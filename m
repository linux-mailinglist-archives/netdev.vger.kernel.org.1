Return-Path: <netdev+bounces-213399-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id D5BFCB24DB0
	for <lists+netdev@lfdr.de>; Wed, 13 Aug 2025 17:41:23 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id CC1DB1C205EA
	for <lists+netdev@lfdr.de>; Wed, 13 Aug 2025 15:38:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 26B63281509;
	Wed, 13 Aug 2025 15:36:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=fris.de header.i=@fris.de header.b="VMIojZs5"
X-Original-To: netdev@vger.kernel.org
Received: from mail.fris.de (mail.fris.de [116.203.77.234])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AD331281372;
	Wed, 13 Aug 2025 15:36:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=116.203.77.234
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755099371; cv=none; b=CL7rhQflcB+31MB3T1WrN5j19DJom8WdFouhcfcrnJrGm2QdeaNEdn9wogEZJbfKBTjnOdvKImTyPYn6RleuSKuITPlvWT4QS7ZW6sCtmiIQEEkfEkKWmw3gcudQgmJRShcSPE4vQGIcZOoDljQibmMDuXdyBQdekkTNHceAi9A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755099371; c=relaxed/simple;
	bh=0yB4yPxqFUcfgr4tTHPeG4JoznlOadq31ynbw69xH1k=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=gae5cELfoPlIx6dO9B9kXxbiTIQx7HuSfYL/Fq+VT0z6NOU+I1zvDnEzLwXEMhzDMNpssPIKLprFME5LvlIqWUCBi9CHOLlCPzysau1qVAv9fL1fRJ73cDR8L2G8YPK0Ll3l1X4LDIn6hKBgQmRkpbigR6crF5srY/VN68N2DLE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=fris.de; spf=pass smtp.mailfrom=fris.de; dkim=pass (2048-bit key) header.d=fris.de header.i=@fris.de header.b=VMIojZs5; arc=none smtp.client-ip=116.203.77.234
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=fris.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=fris.de
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon) with ESMTPSA id C90D0C981B;
	Wed, 13 Aug 2025 17:28:21 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fris.de; s=dkim;
	t=1755098907; h=from:subject:date:message-id:to:cc:mime-version:
	 content-transfer-encoding; bh=Lf7hoXo1qTojSQ5GerYUNJtoP2pgymrfHmOK4+PmZ7c=;
	b=VMIojZs5JA9aS9O3gcpK+RTWtYShv47B/EX2AtYf1Ba9/0eD73cUwPpM2heUT3xcKik52j
	o5SY/+7D/2Jtvv5W4MAYiYrCUevtgdVwKL7jhoh6Fn2yB0CiGKExFoi4vFIHWSHW+k+tlx
	XzExX34iAkYhkvTcoP4jrFveiw6r90Sz+0c+aC3Nn6DCJbG9yR0I3RcwVkhwXLfKg8I7Jo
	TUxmxpOfzLHKxK4bkM3Vl88R5skOQQP9tSr6tn8poV/VNHM29ildSqlZQB14B84gBxripn
	EH8T2lwY4sis0RoVkOdbn1t8Efvq8VG6F8JDA29yYLSmkasHQ9UiaM7LRtm1nA==
From: Frieder Schrempf <frieder@fris.de>
To: netdev@vger.kernel.org,
	Andrew Lunn <andrew@lunn.ch>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	linux-kernel@vger.kernel.org,
	Lukasz Majewski <lukma@denx.de>,
	Paolo Abeni <pabeni@redhat.com>,
	UNGLinuxDriver@microchip.com,
	Vladimir Oltean <olteanv@gmail.com>,
	Woojung Huh <woojung.huh@microchip.com>
Cc: Frieder Schrempf <frieder.schrempf@kontron.de>,
	Florian Fainelli <florian.fainelli@broadcom.com>,
	Jesse Van Gavere <jesseevg@gmail.com>,
	Oleksij Rempel <o.rempel@pengutronix.de>,
	Pieter Van Trappen <pieter.van.trappen@cern.ch>,
	"Russell King (Oracle)" <rmk+kernel@armlinux.org.uk>,
	Simon Horman <horms@kernel.org>,
	Tristram Ha <tristram.ha@microchip.com>,
	Vadim Fedorenko <vadim.fedorenko@linux.dev>
