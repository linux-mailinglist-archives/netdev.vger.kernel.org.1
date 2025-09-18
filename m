Return-Path: <netdev+bounces-213060-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D7D5BB2311C
	for <lists+netdev@lfdr.de>; Tue, 12 Aug 2025 20:00:28 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id D66D9567E0D
	for <lists+netdev@lfdr.de>; Tue, 12 Aug 2025 17:59:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 174882FF163;
	Tue, 12 Aug 2025 17:59:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="lvgDdTnN"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pl1-f202.google.com (mail-pl1-f202.google.com [209.85.214.202])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9A36B2FF150
	for <netdev@vger.kernel.org>; Tue, 12 Aug 2025 17:59:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.202
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755021542; cv=none; b=B7Hb6Q2hLCSE3WkJ4HdDvBCDnKKTQNNCeDXj5zOeiZNdpHuL2Loq5es/NY7eG8131O3IwrhnDUPj8cEAtY2MSLjnxt/dLc5iHqlxigSm6vJMSnPZ40jXJX/TZMdRDc/y4y6QoxphFL5zpO2trdQvnUiUTU6IomzfPmwJCPUOf2E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755021542; c=relaxed/simple;
	bh=xhnYwO7GL1+CtMhfwDFOhfD57z1pVtgWyVGZ0fjlUoI=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=m416p/cRg5gHmBLX1aVgoLQRDPHMktiyqZTfYznnfxoyCAzvltshVNE92FfhWC5Xo3veGuEHfDggYcEzZb5fKS/S7sFZWNVqRXMkkse1UWJ9CiDJ1kYp3LjLOG+6kXrVr4eS0MBfyjklaCO6y8cMvZkBgtzEcDzuY8TomzLhmCg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--kuniyu.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=lvgDdTnN; arc=none smtp.client-ip=209.85.214.202
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--kuniyu.bounces.google.com
Received: by mail-pl1-f202.google.com with SMTP id d9443c01a7336-24283069a1cso63133555ad.1
        for <netdev@vger.kernel.org>; Tue, 12 Aug 2025 10:59:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1755021540; x=1755626340; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=B5rCQpTg40XvAN0nRmC8PJTXTHlgnacsK7xSr02TOwk=;
        b=lvgDdTnNJFIyMUtzyIAuT0KMFprsTRpcBpnaJKC2Hq7QJkec8rJ+1orkGBpd2Puv00
         kRRstkc2jwnexTeULqVk2Fz+GJyt6SFK28yPErncKFYirwhCIrOA2RmAHdFeyJ8E4K06
         nDGCCI0sOYB74+ksyvmW++5JPXcJv6ApCCGp4hb0bYpH8AmUVM7B8GlYDklcH3A2l21V
         gIQmuiYdJIl5z4+V0rqxB/iCfuFa+QHOw8il3JSxixdNze7otr8L7sS9xKFPwmSrELt8
         Tvd1I8VyoNrnrSs5AqTCfPfmZnX7lNu/YYkkkKosfQySQnd/tynxBQSjrvLOI5bkjFO+
         eKuA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1755021540; x=1755626340;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=B5rCQpTg40XvAN0nRmC8PJTXTHlgnacsK7xSr02TOwk=;
        b=ax7NEOL+Vk//lBnnRCgZEqR07HlEPClaRDtRDwbTaD5QdQTnR9/4uAjVbAuA5do3uM
         jWS585269nUFSa+Px6SNtL2k+YM30Pcroa86QeJ4pTguTJYWubCfJPL1BhSWwIN7xSx+
         B0ykEnIknunajHfZPrZu6n68hg5rnNAZ1FVLhrThFvg2Xg7csD2pZ2Frz3zEZtMImj+9
         3JhROqGGhWwkDKfTulVhnqTLzW68zNEQ9uHErXZN6GG6q/9ugNtcsdKxJtP2PMSfkN4Z
         mK0zB0xSCoM8Jx0F+qIB2U7CThTpuGfOS17+9KLIESxrYKW1ZvKIq/gbYZZATNBTsX2b
         wzQg==
X-Forwarded-Encrypted: i=1; AJvYcCXw8hYh1hqNmcRcBzMOEfjIKLWP3iG5e4e9ywqfYY+AqLiFNFO7ShLlwhezz7GFNJkmGGKpRds=@vger.kernel.org
X-Gm-Message-State: AOJu0YxXA4tQvVTOqMej68eyrCbKa2Nb9wpJ8BDDSkFS9Vwrq1M4a9Ry
	1oXJrzQMC5VNKJThvB2kSZSY+BLuyhX6rv4gldVnbxl+cbZgWyvwzdQJwmgEzBiAekduohZBb41
	iZOjf2w==
