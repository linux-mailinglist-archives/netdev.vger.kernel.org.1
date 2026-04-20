Return-Path: <netdev+bounces-279653-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id iA02DNac5Wm1mAEAu9opvQ
	(envelope-from <netdev+bounces-279653-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Mon, 20 Apr 2026 05:26:14 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 581194268BA
	for <lists+netdev@lfdr.de>; Mon, 20 Apr 2026 05:26:13 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id E3E7D301E3F5
	for <lists+netdev@lfdr.de>; Mon, 20 Apr 2026 03:24:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D2DA537FF43;
	Mon, 20 Apr 2026 03:24:34 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from zg8tmja2lje4os4yms4ymjma.icoremail.net (zg8tmja2lje4os4yms4ymjma.icoremail.net [206.189.21.223])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 784B637F8B3
	for <netdev@vger.kernel.org>; Mon, 20 Apr 2026 03:24:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=206.189.21.223
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776655474; cv=none; b=A2Z4q4T86iaKq2gD3fW2i/i59mhF81iEwZyD9pgITpAcLsyNJv7v+fTXKeHuZ54AdpdD74Gi9PBK4r+Ies1jyQDbLIuSVbDp/cgIlUYr5ugl0BMdhqersYb2mPUbiNk145YjX4Rh2NTGltu/ESdYMI8F4QEoGVEOMy4GB/quIHs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776655474; c=relaxed/simple;
	bh=M+x1mxnL9HD/lIcPdVtrSaBErT3UKjLwCKziPJuBHOY=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=ghP/1SNLjdUeEoat5GIiViSZnblvMnYqiC03i3KadVGURPdl0/FcMafQdprs8t3tfgX4WzdlMRRAaZWm5Stux2BR4OHwZPqYBOyywAFovHz/SLlHY5IqEV5/SauNXGcMR86SqZZ130nAzlfIrUihu6a65DX4HsCtURTGI8YlQJ4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=lzu.edu.cn; spf=pass smtp.mailfrom=lzu.edu.cn; arc=none smtp.client-ip=206.189.21.223
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=lzu.edu.cn
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lzu.edu.cn
Received: from enjou-Legion-Y7000P-2019.coin-barley.ts.net (unknown [172.23.56.36])
	by app1 (Coremail) with SMTP id ygmowACnHwBXnOVpn7DVAA--.49940S2;
	Mon, 20 Apr 2026 11:24:08 +0800 (CST)
From: Ren Wei <n05ec@lzu.edu.cn>
To: netdev@vger.kernel.org,
	horms@kernel.org,
	edumazet@google.com
Cc: andrew+netdev@lunn.ch,
	davem@davemloft.net,
	kuba@kernel.org,
	pabeni@redhat.com,
	kees@kernel.org,
	yuantan098@gmail.com,
	ylong030@ucr.edu,
	n05ec@lzu.edu.cn,
	yifanwucs@gmail.com,
	tomapufckgml@gmail.com,
	bird@lzu.edu.cn
Subject: [PATCH net v2 1/2] 8021q: use RCU for egress QoS mappings
Date: Mon, 20 Apr 2026 11:18:45 +0800
Message-ID: <9136768189f8c6d3f824f476c62d2fa1111688e8.1776647968.git.yuantan098@gmail.com>
X-Mailer: git-send-email 2.51.0
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:ygmowACnHwBXnOVpn7DVAA--.49940S2
X-Coremail-Antispam: 1UD129KBjvJXoW3AFy8ZF43Ww4UZF47CryDJrb_yoW3CF1xpF
	WIqFy5Xr4kJFnaqws7JF1Utr4Yv3ykJay2kr9xG3s5Cw15tr9I9F4UuasF9rn0vrWDGr13
	tw43uF48Crs0grDanT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
	9KBjDU0xBIdaVrnRJUUUBY1xkIjI8I6I8E6xAIw20EY4v20xvaj40_Wr0E3s1l1IIY67AE
	w4v_Jr0_Jr4l8cAvFVAK0II2c7xJM28CjxkF64kEwVA0rcxSw2x7M28EF7xvwVC0I7IYx2
	IY67AKxVWDJVCq3wA2z4x0Y4vE2Ix0cI8IcVCY1x0267AKxVW8Jr0_Cr1UM28EF7xvwVC2
	z280aVAFwI0_GcCE3s1l84ACjcxK6I8E87Iv6xkF7I0E14v26rxl6s0DM2AIxVAIcxkEcV
	Aq07x20xvEncxIr21l5I8CrVACY4xI64kE6c02F40Ex7xfMcIj6xIIjxv20xvE14v26r1j
	6r18McIj6I8E87Iv67AKxVWUJVW8JwAm72CE4IkC6x0Yz7v_Jr0_Gr1lF7xvr2IYc2Ij64
	vIr41lF7I21c0EjII2zVCS5cI20VAGYxC7M4IIrI8v6xkF7I0E8cxan2IY04v7MxkF7I0E
	n4kS14v26r1q6r43MxkIecxEwVCm-wCF04k20xvY0x0EwIxGrwCF04k20xvE74AGY7Cv6c
	x26r48MxC20s026xCaFVCjc4AY6r1j6r4UMI8I3I0E5I8CrVAFwI0_Jr0_Jr4lx2IqxVCj
	r7xvwVAFwI0_JrI_JrWlx4CE17CEb7AF67AKxVWUtVW8ZwCIc40Y0x0EwIxGrwCI42IY6x
	IIjxv20xvE14v26r1j6r1xMIIF0xvE2Ix0cI8IcVCY1x0267AKxVW8JVWxJwCI42IY6xAI
	w20EY4v20xvaj40_Jr0_JF4lIxAIcVC2z280aVAFwI0_Jr0_Gr1lIxAIcVC2z280aVCY1x
	0267AKxVW8JVW8JrUvcSsGvfC2KfnxnUUI43ZEXa7VUbGQ6JUUUUU==
X-CM-SenderInfo: zqqvvuo6o23hxhgxhubq/1tbiAQ0CCWnkluAEVgAHsp
X-Spamd-Result: default: False [0.54 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_MISSING_CHARSET(0.50)[];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	TAGGED_FROM(0.00)[bounces-279653-lists,netdev=lfdr.de];
	DMARC_NA(0.00)[lzu.edu.cn];
	RCVD_COUNT_THREE(0.00)[4];
	FORGED_SENDER_MAILLIST(0.00)[];
	FROM_HAS_DN(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FREEMAIL_CC(0.00)[lunn.ch,davemloft.net,kernel.org,redhat.com,gmail.com,ucr.edu,lzu.edu.cn];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	FROM_NEQ_ENVFROM(0.00)[n05ec@lzu.edu.cn,netdev@vger.kernel.org];
	NEURAL_HAM(-0.00)[-0.762];
	TO_DN_NONE(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	R_DKIM_NA(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[14];
	TAGGED_RCPT(0.00)[netdev];
	DBL_BLOCKED_OPENRESOLVER(0.00)[lzu.edu.cn:email,sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,m.to:url]
X-Rspamd-Queue-Id: 581194268BA
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

From: Longxuan Yu <ylong030@ucr.edu>

The TX fast path and reporting paths walk egress QoS mappings without
RTNL. Convert the mapping lists to RCU-protected pointers, use RCU
reader annotations in readers, and defer freeing mapping nodes with an
embedded rcu_head.

This prepares the egress QoS mapping code for safe removal of mapping
nodes in a follow-up change while preserving the current behavior.

Co-developed-by: Yuan Tan <yuantan098@gmail.com>
Signed-off-by: Yuan Tan <yuantan098@gmail.com>
Signed-off-by: Longxuan Yu <ylong030@ucr.edu>
Signed-off-by: Ren Wei <n05ec@lzu.edu.cn>
---

changes in v2:
- split the original single patch into RCU preparation and bug-fix patches
- embed an rcu_head in mapping nodes and use kfree_rcu(pm, rcu)
- keep the existing tombstone-skipping check in vlan_fill_info() so this
patch preserves behavior
- use rcu_dereference_rtnl() for netlink dump traversal
- In patch 1, sample pm->vlan_qos once with READ_ONCE() in vlan_fill_info()
  and reuse the local value, so the RCU preparatory change does not mix a
  plain load for the tombstone check with a separate READ_ONCE() for the
  exported value
- v1 Link:
https://lore.kernel.org/all/b877895cd02d35254b5c05d3c40abbf130cd87eb.1776039122.git.ylong030@ucr.edu/

Besides, we still think Fixes should point to 1da177e4c3f4, not
b020cb488586, because the underlying bug already exists in 1da177e4c3f4:
clearing an egress QoS mapping leaves the mapping node in the hash instead
of deleting it. Commit b020cb488586 only added nr_egress_mappings
accounting for that pre-existing behavior; it did not introduce the bug
itself.

 include/linux/if_vlan.h  | 25 ++++++++++++++++---------
 net/8021q/vlan_dev.c     | 31 ++++++++++++++++---------------
 net/8021q/vlan_netlink.c | 10 ++++++----
 net/8021q/vlanproc.c     | 12 ++++++++----
 4 files changed, 46 insertions(+), 32 deletions(-)

diff --git a/include/linux/if_vlan.h b/include/linux/if_vlan.h
index e6272f9c5e42..20cc16ea4e5a 100644
--- a/include/linux/if_vlan.h
+++ b/include/linux/if_vlan.h
@@ -147,11 +147,13 @@ extern __be16 vlan_dev_vlan_proto(const struct net_device *dev);
  *	@priority: skb priority
  *	@vlan_qos: vlan priority: (skb->priority << 13) & 0xE000
  *	@next: pointer to next struct
+ *	@rcu: used for deferred freeing of mapping nodes
  */
 struct vlan_priority_tci_mapping {
 	u32					priority;
 	u16					vlan_qos;
-	struct vlan_priority_tci_mapping	*next;
+	struct vlan_priority_tci_mapping __rcu	*next;
+	struct rcu_head			rcu;
 };
 
 struct proc_dir_entry;
@@ -177,7 +179,7 @@ struct vlan_dev_priv {
 	unsigned int				nr_ingress_mappings;
 	u32					ingress_priority_map[8];
 	unsigned int				nr_egress_mappings;
-	struct vlan_priority_tci_mapping	*egress_priority_map[16];
+	struct vlan_priority_tci_mapping __rcu	*egress_priority_map[16];
 
 	__be16					vlan_proto;
 	u16					vlan_id;
@@ -209,19 +211,24 @@ static inline u16
 vlan_dev_get_egress_qos_mask(struct net_device *dev, u32 skprio)
 {
 	struct vlan_priority_tci_mapping *mp;
+	u16 vlan_qos = 0;
 
-	smp_rmb(); /* coupled with smp_wmb() in vlan_dev_set_egress_priority() */
+	rcu_read_lock();
 
-	mp = vlan_dev_priv(dev)->egress_priority_map[(skprio & 0xF)];
+	mp = rcu_dereference(vlan_dev_priv(dev)->egress_priority_map[skprio & 0xF]);
 	while (mp) {
 		if (mp->priority == skprio) {
-			return mp->vlan_qos; /* This should already be shifted
-					      * to mask correctly with the
-					      * VLAN's TCI */
+			vlan_qos = READ_ONCE(mp->vlan_qos);
+			break;
 		}
-		mp = mp->next;
+		mp = rcu_dereference(mp->next);
 	}
-	return 0;
+	rcu_read_unlock();
+
+	/* This should already be shifted to mask correctly with
+	 * the VLAN's TCI.
+	 */
+	return vlan_qos;
 }
 
 extern bool vlan_do_receive(struct sk_buff **skb);
diff --git a/net/8021q/vlan_dev.c b/net/8021q/vlan_dev.c
index c40f7d5c4fca..a5340932b657 100644
--- a/net/8021q/vlan_dev.c
+++ b/net/8021q/vlan_dev.c
@@ -172,39 +172,34 @@ int vlan_dev_set_egress_priority(const struct net_device *dev,
 				 u32 skb_prio, u16 vlan_prio)
 {
 	struct vlan_dev_priv *vlan = vlan_dev_priv(dev);
-	struct vlan_priority_tci_mapping *mp = NULL;
+	struct vlan_priority_tci_mapping *mp;
 	struct vlan_priority_tci_mapping *np;
+	u32 bucket = skb_prio & 0xF;
 	u32 vlan_qos = (vlan_prio << VLAN_PRIO_SHIFT) & VLAN_PRIO_MASK;
 
 	/* See if a priority mapping exists.. */
-	mp = vlan->egress_priority_map[skb_prio & 0xF];
+	mp = rtnl_dereference(vlan->egress_priority_map[bucket]);
 	while (mp) {
 		if (mp->priority == skb_prio) {
 			if (mp->vlan_qos && !vlan_qos)
 				vlan->nr_egress_mappings--;
 			else if (!mp->vlan_qos && vlan_qos)
 				vlan->nr_egress_mappings++;
-			mp->vlan_qos = vlan_qos;
+			WRITE_ONCE(mp->vlan_qos, vlan_qos);
 			return 0;
 		}
-		mp = mp->next;
+		mp = rtnl_dereference(mp->next);
 	}
 
 	/* Create a new mapping then. */
-	mp = vlan->egress_priority_map[skb_prio & 0xF];
 	np = kmalloc_obj(struct vlan_priority_tci_mapping);
 	if (!np)
 		return -ENOBUFS;
 
-	np->next = mp;
 	np->priority = skb_prio;
 	np->vlan_qos = vlan_qos;
-	/* Before inserting this element in hash table, make sure all its fields
-	 * are committed to memory.
-	 * coupled with smp_rmb() in vlan_dev_get_egress_qos_mask()
-	 */
-	smp_wmb();
-	vlan->egress_priority_map[skb_prio & 0xF] = np;
+	RCU_INIT_POINTER(np->next, rtnl_dereference(vlan->egress_priority_map[bucket]));
+	rcu_assign_pointer(vlan->egress_priority_map[bucket], np);
 	if (vlan_qos)
 		vlan->nr_egress_mappings++;
 	return 0;
@@ -604,11 +599,17 @@ void vlan_dev_free_egress_priority(const struct net_device *dev)
 	int i;
 
 	for (i = 0; i < ARRAY_SIZE(vlan->egress_priority_map); i++) {
-		while ((pm = vlan->egress_priority_map[i]) != NULL) {
-			vlan->egress_priority_map[i] = pm->next;
-			kfree(pm);
+		pm = rtnl_dereference(vlan->egress_priority_map[i]);
+		RCU_INIT_POINTER(vlan->egress_priority_map[i], NULL);
+		while (pm) {
+			struct vlan_priority_tci_mapping *next;
+
+			next = rtnl_dereference(pm->next);
+			kfree_rcu(pm, rcu);
+			pm = next;
 		}
 	}
+	vlan->nr_egress_mappings = 0;
 }
 
 static void vlan_dev_uninit(struct net_device *dev)
diff --git a/net/8021q/vlan_netlink.c b/net/8021q/vlan_netlink.c
index a000b1ef0520..a5b16833e2ce 100644
--- a/net/8021q/vlan_netlink.c
+++ b/net/8021q/vlan_netlink.c
@@ -260,13 +260,15 @@ static int vlan_fill_info(struct sk_buff *skb, const struct net_device *dev)
 			goto nla_put_failure;
 
 		for (i = 0; i < ARRAY_SIZE(vlan->egress_priority_map); i++) {
-			for (pm = vlan->egress_priority_map[i]; pm;
-			     pm = pm->next) {
-				if (!pm->vlan_qos)
+			for (pm = rcu_dereference_rtnl(vlan->egress_priority_map[i]); pm;
+			     pm = rcu_dereference_rtnl(pm->next)) {
+				u16 vlan_qos = READ_ONCE(pm->vlan_qos);
+
+				if (!vlan_qos)
 					continue;
 
 				m.from = pm->priority;
-				m.to   = (pm->vlan_qos >> 13) & 0x7;
+				m.to   = (vlan_qos >> 13) & 0x7;
 				if (nla_put(skb, IFLA_VLAN_QOS_MAPPING,
 					    sizeof(m), &m))
 					goto nla_put_failure;
diff --git a/net/8021q/vlanproc.c b/net/8021q/vlanproc.c
index fa67374bda49..0e424e0895b7 100644
--- a/net/8021q/vlanproc.c
+++ b/net/8021q/vlanproc.c
@@ -262,15 +262,19 @@ static int vlandev_seq_show(struct seq_file *seq, void *offset)
 		   vlan->ingress_priority_map[7]);
 
 	seq_printf(seq, " EGRESS priority mappings: ");
+	rcu_read_lock();
 	for (i = 0; i < 16; i++) {
-		const struct vlan_priority_tci_mapping *mp
-			= vlan->egress_priority_map[i];
+		const struct vlan_priority_tci_mapping *mp =
+			rcu_dereference(vlan->egress_priority_map[i]);
 		while (mp) {
+			u16 vlan_qos = READ_ONCE(mp->vlan_qos);
+
 			seq_printf(seq, "%u:%d ",
-				   mp->priority, ((mp->vlan_qos >> 13) & 0x7));
-			mp = mp->next;
+				   mp->priority, ((vlan_qos >> 13) & 0x7));
+			mp = rcu_dereference(mp->next);
 		}
 	}
+	rcu_read_unlock();
 	seq_puts(seq, "\n");
 
 	return 0;
-- 
2.43.0


