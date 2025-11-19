Return-Path: <netdev+bounces-239954-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [213.196.21.55])
	by mail.lfdr.de (Postfix) with ESMTPS id A29D8C6E5EF
	for <lists+netdev@lfdr.de>; Wed, 19 Nov 2025 13:05:00 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id E9435384859
	for <lists+netdev@lfdr.de>; Wed, 19 Nov 2025 12:03:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D58943563F7;
	Wed, 19 Nov 2025 12:03:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=armlinux.org.uk header.i=@armlinux.org.uk header.b="CCWOZBqr"
X-Original-To: netdev@vger.kernel.org
Received: from pandora.armlinux.org.uk (pandora.armlinux.org.uk [78.32.30.218])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0FB27347FE8;
	Wed, 19 Nov 2025 12:03:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=78.32.30.218
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763553817; cv=none; b=bYY3Fg2K5iyzPFRzkfmfvilJw+dTTKBEaJ3zJXeMdoimCq56MjWM74wXI9kY5DBPzma05s541CzUOG+/ow5TY7phn37UWYQA7Nyu5t5g3sBqfNnQ9/c6SnhEgA1AX7mKLlrRkAA5JlWnU2gTVphMKOSYLia7kojp+x8SYIwMrxA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763553817; c=relaxed/simple;
	bh=Dfyio5XPM7TTOREotHnKNVW74xmctUJt+qBQAzcWSm8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=dO5FOQ2eD8lXzvX3G5P3QzJmZSF+EZ6lo9DFatR8jxAsWG5d5TJigJH/d+cvi6n7EquHoagrXrJ61c4K4ssF64h09KabJQOg+PKd8yKs3u82K73irBxgUMniI2zT7dJ1Tcun9YWdbvVcZxeO7ABFbHSu62M9R7IbcBT8gr60Hfg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=armlinux.org.uk; spf=none smtp.mailfrom=armlinux.org.uk; dkim=pass (2048-bit key) header.d=armlinux.org.uk header.i=@armlinux.org.uk header.b=CCWOZBqr; arc=none smtp.client-ip=78.32.30.218
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=armlinux.org.uk
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=armlinux.org.uk
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=armlinux.org.uk; s=pandora-2019; h=Sender:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
	List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
	bh=KPIHPS0f26SEefkbfW7cuu+gK061PC4kTsuYRtkCNfE=; b=CCWOZBqrXtyyoWvZ+zYbvOVpFA
	qjyxBwHRVuzskvKgN8NBSUC/gj1F1JVlEBzJAhoig3aM9YM8kr7tGpaDyg1XG+TzWsB/6QkhELjQn
	mqC74TCfXdHwZCOz5s02jbD3n9jKvj5zIa+4MkH1qm7wEvvyGmUzZYNCpGkf7sjP4ymZejnNXqy/L
	+oCAsbdSQUx1NPeo6EzZyk8kpdr7ShC90DUQakQFnryauDi+f2ScZ5vZcEE583m4aBt2G2h/akyWs
	lkK83vxpgNpSc3/BCKbSfHMve2famxU1c35ecWcw3XnsAJrF3zr/pDqAjkhgiEzeoCnrODXLO9fEp
	YOoWRrqA==;
Received: from shell.armlinux.org.uk ([fd8f:7570:feb6:1:5054:ff:fe00:4ec]:45624)
	by pandora.armlinux.org.uk with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.98.2)
	(envelope-from <linux@armlinux.org.uk>)
	id 1vLguK-000000004eg-1P6A;
	Wed, 19 Nov 2025 12:03:32 +0000
Received: from linux by shell.armlinux.org.uk with local (Exim 4.98.2)
	(envelope-from <linux@shell.armlinux.org.uk>)
	id 1vLguH-000000003ON-2Nfy;
	Wed, 19 Nov 2025 12:03:29 +0000
Date: Wed, 19 Nov 2025 12:03:29 +0000
From: "Russell King (Oracle)" <linux@armlinux.org.uk>
To: Vladimir Oltean <vladimir.oltean@nxp.com>
Cc: kernel test robot <lkp@intel.com>, netdev@vger.kernel.org,
	oe-kbuild-all@lists.linux.dev, Andrew Lunn <andrew@lunn.ch>,
	Heiner Kallweit <hkallweit1@gmail.com>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	linux-kernel@vger.kernel.org, Serge Semin <fancer.lancer@gmail.com>,
	Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
	Herve Codina <herve.codina@bootlin.com>,
	Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>, devicetree@vger.kernel.org
Subject: Re: [PATCH net-next 14/15] net: dsa: sja1105: replace mdiobus-pcs
 with xpcs-plat driver
Message-ID: <aR2yEf04Pv-CZi1U@shell.armlinux.org.uk>
References: <20251118190530.580267-15-vladimir.oltean@nxp.com>
 <20251118190530.580267-15-vladimir.oltean@nxp.com>
 <202511191835.rwfD48SW-lkp@intel.com>
 <202511191835.rwfD48SW-lkp@intel.com>
 <20251119120111.voyy7rmy4mk444wo@skbuf>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20251119120111.voyy7rmy4mk444wo@skbuf>
Sender: Russell King (Oracle) <linux@armlinux.org.uk>

On Wed, Nov 19, 2025 at 02:01:11PM +0200, Vladimir Oltean wrote:
> I do wonder how to print resource_size_t (typedef to phys_addr_t, which
> is typedeffed to u64 or u32 depending on CONFIG_PHYS_ADDR_T_64BIT).

From the now hard to find Documentation/core-api/printk-formats.rst:

Physical address types phys_addr_t
----------------------------------

::

        %pa[p]  0x01234567 or 0x0123456789abcdef

For printing a phys_addr_t type (and its derivatives, such as
resource_size_t) which can vary based on build options, regardless of the
width of the CPU data path.

Passed by reference.

-- 
RMK's Patch system: https://www.armlinux.org.uk/developer/patches/
FTTP is here! 80Mbps down 10Mbps up. Decent connectivity at last!

