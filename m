Return-Path: <netdev+bounces-251848-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id sM8pKfercGkgZAAAu9opvQ
	(envelope-from <netdev+bounces-251848-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Wed, 21 Jan 2026 11:35:35 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 1598F554BA
	for <lists+netdev@lfdr.de>; Wed, 21 Jan 2026 11:35:35 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id A3B918EB876
	for <lists+netdev@lfdr.de>; Wed, 21 Jan 2026 10:10:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5EB4B481659;
	Wed, 21 Jan 2026 10:05:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="YvQg4Y9C"
X-Original-To: netdev@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 72F3848AE03
	for <netdev@vger.kernel.org>; Wed, 21 Jan 2026 10:05:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768989958; cv=none; b=TLatLBq65BBICczillgIin8eHzSMnC00jtZU6p8ruEoCbUFtb00R/2QiDyhZ9ZFMSJsTVfTKmmc0XBd7dSJreTZjv0IRbobPcxEp3tVkVF/NyspGUrWESI3TAcvPTpo1WzV7gWnDoxwJLFaOg8/oq8mKtDY6y1ZJX/Dh95zbFuo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768989958; c=relaxed/simple;
	bh=HLtGUoPL/rgQLOb/PfGd4v1lPvfmcNVRyYMM9v/feGg=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=EnIWhc0jMeWhMQb00EXgWPV9KXSisueErmaqdmJxLSrsKZiSEVH5fxfRYhhLJfppOyXJzaqbhmBjk5OxLnmuer2naNf6Y7/aDkYMQBjHHTfAKBzqG0UYs82ECTSZgSfCNZIyWQLF5XvLF8xEkHYqAip4d3emitaqoXlyxG5vXBU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=YvQg4Y9C; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1768989955;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=5XL2GozqxzlQvhCqpE1KCqJ6tax3KDj/rsCAmdRq7/0=;
	b=YvQg4Y9Ci3mgjBZeA6i1h5Qy6VjvSQoEysyBXGLuyR6l/nmFmsXeeLoq5URzAyFgP85RlN
	xRQM18QGviVwK2Sp0mxyuz2uXJTsNX45nsLzoxsCHwrMOFNk4L6DUkFKbucT6wB4ckbpf8
	vSA+hGvb7eMnnW+fSHCzrzOr0RB/me8=
Received: from mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-13-QOfa-YANMWOSstassAVKtA-1; Wed,
 21 Jan 2026 05:05:49 -0500
X-MC-Unique: QOfa-YANMWOSstassAVKtA-1
X-Mimecast-MFC-AGG-ID: QOfa-YANMWOSstassAVKtA_1768989948
Received: from mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.93])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 6E08E195608E;
	Wed, 21 Jan 2026 10:05:48 +0000 (UTC)
Received: from xudu-thinkpadx1carbongen9.nay.csb (unknown [10.72.116.124])
	by mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP id 17A9C18004D8;
	Wed, 21 Jan 2026 10:05:43 +0000 (UTC)
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
Subject: [PATCH net-next v6 7/7] selftest: tun: Add test data for success and failure paths
Date: Wed, 21 Jan 2026 18:05:01 +0800
Message-ID: <5054f3ad9f3dbfe33b827183fccc5efeb8fd0da7.1768979440.git.xudu@redhat.com>
In-Reply-To: <cover.1768979440.git.xudu@redhat.com>
References: <cover.1768979440.git.xudu@redhat.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.93
X-Spamd-Result: default: False [-0.46 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_CONTAINS_FROM(1.00)[];
	DMARC_POLICY_ALLOW_WITH_FAILURES(-0.50)[];
	R_MISSING_CHARSET(0.50)[];
	R_DKIM_ALLOW(-0.20)[redhat.com:s=mimecast20190719];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	DMARC_POLICY_ALLOW(0.00)[redhat.com,quarantine];
	FROM_HAS_DN(0.00)[];
	TAGGED_FROM(0.00)[bounces-251848-lists,netdev=lfdr.de];
	R_SPF_SOFTFAIL(0.00)[~all:c];
	DKIM_TRACE(0.00)[redhat.com:+];
	RCVD_TLS_LAST(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	MISSING_XM_UA(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	TO_DN_NONE(0.00)[];
	RCVD_COUNT_FIVE(0.00)[6];
	FROM_NEQ_ENVFROM(0.00)[xudu@redhat.com,netdev@vger.kernel.org];
	RCPT_COUNT_SEVEN(0.00)[9];
	MIME_TRACE(0.00)[0:+];
	TAGGED_RCPT(0.00)[netdev];
	ASN(0.00)[asn:7979, ipnet:2605:f480::/32, country:US];
	DBL_BLOCKED_OPENRESOLVER(0.00)[dfw.mirrors.kernel.org:rdns,dfw.mirrors.kernel.org:helo]
X-Rspamd-Queue-Id: 1598F554BA
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

To improve the robustness and coverage of the TUN selftests, this
patch expands the set of test data.

Signed-off-by: Xu Du <xudu@redhat.com>
---
 tools/testing/selftests/net/tun.c | 115 +++++++++++++++++++++++++++++-
 1 file changed, 113 insertions(+), 2 deletions(-)

diff --git a/tools/testing/selftests/net/tun.c b/tools/testing/selftests/net/tun.c
index 628ae2caf6f4..8a5cd5cb5472 100644
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
 #define UDP_TUNNEL_GENEVE_4IN6 0x04
 #define UDP_TUNNEL_GENEVE_6IN6 0x08
 
+#define UDP_TUNNEL_MAX_SEGMENTS BIT(7)
+
 #define UDP_TUNNEL_OUTER_IPV4 (UDP_TUNNEL_GENEVE_4IN4 | UDP_TUNNEL_GENEVE_6IN4)
 #define UDP_TUNNEL_INNER_IPV4 (UDP_TUNNEL_GENEVE_4IN4 | UDP_TUNNEL_GENEVE_4IN6)
 
@@ -553,6 +559,39 @@ FIXTURE_VARIANT(tun_vnet_udptnl)
 
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
@@ -561,8 +600,65 @@ FIXTURE_VARIANT(tun_vnet_udptnl)
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
 
 TUN_VNET_UDPTNL_VARIANT_ADD(UDP_TUNNEL_GENEVE_4IN4, 4in4);
 TUN_VNET_UDPTNL_VARIANT_ADD(UDP_TUNNEL_GENEVE_6IN4, 6in4);
@@ -874,4 +970,19 @@ TEST_F(tun_vnet_udptnl, recv_gso_packet)
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
2.52.0


