Return-Path: <netdev+bounces-174360-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 88158A5E5C8
	for <lists+netdev@lfdr.de>; Wed, 12 Mar 2025 21:58:07 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id D649A19C09CF
	for <lists+netdev@lfdr.de>; Wed, 12 Mar 2025 20:57:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F3D6D1F3BB9;
	Wed, 12 Mar 2025 20:54:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=openvpn.net header.i=@openvpn.net header.b="cs/hm/GJ"
X-Original-To: netdev@vger.kernel.org
Received: from mail-wr1-f48.google.com (mail-wr1-f48.google.com [209.85.221.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 153831F2C45
	for <netdev@vger.kernel.org>; Wed, 12 Mar 2025 20:54:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741812884; cv=none; b=kxvjP3WaV1naEiK3wBBmw2jNZhiaY0OQ2uSVzzfzSMkPJxQ9HtQ+TxI3ha9xsiA8g7CdTxtqFJshSJIjSs3LgwFgrAsYqkg/4MElUGmDibvecSGSly37tlP9LvEzBiQbMVtywYb9d0G0h9mELz2JSBnJK2Bfy0K/RjeuzgJ77/M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741812884; c=relaxed/simple;
	bh=7s5Bx5ZbjMC4zD/dWY2YaXmrMwndZtJGYPhF85ahL20=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=iF0hhbrTBpXsYFWzqt3lzRRaQ0PizBNRcu3h3xhwoOpCgosWIWrGwrKiVUDVle9ZWHlLz34IiDpCV85pdpSRl4wl6i+Bo8ppVLjTa58V7iWL7HapvFrUhe8dfLBVOouHefaL4/VIuzMl3nqXfCbQMP5vFoI1Za+GCU4yx95+gBE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=openvpn.net; spf=pass smtp.mailfrom=openvpn.com; dkim=pass (2048-bit key) header.d=openvpn.net header.i=@openvpn.net header.b=cs/hm/GJ; arc=none smtp.client-ip=209.85.221.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=openvpn.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=openvpn.com
Received: by mail-wr1-f48.google.com with SMTP id ffacd0b85a97d-3912c09be7dso173574f8f.1
        for <netdev@vger.kernel.org>; Wed, 12 Mar 2025 13:54:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=openvpn.net; s=google; t=1741812880; x=1742417680; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=aj7l3JFxkV3JUIYqy4m5tX6xQCQ8lcKyoxKw7Xhd+jo=;
        b=cs/hm/GJscco6A71mHhyn4lvABcCt50yqawJ3jmLeOZWI/YpldRSoYlxXddo/rl6wf
         xJaPAP13l6bNTZajj7Bc7TVQG309qdUOIicXP0wlOGwntIxAXVcNh+Ff/rlP6ru3qx7O
         obVdlGwXVdvIOcKwZsDWbrgL13MM3h3lfzrAGY9SOFEagNBL/FxvVd2RmH/Dhg5xY3cg
         GzFpUF+OziG4EzdfKgVbMbHfxUR6A8Btq2vmQxo5PWsdq9vNsh/5xsnSou9Vq0tmHbCg
         CmPtkC7JN8sSz7lWQ5fKMaAi5JgGSQm+7jjOdq9lWaa2ykkRSrKWXh2764SUod1aaKaD
         yD7Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1741812880; x=1742417680;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=aj7l3JFxkV3JUIYqy4m5tX6xQCQ8lcKyoxKw7Xhd+jo=;
        b=smJFnzp2Qtxyh/bPBwVYT92P2qrfV9u3xOhOLVUdLJDEbqqfEmjUk+RIeZ+q9U+bj6
         +r6b2IiEvv98v912S8p1Sh/BpzmA+6j/z3SyllnrbjeL+tPksijgvTKwxKHNnCOFL4da
         JwJCxMmBFYNL9Gz6R6z/5XJH8mxAgrf7ImUcL634uh4BkhvSgdCzpGpgskWxGZ4YpGP1
         NqRoHZXWT1PZe5A9enXZ9/knszLEcv2YDV/7QNmCOqErQ5XuTFs/lDJBqL93Or8a08ZB
         NcYzbFeY8NtTuHHiU2L0RTHl4SH24J+PsCD+uLfswH9wDL5Jve7Ufj8P4HFhE0cdbb+4
         2VBw==
X-Gm-Message-State: AOJu0YxgsHzw4cLiazaoN1lsP3KGmqsFSJlNc8rj9UxaYoQxQJsTyzb6
	d0YtEXd41i18x0jWqZWutR4kM00kv9A45W1rPn6TahecMOluM5CaFKc34BexAMo=
X-Gm-Gg: ASbGncvrAwRN0OtyX7M7Nxu6En8Wj4V84Fw5w52x0g6TcOVnik97UltVK5wcmhYXpA0
	Scz3njMhduMgLNiuceXh2tUBrnLiDQvQKTC9/+w1p1Kki6N/OYBC7ah32afLgBTZhqWthUiMuXB
	f0L3vXKWiGBURdbvKXibGtpFDSA0oMVtpW1T/FAbQTwGotNU2t1aEDVlAOwr0h0Jk87lTGKNXnu
	tG7zKFhNDvlt2Oa/eFGeM57cqyKoRT+53/8b/tr/SnPToDgO/TiClclklkcbN9WkAgLr5IyME9p
	+rDgalDkojSUNuQTeUJR++TEez2g5Ld3AtkCBWD31g==
X-Google-Smtp-Source: AGHT+IFbvXUxVdFwMmuANfoBIjPUkyRJZKkWGTPUuaA/9OmO93Zw2FNviGBa+IJBKDMwN3cuIbYP5A==
X-Received: by 2002:a5d:6c6d:0:b0:390:f641:d8bb with SMTP id ffacd0b85a97d-39132d98b62mr15787982f8f.36.1741812880326;
        Wed, 12 Mar 2025 13:54:40 -0700 (PDT)
Received: from [127.0.0.1] ([2001:67c:2fbc:1:a42b:bae6:6f7d:117f])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-3912c10437dsm22481393f8f.99.2025.03.12.13.54.39
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 12 Mar 2025 13:54:39 -0700 (PDT)
From: Antonio Quartulli <antonio@openvpn.net>
Date: Wed, 12 Mar 2025 21:54:21 +0100
Subject: [PATCH net-next v23 12/23] skb: implement
 skb_send_sock_locked_with_flags()
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250312-b4-ovpn-v23-12-76066bc0a30c@openvpn.net>
References: <20250312-b4-ovpn-v23-0-76066bc0a30c@openvpn.net>
In-Reply-To: <20250312-b4-ovpn-v23-0-76066bc0a30c@openvpn.net>
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
 b=owEBbQGS/pANAwAIAQtw5TqgONWHAcsmYgBn0fR7uLS3f3LLEPQd4z55D+Y2jGcPU4OcJIPTh
 0l0VZOZSEqJATMEAAEIAB0WIQSZq9xs+NQS5N5fwPwLcOU6oDjVhwUCZ9H0ewAKCRALcOU6oDjV
 h2ZmB/9/zf79vMKc/ZN0jXXPU/w4+VLuyGQhPBuWCXGgxx0jNW6pzJmnv3YTz5diozxD0AuUM86
 BGObINml7qXqJ8DHfslyjvkTuU0vXyywEEH7BXbltDxtACDgDY2gas23tbdutHCaLZObc+Dqi2w
 HN8gJkM0E0m6dHUt5RuCYeJ55fMQQNgYNNqvya599ZXfRPdPvY+Uag0P2B2OnvNgLIXfEEwEUO9
 SlWyvSRzqR2zJm8NYCo4FG9ytULNaii4rOwPV0L4vBCDpm0nS77nktUOAZor8gVK74Y0WlQ+PR3
 cYM0X1BHfpqHWVtmVn1ANZQhdUGwqsi1vPOSr4PTivA1rzbF
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


