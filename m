Return-Path: <netdev+bounces-266759-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id UEvWM2+/sWkwFAAAu9opvQ
	(envelope-from <netdev+bounces-266759-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Wed, 11 Mar 2026 20:15:59 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id 3F468269282
	for <lists+netdev@lfdr.de>; Wed, 11 Mar 2026 20:15:59 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 37DB8300AC1F
	for <lists+netdev@lfdr.de>; Wed, 11 Mar 2026 19:15:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 020E12F3C19;
	Wed, 11 Mar 2026 19:15:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b="AC3Rxeav"
X-Original-To: netdev@vger.kernel.org
Received: from vps0.lunn.ch (vps0.lunn.ch [156.67.10.101])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BCF842D47E6;
	Wed, 11 Mar 2026 19:15:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=156.67.10.101
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773256556; cv=none; b=ZKDnIw5xHWx0TeQA6kjYx2Us3DDSUYqKEAl4PZRcWs84HA6tjEMSiCDzW5mOVJsrb1bnNnOnBgFTkr0q/Q6xSZ2G8P7Zq4DgYDz+GCanvs5e3LmMwMWTgSH8qsHH4LFNNXclSR5ExpnKiS87Pc+pD8nis02QKHLt/1lyhAsKNDk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773256556; c=relaxed/simple;
	bh=gwh9ZtQJ8T4eqca8LnY4EHjsnKJyybWcR2U7kLlgdAA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=EgpiON26fX4vqLmYcSkTZpnl0Ut5JGOG1r9lT6nHT14J+UOiFKnU2y1uhGkag+oUy1aIBhDISLYffbkR4oqjsYHLS1s+W7gY/gOdxlqUMM9vM+62Ek8/HRcuJXO/MharJC/asDm3CoFeLASl2CO2v9GDpRDEs8o41icDP/Fjegg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch; spf=pass smtp.mailfrom=lunn.ch; dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b=AC3Rxeav; arc=none smtp.client-ip=156.67.10.101
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lunn.ch
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=lunn.ch;
	s=20171124; h=In-Reply-To:Content-Disposition:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:From:Sender:Reply-To:Subject:
	Date:Message-ID:To:Cc:MIME-Version:Content-Type:Content-Transfer-Encoding:
	Content-ID:Content-Description:Content-Disposition:In-Reply-To:References;
	bh=tmKJz4PTXeSP3DIMaLWnUAhuXvl8uJw/wenH2e9XHUg=; b=AC3RxeaviT2nq9ifbCFtg7D8ye
	nyNyvB4SOixmyd7Jnw374vliShdGmRuMl3EH8V1+USm+BUia6DHGQYFuvR1xF5Z6+xBJ2dn3ZMjT4
	wVJKP3D+4darksEJftGdlRfNL+O1PEYluNPY2Y7O0wM31lLU2HLZ5OBNJCiG+HjDPnj4=;
Received: from andrew by vps0.lunn.ch with local (Exim 4.94.2)
	(envelope-from <andrew@lunn.ch>)
	id 1w0P24-00BE63-D4; Wed, 11 Mar 2026 20:15:48 +0100
Date: Wed, 11 Mar 2026 20:15:48 +0100
From: Andrew Lunn <andrew@lunn.ch>
To: Oliver Neukum <oneukum@suse.com>
Cc: andrew+netdev@lunn.ch, davem@davemloft.net, edumazet@google.com,
	kuba@kernel.org, pabeni@redhat.com, linux-usb@vger.kernel.org,
	netdev@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 1/1 net-next] net: usb: cdc-ether: unify error handling
 in probe
Message-ID: <5db41b5a-c53f-4441-bf4e-a12add3e33b4@lunn.ch>
References: <20260311112919.678686-1-oneukum@suse.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260311112919.678686-1-oneukum@suse.com>
X-Spamd-Result: default: False [-0.66 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[lunn.ch,none];
	R_SPF_ALLOW(-0.20)[+ip4:172.105.105.114:c];
	R_DKIM_ALLOW(-0.20)[lunn.ch:s=20171124];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-266759-lists,netdev=lfdr.de];
	FROM_HAS_DN(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	RCVD_TLS_LAST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	DKIM_TRACE(0.00)[lunn.ch:+];
	ASN(0.00)[asn:63949, ipnet:172.105.96.0/20, country:SG];
	MISSING_XM_UA(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[andrew@lunn.ch,netdev@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	MID_RHS_MATCH_FROM(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	RCPT_COUNT_SEVEN(0.00)[9];
	TO_DN_SOME(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns,lunn.ch:dkim,lunn.ch:mid]
X-Rspamd-Queue-Id: 3F468269282
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

> @@ -288,16 +288,11 @@ int usbnet_generic_cdc_bind(struct usbnet *dev, struct usb_interface *intf)
>  	if (info->data != info->control) {
>  		status = usb_driver_claim_interface(driver, info->data, dev);
>  		if (status < 0)
> -			return status;
> +			goto bad_desc;

>  bad_desc:
>  	dev_info(&dev->udev->dev, "bad CDC descriptors\n");
> -	return -ENODEV;
> +	return status;

Always reporting "bad CDC descriptors" does not seem correct. Not
being able to claim the interface is probably some other sort of
problem.

It might be better to change the dev_dbg()s to dev_err()s, and drop
the dev_info() here. You can then add additional dev_err() before the
goto's you are adding.

    Andrew

---
pw-bot: cr

