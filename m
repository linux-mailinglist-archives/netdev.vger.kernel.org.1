Return-Path: <netdev+bounces-34136-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 52AF27A2465
	for <lists+netdev@lfdr.de>; Fri, 15 Sep 2023 19:14:13 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 56B5C1C2095A
	for <lists+netdev@lfdr.de>; Fri, 15 Sep 2023 17:14:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9427F15E8C;
	Fri, 15 Sep 2023 17:14:09 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AD70530CF7
	for <netdev@vger.kernel.org>; Fri, 15 Sep 2023 17:14:07 +0000 (UTC)
Received: from mgamail.intel.com (mgamail.intel.com [134.134.136.65])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 89C0383
	for <netdev@vger.kernel.org>; Fri, 15 Sep 2023 10:14:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1694798046; x=1726334046;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=W8Bi5ZnMHPWMaBoH1p0jcyxLnjJcNf4t3H/truFXu9A=;
  b=h5kiJCrwK5AgkCp4xZAFp19se2K3KXVH/0tCHbc3bZFc+StcbAxgQZo5
   jpHrSd0iKrCK3Lzyi9e9mDBzejxZGiQGQCBK/EKavW1plWobPIOUcSmTK
   iCz5eGAUaIiDPybRDfMAHdfO4tT8pIpZNkeYwbAV5Gd/gNWPWygVCcklP
   tP4Gm+OVzZlpJflthbB/z/hkF1mM4+ZErqoTTdDNtNSka7Son5trNUpcQ
   ZsVAXpTjN4F4yhcm/QuVGH6gTlMsP8OS3CPXg70LAdi5I10kewU/KrvaJ
   Cinw35/JtuLOtJcjVIIBQIbgNk7wtE3WtiALaeaw8ZN2SfNOBGiLsGBg4
   A==;
X-IronPort-AV: E=McAfee;i="6600,9927,10834"; a="383132309"
X-IronPort-AV: E=Sophos;i="6.02,149,1688454000"; 
   d="scan'208";a="383132309"
Received: from fmsmga002.fm.intel.com ([10.253.24.26])
  by orsmga103.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 15 Sep 2023 10:12:01 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10834"; a="860244180"
X-IronPort-AV: E=Sophos;i="6.02,149,1688454000"; 
   d="scan'208";a="860244180"
Received: from anguy11-upstream.jf.intel.com ([10.166.9.133])
  by fmsmga002.fm.intel.com with ESMTP; 15 Sep 2023 10:12:01 -0700
From: Tony Nguyen <anthony.l.nguyen@intel.com>
To: davem@davemloft.net,
	kuba@kernel.org,
	pabeni@redhat.com,
	edumazet@google.com,
	netdev@vger.kernel.org
Cc: Tony Nguyen <anthony.l.nguyen@intel.com>
Subject: [PATCH net 0/4][pull request] Intel Wired LAN Driver Updates 2023-09-15 (iavf, i40e)
Date: Fri, 15 Sep 2023 10:11:35 -0700
Message-Id: <20230915171139.3822904-1-anthony.l.nguyen@intel.com>
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

This series contains updates to iavf and i40e drivers.

Radoslaw prevents admin queue operations being added when the driver is
being removed for iavf.

Petr Oros immediately starts reconfiguration on changes to VLANs on
iavf.

Ivan Vecera moves reset of VF to occur after port VLAN values are set
on i40e.

The following are changes since commit 615efed8b63f60ddd69c0b8f32f7783859034fc2:
  Merge tag 'nf-23-09-13' of git://git.kernel.org/pub/scm/linux/kernel/git/netfilter/nf
and are available in the git repository at:
  git://git.kernel.org/pub/scm/linux/kernel/git/tnguy/net-queue 40GbE

Ivan Vecera (1):
  i40e: Fix VF VLAN offloading when port VLAN is configured

Petr Oros (2):
  iavf: add iavf_schedule_aq_request() helper
  iavf: schedule a request immediately after add/delete vlan

Radoslaw Tyl (1):
  iavf: do not process adminq tasks when __IAVF_IN_REMOVE_TASK is set

 .../net/ethernet/intel/i40e/i40e_virtchnl_pf.c  |  8 +++++---
 drivers/net/ethernet/intel/iavf/iavf.h          |  2 +-
 drivers/net/ethernet/intel/iavf/iavf_ethtool.c  |  2 +-
 drivers/net/ethernet/intel/iavf/iavf_main.c     | 17 ++++++++---------
 4 files changed, 15 insertions(+), 14 deletions(-)

-- 
2.38.1


