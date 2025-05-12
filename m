Return-Path: <netdev+bounces-189699-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 15695AB339A
	for <lists+netdev@lfdr.de>; Mon, 12 May 2025 11:32:35 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 11A35188C160
	for <lists+netdev@lfdr.de>; Mon, 12 May 2025 09:31:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9B969267F70;
	Mon, 12 May 2025 09:27:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="aUzi2Y5u";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="6i5YlaKb"
X-Original-To: netdev@vger.kernel.org
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0023A266B6F
	for <netdev@vger.kernel.org>; Mon, 12 May 2025 09:27:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747042071; cv=none; b=prxhsuZwgobbkL0nT55k4in+Ll71l8vgWjUyIcV0p3OdN4cdYQyI1a34sPYu1E/bXajo6qGr8GrDQXl89cdVj+DrV17thhEoEFDnZYYOuNx9pBk+9tWca/Tq6VAzNtpMWJqy8a71bQpDkNKsdoeaJTSXEY1Dm44RJv5gxYS36NU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747042071; c=relaxed/simple;
	bh=6gROV9Xhc9iKxYqUpJRUS2t/pH/fNlLUdkx0ZKaOOpU=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=fKVCQtd7HaWt089XO3djiH+OBWQghu56d07ABATO5EDhPBrykUC6DcJfVGoZhw9rXEIIhOkoG2HNTz1DdaOWns6Yh3vUh6siHnvcM3ON64riENiO9vTFHYX6AfmQjVPQZHAbp7ZYqiChvRymi4TijkyZ34QPErygQ3dKAtuJ980=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=aUzi2Y5u; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=6i5YlaKb; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
From: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1747042066;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=DKaaIvE6mMZEEpGXq0LGZKreo8xS5i1HD4lFek72h90=;
	b=aUzi2Y5uqxZS9vvYQoRfjLRYbGhMQ766GP1HsKBN7NWf5sHZsXW86uDhKnh/3Ht1Me5FBp
	Qp1UW5AJWyUkYP3t7dzgQ4j5iyMy8yWKbiJQYLSIWEtgG2v7x1ry27d1bjClx3KfQNcinD
	Xi4BIvHKoCmitCiOVTvXJXZE28apLaB3k5ulruV3pvp5D4IGnryORDkE7gwDn7Gtd/saJc
	t+vOhwD8tMn8jZcRcqTc2mvX3bC8ikqSDjyJPAgZA6+mm+gDinJVEME+GLyEKi3sgM781B
	hgELOX/2qtsmTyNEtj0L9Zc4SFy+vL5uOWlpIn6+4rq8d9V3WggzLww7800mew==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1747042066;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=DKaaIvE6mMZEEpGXq0LGZKreo8xS5i1HD4lFek72h90=;
	b=6i5YlaKb3tv6fwK8PqcV4Vty2FlShxQrXILQM6XJ4zW5h/IBnQmqR2vsO5yWVBwT1aMh4A
	OMHaKbW3o1Z9ogBw==
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
Subject: [PATCH net-next v4 10/15] net/sched: act_mirred: Move the recursion counter struct netdev_xmit
Date: Mon, 12 May 2025 11:27:31 +0200
Message-ID: <20250512092736.229935-11-bigeasy@linutronix.de>
In-Reply-To: <20250512092736.229935-1-bigeasy@linutronix.de>
References: <20250512092736.229935-1-bigeasy@linutronix.de>
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
index 38325e0702968..848735b3a7c02 100644
--- a/include/linux/netdevice_xmit.h
+++ b/include/linux/netdevice_xmit.h
@@ -8,6 +8,9 @@ struct netdev_xmit {
 #ifdef CONFIG_NET_EGRESS
 	u8  skip_txqueue;
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


