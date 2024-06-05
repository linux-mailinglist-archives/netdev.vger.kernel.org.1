Return-Path: <netdev+bounces-100911-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 0AE828FC85E
	for <lists+netdev@lfdr.de>; Wed,  5 Jun 2024 11:53:04 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 698C01F21324
	for <lists+netdev@lfdr.de>; Wed,  5 Jun 2024 09:53:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A8DA918FC7D;
	Wed,  5 Jun 2024 09:52:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b="wCABgHQV"
X-Original-To: netdev@vger.kernel.org
Received: from fllv0015.ext.ti.com (fllv0015.ext.ti.com [198.47.19.141])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B39844963B;
	Wed,  5 Jun 2024 09:52:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.47.19.141
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717581179; cv=none; b=dGruKXRIEC41mvelG0GmU1HBEEIpMPjQYwW+QbFLSegQe7WvOoOBF2WWMJ+LIN8DMJEfjMlRtJtoUnviOM9uC9qBMr8YwuOQ3zHyw0gi83IqM3+Et6PA97zO4mFxWwFnhfK0wDCyhW67Y9Lw+LPyDkved0+DE13FALhXgscnNKU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717581179; c=relaxed/simple;
	bh=jnPNWF3YKGeMoyAAOvnWraIw8XgcXsBn2MIusN1qEFM=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=nP0Qb2TtKRVbWyoaLl5dSyxe738LW6gDQyghGrBjnwP3FTXOHMetHyxa+dux+qy0VZTXQdQbr+ngGsogiv5HZeg5x9ayJ68eTh5YuTPOOoFyMosQKFd+CHrEyptFyooLHi/w+eQZe/hI9LzBRqhJB+qwtNuAJjDRREmOpaOKae0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ti.com; spf=pass smtp.mailfrom=ti.com; dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b=wCABgHQV; arc=none smtp.client-ip=198.47.19.141
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ti.com
Received: from lelv0265.itg.ti.com ([10.180.67.224])
	by fllv0015.ext.ti.com (8.15.2/8.15.2) with ESMTP id 4559qRcc088771;
	Wed, 5 Jun 2024 04:52:27 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
	s=ti-com-17Q1; t=1717581147;
	bh=Lu9R3HFjqY+joNvpPu5u8Mxhs9oQxQ+UkNosv0uJ7MQ=;
	h=From:To:CC:Subject:Date;
	b=wCABgHQVPsy3QQ29+qc+Y1qhzRIREdqRaH4ZfUOSzn+UdOIZ1XvFHU3p7FUn3mkr9
	 VS+suMSB4w5mwDJwX5C0RC2MytpZLHLaW8v+wcSXH7ZNvs7XYK9LR0UfE1CihDfV6H
	 qcO5lxRVZ0mbEWFf5P4zaNSb9bdb+nfQdTgC2i/A=
Received: from DFLE112.ent.ti.com (dfle112.ent.ti.com [10.64.6.33])
	by lelv0265.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 4559qRfU017863
	(version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
	Wed, 5 Jun 2024 04:52:27 -0500
Received: from DFLE102.ent.ti.com (10.64.6.23) by DFLE112.ent.ti.com
 (10.64.6.33) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23; Wed, 5
 Jun 2024 04:52:27 -0500
Received: from lelvsmtp5.itg.ti.com (10.180.75.250) by DFLE102.ent.ti.com
 (10.64.6.23) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23 via
 Frontend Transport; Wed, 5 Jun 2024 04:52:26 -0500
Received: from fllv0122.itg.ti.com (fllv0122.itg.ti.com [10.247.120.72])
	by lelvsmtp5.itg.ti.com (8.15.2/8.15.2) with ESMTP id 4559qQAg046363;
	Wed, 5 Jun 2024 04:52:26 -0500
Received: from localhost (danish-tpc.dhcp.ti.com [10.24.69.25])
	by fllv0122.itg.ti.com (8.14.7/8.14.7) with ESMTP id 4559qPmu012064;
	Wed, 5 Jun 2024 04:52:26 -0500
From: MD Danish Anwar <danishanwar@ti.com>
To: Dan Carpenter <dan.carpenter@linaro.org>,
        Jan Kiszka
	<jan.kiszka@siemens.com>,
        Diogo Ivo <diogo.ivo@siemens.com>, Andrew Lunn
	<andrew@lunn.ch>,
        Simon Horman <horms@kernel.org>, Paolo Abeni
	<pabeni@redhat.com>,
        Jakub Kicinski <kuba@kernel.org>, Eric Dumazet
	<edumazet@google.com>,
        "David S. Miller" <davem@davemloft.net>
CC: <linux-kernel@vger.kernel.org>, <netdev@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>, <srk@ti.com>,
        Vignesh Raghavendra
	<vigneshr@ti.com>,
        Roger Quadros <rogerq@kernel.org>,
        MD Danish Anwar
	<danishanwar@ti.com>,
        Wojciech Drewek <wojciech.drewek@intel.com>
Subject: [PATCH net-next v3] net: ti: icssg-prueth: Add multicast filtering support
Date: Wed, 5 Jun 2024 15:22:23 +0530
Message-ID: <20240605095223.2556963-1-danishanwar@ti.com>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-EXCLAIMER-MD-CONFIG: e1e8a2fd-e40a-4ac6-ac9b-f7e9cc9ee180

Add multicast filtering support for ICSSG Driver. Multicast addresses will
be updated by __dev_mc_sync() API. icssg_prueth_add_macst () and
icssg_prueth_del_mcast() will be sync and unsync APIs for the driver
respectively.

To add a mac_address for a port, driver needs to call icssg_fdb_add_del()
and pass the mac_address and BIT(port_id) to the API. The ICSSG firmware
will then configure the rules and allow filtering.

If a mac_address is added to port0 and the same mac_address needs to be
added for port1, driver needs to pass BIT(port0) | BIT(port1) to the
icssg_fdb_add_del() API. If driver just pass BIT(port1) then the entry for
port0 will be overwritten / lost. This is a design constraint on the
firmware side.

To overcome this in the driver, to add any mac_address for let's say portX
driver first checks if the same mac_address is already added for any other
port. If yes driver calls icssg_fdb_add_del() with BIT(portX) |
BIT(other_existing_port). If not, driver calls icssg_fdb_add_del() with
BIT(portX).

The same thing is applicable for deleting mac_addresses as well. This
logic is in icssg_prueth_add_mcast / icssg_prueth_del_mcast APIs.

Signed-off-by: MD Danish Anwar <danishanwar@ti.com>
---
Cc: Wojciech Drewek <wojciech.drewek@intel.com>

v2 -> v3:
*) Using __dev_mc_sync() instead of __hw_addr_sync_dev().
*) Stopped keeping local copy of multicast list as pointed out by
   Wojciech Drewek <wojciech.drewek@intel.com>

