Return-Path: <netdev+bounces-239031-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 1E9E7C62835
	for <lists+netdev@lfdr.de>; Mon, 17 Nov 2025 07:28:32 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id C09B04E2D79
	for <lists+netdev@lfdr.de>; Mon, 17 Nov 2025 06:26:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4EE43314D32;
	Mon, 17 Nov 2025 06:25:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="cWz0TYJG"
X-Original-To: netdev@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9C003315D40
	for <netdev@vger.kernel.org>; Mon, 17 Nov 2025 06:25:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763360752; cv=none; b=TFA9Oj1BR4RykT+ouvax1KVre/Czm8tK+5BFpzIlZ/OD3OBjEE6Sfh6839R8A+eS0B/Kc9GBm4kSZ0KUZRYcGI5LZq8Zt49301qVg/kon16FGq0BCUCl9t9koNlg7VoTR0qJFXR0jVomNWvi1RrHmLnYPJB0z/E0QsPrFON5rMc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763360752; c=relaxed/simple;
	bh=gAaA4sA9HQ2p+w5UTlLRZbtRM7kOojhouehu7i20ndo=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=MMDnOCm6ITlHXPEkX2KErNU/QgCxKBUeVsvRVBXmz0w7EtTXjVrdVbniCrgc6ZCGP0oCS/3651WRUmSAGx3GpNYdgUXC4dUShi3c8asd5Qa1r/Gil5bv+VCpVi53/kypkO5AiZLiyrY4l8ckpA/zupccN5kl61ncsmYEfZbGtQ4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=cWz0TYJG; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1763360749;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=IyFnb3kPkSYDN/hGaE/ujSf4Y/rgW6z/FdVrwOINlzU=;
	b=cWz0TYJGQn2Lv1K+PAp/+LOhcHzz0UBMJz7cTsmXiYLXlMKldw6xKJnIlF9TxStzgJIWt1
	Stq9sgGFnL2ErLcVHEOKlf1wsTEZy670aPiX1YQC4hbiNR0R2y4hUmJGrrTvWoN6nvzmjc
	6RhGmNazftkvROR9OkxHaUZHtQ2ir5I=
Received: from mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-417-gCLF6I9dMS2OtaSpGjNeqw-1; Mon,
 17 Nov 2025 01:25:45 -0500
X-MC-Unique: gCLF6I9dMS2OtaSpGjNeqw-1
X-Mimecast-MFC-AGG-ID: gCLF6I9dMS2OtaSpGjNeqw_1763360745
Received: from mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.17])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id DA441180047F;
	Mon, 17 Nov 2025 06:25:44 +0000 (UTC)
Received: from xudu-thinkpadx1carbongen9.nay.csb (unknown [10.72.116.141])
	by mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP id 3F59E195608E;
	Mon, 17 Nov 2025 06:25:41 +0000 (UTC)
From: xu du <xudu@redhat.com>
To: davem@davemloft.net,
	edumazet@google.com,
	kuba@kernel.org,
	pabeni@redhat.com
Cc: netdev@vger.kernel.org
Subject: [PATCH net-next 8/8] selftest: tun: Add test data for success and failure paths
Date: Mon, 17 Nov 2025 14:25:04 +0800
Message-ID: <e1ce1c1088ef29c0bab70d4906a7e24cd6b41626.1763345426.git.xudu@redhat.com>
In-Reply-To: <cover.1763345426.git.xudu@redhat.com>
References: <cover.1763345426.git.xudu@redhat.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.17

To improve the robustness and coverage of the TUN selftests, this
patch expands the set of test data.

Signed-off-by: xu du <xudu@redhat.com>
---
 tools/testing/selftests/net/tun.c | 115 +++++++++++++++++++++++++++++-
 1 file changed, 113 insertions(+), 2 deletions(-)

diff --git a/tools/testing/selftests/net/tun.c b/tools/testing/selftests/net/tun.c
index 19524748db44..7a2062f87c6a 100644
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
@@ -70,6 +74,8 @@ static struct in6_addr param_ipaddr6_inner_src = {
 #define UDP_TUNNEL_VXLAN_4IN6 0x04
 #define UDP_TUNNEL_VXLAN_6IN6 0x08
 
+#define UDP_TUNNEL_MAX_SEGMENTS BIT(7)
+
 #define UDP_TUNNEL_OUTER_IPV4 (UDP_TUNNEL_VXLAN_4IN4 | UDP_TUNNEL_VXLAN_6IN4)
 #define UDP_TUNNEL_INNER_IPV4 (UDP_TUNNEL_VXLAN_4IN4 | UDP_TUNNEL_VXLAN_4IN6)
 
@@ -527,6 +533,39 @@ FIXTURE_VARIANT(tun_vnet_udptnl)
 
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
@@ -535,8 +574,65 @@ FIXTURE_VARIANT(tun_vnet_udptnl)
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
@@ -860,4 +956,19 @@ TEST_F(tun_vnet_udptnl, recv_gso_packet)
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


