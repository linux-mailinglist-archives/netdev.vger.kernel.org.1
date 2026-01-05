Return-Path: <netdev+bounces-246998-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id EE6A6CF357D
	for <lists+netdev@lfdr.de>; Mon, 05 Jan 2026 12:48:43 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 45A7330380FD
	for <lists+netdev@lfdr.de>; Mon,  5 Jan 2026 11:48:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 21C4D32FA34;
	Mon,  5 Jan 2026 11:48:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="e1CPeIYq"
X-Original-To: netdev@vger.kernel.org
Received: from mail-wm1-f46.google.com (mail-wm1-f46.google.com [209.85.128.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4A081333447
	for <netdev@vger.kernel.org>; Mon,  5 Jan 2026 11:48:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1767613685; cv=none; b=SwLUgBY66UUwRP8AaHIYz7Eti3Jd1Ae3h51/aTKGj1N/D2bXVUZCIi48hn/hfBmTUT8rO8Fx5+2r2/9WRkI5c9RaE08rFfz/fkCdqg9mibAduK8A3UV2AsAqpc4x+QwKdcJvBoAnf+qd595+rLKOZPIET2axnB2ApI9dXz1FDBo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1767613685; c=relaxed/simple;
	bh=9KuF5mVTCYqNpYTWSGEzNxM1NAUHaHIt1frKONRl/3c=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=MbizIGQlFoNgFTL00UcD4Ap/dK88ymFjUjxv41LgkG15Q0aRcovLoWdTYgzb3iGjm6atV2fAcz9IoQEBvSaox5Fjwv53KAEAEKpqVWZ/2DHByTEqOFei+cwBG27IfNm3v+Q06vDg1JHjbjhuYZxWdV9XZZ6INrtkGUVs5Fkpm/k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=e1CPeIYq; arc=none smtp.client-ip=209.85.128.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f46.google.com with SMTP id 5b1f17b1804b1-47d3ffa5f33so36534025e9.2
        for <netdev@vger.kernel.org>; Mon, 05 Jan 2026 03:48:03 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1767613681; x=1768218481; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=0c7x1KuoCO36lV/cUbw2RbaoUEVJdub9OudTswrskL8=;
        b=e1CPeIYqqLxhaGhQhEAFUgiFi3kRex4k/G1yNOl/C+sz70vye3TpgcVztmpo+9xu9K
         RdcrHg9wGVad2cynGGGE3DQS+Npv0odgsCGBymJ+l6xRZabra0GEgoxZvpNvyznz8nKD
         Guik2Bwd3XFgy8yqQODXasy1JepllAfWtTV+kRf1FKepERZGCx7cO+tHEX4e3V9D5fwe
         e+snLowISA53rBynxc1JiWae22Izm42JrpLbSeYkqR0XRHoq1jn82bWm9/g/BDDqC0xi
         eDJWWFMxkLCpLxhOm+izU6Cw5PZ0L+4GwJGwH7Kk4FHMSpAujy3+PZ5b6DHR66Wp1610
         dkLw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1767613681; x=1768218481;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=0c7x1KuoCO36lV/cUbw2RbaoUEVJdub9OudTswrskL8=;
        b=eOLDg5rBr2eTqLiep65FHNi+tu3h3UASkAThpDWWC0d9PySjPRjnGTVqmCgZCWb5sj
         6Ttc4PXaoDUASm8ay7M4cW2GzUwaTWGni3EsFGgRy8oq0FUMBdfhpudUicodv0QRwI1W
         /5BvtYO2tp8kAjZwQiOvdJ0/RpeScaj1q7eP9HWxOzXN9xVlaS/9tk56i6fgWvQjXigz
         ks1lNyrb9OrIQqRfkOJsn2PiLjGT2GNTf1JP1CXEg7g0H8VJVWRhdCuv1cKn2DE/mIRM
         1BLXaQn3DWy/v8RW/+/pixP2n5K7cb2d6LQ2CusS7ZhLHmCUWlbQx0BVxBBkKrGAh7IC
         gUJw==
X-Gm-Message-State: AOJu0Yz4bhJRxujCcZYoKj0I5DWsVNj1zKAFdSu/J6GzB5UvNfI4r49L
	b2XbZhgZgtHaNdPlUq2zm5nkeLqUF5A38pre1rV1kG8bj8lJCrIqnbkk+QaTTy9L
X-Gm-Gg: AY/fxX4/dmfHh8yjpc+5MElghlcmx/b6SES/onv8L8gc+b3o34C/U0G3hE4h1GoQJmc
	07P6Rx53StT67564OLNHbyO/GdjqhIyUSOAXk71kQ2sfuUMoMnzQ8WBPV68qtLE/PQvqFOeFIjO
	98YrYo7uWTK8LJt7PepyEb876pGUpnWEWhYkyzT4un8p8W3bv54jq4UL7DWl9kNdYywN2TFG8yA
	p52th8cB8I996GlL82EpeP4PMgAVLwOCzgjiVaSi6fmUerS6DkYYYeQIWmzTjNZF5Fy5ooQb0uc
	dGKk0zL6f5a/rLgc+w4XUqrXGNm4htUb5wyW3Js5uDOl8cMBDpDgcGNC2T5yPm3Vk6MI6I6zw5+
	Nl6YuTMRNld9JWmD4cM59tQEBC33CulSWOHFFhygbs13CMjv1o6qbkGMcgScRbG7oiXboMwx4f9
	Ag
X-Google-Smtp-Source: AGHT+IHKI7pXBundH6Aldzu3XpW85g+I64MiD5fidXc/xSwpMM10ybpQYDIOpGVHUtF2nmtmcb5RbA==
X-Received: by 2002:a05:600c:310c:b0:46e:32dd:1b1a with SMTP id 5b1f17b1804b1-47d1953b941mr483080275e9.7.1767613681409;
        Mon, 05 Jan 2026 03:48:01 -0800 (PST)
Received: from wdesk. ([5.213.159.39])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-47d6ba7090esm56459345e9.7.2026.01.05.03.47.58
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 05 Jan 2026 03:48:00 -0800 (PST)
From: Mahdi Faramarzpour <mahdifrmx@gmail.com>
To: netdev@vger.kernel.org
Cc: willemdebruijn.kernel@gmail.com,
	davem@davemloft.net,
	dsahern@kernel.org,
	edumazet@google.com,
	kuba@kernel.org,
	pabeni@redhat.com,
	horms@kernel.org,
	Mahdi Faramarzpour <mahdifrmx@gmail.com>
Subject: [PATCH net-next] udp: add drop count for packets in udp_prod_queue
Date: Mon,  5 Jan 2026 15:17:32 +0330
Message-Id: <20260105114732.140719-1-mahdifrmx@gmail.com>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

This commit adds SNMP drop count increment for the packets in
per NUMA queues which were introduced in commit b650bf0977d3
("udp: remove busylock and add per NUMA queues").

Signed-off-by: Mahdi Faramarzpour <mahdifrmx@gmail.com>
---
 net/ipv4/udp.c | 19 ++++++++++++++++++-
 1 file changed, 18 insertions(+), 1 deletion(-)

diff --git a/net/ipv4/udp.c b/net/ipv4/udp.c
index ffe074cb5..19ab44e46 100644
--- a/net/ipv4/udp.c
+++ b/net/ipv4/udp.c
@@ -1709,6 +1709,11 @@ int __udp_enqueue_schedule_skb(struct sock *sk, struct sk_buff *skb)
 	int dropcount;
 	int nb = 0;
 
+	struct {
+		int mem4;
+		int mem6;
+	} err_count = { 0, 0 };
+
 	rmem = atomic_read(&sk->sk_rmem_alloc);
 	rcvbuf = READ_ONCE(sk->sk_rcvbuf);
 	size = skb->truesize;
@@ -1760,6 +1765,10 @@ int __udp_enqueue_schedule_skb(struct sock *sk, struct sk_buff *skb)
 		total_size += size;
 		err = udp_rmem_schedule(sk, size);
 		if (unlikely(err)) {
+			if (skb->protocol == htons(ETH_P_IP))
+				err_count.mem4++;
+			else
+				err_count.mem6++;
 			/*  Free the skbs outside of locked section. */
 			skb->next = to_drop;
 			to_drop = skb;
@@ -1797,10 +1806,18 @@ int __udp_enqueue_schedule_skb(struct sock *sk, struct sk_buff *skb)
 			skb = to_drop;
 			to_drop = skb->next;
 			skb_mark_not_on_list(skb);
-			/* TODO: update SNMP values. */
 			sk_skb_reason_drop(sk, skb, SKB_DROP_REASON_PROTO_MEM);
 		}
 		numa_drop_add(&udp_sk(sk)->drop_counters, nb);
+
+		SNMP_ADD_STATS(__UDPX_MIB(sk, true), UDP_MIB_MEMERRORS,
+			       err_count.mem4);
+		SNMP_ADD_STATS(__UDPX_MIB(sk, true), UDP_MIB_INERRORS,
+			       err_count.mem4);
+		SNMP_ADD_STATS(__UDPX_MIB(sk, false), UDP_MIB_MEMERRORS,
+			       err_count.mem6);
+		SNMP_ADD_STATS(__UDPX_MIB(sk, false), UDP_MIB_INERRORS,
+			       err_count.mem6);
 	}
 
 	atomic_sub(total_size, &udp_prod_queue->rmem_alloc);
-- 
2.34.1


