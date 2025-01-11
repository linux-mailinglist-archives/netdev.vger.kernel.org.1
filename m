Return-Path: <netdev+bounces-157398-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 2717DA0A261
	for <lists+netdev@lfdr.de>; Sat, 11 Jan 2025 10:44:36 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id B92A07A2D90
	for <lists+netdev@lfdr.de>; Sat, 11 Jan 2025 09:44:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B6B8A186E2F;
	Sat, 11 Jan 2025 09:44:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="d9qJOSI7"
X-Original-To: netdev@vger.kernel.org
Received: from mail-ej1-f46.google.com (mail-ej1-f46.google.com [209.85.218.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0D9FC1632DF
	for <netdev@vger.kernel.org>; Sat, 11 Jan 2025 09:44:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736588669; cv=none; b=mvH0aXbrrPvJ0PkFPhQsGA5nnAGjW9iA01wtaX6L5eTppSRIHNGqOT5EAmPV80WRZmesCV5BpdVgsJVI/xSI7TvzhIluRucD0wpL2CqMCYXUxnI5/pCWH/Z1ZiuKjvwJZXl5dBt0Scgd4HQQ0CDvNFWBEqywCrnwb7ij8lWQrEw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736588669; c=relaxed/simple;
	bh=Thf+XMgjNdUsavEtQJYBBdNuzU4VMGwpV9YWOFjS5co=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=Me57F6lNt2lpiBbYiu3d8Z+o7CqT7NItxCQlGHZRSHTD8uCOrY1RewZDnoC1eBOV75GN8JPxZtFTqIZv2m4KCJRHBeM8EyJIeMzjPYHmlI7YhNom1GzYeiOS2UxekxHQciH/uQ8XnKwvQikSCs4dRYM+PAEPN9A6MnMiW3TgeUo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=d9qJOSI7; arc=none smtp.client-ip=209.85.218.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ej1-f46.google.com with SMTP id a640c23a62f3a-aa67333f7d2so432142566b.0
        for <netdev@vger.kernel.org>; Sat, 11 Jan 2025 01:44:27 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1736588666; x=1737193466; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:autocrypt:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=bgoIuCCwBGJeeTbtYs4Pu/RTiCEZwfJuuBmtOOIet+g=;
        b=d9qJOSI72bk7ExWgmfCSEqqa/6iVe4Bewwkd4SR84vY0ytlUMyE5L+0xF7HOllt8cN
         mQgxHW9u3pyi9+ygBU+q7ldlk7ytP8jqa5Rj0bE1L/sALrhEvvTvIQMwKG+ZUr/2KoIl
         rDoVi1rJIvJS6iXVbqAf9mSsjkjyK+z8cPVc4/Xw3b3bjyt4atjF0JH9p5tGf+EnLuYr
         HpWhSnug/05qadMMDE2aqNKREboiwF5tuAkHPj15CBe7Kd6RWechIKb5e2/6WlnQADfi
         4ZyNAY//cSu66cTsE02iE8SksX8mLHlIiPljAKEu+QDuWnb+vo6MglEFipSZ8Tm3WE3J
         AuUA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1736588666; x=1737193466;
        h=content-transfer-encoding:in-reply-to:autocrypt:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=bgoIuCCwBGJeeTbtYs4Pu/RTiCEZwfJuuBmtOOIet+g=;
        b=Jj6UCFX+LIrBso19IFPlHH9wYLHckXcGmWPDAqjqGZv1RMZGpHg12yNf4baq51mL84
         1GVMl/ZGIASAMoLf9Zd3jnfevJUFJLtIdZ84GvWjg8GXZmdAqdG7W3SNfU/aGbg37HrS
         U299D8iPLNR+fqY6h9LYAS9o2hofwgPt/ERbWAiAyZk5yFtu3+t5vjKn0RfIFYtYKXWC
         kDeFGrHPSUdjVTX0Q8DqEfrVhPs+20GtDVzgeXGMH0JmK1MaJRIbLp1S1zcbGdthkqYK
         Fg9evfxCNKJkDl04TQPvzYRTc09ycMkvTX0tdIJvNYczi814vska/eKOHFmfVx3MW9EV
         tyxA==
X-Forwarded-Encrypted: i=1; AJvYcCUXYByAkHY6XV4IuFCzLUjo/y4++Ocqugtt8GXmJqPV7TzvXGDiAlx1iujfAFNchjssLu+xwl0=@vger.kernel.org
X-Gm-Message-State: AOJu0YwnWXK5CafQXwF+KtL8izeuiD6bStcgcR+9QFxKaiE/oM4dlX7u
	t2Ah7ogBYY9WeMorHEH9Tjx6e7MeNiXCa58E1E+HrvhwRCeVzvB0
X-Gm-Gg: ASbGncv5doly6PT5xu/ma597qmv4GBrEAwdo08hCBp19LUa51gkKV8HTrVy2e7rYHuq
	17L1ZYxFAoeB8fKAJt7RzsNvDHXDhkkmE/3PuwGburjnmT8XWctaXuWjTUgCMyAwjFbn9Jkj2rD
	jINQ8GkPSIJrkrBzDb9PAo0sV7XYKR/u8uA2gxzX10oft5brp5HGJqIwAF6xW50E8MW31jE7s1q
	Pnzvq7bKz2BzkSybu/n9Hf/3C5O4f/F2kjYb6e6Ko8z7b95fMafBxjyXCRdZRz6L6m4OsJ0S4YH
	H7xlzcwiJAAYF44PzbRg5esbFX31uYMtLOcWTJ6pGY6dIMqxsRxb3UNNafLGca/tlrD1DhewS1k
	8JSkAuRd9FNTvLlEkD+aHDZiIL7gd3CeVazqYskv/HVk+qQij
X-Google-Smtp-Source: AGHT+IF6+1xv96W3AZCPKAnoho/1Lr57hSN4HqhByWirYj8RsQJoeiYbS+Dj7BQFkf1UmEC4Qa6J3w==
X-Received: by 2002:a17:907:6e9f:b0:aa5:1a1c:d0a2 with SMTP id a640c23a62f3a-ab2ab74b240mr1330467666b.34.1736588666269;
        Sat, 11 Jan 2025 01:44:26 -0800 (PST)
Received: from ?IPV6:2a02:3100:a90d:e100:d8f1:2ffc:4f48:89fd? (dynamic-2a02-3100-a90d-e100-d8f1-2ffc-4f48-89fd.310.pool.telefonica.de. [2a02:3100:a90d:e100:d8f1:2ffc:4f48:89fd])
        by smtp.googlemail.com with ESMTPSA id a640c23a62f3a-ab2c905e2f7sm254829566b.24.2025.01.11.01.44.24
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sat, 11 Jan 2025 01:44:24 -0800 (PST)
Message-ID: <472f6fe4-18ff-4124-ba43-fd757df7cb4d@gmail.com>
Date: Sat, 11 Jan 2025 10:44:25 +0100
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net-next 3/9] net: phy: c45: don't accept disabled EEE
 modes in genphy_c45_ethtool_set_eee
To: "Russell King (Oracle)" <linux@armlinux.org.uk>
Cc: Paolo Abeni <pabeni@redhat.com>, Jakub Kicinski <kuba@kernel.org>,
 David Miller <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>,
 Simon Horman <horms@kernel.org>, Andrew Lunn <andrew@lunn.ch>,
 "netdev@vger.kernel.org" <netdev@vger.kernel.org>
References: <a002914f-8dc7-4284-bc37-724909af9160@gmail.com>
 <5964fa47-2eff-4968-894c-0b7f487d820c@gmail.com>
 <Z4I4ADNO1nSdZRja@shell.armlinux.org.uk>
Content-Language: en-US
From: Heiner Kallweit <hkallweit1@gmail.com>
Autocrypt: addr=hkallweit1@gmail.com; keydata=
 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
In-Reply-To: <Z4I4ADNO1nSdZRja@shell.armlinux.org.uk>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 11.01.2025 10:21, Russell King (Oracle) wrote:
> On Sat, Jan 11, 2025 at 10:06:02AM +0100, Heiner Kallweit wrote:
>> Link modes in phydev->eee_disabled_modes are filtered out by
>> genphy_c45_write_eee_adv() and won't be advertised. Therefore
>> don't accept such modes from userspace.
> 
> Why do we need this? Surely if the MAC doesn't support modes, then they
> should be filtered out of phydev->supported_eee so that userspace knows
> that the mode is not supported by the network interface as a whole, just
> like we do for phydev->supported.
> 
> That would give us the checking here.
> 
Removing EEE modes to be disabled from supported_eee is problematic
because of how genphy_c45_write_eee_adv() works.

Let's say we have a 2.5Gbps PHY and want to disable EEE at 2.5Gbps. If we
remove 2.5Gbps from supported_eee, then the following check is false:
if (linkmode_intersects(phydev->supported_eee, PHY_EEE_CAP2_FEATURES))
What would result in the 2.5Gbps mode not getting disabled.



