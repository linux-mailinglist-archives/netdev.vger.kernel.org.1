Return-Path: <netdev+bounces-208684-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id CFA11B0CBEF
	for <lists+netdev@lfdr.de>; Mon, 21 Jul 2025 22:36:58 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 602FC7A8A87
	for <lists+netdev@lfdr.de>; Mon, 21 Jul 2025 20:35:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BE70623E35D;
	Mon, 21 Jul 2025 20:36:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="ea1FtPpI"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pf1-f202.google.com (mail-pf1-f202.google.com [209.85.210.202])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4B6B623E33A
	for <netdev@vger.kernel.org>; Mon, 21 Jul 2025 20:36:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.202
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753130193; cv=none; b=bDqfkklPr3NmDUcYZ9+AOPK5BRJYZdkaDcQ6VL5Q7sBGjeqTlK0W22r2KkEyu4InSdkCl0pO1ByvZLYlVsw5lulS6VpKrcOA7FFOgJrSZNc4TRBSDyR/KgSwlRVHPqXs5L7qfTDgR4L5C18OOvIDJBUr2z2Cl0N9/oTeSVnCMZk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753130193; c=relaxed/simple;
	bh=j5N4aCPTqWCMs7i3WRNZ2KVBnmcFjVWd2rdC7aOLvuw=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=TP5F+4BxLK5rQplJwPoAcL+BCHFjwfnspc6FJu8UJgpOFxIP4uJYyhFuFs2ORj/p25wvU6Dk7WNcJMXY/Al31S7A3Da4ew1Bc/bX7rAw4YcdHHcmMpqr+/cjY0PgFd2aTw+/8LNhHnobVEOHnOSmEVpaA67o8HUFg/3FCQbzAP8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--kuniyu.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=ea1FtPpI; arc=none smtp.client-ip=209.85.210.202
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--kuniyu.bounces.google.com
Received: by mail-pf1-f202.google.com with SMTP id d2e1a72fcca58-74ad608d60aso3824741b3a.1
        for <netdev@vger.kernel.org>; Mon, 21 Jul 2025 13:36:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1753130192; x=1753734992; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=Wpwn6QQouhXynO23Cu972bLk01/99pIHsLHoJU/mo78=;
        b=ea1FtPpITkrSIjQirmHVb2WAE99kj30nCDyAGGKtDUMnRx+RJTufKBhOzZde8Ouax2
         ftfziuAEjG+HiLEAUfnMpwlbSSxlaf0Ub0iMXbZmd2cqr4bJ50OCNAuxPKNebsiqTAvK
         zOOQLwcm+arCJJBTHl9Xodk3Z5ugmMPcoanUUGeT+D2ZZpFBxXIk/SrmiByp8ifLmgy0
         8t5U+PI6s5JQ6HGLdACXFUr6GmJWStLHufspg6mRHqi28go2vMC/eIw0I5/gxCIIalD8
         CepTeeUjrnYIhq8vvreCPB+CjTHxTESakrN+MySHEJfHPPyr+QXCCgaCCa0PTnKRkWxK
         vqTA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1753130192; x=1753734992;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=Wpwn6QQouhXynO23Cu972bLk01/99pIHsLHoJU/mo78=;
        b=n7JsFDBfJy4+HgorCgeGUfvGHRDZzmvlUsSehqduk8nIccGNTWmowqxJfJE0X7LlEl
         V/Qt+QNMQGC+XAxCM/KmLVF4ADkgMlk2VQh0qwXcCrN1kmrAXKrf3qZZsSMzqsDAo5xm
         iDa2RZyGwFP1R7oKsVtCuJj84YxdST8GyrJviyKtFdSikbSBzc9UlL4IPxnpwuJpZjVt
         InEuJgJ6Ffn7HKBW3n71mcsDyIP6rDtEDprATuXaPMS68c+K+vC0ZEnXofrok3UH00SG
         g11YGi/3k1SoTGtqWfY1a74gU9U/k6pu0RkMogtNGS9FXtz15RhZF/NLvYbRBSPZEqhF
         +/2w==
