Return-Path: <netdev+bounces-138129-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id F37079AC139
	for <lists+netdev@lfdr.de>; Wed, 23 Oct 2024 10:15:09 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 207071C2113C
	for <lists+netdev@lfdr.de>; Wed, 23 Oct 2024 08:15:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EC1D31581F0;
	Wed, 23 Oct 2024 08:14:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="YctDnfDm"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B6D6315746F;
	Wed, 23 Oct 2024 08:14:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729671297; cv=none; b=Ha/Rn5f2Yb33FhfEUMghiRutXMEFLQLdqVdt83eaGmZSGZAkU1+2cMO71pVvBzLDaepL7pZtX0grvNBYpshrbFb/EuZE/bRIHGwBjIr9Ii/4xeOjRfhsgNKIkZap4+YqBV5cVIbZMOGaq5INQKDcDtBmSfsbEVczsBbsgtN7tic=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729671297; c=relaxed/simple;
	bh=PCYN10kLm7y5N3zh5gY4Cdbwis2bzdQoq+BQVvVyqK0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Cpro9dyQhkhoQBQXu2MBDEtwkyBswtwHRCo43yPItzw4W8Ru/Mb2s3MXG+y+Gi0Jc6uEgPy7BmfcTmKz0meMijI9R3lT2emh6NVLcN1+rAH4s1XShhtpyDENkto+kndZ8NUqZgIn8yPqlEASPs7oMC+AUIrZYZHiQY1Wks8DnEU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=YctDnfDm; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A63F5C4CEC6;
	Wed, 23 Oct 2024 08:14:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1729671297;
	bh=PCYN10kLm7y5N3zh5gY4Cdbwis2bzdQoq+BQVvVyqK0=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=YctDnfDmwr3IK2pisJqLuLBy6/gCIerF7wUKqqa1CfH2RjXTxnFqmPHa97AiuVFd3
	 +ddngVuWmLFnZp1uToHCHMBNAWffgj71hZDa9YBrkfFEPbBFdQBV2cmtU+3464Kg1n
	 Upg4n+S8N+j/dGA33zrClI+TpwJ2BkRWNHKOfdYuUyU+9yjTqpySd44d9Jv5tkFTEt
	 CMWg5e6ir7KfkDF1J+yByJQVXs2Im8O+b800ZScK77zjYghIqrKXzNzOvblPVUIVAq
	 oflJ+JpOVdUmdzQU+kN4xLRyPmk6DDB7EeHT1MoRHDHHm7RVXK2xwny0n3MxFCvF6r
	 ZxtgVoE9nqRrg==
Date: Wed, 23 Oct 2024 10:14:54 +0200
From: Krzysztof Kozlowski <krzk@kernel.org>
To: Daniel Machon <daniel.machon@microchip.com>
Cc: "David S. Miller" <davem@davemloft.net>, 
	Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>, 
	Paolo Abeni <pabeni@redhat.com>, andrew@lunn.ch, Lars Povlsen <lars.povlsen@microchip.com>, 
	Steen Hegelund <Steen.Hegelund@microchip.com>, horatiu.vultur@microchip.com, 
	jensemil.schulzostergaard@microchip.com, Parthiban.Veerasooran@microchip.com, 
	Raju.Lakkaraju@microchip.com, UNGLinuxDriver@microchip.com, 
	Richard Cochran <richardcochran@gmail.com>, Rob Herring <robh@kernel.org>, 
	Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley <conor+dt@kernel.org>, jacob.e.keller@intel.com, 
	ast@fiberby.net, maxime.chevallier@bootlin.com, netdev@vger.kernel.org, 
	linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org, devicetree@vger.kernel.org
Subject: Re: [PATCH net-next 14/15] net: sparx5: add compatible strings for
 lan969x and verify the target
Message-ID: <cetor3ohhg6rzf3w2cm6hqxsqukh52nm54mp7tizb2qc3x44j4@n53v6btq6t6r>
References: <20241021-sparx5-lan969x-switch-driver-2-v1-0-c8c49ef21e0f@microchip.com>
 <20241021-sparx5-lan969x-switch-driver-2-v1-14-c8c49ef21e0f@microchip.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20241021-sparx5-lan969x-switch-driver-2-v1-14-c8c49ef21e0f@microchip.com>

