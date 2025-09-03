Return-Path: <netdev+bounces-219733-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 29C58B42D0B
	for <lists+netdev@lfdr.de>; Thu,  4 Sep 2025 00:54:08 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id D5C311BC1B93
	for <lists+netdev@lfdr.de>; Wed,  3 Sep 2025 22:54:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BE4D72EE263;
	Wed,  3 Sep 2025 22:54:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b="XctDD/MJ"
X-Original-To: netdev@vger.kernel.org
Received: from vps0.lunn.ch (vps0.lunn.ch [156.67.10.101])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EAAD02ECD07;
	Wed,  3 Sep 2025 22:54:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=156.67.10.101
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756940043; cv=none; b=BQbGfKdJisj7e0sOx1DmQ9m0E2OqRCWfn+WbjwS0Sb89XXdsDQUDvFNDuZ951z0poUc4pkODB8SYXoJECXE6kDiuJFOLq/g53NSfeDlQIzwYP+G82ekIdmyJs6AUR0CaEMfLNdyaZuK+Hhn+a0RAetXQSzfObmz5GMAv8W5HgoQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756940043; c=relaxed/simple;
	bh=XfTPu2oZ7lfmXdMQ6ihXpC+gQo+ikABjst2FKnf0inU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=ukyET23szbgTZWB0HEFp5EcvkmahAtb2R97VEkwNOwXQ6I7q4Sc9Myw7k/MaZYsFxPIo0pg5TcL3KMwM31UUZGRmzMkDhJjOxme49920cM7XNRKgAfPWD8PDNSBIyh8GBhb9hRcIQfNCY1D2Q0DFxVSJUPRNgp7qzfRf7GYoqrM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch; spf=pass smtp.mailfrom=lunn.ch; dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b=XctDD/MJ; arc=none smtp.client-ip=156.67.10.101
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lunn.ch
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=lunn.ch;
	s=20171124; h=In-Reply-To:Content-Disposition:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:From:Sender:Reply-To:Subject:
	Date:Message-ID:To:Cc:MIME-Version:Content-Type:Content-Transfer-Encoding:
	Content-ID:Content-Description:Content-Disposition:In-Reply-To:References;
	bh=H5iWDKFTWxPvKGPHXejnuF9lWu57HYhTyaWxcyUeEPE=; b=XctDD/MJgzIUbVqE0lww2FJ8kZ
	sA9QSTEXXngpkXfvLS5Fx3CQ93+j/ac+UadPrgplOU7y1udBaZTXJtEyyawYBMtGqwxFndpFK2nN0
	Nhr1zLbaEUIga6mpFMTc9+pxldwyZPUFBOoab725qdn8aJtuVusrySMqTwgQTUwJUaRI=;
Received: from andrew by vps0.lunn.ch with local (Exim 4.94.2)
	(envelope-from <andrew@lunn.ch>)
	id 1utwM3-0076X8-Hm; Thu, 04 Sep 2025 00:53:27 +0200
Date: Thu, 4 Sep 2025 00:53:27 +0200
From: Andrew Lunn <andrew@lunn.ch>
To: Dong Yibo <dong100@mucse.com>
Cc: andrew+netdev@lunn.ch, davem@davemloft.net, edumazet@google.com,
	kuba@kernel.org, pabeni@redhat.com, horms@kernel.org,
	corbet@lwn.net, gur.stavi@huawei.com, maddy@linux.ibm.com,
	mpe@ellerman.id.au, danishanwar@ti.com, lee@trager.us,
	gongfan1@huawei.com, lorenzo@kernel.org, geert+renesas@glider.be,
	Parthiban.Veerasooran@microchip.com, lukas.bulwahn@redhat.com,
	alexanderduyck@fb.com, richardcochran@gmail.com, kees@kernel.org,
	gustavoars@kernel.org, rdunlap@infradead.org,
	vadim.fedorenko@linux.dev, netdev@vger.kernel.org,
	linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org,
	linux-hardening@vger.kernel.org
Subject: Re: [PATCH net-next v10 5/5] net: rnpgbe: Add register_netdev
Message-ID: <b9a066d0-17b5-4da5-9c5d-8fe848e00896@lunn.ch>
References: <20250903025430.864836-1-dong100@mucse.com>
 <20250903025430.864836-6-dong100@mucse.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250903025430.864836-6-dong100@mucse.com>

>   * rnpgbe_add_adapter - Add netdev for this pci_dev
>   * @pdev: PCI device information structure
> @@ -78,6 +129,38 @@ static int rnpgbe_add_adapter(struct pci_dev *pdev,
>  
>  	hw->hw_addr = hw_addr;
>  	info->init(hw);
> +	mucse_init_mbx_params_pf(hw);
> +	err = hw->ops->echo_fw_status(hw, true, mucse_fw_powerup);
> +	if (err) {
> +		dev_warn(&pdev->dev, "Send powerup to hw failed %d\n", err);
> +		dev_warn(&pdev->dev, "Maybe low performance\n");
> +	}
> +
> +	err = mucse_mbx_sync_fw(hw);
> +	if (err) {
> +		dev_err(&pdev->dev, "Sync fw failed! %d\n", err);
> +		goto err_free_net;
> +	}

The order here seems odd. Don't you want to synchronise the mbox
before you power up? If your are out of sync, the power up could fail,
and you keep in lower power mode? 

> +	netdev->netdev_ops = &rnpgbe_netdev_ops;
> +	netdev->watchdog_timeo = 5 * HZ;
> +	err = hw->ops->reset_hw(hw);
> +	if (err) {
> +		dev_err(&pdev->dev, "Hw reset failed %d\n", err);
> +		goto err_free_net;
> +	}
> +	err = hw->ops->get_perm_mac(hw);
> +	if (err == -EINVAL) {
> +		dev_warn(&pdev->dev, "Try to use random MAC\n");
> +		eth_random_addr(hw->perm_addr);

eth_random_addr() cannot fail. So you don't try to use a random MAC
address, you are using a random MAC address/

	Andrew

