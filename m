Return-Path: <netdev+bounces-219511-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 00AEFB41AB4
	for <lists+netdev@lfdr.de>; Wed,  3 Sep 2025 11:54:55 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 632427AB720
	for <lists+netdev@lfdr.de>; Wed,  3 Sep 2025 09:53:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7D5392DD60E;
	Wed,  3 Sep 2025 09:52:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=blackwall.org header.i=@blackwall.org header.b="ZPk3arVe"
X-Original-To: netdev@vger.kernel.org
Received: from mail-lf1-f45.google.com (mail-lf1-f45.google.com [209.85.167.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 90A9E2C21F9
	for <netdev@vger.kernel.org>; Wed,  3 Sep 2025 09:52:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756893143; cv=none; b=szyEoDujws0FgAGZ9b8uZFSV6d6vCzw1530ZhKm9JTXMcRhaBjAffUOfKJ00iGCCMaI2ZDlL04GGGMHUxV1aWfGBRRdreNbx8XwZ/WjzuAKFNnFo+C6eko22BdkvQcwgznDOVFou/bjPsRGnqbFuTS25lzNglfQ9YC8dvxABkPs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756893143; c=relaxed/simple;
	bh=IHI4Lh34DnlqQV1gz4FV/jeN9W4c6fRBK6GzmhkmVDE=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=oHkwQrjW7F2oUHQ9bPPbsIYvmTtXiBC5VzqEvOZ5fyYouteo93kYDDI0ozBa4ieyan7soTErsQZ3Gv5iRkVigCTq8k3w22+e0h8sPhwAM+0x+9O4Zn3CRZ2FghRQvGH3d5Mtp++YjvYjvOnNlr9ZpvgeyZAK3RO1o9ypj7/zG2A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=blackwall.org; spf=none smtp.mailfrom=blackwall.org; dkim=pass (2048-bit key) header.d=blackwall.org header.i=@blackwall.org header.b=ZPk3arVe; arc=none smtp.client-ip=209.85.167.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=blackwall.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=blackwall.org
Received: by mail-lf1-f45.google.com with SMTP id 2adb3069b0e04-5608bfae95eso519777e87.1
        for <netdev@vger.kernel.org>; Wed, 03 Sep 2025 02:52:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=blackwall.org; s=google; t=1756893140; x=1757497940; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=FkOh6GiVRIhhvdDnammQLO/YqbaXC/eAMSSkjGecmSE=;
        b=ZPk3arVeuo2XzPgHaB3GFBQzFeXS1fTC9NdqpN4F9NdA8uBM10t/PEeq9DKFUE5xvd
         dTNOhGSuN9SUnpz3gV+8BLGWmMA6jHOz7A6AVtvfTqnvysFH8ZKjiILMfC6NovUZ8RJP
         uPsiKceNOKxG9qMeEzDIPDrji1ApSMxQkRJpkxmLMp3TAshlwxQfYm6lWfSXYPkuZG+O
         v05XsFwnwV2g5oUhvNE4eNkKAkvmuyuARyfFRpFBA2EkrRHAOe5jjLxe5OWpx/MX7jAO
         u4Pld7u4HX7IdnxPfQd5bC+pYKyPBH7FShSio20h5Jw1PQkkzOG0Mtuk0GZ32mk+FQrP
         ax6A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1756893140; x=1757497940;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=FkOh6GiVRIhhvdDnammQLO/YqbaXC/eAMSSkjGecmSE=;
        b=kryHBxJiyAor1yS11W8rtSlGEx9vqZZuT/I1QpmMgrrqxKrX0InC9m9vwBMyKREAPl
         Yemoa9jRnEbHW0y2kSybXetuplN1lBjwscrN8GIcmCb6CWVipaTCtU+xsnGPySPBPTrS
         U53uqIy6uDeIHY+VUIuqGXMNRb2f3kJ5leQ8bvDhKCRABbnMW7wdHhykxUiqelCNY4NH
         vT3NJDiX1f1iqqtoZYu9LZeQHpXYGwAHqLsBHYqqMC3CIydoFCBSPMy/rPX+NdH4sD3a
         UgQNVMp7tGnCpYs5AxG5q98eC78o14y9UN8amxhfksxrCn1bTV7q/0Ps5RbZ4yfxHErl
         EH/A==
X-Forwarded-Encrypted: i=1; AJvYcCXv7eDwuCVTxk3cIRGxeT8SpBzyVsHNds6tIXIbi7yPr+ICKb7HrLXB1IQ/tfQL58N3XmmCl5A=@vger.kernel.org
X-Gm-Message-State: AOJu0YzZPPyBEMjTxy4X35XML7tFG0WOgJObLRpeqtV5swztqgsrp2QZ
	MW4SmGjSozLrdgALOfNDMAik0WTXeaAOJlDcY3KPisH34YOByBFeAYT9EYctaSC+oqs=
X-Gm-Gg: ASbGncvrpTkoHnY8TIj9CB82o/tuzsb1CFcxpLoYzJtyKby7qIFS5Y1bpeH4hZS7roF
	K2F6f4zqcZor8l+fNFK9/M/vkW0G726dlat1IoCWlDX7AkwSNSOjFflvRZPB8WxeURAMQQwihSe
	hmxxyHZVZs1BV5xvkh0f1jqO+DdArDu9bgxYViEtNUnKoFmC9ygdeZy/xoQ1J1npmaUrIIjCeOi
	bxOM11oY7f0jiUXrkkPUpx8G1Asmji5qnrB/f+wX/durpOMiUhRNPjlNO01QLgy0gotjoI510LW
	y6+9BgcDMINJ0sdxj/Wvc0tLcP5TbcyDP6Wj4WYmASXg0u3pG+URrqW4zF95r3T83ciuzYLiYto
	PYIIH29tG547sv5YbJ19oxz7tbcTfAVg7Bi2K72uKANngL26kBO4MYu8/LOFiYYwQiLCmEktMRS
	SK1XI0zxKYLUsA
X-Google-Smtp-Source: AGHT+IFbPqnw2qqkEXRE6VRi7nCMBHnGUo+2xz9gd3IMDxcdGmvZmcVa6xY9xV04WX/LLw/gqjYd5g==
X-Received: by 2002:a05:6512:ea2:b0:55f:6831:6eff with SMTP id 2adb3069b0e04-55f708a2b27mr4806509e87.4.1756893139495;
        Wed, 03 Sep 2025 02:52:19 -0700 (PDT)
Received: from [100.115.92.205] (176.111.185.210.kyiv.nat.volia.net. [176.111.185.210])
        by smtp.gmail.com with ESMTPSA id 2adb3069b0e04-5608ad0718fsm397194e87.112.2025.09.03.02.52.18
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 03 Sep 2025 02:52:18 -0700 (PDT)
Message-ID: <b25f0337-5a7d-4632-a022-facc477a8dce@blackwall.org>
Date: Wed, 3 Sep 2025 12:52:17 +0300
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net-next] bonding: Remove support for use_carrier
To: Jay Vosburgh <jv@jvosburgh.net>, netdev@vger.kernel.org
Cc: "David S. Miller" <davem@davemloft.net>,
 Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>,
 Paolo Abeni <pabeni@redhat.com>, Simon Horman <horms@kernel.org>,
 Jonathan Corbet <corbet@lwn.net>, Andrew Lunn <andrew+netdev@lunn.ch>,
 linux-doc@vger.kernel.org
References: <2029487.1756512517@famine>
Content-Language: en-US
From: Nikolay Aleksandrov <razor@blackwall.org>
In-Reply-To: <2029487.1756512517@famine>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 8/30/25 03:08, Jay Vosburgh wrote:
> 	 Remove the implementation of use_carrier, the link monitoring
> method that utilizes ethtool or ioctl to determine the link state of an
> interface in a bond.  Bonding will always behaves as if use_carrier=1,
> which relies on netif_carrier_ok() to determine the link state of
> interfaces.
> 
> 	To avoid acquiring RTNL many times per second, bonding inspects
> link state under RCU, but not under RTNL.  However, ethtool
> implementations in drivers may sleep, and therefore this strategy is
> unsuitable for use with calls into driver ethtool functions.
> 
> 	The use_carrier option was introduced in 2003, to provide
> backwards compatibility for network device drivers that did not support
> the then-new netif_carrier_ok/on/off system.  Device drivers are now
> expected to support netif_carrier_*, and the use_carrier backwards
> compatibility logic is no longer necessary.
> 
> 	The option itself remains, but when queried always returns 1,
> and may only be set to 1.
> 
> Link: https://lore.kernel.org/lkml/000000000000eb54bf061cfd666a@google.com/
> Link: https://lore.kernel.org/netdev/20240718122017.d2e33aaac43a.I10ab9c9ded97163aef4e4de10985cd8f7de60d28@changeid/
> Signed-off-by: Jay Vosburgh <jv@jvosburgh.net>
> 
> ---
> 
> Note: Deliberately omitting a Fixes tag to avoid removing functionality
> in older kernels that may be in use.
> 
>   Documentation/networking/bonding.rst |  79 +++----------------
>   drivers/net/bonding/bond_main.c      | 113 ++-------------------------
>   drivers/net/bonding/bond_netlink.c   |  14 ++--
>   drivers/net/bonding/bond_options.c   |   7 +-
>   drivers/net/bonding/bond_sysfs.c     |   6 +-
>   include/net/bonding.h                |   1 -
>   6 files changed, 28 insertions(+), 192 deletions(-)
> 

Reviewed-by: Nikolay Aleksandrov <razor@blackwall.org>


