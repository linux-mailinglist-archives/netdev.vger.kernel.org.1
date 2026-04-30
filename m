Return-Path: <netdev+bounces-282608-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id umKoJEPA8mnktwEAu9opvQ
	(envelope-from <netdev+bounces-282608-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Thu, 30 Apr 2026 04:36:51 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id EA34549C64E
	for <lists+netdev@lfdr.de>; Thu, 30 Apr 2026 04:36:50 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id E13F9300C26D
	for <lists+netdev@lfdr.de>; Thu, 30 Apr 2026 02:36:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C01CE2C029D;
	Thu, 30 Apr 2026 02:36:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="PRZ7pHPf"
X-Original-To: netdev@vger.kernel.org
Received: from mail-qk1-f202.google.com (mail-qk1-f202.google.com [209.85.222.202])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 82C9F29B8D3
	for <netdev@vger.kernel.org>; Thu, 30 Apr 2026 02:36:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.202
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777516601; cv=none; b=J1nZZ1kd0MKvQN+P7ozX5GSlF2FrI/170JhJJoryVx0Bmuqiu4tZoO+h9G8kocdRYCUwbLgJwcY85IsgP7q9S2dHnVqxP/+8ia1xJZEDLx7ysv17K9gwIh94UY/DelU50RqTFn6eaetL/X2lBSZbdHFGQPMwqx1PUnhRTFUSXhY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777516601; c=relaxed/simple;
	bh=rqIfcvFJMU4U4AVHcj0LU7UoHNsl+kuvgRjGup0eiwc=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=M6/SJmwL67T81oUBsHZ0L+fGW64XZ2qJkpMGRcKeQT4AaahqL09iPZiJIqorwxiP7vcU+0Hu5IgJfNSEbfYMMOlsYN7DfQGVuhCQ0yu4DTrJhQHCKo4erOf9Qu8PPUnh2xYw4AU0CxR+lCN6rhK23Jn/AFaUSAt6Se4JA/BT4g4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--edumazet.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=PRZ7pHPf; arc=none smtp.client-ip=209.85.222.202
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--edumazet.bounces.google.com
Received: by mail-qk1-f202.google.com with SMTP id af79cd13be357-8ead5ab474bso89714985a.1
        for <netdev@vger.kernel.org>; Wed, 29 Apr 2026 19:36:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1777516599; x=1778121399; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=/bMNpW3c4F75ct2ys7AkCXK7g/wrITynXJXwYUZMSu4=;
        b=PRZ7pHPfCF28S8dBQNsNtyq74NAf/pXQcLQ7UM6WE8bM9L1Hwr98jgjFZLQsqBbnJa
         boelsPZIXCkiVTRAU6fSY+XVQdPQQxqnbbzkbw/9+9N7gZ2i/Xt3kGZDPj0lfnvVL8Uo
         LYzbRCGeLHlCsoPr33PsVlkaRoXFDtu+2UODqXUe6K04R0G9bapAdUtcweXXJz46gxx4
         wxDYuRKUVcXWXWIppkMBpnD0VzTLC3XieFLJAQGu8PtliOv4YZlgBzz0AwfPfLoyHH7O
         t67VUz2LyX2IrdaSgHSPS8V2hQ0kQzIoAmRz6TUBFiBg/kdUuBvbajwiSy/czKLeKR5r
         JU/g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1777516599; x=1778121399;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=/bMNpW3c4F75ct2ys7AkCXK7g/wrITynXJXwYUZMSu4=;
        b=l0PJkKY1r+7rSohB23c/SC3fip9g9V//7H8Y48maNFHD1VEVebOOlolUU4Los+NJ8p
         p8fa6fnIH+43sB5R81ser6lp8Sdg9J7WzcNDvI4gwyHF2ysG5AV0jm+KjtNugby6hwYs
         NHUZfD6JEyVGUvXdJgeNVIXmgXUCHGML1U01y8GCYMnyDF8lyPy3HIPYnVBAJbBHsGee
         82eTSOKE6K4pwgbr/kFGYOW7hLLfJJBsEq01XrS0UpFRpmmrfPn/HOR8HWzMC2bZIwLq
         aFTrnG8S+qjLBKXHqXORelqhlFIYQppoyU2K2vfzFPLSi5+OUMgYDzTQMlF+hRQEblLh
         xlLg==
X-Forwarded-Encrypted: i=1; AFNElJ8JI4seMllW+ECqGMQyeId8RVGbKPLLOsQi07wIOJsbHzfCSVRK/7Auqkuacs8hd8CWh9p+V8s=@vger.kernel.org
X-Gm-Message-State: AOJu0YzB7riQvufiNyIzlqsoEBNh5K19Oa5yyYOhjSXT3mH9bjj9BKtx
	vRgYNLCf5CPMq+SOuJCDMMWZoh081EfTj9XdcKg7yKsLbLrUgXR2tHZVxn1uim63jY5XpI2flOI
	Im6N+ENk46/CuIg==
X-Received: from qkntp5.prod.google.com ([2002:a05:620a:3c85:b0:8d4:abda:a95])
 (user=edumazet job=prod-delivery.src-stubby-dispatcher) by
 2002:a05:620a:c4d:b0:8ef:1157:6a05 with SMTP id af79cd13be357-8fa86fa7612mr206005285a.19.1777516599205;
 Wed, 29 Apr 2026 19:36:39 -0700 (PDT)
Date: Thu, 30 Apr 2026 02:36:28 +0000
In-Reply-To: <20260430023628.3216283-1-edumazet@google.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20260430023628.3216283-1-edumazet@google.com>
X-Mailer: git-send-email 2.54.0.545.g6539524ca2-goog
Message-ID: <20260430023628.3216283-5-edumazet@google.com>
Subject: [PATCH v3 net-next 4/4] net/sched: speedup tc_dump_qdisc() when
 tcm_ifindex is provided
From: Eric Dumazet <edumazet@google.com>
To: "David S . Miller" <davem@davemloft.net>, Jakub Kicinski <kuba@kernel.org>, 
	Paolo Abeni <pabeni@redhat.com>
Cc: Simon Horman <horms@kernel.org>, Jamal Hadi Salim <jhs@mojatatu.com>, Jiri Pirko <jiri@resnulli.us>, 
	netdev@vger.kernel.org, eric.dumazet@gmail.com, 
	Eric Dumazet <edumazet@google.com>
Content-Type: text/plain; charset="UTF-8"
X-Rspamd-Queue-Id: EA34549C64E
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [0.84 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	MID_CONTAINS_FROM(1.00)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MV_CASE(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[google.com,reject];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c04:e001:36c::/64:c];
	R_DKIM_ALLOW(-0.20)[google.com:s=20251104];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FREEMAIL_CC(0.00)[kernel.org,mojatatu.com,resnulli.us,vger.kernel.org,gmail.com,google.com];
	RCVD_COUNT_THREE(0.00)[4];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-282608-lists,netdev=lfdr.de];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[edumazet@google.com,netdev@vger.kernel.org];
	DKIM_TRACE(0.00)[google.com:+];
	RCPT_COUNT_SEVEN(0.00)[9];
	NEURAL_HAM(-0.00)[-0.982];
	TAGGED_RCPT(0.00)[netdev];
	ASN(0.00)[asn:63949, ipnet:2600:3c04::/32, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns]

There is no point dumping qdiscs for all devices when user space
wants them for a single device:

tc -s -d qdisc show dev eth1

Signed-off-by: Eric Dumazet <edumazet@google.com>
---
 net/sched/sch_api.c | 7 +++++++
 1 file changed, 7 insertions(+)

diff --git a/net/sched/sch_api.c b/net/sched/sch_api.c
index cf3d01dd6b268741a6e4674954940e09dff139a4..dd0edc9bd4610ec865fc97a81f801a7da020667b 100644
--- a/net/sched/sch_api.c
+++ b/net/sched/sch_api.c
@@ -1884,6 +1884,7 @@ static int tc_dump_qdisc(struct sk_buff *skb, struct netlink_callback *cb)
 		unsigned long ifindex;
 		int q_idx;
 	} *ctx = (void *)cb->ctx;
+	const struct tcmsg *tcm;
 	struct net_device *dev;
 	int s_q_idx, q_idx;
 	int err;
@@ -1894,6 +1895,9 @@ static int tc_dump_qdisc(struct sk_buff *skb, struct netlink_callback *cb)
 				     rtm_tca_policy, cb->extack);
 	if (err < 0)
 		return err;
+	tcm = nlmsg_data(nlh);
+	if (tcm->tcm_ifindex && !ctx->ifindex)
+		ctx->ifindex = tcm->tcm_ifindex;
 
 	s_q_idx = ctx->q_idx;
 
@@ -1901,6 +1905,9 @@ static int tc_dump_qdisc(struct sk_buff *skb, struct netlink_callback *cb)
 		struct netdev_queue *dev_queue;
 		struct Qdisc *q;
 
+		if (tcm->tcm_ifindex && ctx->ifindex != tcm->tcm_ifindex)
+			break;
+
 		q_idx = 0;
 
 		netdev_lock_ops(dev);
-- 
2.54.0.545.g6539524ca2-goog


