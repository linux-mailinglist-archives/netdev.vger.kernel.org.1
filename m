Return-Path: <netdev+bounces-281268-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id AP5SDnsh72lv7QAAu9opvQ
	(envelope-from <netdev+bounces-281268-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Mon, 27 Apr 2026 10:42:35 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 7A18146F441
	for <lists+netdev@lfdr.de>; Mon, 27 Apr 2026 10:42:34 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 5A8DD302F0F2
	for <lists+netdev@lfdr.de>; Mon, 27 Apr 2026 08:36:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2CA5E39B958;
	Mon, 27 Apr 2026 08:36:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="tzz2RS7B"
X-Original-To: netdev@vger.kernel.org
Received: from mail-qv1-f74.google.com (mail-qv1-f74.google.com [209.85.219.74])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B06053806D8
	for <netdev@vger.kernel.org>; Mon, 27 Apr 2026 08:36:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.74
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777278980; cv=none; b=cAQfh6ADVpDa3obRFDT4E+PydD5D54F21IFvFyLeyqIdxnwiyFtDPDEjrs9WYIPP8F7zooSyzAy5SNIEmYpSoygeI1RHQLZhkzSQ4sYl+PYGTFyqD+Qt8TMNhNdaNcmr31kHFT1dAwrzL42pTKHb6T2dWBZKomt5+zIpeHHHq1A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777278980; c=relaxed/simple;
	bh=Krbd0XSS47wbwjzyL9xerLdZDZRh4N4dYBSW8fW62MM=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=oAt+8P8NFxAMf1OGtEepz0JCIGfHhU2J2B0zNUP2JTQpadE6cDlMKYqc/JNDcsYd46rEk7pzt5KYDlXxnZobuTIAFP3viwUnD5xq7PmRfvTaBcD/gTcxnKTjcCm0NV6KlK1NpT5wmfPFk0cNKChx7MScn3L7sXva6qWDPDxh0QI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--edumazet.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=tzz2RS7B; arc=none smtp.client-ip=209.85.219.74
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--edumazet.bounces.google.com
Received: by mail-qv1-f74.google.com with SMTP id 6a1803df08f44-8aca6420fe3so37344606d6.0
        for <netdev@vger.kernel.org>; Mon, 27 Apr 2026 01:36:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1777278977; x=1777883777; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:from:subject:message-id:references
         :mime-version:in-reply-to:date:from:to:cc:subject:date:message-id
         :reply-to;
        bh=4JEsAnMl03YqBvZww7H+Tq1E84Is6QU3pBK1m7/v0A8=;
        b=tzz2RS7BsiKIu3GPAPP8eUSl+Z+pxcMDQK7CB3gDo1D7NnW7UClLgRpKDK0hpxHacY
         g4uby0KERfZEhIbxFUOpDfxELEAebFRnAI1yDqhqNYbIAY4qZlRdQcKaQLrDJ5t3Cc2Q
         XBIoPBYnOvn7xtUX/G5M02VznAEf+7byzBrvGqlFiiVS83F3DoNG5nq7Od8ApyzEZ8r2
         W979wxH64Cq/Oogf+5Jgp0OseBLDnghP1l4pQ7pz7r1HyxsBxfXpJbpSLeM/cituJp34
         iX+2Nxnd9r8c6EGZU6zvlEMM5PaQk75QFoySzprZeVxtw4AOzf8sElPKgJR7kZanvB8E
         0SvA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1777278977; x=1777883777;
        h=content-transfer-encoding:cc:to:from:subject:message-id:references
         :mime-version:in-reply-to:date:x-gm-message-state:from:to:cc:subject
         :date:message-id:reply-to;
        bh=4JEsAnMl03YqBvZww7H+Tq1E84Is6QU3pBK1m7/v0A8=;
        b=JNJZKEtDlILhvN6asOfKC6u5cIcpZsZCJI9RfA1eAHixRPPjAjLEww/LVD7+8dJvyV
         6o0Q86VaJ/WTCksceuiC5jMvPulrVbwSMyMM/D3oZPvbTHJ/XhGjWzctwAfX0IpCt+Xz
         MT0Jo50ddXgBCrdARXQVHCheTfjvprGR1B4S/qfgtpuI91RM8yFiHL/ijnxtNZ7UY2Qh
         Rl6riTc/4V5omaIt3IoBHaQiJ99WMipeK75A5KmEIXl1W8Bc6r3WB5xN+1RARdReqyR4
         V9+oeJoM8SeuWtBHoCbi9zsa/cb8JPUntyeD4+tIsIR7/LiMNMph3/KjCCo3GLsluXFE
         aeqw==
X-Forwarded-Encrypted: i=1; AFNElJ8eCxhswNGOwBacar9Nv5rrNvNlBvs+zN5kTHjnV8C+msU2IpZeebJytH9JqIEF3EgJKva4fbg=@vger.kernel.org
X-Gm-Message-State: AOJu0YyYbn+6GyKCl9GjtAXk4x+AmNJYSdxJL85HcOKSTMIRel+7RzOD
	sH7pMj47Xtcd0NXUVV8nyBBfBc31xlsNQU8XuWRsp/r4j0yl+aFVmsxeFlWgjxZIynAL/o3UVye
	agQo5oLWe/2Kjpg==
X-Received: from qvbme8.prod.google.com ([2002:a05:6214:5d08:b0:8a1:8b97:3205])
 (user=edumazet job=prod-delivery.src-stubby-dispatcher) by
 2002:a05:6214:cc8:b0:89c:e946:2f69 with SMTP id 6a1803df08f44-8b02814b465mr692713316d6.46.1777278977340;
 Mon, 27 Apr 2026 01:36:17 -0700 (PDT)
Date: Mon, 27 Apr 2026 08:36:06 +0000
In-Reply-To: <20260427083606.459355-1-edumazet@google.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20260427083606.459355-1-edumazet@google.com>
X-Mailer: git-send-email 2.54.0.545.g6539524ca2-goog
Message-ID: <20260427083606.459355-6-edumazet@google.com>
Subject: [PATCH v2 net 5/5] net/sched: sch_cake: annotate data-races in
 cake_dump_stats() (V)
From: Eric Dumazet <edumazet@google.com>
To: "David S . Miller" <davem@davemloft.net>, Jakub Kicinski <kuba@kernel.org>, 
	Paolo Abeni <pabeni@redhat.com>
Cc: Simon Horman <horms@kernel.org>, Jamal Hadi Salim <jhs@mojatatu.com>, Jiri Pirko <jiri@resnulli.us>, 
	"=?UTF-8?q?Toke=20H=C3=B8iland-J=C3=B8rgensen?=" <toke@redhat.com>, netdev@vger.kernel.org, eric.dumazet@gmail.com, 
	Eric Dumazet <edumazet@google.com>, 
	"=?UTF-8?q?Toke=20H=C3=B8iland-J=C3=B8rgensen?=" <toke@toke.dk>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Rspamd-Queue-Id: 7A18146F441
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
	FREEMAIL_CC(0.00)[kernel.org,mojatatu.com,resnulli.us,redhat.com,vger.kernel.org,gmail.com,google.com,toke.dk];
	RCVD_COUNT_THREE(0.00)[4];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-281268-lists,netdev=lfdr.de];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[edumazet@google.com,netdev@vger.kernel.org];
	DKIM_TRACE(0.00)[google.com:+];
	RCPT_COUNT_SEVEN(0.00)[11];
	NEURAL_HAM(-0.00)[-0.999];
	TAGGED_RCPT(0.00)[netdev];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[toke.dk:email,sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,cparams.target:url]

