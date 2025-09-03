Return-Path: <netdev+bounces-219399-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B98E8B411B9
	for <lists+netdev@lfdr.de>; Wed,  3 Sep 2025 03:15:00 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 972515460C2
	for <lists+netdev@lfdr.de>; Wed,  3 Sep 2025 01:15:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 656771D54D8;
	Wed,  3 Sep 2025 01:14:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b="aiI/kj9v"
X-Original-To: netdev@vger.kernel.org
Received: from vps0.lunn.ch (vps0.lunn.ch [156.67.10.101])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BF8DC198A11;
	Wed,  3 Sep 2025 01:14:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=156.67.10.101
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756862097; cv=none; b=LPtxhOmjPrd8T6shhJSh/q5YTnFAPzFUWp7+9H6sh+9yK5NcJz/f8ITj0/WhDPxoaHUMlJCqJoQstbf2PLGYsBaxH7HIy0QUFIjkugDkj0l26ubJzwzQB/KtpnLTOSHXJvWh4RoVxsqmPjqt+4VNrCj/qAtwAUHgCcBNZ+pLV0I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756862097; c=relaxed/simple;
	bh=ZxnXYQ8ZkKMKvEsbk8LHc4SUdR1fAkcaWBlyyphdRu4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=eLfmTfSAUy00RcDCKQPwxxKWqchxV0yO2tU0Cw94nG+uSz2IvefrWoBP/VhKIQdD4U42+yTJ1y4X3OEeG3y93grRddkZUpoShVNWu1cVIFJxSY+odbcY1HOMq5GHevWQMCPqw2wkKT2tK8kMAPXb8rf/YBI10MIdgSoGfUpDt3s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch; spf=pass smtp.mailfrom=lunn.ch; dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b=aiI/kj9v; arc=none smtp.client-ip=156.67.10.101
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lunn.ch
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=lunn.ch;
	s=20171124; h=In-Reply-To:Content-Disposition:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:From:Sender:Reply-To:Subject:
	Date:Message-ID:To:Cc:MIME-Version:Content-Type:Content-Transfer-Encoding:
	Content-ID:Content-Description:Content-Disposition:In-Reply-To:References;
	bh=PZSY/HoeaD7tPrscM18IPaoiODDZTLWC3D2hVTC/ChY=; b=aiI/kj9vDKu+YDu6ZfZ40iYwyc
	nj8NmDoKeKf9KbrLqb7cU3VBgpbRiBBOvobSRIn0yl70JZo9/uV/uzComyW3fX9Gao+pcO4yecJR9
	wuRl0nHlPnUwRVSeGwVvdq9KJpXxAOGOM3VTtrn24K6z6bRDbsUe/JkVisyOsHANhPDI=;
Received: from andrew by vps0.lunn.ch with local (Exim 4.94.2)
	(envelope-from <andrew@lunn.ch>)
	id 1utc59-006xR7-JQ; Wed, 03 Sep 2025 03:14:39 +0200
Date: Wed, 3 Sep 2025 03:14:39 +0200
From: Andrew Lunn <andrew@lunn.ch>
To: Daniel Golle <daniel@makrotopia.org>
Cc: Hauke Mehrtens <hauke@hauke-m.de>, Vladimir Oltean <olteanv@gmail.com>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	Russell King <linux@armlinux.org.uk>, netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Andreas Schirm <andreas.schirm@siemens.com>,
	Lukas Stockmann <lukas.stockmann@siemens.com>,
	Alexander Sverdlin <alexander.sverdlin@siemens.com>,
	Peter Christen <peter.christen@siemens.com>,
	Avinash Jayaraman <ajayaraman@maxlinear.com>,
	Bing tao Xu <bxu@maxlinear.com>, Liang Xu <lxu@maxlinear.com>,
	Juraj Povazanec <jpovazanec@maxlinear.com>,
	"Fanni (Fang-Yi) Chan" <fchan@maxlinear.com>,
	"Benny (Ying-Tsan) Weng" <yweng@maxlinear.com>,
	"Livia M. Rosu" <lrosu@maxlinear.com>,
	John Crispin <john@phrozen.org>
Subject: Re: [RFC PATCH net-next 1/6] net: dsa: lantiq_gswip: convert
 accessors to use regmap
Message-ID: <010e24eb-953e-4d0a-845c-ba899b343e9a@lunn.ch>
References: <cover.1756855069.git.daniel@makrotopia.org>
 <97c2b3d65a0cd550922f809f6e6f51645ccc4ef9.1756855069.git.daniel@makrotopia.org>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <97c2b3d65a0cd550922f809f6e6f51645ccc4ef9.1756855069.git.daniel@makrotopia.org>

> +	if (ret) {
> +		WARN_ON_ONCE(1);

WARN_ON_ONCE() returns the evaluation. So you can make this:


> +	if (WARN_ON_ONCE(ret) {
> +		dev_err(priv->dev, "failed to read switch register\n");
> +		return 0;

I personally think this looks better than having the (1).

	Andrew

