Return-Path: <netdev+bounces-136756-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 290F29A2FB9
	for <lists+netdev@lfdr.de>; Thu, 17 Oct 2024 23:22:30 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 42DDB1C20C24
	for <lists+netdev@lfdr.de>; Thu, 17 Oct 2024 21:22:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BC8C4136658;
	Thu, 17 Oct 2024 21:22:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="QYwYY+ZQ"
X-Original-To: netdev@vger.kernel.org
Received: from mail-ej1-f52.google.com (mail-ej1-f52.google.com [209.85.218.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0F19E33997
	for <netdev@vger.kernel.org>; Thu, 17 Oct 2024 21:22:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729200145; cv=none; b=FhKfGXk0GiJpNY2fjfLqKPtnBnOEK/81NEQwJFF61uVMaRsg3o4TrzpWrBdkxKsHtz3ctl/7mqjHdceLYq+DLKiX0Bz1XqfpQz1uqSt2814ZrCYetWNE/Y71JCGF4Amo6gRToLQ7nYpPtTETDkE+IGsf8X5tI4WIoqMTKVnMunA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729200145; c=relaxed/simple;
	bh=LH8hGGdtcY5fys3VDdBZxe3a3IY5kP5gu8Ksa2YFrxY=;
	h=Message-ID:Date:MIME-Version:Subject:From:To:Cc:References:
	 In-Reply-To:Content-Type; b=kicenVBJgt6Q5IhqAgJR1iV9tc84BpB1/QzKANN9YpQTaNZ9Sxgz5un7i63ZzeGnGyufRxeGmKBn813T9FhM61dOGFV9hSzgSxH0XvFJU+OUh9DmcrayAlp87FqbIZjCk7PLoyVORQ1PAXwvrUY7QBCBoLxY1e8/d3UTZS4JBZA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=QYwYY+ZQ; arc=none smtp.client-ip=209.85.218.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ej1-f52.google.com with SMTP id a640c23a62f3a-a9a5f555cfbso63101866b.1
        for <netdev@vger.kernel.org>; Thu, 17 Oct 2024 14:22:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1729200142; x=1729804942; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:autocrypt:content-language
         :references:cc:to:from:subject:user-agent:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=1+WqTFXNujL0mxtoNNobwAYxoxgDAT2b4F1rILcrPAU=;
        b=QYwYY+ZQAHWBx4nWvH2kzH7JfVk49Gd2w9y0erVDoeXOOaGf4WI7r3fdlqvDg6gRzD
         g/DjPm9oIKkXyOgUuAmt9hABoE21a7xa4E4gVSddYnB5/OqDreZySdSW/ZqJpeG/2kEa
         +dDNLVNbfuJPGhUQLDTQGw4NuwO9TibHv86oL+yulj+msEoYMfKxfzY3qRO8zbchEK1H
         7Bo0H9e8tUrF66Gs1otQGh1LoGq8qUwsNCm4GiJXVbyIBRqbirohhhMS4RO8e3XaM+Cx
         3Y54uvGE99DLs4jEKQp7BK204iIDHVpu4xN7SwOFWV8SIbcM+n0OLRORVLJtoc83N/Rq
         GzEQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1729200142; x=1729804942;
        h=content-transfer-encoding:in-reply-to:autocrypt:content-language
         :references:cc:to:from:subject:user-agent:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=1+WqTFXNujL0mxtoNNobwAYxoxgDAT2b4F1rILcrPAU=;
        b=oV9Kpa0QRpqkThG2nXnUNZUiZlbcsIgpc39ikUUQoJ8insDrPCNB1tbfon9lQU+sKj
         bMrZZfOKAT/XzOUmtRG1dYy8cuiS6FtHtImAz6e+KU6VS8/Q0cMoezOpKNIuaDp5RxHh
         u9PHo4b/3mZWhFZOSO38PEwIk/7qPhY65dLKMYO7RuTM4nfuvauJr1YNS5d6KkGNdnR3
         0tjbuPQABVuh8HToKU2xO8J2w6RVVSzdeODQxK3A9pu8xjof7hMLpYxtoeYbka7xRRti
         r0cZSJM9QKhWeL6O9OUQBDvnp8gvibVh6XOl3Ia7ITNkkVXNyyPi59M50PTEfFj5u7Jy
         FPGQ==
X-Forwarded-Encrypted: i=1; AJvYcCWEW8JBl+wvMG5fvqj4jM9Zs3caQKdPbYvR7KZPl+y6vs4aU70ytlKEsl3GOV51kh6y6Nq45bA=@vger.kernel.org
X-Gm-Message-State: AOJu0YxzxKX0n+a/2j7XpjePzYUBtkGSZgkX8hg4gnEJwhazkIqBkjuc
	YXTV4tBdX2SeO54v0Xnw4m9WDFM2Q4vIhLG8ZCufWlOXKfQvjpor
X-Google-Smtp-Source: AGHT+IGIEZRCxEuWx6vL3X0nJZKl6VaISOmP3I+XWFUbgfT4/LSjrkh/It62b/jDQl3D/gJqdgbfLg==
X-Received: by 2002:a05:6402:5299:b0:5c8:8cf5:e97a with SMTP id 4fb4d7f45d1cf-5ca0af7e5admr117367a12.33.1729200142033;
        Thu, 17 Oct 2024 14:22:22 -0700 (PDT)
Received: from ?IPV6:2a02:3100:b38a:4000:3c0a:7830:adf3:df4c? (dynamic-2a02-3100-b38a-4000-3c0a-7830-adf3-df4c.310.pool.telefonica.de. [2a02:3100:b38a:4000:3c0a:7830:adf3:df4c])
        by smtp.googlemail.com with ESMTPSA id 4fb4d7f45d1cf-5ca0b0e6b17sm18391a12.71.2024.10.17.14.22.20
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 17 Oct 2024 14:22:20 -0700 (PDT)
Message-ID: <e34dad2c-7920-4024-9497-f4f9aea4a93f@gmail.com>
Date: Thu, 17 Oct 2024 23:22:20 +0200
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net] r8169: avoid unsolicited interrupts
From: Heiner Kallweit <hkallweit1@gmail.com>
To: Realtek linux nic maintainers <nic_swsd@realtek.com>,
 Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
 David Miller <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>,
 Andrew Lunn <andrew+netdev@lunn.ch>
Cc: Pengyu Ma <mapengyu@gmail.com>,
 "netdev@vger.kernel.org" <netdev@vger.kernel.org>
References: <b8e7df14-d95e-4aab-b0e3-3b90ae0d3c21@gmail.com>
Content-Language: en-US
Autocrypt: addr=hkallweit1@gmail.com; keydata=
 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
In-Reply-To: <b8e7df14-d95e-4aab-b0e3-3b90ae0d3c21@gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 17.10.2024 08:05, Heiner Kallweit wrote:
> It was reported that after resume from suspend a PCI error is logged
> and connectivity is broken. Error message is:
> PCI error (cmd = 0x0407, status_errs = 0x0000)
> The message seems to be a red herring as none of the error bits is set,
> and the PCI command register value also is normal. Exception handling
> for a PCI error includes a chip reset what apparently brakes connectivity
> here. The interrupt status bit triggering the PCI error handling isn't
> actually used on PCIe chip versions, so it's not clear why this bit is
> set by the chip.
> Fix this by ignoring interrupt status bits which aren't part of the
> interrupt mask.
> Note that RxFIFOOver needs a special handling on certain chip versions,
> it's handling isn't changed with this patch.
> 
> Fixes: 0e4851502f84 ("r8169: merge with version 8.001.00 of Realtek's r8168 driver")
> Closes: https://bugzilla.kernel.org/show_bug.cgi?id=219388
> Tested-by: Pengyu Ma <mapengyu@gmail.com>
> Signed-off-by: Heiner Kallweit <hkallweit1@gmail.com>
> ---

When doing some unrelated performance tests I found that this patch breaks
connectivity under heavy load. Please drop it.
I'll investigate and come up with an alternative way to fix the reported issue.

