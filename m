Return-Path: <netdev+bounces-231149-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 357C0BF5B57
	for <lists+netdev@lfdr.de>; Tue, 21 Oct 2025 12:10:45 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id CE9621980392
	for <lists+netdev@lfdr.de>; Tue, 21 Oct 2025 10:11:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2BB3A28CF4A;
	Tue, 21 Oct 2025 10:10:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=mandelbit.com header.i=@mandelbit.com header.b="nCPir1PT"
X-Original-To: netdev@vger.kernel.org
Received: from mail-wr1-f41.google.com (mail-wr1-f41.google.com [209.85.221.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 34A7532B9A2
	for <netdev@vger.kernel.org>; Tue, 21 Oct 2025 10:10:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761041422; cv=none; b=j0Qa54cikDWCi1ig/VlCOgnQLJU7HeiNrChcQKwKZDarTXBA6FGKeS+d+t3HoB0N2KBHWX2yuwXb7bL/XoycjAfRNYAwpO4Nov9ZzEa860/c7juuLNwFip/fj0tu79ubKoBASl4aJlJjnL3B0i77qIBN8K99h4ObZ5pH/uDh0c0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761041422; c=relaxed/simple;
	bh=ENEFlMb8Vyl60OhdDcglKDdBedMH1FCkCe7iS41eW2Y=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=fMJ/ldbAxy9vJpjGmfqUgdld5bUq2xorlmMyd+j8MIZmxvwtxI5hCfMEAL8eLfmT30PxqOZ3qfLxP9z9X084mmf0hLctsBYPteni8hUT64AK3IOPItdK/7C7nqN7tAH+0hyJnH1sqsj/UcUmvDU+kALQXS5UXoVCsr8X0mZzWK0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=mandelbit.com; spf=pass smtp.mailfrom=mandelbit.com; dkim=pass (2048-bit key) header.d=mandelbit.com header.i=@mandelbit.com header.b=nCPir1PT; arc=none smtp.client-ip=209.85.221.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=mandelbit.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=mandelbit.com
Received: by mail-wr1-f41.google.com with SMTP id ffacd0b85a97d-426ed6f4db5so3363185f8f.0
        for <netdev@vger.kernel.org>; Tue, 21 Oct 2025 03:10:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=mandelbit.com; s=google; t=1761041418; x=1761646218; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=1wZYlL5Inw3UdDpRnyAAvQZAPiEUbCVn8VRnJza81eE=;
        b=nCPir1PTPoAKG3cZjzHs9UNtfZAEuXyM2yfansY0HEdvuDQ/nWDO6JgZ5PsJvhl85p
         VwxdcOn8zfR1Xpt9PZcnWHmFFgyRqX8PsIaanZslX91RG+PRe8pAdkd2gks44h1t9t/Q
         dMYyoRWxJj5WR0uA+uVpqFhX6ynvegmypG7gPltTsEVSpP4K1HU9SGogU+kebrRO/d7S
         LxWfaLXoGi+K/qfjPBxvJWIlyFOHfwTxsnvnlPUu2n48AAcUNSmo14Fu+xXIW15dyJZK
         wEQuZhzepkTpH47Rb/5w3S9IavaGHb7n9RTrlLE9VOlHrGR4pN/ygmqnCpfausbwapQV
         ScuQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1761041418; x=1761646218;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=1wZYlL5Inw3UdDpRnyAAvQZAPiEUbCVn8VRnJza81eE=;
        b=f0go8H6Ha5E7HLuGz7qrfapXtaxryuaxg5Iu+45A37j0pbWZJDRs5pnFD85+m64GMx
         2ey/jm8PNmJaCcZ8SSa49fWbNLWexd8GovcjfAo5Xoe6KC3WWgNMShfCoTuUZTTowFbT
         r6umtoMfn0fqR/bXjP+axGMbA99Imaq6fF/oQaqR51k/Hbt7g2YJkiHm2OtqkpB7reLS
         PsRh21aWDCkrdVZZwhG3DYAna9prMTsqptcVMSIb+wpPWu905GKGFZMDDqXnEehNHwWA
         BWUpNdgXMZKROWyK60N9P5PRWTwcoRvH8CF6ozgQPXnMZmuoOdEfkFPxjvsLZJ1+17np
         iRVA==
X-Gm-Message-State: AOJu0YyUWGB9OIuQwCz8TJGytRDTxfkZmwlHUJvdRzl1259nswm2gHCl
	vGMAuYZ9/fSlH44hzyxkOhj6oi1RKY5Yim3jgR5qdHYDyPXk4mHpY2Dc7IFA7v1iGGOTpczQoIU
	XFWOXvIk=
X-Gm-Gg: ASbGncsp3ZGZ2mPjhLR4Bo4iCxQH4289oRve20NtNK7Y0qJslJdArSA6tmcoAR8KN1E
	jGE70riOxFDUHfaQt+NqMks6VYPeffz4ZIrVLg1+1G2LyQZf90f2lPsT0pn88T1iFQO3rPyV7+p
	3E28uysLjGPB0CIzOgstwZtP2Yx8NmOzqN6t0aAuO2tRHLIL34H/JO74uaQ4WX1ajGdBwOLCLgj
	DgQj+Tk4Tv6g+xQPgHbf5XWcUIRGSEhnpbyl+dPqfsqx7zubiN456Dsq/7ejhz5fO3QBAWm3HZT
	iKWbLWT7hDLK+5RqIlrbzMXa4l0A7qk4c9gmFddJIuetq47TjlU9mpTklvM2fcJhL4R9F82NHZ/
	Ed2P+yEN5IJz9FuUk3ftN1LpJqDXuk8rJF7s3OWCgJdJ2ZNMoDxRGeDnT7XVikgN9jrAImPCtAI
	weEHTFeA==
X-Google-Smtp-Source: AGHT+IGTrdb9GYm0zqUMCBoXkJUBA1VHMyK0xrR//SS9duqBTZ/7Xvw3K+24IadowllIp6RS8SuUAg==
X-Received: by 2002:a05:6000:41f7:b0:427:548:6e3b with SMTP id ffacd0b85a97d-42705486e44mr12336756f8f.13.1761041418133;
        Tue, 21 Oct 2025 03:10:18 -0700 (PDT)
Received: from fedora ([2a01:e11:600c:d1a0:3dc8:57d2:efb7:51a8])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-427f009a6c5sm20172032f8f.28.2025.10.21.03.10.17
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 21 Oct 2025 03:10:17 -0700 (PDT)
From: Ralf Lici <ralf@mandelbit.com>
To: netdev@vger.kernel.org
Cc: Ralf Lici <ralf@mandelbit.com>,
	"David S . Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	Simon Horman <horms@kernel.org>,
	Mina Almasry <almasrymina@google.com>,
	Eric Biggers <ebiggers@google.com>,
	Sabrina Dubroca <sd@queasysnail.net>,
	Antonio Quartulli <antonio@openvpn.net>
Subject: [PATCH net v3 1/3] net: datagram: introduce datagram_poll_queue for custom receive queues
Date: Tue, 21 Oct 2025 12:09:40 +0200
Message-ID: <20251021100942.195010-2-ralf@mandelbit.com>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20251021100942.195010-1-ralf@mandelbit.com>
References: <20251021100942.195010-1-ralf@mandelbit.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Some protocols using TCP encapsulation (e.g., espintcp, openvpn) deliver
userspace-bound packets through a custom skb queue rather than the
standard sk_receive_queue.

Introduce datagram_poll_queue that accepts an explicit receive queue,
and convert datagram_poll into a wrapper around datagram_poll_queue.
This allows protocols with custom skb queues to reuse the core polling
logic without relying on sk_receive_queue.

Cc: Sabrina Dubroca <sd@queasysnail.net>
Cc: Antonio Quartulli <antonio@openvpn.net>
Signed-off-by: Ralf Lici <ralf@mandelbit.com>
---
 include/linux/skbuff.h |  3 +++
 net/core/datagram.c    | 44 ++++++++++++++++++++++++++++++++----------
 2 files changed, 37 insertions(+), 10 deletions(-)

diff --git a/include/linux/skbuff.h b/include/linux/skbuff.h
index fb3fec9affaa..a7cc3d1f4fd1 100644
--- a/include/linux/skbuff.h
+++ b/include/linux/skbuff.h
@@ -4204,6 +4204,9 @@ struct sk_buff *__skb_recv_datagram(struct sock *sk,
 				    struct sk_buff_head *sk_queue,
 				    unsigned int flags, int *off, int *err);
 struct sk_buff *skb_recv_datagram(struct sock *sk, unsigned int flags, int *err);
+__poll_t datagram_poll_queue(struct file *file, struct socket *sock,
+			     struct poll_table_struct *wait,
+			     struct sk_buff_head *rcv_queue);
 __poll_t datagram_poll(struct file *file, struct socket *sock,
 			   struct poll_table_struct *wait);
 int skb_copy_datagram_iter(const struct sk_buff *from, int offset,
diff --git a/net/core/datagram.c b/net/core/datagram.c
index cb4b9ef2e4e3..c285c6465923 100644
--- a/net/core/datagram.c
+++ b/net/core/datagram.c
@@ -920,21 +920,22 @@ int skb_copy_and_csum_datagram_msg(struct sk_buff *skb,
 EXPORT_SYMBOL(skb_copy_and_csum_datagram_msg);
 
 /**
- * 	datagram_poll - generic datagram poll
+ *	datagram_poll_queue - same as datagram_poll, but on a specific receive
+ *		queue
  *	@file: file struct
  *	@sock: socket
  *	@wait: poll table
+ *	@rcv_queue: receive queue to poll
  *
- *	Datagram poll: Again totally generic. This also handles
- *	sequenced packet sockets providing the socket receive queue
- *	is only ever holding data ready to receive.
+ *	Performs polling on the given receive queue, handling shutdown, error,
+ *	and connection state. This is useful for protocols that deliver
+ *	userspace-bound packets through a custom queue instead of
+ *	sk->sk_receive_queue.
  *
- *	Note: when you *don't* use this routine for this protocol,
- *	and you use a different write policy from sock_writeable()
- *	then please supply your own write_space callback.
+ *	Return: poll bitmask indicating the socket's current state
  */
-__poll_t datagram_poll(struct file *file, struct socket *sock,
-			   poll_table *wait)
+__poll_t datagram_poll_queue(struct file *file, struct socket *sock,
+			     poll_table *wait, struct sk_buff_head *rcv_queue)
 {
 	struct sock *sk = sock->sk;
 	__poll_t mask;
@@ -956,7 +957,7 @@ __poll_t datagram_poll(struct file *file, struct socket *sock,
 		mask |= EPOLLHUP;
 
 	/* readable? */
-	if (!skb_queue_empty_lockless(&sk->sk_receive_queue))
+	if (!skb_queue_empty_lockless(rcv_queue))
 		mask |= EPOLLIN | EPOLLRDNORM;
 
 	/* Connection-based need to check for termination and startup */
@@ -978,4 +979,27 @@ __poll_t datagram_poll(struct file *file, struct socket *sock,
 
 	return mask;
 }
+EXPORT_SYMBOL(datagram_poll_queue);
+
+/**
+ *	datagram_poll - generic datagram poll
+ *	@file: file struct
+ *	@sock: socket
+ *	@wait: poll table
+ *
+ *	Datagram poll: Again totally generic. This also handles
+ *	sequenced packet sockets providing the socket receive queue
+ *	is only ever holding data ready to receive.
+ *
+ *	Note: when you *don't* use this routine for this protocol,
+ *	and you use a different write policy from sock_writeable()
+ *	then please supply your own write_space callback.
+ *
+ *	Return: poll bitmask indicating the socket's current state
+ */
+__poll_t datagram_poll(struct file *file, struct socket *sock, poll_table *wait)
+{
+	return datagram_poll_queue(file, sock, wait,
+				   &sock->sk->sk_receive_queue);
+}
 EXPORT_SYMBOL(datagram_poll);
-- 
2.51.0


