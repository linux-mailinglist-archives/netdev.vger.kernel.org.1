Return-Path: <netdev+bounces-208638-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C9989B0C785
	for <lists+netdev@lfdr.de>; Mon, 21 Jul 2025 17:26:01 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id F3032168D9D
	for <lists+netdev@lfdr.de>; Mon, 21 Jul 2025 15:26:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 048FE28DEE4;
	Mon, 21 Jul 2025 15:25:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b="LcWD2kUF"
X-Original-To: netdev@vger.kernel.org
Received: from vps0.lunn.ch (vps0.lunn.ch [156.67.10.101])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5B26D27CB02;
	Mon, 21 Jul 2025 15:25:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=156.67.10.101
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753111556; cv=none; b=H6FlEPwpW1mzZr+5hJ7AtDVbgcwt6Q7voMRzNkNuxGb7AudXNcdixMw1xzfRgn7dxlATnn1FIq3eZckJ6uzmdl+yK0TGVTTGWaTRFdbTiibXwH/knRZX/vjYkQQf1mgivFB88lBKiWXKmHn9EX+qgnMu4ruAEqbKd55C9tyg+p0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753111556; c=relaxed/simple;
	bh=WGiK6CgbNg6MkBAFiYfTThbtuFTJq4NwamN1AqSNwNU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=LGoCO2+Rvp/v8QCn+RMRxfKvezpmD0MV/qxLU5urj+0H2h3dRI7TG5MimwlhIK4Aiyk96Jn2gaw1du/hnQSe4yxkJLKe+q1QTxA9rlWqEuW0rWfJC0+U68cvDRzPWYHiJKsrwHoXM92vyXMUXVf8BJ2E8EW1K5mkzLviRCPx4rQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch; spf=pass smtp.mailfrom=lunn.ch; dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b=LcWD2kUF; arc=none smtp.client-ip=156.67.10.101
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lunn.ch
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=lunn.ch;
	s=20171124; h=In-Reply-To:Content-Disposition:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:From:Sender:Reply-To:Subject:
	Date:Message-ID:To:Cc:MIME-Version:Content-Type:Content-Transfer-Encoding:
	Content-ID:Content-Description:Content-Disposition:In-Reply-To:References;
	bh=Dy3PggWmA6e6dQc4DmqpbzZpai7iCi9bZI8JxAEFj3Y=; b=LcWD2kUFQBY+Y+SkfKjehSw2bg
	ANvFNsGn2nDh8gJ2nRgwXQHozvj6kgy1Z6qsS4WiSTZdi4y2suvAxECtUDBMFQjnWEmSLO6DnkZuk
	MrBfOWYsIJr+jg129NN0fY9/GL8qlK1ZQiAhNjkvu/7VU02HPMC8meJYWE82+E/wbLck=;
Received: from andrew by vps0.lunn.ch with local (Exim 4.94.2)
	(envelope-from <andrew@lunn.ch>)
	id 1udsO8-002N63-Hx; Mon, 21 Jul 2025 17:25:12 +0200
Date: Mon, 21 Jul 2025 17:25:12 +0200
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
Subject: Re: [PATCH v2 02/15] net: rnpgbe: Add n500/n210 chip support
Message-ID: <4dea5acc-dd7d-463c-b099-53713dd3d7ee@lunn.ch>
References: <20250721113238.18615-1-dong100@mucse.com>
 <20250721113238.18615-3-dong100@mucse.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250721113238.18615-3-dong100@mucse.com>

> +struct mii_regs {
> +	unsigned int addr; /* MII Address */
> +	unsigned int data; /* MII Data */
> +	unsigned int addr_shift; /* MII address shift */
> +	unsigned int reg_shift; /* MII reg shift */
> +	unsigned int addr_mask; /* MII address mask */
> +	unsigned int reg_mask; /* MII reg mask */
> +	unsigned int clk_csr_shift;
> +	unsigned int clk_csr_mask;
> +};

So MII interests me, being the MDIO/PHY maintainer....

You have introduced this without any user, which is not good, so i
cannot see how it is actually used. It is better to introduce
structures in the patch which makes use of them.

