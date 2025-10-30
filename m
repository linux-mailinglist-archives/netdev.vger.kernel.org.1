Return-Path: <netdev+bounces-234352-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 44ABCC1F95C
	for <lists+netdev@lfdr.de>; Thu, 30 Oct 2025 11:35:36 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 7C8AA464135
	for <lists+netdev@lfdr.de>; Thu, 30 Oct 2025 10:33:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AA28D351FAD;
	Thu, 30 Oct 2025 10:33:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=armlinux.org.uk header.i=@armlinux.org.uk header.b="mhe+afEJ"
X-Original-To: netdev@vger.kernel.org
Received: from pandora.armlinux.org.uk (pandora.armlinux.org.uk [78.32.30.218])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D79AE2882A1;
	Thu, 30 Oct 2025 10:33:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=78.32.30.218
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761820418; cv=none; b=s91W4eDuDMfwLszib72U5uB045EtL8Us5DqbiPasnbn9raftQD0RhytGTUuosrasRseSYt5bFaARyjML1ywGvt8TTVHkWsSV4mkSV1Lc7HSuTkMo/HTsKCffpU/fWbgyZUDR3dbtA5SiGw6zQvoh2AyaQHZb2qU0HPrHbPNLm2g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761820418; c=relaxed/simple;
	bh=oel8tMmtyc6xaq2BcHMZlBGzzEoBoMry4zkVTpe0pHo=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=FlyqMBMOeBAZERtV7tF2NrGVbISsuKn3hLjDo5T0K+GYAJ8eZiVNmoM9lZVYZ/qFMeqrzZxashvT356bkvolfsmSXPyzO9FxGWMHLUM9g+sfecGooyqxj8WyQbgJNOoE6ffb/pObTx+DSEF4c3g4osWwYZXAYRpMc8R0AXY78rs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=armlinux.org.uk; spf=none smtp.mailfrom=armlinux.org.uk; dkim=pass (2048-bit key) header.d=armlinux.org.uk header.i=@armlinux.org.uk header.b=mhe+afEJ; arc=none smtp.client-ip=78.32.30.218
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=armlinux.org.uk
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=armlinux.org.uk
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=armlinux.org.uk; s=pandora-2019; h=Sender:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
	List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
	bh=dEOf8TBUJIgzfwfRuKWeofWnNpL3ZO9x9PK/8aK9tEY=; b=mhe+afEJcNn+x4wnWIMPjJbLD7
	gkSxD39KBgElP1LV9Tbvx04mg7o6Z/Me2kU44aUJRahVhf/ruS0gtTMuwJ0COCZGS+973Z7atktAJ
	siXZ6OdIXiO1tHxM0AJCrNDrmO+yguhyDoeRw9r4kYgRYUO7aCNg6VooGewnN/MkeqxT8HWGmuNxz
	vLhhy/wtvE7oIwHD9xm52ysUPDT6eeFb40o3oG2vFhOJdxzG5ZonCh0BCjMPPn1SLaci6vqrt8FUN
	FVrNbl8MVGZpNd8gF2a9HpgHBORSCM75aom/nPD82V/dirsi8fifDPn5cwV6EHx1cPiVReFx/Yamr
	AwOZWKHg==;
Received: from shell.armlinux.org.uk ([fd8f:7570:feb6:1:5054:ff:fe00:4ec]:50626)
	by pandora.armlinux.org.uk with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.98.2)
	(envelope-from <linux@armlinux.org.uk>)
	id 1vEPyD-000000005YA-1MR4;
	Thu, 30 Oct 2025 10:33:29 +0000
Received: from linux by shell.armlinux.org.uk with local (Exim 4.98.2)
	(envelope-from <linux@shell.armlinux.org.uk>)
	id 1vEPyB-000000008NU-09Cu;
	Thu, 30 Oct 2025 10:33:27 +0000
Date: Thu, 30 Oct 2025 10:33:26 +0000
From: "Russell King (Oracle)" <linux@armlinux.org.uk>
To: Horatiu Vultur <horatiu.vultur@microchip.com>
Cc: andrew@lunn.ch, hkallweit1@gmail.com, davem@davemloft.net,
	edumazet@google.com, kuba@kernel.org, pabeni@redhat.com,
	netdev@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH net v3 1/2] net: phy: micrel: lan8842 errata
Message-ID: <aQM-9u6MQKN_t9fE@shell.armlinux.org.uk>
References: <20251030074941.611454-1-horatiu.vultur@microchip.com>
 <20251030074941.611454-2-horatiu.vultur@microchip.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20251030074941.611454-2-horatiu.vultur@microchip.com>
Sender: Russell King (Oracle) <linux@armlinux.org.uk>

