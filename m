Return-Path: <netdev+bounces-157392-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 4C9ADA0A223
	for <lists+netdev@lfdr.de>; Sat, 11 Jan 2025 10:07:51 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 494113A5A10
	for <lists+netdev@lfdr.de>; Sat, 11 Jan 2025 09:07:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DE95F185B4C;
	Sat, 11 Jan 2025 09:07:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="KG8d8pZA"
X-Original-To: netdev@vger.kernel.org
Received: from mail-ed1-f43.google.com (mail-ed1-f43.google.com [209.85.208.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4BAD282899
	for <netdev@vger.kernel.org>; Sat, 11 Jan 2025 09:07:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736586467; cv=none; b=EAehYYkmU5qrIGZnDdNaUdP/buPfhyilKucKBntEXyXzpdteyQe/DdYlQMmciAQUSli5K5DtyQQpOpuTbeTQcSGoGerNEuK8f5lo/+5ufAd5UE8V9uKeDTWmVFWhQ4TvS8POpqAZElsJWs85v+f7OqL5nBaBgsGrEoDrb6wmAS4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736586467; c=relaxed/simple;
	bh=dMnqu2NFxklOsSsinY1qryXx9RuGGQCtBaDejSngLQE=;
	h=Message-ID:Date:MIME-Version:Subject:From:To:Cc:References:
	 In-Reply-To:Content-Type; b=HoTJ3EdLeE6lETYAuaQqbOc/jR+78IdkOLb6zJX7OdsTGpiWubWLc4xq/85oH2fQk26X+oOAWh8nFCrUz26f/Gv48d73gdE3rtG8ICmcWS8Qe1JuehqEt98U8ackwhGuAvT8aV9kFhTZbPS6lUahCfKDMZLnDx8H/+ngBgIcp+o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=KG8d8pZA; arc=none smtp.client-ip=209.85.208.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ed1-f43.google.com with SMTP id 4fb4d7f45d1cf-5d3f65844deso4386729a12.0
        for <netdev@vger.kernel.org>; Sat, 11 Jan 2025 01:07:46 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1736586465; x=1737191265; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:autocrypt:content-language
         :references:cc:to:from:subject:user-agent:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=wBMddhpX1NI1gq7cSA9OWBGZGHoa2QsJ/OhZHRlrOog=;
        b=KG8d8pZASpf8zkmxd4noN5cJGY+An97/fK/XIrhD1MMKDFIXQt/mXwXpq9ZNK6lz69
         mMGLamUwrHyRJ+3r0MeN2C3iiQ3DFo3Ci0wEA7NgHzHVABnag554SQc6cCYHbjdPXcke
         q1VB/Og2S2ecLZYyVc2sUap9KdqEaT9GTvxaDIPT3gwtH5BrYrUl2mAg4o3/YjEDNJ+S
         Of+kxpXlayngkm4CUr/dWA5pXU6lA+PAdOmk5zDtJpKkNFSGGUwMnrLfcEzznyRKuLBU
         agyBCOwnhnrNklZzdvQrL8xpgLtiwBCS40Ag3pbwPSfdfvyTwjIK7/mCNZO+pvxEIGWs
         JSyg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1736586465; x=1737191265;
        h=content-transfer-encoding:in-reply-to:autocrypt:content-language
         :references:cc:to:from:subject:user-agent:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=wBMddhpX1NI1gq7cSA9OWBGZGHoa2QsJ/OhZHRlrOog=;
        b=ixwon54mn0RcPDS8HDreJyDsdolSCB6uvKAW2kR/mkMCs5xy2X8A/eGRP5v8eToqcS
         cRvVbth/OM5K2JtKI+a2e+rgWGhc+r0i7t54zap11SckfYc35QIHLNq9NR6044CT0M11
         CHN8BNAuwU8qzWt651wuwhJ8OjD6EBW8jWE7gIowZiKBOY12XVOJA3U62C4e0ze71/dk
         dliAjDNYXDDOPXUTQ0fXqXFOhpC2FF8IhV6AppNQK9MNg3hvM1XqCgobIDOW/jhrirbi
         i+4YqeEENm57o3/cqn4MfyXm2DI3OBOgJLoMpLCVpfh9Y0yDFm/pxFESTMpE+Z85phJ7
         dvYg==
X-Gm-Message-State: AOJu0Yz4NrztY4KQAmS6rN6WQkbu3Ngjt12Qc3jBsDg4KI/cNTi+9PYX
	yd4r+VKmatRZuYaI0lZypFkIGU+vovx0hJEtolJ0W0GK8XnoVGXq
X-Gm-Gg: ASbGncuYEVQV7AWSXVjZjyF/z26EeFZVOn3xeUxn2Gki/ryqNmAJk1GntipXbbUEU4C
	zftQc5QL3sIy2HAWm3LV7UC6I0dU5V6Aj/4qTBcOUKk7PZiZtO6oW6Y17GGoTUtSPS9gV4CrUcu
	/mz8fAptQzYH1SQ6isT1G3NIZn6DNmMDHKKFD1U4QeuIIuAG7mzGONgdUrdS49NnyYMegbKp6NH
	9cwikkhnTWQtXYnHa5aPNXdDbBsMp9eMM6xjPSUS7GLS8DAl0bRu5UCiaOCvjmEP1su7nVVBYt5
	5Vcru/uXfbXeboiHMDZHvDIBphBYKr1iQDS6jKToLXnWEXS6qNgMztVt8RDpYpizEib7MxVD62r
	dP1vvsMm//vL1aVgbR4PLqLCkLlA64fMxa4wNcTOkpfZLWr6F
X-Google-Smtp-Source: AGHT+IEnwOB9RjQvwIgT3m1N4dmZ606vHBelaQgvlF+dtjNsuak8yelPFUs6R41A7NVEdxABMrqmuw==
X-Received: by 2002:a05:6402:510d:b0:5d3:e45d:ba91 with SMTP id 4fb4d7f45d1cf-5d972e6e09fmr12793033a12.32.1736586464690;
        Sat, 11 Jan 2025 01:07:44 -0800 (PST)
Received: from ?IPV6:2a02:3100:a90d:e100:d8f1:2ffc:4f48:89fd? (dynamic-2a02-3100-a90d-e100-d8f1-2ffc-4f48-89fd.310.pool.telefonica.de. [2a02:3100:a90d:e100:d8f1:2ffc:4f48:89fd])
        by smtp.googlemail.com with ESMTPSA id 4fb4d7f45d1cf-5d99008c37csm2494648a12.6.2025.01.11.01.07.41
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sat, 11 Jan 2025 01:07:43 -0800 (PST)
Message-ID: <487d87a1-7268-4ef4-9bde-435e61c7495c@gmail.com>
Date: Sat, 11 Jan 2025 10:07:43 +0100
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: [PATCH net-next 5/9] net: phy: improve phy_disable_eee_mode
From: Heiner Kallweit <hkallweit1@gmail.com>
To: Paolo Abeni <pabeni@redhat.com>, Jakub Kicinski <kuba@kernel.org>,
 David Miller <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>,
 Simon Horman <horms@kernel.org>, Andrew Lunn <andrew@lunn.ch>,
 Russell King - ARM Linux <linux@armlinux.org.uk>
Cc: "netdev@vger.kernel.org" <netdev@vger.kernel.org>
References: <a002914f-8dc7-4284-bc37-724909af9160@gmail.com>
Content-Language: en-US
Autocrypt: addr=hkallweit1@gmail.com; keydata=
 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
In-Reply-To: <a002914f-8dc7-4284-bc37-724909af9160@gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

If a mode is to be disabled, remove it from advertising_eee.
Disabling EEE modes shall be done before calling phy_start(),
warn if that's not the case.

Signed-off-by: Heiner Kallweit <hkallweit1@gmail.com>
---
 include/linux/phy.h | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/include/linux/phy.h b/include/linux/phy.h
index ad71d3a3b..fce29aaa9 100644
--- a/include/linux/phy.h
+++ b/include/linux/phy.h
@@ -1333,7 +1333,10 @@ static inline bool phy_is_started(struct phy_device *phydev)
  */
 static inline void phy_disable_eee_mode(struct phy_device *phydev, u32 link_mode)
 {
+	WARN_ON(phy_is_started(phydev));
+
 	linkmode_set_bit(link_mode, phydev->eee_disabled_modes);
+	linkmode_clear_bit(link_mode, phydev->advertising_eee);
 }
 
 void phy_resolve_aneg_pause(struct phy_device *phydev);
-- 
2.47.1



