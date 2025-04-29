Return-Path: <netdev+bounces-186677-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id A07F0AA04BE
	for <lists+netdev@lfdr.de>; Tue, 29 Apr 2025 09:42:08 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 46A8F189FFD7
	for <lists+netdev@lfdr.de>; Tue, 29 Apr 2025 07:41:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5ADB427CCD7;
	Tue, 29 Apr 2025 07:41:15 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from metis.whiteo.stw.pengutronix.de (metis.whiteo.stw.pengutronix.de [185.203.201.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8AD2627817E
	for <netdev@vger.kernel.org>; Tue, 29 Apr 2025 07:41:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.203.201.7
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745912475; cv=none; b=CUhnMW8TiOj0sgF0mKpSYCaO5M+E3Jdb0dE9aDFFzhogVk4zdQ4V8hwcAWcMAwHHZnLBe4nmrb3CaBSr2ZTgJpcDF2qjdQsFU9Qd4GNjYVyjE/aFCz5lJ+kfpxv5u7jofu7eoOusiG6EVAbWFB+Xul2kNNN5rjVIe+etw4m7A5U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745912475; c=relaxed/simple;
	bh=MBFWwb46UQQNdOkUo56hW2ui2l2iYYiZr5TxJR/PPC4=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version:Content-Type; b=ovBiCKY4gvAWRh6qPhQaTGrE3KqH6SSDrwusxjgUYIc2i+/2uyGfxmNsXMmblETsKaeRYvhneicboHThBgcISyfpKtJYCQs95JjD+l6x7+6f7zxjZTnipuW1rTwgFmltD+XPV3dSsfWDEBOrE1YnbO7N5LfQIdW0meH9F54/CtY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de; spf=pass smtp.mailfrom=pengutronix.de; arc=none smtp.client-ip=185.203.201.7
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pengutronix.de
Received: from drehscheibe.grey.stw.pengutronix.de ([2a0a:edc0:0:c01:1d::a2])
	by metis.whiteo.stw.pengutronix.de with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
	(Exim 4.92)
	(envelope-from <ore@pengutronix.de>)
	id 1u9faT-0006KR-Sj; Tue, 29 Apr 2025 09:41:05 +0200
Received: from dude04.red.stw.pengutronix.de ([2a0a:edc0:0:1101:1d::ac])
	by drehscheibe.grey.stw.pengutronix.de with esmtps  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.96)
	(envelope-from <ore@pengutronix.de>)
	id 1u9faS-000E3G-1e;
	Tue, 29 Apr 2025 09:41:04 +0200
Received: from ore by dude04.red.stw.pengutronix.de with local (Exim 4.96)
	(envelope-from <ore@pengutronix.de>)
	id 1u9faS-00CY78-1Q;
	Tue, 29 Apr 2025 09:41:04 +0200
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
Subject: [PATCH net-next v3 4/4] net: selftests: add PHY loopback tests with HW checksum offload
Date: Tue, 29 Apr 2025 09:41:03 +0200
Message-Id: <20250429074103.2991006-5-o.rempel@pengutronix.de>
X-Mailer: git-send-email 2.39.5
In-Reply-To: <20250429074103.2991006-1-o.rempel@pengutronix.de>
References: <20250429074103.2991006-1-o.rempel@pengutronix.de>
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

Introduce two new PHY loopback tests that validate hardware checksum
offload functionality using UDP and TCP packets. These tests set
csum_mode = CHECKSUM_PARTIAL, allowing the NIC to compute transport
checksums.

Tests are only executed if the device advertises NETIF_F_HW_CSUM
support. If not, they are skipped with -EOPNOTSUPP.

Also register the tests under descriptive names in the test list.

Signed-off-by: Oleksij Rempel <o.rempel@pengutronix.de>
Reviewed-by: Simon Horman <horms@kernel.org>
---
 net/core/selftests.c | 80 ++++++++++++++++++++++++++++++++++++++++++++
 1 file changed, 80 insertions(+)

diff --git a/net/core/selftests.c b/net/core/selftests.c
index 591686978dd7..e751dc677858 100644
--- a/net/core/selftests.c
+++ b/net/core/selftests.c
@@ -539,6 +539,79 @@ static int net_test_phy_loopback_tcp(struct net_device *ndev)
 	return __net_test_loopback(ndev, &attr);
 }
 
