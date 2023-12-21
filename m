Return-Path: <netdev+bounces-59649-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 7594C81B951
	for <lists+netdev@lfdr.de>; Thu, 21 Dec 2023 15:08:46 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 2678F1F29460
	for <lists+netdev@lfdr.de>; Thu, 21 Dec 2023 14:08:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3EB286D6C8;
	Thu, 21 Dec 2023 14:07:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="bigJeILy"
X-Original-To: netdev@vger.kernel.org
Received: from mail-yb1-f202.google.com (mail-yb1-f202.google.com [209.85.219.202])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BC7976D6FF
	for <netdev@vger.kernel.org>; Thu, 21 Dec 2023 14:07:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--edumazet.bounces.google.com
Received: by mail-yb1-f202.google.com with SMTP id 3f1490d57ef6-db4004a8aa9so913865276.1
        for <netdev@vger.kernel.org>; Thu, 21 Dec 2023 06:07:49 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1703167668; x=1703772468; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:mime-version:date:from:to:cc:subject
         :date:message-id:reply-to;
        bh=hiY2PVslFVonjyErJLbhMkdT0D/QDjdAylJY2I2ptfQ=;
        b=bigJeILy6nHwCNuMSRWKJcYYbQFkeNiXFvz66tK+CqrWeBe4XzkEscvRPfDhRrcqt2
         Dnjo7EjKNgeGh9FBBn8d2yF3Jmq6zByHbcvim3jvrsP8PnVDaLSqpd9M32CAA1KkFt4L
         LzMOgP3fbwEBardKNTszyTSHd8yDP2+aZR0MHp7CTdEI3bb7bFBxtpUo6AQYVaGejnGj
         BnLHGaC9dOI1t9wlR4b8x6BLYu8HOoFPJgwqoBQBgYUCd5pEJzizm8uz/TnaGEArCU7r
         WZHDojoBhnLemHtqhDzWZ0scOtyLeXRBMStVXsXzdmrtDpdwWm+qLyiWi5N3d6a9xab1
         NjaQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1703167668; x=1703772468;
        h=cc:to:from:subject:message-id:mime-version:date:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=hiY2PVslFVonjyErJLbhMkdT0D/QDjdAylJY2I2ptfQ=;
        b=Gd+Fe+/j1RhV3xQXoKZ5/FTOjadpnwoanOqbwktCJqGj0te92kV7agi09euMkdt8Cf
         i3ZAZB7wfsDONOmk26fOuSstoi/nhFBbnyvrdmPWGmUqN4TiCCvie+T73NFDyyogXGEZ
         HOXwCDDVQfN93Yej6zqiIh65dpRhvgqBHrnD1Jn8gGJK9B+h4tC5/tgPi7Fc3H6LPyy7
         4MsA50o/1a3EWW3N8VbBebb0uCTtQpIteYusj/bJX8kHPydsBKdwd+HksFQVQv9jo2T6
         XRtXbgcMMqBYqVHwba1PvCd6h1cJL1MHyWJgxQjAPz5xX9SSh7I5nM7aKZF+ydE7zo7U
         NByg==
X-Gm-Message-State: AOJu0YzQxKIAG/e3rx43b0bZKmZEczovGPGTpAElLFugUWjZHbOy/P6w
	dhM5fy/9dClHkgQPvzCsVncMc2q8/xMNAQ==
X-Google-Smtp-Source: AGHT+IFvBeoX3hVlvDooVfe2u+wIWsX6+DvHzpN5Tf0Nuri0NxqVizvG8Brzn4wmqdHAthaKsGFo6VcGUwcM5w==
X-Received: from edumazet1.c.googlers.com ([fda3:e722:ac3:cc00:2b:7d90:c0a8:395a])
 (user=edumazet job=sendgmr) by 2002:a25:850c:0:b0:db5:48c5:302e with SMTP id
 w12-20020a25850c000000b00db548c5302emr26889ybk.4.1703167668637; Thu, 21 Dec
 2023 06:07:48 -0800 (PST)
Date: Thu, 21 Dec 2023 14:07:47 +0000
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
X-Mailer: git-send-email 2.43.0.472.g3155946c3a-goog
Message-ID: <20231221140747.1171134-1-edumazet@google.com>
Subject: [PATCH net-next] net-device: move gso_partial_features to net_device_read_tx
From: Eric Dumazet <edumazet@google.com>
To: "David S . Miller" <davem@davemloft.net>, Jakub Kicinski <kuba@kernel.org>, 
	Paolo Abeni <pabeni@redhat.com>
Cc: Willem de Bruijn <willemb@google.com>, netdev@vger.kernel.org, eric.dumazet@gmail.com, 
	Eric Dumazet <edumazet@google.com>, Coco Li <lixiaoyan@google.com>, 
	David Ahern <dsahern@kernel.org>
