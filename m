Return-Path: <netdev+bounces-215393-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id F02A7B2E634
	for <lists+netdev@lfdr.de>; Wed, 20 Aug 2025 22:10:39 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id D6D1C5E4521
	for <lists+netdev@lfdr.de>; Wed, 20 Aug 2025 20:10:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 64A8A2737E3;
	Wed, 20 Aug 2025 20:10:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b="DDLZ2WzG"
X-Original-To: netdev@vger.kernel.org
Received: from vps0.lunn.ch (vps0.lunn.ch [156.67.10.101])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 88602277026;
	Wed, 20 Aug 2025 20:10:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=156.67.10.101
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755720636; cv=none; b=BLt7SnSZW9bAX3jtvJOjOEQT4oTLSGVpcc+AoIH0MZgqPI/w5wkSu2tp/mHGnh/a+AbXizMKKlJ3OcRwBJK89OKDsAEo/9lT8axMdJb8VExlSQDXrVEverrFoS5XTEnhdwzdSiujXhmO15+1OLrqM4lHJD7dVUiGzEFLXnekjPE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755720636; c=relaxed/simple;
	bh=z3Af0HKkpswznNfBg/Ar95xtiR7UJFM/4bdg6rim0iY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=vBHzDtJjzIIJMqQXPrrlLZrgVHH0n7my1I2vezp7hKdv1v4DPf/rBV7Con0jQAXT0PMzKFkkOmNJeeWRJ1WdGq840h8y+TlQBSjp3Zfew0TzwKSd5BcWwQJJOrxoqQzC/kx2qtI/E03+u8o36iYxZ6f2nvFR8e8QxuhASQdqXT8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch; spf=pass smtp.mailfrom=lunn.ch; dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b=DDLZ2WzG; arc=none smtp.client-ip=156.67.10.101
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lunn.ch
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=lunn.ch;
	s=20171124; h=In-Reply-To:Content-Disposition:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:From:Sender:Reply-To:Subject:
	Date:Message-ID:To:Cc:MIME-Version:Content-Type:Content-Transfer-Encoding:
	Content-ID:Content-Description:Content-Disposition:In-Reply-To:References;
	bh=+y0QGQ5WsRkgqzjGpk54eqfXuRt358BpBZB0cWOmpaQ=; b=DDLZ2WzGveYAUhFrj/LZAj3+Tg
	Sj5YFdPFSp5V5ZJl8sC8Eno7bFoS3bV5QoPXeY2qEW62+Eaah9c4oUNLks1hwUQ8FZqc+BHfrCmFn
	6hfNNM4KsksNgLsV7wLvkLXHM3Ya1DRDiNI6jte8LSQXmkPoFwrsrVEq8ejlf2FFc5a4=;
Received: from andrew by vps0.lunn.ch with local (Exim 4.94.2)
	(envelope-from <andrew@lunn.ch>)
	id 1uop8C-005MVf-8G; Wed, 20 Aug 2025 22:10:00 +0200
Date: Wed, 20 Aug 2025 22:10:00 +0200
From: Andrew Lunn <andrew@lunn.ch>
To: Yibo Dong <dong100@mucse.com>
Cc: Vadim Fedorenko <vadim.fedorenko@linux.dev>, andrew+netdev@lunn.ch,
	davem@davemloft.net, edumazet@google.com, kuba@kernel.org,
	pabeni@redhat.com, horms@kernel.org, corbet@lwn.net,
	gur.stavi@huawei.com, maddy@linux.ibm.com, mpe@ellerman.id.au,
	danishanwar@ti.com, lee@trager.us, gongfan1@huawei.com,
	lorenzo@kernel.org, geert+renesas@glider.be,
	Parthiban.Veerasooran@microchip.com, lukas.bulwahn@redhat.com,
	alexanderduyck@fb.com, richardcochran@gmail.com,
	netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
	linux-doc@vger.kernel.org
Subject: Re: [PATCH v5 2/5] net: rnpgbe: Add n500/n210 chip support
Message-ID: <77d89708-19a1-4394-bd6b-ca5aef6bafc1@lunn.ch>
References: <20250818112856.1446278-1-dong100@mucse.com>
 <20250818112856.1446278-3-dong100@mucse.com>
 <d4a84d76-8982-4a9d-a383-2e2d4d66550a@linux.dev>
 <78DD9702C797EEA1+20250820014341.GA1580474@nic-Precision-5820-Tower>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <78DD9702C797EEA1+20250820014341.GA1580474@nic-Precision-5820-Tower>

On Wed, Aug 20, 2025 at 09:43:41AM +0800, Yibo Dong wrote:
> On Tue, Aug 19, 2025 at 02:59:09PM +0100, Vadim Fedorenko wrote:
> > On 18/08/2025 12:28, Dong Yibo wrote:
> > > Initialize n500/n210 chip bar resource map and
> > > dma, eth, mbx ... info for future use.
> > > 
> > [...]
> > 
> > > +struct mucse_hw {
> > > +	void __iomem *hw_addr;
> > > +	void __iomem *ring_msix_base;
> > > +	struct pci_dev *pdev;
> > > +	enum rnpgbe_hw_type hw_type;
> > > +	struct mucse_dma_info dma;
> > > +	struct mucse_eth_info eth;
> > > +	struct mucse_mac_info mac;
> > > +	struct mucse_mbx_info mbx;
> > > +	u32 usecstocount;
> > 
> > What is this field for? You don't use it anywhere in the patchset apart
> > from initialization. Maybe it's better to introduce it once it's used?
> > Together with the defines of values for this field...
> > 
> 
> It is used to store chip frequency which is used to calculate values
> related to 'delay register' in the future. I will improve this.

Maybe also see if you can find a better name. count is rather
vague. Count of what?

	Andrew

