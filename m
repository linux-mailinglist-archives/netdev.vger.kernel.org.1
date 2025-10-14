Return-Path: <netdev+bounces-229337-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id BFECFBDAC13
	for <lists+netdev@lfdr.de>; Tue, 14 Oct 2025 19:19:38 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id D6F194E18C7
	for <lists+netdev@lfdr.de>; Tue, 14 Oct 2025 17:19:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E514A30748C;
	Tue, 14 Oct 2025 17:19:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="3yftRpzm"
X-Original-To: netdev@vger.kernel.org
Received: from mail-qv1-f74.google.com (mail-qv1-f74.google.com [209.85.219.74])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2EDDC3054E8
	for <netdev@vger.kernel.org>; Tue, 14 Oct 2025 17:19:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.74
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760462356; cv=none; b=d5iAuSkEXQP+YWD3xY7r/nnsU/+Syk7xmgDIsaBry91zJs3y4BCKmtQwQdjajuX0GvqPYcwpqDBuXnHlTN8HClOoLI6PE5yID8Q7FhZqderfF5uFF+XCSQI4jHJwHG/EkWVeF/6aS9AHxOdZCM3Fb/MX5FIbfp8Ix6q7pjhXwHI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760462356; c=relaxed/simple;
	bh=HkID3hviyDsa67DAlj9BCV7RkR3NCANyjPU9RV4qBmw=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=QFdUcNaBcJzthPiB/AFGum7a1yZdqaZ1ld7U873SjYbEkSEFHxR1gmHubsiNzwF6fh9LsxmGiGVg7t98TCDS1gtEPLhvVsX3/lrRSb4gaTfYcb8Cyfd2Sja0WhgKVHKYn5uS6sGtYG559Anne7idY/gZ5BTUJw2y9kQDmzKmvMY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--edumazet.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=3yftRpzm; arc=none smtp.client-ip=209.85.219.74
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--edumazet.bounces.google.com
Received: by mail-qv1-f74.google.com with SMTP id 6a1803df08f44-78ea15d3583so251609446d6.1
        for <netdev@vger.kernel.org>; Tue, 14 Oct 2025 10:19:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1760462354; x=1761067154; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=ZrVgTDbKdev9CuYZzIgg4Tz0/FyJ39vJV60DQopgDyo=;
        b=3yftRpzm+6L6oDnwrdpWSjCaEJgSG5KDTM/rzZvS8Um2fCaXCJFgOtVOXpNDM69yxb
         pyeFrbqae/vdWwyz193L+/hskk4JGSunM3Jq7Pf8hesePzNyhBFhMve8EdzC0TJaVt3t
         OxeAUsLHP0wFHEMLYWUP8k4YujD90UHtTtKoFlI39XsZorijhp1X5xAR0LV1c9aMxC1F
         EaXQMKWKt6LKZOiFXH/IUsDZu1nkby30vQX27hhyPhwgP7STxAX/YVA6dsh0nrOPkWDc
         I3VU00uTLcIYzQfjTp4dDw/HqLlWir4PCgj768gmAybzpNJaI7wiZWAZa3oy1yDKH2t6
         HR9Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1760462354; x=1761067154;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=ZrVgTDbKdev9CuYZzIgg4Tz0/FyJ39vJV60DQopgDyo=;
        b=Mq5ojGQWHogw4shVnYlOBCT15N5LJoLaM0xvVY1UAjKxYSmeeJ6IGgI4HmTwLtAEai
         FUYSStN/rRQv0UjDRVTf81RMFyjsnk7d3ErXpYmqa9uhj6X60lG1Mn9wLe/qWEqmyEG+
         vcyW6kXlS83587+zxChtAc29qA3OKF+Mulpa/2e0Y9Qdb5+xtDX1hapALPt+T728UPUZ
         F6oStyIjBjDd9sd2EqS//5MeFwFp/jsi7NiwBYZ1ESfQm0ITHpCqmX4F6QfVKshlHgf9
         8HZJ7NRaN5p9lriBWuIKwEnX4tnblwXOTzhkxOsUWLRM8MuArRgkz3XL4d06qC65HzW3
         8bNQ==
X-Forwarded-Encrypted: i=1; AJvYcCUiTsc+TdzyZ1nx2hcn0JBsDV7VhwQv0GcGQAF3X8KgeyrJFwfQjw2AVWlCZmbIcTLFTOVvIXk=@vger.kernel.org
X-Gm-Message-State: AOJu0YxNsulj2HYFKAHJGOcGRvjfhFOPVqV1qXeUpk9/cYssQFes2tZC
	ZV6aKHc4GE2QAqhKjAHLieagaAvjP/3tm9UQwWwCxgMeBJJXLGr42w/AoM21aATZ8dNCrXiOGdD
	ftWDs/VLuxVljvA==
X-Google-Smtp-Source: AGHT+IFdEZsxpDLKu7PzPs0ZwOkidIwHXit8uh1ZwHVkRqCQ0iZ3PaD2l7IABiLh4KVk3F3gMIgIcBKrXErOmw==
X-Received: from qtkp20.prod.google.com ([2002:a05:622a:13d4:b0:4b7:a698:dea7])
 (user=edumazet job=prod-delivery.src-stubby-dispatcher) by
 2002:a05:622a:2517:b0:4dd:d5ad:a0b0 with SMTP id d75a77b69052e-4e6ead671dbmr329452011cf.72.1760462353930;
 Tue, 14 Oct 2025 10:19:13 -0700 (PDT)
Date: Tue, 14 Oct 2025 17:19:04 +0000
In-Reply-To: <20251014171907.3554413-1-edumazet@google.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20251014171907.3554413-1-edumazet@google.com>
X-Mailer: git-send-email 2.51.0.788.g6d19910ace-goog
Message-ID: <20251014171907.3554413-4-edumazet@google.com>
Subject: [PATCH v2 net-next 3/6] net/sched: act_mirred: add loop detection
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
index 813a19122ebb..cc232508e695 100644
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
index 5f01f567c934..f27b583def78 100644
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
2.51.0.788.g6d19910ace-goog


