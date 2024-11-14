Return-Path: <netdev+bounces-144838-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id B81AE9C8907
	for <lists+netdev@lfdr.de>; Thu, 14 Nov 2024 12:33:54 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 7BFE0B2FC28
	for <lists+netdev@lfdr.de>; Thu, 14 Nov 2024 11:01:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EE08D1F8F0A;
	Thu, 14 Nov 2024 11:00:37 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from mail-ej1-f53.google.com (mail-ej1-f53.google.com [209.85.218.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 342141F8937;
	Thu, 14 Nov 2024 11:00:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731582037; cv=none; b=gUAh94OKo2b3pi0AbzkczosoGHJtyefYXpYWs+esqtled1x/FdPbyRu2DewzliS0pfk2DQu7vn7dBb33f/v1JRAs5eGUpgAVPgNBpvhGcMWzvrhMmvAwXtTqNajYq6fvJmZKDlNzmRcOWRhcIlDB9jaHBlkCl5Tk0e5XrPFC0NQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731582037; c=relaxed/simple;
	bh=CcG0jqnBBTmp6RbT3RFFybDyVcLS/vaHZeyk4jmq+Cs=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=ZIJFT++R7f8rwWKCU69x0SQ1Hr/sRtADRS1JzEWjx6QuBCs67mGRa0mTs42nQKwzcvXjraAp229Wy1zJNa6R4NUrxZ3ALHNbDw8g1JN+kCGhhnDEVEJqBXLpMbDYkn+0C76ecI/e3tw/tg1QCC2Ad1tqsCeyUN3yIoSSi91whF4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=debian.org; spf=pass smtp.mailfrom=gmail.com; arc=none smtp.client-ip=209.85.218.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=debian.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ej1-f53.google.com with SMTP id a640c23a62f3a-a9a4031f69fso77695066b.0;
        Thu, 14 Nov 2024 03:00:35 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1731582034; x=1732186834;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=it2C4C5wvQAPt4uHICHkREUf2UGdJNXOZRzjqKmIdic=;
        b=EmkOb2fyOMxI16gH9M2iWUDAkJndRdWrljZHmlZ85nmDOrxbRy8FZoJGYTM+P2Wj57
         6qvkr9lkQM7IXOdvp5BpXg/iaqEXd5Q9VW5j+6ZGppuK96brWUEgW/CT06fuEbPd1fiJ
         /rIFTF4vNbD3pfSeO5+a2sH/xx6mmFmOhrbwixKeDkiAhYOwPaeouMgsbMCC/NFPoWYE
         iiqydktW9iHQN2YYTRkW1B9CG4syapmZ2eQUUFd6znoGR8xbp8gJxlizNmIFQOBuToGs
         fnPDNXKlPdQFPOO3x8CkNAi0w01R2MowtzNpx+5ObowdOQhVw6rSYXUrBH9mFOrPSIvb
         ZEXw==
X-Forwarded-Encrypted: i=1; AJvYcCU3/tvnfJIVxv+vPMM9wLVjha+fSUhpRF2JACeGfWBnS0Tr73eEVB7jU/flsjBXury3ya2ZboJw+JiJAuk=@vger.kernel.org
X-Gm-Message-State: AOJu0YzAusC650CdCEytaU89YY/bM7etPriLK3Nnjvk2tW69v14n67+g
	dY2MjUuqR03unYOo3EM+DX9hGFLxSscnYZOG0ADtmz/qIUgRamQJ
X-Google-Smtp-Source: AGHT+IECDgFGPDccwqyT8QH8ZQNFUck6UICD6mFmCZCTDQXvteFqZoqCcgoaajup3soceL0oQ8/ffA==
X-Received: by 2002:a17:906:da85:b0:a99:f56e:ce40 with SMTP id a640c23a62f3a-a9ef0021723mr2398084766b.47.1731582033982;
        Thu, 14 Nov 2024 03:00:33 -0800 (PST)
Received: from localhost (fwdproxy-lla-007.fbsv.net. [2a03:2880:30ff:7::face:b00c])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-aa20e08617esm50003766b.182.2024.11.14.03.00.33
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 14 Nov 2024 03:00:33 -0800 (PST)
From: Breno Leitao <leitao@debian.org>
Date: Thu, 14 Nov 2024 03:00:12 -0800
Subject: [PATCH net-next v3 2/2] net: netpoll: flush skb pool during
 cleanup
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20241114-skb_buffers_v2-v3-2-9be9f52a8b69@debian.org>
References: <20241114-skb_buffers_v2-v3-0-9be9f52a8b69@debian.org>
In-Reply-To: <20241114-skb_buffers_v2-v3-0-9be9f52a8b69@debian.org>
To: "David S. Miller" <davem@davemloft.net>, 
 Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>, 
 Paolo Abeni <pabeni@redhat.com>, Simon Horman <horms@kernel.org>
Cc: netdev@vger.kernel.org, linux-kernel@vger.kernel.org, 
 Breno Leitao <leitao@debian.org>, max@kutsevol.com, davej@codemonkey.org.uk, 
 vlad.wing@gmail.com
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=openpgp-sha256; l=1609; i=leitao@debian.org;
 h=from:subject:message-id; bh=CcG0jqnBBTmp6RbT3RFFybDyVcLS/vaHZeyk4jmq+Cs=;
 b=owEBbQKS/ZANAwAIATWjk5/8eHdtAcsmYgBnNdhMAIeFZEObOr+/04M/hYeWOnXWFCd9Fw27M
 9NryO8Y6WKJAjMEAAEIAB0WIQSshTmm6PRnAspKQ5s1o5Of/Hh3bQUCZzXYTAAKCRA1o5Of/Hh3
 bSH0D/9JIsJfmcJNz8WmCGRtzR0Yl77PDOE7wrcHA/4W70kEb5CdTAN6Hocr36XDykat85iUSvF
 a/3Mc0B2qnjHq403WfaUbLYXHEMYBOXtmj6wR78D1T2fiKxT1HNzp12Q0Qi5FR/KDhUSSb85j8y
 kQY7AaF27FgEGNdBodYKb2PPVH0grTIjAGxtE2M1oycFI+mLyi8i3AHZLYXnLMTPyHdnd2kR/TR
 BJgbyoOCy8EZh51D+cMp4ULGJrPWveP4lN32QCQRSRtsJ4U4v6fZG2bK1g7YnKVCbfHitoQXlHx
 wGZdZFPbDHs+Flcy+gFZjCqN+t7EvEaCREdMUU7AhzY+1pUBKSe3yLztfnmp2XSJu/e6nyS0Rtm
 vx0aZsUyhooW3W0GbwNAwLjuMoTuVccy5IHNWPluAVx+bl5BBnSJnZOvBpJYVS01JU2Ivt2q2kl
 pDUnynvi7LqxqP14tDi1gXyAVYd916k0SobKMUBjvmBg2qUYFfSdfJdsghTLSUDGO4jJnJGq9MG
 7XgXE7tzPZsPz7ufX3NOM3McFDZzA2gAyb1Nk5gVPgVRlyXf++StwBuvjnru6AhZoRjetv4DRaD
 61tp2Kzzvyt/xrmkl9t7wGoTORR/C5kNIYMJIPIFgK09QGzaUw2s5traGJeMrdfgNUAh2psbfO8
 4ekpO1wSOAeiYSw==
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
 net/core/netpoll.c | 14 +++++++++++++-
 1 file changed, 13 insertions(+), 1 deletion(-)

diff --git a/net/core/netpoll.c b/net/core/netpoll.c
index 719c9aae845fbeb6f5b53a2bef675d3cb8cd44a7..00e1e4a329022ddcef32d72f1828acaf58cc94fa 100644
--- a/net/core/netpoll.c
+++ b/net/core/netpoll.c
@@ -531,6 +531,14 @@ static int netpoll_parse_ip_addr(const char *str, union inet_addr *addr)
 	return -1;
 }
 
+static void skb_pool_flush(struct netpoll *np)
+{
+	struct sk_buff_head *skb_pool;
+
+	skb_pool = &np->skb_pool;
+	skb_queue_purge_reason(skb_pool, SKB_CONSUMED);
+}
+
 int netpoll_parse_options(struct netpoll *np, char *opt)
 {
 	char *cur=opt, *delim;
@@ -779,10 +787,12 @@ int netpoll_setup(struct netpoll *np)
 
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
@@ -830,6 +840,8 @@ void __netpoll_cleanup(struct netpoll *np)
 		call_rcu(&npinfo->rcu, rcu_cleanup_netpoll_info);
 	} else
 		RCU_INIT_POINTER(np->dev->npinfo, NULL);
+
+	skb_pool_flush(np);
 }
 EXPORT_SYMBOL_GPL(__netpoll_cleanup);
 

-- 
2.43.5


