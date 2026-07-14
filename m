Return-Path: <netdev+bounces-307427-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id 6I5gHDEVVmqxywAAu9opvQ
	(envelope-from <netdev+bounces-307427-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Tue, 14 Jul 2026 12:53:37 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [172.232.135.74])
	by mail.lfdr.de (Postfix) with ESMTPS id 2E1B27539B2
	for <lists+netdev@lfdr.de>; Tue, 14 Jul 2026 12:53:37 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=redhat.com header.s=mimecast20190719 header.b=LpO37GZa;
	spf=pass (mail.lfdr.de: domain of "netdev+bounces-307427-lists+netdev=lfdr.de@vger.kernel.org" designates 172.232.135.74 as permitted sender) smtp.mailfrom="netdev+bounces-307427-lists+netdev=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=quarantine) header.from=redhat.com;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id 8AB73302B262
	for <lists+netdev@lfdr.de>; Tue, 14 Jul 2026 10:53:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0484036F419;
	Tue, 14 Jul 2026 10:53:32 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 884EA374E7F
	for <netdev@vger.kernel.org>; Tue, 14 Jul 2026 10:53:29 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784026411; cv=none; b=Ol1rjbM1Nsz3clumNPw3w8uok3EWM3gmRyJC3PhgykCis6lGuwIO8RfXQwb49LW+XFQP6mv+vWFO0cBSWytryUIIxjWOJ9RN8YZRdEb1iRF8LQ9XmI4T/CC4lC6otKnD8OYpGhjEM4ewe1QsstFL2WqguoO6wRGiwWNORDzTlG4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784026411; c=relaxed/simple;
	bh=TcPVb7lTJ0PdETOwazr9CTG4ohJkbeaFzwurNkxBwNk=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=pSZuCe46G7OM8ntARx2WcMI+IZbXIwKqTcKATxNTgPiQSk3fZ5mio7zokO+9xnd0VmZsazEvCXQC+V8P87GjOISHP0IsOkzHnvmHgHyjydXg7gPpGDbQqK/KPp9gBNPy5B5e9mgpWAr8vPFEDxHKUdpjtv9i4dWfyMhS9uUzMxg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=LpO37GZa; arc=none smtp.client-ip=170.10.129.124
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1784026408;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=8HTxuCDV2TCSgC4X1dMcC9cYNMOqf7itlIY2Hw5Sajk=;
	b=LpO37GZar4Q2X4RqmuAFm18rVQYF/cbH8PDuPv9EgBt6EvfH867rbwt7wdn8S2hR58Ou1g
	DpyAIeMKxwdiC4PnBmBuPpG0vYd3siffiknJhyUwQDFKj6bgi67fGOMOELaFzw6gj0Fd/s
	9dJd/YMP9XSaRgKQguoF8+OBwZ//AdM=
Received: from mx-prod-mc-03.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-543-l-Y2l9hfMwC6rWFoozxGEQ-1; Tue,
 14 Jul 2026 06:53:24 -0400
X-MC-Unique: l-Y2l9hfMwC6rWFoozxGEQ-1
X-Mimecast-MFC-AGG-ID: l-Y2l9hfMwC6rWFoozxGEQ_1784026403
Received: from mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.12])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id A5A601956048;
	Tue, 14 Jul 2026 10:53:22 +0000 (UTC)
Received: from thinkpad.redhat.corp (headnet03.pony-001.prod.iad2.dc.redhat.com [10.2.32.114])
	by mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP id 810DC1956089;
	Tue, 14 Jul 2026 10:53:17 +0000 (UTC)
From: Felix Maurer <fmaurer@redhat.com>
To: netdev@vger.kernel.org,
	davem@davemloft.net,
	edumazet@google.com,
	kuba@kernel.org,
	pabeni@redhat.com,
	horms@kernel.org
Cc: bigeasy@linutronix.de,
	fmancera@suse.de,
	liuhangbin@gmail.com,
	luka.gejak@linux.dev,
	xiaoliang.yang_1@nxp.com,
	kexinsun@smail.nju.edu.cn,
	ssrane_b23@ee.vjti.ac.in,
	michael.bommarito@gmail.com,
	2022090917019@std.uestc.edu.cn,
	yury.norov@gmail.com,
	jvaclav@redhat.com,
	maoyixie.tju@gmail.com
