Return-Path: <netdev+bounces-228808-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id C31AABD433F
	for <lists+netdev@lfdr.de>; Mon, 13 Oct 2025 17:29:24 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 94C254FB167
	for <lists+netdev@lfdr.de>; Mon, 13 Oct 2025 15:11:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D845B314D25;
	Mon, 13 Oct 2025 14:54:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="jF5dvbjA"
X-Original-To: netdev@vger.kernel.org
Received: from mail-yw1-f201.google.com (mail-yw1-f201.google.com [209.85.128.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ED27230C63D
	for <netdev@vger.kernel.org>; Mon, 13 Oct 2025 14:54:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760367264; cv=none; b=cs5OHlp1XnQFtVQn46b/i+QzM3z6E7GGbcieMbn7BsC3Y9mzIil5Le27XoYdcJht0gujvoR1DhzQj8tw0XkmI4LyQdzTTFpMOmIgh06X3NlCoc/D6ADr5F0XW2c2avMsHuPfNef/CspXmwJx9ewN6MqUc1qOp7VVJKszAWcTHPw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760367264; c=relaxed/simple;
	bh=4xjnwpDHCO8jZOH0dDAJ859tN+yDaKjmXPpzturFAHM=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=Nzmhy+F3wqqD4tc+o8fPoSDJ4lapikEvAMveBzIl1X832+JfQyyJ4sDX/60ZWIcAcU58vWWnH+8EDxmj+hG3/Gl5+cS5rm7ZRx8o9apOWqmE17CIdwUd02y09yxXDxQ5V+iE92ruQNTVsPTWZuSWM8RDbd6UjR7nI2ymGBBsC6w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--edumazet.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=jF5dvbjA; arc=none smtp.client-ip=209.85.128.201
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--edumazet.bounces.google.com
Received: by mail-yw1-f201.google.com with SMTP id 00721157ae682-7811685b417so39731807b3.1
        for <netdev@vger.kernel.org>; Mon, 13 Oct 2025 07:54:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1760367262; x=1760972062; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=jBTJqKDiqADcC4DXZyV5q7f1a5fG8ExfroHN1cYdpm4=;
        b=jF5dvbjAPE1vdWdolv6mnNI34RSJlcbUbexx5yKpF6xY1jvQtY6fYAUoS1482BmTkc
         pxs1gdikKmJEdt6stu8tRhnKNGOIBVFTSZgj5Nyh8ZM6RIiyvvhXU/2rYGWwgoECtRiN
         NkwcJCmf8OPgyWMXacLDZfqDhhpE6v+jziVoMWBJepN5KoFONnfNMHnJHz1EZ3eAMQ0b
         i3kpb4xd99eKT2GivPEGi3/N0WyPQVhRO44sdk9yyn4uIc7fiyFwolAEQ5ukN9HLXVEl
         3csqQeoxxsf2K7HGIrrBY7/5oGpNCCpRVBUyi2LNJLDXH0AnH8ffNXFjiyspA53qRdyl
         5inw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1760367262; x=1760972062;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=jBTJqKDiqADcC4DXZyV5q7f1a5fG8ExfroHN1cYdpm4=;
        b=AP3DStZvgIoANY0QexJD2sWeY0FOpnQBozAgTHpIbpngCGQzyvxv4h48xRWIqHq1th
         daW/1j2P8lmvD/Cg2Bosq6d6FbPsyQ+S1pmcW6eQmfIFT90wdVlYZGYvazUWUw0AUrWT
         eOvF7b6xSRjZRhndt1cxnAATJqT88gtMxiLtk05Z2W4TA85OhFcm1xQ76CcDSBhL9RkD
         yhSm1zarILzGywuDcIjYKGHIvhISeFXU4vno28sIEUSwE/hAlh5i8SnXnTkg071alGhj
         BRG+vLiTKgwZomtIzPEybibt6A9b6gbCcXDQwa2kUiRdMSeZdKqqXOZiDLk4OfewJEV2
         pZrQ==
X-Forwarded-Encrypted: i=1; AJvYcCV0vf4JkNRuRJcJGj8Q2xc+axMM7YodAqW4tJ2n/jUM2T70yZwBGMseNIpgcrquJtqf0UMyLTc=@vger.kernel.org
X-Gm-Message-State: AOJu0Yzp0gsHE+76dqae7hY3dMyMea77MNxLmKUt4HxLZW5TXkY+aMux
	N8y9r8B/wf0zEeAh+AQe/NJPXmwpjxTWUUQOhLN/pZ7A/1PstUvjRCL+6ikbbTd07U54BCIktb5
	8mu4dHi2NVs+z9w==
X-Google-Smtp-Source: AGHT+IG947YWuCFP4OUIYR0LkYqXV8YmQ/QB3gxK8NR7VU7zWh4B5WD7/DPA/YlhmKo4S77AdwKj3/V1RvL2Og==
X-Received: from ywbeo19.prod.google.com ([2002:a05:690c:2c13:b0:744:417d:fb23])
 (user=edumazet job=prod-delivery.src-stubby-dispatcher) by
 2002:a05:690c:e0a:b0:773:e84f:ece8 with SMTP id 00721157ae682-780e1659b17mr197262747b3.14.1760367261801;
 Mon, 13 Oct 2025 07:54:21 -0700 (PDT)
Date: Mon, 13 Oct 2025 14:54:13 +0000
In-Reply-To: <20251013145416.829707-1-edumazet@google.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20251013145416.829707-1-edumazet@google.com>
X-Mailer: git-send-email 2.51.0.740.g6adb054d12-goog
Message-ID: <20251013145416.829707-3-edumazet@google.com>
Subject: [PATCH v1 net-next 2/5] net/sched: act_mirred: add loop detection
From: Eric Dumazet <edumazet@google.com>
To: "David S . Miller" <davem@davemloft.net>, Jakub Kicinski <kuba@kernel.org>, 
	Paolo Abeni <pabeni@redhat.com>
Cc: Simon Horman <horms@kernel.org>, Jamal Hadi Salim <jhs@mojatatu.com>, 
	Cong Wang <xiyou.wangcong@gmail.com>, Jiri Pirko <jiri@resnulli.us>, 
	Kuniyuki Iwashima <kuniyu@google.com>, Willem de Bruijn <willemb@google.com>, netdev@vger.kernel.org, 
	eric.dumazet@gmail.com, Eric Dumazet <edumazet@google.com>
Content-Type: text/plain; charset="UTF-8"

Commit 0f022d32c3ec ("net/sched: Fix mirred deadlock on device recursion")
added code in the fast path, even when act_mirred is not used.

Prepare its revert by implementing loop detection in act_mirred.

Adds an array of device pointers in struct netdev_xmit.

tcf_mirred_is_act_redirect() can detect if the array
already contains the target device.

Signed-off-by: Eric Dumazet <edumazet@google.com>
---
 include/linux/netdevice_xmit.h |  9 ++++-
 net/sched/act_mirred.c         | 62 +++++++++++++---------------------
 2 files changed, 31 insertions(+), 40 deletions(-)

diff --git a/include/linux/netdevice_xmit.h b/include/linux/netdevice_xmit.h
index 813a19122ebbb2c6a04176330b1055b7c2b9c902..cc232508e695eefe95ea6e55a21978be11d5da83 100644
--- a/include/linux/netdevice_xmit.h
+++ b/include/linux/netdevice_xmit.h
@@ -2,6 +2,12 @@
 #ifndef _LINUX_NETDEVICE_XMIT_H
 #define _LINUX_NETDEVICE_XMIT_H
 
+#if IS_ENABLED(CONFIG_NET_ACT_MIRRED)
+#define MIRRED_NEST_LIMIT	4
+#endif
+
+struct net_device;
+
 struct netdev_xmit {
 	u16 recursion;
 	u8  more;
@@ -9,7 +15,8 @@ struct netdev_xmit {
 	u8  skip_txqueue;
 #endif
 #if IS_ENABLED(CONFIG_NET_ACT_MIRRED)
-	u8 sched_mirred_nest;
+	u8			sched_mirred_nest;
+	struct net_device	*sched_mirred_dev[MIRRED_NEST_LIMIT];
 #endif
 #if IS_ENABLED(CONFIG_NF_DUP_NETDEV)
 	u8 nf_dup_skb_recursion;
diff --git a/net/sched/act_mirred.c b/net/sched/act_mirred.c
index 5f01f567c934d3669d9a3058cff861a8fe5f88b6..f27b583def78e4afecc7112854b93d59c2520201 100644
--- a/net/sched/act_mirred.c
+++ b/net/sched/act_mirred.c
@@ -29,31 +29,6 @@
 static LIST_HEAD(mirred_list);
 static DEFINE_SPINLOCK(mirred_list_lock);
 
-#define MIRRED_NEST_LIMIT    4
-
-#ifndef CONFIG_PREEMPT_RT
-static u8 tcf_mirred_nest_level_inc_return(void)
-{
-	return __this_cpu_inc_return(softnet_data.xmit.sched_mirred_nest);
-}
-
-static void tcf_mirred_nest_level_dec(void)
-{
-	__this_cpu_dec(softnet_data.xmit.sched_mirred_nest);
-}
-
-#else
-static u8 tcf_mirred_nest_level_inc_return(void)
-{
-	return current->net_xmit.sched_mirred_nest++;
-}
-
-static void tcf_mirred_nest_level_dec(void)
-{
-	current->net_xmit.sched_mirred_nest--;
-}
-#endif
-
 static bool tcf_mirred_is_act_redirect(int action)
 {
 	return action == TCA_EGRESS_REDIR || action == TCA_INGRESS_REDIR;
@@ -439,44 +414,53 @@ TC_INDIRECT_SCOPE int tcf_mirred_act(struct sk_buff *skb,
 {
 	struct tcf_mirred *m = to_mirred(a);
 	int retval = READ_ONCE(m->tcf_action);
-	unsigned int nest_level;
+	struct netdev_xmit *xmit;
 	bool m_mac_header_xmit;
 	struct net_device *dev;
-	int m_eaction;
+	int i, m_eaction;
 	u32 blockid;
 
-	nest_level = tcf_mirred_nest_level_inc_return();
-	if (unlikely(nest_level > MIRRED_NEST_LIMIT)) {
+#ifdef CONFIG_PREEMPT_RT
+	xmit = &current->net_xmit;
+#else
+	xmit = this_cpu_ptr(&softnet_data.xmit);
+#endif
+	if (unlikely(xmit->sched_mirred_nest >= MIRRED_NEST_LIMIT)) {
 		net_warn_ratelimited("Packet exceeded mirred recursion limit on dev %s\n",
 				     netdev_name(skb->dev));
-		retval = TC_ACT_SHOT;
-		goto dec_nest_level;
+		return TC_ACT_SHOT;
 	}
 
 	tcf_lastuse_update(&m->tcf_tm);
 	tcf_action_update_bstats(&m->common, skb);
 
 	blockid = READ_ONCE(m->tcfm_blockid);
-	if (blockid) {
-		retval = tcf_blockcast(skb, m, blockid, res, retval);
-		goto dec_nest_level;
-	}
+	if (blockid)
+		return tcf_blockcast(skb, m, blockid, res, retval);
 
 	dev = rcu_dereference_bh(m->tcfm_dev);
 	if (unlikely(!dev)) {
 		pr_notice_once("tc mirred: target device is gone\n");
 		tcf_action_inc_overlimit_qstats(&m->common);
-		goto dec_nest_level;
+		return retval;
 	}
+	for (i = 0; i < xmit->sched_mirred_nest; i++) {
+		if (xmit->sched_mirred_dev[i] != dev)
+			continue;
+		pr_notice_once("tc mirred: loop on device %s\n",
+			       netdev_name(dev));
+		tcf_action_inc_overlimit_qstats(&m->common);
+		return retval;
+	}
+
+	xmit->sched_mirred_dev[xmit->sched_mirred_nest++] = dev;
 
 	m_mac_header_xmit = READ_ONCE(m->tcfm_mac_header_xmit);
 	m_eaction = READ_ONCE(m->tcfm_eaction);
 
 	retval = tcf_mirred_to_dev(skb, m, dev, m_mac_header_xmit, m_eaction,
 				   retval);
-
-dec_nest_level:
-	tcf_mirred_nest_level_dec();
+	xmit->sched_mirred_nest--;
 
 	return retval;
 }
-- 
2.51.0.740.g6adb054d12-goog


