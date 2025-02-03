Return-Path: <netdev+bounces-162119-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 5A68CA25D2F
	for <lists+netdev@lfdr.de>; Mon,  3 Feb 2025 15:46:08 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id CD30C3AD465
	for <lists+netdev@lfdr.de>; Mon,  3 Feb 2025 14:38:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BDCDB21322A;
	Mon,  3 Feb 2025 14:31:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="B/WQ6SsK"
X-Original-To: netdev@vger.kernel.org
Received: from mail-qv1-f73.google.com (mail-qv1-f73.google.com [209.85.219.73])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 136ED212FAF
	for <netdev@vger.kernel.org>; Mon,  3 Feb 2025 14:31:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.73
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1738593069; cv=none; b=kbiFfV0AxEb5KibJ3+ShqtSjRcWwvuKvyaEgRyHb21azDYzilWCf6eCy1yp0QYGKBSJ1+JPrgnwgRZkF6Vbu3xZW1PD1wqhE02QxSzFuQl5Oohbr2lZvsGhEmQCSfqbYe7vfq2Mc6TzMNdK+oiwkAXU8+G+zdPtaHUN5hjHeOcY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1738593069; c=relaxed/simple;
	bh=prnXcbt2huvfvhxZLdActDxMXy0yTt0im8WFkYLwVDo=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=CDVFSn91gxXErQ5D5t0FODcFd/vXMkaCyhuFrULMpAgVPFA7lZgXrd9mOBR89DZTNfizMaSbXw87BbkzNg4rIwzwo96TnaggPiJ+Ph/F7JGz5YIgOi3Af0EwD866m2CmVKLh9lAatYlhCiyUJCoy7lHZ2Mrs0MaOu6ELPvJlkhg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--edumazet.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=B/WQ6SsK; arc=none smtp.client-ip=209.85.219.73
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--edumazet.bounces.google.com
Received: by mail-qv1-f73.google.com with SMTP id 6a1803df08f44-6dd43b16631so50286476d6.2
        for <netdev@vger.kernel.org>; Mon, 03 Feb 2025 06:31:07 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1738593067; x=1739197867; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=9L3PBsjMaEaZKuEqPtTlZplZbWwE3hgdPgBONKRJuy8=;
        b=B/WQ6SsKRJzxDMGQDxSxzYEcexJKhjC9BaQUx39zgltT0OOd7lQF+RPTdMPhN/3jQa
         9CaC7bY9EO4GaFV7+FMpe19OGfwvttzyqTB4yQD+7rUNsQ/r3HuEIy93BFdvSw3yvhQF
         4lgJX+VtIJY/0ntzXsuHdxQyVyO20HVCFVAsx4Tl0GXN1uHDmiEL7pCILkesKQlzD1be
         lH4LPZAyTRTsj3f8BLfks1YpUmjdlxaozfahbnrs55ueX6iHMmZ/f6EqSVFbxbI2iQsF
         U4LlgZsdC94HX9z09ypsOwkTf7dehVSelqWktCkmMubmUnWXVlcZ0NP1z7o1cOhAgPCI
         sqYQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1738593067; x=1739197867;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=9L3PBsjMaEaZKuEqPtTlZplZbWwE3hgdPgBONKRJuy8=;
        b=BYJZ7MPx8/Y7sQe51g68xgI4Y+i7raHwy/CLPQYOBnbSNK0MvjnBnGQjPCY8Qp0Q6H
         Zr6ykf/qkT45av5e90oX/5VHDj8ItuzyWCJXfzDDMNK00rxpuClgCqKBqqFaI0zyHMes
         2PIopOyuoWXf3Ts8nOTq15RW1k9ECEF+FqcpwUYPS4amXnRVQ5zV+EP8CzitNCeZQOok
         B2TyErucns5TwqaMSkcbaq264g+6MpXZBiPPE5qW0Dc2Q6zWOyWIkuJIF9sU2G5OohqD
         gSYzaI9dq4dBaRVQ3KIA7ilG1Za7fjmFztE8AU8iZi5nPubGjpcM+xXhuozMmfGm+fRK
         wVoA==
