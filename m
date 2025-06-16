Return-Path: <netdev+bounces-198276-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 726ADADBBEE
	for <lists+netdev@lfdr.de>; Mon, 16 Jun 2025 23:28:31 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 490CD7A188F
	for <lists+netdev@lfdr.de>; Mon, 16 Jun 2025 21:27:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A73DE21882F;
	Mon, 16 Jun 2025 21:28:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="b4v4kq3J"
X-Original-To: netdev@vger.kernel.org
Received: from mail-wm1-f48.google.com (mail-wm1-f48.google.com [209.85.128.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C861F1F099C
	for <netdev@vger.kernel.org>; Mon, 16 Jun 2025 21:28:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750109305; cv=none; b=kUs6jhkTKupnukGDsZ3n79bjxOYK+u/TotCXkW2QyXQfrXVuoiyWrfs3GTlvA9+fNqfPr/xT++SR/h7fwzXgJU8uR41QCmKR/zIxYd6iyHLeh9m+doBFF7FhXXplp4Gcd36SjPdZz3mTuhDFZDy1/OMfMHpHKtuetFQ/CzoFYcU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750109305; c=relaxed/simple;
	bh=B81RvMnziV4dcH+AleQaurh906E6nPB/a2o0DOAGk7s=;
	h=Message-ID:Date:MIME-Version:Subject:From:To:Cc:References:
	 In-Reply-To:Content-Type; b=XHgLCzcdi1PQowdvsKn65M87kRf17vW1Yfesb+idQeAdZU1+Me3SAB+V70jAZIdI0ifJLQdnZftJ0Asf5VF1sSvODBjjfvXR2KCfiPMaz4Va3SeLb5AVjRJoe4FYD+N97GYFdmF+sjOZ8RMWqNveqMFiqlufDpMUXWhDLjJOzuE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=b4v4kq3J; arc=none smtp.client-ip=209.85.128.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f48.google.com with SMTP id 5b1f17b1804b1-442e9c00bf4so42558475e9.3
        for <netdev@vger.kernel.org>; Mon, 16 Jun 2025 14:28:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1750109302; x=1750714102; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:autocrypt:content-language
         :references:cc:to:from:subject:user-agent:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=5XXAcOCB01OUObGgFW/V5O9cvQLuVzPmF47hEyzxgoE=;
        b=b4v4kq3JktoutVnf6d4ldmo35bHiXFQId6zABctXlh+ZPV86NFxejgUROiTNeGnGNX
         Yc8nkC2/DnL+KywUPARSzjJyGIbMId1JJbodZDiJFExjq5CXAC81GI3niuXuMunZqoyl
         qbo7h2uzPhRSh9n8z2bY3p8Vc3crrKOVM+rKe1I8rkQc+VpaQynLHMlY0jHSCE7CvYX5
         73I4ES521MW1NGrZi5d8k81cDVnswHatettY/CKlWp0kNLsYTy4mwNE5lt4z+DyZT932
         blP3TgvprFKFMPfjDVpMNHo4MWzo7+guDCMLKfM/d4AlCVokj9SFhpROqYkYoB+0MFBc
         gElA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1750109302; x=1750714102;
        h=content-transfer-encoding:in-reply-to:autocrypt:content-language
         :references:cc:to:from:subject:user-agent:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=5XXAcOCB01OUObGgFW/V5O9cvQLuVzPmF47hEyzxgoE=;
        b=c/jhz82w/p8Rk/N8oY81UdwDzzMUI3ephsbnN2Bexj2N5bR+4RmD53DkeSK0UgVt6/
         vWMMEvUK/G2zVgWyEbTafNEAczPKkB4oUQJVH3miI7W/eQm663g+HZapvLVLM/Kw6acx
         6+NPuXMhXpJ/T/HxLjJ1p7xxy1i0/MNIYAyjP3W1eqgKowzt4edfYDNfkg8ItRZo6iay
         oRQ1Vjmaj4aiGohV4lp2GpJtt3VuPqCYbma1GgOeJR5aiWwWMZo3WkMJV3vp51zdBHLt
         3C3fWBBvk35HuQVnW7LgCeZVXG4Q6ArcgRmtu0Vlhq5jXChe3709gGXcvdwMLA7Na+y7
         OcqA==
X-Gm-Message-State: AOJu0Yy6PWc9D+VeU9q0w6FK+MNj8dBU0Gvvi8eHMQDoJc/LP3QrPDOF
	v5aEkTtOsUkL7CCFlOTbIPZeFJm2MOPRYLDLZFFx6zkWv+ELu5A70j58+vfO6vnI
X-Gm-Gg: ASbGncsaOP3ECyTALLqdvJCezgiaWd7JfGuyjqToIGJz+jBEAEwSvWQBhZsHZvQ9iGv
	1A3earylsO4Ll+29irXGJ43JTLvJUqALgSXTV6fEzLdQ/3CIygeGmuiJagvUfvwVvfalI+O5RWs
	N9EyVKq2wapqqwX4yYFpjuW1gK77rz36AFr3G0whS3Xgka2p8zTqxLqqpTYpTNnlyp5AE35oybV
	k8jPLPwPdKJJfShy+cOiI7se/QfdyM5SzGwqy1OVqcUieyuOLKcGypOsZ+F9NIcZbA8bZvUpjIQ
	s8S5EtIuno78bDxJbeQ8FPcTze5leN/uzD4yaXB9pFuJAslLfYkTMPaLvkdGjNRWUpo6r+jak57
	YFKka0DlIZdi0G6E1+bsR9g90f9iKIpEsmegk9rZP5nQxgOlh2YZGzgU1508+Y7Ymwpq1xL5jw0
	Ev1j0OEn7uDiqSCUFOeIPXHNU=
X-Google-Smtp-Source: AGHT+IFgaIA0648XCawbMM/Uje0CDxIrVV0P16AKdzOA8bg46jzUDvdrSfo3k7CBlYAUfPlYQKhfhw==
X-Received: by 2002:a05:600c:6087:b0:442:e9eb:1b48 with SMTP id 5b1f17b1804b1-4533caed5b0mr102543285e9.24.1750109301788;
        Mon, 16 Jun 2025 14:28:21 -0700 (PDT)
Received: from ?IPV6:2003:ea:8f4e:1600:59de:3cc:3fa9:3c6b? (p200300ea8f4e160059de03cc3fa93c6b.dip0.t-ipconnect.de. [2003:ea:8f4e:1600:59de:3cc:3fa9:3c6b])
        by smtp.googlemail.com with ESMTPSA id ffacd0b85a97d-3a579808c24sm7353361f8f.43.2025.06.16.14.28.21
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 16 Jun 2025 14:28:21 -0700 (PDT)
Message-ID: <da7f896f-2636-40c1-a8ab-bf4e55b6d726@gmail.com>
Date: Mon, 16 Jun 2025 23:28:36 +0200
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net] net: ftgmac100: select FIXED_PHY
From: Heiner Kallweit <hkallweit1@gmail.com>
To: Andrew Lunn <andrew+netdev@lunn.ch>, Paolo Abeni <pabeni@redhat.com>,
 Jakub Kicinski <kuba@kernel.org>, David Miller <davem@davemloft.net>,
 Eric Dumazet <edumazet@google.com>, Simon Horman <horms@kernel.org>
Cc: "netdev@vger.kernel.org" <netdev@vger.kernel.org>
References: <077a3b63-60a6-4c99-98fe-46252f102a71@gmail.com>
Content-Language: en-US
Autocrypt: addr=hkallweit1@gmail.com; keydata=
 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
In-Reply-To: <077a3b63-60a6-4c99-98fe-46252f102a71@gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 16.06.2025 22:27, Heiner Kallweit wrote:
> Depending on e.g. DT configuration this driver uses a fixed link.
> So we shouldn't rely on the user to enable FIXED_PHY, select it in
> Kconfig instead. We may end up with a non-functional driver otherwise.
> 
> Fixes: 38561ded50d0 ("net: ftgmac100: support fixed link")
> Cc: stable@vger.kernel.org
> Signed-off-by: Heiner Kallweit <hkallweit1@gmail.com>
> ---
>  drivers/net/ethernet/faraday/Kconfig | 1 +
>  1 file changed, 1 insertion(+)
> 
> diff --git a/drivers/net/ethernet/faraday/Kconfig b/drivers/net/ethernet/faraday/Kconfig
> index c699bd6bc..474073c7f 100644
> --- a/drivers/net/ethernet/faraday/Kconfig
> +++ b/drivers/net/ethernet/faraday/Kconfig
> @@ -31,6 +31,7 @@ config FTGMAC100
>  	depends on ARM || COMPILE_TEST
>  	depends on !64BIT || BROKEN
>  	select PHYLIB
> +	select FIXED_PHY
>  	select MDIO_ASPEED if MACH_ASPEED_G6
>  	select CRC32
>  	help

Two blamed authors missing, will resubmit.
---
pw-bot: cr

