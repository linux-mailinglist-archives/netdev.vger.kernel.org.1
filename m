Return-Path: <netdev+bounces-140816-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 96E2A9B858F
	for <lists+netdev@lfdr.de>; Thu, 31 Oct 2024 22:44:02 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 1C9131F254B9
	for <lists+netdev@lfdr.de>; Thu, 31 Oct 2024 21:44:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 75EA11E5709;
	Thu, 31 Oct 2024 21:43:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="E2sud19c"
X-Original-To: netdev@vger.kernel.org
Received: from mail-ej1-f49.google.com (mail-ej1-f49.google.com [209.85.218.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7367C1CC15C
	for <netdev@vger.kernel.org>; Thu, 31 Oct 2024 21:42:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730410981; cv=none; b=qt6rc7l4wuWn2DVQbGZ7I8dH1DqMJuWHW3hKa8fDOVMrJDp1wG/PE1hDdan9d3YNQEPKNNCzC5UuhMuqNad0Ui2H+7tI7bFw7vuBJQ0EOAc40WvAEO0+P1w5o8hQe3KmBtqi4ngcun4pGjRbYnghKujtrE89fh1qjDScBpC3VBc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730410981; c=relaxed/simple;
	bh=Ot3xwKTdy3PO6VVE2ho8ZwjinNE2jaPbfo2opEqku5A=;
	h=Message-ID:Date:MIME-Version:Subject:From:To:Cc:References:
	 In-Reply-To:Content-Type; b=Q9twWb62Ls5e731Qq6h0R4clybsCBEVjAW4+YdPVpjn1ZcEWD19nCU6W6pvtsMGkGeId2kCkygAWXqcEXE67ifRXCLWyOW4vVM961JFydCtQnBvKMFi5qgmG/SKqgG++0LJeDiE6ETZ4s7QUuGncgQb3SV/BXIB/XoLK1F5TWkQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=E2sud19c; arc=none smtp.client-ip=209.85.218.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ej1-f49.google.com with SMTP id a640c23a62f3a-a9a2209bd7fso215114266b.2
        for <netdev@vger.kernel.org>; Thu, 31 Oct 2024 14:42:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1730410974; x=1731015774; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:autocrypt:content-language
         :references:cc:to:from:subject:user-agent:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=O5TCqt4iaG1nfsbX/JGCG3xm9DNPzqb8v/mgG2JFNHI=;
        b=E2sud19cosfWmN1IgK75GLUa9Wrn3184xri/OWtyed8FGY7bnBeYgIwAbDuPtZcwtm
         ezncmJiJkh6J1x6Ch9uAnnJrDSbawJepPOpWtyfEEzH/jDhIufn2Wl/l76hs6tBAwuc/
         l015tlee+afSKynMbhcPio5jhQiynHUpWkpAmslcoWdyJVfPG2DqC4UCYqnBsMSlgMoZ
         7k8r/MtIMX6jKkXFLlu6z5lYIwj0NDMZGQGZNpgwIM+kfm5ZCRsRu/B/V8UWyN7eOjEt
         crl0t5wppg7QiTmSEgA4sj337n4kmNYX8jFm5+eR1AVeqolrmeZdLgzVM85M4AIc2H4m
         fA3A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1730410974; x=1731015774;
        h=content-transfer-encoding:in-reply-to:autocrypt:content-language
         :references:cc:to:from:subject:user-agent:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=O5TCqt4iaG1nfsbX/JGCG3xm9DNPzqb8v/mgG2JFNHI=;
        b=DiJ7MjcCxVn+KUoh9uAtp33O/XFg9IqQH3FWHF6YcPm7PDuCRb8/cwuz0jRmiN1ESX
         5rBJ0eK1k7r62ldQdYdK2faWUdIjYSrs2blX4ew6HNogrSmxWJaQn26VK/TR4Q2F1eBI
         ipPr/TXH9TgOvScCfnRzaymQol4DlSVooocD04Y/vEr9h197gwRvM55+MBTubJjMZzVt
         hCmB4onlc7t17+KbbYpROIfZzqfBcSUrkVaW7KwmOVdVAQHOMBdTVVFRN50y+OnzGxuk
         1BIOxNnR2pDSTIaZD88K70q8ixitdIvjldc5tgr97k5eboQ9o55YXQ5Xtf2E3b3ExVUd
         h2ng==
X-Gm-Message-State: AOJu0Yw4+0PHU3DCrhKRO28rkkfNk+Bfo51vKGdK/l3aooUfzuHYDcSg
	GXanJLxqYGic2OEblrugVMdQylfGGwlBorb757h1h3OsEUokiwkl
X-Google-Smtp-Source: AGHT+IFCv3Vss8ZRSYxtUocPcwROFxLPSwNa88ZBOw7jY4jFwh0OKUWPAXmAD3EAyNHcn8PtinmWtg==
X-Received: by 2002:a17:907:94c4:b0:a99:fc9a:5363 with SMTP id a640c23a62f3a-a9de5c919e4mr1995614066b.9.1730410973599;
        Thu, 31 Oct 2024 14:42:53 -0700 (PDT)
Received: from ?IPV6:2a02:3100:af9e:3f00:f876:f664:2bd5:aff4? (dynamic-2a02-3100-af9e-3f00-f876-f664-2bd5-aff4.310.pool.telefonica.de. [2a02:3100:af9e:3f00:f876:f664:2bd5:aff4])
        by smtp.googlemail.com with ESMTPSA id a640c23a62f3a-a9e5664352bsm107576066b.158.2024.10.31.14.42.51
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 31 Oct 2024 14:42:53 -0700 (PDT)
Message-ID: <044c925e-8669-4b98-87df-95b4056f4f5f@gmail.com>
Date: Thu, 31 Oct 2024 22:42:52 +0100
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: [PATCH net-next 1/3] r8169: align RTL8125 EEE config with vendor
 driver
From: Heiner Kallweit <hkallweit1@gmail.com>
To: Realtek linux nic maintainers <nic_swsd@realtek.com>,
 Andrew Lunn <andrew+netdev@lunn.ch>, Paolo Abeni <pabeni@redhat.com>,
 Jakub Kicinski <kuba@kernel.org>, David Miller <davem@davemloft.net>,
 Eric Dumazet <edumazet@google.com>
Cc: "netdev@vger.kernel.org" <netdev@vger.kernel.org>
References: <7a849c7c-50ff-4a9b-9a1c-a963b0561c79@gmail.com>
Content-Language: en-US
Autocrypt: addr=hkallweit1@gmail.com; keydata=
 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
In-Reply-To: <7a849c7c-50ff-4a9b-9a1c-a963b0561c79@gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

Align the EEE config for RTL8125A/RTL8125B with vendor driver r8125.
This should help to avoid compatibility issues.

Signed-off-by: Heiner Kallweit <hkallweit1@gmail.com>
---
 .../net/ethernet/realtek/r8169_phy_config.c    | 18 ++++++++++++------
 1 file changed, 12 insertions(+), 6 deletions(-)

diff --git a/drivers/net/ethernet/realtek/r8169_phy_config.c b/drivers/net/ethernet/realtek/r8169_phy_config.c
index 8739f4b42..a0ecfa9c6 100644
--- a/drivers/net/ethernet/realtek/r8169_phy_config.c
+++ b/drivers/net/ethernet/realtek/r8169_phy_config.c
@@ -89,19 +89,25 @@ static void rtl8168h_config_eee_phy(struct phy_device *phydev)
 	phy_modify_paged(phydev, 0xa42, 0x14, 0x0000, 0x0080);
 }
 
-static void rtl8125a_config_eee_phy(struct phy_device *phydev)
+static void rtl8125_common_config_eee_phy(struct phy_device *phydev)
 {
-	rtl8168h_config_eee_phy(phydev);
+	phy_modify_paged(phydev, 0xa6d, 0x14, 0x0010, 0x0000);
+	phy_modify_paged(phydev, 0xa42, 0x14, 0x0080, 0x0000);
+	phy_modify_paged(phydev, 0xa4a, 0x11, 0x0200, 0x0000);
+}
 
+static void rtl8125a_config_eee_phy(struct phy_device *phydev)
+{
+	rtl8168g_config_eee_phy(phydev);
+	/* disable EEE at 2.5Gbps */
 	phy_modify_paged(phydev, 0xa6d, 0x12, 0x0001, 0x0000);
-	phy_modify_paged(phydev, 0xa6d, 0x14, 0x0010, 0x0000);
+	rtl8125_common_config_eee_phy(phydev);
 }
 
 static void rtl8125b_config_eee_phy(struct phy_device *phydev)
 {
-	phy_modify_paged(phydev, 0xa6d, 0x14, 0x0010, 0x0000);
-	phy_modify_paged(phydev, 0xa42, 0x14, 0x0080, 0x0000);
-	phy_modify_paged(phydev, 0xa4a, 0x11, 0x0200, 0x0000);
+	rtl8168g_config_eee_phy(phydev);
+	rtl8125_common_config_eee_phy(phydev);
 }
 
 static void rtl8169s_hw_phy_config(struct rtl8169_private *tp,
-- 
2.47.0



