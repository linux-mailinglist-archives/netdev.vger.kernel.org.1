Return-Path: <netdev+bounces-30895-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 3E2AD789C04
	for <lists+netdev@lfdr.de>; Sun, 27 Aug 2023 10:03:28 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id C4375281021
	for <lists+netdev@lfdr.de>; Sun, 27 Aug 2023 08:03:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6FABFECE;
	Sun, 27 Aug 2023 08:03:24 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F4010EBC
	for <netdev@vger.kernel.org>; Sun, 27 Aug 2023 08:03:22 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7B223C433C7;
	Sun, 27 Aug 2023 08:03:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1693123402;
	bh=6ROsNKyZUhL4Bd6PfZNL3uGG5Z56tuz4TeApV51H+HI=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=btSosVZTBWwh5P8KqOLifVDjFsVsj67ROlFM3hhVziLw/pFXqKbb2BGJgQPrJxBfG
	 /rDt6JnMYpNmhQqkGoLM9rqAGKeKa3muyOUi3o/LmmYL0mgRtxmGeka2kxNS9UAZpJ
	 XCdZVizb0DRUL19vZVJFebUYla4+kfYkS19q22ij9TbJOOBsr0b+vaLLdL/t0klLPD
	 Z1+Ktyc989waz8bHJzJHyH7Hg6Rz1ZDb66Eo+RlQVx432jagBx7SwU4SZznDfKntsA
	 3ECXI9ftUwWHY4j9QrAsQCd7sRYrQj5/FYmY11tXaklbU9bDt4weaCCLjP0lSnk6yL
	 2cT0kP2aLbrZw==
Date: Sun, 27 Aug 2023 10:03:14 +0200
From: Simon Horman <horms@kernel.org>
To: "Radu Pirea (NXP OSS)" <radu-nicolae.pirea@oss.nxp.com>
Cc: andrew@lunn.ch, hkallweit1@gmail.com, linux@armlinux.org.uk,
	davem@davemloft.net, edumazet@google.com, kuba@kernel.org,
	pabeni@redhat.com, richardcochran@gmail.com, sd@queasysnail.net,
	sebastian.tobuschat@nxp.com, netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [RFC net-next v2 3/5] net: phy: nxp-c45-tja11xx add MACsec
 support
Message-ID: <20230827080314.GQ3523530@kernel.org>
References: <20230824091615.191379-1-radu-nicolae.pirea@oss.nxp.com>
 <20230824091615.191379-4-radu-nicolae.pirea@oss.nxp.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230824091615.191379-4-radu-nicolae.pirea@oss.nxp.com>

On Thu, Aug 24, 2023 at 12:16:13PM +0300, Radu Pirea (NXP OSS) wrote:
> Add MACsec support.
> The MACsec block has four TX SCs and four RX SCs. The driver supports up
> to four SecY. Each SecY with one TX SC and one RX SC.
> The RX SCs can have two keys, key A and key B, written in hardware and
> enabled at the same time.
> The TX SCs can have two keys written in hardware, but only one can be
> active at a given time.
> On TX, the SC is selected using the MAC source address. Due of this
> selection mechanism, each offloaded netdev must have a unique MAC
> address.
> On RX, the SC is selected by SCI(found in SecTAG or calculated using MAC
> SA), or using RX SC 0 as implicit.
> 
> Signed-off-by: Radu Pirea (NXP OSS) <radu-nicolae.pirea@oss.nxp.com>

...

> diff --git a/drivers/net/phy/Makefile b/drivers/net/phy/Makefile
> index c945ed9bd14b..ee53e2fdb968 100644
> --- a/drivers/net/phy/Makefile
> +++ b/drivers/net/phy/Makefile
> @@ -83,6 +83,10 @@ obj-$(CONFIG_MICROSEMI_PHY)	+= mscc/
>  obj-$(CONFIG_MOTORCOMM_PHY)	+= motorcomm.o
>  obj-$(CONFIG_NATIONAL_PHY)	+= national.o
>  obj-$(CONFIG_NCN26000_PHY)	+= ncn26000.o
> +nxp-c45-tja11xx-objs		+= nxp-c45-tja11xx.o

Hi Radu,

The coincidence of "nxp-c45-tja11x" on both sides of the "+=" operator
seems to cause a build failure (for x86_64 allmodconfig with gcc-13).

Circular drivers/net/phy/nxp-c45-tja11xx.o <- drivers/net/phy/nxp-c45-tja11xx.o dependency dropped.

> +ifdef CONFIG_MACSEC
> +nxp-c45-tja11xx-objs		+= nxp-c45-tja11xx-macsec.o
> +endif

>  obj-$(CONFIG_NXP_C45_TJA11XX_PHY)	+= nxp-c45-tja11xx.o
>  obj-$(CONFIG_NXP_CBTX_PHY)	+= nxp-cbtx.o
>  obj-$(CONFIG_NXP_TJA11XX_PHY)	+= nxp-tja11xx.o

...

