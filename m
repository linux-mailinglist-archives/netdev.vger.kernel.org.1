Return-Path: <netdev+bounces-163090-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 7E979A29545
	for <lists+netdev@lfdr.de>; Wed,  5 Feb 2025 16:52:27 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id EE1C01885731
	for <lists+netdev@lfdr.de>; Wed,  5 Feb 2025 15:52:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F150F1946B1;
	Wed,  5 Feb 2025 15:51:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="QMjxGcj9"
X-Original-To: netdev@vger.kernel.org
Received: from mail-qv1-f74.google.com (mail-qv1-f74.google.com [209.85.219.74])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 592051990B7
	for <netdev@vger.kernel.org>; Wed,  5 Feb 2025 15:51:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.74
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1738770689; cv=none; b=erMDvkzxVqZ3vIa90b1W1fCN78hy2AzO4xGAVV1Ud08lLG6IqEjRMC/6//KoZs7kFgt3qGfGmCoUVh9D/4nwViadlddLCWUWuPW+vvtvyi4pnXHu/XkSLjb+18UqgTb3oOdl5MkOP2YM4I7fmoVwCNWigYYARnC8v7XXtq46NoU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1738770689; c=relaxed/simple;
	bh=H8JH/QPjFfGxbrJtRbDkCum9cREuE5YKVIPC//b1qCs=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=NfqpYY1QtHdgrhpUUx1VWyUXm6KsX0c+djPuHgVTCI9JRQXQT2xtS4sg2sGoSmoMuf8g7+hqDdHZUbVwkFnVuZGnFaUKH48gI0K2sZ+73nL1L852QEsGUxmkFUcFkoRG8Z0PoGSA1KhIAq7iBwG9Y3DpZc7N1yxGXQ+9I3m5Sxg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--edumazet.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=QMjxGcj9; arc=none smtp.client-ip=209.85.219.74
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--edumazet.bounces.google.com
Received: by mail-qv1-f74.google.com with SMTP id 6a1803df08f44-6e42e3cb051so34681686d6.0
        for <netdev@vger.kernel.org>; Wed, 05 Feb 2025 07:51:27 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1738770687; x=1739375487; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=oummPnO89bchIzAktiowh3Jl3EZAt201EnCE7gdN6jc=;
        b=QMjxGcj9tjQY49Q9wI4gGwaNbVLqo5wCMAmYjoPqBJpuTntYyvRQ7N5D0pYwDXS2Li
         ZfcXKMDIliCEP9Ps4Gzhnr/FZE7VNozQ025BklcsWafxVG3qtG8RVhTLSGMXrNdJRqkj
         n2ZgHyPQxyPYof4dTHyRbgfuqj0Tm1BC1+atOOTOl7TNzixd1mNEXZNx48KGLGf3qu5j
         5iGmADe+pMuR/ZP69Ao3wz1xu3Kav5UK3l3fu6OLucciHbErkMl8al8MTq8qU8m4kabM
         ybvqYP7xTzfqe1Zr2nGwe+ZSJw2zeddeOivbhWRty8HRBkF3acdXs9UPZjyBe9q/cvH8
         gToQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1738770687; x=1739375487;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=oummPnO89bchIzAktiowh3Jl3EZAt201EnCE7gdN6jc=;
        b=SnyFk+3elcJ6gfTlubrX+nD5ymQT80R0SUjRt23nkn4uoe/VJD44oyz4w42puCP0LK
         t0ipiLIBVqc7BlC25aDetahUORQ7jYnJyUrbKiZqlxgko/u5TMW8tF9IA8SFioBGzXmB
         zSzdcG7Iyj5nD2En+EZOe3k6irRiccJt3dou59+Q9J4eQu2uZriaSidfbPTqOnrII/ev
         AeRZqi1rrWf5a3rD6g4EgyL5VeYQ9f6/BrrL+s+2peSGxZ/a6ktJTIl7nENG6J39rKTA
         xeWw0tWD7fGw8Fit7V95C59jMKY1OUXZJtGVd9MdQTWtLEgCynDNPivDW0I9+UHSiLZO
         4MxQ==
