Return-Path: <netdev+bounces-56710-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 8C0F28108FF
	for <lists+netdev@lfdr.de>; Wed, 13 Dec 2023 05:11:12 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 467BF2820F3
	for <lists+netdev@lfdr.de>; Wed, 13 Dec 2023 04:11:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F380EBE5F;
	Wed, 13 Dec 2023 04:11:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=theori.io header.i=@theori.io header.b="PZDjCUAh"
X-Original-To: netdev@vger.kernel.org
Received: from mail-oo1-xc2d.google.com (mail-oo1-xc2d.google.com [IPv6:2607:f8b0:4864:20::c2d])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E5BF3CE
	for <netdev@vger.kernel.org>; Tue, 12 Dec 2023 20:11:02 -0800 (PST)
Received: by mail-oo1-xc2d.google.com with SMTP id 006d021491bc7-58a7d13b00bso3783755eaf.1
        for <netdev@vger.kernel.org>; Tue, 12 Dec 2023 20:11:02 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=theori.io; s=google; t=1702440662; x=1703045462; darn=vger.kernel.org;
        h=content-disposition:mime-version:message-id:subject:cc:to:from:date
         :from:to:cc:subject:date:message-id:reply-to;
        bh=D/6OhphYEZNlLcbiJPbj6amf3Q88pF1f8rDn070eSak=;
        b=PZDjCUAhdsui08pM1zCi2RbeiPWlL8zA+Vhc3m+dF0R4MXJXlc4IcwoD7O5bWK+d+4
         o/8YG5o1sJ/yVV1aBV/CIceTaUDF/pVNwt/oPhSiBnETbqrz7r9U/O50HmmIqqoCgwFM
         4reeO9FCfk2rKWB57Lusu0/Us3zd3nxcrtEl4=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1702440662; x=1703045462;
        h=content-disposition:mime-version:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=D/6OhphYEZNlLcbiJPbj6amf3Q88pF1f8rDn070eSak=;
        b=Q7qOE2CqeqyTKfHAZb9rbqjOf8GpfmMg4Hxvnrm9jyk6Fq+NB+OKbNN5CFB9dFtGRW
         B0028m2vLrX1Yls3Rx+ZFJxTE/+/XZBqh/qYDAAz8euJZZY6FVvo1igSmji8gkG58jQQ
         z+5l314kZ6bn3MiU7mOBHvP7ApFvju9TQWXQXifI+Qofhbk5KNcjER8l0Bo1fMSlXKWL
         q17Eq1/NPg4PiI5VkqLdxKCKyHba4SC6khBqJrrsEO5RNhcZs3lsuOLWBJIYPrUN+4Ve
         QuWzXjKmXEygEQsoz5NqlFC3W8sxcwhL2kzvT1XNKXFRUKxSPB+mt9taVB9t8HYycz1I
         AmMg==
X-Gm-Message-State: AOJu0Yy675ghYlw/MZFKpDwr9vCaHepSIvpc0JxelAAoSOPM8+r8uar5
	4hS492jDehSnc03Ti5CQf3QwsQ==
X-Google-Smtp-Source: AGHT+IEsw8l3x+JM528+s5CUbHs8RetQqAoHV18Zv/om3v/VJ5NmzhKHTe0uBKIcqOYNFdO61zuV8Q==
X-Received: by 2002:a05:6358:3117:b0:170:17eb:378c with SMTP id c23-20020a056358311700b0017017eb378cmr7004035rwe.52.1702440662071;
        Tue, 12 Dec 2023 20:11:02 -0800 (PST)
Received: from v4bel-B760M-AORUS-ELITE-AX ([211.219.71.65])
        by smtp.gmail.com with ESMTPSA id mj21-20020a17090b369500b0028ac4d1bd72sm2082730pjb.52.2023.12.12.20.10.58
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 12 Dec 2023 20:11:01 -0800 (PST)
Date: Tue, 12 Dec 2023 23:10:56 -0500
From: Hyunwoo Kim <v4bel@theori.io>
To: pabeni@redhat.com, davem@davemloft.net, edumazet@google.com,
	kuniyu@amazon.com
Cc: v4bel@theori.io, imv4bel@gmail.com, kuba@kernel.org, horms@kernel.org,
	dhowells@redhat.com, lukas.bulwahn@gmail.com, mkl@pengutronix.de,
	netdev@vger.kernel.org
Subject: [PATCH v3] appletalk: Fix Use-After-Free in atalk_ioctl
Message-ID: <20231213041056.GA519680@v4bel-B760M-AORUS-ELITE-AX>
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
v2 -> v3: Delete old comments
---
 net/appletalk/ddp.c | 9 ++++-----
 1 file changed, 4 insertions(+), 5 deletions(-)

diff --git a/net/appletalk/ddp.c b/net/appletalk/ddp.c
index 9ba04a69ec2a..a852ec093fa8 100644
--- a/net/appletalk/ddp.c
+++ b/net/appletalk/ddp.c
@@ -1775,15 +1775,14 @@ static int atalk_ioctl(struct socket *sock, unsigned int cmd, unsigned long arg)
 		break;
 	}
 	case TIOCINQ: {
-		/*
-		 * These two are safe on a single CPU system as only
-		 * user tasks fiddle here
-		 */
-		struct sk_buff *skb = skb_peek(&sk->sk_receive_queue);
+		struct sk_buff *skb;
 		long amount = 0;
 
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


