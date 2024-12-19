Return-Path: <netdev+bounces-153179-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 4F6AE9F721A
	for <lists+netdev@lfdr.de>; Thu, 19 Dec 2024 02:50:54 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 93EE01886E90
	for <lists+netdev@lfdr.de>; Thu, 19 Dec 2024 01:48:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 396A11A9B4E;
	Thu, 19 Dec 2024 01:42:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=openvpn.net header.i=@openvpn.net header.b="DjSHqlSM"
X-Original-To: netdev@vger.kernel.org
Received: from mail-wm1-f50.google.com (mail-wm1-f50.google.com [209.85.128.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A0E2A1A4E77
	for <netdev@vger.kernel.org>; Thu, 19 Dec 2024 01:42:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734572551; cv=none; b=eXO2Dp6whYQAwDpCl7yA0Y+0h9YHqF5otZOwuwQKJt94EUYd8GBrFIPCgL20OFIrkgBOSdXWVjw+avjwvlAAvtjp97nAwLPRoOOx9HSmkqhZzYVDj081pVdYjBT/Ws4dPxO1wuo+NE71f6ewmweG6kcr9tC/ydRKeRT5WV/N4ic=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734572551; c=relaxed/simple;
	bh=zxwzzE3nSe/2L9mPGgMJNnofJbeP+COcEZoGUu6OnOA=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=ojQIFopNsTTi1ZPPn5MyyAlfKwdWRL5GPwhtNRvE7AJwTsTKs+NUQrjFvysotqYxTHKT/UeRQjZwN0b3aTvxQy7HASoad6mzBfILb9THkiIwqMrvVhSS5ZKkO2BpLqDctO7yiOo8/HwLWRUD1SCQz3l3ctYWx+KBTK7qFd/lIpo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=openvpn.net; spf=pass smtp.mailfrom=openvpn.com; dkim=pass (2048-bit key) header.d=openvpn.net header.i=@openvpn.net header.b=DjSHqlSM; arc=none smtp.client-ip=209.85.128.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=openvpn.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=openvpn.com
Received: by mail-wm1-f50.google.com with SMTP id 5b1f17b1804b1-43634b570c1so1879545e9.0
        for <netdev@vger.kernel.org>; Wed, 18 Dec 2024 17:42:26 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=openvpn.net; s=google; t=1734572545; x=1735177345; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=kInVyKQTg4IxbPTkwUrhctxmy7AbAvQ2mFaojiMhLv8=;
        b=DjSHqlSMKFy3jP9sv6QO+YsDReUYpnF11n39+El2jvSzbLiSLJ4K0Ao7Zdv+716jyr
         9Mx3tNhozT8hyUp5B6OTn0ZPBVofBfUyFjF378FWbbfM5RVBUT/OQc8Ljgp7tlXijZ84
         TVi+JbPG/wGFIqYB0VeWDk6LDYEXP931ya4Qs+/jXbnGkLZ/WIrrz1gepHcvzoClPYJ/
         aBApuF+cudXz3BTVk/bkdkyuFYp2B1oMVq6qMoIsWzaxF0t5menH8JdHDhAzsGJrOcKG
         laM9BMNwlNxCaYnD4ovAxywIkW3uEz2Sn1ElAt9kvJcKZaU52PF6l09Rk0Bx1wDQYj61
         YIrw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1734572545; x=1735177345;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=kInVyKQTg4IxbPTkwUrhctxmy7AbAvQ2mFaojiMhLv8=;
        b=X8PhPpxO5lLE9uub6PRmp82fQU9PEQxtYqx1PbjnPcP3moh+4HltRQqdlAEVkbiiXs
         hMiuHCjrinouRd6QGyncWlC3JMqElsY2C/QNrlyL8tQW0aT4AnRXesLuq/7tjG9wkDUT
         0YquYVlZZjaVqGbs1p1eID5qScxsps8n+QpMI9/G0L7R6ReDnxz2Hm3+JAXD+YIHQL4J
         CpWrhJyDlsr4+uf00XZifK/ZPGBsqf3ZSq71DyojC4yYolJmt5heb82k6orDj2dci5Kb
         n9ZTLWRkl5D2YMqQjcU4VzdPfairAM7B5nJq6V1j3mRSsSmqycHvKuJPCpf4gha1JLuQ
         eBQw==
X-Gm-Message-State: AOJu0YyQ9RCAwUfzv7DNd2Bm7oXdaY+dbsV6qoTBskjURLc5FW11LICm
	JRmtUr4ZOvV0jB8vrxElOiGOA7xrZOOWeH/aeq4u93dG6KIEquDfSTCr6HGc3A8=
X-Gm-Gg: ASbGnctCd30G0vZiwa2TZBKrubhdOyrKcKNrcfr8BkoQYgFGWfAxfh9Dz7IhdQ9zZXX
	G/SrdTDYge7Neg7cAM5SnLWlHiut8lz/0Ng8iEMAS/zZqRcrMhG9cM45/L7GpN/liBCj1LSrMzM
	N+bSNxyZZAhRL8XFpqcr9sITgUQuQiWE7j6bPE1bj3FjTgBc7xLoYEq6bcaH8bq/xizmVQel2o7
	p9Rk/Awepc+gOuwdbjHl6ygRGea+vrh1qvWAa5kcp9i24OcaXmldPQ8V9l0UvTKWUdy
X-Google-Smtp-Source: AGHT+IEVmLU2Pt78q4Xlm8RP+cEm+XNhbr5lxPwZIGZ7G5fq62WLFtsMu25xCn1BU9rRwsyqYoasZQ==
X-Received: by 2002:a05:600c:4587:b0:434:fbd5:2f0a with SMTP id 5b1f17b1804b1-4365535bb16mr46245725e9.9.1734572544857;
        Wed, 18 Dec 2024 17:42:24 -0800 (PST)
Received: from serenity.mandelbit.com ([2001:67c:2fbc:1:3257:f823:e26a:c3fa])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4364a376846sm63615715e9.0.2024.12.18.17.42.23
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 18 Dec 2024 17:42:24 -0800 (PST)
From: Antonio Quartulli <antonio@openvpn.net>
Date: Thu, 19 Dec 2024 02:42:09 +0100
Subject: [PATCH net-next v16 15/26] ovpn: add support for MSG_NOSIGNAL in
 tcp_sendmsg
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20241219-b4-ovpn-v16-15-3e3001153683@openvpn.net>
References: <20241219-b4-ovpn-v16-0-3e3001153683@openvpn.net>
In-Reply-To: <20241219-b4-ovpn-v16-0-3e3001153683@openvpn.net>
To: netdev@vger.kernel.org, Eric Dumazet <edumazet@google.com>, 
 Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, 
 Donald Hunter <donald.hunter@gmail.com>, 
 Antonio Quartulli <antonio@openvpn.net>, Shuah Khan <shuah@kernel.org>, 
 sd@queasysnail.net, ryazanov.s.a@gmail.com, 
 Andrew Lunn <andrew+netdev@lunn.ch>
Cc: Simon Horman <horms@kernel.org>, linux-kernel@vger.kernel.org, 
 linux-kselftest@vger.kernel.org, Xiao Liang <shaw.leon@gmail.com>
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=openpgp-sha256; l=2486; i=antonio@openvpn.net;
 h=from:subject:message-id; bh=zxwzzE3nSe/2L9mPGgMJNnofJbeP+COcEZoGUu6OnOA=;
 b=owEBbQGS/pANAwAIAQtw5TqgONWHAcsmYgBnY3oWXZbP6sWaytRRHFfzfox6RkRNuuwyidrp+
 rPHRR3XiYeJATMEAAEIAB0WIQSZq9xs+NQS5N5fwPwLcOU6oDjVhwUCZ2N6FgAKCRALcOU6oDjV
 h63zCAC1r1HFA/sDcwB4AZl02DRa2Jm0cd7Zu8/9Xdz+Uasf/frFbIesh/NTWUgv+MyZJRaviaY
 KOM8EHkmmaQv+wAYTHjA5LL31tntBO2/Au2c/Z7vZsQc6B+vP6sG59RmXyokNWoTzz0lx6DxPdm
 imjtAc/4ifLVzBjMgFQCKMGzB+2EYC7dmcaGR5S3PkckB1TETLn55ybKJwAKlJ3WFENZTXEQQiQ
 x91VzSCl/xjW4l6q+S7EFTYOuW0hMVE1m0/wdBtRUvofc2oQvwkDZAtyp6q8S2v/74bQId+X4t0
 EZoHoPUg3NOVeR0hbOa0wAAIUstVX4uCH/3ENo4VXLyQeNFw
X-Developer-Key: i=antonio@openvpn.net; a=openpgp;
 fpr=CABDA1282017C267219885C748F0CCB68F59D14C

Userspace may want to pass the MSG_NOSIGNAL flag to
tcp_sendmsg() in order to avoid generating a SIGPIPE.

To pass this flag down the TCP stack a new skb sending API
accepting a flags argument is introduced.

Cc: Eric Dumazet <edumazet@google.com>
Cc: Paolo Abeni <pabeni@redhat.com>
Signed-off-by: Antonio Quartulli <antonio@openvpn.net>
---
 drivers/net/ovpn/skb.h |  1 +
 drivers/net/ovpn/tcp.c | 12 ++++++++----
 2 files changed, 9 insertions(+), 4 deletions(-)

diff --git a/drivers/net/ovpn/skb.h b/drivers/net/ovpn/skb.h
index fd19cc3081227e01c4c1ef25155de614b2dc2795..67c6e1e4a79041198f554d7c534bc2373ca96033 100644
--- a/drivers/net/ovpn/skb.h
+++ b/drivers/net/ovpn/skb.h
@@ -24,6 +24,7 @@ struct ovpn_cb {
 	struct aead_request *req;
 	struct scatterlist *sg;
 	unsigned int payload_offset;
+	bool nosignal;
 };
 
 static inline struct ovpn_cb *ovpn_skb_cb(struct sk_buff *skb)
diff --git a/drivers/net/ovpn/tcp.c b/drivers/net/ovpn/tcp.c
index 9658513cf021681d20de2f4a581ca032d9d3dfdc..f1be4cd94e16953b39901046ede4381018e8a615 100644
--- a/drivers/net/ovpn/tcp.c
+++ b/drivers/net/ovpn/tcp.c
@@ -222,6 +222,7 @@ void ovpn_tcp_socket_detach(struct socket *sock)
 static void ovpn_tcp_send_sock(struct ovpn_peer *peer)
 {
 	struct sk_buff *skb = peer->tcp.out_msg.skb;
+	int ret, flags;
 
 	if (!skb)
 		return;
@@ -232,9 +233,11 @@ static void ovpn_tcp_send_sock(struct ovpn_peer *peer)
 	peer->tcp.tx_in_progress = true;
 
 	do {
-		int ret = skb_send_sock_locked(peer->sock->sock->sk, skb,
-					       peer->tcp.out_msg.offset,
-					       peer->tcp.out_msg.len);
+		flags = ovpn_skb_cb(skb)->nosignal ? MSG_NOSIGNAL : 0;
+		ret = skb_send_sock_locked_with_flags(peer->sock->sock->sk, skb,
+						      peer->tcp.out_msg.offset,
+						      peer->tcp.out_msg.len,
+						      flags);
 		if (unlikely(ret < 0)) {
 			if (ret == -EAGAIN)
 				goto out;
@@ -371,7 +374,7 @@ static int ovpn_tcp_sendmsg(struct sock *sk, struct msghdr *msg, size_t size)
 
 	lock_sock(peer->sock->sock->sk);
 
-	if (msg->msg_flags & ~MSG_DONTWAIT) {
+	if (msg->msg_flags & ~(MSG_DONTWAIT | MSG_NOSIGNAL)) {
 		ret = -EOPNOTSUPP;
 		goto peer_free;
 	}
@@ -404,6 +407,7 @@ static int ovpn_tcp_sendmsg(struct sock *sk, struct msghdr *msg, size_t size)
 		goto peer_free;
 	}
 
+	ovpn_skb_cb(skb)->nosignal = msg->msg_flags & MSG_NOSIGNAL;
 	ovpn_tcp_send_sock_skb(sock->peer, skb);
 	ret = size;
 peer_free:

-- 
2.45.2


