Return-Path: <netdev+bounces-253092-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id kJUDExMUdWlPAgEAu9opvQ
	(envelope-from <netdev+bounces-253092-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Sat, 24 Jan 2026 19:48:51 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id ACC1F7E8A1
	for <lists+netdev@lfdr.de>; Sat, 24 Jan 2026 19:48:50 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id A4667300C274
	for <lists+netdev@lfdr.de>; Sat, 24 Jan 2026 18:48:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3197D1F0995;
	Sat, 24 Jan 2026 18:48:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b="0ZsJ2cVK"
X-Original-To: netdev@vger.kernel.org
Received: from vps0.lunn.ch (vps0.lunn.ch [156.67.10.101])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E15352B9B9;
	Sat, 24 Jan 2026 18:48:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=156.67.10.101
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769280526; cv=none; b=Ja82ztL5SC+U8NM8D4+GoELVOsmuCW4yjt94jW9sCg3ZEXkCy6/EzL9EueXQOnvn6GofZWEtAtq2hzutU9cVhLGBR7tp/tI7jKFapmduLhh7D6GbZY8QtUorfhEUBBlI03Afu7C2y93hinVBI3RJlY2++wZ9HUgnZ3TL5i9Rsug=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769280526; c=relaxed/simple;
	bh=o8QaVJXY5vRVE5mPXnXAAUBBifC+oh4SSOlXEgwugZM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=V+ZE3eLYpc978cDBeFbqcSW2Ocq0Y5k2oDO2kOnlSIiMqVSQ3mKlUV0q+jZBnPdAmGBYQs8Gp+GZ6IXlo5KbpcdIFBZy9E+z6gky+ZRq7HTxEJ5XHcgWgVj/8O0hOfhXjZ3rK5kOJH77ZLN1Zt/KpDSsJ1NIoU7ZBR9i9GT3zZg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch; spf=pass smtp.mailfrom=lunn.ch; dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b=0ZsJ2cVK; arc=none smtp.client-ip=156.67.10.101
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lunn.ch
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=lunn.ch;
	s=20171124; h=In-Reply-To:Content-Disposition:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:From:Sender:Reply-To:Subject:
	Date:Message-ID:To:Cc:MIME-Version:Content-Type:Content-Transfer-Encoding:
	Content-ID:Content-Description:Content-Disposition:In-Reply-To:References;
	bh=cxyAB1LDOJ85fvLjDomFFnmTJLiY62zgFSyj0HWmz58=; b=0ZsJ2cVKsoculXpqGFnnYmcf1h
	WIf4ud531Ibco4GXRD7ve3vJroLMqfk4fHy7InCIughhd5Z26yUfY7PacRNaOCCLT/mJ5V9JsxdAV
	2DYG7FQ0x9hYWb0L9CziVccyAQsZzz0pbBZsUJzce6mpjc74zR8vwaAqjMiDgXMsR334=;
Received: from andrew by vps0.lunn.ch with local (Exim 4.94.2)
	(envelope-from <andrew@lunn.ch>)
	id 1vjiga-004VBi-Cx; Sat, 24 Jan 2026 19:48:40 +0100
Date: Sat, 24 Jan 2026 19:48:40 +0100
From: Andrew Lunn <andrew@lunn.ch>
To: Ethan Nelson-Moore <enelsonmoore@gmail.com>
Cc: netdev@vger.kernel.org, linux-usb@vger.kernel.org,
	Andrew Lunn <andrew+netdev@lunn.ch>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	Peter Korsgaard <peter@korsgaard.com>,
	Steve Glendinning <steve.glendinning@shawell.net>,
	Oliver Neukum <oneukum@suse.com>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Oleksij Rempel <o.rempel@pengutronix.de>,
	Max Schulze <max.schulze@online.de>,
	Krzysztof =?utf-8?Q?Ha=C5=82asa?= <khalasa@piap.pl>
Subject: Re: [PATCH net-next] net: usb: introduce usbnet_mii_ioctl helper
 function
Message-ID: <8d17a810-9e74-4ef1-8fa7-3267a8678b40@lunn.ch>
References: <20260124080136.75619-1-enelsonmoore@gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260124080136.75619-1-enelsonmoore@gmail.com>
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.66 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[lunn.ch,none];
	R_DKIM_ALLOW(-0.20)[lunn.ch:s=20171124];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c04:e001:36c::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-253092-lists,netdev=lfdr.de];
	FREEMAIL_TO(0.00)[gmail.com];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	RCPT_COUNT_TWELVE(0.00)[15];
	MIME_TRACE(0.00)[0:+];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[andrew@lunn.ch,netdev@vger.kernel.org];
	DKIM_TRACE(0.00)[lunn.ch:+];
	MID_RHS_MATCH_FROM(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c04::/32, country:SG];
	TAGGED_RCPT(0.00)[netdev];
	MISSING_XM_UA(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[lunn.ch:mid,lunn.ch:dkim]
X-Rspamd-Queue-Id: ACC1F7E8A1
X-Rspamd-Action: no action

>  static int smsc75xx_ioctl(struct net_device *netdev, struct ifreq *rq, int cmd)
>  {
> -	struct usbnet *dev = netdev_priv(netdev);
> -
>  	if (!netif_running(netdev))
>  		return -EINVAL;
>  
> -	return generic_mii_ioctl(&dev->mii, if_mii(rq), cmd, NULL);
> +	return usbnet_mii_ioctl(netdev, rq, cmd);
>  }

You are doing the same as phy_do_ioctl(), but for the old mii
code. However, we also have phy_do_ioctl_running(). It might make
sense to add usbnet_mii_ioctl_running()?

	Andrew

