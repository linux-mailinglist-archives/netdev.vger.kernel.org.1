Return-Path: <netdev+bounces-280621-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id OFgrMB+86WlJigIAu9opvQ
	(envelope-from <netdev+bounces-280621-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Thu, 23 Apr 2026 08:28:47 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 16C0F44D9E1
	for <lists+netdev@lfdr.de>; Thu, 23 Apr 2026 08:28:46 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 707463019903
	for <lists+netdev@lfdr.de>; Thu, 23 Apr 2026 06:28:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A1CAC37DE81;
	Thu, 23 Apr 2026 06:28:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="LcTRjjvU"
X-Original-To: netdev@vger.kernel.org
Received: from mail-qk1-f201.google.com (mail-qk1-f201.google.com [209.85.222.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 315B81A7264
	for <netdev@vger.kernel.org>; Thu, 23 Apr 2026 06:28:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776925724; cv=none; b=kjVAkXdZkRSGXeErARx4d7N0tP+0dkNnWp49V/GbcjO7+xg/BzjJ7DncSp2XbHY5Rtx3w2lhNSt3g7t2e6mZ7CZSjcin/4CQO5DplDTJnKQeIa8Sz/sCkNhwPxk2LHxlIU3Xv1IjPNO257V6ALJxKoh4zTgqlDlThz1/BAxVlWE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776925724; c=relaxed/simple;
	bh=TIKWurkCeViktvT6vRCxXoXGv6LQQRRCc9UHJ9Nv66Q=;
	h=Date:Mime-Version:Message-ID:Subject:From:To:Cc:Content-Type; b=OyFcnwniYF98u/E6lQSKVcPHwbdBVki6zGIhELJMWiZ+/ya2JWHTLuKJci7fNidax0M1uTiAz0/jdz54/bgPd9KPCvNT90Mj9hKrIDoocIqRcu56rvCLZfga0dTf3VSg3XUbYZH8CRYawcbFrrWKt5Pmm/gaS0qcLLgGt2OBaSk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--edumazet.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=LcTRjjvU; arc=none smtp.client-ip=209.85.222.201
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--edumazet.bounces.google.com
Received: by mail-qk1-f201.google.com with SMTP id af79cd13be357-8e8950b3ee1so1615601085a.3
        for <netdev@vger.kernel.org>; Wed, 22 Apr 2026 23:28:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1776925722; x=1777530522; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:mime-version:date:from:to:cc:subject
         :date:message-id:reply-to;
        bh=d2awcyUUlOZ7DiUll5yCRAkp5hrWVwnaXgkecEMdniQ=;
        b=LcTRjjvUmFlolRMK/sxv3m5TZYWG5Dp2F5oeRrsrj8SE6H7Ig9Zfs1eLJWsfuqM6sx
         Rorp/tq/T+1TwQVeaH0eGYrJGBGxyYqaBUI7YMfkEFlBv65aqaBn/41BaEN7O/Nm4mX4
         sr1sIgL6fBJ7KMBp2BTzsfHxp50njZhTGiHSpp2cxScF331FEzoF8EDOZYwFQF9dsk2u
         2awwFkKGqkpxV/+CMbPJZEV6yRbELYkWvQQ7q9Fzllgpn5Pr/zEajIN9Myy64wTQIVYf
         CtPvhRNtQPieIFG6By9F1OCMA4TdNAGaGeMch+AaKHfW9VjsX88LxE53d8+J2XUoEius
         b54A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1776925722; x=1777530522;
        h=cc:to:from:subject:message-id:mime-version:date:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=d2awcyUUlOZ7DiUll5yCRAkp5hrWVwnaXgkecEMdniQ=;
        b=FVybnc+ehPO8/8m3fEM4AFziKBntlthm0DTHplltxyEufC8ukq+5Q0qdhWYrNHbfgu
         iRMIeEUEsF19uTjTStKCW0xXOIgreLbyRl6s0lftmhbWsjVH0UDDEgfr306n7z8YTTN3
         IZ6N+RhCDGRh/9Ygn8PiVIVSnKG/GkTjkZFktk5xWXhlmgNfrtsH8Gs5b/KmWfDV4kgy
         q2MFaKP4C+INfCjtveixSVRn9n4suQyjHi3OVDJ7yi9cfy4fkymBdwQeGg2PpLEoLZxm
         OMmiNXhgXatnsCrIzf2Bu0Y3IRVBgAz+OO82/1ZgVyR4YDSGzj25ksh6PJlJvQSDOMsq
         x4rA==
X-Forwarded-Encrypted: i=1; AFNElJ+c0vgC7SrAeXszj9PzJOYkLRUxBYu2+FcqbPYJrdBHM0hMu6lINh6Il4pJhMV5mLg9jNW2V1c=@vger.kernel.org
X-Gm-Message-State: AOJu0YzsoMlwKSvJslaY6BuHyaFrLzAT+GmHCOopzgqkb6wyz8lDr2vM
	Kh540Vp6Ca2GfGYqsd22E2qWuZzwZHBWtBcl9a//+2wgcmAqNbVKyz6YtB790Td4REwsUm7IO3H
	8nGZgciTAqi1XjA==
X-Received: from qknrd3.prod.google.com ([2002:a05:620a:8dc3:b0:8eb:1c73:20c7])
 (user=edumazet job=prod-delivery.src-stubby-dispatcher) by
 2002:a05:620a:4089:b0:8cd:9707:630e with SMTP id af79cd13be357-8e78f82ad1amr3834388785a.19.1776925722029;
 Wed, 22 Apr 2026 23:28:42 -0700 (PDT)
Date: Thu, 23 Apr 2026 06:28:39 +0000
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
X-Mailer: git-send-email 2.54.0.rc2.544.gc7ae2d5bb8-goog
Message-ID: <20260423062839.2524324-1-edumazet@google.com>
Subject: [PATCH net] net/sched: sch_choke: annotate data-races in choke_dump_stats()
From: Eric Dumazet <edumazet@google.com>
To: "David S . Miller" <davem@davemloft.net>, Jakub Kicinski <kuba@kernel.org>, 
	Paolo Abeni <pabeni@redhat.com>
Cc: Simon Horman <horms@kernel.org>, Jamal Hadi Salim <jhs@mojatatu.com>, Jiri Pirko <jiri@resnulli.us>, 
	netdev@vger.kernel.org, eric.dumazet@gmail.com, 
	Eric Dumazet <edumazet@google.com>
Content-Type: text/plain; charset="UTF-8"
X-Spamd-Result: default: False [0.84 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	MID_CONTAINS_FROM(1.00)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MV_CASE(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[google.com,reject];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64];
	R_DKIM_ALLOW(-0.20)[google.com:s=20251104];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FREEMAIL_CC(0.00)[kernel.org,mojatatu.com,resnulli.us,vger.kernel.org,gmail.com,google.com];
	RCVD_COUNT_THREE(0.00)[4];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-280621-lists,netdev=lfdr.de];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[edumazet@google.com,netdev@vger.kernel.org];
	DKIM_TRACE(0.00)[google.com:+];
	RCPT_COUNT_SEVEN(0.00)[9];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[netdev];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: 16C0F44D9E1
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

choke_dump_stats() only runs with RTNL held.
It reads fields that can be changed in qdisc fast path.
Add READ_ONCE()/WRITE_ONCE() annotations.

Fixes: edb09eb17ed8 ("net: sched: do not acquire qdisc spinlock in qdisc/class stats dump")
Signed-off-by: Eric Dumazet <edumazet@google.com>
Reviewed-by: Jamal Hadi Salim <jhs@mojatatu.com>
---
 net/sched/sch_choke.c | 26 ++++++++++++++++----------
 1 file changed, 16 insertions(+), 10 deletions(-)

diff --git a/net/sched/sch_choke.c b/net/sched/sch_choke.c
index 94df8e741a979191a06885ad3ee813f12650ff3c..2875bcdb18a413075c795665e95f9dbbaac45962 100644
--- a/net/sched/sch_choke.c
+++ b/net/sched/sch_choke.c
@@ -229,7 +229,7 @@ static int choke_enqueue(struct sk_buff *skb, struct Qdisc *sch,
 
 		/* Draw a packet at random from queue and compare flow */
 		if (choke_match_random(q, skb, &idx)) {
-			q->stats.matched++;
+			WRITE_ONCE(q->stats.matched, q->stats.matched + 1);
 			choke_drop_by_idx(sch, idx, to_free);
 			goto congestion_drop;
 		}
@@ -241,11 +241,13 @@ static int choke_enqueue(struct sk_buff *skb, struct Qdisc *sch,
 			qdisc_qstats_overlimit(sch);
 			if (use_harddrop(q) || !use_ecn(q) ||
 			    !INET_ECN_set_ce(skb)) {
-				q->stats.forced_drop++;
+				WRITE_ONCE(q->stats.forced_drop,
+					   q->stats.forced_drop + 1);
 				goto congestion_drop;
 			}
 
-			q->stats.forced_mark++;
+			WRITE_ONCE(q->stats.forced_mark,
+				   q->stats.forced_mark + 1);
 		} else if (++q->vars.qcount) {
 			if (red_mark_probability(p, &q->vars, q->vars.qavg)) {
 				q->vars.qcount = 0;
@@ -253,11 +255,13 @@ static int choke_enqueue(struct sk_buff *skb, struct Qdisc *sch,
 
 				qdisc_qstats_overlimit(sch);
 				if (!use_ecn(q) || !INET_ECN_set_ce(skb)) {
-					q->stats.prob_drop++;
+					WRITE_ONCE(q->stats.prob_drop,
+					           q->stats.prob_drop + 1);
 					goto congestion_drop;
 				}
 
-				q->stats.prob_mark++;
+				WRITE_ONCE(q->stats.prob_mark,
+					   q->stats.prob_mark + 1);
 			}
 		} else
 			q->vars.qR = red_random(p);
@@ -272,7 +276,7 @@ static int choke_enqueue(struct sk_buff *skb, struct Qdisc *sch,
 		return NET_XMIT_SUCCESS;
 	}
 
-	q->stats.pdrop++;
+	WRITE_ONCE(q->stats.pdrop, q->stats.pdrop + 1);
 	return qdisc_drop(skb, sch, to_free);
 
 congestion_drop:
@@ -461,10 +465,12 @@ static int choke_dump_stats(struct Qdisc *sch, struct gnet_dump *d)
 {
 	struct choke_sched_data *q = qdisc_priv(sch);
 	struct tc_choke_xstats st = {
-		.early	= q->stats.prob_drop + q->stats.forced_drop,
-		.marked	= q->stats.prob_mark + q->stats.forced_mark,
-		.pdrop	= q->stats.pdrop,
-		.matched = q->stats.matched,
+		.early	= READ_ONCE(q->stats.prob_drop) +
+			  READ_ONCE(q->stats.forced_drop),
+		.marked	= READ_ONCE(q->stats.prob_mark) +
+			  READ_ONCE(q->stats.forced_mark),
+		.pdrop	= READ_ONCE(q->stats.pdrop),
+		.matched = READ_ONCE(q->stats.matched),
 	};
 
 	return gnet_stats_copy_app(d, &st, sizeof(st));
-- 
2.54.0.rc2.544.gc7ae2d5bb8-goog


