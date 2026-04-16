Return-Path: <netdev+bounces-279069-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id N/7xI2Lx4GkZnwAAu9opvQ
	(envelope-from <netdev+bounces-279069-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Thu, 16 Apr 2026 16:25:38 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id D518D40F8B2
	for <lists+netdev@lfdr.de>; Thu, 16 Apr 2026 16:25:37 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id EDB6E30414AA
	for <lists+netdev@lfdr.de>; Thu, 16 Apr 2026 14:25:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2ED123DE454;
	Thu, 16 Apr 2026 14:25:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="kWUWdcGW"
X-Original-To: netdev@vger.kernel.org
Received: from mail-wm1-f47.google.com (mail-wm1-f47.google.com [209.85.128.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BF4C43B27D8
	for <netdev@vger.kernel.org>; Thu, 16 Apr 2026 14:25:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776349532; cv=none; b=mW70TuuuaiLebz1VNhnMUuGSP7msD8/0sN2cD/RISbdGYpXbbRXPWUQUDRCBZ90rguq9VLHArE/lu/fzJ+ihdqF8lbglftZQjF/DC0SeSbNykl4zaosMOTb2jMEl2nAE3yC/1Cqrt8F8IIxVqvdaYR8RnHBxwGh6SdtKgJ6ZuT4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776349532; c=relaxed/simple;
	bh=Mah8Cmz6ZMkLKwtTNEnHpt5iWh2TaRLSHEFPfpzNWFY=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=hcz8J2P/Ef1Vhwm5uPCIIEv2aa4NWSvGm6Cxlyd2cXqNII+cvWoCqW7+bJ6h1V1KJGpv6luheieZ2TDRABuo+1PBkaS1bJxWjdTRJe3lsv/Dvj6ZWLnbhKyYKZ3j+zLXuHwZ0ztV8s/fnPDYoKjQ5VweHFbiqMoB9P47vpEzG0k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=kWUWdcGW; arc=none smtp.client-ip=209.85.128.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f47.google.com with SMTP id 5b1f17b1804b1-488ad135063so78051635e9.0
        for <netdev@vger.kernel.org>; Thu, 16 Apr 2026 07:25:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1776349529; x=1776954329; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=YY91CEdfGmuARnJ03T8w9/266qNTo7bDb9b4TzuMo0s=;
        b=kWUWdcGWo/JhJA2fA71lJrGoLTcbpov7ptQsLz2OdiGYP/K9GhdRS5SKhLGY1lRAay
         0p7XAS40v9lOvgxdA9bNiQOYc2lSDFKMqVqftlRgZ6fcAGLqK3dtJOwxk1Aj/Fg9y9Eo
         Nrl7ZtllQmBDiMc2muGng7KtXQBQVM38O+Z6utuqTAaJNAx+4hDn2yvQ8XsVfzAQlEf0
         dqufoS1bogTGY+gyKArpB5mmRWiS/WTsEWIG0f0MKQFIqhS0001iSRUj3vCYDa+Smm5E
         FW20hlPUaReZaI2ffNHvsGBRBqlHwyUH3bIQdY+tSZ3wAj4xS50ZIQlFaa8661YXmF/G
         Sbog==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1776349529; x=1776954329;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=YY91CEdfGmuARnJ03T8w9/266qNTo7bDb9b4TzuMo0s=;
        b=N29ciar5jlc7M9awob8qB0Pj1y4D3IRdX/DBQ3YvXSl4jF9J23/GHxi83Ag7txnOMr
         IXiNOlgT3mBFQINYf7Igo9Dt809jCDcxuV2a7HplFHbryRQQBJWgXk0Fy2AXxBtBP2VD
         kYdbnUWr4ENmBL2ZqwBKrqSXLfNN3cOTsAD7pi5bGr2KuhGtaMGLmOuSAreUMzoo8tTZ
         rK3B2IIKhmH+Uzjz1po6hLB3STxxtTxE//2iHJKYdYSst7ZQnsB4GNI4mi1Qoyc3nZnz
         jM+YZZ3HP9LW++pIi27fwcFT7BTpeClou5Vyg4w3dnzNIyT2NCoDM06iNcRDjFRl8bHt
         Kt0Q==
X-Forwarded-Encrypted: i=1; AFNElJ+1iSlbIEARi5Tf/nyh+KejPWgNPnoyqCP+cOh9TT4lhy8jMK/FwAmtyrzECauddqKb3qtxWIA=@vger.kernel.org
X-Gm-Message-State: AOJu0YxjWrioi1RZat9PnpMTrHg43y0o/fJvu/U2BIoQKa95O31dqqU6
	KWnBiGzaxkjG3dp2kOaFeaKnJoTGmGuu5Sl2Sv81VSSaa+SkA7EOQV/x
X-Gm-Gg: AeBDievSNW84ALtVNUwU0GlvnzT84txVbnxjZjPmpwFA1bXVHjFabg9phFxGbDAUskv
	JBFmmDP27cvXXwggqVBLrD1GcLbMBuEmuotwznV58xc84nllw0t2brZZmLR2JVIduq32RC2aeda
	KlTFubmX7vUUtM728XsKdu3Swu25HK+Rohn7fAUH7izkeo1zzIEgoUj7QcIVzOz+lGCrmg4ktK8
	LQ+CpxepiiHutsiSBpAycqNEWznh+irTmtAcDp21exezw6flyHwX7gcroshDdMmJTXPOdIAb75/
	brOeLdAUZmf8N2BSwdN2RoXUfzfaUr/zDtWzM/M/MfHTKRsOmHvZhQsMjZo+TuRKDOtJ4SgCE55
	88nsQj0w1GFAvSQfRvVn3wofXpWLIK5/J/QzHmeBKKYgsbmhgNYJqdfJREwiJMYL6COzUKzN8Ii
	JBlz74SsCcNJDPO+rP6h/adPuAdDD2tQXyY7uXDiLm/r9GWB1X8dlkrvTGM+H+zzARrQRtfajoO
	3dRJGD6YbTOo45GoJgH
X-Received: by 2002:a05:600c:8b27:b0:488:af7f:775f with SMTP id 5b1f17b1804b1-488d68766c7mr343666655e9.18.1776349528895;
        Thu, 16 Apr 2026 07:25:28 -0700 (PDT)
Received: from [10.1.4.108] (cust-east-par-46-193-119-166.cust.wifirst.net. [46.193.119.166])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-488f0959d82sm48640365e9.7.2026.04.16.07.25.27
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 16 Apr 2026 07:25:28 -0700 (PDT)
Message-ID: <bf93f620-1288-46a3-8798-6d70aeb2c7c6@gmail.com>
Date: Thu, 16 Apr 2026 16:25:27 +0200
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 1/3] net: dsa: microchip: implement KSZ87xx Module 3
 low-loss cable errata
To: Andrew Lunn <andrew@lunn.ch>
Cc: Marek Vasut <marex@nabladev.com>, Woojung Huh
 <woojung.huh@microchip.com>, UNGLinuxDriver@microchip.com,
 Vladimir Oltean <olteanv@gmail.com>, "David S. Miller"
 <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>,
 Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
 Maxime Chevallier <maxime.chevallier@bootlin.com>,
 Simon Horman <horms@kernel.org>, Heiner Kallweit <hkallweit1@gmail.com>,
 Russell King <linux@armlinux.org.uk>, netdev@vger.kernel.org,
 linux-kernel@vger.kernel.org, Fidelio Lawson <fidelio.lawson@exotec.com>
References: <20260414-ksz87xx_errata_low_loss_connections-v3-0-0e3838ca98c9@exotec.com>
 <20260414-ksz87xx_errata_low_loss_connections-v3-1-0e3838ca98c9@exotec.com>
 <ea90a671-70be-4d89-b842-1e54d687336f@nabladev.com>
 <d9b161dd-f698-4d7e-8ccb-9ec12411bf87@lunn.ch>
 <712cc46a-5ceb-4f0f-88bb-fa0a47002258@nabladev.com>
 <84e24758-2f59-44ca-a9b8-a46094578f83@gmail.com>
 <03040421-89e7-4422-9fb5-0367a34323e4@lunn.ch>
Content-Language: en-US
From: Fidelio LAWSON <lawson.fidelio@gmail.com>
In-Reply-To: <03040421-89e7-4422-9fb5-0367a34323e4@lunn.ch>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[gmail.com,none];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20251104];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FREEMAIL_CC(0.00)[nabladev.com,microchip.com,gmail.com,davemloft.net,google.com,kernel.org,redhat.com,bootlin.com,armlinux.org.uk,vger.kernel.org,exotec.com];
	TAGGED_FROM(0.00)[bounces-279069-lists,netdev=lfdr.de];
	FROM_HAS_DN(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	RCVD_TLS_LAST(0.00)[];
	FREEMAIL_FROM(0.00)[gmail.com];
	RCPT_COUNT_TWELVE(0.00)[16];
	DKIM_TRACE(0.00)[gmail.com:+];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	TO_DN_SOME(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[lawsonfidelio@gmail.com,netdev@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[netdev];
	MID_RHS_MATCH_FROM(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: D518D40F8B2
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

On 4/16/26 14:25, Andrew Lunn wrote:
>> Yes, I think a reasonable compromise could be to expose three tunables:
>>
>> - a boolean "short-cable" tunable, which applies the known good settings
>>    (LPF 62 MHz BW, DSP EQ initial value 0).
>>
>> - an integer LPF bandwidth tunable, for advanced use cases where further
>>    tuning is needed;
>>
>> - an integer DSP EQ initial value tunable, for the same advanced cases.
>>
>> The boolean tunable would follow the KISS principle and cover the common
>> scenario, while the more granular controls would remain optional.
> 
> How do the three interact? Do you need to first enable short-cable
> before you set LPG bandwidth or DSP EQ? If it is not enabled, do you
> get -EINVAL?
> 
> It seems like having extack would be useful to return informative
> error messages to user space, however, that requires netlink
> ethtool. And ETHTOOL_PHY_STUNABLE has not been added to netlink
> ethtool yet :-(
> 
> 	Andrew

My intention would be to keep the interactions as simple and
non-surprising as possible, and avoid requiring any particular ordering
or state machine between the tunables.

The boolean short-cable tunable would simply apply the preset
in one step. The LPF bandwidth and DSP EQ initial value tunables would 
be orthogonal knobs which can be set independently at any time, 
regardless of whether short-cable is enabled or not.

With this model, we don’t need to return -EINVAL for combinations or
ordering, and userspace does not need detailed error reporting. The
tunables behave more like simple setters than a mode switch, which
keeps the API predictable and avoids the need for extack or netlink
ethtool support at this point.

Fidelio


