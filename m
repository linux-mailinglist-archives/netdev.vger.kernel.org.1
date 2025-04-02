Return-Path: <netdev+bounces-178862-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A1F96A7939B
	for <lists+netdev@lfdr.de>; Wed,  2 Apr 2025 19:07:05 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id BAD383A9E07
	for <lists+netdev@lfdr.de>; Wed,  2 Apr 2025 17:06:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 03C1719CD1E;
	Wed,  2 Apr 2025 17:07:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b="2IkIe0/x"
X-Original-To: netdev@vger.kernel.org
Received: from vps0.lunn.ch (vps0.lunn.ch [156.67.10.101])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E095735949;
	Wed,  2 Apr 2025 17:06:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=156.67.10.101
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1743613620; cv=none; b=rHMaxlwMabZNF+vD1WQn+4rP+VHQ68dTHF5yyyHid0a9g7cFtzM3ByRHrZsZf8sxBUH0N1vmmX4pMRrJatJH/jYq1Dy3l6WYSwBt3/oZlZ7TkZz3GcQsmN2od5t/a3qPcAuF87IBy6JG+vzMeT/x2B3qon7MTSCECcpmkojwX8Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1743613620; c=relaxed/simple;
	bh=H3EcLWboaQM1ylt3ubvjTkM0ys+EHhZAClRtpTU23yA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=nJJs5Toc9Cl6F39Po2g3er4nLvWXraEtVbw58V7zbJFbdpfSC0iSFe9WzcpSfRdFO+jMsQ9GCN4WDWoaqBskjjc+4j30e5GUpSgnxov4bzu25pAFfRRmQNtVtKgtSM7SBYwrXa7auncMZeW/ZZUkOmL1AmGyY+mc4E6agpG/fXw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch; spf=pass smtp.mailfrom=lunn.ch; dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b=2IkIe0/x; arc=none smtp.client-ip=156.67.10.101
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lunn.ch
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=lunn.ch;
	s=20171124; h=In-Reply-To:Content-Disposition:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:From:Sender:Reply-To:Subject:
	Date:Message-ID:To:Cc:MIME-Version:Content-Type:Content-Transfer-Encoding:
	Content-ID:Content-Description:Content-Disposition:In-Reply-To:References;
	bh=eJZNDnvZYJl/v6wAtqRZA40hAuj1eQcDN3vqs62UpXc=; b=2IkIe0/xrkxwiAKy4t0LpTq6k5
	/rCRyLMMFZZDCwhjeoqr+d+2FBTLgaAXztM7V6t4daPdS3TQHKSxpth3gVcFOELJBkTcTSwwWQmTW
	T04yRrj1rJRB0Tc+AmMqPSfCtTzbbeYq6UXHNYnBaAq/EijIRKJZvG0sJ7nRsNJGU9cs=;
Received: from andrew by vps0.lunn.ch with local (Exim 4.94.2)
	(envelope-from <andrew@lunn.ch>)
	id 1u01Xx-007pEN-4K; Wed, 02 Apr 2025 19:06:37 +0200
Date: Wed, 2 Apr 2025 19:06:37 +0200
From: Andrew Lunn <andrew@lunn.ch>
To: Lukasz Majewski <lukma@denx.de>
Cc: Andrew Lunn <andrew+netdev@lunn.ch>, davem@davemloft.net,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>, Shawn Guo <shawnguo@kernel.org>,
	Sascha Hauer <s.hauer@pengutronix.de>,
	Pengutronix Kernel Team <kernel@pengutronix.de>,
	Fabio Estevam <festevam@gmail.com>,
	Richard Cochran <richardcochran@gmail.com>, netdev@vger.kernel.org,
	devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
	imx@lists.linux.dev, linux-arm-kernel@lists.infradead.org
Subject: Re: [PATCH v3 4/4] net: mtip: The L2 switch driver for imx287
Message-ID: <d48796b3-636b-46d4-8e3b-74913d4f77ab@lunn.ch>
References: <20250331103116.2223899-1-lukma@denx.de>
 <20250331103116.2223899-5-lukma@denx.de>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250331103116.2223899-5-lukma@denx.de>

> +struct switch_enet_private *mtip_netdev_get_priv(const struct net_device *ndev)
> +{
> +	if (ndev->netdev_ops == &mtip_netdev_ops)
> +		return netdev_priv(ndev);
> +
> +	return NULL;
> +}

> +static bool mtip_port_dev_check(const struct net_device *ndev)
> +{
> +	if (!mtip_netdev_get_priv(ndev))
> +		return false;
> +
> +	return true;
> +}

This appears to be the only use of mtip_netdev_get_priv(). It does not
care what priv actually is. In my previous review i said i think you
can simply this. I still think that is true.

    Andrew

