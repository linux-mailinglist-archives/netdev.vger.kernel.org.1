Return-Path: <netdev+bounces-155470-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 963CBA02678
	for <lists+netdev@lfdr.de>; Mon,  6 Jan 2025 14:24:30 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 78F93164A66
	for <lists+netdev@lfdr.de>; Mon,  6 Jan 2025 13:24:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 873711D5CEA;
	Mon,  6 Jan 2025 13:23:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="biDFff8U"
X-Original-To: netdev@vger.kernel.org
Received: from mail-ej1-f53.google.com (mail-ej1-f53.google.com [209.85.218.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AF4BD1DE2D7
	for <netdev@vger.kernel.org>; Mon,  6 Jan 2025 13:23:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736169822; cv=none; b=bTTgkEBeqPDFocGXgA7zu/4c304muXfwlB8jDNVCcEZu491/xcrurv37flCsrDcp076ZfkK6PXGZTLmnLdHmE+9jRH9UwlJad4e3QtoX/k6Kb9uiinxU82zXJ5XSc6c6amZ+Zbf95BTEyMBn0cU2p31FuuNBmCHgLekDh4XSUpE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736169822; c=relaxed/simple;
	bh=DgCr6GvFALXmKzOSq+9ZU5xCdHcnktEI1NRuQvwWINY=;
	h=Message-ID:Date:MIME-Version:Subject:From:To:Cc:References:
	 In-Reply-To:Content-Type; b=TkF2zql71nAv580yWGamA/PRbh9h4jA+xzJS79/prZONqA7HfBT4OpIwW6OaUh9Qv3IBm+y7Rs7PLlUpjDc5s+emUEkQNlzZwdUwWeEWnZtwPDAWmkMLW3+GrDfm5pa1hZkgWTojl0FCxcipwbxVNf171pFu3yb0sfIQH8JuF9o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=biDFff8U; arc=none smtp.client-ip=209.85.218.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ej1-f53.google.com with SMTP id a640c23a62f3a-aaecf50578eso303184166b.2
        for <netdev@vger.kernel.org>; Mon, 06 Jan 2025 05:23:40 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1736169819; x=1736774619; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:autocrypt:content-language
         :references:cc:to:from:subject:user-agent:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=xGRoTheNfm1NSY5RVYqo69FPbTVXP/c8aUnCdY0uVI0=;
        b=biDFff8UFUCRKRfNwqrNfDGLborYoOgrBgNutaXmygyGqn/vmkKVDiM/kbCC2EwQBn
         HAjkrCRERmoRXj/+CGaNlahKbpPMF4vcH+9MlBEspdNTIjBxX7r8cDySJtpbj8UO2IFu
         nfiIi7l3lBaQk9NWsym+I+Ak65Hf0PquryIUaULY1HMngxd26Qcio6skMwhB21+18wGq
         OFDn34KmjF3XPrjWXcES9zMpZSG+xarKyMexqBmM/bIp38Xaj5e1KEmRN0NSCyEUd41a
         Mz+CYq47pgrTgvdfrfs34aiuzLemNMw3Xm1pIkctvgPETsKCtzCZWCKXcwHeIhjg1G1B
         IeYA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1736169819; x=1736774619;
        h=content-transfer-encoding:in-reply-to:autocrypt:content-language
         :references:cc:to:from:subject:user-agent:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=xGRoTheNfm1NSY5RVYqo69FPbTVXP/c8aUnCdY0uVI0=;
        b=dvQBNXLGAzwp7hNVfELNWbCti/DhBp5l8py6qWoZ8ccvqY3hyj1+bDIiHr1MjekzxO
         /pLNolEn039w/SHwDoZtQuhnPwNOXY7mAjGgJPJ2eQwZZeeG0BvldaQ+GuwKw3uhVELC
         CyVfu7BwvcZWPkGnRb8dcDvjU5ATaHQyb2knWKIhAyXRm8m8G1bV4G+4blJfOJEwS13Y
         0QZLfgMmTSR0Avb6Q+oHMdKKwNuSikLJxBnSrct/gzw4ed1QVZdgnTTsMrprOb/aqf22
         W8goSueg1BI2QELVrT9sWKrSzfC9kr5HY1OCVlqElKxC50zGw3Ga2hglNLC0dpbaeq0j
         b0TQ==
X-Gm-Message-State: AOJu0YzM4o8kbVkaw6YbzkcAW/el4gGL+sVQGPK0Ek2UHEZV9TfBAw+Z
	7rrAW+cn1KZsn+KI8Wr2zud83sagd9p0K0gxbhRnKgEYWVQx2S9X
X-Gm-Gg: ASbGnctEwhKemrdXKN6LhJ6KwKL+YZs6EaDyYQsrtnMGlzoc4aGP2bClfJLcg+CijLV
	IoSdwaBCVRqvlM30QxNIwDTZBVM0u+HZy1nIX3lqflpPX/V3Boas10rahHVJ6BuLBSy1HfnvEPE
	xJCX1FH+iseAW7O2ExaT8AlbTUTkvV/3NiZFudTJk0SB0XPLnWP1/RVjakQafZpQ3qC1VgzUj7A
	spP88jedbYO1f3wRFN4yDUMI1S7Ob20gsoOKKZ6gCLRhC/ygieiR0NVc5pYySXQZOf/MTTxwXH+
	6T+PXHClMVQ/Jpnq0qHRVGjmjQUMahCgsOHsYiCxUqE2RqsLEtMEzGKvPS60uShStl5/qJMwxfZ
	pmOY89Y9b05J576tRJoMIY0v4Fol22xaw+XebDwZ+
X-Google-Smtp-Source: AGHT+IGOwqjxGzgifX8hCGwn+ExePJj83vszAD/RJhRRqC7UlgCnYxvcYLBz858ENEWyrvaYIYiPTw==
X-Received: by 2002:a17:906:4fce:b0:aa6:519c:ef9a with SMTP id a640c23a62f3a-aac3366afa5mr5588271466b.53.1736169818755;
        Mon, 06 Jan 2025 05:23:38 -0800 (PST)
Received: from ?IPV6:2a02:3100:ad97:900:c87:b717:6cf:e370? (dynamic-2a02-3100-ad97-0900-0c87-b717-06cf-e370.310.pool.telefonica.de. [2a02:3100:ad97:900:c87:b717:6cf:e370])
        by smtp.googlemail.com with ESMTPSA id 4fb4d7f45d1cf-5d95a597faesm248498a12.52.2025.01.06.05.23.36
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 06 Jan 2025 05:23:37 -0800 (PST)
Message-ID: <329108a3-12d6-4ce4-9b28-b59f107120ba@gmail.com>
Date: Mon, 6 Jan 2025 14:23:36 +0100
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: [PATCH net-next v2 2/2] net: dsa: microchip: remove MICREL_NO_EEE
 workaround
From: Heiner Kallweit <hkallweit1@gmail.com>
To: Russell King - ARM Linux <linux@armlinux.org.uk>,
 Andrew Lunn <andrew@lunn.ch>, Paolo Abeni <pabeni@redhat.com>,
 Jakub Kicinski <kuba@kernel.org>, Eric Dumazet <edumazet@google.com>,
 David Miller <davem@davemloft.net>, Simon Horman <horms@kernel.org>,
 Woojung Huh <Woojung.Huh@microchip.com>,
 Microchip Linux Driver Support <UNGLinuxDriver@microchip.com>,
 Tim Harvey <tharvey@gateworks.com>, Oleksij Rempel <o.rempel@pengutronix.de>
Cc: "netdev@vger.kernel.org" <netdev@vger.kernel.org>
References: <79f347c6-ac14-475a-8c93-f1a4efc3e15b@gmail.com>
Content-Language: en-US
Autocrypt: addr=hkallweit1@gmail.com; keydata=
 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
In-Reply-To: <79f347c6-ac14-475a-8c93-f1a4efc3e15b@gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

The integrated PHY's on all these switch types have the same PHY ID.
So we can assume that the issue is related to the PHY type, not the
switch type. After having disabled EEE for this PHY type, we can remove
the workaround code here.

Note: On the fast ethernet models listed here the integrated PHY has
      PHY ID 0x00221550, which is handled by PHY driver
      "Micrel KSZ87XX Switch". This PHY driver doesn't handle flag
      MICREL_NO_EEE, therefore setting the flag for these models
      results in a no-op.

Signed-off-by: Heiner Kallweit <hkallweit1@gmail.com>
---
 drivers/net/dsa/microchip/ksz_common.c | 25 -------------------------
 include/linux/micrel_phy.h             |  1 -
 2 files changed, 26 deletions(-)

diff --git a/drivers/net/dsa/microchip/ksz_common.c b/drivers/net/dsa/microchip/ksz_common.c
index e3512e324..4871bb1fc 100644
--- a/drivers/net/dsa/microchip/ksz_common.c
+++ b/drivers/net/dsa/microchip/ksz_common.c
@@ -3008,31 +3008,6 @@ static u32 ksz_get_phy_flags(struct dsa_switch *ds, int port)
 		if (!port)
 			return MICREL_KSZ8_P1_ERRATA;
 		break;
-	case KSZ8567_CHIP_ID:
-		/* KSZ8567R Errata DS80000752C Module 4 */
-	case KSZ8765_CHIP_ID:
-	case KSZ8794_CHIP_ID:
-	case KSZ8795_CHIP_ID:
-		/* KSZ879x/KSZ877x/KSZ876x Errata DS80000687C Module 2 */
-	case KSZ9477_CHIP_ID:
-		/* KSZ9477S Errata DS80000754A Module 4 */
-	case KSZ9567_CHIP_ID:
-		/* KSZ9567S Errata DS80000756A Module 4 */
-	case KSZ9896_CHIP_ID:
-		/* KSZ9896C Errata DS80000757A Module 3 */
-	case KSZ9897_CHIP_ID:
-	case LAN9646_CHIP_ID:
-		/* KSZ9897R Errata DS80000758C Module 4 */
-		/* Energy Efficient Ethernet (EEE) feature select must be manually disabled
-		 *   The EEE feature is enabled by default, but it is not fully
-		 *   operational. It must be manually disabled through register
-		 *   controls. If not disabled, the PHY ports can auto-negotiate
-		 *   to enable EEE, and this feature can cause link drops when
-		 *   linked to another device supporting EEE.
-		 *
-		 * The same item appears in the errata for all switches above.
-		 */
-		return MICREL_NO_EEE;
 	}
 
 	return 0;
diff --git a/include/linux/micrel_phy.h b/include/linux/micrel_phy.h
index 591bf5b5e..9af01bdd8 100644
--- a/include/linux/micrel_phy.h
+++ b/include/linux/micrel_phy.h
@@ -44,7 +44,6 @@
 #define MICREL_PHY_50MHZ_CLK	BIT(0)
 #define MICREL_PHY_FXEN		BIT(1)
 #define MICREL_KSZ8_P1_ERRATA	BIT(2)
-#define MICREL_NO_EEE		BIT(3)
 
 #define MICREL_KSZ9021_EXTREG_CTRL	0xB
 #define MICREL_KSZ9021_EXTREG_DATA_WRITE	0xC
-- 
2.47.1



