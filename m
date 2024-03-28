Return-Path: <netdev+bounces-82899-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 11245890219
	for <lists+netdev@lfdr.de>; Thu, 28 Mar 2024 15:40:53 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 35DB928DC41
	for <lists+netdev@lfdr.de>; Thu, 28 Mar 2024 14:40:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 691A9823CB;
	Thu, 28 Mar 2024 14:40:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="zrW22ih3"
X-Original-To: netdev@vger.kernel.org
Received: from mail-yw1-f202.google.com (mail-yw1-f202.google.com [209.85.128.202])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D544F82D7F
	for <netdev@vger.kernel.org>; Thu, 28 Mar 2024 14:40:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.202
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711636838; cv=none; b=Z5vSipqu67Af/BuJJ1gVUE548Rc7RWKcc87zlH9bOfTtmS/w0j+nVMtN19c2CIA/1ZuI/1lHRTVJbYmxc7hPZ6oZoD9lopitmOMW03vKs8fwHkcedtZlt08X4bmLC50aMcbyjCMDIRdSIUWgYjVf9tG1AFQvveVnZAtjqO5Rscs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711636838; c=relaxed/simple;
	bh=+gdzjdAz3SmFxBm9Peu7OfEUlG2/6IYoqorF/m2CC3o=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=oQgIVaMlCZPQM/OhByQnbWmPnkwVpNOBazg7TF6NUiXtNY0Z/DFNiDvo9dJDEUnH6e1AOj8XazOVkRnK2DaOeUgIOCAuxajWcd6L6JD7J6dw8xbPObnudM4IpMz4oC0wdX/HM9OfqhjOgu+fPGc4j/daZS/JNdnGhAm9m8Fwc2Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--edumazet.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=zrW22ih3; arc=none smtp.client-ip=209.85.128.202
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--edumazet.bounces.google.com
Received: by mail-yw1-f202.google.com with SMTP id 00721157ae682-611e89cf3b5so16742377b3.3
        for <netdev@vger.kernel.org>; Thu, 28 Mar 2024 07:40:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1711636836; x=1712241636; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=Y1Blf2tfA5r57pliiQCXKJixA+SeK/vqFtyh4abCJ18=;
        b=zrW22ih352RobK2NWX69gVxhpIA2RHvqbYdtfu340QspugvPclIj5gHRQ5N1BvAM/Y
         xhJohs9uzHeJxImRviBcdFWvnVFBdnAjSgIZ5uojFhPf5IEhia1gT+btShQLblzrLz3u
         2grZycdkaHvvvAk17HmJe5FZo5QpBSu6Zum7U+0DnTapVfeRzI0/seVdYbNw6S79vdMA
         nXly9o3Gz0vASuz80Nl7IQmWw2dY1pv3ErmI9dAtCPIsbsLQrHgUWYnLpwB9ns1gMYWY
         VLfvgy6s+2L4IvAWq0Djeq86vxg/qBtkMqCYtfJs7eKi6NSFGpU6VVLnpdyg2/S3KEbw
         fLaw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1711636836; x=1712241636;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=Y1Blf2tfA5r57pliiQCXKJixA+SeK/vqFtyh4abCJ18=;
        b=JStutj6YsmpcjVwj9TD4ydZvBICFvsLXzm2zHVOmOmNa0ZgsaPqosce0IY0fZtBQu5
         pa53oWA0vtsC7PYbOntsVfqaIjHLbisOuc7+dJvqSHjkyUVxnOjA6VNSiXsYthMYyFCv
         LpAQAcOHXoAHEH5itrdlHl50oAqfg84NvkJewC6U9an/UlWh72wHYZk6f/I3XRbRQs5s
         h9661mmcs+CGfBemhmHqfSlKuSR+W1K50xV5QPc3z8trCdiaSqg3J+/ifI9jTxAphXC2
         bIrttoPDoyR7pa/S0wNDvia7XQJttucFIL1Xz/YXHA27Xd+n7vrkWHWBXB6FyLsWNiSj
         gJ1A==
