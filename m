Return-Path: <netdev+bounces-281327-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id GOvCGz5k72mHAwEAu9opvQ
	(envelope-from <netdev+bounces-281327-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Mon, 27 Apr 2026 15:27:26 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id 26B754735D8
	for <lists+netdev@lfdr.de>; Mon, 27 Apr 2026 15:27:26 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id A09B83025156
	for <lists+netdev@lfdr.de>; Mon, 27 Apr 2026 13:26:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 487E13C6608;
	Mon, 27 Apr 2026 13:26:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="e7Emf6UP"
X-Original-To: netdev@vger.kernel.org
Received: from mail-yw1-f201.google.com (mail-yw1-f201.google.com [209.85.128.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D42BE3C456B
	for <netdev@vger.kernel.org>; Mon, 27 Apr 2026 13:26:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777296367; cv=none; b=crXyNftdafHXze0ZSYMGTFJpawTtL0/Q483n+70av1OY757hF4LMedyey2sEw2xBbMdj6+mBIcLQPJDInPW2kP12CE1JX+5E//WQ53fuT58CqobwDnjojDiE6Rx/eWWxMlLuk0U0BCPjytymoIeQ2UTxWk9OknwLh0e5bA0kopo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777296367; c=relaxed/simple;
	bh=Y/cHpTqKmY0n8eiE/c+mHiCzJqCMsCituCZ7btZ/FaQ=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=OcVAUAEFAwCgAI2OEkRBSKlH9jd2tod2ekbKw48CyLjzoJSb2je3U0pQjybntcinoXOgz3edT0Hs5LvpbThcYBGrX8XrAzq6/SOcdkPeskwjCoa1Z7pdYCnfGo3mNKKUgjADSf6xUwJijPY2zoAl9+XkmS7sQHfguGdhaZZJG6Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--edumazet.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=e7Emf6UP; arc=none smtp.client-ip=209.85.128.201
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--edumazet.bounces.google.com
Received: by mail-yw1-f201.google.com with SMTP id 00721157ae682-79aa3a19ea3so175986897b3.0
        for <netdev@vger.kernel.org>; Mon, 27 Apr 2026 06:26:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1777296365; x=1777901165; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=sIYNGfPuuyKIwDdMD5kSxfGL6KFegj4pz/UKfqYNwOs=;
        b=e7Emf6UP0AjxdWl/KOEWPRjwS8pR7atmEQguGTfaSUBiCdk8QbLLy4LFCXGkPjJvMG
         Y2Cb+fUtNS0Rx0vy5212X5/rBESpkjmrrGyEHrNStng6xQpgqHHyotKNpLmgkm+mkiDz
         pMY5nEyZXyfnsdvcrjpJHyYGubIT7zjp3eipl6rCMi7IhVJh2FRvr34xJ/k/15pMkSCt
         Bh8psyy5iq5jTSWEpjMsIlMR2mPJdJk35AR8cirI53/yogaxyqzdtY0t6VDtx8l5Fil1
         Al2q6juP9pikzRi9njNjGvpHqzRvRC28aVq/5+SpBvnxnhZ+1SniAtM1qdcmftkLnZo/
         HxDw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1777296365; x=1777901165;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=sIYNGfPuuyKIwDdMD5kSxfGL6KFegj4pz/UKfqYNwOs=;
        b=s+2qcI95bWpulGyPDjeAKuQECGf6KSw5CxCPcF/yijPs3S2P0YDj+nNxbW38ymQliA
         P8qYwIUXo7AF8JjutLwde3DpbYbCAmyspf797P2dZM9p37kz0t5AJm+4yti4ATPFWs5X
         Dg1GCD1tyce8cmeZr/h6wqULiToc1Tg933hjikrpnfa623pdK9xQ9/Sor040ZrR6jJWs
         7bZcJvM//Zp3WrpziMe1+cP3HqrOyBA8hONsM1IpmdV4spj8M9peTgspg1TzADtEZx/Y
         t+dr4IV+w2hTwfIjdUGKKCa7CvI9h9BSBokdEqa46xU0Zl87D/Ua4mxmZApCucj15bC2
         6VXQ==
X-Forwarded-Encrypted: i=1; AFNElJ89nDzcKrw+9F5OruSJnXQWAfMgrZunw3axmmaygB0yv7kAN8cI1DNVDROpe0zNtMRqPKQRB/s=@vger.kernel.org
X-Gm-Message-State: AOJu0YxKSLfKJI1HhZXqWMoUlxML78rdIrNe0laBQjE+jbOVxFY/YKg2
	Tdutr+tPNttCsEWr2tbytJW2DTawsIzF9Zo036i8+niGEe6zNOg95Tib4cCMv5sBhrXSCam/CUp
	gaDMMIDG9lgBJGg==
X-Received: from ywbnj23.prod.google.com ([2002:a05:690c:8e17:b0:7b3:dca5:e065])
 (user=edumazet job=prod-delivery.src-stubby-dispatcher) by
 2002:a05:690c:60c1:b0:798:ff2f:2666 with SMTP id 00721157ae682-7b9ecefbc1cmr459071777b3.16.1777296364450;
 Mon, 27 Apr 2026 06:26:04 -0700 (PDT)
Date: Mon, 27 Apr 2026 13:25:55 +0000
In-Reply-To: <20260427132555.1791636-1-edumazet@google.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20260427132555.1791636-1-edumazet@google.com>
X-Mailer: git-send-email 2.54.0.545.g6539524ca2-goog
Message-ID: <20260427132555.1791636-5-edumazet@google.com>
Subject: [PATCH net-next 4/4] net/sched: speedup tc_dump_qdisc() when
 tcm_ifindex is provided
From: Eric Dumazet <edumazet@google.com>
To: "David S . Miller" <davem@davemloft.net>, Jakub Kicinski <kuba@kernel.org>, 
	Paolo Abeni <pabeni@redhat.com>
Cc: Simon Horman <horms@kernel.org>, Jamal Hadi Salim <jhs@mojatatu.com>, Jiri Pirko <jiri@resnulli.us>, 
	Kuniyuki Iwashima <kuniyu@google.com>, netdev@vger.kernel.org, eric.dumazet@gmail.com, 
	Eric Dumazet <edumazet@google.com>
Content-Type: text/plain; charset="UTF-8"
X-Rspamd-Queue-Id: 26B754735D8
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [0.84 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	MID_CONTAINS_FROM(1.00)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MV_CASE(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[google.com,reject];
	R_SPF_ALLOW(-0.20)[+ip4:172.105.105.114:c];
	R_DKIM_ALLOW(-0.20)[google.com:s=20251104];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FREEMAIL_CC(0.00)[kernel.org,mojatatu.com,resnulli.us,google.com,vger.kernel.org,gmail.com];
	RCVD_COUNT_THREE(0.00)[4];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-281327-lists,netdev=lfdr.de];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[edumazet@google.com,netdev@vger.kernel.org];
	DKIM_TRACE(0.00)[google.com:+];
	RCPT_COUNT_SEVEN(0.00)[10];
	NEURAL_HAM(-0.00)[-0.999];
	TAGGED_RCPT(0.00)[netdev];
	ASN(0.00)[asn:63949, ipnet:172.105.96.0/20, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns]

There is no point dumping qdiscs for all devices when user space
wants them for a single device:

tc -s -d qdisc show dev eth1

Signed-off-by: Eric Dumazet <edumazet@google.com>
---
 net/sched/sch_api.c | 11 ++++++++++-
 1 file changed, 10 insertions(+), 1 deletion(-)

diff --git a/net/sched/sch_api.c b/net/sched/sch_api.c
index c4e8059acdd324441e0d069f6878bbfcab5a0cc7..8d0e4eb72103d9b074131e13e31830cb266eadba 100644
--- a/net/sched/sch_api.c
+++ b/net/sched/sch_api.c
@@ -1874,6 +1874,7 @@ static int tc_dump_qdisc_root(struct Qdisc *root, struct sk_buff *skb,
 static int tc_dump_qdisc(struct sk_buff *skb, struct netlink_callback *cb)
 {
 	const struct nlmsghdr *nlh = cb->nlh;
+	const struct tcmsg *tcm = nlmsg_data(nlh);
 	struct net *net = sock_net(skb->sk);
 	struct nlattr *tca[TCA_MAX + 1];
 	struct {
@@ -1892,6 +1893,9 @@ static int tc_dump_qdisc(struct sk_buff *skb, struct netlink_callback *cb)
 	if (err < 0)
 		return err;
 
+	if (!ctx->ifindex)
+		ctx->ifindex = tcm->tcm_ifindex;
+
 	s_ifindex = ctx->ifindex;
 	s_q_idx = ctx->q_idx;
 
@@ -1899,8 +1903,13 @@ static int tc_dump_qdisc(struct sk_buff *skb, struct netlink_callback *cb)
 		struct netdev_queue *dev_queue;
 		struct Qdisc *q;
 
-		if (ctx->ifindex > s_ifindex)
+		if (ctx->ifindex > s_ifindex) {
+			if (tcm->tcm_ifindex) {
+				ctx->ifindex = ULONG_MAX;
+				break;
+			}
 			s_q_idx = 0;
+		}
 		q_idx = 0;
 
 		netdev_lock_ops(dev);
-- 
2.54.0.545.g6539524ca2-goog


