Return-Path: <netdev+bounces-234072-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 66906C1C3DC
	for <lists+netdev@lfdr.de>; Wed, 29 Oct 2025 17:51:46 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id ED4AC1A260F3
	for <lists+netdev@lfdr.de>; Wed, 29 Oct 2025 16:46:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7586A21FF26;
	Wed, 29 Oct 2025 16:45:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="jK9fpv70"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3628C38F80;
	Wed, 29 Oct 2025 16:45:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761756310; cv=none; b=G4pmuN6Ix1U1s5Wz8tASspWlebryV9YVU41RQndy6Njabrk42sCJ1908QcNN0jr6cUbMHViumqDPWC+6guI7XePsb48GwdiSKUMdXEhqGfRmPP3xTtyFkrZPGMqoJsHBNo+m542CTeJi00eoza5smJEwbMVe2HnUnQJ2Yk53cMA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761756310; c=relaxed/simple;
	bh=+9gg7rn44lizaoclLJSB8lUPlTbltT6sxxRz/mnAro4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=ZFoY9uhC8h27HhR5K91jc3vQdcqmzz6VmJiQY2hCW/GXlxapp9zjvW+5iycY+pwln46AOJs4YnqsfDQu5218UDVhvO6qM2Y1cj7SvtSWIOecUFw4YtpSFq9R7MHdrjDUbP59AxhMWRbSGMxkPT/i4evRYVNLCXjItsUjzUm2M/c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=jK9fpv70; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id BBF57C4CEF7;
	Wed, 29 Oct 2025 16:45:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1761756309;
	bh=+9gg7rn44lizaoclLJSB8lUPlTbltT6sxxRz/mnAro4=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=jK9fpv70YcfZdgLOhNmPwcTSlUpTa8m+mdtrTzJdDLKPBKPDpv58daFIb8cYQAWOT
	 uBkDf8D/48Xb2FEyJjtRqVYV+zTHLJgSADEFJ8PCSEX69PWYwOoyZhMNNTIQ4ltTiv
	 VulKZ7o/sogLTISuAfWgQBCviOc0qSZiEDVHzv6xbE9wQEqCaGG40UFzh/jp/BYSVJ
	 XRj/gEBOWFDZdc7q1Rwu97H7HP/SnTV35CvqpNnEk/iyHoE/auniPq7rfe5OT9Q/jB
	 yZGaYPSJxEhe2GXRR5PJjIPG7p0pCDKPpf9y7cK00C7yKMkqSfLRC9uxc2Qfv4Dhu0
	 vfN4QLBETlECw==
Date: Wed, 29 Oct 2025 16:45:06 +0000
From: Simon Horman <horms@kernel.org>
To: Abdun Nihaal <nihaal@cse.iitm.ac.in>
Cc: isdn@linux-pingi.de, netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH net] isdn: mISDN: hfcsusb: fix memory leak in
 hfcsusb_probe()
Message-ID: <aQJEkvtfmG-sEA3v@horms.kernel.org>
References: <20251024173458.283837-1-nihaal@cse.iitm.ac.in>
 <aQC333bzOkMNOFAG@horms.kernel.org>
 <f2xnihnjrvh6qqqqtqev6zx47pjhxd5kpgdahibdsgtg7ran2d@z6yerx5rddsr>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <f2xnihnjrvh6qqqqtqev6zx47pjhxd5kpgdahibdsgtg7ran2d@z6yerx5rddsr>

On Tue, Oct 28, 2025 at 10:08:44PM +0530, Abdun Nihaal wrote:
> On Tue, Oct 28, 2025 at 12:32:31PM +0000, Simon Horman wrote:
> > I agree that this is a bug, and that it was introduced in the cited commit.
> 
> Thanks for reviewing the patch.
> 
> > I think it would be good to add something to the commit message
> > regarding how the problem was found, e.g. which tool was used, or
> > by inspection; and what testing has been done, e.g. compile tested only.
> 
> Sure I'll add that to future patches that I send.
> This issue was reported by a prototype static analysis tool.
> And it is compile tested only.

Thanks, I think the including two lines above would work well.

> 
> > I think it would be best to follow the idiomatic pattern and
> > introduce a ladder of goto statements to handle unwind on error.
> > 
> > Something like this (compile tested only!):
> > 
> > diff --git a/drivers/isdn/hardware/mISDN/hfcsusb.c b/drivers/isdn/hardware/mISDN/hfcsusb.c
> > @@ -1921,6 +1920,7 @@ hfcsusb_probe(struct usb_interface *intf, const struct usb_device_id *id)
> >  		probe_alt_setting, vend_idx, cfg_used, *vcf, attr, cfg_found,
> >  		ep_addr, cmptbl[16], small_match, iso_packet_size, packet_size,
> >  		alt_used = 0;
> > +	int err;
> >  
> >  	vend_idx = 0xffff;
> >  	for (i = 0; hfcsusb_idtab[i].idVendor; i++) {
> > @@ -2101,20 +2101,28 @@ hfcsusb_probe(struct usb_interface *intf, const struct usb_device_id *id)
> >  	if (!hw->ctrl_urb) {
> >  		pr_warn("%s: No memory for control urb\n",
> >  			driver_info->vend_name);
> > -		kfree(hw);
> > -		return -ENOMEM;
> > +		err = -ENOMEM;
> > +		goto err_free_urb;
> >  	}
> >  
> >  	pr_info("%s: %s: detected \"%s\" (%s, if=%d alt=%d)\n",
> >  		hw->name, __func__, driver_info->vend_name,
> >  		conf_str[small_match], ifnum, alt_used);
> >  
> > -	if (setup_instance(hw, dev->dev.parent))
> > -		return -EIO;
> > +	if (setup_instance(hw, dev->dev.parent)) {
> > +		err = -EIO;
> > +		goto err_free_hw;
> > +	}
> >  
> >  	hw->intf = intf;
> >  	usb_set_intfdata(hw->intf, hw);
> >  	return 0;
> > +
> > +err_free_urb:
> > +	usb_free_urb(hw->ctrl_urb);
> > +err_free_hw:
> > +	kfree(hw);
> > +	return err;
> >  }
> 
> In this case, since there are only two memory allocations and only two
> error paths involved, I would prefer keeping the frees in place. But I
> agree that for longer error paths the ladder of gotos would be better.
> 
> Let me know. I can send an updated patch in the goto-ladder style, if
> you insist.

Insist is a strong word. But that is my preference.
Because even for two allocations this is the preferred style
for Networking code.

