Return-Path: <netdev+bounces-208962-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id A6B7EB0DBA8
	for <lists+netdev@lfdr.de>; Tue, 22 Jul 2025 15:52:07 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id D18491C81FB4
	for <lists+netdev@lfdr.de>; Tue, 22 Jul 2025 13:51:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8EDD42EA46C;
	Tue, 22 Jul 2025 13:51:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b="gAPKCB4y"
X-Original-To: netdev@vger.kernel.org
Received: from vps0.lunn.ch (vps0.lunn.ch [156.67.10.101])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6404C2EA173;
	Tue, 22 Jul 2025 13:51:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=156.67.10.101
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753192269; cv=none; b=gkfeJNh4cSVzZ3RhLjs+QgT1ftt8fC1tyfKBQ4apOf1kiigMZxp713utmwl6HV47V1bcCmK1+06jLGG7qw33wyMxGdRfFP43nS0WC4ed5xAMIQGz9/YQXjegb6tmGWtyeCBDw8ILSsjvU9h8Y2bBm97MRLldtUaE++2nJePw3vI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753192269; c=relaxed/simple;
	bh=8SKeMCUHYITmh0DCa2M2vePU3JIcnv9oLryaCLOLIcY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=b2wzNWfihZNX42xE1ugnQypc8CLsCM4OHWR/x6frXOyIAXCVvcQiCvZBN9yztna8CvDYQAR2LznQZ3/3MR94duOksxW3WFqn3TY2wguhIX53OjylR4cnmHgAN4akmDHqt+ihSlGDyecutjnMAdwsuS/+HiIVcPaQExenOoB8pXQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch; spf=pass smtp.mailfrom=lunn.ch; dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b=gAPKCB4y; arc=none smtp.client-ip=156.67.10.101
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lunn.ch
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=lunn.ch;
	s=20171124; h=In-Reply-To:Content-Disposition:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:From:Sender:Reply-To:Subject:
	Date:Message-ID:To:Cc:MIME-Version:Content-Type:Content-Transfer-Encoding:
	Content-ID:Content-Description:Content-Disposition:In-Reply-To:References;
	bh=6oapWZ27mSslcABG6IClxIx3Ur53GIaWKsw6y3o+rjQ=; b=gAPKCB4yV286JvypVEywMm7qnV
	4Njy0vqxTckWgl0dKmgkIlziDSZ5wkhkLmqglOlpgEd9SQ2xzqpy5M8Alqbgj/rc7GfgQdCMa2/m2
	Hi1SLYj5K1w8foR/e/YZvRVvxsyTrwJJ6qyaA+Uxo5pRa4qO4e2fwc8888CXNU8+OVgQ=;
Received: from andrew by vps0.lunn.ch with local (Exim 4.94.2)
	(envelope-from <andrew@lunn.ch>)
	id 1ueDNZ-002TFP-RI; Tue, 22 Jul 2025 15:50:01 +0200
Date: Tue, 22 Jul 2025 15:50:01 +0200
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
Subject: Re: [PATCH v2 03/15] net: rnpgbe: Add basic mbx ops support
Message-ID: <942d3782-16af-4b20-9480-9bdf2d6a1222@lunn.ch>
References: <20250721113238.18615-1-dong100@mucse.com>
 <20250721113238.18615-4-dong100@mucse.com>
 <e66591a1-0ffa-4135-9347-52dc7745728f@lunn.ch>
 <D81C71402E58DF29+20250722064530.GC99399@nic-Precision-5820-Tower>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <D81C71402E58DF29+20250722064530.GC99399@nic-Precision-5820-Tower>

On Tue, Jul 22, 2025 at 02:45:30PM +0800, Yibo Dong wrote:
> On Mon, Jul 21, 2025 at 05:43:41PM +0200, Andrew Lunn wrote:
> > >  #define MAX_VF_NUM (8)
> > 
> > > +	hw->max_vfs = 7;
> > 
> > ???
> 
> This is mistake, max vfs is 7. 8 is '7 vfs + 1 pf'.

So it seems like you need to add a new #define for MAX_FUNCS_NUM, and
set MAX_VF_NUM to 7. And then actually use MAX_VP_NUM. When reviewing
your own code, seeing the number 7, not a define, should of been a
warning, something is wrong....

> > > +static int mucse_obtain_mbx_lock_pf(struct mucse_hw *hw, enum MBX_ID mbx_id)
> > > +{
> > > +	struct mucse_mbx_info *mbx = &hw->mbx;
> > > +	int try_cnt = 5000, ret;
> > > +	u32 reg;
> > > +
> > > +	reg = (mbx_id == MBX_FW) ? PF2FW_MBOX_CTRL(mbx) :
> > > +				   PF2VF_MBOX_CTRL(mbx, mbx_id);
> > > +	while (try_cnt-- > 0) {
> > > +		/* Take ownership of the buffer */
> > > +		mbx_wr32(hw, reg, MBOX_PF_HOLD);
> > > +		/* force write back before check */
> > > +		wmb();
> > > +		if (mbx_rd32(hw, reg) & MBOX_PF_HOLD)
> > > +			return 0;
> > > +		udelay(100);
> > > +	}
> > > +	return ret;
> > 
> > I've not compiled this, but isn't ret uninitialized here? I would also
> > expect it to return -ETIMEDOUT?
> > 
> > 	Andrew
> > 
> 
> Yes, ret is uninitialized. I will fix this.

Did the compiler give a warning? Code should be warning free. We also
expect networking code to be W=1 warning free.

	Andrew

