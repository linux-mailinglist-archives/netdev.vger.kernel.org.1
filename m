Return-Path: <netdev+bounces-15712-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 580427494C0
	for <lists+netdev@lfdr.de>; Thu,  6 Jul 2023 06:44:44 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 7DF171C20CD3
	for <lists+netdev@lfdr.de>; Thu,  6 Jul 2023 04:44:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5DA34EC2;
	Thu,  6 Jul 2023 04:44:41 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4F52EA47
	for <netdev@vger.kernel.org>; Thu,  6 Jul 2023 04:44:40 +0000 (UTC)
Received: from mga01.intel.com (mga01.intel.com [192.55.52.88])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F0631172B
	for <netdev@vger.kernel.org>; Wed,  5 Jul 2023 21:44:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1688618679; x=1720154679;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=i9WQHef9kqRhh4UQbpWXW4F2xGqcNiPqfVW0EHpDWkY=;
  b=i2pA2Kn8TQyMDvCuzBITCybDu84BZ3Ys0C7+QL/Ek0nIZg2n1LzLs9iJ
   H+7A3tu8wLxLAISAfa9qm0OP9Skx8c+ru4rP/0pmoHiRMhmxZe7rpMZOx
   94qJw0cZp/CSc9WlOOLZqXVYPH6ir25eN75zDB/vxXaEapWfqlchM7HwK
   htVBKtH6ejEz1Gcb96IU4JWMKVr3moJrslRRFSoNpd1jLsD9SGZtx/uKS
   oWgPE8UjlDsjEkcB+YbDz3yqWrRKqfWw+TJZNo6GjOIl84970Vkyd0fzH
   8WjzyFR9NNDhuRzgGrDQm1Kw17+ib2a5wztHIJxtfnl3NFVtaCIuQZGJ/
   g==;
X-IronPort-AV: E=McAfee;i="6600,9927,10762"; a="394259405"
X-IronPort-AV: E=Sophos;i="6.01,184,1684825200"; 
   d="scan'208";a="394259405"
Received: from orsmga001.jf.intel.com ([10.7.209.18])
  by fmsmga101.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 05 Jul 2023 21:44:39 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10762"; a="754614502"
X-IronPort-AV: E=Sophos;i="6.01,184,1684825200"; 
   d="scan'208";a="754614502"
Received: from dpdk-jf-ntb-v2.sh.intel.com ([10.67.119.19])
  by orsmga001.jf.intel.com with ESMTP; 05 Jul 2023 21:44:37 -0700
From: Junfeng Guo <junfeng.guo@intel.com>
To: netdev@vger.kernel.org
Cc: jeroendb@google.com,
	pkaligineedi@google.com,
	shailend@google.com,
	haiyue.wang@intel.com,
	Junfeng Guo <junfeng.guo@intel.com>
Subject: [PATCH net] gve: Set default duplex configuration to full
Date: Thu,  6 Jul 2023 12:41:28 +0800
Message-Id: <20230706044128.2726747-1-junfeng.guo@intel.com>
X-Mailer: git-send-email 2.25.1
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
	RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE,
	T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

Current duplex mode was unset in the driver, resulting in the default
parameter being set to 0, which corresponds to half duplex. It might
mislead users to have incorrect expectation about the driver's
transmission capabilities.
Set the default duplex configuration to full, as the driver runs in
full duplex mode at this point.

Fixes: 7e074d5a76ca ("gve: Enable Link Speed Reporting in the driver.")
Signed-off-by: Junfeng Guo <junfeng.guo@intel.com>
---
 drivers/net/ethernet/google/gve/gve_ethtool.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/drivers/net/ethernet/google/gve/gve_ethtool.c b/drivers/net/ethernet/google/gve/gve_ethtool.c
index cfd4b8d284d1..50162ec9424d 100644
--- a/drivers/net/ethernet/google/gve/gve_ethtool.c
+++ b/drivers/net/ethernet/google/gve/gve_ethtool.c
@@ -590,6 +590,9 @@ static int gve_get_link_ksettings(struct net_device *netdev,
 		err = gve_adminq_report_link_speed(priv);
 
 	cmd->base.speed = priv->link_speed;
+
+	cmd->base.duplex = DUPLEX_FULL;
+
 	return err;
 }
 
-- 
2.25.1


