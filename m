Return-Path: <netdev+bounces-251504-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id KDthBO+jb2n0DgAAu9opvQ
	(envelope-from <netdev+bounces-251504-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Tue, 20 Jan 2026 16:49:03 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [213.196.21.55])
	by mail.lfdr.de (Postfix) with ESMTPS id D724C46B49
	for <lists+netdev@lfdr.de>; Tue, 20 Jan 2026 16:49:02 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id E642774908C
	for <lists+netdev@lfdr.de>; Tue, 20 Jan 2026 14:17:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7E37543D4F0;
	Tue, 20 Jan 2026 14:08:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b="JCE2b+i+"
X-Original-To: netdev@vger.kernel.org
Received: from vps0.lunn.ch (vps0.lunn.ch [156.67.10.101])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9C08942B729
	for <netdev@vger.kernel.org>; Tue, 20 Jan 2026 14:08:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=156.67.10.101
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768918123; cv=none; b=COliHT4f5sDjbrzBYlLSAIxtZsoNI/VwYcnmA41ozJRtS6hoVXCS0jWnIFw74ncCzY5V4LWluZpu7cYd+uGloN4Ttfk5/NyBaepkjSpM9KVLy22im7xLkiKvkcpRkNEqZ/ZQS5PBHfppOGmkMrz9iNz+VHZP/0JY8/4hiPHdoXM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768918123; c=relaxed/simple;
	bh=nQJyWNUCQ3C0XXHdr5XHK5uq/E+I+6CHPIg1amxDlCk=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=WkP0Oxl4FBnrpSFwqi0wwEYp+ATgO4vqP+FhelPXf4/slJW8KvYd8Q+7jSStPFdw59a8M+0pcZ+1zmtYMmfQbckdMoCaUQufJSUK6I4CUwh+Kg5XjA6N92zvMPbC2XhJFnr5w8GwWSb5+MtRY+LlmnLSiteJisg/zUStMY/eR9Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch; spf=pass smtp.mailfrom=lunn.ch; dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b=JCE2b+i+; arc=none smtp.client-ip=156.67.10.101
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lunn.ch
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=lunn.ch;
	s=20171124; h=In-Reply-To:Content-Disposition:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:From:Sender:Reply-To:Subject:
	Date:Message-ID:To:Cc:MIME-Version:Content-Type:Content-Transfer-Encoding:
	Content-ID:Content-Description:Content-Disposition:In-Reply-To:References;
	bh=sjlmp7Xzirjp8hNchZ2HXCaho9lP6cyTX0aqtV4sBh0=; b=JCE2b+i+qxptJw79wClfFsP3om
	7CxGpiY3F43drN1bILoMCbMwK3l8iEpCfSGy9Wg6KcTvZOEEch2hflBoaRYKVZJA5GcyHTA04GXu2
	lNcHtum6cfCsdpdM9sS8uIPJ3QBE615BvQ+OLYL2cIMcQ/O2wykcJpJI1LDP3H+jIbWw=;
Received: from andrew by vps0.lunn.ch with local (Exim 4.94.2)
	(envelope-from <andrew@lunn.ch>)
	id 1viCPA-003gaL-N4; Tue, 20 Jan 2026 15:08:24 +0100
Date: Tue, 20 Jan 2026 15:08:24 +0100
From: Andrew Lunn <andrew@lunn.ch>
To: Simon Horman <horms@kernel.org>
Cc: jacky_chou@aspeedtech.com, davem@davemloft.net, edumazet@google.com,
	andrew+netdev@lunn.ch, kuba@kernel.org, pabeni@redhat.com,
	netdev@vger.kernel.org
Subject: Re: [net-next,v2,09/15] net: ftgmac100: Always register the MDIO bus
 when it exists
Message-ID: <8ab0e121-5ffb-4dd8-afc8-11b6ce3898bb@lunn.ch>
References: <20260116-ftgmac-cleanup-v2-9-81f41f01f2a8@aspeedtech.com>
 <20260120121407.795529-1-horms@kernel.org>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260120121407.795529-1-horms@kernel.org>
X-Spamd-Result: default: False [-0.46 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW_WITH_FAILURES(-0.50)[];
	R_DKIM_ALLOW(-0.20)[lunn.ch:s=20171124];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	DMARC_POLICY_ALLOW(0.00)[lunn.ch,none];
	TAGGED_FROM(0.00)[bounces-251504-lists,netdev=lfdr.de];
	FROM_HAS_DN(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	RCVD_TLS_LAST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	DKIM_TRACE(0.00)[lunn.ch:+];
	MISSING_XM_UA(0.00)[];
	TO_DN_SOME(0.00)[];
	R_SPF_SOFTFAIL(0.00)[~all:c];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[andrew@lunn.ch,netdev@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	MID_RHS_MATCH_FROM(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	RCPT_COUNT_SEVEN(0.00)[8];
	ASN(0.00)[asn:7979, ipnet:213.196.21.0/24, country:US];
	DBL_BLOCKED_OPENRESOLVER(0.00)[linux.dev:url,ams.mirrors.kernel.org:rdns,ams.mirrors.kernel.org:helo,lunn.ch:mid,lunn.ch:dkim]
X-Rspamd-Queue-Id: D724C46B49
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

On Tue, Jan 20, 2026 at 12:14:07PM +0000, Simon Horman wrote:
> This is an AI-generated review of your patch. The human sending this
> email has considered the AI review valid, or at least plausible.
> Full review at: https://netdev-ai.bots.linux.dev/ai-review.html
> ---
> net: ftgmac100: Always register the MDIO bus when it exists
> 
> This patch moves MDIO bus registration earlier in the probe function
> for FARADAY, AST2400, and AST2500 MACs, simplifying the code by
> registering it unconditionally when the hardware has an MDIO controller.
> 
> Note: These issues appear to be fixed later in the series by commits
> 8961daa5f2c0 ("Simplify error handling for ftgmac100_setup_mdio") and
> 046e51399f0f ("Move DT probe into a helper").
> 
> > diff --git a/drivers/net/ethernet/faraday/ftgmac100.c b/drivers/net/ethernet/faraday/ftgmac100.c
> > index f1cb5dc37919..931fdf3d07d1 100644
> > --- a/drivers/net/ethernet/faraday/ftgmac100.c
> > +++ b/drivers/net/ethernet/faraday/ftgmac100.c
> > @@ -1957,6 +1957,14 @@ static int ftgmac100_probe(struct platform_device *pdev)
> >  		priv->txdes0_edotr_mask = BIT(15);
> >  	}
> >
> > +	if (priv->mac_id == FTGMAC100_FARADAY ||
> > +	    priv->mac_id == FTGMAC100_AST2400 ||
> > +	    priv->mac_id == FTGMAC100_AST2500) {
> > +		err = ftgmac100_setup_mdio(netdev);
> > +		if (err)
> > +			goto err_phy_connect;
> > +	}
> 
> If ftgmac100_setup_mdio() fails after of_mdiobus_register() returns an
> error, it calls mdiobus_free(priv->mii_bus) but does not set priv->mii_bus
> to NULL. The goto err_phy_connect then leads to ftgmac100_destroy_mdio()
> which checks if (!priv->mii_bus) but finds a dangling pointer, resulting
> in mdiobus_unregister() on freed memory followed by a double free.

The call to register the MDIO bus has been moved earlier. That means
the call to ftgmac100_destroy_mdio() the bus also needs to move
earlier on the error cleanup path, before err_phy_connect:

	Andrew

