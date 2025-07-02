Return-Path: <netdev+bounces-203539-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 6D4A3AF6559
	for <lists+netdev@lfdr.de>; Thu,  3 Jul 2025 00:37:31 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id CAA2652330A
	for <lists+netdev@lfdr.de>; Wed,  2 Jul 2025 22:37:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 86C03248F5F;
	Wed,  2 Jul 2025 22:36:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="MEQwxRGD"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pj1-f73.google.com (mail-pj1-f73.google.com [209.85.216.73])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E1B322F5C2F
	for <netdev@vger.kernel.org>; Wed,  2 Jul 2025 22:36:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.73
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751495772; cv=none; b=AHus+nzLTzsPCBJPsHZvI3dwLISL6gogvi866zZu3t9mtPCfT5CSZ7yYoJkad4W6uXh4OXLiw/eXefvLDWpWVQ65tZWPJYaXzufH2vYnk/eTgL2qv+rb7+yXPt0i8RtVRFNBNRED9RLEj/3wxvmcd+aAOxt1BLycuMi8E+nyuqM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751495772; c=relaxed/simple;
	bh=UW+SQEj8aN0Ft10n8URP7n2D3XO+nurfejv8kglxm5U=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=eKSImdlwlm3aeL3hJlNSO4c3FpNci7U6r2Ty+7LPaOt1IGEUrn+SyJsrdIYj/MbSInnwNQpqrthx5uLCJwnGhETQYZXHzFyDhTMTEPkoKtEIrKI4Cz6zapTYczLNFquyFw6vpKrDb5bMfx42k2MLkrRTGo1SUBp8tzr8gmYtD4Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--kuniyu.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=MEQwxRGD; arc=none smtp.client-ip=209.85.216.73
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--kuniyu.bounces.google.com
Received: by mail-pj1-f73.google.com with SMTP id 98e67ed59e1d1-311d670ad35so4401178a91.3
        for <netdev@vger.kernel.org>; Wed, 02 Jul 2025 15:36:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1751495770; x=1752100570; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=uy4qEEDdx3wsd0+Zkpw4ox1GIS+aP/bDinXUKsJxlf0=;
        b=MEQwxRGDb9XD6MmxWwueYTHUfnz7ZpkYyESmNDSywrKS820kfGcvq3w4h3Y6C5/XEN
         tEVq43nZijpovEi9vC7jOHpKeanvIXIvJ9ESEDV42m9y2UP6YVm236PXp9aS53Pxlv5+
         8ctqI/Iuuao9VKoU8WO+t2PsaEo0uIF6KFvx/EQL/GZNKiiAm6iwvAj0ackKVTph7W0i
         ELt5MyDR1LO2O8pfBtQoHyEfLgSM0YOpqEtRqHlDlnOFuxbGT2XmG5Ozy25W1NTGAmOJ
         /DlyTa58wjf7lo3f4iQ1oXMbrIKIy1jHLCueu4ORfsV8nGl3fWWHo9iVdjF8MXnOsPZ5
         YS3g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1751495770; x=1752100570;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=uy4qEEDdx3wsd0+Zkpw4ox1GIS+aP/bDinXUKsJxlf0=;
        b=VfYOsO/aGFUe6xUjLK2wPLb+6ejGOm+oA391rQKhySKZ2BLhyxL+FGOoYlzY8t5h1T
         MfV17zsTq9F5dgiHYvhjXlwZUVQTbr6K6vq4wM2QbRsWWlRkaZ9Fijk0WNJOGntiCyTx
         RNIk4BkEJPg//e89guZ0RniYZnfz89lzvEDDMugkXgDXK7MRcofFxrqNvNNtkAK/+iss
         zFV9G7YoRnoCp+LCzGdqJwAYdb0RTfhI9DN8cYi0DHnkWjzr8o+NWRkbexIF3Nr88Y4+
         bb1lDt6YSKnyysIQDtkz3b9qge1gDs8i7CzAYqpPoFPHsGOY9H6cksQ8brUwdradW4cA
         s2kA==
