Return-Path: <netdev+bounces-231885-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 343F4BFE464
	for <lists+netdev@lfdr.de>; Wed, 22 Oct 2025 23:17:54 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 260AE3A86C5
	for <lists+netdev@lfdr.de>; Wed, 22 Oct 2025 21:17:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B79C430215A;
	Wed, 22 Oct 2025 21:17:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="HfawnsO3"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pj1-f73.google.com (mail-pj1-f73.google.com [209.85.216.73])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2FB6A2798FA
	for <netdev@vger.kernel.org>; Wed, 22 Oct 2025 21:17:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.73
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761167849; cv=none; b=tokTE4K46Gcwq1Tc4oZLMgwNNqKVXidgcG93+x80OQCFDKiK+We9hyamZgXTQDxgrYTNAqbzk0wYRN3m5bufnJffLklXXZr8mnDk4UDDVPLyAof3o0nBbSfRpR3F/VXPaLfVdw4TE9xg5l+iemi974sLYVnsxFmW01J/L/mB8U0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761167849; c=relaxed/simple;
	bh=OI//fQhY6GrWZcEbV1qfJgwOYOHPWnMBLceuSeRu0zY=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=ua+bWvNec4kowwOgbl0ZmpiqgSkgAyMOLPMe5SvRUGZxYQUbVOrCj0QzbIXxux2qK6YyvmLh4jyzOslbDX3zOZAPoGppG6Xn92SPw/W+I1Q2WO5OPNKWYnTsm44vPROiAA+c78kLzUwnh6oH8BCkM5mj8huW9EKlJxKlyrzSq54=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--kuniyu.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=HfawnsO3; arc=none smtp.client-ip=209.85.216.73
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--kuniyu.bounces.google.com
Received: by mail-pj1-f73.google.com with SMTP id 98e67ed59e1d1-33bcb779733so68546a91.3
        for <netdev@vger.kernel.org>; Wed, 22 Oct 2025 14:17:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1761167847; x=1761772647; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=x2FlQaGpNmdYyCjDaF+cX7u2dk7mvT/GjpYgyYEIStQ=;
        b=HfawnsO3U9XRZptpEq3XNCLVmgP5AhWLk2Y6GLRGbujGUuQQ29uaeMOIH8ABgiJlq2
         8RDl2aaqNyesGZMi991QaXEgoXUA7dwHGPVMyIIhZibihcEfmQYMiqOOq6yxiZ0JkE9c
         +FSkzbU6v90PYP6Hte1xvX/1qla+tT8r1KClm46F6fBPrLSfW7P1vQzneXx3+i8GrNHa
         kvH6Ms1XxfSGC+sweHH3iSZV+RD8lBvpncd7BfnBBjvdeT4kzEqmTv3fO7RhAwiU1zV+
         YUkQ2tHTWJBge5DCGYKD0K3AS/Yy9MmHZvB3utmm79a8QFpuag/UL1aHsDGT3x6aoEJ8
         Hffg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1761167847; x=1761772647;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=x2FlQaGpNmdYyCjDaF+cX7u2dk7mvT/GjpYgyYEIStQ=;
        b=GXgiQCvyQNns3ACnLdlhkImsgamXPadzckMrB6aB6gVgX7UkjJzRQ5jSyENPW8a5j5
         OTbJ06SHGlgy6bKEb2aSIbrwexfbm52DuZQpVLqHEKJTIT9SNXLgjD8Wk4XfwLzH7MrQ
         fuVkyCIbFv40bE4rTQ61RaWvlsfUBWfzw9gVS8HA2/6aTFjDdmsR5BAJiHqrkHvAi5ML
         j2Fesk7s+r96A4V/2kgex46QCjoAgAV4eoeaeOlMxYDhG8XGPZIenld2JYOC2gu0UQnr
         cSRQh/tG+cpjUfAxvMtWUVA2Fde2htpMEHLb3Onu0FHpYojjPJvg0BFhoDafhe24qqKR
         3qtg==
