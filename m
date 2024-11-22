Return-Path: <netdev+bounces-146875-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id C7E759D6639
	for <lists+netdev@lfdr.de>; Sat, 23 Nov 2024 00:10:23 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 8D1D5281425
	for <lists+netdev@lfdr.de>; Fri, 22 Nov 2024 23:10:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4994F18BC15;
	Fri, 22 Nov 2024 23:10:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b="u9S0ygg/"
X-Original-To: netdev@vger.kernel.org
Received: from vps0.lunn.ch (vps0.lunn.ch [156.67.10.101])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5A08C189BBA;
	Fri, 22 Nov 2024 23:10:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=156.67.10.101
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732317019; cv=none; b=a1uls37+tTJxAtLDOACQ9bF15BphH90xZZIYH4dFS0QSh9ZwQQhNrUnXHjHp2BABl14hH0O8V5e+PURGmYrmz9swncz1y8nBwjZ3rAu2D5H/9D0tRsgsbtYI+il07zXU4DSM+1WTXm8MdU8NWuAfecQu+S71jhuqsHH/CdQDteI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732317019; c=relaxed/simple;
	bh=KtRj3iNPDh03ln2nGA49Y6qq97KDf9A+3sK2WgArvrM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=l0GA03K8ndlXySsaMT8lBv9CLzLWokhoTyhMHG9NwNp1/yAkZH0QjwQ4/uIDel35Z4DuyOdsNdhQ5o8/oeRVcSqEXEAbp1AncLUTIpTr49NSMKtK+Km2FJATQALISBFWTiqs+bmwhJf11SWV9FWi4Y6kdBSGeOtongHMZe9U01Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch; spf=pass smtp.mailfrom=lunn.ch; dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b=u9S0ygg/; arc=none smtp.client-ip=156.67.10.101
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lunn.ch
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=lunn.ch;
	s=20171124; h=In-Reply-To:Content-Disposition:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:From:Sender:Reply-To:Subject:
	Date:Message-ID:To:Cc:MIME-Version:Content-Type:Content-Transfer-Encoding:
	Content-ID:Content-Description:Content-Disposition:In-Reply-To:References;
	bh=Uaxnd6v9igUqbrx4Ej/11lAA/asleA0Szqf9DF1phjw=; b=u9S0ygg/rW248vMf2n/wb6588/
	wwTcQPkKmZYUvQPBNQMsZn8wiyv5K97gDfjSwKTVfQ/wWwwoCANghk6U9rcM/4jjINQX3gpKuzIXz
	KU6pK2lvyMOZSFwsO0Ukc6jxCdralL3qrvSLunz4Y21+R3SM/YXZw3U8VmwmZehhzzbI=;
Received: from andrew by vps0.lunn.ch with local (Exim 4.94.2)
	(envelope-from <andrew@lunn.ch>)
	id 1tEcmw-00EAtm-Lu; Sat, 23 Nov 2024 00:10:10 +0100
Date: Sat, 23 Nov 2024 00:10:10 +0100
From: Andrew Lunn <andrew@lunn.ch>
To: Frank Sae <Frank.Sae@motor-comm.com>
Cc: davem@davemloft.net, edumazet@google.com, kuba@kernel.org,
	pabeni@redhat.com, netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org, xiaogang.fan@motor-comm.com,
	fei.zhang@motor-comm.com, hua.sun@motor-comm.com
Subject: Re: [PATCH net-next v2 15/21] motorcomm:yt6801: Implement pci_driver
 suspend and resume
Message-ID: <05af1645-9355-4d1d-9aa2-fd5e42e8fad4@lunn.ch>
References: <20241120105625.22508-1-Frank.Sae@motor-comm.com>
 <20241120105625.22508-16-Frank.Sae@motor-comm.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20241120105625.22508-16-Frank.Sae@motor-comm.com>

> +static int fxgmac_pre_powerdown(struct fxgmac_pdata *pdata)
> +{
> +	u32 val = 0;
> +	int ret;
> +
> +	fxgmac_disable_rx(pdata);
> +
> +	yt_dbg(pdata, "%s, phy and mac status update\n", __func__);
> +
> +	if (device_may_wakeup(pdata->dev)) {
> +		val = rd32_mem(pdata, EPHY_CTRL);
> +		if (val & EPHY_CTRL_STA_LINKUP) {
> +			ret = phy_speed_down(pdata->phydev, true);
> +			if (ret < 0) {
> +				yt_err(pdata, "%s, phy_speed_down err:%d\n", __func__, ret);
> +				return ret;
> +			}
> +
> +			ret = phy_read_status(pdata->phydev);
> +			if (ret < 0) {
> +				yt_err(pdata, "%s, phy_read_status err:%d\n",
> +				       __func__, ret);
> +				return ret;
> +			}
> +
> +			pdata->phy_speed = pdata->phydev->speed;
> +			pdata->phy_duplex = pdata->phydev->duplex;
> +			yt_dbg(pdata, "%s, speed :%d, duplex :%d\n", __func__,
> +			       pdata->phy_speed, pdata->phy_duplex);
> +
> +			fxgmac_config_mac_speed(pdata);

phy_speed_down() will trigger an autoneg cycle. Once the link has
established the adjust_link callback will be called telling you the
new speed and duplex. The only time you can safely access
phydev->speed and phydev->duplex is during that callback. At other
times the values can be inconsistent.

	Andrew

