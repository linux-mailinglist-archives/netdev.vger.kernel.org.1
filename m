Return-Path: <netdev+bounces-187067-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 87FE6AA4BAB
	for <lists+netdev@lfdr.de>; Wed, 30 Apr 2025 14:50:53 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 75C8E4E49B4
	for <lists+netdev@lfdr.de>; Wed, 30 Apr 2025 12:49:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 18B9425F792;
	Wed, 30 Apr 2025 12:48:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="2sO7YYt2";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="F4IiKRnz"
X-Original-To: netdev@vger.kernel.org
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1263A25D909
	for <netdev@vger.kernel.org>; Wed, 30 Apr 2025 12:48:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746017299; cv=none; b=qTG/BigpLsZLX4bRP2wLbo3p8lBH9spRRqYyNtNVc9Ut6KxGftXkdGvnITsXGfbX5M642Ktt+T2MSq25HP7W1mDyvqxXPGHm5n0db2LDaT18bXYe3XTyJFd083mvXJTh5+AN29HBiCi7zD/BaEyRh4bQ0l8evMHAnUHLQMfqFMQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746017299; c=relaxed/simple;
	bh=mpWnrGSrlTSO+lFgale6qOtBfvpFAUndKnFyjpu3eeA=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=IvlgtQKSbslheJ19a3LhN2PvU+P+37a5mdPk3sDRJ+K/+DMQMSuGp6AvZyNtljK60WmcFABIFsOrl5JYO5vRA3Z5c+5p8t9CZcoZdB80XUuIwPv4HS1bMKhxtK0jHR2BCzBj24ImvjWC6TsE7wVMYebU3x5EpQN6wiXvq4Rnkys=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=2sO7YYt2; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=F4IiKRnz; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
From: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1746017294;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=B91Vs7Kr8/n30DMdAVzJeH1Fm4E83+3x5T7eHPmZihs=;
	b=2sO7YYt2pzTUvqc4FuLZXNvqOvcTr/qM9jAf9vBTfT6bhecqpOIK8R253VWuv84FI8bGjm
	apyG/0tA6/LPiFNKHdSrBbJSE67PygQAR53HDhOvugBtbxsvoaOyQNgXpyZNevLRvQRgwe
	D3UXBtft5q02jL3OHh/4Y5pXt5QdA/m8u9+JlCD1zDKoDcg0mKgyQEypapdWG+qgjHVZfk
	vDRc3ELD5bhdBdScWzMsuHSq5EXSR81RMLTIB34JtDeb93muPCGSjXpOSRE2RGPv/zQmyX
	52AkbqgftnF0TOit+QlbJPChat1PyODYVlmBI2iHrx8NcLfCgHySaKpCY+ZInA==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1746017294;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=B91Vs7Kr8/n30DMdAVzJeH1Fm4E83+3x5T7eHPmZihs=;
	b=F4IiKRnz6F9ryAiK/e+P9wdDQorjOE6kAx99gHDcN4FEqv1B4B7WLOgVOXbvi08L+xt+Oi
	E0KuMp5EwpTyOiDA==
To: netdev@vger.kernel.org,
	linux-rt-devel@lists.linux.dev
Cc: "David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	Simon Horman <horms@kernel.org>,
	Thomas Gleixner <tglx@linutronix.de>,
	Sebastian Andrzej Siewior <bigeasy@linutronix.de>,
	Aaron Conole <aconole@redhat.com>,
	Eelco Chaudron <echaudro@redhat.com>,
	Ilya Maximets <i.maximets@ovn.org>,
	dev@openvswitch.org
Subject: [PATCH net-next v3 12/18] openvswitch: Move ovs_frag_data_storage into the struct ovs_pcpu_storage
Date: Wed, 30 Apr 2025 14:47:52 +0200
Message-ID: <20250430124758.1159480-13-bigeasy@linutronix.de>
In-Reply-To: <20250430124758.1159480-1-bigeasy@linutronix.de>
References: <20250430124758.1159480-1-bigeasy@linutronix.de>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

ovs_frag_data_storage is a per-CPU variable and relies on disabled BH for i=
ts
locking. Without per-CPU locking in local_bh_disable() on PREEMPT_RT
this data structure requires explicit locking.

Move ovs_frag_data_storage into the struct ovs_pcpu_storage which already
provides locking for the structure.

