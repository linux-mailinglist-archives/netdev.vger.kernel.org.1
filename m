Return-Path: <netdev+bounces-100176-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 8775B8D807D
	for <lists+netdev@lfdr.de>; Mon,  3 Jun 2024 13:04:00 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id AA64B1C21446
	for <lists+netdev@lfdr.de>; Mon,  3 Jun 2024 11:03:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DFFEF83CCB;
	Mon,  3 Jun 2024 11:03:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=denx.de header.i=@denx.de header.b="cy1pEwp0"
X-Original-To: netdev@vger.kernel.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 85FEC7E0FC;
	Mon,  3 Jun 2024 11:03:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=85.214.62.61
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717412636; cv=none; b=RCTr/3Tdjt+ZQAxqXmG+3OW0ib7bzSM1SnVrXShUZc7uKWESSVvjm7PgYVdXNLVK+MpKqT6yal62pTYv7pgwzHTr8odTE0AK8tZBbP4qH+uLei5XHnco1gbj/wWerlXxcF8esGcUGNIIX4KFfjPur/IrLY6xCacBNP/2g8aPf6w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717412636; c=relaxed/simple;
	bh=NpkjSkHGZeUe9c7hsdeK5vwkf+TbCfa8VW5GwxruLCU=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=d/cpFzOKLKGJCtXHIL+TZDsX8MH3wHFft1cmBUTimjUlZM5JAO7Hx7+NR520Pgi2GRSs4WioUDRAVu4ysSeiQE2xyPc+DH19omSjTMW+ACX+DuVgGnrfliWGFTEc9WyDXNHEMEUXLlhLIdeQmgPelY0tLeWQfvIumZJS9nXWiwo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=denx.de; spf=pass smtp.mailfrom=denx.de; dkim=pass (2048-bit key) header.d=denx.de header.i=@denx.de header.b=cy1pEwp0; arc=none smtp.client-ip=85.214.62.61
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=denx.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=denx.de
Received: from localhost.localdomain (85-222-111-42.dynamic.chello.pl [85.222.111.42])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
	(No client certificate requested)
	(Authenticated sender: lukma@denx.de)
	by phobos.denx.de (Postfix) with ESMTPSA id EC62787D1D;
	Mon,  3 Jun 2024 13:03:49 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=denx.de;
	s=phobos-20191101; t=1717412632;
	bh=xJ45bh48GVqYlmdtTWZwWBUq4raxArSg1WSjXgO6nic=;
	h=From:To:Cc:Subject:Date:From;
	b=cy1pEwp0zWhrg6jNFYLvQMFMt6XJ+TgWxC5sTYgKXN9jaA2wStRofFcvRSXGvRRcy
	 Iuw+l4kcxgyL0t6Bqci4ZUE/5wEriFX5+lh930+mE4/MZYr2FnLZggOrtCjcZxlU5K
	 AxEFG/qLJF16Y+RIX/25xRJvgguRl0G/36WJyJxwspkkwv5RyhbVthtCfyohRHaGzx
	 vN/7IkAcA6YzOVdiyCHNrB8PHEJ6PLP1hnRA3vNmuOs1Z9kPW578BFMsGKD3p32Z3U
	 BvgNAQlR2zGn+SwOcPFe9ir+d0yAnz2uGqBWIFgepK+p74fGJhIjjM03dge5G7TDkl
	 acWhNnRY+BsOw==
From: Lukasz Majewski <lukma@denx.de>
To: Jakub Kicinski <kuba@kernel.org>,
	netdev@vger.kernel.org,
	Paolo Abeni <pabeni@redhat.com>
