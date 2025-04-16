Return-Path: <netdev+bounces-183377-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 31941A9087D
	for <lists+netdev@lfdr.de>; Wed, 16 Apr 2025 18:16:03 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 5D81619E0B4B
	for <lists+netdev@lfdr.de>; Wed, 16 Apr 2025 16:16:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 94A92215044;
	Wed, 16 Apr 2025 16:14:52 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from metis.whiteo.stw.pengutronix.de (metis.whiteo.stw.pengutronix.de [185.203.201.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8C13F211A24
	for <netdev@vger.kernel.org>; Wed, 16 Apr 2025 16:14:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.203.201.7
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744820092; cv=none; b=ec99nMasgmzCfa6/ZJ4lAajBaKPDswMwt5suIDaH6t8Kr5l8tCrS5uPkTJ0CCo27KQwI5N3h3wrgEwGaqnlTdo3hCVvXzEUS3U9SmcU3pLoneSb7C0Aev6kYwoys8E5m00/FofLlLSERvpK2Dny94EuxmocW1RrCD+qFVrPNU0I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744820092; c=relaxed/simple;
	bh=lVi5qcUYCb6GCjGsEfgk84V0wF5w6QFo0FtxiPgItJ4=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version:Content-Type; b=ROavxaWtNB54ko/T8riCkuEEokg6SuTqGbe+goCxuumn8OE7HwJKr1LpdarUAHW3pblkj51EAHjzRYV7g8frk5CV7UcqryPV+j7s7WIjbsD+js51yUO6A/VE80uzsDAdeREhFnWdtlq4OtRdy9UpTFmj0wOwblbfw8TnPAK+WyU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de; spf=pass smtp.mailfrom=pengutronix.de; arc=none smtp.client-ip=185.203.201.7
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pengutronix.de
Received: from drehscheibe.grey.stw.pengutronix.de ([2a0a:edc0:0:c01:1d::a2])
	by metis.whiteo.stw.pengutronix.de with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
	(Exim 4.92)
	(envelope-from <ore@pengutronix.de>)
	id 1u55PN-0002G2-D7; Wed, 16 Apr 2025 18:14:41 +0200
Received: from dude04.red.stw.pengutronix.de ([2a0a:edc0:0:1101:1d::ac])
	by drehscheibe.grey.stw.pengutronix.de with esmtps  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.96)
	(envelope-from <ore@pengutronix.de>)
	id 1u55PN-000c9H-0U;
	Wed, 16 Apr 2025 18:14:41 +0200
Received: from ore by dude04.red.stw.pengutronix.de with local (Exim 4.96)
	(envelope-from <ore@pengutronix.de>)
	id 1u55PN-00CGQd-0F;
	Wed, 16 Apr 2025 18:14:41 +0200
From: Oleksij Rempel <o.rempel@pengutronix.de>
To: "David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	Simon Horman <horms@kernel.org>
Cc: Oleksij Rempel <o.rempel@pengutronix.de>,
	kernel@pengutronix.de,
	linux-kernel@vger.kernel.org,
	netdev@vger.kernel.org,
	Maxime Chevallier <maxime.chevallier@bootlin.com>
Subject: [PATCH net-next v1 3/4] net: selftest: add checksum mode support and SW checksum handling
Date: Wed, 16 Apr 2025 18:14:38 +0200
Message-Id: <20250416161439.2922994-4-o.rempel@pengutronix.de>
X-Mailer: git-send-email 2.39.5
In-Reply-To: <20250416161439.2922994-1-o.rempel@pengutronix.de>
References: <20250416161439.2922994-1-o.rempel@pengutronix.de>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-SA-Exim-Connect-IP: 2a0a:edc0:0:c01:1d::a2
X-SA-Exim-Mail-From: ore@pengutronix.de
X-SA-Exim-Scanned: No (on metis.whiteo.stw.pengutronix.de); SAEximRunCond expanded to false
X-PTX-Original-Recipient: netdev@vger.kernel.org

Introduce `enum net_test_checksum_mode` to support both CHECKSUM_COMPLETE
and CHECKSUM_PARTIAL modes in selftest packet generation.

Add helpers to calculate and apply software checksums for TCP/UDP in
CHECKSUM_COMPLETE mode, and refactor checksum handling into a dedicated
function `net_test_set_checksum()`.

Update PHY loopback tests to use CHECKSUM_COMPLETE by default to avoid
hardware offload dependencies and improve reliability.

Also rename loopback test names to clarify checksum type and transport.

Signed-off-by: Oleksij Rempel <o.rempel@pengutronix.de>
---
 net/core/selftests.c | 218 ++++++++++++++++++++++++++++++++++++++++---
 1 file changed, 206 insertions(+), 12 deletions(-)

diff --git a/net/core/selftests.c b/net/core/selftests.c
index 34e751d885d7..5d7ff6f829b5 100644
--- a/net/core/selftests.c
+++ b/net/core/selftests.c
@@ -14,6 +14,11 @@
 #include <net/tcp.h>
 #include <net/udp.h>
 
+enum net_test_checksum_mode {
+	NET_TEST_CHECKSUM_COMPLETE,
+	NET_TEST_CHECKSUM_PARTIAL,
+};
+
 struct net_packet_attrs {
 	const unsigned char *src;
 	const unsigned char *dst;
@@ -27,6 +32,7 @@ struct net_packet_attrs {
 	int max_size;
 	u8 id;
 	u16 queue_mapping;
+	enum net_test_checksum_mode csum_mode;
 };
 
 struct net_test_priv {
@@ -51,6 +57,133 @@ static u8 net_test_next_id;
 #define NET_TEST_PKT_MAGIC	0xdeadcafecafedeadULL
 #define NET_LB_TIMEOUT		msecs_to_jiffies(200)
 
+/**
+ * net_test_setup_sw_csum - Compute and apply software checksum
+ *                          (CHECKSUM_COMPLETE)
+ * @skb: Socket buffer with transport header set
+ * @iph: Pointer to IPv4 header inside skb
+ *
+ * This function computes and fills the transport layer checksum (TCP or UDP),
+ * and sets skb->ip_summed = CHECKSUM_COMPLETE.
+ *
+ * Returns 0 on success, or negative error code on failure.
+ */
+static int net_test_setup_sw_csum(struct sk_buff *skb,
+				  struct iphdr *iph)
+{
+	int transport_offset = skb_transport_offset(skb);
+	int transport_len = skb->len - transport_offset;
+	__be16 final_csum;
+	__wsum csum;
+
+	switch (iph->protocol) {
+	case IPPROTO_TCP:
+		if (!pskb_may_pull(skb,
+				   transport_offset + sizeof(struct tcphdr)))
+			return -EFAULT;
+
+		tcp_hdr(skb)->check = 0;
+		break;
+	case IPPROTO_UDP:
+		if (!pskb_may_pull(skb,
+				   transport_offset + sizeof(struct udphdr)))
+			return -EFAULT;
+
+		udp_hdr(skb)->check = 0;
+		break;
+	default:
+		pr_err("net_selftest: unsupported proto for sw csum: %u\n",
+		       iph->protocol);
+		return -EINVAL;
+	}
+
+	csum = skb_checksum(skb, transport_offset, transport_len, 0);
+	final_csum = csum_tcpudp_magic(iph->saddr, iph->daddr, transport_len,
+				       iph->protocol, csum);
+
+	if (iph->protocol == IPPROTO_UDP && final_csum == 0)
+		final_csum = CSUM_MANGLED_0;
+
+	if (iph->protocol == IPPROTO_TCP)
+		tcp_hdr(skb)->check = final_csum;
+	else
+		udp_hdr(skb)->check = final_csum;
+
+	skb->ip_summed = CHECKSUM_COMPLETE;
+
+	return 0;
+}
+
+/**
+ * net_test_setup_hw_csum - Setup skb for hardware checksum offload
+ *			    (CHECKSUM_PARTIAL)
+ * @skb: Socket buffer to prepare
+ * @iph: Pointer to IPv4 header inside skb
+ *
+ * This function sets skb fields and clears transport checksum field
+ * so that the NIC or driver can compute the checksum during transmit.
+ *
+ * Returns 0 on success, or negative error code on failure.
+ */
+static int net_test_setup_hw_csum(struct sk_buff *skb, struct iphdr *iph)
+{
+	u16 csum_offset;
+
+	skb->ip_summed = CHECKSUM_PARTIAL;
+	skb->csum = 0;
+
+	switch (iph->protocol) {
+	case IPPROTO_TCP:
+		if (!tcp_hdr(skb))
+			return -EINVAL;
+		tcp_hdr(skb)->check = 0;
+		csum_offset = offsetof(struct tcphdr, check);
+		break;
+	case IPPROTO_UDP:
+		if (!udp_hdr(skb))
+			return -EINVAL;
+		udp_hdr(skb)->check = 0;
+		csum_offset = offsetof(struct udphdr, check);
+		break;
+	default:
+		pr_err("net_selftest: unsupported proto for hw csum: %u\n",
+		       iph->protocol);
+		return -EINVAL;
+	}
+
+	skb->csum_start = skb_transport_header(skb) - skb->head;
+	skb->csum_offset = csum_offset;
+
+	return 0;
+}
+
+/**
+ * net_test_set_checksum - Apply requested checksum mode to skb
+ * @skb: Socket buffer containing the packet
+ * @attr: Packet attributes including desired checksum mode
+ * @iph: Pointer to the IP header within skb
+ *
+ * This function sets up the skb's checksum handling based on
+ * attr->csum_mode by calling the appropriate helper.
+ *
+ * Returns 0 on success, or negative error code on failure.
+ */
+static int net_test_set_checksum(struct sk_buff *skb,
+				 struct net_packet_attrs *attr,
+				 struct iphdr *iph)
+{
+	switch (attr->csum_mode) {
+	case NET_TEST_CHECKSUM_COMPLETE:
+		return net_test_setup_sw_csum(skb, iph);
+	case NET_TEST_CHECKSUM_PARTIAL:
+		return net_test_setup_hw_csum(skb, iph);
+	default:
+		pr_err("net_selftest: invalid checksum mode: %d\n",
+		       attr->csum_mode);
+		return -EINVAL;
+	}
+}
+
 static struct sk_buff *net_test_get_skb(struct net_device *ndev,
 					struct net_packet_attrs *attr)
 {
@@ -61,6 +194,7 @@ static struct sk_buff *net_test_get_skb(struct net_device *ndev,
 	struct ethhdr *ehdr;
 	struct iphdr *ihdr;
 	int iplen, size;
+	int ret;
 
 	size = attr->size + NET_TEST_PKT_SIZE;
 
@@ -157,15 +291,10 @@ static struct sk_buff *net_test_get_skb(struct net_device *ndev,
 		memset(pad, 0, pad_len);
 	}
 
-	skb->csum = 0;
-	skb->ip_summed = CHECKSUM_PARTIAL;
-	if (attr->tcp) {
-		thdr->check = ~tcp_v4_check(skb->len, ihdr->saddr,
-					    ihdr->daddr, 0);
-		skb->csum_start = skb_transport_header(skb) - skb->head;
-		skb->csum_offset = offsetof(struct tcphdr, check);
-	} else {
-		udp4_hwcsum(skb, ihdr->saddr, ihdr->daddr);
+	ret = net_test_set_checksum(skb, attr, ihdr);
+	if (ret < 0) {
+		kfree_skb(skb);
+		return ERR_PTR(ret);
 	}
 
 	skb->protocol = htons(ETH_P_IP);
@@ -318,29 +447,94 @@ static int net_test_phy_loopback_disable(struct net_device *ndev)
 	return phy_loopback(ndev->phydev, false, 0);
 }
 
+/**
+ * net_test_phy_loopback_udp - Basic PHY loopback test using UDP with SW
+ *                             checksum
+ * @ndev: The network device to test
+ *
+ * Sends and receives a minimal UDP packet through the device's internal
+ * PHY loopback path. The transport checksum is computed in software
+ * (CHECKSUM_COMPLETE), ensuring test validity regardless of hardware
+ * checksum offload support.
+ *
+ * Expected packet path:
+ *   Test code → MAC driver → MAC HW → xMII → PHY →
+ *   internal PHY loopback → xMII → MAC HW → MAC driver → test code
+ *
+ * The test frame includes Ethernet (14B), IPv4 (20B), UDP (8B), and a
+ * minimal payload (13B), totaling 55 bytes before padding/FCS. Most
+ * MACs will pad this to 60 bytes before appending the FCS.
+ *
+ * Returns 0 on success, or negative error code on failure.
+ */
 static int net_test_phy_loopback_udp(struct net_device *ndev)
 {
 	struct net_packet_attrs attr = { };
 
 	attr.dst = ndev->dev_addr;
+	attr.tcp = false;
+	attr.csum_mode = NET_TEST_CHECKSUM_COMPLETE;
+
 	return __net_test_loopback(ndev, &attr);
 }
 
+/**
+ * net_test_phy_loopback_udp_mtu - PHY loopback test using UDP MTU-sized frame
+ *                                 with SW checksum
+ * @ndev: The network device to test
+ *
+ * Sends and receives a UDP packet through the device's internal PHY loopback
+ * path. The packet uses software checksum calculation (CHECKSUM_COMPLETE),
+ * and the total L2 frame size is padded to match the device MTU.
+ *
+ * This tests the loopback path with larger frames and ensures checksum
+ * correctness regardless of hardware offload support.
+ *
+ * Expected packet path:
+ *   Test code → MAC driver → MAC HW → xMII → PHY →
+ *   internal PHY loopback → xMII → MAC HW → MAC driver → test code
+ *
+ * Returns 0 on success, or negative error code on failure.
+ */
 static int net_test_phy_loopback_udp_mtu(struct net_device *ndev)
 {
 	struct net_packet_attrs attr = { };
 
 	attr.dst = ndev->dev_addr;
 	attr.max_size = ndev->mtu;
+	attr.tcp = false;
+	attr.csum_mode = NET_TEST_CHECKSUM_COMPLETE;
+
 	return __net_test_loopback(ndev, &attr);
 }
 
+/**
+ * net_test_phy_loopback_tcp - PHY loopback test using TCP with SW checksum
+ * @ndev: The network device to test
+ *
+ * Sends and receives a minimal TCP packet through the device's internal
+ * PHY loopback path. The checksum is computed in software
+ * (CHECKSUM_COMPLETE), avoiding reliance on hardware checksum offload,
+ * which may behave inconsistently with TCP in some loopback setups.
+ *
+ * Expected packet path:
+ *   Test code → MAC driver → MAC HW → xMII → PHY →
+ *   internal PHY loopback → xMII → MAC HW → MAC driver → test code
+ *
+ * The generated test frame includes Ethernet (14B), IPv4 (20B), TCP (20B),
+ * and a small payload (13B), totaling 67 bytes before FCS. Since the total
+ * exceeds the Ethernet minimum, MAC padding is typically not applied.
+ *
+ * Returns 0 on success, or negative error code on failure.
+ */
 static int net_test_phy_loopback_tcp(struct net_device *ndev)
 {
 	struct net_packet_attrs attr = { };
 
 	attr.dst = ndev->dev_addr;
 	attr.tcp = true;
+	attr.csum_mode = NET_TEST_CHECKSUM_COMPLETE;
+
 	return __net_test_loopback(ndev, &attr);
 }
 
@@ -359,13 +553,13 @@ static const struct net_test {
 		.name = "PHY internal loopback, enable ",
 		.fn = net_test_phy_loopback_enable,
 	}, {
-		.name = "PHY internal loopback, UDP    ",
+		.name = "PHY loopback UDP (SW csum)    ",
 		.fn = net_test_phy_loopback_udp,
 	}, {
-		.name = "PHY internal loopback, MTU    ",
+		.name = "PHY loopback UDP MTU (SW csum)",
 		.fn = net_test_phy_loopback_udp_mtu,
 	}, {
-		.name = "PHY internal loopback, TCP    ",
+		.name = "PHY loopback TCP (SW csum)    ",
 		.fn = net_test_phy_loopback_tcp,
 	}, {
 		/* This test should be done after all PHY loopback test */
-- 
2.39.5


