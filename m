Return-Path: <netdev+bounces-243565-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [104.64.211.4])
	by mail.lfdr.de (Postfix) with ESMTPS id 361B8CA3C1C
	for <lists+netdev@lfdr.de>; Thu, 04 Dec 2025 14:16:45 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id 9624930093AA
	for <lists+netdev@lfdr.de>; Thu,  4 Dec 2025 13:16:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C6EDD34320D;
	Thu,  4 Dec 2025 13:16:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="aWc+T2ID"
X-Original-To: netdev@vger.kernel.org
Received: from mail-wm1-f50.google.com (mail-wm1-f50.google.com [209.85.128.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9F72834321C
	for <netdev@vger.kernel.org>; Thu,  4 Dec 2025 13:16:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1764854194; cv=none; b=N47L7kZJjpeD/pkVbSvu7vHg9t2NWnsNroNBd9BUH0hREyXSCWTYzQxTKQa1cTMOvYHa7znDg1UZinIdbU+jhUD17EjKZZEzYjAuYAD+9tQUpHravIWIf4xXXddffG4Hh7tMDSPB0pJ1ekqwzbF1qGA7dQd8DPRUsLB15R+fkSY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1764854194; c=relaxed/simple;
	bh=ymD7CjPmg3qsC45dQiKE4M9c8rkpcPb6ZIbp9+hlNlA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=OjGqd8yhOQLRAQqJiqO93SQWVixcnvhVQwsdti5AgyylNrsWV9vVph1BNNSu0xqhj3YM0KcbaXqxaasH+b3DhiRnsy2M8IjL7QaUlrTzbJRZLje9Aeh0NJwpLKh3WGEEk24uUvngBBIaVdkA19BwD+1tob5JbpGwQkeSmZNH5jQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=aWc+T2ID; arc=none smtp.client-ip=209.85.128.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f50.google.com with SMTP id 5b1f17b1804b1-4790f0347bfso869695e9.1
        for <netdev@vger.kernel.org>; Thu, 04 Dec 2025 05:16:32 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1764854191; x=1765458991; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=cYBPcepONpHvCLLvCGFW5DmNEw2yqgttigWufQoSyCA=;
        b=aWc+T2IDAGYG6loMDemmy4Un8aKqTfZviGI4Ldet1W4bzhQZK+2WABxw6jTMO57uVi
         zmfFgYfRiP+KfXp+xA7LiCjIxt5xAdmmzJoo6Ihg5D11tuDoQTYvgUWZoxjkDERlW/Ln
         B3pbFn2P8FuYQj7THM4NYs/i4gv0mDVu3Ry4cLrPWgws8xZX5FOn4XqebT0t9eQIFYdC
         f2DmcA0M7Q4Yja2qTA357Gj5LW+aejJ9EIwYKsd4lHXQGlv79UG9S9VI8qU1cPPCwhMr
         Uwi5bW53mR0a9r3rieMcPiJSKTLwsCTYwFEoxx4YOyx2abMqxBxZcDLtesHPbVJIivOu
         zSHA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1764854191; x=1765458991;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=cYBPcepONpHvCLLvCGFW5DmNEw2yqgttigWufQoSyCA=;
        b=Z8zOH3O8jDHtJRSqM+TVu4dP0REyHS+oTQ0WNl0PlXLacqdzVt9V0Z/gFHuWDEi2sY
         J+/zHgSu4bSq61YLvA2vDLFTYj5dca4xfrVNaX2nkDoiVKpwMzQ47rkELd+LTCOrlXIM
         J3oxCFBBCd3RmiDnxhE6dCkKaj4WzVSa5ChVwrPt6OTo+nguo/ey4nxAbs/aODn5FN5H
         HGMmVyXuyQQFXAqXAG3K19MDmaFiiBOYWsMXvR35FXTgkELh+YEqL1bWTDU/nxCU+8Is
         PUnY+iUIFd06EJ/kVuYUIGlFeDRCfhoFiK4Whu/Hd16tQkkfliRFhlM7g+OIDrj+SUDn
         T1FQ==
X-Forwarded-Encrypted: i=1; AJvYcCVRBQowQcYDFeZVZJ0g3aEpaBQiFgJ0r5ZyHA9hNqO0HcYksSq+/NHC2K5XELUFGy6E9WJQbEA=@vger.kernel.org
X-Gm-Message-State: AOJu0Yy3D4orUcJtjF6ugpt+dGdlwKHn5SQUVJ87KL+CTuBZH8CSCTUt
	1B095kjZm6GY5l4KrxBdesjXVrOkN3HfmZLHR2HVCoLpNEPFES/jwlxv
X-Gm-Gg: ASbGncuzq8C/1W/x3vxsyONnPlfTIkd25Gt2X0OZ2DnsICYGiZCdM/KWiBZzDHgRbdv
	Ad//vKJkJZRy5oRLu+dYJqptlbwirRTq7LG5kN7rqRvHoHk0Ux7wtl1mxjWpYCXOQTXqynL7Kq+
	DiIhFZG9kigH6vpE+cglrZ762hdRh+gYTXPwJSiNzrlCELqfzUsx6olZ0PW8kZanml+PMncgkUo
	2FaYUIe1+tyjLUGlpYqK74DlthP0KpuN3p4EG3OKzuS29JB5ph+gulqcDhnGZMWvN3S8a4fbBPI
	K1/jpFcDEQHMrRR+US7yzIPcXy2M34I4gXhsB4uPSavNI0i+EQZpnS9xfBrYRTMaVY6YTLeRStA
	dxE8R72d1UxdHbHk7gnxmvAjCwLmsx0Lov82I0bsTcBCyeSmoloDIhrecFx5UqBM22+em9WCiI5
	smUMM=
X-Google-Smtp-Source: AGHT+IFuZ7+wVEvS7Cd555ZEuGrZTUFUukCrdVsUSca1c9TMkHOJ8JsWJb68xbR/p3vOu4Jb3bTkMw==
X-Received: by 2002:a05:6000:2f86:b0:42b:3e0a:64b9 with SMTP id ffacd0b85a97d-42f756a2d9amr3255858f8f.6.1764854190568;
        Thu, 04 Dec 2025 05:16:30 -0800 (PST)
Received: from skbuf ([2a02:2f04:d106:d600:dbb2:245d:2cf5:21d3])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-42f7cbe9032sm2926996f8f.1.2025.12.04.05.16.28
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 04 Dec 2025 05:16:29 -0800 (PST)
Date: Thu, 4 Dec 2025 15:16:26 +0200
From: Vladimir Oltean <olteanv@gmail.com>
To: Daniel Golle <daniel@makrotopia.org>
Cc: Frank Wunderlich <frankwu@gmx.de>,
	Krzysztof Kozlowski <krzk@kernel.org>, Andrew Lunn <andrew@lunn.ch>,
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
Message-ID: <20251204131626.upw77jncqfwxydww@skbuf>
References: <20251129234603.2544-1-ptpt52@gmail.com>
 <20251129234603.2544-2-ptpt52@gmail.com>
 <0675b35f-217d-4261-9e3f-2eb24753d43c@lunn.ch>
 <20251130080731.ty2dlxaypxvodxiw@skbuf>
 <3fbc4e67-b931-421c-9d83-2214aaa2f6ed@lunn.ch>
 <0d85e1e6-ea75-4f20-aef1-90d446b4bfa1@kernel.org>
 <00f308a1-a4b1-4f20-8d8e-459ddf4c39b1@gmx.de>
 <aS7Zj3AFsSp2CTNv@makrotopia.org>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <aS7Zj3AFsSp2CTNv@makrotopia.org>

On Tue, Dec 02, 2025 at 12:20:31PM +0000, Daniel Golle wrote:
> On Tue, Dec 02, 2025 at 12:52:44PM +0100, Frank Wunderlich wrote:
> > Hi,
> > 
> > Am 01.12.25 um 08:48 schrieb Krzysztof Kozlowski:
> > > On 30/11/2025 21:17, Andrew Lunn wrote:
> > > > On Sun, Nov 30, 2025 at 10:07:31AM +0200, Vladimir Oltean wrote:
> > > > > On Sun, Nov 30, 2025 at 02:11:05AM +0100, Andrew Lunn wrote:
> > > > > > > -		gpiod_set_value_cansleep(priv->reset, 0);
> > > > > > > +		int is_active_low = !!gpiod_is_active_low(priv->reset);
> > > > > > > +		gpiod_set_value_cansleep(priv->reset, is_active_low);
> > > > > > I think you did not correctly understand what Russell said. You pass
> > > > > > the logical value to gpiod_set_value(). If the GPIO has been marked as
> > > > > > active LOW, the GPIO core will invert the logical values to the raw
> > > > > > value. You should not be using gpiod_is_active_low().
> > > > > > 
> > > > > > But as i said to the previous patch, i would just leave everything as
> > > > > > it is, except document the issue.
> > > > > > 
> > > > > > 	Andrew
> > > > > > 
> > > > > It was my suggestion to do it like this (but I don't understand why I'm
> > > > > again not in CC).
> > > > > 
> > > > > We _know_ that the reset pin of the switch should be active low. So by
> > > > > using gpiod_is_active_low(), we can determine whether the device tree is
> > > > > wrong or not, and we can work with a wrong device tree too (just invert
> > > > > the logical values).
> > > > Assuming there is not a NOT gate placed between the GPIO and the reset
> > > > pin, because the board designer decided to do that for some reason?
> > jumping in because i prepare mt7987 / BPI-R4Lite dts for upstreaming when
> > driver-changes are in.
> > With current driver i need to define the reset-gpio for mt7531 again wrong
> > to get it
> > working. So to have future dts correct, imho this (or similar) change to
> > driver is needed.
> > 
> > Of course we cannot simply say that current value is wrong and just invert
> > it because of
> > possible "external" inversion of reset signal between SoC and switch.
> > I have to look on schematics for the boards i have (BPI-R64, BPI-R3,
> > BPI-R2Pro) if there is such circuit.
> 
> I'm also not aware of any board which doesn't directly connect the
> reset of the MT7530 to a GPIO pin of the SoC. For MediaTek's designs
> there is often even a specific pin desginated for this purpose and
> most vendors do follow this. If they deviate at all, then it's just
> that a different pin is used for the switch reset, but I've never
> seen any logic between the SoC's GPIO pin and the switch reset.
> 
> > Maybe the mt7988 (mt7530-mmio) based boards also affected?
> 
> There is no GPIO reset for switches which are integrated in the SoC,
> so this only matters for external MT7530 and MT7531 ICs for which an
> actual GPIO line connected to the SoC is used to reset the switch.

I get the feeling that we're complicating a simple solution because of a
theoretical "what if" scenario. The "NOT" gate is somewhat contrived
given the fact that most GPIOs can already be active high or low, but OK.

If this is blocking progress for new device trees, can we just construct,
using of_machine_is_compatible(), a list of all boards where the device
tree defines incorrect reset polarity that shouldn't be trusted by the
driver when driving the reset GPIO? If we do this, we can also leave
those existing device trees alone.

