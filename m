Return-Path: <netdev+bounces-196336-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id AE25FAD44DA
	for <lists+netdev@lfdr.de>; Tue, 10 Jun 2025 23:34:59 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 783643A45F1
	for <lists+netdev@lfdr.de>; Tue, 10 Jun 2025 21:34:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A1153284B26;
	Tue, 10 Jun 2025 21:34:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Zkn9RXjv"
X-Original-To: netdev@vger.kernel.org
Received: from mail-wr1-f51.google.com (mail-wr1-f51.google.com [209.85.221.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CC79C28469C
	for <netdev@vger.kernel.org>; Tue, 10 Jun 2025 21:34:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1749591295; cv=none; b=NM9sr/jnaE7FA2KzBdldnlGDspzzBkbAFE0kchb1DNwWFeUPT8z6JsXcU9POhwTLhVugAmKu6QI25RvzZZeXPVw9iqGXdThgqOAIPKx3EfWHq77o41+e/DJmqE7Bu8V5/vMSir/vBhgkStAa51UT+/0exrhYgidmVjIRTKH80HQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1749591295; c=relaxed/simple;
	bh=8Y9stje/7c7Q+H1rFd+XUoSivx388K1eyPMMixPoi0M=;
	h=Message-ID:Date:MIME-Version:To:Cc:From:Subject:Content-Type; b=MnjJBmv+r6Jh3qyo9E3SvdTeI/nuS3DlTAX+P23y7m7a/T5ueypNoMp6Tl1XgqIAslZveu2Wy93Jax9oYwPLUTW3D9A0AyqgiW4zr/B5vLvtuJ8Lu6zIvwprFUnUula0Ggpeq3I66WTfPDx2uasJoMoy3jR1MvP6u5kMEX4gs74=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Zkn9RXjv; arc=none smtp.client-ip=209.85.221.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wr1-f51.google.com with SMTP id ffacd0b85a97d-3a5123c1533so3410633f8f.2
        for <netdev@vger.kernel.org>; Tue, 10 Jun 2025 14:34:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1749591292; x=1750196092; darn=vger.kernel.org;
        h=content-transfer-encoding:autocrypt:subject:from:cc:to
         :content-language:user-agent:mime-version:date:message-id:from:to:cc
         :subject:date:message-id:reply-to;
        bh=TPSbEt4wccagWm8pgo1JX3r4pQnNS9iE9mkRJZPvnFI=;
        b=Zkn9RXjvSqrEvL2nERoI1/Vpm6MXJDoh25zFkPoADAV2lW2nvv3R1si3+bVHk8oFYn
         nURnmbe1Ncd5dGL8MumXPfSy4uGBz50Z61M0PRU1IJi3bwAu4ua20EjM1jCEoFdfhMjk
         twnKB8J+6H3lBPn2JyAelJmrvUNdlLo+N1nGlS9ww2dB/EIKPxgbXulHlqdg8k5mdAjF
         BerzEIEVE9PD0sN14ub3gRfoYtTPY33XrEtR+Q62D4Zvhtks0oTXZ4fpU98aI8HhOazu
         ZZqCFId8m7y0DG6Ty8nQBntWErjJEdcNXOFL+rPXZClzX8o7ZYeZUV0ryZ19/mbpVofi
         NxzQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1749591292; x=1750196092;
        h=content-transfer-encoding:autocrypt:subject:from:cc:to
         :content-language:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=TPSbEt4wccagWm8pgo1JX3r4pQnNS9iE9mkRJZPvnFI=;
        b=Wo+SKoRQZe4F8i3yUaUXGkSS/qTPbyfXX+e519DBkCjHEgjzczoZL2uj9mAGrcCrZA
         DB93kmxtUHiq+uSiuDnathbmNgbSg/CY9VIqhCo2c8VlhQF4CH6m5ROqi8gNCWL9tvcj
         ct9PXahEvsme5p4sUZSgqc6AmktRxasqC991RInw9LVYp7ksFdylAKYQ0eEg2rtFLHKx
         eRG9rt9+mSJPb76QRjpPuEGsw28+Kr1grl/s7a031Vdq2bEGrfFZZRhdivklnuC+fST2
         ONTKrdBWTWoKIN0IWLb3D7NjVtCgt1SDegvG/vNp09qEXzhUCtgXQy34d/F670m41xZi
         iFow==
X-Gm-Message-State: AOJu0YxaJfUi0hGQ23KZKdks3gb3RTyln/iQJaQ6STixSB7dc5bDbDUk
	oxdV/2koLqyqon1wJB65kHx8Kpx+KaX+FkPFXXHKD2Gn2sxLs9p7qAZW
X-Gm-Gg: ASbGnctZcHLMIRnAs6J/kKaO0sfBcldYjykpALioZ2Aj4hZ6HLAjL8+Hlf1ATFv5731
	w+MV2IPuZRU1mDIJxP+6+RgYT/IeWXr+JrSK6iyXGcXRF2drX/P7IZKLNPWpGk+VDgl+DmZWo+6
	kNl05MM4qICEr084OB1FjVXwQgdcqGJGadvRRkkDDLfuCxCiLya1e/epEprtqzRcdwFZi1MCQ9S
	v0ZtWj1/hg7aBTmqbWFdRDqEn5KI19vG1zZpzoLwsVgn2RT3OuvmhFo2P6liubyPHclnT+jW8Yj
	hYJwhS1JTrWgfkIV1mERehWtwdu9gpLfZRFtyviP6LwIKvqZY4OG7fvHR4cCZxdAQTzXMOmiIjS
	K0MA5RRV7aQNulpC1sz9Ab+r9EF4XyJRiGXEK67ZbPcLyNny2NPJ9C4t8aiDBBiuordC1w7J6Bm
	J9bv3u912h0iOZMXy2fbhDMS4=
X-Google-Smtp-Source: AGHT+IHIcjVGCoqUtdGUn6NWYDCCEGh6r2ZVn2cVWzsBUZ8Wb54TF8dC5RWrPz3VsF1p06HxgOOBAQ==
X-Received: by 2002:a05:6000:2403:b0:3a5:2ec5:35b8 with SMTP id ffacd0b85a97d-3a558aa5ac8mr312134f8f.11.1749591291977;
        Tue, 10 Jun 2025 14:34:51 -0700 (PDT)
Received: from ?IPV6:2003:ea:8f1a:8200:61f9:df1:e3eb:5a45? (p200300ea8f1a820061f90df1e3eb5a45.dip0.t-ipconnect.de. [2003:ea:8f1a:8200:61f9:df1:e3eb:5a45])
        by smtp.googlemail.com with ESMTPSA id 5b1f17b1804b1-453251a1528sm1676795e9.30.2025.06.10.14.34.50
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 10 Jun 2025 14:34:50 -0700 (PDT)
Message-ID: <ead3ab17-22d0-4cd3-901c-3d493ab851e6@gmail.com>
Date: Tue, 10 Jun 2025 23:34:53 +0200
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Content-Language: en-US
To: Andrew Lunn <andrew@lunn.ch>, Andrew Lunn <andrew+netdev@lunn.ch>,
 Russell King - ARM Linux <linux@armlinux.org.uk>,
 Paolo Abeni <pabeni@redhat.com>, Eric Dumazet <edumazet@google.com>,
 Jakub Kicinski <kuba@kernel.org>, David Miller <davem@davemloft.net>
Cc: "netdev@vger.kernel.org" <netdev@vger.kernel.org>
From: Heiner Kallweit <hkallweit1@gmail.com>
Subject: [PATCH net-next] net: phy: move definition of genphy_c45_driver to
 phy_device.c
Autocrypt: addr=hkallweit1@gmail.com; keydata=
 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
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

genphy_c45_read_status() is exported, so we can move definition of
genphy_c45_driver to phy_device.c and make it static. This helps
to clean up phy.h a little.

Signed-off-by: Heiner Kallweit <hkallweit1@gmail.com>
---
 drivers/net/phy/phy-c45.c    | 7 -------
 drivers/net/phy/phy_device.c | 7 +++++++
 include/linux/phy.h          | 3 ---
 3 files changed, 7 insertions(+), 10 deletions(-)

diff --git a/drivers/net/phy/phy-c45.c b/drivers/net/phy/phy-c45.c
index bdd70d424..61670be0f 100644
--- a/drivers/net/phy/phy-c45.c
+++ b/drivers/net/phy/phy-c45.c
@@ -1573,10 +1573,3 @@ int genphy_c45_ethtool_set_eee(struct phy_device *phydev,
 	return ret;
 }
 EXPORT_SYMBOL(genphy_c45_ethtool_set_eee);
-
-struct phy_driver genphy_c45_driver = {
-	.phy_id         = 0xffffffff,
-	.phy_id_mask    = 0xffffffff,
-	.name           = "Generic Clause 45 PHY",
-	.read_status    = genphy_c45_read_status,
-};
diff --git a/drivers/net/phy/phy_device.c b/drivers/net/phy/phy_device.c
index 73f9cb2e2..2902193e1 100644
--- a/drivers/net/phy/phy_device.c
+++ b/drivers/net/phy/phy_device.c
@@ -59,6 +59,13 @@ struct phy_fixup {
 	int (*run)(struct phy_device *phydev);
 };
 
+static struct phy_driver genphy_c45_driver = {
+	.phy_id         = 0xffffffff,
+	.phy_id_mask    = 0xffffffff,
+	.name           = "Generic Clause 45 PHY",
+	.read_status    = genphy_c45_read_status,
+};
+
 __ETHTOOL_DECLARE_LINK_MODE_MASK(phy_basic_features) __ro_after_init;
 EXPORT_SYMBOL_GPL(phy_basic_features);
 
diff --git a/include/linux/phy.h b/include/linux/phy.h
index e194dad16..c021b351a 100644
--- a/include/linux/phy.h
+++ b/include/linux/phy.h
@@ -1941,9 +1941,6 @@ int genphy_c45_ethtool_set_eee(struct phy_device *phydev,
 			       struct ethtool_keee *data);
 int genphy_c45_an_config_eee_aneg(struct phy_device *phydev);
 
-/* Generic C45 PHY driver */
-extern struct phy_driver genphy_c45_driver;
-
 /* The gen10g_* functions are the old Clause 45 stub */
 int gen10g_config_aneg(struct phy_device *phydev);
 
-- 
2.49.0


