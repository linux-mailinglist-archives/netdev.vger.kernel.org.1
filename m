Return-Path: <netdev+bounces-165360-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 8AE23A31BC1
	for <lists+netdev@lfdr.de>; Wed, 12 Feb 2025 03:12:25 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id D4CAF167FA2
	for <lists+netdev@lfdr.de>; Wed, 12 Feb 2025 02:12:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 184551C462D;
	Wed, 12 Feb 2025 02:11:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="LiRk6zGf"
X-Original-To: netdev@vger.kernel.org
Received: from mail-qk1-f177.google.com (mail-qk1-f177.google.com [209.85.222.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6ED451D5143
	for <netdev@vger.kernel.org>; Wed, 12 Feb 2025 02:11:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739326315; cv=none; b=ECYcj+pr3NavnhZJ6+zsE25oYrSEKnBE1sIpQmqIl8VIclB5hP34bBHmANHkiKAeuMTos9TtUO6fy0zaAA47pjovyR7RkNhNPECLGFt+ZnbHTTsk/1rOIZ9WSXEnZBuqwWgzFaxhgzFdqN7oStTkrmo7tkyZ3fUkK1nqejdmugI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739326315; c=relaxed/simple;
	bh=K8WIcSIcgARTysfF963OEf80X2c01RISMiQKzhFiebs=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=a3TVCXZKVOZ6I9oNnlgl+Fdt3xV7mPuJBag12IHYdSAiDn8YVCXS6/eYsJW91iElC38GCvYgwQur1J6+gSrgxdiGbmzHxyQlCP7+u1XM6pJ/KX9dwBlSs9klKg69zWjuUoNf+TwM9Z2ilYbgAUpktQoxhKVBFQ7jnMpKkniuuN8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=LiRk6zGf; arc=none smtp.client-ip=209.85.222.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-qk1-f177.google.com with SMTP id af79cd13be357-7c05d75007cso382897385a.1
        for <netdev@vger.kernel.org>; Tue, 11 Feb 2025 18:11:52 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1739326311; x=1739931111; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=jw7vNBV/JJp3b9usvmISA7C/WVlPdKaG2q9kPlazBcg=;
        b=LiRk6zGfsaP07WowTfjssgxwQ1vfolq7NTdcBvjsUN3yHw7d9Q8MEr5xh+bDHRUObX
         pY8TUJA/ic5+7H3CgoY3VD89TBOZxcyEa1vb8o4B8bEmeGKqNws1fzWSd8etWxUw75jh
         cTCljEkCkqaDDEK7ssqCDpv8TKhNHuy21KmrUZ1LNX3iBb07iU6YW9BRz0GLieyDicJ4
         RRWLQ29ENmLIluutcF8N+I2Xvsmw121pQ3AgO0cBSBGCXnfGh6OznRoGJM8N6FtN3qRa
         ZQ+Lhiv+Q3sa/U9Rhr9QX5J5fWauVYKf3oguzul9edhg9JH5vI2OMqhh6RHr8QD+38ru
         OSPQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1739326311; x=1739931111;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=jw7vNBV/JJp3b9usvmISA7C/WVlPdKaG2q9kPlazBcg=;
        b=lOzDm4CgnKAHK5a0H7QHf7oq1gItkhtQBYNEftqgDplavQ40KQAU8mNSo3o9UQ156O
         +2bM8J6IYxPBfNS8jE9K2LBU/Pi2mJvta1O9LTE6juFcXYJsaa0S4i7Xqou3eUHv/tcM
         T9CXXKHFYSv6hmzgorTRDD7fflIMsgGC0Ev8m4qxUiRDXynwNeHraLnAmqIlpJ5fBFUc
         NsYEOdigfIn/Pg5ymZ8Ml74i1pWpsfUBIa0CMSIQadF5qGJbhV7f3zKN5aSoYMue4/9f
         AE+sWLKvDMo7sP4FZoCDEWiU86BagHHoU6t9WAwVew276MqtSLKtZFp1vLpCk62ZLDq4
         9Oow==
X-Gm-Message-State: AOJu0YzPaPjQWcuxXxMpYwh25+3NPeQI/47RGT+nXZCobcid3cSuvbO3
	PYBRTTYxFn1zbLiMHrBg28LlN3VhT/KEIihN4s3RhmXwphYzEt6mMfGTWw==
X-Gm-Gg: ASbGncuMIEJQ5oYbZvG671S2D1e03hGK2RGS+B/tH4yPC6LTanVls6CF8h+EyX2IoJa
	3yR+pSYZTF9zOS34J9FCD5naKR/e7QuidPXkXNJXHPM2VAwUKAi6mUd3ZXZpbaGhaG9A9RZXhIQ
	gchNtROfsciYXxAw9OprPBJGQ3u+REQgoONh7lNBBh0dmkuFwDtt7Wv9MuHYj88shRgNRox3Qbu
	esOZah59Ym/XFoKjU4Xz/kgstRjkjAyYbMBWrvvRuCNZURUG5JWIHmxdypAaWoYZGu9cavAN5vM
	5aAhUt3YkVxwTrfQHBSyRY3kff1lqq3biEyjIe1/zuuoZG9GPCW9j6zbJyxlJLpOTKPOxAf21yc
	9PHmrhKITHQ==
X-Google-Smtp-Source: AGHT+IFGiccbhZqyc+tej4qTENJjbBWjiTUYYL3DhoSnUTyHRDLAmgTi3lUKyo/9akatrkTDDTbHag==
X-Received: by 2002:a05:6214:21ae:b0:6e4:3eb1:2bdb with SMTP id 6a1803df08f44-6e46edb4c2emr21334016d6.43.1739326311434;
        Tue, 11 Feb 2025 18:11:51 -0800 (PST)
Received: from willemb.c.googlers.com.com (15.60.86.34.bc.googleusercontent.com. [34.86.60.15])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-6e44a9a524esm58256126d6.5.2025.02.11.18.11.50
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 11 Feb 2025 18:11:50 -0800 (PST)
From: Willem de Bruijn <willemdebruijn.kernel@gmail.com>
To: netdev@vger.kernel.org
Cc: davem@davemloft.net,
	kuba@kernel.org,
	edumazet@google.com,
	pabeni@redhat.com,
	dsahern@kernel.org,
	horms@kernel.org,
	Willem de Bruijn <willemb@google.com>
Subject: [PATCH net-next v2 7/7] ipv6: initialize inet socket cookies with sockcm_init
Date: Tue, 11 Feb 2025 21:09:53 -0500
Message-ID: <20250212021142.1497449-8-willemdebruijn.kernel@gmail.com>
X-Mailer: git-send-email 2.48.1.502.g6dc24dfdaf-goog
In-Reply-To: <20250212021142.1497449-1-willemdebruijn.kernel@gmail.com>
References: <20250212021142.1497449-1-willemdebruijn.kernel@gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Willem de Bruijn <willemb@google.com>

Avoid open coding the same logic.

Signed-off-by: Willem de Bruijn <willemb@google.com>
---
 include/net/ipv6.h | 2 ++
 net/ipv6/ping.c    | 3 ---
 net/ipv6/raw.c     | 9 +++------
 net/ipv6/udp.c     | 3 ---
 4 files changed, 5 insertions(+), 12 deletions(-)

diff --git a/include/net/ipv6.h b/include/net/ipv6.h
index 46a679d9b334..9614006f483c 100644
--- a/include/net/ipv6.h
+++ b/include/net/ipv6.h
@@ -371,6 +371,8 @@ static inline void ipcm6_init_sk(struct ipcm6_cookie *ipc6,
 		.tclass = inet6_sk(sk)->tclass,
 		.dontfrag = inet6_test_bit(DONTFRAG, sk),
 	};
+
+	sockcm_init(&ipc6->sockc, sk);
 }
 
 static inline struct ipv6_txoptions *txopt_get(const struct ipv6_pinfo *np)
diff --git a/net/ipv6/ping.c b/net/ipv6/ping.c
index 46b8adf6e7f8..84d90dd8b3f0 100644
--- a/net/ipv6/ping.c
+++ b/net/ipv6/ping.c
@@ -119,9 +119,6 @@ static int ping_v6_sendmsg(struct sock *sk, struct msghdr *msg, size_t len)
 		return -EINVAL;
 
 	ipcm6_init_sk(&ipc6, sk);
-	ipc6.sockc.priority = READ_ONCE(sk->sk_priority);
-	ipc6.sockc.tsflags = READ_ONCE(sk->sk_tsflags);
-	ipc6.sockc.mark = READ_ONCE(sk->sk_mark);
 
 	fl6.flowi6_oif = oif;
 
diff --git a/net/ipv6/raw.c b/net/ipv6/raw.c
index ae68d3f7dd32..fda640ebd53f 100644
--- a/net/ipv6/raw.c
+++ b/net/ipv6/raw.c
@@ -769,19 +769,16 @@ static int rawv6_sendmsg(struct sock *sk, struct msghdr *msg, size_t len)
 
 	hdrincl = inet_test_bit(HDRINCL, sk);
 
+	ipcm6_init_sk(&ipc6, sk);
+
 	/*
 	 *	Get and verify the address.
 	 */
 	memset(&fl6, 0, sizeof(fl6));
 
-	fl6.flowi6_mark = READ_ONCE(sk->sk_mark);
+	fl6.flowi6_mark = ipc6.sockc.mark;
 	fl6.flowi6_uid = sk->sk_uid;
 
-	ipcm6_init_sk(&ipc6, sk);
-	ipc6.sockc.tsflags = READ_ONCE(sk->sk_tsflags);
-	ipc6.sockc.mark = fl6.flowi6_mark;
-	ipc6.sockc.priority = READ_ONCE(sk->sk_priority);
-
 	if (sin6) {
 		if (addr_len < SIN6_LEN_RFC2133)
 			return -EINVAL;
diff --git a/net/ipv6/udp.c b/net/ipv6/udp.c
index 7096b7e84c10..3a0d6c5a8286 100644
--- a/net/ipv6/udp.c
+++ b/net/ipv6/udp.c
@@ -1496,9 +1496,6 @@ int udpv6_sendmsg(struct sock *sk, struct msghdr *msg, size_t len)
 
 	ipcm6_init_sk(&ipc6, sk);
 	ipc6.gso_size = READ_ONCE(up->gso_size);
-	ipc6.sockc.tsflags = READ_ONCE(sk->sk_tsflags);
-	ipc6.sockc.mark = READ_ONCE(sk->sk_mark);
-	ipc6.sockc.priority = READ_ONCE(sk->sk_priority);
 
 	/* destination address check */
 	if (sin6) {
-- 
2.48.1.502.g6dc24dfdaf-goog


