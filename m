Return-Path: <netdev+bounces-157290-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 31CEEA09DE5
	for <lists+netdev@lfdr.de>; Fri, 10 Jan 2025 23:29:53 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 7D0E6168E91
	for <lists+netdev@lfdr.de>; Fri, 10 Jan 2025 22:29:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 67A9F225A3F;
	Fri, 10 Jan 2025 22:26:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=openvpn.net header.i=@openvpn.net header.b="YOjS5Zm0"
X-Original-To: netdev@vger.kernel.org
Received: from mail-wm1-f48.google.com (mail-wm1-f48.google.com [209.85.128.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2235F225409
	for <netdev@vger.kernel.org>; Fri, 10 Jan 2025 22:26:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736547994; cv=none; b=crAU/4KPl/WOfkg9K+KnZuY9N0HgJPBU+S9mkcL2h0MiX6UzmdMwZBno5MhrvBSQVQJbS2jmiB+K23Y+FTgWqocTQrUKby5wp3YJCpdOASJwIogaYhE4a30YSrX+WBVj91sL7e1Tzh2Qp+7T57cu68czN6deJYk4hwj+e6vGuVo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736547994; c=relaxed/simple;
	bh=5nB6P1uqMYCKCgFkweOVzibQBqTXu4/Iu+/EqgwmLPc=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=Ha4tIOYvhoQgUveywPa112eDAKE/TZDXvWQ4TA6cPotC8f0PAG9MpYZI3Exqy/z/mn3Y3Nwl5JzGp8ITWyrM8OGo90ldv+c0bjtGOfiBrs0T6nlWdMY4nnHhznuxw3yWZM3DgaIADHV+XqmUh9pdxBWniaZkasm2sQ7wBxK6mc4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=openvpn.net; spf=pass smtp.mailfrom=openvpn.com; dkim=pass (2048-bit key) header.d=openvpn.net header.i=@openvpn.net header.b=YOjS5Zm0; arc=none smtp.client-ip=209.85.128.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=openvpn.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=openvpn.com
Received: by mail-wm1-f48.google.com with SMTP id 5b1f17b1804b1-4361b0ec57aso24970495e9.0
        for <netdev@vger.kernel.org>; Fri, 10 Jan 2025 14:26:30 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=openvpn.net; s=google; t=1736547989; x=1737152789; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=dPCdnsDybTbSek31CaEhyHUdFmbRNtk8egB04xoYnP8=;
        b=YOjS5Zm0v+c7ylzMx6xjWVUJeeEIMQJuw8VDRDzOukvQ/2sB94QaKWZGMkbP3CNq+S
         06ta09lxkCdbpTF4lxqkWY2xSECmQC6Vl2LZQ30fx3nd61kTfoirYoN5yukKZNz1h4nI
         Y8m6J3CrN3l53jHEMpcV+u8AtI7tH70bgx1nNEppRyX9UqoVNeYL8xnDhhFROaYxyD0D
         Sq3gfSsOens0xBMm+KAgTHGP1NLFOVOqwzEW9406wNV5+CQ+70ADY2NQYvF40I/ocVJQ
         Eh/n4ztDkXDtRpewtvHHFMZNWItxQj4HOwQuaDmFqc+zyiWJ5i3GnRVNpbm/MfTs5/lz
         oEtg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1736547989; x=1737152789;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=dPCdnsDybTbSek31CaEhyHUdFmbRNtk8egB04xoYnP8=;
        b=e2uOJMYXMCrd1bpqnrRY2e+egTyv373SkdRtbQn0IOWEI3olpGNzB9qLnt2KEz/aOV
         qkUrHKgeFQUgct4G0lEtd5Pu9jkAOlNs2/ss8zYlYRhABQGjmWYRQa5DT2jHScqtaT5K
         R1A9Doo9bv3o7h9LKISsKMG206+GLRwM0/95CBRkvhw+k8nsrajSnB8RA9de0ZpJvNh+
         XoIDgM55dFXqgWa3fvxajyE4qmvCFC8mBWKUieLrUZB/UQwICNTAP7Ub8/+xTVX2NDYt
         9DrQJ94w1iC0O87rgsxM4xAkcqPWXMmVy6olqHuPGzZ23Nui/7jR5LAAnf0jW8xEcFqD
         Qiiw==
X-Gm-Message-State: AOJu0YxtDvuJZTZutm8L3HcwPbO90c8vSIrQ4UETGkfUUGdJ0+MNXp6+
	QOt1PffadCfIvz2NllA/zjfp0/8xs6tg6/fRTj6NqtWGlNvu7LL51NGXo7PGSzI=
X-Gm-Gg: ASbGncuotggCfAx8P9vUMrsl7MbMNDZ6q4vTIEJAmWF6zXtur9VQaoNosLX2f36UK3j
	+6PRr+UMKutIsdNj4aP4R9hQLa2WeTNb05ppc9ZnMJUeUJfN1xsKFnXr8DuG8NDBL5X6pWlXRFp
	oaqYFY6WhDByypsjEYkbHXxCqdchqk0hPl8fplrwPEQS+RXpfVPvdK+G+iYLgTNzzcYYI7wfL0R
	IrZXOU/GC/4zElpF8svMSMXem1/mPqLB6k6pTIukepayGWKykbV57qlG0GBYC18ffW7
X-Google-Smtp-Source: AGHT+IEcA3vMSJU0aCQeYCUPqUPpn6l2NuJ+8KV+Ek4g4Zn6R8fv8uPOQpiL+8tEhw8VHJoMoz2jgA==
X-Received: by 2002:adf:c08d:0:b0:38a:87cc:fb42 with SMTP id ffacd0b85a97d-38a87ccfc9cmr9793310f8f.21.1736547989313;
        Fri, 10 Jan 2025 14:26:29 -0800 (PST)
Received: from serenity.mandelbit.com ([2001:67c:2fbc:1:ef5f:9500:40ad:49a7])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-38a8e37d0fasm5704340f8f.19.2025.01.10.14.26.28
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 10 Jan 2025 14:26:28 -0800 (PST)
From: Antonio Quartulli <antonio@openvpn.net>
Date: Fri, 10 Jan 2025 23:26:30 +0100
Subject: [PATCH net-next v17 14/25] ovpn: add support for MSG_NOSIGNAL in
 tcp_sendmsg
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250110-b4-ovpn-v17-14-47b2377e5613@openvpn.net>
References: <20250110-b4-ovpn-v17-0-47b2377e5613@openvpn.net>
In-Reply-To: <20250110-b4-ovpn-v17-0-47b2377e5613@openvpn.net>
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
 b=owEBbQGS/pANAwAIAQtw5TqgONWHAcsmYgBngZ6xGB4iodHaYPo5Ul5iupajqwKgiIA1wutrf
 UUPxPM7yd2JATMEAAEIAB0WIQSZq9xs+NQS5N5fwPwLcOU6oDjVhwUCZ4GesQAKCRALcOU6oDjV
 h5LRB/0UVvMyArvwyBRZ3cQxUSa1TqmKOceQH5WExtkF8VGuEQnY25u2kKj1Uo+N95gothw/7X6
 WTlTPJMlPXIvn4vJb7P5YA+HFSwwwGXu+k9wWCYQWu481+/F2UmS6scI8wrIFlBno0kMhI7nnhV
 rbfSzPGwBds1aEHrPNgxD6dNSnfWW/tEDIyTO2cALqXGpVf4XI96SadiA8J5Y2mTjbkXxaHfa7h
 yPgvupJZC49mQPQL5vW1V48f9gygjdnV8R/XUP7cVn7lALAK2o+objtMLvmWUrXTfABq+0XQcLv
 LXo+5188FneEoIlOlZtu1WCZRP/sYYl1wtzyGqSkVKAeShN6
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


