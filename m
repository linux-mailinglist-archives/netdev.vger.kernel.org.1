Return-Path: <netdev+bounces-241072-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id CF894C7E9CD
	for <lists+netdev@lfdr.de>; Mon, 24 Nov 2025 00:47:25 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 7FF193A4489
	for <lists+netdev@lfdr.de>; Sun, 23 Nov 2025 23:47:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D28DD218AA0;
	Sun, 23 Nov 2025 23:47:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b="aMwK4ShO"
X-Original-To: netdev@vger.kernel.org
Received: from vps0.lunn.ch (vps0.lunn.ch [156.67.10.101])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 90FC9EEAB
	for <netdev@vger.kernel.org>; Sun, 23 Nov 2025 23:47:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=156.67.10.101
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763941642; cv=none; b=ZAYQs83r/bS7soXMZjgeSw5YK48PMx/eEIIcQ2EYmVAoP+5er7hYc3Z7TwGQbe/tFoN+ebSNR5ghIhWOfz1Lx+U3rcXmlKzTQkjtnxYH4iPIAwAKyivxf9nMnmloKACmEeRukD6/sk1JuMPl4lZQtzoVqh+UGgM2VAdAuL7ma2g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763941642; c=relaxed/simple;
	bh=9pkUwld7jb54EztoY+tY5H4CgrzXwC8niOFhSf/MyK4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Gag6ClDcPZY6IBhnh0Yl1TUmFKYQVogXOFyiB1ymCaoLSo6CAKRq31CW33qTp+gDm/jmZT/WFHyCWC5zun5/sr68MK3bgZiO/VUiJNXkJTLB/vO+YhtVG4dU+Kfkja4TeFww/u/PQIYuSFYGuAJ4risZpZ/6wSIPwZV2kp8LP7A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch; spf=pass smtp.mailfrom=lunn.ch; dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b=aMwK4ShO; arc=none smtp.client-ip=156.67.10.101
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lunn.ch
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=lunn.ch;
	s=20171124; h=In-Reply-To:Content-Disposition:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:From:Sender:Reply-To:Subject:
	Date:Message-ID:To:Cc:MIME-Version:Content-Type:Content-Transfer-Encoding:
	Content-ID:Content-Description:Content-Disposition:In-Reply-To:References;
	bh=ilzgoUw0dbLE4V8vYArjoOgGP8wYeF94HdTQuXpTlQE=; b=aMwK4ShOpUWeQFkHrNaY2oSbb0
	5B2DpTuAcg8VuWdwX8KDwxwoqaPf6HPsY+i6LumNXnUxQ9DyEGb/Y7N2pBtV73NBtJr1BhTLxStXT
	UNT+YpNr1bxNLA8WFeeqVGJf1TbfV4vpT7c3WLgIe9gVm131npwFEKx9XQpDaU2ub5DM=;
Received: from andrew by vps0.lunn.ch with local (Exim 4.94.2)
	(envelope-from <andrew@lunn.ch>)
	id 1vNJnR-00ErlL-3l; Mon, 24 Nov 2025 00:47:09 +0100
Date: Mon, 24 Nov 2025 00:47:09 +0100
From: Andrew Lunn <andrew@lunn.ch>
To: Vladimir Oltean <vladimir.oltean@nxp.com>
Cc: netdev@vger.kernel.org, Paolo Abeni <pabeni@redhat.com>,
	Eric Dumazet <edumazet@google.com>,
	Vladimir Oltean <olteanv@gmail.com>,
	"David S. Miller" <davem@davemloft.net>,
	Jakub Kicinski <kuba@kernel.org>
Subject: Re: [PATCH net-next 1/3] net: dsa: cpu_dp->orig_ethtool_ops might be
 NULL
Message-ID: <da37b219-1606-4378-9636-9512700c4b80@lunn.ch>
References: <20251122112311.138784-1-vladimir.oltean@nxp.com>
 <20251122112311.138784-2-vladimir.oltean@nxp.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20251122112311.138784-2-vladimir.oltean@nxp.com>

On Sat, Nov 22, 2025 at 01:23:09PM +0200, Vladimir Oltean wrote:
> In theory this would have been seen by now, but it seems that all
> drivers used as DSA conduit interfaces thus far have had ethtool_ops
> set, and it's hard to even find modern Ethernet drivers (and not VF
> ones) which don't use ethtool.
> 
> Here is the unfiltered list of drivers which register any sort of
> net_device but don't set its ethtool_ops pointer. I don't think any of
> them 'risks' being used as a DSA conduit, maybe except for moxart,
> rnpbge and icssm, I'm not sure.
> 
> - drivers/net/can/dev/dev.c
> - drivers/net/wwan/qcom_bam_dmux.c
> - drivers/net/wwan/t7xx/t7xx_netdev.c
> - drivers/net/arcnet/arcnet.c
> - drivers/net/hamradio/
> - drivers/net/slip/slip.c
> - drivers/net/ethernet/ezchip/nps_enet.c
> - drivers/net/ethernet/moxa/moxart_ether.c
> - drivers/net/ethernet/wangxun/txgbevf/txgbevf_main.c
> - drivers/net/ethernet/wangxun/ngbevf/ngbevf_main.c
> - drivers/net/ethernet/huawei/hinic3/hinic3_main.c
> - drivers/net/ethernet/i825xx/
> - drivers/net/ethernet/ti/icssm/icssm_prueth.c
> - drivers/net/ethernet/seeq/
> - drivers/net/ethernet/litex/litex_liteeth.c
> - drivers/net/ethernet/sunplus/spl2sw_driver.c
> - drivers/net/ethernet/mucse/rnpgbe/rnpgbe_main.c
> - drivers/net/ipa/
> - drivers/net/wireless/microchip/wilc1000/
> - drivers/net/wireless/mediatek/mt76/dma.c
> - drivers/net/wireless/ath/ath12k/
> - drivers/net/wireless/ath/ath11k/
> - drivers/net/wireless/ath/ath6kl/
> - drivers/net/wireless/ath/ath10k/
> - drivers/net/wireless/intel/iwlwifi/pcie/gen1_2/trans.c
> - drivers/net/wireless/virtual/mac80211_hwsim.c
> - drivers/net/wireless/quantenna/qtnfmac/pcie/pcie.c
> - drivers/net/wireless/realtek/rtw89/core.c
> - drivers/net/wireless/realtek/rtw88/pci.c
> - drivers/net/caif/
> - drivers/net/plip/
> - drivers/net/wan/
> - drivers/net/mctp/
> - drivers/net/ppp/
> - drivers/net/thunderbolt/
> 
> Nonetheless, it's good for the framework not to make such assumptions,
> and not panic when coming across such kind of host device in the future.
> 
> Signed-off-by: Vladimir Oltean <vladimir.oltean@nxp.com>

Reviewed-by: Andrew Lunn <andrew@lunn.ch>

    Andrew

