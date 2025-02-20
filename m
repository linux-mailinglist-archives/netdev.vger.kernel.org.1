Return-Path: <netdev+bounces-167954-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id D0115A3CF43
	for <lists+netdev@lfdr.de>; Thu, 20 Feb 2025 03:14:34 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 30D277A7471
	for <lists+netdev@lfdr.de>; Thu, 20 Feb 2025 02:13:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DDDE91CAA60;
	Thu, 20 Feb 2025 02:14:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="md+6dxb6"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B84161C5D79
	for <netdev@vger.kernel.org>; Thu, 20 Feb 2025 02:14:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740017668; cv=none; b=TCmERDxxeDap+QDS42s+euR3oENe3anyiD3/lCmIHznOVOmSXN4ALnFMCzKQvOI1aA2ByXnq8nJY5+U++pS8pdfTcupnaq5/p4jh23w20H8H0eQc/ZKS67JP6xTPiAAu5Xo07DwpykUnZqSHt8+C0rOspZgT6xI55OP5U4457+E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740017668; c=relaxed/simple;
	bh=MTS3d+TD3MBN2C31DZy5wTwBz77LsrHKyepTWNrCHW0=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=YCoWsY6lRQA5Q14dR6oAy85Lnkrd38fMHiY7YATtTrh5oHllD4Ma1p25LVQSpu2gBpqvmedbfl19QqAquNqQ+6c32gqh5zt1NWkt4UI8ICyPl1l4xYWaLr/nOHO+Z8xvF6Haian9k9I51bho/y0Px1wgSODiV6kcJm+JYn/TYyM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=md+6dxb6; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id AC581C4CED1;
	Thu, 20 Feb 2025 02:14:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1740017668;
	bh=MTS3d+TD3MBN2C31DZy5wTwBz77LsrHKyepTWNrCHW0=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=md+6dxb6U8OxekQ+ox8rRV2LsQNZSLfS8pKh4GibQe/PvUl0/QlkZAxiK5ZbaNF3h
	 eLqqZQcqkX+qJzPAQvBU25sG0gnEWVC1mq79riZGY48ErBOAii49v4QNCfkPCkW9dm
	 7KKJuF7fFvAfSIEcJ9dm6FpyBylMnJS6F5dKENzHw0nTe/pIomnzmljAQBsMLqjykq
	 Zv3hLtzogyEimMsm9m4PqPltLcAbdxUJbzmIWul5zFegQNCS5rmiId2xelkB1QwsC7
	 i0kHnBMFKEjEwjK7o9pEl5aDjXs8Pn9Sr7FYBqLBwofHnSKKGaH30qTKhDt+xXAjoc
	 OH9Fttm8MSi1w==
Date: Wed, 19 Feb 2025 18:14:27 -0800
From: Jakub Kicinski <kuba@kernel.org>
To: Daniel Xu <dxu@dxuuu.xyz>
Cc: davem@davemloft.net, netdev@vger.kernel.org, edumazet@google.com,
 pabeni@redhat.com, andrew+netdev@lunn.ch, horms@kernel.org,
 daniel@iogearbox.net, hawk@kernel.org, john.fastabend@gmail.com,
 michael.chan@broadcom.com, pavan.chebbi@broadcom.com, ap420073@gmail.com
Subject: Re: [PATCH net 1/2] bnxt: don't reject XDP installation when HDS
 isn't forced on
Message-ID: <20250219181427.3d7aa28f@kernel.org>
In-Reply-To: <w3kr4zyocloibq6mniumhtcbp6hqfur6uzqeem6hpoe76t2gqr@4jmz72w3wrw3>
References: <20250220005318.560733-1-kuba@kernel.org>
	<w3kr4zyocloibq6mniumhtcbp6hqfur6uzqeem6hpoe76t2gqr@4jmz72w3wrw3>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Wed, 19 Feb 2025 18:58:02 -0700 Daniel Xu wrote:
> > @@ -395,7 +397,7 @@ static int bnxt_xdp_set(struct bnxt *bp, struct bpf_prog *prog)
> >  			    bp->dev->mtu, BNXT_MAX_PAGE_MODE_MTU);
> >  		return -EOPNOTSUPP;
> >  	}
> > -	if (prog && bp->flags & BNXT_FLAG_HDS) {
> > +	if (prog && dev->cfg->hds_config == ETHTOOL_TCP_DATA_SPLIT_ENABLED) {
> >  		netdev_warn(dev, "XDP is disallowed when HDS is enabled.\n");
> >  		return -EOPNOTSUPP;
> >  	}
> > -- 
> > 2.48.1
> >   
> 
> Nice, that fixed it.
> 
> Tested-by: Daniel Xu <dxu@dxuuu.xyz>

I looked again after sending because it wasn't sitting 100% well with
me. As the commit message says this will work, because it forces all
flags to off. But the driver is also only setting its internal flag
when user requested. So why does it get set in the first place..

I think the real fix may be:

@@ -2071,6 +2072,8 @@ static int ethtool_set_ringparam(struct net_device *dev, void __user *useraddr)
 
        dev->ethtool_ops->get_ringparam(dev, &max, &kernel_ringparam, NULL);
 
+       kernel_ringparam.tcp_data_split = dev->cfg->hds_config;
+
        /* ensure new ring parameters are within the maximums */
        if (ringparam.rx_pending > max.rx_max_pending ||
            ringparam.rx_mini_pending > max.rx_mini_max_pending ||

This is the legacy / ioctl path. We don't hit it in testing, but you
probably hit it via systemd.

At least that's my current theory, waiting for the test kernel 
to deploy.  Sorry for the flip flop..

