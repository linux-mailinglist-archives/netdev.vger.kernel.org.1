Return-Path: <netdev+bounces-223630-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id E3E00B59C19
	for <lists+netdev@lfdr.de>; Tue, 16 Sep 2025 17:31:36 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id E17EE7A285D
	for <lists+netdev@lfdr.de>; Tue, 16 Sep 2025 15:29:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E9A7721579F;
	Tue, 16 Sep 2025 15:31:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=armlinux.org.uk header.i=@armlinux.org.uk header.b="VQ8eJWgp"
X-Original-To: netdev@vger.kernel.org
Received: from pandora.armlinux.org.uk (pandora.armlinux.org.uk [78.32.30.218])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8A725FC1D
	for <netdev@vger.kernel.org>; Tue, 16 Sep 2025 15:31:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=78.32.30.218
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758036690; cv=none; b=dlN7qZGAevt3BKm5lY01n90GBWd7nrAkueCcrihj5HrqgXzx+PgUCAF56a40uKspgLOrD+lIyAY77l/l0RAUnq6qGJAVdnWU8g2eyDn2he/W8wpRIeCr6dY/sHoiQf22V0APfgJRz/SP9ioKNDq4lE7mW4jqQKfhtJETdjsopro=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758036690; c=relaxed/simple;
	bh=KLp7KQMmdKGM7PfggPrZkEkFa9ZAfi+ug40MNViJ/Jo=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=FfutwikNmGzqJ2CewbiOR2Tmgh8ujBAEMkAStNDqyJlOwp0jalG+vWHaJi3hOQ5kRBEYW1xDhJLlojRNS5/g9WoKHiQ8hOFkP/L52PZiS09iVWGmdCbzw+w7dD3rJPIElNtHIoccJ1ZTORyC7oDhxjsLD/1xrlwKaEIBP8KpdoQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=armlinux.org.uk; spf=none smtp.mailfrom=armlinux.org.uk; dkim=pass (2048-bit key) header.d=armlinux.org.uk header.i=@armlinux.org.uk header.b=VQ8eJWgp; arc=none smtp.client-ip=78.32.30.218
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=armlinux.org.uk
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=armlinux.org.uk
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=armlinux.org.uk; s=pandora-2019; h=Sender:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
	List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
	bh=HqD87Lpv7sSKzNMgBjt88SQkPsU47LFofoytvotCWqA=; b=VQ8eJWgpHsDiWYvcZD5XBWUiUC
	LxQAwjQRwHQsV9KGkiWhL36is0efTpWQIVEXztJFC6GsUw5O9t+CO3yA9B2yfZCAfLn1+DnHz22bv
	PafZ3u7ZaIznlfDvVrT6qpW+/IKP0AA47sj+U0PuLGbfC4pdHU/k3dcTz4HO2zMX2tDYgTQdAimtr
	kt6ijfDsu52OwauDsVX83CyEpzgolO6qNUQYpwDTQDqmRmZ/prN7lFTZrft3a+YjQxxMpwndFTbF0
	mm3mFnIntWoHcsKGKpA4QLJrcNBO/abfpgc8/Bcwd/8gWDy0usrhd8L0mGfLyu2OzueYcgcqkyPZX
	4OlqOKgg==;
Received: from shell.armlinux.org.uk ([fd8f:7570:feb6:1:5054:ff:fe00:4ec]:48046)
	by pandora.armlinux.org.uk with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.98.2)
	(envelope-from <linux@armlinux.org.uk>)
	id 1uyXeM-0000000052w-1A9Q;
	Tue, 16 Sep 2025 16:31:22 +0100
Received: from linux by shell.armlinux.org.uk with local (Exim 4.98.2)
	(envelope-from <linux@shell.armlinux.org.uk>)
	id 1uyXeJ-000000007ko-3rtD;
	Tue, 16 Sep 2025 16:31:19 +0100
