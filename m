Return-Path: <netdev+bounces-259121-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id wEbtKWyylGlbGgIAu9opvQ
	(envelope-from <netdev+bounces-259121-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Tue, 17 Feb 2026 19:24:44 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 2177414F119
	for <lists+netdev@lfdr.de>; Tue, 17 Feb 2026 19:24:43 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 7247D3068397
	for <lists+netdev@lfdr.de>; Tue, 17 Feb 2026 18:23:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3C5AB37107F;
	Tue, 17 Feb 2026 18:23:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b="Z81hrn1m"
X-Original-To: netdev@vger.kernel.org
Received: from vps0.lunn.ch (vps0.lunn.ch [156.67.10.101])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 89F01293C4E
	for <netdev@vger.kernel.org>; Tue, 17 Feb 2026 18:23:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=156.67.10.101
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1771352616; cv=none; b=ITSsqVHGtj5EZTqIulAdV4tmSLOmKF02YSkOQrXvC7Sk76Yp5Iv5klxLLsP8C2NU2zfTMkI42f56RavtBvNnpBzxUXucHw4ZQ7A2rgNBkxFPRCYbgOSF9zwu1qLNpUuM+sDBWxWGye9fiLrTh3cmpxAu6sWPf9VYWryu9WCO0VA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1771352616; c=relaxed/simple;
	bh=hlYZ6IJZ4aQ2cLmwYpbEbEYJqPXRXlsqoegYuKofkFs=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=J8kP+Y4qVES3OGAFrIRdyg1wkjtot3MsTuF/ldiCPKCmFMxHCI0WBUcmSgZZzHuH3XHm/Kvfa6xphkgUFEaTZrC/fs2ZRq8PQM4y4JMgHwKLbjg7Sm9RD+V10week+QOXxs51rSNY+ehdgeqKAJV5P+HCGuB8lwfZTbMgPOr/Eo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch; spf=pass smtp.mailfrom=lunn.ch; dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b=Z81hrn1m; arc=none smtp.client-ip=156.67.10.101
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lunn.ch
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=lunn.ch;
	s=20171124; h=In-Reply-To:Content-Disposition:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:From:Sender:Reply-To:Subject:
	Date:Message-ID:To:Cc:MIME-Version:Content-Type:Content-Transfer-Encoding:
	Content-ID:Content-Description:Content-Disposition:In-Reply-To:References;
	bh=2yH04cPNapUvoq8HAj3G/12vfdnjmgBXnbZiChT1xjQ=; b=Z81hrn1mfyGP3ABAozNMnwn+kW
	sRRCwKMyI9f2RWWjYt02G1ymVOE6oS2JyQt3U4phag4wwrA7QsvbWcfoJKSf3VhuYS71JFznoYntv
	f6cQ2NXKWViU66nFNij1t0zmQP4WZor3U4gZw5Cgh+zlotzNH5cfIslgKhEuhcYElRXE=;
Received: from andrew by vps0.lunn.ch with local (Exim 4.94.2)
	(envelope-from <andrew@lunn.ch>)
	id 1vsPjO-007fv4-6U; Tue, 17 Feb 2026 19:23:30 +0100
Date: Tue, 17 Feb 2026 19:23:30 +0100
From: Andrew Lunn <andrew@lunn.ch>
To: Oliver Neukum <oneukum@suse.com>
Cc: netdev@vger.kernel.org, hayeswang@realtek.com, bjorn@mork.no,
	o.rempel@pengutronix.de
Subject: Re: [RFC net-next 1/3] net: usb: divorce private data and cdc state
 in usbnet
Message-ID: <5b017c3f-7c84-4769-b324-5cb92d6b56a7@lunn.ch>
References: <20260210151416.42254-1-oneukum@suse.com>
 <20260210151416.42254-2-oneukum@suse.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260210151416.42254-2-oneukum@suse.com>
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[lunn.ch,none];
	R_DKIM_ALLOW(-0.20)[lunn.ch:s=20171124];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c04:e001:36c::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	TAGGED_FROM(0.00)[bounces-259121-lists,netdev=lfdr.de];
	RCVD_COUNT_THREE(0.00)[4];
	TO_DN_SOME(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FROM_HAS_DN(0.00)[];
	MISSING_XM_UA(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[andrew@lunn.ch,netdev@vger.kernel.org];
	DKIM_TRACE(0.00)[lunn.ch:+];
	MID_RHS_MATCH_FROM(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c04::/32, country:SG];
	TAGGED_RCPT(0.00)[netdev];
	RCPT_COUNT_FIVE(0.00)[5];
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: 2177414F119
X-Rspamd-Action: no action

> @@ -41,7 +53,7 @@ struct usbnet {
>  	/* protocol/interface state */
>  	struct net_device	*net;
>  	int			msg_enable;
> -	unsigned long		data[5];
> +	struct cdc_state	cdc;		/* too common to leave out*/
>  	u32			xid;
>  	u32			hard_mtu;	/* count any extra framing */
>  	size_t			rx_urb_size;	/* size for rx urbs */
> @@ -84,6 +96,7 @@ struct usbnet {
>   * that must be broken
>   */
>  #		define EVENT_UNPLUG		31
> +	unsigned long		private[5];

private would normally be a void *, since the core has no idea what
type is should be, it is specific to the driver. For this patch, could
you make it a void *, and set the pointer to a block of memory
equivalent to 5 unsigned longs.

You can then remove all the casts in the drivers, making the code look
normal for handling private memory.

     Andrew


