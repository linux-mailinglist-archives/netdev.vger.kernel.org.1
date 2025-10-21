Return-Path: <netdev+bounces-231150-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id D9A99BF5B58
	for <lists+netdev@lfdr.de>; Tue, 21 Oct 2025 12:10:48 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 963A04ECCA9
	for <lists+netdev@lfdr.de>; Tue, 21 Oct 2025 10:10:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C378132BF20;
	Tue, 21 Oct 2025 10:10:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=mandelbit.com header.i=@mandelbit.com header.b="GR9bnSVr"
X-Original-To: netdev@vger.kernel.org
Received: from mail-wm1-f51.google.com (mail-wm1-f51.google.com [209.85.128.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F380432B9B8
	for <netdev@vger.kernel.org>; Tue, 21 Oct 2025 10:10:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761041422; cv=none; b=IjyoI8TzUkahMLpzwlAtjBQQdceL+Dpr2SswXjLtYXKjBNerEvhvYJCSpabcgBCbRjwrAV6rtQ/0k7YtcJgZatzWG0+GqTOUZahiONCiD4mjQTzLuDw/7zwpjFHkPFGsWY+lRxlC0aiHBmmJwEw1xj8KhBz0H/gkJt3RsucKyPo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761041422; c=relaxed/simple;
	bh=2EyicdYSSg58m6mYeid4baB/3NpqOlT4oBJJWzQldx0=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=sy0is5JSRStmg/MIbivXVLelOFTyiNTyKt5zHax3z1y226+MxwkkFVvVUsDUpqUQ6/nEUc/yA385sKbbzPubC7Xoo1kSnyegGEzx/L8bygsGpEA6IIXu2GugNez1ramykNosoBRC/96T9JPwhZH089gjnhYXKvjrxJtTIIk35Ro=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=mandelbit.com; spf=pass smtp.mailfrom=mandelbit.com; dkim=pass (2048-bit key) header.d=mandelbit.com header.i=@mandelbit.com header.b=GR9bnSVr; arc=none smtp.client-ip=209.85.128.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=mandelbit.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=mandelbit.com
Received: by mail-wm1-f51.google.com with SMTP id 5b1f17b1804b1-4710022571cso45111115e9.3
        for <netdev@vger.kernel.org>; Tue, 21 Oct 2025 03:10:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=mandelbit.com; s=google; t=1761041419; x=1761646219; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Pnwu16SmAOlMeB6Q3tIUQ4DnXFityKkhFS1K1pQBb/o=;
        b=GR9bnSVrw+suTEWz8XkHUGkPzTbNtIGLOepvkJRIzgKJiHkJWeHsrL9Cd++P0XUUG8
         hUDIvXpzO0PkR1D37ASanMSPB+UOElymIEDyLOM7zCIrK+yeESJlQuJDK0RntAG/miEj
         l5oyKuS3xjnq7i/JgkhdjanNrkMDym30GilQ+JQlAF3t1EysJO6bXZPDrkgFHPsBq4+l
         WpqhBDlLQFqrwpXqijT0OQyguX36f/MMWh+Ibyw+SwDSUpJrdw3BmlTthYE6iDAwWmSE
         fiSc4oD7M0ybLDsUSSeJ6zpc1n67/1X3V385DuO+N8PQywMVoLpi0VGWRO4DO6Sk/N93
         pcEA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1761041419; x=1761646219;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Pnwu16SmAOlMeB6Q3tIUQ4DnXFityKkhFS1K1pQBb/o=;
        b=mC3ckEvkwVprEFZK+jAFNa6U8ngMal9d66+ZlUZXfSZ8PEORGqJ42BQX5LYi1PKUgl
         KnqU2NQjQu6dfng4ft3RtkhTl5Orp2I90RwzJdLrhEm4KnZtuNFzoVU2vGjb8y6w5kbp
         pJVlbJEayliktOckQpL0gob+i3WF5yY5REtUA5sRqa2NKZM6osexxRxTptGQm/MJxgbi
         LlX+RfFxxNDkzDwTicTTrIz1zG3p3c/3gOPJxPnB1Ki1y98QrnbIATQ5nZ0wa0peYo2/
         v9lD6NvjMmKIkB9BWkGGEjTfdTrzgKvJPi4yX++VXlCQaM2ChMZ0/3Euqxyk+J0xPKP+
         9JcQ==
X-Gm-Message-State: AOJu0YyhMyKjgWOzd5ER5gGOT5zbaZnUEo2w1fuAX9o0KCanIvDxk/kj
	iHM08J8FyJ2bYLn5yBLauMgYp96CHpiLHymCXgkIsDiYFUwJJ8GACKbx43KZxYyTTw9MNo1aVQP
	sHo12Ajs=
X-Gm-Gg: ASbGncusrmFj92EWaM4HX6ZaaeoV8M60FR9QSO0l/N8/oUUWMUZGubhEQ80s86TExYh
	i9+KbpFYBKnIq1zFwIDpbUuDEMR0CIYdvGXxZBIH9ulfOf09L2XX5WL6mfnHeRyf9h7oynf2fZJ
	QDj4wiJkz2MWHbsYuCcdGVaHXn8ahxVigLSMbfaFCeMeFPM1z0hIN4LYxf3K1MpHnPJprnV+RrE
	i3V1dL8a5bfxOqirGTGpIN+WxH48mYsJPH3UDMPJrk6sO3+4Ij0BbKycX6nrs9tNMfpq/VWYy4u
	+jb+8PW3J7i7LqwLaD4Ng13Wmo0LJtMUPVCc1a+aBScB8rxfjc3YEGFIyHUoRE6q2QLus+QV1Au
	Hiz9wzLelvV5pcYVxPXj2PyuknWObIEGeTSf0KXKGbUTwDKtcX6quTExPfqiK0flNIHwxcyg=
X-Google-Smtp-Source: AGHT+IFGKO2paV4zIau2CdneSmvKxnUmoQ+//WRDFfEk3JCkDJQ0zGOF7kEISBF3lstwi4vKPO0yjA==
X-Received: by 2002:a05:600d:14:b0:46e:4705:4958 with SMTP id 5b1f17b1804b1-471179174f4mr98349915e9.30.1761041419009;
        Tue, 21 Oct 2025 03:10:19 -0700 (PDT)
Received: from fedora ([2a01:e11:600c:d1a0:3dc8:57d2:efb7:51a8])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-427f009a6c5sm20172032f8f.28.2025.10.21.03.10.18
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 21 Oct 2025 03:10:18 -0700 (PDT)
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
Subject: [PATCH net v3 2/3] espintcp: use datagram_poll_queue for socket readiness
Date: Tue, 21 Oct 2025 12:09:41 +0200
Message-ID: <20251021100942.195010-3-ralf@mandelbit.com>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20251021100942.195010-1-ralf@mandelbit.com>
References: <20251021100942.195010-1-ralf@mandelbit.com>
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


