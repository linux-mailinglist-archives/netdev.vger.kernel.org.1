Return-Path: <netdev+bounces-230803-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id A75DDBEFB18
	for <lists+netdev@lfdr.de>; Mon, 20 Oct 2025 09:38:08 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id BC4263ABF8F
	for <lists+netdev@lfdr.de>; Mon, 20 Oct 2025 07:38:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 561BC2DE70C;
	Mon, 20 Oct 2025 07:38:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=mandelbit.com header.i=@mandelbit.com header.b="RsJNv2eQ"
X-Original-To: netdev@vger.kernel.org
Received: from mail-wm1-f51.google.com (mail-wm1-f51.google.com [209.85.128.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 69F872DCC04
	for <netdev@vger.kernel.org>; Mon, 20 Oct 2025 07:38:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760945884; cv=none; b=V/EEjL6jRHUShE7Vlk/42uEYcbK1FCwJskuFqTkqzLflHsk7SrVvqAQdZMTYct98R5G6ugVTp3B0w994NRP27wRMK9oA/xgzcvbquixtvSYqUt+dGwmxLG3P0Gtu7W9aL1WFaJo+Ho5jn2AEFtspxjmT/a/1dnhlN5bq0uh1xrc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760945884; c=relaxed/simple;
	bh=uyeurQteaqCRUJU+vwL0jb5Dv31GiQGepv+vCtBu+t8=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=sutPIOmSeUqrxMzDpL3OiMN9tonwpBYPSs/bTUCTgWW/R844HCVcEa/zx+JAUpteCRJ5t+9mL4V2Kgf6l0/3aeppR9yx51jeLToxsP6EecKElW1Pe4PgbGxogEYIQmzoD70ZWHzWcGSDa/iirVvEaEBYLs4iZ8z0E/iEtKidgjw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=mandelbit.com; spf=pass smtp.mailfrom=mandelbit.com; dkim=pass (2048-bit key) header.d=mandelbit.com header.i=@mandelbit.com header.b=RsJNv2eQ; arc=none smtp.client-ip=209.85.128.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=mandelbit.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=mandelbit.com
Received: by mail-wm1-f51.google.com with SMTP id 5b1f17b1804b1-47112a73785so29825975e9.3
        for <netdev@vger.kernel.org>; Mon, 20 Oct 2025 00:38:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=mandelbit.com; s=google; t=1760945880; x=1761550680; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=WudtUCqL9ljXkZL/a7VlsBnR20A9APsZ4ZFUXr5zDEM=;
        b=RsJNv2eQy+Ez+j1ONY9M1ADzylRycuZQQqbRsJrNn1jF7ncM2Ki+pcKFF2ampDv82H
         CViKBMsXGM+tsuCcA9FyCb3SyzfOphAfG2mLE+zdxrKnKAY9mnkoVzqN9nFvu7DSS8dI
         jSgY8ncfC9SnIPYvLBl/U+tLEJaww5vu/MP5QXvWqsG9AtIyBkDkvzVSgV7a8MDm26yb
         pk3/+rBje0oexP3Y8xIIVsJyApyz30UjL/1UbK5MSqGHV+aBSAcNvfvXgz37UO98DKVa
         danY3ZJSXFvGZHgnGrQM8ICvnEuRH3avFhgak6nKVg05Cyr/55zkQqnDPkNBQ4D5pgCm
         ovjw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1760945880; x=1761550680;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=WudtUCqL9ljXkZL/a7VlsBnR20A9APsZ4ZFUXr5zDEM=;
        b=oN2fENms4ejKTQGxOV4S6jaxIJIT2C6HEm0qVT7XnpP7wykdEV4l6UY3bxNV5xNJ5v
         a++hjWBIGnB/90l2R+mMiV9kJSsehoFUFbdc8PfZKNmctxcBRW77QfQz9USM+5tGm6So
         sYtRF6XHz+lDJCYSm/43t9d16tyceam7FaoIc9usw9cszWZFkQZYXFCCdDfo838S7BSq
         Ct1J2XYjxLq5lnRd1aBjTXCqOsQLGk2jNVJaeHQTKKpFZhHRktUgnTKnSC79a4afGMlN
         wVnaiNhyUIy8rPvtiO5O4cle3pGCwpUlLjQSOOVGqticXbKLU+7z0m8TPJCV4IKfP1eE
         gmhA==
X-Gm-Message-State: AOJu0Yy142bZhk+V7o3iB9VmelrglSnPYYdMnDM2CUBdYrqNwKky8fWu
	0F5ubv5ahhMmy+9KB5H7IuNJdvJxklZuX2MK9+ocGihB792J7K/sq59IZ19EJZ/ve9YtidQIqof
	61M0uOmKjQg==
X-Gm-Gg: ASbGncuzvEislfpy/P2R2InwJX4TrgXvKRdGvSXD3YW+EBnYTBUwCzVaUk70tUmTFhN
	8duHGdpK1q2w0dLWIw2vyc/iUk6MAximQ7QiHrLfJShBoujNtDSoQ8hq4GeNj33TkQz6nFDujj5
	/djUkGGh8DmoUMf6h2mwu0S+MId6TLn0U/eW8N9ubTf4XNwOvWg3s3UECgLMuw6TFi7e+K+fJ/o
	cV8hxW+PPKLYJMxscs7JWCFLpuFPEj5DOgkpMXttdw93UWZZfRFaGZK9wRhPoFi0NpvCkMDYpXD
	0wlcOLo4CeclwFxy670XqvIH73WDE6azCGWvucjXXVBrPTl0qunKM09Hk34bmvYdJM305eaqxZ6
	y8iOvULslzTP4gQAat9HnVJYx9WGzRU/ybOYdgrSNA7BUG8ZvYk7yQ7HjPgQF0ijt5GvZPZNWpB
	EzF55URA==
X-Google-Smtp-Source: AGHT+IHGg47tVQxnBvdYDo6I3RUeaija5oAkaOTTmQ92zNL4HRzPO5+Ko2g0Z3Gz/VFZUdTXDNX/Cw==
X-Received: by 2002:a05:600c:3f10:b0:46e:59f8:8546 with SMTP id 5b1f17b1804b1-471178afb7amr81951375e9.17.1760945880168;
        Mon, 20 Oct 2025 00:38:00 -0700 (PDT)
Received: from fedora ([2a01:e11:600c:d1a0:3dc8:57d2:efb7:51a8])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-47154d38309sm132862315e9.9.2025.10.20.00.37.59
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 20 Oct 2025 00:37:59 -0700 (PDT)
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
Subject: [PATCH net v2 1/3] net: datagram: introduce datagram_poll_queue for custom receive queues
Date: Mon, 20 Oct 2025 09:37:29 +0200
Message-ID: <20251020073731.76589-2-ralf@mandelbit.com>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20251020073731.76589-1-ralf@mandelbit.com>
References: <20251020073731.76589-1-ralf@mandelbit.com>
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
 net/core/datagram.c    | 46 ++++++++++++++++++++++++++++++------------
 2 files changed, 36 insertions(+), 13 deletions(-)

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
index cb4b9ef2e4e3..11ff1f9b0b61 100644
--- a/net/core/datagram.c
+++ b/net/core/datagram.c
@@ -920,21 +920,20 @@ int skb_copy_and_csum_datagram_msg(struct sk_buff *skb,
 EXPORT_SYMBOL(skb_copy_and_csum_datagram_msg);
 
 /**
- * 	datagram_poll - generic datagram poll
- *	@file: file struct
- *	@sock: socket
- *	@wait: poll table
+ * datagram_poll_queue - same as datagram_poll, but on a specific receive queue
+ * @file: file struct
+ * @sock: socket
+ * @wait: poll table
+ * @rcv_queue: receive queue to poll
  *
- *	Datagram poll: Again totally generic. This also handles
- *	sequenced packet sockets providing the socket receive queue
- *	is only ever holding data ready to receive.
+ * Performs polling on the given receive queue, handling shutdown, error, and
+ * connection state. This is useful for protocols that deliver userspace-bound
+ * packets through a custom queue instead of sk->sk_receive_queue.
  *
- *	Note: when you *don't* use this routine for this protocol,
- *	and you use a different write policy from sock_writeable()
- *	then please supply your own write_space callback.
+ * Return: poll bitmask indicating the socket's current state
  */
-__poll_t datagram_poll(struct file *file, struct socket *sock,
-			   poll_table *wait)
+__poll_t datagram_poll_queue(struct file *file, struct socket *sock,
+			     poll_table *wait, struct sk_buff_head *rcv_queue)
 {
 	struct sock *sk = sock->sk;
 	__poll_t mask;
@@ -956,7 +955,7 @@ __poll_t datagram_poll(struct file *file, struct socket *sock,
 		mask |= EPOLLHUP;
 
 	/* readable? */
-	if (!skb_queue_empty_lockless(&sk->sk_receive_queue))
+	if (!skb_queue_empty_lockless(rcv_queue))
 		mask |= EPOLLIN | EPOLLRDNORM;
 
 	/* Connection-based need to check for termination and startup */
@@ -978,4 +977,25 @@ __poll_t datagram_poll(struct file *file, struct socket *sock,
 
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
+ */
+__poll_t datagram_poll(struct file *file, struct socket *sock, poll_table *wait)
+{
+	return datagram_poll_queue(file, sock, wait,
+				   &sock->sk->sk_receive_queue);
+}
 EXPORT_SYMBOL(datagram_poll);
-- 
2.51.0


