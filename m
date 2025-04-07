Return-Path: <netdev+bounces-179908-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 1C3E5A7EDF6
	for <lists+netdev@lfdr.de>; Mon,  7 Apr 2025 21:55:12 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 2DA2916911F
	for <lists+netdev@lfdr.de>; Mon,  7 Apr 2025 19:50:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4D877254B1F;
	Mon,  7 Apr 2025 19:47:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=openvpn.net header.i=@openvpn.net header.b="hEAFHnsc"
X-Original-To: netdev@vger.kernel.org
Received: from mail-wm1-f47.google.com (mail-wm1-f47.google.com [209.85.128.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EA86D254860
	for <netdev@vger.kernel.org>; Mon,  7 Apr 2025 19:47:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744055252; cv=none; b=J/2HUIyCdezlWWeaUCQm8iRW3BOuspnjFpFBdX+5AEGsPVLBTys7/04uCACeZwRpl/jjJmOYWIXi88XGZIgD2pfv0LUfk6LHYDs9fOAfNLKwG4RD7raz7VMJCH2/DzgIQCn2IgEMsL+S5sEu6pZRibe7MrT1JGSRbq0pBv8BKgY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744055252; c=relaxed/simple;
	bh=GlvSCAg7UZz5CLYVaV/K4bG/kvWgmBwM9Tx9HBMpwWw=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=uj2mbag8UfOfq/lXqkr5Ll+rFYZKTj3yO1Lq5Zsd+AzPEkw7fpEVHzSfsP1nhKn7UAjLKQW1fljvJUOvFYyefq8+s88HO8XV1lQKQ+VstK4YNY+lxdHKxrY5XNWmxJbEnutVKkuwbRKg+gD9Qt2av8Zi3eNzxI6skk6EtaRag4U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=openvpn.net; spf=pass smtp.mailfrom=openvpn.com; dkim=pass (2048-bit key) header.d=openvpn.net header.i=@openvpn.net header.b=hEAFHnsc; arc=none smtp.client-ip=209.85.128.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=openvpn.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=openvpn.com
Received: by mail-wm1-f47.google.com with SMTP id 5b1f17b1804b1-43cf848528aso39017335e9.2
        for <netdev@vger.kernel.org>; Mon, 07 Apr 2025 12:47:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=openvpn.net; s=google; t=1744055247; x=1744660047; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=hrYH2xrGzaSU8S2zLyagpxpW/r4O7GkaJCHPTe5rovc=;
        b=hEAFHnscDzIzKvXZuol7oLG2dJyYU6B+eT6v1ofM7VVY0D2AUYoaqfv2UcmCrx8x+O
         5D9xBOHGKGvAQDiYRwZ3j3dWekFVxFTKx3YBf7V29E3CiVyeAbJ6zUh/RKyK8eaKdL+E
         NR1dRoWqPz/FiJK1MdMlhPWqIt9R9FRXxRu0GaqVSBGLm6Xco4cFr/HOriHiuFennIdK
         AsTiba6cyy32RtE+6hGfHGtZxNEOf0wftXp/eOvipSkNCzQbssbBZaBhp/1E++krF9M4
         RJkt/hX7J338vOxGWoj7bCGyiNDb27EBta6FXl/VR9M4sBnYo2U6SP/znQBrESrkxkWm
         AKfw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1744055247; x=1744660047;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=hrYH2xrGzaSU8S2zLyagpxpW/r4O7GkaJCHPTe5rovc=;
        b=nT3OlF322IGrvKBsLDwD/l4TyH9BKilT8h2unn7KAPaqcwKqVeTQcELWVAzjTNkA92
         AYd23QLpODCIj72zCyPZIxB6+MBItmveO1gZbLsoP609eJJZ1kbEcfvHxvtUcKRVG90/
         MDVKqGQ20CPeK08W0YzvHcCcn7AqJxFTQbwxECWo1v9AlRXyi8g0v7QwJDjBfZp9NXe4
         QIXNFpYtlJUzU5zGwtbonMKQh41S8ITC1Qya89ay119Odwtc6iaJ+qdaxazHNKISHUmD
         mtaXi5jDd83Lctb7vTRkfOe+rEAI09y05x1bbkBVHnSAjz9Z5AfBPMPIk//K8PrWBnn3
         05mg==
X-Gm-Message-State: AOJu0YwAodkf+Zqvp4yXFguoOkuQXMzj+hSTjSarUWInfEOIdSEswjmz
	TjohebFxncz6DcpgRhC8AQMILe7GGhAxBACRsW/x7Vk7Ote3hPEj1C1bYNTw0Y4PJEdSnGoaS/U
	/fEo3tXv1Fg/V9QO7+i1N9t64Ra2oiFk4QI21mhw5f3o3kzc=
X-Gm-Gg: ASbGncunMcHls+ZjaGZdgDEwKB6qyrlVmoFQzW99VeAgkXArG5qEvMbOsU0kTxDA9bY
	pWFlLCK86w9fsewgKT03TqTryEgSDJXVTcg6rVRGWIeS4H218E7xVq1Ow03UurmX3FkrscrcUat
	5esMNfEoKQz/785vu5AyYsio71VRkBnAa3JzvusP8y98P0wQU55KuLum2Co+6JM02KG2NMxuJfB
	K/aVAVqspoSyphUKXetuTPLEIchMGDLwcBL7NaA44xv+2BFjC4/mt25HcbMeLi41P2WZnYppcbK
	m2SsrLcJNn4EtSyFHj0wbXZphjhneqOekI08vtAQAA==
X-Google-Smtp-Source: AGHT+IFwTRSSMqwURfcuR2x1AC4KD8e1qbSjeKRTEifQNarz2z5giACEeNPbrgkqITItgMZkt4i+YQ==
X-Received: by 2002:a05:600c:1c88:b0:43d:7a:471f with SMTP id 5b1f17b1804b1-43ee0694b80mr88736565e9.18.1744055247268;
        Mon, 07 Apr 2025 12:47:27 -0700 (PDT)
Received: from [127.0.0.1] ([2001:67c:2fbc:1:fb98:cd95:3ed6:f7c6])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-43ec342a3dfsm141433545e9.4.2025.04.07.12.47.25
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 07 Apr 2025 12:47:26 -0700 (PDT)
From: Antonio Quartulli <antonio@openvpn.net>
Date: Mon, 07 Apr 2025 21:46:21 +0200
Subject: [PATCH net-next v25 13/23] ovpn: add support for MSG_NOSIGNAL in
 tcp_sendmsg
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250407-b4-ovpn-v25-13-a04eae86e016@openvpn.net>
References: <20250407-b4-ovpn-v25-0-a04eae86e016@openvpn.net>
In-Reply-To: <20250407-b4-ovpn-v25-0-a04eae86e016@openvpn.net>
To: netdev@vger.kernel.org, Eric Dumazet <edumazet@google.com>, 
 Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, 
 Donald Hunter <donald.hunter@gmail.com>, 
 Antonio Quartulli <antonio@openvpn.net>, Shuah Khan <shuah@kernel.org>, 
 sd@queasysnail.net, ryazanov.s.a@gmail.com, 
 Andrew Lunn <andrew+netdev@lunn.ch>
Cc: Simon Horman <horms@kernel.org>, linux-kernel@vger.kernel.org, 
 linux-kselftest@vger.kernel.org, Xiao Liang <shaw.leon@gmail.com>
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=openpgp-sha256; l=2479; i=antonio@openvpn.net;
 h=from:subject:message-id; bh=GlvSCAg7UZz5CLYVaV/K4bG/kvWgmBwM9Tx9HBMpwWw=;
 b=owEBbQGS/pANAwAIAQtw5TqgONWHAcsmYgBn9Cu14qyqyGw7y5ZyFPZKkEU04TRKHYhcP30/U
 tTaEwjNW/qJATMEAAEIAB0WIQSZq9xs+NQS5N5fwPwLcOU6oDjVhwUCZ/QrtQAKCRALcOU6oDjV
 hy9gCACYwdKmPU3ICRaoAM3abyWxpho+3x01dUiCIVT7kosMwa/Ed0/+OZgoSuI47PbOsF0jbGK
 ZI85Hyxcjww5PKcKv4tLaYDxZEkDVCF1jOOH4P87sPVRNQ1KTFv+HsvOahjbe+W2HlA4U4tCgB3
 5Ul1vxyjYSin00oZ/P7LED5V1juCZW4IAhaswKanLsd7Mlo2rX9XdTk64QOJhhPxFLBsf16FOHN
 pC4wSV3QOsdESGRdxNJG0+qRZo6h9pVZajPh0vabJs/c9QNuwBLwZjncgNQEqc9DzH0N0e0dXVm
 vfnP3x3ThjnZy8PokM1R8/ubn2XT7WR1GgJSbhJlTt75w54D
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
index bd3cbcfc770d2c28d234fcdd081b4d02e6496ea0..64430880f1dae33a41f698d713cf151be5b38577 100644
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
index e643cd8a66350eb92c6785317440fcda6c5ab6eb..dde9707d74442a9a6a9e38631196d2c4a09a74f9 100644
--- a/drivers/net/ovpn/tcp.c
+++ b/drivers/net/ovpn/tcp.c
@@ -220,6 +220,7 @@ void ovpn_tcp_socket_wait_finish(struct ovpn_socket *sock)
 static void ovpn_tcp_send_sock(struct ovpn_peer *peer, struct sock *sk)
 {
 	struct sk_buff *skb = peer->tcp.out_msg.skb;
+	int ret, flags;
 
 	if (!skb)
 		return;
@@ -230,9 +231,11 @@ static void ovpn_tcp_send_sock(struct ovpn_peer *peer, struct sock *sk)
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
@@ -380,7 +383,7 @@ static int ovpn_tcp_sendmsg(struct sock *sk, struct msghdr *msg, size_t size)
 	rcu_read_unlock();
 	peer = sock->peer;
 
-	if (msg->msg_flags & ~MSG_DONTWAIT) {
+	if (msg->msg_flags & ~(MSG_DONTWAIT | MSG_NOSIGNAL)) {
 		ret = -EOPNOTSUPP;
 		goto peer_free;
 	}
@@ -413,6 +416,7 @@ static int ovpn_tcp_sendmsg(struct sock *sk, struct msghdr *msg, size_t size)
 		goto peer_free;
 	}
 
+	ovpn_skb_cb(skb)->nosignal = msg->msg_flags & MSG_NOSIGNAL;
 	ovpn_tcp_send_sock_skb(peer, sk, skb);
 	ret = size;
 peer_free:

-- 
2.49.0


