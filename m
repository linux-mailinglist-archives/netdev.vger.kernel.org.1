Return-Path: <netdev+bounces-278461-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id JPmACSBG3mn+pwkAu9opvQ
	(envelope-from <netdev+bounces-278461-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Tue, 14 Apr 2026 15:50:24 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [104.64.211.4])
	by mail.lfdr.de (Postfix) with ESMTPS id E7A733FABAB
	for <lists+netdev@lfdr.de>; Tue, 14 Apr 2026 15:50:21 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id 6E20C301F19D
	for <lists+netdev@lfdr.de>; Tue, 14 Apr 2026 13:48:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 98A123DD524;
	Tue, 14 Apr 2026 13:48:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="WIGtfU1G"
X-Original-To: netdev@vger.kernel.org
Received: from mail-wm1-f51.google.com (mail-wm1-f51.google.com [209.85.128.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 31EB838B7A5
	for <netdev@vger.kernel.org>; Tue, 14 Apr 2026 13:48:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776174517; cv=none; b=IZ11H5vHITD/GVFc2Diq7l/pEHfkns4yhJfpi4x7cT9glIYQ47DaQ6+WuVecCzcd6mDgVwPY8yoyc3iC0XVj0j5xXGhaUqv3bpljqcuaRtSL9mjmVwIkYqTXQ+4DBRHxZm629RJF5nt2cP2Uik6xp1vBZ9FY3hDzH5KGX4kaDuw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776174517; c=relaxed/simple;
	bh=+NIf6YWtruCdajeUPR86ezk4H6Rxe1H7k9Hfp/7xtbA=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=JMkgtNMRsjaO70qPfTMzdTMiSYp1+ygSxMQKIef6eBlgOoJ6HyPGChOLN1DfcTdNEXqf12dxwKnTU4Xj1pH7rBMjvtu4ELS94xYj9IvXRff52fiViW4S6sWWJTC9v15cf5yZqIRjFwtQGhKv4z8uBRyiZhly4uiA9OLfLbiMktM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=WIGtfU1G; arc=none smtp.client-ip=209.85.128.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f51.google.com with SMTP id 5b1f17b1804b1-488971db0fdso55720325e9.0
        for <netdev@vger.kernel.org>; Tue, 14 Apr 2026 06:48:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1776174515; x=1776779315; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=JyLOjyeR0ZbXLEUgpEciyu4epczHaYj8tmmKfzQz42c=;
        b=WIGtfU1G7Js+If21he1p+je8C3Xv+gFZ5hhz4bUM3smZooPdliPHIBcGnwSmIfbWbh
         VTKt3/bbjeuWWuFw35LCPbSH3CVeI7gUe4oEkSlCW6j6UCV02RQUBZVdD0l0fsIku/+M
         dRE3vSnW+G/E9Nnw7ap5Pps3KrBzzHwAVz/MCT6i1HObbtcp+0uzXN6kD8b/y5mASXru
         9AVcH3wgdT5uPXRx4DM3Qi8I8Y5vDGq+pBOoekbluVpY+MQY0ExKvbODBY/GT2aAGTJ1
         xk89v9O3BDepqkYMAWinnPTrVbuS+rAxySqUyKxg38pwROdVCi2kkhQ3xsOjzyokJ9qv
         bkcg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1776174515; x=1776779315;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=JyLOjyeR0ZbXLEUgpEciyu4epczHaYj8tmmKfzQz42c=;
        b=oriTTZi2+mfL4tssDv0IdxXoBCbtl+5/x8/UUVn5m1xLoFeja6pnSmGWFKayyiH7am
         prl6RY3Tq7/bUPM3WDUP/lkVsiQDngVCmBqGJlyS/OT2QUgtRjyUMdWEtYpa+uvQ1neD
         WZYvp7cYSW5BycpXxPcbzB5/6jd9xnN/vQgVn/1fYSVfJYmFB48RF2B+jBR7FIZdFVvY
         m7StTHVyv1pzj1BGTOy/mrppJsI3RjAXVceN7NJpYy60mR359LPQKK9VQEoZyGl7Y3g0
         JBiP684CzL4T4r5PgO2v5iZ/oJMFtnOjEVHPQUe8AunFiwijD4tX2gmw5gVIyiaHgZg8
         UmRQ==
X-Forwarded-Encrypted: i=1; AFNElJ+kA7n//exP05h6o9boCG9hX1K4qVZ8Uy6ejoeKOWPN2K7Z3drf9WrK42o9GSVMf+9JPn6Tey4=@vger.kernel.org
X-Gm-Message-State: AOJu0Yzy9VisBlceF5UVKur8BXo9gIuccwsI+p5J+sCV8mhZLFZz+XHR
	CaaUzjvQQ4+/scUxVl3solm1+N+9BGkxiNXZpqQWgn0iGjRmSeInpnq5
X-Gm-Gg: AeBDietJJTEmZZyLOXtKWF+zOsMN2zCTKkJR7RhW6uackQCjvGiJEyVAYyfn5hfRvy1
	xvOYGELpi/c6HCaT6AjXMVGQBQsZgErMAoEWHpkx63L4htlWIPv59pxsRzLw0zxOtd4YnDD/cQ5
	RLTMCv/l1krZOMsx2z3uDuthzpm5HBZYBl0aJF+C+l68A1jdX2pxZH5SUyWABjjTi2zPA+BxuO+
	jgwlbVPgpyyHz2eFI1xo+iLBZprojrXW7B5sJcSBDHd5gANG61IDjJQyuuItuy0WPj/HpH8cpWP
	M7rKU8UK6+8ePigqnwL4ItI97keQ41E0WTap4glMhB34lIlkY5oz+k3yjWNkmQtTINVY6wFSr8N
	ar2ZddjE+e4Ln+TQGdSICYc/i7nRNuAvFZiPAWVq2shQVD/C16lOgw5GrmZKfBoJq9wD7bhXQfd
	Ncov++iPeyEl3sCWCwl7A1DI1NVGPNQ/8WSHM5dhqDmKJ3JTt/e1hezWlwWkZfUddjgbqv/ig4X
	hqq93+uKhD8jW81rb1A
X-Received: by 2002:a05:600c:5d4:b0:488:d6eb:e63c with SMTP id 5b1f17b1804b1-488d6ebe787mr144787475e9.15.1776174514352;
        Tue, 14 Apr 2026 06:48:34 -0700 (PDT)
Received: from [10.1.4.108] (cust-east-par-46-193-119-166.cust.wifirst.net. [46.193.119.166])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-488ede1de4asm116273755e9.4.2026.04.14.06.48.33
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 14 Apr 2026 06:48:34 -0700 (PDT)
Message-ID: <264667a8-bbb2-44ac-84e7-df6c506ae6fa@gmail.com>
Date: Tue, 14 Apr 2026 15:48:33 +0200
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 1/3] net: dsa: microchip: implement KSZ87xx Module 3
 low-loss cable errata
To: Andrew Lunn <andrew@lunn.ch>, Marek Vasut <marex@nabladev.com>
Cc: Woojung Huh <woojung.huh@microchip.com>, UNGLinuxDriver@microchip.com,
 Vladimir Oltean <olteanv@gmail.com>, "David S. Miller"
 <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>,
 Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
 Marek Vasut <marex@denx.de>,
 Maxime Chevallier <maxime.chevallier@bootlin.com>,
 Simon Horman <horms@kernel.org>, Heiner Kallweit <hkallweit1@gmail.com>,
 Russell King <linux@armlinux.org.uk>, netdev@vger.kernel.org,
 linux-kernel@vger.kernel.org, Fidelio Lawson <fidelio.lawson@exotec.com>
References: <20260414-ksz87xx_errata_low_loss_connections-v3-0-0e3838ca98c9@exotec.com>
 <20260414-ksz87xx_errata_low_loss_connections-v3-1-0e3838ca98c9@exotec.com>
 <ea90a671-70be-4d89-b842-1e54d687336f@nabladev.com>
 <d9b161dd-f698-4d7e-8ccb-9ec12411bf87@lunn.ch>
Content-Language: en-US
From: Fidelio LAWSON <lawson.fidelio@gmail.com>
In-Reply-To: <d9b161dd-f698-4d7e-8ccb-9ec12411bf87@lunn.ch>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[gmail.com,none];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20251104];
	R_SPF_ALLOW(-0.20)[+ip4:104.64.211.4:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FREEMAIL_CC(0.00)[microchip.com,gmail.com,davemloft.net,google.com,kernel.org,redhat.com,denx.de,bootlin.com,armlinux.org.uk,vger.kernel.org,exotec.com];
	TAGGED_FROM(0.00)[bounces-278461-lists,netdev=lfdr.de];
	FROM_HAS_DN(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	RCVD_TLS_LAST(0.00)[];
	FREEMAIL_FROM(0.00)[gmail.com];
	RCPT_COUNT_TWELVE(0.00)[17];
	DKIM_TRACE(0.00)[gmail.com:+];
	ASN(0.00)[asn:63949, ipnet:104.64.192.0/19, country:SG];
	TO_DN_SOME(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[lawsonfidelio@gmail.com,netdev@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[netdev];
	MID_RHS_MATCH_FROM(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sin.lore.kernel.org:helo,sin.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: E7A733FABAB
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

On 4/14/26 14:40, Andrew Lunn wrote:
> On Tue, Apr 14, 2026 at 01:05:49PM +0200, Marek Vasut wrote:
>> On 4/14/26 11:12 AM, Fidelio Lawson wrote:
>>> Implement the "Module 3: Equalizer fix for short cables" erratum from
>>> Microchip document DS80000687C for KSZ87xx switches.
>>>
>>> The issue affects short or low-loss cable links (e.g. CAT5e/CAT6),
>>> where the PHY receiver equalizer may amplify high-amplitude signals
>>> excessively, resulting in internal distortion and link establishment
>>> failures.
>>>
>>> KSZ87xx devices require a workaround for the Module 3 low-loss cable
>>> condition, controlled through the switch TABLE_LINK_MD_V indirect
>>> registers.
>>>
>>> The affected registers are part of the switch address space and are not
>>> directly accessible from the PHY driver. To keep the PHY-facing API
>>> clean and avoid leaking switch-specific details, model this errata
>>> control as vendor-specific Clause 22 PHY registers.
>>>
>>> A vendor-specific Clause 22 PHY register is introduced as a mode
>>> selector in PHY_REG_LOW_LOSS_CTRL, and ksz8_r_phy() / ksz8_w_phy()
>>> translate accesses to these bits into the appropriate indirect
>>> TABLE_LINK_MD_V accesses.
>>>
>>> The control register defines the following modes:
>>> 0: disabled (default behavior)
>>> 1: EQ training workaround
>>> 2: LPF 90 MHz
>>> 3: LPF 62 MHz
>>> 4: LPF 55 MHz
>>> 5: LPF 44 MHz
>> I may not fully understand this, but aren't the EQ and LPF settings
>> orthogonal ?
> 
> What is the real life experience using this feature? Is it needed for
> 1cm cables, but most > 1m cables are O.K with the defaults? Do we need
> all these configuration options? How is a user supposed to discover
> the different options? Can we simplify it down to a Boolean?
> 
> Ethernet is just supposed to work with any valid length of cable,
> KISS. So maybe we should try to keep this feature KISS. Just tell the
> driver it is a short cable, pick different defaults which should work
> with any short cable?
> 
> A boolean should also help with making this tunable reusable with
> other devices. It is unlikely any other devices have these same
> configuration options, unless it is from the same vendor.
> 
>       Andrew

The issue has been observed with very short or low‑loss
cables, typically in industrial or embedded setups where the cable is
below 3m or in a board-to-board setup.

 From our practical experience, this issue occurs in our setup where a 
very short CAT‑6e cable (~20cm) is used.
We were seeing random link dropouts with the default settings, and since 
enabling the workaround 2, the link has remained stable and we have not 
observed any further issues.

We don’t need all these configuration options.

According to the Microchip erratum, the user should try workaround 1 (EQ 
training), and if that does not resolve the random link dropouts,
fall back to workaround 2 by reducing the LPF bandwidth to 62MHz.

Since this procedure for determining which workaround is effective is 
inherently experimental and requires observation in real deployments, 
this is why I originally chose to expose the selection of the workaround 
to the user, at least allowing them to choose between workaround 1 and 
workaround 2.

regards

Fidelio




