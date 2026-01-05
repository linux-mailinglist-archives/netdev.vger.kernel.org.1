Return-Path: <netdev+bounces-246870-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 5C548CF1C3A
	for <lists+netdev@lfdr.de>; Mon, 05 Jan 2026 04:51:25 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id C20633090A50
	for <lists+netdev@lfdr.de>; Mon,  5 Jan 2026 03:46:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 140ED322A28;
	Mon,  5 Jan 2026 03:45:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="aKSA6S3f"
X-Original-To: netdev@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 80A2B321428
	for <netdev@vger.kernel.org>; Mon,  5 Jan 2026 03:45:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1767584738; cv=none; b=CMh3IWlpGXkWrIZcLDeYa9tnMNIcPwC7tB6aSNayeHXkuc5Rj/AXJmIPJJa+cH9/PJyJJz1BWERQiJbU9T3MlK5sgduFvCGpKNEbz03A6LoGGpaPrp/k8Wm6ow/noMhCYvvMNARr9DB5zMd3a8FS16FM5woxJ4xZMeuxhmRgnms=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1767584738; c=relaxed/simple;
	bh=riJGbPocmScMhyWNFDAAT8g32Ex5OW4JQQni6EltDeM=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Q0veIjmjbApgTIzvG1uoEh9wCluO10eZYpPChW5VPJFKLCi0ga0U3ksoTNmFtZwZiCpg3r67n8QSI0OrMnSePy8aWaNDLULN5TRiPYrKQSO2q6Q6HGv4k+mDSjrSf+SyucOOtvEa7BpEP8Z5Mpt+w6ARxhw6smjACYxMbXSj4hc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=aKSA6S3f; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1767584735;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=NV/o1IadiRm0HWU7yBq7XT+X0hWIulEOgoL1ZQv6qPU=;
	b=aKSA6S3fMxa1bSPplT3QduMz/dDJ8Nx9clqlaaoR34Z8etl5SpyaTxdgamj4Q7rV9/Lniz
	SptysOEtbHouqa9JxrnzBX3u2OQ6PTPjQ9mfyOX6NOdp8LVFQBLP+vMMN2gI0qkQPo8d0s
	DHYMp72PdvUSSJLSyl8aQDWH/YpXmCs=
Received: from mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-32-gxDZRqo4PtO1bWiASHUyKw-1; Sun,
 04 Jan 2026 22:45:30 -0500
X-MC-Unique: gxDZRqo4PtO1bWiASHUyKw-1
X-Mimecast-MFC-AGG-ID: gxDZRqo4PtO1bWiASHUyKw_1767584729
Received: from mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.93])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id EE00B1800358;
	Mon,  5 Jan 2026 03:45:28 +0000 (UTC)
Received: from xudu-thinkpadx1carbongen9.nay.csb (unknown [10.66.60.72])
	by mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP id 179F51800367;
	Mon,  5 Jan 2026 03:45:24 +0000 (UTC)
From: Xu Du <xudu@redhat.com>
To: davem@davemloft.net,
	edumazet@google.com,
	kuba@kernel.org,
	pabeni@redhat.com,
	horms@kernel.org,
	shuah@kernel.org
Cc: netdev@vger.kernel.org,
	linux-kselftest@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH net-next v3 8/8] selftest: tun: Add test data for success and failure paths
Date: Mon,  5 Jan 2026 11:44:43 +0800
Message-ID: <581b50dfe7ecd936afe738514320095f51695f71.1767580224.git.xudu@redhat.com>
In-Reply-To: <cover.1767580224.git.xudu@redhat.com>
References: <cover.1767580224.git.xudu@redhat.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.93

To improve the robustness and coverage of the TUN selftests, this
patch expands the set of test data.

Signed-off-by: Xu Du <xudu@redhat.com>
---
 tools/testing/selftests/net/tun.c | 115 +++++++++++++++++++++++++++++-
 1 file changed, 113 insertions(+), 2 deletions(-)

diff --git a/tools/testing/selftests/net/tun.c b/tools/testing/selftests/net/tun.c
index 519aaffd6d1a..2322929b0194 100644
--- a/tools/testing/selftests/net/tun.c
+++ b/tools/testing/selftests/net/tun.c
@@ -57,6 +57,10 @@ static struct in6_addr param_ipaddr6_inner_src = {
 	{ { 0x20, 0x02, 0x0d, 0xb8, 0x02, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 2 } },
 };
 
