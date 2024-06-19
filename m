Return-Path: <netdev+bounces-104791-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 4E79C90E66A
	for <lists+netdev@lfdr.de>; Wed, 19 Jun 2024 10:59:04 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 536121C20AA9
	for <lists+netdev@lfdr.de>; Wed, 19 Jun 2024 08:59:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D33D97D3EF;
	Wed, 19 Jun 2024 08:58:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=armlinux.org.uk header.i=@armlinux.org.uk header.b="sP0DbQlp"
X-Original-To: netdev@vger.kernel.org
Received: from pandora.armlinux.org.uk (pandora.armlinux.org.uk [78.32.30.218])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7C8047D07E;
	Wed, 19 Jun 2024 08:58:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=78.32.30.218
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718787539; cv=none; b=FZvc9+ryBupr6jtNwzwbbqF6EhYuZnnPj9Nhr7v3S7OzdUj/kGnr8jZ/aMc2xLA8qcfN5xh8pCdf139UE3mQ22HwIraQyZrL0FN5snVjkGkYd1+9Wu9/I6tkfKTYI+lsQyz5PHz1dsC81INjLmW8gIZRBiwpr673x35z0xgTJr8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718787539; c=relaxed/simple;
	bh=5e1tuKoSU4JhpFeu96V+Km2ar8/JJsNaywgKU242sD4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=ZsjC4hMqdHaHLUqC6Wgs4kdA6KZ6s+stxsvY8tRUkrCyKx60MydP+X2luGmz3U72gHbmqUVKW8XWPaZHThKr1LpbwYqQ04FHH2icqnx46k5ASfynzF4VBPHLpxb9LrH1Jv8VAX/0atj+IcJUHT2uerYeKEOUAxI2sWjTM3CJHPo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=armlinux.org.uk; spf=none smtp.mailfrom=armlinux.org.uk; dkim=pass (2048-bit key) header.d=armlinux.org.uk header.i=@armlinux.org.uk header.b=sP0DbQlp; arc=none smtp.client-ip=78.32.30.218
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=armlinux.org.uk
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=armlinux.org.uk
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=armlinux.org.uk; s=pandora-2019; h=Sender:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
	List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
	bh=/5pPQjjaT4GK7Sd1WEXbIZE8WP645Hv92WIF4d4jgG0=; b=sP0DbQlpG3YXZpp5VKqHJo18KT
	fH4jvQQiqoTCSl3BVCAbYkpM0e8qI0cWMoyg5imLG11ft1bZrFGqTqXJ2VH1fFVHWsq546vsDSR8/
	+FitfR15qh/TiaCZbefaYEore6DkSPHaSaLFzNHv4YlVRYbNDALbOy/Z6BkQ6mXNe6NtP+0SYr/Bw
	kFqGG6V5EEV7r0SbSelbjh6mXs5BVC9A1887dpknCR+9zS8byAS01Ah6Q6dnuliImhQ4swNEu/icO
	vHBpMcjRZQe3zH6d1nqnQ9W04MzZg2csCJ/7Ddcpnr5/p9LQ+LuW2aksB/mUyaj9CQZjqn0Vf2/AK
	MNdmlKlg==;
Received: from shell.armlinux.org.uk ([fd8f:7570:feb6:1:5054:ff:fe00:4ec]:47872)
	by pandora.armlinux.org.uk with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.96)
	(envelope-from <linux@armlinux.org.uk>)
	id 1sJr9P-00082M-1X;
	Wed, 19 Jun 2024 09:58:43 +0100
Received: from linux by shell.armlinux.org.uk with local (Exim 4.94.2)
	(envelope-from <linux@shell.armlinux.org.uk>)
	id 1sJr9Q-0006cr-Js; Wed, 19 Jun 2024 09:58:44 +0100
Date: Wed, 19 Jun 2024 09:58:44 +0100
From: "Russell King (Oracle)" <linux@armlinux.org.uk>
To: Sky Huang <SkyLake.Huang@mediatek.com>
Cc: Andrew Lunn <andrew@lunn.ch>, Heiner Kallweit <hkallweit1@gmail.com>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	Daniel Golle <daniel@makrotopia.org>,
	Qingfang Deng <dqfext@gmail.com>,
	Matthias Brugger <matthias.bgg@gmail.com>,
	AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>,
	linux-kernel@vger.kernel.org, netdev@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org,
	linux-mediatek@lists.infradead.org,
	Steven Liu <Steven.Liu@mediatek.com>
