Return-Path: <netdev+bounces-256456-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id IvnRGgVXgmmISgMAu9opvQ
	(envelope-from <netdev+bounces-256456-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Tue, 03 Feb 2026 21:13:57 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [IPv6:2600:3c15:e001:75::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 893EFDE650
	for <lists+netdev@lfdr.de>; Tue, 03 Feb 2026 21:13:56 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id F2A3A3009801
	for <lists+netdev@lfdr.de>; Tue,  3 Feb 2026 20:13:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 19B3C369207;
	Tue,  3 Feb 2026 20:13:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="L/u8+vut"
X-Original-To: netdev@vger.kernel.org
Received: from mail-wr1-f45.google.com (mail-wr1-f45.google.com [209.85.221.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9A6F73659F4
	for <netdev@vger.kernel.org>; Tue,  3 Feb 2026 20:13:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770149632; cv=none; b=a0ggY1LzIAy3wXnfKcRPFWzEmRZNaRScAtq5jdhiURZWrVlFtKssHUDJb6hKi1cgSvNNqvELKAjGakMhBtW5ntl9xz/L7d2LCuqhdVRgsgKTOXscN0hQj1GHyaEslIwHqL0C6IjLD1nHgWARrmbTDTV+5JdiVOIJrttA9D+kPrs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770149632; c=relaxed/simple;
	bh=NODE1ex6xHPNfYT9o/gG2lncoCylLf2pyACo62WSVtc=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=BTtlZu4RJ9/kV2OqUA9aku0/KSottjb9EhdN9WOgEtNYT5tQ+wsDaxl0H62FItSoVKk3yTdmWzKGKcvqhNplkTH05nAR+U/hUJPdVCNGRPPqkFW0Q0esxhAH4YqFp9DXnBVRqFpMxVexb1liBiwZDMhUhC/KSSeshciEV9/l2ao=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=L/u8+vut; arc=none smtp.client-ip=209.85.221.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wr1-f45.google.com with SMTP id ffacd0b85a97d-43596062728so115861f8f.1
        for <netdev@vger.kernel.org>; Tue, 03 Feb 2026 12:13:50 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1770149629; x=1770754429; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=STBiAbnohjENbHefVxHOrw1vMjfV2CLsUHaeC+WEYyI=;
        b=L/u8+vut29lru0zfp/u0xZTDA3eBnDjqTJeBBdmUWRt+7RefIuFdpHd3spk0GEkHig
         oVRXB4LMZ/CMiFrGA47hvTApdeZS6gtkYiybSV2NcdnTkQ42yUkeZTgszphblCVvbo1u
         9ZE29YPpgVdrDVc83rx/hDmqIZUhGFKx/zv1QrT/LeornLLzvrZ8uIgbHaQnrlqEg+J5
         j2fjtZQGP4+Nt1KLYV4lQ0ZuEGsE+a0XVyQyAUdvRilWa8KX+u1ZU2vnqgLEA8hSI6t0
         OR50r1M2/4e5vjpZkQ3QTJuWuPa/nT3+MTiOcUqdp/bSuePI3g9j6ShQ0a+K12c1kRNz
         HLpw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1770149629; x=1770754429;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=STBiAbnohjENbHefVxHOrw1vMjfV2CLsUHaeC+WEYyI=;
        b=UGk6Fn0OHA2G2HQMm9pUxKx52Po2YkNGeBHDDR4mKYF1gv+W4eP/LSilHGhc7RbxCd
         drFZLlYutgEJh4G9fNDt+JwawzQoGTfP+1VldvdmIMwNzrkPFy9FW1PcR05s9wgVyGzd
         B9mvbFogAYp8nLl0ZhkaNPTqO97EYH/9s4xvRSZGzGYFIqBVOOCK/tBTr7YVgOi/0LbR
         MgUD/ub2/bvvMpDkGf5yQ331/BN9P61vU/VaQx1RX4zHOIw7TiUdn8IXf4ciqf8UEhEN
         C4ZAzwfhIlAdE5JT1YKuVniPU1X8Lvt9Bkgb9bXGpQGrppy9urkMu9wPOek4gom4bVSY
         nrAQ==
X-Forwarded-Encrypted: i=1; AJvYcCWo5MT7I4yWIUwU1lb/IEm4KtXJS2hcqxUJedBukWLDVzUSyOZw4F+THYuJx1YS8yTNoG9OVgA=@vger.kernel.org
X-Gm-Message-State: AOJu0Yza4IHBzOcg0GOzh2FgCZlOFzU6z20o5FLpbnTWNFRPfM437zq6
	RogNSCobN/cF3yp0ih8kCK5qqBt3yvHJY3JGCnmIwMRNTsbhqCHszuaB6eLbCQ==
X-Gm-Gg: AZuq6aLFuovx8W8ZPWbDh070yeoGJRiNEiDZ5o/VqJiiHjnq2I5vjfQN/zvzp3sseIE
	lKBxvaMYF2BaY0mgdRyukY9SvlTKfHWMpZ0ucCTQc3Ev4JDHoWA8d0/F2WYl/h7pVpFf4RJEu9H
	mwX9Rc1W4Td6pgiAnPGsaJsT+6JBFLMlyi3/7L9p5qIP+JBUquypOxL8G8kVaB1wEDjjMAR5W8G
	Do/4aclsogDRPlJ6Bc3wnal6QpBFrG89VMxA499FDOCAdqeXWvfqgdtKC5kbg+ITxMNEMRs01yw
	lpCRVx113nytqqEJLiwiP3RyThnOyaI0sVbtJNIGptUVsqQR8WpBzoFQaXs5sHQooMS1AWLR2i6
	Pf5PJekQfAdoN5SYsY6/6a+i/PN5BPPeUeTc3m2Gl0KcQNSI2Qyft6zp5fXP88/LkSfKAInsmpD
	TXS+f438UhnmGMlD7KGHowRYZ1QRDdnGCc/emtJfBY/9gRA3PGZWwS0R75NNeg59iuedyx7nOkn
	a54GkVSEMP01kzbX2OmumLBN1OI8ZtNnmL6YwQg6VAE2Wwh3hTEYhOKKZ3vGA==
X-Received: by 2002:a05:6000:18a7:b0:435:db9b:5881 with SMTP id ffacd0b85a97d-43617c8d34emr942617f8f.25.1770149628855;
        Tue, 03 Feb 2026 12:13:48 -0800 (PST)
Received: from ?IPV6:2003:ea:8f39:1b00:cd1:4684:14eb:6540? (p200300ea8f391b000cd1468414eb6540.dip0.t-ipconnect.de. [2003:ea:8f39:1b00:cd1:4684:14eb:6540])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-43617e38ec5sm1284665f8f.14.2026.02.03.12.13.47
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 03 Feb 2026 12:13:48 -0800 (PST)
Message-ID: <81407a61-1e6a-436c-83f3-fc403a706af6@gmail.com>
Date: Tue, 3 Feb 2026 21:13:47 +0100
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net-next v3] r8169: add support for RTL8125cp
To: javen <javen_xu@realsil.com.cn>
Cc: andrew+netdev@lunn.ch, davem@davemloft.net, edumazet@google.com,
 horms@kernel.org, kuba@kernel.org, linux-kernel@vger.kernel.org,
 netdev@vger.kernel.org, nic_swsd@realtek.com, pabeni@redhat.com
References: <f54e4d2a-666c-444a-a79e-0df2ddec97d9@gmail.com>
 <20260203075808.175-1-javen_xu@realsil.com.cn>
Content-Language: en-US
From: Heiner Kallweit <hkallweit1@gmail.com>
In-Reply-To: <20260203075808.175-1-javen_xu@realsil.com.cn>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.66 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[gmail.com,none];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c15:e001:75::/64:c];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20230601];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	MIME_TRACE(0.00)[0:+];
	TO_DN_SOME(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	TAGGED_FROM(0.00)[bounces-256456-lists,netdev=lfdr.de];
	DKIM_TRACE(0.00)[gmail.com:+];
	RCVD_TLS_LAST(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	FROM_HAS_DN(0.00)[];
	FREEMAIL_FROM(0.00)[gmail.com];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[hkallweit1@gmail.com,netdev@vger.kernel.org];
	ASN(0.00)[asn:63949, ipnet:2600:3c15::/32, country:SG];
	NEURAL_HAM(-0.00)[-1.000];
	RCPT_COUNT_SEVEN(0.00)[10];
	MID_RHS_MATCH_FROM(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sin.lore.kernel.org:helo,sin.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: 893EFDE650
X-Rspamd-Action: no action

On 2/3/2026 8:58 AM, javen wrote:
>> On 2/2/2026 11:58 AM, javen wrote:
> 
>>> From: Javen Xu <javen_xu@realsil.com.cn>
> 
>>>
> 
>>> This patch adds support for chip RTL8125cp. Its XID is 0x708. We apply 
> 
>>> different and firmware for RTL8125cp.
> 
>>>
> 
>>> Signed-off-by: Javen Xu <javen_xu@realsil.com.cn>
> 
>>>
> 
>>> ---
> 
>>> v2: This patch fix one mistake on phy_modify_paged(phydev, 0xa43, 
> 
>>> 0x10, 0x0000, 0x1001) which is phy_modify_paged(phydev, 0xa43, 0x00, 0x0000, 0x1001) on patch v1.
> 
>>>
> 
>>> v3: Set phy_modify_paged(phydev, 0xa43, 0x10, 0x0000, 0x0003), bit 0 
> 
>>> means 'link speed 10m PLL OFF', bit 1 means 'ALDPS PLL OFF', bit 2 
> 
>>> means 'ENABLE ALDPS', bit 12 means 'ALDPS XTAL OFF'.
> 
>>
> 
>> ALDPS is disabled two lines later in rtl8125cp_hw_phy_config().
> 
>> So why bother with ALDPS settings if ALDPS is disabled anyway?
> 
> 
> 
> Bit 2 means 'ENABLE ALDPS', we prefer to treat it as a master switch that controls
> 
> some sub-features like bit 1(ALDPS PLL OFF) and bit 12(ALDPS XTAL OFF), instead of
> 
> controlling these sub-features individually. And bit 0(link speed 10m PLL OFF)
> 
> has noting to do with aldps.
> 
I see, you changed the value of a43/10 to 0x0003 in v3. Then just this question:
Few lines later ALDPS gets disabled, so is it beneficial to set bit 1 here?
Thanks for mentioning that bit 0 isn't related to ALDPS.

> 
> 
> Thanks,
> 
> Javen Xu