X-Forwarded-Encrypted: i=1; AJvYcCVGfEMpJDkorZ82PuHzDUwfImFon4Q0RB1j6+YZMswqpGlQkmiKw2MHmQ4IWBok24q6Jz8ASiI=@vger.kernel.org
X-Gm-Message-State: AOJu0Yx+JHO0SIaalS4VxFR/pXUgSxKI3BLporWBI4262iy6LXlSJTdW
	cxBo/rsk6sf+uzL4H2Z8k19Y29rIF1lCM7qKdZ1IXv5BS6qwYG3IWHaJRTnbHSWZ3yGHmncoh5w
	GQAJ0Hw==
X-Google-Smtp-Source: AGHT+IEqCWncMKW63ViAefeXIG8huhYzveq16ITZnOEt6ymZcmRtkiVJaC0gBCk+W5U19OSFwJwnartQvRI=
X-Received: from pjbft22.prod.google.com ([2002:a17:90b:f96:b0:32e:d644:b829])
 (user=kuniyu job=prod-delivery.src-stubby-dispatcher) by 2002:a17:90b:4c4e:b0:32e:6019:5d19
 with SMTP id 98e67ed59e1d1-33bcf921526mr26449310a91.34.1761167847410; Wed, 22
 Oct 2025 14:17:27 -0700 (PDT)
Date: Wed, 22 Oct 2025 21:17:02 +0000
In-Reply-To: <20251022211722.2819414-1-kuniyu@google.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20251022211722.2819414-1-kuniyu@google.com>
X-Mailer: git-send-email 2.51.1.814.gb8fa24458f-goog
Message-ID: <20251022211722.2819414-3-kuniyu@google.com>
Subject: [PATCH v2 net-next 2/8] sctp: Don't copy sk_sndbuf and sk_rcvbuf in sctp_sock_migrate().
From: Kuniyuki Iwashima <kuniyu@google.com>
To: Marcelo Ricardo Leitner <marcelo.leitner@gmail.com>, Xin Long <lucien.xin@gmail.com>, 
	"David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, 
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>
Cc: Simon Horman <horms@kernel.org>, Kuniyuki Iwashima <kuniyu@google.com>, 
	Kuniyuki Iwashima <kuni1840@gmail.com>, netdev@vger.kernel.org, linux-sctp@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

sctp_sock_migrate() is called from 2 places.

1) sctp_accept() calls sp->pf->create_accept_sk() before
   sctp_sock_migrate(), and sp->pf->create_accept_sk() calls
   sctp_copy_sock().

2) sctp_do_peeloff() also calls sctp_copy_sock() before
   sctp_sock_migrate().

sctp_copy_sock() copies sk_sndbuf and sk_rcvbuf from the
parent socket.

Let's not copy the two fields in sctp_sock_migrate().

Signed-off-by: Kuniyuki Iwashima <kuniyu@google.com>
---
 net/sctp/socket.c | 7 ++-----
 1 file changed, 2 insertions(+), 5 deletions(-)

diff --git a/net/sctp/socket.c b/net/sctp/socket.c
index d190e75e4645..735b1222af95 100644
--- a/net/sctp/socket.c
+++ b/net/sctp/socket.c
@@ -9523,12 +9523,9 @@ static int sctp_sock_migrate(struct sock *oldsk, struct sock *newsk,
 	struct sctp_bind_hashbucket *head;
 	int err;
 
-	/* Migrate socket buffer sizes and all the socket level options to the
-	 * new socket.
+	/* Migrate all the socket level options to the new socket.
+	 * Brute force copy old sctp opt.
 	 */
-	newsk->sk_sndbuf = oldsk->sk_sndbuf;
-	newsk->sk_rcvbuf = oldsk->sk_rcvbuf;
-	/* Brute force copy old sctp opt. */
 	sctp_copy_descendant(newsk, oldsk);
 
 	/* Restore the ep value that was overwritten with the above structure
-- 
2.51.1.814.gb8fa24458f-goog


