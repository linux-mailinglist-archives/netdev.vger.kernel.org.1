Return-Path: <netdev+bounces-282013-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id YLT8Fkjq8Gn2awEAu9opvQ
	(envelope-from <netdev+bounces-282013-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Tue, 28 Apr 2026 19:11:36 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id B718E489AC0
	for <lists+netdev@lfdr.de>; Tue, 28 Apr 2026 19:11:35 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id ECDF73044810
	for <lists+netdev@lfdr.de>; Tue, 28 Apr 2026 17:06:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 82FB633AD9D;
	Tue, 28 Apr 2026 17:06:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="v9qEbz1Z"
X-Original-To: netdev@vger.kernel.org
Received: from mail-qv1-f73.google.com (mail-qv1-f73.google.com [209.85.219.73])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 284262D73A6
	for <netdev@vger.kernel.org>; Tue, 28 Apr 2026 17:06:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.73
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777395979; cv=none; b=XO9jICZyGtNE4MEEqf4En2HAqnAiNHG8esiFqzr1LBUnTpF9AsJ0c+arXGRJ6wFUySHOtG102Q+K0RFjSFsKiUXoU/KHPPLpc9ZYvv18l1Oe5a8SJF1me+eH6NQ6w/fDJ7PxNQ10mPePKiQi6ZlWJbkK+vdFukR4hgoOUD/wi+c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777395979; c=relaxed/simple;
	bh=CFMy6HyyTVAnjI4i+ocHbnkW6tJx4Pakyoj0eEMJfSY=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=SbOFpltq9yOyTQoHV/zGS/Py8Rvvtr++lowpcXE6Ys0GjG1Hhn68kkiOUfATP/iqgOWQS/5m/FIZOMHYi3bXMN4Hok2TeRH3+A8PZYt2OCFwW80XS6/J90dojJgIlCVKpDwboqDZj+5WOwPLd7shWRWZiQG1laG4vblBIhinmFg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--edumazet.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=v9qEbz1Z; arc=none smtp.client-ip=209.85.219.73
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--edumazet.bounces.google.com
Received: by mail-qv1-f73.google.com with SMTP id 6a1803df08f44-8aca14d1faaso96471506d6.3
        for <netdev@vger.kernel.org>; Tue, 28 Apr 2026 10:06:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1777395977; x=1778000777; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=L7bFKNxN8MC3qE6vGhSgi0Khm0EeMo+n1gm5R184X1I=;
        b=v9qEbz1Z915KWLGJX/5RkX/9E6JSRCL4HvDKctEn7R/+yn6xBB4owRk6KcLiNNogub
         7Zjjz48PhHdfMrp87eX3dOIhdBganGmfV+79Knm7JtzrvJbMQV+YunU4Dkigv5HxSrZp
         VxGMVEihZikF1yPUn0fcFKhSN/FVlxl+NAsaIkS8UXZdIDXKpz7upyjoSMLlzK5kYRU8
         Zw8/h5YJ5QZa+L8SBYSs6N73sPl8v8QyfxvGp0h90FwhznnZWUfVH9taNgkHJ4+BemTs
         49AVaTyJ3h1pG/OL+yB90cn1SEsfcsMYqZr3jhiluHmguP/Y8CkT6VwtTqWX6bet0sZY
         +BWg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1777395977; x=1778000777;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=L7bFKNxN8MC3qE6vGhSgi0Khm0EeMo+n1gm5R184X1I=;
        b=Rb6QNfX7j7+QLwe/nIYPzO5180KsVK8jvXxeX3wqR7lABACQFH4eRIjHeb1kERpoBd
         f9aTAPaUMlbWHPLfd6drgjnpu/ZV4ZpFY9ElkXznd1e45mo8/N/Jyv7HAir7ksLQwXIB
         3FC3DGD0jXILNtARQijYzRnveD/pjKeN56dHn2dI9rz8hesUZGOJRbtquUqkxEq3qjTl
         Q71NVCaiZfBTgSC/FBQQYJWaf4LjFOEzU9vG7ArqueMtf448K7ZRC51JcAyeBcgy/P/x
         I3A7gSk+m/JFhoHLsk5KFUuTP48Js/LJKx0d7KkdpQiQtKFzDrE0LFmj/ICT4Dzkm1nT
         G1Tg==
X-Forwarded-Encrypted: i=1; AFNElJ872Y613ffqvO9YNQRndDNkcV9xsAzTinbjoergVBOARbHWbm6s5CfCUl1JWfjaqJI4GtuQyp4=@vger.kernel.org
X-Gm-Message-State: AOJu0YwZRVlNVXTwfEashkgFV14jug6nNTiwSDo2z4BWB7LN9GbZKlGm
	Inz2Y+3XhYYGxVNUeEMYJOoJuB/fHyzfeYff6ZXdh1ay4yJw8MckxzQE16SH6OTmemcqiEdOKxr
	o8Z/ySl9vaQhUjA==
X-Received: from qvbpt9.prod.google.com ([2002:a05:6214:489:b0:89c:6104:2e8f])
 (user=edumazet job=prod-delivery.src-stubby-dispatcher) by
 2002:a05:6214:410a:b0:899:fd80:f79f with SMTP id 6a1803df08f44-8b3e3061c6emr62925886d6.23.1777395976611;
 Tue, 28 Apr 2026 10:06:16 -0700 (PDT)
Date: Tue, 28 Apr 2026 17:04:14 +0000
In-Reply-To: <20260428170414.250566-1-edumazet@google.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20260428170414.250566-1-edumazet@google.com>
X-Mailer: git-send-email 2.54.0.545.g6539524ca2-goog
Message-ID: <20260428170414.250566-5-edumazet@google.com>
Subject: [PATCH v2 net-next 4/4] net/sched: speedup tc_dump_qdisc() when
 tcm_ifindex is provided
From: Eric Dumazet <edumazet@google.com>
To: "David S . Miller" <davem@davemloft.net>, Jakub Kicinski <kuba@kernel.org>, 
	Paolo Abeni <pabeni@redhat.com>
Cc: Simon Horman <horms@kernel.org>, Jamal Hadi Salim <jhs@mojatatu.com>, Jiri Pirko <jiri@resnulli.us>, 
	netdev@vger.kernel.org, eric.dumazet@gmail.com, 
	Eric Dumazet <edumazet@google.com>
Content-Type: text/plain; charset="UTF-8"
X-Rspamd-Queue-Id: B718E489AC0
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [0.84 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	MID_CONTAINS_FROM(1.00)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MV_CASE(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[google.com,reject];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	R_DKIM_ALLOW(-0.20)[google.com:s=20251104];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FREEMAIL_CC(0.00)[kernel.org,mojatatu.com,resnulli.us,vger.kernel.org,gmail.com,google.com];
	RCVD_COUNT_THREE(0.00)[4];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-282013-lists,netdev=lfdr.de];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[edumazet@google.com,netdev@vger.kernel.org];
	DKIM_TRACE(0.00)[google.com:+];
	RCPT_COUNT_SEVEN(0.00)[9];
	NEURAL_HAM(-0.00)[-0.982];
	TAGGED_RCPT(0.00)[netdev];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns]

There is no point dumping qdiscs for all devices when user space
wants them for a single device:

tc -s -d qdisc show dev eth1

Signed-off-by: Eric Dumazet <edumazet@google.com>
---
 net/sched/sch_api.c | 7 +++++++
 1 file changed, 7 insertions(+)

diff --git a/net/sched/sch_api.c b/net/sched/sch_api.c
index 641f5a01aca167dd230173078f2db5801dca58da..80827ef8f4f6b0b27391da7c866f5da15f830b2d 100644
--- a/net/sched/sch_api.c
+++ b/net/sched/sch_api.c
@@ -1885,6 +1885,7 @@ static int tc_dump_qdisc(struct sk_buff *skb, struct netlink_callback *cb)
 		int q_idx;
 	} *ctx = (void *)cb->ctx;
 	unsigned long s_ifindex;
+	const struct tcmsg *tcm;
 	struct net_device *dev;
 	int s_q_idx, q_idx;
 	int err;
@@ -1895,6 +1896,9 @@ static int tc_dump_qdisc(struct sk_buff *skb, struct netlink_callback *cb)
 				     rtm_tca_policy, cb->extack);
 	if (err < 0)
 		return err;
+	tcm = nlmsg_data(nlh);
+	if (tcm->tcm_ifindex && !ctx->ifindex)
+		ctx->ifindex = tcm->tcm_ifindex;
 
 	s_ifindex = ctx->ifindex;
 	s_q_idx = ctx->q_idx;
@@ -1903,6 +1907,9 @@ static int tc_dump_qdisc(struct sk_buff *skb, struct netlink_callback *cb)
 		struct netdev_queue *dev_queue;
 		struct Qdisc *q;
 
+		if (tcm->tcm_ifindex && ctx->ifindex != tcm->tcm_ifindex)
+			break;
+
 		q_idx = 0;
 
 		netdev_lock_ops(dev);
-- 
2.54.0.545.g6539524ca2-goog


