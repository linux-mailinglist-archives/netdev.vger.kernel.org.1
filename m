Return-Path: <netdev+bounces-142967-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 86FFD9C0D02
	for <lists+netdev@lfdr.de>; Thu,  7 Nov 2024 18:36:40 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id B8C771C237FD
	for <lists+netdev@lfdr.de>; Thu,  7 Nov 2024 17:36:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5484421642A;
	Thu,  7 Nov 2024 17:36:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b="aKJgnjX+"
X-Original-To: netdev@vger.kernel.org
Received: from vps0.lunn.ch (vps0.lunn.ch [156.67.10.101])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D46C52161E6;
	Thu,  7 Nov 2024 17:36:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=156.67.10.101
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731000996; cv=none; b=iFbX+TS4xUbYU3LyqA9NkGJmj3+XWL/DfSIopnPZaW/332VXkS7nEBz1CgUxZTa+W0gsZvyK8d0sfONt0PqZoP01vw8xbjkO49zRp3htHsPq8g1xZOmMJ3zQK/uzrJrOcDbYQr0IoMitpf2Yf63bGKtvWi5GXRZZpt3iplKJURE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731000996; c=relaxed/simple;
	bh=onNZn4qx9S++LmYj882hex73KbGIA9VLQZ7X7Az/Nko=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=gm2wMoiSGF/CiKhtU+phfftGXa6ApMBJaimUMDE+rei10DvfauMuJT0ipArGnJKjGCqzyE+hlJBFtmJIP5uIytbGblKh5lAKjrCmOQ5GVfHNAApStynQKUqmMJuF9PtCjP3ikkFkMLBGqGJ7uaN0DaM5hsC+BYun90xxXZ+YprY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch; spf=pass smtp.mailfrom=lunn.ch; dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b=aKJgnjX+; arc=none smtp.client-ip=156.67.10.101
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lunn.ch
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=lunn.ch;
	s=20171124; h=In-Reply-To:Content-Disposition:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:From:Sender:Reply-To:Subject:
	Date:Message-ID:To:Cc:MIME-Version:Content-Type:Content-Transfer-Encoding:
	Content-ID:Content-Description:Content-Disposition:In-Reply-To:References;
	bh=T6bHPI18tVLVeYJB4q1sHZ135CJsdmYKJyxnRPGYcWo=; b=aKJgnjX+vMQj6AQVYuPKmg/Wfk
	IuuX+Akhp7STCWM8QdrpzbU+LuTaOjxWVlKB36jv1f8ZCPDdnBPwzwOh+Ga2uOT4rik2oiFUwt3ft
	LqBkLi2je+8sUApsu0e4+IKebfoLV5EmlDu2KYU9hmFBvZj5pHHykpSIeKgM6DJVxMfg=;
Received: from andrew by vps0.lunn.ch with local (Exim 4.94.2)
	(envelope-from <andrew@lunn.ch>)
	id 1t96Qk-00CUQf-SP; Thu, 07 Nov 2024 18:36:26 +0100
Date: Thu, 7 Nov 2024 18:36:26 +0100
From: Andrew Lunn <andrew@lunn.ch>
To: Maxime Chevallier <maxime.chevallier@bootlin.com>
Cc: davem@davemloft.net, Jakub Kicinski <kuba@kernel.org>,
	Eric Dumazet <edumazet@google.com>, Paolo Abeni <pabeni@redhat.com>,
	Russell King <linux@armlinux.org.uk>,
	Christophe Leroy <christophe.leroy@csgroup.eu>,
	Heiner Kallweit <hkallweit1@gmail.com>, netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org, thomas.petazzoni@bootlin.com,
	Herve Codina <herve.codina@bootlin.com>,
	Uwe =?iso-8859-1?Q?Kleine-K=F6nig?= <u.kleine-koenig@baylibre.com>,
	linuxppc-dev@lists.ozlabs.org
Subject: Re: [PATCH net-next 2/7] net: freescale: ucc_geth: split adjust_link
 for phylink conversion
Message-ID: <9dcbc2ce-3d81-49ae-a6d6-2fc96df422c8@lunn.ch>
References: <20241107170255.1058124-1-maxime.chevallier@bootlin.com>
 <20241107170255.1058124-3-maxime.chevallier@bootlin.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20241107170255.1058124-3-maxime.chevallier@bootlin.com>

On Thu, Nov 07, 2024 at 06:02:49PM +0100, Maxime Chevallier wrote:
> Preparing the phylink conversion, split the adjust_link callbaclk, by
> clearly separating the mac configuration, link_up and link_down phases.
> 
> Signed-off-by: Maxime Chevallier <maxime.chevallier@bootlin.com>

Reviewed-by: Andrew Lunn <andrew@lunn.ch>

    Andrew

