Return-Path: <netdev+bounces-243600-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 9A923CA4670
	for <lists+netdev@lfdr.de>; Thu, 04 Dec 2025 17:06:10 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id F1E8D300EE5F
	for <lists+netdev@lfdr.de>; Thu,  4 Dec 2025 16:02:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4CBEB264617;
	Thu,  4 Dec 2025 16:02:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="WnBbGtRl"
X-Original-To: netdev@vger.kernel.org
Received: from mail-wm1-f41.google.com (mail-wm1-f41.google.com [209.85.128.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AA9321DF273
	for <netdev@vger.kernel.org>; Thu,  4 Dec 2025 16:02:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1764864176; cv=none; b=kkZ6zwy6SvpBtvKvbkqYROPEUdHuzAK8K2KXlnpAL3BoT9f8+6Z5ZSDE7yRDJCdo+EOfkGB1da3bYp33hXbtfmItKIzyovtFmxuVzc8HMLOK4Q/cT1a39yzhu8CSzx5j0K4M2uavkDntIZSNmTVOUIp14BmvTZoOiMSOQaxZuqQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1764864176; c=relaxed/simple;
	bh=m1ocXgSnpSBmxlKPIuVU08twZDtwLmgIjzhzzvF6m3w=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=RX+H9P6IYAdI/9Pwmah+OH/vhTQ/uJlF76sDBq8fuAW7joGvdcgzR+PcV8MyAJmY/bfkurJWxdJWuA6KtY8chA1c7vemLPZSsX8jDEpIguGTIdEQQXuovUHFY3nxisMVkRDEQ8KqobD+Jls2FALUpVsUVcq/UAH6x1e2JAeIVDo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=WnBbGtRl; arc=none smtp.client-ip=209.85.128.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f41.google.com with SMTP id 5b1f17b1804b1-4779ebfa91aso953015e9.3
        for <netdev@vger.kernel.org>; Thu, 04 Dec 2025 08:02:54 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1764864173; x=1765468973; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=jhOkEme3R2b0z1JToTf4scmIbojsMBoLPZmWVqYRzNs=;
        b=WnBbGtRlV3M5C2ZHIe2yYH/+1eo90Egqsn8KwYoUetlAoGGTieZHl2Spl8y9Cp4d07
         y8biJtETszAG1XmCcy4f5tnBa6ILpMAWs1HF009N/cE0sgT/D6kOVxWkzKssOkcKvXdx
         nAw0mUKUV7GVJwevgPjEXHPQG4RC/57GeaVU674kd71XLA4AMn79/gfZxW1mkAAnCzV9
         OFbeg7nHO/JQny+5gjNYbgTN+P5mqDNFFoVeZM/R+XMaMvVQtjSQITjVE+uwL7iE2FUq
         cuYAX2adgRWLYFbQk4MsLEgQnJ7aSfO0EwbCpOqz7tcUHjetYimH5HVtkPQN4p/SM9aN
         8XtA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1764864173; x=1765468973;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=jhOkEme3R2b0z1JToTf4scmIbojsMBoLPZmWVqYRzNs=;
        b=NmOSbQ4kLYN0urgFGEz+7Lqyej2xqkyzUzHIrBAMMLUDNQitBNGO/Jy5hGhn9jFbas
         woncqJmqwtwa2G5vyPFeKZACyiSP431N2exKO8MzJ2vi3ADeG1xcmKiXa4SUlfMb471D
         rvCIifdRxkLQajPnJ/N5aaslpW77QPvtlxOtnfRQ2WhgVubwMrvqbtqa/o5c/RZ4rmpb
         s9Is6ARO6Px89iGgJtdx/Td4vt5uYXXIGibpfTFoDjuC2fyHYkwAWmyYARPTcfP2Lsdg
         sm0N654azjcqP5EP4hCl7ZcQkr5Mcvg1x/6PjqdvRtrLpAcxzu40Z3R9glZJrwoxr+V/
         4ZKQ==
X-Forwarded-Encrypted: i=1; AJvYcCXUm89tImKdLh0a4LUnLxQCROSmhTHDi7vdXcFUrJFDI4UUNP81ZLIvvF8H5eO35GfwrFxMVIE=@vger.kernel.org
X-Gm-Message-State: AOJu0Yy7BmTtCXjCTLupvITxH88Ic+4mIGgyKvr9jk9hsRk9eu72M16R
	qkYSTNsPg5CganP8ivwTPAPzyEA370ADTk7IVlQC2Hu0jSKUnBTo8TJa
X-Gm-Gg: ASbGnctrTp54Xv6LumQAmLGuFmlDpslGSftxjvgc1jioMAan9WoblLwzlHzl2sEVYJ3
	yS3KFxwIJRgmiZh0ulh73qoAiMZpwJomkeRMf6lbdwzMkwdSegpgLKxvNb3L2A44Tb8LDBGpMF3
	Dfw+gY3YZAWQcmToS6axt8HOvCcUWd52VvQWhOfT10D8d1SrCn8crgLsHKiTaQ1z59ZS+MIFE0h
	x4njLZG4SFFH0/9gzuEgDLe7eloLu1NCBGZg++gibidQlffcCdAq+HXauhUPG6FM1UF6oXM61pj
	pRNdnbGJq6zTZqODPDHLnljzMb9MNOT6HmHvxnFRtYz+AvBpBhv3dBPLAbRLUvorTSELOfgKeSx
	u1fC2Pj0Q5Hn/i9g7SCIsePHrCqb8CQs7xJwZ36cViyXSibWAX/PW7FWmQvLRzWDbzjwlWixP9I
	bfpnXY4w8/UPyPBQ==
X-Google-Smtp-Source: AGHT+IHk5B99duQzZVP/Wufl2tAKzpvxK3UuoYOHJ/wpcMeiblvQQD75UaOGAiMjZDyGGJIQCl5ZZw==
X-Received: by 2002:a05:600c:45cd:b0:477:5b01:7d49 with SMTP id 5b1f17b1804b1-4792c909a62mr31833775e9.4.1764864172487;
        Thu, 04 Dec 2025 08:02:52 -0800 (PST)
Received: from skbuf ([2a02:2f04:d106:d600:dbb2:245d:2cf5:21d3])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-479308cd87csm40499885e9.0.2025.12.04.08.02.49
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 04 Dec 2025 08:02:51 -0800 (PST)
Date: Thu, 4 Dec 2025 18:02:47 +0200
From: Vladimir Oltean <olteanv@gmail.com>
To: Krzysztof Kozlowski <krzk@kernel.org>
Cc: Daniel Golle <daniel@makrotopia.org>, Frank Wunderlich <frankwu@gmx.de>,
	Andrew Lunn <andrew@lunn.ch>, Chen Minqiang <ptpt52@gmail.com>,
	Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Matthias Brugger <matthias.bgg@gmail.com>,
	AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>,
	"Chester A. Unal" <chester.a.unal@arinc9.com>,
	DENG Qingfang <dqfext@gmail.com>,
	Sean Wang <sean.wang@mediatek.com>, linux-kernel@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org,
	linux-mediatek@lists.infradead.org, netdev@vger.kernel.org
Subject: Re: [PATCH v3 2/2] net: dsa: mt7530: Use GPIO polarity to generate
 correct reset sequence
Message-ID: <20251204160247.yz42mnxvzhxas5jc@skbuf>
References: <20251129234603.2544-1-ptpt52@gmail.com>
 <20251129234603.2544-2-ptpt52@gmail.com>
 <0675b35f-217d-4261-9e3f-2eb24753d43c@lunn.ch>
 <20251130080731.ty2dlxaypxvodxiw@skbuf>
 <3fbc4e67-b931-421c-9d83-2214aaa2f6ed@lunn.ch>
 <0d85e1e6-ea75-4f20-aef1-90d446b4bfa1@kernel.org>
 <00f308a1-a4b1-4f20-8d8e-459ddf4c39b1@gmx.de>
 <aS7Zj3AFsSp2CTNv@makrotopia.org>
 <20251204131626.upw77jncqfwxydww@skbuf>
 <4170c560-1edd-4ff8-96af-a479063be4a5@kernel.org>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <4170c560-1edd-4ff8-96af-a479063be4a5@kernel.org>

On Thu, Dec 04, 2025 at 03:49:52PM +0100, Krzysztof Kozlowski wrote:
> On 04/12/2025 14:16, Vladimir Oltean wrote:
> > I get the feeling that we're complicating a simple solution because of a
> > theoretical "what if" scenario. The "NOT" gate is somewhat contrived
> 
> You downplay this case and suggest (if I get it right) that NOT gate is
> something unusual.
> 
>  I mentioned "line inverter" but it's not about NOT gate. There is no
> need for NOT gate at all, like some magical component which no one puts
> to the board. The only thing needed is just to pull the GPIO up or down,
> that's it. It's completely normal design thus it CAN happen.
> 
> Of course "can" does not mean it actually does, because certain
> configurations like powerdown-fail-safe are more likely and I am not an
> electric circuit designer to tell which one is better, but that
> downplaying does not help here.

I don't want to dismiss this comment, but I don't really understand it.
What do you mean by "line inverter", is it the component inside the GPIO
pin which makes it active low?

I thought that the premise of this patch set is that old device trees
are all (incorrectly) defined as GPIO_ACTIVE_HIGH, but someone familiar
with the matter needs to fact-check this statement.

Anyway, you and Andrew are talking about different things, you haven't
made it clear (or at least it wasn't clear to me) that the inverter you
are talking about isn't his NOT gate (that isn't described in the device
tree at all, as opposed to your inverter which would make the GPIO line
GPIO_ACTIVE_LOW - that's something verifiable).

> Just to clarify: I expect clear communication that some users will be
> broken with as good as you can provide analysis of the impact (which
> users). I only object the clame here "no one can ever pull down a GPIO
> line thus I handled all possible cases and made it backward compatible".
> 
> And that claim to quote was:
> "Therefore, regardless of whether a DTS is old or new, correct or
> incorrect, the driver now generates the correct electrical reset pulse."
> 
> which is 100% false and I am surprised how one could claim that.

Agree, the communication should be better.

