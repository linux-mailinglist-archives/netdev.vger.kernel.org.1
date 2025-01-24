Return-Path: <netdev+bounces-160802-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 041A9A1B8A3
	for <lists+netdev@lfdr.de>; Fri, 24 Jan 2025 16:14:32 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 54A9016AA23
	for <lists+netdev@lfdr.de>; Fri, 24 Jan 2025 15:14:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 83DDE14D708;
	Fri, 24 Jan 2025 15:14:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b="awbpgpm2"
X-Original-To: netdev@vger.kernel.org
Received: from vps0.lunn.ch (vps0.lunn.ch [156.67.10.101])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A2CC812F399;
	Fri, 24 Jan 2025 15:14:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=156.67.10.101
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1737731667; cv=none; b=ZYXPHiYFietoVmqGb1JVE07BXihMtWDcelw0sjHpfotQpRJdp7RrXX714hMGGFHwYeVSdheRvdEUVgdlxvWhuE9BmpfD/+9ZnySZRpAdwdwMVEXl8IYKcOOb3+Vx/UCDYc7ScPP2JvrGufyUmYpQx+cUW7wiQqApwRZEiXPMAnI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1737731667; c=relaxed/simple;
	bh=20tCNysR7q5PePi/rLl/5tz82hyLp2rJQ/Srcqc9UZs=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=BZksHgDNJeKrtVGFtVXXYJFAnMFK8HJ94UINlL95L+YSPBmltFPBoP2NSUqzmcgV3habzVrzYPdA3gahHl/qQx0LTqcseMlvb7m4sPuDwwPcgG84u0/ajF7yOa6YXr3sn3L/9vYiM3+qRKSfQH6CvtDYYUwRiZUFn15S+Xqzru8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch; spf=pass smtp.mailfrom=lunn.ch; dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b=awbpgpm2; arc=none smtp.client-ip=156.67.10.101
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lunn.ch
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=lunn.ch;
	s=20171124; h=In-Reply-To:Content-Disposition:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:From:Sender:Reply-To:Subject:
	Date:Message-ID:To:Cc:MIME-Version:Content-Type:Content-Transfer-Encoding:
	Content-ID:Content-Description:Content-Disposition:In-Reply-To:References;
	bh=wVE7rgHgEpJPUkUmaljyORlmxMSMeLFMqZuFdz6ZPZU=; b=awbpgpm2/8U6hinrQEgznqUlzx
	XU4QjE+b8q7yQp6aR6RU48V7vyqL9kOPUi+1plgMMZu5hgY2tGYtsjQZnseT38WnPpi9K7qRMxBn+
	yg5m2efPPLXBgkUYyc8H7XiFjtERBF0IMq+Pf1mjee0wKWzeXlLyrxKOLrx62jdWhhdw=;
Received: from andrew by vps0.lunn.ch with local (Exim 4.94.2)
	(envelope-from <andrew@lunn.ch>)
	id 1tbLNk-007ctS-US; Fri, 24 Jan 2025 16:14:04 +0100
Date: Fri, 24 Jan 2025 16:14:04 +0100
From: Andrew Lunn <andrew@lunn.ch>
To: Furong Xu <0x1207@gmail.com>
Cc: Brad Griffis <bgriffis@nvidia.com>, Jon Hunter <jonathanh@nvidia.com>,
	netdev@vger.kernel.org, linux-stm32@st-md-mailman.stormreply.com,
	linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
	Alexander Lobakin <aleksander.lobakin@intel.com>,
	Joe Damato <jdamato@fastly.com>,
	Andrew Lunn <andrew+netdev@lunn.ch>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	Maxime Coquelin <mcoquelin.stm32@gmail.com>, xfr@outlook.com,
	"linux-tegra@vger.kernel.org" <linux-tegra@vger.kernel.org>
Subject: Re: [PATCH net-next v3 1/4] net: stmmac: Switch to zero-copy in
 non-XDP RX path
Message-ID: <2ac94866-7258-45f1-be7c-595b64595494@lunn.ch>
References: <cover.1736910454.git.0x1207@gmail.com>
 <bd7aabf4d9b6696885922ed4bef8fc95142d3004.1736910454.git.0x1207@gmail.com>
 <d465f277-bac7-439f-be1d-9a47dfe2d951@nvidia.com>
 <20250124003501.5fff00bc@orangepi5-plus>
 <e6305e71-5633-48bf-988d-fa2886e16aae@nvidia.com>
 <20250124095305.00002b3e@gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250124095305.00002b3e@gmail.com>

> It is not an actual fix, it is only for diagnostic purposes.
> 
> >   So perhaps the only fix needed is to add dma-coherent to our device tree?
> 
> Yes, add dma-coherent to ethernet node is the correct fix.

What do you think about the comment i made?

     Andrew

