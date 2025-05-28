Return-Path: <netdev+bounces-194058-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 39600AC7281
	for <lists+netdev@lfdr.de>; Wed, 28 May 2025 23:05:50 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 0CB441BC7590
	for <lists+netdev@lfdr.de>; Wed, 28 May 2025 21:06:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AE93D212B3D;
	Wed, 28 May 2025 21:05:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b="4L8mlfeR"
X-Original-To: netdev@vger.kernel.org
Received: from vps0.lunn.ch (vps0.lunn.ch [156.67.10.101])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6729CFC0E;
	Wed, 28 May 2025 21:05:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=156.67.10.101
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1748466345; cv=none; b=CkWM6MCQ0VKwTQaFDIR2Jp3Bxiryzj5pnHY6gGehJtO54f+NWnw6vy4OJNroFmwt4nBRZA826lcD37oN5NUyl4fdEcA07FOBkGj/KBWHeylF4f2jHxodDYrFR5rXpy4UXcnuK4ewxzzqJ94K4cKQJuAHBfYiiARIYlUBPas/i6Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1748466345; c=relaxed/simple;
	bh=thfMG70n9VgYdgGnvWHjyk1eF+yc+6WAcoijPrrRo4I=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=gzCEn00vbn6vOwX1FqhTMNLF52Pkq2I/WpUkNqmqKeUG7xGVbsLo+O4XCHsois8snr3u8HVa2m6CnkmIiynQysjfb+bEN/qU8sPfHhkv+oV/eszodOcQh1a2QuuFECTvMDZ2AkJGNI8ZkwRqqYCqC1D3TOVymcexnXHC5Tzlpmk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch; spf=pass smtp.mailfrom=lunn.ch; dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b=4L8mlfeR; arc=none smtp.client-ip=156.67.10.101
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lunn.ch
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=lunn.ch;
	s=20171124; h=In-Reply-To:Content-Transfer-Encoding:Content-Disposition:
	Content-Type:MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:From:
	Sender:Reply-To:Subject:Date:Message-ID:To:Cc:MIME-Version:Content-Type:
	Content-Transfer-Encoding:Content-ID:Content-Description:Content-Disposition:
	In-Reply-To:References; bh=b95mbv58GC1sLRpCdVviPp1TGSLCgwADdPiOEMX8kAs=; b=4L
	8mlfeRvliv9ijr/wpaHqc6/m0DT95i0TweNRw89IsfTxUOZnG0O1o0KeOLB19ufZ+HsFnaxD3i5Ts
	XssIZNhQxsjOi4mcw1okG4dYNjkby2gZWp5YFVilP1G+kR0xz7chzpgpvJNNB0vrjgUZNLTaWFF4m
	A2gneThrUTubonA=;
Received: from andrew by vps0.lunn.ch with local (Exim 4.94.2)
	(envelope-from <andrew@lunn.ch>)
	id 1uKNxl-00ED1x-It; Wed, 28 May 2025 23:05:25 +0200
Date: Wed, 28 May 2025 23:05:25 +0200
From: Andrew Lunn <andrew@lunn.ch>
To: James Hilliard <james.hilliard1@gmail.com>
Cc: "Russell King (Oracle)" <linux@armlinux.org.uk>, wens@csie.org,
	netdev@vger.kernel.org, linux-sunxi@lists.linux.dev,
	Andrew Lunn <andrew+netdev@lunn.ch>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	Maxime Coquelin <mcoquelin.stm32@gmail.com>,
	Alexandre Torgue <alexandre.torgue@foss.st.com>,
	Furong Xu <0x1207@gmail.com>,
	Kunihiko Hayashi <hayashi.kunihiko@socionext.com>,
	linux-stm32@st-md-mailman.stormreply.com,
	linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 1/3] net: stmmac: allow drivers to explicitly select
 PHY device
Message-ID: <1e6e4a44-9d2b-4af4-8635-150ccc410c22@lunn.ch>
References: <CADvTj4oVj-38ohw7Na9rkXLTGEEFkLv=4S40GPvHM5eZnN7KyA@mail.gmail.com>
 <aDbA5l5iXNntTN6n@shell.armlinux.org.uk>
 <CADvTj4qP_enKCG-xpNG44ddMOJj42c+yiuMjV_N9LPJPMJqyOg@mail.gmail.com>
 <f915a0ca-35c9-4a95-8274-8215a9a3e8f5@lunn.ch>
 <CAGb2v66PEA4OJxs2rHrYFAxx8bw4zab7TUXQr+DM-+ERBO-UyQ@mail.gmail.com>
 <CADvTj4qyRRCSnvvYHLvTq73P0YOjqZ=Z7kyjPMm206ezMePTpQ@mail.gmail.com>
 <aDdXRPD2NpiZMsfZ@shell.armlinux.org.uk>
 <CADvTj4pKsAYsm6pm0sgZgQ+AxriXH5_DLmF30g8rFd0FewGG6w@mail.gmail.com>
 <8306dac8-3a0e-4e79-938a-10e9ee38e325@lunn.ch>
 <CADvTj4rWvEaFyOm2HdNonASE4y1qoPoNgP_9n_ZbLCqAo1gGYw@mail.gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CADvTj4rWvEaFyOm2HdNonASE4y1qoPoNgP_9n_ZbLCqAo1gGYw@mail.gmail.com>

On Wed, May 28, 2025 at 01:45:40PM -0600, James Hilliard wrote:
> On Wed, May 28, 2025 at 1:27 PM Andrew Lunn <andrew@lunn.ch> wrote:
> >
> > > I think a lot of ethernet drivers use phy_find_first() for phy scanning
> > > as well so it's not limited to just stmmac AFAIU.
> >
> > You need to differentiate by time. It has become a lot less used in
> > the last decade. DT describes the PHY, so there is no need to hunt
> > around for it. The only real use case now a days is USB dongles, which
> > don't have DT, and maybe PCIe devices without ACPI support.
> 
> I mean, hardware probing features for this sort of use case have been
> getting added outside the network subsystem so I'm not sure what the
> issue with this is as those use cases don't appear to be meaningfully
> different.
> 
> > I suggest you give up pushing this. You have two Maintainers saying no
> > to this, so it is very unlikely you are going to succeed.
> 
> So what should I be doing instead?

Describe the one PHY which actually exists in device tree for the
board, and point to it using phy-handle. No runtime detection, just
correctly describe the hardware.

Do you have examples of boards where the SoC variant changed during
the boards production life?

	Andrew


