Return-Path: <netdev+bounces-131409-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id DD44998E776
	for <lists+netdev@lfdr.de>; Thu,  3 Oct 2024 01:57:26 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 900CD1F25C8C
	for <lists+netdev@lfdr.de>; Wed,  2 Oct 2024 23:57:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7512A19F42F;
	Wed,  2 Oct 2024 23:57:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b="v6kDv0oc"
X-Original-To: netdev@vger.kernel.org
Received: from vps0.lunn.ch (vps0.lunn.ch [156.67.10.101])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D331A14B972;
	Wed,  2 Oct 2024 23:57:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=156.67.10.101
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727913440; cv=none; b=FFge5nq5dt16dWXA6UCvMJp8w+9K3BfaGZgGIqFQ8pmj1oewEAxXJS+06QhJHJp7fDZh4Y2FpuhaVDIu/VFRjO6mRot9BWl5Tc1MInLTAspXSZYPGvCiki1YLr3i2TIPad0hfY3b9kTaS2RI7YH3mJ232QPEWH9gpZ6pk8/j690=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727913440; c=relaxed/simple;
	bh=MBRHyO+e28D/r9LwjPo9VkTBkix3qJhv26tCz419R/0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=PV7Oup4G7q15egVWrXRLgA0FQ+0WcN8tcyNFCVudUac7diHDMJ+P/ldwEXLbJacTg8Hn31Nypr+cNWpSZCR4/Qqd8nr7D1mWVFuPyqY2U39ciYJppAyMwSRGEi9iP9jPugvMl9pz5+S4O2eXGl51E7wvMIpzFRjC4HT/YJObiBE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch; spf=pass smtp.mailfrom=lunn.ch; dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b=v6kDv0oc; arc=none smtp.client-ip=156.67.10.101
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lunn.ch
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=lunn.ch;
	s=20171124; h=In-Reply-To:Content-Disposition:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:From:Sender:Reply-To:Subject:
	Date:Message-ID:To:Cc:MIME-Version:Content-Type:Content-Transfer-Encoding:
	Content-ID:Content-Description:Content-Disposition:In-Reply-To:References;
	bh=5SH4G3BifOy86siuo5EL/MuoIB3QLu7HKrFwz/TS5pY=; b=v6kDv0ocxykXdFFfzSNHMJQkUd
	kFDbNSO8/Exj0oRygi1uSyf2Xwf3UT235VubsaNunfqfX6kjDtayS+yrGYSJ7joaL9CncPHb0GWEb
	MFIJn8Tihckr9+E5KXFtfLMKoXChTj0UV76ZaeqruVFfzFN3B2DKf1jIZDh+ZMWLEgeA=;
Received: from andrew by vps0.lunn.ch with local (Exim 4.94.2)
	(envelope-from <andrew@lunn.ch>)
	id 1sw9DQ-008uHc-VE; Thu, 03 Oct 2024 01:57:08 +0200
Date: Thu, 3 Oct 2024 01:57:08 +0200
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
Subject: Re: [PATCH net-next 12/12] net: pse-pd: tps23881: Add support for
 PSE events and interrupts
Message-ID: <c4b47aaa-3ae6-48cd-906f-cab8a74392ee@lunn.ch>
References: <20241002-feature_poe_port_prio-v1-0-787054f74ed5@bootlin.com>
 <20241002-feature_poe_port_prio-v1-12-787054f74ed5@bootlin.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20241002-feature_poe_port_prio-v1-12-787054f74ed5@bootlin.com>

> This patch also adds support for an OSS GPIO line to turn off all low
> priority ports in case of an over-current event.

Does this need a binding update? Or is the GPIO already listed?

	Andrew

