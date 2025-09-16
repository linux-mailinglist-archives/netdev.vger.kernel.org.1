Return-Path: <netdev+bounces-223550-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 1A8BBB597DA
	for <lists+netdev@lfdr.de>; Tue, 16 Sep 2025 15:38:40 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id CE6A1161758
	for <lists+netdev@lfdr.de>; Tue, 16 Sep 2025 13:38:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1AD603019BE;
	Tue, 16 Sep 2025 13:38:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=armlinux.org.uk header.i=@armlinux.org.uk header.b="v5gj2Erz"
X-Original-To: netdev@vger.kernel.org
Received: from pandora.armlinux.org.uk (pandora.armlinux.org.uk [78.32.30.218])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 047E51C2DB2
	for <netdev@vger.kernel.org>; Tue, 16 Sep 2025 13:38:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=78.32.30.218
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758029918; cv=none; b=NYSM3R7mrFvFDDv02+YTquCeZuDm8KRJzOFM8OFW1fuaYX8L0pqQM2xyxEnCyRNVD4k6EH5DgkX+AynkrUozbfK/tMjq+z9Y2fHnFTGQlUoerGUHELgHTVvEwIGXyKG1UOHm5zBDuKkkLCi9HN5ZYpBy7hf2hTao17oqeYlHOmY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758029918; c=relaxed/simple;
	bh=RUIOFUyGAU9lf/b6ffnhbghIz3X/+a8GFkJzvSDd0UA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=BIau+ia4r8OWHnfgJoGxwxdMR2nCLSYMOpNSdOuePchoixhZ+ZQhIGtcYw8X/FeRofTbLWcYJ07F0lRIPMwtZV4gJnV307ZEgWguFuW/9nnN9EEMCWGv+KiCj6CvqbV7T/F0yYX9kZpi1XKE9dq0F9qBit3CkFZ+0sdXRRL1RAs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=armlinux.org.uk; spf=none smtp.mailfrom=armlinux.org.uk; dkim=pass (2048-bit key) header.d=armlinux.org.uk header.i=@armlinux.org.uk header.b=v5gj2Erz; arc=none smtp.client-ip=78.32.30.218
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=armlinux.org.uk
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=armlinux.org.uk
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=armlinux.org.uk; s=pandora-2019; h=Sender:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
	List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
	bh=WPVN6uX7KvmtEwe9ZmBY3J+N/O0DGcQ0FgQs3IdZ+84=; b=v5gj2ErzdPrRuimce0O2nKewK0
	pwYRtdVSMcZzmSOhsvXE9lvCpL67O6yNeI/hiiCAiT/w2NcXgzxF21fIBjl8Ks61MRzM7O1XcWsde
	14/Bq2FY00clRhJFC8zJaxZR5fKdm6chntG8wATe/Apckz7fTodaIXn5+GCAh2nCs2Jj0yaqQLwVP
	MAUJiIFm99au241Bo5lzaYZN83D6kfMUz4rjd9eKMubrsRhbrLh+ZbU+YSLdz3JMWcZWODnDpTvJu
	rFf0Qa9DB+Iqzil89VqCKUdYDTLB6MEzIf2z6knfQ3VNuPi3jpi+HXixeGOkDlzp0RxK8ELvic4pg
	Cluj0nqg==;
Received: from shell.armlinux.org.uk ([fd8f:7570:feb6:1:5054:ff:fe00:4ec]:58202)
	by pandora.armlinux.org.uk with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.98.2)
	(envelope-from <linux@armlinux.org.uk>)
	id 1uyVt3-000000004fD-2eCm;
	Tue, 16 Sep 2025 14:38:25 +0100
Received: from linux by shell.armlinux.org.uk with local (Exim 4.98.2)
	(envelope-from <linux@shell.armlinux.org.uk>)
	id 1uyVt1-000000007ga-1Nb3;
	Tue, 16 Sep 2025 14:38:23 +0100
Date: Tue, 16 Sep 2025 14:38:23 +0100
From: "Russell King (Oracle)" <linux@armlinux.org.uk>
To: Wei Fang <wei.fang@nxp.com>
Cc: Ajay Kaher <ajay.kaher@broadcom.com>,
	Alexey Makhalov <alexey.makhalov@broadcom.com>,
	Andrew Lunn <andrew+netdev@lunn.ch>,
	Richard Cochran <richardcochran@gmail.com>,
	Broadcom internal kernel review list <bcm-kernel-feedback-list@broadcom.com>,
	Clark Wang <xiaoning.wang@nxp.com>,
	"David S. Miller" <davem@davemloft.net>,
	David Woodhouse <dwmw2@infradead.org>,
	Eric Dumazet <edumazet@google.com>,
	"imx@lists.linux.dev" <imx@lists.linux.dev>,
	Jakub Kicinski <kuba@kernel.org>,
	Jonathan Lemon <jonathan.lemon@gmail.com>,
	"netdev@vger.kernel.org" <netdev@vger.kernel.org>,
	Nick Shi <nick.shi@broadcom.com>, Paolo Abeni <pabeni@redhat.com>,
	Sven Schnelle <svens@linux.ibm.com>,
	Vadim Fedorenko <vadim.fedorenko@linux.dev>,
	Vladimir Oltean <vladimir.oltean@nxp.com>,
	"Y.B. Lu" <yangbo.lu@nxp.com>
Subject: Re: [PATCH net-next 2/2] ptp: rework ptp_clock_unregister() to
 disable events
Message-ID: <aMloTwObRUIRAzPF@shell.armlinux.org.uk>
References: <aMglp11mUGk9PAvu@shell.armlinux.org.uk>
 <E1uyAP7-00000005lGq-3FqI@rmk-PC.armlinux.org.uk>
 <PAXPR04MB851098C0A69B74DD232071B68814A@PAXPR04MB8510.eurprd04.prod.outlook.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <PAXPR04MB851098C0A69B74DD232071B68814A@PAXPR04MB8510.eurprd04.prod.outlook.com>
Sender: Russell King (Oracle) <linux@armlinux.org.uk>

On Tue, Sep 16, 2025 at 09:03:17AM +0000, Wei Fang wrote:
> > the ordering of ptp_clock_unregister() is not ideal, as the chardev
>  ^
> Nit: Uppercase, 't' -> 'T'
> 
> > +void ptp_disable_all_pins(struct ptp_clock *ptp)
> > +{
> > +	struct ptp_clock_info *info = ptp->info;
> > +	unsigned int i;
> > +
> > +	mutex_lock(&ptp->pincfg_mux);
> 
> Currently ptp_chardev.c has been converted to use the auto-cleanup
> API (scoped_cond_guard()), so scoped_guard() can be used here.

... which are very non-C like, non-obvious, and I currently have no
idea at the moment how to use it. In my opinion, it makes code more
difficult to understand.

Maybe someone else can convert this for me to this non-C like
structure?

-- 
RMK's Patch system: https://www.armlinux.org.uk/developer/patches/
FTTP is here! 80Mbps down 10Mbps up. Decent connectivity at last!

