Return-Path: <netdev+bounces-260992-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id gM0mDrIIn2neYgQAu9opvQ
	(envelope-from <netdev+bounces-260992-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Wed, 25 Feb 2026 15:35:30 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [172.232.135.74])
	by mail.lfdr.de (Postfix) with ESMTPS id CFAC2198CCE
	for <lists+netdev@lfdr.de>; Wed, 25 Feb 2026 15:35:29 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id 3A18D302204F
	for <lists+netdev@lfdr.de>; Wed, 25 Feb 2026 14:35:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7661D3D34B4;
	Wed, 25 Feb 2026 14:35:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="iw7Aj66B"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E52033D3333;
	Wed, 25 Feb 2026 14:35:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772030125; cv=none; b=W1wGrUCTz3aFMHDMnaYlr7mlooA2c6JBe1ZYsUjqMx6/CP3LWw8XkovJckJ4yr/qczSS6cJLBljdff6cPNxTVBpGUmW9pHveNRZSreuuoKH+Qfv1ZEGdy3lWcwJsk1Vcq526nD9wAXLnx9tW4FhXAujaONFZSTsP5K50I/QwHTU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772030125; c=relaxed/simple;
	bh=EYEJVeIugja0gavXcYE7+JebJlLUNB9fl2/GXwIICQo=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Y8hM0SUTsjKGgRyi4EI46AbOPQp74kTSBtk/MJb+7DxmNEv12E5FE99ozIH91YO6TIUNUpNt5DDbYyp2g32sPENEmw2VeQaZ08G6OQzxT7DRFh0sRveC7mC+WBEpkR5S56y+kNPpMLEaWk0YcmMm2ptAYlwIcIICAr3oFfTQs0w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=iw7Aj66B; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0B40EC116D0;
	Wed, 25 Feb 2026 14:35:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1772030124;
	bh=EYEJVeIugja0gavXcYE7+JebJlLUNB9fl2/GXwIICQo=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=iw7Aj66BbAUQKsnb5bwa4wssrOYS127Ukk8SlXHe/GyIRkbK34bGbb5cGuntPeLho
	 YAHiuUhSYiQL5T2BexQRVlzGxz+jzS8smHum7IPbACBlvm4uqN7JCkDg5N6O/p6z9e
	 wQ0fWhzwv1Y2znTHxmSwnkrEYEFee7HB3D89bSnw=
Date: Wed, 25 Feb 2026 06:35:16 -0800
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: Jeremy Kerr <jk@codeconstruct.com.au>
Cc: netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
	Matt Johnston <matt@codeconstruct.com.au>,
	stable <stable@kernel.org>
Subject: Re: [PATCH net] net: mctp: usb: properly drop the usb interface on
 probe error
Message-ID: <2026022539-punch-supper-884c@gregkh>
References: <2026022319-turbofan-darkened-206d@gregkh>
 <0fc4daf8261ea1b163c81c5618aba74f248bc3a9.camel@codeconstruct.com.au>
 <2026022314-retiring-accustom-ca7b@gregkh>
 <53bc468db1fe156cf949cb1774b701d209935a83.camel@codeconstruct.com.au>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <53bc468db1fe156cf949cb1774b701d209935a83.camel@codeconstruct.com.au>
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [2.34 / 15.00];
	MID_END_EQ_FROM_USER_PART(4.00)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[linuxfoundation.org,none];
	MID_RHS_NOT_FQDN(0.50)[];
	R_DKIM_ALLOW(-0.20)[linuxfoundation.org:s=korg];
	R_SPF_ALLOW(-0.20)[+ip4:172.232.135.74:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	TAGGED_FROM(0.00)[bounces-260992-lists,netdev=lfdr.de];
	RCVD_COUNT_THREE(0.00)[4];
	TO_DN_SOME(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FROM_HAS_DN(0.00)[];
	MISSING_XM_UA(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	NEURAL_HAM(-0.00)[-0.999];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[gregkh@linuxfoundation.org,netdev@vger.kernel.org];
	DKIM_TRACE(0.00)[linuxfoundation.org:+];
	TAGGED_RCPT(0.00)[netdev];
	ASN(0.00)[asn:63949, ipnet:172.232.128.0/19, country:SG];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	RCPT_COUNT_FIVE(0.00)[5];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sto.lore.kernel.org:helo,sto.lore.kernel.org:rdns,linuxfoundation.org:dkim]
X-Rspamd-Queue-Id: CFAC2198CCE
X-Rspamd-Action: no action

On Tue, Feb 24, 2026 at 02:31:03PM +0800, Jeremy Kerr wrote:
> Hi Greg,
> 
> > > > diff --git a/drivers/net/mctp/mctp-usb.c b/drivers/net/mctp/mctp-usb.c
> > > > index ef860cfc629f..eef17ae89298 100644
> > > > --- a/drivers/net/mctp/mctp-usb.c
> > > > +++ b/drivers/net/mctp/mctp-usb.c
> > > > @@ -355,6 +355,7 @@ static int mctp_usb_probe(struct usb_interface *intf,
> > > >         usb_free_urb(dev->tx_urb);
> > > >         usb_free_urb(dev->rx_urb);
> > > >         free_netdev(netdev);
> > > > +       usb_put_dev(dev->usbdev);
> > > >         return rc;
> > > >  }
> > > 
> > > Should we not do the usb_put_dev() before the free_netdev()?
> > 
> > Why?  The usb_put_dev() doesn't really do anything, except for the fact
> > that you have to do it because you did a usb_get_dev() earlier.
> 
> More that the dev-> dereference may be invalid at that point, since the
> netdev (and hence dev) has been free_netdev()-ed.

Argh, I missed that, yes, you are right, let me make a v2 of this,
thanks for the review!

greg k-h

