Return-Path: <netdev+bounces-165354-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id CD2C1A31BBC
	for <lists+netdev@lfdr.de>; Wed, 12 Feb 2025 03:11:55 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 2A4E4188980B
	for <lists+netdev@lfdr.de>; Wed, 12 Feb 2025 02:12:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6836F155389;
	Wed, 12 Feb 2025 02:11:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="gvExjHDs"
X-Original-To: netdev@vger.kernel.org
Received: from mail-qk1-f175.google.com (mail-qk1-f175.google.com [209.85.222.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D31531482F2
	for <netdev@vger.kernel.org>; Wed, 12 Feb 2025 02:11:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.175
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739326309; cv=none; b=NpDTku8pJcJheQNq1/O4BkU3Oik5Kaex3Y25saoL9BOIoGTfYaJcUxIamY1N7oQXPZS4aWijjGN61Lho07JTswWB7q2uuTRSe3DhqoZoHnpAk+0pJdKiPgBu2WHgU9f/Xb8FnC9hTww00AfMVkkXG8D5/OJJ8iNUiBEUJkM75QI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739326309; c=relaxed/simple;
	bh=29T/1d3clUmyUSHtHun1fPMlpB4FKy7uaBxDpsIl8Vk=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=IxiTZNXggl1AWnLVQxz+rU6Hk2tdjtaWNoNPIY07t7csJJeS2wsWQ8RYKULUQ7/FS6Omf9sV95qlSFv7X60NaQTMfOmjF3T3FwI9UqzUJIO1rBeL2pOxKAk+LTWJAAx3eko8BHJQaVryS8sHHoJZQwpKe5uW6AxsKe/BDQ16zT0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=gvExjHDs; arc=none smtp.client-ip=209.85.222.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-qk1-f175.google.com with SMTP id af79cd13be357-7be8efa231aso644845885a.2
        for <netdev@vger.kernel.org>; Tue, 11 Feb 2025 18:11:47 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1739326306; x=1739931106; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Kbp0x58wnaxWx2OQ8r+M2p008qFTUoMNTJXOqZPPDes=;
        b=gvExjHDsu7th+WD2UMas0+9UAZ69HObWXF15LjEeqIDQVSkI70D/MRfWrYU1/q9Zfi
         CDSVwSA8XRUjEjWW4DXfNAy5sjdI84AlgXIBDjHW01+yck5jKIey6c671ewYD0daUjwO
         haC7NdYxDVkH71uEjQ/xsGFJALYZls0/0XpYzL+wjFY3SAuPSvn2WLAC8gNlhhnK5fOt
         6ARSAgErUMw9GQQ5z2Ho/Xhcc8+8+qaNWY7RCRrFrdFE7gOVW2KXjj4MBrNSepkYF/Wb
         VWfhS/uUq1XmnjOFdu3A0r3izRvh9wrjAyuuKP6je0sfjSYOqAiwvUEzpHDhWxwOi4ST
         VL/Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1739326306; x=1739931106;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Kbp0x58wnaxWx2OQ8r+M2p008qFTUoMNTJXOqZPPDes=;
        b=LVzqOpvneztv7Wn2+2856d/qLugQdys/+Cpi4pl+LSZjEZhtSxDe5kXQwIHnzx+ty1
         BaulLNbvn4xG6hHkZnLIaa5Qr5U+v4g6GOxDxdVHL1/d4obvFC4OcAYoYLIyN1KC3PyK
         ud2GrZY+Q4eMIf4rzyAbc5uYV91tqBnUsPRGzpE76dlAvJ6YXU1iTQo02ZPysOSkzDMF
         ykq82rDKw8myxdPyJmjo0TxjcQfKCA8MMMZ0IA3l2EzaZfv/O/Bar4a9smhghYv8ClUY
         9zLAFeCAAOs1SErhpFs1SYJDYzLgZaHhAjCln2beX92jA0cTQvWBCCtDL//sANEN6bpl
         cBRw==
X-Gm-Message-State: AOJu0YygnSVFGmf0YDKZgPCB/CW/NgAaeU/PRdNM69lVw8L3klOiiYvm
	dfKvQMIwe1QkrERH43Q3p5W6Rt/l5yx+DzcwY7bBDqAY8Qk70zk/aIr+/g==
X-Gm-Gg: ASbGncv4H197T9WLWRsXCoC9CliayMWwLQ4M57yCUBQC5AXsWhpTV7Bz+wcgtPWbAQa
	l/b/w8UGl5DNHC75LPimEHw3S+fBOTFPJGVV676MNMrCQwBPJ+ed7BSyD5okl7p37ceINmRwffz
	wrPUUY5pR+iTyO8WcBvQi3PpePs/SrGVQrikYoQVQsgUsdDh8UyIGYNB6mH+MKqRK8DGorqMJtM
	ExrICHVl6PcE/Uq9AZZvX/fDQXhcMeq+92b6bsM/m+Y7qU81tZMocfHl1DfF+v0ZfnMF7ZXGWRr
	23jj2Y3H7/tx0m8E7pG6HivCxapBzwr7HZo9vZisTAgee2Q9DHCs4QIiTZSLS6ECjVaqwX//ySB
	H0h5332txGg==
X-Google-Smtp-Source: AGHT+IGsuUJ6x8c/Kmlo+7xDnfFcZI5NthfxvdjTRwqKJoCKZAJaT2PnD5Pyh6y18iCrwJbji91GCw==
X-Received: by 2002:a05:6214:19c8:b0:6e4:42c2:dd9a with SMTP id 6a1803df08f44-6e46edbf613mr25590576d6.45.1739326306663;
        Tue, 11 Feb 2025 18:11:46 -0800 (PST)
Received: from willemb.c.googlers.com.com (15.60.86.34.bc.googleusercontent.com. [34.86.60.15])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-6e44a9a524esm58256126d6.5.2025.02.11.18.11.45
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 11 Feb 2025 18:11:46 -0800 (PST)
From: Willem de Bruijn <willemdebruijn.kernel@gmail.com>
To: netdev@vger.kernel.org
Cc: davem@davemloft.net,
	kuba@kernel.org,
	edumazet@google.com,
	pabeni@redhat.com,
	dsahern@kernel.org,
	horms@kernel.org,
	Willem de Bruijn <willemb@google.com>
Subject: [PATCH net-next v2 1/7] tcp: only initialize sockcm tsflags field
Date: Tue, 11 Feb 2025 21:09:47 -0500
Message-ID: <20250212021142.1497449-2-willemdebruijn.kernel@gmail.com>
X-Mailer: git-send-email 2.48.1.502.g6dc24dfdaf-goog
In-Reply-To: <20250212021142.1497449-1-willemdebruijn.kernel@gmail.com>
References: <20250212021142.1497449-1-willemdebruijn.kernel@gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Willem de Bruijn <willemb@google.com>

TCP only reads the tsflags field. Don't bother initializing others.

Signed-off-by: Willem de Bruijn <willemb@google.com>
---
 net/ipv4/tcp.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/net/ipv4/tcp.c b/net/ipv4/tcp.c
index 992d5c9b2487..5798a900b7bf 100644
--- a/net/ipv4/tcp.c
+++ b/net/ipv4/tcp.c
@@ -1127,7 +1127,7 @@ int tcp_sendmsg_locked(struct sock *sk, struct msghdr *msg, size_t size)
 		/* 'common' sending to sendq */
 	}
 
-	sockcm_init(&sockc, sk);
+	sockc = (struct sockcm_cookie) { .tsflags = READ_ONCE(sk->sk_tsflags)};
 	if (msg->msg_controllen) {
 		err = sock_cmsg_send(sk, msg, &sockc);
 		if (unlikely(err)) {
-- 
2.48.1.502.g6dc24dfdaf-goog


