Return-Path: <netdev+bounces-131399-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id E03CD98E6C5
	for <lists+netdev@lfdr.de>; Thu,  3 Oct 2024 01:26:24 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 6C9E41F23943
	for <lists+netdev@lfdr.de>; Wed,  2 Oct 2024 23:26:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7298A19E994;
	Wed,  2 Oct 2024 23:26:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b="i+Op85Pn"
X-Original-To: netdev@vger.kernel.org
Received: from vps0.lunn.ch (vps0.lunn.ch [156.67.10.101])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E4A8D16419;
	Wed,  2 Oct 2024 23:26:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=156.67.10.101
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727911581; cv=none; b=OEiMy83QbO8DpEuvwyq1m/Ob6MPW72r59hLo+6TQ40fwYZRDXbYkngRSYPRRJyAf3zuiX1tph4pfmVYYlzOwyHsO8eqBj3yGa2h2Z9+Lsbl9Fquru5cDVT6mE+H8zFmQaEFE/y8XKkeKe/5VvnGyEAkcSfFVD0QZ1JulXrkx2QU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727911581; c=relaxed/simple;
	bh=yZNHKaTLtMAbMW24wyiw29Fe81kmCEbsMQ1tmPG/Ank=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=XN6JZTVcwufFbUwOZmS2BKGzOpdQjOrqvKo8UHw6O6A8GTNa7NiV1um8iAkWg8QZI7KsrlRviPvOxvugVE5WotWVevUN+/oWBN78A3cbb9F9DYySwN3SKC9oc37XzH1Ft8rhgEAEtGabSW7KNtScdismGR1X5wvQ+ts652Dj8vs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch; spf=pass smtp.mailfrom=lunn.ch; dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b=i+Op85Pn; arc=none smtp.client-ip=156.67.10.101
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lunn.ch
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=lunn.ch;
	s=20171124; h=In-Reply-To:Content-Disposition:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:From:Sender:Reply-To:Subject:
	Date:Message-ID:To:Cc:MIME-Version:Content-Type:Content-Transfer-Encoding:
	Content-ID:Content-Description:Content-Disposition:In-Reply-To:References;
	bh=sI/1hhhu/ac6CTT2bdevVmr+eIeXpxcozXiTF1KwsPc=; b=i+Op85Pn/tOZKxpzYABdMnSyDh
	fZKpSe8GwqvrEi92bcLDYgTjKfMZdNZM+o02bmHsBKbLhV+Fw8YHvNAOUEea8jsYHI7Mu5YH2IqS9
	A/stAEF9aI8Ba3V74Ia7zjzAodlQxBTX7XsOo5+1rPt6rg07Lg37/FyUNuy3b5ml0Ct4=;
Received: from andrew by vps0.lunn.ch with local (Exim 4.94.2)
	(envelope-from <andrew@lunn.ch>)
	id 1sw8jT-008u5o-I8; Thu, 03 Oct 2024 01:26:11 +0200
Date: Thu, 3 Oct 2024 01:26:11 +0200
From: Andrew Lunn <andrew@lunn.ch>
To: Kory Maincent <kory.maincent@bootlin.com>
Cc: Oleksij Rempel <o.rempel@pengutronix.de>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	Jonathan Corbet <corbet@lwn.net>,
	Donald Hunter <donald.hunter@gmail.com>,
	Thomas Petazzoni <thomas.petazzoni@bootlin.com>,
	linux-kernel@vger.kernel.org, netdev@vger.kernel.org,
	linux-doc@vger.kernel.org, Kyle Swenson <kyle.swenson@est.tech>,
	Dent Project <dentproject@linuxfoundation.org>,
	kernel@pengutronix.de
Subject: Re: [PATCH net-next 03/12] net: pse-pd: tps23881: Simplify function
 returns by removing redundant checks
Message-ID: <3dfaff0d-655a-4719-9204-36302eceef5c@lunn.ch>
References: <20241002-feature_poe_port_prio-v1-0-787054f74ed5@bootlin.com>
 <20241002-feature_poe_port_prio-v1-3-787054f74ed5@bootlin.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20241002-feature_poe_port_prio-v1-3-787054f74ed5@bootlin.com>

On Wed, Oct 02, 2024 at 06:27:59PM +0200, Kory Maincent wrote:
> From: Kory Maincent (Dent Project) <kory.maincent@bootlin.com>
> 
> Cleaned up several functions in tps23881 by removing redundant checks on
> return values at the end of functions. These check has been removed, and
> the return statement now directly returns the function result, reducing
> the code's complexity and making it more concise.
> 
> Signed-off-by: Kory Maincent <kory.maincent@bootlin.com>

Reviewed-by: Andrew Lunn <andrew@lunn.ch>

    Andrew

