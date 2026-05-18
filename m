Return-Path: <netdev+bounces-288944-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id EI/nI9nXCmqc8gQAu9opvQ
	(envelope-from <netdev+bounces-288944-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Mon, 18 May 2026 11:11:53 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id EE71F569697
	for <lists+netdev@lfdr.de>; Mon, 18 May 2026 11:11:52 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id EFC4D30379B5
	for <lists+netdev@lfdr.de>; Mon, 18 May 2026 09:05:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D02353E4C9D;
	Mon, 18 May 2026 09:05:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="t7ViEXAd"
X-Original-To: netdev@vger.kernel.org
Received: from mail-qk1-f201.google.com (mail-qk1-f201.google.com [209.85.222.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 333ED3E4C80
	for <netdev@vger.kernel.org>; Mon, 18 May 2026 09:05:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779095122; cv=none; b=lBlYGdusw/TIIj7okIECdYcK8rfaq8EGLqaNw767m/35KphbYhmOaCGC/3yeinV+R5L44eJXORYw44XOhfIZigjbj9ydDohvxeDzs/y9pIDdin++dA7wau42NAz3ZQ5Hl2nUqp6R1WPD6hVJT9u9tH6QmdqPA+90+lbxIM37mYQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779095122; c=relaxed/simple;
	bh=fwAu8h03Rocz1H1sKQq7KpBIY+HRAIy1usLgxYgojGc=;
	h=Date:Mime-Version:Message-ID:Subject:From:To:Cc:Content-Type; b=nvC7zSfpdsnzxRqlW8mvG7hzHrAjii8q8jDuZUOru4RUPlPA/1qLy/IA8AZeM/QQAqGX0K5vj93T+NlEE2DT4L5CkB9X+VqVGA1EOPbU1X+g2K8o5bGRB+YiK4AZgzPov/TuM1ClvfDqzwOAVJpI1p5Lu0nSFBqZiRiEVanBRWU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--edumazet.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=t7ViEXAd; arc=none smtp.client-ip=209.85.222.201
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--edumazet.bounces.google.com
Received: by mail-qk1-f201.google.com with SMTP id af79cd13be357-90f03c426e7so360463685a.0
        for <netdev@vger.kernel.org>; Mon, 18 May 2026 02:05:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1779095120; x=1779699920; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:mime-version:date:from:to:cc:subject
         :date:message-id:reply-to;
        bh=UjWgmV3hq9V0Tl2MHTjAbAptzddCOf4e8Kblv8uH7iA=;
        b=t7ViEXAdIPBwRDTJ66XgIMESZlqEzsFgu9qG5RF4FBWD8qdVIsMe6nrk5pB+kAyJ+x
         nrMwmKfh6OUeWUj4Spvbw7j6QjktJmXP4DqGvEmN02klYLtl5Lw2/XPCADmIleB2WyZG
         HOrLVh3Wneh3/BMIOxjOjmdrk6XUDTg4TEhNdn/PbMzfF0s0hYmrA+KvLu5rqpptvVhw
         32Z1dJO9S+Fq2sTu/c5ntXu3mq6ITOcS1fyAudvN4mkq53Zx/Uu6J5EMLg81z2TVapbh
         YVdKdBjFt9971pUl31FmE03enLKkuGH5WjebEyyf1cZY1dSeY+n2OzV4BGnApEfHSRkM
         82gg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1779095120; x=1779699920;
        h=cc:to:from:subject:message-id:mime-version:date:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=UjWgmV3hq9V0Tl2MHTjAbAptzddCOf4e8Kblv8uH7iA=;
        b=lQf9ZgNSvlB0TYMsz5nSrsdK49FViPdoiWGL5BvAfWF6CNkLYfS+anRIkFE/Tk6Q+B
         Bv2o8t/sXOa8zBdgsRLzXlMtRdAFyhPP/4oRtr5YLioN5w3Hbpnshn1wczUsY5OrRzJr
         HoU8sRN+dJmGUqvy2hfNWmSZXJOANSzXsaT7DjogutlKQr1UQmGIcEEnajNrXMxI675l
         E2wDuyGzzU9SojN97nDc1Fu9bjwta0/X1DJ0BfxV0//QHN/NsBrDibKtoIYNa5uIvDnz
         vNCwCo9VhvgdngjwdNBhRWp/0zOzi0Q2yo+J0Zg2mPgKNHf4mImzxT2nMDLFeG68m1gn
         nu1w==
X-Forwarded-Encrypted: i=1; AFNElJ9rl2vz0PEKgHWrwZSZj9/FQkB+KB7eIeWxgmG/90h1Sy+GwOL0f4CuBuRkFkcGBaF7coWprSY=@vger.kernel.org
X-Gm-Message-State: AOJu0YyFPZ5MnsalJR1XAOGtnlCcyJq8sgeSJml3IpiJScbJYhQD3Zu6
	Llvplsdz0zsLC9iYZDpZLtdDblGF0FjHxO9+Is7cKKm0IB1bmVNkdj4ygu8wxx+HbIJwup/V8nR
	kF2goalP+OOJY7A==
X-Received: from qknsn1.prod.google.com ([2002:a05:620a:9481:b0:911:4d08:b62d])
 (user=edumazet job=prod-delivery.src-stubby-dispatcher) by
 2002:a05:620a:2890:b0:910:c78d:12ef with SMTP id af79cd13be357-911cf3f7626mr2132178885a.38.1779095119288;
 Mon, 18 May 2026 02:05:19 -0700 (PDT)
Date: Mon, 18 May 2026 09:05:18 +0000
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
X-Mailer: git-send-email 2.54.0.563.g4f69b47b94-goog
Message-ID: <20260518090518.629245-1-edumazet@google.com>
Subject: [PATCH net-next] net/sched: sch_htb: fix htb_dump_class_stats() vs
 offload mode
From: Eric Dumazet <edumazet@google.com>
To: "David S . Miller" <davem@davemloft.net>, Jakub Kicinski <kuba@kernel.org>, 
	Paolo Abeni <pabeni@redhat.com>
Cc: Simon Horman <horms@kernel.org>, Jamal Hadi Salim <jhs@mojatatu.com>, 
	Victor Nogueira <victor@mojatatu.com>, Jiri Pirko <jiri@resnulli.us>, netdev@vger.kernel.org, 
	eric.dumazet@gmail.com, Eric Dumazet <edumazet@google.com>, 
	Maxim Mikityanskiy <maximmi@mellanox.com>, Tariq Toukan <tariqt@nvidia.com>
Content-Type: text/plain; charset="UTF-8"
X-Rspamd-Queue-Id: EE71F569697
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [0.84 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	MID_CONTAINS_FROM(1.00)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[google.com,reject];
	MV_CASE(0.50)[];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	R_DKIM_ALLOW(-0.20)[google.com:s=20251104];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-288944-lists,netdev=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[12];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[google.com:+];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[edumazet@google.com,netdev@vger.kernel.org];
	FREEMAIL_CC(0.00)[kernel.org,mojatatu.com,resnulli.us,vger.kernel.org,gmail.com,google.com,mellanox.com,nvidia.com];
	NEURAL_HAM(-0.00)[-1.000];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	TAGGED_RCPT(0.00)[netdev];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,nvidia.com:email,mellanox.com:email]
X-Rspamd-Action: no action

htb_dump_class_stats() and htb_offload_aggregate_stats()
call gnet_stats_basic_sync_init(&cl->bstats) which
is wrong on 32bit arches when syncp is cleared.

Make sure to acquire qdisc spinlock and use
_bstats_set() to ease future lockless dumps.

Fixes: 83271586249c ("sch_htb: Stats for offloaded HTB")
Signed-off-by: Eric Dumazet <edumazet@google.com>
Cc: Maxim Mikityanskiy <maximmi@mellanox.com>
Cc: Tariq Toukan <tariqt@nvidia.com>
---
 net/sched/sch_htb.c | 22 ++++++++++++----------
 1 file changed, 12 insertions(+), 10 deletions(-)

diff --git a/net/sched/sch_htb.c b/net/sched/sch_htb.c
index d8ef3efbe0d5eab42c535e48d95d9005ac9682be..908b9ba9ba2efa8df396b51d437a714afc802a73 100644
--- a/net/sched/sch_htb.c
+++ b/net/sched/sch_htb.c
@@ -1293,8 +1293,6 @@ static void htb_offload_aggregate_stats(struct htb_sched *q,
 	struct htb_class *c;
 	unsigned int i;
 
-	gnet_stats_basic_sync_init(&cl->bstats);
-
 	for (i = 0; i < q->clhash.hashsize; i++) {
 		hlist_for_each_entry(c, &q->clhash.hash[i], common.hnode) {
 			struct htb_class *p = c;
@@ -1313,7 +1311,7 @@ static void htb_offload_aggregate_stats(struct htb_sched *q,
 			}
 		}
 	}
-	_bstats_update(&cl->bstats, bytes, packets);
+	_bstats_set(&cl->bstats, bytes, packets);
 }
 
 static int
@@ -1340,17 +1338,21 @@ htb_dump_class_stats(struct Qdisc *sch, unsigned long arg, struct gnet_dump *d)
 				 INT_MIN, INT_MAX);
 
 	if (q->offload) {
+		spin_lock_bh(qdisc_lock(sch));
 		if (!cl->level) {
-			if (cl->leaf.q)
-				cl->bstats = cl->leaf.q->bstats;
-			else
-				gnet_stats_basic_sync_init(&cl->bstats);
-			_bstats_update(&cl->bstats,
-				       u64_stats_read(&cl->bstats_bias.bytes),
-				       u64_stats_read(&cl->bstats_bias.packets));
+			u64 bytes = 0, packets = 0;
+
+			if (cl->leaf.q) {
+				bytes = u64_stats_read(&cl->leaf.q->bstats.bytes);
+				packets = u64_stats_read(&cl->leaf.q->bstats.packets);
+			}
+			bytes += u64_stats_read(&cl->bstats_bias.bytes);
+			packets += u64_stats_read(&cl->bstats_bias.packets);
+			_bstats_set(&cl->bstats, bytes, packets);
 		} else {
 			htb_offload_aggregate_stats(q, cl);
 		}
+		spin_unlock_bh(qdisc_lock(sch));
 	}
 
 	if (gnet_stats_copy_basic(d, NULL, &cl->bstats, true) < 0 ||
-- 
2.54.0.563.g4f69b47b94-goog


