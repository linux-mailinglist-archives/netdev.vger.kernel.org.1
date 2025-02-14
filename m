Return-Path: <netdev+bounces-166592-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D2203A36846
	for <lists+netdev@lfdr.de>; Fri, 14 Feb 2025 23:28:32 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 223C43B136A
	for <lists+netdev@lfdr.de>; Fri, 14 Feb 2025 22:28:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CA0501FDA92;
	Fri, 14 Feb 2025 22:27:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="bAJBIubW"
X-Original-To: netdev@vger.kernel.org
Received: from mail-qv1-f41.google.com (mail-qv1-f41.google.com [209.85.219.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 26F281FDA61
	for <netdev@vger.kernel.org>; Fri, 14 Feb 2025 22:27:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739572053; cv=none; b=Gp2yIu2C/jOyqetKXlkuMHr3hetmuOTFl5HcSinFgU0DFtfAkPmD9mMZHoEsCg+mjnr/c8Ln59+KhPYcMAOqzajs0vi9gUNyLezaP0beiniWdc6Cn2Xkc1AaTYUj1Pz7eLg7Lmcs5iHK+0YCOybtcY76gFYtC7vdt2k2kvh2KSA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739572053; c=relaxed/simple;
	bh=joZvGOGEIwYVx5Z+C5/7tkuB6wImoIdQeMMTMdNZ0W0=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=CHsfBhITlgfWPbCeuqJYC7kmcp5iXSVEJCldDc+mD4BXDdjM8nQyrPOKr8ZTDuXVnBkRwlZlmPu+Wb1AuIDb5z0Cq1ZXyKGA8ZrR14PgIhfsy4OqQOV7JpDr653aaCtZKYQNts6W7Ov319C5RZy0+O4O09Yu/b0SCr0JnLbKOfQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=bAJBIubW; arc=none smtp.client-ip=209.85.219.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-qv1-f41.google.com with SMTP id 6a1803df08f44-6dd01781b56so30135306d6.0
        for <netdev@vger.kernel.org>; Fri, 14 Feb 2025 14:27:31 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1739572051; x=1740176851; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=aOPeK5nfq/HuUL7RSYmUmdjY9pHbYIwxIJlQz6xUZbA=;
        b=bAJBIubWYcqSPS9U+rPpN3R8T5Z0XO2wHKTkge7INEy8hHj/DdbXGWEV2YRdTdRo4p
         EDFPWQKerh3Kv6h+2SIe/wArmU4lPAQGVX4pRFRpAGqL7TjMwrRmb0BfbvEcDTnWouDa
         ismSW3Qad+Qcg4PjsdRTcuoUVF9QKR6MXgFaZJcFUUh3wQi4cvwDhC0j40ajUAXdx3Cv
         N6/WK5PF+faTmbuSkG7twgGPSrV2A+sNqNZ6R6JtZUOOsifn4o7SSIo1vkkDtVNfdeXI
         FkD0KXfTH9xJsGRKltze+UmmWP26rZIg74019QzuP0hbI9l09WcsFPsPxoiNIta6QXo6
         tGkw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1739572051; x=1740176851;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=aOPeK5nfq/HuUL7RSYmUmdjY9pHbYIwxIJlQz6xUZbA=;
        b=pSlyTpERYmBy+F/JhlUDIr6GZ7+DSn51JnpJL9koeiHyErym6HVjOQee3mSE1/6kbO
         w6KYBwNf+ZUb5c/GzbN0xSmlE2wQpQHMyOfROVqx4bIMM2Rqh187XUStBaEVLzhLGFDt
         kDEB+dZuUS6FXbUZSQD8ZhgH5mkchVsplm3hpdyAtai3JWvNtFqMJk655CoJdWUYwxbx
         3NeVf6KJliwulWWwh/PZDbfBs+8PgBYmW1yAU/YJB54Eb5vhSyPM889JDjPZa8UCvUlO
         1Zdl8/U9YUcWiqAW9OgTwls3ihs/u5/gWU5U5xwSNL96Mv14W1GhZ+OaQWDU0LhkSOsX
         6vTQ==
X-Gm-Message-State: AOJu0YzSXswvc/CdTAHJ1HjCJ+zhXreEfhuN+4HGGts+1ObpTjFQ6IY5
	7hPuH4EWQYgrx2hrlpPxGejdomASVzCUN8NoIuPa6mvu6r/dyb1whUJmkg==
X-Gm-Gg: ASbGnctX4mlnhgSZDP2VYAKxG6SIAI3EMteqlFYAdd4c0j6GZ7eIBYz0BgblqRiRhHq
	CZdA259Znqn7w447OuU5LhVx1g+5E4zmbVUimTGTMxclOqqp+3aVC5qh+AdMJawZ1vmadGUQE7O
	9MTOu+WKYMS8qC/5nWF7r6GKYGnAZwxK8PChr2tEHEkf1Xg6cUGzJEQkDo/0ZDbxeJ1xDInqwrR
	Fz2+yJSeIv+fKxYGquiYc89Pw9qflw0mSPB7Ct9pvuDqEDxPlS3srmPtQL5lRyq5fFysEm/LyPw
	O5dvvc2CxY60lziGxXunWignNo/LP9wnOf4ZInNM0c+rZZpSGCLu6jX8CV9geMIj2t48zPNXrL6
	AzxrX/cNXTA==
X-Google-Smtp-Source: AGHT+IF28UnXDmpT5s+K5UZvLWROtqwrBDyQhY+VXVRSitSLhBr5xE+PGHmLMnTsPM9ozbRCxmek4A==
X-Received: by 2002:ad4:5d63:0:b0:6e4:3455:a562 with SMTP id 6a1803df08f44-6e66cd063bbmr15078036d6.32.1739572051115;
        Fri, 14 Feb 2025 14:27:31 -0800 (PST)
Received: from willemb.c.googlers.com.com (15.60.86.34.bc.googleusercontent.com. [34.86.60.15])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-6e65d7848b7sm25832916d6.27.2025.02.14.14.27.30
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 14 Feb 2025 14:27:30 -0800 (PST)
From: Willem de Bruijn <willemdebruijn.kernel@gmail.com>
To: netdev@vger.kernel.org
Cc: davem@davemloft.net,
	kuba@kernel.org,
	edumazet@google.com,
	pabeni@redhat.com,
	dsahern@kernel.org,
	horms@kernel.org,
	Willem de Bruijn <willemb@google.com>
Subject: [PATCH net-next v3 7/7] ipv6: initialize inet socket cookies with sockcm_init
Date: Fri, 14 Feb 2025 17:27:04 -0500
Message-ID: <20250214222720.3205500-8-willemdebruijn.kernel@gmail.com>
X-Mailer: git-send-email 2.48.1.601.g30ceb7b040-goog
In-Reply-To: <20250214222720.3205500-1-willemdebruijn.kernel@gmail.com>
References: <20250214222720.3205500-1-willemdebruijn.kernel@gmail.com>
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
Reviewed-by: David Ahern <dsahern@kernel.org>
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
2.48.1.601.g30ceb7b040-goog


