Return-Path: <netdev+bounces-258945-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id OGxlCtxxk2lq5AEAu9opvQ
	(envelope-from <netdev+bounces-258945-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Mon, 16 Feb 2026 20:37:00 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 7F45D147504
	for <lists+netdev@lfdr.de>; Mon, 16 Feb 2026 20:36:59 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 0EB3430238D1
	for <lists+netdev@lfdr.de>; Mon, 16 Feb 2026 19:36:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 49E4A2D8379;
	Mon, 16 Feb 2026 19:36:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="LVOlCxNM"
X-Original-To: netdev@vger.kernel.org
Received: from mail-qt1-f202.google.com (mail-qt1-f202.google.com [209.85.160.202])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1B043275864
	for <netdev@vger.kernel.org>; Mon, 16 Feb 2026 19:36:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.202
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1771270617; cv=none; b=j8BEWVkXS6S9eFO86b/SH/35dv/6uW7/gggLbqkdUzgpCWbeTXU287e0ejfe1Gx/eFKLRbFFZ99/WjT/vQsUUukT25tMmfqZ8yQ/g/vg3x4MWY8IdkfNlpPd+reEQH+QdwTfoYzxmsi4MPKgRDjywQINGzpu9QZKBxWz/rdeOhg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1771270617; c=relaxed/simple;
	bh=Bc28nxKhZv3QCDRdkRDy9/eVhgEmC9sqfmbBVX5Z1is=;
	h=Date:Mime-Version:Message-ID:Subject:From:To:Cc:Content-Type; b=o4oyhoTdyCvh4XBrKe5Dfo+Lga+vGIUa3/8rwg3H/Oz+DWO1gh0fAqTQrYzfu2JIE5wHKWw42DsSy3lXayBSbvgULa9z4SKveafIKthDx0K/D7WRLhgXz32SVJOXJ1OHeQkPz8j+z0RXmkInXmuQPj5ySKAcXMLJqJOV3zu0p5A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--edumazet.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=LVOlCxNM; arc=none smtp.client-ip=209.85.160.202
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--edumazet.bounces.google.com
Received: by mail-qt1-f202.google.com with SMTP id d75a77b69052e-506b839cafaso24327651cf.3
        for <netdev@vger.kernel.org>; Mon, 16 Feb 2026 11:36:55 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1771270615; x=1771875415; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:mime-version:date:from:to:cc:subject
         :date:message-id:reply-to;
        bh=d6j6Hfy9UZtJQFxwFk3EgZdpOqO6OFUb9VGms3uyiGA=;
        b=LVOlCxNM+oDvaq1tJcXTZQKoOpvRcpivxKaBvWlvwv+bTXnE8/6xk+/ZlWrF2zeLDk
         HVCtHYPjuiW0355W/4Usowb764xVckWJX3L6h1norsumxe4cPkbEXX22eCWhF+vMP4HU
         I1MXORQ3ctx7Uh6Z7mcdJjjy70V2BuaxOjUhRVynV4NxjNltp3+1gXDdB78LBZzvEKhN
         ONgrjjkckg4xhOElJN+J66rUTOBTnUAcJpH7CGULJHN1EhvPcdqstkXjaWrfs0B3NHrP
         Ar69M1mjLVecKZ2epioasYvz7T4KQZf7PBonn9dNj5ho6LUU8ltp+sp9bIyP6BOwcGF4
         ls0w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1771270615; x=1771875415;
        h=cc:to:from:subject:message-id:mime-version:date:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=d6j6Hfy9UZtJQFxwFk3EgZdpOqO6OFUb9VGms3uyiGA=;
        b=c4b0BJUlGe0oIXgFK6TE5+F0ZehAP5gsHgTx/DkJL65CvthFh0eYny8cTDiP6v+jkg
         9q1C2DqeFKlAPsbvs+FI7gTj5lMboWrcBiRs9FSqiROJf7Nejgi4NYfe2IAWASvKoq5D
         +xGp5wQP5D4xnMUsDAr8C70XnB5Ofe/6HT/qaWYuvoXdwkB3lVvlssu0e7dswU2t+fNd
         GAIelquPNXHVz/drXV093sf0LTY4EeZmO54gsG4lb1nMopSwd0RJWspsKMoVOnm59NQT
         5zSFQtFG+YO7PuFO1Eb96ws7AHXEehyT67qujj/HqQm5rcYdZOSQTaLtnnpF3anUk20P
         LoJA==
X-Forwarded-Encrypted: i=1; AJvYcCXgzMgqauxtiNtBtrA1SPU3HwM7Cc65H8ZIbmgAH9euXuz89dGMZZ2gLeYQ3d47IIkJ2cuFNRA=@vger.kernel.org
X-Gm-Message-State: AOJu0YyLWFcLSuvIS2pOhEyx1NwZpC/+8qfufmRAY96HGSxCibkVj4Hi
	MM2gus+QuwHAtMZnbz5d1rUL2xCDX7/Nq8/2blAXMBy90rBWC/9oIptaeFkywOqtVEfyjrbRlpP
	4efYNmEo28TuNbA==
X-Received: from qtxv21.prod.google.com ([2002:a05:622a:1455:b0:4f0:96d:f258])
 (user=edumazet job=prod-delivery.src-stubby-dispatcher) by
 2002:a05:622a:180a:b0:502:6ed5:7b04 with SMTP id d75a77b69052e-506a836818emr140422311cf.74.1771270614831;
 Mon, 16 Feb 2026 11:36:54 -0800 (PST)
Date: Mon, 16 Feb 2026 19:36:53 +0000
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
X-Mailer: git-send-email 2.53.0.310.g728cabbaf7-goog
Message-ID: <20260216193653.627617-1-edumazet@google.com>
Subject: [PATCH net] net: do not delay zero-copy skbs in skb_attempt_defer_free()
From: Eric Dumazet <edumazet@google.com>
To: "David S . Miller" <davem@davemloft.net>, Jakub Kicinski <kuba@kernel.org>, 
	Paolo Abeni <pabeni@redhat.com>
Cc: Simon Horman <horms@kernel.org>, Kuniyuki Iwashima <kuniyu@google.com>, 
	Willem de Bruijn <willemb@google.com>, netdev@vger.kernel.org, eric.dumazet@gmail.com, 
	Eric Dumazet <edumazet@google.com>
Content-Type: text/plain; charset="UTF-8"
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [0.84 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	MID_CONTAINS_FROM(1.00)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MV_CASE(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[google.com,reject];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	R_DKIM_ALLOW(-0.20)[google.com:s=20230601];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FREEMAIL_CC(0.00)[kernel.org,google.com,vger.kernel.org,gmail.com];
	FORGED_SENDER_MAILLIST(0.00)[];
	TAGGED_FROM(0.00)[bounces-258945-lists,netdev=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[edumazet@google.com,netdev@vger.kernel.org];
	DKIM_TRACE(0.00)[google.com:+];
	RCPT_COUNT_SEVEN(0.00)[9];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	TAGGED_RCPT(0.00)[netdev];
	TO_DN_SOME(0.00)[]
X-Rspamd-Queue-Id: 7F45D147504
X-Rspamd-Action: no action

After the blamed commit, TCP tx zero copy notifications could be
arbitrarily delayed and cause regressions in applications waiting
for them.

Signed-off-by: Eric Dumazet <edumazet@google.com>
Fixes: e20dfbad8aab ("net: fix napi_consume_skb() with alien skbs")
---
 net/core/skbuff.c | 7 ++++++-
 1 file changed, 6 insertions(+), 1 deletion(-)

diff --git a/net/core/skbuff.c b/net/core/skbuff.c
index 699c401a5eae9c497a42b6bdd8593af7890529f4..dc47d3efc72ed86dce5e382d505eda7bc863669a 100644
--- a/net/core/skbuff.c
+++ b/net/core/skbuff.c
@@ -7266,10 +7266,15 @@ void skb_attempt_defer_free(struct sk_buff *skb)
 {
 	struct skb_defer_node *sdn;
 	unsigned long defer_count;
-	int cpu = skb->alloc_cpu;
 	unsigned int defer_max;
 	bool kick;
+	int cpu;
 
+	/* zero copy notifications should not be delayed. */
+	if (skb_zcopy(skb))
+		goto nodefer;
+
+	cpu = skb->alloc_cpu;
 	if (cpu == raw_smp_processor_id() ||
 	    WARN_ON_ONCE(cpu >= nr_cpu_ids) ||
 	    !cpu_online(cpu)) {
-- 
2.53.0.310.g728cabbaf7-goog


