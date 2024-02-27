Return-Path: <netdev+bounces-75315-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id BCCA1869265
	for <lists+netdev@lfdr.de>; Tue, 27 Feb 2024 14:34:48 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 73FC0293EAD
	for <lists+netdev@lfdr.de>; Tue, 27 Feb 2024 13:34:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 248D813AA4F;
	Tue, 27 Feb 2024 13:34:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="lvHptac7"
X-Original-To: netdev@vger.kernel.org
Received: from mail-ej1-f42.google.com (mail-ej1-f42.google.com [209.85.218.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 76A962F2D
	for <netdev@vger.kernel.org>; Tue, 27 Feb 2024 13:34:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709040886; cv=none; b=TTK7AMuvHozMGwmlGu1Kb3tOSqW5vBXigII9MVpt0eIJuHGIurWZWKuqc1b01LtQ/QQuL8YsKm0vo0oUyrus0c3S+EACpNf4RfXOsiiuSi3loaVF0JuiC4NL8Rt8kGPVa8oQqr3QqLcqNkZvgONi9z0lAZwyKrQg8Vs4mtLbXMk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709040886; c=relaxed/simple;
	bh=ZAjXdks9113DusT5ekpiAeAXNKtS1pWrR9V0kfeCESM=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=haB2VF8bAja1oPQFSJpiKnUI7TmaBhklhEDbO630Ef2ouPIPknFVZOnDwG99BQ/IuJ+fhs7uOaLZSfkSoubAjNpXF2WxlmuLxyjhpfBt9D0G3Svr2p/4Il8RNYuTMhsjYqH4v90bxUJ9YP7uWaFX3gsX7P7ryz+H9ejE6Gxyirs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=lvHptac7; arc=none smtp.client-ip=209.85.218.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ej1-f42.google.com with SMTP id a640c23a62f3a-a3f4464c48dso510342266b.3
        for <netdev@vger.kernel.org>; Tue, 27 Feb 2024 05:34:44 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1709040883; x=1709645683; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=J3Fmfeg1gzNeWqfJg7xKm9i74YoNOfkD0J3GL1IucnA=;
        b=lvHptac794dAMGqDeismdz1wIW3ffXYfCIPA24Vgm0PlmKjjh6ve9/gyzlAr10fStc
         PbZbg6ug5ZhgAYlP0ORvSGCdmV+qmBqVpOGorJq9OzbSIRaVP3NhIo4Ab+5uBsH1BE74
         0qBe6pWLU4PDplJDT/8tugSiFjk81gTfaf1504Xoqkg+PKg4nKlpxEPk9LYP0ZgBBt0C
         /39lnWqeoGk4qYPHuWUGWZj6bpz2TRsaHtzxySlQOg9LmZu21/fBChxHxfS0/2LigjS9
         O2c5YD3UgPc/CZZOdXIpPtWQXh3fl8351gnvVk7wcGqyM2dzg8+KNBsB7z45EVSPY9EH
         lVVg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1709040883; x=1709645683;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=J3Fmfeg1gzNeWqfJg7xKm9i74YoNOfkD0J3GL1IucnA=;
        b=SV2TUeQpNNlCSIb509mRh/SpZOjtC9W3KLOwSomtieL1Xjn9q3rd2YpxgV1Pcz0zrO
         eFmBbEYCNHay2VJOsPMp3NzpowkUEfsED5YZeEkjJyoduAmn8XQsUeHMt8ELFRm6t4vg
         7zy0rxKT726Gg0m8EcT0NqBtbab7+G2amOb0XmkzUggtxRG3jsfJMi6g5ptMLLuqULDI
         J7/HMIP4eMqdW1ksBBQ6x4hgGx/5gVrkD9MnaeeIunogswVrUl3lcYDebV1QlJ2TUFjc
         rYpj8xINhPTNM3ljavbUfEyD3aIlANIvO3MeZ/IhikUW3TOz5VRdPPxuyymS4FViTiua
         K9vA==
X-Forwarded-Encrypted: i=1; AJvYcCXsBh3P9ozHeWTxDIPD5DBnBQlZoNXS98efew6zgELXCdV25YZOW8LIlOteAW4F1eYMoGoGgiY3N/z48T0ePsqrBvkNa6pR
X-Gm-Message-State: AOJu0YwpM4HRi+tNLqmp1vzKRuGr/iX/YoBQLAK8pjW11zWX8XkBSyq8
	ZaRwJ9VeGSFYNopNOBDzzEIUlGnoJ1h6/KMPtlwjbscmHlgmwUTK
X-Google-Smtp-Source: AGHT+IFE0kVYfXgISigePzV3otRxhJcATGDijH20ri+mmK9r70R+ch1MHcOWr7LRERJa29YHT2hvYg==
X-Received: by 2002:a17:906:a046:b0:a43:35f1:944e with SMTP id bg6-20020a170906a04600b00a4335f1944emr5159681ejb.22.1709040882649;
        Tue, 27 Feb 2024 05:34:42 -0800 (PST)
Received: from ?IPV6:2001:1c00:20d:1300:1b1c:4449:176a:89ea? (2001-1c00-020d-1300-1b1c-4449-176a-89ea.cable.dynamic.v6.ziggo.nl. [2001:1c00:20d:1300:1b1c:4449:176a:89ea])
        by smtp.gmail.com with ESMTPSA id a19-20020a170906469300b00a431fca6a2esm783168ejr.37.2024.02.27.05.34.41
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 27 Feb 2024 05:34:42 -0800 (PST)
Message-ID: <84fbce22-1c83-41c7-b934-8163bc1b8584@gmail.com>
Date: Tue, 27 Feb 2024 14:34:41 +0100
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH RFC net-next 1/6] net: phy: realtek: configure SerDes mode
 for rtl822x/8251b PHYs
To: "Russell King (Oracle)" <linux@armlinux.org.uk>
Cc: Andrew Lunn <andrew@lunn.ch>, Heiner Kallweit <hkallweit1@gmail.com>,
 "David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>,
 Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
 =?UTF-8?Q?Marek_Beh=C3=BAn?= <kabel@kernel.org>,
 Frank Wunderlich <frank-w@public-files.de>,
 Daniel Golle <daniel@makrotopia.org>, netdev@vger.kernel.org,
 Alexander Couzens <lynxis@fe80.eu>
References: <20240227075151.793496-1-ericwouds@gmail.com>
 <20240227075151.793496-2-ericwouds@gmail.com>
 <Zd27FaFlVqaQVV9B@shell.armlinux.org.uk>
Content-Language: en-US
From: Eric Woudstra <ericwouds@gmail.com>
In-Reply-To: <Zd27FaFlVqaQVV9B@shell.armlinux.org.uk>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit



On 2/27/24 11:36, Russell King (Oracle) wrote:

> It would be nice to fill phydev->possible_interfaces even if
> phydev->host_interfaces has not been populated. That means that the
> "newer" paths in phylink can be always used during validation.
> 
> In other words, move the if() test just above this to below it.
> 

I will change it accordingly.

>> +	ret = phy_write_mmd(phydev, MDIO_MMD_VEND1, 0x75f3, 0);
>> +	if (ret < 0)
>> +		return ret;
> 
> It would be nice to know what this is doing.
>> +
>> +	ret = phy_modify_mmd_changed(phydev, MDIO_MMD_VEND1,
>> +				     RTL822X_VND1_SERDES_OPTION,
>> +				     RTL822X_VND1_SERDES_OPTION_MODE_MASK,
>> +				     mode);
>> +	if (ret < 0)
>> +		return ret;
>> +
>> +	/* the following 3 writes into SerDes control are needed for 2500base-x
>> +	 * mode to work properly
>> +	 */
>> +	ret = phy_write_mmd(phydev, MDIO_MMD_VEND1, 0x6a04, 0x0503);
>> +	if (ret < 0)
>> +		return ret;
>> +
>> +	ret = phy_write_mmd(phydev, MDIO_MMD_VEND1, 0x6f10, 0xd455);
>> +	if (ret < 0)
>> +		return ret;
>> +
>> +	return phy_write_mmd(phydev, MDIO_MMD_VEND1, 0x6f11, 0x8020);
> 
> Also for these. "to work properly" is too vague - is it to do with the
> inband signalling?
> 
> 
> Just to confirm that this doesn't change existing device behaviour?

This is a magic sequence all needed to change serdes-option-mode and only
that. This patch (series) does not change inband negotiation behavior of
the phy (there is another sequence of magic numbers to disable it).

I will change the comment to describe it better.

Regards,

Eric

