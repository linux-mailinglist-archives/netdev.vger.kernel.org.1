Return-Path: <netdev+bounces-113559-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A875793F0C3
	for <lists+netdev@lfdr.de>; Mon, 29 Jul 2024 11:16:35 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id C9EE51C216B2
	for <lists+netdev@lfdr.de>; Mon, 29 Jul 2024 09:16:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2E58F13E3E7;
	Mon, 29 Jul 2024 09:16:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=armlinux.org.uk header.i=@armlinux.org.uk header.b="QjIOX5Py"
X-Original-To: netdev@vger.kernel.org
Received: from pandora.armlinux.org.uk (pandora.armlinux.org.uk [78.32.30.218])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 141E26F2F7;
	Mon, 29 Jul 2024 09:16:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=78.32.30.218
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722244579; cv=none; b=L/JE2BLJRvfUCa8m4zCpCrJFFEKhF4b2r/1qYx3Umc231dUNimLQM6o35wKgBskFrivmxdWHq7sOL7GFN6JghQmdjklyj6qFWdAyE0IvkklMESqCivtGclOpncZ7mOdhPE2s0g3kfujUAVazvuhlq92ldXzQx10ljEHvVixxZdg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722244579; c=relaxed/simple;
	bh=AkX6G6z885Q5T5CpW6N0zxY91QJ/CgPE6kJycFRUhv4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=dZXshkxg5Dn4XiYkKgQFwDuAD0OxVi2muXJCGNliTy8SJ7yTjforpPlhb+3KEr2FTz4HDYjVSx9gpUTSqilxKsUVzFQXSYtd/yfvmyaIRFEBd2tzZQCFaT3jTglxZexbAo3yqDHto6bOvoD8sXJ66vofYRT9jN6qehPTPBl8+Cc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=armlinux.org.uk; spf=none smtp.mailfrom=armlinux.org.uk; dkim=pass (2048-bit key) header.d=armlinux.org.uk header.i=@armlinux.org.uk header.b=QjIOX5Py; arc=none smtp.client-ip=78.32.30.218
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=armlinux.org.uk
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=armlinux.org.uk
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=armlinux.org.uk; s=pandora-2019; h=Sender:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
	List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
	bh=lYDuApbFcnvR3FtABndQmjg0ANtGaAe67G8GpyHWIyE=; b=QjIOX5PyrzYrwolLgxOFBu1Zcx
	zqTzcDDT2IZU1WW9831ZJlZF1Ukv6UdMxExGYXkxpIfAoqmeJzTsLqfsHeoniMjbKb3qOvS8H+c5Q
	62U20zJzG6tBciAPh/0UC6tabRNhv9WuJH7aU1TmDFP9e+zKMfLYCovsypAQygLvUhvgWJNlnQqPR
	q/siV5occB8x78aT4SQCk7t5h1u6ZJrST6qdk6hhsyssADoqt1rSMEOHtwGsom+OIo5XKlpxQ48dQ
	StPplvMplOV2E1HgbeSpJL4Le5z1u9G6zNd9oOhA9i/SMwS3x4Vuy12AZzqsej8bPJUGOtqgFfgvn
	nwThTn6Q==;
Received: from shell.armlinux.org.uk ([fd8f:7570:feb6:1:5054:ff:fe00:4ec]:49390)
	by pandora.armlinux.org.uk with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.96)
	(envelope-from <linux@armlinux.org.uk>)
	id 1sYMU9-0003Sn-0N;
	Mon, 29 Jul 2024 10:16:05 +0100
Received: from linux by shell.armlinux.org.uk with local (Exim 4.94.2)
	(envelope-from <linux@shell.armlinux.org.uk>)
	id 1sYMUA-0004Cy-It; Mon, 29 Jul 2024 10:16:06 +0100
