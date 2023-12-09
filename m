Return-Path: <netdev+bounces-55542-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 0993280B38A
	for <lists+netdev@lfdr.de>; Sat,  9 Dec 2023 11:05:51 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id B2F3D1F21052
	for <lists+netdev@lfdr.de>; Sat,  9 Dec 2023 10:05:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CBAF011C8E;
	Sat,  9 Dec 2023 10:05:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=theori.io header.i=@theori.io header.b="Oe9dcVWc"
X-Original-To: netdev@vger.kernel.org
Received: from mail-oa1-x2d.google.com (mail-oa1-x2d.google.com [IPv6:2001:4860:4864:20::2d])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B15091703
	for <netdev@vger.kernel.org>; Sat,  9 Dec 2023 02:05:43 -0800 (PST)
Received: by mail-oa1-x2d.google.com with SMTP id 586e51a60fabf-1f055438492so2018501fac.3
        for <netdev@vger.kernel.org>; Sat, 09 Dec 2023 02:05:43 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=theori.io; s=google; t=1702116343; x=1702721143; darn=vger.kernel.org;
        h=content-disposition:mime-version:message-id:subject:cc:to:from:date
         :from:to:cc:subject:date:message-id:reply-to;
        bh=s5PCTRTJRZnHK1MRbANCAmJkU16b0mVctmay1KaTY14=;
        b=Oe9dcVWcGt38FFugG/p/rM+T2epgZb+dJRdQT9xt2VuSDCDLvIU9VqMWtIk1beFZUo
         WDWbJt+KSid8TNEpnSYt1cRLr3H+0gSQMweiKN0yzCzzeR6I/WIZZYer9sQYDQU0ROq0
         r9N+hyL9aIXJFc4QbNI7k32C0HEByOb4ZWV3w=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1702116343; x=1702721143;
        h=content-disposition:mime-version:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=s5PCTRTJRZnHK1MRbANCAmJkU16b0mVctmay1KaTY14=;
        b=NhecGSL4wTU773ywsAAvq27qATM+Lh5E7bHhb5cM2rF9IqwzNcGstKtz+evVvv0BiD
         VqE4p9uXcUq1IyybQoqpU3Xk4TH5nw3Q4riYz7fJRmqE9rA5+svwwOR0t+xgA4j+4DOZ
         6iqvBmMdyDGsFuah/XFCRPaQqsOilgRECdjvgJrTp8genPr6QiqokoavSUS0rkFn83rD
         HgOXItYQ5yH5VXMu2RBYiWc8rD5250t9csd6H69mqZCaHso7v0E+1cilj0A1M3JyoPcB
         LfktJuFCyG1TjlnyqwLcQHaQD/krR0qF88uxW1nmDfD7xh6QvOuNimmMjlxWBDVVvP0w
         moOQ==
X-Gm-Message-State: AOJu0YyYgqTkvLNzYXBm026PDM/9mbnJL22+dLQB9Sc7OFU4U88jYy8G
	vQuUXAqf62b6wkPaYyU7rGjNLw==
X-Google-Smtp-Source: AGHT+IFqUTfK53OGgVUo3hyrpGjNPYDkuoBGZ7aTIyivGMBPwZwtRUuRlEC6XuuIsvCmvt2qXtNnvA==
X-Received: by 2002:a05:6870:d18c:b0:1fb:2bec:9fb5 with SMTP id a12-20020a056870d18c00b001fb2bec9fb5mr2088274oac.0.1702116343074;
        Sat, 09 Dec 2023 02:05:43 -0800 (PST)
Received: from v4bel-B760M-AORUS-ELITE-AX ([211.219.71.65])
        by smtp.gmail.com with ESMTPSA id 17-20020aa79111000000b006ce6c661701sm2642953pfh.139.2023.12.09.02.05.40
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 09 Dec 2023 02:05:42 -0800 (PST)
Date: Sat, 9 Dec 2023 05:05:38 -0500
From: Hyunwoo Kim <v4bel@theori.io>
To: ralf@linux-mips.org, edumazet@google.com
Cc: v4bel@theori.io, imv4bel@gmail.com, davem@davemloft.net,
	kuba@kernel.org, pabeni@redhat.com, linux-hams@vger.kernel.org,
	netdev@vger.kernel.org
Subject: [PATCH v4] net/rose: Fix Use-After-Free in rose_ioctl
Message-ID: <20231209100538.GA407321@v4bel-B760M-AORUS-ELITE-AX>
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
v3 -> v4: Delete old comments
---
 net/rose/af_rose.c | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/net/rose/af_rose.c b/net/rose/af_rose.c
index 0cc5a4e19900..ecb91ad4ce63 100644
--- a/net/rose/af_rose.c
+++ b/net/rose/af_rose.c
@@ -1315,9 +1315,11 @@ static int rose_ioctl(struct socket *sock, unsigned int cmd, unsigned long arg)
 	case TIOCINQ: {
 		struct sk_buff *skb;
 		long amount = 0L;
-		/* These two are safe on a single CPU system as only user tasks fiddle here */
+
+		spin_lock_irq(&sk->sk_receive_queue.lock);
 		if ((skb = skb_peek(&sk->sk_receive_queue)) != NULL)
 			amount = skb->len;
+		spin_unlock_irq(&sk->sk_receive_queue.lock);
 		return put_user(amount, (unsigned int __user *) argp);
 	}
 
-- 
2.25.1


