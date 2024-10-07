Return-Path: <netdev+bounces-132860-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B46C1993959
	for <lists+netdev@lfdr.de>; Mon,  7 Oct 2024 23:37:37 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 64741283683
	for <lists+netdev@lfdr.de>; Mon,  7 Oct 2024 21:37:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 70A041DE4F3;
	Mon,  7 Oct 2024 21:35:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=cloudflare.com header.i=@cloudflare.com header.b="XbgRrvyu"
X-Original-To: netdev@vger.kernel.org
Received: from mail-wm1-f53.google.com (mail-wm1-f53.google.com [209.85.128.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BEE861DCB2B
	for <netdev@vger.kernel.org>; Mon,  7 Oct 2024 21:35:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728336952; cv=none; b=oQ2AP0lMbnF52HzjGcNf8GG0nh8LsrXA43hjpOZw5KMkGg8DiCm1pcTg7D7/qAXYTmkH2zZexPAHhPkrV2pCIJo4PbLK1fziMoumHR3UzoWTXXcWAP5Uk91g+y8JgIuxdsBArJQsvQ92ZfBj2OYcWWSZ7qAJavQp54lkJG8+4ZE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728336952; c=relaxed/simple;
	bh=CZ5nZ72LPsUscQ/XLvrhFET6jRbMhyKZW1WicnfpLPA=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=Aza5iQor/4QrPfvB+dQf6wtU6fvt9M0K7gRbvbxkoGOJz6Bgo2YP1htR9iPPSpEUq0n0tyyR9smeHECgXeuggjCF0t7Io0ZmjEtRndbdQycSDWC72xxtXH7fivm5UrrrD1iyfn+zDP7T9k7QlIUxrF4WE0vyGTVPPgdLbPOKr3c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=cloudflare.com; spf=pass smtp.mailfrom=cloudflare.com; dkim=pass (2048-bit key) header.d=cloudflare.com header.i=@cloudflare.com header.b=XbgRrvyu; arc=none smtp.client-ip=209.85.128.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=cloudflare.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=cloudflare.com
Received: by mail-wm1-f53.google.com with SMTP id 5b1f17b1804b1-42e7b7bef42so43843985e9.3
        for <netdev@vger.kernel.org>; Mon, 07 Oct 2024 14:35:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=cloudflare.com; s=google09082023; t=1728336949; x=1728941749; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=BU52YEIbPPjVkPgQ3Y9wQ3w91aLQy4KsNcSSu3XlZvI=;
        b=XbgRrvyuC2C4UUGZm1Kyg96OotgJi3Y38sEyztjS4C7nn6SzwMxGBHUv+ISEXyhnCe
         NwCcE5oQT+9dmYlJgr4gj7chS4UxdDFK/yvxlG6ToSyZk/7mFcz9HRHnfgtjH4n+RDnQ
         Y9uLI7/25fDkq10IXfmGRUhdKg8ek/QPQiatskwJDBcE5sZp1/cRIfnkfUSvngRmMyFU
         qGG67meoIL8OdvgiUmEF5XBWJtcQGpV53mCCeAAFh5tfYNLlu9S76mcaFC5SzHUQo9hA
         O1B6ZCKm6FzwhcasSZe1SCWk4GdzS+65+UWUWatz8tpZklAEPMPbq6Zp78R9NMz7Z6HJ
         0coA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1728336949; x=1728941749;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=BU52YEIbPPjVkPgQ3Y9wQ3w91aLQy4KsNcSSu3XlZvI=;
        b=jmfy4xLwDlEFOiNQMi6Ar2S+CpEY5yKWkygH/1lJYPjj4zUXj3Aqys8sBkERfsdEaP
         tT3sy86cj4BcgMLq4qZ9DqP7elaFx7+I3ahwBVYLLNOl/1Qzpf+CRsSlEKGEF1X+seiA
         GAI6/OF3kH+yAm0sW5LbpvD3mZ3njCUOIH6lLum/Dp1MKb3PJzzQ+pYfrVbRkVFp4Jue
         7qdBSDc6TBIxCZDgXFeZsBlM+dZohePUNLg18yQJ9CDIWB+6y/tQNJGw2q6EuEIG2R1k
         RejwYQIoeAuVf1oiP5oXEvGIgwn+Bz/qeZKkj2v2NutrrS5WaLkvhClXaA5Opxm6mq5+
         wUIA==
X-Forwarded-Encrypted: i=1; AJvYcCUtkXcW8qxzAm1m/CYys/sl6KpXJrk0HMZbzQWbB+rbW3ny2ZwJ9UxFSMN8/dQckFndAmY2lU0=@vger.kernel.org
X-Gm-Message-State: AOJu0YytIKHMx2OtC70fs3cUzXpXcib7jjHDHg92HkgXCIo1KiY4NpOR
	F1/orjl6rgXSiANDuSQQZuh9L1fu1WuR0kaUFBBFIb3ySeveEo/pRc1j45to37w=
X-Google-Smtp-Source: AGHT+IF3Mr1m0BA+tyZxEbsXfJoH0mYfnXmhY4oQRsrEz2kQrNeN0a7g/aWeWG/UvI2YgEescmo9xg==
X-Received: by 2002:a5d:5f88:0:b0:37c:d179:2f77 with SMTP id ffacd0b85a97d-37d0e6bc9f8mr9021915f8f.12.1728336949047;
        Mon, 07 Oct 2024 14:35:49 -0700 (PDT)
Received: from localhost.localdomain ([104.28.192.66])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-37d1691a4absm6535887f8f.29.2024.10.07.14.35.47
        (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
        Mon, 07 Oct 2024 14:35:48 -0700 (PDT)
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
Subject: [PATCH v2 6/8] net: ieee802154: do not leave a dangling sk pointer in ieee802154_create()
Date: Mon,  7 Oct 2024 22:35:00 +0100
Message-Id: <20241007213502.28183-7-ignat@cloudflare.com>
X-Mailer: git-send-email 2.39.5 (Apple Git-154)
In-Reply-To: <20241007213502.28183-1-ignat@cloudflare.com>
References: <20241007213502.28183-1-ignat@cloudflare.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

sock_init_data() attaches the allocated sk object to the provided sock
object. If ieee802154_create() fails later, the allocated sk object is
freed, but the dangling pointer remains in the provided sock object, which
may allow use-after-free.

Clear the sk pointer in the sock object on error.

Signed-off-by: Ignat Korchagin <ignat@cloudflare.com>
---
 net/ieee802154/socket.c | 12 +++++++-----
 1 file changed, 7 insertions(+), 5 deletions(-)

diff --git a/net/ieee802154/socket.c b/net/ieee802154/socket.c
index 990a83455dcf..18d267921bb5 100644
--- a/net/ieee802154/socket.c
+++ b/net/ieee802154/socket.c
@@ -1043,19 +1043,21 @@ static int ieee802154_create(struct net *net, struct socket *sock,
 
 	if (sk->sk_prot->hash) {
 		rc = sk->sk_prot->hash(sk);
-		if (rc) {
-			sk_common_release(sk);
-			goto out;
-		}
+		if (rc)
+			goto out_sk_release;
 	}
 
 	if (sk->sk_prot->init) {
 		rc = sk->sk_prot->init(sk);
 		if (rc)
-			sk_common_release(sk);
+			goto out_sk_release;
 	}
 out:
 	return rc;
+out_sk_release:
+	sk_common_release(sk);
+	sock->sk = NULL;
+	goto out;
 }
 
 static const struct net_proto_family ieee802154_family_ops = {
-- 
2.39.5


