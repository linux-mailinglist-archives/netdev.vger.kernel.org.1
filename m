Return-Path: <netdev+bounces-157461-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 12208A0A5EF
	for <lists+netdev@lfdr.de>; Sat, 11 Jan 2025 21:32:27 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id DA96C1888AD3
	for <lists+netdev@lfdr.de>; Sat, 11 Jan 2025 20:32:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6275B1B85F8;
	Sat, 11 Jan 2025 20:32:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="cqwfwG+B"
X-Original-To: netdev@vger.kernel.org
Received: from mail-ed1-f49.google.com (mail-ed1-f49.google.com [209.85.208.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AA0991B6CEF
	for <netdev@vger.kernel.org>; Sat, 11 Jan 2025 20:32:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736627542; cv=none; b=aSYZIo14Vru6CEf8ANA4iGDWgpdVDmeMgSSyogknERHING7hYGCbtAvN850kRBPQr/Ry9W3Pcwt8Rrrv74CVlisUtjhxqUgRxv4tPP9WNmr6esIMG/2hJ0ENZk+Z+rOuA7Ur779XzTxNSmlOYjDS8Zw7wI6AAXwjsB61uFhxXKw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736627542; c=relaxed/simple;
	bh=Ucz0hiAy42WDB4uKuZxwdSoIsDzU9OGM1jY55eH5MIo=;
	h=Message-ID:Date:MIME-Version:Subject:From:To:Cc:References:
	 In-Reply-To:Content-Type; b=dI86cQ1CjLxs1Ohc2vszYEVZK2p46IZdzfc5x9f36b/0GPp9WSGLjvnRIgQ5aByMip7DamtmPNthx68WdKKPVluiVHMJuHwYBCA7R2Spot4NRVCkBW4EapMoxvfvwpEiRNec/+dzaBv0P4AyJfznROKeYut1KXAxLUartDALPB4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=cqwfwG+B; arc=none smtp.client-ip=209.85.208.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ed1-f49.google.com with SMTP id 4fb4d7f45d1cf-5d982de9547so5934586a12.2
        for <netdev@vger.kernel.org>; Sat, 11 Jan 2025 12:32:20 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1736627539; x=1737232339; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:autocrypt:content-language
         :references:cc:to:from:subject:user-agent:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=tIB9hYm3SMM7nD8Lkz5Og80NbrGxcOWypLxKiDzkZ+s=;
        b=cqwfwG+BA13vd9Ntk3T+ryY4AxDoS78pIS/nNPgXbsciuMChuShkk9ZCUgCh8g3lZc
         3/oCY/A9MAVrierFTbyL54pE3DllvW3astB7UW3qv1jHP7HTzWryh9ng0V/6WeGoFhhf
         HVrEF+j6T72DtuAVD4mYyaE6UnW4KV3b5aMqrw2WUnc535itFykcRaBeLOe8I2FW2B3P
         XIn1p1DYUeHc/uVuKyHx6F5oQiWA3Krrcg9YbjqYYpjWTdZaU7fRARRk/KnIV3x9zPo0
         9joEB/sFmd5sVyBaHq9e6O2YOlFgqarSY3MuUneuCDmEjFLXJfn3QAU/YHj+afwByK5f
         u6lQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1736627539; x=1737232339;
        h=content-transfer-encoding:in-reply-to:autocrypt:content-language
         :references:cc:to:from:subject:user-agent:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=tIB9hYm3SMM7nD8Lkz5Og80NbrGxcOWypLxKiDzkZ+s=;
        b=YsnPPV3jP5BEcFamf0h0Mckf4D6C84SAxr00nfwle/gej7j8kMN2PJ/sdpAVsikgV0
         5+7Jm2eGINlm+FM1f6/C/KUSDh1JhmpEFtfrZEmiDUfh6MHFYO7MANwmE2po4C3YFqmv
         LRFkMeaHBHYcFnmynwcmnxmSP+befwF8KxeZpot9VyLnhnx9e6xkT4gB7ObteMm36JFS
         AsQ0+57y5EQK9aN0egY/TWO/QzF63+p3bK9V/o463jlk8Gmip01fQYHXK/loptePvC8v
         bQfnGWWc44nuzzDdWDnHseTbRLWdiy+/pKqIAX03efSarlH4VSeAzQxQFILT6+sqCUr7
         GGjA==
X-Gm-Message-State: AOJu0YwYw3JHvpnTTcQV2TbqGjwz+FHihygCGl4lImHQHEo3EccL2Igx
	us6kwZMz5moOlMbW43upVkznZmeBKSKQ3lqt6vDJ9rl0tM5Fl0VV
X-Gm-Gg: ASbGncvEiIb3ZQCKX4ijIBHQWYXiPkYF0HFmE8mP7VwhVBcWr3S2nTxA2S4O2axyM26
	gj47Ae6Dj8PSCIMInlSxhcN9txueYPsdXUlgbU3cm7rvGyDa4XsA2hr4ZcY8s8ah5iGv10Oi1Y7
	Cp1t7eo9oBQjx19c9Orc9p7rzG+ijT5znmhHJ9WFJxEmz2GS3oW4i0KmMvkRwaElr94A//fFCO8
	42MzJtj3orYuz44gYOAY3sjk9BeRDpYcy1bPAzLmZLzIdHIT/q8CibQtuNrXu6nrEtueugKZ449
	MhYtOTCdv2ptCOtzL+1FTwyxKp63OiENUTyzPL0xhUd4CZfci6uuelsKYDZk2lP3KshiwpORoy5
	XX4F4NCPoAVL8v0rDB9xqu5Jfxbzu+LXKT7e5fnF5CVCHDhBC
X-Google-Smtp-Source: AGHT+IFCukCFdvQwhQ8kmvKkf6IPxTPPsl+Ik29JnUIkz9tUdqYDFrLNdLfddJrM57ENbj7mlk9z8g==
X-Received: by 2002:a05:6402:2743:b0:5d0:bcdd:ff9c with SMTP id 4fb4d7f45d1cf-5d972df6b1emr13814600a12.2.1736627538774;
        Sat, 11 Jan 2025 12:32:18 -0800 (PST)
Received: from ?IPV6:2a02:3100:a90d:e100:d8f1:2ffc:4f48:89fd? (dynamic-2a02-3100-a90d-e100-d8f1-2ffc-4f48-89fd.310.pool.telefonica.de. [2a02:3100:a90d:e100:d8f1:2ffc:4f48:89fd])
        by smtp.googlemail.com with ESMTPSA id 4fb4d7f45d1cf-5d9c592ec59sm460727a12.30.2025.01.11.12.32.16
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sat, 11 Jan 2025 12:32:17 -0800 (PST)
Message-ID: <5aadb2cb-3328-4126-89c5-eabd78181f30@gmail.com>
Date: Sat, 11 Jan 2025 21:32:16 +0100
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: [PATCH net-next v2 09/10] net: phy: c45: use cached EEE advertisement
 in genphy_c45_ethtool_get_eee
From: Heiner Kallweit <hkallweit1@gmail.com>
To: Paolo Abeni <pabeni@redhat.com>, Jakub Kicinski <kuba@kernel.org>,
 David Miller <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>,
 Simon Horman <horms@kernel.org>, Andrew Lunn <andrew@lunn.ch>,
 Russell King - ARM Linux <linux@armlinux.org.uk>
Cc: "netdev@vger.kernel.org" <netdev@vger.kernel.org>
References: <90b3fbda-1cb7-4072-912c-b03bf542dcdb@gmail.com>
Content-Language: en-US
Autocrypt: addr=hkallweit1@gmail.com; keydata=
 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
In-Reply-To: <90b3fbda-1cb7-4072-912c-b03bf542dcdb@gmail.com>
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
index 8cb420c04..2558b535a 100644
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



