Return-Path: <netdev+bounces-198888-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 3E2BAADE299
	for <lists+netdev@lfdr.de>; Wed, 18 Jun 2025 06:35:20 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 9ECB717B988
	for <lists+netdev@lfdr.de>; Wed, 18 Jun 2025 04:35:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5B26D1E0DFE;
	Wed, 18 Jun 2025 04:35:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="NTs6EGmQ"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pl1-f178.google.com (mail-pl1-f178.google.com [209.85.214.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C22021F0E56
	for <netdev@vger.kernel.org>; Wed, 18 Jun 2025 04:35:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750221304; cv=none; b=IvsVKLrTY4IQUZwLtJ+3RY+LfIRK1PFyscf0opad5s/IveOkq/7QbxBfACFiUM1ZvlJznfiS3TG8O0nA8B2ot0I/ZknGjDN2YvzsZPR22w9ExCZgPXsNrw5qwHGE6fHIpmTBwA9TjjQcBB0JMKqhyoEfGLRDnMZ3Rz70cN/lcOU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750221304; c=relaxed/simple;
	bh=hBAs4eXD7JOb+VVr8UCxFdUd7AGTkpC8dNMuSGkDGBQ=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=UaAGFLO7Jl4W9pb0OmCMq56GBY6PdZBhxvyWtIrqFDxCakEm28XbY1m3v7gQpBeEWT95zQkV66u45vdnxe/lmlQuf33wi4zH814jiFx0OZTIgJMixW/Kb7WHuwExgVXiIE/A6vZBV1R/phP0mtaJBDX2qnjDjX7q9BlFyQaKnQg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=NTs6EGmQ; arc=none smtp.client-ip=209.85.214.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f178.google.com with SMTP id d9443c01a7336-234c5b57557so62894815ad.3
        for <netdev@vger.kernel.org>; Tue, 17 Jun 2025 21:35:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1750221302; x=1750826102; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ufS4wFreNDr1KeLdKKjA5WaZlO3fzw/o+dtgZkmAlFQ=;
        b=NTs6EGmQtsaVq2VcFtRERJXHieWkwFz6a3N+VwKGN5zYQjbaEcxIGye5hRp6gdlzI7
         G74MahBghD1eP4KK+kXazcfbHk2GYAbwyq5P4vgp3kvUY07mvJomxxgPaFKLix4tkR1b
         iXBAOjmikRcHrIpqBI9KBHm6zX217xHM2EByGblrD+9HPbGp5vuKJdLjHhaz5Le409AM
         hMXZ1PZqSpLkbSh6p4GRGp4+RsYfHXKOa9/VAqwSiP2xD20nCD+0gOryLnILqWvd+UlV
         SgI2Pn5y2eRrJhNKSz7kJlEbZI4K8ijO9GNRMpDKnI5Ucur/OwZFHOcxB4nVcTRLiwov
         cBBg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1750221302; x=1750826102;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=ufS4wFreNDr1KeLdKKjA5WaZlO3fzw/o+dtgZkmAlFQ=;
        b=w3erDGhOlx0dH0EyrBokaaNwIXOhojdxoc3yUCCRWlhHzEAEqQUh7gLQmkvVlT1QOz
         to9+/zwDsHJ7qyZYSilt7sPYcgUkvp7dDESQVq8yeB0SsouSY3dvdEYsk9g5A6XYfjEn
         6jsgeZ47Aj/7BjKJ6uuFcGM0WGj1nQNa4s3LXnbFNexJfSpSe1Tc8lLr8mvyhhnrjwRG
         gAnZzSH2WaI6ApY8jCTpxwVHzjkG3af5//ZNbbNyQzh/Hi79wyBMn86md12OlX0lNAlq
         8AWNuCLXceJ6BSR9vIHVkD0zdm6bU7B6wJ6V9hhlGdz8DqJwC48TnA9eUco058PXZGUg
         mqrw==
X-Forwarded-Encrypted: i=1; AJvYcCWMXRMXA/1QrOfZy6zH8DOtS5XLp9joiffXtJlI51QzKpNROSagwuN5oDQYletnIcYB1y8z/dY=@vger.kernel.org
X-Gm-Message-State: AOJu0Yyt8r8X7q8j1va+MHg3s2iknl6/+4smulibVqTzgNeiMhHX+uNu
	OE0ET5nViMKHLGMaJJcVUsranAYv4lmyhz2y+wGRpdnjaw+QEGa6q9Y=
X-Gm-Gg: ASbGncu0+yQEJZFFVI5cPyo8j53cZ3lSo6goZpuUHwQPCvEcj6HFReXnaS/jiGA7zjb
	z1pWqDjsBQd8RVaSd3pCUXkrXziPVpd2fXdb049iwNMgXNktdgiqhnL0mS6bhh2DsIE4X9dCO1U
	LvcCzwR6pPOH+A9jNXdcK1d1SzOd2IqDtKO+fN5fzyUauuOnDTWNYrO//9nF1AqEFrHLaBu+yTz
	ZjkQGYpaH5RmSzU03G+zsMVWlfQyKyMEdZCvXcJa9tEpodkWvrPtKDGZlc5cqX9iLzyG6FvM7aZ
	KfTSmqv6mp1/EMXHCAUtfJZwWF5w0Ikz81DhQQI=
X-Google-Smtp-Source: AGHT+IG25mmG1hHxx/V1pawuD1R4OGeiensr6b5OQIYz3yeO5DdS1hbSaHxyhKkhWBgs7M/cdCMZog==
X-Received: by 2002:a17:902:c94a:b0:235:225d:30a2 with SMTP id d9443c01a7336-2366b3fb77bmr216234755ad.48.1750221301961;
        Tue, 17 Jun 2025 21:35:01 -0700 (PDT)
Received: from fedora.. ([2601:647:6700:3390::c8d1])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2365de77610sm90072225ad.135.2025.06.17.21.35.00
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 17 Jun 2025 21:35:01 -0700 (PDT)
From: Kuniyuki Iwashima <kuni1840@gmail.com>
To: "David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>
Cc: Simon Horman <horms@kernel.org>,
	Kuniyuki Iwashima <kuniyu@google.com>,
	Kuniyuki Iwashima <kuni1840@gmail.com>,
	netdev@vger.kernel.org,
	Christian Brauner <brauner@kernel.org>
Subject: [PATCH v1 net 3/4] af_unix: Don't set -ECONNRESET for consumed OOB skb.
Date: Tue, 17 Jun 2025 21:34:41 -0700
Message-ID: <20250618043453.281247-4-kuni1840@gmail.com>
X-Mailer: git-send-email 2.49.0
In-Reply-To: <20250618043453.281247-1-kuni1840@gmail.com>
References: <20250618043453.281247-1-kuni1840@gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Kuniyuki Iwashima <kuniyu@google.com>

Christian Brauner reported that even after MSG_OOB data is consumed,
calling close() on the receiver socket causes the peer's recv() to
return -ECONNRESET:

  1. send() and recv() an OOB data.

    >>> from socket import *
    >>> s1, s2 = socketpair(AF_UNIX, SOCK_STREAM)
    >>> s1.send(b'x', MSG_OOB)
    1
    >>> s2.recv(1, MSG_OOB)
    b'x'

  2. close() for s2 sets ECONNRESET to s1->sk_err even though
     s2 consumed the OOB data

    >>> s2.close()
    >>> s1.recv(10, MSG_DONTWAIT)
    ...
    ConnectionResetError: [Errno 104] Connection reset by peer

Even after being consumed, the skb holding the OOB 1-byte data stays in
the recv queue to mark the OOB boundary and break recv() at that point.

This must be considered while close()ing a socket.

Let's free the leading consumed OOB skb before checking the -ECONNRESET
condition in unix_release_sock().

Fixes: 314001f0bf92 ("af_unix: Add OOB support")
Reported-by: Christian Brauner <brauner@kernel.org>
Closes: https://lore.kernel.org/netdev/20250529-sinkt-abfeuern-e7b08200c6b0@brauner/
Signed-off-by: Kuniyuki Iwashima <kuniyu@google.com>
---
 net/unix/af_unix.c | 16 +++++++++++-----
 1 file changed, 11 insertions(+), 5 deletions(-)

diff --git a/net/unix/af_unix.c b/net/unix/af_unix.c
index 5392aa53cbc8..50e56365f4f6 100644
--- a/net/unix/af_unix.c
+++ b/net/unix/af_unix.c
@@ -660,6 +660,11 @@ static void unix_sock_destructor(struct sock *sk)
 #endif
 }
 
+static unsigned int unix_skb_len(const struct sk_buff *skb)
+{
+	return skb->len - UNIXCB(skb).consumed;
+}
+
 static void unix_release_sock(struct sock *sk, int embrion)
 {
 	struct unix_sock *u = unix_sk(sk);
@@ -687,6 +692,12 @@ static void unix_release_sock(struct sock *sk, int embrion)
 	unix_state_unlock(sk);
 
 #if IS_ENABLED(CONFIG_AF_UNIX_OOB)
+	skb = skb_peek(&sk->sk_receive_queue);
+	if (skb && !unix_skb_len(skb)) {
+		__skb_unlink(skb, &sk->sk_receive_queue);
+		consume_skb(skb);
+	}
+
 	u->oob_skb = NULL;
 #endif
 
@@ -2661,11 +2672,6 @@ static long unix_stream_data_wait(struct sock *sk, long timeo,
 	return timeo;
 }
 
-static unsigned int unix_skb_len(const struct sk_buff *skb)
-{
-	return skb->len - UNIXCB(skb).consumed;
-}
-
 struct unix_stream_read_state {
 	int (*recv_actor)(struct sk_buff *, int, int,
 			  struct unix_stream_read_state *);
-- 
2.49.0


