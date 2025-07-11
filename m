Return-Path: <netdev+bounces-206087-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id A46D4B01481
	for <lists+netdev@lfdr.de>; Fri, 11 Jul 2025 09:25:30 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id E79591717F2
	for <lists+netdev@lfdr.de>; Fri, 11 Jul 2025 07:25:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8CE7C1F0985;
	Fri, 11 Jul 2025 07:25:08 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from metis.whiteo.stw.pengutronix.de (metis.whiteo.stw.pengutronix.de [185.203.201.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7E2461E5B6D
	for <netdev@vger.kernel.org>; Fri, 11 Jul 2025 07:25:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.203.201.7
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752218708; cv=none; b=pKj1tTl9LFdr3Rn+ds5cui5OfWgl6jVc7PmtEEAq3eLyivOCyitw3xdU3VN5yyqSNTAQAKct0b/6SM0urfTJpn3eEjYE1NGPqLZ/IYoo0g4MvMo19QBi9KrGldzGu87YEfIeVLIfWjjgP5vYVW4APxNx/NpjYB0Ihnu7XuI0Y34=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752218708; c=relaxed/simple;
	bh=icHxeGLHJ+2GLRLVIeoFlPlPPZQSo9aSWmNufjIdbgs=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version:Content-Type; b=Lz5meP+EAZbE5/L3UhP52tmHW1qSOY2aTXtSDYO/1wTnonsXXwGl3vpEgyOGono/rtn34QCo79Dni6YlbQbx31w1jbZDg+8/DLkePptrDXpC2JHWrXMWCnGckgE9rfgt+Nf+kXOvQWWLCnT7VFv6FbkoP90Mn1u61p6Sc+hIql0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de; spf=pass smtp.mailfrom=pengutronix.de; arc=none smtp.client-ip=185.203.201.7
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pengutronix.de
Received: from drehscheibe.grey.stw.pengutronix.de ([2a0a:edc0:0:c01:1d::a2])
	by metis.whiteo.stw.pengutronix.de with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
	(Exim 4.92)
	(envelope-from <ore@pengutronix.de>)
	id 1ua87n-0001bS-PA; Fri, 11 Jul 2025 09:24:51 +0200
Received: from dude04.red.stw.pengutronix.de ([2a0a:edc0:0:1101:1d::ac])
	by drehscheibe.grey.stw.pengutronix.de with esmtps  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.96)
	(envelope-from <ore@pengutronix.de>)
	id 1ua87m-007sjf-1G;
	Fri, 11 Jul 2025 09:24:50 +0200
Received: from ore by dude04.red.stw.pengutronix.de with local (Exim 4.96)
	(envelope-from <ore@pengutronix.de>)
	id 1ua87m-003Mpa-11;
	Fri, 11 Jul 2025 09:24:50 +0200
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
Subject: [PATCH net-next v2 1/1] net: selftests: add PHY-loopback test for bad TCP checksums
Date: Fri, 11 Jul 2025 09:24:49 +0200
Message-Id: <20250711072449.802677-1-o.rempel@pengutronix.de>
X-Mailer: git-send-email 2.39.5
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

Detect NICs and drivers that either drop frames with a corrupted TCP
checksum or, worse, pass them up as valid.  The test flips one bit in
the checksum, transmits the packet in internal loopback, and fails when
the driver reports CHECKSUM_UNNECESSARY.

Discussed at:
https://lore.kernel.org/all/20250625132117.1b3264e8@kernel.org/

Signed-off-by: Oleksij Rempel <o.rempel@pengutronix.de>
---
changes v2:
- Replaced manual calculation of TCP checksum with standard kernel helper
  skb_checksum_help().
- add test documentation
---
 net/core/selftests.c | 84 ++++++++++++++++++++++++++++++++++++++++++--
 1 file changed, 82 insertions(+), 2 deletions(-)

diff --git a/net/core/selftests.c b/net/core/selftests.c
index 406faf8e5f3f..513c8b5f7c46 100644
--- a/net/core/selftests.c
+++ b/net/core/selftests.c
@@ -27,6 +27,7 @@ struct net_packet_attrs {
 	int max_size;
 	u8 id;
 	u16 queue_mapping;
+	bool bad_csum;
 };
 
 struct net_test_priv {
@@ -165,6 +166,37 @@ static struct sk_buff *net_test_get_skb(struct net_device *ndev,
 		thdr->check = ~tcp_v4_check(l4len, ihdr->saddr, ihdr->daddr, 0);
 		skb->csum_start = skb_transport_header(skb) - skb->head;
 		skb->csum_offset = offsetof(struct tcphdr, check);
+
+		if (attr->bad_csum) {
+			u16 csum;
+
+			/* Force mangled checksum */
+			if (skb_checksum_help(skb)) {
+				kfree_skb(skb);
+				return NULL;
+			}
+
+			/* To avoid sparse warnings about operating on
+			 * restricted __sum16/__be16 types, explicitly cast the
+			 * checksum to a plain u16, perform the manipulation,
+			 * and then cast the result back.
+			 */
+			csum = (__force u16)thdr->check;
+
+			/* Mangle the checksum by flipping the LSB. */
+			csum ^= 1;
+			/* If mangling resulted in 0, use the raw value for a
+			 * mangled-zero checksum. We use the literal 0xffff
+			 * because CSUM_MANGLED_0 has a restricted type.
+			 */
+			if (!csum)
+				csum = 0xffff;
+
+			/* Cast the final integer value back to the restricted
+			 * type
+			 */
+			thdr->check = (__force __sum16)csum;
+		}
 	} else {
 		udp4_hwcsum(skb, ihdr->saddr, ihdr->daddr);
 	}
@@ -239,7 +271,11 @@ static int net_test_loopback_validate(struct sk_buff *skb,
 	if (tpriv->packet->id != shdr->id)
 		goto out;
 
-	tpriv->ok = true;
+	if (tpriv->packet->bad_csum && skb->ip_summed == CHECKSUM_UNNECESSARY)
+		tpriv->ok = -EIO;
+	else
+		tpriv->ok = true;
+
 	complete(&tpriv->comp);
 out:
 	kfree_skb(skb);
@@ -285,7 +321,12 @@ static int __net_test_loopback(struct net_device *ndev,
 		attr->timeout = NET_LB_TIMEOUT;
 
 	wait_for_completion_timeout(&tpriv->comp, attr->timeout);
-	ret = tpriv->ok ? 0 : -ETIMEDOUT;
+	if (tpriv->ok < 0)
+		ret = tpriv->ok;
+	else if (!tpriv->ok)
+		ret = -ETIMEDOUT;
+	else
+		ret = 0;
 
 cleanup:
 	dev_remove_pack(&tpriv->pt);
@@ -345,6 +386,42 @@ static int net_test_phy_loopback_tcp(struct net_device *ndev)
 	return __net_test_loopback(ndev, &attr);
 }
 
+/**
+ * net_test_phy_loopback_tcp_bad_csum - PHY loopback test with a deliberately
+ *					corrupted TCP checksum
+ * @ndev: the network device to test
+ *
+ * Builds the same minimal Ethernet/IPv4/TCP frame as
+ * net_test_phy_loopback_tcp(), then flips the least-significant bit of the TCP
+ * checksum so the resulting value is provably invalid (neither 0 nor 0xFFFF).
+ * The frame is transmitted through the device’s internal PHY loopback path:
+ *
+ *   test code -> MAC driver -> MAC HW -> xMII -> PHY ->
+ *   internal PHY loopback -> xMII -> MAC HW -> MAC driver -> test code
+ *
+ * Result interpretation
+ * ---------------------
+ *  0            The frame is delivered to the stack and the driver reports
+ *               ip_summed as CHECKSUM_NONE or CHECKSUM_COMPLETE - both are
+ *               valid ways to indicate “bad checksum, let the stack verify.”
+ *  -ETIMEDOUT   The MAC/PHY silently dropped the frame; hardware checksum
+ *               verification filtered it out before the driver saw it.
+ *  -EIO         The driver returned the frame with ip_summed ==
+ *               CHECKSUM_UNNECESSARY, falsely claiming a valid checksum and
+ *               indicating a serious RX-path defect.
+ *
+ * Return: 0 on success or a negative error code on failure.
+ */
+static int net_test_phy_loopback_tcp_bad_csum(struct net_device *ndev)
+{
+	struct net_packet_attrs attr = { };
+
+	attr.dst = ndev->dev_addr;
+	attr.tcp = true;
+	attr.bad_csum = true;
+	return __net_test_loopback(ndev, &attr);
+}
+
 static const struct net_test {
 	char name[ETH_GSTRING_LEN];
 	int (*fn)(struct net_device *ndev);
@@ -368,6 +445,9 @@ static const struct net_test {
 	}, {
 		.name = "PHY internal loopback, TCP    ",
 		.fn = net_test_phy_loopback_tcp,
+	}, {
+		.name = "PHY loopback, bad TCP csum    ",
+		.fn = net_test_phy_loopback_tcp_bad_csum,
 	}, {
 		/* This test should be done after all PHY loopback test */
 		.name = "PHY internal loopback, disable",
-- 
2.39.5


