Return-Path: <netdev+bounces-228020-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id D4417BBF190
	for <lists+netdev@lfdr.de>; Mon, 06 Oct 2025 21:31:23 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 8555D4F1360
	for <lists+netdev@lfdr.de>; Mon,  6 Oct 2025 19:31:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 246E41D6187;
	Mon,  6 Oct 2025 19:31:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="4O0Oc+oL"
X-Original-To: netdev@vger.kernel.org
Received: from mail-yw1-f201.google.com (mail-yw1-f201.google.com [209.85.128.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6D9A0226D18
	for <netdev@vger.kernel.org>; Mon,  6 Oct 2025 19:31:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759779073; cv=none; b=WthJq1/V2sZ+hnQXeZoel5rqiwZjByLuj6J1C8A/Vg9kuTiZid28KR0nZkcWx6HkFkHgRvt/pjuQ7PmzyraEcKnsq7hTnVZjtoA91AObTQTR1k9qSgzwIS7fY9Ird5z/qtY/jwjys/+PTBkVgICiGMroCB+Kr3/WoWD7iYvbKDs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759779073; c=relaxed/simple;
	bh=W4a48ognHQrxZfcR3egfBH85YvpqX0ZF8qd0JDfkI/s=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=TTrXg8ny6qD+o1VSI4RWlB5HwAb6pMONV+8+3t4O/4nt/IEyFHc2X5j3TSlsivx2l3E4K5qCz9OFWc6ozx9/5vobvznCs2u+/Rhh7z/JFQYZGTVLQALTXLRJQhZ7CBzk2DRGjrpdaQnrw1p61PjZZUHRiQMTLx3jbhGr/XkrcPM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--edumazet.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=4O0Oc+oL; arc=none smtp.client-ip=209.85.128.201
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--edumazet.bounces.google.com
Received: by mail-yw1-f201.google.com with SMTP id 00721157ae682-77f98d8fff8so50087827b3.1
        for <netdev@vger.kernel.org>; Mon, 06 Oct 2025 12:31:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1759779070; x=1760383870; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=vsbIwyLwnwz7VPFH7PjK3J2TP6OkaXz7Lb3mQhUGyHA=;
        b=4O0Oc+oLNoBUlYFk01Qhc7Z9OAdcl+via/15d3VbEyQXYmEvlqft+nsj5IoW8v5Iie
         cqpAja3eXFFkRC/DbZ102aJzYgYMXgztXukE+BkwWutU4TjtEDwxzzuTmtfe7SUu9f8L
         XBNWFjauhktsNxPJLtAenQOk1e++/6cuykvM5zzbh7OujwHLO0PgFrUqYaMAHSfC85Yo
         PNl6tUQcRQ5Yd9LWk5SSfbCDU5gDTcfn61tfL3zmOzyxN9HL/Ao1GKfqtaUEWj53+vLv
         06DbFf5+0l+o0814OXPSX559Vwyhu7ONr5ZNjjG8QNpdat78+N/kyCC0Nn0QLm2rg8XC
         vzyA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1759779070; x=1760383870;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=vsbIwyLwnwz7VPFH7PjK3J2TP6OkaXz7Lb3mQhUGyHA=;
        b=GbHOrRCAJdUsxf+ggGnH1m/8+t6JarpXzvUvXhGvuPHdThLYKLIjLAwqjoXAS6zNls
         qBRmEwfQvEyGEIlH0Q3z2vU5nioL/GNUGg9ExaoQ6ddFTuxp1QyJrEyydmiKWNdbTrRu
         PGt33sIUgVEpbxO7jHjEnISsDh+AYz1z7WCTW8kNWlUFqtJn8/0OVKyGpgtpC2PHbqDy
         L8+vPbUvooMypH+MhnaOrnVLYw1p5eLiISJjJy0xJuFRoPAj+A1vFriCRHrABj7iJlBa
         +rn09r/Ic9pp9gZBxK61EoOGCpdwkvFLfc6V/VpwqlUadAe033bHzRqEyuEF1fXFYPQ8
         FiAA==
X-Forwarded-Encrypted: i=1; AJvYcCUyzohYEwAjpOuEBR/if96tr/YsKy8uPhrObpXagscf18JMgrMdCNRrnPSUvIBA6VUMnMEKZhE=@vger.kernel.org
X-Gm-Message-State: AOJu0YztTS/URHTqoOooKklTVsPgCcc9nrpco7CxX+/n4ByJ4L779GYU
	1Oa7q30BBFl2Mwc1Ro8qlweKviXJaZgQroWJDA64JRWCHF4Fz4+m4I4Q8O5NphE8bhM5H326eHC
	Sgj/7JW8UbquWUA==
X-Google-Smtp-Source: AGHT+IFW29iHkIoYmVdcUV/VWV5LJvk6dc30SyOR9Xs+6rhuoqY8piK+iAwMvtYiceo8bK9XnG4L4plbRrbTlw==
X-Received: from ywbis5.prod.google.com ([2002:a05:690c:6c85:b0:779:9c5b:a46e])
 (user=edumazet job=prod-delivery.src-stubby-dispatcher) by
 2002:a05:690c:508c:b0:780:be5b:345b with SMTP id 00721157ae682-780be5b3782mr51505607b3.20.1759779070192;
 Mon, 06 Oct 2025 12:31:10 -0700 (PDT)
Date: Mon,  6 Oct 2025 19:31:00 +0000
In-Reply-To: <20251006193103.2684156-1-edumazet@google.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20251006193103.2684156-1-edumazet@google.com>
X-Mailer: git-send-email 2.51.0.618.g983fd99d29-goog
Message-ID: <20251006193103.2684156-3-edumazet@google.com>
Subject: [PATCH RFC net-next 2/5] net/sched: act_mirred: add loop detection
From: Eric Dumazet <edumazet@google.com>
To: "David S . Miller" <davem@davemloft.net>, Jakub Kicinski <kuba@kernel.org>, 
	Paolo Abeni <pabeni@redhat.com>
Cc: Simon Horman <horms@kernel.org>, Jamal Hadi Salim <jhs@mojatatu.com>, 
	Cong Wang <xiyou.wangcong@gmail.com>, Jiri Pirko <jiri@resnulli.us>, 
	Kuniyuki Iwashima <kuniyu@google.com>, Willem de Bruijn <willemb@google.com>, netdev@vger.kernel.org, 
	eric.dumazet@gmail.com, Eric Dumazet <edumazet@google.com>
Content-Type: text/plain; charset="UTF-8"

We want to revert commit 0f022d32c3ec ("net/sched: Fix mirred deadlock
on device recursion") because it adds code in the fast path, even when
act_mirred is not used.

Use an additional device pointers array in struct netdev_xmit
and implement loop detection in tcf_mirred_is_act_redirect().

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
2.51.0.618.g983fd99d29-goog


