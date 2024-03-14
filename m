Return-Path: <netdev+bounces-79902-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id E897487BF64
	for <lists+netdev@lfdr.de>; Thu, 14 Mar 2024 15:58:44 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 5C50D1F21EFE
	for <lists+netdev@lfdr.de>; Thu, 14 Mar 2024 14:58:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8840A6F06E;
	Thu, 14 Mar 2024 14:58:40 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from pidgin.makrotopia.org (pidgin.makrotopia.org [185.142.180.65])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 53FDD29CE3
	for <netdev@vger.kernel.org>; Thu, 14 Mar 2024 14:58:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.142.180.65
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710428320; cv=none; b=ZfOcKgDZ8KktIOMkQWck5aZyh9WXoUYt39rtjJdzpoHn4hUKwrTn4grCJfPoh6k1pFrH6977JbDLE6Jrdg9YcUg/m3YJDom/tSegUr7fP5s7R2YWbB4Va3R/3aLsmmJnc+2CTdZpCCRId+Shz2ZGlxh+dI+S+ybOkVhcIlsy6bI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710428320; c=relaxed/simple;
	bh=/CXNTOByyfaW8kIvQ38hgEm2coyTR3tDYY3LEf6z69E=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=LSig6yYQ/JqqAcIs8YSYE7blbTdK9f/CCqTzcNPzp0FTfTDlSVaO0PQ/bq/d3eMbkNSIillQfoOeehoWGoWteIW1afynpf9NdjZZycj0Wc9l5UGMOk2qiTMBp+1PdDFbe/7nK4drCr+U9YHJMdsNFOMUmPRmu/f2fxg7EEcFaoQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=makrotopia.org; spf=pass smtp.mailfrom=makrotopia.org; arc=none smtp.client-ip=185.142.180.65
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=makrotopia.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=makrotopia.org
Received: from local
	by pidgin.makrotopia.org with esmtpsa (TLS1.3:TLS_AES_256_GCM_SHA384:256)
	 (Exim 4.96.2)
	(envelope-from <daniel@makrotopia.org>)
	id 1rkmXR-0007MG-2b;
	Thu, 14 Mar 2024 14:58:33 +0000
Date: Thu, 14 Mar 2024 14:58:24 +0000
From: Daniel Golle <daniel@makrotopia.org>
To: =?utf-8?B?QXLEsW7DpyDDnE5BTA==?= <arinc.unal@arinc9.com>
Cc: Frank Wunderlich <frank-w@public-files.de>,
	netdev <netdev@vger.kernel.org>
Subject: Re: Energy Efficient Ethernet on MT7531 switch
Message-ID: <ZfMQkL2iizhG96Wh@makrotopia.org>
References: <5f1f8827-730e-4f36-bc0a-fec6f5558e93@arinc9.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <5f1f8827-730e-4f36-bc0a-fec6f5558e93@arinc9.com>

Hi,

On Thu, Mar 14, 2024 at 03:57:09PM +0300, Arınç ÜNAL wrote:
> Hi Frank.
> 
> Do you have a board with an external PHY that supports EEE connected to an
> MT7531 switch?

Good to hear you are working on supporting EEE -- something which has
been neglected for too long imho.

I got a bunch of such boards, all of them with different generations
of RealTek RTL8226 or RTL8221 2.5G PHY which in theory supports EEE
but the PHY driver in Linux at this point does not support EEE.

However, as one of the SFP cages of the BPi-R3 is connected to the on-board
MT7531 switch port 5 this would provide the option to basically test EEE
with practically every PHY you could find inside an RJ-45 SFP module
(spoiler: you will mostly find Marvell 88E1111, and I don't see support for
EEE in neither the datasheet nor the responsible sub-driver in Linux).

So looks like we will have to implement support for EEE for either
RealTek's RTL8221B or the built-in PHYs of any of the MT753x, MT7621
or MT7988 switch first.

> I've stumbled across an option on the trap register of
> MT7531 that claims that EEE is disabled switch-wide by default after reset.
> 
> I'm specifically asking for an external PHY because the MT7531 switch PHYs
> don't support EEE yet. But the MT753X DSA subdriver claims to support EEE,
> so the remaining option is external PHYs.
> 
> It'd be great if you can test with and without this diff [1] and see if you
> see EEE supported on ethtool on a computer connected to the external PHY.
> 
> Example output on the computer side:
> 
> $ sudo ethtool --show-eee eno1
> EEE settings for eno1:
> 	EEE status: enabled - active
> 	Tx LPI: 17 (us)
> 	Supported EEE link modes:  100baseT/Full
> 	                           1000baseT/Full
> 	Advertised EEE link modes:  100baseT/Full
> 	                            1000baseT/Full
> 	Link partner advertised EEE link modes:  100baseT/Full
> 	                                         1000baseT/Full
> 
> I'm also CC'ing Daniel and the netdev mailing list, if someone else would
> like to chime in.
> 
> [1]
> diff --git a/drivers/net/dsa/mt7530.c b/drivers/net/dsa/mt7530.c
> index b347d8ab2541..4ef3948d310d 100644
> --- a/drivers/net/dsa/mt7530.c
> +++ b/drivers/net/dsa/mt7530.c
> @@ -2499,6 +2499,8 @@ mt7531_setup(struct dsa_switch *ds)
>  	mt7531_ind_c45_phy_write(priv, MT753X_CTRL_PHY_ADDR, MDIO_MMD_VEND2,
>  				 CORE_PLL_GROUP4, val);
> +	mt7530_rmw(priv, MT7530_MHWTRAP, CHG_STRAP | EEE_DIS, CHG_STRAP);
> +
>  	mt7531_setup_common(ds);
>  	/* Setup VLAN ID 0 for VLAN-unaware bridges */
> diff --git a/drivers/net/dsa/mt7530.h b/drivers/net/dsa/mt7530.h
> index 3c3e7ae0e09b..1b3e81f6c90e 100644
> --- a/drivers/net/dsa/mt7530.h
> +++ b/drivers/net/dsa/mt7530.h
> @@ -299,11 +299,15 @@ enum mt7530_vlan_port_acc_frm {
>  #define  MT7531_FORCE_DPX		BIT(29)
>  #define  MT7531_FORCE_RX_FC		BIT(28)
>  #define  MT7531_FORCE_TX_FC		BIT(27)
> +#define  MT7531_FORCE_EEE100		BIT(26)
> +#define  MT7531_FORCE_EEE1G		BIT(25)
>  #define  MT7531_FORCE_MODE		(MT7531_FORCE_LNK | \
>  					 MT7531_FORCE_SPD | \
>  					 MT7531_FORCE_DPX | \
>  					 MT7531_FORCE_RX_FC | \
> -					 MT7531_FORCE_TX_FC)
> +					 MT7531_FORCE_TX_FC | \
> +					 MT7531_FORCE_EEE100 | \
> +					 MT7531_FORCE_EEE1G)
>  #define  PMCR_LINK_SETTINGS_MASK	(PMCR_TX_EN | PMCR_FORCE_SPEED_1000 | \
>  					 PMCR_RX_EN | PMCR_FORCE_SPEED_100 | \
>  					 PMCR_TX_FC_EN | PMCR_RX_FC_EN | \
> @@ -457,6 +461,7 @@ enum mt7531_clk_skew {
>  #define  XTAL_FSEL_M			BIT(7)
>  #define  PHY_EN				BIT(6)
>  #define  CHG_STRAP			BIT(8)
> +#define  EEE_DIS			BIT(4)
>  /* Register for hw trap modification */
>  #define MT7530_MHWTRAP			0x7804
> 
> Thanks a lot!
> Arınç
> 

