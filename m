Return-Path: <netdev+bounces-287472-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id SA8/FCcyBGqNFQIAu9opvQ
	(envelope-from <netdev+bounces-287472-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Wed, 13 May 2026 10:11:19 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id C357852F5D4
	for <lists+netdev@lfdr.de>; Wed, 13 May 2026 10:11:18 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id A2EF630DB727
	for <lists+netdev@lfdr.de>; Wed, 13 May 2026 08:09:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0A63D3955DA;
	Wed, 13 May 2026 08:09:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="orKzjw1H"
X-Original-To: netdev@vger.kernel.org
Received: from mail-qt1-f201.google.com (mail-qt1-f201.google.com [209.85.160.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 98BF137AA70
	for <netdev@vger.kernel.org>; Wed, 13 May 2026 08:08:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778659740; cv=none; b=jzbdBPLNWYIfop71tAgMtGYcTXL76T/7DkgXfMeco9D9muNV6DBtd/yACvGRTGMoIe5gOFWgnL75XYB950rPkGS3eQ6q5lw/K6Yv4LvlNE/evUIfTEYj1PpJORjLDK9cGWk//CCYl6y2+3CEv13xKP3DBHjMu1cdOKQxIquPHhk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778659740; c=relaxed/simple;
	bh=W67i19YjvQ8hPAiQg18DDvFPs03ZdG7R8U59vdG1FmI=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=nPmEdSKW6mlNqFd9jlP0XVzSJSMJidyHzsWzzSbDxCN7Uy133gtc8rk8qbQGu/PsyD4rzYit3bYwfWs8WFubJ8igAi+70nkzb1lbACWrOqj/W7dqELL8aYPaNE7TXd/YcWpNQiIQ7957Kl6MsoSDH5HDrHOLd5WpSXMvjdod6T4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--edumazet.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=orKzjw1H; arc=none smtp.client-ip=209.85.160.201
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--edumazet.bounces.google.com
Received: by mail-qt1-f201.google.com with SMTP id d75a77b69052e-514b673c8f1so32852251cf.3
        for <netdev@vger.kernel.org>; Wed, 13 May 2026 01:08:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1778659738; x=1779264538; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=irFdHHl5JzyaZP3X1AQlOj29/CqvI7JqysnCPLhjIZw=;
        b=orKzjw1HXIxIiZZ67BXos07Gye30KzpOAuvoDx3ZGnYRzQpgF5Q83lNTAhrAiCHcpv
         jacC0z+bdtW7eUjuT0CUrCNa01P3Hfj4vdbbHZLtM6UNy2mEleNaXlKhBtNWbVHmFnBo
         V3A8mluZs1/h+GTPvI9faMnkIaK9fyXdSuq8QNC+s9CDvh5v70QIx7j5SejpxrfhAXQ5
         8uuxReaj4WWza8L74EhgRQuGjSlP9LkCB34Dk6eDjdUrBS0RS5zjkzCz1lQISKP7Fhl3
         SitzXx3Kp8jE/pgHGAqb8GQF2vLLcy9mRjx9QByBDfd+VgaMwKbT2w/X3IvJfMaAODfQ
         oMvw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1778659738; x=1779264538;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=irFdHHl5JzyaZP3X1AQlOj29/CqvI7JqysnCPLhjIZw=;
        b=UFtDApZybKfrUiCoiZ60umH/TkLKkhrQ0i2kBMHKBih+GsjUkvQ6K8sCpoEc6X1own
         Ny5Wejc3reyW4pLyBUByIHgC/9TXtD5MlWd31yOR2bz2Zx0LSegtA/MX5Zts7IfTP7EK
         CvO9h6WIN0IW8eVpptR6j9Y6fziY+U+LueznNGxSXCFYTy4QmiGBceJUUoR9MICR/Css
         ZY3KI8NFMHuR/Q9GFND9N3P1HSW1FtGLPLlVXwKufSAOatG6Yn89+QAlc+oqWcCS9ddW
         W6AJSd+C9lUEMEVA0VcU4QlA39tRgovL1pY9/c78RgVWZiJzInc+37nLQdfdZ2fyeB9r
         mwKA==
X-Forwarded-Encrypted: i=1; AFNElJ9rImWxe4oYA3Z1qI2gbRtRHXjk7m9m9MRWCnlwDsuQIzrxPJYbclds3XYovYpOSta31wRBzkg=@vger.kernel.org
X-Gm-Message-State: AOJu0Yz3BxnU2SRM9TCF2rp7d+tf9S9fdk+pkq5ormfeQp4pXeVl8Sgz
	k/WB0NVcARq8qQKF4thqCdUowOmZK7S80eD4VPG7Pyv1YHnYQmJhWhsdD9DKTzEpY1HNy2yW4fd
	qsAJewempux8d3g==
X-Received: from qvvr20.prod.google.com ([2002:a05:6214:1254:b0:8ba:6ca5:89e4])
 (user=edumazet job=prod-delivery.src-stubby-dispatcher) by
 2002:a05:622a:20a:b0:50d:e298:8f1c with SMTP id d75a77b69052e-5162f58fd56mr30030321cf.32.1778659738156;
 Wed, 13 May 2026 01:08:58 -0700 (PDT)
Date: Wed, 13 May 2026 08:08:52 +0000
In-Reply-To: <20260513080853.1383975-1-edumazet@google.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20260513080853.1383975-1-edumazet@google.com>
X-Mailer: git-send-email 2.54.0.563.g4f69b47b94-goog
Message-ID: <20260513080853.1383975-3-edumazet@google.com>
Subject: [PATCH net-next 2/3] net: ioam6: no longer acquire qdisc spinlock
 while calling qdisc_qstats_qlen_backlog()
From: Eric Dumazet <edumazet@google.com>
To: "David S . Miller" <davem@davemloft.net>, Jakub Kicinski <kuba@kernel.org>, 
	Paolo Abeni <pabeni@redhat.com>
Cc: Simon Horman <horms@kernel.org>, Jamal Hadi Salim <jhs@mojatatu.com>, 
	Victor Nogueira <victor@mojatatu.com>, Jiri Pirko <jiri@resnulli.us>, Ido Schimmel <idosch@nvidia.com>, 
	David Ahern <dsahern@kernel.org>, 
	"=?UTF-8?q?Toke=20H=C3=B8iland-J=C3=B8rgensen?=" <toke@toke.dk>, netdev@vger.kernel.org, eric.dumazet@gmail.com, 
	Eric Dumazet <edumazet@google.com>
Content-Type: text/plain; charset="UTF-8"
X-Rspamd-Queue-Id: C357852F5D4
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [0.84 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	MID_CONTAINS_FROM(1.00)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[google.com,reject];
	MV_CASE(0.50)[];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	R_DKIM_ALLOW(-0.20)[google.com:s=20251104];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-287472-lists,netdev=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[13];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[google.com:+];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[edumazet@google.com,netdev@vger.kernel.org];
	FREEMAIL_CC(0.00)[kernel.org,mojatatu.com,resnulli.us,nvidia.com,toke.dk,vger.kernel.org,gmail.com,google.com];
	NEURAL_HAM(-0.00)[-1.000];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	TAGGED_RCPT(0.00)[netdev];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns]
X-Rspamd-Action: no action

Recent changes in qdisc_qstats_qlen_backlog() and friends make it safe
to use locklessly.

Signed-off-by: Eric Dumazet <edumazet@google.com>
---
 net/ipv6/ioam6.c | 4 +---
 1 file changed, 1 insertion(+), 3 deletions(-)

diff --git a/net/ipv6/ioam6.c b/net/ipv6/ioam6.c
index e963a71858a78c0e53db31d98ab317bbf64ea2a2..943861a5581ee6e9334c29b9daf888a9d2bf1de0 100644
--- a/net/ipv6/ioam6.c
+++ b/net/ipv6/ioam6.c
@@ -800,7 +800,7 @@ static void __ioam6_fill_trace_data(struct sk_buff *skb,
 	/* queue depth */
 	if (trace->type.bit6) {
 		struct netdev_queue *queue;
-		struct Qdisc *qdisc;
+		const struct Qdisc *qdisc;
 		__u32 qlen, backlog;
 
 		if (dev->flags & IFF_LOOPBACK ||
@@ -810,9 +810,7 @@ static void __ioam6_fill_trace_data(struct sk_buff *skb,
 			queue = skb_get_tx_queue(dev, skb);
 			qdisc = rcu_dereference(queue->qdisc);
 
-			spin_lock_bh(qdisc_lock(qdisc));
 			qdisc_qstats_qlen_backlog(qdisc, &qlen, &backlog);
-			spin_unlock_bh(qdisc_lock(qdisc));
 
 			*(__be32 *)data = cpu_to_be32(backlog);
 		}
-- 
2.54.0.563.g4f69b47b94-goog


