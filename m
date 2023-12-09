Return-Path: <netdev+bounces-55540-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 4B64D80B37F
	for <lists+netdev@lfdr.de>; Sat,  9 Dec 2023 10:56:08 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 909F6B20A83
	for <lists+netdev@lfdr.de>; Sat,  9 Dec 2023 09:56:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 15B8411706;
	Sat,  9 Dec 2023 09:56:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=theori.io header.i=@theori.io header.b="JqfW6pkX"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pl1-x633.google.com (mail-pl1-x633.google.com [IPv6:2607:f8b0:4864:20::633])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1CC4710C9
	for <netdev@vger.kernel.org>; Sat,  9 Dec 2023 01:55:58 -0800 (PST)
Received: by mail-pl1-x633.google.com with SMTP id d9443c01a7336-1d0a5422c80so25508785ad.3
        for <netdev@vger.kernel.org>; Sat, 09 Dec 2023 01:55:58 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=theori.io; s=google; t=1702115757; x=1702720557; darn=vger.kernel.org;
        h=content-disposition:mime-version:message-id:subject:cc:to:from:date
         :from:to:cc:subject:date:message-id:reply-to;
        bh=wZ4+Aq/TK/mruGt3BI/J8Ww5wzM6zMUPfnn74f7dNUs=;
        b=JqfW6pkXLHfEqViC/Wew1kGYDXUuscNUlRQUBoJN3IpsTUPGDX/WXWenv02Vs1g4c8
         bynpHg1oxTLFZ06jXSGDcQl+yBWyVJHCUqS10hgUiksuwUxn7LxvOVk6Qt8ZtrQ78qXY
         u7sOyKw5r3swA7ZjahBnHOzPcyOXAex7iE7cY=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1702115757; x=1702720557;
        h=content-disposition:mime-version:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=wZ4+Aq/TK/mruGt3BI/J8Ww5wzM6zMUPfnn74f7dNUs=;
        b=Uf68LIn2LOEZypAirL8vL9AMw/nvRGZyjO0fqEDv6vmKxLsVCKKdWtbWEBvq4dSJ/6
         Mdxu3p7yPz5d3TUeluvyXbtPY0gMYirzMpQ4puNbTcdMzJ1xtXml+u9RpgjUsUU4Nib9
         /L5CZhvcW+wm33FXEaVK3xjF6W2yoiNCR0Z2pm8TTX3j0y+MGthEiXNEqNi5N+CdaaiJ
         JEzIJsg/+2p/ikdqUoYMtHLZ5gy1y8UlaGnTEWW6RgGv1xRnx1kBkeWSWYH5ERfHP/74
         bO78EiPvsWXXpytcF8nNItQTvuhsEonY70Bh5vuSoKWRcXkbv7V0NexoMdLbpeieptzV
         3bwQ==
X-Gm-Message-State: AOJu0Yy1VMkC3xrLL9Y9zQLOyHwGS8tP028YXY/hTJigVtSJ+uZjIhtN
	OO83CURqCHyKORC5YwoaeDygSw==
X-Google-Smtp-Source: AGHT+IFVabmdLqvRAxykPDOuL783guga4xGdbM7xa+fTMVWs/6k+tvIBTR5EtbkfA/RMMSMWIbhJbQ==
X-Received: by 2002:a17:902:b7c3:b0:1d0:6ffe:a0e with SMTP id v3-20020a170902b7c300b001d06ffe0a0emr1258268plz.108.1702115757607;
        Sat, 09 Dec 2023 01:55:57 -0800 (PST)
Received: from v4bel-B760M-AORUS-ELITE-AX ([211.219.71.65])
        by smtp.gmail.com with ESMTPSA id ja19-20020a170902efd300b001d0b0334a9asm3078257plb.155.2023.12.09.01.55.54
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 09 Dec 2023 01:55:57 -0800 (PST)
Date: Sat, 9 Dec 2023 04:55:52 -0500
From: Hyunwoo Kim <v4bel@theori.io>
To: kuniyu@amazon.com, davem@davemloft.net, edumazet@google.com
Cc: v4bel@theori.io, imv4bel@gmail.com, kuba@kernel.org, pabeni@redhat.com,
	horms@kernel.org, dhowells@redhat.com, lukas.bulwahn@gmail.com,
	mkl@pengutronix.de, netdev@vger.kernel.org
Subject: [PATCH v2] appletalk: Fix Use-After-Free in atalk_ioctl
Message-ID: <20231209095552.GA406496@v4bel-B760M-AORUS-ELITE-AX>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

Because atalk_ioctl() accesses sk->sk_receive_queue
without holding a sk->sk_receive_queue.lock, it can
cause a race with atalk_recvmsg().
A use-after-free for skb occurs with the following flow.
```
atalk_ioctl() -> skb_peek()
atalk_recvmsg() -> skb_recv_datagram() -> skb_free_datagram()
```
Add sk->sk_receive_queue.lock to atalk_ioctl() to fix this issue.

Fixes: 1da177e4c3f4 ("Linux-2.6.12-rc2")
Signed-off-by: Hyunwoo Kim <v4bel@theori.io>
---
v1 -> v2: Change the code style
---
 net/appletalk/ddp.c | 8 +++++---
 1 file changed, 5 insertions(+), 3 deletions(-)

diff --git a/net/appletalk/ddp.c b/net/appletalk/ddp.c
index 9ba04a69ec2a..016b8fb7f096 100644
--- a/net/appletalk/ddp.c
+++ b/net/appletalk/ddp.c
@@ -1775,15 +1775,17 @@ static int atalk_ioctl(struct socket *sock, unsigned int cmd, unsigned long arg)
 		break;
 	}
 	case TIOCINQ: {
+		long amount = 0;
+		struct sk_buff *skb;
 		/*
 		 * These two are safe on a single CPU system as only
 		 * user tasks fiddle here
 		 */
-		struct sk_buff *skb = skb_peek(&sk->sk_receive_queue);
-		long amount = 0;
-
+		spin_lock_irq(&sk->sk_receive_queue.lock);
+		skb = skb_peek(&sk->sk_receive_queue);
 		if (skb)
 			amount = skb->len - sizeof(struct ddpehdr);
+		spin_unlock_irq(&sk->sk_receive_queue.lock);
 		rc = put_user(amount, (int __user *)argp);
 		break;
 	}
-- 
2.25.1


