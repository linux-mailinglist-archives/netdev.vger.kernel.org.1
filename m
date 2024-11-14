Return-Path: <netdev+bounces-144837-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 9B2C49C88D8
	for <lists+netdev@lfdr.de>; Thu, 14 Nov 2024 12:26:27 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 1D434B2F0B3
	for <lists+netdev@lfdr.de>; Thu, 14 Nov 2024 11:01:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 97E5D1F8EE4;
	Thu, 14 Nov 2024 11:00:37 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from mail-ej1-f50.google.com (mail-ej1-f50.google.com [209.85.218.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 98BD01F891D;
	Thu, 14 Nov 2024 11:00:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731582037; cv=none; b=KkBwojobsh6oSs2FiBMcdBnwSQFCbw1PH5968s9t6PXjfVuPHJOyfIfL6nY3eDxe8TCU3x5rCzA+LJRiR2UNsy0WdpqbX8ZHoh0dPvCq4jIYqKaJupZN6u6gYHrBCtiNPLzkaim7OfGh8MXnkwe7/We99mHiyNtwgC+6YvNhSoQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731582037; c=relaxed/simple;
	bh=l/0wZIy7SkdSRdFTGTTWstgdulRmA7dbmH3XYkTeIRU=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=HUbyPNOcUsDhaaa1IBeFn9rIvW+FTq8CsPgHv2ByZ16A8Q1a/VRcLGTbEnT/+A3CuUpAhgdUWRpvDyja488okr6B/7hPjJrDvaM2aNC9V3Sf/C6J8grBmwcoaKCATGmvnBieeIfITp2sHHRBebKjQ6BoZLT9qHBq0ir95mi+tns=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=debian.org; spf=pass smtp.mailfrom=gmail.com; arc=none smtp.client-ip=209.85.218.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=debian.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ej1-f50.google.com with SMTP id a640c23a62f3a-a9e8522445dso88152066b.1;
        Thu, 14 Nov 2024 03:00:34 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1731582033; x=1732186833;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=hzst0PFb8vN+5CtSNyjHKngR6IOzkyemapq2li6Vfbs=;
        b=dK0jXtnbNdtdzu3cbfhL2/0nGU+P8l6gzOtlmvMHKXsZEMVMtqjESQGozfgIsZkRD0
         64314xJbuFP1sJUJuBtt+rGtvmt4vHplae+brArJIrrDgqSw5RnvUM9+cj3K2OHX3Lki
         PFPOg8yJiQbT2MZPkissCnOWIEK+HjH43D5or2FskwXv8lTYdA3S3a9O2C/hlQot9lq7
         7sr9+3Mm13IX804iKnhDnAR9m/XpGXfCnymM2fkgq+8lBOsfodPBJY/+41mLmX7FnVHe
         BCXPsAlde/PsJpBclQ0VrLi0pFuRGnZYIUyShX6Cfvh9bgJRJSBA8VY97hhwKFCglxP+
         vDcw==
X-Forwarded-Encrypted: i=1; AJvYcCV6E+A5BLKX/6bumZiKo7clVOfRAzB+LQ5RgTmTZSiaFytoCjpwcuuGEzD/j4GkjOi7IowPF+pTvYDUEN4=@vger.kernel.org
X-Gm-Message-State: AOJu0YzweAzRnByg5ZsvOkk9hNzWhoapB1Q4CrrCBqDhVbeGyyDNC4oF
	rIzjEn4RorPlO9rAZWjFq1a11HpAAQ73N864aliAXoNw9ACgvMe3
X-Google-Smtp-Source: AGHT+IFItmeT/lE/68W0/7IdbEgphOVzAVurCPTRee8xHFVeoeG+5VYWOHOMU7NYrKQOR+KNwweyeg==
X-Received: by 2002:a17:907:7b9a:b0:a99:8a0e:8710 with SMTP id a640c23a62f3a-aa20ccfe85emr156110266b.14.1731582032430;
        Thu, 14 Nov 2024 03:00:32 -0800 (PST)
Received: from localhost (fwdproxy-lla-115.fbsv.net. [2a03:2880:30ff:73::face:b00c])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-aa20df27068sm50320566b.8.2024.11.14.03.00.31
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 14 Nov 2024 03:00:31 -0800 (PST)
From: Breno Leitao <leitao@debian.org>
Date: Thu, 14 Nov 2024 03:00:11 -0800
Subject: [PATCH net-next v3 1/2] net: netpoll: Individualize the skb pool
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20241114-skb_buffers_v2-v3-1-9be9f52a8b69@debian.org>
References: <20241114-skb_buffers_v2-v3-0-9be9f52a8b69@debian.org>
In-Reply-To: <20241114-skb_buffers_v2-v3-0-9be9f52a8b69@debian.org>
To: "David S. Miller" <davem@davemloft.net>, 
 Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>, 
 Paolo Abeni <pabeni@redhat.com>, Simon Horman <horms@kernel.org>
Cc: netdev@vger.kernel.org, linux-kernel@vger.kernel.org, 
 Breno Leitao <leitao@debian.org>, max@kutsevol.com, davej@codemonkey.org.uk, 
 vlad.wing@gmail.com
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=openpgp-sha256; l=3542; i=leitao@debian.org;
 h=from:subject:message-id; bh=l/0wZIy7SkdSRdFTGTTWstgdulRmA7dbmH3XYkTeIRU=;
 b=owEBbQKS/ZANAwAIATWjk5/8eHdtAcsmYgBnNdhMv/zRrmh8VxPpK1kdKMEXaBKU/yz4qcHQM
 rfB0AgaWCqJAjMEAAEIAB0WIQSshTmm6PRnAspKQ5s1o5Of/Hh3bQUCZzXYTAAKCRA1o5Of/Hh3
 bW0oD/4jEb9w+pg48tMqtICx3DOCccDr07IjhTstMaAtkLQjvoKPtGFhUFHEEV4ttCwlkBXrXur
 2W3zRIpO2rd7QAD8SIiLcyCd3PLnDC+OGTLwe8tsRRCwwKPGA55Mxu8s63RePliTr5WO1yrB9aI
 bpfEVJ8rvF0JSZNrylgpNHfAUm6XmY5F+HyQ3+uyhhOoRQAHTjl2nt3QJPt0tkXv5FRqoUpnpTq
 ZImS1/eYiPhxfH1o0qDal4bW1XYTc+Y1ba9T+txPrHm7IHt6EFQ4N9jQO9elxWpMErNW7qX6zkr
 +nOMOnx3AbuJO46ptFE5ziNsfnJqhrIkcs1RstALCSH1GNj5s+k6sVbdwmTxWCjb0IX2CmYQzD0
 HCE7b3KFhb7EGIPXgMqc//0GPkj1Rs9UT+EgJCG8paXxL7lC9XyO+CRioxh9MaaQe7eCxSEDEE4
 Gc9yR2R3ujXZ22wex+rQmr3AAxyAuEltDI3wZJR+o9IvWeTxyILW4VXaqEQY4i97/Gc90rK6Bbm
 n4Z23zkIbOyvPl5Nv+M9tTggJ+hMUfLiFxhZ3HCLRkOzqg41szGAAr64w1Ttw0Zxm6E9ECHtx34
 ruEOzE/b7huBnoxwISLwx6L9oBhIIQ3/z/0du0IShp4gX8wsYyWIiqtAT0pAZZS0bbrJrjJs9Eo
 1PEvgcPs0G8167g==
X-Developer-Key: i=leitao@debian.org; a=openpgp;
 fpr=AC8539A6E8F46702CA4A439B35A3939FFC78776D

The current implementation of the netpoll system uses a global skb
pool, which can lead to inefficient memory usage and
waste when targets are disabled or no longer in use.

This can result in a significant amount of memory being unnecessarily
allocated and retained, potentially causing performance issues and
limiting the availability of resources for other system components.

Modify the netpoll system to assign a skb pool to each target instead of
using a global one.

This approach allows for more fine-grained control over memory
allocation and deallocation, ensuring that resources are only allocated
and retained as needed.

Signed-off-by: Breno Leitao <leitao@debian.org>
---
 include/linux/netpoll.h |  1 +
 net/core/netpoll.c      | 31 +++++++++++++------------------
 2 files changed, 14 insertions(+), 18 deletions(-)

diff --git a/include/linux/netpoll.h b/include/linux/netpoll.h
index cd4e28db0cbd77572a579aff2067b5864d1a904a..77635b885c18b7d405642c2e7f39f5ff2c7d469d 100644
--- a/include/linux/netpoll.h
+++ b/include/linux/netpoll.h
@@ -32,6 +32,7 @@ struct netpoll {
 	bool ipv6;
 	u16 local_port, remote_port;
 	u8 remote_mac[ETH_ALEN];
+	struct sk_buff_head skb_pool;
 };
 
 struct netpoll_info {
diff --git a/net/core/netpoll.c b/net/core/netpoll.c
index 94b7f07a952fff3358cc609fb29de33ae8ae8626..719c9aae845fbeb6f5b53a2bef675d3cb8cd44a7 100644
--- a/net/core/netpoll.c
+++ b/net/core/netpoll.c
@@ -45,9 +45,6 @@
 
 #define MAX_UDP_CHUNK 1460
 #define MAX_SKBS 32
-
-static struct sk_buff_head skb_pool;
-
 #define USEC_PER_POLL	50
 
 #define MAX_SKB_SIZE							\
@@ -234,20 +231,23 @@ void netpoll_poll_enable(struct net_device *dev)
 		up(&ni->dev_lock);
 }
 
-static void refill_skbs(void)
+static void refill_skbs(struct netpoll *np)
 {
+	struct sk_buff_head *skb_pool;
 	struct sk_buff *skb;
 	unsigned long flags;
 
-	spin_lock_irqsave(&skb_pool.lock, flags);
-	while (skb_pool.qlen < MAX_SKBS) {
+	skb_pool = &np->skb_pool;
+
+	spin_lock_irqsave(&skb_pool->lock, flags);
+	while (skb_pool->qlen < MAX_SKBS) {
 		skb = alloc_skb(MAX_SKB_SIZE, GFP_ATOMIC);
 		if (!skb)
 			break;
 
-		__skb_queue_tail(&skb_pool, skb);
+		__skb_queue_tail(skb_pool, skb);
 	}
-	spin_unlock_irqrestore(&skb_pool.lock, flags);
+	spin_unlock_irqrestore(&skb_pool->lock, flags);
 }
 
 static void zap_completion_queue(void)
@@ -284,12 +284,12 @@ static struct sk_buff *find_skb(struct netpoll *np, int len, int reserve)
 	struct sk_buff *skb;
 
 	zap_completion_queue();
-	refill_skbs();
+	refill_skbs(np);
 repeat:
 
 	skb = alloc_skb(len, GFP_ATOMIC);
 	if (!skb)
-		skb = skb_dequeue(&skb_pool);
+		skb = skb_dequeue(&np->skb_pool);
 
 	if (!skb) {
 		if (++count < 10) {
@@ -673,6 +673,8 @@ int netpoll_setup(struct netpoll *np)
 	struct in_device *in_dev;
 	int err;
 
+	skb_queue_head_init(&np->skb_pool);
+
 	rtnl_lock();
 	if (np->dev_name[0]) {
 		struct net *net = current->nsproxy->net_ns;
@@ -773,7 +775,7 @@ int netpoll_setup(struct netpoll *np)
 	}
 
 	/* fill up the skb queue */
-	refill_skbs();
+	refill_skbs(np);
 
 	err = __netpoll_setup(np, ndev);
 	if (err)
@@ -792,13 +794,6 @@ int netpoll_setup(struct netpoll *np)
 }
 EXPORT_SYMBOL(netpoll_setup);
 
-static int __init netpoll_init(void)
-{
-	skb_queue_head_init(&skb_pool);
-	return 0;
-}
-core_initcall(netpoll_init);
-
 static void rcu_cleanup_netpoll_info(struct rcu_head *rcu_head)
 {
 	struct netpoll_info *npinfo =

-- 
2.43.5


