Return-Path: <netdev+bounces-132210-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D1A6B990F9F
	for <lists+netdev@lfdr.de>; Fri,  4 Oct 2024 22:04:17 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 9557E282C0D
	for <lists+netdev@lfdr.de>; Fri,  4 Oct 2024 20:04:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C2E321D8DEC;
	Fri,  4 Oct 2024 19:16:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="eIGPwlL6"
X-Original-To: netdev@vger.kernel.org
Received: from mail-yw1-f201.google.com (mail-yw1-f201.google.com [209.85.128.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3B1B41D89E3
	for <netdev@vger.kernel.org>; Fri,  4 Oct 2024 19:16:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728069411; cv=none; b=PxrpoGe+Ob54ujI+sw/5MrM5GLn51mPii64LJcTpAWb4HkKbH/XN46iZdVZAdcCvIIWhijPNM59m3TZED3i/JYoZ/o6Uy5YDphO6JUJrOGRdIWkO3DUXWJZLd3GpZ322remxl6laEYVf1X5EcB3NDSpy5ascE4GIPr5Rr7+IfHk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728069411; c=relaxed/simple;
	bh=rTCD9ejq9MFBN2es73b/PZLWoyvSmBIWX5nySeKvVHk=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=Pa8dSCCQleIEG8RVTI7ibxgSTqVN+Ai9Z2kHhYwlfn+S7bGTIzPBRRQk9f9r1TXVDVbdUuD0Jwqlq4ZwOTsmaXYxfVhvrmmvfW1+EbfvRqWzgH6DoyRtyQpZI1uShossMsEwBS1+C+bGfnYOyZKtk9j5kds6VOzPZfazi+HYFQI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--edumazet.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=eIGPwlL6; arc=none smtp.client-ip=209.85.128.201
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--edumazet.bounces.google.com
Received: by mail-yw1-f201.google.com with SMTP id 00721157ae682-6e2d1860a62so14320307b3.0
        for <netdev@vger.kernel.org>; Fri, 04 Oct 2024 12:16:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1728069409; x=1728674209; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=G/CDj+TbYDNeuPFKYt3YFNfSKaDL3LjUTUjPD2KZNno=;
        b=eIGPwlL6Qh8cfB37/tIlrsIRfYNEFQgAG+eDM7KIsaXDeKEIB4GK1IhXHIA2LRG34r
         +fxBuA01H0CwMud8tZBx217qvkpkTiuBVeXo9xfFQJ7iJyVr/Aq6ZX3bBJCF+tXDuwRD
         QDmHMDh96MlZuv0JZSk4LfXfM2RFhfVWSWJf6ycOdU06aYOOFCQqXtXVi8vEf7OOJP9h
         fo3DkZNL4BIngv5QJY+q/ayt6jQJ/WazibN446YNxMrL6WxmDcLoWr3fQXAfzTutXGdk
         etCNQpEACHpAEWFFQN1CsuKBqDS3LSWL/91vDTuH8KQcwOLRYhtkecYz2VA/xcp/HKT1
         JhZg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1728069409; x=1728674209;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=G/CDj+TbYDNeuPFKYt3YFNfSKaDL3LjUTUjPD2KZNno=;
        b=iRdNz1QG5akv/PMNNP/71Ys5D1pUk45wP9ReMLMjcohkDl6ksRLriQRo+W2G9tauTa
         +6A7W677y9IZkB/767X6WU3euNq3UPE/ARP7cpDnRW7WkF9OCLDH5iOLC9CHB9do4/Xk
         Y4OIbfrNWpvXUKOjUcWEQKShqGcD3jygsR1Im/F+80+Q6hAxxeKZVEy3uLIN6RmVziNq
         mK7rRLkuRoTkTB2+x2RLulSXyg9eT/QIuIQxZXmcKVhPF6gXdh54n5W9FSoKJviZEYBv
         q4M4IChM6pI7dmZ/bGhotte0/CgxVpskBdnUfRw6UXV+sNyCAH3dDDrns2wSrdHIb9JI
         OGXA==
X-Gm-Message-State: AOJu0YyrdsxRAeoPB2PpkuMLBWtJTHok4IKOl8nT0w6nnKEhV61upgbs
	vaj8La3qCnnxfRHF3JTXW9worSLxGonwsgxgBE6JCb5q0zo738POlxV9sppPY8TDPdVYuPWPsId
	NTeV4rrnFxQ==
X-Google-Smtp-Source: AGHT+IE3YGh73IUKt3tF3dvy7/GbTQEhVEzQDTI+ZlOSwQg4lIVOEJq0o3dEVeO0MAQ7cNP9Qriaq9jzNHZ/jQ==
X-Received: from edumazet1.c.googlers.com ([fda3:e722:ac3:cc00:f7:ea0b:ac12:11d6])
 (user=edumazet job=sendgmr) by 2002:a25:d003:0:b0:e24:a28e:9399 with SMTP id
 3f1490d57ef6-e28936d2d3bmr2275276.4.1728069409213; Fri, 04 Oct 2024 12:16:49
 -0700 (PDT)
Date: Fri,  4 Oct 2024 19:16:40 +0000
In-Reply-To: <20241004191644.1687638-1-edumazet@google.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20241004191644.1687638-1-edumazet@google.com>
X-Mailer: git-send-email 2.47.0.rc0.187.ge670bccf7e-goog
Message-ID: <20241004191644.1687638-2-edumazet@google.com>
Subject: [PATCH net-next 1/5] net: add TIME_WAIT logic to sk_to_full_sk()
From: Eric Dumazet <edumazet@google.com>
To: "David S . Miller" <davem@davemloft.net>, Jakub Kicinski <kuba@kernel.org>, 
	Paolo Abeni <pabeni@redhat.com>, Martin KaFai Lau <martin.lau@linux.dev>
Cc: netdev@vger.kernel.org, eric.dumazet@gmail.com, 
	Eric Dumazet <edumazet@google.com>
Content-Type: text/plain; charset="UTF-8"

TCP will soon attach TIME_WAIT sockets to some ACK and RST.

Make sure sk_to_full_sk() detects this and does not return
a non full socket.

Signed-off-by: Eric Dumazet <edumazet@google.com>
---
 include/net/inet_sock.h | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/include/net/inet_sock.h b/include/net/inet_sock.h
index 394c3b66065e20d34594d6e2a2010c55bb457810..cec093b78151b9a3b95ad4b3672a72b0aa9a8305 100644
--- a/include/net/inet_sock.h
+++ b/include/net/inet_sock.h
@@ -319,8 +319,10 @@ static inline unsigned long inet_cmsg_flags(const struct inet_sock *inet)
 static inline struct sock *sk_to_full_sk(struct sock *sk)
 {
 #ifdef CONFIG_INET
-	if (sk && sk->sk_state == TCP_NEW_SYN_RECV)
+	if (sk && READ_ONCE(sk->sk_state) == TCP_NEW_SYN_RECV)
 		sk = inet_reqsk(sk)->rsk_listener;
+	if (sk && READ_ONCE(sk->sk_state) == TCP_TIME_WAIT)
+		sk = NULL;
 #endif
 	return sk;
 }
-- 
2.47.0.rc0.187.ge670bccf7e-goog


