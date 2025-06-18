Return-Path: <netdev+bounces-199231-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 9832BADF7DC
	for <lists+netdev@lfdr.de>; Wed, 18 Jun 2025 22:39:58 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 7A4211BC14B9
	for <lists+netdev@lfdr.de>; Wed, 18 Jun 2025 20:40:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D7B7621FF20;
	Wed, 18 Jun 2025 20:39:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="K9ZVO9bN"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B19B721E0B7
	for <netdev@vger.kernel.org>; Wed, 18 Jun 2025 20:39:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750279149; cv=none; b=AOvQM2hrRiG8OSfm/XmymJilLxrQAy6EQQLnw4chhaiE12qwaQAQiyk3K1nscLMKN4Iznb+SjJmkUMOoFrd10qqIxfmIMBL0YQKYDRU9VKT8qV4Bov2LqsOT9J3NiobavVT4BNn+OGBIqOOLAdlTEYuFwZXdVFpJP5uRNpkXS1s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750279149; c=relaxed/simple;
	bh=4dZkVWe4lOdWmUjO1naza1Jqp17H1+dosY5IbUGZrDA=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=hLm8XrCMh/GGWqDsjdukSjF8ziZi8xSCNXEzF+B7SAKN6ylBY+Y5QUKLAoYf6wYvKCbq8KiGeRrN0i6023Q+ZWZpqQ6SalB50QU5FEPDA0Z/xKU9halOzoek80jaVhOnLPJl55mxtxex0rZZr5fguL9GM3BmzJ1PDwizxQbu7ko=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=K9ZVO9bN; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 817C4C4CEED;
	Wed, 18 Jun 2025 20:39:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1750279149;
	bh=4dZkVWe4lOdWmUjO1naza1Jqp17H1+dosY5IbUGZrDA=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=K9ZVO9bNKF0kY8fbc46GO77qRtciyOrscTEjHTyl0qyrCdrjyhvAkdDuUVAVjNTdy
	 K8oqS89pkAGh207gwBB1K4FV/vZPbDtGLlDQChU3SMeqPsujLe4xDKmcLHor5D0lKw
	 v8Btiq4usRNHv5ivCxgPUaqUlbuOXhOJotNTbzI1xQEkpEKnPoWZD+P59ns8kyv25n
	 o7MrNBBMEVOG13dNRkHy/aCQ5/jBIUrOlUtu9nBjJ8Hs3TcawvlS8prKW/SdTSAlFh
	 m45lRGsBhFJhKGXFGRkXsAWcMp3g/CbC2h1i++Znk1vqs11gj2LUVjlPjp3yWAVjh/
	 webC3+HS2eNWA==
From: Jakub Kicinski <kuba@kernel.org>
To: davem@davemloft.net
Cc: netdev@vger.kernel.org,
	edumazet@google.com,
	pabeni@redhat.com,
	andrew+netdev@lunn.ch,
	horms@kernel.org,
	ajit.khaparde@broadcom.com,
	sriharsha.basavapatna@broadcom.com,
	somnath.kotur@broadcom.com,
	shenjian15@huawei.com,
	salil.mehta@huawei.com,
	shaojijie@huawei.com,
	cai.huoqing@linux.dev,
	saeedm@nvidia.com,
	tariqt@nvidia.com,
	louis.peens@corigine.com,
	mbloch@nvidia.com,
	manishc@marvell.com,
	ecree.xilinx@gmail.com,
	joe@dama.to,
	Jakub Kicinski <kuba@kernel.org>
