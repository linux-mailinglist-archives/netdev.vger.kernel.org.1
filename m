Return-Path: <netdev+bounces-49199-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 78C367F112E
	for <lists+netdev@lfdr.de>; Mon, 20 Nov 2023 12:01:51 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 32D28281666
	for <lists+netdev@lfdr.de>; Mon, 20 Nov 2023 11:01:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 78D3213AC7;
	Mon, 20 Nov 2023 11:01:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b="UV5IqoaN"
X-Original-To: netdev@vger.kernel.org
Received: from lelv0142.ext.ti.com (lelv0142.ext.ti.com [198.47.23.249])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B83BFD2;
	Mon, 20 Nov 2023 03:01:35 -0800 (PST)
Received: from lelv0266.itg.ti.com ([10.180.67.225])
	by lelv0142.ext.ti.com (8.15.2/8.15.2) with ESMTP id 3AKB19M4016016;
	Mon, 20 Nov 2023 05:01:09 -0600
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
	s=ti-com-17Q1; t=1700478069;
	bh=dK5EtPWsONa0/kGuX8aw4ZjhPdWzygkQ+zFeP8bQ8UU=;
	h=From:To:CC:Subject:Date;
	b=UV5IqoaNEqJ8El5bzL0UqZaX5wFwKZDODTTaTHAaZx4swD5vcMA++ksvqw4Ebh6sy
	 pfsnbqe99hrXhtGuyXlOYM6RxHuJ6/noRv6gZaCFmEajJbWVlIft6A4iDv+Ru+SXCL
	 g/2cGp2Wlz6EkiFGpIJI1UtnZzq9PPVQcbzNQOR4=
Received: from DFLE100.ent.ti.com (dfle100.ent.ti.com [10.64.6.21])
	by lelv0266.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 3AKB19OV098656
	(version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
	Mon, 20 Nov 2023 05:01:09 -0600
Received: from DFLE114.ent.ti.com (10.64.6.35) by DFLE100.ent.ti.com
 (10.64.6.21) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23; Mon, 20
 Nov 2023 05:01:09 -0600
Received: from lelv0326.itg.ti.com (10.180.67.84) by DFLE114.ent.ti.com
 (10.64.6.35) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23 via
 Frontend Transport; Mon, 20 Nov 2023 05:01:09 -0600
Received: from uda0500640.dal.design.ti.com (ileaxei01-snat.itg.ti.com [10.180.69.5])
	by lelv0326.itg.ti.com (8.15.2/8.15.2) with ESMTP id 3AKB1654029628;
	Mon, 20 Nov 2023 05:01:07 -0600
From: Ravi Gunasekaran <r-gunasekaran@ti.com>
To: <davem@davemloft.net>, <edumazet@google.com>, <kuba@kernel.org>,
        <pabeni@redhat.com>
CC: <bigeasy@linutronix.de>, <horms@kernel.org>, <netdev@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>, <r-gunasekaran@ti.com>
Subject: [PATCH net-next] net: hsr: Add support for MC filtering at the slave device
Date: Mon, 20 Nov 2023 16:31:05 +0530
Message-ID: <20231120110105.18416-1-r-gunasekaran@ti.com>
X-Mailer: git-send-email 2.17.1
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain
X-EXCLAIMER-MD-CONFIG: e1e8a2fd-e40a-4ac6-ac9b-f7e9cc9ee180

From: Murali Karicheri <m-karicheri2@ti.com>

When MC (multicast) list is updated by the networking layer due to a
user command and as well as when allmulti flag is set, it needs to be
passed to the enslaved Ethernet devices. This patch allows this
to happen by implementing ndo_change_rx_flags() and ndo_set_rx_mode()
API calls that in turns pass it to the slave devices using
existing API calls.

Signed-off-by: Murali Karicheri <m-karicheri2@ti.com>
Signed-off-by: Ravi Gunasekaran <r-gunasekaran@ti.com>
---
 net/hsr/hsr_device.c | 67 +++++++++++++++++++++++++++++++++++++++++++-
 1 file changed, 66 insertions(+), 1 deletion(-)

diff --git a/net/hsr/hsr_device.c b/net/hsr/hsr_device.c
index 306f942c3b28..4e8f4a3cefbf 100644
--- a/net/hsr/hsr_device.c
+++ b/net/hsr/hsr_device.c
@@ -173,7 +173,24 @@ static int hsr_dev_open(struct net_device *dev)
 
 static int hsr_dev_close(struct net_device *dev)
 {
-	/* Nothing to do here. */
+	struct hsr_port *port;
+	struct hsr_priv *hsr;
+
+	hsr = netdev_priv(dev);
+	hsr_for_each_port(hsr, port) {
+		if (port->type == HSR_PT_MASTER)
+			continue;
+		switch (port->type) {
+		case HSR_PT_SLAVE_A:
+		case HSR_PT_SLAVE_B:
+			dev_uc_unsync(port->dev, dev);
+			dev_mc_unsync(port->dev, dev);
+			break;
+		default:
+			break;
+		}
+	}
+
 	return 0;
 }
 
@@ -404,12 +421,60 @@ void hsr_del_ports(struct hsr_priv *hsr)
 		hsr_del_port(port);
 }
 
+static void hsr_ndo_set_rx_mode(struct net_device *dev)
+{
+	struct hsr_port *port;
+	struct hsr_priv *hsr;
+
+	hsr = netdev_priv(dev);
+
+	hsr_for_each_port(hsr, port) {
+		if (port->type == HSR_PT_MASTER)
+			continue;
+		switch (port->type) {
+		case HSR_PT_SLAVE_A:
+		case HSR_PT_SLAVE_B:
+			dev_mc_sync_multiple(port->dev, dev);
+			dev_uc_sync_multiple(port->dev, dev);
+			break;
+		default:
+			break;
+		}
+	}
+}
+
+static void hsr_change_rx_flags(struct net_device *dev, int change)
+{
+	struct hsr_port *port;
+	struct hsr_priv *hsr;
+
+	hsr = netdev_priv(dev);
+
+	hsr_for_each_port(hsr, port) {
+		if (port->type == HSR_PT_MASTER)
+			continue;
+		switch (port->type) {
+		case HSR_PT_SLAVE_A:
+		case HSR_PT_SLAVE_B:
+			if (change & IFF_ALLMULTI)
+				dev_set_allmulti(port->dev,
+						 dev->flags &
+						 IFF_ALLMULTI ? 1 : -1);
+			break;
+		default:
+			break;
+		}
+	}
+}
+
 static const struct net_device_ops hsr_device_ops = {
 	.ndo_change_mtu = hsr_dev_change_mtu,
 	.ndo_open = hsr_dev_open,
 	.ndo_stop = hsr_dev_close,
 	.ndo_start_xmit = hsr_dev_xmit,
+	.ndo_change_rx_flags = hsr_change_rx_flags,
 	.ndo_fix_features = hsr_fix_features,
+	.ndo_set_rx_mode = hsr_ndo_set_rx_mode,
 };
 
 static struct device_type hsr_type = {

base-commit: 5a82d69d48c82e89aef44483d2a129f869f3506a
-- 
2.17.1


