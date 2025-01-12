Return-Path: <netdev+bounces-157543-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 91B94A0A9A2
	for <lists+netdev@lfdr.de>; Sun, 12 Jan 2025 14:34:43 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 8E85116719C
	for <lists+netdev@lfdr.de>; Sun, 12 Jan 2025 13:34:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7F4051B6D0D;
	Sun, 12 Jan 2025 13:33:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="mwnPjT55"
X-Original-To: netdev@vger.kernel.org
Received: from mail-wm1-f47.google.com (mail-wm1-f47.google.com [209.85.128.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C5A0C1B85C5
	for <netdev@vger.kernel.org>; Sun, 12 Jan 2025 13:33:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736688805; cv=none; b=lfITj/NvT3eWadgbXHAGjjH0iExzajnAar2zGse05lCUqFys1nJcdSkHUZEEwwkELluNNh+v9BEaAT7qHNh5pvZ9oUu2EsHZFZmaTMX1Xajwlfo8fzoJBdmr/QB5wjhnAXay1VXnI1e/fTK8VGgjG4HQ7N2CsftFNcw55dEcUZ0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736688805; c=relaxed/simple;
	bh=1UV8W1QOC9jTSftW+ZlJdWfSl4UDoMLw3erPQDgiVw8=;
	h=Message-ID:Date:MIME-Version:Subject:From:To:Cc:References:
	 In-Reply-To:Content-Type; b=AmNaSYeWuV/x92Yuf12Ag94KCY1oK2h7M6Tj2RlBEI7hzEkY09EtaCLOQLDJK2WIaXz7kphzP0Pw3CRApuJDV1SmqkwN9SRClwTSjyE9Yf+rm72+kw5cwoIKI50K4s3+bMuddAHQ+/G7+i4+GtHP5+/QCQztQ/wedz5kjfzHPTA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=mwnPjT55; arc=none smtp.client-ip=209.85.128.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f47.google.com with SMTP id 5b1f17b1804b1-436ce2ab251so24714325e9.1
        for <netdev@vger.kernel.org>; Sun, 12 Jan 2025 05:33:23 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1736688802; x=1737293602; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:autocrypt:content-language
         :references:cc:to:from:subject:user-agent:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=EkRLGew2XQH2T7WUYiBfVe1I8XUYYhyO0xpwRanKymc=;
        b=mwnPjT55GekeSvYkllzY3owUCW9d6PwT+PkOOErsAbMvTU+XzzzpABscyORi3ZQhmj
         CwDZ6xx8zfYoIZn2Ai1kJsB2iS98AwgIazkMOFVJDSsQ7cjvxqu13yM4jUo3M8D91+j2
         XxarwWK2B7gm6MeaGikRNOiE9+02TYtSKtsZrBnK+EHHyclq1ilk9wMzFjRuaPbbMV2x
         XVIln/9SmbVbsVmB/WKanJSgY3G1vFx9bIvbKFy/eJ0uw0RbSfg9I7Njl34NJmZtQ8jc
         fmuSSsdCMtNZcFgywz2JUM5Eqbg4CxeCBpzlvDYVdWcbAt88ixRX6m513LMd0zU4K1Wc
         RliQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1736688802; x=1737293602;
        h=content-transfer-encoding:in-reply-to:autocrypt:content-language
         :references:cc:to:from:subject:user-agent:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=EkRLGew2XQH2T7WUYiBfVe1I8XUYYhyO0xpwRanKymc=;
        b=QqlkQbUn/VBeRIlsxJ4kH9jZJogoY6AZz9Dfwcm+NlS7IbwrprHiqfEy7mvSTSIFLv
         fUX8xsFEpZQPn4UP15rhxbKp/tpwi7oXrVS1qwXY4Mx4pHyVfv/L8hEx4Kj4j9lnOoWP
         2PFeBmc38ecZYqLStRn3sK+7/FO3+ioAxcsHc1bq1PHuliOqUwQziDkytZq1QfPYPxiw
         jesVRkihVOmsQJulSKJoTnSGv8Kdp/33WU9DY4Gf6M9kfuZmkH0TPzq8egknxvT+IuUZ
         UiwrhCEe0Wa4OQ815b9xbP/ITCex9/l7HuphiHTn5D8Sxxt+NozvhwhAn1iXoP5m7ua0
         It6w==
X-Gm-Message-State: AOJu0YwLfPyav0yVq1OZDoFkfZ1Qj0pPbqottaGRZHMY63F0f5UBRA2+
	gwoIko/a9F6QwuDi/D1x8szYg/0YPWhL6yrmVMmHhCYoiTe52jPW
X-Gm-Gg: ASbGncsoU1Hzd8kH5dLNNbdZwXr6wnh9hkhkFWOvE+LdTdItYne1USZgdddEPc7l7F8
	KTn7Og+yBpk/sk9sfOW5Co0YnfICqhOYTJJl0jP/r7Pnc4gnP1rPfXJVEyqHaLaV1vY3tca8zMt
	AUF6iZR9Ff59RjuBEkMROCydI6RD8ZilN8iFlLiYId/fx+AGpAMlbSEmIt16TrgMJCJgRfstY4Z
	ZR/16OCIGRGfnZDfa2dyuTggzgYecbiJ0X6HYriXWF0w8kMI5ew3rHMEmhsjbWW0CTuuc+xbBeq
	lkv2xJ6UwsefhMuWDKdJ/g6v2+CKeN3AXA4CNEzMLWnrNiZlcpayvXQnAa6JIazJMijrLw9oD4z
	fgzD8w+3xZ+S7f8kkT5k6Bi9ODBCrkguQw2+wU1b9g+sHbTv/
X-Google-Smtp-Source: AGHT+IHOpXHUXDZmBLDJDZLQoqlGKOkMqHuXvt8rTPSHD6EnhKscdKn/8gTCLst68nVjORcdF/eZeA==
X-Received: by 2002:a05:600c:3b94:b0:434:e2ea:fc94 with SMTP id 5b1f17b1804b1-436e2696cb8mr169865595e9.11.1736688802092;
        Sun, 12 Jan 2025 05:33:22 -0800 (PST)
Received: from ?IPV6:2a02:3100:b0d5:ab00:44ab:526d:76d3:604a? (dynamic-2a02-3100-b0d5-ab00-44ab-526d-76d3-604a.310.pool.telefonica.de. [2a02:3100:b0d5:ab00:44ab:526d:76d3:604a])
        by smtp.googlemail.com with ESMTPSA id ffacd0b85a97d-38a8e38c1d6sm9842108f8f.50.2025.01.12.05.33.20
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sun, 12 Jan 2025 05:33:21 -0800 (PST)
Message-ID: <4362c63d-ce24-438a-96d1-4d6a092d2e07@gmail.com>
Date: Sun, 12 Jan 2025 14:33:21 +0100
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: [PATCH net-next v3 09/10] net: phy: c45: use cached EEE advertisement
 in genphy_c45_ethtool_get_eee
From: Heiner Kallweit <hkallweit1@gmail.com>
To: Paolo Abeni <pabeni@redhat.com>, Jakub Kicinski <kuba@kernel.org>,
 David Miller <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>,
 Simon Horman <horms@kernel.org>, Andrew Lunn <andrew@lunn.ch>,
 Russell King - ARM Linux <linux@armlinux.org.uk>
Cc: "netdev@vger.kernel.org" <netdev@vger.kernel.org>
References: <5e36223a-ee52-4dff-93d5-84dbf49187b5@gmail.com>
Content-Language: en-US
Autocrypt: addr=hkallweit1@gmail.com; keydata=
 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
In-Reply-To: <5e36223a-ee52-4dff-93d5-84dbf49187b5@gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

Now that disabled EEE modes are considered when populating
advertising_eee, we can use this bitmap here instead of reading
the PHY register.

Signed-off-by: Heiner Kallweit <hkallweit1@gmail.com>
---
 drivers/net/phy/phy-c45.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/net/phy/phy-c45.c b/drivers/net/phy/phy-c45.c
index 904a10c02..0fb5e20f3 100644
--- a/drivers/net/phy/phy-c45.c
+++ b/drivers/net/phy/phy-c45.c
@@ -1516,14 +1516,14 @@ int genphy_c45_ethtool_get_eee(struct phy_device *phydev,
 {
 	int ret;
 
-	ret = genphy_c45_eee_is_active(phydev, data->advertised,
-				       data->lp_advertised);
+	ret = genphy_c45_eee_is_active(phydev, NULL, data->lp_advertised);
 	if (ret < 0)
 		return ret;
 
 	data->eee_active = phydev->eee_active;
 	linkmode_andnot(data->supported, phydev->supported_eee,
 			phydev->eee_disabled_modes);
+	linkmode_copy(data->advertised, phydev->advertising_eee);
 	return 0;
 }
 EXPORT_SYMBOL(genphy_c45_ethtool_get_eee);
-- 
2.47.1



