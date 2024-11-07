Return-Path: <netdev+bounces-142888-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id E8C5A9C0A8B
	for <lists+netdev@lfdr.de>; Thu,  7 Nov 2024 16:57:40 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 79ED61F218DB
	for <lists+netdev@lfdr.de>; Thu,  7 Nov 2024 15:57:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 835E0215C7D;
	Thu,  7 Nov 2024 15:57:22 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from mail-ej1-f44.google.com (mail-ej1-f44.google.com [209.85.218.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A1CEA215C73;
	Thu,  7 Nov 2024 15:57:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730995042; cv=none; b=ElxX38etUUep2ep2BAHiHmHUsstBkm12XPo3xld4St7MT0uBdQnwReX84xH4V78qh4tmkCKYesvLOHK8BTFwRNCo/GrTRs3TgUC0uOnxX11GxlGj8WnvYiHsc1h81UIYbIIRmybUUDAWnkIzPq3zjnO/o6VqpbiO/qobdNxl35E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730995042; c=relaxed/simple;
	bh=O6G3z98wXMU2YHskw+iWUsDZqJS9nuyfK8uqaz/Y0D4=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=PrM37apsp0grTUOk5TuTi2O+nJUJmqseaApV3j3MYDQ0zHwElB3Pv0Yd0YQx3KcqRd1u2sxVEbmwvpfbwGLko95Kla/lqatOSesDKx0gSPthEs11+gtADVCtxrHEPLhVxB9AP4xDMkYRJ8wvov2yfuw8RvusxuzS6El6udYWMso=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=debian.org; spf=pass smtp.mailfrom=gmail.com; arc=none smtp.client-ip=209.85.218.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=debian.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ej1-f44.google.com with SMTP id a640c23a62f3a-a99f1fd20c4so157879566b.0;
        Thu, 07 Nov 2024 07:57:20 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1730995038; x=1731599838;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=IqS89/NeNKi4uydQWItWI4zKvSn/L7HP4SPCkznjfEg=;
        b=Ir5k2JdPzAIewW5ggXfQiPw+A9VHI/kDcsWQ2l6K3uz7K1ajW4lsbPtNTc0rcDekUj
         FuDJTaOZdeQQP6yHtZOI64CwCux2IJJoEFNWasylq9D5LMH8S4cRCUNQwom7q7tbm5hM
         O6vjyVi8PGeTs8Aqo2YrAZtWqDaaHrrlnCBWCp+1DT46H+hpxtNEFCmlj3h00WN4jIzH
         zD8gm33tL9AJXRMYpxx6iJXKzJv9pIumRo0XYaIrm/EA2lKlDtc2Gmt8obZZ2Y4gXM+t
         scOwM08j75BMwZpr3Uk84qEjif93gFHApX1KcNRBLINYQFXdSLtXPN4hopOEgyYeuc8B
         cPcw==
X-Forwarded-Encrypted: i=1; AJvYcCXSwFSSk5IVhFLPGz0yBWp/N9n9dBqsvz2DdrnOcJdFvpYBoTjnClO2vDksznopXE8khDNm78qlQKalNbI=@vger.kernel.org
X-Gm-Message-State: AOJu0Yy6QmEvzA5e7lu2N63Cn7hDqVZQUmtJfk+lf077aKaXc0Bg6I1K
	2N6gLadnL1qBoPLghd+HgVC1galSnHf9bDxOj6sYI4mzjaO9auTgouUkHA==
X-Google-Smtp-Source: AGHT+IFZsXP79pPfpJZ4CyW5PRH8wvT1NzyJot5WN9TK02OPh2rk1OeSeDDBjvHvwRHy2R4aGqRH4Q==
X-Received: by 2002:a17:907:d0c:b0:a99:fb56:39cc with SMTP id a640c23a62f3a-a9eeafc8be9mr48057866b.38.1730995038081;
        Thu, 07 Nov 2024 07:57:18 -0800 (PST)
Received: from localhost (fwdproxy-lla-116.fbsv.net. [2a03:2880:30ff:74::face:b00c])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-a9ee0e0faaesm107761666b.175.2024.11.07.07.57.17
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 07 Nov 2024 07:57:17 -0800 (PST)
From: Breno Leitao <leitao@debian.org>
Date: Thu, 07 Nov 2024 07:57:07 -0800
Subject: [PATCH net-next v2 2/2] net: netpoll: flush skb pool during
 cleanup
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20241107-skb_buffers_v2-v2-2-288c6264ba4f@debian.org>
References: <20241107-skb_buffers_v2-v2-0-288c6264ba4f@debian.org>
In-Reply-To: <20241107-skb_buffers_v2-v2-0-288c6264ba4f@debian.org>
To: "David S. Miller" <davem@davemloft.net>, 
 Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>, 
 Paolo Abeni <pabeni@redhat.com>, Simon Horman <horms@kernel.org>
Cc: netdev@vger.kernel.org, linux-kernel@vger.kernel.org, 
 Breno Leitao <leitao@debian.org>
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=openpgp-sha256; l=1806; i=leitao@debian.org;
 h=from:subject:message-id; bh=O6G3z98wXMU2YHskw+iWUsDZqJS9nuyfK8uqaz/Y0D4=;
 b=owEBbQKS/ZANAwAIATWjk5/8eHdtAcsmYgBnLONZV4J75wiXQl5WtSLzAYYRB+uRtpMLkAIcC
 NUfli+1ivOJAjMEAAEIAB0WIQSshTmm6PRnAspKQ5s1o5Of/Hh3bQUCZyzjWQAKCRA1o5Of/Hh3
 bd1BD/9/rVU0n1pYI4bVOAX3Nfg3FE+c7qVkbcY3wGSSAj5h2aPYGM6NL/zBw1bjIxGiG6Z6j5e
 t/XxJMEk8Y+HqipaV0uj4yjl2aYXT0S6RHkrh69b4fotmzTtRzct6bbD1tqUGU9RVZeOaq8z4UG
 hvd3s1ypGU/94F6PkticqmdUDUdvlIE8wimHSl7FLtlavSvSt0ys0y6NFgNyRKn70ON3orbBc2V
 q50UMc7qfYIWsNll281x3f8lm0gCFLqjALrQpytx4FID+y2SRMxz85q8ePkOdKY9bGoEtPTbTa3
 s2SVSEE73DkgFgkJOzUnpeEJYpjkRLhBIZz2hwW5GD7fxskv4vMnSmrm9hL6XOELU/g1oFPJDRi
 7Wp+UM6a7fCV7XGkZAIDf+22Df29M+RyJVvFGyZrozBA8yvuxunBeLQGmRo+LVFQ4wq/ORgXu7G
 HmGTOC5/41SFxfP0qRcH3Ows4QVniQpInCdLyvQ9Ao3Oete+ShN5m+ZK+NztxDCHi07jcnFwCKI
 rhIQ0rs5KSPHBtmBBwkRNgzaSH1B6rSYa99klzGK6H4KYv4mln62Hr0TLmkPO3p6BOAWq1ftKGP
 Q1/talQ+ckI+SASkT2vI1C5nydrotzSmHx8cD0oy4OZa/ka4h4tmpxt6rc0Xps/rBIxHoONLgW4
 PGsB7Ikpn+Z1aNA==
X-Developer-Key: i=leitao@debian.org; a=openpgp;
 fpr=AC8539A6E8F46702CA4A439B35A3939FFC78776D

The netpoll subsystem maintains a pool of 32 pre-allocated SKBs per
instance, but these SKBs are not freed when the netpoll user is brought
down. This leads to memory waste as these buffers remain allocated but
unused.

Add skb_pool_flush() to properly clean up these SKBs when netconsole is
terminated, improving memory efficiency.

Signed-off-by: Breno Leitao <leitao@debian.org>
---
 net/core/netpoll.c | 22 +++++++++++++++++++++-
 1 file changed, 21 insertions(+), 1 deletion(-)

diff --git a/net/core/netpoll.c b/net/core/netpoll.c
index 719c9aae845fbeb6f5b53a2bef675d3cb8cd44a7..498cc38073a3dc9f829f74f254bc70b26ef3856c 100644
--- a/net/core/netpoll.c
+++ b/net/core/netpoll.c
@@ -531,6 +531,22 @@ static int netpoll_parse_ip_addr(const char *str, union inet_addr *addr)
 	return -1;
 }
 
+static void skb_pool_flush(struct netpoll *np)
+{
+	struct sk_buff_head *skb_pool;
+	struct sk_buff *skb;
+	unsigned long flags;
+
+	skb_pool = &np->skb_pool;
+
+	spin_lock_irqsave(&skb_pool->lock, flags);
+	while (skb_pool->qlen > 0) {
+		skb = __skb_dequeue(skb_pool);
+		kfree_skb(skb);
+	}
+	spin_unlock_irqrestore(&skb_pool->lock, flags);
+}
+
 int netpoll_parse_options(struct netpoll *np, char *opt)
 {
 	char *cur=opt, *delim;
@@ -779,10 +795,12 @@ int netpoll_setup(struct netpoll *np)
 
 	err = __netpoll_setup(np, ndev);
 	if (err)
-		goto put;
+		goto flush;
 	rtnl_unlock();
 	return 0;
 
+flush:
+	skb_pool_flush(np);
 put:
 	DEBUG_NET_WARN_ON_ONCE(np->dev);
 	if (ip_overwritten)
@@ -830,6 +848,8 @@ void __netpoll_cleanup(struct netpoll *np)
 		call_rcu(&npinfo->rcu, rcu_cleanup_netpoll_info);
 	} else
 		RCU_INIT_POINTER(np->dev->npinfo, NULL);
+
+	skb_pool_flush(np);
 }
 EXPORT_SYMBOL_GPL(__netpoll_cleanup);
 

-- 
2.43.5


