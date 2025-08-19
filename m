Return-Path: <netdev+bounces-215026-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 2D209B2CB5A
	for <lists+netdev@lfdr.de>; Tue, 19 Aug 2025 19:49:32 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id A1EAF5A3A42
	for <lists+netdev@lfdr.de>; Tue, 19 Aug 2025 17:47:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C555630DEC6;
	Tue, 19 Aug 2025 17:47:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="RCMnCBcV"
X-Original-To: netdev@vger.kernel.org
Received: from mail-wr1-f48.google.com (mail-wr1-f48.google.com [209.85.221.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0FA9C30DEAD;
	Tue, 19 Aug 2025 17:47:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755625662; cv=none; b=butsK2zYN7sdA9lmKJsHbjekIP2L/4f8HXn9LYjJqG0DV489EOLBiWS1vk+T9tm0M2C8aHKk31L7bbTiO0jbWWiGAeJN8ndj8RkWvKYPICM+NU4SbIIk59i6IdPV8MSQfSPgUUmkiZQFHlEfGWmnUcn99wNckdkO18XbiAWXSOM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755625662; c=relaxed/simple;
	bh=uWD5hyVJjE67IRF3moww3abcQ6Otg/bGCM1XBEuodf4=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=NvKAMtVJTxAgt0CN68Cd+hOq4d4ZKcq9rMJ9oVRrzgNHbpLGSa4KuuS/6VRQQzHeLcXflbzN5yzvjc/c0lKX/NrY6aVNgaRIl6a9FWvEZrl7fP9klS6DJo5pDPF6XSUYKM5vcnym65wVrAaOmUrh6XrlTq43dY2OWJDemMd1qx0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=RCMnCBcV; arc=none smtp.client-ip=209.85.221.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wr1-f48.google.com with SMTP id ffacd0b85a97d-3b9e413a219so4504566f8f.3;
        Tue, 19 Aug 2025 10:47:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1755625659; x=1756230459; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Cog/1+YP/iQO2qsSce5fbROxGAWx+PUiBTuYfWJKa7Y=;
        b=RCMnCBcVmXoa6q1Frh/ae7Uh1n65jXPEHp6F7De99AACezXQWazkFsE31qbIQMhskq
         2AWQx25B99SUyhnpG7md13teFdKOMw5KuEbra3nJt+YMq2UQl+ZVyKqjlFFpGxZC5NSX
         NxKnL10GGUKGVhjmFc01O3pcR0SnN+Gvfhu9AGxXoJOHDU4lpkk3SHZW0rcFy3AQV+Nk
         JDwYHBXU9qQ5YOL/FFnoC2tLZ/Y01PWs/PLjdbmSbyC0Xch2kncYd70JWmOp9cQRI4Fq
         VAj2qwloX9vYVue+OgqZTgAZdfYs5iLS4sKoXQP5/uN/pRrrSJndzoSFhBi/ebn/uDBi
         nAhA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1755625659; x=1756230459;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Cog/1+YP/iQO2qsSce5fbROxGAWx+PUiBTuYfWJKa7Y=;
        b=GQkvTJloC1xG+7vtzO6emVVEI4yguoby0Vd+avKOfHTwalz06JErWb/RP/MjkMngNs
         NtQcBLMgmFv6/gvzUu/eWezKR9JuOEC4v5mtL0uTrJMra4gQXw6jbJ7yKT6WnLBK11Dg
         alUEDGaFmUZb5tFm8+uK/3s4NxVDeznXor9Zua0iJ2RBvr6d3GHyYXHTtS6rMNxvSSBE
         AYRZB25wEZSlc6Ttqfcc1LV7bh4Y8YCGI2k9AOzf6rN/Iu5+9Aktz6vxLsXWmNUiFQ7g
         qc/Xm3xzasbvVz6jZ3ePJoQ7v448+ON3EJOgji4njLcFaHnHI6bwVfXtbw9GZaXSFrHT
         ClGg==
X-Forwarded-Encrypted: i=1; AJvYcCW37fDq3nyk5jxfiKLtnKSFWr22Cq2NUBm+TQle3BJr3ae+qVQyZAVXB7oWGvf/Giqr3Uv3HY+Xv4cLvvw=@vger.kernel.org
X-Gm-Message-State: AOJu0YxhJMna76FAkMVMFzYYXPlzUw+eciRrhDZ8rbgtYBxQm6KBg7Nf
	ec/Icf1Z6w5KsYvItsXtpdA7DW+F77Y4SedUHdlrs1QHGhAJbEhUPcaXAFdyeFT1
X-Gm-Gg: ASbGncseQGDIvhX0KZJ4fMJTaeoLT5SqAB5bjQvphB7hgkXQssshrrXx3CQoHK6ypVN
	Xm4K4Ezgf0g21In5oIYNQc1zoRjOXt1XFp6pZax1XrWEdcDOpCibepH9mhrsrqjkm5OQMDF3I+z
	AxsnZuDsIJEZAesJZ2Elw/1OhZXPhkAkbD/fJuCgrH2ZX/8WuV6spSKzCjsGCdjD72WP/Scdnm/
	JooxGxiXREbci12O7pYWdl4IgnlXqM4jJAuIxZZyXehHB7938tw8ntz7xh5rqPJZKE5H4wacEf6
	WkgmnOZyLG3ldhUDmOx9r+xKh1hvnaayeJIquQjwsVvWGqhnEEFSyC4Ts8PYlHqkdJ6t1y0kDYy
	8yTu/pfxxj+eMP0WEiQMY91dtJ+odS9Ll1fw=
X-Google-Smtp-Source: AGHT+IEu3qhC3HqGeNgPtxgH3g/IswHRDzukzy3hbcQoLcK0lKJS4HljCzLnNMNx9arYLl2RmRQ9kg==
X-Received: by 2002:a05:6000:2887:b0:3b7:9350:44d4 with SMTP id ffacd0b85a97d-3c0ea3ceed0mr3065979f8f.11.1755625658996;
        Tue, 19 Aug 2025 10:47:38 -0700 (PDT)
Received: from localhost.localdomain ([45.128.133.229])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-45a1c78b410sm232181565e9.24.2025.08.19.10.47.33
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 19 Aug 2025 10:47:38 -0700 (PDT)
From: Oscar Maes <oscmaes92@gmail.com>
To: netdev@vger.kernel.org
Cc: davem@davemloft.net,
	dsahern@kernel.org,
	edumazet@google.com,
	kuba@kernel.org,
	pabeni@redhat.com,
	horms@kernel.org,
	shuah@kernel.org,
	linux-kernel@vger.kernel.org,
	Oscar Maes <oscmaes92@gmail.com>
Subject: [PATCH net-next v3 1/2] net: ipv4: allow directed broadcast routes to use dst hint
Date: Tue, 19 Aug 2025 19:46:41 +0200
Message-Id: <20250819174642.5148-2-oscmaes92@gmail.com>
X-Mailer: git-send-email 2.39.5
In-Reply-To: <20250819174642.5148-1-oscmaes92@gmail.com>
References: <20250819174642.5148-1-oscmaes92@gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Currently, ip_extract_route_hint uses RTN_BROADCAST to decide
whether to use the route dst hint mechanism.

This check is too strict, as it prevents directed broadcast
routes from using the hint, resulting in poor performance
during bursts of directed broadcast traffic.

Fix this in ip_extract_route_hint and modify ip_route_use_hint
to preserve the intended behaviour.

Signed-off-by: Oscar Maes <oscmaes92@gmail.com>
---
 net/ipv4/ip_input.c | 11 +++++++----
 net/ipv4/route.c    |  2 +-
 2 files changed, 8 insertions(+), 5 deletions(-)

diff --git a/net/ipv4/ip_input.c b/net/ipv4/ip_input.c
index fc323994b1fa..a09aca2c8567 100644
--- a/net/ipv4/ip_input.c
+++ b/net/ipv4/ip_input.c
@@ -587,9 +587,13 @@ static void ip_sublist_rcv_finish(struct list_head *head)
 }
 
 static struct sk_buff *ip_extract_route_hint(const struct net *net,
-					     struct sk_buff *skb, int rt_type)
+					     struct sk_buff *skb)
 {
-	if (fib4_has_custom_rules(net) || rt_type == RTN_BROADCAST ||
+	const struct iphdr *iph = ip_hdr(skb);
+
+	if (fib4_has_custom_rules(net) ||
+	    ipv4_is_lbcast(iph->daddr) ||
+	    ipv4_is_zeronet(iph->daddr) ||
 	    IPCB(skb)->flags & IPSKB_MULTIPATH)
 		return NULL;
 
@@ -618,8 +622,7 @@ static void ip_list_rcv_finish(struct net *net, struct list_head *head)
 
 		dst = skb_dst(skb);
 		if (curr_dst != dst) {
-			hint = ip_extract_route_hint(net, skb,
-						     dst_rtable(dst)->rt_type);
+			hint = ip_extract_route_hint(net, skb);
 
 			/* dispatch old sublist */
 			if (!list_empty(&sublist))
diff --git a/net/ipv4/route.c b/net/ipv4/route.c
index f639a2ae881a..1f212b2ce4c6 100644
--- a/net/ipv4/route.c
+++ b/net/ipv4/route.c
@@ -2210,7 +2210,7 @@ ip_route_use_hint(struct sk_buff *skb, __be32 daddr, __be32 saddr,
 		goto martian_source;
 	}
 
-	if (rt->rt_type != RTN_LOCAL)
+	if (!(rt->rt_flags & RTCF_LOCAL))
 		goto skip_validate_source;
 
 	reason = fib_validate_source_reason(skb, saddr, daddr, dscp, 0, dev,
-- 
2.39.5


