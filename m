Return-Path: <netdev+bounces-103360-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 7BA7E907BA7
	for <lists+netdev@lfdr.de>; Thu, 13 Jun 2024 20:41:02 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 8E1071C2278B
	for <lists+netdev@lfdr.de>; Thu, 13 Jun 2024 18:41:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8B99314A09C;
	Thu, 13 Jun 2024 18:40:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="HNokVVAx"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 60F6F130AC8;
	Thu, 13 Jun 2024 18:40:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718304057; cv=none; b=BmuvYri4S03FeqyPp6cemQOA6IKLO7Nab4ZaOlDjfeXrec8muGULuHqqS7aTEEl0Q3Vxk6n+ZYSEP53eKUXSQ0Nl4m0zDs47jLamCQRzfZZLHWWE8F/b6qVidC7vMKUiK1fVydqI/W+NN0Szez34HXi0MMtpnuyCxhPHuyb4P3U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718304057; c=relaxed/simple;
	bh=dlNtThAMuLJ3XWCpoI7VTxxyt/1MyYvoexTmAVYy2OE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=aS2gyPUvE7eGOZYASIYZ6QMs4/iXPGV+xCkQC0WBN/jBO6vF+T1xBh71rE3nXfeiDj9bpnPqHpRry7MMXx57dkwl263KudCDFl3ltXqJWjTgcIMvDvgAJBaVNTD+NmivuCj61kmR/scTE2IZdX3T7qjosr6QkWsdzW4geqC/M+Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=HNokVVAx; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 06338C2BBFC;
	Thu, 13 Jun 2024 18:40:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1718304056;
	bh=dlNtThAMuLJ3XWCpoI7VTxxyt/1MyYvoexTmAVYy2OE=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=HNokVVAxZYYMWSUAKL4yoMg2IEvn+30uNAZ52QYlT5ph6gQB6bKcBnSVhcILFE70G
	 4JxsAHhH+kbBX0I9z+89VLKBxQZHzjDsHiBBw0hmXRshhrrMTphd/Q3FwVJuWCGk0d
	 TI0jERHgSyEBPcOmBaoR/WVONbliJCcJEzUnPEaQx4vMVt1LREyB3IgksjGIpnNnIM
	 2bdd34Vl6xr/DMXz/MlGMvoGtBYgg1Gs7/Tuw6UgLykDL1YVrNFJUVY5MtC39kg+2C
	 C5sN3M9yiu/jDVONNR5obFZDqu/C8pkPY7mc8W+uvrqWM5wselH5DGhjyqegqEMA/W
	 583c3W5dhEHSw==
Date: Thu, 13 Jun 2024 21:40:51 +0300
From: Leon Romanovsky <leon@kernel.org>
To: Bharat Bhushan <bbhushan2@marvell.com>
Cc: netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
	sgoutham@marvell.com, gakula@marvell.com, sbhatta@marvell.com,
	hkelam@marvell.com, davem@davemloft.net, edumazet@google.com,
	kuba@kernel.org, pabeni@redhat.com, jerinj@marvell.com,
	lcherian@marvell.com, richardcochran@gmail.com
Subject: Re: [net-next,v4 5/8] cn10k-ipsec: Add SA add/delete support for
 outb inline ipsec
Message-ID: <20240613184051.GH4966@unreal>
References: <20240612134622.2157086-1-bbhushan2@marvell.com>
 <20240612134622.2157086-6-bbhushan2@marvell.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240612134622.2157086-6-bbhushan2@marvell.com>

On Wed, Jun 12, 2024 at 07:16:19PM +0530, Bharat Bhushan wrote:
> This patch adds support to add and delete Security Association
> (SA) xfrm ops. Hardware maintains SA context in memory allocated
> by software. Each SA context is 128 byte aligned and size of
> each context is multiple of 128-byte. Add support for transport
> and tunnel ipsec mode, ESP protocol, aead aes-gcm-icv16, key size
> 128/192/256-bits with 32bit salt.
> 
> Signed-off-by: Bharat Bhushan <bbhushan2@marvell.com>
> ---
> v3->v4:
>  - Added check for crypto offload (XFRM_DEV_OFFLOAD_CRYPTO)
>    Thanks "Leon Romanovsky" for pointing out
>  
> v2->v3:
>  - Removed memset to zero wherever possible
>   (comment from Kalesh Anakkur Purayil)
>  - Corrected error hanlding when setting SA for inbound
>    (comment from Kalesh Anakkur Purayil)
>  - Move "netdev->xfrmdev_ops = &cn10k_ipsec_xfrmdev_ops;" to this patch
>    This fix build error with W=1
> 
>  .../marvell/octeontx2/nic/cn10k_ipsec.c       | 456 ++++++++++++++++++
>  .../marvell/octeontx2/nic/cn10k_ipsec.h       | 114 +++++
>  2 files changed, 570 insertions(+)
> 
> diff --git a/drivers/net/ethernet/marvell/octeontx2/nic/cn10k_ipsec.c b/drivers/net/ethernet/marvell/octeontx2/nic/cn10k_ipsec.c
> index fc1029c17c00..892bdbde92ee 100644
> --- a/drivers/net/ethernet/marvell/octeontx2/nic/cn10k_ipsec.c
> +++ b/drivers/net/ethernet/marvell/octeontx2/nic/cn10k_ipsec.c
> @@ -336,6 +336,12 @@ static int cn10k_outb_cpt_clean(struct otx2_nic *pf)
>  	/* Set inline ipsec disabled for this device */
>  	pf->flags &= ~OTX2_FLAG_INLINE_IPSEC_ENABLED;
>  
> +	if (!bitmap_empty(pf->ipsec.sa_bitmap, CN10K_IPSEC_OUTB_MAX_SA)) {
> +		netdev_err(pf->netdev, "SA installed on this device\n");
> +		mutex_unlock(&pf->ipsec.lock);
> +		return -EBUSY;
> +	}

Sorry for not really reviewing the patches and posting some random
comments, but this addition makes me wonder if it is correct
design/implementation. At the stage of IPsec cleanup, all SAs should be
removed before this call.

BTW, In kernel, this type of IPsec is called "Crypto Offload" and not
"inline ipsec".

Thanks

