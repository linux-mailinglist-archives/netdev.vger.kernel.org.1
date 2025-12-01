Return-Path: <netdev+bounces-243050-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [213.196.21.55])
	by mail.lfdr.de (Postfix) with ESMTPS id 34529C98D30
	for <lists+netdev@lfdr.de>; Mon, 01 Dec 2025 20:17:23 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id E5E1C3452B1
	for <lists+netdev@lfdr.de>; Mon,  1 Dec 2025 19:17:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 509E1238159;
	Mon,  1 Dec 2025 19:17:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=exactco.de header.i=@exactco.de header.b="EfT69K6x"
X-Original-To: netdev@vger.kernel.org
Received: from exactco.de (exactco.de [176.9.10.151])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B1D7810F1
	for <netdev@vger.kernel.org>; Mon,  1 Dec 2025 19:17:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=176.9.10.151
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1764616640; cv=none; b=CVH6Q98tqwj/U06JN76iAwG2WeABEYS30XZNVtuSYh9BRB9Y9xgR3wntUg3ypG+KzgHkQeICeKBdJ/iJi0n/Jh10jQdfpZ62iOV1sV2OlDhuR6AoaaKc36U3iH85jvYG/v09qcSDG+g5BW8bjGYCrOWXBE3D9NC0P39cICj7cjQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1764616640; c=relaxed/simple;
	bh=WFfg5ENlIgueFyYoF7Jq12a/GCDmb1nnyBFfdsz07YI=;
	h=Date:Message-Id:Cc:To:Subject:From:Mime-Version:Content-Type; b=jdQVAtmNVX0vFcnDudE7HJPrhKLSHdqpFQdiqByPfNnCHqszFALurby3DDLJ1GgJOzcF2A+yLSoPqs+CHSuruAGsXg6yv4QCSPt1vNjjIE0dvJQrPjXLUJ8iIk0ZXlDpQOtm8I08t+eD6SyZHJx25fr2AjmFcsquRcVh5OhvPMY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=exactco.de; spf=pass smtp.mailfrom=exactco.de; dkim=pass (2048-bit key) header.d=exactco.de header.i=@exactco.de header.b=EfT69K6x; arc=none smtp.client-ip=176.9.10.151
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=exactco.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=exactco.de
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=exactco.de;
	s=x; h=Content-Transfer-Encoding:Content-Type:Mime-Version:From:Subject:To:Cc
	:Message-Id:Date:Sender:Reply-To:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:
	References:List-Id:List-Help:List-Unsubscribe:List-Subscribe:List-Post:
	List-Owner:List-Archive; bh=/9zDcaGSR/6VDJwwXz1PNvhqsdPp6DrpVmlzaY49VAE=; b=E
	fT69K6xgEKGs48xvOYew/wa9ErWibv6dPub26zzQaSN7K+YC+rVbWg90aJXTj36O03fQaZeLETn5i
	1w9gvdek/rGTqJTa96vpMGMlSFQGOMNvYGZkKpEenhdd9Bp9FXVELvkBR+R9tWHB6Zjxd3WLzQU22
	LOCkKpmsmC7vBj+FJyA/gM4KgChY2/H6FUrtJ+zj7G2QHQPKYFC3GHgkAW3RMwBVVObAeXUloHI8M
	wtrsk4Cs2U1Erj8sJJcpfDtrHI6F4UDwiy0nbpUX0/B9OM9c7o9UUWDAht3cCYUyV98++ywvoeRzg
	izhgz59elYDULtTQGzkGQyFV5I3azqi7w==;
Date: Mon, 01 Dec 2025 20:17:06 +0100 (CET)
Message-Id: <20251201.201706.660956838646693149.rene@exactco.de>
Cc: Heiner Kallweit <hkallweit1@gmail.com>, nic_swsd@realtek.com
To: netdev@vger.kernel.org
Subject: [PATCH] r8169: fix RTL8117 Wake-on-Lan in DASH mode
From: =?iso-8859-1?Q?Ren=E9?= Rebe <rene@exactco.de>
X-Mailer: Mew version 6.10 on Emacs 30.2
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Type: Text/Plain; charset=utf-8
Content-Transfer-Encoding: 8bit

Wake-on-Lan does currently not work in DASH mode, e.g. the ASUS Pro WS
X570-ACE with RTL8168fp/RTL8117.

Fix by not returning early in rtl_prepare_power_down when dash_enabled.
While this fixes WOL, it still kills the OOB RTL8117 remote management
BMC connection. Fix by not calling rtl8168_driver_stop if wol is enabled.

While at it, enable wake on magic packet by default, like most other
Linux drivers do.

Signed-off-by: René Rebe <rene@exactco.de>
---

There is still another issue that should be fixed: the dirver init
kills the OOB BMC connection until if up, too. We also should probaly
not even conditionalize rtl8168_driver_stop on wol_enabled as the BMC
should always be accessible. IMHO even on module unload.

---
 drivers/net/ethernet/realtek/r8169_main.c | 9 +++++----
 1 file changed, 5 insertions(+), 4 deletions(-)

diff --git a/drivers/net/ethernet/realtek/r8169_main.c b/drivers/net/ethernet/realtek/r8169_main.c
index 853aabedb128..e2f9b9027fe2 100644
--- a/drivers/net/ethernet/realtek/r8169_main.c
+++ b/drivers/net/ethernet/realtek/r8169_main.c
@@ -2669,9 +2669,6 @@ static void rtl_wol_enable_rx(struct rtl8169_private *tp)
 
 static void rtl_prepare_power_down(struct rtl8169_private *tp)
 {
-	if (tp->dash_enabled)
-		return;
-
 	if (tp->mac_version == RTL_GIGA_MAC_VER_32 ||
 	    tp->mac_version == RTL_GIGA_MAC_VER_33)
 		rtl_ephy_write(tp, 0x19, 0xff64);
@@ -4807,7 +4804,7 @@ static void rtl8169_down(struct rtl8169_private *tp)
 	rtl_disable_exit_l1(tp);
 	rtl_prepare_power_down(tp);
 
-	if (tp->dash_type != RTL_DASH_NONE)
+	if (tp->dash_type != RTL_DASH_NONE && !tp->saved_wolopts)
 		rtl8168_driver_stop(tp);
 }
 
@@ -5406,6 +5403,7 @@ static int rtl_init_one(struct pci_dev *pdev, const struct pci_device_id *ent)
 	tp->pci_dev = pdev;
 	tp->supports_gmii = ent->driver_data == RTL_CFG_NO_GBIT ? 0 : 1;
 	tp->ocp_base = OCP_STD_PHY_BASE;
+	tp->saved_wolopts = WAKE_MAGIC;
 
 	raw_spin_lock_init(&tp->mac_ocp_lock);
 	mutex_init(&tp->led_lock);
@@ -5565,6 +5563,9 @@ static int rtl_init_one(struct pci_dev *pdev, const struct pci_device_id *ent)
 	if (rc)
 		return rc;
 
+	if (tp->saved_wolopts)
+		__rtl8169_set_wol(tp, tp->saved_wolopts);
+
 	rc = register_netdev(dev);
 	if (rc)
 		return rc;
-- 
2.46.0

-- 
René Rebe, ExactCODE GmbH, Berlin, Germany
https://exactco.de • https://t2linux.com • https://patreon.com/renerebe

