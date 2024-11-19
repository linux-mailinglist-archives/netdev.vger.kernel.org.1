Return-Path: <netdev+bounces-146294-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 8DBF59D2AB2
	for <lists+netdev@lfdr.de>; Tue, 19 Nov 2024 17:21:02 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 2F9CC1F235C0
	for <lists+netdev@lfdr.de>; Tue, 19 Nov 2024 16:21:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2BD291D0E0A;
	Tue, 19 Nov 2024 16:20:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b="VWmOj0dL"
X-Original-To: netdev@vger.kernel.org
Received: from vps0.lunn.ch (vps0.lunn.ch [156.67.10.101])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1D6E71D0DE6;
	Tue, 19 Nov 2024 16:20:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=156.67.10.101
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732033245; cv=none; b=RbLFpMdgqw8sWVN6Sn4bnlhegzXLDsZgzSbFvcEYYnZAfkmhCprINpP4v2NMrVRuXhv9FNiffWbdTgleMyZGxjISd9p5ONe9uzy7pUoF10SJ1RuB+pZDreX9LN6r/4dDqU8RuGcOKYz1RAKPd2tiHvU4p+aSyDYH1moHID4t5N0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732033245; c=relaxed/simple;
	bh=/OeQ9IC9XtCJF9VlCTnneCePK0BnZfneZJ10PUHr+i0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=LtJA9RMOlYdIw42d0tmr8Qkkh8i43l/IXyhwFqF/s3NIHBmxeyv8rlTqO+FlGba/kmC6ufW8qxsklM8BMpA9ioJemc1rAuVqvoHGEd/+warTyv4O3k9DfiAy5NkEyHjNyD8/ishj7tUxTIW3sAlINH1sjAKhNHBqArLiqFCil98=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch; spf=pass smtp.mailfrom=lunn.ch; dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b=VWmOj0dL; arc=none smtp.client-ip=156.67.10.101
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lunn.ch
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=lunn.ch;
	s=20171124; h=In-Reply-To:Content-Transfer-Encoding:Content-Disposition:
	Content-Type:MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:From:
	Sender:Reply-To:Subject:Date:Message-ID:To:Cc:MIME-Version:Content-Type:
	Content-Transfer-Encoding:Content-ID:Content-Description:Content-Disposition:
	In-Reply-To:References; bh=LoQB2YBfTaN1K4JPLmVKXFvx1STyXVcKxEJnp1Odqwc=; b=VW
	mOj0dL+lpeG5RitAljRuELwjwDLbv4gS6AsjzEBs8+/a6tUJ7GFM47qX8IF08gRwU9bvSlqN+A+D2
	UwGE7BZXuGH5mOVsR5veHvOXhycyv8aPTip5Xy2dIl/JEMUPiDKYaE2KuHVT4MTjdbUHIXcsFue/W
	85mTiOK6L6ZVuQ4=;
Received: from andrew by vps0.lunn.ch with local (Exim 4.94.2)
	(envelope-from <andrew@lunn.ch>)
	id 1tDQxu-00Dpby-DJ; Tue, 19 Nov 2024 17:20:34 +0100
Date: Tue, 19 Nov 2024 17:20:34 +0100
From: Andrew Lunn <andrew@lunn.ch>
To: Krzysztof =?utf-8?Q?Ha=C5=82asa?= <khalasa@piap.pl>
Cc: netdev <netdev@vger.kernel.org>, Oliver Neukum <oneukum@suse.com>,
	Andrew Lunn <andrew+netdev@lunn.ch>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	linux-usb@vger.kernel.org, linux-kernel@vger.kernel.org,
	Jose Ignacio Tornos Martinez <jtornosm@redhat.com>,
	Ming Lei <ming.lei@canonical.com>
Subject: Re: [PATCH] usbnet_link_change() fails to call netif_carrier_on()
Message-ID: <9baf4f17-bae6-4f5c-b9a1-92dc48fd7a8d@lunn.ch>
References: <m34j43gwto.fsf@t19.piap.pl>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <m34j43gwto.fsf@t19.piap.pl>

On Tue, Nov 19, 2024 at 02:46:59PM +0100, Krzysztof Hałasa wrote:
> Hi,
> 
> ASIX AX88772B based USB 10/100 Ethernet adapter doesn't come
> up ("carrier off"), despite the built-in 100BASE-FX PHY positive link
> indication.
> 
> The problem appears to be in usbnet.c framework:
> 
> void usbnet_link_change(struct usbnet *dev, bool link, bool need_reset)
> {
> 	/* update link after link is reseted */
> 	if (link && !need_reset)
> 		netif_carrier_on(dev->net);
> 	else
> 		netif_carrier_off(dev->net);
> 
> 	if (need_reset && link)
> 		usbnet_defer_kevent(dev, EVENT_LINK_RESET);
> 	else
> 		usbnet_defer_kevent(dev, EVENT_LINK_CHANGE);
> }

static int ax88772_phylink_setup(struct usbnet *dev)
{
        struct asix_common_private *priv = dev->driver_priv;
        phy_interface_t phy_if_mode;
        struct phylink *phylink;

        priv->phylink_config.dev = &dev->net->dev;
        priv->phylink_config.type = PHYLINK_NETDEV;
        priv->phylink_config.mac_capabilities = MAC_SYM_PAUSE | MAC_ASYM_PAUSE |
                MAC_10 | MAC_100;

etc.

This device is using phylink to manage the PHY. phylink will than
manage the carrier. It assumes it is solely responsible for the
carrier. So i think your fix is wrong. You probably should be removing
all code in this driver which touches the carrier.

	Andrew

