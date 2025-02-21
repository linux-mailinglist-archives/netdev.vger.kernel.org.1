Return-Path: <netdev+bounces-168330-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 303E0A3E924
	for <lists+netdev@lfdr.de>; Fri, 21 Feb 2025 01:22:27 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 003B2420EDD
	for <lists+netdev@lfdr.de>; Fri, 21 Feb 2025 00:22:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6B6995680;
	Fri, 21 Feb 2025 00:22:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=armlinux.org.uk header.i=@armlinux.org.uk header.b="t01Rx17B"
X-Original-To: netdev@vger.kernel.org
Received: from pandora.armlinux.org.uk (pandora.armlinux.org.uk [78.32.30.218])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A21434C9D;
	Fri, 21 Feb 2025 00:22:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=78.32.30.218
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740097342; cv=none; b=K+ONcoLKCMBMBrIF5TY3zTq2n7rokNymdUlCCaAwtcOilgKfvxbrkuLWj7UD1pX2MibwJlwUEF9nEiWAYq0MQ6coPertcK8PEwc/AJ3oUdzxhV6FnSFLXvof/qKqgBCHy2FeLDtA/hAnEBUr/UoPYaKP3xInkzDmqYNqQJsUNuI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740097342; c=relaxed/simple;
	bh=bbR2JhjbE8NGlD/AflpDCE4V3oemOih5GQWC6CVgEnQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=dTSXqyqm8ET/y3FDbQyacUcZ8BHUyBx6UvIbOr8lnaNsVbSzaLSGU5xgBbQ9MfApa6Pj9b46h7liAvCZzgbUiyIt2fFVS5wfdOgo+fDeEoeOFb58uPhic/DSz/1dfWAmQDXlSlx2KFVZJ07HATbvETH0Ni+WdnADD1f5343jVc4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=armlinux.org.uk; spf=none smtp.mailfrom=armlinux.org.uk; dkim=pass (2048-bit key) header.d=armlinux.org.uk header.i=@armlinux.org.uk header.b=t01Rx17B; arc=none smtp.client-ip=78.32.30.218
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=armlinux.org.uk
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=armlinux.org.uk
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=armlinux.org.uk; s=pandora-2019; h=Sender:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
	List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
	bh=ilQjTry0RkpQrpQuq+/rlQb1HddPXh5R4G7yfI4BL4I=; b=t01Rx17BWwNKZcRXxeS+IVouen
	7a6S2rfx8RPCLPyYalUbCiZSMVVCSf5YCPnSuW0vsL3YdGJhJhaa3nqefmTRAhEEyfnqvmQG4jcLf
	tc/C6SSinz86mB8vgStnDkMwQWr3g6FsFgfthddflUGpRssCE31U214/t16gYmUAaK4ZKMOKDL9Xw
	yPjiOQH2X9N5CMHyzpeIkwOCmactSq8igRTYcm1DmjlAc908DLm0J7Co4AkPmootV4R3AZlrg+q94
	VFjH7Nmx7V1hdEgt8BrTY8JE82dssgm6G2i1MHdJ0maWzjO24lxsHuP1QOuT0yrfoMkhR8oSlEmHz
	y91PAVUw==;
Received: from shell.armlinux.org.uk ([fd8f:7570:feb6:1:5054:ff:fe00:4ec]:48464)
	by pandora.armlinux.org.uk with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.96)
	(envelope-from <linux@armlinux.org.uk>)
	id 1tlGo2-0002mB-0v;
	Fri, 21 Feb 2025 00:22:14 +0000
Received: from linux by shell.armlinux.org.uk with local (Exim 4.96)
	(envelope-from <linux@shell.armlinux.org.uk>)
	id 1tlGo0-0001Qx-2w;
	Fri, 21 Feb 2025 00:22:12 +0000
Date: Fri, 21 Feb 2025 00:22:12 +0000
From: "Russell King (Oracle)" <linux@armlinux.org.uk>
To: Jakub Kicinski <kuba@kernel.org>
Cc: Jan Petrous <jan.petrous@oss.nxp.com>, NXP S32 Linux Team <s32@nxp.com>,
	netdev@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] MAINTAINERS: fix DWMAC S32 entry
Message-ID: <Z7fHNEFo7Aa4jfUO@shell.armlinux.org.uk>
References: <E1tkJow-004Nfn-Cs@rmk-PC.armlinux.org.uk>
 <20250220152248.3c05878a@kernel.org>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250220152248.3c05878a@kernel.org>
Sender: Russell King (Oracle) <linux@armlinux.org.uk>

On Thu, Feb 20, 2025 at 03:22:48PM -0800, Jakub Kicinski wrote:
> On Tue, 18 Feb 2025 09:23:14 +0000 Russell King (Oracle) wrote:
> > Using L: with more than a bare email address causes getmaintainer.pl
> > to be unable to parse the entry. Fix this by doing as other entries
> > that use this email address and convert it to an R: entry.
> > 
> > Signed-off-by: Russell King (Oracle) <rmk+kernel@armlinux.org.uk>
> > ---
> >  MAINTAINERS | 2 +-
> >  1 file changed, 1 insertion(+), 1 deletion(-)
> > 
> > diff --git a/MAINTAINERS b/MAINTAINERS
> > index de81a3d68396..7da5d2df1b45 100644
> > --- a/MAINTAINERS
> > +++ b/MAINTAINERS
> > @@ -2877,7 +2877,7 @@ F:	drivers/pinctrl/nxp/
> >  
> >  ARM/NXP S32G/S32R DWMAC ETHERNET DRIVER
> >  M:	Jan Petrous <jan.petrous@oss.nxp.com>
> > -L:	NXP S32 Linux Team <s32@nxp.com>
> > +R:	NXP S32 Linux Team <s32@nxp.com>
> >  S:	Maintained
> 
> I had to look thru old commits, 8b0f64b113d61 specifically.
> Can we also strip the "NXP S32 Linux Team"
> It's pretty obvious from s32@nxp.com that it's a group address,
> and this way our scripts will know that this is not a real reviewer.

Right now, the situation is:

$ grep s32@nxp.com MAINTAINERS
R:      NXP S32 Linux Team <s32@nxp.com>
L:      NXP S32 Linux Team <s32@nxp.com>
R:      NXP S32 Linux Team <s32@nxp.com>
L:      s32@nxp.com

and the approach that has been taken in the past is:

-L:     NXP S32 Linux Team <s32@nxp.com>
+R:     NXP S32 Linux Team <s32@nxp.com>

in commit bb2de9b04942 ("MAINTAINERS: fix list entries with display names")

However, commit 98dcb872779f ("ARM: s32c: update MAINTAINERS entry") did
the reverse for the "ARM/NXP S32G ARCHITECTURE" entry breaking that and
adding a new instance of this breakage elsewhere.

It seems these are just going to flip back and forth, so I don't think
I can be bothered to try to fix it, and will modify my own scripts to
eliminate the blank entry in get_maintainers output because of this.
(In other words, s32@nxp.com will *not* be Cc'd for any patches I send.)


-- 
RMK's Patch system: https://www.armlinux.org.uk/developer/patches/
FTTP is here! 80Mbps down 10Mbps up. Decent connectivity at last!

