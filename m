Return-Path: <netdev+bounces-230805-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id AE867BEFB1E
	for <lists+netdev@lfdr.de>; Mon, 20 Oct 2025 09:38:26 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 2F1444EDC4D
	for <lists+netdev@lfdr.de>; Mon, 20 Oct 2025 07:38:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 351E62DE713;
	Mon, 20 Oct 2025 07:38:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=mandelbit.com header.i=@mandelbit.com header.b="LZRc0yQH"
X-Original-To: netdev@vger.kernel.org
Received: from mail-wr1-f43.google.com (mail-wr1-f43.google.com [209.85.221.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5B6722DF13B
	for <netdev@vger.kernel.org>; Mon, 20 Oct 2025 07:38:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760945887; cv=none; b=WEwlKKt1TqYm3/W64A5BmsaVberNLJ8ji5S/H5u0zxmzxqEvsgHSIgKw3r0TzPYegaragva3sa7eoluEKLjvsCTEJP8z9poxdkxWbhTs3nk8YnemLxuJKcf89uiUWU/avxiXXex34Stg5kV2BbtKdV3l2LMn4AexGAG37SQd+s0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760945887; c=relaxed/simple;
	bh=N6Z4L9Tef2XH1W7eR3qOIPYw4Du5+cNQWPUDLeFhGa8=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=W10J/BmZT7LSmwRA8/0ltjohE0Mo4CLPcqVHeom/Rh0xcYnaRCHMWbk9rMn8hdI5fHU9eTXMGx4K66EM2v3x16c1X4oB26oZXV7tZGiERHk9hi7tL/cffxNUhyexqqPy4SWG+UnLOW+oVpGesPRw9ST5+yoMaLhlZynBqI/x0M4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=mandelbit.com; spf=pass smtp.mailfrom=mandelbit.com; dkim=pass (2048-bit key) header.d=mandelbit.com header.i=@mandelbit.com header.b=LZRc0yQH; arc=none smtp.client-ip=209.85.221.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=mandelbit.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=mandelbit.com
Received: by mail-wr1-f43.google.com with SMTP id ffacd0b85a97d-3ecdf2b1751so2225185f8f.0
        for <netdev@vger.kernel.org>; Mon, 20 Oct 2025 00:38:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=mandelbit.com; s=google; t=1760945882; x=1761550682; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=hqH0HWpT/EdCNTCYfdVo5iGOSb4NR+hUMd5jFUmAX14=;
        b=LZRc0yQHEWmPPL3GC8B4M5zijeSlX82Q9wiXMQ84X4YN/ndG0AtbjkDpqmA2LMxqDY
         S7H6aaWFGCAkwkEYFIqcyMKXUouz/M7cwvRL1Wlmu8U+h/OBFDKLB2ig1XNsVDxtqoZt
         adZirA7RGAN7jngr7tP/0lm2O0TNFYna141r8+RWmpv5QwDUooc5QqZLx30zpNI4/axb
         4MyZ8IimxPEOo8sF0wGkLRrxzex7mbnqV7CUcX3Ee1P696iU3kxuu3YFseuict6zGxUt
         67sfkXL7V6KkrnLn4zAjUiifOncdovZIupLDrl22xrEfdOOJ7DYKlq6hdLCErChLxuSE
         xOMQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1760945882; x=1761550682;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=hqH0HWpT/EdCNTCYfdVo5iGOSb4NR+hUMd5jFUmAX14=;
        b=Kl7raDmnlBYdYQZZMaQaUAvkXLwUcF7dZmo7DcYzUje84Z9uUlgMkUgc2dfAat2QX/
         5GSDzX+1ig2CLAt3byShPTTYfJPPBGnNsBAvrQZPC7Q6/DYBMybBx82OTB5HXYZ4or64
         1cq8vHFN5agztMv/K2xfltWs9/qPT18/MsO2vRMK3n6ccthMHOUYdXo7hIRohl49Xa51
         RJisCnA7dJTjPIe+0A6xgiAzgsJ3eqVwhgcdZJPbrnzBBeIuBeUqiWJVAfg4EsxsFjWp
         z+PV9ShCE51PG/qlXNJ32pjT4xMUEdCPmKzP3YZDRcaVxLMxA5f8tzmqXsYoliw2TUo3
         TbUw==
X-Gm-Message-State: AOJu0Yz7yJq89swI5cF7dcnUT1gTYdNy9OhMDmlOPPjZOY/TDe3wfHye
	lSUivEQZkOJnADoUThkcZ+8YBOurdM6U+H6SAeCO+g0McMnstJuhtbXO40LHz7yy7BmZZcTqKoy
	ht6eAwPDjJA==
X-Gm-Gg: ASbGncuWFzOqMazyLQ0akwsstUDq8u9tk7nehcIP+XUuicdbUSp/4A7uPgqEireiLrK
	S3zyySJPprn9/pr61nTaziKg/JYR95Ht6zGjrBJuvX6Gsn7NlJcJkibJgM19zyuoCJ6/BsOLPYq
	stE7fVWK4arPxy2lVO8spjS8CJuOdfd8wH3IV7p7peigBFTKY4Zr4jfy428LCGax9VfOI6QtjdS
	+KGRPrnc3D7zQQWz+PPvZQFZlO3EL3UmmZNzn8WiecMXPhjAgDixkhDWtUPJCdAGQeIL6tw7C8e
	lulTAKJhEEvosgIS5ypfspwLF3z9LZKF/gv6WRdcH0dIzfWdSlAg0SZQ66rRFS5wvsVuA64I6In
	mM3d6fl/RrsMbzeMPg1LG9G4kdKINbx0Jc+58E7FVLDh4pWTqLbd5JnCnCIP4wNtFfPB6sKI=
X-Google-Smtp-Source: AGHT+IF+J99c3BjuyWdsu8xzQOF4DXrudVStKEkNAGSGk0TuASpnVmEJ7dzGy5TEWr/75SQDBm0b+Q==
X-Received: by 2002:a5d:59af:0:b0:427:60d:c4f3 with SMTP id ffacd0b85a97d-427060dc700mr7793615f8f.53.1760945882282;
        Mon, 20 Oct 2025 00:38:02 -0700 (PDT)
Received: from fedora ([2a01:e11:600c:d1a0:3dc8:57d2:efb7:51a8])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-47154d38309sm132862315e9.9.2025.10.20.00.38.01
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 20 Oct 2025 00:38:01 -0700 (PDT)
From: Ralf Lici <ralf@mandelbit.com>
To: netdev@vger.kernel.org
Cc: Ralf Lici <ralf@mandelbit.com>,
	Antonio Quartulli <antonio@openvpn.net>,
	Sabrina Dubroca <sd@queasysnail.net>,
	Andrew Lunn <andrew+netdev@lunn.ch>,
	"David S . Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>
Subject: [PATCH net v2 3/3] ovpn: use datagram_poll_queue for socket readiness in TCP
Date: Mon, 20 Oct 2025 09:37:31 +0200
Message-ID: <20251020073731.76589-4-ralf@mandelbit.com>
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

openvpn TCP encapsulation uses a custom queue to deliver packets to
userspace. Currently it relies on datagram_poll, which checks
sk_receive_queue, leading to false readiness signals when that queue
contains non-userspace packets.

Switch ovpn_tcp_poll to use datagram_poll_queue with the peer's
user_queue, ensuring poll only signals readiness when userspace data is
actually available. Also refactor ovpn_tcp_poll in order to enforce the
assumption we can make on the lifetime of ovpn_sock and peer.

Fixes: 11851cbd60ea ("ovpn: implement TCP transport")
Signed-off-by: Antonio Quartulli <antonio@openvpn.net>
Signed-off-by: Ralf Lici <ralf@mandelbit.com>
---
 drivers/net/ovpn/tcp.c | 26 ++++++++++++++++++++++----
 1 file changed, 22 insertions(+), 4 deletions(-)

diff --git a/drivers/net/ovpn/tcp.c b/drivers/net/ovpn/tcp.c
index 289f62c5d2c7..308fdbb75cea 100644
--- a/drivers/net/ovpn/tcp.c
+++ b/drivers/net/ovpn/tcp.c
@@ -560,16 +560,34 @@ static void ovpn_tcp_close(struct sock *sk, long timeout)
 static __poll_t ovpn_tcp_poll(struct file *file, struct socket *sock,
 			      poll_table *wait)
 {
-	__poll_t mask = datagram_poll(file, sock, wait);
+	struct sk_buff_head *queue = &sock->sk->sk_receive_queue;
 	struct ovpn_socket *ovpn_sock;
+	struct ovpn_peer *peer = NULL;
+	__poll_t mask;
 
 	rcu_read_lock();
 	ovpn_sock = rcu_dereference_sk_user_data(sock->sk);
-	if (ovpn_sock && ovpn_sock->peer &&
-	    !skb_queue_empty(&ovpn_sock->peer->tcp.user_queue))
-		mask |= EPOLLIN | EPOLLRDNORM;
+	/* if we landed in this callback, we expect to have a
+	 * meaningful state. The ovpn_socket lifecycle would
+	 * prevent it otherwise.
+	 */
+	if (WARN_ON(!ovpn_sock || !ovpn_sock->peer)) {
+		rcu_read_unlock();
+		pr_err_ratelimited("ovpn: null state in ovpn_tcp_poll!\n");
+		return 0;
+	}
+
+	if (ovpn_peer_hold(ovpn_sock->peer)) {
+		peer = ovpn_sock->peer;
+		queue = &peer->tcp.user_queue;
+	}
 	rcu_read_unlock();
 
+	mask = datagram_poll_queue(file, sock, wait, queue);
+
+	if (peer)
+		ovpn_peer_put(peer);
+
 	return mask;
 }
 
-- 
2.51.0


