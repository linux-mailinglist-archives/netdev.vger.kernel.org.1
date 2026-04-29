Return-Path: <netdev+bounces-282394-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 0CRoG2cJ8mnhmwEAu9opvQ
	(envelope-from <netdev+bounces-282394-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Wed, 29 Apr 2026 15:36:39 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id E11A3494F1F
	for <lists+netdev@lfdr.de>; Wed, 29 Apr 2026 15:36:34 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 29327306A872
	for <lists+netdev@lfdr.de>; Wed, 29 Apr 2026 13:31:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B0EF03FCB2B;
	Wed, 29 Apr 2026 13:31:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b="MQ+da/Xr"
X-Original-To: netdev@vger.kernel.org
Received: from vps0.lunn.ch (vps0.lunn.ch [156.67.10.101])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5B89F3FBEBB
	for <netdev@vger.kernel.org>; Wed, 29 Apr 2026 13:31:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=156.67.10.101
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777469513; cv=none; b=uYiv4r98ZYG8/ZSwbbmJ4EIJE1Bgua+qDVi7c6S8ATL0M8aMGPRzcZ8MHCZu/AbnWwDaLhfYpBpi/riw1I8KYQIg7brNlDIgiEcrdu19y0UWaXLSvpzP9HByXOFeymJ+kPv8C9Q4CyBFP4MD1rk7uHQC2vNNlrb11ixtG+TI0ps=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777469513; c=relaxed/simple;
	bh=fxKeRhAI7gdMaWpT48f704an3VdOlP1miGnuxVaTUOo=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=l78KsfJ7DBC9AFyCRZOFxnQvq1Zsruhx5eBh1/1rAIn1IaLcEhY0doqkkaW+bUj9HTsVAR52ir/1sRU+NOlohmXFW9crONLzQi3raJvAH1OVoT9LR7AJMuHiiouYWC49fo6j+uV5emLH9X5OZydXWiPpFZW9O9CcQRGAYJnVn7w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch; spf=pass smtp.mailfrom=lunn.ch; dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b=MQ+da/Xr; arc=none smtp.client-ip=156.67.10.101
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lunn.ch
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=lunn.ch;
	s=20171124; h=In-Reply-To:Content-Disposition:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:From:Sender:Reply-To:Subject:
	Date:Message-ID:To:Cc:MIME-Version:Content-Type:Content-Transfer-Encoding:
	Content-ID:Content-Description:Content-Disposition:In-Reply-To:References;
	bh=ZPEKlVWq/hXxzx1A9ZEvNXireTT56HNiF9KwGj5tPcg=; b=MQ+da/Xr5AjC9S71k4TzDCs6V1
	GIfGTzS/9czhhNuwHPMErrZlbDEGP63AqV8fyzd2tDOtikdsq9LoFrYdUSwJaW58qDW0xd5DhcJyI
	AgRHJU39AC6qdSaT3m9/4bBFKggppbc8k6YQRie7nX226pIYGM8HGu+yuRbdHgyJ/afQ=;
Received: from andrew by vps0.lunn.ch with local (Exim 4.94.2)
	(envelope-from <andrew@lunn.ch>)
	id 1wI50x-000XNQ-PE; Wed, 29 Apr 2026 15:31:43 +0200
Date: Wed, 29 Apr 2026 15:31:43 +0200
From: Andrew Lunn <andrew@lunn.ch>
To: Mika Westerberg <mika.westerberg@linux.intel.com>
Cc: Jakub Kicinski <kuba@kernel.org>, netdev@vger.kernel.org,
	YehezkelShB@gmail.com, andrew+netdev@lunn.ch, davem@davemloft.net,
	edumazet@google.com, pabeni@redhat.com
Subject: Re: [PATCH 1/2] net: thunderbolt: Call tbnet_stop() upon shutdown
Message-ID: <8a52ab2d-9cfa-4478-bbda-c910c2b0f726@lunn.ch>
References: <20260427081623.2338179-1-mika.westerberg@linux.intel.com>
 <20260429011224.1505785-1-kuba@kernel.org>
 <20260429053046.GZ557136@black.igk.intel.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260429053046.GZ557136@black.igk.intel.com>
X-Rspamd-Queue-Id: E11A3494F1F
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.66 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[lunn.ch,none];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	R_DKIM_ALLOW(-0.20)[lunn.ch:s=20171124];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FREEMAIL_CC(0.00)[kernel.org,vger.kernel.org,gmail.com,lunn.ch,davemloft.net,google.com,redhat.com];
	FROM_HAS_DN(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	TAGGED_FROM(0.00)[bounces-282394-lists,netdev=lfdr.de];
	FORGED_SENDER_MAILLIST(0.00)[];
	DKIM_TRACE(0.00)[lunn.ch:+];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	MISSING_XM_UA(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[andrew@lunn.ch,netdev@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	MID_RHS_MATCH_FROM(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	RCPT_COUNT_SEVEN(0.00)[8];
	MIME_TRACE(0.00)[0:+];
	TO_DN_SOME(0.00)[]

On Wed, Apr 29, 2026 at 07:30:46AM +0200, Mika Westerberg wrote:
> On Tue, Apr 28, 2026 at 06:12:24PM -0700, Jakub Kicinski wrote:
> > This is an AI-generated review of your patch. The human sending this
> > email has considered the AI review valid, or at least plausible.
> > ---
> > net: thunderbolt: Call tbnet_stop() upon shutdown
> >     
> > This commit updates the shutdown callback for the Thunderbolt network service
> > driver to call tbnet_stop() if the interface is running. This ensures the
> > service drivers release the rings upon shutdown.
> > 
> > > diff --git a/drivers/net/thunderbolt/main.c b/drivers/net/thunderbolt/main.c
> > > index 7aae5d915a1e..631af237998d 100644
> > > --- a/drivers/net/thunderbolt/main.c
> > > +++ b/drivers/net/thunderbolt/main.c
> > > @@ -1417,7 +1417,10 @@ static void tbnet_remove(struct tb_service *svc)
> > >  
> > >  static void tbnet_shutdown(struct tb_service *svc)
> > >  {
> > > -	tbnet_tear_down(tb_service_get_drvdata(svc), true);
> > > +	struct tbnet *net = tb_service_get_drvdata(svc);
> > > +
> > > +	if (netif_running(net->dev))
> > > +		tbnet_stop(net->dev);
> > 
> > Does calling tbnet_stop() directly bypass the network stack teardown sequence?
> 
> This is called when the machine is rebooted or shut down to quiesce the
> device. I don't think the network stack has anything similar?

You mean that network interfaces are left running while the machine
reboots, potentially DMAing receive packets over the bootloader or
freshly loaded kernel? Does that seem reasonable? Don't you think the
core will somehow call the .close function? I cannot point to the code
doing that without a bit if searching, but i think it probably exists.

	Andrew