X-Gm-Message-State: AOJu0Yz+trmlmE4Aj1Vo5B5QRqqcC7qvhV7ZPfi4BMSHsyVJU1FLG5Zv
	+ORL6hn3PyAAtEGu/UeQt3++3qZotoIBtPM9vBb07Xee6AfeBE2LuvMtJo0pIQJBsshqF6bvt7p
	aFUUSDWSFPQ==
X-Google-Smtp-Source: AGHT+IF2DnzYK53Vvyw+YH1v173mBxe750NiYvXf7//be7mcTVmHwL2BP/0Re1Xwgxux8Tc951OCHJBBR7Wwmg==
X-Received: from qvbqr7.prod.google.com ([2002:a0c:f207:0:b0:6d8:aa93:951c])
 (user=edumazet job=prod-delivery.src-stubby-dispatcher) by
 2002:a05:6214:1bc7:b0:6d8:96a6:ec27 with SMTP id 6a1803df08f44-6e243c63d6cmr320971406d6.35.1738593066846;
 Mon, 03 Feb 2025 06:31:06 -0800 (PST)
Date: Mon,  3 Feb 2025 14:30:43 +0000
In-Reply-To: <20250203143046.3029343-1-edumazet@google.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20250203143046.3029343-1-edumazet@google.com>
X-Mailer: git-send-email 2.48.1.362.g079036d154-goog
Message-ID: <20250203143046.3029343-14-edumazet@google.com>
Subject: [PATCH v2 net 13/16] ipv6: use RCU protection in ip6_default_advmss()
From: Eric Dumazet <edumazet@google.com>
To: "David S . Miller" <davem@davemloft.net>, Jakub Kicinski <kuba@kernel.org>, 
	Paolo Abeni <pabeni@redhat.com>
Cc: netdev@vger.kernel.org, Kuniyuki Iwashima <kuniyu@amazon.com>, 
	Simon Horman <horms@kernel.org>, eric.dumazet@gmail.com, 
	Eric Dumazet <edumazet@google.com>
Content-Type: text/plain; charset="UTF-8"

ip6_default_advmss() needs rcu protection to make
sure the net structure it reads does not disappear.

Signed-off-by: Eric Dumazet <edumazet@google.com>
Reviewed-by: Kuniyuki Iwashima <kuniyu@amazon.com>
---
 net/ipv6/route.c | 7 ++++++-
 1 file changed, 6 insertions(+), 1 deletion(-)

diff --git a/net/ipv6/route.c b/net/ipv6/route.c
index 78362822b9070df138a0724dc76003b63026f9e2..ef2d23a1e3d532f5db37ca94ca482c5522dddffc 100644
--- a/net/ipv6/route.c
+++ b/net/ipv6/route.c
@@ -3196,13 +3196,18 @@ static unsigned int ip6_default_advmss(const struct dst_entry *dst)
 {
 	struct net_device *dev = dst->dev;
 	unsigned int mtu = dst_mtu(dst);
-	struct net *net = dev_net(dev);
+	struct net *net;
 
 	mtu -= sizeof(struct ipv6hdr) + sizeof(struct tcphdr);
 
+	rcu_read_lock();
+
+	net = dev_net_rcu(dev);
 	if (mtu < net->ipv6.sysctl.ip6_rt_min_advmss)
 		mtu = net->ipv6.sysctl.ip6_rt_min_advmss;
 
+	rcu_read_unlock();
+
 	/*
 	 * Maximal non-jumbo IPv6 payload is IPV6_MAXPLEN and
 	 * corresponding MSS is IPV6_MAXPLEN - tcp_header_size.
-- 
2.48.1.362.g079036d154-goog


