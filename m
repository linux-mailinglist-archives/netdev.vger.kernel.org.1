Return-Path: <netdev+bounces-103348-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id AA0DE907B27
	for <lists+netdev@lfdr.de>; Thu, 13 Jun 2024 20:22:24 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 462C7B23B85
	for <lists+netdev@lfdr.de>; Thu, 13 Jun 2024 18:22:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DE90814B940;
	Thu, 13 Jun 2024 18:21:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="lUK9ZmP+"
X-Original-To: netdev@vger.kernel.org
Received: from mail-wm1-f42.google.com (mail-wm1-f42.google.com [209.85.128.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1BD5214A624
	for <netdev@vger.kernel.org>; Thu, 13 Jun 2024 18:21:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718302910; cv=none; b=S8RMP1C7AepcdMdLPSR3MMBUwsmxRDkgra8VdVfXsj6fv7X5E3uQRieSKSyRq59lxtUoQMqO6uE223hXfl6RRhpjZ+632wx4N9yKnBJifacamDflamRhS8EG5X/L5ASmx9K+xk5wCB1jrYq2QcUKuekrJw6LFsNUCm3QGO0DPEI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718302910; c=relaxed/simple;
	bh=Eg3PsnHVSYuLn+uKCQz7YExSHrr2gIhjUaFUT+0OM7g=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition; b=LmBuqBsFRZsuJupvStI1W/I7XEcE9MrRL5ebjq3KGmzqlOjiDhtCrBr+HNQM7aEyKjbGY5qHst7XWSV6R6Kv4+OU8JtJ6lTdBS/30MLfvhmdLQ0wuupv/2qr0NiZPFqskcGU2DLZhvZ1PG194gu9C4YdcGCQC8yhQlBPc+hereo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=lUK9ZmP+; arc=none smtp.client-ip=209.85.128.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-wm1-f42.google.com with SMTP id 5b1f17b1804b1-42122ac2f38so8760115e9.1
        for <netdev@vger.kernel.org>; Thu, 13 Jun 2024 11:21:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1718302907; x=1718907707; darn=vger.kernel.org;
        h=content-disposition:mime-version:message-id:subject:cc:to:from:date
         :from:to:cc:subject:date:message-id:reply-to;
        bh=QUxyMjU71ZE+fUPetZ6OJeVBxDmLzc8mtYCL3gsGt3s=;
        b=lUK9ZmP+mAfBhy+5w0FZ/fWbkMITJqtWW0NAaRfyZPeTfXL5jMAr7mYStE/wl5KrVU
         hy0a6wTwzMN+vD1BTuIx8U7aejrTiiqIFNDNkIEIugTpPXNmolkslgBoicXnEOtmI110
         uN0iBiNNX1tHzgPjJREin7VYCd2i0iEfM2BoPZKeoQb4RrtP1FW0vS88pKKzIrufyO46
         Coi6hOXVptR4SYI0eEDQ0AEJckgs57x7cYEDWe5YpQ+HpEnIOkgGzvv83XMHkh9iJvB5
         XU4AbAwdPBXHRFa526OTRiRga5uafHCkgJX4gsS90DWKDvA0Vrk01n1bUjEahNtDfVwv
         1YpQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1718302907; x=1718907707;
        h=content-disposition:mime-version:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=QUxyMjU71ZE+fUPetZ6OJeVBxDmLzc8mtYCL3gsGt3s=;
        b=OaUrC0VnjODkEb0/bzKGClMIpL9WASbRewoJD1hhiKTX5hGoCLxzjdWJ9eukZGCXMY
         kPxeLR1f1glEtY14dBV5eqlCrExmhnUj8uesgVGrU3Mozsmb05VeGFe6XgdWVUGlJ0X0
         9cFMeFnvP8vMjpelPvalKNtNO3mOasoi61zlrRAtO6KeKD6n4HXqAeX+9421JqZvpk+N
         AX5tgQ4SHL5NRcAPe+Jg0Rh219J8jWBtfM6Tka16GHt6H+7ggymTVRQd3gpKqwUycBeh
         T067HV/jTzcaQm9ZPlNFxJGBqtYV4uRt35bMUbwCUz5KwLiXfJSLl9KioSrydZgQvPZH
         tCtQ==
X-Forwarded-Encrypted: i=1; AJvYcCWzk8Zz1K8D7OBQ3zCdsu8CiQfVbW8ruTZWZSMC6hjw3peGNPGurJF0rK7HuhzUmYzaoCRubAiDPXvb2sj+y78VNbgVn7C9
X-Gm-Message-State: AOJu0Yxr0I7HKozU3nx/kZXK2KifLzRd1a2gKbWy0ripBTqMl4D5k7x/
	AapcTnDlC83835v1DCHl/wQjFusGegzQV2GYQuvLqeN+LSS70gxanqcze5tQUeo=
X-Google-Smtp-Source: AGHT+IHE8xPRTkTbm1KPshLdZzNhvmcmIrYIfPgMiJtdCnz+qehS2fJwkgES/YPzH7zgsVHVrvOTGQ==
X-Received: by 2002:a05:600c:4506:b0:421:392b:7e13 with SMTP id 5b1f17b1804b1-422b6dc80c2mr39801835e9.4.1718302907122;
        Thu, 13 Jun 2024 11:21:47 -0700 (PDT)
Received: from localhost ([102.222.70.76])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-422f641a5b4sm33163135e9.41.2024.06.13.11.21.46
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 13 Jun 2024 11:21:46 -0700 (PDT)
Date: Thu, 13 Jun 2024 21:21:42 +0300
From: Dan Carpenter <dan.carpenter@linaro.org>
To: "David S. Miller" <davem@davemloft.net>
Cc: Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>, Hyunwoo Kim <v4bel@theori.io>,
	netdev@vger.kernel.org, kernel-janitors@vger.kernel.org
Subject: [PATCH net-next] atm: clean up a put_user() calls
Message-ID: <04a018e8-7433-4f67-8ddd-9357a0114f87@moroto.mountain>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-Mailer: git-send-email haha only kidding

Unlike copy_from_user(), put_user() and get_user() return -EFAULT on
error.  Use the error code directly instead of setting it.

Signed-off-by: Dan Carpenter <dan.carpenter@linaro.org>
---
 net/atm/ioctl.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/net/atm/ioctl.c b/net/atm/ioctl.c
index f81f8d56f5c0..0f7a39aeccc8 100644
--- a/net/atm/ioctl.c
+++ b/net/atm/ioctl.c
@@ -68,7 +68,7 @@ static int do_vcc_ioctl(struct socket *sock, unsigned int cmd,
 			goto done;
 		}
 		error = put_user(sk->sk_sndbuf - sk_wmem_alloc_get(sk),
-				 (int __user *)argp) ? -EFAULT : 0;
+				 (int __user *)argp);
 		goto done;
 	case SIOCINQ:
 	{
@@ -83,7 +83,7 @@ static int do_vcc_ioctl(struct socket *sock, unsigned int cmd,
 		skb = skb_peek(&sk->sk_receive_queue);
 		amount = skb ? skb->len : 0;
 		spin_unlock_irq(&sk->sk_receive_queue.lock);
-		error = put_user(amount, (int __user *)argp) ? -EFAULT : 0;
+		error = put_user(amount, (int __user *)argp);
 		goto done;
 	}
 	case ATM_SETSC:
-- 
2.43.0


