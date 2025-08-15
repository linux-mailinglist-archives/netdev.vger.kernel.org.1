Return-Path: <netdev+bounces-214136-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 8286EB28583
	for <lists+netdev@lfdr.de>; Fri, 15 Aug 2025 20:07:30 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 7DA243B3E65
	for <lists+netdev@lfdr.de>; Fri, 15 Aug 2025 18:07:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 635B1224B0E;
	Fri, 15 Aug 2025 18:07:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b="W4L5Sohf"
X-Original-To: netdev@vger.kernel.org
Received: from vps0.lunn.ch (vps0.lunn.ch [156.67.10.101])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 86178317702;
	Fri, 15 Aug 2025 18:07:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=156.67.10.101
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755281239; cv=none; b=j7eKhvxHT4Om1oGO1THFPaEidP1fsahPPZAD+v/sNazQ2BRyQ6Eb8G9Jze1G5LMgc2ZOkflsrR4YqrM4HQd7km0jqA0j4/vOGrAZjJo433nSzT7sq7CCAYRbh+KVlLdMVJQ5XGtm/cit5VxlxURidUgGxvcNs58XC3mm8mRzQ2I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755281239; c=relaxed/simple;
	bh=6LkPZMv9k8hDlzCNKVs3sIwoyDtLrZJkQI0c17gRlOw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Wq+M9rE7a/0iICb0YfA+FkxqeEbTbZjmhMc2WLXWmxmKVxRJK1V+Yq3ogOSQCBR8IuCYWoYenYPrUccdjJuYBGjwr43L/JC3pZ0Ai82uhlObJFKnw2qxtInBlaF4KRJ556QC2wQKpZv/pKHkjkRH1LkoUvTMsD1qIwl+Hzx41Mc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch; spf=pass smtp.mailfrom=lunn.ch; dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b=W4L5Sohf; arc=none smtp.client-ip=156.67.10.101
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lunn.ch
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=lunn.ch;
	s=20171124; h=In-Reply-To:Content-Disposition:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:From:Sender:Reply-To:Subject:
	Date:Message-ID:To:Cc:MIME-Version:Content-Type:Content-Transfer-Encoding:
	Content-ID:Content-Description:Content-Disposition:In-Reply-To:References;
	bh=YgvvVuDKqui7txj7cJZLGV7Pe1wl+IwQEbSo3OxI38Y=; b=W4L5SohfsikhicM2fMhMYVU5ez
	7GHAzt8DwRE0JLzrV2MptVHRAfjIKqFdGNGxRchaK/KTSWivn5Lgyjbde+CxjI24zzPF382VEhuAW
	gtccE+EVzyqGn5NSLCy0JtxRYj24P64KzKawzX3gdV7ycR2IKsGCbhQza79dQG3D04iA=;
Received: from andrew by vps0.lunn.ch with local (Exim 4.94.2)
	(envelope-from <andrew@lunn.ch>)
	id 1umyp1-004qd8-3h; Fri, 15 Aug 2025 20:06:35 +0200
Date: Fri, 15 Aug 2025 20:06:35 +0200
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
Subject: Re: [PATCH v4 5/5] net: rnpgbe: Add register_netdev
Message-ID: <b669db06-83f8-447c-8081-7ef6ae9d2aba@lunn.ch>
References: <20250814073855.1060601-1-dong100@mucse.com>
 <20250814073855.1060601-6-dong100@mucse.com>
 <099a6006-02e4-44f0-ae47-7de14cc58a12@lunn.ch>
 <CFAA902406A8215F+20250815064441.GB1148411@nic-Precision-5820-Tower>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CFAA902406A8215F+20250815064441.GB1148411@nic-Precision-5820-Tower>

> > > +static int rnpgbe_reset_hw_ops(struct mucse_hw *hw)
> > > +{
> > > +	struct mucse_dma_info *dma = &hw->dma;
> > > +	int err;
> > > +
> > > +	dma_wr32(dma, RNPGBE_DMA_AXI_EN, 0);
> > > +	err = mucse_mbx_fw_reset_phy(hw);
> > > +	if (err)
> > > +		return err;
> > > +	/* Store the permanent mac address */
> > > +	if (!(hw->flags & M_FLAGS_INIT_MAC_ADDRESS))
> > 
> > What do this hw->flags add to the driver? Why is it here?
> > 
> 
> It is used to init 'permanent addr' only once.
> rnpgbe_reset_hw_ops maybe called when netdev down or hw hang, no need
> try to get 'permanent addr' more times.

It normally costs ~0 to ask the firmware something. So it is generally
simpler to just ask it. If the firmware is dead, you should not really
care, the RPC should timeout, ETIMEDOUT will get returned to user
space, and likely everything else will fail anyway.
 
> > >  static void rnpgbe_rm_adapter(struct pci_dev *pdev)
> > >  {
> > >  	struct mucse *mucse = pci_get_drvdata(pdev);
> > > +	struct mucse_hw *hw = &mucse->hw;
> > >  	struct net_device *netdev;
> > >  
> > >  	if (!mucse)
> > >  		return;
> > >  	netdev = mucse->netdev;
> > > +	if (netdev->reg_state == NETREG_REGISTERED)
> > > +		unregister_netdev(netdev);
> > 
> > Is that possible?
> > 
> 
> Maybe probe failed before register_netdev? Then rmmod the driver.

Functions like this come in pairs. There is some sort of setup
function, and a corresponding teardown function. probe/remove,
open/close. In Linux, if the first fails, the second is never called.

	Andrew

