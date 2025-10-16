Return-Path: <netdev+bounces-229938-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 157FEBE23AF
	for <lists+netdev@lfdr.de>; Thu, 16 Oct 2025 10:53:39 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id E5F8B4EC0AF
	for <lists+netdev@lfdr.de>; Thu, 16 Oct 2025 08:53:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C2E7E30C373;
	Thu, 16 Oct 2025 08:53:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=armlinux.org.uk header.i=@armlinux.org.uk header.b="OL5a+pi/"
X-Original-To: netdev@vger.kernel.org
Received: from pandora.armlinux.org.uk (pandora.armlinux.org.uk [78.32.30.218])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3B21F1FE45D;
	Thu, 16 Oct 2025 08:53:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=78.32.30.218
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760604813; cv=none; b=IOe/T+YOD+cU5G/QcJxPF26Neh4QnhH1iFYBMMH2MS6Zq9M010UYzhkNcYpOcDtFpmBwp1Lbx1zTibDKDJj3d9tnz6WFOz9sARFmFuX6UTJSk12E3eBgXq1tWFTH+ke5cX9XncoQqUpFp/rPlIl+nhG6QgLngzaJug6ZxieskuM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760604813; c=relaxed/simple;
	bh=mHKkF+UuA1yf/hFWgsVVutI1TnoiqqyKMlwnCyexRLM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=BTMagBqU9V58ByEH3UQiQmuxojk3r46H9fP64yRsG7Pcthsu0p3s9VeryakCaLvK/kwzIIL57WAUgwA8FsE//mxIJCzwExxxH1LHGqSm/J/8FpD8cxZD5dcLDtbAU8LzEWpdL6dunR8lbiysGgNowKtKVfEA/aut7H4kxCrNcLI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=armlinux.org.uk; spf=none smtp.mailfrom=armlinux.org.uk; dkim=pass (2048-bit key) header.d=armlinux.org.uk header.i=@armlinux.org.uk header.b=OL5a+pi/; arc=none smtp.client-ip=78.32.30.218
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=armlinux.org.uk
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=armlinux.org.uk
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=armlinux.org.uk; s=pandora-2019; h=Sender:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
	List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
	bh=yGaGxMpVNgSqeQ9n2WyrmVjFRKdNFeYqvaUsm2e9gZw=; b=OL5a+pi/A12eJjtMu+Zl+xG+6b
	uwur0eUa7WIZGxalvgkrU+0CYfHE0zFYEV6HEsuUYO1qD48/NEPqCt29fRRdXbmjXnZQNHzn3/zcm
	VWfZtq/EEO+YOxhfIZZEQbR4/MtO1yMmVSDLfiveFUIlq+PrwACRDgA91/Y6zoF4wQJG2PbxGsFq9
	8R9HUQGN1i7joMrJXfzirY1Apw5O2q/iRtOHFGdTYjqYza0vrccSNiNq3dnlCYLWvz+D5iAMlcrbP
	7DeQuDkhZCvxu7TCdO5Q6lZFcndkcwuomyJmWnemd21nFunshOu92PgemoDsQwRlDIbSaCpR+qhB3
	hJSYpmag==;
Received: from shell.armlinux.org.uk ([fd8f:7570:feb6:1:5054:ff:fe00:4ec]:56192)
	by pandora.armlinux.org.uk with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.98.2)
	(envelope-from <linux@armlinux.org.uk>)
	id 1v9JjZ-0000000061L-2CVx;
	Thu, 16 Oct 2025 09:53:17 +0100
Received: from linux by shell.armlinux.org.uk with local (Exim 4.98.2)
	(envelope-from <linux@shell.armlinux.org.uk>)
	id 1v9JjU-0000000038g-252V;
	Thu, 16 Oct 2025 09:53:12 +0100
Date: Thu, 16 Oct 2025 09:53:12 +0100
From: "Russell King (Oracle)" <linux@armlinux.org.uk>
To: Kory Maincent <kory.maincent@bootlin.com>
Cc: Maxime Chevallier <maxime.chevallier@bootlin.com>,
	Alexandre Torgue <alexandre.torgue@foss.st.com>,
	Jose Abreu <joabreu@synopsys.com>,
	Andrew Lunn <andrew+netdev@lunn.ch>, davem@davemloft.net,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	Maxime Coquelin <mcoquelin.stm32@gmail.com>,
	Richard Cochran <richardcochran@gmail.com>,
	Alexis =?iso-8859-1?Q?Lothor=E9?= <alexis.lothore@bootlin.com>,
	Thomas Petazzoni <thomas.petazzoni@bootlin.com>,
	netdev@vger.kernel.org, linux-stm32@st-md-mailman.stormreply.com,
	linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH net-next 3/3] net: ethtool: tsconfig: Re-configure
 hwtstamp upon provider change
Message-ID: <aPCyeCOMX7FHnZkY@shell.armlinux.org.uk>
References: <20251015102725.1297985-1-maxime.chevallier@bootlin.com>
 <20251015102725.1297985-4-maxime.chevallier@bootlin.com>
 <20251015144526.23e55ee0@kmaincent-XPS-13-7390>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20251015144526.23e55ee0@kmaincent-XPS-13-7390>
Sender: Russell King (Oracle) <linux@armlinux.org.uk>

On Wed, Oct 15, 2025 at 02:45:26PM +0200, Kory Maincent wrote:
> On Wed, 15 Oct 2025 12:27:23 +0200
> Maxime Chevallier <maxime.chevallier@bootlin.com> wrote:
> 
> > When a hwprov timestamping source is changed, but without updating the
> > timestamping parameters, we may want to reconfigure the timestamping
> > source to enable the new provider.
> > 
> > This is especially important if the same HW unit implements 2 providers,
> > a precise and an approx one. In this case, we need to make sure we call
> > the hwtstamp_set operation for the newly selected provider.
> 
> This is a design choice.
> Do we want to preserve the hwtstamp config if only the hwtstamp source is
> changed from ethtool?

This depends what is meant by "preserve". If the hwtstamp capabilities
of the two sources being switched between are the same in terms of how
userspace configures them, then it's fine.

However, it's my understanding that the hwtstamp configuration is a
negotiation between kernel and userspace - drivers are required to
return back to userspace what they're actually doing when userspace
requests a certain configuration. If the hwtstamp capabilities are
different, it breaks this model because what the previous instance
reports back to userspace for a certain configuration could be
different to that which the new instance would report back.

This could get worse when a configuration is set on the previous
instance that isn't supported by the new instance.

-- 
RMK's Patch system: https://www.armlinux.org.uk/developer/patches/
FTTP is here! 80Mbps down 10Mbps up. Decent connectivity at last!