Subject: [PATCH net-next 09/10] eth: hns3: migrate to new RXFH callbacks
Date: Wed, 18 Jun 2025 13:38:22 -0700
Message-ID: <20250618203823.1336156-10-kuba@kernel.org>
X-Mailer: git-send-email 2.49.0
In-Reply-To: <20250618203823.1336156-1-kuba@kernel.org>
References: <20250618203823.1336156-1-kuba@kernel.org>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Migrate to new callbacks added by commit 9bb00786fc61 ("net: ethtool:
add dedicated callbacks for getting and setting rxfh fields").

Signed-off-by: Jakub Kicinski <kuba@kernel.org>
---
This driver wins the award for most convoluted abstraction layers :/
---
 drivers/net/ethernet/hisilicon/hns3/hnae3.h   |  4 +--
 .../hns3/hns3_common/hclge_comm_rss.h         |  4 +--
 .../hns3/hns3_common/hclge_comm_rss.c         |  6 ++--
 .../ethernet/hisilicon/hns3/hns3_ethtool.c    | 33 ++++++++++++++-----
 .../hisilicon/hns3/hns3pf/hclge_main.c        |  4 +--
 .../hisilicon/hns3/hns3vf/hclgevf_main.c      |  4 +--
 6 files changed, 36 insertions(+), 19 deletions(-)

diff --git a/drivers/net/ethernet/hisilicon/hns3/hnae3.h b/drivers/net/ethernet/hisilicon/hns3/hnae3.h
index 4e44f28288f9..8dc7d6fae224 100644
--- a/drivers/net/ethernet/hisilicon/hns3/hnae3.h
+++ b/drivers/net/ethernet/hisilicon/hns3/hnae3.h
@@ -690,9 +690,9 @@ struct hnae3_ae_ops {
 	int (*set_rss)(struct hnae3_handle *handle, const u32 *indir,
 		       const u8 *key, const u8 hfunc);
 	int (*set_rss_tuple)(struct hnae3_handle *handle,
-			     struct ethtool_rxnfc *cmd);
+			     const struct ethtool_rxfh_fields *cmd);
 	int (*get_rss_tuple)(struct hnae3_handle *handle,
-			     struct ethtool_rxnfc *cmd);
+			     struct ethtool_rxfh_fields *cmd);
 
 	int (*get_tc_size)(struct hnae3_handle *handle);
 
