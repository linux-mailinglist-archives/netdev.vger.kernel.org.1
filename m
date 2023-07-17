Return-Path: <netdev+bounces-18406-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 67542756C8E
	for <lists+netdev@lfdr.de>; Mon, 17 Jul 2023 20:55:43 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 512451C2037A
	for <lists+netdev@lfdr.de>; Mon, 17 Jul 2023 18:55:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1E69ABE4E;
	Mon, 17 Jul 2023 18:55:40 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D389F28FA
	for <netdev@vger.kernel.org>; Mon, 17 Jul 2023 18:55:38 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C5A89C433C8;
	Mon, 17 Jul 2023 18:55:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1689620138;
	bh=EDym6wpdqL4h4QQkHCfT0lGoRRSrFMz5M4NcQAU75DI=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=qGnbCMSSrj7XRsgDjgfTBbWrS7cqw3L4SIKtmf3xwHXCByBSq0MHp22BLg4JVuFuK
	 mGe4Kx4W9ZT+Ibxlxjr1givn9z4F1WjfQwKLOLQROslYTOa7RG+jOYBxigGPAU6nTS
	 hNtyv6muNhQ3B8BZEe05fxR6yTtzfXZzdCmsmye1r6arQ4EFwU2MYvpDghyRo4RdAt
	 IzN7om90DT6j/DyzYGEBdgP5bhdaFbYhwnmJH7dYEEW6QLF3KkBEb2jECBTPHdU5FJ
	 /YFnlqJmlteMuIANSJEun9vNFnT+6w2SmjBPjbSM562dr5zmtlbETACnmxtp+YrrH9
	 F6WGH8vNnXx0Q==
Date: Mon, 17 Jul 2023 21:55:33 +0300
From: Leon Romanovsky <leon@kernel.org>
To: Yuanjun Gong <ruc_gongyuanjun@163.com>
Cc: Saeed Mahameed <saeedm@nvidia.com>, Boris Pismenny <borisp@nvidia.com>,
	netdev@vger.kernel.org
Subject: Re: [PATCH 1/1] drivers:net: fix return value check in
 mlx5e_ipsec_remove_trailer
Message-ID: <20230717185533.GA8808@unreal>
References: <20230717144640.23166-1-ruc_gongyuanjun@163.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230717144640.23166-1-ruc_gongyuanjun@163.com>

On Mon, Jul 17, 2023 at 10:46:40PM +0800, Yuanjun Gong wrote:
> mlx5e_ipsec_remove_trailer should return an error code if function
> pskb_trim returns an unexpected value.
> 
> Signed-off-by: Yuanjun Gong <ruc_gongyuanjun@163.com>
> ---
>  drivers/net/ethernet/mellanox/mlx5/core/en_accel/ipsec_rxtx.c | 4 +++-
>  1 file changed, 3 insertions(+), 1 deletion(-)

Please add fixes line, change title to be "net/mlx5e: ...." instead of
"drivers:..." and target tree which is "net".

Thanks

> 
> diff --git a/drivers/net/ethernet/mellanox/mlx5/core/en_accel/ipsec_rxtx.c b/drivers/net/ethernet/mellanox/mlx5/core/en_accel/ipsec_rxtx.c
> index eab5bc718771..8d995e304869 100644
> --- a/drivers/net/ethernet/mellanox/mlx5/core/en_accel/ipsec_rxtx.c
> +++ b/drivers/net/ethernet/mellanox/mlx5/core/en_accel/ipsec_rxtx.c
> @@ -58,7 +58,9 @@ static int mlx5e_ipsec_remove_trailer(struct sk_buff *skb, struct xfrm_state *x)
>  
>  	trailer_len = alen + plen + 2;
>  
> -	pskb_trim(skb, skb->len - trailer_len);
> +	ret = pskb_trim(skb, skb->len - trailer_len);
> +	if (unlikely(ret))
> +		return ret;
>  	if (skb->protocol == htons(ETH_P_IP)) {
>  		ipv4hdr->tot_len = htons(ntohs(ipv4hdr->tot_len) - trailer_len);
>  		ip_send_check(ipv4hdr);
> -- 
> 2.17.1
> 

