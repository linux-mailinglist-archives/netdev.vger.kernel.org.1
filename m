Return-Path: <netdev+bounces-204185-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 47983AF968B
	for <lists+netdev@lfdr.de>; Fri,  4 Jul 2025 17:15:27 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 7158816485D
	for <lists+netdev@lfdr.de>; Fri,  4 Jul 2025 15:15:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 65745189B80;
	Fri,  4 Jul 2025 15:15:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="RGM4eavL"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3D45C18A6A7;
	Fri,  4 Jul 2025 15:15:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751642118; cv=none; b=pDvqSA+92SdpjDESlG5ctfNwbfznaj9Lfs89vVbKEBZAanzX6Mn+1RGPxCeMxMmEEqQf04u2zBrhEVTU5i32jTSY8vqVcPa5bfmyA4kKZtSP47GWc5n2LtRFHYUSEZpT3S8Z7I34yVXMFgLZ/1iAjsUsuZkoXpEzziSq5e/IvnU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751642118; c=relaxed/simple;
	bh=M29PB0qokE4bmLeeZQ5HIARhdbWunEgM+7tuL3dyYvo=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=L59eoJD0S8RLcmWo9XnUIW7P8y22T9N8X1sgyzVysERNVWwQ8GKNPr92nFm8Aci1VYC5UzJz/94aMI5fWf5tATYu40LX3YI0wEBBXgrBJTLv3QsliAlcvxyslkODefbLVakA3CbBtNhEe0urrsGfB4AG/cW5zd50NEypcjRz12c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=RGM4eavL; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id BA93DC4CEE3;
	Fri,  4 Jul 2025 15:15:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1751642116;
	bh=M29PB0qokE4bmLeeZQ5HIARhdbWunEgM+7tuL3dyYvo=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=RGM4eavLoDlvJygoBJF2xosQ7RRXB5xI6BnG0LMsvRPSiEaAePSLrGyXDg3nc+YRT
	 PQ614E/W1N3llo8GpQwtQ+9qQU5+nvL2rCS86DQ5mOjb7gi4+bSyol29RNyWFpVOM+
	 NH8bbekU6eo50PSyK1LefqqTdQ+AyBr9ysSK8sOOr9LzHUhII91D08mFSc9vMGYi7h
	 rlXJGa4EwDGy1UmnJ6k4IIzv0xp/QZiKOFFAZxFN46Pt0lEFwouRsv7/3mzYt5rQ6f
	 bUXYuGwcExH0MjVajMmhEKVu/BQDldzqMb96llhmPVsJbCwuvot2g3Ce7W5BCi/4mX
	 fdzcSm9IcxW4A==
Date: Fri, 4 Jul 2025 16:15:11 +0100
From: Simon Horman <horms@kernel.org>
To: Hariprasad Kelam <hkelam@marvell.com>
Cc: netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
	Sunil Goutham <sgoutham@marvell.com>,
	Geetha sowjanya <gakula@marvell.com>,
	Subbaraya Sundeep <sbhatta@marvell.com>,
	Bharat Bhushan <bbhushan2@marvell.com>,
	Andrew Lunn <andrew+netdev@lunn.ch>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	Tomasz Duszynski <tduszynski@marvell.com>
Subject: Re: [net] Octeontx2-vf: Fix max packet length errors
Message-ID: <20250704151511.GE41770@horms.kernel.org>
References: <20250702110518.631532-1-hkelam@marvell.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250702110518.631532-1-hkelam@marvell.com>

On Wed, Jul 02, 2025 at 04:35:18PM +0530, Hariprasad Kelam wrote:
> Implement packet length validation before submitting packets to
> the hardware to prevent MAXLEN_ERR.
> 
> Fixes: 3184fb5ba96e ("octeontx2-vf: Virtual function driver support")
> Signed-off-by: Hariprasad Kelam <hkelam@marvell.com>
> ---
>  drivers/net/ethernet/marvell/octeontx2/nic/otx2_vf.c | 7 +++++++
>  1 file changed, 7 insertions(+)
> 
> diff --git a/drivers/net/ethernet/marvell/octeontx2/nic/otx2_vf.c b/drivers/net/ethernet/marvell/octeontx2/nic/otx2_vf.c
> index 8a8b598bd389..766237cd86c3 100644
> --- a/drivers/net/ethernet/marvell/octeontx2/nic/otx2_vf.c
> +++ b/drivers/net/ethernet/marvell/octeontx2/nic/otx2_vf.c
> @@ -394,6 +394,13 @@ static netdev_tx_t otx2vf_xmit(struct sk_buff *skb, struct net_device *netdev)
>  	struct otx2_snd_queue *sq;
>  	struct netdev_queue *txq;
>  
> +	/* Check for minimum and maximum packet length */
> +	if (skb->len <= ETH_HLEN ||
> +	    (!skb_shinfo(skb)->gso_size && skb->len > vf->tx_max_pktlen)) {
> +		dev_kfree_skb(skb);
> +		return NETDEV_TX_OK;
> +	}

Hi Hariprasad,

I see the same check in otx2_xmit().
But I wonder if in that case and this one the rx drop counter for the
netdev should be incremented.

Also, do you need this check in rvu_rep_xmit() too?

> +
>  	sq = &vf->qset.sq[qidx];
>  	txq = netdev_get_tx_queue(netdev, qidx);
>  
> -- 
> 2.34.1
> 
> 

