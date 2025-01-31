Return-Path: <netdev+bounces-161795-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 71CD6A241A6
	for <lists+netdev@lfdr.de>; Fri, 31 Jan 2025 18:14:08 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id EDB3B167370
	for <lists+netdev@lfdr.de>; Fri, 31 Jan 2025 17:13:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 385281F0E5E;
	Fri, 31 Jan 2025 17:13:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="zymnghfQ"
X-Original-To: netdev@vger.kernel.org
Received: from mail-qv1-f74.google.com (mail-qv1-f74.google.com [209.85.219.74])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7AA151F0E26
	for <netdev@vger.kernel.org>; Fri, 31 Jan 2025 17:13:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.74
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1738343626; cv=none; b=ZDFr7ZGS4ZakgqTXd7R9xrpvp9eyzCjTXJNur3Dqu1uNouklGPHiehNAB2ZmaAgkgZcZDpT+XtWEvzgFTL48wdWEhDEgZDg/S1QYluqf1TEJ1MQpheMjXQeEdI/MQlt4vj2Mz7p4ombA+Luxa5IQJOohH/tngEHji3Fsdrt/kn8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1738343626; c=relaxed/simple;
	bh=Lt6e7okkgYTvVg+F/jtzDQh/HqGow3PVDgLhKpRdrro=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=YR/qv6q2mJfYU/umsg7dWdAjXpxJkg5a8Ps7bVv2oZ4QiWONfgTdX8jKP4JA7QniZsGEvUixgjn/X7vUu4yriISMrvdWUl7kqmTEEZ0KwIoKxZpCsfO3RMDwL7ZvJN6d2DQSufSLlNAT3/V453fBL7aKLxvFUQAtLUaPvQjFtag=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--edumazet.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=zymnghfQ; arc=none smtp.client-ip=209.85.219.74
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--edumazet.bounces.google.com
Received: by mail-qv1-f74.google.com with SMTP id 6a1803df08f44-6d884999693so34687226d6.0
        for <netdev@vger.kernel.org>; Fri, 31 Jan 2025 09:13:45 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1738343624; x=1738948424; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=2Uf3ShYMVjX4es+z+n0+Jeioa1AmjFn9dDjTiZ55aJE=;
        b=zymnghfQrk2JvhVbWeoaNu6MGfrsNlMwO/piLJFRSLXd1out/g5x2sKUqoHL68wryh
         meByMSSAAp+XtfLykJkmEQGpEVPdB4G+Fq98ZayGOtlZmKWnUmE9+508Tqv4H+B2QldE
         WWfVLwuJd977Yjq420o+fjThyH38j7QMaBc0zjHjNMY7rN8OWu+niU32hnpaK+/UKbWe
         s05u5iufMbuxlcqLuwQqgXw4zg8hZSGs7LJR9a63lJj/kQfnhQOx7e30mm/E5VIgPEjj
         70T0kf1N+2UEYah+gCG84Q7Emy8IZaANrkROtLGbhg63lMg44EZS152bTJiMESUnEIBd
         gK7Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1738343624; x=1738948424;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=2Uf3ShYMVjX4es+z+n0+Jeioa1AmjFn9dDjTiZ55aJE=;
        b=u+c6iPMpj3ZaVW4Aq67/0fbxGLj2NpH4+xKs5d0FwaDxvVA+Y+E8MT17X4n+88d2pK
         5T9QPGCjlysLhkaLalp8VIApc8LFu22oGfPXy24MkggLRnLQQp77NseNRGDACfDj/Z50
         rlRCm8ZG1ePgZCErincB6FqrvJ/WHZNQ4d8qfTKvZnxUC5AHfbL+W7ft2bRXhISN3CdK
         12oU1F/RAZoXMv51ZBnsrpZkXBoEA3/oHPktWUaRPuTk0Th0c1tERecp2weTI5V+oCtv
         r8IQ2zCOJvqT/Hka76eY40rjn0Aid+4zIf6Z7lt4D0NyUjEoz7Lo9AKj+bj3dN4WeSuS
         O74A==
X-Gm-Message-State: AOJu0YxWdvFio8cYmuDMt0s6vbEdBU5OFpZ3dHBJ1zTN7FkA+OZOodhO
	RoeTkyP2C9zc6+o0BOAbKxY/6hFjT+RQETQRtUrDmjlp2sjk7nKi88YIM629MdYGpP8LU8sVOkl
	6KOoCm7a4XQ==
X-Google-Smtp-Source: AGHT+IG08dNPx/fOWJtlz3MGyxmfFbJjmn7LR6allykZc0PqGaEpp3KB8RSuDeX3Rb56t+z1zivgwYuECXXfhw==
X-Received: from qvbpd4.prod.google.com ([2002:a05:6214:4904:b0:6dd:b1b1:caa7])
 (user=edumazet job=prod-delivery.src-stubby-dispatcher) by
 2002:ad4:5fcc:0:b0:6d8:b371:6a0f with SMTP id 6a1803df08f44-6e243c9b6bdmr221595936d6.31.1738343624285;
 Fri, 31 Jan 2025 09:13:44 -0800 (PST)
Date: Fri, 31 Jan 2025 17:13:22 +0000
In-Reply-To: <20250131171334.1172661-1-edumazet@google.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20250131171334.1172661-1-edumazet@google.com>
X-Mailer: git-send-email 2.48.1.362.g079036d154-goog
Message-ID: <20250131171334.1172661-5-edumazet@google.com>
Subject: [PATCH net 04/16] ipv4: use RCU protection in ipv4_default_advmss()
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


