Return-Path: <netdev+bounces-225012-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 9B752B8D19C
	for <lists+netdev@lfdr.de>; Sat, 20 Sep 2025 23:33:33 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id DAEB97C1FA8
	for <lists+netdev@lfdr.de>; Sat, 20 Sep 2025 21:33:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 66310285069;
	Sat, 20 Sep 2025 21:33:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Hn+2pUEk"
X-Original-To: netdev@vger.kernel.org
Received: from mail-wr1-f44.google.com (mail-wr1-f44.google.com [209.85.221.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 869A328313A
	for <netdev@vger.kernel.org>; Sat, 20 Sep 2025 21:33:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758404002; cv=none; b=Z1yVMJbcmkwQSE/EYNMgfF/DQzpfO5tEIiKsBKRtrNbDOMxZ7fLRo4JFG0vezCf9WR+WflYfL4G+fq1hEA/FxWUdzaFvdUkgARR+awQ+Y39nhLDbdBbnoP2TsxMH3MMPIDSF+NQjfKNbZOiNljZZGz+Il+ag4EaQ/pp/Z/xL1FQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758404002; c=relaxed/simple;
	bh=ivzawLq+7cBUcJerwkS2Y1R9E4Y0QGQK/JI8cNgvv8k=;
	h=Message-ID:Date:MIME-Version:Subject:From:To:Cc:References:
	 In-Reply-To:Content-Type; b=fqObdrl1Nc2HNsO6vsRpD8rKdC70Q8QH76I6liuvDoUf37gtpEdg13QIRFHP8pGtwyxMEE2y9VZgVZYIZaFbanJ0TpZ/dzmFhxJ/sgGxht5oHDFj7E4ac0j3bDT8WCCEFKE2u9g2Jra1jYWrhNuH7UzJ4dRl6QV8wvJvZPyGrSk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Hn+2pUEk; arc=none smtp.client-ip=209.85.221.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wr1-f44.google.com with SMTP id ffacd0b85a97d-3f2ae6fadb4so1138905f8f.1
        for <netdev@vger.kernel.org>; Sat, 20 Sep 2025 14:33:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1758403999; x=1759008799; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:autocrypt:content-language
         :references:cc:to:from:subject:user-agent:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=8j4WWqPkFCt4STe5Jmiax3LsKU17rjweqCuHOsE8gLg=;
        b=Hn+2pUEkICyIiFS9eZSKT+qFq6/u3C5LUfcDyPDCm/u6aE2j5k59d1dckhmiuJWyjq
         Sn+qzrYhPjy/4MS3KyysEMIiwW9MC0rUgfCWkgjKf2AZnhtqFbMZQjNhIVRSsg+Q40Cq
         HD7kavisJ286yHdIVgvYQ8jOEvDAWrYPvPVHKWanK5GSpSn/n2ZktThSyHC+o45d2cIa
         ILYDhAfRwqqzPO9FvqjeG3bkqMR/zZC6OyiCEz5AagUdOa4XCtlzKvpjO+6vwmFqAhzo
         avKIDSDAY5hgEkbd5WwcdCD0qWGYtydtvIGRpZgJDRsaA7GQBUQ2oKjA3pNBVzNVg/TC
         J5xg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1758403999; x=1759008799;
        h=content-transfer-encoding:in-reply-to:autocrypt:content-language
         :references:cc:to:from:subject:user-agent:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=8j4WWqPkFCt4STe5Jmiax3LsKU17rjweqCuHOsE8gLg=;
        b=u6xWjcK+wxXFezpk2GDf2aj3Cin5yuoI+s5rSfufMEoly0FqEdeoMSj7I1gtgVtx93
         C01fzBHg8DZrC6TcLBepvURQjZeWJUkiXHVwdPGtxR0tHfrc/Z/ClUHXIU+jpV2PSCYt
         RiCsUNlM7mATmKS02/vRtYgnOeoO83PoNGQb7kiyAWeNnXpG2aj57eO4PwXu3Oj+lyCp
         6mpyeghdikbO9UgmM5BNFF4CmEdCXGJlXGzbdBRPi6ICMBrIIBoz3+cL8d6w0GJANhKe
         6y1Qv6KfRG8ew5nSEnVomdvdWZfHEXeqrQHPPeHqAHsEJew+2PgFfUCPSJkKdPZXz7wd
         Z+Yg==
X-Gm-Message-State: AOJu0Yy+qXfHuk0ob1Ee+YJMdpKGLbjODe+d/dCwwQm2Vjg93e8E5Akk
	xGaFptaUNSktNjcLUPHpCzIahhZJl+7W4jpm4xiYE0wT68qsFDdGukL1
X-Gm-Gg: ASbGncuazahxd7q/IGOT8koWNBCpDP9EJQ4cr5Njh7odqcguH2hGnovGdiT9O+vN0KH
	E+K5GfriAAnu4t6DeXg1ltYxebV+P4RmONgUIdldzqd0iBGFgr4bnV1GsBf2fOhSPCEQZ8QPyrD
	UNx0vZeyYTrxN5uW1RER4rHg3tiaFlZc92rvjKPF8XL8c+mw0RGjYpX1OiIJyHLNm/NdoqSyv0/
	l1mIDuFz62zy3HuNRz7ryYtcX9/gtS6HDl6hQ8VaG+HiVDIdu0PXgR7DlN0EVlwB7/tvxf3MwR1
	suxitU0zZ48IPd8Qqhyd2LMKFSeKzbTXOfeVmVpTzh3LTxuqSwHGoeu4PMGqz5OEMYWNgFItSp3
	jOi/6UTvnI42NwXV8t/Y+lJ+sSzvxkNbFYIC3t7Z0fUGDtMlOThNNHMI/a7Z4u+cvNZ0L5xLT/O
	3KfHqaoMmObKvt1ce2QFRHOwK6e/Ejr3+MFaKVnLwQabswLm7uxHW+cA7TRBs=
X-Google-Smtp-Source: AGHT+IG0/82UqetD7ybHkYl5eW2u0RG5al+Vd2/FSRQKBSJDyiRqrfqhHHtx3eBEUxxxPhthI9Ewig==
X-Received: by 2002:a05:6000:288e:b0:3e9:ee54:af71 with SMTP id ffacd0b85a97d-3ee7bad15fbmr6922002f8f.12.1758403998720;
        Sat, 20 Sep 2025 14:33:18 -0700 (PDT)
Received: from ?IPV6:2003:ea:8f30:a300:65ae:147:ed4c:62d8? (p200300ea8f30a30065ae0147ed4c62d8.dip0.t-ipconnect.de. [2003:ea:8f30:a300:65ae:147:ed4c:62d8])
        by smtp.googlemail.com with ESMTPSA id ffacd0b85a97d-3ee0fbd5d65sm12963179f8f.46.2025.09.20.14.33.16
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sat, 20 Sep 2025 14:33:17 -0700 (PDT)
Message-ID: <6d4e80e7-c684-4d95-abbd-ea62b79a9a8a@gmail.com>
Date: Sat, 20 Sep 2025 23:33:16 +0200
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: [PATCH net-next 1/2] net: phy: dp83640: improve phydev and driver
 removal handling
From: Heiner Kallweit <hkallweit1@gmail.com>
To: Andrew Lunn <andrew@lunn.ch>, Andrew Lunn <andrew+netdev@lunn.ch>,
 Russell King - ARM Linux <linux@armlinux.org.uk>,
 Eric Dumazet <edumazet@google.com>, Paolo Abeni <pabeni@redhat.com>,
 Jakub Kicinski <kuba@kernel.org>, David Miller <davem@davemloft.net>,
 Richard Cochran <richardcochran@gmail.com>
Cc: "netdev@vger.kernel.org" <netdev@vger.kernel.org>
References: <b86c2ecc-41f6-4f7f-85db-b7fa684d1fb7@gmail.com>
Content-Language: en-US
Autocrypt: addr=hkallweit1@gmail.com; keydata=
 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
In-Reply-To: <b86c2ecc-41f6-4f7f-85db-b7fa684d1fb7@gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

Once the last user of a clock has been removed, the clock should be
removed. So far orphaned clocks are cleaned up in dp83640_free_clocks()
only. Add the logic to remove orphaned clocks in dp83640_remove().
This allows to simplify the code, and use standard macro
module_phy_driver(). dp83640 was the last external user of
phy_driver_register(), so we can stop exporting this function afterwards.

Signed-off-by: Heiner Kallweit <hkallweit1@gmail.com>
---
 drivers/net/phy/dp83640.c | 58 ++++++++++++++-------------------------
 1 file changed, 20 insertions(+), 38 deletions(-)

diff --git a/drivers/net/phy/dp83640.c b/drivers/net/phy/dp83640.c
index daab55572..74396453f 100644
--- a/drivers/net/phy/dp83640.c
+++ b/drivers/net/phy/dp83640.c
@@ -953,30 +953,6 @@ static void decode_status_frame(struct dp83640_private *dp83640,
 	}
 }
 
-static void dp83640_free_clocks(void)
-{
-	struct dp83640_clock *clock;
-	struct list_head *this, *next;
-
-	mutex_lock(&phyter_clocks_lock);
-
-	list_for_each_safe(this, next, &phyter_clocks) {
-		clock = list_entry(this, struct dp83640_clock, list);
-		if (!list_empty(&clock->phylist)) {
-			pr_warn("phy list non-empty while unloading\n");
-			BUG();
-		}
-		list_del(&clock->list);
-		mutex_destroy(&clock->extreg_lock);
-		mutex_destroy(&clock->clock_lock);
-		put_device(&clock->bus->dev);
-		kfree(clock->caps.pin_config);
-		kfree(clock);
-	}
-
-	mutex_unlock(&phyter_clocks_lock);
-}
-
 static void dp83640_clock_init(struct dp83640_clock *clock, struct mii_bus *bus)
 {
 	INIT_LIST_HEAD(&clock->list);
@@ -1479,6 +1455,7 @@ static void dp83640_remove(struct phy_device *phydev)
 	struct dp83640_clock *clock;
 	struct list_head *this, *next;
 	struct dp83640_private *tmp, *dp83640 = phydev->priv;
+	bool remove_clock = false;
 
 	if (phydev->mdio.addr == BROADCAST_ADDR)
 		return;
@@ -1506,11 +1483,27 @@ static void dp83640_remove(struct phy_device *phydev)
 		}
 	}
 