Cc: Eric Dumazet <edumazet@google.com>,
	Vladimir Oltean <olteanv@gmail.com>,
	"David S. Miller" <davem@davemloft.net>,
	Oleksij Rempel <o.rempel@pengutronix.de>,
	Tristram.Ha@microchip.com,
	Sebastian Andrzej Siewior <bigeasy@linutronix.de>,
	Ravi Gunasekaran <r-gunasekaran@ti.com>,
	Simon Horman <horms@kernel.org>,
	Nikita Zhandarovich <n.zhandarovich@fintech.ru>,
	Murali Karicheri <m-karicheri2@ti.com>,
	Arvid Brodin <Arvid.Brodin@xdin.com>,
	Dan Carpenter <dan.carpenter@linaro.org>,
	"Ricardo B. Marliere" <ricardo@marliere.net>,
	Casper Andersson <casper.casan@gmail.com>,
	linux-kernel@vger.kernel.org,
	Hangbin Liu <liuhangbin@gmail.com>,
	Geliang Tang <tanggeliang@kylinos.cn>,
	Shuah Khan <shuah@kernel.org>,
	Shigeru Yoshida <syoshida@redhat.com>,
	Lukasz Majewski <lukma@denx.de>
Subject: [PATCH v1 net-next] net: hsr: Send supervisory frames to HSR network with ProxyNodeTable data
Date: Mon,  3 Jun 2024 13:03:29 +0200
Message-Id: <20240603110329.3157458-1-lukma@denx.de>
X-Mailer: git-send-email 2.39.2
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Virus-Scanned: clamav-milter 0.103.8 at phobos.denx.de
X-Virus-Status: Clean

This patch provides support for sending supervision HSR frames with
MAC addresses stored in ProxyNodeTable when RedBox (i.e. HSR-SAN) is
enabled.

Supervision frames with RedBox MAC address (appended as second TLV)
are only send for ProxyNodeTable nodes.

This patch series shall be tested with hsr_redbox.sh script.

Signed-off-by: Lukasz Majewski <lukma@denx.de>
---
 net/hsr/hsr_device.c   | 63 ++++++++++++++++++++++++++++++++++--------
 net/hsr/hsr_forward.c  | 40 +++++++++++++++++++++++++--
 net/hsr/hsr_framereg.c | 15 ++++++++++
 net/hsr/hsr_framereg.h |  2 ++
 net/hsr/hsr_main.h     |  4 ++-
 net/hsr/hsr_netlink.c  |  1 +
 6 files changed, 111 insertions(+), 14 deletions(-)

diff --git a/net/hsr/hsr_device.c b/net/hsr/hsr_device.c
index e6904288d40d..f85331d75454 100644
--- a/net/hsr/hsr_device.c
+++ b/net/hsr/hsr_device.c
@@ -73,9 +73,15 @@ static void hsr_check_announce(struct net_device *hsr_dev)
 			mod_timer(&hsr->announce_timer, jiffies +
 				  msecs_to_jiffies(HSR_ANNOUNCE_INTERVAL));
 		}
+
+		if (hsr->redbox && !timer_pending(&hsr->announce_proxy_timer))
+			mod_timer(&hsr->announce_proxy_timer, jiffies +
+				  msecs_to_jiffies(HSR_ANNOUNCE_INTERVAL) / 2);
 	} else {
 		/* Deactivate the announce timer  */
 		timer_delete(&hsr->announce_timer);
+		if (hsr->redbox)
+			timer_delete(&hsr->announce_proxy_timer);
 	}
 }
 
@@ -279,10 +285,11 @@ static struct sk_buff *hsr_init_skb(struct hsr_port *master)
 	return NULL;
 }
 
