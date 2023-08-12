Return-Path: <netdev+bounces-27068-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 7C55777A198
	for <lists+netdev@lfdr.de>; Sat, 12 Aug 2023 20:02:04 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 413DF1C208E5
	for <lists+netdev@lfdr.de>; Sat, 12 Aug 2023 18:02:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B97FF8BE5;
	Sat, 12 Aug 2023 18:02:00 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 91C3A20EE
	for <netdev@vger.kernel.org>; Sat, 12 Aug 2023 18:01:59 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B43D0C433C7;
	Sat, 12 Aug 2023 18:01:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1691863319;
	bh=GBhWyVgtciTxu71mVGx1KJ0cf/+uvCxSPNmjTOgpN3A=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=MsJK/IyCS2K4zDNZ6L2/bAbFrd9ZYTSQWFGu52dtnFB5cRhIIbKF8p4wez06vdTpo
	 7bnycU9r2robfULVAJi6iojtEcTTo553Vzp7nyR03Gwix343tZraXZj3/4y3iPdqW0
	 IW0B0/Q/RBR1TelIvSHkCngbZpkXbYGFxz5q1qaU0Cb7BYgKm0Il5FqoPt95NygNgq
	 en6hqon/0STSUxvCNDG2dazg29Ui8AarZygNM82VQSbJfYhEWHhiODQTY95KRFJ33m
	 8WTeQB10GBHoJG/+jA8GK8z3seVH1LtIa25w4T8IjoOztES24f31GtZ9C/aZvqLP4m
	 c3y6CeTYNglJA==
Date: Sat, 12 Aug 2023 20:01:54 +0200
From: Simon Horman <horms@kernel.org>
To: "Radu Pirea (NXP OSS)" <radu-nicolae.pirea@oss.nxp.com>
Cc: andrew@lunn.ch, hkallweit1@gmail.com, linux@armlinux.org.uk,
	davem@davemloft.net, edumazet@google.com, kuba@kernel.org,
	pabeni@redhat.com, richardcochran@gmail.com, sd@queasysnail.net,
	netdev@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [RFC net-next v1 3/5] net: phy: nxp-c45-tja11xx add MACsec
 support
Message-ID: <ZNfJEj0jiTR0ZAbK@vergenet.net>
References: <20230811153249.283984-1-radu-nicolae.pirea@oss.nxp.com>
 <20230811153249.283984-4-radu-nicolae.pirea@oss.nxp.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230811153249.283984-4-radu-nicolae.pirea@oss.nxp.com>

On Fri, Aug 11, 2023 at 06:32:47PM +0300, Radu Pirea (NXP OSS) wrote:
> Add MACsec support.
> 
> Signed-off-by: Radu Pirea (NXP OSS) <radu-nicolae.pirea@oss.nxp.com>

Hi Radu,

thanks for your patch-set.
Some minor feedback from my side.

...

> diff --git a/drivers/net/phy/nxp-c45-tja11xx-macsec.c b/drivers/net/phy/nxp-c45-tja11xx-macsec.c

...

> +static int nxp_c45_tx_sc_set_flt(struct macsec_context *ctx,  int secy_id)
> +{
> +	u32 tx_flt_base = TX_FLT_BASE(secy_id);
> +	const u8 *dev_addr = ctx->secy->netdev->dev_addr;
> +	u32 mac_sa;

nit: Please use reverse xmas tree - longest line to shortest
     ordering for local variable declarations in Networking code.

     https://github.com/ecree-solarflare/xmastree is your friend here.

> +
> +	mac_sa = dev_addr[0] << 8 | dev_addr[1];
> +	nxp_c45_macsec_write(ctx->phydev,
> +			     TX_SC_FLT_MAC_DA_SA(tx_flt_base),
> +			     mac_sa);
> +	mac_sa = dev_addr[5] | dev_addr[4] << 8 |
> +		dev_addr[3] << 16 | dev_addr[2] << 24;
> +
> +	nxp_c45_macsec_write(ctx->phydev,
> +			     TX_SC_FLT_MAC_SA(tx_flt_base),
> +			     mac_sa);
> +	nxp_c45_macsec_write(ctx->phydev,
> +			     TX_SC_FLT_MAC_CFG(tx_flt_base),
> +			     TX_SC_FLT_BY_SA | TX_SC_FLT_EN |
> +			     secy_id);
> +
> +	return 0;
> +}
> +
> +static bool nxp_c45_port_valid(struct nxp_c45_secy *phy_secy, u16 port)
> +{
> +	if (phy_secy->secy->tx_sc.end_station && __be16_to_cpu(port) != 1)

The type of port is host byte order, but it is assumed to be big endian
by passing it to __be16_to_cpu(). Also, it's probably more efficient
to convert the constant (1).

There are a number of other Sparse warnings introduced by this patch.
Please take a look over them (and ideally fix them).

> +		return false;
> +
> +	return true;
> +}

...

> +static int nxp_c45_mdo_upd_secy(struct macsec_context *ctx)
> +{
> +	struct phy_device *phydev = ctx->phydev;
> +	struct nxp_c45_phy *priv = phydev->priv;
> +	struct nxp_c45_tx_sa *new_tx_sa, *old_tx_sa;

nit: reverse xmas tree

...

