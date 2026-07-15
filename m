Return-Path: <netdev+bounces-307665-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id qybEK1sgV2qJFgEAu9opvQ
	(envelope-from <netdev+bounces-307665-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Wed, 15 Jul 2026 07:53:31 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 080F575AC24
	for <lists+netdev@lfdr.de>; Wed, 15 Jul 2026 07:53:31 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=gmail.com header.s=20251104 header.b=gDxZ+LTV;
	spf=pass (mail.lfdr.de: domain of "netdev+bounces-307665-lists+netdev=lfdr.de@vger.kernel.org" designates 2600:3c0a:e001:db::12fc:5321 as permitted sender) smtp.mailfrom="netdev+bounces-307665-lists+netdev=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=none) header.from=gmail.com;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id C5DDF3038C6A
	for <lists+netdev@lfdr.de>; Wed, 15 Jul 2026 05:53:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 536563B4E9B;
	Wed, 15 Jul 2026 05:53:28 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from mail-qt1-f173.google.com (mail-qt1-f173.google.com [209.85.160.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D25B43B38A2
	for <netdev@vger.kernel.org>; Wed, 15 Jul 2026 05:53:26 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784094808; cv=none; b=rkpbA1szqQ0kOiZiDOh1i7l+GEdEg9sqWQEYPuqeuUlc9JQj1M4+gjsqrA1gll8cMH0y0+NuwwB/Ffr/h6bWloHLuPU1i94Lj1rGqsSF0VtW1tV4c+7DH/QRYAHXbZgbzvRufOc2lBZIIg0t9PbU8kEtSzn/Y+ekFpDXpFPmLFY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784094808; c=relaxed/simple;
	bh=cv/py1C2nLATOuxnjEQyvp5MmxbEmsJSCheT3nEyXzU=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References; b=j+jFnYz1C5ZkOd5uCr9DYJmqVppEZkTyYo7US12bSHZ41/lO0PL2UPc+3AzdqWqFCW/Id6D7mbJB460ij4HO2ad5Z7e7iB8os8bfMNtI6htZDsZRDSVaVE//q0VqTQFPSx5lppRyMf3rLjyv5UtexIcv82loOglq0/jyANq/MQA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=gDxZ+LTV; arc=none smtp.client-ip=209.85.160.173
Received: by mail-qt1-f173.google.com with SMTP id d75a77b69052e-51bfad59921so42211491cf.0
        for <netdev@vger.kernel.org>; Tue, 14 Jul 2026 22:53:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1784094806; x=1784699606; darn=vger.kernel.org;
        h=references:in-reply-to:message-id:date:subject:cc:to:from:from:to
         :cc:subject:date:message-id:reply-to:content-type;
        bh=VYantbV19BJGNggt8/qq3SXPjrD8WHX/QjRV00onfwg=;
        b=gDxZ+LTVUmXaOu27gQMgMGDVd9WAM+l67JyUvSTbwnnW+jk18loxOt8dzWfScklqDu
         tFaskTOA7GxByk8m0Ycd2va8WgH+XhdznZXfh/3IFoRfJfVubQjyyUH5nIXuWu+j+q9f
         yB9cB51VI/eT7I4rmcoStPsNl7clDKfrgcRmS7H2vuenxYFAm7tMuOIN1SDQk34sj0Mq
         ctfyW5yskOv8vwSzq7BVARDcVNa7Fk6Hg0HwP/xohIMjMYTRdt374i26luLpmwJsbD+d
         roX646zKf2RJXaEeck1d/Pq3QmVDsSk0OJlqA5FMMara2/iG1vb+ioJba1whvhlFRohB
         P5ew==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1784094806; x=1784699606;
        h=references:in-reply-to:message-id:date:subject:cc:to:from:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=VYantbV19BJGNggt8/qq3SXPjrD8WHX/QjRV00onfwg=;
        b=J1uF/Qv2xoOBtx+R4CtMIO3fO5IibLtXso+THit5Sm5cx8D5JFAAC9D/vNc5Mc8Gsb
         SXMwlCZ5oVVs0DJOppPAFcA8MTW24hAraqWGmgYRZ/hUcg3zpyDS1MQcArSbN1STA+A+
         dpBKxJvevSn1wHFxD/wokHO1f0OLkWusAdoLGwwmvbeNtEt6GYawdccL7bjnKgmWYhB1
         Ayn39c1dKINQi1dvxtXJvaCCFI+8GL/PDutMhmtSsuRcT/2vALWCLo8WV3Vnu02jPwTC
         4bEb9gOS/IhU/1wcihSsPHfaepcV6uC7gp7K6ohVzt01UG8jhMYQ6E6RfSZ+KoYvSbzG
         YkwA==
X-Forwarded-Encrypted: i=1; AHgh+Ro9APTcGBsJ3nnl3v+oJuv5NYg0Na/OQBjw5JZRO7swbLGFci30xSNlGkJyM9ZiU8qioZueg/E=@vger.kernel.org
X-Gm-Message-State: AOJu0YzS8w5y3qkOElQs/j7YMr+FMzE2ErcVt32l8epDL/c1lP4nBEh8
	l+Z/epWW8yrhsCvC40L/B6GQJiHXHaCFXgnPHAHkBVRyU8a4K0qc7rruaRNmsJC5
X-Gm-Gg: AfdE7cnnml+czIqnP+vP/0iOol9zWfsxeBcXmhJz82YnUlwaiQ1J85pggcTSirFXjlb
	DiYA9jiiNlB8AHqaueG23JXco43ODMu2G7E/6Wrpq/8aP6/OlkVPUw0EpnrsCtwCAEo+MzsOada
	r5WEk4+o5aT3NT7oYVUaoouatc25WON670hcLfmB7/3+6KNeKJAGrLLuGxXWN3ApWrHah9vwt0h
	zA481KhE/4QxHLvO9+ismYkjD49ZijFQYS4TO8a0+EnY34NTMrpcDUOVcsoCBHAr2jiw8nH1RRP
	x4iryney9W5n2Ok7r6Jngn1QpbPSexayIvAhUDDulpVt1eTZM/lQjwF4A8XA3bxGIMznKoxnaFj
	3TycU5OVxIItNV4x+1y9ALGppajgUjVRKCibYSqgqJ4RbDJeKg5T3TFBF9AJyzI7FWftK/xPsA5
	qmE69nwPsa3JHK3k/JOFIAIQvuQTNzr6Iy8jtrvgUV1JsEpdNdMByGbXO0ZLC5
X-Received: by 2002:a05:622a:142:b0:51c:17cd:1fd4 with SMTP id d75a77b69052e-51e424808f6mr49106881cf.41.1784094805630;
        Tue, 14 Jul 2026 22:53:25 -0700 (PDT)
Received: from localhost.localdomain ([4.15.194.220])
        by smtp.gmail.com with ESMTPSA id d75a77b69052e-51caafd8b4fsm131928181cf.31.2026.07.14.22.53.24
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 14 Jul 2026 22:53:25 -0700 (PDT)
From: Vimal Agrawal <avimalin@gmail.com>
X-Google-Original-From: Vimal Agrawal <vimal.agrawal@sophos.com>
To: pabeni@redhat.com,
	netdev@vger.kernel.org
Cc: kuba@kernel.org,
	kuniyu@google.com,
	edumazet@google.com,
	vimal.agrawal@sophos.com
Subject: [PATCH v4 net-next] net: neigh: avoid calling neigh_forced_gc on every alloc when table is full
Date: Wed, 15 Jul 2026 05:53:11 +0000
Message-Id: <20260715055311.90403-1-vimal.agrawal@sophos.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20260714133909.82424-1-vimal.agrawal@sophos.com>
References: <20260714133909.82424-1-vimal.agrawal@sophos.com>
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
	TAGGED_FROM(0.00)[bounces-307665-lists,netdev=lfdr.de];
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
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,vger.kernel.org:from_smtp,sophos.com:email,sophos.com:mid]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 080F575AC24

Once the neighbour table exceeds gc_thresh3, neigh_forced_gc() is called
on every allocation attempt with no rate limiting. In workloads with mostly
active/reachable entries, the GC walk traverses a large portion of the
neighbour table without reclaiming entries, holding tbl->lock for an
extended period. This causes severe lock contention and allocation
latencies exceeding 16ms under sustained neighbour creation.

Add a pre-lock check in neigh_forced_gc() to skip the GC run if one was
performed within the last 50 ms, but only when the table actually contains
NEIGH_FORCED_GC_LARGE_TABLE_THRESH (16384) or more entries. This avoids
repeated full table scans and lock acquisitions on the hot allocation path
while leaving tables with few entries completely unaffected regardless of
how gc_thresh3 is configured.

Profiling of neigh_create() shows ~3 orders of magnitude latency
improvement with this change.

Link: https://lore.kernel.org/netdev/CALkUMdSCpx_ywYCx_ePLdm6yioO1nQWx7sSM=AEgsq0kywHxTw@mail.gmail.com/
Signed-off-by: Vimal Agrawal <vimal.agrawal@sophos.com>
---
v4: Rate-limit based on actual gc_entries count (>= 16384) rather than
    gc_thresh3 configuration, so tables with few entries are never
    rate-limited regardless of how gc_thresh3 is configured.
v3: Restrict rate limiting to tables with gc_thresh3 >= 16384 to avoid
    breaking selftests and default deployments (gc_thresh3=1024).
v2: Changed rate-limit window from 1s (HZ) to 50ms (msecs_to_jiffies(50))
    based on profiling data showing 44% -> 2.56% CPU reduction.

 net/core/neighbour.c | 11 +++++++++++
 1 file changed, 11 insertions(+)

diff --git a/net/core/neighbour.c b/net/core/neighbour.c
index 1349c0eed..9977b9f32 100644
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
+	if (atomic_read(&tbl->gc_entries) >= NEIGH_FORCED_GC_LARGE_TABLE_THRESH &&
+	    time_before(jiffies, READ_ONCE(tbl->last_flush) + msecs_to_jiffies(50)))
+		return 0;
+
 	NEIGH_CACHE_STAT_INC(tbl, forced_gc_runs);
 
 	spin_lock_bh(&tbl->lock);
-- 
2.43.0