On Mon, Oct 21, 2024 at 03:58:51PM +0200, Daniel Machon wrote:
> Add compatible strings for the twelve lan969x SKU's (Stock Keeping Unit)
> that we support, and verify that the devicetree target is supported by
> the chip target.
> 
> Each SKU supports different bandwidths and features (see [1] for
> details). We want to be able to run a SKU with a lower bandwidth and/or
> feature set, than what is supported by the actual chip. In order to
> accomplish this we:
> 
>     - add new field sparx5->target_dt that reflects the target from the
>       devicetree (compatible string).
> 
>     - compare the devicetree target with the actual chip target. If the
>       bandwidth and features provided by the devicetree target is
>       supported by the chip, we approve - otherwise reject.
> 
>     - set the core clock and features based on the devicetree target
> 
> [1] https://www.microchip.com/en-us/product/lan9698
> 
> Reviewed-by: Steen Hegelund <Steen.Hegelund@microchip.com>
> Signed-off-by: Daniel Machon <daniel.machon@microchip.com>
> ---
>  drivers/net/ethernet/microchip/sparx5/Makefile     |   1 +
>  .../net/ethernet/microchip/sparx5/sparx5_main.c    | 194 ++++++++++++++++++++-
>  .../net/ethernet/microchip/sparx5/sparx5_main.h    |   1 +
>  3 files changed, 193 insertions(+), 3 deletions(-)
> 
> diff --git a/drivers/net/ethernet/microchip/sparx5/Makefile b/drivers/net/ethernet/microchip/sparx5/Makefile
> index 3435ca86dd70..8fe302415563 100644
> --- a/drivers/net/ethernet/microchip/sparx5/Makefile
> +++ b/drivers/net/ethernet/microchip/sparx5/Makefile
> @@ -19,3 +19,4 @@ sparx5-switch-$(CONFIG_DEBUG_FS) += sparx5_vcap_debugfs.o
>  # Provide include files
>  ccflags-y += -I$(srctree)/drivers/net/ethernet/microchip/vcap
>  ccflags-y += -I$(srctree)/drivers/net/ethernet/microchip/fdma
> +ccflags-y += -I$(srctree)/drivers/net/ethernet/microchip/lan969x
> diff --git a/drivers/net/ethernet/microchip/sparx5/sparx5_main.c b/drivers/net/ethernet/microchip/sparx5/sparx5_main.c
> index 5c986c373b3e..edbe639d98c5 100644
> --- a/drivers/net/ethernet/microchip/sparx5/sparx5_main.c
> +++ b/drivers/net/ethernet/microchip/sparx5/sparx5_main.c
> @@ -24,6 +24,8 @@
>  #include <linux/types.h>
>  #include <linux/reset.h>
>  
> +#include "lan969x.h" /* lan969x_desc */
> +
>  #include "sparx5_main_regs.h"
>  #include "sparx5_main.h"
>  #include "sparx5_port.h"
> @@ -227,6 +229,168 @@ bool is_sparx5(struct sparx5 *sparx5)
>  	}
>  }
>  
> +/* Set the devicetree target based on the compatible string */
> +static int sparx5_set_target_dt(struct sparx5 *sparx5)
> +{
> +	struct device_node *node = sparx5->pdev->dev.of_node;
> +
> +	if (is_sparx5(sparx5))
> +		/* For Sparx5 the devicetree target is always the chip target */
> +		sparx5->target_dt = sparx5->target_ct;
> +	else if (of_device_is_compatible(node, "microchip,lan9691-switch"))
> +		sparx5->target_dt = SPX5_TARGET_CT_LAN9691VAO;
> +	else if (of_device_is_compatible(node, "microchip,lan9692-switch"))
> +		sparx5->target_dt = SPX5_TARGET_CT_LAN9692VAO;
> +	else if (of_device_is_compatible(node, "microchip,lan9693-switch"))
> +		sparx5->target_dt = SPX5_TARGET_CT_LAN9693VAO;
> +	else if (of_device_is_compatible(node, "microchip,lan9694-switch"))
> +		sparx5->target_dt = SPX5_TARGET_CT_LAN9694;
> +	else if (of_device_is_compatible(node, "microchip,lan9695-switch"))
> +		sparx5->target_dt = SPX5_TARGET_CT_LAN9694TSN;
> +	else if (of_device_is_compatible(node, "microchip,lan9696-switch"))
> +		sparx5->target_dt = SPX5_TARGET_CT_LAN9696;
> +	else if (of_device_is_compatible(node, "microchip,lan9697-switch"))
> +		sparx5->target_dt = SPX5_TARGET_CT_LAN9696TSN;
> +	else if (of_device_is_compatible(node, "microchip,lan9698-switch"))
> +		sparx5->target_dt = SPX5_TARGET_CT_LAN9698;
> +	else if (of_device_is_compatible(node, "microchip,lan9699-switch"))
> +		sparx5->target_dt = SPX5_TARGET_CT_LAN9698TSN;
> +	else if (of_device_is_compatible(node, "microchip,lan969a-switch"))
> +		sparx5->target_dt = SPX5_TARGET_CT_LAN9694RED;
> +	else if (of_device_is_compatible(node, "microchip,lan969b-switch"))
> +		sparx5->target_dt = SPX5_TARGET_CT_LAN9696RED;
> +	else if (of_device_is_compatible(node, "microchip,lan969c-switch"))
> +		sparx5->target_dt = SPX5_TARGET_CT_LAN9698RED;
> +	else
> +		return -EINVAL;
> +
> +	return 0;
> +}
> +
> +/* Compare the devicetree target with the chip target.
> + * Make sure the chip target supports the features and bandwidth requested
> + * from the devicetree target.
> + */
> +static int sparx5_verify_target(struct sparx5 *sparx5)
> +{
> +	switch (sparx5->target_dt) {
> +	case SPX5_TARGET_CT_7546:
> +	case SPX5_TARGET_CT_7549:
> +	case SPX5_TARGET_CT_7552:
> +	case SPX5_TARGET_CT_7556:
> +	case SPX5_TARGET_CT_7558:
> +	case SPX5_TARGET_CT_7546TSN:
> +	case SPX5_TARGET_CT_7549TSN:
> +	case SPX5_TARGET_CT_7552TSN:
> +	case SPX5_TARGET_CT_7556TSN:
> +	case SPX5_TARGET_CT_7558TSN:
> +		return 0;

All this is weird. Why would you verify? You were matched, it cannot be
mis-matching.

> +	case SPX5_TARGET_CT_LAN9698RED:
> +		if (sparx5->target_ct == SPX5_TARGET_CT_LAN9698RED)

What is "ct"? sorry, all this code is a big no.

Best regards,
Krzysztof


