Return-Path: <netdev+bounces-215476-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 868C4B2EBAE
	for <lists+netdev@lfdr.de>; Thu, 21 Aug 2025 05:07:29 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 41AE71C87B9A
	for <lists+netdev@lfdr.de>; Thu, 21 Aug 2025 03:07:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2B2002D4B7F;
	Thu, 21 Aug 2025 03:07:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b="MQ57fu+t"
X-Original-To: netdev@vger.kernel.org
Received: from vps0.lunn.ch (vps0.lunn.ch [156.67.10.101])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9E47F277C90;
	Thu, 21 Aug 2025 03:07:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=156.67.10.101
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755745644; cv=none; b=lCLNPAWngexgsYhq+AQX60yBbA13cQMTRq/JJ7tQ1rrltuoAMxsRktnKfXgwWy2PBCnZVzYg97CBc06X+74x42DLXbYjN7o/4VQToUlvly8vlgLjwkMP5jzCbw0CyHNBOjvai3IhR7sh1rS+bXejbaSonhvihFONF7LcbhqHpkc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755745644; c=relaxed/simple;
	bh=kNtl7aaIov48PZW8RnkouC5yMH/0vKwj8089QgZo/xg=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=rl/G9ySPimMWhSD3r3XOE/GrpMZ7jmxPy3TKD2R5CEeEk4o5cp0wXqZB8ZAOtF1GHISqbWYSR9NiHnxdvePeMRxrFmiSk+40Uyn2D4UmWB1n/POIBnstdmgq1poDfNkoyppNIiUtJjbfGRVijJCHJar1IPrRk1Yd3+Ww8vWUO6Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch; spf=pass smtp.mailfrom=lunn.ch; dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b=MQ57fu+t; arc=none smtp.client-ip=156.67.10.101
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lunn.ch
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=lunn.ch;
	s=20171124; h=In-Reply-To:Content-Disposition:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:From:Sender:Reply-To:Subject:
	Date:Message-ID:To:Cc:MIME-Version:Content-Type:Content-Transfer-Encoding:
	Content-ID:Content-Description:Content-Disposition:In-Reply-To:References;
	bh=P0a1IzO9BpfonDm6AwhGWLiKp//cCmUP156Hl+GNrao=; b=MQ57fu+t08HIKhylo5imqYm+F0
	8cPEUJV6jckfZL7F2Nd6nCCAzEVxXRe29kZSycLOUuPEBuLsXkatl4suXs2Cw0YIKLw/UL1KVmArF
	4CYmczIVDOc0iBINoqma2Ghjfg5Gw4G/YP/MxlNw3rjuUFpgY8MUeIXozSaOOcOMeZ8s=;
Received: from andrew by vps0.lunn.ch with local (Exim 4.94.2)
	(envelope-from <andrew@lunn.ch>)
	id 1uovda-005P2U-8O; Thu, 21 Aug 2025 05:06:50 +0200
Date: Thu, 21 Aug 2025 05:06:50 +0200
From: Andrew Lunn <andrew@lunn.ch>
To: Yibo Dong <dong100@mucse.com>
Cc: andrew+netdev@lunn.ch, davem@davemloft.net, edumazet@google.com,
	kuba@kernel.org, pabeni@redhat.com, horms@kernel.org,
	corbet@lwn.net, gur.stavi@huawei.com, maddy@linux.ibm.com,
	mpe@ellerman.id.au, danishanwar@ti.com, lee@trager.us,
	gongfan1@huawei.com, lorenzo@kernel.org, geert+renesas@glider.be,
	Parthiban.Veerasooran@microchip.com, lukas.bulwahn@redhat.com,
	alexanderduyck@fb.com, richardcochran@gmail.com,
	netdev@vger.kernel.org, linux-doc@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH v5 3/5] net: rnpgbe: Add basic mbx ops support
Message-ID: <f0c9aee0-0e57-429e-8918-d91bf307018e@lunn.ch>
References: <20250818112856.1446278-1-dong100@mucse.com>
 <20250818112856.1446278-4-dong100@mucse.com>
 <5cced097-52db-41c9-93e4-927aab5ffb2e@lunn.ch>
 <6981CF6C1312658E+20250821014411.GB1742451@nic-Precision-5820-Tower>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <6981CF6C1312658E+20250821014411.GB1742451@nic-Precision-5820-Tower>

On Thu, Aug 21, 2025 at 09:44:11AM +0800, Yibo Dong wrote:
> On Wed, Aug 20, 2025 at 10:23:44PM +0200, Andrew Lunn wrote:
> > > +/**
> > > + * mucse_mbx_get_ack - Read ack from reg
> > > + * @mbx: pointer to the MBX structure
> > > + * @reg: register to read
> > > + *
> > > + * @return: the ack value
> > > + **/
> > > +static u16 mucse_mbx_get_ack(struct mucse_mbx_info *mbx, int reg)
> > > +{
> > > +	return (mbx_data_rd32(mbx, reg) >> 16);
> > > +}
> > 
> > > +static int mucse_check_for_ack_pf(struct mucse_hw *hw)
> > > +{
> > > +	struct mucse_mbx_info *mbx = &hw->mbx;
> > > +	u16 hw_fw_ack;
> > > +
> > > +	hw_fw_ack = mucse_mbx_get_ack(mbx, MBX_FW2PF_COUNTER);
> > 
> > > +int mucse_write_mbx_pf(struct mucse_hw *hw, u32 *msg, u16 size)
> > > +{
> > > +	struct mucse_mbx_info *mbx = &hw->mbx;
> > > +	int size_inwords = size / 4;
> > > +	u32 ctrl_reg;
> > > +	int ret;
> > > +	int i;
> > > +
> > > +	ctrl_reg = PF2FW_MBOX_CTRL(mbx);
> > > +	ret = mucse_obtain_mbx_lock_pf(hw);
> > > +	if (ret)
> > > +		return ret;
> > > +
> > > +	for (i = 0; i < size_inwords; i++)
> > > +		mbx_data_wr32(mbx, MBX_FW_PF_SHM_DATA + i * 4, msg[i]);
> > > +
> > > +	/* flush msg and acks as we are overwriting the message buffer */
> > > +	hw->mbx.fw_ack = mucse_mbx_get_ack(mbx, MBX_FW2PF_COUNTER);
> > 
> > It seems like the ACK is always at MBX_FW2PF_COUNTER. So why pass it
> > to mucse_mbx_get_ack()? Please look at your other getters and setters.
> > 
> 
> 'mucse_mbx_get_ack' is always at MBX_FW2PF_COUNTER now, just for pf-fw mbx. 
> But, in the future, there will be pf-vf mbx with different input.
> Should I move 'MBX_FW2PF_COUNTER' to function 'mucse_mbx_get_ack', and
> update the function when I add vf relative code in the future?

Maybe add mucse_mbx_get_pf_ack() so you can later add
mucse_mbx_get_vf_ack()?

The problem is, our crystal ball about what will come next is not very
good. So we review the code we see now, and make comments about it
now. You can add comments explaining why something is the way it is
because in the future it needs to be more generic to handle additional
use cases, etc. Or explain in the commit message.

	Andrew

