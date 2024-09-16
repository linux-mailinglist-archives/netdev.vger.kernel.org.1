Return-Path: <netdev+bounces-128593-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D76F297A7CD
	for <lists+netdev@lfdr.de>; Mon, 16 Sep 2024 21:31:38 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id E85801C21D11
	for <lists+netdev@lfdr.de>; Mon, 16 Sep 2024 19:31:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 155066A33A;
	Mon, 16 Sep 2024 19:31:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=armlinux.org.uk header.i=@armlinux.org.uk header.b="0DXf8eai"
X-Original-To: netdev@vger.kernel.org
Received: from pandora.armlinux.org.uk (pandora.armlinux.org.uk [78.32.30.218])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 339A410A18;
	Mon, 16 Sep 2024 19:31:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=78.32.30.218
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726515093; cv=none; b=KC+oQRV+5s6kI0vcsz+H8h8Sw+Nsx2AxSE70GjVjGFlk+ZSPNHW+Gkbxhs9qIr1zn1TqdaaLSkfz+N8qKLDvU89gCAhAaOdAA6Kg69qnZxzlWI3ljR8XZau5msgOyyZRk9kGN2CO9JtYekcNjJtxSW95Wl7hcW8DPBQWsyKP3Tk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726515093; c=relaxed/simple;
	bh=VGZ5UzmKkzEYQaRjK5SJlhiA/OLYN910/efsdTsxmIA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=uMfekRRr/4h3qVyAT6bH68+SZOkDCJT3XfZaZtCny9rviIE63GudzsT0AsLBAsH1f/pZMCpswKBYYh0ucgY8tN3QGtFHUkJ6WK9RL7yAh373PIDwcnPRx5MoXPn2SqgewzHiMB+WqkrDxKtggplaW/cs+RZBFo9UKCgzXap4Ing=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=armlinux.org.uk; spf=none smtp.mailfrom=armlinux.org.uk; dkim=pass (2048-bit key) header.d=armlinux.org.uk header.i=@armlinux.org.uk header.b=0DXf8eai; arc=none smtp.client-ip=78.32.30.218
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=armlinux.org.uk
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=armlinux.org.uk
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=armlinux.org.uk; s=pandora-2019; h=Sender:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
	List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
	bh=hK+swyLRKLV/AdJcmTvc0GeACDQuJQuPXvg921aARx0=; b=0DXf8eai1CfeLaytMhe1Wl2s+I
	qiVFjHkBxp83TsaaNbKXmuRFwDQLa8AnZF2HH22oiEcd+Ox0sOGHpUcf9If2UrHVbWd94Ve24DMxr
	Kzsh+FKd9DR0Wcfcs3RoGMGqrQ5h5NY0vakJtJz1fDjl0/Klaw/rvoQnHijaR3kpz4KcfDRjZMSd3
	FIdo+Gh/AZsGiVt0gjA72UanRxyFEjRKEVqsd4UtZ+k1MGtBm8Ig0+qzQBZA67r7F+vCsm5Yup1pA
	eZHgUeIKN4BpkfhLqpr6hftYmpppXbPGzYhn5e0h3unqBGCt7pcysx5ZOQAPziWsRrnPfpwqbG13X
	3hXqA7tg==;
Received: from shell.armlinux.org.uk ([fd8f:7570:feb6:1:5054:ff:fe00:4ec]:43604)
	by pandora.armlinux.org.uk with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.96)
	(envelope-from <linux@armlinux.org.uk>)
	id 1sqHRU-0006Jw-1B;
	Mon, 16 Sep 2024 20:31:24 +0100
Received: from linux by shell.armlinux.org.uk with local (Exim 4.96)
	(envelope-from <linux@shell.armlinux.org.uk>)
	id 1sqHRO-0007Df-0o;
	Mon, 16 Sep 2024 20:31:18 +0100
Date: Mon, 16 Sep 2024 20:31:18 +0100
From: "Russell King (Oracle)" <linux@armlinux.org.uk>
To: Raju Lakkaraju <Raju.Lakkaraju@microchip.com>
Cc: Christophe JAILLET <christophe.jaillet@wanadoo.fr>,
	netdev@vger.kernel.org, davem@davemloft.net, edumazet@google.com,
	kuba@kernel.org, pabeni@redhat.com, bryan.whitehead@microchip.com,
	UNGLinuxDriver@microchip.com, maxime.chevallier@bootlin.com,
	rdunlap@infradead.org, andrew@lunn.ch, Steen.Hegelund@microchip.com,
	daniel.machon@microchip.com, linux-kernel@vger.kernel.org
Subject: Re: [PATCH net-next V2 2/5] net: lan743x: Add support to
 software-nodes for sfp
Message-ID: <ZuiHhoxi05IOWphr@shell.armlinux.org.uk>
References: <20240911161054.4494-1-Raju.Lakkaraju@microchip.com>
 <20240911161054.4494-3-Raju.Lakkaraju@microchip.com>
 <c93c4fe2-e3bb-4ee9-be17-ca8cb9206386@wanadoo.fr>
 <ZuKLGYThw8xBKw7E@HYD-DK-UNGSW21.microchip.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ZuKLGYThw8xBKw7E@HYD-DK-UNGSW21.microchip.com>
Sender: Russell King (Oracle) <linux@armlinux.org.uk>

On Thu, Sep 12, 2024 at 12:02:57PM +0530, Raju Lakkaraju wrote:
> Hi Christophe,
> 
> The 09/11/2024 18:54, Christophe JAILLET wrote:
> > > +static int pci1xxxx_i2c_adapter_get(struct lan743x_adapter *adapter)
> > > +{
> > > +     struct pci1xxxx_i2c *i2c_drvdata;
> > > +
> > > +     i2c_drvdata = pci1xxxx_perif_drvdata_get(adapter, PCI1XXXX_PERIF_I2C_ID);
> > > +     if (!i2c_drvdata)
> > > +             return -EPROBE_DEFER;
> > > +
> > > +     adapter->i2c_adap = &i2c_drvdata->adap;
> > > +     snprintf(adapter->nodes->i2c_name, sizeof(adapter->nodes->i2c_name),
> > > +              adapter->i2c_adap->name);
> > 
> > strscpy() ?
> > 
> 
> Accepted. I will fix.
> Here snprintf( ) does not take any format string, we can use strscpy( ).

As a general tip for safe programming... never use snprintf() as a
"short cut" for copying strings. It may do stuff that you don't
expect!

For example, taking the above case, if "adapter->i2c_adap->name"
contains any % characters, then, as you are passing it as the
_format_ _string_, sprintf() will try to interpret those as printf
escape sequences, and thus _can_ attempt to dereference arguments
that were never passed to snprintf().

If you really want to do this kind of thing, at least write it in
a safe way...

	snprintf(..., "%s", string);

rather than:

	snprintf(..., string);

so that "string" doesn't attempt to be escape-expanded.

Of course, using proper string copying functions that do what you
want in a cheap way is always more preferable to the printf related
functions!

-- 
RMK's Patch system: https://www.armlinux.org.uk/developer/patches/
FTTP is here! 80Mbps down 10Mbps up. Decent connectivity at last!

