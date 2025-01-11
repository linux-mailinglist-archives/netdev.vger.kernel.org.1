Return-Path: <netdev+bounces-157465-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 9CA21A0A5FF
	for <lists+netdev@lfdr.de>; Sat, 11 Jan 2025 21:49:40 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 9170F3A87AC
	for <lists+netdev@lfdr.de>; Sat, 11 Jan 2025 20:49:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 393BB1B86D5;
	Sat, 11 Jan 2025 20:49:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="kyxAQLWh"
X-Original-To: netdev@vger.kernel.org
Received: from mail-wm1-f42.google.com (mail-wm1-f42.google.com [209.85.128.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 77D911B6CEF
	for <netdev@vger.kernel.org>; Sat, 11 Jan 2025 20:49:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736628577; cv=none; b=kxMNYCui6VJfVBeFok+ZpEJjY/XsWCFqnFpWR7BrzxK6IrHRxUBOeI7IKNS+ONKjV+ThFdEHTd3xTVk3UeSAtCvhxDs02OUvt/AOoWRdDFESUmjRRiSZhEghkglYC2UFYSyzPr/y4JZFrFvypf+UfJOX1gD1/Dht0FlgpsbiXu8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736628577; c=relaxed/simple;
	bh=qP5/M6vseHnnBiZ/lTYidFMd3YWQ51fEwZPovPeFPNU=;
	h=Message-ID:Date:MIME-Version:Subject:From:To:Cc:References:
	 In-Reply-To:Content-Type; b=t7C8SYFAS84pk1F6yvumL4sGQTQM3i8GcIisSjtUiCZyZ+Q42/KK6AWvKt3Zi9Nlbx68vKjQ0IZIf6CXIqjlOSREmexQbdGxDhG11s4zoFK8nIZZjsbgYwQEP6Xo988HFa/+AJq9yAhUdQR5wSV/P3AuTcIMBfdCX7lNs5Xq4/E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=kyxAQLWh; arc=none smtp.client-ip=209.85.128.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f42.google.com with SMTP id 5b1f17b1804b1-436637e8c8dso33454855e9.1
        for <netdev@vger.kernel.org>; Sat, 11 Jan 2025 12:49:35 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1736628574; x=1737233374; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:autocrypt:content-language
         :references:cc:to:from:subject:user-agent:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=2Z80OxOIrtkhN3EgoWKZwUPYC+py2jGJPJeNHPUOoGU=;
        b=kyxAQLWhSG5EZ7p0InLPVzfSAR8C8dpEKWsevB/ttMCDzLZatKsEYz4+lSMZpJuqca
         D4U8BMOSd1U15akPAGpMV+IzQSfLUpro19O62dy5xloSBk65jdlBklJF5haXEO/ztF9A
         cL45zT3F4LQnL9h1KnNFOJ578a5GqOj9KPMA+oQ5sAiRhxP7EOKapGSpRV2D2P19WBAr
         pfmWaTeOk6kue78ZJ3rDVQBYpMhG2PVJ9lR0/y7U5O3afgX2QMHngMvlgM4zeNv9s5A8
         rpyEul1VF7qt4gFL2wlqEZSrIfiD84jCS0w55tLKggEYzxSpyUUEjSFeJlrDXe32BN/a
         EtVA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1736628574; x=1737233374;
        h=content-transfer-encoding:in-reply-to:autocrypt:content-language
         :references:cc:to:from:subject:user-agent:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=2Z80OxOIrtkhN3EgoWKZwUPYC+py2jGJPJeNHPUOoGU=;
        b=m4ZKaqv/JTrErhCKApP3N7JV+Y3N/g4jLnD2+VKgLJ4iM1q6fPMAxXT37HdRKAqVqx
         An19zHs4gjKOsMpQjQtJExULcERHdgDLKRsyIKI3yGWdihqGglCn54MJgn2C+s1QzD6s
         374kWritVqhleSnT9wsp35z80tjmEn/4OatTBjDfyLgDqKzW2RrL1zFjCpZzqv6YywsK
         IV3tYCnyxlCAKmLWFEOlrXtP6mW6nd+VTUYTuzDQku7iXNXffQy5QaoF/g9E9AhMZQPS
         bfq7DfYQdt5fcba+hV9ylns9WEJoY3SqNvoVPCUfZ5EHoaJ2cvrHmGmcYk5FXNP9ZWei
         fbBw==
X-Gm-Message-State: AOJu0Yz+kjR33RLXizjYw6uHOYt90w7kd2r4X3podELr1y57GOoJdd3f
	jc1sGfVADqRkhWlQ2NS92G7W6w9fPLVB/VVnEQ1uBUKmENwwHiXt
X-Gm-Gg: ASbGnctrjToGY/xPS0wW+k/HcfpS20bY+GrsbmLbybFV7sL1Ti2stnkSZ2uQuYJQ77V
	3GnmcO6l6V+fw8ouPbwUnaY8g8ymzEqtJ+bT2gqWyxM3XtL1SYOIvWnTNt6gwodh3cZIBKMclbN
	m4RskM29LJWZvfNrRggZ1JAjeVDaLRBvEf/sXfXfRGxFlMVTlhXVzJKKjPhozj5Siq+RJyCPz7u
	l8Qwk2wqwTZLt3iKEJHNyZZbUcsoLMwvO4zA5Wn2RPKXGFVPC+tzr9ggML0nzoBWp+HcVFE0Iw2
	JAGmKZD7sbOIPFoNf08x10oW0FslW0XrN/ExTele8VQxIsldlkALcyckxxMksOpqE5nJj8kz6FN
	ph/tJDhTzUvtTvLfKZf9T3hqWdF1NV4DFTbrhJaHpI9jRfMC6
X-Google-Smtp-Source: AGHT+IF4SzHq3sH8G20TxAEFMqdXF54qE0OEkYtbGWw0cG9JiNJrIb2kNNrC9DmRcuelQpjpISmiKA==
X-Received: by 2002:a05:600c:310c:b0:436:840b:2593 with SMTP id 5b1f17b1804b1-436e26ad50emr150523875e9.15.1736628573707;
        Sat, 11 Jan 2025 12:49:33 -0800 (PST)
Received: from ?IPV6:2a02:3100:a90d:e100:d8f1:2ffc:4f48:89fd? (dynamic-2a02-3100-a90d-e100-d8f1-2ffc-4f48-89fd.310.pool.telefonica.de. [2a02:3100:a90d:e100:d8f1:2ffc:4f48:89fd])
        by smtp.googlemail.com with ESMTPSA id 5b1f17b1804b1-436e9d8faa5sm94020955e9.1.2025.01.11.12.49.31
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sat, 11 Jan 2025 12:49:32 -0800 (PST)
Message-ID: <e821b302-5fe6-49ab-aabd-05da500581c0@gmail.com>
Date: Sat, 11 Jan 2025 21:49:31 +0100
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: [PATCH net-next v2 1/3] net: phy: realtek: add support for reading
 MDIO_MMD_VEND2 regs on RTL8125/RTL8126
From: Heiner Kallweit <hkallweit1@gmail.com>
To: Paolo Abeni <pabeni@redhat.com>, Jakub Kicinski <kuba@kernel.org>,
 David Miller <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>,
 Simon Horman <horms@kernel.org>,
 Russell King - ARM Linux <linux@armlinux.org.uk>,
 Andrew Lunn <andrew@lunn.ch>
Cc: "netdev@vger.kernel.org" <netdev@vger.kernel.org>
References: <7319d8f9-2d6f-4522-92e8-a8a4990042fb@gmail.com>
Content-Language: en-US
Autocrypt: addr=hkallweit1@gmail.com; keydata=
 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
In-Reply-To: <7319d8f9-2d6f-4522-92e8-a8a4990042fb@gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

RTL8125/RTL8126 don't support MMD access to the internal PHY, but
provide a mechanism to access at least all MDIO_MMD_VEND2 registers.
By exposing this mechanism standard MMD access functions can be used
to access the MDIO_MMD_VEND2 registers.

Signed-off-by: Heiner Kallweit <hkallweit1@gmail.com>
---
 drivers/net/phy/realtek.c | 12 ++++++++++--
 1 file changed, 10 insertions(+), 2 deletions(-)

diff --git a/drivers/net/phy/realtek.c b/drivers/net/phy/realtek.c
index f65d7f1f3..af9874143 100644
--- a/drivers/net/phy/realtek.c
+++ b/drivers/net/phy/realtek.c
@@ -736,7 +736,11 @@ static int rtlgen_read_mmd(struct phy_device *phydev, int devnum, u16 regnum)
 {
 	int ret;
 
-	if (devnum == MDIO_MMD_PCS && regnum == MDIO_PCS_EEE_ABLE) {
+	if (devnum == MDIO_MMD_VEND2) {
+		rtl821x_write_page(phydev, regnum >> 4);
+		ret = __phy_read(phydev, 0x10 + ((regnum & 0xf) >> 1));
+		rtl821x_write_page(phydev, 0);
+	} else if (devnum == MDIO_MMD_PCS && regnum == MDIO_PCS_EEE_ABLE) {
 		rtl821x_write_page(phydev, 0xa5c);
 		ret = __phy_read(phydev, 0x12);
 		rtl821x_write_page(phydev, 0);
@@ -760,7 +764,11 @@ static int rtlgen_write_mmd(struct phy_device *phydev, int devnum, u16 regnum,
 {
 	int ret;
 
-	if (devnum == MDIO_MMD_AN && regnum == MDIO_AN_EEE_ADV) {
+	if (devnum == MDIO_MMD_VEND2) {
+		rtl821x_write_page(phydev, regnum >> 4);
+		ret = __phy_write(phydev, 0x10 + ((regnum & 0xf) >> 1), val);
+		rtl821x_write_page(phydev, 0);
+	} else if (devnum == MDIO_MMD_AN && regnum == MDIO_AN_EEE_ADV) {
 		rtl821x_write_page(phydev, 0xa5d);
 		ret = __phy_write(phydev, 0x10, val);
 		rtl821x_write_page(phydev, 0);
-- 
2.47.1



