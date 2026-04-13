Return-Path: <netdev+bounces-278009-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id wE1sJku03GlVVgkAu9opvQ
	(envelope-from <netdev+bounces-278009-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Mon, 13 Apr 2026 11:15:55 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id E553F3E9ADF
	for <lists+netdev@lfdr.de>; Mon, 13 Apr 2026 11:15:54 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 19AE43047BC8
	for <lists+netdev@lfdr.de>; Mon, 13 Apr 2026 09:09:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EED173AF659;
	Mon, 13 Apr 2026 09:09:48 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from zg8tmtyylji0my4xnjqumte4.icoremail.net (zg8tmtyylji0my4xnjqumte4.icoremail.net [162.243.164.118])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D1C983AEF5F
	for <netdev@vger.kernel.org>; Mon, 13 Apr 2026 09:09:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=162.243.164.118
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776071388; cv=none; b=Gem/Q/VJzrJoIVvx1RYT8Moeshhg8sFHdK7Q3ol1paA0lam7/gzVrovBJnBZjDKollA4U/EaYULAmKisL+uUjkvy9FP+jnMBm50vaRfJQ+Kw8XLABMGVj7F3Cwa51fC2VPaOfEw0teGjCnHuc9zljYobe+K7nXQ8LqYHEOyIoc8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776071388; c=relaxed/simple;
	bh=MdQzP6/OY331Npl4Keioe9hDdRPVOpTm7hZ5llDM89s=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=E8gjsy0xDaI7LYoFUyr/aE0QNsGOwiVzTXiqfBnTnUf3rsmXwhjmyeW7XXCcxHUg0kbpFLawJXWyvdW9g9mIDbse5AOBrI5zkG9p5Fl12hFD4xlWZD8fUlNqbU+FyeupCAreHiXT/e9NOorZxEyB9Zq6m7Tyux5udaF1EYy+w/c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=lzu.edu.cn; spf=pass smtp.mailfrom=lzu.edu.cn; arc=none smtp.client-ip=162.243.164.118
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=lzu.edu.cn
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lzu.edu.cn
Received: from enjou-Legion-Y7000P-2019.coin-barley.ts.net (unknown [172.23.56.36])
	by app2 (Coremail) with SMTP id zQmowABH4Ia7stxpfqI5AA--.31380S3;
	Mon, 13 Apr 2026 17:09:18 +0800 (CST)
From: Ren Wei <n05ec@lzu.edu.cn>
To: bridge@lists.linux.dev,
	netdev@vger.kernel.org
Cc: razor@blackwall.org,
	idosch@nvidia.com,
	davem@davemloft.net,
	edumazet@google.com,
	kuba@kernel.org,
	pabeni@redhat.com,
	horms@kernel.org,
	makita.toshiaki@lab.ntt.co.jp,
	vyasevic@redhat.com,
	yifanwucs@gmail.com,
	tomapufckgml@gmail.com,
	yuantan098@gmail.com,
	bird@lzu.edu.cn,
	enjou1224z@gmail.com,
	zcliangcn@gmail.com,
	n05ec@lzu.edu.cn
Subject: [PATCH net 1/1] net: bridge: use a stable FDB dst snapshot in RCU readers
Date: Mon, 13 Apr 2026 17:08:46 +0800
Message-ID: <6570fabb85ecadb8baaf019efe856f407711c7b9.1776043229.git.zcliangcn@gmail.com>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <cover.1776043229.git.zcliangcn@gmail.com>
References: <cover.1776043229.git.zcliangcn@gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:zQmowABH4Ia7stxpfqI5AA--.31380S3
X-Coremail-Antispam: 1UD129KBjvJXoW3Ar4Dtr18tFyxtrWDAw1fJFb_yoW7tF1rpF
	Z0gayfJrWkXr1a9w48ZFW8ZF1UtF4kGay5urZrA34FvFn8tFn5CayktFyavF1rAFZ5uFWa
	yr1jqrySvw1DXa7anT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
	9KBjDU0xBIdaVrnRJUUUBF1xkIjI8I6I8E6xAIw20EY4v20xvaj40_Wr0E3s1l1IIY67AE
	w4v_Jr0_Jr4l8cAvFVAK0II2c7xJM28CjxkF64kEwVA0rcxSw2x7M28EF7xvwVC0I7IYx2
	IY67AKxVW7JVWDJwA2z4x0Y4vE2Ix0cI8IcVCY1x0267AKxVW8Jr0_Cr1UM28EF7xvwVC2
	z280aVAFwI0_GcCE3s1l84ACjcxK6I8E87Iv6xkF7I0E14v26rxl6s0DM2AIxVAIcxkEcV
	Aq07x20xvEncxIr21l5I8CrVACY4xI64kE6c02F40Ex7xfMcIj6xIIjxv20xvE14v26r10
	6r15McIj6I8E87Iv67AKxVWUJVW8JwAm72CE4IkC6x0Yz7v_Jr0_Gr1lF7xvr2IYc2Ij64
	vIr41lF7I21c0EjII2zVCS5cI20VAGYxC7M4IIrI8v6xkF7I0E8cxan2IY04v7MxkF7I0E
	n4kS14v26r4a6rW5MxkIecxEwVCm-wCF04k20xvY0x0EwIxGrwCF04k20xvE74AGY7Cv6c
	x26r48MxC20s026xCaFVCjc4AY6r1j6r4UMI8I3I0E5I8CrVAFwI0_Jr0_Jr4lx2IqxVCj
	r7xvwVAFwI0_JrI_JrWlx4CE17CEb7AF67AKxVW8ZVWrXwCIc40Y0x0EwIxGrwCI42IY6x
	IIjxv20xvE14v26r1j6r1xMIIF0xvE2Ix0cI8IcVCY1x0267AKxVWxJVW8Jr1lIxAIcVCF
	04k26cxKx2IYs7xG6r1j6r1xMIIF0xvEx4A2jsIE14v26r1j6r4UMIIF0xvEx4A2jsIEc7
	CjxVAFwI0_Gr0_Gr1UYxBIdaVFxhVjvjDU0xZFpf9x0JUj4E_UUUUU=
X-CM-SenderInfo: zqqvvuo6o23hxhgxhubq/1tbiAQsQCWncrd8BFwAAsC
X-Spamd-Result: default: False [-0.96 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_MISSING_CHARSET(0.50)[];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	TAGGED_FROM(0.00)[bounces-278009-lists,netdev=lfdr.de];
	DMARC_NA(0.00)[lzu.edu.cn];
	FORGED_SENDER_MAILLIST(0.00)[];
	FREEMAIL_CC(0.00)[blackwall.org,nvidia.com,davemloft.net,google.com,kernel.org,redhat.com,lab.ntt.co.jp,gmail.com,lzu.edu.cn];
	RCVD_COUNT_THREE(0.00)[4];
	MIME_TRACE(0.00)[0:+];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	FROM_HAS_DN(0.00)[];
	NEURAL_HAM(-0.00)[-0.864];
	TO_DN_NONE(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[n05ec@lzu.edu.cn,netdev@vger.kernel.org];
	R_DKIM_NA(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[18];
	TAGGED_RCPT(0.00)[netdev];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,lzu.edu.cn:email]
X-Rspamd-Queue-Id: E553F3E9ADF
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

From: Zhengchuan Liang <zcliangcn@gmail.com>

Local FDB entries can be rewritten in place by `fdb_delete_local()`, which
updates `f->dst` to another port or to `NULL` while keeping the entry
alive. Several bridge RCU readers inspect `f->dst`, including
`br_fdb_fillbuf()` through the `brforward_read()` sysfs path.

These readers currently load `f->dst` multiple times and can therefore
observe inconsistent values across the check and later dereference.
In `br_fdb_fillbuf()`, this means a concurrent local-FDB update can change
`f->dst` after the NULL check and before the `port_no` dereference,
leading to a NULL-ptr-deref.

Fix this by taking a single `READ_ONCE()` snapshot of `f->dst` in each
affected RCU reader and using that snapshot for the rest of the access
sequence. Also publish the in-place `f->dst` updates in `fdb_delete_local()`
with `WRITE_ONCE()` so the readers and writer use matching access patterns.

Fixes: 960b589f86c7 ("bridge: Properly check if local fdb entry can be deleted in br_fdb_change_mac_address")
Cc: stable@kernel.org
Reported-by: Yifan Wu <yifanwucs@gmail.com>
Reported-by: Juefei Pu <tomapufckgml@gmail.com>
Co-developed-by: Yuan Tan <yuantan098@gmail.com>
Signed-off-by: Yuan Tan <yuantan098@gmail.com>
Suggested-by: Xin Liu <bird@lzu.edu.cn>
Tested-by: Ren Wei <enjou1224z@gmail.com>
Signed-off-by: Zhengchuan Liang <zcliangcn@gmail.com>
Signed-off-by: Ren Wei <n05ec@lzu.edu.cn>
---
 net/bridge/br_arp_nd_proxy.c |  8 +++++---
 net/bridge/br_fdb.c          | 28 ++++++++++++++++++----------
 2 files changed, 23 insertions(+), 13 deletions(-)

diff --git a/net/bridge/br_arp_nd_proxy.c b/net/bridge/br_arp_nd_proxy.c
index 6b5595868a39c..7ace0f4941bb6 100644
--- a/net/bridge/br_arp_nd_proxy.c
+++ b/net/bridge/br_arp_nd_proxy.c
@@ -202,11 +202,12 @@ void br_do_proxy_suppress_arp(struct sk_buff *skb, struct net_bridge *br,
 
 		f = br_fdb_find_rcu(br, n->ha, vid);
 		if (f) {
+			const struct net_bridge_port *dst = READ_ONCE(f->dst);
 			bool replied = false;
 
 			if ((p && (p->flags & BR_PROXYARP)) ||
-			    (f->dst && (f->dst->flags & BR_PROXYARP_WIFI)) ||
-			    br_is_neigh_suppress_enabled(f->dst, vid)) {
+			    (dst && (dst->flags & BR_PROXYARP_WIFI)) ||
+			    br_is_neigh_suppress_enabled(dst, vid)) {
 				if (!vid)
 					br_arp_send(br, p, skb->dev, sip, tip,
 						    sha, n->ha, sha, 0, 0);
@@ -470,9 +471,10 @@ void br_do_suppress_nd(struct sk_buff *skb, struct net_bridge *br,
 
 		f = br_fdb_find_rcu(br, n->ha, vid);
 		if (f) {
+			const struct net_bridge_port *dst = READ_ONCE(f->dst);
 			bool replied = false;
 
-			if (br_is_neigh_suppress_enabled(f->dst, vid)) {
+			if (br_is_neigh_suppress_enabled(dst, vid)) {
 				if (vid != 0)
 					br_nd_send(br, p, skb, n,
 						   skb->vlan_proto,
diff --git a/net/bridge/br_fdb.c b/net/bridge/br_fdb.c
index e2c17f620f009..6eb3ab69a5140 100644
--- a/net/bridge/br_fdb.c
+++ b/net/bridge/br_fdb.c
@@ -236,6 +236,7 @@ struct net_device *br_fdb_find_port(const struct net_device *br_dev,
 				    const unsigned char *addr,
 				    __u16 vid)
 {
+	const struct net_bridge_port *dst;
 	struct net_bridge_fdb_entry *f;
 	struct net_device *dev = NULL;
 	struct net_bridge *br;
@@ -248,8 +249,11 @@ struct net_device *br_fdb_find_port(const struct net_device *br_dev,
 	br = netdev_priv(br_dev);
 	rcu_read_lock();
 	f = br_fdb_find_rcu(br, addr, vid);
-	if (f && f->dst)
-		dev = f->dst->dev;
+	if (f) {
+		dst = READ_ONCE(f->dst);
+		if (dst)
+			dev = dst->dev;
+	}
 	rcu_read_unlock();
 
 	return dev;
@@ -346,7 +350,7 @@ static void fdb_delete_local(struct net_bridge *br,
 		vg = nbp_vlan_group(op);
 		if (op != p && ether_addr_equal(op->dev->dev_addr, addr) &&
 		    (!vid || br_vlan_find(vg, vid))) {
-			f->dst = op;
+			WRITE_ONCE(f->dst, op);
 			clear_bit(BR_FDB_ADDED_BY_USER, &f->flags);
 			return;
 		}
@@ -357,7 +361,7 @@ static void fdb_delete_local(struct net_bridge *br,
 	/* Maybe bridge device has same hw addr? */
 	if (p && ether_addr_equal(br->dev->dev_addr, addr) &&
 	    (!vid || (v && br_vlan_should_use(v)))) {
-		f->dst = NULL;
+		WRITE_ONCE(f->dst, NULL);
 		clear_bit(BR_FDB_ADDED_BY_USER, &f->flags);
 		return;
 	}
@@ -928,6 +932,7 @@ int br_fdb_test_addr(struct net_device *dev, unsigned char *addr)
 int br_fdb_fillbuf(struct net_bridge *br, void *buf,
 		   unsigned long maxnum, unsigned long skip)
 {
+	const struct net_bridge_port *dst;
 	struct net_bridge_fdb_entry *f;
 	struct __fdb_entry *fe = buf;
 	unsigned long delta;
@@ -944,7 +949,8 @@ int br_fdb_fillbuf(struct net_bridge *br, void *buf,
 			continue;
 
 		/* ignore pseudo entry for local MAC address */
-		if (!f->dst)
+		dst = READ_ONCE(f->dst);
+		if (!dst)
 			continue;
 
 		if (skip) {
@@ -956,8 +962,8 @@ int br_fdb_fillbuf(struct net_bridge *br, void *buf,
 		memcpy(fe->mac_addr, f->key.addr.addr, ETH_ALEN);
 
 		/* due to ABI compat need to split into hi/lo */
-		fe->port_no = f->dst->port_no;
-		fe->port_hi = f->dst->port_no >> 8;
+		fe->port_no = dst->port_no;
+		fe->port_hi = dst->port_no >> 8;
 
 		fe->is_local = test_bit(BR_FDB_LOCAL, &f->flags);
 		if (!test_bit(BR_FDB_STATIC, &f->flags)) {
@@ -1083,9 +1089,11 @@ int br_fdb_dump(struct sk_buff *skb,
 
 	rcu_read_lock();
 	hlist_for_each_entry_rcu(f, &br->fdb_list, fdb_node) {
+		const struct net_bridge_port *dst = READ_ONCE(f->dst);
+
 		if (*idx < ctx->fdb_idx)
 			goto skip;
-		if (filter_dev && (!f->dst || f->dst->dev != filter_dev)) {
+		if (filter_dev && (!dst || dst->dev != filter_dev)) {
 			if (filter_dev != dev)
 				goto skip;
 			/* !f->dst is a special case for bridge
@@ -1093,10 +1101,10 @@ int br_fdb_dump(struct sk_buff *skb,
 			 * Therefore need a little more filtering
 			 * we only want to dump the !f->dst case
 			 */
-			if (f->dst)
+			if (dst)
 				goto skip;
 		}
-		if (!filter_dev && f->dst)
+		if (!filter_dev && dst)
 			goto skip;
 
 		err = fdb_fill_info(skb, br, f,
-- 
2.43.0