Date: Mon, 29 Jul 2024 10:16:06 +0100
From: "Russell King (Oracle)" <linux@armlinux.org.uk>
To: Raju Lakkaraju <Raju.Lakkaraju@microchip.com>
Cc: netdev@vger.kernel.org, davem@davemloft.net, kuba@kernel.org,
	andrew@lunn.ch, horms@kernel.org, hkallweit1@gmail.com,
	richardcochran@gmail.com, rdunlap@infradead.org,
	bryan.whitehead@microchip.com, edumazet@google.com,
	pabeni@redhat.com, linux-kernel@vger.kernel.org,
	UNGLinuxDriver@microchip.com
Subject: Re: [PATCH net-next V2 3/4] net: lan743x: Migrate phylib to phylink
Message-ID: <Zqdd1mfSUDK9EifJ@shell.armlinux.org.uk>
References: <20240716113349.25527-1-Raju.Lakkaraju@microchip.com>
 <20240716113349.25527-4-Raju.Lakkaraju@microchip.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240716113349.25527-4-Raju.Lakkaraju@microchip.com>
Sender: Russell King (Oracle) <linux@armlinux.org.uk>

On Tue, Jul 16, 2024 at 05:03:48PM +0530, Raju Lakkaraju wrote:
> +static void lan743x_phylink_mac_link_up(struct phylink_config *config,
> +					struct phy_device *phydev,
> +					unsigned int link_an_mode,
> +					phy_interface_t interface,
> +					int speed, int duplex,
> +					bool tx_pause, bool rx_pause)
> +{
> +	struct net_device *netdev = to_net_dev(config->dev);
> +	struct lan743x_adapter *adapter = netdev_priv(netdev);
> +	int mac_cr;
> +	u8 cap;
> +
> +	mac_cr = lan743x_csr_read(adapter, MAC_CR);
> +	/* Pre-initialize register bits.
> +	 * Resulting value corresponds to SPEED_10
> +	 */
> +	mac_cr &= ~(MAC_CR_CFG_H_ | MAC_CR_CFG_L_);
> +	if (speed == SPEED_2500)
> +		mac_cr |= (MAC_CR_CFG_H_ | MAC_CR_CFG_L_);
> +	else if (speed == SPEED_1000)
> +		mac_cr |= (MAC_CR_CFG_H_);
> +	else if (speed == SPEED_100)
> +		mac_cr |= (MAC_CR_CFG_L_);

These parens in each of these if() sub-blocks is not required. |=
operates the same way as = - all such operators are treated the same
in C.

> +
> +	lan743x_csr_write(adapter, MAC_CR, mac_cr);
> +
> +	lan743x_ptp_update_latency(adapter, speed);
> +
> +	/* Flow Control operation */
> +	cap = 0;
> +	if (tx_pause)
> +		cap |= FLOW_CTRL_TX;
> +	if (rx_pause)
> +		cap |= FLOW_CTRL_RX;
> +
> +	lan743x_mac_flow_ctrl_set_enables(adapter,
> +					  cap & FLOW_CTRL_TX,
> +					  cap & FLOW_CTRL_RX);
> +
> +	netif_tx_wake_all_queues(to_net_dev(config->dev));

You already have "netdev", so there's no need to do the to_net_dev()
dance again here.

> +}
> +
> +static const struct phylink_mac_ops lan743x_phylink_mac_ops = {
> +	.mac_config = lan743x_phylink_mac_config,
> +	.mac_link_down = lan743x_phylink_mac_link_down,
> +	.mac_link_up = lan743x_phylink_mac_link_up,
> +};

I guess as there's no PCS support here, you don't support inband mode
for 1000base-X (which is rather fundamental for it).