+#ifndef BIT
+#define BIT(nr) (1UL << (nr))
+#endif
+
 #define VN_ID 1
 #define VN_PORT 4789
 #define UDP_SRC_PORT 22
@@ -72,6 +76,8 @@ static struct in6_addr param_ipaddr6_inner_src = {
 #define UDP_TUNNEL_VXLAN_4IN6 0x04
 #define UDP_TUNNEL_VXLAN_6IN6 0x08
 
+#define UDP_TUNNEL_MAX_SEGMENTS BIT(7)
+
 #define UDP_TUNNEL_OUTER_IPV4 (UDP_TUNNEL_VXLAN_4IN4 | UDP_TUNNEL_VXLAN_6IN4)
 #define UDP_TUNNEL_INNER_IPV4 (UDP_TUNNEL_VXLAN_4IN4 | UDP_TUNNEL_VXLAN_4IN6)
 
@@ -545,6 +551,39 @@ FIXTURE_VARIANT(tun_vnet_udptnl)
 
 /* clang-format off */
 #define TUN_VNET_UDPTNL_VARIANT_ADD(type, desc)                              \
+	FIXTURE_VARIANT_ADD(tun_vnet_udptnl, desc##_nogsosz_1byte) {         \
+		/* no GSO: send a single byte */                             \
+		.tunnel_type = type,                                         \
+		.data_size = 1,                                              \
+		.r_num_mss = 1,                                              \
+		.is_tap = true,                                              \
+		.no_gso = true,                                              \
+	};                                                                   \
+	FIXTURE_VARIANT_ADD(tun_vnet_udptnl, desc##_nogsosz_1mss) {          \
+		/* no GSO: send a single MSS, fall back to no GSO */         \
+		.tunnel_type = type,                                         \
+		.data_size = UDP_TUNNEL_MSS(type),                           \
+		.r_num_mss = 1,                                              \
+		.is_tap = true,                                              \
+		.no_gso = true,                                              \
+	};                                                                   \
+	FIXTURE_VARIANT_ADD(tun_vnet_udptnl, desc##_nogsosz_gtmss) {         \
+		/* no GSO: send a single MSS + 1B: fail */                   \
+		.tunnel_type = type,                                         \
+		.data_size = UDP_TUNNEL_MSS(type) + 1,                       \
+		.r_num_mss = 1,                                              \
+		.is_tap = true,                                              \
+		.no_gso = true,                                              \
+	};                                                                   \
+	FIXTURE_VARIANT_ADD(tun_vnet_udptnl, desc##_1byte) {                 \
+		/* GSO: send 1 byte, gso 1 byte, fall back to no GSO */      \
+		.tunnel_type = type,                                         \
+		.gso_size = 1,                                               \
+		.data_size = 1,                                              \
+		.r_num_mss = 1,                                              \
+		.is_tap = true,                                              \
+		.no_gso = true,                                              \
+	};                                                                   \
 	FIXTURE_VARIANT_ADD(tun_vnet_udptnl, desc##_1mss) {                  \
 		/* send a single MSS: fall back to no GSO */                 \
 		.tunnel_type = type,                                         \
@@ -553,8 +592,65 @@ FIXTURE_VARIANT(tun_vnet_udptnl)
 		.r_num_mss = 1,                                              \
 		.is_tap = true,                                              \
 		.no_gso = true,                                              \
-	};
-/* clang-format on */
+	};                                                                   \
+	FIXTURE_VARIANT_ADD(tun_vnet_udptnl, desc##_ltgso) {                 \
+		/* data <= MSS < gso: will fall back to no GSO */            \
+		.tunnel_type = type,                                         \
+		.gso_size = UDP_TUNNEL_MSS(type) + 1,                        \
+		.data_size = UDP_TUNNEL_MSS(type),                           \
+		.r_num_mss = 1,                                              \
+		.is_tap = true,                                              \
+		.no_gso = true,                                              \
+	};                                                                   \
+	FIXTURE_VARIANT_ADD(tun_vnet_udptnl, desc##_gtgso) {                 \
+		/* GSO: a single MSS + 1B */                                 \
+		.tunnel_type = type,                                         \
+		.gso_size = UDP_TUNNEL_MSS(type),                            \
+		.data_size = UDP_TUNNEL_MSS(type) + 1,                       \
+		.r_num_mss = 2,                                              \
+		.is_tap = true,                                              \
+	};                                                                   \
+	FIXTURE_VARIANT_ADD(tun_vnet_udptnl, desc##_2mss) {                  \
+		/* no GSO: send exactly 2 MSS */                             \
+		.tunnel_type = type,                                         \
+		.gso_size = UDP_TUNNEL_MSS(type),                            \
+		.data_size = UDP_TUNNEL_MSS(type) * 2,                       \
+		.r_num_mss = 2,                                              \
+		.is_tap = true,                                              \
+	};                                                                   \
+	FIXTURE_VARIANT_ADD(tun_vnet_udptnl, desc##_maxbytes) {              \
+		/* GSO: send max bytes */                                    \
+		.tunnel_type = type,                                         \
+		.gso_size = UDP_TUNNEL_MSS(type),                            \
+		.data_size = UDP_TUNNEL_MAX(type, true),                     \
+		.r_num_mss = UDP_TUNNEL_MAX(type, true) /                    \
+			     UDP_TUNNEL_MSS(type) + 1,                       \
+		.is_tap = true,                                              \
+	};                                                                   \
+	FIXTURE_VARIANT_ADD(tun_vnet_udptnl, desc##_over_maxbytes) {         \
+		/* GSO: send oversize max bytes: fail */                     \
+		.tunnel_type = type,                                         \
+		.gso_size = UDP_TUNNEL_MSS(type),                            \
+		.data_size = ETH_MAX_MTU,                                    \
+		.r_num_mss = ETH_MAX_MTU / UDP_TUNNEL_MSS(type) + 1,         \
+		.is_tap = true,                                              \
+	};                                                                   \
+	FIXTURE_VARIANT_ADD(tun_vnet_udptnl, desc##_maxsegs) {               \
+		/* GSO: send max number of min sized segments */             \
+		.tunnel_type = type,                                         \
+		.gso_size = 1,                                               \
+		.data_size = UDP_TUNNEL_MAX_SEGMENTS,                        \
+		.r_num_mss = UDP_TUNNEL_MAX_SEGMENTS,                        \
+		.is_tap = true,                                              \
+	};                                                                   \
+	FIXTURE_VARIANT_ADD(tun_vnet_udptnl, desc##_5byte) {                 \
+		/* GSO: send 5 bytes, gso 2 bytes */                         \
+		.tunnel_type = type,                                         \
+		.gso_size = 2,                                               \
+		.data_size = 5,                                              \
+		.r_num_mss = 3,                                              \
+		.is_tap = true,                                              \
+	} /* clang-format on */
 
 TUN_VNET_UDPTNL_VARIANT_ADD(UDP_TUNNEL_VXLAN_4IN4, 4in4);
 TUN_VNET_UDPTNL_VARIANT_ADD(UDP_TUNNEL_VXLAN_6IN4, 6in4);
