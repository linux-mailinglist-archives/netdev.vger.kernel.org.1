Return-Path: <netdev+bounces-217824-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 58A21B39EAC
	for <lists+netdev@lfdr.de>; Thu, 28 Aug 2025 15:23:21 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 2CB851C838CC
	for <lists+netdev@lfdr.de>; Thu, 28 Aug 2025 13:22:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D96CA311971;
	Thu, 28 Aug 2025 13:21:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b="Bj8BsdLP"
X-Original-To: netdev@vger.kernel.org
Received: from vps0.lunn.ch (vps0.lunn.ch [156.67.10.101])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2CFB730DECC;
	Thu, 28 Aug 2025 13:21:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=156.67.10.101
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756387283; cv=none; b=SwFTxYBL/6Efdb5H/VCXCXk84m8SbA1qrkfqYhiY9sEzS1+tBsUzJY69mYauJploo/UAT0SmCKGNqFM+ckE3F3Q4d1L1WcAgegFNqA8ZQqOlp+CnWTH+rJhrp9KhJ0I7PXJfnzpybL1ZQ/hY8uithpNniK+u7RIJg2/PEP5TFhc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756387283; c=relaxed/simple;
	bh=Xrecx64vJN8d2Fip7wEf3/fmg2/Bwcntm4abqeUeaUU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=noQlA6rKNJn6Ls/CRA5+eAXRrEYaKMTeiqJzkVavc9uflUYVTwaFVVdMki461iF0IqBFvob6i/FryELJ4/qCkR8Cwd4+XiSm/lUBbdqVkGfTU4InmHOmlk03gkrqTgsCfkFi26me1A3hQlsU3m1dguDz6pgPpDF6Rh6xMdm5LFo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch; spf=pass smtp.mailfrom=lunn.ch; dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b=Bj8BsdLP; arc=none smtp.client-ip=156.67.10.101
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lunn.ch
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=lunn.ch;
	s=20171124; h=In-Reply-To:Content-Disposition:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:From:Sender:Reply-To:Subject:
	Date:Message-ID:To:Cc:MIME-Version:Content-Type:Content-Transfer-Encoding:
	Content-ID:Content-Description:Content-Disposition:In-Reply-To:References;
	bh=ImxFE4Tql19qHORQ8B9zxDfF5fp9/O6bvriJBQ+xKzM=; b=Bj8BsdLPGe07g0aRdl1hmvw7m0
	xno4Xw7c4yb6Kdrab8yC4867YESKgrXiJQYFeUKug2vhjlFGDLzjKFNQ7fJRczFKPT0l/2mY0q02t
	O2rgPNSug1fDjGm2xxOdOUPGrM6aKtk1Gtqt4FBJ1vgKqTcUDY32WxngdYlzFWZSCmw0=;
Received: from andrew by vps0.lunn.ch with local (Exim 4.94.2)
	(envelope-from <andrew@lunn.ch>)
	id 1urcXs-006LzB-4M; Thu, 28 Aug 2025 15:20:04 +0200
Date: Thu, 28 Aug 2025 15:20:04 +0200
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
Subject: Re: [PATCH net-next v9 5/5] net: rnpgbe: Add register_netdev
Message-ID: <e0f71a7d-1288-4971-804d-123e3e8a153f@lunn.ch>
References: <20250828025547.568563-1-dong100@mucse.com>
 <20250828025547.568563-6-dong100@mucse.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250828025547.568563-6-dong100@mucse.com>

> +/**
> + * rnpgbe_reset_hw_ops - Do a hardware reset
> + * @hw: hw information structure
> + *
> + * rnpgbe_reset_hw_ops calls fw to do a hardware
> + * reset, and cleans some regs to default.
> + *
> + * Return: 0 on success, negative errno on failure
> + **/
> +static int rnpgbe_reset_hw_ops(struct mucse_hw *hw)
> +{
> +	struct mucse_dma_info *dma = &hw->dma;
> +	int err;
> +
> +	rnpgbe_dma_wr32(dma, RNPGBE_DMA_AXI_EN, 0);
> +	err = mucse_mbx_fw_reset_phy(hw);
> +	if (err)
> +		return err;
> +	return rnpgbe_get_permanent_mac(hw, hw->perm_addr);

Why is a function named rnpgbe_reset_hw_ops() getting the permanent
MAC address? Reset should not have anything to do with MAC address.

If the MAC address is not valid, you normally use a random MAC
address. But you cannot easily differentiate between the reset failed,
the reset got ^C, and the MAC address was not valid.

> +/**
> + * rnpgbe_driver_status_hw_ops - Echo driver status to hw
> + * @hw: hw information structure
> + * @enable: true or false status
> + * @mode: status mode
> + **/
> +static void rnpgbe_driver_status_hw_ops(struct mucse_hw *hw,
> +					bool enable,
> +					int mode)
> +{
> +	switch (mode) {
> +	case mucse_driver_insmod:
> +		mucse_mbx_ifinsmod(hw, enable);

Back to the ^C handling. This could be interrupted before the firmware
is told the driver is loaded. That EINTR is thrown away here, so the
driver thinks everything is O.K, but the firmware still thinks there
is no MAC driver. What happens then?

And this is the same problem i pointed out before, you ignore EINTR in
a void function. Rather than fix one instance, you should of reviewed
the whole driver and fixed them all. You cannot expect the Reviewers
to do this for you.

    Andrew

---
pw-bot: cr

