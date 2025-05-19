Return-Path: <netdev+bounces-191369-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id AD951ABB346
	for <lists+netdev@lfdr.de>; Mon, 19 May 2025 04:36:12 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 522203B64A4
	for <lists+netdev@lfdr.de>; Mon, 19 May 2025 02:35:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 475C31E8338;
	Mon, 19 May 2025 02:35:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="P6nJKqVn"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pl1-f202.google.com (mail-pl1-f202.google.com [209.85.214.202])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A8C231E412A
	for <netdev@vger.kernel.org>; Mon, 19 May 2025 02:35:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.202
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747622127; cv=none; b=WsZGdOx7RZRrfQLc08G9slcuvGQUkJq+l7fZMkx6g7YrAO5TNxWYHs/HiD9+xAau0QGcdX67EfEaUQrzbdSZYqydgjdjjDiQ5Krlq8IAaEbCbhZumvV7/SDHc/PkkVaZdFVncnwVvziPDULhlzu3ta4YJAQeC1g890ZAoyutgvc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747622127; c=relaxed/simple;
	bh=5DzXyFZppL/cq5j1HzYPMxrLP1enrQNOXaKnx3QGtjg=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=Gnyo4t0KgB9zChyalnUimwkH78Nj+1TGcKbLZTDIyHq4z6FK9E/Ltb7MNE0Ct+0N50vwCAjBtlH1bkGCVvknNsf22KS8Cg+kKHPiZ6Y3Hl9aA6+EVwcMQHZ0LU8/U6bUmWZVXGlRhXw4BRjYyJsE7veVKDfJLMsj9NCoxGxuBBQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--almasrymina.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=P6nJKqVn; arc=none smtp.client-ip=209.85.214.202
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--almasrymina.bounces.google.com
Received: by mail-pl1-f202.google.com with SMTP id d9443c01a7336-231d7f59e03so30883805ad.2
        for <netdev@vger.kernel.org>; Sun, 18 May 2025 19:35:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1747622125; x=1748226925; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=Gusqn2FGILPnBfmIj4t7zENeze5uiCs9j+T8Q4RUJFI=;
        b=P6nJKqVnGS+nusg1unC3VlZC4wEsndhTSqpAXtAHzKE8n+a2tZndNuEi8apDdnG95Q
         cWN36sLDp8i62cm3axEGYcj2jlPX7hzuJSvo4puOpptoZifCnHMSEXBGCgW+HlqNpNUF
         1yt5aW922Se5i7v74/y1e6wYEZNihfclmO9t6vyMTI1Od03ftfX0e4LbMWitFW5FddpP
         jO23brPhxB+OPEh2q+lex41t/VbOsLUb5oga3OqwBxJObBdsZkiAXUo0GxNQNvkemv5V
         tpJrJyGwjXlSlHRgevD8/XoC0Bk5P7UziM5Tyxov3iGp6dgw+XsvWOf+Mg3ODCHdaWVo
         2stw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1747622125; x=1748226925;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=Gusqn2FGILPnBfmIj4t7zENeze5uiCs9j+T8Q4RUJFI=;
        b=kgbbYX+2vSwjSjVUuIfZyfygUAkrv+eub74gzTZru9CFbN5CrnFAJYATGJh7oymTk+
         DZXHVaTM3ezoFk4SKFRJeGq+oZODgfgF2m20byjPnWyKKP4xgKDm2BPVkH4vbwuFsb3G
         OjnWjgGP+2Mg/wJE7crCfJ+oVsjJ929kwU3EGoL5FkLyPOlVI9oEGlvM5eRJm0CKY8gg
         KCgH3S012RHCMzcX71FpqY6XFIeHygXZHTy7NE5t9VcueiNB+NDmg2MuPdUYlq+ovcSq
         LtmCqLC6wc0qsPC1I9gjs5UgibCbw/2T4la0q/r3LafhyfX65fBpj3OjtEEY6cafHjPJ
         Gofg==
X-Gm-Message-State: AOJu0Yz+MXCsIWS1n2ZZb+cDZ+2cocehyQ4giZtZryv2jPX/AoJiCz5B
	u05FcRNbB329RRfukwQ+LgDmVOk7b5zqk/IWhOnjuWmpPFFYVRAsn2hyTEdZ2J+RvjFKDLM5CHG
	+cv4UT5SOZXwoOUN3GWxG4qO/uTZBl6tozGSaRmYUvUbmE2/upsdSdYLutRwWUSVU0Yma5qn6Jm
	lLcWbyrGQISb8+HuQ+zuS1MVZ0al/vXp8B04JMYgVZw0xhnLxr3NMxsOBOiAlMNZ8=
X-Google-Smtp-Source: AGHT+IHDDNZkjAjUjolYoSTD0tv7TPNYWLq6jXy11ozQMRE7VpKYIgEpNaXnIZTOp/O8RRLb92Sj8gyGBrpw3U9Zqg==
X-Received: from plblk7.prod.google.com ([2002:a17:903:8c7:b0:231:78bc:586d])
 (user=almasrymina job=prod-delivery.src-stubby-dispatcher) by
 2002:a17:903:2990:b0:22e:5df9:8f67 with SMTP id d9443c01a7336-231d4596da5mr182730955ad.34.1747622124969;
 Sun, 18 May 2025 19:35:24 -0700 (PDT)
