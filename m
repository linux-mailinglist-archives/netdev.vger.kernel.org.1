Return-Path: <netdev+bounces-54399-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 3F8FB806F77
	for <lists+netdev@lfdr.de>; Wed,  6 Dec 2023 13:09:37 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id E06981F212EC
	for <lists+netdev@lfdr.de>; Wed,  6 Dec 2023 12:09:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8AE39358BB;
	Wed,  6 Dec 2023 12:09:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=theori.io header.i=@theori.io header.b="D/hOsNEN"
X-Original-To: netdev@vger.kernel.org
Received: from mail-oo1-xc36.google.com (mail-oo1-xc36.google.com [IPv6:2607:f8b0:4864:20::c36])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0869CBA
	for <netdev@vger.kernel.org>; Wed,  6 Dec 2023 04:09:30 -0800 (PST)
Received: by mail-oo1-xc36.google.com with SMTP id 006d021491bc7-58e256505f7so2595850eaf.3
        for <netdev@vger.kernel.org>; Wed, 06 Dec 2023 04:09:29 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=theori.io; s=google; t=1701864569; x=1702469369; darn=vger.kernel.org;
        h=content-disposition:mime-version:message-id:subject:cc:to:from:date
         :from:to:cc:subject:date:message-id:reply-to;
        bh=VUdX8AHUZyNKsOQIuPu3E/oWx+8+/pEtsEupQddJKnA=;
        b=D/hOsNENpXeBeHVV8e1t0UrWwtvrvjcluYWgxoWS1vltp1YYbdKalCjAbPNu+wLnPp
         5BX1bztFDI/0GXcvUTuMT9cJr+xaX4nPhTxwx97ZhZ27jhxqdbQF8NWCTJGy+qxibJ0f
         EqXb6r60dDM/Ep5+kO8JzNf45il2EBQKhCDBA=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1701864569; x=1702469369;
        h=content-disposition:mime-version:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=VUdX8AHUZyNKsOQIuPu3E/oWx+8+/pEtsEupQddJKnA=;
        b=OS5ch3U+NEK72dwJHV4AWR+uBsXz5+R5MfxK5Q/aWcaf54QXyB4ks/+QrPoc/HpmqD
         z4KMlEMV07Vo99qwI2A/wHzapZBlwbiHDRU4WNRwkf5UQUCLHxxm5zl5muVmhFaRAsMV
         YWkd1gRDKDvCrfdkHvadN7Bma9Sea0OnJQn8eHfxMqoGyv+AfpgZaWx+v5RWE6rZCr9t
         pC/XPDqn38U+83+Zut4XQmpwzJ99xv/tTrIsFMaKMeqx9f3L/bxWY0z1C7c9UG6GuaCD
         boc9CtIzkKugPa9+hLFZaGwxj6j/AbrEcTqeXyUywlc3pFPGtjDOWanfg0k/get90ppy
         3mig==
X-Gm-Message-State: AOJu0YyIvsZjpJsOWI+FTxuxWPoaMP/dsUJP4mE2XCNAVP6wsxa9faN5
	ja3J44lA4s7H//rmet+ppcOWNQ==
X-Google-Smtp-Source: AGHT+IF8ACEgI9PBEDMOyFN7N3ORHyNyztftRX5bV2fbEOqNxDmM/Ir0n+Hv08XOGtU2748NceKzPw==
X-Received: by 2002:a05:6358:9106:b0:170:302b:545f with SMTP id q6-20020a056358910600b00170302b545fmr1151672rwq.56.1701864569208;
        Wed, 06 Dec 2023 04:09:29 -0800 (PST)
Received: from ubuntu ([211.219.71.65])
        by smtp.gmail.com with ESMTPSA id bm10-20020a056a00320a00b006cbafd6996csm11135842pfb.123.2023.12.06.04.09.26
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 06 Dec 2023 04:09:28 -0800 (PST)
Date: Wed, 6 Dec 2023 04:09:23 -0800
From: Hyunwoo Kim <v4bel@theori.io>
To: davem@davemloft.net, edumazet@google.com
Cc: v4bel@theori.io, imv4bel@gmail.com, kuba@kernel.org, pabeni@redhat.com,
	horms@kernel.org, dhowells@redhat.com, lukas.bulwahn@gmail.com,
	mkl@pengutronix.de, netdev@vger.kernel.org
Subject: [PATCH] appletalk: Fix Use-After-Free in atalk_ioctl
Message-ID: <20231206120923.GA14115@ubuntu>
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
 net/appletalk/ddp.c | 5 +++--
 1 file changed, 3 insertions(+), 2 deletions(-)

diff --git a/net/appletalk/ddp.c b/net/appletalk/ddp.c
index 9ba04a69ec2a..f240d5338bc9 100644
--- a/net/appletalk/ddp.c
+++ b/net/appletalk/ddp.c
@@ -1775,15 +1775,16 @@ static int atalk_ioctl(struct socket *sock, unsigned int cmd, unsigned long arg)
 		break;
 	}
 	case TIOCINQ: {
+		long amount = 0;
 		/*
 		 * These two are safe on a single CPU system as only
 		 * user tasks fiddle here
 		 */
+		spin_lock_irq(&sk->sk_receive_queue.lock);
 		struct sk_buff *skb = skb_peek(&sk->sk_receive_queue);
-		long amount = 0;
-
 		if (skb)
 			amount = skb->len - sizeof(struct ddpehdr);
+		spin_unlock_irq(&sk->sk_receive_queue.lock);
 		rc = put_user(amount, (int __user *)argp);
 		break;
 	}
-- 
2.25.1


