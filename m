Return-Path: <netdev+bounces-27069-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 6080C77A1A2
	for <lists+netdev@lfdr.de>; Sat, 12 Aug 2023 20:08:02 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 51F1C1C208F7
	for <lists+netdev@lfdr.de>; Sat, 12 Aug 2023 18:08:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C02CC8BED;
	Sat, 12 Aug 2023 18:07:58 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6B4908839
	for <netdev@vger.kernel.org>; Sat, 12 Aug 2023 18:07:57 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id CCE47C433C8;
	Sat, 12 Aug 2023 18:07:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1691863677;
	bh=k8+Etv3lthP2zsFFRvqPmbDklJ8wGU5W44zD9LwYLvg=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=altZPXoc3wrnKWR2ZISCGj/6yaDR6vwwQanznoUvrOgul8PRSQGaDACmHGfCQ2QPA
	 hiPey5DLPSx6tl4BPSlB3U9nW6zI5yOpimu1EE78H8HgezRFAZggAb2jhHn4AZPZ4r
	 TbN21nuNuy3rIZk+iq9COUshy6vwwLLpfMU1r0I9GKuwnHL0aGtFJHwG/hTwnMaB+S
	 cY13PVW9IAVviT6NO0YmJzOZaPefgM/cgswKSphKY2JgQeCSlrZGLx4sXfh4HOoUP/
	 dyvHBB4Jt1UdMpScW5CUYLrBZ9Cx0EmaPIMF9tpPhAea+Rau8h4AkBPjW1PfLlNRoP
	 Wgk3jUGGP898Q==
Date: Sat, 12 Aug 2023 20:07:52 +0200
From: Simon Horman <horms@kernel.org>
To: "Radu Pirea (NXP OSS)" <radu-nicolae.pirea@oss.nxp.com>
Cc: andrew@lunn.ch, hkallweit1@gmail.com, linux@armlinux.org.uk,
	davem@davemloft.net, edumazet@google.com, kuba@kernel.org,
	pabeni@redhat.com, richardcochran@gmail.com, sd@queasysnail.net,
	netdev@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [RFC net-next v1 4/5] net: macsec: introduce mdo_insert_tx_tag
Message-ID: <ZNfKeCGf0xZTTum7@vergenet.net>
References: <20230811153249.283984-1-radu-nicolae.pirea@oss.nxp.com>
 <20230811153249.283984-5-radu-nicolae.pirea@oss.nxp.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230811153249.283984-5-radu-nicolae.pirea@oss.nxp.com>

On Fri, Aug 11, 2023 at 06:32:48PM +0300, Radu Pirea (NXP OSS) wrote:
> Offloading MACsec in PHYs requires inserting the SecTAG and the ICV in
> the ethernet frame. This operation will increase the frame size with 32
> bytes. If the frames are sent at line rate, the PHY will not have enough
> room to insert the SecTAG and the ICV.
> 
> To mitigate this scenario, the PHY offer to use require a specific
> ethertype with some padding bytes present in the ethernet frame. This
> ethertype and its associated bytes will be replaced by the SecTAG and ICV.
> 
> Signed-off-by: Radu Pirea (NXP OSS) <radu-nicolae.pirea@oss.nxp.com>

...

> diff --git a/drivers/net/macsec.c b/drivers/net/macsec.c

...

> @@ -4137,6 +4211,11 @@ static int macsec_newlink(struct net *net, struct net_device *dev,
>  			if (err)
>  				goto del_dev;
>  		}
> +
> +		dev->needed_headroom -= MACSEC_NEEDED_HEADROOM;
> +		dev->needed_headroom += ops->needed_headroom;
> +		dev->needed_tailroom -= MACSEC_NEEDED_TAILROOM;
> +		dev->needed_tailroom += ops->needed_tailroom;

Hi Radu,

Just above the beginning of this hunk it is assumed that ops may be NULL.
However, here it is dereferenced unconditionally. Is this safe?

Flagged by Smatch.

>  	}
>  
>  	err = register_macsec_dev(real_dev, dev);
> diff --git a/include/net/macsec.h b/include/net/macsec.h
> index 33dc7f2aa42e..a988249d9608 100644
> --- a/include/net/macsec.h
> +++ b/include/net/macsec.h
> @@ -272,6 +272,7 @@ struct macsec_context {
>  		struct macsec_rx_sa_stats *rx_sa_stats;
>  		struct macsec_dev_stats  *dev_stats;
>  	} stats;
> +	struct sk_buff *skb;

Not strictly related to this patch,
but it would be nice to update the kernel doc for this
structure so that it's fields are documented.

>  };
>  
>  /**
> @@ -302,6 +303,10 @@ struct macsec_ops {
>  	int (*mdo_get_tx_sa_stats)(struct macsec_context *ctx);
>  	int (*mdo_get_rx_sc_stats)(struct macsec_context *ctx);
>  	int (*mdo_get_rx_sa_stats)(struct macsec_context *ctx);
> +	/* Offload tag */
> +	int (*mdo_insert_tx_tag)(struct macsec_context *ctx);
> +	int needed_headroom;
> +	int needed_tailroom;

Ditto.

>  };
>  
>  #if IS_ENABLED(CONFIG_MACSEC)
> -- 
> 2.34.1
> 
> 

