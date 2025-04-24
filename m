Return-Path: <netdev+bounces-185595-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 0D701A9B113
	for <lists+netdev@lfdr.de>; Thu, 24 Apr 2025 16:36:06 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 88E1D1941FAC
	for <lists+netdev@lfdr.de>; Thu, 24 Apr 2025 14:35:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B74C7155C83;
	Thu, 24 Apr 2025 14:34:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b="A0AnKotE"
X-Original-To: netdev@vger.kernel.org
Received: from vps0.lunn.ch (vps0.lunn.ch [156.67.10.101])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D804478F2D;
	Thu, 24 Apr 2025 14:34:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=156.67.10.101
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745505279; cv=none; b=RnSFADXyZm+fUl/9eUJwP47JX/iihc6kx0ehpIUYtfJnNe1VgI8ymPlC638KhW5DymONJ8tYpZWvqxZ258U2GT+1uzrMAfjeB67b0IXWO10gSBm5HUbZU4Qui6z/cNiQPduEVUmpml1wQXdVVu280sK/7hQOPNmIajWpMkCrUJs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745505279; c=relaxed/simple;
	bh=N5x8Q2Rtm6QOgQXSotXHqtHIw+J1TfNo82tMF3wwHPU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Y/lBCS8Z6c3OPvaGPFnZDktZKZbzMrFXTc1hLdA465X6urdaE4xudqXRKpfzgFgdFfUwifebNkrW3zSCYgNlrJvE2llI/CT4iuAUlaJUbJXCyLcJvN/cRYCP5ebLaYJWnuGmGpLqvWfxLf1xzdPz1aNB+HgDoFaRhrXWgrO/NVE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch; spf=pass smtp.mailfrom=lunn.ch; dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b=A0AnKotE; arc=none smtp.client-ip=156.67.10.101
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lunn.ch
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=lunn.ch;
	s=20171124; h=In-Reply-To:Content-Disposition:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:From:Sender:Reply-To:Subject:
	Date:Message-ID:To:Cc:MIME-Version:Content-Type:Content-Transfer-Encoding:
	Content-ID:Content-Description:Content-Disposition:In-Reply-To:References;
	bh=HLdrHvKgL2r7FEcbNA5oSIPt8Kl3IHS6iUHcW2h0DFU=; b=A0AnKotE7i/6YTmaTlQrNahIQ9
	uKrGeuVhcZ2b1GaBzKlRWg1xtvcJ5Pi/q30OoxyL2P+SZbWH0gjdadxXo9vZk1i+NLFdtH5ipm6WD
	2FSzknsD0+awMwLFxnXsGpWuxnQC+C4WAuKrs80PXjFLSCyYU5YobZeHxBcZ4rwPRiFQ=;
Received: from andrew by vps0.lunn.ch with local (Exim 4.94.2)
	(envelope-from <andrew@lunn.ch>)
	id 1u7xel-00ATPZ-R9; Thu, 24 Apr 2025 16:34:27 +0200
Date: Thu, 24 Apr 2025 16:34:27 +0200
From: Andrew Lunn <andrew@lunn.ch>
To: "Russell King (Oracle)" <linux@armlinux.org.uk>
Cc: Oleksij Rempel <o.rempel@pengutronix.de>,
	Woojung Huh <woojung.huh@microchip.com>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	Heiner Kallweit <hkallweit1@gmail.com>, kernel@pengutronix.de,
	linux-kernel@vger.kernel.org, netdev@vger.kernel.org,
	UNGLinuxDriver@microchip.com, Simon Horman <horms@kernel.org>,
	Maxime Chevallier <maxime.chevallier@bootlin.com>
Subject: Re: [PATCH net-next v1 4/4] net: phy: Always read EEE LPA in
 genphy_c45_ethtool_get_eee()
Message-ID: <8f0d5725-04b7-4e15-897d-1fd5e540dacb@lunn.ch>
References: <20250424130222.3959457-1-o.rempel@pengutronix.de>
 <20250424130222.3959457-5-o.rempel@pengutronix.de>
 <aAo5keWOAVWxj9_o@shell.armlinux.org.uk>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <aAo5keWOAVWxj9_o@shell.armlinux.org.uk>

On Thu, Apr 24, 2025 at 02:16:01PM +0100, Russell King (Oracle) wrote:
> On Thu, Apr 24, 2025 at 03:02:22PM +0200, Oleksij Rempel wrote:
> > Previously, genphy_c45_ethtool_get_eee() used genphy_c45_eee_is_active(),
> > which skips reading the EEE LPA register if local EEE is disabled. This
> > prevents ethtool from reporting the link partner's EEE capabilities in
> > that case.
> > 
> > Replace it with genphy_c45_read_eee_lpa(), which always reads the LPA
> > register regardless of local EEE state. This allows users to see the
> > link partner's EEE advertisement even when EEE is disabled locally.
> > 
> > Example before the patch:
> > 
> >   EEE settings for lan1:
> >           EEE status: disabled
> >           Tx LPI: disabled
> >           Supported EEE link modes:  100baseT/Full
> >                                      1000baseT/Full
> >           Advertised EEE link modes:  Not reported
> >           Link partner advertised EEE link modes:  Not reported
> > 
> > After the patch:
> > 
> >   EEE settings for lan1:
> >           EEE status: disabled
> >           Tx LPI: disabled
> >           Supported EEE link modes:  100baseT/Full
> >                                      1000baseT/Full
> >           Advertised EEE link modes:  Not reported
> >           Link partner advertised EEE link modes:  100baseT/Full
> >                                                    1000baseT/Full
> 
> Seems to me this takes the opposite view to patch 3... not sure there's
> much consistency here.

+1

> However, I've no objection to reading the LPA EEE state and
> reporting it.

What happens with normal link mode LPA when autoneg is disabled? I
guess they are not reported because the PHY is not even listening for
the autoneg pulses. We could be inconsistent between normal LPA and
LPA EEE, but is that a good idea?

	Andrew

