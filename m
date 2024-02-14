Return-Path: <netdev+bounces-71828-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 6345D8553DB
	for <lists+netdev@lfdr.de>; Wed, 14 Feb 2024 21:18:59 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id E1C491F22A65
	for <lists+netdev@lfdr.de>; Wed, 14 Feb 2024 20:18:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6A4E013DBAE;
	Wed, 14 Feb 2024 20:18:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="RO/2wNxJ"
X-Original-To: netdev@vger.kernel.org
Received: from mail-ed1-f42.google.com (mail-ed1-f42.google.com [209.85.208.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B3F5413DBA9
	for <netdev@vger.kernel.org>; Wed, 14 Feb 2024 20:18:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707941934; cv=none; b=fEGq0Pv7QISip2f8FqNblsluZe6JL9RDyu2qgpYxTf7VMLNhn1QszULSAi/MPC82O35RIxIegQS6NQ/etgR0ljdR2h1/Rh/tOOTMd13RGuNU++wSnbDlQ3GUKdX6jAk/3H+nU/LDaGzpQGARokDnQ3YE/YeIgETSxLd/cntHhUw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707941934; c=relaxed/simple;
	bh=70R//JjeVcpmPkvafVhctCQZhnAXsfHQXQzyFdjz4bM=;
	h=Message-ID:Date:MIME-Version:Subject:From:To:Cc:References:
	 In-Reply-To:Content-Type; b=XZk7TplqBXXs/HG0W52Yegyyleoaa1ML/oPIU0iMFR2roATEa19VoDcM0rUtH+TCZCI3keq5KTE6CRO3AUDi3c9mMDtu4ahSgk4fii+rNHEUYeIQ9pwt9EOgD1e2lx4SH22EXKlVLWycYZoUWOEG+/gwtgI6gTZEqbMXo1+pE5Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=RO/2wNxJ; arc=none smtp.client-ip=209.85.208.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ed1-f42.google.com with SMTP id 4fb4d7f45d1cf-55a035669d5so209339a12.2
        for <netdev@vger.kernel.org>; Wed, 14 Feb 2024 12:18:52 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1707941931; x=1708546731; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:autocrypt:references:cc:to
         :from:content-language:subject:user-agent:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=1ASSBrSu0ZQPnneorymVjDupx59iVfyhmn7B7z+Ogd4=;
        b=RO/2wNxJTRuAkiDajRjpn+mDppH8SE61Utwa+DKcxgVK/BbZi65q5IzV32gP2m6XN4
         5dYL+bGSZCS0smfu/HKh5sc5fTm0uF0rpBrU4awKOHPim29eSOu7Rn5KisUPDHs6S689
         07OUhx5ggbUenrjup7DP6695Uh7R9/XZOBgWRGYN2ayoyi2bbabH2ke5uHPhBzZq4Oz5
         ZMMGqHdmOFU0YuK+zEKmniCKzoEkbOSlUEZA7ah4iKYaFEWoAqbOlD4X2eiPmNvd6Nez
         0m4RzZ2TDTFGQLK9bbMGv35WYS87YgiBa5U/9l1FTNtuxXzTQtWSfMMQ35jChsT6I5bf
         P9+g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1707941931; x=1708546731;
        h=content-transfer-encoding:in-reply-to:autocrypt:references:cc:to
         :from:content-language:subject:user-agent:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=1ASSBrSu0ZQPnneorymVjDupx59iVfyhmn7B7z+Ogd4=;
        b=Fwk/OwikEBc5WIsBHBv8EPyqpTevOZR5PwopMy+Gl5yJQj3Y5iQvm+OFTosgMDsN0+
         IVDoNZUQdwyAWS1xKimKrW8cm6EH76uyChcrCMfhJEh1sefcS/gOknXd8MchAakAKz0y
         oRIMhQ8bw5feGC5CRHgDdqPLjD1J4wLzxjQSA9j7eMoGB2/kVge1r4SXvq5dKWztfmUZ
         SEUoF/btYota1NoAMESWVDXyr2mb8P+ZlBrhmpMNW0NSjw2LxbuZM+Naqi1SazokjNNM
         x0JUfs6rknI5vzQ4s39rbykcvpzngmmJhSs+Hhvq+hvao8AZdVoqmsKGQo7Xe7xqLG1T
         EHDg==
X-Gm-Message-State: AOJu0Yz1NAE+bdkZiC2NI2eyYc5Aj9Xjpypemdal4pbS2SHy7SIEqJnN
	0kJnLgKeUDTJ/3E2UCXluZyVOnQAyCTc7/5HF+v2mB4nLeU3tUK1
X-Google-Smtp-Source: AGHT+IFyshs/j3sNG5Q3OwBGqvba8+Pz3bypkk6cdlCQEJ6OTMxA3h7ebMBGA7WXvNc9N2bA9ZTqFg==
X-Received: by 2002:aa7:c54b:0:b0:560:cc04:a96c with SMTP id s11-20020aa7c54b000000b00560cc04a96cmr2683620edr.24.1707941930741;
        Wed, 14 Feb 2024 12:18:50 -0800 (PST)
X-Forwarded-Encrypted: i=1; AJvYcCVcmyTDdHhZDS3opY5Ifb6eufLj5AttPYa6rWI3317oA7JOzqi0alChWq5xwVVjuy9tWePfdViOdA4dnfP/kJTZ9gMHem1HqQ5LY2QmQO+pFjTnMNQ83/LdWN7rUOtgX3XcBlRmPKtoWSQRPoPpFjO8RVLgpMnC7VVcHeLxegkCQoLKnuhA4YHko32LRD1I9hlW1Lg=
Received: from ?IPV6:2a01:c23:c153:4a00:f92b:249d:fae6:3a40? (dynamic-2a01-0c23-c153-4a00-f92b-249d-fae6-3a40.c23.pool.telefonica.de. [2a01:c23:c153:4a00:f92b:249d:fae6:3a40])
        by smtp.googlemail.com with ESMTPSA id en14-20020a056402528e00b0055fef53460bsm4979118edb.0.2024.02.14.12.18.49
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 14 Feb 2024 12:18:50 -0800 (PST)
Message-ID: <be7f8af6-0acc-4289-aefe-d4bf5dd39a2f@gmail.com>
Date: Wed, 14 Feb 2024 21:18:50 +0100
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: [PATCH net-next 4/5] net: phy: c45: add support for EEE link partner
 ability 2 to genphy_c45_read_eee_lpa
Content-Language: en-US
From: Heiner Kallweit <hkallweit1@gmail.com>
To: Andrew Lunn <andrew@lunn.ch>,
 Russell King - ARM Linux <linux@armlinux.org.uk>,
 Paolo Abeni <pabeni@redhat.com>, Eric Dumazet <edumazet@google.com>,
 Jakub Kicinski <kuba@kernel.org>, David Miller <davem@davemloft.net>
Cc: "netdev@vger.kernel.org" <netdev@vger.kernel.org>
References: <558e122f-e900-4a17-a03a-2b9ec4fed124@gmail.com>
Autocrypt: addr=hkallweit1@gmail.com; keydata=
 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
In-Reply-To: <558e122f-e900-4a17-a03a-2b9ec4fed124@gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

Add support for reading EEE link partner ability 2 register.

Signed-off-by: Heiner Kallweit <hkallweit1@gmail.com>
---
 drivers/net/phy/phy-c45.c | 11 +++++++++++
 1 file changed, 11 insertions(+)

diff --git a/drivers/net/phy/phy-c45.c b/drivers/net/phy/phy-c45.c
index 5a245f0cc..b09c6baf0 100644
--- a/drivers/net/phy/phy-c45.c
+++ b/drivers/net/phy/phy-c45.c
@@ -781,6 +781,17 @@ static int genphy_c45_read_eee_lpa(struct phy_device *phydev,
 		mii_eee_cap1_mod_linkmode_t(lpa, val);
 	}
 
+	if (linkmode_intersects(phydev->supported_eee, PHY_EEE_CAP2_FEATURES)) {
+		/* IEEE 802.3-2022 45.2.7.17 EEE link partner ability 2
+		 * (Register 7.63)
+		 */
+		val = phy_read_mmd(phydev, MDIO_MMD_AN, MDIO_AN_EEE_LPABLE2);
+		if (val < 0)
+			return val;
+
+		mii_eee_cap2_mod_linkmode_adv_t(lpa, val);
+	}
+
 	if (linkmode_test_bit(ETHTOOL_LINK_MODE_10baseT1L_Full_BIT,
 			      phydev->supported_eee)) {
 		/* IEEE 802.3cg-2019 45.2.7.26 10BASE-T1 AN status register
-- 
2.43.1