Subject: [RFC net-next 2/2] hsr: Remove second MAC address from node table
Date: Tue, 14 Jul 2026 12:52:43 +0200
Message-ID: <cb3c97efbf28181f9b8efc6a37e08d5a668c68e2.1784024900.git.fmaurer@redhat.com>
In-Reply-To: <cover.1784024900.git.fmaurer@redhat.com>
References: <cover.1784024900.git.fmaurer@redhat.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.12
X-Rspamd-Action: no action
X-Spamd-Result: default: False [0.84 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	MID_CONTAINS_FROM(1.00)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[redhat.com,quarantine];
	R_MISSING_CHARSET(0.50)[];
	R_SPF_ALLOW(-0.20)[+ip4:172.232.135.74:c];
	R_DKIM_ALLOW(-0.20)[redhat.com:s=mimecast20190719];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FREEMAIL_CC(0.00)[linutronix.de,suse.de,gmail.com,linux.dev,nxp.com,smail.nju.edu.cn,ee.vjti.ac.in,std.uestc.edu.cn,redhat.com];
	TAGGED_FROM(0.00)[bounces-307427-lists,netdev=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FORGED_SENDER(0.00)[fmaurer@redhat.com,netdev@vger.kernel.org];
	MIME_TRACE(0.00)[0:+];
	FORGED_RECIPIENTS(0.00)[m:netdev@vger.kernel.org,m:davem@davemloft.net,m:edumazet@google.com,m:kuba@kernel.org,m:pabeni@redhat.com,m:horms@kernel.org,m:bigeasy@linutronix.de,m:fmancera@suse.de,m:liuhangbin@gmail.com,m:luka.gejak@linux.dev,m:xiaoliang.yang_1@nxp.com,m:kexinsun@smail.nju.edu.cn,m:ssrane_b23@ee.vjti.ac.in,m:michael.bommarito@gmail.com,m:2022090917019@std.uestc.edu.cn,m:yury.norov@gmail.com,m:jvaclav@redhat.com,m:maoyixie.tju@gmail.com,m:michaelbommarito@gmail.com,m:yurynorov@gmail.com,m:maoyixietju@gmail.com,s:lists@lfdr.de];
	FORWARDED(0.00)[lists@lfdr.de];
	FORGED_SENDER_MAILLIST(0.00)[];
	DKIM_TRACE(0.00)[redhat.com:+];
	MISSING_XM_UA(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[18];
	PRECEDENCE_BULK(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[fmaurer@redhat.com,netdev@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCVD_COUNT_FIVE(0.00)[6];
	ALIAS_RESOLVED(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.232.128.0/19, country:SG];
	TO_DN_NONE(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[vger.kernel.org:from_smtp,sto.lore.kernel.org:helo,sto.lore.kernel.org:rdns]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 2E1B27539B2

Since its creation, the hsr module supported two MAC addresses per node in
the node table. Presumably, this was initially implemented to support an
address substitution mechanism for PRP. The IEC 62439-3:2010 calls this
property PICS_SUBS and it is optional to implement:

"Some applications require different MAC addresses on the redundant ports,
and these MAC addresses may be different from the default MAC address of
that node. This involves address substitution mechanisms which are not
specified in this International Standard. However, the basic protocol and
the frame format are prepared for such extension." (IEC 62439-3:2010,
4.1.7)

Note that this is from IEC 62439-3:2010, which standardizes PRPv0 which we
do not support at all. IEC 62439-3:2012 explicitly removed this address
substitution mechanism completely, leaving only a single MAC address per
node in the node table.

While the initial implementation aimed at supporting PICS_SUBS, this
developed into a situation where a lot of the code in the hsr module
assumed that nodes can/should have different MAC addresses on their two
ports. This is not the case.

Therefore, remove all references to MAC address B and concepts depending on
it (like the addr_B_port, i.e., the port where the second MAC address
should be used; and notably the address A terminology). This allows to get
rid of the node merging code as well. As the supervision frame parsing was
mostly superficial afterwards and we don't do anything with the data, it is
removed as well. Proper parsing of supervision frames can be added at a
later point again (probably after reworking the whole rx path a bit).

Signed-off-by: Felix Maurer <fmaurer@redhat.com>
---
 net/hsr/hsr_debugfs.c  |   9 +-
 net/hsr/hsr_device.c   |  17 ++-
 net/hsr/hsr_forward.c  |   8 +-
 net/hsr/hsr_framereg.c | 250 +++++------------------------------------
 net/hsr/hsr_framereg.h |  14 +--
 net/hsr/hsr_main.c     |   6 +-
 net/hsr/hsr_main.h     |   5 +-
 net/hsr/hsr_netlink.c  |  18 +--
 8 files changed, 46 insertions(+), 281 deletions(-)

diff --git a/net/hsr/hsr_debugfs.c b/net/hsr/hsr_debugfs.c
index 5b2cfac3b2ba..c6dcc9cdddee 100644
--- a/net/hsr/hsr_debugfs.c
+++ b/net/hsr/hsr_debugfs.c
@@ -23,8 +23,7 @@ hsr_node_table_show(struct seq_file *sfp, void *data)
 
 	seq_printf(sfp, "Node Table entries for (%s) device\n",
 		   (priv->prot_version == PRP_V1 ? "PRP" : "HSR"));
-	seq_puts(sfp, "MAC-Address-A,    MAC-Address-B,    time_in[A], ");
-	seq_puts(sfp, "time_in[B], Address-B port, ");
+	seq_puts(sfp, "MAC-Address-A,    time_in[A], time_in[B], ");
 	if (priv->prot_version == PRP_V1)
 		seq_puts(sfp, "SAN-A, SAN-B, DAN-P\n");
 	else
@@ -33,13 +32,11 @@ hsr_node_table_show(struct seq_file *sfp, void *data)
 	rcu_read_lock();
 	list_for_each_entry_rcu(node, &priv->node_db, mac_list) {
 		/* skip self node */
-		if (hsr_addr_is_self(priv, node->macaddress_A))
+		if (hsr_addr_is_self(priv, node->macaddress))
 			continue;
-		seq_printf(sfp, "%pM ", &node->macaddress_A[0]);
-		seq_printf(sfp, "%pM ", &node->macaddress_B[0]);
+		seq_printf(sfp, "%pM ", &node->macaddress[0]);
 		seq_printf(sfp, "%10lx, ", node->time_in[HSR_PT_SLAVE_A]);
 		seq_printf(sfp, "%10lx, ", node->time_in[HSR_PT_SLAVE_B]);
-		seq_printf(sfp, "%14x, ", node->addr_B_port);
 
 		if (priv->prot_version == PRP_V1)
 			seq_printf(sfp, "%5x, %5x, %5x\n",
diff --git a/net/hsr/hsr_device.c b/net/hsr/hsr_device.c
index a52079eb2adb..35457016a841 100644
--- a/net/hsr/hsr_device.c
+++ b/net/hsr/hsr_device.c
@@ -341,9 +341,9 @@ static void send_hsr_supervision_frame(struct hsr_port *port,
 	hsr_stag->tlv.HSR_TLV_length = hsr->prot_version ?
 				sizeof(struct hsr_sup_payload) : 12;
 
-	/* Payload: MacAddressA / SAN MAC from ProxyNodeTable */
+	/* Payload: MacAddress / SAN MAC from ProxyNodeTable */
 	hsr_sp = skb_put(skb, sizeof(struct hsr_sup_payload));
-	ether_addr_copy(hsr_sp->macaddress_A, addr);
+	ether_addr_copy(hsr_sp->macaddress, addr);
 
 	if (hsr->redbox &&
 	    hsr_is_node_in_db(&hsr->proxy_node_db, addr)) {
@@ -353,7 +353,7 @@ static void send_hsr_supervision_frame(struct hsr_port *port,
 
 		/* Payload: MacAddressRedBox */
 		hsr_sp = skb_put(skb, sizeof(struct hsr_sup_payload));
-		ether_addr_copy(hsr_sp->macaddress_A, hsr->macaddress_redbox);
+		ether_addr_copy(hsr_sp->macaddress, hsr->macaddress_redbox);
 	}
 
 	if (skb_put_padto(skb, ETH_ZLEN)) {
@@ -393,9 +393,9 @@ static void send_prp_supervision_frame(struct hsr_port *master,
 	hsr_stag->tlv.HSR_TLV_type = PRP_TLV_LIFE_CHECK_DD;
 	hsr_stag->tlv.HSR_TLV_length = sizeof(struct hsr_sup_payload);
 
-	/* Payload: MacAddressA */
+	/* Payload: MacAddress */
 	hsr_sp = skb_put(skb, sizeof(struct hsr_sup_payload));
-	ether_addr_copy(hsr_sp->macaddress_A, master->dev->dev_addr);
+	ether_addr_copy(hsr_sp->macaddress, master->dev->dev_addr);
 
 	if (skb_put_padto(skb, ETH_ZLEN)) {
 		spin_unlock_bh(&hsr->seqnr_lock);
@@ -445,10 +445,10 @@ static void hsr_proxy_announce(struct timer_list *t)
 		goto done;
 
 	list_for_each_entry_rcu(node, &hsr->proxy_node_db, mac_list) {
-		if (hsr_addr_is_redbox(hsr, node->macaddress_A))
+		if (hsr_addr_is_redbox(hsr, node->macaddress))
 			continue;
 		hsr->proto_ops->send_sv_frame(interlink, &interval,
-					      node->macaddress_A);
+					      node->macaddress);
 	}
 
 	if (is_admin_up(interlink->dev)) {
@@ -745,8 +745,7 @@ int hsr_dev_finalize(struct net_device *hsr_dev, struct net_device *slave[2],
 	}
 
 	/* Make sure we recognize frames from ourselves in hsr_handle_frame() */
-	res = hsr_create_self_node(hsr, hsr_dev->dev_addr,
-				   slave[1]->dev_addr);
+	res = hsr_create_self_node(hsr, hsr_dev->dev_addr);
 	if (res < 0)
 		return res;
 
diff --git a/net/hsr/hsr_forward.c b/net/hsr/hsr_forward.c
index 0774981a65c1..96dd01b9ee82 100644
--- a/net/hsr/hsr_forward.c
+++ b/net/hsr/hsr_forward.c
@@ -28,9 +28,6 @@ struct hsr_node;
  * 2) Use the LifeCheck frames to detect ring breaks. I.e. if no LifeCheck
  *    frame is received from a particular node, we know something is wrong.
  *    We just register these (as with normal frames) and throw them away.
- *
- * 3) Allow different MAC addresses for the two slave interfaces, using the
- *    MacAddressA field.
  */
 static bool is_supervision_frame(struct hsr_priv *hsr, struct sk_buff *skb)
 {
@@ -143,7 +140,7 @@ static bool is_proxy_supervision_frame(struct hsr_priv *hsr,
 	 * frame with MAC addresses from own ProxyNodeTable.
 	 */
 	return hsr_is_node_in_db(&hsr->proxy_node_db,
-				 payload->macaddress_A);
+				 payload->macaddress);
 }
 
 static struct sk_buff *create_stripped_skb_hsr(struct sk_buff *skb_in,
@@ -403,7 +400,6 @@ static void hsr_deliver_master(struct sk_buff *skb, struct net_device *dev,
 	int res, recv_len;
 
 	was_multicast_frame = (skb->pkt_type == PACKET_MULTICAST);
-	hsr_addr_subst_source(node_src, skb);
 	skb_pull(skb, ETH_HLEN);
 	recv_len = skb->len;
 	res = netif_rx(skb);
@@ -421,8 +417,6 @@ static int hsr_xmit(struct sk_buff *skb, struct hsr_port *port,
 		    struct hsr_frame_info *frame)
 {
 	if (frame->port_rcv->type == HSR_PT_MASTER) {
-		hsr_addr_subst_dest(frame->node_src, skb, port);
-
 		/* Address substitution (IEC62439-3 pp 26, 50): replace mac
 		 * address of outgoing frame with that of the outgoing slave's.
 		 */
diff --git a/net/hsr/hsr_framereg.c b/net/hsr/hsr_framereg.c
index e44929871274..12c2b6c4bd66 100644
--- a/net/hsr/hsr_framereg.c
+++ b/net/hsr/hsr_framereg.c
@@ -38,9 +38,7 @@ bool hsr_addr_is_self(struct hsr_priv *hsr, unsigned char *addr)
 	if (!sn)
 		goto out;
 
-	if (ether_addr_equal(addr, sn->macaddress_A) ||
-	    ether_addr_equal(addr, sn->macaddress_B))
-		ret = true;
+	ret = ether_addr_equal(addr, sn->macaddress);
 out:
 	rcu_read_unlock();
 	return ret;
@@ -48,13 +46,13 @@ bool hsr_addr_is_self(struct hsr_priv *hsr, unsigned char *addr)
 
 /* Search for mac entry. Caller must hold rcu read lock.
  */
-static struct hsr_node *find_node_by_addr_A(struct list_head *node_db,
-					    const unsigned char addr[ETH_ALEN])
+static struct hsr_node *find_node_by_addr(struct list_head *node_db,
+					  const unsigned char addr[ETH_ALEN])
 {
 	struct hsr_node *node;
 
 	list_for_each_entry_rcu(node, node_db, mac_list) {
-		if (ether_addr_equal(node->macaddress_A, addr))
+		if (ether_addr_equal(node->macaddress, addr))
 			return node;
 	}
 
@@ -66,15 +64,14 @@ static struct hsr_node *find_node_by_addr_A(struct list_head *node_db,
 bool hsr_is_node_in_db(struct list_head *node_db,
 		       const unsigned char addr[ETH_ALEN])
 {
-	return !!find_node_by_addr_A(node_db, addr);
+	return !!find_node_by_addr(node_db, addr);
 }
 
 /* Helper for device init; the self_node is used in hsr_handle_frame() to
  * recognize frames from self that's been looped over the HSR ring.
  */
 int hsr_create_self_node(struct hsr_priv *hsr,
-			 const unsigned char addr_a[ETH_ALEN],
-			 const unsigned char addr_b[ETH_ALEN])
+			 const unsigned char addr[ETH_ALEN])
 {
 	struct hsr_self_node *sn, *old;
 
@@ -82,8 +79,7 @@ int hsr_create_self_node(struct hsr_priv *hsr,
 	if (!sn)
 		return -ENOMEM;
 
-	ether_addr_copy(sn->macaddress_A, addr_a);
-	ether_addr_copy(sn->macaddress_B, addr_b);
+	ether_addr_copy(sn->macaddress, addr);
 
 	spin_lock_bh(&hsr->list_lock);
 	old = rcu_replace_pointer(hsr->self_node, sn,
@@ -121,40 +117,6 @@ static void hsr_free_node_rcu(struct rcu_head *rn)
 	hsr_free_node(node);
 }
 
-static void hsr_lock_seq_out_pair(struct hsr_node *node_a,
-				  struct hsr_node *node_b)
-{
-	if (node_a == node_b) {
-		spin_lock_bh(&node_a->seq_out_lock);
-		return;
-	}
-
-	if (node_a < node_b) {
-		spin_lock_bh(&node_a->seq_out_lock);
-		spin_lock_nested(&node_b->seq_out_lock, SINGLE_DEPTH_NESTING);
-	} else {
-		spin_lock_bh(&node_b->seq_out_lock);
-		spin_lock_nested(&node_a->seq_out_lock, SINGLE_DEPTH_NESTING);
-	}
-}
-
-static void hsr_unlock_seq_out_pair(struct hsr_node *node_a,
-				    struct hsr_node *node_b)
-{
-	if (node_a == node_b) {
-		spin_unlock_bh(&node_a->seq_out_lock);
-		return;
-	}
-
-	if (node_a < node_b) {
-		spin_unlock(&node_b->seq_out_lock);
-		spin_unlock_bh(&node_a->seq_out_lock);
-	} else {
-		spin_unlock(&node_a->seq_out_lock);
-		spin_unlock_bh(&node_b->seq_out_lock);
-	}
-}
-
 void hsr_del_nodes(struct list_head *node_db)
 {
 	struct hsr_node *node;
@@ -179,7 +141,7 @@ void prp_handle_san_frame(bool san, enum hsr_port_type port,
 		node->san_b = true;
 }
 
-/* Allocate an hsr_node and add it to node_db. 'addr' is the node's address_A.
+/* Allocate an hsr_node and add it to node_db.
  */
 static struct hsr_node *hsr_add_node(struct hsr_priv *hsr,
 				     struct list_head *node_db,
@@ -195,7 +157,7 @@ static struct hsr_node *hsr_add_node(struct hsr_priv *hsr,
 	if (!new_node)
 		return NULL;
 
-	ether_addr_copy(new_node->macaddress_A, addr);
+	ether_addr_copy(new_node->macaddress, addr);
 	spin_lock_init(&new_node->seq_out_lock);
 
 	if (hsr->prot_version == PRP_V1)
@@ -224,9 +186,7 @@ static struct hsr_node *hsr_add_node(struct hsr_priv *hsr,
 	spin_lock_bh(&hsr->list_lock);
 	list_for_each_entry_rcu(node, node_db, mac_list,
 				lockdep_is_held(&hsr->list_lock)) {
-		if (ether_addr_equal(node->macaddress_A, addr))
-			goto out;
-		if (ether_addr_equal(node->macaddress_B, addr))
+		if (ether_addr_equal(node->macaddress, addr))
 			goto out;
 	}
 	list_add_tail_rcu(&new_node->mac_list, node_db);
@@ -267,12 +227,7 @@ struct hsr_node *hsr_get_node(struct hsr_port *port, struct list_head *node_db,
 	ethhdr = (struct ethhdr *)skb_mac_header(skb);
 
 	list_for_each_entry_rcu(node, node_db, mac_list) {
-		if (ether_addr_equal(node->macaddress_A, ethhdr->h_source)) {
-			if (hsr->proto_ops->update_san_info)
-				hsr->proto_ops->update_san_info(node, is_sup);
-			return node;
-		}
-		if (ether_addr_equal(node->macaddress_B, ethhdr->h_source)) {
+		if (ether_addr_equal(node->macaddress, ethhdr->h_source)) {
 			if (hsr->proto_ops->update_san_info)
 				hsr->proto_ops->update_san_info(node, is_sup);
 			return node;
@@ -281,7 +236,7 @@ struct hsr_node *hsr_get_node(struct hsr_port *port, struct list_head *node_db,
 
 	/* Check if required node is not in proxy nodes table */
 	list_for_each_entry_rcu(node, &hsr->proxy_node_db, mac_list) {
-		if (ether_addr_equal(node->macaddress_A, ethhdr->h_source)) {
+		if (ether_addr_equal(node->macaddress, ethhdr->h_source)) {
 			if (hsr->proto_ops->update_san_info)
 				hsr->proto_ops->update_san_info(node, is_sup);
 			return node;
@@ -363,26 +318,19 @@ VISIBLE_IF_KUNIT struct hsr_seq_block *hsr_get_seq_block(struct hsr_node *node,
 }
 EXPORT_SYMBOL_IF_KUNIT(hsr_get_seq_block);
 
-/* Use the Supervision frame's info about an eventual macaddress_B for merging
- * nodes that has previously had their macaddress_B registered as a separate
- * node.
+/* Use the Supervision frame's info to ensure the node is in the node table.
  */
 void hsr_handle_sup_frame(struct hsr_frame_info *frame)
 {
-	struct hsr_node *node_curr = frame->node_src;
 	struct hsr_port *port_rcv = frame->port_rcv;
-	struct hsr_seq_block *src_blk, *merge_blk;
 	struct hsr_priv *hsr = port_rcv->hsr;
-	struct hsr_sup_tlv *hsr_sup_tlv;
 	struct hsr_sup_payload *hsr_sp;
-	struct hsr_node *node_real;
 	struct sk_buff *skb = NULL;
 	struct list_head *node_db;
+	struct hsr_node *node;
 	struct ethhdr *ethhdr;
 	unsigned int total_pull_size = 0;
 	unsigned int pull_size = 0;
-	unsigned long idx;
-	int i;
 
 	/* Here either frame->skb_hsr or frame->skb_prp should be
 	 * valid as supervision frame always will have protocol
@@ -419,146 +367,19 @@ void hsr_handle_sup_frame(struct hsr_frame_info *frame)
 	/* get HSR sup payload */
 	hsr_sp = (struct hsr_sup_payload *)skb->data;
 
-	/* Merge node_curr (registered on macaddress_B) into node_real */
 	node_db = &port_rcv->hsr->node_db;
-	node_real = find_node_by_addr_A(node_db, hsr_sp->macaddress_A);
-	if (!node_real)
-		/* No frame received from AddrA of this node yet */
-		node_real = hsr_add_node(hsr, node_db, hsr_sp->macaddress_A,
-					 true, port_rcv->type);
-	if (!node_real)
-		goto done; /* No mem */
-	if (node_real == node_curr)
-		/* Node has already been merged */
-		goto done;
-
-	/* Leave the first HSR sup payload. */
-	pull_size = sizeof(struct hsr_sup_payload);
-	skb_pull(skb, pull_size);
-	total_pull_size += pull_size;
-
-	/* Get second supervision tlv */
-	hsr_sup_tlv = (struct hsr_sup_tlv *)skb->data;
-	/* And check if it is a redbox mac TLV */
-	if (hsr_sup_tlv->HSR_TLV_type == PRP_TLV_REDBOX_MAC) {
-		/* We could stop here after pushing hsr_sup_payload,
-		 * or proceed and allow macaddress_B and for redboxes.
+	node = find_node_by_addr(node_db, hsr_sp->macaddress);
+	if (!node)
+		/* Node doesn't appear in node_db yet, hsr_add_node() will
+		 * check again under lock before really adding.
 		 */
-		/* Sanity check length */
-		if (hsr_sup_tlv->HSR_TLV_length != 6)
-			goto done;
-
-		/* Leave the second HSR sup tlv. */
-		pull_size = sizeof(struct hsr_sup_tlv);
-		skb_pull(skb, pull_size);
-		total_pull_size += pull_size;
-
-		/* Get redbox mac address. */
-		hsr_sp = (struct hsr_sup_payload *)skb->data;
-
-		/* Check if redbox mac and node mac are equal. */
-		if (!ether_addr_equal(node_real->macaddress_A, hsr_sp->macaddress_A)) {
-			/* This is a redbox supervision frame for a VDAN! */
-			goto done;
-		}
-	}
-
-	ether_addr_copy(node_real->macaddress_B, ethhdr->h_source);
-	hsr_lock_seq_out_pair(node_real, node_curr);
-	for (i = 0; i < HSR_PT_PORTS; i++) {
-		if (!node_curr->time_in_stale[i] &&
-		    time_after(node_curr->time_in[i], node_real->time_in[i])) {
-			node_real->time_in[i] = node_curr->time_in[i];
-			node_real->time_in_stale[i] =
-						node_curr->time_in_stale[i];
-		}
-	}
-
-	xa_for_each(&node_curr->seq_blocks, idx, src_blk) {
-		if (hsr_seq_block_is_old(src_blk))
-			continue;
-
-		merge_blk = hsr_get_seq_block(node_real, src_blk->block_idx);
-		if (!merge_blk)
-			continue;
-		merge_blk->time = min(merge_blk->time, src_blk->time);
-		for (i = 0; i < node_real->seq_port_cnt; i++) {
-			bitmap_or(merge_blk->seq_nrs[i], merge_blk->seq_nrs[i],
-				  src_blk->seq_nrs[i], HSR_SEQ_BLOCK_SIZE);
-		}
-	}
-	hsr_unlock_seq_out_pair(node_real, node_curr);
-	node_real->addr_B_port = port_rcv->type;
+		hsr_add_node(hsr, node_db, hsr_sp->macaddress, true,
+			     port_rcv->type);
 
-	spin_lock_bh(&hsr->list_lock);
-	if (!node_curr->removed) {
-		list_del_rcu(&node_curr->mac_list);
-		node_curr->removed = true;
-		call_rcu(&node_curr->rcu_head, hsr_free_node_rcu);
-	}
-	spin_unlock_bh(&hsr->list_lock);
-
-done:
 	/* Push back here */
 	skb_push(skb, total_pull_size);
 }
 
-/* 'skb' is a frame meant for this host, that is to be passed to upper layers.
- *
- * If the frame was sent by a node's B interface, replace the source
- * address with that node's "official" address (macaddress_A) so that upper
- * layers recognize where it came from.
- */
-void hsr_addr_subst_source(struct hsr_node *node, struct sk_buff *skb)
-{
-	if (!skb_mac_header_was_set(skb)) {
-		WARN_ONCE(1, "%s: Mac header not set\n", __func__);
-		return;
-	}
-
-	memcpy(&eth_hdr(skb)->h_source, node->macaddress_A, ETH_ALEN);
-}
-
-/* 'skb' is a frame meant for another host.
- * 'port' is the outgoing interface
- *
- * Substitute the target (dest) MAC address if necessary, so the it matches the
- * recipient interface MAC address, regardless of whether that is the
- * recipient's A or B interface.
- * This is needed to keep the packets flowing through switches that learn on
- * which "side" the different interfaces are.
- */
-void hsr_addr_subst_dest(struct hsr_node *node_src, struct sk_buff *skb,
-			 struct hsr_port *port)
-{
-	struct hsr_node *node_dst;
-
-	if (!skb_mac_header_was_set(skb)) {
-		WARN_ONCE(1, "%s: Mac header not set\n", __func__);
-		return;
-	}
-
-	if (!is_unicast_ether_addr(eth_hdr(skb)->h_dest))
-		return;
-
-	node_dst = find_node_by_addr_A(&port->hsr->node_db,
-				       eth_hdr(skb)->h_dest);
-	if (!node_dst && port->hsr->redbox)
-		node_dst = find_node_by_addr_A(&port->hsr->proxy_node_db,
-					       eth_hdr(skb)->h_dest);
-
-	if (!node_dst) {
-		if (port->hsr->prot_version != PRP_V1 && net_ratelimit())
-			netdev_err(skb->dev, "%s: Unknown node\n", __func__);
-		return;
-	}
-	if (port->type != node_dst->addr_B_port)
-		return;
-
-	if (is_valid_ether_addr(node_dst->macaddress_B))
-		ether_addr_copy(eth_hdr(skb)->h_dest, node_dst->macaddress_B);
-}
-
 void hsr_register_frame_in(struct hsr_node *node, struct hsr_port *port,
 			   u16 sequence_nr)
 {
@@ -698,7 +519,7 @@ void hsr_prune_nodes(struct timer_list *t)
 		 * the master port. Thus the master node will be repeatedly
 		 * pruned leading to packet loss.
 		 */
-		if (hsr_addr_is_self(hsr, node->macaddress_A))
+		if (hsr_addr_is_self(hsr, node->macaddress))
 			continue;
 
 		/* Shorthand */
@@ -727,14 +548,14 @@ void hsr_prune_nodes(struct timer_list *t)
 			rcu_read_lock();
 			port = get_late_port(hsr, node);
 			if (port)
-				hsr_nl_ringerror(hsr, node->macaddress_A, port);
+				hsr_nl_ringerror(hsr, node->macaddress, port);
 			rcu_read_unlock();
 		}
 
 		/* Prune old entries */
 		if (time_is_before_jiffies(timestamp +
 				msecs_to_jiffies(HSR_NODE_FORGET_TIME))) {
-			hsr_nl_nodedown(hsr, node->macaddress_A);
+			hsr_nl_nodedown(hsr, node->macaddress);
 			if (!node->removed) {
 				list_del_rcu(&node->mac_list);
 				node->removed = true;
@@ -760,7 +581,7 @@ void hsr_prune_proxy_nodes(struct timer_list *t)
 	spin_lock_bh(&hsr->list_lock);
 	list_for_each_entry_safe(node, tmp, &hsr->proxy_node_db, mac_list) {
 		/* Don't prune RedBox node. */
-		if (hsr_addr_is_redbox(hsr, node->macaddress_A))
+		if (hsr_addr_is_redbox(hsr, node->macaddress))
 			continue;
 
 		timestamp = node->time_in[HSR_PT_INTERLINK];
@@ -768,7 +589,7 @@ void hsr_prune_proxy_nodes(struct timer_list *t)
 		/* Prune old entries */
 		if (time_is_before_jiffies(timestamp +
 				msecs_to_jiffies(HSR_PROXY_NODE_FORGET_TIME))) {
-			hsr_nl_nodedown(hsr, node->macaddress_A);
+			hsr_nl_nodedown(hsr, node->macaddress);
 			if (!node->removed) {
 				list_del_rcu(&node->mac_list);
 				node->removed = true;
@@ -794,13 +615,13 @@ void *hsr_get_next_node(struct hsr_priv *hsr, void *_pos,
 		node = list_first_or_null_rcu(&hsr->node_db,
 					      struct hsr_node, mac_list);
 		if (node)
-			ether_addr_copy(addr, node->macaddress_A);
+			ether_addr_copy(addr, node->macaddress);
 		return node;
 	}
 
 	node = _pos;
 	list_for_each_entry_continue_rcu(node, &hsr->node_db, mac_list) {
-		ether_addr_copy(addr, node->macaddress_A);
+		ether_addr_copy(addr, node->macaddress);
 		return node;
 	}
 
@@ -840,23 +661,18 @@ static void fill_last_seq_nrs(struct hsr_node *node, u16 *if1_seq, u16 *if2_seq)
 
 int hsr_get_node_data(struct hsr_priv *hsr,
 		      const unsigned char *addr,
-		      unsigned char addr_b[ETH_ALEN],
-		      unsigned int *addr_b_ifindex,
 		      int *if1_age,
 		      u16 *if1_seq,
 		      int *if2_age,
 		      u16 *if2_seq)
 {
 	struct hsr_node *node;
-	struct hsr_port *port;
 	unsigned long tdiff;
 
-	node = find_node_by_addr_A(&hsr->node_db, addr);
+	node = find_node_by_addr(&hsr->node_db, addr);
 	if (!node)
 		return -ENOENT;
 
-	ether_addr_copy(addr_b, node->macaddress_B);
-
 	tdiff = jiffies - node->time_in[HSR_PT_SLAVE_A];
 	if (node->time_in_stale[HSR_PT_SLAVE_A])
 		*if1_age = INT_MAX;
@@ -883,15 +699,5 @@ int hsr_get_node_data(struct hsr_priv *hsr,
 	if (hsr->prot_version != PRP_V1)
 		fill_last_seq_nrs(node, if1_seq, if2_seq);
 
-	if (node->addr_B_port != HSR_PT_NONE) {
-		port = hsr_port_get_hsr(hsr, node->addr_B_port);
-		if (port)
-			*addr_b_ifindex = port->dev->ifindex;
-		else
-			*addr_b_ifindex = -1;
-	} else {
-		*addr_b_ifindex = -1;
-	}
-
 	return 0;
 }
diff --git a/net/hsr/hsr_framereg.h b/net/hsr/hsr_framereg.h
index c65ecb925734..bb18b15c25ef 100644
--- a/net/hsr/hsr_framereg.h
+++ b/net/hsr/hsr_framereg.h
@@ -38,10 +38,6 @@ void hsr_handle_sup_frame(struct hsr_frame_info *frame);
 bool hsr_addr_is_self(struct hsr_priv *hsr, unsigned char *addr);
 bool hsr_addr_is_redbox(struct hsr_priv *hsr, unsigned char *addr);
 
-void hsr_addr_subst_source(struct hsr_node *node, struct sk_buff *skb);
-void hsr_addr_subst_dest(struct hsr_node *node_src, struct sk_buff *skb,
-			 struct hsr_port *port);
-
 void hsr_register_frame_in(struct hsr_node *node, struct hsr_port *port,
 			   u16 sequence_nr);
 int hsr_register_frame_out(struct hsr_port *port, struct hsr_frame_info *frame);
@@ -50,16 +46,13 @@ void hsr_prune_nodes(struct timer_list *t);
 void hsr_prune_proxy_nodes(struct timer_list *t);
 
 int hsr_create_self_node(struct hsr_priv *hsr,
-			 const unsigned char addr_a[ETH_ALEN],
-			 const unsigned char addr_b[ETH_ALEN]);
+			 const unsigned char addr[ETH_ALEN]);
 
 void *hsr_get_next_node(struct hsr_priv *hsr, void *_pos,
 			unsigned char addr[ETH_ALEN]);
 
 int hsr_get_node_data(struct hsr_priv *hsr,
 		      const unsigned char *addr,
-		      unsigned char addr_b[ETH_ALEN],
-		      unsigned int *addr_b_ifindex,
 		      int *if1_age,
 		      u16 *if1_seq,
 		      int *if2_age,
@@ -99,10 +92,7 @@ struct hsr_node {
 	struct list_head	mac_list;
 	/* Protect R/W access seq_blocks */
 	spinlock_t		seq_out_lock;
-	unsigned char		macaddress_A[ETH_ALEN];
-	unsigned char		macaddress_B[ETH_ALEN];
-	/* Local slave through which AddrB frames are received from this node */
-	enum hsr_port_type	addr_B_port;
+	unsigned char		macaddress[ETH_ALEN];
 	unsigned long		time_in[HSR_PT_PORTS];
 	bool			time_in_stale[HSR_PT_PORTS];
 	/* if the node is a SAN */
diff --git a/net/hsr/hsr_main.c b/net/hsr/hsr_main.c
index 202cf2a3625f..6708145cb423 100644
--- a/net/hsr/hsr_main.c
+++ b/net/hsr/hsr_main.c
@@ -88,12 +88,8 @@ static int hsr_netdev_notify(struct notifier_block *nb, unsigned long event,
 		}
 
 		/* Make sure we recognize frames from ourselves in hsr_handle_frame() */
-		port = hsr_port_get_hsr(hsr, HSR_PT_SLAVE_B);
 		res = hsr_create_self_node(hsr,
-					   master->dev->dev_addr,
-					   port ?
-						port->dev->dev_addr :
-						master->dev->dev_addr);
+					   master->dev->dev_addr);
 		if (res)
 			netdev_warn(master->dev,
 				    "Could not update HSR node address.\n");
diff --git a/net/hsr/hsr_main.h b/net/hsr/hsr_main.h
index 134e4f3fff60..78b24ee6beca 100644
--- a/net/hsr/hsr_main.h
+++ b/net/hsr/hsr_main.h
@@ -97,7 +97,7 @@ struct hsr_sup_tag {
 } __packed;
 
 struct hsr_sup_payload {
-	unsigned char	macaddress_A[ETH_ALEN];
+	unsigned char	macaddress[ETH_ALEN];
 } __packed;
 
 static inline void set_hsr_stag_path(struct hsr_sup_tag *hst, u16 path)
@@ -181,8 +181,7 @@ struct hsr_proto_ops {
 };
 
 struct hsr_self_node {
-	unsigned char	macaddress_A[ETH_ALEN];
-	unsigned char	macaddress_B[ETH_ALEN];
+	unsigned char	macaddress[ETH_ALEN];
 	struct rcu_head	rcu_head;
 };
 
diff --git a/net/hsr/hsr_netlink.c b/net/hsr/hsr_netlink.c
index 8099f2069a74..958b7b3c5be5 100644
--- a/net/hsr/hsr_netlink.c
+++ b/net/hsr/hsr_netlink.c
@@ -327,12 +327,10 @@ static int hsr_get_node_status(struct sk_buff *skb_in, struct genl_info *info)
 	void *msg_head;
 	struct hsr_priv *hsr;
 	struct hsr_port *port;
-	unsigned char hsr_node_addr_b[ETH_ALEN];
 	int hsr_node_if1_age;
 	u16 hsr_node_if1_seq;
 	int hsr_node_if2_age;
 	u16 hsr_node_if2_seq;
-	int addr_b_ifindex;
 	int res;
 
 	if (!info)
@@ -376,8 +374,6 @@ static int hsr_get_node_status(struct sk_buff *skb_in, struct genl_info *info)
 	res = hsr_get_node_data(hsr,
 				(unsigned char *)
 				nla_data(info->attrs[HSR_A_NODE_ADDR]),
-					 hsr_node_addr_b,
-					 &addr_b_ifindex,
 					 &hsr_node_if1_age,
 					 &hsr_node_if1_seq,
 					 &hsr_node_if2_age,
@@ -390,18 +386,6 @@ static int hsr_get_node_status(struct sk_buff *skb_in, struct genl_info *info)
 	if (res < 0)
 		goto nla_put_failure;
 
-	if (addr_b_ifindex > -1) {
-		res = nla_put(skb_out, HSR_A_NODE_ADDR_B, ETH_ALEN,
-			      hsr_node_addr_b);
-		if (res < 0)
-			goto nla_put_failure;
-
-		res = nla_put_u32(skb_out, HSR_A_ADDR_B_IFINDEX,
-				  addr_b_ifindex);
-		if (res < 0)
-			goto nla_put_failure;
-	}
-
 	res = nla_put_u32(skb_out, HSR_A_IF1_AGE, hsr_node_if1_age);
 	if (res < 0)
 		goto nla_put_failure;
@@ -450,7 +434,7 @@ static int hsr_get_node_status(struct sk_buff *skb_in, struct genl_info *info)
 	return res;
 }
 
-/* Get a list of MacAddressA of all nodes known to this node (including self).
+/* Get a list of MAC addresses of all nodes known to this node (including self).
  */
 static int hsr_get_node_list(struct sk_buff *skb_in, struct genl_info *info)
 {
-- 
2.55.0


