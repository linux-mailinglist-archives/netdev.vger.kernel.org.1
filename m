Return-Path: <netdev+bounces-230089-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 1F36CBE3E34
	for <lists+netdev@lfdr.de>; Thu, 16 Oct 2025 16:24:16 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 9A22A503277
	for <lists+netdev@lfdr.de>; Thu, 16 Oct 2025 14:23:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B86D6341676;
	Thu, 16 Oct 2025 14:22:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=mandelbit.com header.i=@mandelbit.com header.b="MXeymlJq"
X-Original-To: netdev@vger.kernel.org
Received: from mail-ed1-f52.google.com (mail-ed1-f52.google.com [209.85.208.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AC17634164D
	for <netdev@vger.kernel.org>; Thu, 16 Oct 2025 14:22:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760624570; cv=none; b=HDh8hB/++ts053DJAYXyijdh/kDrGjN3CudJo7n85RE68VsLYB3O2EU7Z0WtU1OTvLvW4Pu1M+LtJp8jo+wwwGdAldhPkh/Q57y1BgV+R1G3Xk7iCy+7MMFMFr4Y6OYskZn8U2xmFg7luoy6WkZG8LPCQhlNRdYct4rjVPYAC9Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760624570; c=relaxed/simple;
	bh=vo/lPHX7CHWg1E8INiZ55O5JAx3twZofPrsQ+Rc/4q0=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=a3GvjZGPR21Y5gCOuTJIh3o75rqVPyPujt+uT2d/NFN2p2nopYIxE3KKvfb9heIFosx+y4kiwfRmdzVWERkLVY44Ec2xgLtiKdqgJnrr4tkugnHg9avggV1NHvoVfLnvKhKJCMyXq5oFdl2BhB/if6C5GD3OsZ9a7ZrGWMVpqPc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=mandelbit.com; spf=pass smtp.mailfrom=mandelbit.com; dkim=pass (2048-bit key) header.d=mandelbit.com header.i=@mandelbit.com header.b=MXeymlJq; arc=none smtp.client-ip=209.85.208.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=mandelbit.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=mandelbit.com
Received: by mail-ed1-f52.google.com with SMTP id 4fb4d7f45d1cf-63bfbbbdd0bso1593869a12.3
        for <netdev@vger.kernel.org>; Thu, 16 Oct 2025 07:22:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=mandelbit.com; s=google; t=1760624565; x=1761229365; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=H/Leon7wmPCEZCg4TR67Me12Ynu0gtrsB+Bd0XiL0ao=;
        b=MXeymlJq6HL6LnLuvnBAhEHzRSvH4Wujn3CkTFWu9rvdMHMjOatZwmmug4557tMnFt
         JM0NYKPr4XkHGwYAkqhKrYnK0xiQXmdIUMbdf/y6uk+Xvmj1QD9wjImW3E96RH8/xVbH
         T83UFISGeE5rSea0RhucHJJqrLtIqL5WBgfhyQSllDNlY2Y7JQN5kguObDWmlj3sGvlT
         j7mBBWIiXOhSW0Gn1HhA4zhNEc8Ap09Ilp/PFz0UCjjnQeF7bGSJvktvSF1S5puq1boA
         EusYXfh0lZ87l6/IzrvZ3k8sVGn/zK4ilMiinNn7k9175HwNDqeCy+kRMFi2+Cw0sSuv
         CuaQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1760624565; x=1761229365;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=H/Leon7wmPCEZCg4TR67Me12Ynu0gtrsB+Bd0XiL0ao=;
        b=m6FiO7XsRBKGH/u7NtAtE+VxHd51MUYJU1e+AC8iVB12HOv/B4vOT+phtIe1U3MT+3
         AUAGl+BXbD7hc5JWEBrRIP6DZfqgGwkJNKY0q+uuXKA/6jT3I+jyottTjBekLo/tWvrS
         /0ySbrwJlajuNSBnRtGNHSJ5yqmzK1j1KADM935yZYkGOXwETgeOSwsXFLZwCNSW8KFI
         43r5jgWAxZPNL9lCXbgfCbmfxsToXrltqwjFDjFYVivl8xBRcBMT7ti0JMPmmLhqluDW
         DhNbOdW9Sz4qPd7LmqMXMZuK5Daj2vi9vi9lfaESNAMqSJA5YdMFZcsaJNgaKg+t+J0U
         y6iA==
X-Gm-Message-State: AOJu0Yw2ukUSfsXKeW45dqiZA67WC0OdnFVrqVZwOlLljGNDhbDfRf4p
	3qUwl+Lph/jSBT9JtydSor/6JHZEp9C6rChdVifMks7wdGyx3CjVn+GIdwtqmEZlDlzt5+rrZG7
	vsmtpRf8=
X-Gm-Gg: ASbGnctI7+y7PNkpVdfKNMRrHiu2uFs+xuTisltTFxNIKufn5x9Wrpvmls80da3p+Ej
	2alSjVHJglOC+6Gbp5YkRGNCuQ9f6cnXwWdJjh0KKZFl2se2SdQy5jqo30pdi2NyvUjZ6cDFIEy
	v9OGo4MdskvPhetcENpah1X9JiVC+IxW7KplvBRtXvYjoqa0DXb7N+vSpVvbB8zJg+xVCAVb+13
	YjqFT60m2GL9gqzLLsx3KX8Bd/21MaQVdG+TuTsooxnrrJ61YV0vNlOYiQpq4lu3r5FYExzBXdA
	RrclRNEInkPNL3EEEXiJs1v/44TO//xPqBW3Ck7d0UBw2Q7QW17PuJKR/AdP2/lrBersLoQ+aCZ
	bIVeYr7RzBT8xY2J33MkazN3XaH9WMBmBYr3KuhO3NiHLzyUiaenhfUrs7fNeZrM4NsS/Zv+W5L
	x+EEO7SfH81+26kGeZ
X-Google-Smtp-Source: AGHT+IHezXl4XzdVczgxxtb1p1+AWCV8EuuXdTaAf+Y5RwpbvfQvtqAPRJKub6C7LrZY9O03XimWAQ==
X-Received: by 2002:a05:6402:398b:b0:63a:294:b02a with SMTP id 4fb4d7f45d1cf-63c1f640da1mr52660a12.13.1760624564654;
        Thu, 16 Oct 2025 07:22:44 -0700 (PDT)
Received: from fedora ([2a01:e11:600c:d1a0:3dc8:57d2:efb7:51a8])
        by smtp.gmail.com with ESMTPSA id 4fb4d7f45d1cf-63a52b1e89csm16174574a12.19.2025.10.16.07.22.44
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 16 Oct 2025 07:22:44 -0700 (PDT)
From: Ralf Lici <ralf@mandelbit.com>
To: netdev@vger.kernel.org
Cc: Ralf Lici <ralf@mandelbit.com>,
	Sabrina Dubroca <sd@queasysnail.net>,
	"David S . Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	Herbert Xu <herbert@gondor.apana.org.au>,
	Antonio Quartulli <antonio@openvpn.net>
Subject: [PATCH net 1/3] net: datagram: introduce datagram_poll_queue for custom receive queues
Date: Thu, 16 Oct 2025 16:22:05 +0200
Message-ID: <20251016142207.411549-2-ralf@mandelbit.com>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20251016142207.411549-1-ralf@mandelbit.com>
References: <20251016142207.411549-1-ralf@mandelbit.com>
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
 net/core/datagram.c    | 45 +++++++++++++++++++++++++++++-------------
 2 files changed, 34 insertions(+), 14 deletions(-)

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
index cb4b9ef2e4e3..60e69d0b6aa0 100644
--- a/net/core/datagram.c
+++ b/net/core/datagram.c
@@ -920,21 +920,18 @@ int skb_copy_and_csum_datagram_msg(struct sk_buff *skb,
 EXPORT_SYMBOL(skb_copy_and_csum_datagram_msg);
 
 /**
- * 	datagram_poll - generic datagram poll
- *	@file: file struct
- *	@sock: socket
- *	@wait: poll table
- *
- *	Datagram poll: Again totally generic. This also handles
- *	sequenced packet sockets providing the socket receive queue
- *	is only ever holding data ready to receive.
+ * datagram_poll_queue - same as datagram_poll, but on a specific receive queue
+ * @file: file struct
+ * @sock: socket
+ * @wait: poll table
+ * @rcv_queue: receive queue to poll
  *
- *	Note: when you *don't* use this routine for this protocol,
- *	and you use a different write policy from sock_writeable()
- *	then please supply your own write_space callback.
+ * Performs polling on the given receive queue, handling shutdown, error, and
+ * connection state. This is useful for protocols that deliver userspace-bound
+ * packets through a custom queue instead of sk->sk_receive_queue.
  */
-__poll_t datagram_poll(struct file *file, struct socket *sock,
-			   poll_table *wait)
+__poll_t datagram_poll_queue(struct file *file, struct socket *sock,
+			     poll_table *wait, struct sk_buff_head *rcv_queue)
 {
 	struct sock *sk = sock->sk;
 	__poll_t mask;
@@ -956,7 +953,7 @@ __poll_t datagram_poll(struct file *file, struct socket *sock,
 		mask |= EPOLLHUP;
 
 	/* readable? */
-	if (!skb_queue_empty_lockless(&sk->sk_receive_queue))
+	if (!skb_queue_empty_lockless(rcv_queue))
 		mask |= EPOLLIN | EPOLLRDNORM;
 
 	/* Connection-based need to check for termination and startup */
@@ -978,4 +975,24 @@ __poll_t datagram_poll(struct file *file, struct socket *sock,
 
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
+	return datagram_poll_queue(file, sock, wait, &sock->sk->sk_receive_queue);
+}
 EXPORT_SYMBOL(datagram_poll);
-- 
2.51.0


