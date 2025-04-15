Return-Path: <netdev+bounces-182710-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id F1378A89C06
	for <lists+netdev@lfdr.de>; Tue, 15 Apr 2025 13:21:47 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id B487F1699BA
	for <lists+netdev@lfdr.de>; Tue, 15 Apr 2025 11:20:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 86FDC29A3E1;
	Tue, 15 Apr 2025 11:17:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=openvpn.net header.i=@openvpn.net header.b="Km3SQY+g"
X-Original-To: netdev@vger.kernel.org
Received: from mail-wm1-f51.google.com (mail-wm1-f51.google.com [209.85.128.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8DFF5297A5D
	for <netdev@vger.kernel.org>; Tue, 15 Apr 2025 11:17:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744715869; cv=none; b=lOO/ifY8yCxsoMmL+YJcxV5ROkBRcqmac5HmPyNZmNrDmaB52mArVqx3/hCoqJiNe/u+8NejSSpYXfM57QGUAcC6LMRY48K8eodf1jBZDrgkwhKPJGO9Qy+Zx/G38+1/APcwKd5iHt/EWLey+besm7Lvrspr8athFI7l0pl2+lg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744715869; c=relaxed/simple;
	bh=+Unom1yykFNqbE9773wCLW/thNu13gqRTUvNb4z4izU=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=Bj5RW8g5I/HV27hKvCaJAs7x9IGOpnLKKWLC9/ITd6+mdd9u6TYI0AyZNFdsnxdluQ84n+qTBF8TT8XezNpS62DWd5581t8nnDoLZIqge68Aav/VQmA6TI7pgfOpBF1bdFPgXAsSIaIUsJkoyUS9W1qT2E8Fe7yGCOfiCfj/0/0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=openvpn.net; spf=pass smtp.mailfrom=openvpn.com; dkim=pass (2048-bit key) header.d=openvpn.net header.i=@openvpn.net header.b=Km3SQY+g; arc=none smtp.client-ip=209.85.128.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=openvpn.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=openvpn.com
Received: by mail-wm1-f51.google.com with SMTP id 5b1f17b1804b1-43edecbfb94so57076825e9.1
        for <netdev@vger.kernel.org>; Tue, 15 Apr 2025 04:17:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=openvpn.net; s=google; t=1744715864; x=1745320664; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=LTV89+C/IAgzFB5m5xPEkC+pORUgcF9jMRUpcGRiTts=;
        b=Km3SQY+g68dlL5WDJfC9Wox3eGYLBFS2chRqnlwomuKB2kuzSEES130Oy+FHQQ5bu+
         myJtOB+U//Tcy0CjVyTfP5kBUA52GLq7PwPu+DfrHXPeNheDDXb93LSwXUAnR8uL2DPr
         Dmd0KmtfdB3xhE9AEwDThk2DQeD230CzX0uy+HICxT3OnDcLiV6ylXK2XZabjUNm+sjA
         Drk+ReGt3IE8q3cQ+sCc2wRdoCj2rEtWpoyQAUL3XkBmNNb01RfxD78YEZi7h0aV7yDm
         zer7EsnuVPYnAy6P+nSmtcWLfbT/7UISDrIpFatKYKMPprMnmrqKfsMVXqVVK13Q0pdu
         fX5g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1744715864; x=1745320664;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=LTV89+C/IAgzFB5m5xPEkC+pORUgcF9jMRUpcGRiTts=;
        b=n6akavuh5+smzmfyF9yU23kmCJqm74ODteNsVphaieiIO/NTYc6TP9WmoiBsznGMKw
         g7QvU1xR8XbNur7DLrIo6FqSFG3q7F0HtFm9tEz2LxilykRmEtn0j0yGmFhO5Igb2PBX
         CPZou4N7t0EDFom4i18uEVofTaU8odfCvXMNuH/uxiB5eaX6+m+GJH/3/FcENj0Q/Bub
         +m74ukoPg4OZD8cJMOC0AHkivg6HLDhCRj8RXLzEryKy7eeYN5BpRtmOhdr6fp5QI+8U
         CFUYijB8rQ5jpK+6G5U14WjCQRn6InA0koH4P+WdF8ziXzqgYkM3367127fr9RJnYSUF
         mm8A==
X-Gm-Message-State: AOJu0Yy64xZCb4ojcxZ8W+ZFqL1Pwixb5oaJ3mV5/EgGlI7m9sYJuWWM
	/YuTeHcX51xZ+suIZLLDxJdwk124i+0vSNkHAyea3JNxUgh38qOzXToqErM0mTD3hSVeOJIGrhn
	wCjBq3bMAfc1J0c6IiYATtXG/7tXdWJL8ipHt96bFD9i0H7k=
X-Gm-Gg: ASbGnctd9YsT50/yXsSwvcAfLYGJdlesqE6jnnXOwNUIPfAGUehiVvz9f6gagizfWkS
	mNwgs6n1nw8dKktaKDWQVKnv8DihSSsOCPaRUM9flS5xwAX8vIUKpspJEaTTQYCWt4A7qN30Hek
	sJNkuDwcwu3VHuEDG35ce7TAzugJ2l0CtQ4TNKjLfL0qncKbbMfL6qPEDMdSITQdS/bE4wAd8Ah
	2qwxP4U4X9mZ9UoQjwZzczHI1NvbEXONQsD1eQ10jM1UCzqGFV/aAkjwqU311GKmuK6p3J0XDBR
	OjqyxinnwIMiXrJpmz485ihRzG3TeiqIE8S0xQ==
X-Google-Smtp-Source: AGHT+IFMQlof59fOSg2M7Eq+m/RtbhU+97yysT9+PCWJfN8QfdC4S+dr1wKcgeULLpXXtIHsL2RW3A==
X-Received: by 2002:a05:600c:4fc1:b0:43d:47b7:b32d with SMTP id 5b1f17b1804b1-43f3a9afc1emr114850195e9.25.1744715864556;
        Tue, 15 Apr 2025 04:17:44 -0700 (PDT)
Received: from [127.0.0.1] ([2001:67c:2fbc:1:83ac:73b4:720f:dc99])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-43f2066d26bsm210836255e9.22.2025.04.15.04.17.43
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 15 Apr 2025 04:17:44 -0700 (PDT)
From: Antonio Quartulli <antonio@openvpn.net>
Date: Tue, 15 Apr 2025 13:17:30 +0200
Subject: [PATCH net-next v26 13/23] ovpn: add support for MSG_NOSIGNAL in
 tcp_sendmsg
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250415-b4-ovpn-v26-13-577f6097b964@openvpn.net>
References: <20250415-b4-ovpn-v26-0-577f6097b964@openvpn.net>
In-Reply-To: <20250415-b4-ovpn-v26-0-577f6097b964@openvpn.net>
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
 h=from:subject:message-id; bh=+Unom1yykFNqbE9773wCLW/thNu13gqRTUvNb4z4izU=;
 b=owEBbQGS/pANAwAIAQtw5TqgONWHAcsmYgBn/kBC5GCVEXr1yIn8QuqochbJhgC073YBScniF
 aNqKp9N6/qJATMEAAEIAB0WIQSZq9xs+NQS5N5fwPwLcOU6oDjVhwUCZ/5AQgAKCRALcOU6oDjV
 h0skCACVDtxscS+U1pTczUQRXmdOPUnVYdiNZu9j/IbBs6wPQNrsNWG68KmhumIbaHSuJ3KhE2j
 o0r8LcyNbe/eAQcsnJcmiWxD6lXq0Nj3Ksh8fvo3jtAlN78gdkCCJkacixK0AbAAZL8j7/FySOk
 snWdSK2+2gc746sqw1LA+7x+BWFTaxf3GV31em7bTGo+WIFQ4Dy2YDolNlN9kLghzUXj84iXJOY
 K30JWMryR49joNOZLiOQQ5GjqfkF1MxiqTAdtixCs5qi9LL8njRQx54g0tJCT/UzezZccB5WxcU
 zUaehnb687l5liknaruBdGyY3ooLvo4a5e9VmfDKkm+wkrgx
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
index 588ff6b0440103f6620837a75ea2f1029d91b8a3..7c42d84987ad362289dbf5e7992403c76e910ed9 100644
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