X-Google-Smtp-Source: AGHT+IFWOE5iaFIohAGKeh/7bkm49sAtcTJw3E8VuXd5fFWE4AD9T9o/O9JzYSwQSyIb+xne5Odsyex1rCE=
X-Received: from plblh11.prod.google.com ([2002:a17:903:290b:b0:240:39eb:1e8c])
 (user=kuniyu job=prod-delivery.src-stubby-dispatcher) by 2002:a17:903:440f:b0:240:127:85f1
 with SMTP id d9443c01a7336-2430d0fc548mr1608415ad.18.1755021539728; Tue, 12
 Aug 2025 10:58:59 -0700 (PDT)
Date: Tue, 12 Aug 2025 17:58:21 +0000
In-Reply-To: <20250812175848.512446-1-kuniyu@google.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20250812175848.512446-1-kuniyu@google.com>
X-Mailer: git-send-email 2.51.0.rc0.205.g4a044479a3-goog
Message-ID: <20250812175848.512446-4-kuniyu@google.com>
Subject: [PATCH v3 net-next 03/12] tcp: Simplify error path in inet_csk_accept().
From: Kuniyuki Iwashima <kuniyu@google.com>
To: "David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, 
	Jakub Kicinski <kuba@kernel.org>, Neal Cardwell <ncardwell@google.com>, Paolo Abeni <pabeni@redhat.com>, 
	Willem de Bruijn <willemb@google.com>, Matthieu Baerts <matttbe@kernel.org>, 
	Mat Martineau <martineau@kernel.org>, Johannes Weiner <hannes@cmpxchg.org>, 
	Michal Hocko <mhocko@kernel.org>, Roman Gushchin <roman.gushchin@linux.dev>, 
	Shakeel Butt <shakeel.butt@linux.dev>, Andrew Morton <akpm@linux-foundation.org>, 
	"=?UTF-8?q?Michal=20Koutn=C3=BD?=" <mkoutny@suse.com>, Tejun Heo <tj@kernel.org>
Cc: Simon Horman <horms@kernel.org>, Geliang Tang <geliang@kernel.org>, 
	Muchun Song <muchun.song@linux.dev>, Mina Almasry <almasrymina@google.com>, 
	Kuniyuki Iwashima <kuniyu@google.com>, Kuniyuki Iwashima <kuni1840@gmail.com>, netdev@vger.kernel.org, 
	mptcp@lists.linux.dev, cgroups@vger.kernel.org, linux-mm@kvack.org
Content-Type: text/plain; charset="UTF-8"

When an error occurs in inet_csk_accept(), what we should do is
only call release_sock() and set the errno to arg->err.

But the path jumps to another label, which introduces unnecessary
initialisation and tests for newsk.

Let's simplify the error path and remove the redundant NULL
checks for newsk.

Signed-off-by: Kuniyuki Iwashima <kuniyu@google.com>
Reviewed-by: Eric Dumazet <edumazet@google.com>
---
 net/ipv4/inet_connection_sock.c | 15 +++++++--------
 1 file changed, 7 insertions(+), 8 deletions(-)

diff --git a/net/ipv4/inet_connection_sock.c b/net/ipv4/inet_connection_sock.c
index 1e2df51427fe..724bd9ed6cd4 100644
--- a/net/ipv4/inet_connection_sock.c
+++ b/net/ipv4/inet_connection_sock.c
@@ -706,9 +706,9 @@ struct sock *inet_csk_accept(struct sock *sk, struct proto_accept_arg *arg)
 		spin_unlock_bh(&queue->fastopenq.lock);
 	}
 
-out:
 	release_sock(sk);
-	if (newsk && mem_cgroup_sockets_enabled) {
+
+	if (mem_cgroup_sockets_enabled) {
 		gfp_t gfp = GFP_KERNEL | __GFP_NOFAIL;
 		int amt = 0;
 
@@ -732,18 +732,17 @@ struct sock *inet_csk_accept(struct sock *sk, struct proto_accept_arg *arg)
 
 		release_sock(newsk);
 	}
+
 	if (req)
 		reqsk_put(req);
 
-	if (newsk)
-		inet_init_csk_locks(newsk);
-
+	inet_init_csk_locks(newsk);
 	return newsk;
+
 out_err:
-	newsk = NULL;
-	req = NULL;
+	release_sock(sk);
 	arg->err = error;
-	goto out;
+	return NULL;
 }
 EXPORT_SYMBOL(inet_csk_accept);
 
-- 
2.51.0.rc0.205.g4a044479a3-goog


