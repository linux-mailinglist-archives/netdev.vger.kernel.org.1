Return-Path: <netdev+bounces-105429-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id CB7D2911202
	for <lists+netdev@lfdr.de>; Thu, 20 Jun 2024 21:21:26 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 85C90285939
	for <lists+netdev@lfdr.de>; Thu, 20 Jun 2024 19:21:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 20ACC1B4C3D;
	Thu, 20 Jun 2024 19:21:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b="ci1WlA6n"
X-Original-To: netdev@vger.kernel.org
Received: from vps0.lunn.ch (vps0.lunn.ch [156.67.10.101])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1FDE11B47C1;
	Thu, 20 Jun 2024 19:21:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=156.67.10.101
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718911279; cv=none; b=QofxMG+75JGbr5b6JU1drbN2BPavlLtz+yLp+xeIHnCTI9tTcSDy1+/Yv/hyw/BOEk6iBhOeDZB9Vx8Jb4izsztsA3UlZFv8b2Fa/ZrBFUP5kKrKMtoV6Fi51/Fo/Ny2yIzh6BQsyguTtcFtKjmcKcZY3bkQktcfzPlw3lbVLUM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718911279; c=relaxed/simple;
	bh=8epgr/RvrTLRKPmIB/Afb8y7LeJFhLANO06COiwITpU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=aYao2pevnGAhCEUYXcz7lGDAV8kXij9fSjh+mGeVRd77gmrpeOcq0eye6JmDmZ6ECXxlaEVt5qcf4ohom38uU5NSJXBi5dgUHIUZguBuvSf0sXGxgqDbx6FZccyKUhA9K1Df3Rbx9Ad/Aoxvflq/Fd+Eqt0LupA9G7rp08+pES4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch; spf=pass smtp.mailfrom=lunn.ch; dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b=ci1WlA6n; arc=none smtp.client-ip=156.67.10.101
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lunn.ch
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=lunn.ch;
	s=20171124; h=In-Reply-To:Content-Disposition:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:From:Sender:Reply-To:Subject:
	Date:Message-ID:To:Cc:MIME-Version:Content-Type:Content-Transfer-Encoding:
	Content-ID:Content-Description:Content-Disposition:In-Reply-To:References;
	bh=SnzxQ3G5O1MZLAjWeXdj4aotnAk4rfp6Vz3kFyLSsa0=; b=ci1WlA6nYinmBy2cyOkwYwtGvE
	nviN9i66TLjfrSFi5xsI4a4i2pC7zgzBIt7Fu9GmU4qR4mI/Hiz6Epwha/jkg5FsbsfkgLv7s8ldT
	kbH0FwU49T/BgGIPYO2IQvNPr+GuFAjJrM2kPf/RLg34qihtaU6vnJ73twlZevx32N54=;
Received: from andrew by vps0.lunn.ch with local (Exim 4.94.2)
	(envelope-from <andrew@lunn.ch>)
	id 1sKNLA-000bLe-TH; Thu, 20 Jun 2024 21:21:00 +0200
Date: Thu, 20 Jun 2024 21:21:00 +0200
From: Andrew Lunn <andrew@lunn.ch>
To: Furong Xu <0x1207@gmail.com>
Cc: "David S. Miller" <davem@davemloft.net>,
	Alexandre Torgue <alexandre.torgue@foss.st.com>,
	Jose Abreu <joabreu@synopsys.com>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	Maxime Coquelin <mcoquelin.stm32@gmail.com>,
	Joao Pinto <jpinto@synopsys.com>, Simon Horman <horms@kernel.org>,
	netdev@vger.kernel.org, linux-stm32@st-md-mailman.stormreply.com,
	linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
	xfr@outlook.com, rock.xu@nio.com
Subject: Re: [PATCH net-next v1] net: stmmac: init more plat members from DT
Message-ID: <54024796-bdf8-4b28-9189-3fa23cff52cf@lunn.ch>
References: <20240620064004.573280-1-0x1207@gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240620064004.573280-1-0x1207@gmail.com>

On Thu, Jun 20, 2024 at 02:40:04PM +0800, Furong Xu wrote:
> A new option to init some useful members of plat_stmmacenet_data from DT.

Are these documented in the binding?

Also, do you have a .dts file which makes use of these. We don't like
to add things unless there is a user.

    Andrew

---
pw-bot: cr

