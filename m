Return-Path: <netdev+bounces-147487-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 85F3C9D9CFD
	for <lists+netdev@lfdr.de>; Tue, 26 Nov 2024 18:57:47 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 052F7B2C553
	for <lists+netdev@lfdr.de>; Tue, 26 Nov 2024 17:56:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6A1401DC18F;
	Tue, 26 Nov 2024 17:56:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=riseup.net header.i=@riseup.net header.b="o8bNmHlN"
X-Original-To: netdev@vger.kernel.org
Received: from mx1.riseup.net (mx1.riseup.net [198.252.153.129])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 68DE71DD87C
	for <netdev@vger.kernel.org>; Tue, 26 Nov 2024 17:56:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.252.153.129
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732643793; cv=none; b=Ev6I73oEVXegdRcAQQNssCjheyAQ31EcnN52Cjhg95JnYQDJVT5LoJxh3WPW4tySZE/oiwa9Ot7Wh60qGfeuln4Vf8UMlh9bIJikDkGKZQCvLMKXaeXHSEms2jN/aZY/u0AaQGHqP+Jh++NNmEH67DYxhESXnpksu7aQHG0HePM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732643793; c=relaxed/simple;
	bh=pqH5/5efzrzGVC8IPirhxhe0ODD2Nw/s5uLqUOQqjSU=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=h/YWyM3yoUNYJXwkc6T7jIL5sQzdlcp2+DXBkKoKaW9XL7rb0jzysSXbIEAeQKGXsh4pMjcnm4JxMYkTJgB8Ltw7nBRxoqjRlY4dwDAJgNE65wY5qk6bprJRi/bOiSWjPNxvqqmUy776q64e/zrTpzHDIRixuxYqIVd+AyUK59I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=riseup.net; spf=pass smtp.mailfrom=riseup.net; dkim=pass (1024-bit key) header.d=riseup.net header.i=@riseup.net header.b=o8bNmHlN; arc=none smtp.client-ip=198.252.153.129
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=riseup.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=riseup.net
Received: from fews01-sea.riseup.net (fews01-sea-pn.riseup.net [10.0.1.109])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx1.riseup.net (Postfix) with ESMTPS id 4XyVcn2X7PzDqjn;
	Tue, 26 Nov 2024 17:56:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=riseup.net; s=squak;
	t=1732643785; bh=pqH5/5efzrzGVC8IPirhxhe0ODD2Nw/s5uLqUOQqjSU=;
	h=From:To:Cc:Subject:Date:From;
	b=o8bNmHlNpXw/PuDmxcK0rM+9M65OXgMugP/t2WE0DrTcSLC/D9L5Wdkd5dtc2dIkq
	 se3anPXMuXAVjJR2dDjJx7DEUCL8EphpnZino1vHwW/LySljk4yZXEB62H+PZSGbTP
	 Lc7+HnVVNJVe2kxax+63Dj7qxocMQFBeFyNYptB8=
X-Riseup-User-ID: A9390D39A5160C4D924274524CEABF36733992B58953CCB0C8C20381F36E36D7
Received: from [127.0.0.1] (localhost [127.0.0.1])
	 by fews01-sea.riseup.net (Postfix) with ESMTPSA id 4XyVcm0HP9zJrVB;
	Tue, 26 Nov 2024 17:56:23 +0000 (UTC)
From: Fernando Fernandez Mancera <ffmancera@riseup.net>
To: netdev@vger.kernel.org
Cc: edumazet@google.com,
	willemb@google.com,
	Fernando Fernandez Mancera <ffmancera@riseup.net>
Subject: [PATCH net] udp: call sock_def_readable() if socket is not SOCK_FASYNC
Date: Tue, 26 Nov 2024 17:53:15 +0000
Message-ID: <20241126175402.1506-1-ffmancera@riseup.net>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

If a socket is not SOCK_FASYNC, sock_def_readable() needs to be called
even if receive queue was not empty. Otherwise, if several threads are
listening on the same socket with blocking recvfrom() calls they might
hang waiting for data to be received.

Link: https://bugzilla.redhat.com/2308477
Fixes: 612b1c0dec5b ("udp: avoid calling sock_def_readable() if possible")
Signed-off-by: Fernando Fernandez Mancera <ffmancera@riseup.net>
---
 net/ipv4/udp.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/net/ipv4/udp.c b/net/ipv4/udp.c
index 6a01905d379f..4c398e6945ee 100644
--- a/net/ipv4/udp.c
+++ b/net/ipv4/udp.c
@@ -1722,6 +1722,7 @@ int __udp_enqueue_schedule_skb(struct sock *sk, struct sk_buff *skb)
 	if (!sock_flag(sk, SOCK_DEAD)) {
 		if (becomes_readable ||
 		    sk->sk_data_ready != sock_def_readable ||
+		    !sock_flag(sk, SOCK_FASYNC) ||
 		    READ_ONCE(sk->sk_peek_off) >= 0)
 			INDIRECT_CALL_1(sk->sk_data_ready,
 					sock_def_readable, sk);
-- 
2.47.1