X-Forwarded-Encrypted: i=1; AJvYcCVVu8Bml/+1tvyMsSxzvpskMu8Rf4C/nvYYObH6Tqq6o+QOyIGyuyDm+IrBUMOgQmW8t699X4o=@vger.kernel.org
X-Gm-Message-State: AOJu0YzOPkvoFX5KO9scJS2+i41wyFpTBsTsSTAoBEmYnaVkGvq5wSie
	/7JS1VsdBZeboq0VFvkxRZ9/WsxFMrs/4EXKI+Z3GIsjg/xnH98FpGG9Htp04vocF+IZ6A0v73l
	MxOqahg==
X-Google-Smtp-Source: AGHT+IFZL7OfWcZxMF8jTIerCJ/5+HTstJCL8edR5B6lnSZevD47cNWlEc5DERAvpg8OQLiVQ8tjahab5sQ=
X-Received: from pjbkl12.prod.google.com ([2002:a17:90b:498c:b0:311:c5d3:c7d0])
 (user=kuniyu job=prod-delivery.src-stubby-dispatcher) by 2002:a17:90b:58c7:b0:311:af8c:51cd
 with SMTP id 98e67ed59e1d1-31a90bd4921mr7870476a91.18.1751495770236; Wed, 02
 Jul 2025 15:36:10 -0700 (PDT)
Date: Wed,  2 Jul 2025 22:35:13 +0000
In-Reply-To: <20250702223606.1054680-1-kuniyu@google.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20250702223606.1054680-1-kuniyu@google.com>
X-Mailer: git-send-email 2.50.0.727.gbf7dc18ff4-goog
Message-ID: <20250702223606.1054680-2-kuniyu@google.com>
Subject: [PATCH v1 net-next 1/7] af_unix: Don't hold unix_state_lock() in __unix_dgram_recvmsg().
From: Kuniyuki Iwashima <kuniyu@google.com>
To: "David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, 
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>
Cc: Simon Horman <horms@kernel.org>, Kuniyuki Iwashima <kuniyu@google.com>, 
	Kuniyuki Iwashima <kuni1840@gmail.com>, netdev@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

When __skb_try_recv_datagram() returns NULL in __unix_dgram_recvmsg(),
we hold unix_state_lock() unconditionally.

This is because SOCK_SEQPACKET sk needs to return EOF in case its peer
has been close()d concurrently.

This behaviour totally depends on the timing of the peer's close() and
reading sk->sk_shutdown, and taking the lock does not play a role.

Let's drop the lock from __unix_dgram_recvmsg() and use READ_ONCE().

Signed-off-by: Kuniyuki Iwashima <kuniyu@google.com>
---
 net/unix/af_unix.c | 4 +---
 1 file changed, 1 insertion(+), 3 deletions(-)

diff --git a/net/unix/af_unix.c b/net/unix/af_unix.c
index 564c970d97ff..1fa232ff4a2e 100644
--- a/net/unix/af_unix.c
+++ b/net/unix/af_unix.c
@@ -2528,12 +2528,10 @@ int __unix_dgram_recvmsg(struct sock *sk, struct msghdr *msg, size_t size,
 					      &err, &timeo, last));
 
 	if (!skb) { /* implies iolock unlocked */
-		unix_state_lock(sk);
 		/* Signal EOF on disconnected non-blocking SEQPACKET socket. */
 		if (sk->sk_type == SOCK_SEQPACKET && err == -EAGAIN &&
-		    (sk->sk_shutdown & RCV_SHUTDOWN))
+		    (READ_ONCE(sk->sk_shutdown) & RCV_SHUTDOWN))
 			err = 0;
-		unix_state_unlock(sk);
 		goto out;
 	}
 
-- 
2.50.0.727.gbf7dc18ff4-goog


