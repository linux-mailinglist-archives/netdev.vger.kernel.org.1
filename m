Return-Path: <netdev+bounces-55538-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 1214380B373
	for <lists+netdev@lfdr.de>; Sat,  9 Dec 2023 10:42:23 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 91FDD280FE4
	for <lists+netdev@lfdr.de>; Sat,  9 Dec 2023 09:42:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 968E310A2E;
	Sat,  9 Dec 2023 09:42:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=theori.io header.i=@theori.io header.b="M5gy7yJZ"
X-Original-To: netdev@vger.kernel.org
Received: from mail-io1-xd2a.google.com (mail-io1-xd2a.google.com [IPv6:2607:f8b0:4864:20::d2a])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D18BC10C9
	for <netdev@vger.kernel.org>; Sat,  9 Dec 2023 01:42:14 -0800 (PST)
Received: by mail-io1-xd2a.google.com with SMTP id ca18e2360f4ac-7b6f4330598so104290639f.1
        for <netdev@vger.kernel.org>; Sat, 09 Dec 2023 01:42:14 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=theori.io; s=google; t=1702114934; x=1702719734; darn=vger.kernel.org;
        h=content-disposition:mime-version:message-id:subject:cc:to:from:date
         :from:to:cc:subject:date:message-id:reply-to;
        bh=BV1cCWvSz4/n1ZZs101uQSRQBfLiBIMXTgnA7ozCgYA=;
        b=M5gy7yJZnjD42G80biwWWeaegMaZcOA49AcJxR2hiQ7QVjC3KO6hJm6Ul5N38lVJIu
         eijGg4yjifFjierHVleeBbsMyNX1H+Z8um/nrJZOH1BLrqbl6a32icAPhUtCimj3szkC
         3GCiVI7C1Ga23Vyq662HkpIdpRNtkb7kn5E2E=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1702114934; x=1702719734;
        h=content-disposition:mime-version:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=BV1cCWvSz4/n1ZZs101uQSRQBfLiBIMXTgnA7ozCgYA=;
        b=dY3p+WoSDkAQDYtQrNNVIDEJCQzCa9ncOSb6ykc5zd3UPCJFWO+8Jp18H3ctGS8+0j
         JuhQOTfhZT8ig2NwF6VbTtHX/WWTOeztsnZoDMEjwdPQe6k4pOdDgVY1tsYhQ4jFY8OW
         WeGK191DoI/Cx8oE+2T5h1uWrHREkuktTy0bBICut83m9TzgEBK5wkciyUFog04kuFq/
         a+GTvS1SFqzt4dgYBG2m4lsxD4tvLbSCjA1zV7kUCDleck/a9fj1w9wMEWssCOD+/OXF
         9DElD1ZEjFyle+FoHhzATYnAOIZK/D44g00/qzjhjFcRHUHGhlz9OzULfNl/l+zJQAQB
         82Mg==
X-Gm-Message-State: AOJu0YxTEGUdmSx/d6NPS4Yq4GWni1KW6etNGNrHKvsaXrB0xdjpNPIV
	CUn/dpaBsjnqZBzi4jDxC1Xl6w==
X-Google-Smtp-Source: AGHT+IH2jc3/Ag56VPJlWyox+hBrfzllP9ddybA5Ks9z2OOTeKxDms7AsmVvW/5Q9auhl/APpSBIRA==
X-Received: by 2002:a05:6602:1a97:b0:7b6:f236:658f with SMTP id bn23-20020a0566021a9700b007b6f236658fmr1852667iob.12.1702114934103;
        Sat, 09 Dec 2023 01:42:14 -0800 (PST)
Received: from v4bel-B760M-AORUS-ELITE-AX ([211.219.71.65])
        by smtp.gmail.com with ESMTPSA id p12-20020a170902e74c00b001d0b32ec81esm3026605plf.79.2023.12.09.01.42.11
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 09 Dec 2023 01:42:13 -0800 (PST)
Date: Sat, 9 Dec 2023 04:42:10 -0500
From: Hyunwoo Kim <v4bel@theori.io>
To: davem@davemloft.net, kuba@kernel.org, edumazet@google.com
Cc: v4bel@theori.io, imv4bel@gmail.com, pabeni@redhat.com,
	netdev@vger.kernel.org
Subject: [PATCH net v3] atm: Fix Use-After-Free in do_vcc_ioctl
Message-ID: <20231209094210.GA403126@v4bel-B760M-AORUS-ELITE-AX>
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
v2 -> v3: Change to 'int amount'
---
 net/atm/ioctl.c | 7 +++++--
 1 file changed, 5 insertions(+), 2 deletions(-)

diff --git a/net/atm/ioctl.c b/net/atm/ioctl.c
index 838ebf0cabbf..f81f8d56f5c0 100644
--- a/net/atm/ioctl.c
+++ b/net/atm/ioctl.c
@@ -73,14 +73,17 @@ static int do_vcc_ioctl(struct socket *sock, unsigned int cmd,
 	case SIOCINQ:
 	{
 		struct sk_buff *skb;
+		int amount;
 
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


