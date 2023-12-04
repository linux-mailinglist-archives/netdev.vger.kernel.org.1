Return-Path: <netdev+bounces-53385-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 935EE802BC5
	for <lists+netdev@lfdr.de>; Mon,  4 Dec 2023 07:57:18 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 1A87EB208D6
	for <lists+netdev@lfdr.de>; Mon,  4 Dec 2023 06:57:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B98AF186C;
	Mon,  4 Dec 2023 06:57:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=theori.io header.i=@theori.io header.b="N/THPLzd"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pl1-x62d.google.com (mail-pl1-x62d.google.com [IPv6:2607:f8b0:4864:20::62d])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F2DC8D5
	for <netdev@vger.kernel.org>; Sun,  3 Dec 2023 22:57:06 -0800 (PST)
Received: by mail-pl1-x62d.google.com with SMTP id d9443c01a7336-1d06fffdb65so6005235ad.2
        for <netdev@vger.kernel.org>; Sun, 03 Dec 2023 22:57:06 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=theori.io; s=google; t=1701673026; x=1702277826; darn=vger.kernel.org;
        h=content-disposition:mime-version:message-id:subject:cc:to:from:date
         :from:to:cc:subject:date:message-id:reply-to;
        bh=BQerDqLT/YuVKy8PnJF+K7oN0s4BlSSuzOpk3jy8sxI=;
        b=N/THPLzddHjFTXscP7K0dZrgxzepvVC8wnhnHn0UUG0ltE6Pxu7XxNcXrpocyVMuEU
         s9i8VPkO7iFQDdbuXQ7itX3QzqjW0KWZjG3uTvuiTASHjMS9OyV/BuTilsVsxrK9Ngyo
         3y3CwHeeZPsUnaINeX4PnabSyC28Blol/jhTo=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1701673026; x=1702277826;
        h=content-disposition:mime-version:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=BQerDqLT/YuVKy8PnJF+K7oN0s4BlSSuzOpk3jy8sxI=;
        b=gXKWuQmapinaT6Hf8DXHRryN2OrNHoATd8UaCZkpsfKvkMPIBOoFmlAd+PavPpokGY
         qF1GvsZr07wPIXdFI9zK2aMpO1ygbBcj95+V1r3xYa1scvTPaMPgJTmfMZrNQvuS6AXU
         ga47E3CA/QSgKfeF6UX13SRK5h/OB9ie4vcaEfoWlH2DI5LjRzxYVxfPSw4mPv4qH2Fn
         6QorYfai4hm9DAWbtZ7rCqaDxx/6a26hRNY0aJ6+vppKJC07woUlR3jItUPJWx6qD0hQ
         fFNj/z+8DOSEpQ7LQF9UiB9eUsUoC680bMbl8jdXnQmKV1ILHmIrKku1ZqqIp3XnZl0n
         lLXg==
X-Gm-Message-State: AOJu0YyxOhkh/1M5mtifz2/x0NMGFxug1QPj0w4A1a95G6K2IFTZ+b37
	qatuPYyIA4nx+K2sMuFXdGLJXg==
X-Google-Smtp-Source: AGHT+IFNNVKaL+XBoun/3jgvrDxt2YOZK0MpsdVAjuRuoVTESBuUf6Y2VzcR5p72aXnQye4i+YOtrQ==
X-Received: by 2002:a17:902:d48a:b0:1d0:9c9d:dcde with SMTP id c10-20020a170902d48a00b001d09c9ddcdemr574828plg.122.1701673026294;
        Sun, 03 Dec 2023 22:57:06 -0800 (PST)
Received: from ubuntu ([211.219.71.65])
        by smtp.gmail.com with ESMTPSA id ja5-20020a170902efc500b001d0b080c7e6sm655829plb.208.2023.12.03.22.57.03
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 03 Dec 2023 22:57:05 -0800 (PST)
Date: Sun, 3 Dec 2023 22:56:57 -0800
From: Hyunwoo Kim <v4bel@theori.io>
To: ralf@linux-mips.org
Cc: v4bel@theori.io, imv4bel@gmail.com, davem@davemloft.net,
	edumazet@google.com, kuba@kernel.org, pabeni@redhat.com,
	linux-hams@vger.kernel.org, netdev@vger.kernel.org
Subject: [PATCH] net/rose: Fix Use-After-Free in rose_ioctl
Message-ID: <20231204065657.GA16054@ubuntu>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

Because rose_ioctl() accesses sk->sk_receive_queue
without holding a lock_sock, it can cause a race with
rose_accept().
A use-after-free for skb occurs with the following flow.
```
rose_ioctl() -> skb_peek()
rose_accept() -> skb_dequeue() -> kfree_skb()
```
Add lock_sock to rose_ioctl() to fix this issue.

Signed-off-by: Hyunwoo Kim <v4bel@theori.io>
---
 net/rose/af_rose.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/net/rose/af_rose.c b/net/rose/af_rose.c
index 0cc5a4e19900..5fe9db64b6df 100644
--- a/net/rose/af_rose.c
+++ b/net/rose/af_rose.c
@@ -1316,8 +1316,10 @@ static int rose_ioctl(struct socket *sock, unsigned int cmd, unsigned long arg)
 		struct sk_buff *skb;
 		long amount = 0L;
 		/* These two are safe on a single CPU system as only user tasks fiddle here */
+		lock_sock(sk);
 		if ((skb = skb_peek(&sk->sk_receive_queue)) != NULL)
 			amount = skb->len;
+		release_sock(sk);
 		return put_user(amount, (unsigned int __user *) argp);
 	}
 
-- 
2.25.1


