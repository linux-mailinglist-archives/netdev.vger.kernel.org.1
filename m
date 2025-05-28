Return-Path: <netdev+bounces-193965-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 8FB9DAC6A4B
	for <lists+netdev@lfdr.de>; Wed, 28 May 2025 15:25:05 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 5FA131677A8
	for <lists+netdev@lfdr.de>; Wed, 28 May 2025 13:25:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 41DDE283C92;
	Wed, 28 May 2025 13:25:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b="CvNTTWZq"
X-Original-To: netdev@vger.kernel.org
Received: from vps0.lunn.ch (vps0.lunn.ch [156.67.10.101])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6BB841FAA;
	Wed, 28 May 2025 13:24:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=156.67.10.101
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1748438701; cv=none; b=EJmfcWG6ROLnJ6ZwcsuxEJR/1SAux2iaekDJJraJQPPnueA6J98tonQojUfaX33HTIVxYgYvyQ+mMM0oe3boZQ/IUeNYhD4dxWFNT4ZkWagVZb9zpiokuoDsoZ03cGchWDO+hoxI4KrlK51lYIY1yJ5x3UgYcnx2v1h2Qs1+AQg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1748438701; c=relaxed/simple;
	bh=3EaQ0vYUuKF1jmAFbBVV6X09cz1ehGj922mtt6MzENI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=cjosWkV7JFp7wBk4QUE3Lp0oAzK7QIwUoD3GhCZGMC6xnGPEDjUodFDXkHvxOVHB+OATBlHs4thVaecK0OqdbGLqfc0zKAXZxFCDGgbiUzUYm1IhtphRWoKVzx7qR7JQC3yM4rMGrWSQ/8/MSVyHsA0pzxCz6aUwNKkfCderMoo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch; spf=pass smtp.mailfrom=lunn.ch; dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b=CvNTTWZq; arc=none smtp.client-ip=156.67.10.101
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lunn.ch
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=lunn.ch;
	s=20171124; h=In-Reply-To:Content-Transfer-Encoding:Content-Disposition:
	Content-Type:MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:From:
	Sender:Reply-To:Subject:Date:Message-ID:To:Cc:MIME-Version:Content-Type:
	Content-Transfer-Encoding:Content-ID:Content-Description:Content-Disposition:
	In-Reply-To:References; bh=eBLT1coqN7DWf9zqS26cnLXO/a+cQ5A8TJyemfvfOhg=; b=Cv
	NTTWZqEWIqlQKLw1iqZfeKB2gycKP4fQnxaOgVhW9sQoXjUgOMqlAPqOY/cEdYB0XM/boQ+lyJ8s+
	kqj5B6BKu2PlJbvkVkPJ277StCNkbUonv85HBREfXR+xowx5Nj4vC0mlLHpG03b0Wk7ggawLr63qs
	WWFpLv9UJKSTCO4=;
Received: from andrew by vps0.lunn.ch with local (Exim 4.94.2)
	(envelope-from <andrew@lunn.ch>)
	id 1uKGm5-00EB7S-MN; Wed, 28 May 2025 15:24:53 +0200
Date: Wed, 28 May 2025 15:24:53 +0200
From: Andrew Lunn <andrew@lunn.ch>
To: James Hilliard <james.hilliard1@gmail.com>
Cc: "Russell King (Oracle)" <linux@armlinux.org.uk>, netdev@vger.kernel.org,
	linux-sunxi@lists.linux.dev, Andrew Lunn <andrew+netdev@lunn.ch>,
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
Message-ID: <f915a0ca-35c9-4a95-8274-8215a9a3e8f5@lunn.ch>
References: <20250527175558.2738342-1-james.hilliard1@gmail.com>
 <631ed4fe-f28a-443b-922b-7f41c20f31f3@lunn.ch>
 <CADvTj4rGdb_kHV_gjKTJNkzYEPMzqLcHY_1xw7wy5r-ryqDfNQ@mail.gmail.com>
 <fe8fb314-de99-45c2-b71e-5cedffe590b0@lunn.ch>
 <CADvTj4qRmjUQJnhamkWNpHGNAtvFyOJnbaQ5RZ6NYYqSNhxshA@mail.gmail.com>
 <014d8d63-bfb1-4911-9ea6-6f4cdabc46e5@lunn.ch>
 <CADvTj4oVj-38ohw7Na9rkXLTGEEFkLv=4S40GPvHM5eZnN7KyA@mail.gmail.com>
 <aDbA5l5iXNntTN6n@shell.armlinux.org.uk>
 <CADvTj4qP_enKCG-xpNG44ddMOJj42c+yiuMjV_N9LPJPMJqyOg@mail.gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CADvTj4qP_enKCG-xpNG44ddMOJj42c+yiuMjV_N9LPJPMJqyOg@mail.gmail.com>

On Wed, May 28, 2025 at 05:57:38AM -0600, James Hilliard wrote:
> On Wed, May 28, 2025 at 1:53 AM Russell King (Oracle)
> <linux@armlinux.org.uk> wrote:
> >
> > On Tue, May 27, 2025 at 02:37:03PM -0600, James Hilliard wrote:
> > > On Tue, May 27, 2025 at 2:30 PM Andrew Lunn <andrew@lunn.ch> wrote:
> > > >
> > > > > Sure, that may make sense to do as well, but I still don't see
> > > > > how that impacts the need to runtime select the PHY which
> > > > > is configured for the correct MFD.
> > > >
> > > > If you know what variant you have, you only include the one PHY you
> > > > actually have, and phy-handle points to it, just as normal. No runtime
> > > > selection.
> > >
> > > Oh, so here's the issue, we have both PHY variants, older hardware
> > > generally has AC200 PHY's while newer ships AC300 PHY's, but
> > > when I surveyed our deployed hardware using these boards many
> > > systems of similar age would randomly mix AC200 and AC300 PHY's.
> > >
> > > It appears there was a fairly long transition period where both variants
> > > were being shipped.
> >
> > Given that DT is supposed to describe the hardware that is being run on,
> > it should _describe_ _the_ _hardware_ that the kernel is being run on.
> >
> > That means not enumerating all possibilities in DT and then having magic
> > in the kernel to select the right variant. That means having a correct
> > description in DT for the kernel to use.
> 
> The approach I'm using is IMO quite similar to say other hardware
> variant runtime detection DT features like this:
> https://github.com/torvalds/linux/commit/157ce8f381efe264933e9366db828d845bade3a1

That is for things link a HAT on a RPi. It is something which is easy
to replace, and is expected to be replaced.

You are talking about some form of chiplet like component within the
SoC package. It is not easy to replace, and not expected to be
replaced.

Different uses cases altogether.

What i think we will end up with is the base SoC .dtsi file, and two
additional .dtsi files describing the two PHY variants.

	Andrew

