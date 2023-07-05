Return-Path: <netdev+bounces-15649-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 088B5748EE0
	for <lists+netdev@lfdr.de>; Wed,  5 Jul 2023 22:25:44 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id B68922810F6
	for <lists+netdev@lfdr.de>; Wed,  5 Jul 2023 20:25:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 703A715AD4;
	Wed,  5 Jul 2023 20:24:47 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6645615AC7
	for <netdev@vger.kernel.org>; Wed,  5 Jul 2023 20:24:47 +0000 (UTC)
Received: from mga04.intel.com (mga04.intel.com [192.55.52.120])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 64B8D1988
	for <netdev@vger.kernel.org>; Wed,  5 Jul 2023 13:24:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1688588686; x=1720124686;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=6mDwatLWXN+WdvnIWpbXL4rUFD99PGrI4Na6sDPtGsY=;
  b=WXRtRI7QXBFlebMDimriaDfltA+xl+q0TcUo07z+IuaYKDU0FjncDJMX
   2p2aDrwJ36Z/jNj/5NLPveK9Aln1CvWiz3S9YHpSrTQF0Op2INMEWRwPU
   bpbsLuabJShXVE59stQGTHyztYTNYo6m6uVVucS80M7fzcwSg9UdpjLwr
   c1oyPuyI6YQ36j7BFFJV94P9tDrmeZ0FFoS92ZeLFinXSYqH1C8AS5bBq
   0hDsiOZiZSMD6dbbMKzA9RqV0HMJ78ivJu6soC7Z4gx0C+iGgrZeAW9Jf
   sImj94HJMw1j9nov8rpYuGhIL1EUD2HlmFM1AEG/vANgABYdmkt5rZmxA
   g==;
X-IronPort-AV: E=McAfee;i="6600,9927,10762"; a="362303237"
X-IronPort-AV: E=Sophos;i="6.01,184,1684825200"; 
   d="scan'208";a="362303237"
Received: from fmsmga003.fm.intel.com ([10.253.24.29])
  by fmsmga104.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 05 Jul 2023 13:24:41 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10762"; a="809380439"
X-IronPort-AV: E=Sophos;i="6.01,184,1684825200"; 
   d="scan'208";a="809380439"
Received: from anguy11-upstream.jf.intel.com ([10.166.9.133])
  by FMSMGA003.fm.intel.com with ESMTP; 05 Jul 2023 13:24:40 -0700
From: Tony Nguyen <anthony.l.nguyen@intel.com>
To: davem@davemloft.net,
	kuba@kernel.org,
	pabeni@redhat.com,
	edumazet@google.com,
	netdev@vger.kernel.org
Cc: Prasad Koya <prasad@arista.com>,
	anthony.l.nguyen@intel.com,
	sasha.neftin@intel.com,
	Naama Meir <naamax.meir@linux.intel.com>
Subject: [PATCH net 4/6] igc: set TP bit in 'supported' and 'advertising' fields of ethtool_link_ksettings
Date: Wed,  5 Jul 2023 13:19:03 -0700
Message-Id: <20230705201905.49570-5-anthony.l.nguyen@intel.com>
X-Mailer: git-send-email 2.38.1
In-Reply-To: <20230705201905.49570-1-anthony.l.nguyen@intel.com>
References: <20230705201905.49570-1-anthony.l.nguyen@intel.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
	SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

From: Prasad Koya <prasad@arista.com>

set TP bit in the 'supported' and 'advertising' fields. i225/226 parts
only support twisted pair copper.

Fixes: 8c5ad0dae93c ("igc: Add ethtool support")
Signed-off-by: Prasad Koya <prasad@arista.com>
Acked-by: Sasha Neftin <sasha.neftin@intel.com>
Tested-by: Naama Meir <naamax.meir@linux.intel.com>
Signed-off-by: Tony Nguyen <anthony.l.nguyen@intel.com>
---
 drivers/net/ethernet/intel/igc/igc_ethtool.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/drivers/net/ethernet/intel/igc/igc_ethtool.c b/drivers/net/ethernet/intel/igc/igc_ethtool.c
index 0e2cb00622d1..93bce729be76 100644
--- a/drivers/net/ethernet/intel/igc/igc_ethtool.c
+++ b/drivers/net/ethernet/intel/igc/igc_ethtool.c
@@ -1708,6 +1708,8 @@ static int igc_ethtool_get_link_ksettings(struct net_device *netdev,
 	/* twisted pair */
 	cmd->base.port = PORT_TP;
 	cmd->base.phy_address = hw->phy.addr;
+	ethtool_link_ksettings_add_link_mode(cmd, supported, TP);
+	ethtool_link_ksettings_add_link_mode(cmd, advertising, TP);
 
 	/* advertising link modes */
 	if (hw->phy.autoneg_advertised & ADVERTISE_10_HALF)
-- 
2.38.1


