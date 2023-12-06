Return-Path: <netdev+bounces-54384-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 90D5D806D96
	for <lists+netdev@lfdr.de>; Wed,  6 Dec 2023 12:13:42 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 4428A281B40
	for <lists+netdev@lfdr.de>; Wed,  6 Dec 2023 11:13:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8B193315A7;
	Wed,  6 Dec 2023 11:13:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=theori.io header.i=@theori.io header.b="J8bwQQZe"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pl1-x632.google.com (mail-pl1-x632.google.com [IPv6:2607:f8b0:4864:20::632])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7D760C3
	for <netdev@vger.kernel.org>; Wed,  6 Dec 2023 03:13:34 -0800 (PST)
Received: by mail-pl1-x632.google.com with SMTP id d9443c01a7336-1d06819a9cbso29128165ad.1
        for <netdev@vger.kernel.org>; Wed, 06 Dec 2023 03:13:34 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=theori.io; s=google; t=1701861214; x=1702466014; darn=vger.kernel.org;
        h=content-disposition:mime-version:message-id:subject:cc:to:from:date
         :from:to:cc:subject:date:message-id:reply-to;
        bh=7i8p6B2ghm30k4bcKSBkkS2M9cpAiFkI2BQp4RK+W6k=;
        b=J8bwQQZegKQAKZWn1hq33SGrN607/mTkaKE/hlDFPg8vNfCaKqB2X3RE1neSHb/0bI
         gaxUY2rVU3X6bk+iJ6vq+IaPCcsznIZhS9EdilLUe/pKx5FbENadGvY2aH4Hg6RiCZQi
         rOUaKVo3JBnhtW8qXOai+6xR7vKjoKjipsasA=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1701861214; x=1702466014;
        h=content-disposition:mime-version:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=7i8p6B2ghm30k4bcKSBkkS2M9cpAiFkI2BQp4RK+W6k=;
        b=atdWBTxJGpJ9LTgF6Jid/PEh+MisoEXTl5yKjjOGqbfBvwGVhd43TW/m34aMQ178sl
         v9xbRfeFJDUijjYAcMLbRjAz7huMx0H/nehXRuPF5cOnhva8aTZtz4eMCRuvk6Bnfrlx
         75h9JcuE8zgYyh+v7BBHWMRWuVT/rHbFCTV9FBsdB4e5IIneRdBxoRnYQ3io6Y0U86En
         LQQpjr6PUF+6bldP3Jm6lAyEk1eP1K78SiyWBdQLGbJfh6IeL/fgu5IWMclK10ZrXOnb
         yZz5DTQuC1oTerLrq9hguMuaDnauXqm7dv4B09kslAq0FTybbW0ILNDzQmI4kTRfkuLQ
         JrDQ==
X-Gm-Message-State: AOJu0YyLyB2EDX525o/65osXE7RiyecxBbtpbX/n5qaQOSjH/U50afhU
	ghYq1dC2gmZgxOs3X+5PMJ2Y8g==
X-Google-Smtp-Source: AGHT+IHyO7csI0IuiNs8mzji5TYTnhV7Hye3QQW9UPXvFHaYpXzKeWoRwXXvJryxe5gT02hfi9sxLA==
X-Received: by 2002:a17:90b:314e:b0:286:e34a:d178 with SMTP id ip14-20020a17090b314e00b00286e34ad178mr502109pjb.36.1701861213912;
        Wed, 06 Dec 2023 03:13:33 -0800 (PST)
Received: from ubuntu ([211.219.71.65])
        by smtp.gmail.com with ESMTPSA id t13-20020a1709028c8d00b001cfd35ec1d7sm11806933plo.243.2023.12.06.03.13.31
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 06 Dec 2023 03:13:33 -0800 (PST)
Date: Wed, 6 Dec 2023 03:13:29 -0800
From: Hyunwoo Kim <v4bel@theori.io>
To: ralf@linux-mips.org, edumazet@google.com
Cc: v4bel@theori.io, imv4bel@gmail.com, davem@davemloft.net,
	kuba@kernel.org, pabeni@redhat.com, linux-hams@vger.kernel.org,
	netdev@vger.kernel.org
Subject: [PATCH v3] net/rose: Fix Use-After-Free in rose_ioctl
Message-ID: <20231206111329.GA9888@ubuntu>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

Because rose_ioctl() accesses sk->sk_receive_queue
without holding a sk->sk_receive_queue.lock, it can
cause a race with rose_accept().
A use-after-free for skb occurs with the following flow.
```
rose_ioctl() -> skb_peek()
rose_accept() -> skb_dequeue() -> kfree_skb()
```
Add sk->sk_receive_queue.lock to rose_ioctl() to fix this issue.

Fixes: 1da177e4c3f4 ("Linux-2.6.12-rc2")
Signed-off-by: Hyunwoo Kim <v4bel@theori.io>
---
v1 -> v2: Use sk->sk_receive_queue.lock instead of lock_sock.
v2 -> v3: Change spin_lock to spin_lock_irq
---
 net/rose/af_rose.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/net/rose/af_rose.c b/net/rose/af_rose.c
index 0cc5a4e19900..7ff76bf3f56e 100644
--- a/net/rose/af_rose.c
+++ b/net/rose/af_rose.c
@@ -1316,8 +1316,10 @@ static int rose_ioctl(struct socket *sock, unsigned int cmd, unsigned long arg)
 		struct sk_buff *skb;
 		long amount = 0L;
 		/* These two are safe on a single CPU system as only user tasks fiddle here */
+		spin_lock_irq(&sk->sk_receive_queue.lock);
 		if ((skb = skb_peek(&sk->sk_receive_queue)) != NULL)
 			amount = skb->len;
+		spin_unlock_irq(&sk->sk_receive_queue.lock);
 		return put_user(amount, (unsigned int __user *) argp);
 	}
 
-- 
2.25.1


