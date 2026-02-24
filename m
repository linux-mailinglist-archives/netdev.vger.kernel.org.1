Return-Path: <netdev+bounces-260535-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id gLX6FRGmnWmgQwQAu9opvQ
	(envelope-from <netdev+bounces-260535-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Tue, 24 Feb 2026 14:22:25 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 17788187915
	for <lists+netdev@lfdr.de>; Tue, 24 Feb 2026 14:22:25 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id DEDDB315B6A5
	for <lists+netdev@lfdr.de>; Tue, 24 Feb 2026 13:17:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5A4903A1A53;
	Tue, 24 Feb 2026 13:16:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=huawei.com header.i=@huawei.com header.b="tL+zQEEX"
X-Original-To: netdev@vger.kernel.org
Received: from canpmsgout03.his.huawei.com (canpmsgout03.his.huawei.com [113.46.200.218])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D11F23A1A43;
	Tue, 24 Feb 2026 13:16:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=113.46.200.218
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1771938988; cv=none; b=XHryfMIJwzXOUWmSmAY+PKlNFpaMFz9APTSu9ZwYSXpEtVqLnnQua65fMFh83s5qhJkuR08+n3vXSgW4NTueW6Uj8eq8C1z8nsy7uFHypm2u9GEpfW8baK8G7qLQ6BnfMyoJMBvRtGYvUVSwtRx+h35X+uibvhJd+fEc0US1tXI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1771938988; c=relaxed/simple;
	bh=bf0NxaGL/wrr28K/C5Ym3GsrBAaZEk8EPyKIFNb9cI0=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=ehLpfps2jqnkGeCgP9aOipSxKJ/E+6gj1n1tUvVtg1fvWds48h5W1Dtzc/WFP2Fz/msr1ucv94DFNskQCmUMerPHYKBlU+Efkn6nJxvcY9QG7qCSAT/3nUtfz7i+073/ggPY00RueSIHjf1Z+9YVU502QBm7lbEzMWDS5+uJuDo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=huawei.com; dkim=pass (1024-bit key) header.d=huawei.com header.i=@huawei.com header.b=tL+zQEEX; arc=none smtp.client-ip=113.46.200.218
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
dkim-signature: v=1; a=rsa-sha256; d=huawei.com; s=dkim;
	c=relaxed/relaxed; q=dns/txt;
	h=From;
	bh=n/pg0Tw1O/MBIkjV9GqpJlB9KUTV7XWENZDkOwJq7Ak=;
	b=tL+zQEEXOAuGhHAC4rw/6nMIzDWnYUZT/h5uWEZL6fwV+mDvkaHgfzORsu6le6RC0GPxHxpoj
	M8vbfJcZF/XgGL2qOG1QxXe7468Ei0tzbMhJksUFVRLj7Aj0SsWIZYAltue18YRFWAsYLeG3BST
	BxSUkEhjqh4UjH0ESHBoNZE=
Received: from mail.maildlp.com (unknown [172.19.162.140])
	by canpmsgout03.his.huawei.com (SkyGuard) with ESMTPS id 4fKym91h4gzpT14;
	Tue, 24 Feb 2026 21:11:37 +0800 (CST)
Received: from kwepemf100013.china.huawei.com (unknown [7.202.181.12])
	by mail.maildlp.com (Postfix) with ESMTPS id 0FE252016A;
	Tue, 24 Feb 2026 21:16:23 +0800 (CST)
Received: from DESKTOP-62GVMTR.china.huawei.com (10.174.189.124) by
 kwepemf100013.china.huawei.com (7.202.181.12) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.36; Tue, 24 Feb 2026 21:16:22 +0800
From: Fan Gong <gongfan1@huawei.com>
To: Fan Gong <gongfan1@huawei.com>, Zhu Yikai <zhuyikai1@h-partners.com>,
	<netdev@vger.kernel.org>, "David S. Miller" <davem@davemloft.net>, Eric
 Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>, Paolo Abeni
	<pabeni@redhat.com>, Simon Horman <horms@kernel.org>, Andrew Lunn
	<andrew+netdev@lunn.ch>
CC: <linux-kernel@vger.kernel.org>, <linux-doc@vger.kernel.org>, luosifu
	<luosifu@huawei.com>, Xin Guo <guoxin09@huawei.com>, Zhou Shuai
	<zhoushuai28@huawei.com>, Wu Like <wulike1@huawei.com>, Shi Jing
	<shijing34@huawei.com>
Subject: [PATCH net-next v01 12/15] hinic3: Add ethtool coalesce ops
Date: Tue, 24 Feb 2026 21:15:49 +0800
Message-ID: <3f472dcdeae0c5571a7f2095231a3f8a8dabc79e.1771916043.git.zhuyikai1@h-partners.com>
X-Mailer: git-send-email 2.51.0.windows.1
In-Reply-To: <cover.1771916043.git.zhuyikai1@h-partners.com>
References: <cover.1771916043.git.zhuyikai1@h-partners.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: kwepems500001.china.huawei.com (7.221.188.70) To
 kwepemf100013.china.huawei.com (7.202.181.12)
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.16 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[huawei.com,quarantine];
	R_DKIM_ALLOW(-0.20)[huawei.com:s=dkim];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c04:e001:36c::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	MIME_TRACE(0.00)[0:+];
	RCPT_COUNT_TWELVE(0.00)[16];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-260535-lists,netdev=lfdr.de];
	DKIM_TRACE(0.00)[huawei.com:+];
	ASN(0.00)[asn:63949, ipnet:2600:3c04::/32, country:SG];
	TO_DN_SOME(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[gongfan1@huawei.com,netdev@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	NEURAL_HAM(-0.00)[-0.997];
	RCVD_COUNT_FIVE(0.00)[6];
	TAGGED_RCPT(0.00)[netdev];
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns,h-partners.com:mid,h-partners.com:email,huawei.com:email,huawei.com:dkim]
X-Rspamd-Queue-Id: 17788187915
X-Rspamd-Action: no action

Co-developed-by: Zhu Yikai <zhuyikai1@h-partners.com>
Signed-off-by: Zhu Yikai <zhuyikai1@h-partners.com>
Signed-off-by: Fan Gong <gongfan1@huawei.com>
---
 .../ethernet/huawei/hinic3/hinic3_ethtool.c   | 275 ++++++++++++++++++
 1 file changed, 275 insertions(+)

diff --git a/drivers/net/ethernet/huawei/hinic3/hinic3_ethtool.c b/drivers/net/ethernet/huawei/hinic3/hinic3_ethtool.c
index ea0b2df73e9f..b8aee18fac8f 100644
--- a/drivers/net/ethernet/huawei/hinic3/hinic3_ethtool.c
+++ b/drivers/net/ethernet/huawei/hinic3/hinic3_ethtool.c
@@ -17,6 +17,12 @@
 #include "hinic3_nic_cfg.h"
 
 #define HINIC3_MGMT_VERSION_MAX_LEN     32
+#define COALESCE_ALL_QUEUE              0xFFFF
+/* Coalesce time properties in milliseconds */
+#define COALESCE_PENDING_LIMIT_UNIT     8
+#define COALESCE_TIMER_CFG_UNIT         5
+#define COALESCE_MAX_PENDING_LIMIT      (255 * COALESCE_PENDING_LIMIT_UNIT)
+#define COALESCE_MAX_TIMER_CFG          (255 * COALESCE_TIMER_CFG_UNIT)
 
 static void hinic3_get_drvinfo(struct net_device *netdev,
 			       struct ethtool_drvinfo *info)
@@ -912,6 +918,273 @@ static void hinic3_get_strings(struct net_device *netdev,
 	}
 }
 