X-Forwarded-Encrypted: i=1; AJvYcCWGsu3IQLJ3rKSEgaW6tfaiiI4+S8T3sxDfjmMgOcG+WkGLEBwlmkPDKmc7517zFkA4elhu8fNpcge4IJsj9ZuAsZYkmlkG
X-Gm-Message-State: AOJu0YyClWWK90n4Yr3klfcrRGWz+1EetVBTqR/F63/t8QGq4KcT37eQ
	SByHo7MX3mgYysncK/2lOwpPtLdgqhZiCVKaEHjK9d9NfULkLcefeZgHRAEDktd4Crgif7eGpeE
	Jy4ZdMXrKRA==
X-Google-Smtp-Source: AGHT+IHAqudW+dS7+SmI3Sc39hQ4EeL4UxtAyM2XVSSvEpfCnV/GM5VstfU1dMfOKyO9epjZklOWMqZ9TXh/dQ==
X-Received: from edumazet1.c.googlers.com ([fda3:e722:ac3:cc00:2b:7d90:c0a8:395a])
 (user=edumazet job=sendgmr) by 2002:a05:6902:2182:b0:dce:30f5:6bc5 with SMTP
 id dl2-20020a056902218200b00dce30f56bc5mr213520ybb.4.1711636835954; Thu, 28
 Mar 2024 07:40:35 -0700 (PDT)
Date: Thu, 28 Mar 2024 14:40:29 +0000
In-Reply-To: <20240328144032.1864988-1-edumazet@google.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20240328144032.1864988-1-edumazet@google.com>
X-Mailer: git-send-email 2.44.0.396.g6e790dbe36-goog
Message-ID: <20240328144032.1864988-2-edumazet@google.com>
Subject: [PATCH net-next 1/4] udp: annotate data-race in __udp_enqueue_schedule_skb()
From: Eric Dumazet <edumazet@google.com>
To: "David S . Miller" <davem@davemloft.net>, Jakub Kicinski <kuba@kernel.org>, 
	Paolo Abeni <pabeni@redhat.com>
Cc: Willem de Bruijn <willemb@google.com>, netdev@vger.kernel.org, eric.dumazet@gmail.com, 
	Eric Dumazet <edumazet@google.com>
Content-Type: text/plain; charset="UTF-8"

sk->sk_rcvbuf is read locklessly twice, while other threads
could change its value.

Use a READ_ONCE() to annotate the race.

Signed-off-by: Eric Dumazet <edumazet@google.com>
---
 net/ipv4/udp.c | 11 ++++++-----
 1 file changed, 6 insertions(+), 5 deletions(-)

diff --git a/net/ipv4/udp.c b/net/ipv4/udp.c
index 661d0e0d273f616ad82746b69b2c76d056633017..f2736e8958187e132ef45d8e25ab2b4ea7bcbc3d 100644
--- a/net/ipv4/udp.c
+++ b/net/ipv4/udp.c
@@ -1492,13 +1492,14 @@ int __udp_enqueue_schedule_skb(struct sock *sk, struct sk_buff *skb)
 	struct sk_buff_head *list = &sk->sk_receive_queue;
 	int rmem, err = -ENOMEM;
 	spinlock_t *busy = NULL;
-	int size;
+	int size, rcvbuf;
 
-	/* try to avoid the costly atomic add/sub pair when the receive
-	 * queue is full; always allow at least a packet
+	/* Immediately drop when the receive queue is full.
+	 * Always allow at least one packet.
 	 */
 	rmem = atomic_read(&sk->sk_rmem_alloc);
-	if (rmem > sk->sk_rcvbuf)
+	rcvbuf = READ_ONCE(sk->sk_rcvbuf);
+	if (rmem > rcvbuf)
 		goto drop;
 
 	/* Under mem pressure, it might be helpful to help udp_recvmsg()
@@ -1507,7 +1508,7 @@ int __udp_enqueue_schedule_skb(struct sock *sk, struct sk_buff *skb)
 	 * - Less cache line misses at copyout() time
 	 * - Less work at consume_skb() (less alien page frag freeing)
 	 */
-	if (rmem > (sk->sk_rcvbuf >> 1)) {
+	if (rmem > (rcvbuf >> 1)) {
 		skb_condense(skb);
 
 		busy = busylock_acquire(sk);
-- 
2.44.0.396.g6e790dbe36-goog


