Return-Path: <netdev+bounces-32126-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 9178F792D74
	for <lists+netdev@lfdr.de>; Tue,  5 Sep 2023 20:37:01 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id BB8811C20A8C
	for <lists+netdev@lfdr.de>; Tue,  5 Sep 2023 18:37:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 744A2DDCE;
	Tue,  5 Sep 2023 18:36:50 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 64120DDC5
	for <netdev@vger.kernel.org>; Tue,  5 Sep 2023 18:36:50 +0000 (UTC)
Received: from mgamail.intel.com (mgamail.intel.com [134.134.136.100])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8259C83
	for <netdev@vger.kernel.org>; Tue,  5 Sep 2023 11:36:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1693938988; x=1725474988;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=0gWcB4TvPl+6IO95WW2K397nmjiAun3BB4IXEhhj6s0=;
  b=m0QP2V09mrLYX1VeNRACSNUMDRUBgGnUYFovFw03v/zkVh4be1r5ybgC
   PUn0f1NMeG/BPtUhNelUqZ2IlpzE+UJDru5iuX5lgiPQdYcByQNLOSGfH
   NuK0acjaB9oyufOXmZNDqBPyGOBQI9XW3/i/QLfFyzIpdQVBf4Di8rfYc
   tyRTGAGQ5S2M9EOxEkOK5im/BztqMWpfeilrR2EQgpyoRu57jD+CDxFWs
   u4Vf5bnsnhWn5W9QO1SC1j3/1L0ZThOA37dqm1rVb4f4+1D0ZP5BwpVk3
   F6Gd5zTB0vG1fGvSKUrsjB3eyasTX3m5yg2SK6xOo7JHAIJy7TpBZZj8g
   A==;
X-IronPort-AV: E=McAfee;i="6600,9927,10824"; a="443260807"
X-IronPort-AV: E=Sophos;i="6.02,229,1688454000"; 
   d="scan'208";a="443260807"
Received: from fmsmga001.fm.intel.com ([10.253.24.23])
  by orsmga105.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 05 Sep 2023 11:12:56 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10824"; a="884401498"
X-IronPort-AV: E=Sophos;i="6.02,229,1688454000"; 
   d="scan'208";a="884401498"
Received: from anguy11-upstream.jf.intel.com ([10.166.9.133])
  by fmsmga001.fm.intel.com with ESMTP; 05 Sep 2023 11:12:47 -0700
From: Tony Nguyen <anthony.l.nguyen@intel.com>
To: davem@davemloft.net,
	kuba@kernel.org,
	pabeni@redhat.com,
	edumazet@google.com,
	netdev@vger.kernel.org
Cc: Tony Nguyen <anthony.l.nguyen@intel.com>
Subject: [PATCH net 0/2][pull request] Intel Wired LAN Driver Updates 2023-09-05 (i40e, iavf)
Date: Tue,  5 Sep 2023 11:05:19 -0700
Message-Id: <20230905180521.887861-1-anthony.l.nguyen@intel.com>
X-Mailer: git-send-email 2.38.1
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
	RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_NONE autolearn=ham
	autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

This series contains updates to i40e and iavf drivers.

Andrii ensures all VSIs are cleaned up for remove in i40e.

Brett reworks logic for setting promiscuous mode that can, currently, cause
incorrect states on iavf.

The following are changes since commit 29fe7a1b62717d58f033009874554d99d71f7d37:
  octeontx2-af: Fix truncation of smq in CN10K NIX AQ enqueue mbox handler
and are available in the git repository at:
  git://git.kernel.org/pub/scm/linux/kernel/git/tnguy/net-queue 40GbE

Andrii Staikov (1):
  i40e: fix potential memory leaks in i40e_remove()

Brett Creeley (1):
  iavf: Fix promiscuous mode configuration flow messages

 drivers/net/ethernet/intel/i40e/i40e_main.c   | 10 ++-
 drivers/net/ethernet/intel/iavf/iavf.h        | 16 ++--
 drivers/net/ethernet/intel/iavf/iavf_main.c   | 43 +++++------
 .../net/ethernet/intel/iavf/iavf_virtchnl.c   | 75 ++++++++++++-------
 4 files changed, 82 insertions(+), 62 deletions(-)

-- 
2.38.1


