Return-Path: <netdev+bounces-226411-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 5637EB9FF09
	for <lists+netdev@lfdr.de>; Thu, 25 Sep 2025 16:20:21 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 5E18C1882B48
	for <lists+netdev@lfdr.de>; Thu, 25 Sep 2025 14:15:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8DE6C2877D3;
	Thu, 25 Sep 2025 14:12:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b="cXp43DwU"
X-Original-To: netdev@vger.kernel.org
Received: from vps0.lunn.ch (vps0.lunn.ch [156.67.10.101])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C6E3C286D46
	for <netdev@vger.kernel.org>; Thu, 25 Sep 2025 14:12:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=156.67.10.101
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758809541; cv=none; b=VF7z/3yYDqlt9rJBZRKzrfkBmGM//oKK3ZG1dcKxR+4HtQehvrMcGAxrE+ZBik5nhx+8pDaCkF5MromAsRKH+DRHEfLGcVEhzGsLPqEIBr03TtVH0eV3JXlarSz8YzVuOuCIVhcRoJiElRyNPdwWsvhY/ifx9UHZP6N49P6/xIA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758809541; c=relaxed/simple;
	bh=RHX32Lv0zBGA+Ifx4l3xidfpMlf4syedyCzARChzofA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=KnxPjm6z4BMBm3h39uF+hsDpnFbp+1og9b88Hj1/Ex71a82bwR4yh2RSTPFpsUgmJ3G/AyBsd7FXHoGkx5E/B7bjR57mkB4iOFBMR8hOeIJtFxghis7X7Do4sY6KN5dJjtWNj5pCYEx2HDtb/Shb3T4fhLUfj5qleMC1EWi6RHA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch; spf=pass smtp.mailfrom=lunn.ch; dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b=cXp43DwU; arc=none smtp.client-ip=156.67.10.101
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lunn.ch
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=lunn.ch;
	s=20171124; h=In-Reply-To:Content-Disposition:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:From:Sender:Reply-To:Subject:
	Date:Message-ID:To:Cc:MIME-Version:Content-Type:Content-Transfer-Encoding:
	Content-ID:Content-Description:Content-Disposition:In-Reply-To:References;
	bh=0vsa83PWpYghu0vYpD8NlWR/z+L8lFEP0HBrSpLi7cw=; b=cXp43DwUOn+lTSYb/1IyyBOBXd
	B4vgIhsgMELCNFSCRIaTz9ek2VarIFufohpmZsfokORdOPvv7tb2janxMc79CEr6L/dpee6tpKuJ3
	Q77OXFDwduTysz6IvcNBgD3vx8fscFFQwdf0PtXbb6NVGE3x+SjJObSSvJDLEY8lUsnc=;
Received: from andrew by vps0.lunn.ch with local (Exim 4.94.2)
	(envelope-from <andrew@lunn.ch>)
	id 1v1mhS-009TNG-0Z; Thu, 25 Sep 2025 16:11:58 +0200
Date: Thu, 25 Sep 2025 16:11:57 +0200
From: Andrew Lunn <andrew@lunn.ch>
To: Xuan Zhuo <xuanzhuo@linux.alibaba.com>
Cc: Przemek Kitszel <przemyslaw.kitszel@intel.com>,
	Andrew Lunn <andrew+netdev@lunn.ch>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, netdev@vger.kernel.org,
	Paolo Abeni <pabeni@redhat.com>, Wen Gu <guwen@linux.alibaba.com>,
	Philo Lu <lulie@linux.alibaba.com>,
	Lorenzo Bianconi <lorenzo@kernel.org>,
	Vadim Fedorenko <vadim.fedorenko@linux.dev>,
	Lukas Bulwahn <lukas.bulwahn@redhat.com>,
	Geert Uytterhoeven <geert+renesas@glider.be>,
	Vivian Wang <wangruikang@iscas.ac.cn>,
	Troy Mitchell <troy.mitchell@linux.spacemit.com>,
	Dust Li <dust.li@linux.alibaba.com>
Subject: Re: [PATCH net-next v3] eea: Add basic driver framework for Alibaba
 Elastic Ethernet Adaptor
Message-ID: <bf3a6b81-de2e-4c63-968e-5f0937727855@lunn.ch>
References: <20250919014856.20267-1-xuanzhuo@linux.alibaba.com>
 <cfae046e-106d-4963-88be-8ca116859538@intel.com>
 <1758782566.2551036-1-xuanzhuo@linux.alibaba.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1758782566.2551036-1-xuanzhuo@linux.alibaba.com>

> > > +ALIBABA ELASTIC ETHERNET ADAPTOR DRIVER
> > > +M:	Xuan Zhuo <xuanzhuo@linux.alibaba.com>
> > > +M:	Wen Gu <guwen@linux.alibaba.com>
> > > +R:	Philo Lu <lulie@linux.alibaba.com>
> > > +L:	netdev@vger.kernel.org
> > > +S:	Supported
> >
> > this is reserved for companies that run netdev-ci tests on their HW
> 
> Yes, so I think this is fine for us. In the future, the Alibaba Cloud instance
> will provide the EEA NIC, and we will test it on such a machine.

Until you do have such tests, and can show us the test reports, please
don't use Supported.

	Andrew

