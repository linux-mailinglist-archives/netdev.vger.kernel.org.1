Return-Path: <netdev+bounces-218325-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 0F68DB3BF3C
	for <lists+netdev@lfdr.de>; Fri, 29 Aug 2025 17:31:27 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 937B8A05B66
	for <lists+netdev@lfdr.de>; Fri, 29 Aug 2025 15:31:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 22EC3322DC9;
	Fri, 29 Aug 2025 15:31:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="XgozbrYa"
X-Original-To: netdev@vger.kernel.org
Received: from mail-qk1-f201.google.com (mail-qk1-f201.google.com [209.85.222.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7DFD5322C9C
	for <netdev@vger.kernel.org>; Fri, 29 Aug 2025 15:31:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756481466; cv=none; b=OgT3d1JE9A11GjGBNd+86N3mwDpFBY0EsJZBPxbqEdbFqRnEvn0YvZrLz+YsZb35Pz/h93Mlggmw1JHxfj3u6T/yEES6SGbMTMZNzVkRvn9sBy6wH1DZZLA+YnLcGi8qJOvngBLi+JE0aE50xYPTCwg8MIGll3wm1i2Z+kHzcvY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756481466; c=relaxed/simple;
	bh=wDY64SrfxPxDKlc5GvBpA8vnc20pgo3GCKCJCrCOPJM=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=SQ1b9j99p/RANy4Bc8Iw/gnK2La1W/wckYwQrYPBmDiyXRWL+IbN933DqFBkqwrSF5cdRmSG7Crs+h3ix82R5lrvsSbSWZ6WZF8PFXpCQRJKJTN37zi9PUV/pVJgKJ9zI2DT4RXLcyWrw2Oh5dobs9d9eAGbVdXsetOYSNg0/cg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--edumazet.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=XgozbrYa; arc=none smtp.client-ip=209.85.222.201
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--edumazet.bounces.google.com
Received: by mail-qk1-f201.google.com with SMTP id af79cd13be357-7f737071bebso509062985a.2
        for <netdev@vger.kernel.org>; Fri, 29 Aug 2025 08:31:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1756481463; x=1757086263; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=bqXmoWtQw7mn+k2f005VEom0bCQqQnA/De2EKzKykHg=;
        b=XgozbrYa5d94sGxiIVGR6FB+msjshIBn6CpFU34MtO+slrRCQQ7a1co35pIz02ifaa
         gakEG4VF3cccgUmYfhnXGivjEt7dUYOZETeTZ1QXj9IxswtPtQZFb8bUk1BoXr1ATz+g
         AHvZTq5/oKsqLpeU9QTOtULL7sm01ZoB5fBwvYKOLFFYASAN3vLxVQCBRdTjnkwS8mBu
         NA34SYvzh3D+acAMljyJM3ipoKc4m47U5c7VtTHqFc/ULza9nKPAQCmxIxdlBmi0eg1g
         etTWCuK7f6s5nm5z+TaGRM+/ZI5wEkLHqKCl+1qgk+CrwELkqky7PGqSAnaNroqzlrqd
         2bZg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1756481463; x=1757086263;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=bqXmoWtQw7mn+k2f005VEom0bCQqQnA/De2EKzKykHg=;
        b=WYUwqpS5UqgLg7LRXk0Nqj5iPPv2TKxWZAMrv/RyCwwjWGNEyHId6sukWJSB0df5Rp
         Byj4B8jIo6sT9Q8XTMB8tX9FxXCIzEKPcy90yZ53PLTeCCzAc4xv5DH95iyW5g0PUWbS
         1NESSH1BzW6XWEvrwrqaRC8uU+FkhB2TIyeJMOWAkcyYWAvvw0f6cgaMOXunJT66DYqW
         uHQNuphONL8/Bx+DdfzquHHZJRXn+P2E+hn1Xi/bG1nBJLthmz+AehqwHTK9De8rfCxx
         zzSCBDuNgKQUt4g1+mYQNFqdyTxyxWUfqm0XRDVVLfFT1NonhgQy0BvzD/oFQTFmtiQC
         q7vg==
X-Forwarded-Encrypted: i=1; AJvYcCVOHKs8RTB7/iue2xSLPOxpknSlmfYXUNsBFlD4P15sANFZhSDz+7TwMUTS0YAH0IoyRpoWlgM=@vger.kernel.org
X-Gm-Message-State: AOJu0Yys7grwVjLkMb1rshIo2w5wGpvQGaiYdIk910xjwWnTb4rnSeqg
	sKMVSXjUEqeLbbui0UKHaTlmbxWMbU5NiomELyn4YhqAm21N3TIOn6UEDFjLRoNhdyRzNtI8RI4
	FzMIB4pKLlck2Xg==
X-Google-Smtp-Source: AGHT+IH5NXZgmSWKZLBP5zdgGB4msHx+zBUDHHTVWiaEql26twEfFVy21LKaxhMXIBa/ki2z5hdqN1Bqh6v7MQ==
X-Received: from qkpb39.prod.google.com ([2002:a05:620a:2727:b0:7f9:cb2e:4d0])
 (user=edumazet job=prod-delivery.src-stubby-dispatcher) by
 2002:a05:620a:f05:b0:7e6:99e5:f54b with SMTP id af79cd13be357-7ea10f90321mr3151406985a.19.1756481463079;
 Fri, 29 Aug 2025 08:31:03 -0700 (PDT)
Date: Fri, 29 Aug 2025 15:30:53 +0000
In-Reply-To: <20250829153054.474201-1-edumazet@google.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20250829153054.474201-1-edumazet@google.com>
X-Mailer: git-send-email 2.51.0.318.gd7df087d1a-goog
Message-ID: <20250829153054.474201-4-edumazet@google.com>
Subject: [PATCH v3 net-next 3/4] inet: ping: make ping_port_rover per netns
From: Eric Dumazet <edumazet@google.com>
To: "David S . Miller" <davem@davemloft.net>, Jakub Kicinski <kuba@kernel.org>, 
	Paolo Abeni <pabeni@redhat.com>
Cc: Simon Horman <horms@kernel.org>, David Ahern <dsahern@kernel.org>, netdev@vger.kernel.org, 
	eric.dumazet@gmail.com, Eric Dumazet <edumazet@google.com>
Content-Type: text/plain; charset="UTF-8"

Provide isolation between netns for ping idents.

Randomize initial ping_port_rover value at netns creation.

Signed-off-by: Eric Dumazet <edumazet@google.com>
Reviewed-by: David Ahern <dsahern@kernel.org>
---
 include/net/netns/ipv4.h |  1 +
 net/ipv4/ping.c          | 10 +++++-----
 2 files changed, 6 insertions(+), 5 deletions(-)

diff --git a/include/net/netns/ipv4.h b/include/net/netns/ipv4.h
index 6373e3f17da84ebc5c11058763932e595f0fd205..54a7d187f62a2e995076e85f1e6b2fd70f84b2c1 100644
--- a/include/net/netns/ipv4.h
+++ b/include/net/netns/ipv4.h
@@ -251,6 +251,7 @@ struct netns_ipv4 {
 	int sysctl_igmp_qrv;
 
 	struct ping_group_range ping_group_range;
+	u16			ping_port_rover;
 
 	atomic_t dev_addr_genid;
 
diff --git a/net/ipv4/ping.c b/net/ipv4/ping.c
index 75e1b0f5c697653e79166fde5f312f46b471344a..98ccd4f9ed657d2bb9c013932d0c678f2b38a746 100644
--- a/net/ipv4/ping.c
+++ b/net/ipv4/ping.c
@@ -58,8 +58,6 @@ static struct ping_table ping_table;
 struct pingv6_ops pingv6_ops;
 EXPORT_SYMBOL_GPL(pingv6_ops);
 
-static u16 ping_port_rover;
-
 static inline u32 ping_hashfn(const struct net *net, u32 num, u32 mask)
 {
 	u32 res = (num + net_hash_mix(net)) & mask;
@@ -84,12 +82,12 @@ int ping_get_port(struct sock *sk, unsigned short ident)
 	isk = inet_sk(sk);
 	spin_lock(&ping_table.lock);
 	if (ident == 0) {
+		u16 result = net->ipv4.ping_port_rover + 1;
 		u32 i;
-		u16 result = ping_port_rover + 1;
 
 		for (i = 0; i < (1L << 16); i++, result++) {
 			if (!result)
-				result++; /* avoid zero */
+				continue; /* avoid zero */
 			hlist = ping_hashslot(&ping_table, net, result);
 			sk_for_each(sk2, hlist) {
 				if (!net_eq(sock_net(sk2), net))
@@ -101,7 +99,7 @@ int ping_get_port(struct sock *sk, unsigned short ident)
 			}
 
 			/* found */
-			ping_port_rover = ident = result;
+			net->ipv4.ping_port_rover = ident = result;
 			break;
 next_port:
 			;
@@ -1146,6 +1144,8 @@ static int __net_init ping_v4_proc_init_net(struct net *net)
 	if (!proc_create_net("icmp", 0444, net->proc_net, &ping_v4_seq_ops,
 			sizeof(struct ping_iter_state)))
 		return -ENOMEM;
+
+	net->ipv4.ping_port_rover = get_random_u16();
 	return 0;
 }
 
-- 
2.51.0.318.gd7df087d1a-goog