+static int hinic3_set_queue_coalesce(struct net_device *netdev, u16 q_id,
+				     struct hinic3_intr_coal_info *coal)
+{
+	struct hinic3_nic_dev *nic_dev = netdev_priv(netdev);
+	struct hinic3_intr_coal_info *intr_coal;
+	struct hinic3_interrupt_info info = {};
+	int err;
+
+	intr_coal = &nic_dev->intr_coalesce[q_id];
+
+	intr_coal->coalesce_timer_cfg = coal->coalesce_timer_cfg;
+	intr_coal->pending_limit = coal->pending_limit;
+	intr_coal->rx_pending_limit_low = coal->rx_pending_limit_low;
+	intr_coal->rx_pending_limit_high = coal->rx_pending_limit_high;
+
+	if (!test_bit(HINIC3_INTF_UP, &nic_dev->flags) ||
+	    q_id >= nic_dev->q_params.num_qps || nic_dev->adaptive_rx_coal)
+		return 0;
+
+	info.msix_index = nic_dev->q_params.irq_cfg[q_id].msix_entry_idx;
+	info.interrupt_coalesc_set = 1;
+	info.coalesc_timer_cfg = intr_coal->coalesce_timer_cfg;
+	info.pending_limit = intr_coal->pending_limit;
+	info.resend_timer_cfg = intr_coal->resend_timer_cfg;
+	err = hinic3_set_interrupt_cfg(nic_dev->hwdev, info);
+	if (err) {
+		netdev_warn(netdev, "Failed to set queue%u coalesce\n", q_id);
+		return err;
+	}
+
+	return 0;
+}
+
+static int is_coalesce_exceed_limit(struct net_device *netdev,
+				    const struct ethtool_coalesce *coal)
+{
+	if (coal->rx_coalesce_usecs > COALESCE_MAX_TIMER_CFG) {
+		netdev_err(netdev, "rx_coalesce_usecs out of range %d-%d\n", 0,
+			   COALESCE_MAX_TIMER_CFG);
+		return -EOPNOTSUPP;
+	}
+
+	if (coal->rx_max_coalesced_frames > COALESCE_MAX_PENDING_LIMIT) {
+		netdev_err(netdev, "rx_max_coalesced_frames out of range %d-%d\n",
+			   0, COALESCE_MAX_PENDING_LIMIT);
+		return -EOPNOTSUPP;
+	}
+
+	if (coal->rx_coalesce_usecs_low > COALESCE_MAX_TIMER_CFG) {
+		netdev_err(netdev, "rx_coalesce_usecs_low out of range %d-%d\n",
+			   0, COALESCE_MAX_TIMER_CFG);
+		return -EOPNOTSUPP;
+	}
+
+	if (coal->rx_max_coalesced_frames_low > COALESCE_MAX_PENDING_LIMIT) {
+		netdev_err(netdev, "rx_max_coalesced_frames_low out of range %d-%d\n",
+			   0, COALESCE_MAX_PENDING_LIMIT);
+		return -EOPNOTSUPP;
+	}
+
+	if (coal->rx_coalesce_usecs_high > COALESCE_MAX_TIMER_CFG) {
+		netdev_err(netdev, "rx_coalesce_usecs_high out of range %d-%d\n",
+			   0, COALESCE_MAX_TIMER_CFG);
+		return -EOPNOTSUPP;
+	}
+
+	if (coal->rx_max_coalesced_frames_high > COALESCE_MAX_PENDING_LIMIT) {
+		netdev_err(netdev, "rx_max_coalesced_frames_high out of range %d-%d\n",
+			   0, COALESCE_MAX_PENDING_LIMIT);
+		return -EOPNOTSUPP;
+	}
+
+	return 0;
+}
+
+static int is_coalesce_legal(struct net_device *netdev,
+			     const struct ethtool_coalesce *coal)
+{
+	struct ethtool_coalesce tmp_coal = {};
+	int err;
+
+	if (coal->rx_coalesce_usecs != coal->tx_coalesce_usecs) {
+		netdev_err(netdev, "tx-usecs must be equal to rx-usecs\n");
+		return -EINVAL;
+	}
+
+	if (coal->rx_max_coalesced_frames != coal->tx_max_coalesced_frames) {
+		netdev_err(netdev, "tx-frames must be equal to rx-frames\n");
+		return -EINVAL;
+	}
+
+	tmp_coal.cmd = coal->cmd;
+	tmp_coal.rx_coalesce_usecs = coal->rx_coalesce_usecs;
+	tmp_coal.rx_max_coalesced_frames = coal->rx_max_coalesced_frames;
+	tmp_coal.tx_coalesce_usecs = coal->tx_coalesce_usecs;
+	tmp_coal.tx_max_coalesced_frames = coal->tx_max_coalesced_frames;
+	tmp_coal.use_adaptive_rx_coalesce = coal->use_adaptive_rx_coalesce;
+
+	tmp_coal.rx_coalesce_usecs_low = coal->rx_coalesce_usecs_low;
+	tmp_coal.rx_max_coalesced_frames_low =
+		coal->rx_max_coalesced_frames_low;
+
+	tmp_coal.rx_coalesce_usecs_high = coal->rx_coalesce_usecs_high;
+	tmp_coal.rx_max_coalesced_frames_high =
+		coal->rx_max_coalesced_frames_high;
+
+	if (memcmp(coal, &tmp_coal, sizeof(struct ethtool_coalesce))) {
+		netdev_err(netdev, "Only support to change rx/tx-usecs and rx/tx-frames\n");
+		return -EOPNOTSUPP;
+	}
+
+	err = is_coalesce_exceed_limit(netdev, coal);
+	if (err)
+		return err;
+
+	if (coal->rx_coalesce_usecs_low / COALESCE_TIMER_CFG_UNIT >=
+	    coal->rx_coalesce_usecs_high / COALESCE_TIMER_CFG_UNIT) {
+		netdev_err(netdev, "invalid coalesce usec high %u, low %u, unit %d\n",
+			   coal->rx_coalesce_usecs_high,
+			   coal->rx_coalesce_usecs_low,
+			   COALESCE_TIMER_CFG_UNIT);
+		return -EINVAL;
+	}
+
+	if (coal->rx_max_coalesced_frames_low / COALESCE_PENDING_LIMIT_UNIT >=
+	    coal->rx_max_coalesced_frames_high / COALESCE_PENDING_LIMIT_UNIT) {
+		netdev_err(netdev, "invalid coalesce frame high %u, low %u, unit %d\n",
+			   coal->rx_max_coalesced_frames_high,
+			   coal->rx_max_coalesced_frames_low,
+			   COALESCE_PENDING_LIMIT_UNIT);
+		return -EOPNOTSUPP;
+	}
+
+	return 0;
+}
+
+static void check_coalesce_align(struct net_device *netdev,
+				 u32 item, u32 unit, const char *str)
+{
+	if (item % unit)
+		netdev_warn(netdev, "%s in %d units, change to %u\n",
+			    str, unit, item - item % unit);
+}
+
+#define CHECK_COALESCE_ALIGN(member, unit) \
+	check_coalesce_align(netdev, member, unit, #member)
+
+static void check_coalesce_changed(struct net_device *netdev,
+				   u32 item, u32 unit, u32 ori_val,
+				   const char *obj_str, const char *str)
+{
+	if ((item / unit) != ori_val)
+		netdev_dbg(netdev, "Change %s from %d to %u %s\n",
+			   str, ori_val * unit, item - item % unit, obj_str);
+}
+
+#define CHECK_COALESCE_CHANGED(member, unit, ori_val, obj_str) \
+	check_coalesce_changed(netdev, member, unit, ori_val, obj_str, #member)
+
+static int hinic3_set_hw_coal_param(struct net_device *netdev,
+				    struct hinic3_intr_coal_info *intr_coal)
+{
+	struct hinic3_nic_dev *nic_dev = netdev_priv(netdev);
+	u16 i;
+
+	for (i = 0; i < nic_dev->max_qps; i++)
+		hinic3_set_queue_coalesce(netdev, i, intr_coal);
+
+	return 0;
+}
+
+static int hinic3_get_coalesce(struct net_device *netdev,
+			       struct ethtool_coalesce *coal,
+			       struct kernel_ethtool_coalesce *kernel_coal,
+			       struct netlink_ext_ack *extack)
+{
+	struct hinic3_nic_dev *nic_dev = netdev_priv(netdev);
+	struct hinic3_intr_coal_info *interrupt_info;
+
+	interrupt_info = &nic_dev->intr_coalesce[0];
+
+	coal->rx_coalesce_usecs = interrupt_info->coalesce_timer_cfg *
+				  COALESCE_TIMER_CFG_UNIT;
+	coal->rx_max_coalesced_frames = interrupt_info->pending_limit *
+					COALESCE_PENDING_LIMIT_UNIT;
+
+	/* tx/rx use the same interrupt */
+	coal->tx_coalesce_usecs = coal->rx_coalesce_usecs;
+	coal->tx_max_coalesced_frames = coal->rx_max_coalesced_frames;
+	coal->use_adaptive_rx_coalesce = nic_dev->adaptive_rx_coal;
+
+	coal->rx_max_coalesced_frames_high =
+		interrupt_info->rx_pending_limit_high *
+		COALESCE_PENDING_LIMIT_UNIT;
+
+	coal->rx_max_coalesced_frames_low =
+		interrupt_info->rx_pending_limit_low *
+		COALESCE_PENDING_LIMIT_UNIT;
+
+	return 0;
+}
+
+static int hinic3_set_coalesce(struct net_device *netdev,
+			       struct ethtool_coalesce *coal,
+			       struct kernel_ethtool_coalesce *kernel_coal,
+			       struct netlink_ext_ack *extack)
+{
+	struct hinic3_nic_dev *nic_dev = netdev_priv(netdev);
+	struct hinic3_intr_coal_info *ori_intr_coal;
+	struct hinic3_intr_coal_info intr_coal = {};
+	char obj_str[32];
+	int err;
+
+	err = is_coalesce_legal(netdev, coal);
+	if (err)
+		return err;
+
+	CHECK_COALESCE_ALIGN(coal->rx_coalesce_usecs, COALESCE_TIMER_CFG_UNIT);
+	CHECK_COALESCE_ALIGN(coal->rx_max_coalesced_frames,
+			     COALESCE_PENDING_LIMIT_UNIT);
+	CHECK_COALESCE_ALIGN(coal->rx_coalesce_usecs_high,
+			     COALESCE_TIMER_CFG_UNIT);
+	CHECK_COALESCE_ALIGN(coal->rx_max_coalesced_frames_high,
+			     COALESCE_PENDING_LIMIT_UNIT);
+	CHECK_COALESCE_ALIGN(coal->rx_coalesce_usecs_low,
+			     COALESCE_TIMER_CFG_UNIT);
+	CHECK_COALESCE_ALIGN(coal->rx_max_coalesced_frames_low,
+			     COALESCE_PENDING_LIMIT_UNIT);
+
+	ori_intr_coal = &nic_dev->intr_coalesce[0];
+	snprintf(obj_str, sizeof(obj_str), "for netdev");
+
+	CHECK_COALESCE_CHANGED(coal->rx_coalesce_usecs, COALESCE_TIMER_CFG_UNIT,
+			       ori_intr_coal->coalesce_timer_cfg, obj_str);
+	CHECK_COALESCE_CHANGED(coal->rx_max_coalesced_frames,
+			       COALESCE_PENDING_LIMIT_UNIT,
+			       ori_intr_coal->pending_limit, obj_str);
+	CHECK_COALESCE_CHANGED(coal->rx_max_coalesced_frames_high,
+			       COALESCE_PENDING_LIMIT_UNIT,
+			       ori_intr_coal->rx_pending_limit_high, obj_str);
+	CHECK_COALESCE_CHANGED(coal->rx_max_coalesced_frames_low,
+			       COALESCE_PENDING_LIMIT_UNIT,
+			       ori_intr_coal->rx_pending_limit_low, obj_str);
+
+	intr_coal.coalesce_timer_cfg =
+		(u8)(coal->rx_coalesce_usecs / COALESCE_TIMER_CFG_UNIT);
+	intr_coal.pending_limit = (u8)(coal->rx_max_coalesced_frames /
+				      COALESCE_PENDING_LIMIT_UNIT);
+
+	nic_dev->adaptive_rx_coal = coal->use_adaptive_rx_coalesce;
+
+	intr_coal.rx_pending_limit_high =
+		(u8)(coal->rx_max_coalesced_frames_high /
+		     COALESCE_PENDING_LIMIT_UNIT);
+
+	intr_coal.rx_pending_limit_low =
+		(u8)(coal->rx_max_coalesced_frames_low /
+		     COALESCE_PENDING_LIMIT_UNIT);
+
+	/* coalesce timer or pending set to zero will disable coalesce */
+	if (!nic_dev->adaptive_rx_coal &&
+	    (!intr_coal.coalesce_timer_cfg || !intr_coal.pending_limit))
+		netdev_warn(netdev, "Coalesce will be disabled\n");
+
+	return hinic3_set_hw_coal_param(netdev, &intr_coal);
+}
+
 static const struct ethtool_ops hinic3_ethtool_ops = {
 	.supported_coalesce_params      = ETHTOOL_COALESCE_USECS |
 					  ETHTOOL_COALESCE_PKT_RATE_RX_USECS,
@@ -925,6 +1198,8 @@ static const struct ethtool_ops hinic3_ethtool_ops = {
 	.get_sset_count                 = hinic3_get_sset_count,
 	.get_ethtool_stats              = hinic3_get_ethtool_stats,
 	.get_strings                    = hinic3_get_strings,
+	.get_coalesce                   = hinic3_get_coalesce,
+	.set_coalesce                   = hinic3_set_coalesce,
 };
 
 void hinic3_set_ethtool_ops(struct net_device *netdev)
-- 
2.43.0


