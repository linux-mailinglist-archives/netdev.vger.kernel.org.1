Return-Path: <netdev+bounces-230804-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [213.196.21.55])
	by mail.lfdr.de (Postfix) with ESMTPS id 81569BEFB1B
	for <lists+netdev@lfdr.de>; Mon, 20 Oct 2025 09:38:11 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id F1814345C73
	for <lists+netdev@lfdr.de>; Mon, 20 Oct 2025 07:38:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 217572DE70C;
	Mon, 20 Oct 2025 07:38:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=mandelbit.com header.i=@mandelbit.com header.b="Y653D0rj"
X-Original-To: netdev@vger.kernel.org
Received: from mail-wr1-f47.google.com (mail-wr1-f47.google.com [209.85.221.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 466492DE6FB
	for <netdev@vger.kernel.org>; Mon, 20 Oct 2025 07:38:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760945885; cv=none; b=ECXYN7tJeDFXP83ECm7JaEl6U9UQijiGGD6TRwc4sKC0KlQZDaO+duDKpUlQMHwUB30MUzlhX/dTRyPYe8yq3ONDnyEfjjOutaeJh5DTwEIgZvhRLKK4PFB9uK0QybAi6iEDtR0Q6+gLr76+EBo0SGgM+t6tzFttUNj95iRc+xA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760945885; c=relaxed/simple;
	bh=2EyicdYSSg58m6mYeid4baB/3NpqOlT4oBJJWzQldx0=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=oe7Begy40vAImBULN+eKv7eWZ07FmtPZSaUNsWYKvJiNQ+kTH2JbmHnnZpVnut3LMinZCxD3HxV+i0WyXEiIrT1t+Kpsu81LZiBsQxEMOo4XnaO+2aEnvjfdk0UUoaTZzZ+tMQzETgnhv+Chll18jGE0c76uat6OuTbhYTsrsWs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=mandelbit.com; spf=pass smtp.mailfrom=mandelbit.com; dkim=pass (2048-bit key) header.d=mandelbit.com header.i=@mandelbit.com header.b=Y653D0rj; arc=none smtp.client-ip=209.85.221.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=mandelbit.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=mandelbit.com
Received: by mail-wr1-f47.google.com with SMTP id ffacd0b85a97d-4283be7df63so879263f8f.1
        for <netdev@vger.kernel.org>; Mon, 20 Oct 2025 00:38:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=mandelbit.com; s=google; t=1760945881; x=1761550681; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Pnwu16SmAOlMeB6Q3tIUQ4DnXFityKkhFS1K1pQBb/o=;
        b=Y653D0rjoNvweP0Hq0VMwcGH9QLWjYf1FlU3cHpX6kQgc230+j0IXGXeL+GaPOFLxo
         DuHrCj0xX5KWdOE1wUJDvHSB0aElzLidNYX9Vamq+jWY0CXTSKzLS4C9F2A53rrOKBa6
         iQkmzyUlDvTSNoNpejXy9LYKHJwBTW0c86BoCWpWPuecLjm9FzLeLjejGAYqvonT8fLL
         4U7tTUQnsSI6P+LLzjLkF+isqtx1du/Bg+VlV0Y4bYo8Qa9m6alr9lJcfXEfDDyO6bin
         qnlGqFD1Uc8utyWQtVmoxflkf2wn/qKS9v5jRiKAWHt0RJRvYqmSNBOqe1TrOcU64A6d
         fdBw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1760945881; x=1761550681;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Pnwu16SmAOlMeB6Q3tIUQ4DnXFityKkhFS1K1pQBb/o=;
        b=KBUQABfCnGOlFdIWKElWFXgNHHYNGnSRoIj+u/Wpq9hD63BGmjGaMZ8PWPEIatAtFt
         qrnMNC09516ySVHMY9Z6rEXbwX3A9h9Bo5vL2i/oQz8HtIdxH+7dgeKhF5aVba1T9Iw/
         IlFiJox06TEA6auXITbhaePVyjrXEXn2nKWOwKCYlZtcyqe4t2XBSvJqsGyQnRFtfIuY
         gb7sjX38hllXZsenN5UUW5BJKQTKe37D95DmOk7AQixmJdxkHIj/scip/IL/EmmCBXna
         xNAsHZhdTfa2D5Z+qJuWgOKzswprae3nteDV8+PjUOhNwblp4DIOkC8+SsbgsP1G5k9t
         RC8Q==
X-Gm-Message-State: AOJu0YzFYR/VKcq3u2lkY30r2Sg7orAYOANwTAjrfKMD1jFWjgOJJjJ/
	e+d4FWC0A5XlulbBE12vv1t5I2A+FZSxxWQAASO1fZ7uaxPmYNSZZOKBHku7YIO0sPTBirQW+Tv
	npJxFK4e6JA==
X-Gm-Gg: ASbGncsZnX5k+piDS5OUzyFzDT+pGuLSz0367Trw+c3CCdr79ByTxpfZO3Pt69Tdots
	RBxybPSDSZZhbb/wlK750qogpIJw9SOq5+z5knsXVJsF5EvAVBGIB0Qp4Q9iBatF5Za0z9s7R7H
	HIFEvfqBmxOHMTPqHrHVsBX1vVXdg7JjKcPB9H547Z4XB2C1mBG1ENxa2PAbEVjmLNbz/3+mc/J
	MnjbAZNi8cudpH7h7WetHXWQfCXwVKSNJdqCcHi2bsepbBl1epO2v8goSDfwQguDvvDxrO3zNK2
	ZX+h9r6d+Pw6xyhUdPPFR0uqq7Nz4zkFHo3xJoZhHBWkMaaRzmjC7pKnevmAWo1Hn4bUYKawqXp
	ROimSJqIn7JtAxvI3/r8fyw/nJxkowY4TkNS0IhzR1i/GUurw9nxmKbMw8Olpy9xGsyvSQ3sjLT
	HnDPHi6w==
X-Google-Smtp-Source: AGHT+IEoJ2O0C5NKrqaFTHGOFs1jJ5Qt1iw3Ft7yyZl/KtOYWdSIdxRzaFMMRX63qhgcj/2awnk31Q==
X-Received: by 2002:a05:6000:2887:b0:3e7:68b2:c556 with SMTP id ffacd0b85a97d-42704d7ebd3mr7508746f8f.26.1760945881218;
        Mon, 20 Oct 2025 00:38:01 -0700 (PDT)
Received: from fedora ([2a01:e11:600c:d1a0:3dc8:57d2:efb7:51a8])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-47154d38309sm132862315e9.9.2025.10.20.00.38.00
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 20 Oct 2025 00:38:00 -0700 (PDT)
From: Ralf Lici <ralf@mandelbit.com>
To: netdev@vger.kernel.org
Cc: Ralf Lici <ralf@mandelbit.com>,
	Steffen Klassert <steffen.klassert@secunet.com>,
	Herbert Xu <herbert@gondor.apana.org.au>,
	"David S . Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	Simon Horman <horms@kernel.org>,
	Sabrina Dubroca <sd@queasysnail.net>,
	Antonio Quartulli <antonio@openvpn.net>
Subject: [PATCH net v2 2/3] espintcp: use datagram_poll_queue for socket readiness
Date: Mon, 20 Oct 2025 09:37:30 +0200
Message-ID: <20251020073731.76589-3-ralf@mandelbit.com>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20251020073731.76589-1-ralf@mandelbit.com>
References: <20251020073731.76589-1-ralf@mandelbit.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

espintcp uses a custom queue (ike_queue) to deliver packets to
userspace. The polling logic relies on datagram_poll, which checks
sk_receive_queue, which can lead to false readiness signals when that
queue contains non-userspace packets.

Switch espintcp_poll to use datagram_poll_queue with ike_queue, ensuring
poll only signals readiness when userspace data is actually available.

Fixes: e27cca96cd68 ("xfrm: add espintcp (RFC 8229)")
Signed-off-by: Ralf Lici <ralf@mandelbit.com>
---
 net/xfrm/espintcp.c | 6 +-----
 1 file changed, 1 insertion(+), 5 deletions(-)

diff --git a/net/xfrm/espintcp.c b/net/xfrm/espintcp.c
index fc7a603b04f1..bf744ac9d5a7 100644
--- a/net/xfrm/espintcp.c
+++ b/net/xfrm/espintcp.c
@@ -555,14 +555,10 @@ static void espintcp_close(struct sock *sk, long timeout)
 static __poll_t espintcp_poll(struct file *file, struct socket *sock,
 			      poll_table *wait)
 {
-	__poll_t mask = datagram_poll(file, sock, wait);
 	struct sock *sk = sock->sk;
 	struct espintcp_ctx *ctx = espintcp_getctx(sk);
 
-	if (!skb_queue_empty(&ctx->ike_queue))
-		mask |= EPOLLIN | EPOLLRDNORM;
-
-	return mask;
+	return datagram_poll_queue(file, sock, wait, &ctx->ike_queue);
 }
 
 static void build_protos(struct proto *espintcp_prot,
-- 
2.51.0


