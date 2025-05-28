Return-Path: <netdev+bounces-193904-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id D8A12AC636C
	for <lists+netdev@lfdr.de>; Wed, 28 May 2025 09:53:29 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id B18E61891431
	for <lists+netdev@lfdr.de>; Wed, 28 May 2025 07:53:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 338D82459C6;
	Wed, 28 May 2025 07:53:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=armlinux.org.uk header.i=@armlinux.org.uk header.b="BxhS0FZ5"
X-Original-To: netdev@vger.kernel.org
Received: from pandora.armlinux.org.uk (pandora.armlinux.org.uk [78.32.30.218])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A9001243968;
	Wed, 28 May 2025 07:53:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=78.32.30.218
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1748418805; cv=none; b=U2ggOTXp2XGpCa/hHydfQH4Gv+hrbBiRbIZRgbezWzG3E8owIhbththiQ/hS1N2QQR4OMymmq2ReAgogaJ4hEZMr51+USghN215cFZP8GjvYOm4rkycQ4d+D8hW52AMjPWQQ4iFa32ShcBEJ7vYWGj9+SzZJ9pcKVhlVPN64qV4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1748418805; c=relaxed/simple;
	bh=PxiB0VdarYPOAXAu6174aIJk6fsKNzMiJatbecF9DbU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=qjAqnTm9ZUOHKF+sHek9qmWVIJEoYGA0POKPNjjGoerxtGuoC2wOaDA0vKOZz5WRGIR1tWetjQShNklvCQCS7KZ7+0wj4Fo4WSrdVMz9g3/G36r9oFYALga/5F5Z0tCU8mjGtU15b3bNGJtaQS2Gzs+GGjnxHcf/YDCX9kT8/U4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=armlinux.org.uk; spf=none smtp.mailfrom=armlinux.org.uk; dkim=pass (2048-bit key) header.d=armlinux.org.uk header.i=@armlinux.org.uk header.b=BxhS0FZ5; arc=none smtp.client-ip=78.32.30.218
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=armlinux.org.uk
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=armlinux.org.uk
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=armlinux.org.uk; s=pandora-2019; h=Sender:In-Reply-To:
	Content-Transfer-Encoding:Content-Type:MIME-Version:References:Message-ID:
	Subject:Cc:To:From:Date:Reply-To:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
	List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
	bh=Ve9zlEhyAeIJvFh++9HwCNvy/GoFzpwAhVVWMjKo3bE=; b=BxhS0FZ5P9KDXBIuaA2hPCfF72
	kQOc+zam/61pRNAjeSCEDHXcETAjwY5InAkIrntfRtDixw/t8lP0638gmI/JR8kWHFDfLOOXpi/Gm
	pWz4Gkuma2cqnwp+70Osyffe0NV66c2sAGngS1k6cNP/fJDk3xULr+kI8L+74EYw8az0Bd1xmGHcJ
	PbJue0I+lPkoL06qAbKfO8VXR6n21brNYIrFenE9dDocepHHHkGTEddAsFwejmNBBw2AzoHYR7aUr
	P7aPxwZ8ueOHujHeLD6T9b5p78EuLX9EByQMobwH2cn/IhZCPUZtJVG/AD6unO95Fxpjz6edFovbj
	7rgRLdxQ==;
Received: from shell.armlinux.org.uk ([fd8f:7570:feb6:1:5054:ff:fe00:4ec]:55976)
	by pandora.armlinux.org.uk with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.96)
	(envelope-from <linux@armlinux.org.uk>)
	id 1uKBb9-0008NH-0j;
	Wed, 28 May 2025 08:53:15 +0100
Received: from linux by shell.armlinux.org.uk with local (Exim 4.96)
	(envelope-from <linux@shell.armlinux.org.uk>)
	id 1uKBb4-0002G5-1v;
	Wed, 28 May 2025 08:53:10 +0100
Date: Wed, 28 May 2025 08:53:10 +0100
From: "Russell King (Oracle)" <linux@armlinux.org.uk>
To: James Hilliard <james.hilliard1@gmail.com>
Cc: Andrew Lunn <andrew@lunn.ch>, netdev@vger.kernel.org,
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
Message-ID: <aDbA5l5iXNntTN6n@shell.armlinux.org.uk>
References: <20250527175558.2738342-1-james.hilliard1@gmail.com>
 <631ed4fe-f28a-443b-922b-7f41c20f31f3@lunn.ch>
 <CADvTj4rGdb_kHV_gjKTJNkzYEPMzqLcHY_1xw7wy5r-ryqDfNQ@mail.gmail.com>
 <fe8fb314-de99-45c2-b71e-5cedffe590b0@lunn.ch>
 <CADvTj4qRmjUQJnhamkWNpHGNAtvFyOJnbaQ5RZ6NYYqSNhxshA@mail.gmail.com>
 <014d8d63-bfb1-4911-9ea6-6f4cdabc46e5@lunn.ch>
 <CADvTj4oVj-38ohw7Na9rkXLTGEEFkLv=4S40GPvHM5eZnN7KyA@mail.gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CADvTj4oVj-38ohw7Na9rkXLTGEEFkLv=4S40GPvHM5eZnN7KyA@mail.gmail.com>
Sender: Russell King (Oracle) <linux@armlinux.org.uk>

On Tue, May 27, 2025 at 02:37:03PM -0600, James Hilliard wrote:
> On Tue, May 27, 2025 at 2:30 PM Andrew Lunn <andrew@lunn.ch> wrote:
> >
> > > Sure, that may make sense to do as well, but I still don't see
> > > how that impacts the need to runtime select the PHY which
> > > is configured for the correct MFD.
> >
> > If you know what variant you have, you only include the one PHY you
> > actually have, and phy-handle points to it, just as normal. No runtime
> > selection.
> 
> Oh, so here's the issue, we have both PHY variants, older hardware
> generally has AC200 PHY's while newer ships AC300 PHY's, but
> when I surveyed our deployed hardware using these boards many
> systems of similar age would randomly mix AC200 and AC300 PHY's.
> 
> It appears there was a fairly long transition period where both variants
> were being shipped.

Given that DT is supposed to describe the hardware that is being run on,
it should _describe_ _the_ _hardware_ that the kernel is being run on.

That means not enumerating all possibilities in DT and then having magic
in the kernel to select the right variant. That means having a correct
description in DT for the kernel to use.

I don't think that abusing "phys" is a good idea.

It's quite normal for the boot loader to fix up the device tree
according to the hardware - for example, adding the actual memory
location and sizes that are present, adding reserved memory regions,
etc. I don't see why you couldn't detect the differences and have
the boot loader patch the device tree appropriately.

-- 
RMK's Patch system: https://www.armlinux.org.uk/developer/patches/
FTTP is here! 80Mbps down 10Mbps up. Decent connectivity at last!

