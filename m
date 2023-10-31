Return-Path: <netdev+bounces-45486-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A377E7DD83F
	for <lists+netdev@lfdr.de>; Tue, 31 Oct 2023 23:27:38 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 312602812C1
	for <lists+netdev@lfdr.de>; Tue, 31 Oct 2023 22:27:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EC1F727445;
	Tue, 31 Oct 2023 22:27:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="PtpWeLTF"
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5D4024417
	for <netdev@vger.kernel.org>; Tue, 31 Oct 2023 22:27:33 +0000 (UTC)
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.8])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 83C61101
	for <netdev@vger.kernel.org>; Tue, 31 Oct 2023 15:27:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1698791251; x=1730327251;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=56b5MfCFIFAlLzHYVZ+0IIbcoP+h5LznhRfG4s6vWUs=;
  b=PtpWeLTF2WsK8dsg/Qcdq1r4dC26x+HZJSSLhI23GlyvYRpYnQfV2Cdc
   Hm/wKFpd0z7ehCQXafqbezyQImfLyE+h/LQl3hyLfkhIbzf0ntGB+icC6
   mM6KCAEwL7gtgabGmpI0WSfjvir9KIdCliPYfh0jEdD7jy2aq+bsQ7sr+
   cUGi+IfKInpFisw1ljXWUTKtjkRWI13Z8LQFxZLvOUiCJXRNP3OFNovgl
   VLKDfc8XutTFkMVi2asjW4WHYmgoIUKoP7DIstOfrsEQHkX6pp4fXUeib
   ENrZSxY/032j7SaYVfZq1GuKern49k5AVo/z9SSVhUpkKRDkdz0GBDQa/
   g==;
X-IronPort-AV: E=McAfee;i="6600,9927,10880"; a="1236091"
X-IronPort-AV: E=Sophos;i="6.03,266,1694761200"; 
   d="scan'208";a="1236091"
Received: from fmviesa002.fm.intel.com ([10.60.135.142])
  by fmvoesa102.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 31 Oct 2023 15:27:31 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.03,266,1694761200"; 
   d="scan'208";a="1988797"
Received: from jekeller-desk.amr.corp.intel.com (HELO jekeller-desk.jekeller.internal) ([10.166.241.1])
  by fmviesa002-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 31 Oct 2023 15:27:31 -0700
From: Jacob Keller <jacob.e.keller@intel.com>
To: netdev@vger.kernel.org,
	David Miller <davem@davemloft.net>,
	Jakub Kicinski <kuba@kernel.org>,
	Jesse Brandeburg <jesse.brandeburg@intel.com>
Cc: Karol Kolacinski <karol.kolacinski@intel.com>,
	Anthony Nguyen <anthony.l.nguyen@intel.com>,
	Jacob Keller <jacob.e.keller@intel.com>
Subject: [PATCH net v2 0/3] ice: restore timestamp config after reset
Date: Tue, 31 Oct 2023 15:27:22 -0700
Message-ID: <20231031222725.2819172-1-jacob.e.keller@intel.com>
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

After some digging, it turned out this problem is two-fold. Since the
introduction of the PTP support the driver has been clobbering the storage
of the current timestamp configuration during reset. Thus after a reset, the
driver will no longer perform Tx or Rx timestamps, and will report
timestamp configuration as disabled if SIOCGHWTSTAMP ioctl is issued.

In addition, the recently merged auxiliary bus support code missed that
PFINT_TSYN_MSK must be reprogrammed on the clock owner for E822 devices.
Failure to restore this register configuration results in the driver no
longer responding to interrupts from other ports. Depending on the traffic
pattern, this can either result in increased latency responding to
timestamps on the non-owner ports, or it can result in the driver never
reporting any timestamps. The configuration of PFINT_TSYN_MSK was only done
during initialization. Due to this, the Tx timestamp issue persists even if
userspace reconfigures timestamping.

This series fixes both issues, as well as removes a redundant Tx ring field
since we can rely on the skb flag as the primary detector for a Tx timestamp
request.

Note that I don't think this series will directly apply to older stable
releases (even v6.6) as we recently refactored a lot of the PTP code to
support auxiliary bus. Patch 2/3 only matters for the post-auxiliary bus
implementation. The principle of patch 1/3 and 3/3 could apply as far back
as the initial PTP support, but I don't think it will apply cleanly as-is.

Changes since v1
* Update target to net and rebase onto current net tree.
* Add appropriate fixes tag to 1/3.
* Slightly update the cover message.
* picked up Jesse's Reviewed-by tag.

V1 was posted here:
https://lore.kernel.org/netdev/20231028002322.2224777-1-jacob.e.keller@intel.com/

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


base-commit: 55c900477f5b3897d9038446f72a281cae0efd86
-- 
2.41.0


