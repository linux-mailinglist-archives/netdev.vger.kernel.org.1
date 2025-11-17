Return-Path: <netdev+bounces-239029-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [IPv6:2a01:60a::1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id B129CC6282C
	for <lists+netdev@lfdr.de>; Mon, 17 Nov 2025 07:26:25 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id 344F9360074
	for <lists+netdev@lfdr.de>; Mon, 17 Nov 2025 06:26:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 34E9E31579B;
	Mon, 17 Nov 2025 06:25:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="Fr04KARk"
X-Original-To: netdev@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 646F7315D55
	for <netdev@vger.kernel.org>; Mon, 17 Nov 2025 06:25:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763360746; cv=none; b=TGk6oFyrvFSfoVSSlzpr0WqhKgP2BGMXP7YwqHI6Q/qia9KzY7khSZgxl7z7vXLLey85qOtkkDWJJmucT+spC6mJH4YaP+/cAzdhdU6ZaHyCO5VVxKUeCwdN76bSGkCPS2LVGUOHWpvDLw32PX/kEKOpeYVXPhExKW6IvEHwdQI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763360746; c=relaxed/simple;
	bh=4looNXpGLoSmtcZ5WlbX7y0DgDiuIWdO8s+ahMmrFWQ=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=TUyLIP0D2vY5X+bck22x6LjhDJAtuZ5q/b8a1y21/ODv13AXwhlwsc6GK41terFq9RsBRk1ORieudRS8SH7QUXPlRSxs39aQ5IkRh56HZPbsKyXKBj2R6RR2xi5lKqssUOHUd19UTHhMIqOcuc66ci8RinOfKQuujzq54mfNqvA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=Fr04KARk; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1763360743;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=7p/uN1NmdXMB1RvfnCsUt8vjTG2E3v92qcAJea3Mqiw=;
	b=Fr04KARkse1IyiGWHxExxPrnGCbTXb5cn81XzWRF2pRGZ93Hl9lT4rNhWLmANmqitFznBA
	QiLEb3YZGcFJnkmmGnsU7FW3PVnhG59erCp5T9QSM/CfBalqkyHLKNaNT/3zXG6h/1KI8i
	n3i8uhRnE6LFF9OUsYzwTSBKfvp/5cU=
Received: from mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-47-YsgJ-p4_MO2LYHx0QTMJvA-1; Mon,
 17 Nov 2025 01:25:39 -0500
X-MC-Unique: YsgJ-p4_MO2LYHx0QTMJvA-1
X-Mimecast-MFC-AGG-ID: YsgJ-p4_MO2LYHx0QTMJvA_1763360738
Received: from mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.17])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 01499195609D;
	Mon, 17 Nov 2025 06:25:38 +0000 (UTC)
Received: from xudu-thinkpadx1carbongen9.nay.csb (unknown [10.72.116.141])
	by mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP id 4F57A195608E;
	Mon, 17 Nov 2025 06:25:34 +0000 (UTC)
From: xu du <xudu@redhat.com>
To: davem@davemloft.net,
	edumazet@google.com,
	kuba@kernel.org,
	pabeni@redhat.com
Cc: netdev@vger.kernel.org
Subject: [PATCH net-next 6/8] selftest: tun: Add test for sending gso packet into tun
Date: Mon, 17 Nov 2025 14:25:02 +0800
Message-ID: <2a2666256b330348437cde92a6bff24ae70e2b46.1763345426.git.xudu@redhat.com>
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

The test constructs a raw packet, prepends a virtio_net_hdr,
and writes the result to the TUN device. This mimics the behavior
of a vm forwarding a guest's packet to the host networking stack.

Signed-off-by: xu du <xudu@redhat.com>
---
 tools/testing/selftests/net/tun.c | 149 ++++++++++++++++++++++++++++--
 1 file changed, 140 insertions(+), 9 deletions(-)

