Return-Path: <netdev+bounces-46026-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id AECB87E0F22
	for <lists+netdev@lfdr.de>; Sat,  4 Nov 2023 12:35:31 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id C69621C2096C
	for <lists+netdev@lfdr.de>; Sat,  4 Nov 2023 11:35:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 50C5715ADB;
	Sat,  4 Nov 2023 11:35:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="F81P/3b6"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3238B8C11
	for <netdev@vger.kernel.org>; Sat,  4 Nov 2023 11:35:27 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4FD4FC433C8;
	Sat,  4 Nov 2023 11:35:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1699097727;
	bh=eQe1wFKxq3ZqObZy6vRwp3gsb3y+Y6bu7pHdSAo8SKg=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=F81P/3b6o/poheCB9O8X8dq9m/r4k6OKV33/JSc/hoIHLNId4FeYJIoIR/O/bghTJ
	 wdaguamX+dW5SZynhF9CZ3yH9joJNEXznIAi1ep7EnYx2i++yLG9f1XeDOIecntp3E
	 lqhtLpiJE1US6hx5ejpi1bgxWEdFFvPL/b4T98kpkn1cw2MSlT+a4GEDv0aM8mJ09Z
	 Bn2IT7V4BEYdTjI9mG6aPn5MzrHdVbHgIxW5w4mcG9O8FVnR/PvhUeMCDSdgFj21To
	 z1X9qs/8So1bYiyJ0r4NMKWz7sPNotpu70PvlwrBv49HsTHWQiVc1agxswAUpLO5MC
	 LpjCqZahpUGLg==
Date: Sat, 4 Nov 2023 11:35:06 +0000
From: Simon Horman <horms@kernel.org>
To: "Radu Pirea (NXP OSS)" <radu-nicolae.pirea@oss.nxp.com>
Cc: sd@queasysnail.net, davem@davemloft.net, edumazet@google.com,
	kuba@kernel.org, pabeni@redhat.com, andrew@lunn.ch,
	hkallweit1@gmail.com, linux@armlinux.org.uk,
	richardcochran@gmail.com, linux-kernel@vger.kernel.org,
	netdev@vger.kernel.org, sebastian.tobuschat@oss.nxp.com
Subject: Re: [PATCH net-next v8 5/7] net: phy: nxp-c45-tja11xx: add MACsec
 support
Message-ID: <20231104113506.GA891380@kernel.org>
References: <20231023094327.565297-1-radu-nicolae.pirea@oss.nxp.com>
 <20231023094327.565297-6-radu-nicolae.pirea@oss.nxp.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20231023094327.565297-6-radu-nicolae.pirea@oss.nxp.com>

On Mon, Oct 23, 2023 at 12:43:25PM +0300, Radu Pirea (NXP OSS) wrote:
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

> +void nxp_c45_handle_macsec_interrupt(struct phy_device *phydev,
> +				     irqreturn_t *ret)
> +{
> +	struct nxp_c45_phy *priv = phydev->priv;
> +	struct nxp_c45_secy *pos, *tmp;
> +	struct nxp_c45_sa *sa;
> +	u8 encoding_sa;
> +	int secy_id;
> +	u32 reg = 0;
> +
> +	if (!priv->macsec)
> +		return;
> +
> +	do {
> +		nxp_c45_macsec_read(phydev, MACSEC_EVR, &reg);
> +		if (!reg)
> +			return;
> +
> +		secy_id = MACSEC_REG_SIZE - ffs(reg);
> +		list_for_each_entry_safe(pos, tmp, &priv->macsec->secy_list,
> +					 list)
> +			if (pos->secy_id == secy_id)
> +				break;
> +
> +		encoding_sa = pos->secy->tx_sc.encoding_sa;

Hi Radu,

I'm unsure if this can happen, but my understanding is that if
priv->macsec->secy_list is empty then pos will be uninitialised here.

Flagged by Coccinelle.

> +		phydev_dbg(phydev, "pn_wrapped: TX SC %d, encoding_sa %u\n",
> +			   pos->secy_id, encoding_sa);
> +
> +		sa = nxp_c45_find_sa(&pos->sa_list, TX_SA, encoding_sa);
> +		if (!IS_ERR(sa))
> +			macsec_pn_wrapped(pos->secy, sa->sa);
> +		else
> +			WARN_ON(1);
> +
> +		nxp_c45_macsec_write(phydev, MACSEC_EVR,
> +				     TX_SC_BIT(pos->secy_id));
> +		*ret = IRQ_HANDLED;
> +	} while (reg);
> +}

...

