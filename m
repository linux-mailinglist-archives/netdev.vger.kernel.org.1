Return-Path: <netdev+bounces-207286-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 143C2B069AA
	for <lists+netdev@lfdr.de>; Wed, 16 Jul 2025 01:01:35 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 4C86F1AA4086
	for <lists+netdev@lfdr.de>; Tue, 15 Jul 2025 23:01:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8CB5C2D29C2;
	Tue, 15 Jul 2025 23:01:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="v9GXd4uu"
X-Original-To: netdev@vger.kernel.org
Received: from mail-oi1-f172.google.com (mail-oi1-f172.google.com [209.85.167.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D68B92C3768
	for <netdev@vger.kernel.org>; Tue, 15 Jul 2025 23:01:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752620485; cv=none; b=pdSo/xnHv9WvY+/SY38PY1HPNCPW3gWzD0/4jynbYrkMkuiGUwm46HnNUBarolRuKf0A0AhfkIS4J/9F62CUU7T9pkcr/wCRGp8LrbZUmSYxQyobPllA4df6G7GtZoisOZR1t074U1FZLkhuKNPPzYnxIAruoB+5BcW1KBBg368=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752620485; c=relaxed/simple;
	bh=b/LA/fS6G1ALR75iCSwylRoGN9ZsUCbGZpu9YxrMRv0=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition; b=PUPgSRiZLYRXkandfHON6CFN4QZN/STJ6wVdZBHaMRw2SYee3wgeIDZn+3pGGW7wekOpiTfQtZoh2ZeLfLa8No54Nb8UQTTR1Xf2xA8hS4rmTkWUeWQWaF9yNwSww2EYfts2Ug+ZlTYx+yTrSRfZymH72G9GcEFsSvzFpAk/2K0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=v9GXd4uu; arc=none smtp.client-ip=209.85.167.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-oi1-f172.google.com with SMTP id 5614622812f47-41b4bf6ead9so971932b6e.3
        for <netdev@vger.kernel.org>; Tue, 15 Jul 2025 16:01:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1752620483; x=1753225283; darn=vger.kernel.org;
        h=content-disposition:mime-version:message-id:subject:cc:to:from:date
         :from:to:cc:subject:date:message-id:reply-to;
        bh=k0CRRO8Zw5SYMNCeis2H0ecNCwZ1xJBBe/YWgqbP+9k=;
        b=v9GXd4uuanam7MiY9coe2hgWN/wJfqgjJcecYUy7JPw4f2lPJ3cupMj0zdQz76nUZS
         8KND3N+WJDPM5aZZsQDdAQ1gk2QVoSHYiJlG9qFxZpifZ29ugoWfz4qoWZxTmj213yTA
         N7kZHT0KUrBSRaObYepCZunlD16Ypncjjf1E+O4QhWV1v3LeXIc1LAHpuf0BTGCdXh0L
         m5O9OkoaXk+Kz504c+lmzERyeRizZp9doePktFeDx74nvUhy6JvT/veAt1Xh1+lCSriq
         u7EJJhGDkwwdAm912DlQs1PqMUZttsgPOYNZKQBwI0uL8pLaNm/eyQnt93I4lMF6lQHe
         Sglg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1752620483; x=1753225283;
        h=content-disposition:mime-version:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=k0CRRO8Zw5SYMNCeis2H0ecNCwZ1xJBBe/YWgqbP+9k=;
        b=heDlMg1wQOC4MF7SkrnJfOhn+ig0FmLqhTE1u2+udRimEkmNROdCo9wqNn/rYhwU/p
         v0nuCcHMk1ahhL7r3qiMIB66mU+17tiHVKPOpaOjA6bNY4m0nGUQnYzYHjFR2LuI5xk4
         T95nyGEFQlK8tW7SKybkC8pRWN6sp/CwHFlft1PJBLWi7bsMyum8zQUTP73OZM+QHj2k
         gjjQ+Vhi5c19bBusKU34+QNPYGpP5JGxkXDLc1rl4TlW3cktQrjYhayaPzbDSpAJecJ0
         U1armUDi0HddGCl2nRdqBsfDIFd7geidu5deY/E503spJ/vVpPgkgPBOkClGKniU4ONI
         TpWw==
X-Forwarded-Encrypted: i=1; AJvYcCWyjuMYq4pr+MQVYX8l8DQD5+8QjtLPY1nIorSZr7uz0uvc59IJy+0W37X36g6+fw9QuXZva+4=@vger.kernel.org
X-Gm-Message-State: AOJu0YzGZ+IgxjrpK8pTX6UVvuOmqXrCI9ojHuNmNnZ4xBl6qjLVtkNz
	vwZM/lCp466XzEXaOL4lyv8tn7pkXhOI1rIJNx2/UxvQy3ThVi/406u1wPW/L70Y21Q=
X-Gm-Gg: ASbGncus0EMCdEiMpTxw+PMjvTjS/aVDX7p2JKk1p6oZz5WpMcCrqgPA92/0IXihZfW
	02xebfEWX2m/13Fmiw3j8piofnSCmRVGRIQFquS9IlouEAU+tYDpvk8SXtKp+B96uHP+PXuHvls
	WXaazX1jQChvhqsK8qYGmLqwjosnlFFaN+cfaj7K1Cq6OxObmhImao47dqMTIeahU5yGCBrwoEl
	/6UZDPxkWm0nFlGBI5JQ+tNFcpi6E4Tqu0m5HnJrihgGEyuiyMSC6+2S28YYQgerfg+XDHIFg2q
	r0lI7an8X+++Yk+pkfBmzdHmjL890o53W+JPDDX2kK057gOvV4AN3n9+FeEpVowMl4Y0wyB991E
	dGnfA7xsLcTOXbCBMP+mpUxtfDQ4i
X-Google-Smtp-Source: AGHT+IGQtllmBc9kuXNMSNrT8BdEoXm/J1sAHyCL8mClXy5PmdAT8mA8+MNoRfXMLo08tASsstG21g==
X-Received: by 2002:a05:6808:199f:b0:41b:75ca:b104 with SMTP id 5614622812f47-41d05d37a1emr470408b6e.39.1752620482690;
        Tue, 15 Jul 2025 16:01:22 -0700 (PDT)
Received: from localhost ([2603:8080:b800:f700:9b4e:9dd8:875d:d59])
        by smtp.gmail.com with UTF8SMTPSA id 5614622812f47-41418c0ae9bsm2349086b6e.6.2025.07.15.16.01.20
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 15 Jul 2025 16:01:22 -0700 (PDT)
Date: Tue, 15 Jul 2025 18:01:19 -0500
From: Dan Carpenter <dan.carpenter@linaro.org>
To: Rob Herring <robh@kernel.org>
Cc: Felix Fietkau <nbd@nbd.name>, Sean Wang <sean.wang@mediatek.com>,
	Lorenzo Bianconi <lorenzo@kernel.org>,
	Andrew Lunn <andrew+netdev@lunn.ch>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	Matthias Brugger <matthias.bgg@gmail.com>,
	AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>,
	netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org,
	linux-mediatek@lists.infradead.org, kernel-janitors@vger.kernel.org
Subject: [PATCH net-next] net: ethernet: mtk_wed: Fix NULL vs IS_ERR() bug in
 mtk_wed_get_memory_region()
Message-ID: <87c10dbd-df86-4971-b4f5-40ba02c076fb@sabinyo.mountain>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-Mailer: git-send-email haha only kidding

We recently changed this from using devm_ioremap() to using
devm_ioremap_resource() and unfortunately the former returns NULL while
the latter returns error pointers.  The check for errors needs to be
updated as well.

Fixes: e27dba1951ce ("net: Use of_reserved_mem_region_to_resource{_byname}() for "memory-region"")
Signed-off-by: Dan Carpenter <dan.carpenter@linaro.org>
---
 drivers/net/ethernet/mediatek/mtk_wed_mcu.c | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/drivers/net/ethernet/mediatek/mtk_wed_mcu.c b/drivers/net/ethernet/mediatek/mtk_wed_mcu.c
index 8498b35ec7a6..fa6b21603416 100644
--- a/drivers/net/ethernet/mediatek/mtk_wed_mcu.c
+++ b/drivers/net/ethernet/mediatek/mtk_wed_mcu.c
@@ -247,8 +247,10 @@ mtk_wed_get_memory_region(struct mtk_wed_hw *hw, const char *name,
 	region->phy_addr = res.start;
 	region->size = resource_size(&res);
 	region->addr = devm_ioremap_resource(hw->dev, &res);
+	if (IS_ERR(region->addr))
+		return PTR_ERR(region->addr);
 
-	return !region->addr ? -EINVAL : 0;
+	return 0;
 }
 
 static int
-- 
2.47.2


