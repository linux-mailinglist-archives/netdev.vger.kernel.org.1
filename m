Return-Path: <netdev+bounces-263262-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id eCWeLYf5pmk7bgAAu9opvQ
	(envelope-from <netdev+bounces-263262-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Tue, 03 Mar 2026 16:08:55 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 33F1B1F2118
	for <lists+netdev@lfdr.de>; Tue, 03 Mar 2026 16:08:55 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id CE7F2308962D
	for <lists+netdev@lfdr.de>; Tue,  3 Mar 2026 14:59:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C58353A6EF3;
	Tue,  3 Mar 2026 14:59:05 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from relmlie6.idc.renesas.com (relmlor2.renesas.com [210.160.252.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1D55D3B5822;
	Tue,  3 Mar 2026 14:59:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=210.160.252.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772549945; cv=none; b=pDWqQgpaRqw7+gcgj24vPETJrUj0VkD1d3M2da+EGAs7xXMwsHTVYWrxU3nK7jCaJJdJ8fSBkz55clYYtZqGPWceejyxF6KZp0mQT+g+ct7XY9QDXlzcjIT7FIbYfiq5o0ZLc2gzRdnQ2CZGHIotU1Us3+XQBJHTdzt7Q+cT+0w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772549945; c=relaxed/simple;
	bh=jsHmcRTwSYXWV0NQ7akNiCpmZSEUere/Vg3ckiSm75M=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=NgAHGfvhAbXJFbQIUnk7We5ZJuWjoPIddVDyN4RPedudZtTjokm8P2bW7TN3E70IDHlnvAcyd1AF86uocFRim3miY3Gx1eeOJp6iwRMBtpx4f7RAzUc3SwN+agSKiYwRolWZ3+fAr5h+rW8QYp2vHnrSqgTvbwD0iQJ3v+51lHQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=renesas.com; spf=pass smtp.mailfrom=renesas.com; arc=none smtp.client-ip=210.160.252.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=renesas.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=renesas.com
X-CSE-ConnectionGUID: u7EqF9WKTXKRYtkXA6aSNg==
X-CSE-MsgGUID: PBIVzJ5sQzuJRrMv6FCszg==
Received: from unknown (HELO relmlir5.idc.renesas.com) ([10.200.68.151])
  by relmlie6.idc.renesas.com with ESMTP; 03 Mar 2026 23:59:02 +0900
Received: from vm01.adwin.renesas.com (unknown [10.226.92.15])
	by relmlir5.idc.renesas.com (Postfix) with ESMTP id ABA92401006A;
	Tue,  3 Mar 2026 23:58:56 +0900 (JST)
From: Ovidiu Panait <ovidiu.panait.rb@renesas.com>
To: andrew+netdev@lunn.ch,
	davem@davemloft.net,
	edumazet@google.com,
	kuba@kernel.org,
	pabeni@redhat.com,
	mcoquelin.stm32@gmail.com,
	alexandre.torgue@foss.st.com,
	linux@armlinux.org.uk,
	rmk+kernel@armlinux.org.uk,
	maxime.chevallier@bootlin.com,
	boon.khai.ng@altera.com,
	rohan.g.thomas@altera.com,
	vladimir.oltean@nxp.com,
	hayashi.kunihiko@socionext.com,
	boon.leong.ong@intel.com,
	kim.tatt.chuah@intel.com
Cc: netdev@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org,
	linux-stm32@st-md-mailman.stormreply.com,
	linux-kernel@vger.kernel.org
Subject: [PATCH net v3 4/4] net: stmmac: Defer VLAN HW configuration when interface is down
Date: Tue,  3 Mar 2026 14:58:28 +0000
Message-ID: <20260303145828.7845-5-ovidiu.panait.rb@renesas.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260303145828.7845-1-ovidiu.panait.rb@renesas.com>
References: <20260303145828.7845-1-ovidiu.panait.rb@renesas.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Rspamd-Queue-Id: 33F1B1F2118
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [1.64 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	MID_CONTAINS_FROM(1.00)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_MISSING_CHARSET(0.50)[];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c04:e001:36c::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	DMARC_POLICY_SOFTFAIL(0.10)[renesas.com : SPF not aligned (relaxed), No valid DKIM,none];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-263262-lists,netdev=lfdr.de];
	TO_DN_NONE(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	FROM_HAS_DN(0.00)[];
	FREEMAIL_TO(0.00)[lunn.ch,davemloft.net,google.com,kernel.org,redhat.com,gmail.com,foss.st.com,armlinux.org.uk,bootlin.com,altera.com,nxp.com,socionext.com,intel.com];
	MIME_TRACE(0.00)[0:+];
	FROM_NEQ_ENVFROM(0.00)[ovidiu.panait.rb@renesas.com,netdev@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c04::/32, country:SG];
	R_DKIM_NA(0.00)[];
	NEURAL_HAM(-0.00)[-0.557];
	RCVD_COUNT_FIVE(0.00)[5];
	TAGGED_RCPT(0.00)[netdev,kernel];
	PRECEDENCE_BULK(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[20];
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:rdns,tor.lore.kernel.org:helo,renesas.com:mid,renesas.com:email]
X-Rspamd-Action: no action

VLAN register accesses on the MAC side require the PHY RX clock to be
active. When the network interface is down, the PHY is suspended and
the RX clock is unavailable, causing VLAN operations to fail with
timeouts.

The VLAN core automatically removes VID 0 after the interface goes down
and re-adds it when it comes back up, so these timeouts happen during
normal interface down/up:

    # ip link set end1 down
    renesas-gbeth 15c40000.ethernet end1: Timeout accessing MAC_VLAN_Tag_Filter
    renesas-gbeth 15c40000.ethernet end1: failed to kill vid 0081/0

Adding VLANs while the interface is down also fails:

    # ip link add link end1 name end1.10 type vlan id 10
    renesas-gbeth 15c40000.ethernet end1: Timeout accessing MAC_VLAN_Tag_Filter
    RTNETLINK answers: Device or resource busy

To fix this, check if the interface is up before accessing VLAN registers.
The software state is always kept up to date regardless of interface state.

When the interface is brought up, stmmac_vlan_restore() is called
to write the VLAN state to hardware.

Fixes: ed64639bc1e0 ("net: stmmac: Add support for VLAN Rx filtering")
Signed-off-by: Ovidiu Panait <ovidiu.panait.rb@renesas.com>
---
v3 changes:
- Dropped the 'write_hw' approach to avoid passing attributes around.
  Instead, netif_running() checks were added directly on the VLAN paths.

v2 changes:
- Split this commit - added a new commit (3/5) which fixes VLAN
  restore on resume and open paths.
- Dropped phylink_rx_clk_stop_block()/unblock() calls around VLAN restore.

 .../net/ethernet/stmicro/stmmac/stmmac_main.c |  3 ++
 .../net/ethernet/stmicro/stmmac/stmmac_vlan.c | 42 ++++++++++---------
 2 files changed, 26 insertions(+), 19 deletions(-)

diff --git a/drivers/net/ethernet/stmicro/stmmac/stmmac_main.c b/drivers/net/ethernet/stmicro/stmmac/stmmac_main.c
index a8fb091d7b5d..536d513bdad5 100644
--- a/drivers/net/ethernet/stmicro/stmmac/stmmac_main.c
+++ b/drivers/net/ethernet/stmicro/stmmac/stmmac_main.c
@@ -6774,6 +6774,9 @@ static int stmmac_vlan_update(struct stmmac_priv *priv, bool is_double)
 		hash = 0;
 	}
 
+	if (!netif_running(priv->dev))
+		return 0;
+
 	return stmmac_update_vlan_hash(priv, priv->hw, hash, pmatch, is_double);
 }
 
diff --git a/drivers/net/ethernet/stmicro/stmmac/stmmac_vlan.c b/drivers/net/ethernet/stmicro/stmmac/stmmac_vlan.c
index fcc34867405e..e24efe3bfedb 100644
--- a/drivers/net/ethernet/stmicro/stmmac/stmmac_vlan.c
+++ b/drivers/net/ethernet/stmicro/stmmac/stmmac_vlan.c
@@ -76,7 +76,9 @@ static int vlan_add_hw_rx_fltr(struct net_device *dev,
 		}
 
 		hw->vlan_filter[0] = vid;
-		vlan_write_single(dev, vid);
+
+		if (netif_running(dev))
+			vlan_write_single(dev, vid);
 
 		return 0;
 	}
@@ -97,12 +99,15 @@ static int vlan_add_hw_rx_fltr(struct net_device *dev,
 		return -EPERM;
 	}
 
-	ret = vlan_write_filter(dev, hw, index, val);
+	if (netif_running(dev)) {
+		ret = vlan_write_filter(dev, hw, index, val);
+		if (ret)
+			return ret;
+	}
 
-	if (!ret)
-		hw->vlan_filter[index] = val;
+	hw->vlan_filter[index] = val;
 
-	return ret;
+	return 0;
 }
 
 static int vlan_del_hw_rx_fltr(struct net_device *dev,
@@ -115,7 +120,9 @@ static int vlan_del_hw_rx_fltr(struct net_device *dev,
 	if (hw->num_vlan == 1) {
 		if ((hw->vlan_filter[0] & VLAN_TAG_VID) == vid) {
 			hw->vlan_filter[0] = 0;
-			vlan_write_single(dev, 0);
+
+			if (netif_running(dev))
+				vlan_write_single(dev, 0);
 		}
 		return 0;
 	}
@@ -124,22 +131,23 @@ static int vlan_del_hw_rx_fltr(struct net_device *dev,
 	for (i = 0; i < hw->num_vlan; i++) {
 		if ((hw->vlan_filter[i] & VLAN_TAG_DATA_VEN) &&
 		    ((hw->vlan_filter[i] & VLAN_TAG_DATA_VID) == vid)) {
-			ret = vlan_write_filter(dev, hw, i, 0);
 
-			if (!ret)
-				hw->vlan_filter[i] = 0;
-			else
-				return ret;
+			if (netif_running(dev)) {
+				ret = vlan_write_filter(dev, hw, i, 0);
+				if (ret)
+					return ret;
+			}
+
+			hw->vlan_filter[i] = 0;
 		}
 	}
 
-	return ret;
+	return 0;
 }
 
 static void vlan_restore_hw_rx_fltr(struct net_device *dev,
 				    struct mac_device_info *hw)
 {
-	u32 val;
 	int i;
 
 	/* Single Rx VLAN Filter */
@@ -149,12 +157,8 @@ static void vlan_restore_hw_rx_fltr(struct net_device *dev,
 	}
 
 	/* Extended Rx VLAN Filter Enable */
-	for (i = 0; i < hw->num_vlan; i++) {
-		if (hw->vlan_filter[i] & VLAN_TAG_DATA_VEN) {
-			val = hw->vlan_filter[i];
-			vlan_write_filter(dev, hw, i, val);
-		}
-	}
+	for (i = 0; i < hw->num_vlan; i++)
+		vlan_write_filter(dev, hw, i, hw->vlan_filter[i]);
 }
 
 static void vlan_update_hash(struct mac_device_info *hw, u32 hash,
-- 
2.51.0