Subject: Re: [PATCH net-next v7 2/5] net: phy: mediatek: Move LED and
 read/write page helper functions into mtk phy lib
Message-ID: <ZnKdxOM/2/5WvZCJ@shell.armlinux.org.uk>
References: <20240613104023.13044-1-SkyLake.Huang@mediatek.com>
 <20240613104023.13044-3-SkyLake.Huang@mediatek.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240613104023.13044-3-SkyLake.Huang@mediatek.com>
Sender: Russell King (Oracle) <linux@armlinux.org.uk>

On Thu, Jun 13, 2024 at 06:40:20PM +0800, Sky Huang wrote:
> @@ -342,7 +295,8 @@ static int cal_cycle(struct phy_device *phydev, int devad,
>  	ret = phy_read_mmd_poll_timeout(phydev, MDIO_MMD_VEND1,
>  					MTK_PHY_RG_AD_CAL_CLK, reg_val,
>  					reg_val & MTK_PHY_DA_CAL_CLK, 500,
> -					ANALOG_INTERNAL_OPERATION_MAX_US, false);
> +					ANALOG_INTERNAL_OPERATION_MAX_US,
> +					false);

Again, this patch is moving code around. There should be no extraneous
changes in such a patch - it should just move code around, fixing stuff
up for the code move. Any other change (such as reformatting) should be
done as a separate patch.

>  	if (ret) {
>  		phydev_err(phydev, "Calibration cycle timeout\n");
>  		return ret;
> @@ -351,7 +305,7 @@ static int cal_cycle(struct phy_device *phydev, int devad,
>  	phy_clear_bits_mmd(phydev, MDIO_MMD_VEND1, MTK_PHY_RG_AD_CALIN,
>  			   MTK_PHY_DA_CALIN_FLAG);
>  	ret = phy_read_mmd(phydev, MDIO_MMD_VEND1, MTK_PHY_RG_AD_CAL_COMP) >>
> -			   MTK_PHY_AD_CAL_COMP_OUT_SHIFT;
> +	      MTK_PHY_AD_CAL_COMP_OUT_SHIFT;

I don't see a reason for this change, and it goes against established
coding style.

>  	phydev_dbg(phydev, "cal_val: 0x%x, ret: %d\n", cal_val, ret);
>  
>  	return ret;
> @@ -440,38 +394,46 @@ static int tx_amp_fill_result(struct phy_device *phydev, u16 *buf)
>  	}
>  
>  	phy_modify_mmd(phydev, MDIO_MMD_VEND1, MTK_PHY_TXVLD_DA_RG,
> -		       MTK_PHY_DA_TX_I2MPB_A_GBE_MASK, (buf[0] + bias[0]) << 10);
> +		       MTK_PHY_DA_TX_I2MPB_A_GBE_MASK,
> +		       (buf[0] + bias[0]) << 10);

Likewise, this is an extraneous change to the primary purpose of this
patch which is to reorganise code to a new file. 

>  	phy_modify_mmd(phydev, MDIO_MMD_VEND1, MTK_PHY_TXVLD_DA_RG,
>  		       MTK_PHY_DA_TX_I2MPB_A_TBT_MASK, buf[0] + bias[1]);
>  	phy_modify_mmd(phydev, MDIO_MMD_VEND1, MTK_PHY_TX_I2MPB_TEST_MODE_A2,
> -		       MTK_PHY_DA_TX_I2MPB_A_HBT_MASK, (buf[0] + bias[2]) << 10);
> +		       MTK_PHY_DA_TX_I2MPB_A_HBT_MASK,
> +		       (buf[0] + bias[2]) << 10);

Same again.

>  	phy_modify_mmd(phydev, MDIO_MMD_VEND1, MTK_PHY_TX_I2MPB_TEST_MODE_A2,
>  		       MTK_PHY_DA_TX_I2MPB_A_TST_MASK, buf[0] + bias[3]);
>  
>  	phy_modify_mmd(phydev, MDIO_MMD_VEND1, MTK_PHY_TX_I2MPB_TEST_MODE_B1,
> -		       MTK_PHY_DA_TX_I2MPB_B_GBE_MASK, (buf[1] + bias[4]) << 8);
> +		       MTK_PHY_DA_TX_I2MPB_B_GBE_MASK,
> +		       (buf[1] + bias[4]) << 8);

And here.

