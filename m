Return-Path: <netdev+bounces-219914-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 4EC72B43B05
	for <lists+netdev@lfdr.de>; Thu,  4 Sep 2025 14:07:01 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id A29507C09B8
	for <lists+netdev@lfdr.de>; Thu,  4 Sep 2025 12:06:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C119627A468;
	Thu,  4 Sep 2025 12:06:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b="nh5P79LU"
X-Original-To: netdev@vger.kernel.org
Received: from vps0.lunn.ch (vps0.lunn.ch [156.67.10.101])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1F89E2D46CB;
	Thu,  4 Sep 2025 12:06:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=156.67.10.101
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756987608; cv=none; b=kJnsugm6Ua7MQ/mYzsDE1BPlQy3Uh3i4aTdJTR6i/bEV556Y9uLxKzz7SuNMYvztUASJxtof2CLZeZjR4n76N6bbPq31VWO6Q2Oz2XnUBxhnZ+zRoHraXVWoqnW/hYaBftAeNXCgnRanfjRHQ3iq1rZ1JB2cYWMteoio/0lY+5Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756987608; c=relaxed/simple;
	bh=zm6TgX3Aox2Z8s6DkfbhHOfphs227t+gV7W3lLhyTH4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=cGR9KTm1hQmYcA4s+fmwKelB79pySQtIj6EQyblM9NEtHpRPK1xl8A18NdN46rPvwIz4PckvmehhaM5w1dymU14YG+Y6J7ih0G6AEVJx22NlXWWV+ssENR2GPmXWWmUrr9IQ1qWK28Ki/K7R1L9LN81TLI9OSj7lsUEDn763vHQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch; spf=pass smtp.mailfrom=lunn.ch; dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b=nh5P79LU; arc=none smtp.client-ip=156.67.10.101
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lunn.ch
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=lunn.ch;
	s=20171124; h=In-Reply-To:Content-Disposition:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:From:Sender:Reply-To:Subject:
	Date:Message-ID:To:Cc:MIME-Version:Content-Type:Content-Transfer-Encoding:
	Content-ID:Content-Description:Content-Disposition:In-Reply-To:References;
	bh=Q6zB9wLfiY9Hs3Un4C3qmCTS/PiHSKuEFiLPwa5uEto=; b=nh5P79LUM5K7UPQrw9Fspa9Okw
	rgLr8cre0Zx9XGUMocgS+OYS6ryui6WQs/46bg7gPHs5fninFgGY+P5texlmXQaLZWoEcL/PEYn9p
	fSD2nXW4ZR5E2lGKH53mpj+FKT4nWXja2XiF9yONXdOlX5xrqkWIOVG/2Fac5LZAERe8=;
Received: from andrew by vps0.lunn.ch with local (Exim 4.94.2)
	(envelope-from <andrew@lunn.ch>)
	id 1uu8j0-007Ciq-0Z; Thu, 04 Sep 2025 14:05:58 +0200
Date: Thu, 4 Sep 2025 14:05:57 +0200
From: Andrew Lunn <andrew@lunn.ch>
To: Yibo Dong <dong100@mucse.com>
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
Subject: Re: [PATCH net-next v10 3/5] net: rnpgbe: Add basic mbx ops support
Message-ID: <908e4c95-81cb-4a95-9235-2d2c8c80d80c@lunn.ch>
References: <20250903025430.864836-1-dong100@mucse.com>
 <20250903025430.864836-4-dong100@mucse.com>
 <659df824-7509-4ffe-949b-187d7d44f69f@lunn.ch>
 <AF92025D9CBFCF3B+20250904031948.GA1022066@nic-Precision-5820-Tower>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <AF92025D9CBFCF3B+20250904031948.GA1022066@nic-Precision-5820-Tower>

On Thu, Sep 04, 2025 at 11:19:48AM +0800, Yibo Dong wrote:
> On Thu, Sep 04, 2025 at 12:24:17AM +0200, Andrew Lunn wrote:
> > >  struct mucse_mbx_info {
> > > +	struct mucse_mbx_stats stats;
> > > +	u32 timeout;
> > > +	u32 usec_delay;
> > > +	u16 size;
> > > +	u16 fw_req;
> > > +	u16 fw_ack;
> > > +	/* lock for only one use mbx */
> > > +	struct mutex lock;
> > >  	/* fw <--> pf mbx */
> > >  	u32 fw_pf_shm_base;
> > >  	u32 pf2fw_mbox_ctrl;
> > 
> > > +/**
> > > + * mucse_obtain_mbx_lock_pf - Obtain mailbox lock
> > > + * @hw: pointer to the HW structure
> > > + *
> > > + * This function maybe used in an irq handler.
> > > + *
> > > + * Return: 0 if we obtained the mailbox lock or else -EIO
> > > + **/
> > > +static int mucse_obtain_mbx_lock_pf(struct mucse_hw *hw)
> > > +{
> > > +	struct mucse_mbx_info *mbx = &hw->mbx;
> > > +	int try_cnt = 5000;
> > > +	u32 reg;
> > > +
> > > +	reg = PF2FW_MBOX_CTRL(mbx);
> > > +	while (try_cnt-- > 0) {
> > > +		mbx_ctrl_wr32(mbx, reg, MBOX_PF_HOLD);
> > > +		/* force write back before check */
> > > +		wmb();
> > > +		if (mbx_ctrl_rd32(mbx, reg) & MBOX_PF_HOLD)
> > > +			return 0;
> > > +		udelay(100);
> > > +	}
> > > +	return -EIO;
> > > +}
> > 
> > If there is a function which obtains a lock, there is normally a
> > function which releases a lock. But i don't see it.
> > 
> 
> The lock is relased when send MBOX_CTRL_REQ in mucse_write_mbx_pf:
> 
> mbx_ctrl_wr32(mbx, ctrl_reg, MBOX_CTRL_REQ);
> 
> Set MBOX_PF_HOLD(bit3) to hold the lock, clear bit3 to release, and set
> MBOX_CTRL_REQ(bit0) to send the req. req and lock are different bits in
> one register. So we send the req along with releasing lock (set bit0 and
> clear bit3).
> Maybe I should add comment like this?
> 
> /* send the req along with releasing the lock */
> mbx_ctrl_wr32(mbx, ctrl_reg, MBOX_CTRL_REQ);

As i said, functions like this come in pairs. obtain/release,
lock/unlock. When reading code, you want to be able to see both of the
pair in a function, to know the unlock is not missing. The kernel even
has tools which will validate all paths through a function releasing
locks. Often error paths get this wrong.

So please make this a function, give it a name which makes it obvious
it is the opposite of mucse_obtain_mbx_lock_pf().

	Andrew

