Return-Path: <netdev+bounces-96848-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 017BE8C8084
	for <lists+netdev@lfdr.de>; Fri, 17 May 2024 07:02:04 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 7B1F4B220A2
	for <lists+netdev@lfdr.de>; Fri, 17 May 2024 05:02:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F2807134A6;
	Fri, 17 May 2024 05:01:37 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from metis.whiteo.stw.pengutronix.de (metis.whiteo.stw.pengutronix.de [185.203.201.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6DD3C1095C
	for <netdev@vger.kernel.org>; Fri, 17 May 2024 05:01:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.203.201.7
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715922097; cv=none; b=fM8uq22FRkL+iMDtZT2wXoblhXKwzqNdeDdcO2lM0vgKDNZ316R5gnU5McoshwW7/nUL9lVThDbGnkYHtrDeiRoU1ZKba7XeosuIuVTr5rPo836uuwtjkPo5gY0IS3uSC92MJqDz3v5nWOHczCjkSRsv2nwyK5tBj+TFGKUPmQs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715922097; c=relaxed/simple;
	bh=Q++9aS+kx2YZlIKGrDvxJlGOFReUULix7E6oSVQC3wE=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=RXzASX+VnMUrR7aXzjZN4mlOYbExIUGrT4F8KCYWnWiSLk24nsmZe2Po570eJBa/9cqmcwlWRVoae2p02f/jixrXSPzCHuDNx7UI03GGDSv1n6m+XQXx+Nmc7k0v4trm9WmhMmWCpCACHm+UizKP7jpHzWPwg83z5IOifg6sFhU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de; spf=pass smtp.mailfrom=pengutronix.de; arc=none smtp.client-ip=185.203.201.7
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pengutronix.de
Received: from drehscheibe.grey.stw.pengutronix.de ([2a0a:edc0:0:c01:1d::a2])
	by metis.whiteo.stw.pengutronix.de with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
	(Exim 4.92)
	(envelope-from <ore@pengutronix.de>)
	id 1s7pif-0001c9-ST; Fri, 17 May 2024 07:01:25 +0200
Received: from [2a0a:edc0:0:1101:1d::ac] (helo=dude04.red.stw.pengutronix.de)
	by drehscheibe.grey.stw.pengutronix.de with esmtps  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.94.2)
	(envelope-from <ore@pengutronix.de>)
	id 1s7pic-001p0g-BX; Fri, 17 May 2024 07:01:22 +0200
Received: from ore by dude04.red.stw.pengutronix.de with local (Exim 4.96)
	(envelope-from <ore@pengutronix.de>)
	id 1s7pic-0097fT-0u;
	Fri, 17 May 2024 07:01:22 +0200
From: Oleksij Rempel <o.rempel@pengutronix.de>
To: "David S. Miller" <davem@davemloft.net>,
	Andrew Lunn <andrew@lunn.ch>,
	Eric Dumazet <edumazet@google.com>,
	Florian Fainelli <f.fainelli@gmail.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	Vladimir Oltean <olteanv@gmail.com>,
	Woojung Huh <woojung.huh@microchip.com>,
	Arun Ramadoss <arun.ramadoss@microchip.com>
Cc: Oleksij Rempel <o.rempel@pengutronix.de>,
	Hariprasad Kelam <hkelam@marvell.com>,
	kernel@pengutronix.de,
	linux-kernel@vger.kernel.org,
	netdev@vger.kernel.org,
	UNGLinuxDriver@microchip.com,
	David Ahern <dsahern@kernel.org>,
	Simon Horman <horms@kernel.org>,
	Willem de Bruijn <willemb@google.com>,
	=?UTF-8?q?S=C3=B8ren=20Andersen?= <san@skov.dk>
Subject: [PATCH net v2 1/1] net: dsa: microchip: Correct initialization order for KSZ88x3 ports
Date: Fri, 17 May 2024 07:01:21 +0200
Message-Id: <20240517050121.2174412-1-o.rempel@pengutronix.de>
X-Mailer: git-send-email 2.39.2
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-SA-Exim-Connect-IP: 2a0a:edc0:0:c01:1d::a2
X-SA-Exim-Mail-From: ore@pengutronix.de
X-SA-Exim-Scanned: No (on metis.whiteo.stw.pengutronix.de); SAEximRunCond expanded to false
X-PTX-Original-Recipient: netdev@vger.kernel.org

Adjust the initialization sequence of KSZ88x3 switches to enable
802.1p priority control on Port 2 before configuring Port 1. This
change ensures the apptrust functionality on Port 1 operates
correctly, as it depends on the priority settings of Port 2. The
prior initialization sequence incorrectly configured Port 1 first,
which could lead to functional discrepancies.

Fixes: a1ea57710c9d ("net: dsa: microchip: dcb: add special handling for KSZ88X3 family")
Signed-off-by: Oleksij Rempel <o.rempel@pengutronix.de>
Reviewed-by: Hariprasad Kelam <hkelam@marvell.com>
---
 drivers/net/dsa/microchip/ksz_dcb.c | 10 ++++++++++
 1 file changed, 10 insertions(+)

diff --git a/drivers/net/dsa/microchip/ksz_dcb.c b/drivers/net/dsa/microchip/ksz_dcb.c
index a971063275629..086bc9b3cf536 100644
--- a/drivers/net/dsa/microchip/ksz_dcb.c
+++ b/drivers/net/dsa/microchip/ksz_dcb.c
@@ -805,5 +805,15 @@ int ksz_dcb_init(struct ksz_device *dev)
 	if (ret)
 		return ret;
 
+	/* Enable 802.1p priority control on Port 2 during switch initialization.
+	 * This setup is critical for the apptrust functionality on Port 1, which
+	 * relies on the priority settings of Port 2. Note: Port 1 is naturally
+	 * configured before Port 2, necessitating this configuration order.
+	 */
+	if (ksz_is_ksz88x3(dev))
+		return ksz_prmw8(dev, KSZ_PORT_2, KSZ8_REG_PORT_1_CTRL_0,
+				 KSZ8_PORT_802_1P_ENABLE,
+				 KSZ8_PORT_802_1P_ENABLE);
+
 	return 0;
 }
-- 
2.39.2


