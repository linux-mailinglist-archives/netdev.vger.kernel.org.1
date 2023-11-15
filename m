Return-Path: <netdev+bounces-46884-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 3459C7E6E9B
	for <lists+netdev@lfdr.de>; Thu,  9 Nov 2023 17:23:25 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id B56BCB20BB3
	for <lists+netdev@lfdr.de>; Thu,  9 Nov 2023 16:23:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9C4562136B;
	Thu,  9 Nov 2023 16:23:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b="esslbwfV"
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F0A46210EE
	for <netdev@vger.kernel.org>; Thu,  9 Nov 2023 16:23:17 +0000 (UTC)
Received: from vps0.lunn.ch (vps0.lunn.ch [156.67.10.101])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BD12735A9;
	Thu,  9 Nov 2023 08:23:16 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=lunn.ch;
	s=20171124; h=In-Reply-To:Content-Disposition:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:From:Sender:Reply-To:Subject:
	Date:Message-ID:To:Cc:MIME-Version:Content-Type:Content-Transfer-Encoding:
	Content-ID:Content-Description:Content-Disposition:In-Reply-To:References;
	bh=IgIWkKpvGMvUKj92YCRYLOy8UePNcQyB18TDcSyhxoE=; b=esslbwfVGfDyH5J4Z1pPOHI+8G
	XKEVlcHOinNAydE2xp/gTDlnHfg/SVLmso1tcIvdsnCftiD4FIzZW10F5SOvIOKATlTMOHU8D/iH/
	vZQk62wqQFHPlS8fpv6jnU1Vj9reEIH7hXnGYKl922iB5KK5mORtBUMCvOC0h8cnQJQM=;
Received: from andrew by vps0.lunn.ch with local (Exim 4.94.2)
	(envelope-from <andrew@lunn.ch>)
	id 1r17o2-001DYh-UI; Thu, 09 Nov 2023 17:22:58 +0100
Date: Thu, 9 Nov 2023 17:22:58 +0100
From: Andrew Lunn <andrew@lunn.ch>
To: Gan Yi Fang <yi.fang.gan@intel.com>
Cc: Alexandre Torgue <alexandre.torgue@foss.st.com>,
	Jose Abreu <joabreu@synopsys.com>,
	"David S . Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	Maxime Coquelin <mcoquelin.stm32@gmail.com>,
	Russell King <linux@armlinux.org.uk>,
	Andrew Halaney <ahalaney@redhat.com>,
	Simon Horman <horms@kernel.org>,
	Bartosz Golaszewski <bartosz.golaszewski@linaro.org>,
	Shenwei Wang <shenwei.wang@nxp.com>,
	Russell King <rmk+kernel@armlinux.org.uk>,
	Johannes Zink <j.zink@pengutronix.de>,
	Jochen Henneberg <jh@henneberg-systemdesign.com>,
	netdev@vger.kernel.org, linux-stm32@st-md-mailman.stormreply.com,
	linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
	Looi Hong Aun <hong.aun.looi@intel.com>,
	Voon Weifeng <weifeng.voon@intel.com>,
	Song Yoong Siang <yoong.siang.song@intel.com>
Subject: Re: [PATCH net-next 1/1] net: stmmac: Add support for HW-accelerated
 VLAN stripping
Message-ID: <b197865d-8905-497c-8fe0-d6e122b0d9f7@lunn.ch>
References: <20231109053831.2572699-1-yi.fang.gan@intel.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20231109053831.2572699-1-yi.fang.gan@intel.com>

> +static void dwmac4_rx_hw_vlan(struct mac_device_info *hw,
> +			      struct dma_desc *rx_desc, struct sk_buff *skb)
> +{
> +	if (hw->desc->get_rx_vlan_valid(rx_desc)) {
> +		u16 vid = (u16)hw->desc->get_rx_vlan_tci(rx_desc);
> +
> +		__vlan_hwaccel_put_tag(skb, htons(ETH_P_8021Q), vid);
> +	}
> +}

> +static inline int dwmac4_wrback_get_rx_vlan_tci(struct dma_desc *p)
> +{
> +	return (le32_to_cpu(p->des0) & RDES0_VLAN_TAG_MASK);
> +}

A tci is a u16. If you make this function return a u16, you can avoid
the cast.

  Andrew

