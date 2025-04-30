Return-Path: <netdev+bounces-187065-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 69E66AA4BAA
	for <lists+netdev@lfdr.de>; Wed, 30 Apr 2025 14:50:49 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 5B6F04E463D
	for <lists+netdev@lfdr.de>; Wed, 30 Apr 2025 12:49:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E701A25EFBB;
	Wed, 30 Apr 2025 12:48:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="FvVEqPRy";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="Wc65Hd0r"
X-Original-To: netdev@vger.kernel.org
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 96D5F25D8FC
	for <netdev@vger.kernel.org>; Wed, 30 Apr 2025 12:48:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746017298; cv=none; b=HtnsICIpZb/Stxf371+X1sgU664mzqTN5c6LW0jZUkIoDwyiaidco5zW8o5e9U0S0F884q1965C03YaqGSi9xBRX5mNIdGf+qJnXklQ6q8rnKX9e196ATE5BVlbRsoBlwI+kc3cNo3DFJJn7uPS0Gn+pjfd9Sgb9NNcl3i0ByHA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746017298; c=relaxed/simple;
	bh=zrHr0oIdmFVvuqReRS6A1Vk8JfCJLTqEyMuMgmRm85A=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=JufMN2eBSup+gywNsHaR1hFdyg3UT1X2ITRjqJu2h1zVDIM6aNIKRPfDfhfZjp/5dhxa5HqFDdAp9PaFfr0y4TwSfBiR7BXwbcO3GYACr1runbY6gQwlrPMPKi+IKNNr89dKWY5I4GdquWDaZTkoCJ8gnQBumlDiO43IvFeCVCw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=FvVEqPRy; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=Wc65Hd0r; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
From: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1746017295;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=ItheQOXN0W8/U3eIeVElS1GMGBEBaL1p1NvXJGWnpLY=;
	b=FvVEqPRygrxDDfoDvBaQM7fyavV3sOHCRiIVWJVIE2y422bKJq6Pswk49lN4yTcISejazj
	3yxGokX2MeTI2W+gud7A24zxMerRvGK2hpCSWxfBLEsjdEMIIZSdvb1FoL6rGhtVwzGS06
	zU255MMi1r1A9r0WPVPJW7Rxa4UN+xjdNCFTfzUcFM1Lu2OHHRV7OvOG6G0XV7jH9FThFo
	kwwzFFnTjtZut925q868v8a1o07/hD0obChrFNixdDhLMXnCOoC5jYfLweeU4LiOQX39bB
	JzedMux79QGPV6XhGljcjVEinqXrel8ZKNEX23bzYINizY+9a6Jp5cHzX1fPfg==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1746017295;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=ItheQOXN0W8/U3eIeVElS1GMGBEBaL1p1NvXJGWnpLY=;
	b=Wc65Hd0rrhZzI3GvZEmn9Tym6FUyXIYynEMleADo20VMbjX/uIVgVo6bCIScseyeXvM538
	QAG61D5RH5ogYvCQ==
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
Subject: [PATCH net-next v3 13/18] net/sched: act_mirred: Move the recursion counter struct netdev_xmit
Date: Wed, 30 Apr 2025 14:47:53 +0200
Message-ID: <20250430124758.1159480-14-bigeasy@linutronix.de>
In-Reply-To: <20250430124758.1159480-1-bigeasy@linutronix.de>
References: <20250430124758.1159480-1-bigeasy@linutronix.de>
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
index 5b38143659249..5f01f567c934d 100644
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
+	return current->net_xmit.sched_mirred_nest++;
+}
+
+static void tcf_mirred_nest_level_dec(void)
+{
+	current->net_xmit.sched_mirred_nest--;
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
2.49.0


