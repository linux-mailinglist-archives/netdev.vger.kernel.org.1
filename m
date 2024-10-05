Return-Path: <netdev+bounces-132424-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 2C73C991AC4
	for <lists+netdev@lfdr.de>; Sat,  5 Oct 2024 23:00:32 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 5C49B1C21575
	for <lists+netdev@lfdr.de>; Sat,  5 Oct 2024 21:00:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 07BB614F9D7;
	Sat,  5 Oct 2024 21:00:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b="DCprOD8s"
X-Original-To: netdev@vger.kernel.org
Received: from vps0.lunn.ch (vps0.lunn.ch [156.67.10.101])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EC63C130E4A;
	Sat,  5 Oct 2024 21:00:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=156.67.10.101
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728162026; cv=none; b=noeOxZKwOAX7yA3b2t8D4Ewd42vJhO4t8NNG7SSNFB2e06mfNE5c6tNnmFdEzJvN/DnFF7ZbYZPZhBa49Dy1Z7ueMdQlsn2faQApttbtfBUsHp5Yg8RcBvK7WS0Qvolm1wHnkk516+1VsR84borafS9vdFNLh8d8UyW17oj8H9o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728162026; c=relaxed/simple;
	bh=ScASTPT6AFh97GPbahkq9aC3gQvnOL51RNtY8Bpu5RU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=svVEPDLlf2+AsfoQGu6Dx2Y2jCG+1NNHO47IJ16D1Lbkuwbyw+2QZYFfmcMWPfaDjZlWdHG2L/EzODx/pUlpn0hwfd02Lyxti5uNLxgZRl8qXQIoys/fbEcMjeRpsckXnG3UPQ0LhuUK2+5c+yaqH1eNRslNaycKYKRQRgUimhU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch; spf=pass smtp.mailfrom=lunn.ch; dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b=DCprOD8s; arc=none smtp.client-ip=156.67.10.101
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lunn.ch
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=lunn.ch;
	s=20171124; h=In-Reply-To:Content-Transfer-Encoding:Content-Disposition:
	Content-Type:MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:From:
	Sender:Reply-To:Subject:Date:Message-ID:To:Cc:MIME-Version:Content-Type:
	Content-Transfer-Encoding:Content-ID:Content-Description:Content-Disposition:
	In-Reply-To:References; bh=v9RB8vqr/xYm2/eGxjNdNn7s+S6YhBoDtDg3ougf7u0=; b=DC
	prOD8sH0lfjt9prLI/Tv7bYHOadNyN2p+/yCB18FdmXr2kK3ij34KAqHQI4AbuWjMjlZiNxcpINcl
	sfzczekhHJkAfVmIFy/YYfP4TOfxFfozpvFNv9YVSIVLfak5pc+iZcTzwRukfIhiI9IA7QDGRg0PY
	zGYm1rICXmX4d9s=;
Received: from andrew by vps0.lunn.ch with local (Exim 4.94.2)
	(envelope-from <andrew@lunn.ch>)
	id 1sxBsr-0099WQ-5Z; Sat, 05 Oct 2024 23:00:13 +0200
Date: Sat, 5 Oct 2024 23:00:13 +0200
From: Andrew Lunn <andrew@lunn.ch>
To: Mohammed Anees <pvmohammedanees2003@gmail.com>
Cc: davem@davemloft.net, edumazet@google.com, f.fainelli@gmail.com,
	kuba@kernel.org, linux-kernel@vger.kernel.org,
	linux@armlinux.org.uk, netdev@vger.kernel.org, olteanv@gmail.com,
	pabeni@redhat.com
Subject: Re: [PATCH] net: dsa: Fix conditional handling of Wake-on-Lan
 configuration in dsa_user_set_wol
Message-ID: <0d151801-f27c-4f53-9fb1-ce459a861b82@lunn.ch>
References: <8555d3b6-8154-4a79-9828-352641ca0a58@lunn.ch>
 <20241005184235.22421-1-pvmohammedanees2003@gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20241005184235.22421-1-pvmohammedanees2003@gmail.com>

On Sun, Oct 06, 2024 at 12:12:33AM +0530, Mohammed Anees wrote:
> In the original code, we initialize ret = -EOPNOTSUPP and then call 
> phylink_ethtool_set_wol(). If DSA supports WOL, we call set_wol(). 
> However, we aren’t checking if phylink_ethtool_set_wol() succeeds, 
> so I assumed both functions should be called, and if either fails,
> we return -EOPNOTSUPP.
> 
> 
> static int dsa_user_set_wol(struct net_device *dev, struct ethtool_wolinfo *w)
> {
> 	struct dsa_port *dp = dsa_user_to_port(dev);
> 	struct dsa_switch *ds = dp->ds;
> 	int ret = -EOPNOTSUPP;
> 
> 	phylink_ethtool_set_wol(dp->pl, w);
> 
> 	if (ds->ops->set_wol)
> 		ret = ds->ops->set_wol(ds, dp->index, w);
> 
> 	return ret;
> }
> 
> >From your response, it seems either of the two function can handle setting 
> WOL, if so shouldn't we check the return value of phylink_ethtool_set_wol() 
> to ensure it succeeds?

It is actually a bit more subtle than that, and i think everything
gets it wrong. Yes, we should check the return code from
phylink_ethtool_set_wol. If it does not return an error, we are
done. If it returns an error other than EOPNOTSUPP, it should return
it. And in the case of EOPNOTSUPP we should try to see if DSA supports
the WoL mode. And this is probably an over simplification. ethtool man
page says:

          wol p|u|m|b|a|g|s|f|d...
                  Sets Wake-on-LAN options.  Not all devices support this.  The
                  argument to this option is a string of characters  specifying
                  which options to enable.
                  p   Wake on PHY activity
                  u   Wake on unicast messages
                  m   Wake on multicast messages
                  b   Wake on broadcast messages
                  a   Wake on ARP
                  g   Wake on MagicPacket™
                  s   Enable SecureOn™ password for MagicPacket™
                  f   Wake on filter(s)
                  d   Disable  (wake  on  nothing).  This option
                      clears all previous options.

So userspace could say pumbagsf, with the PHY supporting pmub and the
MAC supporting agsf, and the two need to cooperate.

get_wol() needs to call both phylink_ethtool_get_wol() and dsa
get_wol, and combine the results.

	Andrew