+	if (!clock->chosen && list_empty(&clock->phylist))
+		remove_clock = true;
+
 	dp83640_clock_put(clock);
 	kfree(dp83640);
+
+	if (remove_clock) {
+		mutex_lock(&phyter_clocks_lock);
+		list_del(&clock->list);
+		mutex_unlock(&phyter_clocks_lock);
+
+		mutex_destroy(&clock->extreg_lock);
+		mutex_destroy(&clock->clock_lock);
+		put_device(&clock->bus->dev);
+		kfree(clock->caps.pin_config);
+		kfree(clock);
+	}
 }
 
-static struct phy_driver dp83640_driver = {
+static struct phy_driver dp83640_driver[] = {
+{
 	.phy_id		= DP83640_PHY_ID,
 	.phy_id_mask	= 0xfffffff0,
 	.name		= "NatSemi DP83640",
@@ -1521,26 +1514,15 @@ static struct phy_driver dp83640_driver = {
 	.config_init	= dp83640_config_init,
 	.config_intr    = dp83640_config_intr,
 	.handle_interrupt = dp83640_handle_interrupt,
+},
 };
 
-static int __init dp83640_init(void)
-{
-	return phy_driver_register(&dp83640_driver, THIS_MODULE);
-}
-
-static void __exit dp83640_exit(void)
-{
-	dp83640_free_clocks();
-	phy_driver_unregister(&dp83640_driver);
-}
+module_phy_driver(dp83640_driver);
 
 MODULE_DESCRIPTION("National Semiconductor DP83640 PHY driver");
 MODULE_AUTHOR("Richard Cochran <richardcochran@gmail.com>");
 MODULE_LICENSE("GPL");
 
-module_init(dp83640_init);
-module_exit(dp83640_exit);
-
 static const struct mdio_device_id __maybe_unused dp83640_tbl[] = {
 	{ DP83640_PHY_ID, 0xfffffff0 },
 	{ }
-- 
2.51.0



