Return-Path: <netdev+bounces-185237-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 9DD61A996DA
	for <lists+netdev@lfdr.de>; Wed, 23 Apr 2025 19:40:00 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id BD20E188E714
	for <lists+netdev@lfdr.de>; Wed, 23 Apr 2025 17:40:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4D5DC28935F;
	Wed, 23 Apr 2025 17:39:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="uxM/K0bo"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 28FE52853E1
	for <netdev@vger.kernel.org>; Wed, 23 Apr 2025 17:39:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745429997; cv=none; b=IONIfUrzYnkxLFz/+0XcqP6vnXIR57rFyj8e4enWtiqT3CjggXV9F/mPT3BHy2Wgkn5HAGfXFb7bJ2U7ZuViC6U5gyuQpGcGtBnMEIHDxDGONfNbvBIA/LvR7+UTI+V7V1jzDNkEvZjylItShnorbgpfYuW2TXy1o1fdPnsdduk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745429997; c=relaxed/simple;
	bh=kY3JtwxlKCPArdIyX3rCb323GmFlS/jUCclJLdDtcbI=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition:In-Reply-To; b=HVo5ld3/7uos1w+wFKQiYkVKheWQ+jJVdql1qx16Ch0CkxabrDG4W0yHC69oJ1hNt4gW3xjGkDxN/TPKcIk9ylme2hkHLH1B9u450MIoU915LAY6FqnBj7cjWdGLHszX92k2I+Sd1zG0MwHgSEKO+9XOKdgSJMntkRuevJZK7qE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=uxM/K0bo; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6B4EFC4CEE2;
	Wed, 23 Apr 2025 17:39:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1745429996;
	bh=kY3JtwxlKCPArdIyX3rCb323GmFlS/jUCclJLdDtcbI=;
	h=Date:From:To:Cc:Subject:In-Reply-To:From;
	b=uxM/K0booX91PiY1MCS/qehR9zNFz0UuiLTqZBmC9jcsMaChfihv3rbhr0xOo0cfJ
	 gcvR05ZKhKdvdToPILLUFTQDg8tc9ak2AIjal/8wQMRceQhv92JbcK6OEm7Q2oBt2k
	 L9TL7YxTvSn4x8KZ4ZkLUCvYWD49Tjyf7cfK9FaG6h9xvI9Eglolw2q0ObizpY6tfV
	 CeYEV9387ehRXdzg2ykky0ChaeVoS9iv+TKWOrnGpTJJYr+SYvcUZzbtDNvsnX/6dA
	 4uhJOVS5kF9RGHzy+eJWdoLskG12jiog1LLpOioiMz0dGht7VYlg1c/5R2fSiNAmPg
	 1AVhLHABEpXWw==
Date: Wed, 23 Apr 2025 12:39:54 -0500
From: Bjorn Helgaas <helgaas@kernel.org>
To: Heiner Kallweit <hkallweit1@gmail.com>
Cc: Krishna Chaitanya Chundru <krishna.chundru@oss.qualcomm.com>,
	Bjorn Helgaas <bhelgaas@google.com>, nic_swsd@realtek.com,
	Andrew Lunn <andrew+netdev@lunn.ch>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	netdev@vger.kernel.org, Niklas Cassel <cassel@kernel.org>,
	Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
Subject: Re: [PATCH] r8169: do not call rtl8169_down() twice on shutdown
Message-ID: <20250423173954.GA441200@bhelgaas>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <302ad2e6-e42f-4579-8a99-0ca72fccf24a@gmail.com>

On Sun, Apr 20, 2025 at 08:25:19AM +0200, Heiner Kallweit wrote:
> On 20.04.2025 01:18, Krishna Chaitanya Chundru wrote:
> > On 4/19/2025 3:48 PM, Heiner Kallweit wrote:
> >> On 18.04.2025 23:52, Heiner Kallweit wrote:
> >>> On 18.04.2025 19:19, Manivannan Sadhasivam wrote:
> >>>> On Wed, Apr 16, 2025 at 06:03:36PM +0200, Niklas Cassel wrote:
> >>>>> Hello Krishna Chaitanya,
> >>>>>
> >>>>> On Wed, Apr 16, 2025 at 09:15:19PM +0530, Krishna Chaitanya Chundru wrote:
> >>>>>> On 4/16/2025 7:43 PM, Niklas Cassel wrote:
> >>>>>>>
> >>>>>>> So perhaps we should hold off with this patch.
> >>>>>>>
> >>>>>> I disagree on this, it might be causing issue with net
> >>>>>> driver, but we might face some other issues as explained
> >>>>>> above if we don't call pci_stop_root_bus().
> >>>>>
> >>>>> When I wrote hold off with this patch, I meant the patch in
> >>>>> $subject, not your patch.
> >>>>>
> >>>>>
> >>>>> When it comes to your patch, I think that the commit log needs
> >>>>> to explain why it is so special.
> >>>>>
> >>>>> Because AFAICT, all other PCIe controller drivers call
> >>>>> pci_stop_root_bus() in the .remove() callback, not in the
> >>>>> .shutdown() callback.
> >>>>
> >>>> And this driver is special because, it has no 'remove()'
> >>>> callback as it implements an irqchip controller. So we have to
> >>>> shutdown the devices cleanly in the 'shutdown' callback.
> >>>>
> >>> Doing proper cleanup in a first place is responsibility of the
> >>> respective bus devices (in their shutdown() callback).
> >>>
> >>> Calling pci_stop_root_bus() in the pci controllers shutdown()
> >>> causes the bus devices to be removed, hence their remove() is
> >>> called. Typically devices don't expect that remove() is called
> >>> after shutdown(). This may cause issues if e.g. shutdown() sets
> >>> a device to D3cold. remove() won't expect that device is
> >>> inaccessible.
> >
> > Lets say controller driver in the shut down callback keeps PCIe
> > device state in D3cold without removing PCIe devices. Then the
> > PCIe client drivers which are not registered with the shutdown
> > callback assumes PCIe link is still accessible and initiates some
> > transfers or there may be on ongoing transfers also which can
> > result in some system errors like soc error etc which can hang the
> > device.
> > 
> I'd consider a bus device driver behaving this way as broken.  IMO
> device drivers should ensure that device is quiesced on shutdown.
> As you highlight this case, do you have specific examples?  Maybe we
> should focus on fixing such bus device drivers first.
> 
> I'd be interested in the PCI maintainers point of view, that's why I
> added Bjorn to the discussion.

See https://lore.kernel.org/r/20250423171715.GA430351@bhelgaas

I think we should resolve the question of whether .shutdown() should
remove all downstream drivers and devices needs to be resolved, and
hopefully we don't have to discuss it in two separate places.

Bjorn

