Return-Path: <netdev+bounces-284825-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id iC88Ea85+2nUXwMAu9opvQ
	(envelope-from <netdev+bounces-284825-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Wed, 06 May 2026 14:53:03 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [172.232.135.74])
	by mail.lfdr.de (Postfix) with ESMTPS id D7ADF4DA8B7
	for <lists+netdev@lfdr.de>; Wed, 06 May 2026 14:53:02 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id 46D9530041F1
	for <lists+netdev@lfdr.de>; Wed,  6 May 2026 12:53:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1BD3242849F;
	Wed,  6 May 2026 12:53:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b="LbvXRB/k"
X-Original-To: netdev@vger.kernel.org
Received: from vps0.lunn.ch (vps0.lunn.ch [156.67.10.101])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C5BD43FD15D
	for <netdev@vger.kernel.org>; Wed,  6 May 2026 12:52:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=156.67.10.101
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778071981; cv=none; b=nj8Wnnremo4evtP3Ltr02T74gyuZ7z+MaKv4OZtsaoLAsc0tshgxavt79j7bcAYTQGas10luWfhDyAmS0Oz0rrzB/7LMUQF286HnIrfXxV/PGQd8RffmcHncKqrVCVGatvYKIw+5FCkqypy0BCj/YKRsf+lR7qowtdrtMEDe3Lo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778071981; c=relaxed/simple;
	bh=hcJU7Z8htJnUaJpeZalX6zZAnVlE4N3bcewk4vZYyXQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Vq8Ns2AdiwwxQ3Lsh8l+BnIAwY+E4KXDhme9xanG5vgcuJWa7jd+X3cr2ymT6UJmlA+SAKMIaWuNoRSlcIB+KqqlvPOeEYRQc1doYLpBnLBMOPKlcwJ1kCGoQiciSA3Vjit2LrF0P7lfo6aNgYiRtM/Cv8qZbiLt9TEU3pxpfaU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch; spf=pass smtp.mailfrom=lunn.ch; dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b=LbvXRB/k; arc=none smtp.client-ip=156.67.10.101
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lunn.ch
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=lunn.ch;
	s=20171124; h=In-Reply-To:Content-Disposition:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:From:Sender:Reply-To:Subject:
	Date:Message-ID:To:Cc:MIME-Version:Content-Type:Content-Transfer-Encoding:
	Content-ID:Content-Description:Content-Disposition:In-Reply-To:References;
	bh=qrSqa5fTUMG4IWMpybk9wuLg7+UOVRZLIs9Z+IV1bzM=; b=LbvXRB/kTJX+vfQghCWliSre64
	R7FDu1A9Py29NEMPK/1Y66Y4EoEtYbYvMX/Im/S9B+BdPo7m9bjYRMcNKEG0ekT8hgY7GZmMIm/3u
	JjGfCozvce14iyX+B8V55bRC4Z8ZLunoxS62E01lGukHVwZ5wWlpbbZR0QkH6uidESLM=;
Received: from andrew by vps0.lunn.ch with local (Exim 4.94.2)
	(envelope-from <andrew@lunn.ch>)
	id 1wKbkH-001dc6-TU; Wed, 06 May 2026 14:52:57 +0200
Date: Wed, 6 May 2026 14:52:57 +0200
From: Andrew Lunn <andrew@lunn.ch>
To: Sven Schuchmann <schuchmann@schleissheimer.de>
Cc: "netdev@vger.kernel.org" <netdev@vger.kernel.org>
Subject: Re: assert in phylink.c with lan7801 and dp83tc811 since kernel 6.18
Message-ID: <43c0d352-5637-419d-b48f-6c03d8018cf3@lunn.ch>
References: <BEZP281MB224533D524B27CFC6E47B447D93E2@BEZP281MB2245.DEUP281.PROD.OUTLOOK.COM>
 <57fb63c2-7a05-4bbe-ba2d-fc61ce1e3ba1@lunn.ch>
 <BEZP281MB224573FE237813F5DE192A95D93F2@BEZP281MB2245.DEUP281.PROD.OUTLOOK.COM>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <BEZP281MB224573FE237813F5DE192A95D93F2@BEZP281MB2245.DEUP281.PROD.OUTLOOK.COM>
X-Rspamd-Queue-Id: D7ADF4DA8B7
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[lunn.ch,none];
	R_DKIM_ALLOW(-0.20)[lunn.ch:s=20171124];
	R_SPF_ALLOW(-0.20)[+ip4:172.232.135.74:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	RCPT_COUNT_TWO(0.00)[2];
	TO_DN_EQ_ADDR_SOME(0.00)[];
	TAGGED_FROM(0.00)[bounces-284825-lists,netdev=lfdr.de];
	TO_DN_SOME(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FROM_HAS_DN(0.00)[];
	MISSING_XM_UA(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[andrew@lunn.ch,netdev@vger.kernel.org];
	DKIM_TRACE(0.00)[lunn.ch:+];
	MID_RHS_MATCH_FROM(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.232.128.0/19, country:SG];
	TAGGED_RCPT(0.00)[netdev];
	FORGED_SENDER_MAILLIST(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[lunn.ch:dkim,lunn.ch:mid,sto.lore.kernel.org:helo,sto.lore.kernel.org:rdns]

On Wed, May 06, 2026 at 12:30:33PM +0000, Sven Schuchmann wrote:
> Hi Andrew,
> 
> I came up with this:
> 
> diff --git a/drivers/net/usb/lan78xx.c b/drivers/net/usb/lan78xx.c
> index 261af300ab00..734cb62a1043 100644
> --- a/drivers/net/usb/lan78xx.c
> +++ b/drivers/net/usb/lan78xx.c
> @@ -2862,7 +2862,9 @@ static int lan78xx_phylink_setup(struct lan78xx_net *dev)
>  static void lan78xx_phy_uninit(struct lan78xx_net *dev)
>  {
>         if (dev->phylink) {
> +               rtnl_lock();
>                 phylink_disconnect_phy(dev->phylink);
> +               rtnl_unlock();
>                 phylink_destroy(dev->phylink);
>                 dev->phylink = NULL;
>         }
> 
> and it seems to prevent the cash. What do you think?

Does the Ethernet also work?

As i said, there appears to be two things going on. For some reason it
decides the PHY and MAC don't make a valid combination and returns
-EINVAL.

And then we have the RTNL problem.

We should fix the RTNL problem, but that on its own will probably not
give you working Ethernet.

Right let me look at the context we are in when
phylink_disconnect_phy() is called. See if this fix is correct.

	Andrew

