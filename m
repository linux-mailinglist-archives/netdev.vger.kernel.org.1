Return-Path: <netdev+bounces-164987-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 7D880A2FF6D
	for <lists+netdev@lfdr.de>; Tue, 11 Feb 2025 01:44:55 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 0F34E1884AC5
	for <lists+netdev@lfdr.de>; Tue, 11 Feb 2025 00:44:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 94C1C1E9916;
	Tue, 11 Feb 2025 00:41:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=openvpn.net header.i=@openvpn.net header.b="YUpkXHaE"
X-Original-To: netdev@vger.kernel.org
Received: from mail-wm1-f41.google.com (mail-wm1-f41.google.com [209.85.128.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 530521E5B7D
	for <netdev@vger.kernel.org>; Tue, 11 Feb 2025 00:41:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739234482; cv=none; b=NnGoPxY0rlrBzi7AkkM0l5bsTj1fSAx+Toygl/UaeeSVO6jTxL9EwKOw+W+/CMwnmeLBdLkvvFYOFteM3wXKI3b9GlQRMY7ddctXgkZApn2gbdCxqy7ol3zIZxcJYQmzawS8gbYrwEuBb+j/vl2h878xhRB9ZGXKtD8399B5POs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739234482; c=relaxed/simple;
	bh=KD5BFpOHNqSvy48hENeZDo81i4H16OBz+7xPO4NE0r0=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=BYi/Of0rc2WEiZtlJKnEVHBGozJD226/yJs2IS11Sp+VpOgzNN42084w0TKTylWFLC4jjUqksLnp7xDG0NcHs0+AYQ7I71VPhs2w65iEcjjUMQcgKaG0tHtSrnP2Jwzjy2tm6xSkGMkM7/SJs9bjAp8Z4oFkCMTgxOmc8a3ORo4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=openvpn.net; spf=pass smtp.mailfrom=openvpn.com; dkim=pass (2048-bit key) header.d=openvpn.net header.i=@openvpn.net header.b=YUpkXHaE; arc=none smtp.client-ip=209.85.128.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=openvpn.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=openvpn.com
Received: by mail-wm1-f41.google.com with SMTP id 5b1f17b1804b1-43618283d48so34313475e9.1
        for <netdev@vger.kernel.org>; Mon, 10 Feb 2025 16:41:20 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=openvpn.net; s=google; t=1739234478; x=1739839278; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=+EI3H1b1PYT7I1BdLZ0sMTpvWIzL+1PSLPvHLdSDaSw=;
        b=YUpkXHaEx091KYbmKYpEGYgGdKH/GpDsCGP1W0xI+xWnp7EtkFpqDwLpw3tkTzagNV
         MGbKjgyYf0Yw2Yn0fdXe0i6Q5PEJCKbBmlSAOgkhqgCMyUsNE9iEHtlOxEwVlSe4G8JZ
         Hpo6TpDmTkkXDMFm5ylTabyIRoVH0MP0XpW0HuUEbBJlFFSK/FOTzBWZ9sjAt6pPCBxO
         n0MQgQ7/745U4XAjZK2RzBKS9IBsDpOpic7TWeZ+SHXKyb0NQ4iQbIcqd7ZRO45a1Vt1
         TLnpWtnxm8fXDG5g0oLhDGXu/CesvEAA2gtu5CNlTeYQuZNauT+NYlUuVTiMjlGhboMx
         mPZA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1739234478; x=1739839278;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=+EI3H1b1PYT7I1BdLZ0sMTpvWIzL+1PSLPvHLdSDaSw=;
        b=HOWt1h6tGAW5RBEzbObLDGYYReZ29No4weSrjRSuZbkyJlggU5o0SjCxWswxVy7dex
         kqP5B3x0S34LepVlj7kOEndx9zFrZhLbERoWKEOvCivu6VTzXcSXnbrICzTq1uSI6UMs
         9Aq/Q06fY6PaUctyypB89rmbPukBzkY8Rcd/kRkoch5/TfiQTCR5VTlHUNew8tP+1qON
         LkU+XqXXTzoCUyLlWejTwK+DdWjmT3RaZkNy0klrK+qwlqWNhS0P57vvmZbE4K1qquZK
         3rH/DChF657jZBdz3PuF3Tt89PrVhUVjItCiMmEg4TWUrSoug1eo+s+X3lxuvMHhiUmB
         w2KQ==
X-Gm-Message-State: AOJu0Yx9kgotRZhp3KWKpV4hLP8CCB3AkiHQKMSKX8mB43KkYPT8LkaV
	gvYbvLkX3hMdvHhWAaj73bb4S6uX2f6fmC/bVgAHY+VZRPotDbHDGwdVvLVI/lU=
X-Gm-Gg: ASbGnct3a8Fq+Q8Xm1zIdYd+HWy8qrqXHaXSu6Uf7A5mf3X1R7NUsofbivDp67Vc/1H
	JQAKVgbTHCxHFzBFwrzOtq/gjBOnhRR28Q6Cr0kyC6t8lZA/gBndTFtTTewKHFL+fL62cKfQoxZ
	O+jKprpcVEZEim3onLXPv2Qxt1T4An+Avuv83t3pxkD2OzmD83qjMyTvc1uS/48A+Rv3nx3UBd8
	+NFgHjmAahSizs1qM/bYtb1APE1OKgU4l4mxf5R3JMhu6l4bvED+HEkugHK0D4gXgFxBepX1fnW
	8VVvuKHMkqDc5RjiHMnhi5KJcCw=
X-Google-Smtp-Source: AGHT+IFKSdsxUH0mb61Yv8dAVEGvPV8nyRzJdwcsKzf0RWS0xgzb4/3SNNPkbAAI2sAkmgFuFxDXbw==
X-Received: by 2002:a05:600c:4e13:b0:434:9499:9e87 with SMTP id 5b1f17b1804b1-4394c8538fdmr13205315e9.25.1739234478587;
        Mon, 10 Feb 2025 16:41:18 -0800 (PST)
Received: from serenity.mandelbit.com ([2001:67c:2fbc:1:1255:949f:f81c:4f95])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4394dc1bed2sm3388435e9.0.2025.02.10.16.41.17
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 10 Feb 2025 16:41:18 -0800 (PST)
From: Antonio Quartulli <antonio@openvpn.net>
Date: Tue, 11 Feb 2025 01:40:07 +0100
Subject: [PATCH net-next v19 14/26] ovpn: add support for MSG_NOSIGNAL in
 tcp_sendmsg
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250211-b4-ovpn-v19-14-86d5daf2a47a@openvpn.net>
References: <20250211-b4-ovpn-v19-0-86d5daf2a47a@openvpn.net>
In-Reply-To: <20250211-b4-ovpn-v19-0-86d5daf2a47a@openvpn.net>
To: netdev@vger.kernel.org, Eric Dumazet <edumazet@google.com>, 
 Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, 
 Donald Hunter <donald.hunter@gmail.com>, 
 Antonio Quartulli <antonio@openvpn.net>, Shuah Khan <shuah@kernel.org>, 
 sd@queasysnail.net, ryazanov.s.a@gmail.com, 
 Andrew Lunn <andrew+netdev@lunn.ch>
Cc: Simon Horman <horms@kernel.org>, linux-kernel@vger.kernel.org, 
 linux-kselftest@vger.kernel.org, Xiao Liang <shaw.leon@gmail.com>
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=openpgp-sha256; l=2456; i=antonio@openvpn.net;
 h=from:subject:message-id; bh=KD5BFpOHNqSvy48hENeZDo81i4H16OBz+7xPO4NE0r0=;
 b=owEBbQGS/pANAwAIAQtw5TqgONWHAcsmYgBnqpyNw21/hSe4FFL2FB90CoPI8CErMCqUwISSR
 b0KPLN4+omJATMEAAEIAB0WIQSZq9xs+NQS5N5fwPwLcOU6oDjVhwUCZ6qcjQAKCRALcOU6oDjV
 h+hJCACw4xagGSlZCHvOYq7pyy+QacdWEq0boNs7Y5MNnj4dTkcTDE40KlY+hm/PLHcde3PjZUv
 46qUAzT8iKBWyErBWxcw7dnbaVEU61U2W1+YQsCET2ai0u4gRf40CMOFCPQixYEgoAMCntCcop/
 ek3yc8Zxgj8LqUF/elVwPiyEuzqQcKNtLJ7TNnYj9WubT7zAWxVP3F2HJEY4kmWeTqc9fap2TpV
 XCYszQES0HzAjJ3RDwThMTdZu0o0Pn5ys1bDbEzW7iF/UL6VjJ+klIIjvPc/lLlUNwjrJYX3D7f
 9Bwm+2mlK+aJnksQIQVYbDgKvJYK9FZYUCJ6p8Lv4j9eh0CS
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
index 6a256684d68682bd4dfab93dbff092d238192316..e4df039f959e8af945844b2bbcd9ea416e1bcec9 100644
--- a/drivers/net/ovpn/skb.h
+++ b/drivers/net/ovpn/skb.h
@@ -25,6 +25,7 @@ struct ovpn_cb {
 	struct scatterlist *sg;
 	u8 *iv;
 	unsigned int payload_offset;
+	bool nosignal;
 };
 
 static inline struct ovpn_cb *ovpn_skb_cb(struct sk_buff *skb)
diff --git a/drivers/net/ovpn/tcp.c b/drivers/net/ovpn/tcp.c
index c7eb96d79e0229d178e1cf090cea45361730685e..c4d90cfeaaf7d032270fa2c9cb78f4ca7745750f 100644
--- a/drivers/net/ovpn/tcp.c
+++ b/drivers/net/ovpn/tcp.c
@@ -210,6 +210,7 @@ void ovpn_tcp_socket_detach(struct ovpn_socket *ovpn_sock)
 static void ovpn_tcp_send_sock(struct ovpn_peer *peer, struct sock *sk)
 {
 	struct sk_buff *skb = peer->tcp.out_msg.skb;
+	int ret, flags;
 
 	if (!skb)
 		return;
@@ -220,9 +221,11 @@ static void ovpn_tcp_send_sock(struct ovpn_peer *peer, struct sock *sk)
 	peer->tcp.tx_in_progress = true;
 
 	do {
-		int ret = skb_send_sock_locked(sk, skb,
-					       peer->tcp.out_msg.offset,
-					       peer->tcp.out_msg.len);
+		flags = ovpn_skb_cb(skb)->nosignal ? MSG_NOSIGNAL : 0;
+		ret = skb_send_sock_locked_with_flags(sk, skb,
+						      peer->tcp.out_msg.offset,
+						      peer->tcp.out_msg.len,
+						      flags);
 		if (unlikely(ret < 0)) {
 			if (ret == -EAGAIN)
 				goto out;
@@ -363,7 +366,7 @@ static int ovpn_tcp_sendmsg(struct sock *sk, struct msghdr *msg, size_t size)
 
 	lock_sock(sk);
 
-	if (msg->msg_flags & ~MSG_DONTWAIT) {
+	if (msg->msg_flags & ~(MSG_DONTWAIT | MSG_NOSIGNAL)) {
 		ret = -EOPNOTSUPP;
 		goto peer_free;
 	}
@@ -396,6 +399,7 @@ static int ovpn_tcp_sendmsg(struct sock *sk, struct msghdr *msg, size_t size)
 		goto peer_free;
 	}
 
+	ovpn_skb_cb(skb)->nosignal = msg->msg_flags & MSG_NOSIGNAL;
 	ovpn_tcp_send_sock_skb(peer, sk, skb);
 	ret = size;
 peer_free:

-- 
2.45.3