X-Forwarded-Encrypted: i=1; AJvYcCVk+mGrxrxm3kGTMZ3veS3nrZDdVaG2XB3CFZgMFAx2Qbn7leV0JTkyLn4j9Bhu6TahVRXemfc=@vger.kernel.org
X-Gm-Message-State: AOJu0YwQiOIPQd6fJ1mfSwsRatEteKzLzBD17l2Cw9b2DwIiLsgR+Hbu
	2eF2ufLfGKVriqdV73DjqkM7hU7h7EpwN9OoN5K1x5u0+i5ZuftwahLvJh/AUOtYixLbeDYqQRP
	boTCLVA==
X-Google-Smtp-Source: AGHT+IGOSqwwC3mh3GOf+Pwdhi6WvfqKoRK+i/P5LIuBAbC+/yAfslPdXIv1OdhrmQiErVu217W2zT+wZxQ=
X-Received: from pfbml3.prod.google.com ([2002:a05:6a00:3d83:b0:748:e00c:4e66])
 (user=kuniyu job=prod-delivery.src-stubby-dispatcher) by 2002:a05:6a20:7d9f:b0:232:7c7b:1c7b
 with SMTP id adf61e73a8af0-23810d50911mr35590008637.14.1753130191720; Mon, 21
 Jul 2025 13:36:31 -0700 (PDT)
Date: Mon, 21 Jul 2025 20:35:22 +0000
In-Reply-To: <20250721203624.3807041-1-kuniyu@google.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20250721203624.3807041-1-kuniyu@google.com>
X-Mailer: git-send-email 2.50.0.727.gbf7dc18ff4-goog
Message-ID: <20250721203624.3807041-4-kuniyu@google.com>
Subject: [PATCH v1 net-next 03/13] tcp: Simplify error path in inet_csk_accept().
From: Kuniyuki Iwashima <kuniyu@google.com>
To: "David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, 
	Jakub Kicinski <kuba@kernel.org>, Neal Cardwell <ncardwell@google.com>, Paolo Abeni <pabeni@redhat.com>, 
	Willem de Bruijn <willemb@google.com>, Matthieu Baerts <matttbe@kernel.org>, 
	Mat Martineau <martineau@kernel.org>, Johannes Weiner <hannes@cmpxchg.org>, 
	Michal Hocko <mhocko@kernel.org>, Roman Gushchin <roman.gushchin@linux.dev>, 
	Shakeel Butt <shakeel.butt@linux.dev>, Andrew Morton <akpm@linux-foundation.org>
Cc: Simon Horman <horms@kernel.org>, Geliang Tang <geliang@kernel.org>, 
	Muchun Song <muchun.song@linux.dev>, Kuniyuki Iwashima <kuniyu@google.com>, 
	Kuniyuki Iwashima <kuni1840@gmail.com>, netdev@vger.kernel.org, mptcp@lists.linux.dev, 
	cgroups@vger.kernel.org, linux-mm@kvack.org
Content-Type: text/plain; charset="UTF-8"

When an error occurs in inet_csk_accept(), what we should do is
only call release_sock() and set the errno to arg->err.

But the path jumps to another label, which introduces unnecessary
initialisation and tests for newsk.

Let's simplify the error path and remove the redundant NULL
checks for newsk.

Signed-off-by: Kuniyuki Iwashima <kuniyu@google.com>
---
 net/ipv4/inet_connection_sock.c | 15 +++++++--------
 1 file changed, 7 insertions(+), 8 deletions(-)

diff --git a/net/ipv4/inet_connection_sock.c b/net/ipv4/inet_connection_sock.c
index 1e2df51427fed..724bd9ed6cd48 100644
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
2.50.0.727.gbf7dc18ff4-goog