Cc: Aaron Conole <aconole@redhat.com>
Cc: Eelco Chaudron <echaudro@redhat.com>
Cc: Ilya Maximets <i.maximets@ovn.org>
Cc: dev@openvswitch.org
Signed-off-by: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
---
 net/openvswitch/actions.c  | 20 ++------------------
 net/openvswitch/datapath.h | 16 ++++++++++++++++
 2 files changed, 18 insertions(+), 18 deletions(-)

diff --git a/net/openvswitch/actions.c b/net/openvswitch/actions.c
index f4996c11aefac..4d20eadd77ceb 100644
--- a/net/openvswitch/actions.c
+++ b/net/openvswitch/actions.c
@@ -39,22 +39,6 @@
 #include "flow_netlink.h"
 #include "openvswitch_trace.h"
=20
-#define MAX_L2_LEN	(VLAN_ETH_HLEN + 3 * MPLS_HLEN)
-struct ovs_frag_data {
-	unsigned long dst;
-	struct vport *vport;
-	struct ovs_skb_cb cb;
-	__be16 inner_protocol;
-	u16 network_offset;	/* valid only for MPLS */
-	u16 vlan_tci;
-	__be16 vlan_proto;
-	unsigned int l2_len;
-	u8 mac_proto;
-	u8 l2_data[MAX_L2_LEN];
-};
-
-static DEFINE_PER_CPU(struct ovs_frag_data, ovs_frag_data_storage);
-
 DEFINE_PER_CPU(struct ovs_pcpu_storage, ovs_pcpu_storage) =3D {
 	.bh_lock =3D INIT_LOCAL_LOCK(bh_lock),
 };
@@ -771,7 +755,7 @@ static int set_sctp(struct sk_buff *skb, struct sw_flow=
_key *flow_key,
 static int ovs_vport_output(struct net *net, struct sock *sk,
 			    struct sk_buff *skb)
 {
-	struct ovs_frag_data *data =3D this_cpu_ptr(&ovs_frag_data_storage);
+	struct ovs_frag_data *data =3D this_cpu_ptr(&ovs_pcpu_storage.frag_data);
 	struct vport *vport =3D data->vport;
=20
 	if (skb_cow_head(skb, data->l2_len) < 0) {
@@ -823,7 +807,7 @@ static void prepare_frag(struct vport *vport, struct sk=
_buff *skb,
 	unsigned int hlen =3D skb_network_offset(skb);
 	struct ovs_frag_data *data;
=20
-	data =3D this_cpu_ptr(&ovs_frag_data_storage);
+	data =3D this_cpu_ptr(&ovs_pcpu_storage.frag_data);
 	data->dst =3D skb->_skb_refdst;
 	data->vport =3D vport;
 	data->cb =3D *OVS_CB(skb);
diff --git a/net/openvswitch/datapath.h b/net/openvswitch/datapath.h
index 4a665c3cfa906..1b5348b0f5594 100644
--- a/net/openvswitch/datapath.h
+++ b/net/openvswitch/datapath.h
@@ -13,6 +13,7 @@
 #include <linux/skbuff.h>
 #include <linux/u64_stats_sync.h>
 #include <net/ip_tunnels.h>
+#include <net/mpls.h>
=20
 #include "conntrack.h"
 #include "flow.h"
@@ -173,6 +174,20 @@ struct ovs_net {
 	bool xt_label;
 };
=20
+#define MAX_L2_LEN	(VLAN_ETH_HLEN + 3 * MPLS_HLEN)
+struct ovs_frag_data {
+	unsigned long dst;
+	struct vport *vport;
+	struct ovs_skb_cb cb;
+	__be16 inner_protocol;
+	u16 network_offset;	/* valid only for MPLS */
+	u16 vlan_tci;
+	__be16 vlan_proto;
+	unsigned int l2_len;
+	u8 mac_proto;
+	u8 l2_data[MAX_L2_LEN];
+};
+
 struct deferred_action {
 	struct sk_buff *skb;
 	const struct nlattr *actions;
@@ -200,6 +215,7 @@ struct action_flow_keys {
 struct ovs_pcpu_storage {
 	struct action_fifo action_fifos;
 	struct action_flow_keys flow_keys;
+	struct ovs_frag_data frag_data;
 	int exec_level;
 	struct task_struct *owner;
 	local_lock_t bh_lock;
--=20
2.49.0


