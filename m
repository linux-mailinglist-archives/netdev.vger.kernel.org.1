Return-Path: <netdev+bounces-164742-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E0953A2EEC0
	for <lists+netdev@lfdr.de>; Mon, 10 Feb 2025 14:49:53 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 4BF3C7A128E
	for <lists+netdev@lfdr.de>; Mon, 10 Feb 2025 13:48:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BCEC7221DA9;
	Mon, 10 Feb 2025 13:49:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b="LeVKiW6Y"
X-Original-To: netdev@vger.kernel.org
Received: from vps0.lunn.ch (vps0.lunn.ch [156.67.10.101])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1339222E410
	for <netdev@vger.kernel.org>; Mon, 10 Feb 2025 13:49:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=156.67.10.101
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739195387; cv=none; b=uAuAAMhD2E1fnrXSG6tpwMVFppnS1GypsoGE7t749WiBENfIOSDTuSWLrPmElBmGjnAKqbz7Ut3uLNh1SIZpzrJgS4TkkM4bfA+DlW+AdpKFwo8qe5PnvQHxcEW7rLtxWuD+JhDSPkO5Nyx1K0kbQD9SzpxlqBXTzMfpRtkOKMQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739195387; c=relaxed/simple;
	bh=A/NyHZyAF0nMwNbgLVy64b2xXt7yvj+JPw9b9S59g1k=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Ge7TrRBZ4pdDRuR5TkRG3r7VaodCym9y4/XUy05INhHnx5svNGcjAwkDBHl87g4RHn9hTEDhNkMx6ZBHEHdajPUhkXvLGSzPTdW+JnGH6PVytzqzKuW5QN5RzIfxKTRn3dGYfDIMsqsd48cZpVz2o1Dz8G3I+fBY78gcTLNvrWE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch; spf=pass smtp.mailfrom=lunn.ch; dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b=LeVKiW6Y; arc=none smtp.client-ip=156.67.10.101
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lunn.ch
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=lunn.ch;
	s=20171124; h=In-Reply-To:Content-Disposition:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:From:Sender:Reply-To:Subject:
	Date:Message-ID:To:Cc:MIME-Version:Content-Type:Content-Transfer-Encoding:
	Content-ID:Content-Description:Content-Disposition:In-Reply-To:References;
	bh=VABgsncBHj3rxSQDwmUyLL1Hr5UZmX/R+inZQJo5RL0=; b=LeVKiW6YsD1TuJE8ccj/KX648w
	0JCB5t2134aw8vwhUQY6/LGbTiauKDp3DfGuN6UwqHbF2wcdVyZx+tmx2QGbKumBp7KrZcAXwZgMv
	0Mldc/kFc8KizKO35m4qktfp82jvNPSdhCNlL5GA3jnTLT9bJHPLtCG1V3DhLKAnkodY=;
Received: from andrew by vps0.lunn.ch with local (Exim 4.94.2)
	(envelope-from <andrew@lunn.ch>)
	id 1thUAQ-00Cj6T-DZ; Mon, 10 Feb 2025 14:49:42 +0100
Date: Mon, 10 Feb 2025 14:49:42 +0100
From: Andrew Lunn <andrew@lunn.ch>
To: Raju Rangoju <Raju.Rangoju@amd.com>
Cc: netdev@vger.kernel.org, kuba@kernel.org, pabeni@redhat.com,
	edumazet@google.com, davem@davemloft.net, andrew+netdev@lunn.ch,
	Shyam Sundar S K <Shyam-sundar.S-k@amd.com>
Subject: Re: [PATCH net-next] amd-xgbe: re-initiate auto-negotiation for
 Broadcom PHYs
Message-ID: <cd0413bb-105e-4c84-93f5-c1a5af5b4158@lunn.ch>
References: <20250210120933.1981517-1-Raju.Rangoju@amd.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250210120933.1981517-1-Raju.Rangoju@amd.com>

On Mon, Feb 10, 2025 at 05:39:33PM +0530, Raju Rangoju wrote:
> Some PHYs on certain platforms may show a successful link after setting
> the speed to 100Mbps through auto-negotiation (AN) even when
> 10M/100M/1G concurrent speed is configured. However, they may not be
> able to transmit or receive data. These PHYs need an "additional
> auto-negotiation (AN) cycle" after the speed change, to function correctly.
> 
> A quirk for these PHYs is that if the outcome of the AN leads to a
> change in speed, the AN should be re-initiated at the new speed.

Are you sure it is the PHY which is broken, not the MAC? Is there an
errata from Broadcom?

> +static bool xgbe_phy_broadcom_phy_quirks(struct xgbe_prv_data *pdata)
> +{
> +	struct xgbe_phy_data *phy_data = pdata->phy_data;
> +	unsigned int phy_id = phy_data->phydev->phy_id;
> +	unsigned int ver;
> +
> +	ver = XGMAC_GET_BITS(pdata->hw_feat.version, MAC_VR, SNPSVER);
> +
> +	/* For Broadcom PHY, use the extra AN flag */
> +	if (ver == SNPS_MAC_VER_0x21 && (phy_id & 0xffffffff) == 0x600d8595) {

Please add this ID to include/linux/brcmphy.h.

Also, is it specifically revision 5 of this PHY which is broken?

	Andrew

