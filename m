Return-Path: <netdev+bounces-204562-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 9775CAFB2EE
	for <lists+netdev@lfdr.de>; Mon,  7 Jul 2025 14:10:01 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 2AB77189CDBD
	for <lists+netdev@lfdr.de>; Mon,  7 Jul 2025 12:10:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E666329AAF9;
	Mon,  7 Jul 2025 12:09:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b="iwLNMnL5"
X-Original-To: netdev@vger.kernel.org
Received: from vps0.lunn.ch (vps0.lunn.ch [156.67.10.101])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 09E6D29A9ED;
	Mon,  7 Jul 2025 12:09:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=156.67.10.101
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751890196; cv=none; b=eo0l+OS4cumOQ2YzNKUeIqT7FmYcIhVM9ainxer46MplUEZE06Unat+g2PCMmUl4PGVrrEZoYliZVOAEyDA9jUdJVDm1MKCbvFTG/Q5Awgs+wRgm9A8m7wgNDjNRy08/3WaI3B4glEP5dRCfL9nuPdyl/PwDoYiNNrqw+xxuWPg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751890196; c=relaxed/simple;
	bh=WFhdIKgugKGah05NOZFe35YaFk/IGcydxloP193R58w=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=uprL78Ff1dbM3LqI4yP335zMEpsK+t3XGFT2fcIIJfR1Lw8PmoLI0hE0QampnzONvzpZAM2FclE9YzO07b/q6eAfgDVoZd5T0KmV2urqe4bQOH4rV7Mlbgqk7Y7fRCduCvcUZfc94KzANoUCVPYEDo1SzkIq+hzZ7sQub4EuKjY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch; spf=pass smtp.mailfrom=lunn.ch; dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b=iwLNMnL5; arc=none smtp.client-ip=156.67.10.101
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lunn.ch
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=lunn.ch;
	s=20171124; h=In-Reply-To:Content-Disposition:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:From:Sender:Reply-To:Subject:
	Date:Message-ID:To:Cc:MIME-Version:Content-Type:Content-Transfer-Encoding:
	Content-ID:Content-Description:Content-Disposition:In-Reply-To:References;
	bh=XEtC+wRhm6PC1IQQS5E7xcerOENVh/DYiOue9pVWljE=; b=iwLNMnL5wcAawTja01YDdDmjju
	udQ9iDbTRGBFqafLcH1KFnPSPOmA5n9KUFgfmk+QdFye5lpAuhQj984chMKsVeWzW1FWm1zd1bQdm
	FTxWZjXAbgH+kNi16ZekOrY+C2xE85OD/5YZv2OBMe+ywmI3bu5AUTKE6eqSfC6hD2rY=;
Received: from andrew by vps0.lunn.ch with local (Exim 4.94.2)
	(envelope-from <andrew@lunn.ch>)
	id 1uYkex-000i4f-TV; Mon, 07 Jul 2025 14:09:23 +0200
Date: Mon, 7 Jul 2025 14:09:23 +0200
From: Andrew Lunn <andrew@lunn.ch>
To: Yibo Dong <dong100@mucse.com>
Cc: davem@davemloft.net, edumazet@google.com, kuba@kernel.org,
	pabeni@redhat.com, horms@kernel.org, corbet@lwn.net,
	andrew+netdev@lunn.ch, gur.stavi@huawei.com, maddy@linux.ibm.com,
	mpe@ellerman.id.au, danishanwar@ti.com, lee@trager.us,
	gongfan1@huawei.com, lorenzo@kernel.org, geert+renesas@glider.be,
	Parthiban.Veerasooran@microchip.com, lukas.bulwahn@redhat.com,
	alexanderduyck@fb.com, netdev@vger.kernel.org,
	linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 04/15] net: rnpgbe: Add get_capability mbx_fw ops support
Message-ID: <e0610a11-18fa-42f6-9925-f15dac20643c@lunn.ch>
References: <20250703014859.210110-1-dong100@mucse.com>
 <20250703014859.210110-5-dong100@mucse.com>
 <57497e14-3f9a-4da8-9892-ed794aadbf47@lunn.ch>
 <CB185D75E8EDC84A+20250707073743.GA164527@nic-Precision-5820-Tower>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CB185D75E8EDC84A+20250707073743.GA164527@nic-Precision-5820-Tower>

On Mon, Jul 07, 2025 at 03:37:43PM +0800, Yibo Dong wrote:
> On Fri, Jul 04, 2025 at 08:25:12PM +0200, Andrew Lunn wrote:
> > > +/**
> > > + * mucse_fw_send_cmd_wait - Send cmd req and wait for response
> > > + * @hw: Pointer to the HW structure
> > > + * @req: Pointer to the cmd req structure
> > > + * @reply: Pointer to the fw reply structure
> > > + *
> > > + * mucse_fw_send_cmd_wait sends req to pf-cm3 mailbox and wait
> > > + * reply from fw.
> > > + *
> > > + * Returns 0 on success, negative on failure
> > > + **/
> > > +static int mucse_fw_send_cmd_wait(struct mucse_hw *hw,
> > > +				  struct mbx_fw_cmd_req *req,
> > > +				  struct mbx_fw_cmd_reply *reply)
> > > +{
> > > +	int err;
> > > +	int retry_cnt = 3;
> > > +
> > > +	if (!hw || !req || !reply || !hw->mbx.ops.read_posted)
> > 
> > Can this happen?
> > 
> > If this is not supposed to happen, it is better the driver opps, so
> > you get a stack trace and find where the driver is broken.
> > 
> Yes, it is not supposed to happen. So, you means I should remove this
> check in order to get opps when this condition happen?

You should remove all defensive code. Let is explode with an Opps, so
you can find your bugs.

> > > +		return -EINVAL;
> > > +
> > > +	/* if pcie off, nothing todo */
> > > +	if (pci_channel_offline(hw->pdev))
> > > +		return -EIO;
> > 
> > What can cause it to go offline? Is this to do with PCIe hotplug?
> > 
> Yes, I try to get a PCIe hotplug condition by 'pci_channel_offline'.
> If that happens, driver should never do bar-read/bar-write, so return
> here.

I don't know PCI hotplug too well, but i assume the driver core will
call the .release function. Can this function be called as part of
release? What actually happens on the PCI bus when you try to access a
device which no longer exists?

How have you tested this? Do you have the ability to do a hot{un}plug?

> > > +	if (mutex_lock_interruptible(&hw->mbx.lock))
> > > +		return -EAGAIN;
> > 
> > mutex_lock_interruptable() returns -EINTR, which is what you should
> > return, not -EAGAIN.
> > 
> Got it, I should return '-EINTR' here.

No, you should return whatever mutex_lock_interruptable()
returns. Whenever you call a function which returns an error code, you
should pass that error code up the call stack. Never replace one error
code with another.

> > > +	if (reply->error_code)
> > > +		return -reply->error_code;
> > 
> > The mbox is using linux error codes? 
> > 
> It is used only between driver and fw, yay be just samply like this: 
> 0     -- no error
> not 0 -- error
> So, it is not using linux error codes.

Your functions should always use linux/POSIX error codes. So if your
firmware says an error has happened, turn it into a linux/POSIX error
code. EINVAL, TIMEDOUT, EIO, whatever makes the most sense.

	Andrew

