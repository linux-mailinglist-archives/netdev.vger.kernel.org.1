Return-Path: <netdev+bounces-237344-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 64DABC49310
	for <lists+netdev@lfdr.de>; Mon, 10 Nov 2025 21:09:27 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id C809C1890504
	for <lists+netdev@lfdr.de>; Mon, 10 Nov 2025 20:09:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4337433F8B4;
	Mon, 10 Nov 2025 20:09:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="QcpUyVdm"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 12B2533F8A6;
	Mon, 10 Nov 2025 20:09:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762805358; cv=none; b=XBOFPDMF8Jo4sSgjh0BBahNYdjraf3UJUpLCwjB/P5IdOzrCYCQDj9N5LXNvV/JEWuhtVuWIfvchja+e2C/hZpVzueZf50+NMDz52SZrpX4MS1gC0iBdp67oQjf738oyz5xNrDatlMcu4GUHQikMtBzg2hq1rpAhXl/453pvutw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762805358; c=relaxed/simple;
	bh=0iOhbGLxfSoLRBYgw+mP+RQa87LiNVPt6z/z3LThk5Y=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=u/KO+aqcWae+8d3sflX7rxMV+sBE/nrpnT5e5VWLtCHVIKJJSZ3p8mLKjJOceuRCinyQpdBcPST2XABYwCsxShQ2aX4dkoWBgogL+WvlW8sXqtTgmASKOsL/6wq/26jqQMhjORHDoNIPxEaeDbaLx6qCURtZRYHZ8o/vqoF42R0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=QcpUyVdm; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 50174C4CEF5;
	Mon, 10 Nov 2025 20:09:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1762805357;
	bh=0iOhbGLxfSoLRBYgw+mP+RQa87LiNVPt6z/z3LThk5Y=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=QcpUyVdmcLgbVnPvtvG5sn+9VBwKYizaBkOPJ4X74CZDnGzJtx7BAJ+tIxFT21Fc3
	 kuqmvrJf3ya8gDyeZhjrs97LF4iKzBJX+0qjLU2uDBpRj33RsHW7WQe0f1a6wMULsK
	 MHACPV9+uXAHvFPFb8X1myONhP1kPiEGf/spaX/s4HySFB9r8akxvZuqLJRMmHyzOj
	 WQUq3suhO1/hWXwR5IdxvwzYWwP5s0d0pAsX0p+V74Gc+MZCCi+JLZEkAY6sRJwvNO
	 mRp3nvkU4CihCyV3xqso5fKJMu09coOWxk01X2N2w3NYFxPA5T4LgFDolk3DbjgZ0F
	 1MBO1cOUQqWug==
Date: Mon, 10 Nov 2025 20:09:10 +0000
From: Simon Horman <horms@kernel.org>
To: Inochi Amaoto <inochiama@gmail.com>
Cc: Han Gao <rabenda.cn@gmail.com>, Icenowy Zheng <uwu@icenowy.me>,
	Vivian Wang <wangruikang@iscas.ac.cn>, Yao Zi <ziyao@disroot.org>,
	Andrew Lunn <andrew+netdev@lunn.ch>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Chen Wang <unicorn_wang@outlook.com>,
	Maxime Coquelin <mcoquelin.stm32@gmail.com>,
	Alexandre Torgue <alexandre.torgue@foss.st.com>,
	Heiner Kallweit <hkallweit1@gmail.com>,
	Russell King <linux@armlinux.org.uk>,
	"Russell King (Oracle)" <rmk+kernel@armlinux.org.uk>,
	netdev@vger.kernel.org, devicetree@vger.kernel.org,
	sophgo@lists.linux.dev, linux-kernel@vger.kernel.org,
	linux-stm32@st-md-mailman.stormreply.com,
	linux-arm-kernel@lists.infradead.org, Yixun Lan <dlan@gentoo.org>,
	Longbin Li <looong.bin@gmail.com>, Andrew Lunn <andrew@lunn.ch>