@@ -893,4 +989,19 @@ TEST_F(tun_vnet_udptnl, recv_gso_packet)
 	}
 }
 
+XFAIL_ADD(tun_vnet_udptnl, 4in4_nogsosz_gtmss, recv_gso_packet);
+XFAIL_ADD(tun_vnet_udptnl, 6in4_nogsosz_gtmss, recv_gso_packet);
+XFAIL_ADD(tun_vnet_udptnl, 4in6_nogsosz_gtmss, recv_gso_packet);
+XFAIL_ADD(tun_vnet_udptnl, 6in6_nogsosz_gtmss, recv_gso_packet);
+
+XFAIL_ADD(tun_vnet_udptnl, 4in4_over_maxbytes, send_gso_packet);
+XFAIL_ADD(tun_vnet_udptnl, 6in4_over_maxbytes, send_gso_packet);
+XFAIL_ADD(tun_vnet_udptnl, 4in6_over_maxbytes, send_gso_packet);
+XFAIL_ADD(tun_vnet_udptnl, 6in6_over_maxbytes, send_gso_packet);
+
+XFAIL_ADD(tun_vnet_udptnl, 4in4_over_maxbytes, recv_gso_packet);
+XFAIL_ADD(tun_vnet_udptnl, 6in4_over_maxbytes, recv_gso_packet);
+XFAIL_ADD(tun_vnet_udptnl, 4in6_over_maxbytes, recv_gso_packet);
+XFAIL_ADD(tun_vnet_udptnl, 6in6_over_maxbytes, recv_gso_packet);
+
 TEST_HARNESS_MAIN
-- 
2.49.0


