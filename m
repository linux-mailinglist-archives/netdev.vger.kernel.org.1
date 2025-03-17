Return-Path: <netdev+bounces-175424-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 6F6DAA65CDF
	for <lists+netdev@lfdr.de>; Mon, 17 Mar 2025 19:38:48 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id F31DB1640DC
	for <lists+netdev@lfdr.de>; Mon, 17 Mar 2025 18:38:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E54931C9B9B;
	Mon, 17 Mar 2025 18:38:18 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from pidgin.makrotopia.org (pidgin.makrotopia.org [185.142.180.65])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 60457176ADB;
	Mon, 17 Mar 2025 18:38:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.142.180.65
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742236698; cv=none; b=KRQGP7dQVzLTljbStIO+CL7MmsiyxzSmzKYnabxgJA+cJVF+3lWrrAE5SYgZo6Waw3lRpB0KY7yl55fkp5XuP1q5HFf68VqDGWF/9r/UYdmA/ukpnOK4/CbcGEWQb5ne5ntn+Spv3mMxBBTPAyjuqCxAyyOEuifr0yCG0Ye7leY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742236698; c=relaxed/simple;
	bh=x8VzNlnfyxrbj98l+2sMkUMZwVMQl42R9kHvQVPYs+k=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=L8TCpwvAnqX/xWaXVn3GNPIxnV4MuiS88d170d3qG0pW2eG/7kNO+5TIlOFR6I2NyZ7CTMqCA/aKsQ5xgw65nQhkWMxODOeC7bLu7QvayAtzh1HeJSleTMAgi+rItZMJQd25NyD89ZKOslkchsaMEgK7VtkNlPX8D84Z5Z+JBGE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=makrotopia.org; spf=pass smtp.mailfrom=makrotopia.org; arc=none smtp.client-ip=185.142.180.65
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=makrotopia.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=makrotopia.org
Received: from local
	by pidgin.makrotopia.org with esmtpsa (TLS1.3:TLS_AES_256_GCM_SHA384:256)
	 (Exim 4.98)
	(envelope-from <daniel@makrotopia.org>)
	id 1tuFLa-000000007G3-0hL0;
	Mon, 17 Mar 2025 18:37:58 +0000
Date: Mon, 17 Mar 2025 18:37:54 +0000
From: Daniel Golle <daniel@makrotopia.org>
To: "Lucien.Jheng" <lucienx123@gmail.com>
Cc: linux-clk@vger.kernel.org, andrew@lunn.ch, hkallweit1@gmail.com,
	linux@armlinux.org.uk, kuba@kernel.org, davem@davemloft.net,
	edumazet@google.com, pabeni@redhat.com, ericwouds@gmail.com,
	netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
	joseph.lin@airoha.com, wenshin.chung@airoha.com
Subject: Re: [PATCH v4 net-next PATCH 1/1] net: phy: air_en8811h: Add clk
 provider for CKO pin
Message-ID: <Z9hsAmiD9sZ_NAR-@makrotopia.org>
References: <20250317143111.28824-1-lucienX123@gmail.com>
 <20250317143111.28824-2-lucienX123@gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250317143111.28824-2-lucienX123@gmail.com>

On Mon, Mar 17, 2025 at 10:31:11PM +0800, Lucien.Jheng wrote:
> EN8811H outputs 25MHz or 50MHz clocks on CKO, selected by GPIO3.
> CKO clock activates on power-up and continues through md32 firmware loading.

Maybe add here:
"Implement clk provider driver so we can disable the clock output in case
it isn't needed, which also helps to reduce EMF noise"

Ie. the description you had was fine and good to have, just the lines had to
be shorter (ie. just insert linebreaks at 70~75 chars).

See more comments inline below:

> ...
> @@ -806,6 +817,84 @@ static int en8811h_led_hw_is_supported(struct phy_device *phydev, u8 index,
>  	return 0;
>  };
>  
> +static unsigned long en8811h_recalc_rate(struct clk_hw *hw, unsigned long parent)

calling this en8811h_clk_recalc_rate() would be better imho.

> +{
> +	struct en8811h_priv *priv = clk_hw_to_en8811h_priv(hw);
> +	struct phy_device *phydev = priv->phydev;
> +	u32 pbus_value;
> +	int ret;
> +
> +	ret = air_buckpbus_reg_read(phydev, EN8811H_HWTRAP1, &pbus_value);
> +	if (ret < 0)
> +		return ret;
> +
> +	return (pbus_value & EN8811H_HWTRAP1_CKO) ? 50000000 : 25000000;
> +}
> +
> +static int en8811h_enable(struct clk_hw *hw)

call this en8811h_clk_enable()

> +{
> +	struct en8811h_priv *priv = clk_hw_to_en8811h_priv(hw);
> +	struct phy_device *phydev = priv->phydev;
> +
> +	return air_buckpbus_reg_modify(phydev, EN8811H_CLK_CGM,
> +				EN8811H_CLK_CGM_CKO, EN8811H_CLK_CGM_CKO);
> +}
> +
> +static void en8811h_disable(struct clk_hw *hw)

call this en8811h_clk_disable()

> +{
> +	struct en8811h_priv *priv = clk_hw_to_en8811h_priv(hw);
> +	struct phy_device *phydev = priv->phydev;
> +
> +	air_buckpbus_reg_modify(phydev, EN8811H_CLK_CGM,
> +				EN8811H_CLK_CGM_CKO, 0);
> +}
> +
> +static int en8811h_is_enabled(struct clk_hw *hw)

call this en8811h_clk_is_enabled()

