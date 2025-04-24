Return-Path: <netdev+bounces-185718-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 4DA3CA9B890
	for <lists+netdev@lfdr.de>; Thu, 24 Apr 2025 21:57:23 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 8285C1BA0557
	for <lists+netdev@lfdr.de>; Thu, 24 Apr 2025 19:57:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 642A5292911;
	Thu, 24 Apr 2025 19:57:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b="r1jNv8Ic"
X-Original-To: netdev@vger.kernel.org
Received: from vps0.lunn.ch (vps0.lunn.ch [156.67.10.101])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9990A28F533;
	Thu, 24 Apr 2025 19:57:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=156.67.10.101
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745524638; cv=none; b=T1VZsrUTULCxDyn6AHxi3uI3kAmHydRuRTxmfK7BG/YBzO+/e6BwXs7x7qe9OEiVhV8LjvMEiFRPdoOO8FmF+r5DoXPGLKVjPs9o7vjLSVPyJ9dGBNh5cZ92CUMQP37lnu2jQSMJARXVK0E6QNqcEQWL/dSbDqONykuvwzZPEcY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745524638; c=relaxed/simple;
	bh=NRwgx2wIZFBCCrj8injQQIzFF35dZesi/VSbvPbCVjs=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=F8eZqHA5VJV4cCmgZKUKxSixNJVjwbdTFnaOb9JiBfDsfaoPQwOKpwDN6SlHdExQ0m+XgO8bs5W7HkUrxpur5NZy9UEdyzOrVNb8V+EjhCk/ufv2+7EDPzcAcSleUSkk2sZFPOe/1LFKtA5bYNqGz647zWwS/qvLijfQu4hXURw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch; spf=pass smtp.mailfrom=lunn.ch; dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b=r1jNv8Ic; arc=none smtp.client-ip=156.67.10.101
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lunn.ch
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=lunn.ch;
	s=20171124; h=In-Reply-To:Content-Disposition:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:From:Sender:Reply-To:Subject:
	Date:Message-ID:To:Cc:MIME-Version:Content-Type:Content-Transfer-Encoding:
	Content-ID:Content-Description:Content-Disposition:In-Reply-To:References;
	bh=01Ud74uIYXdQOUIyMNvZgKEkYm/i2AyJKxEPo1ckeHk=; b=r1jNv8IcndBjQX84PVqT4QUiY1
	YlgEs8ImHGTjZFoFVb0/S8xE8TRY46mg5BprfPXHlkoZt22da10ooVM+PQ8gMN8SNSMpSzEtybEvW
	BPou4jjJXG72G7ZgRCPTcmIR3GVVhhpcDyii6/BCP0n+p5/7s8IOLQKbLQxSE18BCjaE=;
Received: from andrew by vps0.lunn.ch with local (Exim 4.94.2)
	(envelope-from <andrew@lunn.ch>)
	id 1u82gz-00AVZC-G0; Thu, 24 Apr 2025 21:57:05 +0200
Date: Thu, 24 Apr 2025 21:57:05 +0200
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
Subject: Re: [PATCH net-next v4 5/8] mfd: zl3073x: Add functions to work with
 register mailboxes
Message-ID: <34f29b17-dc68-4005-b2da-95fde34117a0@lunn.ch>
References: <20250424154722.534284-1-ivecera@redhat.com>
 <20250424154722.534284-6-ivecera@redhat.com>
 <5094e051-5504-48a5-b411-ed1a0d949eeb@lunn.ch>
 <bd645425-b9cb-454d-8971-646501704697@redhat.com>
 <8082254c-01a6-4aca-84de-76083fdcbb3b@lunn.ch>
 <ea9cd028-3d74-4d46-b355-a74ad549269b@redhat.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ea9cd028-3d74-4d46-b355-a74ad549269b@redhat.com>

On Thu, Apr 24, 2025 at 09:53:39PM +0200, Ivan Vecera wrote:
> 
> 
> On 24. 04. 25 9:18 odp., Andrew Lunn wrote:
> > > During taking 613cbb91e9ce ("media: Add MIPI CCI register access helper
> > > functions") approach I found they are using for these functions u64
> > > regardless of register size... Just to accommodate the biggest
> > > possible value. I know about weakness of 'void *' usage but u64 is not
> > > also ideal as the caller is forced to pass always 8 bytes for reading
> > > and forced to reserve 8 bytes for each read value on stack.
> > 
> > In this device, how are the u48s used? Are they actually u48s, or are
> > they just u8[6], for example a MAC address? The network stack has lots
> > of functions like:
> > 
> > eth_hw_addr_set(struct net_device *dev, const u8 *addr)
> 
> u48 registers always represent 48bit integer... they read from device using
> bulk read as big-endian 48bit int. The same is valid also for u16
> and u32.

Then a u64 makes sense, plus on write to hardware a check the upper
bits are 0. These u48s are going to be stored in a u64 anyway, since C
does not have a u48 type.

But all the other types do exist in C, so you should use them and have
type checking.

	Andrew

