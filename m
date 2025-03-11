Return-Path: <netdev+bounces-173847-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id DA33FA5C025
	for <lists+netdev@lfdr.de>; Tue, 11 Mar 2025 13:07:17 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 84778189A884
	for <lists+netdev@lfdr.de>; Tue, 11 Mar 2025 12:06:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B3A3F25A62C;
	Tue, 11 Mar 2025 12:03:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=openvpn.net header.i=@openvpn.net header.b="hHXG00W4"
X-Original-To: netdev@vger.kernel.org
Received: from mail-wm1-f50.google.com (mail-wm1-f50.google.com [209.85.128.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 51CCB222572
	for <netdev@vger.kernel.org>; Tue, 11 Mar 2025 12:03:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741694605; cv=none; b=hVbGGP25W0hBIWIlH+callHpLHCIqCRnBhS+FRwDD8I37jdYHpQ2OV/v6urIHkg8gKNO3HVV9Mjm6hixIzKxSb9kCBQmWmzpCrRLe/Hyd7CIkqbye9PiCrj9V5XMixh8ACkwfCZcn4/hVGXW29XVkd2TZHsQ2i9Idll1M+UVRPk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741694605; c=relaxed/simple;
	bh=7s5Bx5ZbjMC4zD/dWY2YaXmrMwndZtJGYPhF85ahL20=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=Y+tazYbIcFZQp8cuKZSX29Qgtrx2r9j1HN/PxcOwI5AT0tXCtDqDnyIou+4TENtoQHN0YfaQFfNSK/8Z3ZgW/G6P/H1KNpb3fRo2e7QbZI5IC0n+Tz1ipIli6yCIHHLcIppWKsQeAIVUjWUf6p3MY2lCD1dmIFGEM8v/S7mQ+Zs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=openvpn.net; spf=pass smtp.mailfrom=openvpn.com; dkim=pass (2048-bit key) header.d=openvpn.net header.i=@openvpn.net header.b=hHXG00W4; arc=none smtp.client-ip=209.85.128.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=openvpn.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=openvpn.com
Received: by mail-wm1-f50.google.com with SMTP id 5b1f17b1804b1-43948f77f1aso31871695e9.0
        for <netdev@vger.kernel.org>; Tue, 11 Mar 2025 05:03:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=openvpn.net; s=google; t=1741694598; x=1742299398; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=aj7l3JFxkV3JUIYqy4m5tX6xQCQ8lcKyoxKw7Xhd+jo=;
        b=hHXG00W4oYFLhLZ+DN+61B6ZQg45eviR66cjBJSyT6ln8U8nnjk5xoXjipVJBLK6VZ
         z9JVx83V6Gkrr8p2D7bkY7ZEL2niLpU9bpHsMe+7CYtC+zWa3TJD0al9OvCdA4TcmnG3
         qQAPQxsAjAJlYKs0UF1HL9ul1Osl748MdBwPIBHb5Ea58qNsZDSZoBOVXXz34ve8sKSL
         uZo3fYS2fzlKBgHZYE0wrNqTEEEtgr7z7NqcqKwSb5nwTR98c51h5nYacm/1HFvb/nkv
         9C2i++PlxGZYgqN1p8xBgqEdJg62gnzQkIHHkwOYghWZ4zR9Z19OQze5lxrsZK9KKVY7
         cjuA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1741694598; x=1742299398;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=aj7l3JFxkV3JUIYqy4m5tX6xQCQ8lcKyoxKw7Xhd+jo=;
        b=hrgfH75LpxTrlBex9F4BM5D0EeNSNWeDQADJrJTXmMKrYgIeDZtlsrmh4MTl9M0Clj
         MWX8hR7FM1WGIDpq8SNaK6clW8hmRnRm55seAkSno2yHtt9ONbJsscV7dHlZsEbnDlj0
         mR6/JKyvBTVD5SgL0DNUHrTV5hJoN2pM2xqUSFsATFmtndYnqlkK/TLKpXHklCuiTVkE
         Lah77e5LWFB1lelkrH916iB9AMWvD1XZds5CabEGvbKt4SdIFnZrl5PKN/UvBfinHqOf
         PqyEVA4hm+d8vucdEbDcE3BBP79XkpztF8xXP9lMZdCH6Uhbai0ZjinooTONAb1JlBFo
         TaaA==
X-Gm-Message-State: AOJu0YxZ/7/3YDGJ0wHpNlgJW5y6nXr/hGcRmsFw87IIyQ2A05XildS7
	mh1nRejXLobrwz9ZwbOcV6R2EsK0lTReAbVpl6JX7kJ0f8gmp67SiHTP0aqN6/k=
X-Gm-Gg: ASbGncvJm7+pVbaTjEIVP9nzSFWDgeD5NUWVNn+NjGXoqqaeDn42NXleuIthWIPdTuE
	9Q85VnivMCDRM92UPY5UdiFMirkBqYWAct1/msNv5UQbHyEhoBQ0on5sw/DiAhGskwtrgnv38q0
	C9GHqxw4LZ/w2z2bgeI0vmjTb6xGSQwR3OQLBvu6FtSqI/fUxKn5GoG3XckDC9GZ9HFXNFAXfeK
	ebjujVx6aDlsRi8fVDxyimMx+e7uqf7MCARnWO9WAoQCefkCQC67Kj2bSF8XrGmWHF8gMo844Kl
	PuyQG5PVjR9pKyNMbQtKKOrL+T+atMPqnb9v1+oNTQ==
X-Google-Smtp-Source: AGHT+IF+d6JvFBfJOHeAIXvtZqiiuLeusCJMghibRmIueZgBdSmvrHcvNSuL/1M+sgdeOMHcKwsskQ==
X-Received: by 2002:a05:600c:3b13:b0:43d:b3:f95 with SMTP id 5b1f17b1804b1-43d00b313bemr47399265e9.28.1741694598471;
        Tue, 11 Mar 2025 05:03:18 -0700 (PDT)
Received: from [127.0.0.1] ([2001:67c:2fbc:1:52de:66e8:f2da:9714])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-43ceafc09d5sm110537605e9.31.2025.03.11.05.03.17
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 11 Mar 2025 05:03:18 -0700 (PDT)
From: Antonio Quartulli <antonio@openvpn.net>
Date: Tue, 11 Mar 2025 13:02:13 +0100
Subject: [PATCH net-next v22 12/23] skb: implement
 skb_send_sock_locked_with_flags()
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250311-b4-ovpn-v22-12-2b7b02155412@openvpn.net>
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
X-Developer-Signature: v=1; a=openpgp-sha256; l=3763; i=antonio@openvpn.net;
 h=from:subject:message-id; bh=7s5Bx5ZbjMC4zD/dWY2YaXmrMwndZtJGYPhF85ahL20=;
 b=owGbwMvMwMHIXfDUaoHF1XbG02pJDOkX1Apbk5+7SxgVsXec/t7br/C+7i9TjDFbw5ukf5xrD
 GufPMzsZDRmYWDkYJAVU2SZufpOzo8rQk/uxR/4AzOIlQlkCgMXpwBMRLeB/Z9Corxm3ye5vzFS
 HnMmTPnasnfWp9tthYuFf3huYjjxbXXC1etMHHm6M3YoMvP8iXqc+VfKqOZIGeM/9+RAybkFOle
 PNc6qbJWw3d9vL3i5mGP29C/JXd8fVbzMmJEmXF518o5nnVrAT/XOaoHyNa8v5VRkODuc8mFY1/
 bA6FLDHrdbzXOTi3Yf//1kl7ffw4l88+1vclS5BHBZxW/Yveyb2C5J3yRFxumdKydeqFh/mWeHg
 NMaCbMA++TFqjnMXUFVamnn9ORrVv4IiVzpHv4x9bF80sm3miyRhTNdQ3wkIk+ER1y71n47r73v
 VIzX6n/52xZ2i/Gb5dXe7pmq+GyVBYvQLVeWu042ddZNAA==
X-Developer-Key: i=antonio@openvpn.net; a=openpgp;
 fpr=CABDA1282017C267219885C748F0CCB68F59D14C

When sending an skb over a socket using skb_send_sock_locked(),
it is currently not possible to specify any flag to be set in
msghdr->msg_flags.

However, we may want to pass flags the user may have specified,
like MSG_NOSIGNAL.

Extend __skb_send_sock() with a new argument 'flags' and add a
new interface named skb_send_sock_locked_with_flags().

Cc: Eric Dumazet <edumazet@google.com>
Cc: Jakub Kicinski <kuba@kernel.org>
Cc: Paolo Abeni <pabeni@redhat.com>
Cc: Simon Horman <horms@kernel.org>
Signed-off-by: Antonio Quartulli <antonio@openvpn.net>
---
 include/linux/skbuff.h |  2 ++
 net/core/skbuff.c      | 18 +++++++++++++-----
 2 files changed, 15 insertions(+), 5 deletions(-)

diff --git a/include/linux/skbuff.h b/include/linux/skbuff.h
index 14517e95a46c4e6f9a04ef7c7193b82b5e145b28..afd694b856b0dee3a657f23cb92cdd33885efbb1 100644
--- a/include/linux/skbuff.h
+++ b/include/linux/skbuff.h
@@ -4162,6 +4162,8 @@ int skb_splice_bits(struct sk_buff *skb, struct sock *sk, unsigned int offset,
 		    unsigned int flags);
 int skb_send_sock_locked(struct sock *sk, struct sk_buff *skb, int offset,
 			 int len);
+int skb_send_sock_locked_with_flags(struct sock *sk, struct sk_buff *skb,
+				    int offset, int len, int flags);
 int skb_send_sock(struct sock *sk, struct sk_buff *skb, int offset, int len);
 void skb_copy_and_csum_dev(const struct sk_buff *skb, u8 *to);
 unsigned int skb_zerocopy_headlen(const struct sk_buff *from);
diff --git a/net/core/skbuff.c b/net/core/skbuff.c
index ab8acb737b93299f503e5c298b87e18edd59d555..bd627cfea8052faf3e9e745291b54ed22d2e7ed3 100644
--- a/net/core/skbuff.c
+++ b/net/core/skbuff.c
@@ -3239,7 +3239,7 @@ static int sendmsg_unlocked(struct sock *sk, struct msghdr *msg)
 
 typedef int (*sendmsg_func)(struct sock *sk, struct msghdr *msg);
 static int __skb_send_sock(struct sock *sk, struct sk_buff *skb, int offset,
-			   int len, sendmsg_func sendmsg)
+			   int len, sendmsg_func sendmsg, int flags)
 {
 	unsigned int orig_len = len;
 	struct sk_buff *head = skb;
@@ -3257,7 +3257,7 @@ static int __skb_send_sock(struct sock *sk, struct sk_buff *skb, int offset,
 		kv.iov_base = skb->data + offset;
 		kv.iov_len = slen;
 		memset(&msg, 0, sizeof(msg));
-		msg.msg_flags = MSG_DONTWAIT;
+		msg.msg_flags = MSG_DONTWAIT | flags;
 
 		iov_iter_kvec(&msg.msg_iter, ITER_SOURCE, &kv, 1, slen);
 		ret = INDIRECT_CALL_2(sendmsg, sendmsg_locked,
@@ -3294,7 +3294,8 @@ static int __skb_send_sock(struct sock *sk, struct sk_buff *skb, int offset,
 		while (slen) {
 			struct bio_vec bvec;
 			struct msghdr msg = {
-				.msg_flags = MSG_SPLICE_PAGES | MSG_DONTWAIT,
+				.msg_flags = MSG_SPLICE_PAGES | MSG_DONTWAIT |
+					     flags,
 			};
 
 			bvec_set_page(&bvec, skb_frag_page(frag), slen,
@@ -3340,14 +3341,21 @@ static int __skb_send_sock(struct sock *sk, struct sk_buff *skb, int offset,
 int skb_send_sock_locked(struct sock *sk, struct sk_buff *skb, int offset,
 			 int len)
 {
-	return __skb_send_sock(sk, skb, offset, len, sendmsg_locked);
+	return __skb_send_sock(sk, skb, offset, len, sendmsg_locked, 0);
 }
 EXPORT_SYMBOL_GPL(skb_send_sock_locked);
 
+int skb_send_sock_locked_with_flags(struct sock *sk, struct sk_buff *skb,
+				    int offset, int len, int flags)
+{
+	return __skb_send_sock(sk, skb, offset, len, sendmsg_locked, flags);
+}
+EXPORT_SYMBOL_GPL(skb_send_sock_locked_with_flags);
+
 /* Send skb data on a socket. Socket must be unlocked. */
 int skb_send_sock(struct sock *sk, struct sk_buff *skb, int offset, int len)
 {
-	return __skb_send_sock(sk, skb, offset, len, sendmsg_unlocked);
+	return __skb_send_sock(sk, skb, offset, len, sendmsg_unlocked, 0);
 }
 
 /**

-- 
2.48.1


