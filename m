Return-Path: <netdev+bounces-133753-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 9E471996F5D
	for <lists+netdev@lfdr.de>; Wed,  9 Oct 2024 17:14:08 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id C8DBFB22A87
	for <lists+netdev@lfdr.de>; Wed,  9 Oct 2024 15:14:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 914931E1A08;
	Wed,  9 Oct 2024 15:05:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="OhWnPVmQ"
X-Original-To: netdev@vger.kernel.org
Received: from mail-yw1-f202.google.com (mail-yw1-f202.google.com [209.85.128.202])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F1A5D1E104F
	for <netdev@vger.kernel.org>; Wed,  9 Oct 2024 15:05:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.202
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728486311; cv=none; b=l+8W8xxZc4hVbU94sPzc+gnY1E3vJv4mxc3o0GZRhVuku4ewKq9UWLMjJaHCVzuj1H1+eZUoi/pehO6VdCAy419HAyMC421JK7dqPL9W23v43frr3sOtvPuccL41Z+rUrZTGMHRLKrEPyL772KmJtOr1DZhIa2o+OY5z8wOLQYI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728486311; c=relaxed/simple;
	bh=JoziAmfLurZf1irmSz9RdqM3egsJYeOZG3BdDq82Kuc=;
	h=Date:Mime-Version:Message-ID:Subject:From:To:Cc:Content-Type; b=sfhKM2wVklH5n0u3OPsFlAHCTaOB7fIIPQU7v9/IFfJJGXRjhD0Omqar21qYD+ou1WEBuDANd7uFqyxHWHohs8J0jpx+U8LNj1UJDNa4VOCxAExk0GHWjYEd+EvK0PEllKwe2S0LmAySMjZ32gSlVYQDaY2BY6pqNaHt5eQY2dU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--edumazet.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=OhWnPVmQ; arc=none smtp.client-ip=209.85.128.202
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--edumazet.bounces.google.com
Received: by mail-yw1-f202.google.com with SMTP id 00721157ae682-6e22f8dc491so118962467b3.1
        for <netdev@vger.kernel.org>; Wed, 09 Oct 2024 08:05:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1728486309; x=1729091109; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:mime-version:date:from:to:cc:subject
         :date:message-id:reply-to;
        bh=RNk0Yy2Dh2od6LIXP+aNNUI8kMbNRe4FzprlmuNJ1j0=;
        b=OhWnPVmQv9FUgXbl0t2VumI0mmpm0u+aJsPZbWCIWqdablTVWPCH84yYI8Ss6DFnUl
         5i7lXBqDCEhL9YdEvFRwYWVTWZ+oScDOsDIy9LHWcmwRqGJ7Y+Ybx+5znarvahMfghFX
         K/y7HoAV5cNZdAlkStkblte3ayzclDETWKvRThw4RXblXFhgAU6nBuFeDHkzDkSB0eGe
         Y+S3PAVp2FjTfW5JFB50q57wWrkAqv0BpQ9RQQaQuJp/iuP5ZVXl6Fso5KWNwbyAzJIx
         9tCbnacSFcJLvYiYQ3oDLMujcK2wcVwa+EVmqR51aoi19ds5sxlyVsvXKJkLd3dVFprv
         EAFw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1728486309; x=1729091109;
        h=cc:to:from:subject:message-id:mime-version:date:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=RNk0Yy2Dh2od6LIXP+aNNUI8kMbNRe4FzprlmuNJ1j0=;
        b=Ykcy0MH27vP7cw5Psu8n+9HwDNwbI1b4ZRlA/meNr5x58rERK14ShQh/pdFnFpQuVo
         ezvJ/UQLm+27q5SApR0kdioqmNnXIHGllwBcmKi7Po6aQvkCtftebTuuMa6ZGVtTaX3f
         pLmN5DB6YZWCrIX0uuElN+OZdje8vFYuA1N/62HKfRMCtrmeMlKDQGYuJZRlDBbH+JSb
         xEq4prcP8QGEXmLr7aI504sfeyja6QJvGe+jpRMzCTIvWyQN9iSCymjAfpTK6K1JgXGT
         xXd8dH6pmPAmGgUyQjW1weKnoOs0Yk8iEsmq8Fm5ftMsmyPy/3sjzF8a+tvcMbpfEYd9
         EeRg==
X-Forwarded-Encrypted: i=1; AJvYcCVDWxEgPAUfD/VDsX5PdkyC/updYqANd8VACtp0zhbp2IHbSk0XCIPyGPLW/rITilxvxt7l9zI=@vger.kernel.org
X-Gm-Message-State: AOJu0YyYOIu6xrQFz170Spfq2nHS1RAptnw4dY8qMgxnPG6CpEYc0L6T
	m0zuiFEy3foSiyzB3asblaS7bA3opFKYGtpusGpXmdxQllh3msmw6sLWMp4oA/RtlIjO/64lVQ6
	9QhcuJ+ogHw==
X-Google-Smtp-Source: AGHT+IHqGGOnNpln7tvaqCKnhK91ZR4IMRUYSNrDmKocZXhc6iyTJOmXGNdQcL9ecL7Sn/x0u41Rn8RgYOrOaA==
X-Received: from edumazet1.c.googlers.com ([fda3:e722:ac3:cc00:f7:ea0b:ac12:11d6])
 (user=edumazet job=sendgmr) by 2002:a25:103:0:b0:e28:f6f6:81a5 with SMTP id
 3f1490d57ef6-e28fe347af5mr2229276.0.1728486308982; Wed, 09 Oct 2024 08:05:08
 -0700 (PDT)