Subject: Re: [PATCH v7 3/3] net: stmmac: dwmac-sophgo: Add phy interface
 filter
Message-ID: <aRJGZjgTgcjZgIqe@horms.kernel.org>
References: <20251107111715.3196746-1-inochiama@gmail.com>
 <20251107111715.3196746-4-inochiama@gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20251107111715.3196746-4-inochiama@gmail.com>

On Fri, Nov 07, 2025 at 07:17:15PM +0800, Inochi Amaoto wrote:
> As the SG2042 has an internal rx delay, the delay should be removed
> when initializing the mac, otherwise the phy will be misconfigurated.
> 
> Fixes: 543009e2d4cd ("net: stmmac: dwmac-sophgo: Add support for Sophgo SG2042 SoC")
> Signed-off-by: Inochi Amaoto <inochiama@gmail.com>
> Tested-by: Han Gao <rabenda.cn@gmail.com>
> Reviewed-by: Andrew Lunn <andrew@lunn.ch>
> ---
>  .../ethernet/stmicro/stmmac/dwmac-sophgo.c    | 20 ++++++++++++++++++-
>  1 file changed, 19 insertions(+), 1 deletion(-)
> 
> diff --git a/drivers/net/ethernet/stmicro/stmmac/dwmac-sophgo.c b/drivers/net/ethernet/stmicro/stmmac/dwmac-sophgo.c

...

> @@ -50,11 +56,23 @@ static int sophgo_dwmac_probe(struct platform_device *pdev)
>  	if (ret)
>  		return ret;
>  
> +	data = device_get_match_data(&pdev->dev);
> +	if (data && data->has_internal_rx_delay) {
> +		plat_dat->phy_interface = phy_fix_phy_mode_for_mac_delays(plat_dat->phy_interface,
> +									  false, true);
> +		if (plat_dat->phy_interface == PHY_INTERFACE_MODE_NA)
> +			return -EINVAL;

I'm sorry if this is a false positive. Because, more so than Russell [1], I
confused about how about the treatment of phy_interface. But it seems that
there is a miss match between the use of phy_fix_phy_mode_for_mac_delays()
above and the binding.

The call to phy_fix_phy_mode_for_mac_delays() above will return
PHY_INTERFACE_MODE_NA unless phy_interface is PHY_INTERFACE_MODE_RGMII_ID
or PHY_INTERFACE_MODE_RGMII_RXID.

  phy_interface_t phy_fix_phy_mode_for_mac_delays(phy_interface_t interface,
						bool mac_txid, bool mac_rxid)
  ...
	if (mac_rxid) {
		if (interface == PHY_INTERFACE_MODE_RGMII_ID)
			return PHY_INTERFACE_MODE_RGMII_TXID;
		if (interface == PHY_INTERFACE_MODE_RGMII_RXID)
			return PHY_INTERFACE_MODE_RGMII;
		return PHY_INTERFACE_MODE_NA;
	}
  ...

Looking at phy_modes(), unsurprisingly, the following mappings occur:
* "rgmii" -> PHY_INTERFACE_MODE_RGMII
* "rgmii-id" -> PHY_INTERFACE_MODE_RGMII_ID
* "rgmii-rxid" -> PHY_INTERFACE_MODE_RGMII_RXID
* "rgmii-txid" -> PHY_INTERFACE_MODE_RGMII_TXID

And in the binding, patch 1/3 of this series, only phy-mode rgmii-txid or
rgmii-id is allowed.

But if rgmii-txid is used, PHY_INTERFACE_MODE_RGMII_TXID will be passed to
phy_fix_phy_mode_for_mac_delays(), which will return PHY_INTERFACE_MODE_NA.

Again, I'm confused about the mapping in phy_fix_phy_mode_for_mac_delays().
But there does seem to be some inconsistency between the binding and
the driver implementation here.

Flagged by Claude Code with https://github.com/masoncl/review-prompts/ 

[1] https://lore.kernel.org/all/aPSubO4tJjN_ns-t@shell.armlinux.org.uk/

...

