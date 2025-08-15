Return-Path: <netdev+bounces-213948-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 5B0E3B27704
	for <lists+netdev@lfdr.de>; Fri, 15 Aug 2025 05:43:52 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 4FA7D5E4A6A
	for <lists+netdev@lfdr.de>; Fri, 15 Aug 2025 03:43:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1D09A2BE640;
	Fri, 15 Aug 2025 03:42:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b="TEv8ySd3"
X-Original-To: netdev@vger.kernel.org
Received: from vps0.lunn.ch (vps0.lunn.ch [156.67.10.101])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3D8332BE64F;
	Fri, 15 Aug 2025 03:42:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=156.67.10.101
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755229362; cv=none; b=qt8FXAyw6SogmAl8uGaKcFWHnhzlx9UU0Ac4Ly/ss5McT41Q+vRwY0X+A8VD4m+iXMoO6qR/Q4lWrN9kwJ07NLscwRM3EatddvuZqCDaELp1NW0/qUmeltFZNTG8V4uO36ardcGMaroRgXDNfWBxvORqzJkYDVewFSUf2P6AOrs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755229362; c=relaxed/simple;
	bh=aMG5MR/kQYbZlG+R41I+TyUtSopot5UaB9vuS57geCE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=fITd8lJYaEleNuCOLLxLXlGxhSCUsh9AcilIGcJy4BqBeI6kt4vmRlrLhKPHZv4x2/NxldawUNbk8dzN299ndgR0G8jE/u35r6xUXD9XPglNXJ6aYe/umVYOrQ5dOzCczGrD3RsVLUb75P7j4IfWpcXsbCFERhFGISNsf9W4OBE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch; spf=pass smtp.mailfrom=lunn.ch; dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b=TEv8ySd3; arc=none smtp.client-ip=156.67.10.101
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lunn.ch
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=lunn.ch;
	s=20171124; h=In-Reply-To:Content-Disposition:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:From:Sender:Reply-To:Subject:
	Date:Message-ID:To:Cc:MIME-Version:Content-Type:Content-Transfer-Encoding:
	Content-ID:Content-Description:Content-Disposition:In-Reply-To:References;
	bh=UxqLZiyOaKpTCfZHAkjWJO2mNSyIpBiF2SW7fqA3g6A=; b=TEv8ySd3nZP5F6ZZMmUW3h52BT
	pnCXRyrqJfTlGSHFeyp+w3x69iMAv4c/u5UAz65KL6gaB0qgg9JTuJnUpNHCDQyoy8pIuWgNXa16A
	MdIELcWGHAMUrHekzNSuZGxIudJaqO1vxWg9sRJ0WBpuEU5jAV33E3yodWQfXg1eBDEk=;
Received: from andrew by vps0.lunn.ch with local (Exim 4.94.2)
	(envelope-from <andrew@lunn.ch>)
	id 1umlKP-004mYa-7S; Fri, 15 Aug 2025 05:42:05 +0200
Date: Fri, 15 Aug 2025 05:42:05 +0200
From: Andrew Lunn <andrew@lunn.ch>
To: Dong Yibo <dong100@mucse.com>
Cc: andrew+netdev@lunn.ch, davem@davemloft.net, edumazet@google.com,
	kuba@kernel.org, pabeni@redhat.com, horms@kernel.org,
	corbet@lwn.net, gur.stavi@huawei.com, maddy@linux.ibm.com,
	mpe@ellerman.id.au, danishanwar@ti.com, lee@trager.us,
	gongfan1@huawei.com, lorenzo@kernel.org, geert+renesas@glider.be,
	Parthiban.Veerasooran@microchip.com, lukas.bulwahn@redhat.com,
	alexanderduyck@fb.com, richardcochran@gmail.com,
	netdev@vger.kernel.org, linux-doc@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH v4 5/5] net: rnpgbe: Add register_netdev
Message-ID: <099a6006-02e4-44f0-ae47-7de14cc58a12@lunn.ch>
References: <20250814073855.1060601-1-dong100@mucse.com>
 <20250814073855.1060601-6-dong100@mucse.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250814073855.1060601-6-dong100@mucse.com>

> +struct mucse_hw_operations {
> +	int (*reset_hw)(struct mucse_hw *hw);
> +	void (*driver_status)(struct mucse_hw *hw, bool enable, int mode);
> +};

Again, there is only one instance of this. Will there be more?

> + * rnpgbe_get_permanent_mac - Get permanent mac
> + * @hw: hw information structure
> + * @mac_addr: pointer to store mac
> + *
> + * rnpgbe_get_permanent_mac tries to get mac from hw.
> + * It use eth_random_addr if failed.
> + **/
> +static void rnpgbe_get_permanent_mac(struct mucse_hw *hw,
> +				     u8 *mac_addr)
> +{
> +	struct device *dev = &hw->pdev->dev;
> +
> +	if (mucse_fw_get_macaddr(hw, hw->pfvfnum, mac_addr, hw->lane) ||
> +	    !is_valid_ether_addr(mac_addr)) {
> +		dev_warn(dev, "Failed to get valid MAC from FW, using random\n");
> +		eth_random_addr(mac_addr);
> +	}

With a function named rnpgbe_get_permanent_mac(), i would not expect
it to return a random MAC address. If there is no permanent MAC
address, return -EINVAL, and let the caller does with the error.

> +static int rnpgbe_reset_hw_ops(struct mucse_hw *hw)
> +{
> +	struct mucse_dma_info *dma = &hw->dma;
> +	int err;
> +
> +	dma_wr32(dma, RNPGBE_DMA_AXI_EN, 0);
> +	err = mucse_mbx_fw_reset_phy(hw);
> +	if (err)
> +		return err;
> +	/* Store the permanent mac address */
> +	if (!(hw->flags & M_FLAGS_INIT_MAC_ADDRESS))

What do this hw->flags add to the driver? Why is it here?

>  static void rnpgbe_rm_adapter(struct pci_dev *pdev)
>  {
>  	struct mucse *mucse = pci_get_drvdata(pdev);
> +	struct mucse_hw *hw = &mucse->hw;
>  	struct net_device *netdev;
>  
>  	if (!mucse)
>  		return;
>  	netdev = mucse->netdev;
> +	if (netdev->reg_state == NETREG_REGISTERED)
> +		unregister_netdev(netdev);

Is that possible?

>  	mucse->netdev = NULL;
> +	hw->ops->driver_status(hw, false, mucse_driver_insmod);
>  	free_netdev(netdev);
>  }
>  
> -- 
> 2.25.1
> 

