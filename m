Return-Path: <netdev+bounces-181435-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E848CA84FE5
	for <lists+netdev@lfdr.de>; Fri, 11 Apr 2025 00:57:20 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id DF0604A66C7
	for <lists+netdev@lfdr.de>; Thu, 10 Apr 2025 22:57:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7EC5820F065;
	Thu, 10 Apr 2025 22:57:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="hjea6f97"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4B64420C470;
	Thu, 10 Apr 2025 22:57:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744325832; cv=none; b=cjlYfvXW0ffgcg9Bm0lc6Kj7tBru6RZ8cAd3XXjC1f1WAw2iE6yrIIfsluYtL/0CcHBoe5YYIodXp0HXib8TYzrP5vgsscxuqHw2yKACn1i0dC3u7wBrIRLVE9A/9CkmumXH4IUwEqDMxlEUwIIZiYEJEJvKtKn89ayJOnOmIIk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744325832; c=relaxed/simple;
	bh=dFjSj+0XP33Tq5fvO9OJcLGRfVuicnfCNBFxi1smsew=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=IDLMhQy9kX5/WQZu1I2PzDhFLrG5u+8Da4ML/zvPmdb4R60mFdbVMZuHAPbrokniulhoUezwtzjAtLKymRSkIQNR9CIHaeG7ezwhoImlb+3JY27g+R5tGea+MbMVLZA+AKvhQ4QeI1AH3pgdNoGyPY4sH70DGGV0YngyAjf903A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=hjea6f97; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0CC36C4CEDD;
	Thu, 10 Apr 2025 22:57:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1744325831;
	bh=dFjSj+0XP33Tq5fvO9OJcLGRfVuicnfCNBFxi1smsew=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=hjea6f97bl1ND8IhXBcyyoRfCD5qyNUa4prZrat/d6tm9yWKT4pkXtP++59cIxb0o
	 sT9Bjc5amMt9BwUuK/ahI5rMyvwJknMAjNLX3fwRUzTPUgU3gcQbakEYvlb4MXFJvG
	 xL/tXnxhNMNGSjRqI/j7Odg9jxIiNtq57ogvv4lhfwWY5+KQzHfFf+ayMfUJCZqw1w
	 ihd4gEOrNJWZob8ZcnkhWDwATFUMVbmmM9se7uA8OKQe2e0q7v+U9X7Lfr5wwZVk4q
	 SKM/jLFstYNok683XRkde4V8zvEg6TIWEzAtCOYsZ49z5VxJQ1knS9ydGKLhtjaKNk
	 gqs1U7EB1PsiQ==
Date: Thu, 10 Apr 2025 15:57:10 -0700
From: Jakub Kicinski <kuba@kernel.org>
To: Ivan Vecera <ivecera@redhat.com>
Cc: netdev@vger.kernel.org, Vadim Fedorenko <vadim.fedorenko@linux.dev>,
 Arkadiusz Kubalewski <arkadiusz.kubalewski@intel.com>, Jiri Pirko
 <jiri@resnulli.us>, Rob Herring <robh@kernel.org>, Krzysztof Kozlowski
 <krzk+dt@kernel.org>, Conor Dooley <conor+dt@kernel.org>, Prathosh Satish
 <Prathosh.Satish@microchip.com>, Lee Jones <lee@kernel.org>, Kees Cook
 <kees@kernel.org>, Andy Shevchenko <andy@kernel.org>, Andrew Morton
 <akpm@linux-foundation.org>, Michal Schmidt <mschmidt@redhat.com>,
 devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
 linux-hardening@vger.kernel.org
Subject: Re: [PATCH v2 00/14] Add Microchip ZL3073x support (part 1)
Message-ID: <20250410155710.067a97f7@kernel.org>
In-Reply-To: <889e68eb-d5b5-41ae-876d-9efc45416db6@redhat.com>
References: <20250409144250.206590-1-ivecera@redhat.com>
	<20250409171713.6e9fb666@kernel.org>
	<889e68eb-d5b5-41ae-876d-9efc45416db6@redhat.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Thu, 10 Apr 2025 11:18:24 +0200 Ivan Vecera wrote:
> On 10. 04. 25 2:17 dop., Jakub Kicinski wrote:
> > On Wed,  9 Apr 2025 16:42:36 +0200 Ivan Vecera wrote:  
> >> Add support for Microchip Azurite DPLL/PTP/SyncE chip family that
> >> provides DPLL and PTP functionality. This series bring first part
> >> that adds the common MFD driver that provides an access to the bus
> >> that can be either I2C or SPI.
> >>
> >> The next series will bring the DPLL driver that will covers DPLL
> >> functionality. And another ones will bring PTP driver and flashing
> >> capability via devlink.
> >>
> >> Testing was done by myself and by Prathosh Satish on Microchip EDS2
> >> development board with ZL30732 DPLL chip connected over I2C bus.  
> > 
> > The DPLL here is for timing, right? Not digital logic?
> > After a brief glance I'm wondering why mfd, PHC + DPLL
> > is a pretty common combo. Am I missing something?  
> 
> Well, you are right, this is not pretty common combo right now. But how 
> many DPLL implementations we have now in kernel?
> 
> There are 3 mlx5, ice and ptp_ocp. The first two are ethernet NIC 
> drivers that re-expose (translate) DPLL API provided by their firmwares 
> and the 3rd timecard that acts primarily as PTP clock.
> 
> Azurite is primarly the DPLL chip with multiple DPLL channels and one of 
> its use-case is time synchronization or signal synchronization. Other 
> one can be PTP clock and even GPIO controller where some of input or 
> output pins can be configured not to receive or send periodic signal but 
> can act is GPIO inputs or outputs (depends on wiring and usage).
> 
> So I have taken an approach to have common MFD driver that provides a 
> synchronized access to device registers and to have another drivers for 
> particular functionality in well bounded manner (DPLL sub-device (MFD 
> cell) for each DPLL channel, PTP cell for channel that is configured to 
> provide PTP clock and potentially GPIO controller cell but this is 
> out-of-scope now).

Okay, my understanding was that if you need to reuse the component
drivers across multiple different SoCs or devices, and there is no
"natural" bus then MFD is the go to. OTOH using MFD as a software
abstraction/to organize your code is a pointless complication.
(We're going to merge the MFD parts via Lee's tree and the all actual
drivers via netdev?) Admittedly that's just my feeling and not based 
on any real info or experience. I defer to Lee and others to pass
judgment.

