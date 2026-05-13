Return-Path: <netdev+bounces-287473-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id GD0rOakxBGo/FAIAu9opvQ
	(envelope-from <netdev+bounces-287473-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Wed, 13 May 2026 10:09:13 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [172.232.135.74])
	by mail.lfdr.de (Postfix) with ESMTPS id C657252F596
	for <lists+netdev@lfdr.de>; Wed, 13 May 2026 10:09:08 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id A9F7D30356A4
	for <lists+netdev@lfdr.de>; Wed, 13 May 2026 08:09:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5A38F3955E8;
	Wed, 13 May 2026 08:09:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="MYmoIjCx"
X-Original-To: netdev@vger.kernel.org
Received: from mail-qk1-f201.google.com (mail-qk1-f201.google.com [209.85.222.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E1AB3379C2C
	for <netdev@vger.kernel.org>; Wed, 13 May 2026 08:09:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778659742; cv=none; b=iyeYM7J8wPDbN/gWLOGN24eeQyKVcsIedeOw4Z6t6mJBVnStWZRMu5lxwEFfQzTs5SyMQ+mhS5inUmI+7wU17DTjvCSTq4PBXk2jJiDxMfoghkkiMikMkBwS+OXUW0MEOqeDVFCMYfgnKSSXh/blBE06s9vOm7bSFHI8TjxYcC8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778659742; c=relaxed/simple;
	bh=COzqRahbVb3s1ie38TQGlT2+DIxqg+wUz/FMUJJSjsY=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=HpQejVnktBYIXzwozuOXNMsmnmFJxdQ2NvJRigXxIcUqSzZSjQghUeRGxfJvz1wc6HKv6ReCVNpS5VJLVL7AcIoF7y/yqV+XllcLoA2tcn8EFjaGK0eHhGFxQyGggVBVo35ZyM763StjYtISSwC2INcnykDUsO2lWU8WqdHNWCg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--edumazet.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=MYmoIjCx; arc=none smtp.client-ip=209.85.222.201
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--edumazet.bounces.google.com
Received: by mail-qk1-f201.google.com with SMTP id af79cd13be357-910469891f6so760685a.2
        for <netdev@vger.kernel.org>; Wed, 13 May 2026 01:09:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1778659740; x=1779264540; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=vTw+qpgNEup6BR14/e2C7w3iK85rKD3avntbdZd/Bd4=;
        b=MYmoIjCxSe5d+53+GHCRuve7q3K+ofwYFcTzLRZCz6s7GIrnHO6aQR4a0/gO8hO4Hy
         xbKn1/328Ghl8t2Ni2e8/4Q9SLasCOEj20pH9okr6zxtBvLHXyiwdURa9x+F3R1CQ/7u
         YLrPmXPG6/i2eIZ2825jZ21ff60QEsTStI7Fk5v+mG3iybr6DIlMIkfXT/5MAoSw+H15
         vOFAuaVWtmxGuxEk3+K6AF5zcd/OwdLiR9hDw7xNiWximhO4zsDd20w3/sF9RnFH2AIv
         rk41KmHGLEb77dzUSmzyruZgNelAsULwOlak17hqeCiC4mo7VXj41+2XzMyGduuj86Jz
         HRKQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1778659740; x=1779264540;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=vTw+qpgNEup6BR14/e2C7w3iK85rKD3avntbdZd/Bd4=;
        b=KxW1BzCqrDWNplRt3t0ecp/e+eShnvGNf8aqpA3Oaw4T0pYKzEemg57nImKbYPG+LI
         /1UZ04CIvvJ49uQQR0HBcbbdzJHT6idNx2d9GuU1CkfpSbdQ9dVo6vt9/cBlmgrmIG4v
         /Gx4tPeSZe8lzCzpd1QEdEYP/j/u3/sAqst6VvoLj5nIGV/6gKYttDmjtQTeTlhM5f/3
         cm8bb0Gjl96iQhjCUjHzCus1JYnOdePH3v5heGdpe5ERmpJ75rgJQEl8GEvhjLvRiP53
         8YEvXxNoUN+uOnWVsF6ta2staXLN5LFNM0eb6i4p/27h+YnE41SVUOymhWyv51FmywCA
         jpNQ==
X-Forwarded-Encrypted: i=1; AFNElJ8OOwbdSjsN7l5hp/HfDPoK2iBkn6wNJKQSNZzuYHfuuuZrjYkYJ3B9tQLoP0wZRtAi0xHs/Nk=@vger.kernel.org
X-Gm-Message-State: AOJu0Yyhq1QRSzHYOXAz/YBliEZmNi/BJfwSDgkgtVeUl8ZvfjytLXCX
	IW6L22SPs0IQt7L0zjZ89EjT884cAGvB3D0Lcuuw/VZleGxPLdKvZ+jtFe1EFalVluuhkfCdX/p
	7YLgnQUgZGSfMLg==
X-Received: from qkbee10.prod.google.com ([2002:a05:620a:800a:b0:8cb:d089:6a15])
 (user=edumazet job=prod-delivery.src-stubby-dispatcher) by
 2002:a05:620a:172b:b0:90b:9dca:2199 with SMTP id af79cd13be357-90fab031557mr287470885a.6.1778659739718;
 Wed, 13 May 2026 01:08:59 -0700 (PDT)
Date: Wed, 13 May 2026 08:08:53 +0000
In-Reply-To: <20260513080853.1383975-1-edumazet@google.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20260513080853.1383975-1-edumazet@google.com>
X-Mailer: git-send-email 2.54.0.563.g4f69b47b94-goog
Message-ID: <20260513080853.1383975-4-edumazet@google.com>
Subject: [PATCH net-next 3/3] net/sched: sch_hfsc: annotate data-races in hfsc_dump_class_stats()
From: Eric Dumazet <edumazet@google.com>
To: "David S . Miller" <davem@davemloft.net>, Jakub Kicinski <kuba@kernel.org>, 
	Paolo Abeni <pabeni@redhat.com>
Cc: Simon Horman <horms@kernel.org>, Jamal Hadi Salim <jhs@mojatatu.com>, 
	Victor Nogueira <victor@mojatatu.com>, Jiri Pirko <jiri@resnulli.us>, Ido Schimmel <idosch@nvidia.com>, 
	David Ahern <dsahern@kernel.org>, 
	"=?UTF-8?q?Toke=20H=C3=B8iland-J=C3=B8rgensen?=" <toke@toke.dk>, netdev@vger.kernel.org, eric.dumazet@gmail.com, 
	Eric Dumazet <edumazet@google.com>
Content-Type: text/plain; charset="UTF-8"
X-Rspamd-Queue-Id: C657252F596
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [0.84 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_CONTAINS_FROM(1.00)[];
	DMARC_POLICY_ALLOW(-0.50)[google.com,reject];
	MV_CASE(0.50)[];
	R_SPF_ALLOW(-0.20)[+ip4:172.232.135.74:c];
	R_DKIM_ALLOW(-0.20)[google.com:s=20251104];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FROM_HAS_DN(0.00)[];
	TAGGED_FROM(0.00)[bounces-287473-lists,netdev=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[13];
	FREEMAIL_CC(0.00)[kernel.org,mojatatu.com,resnulli.us,nvidia.com,toke.dk,vger.kernel.org,gmail.com,google.com];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[edumazet@google.com,netdev@vger.kernel.org];
	DKIM_TRACE(0.00)[google.com:+];
	SEM_URIBL_FRESH15_UNKNOWN_FAIL(0.00)[xstats.work:query timed out];
	TAGGED_RCPT(0.00)[netdev];
	NEURAL_HAM(-0.00)[-1.000];
	ASN(0.00)[asn:63949, ipnet:172.232.128.0/19, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sto.lore.kernel.org:helo,sto.lore.kernel.org:rdns]
X-Rspamd-Action: no action

hfsc_dump_class_stats() runs without qdisc spinlock being held.

Add READ_ONCE()/WRITE_ONCE() annotations around:

- cl->level
- cl->cl_vtperiod
- cl->cl_total
- cl->cl_cumul

Fixes: edb09eb17ed8 ("net: sched: do not acquire qdisc spinlock in qdisc/class stats dump")
Signed-off-by: Eric Dumazet <edumazet@google.com>
---
 net/sched/sch_hfsc.c | 22 +++++++++++-----------
 1 file changed, 11 insertions(+), 11 deletions(-)

diff --git a/net/sched/sch_hfsc.c b/net/sched/sch_hfsc.c
index 59409ee2d2ff9279d7439b744030c0e845386de0..c06d2761a1fb9dbc711b18d61cfa8c28a7de0bd8 100644
--- a/net/sched/sch_hfsc.c
+++ b/net/sched/sch_hfsc.c
@@ -715,7 +715,7 @@ init_vf(struct hfsc_class *cl, unsigned int len)
 			rtsc_min(&cl->cl_virtual, &cl->cl_fsc, cl->cl_vt, cl->cl_total);
 			cl->cl_vtadj = 0;
 
-			cl->cl_vtperiod++;  /* increment vt period */
+			WRITE_ONCE(cl->cl_vtperiod, cl->cl_vtperiod + 1);  /* increment vt period */
 			cl->cl_parentperiod = cl->cl_parent->cl_vtperiod;
 			if (cl->cl_parent->cl_nactive == 0)
 				cl->cl_parentperiod++;
@@ -757,7 +757,7 @@ update_vf(struct hfsc_class *cl, unsigned int len, u64 cur_time)
 		go_passive = 1;
 
 	for (; cl->cl_parent != NULL; cl = cl->cl_parent) {
-		cl->cl_total += len;
+		WRITE_ONCE(cl->cl_total, cl->cl_total + len);
 
 		if (!(cl->cl_flags & HFSC_FSC) || cl->cl_nactive == 0)
 			continue;
@@ -847,7 +847,7 @@ hfsc_adjust_levels(struct hfsc_class *cl)
 			if (p->level >= level)
 				level = p->level + 1;
 		}
-		cl->level = level;
+		WRITE_ONCE(cl->level, level);
 	} while ((cl = cl->cl_parent) != NULL);
 }
 
@@ -1338,10 +1338,10 @@ hfsc_dump_class_stats(struct Qdisc *sch, unsigned long arg,
 	__u32 qlen;
 
 	qdisc_qstats_qlen_backlog(cl->qdisc, &qlen, &cl->qstats.backlog);
-	xstats.level   = cl->level;
-	xstats.period  = cl->cl_vtperiod;
-	xstats.work    = cl->cl_total;
-	xstats.rtwork  = cl->cl_cumul;
+	xstats.level   = READ_ONCE(cl->level);
+	xstats.period  = READ_ONCE(cl->cl_vtperiod);
+	xstats.work    = READ_ONCE(cl->cl_total);
+	xstats.rtwork  = READ_ONCE(cl->cl_cumul);
 
 	if (gnet_stats_copy_basic(d, NULL, &cl->bstats, true) < 0 ||
 	    gnet_stats_copy_rate_est(d, &cl->rate_est) < 0 ||
@@ -1452,15 +1452,15 @@ hfsc_change_qdisc(struct Qdisc *sch, struct nlattr *opt,
 static void
 hfsc_reset_class(struct hfsc_class *cl)
 {
-	cl->cl_total        = 0;
-	cl->cl_cumul        = 0;
+	WRITE_ONCE(cl->cl_total, 0);
+	WRITE_ONCE(cl->cl_cumul, 0);
 	cl->cl_d            = 0;
 	cl->cl_e            = 0;
 	cl->cl_vt           = 0;
 	cl->cl_vtadj        = 0;
 	cl->cl_cvtmin       = 0;
 	cl->cl_cvtoff       = 0;
-	cl->cl_vtperiod     = 0;
+	WRITE_ONCE(cl->cl_vtperiod, 0);
 	cl->cl_parentperiod = 0;
 	cl->cl_f            = 0;
 	cl->cl_myf          = 0;
@@ -1626,7 +1626,7 @@ hfsc_dequeue(struct Qdisc *sch)
 	bstats_update(&cl->bstats, skb);
 	update_vf(cl, qdisc_pkt_len(skb), cur_time);
 	if (realtime)
-		cl->cl_cumul += qdisc_pkt_len(skb);
+		WRITE_ONCE(cl->cl_cumul, cl->cl_cumul + qdisc_pkt_len(skb));
 
 	if (cl->cl_flags & HFSC_RSC) {
 		if (cl->qdisc->q.qlen != 0) {
-- 
2.54.0.563.g4f69b47b94-goog


