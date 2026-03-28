Return-Path: <netdev+bounces-272772-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id OUMbM9Lnx2nbegUAu9opvQ
	(envelope-from <netdev+bounces-272772-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Sat, 28 Mar 2026 15:38:10 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id 3257534EB35
	for <lists+netdev@lfdr.de>; Sat, 28 Mar 2026 15:38:10 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id EE83A3019CAD
	for <lists+netdev@lfdr.de>; Sat, 28 Mar 2026 14:38:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A4DCD2FDC5E;
	Sat, 28 Mar 2026 14:38:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b="VYIvHkY7"
X-Original-To: netdev@vger.kernel.org
Received: from vps0.lunn.ch (vps0.lunn.ch [156.67.10.101])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5852A13D51E;
	Sat, 28 Mar 2026 14:38:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=156.67.10.101
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774708685; cv=none; b=QXS8/CU0M6mw20cbrm4MDF50vd5kS4GLlgme9OqvNi0/zgsR+s2qrgxVPg8Vu2+ZDzyygzPpRv738eCCrk9u39j7ZEHa8sYwpgoVNQRFr2uM1Q54l9XSfRYfcwRLGYYMC++htAoB2eLS6Vo4FQYNCu9KijpjgcFB+d6A8kQbuxE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774708685; c=relaxed/simple;
	bh=U7uYWD1B98XbD6EV0mmPmMlXVt5n8KUwJ5d4L3IQElc=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=YFpf/aI1m6EHADaQ3P8SMzo0QWv/1UxZi9chF2H8v/mjD/uxR6X7dGVtaVVPHhJPgmd7++y8WpzRQgj4BcpLXM/XbKhflNI03vkgCNjs93GvBUYXwF3MHUTIgjXJG4yqFWoDKOvavwFZqFY5PbtzUDtF6WupzpyKgRRFfe40sYw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch; spf=pass smtp.mailfrom=lunn.ch; dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b=VYIvHkY7; arc=none smtp.client-ip=156.67.10.101
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lunn.ch
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=lunn.ch;
	s=20171124; h=In-Reply-To:Content-Disposition:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:From:Sender:Reply-To:Subject:
	Date:Message-ID:To:Cc:MIME-Version:Content-Type:Content-Transfer-Encoding:
	Content-ID:Content-Description:Content-Disposition:In-Reply-To:References;
	bh=1t8tmSrXzEEc0ye9Vbn1/FQ1NdO15sJwBUGpTTq9scs=; b=VYIvHkY7vH/CyzNPAePuG3QWBm
	oo6NWD6QgYw9aiMICNIbA1URybU19b6vU2JyzPep8oYMY2QWwnHiZSavRI42GgRvvdL0lXaUeCrYx
	0zdcy+rXyskZPST7qDxxIxI0Jgn1U07xvEV3l5Q7uQ4EgI6c8J3O3X8PHkDAI5roiSVE=;
Received: from andrew by vps0.lunn.ch with local (Exim 4.94.2)
	(envelope-from <andrew@lunn.ch>)
	id 1w6UnU-00Dn8u-DB; Sat, 28 Mar 2026 15:37:56 +0100
Date: Sat, 28 Mar 2026 15:37:56 +0100
From: Andrew Lunn <andrew@lunn.ch>
To: Yufan Chen <yufan.chen@linux.dev>
Cc: Andrew Lunn <andrew+netdev@lunn.ch>,
	"David S . Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
	Yufan Chen <ericterminal@gmail.com>
Subject: Re: [PATCH] net/ftgmac100: fix ring allocation unwind leaks on open
 failure
Message-ID: <7228e638-7d91-47a0-b99c-9894180c8660@lunn.ch>
References: <20260328092428.75430-1-yufan.chen@linux.dev>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260328092428.75430-1-yufan.chen@linux.dev>
X-Spamd-Result: default: False [-0.66 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[lunn.ch,none];
	R_DKIM_ALLOW(-0.20)[lunn.ch:s=20171124];
	R_SPF_ALLOW(-0.20)[+ip4:172.105.105.114];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FREEMAIL_CC(0.00)[lunn.ch,davemloft.net,google.com,kernel.org,redhat.com,vger.kernel.org,gmail.com];
	TAGGED_FROM(0.00)[bounces-272772-lists,netdev=lfdr.de];
	FROM_HAS_DN(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	RCVD_TLS_LAST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	DKIM_TRACE(0.00)[lunn.ch:+];
	MISSING_XM_UA(0.00)[];
	TO_DN_SOME(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[andrew@lunn.ch,netdev@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	MID_RHS_MATCH_FROM(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	RCPT_COUNT_SEVEN(0.00)[9];
	ASN(0.00)[asn:63949, ipnet:172.105.96.0/20, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns,lunn.ch:dkim,lunn.ch:mid]
X-Rspamd-Queue-Id: 3257534EB35
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

On Sat, Mar 28, 2026 at 05:24:28PM +0800, Yufan Chen wrote:
> From: Yufan Chen <ericterminal@gmail.com>
> 
> ftgmac100_alloc_rings() allocated rx_skbs, tx_skbs, rxdes, txdes, and rx_scratch in stages but returned directly on any intermediate allocation failure. This left previously allocated objects unreleased and could accumulate leaks across repeated ifup retries under memory pressure.

Please take a read of

https://docs.kernel.org/process/submitting-patches.html

and

https://www.kernel.org/doc/html/latest/process/maintainer-netdev.html


You have a number of process issues.

>  static int ftgmac100_alloc_rings(struct ftgmac100 *priv)
>  {
> +	int err = -ENOMEM;
> +
>  	/* Allocate skb arrays */
>  	priv->rx_skbs = kcalloc(MAX_RX_QUEUE_ENTRIES, sizeof(void *),
>  				GFP_KERNEL);
>  	if (!priv->rx_skbs)
> -		return -ENOMEM;
> +		goto out;
>  	priv->tx_skbs = kcalloc(MAX_TX_QUEUE_ENTRIES, sizeof(void *),
>  				GFP_KERNEL);
>  	if (!priv->tx_skbs)
> -		return -ENOMEM;
> +		goto out;
>  
>  	/* Allocate descriptors */
>  	priv->rxdes = dma_alloc_coherent(priv->dev,
>  					 MAX_RX_QUEUE_ENTRIES * sizeof(struct ftgmac100_rxdes),
>  					 &priv->rxdes_dma, GFP_KERNEL);
>  	if (!priv->rxdes)
> -		return -ENOMEM;
> +		goto out;
>  	priv->txdes = dma_alloc_coherent(priv->dev,
>  					 MAX_TX_QUEUE_ENTRIES * sizeof(struct ftgmac100_txdes),
>  					 &priv->txdes_dma, GFP_KERNEL);
>  	if (!priv->txdes)
> -		return -ENOMEM;
> +		goto out;
>  
>  	/* Allocate scratch packet buffer */
>  	priv->rx_scratch = dma_alloc_coherent(priv->dev,
> @@ -997,9 +1002,13 @@ static int ftgmac100_alloc_rings(struct ftgmac100 *priv)
>  					      &priv->rx_scratch_dma,
>  					      GFP_KERNEL);
>  	if (!priv->rx_scratch)
> -		return -ENOMEM;
> +		goto out;
>  
>  	return 0;
> +
> +out:
> +	ftgmac100_free_rings(priv);
> +	return err;

If you look at other drivers, you will notice that functions that do
allocations pretty much always do their own cleanup, rather than
calling a helper. You generally see multiple labels, one per
allocation, and gotos jumping to the needed code.

    Andrew

---
pw-bot: cr

