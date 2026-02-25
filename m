Return-Path: <netdev+bounces-260981-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id oAMrDlcGn2mZYgQAu9opvQ
	(envelope-from <netdev+bounces-260981-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Wed, 25 Feb 2026 15:25:27 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 8FAFB198ADF
	for <lists+netdev@lfdr.de>; Wed, 25 Feb 2026 15:25:26 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id D6DF4309606B
	for <lists+netdev@lfdr.de>; Wed, 25 Feb 2026 14:24:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6CB313D3488;
	Wed, 25 Feb 2026 14:24:37 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from relmlie6.idc.renesas.com (relmlor2.renesas.com [210.160.252.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7A2EA3D3485;
	Wed, 25 Feb 2026 14:24:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=210.160.252.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772029477; cv=none; b=aA1Cm3s4QVkGiGbHUMyg+75DHvIcvubgt7+9pXvoB3M4JYLPSVBVxH1jwxx6DL8RbcYEubO22gGgZKTc88ThVisP77hpZbATlr6SPqiki758W1oZkMCeV3FK+Uz6G/f987vDxqyKpSlFh3+lU8s+qv7DGcXsfr95O/zWy1H7Ta8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772029477; c=relaxed/simple;
	bh=/j+KKokPmqND21UBiNjdIW9ARxpHY/OtdFIFrZnogdU=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=V4utqL3s6hTtHgQ9T7yCPAcH1m7nvdMwk6IB0weQu1yznPumfJSBxkd1IL0B32DWzqsB4CAzaMYIeqLTtw+VaJfWHPA5t9SF+opklAWMHuSZlOJ3tKAMxRRnEWlXk0Z6kfOGHL4riEmTfQtgeUj18Onb7kSz+B0oHqsf/wg6iXk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=renesas.com; spf=pass smtp.mailfrom=renesas.com; arc=none smtp.client-ip=210.160.252.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=renesas.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=renesas.com
X-CSE-ConnectionGUID: onbCMC7XSyWtP4f3YSZ8Uw==
X-CSE-MsgGUID: fx56hqT+ToOjKXfaFqOYPQ==
Received: from unknown (HELO relmlir5.idc.renesas.com) ([10.200.68.151])
  by relmlie6.idc.renesas.com with ESMTP; 25 Feb 2026 23:24:28 +0900
Received: from vm01.adwin.renesas.com (unknown [10.226.92.192])
	by relmlir5.idc.renesas.com (Postfix) with ESMTP id 661CC4017D8D;
	Wed, 25 Feb 2026 23:24:22 +0900 (JST)
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
Subject: [PATCH net-next v2 1/5] net: stmmac: Fix error handling in VLAN add and delete paths
Date: Wed, 25 Feb 2026 14:24:10 +0000
Message-ID: <20260225142414.130144-2-ovidiu.panait.rb@renesas.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260225142414.130144-1-ovidiu.panait.rb@renesas.com>
References: <20260225142414.130144-1-ovidiu.panait.rb@renesas.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [1.64 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	MID_CONTAINS_FROM(1.00)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_MISSING_CHARSET(0.50)[];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	DMARC_POLICY_SOFTFAIL(0.10)[renesas.com : SPF not aligned (relaxed), No valid DKIM,none];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-260981-lists,netdev=lfdr.de];
	TO_DN_NONE(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	FROM_HAS_DN(0.00)[];
	FREEMAIL_TO(0.00)[lunn.ch,davemloft.net,google.com,kernel.org,redhat.com,gmail.com,foss.st.com,armlinux.org.uk,bootlin.com,altera.com,nxp.com,socionext.com,intel.com];
	MIME_TRACE(0.00)[0:+];
	FROM_NEQ_ENVFROM(0.00)[ovidiu.panait.rb@renesas.com,netdev@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	R_DKIM_NA(0.00)[];
	NEURAL_HAM(-0.00)[-0.989];
	RCVD_COUNT_FIVE(0.00)[5];
	TAGGED_RCPT(0.00)[netdev,kernel];
	PRECEDENCE_BULK(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[20];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,renesas.com:mid,renesas.com:email]
X-Rspamd-Queue-Id: 8FAFB198ADF
X-Rspamd-Action: no action

stmmac_vlan_rx_add_vid() updates active_vlans and the VLAN hash
register before writing the HW filter entry. If the filter write
fails, it leaves a stale VID in active_vlans and the hash register.

stmmac_vlan_rx_kill_vid() has the reverse problem: it clears
active_vlans before removing the HW filter. On failure, the VID is
gone from active_vlans but still present in the HW filter table.

To fix this, reorder the operations to update the hash table first,
then attempt the HW filter operation. If the HW filter fails, roll
back both the active_vlans bitmap and the hash table by calling
stmmac_vlan_update() again.

Fixes: ed64639bc1e0 ("net: stmmac: Add support for VLAN Rx filtering")
Signed-off-by: Ovidiu Panait <ovidiu.panait.rb@renesas.com>
---
v2 changes: none.

 .../net/ethernet/stmicro/stmmac/stmmac_main.c  | 18 ++++++++++++++----
 1 file changed, 14 insertions(+), 4 deletions(-)

diff --git a/drivers/net/ethernet/stmicro/stmmac/stmmac_main.c b/drivers/net/ethernet/stmicro/stmmac/stmmac_main.c
index 82375d34ad57..f2f120ddba46 100644
--- a/drivers/net/ethernet/stmicro/stmmac/stmmac_main.c
+++ b/drivers/net/ethernet/stmicro/stmmac/stmmac_main.c
@@ -6798,9 +6798,13 @@ static int stmmac_vlan_rx_add_vid(struct net_device *ndev, __be16 proto, u16 vid
 
 	if (priv->hw->num_vlan) {
 		ret = stmmac_add_hw_vlan_rx_fltr(priv, ndev, priv->hw, proto, vid);
-		if (ret)
+		if (ret) {
+			clear_bit(vid, priv->active_vlans);
+			stmmac_vlan_update(priv, is_double);
 			goto err_pm_put;
+		}
 	}
+
 err_pm_put:
 	pm_runtime_put(priv->device);
 
@@ -6824,15 +6828,21 @@ static int stmmac_vlan_rx_kill_vid(struct net_device *ndev, __be16 proto, u16 vi
 		is_double = true;
 
 	clear_bit(vid, priv->active_vlans);
+	ret = stmmac_vlan_update(priv, is_double);
+	if (ret) {
+		set_bit(vid, priv->active_vlans);
+		goto del_vlan_error;
+	}
 
 	if (priv->hw->num_vlan) {
 		ret = stmmac_del_hw_vlan_rx_fltr(priv, ndev, priv->hw, proto, vid);
-		if (ret)
+		if (ret) {
+			set_bit(vid, priv->active_vlans);
+			stmmac_vlan_update(priv, is_double);
 			goto del_vlan_error;
+		}
 	}
 
-	ret = stmmac_vlan_update(priv, is_double);
-
 del_vlan_error:
 	pm_runtime_put(priv->device);
 
-- 
2.51.0


