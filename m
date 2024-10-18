Return-Path: <netdev+bounces-137027-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 119149A40D4
	for <lists+netdev@lfdr.de>; Fri, 18 Oct 2024 16:13:03 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 940551F231E3
	for <lists+netdev@lfdr.de>; Fri, 18 Oct 2024 14:13:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 33DFD1D5AC7;
	Fri, 18 Oct 2024 14:12:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="IAkcC8o5"
X-Original-To: netdev@vger.kernel.org
Received: from out-176.mta1.migadu.com (out-176.mta1.migadu.com [95.215.58.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AB5E21877;
	Fri, 18 Oct 2024 14:12:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=95.215.58.176
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729260778; cv=none; b=q/bJS2AdlxqdKBlggnlhfMJv8Ze9gpSUzucL/nS2TpnU84IuRgMD6+HVU7QbRhOmxE/AiQ17fSPc9kc1sNZSlPNPspveffnNJs55STTxDBI30I/hw9MWqrrFmEHFwQIbNBErBb1Ownpt30/+EBTdj+Aj0Q6EVmLsOABLzAk1cAs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729260778; c=relaxed/simple;
	bh=AmilhHxrBpWJmfseO07qPvXsrQP43giiH4t8zyyH9Lg=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=o7wisaPzVXJB+jEkUGYU9vtNmbIJ8/nxWwy7KyWn8jbfJ4xRSv8fA9ursKaWLGuGj5pCVSQplUTFBFmgd5G+ozNhoB1GlcoQR1U6ZH4U7P+vuFJMHxKmIKDeZCsa+9WSH65mICaRqwQuNy0R1cyvPA03SQz1jDGR4/bUY2/CQz4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=IAkcC8o5; arc=none smtp.client-ip=95.215.58.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1729260772;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding;
	bh=xoASWoTi+c/T+PN9tatzMLSW/PQgL89x7z70TOYinwU=;
	b=IAkcC8o5vxKivXfyxn5A4vrWebQiTQH6yPLn+1ICoBJMlBb5IQe8zEA3lF9WOoWbUqPv5L
	k7FjM5d/ZN8XskOTrrSziWbNEQnbB4epKGhSeDwPOpYXziMVL4MRgU9Ah1pJd4Wm/HmBAr
	LoM9Cq1foRhca9Qx9AytkIwOlGew6rM=
From: Yajun Deng <yajun.deng@linux.dev>
To: davem@davemloft.net,
	edumazet@google.com,
	kuba@kernel.org,
	pabeni@redhat.com
Cc: netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Yajun Deng <yajun.deng@linux.dev>
Subject: [PATCH v3 net-next] net: vlan: Use vlan_prio instead of vlan_qos in mapping
Date: Fri, 18 Oct 2024 22:12:33 +0800
Message-Id: <20241018141233.2568-1-yajun.deng@linux.dev>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Migadu-Flow: FLOW_OUT

The vlan_qos member is used to save the vlan qos, but we only save the
priority. Also, we will get the priority in vlan netlink and proc.
We can just save the vlan priority using vlan_prio, so we can use vlan_prio
to get the priority directly.

For flexibility, we introduced vlan_dev_get_egress_priority() helper
function. After this patch, we will call vlan_dev_get_egress_priority()
instead of vlan_dev_get_egress_qos_mask() in irdma.ko and rdma_cm.ko.
Because we don't need the shift and mask operations anymore.

There is no functional changes.

Signed-off-by: Yajun Deng <yajun.deng@linux.dev>
---
v3: Remove the restriction that the maximum vlan priority is 7.
v2: Add more detailed comments and tests.
v1: https://lore.kernel.org/all/20241009132302.2902-1-yajun.deng@linux.dev/
---
 include/linux/if_vlan.h  | 26 +++++++++++++++++++-------
 net/8021q/vlan.h         |  4 ++--
 net/8021q/vlan_dev.c     | 23 ++++++++++++-----------
 net/8021q/vlan_netlink.c |  4 ++--
 net/8021q/vlanproc.c     |  4 ++--
 5 files changed, 37 insertions(+), 24 deletions(-)

diff --git a/include/linux/if_vlan.h b/include/linux/if_vlan.h
index c1645c86eed9..7cc36853c017 100644
--- a/include/linux/if_vlan.h
+++ b/include/linux/if_vlan.h
@@ -150,12 +150,12 @@ extern __be16 vlan_dev_vlan_proto(const struct net_device *dev);
 /**
  *	struct vlan_priority_tci_mapping - vlan egress priority mappings
  *	@priority: skb priority
- *	@vlan_qos: vlan priority: (skb->priority << 13) & 0xE000
+ *	@vlan_prio: vlan priority
  *	@next: pointer to next struct
  */
 struct vlan_priority_tci_mapping {
 	u32					priority;
-	u16					vlan_qos;
+	u8					vlan_prio;
 	struct vlan_priority_tci_mapping	*next;
 };
 
@@ -204,8 +204,8 @@ static inline struct vlan_dev_priv *vlan_dev_priv(const struct net_device *dev)
 	return netdev_priv(dev);
 }
 
-static inline u16
-vlan_dev_get_egress_qos_mask(struct net_device *dev, u32 skprio)
+static inline u8
+vlan_dev_get_egress_priority(struct net_device *dev, u32 skprio)
 {
 	struct vlan_priority_tci_mapping *mp;
 
@@ -214,15 +214,21 @@ vlan_dev_get_egress_qos_mask(struct net_device *dev, u32 skprio)
 	mp = vlan_dev_priv(dev)->egress_priority_map[(skprio & 0xF)];
 	while (mp) {
 		if (mp->priority == skprio) {
-			return mp->vlan_qos; /* This should already be shifted
-					      * to mask correctly with the
-					      * VLAN's TCI */
+			return mp->vlan_prio;
 		}
 		mp = mp->next;
 	}
 	return 0;
 }
 
+static inline u16
+vlan_dev_get_egress_qos_mask(struct net_device *dev, u32 skprio)
+{
+	u8 vlan_prio = vlan_dev_get_egress_priority(dev, skprio);
+
+	return (vlan_prio << VLAN_PRIO_SHIFT) & VLAN_PRIO_MASK;
+}
+
 extern bool vlan_do_receive(struct sk_buff **skb);
 
 extern int vlan_vid_add(struct net_device *dev, __be16 proto, u16 vid);
@@ -269,6 +275,12 @@ static inline __be16 vlan_dev_vlan_proto(const struct net_device *dev)
 	return 0;
 }
 
