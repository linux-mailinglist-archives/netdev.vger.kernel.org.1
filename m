Return-Path: <netdev+bounces-54403-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id DF597806FC1
	for <lists+netdev@lfdr.de>; Wed,  6 Dec 2023 13:31:28 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 9AC32281AFE
	for <lists+netdev@lfdr.de>; Wed,  6 Dec 2023 12:31:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 49F36364B4;
	Wed,  6 Dec 2023 12:31:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=theori.io header.i=@theori.io header.b="N/fwrp5r"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pl1-x632.google.com (mail-pl1-x632.google.com [IPv6:2607:f8b0:4864:20::632])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 74A25D4B
	for <netdev@vger.kernel.org>; Wed,  6 Dec 2023 04:31:24 -0800 (PST)
Received: by mail-pl1-x632.google.com with SMTP id d9443c01a7336-1d0a7b72203so28950435ad.2
        for <netdev@vger.kernel.org>; Wed, 06 Dec 2023 04:31:24 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=theori.io; s=google; t=1701865883; x=1702470683; darn=vger.kernel.org;
        h=content-disposition:mime-version:message-id:subject:cc:to:from:date
         :from:to:cc:subject:date:message-id:reply-to;
        bh=CzbxTM6gSAYKM35SslTxxtfO08Ng+kkdMu8cmuTugo8=;
        b=N/fwrp5r1ZhYX5xYelpFJBbXozo3UVPinfbLaDkADDJhGdweMdhrYIDK2hbwC/F+v2
         3hLADIRXuDq9re6Aol/cOIRo6eArpILjZi3KPMTvXFG4QUNHa2IdtvTyrZ7iA3kRGD4b
         RLmSweCiw20B/7j6YKOVq6HZKQ09AUAqwrcyQ=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1701865883; x=1702470683;
        h=content-disposition:mime-version:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=CzbxTM6gSAYKM35SslTxxtfO08Ng+kkdMu8cmuTugo8=;
        b=bYqdk5OB0eiTiErBHL8T68sAf5sIrYUNX8UR0sHpkc24Nr8dXEouOUizEzHH6Kqe+E
         WgiUJaCQTgRwptzPhkll1eoc8H/BPDKsbB95GpPlJzS7KdmcuijtOFtUBRt8SaNtrZNL
         jsTbtw927J94Gw0DHMFQA7/YG3EaRMemrQxFu8Ycxf3CrOlrEqR77J1YoLYsmHQbEFog
         djIe1bSmYYmC9u/NQO7ElaxJjLRNZv3R6Q8jI6TparZDPLNOuTW/nIZmHWgTyCojAyAx
         FRWze1zJ5kGyEMZHrWPutCp+cTXSpGhos0h5mW2V7HpdFyOvRz6n9f3/hOkDg61wSKqj
         UFCg==
X-Gm-Message-State: AOJu0Yzj/N88F4OedW7eXglKqnx0MLwvowumvnpsrB6Ys8ustqzGxxBG
	e8WA7WuGpEjAMMuzZLC9vizg0w==
X-Google-Smtp-Source: AGHT+IE2waFPHU+v0d4zYclK+TPk0xI2/vCBIoGZWTTxPF3Y/CmW/+UFjXDHoCkcDWjPVm/A9zzRqA==
X-Received: by 2002:a17:902:b116:b0:1d0:aa79:6ef4 with SMTP id q22-20020a170902b11600b001d0aa796ef4mr677504plr.113.1701865883303;
        Wed, 06 Dec 2023 04:31:23 -0800 (PST)
Received: from ubuntu ([211.219.71.65])
        by smtp.gmail.com with ESMTPSA id l2-20020a170902ec0200b001d05456394csm10061402pld.28.2023.12.06.04.31.20
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 06 Dec 2023 04:31:22 -0800 (PST)
Date: Wed, 6 Dec 2023 04:31:18 -0800
From: Hyunwoo Kim <v4bel@theori.io>
To: davem@davemloft.net, edumazet@google.com
Cc: v4bel@theori.io, imv4bel@gmail.com, kuba@kernel.org, pabeni@redhat.com,
	netdev@vger.kernel.org
Subject: [PATCH] atm: Fix Use-After-Free in do_vcc_ioctl
Message-ID: <20231206123118.GA15625@ubuntu>
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
 net/atm/ioctl.c | 10 +++++++---
 1 file changed, 7 insertions(+), 3 deletions(-)

diff --git a/net/atm/ioctl.c b/net/atm/ioctl.c
index 838ebf0cabbf..62abe022f2bc 100644
--- a/net/atm/ioctl.c
+++ b/net/atm/ioctl.c
@@ -73,14 +73,18 @@ static int do_vcc_ioctl(struct socket *sock, unsigned int cmd,
 	case SIOCINQ:
 	{
 		struct sk_buff *skb;
+		long amount = 0;
 
 		if (sock->state != SS_CONNECTED) {
 			error = -EINVAL;
 			goto done;
 		}
-		skb = skb_peek(&sk->sk_receive_queue);
-		error = put_user(skb ? skb->len : 0,
-				 (int __user *)argp) ? -EFAULT : 0;
+
+		spin_lock_irq(&sk->sk_receive_queue.lock);
+		if ((skb = skb_peek(&sk->sk_receive_queue)) != NULL)
+			amount = skb->len;
+		spin_unlock_irq(&sk->sk_receive_queue.lock);
+		error = put_user(amount, (int __user *)argp) ? -EFAULT : 0;
 		goto done;
 	}
 	case ATM_SETSC:
-- 
2.25.1


