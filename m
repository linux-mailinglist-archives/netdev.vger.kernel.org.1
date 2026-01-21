Return-Path: <netdev+bounces-251846-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id qAKOJhiscGkgZAAAu9opvQ
	(envelope-from <netdev+bounces-251846-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Wed, 21 Jan 2026 11:36:08 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 2B093554E7
	for <lists+netdev@lfdr.de>; Wed, 21 Jan 2026 11:36:08 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 0DA56889728
	for <lists+netdev@lfdr.de>; Wed, 21 Jan 2026 10:09:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 81DF948164B;
	Wed, 21 Jan 2026 10:05:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="SG/yBWQ3"
X-Original-To: netdev@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D1A51481FDC
	for <netdev@vger.kernel.org>; Wed, 21 Jan 2026 10:05:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768989946; cv=none; b=DZyJmjyDAXPghmIuPx2w35yKimRKceTiS9JsxmVrj7+Cn73Ldc/a7zEI71/tulS97N/2Wywa+FgXRLvvXovnJaajm/2+b5sTWE2K0XMJUUnvvNGx9h+Wee8owzt3BgP+nv0moLH0c+H6dVNMxCcMGVWK7IViVIIMaD3KS9X0hlc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768989946; c=relaxed/simple;
	bh=YIjj8p88xswOjIMLr7gLxFIpv8gfxcKe7WDs7dQEI5o=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=ASIHivJqA+wMk0rV10JBhsinNJngTEO+bvZCTquN5m1/g44VWeKNNTUHGZ51brmynKGclmKEXIvrkMxAUJysuuGQHGYGxJUdvZaaE+sSYYfIc73OmyYch3QlXCmSudXrHGiy+SulWSg6PbxiSpSa+CdSiKNa06pXP+m7Iy8+lZw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=SG/yBWQ3; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1768989943;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=HjHbBns596A0PY7jXZNde0DLsbGoZFg3uEUoRR2OeSY=;
	b=SG/yBWQ3XbcAJ9Gq0FVhDZKtZAoSbPeGH8Q54A8apDoHjhoxlBdSw6Z77nC5OPPCbaodXf
	AQKluLIuNvWG/XyfbFJ4eKitpT37BfdyHmRWskger34TZrSAxhOydizp/fn3AHkGlgo7fV
	sO5rEs3HLpv2RGT6pK3g59RkIaN/8mo=
Received: from mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-343-khqJnk7uO7iu1KYcpABseA-1; Wed,
 21 Jan 2026 05:05:39 -0500
X-MC-Unique: khqJnk7uO7iu1KYcpABseA-1
X-Mimecast-MFC-AGG-ID: khqJnk7uO7iu1KYcpABseA_1768989938
Received: from mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.93])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 5346C19560A6;
	Wed, 21 Jan 2026 10:05:38 +0000 (UTC)
Received: from xudu-thinkpadx1carbongen9.nay.csb (unknown [10.72.116.124])
	by mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP id 22D081800665;
	Wed, 21 Jan 2026 10:05:32 +0000 (UTC)
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
Subject: [PATCH net-next v6 5/7] selftest: tun: Add test for sending gso packet into tun
Date: Wed, 21 Jan 2026 18:04:59 +0800
Message-ID: <a988dbc9ca109e4f1f0b33858c5035bce8ebede3.1768979440.git.xudu@redhat.com>
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
	TAGGED_FROM(0.00)[bounces-251846-lists,netdev=lfdr.de];
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
X-Rspamd-Queue-Id: 2B093554E7
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

The test constructs a raw packet, prepends a virtio_net_hdr,
and writes the result to the TUN device. This mimics the behavior
of a vm forwarding a guest's packet to the host networking stack.

Signed-off-by: Xu Du <xudu@redhat.com>
---
v4 -> v5:
 - Use Geneve instead of VXLAN due to missing YNL support.

v3 -> v4:
 - Expand the buffer to accommodate the maximum length of test packets.