> +
> +static int lan743x_phylink_create(struct net_device *netdev)
> +{
> +	struct lan743x_adapter *adapter = netdev_priv(netdev);
> +	struct phylink *pl;
> +
> +	adapter->phylink_config.dev = &netdev->dev;
> +	adapter->phylink_config.type = PHYLINK_NETDEV;
> +	adapter->phylink_config.mac_managed_pm = false;
> +
> +	adapter->phylink_config.mac_capabilities = MAC_ASYM_PAUSE |
> +		MAC_SYM_PAUSE | MAC_10 | MAC_100 | MAC_1000FD | MAC_2500FD;
> +
> +	lan743x_phy_interface_select(adapter);
> +
> +	switch (adapter->phy_interface) {
> +	case PHY_INTERFACE_MODE_SGMII:
> +		__set_bit(PHY_INTERFACE_MODE_SGMII,
> +			  adapter->phylink_config.supported_interfaces);
> +		__set_bit(PHY_INTERFACE_MODE_1000BASEX,
> +			  adapter->phylink_config.supported_interfaces);
> +		__set_bit(PHY_INTERFACE_MODE_2500BASEX,
> +			  adapter->phylink_config.supported_interfaces);
> +		break;
> +	case PHY_INTERFACE_MODE_GMII:
> +		__set_bit(PHY_INTERFACE_MODE_GMII,
> +			  adapter->phylink_config.supported_interfaces);
> +		break;
> +	case PHY_INTERFACE_MODE_MII:
> +		__set_bit(PHY_INTERFACE_MODE_MII,
> +			  adapter->phylink_config.supported_interfaces);
> +		break;
> +	default:
> +		__set_bit(PHY_INTERFACE_MODE_RGMII,
> +			  adapter->phylink_config.supported_interfaces);

Do you really only support RGMII and not RGMII_ID/RGMII_TXID/RGMII_RXID
(which are normally implemented by tweaking the delays at the PHY end
of the RGMII link) ?

> +static bool lan743x_phy_handle_exists(struct device_node *dn)
> +{
> +	dn = of_parse_phandle(dn, "phy-handle", 0);
> +	of_node_put(dn);
> +	if (IS_ERR(dn))
> +		return false;
> +
> +	return true;

This likely doesn't work. Have you checked what the return values for
of_parse_phandle() actually are before creating this, because to me
this looks like you haven't - and thus what you've created is wrong.
of_parse_phandle() doesn't return error-pointers when it fails, it
returns NULL. Therefore, this will always return true.

We have another implementation of something very similar in the macb
driver - see macb_phy_handle_exists(), and this one is implemented
correctly.

> +}
> +
> +static int lan743x_phylink_connect(struct lan743x_adapter *adapter)
> +{
> +	struct device_node *dn = adapter->pdev->dev.of_node;
> +	struct net_device *dev = adapter->netdev;
> +	struct fixed_phy_status fphy_status = {
> +		.link = 1,
> +		.speed = SPEED_1000,
> +		.duplex = DUPLEX_FULL,
> +	};
> +	struct phy_device *phydev;
> +	int ret;
> +
> +	if (dn)
> +		ret = phylink_of_phy_connect(adapter->phylink, dn, 0);
> +
> +	if (!dn || (ret && !lan743x_phy_handle_exists(dn))) {
> +		phydev = phy_find_first(adapter->mdiobus);
> +		if (!phydev) {
> +			if (((adapter->csr.id_rev & ID_REV_ID_MASK_) ==
> +			      ID_REV_ID_LAN7431_) || adapter->is_pci11x1x) {
> +				phydev = fixed_phy_register(PHY_POLL,
> +							    &fphy_status,
> +							    NULL);
> +				if (IS_ERR(phydev)) {
> +					netdev_err(dev, "No PHY/fixed_PHY found\n");
> +					return PTR_ERR(phydev);
> +				}

Eww. Given that phylink has its own internal fixed-PHY support, can we
not find some way to avoid the legacy fixed-PHY usage here?

-- 
RMK's Patch system: https://www.armlinux.org.uk/developer/patches/
FTTP is here! 80Mbps down 10Mbps up. Decent connectivity at last!

