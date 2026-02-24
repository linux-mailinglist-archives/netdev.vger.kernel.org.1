Return-Path: <netdev+bounces-260537-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id iDxrLz2mnWmgQwQAu9opvQ
	(envelope-from <netdev+bounces-260537-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Tue, 24 Feb 2026 14:23:09 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 327E6187949
	for <lists+netdev@lfdr.de>; Tue, 24 Feb 2026 14:23:09 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 114B1317381C
	for <lists+netdev@lfdr.de>; Tue, 24 Feb 2026 13:17:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EA1463A1CFA;
	Tue, 24 Feb 2026 13:16:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=huawei.com header.i=@huawei.com header.b="TUzbKZdI"
X-Original-To: netdev@vger.kernel.org
Received: from canpmsgout09.his.huawei.com (canpmsgout09.his.huawei.com [113.46.200.224])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3A3C33A1A3D;
	Tue, 24 Feb 2026 13:16:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=113.46.200.224
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1771938989; cv=none; b=FgucyPFszmRcDRGFJBnIF1uG+tl3o87JSDayWJpAlv71t+x3aprU9lICdN5yOwsSZ80bQoML3w25QvGyJ4ODpUaACnOkCRrHkgz5x+82hQT2vvDLeAXFL1H9KAowM1WDAmPl2Ms0YSUIoW7A+rkbhGVxyqjwmli0/0MwgZ2kOMc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1771938989; c=relaxed/simple;
	bh=98Wj99HSV5Al8LWedN3mb1cebsKw4eJRqW7T0HvRXks=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=ceCuCxbdVeMMWvaqI/xpdQZCD8J9nXgcNZR11+71YgKuOGKIxrAuHUBWImBuvwfXLMF+oHnT0QlY5gYDqQB9qOBx+YDFUh5C0DU8hZiKg7WYn/aJFKeRNQtK3LqXUUSbvtceS8eK+qnW+LcL6JhySc3dBQBH0UVVGYinT5gvy6g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=huawei.com; dkim=pass (1024-bit key) header.d=huawei.com header.i=@huawei.com header.b=TUzbKZdI; arc=none smtp.client-ip=113.46.200.224
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
dkim-signature: v=1; a=rsa-sha256; d=huawei.com; s=dkim;
	c=relaxed/relaxed; q=dns/txt;
	h=From;
	bh=kma0hz3STBGSZ6ldhWjWbS6B+jp7JplQW86qgN8w3tI=;
	b=TUzbKZdIZ3nzXzYUM18CcVjGwSywUbDVeYXRXy7zOCLKXBFLGaMd0PrLCkHD8Aq0j26nETIb9
	K6PmOqhK0gvLcoTc7nHQp8blDWvmjBTc86EYwZQFmqyBiwLqsQ/hGjC9WNuIsl0EFm5qU7k3IcD
	XoFCsYiIYM2wGH0DWygrWLU=
Received: from mail.maildlp.com (unknown [172.19.162.92])
	by canpmsgout09.his.huawei.com (SkyGuard) with ESMTPS id 4fKym7389wz1cyPh;
	Tue, 24 Feb 2026 21:11:35 +0800 (CST)
Received: from kwepemf100013.china.huawei.com (unknown [7.202.181.12])
	by mail.maildlp.com (Postfix) with ESMTPS id 7C5F140565;
	Tue, 24 Feb 2026 21:16:21 +0800 (CST)
Received: from DESKTOP-62GVMTR.china.huawei.com (10.174.189.124) by
 kwepemf100013.china.huawei.com (7.202.181.12) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.36; Tue, 24 Feb 2026 21:16:20 +0800
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
Subject: [PATCH net-next v01 11/15] hinic3: Add ethtool statistic ops
Date: Tue, 24 Feb 2026 21:15:48 +0800
Message-ID: <c861b68abf0d876f29f819526383bac69714ba33.1771916043.git.zhuyikai1@h-partners.com>
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
	TAGGED_FROM(0.00)[bounces-260537-lists,netdev=lfdr.de];
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
X-Rspamd-Queue-Id: 327E6187949
X-Rspamd-Action: no action

Co-developed-by: Zhu Yikai <zhuyikai1@h-partners.com>
Signed-off-by: Zhu Yikai <zhuyikai1@h-partners.com>
Signed-off-by: Fan Gong <gongfan1@huawei.com>
---
 .../ethernet/huawei/hinic3/hinic3_ethtool.c   | 414 ++++++++++++++++++
 .../ethernet/huawei/hinic3/hinic3_hw_intf.h   |  13 +-
 .../huawei/hinic3/hinic3_mgmt_interface.h     |  37 ++
 .../ethernet/huawei/hinic3/hinic3_nic_cfg.c   |  64 +++
 .../ethernet/huawei/hinic3/hinic3_nic_cfg.h   | 109 +++++
 .../ethernet/huawei/hinic3/hinic3_nic_dev.h   |  15 +
 .../net/ethernet/huawei/hinic3/hinic3_rx.c    |  58 ++-
 .../net/ethernet/huawei/hinic3/hinic3_rx.h    |  14 +
 .../net/ethernet/huawei/hinic3/hinic3_tx.c    |  72 ++-
 .../net/ethernet/huawei/hinic3/hinic3_tx.h    |   2 +
 10 files changed, 789 insertions(+), 9 deletions(-)

diff --git a/drivers/net/ethernet/huawei/hinic3/hinic3_ethtool.c b/drivers/net/ethernet/huawei/hinic3/hinic3_ethtool.c
index d155d8c533c7..ea0b2df73e9f 100644
--- a/drivers/net/ethernet/huawei/hinic3/hinic3_ethtool.c
+++ b/drivers/net/ethernet/huawei/hinic3/hinic3_ethtool.c
@@ -501,6 +501,417 @@ static int hinic3_set_ringparam(struct net_device *netdev,
 	return 0;
 }
 
+struct hinic3_stats {
+	char name[ETH_GSTRING_LEN];
+	u32  size;
+	int  offset;
+};
+
+#define HINIC3_NETDEV_STAT(_stat_item) { \
+	.name   = #_stat_item, \
+	.size   = sizeof_field(struct rtnl_link_stats64, _stat_item), \
+	.offset = offsetof(struct rtnl_link_stats64, _stat_item) \
+}
+
+static const struct hinic3_stats hinic3_netdev_stats[] = {
+	HINIC3_NETDEV_STAT(rx_packets),
+	HINIC3_NETDEV_STAT(tx_packets),
+	HINIC3_NETDEV_STAT(rx_bytes),
+	HINIC3_NETDEV_STAT(tx_bytes),
+	HINIC3_NETDEV_STAT(rx_errors),
+	HINIC3_NETDEV_STAT(tx_errors),
+	HINIC3_NETDEV_STAT(rx_dropped),
+	HINIC3_NETDEV_STAT(tx_dropped),
+	HINIC3_NETDEV_STAT(multicast),
+	HINIC3_NETDEV_STAT(collisions),
+	HINIC3_NETDEV_STAT(rx_length_errors),
+	HINIC3_NETDEV_STAT(rx_over_errors),
+	HINIC3_NETDEV_STAT(rx_crc_errors),
+	HINIC3_NETDEV_STAT(rx_frame_errors),
+	HINIC3_NETDEV_STAT(rx_fifo_errors),
+	HINIC3_NETDEV_STAT(rx_missed_errors),
+	HINIC3_NETDEV_STAT(tx_aborted_errors),
+	HINIC3_NETDEV_STAT(tx_carrier_errors),
+	HINIC3_NETDEV_STAT(tx_fifo_errors),
+	HINIC3_NETDEV_STAT(tx_heartbeat_errors),
+};
+
+#define HINIC3_NIC_STAT(_stat_item) { \
+	.name   = #_stat_item, \
+	.size   = sizeof_field(struct hinic3_nic_stats, _stat_item), \
+	.offset = offsetof(struct hinic3_nic_stats, _stat_item) \
+}
+
+#define HINIC3_RXQ_STAT(_stat_item) { \
+	.name   = "rxq%d_"#_stat_item, \
+	.size   = sizeof_field(struct hinic3_rxq_stats, _stat_item), \
+	.offset = offsetof(struct hinic3_rxq_stats, _stat_item) \
+}
+
+#define HINIC3_TXQ_STAT(_stat_item) { \
+	.name   = "txq%d_"#_stat_item, \
+	.size   = sizeof_field(struct hinic3_txq_stats, _stat_item), \
+	.offset = offsetof(struct hinic3_txq_stats, _stat_item) \
+}
+
+static struct hinic3_stats hinic3_rx_queue_stats[] = {
+	HINIC3_RXQ_STAT(packets),
+	HINIC3_RXQ_STAT(bytes),
+	HINIC3_RXQ_STAT(errors),
+	HINIC3_RXQ_STAT(csum_errors),
+	HINIC3_RXQ_STAT(other_errors),
+	HINIC3_RXQ_STAT(dropped),
+	HINIC3_RXQ_STAT(rx_buf_empty),
+	HINIC3_RXQ_STAT(alloc_skb_err),
+	HINIC3_RXQ_STAT(alloc_rx_buf_err),
+	HINIC3_RXQ_STAT(restore_drop_sge),
+};
+
+static struct hinic3_stats hinic3_tx_queue_stats[] = {
+	HINIC3_TXQ_STAT(packets),
+	HINIC3_TXQ_STAT(bytes),
+	HINIC3_TXQ_STAT(busy),
+	HINIC3_TXQ_STAT(dropped),
+	HINIC3_TXQ_STAT(skb_pad_err),
+	HINIC3_TXQ_STAT(frag_len_overflow),
+	HINIC3_TXQ_STAT(offload_cow_skb_err),
+	HINIC3_TXQ_STAT(map_frag_err),
+	HINIC3_TXQ_STAT(unknown_tunnel_pkt),
+	HINIC3_TXQ_STAT(frag_size_err),
+};
+
+#define HINIC3_FUNC_STAT(_stat_item) {	\
+	.name   = #_stat_item, \
+	.size   = sizeof_field(struct l2nic_vport_stats, _stat_item), \
+	.offset = offsetof(struct l2nic_vport_stats, _stat_item) \
+}
+
+static struct hinic3_stats hinic3_function_stats[] = {
+	HINIC3_FUNC_STAT(tx_unicast_pkts_vport),
+	HINIC3_FUNC_STAT(tx_unicast_bytes_vport),
+	HINIC3_FUNC_STAT(tx_multicast_pkts_vport),
+	HINIC3_FUNC_STAT(tx_multicast_bytes_vport),
+	HINIC3_FUNC_STAT(tx_broadcast_pkts_vport),
+	HINIC3_FUNC_STAT(tx_broadcast_bytes_vport),
+
+	HINIC3_FUNC_STAT(rx_unicast_pkts_vport),
+	HINIC3_FUNC_STAT(rx_unicast_bytes_vport),
+	HINIC3_FUNC_STAT(rx_multicast_pkts_vport),
+	HINIC3_FUNC_STAT(rx_multicast_bytes_vport),
+	HINIC3_FUNC_STAT(rx_broadcast_pkts_vport),
+	HINIC3_FUNC_STAT(rx_broadcast_bytes_vport),
+
+	HINIC3_FUNC_STAT(tx_discard_vport),
+	HINIC3_FUNC_STAT(rx_discard_vport),
+	HINIC3_FUNC_STAT(tx_err_vport),
+	HINIC3_FUNC_STAT(rx_err_vport),
+};
+
+#define HINIC3_PORT_STAT(_stat_item) { \
+	.name   = #_stat_item, \
+	.size   = sizeof_field(struct mag_cmd_port_stats, _stat_item), \
+	.offset = offsetof(struct mag_cmd_port_stats, _stat_item) \
+}
+
+static struct hinic3_stats hinic3_port_stats[] = {
+	HINIC3_PORT_STAT(mac_tx_fragment_pkt_num),
+	HINIC3_PORT_STAT(mac_tx_undersize_pkt_num),
+	HINIC3_PORT_STAT(mac_tx_undermin_pkt_num),
+	HINIC3_PORT_STAT(mac_tx_64_oct_pkt_num),
+	HINIC3_PORT_STAT(mac_tx_65_127_oct_pkt_num),
+	HINIC3_PORT_STAT(mac_tx_128_255_oct_pkt_num),
+	HINIC3_PORT_STAT(mac_tx_256_511_oct_pkt_num),
+	HINIC3_PORT_STAT(mac_tx_512_1023_oct_pkt_num),
+	HINIC3_PORT_STAT(mac_tx_1024_1518_oct_pkt_num),
+	HINIC3_PORT_STAT(mac_tx_1519_2047_oct_pkt_num),
+	HINIC3_PORT_STAT(mac_tx_2048_4095_oct_pkt_num),
+	HINIC3_PORT_STAT(mac_tx_4096_8191_oct_pkt_num),
+	HINIC3_PORT_STAT(mac_tx_8192_9216_oct_pkt_num),
+	HINIC3_PORT_STAT(mac_tx_9217_12287_oct_pkt_num),
+	HINIC3_PORT_STAT(mac_tx_12288_16383_oct_pkt_num),
+	HINIC3_PORT_STAT(mac_tx_1519_max_bad_pkt_num),
+	HINIC3_PORT_STAT(mac_tx_1519_max_good_pkt_num),
+	HINIC3_PORT_STAT(mac_tx_oversize_pkt_num),
+	HINIC3_PORT_STAT(mac_tx_jabber_pkt_num),
+	HINIC3_PORT_STAT(mac_tx_bad_pkt_num),
+	HINIC3_PORT_STAT(mac_tx_bad_oct_num),
+	HINIC3_PORT_STAT(mac_tx_good_pkt_num),
+	HINIC3_PORT_STAT(mac_tx_good_oct_num),
+	HINIC3_PORT_STAT(mac_tx_total_pkt_num),
+	HINIC3_PORT_STAT(mac_tx_total_oct_num),
+	HINIC3_PORT_STAT(mac_tx_uni_pkt_num),
+	HINIC3_PORT_STAT(mac_tx_multi_pkt_num),
+	HINIC3_PORT_STAT(mac_tx_broad_pkt_num),
+	HINIC3_PORT_STAT(mac_tx_pause_num),
+	HINIC3_PORT_STAT(mac_tx_pfc_pkt_num),
+	HINIC3_PORT_STAT(mac_tx_pfc_pri0_pkt_num),
+	HINIC3_PORT_STAT(mac_tx_pfc_pri1_pkt_num),
+	HINIC3_PORT_STAT(mac_tx_pfc_pri2_pkt_num),
+	HINIC3_PORT_STAT(mac_tx_pfc_pri3_pkt_num),
+	HINIC3_PORT_STAT(mac_tx_pfc_pri4_pkt_num),
+	HINIC3_PORT_STAT(mac_tx_pfc_pri5_pkt_num),
+	HINIC3_PORT_STAT(mac_tx_pfc_pri6_pkt_num),
+	HINIC3_PORT_STAT(mac_tx_pfc_pri7_pkt_num),
+	HINIC3_PORT_STAT(mac_tx_control_pkt_num),
+	HINIC3_PORT_STAT(mac_tx_err_all_pkt_num),
+	HINIC3_PORT_STAT(mac_tx_from_app_good_pkt_num),
+	HINIC3_PORT_STAT(mac_tx_from_app_bad_pkt_num),
+
+	HINIC3_PORT_STAT(mac_rx_fragment_pkt_num),
+	HINIC3_PORT_STAT(mac_rx_undersize_pkt_num),
+	HINIC3_PORT_STAT(mac_rx_undermin_pkt_num),
+	HINIC3_PORT_STAT(mac_rx_64_oct_pkt_num),
+	HINIC3_PORT_STAT(mac_rx_65_127_oct_pkt_num),
+	HINIC3_PORT_STAT(mac_rx_128_255_oct_pkt_num),
+	HINIC3_PORT_STAT(mac_rx_256_511_oct_pkt_num),
+	HINIC3_PORT_STAT(mac_rx_512_1023_oct_pkt_num),
+	HINIC3_PORT_STAT(mac_rx_1024_1518_oct_pkt_num),
+	HINIC3_PORT_STAT(mac_rx_1519_2047_oct_pkt_num),
+	HINIC3_PORT_STAT(mac_rx_2048_4095_oct_pkt_num),
+	HINIC3_PORT_STAT(mac_rx_4096_8191_oct_pkt_num),
+	HINIC3_PORT_STAT(mac_rx_8192_9216_oct_pkt_num),
+	HINIC3_PORT_STAT(mac_rx_9217_12287_oct_pkt_num),
+	HINIC3_PORT_STAT(mac_rx_12288_16383_oct_pkt_num),
+	HINIC3_PORT_STAT(mac_rx_1519_max_bad_pkt_num),
+	HINIC3_PORT_STAT(mac_rx_1519_max_good_pkt_num),
+	HINIC3_PORT_STAT(mac_rx_oversize_pkt_num),
+	HINIC3_PORT_STAT(mac_rx_jabber_pkt_num),
+	HINIC3_PORT_STAT(mac_rx_bad_pkt_num),
+	HINIC3_PORT_STAT(mac_rx_bad_oct_num),
+	HINIC3_PORT_STAT(mac_rx_good_pkt_num),
+	HINIC3_PORT_STAT(mac_rx_good_oct_num),
+	HINIC3_PORT_STAT(mac_rx_total_pkt_num),
+	HINIC3_PORT_STAT(mac_rx_total_oct_num),
+	HINIC3_PORT_STAT(mac_rx_uni_pkt_num),
+	HINIC3_PORT_STAT(mac_rx_multi_pkt_num),
+	HINIC3_PORT_STAT(mac_rx_broad_pkt_num),
+	HINIC3_PORT_STAT(mac_rx_pause_num),
+	HINIC3_PORT_STAT(mac_rx_pfc_pkt_num),
+	HINIC3_PORT_STAT(mac_rx_pfc_pri0_pkt_num),
+	HINIC3_PORT_STAT(mac_rx_pfc_pri1_pkt_num),
+	HINIC3_PORT_STAT(mac_rx_pfc_pri2_pkt_num),
+	HINIC3_PORT_STAT(mac_rx_pfc_pri3_pkt_num),
+	HINIC3_PORT_STAT(mac_rx_pfc_pri4_pkt_num),
+	HINIC3_PORT_STAT(mac_rx_pfc_pri5_pkt_num),
+	HINIC3_PORT_STAT(mac_rx_pfc_pri6_pkt_num),
+	HINIC3_PORT_STAT(mac_rx_pfc_pri7_pkt_num),
+	HINIC3_PORT_STAT(mac_rx_control_pkt_num),
+	HINIC3_PORT_STAT(mac_rx_sym_err_pkt_num),
+	HINIC3_PORT_STAT(mac_rx_fcs_err_pkt_num),
+	HINIC3_PORT_STAT(mac_rx_send_app_good_pkt_num),
+	HINIC3_PORT_STAT(mac_rx_send_app_bad_pkt_num),
+	HINIC3_PORT_STAT(mac_rx_unfilter_pkt_num),
+};
+
+static int hinic3_get_sset_count(struct net_device *netdev, int sset)
+{
+	struct hinic3_nic_dev *nic_dev = netdev_priv(netdev);
+	int count, q_num;
+
+	switch (sset) {
+	case ETH_SS_STATS:
+		q_num = nic_dev->q_params.num_qps;
+		count = ARRAY_SIZE(hinic3_netdev_stats) +
+			ARRAY_SIZE(hinic3_function_stats) +
+			(ARRAY_SIZE(hinic3_tx_queue_stats) +
+			 ARRAY_SIZE(hinic3_rx_queue_stats)) *
+			q_num;
+
+		if (!HINIC3_IS_VF(nic_dev->hwdev))
+			count += ARRAY_SIZE(hinic3_port_stats);
+
+		return count;
+	default:
+		return -EOPNOTSUPP;
+	}
+}
+
+static u64 get_val_of_ptr(u32 size, const void *ptr)
+{
+	u64 ret = size == sizeof(u64) ? *(u64 *)ptr :
+		  size == sizeof(u32) ? *(u32 *)ptr :
+		  size == sizeof(u16) ? *(u16 *)ptr :
+		  *(u8 *)ptr;
+
+	return ret;
+}
+
+static void hinic3_get_drv_queue_stats(struct net_device *netdev, u64 *data)
+{
+	struct hinic3_nic_dev *nic_dev = netdev_priv(netdev);
+	struct hinic3_txq_stats txq_stats = {};
+	struct hinic3_rxq_stats rxq_stats = {};
+	u16 i = 0, j, qid;
+	char *p;
+
+	for (qid = 0; qid < nic_dev->q_params.num_qps; qid++) {
+		if (!nic_dev->txqs)
+			break;
+
+		hinic3_txq_get_stats(&nic_dev->txqs[qid], &txq_stats);
+		for (j = 0; j < ARRAY_SIZE(hinic3_tx_queue_stats); j++, i++) {
+			p = (char *)&txq_stats +
+			    hinic3_tx_queue_stats[j].offset;
+			data[i] = get_val_of_ptr(hinic3_tx_queue_stats[j].size,
+						 p);
+		}
+	}
+
+	for (qid = 0; qid < nic_dev->q_params.num_qps; qid++) {
+		if (!nic_dev->rxqs)
+			break;
+
+		hinic3_rxq_get_stats(&nic_dev->rxqs[qid], &rxq_stats);
+		for (j = 0; j < ARRAY_SIZE(hinic3_rx_queue_stats); j++, i++) {
+			p = (char *)&rxq_stats +
+			    hinic3_rx_queue_stats[j].offset;
+			data[i] = get_val_of_ptr(hinic3_rx_queue_stats[j].size,
+						 p);
+		}
+	}
+}
+
+static u16 hinic3_get_ethtool_port_stats(struct net_device *netdev, u64 *data)
+{
+	struct hinic3_nic_dev *nic_dev = netdev_priv(netdev);
+	struct mag_cmd_port_stats *port_stats;
+	u16 i = 0, j;
+	char *p;
+	int err;
+
+	port_stats = kmalloc_obj(*port_stats, GFP_KERNEL);
+	if (!port_stats) {
+		memset(&data[i], 0,
+		       ARRAY_SIZE(hinic3_port_stats) * sizeof(*data));
+		i += ARRAY_SIZE(hinic3_port_stats);
+		return i;
+	}
+
+	err = hinic3_get_phy_port_stats(nic_dev->hwdev, port_stats);
+	if (err)
+		netdev_err(netdev, "Failed to get port stats from fw\n");
+
+	for (j = 0; j < ARRAY_SIZE(hinic3_port_stats); j++, i++) {
+		p = (char *)port_stats + hinic3_port_stats[j].offset;
+		data[i] = get_val_of_ptr(hinic3_port_stats[j].size, p);
+	}
+
+	kfree(port_stats);
+
+	return i;
+}
+
+static void hinic3_get_ethtool_stats(struct net_device *netdev,
+				     struct ethtool_stats *stats, u64 *data)
+{
+	struct hinic3_nic_dev *nic_dev = netdev_priv(netdev);
+	struct l2nic_vport_stats vport_stats = {};
+	const struct rtnl_link_stats64 *net_stats;
+	struct rtnl_link_stats64 temp;
+	u16 i = 0, j;
+	char *p;
+	int err;
+
+	net_stats = dev_get_stats(netdev, &temp);
+	for (j = 0; j < ARRAY_SIZE(hinic3_netdev_stats); j++, i++) {
+		p = (char *)net_stats + hinic3_netdev_stats[j].offset;
+		data[i] = get_val_of_ptr(hinic3_netdev_stats[j].size, p);
+	}
+
+	err = hinic3_get_vport_stats(nic_dev->hwdev,
+				     hinic3_global_func_id(nic_dev->hwdev),
+				     &vport_stats);
+	if (err)
+		netdev_err(netdev, "Failed to get function stats from fw\n");
+
+	for (j = 0; j < ARRAY_SIZE(hinic3_function_stats); j++, i++) {
+		p = (char *)&vport_stats + hinic3_function_stats[j].offset;
+		data[i] = get_val_of_ptr(hinic3_function_stats[j].size, p);
+	}
+
+	if (!HINIC3_IS_VF(nic_dev->hwdev))
+		i += hinic3_get_ethtool_port_stats(netdev, data + i);
+
+	hinic3_get_drv_queue_stats(netdev, data + i);
+}
+
+static u16 hinic3_get_drv_dev_strings(char *p)
+{
+	u16 i, cnt = 0;
+
+	for (i = 0; i < ARRAY_SIZE(hinic3_netdev_stats); i++) {
+		memcpy(p, hinic3_netdev_stats[i].name, ETH_GSTRING_LEN);
+		p += ETH_GSTRING_LEN;
+		cnt++;
+	}
+
+	return cnt;
+}
+
+static u16 hinic3_get_hw_stats_strings(struct net_device *netdev, char *p)
+{
+	struct hinic3_nic_dev *nic_dev = netdev_priv(netdev);
+	u16 i, cnt = 0;
+
+	for (i = 0; i < ARRAY_SIZE(hinic3_function_stats); i++) {
+		memcpy(p, hinic3_function_stats[i].name, ETH_GSTRING_LEN);
+		p += ETH_GSTRING_LEN;
+		cnt++;
+	}
+
+	if (!HINIC3_IS_VF(nic_dev->hwdev)) {
+		for (i = 0; i < ARRAY_SIZE(hinic3_port_stats); i++) {
+			memcpy(p, hinic3_port_stats[i].name, ETH_GSTRING_LEN);
+			p += ETH_GSTRING_LEN;
+			cnt++;
+		}
+	}
+
+	return cnt;
+}
+
+static void hinic3_get_qp_stats_strings(const struct net_device *netdev,
+					char *p)
+{
+	struct hinic3_nic_dev *nic_dev = netdev_priv(netdev);
+	u8 *data = p;
+	u16 i, j;
+
+	for (i = 0; i < nic_dev->q_params.num_qps; i++) {
+		for (j = 0; j < ARRAY_SIZE(hinic3_tx_queue_stats); j++)
+			ethtool_sprintf(&data,
+					hinic3_tx_queue_stats[j].name, i);
+	}
+
+	for (i = 0; i < nic_dev->q_params.num_qps; i++) {
+		for (j = 0; j < ARRAY_SIZE(hinic3_rx_queue_stats); j++)
+			ethtool_sprintf(&data,
+					hinic3_rx_queue_stats[j].name, i);
+	}
+}
+
+static void hinic3_get_strings(struct net_device *netdev,
+			       u32 stringset, u8 *data)
+{
+	char *p = (char *)data;
+	u16 offset;
+
+	switch (stringset) {
+	case ETH_SS_STATS:
+		offset = hinic3_get_drv_dev_strings(p);
+		offset += hinic3_get_hw_stats_strings(netdev, p +
+							      offset *
+							      ETH_GSTRING_LEN);
+		hinic3_get_qp_stats_strings(netdev,
+					    p + offset * ETH_GSTRING_LEN);
+
+		return;
+	default:
+		netdev_err(netdev, "Invalid string set %u.\n", stringset);
+		return;
+	}
+}
+
 static const struct ethtool_ops hinic3_ethtool_ops = {
 	.supported_coalesce_params      = ETHTOOL_COALESCE_USECS |
 					  ETHTOOL_COALESCE_PKT_RATE_RX_USECS,
@@ -511,6 +922,9 @@ static const struct ethtool_ops hinic3_ethtool_ops = {
 	.get_link                       = ethtool_op_get_link,
 	.get_ringparam                  = hinic3_get_ringparam,
 	.set_ringparam                  = hinic3_set_ringparam,
+	.get_sset_count                 = hinic3_get_sset_count,
+	.get_ethtool_stats              = hinic3_get_ethtool_stats,
+	.get_strings                    = hinic3_get_strings,
 };
 
 void hinic3_set_ethtool_ops(struct net_device *netdev)
diff --git a/drivers/net/ethernet/huawei/hinic3/hinic3_hw_intf.h b/drivers/net/ethernet/huawei/hinic3/hinic3_hw_intf.h
index cfc9daa3034f..0b2ebef04c02 100644
--- a/drivers/net/ethernet/huawei/hinic3/hinic3_hw_intf.h
+++ b/drivers/net/ethernet/huawei/hinic3/hinic3_hw_intf.h
@@ -51,7 +51,18 @@ static inline void mgmt_msg_params_init_default(struct mgmt_msg_params *msg_para
 	msg_params->in_size = buf_size;
 	msg_params->expected_out_size = buf_size;
 	msg_params->timeout_ms = 0;
-}
+};
+
+static inline void
+mgmt_msg_params_init_in_out(struct mgmt_msg_params *msg_params, void *in_buf,
+			    void *out_buf, u32 in_buf_size, u32 out_buf_size)
+{
+	msg_params->buf_in = in_buf;
+	msg_params->buf_out = out_buf;
+	msg_params->in_size = in_buf_size;
+	msg_params->expected_out_size = out_buf_size;
+	msg_params->timeout_ms = 0;
+};
 
 enum cfg_cmd {
 	CFG_CMD_GET_DEV_CAP = 0,
diff --git a/drivers/net/ethernet/huawei/hinic3/hinic3_mgmt_interface.h b/drivers/net/ethernet/huawei/hinic3/hinic3_mgmt_interface.h
index c5bca3c4af96..76c691f82703 100644
--- a/drivers/net/ethernet/huawei/hinic3/hinic3_mgmt_interface.h
+++ b/drivers/net/ethernet/huawei/hinic3/hinic3_mgmt_interface.h
@@ -143,6 +143,41 @@ struct l2nic_cmd_set_dcb_state {
 	u8                   rsvd[7];
 };
 
+struct l2nic_port_stats_info {
+	struct mgmt_msg_head msg_head;
+	u16                  func_id;
+	u16                  rsvd1;
+};
+
+struct l2nic_vport_stats {
+	u64 tx_unicast_pkts_vport;
+	u64 tx_unicast_bytes_vport;
+	u64 tx_multicast_pkts_vport;
+	u64 tx_multicast_bytes_vport;
+	u64 tx_broadcast_pkts_vport;
+	u64 tx_broadcast_bytes_vport;
+
+	u64 rx_unicast_pkts_vport;
+	u64 rx_unicast_bytes_vport;
+	u64 rx_multicast_pkts_vport;
+	u64 rx_multicast_bytes_vport;
+	u64 rx_broadcast_pkts_vport;
+	u64 rx_broadcast_bytes_vport;
+
+	u64 tx_discard_vport;
+	u64 rx_discard_vport;
+	u64 tx_err_vport;
+	u64 rx_err_vport;
+};
+
+struct l2nic_cmd_vport_stats {
+	struct mgmt_msg_head     msg_head;
+	u32                      stats_size;
+	u32                      rsvd1;
+	struct l2nic_vport_stats stats;
+	u64                      rsvd2[6];
+};
+
 struct l2nic_cmd_lro_config {
 	struct mgmt_msg_head msg_head;
 	u16                  func_id;
@@ -234,6 +269,7 @@ enum l2nic_cmd {
 	L2NIC_CMD_SET_VPORT_ENABLE    = 6,
 	L2NIC_CMD_SET_RX_MODE         = 7,
 	L2NIC_CMD_SET_SQ_CI_ATTR      = 8,
+	L2NIC_CMD_GET_VPORT_STAT      = 9,
 	L2NIC_CMD_CLEAR_QP_RESOURCE   = 11,
 	L2NIC_CMD_CFG_RX_LRO          = 13,
 	L2NIC_CMD_CFG_LRO_TIMER       = 14,
@@ -272,6 +308,7 @@ enum mag_cmd {
 	MAG_CMD_SET_PORT_ENABLE = 6,
 	MAG_CMD_GET_LINK_STATUS = 7,
 
+	MAG_CMD_GET_PORT_STAT   = 151,
 	MAG_CMD_GET_PORT_INFO   = 153,
 };
 
diff --git a/drivers/net/ethernet/huawei/hinic3/hinic3_nic_cfg.c b/drivers/net/ethernet/huawei/hinic3/hinic3_nic_cfg.c
index 11ef362ace95..a1a193201afd 100644
--- a/drivers/net/ethernet/huawei/hinic3/hinic3_nic_cfg.c
+++ b/drivers/net/ethernet/huawei/hinic3/hinic3_nic_cfg.c
@@ -639,6 +639,42 @@ int hinic3_get_link_status(struct hinic3_hwdev *hwdev, bool *link_status_up)
 	return 0;
 }
 
+int hinic3_get_phy_port_stats(struct hinic3_hwdev *hwdev,
+			      struct mag_cmd_port_stats *stats)
+{
+	struct mag_cmd_port_stats_info stats_info = {};
+	struct mag_cmd_get_port_stat *port_stats;
+	struct mgmt_msg_params msg_params = {};
+	int err;
+
+	port_stats = kzalloc_obj(*port_stats, GFP_KERNEL);
+	if (!port_stats)
+		return -ENOMEM;
+
+	stats_info.port_id = hinic3_physical_port_id(hwdev);
+
+	mgmt_msg_params_init_in_out(&msg_params, &stats_info, port_stats,
+				    sizeof(stats_info), sizeof(*port_stats));
+
+	err = hinic3_send_mbox_to_mgmt(hwdev, MGMT_MOD_HILINK,
+				       MAG_CMD_GET_PORT_STAT, &msg_params);
+
+	if (err || stats_info.head.status) {
+		dev_err(hwdev->dev,
+			"Failed to get port statistics, err: %d, status: 0x%x\n",
+			err, stats_info.head.status);
+		err = -EFAULT;
+		goto out;
+	}
+
+	memcpy(stats, &port_stats->counter, sizeof(*stats));
+
+out:
+	kfree(port_stats);
+
+	return err;
+}
+
 int hinic3_get_port_info(struct hinic3_hwdev *hwdev,
 			 struct hinic3_nic_port_info *port_info)
 {
@@ -751,3 +787,31 @@ int hinic3_get_pause_info(struct hinic3_nic_dev *nic_dev,
 
 	return 0;
 }
+
+int hinic3_get_vport_stats(struct hinic3_hwdev *hwdev, u16 func_id,
+			   struct l2nic_vport_stats *stats)
+{
+	struct l2nic_cmd_vport_stats vport_stats = {};
+	struct l2nic_port_stats_info stats_info = {};
+	struct mgmt_msg_params msg_params = {};
+	int err;
+
+	stats_info.func_id = func_id;
+
+	mgmt_msg_params_init_in_out(&msg_params, &stats_info, &vport_stats,
+				    sizeof(stats_info), sizeof(vport_stats));
+
+	err = hinic3_send_mbox_to_mgmt(hwdev, MGMT_MOD_L2NIC,
+				       L2NIC_CMD_GET_VPORT_STAT, &msg_params);
+
+	if (err || vport_stats.msg_head.status) {
+		dev_err(hwdev->dev,
+			"Failed to get function statistics, err: %d, status: 0x%x\n",
+			err, vport_stats.msg_head.status);
+		return -EFAULT;
+	}
+
+	memcpy(stats, &vport_stats.stats, sizeof(*stats));
+
+	return 0;
+}
diff --git a/drivers/net/ethernet/huawei/hinic3/hinic3_nic_cfg.h b/drivers/net/ethernet/huawei/hinic3/hinic3_nic_cfg.h
index 5d52202a8d4e..80573c121539 100644
--- a/drivers/net/ethernet/huawei/hinic3/hinic3_nic_cfg.h
+++ b/drivers/net/ethernet/huawei/hinic3/hinic3_nic_cfg.h
@@ -129,6 +129,110 @@ struct mag_cmd_get_xsfp_present {
 	u8                   rsvd[2];
 };
 
+struct mag_cmd_port_stats {
+	u64 mac_tx_fragment_pkt_num;
+	u64 mac_tx_undersize_pkt_num;
+	u64 mac_tx_undermin_pkt_num;
+	u64 mac_tx_64_oct_pkt_num;
+	u64 mac_tx_65_127_oct_pkt_num;
+	u64 mac_tx_128_255_oct_pkt_num;
+	u64 mac_tx_256_511_oct_pkt_num;
+	u64 mac_tx_512_1023_oct_pkt_num;
+	u64 mac_tx_1024_1518_oct_pkt_num;
+	u64 mac_tx_1519_2047_oct_pkt_num;
+	u64 mac_tx_2048_4095_oct_pkt_num;
+	u64 mac_tx_4096_8191_oct_pkt_num;
+	u64 mac_tx_8192_9216_oct_pkt_num;
+	u64 mac_tx_9217_12287_oct_pkt_num;
+	u64 mac_tx_12288_16383_oct_pkt_num;
+	u64 mac_tx_1519_max_bad_pkt_num;
+	u64 mac_tx_1519_max_good_pkt_num;
+	u64 mac_tx_oversize_pkt_num;
+	u64 mac_tx_jabber_pkt_num;
+	u64 mac_tx_bad_pkt_num;
+	u64 mac_tx_bad_oct_num;
+	u64 mac_tx_good_pkt_num;
+	u64 mac_tx_good_oct_num;
+	u64 mac_tx_total_pkt_num;
+	u64 mac_tx_total_oct_num;
+	u64 mac_tx_uni_pkt_num;
+	u64 mac_tx_multi_pkt_num;
+	u64 mac_tx_broad_pkt_num;
+	u64 mac_tx_pause_num;
+	u64 mac_tx_pfc_pkt_num;
+	u64 mac_tx_pfc_pri0_pkt_num;
+	u64 mac_tx_pfc_pri1_pkt_num;
+	u64 mac_tx_pfc_pri2_pkt_num;
+	u64 mac_tx_pfc_pri3_pkt_num;
+	u64 mac_tx_pfc_pri4_pkt_num;
+	u64 mac_tx_pfc_pri5_pkt_num;
+	u64 mac_tx_pfc_pri6_pkt_num;
+	u64 mac_tx_pfc_pri7_pkt_num;
+	u64 mac_tx_control_pkt_num;
+	u64 mac_tx_err_all_pkt_num;
+	u64 mac_tx_from_app_good_pkt_num;
+	u64 mac_tx_from_app_bad_pkt_num;
+
+	u64 mac_rx_fragment_pkt_num;
+	u64 mac_rx_undersize_pkt_num;
+	u64 mac_rx_undermin_pkt_num;
+	u64 mac_rx_64_oct_pkt_num;
+	u64 mac_rx_65_127_oct_pkt_num;
+	u64 mac_rx_128_255_oct_pkt_num;
+	u64 mac_rx_256_511_oct_pkt_num;
+	u64 mac_rx_512_1023_oct_pkt_num;
+	u64 mac_rx_1024_1518_oct_pkt_num;
+	u64 mac_rx_1519_2047_oct_pkt_num;
+	u64 mac_rx_2048_4095_oct_pkt_num;
+	u64 mac_rx_4096_8191_oct_pkt_num;
+	u64 mac_rx_8192_9216_oct_pkt_num;
+	u64 mac_rx_9217_12287_oct_pkt_num;
+	u64 mac_rx_12288_16383_oct_pkt_num;
+	u64 mac_rx_1519_max_bad_pkt_num;
+	u64 mac_rx_1519_max_good_pkt_num;
+	u64 mac_rx_oversize_pkt_num;
+	u64 mac_rx_jabber_pkt_num;
+	u64 mac_rx_bad_pkt_num;
+	u64 mac_rx_bad_oct_num;
+	u64 mac_rx_good_pkt_num;
+	u64 mac_rx_good_oct_num;
+	u64 mac_rx_total_pkt_num;
+	u64 mac_rx_total_oct_num;
+	u64 mac_rx_uni_pkt_num;
+	u64 mac_rx_multi_pkt_num;
+	u64 mac_rx_broad_pkt_num;
+	u64 mac_rx_pause_num;
+	u64 mac_rx_pfc_pkt_num;
+	u64 mac_rx_pfc_pri0_pkt_num;
+	u64 mac_rx_pfc_pri1_pkt_num;
+	u64 mac_rx_pfc_pri2_pkt_num;
+	u64 mac_rx_pfc_pri3_pkt_num;
+	u64 mac_rx_pfc_pri4_pkt_num;
+	u64 mac_rx_pfc_pri5_pkt_num;
+	u64 mac_rx_pfc_pri6_pkt_num;
+	u64 mac_rx_pfc_pri7_pkt_num;
+	u64 mac_rx_control_pkt_num;
+	u64 mac_rx_sym_err_pkt_num;
+	u64 mac_rx_fcs_err_pkt_num;
+	u64 mac_rx_send_app_good_pkt_num;
+	u64 mac_rx_send_app_bad_pkt_num;
+	u64 mac_rx_unfilter_pkt_num;
+};
+
+struct mag_cmd_port_stats_info {
+	struct mgmt_msg_head head;
+
+	u8                   port_id;
+	u8                   rsvd0[3];
+};
+
+struct mag_cmd_get_port_stat {
+	struct mgmt_msg_head      head;
+
+	struct mag_cmd_port_stats counter;
+	u64                       rsvd1[15];
+};
+
 enum link_err_type {
 	LINK_ERR_MODULE_UNRECOGENIZED,
 	LINK_ERR_NUM,
@@ -209,6 +313,11 @@ int hinic3_get_port_info(struct hinic3_hwdev *hwdev,
 			 struct hinic3_nic_port_info *port_info);
 int hinic3_set_vport_enable(struct hinic3_hwdev *hwdev, u16 func_id,
 			    bool enable);
+int hinic3_get_phy_port_stats(struct hinic3_hwdev *hwdev,
+			      struct mag_cmd_port_stats *stats);
+int hinic3_get_vport_stats(struct hinic3_hwdev *hwdev, u16 func_id,
+			   struct l2nic_vport_stats *stats);
+
 int hinic3_add_vlan(struct hinic3_hwdev *hwdev, u16 vlan_id, u16 func_id);
 int hinic3_del_vlan(struct hinic3_hwdev *hwdev, u16 vlan_id, u16 func_id);
 
diff --git a/drivers/net/ethernet/huawei/hinic3/hinic3_nic_dev.h b/drivers/net/ethernet/huawei/hinic3/hinic3_nic_dev.h
index a94c3dde421e..107bf392f5ed 100644
--- a/drivers/net/ethernet/huawei/hinic3/hinic3_nic_dev.h
+++ b/drivers/net/ethernet/huawei/hinic3/hinic3_nic_dev.h
@@ -34,6 +34,20 @@ enum hinic3_event_work_flags {
 	HINIC3_EVENT_WORK_TX_TIMEOUT,
 };
 
+#define HINIC3_NIC_STATS_INC(nic_dev, field) \
+do { \
+	u64_stats_update_begin(&(nic_dev)->stats.syncp); \
+	(nic_dev)->stats.field++; \
+	u64_stats_update_end(&(nic_dev)->stats.syncp); \
+} while (0)
+
+struct hinic3_nic_stats {
+	/* Subdivision statistics show in private tool */
+	u64                   tx_carrier_off_drop;
+	u64                   tx_invalid_qid;
+	struct u64_stats_sync syncp;
+};
+
 enum hinic3_rx_mode_state {
 	HINIC3_HW_PROMISC_ON,
 	HINIC3_HW_ALLMULTI_ON,
@@ -120,6 +134,7 @@ struct hinic3_nic_dev {
 	struct hinic3_dyna_txrxq_params q_params;
 	struct hinic3_txq               *txqs;
 	struct hinic3_rxq               *rxqs;
+	struct hinic3_nic_stats         stats;
 
 	enum hinic3_rss_hash_type       rss_hash_type;
 	struct hinic3_rss_type          rss_type;
diff --git a/drivers/net/ethernet/huawei/hinic3/hinic3_rx.c b/drivers/net/ethernet/huawei/hinic3/hinic3_rx.c
index fe7fdd06c1b6..802ec9dffcd9 100644
--- a/drivers/net/ethernet/huawei/hinic3/hinic3_rx.c
+++ b/drivers/net/ethernet/huawei/hinic3/hinic3_rx.c
@@ -29,10 +29,17 @@
 #define HINIC3_LRO_PKT_HDR_LEN_IPV4     66
 #define HINIC3_LRO_PKT_HDR_LEN_IPV6     86
 #define HINIC3_LRO_PKT_HDR_LEN(cqe) \
-	(RQ_CQE_OFFOLAD_TYPE_GET((cqe)->offload_type, IP_TYPE) == \
+	(RQ_CQE_OFFOLAD_TYPE_GET(le32_to_cpu((cqe)->offload_type), IP_TYPE) == \
 	 HINIC3_RX_IPV6_PKT ? HINIC3_LRO_PKT_HDR_LEN_IPV6 : \
 	 HINIC3_LRO_PKT_HDR_LEN_IPV4)
 
+#define RXQ_STATS_INC(rxq, field) \
+do { \
+	u64_stats_update_begin(&(rxq)->rxq_stats.syncp); \
+	(rxq)->rxq_stats.field++; \
+	u64_stats_update_end(&(rxq)->rxq_stats.syncp); \
+} while (0)
+
 static void hinic3_rxq_clean_stats(struct hinic3_rxq_stats *rxq_stats)
 {
 	u64_stats_update_begin(&rxq_stats->syncp);
@@ -155,8 +162,10 @@ static u32 hinic3_rx_fill_buffers(struct hinic3_rxq *rxq)
 
 		err = rx_alloc_mapped_page(rxq->page_pool, rx_info,
 					   rxq->buf_len);
-		if (unlikely(err))
+		if (unlikely(err)) {
+			RXQ_STATS_INC(rxq, alloc_rx_buf_err);
 			break;
+		}
 
 		dma_addr = page_pool_get_dma_addr(rx_info->page) +
 			rx_info->page_offset;
@@ -170,6 +179,8 @@ static u32 hinic3_rx_fill_buffers(struct hinic3_rxq *rxq)
 				rxq->next_to_update << HINIC3_NORMAL_RQ_WQE);
 		rxq->delta -= i;
 		rxq->next_to_alloc = rxq->next_to_update;
+	} else if (free_wqebbs == rxq->q_depth - 1) {
+		RXQ_STATS_INC(rxq, rx_buf_empty);
 	}
 
 	return i;
@@ -329,11 +340,17 @@ static void hinic3_rx_csum(struct hinic3_rxq *rxq, u32 offload_type,
 	u32 csum_err = RQ_CQE_STATUS_GET(status, CSUM_ERR);
 	struct net_device *netdev = rxq->netdev;
 
+	if (unlikely(csum_err == HINIC3_RX_CSUM_IPSU_OTHER_ERR))
+		rxq->rxq_stats.other_errors++;
+
 	if (!(netdev->features & NETIF_F_RXCSUM))
 		return;
 
 	if (unlikely(csum_err)) {
 		/* pkt type is recognized by HW, and csum is wrong */
+		if (!(csum_err & (HINIC3_RX_CSUM_HW_CHECK_NONE |
+				  HINIC3_RX_CSUM_IPSU_OTHER_ERR)))
+			rxq->rxq_stats.csum_errors++;
 		skb->ip_summed = CHECKSUM_NONE;
 		return;
 	}
@@ -397,8 +414,10 @@ static int recv_one_pkt(struct hinic3_rxq *rxq, struct hinic3_rq_cqe *rx_cqe,
 	u16 num_lro;
 
 	skb = hinic3_fetch_rx_buffer(rxq, pkt_len);
-	if (unlikely(!skb))
+	if (unlikely(!skb)) {
+		RXQ_STATS_INC(rxq, alloc_skb_err);
 		return -ENOMEM;
+	}
 
 	/* place header in linear portion of buffer */
 	if (skb_is_nonlinear(skb))
@@ -562,11 +581,33 @@ int hinic3_configure_rxqs(struct net_device *netdev, u16 num_rq,
 	return 0;
 }
 
+void hinic3_rxq_get_stats(struct hinic3_rxq *rxq,
+			  struct hinic3_rxq_stats *stats)
+{
+	struct hinic3_rxq_stats *rxq_stats = &rxq->rxq_stats;
+	unsigned int start;
+
+	u64_stats_update_begin(&stats->syncp);
+	do {
+		start = u64_stats_fetch_begin(&rxq_stats->syncp);
+		stats->bytes = rxq_stats->bytes;
+		stats->packets = rxq_stats->packets;
+		stats->errors = rxq_stats->csum_errors +
+				rxq_stats->other_errors;
+		stats->csum_errors = rxq_stats->csum_errors;
+		stats->other_errors = rxq_stats->other_errors;
+		stats->dropped = rxq_stats->dropped;
+		stats->rx_buf_empty = rxq_stats->rx_buf_empty;
+	} while (u64_stats_fetch_retry(&rxq_stats->syncp, start));
+	u64_stats_update_end(&stats->syncp);
+}
+
 int hinic3_rx_poll(struct hinic3_rxq *rxq, int budget)
 {
 	struct hinic3_nic_dev *nic_dev = netdev_priv(rxq->netdev);
 	u32 sw_ci, status, pkt_len, vlan_len;
 	struct hinic3_rq_cqe *rx_cqe;
+	u64 rx_bytes = 0;
 	u32 num_wqe = 0;
 	int nr_pkts = 0;
 	u16 num_lro;
@@ -586,10 +627,14 @@ int hinic3_rx_poll(struct hinic3_rxq *rxq, int budget)
 		if (recv_one_pkt(rxq, rx_cqe, pkt_len, vlan_len, status))
 			break;
 
+		rx_bytes += pkt_len;
 		nr_pkts++;
 		num_lro = RQ_CQE_STATUS_GET(status, NUM_LRO);
-		if (num_lro)
+		if (num_lro) {
+			rx_bytes += (num_lro - 1) *
+				    HINIC3_LRO_PKT_HDR_LEN(rx_cqe);
 			num_wqe += hinic3_get_sge_num(rxq, pkt_len);
+		}
 
 		rx_cqe->status = 0;
 
@@ -600,5 +645,10 @@ int hinic3_rx_poll(struct hinic3_rxq *rxq, int budget)
 	if (rxq->delta >= HINIC3_RX_BUFFER_WRITE)
 		hinic3_rx_fill_buffers(rxq);
 
+	u64_stats_update_begin(&rxq->rxq_stats.syncp);
+	rxq->rxq_stats.packets += (u64)nr_pkts;
+	rxq->rxq_stats.bytes += rx_bytes;
+	u64_stats_update_end(&rxq->rxq_stats.syncp);
+
 	return nr_pkts;
 }
diff --git a/drivers/net/ethernet/huawei/hinic3/hinic3_rx.h b/drivers/net/ethernet/huawei/hinic3/hinic3_rx.h
index 06d1b3299e7c..cd2dcaab6cf7 100644
--- a/drivers/net/ethernet/huawei/hinic3/hinic3_rx.h
+++ b/drivers/net/ethernet/huawei/hinic3/hinic3_rx.h
@@ -8,6 +8,17 @@
 #include <linux/dim.h>
 #include <linux/netdevice.h>
 
+/* rx cqe checksum err */
+#define HINIC3_RX_CSUM_IP_CSUM_ERR      BIT(0)
+#define HINIC3_RX_CSUM_TCP_CSUM_ERR     BIT(1)
+#define HINIC3_RX_CSUM_UDP_CSUM_ERR     BIT(2)
+#define HINIC3_RX_CSUM_IGMP_CSUM_ERR    BIT(3)
+#define HINIC3_RX_CSUM_ICMPV4_CSUM_ERR  BIT(4)
+#define HINIC3_RX_CSUM_ICMPV6_CSUM_ERR  BIT(5)
+#define HINIC3_RX_CSUM_SCTP_CRC_ERR     BIT(6)
+#define HINIC3_RX_CSUM_HW_CHECK_NONE    BIT(7)
+#define HINIC3_RX_CSUM_IPSU_OTHER_ERR   BIT(8)
+
 #define RQ_CQE_OFFOLAD_TYPE_PKT_TYPE_MASK           GENMASK(4, 0)
 #define RQ_CQE_OFFOLAD_TYPE_IP_TYPE_MASK            GENMASK(6, 5)
 #define RQ_CQE_OFFOLAD_TYPE_TUNNEL_PKT_FORMAT_MASK  GENMASK(11, 8)
@@ -123,6 +134,9 @@ void hinic3_free_rxqs_res(struct net_device *netdev, u16 num_rq,
 			  u32 rq_depth, struct hinic3_dyna_rxq_res *rxqs_res);
 int hinic3_configure_rxqs(struct net_device *netdev, u16 num_rq,
 			  u32 rq_depth, struct hinic3_dyna_rxq_res *rxqs_res);
+
+void hinic3_rxq_get_stats(struct hinic3_rxq *rxq,
+			  struct hinic3_rxq_stats *stats);
 int hinic3_rx_poll(struct hinic3_rxq *rxq, int budget);
 
 #endif
diff --git a/drivers/net/ethernet/huawei/hinic3/hinic3_tx.c b/drivers/net/ethernet/huawei/hinic3/hinic3_tx.c
index 6d3dc930ca97..79f877c9aa03 100644
--- a/drivers/net/ethernet/huawei/hinic3/hinic3_tx.c
+++ b/drivers/net/ethernet/huawei/hinic3/hinic3_tx.c
@@ -16,6 +16,13 @@
 
 #define MIN_SKB_LEN                32
 
+#define TXQ_STATS_INC(txq, field) \
+do { \
+	u64_stats_update_begin(&(txq)->txq_stats.syncp); \
+	(txq)->txq_stats.field++; \
+	u64_stats_update_end(&(txq)->txq_stats.syncp); \
+} while (0)
+
 static void hinic3_txq_clean_stats(struct hinic3_txq_stats *txq_stats)
 {
 	u64_stats_update_begin(&txq_stats->syncp);
@@ -97,8 +104,10 @@ static int hinic3_tx_map_skb(struct net_device *netdev, struct sk_buff *skb,
 
 	dma_info[0].dma = dma_map_single(&pdev->dev, skb->data,
 					 skb_headlen(skb), DMA_TO_DEVICE);
-	if (dma_mapping_error(&pdev->dev, dma_info[0].dma))
+	if (dma_mapping_error(&pdev->dev, dma_info[0].dma)) {
+		TXQ_STATS_INC(txq, map_frag_err);
 		return -EFAULT;
+	}
 
 	dma_info[0].len = skb_headlen(skb);
 
@@ -117,6 +126,7 @@ static int hinic3_tx_map_skb(struct net_device *netdev, struct sk_buff *skb,
 						     skb_frag_size(frag),
 						     DMA_TO_DEVICE);
 		if (dma_mapping_error(&pdev->dev, dma_info[idx].dma)) {
+			TXQ_STATS_INC(txq, map_frag_err);
 			err = -EFAULT;
 			goto err_unmap_page;
 		}
@@ -260,6 +270,7 @@ static int hinic3_tx_csum(struct hinic3_txq *txq, struct hinic3_sq_task *task,
 		if (l4_proto != IPPROTO_UDP ||
 		    ((struct udphdr *)skb_transport_header(skb))->dest !=
 		    VXLAN_OFFLOAD_PORT_LE) {
+			TXQ_STATS_INC(txq, unknown_tunnel_pkt);
 			/* Unsupported tunnel packet, disable csum offload */
 			skb_checksum_help(skb);
 			return 0;
@@ -433,6 +444,27 @@ static u32 hinic3_tx_offload(struct sk_buff *skb, struct hinic3_sq_task *task,
 	return offload;
 }
 
+static void hinic3_get_pkt_stats(struct hinic3_txq *txq, struct sk_buff *skb)
+{
+	u32 hdr_len, tx_bytes;
+	unsigned short pkts;
+
+	if (skb_is_gso(skb)) {
+		hdr_len = (skb_shinfo(skb)->gso_segs - 1) *
+			  skb_tcp_all_headers(skb);
+		tx_bytes = skb->len + hdr_len;
+		pkts = skb_shinfo(skb)->gso_segs;
+	} else {
+		tx_bytes = skb->len > ETH_ZLEN ? skb->len : ETH_ZLEN;
+		pkts = 1;
+	}
+
+	u64_stats_update_begin(&txq->txq_stats.syncp);
+	txq->txq_stats.bytes += tx_bytes;
+	txq->txq_stats.packets += pkts;
+	u64_stats_update_end(&txq->txq_stats.syncp);
+}
+
 static u16 hinic3_get_and_update_sq_owner(struct hinic3_io_queue *sq,
 					  u16 curr_pi, u16 wqebb_cnt)
 {
@@ -539,8 +571,10 @@ static netdev_tx_t hinic3_send_one_skb(struct sk_buff *skb,
 	int err;
 
 	if (unlikely(skb->len < MIN_SKB_LEN)) {
-		if (skb_pad(skb, MIN_SKB_LEN - skb->len))
+		if (skb_pad(skb, MIN_SKB_LEN - skb->len)) {
+			TXQ_STATS_INC(txq, skb_pad_err);
 			goto err_out;
+		}
 
 		skb->len = MIN_SKB_LEN;
 	}
@@ -595,6 +629,7 @@ static netdev_tx_t hinic3_send_one_skb(struct sk_buff *skb,
 				  txq->tx_stop_thrs,
 				  txq->tx_start_thrs);
 
+	hinic3_get_pkt_stats(txq, skb);
 	hinic3_prepare_sq_ctrl(&wqe_combo, queue_info, num_sge, owner);
 	hinic3_write_db(txq->sq, 0, DB_CFLAG_DP_SQ,
 			hinic3_get_sq_local_pi(txq->sq));
@@ -604,6 +639,8 @@ static netdev_tx_t hinic3_send_one_skb(struct sk_buff *skb,
 err_drop_pkt:
 	dev_kfree_skb_any(skb);
 err_out:
+	TXQ_STATS_INC(txq, dropped);
+
 	return NETDEV_TX_OK;
 }
 
@@ -611,12 +648,22 @@ netdev_tx_t hinic3_xmit_frame(struct sk_buff *skb, struct net_device *netdev)
 {
 	struct hinic3_nic_dev *nic_dev = netdev_priv(netdev);
 	u16 q_id = skb_get_queue_mapping(skb);
+	struct hinic3_txq *txq;
 
-	if (unlikely(!netif_carrier_ok(netdev)))
+	if (unlikely(!netif_carrier_ok(netdev))) {
+		HINIC3_NIC_STATS_INC(nic_dev, tx_carrier_off_drop);
 		goto err_drop_pkt;
+	}
+
+	if (unlikely(q_id >= nic_dev->q_params.num_qps)) {
+		txq = &nic_dev->txqs[0];
+		u64_stats_update_begin(&txq->txq_stats.syncp);
+		txq->txq_stats.dropped++;
+		u64_stats_update_end(&txq->txq_stats.syncp);
 
-	if (unlikely(q_id >= nic_dev->q_params.num_qps))
+		HINIC3_NIC_STATS_INC(nic_dev, tx_invalid_qid);
 		goto err_drop_pkt;
+	}
 
 	return hinic3_send_one_skb(skb, netdev, &nic_dev->txqs[q_id]);
 
@@ -756,6 +803,23 @@ int hinic3_configure_txqs(struct net_device *netdev, u16 num_sq,
 	return 0;
 }
 
+void hinic3_txq_get_stats(struct hinic3_txq *txq,
+			  struct hinic3_txq_stats *stats)
+{
+	struct hinic3_txq_stats *txq_stats = &txq->txq_stats;
+	unsigned int start;
+
+	u64_stats_update_begin(&stats->syncp);
+	do {
+		start = u64_stats_fetch_begin(&txq_stats->syncp);
+		stats->bytes = txq_stats->bytes;
+		stats->packets = txq_stats->packets;
+		stats->busy = txq_stats->busy;
+		stats->dropped = txq_stats->dropped;
+	} while (u64_stats_fetch_retry(&txq_stats->syncp, start));
+	u64_stats_update_end(&stats->syncp);
+}
+
 bool hinic3_tx_poll(struct hinic3_txq *txq, int budget)
 {
 	struct net_device *netdev = txq->netdev;
diff --git a/drivers/net/ethernet/huawei/hinic3/hinic3_tx.h b/drivers/net/ethernet/huawei/hinic3/hinic3_tx.h
index 00194f2a1bcc..0a21c423618f 100644
--- a/drivers/net/ethernet/huawei/hinic3/hinic3_tx.h
+++ b/drivers/net/ethernet/huawei/hinic3/hinic3_tx.h
@@ -157,6 +157,8 @@ int hinic3_configure_txqs(struct net_device *netdev, u16 num_sq,
 			  u32 sq_depth, struct hinic3_dyna_txq_res *txqs_res);
 
 netdev_tx_t hinic3_xmit_frame(struct sk_buff *skb, struct net_device *netdev);
+void hinic3_txq_get_stats(struct hinic3_txq *txq,
+			  struct hinic3_txq_stats *stats);
 bool hinic3_tx_poll(struct hinic3_txq *txq, int budget);
 void hinic3_flush_txqs(struct net_device *netdev);
 
-- 
2.43.0


