Return-Path: <netdev+bounces-118875-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 5E6C195366B
	for <lists+netdev@lfdr.de>; Thu, 15 Aug 2024 16:59:09 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 09D6A285321
	for <lists+netdev@lfdr.de>; Thu, 15 Aug 2024 14:59:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1FF311ABED3;
	Thu, 15 Aug 2024 14:58:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="P4hMKKtq"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EF1771ABEC7;
	Thu, 15 Aug 2024 14:58:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723733918; cv=none; b=PIu4P8ErhxkL6I6efOcFNrJ8wHugkv2dVZCKAA8H4yL5DKekR73BAuXni0ql07017/pgGV2htingSqaLl3ieSjhzL6sivUFB+BD4mhi0SMc5WqvBJ14L6ILZh2cdpvw8x0+DvvdgDQcKOqRsAQYHbiN7u5BCXYXdmgXxNTd0ti0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723733918; c=relaxed/simple;
	bh=zct74IZ/bRfrRYww4OS483OWKGYhQysxlcXnalLdh08=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=YK5aS/6/4CqK6FGn1OA74wWwj2qJYAkQ5oiUdhx+2LO6xzuWjepSTrdHmkO19eVbnVCpRufobI0Pd53gEqC7+YmG+9DX3LdB22bU7v1HAH0WJVxSwTCkyXes1V3ZJ+QNfslRuknm+mUTEYsbTeNnKryxoS2c4+0O/eq7cz9kyxk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=P4hMKKtq; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E5FFFC32786;
	Thu, 15 Aug 2024 14:58:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1723733917;
	bh=zct74IZ/bRfrRYww4OS483OWKGYhQysxlcXnalLdh08=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=P4hMKKtqUdU6IygTaoWO/OQiSF+VvvCgV+lYuCLORHOHp4XOfeYBiPuDTkFv8+7ui
	 wxbdKFvvjtKHcznCIVpzEASsxjIUyH/PI/tWYyh6n1JrmXUSCNX+EHXE4c1M1B7Jyf
	 yfUvP67oryx2XvkZsUHi70e73MtkVkyMeoGhJhQ1e4dGaWHkf5kNsfraTERC13QTVB
	 spYOBoX/A5shE0ika8w0hgAb+77BVYscRps6utB/7B+9/q5ymQzi7JP+qtYCvsN5+Y
	 YsXsLBZtlrY7nDvqhulajR3Dmg3uzxIYzK9owY8qjfFo0wGSl7TqEG5PRa3kMN4P3C
	 KdYg37kryE8iw==
Date: Thu, 15 Aug 2024 15:58:32 +0100
From: Simon Horman <horms@kernel.org>
To: Sean Anderson <sean.anderson@linux.dev>
Cc: Radhey Shyam Pandey <radhey.shyam.pandey@amd.com>,
	netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
	Andrew Lunn <andrew@lunn.ch>, Michal Simek <michal.simek@amd.com>,
	Daniel Borkmann <daniel@iogearbox.net>,
	Paolo Abeni <pabeni@redhat.com>,
	"David S . Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	linux-arm-kernel@lists.infradead.org,
	Jakub Kicinski <kuba@kernel.org>,
	Ariane Keller <ariane.keller@tik.ee.ethz.ch>
Subject: Re: [PATCH net-next 1/4] net: xilinx: axienet: Always disable
 promiscuous mode
Message-ID: <20240815145832.GG632411@kernel.org>
References: <20240812200437.3581990-1-sean.anderson@linux.dev>
 <20240812200437.3581990-2-sean.anderson@linux.dev>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240812200437.3581990-2-sean.anderson@linux.dev>

On Mon, Aug 12, 2024 at 04:04:34PM -0400, Sean Anderson wrote:
> If prmiscuous mode is disabled when there are fewer than four multicast
> addresses, then it will to be reflected in the hardware. Fix this by
> always clearing the promiscuous mode flag even when we program multicast
> addresses.
> 
> Fixes: 8a3b7a252dca ("drivers/net/ethernet/xilinx: added Xilinx AXI Ethernet driver")
> Signed-off-by: Sean Anderson <sean.anderson@linux.dev>
> ---
> 
>  drivers/net/ethernet/xilinx/xilinx_axienet_main.c | 4 ++++
>  1 file changed, 4 insertions(+)
> 
> diff --git a/drivers/net/ethernet/xilinx/xilinx_axienet_main.c b/drivers/net/ethernet/xilinx/xilinx_axienet_main.c
> index ca04c298daa2..e664611c29cf 100644
> --- a/drivers/net/ethernet/xilinx/xilinx_axienet_main.c
> +++ b/drivers/net/ethernet/xilinx/xilinx_axienet_main.c
> @@ -451,6 +451,10 @@ static void axienet_set_multicast_list(struct net_device *ndev)
>  	} else if (!netdev_mc_empty(ndev)) {
>  		struct netdev_hw_addr *ha;
>  
> +		reg = axienet_ior(lp, XAE_FMI_OFFSET);
> +		reg &= ~XAE_FMI_PM_MASK;
> +		axienet_iow(lp, XAE_FMI_OFFSET, reg);
> +

Hi Sean,

I notice that this replicates code in another part of this function.
And that is then factored out into common code as part of the last
patch of this series.

I guess that it is in the wash, but perhaps it would
be nicer to factor out the common promisc mode setting code
as part of this patch.

Otherwise, this LGTM.

>  		i = 0;
>  		netdev_for_each_mc_addr(ha, ndev) {
>  			if (i >= XAE_MULTICAST_CAM_TABLE_NUM)
> -- 
> 2.35.1.1320.gc452695387.dirty
> 
> 

