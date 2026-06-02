Return-Path: <netdev+bounces-294222-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id kqw9MxHeHmoXWwAAu9opvQ
	(envelope-from <netdev+bounces-294222-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Tue, 02 Jun 2026 15:43:45 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 6986762E9A4
	for <lists+netdev@lfdr.de>; Tue, 02 Jun 2026 15:43:45 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=huawei.com header.s=dkim header.b=lvcEZHdd;
	spf=pass (mail.lfdr.de: domain of "netdev+bounces-294222-lists+netdev=lfdr.de@vger.kernel.org" designates 2600:3c04:e001:36c::12fc:5321 as permitted sender) smtp.mailfrom="netdev+bounces-294222-lists+netdev=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=quarantine) header.from=huawei.com;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 5618B30BCDDB
	for <lists+netdev@lfdr.de>; Tue,  2 Jun 2026 13:34:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 341F63E716D;
	Tue,  2 Jun 2026 13:33:59 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from canpmsgout09.his.huawei.com (canpmsgout09.his.huawei.com [113.46.200.224])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3455125B08D;
	Tue,  2 Jun 2026 13:33:55 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780407239; cv=none; b=i8BgqQgDC8SYAp6DzztkAylKVYl0NeyWPT+crX5ZLEHVSOA7kU6pHMNfG/VRo7mqqCwPBfZXWwfJSVGZ1/QicajyNyzk6cJHKFOjCXC4+CFeUDuEQIfwdI1Rn/wTeqT6QSvkkjrDJneGPmFxcj+HGrUq6NJxHmM5jBT6r7JtahY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780407239; c=relaxed/simple;
	bh=kpt2CIVm4XiZ4lFt8mZDT7KnPdP1u9eojXxuAWokgYw=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=EzQMA20eFiF4vMTyJ7+hjam6bf5IV+E9ZQert171YNP0lofOSrsETalUPfXpi0JV9KkktgyjFkjOO4rpI1zURw+nW0wET75ZZcxH1fJ3xkgQUXaZSMkNWAubYKSCqaPBnvxraTbc+CiQpH/hsIaxr/vYLB5QQxwor/OeMj3O8Eo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=huawei.com; dkim=pass (1024-bit key) header.d=huawei.com header.i=@huawei.com header.b=lvcEZHdd; arc=none smtp.client-ip=113.46.200.224
dkim-signature: v=1; a=rsa-sha256; d=huawei.com; s=dkim;
	c=relaxed/relaxed; q=dns/txt;
	h=From;
	bh=7z2ar325Z2FJrKCwh3XF42GRH5+Ob/JuqiVJlt5E4hA=;
	b=lvcEZHddms9RVJSzTPNi8mcBgJ9ul/QNEQO2f8kFEuAZFin1xsHFEJqmkeHvHrRz2DIQsjNON
	yRNbLHx9aFsXiPimiqjalFJ4gYRqk/7MIQn2IDYxf65+4EnV2fLDpN07Y5efsDJu131k+ANMZck
	S3lpPoxaCKpIDGPMjT9r7UQ=
Received: from mail.maildlp.com (unknown [172.19.163.127])
	by canpmsgout09.his.huawei.com (SkyGuard) with ESMTPS id 4gVBRZ5bZzz1cynJ;
	Tue,  2 Jun 2026 21:26:02 +0800 (CST)
Received: from kwepemk100013.china.huawei.com (unknown [7.202.194.61])
	by mail.maildlp.com (Postfix) with ESMTPS id 0374D402AB;
	Tue,  2 Jun 2026 21:33:51 +0800 (CST)
Received: from localhost.huawei.com (10.90.31.46) by
 kwepemk100013.china.huawei.com (7.202.194.61) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.36; Tue, 2 Jun 2026 21:33:50 +0800
From: Jijie Shao <shaojijie@huawei.com>
To: <davem@davemloft.net>, <edumazet@google.com>, <kuba@kernel.org>,
	<pabeni@redhat.com>, <andrew+netdev@lunn.ch>, <horms@kernel.org>
CC: <shenjian15@huawei.com>, <liuyonglong@huawei.com>,
	<chenhao418@huawei.com>, <huangdonghua3@h-partners.com>,
	<yangshuaisong@h-partners.com>, <netdev@vger.kernel.org>,
	<linux-kernel@vger.kernel.org>, <shaojijie@huawei.com>
Subject: [PATCH V3 net-next 5/6] net: hns3: debugfs support for dumping fd rules
Date: Tue, 2 Jun 2026 21:33:36 +0800
Message-ID: <20260602133337.2216918-6-shaojijie@huawei.com>
X-Mailer: git-send-email 2.33.0
In-Reply-To: <20260602133337.2216918-1-shaojijie@huawei.com>
References: <20260602133337.2216918-1-shaojijie@huawei.com>
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
X-Spamd-Result: default: False [0.84 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_CONTAINS_FROM(1.00)[];
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[huawei.com,quarantine];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c04:e001:36c::/64:c];
	R_DKIM_ALLOW(-0.20)[huawei.com:s=dkim];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FORWARDED(0.00)[lists@lfdr.de];
	MIME_TRACE(0.00)[0:+];
	RCVD_TLS_LAST(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	TAGGED_FROM(0.00)[bounces-294222-lists,netdev=lfdr.de];
	FORGED_SENDER(0.00)[shaojijie@huawei.com,netdev@vger.kernel.org];
	FORGED_RECIPIENTS(0.00)[m:davem@davemloft.net,m:edumazet@google.com,m:kuba@kernel.org,m:pabeni@redhat.com,m:andrew+netdev@lunn.ch,m:horms@kernel.org,m:shenjian15@huawei.com,m:liuyonglong@huawei.com,m:chenhao418@huawei.com,m:huangdonghua3@h-partners.com,m:yangshuaisong@h-partners.com,m:netdev@vger.kernel.org,m:linux-kernel@vger.kernel.org,m:shaojijie@huawei.com,m:andrew@lunn.ch,s:lists@lfdr.de];
	DKIM_TRACE(0.00)[huawei.com:+];
	ASN(0.00)[asn:63949, ipnet:2600:3c04::/32, country:SG];
	RCPT_COUNT_TWELVE(0.00)[14];
	PRECEDENCE_BULK(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[shaojijie@huawei.com,netdev@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCVD_COUNT_FIVE(0.00)[6];
	ALIAS_RESOLVED(0.00)[];
	TO_DN_NONE(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[vger.kernel.org:from_smtp,tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns,huawei.com:mid,huawei.com:dkim,huawei.com:from_mime,huawei.com:email]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 6986762E9A4

Currently, the tc tool only supports adding and deleting rules from
the driver but does not support querying rules from the driver.

This patch adds a rule dump file in debugfs to check whether the driver's
configuration matches the configuration issued by tc flow.

Signed-off-by: Jijie Shao <shaojijie@huawei.com>
---
 drivers/net/ethernet/hisilicon/hns3/hnae3.h   |   1 +
 .../ethernet/hisilicon/hns3/hns3_debugfs.c    |   6 +
 .../hisilicon/hns3/hns3pf/hclge_debugfs.c     | 145 ++++++++++++++++++
 3 files changed, 152 insertions(+)

diff --git a/drivers/net/ethernet/hisilicon/hns3/hnae3.h b/drivers/net/ethernet/hisilicon/hns3/hnae3.h
index a724935b655a..a8798eecd9fb 100644
--- a/drivers/net/ethernet/hisilicon/hns3/hnae3.h
+++ b/drivers/net/ethernet/hisilicon/hns3/hnae3.h
@@ -331,6 +331,7 @@ enum hnae3_dbg_cmd {
 	HNAE3_DBG_CMD_TX_QUEUE_INFO,
 	HNAE3_DBG_CMD_FD_TCAM,
 	HNAE3_DBG_CMD_FD_COUNTER,
+	HNAE3_DBG_CMD_FD_RULE,
 	HNAE3_DBG_CMD_MAC_TNL_STATUS,
 	HNAE3_DBG_CMD_SERV_INFO,
 	HNAE3_DBG_CMD_UMV_INFO,
diff --git a/drivers/net/ethernet/hisilicon/hns3/hns3_debugfs.c b/drivers/net/ethernet/hisilicon/hns3/hns3_debugfs.c
index 4cce4f4ba6b0..1347edac7699 100644
--- a/drivers/net/ethernet/hisilicon/hns3/hns3_debugfs.c
+++ b/drivers/net/ethernet/hisilicon/hns3/hns3_debugfs.c
@@ -273,6 +273,12 @@ static struct hns3_dbg_cmd_info hns3_dbg_cmd[] = {
 		.dentry = HNS3_DBG_DENTRY_FD,
 		.init = hns3_dbg_common_init_t2,
 	},
+	{
+		.name = "fd_rule",
+		.cmd = HNAE3_DBG_CMD_FD_RULE,
+		.dentry = HNS3_DBG_DENTRY_FD,
+		.init = hns3_dbg_common_init_t2,
+	},
 	{
 		.name = "service_task_info",
 		.cmd = HNAE3_DBG_CMD_SERV_INFO,
diff --git a/drivers/net/ethernet/hisilicon/hns3/hns3pf/hclge_debugfs.c b/drivers/net/ethernet/hisilicon/hns3/hns3pf/hclge_debugfs.c
index 3dab3a271aa6..73cdcaa1c311 100644
--- a/drivers/net/ethernet/hisilicon/hns3/hns3pf/hclge_debugfs.c
+++ b/drivers/net/ethernet/hisilicon/hns3/hns3pf/hclge_debugfs.c
@@ -2121,6 +2121,147 @@ static int hclge_dbg_dump_fd_counter(struct seq_file *s, void *data)
 	return 0;
 }
 
+__printf(4, 5)
+static void hclge_fd_dump_item(struct seq_file *s, const char *name,
+			       const char *suffix, const char *fmt, ...)
+{
+	va_list args;
+
+	seq_printf(s, "\t\t%s%s: ", name, suffix);
+
+	va_start(args, fmt);
+	seq_vprintf(s, fmt, args);
+	va_end(args);
+
+	seq_putc(s, '\n');
+}
+
+#define hclge_fd_dump_any(s, rule, type, name, fmt, key, mask)		\
+do {									\
+	typeof(s) _s = (s);						\
+	typeof(name) _name = (name);					\
+	typeof(fmt) _fmt = (fmt);					\
+									\
+	if (!((rule)->unused_tuple & BIT(type))) {			\
+		hclge_fd_dump_item(_s, _name, "", _fmt, key);		\
+		hclge_fd_dump_item(_s, _name, "_mask", _fmt, mask);	\
+	}								\
+} while (0)
+#define hclge_fd_dump_u32  hclge_fd_dump_any
+#define hclge_fd_dump_ptr  hclge_fd_dump_any
+
+static void hclge_fd_dump_ip(struct seq_file *s,
+			     struct hclge_fd_rule *rule,
+			     u32 type, const char *name,
+			     const u32 *ip, const u32 *mask)
+{
+	__be32 be_mask[IPV6_ADDR_WORDS];
+	__be32 be_ip[IPV6_ADDR_WORDS];
+
+	if (rule->unused_tuple & BIT(type))
+		return;
+
+	ipv6_addr_cpu_to_be32(be_ip, ip);
+	ipv6_addr_cpu_to_be32(be_mask, mask);
+
+	if (rule->tuples.ether_proto == ETH_P_IPV6)
+		hclge_fd_dump_ptr(s, rule, type, name, "%pI6",
+				  be_ip, be_mask);
+	else
+		hclge_fd_dump_ptr(s, rule, type, name, "%pI4",
+				  &be_ip[IPV4_INDEX], &be_mask[IPV4_INDEX]);
+}
+
+static void hclge_dbg_dump_fd_tuples(struct seq_file *s,
+				     struct hclge_fd_rule *rule)
+{
+	seq_puts(s, "\trule tuples:\n");
+
+	hclge_fd_dump_ptr(s, rule, INNER_DST_MAC, "dst_mac", "%pM",
+			  rule->tuples.dst_mac, rule->tuples_mask.dst_mac);
+	hclge_fd_dump_ptr(s, rule, INNER_SRC_MAC, "src_mac", "%pM",
+			  rule->tuples.src_mac, rule->tuples_mask.src_mac);
+	hclge_fd_dump_u32(s, rule, INNER_VLAN_TAG_FST, "vlan_tag", "0x%04x",
+			  rule->tuples.vlan_tag1, rule->tuples_mask.vlan_tag1);
+	hclge_fd_dump_u32(s, rule, INNER_ETH_TYPE, "ether_proto", "0x%04x",
+			  rule->tuples.ether_proto,
+			  rule->tuples_mask.ether_proto);
+	hclge_fd_dump_u32(s, rule, INNER_L2_RSV, "l2_user_def", "0x%04x",
+			  rule->tuples.l2_user_def,
+			  rule->tuples_mask.l2_user_def);
+	hclge_fd_dump_ip(s, rule, INNER_SRC_IP, "src_ip",
+			 rule->tuples.src_ip, rule->tuples_mask.src_ip);
+	hclge_fd_dump_ip(s, rule, INNER_DST_IP, "dst_ip",
+			 rule->tuples.dst_ip, rule->tuples_mask.dst_ip);
+	hclge_fd_dump_u32(s, rule, INNER_IP_TOS, "ip_tos", "0x%02x",
+			  rule->tuples.ip_tos, rule->tuples_mask.ip_tos);
+	hclge_fd_dump_u32(s, rule, INNER_IP_PROTO, "ip_proto", "0x%02x",
+			  rule->tuples.ip_proto, rule->tuples_mask.ip_proto);
+	hclge_fd_dump_u32(s, rule, INNER_L3_RSV, "l3_user_def", "0x%04x",
+			  rule->tuples.l3_user_def,
+			  rule->tuples_mask.l3_user_def);
+	hclge_fd_dump_u32(s, rule, INNER_SRC_PORT, "src_port", "0x%04x",
+			  rule->tuples.src_port, rule->tuples_mask.src_port);
+	hclge_fd_dump_u32(s, rule, INNER_DST_PORT, "dst_port", "0x%04x",
+			  rule->tuples.dst_port, rule->tuples_mask.dst_port);
+	hclge_fd_dump_u32(s, rule, INNER_L4_RSV, "l4_user_def", "0x%08x",
+			  rule->tuples.l4_user_def,
+			  rule->tuples_mask.l4_user_def);
+	hclge_fd_dump_u32(s, rule, OUTER_TUN_VNI, "outer_tun_vni", "0x%06x",
+			  rule->tuples.outer_tun_vni,
+			  rule->tuples_mask.outer_tun_vni);
+}
+
+static void hclge_dbg_dump_fd_action(struct seq_file *s,
+				     struct hclge_fd_rule *rule)
+{
+	static const char * const action_str[] = {
+		[HCLGE_FD_ACTION_SELECT_QUEUE] = "select_queue",
+		[HCLGE_FD_ACTION_DROP_PACKET]  = "drop_packet",
+		[HCLGE_FD_ACTION_SELECT_TC]    = "select_tc",
+	};
+
+	seq_printf(s, "\taction: %s\n", action_str[rule->action]);
+
+	if (rule->action == HCLGE_FD_ACTION_SELECT_QUEUE)
+		seq_printf(s, "\tqueue_id: %u\n", rule->queue_id);
+	else if (rule->action == HCLGE_FD_ACTION_SELECT_TC)
+		seq_printf(s, "\ttc: %u\n", rule->cls_flower.tc);
+}
+
+static void hclge_dbg_dump_fd_type(struct hclge_dev *hdev, struct seq_file *s)
+{
+	static const char *const rule_type_str[] = {
+		[HCLGE_FD_RULE_NONE]        = "none",
+		[HCLGE_FD_ARFS_ACTIVE]      = "arfs",
+		[HCLGE_FD_EP_ACTIVE]        = "ep",
+		[HCLGE_FD_TC_FLOWER_ACTIVE] = "tc_flow"
+	};
+
+	seq_printf(s, "fd type: %s\n", rule_type_str[hdev->fd_active_type]);
+}
+
+static int hclge_dbg_dump_fd_rule(struct seq_file *s, void *data)
+{
+	struct hclge_dev *hdev = hclge_seq_file_to_hdev(s);
+	struct hclge_fd_rule *rule;
+
+	spin_lock_bh(&hdev->fd_rule_lock);
+	hclge_dbg_dump_fd_type(hdev, s);
+	hlist_for_each_entry(rule, &hdev->fd_rule_list, rule_node) {
+		if (rule->state != HCLGE_FD_ACTIVE)
+			continue;
+
+		seq_printf(s, "location: %u\n", rule->location);
+		seq_printf(s, "vport_id: %u\n", rule->vf_id);
+		hclge_dbg_dump_fd_action(s, rule);
+		hclge_dbg_dump_fd_tuples(s, rule);
+	}
+	spin_unlock_bh(&hdev->fd_rule_lock);
+
+	return 0;
+}
+
 static const struct hclge_dbg_status_dfx_info hclge_dbg_rst_info[] = {
 	{HCLGE_MISC_VECTOR_REG_BASE, "vector0 interrupt enable status"},
 	{HCLGE_MISC_RESET_STS_REG,   "reset interrupt source"},
@@ -2913,6 +3054,10 @@ static const struct hclge_dbg_func hclge_dbg_cmd_func[] = {
 		.cmd = HNAE3_DBG_CMD_FD_TCAM,
 		.dbg_read_func = hclge_dbg_dump_fd_tcam,
 	},
+	{
+		.cmd = HNAE3_DBG_CMD_FD_RULE,
+		.dbg_read_func = hclge_dbg_dump_fd_rule,
+	},
 	{
 		.cmd = HNAE3_DBG_CMD_MAC_TNL_STATUS,
 		.dbg_read_func = hclge_dbg_dump_mac_tnl_status,
-- 
2.33.0


