Return-Path: <netdev+bounces-257658-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id +OBLJt9ihmlyMgQAu9opvQ
	(envelope-from <netdev+bounces-257658-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Fri, 06 Feb 2026 22:53:35 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id 18CA4103995
	for <lists+netdev@lfdr.de>; Fri, 06 Feb 2026 22:53:34 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id E82A13013B64
	for <lists+netdev@lfdr.de>; Fri,  6 Feb 2026 21:53:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2899B312826;
	Fri,  6 Feb 2026 21:53:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="HDoe48c/"
X-Original-To: netdev@vger.kernel.org
Received: from mail-wr1-f44.google.com (mail-wr1-f44.google.com [209.85.221.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AF84031280C
	for <netdev@vger.kernel.org>; Fri,  6 Feb 2026 21:53:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770414811; cv=none; b=SW2UErEf2Kql48iErcegopsjqRTc9L2L8O2R60XGplvL1hLfbzwVc3evFYL/90JntFh1+HmfutqBNBAm8ySDC4VKYXovyH4rs33IDoj67XGJW4jjhoZS9zWx4DEtv0P0zrm35QYwwis6G4p8Ms789nXO1L6HW32cMzucJG9YDfQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770414811; c=relaxed/simple;
	bh=N+K+u5vfKMyiGUx+T0sMrtyHfAeD78DEAek8Bx0L4zA=;
	h=Message-ID:Date:MIME-Version:To:Cc:From:Subject:Content-Type; b=kFR85HBt5OtcoBOOxIxFhq18BCgfF9LiOLSnc+ZZyVPOvEF1IF4Mc28BIvBVxVK8VVSzNgtciZIbAluQacku+NSY8nHxigXR96sn9Lj1WYc7n61LhywjBycFQsGL1AsOq3FyAFIJcXosZWLZbBin/ewezXYSXr3nEE/Ls4BLr44=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=HDoe48c/; arc=none smtp.client-ip=209.85.221.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wr1-f44.google.com with SMTP id ffacd0b85a97d-4359249bbacso2194473f8f.0
        for <netdev@vger.kernel.org>; Fri, 06 Feb 2026 13:53:30 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1770414809; x=1771019609; darn=vger.kernel.org;
        h=content-transfer-encoding:subject:from:cc:to:content-language
         :user-agent:mime-version:date:message-id:from:to:cc:subject:date
         :message-id:reply-to;
        bh=zAl16RgQK7YFCIKgzNT/s5NyKcYOEtIJSgcBAHgZb7s=;
        b=HDoe48c/Sh/GixgFeEhGiXRICOx/j7IdK1TgdROkAVUiFzmZiKwPaOGucohEEZSIW9
         +QZBPkrNJ6HB1228kCdkxQ3NR2y4hFNoYRRcRkkoNU8PWuv8mfkaWJ0WFQTLJ1WTdy9I
         C3qKVUohU/mSRW/i5vrd8wfyNvkd9sWupz5yI28YlMlUgTPbInWJJD3b+M4l/HBCn7DA
         aP/+TnW/RKOaUZH8BI4XJ1S2MMKpqoz1R4vd/CaNN2MwOswMbsB4tkj8BbwMFnFHzuWV
         XPwW/eW19gbwFjY8ZxZ+JQm6WLtsKAq8WgfIW8Gvq9x9DvN8jV6cChFOs8FBjywdwOwe
         6m2A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1770414809; x=1771019609;
        h=content-transfer-encoding:subject:from:cc:to:content-language
         :user-agent:mime-version:date:message-id:x-gm-gg:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=zAl16RgQK7YFCIKgzNT/s5NyKcYOEtIJSgcBAHgZb7s=;
        b=MavktfUqyBHQkjxScHNy7CFx5Aaw7DxYzz/IC/O0EDEYgzY61IB+mB31IYInn7Bmnp
         tplixDDxJH/sZrMzcIXRlXdyy9phznNZFvy61qQzfrFBNok1iw8S2Nx8ick+rXkOnXbk
         ByIAtXY7scwQ48Xh8bokufAzw3Nafb6fwoBHsSOnBufTuguA2RwF2VCdvYq3D+L87JMB
         CroSpu6L43g9WJAZ3gKf2jvOGWK74uYjFSd12ybTwh/uyS7GHHfiCB2w6j6dh7sX6JPO
         FY8LnodcpS+cxRdz7GyL4GdV0j30n1r7HW/tu/P3O4DmPVxOuQBXYfcz3QTFrnpULDh3
         93bw==
X-Gm-Message-State: AOJu0Yz3W/TU9gyWrOIYS7rAj9RRFI+YeGCy1FUuGMMv967sPTCtgbcc
	OBgkIr6BhEzLro9VS0ORVPJQfnMeBwR4x4XJ8+qXChArbmHNoxciLGc7
X-Gm-Gg: AZuq6aLWauBCPHx6siYehhBbNeGa9PJqbKun2YJe21M08yyEU6yR80Zy1EGvpz5EYuf
	jl3w5zvrdJNPQmiQXq2ZPdIWTGJf74tMr8dFsZqRpM02lKAHqbR9TMUUzU8gNb2cpgN8uqMbFPy
	v4G/HdRwJs5dpn0oKM9WGDtDgojxCTBLUwRodz219smyT0M6juZHe4BcXUXiozTCQri5jYIh3W8
	ag9RB+MJYClFHWvQZWVwldd90naYEBpES4ir/6DvyeHWQfIQ5LvcYB5GvxWsMaRUe7k+ACsqkk8
	tkJn9u5qhKgm/nz1bUkhXLxuU4qLjUG7ynkR0xiaxNyjyQR54GYm+6xT2NAtVeGsP7vQgAyGpXX
	xJvBP3JM1wkZLOQAY+zT70qz2VuyuDaLlMiiy/8AC2zxkgTIflxD/paM/MKEDJzfuxqVgMejmsn
	zLrWWK8Ht5GvJrBpTqg/2i40MguZCwNjYyA5xniXcYD+L53YoZU70gCs2j05E++lc0cO43E6/jT
	F12VdNrhwuT4HquqBZrGTymNa7QHUXhsUMoS1F6GRcdnlAsZU9clA==
X-Received: by 2002:a5d:5f55:0:b0:435:8dd5:ad4f with SMTP id ffacd0b85a97d-436209964d4mr12103443f8f.9.1770414808890;
        Fri, 06 Feb 2026 13:53:28 -0800 (PST)
Received: from ?IPV6:2003:ea:8f15:8200:e142:60ff:2daa:1023? (p200300ea8f158200e14260ff2daa1023.dip0.t-ipconnect.de. [2003:ea:8f15:8200:e142:60ff:2daa:1023])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-43629664632sm8463498f8f.0.2026.02.06.13.53.27
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 06 Feb 2026 13:53:28 -0800 (PST)
Message-ID: <5bc19909-0fc7-485c-a573-4819eeea5b5d@gmail.com>
Date: Fri, 6 Feb 2026 22:53:26 +0100
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Content-Language: en-US
To: Linus Walleij <linus.walleij@linaro.org>, Paolo Abeni
 <pabeni@redhat.com>, Eric Dumazet <edumazet@google.com>,
 David Miller <davem@davemloft.net>, Andrew Lunn <andrew+netdev@lunn.ch>,
 Simon Horman <horms@kernel.org>, Siddharth Vadapalli <s-vadapalli@ti.com>,
 Roger Quadros <rogerq@kernel.org>, Jakub Kicinski <kuba@kernel.org>
Cc: "netdev@vger.kernel.org" <netdev@vger.kernel.org>,
 linux-omap@vger.kernel.org
From: Heiner Kallweit <hkallweit1@gmail.com>
Subject: [PATCH net-next] net: ethernet: ti: davinci_emac: remove member
 phy_id from struct emac_platform_data
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.66 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[gmail.com,none];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20230601];
	R_SPF_ALLOW(-0.20)[+ip4:172.105.105.114:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-257658-lists,netdev=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	TO_DN_EQ_ADDR_SOME(0.00)[];
	MIME_TRACE(0.00)[0:+];
	DKIM_TRACE(0.00)[gmail.com:+];
	FREEMAIL_FROM(0.00)[gmail.com];
	TO_DN_SOME(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	FROM_HAS_DN(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[hkallweit1@gmail.com,netdev@vger.kernel.org];
	ASN(0.00)[asn:63949, ipnet:172.105.96.0/20, country:SG];
	NEURAL_HAM(-0.00)[-0.988];
	RCPT_COUNT_SEVEN(0.00)[11];
	MID_RHS_MATCH_FROM(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: 18CA4103995
X-Rspamd-Action: no action

b4aed01de486 ("ARM: davinci: Delete DM646x board files") removed the
last user of member phy_id. So let's remove phy_id.

Signed-off-by: Heiner Kallweit <hkallweit1@gmail.com>
---
 drivers/net/ethernet/ti/davinci_emac.c | 24 ++++++++++--------------
 include/linux/davinci_emac.h           |  9 ---------
 2 files changed, 10 insertions(+), 23 deletions(-)

diff --git a/drivers/net/ethernet/ti/davinci_emac.c b/drivers/net/ethernet/ti/davinci_emac.c
index ed8116fb05e..df51441a2b8 100644
--- a/drivers/net/ethernet/ti/davinci_emac.c
+++ b/drivers/net/ethernet/ti/davinci_emac.c
@@ -329,7 +329,6 @@ struct emac_priv {
 	u32 mac_hash2;
 	u32 multicast_hash_cnt[EMAC_NUM_MULTICAST_BITS];
 	u32 rx_addr_type;
-	const char *phy_id;
 	struct device_node *phy_node;
 	spinlock_t lock;
 	/*platform specific members*/
@@ -1418,6 +1417,7 @@ static int emac_dev_open(struct net_device *ndev)
 	struct emac_priv *priv = netdev_priv(ndev);
 	struct phy_device *phydev = NULL;
 	struct device *phy = NULL;
+	const char *phy_id = NULL;
 
 	ret = pm_runtime_resume_and_get(&priv->pdev->dev);
 	if (ret < 0) {
@@ -1502,8 +1502,8 @@ static int emac_dev_open(struct net_device *ndev)
 		}
 	}
 
-	/* use the first phy on the bus if pdata did not give us a phy id */
-	if (!phydev && !priv->phy_id) {
+	/* use the first phy on the bus */
+	if (!phydev) {
 		/* NOTE: we can't use bus_find_device_by_name() here because
 		 * the device name is not guaranteed to be 'davinci_mdio'. On
 		 * some systems it can be 'davinci_mdio.0' so we need to use
@@ -1513,20 +1513,19 @@ static int emac_dev_open(struct net_device *ndev)
 		phy = bus_find_device(&mdio_bus_type, NULL, NULL,
 				      match_first_device);
 		if (phy) {
-			priv->phy_id = dev_name(phy);
-			if (!priv->phy_id || !*priv->phy_id)
+			phy_id = dev_name(phy);
+			if (!phy_id || !*phy_id)
 				put_device(phy);
 		}
 	}
 
-	if (!phydev && priv->phy_id && *priv->phy_id) {
-		phydev = phy_connect(ndev, priv->phy_id,
-				     &emac_adjust_link,
+	if (!phydev && phy_id && *phy_id) {
+		phydev = phy_connect(ndev, phy_id, &emac_adjust_link,
 				     PHY_INTERFACE_MODE_MII);
 		put_device(phy);	/* reference taken by bus_find_device */
 		if (IS_ERR(phydev)) {
 			dev_err(emac_dev, "could not connect to phy %s\n",
-				priv->phy_id);
+				phy_id);
 			ret = PTR_ERR(phydev);
 			goto err;
 		}
@@ -1761,10 +1760,8 @@ davinci_emac_of_get_pdata(struct platform_device *pdev, struct emac_priv *priv)
 	pdata->no_bd_ram = of_property_read_bool(np, "ti,davinci-no-bd-ram");
 
 	priv->phy_node = of_parse_phandle(np, "phy-handle", 0);
-	if (!priv->phy_node) {
-		if (!of_phy_is_fixed_link(np))
-			pdata->phy_id = NULL;
-		else if (of_phy_register_fixed_link(np) >= 0)
+	if (!priv->phy_node && of_phy_is_fixed_link(np)) {
+		if (!of_phy_register_fixed_link(np))
 			priv->phy_node = of_node_get(np);
 	}
 
@@ -1846,7 +1843,6 @@ static int davinci_emac_probe(struct platform_device *pdev)
 
 	/* MAC addr and PHY mask , RMII enable info from platform_data */
 	memcpy(priv->mac_addr, pdata->mac_addr, ETH_ALEN);
-	priv->phy_id = pdata->phy_id;
 	priv->rmii_en = pdata->rmii_en;
 	priv->version = pdata->version;
 	priv->int_enable = pdata->interrupt_enable;
diff --git a/include/linux/davinci_emac.h b/include/linux/davinci_emac.h
index 28e6cf1356d..c1482557d3e 100644
--- a/include/linux/davinci_emac.h
+++ b/include/linux/davinci_emac.h
@@ -25,15 +25,6 @@ struct emac_platform_data {
 	u32 ctrl_ram_offset;
 	u32 hw_ram_addr;
 	u32 ctrl_ram_size;
-
-	/*
-	 * phy_id can be one of the following:
-	 *   - NULL		: use the first phy on the bus,
-	 *   - ""		: force to 100/full, no mdio control
-	 *   - "<bus>:<addr>"	: use the specified bus and phy
-	 */
-	const char *phy_id;
-
 	u8 rmii_en;
 	u8 version;
 	bool no_bd_ram;
-- 
2.53.0


