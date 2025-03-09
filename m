Return-Path: <netdev+bounces-173304-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 954F7A58501
	for <lists+netdev@lfdr.de>; Sun,  9 Mar 2025 15:48:06 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id BA58416B368
	for <lists+netdev@lfdr.de>; Sun,  9 Mar 2025 14:48:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BCF101EB5D2;
	Sun,  9 Mar 2025 14:47:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="BkBLmRwB";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="JJKTzu7h"
X-Original-To: netdev@vger.kernel.org
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4C0F31DF24A
	for <netdev@vger.kernel.org>; Sun,  9 Mar 2025 14:47:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741531635; cv=none; b=nxcHwaLsOpdy0x/A2/G4Gyz33ZY0qrDcik8sKX/aLW7iKNxnE4gSPqiLrZdlr5ZKOr1ShPo46N1GZD8Ag7LDjFd32DseHZEDeHDA0kajai2CEmr8CIWsSpIVLo52wrpPq4YVmCqSaqWZgF5Vr0XcWavusvD7EFrmGlRUjSwk65E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741531635; c=relaxed/simple;
	bh=jWriMsUvYWiqG0HpHgS2t9OUBIHcDtiwjShvzLVuano=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=gbwwUj8jcfZoDKCawiSC+Rkl9YxaYAQOWiDd9VrNVQNt/XFo2lsHvJSs9dLTS1c60YmMaXSMiMQdqkHgyWKYS4a2JCnFU2uUQni7xLyYlSPqh3i4xqE8hWiqKqxfxBMf+FRyhqP02/97IXs0eUh3rGrEVQELsiBOEWIlu0XnfZM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=BkBLmRwB; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=JJKTzu7h; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
From: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1741531631;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=3oGUJfvWmoE3lobOlWLxxnXkeRka7EQOI3g+/48MIgI=;
	b=BkBLmRwBu/l9e7tKftx92hMzDbQ8Sp07rDwtpRnu8S0PFDr3uF+9o1swQmC/Dqm4d5KZcc
	SDEfMgsXY0LVXa0jCl5+UHPkIZN4kXVg4vabEnEnxoKhnlpdsQXnIDEEsocSaW9RUmfa1l
	1/01oR0osekOYYgNj/M4i7b6XCQdGZCv3vu0OxF1d83j1X3xGDrS2WwZCZU3vFje7Yoi53
	dDkvt5rboOPbn9q0YdB6Uu8PJQ63LY0p/XidsYw31h4j6zrITRtWax0lPxxL6wBs7w/pLl
	TKCXdaP0vSV4MYxGOWMhIS/CWFtiqTCeKqlQoOuDGYDYkIo3yim9qRNuS+wW9w==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1741531631;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=3oGUJfvWmoE3lobOlWLxxnXkeRka7EQOI3g+/48MIgI=;
	b=JJKTzu7hOpPLT4t7d6jJGXHqIpshHHHxiy7zw8Fm4GmrbBt0Ie+DaAI/t+P5P4xW6I+YdT
	/ibCKxTxva9iP0Aw==
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
Subject: [PATCH net-next 14/18] net/sched: Use nested-BH locking for sch_frag_data_storage.
Date: Sun,  9 Mar 2025 15:46:49 +0100
Message-ID: <20250309144653.825351-15-bigeasy@linutronix.de>
In-Reply-To: <20250309144653.825351-1-bigeasy@linutronix.de>
References: <20250309144653.825351-1-bigeasy@linutronix.de>
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
2.47.2


