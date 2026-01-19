Return-Path: <netdev+bounces-251309-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id BFD94D3B926
	for <lists+netdev@lfdr.de>; Mon, 19 Jan 2026 22:13:22 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 4A888304357F
	for <lists+netdev@lfdr.de>; Mon, 19 Jan 2026 21:12:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D7FE22F7ADE;
	Mon, 19 Jan 2026 21:12:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=herbertland.com header.i=@herbertland.com header.b="VgqPGwOX"
X-Original-To: netdev@vger.kernel.org
Received: from mail-dy1-f170.google.com (mail-dy1-f170.google.com [74.125.82.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8D0F42F7475
	for <netdev@vger.kernel.org>; Mon, 19 Jan 2026 21:12:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.82.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768857161; cv=none; b=QusUy5/dki4REzDAeSNnJO1/Gjg2Ck6PfgNnuvtH3QrkCoth3rXoN6zeQXpnJw9XUuMu4le43y9iiilwKBtYkF4jEODMGERqCq/SCfERZ+9oQ5s0/nasWwh0NdtbYluXhlSX0Tnt2xnAlFje4MH1Ui+cnUxe+Jy00Pv+c31nC9U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768857161; c=relaxed/simple;
	bh=RxuB4fQOw40GjTFCeMNeAO9JQq+9pyRO9zVS/bwqwqM=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=KplXzxRFjtQ4wjQROQ0XxqS2lHz3Js0mvlFatkI+jdymswVzCyb37sLGT0bOQWUF992vnm3DuYLLWnMqH7I1nj1Swr9sOBHOcRwVeNZyiT7F7Bq1+pExi883327WIqMMsN1Z1R9ss4ZmgsH1yQS6/zn5BCfWQ9HsjqUhUMobImU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=herbertland.com; spf=pass smtp.mailfrom=herbertland.com; dkim=pass (2048-bit key) header.d=herbertland.com header.i=@herbertland.com header.b=VgqPGwOX; arc=none smtp.client-ip=74.125.82.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=herbertland.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=herbertland.com
Received: by mail-dy1-f170.google.com with SMTP id 5a478bee46e88-2b6a93d15ddso4501860eec.1
        for <netdev@vger.kernel.org>; Mon, 19 Jan 2026 13:12:40 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=herbertland.com; s=google; t=1768857160; x=1769461960; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=gxarzd/JYXJXH1ji4SIrW5uq3pJu4+kyHJNxhFjiKx0=;
        b=VgqPGwOXx1n0kznEQWfhLEvIfTJmMsOeO2GBAxb+S88Y6in9PO0QSrV4ud4wHxNQ8c
         PodIIxw0kiNqVN3q2erFqn2CQ+GxA3WxunejrFevktM0VdK+47sAM2xELv8VqhtCaNIF
         siGs8V8mAvfYyX55ErazIl+El5tnS/xEaAdCFGmY5svOYHVlFohy35Ks9uhovWlUI5ml
         8rcRDc+5DTe6Jv7mspINDItjkNUYpcNEcsPT7ZLCgyuMIl5RFTItfub6oQSbH3AO7CTP
         G+mGRjvdAf+ve/JJzdm6ORxahFaBIeHrtH+MHN2ktnE7UJcr+FbzK3te/SpthJGgeYUr
         XE0Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1768857160; x=1769461960;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=gxarzd/JYXJXH1ji4SIrW5uq3pJu4+kyHJNxhFjiKx0=;
        b=QqouIEcY+6WDKPPr8b1RdvHm7f3XR7VySF3bP1IFtLE0oRbZIdNzyVhxU6C/rWxbbo
         qCXgprOfGJ3LLhNNs61wG1Jn0lWHEAzvSnXX/sq9uEnbIFm9j+toZx69uftDvFw7Wj6t
         Ke6Adjsd+kUXj+gH1qFjY36p0dtZEUsDxzzAkhOdPYFu4m9Z/puuD0w5I0lgcv093/wT
         bH+P5R9cVF+sqJ8yIXzRQklqK9Pd5ltPIBK5WeXLq5sLJYDQQj8oRqAQ2t8q1ktP/6BV
         TTZmvJHJRv7F45No+X0ziJ96Do5MeGWz+OHYdFB2U9KdFtp8dz+X4VobtqfXZoXlVE//
         P89w==
X-Forwarded-Encrypted: i=1; AJvYcCXjZGXBYw3T5TYCkzooeQRt5HBdL/8ibEu7hdXg8dF0vxPjNG3m1m5v16vBN+O/kxRTUfwTg9o=@vger.kernel.org
X-Gm-Message-State: AOJu0YyvAhhRKxDOZoK51W/5BtsyKflSWOfZfcqesAHCSeEGxmwgYCg6
	K4LbKfg8ZfDRRJDnqvD3vYLBTBkfX02j4DQJ5sbZo4IqlhaDQgvYECB+MaVRatw3ug==
X-Gm-Gg: AZuq6aJt/EfXnLXLinUpiqaBeE4hhAe+++iWvRjDrKEJtwgwmbRPVx9Itc9K73pfnSF
	yCr5QyzbUEnyLSH8HzIgGp4yL/mT0bxpZ4LbOysIEORbxoOyfkbtkUtZVTYrMbzYMVmBJ40dFcz
	ftNP9OPI7j7g9oJS65l8kkP3C+dLasdjfWmkUP1mp18Y+DsHAQfFMe9w68r51Fyv/9PRY9lz928
	FuODjmvUn67sKyiLQXP7GsdaC6qKcDlaog/UEaYbfzWoKXjJncq9gKPTkV/0zz3qgrWCHfuDQC8
	uiU5G5Xr0kOwMrKRcu62XsWVI9IvgQcChZM/pqbKJm62VCyD5qwQ+OYxSzRheK0FYKqcsM2dNeV
	5V0u9b9Xv34Gjz+UaAURLwKEzE1rx3lfPld6OQL+BpB7tlK1PbAdjB2i/J7CA79Xrn4cMUA2el2
	ONs5EAUgpfmCwzrVzVSIz7SAR6ckWVJMI/mtP4L61r8FMeHXKOMsI5Cc+W
X-Received: by 2002:a05:7301:9e48:b0:2ae:5ad4:718d with SMTP id 5a478bee46e88-2b6b410825emr9821153eec.43.1768857159396;
        Mon, 19 Jan 2026 13:12:39 -0800 (PST)
Received: from pong.herbertland.com ([2601:646:8980:b330:850a:22d6:79cd:2abe])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-2b6b351e38bsm14348137eec.14.2026.01.19.13.12.38
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 19 Jan 2026 13:12:38 -0800 (PST)
From: Tom Herbert <tom@herbertland.com>
To: davem@davemloft.net,
	kuba@kernel.org,
	netdev@vger.kernel.org,
	justin.iurman@uliege.be
Cc: Tom Herbert <tom@herbertland.com>
Subject: [PATCH net-next v3 1/7] ipv6: Check of max HBH or DestOp sysctl is zero and drop if it is
Date: Mon, 19 Jan 2026 13:12:06 -0800
Message-ID: <20260119211212.55026-2-tom@herbertland.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260119211212.55026-1-tom@herbertland.com>
References: <20260119211212.55026-1-tom@herbertland.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

In IPv6 Destination options processing function check if
net->ipv6.sysctl.max_dst_opts_cnt is zero up front. If it is zero then
drop the packet since Destination Options processing is disabled.

Similarly, in IPv6 hop-by-hop options processing function check if
net->ipv6.sysctl.max_hbh_opts_cnt is zero up front. If it is zero then
drop the packet since Hop-by-Hop Options processing is disabled.

Signed-off-by: Tom Herbert <tom@herbertland.com>
---
 net/ipv6/exthdrs.c | 6 ++++--
 1 file changed, 4 insertions(+), 2 deletions(-)

diff --git a/net/ipv6/exthdrs.c b/net/ipv6/exthdrs.c
index 54088fa0c09d..45bbad76f5de 100644
--- a/net/ipv6/exthdrs.c
+++ b/net/ipv6/exthdrs.c
@@ -303,7 +303,8 @@ static int ipv6_destopt_rcv(struct sk_buff *skb)
 	struct net *net = dev_net(skb->dev);
 	int extlen;
 
-	if (!pskb_may_pull(skb, skb_transport_offset(skb) + 8) ||
+	if (!net->ipv6.sysctl.max_dst_opts_cnt ||
+	    !pskb_may_pull(skb, skb_transport_offset(skb) + 8) ||
 	    !pskb_may_pull(skb, (skb_transport_offset(skb) +
 				 ((skb_transport_header(skb)[1] + 1) << 3)))) {
 		__IP6_INC_STATS(dev_net(dst_dev(dst)), idev,
@@ -1041,7 +1042,8 @@ int ipv6_parse_hopopts(struct sk_buff *skb)
 	 * sizeof(struct ipv6hdr) by definition of
 	 * hop-by-hop options.
 	 */
-	if (!pskb_may_pull(skb, sizeof(struct ipv6hdr) + 8) ||
+	if (!net->ipv6.sysctl.max_hbh_opts_cnt ||
+	    !pskb_may_pull(skb, sizeof(struct ipv6hdr) + 8) ||
 	    !pskb_may_pull(skb, (sizeof(struct ipv6hdr) +
 				 ((skb_transport_header(skb)[1] + 1) << 3)))) {
 fail_and_free:
-- 
2.43.0


