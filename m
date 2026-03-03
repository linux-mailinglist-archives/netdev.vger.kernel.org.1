Return-Path: <netdev+bounces-263260-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id IHDED/73pmk7bgAAu9opvQ
	(envelope-from <netdev+bounces-263260-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Tue, 03 Mar 2026 16:02:22 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [104.64.211.4])
	by mail.lfdr.de (Postfix) with ESMTPS id F2DB11F1F45
	for <lists+netdev@lfdr.de>; Tue, 03 Mar 2026 16:02:20 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id 88727303C105
	for <lists+netdev@lfdr.de>; Tue,  3 Mar 2026 14:59:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BE89D48122C;
	Tue,  3 Mar 2026 14:58:51 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from relmlie6.idc.renesas.com (relmlor2.renesas.com [210.160.252.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B99B147F2EF;
	Tue,  3 Mar 2026 14:58:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=210.160.252.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772549931; cv=none; b=YPWT2wpZ7fR+HqhfQ2uzVMLAzwf9cOtcZ/c99gHJGWfQQWRDNKzyGRFSwVZbJQE8KZmuiPzfgoxpGFv/dl8qneDmQSM19sXGiOhX0XBvZog9NDo9X5zuwG1W0Kd/JiphLSMgZyJ6uDjOchQmcuMPRwmoRHgRB5TpeOV3J5aPYKE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772549931; c=relaxed/simple;
	bh=FLv0YOxZuBU+xNlmH9S5SZOiBrCIe/USODwl8gAaZGI=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=ZKjL+nR6EQVr8YC75+pyfHQhY5Lx1T/UNq4qFqByNbNxPOczusf7iM/1m1N8B1cTRLaKhexpGfbogXGUFDfaNOdOOeS9Bl5ctdbCPluecZDIdxRbhC3cE6zbr4s8I8Z89aLnCcPh8qyqfzVZwQSdTBmmwAD0q7EocbqKTlamZGw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=renesas.com; spf=pass smtp.mailfrom=renesas.com; arc=none smtp.client-ip=210.160.252.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=renesas.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=renesas.com
X-CSE-ConnectionGUID: FKUiEAa7QWySMLK+hu3+Ag==
X-CSE-MsgGUID: 4ltcrwNwQbiL1ECACIVy2w==
Received: from unknown (HELO relmlir5.idc.renesas.com) ([10.200.68.151])
  by relmlie6.idc.renesas.com with ESMTP; 03 Mar 2026 23:58:49 +0900
Received: from vm01.adwin.renesas.com (unknown [10.226.92.15])
	by relmlir5.idc.renesas.com (Postfix) with ESMTP id 52014400D0EA;
	Tue,  3 Mar 2026 23:58:43 +0900 (JST)
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
Subject: [PATCH net v3 2/4] net: stmmac: Improve double VLAN handling
Date: Tue,  3 Mar 2026 14:58:26 +0000
Message-ID: <20260303145828.7845-3-ovidiu.panait.rb@renesas.com>
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
X-Rspamd-Queue-Id: F2DB11F1F45
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [1.64 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	MID_CONTAINS_FROM(1.00)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_MISSING_CHARSET(0.50)[];
	R_SPF_ALLOW(-0.20)[+ip4:104.64.211.4:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	DMARC_POLICY_SOFTFAIL(0.10)[renesas.com : SPF not aligned (relaxed), No valid DKIM,none];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-263260-lists,netdev=lfdr.de];
	TO_DN_NONE(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	FROM_HAS_DN(0.00)[];
	FREEMAIL_TO(0.00)[lunn.ch,davemloft.net,google.com,kernel.org,redhat.com,gmail.com,foss.st.com,armlinux.org.uk,bootlin.com,altera.com,nxp.com,socionext.com,intel.com];
	MIME_TRACE(0.00)[0:+];
	FROM_NEQ_ENVFROM(0.00)[ovidiu.panait.rb@renesas.com,netdev@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	ASN(0.00)[asn:63949, ipnet:104.64.192.0/19, country:SG];
	R_DKIM_NA(0.00)[];
	NEURAL_HAM(-0.00)[-0.585];
	RCVD_COUNT_FIVE(0.00)[5];
	TAGGED_RCPT(0.00)[netdev,kernel];
	PRECEDENCE_BULK(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[20];
	DBL_BLOCKED_OPENRESOLVER(0.00)[renesas.com:mid,renesas.com:email,sin.lore.kernel.org:rdns,sin.lore.kernel.org:helo]
X-Rspamd-Action: no action

The double VLAN bits (EDVLP, ESVL, DOVLTC) are handled inconsistently
between the two vlan_update_hash() implementations:

- dwxgmac2_update_vlan_hash() explicitly clears the double VLAN bits when
is_double is false, meaning that adding a 802.1Q VLAN will disable
double VLAN mode:

  $ ip link add link eth0 name eth0.200 type vlan id 200 protocol 802.1ad
  $ ip link add link eth0 name eth0.100 type vlan id 100
  # Double VLAN bits no longer set

- vlan_update_hash() sets these bits and only clears them when the last
VLAN has been removed, so double VLAN mode remains enabled even after all
802.1AD VLANs are removed.

Address both issues by tracking the number of active 802.1AD VLANs in
priv->num_double_vlans. Pass this count to stmmac_vlan_update() so both
implementations correctly set the double VLAN bits when any 802.1AD
VLAN is active, and clear them only when none remain.

Also update vlan_update_hash() to explicitly clear the double VLAN bits
when is_double is false, matching the dwxgmac2 behavior.

Signed-off-by: Ovidiu Panait <ovidiu.panait.rb@renesas.com>
---
v3 changes: none.

v2 changes: none.

 drivers/net/ethernet/stmicro/stmmac/stmmac.h     |  1 +
 .../net/ethernet/stmicro/stmmac/stmmac_main.c    | 16 ++++++++++++----
 .../net/ethernet/stmicro/stmmac/stmmac_vlan.c    |  8 ++++++++
 3 files changed, 21 insertions(+), 4 deletions(-)

diff --git a/drivers/net/ethernet/stmicro/stmmac/stmmac.h b/drivers/net/ethernet/stmicro/stmmac/stmmac.h
index 51c96a738151..33667a26708c 100644
--- a/drivers/net/ethernet/stmicro/stmmac/stmmac.h
+++ b/drivers/net/ethernet/stmicro/stmmac/stmmac.h
@@ -323,6 +323,7 @@ struct stmmac_priv {
 	void __iomem *ptpaddr;
 	void __iomem *estaddr;
 	unsigned long active_vlans[BITS_TO_LONGS(VLAN_N_VID)];
+	unsigned int num_double_vlans;
 	int sfty_irq;
 	int sfty_ce_irq;
 	int sfty_ue_irq;
diff --git a/drivers/net/ethernet/stmicro/stmmac/stmmac_main.c b/drivers/net/ethernet/stmicro/stmmac/stmmac_main.c
index d979a3ebd28e..2365b12fbe05 100644
--- a/drivers/net/ethernet/stmicro/stmmac/stmmac_main.c
+++ b/drivers/net/ethernet/stmicro/stmmac/stmmac_main.c
@@ -6780,6 +6780,7 @@ static int stmmac_vlan_update(struct stmmac_priv *priv, bool is_double)
 static int stmmac_vlan_rx_add_vid(struct net_device *ndev, __be16 proto, u16 vid)
 {
 	struct stmmac_priv *priv = netdev_priv(ndev);
+	unsigned int num_double_vlans;
 	bool is_double = false;
 	int ret;
 
@@ -6791,7 +6792,8 @@ static int stmmac_vlan_rx_add_vid(struct net_device *ndev, __be16 proto, u16 vid
 		is_double = true;
 
 	set_bit(vid, priv->active_vlans);
-	ret = stmmac_vlan_update(priv, is_double);
+	num_double_vlans = priv->num_double_vlans + is_double;
+	ret = stmmac_vlan_update(priv, num_double_vlans);
 	if (ret) {
 		clear_bit(vid, priv->active_vlans);
 		goto err_pm_put;
@@ -6801,11 +6803,13 @@ static int stmmac_vlan_rx_add_vid(struct net_device *ndev, __be16 proto, u16 vid
 		ret = stmmac_add_hw_vlan_rx_fltr(priv, ndev, priv->hw, proto, vid);
 		if (ret) {
 			clear_bit(vid, priv->active_vlans);
-			stmmac_vlan_update(priv, is_double);
+			stmmac_vlan_update(priv, priv->num_double_vlans);
 			goto err_pm_put;
 		}
 	}
 
+	priv->num_double_vlans = num_double_vlans;
+
 err_pm_put:
 	pm_runtime_put(priv->device);
 
@@ -6818,6 +6822,7 @@ static int stmmac_vlan_rx_add_vid(struct net_device *ndev, __be16 proto, u16 vid
 static int stmmac_vlan_rx_kill_vid(struct net_device *ndev, __be16 proto, u16 vid)
 {
 	struct stmmac_priv *priv = netdev_priv(ndev);
+	unsigned int num_double_vlans;
 	bool is_double = false;
 	int ret;
 
@@ -6829,7 +6834,8 @@ static int stmmac_vlan_rx_kill_vid(struct net_device *ndev, __be16 proto, u16 vi
 		is_double = true;
 
 	clear_bit(vid, priv->active_vlans);
-	ret = stmmac_vlan_update(priv, is_double);
+	num_double_vlans = priv->num_double_vlans - is_double;
+	ret = stmmac_vlan_update(priv, num_double_vlans);
 	if (ret) {
 		set_bit(vid, priv->active_vlans);
 		goto del_vlan_error;
@@ -6839,11 +6845,13 @@ static int stmmac_vlan_rx_kill_vid(struct net_device *ndev, __be16 proto, u16 vi
 		ret = stmmac_del_hw_vlan_rx_fltr(priv, ndev, priv->hw, proto, vid);
 		if (ret) {
 			set_bit(vid, priv->active_vlans);
-			stmmac_vlan_update(priv, is_double);
+			stmmac_vlan_update(priv, priv->num_double_vlans);
 			goto del_vlan_error;
 		}
 	}
 
+	priv->num_double_vlans = num_double_vlans;
+
 del_vlan_error:
 	pm_runtime_put(priv->device);
 
diff --git a/drivers/net/ethernet/stmicro/stmmac/stmmac_vlan.c b/drivers/net/ethernet/stmicro/stmmac/stmmac_vlan.c
index b18404dd5a8b..de1a70e1c86e 100644
--- a/drivers/net/ethernet/stmicro/stmmac/stmmac_vlan.c
+++ b/drivers/net/ethernet/stmicro/stmmac/stmmac_vlan.c
@@ -183,6 +183,10 @@ static void vlan_update_hash(struct mac_device_info *hw, u32 hash,
 			value |= VLAN_EDVLP;
 			value |= VLAN_ESVL;
 			value |= VLAN_DOVLTC;
+		} else {
+			value &= ~VLAN_EDVLP;
+			value &= ~VLAN_ESVL;
+			value &= ~VLAN_DOVLTC;
 		}
 
 		writel(value, ioaddr + VLAN_TAG);
@@ -193,6 +197,10 @@ static void vlan_update_hash(struct mac_device_info *hw, u32 hash,
 			value |= VLAN_EDVLP;
 			value |= VLAN_ESVL;
 			value |= VLAN_DOVLTC;
+		} else {
+			value &= ~VLAN_EDVLP;
+			value &= ~VLAN_ESVL;
+			value &= ~VLAN_DOVLTC;
 		}
 
 		writel(value | perfect_match, ioaddr + VLAN_TAG);
-- 
2.51.0