v1 -> v2:
*) Rebased on latest net-next/main.

NOTE: This series can be applied cleanly on the tip of net-next/main. This
series doesn't depend on any other ICSSG driver related series that is
floating around in netdev.

v1 https://lore.kernel.org/all/20240516091752.2969092-1-danishanwar@ti.com/
v2 https://lore.kernel.org/all/20240604114402.1835973-1-danishanwar@ti.com/

 drivers/net/ethernet/ti/icssg/icssg_prueth.c | 38 +++++++++++++++++---
 1 file changed, 34 insertions(+), 4 deletions(-)

diff --git a/drivers/net/ethernet/ti/icssg/icssg_prueth.c b/drivers/net/ethernet/ti/icssg/icssg_prueth.c
index 6e65aa0977d4..e13835100754 100644
--- a/drivers/net/ethernet/ti/icssg/icssg_prueth.c
+++ b/drivers/net/ethernet/ti/icssg/icssg_prueth.c
@@ -439,6 +439,37 @@ const struct icss_iep_clockops prueth_iep_clockops = {
 	.perout_enable = prueth_perout_enable,
 };
 
+static int icssg_prueth_add_mcast(struct net_device *ndev, const u8 *addr)
+{
+	struct prueth_emac *emac = netdev_priv(ndev);
+	int port_mask = BIT(emac->port_id);
+
+	port_mask |= icssg_fdb_lookup(emac, addr, 0);
+	icssg_fdb_add_del(emac, addr, 0, port_mask, true);
+	icssg_vtbl_modify(emac, 0, port_mask, port_mask, true);
+
+	return 0;
+}
+
+static int icssg_prueth_del_mcast(struct net_device *ndev, const u8 *addr)
+{
+	struct prueth_emac *emac = netdev_priv(ndev);
+	int port_mask = BIT(emac->port_id);
+	int other_port_mask;
+
+	other_port_mask = port_mask ^ icssg_fdb_lookup(emac, addr, 0);
+
+	icssg_fdb_add_del(emac, addr, 0, port_mask, false);
+	icssg_vtbl_modify(emac, 0, port_mask, port_mask, false);
+
+	if (other_port_mask) {
+		icssg_fdb_add_del(emac, addr, 0, other_port_mask, true);
+		icssg_vtbl_modify(emac, 0, other_port_mask, other_port_mask, true);
+	}
+
+	return 0;
+}
+
 /**
  * emac_ndo_open - EMAC device open
  * @ndev: network adapter device
@@ -599,6 +630,8 @@ static int emac_ndo_stop(struct net_device *ndev)
 
 	icssg_class_disable(prueth->miig_rt, prueth_emac_slice(emac));
 
+	__dev_mc_unsync(ndev, icssg_prueth_del_mcast);
+
 	atomic_set(&emac->tdown_cnt, emac->tx_ch_num);
 	/* ensure new tdown_cnt value is visible */
 	smp_mb__after_atomic();
@@ -675,10 +708,7 @@ static void emac_ndo_set_rx_mode_work(struct work_struct *work)
 		return;
 	}
 
-	if (!netdev_mc_empty(ndev)) {
-		emac_set_port_state(emac, ICSSG_EMAC_PORT_MC_FLOODING_ENABLE);
-		return;
-	}
+	__dev_mc_sync(ndev, icssg_prueth_add_mcast, icssg_prueth_del_mcast);
 }
 
 /**

base-commit: fd70f0443e24c3888bf4b7f198df6d705c9b8ab2
-- 
2.34.1


