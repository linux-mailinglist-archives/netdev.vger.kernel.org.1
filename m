Return-Path: <netdev+bounces-302496-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id lx7nIvwiQmpP0wkAu9opvQ
	(envelope-from <netdev+bounces-302496-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Mon, 29 Jun 2026 09:47:08 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id DE0736D7263
	for <lists+netdev@lfdr.de>; Mon, 29 Jun 2026 09:47:07 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=huawei.com header.s=dkim header.b=tydsi2KZ;
	spf=pass (mail.lfdr.de: domain of "netdev+bounces-302496-lists+netdev=lfdr.de@vger.kernel.org" designates 172.234.253.10 as permitted sender) smtp.mailfrom="netdev+bounces-302496-lists+netdev=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=quarantine) header.from=huawei.com;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 61B62315F15C
	for <lists+netdev@lfdr.de>; Mon, 29 Jun 2026 07:39:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 55CFE3D79E8;
	Mon, 29 Jun 2026 07:38:16 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from canpmsgout12.his.huawei.com (canpmsgout12.his.huawei.com [113.46.200.227])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0627935838A;
	Mon, 29 Jun 2026 07:38:09 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782718695; cv=none; b=JXs6YxoH9QdXkTAQ2sHPuOnBZzhgEA2/tB/I6gNfjRL0jkVwYjrjv9CsYqxZ49/g/NmeBJCjAMc1e/NhEvrCwf6mYkw6zaFRYre2OGnCS7xX598Ym0D6yrJ6Fj7SQabo3Ic9QLE7vGn7/KV9gd2G6owZGWOBnjSq2SDL0sqaxIk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782718695; c=relaxed/simple;
	bh=dnApTbUirfr3HNUZOvwFpuH407Ds6rbI0B7x1cFmAWY=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=IwbJNddzr7okt8DHy367Op90n4qrk8u3yzxb8fQII+c9oCNfu7/FzhqT82pj1xD8DrKzukQSlTtlIuwHr6mwWmxruDq/Nj33sBDwqHUkA+WBfWK2nskMkN99hToNEfVgaFlPzucp4TxxBnkb7JuwD4aCVf92i6KuH9yDBflxWwI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=huawei.com; dkim=pass (1024-bit key) header.d=huawei.com header.i=@huawei.com header.b=tydsi2KZ; arc=none smtp.client-ip=113.46.200.227
dkim-signature: v=1; a=rsa-sha256; d=huawei.com; s=dkim;
	c=relaxed/relaxed; q=dns/txt;
	h=From;
	bh=piaIOpSJNUh0uSzILK/YryjLONtZSYDL4biQng1Yy7s=;
	b=tydsi2KZPtc/ifpa5/Gx31iAOo1/7IfmaaIUXHAx605j1m2xCdAGc3uFpfVWKLC7tl0zV/J13
	79u+tjAQHj19lZ4fjVwL7LIw2zCtmhcNwpetARLZ8o/FBopKgN+sWPAPk2DUo04pbbKr/pTK5oK
	+PN7DU/wlA39EFh5JPLrwh8=
Received: from mail.maildlp.com (unknown [172.19.163.163])
	by canpmsgout12.his.huawei.com (SkyGuard) with ESMTPS id 4gpdFX4lSbznTwY;
	Mon, 29 Jun 2026 15:29:20 +0800 (CST)
Received: from kwepemf100013.china.huawei.com (unknown [7.202.181.12])
	by mail.maildlp.com (Postfix) with ESMTPS id C99C64048B;
	Mon, 29 Jun 2026 15:38:01 +0800 (CST)
Received: from DESKTOP-62GVMTR.china.huawei.com (10.174.189.124) by
 kwepemf100013.china.huawei.com (7.202.181.12) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.36; Mon, 29 Jun 2026 15:38:00 +0800
From: Fan Gong <gongfan1@huawei.com>
To: Fan Gong <gongfan1@huawei.com>, Wu Di <wudi234@huawei.com>, Teng Peisen
	<tengpeisen@huawei.com>, <netdev@vger.kernel.org>, "David S. Miller"
	<davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, Jakub Kicinski
	<kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, Simon Horman
	<horms@kernel.org>, Andrew Lunn <andrew+netdev@lunn.ch>, Ioana Ciornei
	<ioana.ciornei@nxp.com>, Mohsin Bashir <mohsin.bashr@gmail.com>, Dimitri
 Daskalakis <dimitri.daskalakis1@gmail.com>, Harshitha Ramamurthy
	<hramamurthy@google.com>
CC: <linux-kernel@vger.kernel.org>, <linux-doc@vger.kernel.org>, luosifu
	<luosifu@huawei.com>, Xin Guo <guoxin09@huawei.com>, Zhou Shuai
	<zhoushuai28@huawei.com>, Wu Like <wulike1@huawei.com>, Shi Jing
	<shijing34@huawei.com>, Zheng Jiezhen <zhengjiezhen@h-partners.com>, Maxime
 Chevallier <maxime.chevallier@bootlin.com>
Subject: [PATCH net-next v10 3/5] hinic3: Add ethtool coalesce ops
Date: Mon, 29 Jun 2026 15:37:44 +0800
Message-ID: <f7615c9d656d705125a09a2268110e1ac14d17e2.1782718232.git.wudi234@huawei.com>
X-Mailer: git-send-email 2.50.1.windows.1
In-Reply-To: <cover.1782718232.git.wudi234@huawei.com>
References: <cover.1782718232.git.wudi234@huawei.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: kwepems100002.china.huawei.com (7.221.188.206) To
 kwepemf100013.china.huawei.com (7.202.181.12)
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-7.16 / 15.00];
	WHITELIST_DMARC(-7.00)[huawei.com:D:+];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[huawei.com,quarantine];
	R_DKIM_ALLOW(-0.20)[huawei.com:s=dkim];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCPT_COUNT_TWELVE(0.00)[23];
	TAGGED_FROM(0.00)[bounces-302496-lists,netdev=lfdr.de];
	FREEMAIL_TO(0.00)[huawei.com,vger.kernel.org,davemloft.net,google.com,kernel.org,redhat.com,lunn.ch,nxp.com,gmail.com];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	FORWARDED(0.00)[lists@lfdr.de];
	FORGED_RECIPIENTS(0.00)[m:gongfan1@huawei.com,m:wudi234@huawei.com,m:tengpeisen@huawei.com,m:netdev@vger.kernel.org,m:davem@davemloft.net,m:edumazet@google.com,m:kuba@kernel.org,m:pabeni@redhat.com,m:horms@kernel.org,m:andrew+netdev@lunn.ch,m:ioana.ciornei@nxp.com,m:mohsin.bashr@gmail.com,m:dimitri.daskalakis1@gmail.com,m:hramamurthy@google.com,m:linux-kernel@vger.kernel.org,m:linux-doc@vger.kernel.org,m:luosifu@huawei.com,m:guoxin09@huawei.com,m:zhoushuai28@huawei.com,m:wulike1@huawei.com,m:shijing34@huawei.com,m:zhengjiezhen@h-partners.com,m:maxime.chevallier@bootlin.com,m:andrew@lunn.ch,m:mohsinbashr@gmail.com,m:dimitridaskalakis1@gmail.com,s:lists@lfdr.de];
	FORGED_SENDER(0.00)[gongfan1@huawei.com,netdev@vger.kernel.org];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[gongfan1@huawei.com,netdev@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[huawei.com:+];
	RCVD_COUNT_FIVE(0.00)[6];
	MID_RHS_MATCH_FROM(0.00)[];
	TO_DN_SOME(0.00)[];
	ALIAS_RESOLVED(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[vger.kernel.org:from_smtp,sea.lore.kernel.org:rdns,sea.lore.kernel.org:helo]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: DE0736D7263

  Implement following ethtool callback function:
.get_coalesce
.set_coalesce

  These callbacks allow users to utilize ethtool for detailed
RX coalesce configuration and monitoring.

Co-developed-by: Wu Di <wudi234@huawei.com>
Signed-off-by: Wu Di <wudi234@huawei.com>
Co-developed-by: Teng Peisen <tengpeisen@huawei.com>
Signed-off-by: Teng Peisen <tengpeisen@huawei.com>
Signed-off-by: Fan Gong <gongfan1@huawei.com>
---
 .../ethernet/huawei/hinic3/hinic3_ethtool.c   | 286 +++++++++++++++++-
 .../net/ethernet/huawei/hinic3/hinic3_irq.c   |  15 +-
 2 files changed, 296 insertions(+), 5 deletions(-)

diff --git a/drivers/net/ethernet/huawei/hinic3/hinic3_ethtool.c b/drivers/net/ethernet/huawei/hinic3/hinic3_ethtool.c
index 0e1f83806933..c329f1c62f0e 100644
--- a/drivers/net/ethernet/huawei/hinic3/hinic3_ethtool.c
+++ b/drivers/net/ethernet/huawei/hinic3/hinic3_ethtool.c
@@ -18,6 +18,11 @@
 #include "hinic3_nic_cfg.h"
 
 #define HINIC3_MGMT_VERSION_MAX_LEN     32
+/* Coalesce time properties in microseconds */
+#define COALESCE_PENDING_LIMIT_UNIT     8
+#define COALESCE_TIMER_CFG_UNIT         5
+#define COALESCE_MAX_PENDING_LIMIT      (255 * COALESCE_PENDING_LIMIT_UNIT)
+#define COALESCE_MAX_TIMER_CFG          (255 * COALESCE_TIMER_CFG_UNIT)
 
 static void hinic3_get_drvinfo(struct net_device *netdev,
 			       struct ethtool_drvinfo *info)
@@ -973,9 +978,284 @@ static void hinic3_get_pause_stats(struct net_device *netdev,
 	kfree(ps);
 }
 
+static int hinic3_set_queue_coalesce(struct net_device *netdev, u16 q_id,
+				     struct hinic3_intr_coal_info *coal,
+				     struct netlink_ext_ack *extack)
+{
+	struct hinic3_nic_dev *nic_dev = netdev_priv(netdev);
+	struct hinic3_intr_coal_info *intr_coal;
+	struct hinic3_intr_coal_info old_coal;
+	struct hinic3_interrupt_info info = {};
+	int err;
+
+	mutex_lock(&nic_dev->state_lock);
+	intr_coal = &nic_dev->intr_coalesce[q_id];
+	old_coal = *intr_coal;
+
+	intr_coal->coalesce_timer_cfg = coal->coalesce_timer_cfg;
+	intr_coal->pending_limit = coal->pending_limit;
+	intr_coal->rx_pending_limit_low = coal->rx_pending_limit_low;
+	intr_coal->rx_pending_limit_high = coal->rx_pending_limit_high;
+
+	info.resend_timer_cfg = intr_coal->resend_timer_cfg;
+	mutex_unlock(&nic_dev->state_lock);
+
+	if (!test_bit(HINIC3_INTF_UP, &nic_dev->flags) ||
+	    q_id >= nic_dev->q_params.num_qps)
+		return 0;
+
+	info.msix_index = nic_dev->q_params.irq_cfg[q_id].msix_entry_idx;
+	info.interrupt_coalesc_set = 1;
+
+	info.coalesc_timer_cfg = coal->coalesce_timer_cfg;
+	info.pending_limit = coal->pending_limit;
+
+	mutex_lock(&nic_dev->state_lock);
+	err = hinic3_set_interrupt_cfg(nic_dev->hwdev, info);
+	mutex_unlock(&nic_dev->state_lock);
+
+	if (err) {
+		NL_SET_ERR_MSG_FMT_MOD(extack, "Failed to set queue%u coalesce",
+				       q_id);
+		mutex_lock(&nic_dev->state_lock);
+		*intr_coal = old_coal;
+		mutex_unlock(&nic_dev->state_lock);
+		return err;
+	}
+
+	return 0;
+}
+
+static int is_coalesce_exceed_limit(const struct ethtool_coalesce *coal,
+				    struct netlink_ext_ack *extack)
+{
+	const struct {
+		const char *name;
+		u32 value;
+		u32 limit;
+	} coalesce_limits[] = {
+		{"rx_coalesce_usecs",
+		 coal->rx_coalesce_usecs,
+		 COALESCE_MAX_TIMER_CFG},
+		{"rx_max_coalesced_frames",
+		 coal->rx_max_coalesced_frames,
+		 COALESCE_MAX_PENDING_LIMIT},
+		{"rx_max_coalesced_frames_low",
+		 coal->rx_max_coalesced_frames_low,
+		 COALESCE_MAX_PENDING_LIMIT},
+		{"rx_max_coalesced_frames_high",
+		 coal->rx_max_coalesced_frames_high,
+		 COALESCE_MAX_PENDING_LIMIT},
+	};
+
+	for (int i = 0; i < ARRAY_SIZE(coalesce_limits); i++) {
+		if (coalesce_limits[i].value > coalesce_limits[i].limit) {
+			NL_SET_ERR_MSG_FMT_MOD(extack,
+					       "%s out of range %d-%d",
+					       coalesce_limits[i].name,
+					       0,
+					       coalesce_limits[i].limit);
+			return -ERANGE;
+		}
+	}
+	return 0;
+}
+
+static int is_coalesce_legal(const struct ethtool_coalesce *coal,
+			     struct netlink_ext_ack *extack)
+{
+	int err;
+
+	err = is_coalesce_exceed_limit(coal, extack);
+	if (err)
+		return err;
+
+	if (coal->rx_max_coalesced_frames_low >
+	    coal->rx_max_coalesced_frames_high) {
+		NL_SET_ERR_MSG_FMT_MOD(extack,
+				       "invalid coalesce frame high %u, low %u",
+				       coal->rx_max_coalesced_frames_high,
+				       coal->rx_max_coalesced_frames_low);
+		return -ERANGE;
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
+				    struct hinic3_intr_coal_info *intr_coal,
+				    struct netlink_ext_ack *extack)
+{
+	struct hinic3_nic_dev *nic_dev = netdev_priv(netdev);
+	int err;
+	u16 i;
+
+	for (i = 0; i < nic_dev->max_qps; i++) {
+		err = hinic3_set_queue_coalesce(netdev, i, intr_coal, extack);
+		if (err)
+			return err;
+	}
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
+	coal->use_adaptive_rx_coalesce = nic_dev->adaptive_rx_coal;
+
+	mutex_lock(&nic_dev->state_lock);
+
+	coal->rx_max_coalesced_frames_low =
+		interrupt_info->rx_pending_limit_low *
+		COALESCE_PENDING_LIMIT_UNIT;
+
+	coal->rx_max_coalesced_frames_high =
+		interrupt_info->rx_pending_limit_high *
+		COALESCE_PENDING_LIMIT_UNIT;
+
+	/* TX/RX uses the same interrupt.
+	 * So we only declare RX ethtool_coalesce parameters.
+	 */
+	coal->rx_coalesce_usecs = interrupt_info->coalesce_timer_cfg *
+				  COALESCE_TIMER_CFG_UNIT;
+
+	coal->rx_max_coalesced_frames = interrupt_info->pending_limit *
+					COALESCE_PENDING_LIMIT_UNIT;
+
+	mutex_unlock(&nic_dev->state_lock);
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
+	const char *obj_str = "for netdev";
+	bool old_adaptive, new_adaptive;
+	bool dim_stopped = false;
+	int err;
+	int i;
+
+	err = is_coalesce_legal(coal, extack);
+	if (err)
+		return err;
+
+	CHECK_COALESCE_ALIGN(coal->rx_coalesce_usecs, COALESCE_TIMER_CFG_UNIT);
+	CHECK_COALESCE_ALIGN(coal->rx_max_coalesced_frames,
+			     COALESCE_PENDING_LIMIT_UNIT);
+	CHECK_COALESCE_ALIGN(coal->rx_max_coalesced_frames_high,
+			     COALESCE_PENDING_LIMIT_UNIT);
+	CHECK_COALESCE_ALIGN(coal->rx_max_coalesced_frames_low,
+			     COALESCE_PENDING_LIMIT_UNIT);
+
+	ori_intr_coal = &nic_dev->intr_coalesce[0];
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
+	old_adaptive = READ_ONCE(nic_dev->adaptive_rx_coal);
+	new_adaptive = !!coal->use_adaptive_rx_coalesce;
+
+	if (old_adaptive) {
+		WRITE_ONCE(nic_dev->adaptive_rx_coal, false);
+
+		synchronize_net();
+
+		for (i = 0; i < nic_dev->q_params.num_qps; i++) {
+			if (!nic_dev->q_params.irq_cfg[i].rxq)
+				continue;
+
+			cancel_work_sync(&nic_dev->q_params.irq_cfg[i].rxq
+					 ->dim.work);
+		}
+
+		dim_stopped = true;
+	}
+
+	intr_coal.coalesce_timer_cfg =
+		(u8)(coal->rx_coalesce_usecs / COALESCE_TIMER_CFG_UNIT);
+
+	intr_coal.pending_limit =
+		(u8)(coal->rx_max_coalesced_frames /
+		     COALESCE_PENDING_LIMIT_UNIT);
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
+	if (!new_adaptive &&
+	    (!intr_coal.coalesce_timer_cfg || !intr_coal.pending_limit))
+		netdev_info(netdev, "Coalesce will be disabled\n");
+
+	err = hinic3_set_hw_coal_param(netdev, &intr_coal, extack);
+	if (err) {
+		if (dim_stopped)
+			WRITE_ONCE(nic_dev->adaptive_rx_coal, old_adaptive);
+
+		return err;
+	}
+
+	WRITE_ONCE(nic_dev->adaptive_rx_coal, new_adaptive);
+
+	return 0;
+}
+
 static const struct ethtool_ops hinic3_ethtool_ops = {
-	.supported_coalesce_params      = ETHTOOL_COALESCE_USECS |
-					  ETHTOOL_COALESCE_PKT_RATE_RX_USECS,
+	.supported_coalesce_params      = ETHTOOL_COALESCE_RX_USECS |
+					  ETHTOOL_COALESCE_RX_MAX_FRAMES |
+					  ETHTOOL_COALESCE_USE_ADAPTIVE_RX |
+					  ETHTOOL_COALESCE_RX_MAX_FRAMES_LOW |
+					  ETHTOOL_COALESCE_RX_MAX_FRAMES_HIGH,
 	.get_link_ksettings             = hinic3_get_link_ksettings,
 	.get_drvinfo                    = hinic3_get_drvinfo,
 	.get_msglevel                   = hinic3_get_msglevel,
@@ -991,6 +1271,8 @@ static const struct ethtool_ops hinic3_ethtool_ops = {
 	.get_eth_ctrl_stats             = hinic3_get_eth_ctrl_stats,
 	.get_rmon_stats                 = hinic3_get_rmon_stats,
 	.get_pause_stats                = hinic3_get_pause_stats,
+	.get_coalesce                   = hinic3_get_coalesce,
+	.set_coalesce                   = hinic3_set_coalesce,
 };
 
 void hinic3_set_ethtool_ops(struct net_device *netdev)
diff --git a/drivers/net/ethernet/huawei/hinic3/hinic3_irq.c b/drivers/net/ethernet/huawei/hinic3/hinic3_irq.c
index 5479c235e3de..4e3b8e3c31f9 100644
--- a/drivers/net/ethernet/huawei/hinic3/hinic3_irq.c
+++ b/drivers/net/ethernet/huawei/hinic3/hinic3_irq.c
@@ -101,10 +101,14 @@ static int hinic3_request_irq(struct hinic3_irq_cfg *irq_cfg, u16 q_id)
 
 	info.msix_index = irq_cfg->msix_entry_idx;
 	info.interrupt_coalesc_set = 1;
+
+	mutex_lock(&nic_dev->state_lock);
 	info.pending_limit = nic_dev->intr_coalesce[q_id].pending_limit;
 	info.coalesc_timer_cfg =
 		nic_dev->intr_coalesce[q_id].coalesce_timer_cfg;
 	info.resend_timer_cfg = nic_dev->intr_coalesce[q_id].resend_timer_cfg;
+	mutex_unlock(&nic_dev->state_lock);
+
 	err = hinic3_set_interrupt_cfg(nic_dev->hwdev, info);
 	if (err) {
 		netdev_err(netdev, "Failed to set RX interrupt coalescing attribute.\n");
@@ -169,17 +173,22 @@ static int hinic3_set_interrupt_moder(struct net_device *netdev, u16 q_id,
 static void hinic3_update_queue_coal(struct net_device *netdev, u16 q_id,
 				     u16 coal_timer, u16 coal_pkts)
 {
+	u8 coalesc_timer_cfg, pending_limit, limit_low, limit_high;
 	struct hinic3_intr_coal_info *q_coal;
-	u8 coalesc_timer_cfg, pending_limit;
 	struct hinic3_nic_dev *nic_dev;
 
 	nic_dev = netdev_priv(netdev);
 
 	q_coal = &nic_dev->intr_coalesce[q_id];
 	coalesc_timer_cfg = (u8)coal_timer;
+
+	mutex_lock(&nic_dev->state_lock);
+	limit_low = q_coal->rx_pending_limit_low;
+	limit_high = q_coal->rx_pending_limit_high;
+	mutex_unlock(&nic_dev->state_lock);
+
 	pending_limit = clamp_t(u8, coal_pkts >> HINIC3_COAL_PKT_SHIFT,
-				q_coal->rx_pending_limit_low,
-				q_coal->rx_pending_limit_high);
+				limit_low, limit_high);
 
 	hinic3_set_interrupt_moder(nic_dev->netdev, q_id,
 				   coalesc_timer_cfg, pending_limit);
-- 
2.43.0


