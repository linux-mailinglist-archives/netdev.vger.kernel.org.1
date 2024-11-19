Return-Path: <netdev+bounces-146243-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C88D79D26B9
	for <lists+netdev@lfdr.de>; Tue, 19 Nov 2024 14:19:23 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 88DFE2829CE
	for <lists+netdev@lfdr.de>; Tue, 19 Nov 2024 13:19:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 74E961CC8A0;
	Tue, 19 Nov 2024 13:19:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=armlinux.org.uk header.i=@armlinux.org.uk header.b="Yuo+S+AB"
X-Original-To: netdev@vger.kernel.org
Received: from pandora.armlinux.org.uk (pandora.armlinux.org.uk [78.32.30.218])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BFC2212B93;
	Tue, 19 Nov 2024 13:19:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=78.32.30.218
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732022358; cv=none; b=XRFCrqUUtGJAqyvvs1vJ/gXDTTFxhZaJE2lrzaWFdneUs3X/qcV+LLMKCxtdYaVP5zUB8Oc/LffE8Li7TUTyTYTaAE3+EqMemBAdPWPLbdWuaRGog4xt3zz1v4rXbVU2ug7T8kZjIpOkCD8GA6zs2K/e+IJ6OwTDVH73ntYJCJQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732022358; c=relaxed/simple;
	bh=heC2W64u9lxX7hBxk0vAcv1W8KZWJh4QrGipH65lbFM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=csTE4VQ4wF42uBovE1YKbsLGaNbFKsOyjK7VJ3VEATqw4r8iqBgmXw9St3NCZAWAsPVwfbtALtsCp8eehChxKMh2nepSIaDu02doM2Sob2v0KT6OhDQIXX77Nkj+1szWCbqyKWgWTtz0tMzzYcvouAT3Eaca8YKO+FqrxwwxwjY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=armlinux.org.uk; spf=none smtp.mailfrom=armlinux.org.uk; dkim=pass (2048-bit key) header.d=armlinux.org.uk header.i=@armlinux.org.uk header.b=Yuo+S+AB; arc=none smtp.client-ip=78.32.30.218
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=armlinux.org.uk
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=armlinux.org.uk
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=armlinux.org.uk; s=pandora-2019; h=Sender:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
	List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
	bh=1KfrneJwcEYheNMfrfNjo9ZS+UmR5Cm/dBZt4GtnUto=; b=Yuo+S+ABzgWzxo66fZkvUu6o27
	vfWE9FjKlYV+KJ8wcwM7CebRfvCMx7OARYV8OdeXQavI+GSleh17Vu3BiH1aJQDg9HYMutx4QxydA
	x8YYT4e4um83vyek8UCkxqm0MKotYh/If+v/TadtBVchaqBqNjZ7F4UpO4iMdQ+itOG9kou99WkT5
	8+Sudruhf7TBRjsVtyaqMYTn4OQWENzMYAAfVbGP+KKSgydLanki238hkjHHo7/0ZmNYhv9aC8Jht
	Wy2vsk4WBAYk5DeDwse5jm5kepiHqpr1AGiOKAFjS9iRM1AkF7LnrZF7dmVix9kCeFKuLtXGss+Pa
	XZsl+D4A==;
Received: from shell.armlinux.org.uk ([fd8f:7570:feb6:1:5054:ff:fe00:4ec]:38246)
	by pandora.armlinux.org.uk with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.96)
	(envelope-from <linux@armlinux.org.uk>)
	id 1tDO8B-0003a0-2D;
	Tue, 19 Nov 2024 13:19:00 +0000
Received: from linux by shell.armlinux.org.uk with local (Exim 4.96)
	(envelope-from <linux@shell.armlinux.org.uk>)
	id 1tDO89-00065G-0t;
	Tue, 19 Nov 2024 13:18:57 +0000
Date: Tue, 19 Nov 2024 13:18:57 +0000
From: "Russell King (Oracle)" <linux@armlinux.org.uk>
To: "Gupta, Suraj" <Suraj.Gupta2@amd.com>
Cc: Sean Anderson <sean.anderson@linux.dev>,
	"andrew+netdev@lunn.ch" <andrew+netdev@lunn.ch>,
	"davem@davemloft.net" <davem@davemloft.net>,
	"edumazet@google.com" <edumazet@google.com>,
	"kuba@kernel.org" <kuba@kernel.org>,
	"pabeni@redhat.com" <pabeni@redhat.com>,
	"Simek, Michal" <michal.simek@amd.com>,
	"Pandey, Radhey Shyam" <radhey.shyam.pandey@amd.com>,
	"horms@kernel.org" <horms@kernel.org>,
	"netdev@vger.kernel.org" <netdev@vger.kernel.org>,
	"linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
	"git (AMD-Xilinx)" <git@amd.com>,
	"Katakam, Harini" <harini.katakam@amd.com>
