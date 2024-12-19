Return-Path: <netdev+bounces-153178-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 91EF09F7207
	for <lists+netdev@lfdr.de>; Thu, 19 Dec 2024 02:48:11 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 6E06816B098
	for <lists+netdev@lfdr.de>; Thu, 19 Dec 2024 01:48:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C25A41A7044;
	Thu, 19 Dec 2024 01:42:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=openvpn.net header.i=@openvpn.net header.b="Bhf4cpGD"
X-Original-To: netdev@vger.kernel.org
Received: from mail-wm1-f49.google.com (mail-wm1-f49.google.com [209.85.128.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3DCBB1A254E
	for <netdev@vger.kernel.org>; Thu, 19 Dec 2024 01:42:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734572547; cv=none; b=nmM0dgVN3BgihZROrHj68YuO/knTWIqeUqjdPvjZLs+eLg+2CEnNCgsf9jKmI9/aiSB3vPexBjLn+Yl88afOtIw9cNE3ZvPZB4AfT1WuCP5fR3/jLBUzaJ8uGzuxfUQ62OFdcKHTJoFvG9wW9eqFqMFbt8w5mWLE2Wk2QbDEZWo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734572547; c=relaxed/simple;
	bh=+I0CIsXtEiIwM67fyET5J2S6dQohwJOCqzXgQfocGBc=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=cFjeGPS5K617kZWR0do17J3b7bVabEyB+48fRY9HpMMS5a6deKbfjBRa+CzEZHPAJv+KHJEY/lC7IZgZlrSyis0dvVbCkHC9x/C/2D/sw999Jr6tqu6nLzuiiEBX2IeAIEFiDtNZ6CNdtI8eN2slgIkB9Rov8uTL+v+Hg37zBIA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=openvpn.net; spf=pass smtp.mailfrom=openvpn.com; dkim=pass (2048-bit key) header.d=openvpn.net header.i=@openvpn.net header.b=Bhf4cpGD; arc=none smtp.client-ip=209.85.128.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=openvpn.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=openvpn.com
Received: by mail-wm1-f49.google.com with SMTP id 5b1f17b1804b1-4363dc916ceso8789075e9.0
        for <netdev@vger.kernel.org>; Wed, 18 Dec 2024 17:42:25 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=openvpn.net; s=google; t=1734572544; x=1735177344; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=6eaSomrt0ENXr78HcIYaZg80aU6nwBAZS74Oa3PamkQ=;
        b=Bhf4cpGDEcIw4EUMMrXBc4sigDgadfa+ypnVYxLDvge+uMNSuP3TxhqvCk0PycWQRe
         gnRMep5Tbt9HPPuT77i4fNhEnfnwGDQttKZ7vYz35efphzzuMKhPAI0OCKVaL5yXMGn7
         3CJS3rnD1vtRHhu7nBwEZBcbCEhb3XXLZe0/G/EwpTqJHsj8miFQ9OQvZuk+zWUu4aNw
         fF0kJGpzzILQfK22k7JummC4I+qYs/q17H1CiRZGmQjneZHcNsBh+oOUM3q6mjcSHf1R
         Kb2xJJKIsTiL14APIxW8mn/YE55WB5hVYGjXcZcMa/Ne5SsqEFBm8FEFLtC/t/k6jLlj
         YOlg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1734572544; x=1735177344;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=6eaSomrt0ENXr78HcIYaZg80aU6nwBAZS74Oa3PamkQ=;
        b=cKnfxDk31jBUAtW5FPqKvdsKChxGb2c5xKoBR+JvwBrO5G7yrC1X1MihRh7mrgEOkJ
         5C0U7/Pn41W0o14EOIe4nv+3ku7mqgBOOS93Cv2LQUVS71F/GjnhB1eE+JDGl00eToDY
         WJxKU0L7qU8rVO2n/NF29NQWddfn2sL52NHwT+qtzE14eVezPk3qnVqEa8NdcFlWWMnY
         1Hp0qqEMvv7etQX9cGTphhWeLlTDgYyIbtX8JnDdz9zR6ThrJ+3WlT4RBv6oZvdQny7W
         XqpShjVaOJ+rwRYqlFvz7YrlUTFTH4Up2WJitY98glqKKxshJTBCoJavBPlSvEH1xvzT
         f2eQ==
X-Gm-Message-State: AOJu0Yz4z1XGuUFTdotKbpAzBfbuEJekzmZy+OfZcNrGi8VyRkwTC74C
	AkcyYan3pPxzDpuYytw3PxEMpAPWEVMMtxRlozGaNFGhiV5SHA1xvg6nUYciTkI=
X-Gm-Gg: ASbGncsJpa2ohjLDNbyqOEprBxFET0Q0D9t3Dj+lS1QI3iugXCiEgHS1vFiVOBJm7mZ
	A4tIxYIhkUZAI6/XIhxHqpcs2URpoDU6lL4KW/GVJ3G4Bo3Pw3HWI0ejDhSl5drP63ZIKeXANvF
	dCgmrwUSjCQgx0JO4Frc9BSpL55H6cTV5Ypobzh8g3twUnGTahGPWmgdgUCbTGT2ek597fyKiEP
	JRPG315ccD24c2PYnd+3SpP2RpmWhkGcQuVth5MW98YZrwBD6QuBWXboGnPfZoSKDn3
X-Google-Smtp-Source: AGHT+IEmDmiP9adgHvZUH4ZdlfvVLP7hkdCZyPEoUJ32kAK8T+wIcxazuHb4UVtZBttRZSUEDk4d+Q==
X-Received: by 2002:a5d:6d03:0:b0:386:3213:5b80 with SMTP id ffacd0b85a97d-38a1a274920mr1045676f8f.24.1734572543725;
        Wed, 18 Dec 2024 17:42:23 -0800 (PST)
Received: from serenity.mandelbit.com ([2001:67c:2fbc:1:3257:f823:e26a:c3fa])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4364a376846sm63615715e9.0.2024.12.18.17.42.21
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 18 Dec 2024 17:42:23 -0800 (PST)
From: Antonio Quartulli <antonio@openvpn.net>
Date: Thu, 19 Dec 2024 02:42:08 +0100
Subject: [PATCH net-next v16 14/26] skb: implement
 skb_send_sock_locked_with_flags()
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20241219-b4-ovpn-v16-14-3e3001153683@openvpn.net>
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
X-Developer-Signature: v=1; a=openpgp-sha256; l=3763; i=antonio@openvpn.net;
 h=from:subject:message-id; bh=+I0CIsXtEiIwM67fyET5J2S6dQohwJOCqzXgQfocGBc=;
 b=owEBbQGS/pANAwAIAQtw5TqgONWHAcsmYgBnY3oWuuG/wRfGFDKMhdE5emdD3X85H9AV4LMSR
 6NnMRVCSdSJATMEAAEIAB0WIQSZq9xs+NQS5N5fwPwLcOU6oDjVhwUCZ2N6FgAKCRALcOU6oDjV
 h8w4B/4jileuqzc56A1VuiSz3H9+qoRWC3/uD2rM+Ki2t9ncx/3TEEd0i6mQ7MFuUTDFNYde2m8
 7SlQYrSawN0hXDAjsw8neL8IBb77VfM2oF3LdRybot0cMX+UnAH/iVAd9zg1AEeJAXGAsMzl3IF
 SOBx+Yn14No5yMLwBsfn9snRI8A9gmeQ3KBGgmaQBRgDN7kmn4fvzb3EwaGb8TcfwaH2eFl+qm/
 N27Vkea7LKQxYqLmOSIGgfvnV19tTopRGKo506UqY6CyDhlzPodEeawiFbe8Fp3dnxZ4rzd2+C/
 qCPTuFiYwYhSh28dTJg6ZBOMxbBPqRx9RS9ePaO4Vo5yyzFQ
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
index b2509cd0b930688d9ae94bc4e37a7549797e608f..86c2eea2344114c6b51b38d402167fe6175a8a92 100644
--- a/include/linux/skbuff.h
+++ b/include/linux/skbuff.h
@@ -4154,6 +4154,8 @@ int skb_splice_bits(struct sk_buff *skb, struct sock *sk, unsigned int offset,
 		    unsigned int flags);
 int skb_send_sock_locked(struct sock *sk, struct sk_buff *skb, int offset,
 			 int len);
+int skb_send_sock_locked_with_flags(struct sock *sk, struct sk_buff *skb,
+				    int offset, int len, int flags);
 int skb_send_sock(struct sock *sk, struct sk_buff *skb, int offset, int len);
 void skb_copy_and_csum_dev(const struct sk_buff *skb, u8 *to);
 unsigned int skb_zerocopy_headlen(const struct sk_buff *from);
diff --git a/net/core/skbuff.c b/net/core/skbuff.c
index a441613a1e6c1765f7fc2e40f982b81f8f8fdb96..e83327bcbce37625f5c0b8b0581d6e3bf5fb55a5 100644
--- a/net/core/skbuff.c
+++ b/net/core/skbuff.c
@@ -3267,7 +3267,7 @@ static int sendmsg_unlocked(struct sock *sk, struct msghdr *msg)
 
 typedef int (*sendmsg_func)(struct sock *sk, struct msghdr *msg);
 static int __skb_send_sock(struct sock *sk, struct sk_buff *skb, int offset,
-			   int len, sendmsg_func sendmsg)
+			   int len, sendmsg_func sendmsg, int flags)
 {
 	unsigned int orig_len = len;
 	struct sk_buff *head = skb;
@@ -3285,7 +3285,7 @@ static int __skb_send_sock(struct sock *sk, struct sk_buff *skb, int offset,
 		kv.iov_base = skb->data + offset;
 		kv.iov_len = slen;
 		memset(&msg, 0, sizeof(msg));
-		msg.msg_flags = MSG_DONTWAIT;
+		msg.msg_flags = MSG_DONTWAIT | flags;
 
 		iov_iter_kvec(&msg.msg_iter, ITER_SOURCE, &kv, 1, slen);
 		ret = INDIRECT_CALL_2(sendmsg, sendmsg_locked,
@@ -3322,7 +3322,8 @@ static int __skb_send_sock(struct sock *sk, struct sk_buff *skb, int offset,
 		while (slen) {
 			struct bio_vec bvec;
 			struct msghdr msg = {
-				.msg_flags = MSG_SPLICE_PAGES | MSG_DONTWAIT,
+				.msg_flags = MSG_SPLICE_PAGES | MSG_DONTWAIT |
+					     flags,
 			};
 
 			bvec_set_page(&bvec, skb_frag_page(frag), slen,
@@ -3368,14 +3369,21 @@ static int __skb_send_sock(struct sock *sk, struct sk_buff *skb, int offset,
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
2.45.2


