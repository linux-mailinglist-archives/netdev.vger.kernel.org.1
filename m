Return-Path: <netdev+bounces-238893-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id 50765C60BBF
	for <lists+netdev@lfdr.de>; Sat, 15 Nov 2025 22:28:04 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 7FE1E4E1707
	for <lists+netdev@lfdr.de>; Sat, 15 Nov 2025 21:26:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C502523BD1D;
	Sat, 15 Nov 2025 21:26:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ax88SKCQ"
X-Original-To: netdev@vger.kernel.org
Received: from mail-wm1-f49.google.com (mail-wm1-f49.google.com [209.85.128.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 11F2C21A447
	for <netdev@vger.kernel.org>; Sat, 15 Nov 2025 21:26:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763241993; cv=none; b=lZvE9pAg5kzf8yHqggrn3srGrNIbGW60yYPCdO5r9t25ZiptVSg8kYG5hnB2U8Fq+VvhNUCpsSzq3u2om3DjgaNwTQv+OnHEnM4pm/MD9nplfbzMCZX7Jc0UXfvckh/JsyW1MQLFo1k3RSib0Q+qVsae/QqSTgjl3k887u2tpyQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763241993; c=relaxed/simple;
	bh=8v9uIOmgdamqV3ZY3x/o9FqEarHVPOy2KCPRn0Uxb0c=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=lpfnDa/hRQ9tXRitKPNhSlYRc+IHpyyNCHMBc9vyB3L0jHKMD2RKhIs4HfVnX93myiwz1TkXjTYlS75U+Wq4b/EotBvY7rYQBSBYnxteHgnBsY416o12vUy56X1brd4u3BWQZci1u9xB+BaFbv+CViOJ2IBYN6DDgqka+CcAAC8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=ax88SKCQ; arc=none smtp.client-ip=209.85.128.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f49.google.com with SMTP id 5b1f17b1804b1-4710022571cso28682405e9.3
        for <netdev@vger.kernel.org>; Sat, 15 Nov 2025 13:26:31 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1763241990; x=1763846790; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=TWLafe1CiEVI/z5NIFCryV2L73Psg30K8oiuqEJMvYM=;
        b=ax88SKCQc7HUrx+2vQwUyEe1dNfWGQAc1G+anLK67EX549qVEgqwIThBu6+XrfvX+8
         5wOMR3yoDfrzA5ns2VIX7p16AYkMLVOj/VN8agWBe16J3v1aG2gva946rGT4SOyiPqZ3
         7G35DwGRUeJ5t4Kvaoo/QsosvHcLCtip+95NQoe+V4QTmcbzr9TzSuS6mz5spyFsmS9a
         W2/LIwWiHtzx0M3rihAMDuY4447y8+NLba181jFGgvWtE4CK7/vbudAWK/AK/3ddizTG
         Dlz4aGZXGnDvOBDodBbKOmliMki+p61c2dDbA+Xs2On/O2oAAg1Q6wT0rAeZUYG1Fvp8
         xodA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1763241990; x=1763846790;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=TWLafe1CiEVI/z5NIFCryV2L73Psg30K8oiuqEJMvYM=;
        b=Qgsmdt0X2RcvrMWVr22tvSYr4SEyAlF8bXs5/wC1gy4lf7Huhvji/y709pV/pUWrr5
         WpPkEL+JnuVX9SK+iohNIDMQW0vOy+PF7vyxhgMjCdyacA43SnESy+9fdFNo/8AJo+mC
         CBuKmGqXZbj5DZzE4uuRRdPjejp4aiKfoiU5CUOMGmlZ5kw53ibqJiGT1NutSCG2usJV
         OBalLFMzMXkPdSqTmRIYYpvbwVuxpghbcM4OdKuM7KG31ppKZAWm9qTPbQ7+yc3O8lh7
         8d3ckbY1Jc0ia0fqvruDhg6eImmH2tVMmW3q5X55Rv/cM0MVBfvLwTnPPO2HweFa1NIA
         KxZg==
X-Forwarded-Encrypted: i=1; AJvYcCUYoNgDw905+gwl1Lmezs1V7afmYahR+CHB25cywCVV6Mt7kiAFTBih0378iRbUq/LmebWiimU=@vger.kernel.org
X-Gm-Message-State: AOJu0YyJ2bKur9zLvfZWXkFecKiSyWc3oK5kfWhAABMuX3tWxR23/nLU
	Iuu3oT1sRmXZIa54XtsE7Y5EZMgvicm+67O5BQBWPu3yuCwSj/RY7Qg1
X-Gm-Gg: ASbGncsNW3qnpRyoKCFfbPOgkFG4a0kFiRlVVTvrM2pOOYeF02Mwha0QlKHI6CGo6xU
	353CIKF0pULURjsK8eF3ujqQDCTr2D8lMLw+AfW3DqniwzCM1Vo2XrzaasZihGWD9FC/U3CPkT9
	jL+fjXK5rMgBaG7ETztU9nWDOBsKjWfsLPSAG1vQH8Hyo7qM9+0iM8Bz2ipryUGG9FmJcoTXIs9
	F0PDmjjqss3BljpTVUmMRVB6ZKTsoU7Bm6mwFouHeBWzi1cVDEdA6S0I/0JYETLHMREPhHwSlaw
	BvtjadU/ulO0QgxbBU8dDgrkYS3QkQcCM3jRzH1L+fZAIc3vjfKe3Uy096Rlwb0wi/lxt4toeuE
	P6I2Ha0cWqJCLwwpg8l0Qv1PlCq60Y6GbR1Ulm1lO0WovPsq/YyKTasiLrSUkvPaBoGUNengXc0
	p7KIIHOhJ6rxiig1bbigkj+ry1x/VYekKM0hCwcfh0Nj/is9eZ75zqSWWkK2RLoQo170PO5iVwB
	uFwlKgZzA/467BYOR7sG33ASSsxjbbzXNl78kM3v+xnLl3l3z8wMA==
X-Google-Smtp-Source: AGHT+IGKrjZPx8IPhI+FCjOQPz7YWtS6e3WDJ0qObbYagWG9XJrsK2RByxJEXWrQejpNgiVaT/wxJQ==
X-Received: by 2002:a05:600c:c4a3:b0:477:fcb:2256 with SMTP id 5b1f17b1804b1-4778fe6094cmr75421095e9.17.1763241990080;
        Sat, 15 Nov 2025 13:26:30 -0800 (PST)
Received: from ?IPV6:2003:ea:8f21:db00:e03a:ae7c:84f9:38f2? (p200300ea8f21db00e03aae7c84f938f2.dip0.t-ipconnect.de. [2003:ea:8f21:db00:e03a:ae7c:84f9:38f2])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4778bb30eacsm80157425e9.2.2025.11.15.13.26.27
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sat, 15 Nov 2025 13:26:28 -0800 (PST)
Message-ID: <7082e2d0-a5a9-4b00-950f-dc513975af1c@gmail.com>
Date: Sat, 15 Nov 2025 22:26:35 +0100
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: LAN8720: RX errors / packet loss when using smsc PHY driver on
 i.MX6Q
To: Fabio Estevam <festevam@gmail.com>
Cc: Russell King - ARM Linux <linux@armlinux.org.uk>,
 edumazet <edumazet@google.com>, netdev <netdev@vger.kernel.org>,
 Andrew Lunn <andrew@lunn.ch>
References: <CAOMZO5DFxJSK=XP5OwRy0_osU+UUs3bqjhT2ZT3RdNttv1Mo4g@mail.gmail.com>
 <e9c5ef6c-9b4c-4216-b626-c07e20bb0b6f@lunn.ch>
 <CAOMZO5BEcoQSLJpGUtsfiNXPUMVP3kbs1n9KXZxaWBzifZHoZw@mail.gmail.com>
 <1ec7a98b-ed61-4faf-8a0f-ec0443c9195e@gmail.com>
 <CAOMZO5CbNEspuYTUVfMysNkzzMXgTZaRxCTKSXfT0=WmoK=i5Q@mail.gmail.com>
Content-Language: en-US
From: Heiner Kallweit <hkallweit1@gmail.com>
In-Reply-To: <CAOMZO5CbNEspuYTUVfMysNkzzMXgTZaRxCTKSXfT0=WmoK=i5Q@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

On 11/15/2025 10:01 PM, Fabio Estevam wrote:
> Hi Heiner,
> 
> On Fri, Nov 14, 2025 at 6:33 PM Heiner Kallweit <hkallweit1@gmail.com> wrote:
> 
>> The smsc PHY driver for LAN8720 has a number of callbacks and flags.
>> Try commenting them out one after the other until it works.
>>
>> .read_status    = lan87xx_read_status,
>> .config_init    = smsc_phy_config_init,
>> .soft_reset     = smsc_phy_reset,
>> .config_aneg    = lan95xx_config_aneg_ext,
>> .suspend        = genphy_suspend,
>> .resume         = genphy_resume,
>> .flags          = PHY_RST_AFTER_CLK_EN,
>>
>> All of them are optional. If all are commented out, you should have
>> the behavior of the genphy driver.
>>
>> Once we know which callback is problematic, we have a starting point.
> 
> Thanks for the suggestion.
> 
> After removing the '.soft_reset = smsc_phy_reset,' line, there is no
> packet loss anymore.
> 
> If you have any other suggestions regarding smsc_phy_reset(), please
> let me know.
> 
smsc_phy_reset() does two things:
1. set PHY to "all capable" mode if in power-down
2. genphy_soft_reset()

Again, as the genphy driver works fine for you, both parts should be optional.
Check with part is causing the packet loss.

> Thanks