v1 -> v2:
 - Correct spelling of 'recieve' to 'receive'.
 - Avoid busy waiting caused by recv() returning empty.

 tools/testing/selftests/net/tun.c | 144 ++++++++++++++++++++++++++++--
 1 file changed, 135 insertions(+), 9 deletions(-)

diff --git a/tools/testing/selftests/net/tun.c b/tools/testing/selftests/net/tun.c
index ec089355312b..f0ddb5d37683 100644
--- a/tools/testing/selftests/net/tun.c
+++ b/tools/testing/selftests/net/tun.c
@@ -75,7 +75,34 @@ static struct in6_addr param_ipaddr6_inner_src = {
 #define UDP_TUNNEL_OUTER_IPV4 (UDP_TUNNEL_GENEVE_4IN4 | UDP_TUNNEL_GENEVE_6IN4)
 #define UDP_TUNNEL_INNER_IPV4 (UDP_TUNNEL_GENEVE_4IN4 | UDP_TUNNEL_GENEVE_4IN6)
 
+#define UDP_TUNNEL_GENEVE_4IN4_HDRLEN                        \
+	(ETH_HLEN + 2 * sizeof(struct iphdr) + GENEVE_HLEN + \
+	 2 * sizeof(struct udphdr))
+#define UDP_TUNNEL_GENEVE_6IN6_HDRLEN                          \
+	(ETH_HLEN + 2 * sizeof(struct ipv6hdr) + GENEVE_HLEN + \
+	 2 * sizeof(struct udphdr))
+#define UDP_TUNNEL_GENEVE_4IN6_HDRLEN                               \
+	(ETH_HLEN + sizeof(struct iphdr) + sizeof(struct ipv6hdr) + \
+	 GENEVE_HLEN + 2 * sizeof(struct udphdr))
+#define UDP_TUNNEL_GENEVE_6IN4_HDRLEN                               \
+	(ETH_HLEN + sizeof(struct ipv6hdr) + sizeof(struct iphdr) + \
+	 GENEVE_HLEN + 2 * sizeof(struct udphdr))
+
+#define UDP_TUNNEL_HDRLEN(type)                                             \
+	((type) == UDP_TUNNEL_GENEVE_4IN4 ? UDP_TUNNEL_GENEVE_4IN4_HDRLEN : \
+	 (type) == UDP_TUNNEL_GENEVE_6IN6 ? UDP_TUNNEL_GENEVE_6IN6_HDRLEN : \
+	 (type) == UDP_TUNNEL_GENEVE_4IN6 ? UDP_TUNNEL_GENEVE_4IN6_HDRLEN : \
+	 (type) == UDP_TUNNEL_GENEVE_6IN4 ? UDP_TUNNEL_GENEVE_6IN4_HDRLEN : \
+					    0)
+
+#define UDP_TUNNEL_MSS(type) (ETH_DATA_LEN - UDP_TUNNEL_HDRLEN(type))
+#define UDP_TUNNEL_MAX(type, is_tap) \
+	(ETH_MAX_MTU - UDP_TUNNEL_HDRLEN(type) - ((is_tap) ? ETH_HLEN : 0))
+
 #define TUN_VNET_TNL_SIZE sizeof(struct virtio_net_hdr_v1_hash_tunnel)
+#define MAX_VNET_TUNNEL_PACKET_SZ                                       \
+	(TUN_VNET_TNL_SIZE + ETH_HLEN + UDP_TUNNEL_GENEVE_6IN6_HDRLEN + \
+	 ETH_MAX_MTU)
 
 struct geneve_setup_config {
 	int family;
@@ -408,15 +435,23 @@ FIXTURE(tun_vnet_udptnl)
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
 
 TUN_VNET_UDPTNL_VARIANT_ADD(UDP_TUNNEL_GENEVE_4IN4, 4in4);
@@ -544,14 +579,105 @@ FIXTURE_TEARDOWN(tun_vnet_udptnl)
 	EXPECT_EQ(ret, 0);
 }
 
-TEST_F(tun_vnet_udptnl, basic)
+static int build_gso_packet_into_tun(const FIXTURE_VARIANT(tun_vnet_udptnl) *
+					     variant,
+				     uint8_t *buf)
 {
-	int ret;
-	char cmd[256] = { 0 };
+	int pktlen, hlen, proto, inner_family, outer_family;
+	int tunnel_type = variant->tunnel_type;
+	int payload_len = variant->data_size;
+	int gso_size = variant->gso_size;
+	uint8_t *outer_udph, *cur = buf;
+	void *sip, *dip, *smac, *dmac;
+	bool is_tap = variant->is_tap;
 
-	sprintf(cmd, "ip addr show %s > /dev/null 2>&1", param_dev_geneve_name);
-	ret = system(cmd);
-	ASSERT_EQ(ret, 0);
+	hlen = (is_tap ? ETH_HLEN : 0) + UDP_TUNNEL_HDRLEN(tunnel_type);
+	inner_family = (tunnel_type & UDP_TUNNEL_INNER_IPV4) ? AF_INET :
+							       AF_INET6;
+	outer_family = (tunnel_type & UDP_TUNNEL_OUTER_IPV4) ? AF_INET :
+							       AF_INET6;
+
+	cur += build_virtio_net_hdr_v1_hash_tunnel(cur, is_tap, hlen, gso_size,
+						   outer_family, inner_family);
+
+	pktlen = hlen + payload_len;
+	assign_ifaddr_vars(outer_family, 1, &sip, &dip, &smac, &dmac);
+
+	if (is_tap) {
+		proto = outer_family == AF_INET ? ETH_P_IP : ETH_P_IPV6;
+		pktlen -= ETH_HLEN;
+		cur += build_eth(cur, proto, dmac, smac);
+	}
+
+	if (outer_family == AF_INET) {
+		pktlen = pktlen - sizeof(struct iphdr);
+		cur += build_ipv4_header(cur, IPPROTO_UDP, pktlen, dip, sip);
+	} else {
+		pktlen = pktlen - sizeof(struct ipv6hdr);
+		cur += build_ipv6_header(cur, IPPROTO_UDP, 0, pktlen, dip, sip);
+	}
+
+	outer_udph = cur;
+	assign_ifaddr_vars(inner_family, 0, &sip, &dip, &smac, &dmac);
+
+	pktlen -= sizeof(struct udphdr);
+	proto = inner_family == AF_INET ? ETH_P_IP : ETH_P_IPV6;
+	cur += build_udp_header(cur, UDP_SRC_PORT, VN_PORT, pktlen);
+	cur += build_geneve_header(cur, VN_ID);
+	cur += build_eth(cur, proto, dmac, smac);
+
+	pktlen = sizeof(struct udphdr) + payload_len;
+	if (inner_family == AF_INET)
+		cur += build_ipv4_header(cur, IPPROTO_UDP, pktlen, dip, sip);
+	else
+		cur += build_ipv6_header(cur, IPPROTO_UDP, 0, pktlen, dip, sip);
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
+receive_gso_packet_from_tunnel(FIXTURE_DATA(tun_vnet_udptnl) * self,
+			       const FIXTURE_VARIANT(tun_vnet_udptnl) * variant,
+			       int *r_num_mss)
+{
+	uint8_t packet_buf[MAX_VNET_TUNNEL_PACKET_SZ];
+	int len, total_len = 0, socket = self->sock;
+	int payload_len = variant->data_size;
+
+	while (total_len < payload_len) {
+		len = recv(socket, packet_buf, sizeof(packet_buf), 0);
+		if (len <= 0) {
+			if (len < 0 && errno != EAGAIN && errno != EWOULDBLOCK)
+				perror("recv");
+			break;
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
+	ret = receive_gso_packet_from_tunnel(self, variant, &r_num_mss);
+	ASSERT_EQ(ret, variant->data_size);
+	ASSERT_EQ(r_num_mss, variant->r_num_mss);
 }
 
 TEST_HARNESS_MAIN
-- 
2.52.0