X-Gm-Message-State: AOJu0YwBK1q+Nc2JhLQtRPxMRED60XAsJZL/eplxHIlySmKz+wZkbywH
	ppcIGxFor97xJpLnV+KDw0MZe/4dZk2jLRLemiSn97p+KZ1qh+kL5K/smT7LziZs1Jg3SZ7LOHv
	olpeAfkJ37w==
X-Google-Smtp-Source: AGHT+IEED/sXUFR8e5BcIPk0aFSPDj3FXn4V8c/ldayogRX7uDzKvpe0Hxl6B9psUVHWEAUTHY5p0BRxkYT+LQ==
X-Received: from qknru10.prod.google.com ([2002:a05:620a:684a:b0:7bc:de89:fc31])
 (user=edumazet job=prod-delivery.src-stubby-dispatcher) by
 2002:a05:620a:43a6:b0:7b6:753b:9b5d with SMTP id af79cd13be357-7c03a036f63mr575155085a.36.1738770687191;
 Wed, 05 Feb 2025 07:51:27 -0800 (PST)
Date: Wed,  5 Feb 2025 15:51:12 +0000
In-Reply-To: <20250205155120.1676781-1-edumazet@google.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20250205155120.1676781-1-edumazet@google.com>
X-Mailer: git-send-email 2.48.1.362.g079036d154-goog
Message-ID: <20250205155120.1676781-5-edumazet@google.com>
Subject: [PATCH v4 net 04/12] ipv4: use RCU protection in ipv4_default_advmss()
From: Eric Dumazet <edumazet@google.com>
To: "David S . Miller" <davem@davemloft.net>, Jakub Kicinski <kuba@kernel.org>, 
	Paolo Abeni <pabeni@redhat.com>
Cc: netdev@vger.kernel.org, Kuniyuki Iwashima <kuniyu@amazon.com>, 
	Simon Horman <horms@kernel.org>, eric.dumazet@gmail.com, 
	Eric Dumazet <edumazet@google.com>
Content-Type: text/plain; charset="UTF-8"

ipv4_default_advmss() must use RCU protection to make
sure the net structure it reads does not disappear.

Fixes: 2e9589ff809e ("ipv4: Namespaceify min_adv_mss sysctl knob")
Signed-off-by: Eric Dumazet <edumazet@google.com>
Reviewed-by: Kuniyuki Iwashima <kuniyu@amazon.com>
---
 net/ipv4/route.c | 11 ++++++++---
 1 file changed, 8 insertions(+), 3 deletions(-)

diff --git a/net/ipv4/route.c b/net/ipv4/route.c
index 577b88a43293aa801c3ee736d7e5cc4d97917717..74c074f45758be5ae78a87edb31837481cc40278 100644
--- a/net/ipv4/route.c
+++ b/net/ipv4/route.c
@@ -1307,10 +1307,15 @@ static void set_class_tag(struct rtable *rt, u32 tag)
 
 static unsigned int ipv4_default_advmss(const struct dst_entry *dst)
 {
-	struct net *net = dev_net(dst->dev);
 	unsigned int header_size = sizeof(struct tcphdr) + sizeof(struct iphdr);
-	unsigned int advmss = max_t(unsigned int, ipv4_mtu(dst) - header_size,
-				    net->ipv4.ip_rt_min_advmss);
+	unsigned int advmss;
+	struct net *net;
+
+	rcu_read_lock();
+	net = dev_net_rcu(dst->dev);
+	advmss = max_t(unsigned int, ipv4_mtu(dst) - header_size,
+				   net->ipv4.ip_rt_min_advmss);
+	rcu_read_unlock();
 
 	return min(advmss, IPV4_MAX_PMTU - header_size);
 }
-- 
2.48.1.362.g079036d154-goog


