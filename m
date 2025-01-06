Return-Path: <netdev+bounces-155555-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 375E6A02F5F
	for <lists+netdev@lfdr.de>; Mon,  6 Jan 2025 19:01:24 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id B181C3A1ABC
	for <lists+netdev@lfdr.de>; Mon,  6 Jan 2025 18:01:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 94B5A1DF748;
	Mon,  6 Jan 2025 18:01:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="WnMEvK8e"
X-Original-To: netdev@vger.kernel.org
Received: from mail-ej1-f54.google.com (mail-ej1-f54.google.com [209.85.218.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AE543149DF4
	for <netdev@vger.kernel.org>; Mon,  6 Jan 2025 18:01:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736186482; cv=none; b=ZRBclzlxv8qdqzKARdU8YIn1giGoDU4AJ+Xy3S4U3y6WG0hfNxQ5391ZRqm7XOosS4e6U1VzlHxKPJ988f3ICtUpclzp7Ho6dgdUtWlQPWqPJtmESY5lK1ZJA3/HO9KHkLSBwgR1TnSWM4kriRAlINKv9slc2tnpLOCebtUD71g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736186482; c=relaxed/simple;
	bh=7QzdicXnjjuTIyXb1zMBJs2HlUeDsmxbl2AcTpILjp8=;
	h=Message-ID:Date:MIME-Version:Subject:From:To:Cc:References:
	 In-Reply-To:Content-Type; b=KQL60WaBmqTqH6kQXkL5GKoENuzdbXCpkAsAx3Jn1la7VhI4oCCHPJBvmAwg6lC2Zm4WswL3qqd0YoErZirwkc5dQ9KLzkzcQF2noeL+M9Knbc6BQai7Ta0ULibtt5buubKXFhFwA308OuR+mDbDVKuDa/STQGNU5L9sIKfly7I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=WnMEvK8e; arc=none smtp.client-ip=209.85.218.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ej1-f54.google.com with SMTP id a640c23a62f3a-aaf60d85238so882645066b.0
        for <netdev@vger.kernel.org>; Mon, 06 Jan 2025 10:01:20 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1736186479; x=1736791279; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:autocrypt:content-language
         :references:cc:to:from:subject:user-agent:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=dNFtSUL4p2xdptt92FS+EcD3qvXkvVtb4RKnVyliZfM=;
        b=WnMEvK8eX/xeKGCVgt1GY/SdxlNrKOq0CfWW+3BSHm2XCi8ExEyH8A97sRhdP1WrgL
         9rkaF+FlSJ66AABRR1aFoN9KrodvJ+eelnKsDJOPqczlU5SHjwAHbjl8X1Okz1G2n7Mt
         mUpgkSo4a7/ITGJpolTDw6aREFE1p9jrCR2sRIOkuVGXzoMjY1DYnBbxBdIOGIpkHTv6
         +nxlwWkxm+XeDOCRYlmCCkExf3SR3mShN8OuUCriJZAYBaWLnR+xvU4k5HzwqwJ6tE1D
         7Af7fBXOZajxOyyFR7NgFWo9rbS7CthJSG2wqeJAURahWfppDzirrS7IcP7nKgRn0caG
         LPyA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1736186479; x=1736791279;
        h=content-transfer-encoding:in-reply-to:autocrypt:content-language
         :references:cc:to:from:subject:user-agent:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=dNFtSUL4p2xdptt92FS+EcD3qvXkvVtb4RKnVyliZfM=;
        b=bjhd6MIJ0EBSm932BhUhJK2ZMoPMiWuWurUC8+qog23Taf6OGf834YAlkaqEaT4pRq
         4bMW/9KdUrXXfRkoBWQ6Xmlyjfl3pZmd9gSSCS5pB5jJqiB8n87otP+adBKBBXHOvNCk
         Cy+P5tnv0geDIlj3tFxi90UAFRv/rs3KmiEKfrq8/Q75nVFUfAQ4tFHbfsYnrv3iJM/c
         wZHpxSvC58hynn7MfL9PSDorkNqdW4lw6s8cEfIFbVqASGC1/f7SvddvyDKAWU4SXU6O
         5qK4q41Kqv0kMurMU6wuzx7NDGMA0QZFaPJgsuHYCePkUEhbM7EDOTs/RCsz5qMK3pje
         HF2g==
X-Gm-Message-State: AOJu0Ywot/KuCXZBoE5Z1WY86encu2X51ik9X5ghRNw4Ke6q6/n1PuZM
	OJRhlBeUk5eNO8Ofnf1OAticms0bm7wRcDHNG2kksntM0+XYI30N
X-Gm-Gg: ASbGncsJfmC1+3LQLv9M0cQlT84WWG2aGO5BUijE1gbUIlrdmXyAnUzBX2sNJ49UhNZ
	XzkLswiO1cB1/0eH2epZsgQ2XFpNgkRbiKgklRk8gkySbbywlqYPbKavc/ITwZdjQJS53HmCIVN
	oIFe8vnNIgDf18S/aJyG8HFqftgH5SuYxT8+HpkomYpb9W4hFou+EpvMMvVWXAILthR5WaKM2Up
	vpu79p0jK4qXpNCQ7FGIoELdKCRAK0D+UsJuOY/oWJyP+/hZ9czE6aDUHAygDuW8o0ERWqIRS75
	hyBGql+OrCtqgir4MLcJ2sFZXslrur8gC50WZ7tOO/DmC+wJ2CwtqvqXjxFuwF0UMjwoBwifohi
	iyrXWRJFeaYh67I4vZ6EN7y6EUskTWPM37rtMc00I
X-Google-Smtp-Source: AGHT+IEdxVtAsvCKsZwDlrNYKWGc/RwCIEKrXFQkdmDRihW204mkuBZfDiQNddh4RvtRhbSVC9GoLA==
X-Received: by 2002:a17:907:3f89:b0:aa6:9624:78fd with SMTP id a640c23a62f3a-aac3444eb22mr5945428366b.48.1736186478849;
        Mon, 06 Jan 2025 10:01:18 -0800 (PST)
Received: from ?IPV6:2a02:3100:ad97:900:c87:b717:6cf:e370? (dynamic-2a02-3100-ad97-0900-0c87-b717-06cf-e370.310.pool.telefonica.de. [2a02:3100:ad97:900:c87:b717:6cf:e370])
        by smtp.googlemail.com with ESMTPSA id a640c23a62f3a-aac0efe48ecsm2305674866b.126.2025.01.06.10.01.16
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 06 Jan 2025 10:01:17 -0800 (PST)
Message-ID: <cf9d1c92-de68-44ea-9dec-ceba17c2aec9@gmail.com>
Date: Mon, 6 Jan 2025 19:01:16 +0100
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: [PATCH net-next 1/2] r8169: prepare for extending hwmon support
From: Heiner Kallweit <hkallweit1@gmail.com>
To: Realtek linux nic maintainers <nic_swsd@realtek.com>,
 Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
 Eric Dumazet <edumazet@google.com>, David Miller <davem@davemloft.net>,
 Andrew Lunn <andrew+netdev@lunn.ch>, Simon Horman <horms@kernel.org>
Cc: "netdev@vger.kernel.org" <netdev@vger.kernel.org>
References: <97bc1a93-d5d5-4444-86f2-a0b9cc89b0c8@gmail.com>
Content-Language: en-US
Autocrypt: addr=hkallweit1@gmail.com; keydata=
 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
In-Reply-To: <97bc1a93-d5d5-4444-86f2-a0b9cc89b0c8@gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

This factors out the temperature value calculation and
prepares for adding further temperature attributes.

Signed-off-by: Heiner Kallweit <hkallweit1@gmail.com>
---
 drivers/net/ethernet/realtek/r8169_main.c | 23 +++++++++++++++++------
 1 file changed, 17 insertions(+), 6 deletions(-)

diff --git a/drivers/net/ethernet/realtek/r8169_main.c b/drivers/net/ethernet/realtek/r8169_main.c
index 5724f650f..38f915956 100644
--- a/drivers/net/ethernet/realtek/r8169_main.c
+++ b/drivers/net/ethernet/realtek/r8169_main.c
@@ -5338,17 +5338,28 @@ static bool rtl_aspm_is_safe(struct rtl8169_private *tp)
 	return false;
 }
 
+static int r8169_hwmon_get_temp(int raw)
+{
+	if (raw >= 512)
+		raw -= 1024;
+
+	return 1000 * raw / 2;
+}
+
 static int r8169_hwmon_read(struct device *dev, enum hwmon_sensor_types type,
 			    u32 attr, int channel, long *val)
 {
 	struct rtl8169_private *tp = dev_get_drvdata(dev);
-	int val_raw;
-
-	val_raw = phy_read_paged(tp->phydev, 0xbd8, 0x12) & 0x3ff;
-	if (val_raw >= 512)
-		val_raw -= 1024;
+	int raw;
 
-	*val = 1000 * val_raw / 2;
+	switch (attr) {
+	case hwmon_temp_input:
+		raw = phy_read_paged(tp->phydev, 0xbd8, 0x12) & 0x3ff;
+		*val = r8169_hwmon_get_temp(raw);
+		break;
+	default:
+		return -EINVAL;
+	}
 
 	return 0;
 }
-- 
2.47.1



