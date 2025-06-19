Return-Path: <netdev+bounces-199311-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 84630ADFC45
	for <lists+netdev@lfdr.de>; Thu, 19 Jun 2025 06:15:22 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 390583A5A18
	for <lists+netdev@lfdr.de>; Thu, 19 Jun 2025 04:14:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D555323FC66;
	Thu, 19 Jun 2025 04:15:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="BgdoGCd3"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pl1-f176.google.com (mail-pl1-f176.google.com [209.85.214.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 433B523C8D3
	for <netdev@vger.kernel.org>; Thu, 19 Jun 2025 04:15:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.176
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750306506; cv=none; b=qAJfQXjdPmMx1PWUuZ0uiGa3VOCNXjj5hSqAwCC/p7HIZs41fa1eU98p4ergR2+174rEmd4zitxSkDDow91ns4pNvgOM9vXOuPkIKonzbF0NFU3zrmCY1ebofULmhB2+z/Izcv7vMinD9CP6WNZPTltAijk5SEq3nDK4h2G0zvw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750306506; c=relaxed/simple;
	bh=WOW+IcvKRf8NdohDkP9/glJ/rBV11AS6HhK0qNUM5n8=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=M/BJVP1hitFfkjEL76vXa0lLH5Vfrhn2rBwPcd+1yxjf+cgW/6HwszaETiwiQrsPzUp/amuHX8eh3J9lVFNhjO+jpKA4Kdlo5/fQll5zHlZqbd8rOMZRxWnB3+uhq48CLQZFO+pQabvj4K1rS0FXWunK4Vk1owwq5ckgJ0t599A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=BgdoGCd3; arc=none smtp.client-ip=209.85.214.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f176.google.com with SMTP id d9443c01a7336-2349f096605so5991635ad.3
        for <netdev@vger.kernel.org>; Wed, 18 Jun 2025 21:15:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1750306504; x=1750911304; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=2T9rVvE0y3DiAREEbh/zZLGN/zuAcPPrenN9RIAORG8=;
        b=BgdoGCd3mdsWifj5rLGy7hQKj0zYnon8m60ZKh+JmN3kBT01H43sym6cqmbiVldLpi
         InJ8HkN5THtye7ukhXZKt6jDKwQAZP4e3acWS/R7cvcKVqodOpjdOSANcFNhiuGg3r02
         sIPMev9n77sW42DD0D8vCVjUxGSl0XRdGIpDPnpKkkS6L6/T94I2QD9i3daOk/hCaDXN
         hFVMrDTqn/jZfH2eR3CDtAYhYJp58K67++JPvBavSHDWsvY9hmFVyXHQj3BTQ5uhbcoB
         JRicrJ+lAsBX7cLHepc0F0mIjVLPxiQww11eYmDbNfU0rmto166VluyxtOZNv8i3s/FI
         n61g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1750306504; x=1750911304;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=2T9rVvE0y3DiAREEbh/zZLGN/zuAcPPrenN9RIAORG8=;
        b=i/VHcEeVchh4BqiNxlyxKOOcSqk112ooa8ZQPwq56uhQ/GRCQc6AJkHan/7SL0PWvL
         DRDtsIINd4XKYDNBxzyAFX3sVPry2W5jVAA0XNWkygLuEYfMpchGtJyNu6YsB6iS4Je6
         pEGOrVDkHER4AvTj7ngJ/PKrdsxhs0JW2jrThOil+tjDVVifRmSbD1vOCMb0av9nGcmL
         aybbzVWHGvURlU1yA9IjPfVowE5iEyx7raVN44QQYXfQwrxwNrhiMInoWLy9Son2XYko
         R7dH7eTXU3ogFPLMhFMi/mZd/izUDb5PozjwyY1Yzzy9rR3fiygNAzXqvO5lEnXuwXpD
         JzNQ==
X-Forwarded-Encrypted: i=1; AJvYcCWXytu+ceRk4Phk5Om81u56p+yDi4EJIB3BD6O8nmCDsYv5NsdSXR/8JWyjkt7t0Ipjkk6pLB4=@vger.kernel.org
X-Gm-Message-State: AOJu0Yw0TMegZscDNcDTW82Tw5KNODmZUFUyYE6Pj3gdEJ7rWDM7hdnA
	TQoMlNO2Nf1kn8ufhwAS//FQmNLcneAZE7eFwOw3If388/8a8vi4W9s=
X-Gm-Gg: ASbGncurlsOIH5ZZlHP9mJ57dLUpRwAom3cHj8RAXx3hBFkrLDhIUBNSmtL12Hy6bjD
	1xs4+plXyzGcswm9GFWA4u2q1J3ueKIduP93uJf1DknDFn+CB1Vpq30eGTQ4zUn39ZvVnuJZPxS
	ok++hP2Bp5oILbyps2iD3CWcEXbsXSEL7ZAHtHmxoLxRjzYJS8pSrSrCR53P1jjFVOqNF8z5nmI
	zBpX0qsZP5Caa4QVB9KxtqHHYTX00bHbHtLwDPQRfEolb1Oqz275TuA/SYGgbjW1eq549DHf6gf
	q5VllD8TFpJmONK2geSXwY1GHGAVioQ62P1sb8U=
X-Google-Smtp-Source: AGHT+IEYEUpO2tcAFhZ2JqJRg+yp3Q+36N/i4XGnooIn9FJlZdxCQt3hc4D5/cWd1iRNjO4YpCZVBQ==
X-Received: by 2002:a17:903:b88:b0:234:8f5d:e3bd with SMTP id d9443c01a7336-2366b3c353amr314508615ad.39.1750306504548;
        Wed, 18 Jun 2025 21:15:04 -0700 (PDT)
Received: from fedora.. ([2601:647:6700:3390::c8d1])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2365de781b1sm109928585ad.89.2025.06.18.21.15.03
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 18 Jun 2025 21:15:04 -0700 (PDT)
From: Kuniyuki Iwashima <kuni1840@gmail.com>
To: "David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>
Cc: Simon Horman <horms@kernel.org>,
	Rao Shoaib <rao.shoaib@oracle.com>,
	Kuniyuki Iwashima <kuniyu@google.com>,
	Kuniyuki Iwashima <kuni1840@gmail.com>,
	netdev@vger.kernel.org,
	Christian Brauner <brauner@kernel.org>
Subject: [PATCH v2 net 3/4] af_unix: Don't set -ECONNRESET for consumed OOB skb.
Date: Wed, 18 Jun 2025 21:13:57 -0700
Message-ID: <20250619041457.1132791-4-kuni1840@gmail.com>
X-Mailer: git-send-email 2.49.0
In-Reply-To: <20250619041457.1132791-1-kuni1840@gmail.com>
References: <20250619041457.1132791-1-kuni1840@gmail.com>
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

Let's skip the leading consumed OOB skb while checking the -ECONNRESET
condition in unix_release_sock().

Fixes: 314001f0bf92 ("af_unix: Add OOB support")
Reported-by: Christian Brauner <brauner@kernel.org>
Closes: https://lore.kernel.org/netdev/20250529-sinkt-abfeuern-e7b08200c6b0@brauner/
Signed-off-by: Kuniyuki Iwashima <kuniyu@google.com>
---
v2: Reuse the existing path for non-listener and skip the leading
    consumed OOB skb instead of freeing it

v1: https://lore.kernel.org/netdev/20250618043453.281247-1-kuni1840@gmail.com/
---
 net/unix/af_unix.c | 18 ++++++++++++------
 1 file changed, 12 insertions(+), 6 deletions(-)

diff --git a/net/unix/af_unix.c b/net/unix/af_unix.c
index 5392aa53cbc8..52b155123985 100644
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
@@ -694,10 +699,16 @@ static void unix_release_sock(struct sock *sk, int embrion)
 
 	if (skpair != NULL) {
 		if (sk->sk_type == SOCK_STREAM || sk->sk_type == SOCK_SEQPACKET) {
+			struct sk_buff *skb = skb_peek(&sk->sk_receive_queue);
+
+#if IS_ENABLED(CONFIG_AF_UNIX_OOB)
+			if (skb && !unix_skb_len(skb))
+				skb = skb_peek_next(skb, &sk->sk_receive_queue);
+#endif
 			unix_state_lock(skpair);
 			/* No more writes */
 			WRITE_ONCE(skpair->sk_shutdown, SHUTDOWN_MASK);
-			if (!skb_queue_empty_lockless(&sk->sk_receive_queue) || embrion)
+			if (skb || embrion)
 				WRITE_ONCE(skpair->sk_err, ECONNRESET);
 			unix_state_unlock(skpair);
 			skpair->sk_state_change(skpair);
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


