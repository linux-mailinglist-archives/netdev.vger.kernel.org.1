Return-Path: <netdev+bounces-157680-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 5CB07A0B2F3
	for <lists+netdev@lfdr.de>; Mon, 13 Jan 2025 10:34:33 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 6534E166475
	for <lists+netdev@lfdr.de>; Mon, 13 Jan 2025 09:34:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9241D28EC86;
	Mon, 13 Jan 2025 09:31:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=openvpn.net header.i=@openvpn.net header.b="P393Fgc1"
X-Original-To: netdev@vger.kernel.org
Received: from mail-wm1-f45.google.com (mail-wm1-f45.google.com [209.85.128.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 78156284A4C
	for <netdev@vger.kernel.org>; Mon, 13 Jan 2025 09:31:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736760685; cv=none; b=XXif9Y23FDR20NPZTu8+QzpwOi84VrxemERfYxHOeOc5hEaeFfB/vV+yIi1HLDHieC/lUnIRx/rFbOKXyttGGwAuvOVxCWLNMe32F9BE563qfG+nGOmKfqDU84LO29Y4JqNb0Ztoz/jdorarCrWnTrvAWXH0opl955n0oIEixSM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736760685; c=relaxed/simple;
	bh=fHoVTVq5BbCLTwJdoK2tOCtjrx/maX1L8ZezNHLmiiA=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=mlOflD1/0dThi1ZM4TwNnxaoWdHL8Hbd5xYpeAq6stF/UoGvpeANNs80lWCw8z7Tx/OrWEa6buZ0xs6e3fQI4vQLx5qmo/1Bh8QH6/zg+N7fuA/jFnl4VHx8s6PwDOP341zxLeWusaK6oa18xnPMeDqNPAkIsd9Z24KiHLeriNc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=openvpn.net; spf=pass smtp.mailfrom=openvpn.com; dkim=pass (2048-bit key) header.d=openvpn.net header.i=@openvpn.net header.b=P393Fgc1; arc=none smtp.client-ip=209.85.128.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=openvpn.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=openvpn.com
Received: by mail-wm1-f45.google.com with SMTP id 5b1f17b1804b1-43690d4605dso27777985e9.0
        for <netdev@vger.kernel.org>; Mon, 13 Jan 2025 01:31:22 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=openvpn.net; s=google; t=1736760681; x=1737365481; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=6j2GBpc2aFHsc+qlcjcQ+gt1cS1cPMzxzPpCsISmzE0=;
        b=P393Fgc1Z6tRfPmhd65AjAf0nDUHFQV89AhqXpsj7hVyKwoXz1AaGQ8g7WOZ2Z3u3+
         MxzLamqdquYIwvpDI2GPgX9RVfzuxfx/kPq1P7ixGDctsOgoAZ9krmGSjHxu6sKbs6Bw
         3z+LfXHavB21JrigXnIogJ9/ckBOntQGVqof1YZ/DGDPq1acPF5m4dp61wt0HCMyvXrl
         1cZ6r7btn04OOaLH6DOv/eMs6ti8CnO6WiCuEeEc/6NKKNSU5ZQ9U+JPRN9HUzDnVKp8
         XnJhJtp1xOOlE75bf5Pr446Xs+3Np+lRk3gCDg5nXu98PbJLYZuDKjW3T3DbFVQ56led
         QQ0g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1736760681; x=1737365481;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=6j2GBpc2aFHsc+qlcjcQ+gt1cS1cPMzxzPpCsISmzE0=;
        b=Dv+sK3geEVAY8vcICzvfrFQFc7Or2wDEeFqSZGoYXqVJcNPuhhYtvSTGjUWIavifrA
         x3AQYffSFVRThOodkcfd4JKP5fI0wu3ZeUVU5Dhr95YCVO6arZSK4Fr26l90UMaXMuZg
         NTkh3Pj+psEI9JXqchLxbUpQwDm1EQTa0eH06FRiMV9PEXnTakGqbUEnrm894Ugj9Aiq
         nfaNsVEb9T2Cz6SLiUpMwkuSQMwvuxJ8cu9ggmwu3NXqFT0IJun6PpFODqMv30oz43Ld
         KilmQLhLccH4EWPAbnuxX2ZdBP4/y5LkVszjj3IpiMIquao/kwN5serS6IqtuJnkjMJn
         jKVg==
X-Gm-Message-State: AOJu0YzQQmmYee3NiZKoggRwmamox2uYpt+gY2k3LIj/MHBEcbHj8h+S
	FM+f3ngctpTeZGghch13c5ffUSXZ1wwfuESR+sWcCgcE/GOIsRQHT6d3GP9IvAc=
X-Gm-Gg: ASbGnctLbfBJzG2ov5WlF+rdXm96rHBWgnbin52maZZ/6+WayGnu5Ej5sMBbeh9KXRP
	+l1VoWsiBXQF/lldt9tnihFjfngk2RI+sznwH1f2rgDQnXN6Lg9YMcRYBp7jvmUQmbmKs5aXQek
	ityJPmLYUr5inHywajRG9LaUwLgCFyEn+9w6NYLWD0H0h9vlteQrMNHQn2EAg0Kah6HKgAD/kxo
	IyHO/1MuCxXem+dkfwsZWNLKX8QjFRb7BQ3VKM+y/0SeyYbZmTvHDptw2kZrMCi5mJE
X-Google-Smtp-Source: AGHT+IFrKIhQ7xOhmlUpQonxHs/N/xUqIGkQKeU6TsioAPz4xO4S4+IAOjd9TnxRVmL4k8QC4LMFAQ==
X-Received: by 2002:a05:6000:2ce:b0:38a:6807:f86 with SMTP id ffacd0b85a97d-38a872da793mr16452988f8f.17.1736760680822;
        Mon, 13 Jan 2025 01:31:20 -0800 (PST)
Received: from serenity.mandelbit.com ([2001:67c:2fbc:1:8305:bf37:3bbd:ed1d])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-38a8e4b8124sm11528446f8f.81.2025.01.13.01.31.19
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 13 Jan 2025 01:31:20 -0800 (PST)
From: Antonio Quartulli <antonio@openvpn.net>
Date: Mon, 13 Jan 2025 10:31:32 +0100
Subject: [PATCH net-next v18 13/25] skb: implement
 skb_send_sock_locked_with_flags()
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250113-b4-ovpn-v18-13-1f00db9c2bd6@openvpn.net>
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
X-Developer-Signature: v=1; a=openpgp-sha256; l=3763; i=antonio@openvpn.net;
 h=from:subject:message-id; bh=fHoVTVq5BbCLTwJdoK2tOCtjrx/maX1L8ZezNHLmiiA=;
 b=owEBbQGS/pANAwAIAQtw5TqgONWHAcsmYgBnhN2HCQHoLkwzqusCSo4Fq2Og793SAFYT06Bs8
 NPYmtzs/wSJATMEAAEIAB0WIQSZq9xs+NQS5N5fwPwLcOU6oDjVhwUCZ4TdhwAKCRALcOU6oDjV
 h8HvB/9iAZkyT5WgcYuAO3JERo7e309WHpQJ1i36PeI9yw6zPEJ9c8zgBTVx92WcPRIBnRyQ5vA
 H/tYEn41/r3I4LBKZcDZWHqRDFzcJ8YPvq9G4R9x+Tj6sA+QbyrQq0RKs2eykaq5wEXnjksUz3n
 wfsK+R9lfrjeAc7PwQOhfd4UFIsl+fALwGlYlzopfkgU1VOq1CLdr5k2pyjnhAOfzdL1NCmZUKJ
 1MkHtUZG40++f/Z8UFc6ZIocejg+XuXWDd/+mFrH0P58fpny30txBiNuLIVROkgOBzsa4p79HJr
 K7rqmOt8GQyzDIRpwVGVI2Y6YXq3NBXBtrFzidVNDEf3cVp1
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
index bb2b751d274acff931281a72e8b4b0c699b4e8af..c7afa7871e1c26e0caad4f77facf8a225425bce5 100644
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


