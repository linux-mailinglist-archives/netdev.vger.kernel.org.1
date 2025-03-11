Return-Path: <netdev+bounces-173850-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 2197DA5C023
	for <lists+netdev@lfdr.de>; Tue, 11 Mar 2025 13:07:13 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id BCA987AAB23
	for <lists+netdev@lfdr.de>; Tue, 11 Mar 2025 12:05:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4C01025BAA0;
	Tue, 11 Mar 2025 12:03:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=openvpn.net header.i=@openvpn.net header.b="e7kLhcAo"
X-Original-To: netdev@vger.kernel.org
Received: from mail-wm1-f51.google.com (mail-wm1-f51.google.com [209.85.128.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A791F25A323
	for <netdev@vger.kernel.org>; Tue, 11 Mar 2025 12:03:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741694607; cv=none; b=UJsrSWYAHpVC7Gc+ZKeU3/WcqEB3kM8aHxiN1WQffZkDTK8sQUEYLlqLysglagwWhygOnBmtIYTPvfC2Hh9Iq7Grx60e6AZy7rCz/ybTpgPXIVclCHtYBx+vEqWL5fbUOQr+/CaOXXyaTxEnAyFnK2dNIl7kSWhzfNuI2SDMe8c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741694607; c=relaxed/simple;
	bh=ri2c4Ytlpnb6MthNw5Uj/vFPwNDGP/hWkEwxnYNr2f4=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=sKdRcbXXt/+PKk7qJamyobPuKGNQUDyROjqMjTmi9boG7gn+usG5mLQrxubDtBtmAo191oYBV1MSmMZkhKP+wE/aV6urUmhQijC0694x3GNZQk7WrNh3eGv5wfe2xNgy3JRuZTGcXyAGJjjal6Od+LjG0cPMQPpRYbLY5NLKu5E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=openvpn.net; spf=pass smtp.mailfrom=openvpn.com; dkim=pass (2048-bit key) header.d=openvpn.net header.i=@openvpn.net header.b=e7kLhcAo; arc=none smtp.client-ip=209.85.128.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=openvpn.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=openvpn.com
Received: by mail-wm1-f51.google.com with SMTP id 5b1f17b1804b1-43d0359b1fcso4037215e9.0
        for <netdev@vger.kernel.org>; Tue, 11 Mar 2025 05:03:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=openvpn.net; s=google; t=1741694600; x=1742299400; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=knj5Ou9okDSc0sSB2beqc0E37iP0V7u+FLPcU5pOcYQ=;
        b=e7kLhcAoemdU5CQ1+MqTl5XYqmdHzYw3UofZ8lb0Fp+7KNLHkoazArvKnWYjP8chQF
         3ZBhe089Po+M1opDLaH5OGkyRqM0CQK2wrhw5K3ckb1Q9Oc139ZZQYkv3q3Igwr5VQnU
         Zt7t77QNib+DB224i2Zf2UkVOUnUeMoSyHfZOkHGgc0g8u/IiTPd15o5w17uThtZefzC
         uJrARnJgBTbMN2qPdae1cyegQAlU3ORZvo5aSnFH7j+YVLIJl64kMxBEMy6yD53w6fKr
         WvogJXlA+MKwbal6aIv6bCs+WD7E4B9EoWmrgx6IepUGidCosSi+8dvZYRaRiBsHlypH
         PBbg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1741694600; x=1742299400;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=knj5Ou9okDSc0sSB2beqc0E37iP0V7u+FLPcU5pOcYQ=;
        b=iQm0rhxeAOWkJyIpyxFh1GMoch0O1zJR2NMGoc0zKBgAK3hoWluSLVgRZuG3cnRNv1
         DPzNM0wfuxPGBPsrhUngzLLMIHnRfnBHGNKj9l8Bch+GR3YiHH+ZSk61a7xiYjONwasi
         ndSasLMeMnbWoaAk3CskyiW0ro8Uue87baHcUesG4dM3liBHDR9FmrWlSPK3UCYZQlyr
         U6akdWHwj2rO5Ir8AEUXUDxGxpnjerVcDQoYOalNFiJVutxdiQWFdb6RmJytfZvjRGsb
         L0IJJBmdfaUXu2VmKzo07pjabmWDOqRm4vTVoePF/2i1uzR/HkrDF6doOZOcToEqNCC9
         MPxQ==
X-Gm-Message-State: AOJu0YxvH+9S4Ak3c+L2tCX8uKF8OMGDUeZU975h6VQb6ZS41DLBJmxW
	2kzJt2IFLsIeu5KVqaszKe7DeJ9R6/aluRLDoYQn8v3K74rLcxdG3BoNCsANzY0=
X-Gm-Gg: ASbGncs9b1FY0/IRvdtTUYK6akxmiLK5KZczDDTzTdbRLm3qEUSQYB4yzLavDzv6LMs
	uh3hKszoQFuq82oRZy2HMqTDJ7DkuBvysIHAbRvF4rKa+auiOdyw9ywzNpJBbZG2Ku7rn/cJrjG
	Vl5Vvg9vsOkrktQguO0OajyBTiH3bCGVy4pSd4kDhvk84Fjda7hkmZJWZ9eKtzreuG1FMKUaIGr
	XDrR8HBKyG7n0QTHOimCU2zmiuGkKpLHJlj1q636lGCBtcHnDi66ixEqaVaawjWckkq+vjtKKCe
	HtcKdvOHoE2sy50j9EH9Fit3MO355NipYLroPTnSKw==
X-Google-Smtp-Source: AGHT+IFE78qSsS5yU5/l+uAzJm2HZ5z+m+zV9CngekvXXRG3SR7vhfOo11ZsJyhSi8jrg6/4UN5k1Q==
X-Received: by 2002:a05:600c:b52:b0:43c:ed33:a500 with SMTP id 5b1f17b1804b1-43d01d5f83amr38503055e9.10.1741694599622;
        Tue, 11 Mar 2025 05:03:19 -0700 (PDT)
Received: from [127.0.0.1] ([2001:67c:2fbc:1:52de:66e8:f2da:9714])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-43ceafc09d5sm110537605e9.31.2025.03.11.05.03.18
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 11 Mar 2025 05:03:19 -0700 (PDT)
From: Antonio Quartulli <antonio@openvpn.net>
Date: Tue, 11 Mar 2025 13:02:14 +0100
Subject: [PATCH net-next v22 13/23] ovpn: add support for MSG_NOSIGNAL in
 tcp_sendmsg
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250311-b4-ovpn-v22-13-2b7b02155412@openvpn.net>
References: <20250311-b4-ovpn-v22-0-2b7b02155412@openvpn.net>
In-Reply-To: <20250311-b4-ovpn-v22-0-2b7b02155412@openvpn.net>
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
 h=from:subject:message-id; bh=ri2c4Ytlpnb6MthNw5Uj/vFPwNDGP/hWkEwxnYNr2f4=;
 b=owEBbQGS/pANAwAIAQtw5TqgONWHAcsmYgBn0CZx7b1lJBZaipGBDRDV/D9519rBlmLohDdpP
 gwu9A8wtBuJATMEAAEIAB0WIQSZq9xs+NQS5N5fwPwLcOU6oDjVhwUCZ9AmcQAKCRALcOU6oDjV
 hzHrB/9+xXaf4K5ly3V2Lhg4WdJg6c6ILQ599VLT1cbQqI0Jvc3Slu+OGyItDI4m/LKkiJElsg9
 jPAuH2hshBm4MnggABqtF/zaubRWqrWuHI0Vy4+iKc3P3h9es31lhIfYc2yW+dBRo2+Ht+0LzYe
 CiWpgueT0BOJu7sAbRsKIdqdwoTDL1+atejhVM64dqsyjGFFZB8ooErtC2rqwvEI/WEEmzauNFW
 tXFHreDWmeTL3SyacRmva2PGSOpKPybKzhfQYbCyFH+0XTHnFF+SBTmIjZGzJ4m/hKZw+/xcsj+
 LSF/J3LtiyiIs+nSrLREJJKasz1Q+1W4rxIGWbkYbIH2Zd1N
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
index a5bfd06bc9499b6886b42e039095bb8ce93994fb..e05c9ba0e0f5f74bd99fc0ed918fb93cd1f3d494 100644
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
2.48.1


