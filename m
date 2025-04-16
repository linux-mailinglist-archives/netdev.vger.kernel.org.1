Return-Path: <netdev+bounces-183329-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 530F6A90611
	for <lists+netdev@lfdr.de>; Wed, 16 Apr 2025 16:20:06 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id C18D91663E7
	for <lists+netdev@lfdr.de>; Wed, 16 Apr 2025 14:16:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9B5B9204C2F;
	Wed, 16 Apr 2025 14:14:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="gCF36gjW"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 75679202F9C
	for <netdev@vger.kernel.org>; Wed, 16 Apr 2025 14:14:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744812841; cv=none; b=CCQNwYgO/2FstdrWi8Fs+v/OU/OcNhKBQr7Q1tNPll6oMcf/82TOoVS65VHI8g32deX99oc5maNCWVlnvTA+X6Av0nCAXj5DnyX9loMQXrd1EhSgNR38xS6kYMLne1lRjMnlWKmkXwpiK8WwxDWOEVvwXzhoR2htsBNIju4xbzA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744812841; c=relaxed/simple;
	bh=aJM9KtZjGWJx3V9hGn+9ONXAzT0iVKDyKmibJWyTCWQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=magPkIPO0M9+2wx6FqjXJ9lpw/FogbhWJ52GTLsyD8EsLt41xtAETCKOs8Yo3RLI8smI8bNWQImGXuZY6AnPPqFVsT1wXuIeGjOK6DwmuxUdIAgwqItbBvjaq4HEBINusTgBh6gu7sb2xF0LLlyfcPLBwh4mraf/fEPJFEA/h5s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=gCF36gjW; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id BEE9FC4CEEF;
	Wed, 16 Apr 2025 14:13:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1744812839;
	bh=aJM9KtZjGWJx3V9hGn+9ONXAzT0iVKDyKmibJWyTCWQ=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=gCF36gjWDBWobW2M4aOqBQ1Lg2rRzhKxPtqbTmcsgUd+/r/4OOWaJRE4S8C9++mIz
	 ZSsOI6LqzmrUasu06ITWrhVfEJEtp9eElUqxNY7b4hlXt7pPcVmhBi+4mPSkQOX3h5
	 remycygUerrWrsUgNaLMry/qkDeWZpAZSDIjOClUpQ8m5YEc0srQlfs/nCJkJx0uZQ
	 AnmgkA5cJWGvQAz98mcfJ7H8UYT5W2DlaMWo+poJKL7PEhLNnZTwUUW2N5Pkx+ETUz
	 Wu5VtvcpIbUaJjcLYI4ljb4m0Pp3Izvhd5w7AhKacOGSJJ1BBXWmVZpmmvN9ejcVwE
	 Izy7AzBw1WV3A==
Date: Wed, 16 Apr 2025 16:13:55 +0200
From: Niklas Cassel <cassel@kernel.org>
To: Heiner Kallweit <hkallweit1@gmail.com>
Cc: nic_swsd@realtek.com, Andrew Lunn <andrew+netdev@lunn.ch>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>,
	netdev@vger.kernel.org,
	Krishna Chaitanya Chundru <krishna.chundru@oss.qualcomm.com>
Subject: Re: [PATCH] r8169: do not call rtl8169_down() twice on shutdown
Message-ID: <Z_-7I26WVApG98Ej@ryzen>
References: <20250415095335.506266-2-cassel@kernel.org>
 <4f8d3018-d7e5-47e5-b99d-550f8a4011ee@gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <4f8d3018-d7e5-47e5-b99d-550f8a4011ee@gmail.com>

On Tue, Apr 15, 2025 at 08:48:53PM +0200, Heiner Kallweit wrote:
> On 15.04.2025 11:53, Niklas Cassel wrote:
> > For a PCI controller driver with a .shutdown() callback, we will see the
> > following warning:
> 
> I saw the related mail thread, IIRC it was about potential new code.
> Is this right? Or do we talk about existing code? Then it would have
> to be treated as fix.

The qcom PCIe controller driver wants to add a .shutdown callback:
https://lore.kernel.org/linux-pci/tb6kkyfgpemzacfwbg45otgcrg5ltj323y6ufjy3bw3rgri7uf@vrmmtueyg7su/T/#t

In that shutdown callback, they want to call dw_pcie_host_deinit(),
which will call pci_stop_root_bus().

Looking at other PCIe controller drivers:
$ git grep -p pci_stop_root_bus

There seems to be a lot of PCIe controller drivers that call
pci_stop_root_bus(), but they all do it from the .remove() callback,
not from the .shutdown() callback.

