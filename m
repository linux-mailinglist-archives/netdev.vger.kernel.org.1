Return-Path: <netdev+bounces-154743-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 13C5A9FFA74
	for <lists+netdev@lfdr.de>; Thu,  2 Jan 2025 15:23:04 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id DC7FA160B4F
	for <lists+netdev@lfdr.de>; Thu,  2 Jan 2025 14:23:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8D84043ABD;
	Thu,  2 Jan 2025 14:23:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b="cNi+4NC5"
X-Original-To: netdev@vger.kernel.org
Received: from vps0.lunn.ch (vps0.lunn.ch [156.67.10.101])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9D0271B4259
	for <netdev@vger.kernel.org>; Thu,  2 Jan 2025 14:22:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=156.67.10.101
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1735827778; cv=none; b=f6EqWZmNWiYg1mev8Za5eicrbRb0iGBVFxpb5ZSqqhGijnKbIOLc0LK2gbifn+pH5A+X8MeMWhgalCFyQW87MTS1xvV1L2V4tO7g/pqehxNMQAu7peX1ZTnzIlK5wz71c6cfHbxfS882yPTGIamtfjjIYeNNAPoAKcStbv7WIPQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1735827778; c=relaxed/simple;
	bh=xd623UdOCSuLko0V+IV6GxDgE/RnD5adkuuZ1XhKNn8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=qfHXCvMUCcweAE8bg+Vqb9MzMLleh2CkMG72ZIg5814lP8LILsO9XqlhGAuJ32tmWy3cA7d/56B+/RwjVKu6dky9axvv3BopETCsQn47j+ywLDnIkBlflOK7AG54ADbbmhJ36JYCx3LIOMXiiln5YvOSG96gGX/u7+5CEpbbN0o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch; spf=pass smtp.mailfrom=lunn.ch; dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b=cNi+4NC5; arc=none smtp.client-ip=156.67.10.101
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lunn.ch
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=lunn.ch;
	s=20171124; h=In-Reply-To:Content-Disposition:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:From:Sender:Reply-To:Subject:
	Date:Message-ID:To:Cc:MIME-Version:Content-Type:Content-Transfer-Encoding:
	Content-ID:Content-Description:Content-Disposition:In-Reply-To:References;
	bh=NXVSXnI2Z/UNgc6rmEhjTIFedZA95rTm9J41zUgjSyo=; b=cNi+4NC5aoG6g2shujYyjnW82N
	pITjc5cLJvg1EpOQcMGb8hOE9TWr1TNn7y2wTnSIFuNQCRGahzZ5ZqmR/oZpWlhMsh6jmdcnST3kO
	hubyFMfGNfh5fWt0qRA4mV06nEU605gRza1YQIW4BRX+0JGWdPIFT0blVEu+SiOmMpec=;
Received: from andrew by vps0.lunn.ch with local (Exim 4.94.2)
	(envelope-from <andrew@lunn.ch>)
	id 1tTM59-000l7N-Ls; Thu, 02 Jan 2025 15:21:51 +0100
Date: Thu, 2 Jan 2025 15:21:51 +0100
From: Andrew Lunn <andrew@lunn.ch>
To: Francesco Valla <francesco@valla.it>
Cc: "Russell King (Oracle)" <linux@armlinux.org.uk>,
	Andrew Lunn <andrew+netdev@lunn.ch>,
	Heiner Kallweit <hkallweit1@gmail.com>, netdev@vger.kernel.org
Subject: Re: [PATCH] net: phy: don't issue a module request if a driver is
 available
Message-ID: <c94c5555-1d3a-4d81-8595-1e70c6c352f6@lunn.ch>
References: <20250101235122.704012-1-francesco@valla.it>
 <7103704.9J7NaK4W3v@fedora.fritz.box>
 <d5bbf98e-7dff-436e-9759-0d809072202f@lunn.ch>
 <2105036.YKUYFuaPT4@fedora.fritz.box>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <2105036.YKUYFuaPT4@fedora.fritz.box>

> > One other question, how much speadup do you get with async probe of
> > PHYs? Is it really worth the effort?
> 
> For me it's a reduction of ~170ms, which currently accounts for roughly the 25%
> of the time spent before starting userspace (660ms vs 490ms, give or take a
> couple of milliseconds). That's due to the large reset time required by the PHYs
> to initialize

170ms seems like a long time for a reset. Maybe check the datasheet
and see what it says.

	Andrew

