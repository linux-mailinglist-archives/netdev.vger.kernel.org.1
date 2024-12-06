Return-Path: <netdev+bounces-149650-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id A4D519E69F7
	for <lists+netdev@lfdr.de>; Fri,  6 Dec 2024 10:23:38 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 5C8DA2818C7
	for <lists+netdev@lfdr.de>; Fri,  6 Dec 2024 09:23:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 78C071DFDAE;
	Fri,  6 Dec 2024 09:23:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="muxZCgEB"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 40DC31DC74A;
	Fri,  6 Dec 2024 09:23:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733477014; cv=none; b=USYffjEFM8kzlzm8DyeccjwJEdaUApg0kgF7YrXY494LmRw1E3LFNzItxbBFFCI9mGL57w/Z6Pr7iCZp1PHyXwGohTdlndbc+W0t4HT0i/oqnbwnQZOyMXac5MujEOK7aH/g751PHZ6QcwiqDmG2/9umO/gIUkj9kqCQOLWiTFo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733477014; c=relaxed/simple;
	bh=xY98lH0BaSIV8zagioaYJbX3C7J/Vz6AsNwU2/8yh5g=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=hc1aU7JMWjC73ocEJYSEaLhPgeICpc2DVFMQCJIRFUDv7l8Ow0XgI1sNx1knbb2QXm+c34sAZ9YWBwc4nLm+/esBwXGLCulCxFPN4k9BBmXN+p4nZsnALzPvpdF90SBfdbBt4zkihEnv/JGDK0DyQXcFa4JsLlzvvpvv5vUhahI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=muxZCgEB; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 57B29C4CED1;
	Fri,  6 Dec 2024 09:23:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1733477013;
	bh=xY98lH0BaSIV8zagioaYJbX3C7J/Vz6AsNwU2/8yh5g=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=muxZCgEBz0M5Ct3kKIQS/zq4BLME/kZrcWo3rKfb15ThlsOcVQZC8s6CPbKs9n3Ve
	 KpmwfkYsfoSRTHNNXeWA+CipKEfaSwXsBQYqWLnpiGiGYQcJX8OCVrmTQ2wY4mSQBo
	 p039+cTh4QZ2vdaAQvHJtsaS9HyP9WNQuzBs3dWu09+ZaQJAsxcNO74/iz1x7fWabP
	 lje714EpTQ1FJ6xepNUgGoWkI24PUGyGk62K7VXCj+SaX+2baKCmKMWfh9GBQdnkom
	 2ttfRcNxEFQ4kbQ9ms4NCgQOvRsS261dLpvYVdv5Ucrmfz5i35pOJYhtOBv9yoX7ma
	 1lfE6pU5VIQtQ==
Date: Fri, 6 Dec 2024 09:23:29 +0000
From: Simon Horman <horms@kernel.org>
To: Wei Fang <wei.fang@nxp.com>
Cc: claudiu.manoil@nxp.com, vladimir.oltean@nxp.com, xiaoning.wang@nxp.com,
	andrew+netdev@lunn.ch, davem@davemloft.net, edumazet@google.com,
	kuba@kernel.org, pabeni@redhat.com, frank.li@nxp.com,
	netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
	imx@lists.linux.dev
Subject: Re: [PATCH v6 RESEND net-next 1/5] net: enetc: add Rx checksum
 offload for i.MX95 ENETC
Message-ID: <20241206092329.GH2581@kernel.org>
References: <20241204052932.112446-1-wei.fang@nxp.com>
 <20241204052932.112446-2-wei.fang@nxp.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20241204052932.112446-2-wei.fang@nxp.com>

On Wed, Dec 04, 2024 at 01:29:28PM +0800, Wei Fang wrote:
> ENETC rev 4.1 supports TCP and UDP checksum offload for receive, the bit
> 108 of the Rx BD will be set if the TCP/UDP checksum is correct. Since
> this capability is not defined in register, the rx_csum bit is added to
> struct enetc_drvdata to indicate whether the device supports Rx checksum
> offload.
> 
> Signed-off-by: Wei Fang <wei.fang@nxp.com>
> Reviewed-by: Frank Li <Frank.Li@nxp.com>
> Reviewed-by: Claudiu Manoil <claudiu.manoil@nxp.com>
> ---
> v2: no changes
> v3: no changes
> v4: no changes
> v5: no changes
> v6: no changes
> ---
>  drivers/net/ethernet/freescale/enetc/enetc.c       | 14 ++++++++++----
>  drivers/net/ethernet/freescale/enetc/enetc.h       |  2 ++
>  drivers/net/ethernet/freescale/enetc/enetc_hw.h    |  2 ++
>  .../net/ethernet/freescale/enetc/enetc_pf_common.c |  3 +++
>  4 files changed, 17 insertions(+), 4 deletions(-)
> 
> diff --git a/drivers/net/ethernet/freescale/enetc/enetc.c b/drivers/net/ethernet/freescale/enetc/enetc.c
> index 35634c516e26..3137b6ee62d3 100644
> --- a/drivers/net/ethernet/freescale/enetc/enetc.c
> +++ b/drivers/net/ethernet/freescale/enetc/enetc.c
> @@ -1011,10 +1011,15 @@ static void enetc_get_offloads(struct enetc_bdr *rx_ring,
>  
>  	/* TODO: hashing */
>  	if (rx_ring->ndev->features & NETIF_F_RXCSUM) {
> -		u16 inet_csum = le16_to_cpu(rxbd->r.inet_csum);
> -
> -		skb->csum = csum_unfold((__force __sum16)~htons(inet_csum));
> -		skb->ip_summed = CHECKSUM_COMPLETE;
> +		if (priv->active_offloads & ENETC_F_RXCSUM &&
> +		    le16_to_cpu(rxbd->r.flags) & ENETC_RXBD_FLAG_L4_CSUM_OK) {
> +			skb->ip_summed = CHECKSUM_UNNECESSARY;
> +		} else {
> +			u16 inet_csum = le16_to_cpu(rxbd->r.inet_csum);
> +
> +			skb->csum = csum_unfold((__force __sum16)~htons(inet_csum));
> +			skb->ip_summed = CHECKSUM_COMPLETE;
> +		}
>  	}

Hi Wei,

I am wondering about the relationship between the above and
hardware support for CHECKSUM_COMPLETE.

Prior to this patch CHECKSUM_COMPLETE was always used, which seems
desirable. But with this patch, CHECKSUM_UNNECESSARY is conditionally used.

If those cases don't work with CHECKSUM_COMPLETE then is this a bug-fix?

Or, alternatively, if those cases do work with CHECKSUM_COMPLETE, then
I'm unsure why this change is necessary or desirable. It's my understanding
that from the Kernel's perspective CHECKSUM_COMPLETE is preferable to
CHECKSUM_UNNECESSARY.

...

