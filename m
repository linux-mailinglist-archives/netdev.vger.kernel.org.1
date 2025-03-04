Return-Path: <netdev+bounces-171447-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 76285A4D01E
	for <lists+netdev@lfdr.de>; Tue,  4 Mar 2025 01:38:30 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 21401175CA8
	for <lists+netdev@lfdr.de>; Tue,  4 Mar 2025 00:37:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 43E6C1F4170;
	Tue,  4 Mar 2025 00:34:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=openvpn.net header.i=@openvpn.net header.b="QYiBv0OP"
X-Original-To: netdev@vger.kernel.org
Received: from mail-wr1-f41.google.com (mail-wr1-f41.google.com [209.85.221.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A56511EDA1F
	for <netdev@vger.kernel.org>; Tue,  4 Mar 2025 00:34:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741048489; cv=none; b=CVXkLInMe2Q73vik0WyeMhuBp1S89G3gJqSpWBjmiecaKDWfiKxFESZdVWuFkWs8L0ZC5ULTAwA625po0VGq/MDIzzRfFZAtLGmCcC3IiGz285EaUJ/tlKkBGAH0JPve8laT1s/2sgauBIkQcvIpjotpfLMJ4RsNoO2vclWVaeI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741048489; c=relaxed/simple;
	bh=PbesptcARg4Ut8HDInQJPzampu5E1akZeWd43i/N/Rw=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=eepBzTaXNAVS+WB9A//VaUBKv8mCwL7sUDImISBx0c864INMarP5DnA31n3LhfuEULAzDlxarNif82w5I83IR9wWC7CBTNxk8/nUjWqUDHenZUX+7skmA3bAEmUyn+R/0REF56LeGna1FphS1YMs4EhRPKZU0KWcvMHJ7XKlf/M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=openvpn.net; spf=pass smtp.mailfrom=openvpn.com; dkim=pass (2048-bit key) header.d=openvpn.net header.i=@openvpn.net header.b=QYiBv0OP; arc=none smtp.client-ip=209.85.221.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=openvpn.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=openvpn.com
Received: by mail-wr1-f41.google.com with SMTP id ffacd0b85a97d-390df0138beso2643339f8f.0
        for <netdev@vger.kernel.org>; Mon, 03 Mar 2025 16:34:46 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=openvpn.net; s=google; t=1741048485; x=1741653285; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=EQwqdxOgwt/7vrDDaSdpoZa809dnvtmEHZJ/1Qd3Cks=;
        b=QYiBv0OPkfYVUPMtYiEWTJ8b2jgG4XtphMg1EESs0chsunYkJpU+khg4JaWhS7lnvJ
         LAhOR6PNcIUO98OvSrw3rM4XiZnDFn0PFbqQk11sQY1HIU4lQjwhOMXaqn8PEtY4AcyG
         1ojBAKYFwcFhNAfVT+zmIHpxwGKtIFwRM9oFF2EzTryFoy6xK8a2PRe3Ae/DVHiuYtxD
         ULPuroDJIBFsmtkPe7Cc6U1Ihm1R5kg2bQO2VvbwMlbgbfE2vLoFB90j06/qzI+DAKGD
         cYnE6FxDxRNYxTE4ApkI+fU79J7+WjR2vgR51OzQTTEZLEHsVrY9gQl9D+KO07WAXUe4
         i78g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1741048485; x=1741653285;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=EQwqdxOgwt/7vrDDaSdpoZa809dnvtmEHZJ/1Qd3Cks=;
        b=XZRHuJHilhg1DRAdjEaKRKW+l6VdlImOD4eQYZvJ6MHFjJgNtMB4DfbiDurA/fs2Uj
         ynADvmaDLknA4w3sP6D714TT3co6tWc3YFRM+/XowX7hE3xJWhAL1u1EKlNVHNWWxytO
         ivbUvbUNCqVGWn7DEpVoDxV08KqxjhgBCChjuwHugN7li3Ea0405oRMEIgIkol0SESFx
         eue0OrpYC84TowUWZVouQIDXa0BYsdaCQJp++lZ8SchU4Psn79K6rhgNcC4S7Spiz4hr
         tGCJnyLXOOkoPxSmANc72UOCTtglq8SAsf9oVFk+9ckDVNMRYVZsn6TFoETvhuhf891b
         uFqg==
X-Gm-Message-State: AOJu0YxumgtVrFcwDubJZ/hYbPT6hk1nxPNGfYBlf59l/SsdRU11Rkl2
	RAG3IewMWp+lf3SbyLIbEAh/BZxbWXg24EXu2SWgWxT5kRxV8QCdMuE+VCb85NM=
X-Gm-Gg: ASbGnct+3kle8n3soGD7bdj0lRsb4Erbpk3fYNoyQ/4hIXro2wRjx1iSL7Nse8+VFy1
	mJmumoeE+xghISQrQPSHnxC/THVeoFhrTkvH/1hoibX0Hx0XlffEhB6dqLCtykI+7CDVcgB4Q+U
	LA1Y0MIC5LnrHSSGN4SigexuRDziW16yU/UDikaxVPiMEewka58M/rcucmQeUAImcafJh5ptOmk
	Cw3YapcVus6LdzZ/fTOKDMbLbZ2elzZkJEvOLSHBUijJ05fvwFLjWFYjHNt6cs4TyT87ZUuNtiH
	8CdvrsTYOPQpVwQ2hLeabRP7g7OtfvmtRQIhJhf1IA==
X-Google-Smtp-Source: AGHT+IGpspvam1C8RvPX3/BPMzjM9rqVq3JyBrFhcL/I3qL/bRtoK51mArGaJhCepTOZHumA+U7xlg==
X-Received: by 2002:a05:6000:270f:b0:390:ea34:7d83 with SMTP id ffacd0b85a97d-390ec9c166cmr11093758f8f.31.1741048484905;
        Mon, 03 Mar 2025 16:34:44 -0800 (PST)
Received: from [127.0.0.1] ([2001:67c:2fbc:1:49fa:e07e:e2df:d3ba])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-390e47a6d0asm15709265f8f.27.2025.03.03.16.34.43
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 03 Mar 2025 16:34:44 -0800 (PST)
From: Antonio Quartulli <antonio@openvpn.net>
Date: Tue, 04 Mar 2025 01:33:43 +0100
Subject: [PATCH v21 13/24] ovpn: add support for MSG_NOSIGNAL in
 tcp_sendmsg
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250304-b4-ovpn-tmp-v21-13-d3cbb74bb581@openvpn.net>
References: <20250304-b4-ovpn-tmp-v21-0-d3cbb74bb581@openvpn.net>
In-Reply-To: <20250304-b4-ovpn-tmp-v21-0-d3cbb74bb581@openvpn.net>
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
 h=from:subject:message-id; bh=PbesptcARg4Ut8HDInQJPzampu5E1akZeWd43i/N/Rw=;
 b=owEBbQGS/pANAwAIAQtw5TqgONWHAcsmYgBnxkqP/jzo2uEazn/QB72AvP9fuVB0jc8fJ/Vmy
 uhh++zc9EKJATMEAAEIAB0WIQSZq9xs+NQS5N5fwPwLcOU6oDjVhwUCZ8ZKjwAKCRALcOU6oDjV
 hw0zB/9PDa5RIGWd1z5zEqhVr4s3Bqd82G1uYxc8ZtfRDxTPTF8EXEiKUAnBGq0dWn8C0iv9OTd
 dBls84bUJndZavWNdqyo23ztKlyVYSnkGaFupwNnOTrQg9hHdGLry3LwjnTIVHVSfDpKjHB60xM
 qHOJuZy3w+7oUwTyk1nOHVWIeVvKAz+ArjibifgtY9LN/v5CmypQvTv6zWFCReBJe3/1livlFtS
 3cCBIOeqpsj8ADZa7r4hk6epaydKP/Jg5NxHpB33si2ivpQXrbmY5nftNA27bOtqmmBkBQ0eWfh
 1WTfgqknhjXgESuskrVN3w1OGCJO+/DcAG4XIkk0uM58bE7o
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
2.45.3


