Return-Path: <netdev+bounces-230091-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 9F634BE3E69
	for <lists+netdev@lfdr.de>; Thu, 16 Oct 2025 16:26:58 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id C476B5E11AA
	for <lists+netdev@lfdr.de>; Thu, 16 Oct 2025 14:24:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 31E35342C81;
	Thu, 16 Oct 2025 14:23:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=mandelbit.com header.i=@mandelbit.com header.b="ISdeTN0f"
X-Original-To: netdev@vger.kernel.org
Received: from mail-ed1-f45.google.com (mail-ed1-f45.google.com [209.85.208.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 556F7343218
	for <netdev@vger.kernel.org>; Thu, 16 Oct 2025 14:22:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760624580; cv=none; b=mHbAyIgtUgi4oKc6VPZIjjTN9Xyw2n4dLAOYmuPVlsbbuZHO5UIw3k9vYAErvwxptwbtk55fx6uHUcNXMWGfSZrFhh0PHqua/XFMVKTD7ZXhIkepNCu8QvUjJh2T2/im3tDKQnR+7+k7C46/0OF6I0qq7rjrUQ6jmmL4Wazo7wc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760624580; c=relaxed/simple;
	bh=N6Z4L9Tef2XH1W7eR3qOIPYw4Du5+cNQWPUDLeFhGa8=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=CD2rb3BgPSOOmxmEdusUTTPDSSIBTibAirlscNdZYF+LY+iSTe/85Ws3lf0EZZV9+l962G9e1aMHHvbFfBG4mbfcqd9gpvE8LUV4QIAk0bDi7JRAVRvtsaGEYiro/br88flebCht+zSw5Vd0qzpRJfeCogRUk5xrjhqucM8xWac=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=mandelbit.com; spf=pass smtp.mailfrom=mandelbit.com; dkim=pass (2048-bit key) header.d=mandelbit.com header.i=@mandelbit.com header.b=ISdeTN0f; arc=none smtp.client-ip=209.85.208.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=mandelbit.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=mandelbit.com
Received: by mail-ed1-f45.google.com with SMTP id 4fb4d7f45d1cf-639102bba31so1607998a12.2
        for <netdev@vger.kernel.org>; Thu, 16 Oct 2025 07:22:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=mandelbit.com; s=google; t=1760624576; x=1761229376; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=hqH0HWpT/EdCNTCYfdVo5iGOSb4NR+hUMd5jFUmAX14=;
        b=ISdeTN0fhdO5aty6rMdGd656QgBij0bbKjCN5bPoYNsw9p1YKApe4+9SqLLyntbQdB
         IlaRiyw0HoNiGHJfGx5KYPqO62gWB5HOBEzKKKnzxnk80LJTeu7nrDyhhOchzAAE0lfQ
         2LE2JdY5FG2LDjLS9+FsrlUEettMUaJjZHRbPnRwruL7TNbbPjrsdoxi60L5ozTPMJeE
         pEkSIbtLG/6UXeNHQ8gWAf/peUWWKqiGdalBkt8DPlSEiaapJShqrWW0bZ8+//jZP+E5
         qEiTqAg/cz8aWzC13/fJXdyiqBnwjL4D8k8rJdmO+9/5vq5bzAFaCv5q4OWu1ZnwCkyR
         Rr3g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1760624576; x=1761229376;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=hqH0HWpT/EdCNTCYfdVo5iGOSb4NR+hUMd5jFUmAX14=;
        b=DcpxbaMyZiH9QyR75S923NdhyTujOYovwmNj9RSKoixbRR7hN16F1liW+KfBa7Wcrw
         Do/B97aqCnSFjrj3jqVY4tsUTgv5qka8XMqbzwUbgnLQK5aYEoHb3Zecxc/3zUvx36QS
         gQN96TNyi9QwtaUNutja42oWjPxZliw2+O3jH8RFv+JD3el5n8Wkw/v1auphrgt1U0ds
         43zly558uM4+wz7nx2nE3jaxBzPA7vD4qmIvVn7xYCu2DKsPkSwJjYdPAIxeAtqHGxsF
         9gsNy3cE9m0SPEfxYzDo7CIA9Ts+dv1G90r4UB7WpXEpqjBsdLkkuve9f3/+yUj3XXSX
         tIgA==
X-Gm-Message-State: AOJu0Yx2seOQfor6R6p5FiEhMhEVwPpxx5lDvabZuf4pSnn6Pb1TYUo1
	1KTEq/Se6+81yefe0OHgVslZ/1bSGNfplPoAgqvWZlybCw7qpFCqwEnBDOm0SdNyv00u2xvktYs
	AkH/PZy8=
X-Gm-Gg: ASbGncvSY9nwDT1+FujcSWroEreeD/ZBNz307DfSMH59BPZ8/SKoBy0FQN0sVtCUhJ9
	9mAx5fey1WXjRyLeJwlgfi6wrx1R54htGywjo4GNBD+LpnBl0L16j3xIit3uOL2rrlWTW1Dgoyz
	8ZWh31aMBi9GVSv0uujON99qZePDJUhf7AEe0mXxVKs4d7nOL4wfgAT1mMTrGwT/A/BKzLGSwWg
	8gq636hUBM0QzHAF7oKnOe2Q7IUDF8Q6JsjzfoLnGnmZIB4WIZn4D2LcAWiCmjoxVFivZi/2joi
	D8hOdwdnpWntCVxWAQJrbhynfivzfX4fepGDYH7LRrlx0LUyufrIacLvWcj+eXtDnZFhwb0mq+u
	8qMjtfYcbA7/BC1Imwvi7p0/fIlXIKFoSUwsCMA4UhLVIccvVWSkUh/WrIzzab3CWiOsKoqdB2u
	kXP1pD+8+QVVpRYnzt
X-Google-Smtp-Source: AGHT+IHkQYf/GivOKEYuGj+70l9Jjsm5sxdGRJZ9HpQBGsOHcmFiE4GPXpJyL+ncV7ZVHMmhHc00Ug==
X-Received: by 2002:a05:6402:268a:b0:63b:f090:ac77 with SMTP id 4fb4d7f45d1cf-63c1f6b51ddmr49492a12.21.1760624576299;
        Thu, 16 Oct 2025 07:22:56 -0700 (PDT)
Received: from fedora ([2a01:e11:600c:d1a0:3dc8:57d2:efb7:51a8])
        by smtp.gmail.com with ESMTPSA id 4fb4d7f45d1cf-63a52b1e89csm16174574a12.19.2025.10.16.07.22.55
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 16 Oct 2025 07:22:56 -0700 (PDT)
From: Ralf Lici <ralf@mandelbit.com>
To: netdev@vger.kernel.org
Cc: Ralf Lici <ralf@mandelbit.com>,
	Sabrina Dubroca <sd@queasysnail.net>,
	"David S . Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	Antonio Quartulli <antonio@openvpn.net>
Subject: [PATCH net 3/3] ovpn: use datagram_poll_queue for socket readiness in TCP
Date: Thu, 16 Oct 2025 16:22:07 +0200
Message-ID: <20251016142207.411549-4-ralf@mandelbit.com>
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


