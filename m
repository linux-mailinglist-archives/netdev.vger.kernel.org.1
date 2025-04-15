Return-Path: <netdev+bounces-182711-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 6165BA89BFC
	for <lists+netdev@lfdr.de>; Tue, 15 Apr 2025 13:21:07 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 52DAC7AAFA3
	for <lists+netdev@lfdr.de>; Tue, 15 Apr 2025 11:19:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1169929A3F0;
	Tue, 15 Apr 2025 11:17:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=openvpn.net header.i=@openvpn.net header.b="a3p/Jopz"
X-Original-To: netdev@vger.kernel.org
Received: from mail-wr1-f43.google.com (mail-wr1-f43.google.com [209.85.221.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 642FC297A5C
	for <netdev@vger.kernel.org>; Tue, 15 Apr 2025 11:17:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744715869; cv=none; b=LKQ+q1h4vDSFjrUT4eWFTbODHXjuC1i0iDhBCqHuQjM7SoVnxNrRjo+2ASZR2izSx71f5VJyIP8glAWvpDOlz+cq41IctaRz3KuRcexEcJ+8DltADhWNP1Um/UfWCfU2CuG63mghOxpAjrnakYRE84ct4LB5XZdS98sy/eohTFw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744715869; c=relaxed/simple;
	bh=f2L/6MV3WoY+r58AHmJzHD1uZB1yXOJNNlPf35u+BQk=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=Tu8YvCxAcC+imk4CLM0RlcJFzkHJtZMdfSnJCDiJidv+r+kr9j9fsneXYbmzOfz9ENPbA2AdrAzBMfEBB/e/w5il+ujhxpAnUd6H9WNAcKZ2PBDcG31UVFG+pSxPhiawlzUbBU9DhSIb77ZpzIClyOHal0saO5sbFHvUwiEeiAs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=openvpn.net; spf=pass smtp.mailfrom=openvpn.com; dkim=pass (2048-bit key) header.d=openvpn.net header.i=@openvpn.net header.b=a3p/Jopz; arc=none smtp.client-ip=209.85.221.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=openvpn.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=openvpn.com
Received: by mail-wr1-f43.google.com with SMTP id ffacd0b85a97d-3914a5def6bso3128733f8f.1
        for <netdev@vger.kernel.org>; Tue, 15 Apr 2025 04:17:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=openvpn.net; s=google; t=1744715863; x=1745320663; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=9WYY/11xBcIOkdKUznP/08VpnWtjoWEZk7RzwrODJkE=;
        b=a3p/Jopzb2Ad1EWqHIHFnpxP6QRwW40Jgxp1CxXRbxi2GpgWvSkzo1OzMKk7Mr3zXr
         WG8CkPSfJGWtnwP/e6rWBWosxd+XXdhToMLfON/oLJasww4iqcgBcLxRPDvJQfmOl8gi
         adI9xBwXLiDPOPSfZCKFTtcRpiXnJK+9jZw6sF1RSMdfYj9IBk7cJXdYf8M15vLmfhMT
         EGzGV/jcPUtr7Kcsq/MAm4P8Xs59rD6+cU12RyXCd1LC+BOfC6aR4CS9FqvdAlxaDsH/
         E+iSFg6+e0dD5IGnc+lvOE7J+/mKY3u3nW7UfFPIlBpHNBAtrEoyJAemLNCZ0Ti37i5H
         qPoQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1744715863; x=1745320663;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=9WYY/11xBcIOkdKUznP/08VpnWtjoWEZk7RzwrODJkE=;
        b=tv9socarR2vzdVUFYVlrERi/0aThDONf8xiVw/a0LdBG2z9V/e2nRkLWq6XbB8likn
         L9RfGiRB0lRvM70bMQz/XzjEjQoRbIWI7ZcJweCs1B5JQ7oyGXL9aVFVYGuiy0lsEbqQ
         21nO/limpqvlwnbYsgR6Mtcc+SqJMHXkF9NgtIRtgUnztPFNdix0/EhsHj1PyuqTJS41
         9T3NIE7Yvwr+UpoaV792MZPLJyw5Sdd0d+9QWFWxeHGyE3Ap8owy46jjMb3QLiFhM7dz
         yDVkxZRbX7/hhEEq1utglr2ueSjK/tObvNrpikzBNFTtOf+WbtOZrJ76JCxsKdClRk2P
         gEdw==
X-Gm-Message-State: AOJu0YxBOjiP/+8tDUS0nptom3Qusqa9tsegfp6LzP5SlgWIKvCy8KK5
	BkXWh7x4Zlj9ad2fZgThrrAz0fD0EmEgfU0MV3MorD4dsxEMPkHMHwP+5MZuD4b8TSQck1hEpgf
	jb7d9cqMiWAXA0M3QGlcXR1HzSVJBh1wvBqHLdOm/BguGDH8=
X-Gm-Gg: ASbGncv9xswygsl70vWQ8BQ4O1pKcUItFeOkRbSOjHffYC7zWOSHbxCbIPN/YTXK4FH
	9InWYiatvIHUFYh1UMktk+d2gJQzcrsiVrb6UPXaA4C1fiWoSTa0t5653UPSllaLBRhfkG/lynw
	y4alD9vsRM0yCebMKXwshHYU3pj+mufl59f1K2HNjHk6/GOoXYoU2aAtSzKqnK9dyBAdLmSsnYw
	HWB1kMtamudGXkTS9YMGwpErQDn+s7F5hUUt4DGkD4PKKHvqhMjYyiX6nMQ8/6iZzV7YRKkqLOG
	wow4BI8mvY+RJd3AZkY//eb9kCrNr5h1P0fiQedfRvdakYvq
X-Google-Smtp-Source: AGHT+IGxnmTpIEZoPgKS6KSxnbaUdq8NgL5AA63J7oNVT7dDt++Ud3v8hl4tc0WEstdoOJvr+/JphA==
X-Received: by 2002:a05:6000:2401:b0:391:20ef:62d6 with SMTP id ffacd0b85a97d-39ea51ee240mr13529343f8f.11.1744715863426;
        Tue, 15 Apr 2025 04:17:43 -0700 (PDT)
Received: from [127.0.0.1] ([2001:67c:2fbc:1:83ac:73b4:720f:dc99])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-43f2066d26bsm210836255e9.22.2025.04.15.04.17.42
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 15 Apr 2025 04:17:42 -0700 (PDT)
From: Antonio Quartulli <antonio@openvpn.net>
Date: Tue, 15 Apr 2025 13:17:29 +0200
Subject: [PATCH net-next v26 12/23] skb: implement
 skb_send_sock_locked_with_flags()
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250415-b4-ovpn-v26-12-577f6097b964@openvpn.net>
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
X-Developer-Signature: v=1; a=openpgp-sha256; l=3763; i=antonio@openvpn.net;
 h=from:subject:message-id; bh=f2L/6MV3WoY+r58AHmJzHD1uZB1yXOJNNlPf35u+BQk=;
 b=owGbwMvMwMHIXfDUaoHF1XbG02pJDOn/HJyiXoau2Hdf+eVp3mXTziazBBS8/NLn2bQxboJrq
 2X0d9faTkZjFgZGDgZZMUWWmavv5Py4IvTkXvyBPzCDWJlApjBwcQrAREQcORjWJM4wtUyWduXv
 dA3dLR3LVOOqOXM3h1Yzx4H9d+NyY1zPqWfGLdkmIHnNrNTVJO2fjglvpFCIqJ5DQ3i41/PM1+8
 Y16dGNP2+eLLuafQe7xuSS9P7DfWmfOU2ilPwKOLWLCzUM+WPP2Ux9diXzUd2/oh3zr/m5X4leL
 G+2Nr4RV1c//e+NWKwlJt8Q2P1amnNu3uS4iavYXGrfpcWM+t16x053+Vrz2VzGE1NSmlttZu43
 fHAZX3Wn1UlewLnsZ9JiC+aeO1YqE6d76LDi6QuVJYFnc0q6s3X6yreXW90bEOg0IzX0nb3bsy+
 cvyLoV5asMaNSGZZNesvyQzqLeeuWUf8z0tyzn+e+7wIAA==
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
index f1381aff0f896220b2b6bc706aaca17b8f28fd8b..beb084ee4f4d2a83165e08d3a5918d0bc9bfc069 100644
--- a/include/linux/skbuff.h
+++ b/include/linux/skbuff.h
@@ -4145,6 +4145,8 @@ int skb_splice_bits(struct sk_buff *skb, struct sock *sk, unsigned int offset,
 		    unsigned int flags);
 int skb_send_sock_locked(struct sock *sk, struct sk_buff *skb, int offset,
 			 int len);
+int skb_send_sock_locked_with_flags(struct sock *sk, struct sk_buff *skb,
+				    int offset, int len, int flags);
 int skb_send_sock(struct sock *sk, struct sk_buff *skb, int offset, int len);
 void skb_copy_and_csum_dev(const struct sk_buff *skb, u8 *to);
 unsigned int skb_zerocopy_headlen(const struct sk_buff *from);
diff --git a/net/core/skbuff.c b/net/core/skbuff.c
index 74a2d886a35b518d55b6d3cafcb8442212f9beee..d73ad79fe739d1c412615ed01f0850dbf4c9e09e 100644
--- a/net/core/skbuff.c
+++ b/net/core/skbuff.c
@@ -3227,7 +3227,7 @@ static int sendmsg_unlocked(struct sock *sk, struct msghdr *msg)
 
 typedef int (*sendmsg_func)(struct sock *sk, struct msghdr *msg);
 static int __skb_send_sock(struct sock *sk, struct sk_buff *skb, int offset,
-			   int len, sendmsg_func sendmsg)
+			   int len, sendmsg_func sendmsg, int flags)
 {
 	unsigned int orig_len = len;
 	struct sk_buff *head = skb;
@@ -3245,7 +3245,7 @@ static int __skb_send_sock(struct sock *sk, struct sk_buff *skb, int offset,
 		kv.iov_base = skb->data + offset;
 		kv.iov_len = slen;
 		memset(&msg, 0, sizeof(msg));
-		msg.msg_flags = MSG_DONTWAIT;
+		msg.msg_flags = MSG_DONTWAIT | flags;
 
 		iov_iter_kvec(&msg.msg_iter, ITER_SOURCE, &kv, 1, slen);
 		ret = INDIRECT_CALL_2(sendmsg, sendmsg_locked,
@@ -3282,7 +3282,8 @@ static int __skb_send_sock(struct sock *sk, struct sk_buff *skb, int offset,
 		while (slen) {
 			struct bio_vec bvec;
 			struct msghdr msg = {
-				.msg_flags = MSG_SPLICE_PAGES | MSG_DONTWAIT,
+				.msg_flags = MSG_SPLICE_PAGES | MSG_DONTWAIT |
+					     flags,
 			};
 
 			bvec_set_page(&bvec, skb_frag_page(frag), slen,
@@ -3328,14 +3329,21 @@ static int __skb_send_sock(struct sock *sk, struct sk_buff *skb, int offset,
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
2.49.0