On Thu, Oct 30, 2025 at 08:49:40AM +0100, Horatiu Vultur wrote:
> +static int lan8842_erratas(struct phy_device *phydev)
> +{
> +	int ret;
> +
> +	/* Magjack center tapped ports */
> +	ret = lanphy_write_page_reg(phydev, LAN8814_PAGE_POWER_REGS,
> +				    LAN8814_POWER_MGMT_MODE_3_ANEG_MDI,
> +				    LAN8814_POWER_MGMT_VAL1);
> +	if (ret < 0)
> +		return ret;
> +
> +	ret = lanphy_write_page_reg(phydev, LAN8814_PAGE_POWER_REGS,
> +				    LAN8814_POWER_MGMT_MODE_4_ANEG_MDIX,
> +				    LAN8814_POWER_MGMT_VAL1);
> +	if (ret < 0)
> +		return ret;
> +
> +	ret = lanphy_write_page_reg(phydev, LAN8814_PAGE_POWER_REGS,
> +				    LAN8814_POWER_MGMT_MODE_5_10BT_MDI,
> +				    LAN8814_POWER_MGMT_VAL1);
> +	if (ret < 0)
> +		return ret;
> +
> +	ret = lanphy_write_page_reg(phydev, LAN8814_PAGE_POWER_REGS,
> +				    LAN8814_POWER_MGMT_MODE_6_10BT_MDIX,
> +				    LAN8814_POWER_MGMT_VAL1);
> +	if (ret < 0)
> +		return ret;
> +
> +	ret = lanphy_write_page_reg(phydev, LAN8814_PAGE_POWER_REGS,
> +				    LAN8814_POWER_MGMT_MODE_7_100BT_TRAIN,
> +				    LAN8814_POWER_MGMT_VAL2);
> +	if (ret < 0)
> +		return ret;
> +
> +	ret = lanphy_write_page_reg(phydev, LAN8814_PAGE_POWER_REGS,
> +				    LAN8814_POWER_MGMT_MODE_8_100BT_MDI,
> +				    LAN8814_POWER_MGMT_VAL3);
> +	if (ret < 0)
> +		return ret;
> +
> +	ret = lanphy_write_page_reg(phydev, LAN8814_PAGE_POWER_REGS,
> +				    LAN8814_POWER_MGMT_MODE_9_100BT_EEE_MDI_TX,
> +				    LAN8814_POWER_MGMT_VAL3);
> +	if (ret < 0)
> +		return ret;
> +
> +	ret = lanphy_write_page_reg(phydev, LAN8814_PAGE_POWER_REGS,
> +				    LAN8814_POWER_MGMT_MODE_10_100BT_EEE_MDI_RX,
> +				    LAN8814_POWER_MGMT_VAL4);
> +	if (ret < 0)
> +		return ret;
> +
> +	ret = lanphy_write_page_reg(phydev, LAN8814_PAGE_POWER_REGS,
> +				    LAN8814_POWER_MGMT_MODE_11_100BT_MDIX,
> +				    LAN8814_POWER_MGMT_VAL5);
> +	if (ret < 0)
> +		return ret;
> +
> +	ret = lanphy_write_page_reg(phydev, LAN8814_PAGE_POWER_REGS,
> +				    LAN8814_POWER_MGMT_MODE_12_100BT_EEE_MDIX_TX,
> +				    LAN8814_POWER_MGMT_VAL5);
> +	if (ret < 0)
> +		return ret;
> +
> +	ret = lanphy_write_page_reg(phydev, LAN8814_PAGE_POWER_REGS,
> +				    LAN8814_POWER_MGMT_MODE_13_100BT_EEE_MDIX_RX,
> +				    LAN8814_POWER_MGMT_VAL4);
> +	if (ret < 0)
> +		return ret;
> +
> +	return lanphy_write_page_reg(phydev, LAN8814_PAGE_POWER_REGS,
> +				     LAN8814_POWER_MGMT_MODE_14_100BTX_EEE_TX_RX,
> +				     LAN8814_POWER_MGMT_VAL4);

This is a lot of repetition.

Is it worth storing the errata register information in a struct, and
then using a loop to write these registers. Something like:

struct lanphy_reg_data {
	int page;
	u16 addr;
	u16 val;
;

static const struct lanphy_reg_data short_centre_tap_errata[] = {
	...
};

static int lanphy_write_reg_data(struct phy_device *phydev,
				 const struct lanphy_reg_data *data,
				 size_t num)
{
	int ret = 0;

	while (num--) {
		ret = lanphy_write_page_reg(phydev, data->page, data->addr,
					    data->val);
		if (ret)
			break;
	}

	return 0;
}

static int lan8842_erratas(struct phy_device *phydev)
{
	int ret;

	ret = lanphy_write_reg_data(phydev, short_centre_tap_errata,
				    ARRAY_SIZE(short_centre_tap_errata));
	if (ret)
		return ret;

	return lanphy_write_reg_data(phydev, blah_errata,
				     ARRAY_SIZE(blah_errata));
}

?

-- 
RMK's Patch system: https://www.armlinux.org.uk/developer/patches/
FTTP is here! 80Mbps down 10Mbps up. Decent connectivity at last!

