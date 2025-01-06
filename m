Return-Path: <netdev+bounces-155466-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id DCD13A02662
	for <lists+netdev@lfdr.de>; Mon,  6 Jan 2025 14:22:52 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 6495F3A056F
	for <lists+netdev@lfdr.de>; Mon,  6 Jan 2025 13:22:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B5796159565;
	Mon,  6 Jan 2025 13:22:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="WcwcQwBx"
X-Original-To: netdev@vger.kernel.org
Received: from mail-ej1-f53.google.com (mail-ej1-f53.google.com [209.85.218.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EF94835973
	for <netdev@vger.kernel.org>; Mon,  6 Jan 2025 13:22:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736169767; cv=none; b=Gq5Aj94BNsHZ7Xd+jVtXqdtdhFUNrGFhBOP/ElhhuzbF7VeSph5n5PjTM8tKGtmuuDCcX68D9jARu0T7BrcoLsP8WjsWhdkHT132weQfQ1NpmkzIG1nZFiJweOb0l/hcQp3Yq07ovMVk9dPYETXKVPWSPYl6/6rqFv8kUaluuKs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736169767; c=relaxed/simple;
	bh=qf6wGoW8wwbfm/lMdY6ttk39lMhMUPx+zAofJQLnd2A=;
	h=Message-ID:Date:MIME-Version:Subject:From:To:Cc:References:
	 In-Reply-To:Content-Type; b=CX8rXY00pY0fo8YzEyMUXgCI+NNrDdIn4njsd4eqXudm4Y+gIj4mXVyEsBuvdX4jJ4IUefFMH2k59rHp9FHZPz2iX/C8qFK1rF7brlq2k0coOBr8HvJCG8ncduvfoOWllC9fpuwQSx9xqDEE/c0OdIxVrRdPKdlsNSah9dtY7mg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=WcwcQwBx; arc=none smtp.client-ip=209.85.218.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ej1-f53.google.com with SMTP id a640c23a62f3a-aaeef97ff02so1747387666b.1
        for <netdev@vger.kernel.org>; Mon, 06 Jan 2025 05:22:45 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1736169764; x=1736774564; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:autocrypt:content-language
         :references:cc:to:from:subject:user-agent:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=S+t4D5QRfDjbwF/fWql0yMBexZnrw77uc2+xes4kLSA=;
        b=WcwcQwBxmLPLVDOKrOmmjOfe+hWEBl2iKaHpH7sEK8itOVwUA2q2KeR1qcW/CBEki+
         OG1NjvaGFjScvv4qlPQaNQm6kmwL9EENLY11bj60N35Ne7opZbyVxUB0O4gu0H9bBe36
         9q15YprUvb/o0NoECNqQQyutT43PFSWQjS9DNJMbHuoCtZ5PxeFcnswJXm5SGiazy6cx
         83TxUGwYrZzXy9ZJk/Rgl+zNANkD4zqfmrKUnm5mqoP+vkMXw3g3PhLmPeRpQA/uKLSE
         jsUNa6DLWRowoKqEl/cPQLfy9qWN4MHCuBWkF4l4dDG9RXm0eTApXkkMR7cXIA//SxFR
         pOCg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1736169764; x=1736774564;
        h=content-transfer-encoding:in-reply-to:autocrypt:content-language
         :references:cc:to:from:subject:user-agent:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=S+t4D5QRfDjbwF/fWql0yMBexZnrw77uc2+xes4kLSA=;
        b=LdJP6zGsNGcupJa6So7WjZo2T7n8r33d10UEe16vPLoXi0u8GI/q2oUih7+a08yYww
         B2LQUg0FyKtXR4SYTlZ8fmSAe72OOF7Sjw+nNXDoWnpFCaafCUay5Jeqtb032n6tXlA5
         ZmjHaIgY/scAiyDjFm7gae6oh8tJxuNonGJREF6wH2yRPzAVxM7m8j48JdJDG85pz6tx
         K7VQAiKfUhlb0cxyDhTWeXt3cH8SkSIXXVdxVS5vnv53hBDsglaq+BzH4y2HjOkXUKh1
         xs91dbcNgrbnMNbfaSaSRgx/Ouh+/uoJYcV0a9NyyilzNrAP4Y3IP+rc56FlBF/h4P6V
         dDfg==
X-Gm-Message-State: AOJu0YwGsQIH1kxvh4SGuGPrrptrIV2iHRlwqBI4zUdDRcIK/FgEWwMY
	12i1XDeWFX+ESV8wI5byQukplxPnC4hD/H6Hc6JOfw09ArT5v5Ql
X-Gm-Gg: ASbGncu6Wv5bMacAFpIsn3sOxzGyYBWtuYepo97CHEy4kU/D7DfoF8Ofv9IUini0NOf
	YrKywxBnBMdoT5+0f+GtKTWxCPxXLeI/TJy47SJcXK9rXWXdoq37gcu+E4j1W8uaozx1IW9Chi7
	D37RDUDgBA1rN33xEb2meKcGeH3KpKquqTzoBcFyfUqdZOu4LpXpYLW0VG8yLSCLBWLw1Vqo9g4
	j+mdXJS877dGj1LX92ug109OiVMs290jWYQaqWgtxZ9njY2miNBirOPa8KN686FGcUz0CXfQghm
	887laPnRDSB1v7MS3yiQEMiFWV3OKhyc6A3uieJn/EeN27bEGoPdDVtm6eedNcWCzxbSzQ3SeSU
	HWVehOCcEMUnDdl3RzDmKpwfG3ECe4ng10dapDMkS
X-Google-Smtp-Source: AGHT+IFDqd9DGM13ekiR/1j2Hsg6xDadmLk+QaKSXMelg8CgnsJGGuOc4zecDajxQy70qAdaM+QB4Q==
X-Received: by 2002:a17:907:da6:b0:aa6:824c:4ae5 with SMTP id a640c23a62f3a-aac345f5cfbmr5941839966b.56.1736169763991;
        Mon, 06 Jan 2025 05:22:43 -0800 (PST)
Received: from ?IPV6:2a02:3100:ad97:900:c87:b717:6cf:e370? (dynamic-2a02-3100-ad97-0900-0c87-b717-06cf-e370.310.pool.telefonica.de. [2a02:3100:ad97:900:c87:b717:6cf:e370])
        by smtp.googlemail.com with ESMTPSA id a640c23a62f3a-aac0efe4971sm2279057966b.107.2025.01.06.05.22.41
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 06 Jan 2025 05:22:42 -0800 (PST)
Message-ID: <9579ad70-7438-4ab6-81fd-8c6c6a9faa50@gmail.com>
Date: Mon, 6 Jan 2025 14:22:41 +0100
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: [PATCH net-next v2 1/2] net: phy: micrel: disable EEE on KSZ9477-type
 PHY
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

On several supported switches the integrated PHY's have buggy EEE.
On the GBit-capable ones it's always the same type of PHY with PHY ID
0x00221631. So we can simplify erratum handling by calling
phy_disable_eee() for this PHY type.

Note: The KSZ9477 PHY driver also covers e.g. the internal PHY of
      KSZ9563 (ID: 0x00221637), which is unaffected by the EEE issue.
      Therefore check for the exact PHY ID.

Reported-by: Oleksij Rempel <o.rempel@pengutronix.de>
Signed-off-by: Heiner Kallweit <hkallweit1@gmail.com>
---
v2:
- call phy_disable_eee() instead of clearing supported_eee
---
 drivers/net/phy/micrel.c | 12 ++++++------
 1 file changed, 6 insertions(+), 6 deletions(-)

diff --git a/drivers/net/phy/micrel.c b/drivers/net/phy/micrel.c
index eeb33eb18..e7eaa1264 100644
--- a/drivers/net/phy/micrel.c
+++ b/drivers/net/phy/micrel.c
@@ -1524,6 +1524,12 @@ static int ksz9477_get_features(struct phy_device *phydev)
 	if (ret)
 		return ret;
 
+	/* See KSZ9477 Errata DS80000754C Module 4 */
+	if (phydev->phy_id == PHY_ID_KSZ9477) {
+		phy_disable_eee(phydev);
+		return 0;
+	}
+
 	/* The "EEE control and capability 1" (Register 3.20) seems to be
 	 * influenced by the "EEE advertisement 1" (Register 7.60). Changes
 	 * on the 7.60 will affect 3.20. So, we need to construct our own list
@@ -2002,12 +2008,6 @@ static int ksz9477_config_init(struct phy_device *phydev)
 			return err;
 	}
 
-	/* According to KSZ9477 Errata DS80000754C (Module 4) all EEE modes
-	 * in this switch shall be regarded as broken.
-	 */
-	if (phydev->dev_flags & MICREL_NO_EEE)
-		linkmode_fill(phydev->eee_broken_modes);
-
 	return kszphy_config_init(phydev);
 }
 
-- 
2.47.1



