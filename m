Return-Path: <netdev+bounces-15628-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id EAF57748D6E
	for <lists+netdev@lfdr.de>; Wed,  5 Jul 2023 21:10:37 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 05AF71C20BE7
	for <lists+netdev@lfdr.de>; Wed,  5 Jul 2023 19:10:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EBDD614ABD;
	Wed,  5 Jul 2023 19:10:34 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 40F9D15482
	for <netdev@vger.kernel.org>; Wed,  5 Jul 2023 19:10:33 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 830E6C433C9;
	Wed,  5 Jul 2023 19:10:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1688584233;
	bh=5v2Jcbu23jOZ3NaXiTSv75lRiQHToTnbx3t9Ier4ieA=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=qaRFN7is3IkXgvJVuogihBRu2z0M9hIkMOoVNNKz0aqlLr9bWl0sGVxKe64O/gDmf
	 COB5jjtZ75SrFflvrcpcpOz5laZmr+8IAq8TFsZauo8Qxt7Z+vTsiguElCzwp3lIgR
	 HanYQpRRWpy8UzeRiJmTEDbxBR2xvZxbvl82AMN1bgrz9KDfpW5t86f8dunErGqzIv
	 ANDRrSxrxoUuDv3zvDDByMd3ACbFRRg+zfm7ATTy2aiQPtH2IWh/sYZyeZ6zK2ryP2
	 plqsqzfA/8zk4qdInLZoucroxki4WylAJh6guGCNBePq5eLsEjuHt8YwdLm5ODeSGO
	 v94qReik0nw+w==
Date: Wed, 5 Jul 2023 22:10:28 +0300
From: Leon Romanovsky <leon@kernel.org>
To: Wang Ming <machel@vivo.com>
Cc: Sunil Goutham <sgoutham@marvell.com>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	linux-arm-kernel@lists.infradead.org, netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org, opensource.kernel@vivo.com
Subject: Re: [PATCH net v2] net:thunderx:Fix resource leaks in
 device_for_each_child_node() loops
Message-ID: <20230705191028.GP6455@unreal>
References: <20230705143507.4120-1-machel@vivo.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230705143507.4120-1-machel@vivo.com>

On Wed, Jul 05, 2023 at 10:34:56PM +0800, Wang Ming wrote:
> The device_for_each_child_node() loop in
> bgx_init_of_phy() function should have
> wnode_handle_put() before break
> which could avoid resource leaks.
> This patch could fix this bug.

It is very strange typographic. You have ~80 chars per-line, while your
longest line is 40 chars only.

> 
> Signed-off-by: Wang Ming <machel@vivo.com>
> ---
>  drivers/net/ethernet/cavium/thunder/thunder_bgx.c | 5 ++++-
>  1 file changed, 4 insertions(+), 1 deletion(-)
> 
> diff --git a/drivers/net/ethernet/cavium/thunder/thunder_bgx.c b/drivers/net/ethernet/cavium/thunder/thunder_bgx.c
> index a317feb8decb..dad32d36a015 100644
> --- a/drivers/net/ethernet/cavium/thunder/thunder_bgx.c
> +++ b/drivers/net/ethernet/cavium/thunder/thunder_bgx.c
> @@ -1478,8 +1478,10 @@ static int bgx_init_of_phy(struct bgx *bgx)
>  		 * cannot handle it, so exit the loop.
>  		 */
>  		node = to_of_node(fwn);
> -		if (!node)
> +		if (!node) {
> +			fwnode_handle_put(fwn);
>  			break;
> +		}
>  
>  		of_get_mac_address(node, bgx->lmac[lmac].mac);
>  
> @@ -1503,6 +1505,7 @@ static int bgx_init_of_phy(struct bgx *bgx)
>  		lmac++;
>  		if (lmac == bgx->max_lmac) {
>  			of_node_put(node);
> +			fwnode_handle_put(fwn);
>  			break;
>  		}
>  	}
> -- 
> 2.25.1
> 
> 