Subject: Re: [PATCH net-next 2/2] net: axienet: Add support for AXI 2.5G MAC
Message-ID: <ZzyQQV4qM_fTrpMf@shell.armlinux.org.uk>
References: <20241118081822.19383-1-suraj.gupta2@amd.com>
 <20241118081822.19383-3-suraj.gupta2@amd.com>
 <ZztjvkxbCiLER-PJ@shell.armlinux.org.uk>
 <657764fd-68a1-4826-b832-3bda91a0c13b@linux.dev>
 <Zztml-Te38P3M7cM@shell.armlinux.org.uk>
 <BL3PR12MB65716077E66F2141CC618DD9C9202@BL3PR12MB6571.namprd12.prod.outlook.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <BL3PR12MB65716077E66F2141CC618DD9C9202@BL3PR12MB6571.namprd12.prod.outlook.com>
Sender: Russell King (Oracle) <linux@armlinux.org.uk>

On Tue, Nov 19, 2024 at 10:28:48AM +0000, Gupta, Suraj wrote:
> > -----Original Message-----
> > From: Russell King <linux@armlinux.org.uk>
> > 
> > On Mon, Nov 18, 2024 at 11:00:22AM -0500, Sean Anderson wrote:
> > > On 11/18/24 10:56, Russell King (Oracle) wrote:
> > > > On Mon, Nov 18, 2024 at 01:48:22PM +0530, Suraj Gupta wrote:
> > > >> Add AXI 2.5G MAC support, which is an incremental speed upgrade of
> > > >> AXI 1G MAC and supports 2.5G speed only. "max-speed" DT property is
> > > >> used in driver to distinguish 1G and 2.5G MACs of AXI 1G/2.5G IP.
> > > >> If max-speed property is missing, 1G is assumed to support backward
> > > >> compatibility.
> > > >>
> > > >> Co-developed-by: Harini Katakam <harini.katakam@amd.com>
> > > >> Signed-off-by: Harini Katakam <harini.katakam@amd.com>
> > > >> Signed-off-by: Suraj Gupta <suraj.gupta2@amd.com>
> > > >> ---
> > > >
> > > > ...
> > > >
> > > >> -  lp->phylink_config.mac_capabilities = MAC_SYM_PAUSE |
> > MAC_ASYM_PAUSE |
> > > >> -          MAC_10FD | MAC_100FD | MAC_1000FD;
> > > >> +  lp->phylink_config.mac_capabilities = MAC_SYM_PAUSE |
> > > >> + MAC_ASYM_PAUSE;
> > > >> +
> > > >> +  /* Set MAC capabilities based on MAC type */  if (lp->max_speed
> > > >> + == SPEED_1000)
> > > >> +          lp->phylink_config.mac_capabilities |= MAC_10FD |
> > > >> + MAC_100FD | MAC_1000FD;  else
> > > >> +          lp->phylink_config.mac_capabilities |= MAC_2500FD;
> > > >
> > > > The MAC can only operate at (10M, 100M, 1G) _or_ 2.5G ?
> > >
> > > It's a PCS limitation. It either does (1000Base-X and/or SGMII) OR
> > > (2500Base-X). The MAC itself doesn't have this limitation AFAIK.
> > 
> > That means the patch is definitely wrong, and the proposed DT change is also
> > wrong.
> > 
> > If it's a limitation of the PCS, that limitation should be applied via the PCS's
> > .pcs_validate() method, not at the MAC level.
> > 
> As mentioned in IP PG (https://docs.amd.com/r/en-US/pg051-tri-mode-eth-mac/Ethernet-Overview#:~:text=Typical%20Ethernet%20Architecture-,MAC,-For%2010/100), it's limitation in MAC also.

I'm not reading it as a limitation of the MAC.

The limitation stated there is that internal mode (GMII) is only
supported for 2.5Gbps speeds. At 2.5Gbps speeds, the clock rate is
increased from 125MHz to 312.5MHz (which makes it non-compliant
with 802.3-2008, because that version doesn't define 2.5Gbps speeds.)

So long as the clock rate and interface can be safely switched, I
don't see any reason to restrict the MAC itself to be either
10/100/1G _or_ 2.5G.

Note that 2.5G will only become available if it is supported by one
of the supported interface modes (e.g. 2500base-X). If the supported
interface modes do not include a mode that supports >1G, then 2.5G
won't be available even if MAC_2500FD is set in mac_capabilities.

-- 
RMK's Patch system: https://www.armlinux.org.uk/developer/patches/
FTTP is here! 80Mbps down 10Mbps up. Decent connectivity at last!

