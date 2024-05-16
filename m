Return-Path: <netdev+bounces-96697-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id C05968C7318
	for <lists+netdev@lfdr.de>; Thu, 16 May 2024 10:43:57 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id F1DCE1C21A8B
	for <lists+netdev@lfdr.de>; Thu, 16 May 2024 08:43:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 49E30142E62;
	Thu, 16 May 2024 08:43:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="pkg4pDxZ"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 22D8A6BFBF;
	Thu, 16 May 2024 08:43:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715849033; cv=none; b=A0V97csrOAzeGu1ixcOkQ+nOk3+LSUys3PE1zJZK5Y51yKwa+Ok9U7NYLdWzUBkZl3grQvYkM54HZ7AL4X70kzz/GQjQlg8RT+ekTYcm+dnvyQhPrzmyjyPaonzTwh4h8/02VtyPd1yTW2MhMCa5VwekyfWYjDz+nl2Qwgld8hI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715849033; c=relaxed/simple;
	bh=7eowNZsP0z/IUYzGQw3TrUkJcTIY48766X+Sspo9t44=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=DQKwG2r+lUnih4Ljog+smyJP8nyTS4L0nxoEXjU5EGLD2ESRQwsRc7SJX43MIPfX6Pnjsf6hImrS83V58xAMVMOq6uhEUPPG1Ect7Urp4cJcQBXwHohtbxZIjOLfypBgCdG6f5tRu3scaXQITv2fIksFj1+RCpHKzO0WrDlQ5/c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=pkg4pDxZ; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B46C1C32781;
	Thu, 16 May 2024 08:43:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1715849032;
	bh=7eowNZsP0z/IUYzGQw3TrUkJcTIY48766X+Sspo9t44=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=pkg4pDxZ1kyNT3gWta5QQ1ZLtC/xQUwyvpn1l27JH2A8G3uR767HFOTFDgDiKwfeV
	 SaANF+IDO1eZVTDEN3IKoTZVQCT2KLPJvxE7QeF8p8L6h2pQtyEBYe2fDpEfFUL529
	 iLZHYrSZNKHGR1SZCok/X/4GCOxcsnGD54B66dxe2o0mJkl42PBGERX6sFlDoIQFRN
	 D5pAVChuwKIIzBd/84TFPrZNFWx8hziSSTv9B27D+UBfo0uptOUyjpu8hLh0FyOEEO
	 49ocJz7XPoPLlcEYQlAJ3tOBRmhgFItbecA0+jXEVsLX2ch5+RRHhsvZGzBk1pBYxa
	 Xgb0sguWwoocA==
Date: Thu, 16 May 2024 09:43:48 +0100
From: Simon Horman <horms@kernel.org>
To: Ryosuke Yasuoka <ryasuoka@redhat.com>
Cc: krzk@kernel.org, davem@davemloft.net, edumazet@google.com,
	kuba@kernel.org, pabeni@redhat.com, netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org, syoshida@redhat.com
Subject: Re: [PATCH net] nfc: nci: Fix handling of zero-length payload
 packets in nci_rx_work()
Message-ID: <20240516084348.GF179178@kernel.org>
References: <20240515151757.457353-1-ryasuoka@redhat.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240515151757.457353-1-ryasuoka@redhat.com>

Hi Yasuoka-san,

On Thu, May 16, 2024 at 12:17:07AM +0900, Ryosuke Yasuoka wrote:
> When nci_rx_work() receives a zero-length payload packet, it should
> discard the packet without exiting the loop. Instead, it should continue
> processing subsequent packets.

nit: I think it would be clearer to say:

... it should not discard the packet and exit the loop. Instead, ...

> 
> Fixes: d24b03535e5e ("nfc: nci: Fix uninit-value in nci_dev_up and nci_ntf_packet")
> Closes: https://lore.kernel.org/lkml/20240428134525.GW516117@kernel.org/T/

nit: I'm not sure this Closes link is adding much,
     there are more changes coming, right?

> Reported-by: Ryosuke Yasuoka <ryasuoka@redhat.com>
> Signed-off-by: Ryosuke Yasuoka <ryasuoka@redhat.com>
> ---
>  net/nfc/nci/core.c | 3 +--
>  1 file changed, 1 insertion(+), 2 deletions(-)
> 
> diff --git a/net/nfc/nci/core.c b/net/nfc/nci/core.c
> index b133dc55304c..f2ae8b0d81b9 100644
> --- a/net/nfc/nci/core.c
> +++ b/net/nfc/nci/core.c
> @@ -1518,8 +1518,7 @@ static void nci_rx_work(struct work_struct *work)
>  
>  		if (!nci_plen(skb->data)) {
>  			kfree_skb(skb);
> -			kcov_remote_stop();
> -			break;
> +			continue;
>  		}
>  
>  		/* Process frame */
> -- 
> 2.44.0
> 
> 

