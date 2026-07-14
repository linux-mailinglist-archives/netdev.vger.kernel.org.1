Return-Path: <netdev+bounces-307477-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id OkRMMks9Vmo82AAAu9opvQ
	(envelope-from <netdev+bounces-307477-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Tue, 14 Jul 2026 15:44:43 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 26C7B7554DA
	for <lists+netdev@lfdr.de>; Tue, 14 Jul 2026 15:44:43 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=gmail.com header.s=20251104 header.b=BbHIH5LS;
	spf=pass (mail.lfdr.de: domain of "netdev+bounces-307477-lists+netdev=lfdr.de@vger.kernel.org" designates 2600:3c0a:e001:db::12fc:5321 as permitted sender) smtp.mailfrom="netdev+bounces-307477-lists+netdev=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=none) header.from=gmail.com;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 85EAF30C9CA2
	for <lists+netdev@lfdr.de>; Tue, 14 Jul 2026 13:39:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 05C83466B65;
	Tue, 14 Jul 2026 13:39:41 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from mail-qt1-f177.google.com (mail-qt1-f177.google.com [209.85.160.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9416C4657FB
	for <netdev@vger.kernel.org>; Tue, 14 Jul 2026 13:39:39 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784036380; cv=none; b=ZGWNjdpRY6vGHAj4N83B/0tCcJ1/jU2T8t2Qz4bhSdQRCrX7sujQMjqp0MDw+LC2Bjla5ULD7Ppfs4ToVLoRG8BbPQ+YJXyMmcwWYYmuJqST3upvuboKi+R1Cl8MRqJEsKNQ2D0b1akZsgKM2pRugDJdhB8ewuLjhWvkjeVy9i8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784036380; c=relaxed/simple;
	bh=25m6Cev1zrh1xLbTU13X01zVEAyc2YjiEIvasunGnv8=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References; b=lBisD2y2uRQJxTL+QFwhr8+Dz0uIu230lEHgizPDmcc7AALj1vCHWuKkSA6ZTmaqgpgm0Wm74+Siz6hI2tMCLW2AHCDC1nHIYj/mHkaNatXexeu9zsbR/2ST13ty7HgM13MOLcYaVOXU1spGIGWUo+Y8zk45cs/1EmGGNq0q/KE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=BbHIH5LS; arc=none smtp.client-ip=209.85.160.177
Received: by mail-qt1-f177.google.com with SMTP id d75a77b69052e-51c2cce930cso9018591cf.0
        for <netdev@vger.kernel.org>; Tue, 14 Jul 2026 06:39:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1784036378; x=1784641178; darn=vger.kernel.org;
        h=references:in-reply-to:message-id:date:subject:cc:to:from:from:to
         :cc:subject:date:message-id:reply-to:content-type;
        bh=L47aQNASNr7ThcpGvRtxM7NJ1d7uBgMB7FOTPWUQ7RU=;
        b=BbHIH5LS3cMyG30IyWL80bX28iwxrdNXolxKJauOtWWKhw7Jgl42CfTFY1FvvwSY0v
         Yb00Ls9dXexIhArK8XlpNhexCO+PpNZSfhVJtAaHgK6R+tCFobqrcLZQvxEXcNpinKlG
         jLn9tjJHgoICgEP0yTVzYnShUNPYUdjlzGxQQw9v3qFSc3EBd2uAgOHhNi0o0px7HPNh
         dj9gWA495ZwujqnmPnsgcc6hB9kaW8rDu+XobVY2clNqy5OsTOBqqkDakmAWYwXDbsko
         VurjLwxjjKoONKj9Wti2W4dzhNmQH0Pl36BHWk2JgosmAvASvfFPDxBIGOmnVv1uDQi2
         iIsg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1784036378; x=1784641178;
        h=references:in-reply-to:message-id:date:subject:cc:to:from:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=L47aQNASNr7ThcpGvRtxM7NJ1d7uBgMB7FOTPWUQ7RU=;
        b=JABsdMFqQbpA1/9ftqitMmQfaeJJJe0ZyAGK4a3eixXw2wdamyCP4vqu8rKq9ZHv6y
         uQTMKmA57JrCRkRUrS7maKzI5onOmJFSBlxfwjiWf8pXtHHjk7jYg8goVtfFKNM3Fk8J
         V0MMIFlJ6wWzxeWhAm/LEld5mxOGqz3NpTuruy7LtCc584NnEIYgNKD+rqdjWpKHeGu7
         t01Cafp1ITV95AxEFaeosFnGOMtX5e4lrSc5Zbv+PiEo3H2jdmvdkvgCpcl6zS6FPmUE
         qwVyAFG/39TQQ/azWPKDJGJhLozq+enPCpiZqSq6+hByfW1ndCixvoC/TNkF2Tr+ueNg
         DFaQ==
X-Forwarded-Encrypted: i=1; AHgh+RpkfHtZxbGiWpr/4hrcfw01F1c7fGCLJlkEQWeY9Gr1j5kyQpnCOvWdf73cMCw0vRpOIslD8MA=@vger.kernel.org
X-Gm-Message-State: AOJu0YzjUjZqTCNYvOqVWxGMMU9KtCuosYVUkC0Ul+6GND8PBfhDBpPA
	jUj9kIyWYfckq5CKMM3wgN5M6MhPPd3pGyjfWkDVfTymGG/20VPJhkH684aOZg==
X-Gm-Gg: AfdE7cmKRrdStPSmSAHCfw+7T7PshuURgbjwtOZhVq8sqUk5OrYWBNW6hpGFvsJtGfm
	/qyS53dDxzVQXiGDd5DKKVaID7h7kkFXd1CyHLTCPtfCwv9dgKnwHuhx/jdnNAmx+zrkREzylEY
	rJvzw/abBR+G1sDARKdkHdD64F1aPnomtrP1s86FdfkTbnf7qaR+WM5fzNHQMrEIaGemr3mMLEk
	p6tne993lgHS4JqJKsRyEHzs6lqWt2N+I86UtI6dv0aOOw1ri8P8oWCKgCdGVlRtk1vSbCS7k+8
	bJf0N6cjw9ANF+aAt2vGI+niQSvcyCQSPCGdW82PuU/BkNNgX+keoGJLwJpN3L3Dljb0ZJis21+
	4FwMVSKP9wj5vgbj1zByb6qfmeVur8sOJaG34waLRcK6cmV5jWNZc3MregLX3YiaT2vMz/f8l50
	jEHR322QJFhMaUxrXALmElc0uEpVtu303l4u3vD5+azfCEcx1rPucYvF5HJm79
X-Received: by 2002:a05:622a:40c3:b0:51c:7b12:121a with SMTP id d75a77b69052e-51cbf37521fmr130323491cf.88.1784036378339;
        Tue, 14 Jul 2026 06:39:38 -0700 (PDT)
Received: from localhost.localdomain ([4.15.194.220])
        by smtp.gmail.com with ESMTPSA id d75a77b69052e-51caab6e326sm115754311cf.6.2026.07.14.06.39.37
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 14 Jul 2026 06:39:38 -0700 (PDT)
From: Vimal Agrawal <avimalin@gmail.com>
X-Google-Original-From: Vimal Agrawal <vimal.agrawal@sophos.com>
To: pabeni@redhat.com,
	netdev@vger.kernel.org
Cc: kuba@kernel.org,
	kuniyu@google.com,
	edumazet@google.com,
	vimal.agrawal@sophos.com
Subject: [PATCH v3 net-next] net: neigh: avoid calling neigh_forced_gc on every alloc when table is full
Date: Tue, 14 Jul 2026 13:39:09 +0000
Message-Id: <20260714133909.82424-1-vimal.agrawal@sophos.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <bc55e708-2f2f-46a1-b930-1cb62b05ac1d@redhat.com>
References: <bc55e708-2f2f-46a1-b930-1cb62b05ac1d@redhat.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-1.66 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[gmail.com,none];
	R_MISSING_CHARSET(0.50)[];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20251104];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	FORGED_RECIPIENTS(0.00)[m:pabeni@redhat.com,m:netdev@vger.kernel.org,m:kuba@kernel.org,m:kuniyu@google.com,m:edumazet@google.com,m:vimal.agrawal@sophos.com,s:lists@lfdr.de];
	TAGGED_FROM(0.00)[bounces-307477-lists,netdev=lfdr.de];
	FORGED_SENDER(0.00)[avimalin@gmail.com,netdev@vger.kernel.org];
	PRECEDENCE_BULK(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	FREEMAIL_FROM(0.00)[gmail.com];
	FROM_HAS_DN(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FORWARDED(0.00)[lists@lfdr.de];
	DKIM_TRACE(0.00)[gmail.com:+];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	FROM_NEQ_ENVFROM(0.00)[avimalin@gmail.com,netdev@vger.kernel.org];
	TO_DN_NONE(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	FORGED_SENDER_FORWARDING(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	ALIAS_RESOLVED(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	RCPT_COUNT_FIVE(0.00)[6];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[vger.kernel.org:from_smtp,sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,sophos.com:email,sophos.com:mid]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 26C7B7554DA

Once the neighbour table exceeds gc_thresh3, neigh_forced_gc() is called
on every allocation attempt with no rate limiting. In workloads with mostly
active/reachable entries, the GC walk traverses a large portion of the
neighbour table without reclaiming entries, holding tbl->lock for an
extended period. This causes severe lock contention and allocation
latencies exceeding 16ms under sustained neighbour creation.

Add a pre-lock check in neigh_forced_gc() to skip the GC run if one was
performed within the last 50 ms, but only when gc_thresh3 is configured
at or above NEIGH_FORCED_GC_LARGE_TABLE_THRESH (16384). This avoids
repeated full table scans and lock acquisitions on the hot allocation path
while leaving default-sized and test deployments (gc_thresh3 < 16384)
completely unaffected.

Profiling of neigh_create() shows ~3 orders of magnitude latency
improvement with this change.

Link: https://lore.kernel.org/netdev/CALkUMdSCpx_ywYCx_ePLdm6yioO1nQWx7sSM=AEgsq0kywHxTw@mail.gmail.com/
Signed-off-by: Vimal Agrawal <vimal.agrawal@sophos.com>

---
Thank you for catching this. The v2 rate limit was unconditional, so it
fired even in the selftest which sets gc_thresh3=10, preventing
forced_gc_runs from being incremented.

v3 restricts rate limiting to tables where gc_thresh3 >= 16384. Selftests
and default deployments (gc_thresh3=1024) are unaffected.

v3: Restrict rate limiting to tables with gc_thresh3 >= 16384 to avoid
    breaking selftests and default deployments (gc_thresh3=1024).
v2: Changed rate-limit window from 1s (HZ) to 50ms (msecs_to_jiffies(50))
    based on profiling data showing 44% -> 2.56% CPU reduction.

 net/core/neighbour.c | 11 +++++++++++
 1 file changed, 11 insertions(+)

diff --git a/net/core/neighbour.c b/net/core/neighbour.c
index 1349c0eed..9438c5821 100644
--- a/net/core/neighbour.c
+++ b/net/core/neighbour.c
@@ -250,6 +250,8 @@ bool neigh_remove_one(struct neighbour *n)
 	return retval;
 }
 
+#define NEIGH_FORCED_GC_LARGE_TABLE_THRESH    16384
+
 static int neigh_forced_gc(struct neigh_table *tbl)
 {
 	int max_clean = atomic_read(&tbl->gc_entries) -
@@ -260,6 +262,15 @@ static int neigh_forced_gc(struct neigh_table *tbl)
 	int shrunk = 0;
 	int loop = 0;
 
+	/*
+	 * For large neighbor tables, repeated forced GC passes can spend
+	 * significant CPU scanning neighbor entries when most remain active.
+	 * Rate-limit consecutive forced GC passes to reduce CPU overhead.
+	 */
+	if (READ_ONCE(tbl->gc_thresh3) >= NEIGH_FORCED_GC_LARGE_TABLE_THRESH &&
+	    time_before(jiffies, READ_ONCE(tbl->last_flush) + msecs_to_jiffies(50)))
+		return 0;
+
 	NEIGH_CACHE_STAT_INC(tbl, forced_gc_runs);
 
 	spin_lock_bh(&tbl->lock);
-- 
2.43.0


