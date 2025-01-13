Return-Path: <netdev+bounces-157682-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id E92FDA0B2F8
	for <lists+netdev@lfdr.de>; Mon, 13 Jan 2025 10:35:10 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 771A018885F3
	for <lists+netdev@lfdr.de>; Mon, 13 Jan 2025 09:35:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2829A3DAC00;
	Mon, 13 Jan 2025 09:31:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=openvpn.net header.i=@openvpn.net header.b="bNMlSrtC"
X-Original-To: netdev@vger.kernel.org
Received: from mail-wr1-f41.google.com (mail-wr1-f41.google.com [209.85.221.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DCA69284A77
	for <netdev@vger.kernel.org>; Mon, 13 Jan 2025 09:31:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736760686; cv=none; b=AGUHAZG4hxjyUz7/3V6u3sRtunXPYNhst15W3wpF3FGEjpnFIBKEcUJeQioZ5IAOwqas2hE3GWengYwnFw6H2Mwo9AwYRdhEhRz0NCahC97sRbM0hhmzXosOo7lsV/v2fZjaTPU2J3ZED4fUdWGK1JWny3RbLaJluvCer6ll7R4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736760686; c=relaxed/simple;
	bh=5nB6P1uqMYCKCgFkweOVzibQBqTXu4/Iu+/EqgwmLPc=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=iLQ1aWckq1zVFthOGFFQ57B5CUj4M3k1X/spThjN+s0bGVhQ8tYgkjcAoptuo/9jnJdPrkVbT30SQapepJ4m43ju0Ta+jS3+0EcaKgOgB41/ADh0HyOM5+aHkQdzPByTP1g5IkYs0UqO2pFrsCp6kOsqywNsnFccEUnmBc1Ttdc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=openvpn.net; spf=pass smtp.mailfrom=openvpn.com; dkim=pass (2048-bit key) header.d=openvpn.net header.i=@openvpn.net header.b=bNMlSrtC; arc=none smtp.client-ip=209.85.221.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=openvpn.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=openvpn.com
Received: by mail-wr1-f41.google.com with SMTP id ffacd0b85a97d-385e87b25f0so3175871f8f.0
        for <netdev@vger.kernel.org>; Mon, 13 Jan 2025 01:31:23 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=openvpn.net; s=google; t=1736760682; x=1737365482; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=dPCdnsDybTbSek31CaEhyHUdFmbRNtk8egB04xoYnP8=;
        b=bNMlSrtCtinVuHx/VkGuewB4Fejr8lcxGohC055Ac+uAHkvHAnC24usz8QuU3wm+tN
         XuTWpxP5cq/vIMIWEcyxjc9Q0Bh6Jb0NGAmkthj9R0ClTj0JCCojZVmbYfKoVDCjPPaO
         RLTVDQpb195f91zOfhh6fgykZs+9d6znVnNEQonot4LpBqiuotOLW8uq1XE5YLd6iQmf
         ux0m8bd9xCmjyV11bGPTABdejo2HaEcZ1r6S/f0wtlB0cGRsN7hRZMcoPNvSAd4vSU8B
         aRrNXLnRV9tsM/+namY2sBtYKteYn+4StbOaHdQjyZOGp17dT53Ci7bya4FcpBk4MtWx
         NSUQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1736760682; x=1737365482;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=dPCdnsDybTbSek31CaEhyHUdFmbRNtk8egB04xoYnP8=;
        b=exFv4Y+h8oAJF9yBGPxsr2/YQoAXtZjEpaf45BisAu4fpY4OLgZ18AuRr3FzbhOKk0
         FZ/SIIXwmDMlCcEXDn9MIHuIjebJqx6ZE5cWVJL6/G760YYiMxpfswsMbjxB853exQOO
         waEEB2KKeZJKeXEzrYZpVZOUOs/G7XrrJuM4mi8eNc3hp9NJTLEgMj+hqstjBJRkohyf
         o5qpixyoe/uwIhsvJ0PPKutFT12PZUXSA9XVC8RklwXHK63NO4LTAZCB72M2EHjw0f/o
         F2zQoCGqsToaAF6OBs08AijfmJ8Hx65N9e7sXbkuB0UtvoMGBelUqkLweSY4Sr+aPpzg
         QUtg==
X-Gm-Message-State: AOJu0YypRS+EMnXzW02Fo9CBDBkumFy5BSZ8jNiB+njKoPwxaKr8sv/C
	ErQMOAiqc4o/a78eu4vcyVsy9nWY2j4Sd9KSLFig1Whd1l976K2SlvfAhKcpjUc=
X-Gm-Gg: ASbGncvHcZOyCv7PV18sDv/qXwnDQU757dGaHJoipJRGCt5SBmux3j9pxMEc3Xl0kuD
	dEcERPsexyX9r7cYPCEbsBLScQvAUfBRVW1BJdQPJD0aBs0n7YA7HLn0+FsgLTV+41YqFWpEtLl
	O/EzzygF9RkyZKdshuIneVF2L0BCVHCvSQ6MhX7L6GesNBjWoKRo8C95105un73Noq6gXt8oV4E
	RcnUMJeTsJgNTccSmcyxW0Qjjc/6u/e8dd109NaBP7tWPCAF0ApRN1LGwP7qsv7uZrc
X-Google-Smtp-Source: AGHT+IFIs7dhmzOrcVNorA82vYYmPXs8ShfyPm8K48NyT9urWqDSFZAWdFqVGGkPXvzzWIaeUZHP+Q==
X-Received: by 2002:a05:6000:1aca:b0:386:3bde:9849 with SMTP id ffacd0b85a97d-38a8b0caa82mr13477567f8f.12.1736760682044;
        Mon, 13 Jan 2025 01:31:22 -0800 (PST)
Received: from serenity.mandelbit.com ([2001:67c:2fbc:1:8305:bf37:3bbd:ed1d])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-38a8e4b8124sm11528446f8f.81.2025.01.13.01.31.20
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 13 Jan 2025 01:31:21 -0800 (PST)
From: Antonio Quartulli <antonio@openvpn.net>
Date: Mon, 13 Jan 2025 10:31:33 +0100
Subject: [PATCH net-next v18 14/25] ovpn: add support for MSG_NOSIGNAL in
 tcp_sendmsg
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250113-b4-ovpn-v18-14-1f00db9c2bd6@openvpn.net>
References: <20250113-b4-ovpn-v18-0-1f00db9c2bd6@openvpn.net>
In-Reply-To: <20250113-b4-ovpn-v18-0-1f00db9c2bd6@openvpn.net>
To: netdev@vger.kernel.org, Eric Dumazet <edumazet@google.com>, 
 Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, 
 Donald Hunter <donald.hunter@gmail.com>, 
 Antonio Quartulli <antonio@openvpn.net>, Shuah Khan <shuah@kernel.org>, 
 sd@queasysnail.net, ryazanov.s.a@gmail.com, 
 Andrew Lunn <andrew+netdev@lunn.ch>
Cc: Simon Horman <horms@kernel.org>, linux-kernel@vger.kernel.org, 
 linux-kselftest@vger.kernel.org, Xiao Liang <shaw.leon@gmail.com>
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=openpgp-sha256; l=2496; i=antonio@openvpn.net;
 h=from:subject:message-id; bh=5nB6P1uqMYCKCgFkweOVzibQBqTXu4/Iu+/EqgwmLPc=;
 b=owEBbQGS/pANAwAIAQtw5TqgONWHAcsmYgBnhN2HktwmWnZ35SPI5LzMnLooHJ3jRMj2Uk/Tv
 fe9X/26wCeJATMEAAEIAB0WIQSZq9xs+NQS5N5fwPwLcOU6oDjVhwUCZ4TdhwAKCRALcOU6oDjV
 h03gB/9555eoMt4Obn7X4D5zArMCrJXlFoC9L4yCFiOlnL6hiDvMy4g1jJGAsF6JK03VfiGH7rg
 w77kkSjUM2cdhOIziIkf2Elhwu719OerNemkYN6ZGphds6Nf9pCteUno0gdc6JllJImAjz7V7aQ
 334xDIO7ZhcPI3wnv5AfeGFHWz5tTr3xUopGfpLG3LHkmB4oWtvV4gfMGRKwpmD4sia52XN/O6X
 GxkGIA9ScjIze52t3s5bCjZEPeX4DfrNPwGChg8fjPJ3r7c5CiCFXae/3hXJ5as8pL78kHRJxaP
 G+1pyLQEhDqz5P0lMffh+V/rF9lX3x6tHY0tR29b7twf560r
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
index f42b449b24d04ac247576d9de2c0513683e0072c..9776d87acc4742661423cd1824ac12b385889a97 100644
--- a/drivers/net/ovpn/tcp.c
+++ b/drivers/net/ovpn/tcp.c
@@ -217,6 +217,7 @@ void ovpn_tcp_socket_detach(struct ovpn_socket *ovpn_sock)
 static void ovpn_tcp_send_sock(struct ovpn_peer *peer)
 {
 	struct sk_buff *skb = peer->tcp.out_msg.skb;
+	int ret, flags;
 
 	if (!skb)
 		return;
@@ -227,9 +228,11 @@ static void ovpn_tcp_send_sock(struct ovpn_peer *peer)
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
@@ -369,7 +372,7 @@ static int ovpn_tcp_sendmsg(struct sock *sk, struct msghdr *msg, size_t size)
 
 	lock_sock(peer->sock->sock->sk);
 
-	if (msg->msg_flags & ~MSG_DONTWAIT) {
+	if (msg->msg_flags & ~(MSG_DONTWAIT | MSG_NOSIGNAL)) {
 		ret = -EOPNOTSUPP;
 		goto peer_free;
 	}
@@ -402,6 +405,7 @@ static int ovpn_tcp_sendmsg(struct sock *sk, struct msghdr *msg, size_t size)
 		goto peer_free;
 	}
 
+	ovpn_skb_cb(skb)->nosignal = msg->msg_flags & MSG_NOSIGNAL;
 	ovpn_tcp_send_sock_skb(sock->peer, skb);
 	ret = size;
 peer_free:

-- 
2.45.2


