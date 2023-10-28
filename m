Return-Path: <netdev+bounces-44944-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 0982C7DA451
	for <lists+netdev@lfdr.de>; Sat, 28 Oct 2023 02:23:39 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 64DA8282682
	for <lists+netdev@lfdr.de>; Sat, 28 Oct 2023 00:23:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2704A37E;
	Sat, 28 Oct 2023 00:23:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="GswPZBQJ"
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AAA5618D
	for <netdev@vger.kernel.org>; Sat, 28 Oct 2023 00:23:33 +0000 (UTC)
Received: from mgamail.intel.com (mgamail.intel.com [134.134.136.100])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5F521129
	for <netdev@vger.kernel.org>; Fri, 27 Oct 2023 17:23:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1698452612; x=1729988612;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=noMPGbHI8rLyxyefipm4ejVGnLikJGigSzC4PuaRnBY=;
  b=GswPZBQJbQnfvLNRS2fdArV3YvqOomv6HUgAs9Ki+bMWkXspz6/+YdQm
   wLoK1x58B+wemLiJgBH39BFIVPmd7kibRRGgAbo5eNeC/IabfP8P6VEzy
   UCVHIkpDTzlT1ZAmfBFHdN/XVkyIdo2m4g8eOYl0CoZ+Q+P6PYu9iVV1F
   j/uAEzc2+b8TcFIBBX2AYa5J9IXK8PHZqsWtNkQj3NPoEntgZ7pVYrRdX
   dm6VMjgzpHCg8u+yOGG76gJ/E3hhAdMz4j7sEYMLu9u/gXeIJcsxYGXxP
   QWTbOILazB+9RTWD1pe+bjNbvJjljzQawjMOpB5vJj+B/rdApgdZ5O9Tm
   Q==;
X-IronPort-AV: E=McAfee;i="6600,9927,10876"; a="454337181"
X-IronPort-AV: E=Sophos;i="6.03,257,1694761200"; 
   d="scan'208";a="454337181"
Received: from fmviesa002.fm.intel.com ([10.60.135.142])
  by orsmga105.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 27 Oct 2023 17:23:31 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.03,257,1694761200"; 
   d="scan'208";a="997985"
Received: from jekeller-desk.amr.corp.intel.com (HELO jekeller-desk.jekeller.internal) ([10.166.241.1])
  by fmviesa002-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 27 Oct 2023 17:23:19 -0700
From: Jacob Keller <jacob.e.keller@intel.com>
To: netdev@vger.kernel.org,
	David Miller <davem@davemloft.net>,
	Jakub Kicinski <kuba@kernel.org>,
	Jesse Brandeburg <jesse.brandeburg@intel.com>
Cc: Karol Kolacinski <karol.kolacinski@intel.com>,
	Jacob Keller <jacob.e.keller@intel.com>
Subject: [PATCH net-next 0/3] ice: restore timestamp config after reset
Date: Fri, 27 Oct 2023 17:23:19 -0700
Message-ID: <20231028002322.2224777-1-jacob.e.keller@intel.com>
X-Mailer: git-send-email 2.41.0
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

We recently discovered during internal validation that the ice driver has
not been properly restoring Tx timestamp configuration after a device reset,
which resulted in application failures after a device reset.

It turned out this problem is two-fold. Since the introduction of the PTP
support, the driver has been clobbering the user space configuration
settings during reset. Thus after a reset, the driver will not restore
timestamps, and will report timestamps as disabled if SIOCGHWTSTAMP ioctl is
issued.

In addition, the recently merged auxiliary bus support code missed that
PFINT_TSYN_MSK must be reprogrammed on the clock owner for E822 devices.
Failure to restore this register configuration results in the driver no
longer responding to interrupts from other ports. Depending on the traffic
pattern, this can either result in increased latency responding to
timestamps on the non-owner ports, or it can result in the driver never
reporting any timestamps.

This series fixes both issues, as well as removes a redundant Tx ring field
since we can rely on the skb flag as the primary detector for a Tx timestamp
request.

I opted to send this to net-next, because my primary focus was on fixing the
E822 issue which was not introduced until the auxiliary bus which isn't in
the net tree. I do not know if the fix for the overall timestamp
configuration issue is applicable to net, since we have had a lot of
refactor going into the driver to support auxiliary bus as well as in
preparation for new hardware support.

I'd like to see this merged so that the timestamping issues are fixed in
6.6.

Jacob Keller (3):
  ice: remove ptp_tx ring parameter flag
  ice: unify logic for programming PFINT_TSYN_MSK
  ice: restore timestamp configuration after device reset

 drivers/net/ethernet/intel/ice/ice_main.c |  12 +-
 drivers/net/ethernet/intel/ice/ice_ptp.c  | 146 ++++++++++++----------
 drivers/net/ethernet/intel/ice/ice_ptp.h  |   5 +-
 drivers/net/ethernet/intel/ice/ice_txrx.c |   3 -
 drivers/net/ethernet/intel/ice/ice_txrx.h |   1 -
 5 files changed, 84 insertions(+), 83 deletions(-)


base-commit: 3a04927f8d4b7a4f008f04af41e31173002eb1ea
-- 
2.41.0


