Return-Path: <netdev+bounces-224520-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id E1FAEB85DD2
	for <lists+netdev@lfdr.de>; Thu, 18 Sep 2025 18:03:06 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 7F92C1CC4285
	for <lists+netdev@lfdr.de>; Thu, 18 Sep 2025 15:57:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 07585315764;
	Thu, 18 Sep 2025 15:55:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="o2Cdtega"
X-Original-To: netdev@vger.kernel.org
Received: from mail-qk1-f202.google.com (mail-qk1-f202.google.com [209.85.222.202])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2C6A4314D0D
	for <netdev@vger.kernel.org>; Thu, 18 Sep 2025 15:55:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.202
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758210937; cv=none; b=JvOtrStU62sqHVqyJ8t3ld7I2SfDV4RxGGuQbhCLtx5kFHnN/VugIq2F6e1aE4eQwLPRhy84AB+QwwV8MfEvOxzz9EvmxjzE7HJ08WIbgaRSTd0/5N4i6JDKlinWlOWaiQtSO7VgBIiA1qKtXl2PB1SWdMDDD+ZJw38BvHnvuVk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758210937; c=relaxed/simple;
	bh=a8YNf9+u1wPIxT2ULjOl/VHxeJgDhrTQAVZ/MzAqU5U=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=bHOehndtjODA7jFa6QZ32kk01yHm4gVwoWh/dlpsYjP4OteoF0zfA2sRtbkLPce0qxsJlWbYUL/KBn525OXFKPCqMz2hNMoj5nmSj0I6ef+L4wwysZ2TIEt6LuzJyUQEj0OTu/XjPV6QHoPBxq6zinxiDbjWRF46B4HZ8hiozsY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--edumazet.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=o2Cdtega; arc=none smtp.client-ip=209.85.222.202
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--edumazet.bounces.google.com
Received: by mail-qk1-f202.google.com with SMTP id af79cd13be357-806f812a0aaso232215285a.3
        for <netdev@vger.kernel.org>; Thu, 18 Sep 2025 08:55:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1758210935; x=1758815735; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=ddE2C9gjwbAd/zuc7bAabSsH2xoX/0bHukBaRJiZGqA=;
        b=o2CdtegaTOWFQ6ewyCh+gTvv7nToIH+aOIsHhRNM+5ApoFVfTrOnKyXvTu+qIBmD6G
         7ykphqNMC29ylkbTX3G9Qp16BbC8USPPRA21euwhfVxsE9+JIft3gP9w/iuuV/+MHPoX
         r5q0JsXJquz1TFzOWoJEEnL7s0ySN+DL8/J6HyuZcVx/fPrqhocDwXO9x7VXrodXpTkT
         tQ07aXuEEdb91sRB52dqfBcWkP1WrdtKXctDUEMzQu+aQgsrQ4LIK8Om8ZctCCcrLDc3
         GIKVcnvnuxqixRieq7Yze/kxp/pLk5M4OYwKaCn7FrbXVnqvePWhlZVkgYbPhx5PLKGv
         s62g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1758210935; x=1758815735;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=ddE2C9gjwbAd/zuc7bAabSsH2xoX/0bHukBaRJiZGqA=;
        b=hHqUEcDWUBEL+MqpD1wju+hFUkk+sXx/Wb3iTJ3fcR7eYsyjWv6Hzn4/LFo8+Pkt1X
         ovW0IsVrUtyoiFzKmfFhVPtwO6j8Favky/6WIcU+nLWrpqWTOTRgXcNy+ENc7oW9JUGx
         EslMx7INxMt6pcCIkdEucUpJXxjb9avCoW5HMfDXTiZQTH+pq8O4B56qI7/rir8TdAe7
         S3unuhKR/EakxwYS3/pZzdQNkzd/OISHl7yL2zxjpkN734DlJFAb1Licp7xpri+pWE+G
         wPwnxHhiW+gNcloamj7jFkkJqRatCOMrwOrQZx08kLR8tfFHg8ceMFshDHESajA73SLv
         T5og==
X-Forwarded-Encrypted: i=1; AJvYcCVve2knYm7fw5BADkuaLL6cGk+vmlTkyJGouvdaLD0iE8W4DMSBAVPRpZZLbZ45dazdQkBwuGc=@vger.kernel.org
X-Gm-Message-State: AOJu0YwdQnEj0GfHFlQybaSadahHxkAkDC3IFT+d7bsmQkhTiJ85O5K/
	LJ1FZpPoI8/XaV6mWtvK24Q8CMl12LGE7qvFJMyCMb9GIVM5aBwtJIMLcTOIP/oN8TSLywRBFYy
	PAnEfgi8qchF3Vw==
