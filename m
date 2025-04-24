Return-Path: <netdev+bounces-185661-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C6218A9B437
	for <lists+netdev@lfdr.de>; Thu, 24 Apr 2025 18:36:51 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id ADD874A38F6
	for <lists+netdev@lfdr.de>; Thu, 24 Apr 2025 16:35:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 31104283C94;
	Thu, 24 Apr 2025 16:34:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b="QsjEl7Qn"
X-Original-To: netdev@vger.kernel.org
Received: from vps0.lunn.ch (vps0.lunn.ch [156.67.10.101])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0EE0C281501;
	Thu, 24 Apr 2025 16:34:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=156.67.10.101
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745512490; cv=none; b=VKMqNqT6aW6gOXHfyPPFXPBxRo8CuxqkOyTZFNQMF7/iUCRSyWX6JDaOUaW/cLn6pT7Aq6lsk2bm9e77FQ3DbER1t/IF8q14KKKdBAqBRjYQmUflqngRU/UhOPRGFacs8UJ2gSL+07s2NbTN0M7o14Bl4ZwY0mFlIeNj2QLvrUU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745512490; c=relaxed/simple;
	bh=M96IPY+EzvacNuH4fX06Yqiasq5DmKyDBU3sulBRIEg=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=k2y99kvzSc17kwPww16emjE7WPKQcnbN7u6+gLwCRgLqW3+hk8uglOFIj4G7UTaL1KUIJFdJTpgC7TNmHH6lasAzLeomo6RafSkPeCNPM1nyg5VKs8waxV2f951Hfi+0Y+JBZ8Gp2+BGBxQRwqSbTfbglzg2NUFaI5wAzduOzBI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch; spf=pass smtp.mailfrom=lunn.ch; dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b=QsjEl7Qn; arc=none smtp.client-ip=156.67.10.101
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lunn.ch
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=lunn.ch;
	s=20171124; h=In-Reply-To:Content-Disposition:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:From:Sender:Reply-To:Subject:
	Date:Message-ID:To:Cc:MIME-Version:Content-Type:Content-Transfer-Encoding:
	Content-ID:Content-Description:Content-Disposition:In-Reply-To:References;
	bh=3QlHbCdvw1igkueMu0uSmIH5VRamgRx4CVaOzdfiVtg=; b=QsjEl7QnZLPAkblIny2Svryot3
	SmK4EZuoXbaFk/lxyKlSSbueICIHUO1WA6eTa0DcLQQzcorRJQvHpE7HkN8nVfJV1dcyjYJd+oB0c
	ZIOtiefozx3M8H9vonepHByBs0OzBZyiLv3SisEgV/wxLhYl5aT24kJwh4X6SyEnGqw4=;
Received: from andrew by vps0.lunn.ch with local (Exim 4.94.2)
	(envelope-from <andrew@lunn.ch>)
	id 1u7zWv-00AURZ-SC; Thu, 24 Apr 2025 18:34:29 +0200
Date: Thu, 24 Apr 2025 18:34:29 +0200
From: Andrew Lunn <andrew@lunn.ch>
To: Ivan Vecera <ivecera@redhat.com>
Cc: netdev@vger.kernel.org, Vadim Fedorenko <vadim.fedorenko@linux.dev>,
	Arkadiusz Kubalewski <arkadiusz.kubalewski@intel.com>,
	Jiri Pirko <jiri@resnulli.us>, Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Prathosh Satish <Prathosh.Satish@microchip.com>,
	Lee Jones <lee@kernel.org>, Kees Cook <kees@kernel.org>,
	Andy Shevchenko <andy@kernel.org>,
	Andrew Morton <akpm@linux-foundation.org>,
	Michal Schmidt <mschmidt@redhat.com>, devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org, linux-hardening@vger.kernel.org
Subject: Re: [PATCH net-next v4 3/8] mfd: Add Microchip ZL3073x support
Message-ID: <4fae1a96-ac19-46b8-8eff-2a38d28414fc@lunn.ch>
References: <20250424154722.534284-1-ivecera@redhat.com>
 <20250424154722.534284-4-ivecera@redhat.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250424154722.534284-4-ivecera@redhat.com>

> +++ b/drivers/mfd/zl3073x-regs.h
> @@ -0,0 +1,74 @@
> +/* SPDX-License-Identifier: GPL-2.0-only */
> +
> +#ifndef __ZL3073X_REGS_H
> +#define __ZL3073X_REGS_H
> +
> +#include <linux/bitfield.h>
> +#include <linux/bits.h>
> +
> +/*
> + * Register address structure:
> + * ===========================
> + *  25        19 18   16 15     7 6           0
> + * +-------------------------------------------+
> + * | max_offset | width |  page  | page_offset |
> + * +-------------------------------------------+
> + *
> + * page_offset ... <0x00..0x7F>
> + * page .......... HW page number
> + * size .......... register byte size (1, 2, 4 or 6)
> + * max_offset .... maximal offset for indexed registers
> + *                 (for non-indexed regs max_offset == page_offset)
> + */

Something i missed earlier. This does not really describe
hardware. The upper half is meta data about the register, which you
encode into the register number.

How many other Linux drivers do you know about which does this?

Also width vs size.

	Andrew