Actually, I can't see any existing PCIe controller driver that calls
pci_stop_root_bus() from the .shutdown() callback.

So perhaps we should hold off with this patch.

Adding the qcom folks to CC.


Kind regards,
Niklas


> 
> Existence of a shutdown callback itself is not the problem, the problem is
> that all PCI bus devices are removed as part of shutdown handling for this
> specific controller driver.
> 
> > [   12.020111] called from state HALTED
> > [   12.020459] WARNING: CPU: 7 PID: 229 at drivers/net/phy/phy.c:1630 phy_stop+0x134/0x1a0
> > 
> > This is because rtl8169_down() (which calls phy_stop()) is called twice
> > during shutdown.
> > 
> > First time:
> > [   23.827764] Call trace:
> > [   23.827765]  show_stack+0x20/0x40 (C)
> > [   23.827774]  dump_stack_lvl+0x60/0x80
> > [   23.827778]  dump_stack+0x18/0x24
> > [   23.827782]  rtl8169_down+0x30/0x2a0
> > [   23.827788]  rtl_shutdown+0xb0/0xc0
> > [   23.827792]  pci_device_shutdown+0x3c/0x88
> > [   23.827797]  device_shutdown+0x150/0x278
> > [   23.827802]  kernel_restart+0x4c/0xb8
> > 
> > Second time:
> > [   23.841468] Call trace:
> > [   23.841470]  show_stack+0x20/0x40 (C)
> > [   23.841478]  dump_stack_lvl+0x60/0x80
> > [   23.841483]  dump_stack+0x18/0x24
> > [   23.841486]  rtl8169_down+0x30/0x2a0
> > [   23.841492]  rtl8169_close+0x64/0x100
> > [   23.841496]  __dev_close_many+0xbc/0x1f0
> > [   23.841502]  dev_close_many+0x94/0x160
> > [   23.841505]  unregister_netdevice_many_notify+0x160/0x9d0
> > [   23.841510]  unregister_netdevice_queue+0xf0/0x100
> > [   23.841515]  unregister_netdev+0x2c/0x58
> > [   23.841519]  rtl_remove_one+0xa0/0xe0
> > [   23.841524]  pci_device_remove+0x4c/0xf8
> > [   23.841528]  device_remove+0x54/0x90
> > [   23.841534]  device_release_driver_internal+0x1d4/0x238
> > [   23.841539]  device_release_driver+0x20/0x38
> > [   23.841544]  pci_stop_bus_device+0x84/0xe0
> > [   23.841548]  pci_stop_bus_device+0x40/0xe0
> > [   23.841552]  pci_stop_root_bus+0x48/0x80
> > [   23.841555]  dw_pcie_host_deinit+0x34/0xe0
> > [   23.841559]  rockchip_pcie_shutdown+0x20/0x38
> > [   23.841565]  platform_shutdown+0x2c/0x48
> > [   23.841571]  device_shutdown+0x150/0x278
> > [   23.841575]  kernel_restart+0x4c/0xb8
> > 
> > Add a netif_device_present() guard around the rtl8169_down() call in
> > rtl8169_close(), to avoid rtl8169_down() from being called twice.
> > 
> > This matches how e.g. e1000e_close() has a netif_device_present() guard
> > around the e1000e_down() call.
> > 
> This approach has at least two issues:
> 
> 1. Likely it breaks WoL, because now phy_detach() is called.
> 2. r8169 shutdown callback sets device to D3hot, PCI core wakes it up again
>    for the remove callback. Now it's left in D0.
> 
> I'll also spend a few thoughts on how to solve this best.
> 
> > Signed-off-by: Niklas Cassel <cassel@kernel.org>
> > ---
> >  drivers/net/ethernet/realtek/r8169_main.c | 3 ++-
> >  1 file changed, 2 insertions(+), 1 deletion(-)
> > 
> > diff --git a/drivers/net/ethernet/realtek/r8169_main.c b/drivers/net/ethernet/realtek/r8169_main.c
> > index 4eebd9cb40a3..0300a06ae260 100644
> > --- a/drivers/net/ethernet/realtek/r8169_main.c
> > +++ b/drivers/net/ethernet/realtek/r8169_main.c
> > @@ -4879,7 +4879,8 @@ static int rtl8169_close(struct net_device *dev)
> >  	pm_runtime_get_sync(&pdev->dev);
> >  
> >  	netif_stop_queue(dev);
> > -	rtl8169_down(tp);
> > +	if (netif_device_present(tp->dev))
> > +		rtl8169_down(tp);
> >  	rtl8169_rx_clear(tp);
> >  
> >  	free_irq(tp->irq, tp);
> 