diff --git a/drivers/net/ethernet/hisilicon/hns3/hns3_common/hclge_comm_rss.h b/drivers/net/ethernet/hisilicon/hns3/hns3_common/hclge_comm_rss.h
index cdafa63fe38b..cbc02b50c6e7 100644
--- a/drivers/net/ethernet/hisilicon/hns3/hns3_common/hclge_comm_rss.h
+++ b/drivers/net/ethernet/hisilicon/hns3/hns3_common/hclge_comm_rss.h
@@ -108,7 +108,7 @@ void hclge_comm_get_rss_indir_tbl(struct hclge_comm_rss_cfg *rss_cfg,
 int hclge_comm_set_rss_algo_key(struct hclge_comm_hw *hw, const u8 hfunc,
 				const u8 *key);
 int hclge_comm_init_rss_tuple_cmd(struct hclge_comm_rss_cfg *rss_cfg,
-				  struct ethtool_rxnfc *nfc,
+				  const struct ethtool_rxfh_fields *nfc,
 				  struct hnae3_ae_dev *ae_dev,
 				  struct hclge_comm_rss_input_tuple_cmd *req);
 u64 hclge_comm_convert_rss_tuple(u8 tuple_sets);
@@ -129,5 +129,5 @@ int hclge_comm_set_rss_hash_key(struct hclge_comm_rss_cfg *rss_cfg,
 int hclge_comm_set_rss_tuple(struct hnae3_ae_dev *ae_dev,
 			     struct hclge_comm_hw *hw,
 			     struct hclge_comm_rss_cfg *rss_cfg,
-			     struct ethtool_rxnfc *nfc);
+			     const struct ethtool_rxfh_fields *nfc);
 #endif
diff --git a/drivers/net/ethernet/hisilicon/hns3/hns3_common/hclge_comm_rss.c b/drivers/net/ethernet/hisilicon/hns3/hns3_common/hclge_comm_rss.c
index 4e2bb6556b1c..1eca53aaf598 100644
--- a/drivers/net/ethernet/hisilicon/hns3/hns3_common/hclge_comm_rss.c
+++ b/drivers/net/ethernet/hisilicon/hns3/hns3_common/hclge_comm_rss.c
@@ -151,7 +151,7 @@ EXPORT_SYMBOL_GPL(hclge_comm_set_rss_hash_key);
 int hclge_comm_set_rss_tuple(struct hnae3_ae_dev *ae_dev,
 			     struct hclge_comm_hw *hw,
 			     struct hclge_comm_rss_cfg *rss_cfg,
-			     struct ethtool_rxnfc *nfc)
+			     const struct ethtool_rxfh_fields *nfc)
 {
 	struct hclge_comm_rss_input_tuple_cmd *req;
 	struct hclge_desc desc;
@@ -422,7 +422,7 @@ int hclge_comm_set_rss_algo_key(struct hclge_comm_hw *hw, const u8 hfunc,
 }
 EXPORT_SYMBOL_GPL(hclge_comm_set_rss_algo_key);
 
-static u8 hclge_comm_get_rss_hash_bits(struct ethtool_rxnfc *nfc)
+static u8 hclge_comm_get_rss_hash_bits(const struct ethtool_rxfh_fields *nfc)
 {
 	u8 hash_sets = nfc->data & RXH_L4_B_0_1 ? HCLGE_COMM_S_PORT_BIT : 0;
 
@@ -448,7 +448,7 @@ static u8 hclge_comm_get_rss_hash_bits(struct ethtool_rxnfc *nfc)
 }
 
 int hclge_comm_init_rss_tuple_cmd(struct hclge_comm_rss_cfg *rss_cfg,
-				  struct ethtool_rxnfc *nfc,
+				  const struct ethtool_rxfh_fields *nfc,
 				  struct hnae3_ae_dev *ae_dev,
 				  struct hclge_comm_rss_input_tuple_cmd *req)
 {
diff --git a/drivers/net/ethernet/hisilicon/hns3/hns3_ethtool.c b/drivers/net/ethernet/hisilicon/hns3/hns3_ethtool.c
index 6715222aeb66..3513293abda9 100644
--- a/drivers/net/ethernet/hisilicon/hns3/hns3_ethtool.c
+++ b/drivers/net/ethernet/hisilicon/hns3/hns3_ethtool.c
@@ -978,6 +978,16 @@ static int hns3_set_rss(struct net_device *netdev,
 					rxfh->hfunc);
 }
 
+static int hns3_get_rxfh_fields(struct net_device *netdev,
+				struct ethtool_rxfh_fields *cmd)
+{
+	struct hnae3_handle *h = hns3_get_handle(netdev);
+
+	if (h->ae_algo->ops->get_rss_tuple)
+		return h->ae_algo->ops->get_rss_tuple(h, cmd);
+	return -EOPNOTSUPP;
+}
+
 static int hns3_get_rxnfc(struct net_device *netdev,
 			  struct ethtool_rxnfc *cmd,
 			  u32 *rule_locs)
@@ -988,10 +998,6 @@ static int hns3_get_rxnfc(struct net_device *netdev,
 	case ETHTOOL_GRXRINGS:
 		cmd->data = h->kinfo.num_tqps;
 		return 0;
-	case ETHTOOL_GRXFH:
-		if (h->ae_algo->ops->get_rss_tuple)
-			return h->ae_algo->ops->get_rss_tuple(h, cmd);
-		return -EOPNOTSUPP;
 	case ETHTOOL_GRXCLSRLCNT:
 		if (h->ae_algo->ops->get_fd_rule_cnt)
 			return h->ae_algo->ops->get_fd_rule_cnt(h, cmd);
@@ -1275,15 +1281,22 @@ static int hns3_set_ringparam(struct net_device *ndev,
 	return ret;
 }
 
+static int hns3_set_rxfh_fields(struct net_device *netdev,
+				const struct ethtool_rxfh_fields *cmd,
+				struct netlink_ext_ack *extack)
+{
+	struct hnae3_handle *h = hns3_get_handle(netdev);
+
+	if (h->ae_algo->ops->set_rss_tuple)
+		return h->ae_algo->ops->set_rss_tuple(h, cmd);
+	return -EOPNOTSUPP;
+}
+
 static int hns3_set_rxnfc(struct net_device *netdev, struct ethtool_rxnfc *cmd)
 {
 	struct hnae3_handle *h = hns3_get_handle(netdev);
 
 	switch (cmd->cmd) {
-	case ETHTOOL_SRXFH:
-		if (h->ae_algo->ops->set_rss_tuple)
-			return h->ae_algo->ops->set_rss_tuple(h, cmd);
-		return -EOPNOTSUPP;
 	case ETHTOOL_SRXCLSRLINS:
 		if (h->ae_algo->ops->add_fd_entry)
 			return h->ae_algo->ops->add_fd_entry(h, cmd);
@@ -2105,6 +2118,8 @@ static const struct ethtool_ops hns3vf_ethtool_ops = {
 	.get_rxfh_indir_size = hns3_get_rss_indir_size,
 	.get_rxfh = hns3_get_rss,
 	.set_rxfh = hns3_set_rss,
+	.get_rxfh_fields = hns3_get_rxfh_fields,
+	.set_rxfh_fields = hns3_set_rxfh_fields,
 	.get_link_ksettings = hns3_get_link_ksettings,
 	.get_channels = hns3_get_channels,
 	.set_channels = hns3_set_channels,
@@ -2142,6 +2157,8 @@ static const struct ethtool_ops hns3_ethtool_ops = {
 	.get_rxfh_indir_size = hns3_get_rss_indir_size,
 	.get_rxfh = hns3_get_rss,
 	.set_rxfh = hns3_set_rss,
+	.get_rxfh_fields = hns3_get_rxfh_fields,
+	.set_rxfh_fields = hns3_set_rxfh_fields,
 	.get_link_ksettings = hns3_get_link_ksettings,
 	.set_link_ksettings = hns3_set_link_ksettings,
 	.nway_reset = hns3_nway_reset,
diff --git a/drivers/net/ethernet/hisilicon/hns3/hns3pf/hclge_main.c b/drivers/net/ethernet/hisilicon/hns3/hns3pf/hclge_main.c
index a5b480d59fbf..5acefd57df45 100644
--- a/drivers/net/ethernet/hisilicon/hns3/hns3pf/hclge_main.c
+++ b/drivers/net/ethernet/hisilicon/hns3/hns3pf/hclge_main.c
@@ -4872,7 +4872,7 @@ static int hclge_set_rss(struct hnae3_handle *handle, const u32 *indir,
 }
 
 static int hclge_set_rss_tuple(struct hnae3_handle *handle,
-			       struct ethtool_rxnfc *nfc)
+			       const struct ethtool_rxfh_fields *nfc)
 {
 	struct hclge_vport *vport = hclge_get_vport(handle);
 	struct hclge_dev *hdev = vport->back;
@@ -4890,7 +4890,7 @@ static int hclge_set_rss_tuple(struct hnae3_handle *handle,
 }
 
 static int hclge_get_rss_tuple(struct hnae3_handle *handle,
-			       struct ethtool_rxnfc *nfc)
+			       struct ethtool_rxfh_fields *nfc)
 {
 	struct hclge_vport *vport = hclge_get_vport(handle);
 	u8 tuple_sets;
diff --git a/drivers/net/ethernet/hisilicon/hns3/hns3vf/hclgevf_main.c b/drivers/net/ethernet/hisilicon/hns3/hns3vf/hclgevf_main.c
index c4f35e8e2177..f1657f50cdda 100644
--- a/drivers/net/ethernet/hisilicon/hns3/hns3vf/hclgevf_main.c
+++ b/drivers/net/ethernet/hisilicon/hns3/hns3vf/hclgevf_main.c
@@ -606,7 +606,7 @@ static int hclgevf_set_rss(struct hnae3_handle *handle, const u32 *indir,
 }
 
 static int hclgevf_set_rss_tuple(struct hnae3_handle *handle,
-				 struct ethtool_rxnfc *nfc)
+				 const struct ethtool_rxfh_fields *nfc)
 {
 	struct hclgevf_dev *hdev = hclgevf_ae_get_hdev(handle);
 	int ret;
@@ -624,7 +624,7 @@ static int hclgevf_set_rss_tuple(struct hnae3_handle *handle,
 }
 
 static int hclgevf_get_rss_tuple(struct hnae3_handle *handle,
-				 struct ethtool_rxnfc *nfc)
+				 struct ethtool_rxfh_fields *nfc)
 {
 	struct hclgevf_dev *hdev = hclgevf_ae_get_hdev(handle);
 	u8 tuple_sets;
-- 
2.49.0


