Return-Path: <netdev+bounces-219206-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 3185FB40731
	for <lists+netdev@lfdr.de>; Tue,  2 Sep 2025 16:41:55 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 716D1188A3FE
	for <lists+netdev@lfdr.de>; Tue,  2 Sep 2025 14:40:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1CECB33CE82;
	Tue,  2 Sep 2025 14:36:58 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from mail-ej1-f54.google.com (mail-ej1-f54.google.com [209.85.218.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E046C3376AE;
	Tue,  2 Sep 2025 14:36:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756823818; cv=none; b=p3Vclmn8vBosBmCzsGhi75nkHrJVY8siz1uIk2fSBH7gN5XiJPJZTY/FqYEf8nI6kwjVFIAlUvF7ozA8xK+ZNibHrhHBqqPKqu49sb5oN4fmrMGGqdTOB6e784lD3TutJSSqocLIpJtsT1JTjEHbneQUseR/Dlw09oZ+QfPaUHo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756823818; c=relaxed/simple;
	bh=QOwKb2hEwQaGFHvUWM1aHkkgzXtur1DMIlEfQlknmM4=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=Hgembdo3ev0j9zSr37teMutI5w/oHWQQ1UkqgwVb6aei1068sS4O4EcPkg4zJEXVHq7BtGlkvjQaqe+IxiiQwIeDdBncfvKf88nBY4W4iUbltWvmtmV4TgRF1m6PN7AP/AgakIxrMCKCC11M3decoQxCVRI8BThFq+uyg1xLd2k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=debian.org; spf=pass smtp.mailfrom=gmail.com; arc=none smtp.client-ip=209.85.218.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=debian.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ej1-f54.google.com with SMTP id a640c23a62f3a-b02c719a117so338625666b.1;
        Tue, 02 Sep 2025 07:36:55 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1756823814; x=1757428614;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=sGgQwclxV+InBl48sbLkPeBpWw53bOiCuvt5WtGZiTs=;
        b=P8OVWSxee+HHjK5Rj/QB8Qgh83GS2KHFhuwLaI1lrCI/5I1766WAno/34XrtoP1KDK
         bG0CBTOuzx5Z8ld+KzY6I5q8fUNS9HdC5B1SoTIhcjeEV8XOj60ptCzJFrR4K+bCrOw2
         Ujo/9bdvZeLOwZNXRZWwrEVVwGCDxogAlTMyXBZbXlfS+JjGUh5SZqqjCz9WyZy3fGLa
         HnskuyCKuxAPyfkc44RlqWftR6n4b3hVn4bDlPSFQcQtAjugk5xFCVX3zpwFvANqlgEW
         hPWMinuNrrsZARs4WjCocpEjT2l7P3TMaLHo0xHclobJmLG2noXIl6Aku8y9dmNpd803
         MbEQ==
X-Forwarded-Encrypted: i=1; AJvYcCWDUmQ3HDbVxwbsHQJJscI4yJ0h70Ph8O/Ba6NxFztzBdjRuEDD/7yzi8T8bIchQ0nQ+MhgATjAEk/62+0=@vger.kernel.org
X-Gm-Message-State: AOJu0YwEy5+B3/o4vVaR9rhXPeg06x+BBE6Klo288AsNtxbDVt42IDPi
	Vbr+BTNBi2uqZfVrBiyOxoz8GlftboqU8SUQJm477fkhaWAh96EvReIv
X-Gm-Gg: ASbGncucwaAy9YwkPhLZqmSg1rrfQ+dE2zKnv6cWI2pBROkPUBYZ4xgUmPHor0lNTFv
	4cAcid1jkTu3/r9PxTsowyOQHbm0nXbV7/trrd9Ru21bNGP2VfToECKWHYBdY6+tgjDVnXPyGQh
	MWUlwidswTtQR6kH+SfE/Xwvy++RMHHTeerBPIdyKdbb9SAZsI0dquANShyg0LZMQhi05zspMpU
	wq9qQK8kfjD8QZpA5UqcgRO0Y+0epSTY0qaAN6hpo9mq1XdYa0rADyqnuuGAst6se0W0OmsTyBw
	LA8/O+xKIJjAG+1qMXn2Tfh7UafJc8GK2CI0eFMSLXtAqgxOJpMgum6YJqYXCOJE5MF+cTvdBhP
	okVpuNcwsF2O85GIoLztosg==
X-Google-Smtp-Source: AGHT+IEpSTMgUVxh+9BmW5H958NG8p75QgWGA7ru5f+izVOhd1AyXRzufdrpFBjNB8HWq480f8/7fg==
X-Received: by 2002:a17:906:f588:b0:b04:3268:a6c8 with SMTP id a640c23a62f3a-b043268b4a0mr704297466b.43.1756823813778;
        Tue, 02 Sep 2025 07:36:53 -0700 (PDT)
Received: from localhost ([2a03:2880:30ff:1::])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-b04129eccbfsm727728366b.7.2025.09.02.07.36.53
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 02 Sep 2025 07:36:53 -0700 (PDT)
From: Breno Leitao <leitao@debian.org>
Date: Tue, 02 Sep 2025 07:36:29 -0700
Subject: [PATCH 7/7] netpoll: Flush skb_pool as part of netconsole cleanup
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250902-netpoll_untangle_v3-v1-7-51a03d6411be@debian.org>
References: <20250902-netpoll_untangle_v3-v1-0-51a03d6411be@debian.org>
In-Reply-To: <20250902-netpoll_untangle_v3-v1-0-51a03d6411be@debian.org>
To: Andrew Lunn <andrew+netdev@lunn.ch>, 
 "David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, 
 Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, 
 Simon Horman <horms@kernel.org>, 
 Sebastian Andrzej Siewior <bigeasy@linutronix.de>, 
 Clark Williams <clrkwllms@kernel.org>, Steven Rostedt <rostedt@goodmis.org>
Cc: netdev@vger.kernel.org, linux-kernel@vger.kernel.org, 
 linux-rt-devel@lists.linux.dev, kernel-team@meta.com, efault@gmx.de, 
 calvin@wbinvd.org, Breno Leitao <leitao@debian.org>
X-Mailer: b4 0.15-dev-dd21f
X-Developer-Signature: v=1; a=openpgp-sha256; l=2533; i=leitao@debian.org;
 h=from:subject:message-id; bh=QOwKb2hEwQaGFHvUWM1aHkkgzXtur1DMIlEfQlknmM4=;
 b=owEBbQKS/ZANAwAIATWjk5/8eHdtAcsmYgBotwD5LX2SXM4Un8klcyCjqO4sv2Lht3xKRNhV5
 vbufV5MTXSJAjMEAAEIAB0WIQSshTmm6PRnAspKQ5s1o5Of/Hh3bQUCaLcA+QAKCRA1o5Of/Hh3
 bTyGD/9YXblp9JM07zJx/HWzzAhbrtLXUMe4oIu02xOZ18sFDnDIANmRrJWl2rg72H6wIoRxt8Z
 aUg81x1PhyCTRZ709Mkqe5d5S+ewu1Bi/qie4INs6FSvFuIexD1pNG2FasJ1xmn7kEOUnwVO0kZ
 VTGrX+HbqwmqRAfDQRDOsX9ecyP5kVVfXQ2Xe7jcA6dddCgaSTIzND3VlTQbpegC/YsFJI4wAhT
 WAyn3w9Y+e/4CygORus/Q+QZMVrqI+QnQOK+8cWYDkhSisjwynUF/k9Wa7P10kz32uw09dCva6e
 m0WXbFDId/wE3hTMNcuemwGtJdtTQmrnRdxa9rSnJOC8qqd/gN8HiifT+Gtsx8e675V5bd/yl7W
 2L7jGynwnfzQLQ2HIQi2DnauKpUfkW/YuAusTa01zhO/EtpdLgFEomxgTg/mLWihKNJZ97EQTBG
 FfXovDkqTM6FnUQumAR1Nj/A/8DM1wheKEQLRTGuJF6y0pKB93lZfL8gZ12MxSELb+tMJxSXDNN
 eWYs1Ab9DlDaOu9uedefYkyk/43CbAThJHlXfFNljNppV5dY38cnsDNYrV9dYz5CaxluTx/HnWR
 rHWE2mxf2heynoVGnIQb/clg49busTnUx2K2h2GMlj7MJTpsGYNGMLdd88PZhnilv76VIulRjiy
 jw3Ggs8CR5rb40w==
X-Developer-Key: i=leitao@debian.org; a=openpgp;
 fpr=AC8539A6E8F46702CA4A439B35A3939FFC78776D

Transfer the skb_pool_flush() function from netpoll to netconsole, and
call it within netpoll_cleanup() to ensure skb pool resources are
properly released once the device is down.

The invocation of skb_pool_flush() was removed from netpoll_setup(), as
the pool is now only managed after successful allocation.

This complete the move of skb pool management from netpoll to
netconsole.

Signed-off-by: Breno Leitao <leitao@debian.org>
---
 drivers/net/netconsole.c | 10 ++++++++++
 net/core/netpoll.c       | 15 +--------------
 2 files changed, 11 insertions(+), 14 deletions(-)

diff --git a/drivers/net/netconsole.c b/drivers/net/netconsole.c
index bf7bab7a9c2f0..b9bfb78560b3c 100644
--- a/drivers/net/netconsole.c
+++ b/drivers/net/netconsole.c
@@ -300,12 +300,22 @@ static struct netconsole_target *alloc_and_init(void)
 	return nt;
 }
 
+static void skb_pool_flush(struct netpoll *np)
+{
+	struct sk_buff_head *skb_pool;
+
+	cancel_work_sync(&np->refill_wq);
+	skb_pool = &np->skb_pool;
+	skb_queue_purge_reason(skb_pool, SKB_CONSUMED);
+}
+
 static void netpoll_cleanup(struct netpoll *np)
 {
 	rtnl_lock();
 	if (!np->dev)
 		goto out;
 	do_netpoll_cleanup(np);
+	skb_pool_flush(np);
 out:
 	rtnl_unlock();
 }
diff --git a/net/core/netpoll.c b/net/core/netpoll.c
index 5aa83c9c09e05..c0eeeb9ac3daf 100644
--- a/net/core/netpoll.c
+++ b/net/core/netpoll.c
@@ -326,15 +326,6 @@ netdev_tx_t netpoll_send_skb(struct netpoll *np, struct sk_buff *skb)
 }
 EXPORT_SYMBOL(netpoll_send_skb);
 
