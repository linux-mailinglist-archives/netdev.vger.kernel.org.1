Return-Path: <netdev+bounces-28341-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 123A577F16D
	for <lists+netdev@lfdr.de>; Thu, 17 Aug 2023 09:45:58 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id B8513281DDF
	for <lists+netdev@lfdr.de>; Thu, 17 Aug 2023 07:45:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AA901D51E;
	Thu, 17 Aug 2023 07:45:54 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 70F82CA58
	for <netdev@vger.kernel.org>; Thu, 17 Aug 2023 07:45:53 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0CD9DC433C8;
	Thu, 17 Aug 2023 07:45:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1692258352;
	bh=onKG4UaSIXvx73FVELXuTURmfyjPZd62E2Ggu8RV0UY=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=UBSyYwRq4ukM+F0TADNzRB2xmIXTJcxJ0yaWvaf8nHHyv0HwA4WqV406TOksPFasq
	 Pd0ZU1Q17HqL4fKlQb7bTcigZNc0/ETKGYy+XZdSQDvOCvBcbUDKijk/6GTZ3W2YnZ
	 pnDR+tgWaUw1GfmhJIm6GR4PI35UPBWktbp3sRWx0h+dfBjebD/9cWISc9+VLe3Mda
	 f//r5igfPaFWTfLj5pI9MJzGe6Byb1M0hl00nO5q9TYD6Vn+8YDpm+QdbbBm6ZBh87
	 hJovxgM7gqMvD6YRICJvi0UOTmqoXffJF1Csfs/rTDfm+rN3yQ+Amou0x2gcEboU5w
	 nc7PbHoWQHSUA==
Date: Thu, 17 Aug 2023 09:45:47 +0200
From: Simon Horman <horms@kernel.org>
To: nick.hawkins@hpe.com
Cc: christophe.jaillet@wanadoo.fr, simon.horman@corigine.com,
	andrew@lunn.ch, verdun@hpe.com, davem@davemloft.net,
	edumazet@google.com, kuba@kernel.org, pabeni@redhat.com,
	robh+dt@kernel.org, krzysztof.kozlowski+dt@linaro.org,
	conor+dt@kernel.org, netdev@vger.kernel.org,
	devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v3 4/5] net: hpe: Add GXP UMAC Driver
Message-ID: <ZN3QKyHoUNoN9dx5@vergenet.net>
References: <20230816215220.114118-1-nick.hawkins@hpe.com>
 <20230816215220.114118-5-nick.hawkins@hpe.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230816215220.114118-5-nick.hawkins@hpe.com>

On Wed, Aug 16, 2023 at 04:52:19PM -0500, nick.hawkins@hpe.com wrote:
> From: Nick Hawkins <nick.hawkins@hpe.com>
> 
> The GXP contains two Ethernet MACs that can be connected externally
> to several physical devices. From an external interface perspective
> the BMC provides two SERDES interface connections capable of either
> SGMII or 1000Base-X operation. The BMC also provides a RMII interface
> for sideband connections to external Ethernet controllers.
> 
> The primary MAC (umac0) can be mapped to either SGMII/1000-BaseX
> SERDES interface.  The secondary MAC (umac1) can be mapped to only
> the second SGMII/1000-Base X Serdes interface or it can be mapped for
> RMII sideband.
> 
> Signed-off-by: Nick Hawkins <nick.hawkins@hpe.com>

...

> diff --git a/drivers/net/ethernet/hpe/gxp-umac.c b/drivers/net/ethernet/hpe/gxp-umac.c

...

> +static int umac_init_mac_address(struct net_device *ndev)
> +{
> +	struct umac_priv *umac = netdev_priv(ndev);
> +	struct platform_device *pdev = umac->pdev;
> +	char addr[ETH_ALEN];
> +	int err;
> +
> +	err = of_get_mac_address(pdev->dev.of_node, addr);
> +	if (err)
> +		netdev_err(ndev, "Failed to get address from device-tree: %d\n",
> +			   err);
> +		return -EINVAL;

Hi Nick,

it looks like there should be some {} involved in the condition above,
else the function will return -EINVAL unconditionally.

Flagged by W=1 builds with clang-16 and gcc-13.

> +
> +	if (is_valid_ether_addr(addr)) {
> +		dev_addr_set(ndev, addr);
> +		netdev_dbg(ndev,
> +			   "Read MAC address %pM from DTB\n", ndev->dev_addr);
> +	} else {
> +		netdev_err(ndev, "Mac Address is Invalid");
> +		return -EINVAL;
> +	}
> +
> +	dev_addr_set(ndev, addr);
> +	umac_set_mac_address(ndev, addr);
> +
> +	return 0;
> +}

...