Content-Type: text/plain; charset="UTF-8"

dev->gso_partial_features is read from tx fast path for GSO packets.

Move it to appropriate section to avoid a cache line miss.

Fixes: 43a71cd66b9c ("net-device: reorganize net_device fast path variables")
Signed-off-by: Eric Dumazet <edumazet@google.com>
Cc: Coco Li <lixiaoyan@google.com>
Cc: David Ahern <dsahern@kernel.org>
---
 Documentation/networking/net_cachelines/net_device.rst | 2 +-
 include/linux/netdevice.h                              | 2 +-
 net/core/dev.c                                         | 3 ++-
 3 files changed, 4 insertions(+), 3 deletions(-)

diff --git a/Documentation/networking/net_cachelines/net_device.rst b/Documentation/networking/net_cachelines/net_device.rst
index 6cab1b797739f57f15962dc0daccc2bd6aafeb97..2dd8d8f20da2558fddcc341f3a8a27da3c4a1796 100644
--- a/Documentation/networking/net_cachelines/net_device.rst
+++ b/Documentation/networking/net_cachelines/net_device.rst
@@ -38,7 +38,7 @@ netdev_features_t                   wanted_features
 netdev_features_t                   vlan_features                                                   
 netdev_features_t                   hw_enc_features         -                   -                   netif_skb_features
 netdev_features_t                   mpls_features                                                   
-netdev_features_t                   gso_partial_features                                            
+netdev_features_t                   gso_partial_features    read_mostly                             gso_features_check
 unsigned_int                        min_mtu                                                         
 unsigned_int                        max_mtu                                                         
 unsigned_short                      type                                                            
diff --git a/include/linux/netdevice.h b/include/linux/netdevice.h
index 75c7725e5e4fdf59da55923cd803e084956b0fa0..5d1ec780122919c31e4215358d736aef3f8a0acd 100644
--- a/include/linux/netdevice.h
+++ b/include/linux/netdevice.h
@@ -2114,6 +2114,7 @@ struct net_device {
 	const struct net_device_ops *netdev_ops;
 	const struct header_ops *header_ops;
 	struct netdev_queue	*_tx;
+	netdev_features_t	gso_partial_features;
 	unsigned int		real_num_tx_queues;
 	unsigned int		gso_max_size;
 	unsigned int		gso_ipv4_max_size;
@@ -2210,7 +2211,6 @@ struct net_device {
 	netdev_features_t	vlan_features;
 	netdev_features_t	hw_enc_features;
 	netdev_features_t	mpls_features;
-	netdev_features_t	gso_partial_features;
 
 	unsigned int		min_mtu;
 	unsigned int		max_mtu;
diff --git a/net/core/dev.c b/net/core/dev.c
index b875040783209e95afb92217a0a07ede42a2e425..0e18a802252b35948dad5d739c07d4a06b466eb8 100644
--- a/net/core/dev.c
+++ b/net/core/dev.c
@@ -11623,6 +11623,7 @@ static void __init net_dev_struct_check(void)
 	CACHELINE_ASSERT_GROUP_MEMBER(struct net_device, net_device_read_tx, gso_max_size);
 	CACHELINE_ASSERT_GROUP_MEMBER(struct net_device, net_device_read_tx, gso_ipv4_max_size);
 	CACHELINE_ASSERT_GROUP_MEMBER(struct net_device, net_device_read_tx, gso_max_segs);
+	CACHELINE_ASSERT_GROUP_MEMBER(struct net_device, net_device_read_tx, gso_partial_features);
 	CACHELINE_ASSERT_GROUP_MEMBER(struct net_device, net_device_read_tx, num_tc);
 	CACHELINE_ASSERT_GROUP_MEMBER(struct net_device, net_device_read_tx, mtu);
 	CACHELINE_ASSERT_GROUP_MEMBER(struct net_device, net_device_read_tx, needed_headroom);
@@ -11636,7 +11637,7 @@ static void __init net_dev_struct_check(void)
 #ifdef CONFIG_NET_XGRESS
 	CACHELINE_ASSERT_GROUP_MEMBER(struct net_device, net_device_read_tx, tcx_egress);
 #endif
-	CACHELINE_ASSERT_GROUP_SIZE(struct net_device, net_device_read_tx, 152);
+	CACHELINE_ASSERT_GROUP_SIZE(struct net_device, net_device_read_tx, 160);
 
 	/* TXRX read-mostly hotpath */
 	CACHELINE_ASSERT_GROUP_MEMBER(struct net_device, net_device_read_txrx, flags);
-- 
2.43.0.472.g3155946c3a-goog


