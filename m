Return-Path: <netdev+bounces-181974-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 33F83A873B3
	for <lists+netdev@lfdr.de>; Sun, 13 Apr 2025 21:51:14 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 66A96188EBD9
	for <lists+netdev@lfdr.de>; Sun, 13 Apr 2025 19:51:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4AB491F2380;
	Sun, 13 Apr 2025 19:51:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b="FDAD/u5Q"
X-Original-To: netdev@vger.kernel.org
Received: from vps0.lunn.ch (vps0.lunn.ch [156.67.10.101])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7137D64A98;
	Sun, 13 Apr 2025 19:51:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=156.67.10.101
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744573869; cv=none; b=Pg4icViC7LCYVgUgMjcLNOB4g3TyIs9s52GkX+vp4Ck+bzSWCxFjwRVbYpjpyn+Ruw+Vtklhz0IC3QCJxDD/k24B7ddz00/9Q8iK1jI+NSSzhxMswXIZWM0tEUmp7Xc3DngtTslbrCRJsnZnr1IDAFDXa3Zw4wLHGSNEKiVXPxg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744573869; c=relaxed/simple;
	bh=IRLaNQdb3TIWz0TX8veHTm12z8DUreWzQbAPozk2cUM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=oQjhxCRu+frYHqTj2I35Q6dC/Gd1HC3F1DP55vihgGtTJZuAZ3BAsbp51q9qo61j4J6BI6cWpkUaLwzLxTRfgtQwpnwqUQpKgNdWWJJb+tSx/DztpvEFV1ttSpBVnY2xHNrfrkTgrxBoU42EeweNoH1mHAmz8VHP/sVgp3agiG8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch; spf=pass smtp.mailfrom=lunn.ch; dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b=FDAD/u5Q; arc=none smtp.client-ip=156.67.10.101
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lunn.ch
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=lunn.ch;
	s=20171124; h=In-Reply-To:Content-Transfer-Encoding:Content-Disposition:
	Content-Type:MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:From:
	Sender:Reply-To:Subject:Date:Message-ID:To:Cc:MIME-Version:Content-Type:
	Content-Transfer-Encoding:Content-ID:Content-Description:Content-Disposition:
	In-Reply-To:References; bh=gk7+NueQV0rZfB0Vb9kEXe2k5hVrXUXOMr3/Bjby3Bw=; b=FD
	AD/u5QyeIYJuWo3xHLH0qKp4HT6S10GFJi6yvcp1visS1XZQLaYnTtiYiq4vHuiKvttgnSaR/Csph
	jZEUXQW3Hur7F9uzhZ09nxx5HtR/x7LBHCEU6M8WNg2MyMDLeGlEhAdRlFIYOuIRcnrMci6as30Kq
	cZXXKVUZ2G17BaE=;
Received: from andrew by vps0.lunn.ch with local (Exim 4.94.2)
	(envelope-from <andrew@lunn.ch>)
	id 1u43Ls-0095Ss-8s; Sun, 13 Apr 2025 21:50:48 +0200
Date: Sun, 13 Apr 2025 21:50:48 +0200
From: Andrew Lunn <andrew@lunn.ch>
To: Ivan Vecera <ivecera@redhat.com>
Cc: Andy Shevchenko <andy.shevchenko@gmail.com>, netdev@vger.kernel.org,
	Vadim Fedorenko <vadim.fedorenko@linux.dev>,
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
Subject: Re: [PATCH v2 07/14] mfd: zl3073x: Add components versions register
 defs
Message-ID: <83f83841-fa10-422f-9b4b-625c678a4b5e@lunn.ch>
References: <20250409144250.206590-1-ivecera@redhat.com>
 <20250409144250.206590-8-ivecera@redhat.com>
 <CAHp75Ve4LO5rB3HLDV5XXMd4SihOQbPZBEZC8i1VY_Nz0E9tig@mail.gmail.com>
 <b7e223bd-d43b-4cdd-9d48-4a1f80a482e8@redhat.com>
 <46ff3480-caca-4e2c-9382-2897c611758a@redhat.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <46ff3480-caca-4e2c-9382-2897c611758a@redhat.com>


61;8000;1cOn Fri, Apr 11, 2025 at 03:17:14PM +0200, Ivan Vecera wrote:
> On 11. 04. 25 1:19 odp., Ivan Vecera wrote:
> > The range for regmap 1: (registers 0x000-0x4FF)
> > regmap_range_cfg {
> >      .range_min = 0,
> >      .range_max = 10 * 128 - 1, /* 10 pages, 128 registers each */
> >      .selector_reg = 0x7f,      /* page selector at each page */
> >      .selector_shift = 0,       /* no shift in page selector */
> >      .selector_mask = GENMASK(3, 0),    /* 4 bits for page sel */
> >      .window_start = 0,         /* 128 regs from 0x00-0x7f */
> >      .window_len = 128,
> > };
> > 
> > The range for regmap 2: (registers 0x500-0x77F)
> > regmap_range_cfg {
> >      .range_min = 10 * 128,
> >      .range_max = 15 * 128 - 1, /* 5 pages, 128 registers each */
> >      .selector_reg = 0x7f,      /* page selector at each page */
> >      .selector_shift = 0,       /* no shift in page selector */
> >      .selector_mask = GENMASK(3, 0),    /* 4 bits for page sel */
> >      .window_start = 0,         /* 128 regs from 0x00-0x7f */
> >      .window_len = 128,
> > };
> > 
> > Is it now OK?
> 
> No this is not good... I cannot use 2 ranges.
> 
> This is not safe... if the caller use regmap 2 to read/write something below
> 0x500 (by mistake), no mapping is applied and value is directly used as
> register number that's wrong :-(.
> 
> Should I use rather single mapping range to cover all pages and ensure at
> driver level that regmap 2 is not used for regs < 0x500?

I don't know regmap too well, but cannot your mailbox regmap have a
reg_base of 10 * 128. Going blow that would then require a negative
reg, but they are unsigned int.

One of that things the core MFD driver is about is giving you safe
access to shared registers on some sort of bus. So it could well be
your MFD exports an higher level API for mailboxs, a mailbox read and
mailbox write, etc. The regmap below it is not exposed outside of the
MFD core. And the MFD core does all the locking.

	Andrew

