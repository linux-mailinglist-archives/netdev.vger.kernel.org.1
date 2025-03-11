Return-Path: <netdev+bounces-173764-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 9DB04A5B953
	for <lists+netdev@lfdr.de>; Tue, 11 Mar 2025 07:39:38 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 2C7AC1892C69
	for <lists+netdev@lfdr.de>; Tue, 11 Mar 2025 06:39:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E6A591F03F2;
	Tue, 11 Mar 2025 06:39:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="X321t56B"
X-Original-To: netdev@vger.kernel.org
Received: from mail-ej1-f42.google.com (mail-ej1-f42.google.com [209.85.218.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2F9CB1E9B1F
	for <netdev@vger.kernel.org>; Tue, 11 Mar 2025 06:39:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741675174; cv=none; b=NFc/OE85PuLmnQvzEHqM7NcOyk7YuGzoJalosa7FdrUGqTKthZ6JDG4/jexcanxcojmDC98kqNY+GFK0MUTVPjRp91GEszZtx8TUZFsV3iXnxyVxRRbo9SN95ywEYffpHVxi3oCICwoQgCOBfdNL2h/EiSBpKSFSVoS821s05LM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741675174; c=relaxed/simple;
	bh=x84y1YiYxzvQFpxbeSWw8i2AnBhaKu5wQsBUBQdOc9o=;
	h=Message-ID:Date:MIME-Version:To:Cc:From:Subject:Content-Type; b=DktzXxSJ2Gfe7VXKX9lZvG+UWjHxeMFvZ0SphsTF8BDwh21JbVIXn+LOc022zkLHHHdGL1UW0woqdW/a7OuHXGmRSRaUY6rx54YL9vgEITOiT5pElidgGTjMYdrHzGResoLk4N5uLEprOKmjF9HZtgFeiuvcpuPT9oeuXv9Oyhk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=X321t56B; arc=none smtp.client-ip=209.85.218.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ej1-f42.google.com with SMTP id a640c23a62f3a-aaee2c5ee6eso694349766b.1
        for <netdev@vger.kernel.org>; Mon, 10 Mar 2025 23:39:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1741675171; x=1742279971; darn=vger.kernel.org;
        h=content-transfer-encoding:autocrypt:subject:from:cc:to
         :content-language:user-agent:mime-version:date:message-id:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Y+tm/rgNfkmaK4aaHuAz++rkiT9ipjAMgSoCm+0FoPU=;
        b=X321t56Be8HOZ3f5qJXIHaz7eTGV6EY8xWAUCfst0MwWqd0kAhPK9cB4AdA/o1raOY
         TiRQM4HpEbv990z/VhkOLYDjj1hmMgJADToDiKD33gP2f86u9l3yCHIt1lePOpMfVT+4
         SVGFUgM8meOfR7aObU0NJ9PDXFZPKpPZ7rC/oBJvBC4JCrwJPAkiLBO6U27UonrSjGio
         96hrD+digAMDUpyd4RNlPz4KHcD2wTdrBKpn22QSzLHmb39nIAdktXa9gBZRmhvmRsAZ
         IEqm3wEETXM4LG6eYxvVT6XvIYz5dsbRBlyf8iwo1SUjkTau+3nN589iduyyJFuO6pcD
         +q8w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1741675171; x=1742279971;
        h=content-transfer-encoding:autocrypt:subject:from:cc:to
         :content-language:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=Y+tm/rgNfkmaK4aaHuAz++rkiT9ipjAMgSoCm+0FoPU=;
        b=L+VI+WvgPpC6LuP3qRyPJvNiGhD4fvrPKMclx5Wyy3kVMYEVgWGaIuALqxS8G0Qe3N
         EBJP8NehpDAEWxUjg3n/5y9Yny4TuNLGF6DSoYx2Gl1/yJCHSlXNzK+OXW3Nutr9U/6e
         FguR3KZKL6zS0xvRpsR5q41FCPBPgducAyG2meFDxSzL/eL1K0ciwCbY+MQADDzF5OEp
         BAzSKZCvNivTACLvSrdEbZJvtaPItZ8P6yKpZb7ZiQYyKlupGI6JC7i4Tr+ITSXxMBTE
         txUSn8WBrdtBZuC/o2O/E2gIuHt2svt+cmdSiQrcVvMcZwRkXKx1aCWHFd6CpYat2myH
         +zQw==
X-Gm-Message-State: AOJu0YxzSL0+6djRX6DwJomSLew6ueex6YYaap6l7u7JtS/gcRcKWUWc
	Ol51h4+i6LqjYCXHXm2KMyDjKxJoWhfVli7pkr7K8/y6ehRa1j7mYzBfBQ==
X-Gm-Gg: ASbGncvtw1dZ4Y7FCVQycHSPBTHHngvdKtcrlJvjVea2MH3uHagvK3z8ogt8gQHFC9u
	0klDQvVPhJHUNKtcf4R9OCc39CgXffANgaM3iCEbFIuu9r82Lptv6RkTA3/ns6JuTzkB/pEFpk2
	AmG0xsbjHZvud1DiFOAU+bvuxOBhu5OP2ngd2hERsrJQQozasW6tC4vut86UT20fcL36mtsdF3r
	w4OMZ7JIzb0uW7Sstso6myR8wJwqAEQpuoSZsk63GYfH09Fs251fzDIR2tOCL43AT0cSFoMGMrA
	gHLOAd96BtNygu0I6XdGBEIwm7HeMwPTpwj5NgxzHzcyWhsBaFXPNLHL4kKbphT48AtFi6m1FBI
	vQ3jJvOA88kvTnCWv8X1G3VGHeRWWFxIFUL/7WulW1homNetDZS5RnkKOQm9C+HdnZpKt1Ad6ko
	KT8P3YWJZHe7gkxpbHNCC8TRaWq88EWWhp7DtJ
X-Google-Smtp-Source: AGHT+IFWUw58Ix/3G/kolIJ5bxvwbvCPyg6/nJ3YQ/JDVORkm3u81J8C5/p3U7NBrcsuBgxfda7Oiw==
X-Received: by 2002:a17:907:1b02:b0:abf:75d7:72a2 with SMTP id a640c23a62f3a-ac252f5b3b4mr2160150966b.38.1741675170981;
        Mon, 10 Mar 2025 23:39:30 -0700 (PDT)
Received: from ?IPV6:2a02:3100:ad09:4d00:f159:4498:19a5:6163? (dynamic-2a02-3100-ad09-4d00-f159-4498-19a5-6163.310.pool.telefonica.de. [2a02:3100:ad09:4d00:f159:4498:19a5:6163])
        by smtp.googlemail.com with ESMTPSA id a640c23a62f3a-ac23973af6fsm876269966b.100.2025.03.10.23.39.30
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 10 Mar 2025 23:39:30 -0700 (PDT)
Message-ID: <1c1a5c49-8c9c-42a7-b087-4a84d3585e0d@gmail.com>
Date: Tue, 11 Mar 2025 07:39:33 +0100
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Content-Language: en-US
To: Florian Fainelli <florian.fainelli@broadcom.com>,
 Andrew Lunn <andrew@lunn.ch>, Vladimir Oltean <olteanv@gmail.com>,
 David Miller <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>,
 Paolo Abeni <pabeni@redhat.com>, Jakub Kicinski <kuba@kernel.org>
Cc: "netdev@vger.kernel.org" <netdev@vger.kernel.org>
From: Heiner Kallweit <hkallweit1@gmail.com>
Subject: [PATCH net-next] net: dsa: b53: use genphy_c45_eee_is_active
 directly, instead of phy_init_eee
Autocrypt: addr=hkallweit1@gmail.com; keydata=
 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
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

Use genphy_c45_eee_is_active directly instead of phy_init_eee,
this prepares for removing phy_init_eee. With the second
argument being Null, phy_init_eee doesn't initialize anything.

Signed-off-by: Heiner Kallweit <hkallweit1@gmail.com>
---
 drivers/net/dsa/b53/b53_common.c | 5 +----
 1 file changed, 1 insertion(+), 4 deletions(-)

diff --git a/drivers/net/dsa/b53/b53_common.c b/drivers/net/dsa/b53/b53_common.c
index 61d164ffb..17e3ead16 100644
--- a/drivers/net/dsa/b53/b53_common.c
+++ b/drivers/net/dsa/b53/b53_common.c
@@ -2212,10 +2212,7 @@ EXPORT_SYMBOL(b53_mirror_del);
  */
 int b53_eee_init(struct dsa_switch *ds, int port, struct phy_device *phy)
 {
-	int ret;
-
-	ret = phy_init_eee(phy, false);
-	if (ret)
+	if (!phy->drv || genphy_c45_eee_is_active(phy, NULL) <= 0)
 		return 0;
 
 	b53_eee_enable_set(ds, port, true);
-- 
2.48.1


