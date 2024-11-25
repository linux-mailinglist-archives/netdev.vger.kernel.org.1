Return-Path: <netdev+bounces-147236-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 198369D8841
	for <lists+netdev@lfdr.de>; Mon, 25 Nov 2024 15:42:10 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 59402B2AB47
	for <lists+netdev@lfdr.de>; Mon, 25 Nov 2024 14:40:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DC4FB1B0F2D;
	Mon, 25 Nov 2024 14:40:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b="3P6gKlf4"
X-Original-To: netdev@vger.kernel.org
Received: from vps0.lunn.ch (vps0.lunn.ch [156.67.10.101])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A812116419;
	Mon, 25 Nov 2024 14:40:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=156.67.10.101
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732545607; cv=none; b=XzDnJnjjLLtHEhEjygS0vMXCWV+BYCEMkoiz/Hs1AeDOCZ1ZDwS8FmWuh0pJBXY03hb+Sj90G60WHiGinIRR5mKDlRBBLjcgRNjd3mvjkzMk3JysksKVRMJO21rPHlxBSwYFq72jme/VzFu28TVUGKom6TY+Reegb3HEAthy5yk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732545607; c=relaxed/simple;
	bh=no0iSacVIbqAzRpeeuWFxDaWomFW1YKjQT7MAj8tdb0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=MV9Qb3eXgfKBvSjuw7gpmCnYBnP8ZfWRwF9Dy5GhcmBKI3diTZDc3G7LwDKErosTYWP+WMT76uEKOx89xgq87eyws5I3e3ydntZG7FkHF2vgaZNGk8LmAYC5EktYZ6e+IDl6cPByhRoUFbLzFju1ll3xX3RBEyJvkAEBxwKj27c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch; spf=pass smtp.mailfrom=lunn.ch; dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b=3P6gKlf4; arc=none smtp.client-ip=156.67.10.101
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lunn.ch
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=lunn.ch;
	s=20171124; h=In-Reply-To:Content-Disposition:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:From:Sender:Reply-To:Subject:
	Date:Message-ID:To:Cc:MIME-Version:Content-Type:Content-Transfer-Encoding:
	Content-ID:Content-Description:Content-Disposition:In-Reply-To:References;
	bh=CbRa1KYMMLQGdG25mz0RDUzqlaf9wwEr5gH4UxtL00A=; b=3P6gKlf4cmZSVMzg3cEfPS3Hck
	Uw0GfpfUqPOakxo9mVjPLxeKL2k+XjJt6QjdmqJrFxdNjMIQj/uqPex00LoJohjxpSjyHZrrAxeZq
	UZRDv2OWhaTqJP8E+9AkTU3PIw+f9Rm25eq3uXqhHEDtM95Xb48CKIsL7Yyg4gJABzC8=;
Received: from andrew by vps0.lunn.ch with local (Exim 4.94.2)
	(envelope-from <andrew@lunn.ch>)
	id 1tFaFp-00EOnk-R5; Mon, 25 Nov 2024 15:39:57 +0100
Date: Mon, 25 Nov 2024 15:39:57 +0100
From: Andrew Lunn <andrew@lunn.ch>
To: Frank Sae <Frank.Sae@motor-comm.com>
Cc: davem@davemloft.net, edumazet@google.com, kuba@kernel.org,
	pabeni@redhat.com, netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org, xiaogang.fan@motor-comm.com,
	fei.zhang@motor-comm.com, hua.sun@motor-comm.com
Subject: Re: [PATCH net-next v2 09/21] motorcomm:yt6801: Implement some
 hw_ops function
Message-ID: <cd57707a-2d7e-4549-aab1-d0bd6c24ad35@lunn.ch>
References: <20241120105625.22508-1-Frank.Sae@motor-comm.com>
 <20241120105625.22508-10-Frank.Sae@motor-comm.com>
 <46206a81-e230-411c-8a78-d461d238b171@lunn.ch>
 <11e26658-670f-49fa-8001-0654670b541e@motor-comm.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <11e26658-670f-49fa-8001-0654670b541e@motor-comm.com>

On Mon, Nov 25, 2024 at 05:49:19PM +0800, Frank Sae wrote:
> Hi Andrew,
> 
> On 2024/11/23 09:03, Andrew Lunn wrote:
> > It took a lot of effort to find your MDIO code. And MDIO bus driver
> > makes a good patch on its own.
> > 
> 
> Sorry about that.
> There is too many codes in yt6801_hw.c file. If I put the MDIO bus driver
> in one patch, it's would be very difficult to limit to 15 patches. 

You can easily limit this to 15 patches. Throw away 75% of the driver
for the moment. Do enough to get link and then send/receive
frames. Forget the rest. You don't need statistics, ethtool, WoL, and
everything else in the first submission. They can all be added later.

You need reviewers in order to get your driver merged. If you give
them a huge driver which is hard to find what they are interested in,
they won't review it, and it will not get merged. So break it up into
a number of patchsets. A minimum driver to just send/receive should be
nice and small, and can be split into 15 patches making it nice and
easy to find bits reviewers are interested in. That should get
reviewed and merged. Then add more and more features in nice small
chunks which are easy to review.