+static inline u8 vlan_dev_get_egress_priority(struct net_device *dev,
+					      u32 skprio)
+{
+	return 0;
+}
+
 static inline u16 vlan_dev_get_egress_qos_mask(struct net_device *dev,
 					       u32 skprio)
 {
diff --git a/net/8021q/vlan.h b/net/8021q/vlan.h
index 5eaf38875554..b28875c4ac86 100644
--- a/net/8021q/vlan.h
+++ b/net/8021q/vlan.h
@@ -126,9 +126,9 @@ void vlan_filter_drop_vids(struct vlan_info *vlan_info, __be16 proto);
 
 /* found in vlan_dev.c */
 void vlan_dev_set_ingress_priority(const struct net_device *dev,
-				   u32 skb_prio, u16 vlan_prio);
+				   u32 skb_prio, u8 vlan_prio);
 int vlan_dev_set_egress_priority(const struct net_device *dev,
-				 u32 skb_prio, u16 vlan_prio);
+				 u32 skb_prio, u8 vlan_prio);
 void vlan_dev_free_egress_priority(const struct net_device *dev);
 int vlan_dev_change_flags(const struct net_device *dev, u32 flag, u32 mask);
 void vlan_dev_get_realdev_name(const struct net_device *dev, char *result,
diff --git a/net/8021q/vlan_dev.c b/net/8021q/vlan_dev.c
index 458040e8a0e0..5d153f1a7963 100644
--- a/net/8021q/vlan_dev.c
+++ b/net/8021q/vlan_dev.c
@@ -155,35 +155,36 @@ static int vlan_dev_change_mtu(struct net_device *dev, int new_mtu)
 }
 
 void vlan_dev_set_ingress_priority(const struct net_device *dev,
-				   u32 skb_prio, u16 vlan_prio)
+				   u32 skb_prio, u8 vlan_prio)
 {
 	struct vlan_dev_priv *vlan = vlan_dev_priv(dev);
 
-	if (vlan->ingress_priority_map[vlan_prio & 0x7] && !skb_prio)
+	vlan_prio = vlan_prio & 0x7;
+	if (vlan->ingress_priority_map[vlan_prio] && !skb_prio)
 		vlan->nr_ingress_mappings--;
-	else if (!vlan->ingress_priority_map[vlan_prio & 0x7] && skb_prio)
+	else if (!vlan->ingress_priority_map[vlan_prio] && skb_prio)
 		vlan->nr_ingress_mappings++;
 
-	vlan->ingress_priority_map[vlan_prio & 0x7] = skb_prio;
+	vlan->ingress_priority_map[vlan_prio] = skb_prio;
 }
 
 int vlan_dev_set_egress_priority(const struct net_device *dev,
-				 u32 skb_prio, u16 vlan_prio)
+				 u32 skb_prio, u8 vlan_prio)
 {
 	struct vlan_dev_priv *vlan = vlan_dev_priv(dev);
 	struct vlan_priority_tci_mapping *mp = NULL;
 	struct vlan_priority_tci_mapping *np;
-	u32 vlan_qos = (vlan_prio << VLAN_PRIO_SHIFT) & VLAN_PRIO_MASK;
 
+	vlan_prio = vlan_prio & 0x7;
 	/* See if a priority mapping exists.. */
 	mp = vlan->egress_priority_map[skb_prio & 0xF];
 	while (mp) {
 		if (mp->priority == skb_prio) {
-			if (mp->vlan_qos && !vlan_qos)
+			if (mp->vlan_prio && !vlan_prio)
 				vlan->nr_egress_mappings--;
-			else if (!mp->vlan_qos && vlan_qos)
+			else if (!mp->vlan_prio && vlan_prio)
 				vlan->nr_egress_mappings++;
-			mp->vlan_qos = vlan_qos;
+			mp->vlan_prio = vlan_prio;
 			return 0;
 		}
 		mp = mp->next;
@@ -197,14 +198,14 @@ int vlan_dev_set_egress_priority(const struct net_device *dev,
 
 	np->next = mp;
 	np->priority = skb_prio;
-	np->vlan_qos = vlan_qos;
+	np->vlan_prio = vlan_prio;
 	/* Before inserting this element in hash table, make sure all its fields
 	 * are committed to memory.
 	 * coupled with smp_rmb() in vlan_dev_get_egress_qos_mask()
 	 */
 	smp_wmb();
 	vlan->egress_priority_map[skb_prio & 0xF] = np;
-	if (vlan_qos)
+	if (vlan_prio)
 		vlan->nr_egress_mappings++;
 	return 0;
 }
diff --git a/net/8021q/vlan_netlink.c b/net/8021q/vlan_netlink.c
index cf5219df7903..f62d8320c5b4 100644
--- a/net/8021q/vlan_netlink.c
+++ b/net/8021q/vlan_netlink.c
@@ -261,11 +261,11 @@ static int vlan_fill_info(struct sk_buff *skb, const struct net_device *dev)
 		for (i = 0; i < ARRAY_SIZE(vlan->egress_priority_map); i++) {
 			for (pm = vlan->egress_priority_map[i]; pm;
 			     pm = pm->next) {
-				if (!pm->vlan_qos)
+				if (!pm->vlan_prio)
 					continue;
 
 				m.from = pm->priority;
-				m.to   = (pm->vlan_qos >> 13) & 0x7;
+				m.to   = pm->vlan_prio;
 				if (nla_put(skb, IFLA_VLAN_QOS_MAPPING,
 					    sizeof(m), &m))
 					goto nla_put_failure;
diff --git a/net/8021q/vlanproc.c b/net/8021q/vlanproc.c
index fa67374bda49..a5a5b8fbb054 100644
--- a/net/8021q/vlanproc.c
+++ b/net/8021q/vlanproc.c
@@ -266,8 +266,8 @@ static int vlandev_seq_show(struct seq_file *seq, void *offset)
 		const struct vlan_priority_tci_mapping *mp
 			= vlan->egress_priority_map[i];
 		while (mp) {
-			seq_printf(seq, "%u:%d ",
-				   mp->priority, ((mp->vlan_qos >> 13) & 0x7));
+			seq_printf(seq, "%u:%u ",
+				   mp->priority, mp->vlan_prio);
 			mp = mp->next;
 		}
 	}
-- 
2.25.1