-static void send_hsr_supervision_frame(struct hsr_port *master,
-				       unsigned long *interval)
+static void send_hsr_supervision_frame(struct hsr_port *port,
+				       unsigned long *interval,
+				       const unsigned char addr[ETH_ALEN])
 {
-	struct hsr_priv *hsr = master->hsr;
+	struct hsr_priv *hsr = port->hsr;
 	__u8 type = HSR_TLV_LIFE_CHECK;
 	struct hsr_sup_payload *hsr_sp;
 	struct hsr_sup_tlv *hsr_stlv;
@@ -296,9 +303,9 @@ static void send_hsr_supervision_frame(struct hsr_port *master,
 		hsr->announce_count++;
 	}
 
-	skb = hsr_init_skb(master);
+	skb = hsr_init_skb(port);
 	if (!skb) {
-		netdev_warn_once(master->dev, "HSR: Could not send supervision frame\n");
+		netdev_warn_once(port->dev, "HSR: Could not send supervision frame\n");
 		return;
 	}
 
@@ -321,11 +328,12 @@ static void send_hsr_supervision_frame(struct hsr_port *master,
 	hsr_stag->tlv.HSR_TLV_length = hsr->prot_version ?
 				sizeof(struct hsr_sup_payload) : 12;
 
-	/* Payload: MacAddressA */
+	/* Payload: MacAddressA / SAN MAC from ProxyNodeTable */
 	hsr_sp = skb_put(skb, sizeof(struct hsr_sup_payload));
-	ether_addr_copy(hsr_sp->macaddress_A, master->dev->dev_addr);
+	ether_addr_copy(hsr_sp->macaddress_A, addr);
 
-	if (hsr->redbox) {
+	if (hsr->redbox &&
+	    hsr_is_node_in_db(&hsr->proxy_node_db, addr)) {
 		hsr_stlv = skb_put(skb, sizeof(struct hsr_sup_tlv));
 		hsr_stlv->HSR_TLV_type = PRP_TLV_REDBOX_MAC;
 		hsr_stlv->HSR_TLV_length = sizeof(struct hsr_sup_payload);
@@ -340,13 +348,14 @@ static void send_hsr_supervision_frame(struct hsr_port *master,
 		return;
 	}
 
-	hsr_forward_skb(skb, master);
+	hsr_forward_skb(skb, port);
 	spin_unlock_bh(&hsr->seqnr_lock);
 	return;
 }
 
 static void send_prp_supervision_frame(struct hsr_port *master,
-				       unsigned long *interval)
+				       unsigned long *interval,
+				       const unsigned char addr[ETH_ALEN])
 {
 	struct hsr_priv *hsr = master->hsr;
 	struct hsr_sup_payload *hsr_sp;
@@ -396,7 +405,7 @@ static void hsr_announce(struct timer_list *t)
 
 	rcu_read_lock();
 	master = hsr_port_get_hsr(hsr, HSR_PT_MASTER);
-	hsr->proto_ops->send_sv_frame(master, &interval);
+	hsr->proto_ops->send_sv_frame(master, &interval, master->dev->dev_addr);
 
 	if (is_admin_up(master->dev))
 		mod_timer(&hsr->announce_timer, jiffies + interval);
@@ -404,6 +413,37 @@ static void hsr_announce(struct timer_list *t)
 	rcu_read_unlock();
 }
 
+/* Announce (supervision frame) timer function for RedBox
+ */
+static void hsr_proxy_announce(struct timer_list *t)
+{
+	struct hsr_port *interlink;
+	unsigned long interval = 0;
+	struct hsr_node *node;
+	struct hsr_priv *hsr = from_timer(hsr, t, announce_proxy_timer);
+
+	rcu_read_lock();
+	/* RedBOX sends supervisory frames to HSR network with MAC addresses
+	 * of SAN nodes stored in ProxyNodeTable.
+	 */
+	interlink = hsr_port_get_hsr(hsr, HSR_PT_INTERLINK);
+	list_for_each_entry_rcu(node, &hsr->proxy_node_db, mac_list) {
+		if (hsr_addr_is_redbox(hsr, node->macaddress_A))
+			continue;
+		hsr->proto_ops->send_sv_frame(interlink, &interval,
+					      node->macaddress_A);
+	}
+
+	if (is_admin_up(interlink->dev)) {
+		if (interval == 0)
+			interval = msecs_to_jiffies(HSR_ANNOUNCE_INTERVAL);
+
+		mod_timer(&hsr->announce_proxy_timer, jiffies + interval);
+	}
+
+	rcu_read_unlock();
+}
+
 void hsr_del_ports(struct hsr_priv *hsr)
 {
 	struct hsr_port *port;
@@ -590,6 +630,7 @@ int hsr_dev_finalize(struct net_device *hsr_dev, struct net_device *slave[2],
 	timer_setup(&hsr->announce_timer, hsr_announce, 0);
 	timer_setup(&hsr->prune_timer, hsr_prune_nodes, 0);
 	timer_setup(&hsr->prune_proxy_timer, hsr_prune_proxy_nodes, 0);
+	timer_setup(&hsr->announce_proxy_timer, hsr_proxy_announce, 0);
 
 	ether_addr_copy(hsr->sup_multicast_addr, def_multicast_addr);
 	hsr->sup_multicast_addr[ETH_ALEN - 1] = multicast_spec;
diff --git a/net/hsr/hsr_forward.c b/net/hsr/hsr_forward.c
index 05a61b8286ec..2aa2621d8517 100644
--- a/net/hsr/hsr_forward.c
+++ b/net/hsr/hsr_forward.c
@@ -117,6 +117,38 @@ static bool is_supervision_frame(struct hsr_priv *hsr, struct sk_buff *skb)
 	return true;
 }
 
+static bool is_proxy_supervision_frame(struct hsr_priv *hsr,
+				       struct sk_buff *skb)
+{
+	struct hsr_sup_payload *payload;
+	struct ethhdr *eth_hdr;
+	u16 total_length = 0;
+
+	eth_hdr = (struct ethhdr *)skb_mac_header(skb);
+
+	/* Get the HSR protocol revision. */
+	if (eth_hdr->h_proto == htons(ETH_P_HSR))
+		total_length = sizeof(struct hsrv1_ethhdr_sp);
+	else
+		total_length = sizeof(struct hsrv0_ethhdr_sp);
+
+	if (!pskb_may_pull(skb, total_length))
+		return false;
+
+	skb_pull(skb, total_length);
+	payload = (struct hsr_sup_payload *)skb->data;
+	skb_push(skb, total_length);
+
+	/* For RedBox (HSR-SAN) check if we have received the supervision
+	 * frame with MAC addresses from own ProxyNodeTable.
+	 */
+	if (hsr_is_node_in_db(&hsr->proxy_node_db,
+			      payload->macaddress_A))
+		return true;
+
+	return false;
+}
+
 static struct sk_buff *create_stripped_skb_hsr(struct sk_buff *skb_in,
 					       struct hsr_frame_info *frame)
 {
@@ -499,7 +531,8 @@ static void hsr_forward_do(struct hsr_frame_info *frame)
 					   frame->sequence_nr))
 			continue;
 
-		if (frame->is_supervision && port->type == HSR_PT_MASTER) {
+		if (frame->is_supervision && port->type == HSR_PT_MASTER &&
+		    !frame->is_proxy_supervision) {
 			hsr_handle_sup_frame(frame);
 			continue;
 		}
@@ -637,6 +670,9 @@ static int fill_frame_info(struct hsr_frame_info *frame,
 
 	memset(frame, 0, sizeof(*frame));
 	frame->is_supervision = is_supervision_frame(port->hsr, skb);
+	if (frame->is_supervision && hsr->redbox)
+		frame->is_proxy_supervision =
+			is_proxy_supervision_frame(port->hsr, skb);
 
 	n_db = &hsr->node_db;
 	if (port->type == HSR_PT_INTERLINK)
@@ -688,7 +724,7 @@ void hsr_forward_skb(struct sk_buff *skb, struct hsr_port *port)
 	/* Gets called for ingress frames as well as egress from master port.
 	 * So check and increment stats for master port only here.
 	 */
-	if (port->type == HSR_PT_MASTER) {
+	if (port->type == HSR_PT_MASTER || port->type == HSR_PT_INTERLINK) {
 		port->dev->stats.tx_packets++;
 		port->dev->stats.tx_bytes += skb->len;
 	}
diff --git a/net/hsr/hsr_framereg.c b/net/hsr/hsr_framereg.c
index 614df9649794..8d2a5e8adf83 100644
--- a/net/hsr/hsr_framereg.c
+++ b/net/hsr/hsr_framereg.c
@@ -36,6 +36,17 @@ static bool seq_nr_after(u16 a, u16 b)
 #define seq_nr_before(a, b)		seq_nr_after((b), (a))
 #define seq_nr_before_or_eq(a, b)	(!seq_nr_after((a), (b)))
 
+bool hsr_addr_is_redbox(struct hsr_priv *hsr, unsigned char *addr)
+{
+	if (!hsr->redbox || !is_valid_ether_addr(hsr->macaddress_redbox))
+		return false;
+
+	if (ether_addr_equal(addr, hsr->macaddress_redbox))
+		return true;
+
+	return false;
+}
+
 bool hsr_addr_is_self(struct hsr_priv *hsr, unsigned char *addr)
 {
 	struct hsr_self_node *sn;
@@ -591,6 +602,10 @@ void hsr_prune_proxy_nodes(struct timer_list *t)
 
 	spin_lock_bh(&hsr->list_lock);
 	list_for_each_entry_safe(node, tmp, &hsr->proxy_node_db, mac_list) {
+		/* Don't prune RedBox node. */
+		if (hsr_addr_is_redbox(hsr, node->macaddress_A))
+			continue;
+
 		timestamp = node->time_in[HSR_PT_INTERLINK];
 
 		/* Prune old entries */
diff --git a/net/hsr/hsr_framereg.h b/net/hsr/hsr_framereg.h
index 7619e31c1d2d..993fa950d814 100644
--- a/net/hsr/hsr_framereg.h
+++ b/net/hsr/hsr_framereg.h
@@ -22,6 +22,7 @@ struct hsr_frame_info {
 	struct hsr_node *node_src;
 	u16 sequence_nr;
 	bool is_supervision;
+	bool is_proxy_supervision;
 	bool is_vlan;
 	bool is_local_dest;
 	bool is_local_exclusive;
@@ -35,6 +36,7 @@ struct hsr_node *hsr_get_node(struct hsr_port *port, struct list_head *node_db,
 			      enum hsr_port_type rx_port);
 void hsr_handle_sup_frame(struct hsr_frame_info *frame);
 bool hsr_addr_is_self(struct hsr_priv *hsr, unsigned char *addr);
+bool hsr_addr_is_redbox(struct hsr_priv *hsr, unsigned char *addr);
 
 void hsr_addr_subst_source(struct hsr_node *node, struct sk_buff *skb);
 void hsr_addr_subst_dest(struct hsr_node *node_src, struct sk_buff *skb,
diff --git a/net/hsr/hsr_main.h b/net/hsr/hsr_main.h
index 23850b16d1ea..ab1f8d35d9dc 100644
--- a/net/hsr/hsr_main.h
+++ b/net/hsr/hsr_main.h
@@ -170,7 +170,8 @@ struct hsr_node;
 
 struct hsr_proto_ops {
 	/* format and send supervision frame */
-	void (*send_sv_frame)(struct hsr_port *port, unsigned long *interval);
+	void (*send_sv_frame)(struct hsr_port *port, unsigned long *interval,
+			      const unsigned char addr[ETH_ALEN]);
 	void (*handle_san_frame)(bool san, enum hsr_port_type port,
 				 struct hsr_node *node);
 	bool (*drop_frame)(struct hsr_frame_info *frame, struct hsr_port *port);
@@ -197,6 +198,7 @@ struct hsr_priv {
 	struct list_head	proxy_node_db;	/* RedBox HSR proxy nodes */
 	struct hsr_self_node	__rcu *self_node;	/* MACs of slaves */
 	struct timer_list	announce_timer;	/* Supervision frame dispatch */
+	struct timer_list	announce_proxy_timer;
 	struct timer_list	prune_timer;
 	struct timer_list	prune_proxy_timer;
 	int announce_count;
diff --git a/net/hsr/hsr_netlink.c b/net/hsr/hsr_netlink.c
index 898f18c6da53..f6ff0b61e08a 100644
--- a/net/hsr/hsr_netlink.c
+++ b/net/hsr/hsr_netlink.c
@@ -131,6 +131,7 @@ static void hsr_dellink(struct net_device *dev, struct list_head *head)
 	del_timer_sync(&hsr->prune_timer);
 	del_timer_sync(&hsr->prune_proxy_timer);
 	del_timer_sync(&hsr->announce_timer);
+	timer_delete_sync(&hsr->announce_proxy_timer);
 
 	hsr_debugfs_term(hsr);
 	hsr_del_ports(hsr);
-- 
2.20.1


