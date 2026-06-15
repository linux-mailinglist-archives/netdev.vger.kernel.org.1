Return-Path: <netdev+bounces-299334-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id bJZKIgmdL2oxDQUAu9opvQ
	(envelope-from <netdev+bounces-299334-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Mon, 15 Jun 2026 08:34:49 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id BCD31683DCA
	for <lists+netdev@lfdr.de>; Mon, 15 Jun 2026 08:34:47 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=huawei.com header.s=dkim header.b=XoiyYgC0;
	spf=pass (mail.lfdr.de: domain of "netdev+bounces-299334-lists+netdev=lfdr.de@vger.kernel.org" designates 172.105.105.114 as permitted sender) smtp.mailfrom="netdev+bounces-299334-lists+netdev=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=quarantine) header.from=huawei.com;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id C5AF7300353E
	for <lists+netdev@lfdr.de>; Mon, 15 Jun 2026 06:34:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 181F13603D9;
	Mon, 15 Jun 2026 06:34:46 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from canpmsgout12.his.huawei.com (canpmsgout12.his.huawei.com [113.46.200.227])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4AEB830D401;
	Mon, 15 Jun 2026 06:34:41 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781505286; cv=none; b=MNuDcevcMxTWXnH8f/o+KCqgkfeczZyRG4VmGvG2EyaI/HMTphY5dTEAIz6aeSkeylZmYCZHyvBjOCmHfUHqRaQdaPLsJGAvm+RDC4e6SMVciOtTzMsT94ik6syp0jo540duVCbT+z5IoXlvqwocDgZb08aF3JgTigIJT0CYd4Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781505286; c=relaxed/simple;
	bh=AV8dvQZNFwnKZaiKAKKFvjjzr7MLeYAD9+dp/reoKXE=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=S78rJNIN7nqLVD4EPQUqyoHnGHQhxAv7s+PajyTpeLUTBhWOzWL5mf+gOouLbwJYpxPLXlTtjcBon/YiF8vVqruNOkvcb9vrnf76AVrkxKEuY6bgoIQX40aAA+8A8afXuLidmgNN8SOorhP7LF4X1NZjkMn3FyoV/si0f13orRo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=huawei.com; dkim=pass (1024-bit key) header.d=huawei.com header.i=@huawei.com header.b=XoiyYgC0; arc=none smtp.client-ip=113.46.200.227
dkim-signature: v=1; a=rsa-sha256; d=huawei.com; s=dkim;
	c=relaxed/relaxed; q=dns/txt;
	h=From;
	bh=+pb9VIe3Rk09xxycZT2pzzjsEXJIhXty7m6OO8fHpl4=;
	b=XoiyYgC0rNN9DwZ+zNJnRpu4OKSmHWBxdJm2LeWHA0meqlJpnB+c/cig9kGp/m36q14fFweMK
	5VbrZ+fk2oR7XM86uEK9zfVZut6b2IKo00ggEhlyEIsfO1f4QFblaMpEQAKZfMA1dXrjOWFjE4a
	kHKPxXz2E74zqjZHCLF8g6I=
Received: from mail.maildlp.com (unknown [172.19.163.127])
	by canpmsgout12.his.huawei.com (SkyGuard) with ESMTPS id 4gf0Vh3vNQznTwh;
	Mon, 15 Jun 2026 14:25:48 +0800 (CST)
Received: from kwepemk100013.china.huawei.com (unknown [7.202.194.61])
	by mail.maildlp.com (Postfix) with ESMTPS id 8F1A9402AB;
	Mon, 15 Jun 2026 14:34:37 +0800 (CST)
Received: from localhost.huawei.com (10.90.31.46) by
 kwepemk100013.china.huawei.com (7.202.194.61) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.36; Mon, 15 Jun 2026 14:34:36 +0800
From: Jijie Shao <shaojijie@huawei.com>
To: <davem@davemloft.net>, <edumazet@google.com>, <kuba@kernel.org>,
	<pabeni@redhat.com>, <andrew+netdev@lunn.ch>, <horms@kernel.org>
CC: <shenjian15@huawei.com>, <liuyonglong@huawei.com>,
	<chenhao418@huawei.com>, <huangdonghua3@h-partners.com>,
	<yangshuaisong@h-partners.com>, <netdev@vger.kernel.org>,
	<linux-kernel@vger.kernel.org>, <shaojijie@huawei.com>
Subject: [PATCH net-next] net: hns3: add support to query/set TX pfc_prevention_tout for ethtool with RX prevention disabled
Date: Mon, 15 Jun 2026 14:34:27 +0800
Message-ID: <20260615063427.430456-1-shaojijie@huawei.com>
X-Mailer: git-send-email 2.33.0
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: kwepems100002.china.huawei.com (7.221.188.206) To
 kwepemk100013.china.huawei.com (7.202.194.61)
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-6.16 / 15.00];
	WHITELIST_DMARC(-7.00)[huawei.com:D:+];
	SUSPICIOUS_RECIPS(1.50)[];
	MID_CONTAINS_FROM(1.00)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[huawei.com,quarantine];
	R_MISSING_CHARSET(0.50)[];
	R_SPF_ALLOW(-0.20)[+ip4:172.105.105.114:c];
	R_DKIM_ALLOW(-0.20)[huawei.com:s=dkim];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-299334-lists,netdev=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FORGED_RECIPIENTS(0.00)[m:davem@davemloft.net,m:edumazet@google.com,m:kuba@kernel.org,m:pabeni@redhat.com,m:andrew+netdev@lunn.ch,m:horms@kernel.org,m:shenjian15@huawei.com,m:liuyonglong@huawei.com,m:chenhao418@huawei.com,m:huangdonghua3@h-partners.com,m:yangshuaisong@h-partners.com,m:netdev@vger.kernel.org,m:linux-kernel@vger.kernel.org,m:shaojijie@huawei.com,m:andrew@lunn.ch,s:lists@lfdr.de];
	TO_DN_NONE(0.00)[];
	FORGED_SENDER(0.00)[shaojijie@huawei.com,netdev@vger.kernel.org];
	FORGED_SENDER_MAILLIST(0.00)[];
	FROM_HAS_DN(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FORWARDED(0.00)[lists@lfdr.de];
	FROM_NEQ_ENVFROM(0.00)[shaojijie@huawei.com,netdev@vger.kernel.org];
	DKIM_TRACE(0.00)[huawei.com:+];
	RCVD_COUNT_FIVE(0.00)[6];
	TAGGED_RCPT(0.00)[netdev];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	ALIAS_RESOLVED(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.105.96.0/20, country:SG];
	RCPT_COUNT_TWELVE(0.00)[14];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[vger.kernel.org:from_smtp,tor.lore.kernel.org:rdns,tor.lore.kernel.org:helo,huawei.com:dkim,huawei.com:email,huawei.com:mid,huawei.com:from_mime]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: BCD31683DCA

From: Hao Chen <chenhao418@huawei.com>

Add ethtool support to query and configure the PFC (Priority Flow Control)
storm prevention timeout. When TX continuously sends PFC frames, the peer
end is suppressed from sending packets. If this persists, a PFC frame storm
may occur.

This feature allows configuring a timeout to prevent such storms.

Signed-off-by: Hao Chen <chenhao418@huawei.com>
Signed-off-by: Jijie Shao <shaojijie@huawei.com>
---
 drivers/net/ethernet/hisilicon/hns3/hnae3.h   |  14 ++
 .../hns3/hns3_common/hclge_comm_cmd.h         |   3 +
 .../ethernet/hisilicon/hns3/hns3_ethtool.c    |  12 ++
 .../hisilicon/hns3/hns3pf/hclge_cmd.h         |   9 +
 .../hisilicon/hns3/hns3pf/hclge_main.c        | 172 ++++++++++++++++++
 .../hisilicon/hns3/hns3pf/hclge_main.h        |   7 +
 6 files changed, 217 insertions(+)

diff --git a/drivers/net/ethernet/hisilicon/hns3/hnae3.h b/drivers/net/ethernet/hisilicon/hns3/hnae3.h
index a8798eecd9fb..4286af9239b0 100644
--- a/drivers/net/ethernet/hisilicon/hns3/hnae3.h
+++ b/drivers/net/ethernet/hisilicon/hns3/hnae3.h
@@ -602,6 +602,10 @@ typedef int (*read_func)(struct seq_file *s, void *data);
  *   Config wake on lan
  * dbg_get_read_func
  *   Return the read func for debugfs seq file
+ * set_pfc_prevention_tout
+ *   Set PFC storm prevention timeout
+ * get_pfc_prevention_tout
+ *   Get PFC storm prevention timeout
  */
 struct hnae3_ae_ops {
 	int (*init_ae_dev)(struct hnae3_ae_dev *ae_dev);
@@ -810,6 +814,8 @@ struct hnae3_ae_ops {
 	int (*hwtstamp_set)(struct hnae3_handle *handle,
 			    struct kernel_hwtstamp_config *config,
 			    struct netlink_ext_ack *extack);
+	int (*set_pfc_prevention_tout)(struct hnae3_handle *handle, u16 times);
+	int (*get_pfc_prevention_tout)(struct hnae3_handle *handle, u16 *times);
 };
 
 struct hnae3_dcb_ops {
@@ -891,6 +897,14 @@ struct hnae3_roce_private_info {
 	unsigned long state;
 };
 
+struct hnae3_pfc_storm_para {
+	u32 dir;
+	u32 enable;
+	u32 period_ms;
+	u32 times;
+	u32 recovery_period_ms;
+};
+
 #define HNAE3_SUPPORT_APP_LOOPBACK    BIT(0)
 #define HNAE3_SUPPORT_PHY_LOOPBACK    BIT(1)
 #define HNAE3_SUPPORT_SERDES_SERIAL_LOOPBACK	BIT(2)
diff --git a/drivers/net/ethernet/hisilicon/hns3/hns3_common/hclge_comm_cmd.h b/drivers/net/ethernet/hisilicon/hns3/hns3_common/hclge_comm_cmd.h
index 2c2a2f1e0d7a..6dde07dde1e8 100644
--- a/drivers/net/ethernet/hisilicon/hns3/hns3_common/hclge_comm_cmd.h
+++ b/drivers/net/ethernet/hisilicon/hns3/hns3_common/hclge_comm_cmd.h
@@ -314,6 +314,9 @@ enum hclge_opcode_type {
 
 	/* Query link diagnosis info command */
 	HCLGE_OPC_QUERY_LINK_DIAGNOSIS	= 0x702A,
+
+	/* Config pause storm param command */
+	HCLGE_OPC_CFG_PAUSE_STORM_PARA = 0x7019,
 };
 
 enum hclge_comm_cmd_return_status {
diff --git a/drivers/net/ethernet/hisilicon/hns3/hns3_ethtool.c b/drivers/net/ethernet/hisilicon/hns3/hns3_ethtool.c
index 9cb7ce9fd311..1ecde1ec269a 100644
--- a/drivers/net/ethernet/hisilicon/hns3/hns3_ethtool.c
+++ b/drivers/net/ethernet/hisilicon/hns3/hns3_ethtool.c
@@ -1896,6 +1896,12 @@ static int hns3_get_tunable(struct net_device *netdev,
 	case ETHTOOL_TX_COPYBREAK_BUF_SIZE:
 		*(u32 *)data = h->kinfo.tx_spare_buf_size;
 		break;
+	case ETHTOOL_PFC_PREVENTION_TOUT:
+		if (!h->ae_algo->ops->get_pfc_prevention_tout)
+			return -EOPNOTSUPP;
+
+		ret = h->ae_algo->ops->get_pfc_prevention_tout(h, (u16 *)data);
+		break;
 	default:
 		ret = -EOPNOTSUPP;
 		break;
@@ -2021,6 +2027,12 @@ static int hns3_set_tunable(struct net_device *netdev,
 			netdev_info(netdev, "the active tx spare buf size is %u, due to page order\n",
 				    priv->ring->tx_spare->len);
 
+		break;
+	case ETHTOOL_PFC_PREVENTION_TOUT:
+		if (!h->ae_algo->ops->set_pfc_prevention_tout)
+			return -EOPNOTSUPP;
+
+		ret = h->ae_algo->ops->set_pfc_prevention_tout(h, *(u16 *)data);
 		break;
 	default:
 		ret = -EOPNOTSUPP;
diff --git a/drivers/net/ethernet/hisilicon/hns3/hns3pf/hclge_cmd.h b/drivers/net/ethernet/hisilicon/hns3/hns3pf/hclge_cmd.h
index 4ce92ddefcde..1c029dc32ab8 100644
--- a/drivers/net/ethernet/hisilicon/hns3/hns3pf/hclge_cmd.h
+++ b/drivers/net/ethernet/hisilicon/hns3/hns3pf/hclge_cmd.h
@@ -890,6 +890,15 @@ struct hclge_query_wol_supported_cmd {
 	u8 rsv[20];
 };
 
+struct hclge_pfc_storm_para_cmd {
+	__le32 dir;
+	__le32 enable;
+	__le32 period_ms;
+	__le32 times;
+	__le32 recovery_period_ms;
+	__le32 rsv;
+};
+
 struct hclge_hw;
 int hclge_cmd_send(struct hclge_hw *hw, struct hclge_desc *desc, int num);
 #endif
diff --git a/drivers/net/ethernet/hisilicon/hns3/hns3pf/hclge_main.c b/drivers/net/ethernet/hisilicon/hns3/hns3pf/hclge_main.c
index 2f1984930da2..ade90d1bd6df 100644
--- a/drivers/net/ethernet/hisilicon/hns3/hns3pf/hclge_main.c
+++ b/drivers/net/ethernet/hisilicon/hns3/hns3pf/hclge_main.c
@@ -3502,6 +3502,122 @@ static int hclge_set_vf_link_state(struct hnae3_handle *handle, int vf,
 	return ret;
 }
 
+static int hclge_set_pfc_storm_para(struct hclge_dev *hdev,
+				    struct hnae3_pfc_storm_para *para)
+{
+	struct hclge_pfc_storm_para_cmd *para_cmd;
+	struct hclge_desc desc;
+	int ret;
+
+	if (hdev->ae_dev->dev_version < HNAE3_DEVICE_VERSION_V3)
+		return -EOPNOTSUPP;
+
+	hclge_cmd_setup_basic_desc(&desc, HCLGE_OPC_CFG_PAUSE_STORM_PARA,
+				   false);
+	para_cmd = (struct hclge_pfc_storm_para_cmd *)desc.data;
+	para_cmd->dir = cpu_to_le32(para->dir);
+	para_cmd->enable = cpu_to_le32(para->enable);
+	para_cmd->period_ms = cpu_to_le32(para->period_ms);
+	para_cmd->times = cpu_to_le32(para->times);
+	para_cmd->recovery_period_ms = cpu_to_le32(para->recovery_period_ms);
+
+	ret = hclge_cmd_send(&hdev->hw, &desc, 1);
+	if (ret)
+		dev_err(&hdev->pdev->dev,
+			"failed to set pfc storm para, ret = %d\n", ret);
+	return ret;
+}
+
+static int hclge_get_pfc_storm_para(struct hclge_dev *hdev,
+				    struct hnae3_pfc_storm_para *para)
+{
+	struct hclge_pfc_storm_para_cmd *para_cmd;
+	struct hclge_desc desc;
+	int ret;
+
+	if (hdev->ae_dev->dev_version < HNAE3_DEVICE_VERSION_V3)
+		return -EOPNOTSUPP;
+
+	hclge_cmd_setup_basic_desc(&desc, HCLGE_OPC_CFG_PAUSE_STORM_PARA, true);
+	para_cmd = (struct hclge_pfc_storm_para_cmd *)desc.data;
+	para_cmd->dir = cpu_to_le32(para->dir);
+	ret = hclge_cmd_send(&hdev->hw, &desc, 1);
+	if (ret) {
+		dev_err(&hdev->pdev->dev,
+			"failed to get pfc storm para, ret = %d\n", ret);
+		return ret;
+	}
+
+	para->enable = le32_to_cpu(para_cmd->enable);
+	para->period_ms = le32_to_cpu(para_cmd->period_ms);
+	para->times = le32_to_cpu(para_cmd->times);
+	para->recovery_period_ms = le32_to_cpu(para_cmd->recovery_period_ms);
+
+	return 0;
+}
+
+static int hclge_enable_pfc_storm_prevent(struct hclge_dev *hdev,
+					  int dir, bool enable)
+{
+	struct hnae3_pfc_storm_para para = {0};
+	int ret;
+
+	para.dir = dir;
+	ret = hclge_get_pfc_storm_para(hdev, &para);
+	if (ret)
+		return ret;
+
+	para.enable = enable;
+	return hclge_set_pfc_storm_para(hdev, &para);
+}
+
+static int hclge_set_pfc_prevention_tout(struct hnae3_handle *h, u16 times)
+{
+	struct hclge_vport *vport = hclge_get_vport(h);
+	struct hclge_dev *hdev = vport->back;
+	struct hnae3_pfc_storm_para para;
+	int ret;
+
+	if (times > HCLGE_MAX_PFC_PREVENTION_TOUT) {
+		dev_err(&hdev->pdev->dev,
+			"times %u should be less than %u!\n",
+			times, HCLGE_MAX_PFC_PREVENTION_TOUT);
+		return -EINVAL;
+	}
+
+	para.dir = HCLGE_DIR_TX;
+	ret = hclge_get_pfc_storm_para(hdev, &para);
+	if (ret)
+		return ret;
+
+	para.enable = times ? 1 : 0;
+	para.times = (u32)times;
+	ret = hclge_set_pfc_storm_para(hdev, &para);
+	if (ret)
+		return ret;
+
+	hdev->pfc_prevention_tout = times;
+
+	return 0;
+}
+
+static int hclge_get_pfc_prevention_tout(struct hnae3_handle *h, u16 *times)
+{
+	struct hclge_vport *vport = hclge_get_vport(h);
+	struct hclge_dev *hdev = vport->back;
+	struct hnae3_pfc_storm_para para;
+	int ret;
+
+	para.dir = HCLGE_DIR_TX;
+	ret = hclge_get_pfc_storm_para(hdev, &para);
+	if (ret)
+		return ret;
+
+	*times = para.enable ? (u16)para.times : 0;
+
+	return 0;
+}
+
 static void hclge_set_reset_pending(struct hclge_dev *hdev,
 				    enum hnae3_reset_type reset_type)
 {
@@ -4295,6 +4411,26 @@ static int hclge_reset_prepare(struct hclge_dev *hdev)
 	return hclge_reset_prepare_wait(hdev);
 }
 
+static void hclge_restore_pfc_storm_prevention_tout(struct hclge_dev *hdev)
+{
+	struct hnae3_handle *handle = &hdev->vport[0].nic;
+	int ret;
+
+	ret = hclge_enable_pfc_storm_prevent(hdev, HCLGE_DIR_RX, false);
+	if (ret == -EOPNOTSUPP)
+		return;
+	else if (ret)
+		dev_warn(&hdev->pdev->dev,
+			 "failed to disable rx pfc storm prevent, ret = %d\n",
+			 ret);
+
+	ret = hclge_set_pfc_prevention_tout(handle, hdev->pfc_prevention_tout);
+	if (ret)
+		dev_warn(&hdev->pdev->dev,
+			 "failed to set tx pfc storm prevent, ret = %d\n",
+			 ret);
+}
+
 static int hclge_reset_rebuild(struct hclge_dev *hdev)
 {
 	int ret;
@@ -4342,6 +4478,8 @@ static int hclge_reset_rebuild(struct hclge_dev *hdev)
 
 	hclge_update_reset_level(hdev);
 
+	hclge_restore_pfc_storm_prevention_tout(hdev);
+
 	return 0;
 }
 
@@ -9256,6 +9394,32 @@ static int hclge_init_wol(struct hclge_dev *hdev)
 	return hclge_update_wol(hdev);
 }
 
+static void hclge_init_pfc_prevention_tout(struct hclge_dev *hdev)
+{
+	struct hnae3_handle *handle = &hdev->vport[0].nic;
+	u16 times;
+	int ret;
+
+	ret = hclge_enable_pfc_storm_prevent(hdev, HCLGE_DIR_RX, false);
+	if (ret == -EOPNOTSUPP)
+		return;
+	else if (ret)
+		dev_warn(&hdev->pdev->dev,
+			 "failed to disable rx pfc storm prevent, ret = %d\n",
+			 ret);
+
+	ret = hclge_get_pfc_prevention_tout(handle, &times);
+	if (ret) {
+		dev_warn(&hdev->pdev->dev,
+			 "failed to get tx pfc prevention timeout, ret = %d\n",
+			 ret);
+		times = HCLGE_DEFAULT_PFC_PREVENTION_TOUT;
+	}
+
+	hdev->pfc_prevention_tout = times;
+	hdev->pfc_prevention_tout_default = times;
+}
+
 static void hclge_get_wol(struct hnae3_handle *handle,
 			  struct ethtool_wolinfo *wol)
 {
@@ -9490,6 +9654,8 @@ static int hclge_init_ae_dev(struct hnae3_ae_dev *ae_dev)
 		dev_warn(&pdev->dev,
 			 "failed to wake on lan init, ret = %d\n", ret);
 
+	hclge_init_pfc_prevention_tout(hdev);
+
 	ret = hclge_devlink_init(hdev);
 	if (ret)
 		goto err_ptp_uninit;
@@ -9913,6 +10079,10 @@ static void hclge_uninit_ae_dev(struct hnae3_ae_dev *ae_dev)
 	hclge_config_nic_hw_error(hdev, false);
 	hclge_config_rocee_ras_interrupt(hdev, false);
 
+	/* Restore hw default values for the next initialization */
+	hclge_set_pfc_prevention_tout(&hdev->vport->nic,
+				      hdev->pfc_prevention_tout_default);
+
 	hclge_comm_cmd_uninit(hdev->ae_dev, &hdev->hw.hw);
 	hclge_misc_irq_uninit(hdev);
 	hclge_devlink_uninit(hdev);
@@ -10475,6 +10645,8 @@ static const struct hnae3_ae_ops hclge_ops = {
 	.set_wol = hclge_set_wol,
 	.hwtstamp_get = hclge_ptp_get_cfg,
 	.hwtstamp_set = hclge_ptp_set_cfg,
+	.set_pfc_prevention_tout = hclge_set_pfc_prevention_tout,
+	.get_pfc_prevention_tout = hclge_get_pfc_prevention_tout,
 };
 
 static struct hnae3_ae_algo ae_algo = {
diff --git a/drivers/net/ethernet/hisilicon/hns3/hns3pf/hclge_main.h b/drivers/net/ethernet/hisilicon/hns3/hns3pf/hclge_main.h
index 87adeb64e6ea..f40d8c79257c 100644
--- a/drivers/net/ethernet/hisilicon/hns3/hns3pf/hclge_main.h
+++ b/drivers/net/ethernet/hisilicon/hns3/hns3pf/hclge_main.h
@@ -345,6 +345,11 @@ enum hclge_link_fail_code {
 #define HCLGE_LINK_STATUS_DOWN 0
 #define HCLGE_LINK_STATUS_UP   1
 
+#define HCLGE_DIR_RX 0
+#define HCLGE_DIR_TX 1
+#define HCLGE_MAX_PFC_PREVENTION_TOUT		2000
+#define HCLGE_DEFAULT_PFC_PREVENTION_TOUT	1000
+
 #define HCLGE_PG_NUM		4
 #define HCLGE_SCH_MODE_SP	0
 #define HCLGE_SCH_MODE_DWRR	1
@@ -897,6 +902,8 @@ struct hclge_dev {
 	u16 vf_rss_size_max;		/* HW defined VF max RSS task queue */
 	u16 pf_rss_size_max;		/* HW defined PF max RSS task queue */
 	u32 tx_spare_buf_size;		/* HW defined TX spare buffer size */
+	u16 pfc_prevention_tout;	/* User config, restored after reset */
+	u16 pfc_prevention_tout_default; /* HW default, to avoid stale state */
 
 	u16 fdir_pf_filter_count; /* Num of guaranteed filters for this PF */
 	u16 num_alloc_vport;		/* Num vports this driver supports */

base-commit: 2319688890d97c63da423a3c57c23b4ab5952dfc
-- 
2.33.0


