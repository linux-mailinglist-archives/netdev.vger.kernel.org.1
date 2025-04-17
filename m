Return-Path: <netdev+bounces-183763-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id CCD68A91DBC
	for <lists+netdev@lfdr.de>; Thu, 17 Apr 2025 15:23:10 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 67747188AA68
	for <lists+netdev@lfdr.de>; Thu, 17 Apr 2025 13:23:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DAB3C24C082;
	Thu, 17 Apr 2025 13:22:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b="mAd01pPq"
X-Original-To: netdev@vger.kernel.org
Received: from vps0.lunn.ch (vps0.lunn.ch [156.67.10.101])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0055124BBE0;
	Thu, 17 Apr 2025 13:22:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=156.67.10.101
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744896144; cv=none; b=rHW2EtIBaKRwt2OMpn+aFZhiNSZnrXzoTsaih6MSjb2j1/XRwRreFwHvPnXSRTmWI6HB+xTRQ2kO34E15Cku7i4ypqeXM3huqdhV4eURTfEKOHJH3j+jT084C4Z2okZe4l5Pgs/cS7juWjAMsUTsUWifwnLbrrDwrb/oXsGEoT4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744896144; c=relaxed/simple;
	bh=9q45jsPx00bo1vLeH9HM+/YCz9B4wS4P7ar954yTx20=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Evs+hlRNlD3YaxlVZ+YDoR/1eGnmXgK9Qv23P+w001Dlrtd3JKdYbTkqI/xp9ASe0Xi3iB1cuGgWNKbpiX+D9vHuJWIbQdmwvU7CSxrLY3ZTch+LSkWXj8sz057/vmgG9zx5CyJ3KuvobuSlTw4TkpZNRG3hJWwxS4ZYQ55Ny+k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch; spf=pass smtp.mailfrom=lunn.ch; dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b=mAd01pPq; arc=none smtp.client-ip=156.67.10.101
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lunn.ch
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=lunn.ch;
	s=20171124; h=In-Reply-To:Content-Disposition:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:From:Sender:Reply-To:Subject:
	Date:Message-ID:To:Cc:MIME-Version:Content-Type:Content-Transfer-Encoding:
	Content-ID:Content-Description:Content-Disposition:In-Reply-To:References;
	bh=MCamaocuimbhmfsH5oDiWfOn4qDIn9MqndMJRqcqllc=; b=mAd01pPqpppMGiM+2D+IT1BnSt
	JwoiZDe5+gIvYpl7dFSOPo3p7FfddwdWTMHdASmG6X4oTKsXL9VzgRIf1pGRckynurZG1cvAXu/Kr
	Twdq37wNUT+JQ+0TFCV/bbeJey7TBRWdJOlkPC5V1ouCuIV2sHtTgM4L8j8JGFP/ivdU=;
Received: from andrew by vps0.lunn.ch with local (Exim 4.94.2)
	(envelope-from <andrew@lunn.ch>)
	id 1u5PC0-009mnk-N8; Thu, 17 Apr 2025 15:22:12 +0200
Date: Thu, 17 Apr 2025 15:22:12 +0200
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
Subject: Re: [PATCH v3 net-next 5/8] mfd: zl3073x: Add functions to work with
 register mailboxes
Message-ID: <8802b276-b6dd-4235-87dd-18b835edb196@lunn.ch>
References: <20250416162144.670760-1-ivecera@redhat.com>
 <20250416162144.670760-6-ivecera@redhat.com>
 <d286dec9-a544-409d-bf62-d2b84ef6ecd4@lunn.ch>
 <CAAVpwAvVO7RGLGMXCBxCD35kKCLmZEkeXuERG0C2GHP54kCGJw@mail.gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAAVpwAvVO7RGLGMXCBxCD35kKCLmZEkeXuERG0C2GHP54kCGJw@mail.gmail.com>

> > > +/*
> > > + * Mailbox operations
> > > + */
> > > +int zl3073x_mb_dpll_read(struct zl3073x_dev *zldev, u8 index);
> > > +int zl3073x_mb_dpll_write(struct zl3073x_dev *zldev, u8 index);
> > > +int zl3073x_mb_output_read(struct zl3073x_dev *zldev, u8 index);
> > > +int zl3073x_mb_output_write(struct zl3073x_dev *zldev, u8 index);
> > > +int zl3073x_mb_ref_read(struct zl3073x_dev *zldev, u8 index);
> > > +int zl3073x_mb_ref_write(struct zl3073x_dev *zldev, u8 index);
> > > +int zl3073x_mb_synth_read(struct zl3073x_dev *zldev, u8 index);
> > > +int zl3073x_mb_synth_write(struct zl3073x_dev *zldev, u8 index);
> >
> > I assume these are the only valid ways to access a mailbox?
> >
> > If so:
> >
> > > +static inline __maybe_unused int
> > > +zl3073x_mb_read_ref_mb_mask(struct zl3073x_dev *zldev, u16 *value)
> > > +{
> > > +     __be16 temp;
> > > +     int rc;
> > > +
> > > +     lockdep_assert_held(&zldev->mailbox_lock);
> > > +     rc = regmap_bulk_read(zldev->regmap, ZL_REG_REF_MB_MASK, &temp,
> > > +                           sizeof(temp));
> > > +     if (rc)
> > > +             return rc;
> > > +
> > > +     *value = be16_to_cpu(temp);
> > > +     return rc;
> > > +}
> >
> > These helpers can be made local to the core. You can then drop the
> > lockdep_assert_held() from here, since the only way to access them is
> > via the API you defined above, and add the checks in those API
> > functions.
> 
> This cannot be done this way... the above API just simplifies the
> operation of read and write latch registers from/to mailbox.
> 
> Whole operation is described in the commit description.
> 
> E.g. read something about DPLL1
> 1. Call zl3073x_mb_dpll_read(..., 1)
>    This selects DPLL1 in the DPLL mailbox and performs read operation
> and waits for finish
> 2. Call zl3073x_mb_read_dpll_mode()
>    This reads dpll_mode latch register
> 
> write:
> 1. Call zl3073x_mb_write_dpll_mode(...)
>    This writes mode to dpll_mode latch register
> 2. Call zl3073x_mb_dpll_read(..., 1)
>    This writes all info from latch registers to DPLL1
> 
> The point is that between step 1 and 2 nobody else cannot touch
> latch_registers or mailbox select register and op semaphore.

Again, think about your layering. What does your lower level mailbox
API look like? What does the MFD need to export for a safe API?

So maybe you need zl3073x_mb_read_u8(), zl3073x_mb_read_u16(),
zl3073x_mb_read_u32(), as part of your mailbox API. These assert the
lock is held.

You could even make zl3073x_mb_read_u8() validate the register is in
the upper range, and that zl3073x_read_u8() the register is in the
lower range.

	Andrew

