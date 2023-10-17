Return-Path: <netdev+bounces-42024-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 95A5F7CCBA2
	for <lists+netdev@lfdr.de>; Tue, 17 Oct 2023 21:04:34 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 50A57281A4B
	for <lists+netdev@lfdr.de>; Tue, 17 Oct 2023 19:04:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4FE3F2DF6B;
	Tue, 17 Oct 2023 19:04:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="C5hPXyyL"
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5D416EBE
	for <netdev@vger.kernel.org>; Tue, 17 Oct 2023 19:04:29 +0000 (UTC)
Received: from mgamail.intel.com (mgamail.intel.com [192.55.52.120])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AC2A9F5
	for <netdev@vger.kernel.org>; Tue, 17 Oct 2023 12:04:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1697569467; x=1729105467;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=idg+qFAPZNp2s2IRq8rhfOlbO6zqI11Y4kIe+Ep/uiE=;
  b=C5hPXyyLmsRAv0xWvkiHxFUerZvl41FG5z5re4QLgfiKoHUJjlSPu7ly
   KcE5eVl6c6uGZjerH/p7NiIU/n93lL6c4gODv5MPfso8AfHfUAnNl2zgC
   jnTYY2ZpLvB6cOGWrvTF7tMk+Wi+WoiZ5LyDox2ZpaTIIIbJ6pxe17Bxr
   L+TOFXcE/R1t6+PF5W4m14wIFyE+RjGYLi7WZTHyUfunhErw3RDlJ8w49
   iEVnhB5X0m1EEmwow2Eb2nGF3wxxSMnMqZ0/Sh4Whz5a5kkCZU0Z86Ulw
   QutUvaOVehk3mrM5SuJHRnxxvq6weViXHLQYfWeM/WONt47gehtKEfsOr
   g==;
X-IronPort-AV: E=McAfee;i="6600,9927,10866"; a="384739678"
X-IronPort-AV: E=Sophos;i="6.03,233,1694761200"; 
   d="scan'208";a="384739678"
Received: from fmsmga008.fm.intel.com ([10.253.24.58])
  by fmsmga104.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 17 Oct 2023 12:04:18 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10866"; a="822108670"
X-IronPort-AV: E=Sophos;i="6.03,233,1694761200"; 
   d="scan'208";a="822108670"
Received: from jekeller-desk.amr.corp.intel.com (HELO jekeller-desk.jekeller.internal) ([10.166.241.1])
  by fmsmga008-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 17 Oct 2023 12:04:17 -0700
From: Jacob Keller <jacob.e.keller@intel.com>
To: netdev@vger.kernel.org,
	David Miller <davem@davemloft.net>,
	Jakub Kicinski <kuba@kernel.org>
Cc: Jacob Keller <jacob.e.keller@intel.com>
Subject: [PATCH net-next 0/9] Intel Wired LAN Driver Updates 2023-10-17
Date: Tue, 17 Oct 2023 12:04:02 -0700
Message-ID: <20231017190411.2199743-1-jacob.e.keller@intel.com>
X-Mailer: git-send-email 2.41.0
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
	SPF_HELO_NONE,SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

This series contains cleanups for all the Intel drivers relating to their
use of format specifiers and the use of strncpy.

Jesse fixes various -Wformat warnings across all the Intel networking,
including various cases where a "%s" string format specifier is preferred,
and using kasprintf instead of snprintf.

Justin replaces all of the uses of the now deprecated strncpy with a more
modern string function, primarily strscpy.

Jesse Brandeburg (2):
  intel: fix string truncation warnings
  intel: fix format warnings

Justin Stitt (7):
  e100: replace deprecated strncpy with strscpy
  e1000: replace deprecated strncpy with strscpy
  fm10k: replace deprecated strncpy with strscpy
  i40e: use scnprintf over strncpy+strncat
  igb: replace deprecated strncpy with strscpy
  igbvf: replace deprecated strncpy with strscpy
  igc: replace deprecated strncpy with strscpy

 drivers/net/ethernet/intel/e100.c             |  2 +-
 drivers/net/ethernet/intel/e1000/e1000_main.c |  2 +-
 .../net/ethernet/intel/fm10k/fm10k_ethtool.c  |  8 ++--
 drivers/net/ethernet/intel/i40e/i40e_ddp.c    |  7 ++--
 .../net/ethernet/intel/i40e/i40e_ethtool.c    |  6 ++-
 .../net/ethernet/intel/iavf/iavf_ethtool.c    |  8 ++--
 .../net/ethernet/intel/iavf/iavf_virtchnl.c   | 22 ++++-------
 drivers/net/ethernet/intel/ice/ice_ethtool.c  |  7 ++--
 drivers/net/ethernet/intel/ice/ice_ptp.c      |  4 +-
 drivers/net/ethernet/intel/igb/igb_ethtool.c  |  4 +-
 drivers/net/ethernet/intel/igb/igb_main.c     | 39 +++++++++----------
 drivers/net/ethernet/intel/igbvf/netdev.c     |  2 +-
 drivers/net/ethernet/intel/igc/igc_ethtool.c  |  5 ++-
 drivers/net/ethernet/intel/igc/igc_main.c     |  2 +-
 .../net/ethernet/intel/ixgbe/ixgbe_ethtool.c  |  4 +-
 15 files changed, 58 insertions(+), 64 deletions(-)

-- 
2.41.0


