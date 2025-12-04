Return-Path: <netdev+bounces-243664-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id A24D2CA4E87
	for <lists+netdev@lfdr.de>; Thu, 04 Dec 2025 19:21:40 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 61A883034EE9
	for <lists+netdev@lfdr.de>; Thu,  4 Dec 2025 18:21:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9208635F8BA;
	Thu,  4 Dec 2025 18:21:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="kKJDvS7u"
X-Original-To: netdev@vger.kernel.org
Received: from mail-wr1-f49.google.com (mail-wr1-f49.google.com [209.85.221.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CF7951DF970
	for <netdev@vger.kernel.org>; Thu,  4 Dec 2025 18:21:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1764872498; cv=none; b=hiyli+BpdKpPjP8SxdmHnNE9eJs37rmRO2cE7zw/sfhLHVGnGkpAK52GZJMv1lxovTlOzQgXYySbXTmAjM25rEAI2PTJcWhn1p2139oOLtgAqiQHIELcUh68xcl9e+p9bAkN5g+fs2PMKSOt0h1dKcCFStxilPHeKLiFmI4/NjI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1764872498; c=relaxed/simple;
	bh=qXK4lVZdMwCgMQa59PFr2Cz3cQJN74HoY3VDwQdfNlA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=lQBaNDThwRRoZloLpcd3XSDf+fd8T8NHXUed6N5FYDKNF/hasx71cfoj+WChutbeJOU97T6ISDBYVcdBmaVCB1xkNWrXYj9G5gmFS1VBrH+yzbLKF8kdZ+Nx0/qNUcgQOCtf7W7rXeyisoNdlzuGV1sLkrMWteszSKCg12LnS6E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=kKJDvS7u; arc=none smtp.client-ip=209.85.221.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wr1-f49.google.com with SMTP id ffacd0b85a97d-42b2de74838so79921f8f.2
        for <netdev@vger.kernel.org>; Thu, 04 Dec 2025 10:21:36 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1764872495; x=1765477295; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=fv8P+6IVWvIL0bC+f9n0QNbXSqmfD+me3uZoZ0RY/2g=;
        b=kKJDvS7uEgx0mulgRjPSlFmNt5psY8+La9zRSAcibC4/PyUrswchIo7kXLy0YqtXK5
         Zl5Ix3XShzqnkBCtNf9GjAomS37L5EFnReN4AyGaEEJMt4CQq4H/TX8HmHHFzJQdxpX4
         0dLhZiwuYXb8aEEqRS/k2m711jS2s3l7IOzugbgS9Luv/xv+2YBWzArvzdR6Pn0YvIcU
         KT5ch44suXiGKHjhetNGIwE0AGijF1srnb/Ztl8Ko4+snDZn03qkItieuWKvQQreT+Zm
         IsTy6fHabrRKWt54xy09MR62Wum+b21gjxWKL28rx7C6O+Mmrw+6L4VwMJtXucuot1Pr
         AzwA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1764872495; x=1765477295;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=fv8P+6IVWvIL0bC+f9n0QNbXSqmfD+me3uZoZ0RY/2g=;
        b=q5YZPVKHCj6OgJUaSHR/gJMRxcYOryg5pL70F5PhCl/uaJKrKXQYNGHZp2AaBFItcb
         yfHtUtaNHzK2uEISeJn4GB8zPpKm1O2UjfmmzoRYD2EX4R89hErHQQ//gGSo48ru6anv
         EzKILFTXVqlwZmvOQ15bbxzyyq8Svz+4FRE78X0hRf6SbnjeJYF72Xc/sDEGR1h3XRjg
         mwbnN7c6XjRprLsDpXArz4cWUO0OMtOHHvn4b6bxKIaWqvHfdIyaLBGOApdhPIcJJCf8
         JCtn/zHJwBZ4coHmlj8fWzqJHwAH+yrWt3JZ3KitC4xsNCd3nVdP8sMr45rzO2SsowLK
         60QA==
X-Forwarded-Encrypted: i=1; AJvYcCWxHjKIgEWw6vVtz3TG5ZFlVE6GXV389J8mZk9ZjmjA/+sTLb9MiEh0NivlvrSiRQO9qVEeXa0=@vger.kernel.org
X-Gm-Message-State: AOJu0YyhKsqZNTJc1VkSNVFe0pXbQeDeFXWjPjUv8SOhw7ZUkW11Z9dT
	h4tNuk5jGWSH6504j2X6kOhTVVWOfwOB0M1Kgrev5lYa6CdVgVhE2ixY
X-Gm-Gg: ASbGncsF2DN2Q+29AU+NqJAfplLJOlb4Tu8f9RpnoiQ3WxB2DWE8qrU7e5UWEJm6Lk2
	wErkc4HzMdFKNOghggv7uzZeRbxRTV52UJP68w+wLITbdSxPiwKzpolNj2PR77CpHVCNDH3imNd
	f9Jj0X3YgPUVnJ5/trw4jeehWblnymgQXkvaM6CJ2qf4/nlXpQsXZs6/DWAfk3CASAC5NavvNmq
	xJ7r4CeEf+Y/7M41jI5csAco2SlST+4oRbTIY06fkVzyBXPDwOBrQPFGoIP5R268UFmOHRajE9/
	OKC7dDMb0ol2SYOv6wq7NOUqYEQVZ7/UgFcWAFREqRBtZvxiM1EtSoGpHOdVaqcHvT6Au/CJ0gM
	vUlS9ilmwV+xv3EwX8s9xbE5kB+WS4qGQAJxzRiYh4VdDs6wrTGHjzwxnpsfKgG9mv+NQDbiHuM
	VOYcQ=
X-Google-Smtp-Source: AGHT+IEzgG4TzCJXxABGuutxcIrI+o/G6IuaOtE2bigp/vNM2WwpcI6tNhb5bLyGJf4XeLf7rYmrFA==
X-Received: by 2002:a05:600c:8b42:b0:46f:ab96:58e9 with SMTP id 5b1f17b1804b1-4792ae634e8mr38393335e9.0.1764872494836;
        Thu, 04 Dec 2025 10:21:34 -0800 (PST)
Received: from skbuf ([2a02:2f04:d106:d600:dbb2:245d:2cf5:21d3])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-479308cd87csm45669115e9.0.2025.12.04.10.21.32
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 04 Dec 2025 10:21:34 -0800 (PST)
Date: Thu, 4 Dec 2025 20:21:31 +0200
From: Vladimir Oltean <olteanv@gmail.com>
To: "Russell King (Oracle)" <linux@armlinux.org.uk>
Cc: Krzysztof Kozlowski <krzk@kernel.org>,
	Daniel Golle <daniel@makrotopia.org>,
	Frank Wunderlich <frankwu@gmx.de>, Andrew Lunn <andrew@lunn.ch>,
	Chen Minqiang <ptpt52@gmail.com>, Rob Herring <robh@kernel.org>,
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
Message-ID: <20251204182131.gfqwy566gjzd7dbx@skbuf>
References: <0d85e1e6-ea75-4f20-aef1-90d446b4bfa1@kernel.org>
 <00f308a1-a4b1-4f20-8d8e-459ddf4c39b1@gmx.de>
 <aS7Zj3AFsSp2CTNv@makrotopia.org>
 <20251204131626.upw77jncqfwxydww@skbuf>
 <4170c560-1edd-4ff8-96af-a479063be4a5@kernel.org>
 <20251204160247.yz42mnxvzhxas5jc@skbuf>
 <66d080f1-e989-451f-9d5e-34460e5eb1b0@kernel.org>
 <20251204171159.yy3nkvzttxecmhfo@skbuf>
 <178afbeb-168f-4765-bb0b-fad0bcd29382@kernel.org>
 <aTHIulPW055AyLW_@shell.armlinux.org.uk>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <aTHIulPW055AyLW_@shell.armlinux.org.uk>

On Thu, Dec 04, 2025 at 05:45:30PM +0000, Russell King (Oracle) wrote:
> It would make sense if a single GPIO pin is used for resetting
> several devices, some of them with an active-high reset input and
> others with active-low.
> 
> What matters for a GPIO pin used to source a reset signal is "what
> is the active level at the GPIO pin for the reset to be asserted to
> the connected device(s)."
> 
> If we have a device that requires an active-low reset input, but there
> is some form of inversion in the path to that input from a GPIO, then
> the GPIO _should_ be marked active-high. If the same active-low reset
> input is connected directly to a GPIO, the GPIO _should_ be marked as
> active-low. Thus, to assert reset, writing '1' through
> gpiod_set_value() _should_ assert the reset input on the target device
> in both cases.
> 
> This is why gpiolib supports software inversion - so software engineers
> can think in terms of positive non-inverted logic when programming
> GPIOs.

Thanks for this message, to me it brought new info which I didn't
consider before, which is that if there are *future* boards where some
sort of inversion on the reset signal (likely due to it being shared as
you say), they should be described as GPIO_ACTIVE_HIGH, but this patch
locks us out of that possibility.

If I may bring one more data point into the discussion: the switch
binding specifically requests not to describe shared reset lines
(because unrelated drivers might reset the switch after it probed):

  reset-gpios:
    description: |
      GPIO to reset the switch. Use this if mediatek,mcm is not used.
      This property is optional because some boards share the reset line with
      other components which makes it impossible to probe the switch if the
      reset line is used.

so I guess that the probability for a reset signal inversion, even if
it exists, to cause problems in the GPIO_ACTIVE_HIGH reinterpretation,
is still low, albeit for a completely different reason than the one I
initially claimed (which is bogus and Krzysztof was right to challenge it).

> Sadly, we keep having people mark active-low signals as "active high"
> in DT, and then have to write '0' to assert the signal. These people
> basically don't understand electronics and/or our GPIO model.

This is the case we seem to be in.

On a scale of safety, having quirks for the affected device trees still
ranks a bit higher, though.