>  	phy_modify_mmd(phydev, MDIO_MMD_VEND1, MTK_PHY_TX_I2MPB_TEST_MODE_B1,
>  		       MTK_PHY_DA_TX_I2MPB_B_TBT_MASK, buf[1] + bias[5]);
>  	phy_modify_mmd(phydev, MDIO_MMD_VEND1, MTK_PHY_TX_I2MPB_TEST_MODE_B2,
> -		       MTK_PHY_DA_TX_I2MPB_B_HBT_MASK, (buf[1] + bias[6]) << 8);
> +		       MTK_PHY_DA_TX_I2MPB_B_HBT_MASK,
> +		       (buf[1] + bias[6]) << 8);

And here.

>  	phy_modify_mmd(phydev, MDIO_MMD_VEND1, MTK_PHY_TX_I2MPB_TEST_MODE_B2,
>  		       MTK_PHY_DA_TX_I2MPB_B_TST_MASK, buf[1] + bias[7]);
>  
>  	phy_modify_mmd(phydev, MDIO_MMD_VEND1, MTK_PHY_TX_I2MPB_TEST_MODE_C1,
> -		       MTK_PHY_DA_TX_I2MPB_C_GBE_MASK, (buf[2] + bias[8]) << 8);
> +		       MTK_PHY_DA_TX_I2MPB_C_GBE_MASK,
> +		       (buf[2] + bias[8]) << 8);

Ditto.

>  	phy_modify_mmd(phydev, MDIO_MMD_VEND1, MTK_PHY_TX_I2MPB_TEST_MODE_C1,
>  		       MTK_PHY_DA_TX_I2MPB_C_TBT_MASK, buf[2] + bias[9]);
>  	phy_modify_mmd(phydev, MDIO_MMD_VEND1, MTK_PHY_TX_I2MPB_TEST_MODE_C2,
> -		       MTK_PHY_DA_TX_I2MPB_C_HBT_MASK, (buf[2] + bias[10]) << 8);
> +		       MTK_PHY_DA_TX_I2MPB_C_HBT_MASK,
> +		       (buf[2] + bias[10]) << 8);

Ditto.

>  	phy_modify_mmd(phydev, MDIO_MMD_VEND1, MTK_PHY_TX_I2MPB_TEST_MODE_C2,
>  		       MTK_PHY_DA_TX_I2MPB_C_TST_MASK, buf[2] + bias[11]);
>  
>  	phy_modify_mmd(phydev, MDIO_MMD_VEND1, MTK_PHY_TX_I2MPB_TEST_MODE_D1,
> -		       MTK_PHY_DA_TX_I2MPB_D_GBE_MASK, (buf[3] + bias[12]) << 8);
> +		       MTK_PHY_DA_TX_I2MPB_D_GBE_MASK,
> +		       (buf[3] + bias[12]) << 8);

Ditto.

>  	phy_modify_mmd(phydev, MDIO_MMD_VEND1, MTK_PHY_TX_I2MPB_TEST_MODE_D1,
>  		       MTK_PHY_DA_TX_I2MPB_D_TBT_MASK, buf[3] + bias[13]);
>  	phy_modify_mmd(phydev, MDIO_MMD_VEND1, MTK_PHY_TX_I2MPB_TEST_MODE_D2,
> -		       MTK_PHY_DA_TX_I2MPB_D_HBT_MASK, (buf[3] + bias[14]) << 8);
> +		       MTK_PHY_DA_TX_I2MPB_D_HBT_MASK,
> +		       (buf[3] + bias[14]) << 8);

Ditto.