Please add this only when you add the mdiobus driver, so i can see how
it is used. Please look at the other structures you have here. Please
add them as they are actually used.

> +struct mucse_hw {
> +	void *back;
> +	u8 pfvfnum;
> +	u8 pfvfnum_system;
> +	u8 __iomem *hw_addr;
> +	u8 __iomem *ring_msix_base;

I spotted this somewhere else. A u8 __iomem * is odd. Why is this not
a void *? ioremap() returns a void __iomem *, and all the readb(),
readw(), readX() functions expect a void * __iomem. So this looks odd.

> +#define m_rd_reg(reg) readl(reg)
> +#define m_wr_reg(reg, val) writel((val), reg)

Please don't wrap standard functions like this. Everybody knows what
readl() does. Nobody has any idea what m_rd_reg() does! You are just
making your driver harder to understand and maintain.

> +	mac->mii.addr = RNPGBE_MII_ADDR;
> +	mac->mii.data = RNPGBE_MII_DATA;
> +	mac->mii.addr_shift = 11;
> +	mac->mii.addr_mask = 0x0000F800;

GENMASK()? If you are using these helpers correctly, you probably
don't need the _shift members.

> +	mac->mii.reg_shift = 6;
> +	mac->mii.reg_mask = 0x000007C0;
> +	mac->mii.clk_csr_shift = 2;
> +	mac->mii.clk_csr_mask = GENMASK(5, 2);
> +	mac->clk_csr = 0x02; /* csr 25M */
> +	/* hw fixed phy_addr */
> +	mac->phy_addr = 0x11;

That is suspicious. But until i see the PHY handling code, it is hard
to say.

> +static void rnpgbe_get_invariants_n210(struct mucse_hw *hw)
> +{
> +	struct mucse_mbx_info *mbx = &hw->mbx;
> +	/* get invariants based from n500 */
> +	rnpgbe_get_invariants_n500(hw);
> +
> +	/* update msix base */
> +	hw->ring_msix_base = hw->hw_addr + 0x29000;
> +	/* update mbx offset */
> +	mbx->vf2pf_mbox_vec_base = 0x29200;
> +	mbx->fw2pf_mbox_vec = 0x29400;
> +	mbx->pf_vf_shm_base = 0x29900;
> +	mbx->mbx_mem_size = 64;
> +	mbx->pf2vf_mbox_ctrl_base = 0x2aa00;
> +	mbx->pf_vf_mbox_mask_lo = 0x2ab00;
> +	mbx->pf_vf_mbox_mask_hi = 0;
> +	mbx->fw_pf_shm_base = 0x2d900;
> +	mbx->pf2fw_mbox_ctrl = 0x2e900;
> +	mbx->fw_pf_mbox_mask = 0x2eb00;
> +	mbx->fw_vf_share_ram = 0x2b900;
> +	mbx->share_size = 512;
> +	/* update hw feature */
> +	hw->feature_flags |= M_HW_FEATURE_EEE;
> +	hw->usecstocount = 62;

This variant does not have an MDIO bus?

> +#define RNPGBE_RING_BASE (0x1000)
> +#define RNPGBE_MAC_BASE (0x20000)
> +#define RNPGBE_ETH_BASE (0x10000)

Please drop all the () on plain constants. You only need () when it is
an expression.

> +			      const struct rnpgbe_info *ii)

I don't really see how the variable name ii has anything to do with
rnpgbe_info. I know naming is hard, but why not call it info?


>  {
>  	struct mucse *mucse = NULL;
> +	struct mucse_hw *hw = NULL;
> +	u8 __iomem *hw_addr = NULL;
>  	struct net_device *netdev;
>  	static int bd_number;
> +	u32 dma_version = 0;
> +	int err = 0;
> +	u32 queues;
>  
> -	netdev = alloc_etherdev_mq(sizeof(struct mucse), 1);
> +	queues = ii->total_queue_pair_cnts;
> +	netdev = alloc_etherdev_mq(sizeof(struct mucse), queues);

I pointed out this before. Try to avoid changing code added in
previous patches. I just wasted time looking up what the function is
called which allocates a single queue, and writing a review comment.

Waiting reviewers time is a good way to get less/slower reviews.

	Andrew

