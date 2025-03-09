Return-Path: <netdev+bounces-173302-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 6AD9BA58500
	for <lists+netdev@lfdr.de>; Sun,  9 Mar 2025 15:48:06 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 7E2A3188E6BE
	for <lists+netdev@lfdr.de>; Sun,  9 Mar 2025 14:48:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BCDDC1EB5C7;
	Sun,  9 Mar 2025 14:47:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="Lmy3Bj2W";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="9Aq1Fz/Y"
X-Original-To: netdev@vger.kernel.org
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 120781DF246
	for <netdev@vger.kernel.org>; Sun,  9 Mar 2025 14:47:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741531635; cv=none; b=dsrr9GXiI3H5RY2C+agHUM90sp2nYvhwBfFoDZG9bjRtzjDqwiIbeSaj5sld2X6AfYSIxX7xZbq5db6V2oNxfG8kDXxTTTrVDDfo8pjOdooiC+/BdAkTRTwNEwSobAd2HvsXxYWztHVJFk/IEItgKEsSCFBGf0X9bz7QOYpnsl8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741531635; c=relaxed/simple;
	bh=uvG0lv4VwElbaRukXRj884rn4WNeVfzTRwlRtcr3784=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=opdhwktTCv/H1lcBuOKr03E9Lq1QB8v358kC9q039kRXLC6k8aAj3rs2V1gra9+zhHoBVepNK9a0RuQu0nWl5SnTHAA8/mdoUThWcmzh1AVJ/5MJX4L91inzmx13GFoId2qZpdZJvgacCUWp5UDjc73bBp0pL9keUrdrB7kpTLI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=Lmy3Bj2W; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=9Aq1Fz/Y; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
From: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1741531631;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=645F6y/0azhk6zsCluxWbxXwLhmqo+r9PW7qSJdcVcw=;
	b=Lmy3Bj2WhX7EebGWkmW+QUvEY0e7zx2cSKuya660zHrgWt51O0wL4UmXFy4Y/pqlI7ZI+4
	e9AdRynmOa/99gx8S1alUUPGir9tuUVLR5t9M1zENfW5TsRts6zHPK5V//Fz4HHqAiaNYC
	pRHepkboMJRhSU3fXSwiSzpKP6JYt4BGWOej5UVA3Ekqm6QvtsijJ2G67uIHqxNnoeQihU
	e7v7YS85ai701+xGzhOxc0xUw1P34tohUzIa0YuUYvGWtuBKDD/+ebBepqeJKAnQNjpqnw
	hsVRrCPeYi0sZILMcqFO3wV0qlb/T+2R5PrWzM89hyKIONLgPnNjjY5SGgZPgg==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1741531631;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=645F6y/0azhk6zsCluxWbxXwLhmqo+r9PW7qSJdcVcw=;
	b=9Aq1Fz/Ypcdrc+A7/jq/g0PvUZa8RG/d8wh0/8J5hUJr1BqPh3CjUCRY+QmsFrkKUa76VE
	NPNxYCg+rEyh/3Ag==
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
Subject: [PATCH net-next 13/18] net/sched: act_mirred: Move the recursion counter struct netdev_xmit.
Date: Sun,  9 Mar 2025 15:46:48 +0100
Message-ID: <20250309144653.825351-14-bigeasy@linutronix.de>
In-Reply-To: <20250309144653.825351-1-bigeasy@linutronix.de>
References: <20250309144653.825351-1-bigeasy@linutronix.de>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

mirred_nest_level is a per-CPU variable and relies on disabled BH for its
locking. Without per-CPU locking in local_bh_disable() on PREEMPT_RT
this data structure requires explicit locking.

Move mirred_nest_level to struct netdev_xmit as u8, provide wrappers.

Cc: Jamal Hadi Salim <jhs@mojatatu.com>
Cc: Cong Wang <xiyou.wangcong@gmail.com>
Cc: Jiri Pirko <jiri@resnulli.us>
Signed-off-by: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
---
 include/linux/netdevice_xmit.h |  3 +++
 net/sched/act_mirred.c         | 28 +++++++++++++++++++++++++---
 2 files changed, 28 insertions(+), 3 deletions(-)

diff --git a/include/linux/netdevice_xmit.h b/include/linux/netdevice_xmit.h
index 3bbbc1a9860a3..4793ec42b1faa 100644
--- a/include/linux/netdevice_xmit.h
+++ b/include/linux/netdevice_xmit.h
@@ -11,6 +11,9 @@ struct netdev_xmit {
 #if IS_ENABLED(CONFIG_NF_DUP_NETDEV)
 	u8 nf_dup_skb_recursion;
 #endif
+#if IS_ENABLED(CONFIG_NET_ACT_MIRRED)
+	u8 sched_mirred_nest;
+#endif
 };
=20
 #endif
diff --git a/net/sched/act_mirred.c b/net/sched/act_mirred.c
index 5b38143659249..8d8cfac6cc6af 100644
--- a/net/sched/act_mirred.c
+++ b/net/sched/act_mirred.c
@@ -30,7 +30,29 @@ static LIST_HEAD(mirred_list);
 static DEFINE_SPINLOCK(mirred_list_lock);
=20
 #define MIRRED_NEST_LIMIT    4
-static DEFINE_PER_CPU(unsigned int, mirred_nest_level);
+
+#ifndef CONFIG_PREEMPT_RT
+static u8 tcf_mirred_nest_level_inc_return(void)
+{
+	return __this_cpu_inc_return(softnet_data.xmit.sched_mirred_nest);
+}
+
+static void tcf_mirred_nest_level_dec(void)
+{
+	__this_cpu_dec(softnet_data.xmit.sched_mirred_nest);
+}
+
+#else
+static u8 tcf_mirred_nest_level_inc_return(void)
+{
+	return current->net_xmit.nf_dup_skb_recursion++;
+}
+
+static void tcf_mirred_nest_level_dec(void)
+{
+	current->net_xmit.nf_dup_skb_recursion--;
+}
+#endif
=20
 static bool tcf_mirred_is_act_redirect(int action)
 {
@@ -423,7 +445,7 @@ TC_INDIRECT_SCOPE int tcf_mirred_act(struct sk_buff *sk=
b,
 	int m_eaction;
 	u32 blockid;
=20
-	nest_level =3D __this_cpu_inc_return(mirred_nest_level);
+	nest_level =3D tcf_mirred_nest_level_inc_return();
 	if (unlikely(nest_level > MIRRED_NEST_LIMIT)) {
 		net_warn_ratelimited("Packet exceeded mirred recursion limit on dev %s\n=
",
 				     netdev_name(skb->dev));
@@ -454,7 +476,7 @@ TC_INDIRECT_SCOPE int tcf_mirred_act(struct sk_buff *sk=
b,
 				   retval);
=20
 dec_nest_level:
-	__this_cpu_dec(mirred_nest_level);
+	tcf_mirred_nest_level_dec();
=20
 	return retval;
 }
--=20
2.47.2


