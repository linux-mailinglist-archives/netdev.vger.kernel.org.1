Return-Path: <netdev+bounces-54120-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 7B9F8806093
	for <lists+netdev@lfdr.de>; Tue,  5 Dec 2023 22:19:48 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 74DC21C20F56
	for <lists+netdev@lfdr.de>; Tue,  5 Dec 2023 21:19:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E39516E59A;
	Tue,  5 Dec 2023 21:19:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="EPwvLbDC"
X-Original-To: netdev@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.55.52.115])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7BFCAA5
	for <netdev@vger.kernel.org>; Tue,  5 Dec 2023 13:19:42 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1701811182; x=1733347182;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=aVORLXlgNTwpT7j12Gm12L0UNM2kft2BOgle2nzv72E=;
  b=EPwvLbDC4tJSC4cFpPFJPdmB4SwWgrmSeoIBnlNFh0pWUri9OW+XsHjC
   TUbRS3RdUYSFZvY5aOV46aBrEZ0LN1D9o37fE94SU45TlDtlfyD36Na2J
   UAF6lr+O0KolSScaxnH9Iokdy47r0D/863/agXFjxaaP+VURC2/79Okoz
   NbG3QfswD05K/PXkj1QBsCLQWDKzkgia4oBHIqFcR2aT4zeL/lY5CJ/+f
   ixts0w+6dmtWbynHqjr+3+tYpBgg9evJEJnxezIH4Ns2xFcCUkI66yLSZ
   boru1bVfP+/ElKGaAYUlBVesQ85aOHiyvvxVppJfjPXQRhSP0jk8BKdZK
   A==;
X-IronPort-AV: E=McAfee;i="6600,9927,10915"; a="393693796"
X-IronPort-AV: E=Sophos;i="6.04,253,1695711600"; 
   d="scan'208";a="393693796"
Received: from orsmga004.jf.intel.com ([10.7.209.38])
  by fmsmga103.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 05 Dec 2023 13:19:26 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10915"; a="894510098"
X-IronPort-AV: E=Sophos;i="6.04,253,1695711600"; 
   d="scan'208";a="894510098"
Received: from anguy11-upstream.jf.intel.com ([10.166.9.133])
  by orsmga004.jf.intel.com with ESMTP; 05 Dec 2023 13:19:26 -0800
From: Tony Nguyen <anthony.l.nguyen@intel.com>
To: davem@davemloft.net,
	kuba@kernel.org,
	pabeni@redhat.com,
	edumazet@google.com,
	netdev@vger.kernel.org
Cc: Tony Nguyen <anthony.l.nguyen@intel.com>
Subject: [PATCH net 0/4][pull request] Intel Wired LAN Driver Updates 2023-12-05 (ice, i40e, iavf)
Date: Tue,  5 Dec 2023 13:19:11 -0800
Message-ID: <20231205211918.2123019-1-anthony.l.nguyen@intel.com>
X-Mailer: git-send-email 2.41.0
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

This series contains updates to ice, i40e and iavf drivers.

Michal fixes incorrect usage of VF MSIX value and index calculation for
ice.

Marcin restores disabling of Rx VLAN filtering which was inadvertently
removed for ice.

Ivan Vecera corrects improper messaging of MFS port for i40e.

Jake fixes incorrect checking of coalesce values on iavf.

The following are changes since commit 3c91c909f13f0c32b0d54d75c3f798479b1a84f5:
  octeontx2-af: fix a use-after-free in rvu_npa_register_reporters
and are available in the git repository at:
  git://git.kernel.org/pub/scm/linux/kernel/git/tnguy/net-queue 100GbE

Ivan Vecera (1):
  i40e: Fix unexpected MFS warning message

Jacob Keller (1):
  iavf: validate tx_coalesce_usecs even if rx_coalesce_usecs is zero

Marcin Szycik (1):
  ice: Restore fix disabling RX VLAN filtering

Michal Swiatkowski (1):
  ice: change vfs.num_msix_per to vf->num_msix

 drivers/net/ethernet/intel/i40e/i40e_main.c          |  2 +-
 drivers/net/ethernet/intel/iavf/iavf_ethtool.c       | 12 ++----------
 drivers/net/ethernet/intel/iavf/iavf_txrx.h          |  1 -
 drivers/net/ethernet/intel/ice/ice_sriov.c           |  7 +------
 drivers/net/ethernet/intel/ice/ice_vf_vsi_vlan_ops.c | 11 ++++++++---
 drivers/net/ethernet/intel/ice/ice_virtchnl.c        |  5 ++---
 6 files changed, 14 insertions(+), 24 deletions(-)

-- 
2.41.0