Date: Wed,  9 Oct 2024 15:05:04 +0000
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
X-Mailer: git-send-email 2.47.0.rc0.187.ge670bccf7e-goog
Message-ID: <20241009150504.2871093-1-edumazet@google.com>
Subject: [PATCH net-next] tcp: move sysctl_tcp_l3mdev_accept to netns_ipv4_read_rx
From: Eric Dumazet <edumazet@google.com>
To: "David S . Miller" <davem@davemloft.net>, Jakub Kicinski <kuba@kernel.org>, 
	Paolo Abeni <pabeni@redhat.com>
Cc: David Ahern <dsahern@kernel.org>, netdev@vger.kernel.org, eric.dumazet@gmail.com, 
	Eric Dumazet <edumazet@google.com>, Wei Wang <weiwan@google.com>, Coco Li <lixiaoyan@google.com>
Content-Type: text/plain; charset="UTF-8"

sysctl_tcp_l3mdev_accept is read from TCP receive fast path from
tcp_v6_early_demux(),
 __inet6_lookup_established,
  inet_request_bound_dev_if().

Move it to netns_ipv4_read_rx.

Remove the '#ifdef CONFIG_NET_L3_MASTER_DEV' that was guarding
its definition.

Note this adds a hole of three bytes that could be filled later.

Fixes: 18fd64d25422 ("netns-ipv4: reorganize netns_ipv4 fast path variables")
Signed-off-by: Eric Dumazet <edumazet@google.com>
Cc: Wei Wang <weiwan@google.com>
Cc: Coco Li <lixiaoyan@google.com>
---
 .../networking/net_cachelines/netns_ipv4_sysctl.rst          | 2 +-
 include/net/netns/ipv4.h                                     | 5 ++---
 net/core/net_namespace.c                                     | 4 +++-
 3 files changed, 6 insertions(+), 5 deletions(-)

diff --git a/Documentation/networking/net_cachelines/netns_ipv4_sysctl.rst b/Documentation/networking/net_cachelines/netns_ipv4_sysctl.rst
index 9b87089a84c61eddaa4e048da6cbb68c5e934ad6..b9855d95fc0d189db65aebae92564336ddeae7bd 100644
--- a/Documentation/networking/net_cachelines/netns_ipv4_sysctl.rst
+++ b/Documentation/networking/net_cachelines/netns_ipv4_sysctl.rst
@@ -58,7 +58,7 @@ u8                              sysctl_udp_early_demux
 u8                              sysctl_nexthop_compat_mode                   -                   -                   
 u8                              sysctl_fwmark_reflect                        -                   -                   
 u8                              sysctl_tcp_fwmark_accept                     -                   -                   
-u8                              sysctl_tcp_l3mdev_accept                     -                   -                   
+u8                              sysctl_tcp_l3mdev_accept                     -                   read_mostly         __inet6_lookup_established/inet_request_bound_dev_if
 u8                              sysctl_tcp_mtu_probing                       -                   -                   
 int                             sysctl_tcp_mtu_probe_floor                   -                   -                   
 int                             sysctl_tcp_base_mss                          -                   -                   
diff --git a/include/net/netns/ipv4.h b/include/net/netns/ipv4.h
index 276f622f3516871c438be27bafe61c039445b335..42866649901e36fbdd4e9f55645b22bdb6f86891 100644
--- a/include/net/netns/ipv4.h
+++ b/include/net/netns/ipv4.h
@@ -76,6 +76,8 @@ struct netns_ipv4 {
 	__cacheline_group_begin(netns_ipv4_read_rx);
 	u8 sysctl_ip_early_demux;
 	u8 sysctl_tcp_early_demux;
+	u8 sysctl_tcp_l3mdev_accept;
+	/* 3 bytes hole, try to pack */
 	int sysctl_tcp_reordering;
 	int sysctl_tcp_rmem[3];
 	__cacheline_group_end(netns_ipv4_read_rx);
@@ -151,9 +153,6 @@ struct netns_ipv4 {
 
 	u8 sysctl_fwmark_reflect;
 	u8 sysctl_tcp_fwmark_accept;
-#ifdef CONFIG_NET_L3_MASTER_DEV
-	u8 sysctl_tcp_l3mdev_accept;
-#endif
 	u8 sysctl_tcp_mtu_probing;
 	int sysctl_tcp_mtu_probe_floor;
 	int sysctl_tcp_base_mss;
diff --git a/net/core/net_namespace.c b/net/core/net_namespace.c
index a5bc1fd8b0341f401b6b48ea7c26b2ac07d1ddb6..0a86aff17f512bbeaa2795ab56748d8bb3b3fb71 100644
--- a/net/core/net_namespace.c
+++ b/net/core/net_namespace.c
@@ -1159,11 +1159,13 @@ static void __init netns_ipv4_struct_check(void)
 				      sysctl_ip_early_demux);
 	CACHELINE_ASSERT_GROUP_MEMBER(struct netns_ipv4, netns_ipv4_read_rx,
 				      sysctl_tcp_early_demux);
+	CACHELINE_ASSERT_GROUP_MEMBER(struct netns_ipv4, netns_ipv4_read_rx,
+				      sysctl_tcp_l3mdev_accept);
 	CACHELINE_ASSERT_GROUP_MEMBER(struct netns_ipv4, netns_ipv4_read_rx,
 				      sysctl_tcp_reordering);
 	CACHELINE_ASSERT_GROUP_MEMBER(struct netns_ipv4, netns_ipv4_read_rx,
 				      sysctl_tcp_rmem);
-	CACHELINE_ASSERT_GROUP_SIZE(struct netns_ipv4, netns_ipv4_read_rx, 18);
+	CACHELINE_ASSERT_GROUP_SIZE(struct netns_ipv4, netns_ipv4_read_rx, 22);
 }
 #endif
 
-- 
2.47.0.rc0.187.ge670bccf7e-goog


