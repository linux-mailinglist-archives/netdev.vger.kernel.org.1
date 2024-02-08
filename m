Return-Path: <netdev+bounces-70387-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 96B6184EB33
	for <lists+netdev@lfdr.de>; Thu,  8 Feb 2024 23:07:37 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id BA1E81C21A66
	for <lists+netdev@lfdr.de>; Thu,  8 Feb 2024 22:07:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 68AA44F614;
	Thu,  8 Feb 2024 22:07:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="U2bDGooq"
X-Original-To: netdev@vger.kernel.org
Received: from mail-yw1-f173.google.com (mail-yw1-f173.google.com [209.85.128.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A6BE54F60C
	for <netdev@vger.kernel.org>; Thu,  8 Feb 2024 22:07:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707430043; cv=none; b=T0TsE1Z7K1rtacM4OuoNeqnr8g9zbIC0mwGMAaYBVtXmBLnnd8c49nGuAkWshFRDcbUveMGNm+UUX2sQveTz7itjwut2WtGmkYs6oCuuKPzNcZAevtlrMKVgQnnvGUeAk2+vK6r3fmgOY7rkWg6vTSMCPhxo6pueTaGlZCgjyIk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707430043; c=relaxed/simple;
	bh=4tSVrc3lDD9aUoYxlltfLeAwJNFQSEcmRZdoZavUtrI=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=dRnNrx1qySFk3fV1ozMkkjVT28cgQTGpZDKvAKaHwd5hVHR7zjFLoSNYCEOUVBmDzNKvmr+N/B6KGDN9zPfEBv8uHwAhuvs1QmVdsZeylKN8V/gltviqckoJ5qCOlmDqAYuXjzuF8zgja3FM0zIj+9EBM72eyOGA6z/Udjubf5k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=U2bDGooq; arc=none smtp.client-ip=209.85.128.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-yw1-f173.google.com with SMTP id 00721157ae682-604a1581cffso4161877b3.3
        for <netdev@vger.kernel.org>; Thu, 08 Feb 2024 14:07:21 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1707430040; x=1708034840; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=g8gr/KnM/VeL15b3iiujnM+2BUtml3tCCqm7xonJUZI=;
        b=U2bDGooqMo/NwnIkjSHjKqXhedmSMwyjhjhA+lb8wjQBNFIsIQj7GC491YqUh9mVt8
         7WYMZ0kBaVZkqx4Q0FwUYH8atk7t5szvVgiM0n7ucOtqIutmIFy098MTts+fILY3YDdo
         Txhs6kv2cK9nMtYLlKhMRf9m1Zij0Ltcm/7z0IsDqjzIUJZYFJTgH8CzA8n0nxbTLQKr
         /CJM1zQwUKpQKUo99WAGyqvMHNIvc2Umw8Tox74B2VvpYvjstC5djH94OQargrDfwc22
         BP4nQTSh+1s76pqC4lqwa5XbkedfiHujL4fP1AWmK0+LubtO7au9MBx3cPZ3fxAmMCBj
         COug==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1707430040; x=1708034840;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=g8gr/KnM/VeL15b3iiujnM+2BUtml3tCCqm7xonJUZI=;
        b=QEuMienkLRrAjdAXrPeSUo7Ls+7XHiuLKUwZI7WHJgrXP099uCJ1Yau6Co47HYIuXm
         vNrU5eA/04f5sRNd0DyEG04uT39bvHFx3sj/tzcrnbBykM+n5LXbditXBO+cbuMRVohV
         oCZS8nTkhPb4MOQpf5z5SA+I2Vz0zZ8hk7/1L05cW/s5rEHwGDnfrxgeJ5DjT+1gu3n2
         vnQ7fE90OMlxBa+8MubutQbbkLVJhJa8Jr91TMNhBBtmJ2rnvKwBHfDgUKLyRTSd4y9A
         tTUFx3V38FqcKRqc7HDK1gYgR9UZthK/QvSsftJ7J2iPdZMMykoLU52hl1zqJuhbI73e
         Tk2g==
X-Gm-Message-State: AOJu0YxXYvd9dBr71Qqu9yJPC3gRR9exBQaVxbgHNoD0d7wfuLP/ID+r
	+IYj0lVXN6OggQGfluV+0TAZL2uuHBRw4iL1Ye3I1EVJOn3SSx9oK+33uiHr5II=
X-Google-Smtp-Source: AGHT+IEuzCb8iOksw/WH1MloFE3Rn8ipz/0Ox25w7S5auRK4Dve+wsihBjLf9Zu0isriOzS7OMSXIA==
X-Received: by 2002:a81:918d:0:b0:5ff:5cfd:7127 with SMTP id i135-20020a81918d000000b005ff5cfd7127mr683815ywg.14.1707430040131;
        Thu, 08 Feb 2024 14:07:20 -0800 (PST)
X-Forwarded-Encrypted: i=1; AJvYcCUSpKkwuonOpXlSMLyn/fybXRwq3Vm2Jy9oAMTrpuoqOMSVt9wy1/uPqj/8xlmkMCJZh4EGjH0/RPhNt7bwGRZz8zk5Tz0mxl1d5ctho7aYvB0M73FxkD/yRzVP2KRM8u1V21gUCMNaelS66nGZP2ijxH7b9Wv2twkHeVzw797zwY8Tq7HfOxmmLvlA9yI6FF2QoToFyzzCwYOrTlJ1l3EtgedwMc66zsCMkC3ugw1js+4nSv5Z1f5u6YCRSQnxpZJo9VstClEoDSrsBctMnlI89uakNOdwk4bDNH4SyPfhxc2jaHnS9cSvVOOt/9Vm/8zY132lRExQxO5SDlewfmMDQOkiaKaECaRfxQ==
Received: from kickker.attlocal.net ([2600:1700:6cf8:1240:1c58:82ab:ea0c:f407])
        by smtp.gmail.com with ESMTPSA id m128-20020a0de386000000b006049e3167fcsm61320ywe.99.2024.02.08.14.07.18
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 08 Feb 2024 14:07:19 -0800 (PST)
From: thinker.li@gmail.com
To: netdev@vger.kernel.org,
	ast@kernel.org,
	martin.lau@linux.dev,
	kernel-team@meta.com,
	davem@davemloft.net,
	dsahern@kernel.org,
	edumazet@google.com,
	kuba@kernel.org,
	pabeni@redhat.com,
	liuhangbin@gmail.com
Cc: sinquersw@gmail.com,
	kuifeng@meta.com,
	Kui-Feng Lee <thinker.li@gmail.com>
Subject: [PATCH net-next v6 1/5] net/ipv6: set expires in rt6_add_dflt_router().
Date: Thu,  8 Feb 2024 14:06:49 -0800
Message-Id: <20240208220653.374773-2-thinker.li@gmail.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240208220653.374773-1-thinker.li@gmail.com>
References: <20240208220653.374773-1-thinker.li@gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Kui-Feng Lee <thinker.li@gmail.com>

Pass the duration of a lifetime (in seconds) to the function
rt6_add_dflt_router() so that it can properly set the expiration time.

The function ndisc_router_discovery() is the only one that calls
rt6_add_dflt_router(), and it will later set the expiration time for the
route created by rt6_add_dflt_router(). However, there is a gap of time
between calling rt6_add_dflt_router() and setting the expiration time in
ndisc_router_discovery(). During this period, there is a possibility that a
new route may be removed from the routing table. By setting the correct
expiration time in rt6_add_dflt_router(), we can prevent this from
happening. The reason for setting RTF_EXPIRES in rt6_add_dflt_router() is
to start the Garbage Collection (GC) timer, as it only activates when a
route with RTF_EXPIRES is added to a table.

Suggested-by: David Ahern <dsahern@kernel.org>
Reviewed-by: Hangbin Liu <liuhangbin@gmail.com>
Reviewed-by: David Ahern <dsahern@kernel.org>
Signed-off-by: Kui-Feng Lee <thinker.li@gmail.com>
---
 include/net/ip6_route.h | 3 ++-
 net/ipv6/ndisc.c        | 3 ++-
 net/ipv6/route.c        | 4 +++-
 3 files changed, 7 insertions(+), 3 deletions(-)

diff --git a/include/net/ip6_route.h b/include/net/ip6_route.h
index 28b065790261..52a51c69aa9d 100644
--- a/include/net/ip6_route.h
+++ b/include/net/ip6_route.h
@@ -170,7 +170,8 @@ struct fib6_info *rt6_get_dflt_router(struct net *net,
 struct fib6_info *rt6_add_dflt_router(struct net *net,
 				     const struct in6_addr *gwaddr,
 				     struct net_device *dev, unsigned int pref,
-				     u32 defrtr_usr_metric);
+				     u32 defrtr_usr_metric,
+				     int lifetime);
 
 void rt6_purge_dflt_routers(struct net *net);
 
diff --git a/net/ipv6/ndisc.c b/net/ipv6/ndisc.c
index a19999b30bc0..a68462668158 100644
--- a/net/ipv6/ndisc.c
+++ b/net/ipv6/ndisc.c
@@ -1382,7 +1382,8 @@ static enum skb_drop_reason ndisc_router_discovery(struct sk_buff *skb)
 			neigh_release(neigh);
 
 		rt = rt6_add_dflt_router(net, &ipv6_hdr(skb)->saddr,
-					 skb->dev, pref, defrtr_usr_metric);
+					 skb->dev, pref, defrtr_usr_metric,
+					 lifetime);
 		if (!rt) {
 			ND_PRINTK(0, err,
 				  "RA: %s failed to add default route\n",
diff --git a/net/ipv6/route.c b/net/ipv6/route.c
index 63b4c6056582..98abba8f15cd 100644
--- a/net/ipv6/route.c
+++ b/net/ipv6/route.c
@@ -4355,7 +4355,8 @@ struct fib6_info *rt6_add_dflt_router(struct net *net,
 				     const struct in6_addr *gwaddr,
 				     struct net_device *dev,
 				     unsigned int pref,
-				     u32 defrtr_usr_metric)
+				     u32 defrtr_usr_metric,
+				     int lifetime)
 {
 	struct fib6_config cfg = {
 		.fc_table	= l3mdev_fib_table(dev) ? : RT6_TABLE_DFLT,
@@ -4368,6 +4369,7 @@ struct fib6_info *rt6_add_dflt_router(struct net *net,
 		.fc_nlinfo.portid = 0,
 		.fc_nlinfo.nlh = NULL,
 		.fc_nlinfo.nl_net = net,
+		.fc_expires = jiffies_to_clock_t(lifetime * HZ),
 	};
 
 	cfg.fc_gateway = *gwaddr;
-- 
2.34.1


