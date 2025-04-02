Return-Path: <netdev+bounces-178780-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C7B4CA78E01
	for <lists+netdev@lfdr.de>; Wed,  2 Apr 2025 14:16:46 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id E46C73A7163
	for <lists+netdev@lfdr.de>; Wed,  2 Apr 2025 12:16:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A5060239565;
	Wed,  2 Apr 2025 12:16:29 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from szxga03-in.huawei.com (szxga03-in.huawei.com [45.249.212.189])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C80D1238D51;
	Wed,  2 Apr 2025 12:16:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.189
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1743596189; cv=none; b=Gcfl1lxSmanHsBmBAiQnI4Ogu8IcJB60xMXCUm95TVcmtQ2bLfn8ARPLGosGC07fDTxTGM2qcuuLM9LuGZo99rsVmgqK+HllZiiXO9ca3qkPrBz49kc4u27vnPdpT4x7Oyrtuw0gde0aowhPT6jtpMQf4j/vnTpKkPfraB26Cwo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1743596189; c=relaxed/simple;
	bh=F+xl4m5xuogM7OdpnHQiRtW6G9/kjWT0aJggDEFrzF8=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=ET7gsd49qalR9HdlMZWbbW1jcsNTaX+BbBtHw+o183rakk1a/Wt4pHEcdR/uO2u4nIjRIPWtT5n5WJc8Od72ePWcIrMswp/WdBhnOCBK4jnMF8Rux44gkFbi1Aq4QVzffp7M0EqBR7ZNOsmOwfUJtf9qj2Qk9jCmnjfOjNkpPWo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=huawei.com; arc=none smtp.client-ip=45.249.212.189
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Received: from mail.maildlp.com (unknown [172.19.163.252])
	by szxga03-in.huawei.com (SkyGuard) with ESMTP id 4ZSNzv0C6WzHrF7;
	Wed,  2 Apr 2025 20:12:59 +0800 (CST)
Received: from kwepemk100013.china.huawei.com (unknown [7.202.194.61])
	by mail.maildlp.com (Postfix) with ESMTPS id 63E7C1800E5;
	Wed,  2 Apr 2025 20:16:19 +0800 (CST)
Received: from localhost.localdomain (10.90.30.45) by
 kwepemk100013.china.huawei.com (7.202.194.61) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.11; Wed, 2 Apr 2025 20:16:18 +0800
From: Jijie Shao <shaojijie@huawei.com>
To: <davem@davemloft.net>, <edumazet@google.com>, <kuba@kernel.org>,
	<pabeni@redhat.com>, <andrew+netdev@lunn.ch>, <horms@kernel.org>
CC: <shenjian15@huawei.com>, <wangpeiyang1@huawei.com>,
	<liuyonglong@huawei.com>, <chenhao418@huawei.com>,
	<jonathan.cameron@huawei.com>, <shameerali.kolothum.thodi@huawei.com>,
	<salil.mehta@huawei.com>, <netdev@vger.kernel.org>,
	<linux-kernel@vger.kernel.org>, <shaojijie@huawei.com>
Subject: [PATCH net 1/3] net: hns3: fix a use of uninitialized variable problem
Date: Wed, 2 Apr 2025 20:09:59 +0800
Message-ID: <20250402121001.663431-2-shaojijie@huawei.com>
X-Mailer: git-send-email 2.30.0
In-Reply-To: <20250402121001.663431-1-shaojijie@huawei.com>
References: <20250402121001.663431-1-shaojijie@huawei.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: dggems702-chm.china.huawei.com (10.3.19.179) To
 kwepemk100013.china.huawei.com (7.202.194.61)

From: Yonglong Liu <liuyonglong@huawei.com>

In hclge_add_fd_entry(), if the flow type is FLOW_EXT, and the data of
m_ext is all zero, then some members of the local variable "info" are
not initialized.

Fixes: 67b0e1428e2f ("net: hns3: add support for user-def data of flow director")
Signed-off-by: Yonglong Liu <liuyonglong@huawei.com>
Signed-off-by: Jijie Shao <shaojijie@huawei.com>
---
 drivers/net/ethernet/hisilicon/hns3/hns3pf/hclge_main.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/net/ethernet/hisilicon/hns3/hns3pf/hclge_main.c b/drivers/net/ethernet/hisilicon/hns3/hns3pf/hclge_main.c
index 92f9b8ec76d9..f61355b03e14 100644
--- a/drivers/net/ethernet/hisilicon/hns3/hns3pf/hclge_main.c
+++ b/drivers/net/ethernet/hisilicon/hns3/hns3pf/hclge_main.c
@@ -6545,8 +6545,8 @@ static int hclge_add_fd_entry(struct hnae3_handle *handle,
 			      struct ethtool_rxnfc *cmd)
 {
 	struct hclge_vport *vport = hclge_get_vport(handle);
+	struct hclge_fd_user_def_info info = {0};
 	struct hclge_dev *hdev = vport->back;
-	struct hclge_fd_user_def_info info;
 	u16 dst_vport_id = 0, q_index = 0;
 	struct ethtool_rx_flow_spec *fs;
 	struct hclge_fd_rule *rule;
-- 
2.33.0