Date: Tue, 16 Sep 2025 16:31:19 +0100
From: "Russell King (Oracle)" <linux@armlinux.org.uk>
To: Andrew Lunn <andrew@lunn.ch>
Cc: Vladimir Oltean <olteanv@gmail.com>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, netdev@vger.kernel.org,
	Paolo Abeni <pabeni@redhat.com>,
	Richard Cochran <richardcochran@gmail.com>
Subject: Re: [PATCH net-next 5/5] net: dsa: mv88e6xxx: move
 mv88e6xxx_hwtstamp_work() prototype
Message-ID: <aMmCx1Eu0pDAxWJ9@shell.armlinux.org.uk>
References: <aMgPN6W5Js5ZrL5n@shell.armlinux.org.uk>
 <E1uy8uh-00000005cFT-40x8@rmk-PC.armlinux.org.uk>
 <20250916080903.24vbpv7hevhrzl4g@skbuf>
 <9d3eb839-99be-4d08-96ec-8bee1dec073a@lunn.ch>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <9d3eb839-99be-4d08-96ec-8bee1dec073a@lunn.ch>
Sender: Russell King (Oracle) <linux@armlinux.org.uk>

On Tue, Sep 16, 2025 at 02:46:05PM +0200, Andrew Lunn wrote:
> > This leaves the shim definition (for when CONFIG_NET_DSA_MV88E6XXX_PTP
> > is not defined) in ptp.h. It creates an inconsistency and potential
> > problem - the same header should provide all definitions of the same
> > function.
> 
> How big is the PTP code? We have added a lot of code to this driver
> since PTP was added. I suspect the PTP code is now small compared to
> the rest of the driver, so does it still make sense to have it
> optional? Also once the PTP code gets moved into a library and shared
> by the Marvell PHY driver and other Marvell MAC drivers, won't we have
> an overall code shrink even when it is enabled in DSA?
> 
> Maybe it is time for CONFIG_NET_DSA_MV88E6XXX_PTP to go away?

Unmodified:
wc -l:
   611 drivers/net/dsa/mv88e6xxx/hwtstamp.c
   180 drivers/net/dsa/mv88e6xxx/hwtstamp.h
   564 drivers/net/dsa/mv88e6xxx/ptp.c
   176 drivers/net/dsa/mv88e6xxx/ptp.h

size:
   text    data     bss     dec     hex filename
   4004       0      16    4020     fb4 drivers/net/dsa/mv88e6xxx/hwtstamp.o
 130360    3505     224  134089   20bc9 drivers/net/dsa/mv88e6xxx/mv88e6xxx.ko
   3917       0      64    3981     f8d drivers/net/dsa/mv88e6xxx/ptp.o

Current post-conversion:
wc -l:
   459 drivers/net/dsa/mv88e6xxx/hwtstamp.c
   169 drivers/net/dsa/mv88e6xxx/hwtstamp.h
   418 drivers/net/dsa/mv88e6xxx/ptp.c
    83 drivers/net/dsa/mv88e6xxx/ptp.h

size:
   text    data     bss     dec     hex filename
   3988       0       0    3988     f94 drivers/net/dsa/mv88e6xxx/hwtstamp.o
 129312    3505     144  132961   20761 drivers/net/dsa/mv88e6xxx/mv88e6xxx.ko
   2709       0       0    2709     a95 drivers/net/dsa/mv88e6xxx/ptp.o

With a bit more effort to avoid the repeated chip->info->ops->foo
dereferecing chains in ptp.c, I can get this down to:

   text    data     bss     dec     hex filename
   2677       0       0    2677     a75 drivers/net/dsa/mv88e6xxx/ptp.o

So that reduces the PTP .text size by between 31 and 32%.

-- 
RMK's Patch system: https://www.armlinux.org.uk/developer/patches/
FTTP is here! 80Mbps down 10Mbps up. Decent connectivity at last!

