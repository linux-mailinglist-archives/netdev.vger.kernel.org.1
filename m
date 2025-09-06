Return-Path: <netdev+bounces-220630-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 45354B477E0
	for <lists+netdev@lfdr.de>; Sun,  7 Sep 2025 00:00:05 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 329005669DD
	for <lists+netdev@lfdr.de>; Sat,  6 Sep 2025 22:00:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8F6B0286D40;
	Sat,  6 Sep 2025 22:00:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="I6JNMmva"
X-Original-To: netdev@vger.kernel.org
Received: from mail-wm1-f47.google.com (mail-wm1-f47.google.com [209.85.128.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C6B8A25782A
	for <netdev@vger.kernel.org>; Sat,  6 Sep 2025 21:59:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757196001; cv=none; b=A3ldQdVczG5xl/b2Ed6pY/2MNDRTmBjHG805qeUjNVJa4p00o0AcbEeE+UsvIfV/bXoztWwvkDph9UA4nxBFUndJRVws3BNm9Fdw+v67Y5/zUfkae72MqWGTsQDsd0dDHHZgDr4heiblQRBfgqeiGhFO5cIV5TR2Xko0xGqy3oc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757196001; c=relaxed/simple;
	bh=naTHotetYChM8d1fIKkv9GLNzCU87sEQyT5Tdwg2iZM=;
	h=Message-ID:Date:MIME-Version:Subject:From:To:Cc:References:
	 In-Reply-To:Content-Type; b=WyP6k3gXpRu3GyvLLW3nQwB9Wnffj1N/G5RM6wSmrGYUQpKaQAY8K0h3o5QuBIF3/MupLhSwP4ygWR+ARGKUJtVbeCLV3LNx4H//u+NFI0jfbnjHciwNFjHFoc+9uVR0R6wNs/Ffo0pwbMrNQ6gXTLw6uoQHsQYMV4UDr+cCcCI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=I6JNMmva; arc=none smtp.client-ip=209.85.128.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f47.google.com with SMTP id 5b1f17b1804b1-45ddddbe31fso4248535e9.1
        for <netdev@vger.kernel.org>; Sat, 06 Sep 2025 14:59:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1757195998; x=1757800798; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:autocrypt:content-language
         :references:cc:to:from:subject:user-agent:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=ZKMQxbyd2JHqSzYQxrU8xoYLRcofhtacT6oBuvkxs44=;
        b=I6JNMmvaxaF5eQZy1CD8U014ttSoHeKGcdAVk2tAwV6Jsje/Wu40XDxeU3k+UaYUDZ
         4AZ+Zd4HnGVG4zLrzyNbNTa/mv/GI4qYMAk14H9z1EULbG9GL7TFlk8emknzM8ikxWd7
         WLDpqLipQanit3YTJvwBOl7GduzRriHWinhhgNgRpiYHIZyrWOwHdYtte3NljXHx9BqP
         wQ5tH4NPH9ktMVqDGn3qoJ9yCpUN9PCljqQVEZquzRQp23Y6NWT+TxFDBTnv/PFyf1oz
         3PIUb//YEnUKE52QN8TXkYrc/gRaYUKzQOuSHBzAIQ7FBkUAZgaHR2N2WIMmlIcJDAoR
         FtPg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1757195998; x=1757800798;
        h=content-transfer-encoding:in-reply-to:autocrypt:content-language
         :references:cc:to:from:subject:user-agent:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=ZKMQxbyd2JHqSzYQxrU8xoYLRcofhtacT6oBuvkxs44=;
        b=vpiUmuG/VUjX9v5RAX7qQg95it/tP3VOodtHg4dKj5N3I9KtMDLDT4zZiKPAFmka4z
         3lZn8Nkto+dkfLD4ip3ncG2sPzM39MU8opq8M7Cct37b/htbDgd/PM6vT6gP31CPwFcH
         ORUlzNwt6tOXR784rrDN/b+FIxTGjk6cGHbGCSTlmVsriTr+Dq0GpfF4cS4wrUs/pJgh
         BiB/WbtuSAX2/NWARB3BnQst6SWvKTiOk5pAU9b55m3wKdN/waWPw4C2HmuUu2pxF4g5
         avzBxpyycgUDQm+Wk9mOPzWLWNqsOpnp+7/uO7iiFlkFNNsJNKsBfaJHByBhHa4K2mTm
         ihkw==
X-Gm-Message-State: AOJu0YyG2XwVty5iaCwh1L4epjPY3u7BVaKFwEE2/58pEsBDsmVMFMOG
	gGaInUghp2us+0FFU+2rKPLBWR00erGa/qgRFaqDw9VGE9pGOcXh07hC
X-Gm-Gg: ASbGncvFBNmcwNb6Kuim4z5zjzNjcwmxBOdz9VgxZ9EJki/X5ZXTSjeRM1xcC6bXDPp
	NPVD6gnuU7eMD3QY6uWBWrKt2QZ4CauXi7issfc0UV2uuJaZIXTX4SKgeIzlqpvUpQwDlaBNm9N
	0u/NxTmrM4SBSvZIN87v3swp36KIhJHaHHrqMkbYERo+fGCQDNZfJeOSVewXq5vT3Bvowlxz+xN
	hP8I7z+TpoviIncQHLtaiSmJiSL+BEXKprEm5ZeTfviaEpEJUt3GLt3y8HuS2NZxPg+lgnds+hr
	iFlxHf60tE/BetpZdi6ZZgjObD34FocduMAiIuOJo7bUf5P3qHK30szn61RZG/2ljbMtLUnsNMp
	PyPNdoW3tmW95XyXe8mQj5hpyUxpbFkG/NS/Toc95L5eG9F3maIDcBHhCLJ2DSvjRnFibVoRNfe
	JGrX+MnMJb+lJM1BvzB1b4iaLOLfTKOSc5Ys13NAAPplnIJuZbDEIvq2it52xSknfTzDnBPA==
X-Google-Smtp-Source: AGHT+IGJafonjUTefNCXxarqHQqBed5/hiDmQ3VWw7kFBi/7suftWthR5RIwI3LqPvyirwimZky7rw==
X-Received: by 2002:a05:600c:358a:b0:45b:9322:43fc with SMTP id 5b1f17b1804b1-45ddded6b98mr23712565e9.29.1757195997960;
        Sat, 06 Sep 2025 14:59:57 -0700 (PDT)
Received: from ?IPV6:2003:ea:8f2b:f400:f9ef:5bb:5d77:26c7? (p200300ea8f2bf400f9ef05bb5d7726c7.dip0.t-ipconnect.de. [2003:ea:8f2b:f400:f9ef:5bb:5d77:26c7])
        by smtp.googlemail.com with ESMTPSA id ffacd0b85a97d-3cf33fbb3cdsm19790092f8f.51.2025.09.06.14.59.56
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sat, 06 Sep 2025 14:59:57 -0700 (PDT)
Message-ID: <00843c01-6d60-46f9-b63e-1b894d8dbe0d@gmail.com>
Date: Sun, 7 Sep 2025 00:00:10 +0200
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: [PATCH net-next 1/4] net: phy: fixed_phy: remove unused interrupt
 support
From: Heiner Kallweit <hkallweit1@gmail.com>
To: Andrew Lunn <andrew@lunn.ch>, Andrew Lunn <andrew+netdev@lunn.ch>,
 Russell King - ARM Linux <linux@armlinux.org.uk>,
 Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
 Eric Dumazet <edumazet@google.com>, David Miller <davem@davemloft.net>
Cc: "netdev@vger.kernel.org" <netdev@vger.kernel.org>
References: <e81be066-cc23-4055-aed7-2fbc86da1ff7@gmail.com>
Content-Language: en-US
Autocrypt: addr=hkallweit1@gmail.com; keydata=
 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
In-Reply-To: <e81be066-cc23-4055-aed7-2fbc86da1ff7@gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

The two callers of __fixed_phy_add() both pass PHY_POLL, so we can
remove the irq argument to simplify the function.

Signed-off-by: Heiner Kallweit <hkallweit1@gmail.com>
---
 drivers/net/phy/fixed_phy.c | 9 +++------
 1 file changed, 3 insertions(+), 6 deletions(-)

diff --git a/drivers/net/phy/fixed_phy.c b/drivers/net/phy/fixed_phy.c
index aae7bd4ce..1ac17ef33 100644
--- a/drivers/net/phy/fixed_phy.c
+++ b/drivers/net/phy/fixed_phy.c
@@ -114,7 +114,7 @@ int fixed_phy_set_link_update(struct phy_device *phydev,
 }
 EXPORT_SYMBOL_GPL(fixed_phy_set_link_update);
 
-static int __fixed_phy_add(unsigned int irq, int phy_addr,
+static int __fixed_phy_add(int phy_addr,
 			   const struct fixed_phy_status *status)
 {
 	int ret;
@@ -129,9 +129,6 @@ static int __fixed_phy_add(unsigned int irq, int phy_addr,
 	if (!fp)
 		return -ENOMEM;
 
-	if (irq != PHY_POLL)
-		fmb->mii_bus->irq[phy_addr] = irq;
-
 	fp->addr = phy_addr;
 	fp->status = *status;
 
@@ -142,7 +139,7 @@ static int __fixed_phy_add(unsigned int irq, int phy_addr,
 
 void fixed_phy_add(const struct fixed_phy_status *status)
 {
-	__fixed_phy_add(PHY_POLL, 0, status);
+	__fixed_phy_add(0, status);
 }
 EXPORT_SYMBOL_GPL(fixed_phy_add);
 
@@ -179,7 +176,7 @@ struct phy_device *fixed_phy_register(const struct fixed_phy_status *status,
 	if (phy_addr < 0)
 		return ERR_PTR(phy_addr);
 
-	ret = __fixed_phy_add(PHY_POLL, phy_addr, status);
+	ret = __fixed_phy_add(phy_addr, status);
 	if (ret < 0) {
 		ida_free(&phy_fixed_ida, phy_addr);
 		return ERR_PTR(ret);
-- 
2.51.0



