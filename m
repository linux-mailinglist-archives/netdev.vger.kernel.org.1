Return-Path: <netdev+bounces-72762-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id BE92F859866
	for <lists+netdev@lfdr.de>; Sun, 18 Feb 2024 19:04:55 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id EDA60B20A66
	for <lists+netdev@lfdr.de>; Sun, 18 Feb 2024 18:04:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7CD126EB42;
	Sun, 18 Feb 2024 18:04:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="P8iZtd/A"
X-Original-To: netdev@vger.kernel.org
Received: from mail-ed1-f49.google.com (mail-ed1-f49.google.com [209.85.208.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BD3E06EB78
	for <netdev@vger.kernel.org>; Sun, 18 Feb 2024 18:04:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708279487; cv=none; b=lwfP2pmj96l4PszZcPkgJm8RrPdFwDq/44QfCEZ/rVUoPu44TVvrWq2D1boTXB3pLulreJCpJ7SifC70G5jKfx1K/q0Aw0x0KEZJvBQ7QminYrZ6lhC5qfY0N2Qz1hMorG+KrV1XKcrV01g+VP0/7wWuD433amZAWcyWtVQJFfU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708279487; c=relaxed/simple;
	bh=QT53atjJJ1vw7GU3v0lQnlNsfRJBd9sRcnUo6SKvZoY=;
	h=Message-ID:Date:MIME-Version:To:Cc:From:Subject:Content-Type; b=nUGkfm27CIUv2/usHg3xWGv6zVCtF/FJcN2dYKXv08uZgkqZJp6QdfnzVreagzAP+3LIr+wXTxULhfz22ncu7zR2tshUIKg8Y4nDHSNkXL7NJu+MGE/4hWvthqBKDPzlkbEWVFh6T5iRhH582/BoCZx5teHqpgdUf8FGSAdlPw8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=P8iZtd/A; arc=none smtp.client-ip=209.85.208.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ed1-f49.google.com with SMTP id 4fb4d7f45d1cf-5611e54a92dso4777284a12.2
        for <netdev@vger.kernel.org>; Sun, 18 Feb 2024 10:04:45 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1708279484; x=1708884284; darn=vger.kernel.org;
        h=content-transfer-encoding:autocrypt:subject:from:cc:to
         :content-language:user-agent:mime-version:date:message-id:from:to:cc
         :subject:date:message-id:reply-to;
        bh=W5zEuthr4m6qNdMoc14v8jKuscSwrPopo1Du60QwSHQ=;
        b=P8iZtd/AnY2FiVk9Mc5MJb2sHCafiUBvM+bNWusFUivuvCjeRRdRIPST2oYOFZPNZx
         TfTmTQhu99S9nfZ2fYTzyrmUe9WBzXzuFXN6Gab7Maa50C+mqKnj9MOmchHHaY5WR1XX
         4HRhHOfg0Q4X5cQWtd2knQYDJ857vuP9ua9mnw2j/wtxPJwjOkVdwxwKYc9toD2fU9vL
         c2vN+jG4d20AOTS7oKXuLkeabzp+jHlnx+0Q2uZih7t+eS7Ua3w/DHBXoC8m87pr03nD
         X0LXLVV9+nuz1LYDg8PJdwTQla9+mTGY605cwUeyZqkvO9ztrIVYvnUUgz2xZjKS3mm1
         fPig==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1708279484; x=1708884284;
        h=content-transfer-encoding:autocrypt:subject:from:cc:to
         :content-language:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=W5zEuthr4m6qNdMoc14v8jKuscSwrPopo1Du60QwSHQ=;
        b=SZqW7D/On9smcKyIg8Xu8XRnn+BnGfijAnmyuqOjSeZZyL1Jkq5b/DcYVyJGvlJ4Vr
         eCeEDGkYP5i+icg9V0V9cjDvmVNknAYIaMfJQqUr3YE8J7S8J9B0dzcmkBHt1qQMJnVy
         9HXN1qxNGyP3oWF44wSG9zjbt79gz+Xpb1/j7V423FacAJMG8oRedrizUPnx40KbH+G0
         2kkRI6JoLwRgvdXmJ1bNYk+i1TR/YewlpgOYPtH3xTGDIYwmDBwCg9Kidd2WUugHDfZZ
         OANOSAVMeHvqd53xg2PmFEeTvo/H/WUFvLdskTxjB3W/B+8/Mxi+d9kE63rEazwHJDs3
         RZYg==
X-Gm-Message-State: AOJu0Yx9f+F9PVoQKR/egIr/t6y1vSJabAUX3TU6W5AXaj9YFyBKt5iA
	VFX8adgNiLRFmp8Zrwp8DmIqFuoIbxMlisW042yHCA5uPdPNT9p/
X-Google-Smtp-Source: AGHT+IHZIYfZe9Cc/AzQfwrQ3oED3/GAdaJhszYPSmRsZg60kHDzr32f2FSdGuDh7koCK9vRdMN2Uw==
X-Received: by 2002:aa7:ca56:0:b0:564:6fe5:71f8 with SMTP id j22-20020aa7ca56000000b005646fe571f8mr711926edt.32.1708279483053;
        Sun, 18 Feb 2024 10:04:43 -0800 (PST)
Received: from ?IPV6:2a01:c23:b9e5:d800:2cda:54d5:8742:3de1? (dynamic-2a01-0c23-b9e5-d800-2cda-54d5-8742-3de1.c23.pool.telefonica.de. [2a01:c23:b9e5:d800:2cda:54d5:8742:3de1])
        by smtp.googlemail.com with ESMTPSA id es11-20020a056402380b00b00561e675a3casm1945439edb.68.2024.02.18.10.04.42
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sun, 18 Feb 2024 10:04:42 -0800 (PST)
Message-ID: <9fcf20f5-7763-4bde-8ed8-fc81722ad509@gmail.com>
Date: Sun, 18 Feb 2024 19:04:42 +0100
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Content-Language: en-US
To: Pavan Chebbi <pavan.chebbi@broadcom.com>,
 Michael Chan <mchan@broadcom.com>, Paolo Abeni <pabeni@redhat.com>,
 Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>,
 David Miller <davem@davemloft.net>, Andrew Lunn <andrew@lunn.ch>
Cc: "netdev@vger.kernel.org" <netdev@vger.kernel.org>
From: Heiner Kallweit <hkallweit1@gmail.com>
Subject: [PATCH net-next] tg3: simplify tg3_phy_autoneg_cfg
Autocrypt: addr=hkallweit1@gmail.com; keydata=
 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
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

Make use of ethtool_adv_to_mmd_eee_adv_t() to simplify the code.

Signed-off-by: Heiner Kallweit <hkallweit1@gmail.com>
---
 drivers/net/ethernet/broadcom/tg3.c | 17 ++++-------------
 1 file changed, 4 insertions(+), 13 deletions(-)

diff --git a/drivers/net/ethernet/broadcom/tg3.c b/drivers/net/ethernet/broadcom/tg3.c
index 7a07c5216..62ff4381a 100644
--- a/drivers/net/ethernet/broadcom/tg3.c
+++ b/drivers/net/ethernet/broadcom/tg3.c
@@ -4354,21 +4354,12 @@ static int tg3_phy_autoneg_cfg(struct tg3 *tp, u32 advertise, u32 flowctrl)
 	if (!err) {
 		u32 err2;
 
-		val = 0;
-		/* Advertise 100-BaseTX EEE ability */
-		if (advertise & ADVERTISED_100baseT_Full)
-			val |= MDIO_AN_EEE_ADV_100TX;
-		/* Advertise 1000-BaseT EEE ability */
-		if (advertise & ADVERTISED_1000baseT_Full)
-			val |= MDIO_AN_EEE_ADV_1000T;
-
-		if (!tp->eee.eee_enabled) {
+		if (!tp->eee.eee_enabled)
 			val = 0;
-			linkmode_zero(tp->eee.advertised);
-		} else {
-			mii_eee_cap1_mod_linkmode_t(tp->eee.advertised, val);
-		}
+		else
+			val = ethtool_adv_to_mmd_eee_adv_t(advertise);
 
+		mii_eee_cap1_mod_linkmode_t(tp->eee.advertised, val);
 		err = tg3_phy_cl45_write(tp, MDIO_MMD_AN, MDIO_AN_EEE_ADV, val);
 		if (err)
 			val = 0;
-- 
2.43.2


