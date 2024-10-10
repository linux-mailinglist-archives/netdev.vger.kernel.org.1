Return-Path: <netdev+bounces-134044-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 9A9EB997B61
	for <lists+netdev@lfdr.de>; Thu, 10 Oct 2024 05:41:09 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 3DA98280E2A
	for <lists+netdev@lfdr.de>; Thu, 10 Oct 2024 03:41:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5FAD518E75A;
	Thu, 10 Oct 2024 03:41:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="UdpY1XkR"
X-Original-To: netdev@vger.kernel.org
Received: from mail-yw1-f202.google.com (mail-yw1-f202.google.com [209.85.128.202])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C7CB629CEC
	for <netdev@vger.kernel.org>; Thu, 10 Oct 2024 03:41:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.202
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728531665; cv=none; b=JexEGn/5XRjgxJpCA6EKruBw2ySX8YECORvMw7QSZPstSObdaPOKpfiyEVjzPiq7uxei8Cgr8Aaxg7C1zjqDIkb/zQfQ1y4FH4/Fc1SLt5Uxxpw0/x5YOEXvnh60FDae8QoV8c2DQxf/FxewetlISWktF+UBveuV/3sXqupSDLs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728531665; c=relaxed/simple;
	bh=mBEDgrLP2tWZj5ILUX+0vgUbEy3M2qrjpjS3nGLcDTg=;
	h=Date:Mime-Version:Message-ID:Subject:From:To:Cc:Content-Type; b=PCf6XfbFh2Z8tioNql02DYuT7e32A5Y2amRkaZ4WOdzjy6eQHFICv65u7DZxQ9UdvHqEJKamqfYPn9IGctNfjxJlyDt5XTWdHNpuBGE5dzW056Lm0kYElYNpXurNTntYMZ/BdlgnM3mL1Fqcvo5qug+zmPnFYUxb3yCbOtH+nkM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--edumazet.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=UdpY1XkR; arc=none smtp.client-ip=209.85.128.202
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--edumazet.bounces.google.com
Received: by mail-yw1-f202.google.com with SMTP id 00721157ae682-6e3245ed6b8so12070397b3.0
        for <netdev@vger.kernel.org>; Wed, 09 Oct 2024 20:41:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1728531663; x=1729136463; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:mime-version:date:from:to:cc:subject
         :date:message-id:reply-to;
        bh=JZVFCJIP70Zwf5bErSNvOADUTV81ptKaon8/wmS6DsI=;
        b=UdpY1XkRbGOV21L+PZqAmExKiMBT0wdL3D2DQos5YGykkKfGl08hUSQInaPGW08jxT
         0LdA8h+Y2Ec+tknRVubw9AXnTNF8qLwAMocsUyouvNg+Bv+fqH4YltZKwX669Ik472Q8
         HdauffKhnbe4GagTPtNq5fA/77dU16RNeiojvGDvpXv0qUWrs2daWQuVixhPg6YoKWTk
         KN0XY3t+ZcOoJ0Pd2PyJKxnpB/0YFHUD1Oec8eA19YPlth9nxx9LbwjEZq2KQ8xjqdey
         rJqGWcqH8GA/0Xo3Xa51/F1IgU1AceUb2vmyyRR5vhhHdKPohdTt8oHIDWsKleZYxLEk
         ag/g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1728531663; x=1729136463;
        h=cc:to:from:subject:message-id:mime-version:date:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=JZVFCJIP70Zwf5bErSNvOADUTV81ptKaon8/wmS6DsI=;
        b=WxPWtJQ4PWXsk1whRj65ffrI02oEKnuEhDUznmv8TnvQNeenaBhUN1YmTS1kNjKPeY
         RHOqfwtGWWdXrETxqZXfb32naJB+i2chbhZgDSOHsQdABBbeTxrylt8F4r7pVylW6wUL
         wfz4z6BtF26juQrmV4oicLH7vz3hGM8Zfh2VOTkJrk/QtOfEzToHXw90EK/f2OwQo2sC
         mLKOhelIMDS5jbaGuayW8BgAN0CCKmeSWqhQak6ismcdSkD7Axv5XhxQmU0vR1OVcdAf
         XsekilLD7TrJDJsaUZVobRev0sqva+qanXtDJ/VsuahrVukxrhKKIotoSxkLAUaSCL9U
         oFtQ==
