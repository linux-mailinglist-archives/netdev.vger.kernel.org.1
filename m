Return-Path: <netdev+bounces-99528-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id EFB4C8D5217
	for <lists+netdev@lfdr.de>; Thu, 30 May 2024 21:08:41 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 1F1DC1C21720
	for <lists+netdev@lfdr.de>; Thu, 30 May 2024 19:08:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F1D9D6CDB7;
	Thu, 30 May 2024 19:08:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ALaMbQNl"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CBC156BB2F;
	Thu, 30 May 2024 19:08:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717096111; cv=none; b=QXTYZF0ORaSvkKPdl+/DfP8Yqi7HLGGoV5AUoGBqQoDn/wh5hS484WDvusHsefzkod5F+VURqhioX/YeSnXtHJ+/enrFcsvWWFw3trnQvZ5iI+G3TzecHpxg3c5oRQ2YSb2hLOZEppUgtfQ934VRYwM2MqPeGzUIlhVGEPbMa3Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717096111; c=relaxed/simple;
	bh=Qpg5Q2EhMyKmWZjKSiIdY491rX47ZL7A3DH8EIJ+Vgg=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=UXdGlfCXbaS6KpSzvLzDBwLfr6RE+Q4OpTkVA31aYue0GroGyF7xl4RkhuWTJQ//mHaDp0KomWiXmgEd29AK951hXBU+klm6ol42hKDma8ThrdHsTWDNl6hnTJOUnsV1PFHCHu4BE+vM0AYsQddoPyRKxARw7YuJfHP5rzOz7gM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ALaMbQNl; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C3D9CC32781;
	Thu, 30 May 2024 19:08:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1717096110;
	bh=Qpg5Q2EhMyKmWZjKSiIdY491rX47ZL7A3DH8EIJ+Vgg=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=ALaMbQNlXrEJh4FlyXErAkh9Gxl0i9dwynxLvpXs2XejNxgjEH7cdj0oDTbunCGW4
	 pWKk0Rt+wuazccMq6I1v5pCoib0jpYv4WuPbe0kTxlBcKnsY8QWQl74cfalyNqaH1v
	 lygm5r7ectDDa20bewUtcjdlOzUPBRCrS+roU6XN7YMvn3q8G5/NQ/oCvw1rL3wQQ4
	 sXAzsIVz+T9QvDdGntcDwXObimFnIh0fyr7341XKEXhiETR2hECJfnpiMxi1a/JANO
	 wxSG9iRQ8xeTr6WNaOEYug+ZtffCrtl5n7oEjCEWJSBZCTdFDrAr8oIklt8IlaLzYJ
	 JxfJeH9S8Y4Pw==
Date: Thu, 30 May 2024 20:08:25 +0100
From: Simon Horman <horms@kernel.org>
To: MD Danish Anwar <danishanwar@ti.com>
Cc: Dan Carpenter <dan.carpenter@linaro.org>,
	Diogo Ivo <diogo.ivo@siemens.com>,
	Jan Kiszka <jan.kiszka@siemens.com>, Andrew Lunn <andrew@lunn.ch>,
	Paolo Abeni <pabeni@redhat.com>, Jakub Kicinski <kuba@kernel.org>,
	Eric Dumazet <edumazet@google.com>,
	"David S. Miller" <davem@davemloft.net>,
	linux-kernel@vger.kernel.org, netdev@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org, srk@ti.com,
	Vignesh Raghavendra <vigneshr@ti.com>, r-gunasekaran@ti.com,
	Roger Quadros <rogerq@kernel.org>
Subject: Re: [RFC PATCH net-next 2/2] net: ti: icssg-prueth: Add multicast
 filtering support
Message-ID: <20240530190825.GC123401@kernel.org>
References: <20240516091752.2969092-1-danishanwar@ti.com>
 <20240516091752.2969092-3-danishanwar@ti.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240516091752.2969092-3-danishanwar@ti.com>

On Thu, May 16, 2024 at 02:47:52PM +0530, MD Danish Anwar wrote:
> Add multicast filtering support for ICSSG Driver.
> 
> Signed-off-by: MD Danish Anwar <danishanwar@ti.com>
> ---
>  drivers/net/ethernet/ti/icssg/icssg_config.c | 16 +++++--
>  drivers/net/ethernet/ti/icssg/icssg_prueth.c | 50 ++++++++++++++++++--
>  drivers/net/ethernet/ti/icssg/icssg_prueth.h |  3 ++
>  3 files changed, 62 insertions(+), 7 deletions(-)
> 
> diff --git a/drivers/net/ethernet/ti/icssg/icssg_config.c b/drivers/net/ethernet/ti/icssg/icssg_config.c
> index 2213374d4d45..4e30bb995078 100644
> --- a/drivers/net/ethernet/ti/icssg/icssg_config.c
> +++ b/drivers/net/ethernet/ti/icssg/icssg_config.c
> @@ -318,17 +318,27 @@ static int prueth_emac_buffer_setup(struct prueth_emac *emac)
>  
>  static void icssg_init_emac_mode(struct prueth *prueth)
>  {
> +	u32 addr = prueth->shram.pa + VLAN_STATIC_REG_TABLE_OFFSET;
>  	/* When the device is configured as a bridge and it is being brought
>  	 * back to the emac mode, the host mac address has to be set as 0.
>  	 */
>  	u8 mac[ETH_ALEN] = { 0 };
> +	int i;
>  
>  	if (prueth->emacs_initialized)
>  		return;
>  
> -	regmap_update_bits(prueth->miig_rt, FDB_GEN_CFG1,
> -			   SMEM_VLAN_OFFSET_MASK, 0);
> -	regmap_write(prueth->miig_rt, FDB_GEN_CFG2, 0);
> +	/* Set VLAN TABLE address base */
> +	regmap_update_bits(prueth->miig_rt, FDB_GEN_CFG1, SMEM_VLAN_OFFSET_MASK,
> +			   addr <<  SMEM_VLAN_OFFSET);
> +	/* Configure CFG2 register */
> +	regmap_write(prueth->miig_rt, FDB_GEN_CFG2, (FDB_PRU0_EN | FDB_PRU1_EN | FDB_HOST_EN));
> +
> +	prueth->vlan_tbl = prueth->shram.va + VLAN_STATIC_REG_TABLE_OFFSET;
> +	for (i = 0; i < SZ_4K - 1; i++) {
> +		prueth->vlan_tbl[i].fid = i;
> +		prueth->vlan_tbl[i].fid_c1 = 0;
> +	}

Hi MD,

This isnot a full review, but I did notice one thing.

According to Sparse, prueth->shram.va is __iomem.
I don't think it is portable to directly access __iomem like this.
Rather, I suspect that either ioremap(), or writel() or similar should be used.

>  	/* Clear host MAC address */
>  	icssg_class_set_host_mac_addr(prueth->miig_rt, mac);
>  }

...