+/**
+ * net_test_phy_loopback_udp_hwcsum - PHY loopback test using UDP with HW
+ *                                    checksum
+ * @ndev: The network device to test
+ *
+ * Sends and receives a UDP packet through the device's internal PHY loopback
+ * path. The packet is configured for hardware checksum offload
+ * (CHECKSUM_PARTIAL), allowing the NIC to compute the transport checksum.
+ *
+ * Expected packet path:
+ *   Test code → MAC driver → MAC HW → xMII → PHY →
+ *   internal PHY loopback → xMII → MAC HW → MAC driver → test code
+ *
+ * The test frame includes Ethernet (14B), IPv4 (20B), UDP (8B), and a
+ * small payload (13B), totaling 55 bytes before MAC padding/FCS. Most
+ * MACs pad this to the minimum Ethernet payload (60 bytes before FCS).
+ *
+ * If the device does not support NETIF_F_HW_CSUM, the test is skipped
+ * and -EOPNOTSUPP is returned.
+ *
+ * Returns 0 on success, or negative error code on failure.
+ */
+static int net_test_phy_loopback_udp_hwcsum(struct net_device *ndev)
+{
+	struct net_packet_attrs attr = { };
+
+	if (!(ndev->features & NETIF_F_HW_CSUM))
+		return -EOPNOTSUPP;
+
+	attr.dst = ndev->dev_addr;
+	attr.tcp = false;
+	attr.csum_mode = NET_TEST_CHECKSUM_PARTIAL;
+
+	return __net_test_loopback(ndev, &attr);
+}
+
+/**
+ * net_test_phy_loopback_tcp_hwcsum - PHY loopback test using TCP with HW
+ *                                    checksum
+ * @ndev: The network device to test
+ *
+ * Sends and receives a TCP packet through the device's internal PHY loopback
+ * path. The packet is configured for hardware checksum offload
+ * (CHECKSUM_PARTIAL), allowing the NIC to compute the transport checksum.
+ *
+ * Expected packet path:
+ *   Test code → MAC driver → MAC HW → xMII → PHY →
+ *   internal PHY loopback → xMII → MAC HW → MAC driver → test code
+ *   (via packet_type handler)
+ *
+ * The test frame includes Ethernet (14B), IPv4 (20B), TCP (20B),
+ * and a small payload (13B), totaling 67 bytes before FCS.
+ * No additional padding is required.
+ *
+ * If the device does not support NETIF_F_HW_CSUM, the test is skipped
+ * and -EOPNOTSUPP is returned.
+ *
+ * Returns 0 on success, or negative error code on failure.
+ */
+static int net_test_phy_loopback_tcp_hwcsum(struct net_device *ndev)
+{
+	struct net_packet_attrs attr = { };
+
+	if (!(ndev->features & NETIF_F_HW_CSUM))
+		return -EOPNOTSUPP;
+
+	attr.dst = ndev->dev_addr;
+	attr.tcp = true;
+	attr.csum_mode = NET_TEST_CHECKSUM_PARTIAL;
+
+	return __net_test_loopback(ndev, &attr);
+}
+
 static const struct net_test {
 	char name[ETH_GSTRING_LEN];
 	int (*fn)(struct net_device *ndev);
@@ -562,6 +635,13 @@ static const struct net_test {
 	}, {
 		.name = "PHY loopback TCP (SW csum)    ",
 		.fn = net_test_phy_loopback_tcp,
+	}, {
+		/* Conditional HW checksum tests */
+		.name = "PHY loopback UDP (HW csum)    ",
+		.fn = net_test_phy_loopback_udp_hwcsum,
+	}, {
+		.name = "PHY loopback TCP (HW csum)    ",
+		.fn = net_test_phy_loopback_tcp_hwcsum,
 	}, {
 		/* This test should be done after all PHY loopback test */
 		.name = "PHY internal loopback, disable",
-- 
2.39.5