diff --git a/tools/testing/selftests/net/tun.c b/tools/testing/selftests/net/tun.c
index 8f0188ccb9fb..870697a0d9e8 100644
--- a/tools/testing/selftests/net/tun.c
+++ b/tools/testing/selftests/net/tun.c
@@ -75,6 +75,31 @@ static struct in6_addr param_ipaddr6_inner_src = {
 
 #define TUN_VNET_TNL_SIZE sizeof(struct virtio_net_hdr_v1_hash_tunnel)
 
+#define MAX_VNET_TUNNEL_PACKET_SZ (TUN_VNET_TNL_SIZE + ETH_HLEN + ETH_MAX_MTU)
+
+#define UDP_TUNNEL_VXLAN_4IN4_HDRLEN \
+	(ETH_HLEN + 2 * sizeof(struct iphdr) + 8 + 2 * sizeof(struct udphdr))
+#define UDP_TUNNEL_VXLAN_6IN6_HDRLEN \
+	(ETH_HLEN + 2 * sizeof(struct ipv6hdr) + 8 + 2 * sizeof(struct udphdr))
+#define UDP_TUNNEL_VXLAN_4IN6_HDRLEN                                    \
+	(ETH_HLEN + sizeof(struct iphdr) + sizeof(struct ipv6hdr) + 8 + \
+	 2 * sizeof(struct udphdr))
+#define UDP_TUNNEL_VXLAN_6IN4_HDRLEN                                    \
+	(ETH_HLEN + sizeof(struct ipv6hdr) + sizeof(struct iphdr) + 8 + \
+	 2 * sizeof(struct udphdr))
+
+#define UDP_TUNNEL_HDRLEN(type)                                           \
+	((type) == UDP_TUNNEL_VXLAN_4IN4 ? UDP_TUNNEL_VXLAN_4IN4_HDRLEN : \
+	 (type) == UDP_TUNNEL_VXLAN_6IN4 ? UDP_TUNNEL_VXLAN_6IN4_HDRLEN : \
+	 (type) == UDP_TUNNEL_VXLAN_4IN6 ? UDP_TUNNEL_VXLAN_4IN6_HDRLEN : \
+	 (type) == UDP_TUNNEL_VXLAN_6IN6 ? UDP_TUNNEL_VXLAN_6IN6_HDRLEN : \
+					   0)
+
+#define UDP_TUNNEL_MSS(type) (ETH_DATA_LEN - UDP_TUNNEL_HDRLEN(type))
+
+#define UDP_TUNNEL_MAX(type, is_tap) \
+	(ETH_MAX_MTU - UDP_TUNNEL_HDRLEN(type) - ((is_tap) ? ETH_HLEN : 0))
+
 union vxlan_addr {
 	struct sockaddr_in sin;
 	struct sockaddr_in6 sin6;
@@ -384,15 +409,23 @@ FIXTURE(tun_vnet_udptnl)
 FIXTURE_VARIANT(tun_vnet_udptnl)
 {
 	int tunnel_type;
-	bool is_tap;
+	int gso_size;
+	int data_size;
+	int r_num_mss;
+	bool is_tap, no_gso;
 };
 
 /* clang-format off */
 #define TUN_VNET_UDPTNL_VARIANT_ADD(type, desc)                              \
-	FIXTURE_VARIANT_ADD(tun_vnet_udptnl, desc##udptnl) {                 \
+	FIXTURE_VARIANT_ADD(tun_vnet_udptnl, desc##_1mss) {                  \
+		/* send a single MSS: fall back to no GSO */                 \
 		.tunnel_type = type,                                         \
+		.gso_size = UDP_TUNNEL_MSS(type),                            \
+		.data_size = UDP_TUNNEL_MSS(type),                           \
+		.r_num_mss = 1,                                              \
 		.is_tap = true,                                              \
-	}
+		.no_gso = true,                                              \
+	};
 /* clang-format on */
 
 TUN_VNET_UDPTNL_VARIANT_ADD(UDP_TUNNEL_VXLAN_4IN4, 4in4);
@@ -510,14 +543,112 @@ FIXTURE_TEARDOWN(tun_vnet_udptnl)
 	EXPECT_EQ(ret, 0);
 }
 
-TEST_F(tun_vnet_udptnl, basic)
+static int build_gso_packet_into_tun(const FIXTURE_VARIANT(tun_vnet_udptnl) *
+					     variant,
+				     uint8_t *buf)
 {
-	int ret;
-	char cmd[256] = { 0 };
+	int tunnel_type = variant->tunnel_type;
+	int payload_len = variant->data_size;
+	int gso_size = variant->gso_size;
+	int inner_family, outer_family;
+	bool is_tap = variant->is_tap;
+	uint8_t *outer_udph = NULL;
+	uint8_t *cur = buf;
+	int len, proto;
+
+	len = (is_tap ? ETH_HLEN : 0) + UDP_TUNNEL_HDRLEN(tunnel_type);
+	inner_family = (tunnel_type & UDP_TUNNEL_INNER_IPV4) ? AF_INET :
+							       AF_INET6;
+	outer_family = (tunnel_type & UDP_TUNNEL_OUTER_IPV4) ? AF_INET :
+							       AF_INET6;
+
+	cur += build_virtio_net_hdr_v1_hash_tunnel(cur, is_tap, len, gso_size,
+						   outer_family, inner_family);
+
+	if (is_tap) {
+		proto = outer_family == AF_INET ? ETH_P_IP : ETH_P_IPV6;
+		cur += build_eth(cur, proto, param_hwaddr_outer_dst,
+				 param_hwaddr_outer_src);
+		len -= ETH_HLEN;
+	}
 
-	sprintf(cmd, "ip addr show %s > /dev/null 2>&1", param_dev_vxlan_name);
-	ret = system(cmd);
-	ASSERT_EQ(ret, 0);
+	if (outer_family == AF_INET) {
+		len = len - sizeof(struct iphdr) + payload_len;
+		cur += build_ipv4_header(cur, IPPROTO_UDP, len,
+					 &param_ipaddr4_outer_dst,
+					 &param_ipaddr4_outer_src);
+	} else {
+		len = len - sizeof(struct ipv6hdr) + payload_len;
+		cur += build_ipv6_header(cur, IPPROTO_UDP, 0, len,
+					 &param_ipaddr6_outer_dst,
+					 &param_ipaddr6_outer_src);
+	}
+
+	outer_udph = cur;
+	len -= sizeof(struct udphdr);
+	proto = inner_family == AF_INET ? ETH_P_IP : ETH_P_IPV6;
+	cur += build_udp_header(cur, UDP_SRC_PORT, VN_PORT, len);
+	cur += build_vxlan_header(cur, VN_ID);
+	cur += build_eth(cur, proto, param_hwaddr_inner_dst,
+			 param_hwaddr_inner_src);
+
+	len = sizeof(struct udphdr) + payload_len;
+	if (inner_family == AF_INET) {
+		cur += build_ipv4_header(cur, IPPROTO_UDP, len,
+					 &param_ipaddr4_inner_dst,
+					 &param_ipaddr4_inner_src);
+	} else {
+		cur += build_ipv6_header(cur, IPPROTO_UDP, 0, len,
+					 &param_ipaddr6_inner_dst,
+					 &param_ipaddr6_inner_src);
+	}
+
+	cur += build_udp_packet(cur, UDP_DST_PORT, UDP_SRC_PORT, payload_len,
+				inner_family, false);
+
+	build_udp_packet_csum(outer_udph, outer_family, false);
+
+	return cur - buf;
+}
+
+static int
+recieve_gso_packet_from_tunnel(FIXTURE_DATA(tun_vnet_udptnl) * self,
+			       const FIXTURE_VARIANT(tun_vnet_udptnl) * variant,
+			       int *r_num_mss)
+{
+	uint8_t packet_buf[MAX_VNET_TUNNEL_PACKET_SZ];
+	int len, total_len = 0, socket = self->sock;
+	int payload_len = variant->data_size;
+
+	while (total_len < payload_len) {
+		len = recv(socket, packet_buf, sizeof(packet_buf), 0);
+		if (len < 0) {
+			if (errno != EAGAIN && errno != EWOULDBLOCK)
+				perror("recv");
+			return total_len;
+		}
+
+		(*r_num_mss)++;
+		total_len += len;
+	}
+
+	return total_len;
+}
+
+TEST_F(tun_vnet_udptnl, send_gso_packet)
+{
+	uint8_t pkt[MAX_VNET_TUNNEL_PACKET_SZ];
+	int r_num_mss = 0;
+	int ret, off;
+
+	memset(pkt, 0, sizeof(pkt));
+	off = build_gso_packet_into_tun(variant, pkt);
+	ret = write(self->fd, pkt, off);
+	ASSERT_EQ(ret, off);
+
+	ret = recieve_gso_packet_from_tunnel(self, variant, &r_num_mss);
+	ASSERT_EQ(ret, variant->data_size);
+	ASSERT_EQ(r_num_mss, variant->r_num_mss);
 }
 
 TEST_HARNESS_MAIN
-- 
2.49.0