-static void skb_pool_flush(struct netpoll *np)
-{
-	struct sk_buff_head *skb_pool;
-
-	cancel_work_sync(&np->refill_wq);
-	skb_pool = &np->skb_pool;
-	skb_queue_purge_reason(skb_pool, SKB_CONSUMED);
-}
-
 int __netpoll_setup(struct netpoll *np, struct net_device *ndev)
 {
 	struct netpoll_info *npinfo;
@@ -547,7 +538,7 @@ int netpoll_setup(struct netpoll *np)
 
 	err = __netpoll_setup(np, ndev);
 	if (err)
-		goto flush;
+		goto put;
 	rtnl_unlock();
 
 	/* Make sure all NAPI polls which started before dev->npinfo
@@ -558,8 +549,6 @@ int netpoll_setup(struct netpoll *np)
 
 	return 0;
 
-flush:
-	skb_pool_flush(np);
 put:
 	DEBUG_NET_WARN_ON_ONCE(np->dev);
 	if (ip_overwritten)
@@ -607,8 +596,6 @@ static void __netpoll_cleanup(struct netpoll *np)
 		call_rcu(&npinfo->rcu, rcu_cleanup_netpoll_info);
 	} else
 		RCU_INIT_POINTER(np->dev->npinfo, NULL);
-
-	skb_pool_flush(np);
 }
 
 void __netpoll_free(struct netpoll *np)

-- 
2.47.3


