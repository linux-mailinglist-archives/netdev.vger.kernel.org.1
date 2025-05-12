Return-Path: <netdev+bounces-189698-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 4F8EAAB33AA
	for <lists+netdev@lfdr.de>; Mon, 12 May 2025 11:34:21 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id E5A783A0F8B
	for <lists+netdev@lfdr.de>; Mon, 12 May 2025 09:31:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 98588267F68;
	Mon, 12 May 2025 09:27:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="Vei/ULgv";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="Kcpq+/LK"
X-Original-To: netdev@vger.kernel.org
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 008CA267AF9
	for <netdev@vger.kernel.org>; Mon, 12 May 2025 09:27:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747042071; cv=none; b=CIHlpRE3KzdYt9RnZmcKur7twi9ntdOYfJR8I8ViryHDLHBe8dIv1uAhOZ5YQhuU6Q54+JXLwugwKLueWhWAXTa80eOXY4qGmcVoD0d+2PnF/6dMuhb9JWRcU2FsNvQ+1WxZ2fbdCrxClaOOViNNzU74du71l7UiiPAv6+i2Vpc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747042071; c=relaxed/simple;
	bh=psMK5D/Ej6r9TOHK0/N777uNZ7fI4FJf9tekZNqyEP4=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=UwaFEUiF6bsC9Dy+re3vtkZRi7K5cJsR9amHVfqwkverLCgOKs/gkHprn9V/JGSsFG7GNP9blze00tRThKayPl69XGvaPcJuMGhOdVoPlajNqMq0XBtGa+sMP9hZSLF2yRHNWl7pjgtSWAPhsaXkDW0oG0+f39rKDJWVGczKx9c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=Vei/ULgv; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=Kcpq+/LK; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
From: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1747042066;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=g9V0amf8yCnsZjanHGDleuk2ou6MuA9/QgqDODlZotE=;
	b=Vei/ULgvbEEqFMmwxlZA2ABJWRGhHFjVplduG9rMB5L6TOMh31AqdSJWJIqMZSVgIAiNzm
	ndRua6m/eTU6vFLn1X9g3PO2kBbqQN/1gxtpQwQcn5TJvffV0AltQ0Kf049YNM+JfjVKdm
	FX+1vkNu2FoGi6mCqNspRgQaHcPXwwHW3QDGL7cOfPJLIEarVQdomcmcawycrPAGvzYSkQ
	A7/p7zDouW4MZ4BRNeTgkGrAWsJmia2ycVeVPaMis7K199bTv5hzk/lFr0pVouBka1ofyr
	OQ4VC/GrM3dJ1tr43gkPiKzarE3ijoyxo4KWP4BGyNaiQlqIfbE1X+jFBmcvbw==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1747042066;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=g9V0amf8yCnsZjanHGDleuk2ou6MuA9/QgqDODlZotE=;
	b=Kcpq+/LKIOct1yIABLM+H0uN6yKyyJYeNNjngbGI2hZo5MhkqmOJyWh6JWY04FU6FmVkDT
	uIqfkJwG0fdfCVCA==
To: netdev@vger.kernel.org,
	linux-rt-devel@lists.linux.dev
Cc: "David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	Simon Horman <horms@kernel.org>,
	Thomas Gleixner <tglx@linutronix.de>,
	Sebastian Andrzej Siewior <bigeasy@linutronix.de>,
	Jamal Hadi Salim <jhs@mojatatu.com>,
	Cong Wang <xiyou.wangcong@gmail.com>,
	Jiri Pirko <jiri@resnulli.us>
Subject: [PATCH net-next v4 11/15] net/sched: Use nested-BH locking for sch_frag_data_storage
Date: Mon, 12 May 2025 11:27:32 +0200
Message-ID: <20250512092736.229935-12-bigeasy@linutronix.de>
In-Reply-To: <20250512092736.229935-1-bigeasy@linutronix.de>
References: <20250512092736.229935-1-bigeasy@linutronix.de>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

