Return-Path: <netdev+bounces-146878-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 544C09D6648
	for <lists+netdev@lfdr.de>; Sat, 23 Nov 2024 00:19:33 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id D630A160784
	for <lists+netdev@lfdr.de>; Fri, 22 Nov 2024 23:19:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 80B7E18A944;
	Fri, 22 Nov 2024 23:19:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b="1AzRg2vM"
X-Original-To: netdev@vger.kernel.org
Received: from vps0.lunn.ch (vps0.lunn.ch [156.67.10.101])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C3DCA175A5;
	Fri, 22 Nov 2024 23:19:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=156.67.10.101
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732317570; cv=none; b=HVebt1MwfEtTpwxmvc9JhMVHEs+fzOeAgNWCPTTCIVOLKcrQBWt4B5NiKdpjuxMyoPWc6IhY6c/t0zzbePZwXCLjtZHuDaxovRUD1Hpa5b/HGz5iQ0fJ5EIjlPi/NM3H9jlplQCJZPsst37xQGJgtv0TL4F/OWvlAYDCifrTOv8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732317570; c=relaxed/simple;
	bh=oUVjIaFmKm2QbHvYVQLew59YYhT4QWEjxn/pUNVRugE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=k7NvGg9FtTz/ZYVRFzGzDKHOsuQMcztUpy7qxQ+XC2cfl+hzAhl4/pbvwoOPUZGbNhZClsWer9tVexnfOILPSA0Ji9sIsLEaROPyTeFM3ooQS/5ooCXlq67D7iaqLbKdgNsTe6OKAjIxCw5LHNGVt7byQSN0nsnfg82ZPDE9r04=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch; spf=pass smtp.mailfrom=lunn.ch; dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b=1AzRg2vM; arc=none smtp.client-ip=156.67.10.101
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lunn.ch
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=lunn.ch;
	s=20171124; h=In-Reply-To:Content-Disposition:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:From:Sender:Reply-To:Subject:
	Date:Message-ID:To:Cc:MIME-Version:Content-Type:Content-Transfer-Encoding:
	Content-ID:Content-Description:Content-Disposition:In-Reply-To:References;
	bh=4ATYHRcZENvMxk7zHawVsyJCwK0O5e/Zw032fcPXSSI=; b=1AzRg2vM2BVjFZYEazZSR14J0/
	PY0M9uvz3gEG3OnJ0pXR8ik5ISzQsRiILuSzaDUY+gzO8cKgLmQUxNhjGXtMq6M0hdxeSvQHokR9z
	7M0Seyew1rWknqaoH0ZwGufEeOsaMjnwZN1D77FbIVXVTc7Mr3lDjrgRTXLScOEwtw78=;
Received: from andrew by vps0.lunn.ch with local (Exim 4.94.2)
	(envelope-from <andrew@lunn.ch>)
	id 1tEcvr-00EAxG-81; Sat, 23 Nov 2024 00:19:23 +0100
Date: Sat, 23 Nov 2024 00:19:23 +0100
From: Andrew Lunn <andrew@lunn.ch>
To: Frank Sae <Frank.Sae@motor-comm.com>
Cc: davem@davemloft.net, edumazet@google.com, kuba@kernel.org,
	pabeni@redhat.com, netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org, xiaogang.fan@motor-comm.com,
	fei.zhang@motor-comm.com, hua.sun@motor-comm.com
Subject: Re: [PATCH net-next v2 12/21] motorcomm:yt6801: Implement
 .ndo_tx_timeout and .ndo_change_mtu functions
Message-ID: <581643c0-7813-4203-aacb-07c2eca73b88@lunn.ch>
References: <20241120105625.22508-1-Frank.Sae@motor-comm.com>
 <20241120105625.22508-13-Frank.Sae@motor-comm.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20241120105625.22508-13-Frank.Sae@motor-comm.com>

> +static int fxgmac_change_mtu(struct net_device *netdev, int mtu)
> +{
> +	struct fxgmac_pdata *pdata = netdev_priv(netdev);
> +	int old_mtu = netdev->mtu;
> +	int ret;
> +
> +	mutex_lock(&pdata->mutex);
> +	fxgmac_stop(pdata);
> +	fxgmac_free_tx_data(pdata);
> +
> +	/* We must unmap rx desc's dma before we change rx_buf_size.
> +	 * Becaues the size of the unmapped DMA is set according to rx_buf_size
> +	 */
> +	fxgmac_free_rx_data(pdata);
> +	pdata->jumbo = mtu > ETH_DATA_LEN ? 1 : 0;
> +	ret = fxgmac_calc_rx_buf_size(pdata, mtu);
> +	if (ret < 0)
> +		return ret;
> +
> +	pdata->rx_buf_size = ret;
> +	netdev->mtu = mtu;
> +
> +	if (netif_running(netdev))
> +		fxgmac_start(pdata);
> +
> +	netdev_update_features(netdev);
> +
> +	mutex_unlock(&pdata->mutex);

I don't see anything here handling pause when changing to/from jumbo.
Is it hiding somewhere?

	Andrew