X-Google-Smtp-Source: AGHT+IFm20un69Sd/aGw9QHC6fcRgi1wlyQW8o7cmqDRJJynbyWxpUDpfoscDREVqC+pNBOQHKdSB+DZBthnZw==
X-Received: from qkbdz28.prod.google.com ([2002:a05:620a:2b9c:b0:7fe:9767:1b7f])
 (user=edumazet job=prod-delivery.src-stubby-dispatcher) by
 2002:a05:620a:4ad6:b0:834:99c8:48e4 with SMTP id af79cd13be357-83ba29b6c34mr8624785a.9.1758210934997;
 Thu, 18 Sep 2025 08:55:34 -0700 (PDT)
Date: Thu, 18 Sep 2025 15:55:26 +0000
In-Reply-To: <20250918155532.751173-1-edumazet@google.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20250918155532.751173-1-edumazet@google.com>
X-Mailer: git-send-email 2.51.0.384.g4c02a37b29-goog
Message-ID: <20250918155532.751173-2-edumazet@google.com>
Subject: [PATCH net-next 1/7] net: move sk_uid and sk_protocol to sock_read_tx
From: Eric Dumazet <edumazet@google.com>
To: "David S . Miller" <davem@davemloft.net>, Jakub Kicinski <kuba@kernel.org>, 
	Paolo Abeni <pabeni@redhat.com>
Cc: Simon Horman <horms@kernel.org>, Neal Cardwell <ncardwell@google.com>, 
	Willem de Bruijn <willemb@google.com>, Kuniyuki Iwashima <kuniyu@google.com>, netdev@vger.kernel.org, 
	eric.dumazet@gmail.com, Eric Dumazet <edumazet@google.com>
Content-Type: text/plain; charset="UTF-8"

sk_uid and sk_protocol are read from inet6_csk_route_socket()
for each TCP transmit.

Also read from udpv6_sendmsg(), udp_sendmsg() and others.

Move them to sock_read_tx for better cache locality.

Signed-off-by: Eric Dumazet <edumazet@google.com>
---
 include/net/sock.h | 6 +++---
 net/core/sock.c    | 2 ++
 2 files changed, 5 insertions(+), 3 deletions(-)

diff --git a/include/net/sock.h b/include/net/sock.h
index e58c6120271fe97ec0b547b1c506ab4324891785..99464b55c8fcd1fe62dddae5bc686014fbd751fa 100644
--- a/include/net/sock.h
+++ b/include/net/sock.h
@@ -492,6 +492,9 @@ struct sock {
 	long			sk_sndtimeo;
 	u32			sk_priority;
 	u32			sk_mark;
+	kuid_t			sk_uid;
+	u16			sk_protocol;
+	u16			sk_type;
 	struct dst_entry __rcu	*sk_dst_cache;
 	netdev_features_t	sk_route_caps;
 #ifdef CONFIG_SOCK_VALIDATE_XMIT
@@ -517,15 +520,12 @@ struct sock {
 				sk_no_check_tx : 1,
 				sk_no_check_rx : 1;
 	u8			sk_shutdown;
-	u16			sk_type;
-	u16			sk_protocol;
 	unsigned long	        sk_lingertime;
 	struct proto		*sk_prot_creator;
 	rwlock_t		sk_callback_lock;
 	int			sk_err_soft;
 	u32			sk_ack_backlog;
 	u32			sk_max_ack_backlog;
-	kuid_t			sk_uid;
 	unsigned long		sk_ino;
 	spinlock_t		sk_peer_lock;
 	int			sk_bind_phc;
diff --git a/net/core/sock.c b/net/core/sock.c
index 21742da19e45bbe53e84b8a87d5a23bc2d2275f8..ad79efde447675c8a8a3aafe204e2bbb1a5efe7c 100644
--- a/net/core/sock.c
+++ b/net/core/sock.c
@@ -4471,6 +4471,8 @@ static int __init sock_struct_check(void)
 	CACHELINE_ASSERT_GROUP_MEMBER(struct sock, sock_read_tx, sk_sndtimeo);
 	CACHELINE_ASSERT_GROUP_MEMBER(struct sock, sock_read_tx, sk_priority);
 	CACHELINE_ASSERT_GROUP_MEMBER(struct sock, sock_read_tx, sk_mark);
+	CACHELINE_ASSERT_GROUP_MEMBER(struct sock, sock_read_tx, sk_uid);
+	CACHELINE_ASSERT_GROUP_MEMBER(struct sock, sock_read_tx, sk_protocol);
 	CACHELINE_ASSERT_GROUP_MEMBER(struct sock, sock_read_tx, sk_dst_cache);
 	CACHELINE_ASSERT_GROUP_MEMBER(struct sock, sock_read_tx, sk_route_caps);
 	CACHELINE_ASSERT_GROUP_MEMBER(struct sock, sock_read_tx, sk_gso_type);
-- 
2.51.0.384.g4c02a37b29-goog