sch_frag_data_storage is a per-CPU variable and relies on disabled BH
for its locking. Without per-CPU locking in local_bh_disable() on
PREEMPT_RT this data structure requires explicit locking.

Add local_lock_t to the struct and use local_lock_nested_bh() for locking.
This change adds only lockdep coverage and does not alter the functional
behaviour for !PREEMPT_RT.

Cc: Jamal Hadi Salim <jhs@mojatatu.com>
Cc: Cong Wang <xiyou.wangcong@gmail.com>
Cc: Jiri Pirko <jiri@resnulli.us>
Signed-off-by: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
---
 net/sched/sch_frag.c | 10 +++++++++-
 1 file changed, 9 insertions(+), 1 deletion(-)

diff --git a/net/sched/sch_frag.c b/net/sched/sch_frag.c
index ce63414185fd6..d1d87dce7f3f7 100644
--- a/net/sched/sch_frag.c
+++ b/net/sched/sch_frag.c
@@ -16,14 +16,18 @@ struct sch_frag_data {
 	unsigned int l2_len;
 	u8 l2_data[VLAN_ETH_HLEN];
 	int (*xmit)(struct sk_buff *skb);
+	local_lock_t bh_lock;
 };
=20
-static DEFINE_PER_CPU(struct sch_frag_data, sch_frag_data_storage);
+static DEFINE_PER_CPU(struct sch_frag_data, sch_frag_data_storage) =3D {
+	.bh_lock =3D INIT_LOCAL_LOCK(bh_lock),
+};
=20
 static int sch_frag_xmit(struct net *net, struct sock *sk, struct sk_buff =
*skb)
 {
 	struct sch_frag_data *data =3D this_cpu_ptr(&sch_frag_data_storage);
=20
+	lockdep_assert_held(&data->bh_lock);
 	if (skb_cow_head(skb, data->l2_len) < 0) {
 		kfree_skb(skb);
 		return -ENOMEM;
@@ -95,6 +99,7 @@ static int sch_fragment(struct net *net, struct sk_buff *=
skb,
 		struct rtable sch_frag_rt =3D { 0 };
 		unsigned long orig_dst;
=20
+		local_lock_nested_bh(&sch_frag_data_storage.bh_lock);
 		sch_frag_prepare_frag(skb, xmit);
 		dst_init(&sch_frag_rt.dst, &sch_frag_dst_ops, NULL,
 			 DST_OBSOLETE_NONE, DST_NOCOUNT);
@@ -105,11 +110,13 @@ static int sch_fragment(struct net *net, struct sk_bu=
ff *skb,
 		IPCB(skb)->frag_max_size =3D mru;
=20
 		ret =3D ip_do_fragment(net, skb->sk, skb, sch_frag_xmit);
+		local_unlock_nested_bh(&sch_frag_data_storage.bh_lock);
 		refdst_drop(orig_dst);
 	} else if (skb_protocol(skb, true) =3D=3D htons(ETH_P_IPV6)) {
 		unsigned long orig_dst;
 		struct rt6_info sch_frag_rt;
=20
+		local_lock_nested_bh(&sch_frag_data_storage.bh_lock);
 		sch_frag_prepare_frag(skb, xmit);
 		memset(&sch_frag_rt, 0, sizeof(sch_frag_rt));
 		dst_init(&sch_frag_rt.dst, &sch_frag_dst_ops, NULL,
@@ -122,6 +129,7 @@ static int sch_fragment(struct net *net, struct sk_buff=
 *skb,
=20
 		ret =3D ipv6_stub->ipv6_fragment(net, skb->sk, skb,
 					       sch_frag_xmit);
+		local_unlock_nested_bh(&sch_frag_data_storage.bh_lock);
 		refdst_drop(orig_dst);
 	} else {
 		net_warn_ratelimited("Fail frag %s: eth=3D%x, MRU=3D%d, MTU=3D%d\n",
--=20
2.49.0


