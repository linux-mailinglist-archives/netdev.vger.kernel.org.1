Return-Path: <netdev+bounces-135257-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 4332C99D386
	for <lists+netdev@lfdr.de>; Mon, 14 Oct 2024 17:38:53 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 6B1F81C22D72
	for <lists+netdev@lfdr.de>; Mon, 14 Oct 2024 15:38:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9C37A1BC58;
	Mon, 14 Oct 2024 15:38:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=cloudflare.com header.i=@cloudflare.com header.b="RJNDVQ1e"
X-Original-To: netdev@vger.kernel.org
Received: from mail-wr1-f52.google.com (mail-wr1-f52.google.com [209.85.221.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B376519E98B
	for <netdev@vger.kernel.org>; Mon, 14 Oct 2024 15:38:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728920306; cv=none; b=u6RwvXcYrxkLmWIsPdzVMTt/sdkUi+28Y67T+7f9BoPIU9u4DNVFQnzJMnq+NnULL4XR226gOCh8rGhdHM9Qh1sHjiJLND9W+64kBga1fGu+YMprEatfgfsfrid6ZpO14RFHHJZPi4Lpq6T3fU+lcIBNR91IOAnKF5cpPOxkDEY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728920306; c=relaxed/simple;
	bh=1bN+QEotEpIRBT6cXWz23R8634LnGKN+Ky65Id1kG+8=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=K6pWutDF11D4XWKuW9dpWkVPpFv59r/VT0OC7dbJSJOYAoudoT/vRS1DtAt4xkpYqEmefwLQoLv5XSW/hJeVYnXtg4zNSig7g4u6fl3CDAFfoqcv37WArWMJax/qfZtgeKEPSg2WGmYo+YUvz4HmkbIFW8GGwY4ngsWBrzTKq7A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=cloudflare.com; spf=pass smtp.mailfrom=cloudflare.com; dkim=pass (2048-bit key) header.d=cloudflare.com header.i=@cloudflare.com header.b=RJNDVQ1e; arc=none smtp.client-ip=209.85.221.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=cloudflare.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=cloudflare.com
Received: by mail-wr1-f52.google.com with SMTP id ffacd0b85a97d-37d473c4bb6so3471145f8f.3
        for <netdev@vger.kernel.org>; Mon, 14 Oct 2024 08:38:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=cloudflare.com; s=google09082023; t=1728920303; x=1729525103; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=oRUPHKnK+G7iaw/aUVaZN8QnmGwAZh5z1e5fpZvzMzU=;
        b=RJNDVQ1eKw80sPypm9wytcdbY4bKkip70lRcKlrDqwnKq89gcFV3E9Ml50zx5PWpiL
         CDK52zTEyZx4XxoMaulb37d4piZbghUzQ+JbGf+r5F23uxPBi7a/U9sPES9+Ea/Q/f2D
         8p7rfrQT2YwtCMRYzJNkmrKH8gN+V13g1AdXy5xo6cGZ2/x6kVZFmIjviHKrymm57erx
         5P2g8tNAtOGzFXPDbf1ebe2sM8gaxTyIgWIJ+OjfEvPUBtPUEVqlmO7ppz6W8E30qMuM
         WeMWefrYfQ4SxNLJEsnBkXjRYIKlKgN9yUPRUrH7OCLO5FgEZf5kIp+PrLQVjBWZlWS7
         cHCg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1728920303; x=1729525103;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=oRUPHKnK+G7iaw/aUVaZN8QnmGwAZh5z1e5fpZvzMzU=;
        b=wBeuDjfuzrWP7W2WTV99YxD1RyIM0I9j8DHSNqk+CLxOLXPr+8vG8M+LYl8F/q7e0Q
         nZfA0n+pKvRAxOApUyzdaAaIzCHDP4UKguGLySELuIkOyJTp6Iel/tOZpp+EItqP3TiT
         PRyaj6ceWY7Asim1OKzSwHfhLdh/bJGAZrwS0DDO2izTpi2EPeaRutESPn/J7CEsnJJa
         rGhDhy8IWX3dzKbRyYcCt4mUL5Bt8TOoQisw8NGX3LB9JfPY98H1XnQlBqvcayQapKgf
         tYkNRb2xzu8py43iDqFM+ELNKiR4vN7CRuPuCfbFfurcuseTgw20p8LWmSp5Fb6IluwV
         pYHA==
X-Forwarded-Encrypted: i=1; AJvYcCXdxh/2Cp6SRo5G2m1CNV8Q1dDQU3bMu1Y0WA7nmPs4f+OKpBfuS7mDS6/C/js5AxNHcLCq0jM=@vger.kernel.org
X-Gm-Message-State: AOJu0YzZXtefYCEim/atIm+zqW6W+Y7XcO5+2z1k3fpbk4K+Yi5wsAoz
	hHw6AuXHsOuHmKDMGkH8N8CYW0jB+Q54Y+5T6q7Ft0yLdCopuhPoNTexZjAZd1Y=
X-Google-Smtp-Source: AGHT+IEaE6C7r4ltNMskXO+tjNMKt9+qcANcSAGt9ehXwYkCcmFGRyHWUT3EcbTB5H99ngatuL8/sw==
X-Received: by 2002:a5d:4f8a:0:b0:37c:d1ea:f1ce with SMTP id ffacd0b85a97d-37d5ff8db28mr6535195f8f.25.1728920303012;
        Mon, 14 Oct 2024 08:38:23 -0700 (PDT)
Received: from localhost.localdomain ([2a09:bac5:50cb:432::6b:93])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-37d4b6a8940sm11725913f8f.6.2024.10.14.08.38.20
        (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
        Mon, 14 Oct 2024 08:38:22 -0700 (PDT)
From: Ignat Korchagin <ignat@cloudflare.com>
To: "David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Marcel Holtmann <marcel@holtmann.org>,
	Johan Hedberg <johan.hedberg@gmail.com>,
	Luiz Augusto von Dentz <luiz.dentz@gmail.com>,
	Oliver Hartkopp <socketcan@hartkopp.net>,
	Marc Kleine-Budde <mkl@pengutronix.de>,
	Alexander Aring <alex.aring@gmail.com>,
	Stefan Schmidt <stefan@datenfreihafen.org>,
	Miquel Raynal <miquel.raynal@bootlin.com>,
	David Ahern <dsahern@kernel.org>,
	Willem de Bruijn <willemdebruijn.kernel@gmail.com>,
	linux-bluetooth@vger.kernel.org,
	linux-can@vger.kernel.org,
	linux-wpan@vger.kernel.org
Cc: kernel-team@cloudflare.com,
	kuniyu@amazon.com,
	alibuda@linux.alibaba.com,
	Ignat Korchagin <ignat@cloudflare.com>
Subject: [PATCH net-next v3 1/9] af_packet: avoid erroring out after sock_init_data() in packet_create()
Date: Mon, 14 Oct 2024 16:38:00 +0100
Message-Id: <20241014153808.51894-2-ignat@cloudflare.com>
X-Mailer: git-send-email 2.39.5 (Apple Git-154)
In-Reply-To: <20241014153808.51894-1-ignat@cloudflare.com>
References: <20241014153808.51894-1-ignat@cloudflare.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

After sock_init_data() the allocated sk object is attached to the provided
sock object. On error, packet_create() frees the sk object leaving the
dangling pointer in the sock object on return. Some other code may try
to use this pointer and cause use-after-free.

Suggested-by: Eric Dumazet <edumazet@google.com>
Signed-off-by: Ignat Korchagin <ignat@cloudflare.com>
---
 net/packet/af_packet.c | 12 ++++++------
 1 file changed, 6 insertions(+), 6 deletions(-)

diff --git a/net/packet/af_packet.c b/net/packet/af_packet.c
index f8942062f776..99ae27d1e4dc 100644
--- a/net/packet/af_packet.c
+++ b/net/packet/af_packet.c
@@ -3421,17 +3421,17 @@ static int packet_create(struct net *net, struct socket *sock, int protocol,
 	if (sock->type == SOCK_PACKET)
 		sock->ops = &packet_ops_spkt;
 
+	po = pkt_sk(sk);
+	err = packet_alloc_pending(po);
+	if (err)
+		goto out_sk_free;
+
 	sock_init_data(sock, sk);
 
-	po = pkt_sk(sk);
 	init_completion(&po->skb_completion);
 	sk->sk_family = PF_PACKET;
 	po->num = proto;
 
-	err = packet_alloc_pending(po);
-	if (err)
-		goto out2;
-
 	packet_cached_dev_reset(po);
 
 	sk->sk_destruct = packet_sock_destruct;
@@ -3463,7 +3463,7 @@ static int packet_create(struct net *net, struct socket *sock, int protocol,
 	sock_prot_inuse_add(net, &packet_proto, 1);
 
 	return 0;
-out2:
+out_sk_free:
 	sk_free(sk);
 out:
 	return err;
-- 
2.39.5


