Return-Path: <netdev+bounces-168657-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 5CBBBA4007A
	for <lists+netdev@lfdr.de>; Fri, 21 Feb 2025 21:11:27 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 377A742452E
	for <lists+netdev@lfdr.de>; Fri, 21 Feb 2025 20:11:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2459325333E;
	Fri, 21 Feb 2025 20:11:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="LUr2Q7a6"
X-Original-To: netdev@vger.kernel.org
Received: from mail-ed1-f42.google.com (mail-ed1-f42.google.com [209.85.208.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 58C2C2512D7;
	Fri, 21 Feb 2025 20:11:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740168684; cv=none; b=RDmF4JsWxO7ZaeBA2mcQPT21Sc+SmxKL/SZAGfKSn2xw7tnOYPfuVBrjTVm62vxYT2M33sjMH4Ka6j/GR1FZlyURCuCOpbd9bqP/ixKSC4tz/aMD1EXZZeu0kys6h+7zk8MqQkSIAcf7BT6Q+SXKeRQA71QjwlNMdVzTr2f8EQo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740168684; c=relaxed/simple;
	bh=L9Ovkk/RRrfQrsD0lsLa4ubovPWTOd9u2jMfCHwM6us=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=ILtYhU18eWZIb7+ppfLF5Wffr23bQpRhN2wMfXjD+rJHwRroW3rPSx5aDhWQQ2RMI+FpXkTXhwVNeni+Hc4KcBC/an8Uw/oZCm+YiC0aymn/6ghDevFzn7VFy6jRsL6xqu/sGh5Z/YeYChCp2ePWvWrzffgOSTZbWSUfb8cupKQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=LUr2Q7a6; arc=none smtp.client-ip=209.85.208.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ed1-f42.google.com with SMTP id 4fb4d7f45d1cf-5df07041c24so3660911a12.0;
        Fri, 21 Feb 2025 12:11:21 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1740168680; x=1740773480; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:autocrypt:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=f6QfXUMWQv5rataWRZ+L/ZQO7XWSTCyFXZSgM/69Zyw=;
        b=LUr2Q7a61imlfgueIlS/Lo88rJQZ18xCTCy7aN9IbdYtJfZ4P8utqSxU5lUnFn6L+B
         2HFPYEIVY0GIIaVEAUHB9yZMOZOARPNURO8JixYcfi6N1lOntxMOFZ7a61hDAQLeyWAS
         TviBWdFhs1+Uk72J+SCVjpP9qxpiriS0GlNX8DXUA1HGQNBcWdfR2FqIegmYsZtpYGLa
         +dMZADPaZ8FmfUwXoTvR/oT4lwJFB3pbzgf6PvicyYTCs/XN2KmNmE+Oe8KIo3D1Bc5T
         ADB2KZzmovpJOzTklp+F0+gK6qncvamcAfWb6s3YK86ZMcAVOqdiDUTdV1fudEQ8dxmT
         euVw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1740168680; x=1740773480;
        h=content-transfer-encoding:in-reply-to:autocrypt:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=f6QfXUMWQv5rataWRZ+L/ZQO7XWSTCyFXZSgM/69Zyw=;
        b=VcZ4ZrUHy9YA4hXwDsvbGy/NVjZlT+jLMIOX9TZp8ky3+dLrS5OWSmPAxZNTywWHgi
         i9fv63SsOU9oZRcAqqnzPBDyxVebgUizhH/GTzHi+nlREb2fpS4RGFILIiJuy9jWWbN/
         hLECs3IwEpSHvOJW2FIPB73SHdfMPOzhltkFNaeyCbFMkC0rOcjRC5byx3zcSWx0uIv9
         R6rTFzR78OTF61GP3RT+xGbAxIrcSm6RaVKjP5qQBvqwIhaT2xHVdAeNYfS9UaUILcEM
         HLF0Ec7n3sgQtynViXhjrv9DUNgs8nffuVfIQ+naFRzst+uizVI405TxGJS0bC3fZZN3
         c1+g==
X-Forwarded-Encrypted: i=1; AJvYcCVfjiwBbrxHzcKSdtNFKdZ1/HRur2XFirhZNUVf9R3by0N8QzYFvwTl7s0ihYO2XQawrrWTWN8K@vger.kernel.org, AJvYcCWFefAwiluOz7HetxfjLehb7hOYPtKSvNigDfC/2IricX/1YM5fHpNPThtcEo2niOG5yPHfq6lXU1r8vCM=@vger.kernel.org
X-Gm-Message-State: AOJu0YxyLKUpTKrfEpalcM2s2RbsK1qZxB8vlBVNOAc2UuZv3Tmxb5Mw
	1A4WtRffm8ER/4rFyQn9eVnowqM++gnJv4RY330jr3tHxaySZR4P
X-Gm-Gg: ASbGncvUV69m1q27gz141xnarfDcc6j1qjJFgU6t4k4Y+oUCReDY5FVLQLcg4I6+U+U
	WnNGNJg8R+RzPc+z/FULSpCxeyr9BqYqdypf9IdBDqbsRmrlAebPnun1lx2kywTJODwTfzaPjrt
	qKpNTSQbsUNTLqgnw+Y5LVTnXf95V/dP2mNdfss9rmmTAcO9MfrtKQ5pCjMejygN2UCuzYCazZo
	Le7nIuD64oi8vXynYD9rvDPya8715mqyrLRzQg1Jsr0KKtOVdpEZJEISe1+We1VmmFlFZA2Nlk5
	qjxQSLg5klFqQnLJj2nZE08KvZgIGGE4+Yec/clacGhCd2iDnzs1s/nFPWFT8zS06odnvdfloci
	ylJ9olmbIJ9rO85vD2Michdnghnt10F/BKozgGANK15uu44VgPuLETPsn9+Tr2ScfRycW5mQyjU
	WvKRp+2DT3CXK7
X-Google-Smtp-Source: AGHT+IFNFb+yB0DGuaN58oRk5ysUosLAVKbBemzvkkTtGpLbRvy0yEKVeaIQMhJlEq8RkVd+mesLkA==
X-Received: by 2002:a17:907:94c8:b0:aa6:6c46:7ca1 with SMTP id a640c23a62f3a-abc0d97e4eemr408476766b.10.1740168680088;
        Fri, 21 Feb 2025 12:11:20 -0800 (PST)
Received: from ?IPV6:2a02:3100:b29e:900:9dc2:647a:dfc:6311? (dynamic-2a02-3100-b29e-0900-9dc2-647a-0dfc-6311.310.pool.telefonica.de. [2a02:3100:b29e:900:9dc2:647a:dfc:6311])
        by smtp.googlemail.com with ESMTPSA id a640c23a62f3a-abbbe74100asm756317866b.95.2025.02.21.12.11.18
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 21 Feb 2025 12:11:19 -0800 (PST)
Message-ID: <eeba10a2-809a-4583-bd35-1f363c824e14@gmail.com>
Date: Fri, 21 Feb 2025 21:12:09 +0100
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net-next 3/3] r8169: disable RTL8126 ZRX-DC timeout
To: Bjorn Helgaas <helgaas@kernel.org>, ChunHao Lin <hau@realtek.com>
Cc: nic_swsd@realtek.com, andrew+netdev@lunn.ch, davem@davemloft.net,
 edumazet@google.com, kuba@kernel.org, pabeni@redhat.com,
 netdev@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20250221200132.GA357821@bhelgaas>
Content-Language: en-US
From: Heiner Kallweit <hkallweit1@gmail.com>
Autocrypt: addr=hkallweit1@gmail.com; keydata=
 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
In-Reply-To: <20250221200132.GA357821@bhelgaas>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 21.02.2025 21:01, Bjorn Helgaas wrote:
> On Fri, Feb 21, 2025 at 03:18:28PM +0800, ChunHao Lin wrote:
>> Disable it due to it dose not meet ZRX-DC specification. If it is enabled,
>> device will exit L1 substate every 100ms. Disable it for saving more power
>> in L1 substate.
> 
> s/dose/does/
> 
> Is ZRX-DC a PCIe spec?  A Google search suggests that it might not be
> completely Realtek-specific?
> 
ZRX-DC is the receiver DC impedance as specified in the PCIe Base Specification.
From what I've found after a quick search ASPM restrictions apply if this impedance
isn't in the range 40-60 ohm.

>> +static void rtl_disable_zrxdc_timeout(struct rtl8169_private *tp)
>> +{
>> +	struct pci_dev *pdev = tp->pci_dev;
>> +	u8 val;
>> +
>> +	if (pdev->cfg_size > 0x0890 &&
>> +	    pci_read_config_byte(pdev, 0x0890, &val) == PCIBIOS_SUCCESSFUL &&
>> +	    pci_write_config_byte(pdev, 0x0890, val & ~BIT(0)) == PCIBIOS_SUCCESSFUL)
> 
> Is this a standard PCIe extended capability?  If so, it would be nice
> to search for it with pci_find_ext_capability() and use standard
> #defines.
> 
> Bjorn