>  	phy_modify_mmd(phydev, MDIO_MMD_VEND1, MTK_PHY_TX_I2MPB_TEST_MODE_D2,
>  		       MTK_PHY_DA_TX_I2MPB_D_TST_MASK, buf[3] + bias[15]);
>  
> @@ -662,7 +624,8 @@ static int tx_vcm_cal_sw(struct phy_device *phydev, u8 rg_txreserve_x)
>  		goto restore;
>  
>  	/* We calibrate TX-VCM in different logic. Check upper index and then
> -	 * lower index. If this calibration is valid, apply lower index's result.
> +	 * lower index. If this calibration is valid, apply lower index's
> +	 * result.

Ditto.

>  	 */
>  	ret = upper_ret - lower_ret;
>  	if (ret == 1) {
> @@ -691,7 +654,8 @@ static int tx_vcm_cal_sw(struct phy_device *phydev, u8 rg_txreserve_x)
>  	} else if (upper_idx == TXRESERVE_MAX && upper_ret == 0 &&
>  		   lower_ret == 0) {
>  		ret = 0;
> -		phydev_warn(phydev, "TX-VCM SW cal result at high margin 0x%x\n",
> +		phydev_warn(phydev,
> +			    "TX-VCM SW cal result at high margin 0x%x\n",

Ditto.

>  			    upper_idx);
>  	} else {
>  		ret = -EINVAL;
> @@ -795,7 +759,8 @@ static void mt7981_phy_finetune(struct phy_device *phydev)
>  
>  	/* TR_OPEN_LOOP_EN = 1, lpf_x_average = 9 */
>  	phy_modify_mmd(phydev, MDIO_MMD_VEND1, MTK_PHY_RG_DEV1E_REG234,
> -		       MTK_PHY_TR_OPEN_LOOP_EN_MASK | MTK_PHY_LPF_X_AVERAGE_MASK,
> +		       MTK_PHY_TR_OPEN_LOOP_EN_MASK |
> +		       MTK_PHY_LPF_X_AVERAGE_MASK,

Ditto.

>  		       BIT(0) | FIELD_PREP(MTK_PHY_LPF_X_AVERAGE_MASK, 0x9));
>  
>  	/* rg_tr_lpf_cnt_val = 512 */
> @@ -864,7 +829,8 @@ static void mt7988_phy_finetune(struct phy_device *phydev)
>  
>  	/* TR_OPEN_LOOP_EN = 1, lpf_x_average = 10 */
>  	phy_modify_mmd(phydev, MDIO_MMD_VEND1, MTK_PHY_RG_DEV1E_REG234,
> -		       MTK_PHY_TR_OPEN_LOOP_EN_MASK | MTK_PHY_LPF_X_AVERAGE_MASK,
> +		       MTK_PHY_TR_OPEN_LOOP_EN_MASK |
> +		       MTK_PHY_LPF_X_AVERAGE_MASK,

Ditto.

>  		       BIT(0) | FIELD_PREP(MTK_PHY_LPF_X_AVERAGE_MASK, 0xa));
>  
>  	/* rg_tr_lpf_cnt_val = 1023 */
> @@ -976,7 +942,8 @@ static void mt798x_phy_eee(struct phy_device *phydev)
>  	phy_restore_page(phydev, MTK_PHY_PAGE_STANDARD, 0);
>  
>  	phy_select_page(phydev, MTK_PHY_PAGE_EXTENDED_3);
> -	__phy_modify(phydev, MTK_PHY_LPI_REG_14, MTK_PHY_LPI_WAKE_TIMER_1000_MASK,
> +	__phy_modify(phydev, MTK_PHY_LPI_REG_14,
> +		     MTK_PHY_LPI_WAKE_TIMER_1000_MASK,
>  		     FIELD_PREP(MTK_PHY_LPI_WAKE_TIMER_1000_MASK, 0x19c));

Ditto.

>  
>  	__phy_modify(phydev, MTK_PHY_LPI_REG_1c, MTK_PHY_SMI_DET_ON_THRESH_MASK,
> @@ -986,7 +953,8 @@ static void mt798x_phy_eee(struct phy_device *phydev)
>  	phy_modify_mmd(phydev, MDIO_MMD_VEND1,
>  		       MTK_PHY_RG_LPI_PCS_DSP_CTRL_REG122,
>  		       MTK_PHY_LPI_NORM_MSE_HI_THRESH1000_MASK,
> -		       FIELD_PREP(MTK_PHY_LPI_NORM_MSE_HI_THRESH1000_MASK, 0xff));
> +		       FIELD_PREP(MTK_PHY_LPI_NORM_MSE_HI_THRESH1000_MASK,
> +				  0xff));

Ditto.

>  }
>  
>  static int cal_sw(struct phy_device *phydev, enum CAL_ITEM cal_item,
> @@ -1130,57 +1098,13 @@ static int mt798x_phy_config_init(struct phy_device *phydev)
>  	return mt798x_phy_calibration(phydev);
>  }
>  
> -static int mt798x_phy_hw_led_on_set(struct phy_device *phydev, u8 index,
> -				    bool on)
> -{
> -	unsigned int bit_on = MTK_PHY_LED_STATE_FORCE_ON + (index ? 16 : 0);
> -	struct mtk_socphy_priv *priv = phydev->priv;
> -	bool changed;
> -
> -	if (on)
> -		changed = !test_and_set_bit(bit_on, &priv->led_state);
> -	else
> -		changed = !!test_and_clear_bit(bit_on, &priv->led_state);
> -
> -	changed |= !!test_and_clear_bit(MTK_PHY_LED_STATE_NETDEV +
> -					(index ? 16 : 0), &priv->led_state);
> -	if (changed)
> -		return phy_modify_mmd(phydev, MDIO_MMD_VEND2, index ?
> -				      MTK_PHY_LED1_ON_CTRL : MTK_PHY_LED0_ON_CTRL,

If you're moving this code, don't even correct this formatting in the
new file. If you correct the formatting in a patch _before_ this one,
then do the move, the formatting will then be correct in the new file
and the code move will be exactly that - just a code move.

>  static int mt798x_phy_led_blink_set(struct phy_device *phydev, u8 index,
>  				    unsigned long *delay_on,
>  				    unsigned long *delay_off)
>  {
>  	bool blinking = false;
>  	int err = 0;
> +	struct mtk_socphy_priv *priv = phydev->priv;

Netdev wants reverse Christmas-tree. Longest local variable declaration
first, followed by next shorter and so on. So, in this case, it should
be priv, blinking, then err in that order.

>  static int mt798x_phy_led_brightness_set(struct phy_device *phydev,
>  					 u8 index, enum led_brightness value)
>  {
>  	int err;
> +	struct mtk_socphy_priv *priv = phydev->priv;

Reverse Christmas tree please.

>  static int mt798x_phy_led_hw_control_set(struct phy_device *phydev, u8 index,
>  					 unsigned long rules)
>  {
> -	unsigned int bit_netdev = MTK_PHY_LED_STATE_NETDEV + (index ? 16 : 0);
>  	struct mtk_socphy_priv *priv = phydev->priv;
> -	u16 on = 0, blink = 0;
> -	int ret;
> -
> -	if (index > 1)
> -		return -EINVAL;
> -
> -	if (rules & BIT(TRIGGER_NETDEV_FULL_DUPLEX))
> -		on |= MTK_PHY_LED_ON_FDX;
> -
> -	if (rules & BIT(TRIGGER_NETDEV_HALF_DUPLEX))
> -		on |= MTK_PHY_LED_ON_HDX;
> -
> -	if (rules & (BIT(TRIGGER_NETDEV_LINK_10) | BIT(TRIGGER_NETDEV_LINK)))
> -		on |= MTK_PHY_LED_ON_LINK10;
> -
> -	if (rules & (BIT(TRIGGER_NETDEV_LINK_100) | BIT(TRIGGER_NETDEV_LINK)))
> -		on |= MTK_PHY_LED_ON_LINK100;
> -
> -	if (rules & (BIT(TRIGGER_NETDEV_LINK_1000) | BIT(TRIGGER_NETDEV_LINK)))
> -		on |= MTK_PHY_LED_ON_LINK1000;
>  
> -	if (rules & BIT(TRIGGER_NETDEV_RX)) {
> -		blink |= (on & MTK_PHY_LED_ON_LINK) ?
> -			  (((on & MTK_PHY_LED_ON_LINK10) ? MTK_PHY_LED_BLINK_10RX : 0) |
> -			   ((on & MTK_PHY_LED_ON_LINK100) ? MTK_PHY_LED_BLINK_100RX : 0) |
> -			   ((on & MTK_PHY_LED_ON_LINK1000) ? MTK_PHY_LED_BLINK_1000RX : 0)) :
> -			  MTK_PHY_LED_BLINK_RX;

Now for this mess - and it should've been caught earlier... far too many
parens. Too many parens make code unreadable. Also, we know "blink"
starts off with the bits clear. So:

	if (rules & BIT(TRIGGER_NETDEV_RX)) {
		if (on & MTK_PHY_LED_ON_LINK) {
			if (on & MTK_PHY_LED_ON_LINK10)
				blink |= MTK_PHY_LED_BLINK_10RX;
			if (on & MTK_PHY_LED_ON_LINK100)
				blink |= MTK_PHY_LED_BLINK_100RX;
			if (on & MTK_PHY_LED_ON_LINK1000)
				blink |= MTK_PHY_LED_BLINK_1000RX;
		} else {
			blink |= MTK_PHY_LED_BLINK_RX;
		}
	}

is a much nicer and easier to read formatting.

Thanks.

-- 
RMK's Patch system: https://www.armlinux.org.uk/developer/patches/
FTTP is here! 80Mbps down 10Mbps up. Decent connectivity at last!

