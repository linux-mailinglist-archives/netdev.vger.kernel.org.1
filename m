Return-Path: <netdev+bounces-267322-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id sBcvOyDGs2kqawAAu9opvQ
	(envelope-from <netdev+bounces-267322-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Fri, 13 Mar 2026 09:09:04 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 602E727F549
	for <lists+netdev@lfdr.de>; Fri, 13 Mar 2026 09:09:04 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 61A8E31616F1
	for <lists+netdev@lfdr.de>; Fri, 13 Mar 2026 07:55:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E1D22374E78;
	Fri, 13 Mar 2026 07:54:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=huawei.com header.i=@huawei.com header.b="CCOtpMKj"
X-Original-To: netdev@vger.kernel.org
Received: from canpmsgout08.his.huawei.com (canpmsgout08.his.huawei.com [113.46.200.223])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CB956373BEB;
	Fri, 13 Mar 2026 07:54:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=113.46.200.223
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773388483; cv=none; b=qAn2ZAogRK3ennHQPliIMNHU16DVb44YusmmXfWkmz3n5WxqLS2bBIKMWojZ+KvbnPEV8Nwms3TFPKW/g2lhT7/eSTb/t+CSkP5JYLOc0g12tFG96GT/aHQoDP4Un9+tykphwIPPXmm+Aon4e7kLdmBDUJTBxCxAqNSkDzdhX5Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773388483; c=relaxed/simple;
	bh=2mp21Bgx0s1nHyRQATv5i2w7Zzb+50PnuFXskM1IdZg=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=mYpEwcIeRRTPd/QzdgCuuMk6CBrGWMUnH7apULccmS3V0nbg1jlTb0tKtZrAWP6N8ZRqzWWqWoSqRVu53mzsn7FXG0q10tIc9OEje2rOKgmprFAELUNxPXog0fXBm9VHLf4DEp35wn6AwDbqBsxoBhjKabWdYxW0ugXU490oX+A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=huawei.com; dkim=pass (1024-bit key) header.d=huawei.com header.i=@huawei.com header.b=CCOtpMKj; arc=none smtp.client-ip=113.46.200.223
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
dkim-signature: v=1; a=rsa-sha256; d=huawei.com; s=dkim;
	c=relaxed/relaxed; q=dns/txt;
	h=From;
	bh=AWLv/HbQGJeSA9CEKbKidWIpaRxWLDLu82TW66hiQDw=;
	b=CCOtpMKjeZWbHG0j4G5QbqzOCFfL1pvu2L59vMc0o4SbVLtG0DvAkPtZHCWIl2C+3A/HbihGy
	p1AOJOAQd61wyBFuhu3gYGTwCEFf4NhSs6SyTYdtG8ij9ifeqk1jdMe5EFsMNKmFhcJ+fyN/pZ5
	2RtaK4iKujC//ZdZjQGK3BE=
Received: from mail.maildlp.com (unknown [172.19.162.92])
	by canpmsgout08.his.huawei.com (SkyGuard) with ESMTPS id 4fXGpl1pZRzmV6J;
	Fri, 13 Mar 2026 15:49:35 +0800 (CST)
Received: from kwepemf100013.china.huawei.com (unknown [7.202.181.12])
	by mail.maildlp.com (Postfix) with ESMTPS id AAB6C40565;
	Fri, 13 Mar 2026 15:54:32 +0800 (CST)
Received: from DESKTOP-62GVMTR.china.huawei.com (10.174.189.124) by
 kwepemf100013.china.huawei.com (7.202.181.12) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.36; Fri, 13 Mar 2026 15:54:31 +0800
From: Fan Gong <gongfan1@huawei.com>
To: Fan Gong <gongfan1@huawei.com>, Zhu Yikai <zhuyikai1@h-partners.com>,
	<netdev@vger.kernel.org>, "David S. Miller" <davem@davemloft.net>, Eric
 Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>, Paolo Abeni
	<pabeni@redhat.com>, Simon Horman <horms@kernel.org>, Andrew Lunn
	<andrew+netdev@lunn.ch>, Ioana Ciornei <ioana.ciornei@nxp.com>
CC: <linux-kernel@vger.kernel.org>, <linux-doc@vger.kernel.org>, luosifu
	<luosifu@huawei.com>, Xin Guo <guoxin09@huawei.com>, Zhou Shuai
	<zhoushuai28@huawei.com>, Wu Like <wulike1@huawei.com>, Shi Jing
	<shijing34@huawei.com>, Zheng Jiezhen <zhengjiezhen@h-partners.com>, Maxime
 Chevallier <maxime.chevallier@bootlin.com>
Subject: [PATCH net-next v01 4/7] hinic3: Add ethtool rss ops
Date: Fri, 13 Mar 2026 15:54:11 +0800
Message-ID: <d1e7935defcd58b9fa450a7236677293e6ac7dd5.1773387649.git.zhuyikai1@h-partners.com>
X-Mailer: git-send-email 2.51.0.windows.1
In-Reply-To: <cover.1773387649.git.zhuyikai1@h-partners.com>
References: <cover.1773387649.git.zhuyikai1@h-partners.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: kwepems500002.china.huawei.com (7.221.188.17) To
 kwepemf100013.china.huawei.com (7.202.181.12)
X-Spamd-Result: default: False [-0.16 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[huawei.com,quarantine];
	R_DKIM_ALLOW(-0.20)[huawei.com:s=dkim];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	MIME_TRACE(0.00)[0:+];
	RCPT_COUNT_TWELVE(0.00)[19];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-267322-lists,netdev=lfdr.de];
	DKIM_TRACE(0.00)[huawei.com:+];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	TO_DN_SOME(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[gongfan1@huawei.com,netdev@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	RCVD_COUNT_FIVE(0.00)[6];
	TAGGED_RCPT(0.00)[netdev];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,h-partners.com:email,h-partners.com:mid,huawei.com:dkim,huawei.com:email]
X-Rspamd-Queue-Id: 602E727F549
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

  Implement following ethtool callback function:
.get_rxnfc
.set_rxnfc
.get_channels
.set_channels
.get_rxfh_indir_size
.get_rxfh_key_size
.get_rxfh
.set_rxfh

  These callbacks allow users to utilize ethtool for detailed
RSS parameters configuration and monitoring.

Co-developed-by: Zhu Yikai <zhuyikai1@h-partners.com>
Signed-off-by: Zhu Yikai <zhuyikai1@h-partners.com>
Signed-off-by: Fan Gong <gongfan1@huawei.com>
---
 .../ethernet/huawei/hinic3/hinic3_ethtool.c   |   9 +
 .../huawei/hinic3/hinic3_mgmt_interface.h     |   2 +
 .../net/ethernet/huawei/hinic3/hinic3_rss.c   | 487 +++++++++++++++++-
 .../net/ethernet/huawei/hinic3/hinic3_rss.h   |  19 +
 4 files changed, 515 insertions(+), 2 deletions(-)

diff --git a/drivers/net/ethernet/huawei/hinic3/hinic3_ethtool.c b/drivers/net/ethernet/huawei/hinic3/hinic3_ethtool.c
index 8f9b71a04145..71b5e5c451df 100644
--- a/drivers/net/ethernet/huawei/hinic3/hinic3_ethtool.c
+++ b/drivers/net/ethernet/huawei/hinic3/hinic3_ethtool.c
@@ -15,6 +15,7 @@
 #include "hinic3_hw_comm.h"
 #include "hinic3_nic_dev.h"
 #include "hinic3_nic_cfg.h"
+#include "hinic3_rss.h"
 
 #define HINIC3_MGMT_VERSION_MAX_LEN     32
 #define COALESCE_ALL_QUEUE              0xFFFF
@@ -1331,6 +1332,14 @@ static const struct ethtool_ops hinic3_ethtool_ops = {
 	.get_pause_stats                = hinic3_get_pause_stats,
 	.get_coalesce                   = hinic3_get_coalesce,
 	.set_coalesce                   = hinic3_set_coalesce,
+	.get_rxnfc                      = hinic3_get_rxnfc,
+	.set_rxnfc                      = hinic3_set_rxnfc,
+	.get_channels                   = hinic3_get_channels,
+	.set_channels                   = hinic3_set_channels,
+	.get_rxfh_indir_size            = hinic3_get_rxfh_indir_size,
+	.get_rxfh_key_size              = hinic3_get_rxfh_key_size,
+	.get_rxfh                       = hinic3_get_rxfh,
+	.set_rxfh                       = hinic3_set_rxfh,
 };
 
 void hinic3_set_ethtool_ops(struct net_device *netdev)
diff --git a/drivers/net/ethernet/huawei/hinic3/hinic3_mgmt_interface.h b/drivers/net/ethernet/huawei/hinic3/hinic3_mgmt_interface.h
index 76c691f82703..3c1263ff99ff 100644
--- a/drivers/net/ethernet/huawei/hinic3/hinic3_mgmt_interface.h
+++ b/drivers/net/ethernet/huawei/hinic3/hinic3_mgmt_interface.h
@@ -282,6 +282,7 @@ enum l2nic_cmd {
 	L2NIC_CMD_SET_VLAN_FILTER_EN  = 26,
 	L2NIC_CMD_SET_RX_VLAN_OFFLOAD = 27,
 	L2NIC_CMD_CFG_RSS             = 60,
+	L2NIC_CMD_GET_RSS_CTX_TBL     = 62,
 	L2NIC_CMD_CFG_RSS_HASH_KEY    = 63,
 	L2NIC_CMD_CFG_RSS_HASH_ENGINE = 64,
 	L2NIC_CMD_SET_RSS_CTX_TBL     = 65,
@@ -301,6 +302,7 @@ enum l2nic_ucode_cmd {
 	L2NIC_UCODE_CMD_MODIFY_QUEUE_CTX  = 0,
 	L2NIC_UCODE_CMD_CLEAN_QUEUE_CTX   = 1,
 	L2NIC_UCODE_CMD_SET_RSS_INDIR_TBL = 4,
+	L2NIC_UCODE_CMD_GET_RSS_INDIR_TBL = 6,
 };
 
 /* hilink mac group command */
diff --git a/drivers/net/ethernet/huawei/hinic3/hinic3_rss.c b/drivers/net/ethernet/huawei/hinic3/hinic3_rss.c
index 25db74d8c7dd..74c04f72d4ff 100644
--- a/drivers/net/ethernet/huawei/hinic3/hinic3_rss.c
+++ b/drivers/net/ethernet/huawei/hinic3/hinic3_rss.c
@@ -155,7 +155,7 @@ static int hinic3_set_rss_type(struct hinic3_hwdev *hwdev,
 				       L2NIC_CMD_SET_RSS_CTX_TBL, &msg_params);
 
 	if (ctx_tbl.msg_head.status == MGMT_STATUS_CMD_UNSUPPORTED) {
-		return MGMT_STATUS_CMD_UNSUPPORTED;
+		return -EOPNOTSUPP;
 	} else if (err || ctx_tbl.msg_head.status) {
 		dev_err(hwdev->dev, "mgmt Failed to set rss context offload, err: %d, status: 0x%x\n",
 			err, ctx_tbl.msg_head.status);
@@ -165,6 +165,39 @@ static int hinic3_set_rss_type(struct hinic3_hwdev *hwdev,
 	return 0;
 }
 
+static int hinic3_get_rss_type(struct hinic3_hwdev *hwdev,
+			       struct hinic3_rss_type *rss_type)
+{
+	struct l2nic_cmd_rss_ctx_tbl ctx_tbl = {};
+	struct mgmt_msg_params msg_params = {};
+	int err;
+
+	ctx_tbl.func_id = hinic3_global_func_id(hwdev);
+
+	mgmt_msg_params_init_default(&msg_params, &ctx_tbl, sizeof(ctx_tbl));
+
+	err = hinic3_send_mbox_to_mgmt(hwdev, MGMT_MOD_L2NIC,
+				       L2NIC_CMD_GET_RSS_CTX_TBL,
+				       &msg_params);
+	if (err || ctx_tbl.msg_head.status) {
+		dev_err(hwdev->dev, "Failed to get hash type, err: %d, status: 0x%x\n",
+			err, ctx_tbl.msg_head.status);
+			return -EINVAL;
+	}
+
+	rss_type->ipv4         = L2NIC_RSS_TYPE_GET(ctx_tbl.context, IPV4);
+	rss_type->ipv6         = L2NIC_RSS_TYPE_GET(ctx_tbl.context, IPV6);
+	rss_type->ipv6_ext     = L2NIC_RSS_TYPE_GET(ctx_tbl.context, IPV6_EXT);
+	rss_type->tcp_ipv4     = L2NIC_RSS_TYPE_GET(ctx_tbl.context, TCP_IPV4);
+	rss_type->tcp_ipv6     = L2NIC_RSS_TYPE_GET(ctx_tbl.context, TCP_IPV6);
+	rss_type->tcp_ipv6_ext = L2NIC_RSS_TYPE_GET(ctx_tbl.context,
+						    TCP_IPV6_EXT);
+	rss_type->udp_ipv4     = L2NIC_RSS_TYPE_GET(ctx_tbl.context, UDP_IPV4);
+	rss_type->udp_ipv6     = L2NIC_RSS_TYPE_GET(ctx_tbl.context, UDP_IPV6);
+
+	return 0;
+}
+
 static int hinic3_rss_cfg_hash_type(struct hinic3_hwdev *hwdev, u8 opcode,
 				    enum hinic3_rss_hash_type *type)
 {
@@ -264,7 +297,8 @@ static int hinic3_set_hw_rss_parameters(struct net_device *netdev, u8 rss_en)
 	if (err)
 		return err;
 
-	hinic3_fillout_indir_tbl(netdev, nic_dev->rss_indir);
+	if (!netif_is_rxfh_configured(netdev))
+		hinic3_fillout_indir_tbl(netdev, nic_dev->rss_indir);
 
 	err = hinic3_config_rss_hw_resource(netdev, nic_dev->rss_indir);
 	if (err)
@@ -334,3 +368,452 @@ void hinic3_try_to_enable_rss(struct net_device *netdev)
 	clear_bit(HINIC3_RSS_ENABLE, &nic_dev->flags);
 	nic_dev->q_params.num_qps = nic_dev->max_qps;
 }
+
+static int hinic3_set_l4_rss_hash_ops(const struct ethtool_rxnfc *cmd,
+				      struct hinic3_rss_type *rss_type)
+{
+	u8 rss_l4_en;
+
+	switch (cmd->data & (RXH_L4_B_0_1 | RXH_L4_B_2_3)) {
+	case 0:
+		rss_l4_en = 0;
+		break;
+	case (RXH_L4_B_0_1 | RXH_L4_B_2_3):
+		rss_l4_en = 1;
+		break;
+	default:
+		return -EINVAL;
+	}
+
+	switch (cmd->flow_type) {
+	case TCP_V4_FLOW:
+		rss_type->tcp_ipv4 = rss_l4_en;
+		break;
+	case TCP_V6_FLOW:
+		rss_type->tcp_ipv6 = rss_l4_en;
+		break;
+	case UDP_V4_FLOW:
+		rss_type->udp_ipv4 = rss_l4_en;
+		break;
+	case UDP_V6_FLOW:
+		rss_type->udp_ipv6 = rss_l4_en;
+		break;
+	default:
+		return -EINVAL;
+	}
+
+	return 0;
+}
+
+static int hinic3_update_rss_hash_opts(struct net_device *netdev,
+				       struct ethtool_rxnfc *cmd,
+				       struct hinic3_rss_type *rss_type)
+{
+	int err;
+
+	switch (cmd->flow_type) {
+	case TCP_V4_FLOW:
+	case TCP_V6_FLOW:
+	case UDP_V4_FLOW:
+	case UDP_V6_FLOW:
+		err = hinic3_set_l4_rss_hash_ops(cmd, rss_type);
+		if (err)
+			return err;
+
+		break;
+	case IPV4_FLOW:
+		rss_type->ipv4 = 1;
+		break;
+	case IPV6_FLOW:
+		rss_type->ipv6 = 1;
+		break;
+	default:
+		netdev_err(netdev, "Unsupported flow type\n");
+		return -EINVAL;
+	}
+
+	return 0;
+}
+
+static int hinic3_set_rss_hash_opts(struct net_device *netdev,
+				    struct ethtool_rxnfc *cmd)
+{
+	struct hinic3_nic_dev *nic_dev = netdev_priv(netdev);
+	struct hinic3_rss_type *rss_type;
+	int err;
+
+	rss_type = &nic_dev->rss_type;
+
+	if (!test_bit(HINIC3_RSS_ENABLE, &nic_dev->flags)) {
+		cmd->data = 0;
+		netdev_err(netdev, "RSS is disable, not support to set flow-hash\n");
+		return -EOPNOTSUPP;
+	}
+
+	/* RSS only supports hashing of IP addresses and L4 ports */
+	if (cmd->data & ~(RXH_IP_SRC | RXH_IP_DST |
+			  RXH_L4_B_0_1 | RXH_L4_B_2_3))
+		return -EINVAL;
+
+	/* Both IP addresses must be part of the hash tuple */
+	if (!(cmd->data & RXH_IP_SRC) || !(cmd->data & RXH_IP_DST))
+		return -EINVAL;
+
+	err = hinic3_get_rss_type(nic_dev->hwdev, rss_type);
+	if (err) {
+		netdev_err(netdev, "Failed to get rss type\n");
+		return err;
+	}
+
+	err = hinic3_update_rss_hash_opts(netdev, cmd, rss_type);
+	if (err)
+		return err;
+
+	err = hinic3_set_rss_type(nic_dev->hwdev, *rss_type);
+	if (err) {
+		netdev_err(netdev, "Failed to set rss type\n");
+		return err;
+	}
+
+	return 0;
+}
+
+static void convert_rss_type(u8 rss_opt, struct ethtool_rxnfc *cmd)
+{
+	if (rss_opt)
+		cmd->data |= RXH_L4_B_0_1 | RXH_L4_B_2_3;
+}
+
+static int hinic3_convert_rss_type(struct net_device *netdev,
+				   struct hinic3_rss_type *rss_type,
+				   struct ethtool_rxnfc *cmd)
+{
+	cmd->data = RXH_IP_SRC | RXH_IP_DST;
+	switch (cmd->flow_type) {
+	case TCP_V4_FLOW:
+		convert_rss_type(rss_type->tcp_ipv4, cmd);
+		break;
+	case TCP_V6_FLOW:
+		convert_rss_type(rss_type->tcp_ipv6, cmd);
+		break;
+	case UDP_V4_FLOW:
+		convert_rss_type(rss_type->udp_ipv4, cmd);
+		break;
+	case UDP_V6_FLOW:
+		convert_rss_type(rss_type->udp_ipv6, cmd);
+		break;
+	case IPV4_FLOW:
+	case IPV6_FLOW:
+		break;
+	default:
+		netdev_err(netdev, "Unsupported flow type\n");
+		cmd->data = 0;
+		return -EINVAL;
+	}
+
+	return 0;
+}
+
+static int hinic3_get_rss_hash_opts(struct net_device *netdev,
+				    struct ethtool_rxnfc *cmd)
+{
+	struct hinic3_nic_dev *nic_dev = netdev_priv(netdev);
+	struct hinic3_rss_type rss_type;
+	int err;
+
+	cmd->data = 0;
+
+	if (!test_bit(HINIC3_RSS_ENABLE, &nic_dev->flags))
+		return 0;
+
+	err = hinic3_get_rss_type(nic_dev->hwdev, &rss_type);
+	if (err) {
+		netdev_err(netdev, "Failed to get rss type\n");
+		return err;
+	}
+
+	return hinic3_convert_rss_type(netdev, &rss_type, cmd);
+}
+
+int hinic3_get_rxnfc(struct net_device *netdev,
+		     struct ethtool_rxnfc *cmd, u32 *rule_locs)
+{
+	struct hinic3_nic_dev *nic_dev = netdev_priv(netdev);
+	int err = 0;
+
+	switch (cmd->cmd) {
+	case ETHTOOL_GRXRINGS:
+		cmd->data = nic_dev->q_params.num_qps;
+		break;
+	case ETHTOOL_GRXFH:
+		err = hinic3_get_rss_hash_opts(netdev, cmd);
+		break;
+	default:
+		err = -EOPNOTSUPP;
+		break;
+	}
+
+	return err;
+}
+
+int hinic3_set_rxnfc(struct net_device *netdev, struct ethtool_rxnfc *cmd)
+{
+	int err;
+
+	switch (cmd->cmd) {
+	case ETHTOOL_SRXFH:
+		err = hinic3_set_rss_hash_opts(netdev, cmd);
+		break;
+	default:
+		err = -EOPNOTSUPP;
+		break;
+	}
+
+	return err;
+}
+
+static u16 hinic3_max_channels(struct net_device *netdev)
+{
+	struct hinic3_nic_dev *nic_dev = netdev_priv(netdev);
+	u8 tcs = netdev_get_num_tc(netdev);
+
+	return tcs ? nic_dev->max_qps / tcs : nic_dev->max_qps;
+}
+
+static u16 hinic3_curr_channels(struct net_device *netdev)
+{
+	struct hinic3_nic_dev *nic_dev = netdev_priv(netdev);
+
+	if (netif_running(netdev))
+		return nic_dev->q_params.num_qps ?
+				nic_dev->q_params.num_qps : 1;
+	else
+		return min_t(u16, hinic3_max_channels(netdev),
+			     nic_dev->q_params.num_qps);
+}
+
+void hinic3_get_channels(struct net_device *netdev,
+			 struct ethtool_channels *channels)
+{
+	channels->max_rx = 0;
+	channels->max_tx = 0;
+	channels->max_other = 0;
+	/* report maximum channels */
+	channels->max_combined = hinic3_max_channels(netdev);
+	channels->rx_count = 0;
+	channels->tx_count = 0;
+	channels->other_count = 0;
+	/* report flow director queues as maximum channels */
+	channels->combined_count = hinic3_curr_channels(netdev);
+}
+
+static int
+hinic3_validate_channel_parameter(struct net_device *netdev,
+				  const struct ethtool_channels *channels)
+{
+	u16 max_channel = hinic3_max_channels(netdev);
+	unsigned int count = channels->combined_count;
+
+	if (!count) {
+		netdev_err(netdev, "Unsupported combined_count=0\n");
+		return -EINVAL;
+	}
+
+	if (channels->tx_count || channels->rx_count || channels->other_count) {
+		netdev_err(netdev, "Setting rx/tx/other count not supported\n");
+		return -EINVAL;
+	}
+
+	if (count > max_channel) {
+		netdev_err(netdev, "Combined count %u exceed limit %u\n", count,
+			   max_channel);
+		return -EINVAL;
+	}
+
+	return 0;
+}
+
+int hinic3_set_channels(struct net_device *netdev,
+			struct ethtool_channels *channels)
+{
+	struct hinic3_nic_dev *nic_dev = netdev_priv(netdev);
+	unsigned int count = channels->combined_count;
+	struct hinic3_dyna_txrxq_params q_params;
+	int err;
+
+	if (hinic3_validate_channel_parameter(netdev, channels))
+		return -EINVAL;
+
+	if (!test_bit(HINIC3_RSS_ENABLE, &nic_dev->flags)) {
+		netdev_err(netdev, "This function doesn't support RSS, only support 1 queue pair\n");
+		return -EOPNOTSUPP;
+	}
+
+	netdev_dbg(netdev, "Set max combined queue number from %u to %u\n",
+		   nic_dev->q_params.num_qps, count);
+
+	if (netif_running(netdev)) {
+		q_params = nic_dev->q_params;
+		q_params.num_qps = (u16)count;
+		q_params.txqs_res = NULL;
+		q_params.rxqs_res = NULL;
+		q_params.irq_cfg = NULL;
+
+		err = hinic3_change_channel_settings(netdev, &q_params);
+		if (err) {
+			netdev_err(netdev, "Failed to change channel settings\n");
+			return err;
+		}
+	} else {
+		nic_dev->q_params.num_qps = (u16)count;
+	}
+
+	return 0;
+}
+
+u32 hinic3_get_rxfh_indir_size(struct net_device *netdev)
+{
+	return L2NIC_RSS_INDIR_SIZE;
+}
+
+static int hinic3_set_rss_rxfh(struct net_device *netdev,
+			       const u32 *indir, u8 *key)
+{
+	struct hinic3_nic_dev *nic_dev = netdev_priv(netdev);
+	int err;
+	u32 i;
+
+	if (indir) {
+		for (i = 0; i < L2NIC_RSS_INDIR_SIZE; i++)
+			nic_dev->rss_indir[i] = (u16)indir[i];
+
+		err = hinic3_rss_set_indir_tbl(nic_dev->hwdev,
+					       nic_dev->rss_indir);
+		if (err) {
+			netdev_err(netdev, "Failed to set rss indir table\n");
+			return err;
+		}
+	}
+
+	if (key) {
+		err = hinic3_rss_set_hash_key(nic_dev->hwdev, key);
+		if (err) {
+			netdev_err(netdev, "Failed to set rss key\n");
+			return err;
+		}
+
+		memcpy(nic_dev->rss_hkey, key, L2NIC_RSS_KEY_SIZE);
+	}
+
+	return 0;
+}
+
+u32 hinic3_get_rxfh_key_size(struct net_device *netdev)
+{
+	return L2NIC_RSS_KEY_SIZE;
+}
+
+static int hinic3_rss_get_indir_tbl(struct hinic3_hwdev *hwdev,
+				    u32 *indir_table)
+{
+	struct hinic3_cmd_buf_pair pair;
+	u16 *indir_tbl = NULL;
+	int err, i;
+
+	err = hinic3_cmd_buf_pair_init(hwdev, &pair);
+	if (err) {
+		dev_err(hwdev->dev, "Failed to allocate cmd_buf.\n");
+		return err;
+	}
+
+	err = hinic3_cmdq_detail_resp(hwdev, MGMT_MOD_L2NIC,
+				      L2NIC_UCODE_CMD_GET_RSS_INDIR_TBL,
+				      pair.in, pair.out, NULL);
+	if (err) {
+		dev_err(hwdev->dev, "Failed to get rss indir table\n");
+		goto err_get_indir_tbl;
+	}
+
+	indir_tbl = (u16 *)pair.out->buf;
+	for (i = 0; i < L2NIC_RSS_INDIR_SIZE; i++)
+		indir_table[i] = *(indir_tbl + i);
+
+err_get_indir_tbl:
+	hinic3_cmd_buf_pair_uninit(hwdev, &pair);
+
+	return err;
+}
+
+int hinic3_get_rxfh(struct net_device *netdev,
+		    struct ethtool_rxfh_param *rxfh)
+{
+	struct hinic3_nic_dev *nic_dev = netdev_priv(netdev);
+	int err = 0;
+
+	if (!test_bit(HINIC3_RSS_ENABLE, &nic_dev->flags)) {
+		netdev_err(netdev, "Rss is disabled\n");
+		return -EOPNOTSUPP;
+	}
+
+	rxfh->hfunc =
+		nic_dev->rss_hash_type == HINIC3_RSS_HASH_ENGINE_TYPE_XOR ?
+		ETH_RSS_HASH_XOR : ETH_RSS_HASH_TOP;
+
+	if (rxfh->indir) {
+		err = hinic3_rss_get_indir_tbl(nic_dev->hwdev, rxfh->indir);
+		if (err)
+			return err;
+	}
+
+	if (rxfh->key)
+		memcpy(rxfh->key, nic_dev->rss_hkey, L2NIC_RSS_KEY_SIZE);
+
+	return err;
+}
+
+static int hinic3_update_hash_func_type(struct net_device *netdev, u8 hfunc)
+{
+	struct hinic3_nic_dev *nic_dev = netdev_priv(netdev);
+	enum hinic3_rss_hash_type new_rss_hash_type;
+
+	switch (hfunc) {
+	case ETH_RSS_HASH_NO_CHANGE:
+		return 0;
+	case ETH_RSS_HASH_XOR:
+		new_rss_hash_type = HINIC3_RSS_HASH_ENGINE_TYPE_XOR;
+		break;
+	case ETH_RSS_HASH_TOP:
+		new_rss_hash_type = HINIC3_RSS_HASH_ENGINE_TYPE_TOEP;
+		break;
+	default:
+		netdev_err(netdev, "Unsupported hash func %u\n", hfunc);
+		return -EOPNOTSUPP;
+	}
+
+	if (new_rss_hash_type == nic_dev->rss_hash_type)
+		return 0;
+
+	nic_dev->rss_hash_type = new_rss_hash_type;
+	return hinic3_rss_set_hash_type(nic_dev->hwdev, nic_dev->rss_hash_type);
+}
+
+int hinic3_set_rxfh(struct net_device *netdev,
+		    struct ethtool_rxfh_param *rxfh,
+		    struct netlink_ext_ack *extack)
+{
+	struct hinic3_nic_dev *nic_dev = netdev_priv(netdev);
+	int err;
+
+	if (!test_bit(HINIC3_RSS_ENABLE, &nic_dev->flags)) {
+		netdev_err(netdev, "Not support to set rss parameters when rss is disable\n");
+		return -EOPNOTSUPP;
+	}
+
+	err = hinic3_update_hash_func_type(netdev, rxfh->hfunc);
+	if (err)
+		return err;
+
+	err = hinic3_set_rss_rxfh(netdev, rxfh->indir, rxfh->key);
+
+	return err;
+}
diff --git a/drivers/net/ethernet/huawei/hinic3/hinic3_rss.h b/drivers/net/ethernet/huawei/hinic3/hinic3_rss.h
index 78d82c2aca06..9f1b77780cd4 100644
--- a/drivers/net/ethernet/huawei/hinic3/hinic3_rss.h
+++ b/drivers/net/ethernet/huawei/hinic3/hinic3_rss.h
@@ -5,10 +5,29 @@
 #define _HINIC3_RSS_H_
 
 #include <linux/netdevice.h>
+#include <linux/ethtool.h>
 
 int hinic3_rss_init(struct net_device *netdev);
 void hinic3_rss_uninit(struct net_device *netdev);
 void hinic3_try_to_enable_rss(struct net_device *netdev);
 void hinic3_clear_rss_config(struct net_device *netdev);
 
+int hinic3_get_rxnfc(struct net_device *netdev,
+		     struct ethtool_rxnfc *cmd, u32 *rule_locs);
+int hinic3_set_rxnfc(struct net_device *netdev, struct ethtool_rxnfc *cmd);
+
+void hinic3_get_channels(struct net_device *netdev,
+			 struct ethtool_channels *channels);
+int hinic3_set_channels(struct net_device *netdev,
+			struct ethtool_channels *channels);
+
+u32 hinic3_get_rxfh_indir_size(struct net_device *netdev);
+u32 hinic3_get_rxfh_key_size(struct net_device *netdev);
+
+int hinic3_get_rxfh(struct net_device *netdev,
+		    struct ethtool_rxfh_param *rxfh);
+int hinic3_set_rxfh(struct net_device *netdev,
+		    struct ethtool_rxfh_param *rxfh,
+		    struct netlink_ext_ack *extack);
+
 #endif
-- 
2.43.0