X-Gm-Message-State: AOJu0Yyjqooige61S5kWb+/eYZ4jqE4LrLSaZCTEdN3lU7h+CSHo+ldf
	WJhlfFM009AOKO6cJ1eySXMt93VIFltZehwjzMx51KQ1JmG47f9G8naHbzwfPQNBbDHt7ZsfdxS
	HXbFr/TuVDQ==
X-Google-Smtp-Source: AGHT+IHcIXLDQkSoVRCaYXhz0xFhOoIwiIL8hUT+Y1haPNwJB1aFchkSNfBaChzeCKoR5/NTCDKvzyJ6I1itoA==
X-Received: from edumazet1.c.googlers.com ([fda3:e722:ac3:cc00:f7:ea0b:ac12:11d6])
 (user=edumazet job=sendgmr) by 2002:a05:690c:450c:b0:6db:c34f:9e4f with SMTP
 id 00721157ae682-6e3224dec7emr1400387b3.8.1728531662777; Wed, 09 Oct 2024
 20:41:02 -0700 (PDT)
Date: Thu, 10 Oct 2024 03:41:00 +0000
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
X-Mailer: git-send-email 2.47.0.rc0.187.ge670bccf7e-goog
Message-ID: <20241010034100.320832-1-edumazet@google.com>
Subject: [PATCH v2 net-next] tcp: move sysctl_tcp_l3mdev_accept to netns_ipv4_read_rx
From: Eric Dumazet <edumazet@google.com>
To: "David S . Miller" <davem@davemloft.net>, Jakub Kicinski <kuba@kernel.org>, 
	Paolo Abeni <pabeni@redhat.com>
Cc: netdev@vger.kernel.org, eric.dumazet@gmail.com, 
	Eric Dumazet <edumazet@google.com>, David Ahern <dsahern@kernel.org>, Wei Wang <weiwan@google.com>, 
	Coco Li <lixiaoyan@google.com>
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
Reviewed-by: David Ahern <dsahern@kernel.org>
Cc: Wei Wang <weiwan@google.com>
Cc: Coco Li <lixiaoyan@google.com>
---
v2 : rebase on latest net-next

 .../networking/net_cachelines/netns_ipv4_sysctl.rst          | 2 +-
 include/net/netns/ipv4.h                                     | 5 ++---
 net/core/net_namespace.c                                     | 4 +++-
 3 files changed, 6 insertions(+), 5 deletions(-)

diff --git a/Documentation/networking/net_cachelines/netns_ipv4_sysctl.rst b/Documentation/networking/net_cachelines/netns_ipv4_sysctl.rst
index 392e08a6ec046bc3f99f8f2416e71a6c8f78b091..629da6dc6d746ce8058cfbe2215d33d55ca4c19d 100644
--- a/Documentation/networking/net_cachelines/netns_ipv4_sysctl.rst
+++ b/Documentation/networking/net_cachelines/netns_ipv4_sysctl.rst
@@ -59,7 +59,7 @@ u8                              sysctl_udp_early_demux
 u8                              sysctl_nexthop_compat_mode
 u8                              sysctl_fwmark_reflect
 u8                              sysctl_tcp_fwmark_accept
-u8                              sysctl_tcp_l3mdev_accept
+u8                              sysctl_tcp_l3mdev_accept                                         read_mostly         __inet6_lookup_established/inet_request_bound_dev_if
 u8                              sysctl_tcp_mtu_probing
 int                             sysctl_tcp_mtu_probe_floor
 int                             sysctl_tcp_base_mss
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


