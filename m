Return-Path: <netdev+bounces-276523-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id uDx3EZlQ1mm8DQgAu9opvQ
	(envelope-from <netdev+bounces-276523-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Wed, 08 Apr 2026 14:56:57 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id EF7533BC775
	for <lists+netdev@lfdr.de>; Wed, 08 Apr 2026 14:56:56 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 3379D3034A3B
	for <lists+netdev@lfdr.de>; Wed,  8 Apr 2026 12:56:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AB9C13C2799;
	Wed,  8 Apr 2026 12:56:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="wCXqwxLx"
X-Original-To: netdev@vger.kernel.org
Received: from mail-qk1-f201.google.com (mail-qk1-f201.google.com [209.85.222.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5E83C3C6619
	for <netdev@vger.kernel.org>; Wed,  8 Apr 2026 12:56:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775652990; cv=none; b=YNFwatQOW6ouXy/DuYa4l49HtZlenr01OIDNlOWCgucCWMMFeUDs5xthMJgiR0+UB1ZidM3Dw08j6bFwqyohXLv1MdArfIz5B7/GhjMvkAJt/dfYNHCy4lYazahy4FUVksGUced0A/6ipuLlGhcoy2jA50NMB376CtnxY6x5iQU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775652990; c=relaxed/simple;
	bh=NLlOCX8azWcJx65h66z85wsmonxZA2LSWRD6jzZ1lQo=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=MJVPQkWE0jTw5bphtAWEG5MJpVVuMk+tO776X9UpjIbdQwzyWD8ZzuhNt54LLKjQCi3JjB2TBAw2BCSsgxceWRvvZS92WEqk97H8jCCmNMjalV9DqrlGy/pk3w6HXZdKPVz+Iec8+srOTv1s+2O8l0RZxzL71BoF9+WPWtIkW6w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--edumazet.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=wCXqwxLx; arc=none smtp.client-ip=209.85.222.201
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--edumazet.bounces.google.com
Received: by mail-qk1-f201.google.com with SMTP id af79cd13be357-8d5b5d607d1so951556585a.3
        for <netdev@vger.kernel.org>; Wed, 08 Apr 2026 05:56:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1775652988; x=1776257788; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=Ge1KbPtPse9CG3yxMaUrV47O0RjfiawbyUAvHe0Yefw=;
        b=wCXqwxLxdv9XFRiV4gt1gfoBVkySpR4lo9XIhamYin/AqlLLzO7+hrzcWojo0r5eyG
         7foVoYFFCrgMkT9xk6RmZBB8+8DroJT6i2+8kvQ+LwfVTWiWJavAj6ao4J0NsTKbR00J
         flXhJtD1beh961zf+P9uc/MLKUBpBV5Y9oc683eWdeK1y2tNqDTu9VXaXdUid2KkpIh7
         onk7Bd2xoTSyrab9mnvJvEfYtXY4rWcNIT8smShOD+a0OC1e13qxiS54wcnJLEehZ6d6
         ouGqcLjc5pJPplPrrU7aVvqGKQTy4v0whyx9SDk4h44yLiiJu5xS0uNYYhvVjGC1fpoT
         FgPQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1775652988; x=1776257788;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=Ge1KbPtPse9CG3yxMaUrV47O0RjfiawbyUAvHe0Yefw=;
        b=MmrMIsEZj5rFh5OMQn2eI2zbXiqxKxzdvi4YxsKfnoqP1lJy+5yQtuFX93Ok5RVs5e
         L5CGqT7lUvB3x4EeJM8jwBYj/ek0AR4vVbxeA59VSU2gFRGXPJ4AaoIidhoJYJW3J8YX
         euqykfTwR1PiU/AuQbNB8c6s0k9Yz9MHV6WP0BI09JOp7qGWY4pV6tWN5tf75oT6gCx8
         yhBvmE0YcRxHb3Nzwgyp/uF9TktoMdt80jDL8BSunS/AS3apMWaf9nOOk6aLprTuSSpF
         y3YSUjt4KxrFyIeggTJ+Ht8RpzJyO+mtXQdhccdy/RtdqDNHOskie0k4RM8M8cEYzfYh
         +7vg==
X-Forwarded-Encrypted: i=1; AJvYcCUzrI07angd/jTDbzgvcaNR66wib6KwTwFg7oeiHG70ag3GYmokN1AuWo8qYOJxfgbbxCVNMc4=@vger.kernel.org
X-Gm-Message-State: AOJu0Yz9zBbLvN+Qbgf73rW/Kaiw5CUZYnPY5WotJ5JF/i9TkGni7s7l
	30Z/7iCTz0Z2XFdBtFvgESNRtpR8i+CIVQwUdVkUzbehXVDOO4h21BDsl7CBik1fOhpcfdfb7qX
	QPFPjuMhnMBGPhA==
X-Received: from qkpa10.prod.google.com ([2002:a05:620a:438a:b0:8d4:1ac0:34ec])
 (user=edumazet job=prod-delivery.src-stubby-dispatcher) by
 2002:a05:620a:201b:b0:8d5:bb98:f3ce with SMTP id af79cd13be357-8d5bb98f6f6mr1883595885a.60.1775652988175;
 Wed, 08 Apr 2026 05:56:28 -0700 (PDT)
Date: Wed,  8 Apr 2026 12:56:04 +0000
In-Reply-To: <20260408125611.3592751-1-edumazet@google.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20260408125611.3592751-1-edumazet@google.com>
X-Mailer: git-send-email 2.53.0.1213.gd9a14994de-goog
Message-ID: <20260408125611.3592751-9-edumazet@google.com>
Subject: [PATCH net-next 08/15] net/sched: sch_fq_codel: remove data-races
 from fq_codel_dump_stats()
From: Eric Dumazet <edumazet@google.com>
To: "David S . Miller" <davem@davemloft.net>, Jakub Kicinski <kuba@kernel.org>, 
	Paolo Abeni <pabeni@redhat.com>
Cc: Simon Horman <horms@kernel.org>, Jamal Hadi Salim <jhs@mojatatu.com>, Jiri Pirko <jiri@resnulli.us>, 
	Kuniyuki Iwashima <kuniyu@google.com>, netdev@vger.kernel.org, eric.dumazet@gmail.com, 
	Eric Dumazet <edumazet@google.com>
Content-Type: text/plain; charset="UTF-8"
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
	TAGGED_FROM(0.00)[bounces-276523-lists,netdev=lfdr.de];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[edumazet@google.com,netdev@vger.kernel.org];
	DKIM_TRACE(0.00)[google.com:+];
	RCPT_COUNT_SEVEN(0.00)[10];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[netdev];
	ASN(0.00)[asn:63949, ipnet:172.105.96.0/20, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: EF7533BC775
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

fq_codel_dump_stats() acquires the qdisc spinlock a bit too late.

Move this acquisition before we fill st.qdisc_stats with live data.

Fixes: edb09eb17ed8 ("net: sched: do not acquire qdisc spinlock in qdisc/class stats dump")
Signed-off-by: Eric Dumazet <edumazet@google.com>
---
 net/sched/sch_fq_codel.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/net/sched/sch_fq_codel.c b/net/sched/sch_fq_codel.c
index 5c88278a30b3cd92ae525d1a88eb692ff0e296e0..db5cf578cbd63e842381cb147ced145fed4cca3e 100644
--- a/net/sched/sch_fq_codel.c
+++ b/net/sched/sch_fq_codel.c
@@ -586,6 +586,8 @@ static int fq_codel_dump_stats(struct Qdisc *sch, struct gnet_dump *d)
 	};
 	struct list_head *pos;
 
+	sch_tree_lock(sch);
+
 	st.qdisc_stats.maxpacket = q->cstats.maxpacket;
 	st.qdisc_stats.drop_overlimit = q->drop_overlimit;
 	st.qdisc_stats.ecn_mark = q->cstats.ecn_mark;
@@ -594,7 +596,6 @@ static int fq_codel_dump_stats(struct Qdisc *sch, struct gnet_dump *d)
 	st.qdisc_stats.memory_usage  = q->memory_usage;
 	st.qdisc_stats.drop_overmemory = q->drop_overmemory;
 
-	sch_tree_lock(sch);
 	list_for_each(pos, &q->new_flows)
 		st.qdisc_stats.new_flows_len++;
 
-- 
2.53.0.1213.gd9a14994de-goog


