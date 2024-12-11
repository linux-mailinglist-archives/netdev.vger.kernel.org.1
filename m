Return-Path: <netdev+bounces-151077-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 815C89ECB97
	for <lists+netdev@lfdr.de>; Wed, 11 Dec 2024 12:54:30 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id C59261889396
	for <lists+netdev@lfdr.de>; Wed, 11 Dec 2024 11:54:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 10629211A2A;
	Wed, 11 Dec 2024 11:54:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=armlinux.org.uk header.i=@armlinux.org.uk header.b="B/G0DYw+"
X-Original-To: netdev@vger.kernel.org
Received: from pandora.armlinux.org.uk (pandora.armlinux.org.uk [78.32.30.218])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1F7541A83E4
	for <netdev@vger.kernel.org>; Wed, 11 Dec 2024 11:54:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=78.32.30.218
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733918064; cv=none; b=Q9V9c8/z8B/HUpxjOXjgFDvze3UigROphvh0GcTR0ymc7mA7pKa7F6vJEixTsFK+QVRO1VuBhgXyyeEqH4QfZjk0ceTP/mhxwo+6/SvnUm+dOlSwZilaVmT07ARGAurap+6YmDch5XGmdsvRKWkf8zlG2/DIkeyvJXILbioIF+k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733918064; c=relaxed/simple;
	bh=Wc75WMZQxMN38hQGWWKSiLo2qmsgpe7NsUEnepSZzXQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=gVR44UdwVFoBsFEWPozbjq13PaO/03O0vjVFaPTnNG6Vp/XOGSo0406jM9gdi+LZHt8eVxnyHrSHqp6IXW6XoD3DWpUkyRaOfPoEI9xKImd7PBdcAibxJDgqPxTWu9D6jc6DvXKtg7+KZuzYXbwEijB8poRtPps3kDhiLQXCrSU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=armlinux.org.uk; spf=none smtp.mailfrom=armlinux.org.uk; dkim=pass (2048-bit key) header.d=armlinux.org.uk header.i=@armlinux.org.uk header.b=B/G0DYw+; arc=none smtp.client-ip=78.32.30.218
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=armlinux.org.uk
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=armlinux.org.uk
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=armlinux.org.uk; s=pandora-2019; h=Sender:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
	List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
	bh=aqO7wh3wywXIDX7BTtlVzWRJlUYGr4hZz+O1QbSvs7U=; b=B/G0DYw+kSXB2eB+FGlGZDOiXj
	BqXBHDkQBuCxOF9rT+DvPEVYyXT6YOHp7DpmKSYmBMvxBkAtfsNvW5mCHhla2nDv+T7IFazJqcDRL
	uQyx8O1b/j4WsBuzzhGphMZLEQKeo0MhCbVQgaXh1kbLHNdTxhWKBNFE2p+S5WMFL9Rx4d7dq5rIC
	z2n6SrGRjN9ZPAdEfx7+UyULrgnOoNnEcDS8Jty0IqMkh7nSTpQONhmE7NAPP899r1r0NbOIbBBDp
	vSXnRCrNuLAzTmGPr+w82Lpp2DevL5ZIIdyWbrK9W6JMWpPP9amcIxh+kEQlSEADRXYuCZsmJPg/v
	RCF3D1OA==;
Received: from shell.armlinux.org.uk ([fd8f:7570:feb6:1:5054:ff:fe00:4ec]:33162)
	by pandora.armlinux.org.uk with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.96)
	(envelope-from <linux@armlinux.org.uk>)
	id 1tLLIB-0003qL-06;
	Wed, 11 Dec 2024 11:54:11 +0000
Received: from linux by shell.armlinux.org.uk with local (Exim 4.96)
	(envelope-from <linux@shell.armlinux.org.uk>)
	id 1tLLI8-0003us-2r;
	Wed, 11 Dec 2024 11:54:08 +0000
Date: Wed, 11 Dec 2024 11:54:08 +0000
From: "Russell King (Oracle)" <linux@armlinux.org.uk>
To: Mateusz Polchlopek <mateusz.polchlopek@intel.com>
Cc: Andrew Lunn <andrew@lunn.ch>, Heiner Kallweit <hkallweit1@gmail.com>,
	Marcin Wojtas <marcin.s.wojtas@gmail.com>,
	Andrew Lunn <andrew+netdev@lunn.ch>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	Richard Cochran <richardcochran@gmail.com>, netdev@vger.kernel.org
Subject: Re: [PATCH net-next v2] net: mvpp2: tai: warn once if we fail to
 update our timestamp
Message-ID: <Z1l9YFEbAfR3SBff@shell.armlinux.org.uk>
References: <E1tLKNm-006eTd-FD@rmk-PC.armlinux.org.uk>
 <07eeb151-008b-4b92-8db9-31cd51ec3e77@intel.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <07eeb151-008b-4b92-8db9-31cd51ec3e77@intel.com>
Sender: Russell King (Oracle) <linux@armlinux.org.uk>

On Wed, Dec 11, 2024 at 12:48:21PM +0100, Mateusz Polchlopek wrote:
> On 12/11/2024 11:55 AM, Russell King wrote:
> > The hardware timestamps for packets contain a truncated seconds field,
> > only containing two bits of seconds. In order to provide the full
> > number of seconds, we need to keep track of the full hardware clock by
> > reading it every two seconds.
> > 
> > However, if we fail to read the clock, we silently ignore the error.
> > Print a warning indicating that the PP2 TAI clock timestamps have
> > become unreliable.
> > 
> > Signed-off-by: Russell King <rmk+kernel@armlinux.org.uk>
> > --
> > v2: correct dev_warn_once() indentation
> > ---
> >   drivers/net/ethernet/marvell/mvpp2/mvpp2_tai.c | 5 ++++-
> >   1 file changed, 4 insertions(+), 1 deletion(-)
> > 
> > diff --git a/drivers/net/ethernet/marvell/mvpp2/mvpp2_tai.c b/drivers/net/ethernet/marvell/mvpp2/mvpp2_tai.c
> > index 95862aff49f1..6b60beb1f3ed 100644
> > --- a/drivers/net/ethernet/marvell/mvpp2/mvpp2_tai.c
> > +++ b/drivers/net/ethernet/marvell/mvpp2/mvpp2_tai.c
> > @@ -54,6 +54,7 @@
> >   #define TCSR_CAPTURE_0_VALID		BIT(0)
> >   struct mvpp2_tai {
> > +	struct device *dev;
> >   	struct ptp_clock_info caps;
> >   	struct ptp_clock *ptp_clock;
> >   	void __iomem *base;
> > @@ -303,7 +304,8 @@ static long mvpp22_tai_aux_work(struct ptp_clock_info *ptp)
> >   {
> >   	struct mvpp2_tai *tai = ptp_to_tai(ptp);
> > -	mvpp22_tai_gettimex64(ptp, &tai->stamp, NULL);
> > +	if (mvpp22_tai_gettimex64(ptp, &tai->stamp, NULL) < 0)
> > +		dev_warn_once(tai->dev, "PTP timestamps are unreliable");
> 
> Only small nitpick/question - shouldn't text end with '\n'? I see in the
> code that most of calls of dev_warn_once has '\n' at the end.

Yes, thanks for spotting.

-- 
RMK's Patch system: https://www.armlinux.org.uk/developer/patches/
FTTP is here! 80Mbps down 10Mbps up. Decent connectivity at last!