> >> +static int mdio_loop_wait(struct fxgmac_pdata *pdata, u32 max_cnt)
> >> +{
> >> +	u32 val, i;
> >> +
> >> +	for (i = 0; i < max_cnt; i++) {
> >> +		val = rd32_mac(pdata, MAC_MDIO_ADDRESS);
> >> +		if ((val & MAC_MDIO_ADDR_BUSY) == 0)
> >> +			break;
> >> +
> >> +		fsleep(10);
> >> +	}
> >> +
> >> +	if (i >= max_cnt) {
> >> +		WARN_ON(1);
> >> +		yt_err(pdata, "%s timeout. used cnt:%d, reg_val=%x.\n",
> >> +		       __func__, i + 1, val);
> >> +
> >> +		return -ETIMEDOUT;
> >> +	}
> > 
> > Please replace this using one of the helpers in
> > include/linux/iopoll.h.
> > 
> >> +#define PHY_WR_CONFIG(reg_offset)		(0x8000205 + ((reg_offset) * 0x10000))
> >> +static int fxgmac_phy_write_reg(struct fxgmac_pdata *pdata, u32 reg_id, u32 data)
> >> +{
> >> +	int ret;
> >> +
> >> +	wr32_mac(pdata, data, MAC_MDIO_DATA);
> >> +	wr32_mac(pdata, PHY_WR_CONFIG(reg_id), MAC_MDIO_ADDRESS);
> >> +	ret = mdio_loop_wait(pdata, PHY_MDIO_MAX_TRY);
> >> +	if (ret < 0)
> >> +		return ret;
> >> +
> >> +	yt_dbg(pdata, "%s, id:%x %s, ctrl:0x%08x, data:0x%08x\n", __func__,
> >> +	       reg_id, (ret == 0) ? "ok" : "err", PHY_WR_CONFIG(reg_id), data);
> >> +
> >> +	return ret;
> >> +}
> >> +
> >> +#define PHY_RD_CONFIG(reg_offset)		(0x800020d + ((reg_offset) * 0x10000))
> >> +static int fxgmac_phy_read_reg(struct fxgmac_pdata *pdata, u32 reg_id)
> >> +{
> >> +	u32 val;
> >> +	int ret;
> >> +
> >> +	wr32_mac(pdata, PHY_RD_CONFIG(reg_id), MAC_MDIO_ADDRESS);
> >> +	ret =  mdio_loop_wait(pdata, PHY_MDIO_MAX_TRY);
> >> +	if (ret < 0)
> >> +		return ret;
> >> +
> >> +	val = rd32_mac(pdata, MAC_MDIO_DATA);  /* Read data */
> >> +	yt_dbg(pdata, "%s, id:%x ok, ctrl:0x%08x, val:0x%08x.\n", __func__,
> >> +	       reg_id, PHY_RD_CONFIG(reg_id), val);
> >> +
> >> +	return val;
> >> +}
> > 
> > And where is the rest of the MDIO bus driver?
> 
> There is no separate reset of MDIO bus driver.

rest, not reset.

An MDIO driver is generally two to five functions to do bus
transactions, and then one or two functions to allocate the bus
structure, fill in the members and register the bus, and maybe a
function to undo that. I would expect these all to be in one
patch. They are not.

At some point, you need to justify your hw_ops structure. Why do you
have this? At the moment it just obfuscate the code. Maybe there is a
good reason for it, but given the size of the driver i've not been
able to find it.

> >> +#define LINK_DOWN	0x800
> >> +#define LINK_UP		0x400
> >> +#define LINK_CHANGE	(LINK_DOWN | LINK_UP)
> >> +	if ((stats_pre & LINK_CHANGE) != (stats & LINK_CHANGE)) {
> >> +		yt_dbg(pdata, "phy link change\n");
> >> +		return 1;
> >> +	}
> >> +
> >> +	return 0;
> >> +unlock:
> >> +	phy_unlock_mdio_bus(pdata->phydev);
> >> +	yt_err(pdata, "fxgmac_phy_read_reg err!\n");
> >> +	return  -ETIMEDOUT;
> >> +}
> > 
> > You need to rework your PHY interrupt handling. The PHY driver is
> > responsible for handing the interrupt registers in the PHY. Ideally
> > you just want to export an interrupt to phylib, so it can do all the
> > work.
> 
> I'm sorry. Could you please give me more information about export
>  an interrupt to phylib?

I would actually suggest you first just let phylib poll the PHY. That
gets you something working. You can add interrupt support in a later
patchset. For ideas, look at ksz_common.c:

ds->user_mii_bus->irq[phy] = irq;

You have a whole tree of source code you can look at, there are other
examples of MAC drivers exporting an interrupt controller. And you
might find other ways to do this, look at other MAC drivers. There is
nothing special here, so don't invent something new, copy what other
MAC drivers do.


	Andrew

