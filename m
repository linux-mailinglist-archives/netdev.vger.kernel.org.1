Return-Path: <netdev+bounces-89822-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id B141A8ABBEB
	for <lists+netdev@lfdr.de>; Sat, 20 Apr 2024 16:03:33 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id B1B1D1C20AD6
	for <lists+netdev@lfdr.de>; Sat, 20 Apr 2024 14:03:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2B9B922301;
	Sat, 20 Apr 2024 14:03:18 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from pidgin.makrotopia.org (pidgin.makrotopia.org [185.142.180.65])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 04C5426AF3
	for <netdev@vger.kernel.org>; Sat, 20 Apr 2024 14:03:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.142.180.65
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713621798; cv=none; b=DMuHfzllmnxKFoOnbMigR2nn1eZtWBoWxGJElYlldGKIbj/ydb98xLm5oF3IeiqZ3nmQt9JUVZA1SPh9Fzdo9V/U6011DIm3JcN/tSWFE808medkkuYG2CrzBlSE8WA4MAF6ls1MvbyQZSROp/uXthr44OCA5yMQLGM+xBjavdM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713621798; c=relaxed/simple;
	bh=RHb2Csd+hNqFgC6JCAOCzps5vkPmfn6XSs9rG+0No2I=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=YciakuoZ/IQ/VTvJFfjQtlCiLOpBcjjnerAyJtJXnZ67927gmWQemrTKxKrmO7zYLDDr+iodg3qIzui3OiQDgfI3U1zdNUK+nJDSULpVfpF+B+12tKpNDLLP83HTh/iEFVk1xzce8+5Y/AdmAArWPu2Fn0vquagHWKoSj3d1yLw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=makrotopia.org; spf=pass smtp.mailfrom=makrotopia.org; arc=none smtp.client-ip=185.142.180.65
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=makrotopia.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=makrotopia.org
Received: from local
	by pidgin.makrotopia.org with esmtpsa (TLS1.3:TLS_AES_256_GCM_SHA384:256)
	 (Exim 4.97.1)
	(envelope-from <daniel@makrotopia.org>)
	id 1ryBJ1-000000002Su-3Mqf;
	Sat, 20 Apr 2024 14:03:03 +0000
Date: Sat, 20 Apr 2024 15:02:57 +0100
From: Daniel Golle <daniel@makrotopia.org>
To: David Bauer <mail@david-bauer.net>
Cc: davem@davemloft.net, edumazet@google.com, kuba@kernel.org,
	pabeni@redhat.com, netdev@vger.kernel.org
Subject: Re: [PATCH net-next] net l2tp: drop flow hash on forward
Message-ID: <ZiPLEdv97kX39k21@makrotopia.org>
References: <20240420133940.5476-1-mail@david-bauer.net>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240420133940.5476-1-mail@david-bauer.net>

On Sat, Apr 20, 2024 at 03:39:40PM +0200, David Bauer wrote:
> Drop the flow-hash of the skb when forwarding to the L2TP netdev.
> 
> This avoids the L2TP qdisc from using the flow-hash from the outer
> packet, which is identical for every flow within the tunnel.
> 
> This does not affect every platform but is specific for the ethernet
> driver. It depends on the platform including L4 information in the
> flow-hash.
> 
> One such example is the Mediatek Filogic MT798x family of networking
> processors.
> 
> Signed-off-by: David Bauer <mail@david-bauer.net>

While it's difficult to say which exact commit this fixes, I still
consider it being a fix, as otherwise flow-offloading on mentioned
platforms will face difficulties when using L2TP (right?).
Hence maybe it should go via 'net' tree rather than via 'net-next'?

The fix itself looks fine to me.

> ---
>  net/l2tp/l2tp_eth.c | 3 +++
>  1 file changed, 3 insertions(+)
> 
> diff --git a/net/l2tp/l2tp_eth.c b/net/l2tp/l2tp_eth.c
> index 39e487ccc468..8ba00ad433c2 100644
> --- a/net/l2tp/l2tp_eth.c
> +++ b/net/l2tp/l2tp_eth.c
> @@ -127,6 +127,9 @@ static void l2tp_eth_dev_recv(struct l2tp_session *session, struct sk_buff *skb,
>  	/* checksums verified by L2TP */
>  	skb->ip_summed = CHECKSUM_NONE;
>  
> +	/* drop outer flow-hash */
> +	skb_clear_hash(skb);
> +
>  	skb_dst_drop(skb);
>  	nf_reset_ct(skb);
>  
> -- 
> 2.43.0
> 
> 

