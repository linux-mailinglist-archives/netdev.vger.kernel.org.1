Return-Path: <netdev+bounces-281321-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id GI8fFtpf72mHAwEAu9opvQ
	(envelope-from <netdev+bounces-281321-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Mon, 27 Apr 2026 15:08:42 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id B214747327A
	for <lists+netdev@lfdr.de>; Mon, 27 Apr 2026 15:08:41 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id E73A530048C9
	for <lists+netdev@lfdr.de>; Mon, 27 Apr 2026 13:02:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CBE572F25F0;
	Mon, 27 Apr 2026 13:02:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b="De8Z4zpB"
X-Original-To: netdev@vger.kernel.org
Received: from vps0.lunn.ch (vps0.lunn.ch [156.67.10.101])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6FC3740DFD6
	for <netdev@vger.kernel.org>; Mon, 27 Apr 2026 13:02:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=156.67.10.101
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777294973; cv=none; b=F9Ol/2HLfOjEo6DHWpNbGD65Ztwqg5njJ+O90GOUP0m3R+nqshRJcTQbVCmvMkG0MJcODaw6Mq7EIHKwC5DvEqwX0x8XLf/gexeOKZGPe1uPTJpHZQYKQlK8ZhEdBjW1jURA3dfM9Z9r0OZcsICOxJ4Q+pKSLb3iLISGb+FxLXA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777294973; c=relaxed/simple;
	bh=eq4Zs9e7kjJN/3IntWgHqiaxmH22/3zBsk3QOWsXIJc=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=cfolQRrt4+uD3Cz3jILTk15vpRJREvUrEcGVdPu97Jv0VF36ojvbtMyNiOg3oIca+oVRScE/1aF12faf8WgH1DpCAVpLxo/YBxKbaEh6eaF/fNw2P6UuGvdKtat/bhvYWWgWnia5/phLJBhY+mlUT5vFEOk7NZrg7Zwj4V2NRHY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch; spf=pass smtp.mailfrom=lunn.ch; dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b=De8Z4zpB; arc=none smtp.client-ip=156.67.10.101
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lunn.ch
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=lunn.ch;
	s=20171124; h=In-Reply-To:Content-Disposition:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:From:Sender:Reply-To:Subject:
	Date:Message-ID:To:Cc:MIME-Version:Content-Type:Content-Transfer-Encoding:
	Content-ID:Content-Description:Content-Disposition:In-Reply-To:References;
	bh=1sw4PI45T8Ivb7+XZcvcASIQ8ljy3VWSaI4gU4iBOZU=; b=De8Z4zpBgkdV7HMmNGAREaTf+W
	rW+fbTnHTT9Ao2JDj0jNsXNawn0kyUybyC9OGWLmXD/WZqB5Bh8zooakqH8j5mXA4mqFO6npK9ORs
	B52x+CM9ufCal4rrzol9wP8ot199aLIvDfaNHGbdJkhtUWu7asaHaabaU4iU3QKzZB90=;
Received: from andrew by vps0.lunn.ch with local (Exim 4.94.2)
	(envelope-from <andrew@lunn.ch>)
	id 1wHLbu-000A81-1A; Mon, 27 Apr 2026 15:02:50 +0200
Date: Mon, 27 Apr 2026 15:02:50 +0200
From: Andrew Lunn <andrew@lunn.ch>
To: kernelcoredev <sonionwhat@gmail.com>
Cc: netdev@vger.kernel.org, andrew+netdev@lunn.ch, davem@davemloft.net,
	edumazet@google.com, kuba@kernel.org, pabeni@redhat.com
Subject: Re: [PATCH] net: nixge: fix skb leak and missing bail on DMA mapping
 error
Message-ID: <07c71deb-0aea-420f-b8eb-4a0a1f0ae42a@lunn.ch>
References: <20260427060046.3927-1-sonionwhat@gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260427060046.3927-1-sonionwhat@gmail.com>
X-Rspamd-Queue-Id: B214747327A
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.66 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[lunn.ch,none];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	R_DKIM_ALLOW(-0.20)[lunn.ch:s=20171124];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-281321-lists,netdev=lfdr.de];
	FROM_HAS_DN(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	FREEMAIL_TO(0.00)[gmail.com];
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
	RCPT_COUNT_SEVEN(0.00)[7];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,lunn.ch:dkim,lunn.ch:mid]

On Mon, Apr 27, 2026 at 02:00:46AM -0400, kernelcoredev wrote:
> When dma_mapping_error() fires during RX buffer refill in nixge_recv(),
> the skb allocated by netdev_alloc_skb_ip_align() is never freed, and
> execution continues writing a corrupt physical address into the hardware
> descriptor ring.
> 
> Fix by freeing the skb with dev_kfree_skb() and returning early.
> 
> Fixes: 492caffa8a1a ("net: ethernet: nixge: Add support for National Instruments XGE netdev")
> 
> Signed-off-by: Bentley Blacketer <sonionwhat@gmail.com>
> ---
>  drivers/net/ethernet/ni/nixge.c | 5 +++--
>  1 file changed, 3 insertions(+), 2 deletions(-)
> 
> diff --git a/drivers/net/ethernet/ni/nixge.c b/drivers/net/ethernet/ni/nixge.c
> index 230d5ff99..b64e2f355 100644
> --- a/drivers/net/ethernet/ni/nixge.c
> +++ b/drivers/net/ethernet/ni/nixge.c
> @@ -645,8 +645,9 @@ static int nixge_recv(struct net_device *ndev, int budget)
>  					  NIXGE_MAX_JUMBO_FRAME_SIZE,
>  					  DMA_FROM_DEVICE);
>  		if (dma_mapping_error(ndev->dev.parent, cur_phys)) {
> -			/* FIXME: bail out and clean up */
> -			netdev_err(ndev, "Failed to map ...\n");
> +			netdev_err(ndev, "Failed to map RX buffer\n");
> +			dev_kfree_skb(new_skb);
> +			return packets;

Please add to the commit message an explanation of how you tested
this. Did you hack dma_mapping_error() so that 1 in 1000 is returned
an error?

   Andrew

