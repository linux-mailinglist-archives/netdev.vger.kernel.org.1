Return-Path: <netdev+bounces-182333-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 87CE3A8880E
	for <lists+netdev@lfdr.de>; Mon, 14 Apr 2025 18:10:31 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 4527D176E21
	for <lists+netdev@lfdr.de>; Mon, 14 Apr 2025 16:09:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8E720288CA9;
	Mon, 14 Apr 2025 16:08:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="u0p8o9lS";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="7o7XSzmx"
X-Original-To: netdev@vger.kernel.org
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B515D284699
	for <netdev@vger.kernel.org>; Mon, 14 Apr 2025 16:08:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744646898; cv=none; b=Ao/kpFz6D4cNjObYX/g2dFlu0mfGh1RVYPJ3bG2sMn661RZ81+Ei5TPDEAO2DOrCr3UHgpeG68Oscw6FkeI5Ysmiqwm6eAW4cCDCGGHmI65yJUW1wMyxGFkchOkYw9GT9nZRKsUhhmPihMsc6Jz7pPFLDb81ISrSMkLHG8nuT34=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744646898; c=relaxed/simple;
	bh=zrHr0oIdmFVvuqReRS6A1Vk8JfCJLTqEyMuMgmRm85A=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=l1HaPTgpMq2QAKofJzniY/5IurJTL4KyP35DFqRDTJhO810m0NWalbM/xJKtKbX05GufmODomR8DD8W72FQp8tt2AeoEcRqIagAQvqpi1uhx3h8LmVGxbm3cUCndlbeQiHrQw+fONQN7Rm88wu17ip6+G0C/7N9XN4FFTcyKjNA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=u0p8o9lS; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=7o7XSzmx; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
From: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1744646893;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=ItheQOXN0W8/U3eIeVElS1GMGBEBaL1p1NvXJGWnpLY=;
	b=u0p8o9lSr8QSW5yjQvmHEHfTLSQ1cjSD+GMUHGAjsBaSkMiQkBGTW7BNgndXGSbM6pM/X6
	2IMKASyTEQCszA3vfJnT6DNIudR/ZUMrAGnTZIzgzQZ5eJ5Yk90K505ZUFZzU0hJvYqChz
	9Q9Ig/wkZBonYfl/+gHJsVTjii0D6j55TJ/cg5+D9XT9fVpsjpTObP0FztPx4+ww099oCA
	spvOXQ4V/a9g33xyilwEH0JQ1XfmQbMQBPTo3RQASib2GXQYLqrpEjOQeD1YEkb+S2w9rV
	uXO18WEVwYZQDNXN9M9spuYkQpOTtr8uKIrJHCkQ4zD6C+XMcU9/KOP30FcK1w==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1744646893;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=ItheQOXN0W8/U3eIeVElS1GMGBEBaL1p1NvXJGWnpLY=;
	b=7o7XSzmxcMa4Pl4d2mBEf53ukv6SKPSmNrSfSxM8hpIuh7VZeUsncz6fKPrHDz3PMpnjKz
	n216a2vVAgUR8dAg==
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
Subject: [PATCH net-next v2 13/18] net/sched: act_mirred: Move the recursion counter struct netdev_xmit
Date: Mon, 14 Apr 2025 18:07:49 +0200
Message-ID: <20250414160754.503321-14-bigeasy@linutronix.de>
In-Reply-To: <20250414160754.503321-1-bigeasy@linutronix.de>
References: <20250414160754.503321-1-bigeasy@linutronix.de>
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


