Return-Path: <netdev+bounces-55532-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id F306A80B358
	for <lists+netdev@lfdr.de>; Sat,  9 Dec 2023 10:05:22 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 02E131C208F4
	for <lists+netdev@lfdr.de>; Sat,  9 Dec 2023 09:05:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DCE3079FD;
	Sat,  9 Dec 2023 09:05:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=theori.io header.i=@theori.io header.b="CH67JK0J"
X-Original-To: netdev@vger.kernel.org
Received: from mail-oi1-x22f.google.com (mail-oi1-x22f.google.com [IPv6:2607:f8b0:4864:20::22f])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 89554EB
	for <netdev@vger.kernel.org>; Sat,  9 Dec 2023 01:05:14 -0800 (PST)
Received: by mail-oi1-x22f.google.com with SMTP id 5614622812f47-3b86f3cdca0so1976739b6e.3
        for <netdev@vger.kernel.org>; Sat, 09 Dec 2023 01:05:14 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=theori.io; s=google; t=1702112714; x=1702717514; darn=vger.kernel.org;
        h=content-disposition:mime-version:message-id:subject:cc:to:from:date
         :from:to:cc:subject:date:message-id:reply-to;
        bh=LQlTLRhrKohgHPSzdkKxnLtFbPFcoNK5KCT+nLgvVuM=;
        b=CH67JK0Jc8mUoau4RSC/OX8lgvANTnmZK59MhJNpn2GsqhfaY5k/BurSXCzs2iCvUI
         zQ180dBJnGKz1AjwENppc498Y0JMZhji9pQJc1A6IGnPuLDLs3Y0azo8yt1bJnfR/Y+t
         gxwS3aiPx7nyatF96RWTEzNJ9j5wNBA8SWxHE=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1702112714; x=1702717514;
        h=content-disposition:mime-version:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=LQlTLRhrKohgHPSzdkKxnLtFbPFcoNK5KCT+nLgvVuM=;
        b=nmGgbha7gbwreCz1uOHZzA63l6/bg/q1pGcC6A7wh/sO5ZbUG8Dqk/ofCrsrzxGScm
         NttLPCiShFce0eedd/gM94PW8YbOQcKi5bum58xmUG68cPexk3VSvZPyFj3ZJTONsfEj
         1m/8yQkl/l+vEHImkklek2yMA2WouniYuNW5HatcUDP28coFJE45BJhpRL/0S1kM9zw0
         h9W62mrsdNC9UpxOu5kUlfm4HHIxUYnG5a9SYT7+KX6ANXk84Q1WHVY8DRteGGGHhM4V
         ZaIlpCJpGhy6Z6K2o5+uKWweyjXNw8xiWK3v+2/YflGxkMtiWg1G2gH/tR41ToSnc58u
         srUw==
X-Gm-Message-State: AOJu0Yyi/hiZlMXgx7MzbCcAFqQGtNTMBvK07YYOT283zLig3XoIGn9d
	nFMR4btQKtKohwWMga43/HeV0g==
X-Google-Smtp-Source: AGHT+IG9ur6DebYr4Ipb1d9LxsjsMef1uAD5lADFrUvEoy9QM3YO/+CYkICSCHz+fy5sjio7Wed4kg==
X-Received: by 2002:a05:6808:17a7:b0:3b9:ee89:540b with SMTP id bg39-20020a05680817a700b003b9ee89540bmr1839142oib.67.1702112713842;
        Sat, 09 Dec 2023 01:05:13 -0800 (PST)
Received: from v4bel-B760M-AORUS-ELITE-AX ([211.219.71.65])
        by smtp.gmail.com with ESMTPSA id i4-20020a62c104000000b006ceba4953f6sm2978096pfg.8.2023.12.09.01.05.11
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 09 Dec 2023 01:05:13 -0800 (PST)
Date: Sat, 9 Dec 2023 04:05:09 -0500
From: Hyunwoo Kim <v4bel@theori.io>
To: davem@davemloft.net, kuba@kernel.org
Cc: v4bel@theori.io, imv4bel@gmail.com, edumazet@google.com,
	pabeni@redhat.com, netdev@vger.kernel.org
Subject: [PATCH net v2] atm: Fix Use-After-Free in do_vcc_ioctl
Message-ID: <20231209090509.GA401342@v4bel-B760M-AORUS-ELITE-AX>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

Because do_vcc_ioctl() accesses sk->sk_receive_queue
without holding a sk->sk_receive_queue.lock, it can
cause a race with vcc_recvmsg().
A use-after-free for skb occurs with the following flow.
```
do_vcc_ioctl() -> skb_peek()
vcc_recvmsg() -> skb_recv_datagram() -> skb_free_datagram()
```
Add sk->sk_receive_queue.lock to do_vcc_ioctl() to fix this issue.

Fixes: 1da177e4c3f4 ("Linux-2.6.12-rc2")
Signed-off-by: Hyunwoo Kim <v4bel@theori.io>
---
v1 -> v2: Change the code style
---
 net/atm/ioctl.c | 7 +++++--
 1 file changed, 5 insertions(+), 2 deletions(-)

diff --git a/net/atm/ioctl.c b/net/atm/ioctl.c
index 838ebf0cabbf..b7684abcf458 100644
--- a/net/atm/ioctl.c
+++ b/net/atm/ioctl.c
@@ -72,15 +72,18 @@ static int do_vcc_ioctl(struct socket *sock, unsigned int cmd,
 		goto done;
 	case SIOCINQ:
 	{
+		long amount;
 		struct sk_buff *skb;
 
 		if (sock->state != SS_CONNECTED) {
 			error = -EINVAL;
 			goto done;
 		}
+		spin_lock_irq(&sk->sk_receive_queue.lock);
 		skb = skb_peek(&sk->sk_receive_queue);
-		error = put_user(skb ? skb->len : 0,
-				 (int __user *)argp) ? -EFAULT : 0;
+		amount = skb ? skb->len : 0;
+		spin_unlock_irq(&sk->sk_receive_queue.lock);
+		error = put_user(amount, (int __user *)argp) ? -EFAULT : 0;
 		goto done;
 	}
 	case ATM_SETSC:
-- 
2.25.1