Subject: [RFC PATCH] net: dsa: microchip: Prevent overriding of HSR port forwarding
Date: Wed, 13 Aug 2025 17:26:12 +0200
Message-ID: <20250813152615.856532-1-frieder@fris.de>
X-Mailer: git-send-email 2.50.1
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Last-TLS-Session-Version: TLSv1.3

From: Frieder Schrempf <frieder.schrempf@kontron.de>

The KSZ9477 supports NETIF_F_HW_HSR_FWD to forward packets between
HSR ports. This is set up when creating the HSR interface via
ksz9477_hsr_join() and ksz9477_cfg_port_member().

At the same time ksz_update_port_member() is called on every
state change of a port and reconfiguring the forwarding to the
default state which means packets get only forwarded to the CPU
port.

If the ports are brought up before setting up the HSR interface
and then the port state is not changed afterwards, everything works
as intended:

  ip link set lan1 up
  ip link set lan2 up
  ip link add name hsr type hsr slave1 lan1 slave2 lan2 supervision 45 version 1
  ip addr add dev hsr 10.0.0.10/24
  ip link set hsr up

If the port state is changed after creating the HSR interface, this results
in a non-working HSR setup:

  ip link add name hsr type hsr slave1 lan1 slave2 lan2 supervision 45 version 1
  ip addr add dev hsr 10.0.0.10/24
  ip link set lan1 up
  ip link set lan2 up
  ip link set hsr up

In this state, packets will not get forwarded between the HSR ports and
communication between HSR nodes that are not direct neighbours in the
topology fails.

To avoid this, we prevent all forwarding reconfiguration requests for ports
that are part of a HSR setup with NETIF_F_HW_HSR_FWD enabled.

Fixes: 2d61298fdd7b ("net: dsa: microchip: Enable HSR offloading for KSZ9477")
Signed-off-by: Frieder Schrempf <frieder.schrempf@kontron.de>
---
I'm posting this as RFC as my knowledge of the driver and the stack in
general is very limited. Please review thoroughly and provide feedback.
Thanks!
---
---
 drivers/net/dsa/microchip/ksz_common.c | 11 +++++++++++
 include/net/dsa.h                      | 12 ++++++++++++
 2 files changed, 23 insertions(+)

diff --git a/drivers/net/dsa/microchip/ksz_common.c b/drivers/net/dsa/microchip/ksz_common.c
index 7c142c17b3f69..56370ecdfe4ee 100644
--- a/drivers/net/dsa/microchip/ksz_common.c
+++ b/drivers/net/dsa/microchip/ksz_common.c
@@ -2286,6 +2286,17 @@ static void ksz_update_port_member(struct ksz_device *dev, int port)
 		return;
 
 	dp = dsa_to_port(ds, port);
+
+	/*
+	 * HSR ports might use forwarding configured during setup. Prevent any
+	 * modifications as long as the port is part of a HSR setup with
+	 * NETIF_F_HW_HSR_FWD enabled.
+	 */
+	if (dev->hsr_dev && dp->user &&
+	    (dp->user->features & NETIF_F_HW_HSR_FWD) &&
+	    dsa_is_hsr_port(ds, dev->hsr_dev, port))
+		return;
+
 	cpu_port = BIT(dsa_upstream_port(ds, port));
 
 	for (i = 0; i < ds->num_ports; i++) {
diff --git a/include/net/dsa.h b/include/net/dsa.h
index 55e2d97f247eb..846a2cc2f2fc3 100644
--- a/include/net/dsa.h
+++ b/include/net/dsa.h
@@ -565,6 +565,18 @@ static inline bool dsa_is_user_port(struct dsa_switch *ds, int p)
 	return dsa_to_port(ds, p)->type == DSA_PORT_TYPE_USER;
 }
 
+static inline bool dsa_is_hsr_port(struct dsa_switch *ds, struct net_device *hsr, int p)
+{
+	struct dsa_port *hsr_dp;
+
+	dsa_hsr_foreach_port(hsr_dp, ds, hsr) {
+		if (hsr_dp->index == p)
+			return true;
+	}
+
+	return false;
+}
+
 #define dsa_tree_for_each_user_port(_dp, _dst) \
 	list_for_each_entry((_dp), &(_dst)->ports, list) \
 		if (dsa_port_is_user((_dp)))
-- 
2.50.1


