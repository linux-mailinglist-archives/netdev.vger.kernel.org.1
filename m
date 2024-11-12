Return-Path: <netdev+bounces-144226-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 51CEA9C63D5
	for <lists+netdev@lfdr.de>; Tue, 12 Nov 2024 22:54:55 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 27D90B24A76
	for <lists+netdev@lfdr.de>; Tue, 12 Nov 2024 20:33:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 52498200C93;
	Tue, 12 Nov 2024 20:33:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="kbDTMI/R"
X-Original-To: netdev@vger.kernel.org
Received: from mail-ej1-f53.google.com (mail-ej1-f53.google.com [209.85.218.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 970D11FA829
	for <netdev@vger.kernel.org>; Tue, 12 Nov 2024 20:33:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731443597; cv=none; b=jFkvjuuas78CAbZn3X+3Zt/T7GKLlXqW1wOBv++LR0pJz717cnhDIBAT4XNjEqVKpt0QtXDKgob+uE8Hriu8GcCIP6oqzBTD6rgSiXCFuT+hrcbiDQOEPQ5TGYn8Ii7IB3QNB1aSTRZdmYcVBNl8JmeIpqcFysAC35ApWECmr4E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731443597; c=relaxed/simple;
	bh=+lG2od7J8YFJI+zwu1+kfkfyqXWoaBrgjXc41rR+DeE=;
	h=Message-ID:Date:MIME-Version:To:Cc:From:Subject:Content-Type; b=XbhQa52k/rljUc+FJa1id2O3oRkHcznFVi9pu3amk5g9Hur/p5jlwKJMEqDOPJ40tyRYlVTsIMmBRN5w3bBpnZI5fpm+I0gMkQ8ubJiELO2hNWaBLyRehIHtc7nkg0srbO84U3KVoibClddTnWWoqYxvWTHqUf21ef2MS07OAXg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=kbDTMI/R; arc=none smtp.client-ip=209.85.218.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ej1-f53.google.com with SMTP id a640c23a62f3a-a9a850270e2so1113184866b.0
        for <netdev@vger.kernel.org>; Tue, 12 Nov 2024 12:33:15 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1731443594; x=1732048394; darn=vger.kernel.org;
        h=content-transfer-encoding:autocrypt:subject:from:cc:to
         :content-language:user-agent:mime-version:date:message-id:from:to:cc
         :subject:date:message-id:reply-to;
        bh=XltBEOO3XhrHX2Jiumb7VcSAsIURWoQq4SFauQXzM8E=;
        b=kbDTMI/RUVix+MoBeyxDnxJUvupwgFBdr70NfU02oHtIDGDOKS55BV6HXBvqBuHHED
         z4SmArOMUS5oKmv/joKxe4+znaciwH9pFD7BnuLgUiEMbzwtHYvE7p7+vEwMFGz3XIb8
         /pm8IHDqXHDcwXFTaFWdArlqXjkrZFlIaCW6k3RJJUXGlXi25HKk+UadlUz1dlIk8j4+
         2/USZorASGFDqvD5SrW17ndsoEsqIjZ34Iw7fPlUXkN3CqiAxlTV+k9f22Ei6lX/waDv
         VM43PCspNwoN/T43UI31kKQEHVNbchhzV2ZDgRg7TrWqINbKAh/3jEd3o5i8D07Inaol
         BHsw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1731443594; x=1732048394;
        h=content-transfer-encoding:autocrypt:subject:from:cc:to
         :content-language:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=XltBEOO3XhrHX2Jiumb7VcSAsIURWoQq4SFauQXzM8E=;
        b=lOVHydqCDflKpksaQKm7qXSWy+uqxxuKU9hgBAsZenZ6u2nRT0e++/Newh+h9mH6vH
         ngKh2AvVUFNycHYWTxrDQvbimBcYSJhd36QL7Cnjk8DbAnEZr3DN4IYp3ESu9aOxmcQD
         yyXRjmwqF2N0c4i1m5u8tkxsv2XOclLBb/Q6hsv+yN7Cd39ZWzaxjt9G03nxQ0GXRUHw
         GlWWCW72/T2N64OF7LDuGQH2R7OQAQ5r3guo83cT/Bi0voTRsZd1R3p8hIXTRL24EhRe
         jf/Q0INNT4y63pT5OlktyQOMVZgMf201cACzF0v36Mqb11GbX/Isyx2vu6BkRtL/+99X
         038g==
X-Gm-Message-State: AOJu0Yz8ogxNnmmYtXTM9SkcOdZPaV052aJ74eu1RWM51HAvmV7CHDSo
	18AeHHYkCf1+HEl1kPqa8JfW62oEtXn34cUtlEw6Rifa2wdDL1nr
X-Google-Smtp-Source: AGHT+IFeQmzZ2ae8i0oEOUNbe1xNKHVXlTqFDKlyF8LU+Mb0JiniGgDUHsrrXfaAZgIXo+3Y4ZS/nQ==
X-Received: by 2002:a17:907:6d05:b0:a9a:19c8:740c with SMTP id a640c23a62f3a-a9eeffeeb1bmr1766504466b.47.1731443593610;
        Tue, 12 Nov 2024 12:33:13 -0800 (PST)
Received: from ?IPV6:2a02:3100:a46e:ea00:edd9:afd4:7c83:6d14? (dynamic-2a02-3100-a46e-ea00-edd9-afd4-7c83-6d14.310.pool.telefonica.de. [2a02:3100:a46e:ea00:edd9:afd4:7c83:6d14])
        by smtp.googlemail.com with ESMTPSA id a640c23a62f3a-a9ee0a4a988sm758481166b.59.2024.11.12.12.33.10
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 12 Nov 2024 12:33:12 -0800 (PST)
Message-ID: <b0832102-28ab-4223-b879-91fb1fc11278@gmail.com>
Date: Tue, 12 Nov 2024 21:33:11 +0100
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Content-Language: en-US
To: Russell King - ARM Linux <linux@armlinux.org.uk>,
 Andrew Lunn <andrew@lunn.ch>, Paolo Abeni <pabeni@redhat.com>,
 Jakub Kicinski <kuba@kernel.org>, David Miller <davem@davemloft.net>,
 Eric Dumazet <edumazet@google.com>
Cc: "netdev@vger.kernel.org" <netdev@vger.kernel.org>
From: Heiner Kallweit <hkallweit1@gmail.com>
Subject: [PATCH net-next] net: phy: c45: don't use temporary linkmode bitmaps
 in genphy_c45_ethtool_get_eee
Autocrypt: addr=hkallweit1@gmail.com; keydata=
 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
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

genphy_c45_eee_is_active() populates both bitmaps only if it returns
successfully. So we can avoid the overhead of the temporary bitmaps.

Signed-off-by: Heiner Kallweit <hkallweit1@gmail.com>
---
 drivers/net/phy/phy-c45.c | 7 ++-----
 1 file changed, 2 insertions(+), 5 deletions(-)

diff --git a/drivers/net/phy/phy-c45.c b/drivers/net/phy/phy-c45.c
index 29cc22a4b..96a51a0b2 100644
--- a/drivers/net/phy/phy-c45.c
+++ b/drivers/net/phy/phy-c45.c
@@ -1521,20 +1521,17 @@ EXPORT_SYMBOL(genphy_c45_eee_is_active);
 int genphy_c45_ethtool_get_eee(struct phy_device *phydev,
 			       struct ethtool_keee *data)
 {
-	__ETHTOOL_DECLARE_LINK_MODE_MASK(adv) = {};
-	__ETHTOOL_DECLARE_LINK_MODE_MASK(lp) = {};
 	bool is_enabled;
 	int ret;
 
-	ret = genphy_c45_eee_is_active(phydev, adv, lp, &is_enabled);
+	ret = genphy_c45_eee_is_active(phydev, data->advertised,
+				       data->lp_advertised, &is_enabled);
 	if (ret < 0)
 		return ret;
 
 	data->eee_enabled = is_enabled;
 	data->eee_active = ret;
 	linkmode_copy(data->supported, phydev->supported_eee);
-	linkmode_copy(data->advertised, adv);
-	linkmode_copy(data->lp_advertised, lp);
 
 	return 0;
 }
-- 
2.47.0


