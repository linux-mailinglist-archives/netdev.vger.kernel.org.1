Return-Path: <netdev+bounces-193261-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id DFE7AAC34FF
	for <lists+netdev@lfdr.de>; Sun, 25 May 2025 15:46:08 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id B13C13B0B5C
	for <lists+netdev@lfdr.de>; Sun, 25 May 2025 13:45:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 334A61F0E50;
	Sun, 25 May 2025 13:46:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="gR0NRooX"
X-Original-To: netdev@vger.kernel.org
Received: from mail-wm1-f42.google.com (mail-wm1-f42.google.com [209.85.128.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7AB888C11
	for <netdev@vger.kernel.org>; Sun, 25 May 2025 13:46:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1748180765; cv=none; b=NTJlMj2buOeU5phENX6NjySNPk/7iCZkRB36GJc46LJZxXciKV7E/NZMmQwiI0Ws3+/sKRY2JewVb2WfLFehDMKALGg2Z993NHauiU/7aY/w3H3fkjkVnMqqZyxRwuTtBKf2WzS5CHtexmW4Oa+2FMx61eRlTJ/3oCcEt+U0MTs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1748180765; c=relaxed/simple;
	bh=mFXvaGohXRbNGECt6LAVxGWV1ZvswiKiFWGrHWY6FSQ=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=dxwgslsOzKVkkfitv+5ZRZhHVj+JNTcE/3qhpsZa5iIJybYtQxRh51lpwSfQUXftZqwBBHCqr3zmnErCB5tmjYKVgwwrDtuLmfCq5iDPzdEyomuyrYwwNtq7sm9/oAAjpxyAbZs6dDYGC4y65u2rob5pEP/dBPJl+DVUfcAxZYA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=gR0NRooX; arc=none smtp.client-ip=209.85.128.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f42.google.com with SMTP id 5b1f17b1804b1-44b1ff82597so13039545e9.3
        for <netdev@vger.kernel.org>; Sun, 25 May 2025 06:46:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1748180762; x=1748785562; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:autocrypt:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=ptBW4pq2eSB5zJsCn8bqtBKXBQ1gj4wGH+j5PRlxsiA=;
        b=gR0NRooXE03SnFxFnqIK0/UpsLJRYioeu0ZkQQb4JZs+vo339qB/5Ply4g7CsFaZ1u
         cuCNUOIsVjStqlNWA5GLyI0lqvuBW98ZsC6a6wULzYeWRAonaBKiURLUJrP7dwr/hw+9
         MbVigiO26lI1wcRE+R1mVshEGj/1mN197x0mJpTObNO+lJLvwbmHjl53/2/A4VTvXoK3
         PPrMv8a7YOY0UpW44jkqVc9rGNy+cHiQsJvCrsJxL/UHu2sU23n85vOND9ucmN30NGj2
         zJSNUGEBJiQ+yev/xzfhLsYMSVkuSjw0OfKXJ1m+jcenAdkKc3qW4Pr/gKqPI6OvBMXi
         pPVA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1748180762; x=1748785562;
        h=content-transfer-encoding:in-reply-to:autocrypt:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ptBW4pq2eSB5zJsCn8bqtBKXBQ1gj4wGH+j5PRlxsiA=;
        b=AL+7qSBfLKXdBCVZ3Mg55dL4lyUc/YaOmk/BRE9pdm05HCc+VknctMvvyvzniAj0Dj
         Yv15a48KhxX5cqkd1OEtIvacvmNueHvvrQUEbEYHNSkYCVUNg94gSG2Fq5MxLT+NDQHy
         GePJgUXHF9WpJC9mJqaCKqd2HJAJeQB9roiRnV7a+2KyKo7OFVy0dO4drW64H925/OEP
         YmXCEoATyW74wwyGMhxecNoh+M/pCDV/Fci2++XN5hNeM5o19uWSGfAoPGs65W5yW1zT
         ar3l6WbYLpFPGDL3mj5Plhnw2EUYBnqn79EmSU1SsoUn9Pe2Ib0WcDit70tPpEj5eKxb
         V/eA==
X-Gm-Message-State: AOJu0Yyn7tc5fiBTB6PSj6UNwEEUzDJMZNihqEzJDpLbZAv9ET/bZ6q6
	Ef1T83Bqoyvs1VN/1gjNPEFLVZwjlw8klXGPN5t7CaflIuf21A3HIizr
X-Gm-Gg: ASbGncsUIgwcAszHkvRHgzKuAG/qDlT/RVaSTeTNJwDU9PvWL87hbVJ0w59gY/XCOce
	uqWDgpZ3bwHwUj99WbQJGo1AhV9Se14ypDUi+r3TU1cM9pgt8+9lEAbvHydAAFYbHz7uHRldlYd
	rtM8Rqkci7zyD3rvcwnUzFYLPb8uvhbwuAvUabg8ePA6U1eMhA06PvJVGeVfMiauyJ6kaiMj/Q/
	wxGilboWH8Aq/DDFuknuJ29Ctjr6yene5csVX/GWCCbA/VV2sLB2D+XE0kiq95LHGUijPn98/z5
	l5j8C0mfYtveb/7Cnvnu3/reS9/6lm0wHe9Rgtb3z5oZ1ZE/tDKlEZzLBSKkS2obNK1uKs/3lLE
	YpG++1rJ2OyfMShGOopQnk5ysZxxMX/ugLm+IHWsO1r+zaqyCRP1Tsqd1xSM8PKcAaqhtwOQOhz
	yiw1Hd/WFFD/t/gzs=
X-Google-Smtp-Source: AGHT+IFInCxQdIDp0HzrnhHvqNRyrsduaDAWSraSBM+QuklOVa5PV8NuPp695IGYzs2En0IAV//ALw==
X-Received: by 2002:a05:600c:4e0c:b0:442:faa3:fadb with SMTP id 5b1f17b1804b1-44c917f3ea8mr59100415e9.2.1748180761495;
        Sun, 25 May 2025 06:46:01 -0700 (PDT)
Received: from ?IPV6:2003:ea:8f14:f300:48f2:565e:ea8f:fabe? (p200300ea8f14f30048f2565eea8ffabe.dip0.t-ipconnect.de. [2003:ea:8f14:f300:48f2:565e:ea8f:fabe])
        by smtp.googlemail.com with ESMTPSA id 5b1f17b1804b1-447f24b6471sm208715715e9.24.2025.05.25.06.45.58
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sun, 25 May 2025 06:45:59 -0700 (PDT)
Message-ID: <c2a05c06-5a70-4447-bf77-71e4f0d6407f@gmail.com>
Date: Sun, 25 May 2025 15:46:44 +0200
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net-next] net: phy: move
 mdiobus_setup_mdiodev_from_board_info to mdio_bus_provider.c
To: Paolo Abeni <pabeni@redhat.com>, Andrew Lunn <andrew@lunn.ch>,
 Andrew Lunn <andrew+netdev@lunn.ch>,
 Russell King - ARM Linux <linux@armlinux.org.uk>,
 Jakub Kicinski <kuba@kernel.org>, David Miller <davem@davemloft.net>,
 Eric Dumazet <edumazet@google.com>
Cc: "netdev@vger.kernel.org" <netdev@vger.kernel.org>
References: <de5f64cb-1d9f-414e-b506-c924dd9f951d@gmail.com>
 <914ef57a-7c22-448c-b9a3-0580e5311102@redhat.com>
Content-Language: en-US
From: Heiner Kallweit <hkallweit1@gmail.com>
Autocrypt: addr=hkallweit1@gmail.com; keydata=
 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
In-Reply-To: <914ef57a-7c22-448c-b9a3-0580e5311102@redhat.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 20.05.2025 12:45, Paolo Abeni wrote:
> On 5/15/25 10:11 PM, Heiner Kallweit wrote:
>> Move mdiobus_setup_mdiodev_from_board_info() to mdio_bus_provider.c.
>> Benefits are:
>> - The function doesn't have to be exported any longer and can be made
>>   static.
>> - We can call mdiobus_create_device() directly instead of passing it
>>   as a callback.
>>
>> Only drawback is that now list and mutex have to be exported.
> 
> ... so the total exports count actually increases, and I personally
> think that exporting a function is preferable to exporting a variable.
> 
> @Andrew, Russell: WDYT?
> 
> Thanks,
> 
> Paolo
> 
--
pw-bot: cr


