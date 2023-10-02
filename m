Return-Path: <netdev+bounces-37372-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 4FA017B5094
	for <lists+netdev@lfdr.de>; Mon,  2 Oct 2023 12:46:23 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sv.mirrors.kernel.org (Postfix) with ESMTP id 0EEB0283520
	for <lists+netdev@lfdr.de>; Mon,  2 Oct 2023 10:46:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A6274F9F0;
	Mon,  2 Oct 2023 10:46:20 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9766A10A12
	for <netdev@vger.kernel.org>; Mon,  2 Oct 2023 10:46:20 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0D286C433C9;
	Mon,  2 Oct 2023 10:46:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1696243580;
	bh=mp+1EXdp3qgYWtCDpptgNkw0RRPLLgHZjeZQSO6Wllc=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=oUimYht38nRMdKPBbxRSb8mYWugKSd/8XuP1yCd65gG/9P+0swXbd5F5ys8d0Yz6Q
	 +ghR+zTpygSs1eKBwey87VKJcQLxwWKfpVWYnANdy10UhbnacGypSR7UoCiPj6rvr1
	 19UYQstWThQKdUHD4nn1esjGLG1vSxU5Kfjrd+SkbeTSiPzT5TWNIf9stJ4EShwbta
	 pIzSF6GqyLv9jNqV8ZFaRD3Qy4z9vu792D61UGixNFjXFYR9ndTcTgjSm8FGoJ1oUY
	 HzzSp9m9wjHzBrmDHGUEQlg0XCCJ4PIRGpxGuutnMF4N56wHqznTQYiTSxxOsnBj1l
	 zNKlUYj4W1kvQ==
From: =?UTF-8?q?Marek=20Beh=C3=BAn?= <kabel@kernel.org>
To: Christian Marangi <ansuelsmth@gmail.com>,
	"David S. Miller" <davem@davemloft.net>,
	Paolo Abeni <pabeni@redhat.com>,
	netdev@vger.kernel.org
Cc: =?UTF-8?q?Marek=20Beh=C3=BAn?= <kabel@kernel.org>
Subject: [PATCH net 2/2] net: dsa: qca8k: fix potential MDIO bus conflict when accessing internal PHYs via management frames
Date: Mon,  2 Oct 2023 12:46:12 +0200
Message-ID: <20231002104612.21898-3-kabel@kernel.org>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20231002104612.21898-1-kabel@kernel.org>
References: <20231002104612.21898-1-kabel@kernel.org>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

Besides the QCA8337 switch the Turris 1.x device has on it's MDIO bus
also Micron ethernet PHY (dedicated to the WAN port).

We've been experiencing a strange behavior of the WAN ethernet
interface, wherein the WAN PHY started timing out the MDIO accesses, for
example when the interface was brought down and then back up.

Bisecting led to commit 2cd548566384 ("net: dsa: qca8k: add support for
phy read/write with mgmt Ethernet"), which added support to access the
QCA8337 switch's internal PHYs via management ethernet frames.

Connecting the MDIO bus pins onto an oscilloscope, I was able to see
that the MDIO bus was active whenever a request to read/write an
internal PHY register was done via an management ethernet frame.

My theory is that when the switch core always communicates with the
internal PHYs via the MDIO bus, even when externally we request the
access via ethernet. This MDIO bus is the same one via which the switch
and internal PHYs are accessible to the board, and the board may have
other devices connected on this bus. An ASCII illustration may give more
insight:

           +---------+
      +----|         |
      |    | WAN PHY |
      | +--|         |
      | |  +---------+
      | |
      | |  +----------------------------------+
      | |  | QCA8337                          |
MDC   | |  |                        +-------+ |
------o-+--|--------o------------o--|       | |
MDIO    |  |        |            |  | PHY 1 |-|--to RJ45
--------o--|---o----+---------o--+--|       | |
           |   |    |         |  |  +-------+ |
	   | +-------------+  |  o--|       | |
	   | | MDIO MDC    |  |  |  | PHY 2 |-|--to RJ45
eth1	   | |             |  o--+--|       | |
-----------|-|port0        |  |  |  +-------+ |
           | |             |  |  o--|       | |
	   | | switch core |  |  |  | PHY 3 |-|--to RJ45
           | +-------------+  o--+--|       | |
	   |                  |  |  +-------+ |
	   |                  |  o--|  ...  | |
	   +----------------------------------+

When we send a request to read an internal PHY register via an ethernet
management frame via eth1, the switch core receives the ethernet frame
on port 0 and then communicates with the internal PHY via MDIO. At this
time, other potential devices, such as the WAN PHY on Turris 1.x, cannot
use the MDIO bus, since it may cause a bus conflict.

Fix this issue by locking the MDIO bus even when we are accessing the
PHY registers via ethernet management frames.

Fixes: 2cd548566384 ("net: dsa: qca8k: add support for phy read/write with mgmt Ethernet")
Signed-off-by: Marek Behún <kabel@kernel.org>
---
 drivers/net/dsa/qca/qca8k-8xxx.c | 11 +++++++++++
 1 file changed, 11 insertions(+)

diff --git a/drivers/net/dsa/qca/qca8k-8xxx.c b/drivers/net/dsa/qca/qca8k-8xxx.c
index d2df30640269..4ce68e655a63 100644
--- a/drivers/net/dsa/qca/qca8k-8xxx.c
+++ b/drivers/net/dsa/qca/qca8k-8xxx.c
@@ -666,6 +666,15 @@ qca8k_phy_eth_command(struct qca8k_priv *priv, bool read, int phy,
 		goto err_read_skb;
 	}
 
+	/* It seems that accessing the switch's internal PHYs via management
+	 * packets still uses the MDIO bus within the switch internally, and
+	 * these accesses can conflict with external MDIO accesses to other
+	 * devices on the MDIO bus.
+	 * We therefore need to lock the MDIO bus onto which the switch is
+	 * connected.
+	 */
+	mutex_lock(&priv->bus->mdio_lock);
+
 	/* Actually start the request:
 	 * 1. Send mdio master packet
 	 * 2. Busy Wait for mdio master command
@@ -678,6 +687,7 @@ qca8k_phy_eth_command(struct qca8k_priv *priv, bool read, int phy,
 	mgmt_master = priv->mgmt_master;
 	if (!mgmt_master) {
 		mutex_unlock(&mgmt_eth_data->mutex);
+		mutex_unlock(&priv->bus->mdio_lock);
 		ret = -EINVAL;
 		goto err_mgmt_master;
 	}
@@ -765,6 +775,7 @@ qca8k_phy_eth_command(struct qca8k_priv *priv, bool read, int phy,
 				    QCA8K_ETHERNET_TIMEOUT);
 
 	mutex_unlock(&mgmt_eth_data->mutex);
+	mutex_unlock(&priv->bus->mdio_lock);
 
 	return ret;
 
-- 
2.41.0


