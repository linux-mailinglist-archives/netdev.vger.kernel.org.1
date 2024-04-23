Return-Path: <netdev+bounces-90350-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 1EB698ADD3E
	for <lists+netdev@lfdr.de>; Tue, 23 Apr 2024 07:54:58 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id A3E77B22D28
	for <lists+netdev@lfdr.de>; Tue, 23 Apr 2024 05:54:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 26F3B208A5;
	Tue, 23 Apr 2024 05:54:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="YLnzVsCa"
X-Original-To: netdev@vger.kernel.org
Received: from mail-ej1-f54.google.com (mail-ej1-f54.google.com [209.85.218.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8120222EF2
	for <netdev@vger.kernel.org>; Tue, 23 Apr 2024 05:54:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713851687; cv=none; b=l7w4sekYHVL+QelZ6M7uEuuSyXdhuCBhTff3H2cdXOCj6hHr7XJftLNoiwmIKXuuXQ1JpmSng5/BIhbmk7qJApuH2zCINLl0niRgC0JSjozJRnBvbQBFJk+jqn9X20fRZCFnq3GGE7Go8OTse155l9dE5jkPpOh5du/+ERGhc+U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713851687; c=relaxed/simple;
	bh=p9PnohezCiZzgLS5kUwUsGBE2QZeJhwfGQwzG54TAdc=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=i23KG4qqcAntDyU/P/nlNTjvZVuE8xIk7KqWRTWjcUSVgGYwuFLkzkjBz77ltC9/Te0aOfCDSEIbx5h0bpmQtkMxUNQeiNNQZHsq5gYMBgdzt4wM8MrzmaKD5xVTTP1U6a0WGJnkq6yEkUw3+/in7+oH6GJ7gvqSYID9CsOoj5o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=YLnzVsCa; arc=none smtp.client-ip=209.85.218.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ej1-f54.google.com with SMTP id a640c23a62f3a-a5224dfa9adso887581666b.0
        for <netdev@vger.kernel.org>; Mon, 22 Apr 2024 22:54:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1713851684; x=1714456484; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=wGQ1vCbAzlTHObPt+9mNk8fzJsN8eRc3YIQMb9wAdMQ=;
        b=YLnzVsCaA6zn3kXe3YCDFaXcLuuslw0mWTk9OM+ckTQoChF5AAofgyAdNZjE1Ed3Q2
         M16JNXvexe2kWBP8zCXMrj2tCJWkvqs/2CC+q+xipn/ldTquWzyhsB8XcUHUERLKMfwT
         fPSHIkppQAQ71FQv0LGyutWI7RllkH6irnjMSWvrhSWLHbx/EDHjwAwz58tulxoo3ZSd
         BZlIWH4gzNUZGqvX7a8hgwNLk3E0QHX35KjyrnJb4TF9oTDmWPvEi5ncuxUsNnJ2Au4Y
         03D7KL7gd7vokwDNfbdGeA628VpLYC1y0WFxLocKBe3CSw5nrZ1wX+nj5/2q0qvbkakq
         qK6Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1713851684; x=1714456484;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=wGQ1vCbAzlTHObPt+9mNk8fzJsN8eRc3YIQMb9wAdMQ=;
        b=lvBEvbmWFLpQsNagG2C/po7y9XHt0jvoRrD8+vTaaAgkpWyX/hbGDffrEaRurdKMEv
         Eyx7ry0lwx1cXHNkmr1FMi0bWpBoc7SvQ/9nacdVbdNHiM7Rf5SI24Z6UcBqx6j/GCYk
         PtFq9izWO7Q+BWuxJUhHhfypuHex8PCCFdtsdktkISH8nQ3uh8IR82xlVdAUooY2Mivk
         pD/A8lt/Y2497LfJKHwgKdp4ykWfUw6xLDgsvaYbcia4cSoc0bHo4vs/JNugbMmpalWj
         zUR7non+5rf1+85WE0igivHlvnt+HNlFm3bxsn/sssnBIXf5uM+Zbt9lsOdG7t4s1Dw8
         hyXw==
X-Forwarded-Encrypted: i=1; AJvYcCVzWr48qT27oIRZ7NH6HwOHNpKFtKzllsAUxR2KYpNwQcU3fNYvE7+qWgGS/UdMSeXVHsTx+J/y0S0aWmP6UNObr5lvq0uQ
X-Gm-Message-State: AOJu0YyN2yVoHB0uvpjHhXqinHunGyku1V+ceymMokHr4Hmi322/Vnkp
	cvhgDOL4s0jy+CCyl0EUK0IDSdL+gkI+aYcN5GiCPipGtn+yrVmy
X-Google-Smtp-Source: AGHT+IG5pg3wPqgObvwkhJPKMQLyrQh7GRTTZYONmtYRhptrtH7dVrUruh8kjFpe1nRLNAfGMVexlw==
X-Received: by 2002:a17:906:e5b:b0:a58:7aaa:2e4d with SMTP id q27-20020a1709060e5b00b00a587aaa2e4dmr1258492eji.12.1713851683459;
        Mon, 22 Apr 2024 22:54:43 -0700 (PDT)
Received: from ?IPV6:2001:1c00:20d:1300:1b1c:4449:176a:89ea? (2001-1c00-020d-1300-1b1c-4449-176a-89ea.cable.dynamic.v6.ziggo.nl. [2001:1c00:20d:1300:1b1c:4449:176a:89ea])
        by smtp.gmail.com with ESMTPSA id x20-20020a1709060a5400b00a524b2ffed6sm6600404ejf.56.2024.04.22.22.54.42
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 22 Apr 2024 22:54:42 -0700 (PDT)
Message-ID: <ea9924d3-639b-4332-b870-a9ab2caab11c@gmail.com>
Date: Tue, 23 Apr 2024 07:54:39 +0200
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net-next 2/2] net: sfp: enhance quirk for Fibrestore 2.5G
 copper SFP module
To: =?UTF-8?Q?Marek_Beh=C3=BAn?= <kabel@kernel.org>, netdev@vger.kernel.org,
 Russell King <rmk+kernel@armlinux.org.uk>,
 Raju Lakkaraju <Raju.Lakkaraju@microchip.com>,
 Frank Wunderlich <frank-w@public-files.de>,
 Simon Horman <simon.horman@corigine.com>
Cc: Andrew Lunn <andrew@lunn.ch>, Heiner Kallweit <hkallweit1@gmail.com>
References: <20240422094435.25913-1-kabel@kernel.org>
 <20240422094435.25913-2-kabel@kernel.org>
Content-Language: en-US
From: Eric Woudstra <ericwouds@gmail.com>
In-Reply-To: <20240422094435.25913-2-kabel@kernel.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit



On 4/22/24 11:44, Marek Behún wrote:

> Frank, Russell, do you still have access to OEM SFP-2.5G-T module?
> It could make sense to try this quirk also for those modeuls, instead
> of the current sfp_quirk_oem_2_5

It was part of the previous patch-set until and including v2:
"rtl8221b/8251b add C45 instances and SerDes switching"

Note that it does:
	sfp->id.base.extended_cc = SFF8024_ECC_2_5GBASE_T;
As the OEM modules have not set this byte. We need it, so that we know
that the sfp_may_have_phy().

After v2 I have dropped it, as it would break functioning some sfp-modules.

As OEM vendors know the eeprom password of the Rollball sfp modules,
they use it in any way they want, not taking in to account that mainline
kernel uses it for unique identification.

Vendor 1 sells "OEM", "SFP-2.5G-T" with a rtl8221b on it.
Vendor 2 sells "OEM", "SFP-2.5G-T" with a yt8821 on it.

So on the OEM modules, we cannot rely solely on the two strings anymore.

Introducing the patch, would break the modules with the yt8821 on it. It
does not have any support in mainline.

Also any code I found for the yt8821 is C22 only. And even more, even
though we are facing with an almost similar MCU, RollBall protocol does
not work. I think it is almost the same mcu, as it responds to the same
eeprom password, and also the rollball password does something, but not
give the expected result.

So you for the OEM module it would have been:

+// For 2.5GBASE-T short-reach modules
+static void sfp_fixup_oem_2_5gbaset(struct sfp *sfp)
+{
+	sfp_fixup_rollball(sfp);
+	sfp->id.base.extended_cc = SFF8024_ECC_2_5GBASE_T;
+}
+

-	SFP_QUIRK_M("OEM", "SFP-2.5G-T", sfp_quirk_oem_2_5g),
+	SFP_QUIRK_F("OEM", "SFP-2.5G-T", sfp_fixup_oem_2_5gbaset),