Date: Mon, 19 May 2025 02:35:11 +0000
In-Reply-To: <20250519023517.4062941-1-almasrymina@google.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20250519023517.4062941-1-almasrymina@google.com>
X-Mailer: git-send-email 2.49.0.1101.gccaa498523-goog
Message-ID: <20250519023517.4062941-4-almasrymina@google.com>
Subject: [PATCH net-next v1 3/9] net: devmem: preserve sockc_err
From: Mina Almasry <almasrymina@google.com>
To: netdev@vger.kernel.org, linux-kernel@vger.kernel.org, 
	linux-kselftest@vger.kernel.org
Cc: Mina Almasry <almasrymina@google.com>, "David S. Miller" <davem@davemloft.net>, 
	Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, 
	Simon Horman <horms@kernel.org>, Jesper Dangaard Brouer <hawk@kernel.org>, 
	Ilias Apalodimas <ilias.apalodimas@linaro.org>, Neal Cardwell <ncardwell@google.com>, 
	Kuniyuki Iwashima <kuniyu@amazon.com>, David Ahern <dsahern@kernel.org>, 
	Andrew Lunn <andrew+netdev@lunn.ch>, Shuah Khan <shuah@kernel.org>, sdf@fomichev.me, 
	ap420073@gmail.com, praan@google.com, shivajikant@google.com
Content-Type: text/plain; charset="UTF-8"

Preserve the error code returned by sock_cmsg_send and return that on
err.

Signed-off-by: Mina Almasry <almasrymina@google.com>
---
 net/ipv4/tcp.c | 24 ++++++++++--------------
 1 file changed, 10 insertions(+), 14 deletions(-)

diff --git a/net/ipv4/tcp.c b/net/ipv4/tcp.c
index b7b6ab41b496..45abe5772157 100644
--- a/net/ipv4/tcp.c
+++ b/net/ipv4/tcp.c
@@ -1067,7 +1067,7 @@ int tcp_sendmsg_locked(struct sock *sk, struct msghdr *msg, size_t size)
 	int flags, err, copied = 0;
 	int mss_now = 0, size_goal, copied_syn = 0;
 	int process_backlog = 0;
-	bool sockc_valid = true;
+	int sockc_err = 0;
 	int zc = 0;
 	long timeo;
 
@@ -1075,13 +1075,10 @@ int tcp_sendmsg_locked(struct sock *sk, struct msghdr *msg, size_t size)
 
 	sockc = (struct sockcm_cookie){ .tsflags = READ_ONCE(sk->sk_tsflags) };
 	if (msg->msg_controllen) {
-		err = sock_cmsg_send(sk, msg, &sockc);
-		if (unlikely(err))
-			/* Don't return error until MSG_FASTOPEN has been
-			 * processed; that may succeed even if the cmsg is
-			 * invalid.
-			 */
-			sockc_valid = false;
+		sockc_err = sock_cmsg_send(sk, msg, &sockc);
+		/* Don't return error until MSG_FASTOPEN has been processed;
+		 * that may succeed even if the cmsg is invalid.
+		 */
 	}
 
 	if ((flags & MSG_ZEROCOPY) && size) {
@@ -1092,7 +1089,7 @@ int tcp_sendmsg_locked(struct sock *sk, struct msghdr *msg, size_t size)
 		} else if (sock_flag(sk, SOCK_ZEROCOPY)) {
 			skb = tcp_write_queue_tail(sk);
 			uarg = msg_zerocopy_realloc(sk, size, skb_zcopy(skb),
-						    sockc_valid && !!sockc.dmabuf_id);
+						    !sockc_err && !!sockc.dmabuf_id);
 			if (!uarg) {
 				err = -ENOBUFS;
 				goto out_err;
@@ -1102,7 +1099,7 @@ int tcp_sendmsg_locked(struct sock *sk, struct msghdr *msg, size_t size)
 			else
 				uarg_to_msgzc(uarg)->zerocopy = 0;
 
-			if (sockc_valid && sockc.dmabuf_id) {
+			if (!sockc_err && sockc.dmabuf_id) {
 				binding = net_devmem_get_binding(sk, sockc.dmabuf_id);
 				if (IS_ERR(binding)) {
 					err = PTR_ERR(binding);
@@ -1116,7 +1113,7 @@ int tcp_sendmsg_locked(struct sock *sk, struct msghdr *msg, size_t size)
 			zc = MSG_SPLICE_PAGES;
 	}
 
-	if (sockc_valid && sockc.dmabuf_id &&
+	if (!sockc_err && sockc.dmabuf_id &&
 	    (!(flags & MSG_ZEROCOPY) || !sock_flag(sk, SOCK_ZEROCOPY))) {
 		err = -EINVAL;
 		goto out_err;
@@ -1160,9 +1157,8 @@ int tcp_sendmsg_locked(struct sock *sk, struct msghdr *msg, size_t size)
 		/* 'common' sending to sendq */
 	}
 
-	if (!sockc_valid) {
-		if (!err)
-			err = -EINVAL;
+	if (!!sockc_err) {
+		err = sockc_err;
 		goto out_err;
 	}
 
-- 
2.49.0.1101.gccaa498523-goog