cake_dump_stats() runs without qdisc spinlock being held.

In this final patch, I add READ_ONCE()/WRITE_ONCE() annotations
for cparams.target and cparams.interval.

Fixes: 046f6fd5daef ("sched: Add Common Applications Kept Enhanced (cake) q=
disc")
Signed-off-by: Eric Dumazet <edumazet@google.com>
Acked-by: "Toke H=C3=B8iland-J=C3=B8rgensen" <toke@toke.dk>
---
 net/sched/sch_cake.c | 13 +++++++------
 1 file changed, 7 insertions(+), 6 deletions(-)

diff --git a/net/sched/sch_cake.c b/net/sched/sch_cake.c
index 975f5d6d6982f33a9d1f5454721ce16b6c433439..13c6d1869a144738c52ffc462f0=
6338bf8245fea 100644
--- a/net/sched/sch_cake.c
+++ b/net/sched/sch_cake.c
@@ -2356,10 +2356,11 @@ static void cake_set_rate(struct cake_tin_data *b, =
u64 rate, u32 mtu,
=20
 	byte_target_ns =3D (byte_target * rate_ns) >> rate_shft;
=20
-	b->cparams.target =3D max((byte_target_ns * 3) / 2, target_ns);
-	b->cparams.interval =3D max(rtt_est_ns +
-				     b->cparams.target - target_ns,
-				     b->cparams.target * 2);
+	WRITE_ONCE(b->cparams.target,
+		   max((byte_target_ns * 3) / 2, target_ns));
+	WRITE_ONCE(b->cparams.interval,
+		   max(rtt_est_ns + b->cparams.target - target_ns,
+		       b->cparams.target * 2));
 	b->cparams.mtu_time =3D byte_target_ns;
 	b->cparams.p_inc =3D 1 << 24; /* 1/256 */
 	b->cparams.p_dec =3D 1 << 20; /* 1/4096 */
@@ -3042,9 +3043,9 @@ static int cake_dump_stats(struct Qdisc *sch, struct =
gnet_dump *d)
 		PUT_TSTAT_U32(BACKLOG_BYTES, READ_ONCE(b->tin_backlog));
=20
 		PUT_TSTAT_U32(TARGET_US,
-			      ktime_to_us(ns_to_ktime(b->cparams.target)));
+			      ktime_to_us(ns_to_ktime(READ_ONCE(b->cparams.target))));
 		PUT_TSTAT_U32(INTERVAL_US,
-			      ktime_to_us(ns_to_ktime(b->cparams.interval)));
+			      ktime_to_us(ns_to_ktime(READ_ONCE(b->cparams.interval))));
=20
 		PUT_TSTAT_U32(SENT_PACKETS, READ_ONCE(b->packets));
 		PUT_TSTAT_U32(DROPPED_PACKETS, READ_ONCE(b->tin_dropped));
--=20
2.54.0.545.g6539524ca2-goog


