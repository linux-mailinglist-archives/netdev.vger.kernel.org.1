Return-Path: <netdev+bounces-166205-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B880AA34EFB
	for <lists+netdev@lfdr.de>; Thu, 13 Feb 2025 21:05:21 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 3EBEC3AB9C4
	for <lists+netdev@lfdr.de>; Thu, 13 Feb 2025 20:05:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A1D0724A04C;
	Thu, 13 Feb 2025 20:05:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b="wo2J7mL7"
X-Original-To: netdev@vger.kernel.org
Received: from vps0.lunn.ch (vps0.lunn.ch [156.67.10.101])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EBC2728A2CF;
	Thu, 13 Feb 2025 20:05:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=156.67.10.101
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739477117; cv=none; b=H3945zLmJy6LSad7nqG3LfFWYO5KrAAg0i3VOGD7iCP+zKXFIneNRy5VSIPXm9t9YK6XB8h7Z7hf+qUF1SN38hS4gi+8/OHTGbR10hznEz8DUTxb1Cr1z0purBlaYG9Wq2wcT+PBbZmWm1HS0FeYt46EmOm5duTX3JySP2WXlaw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739477117; c=relaxed/simple;
	bh=3BHHUpa7DXsnveOQCqApXkhQSb06i8xLLd/CiXMTYnA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=HtZNT1cRgHmf9G4OKsv2/PuJUGrrdd2lUCfMtEtLEPhEr2moX3a9v2jsfOovLeZzRsnfudWfg17jaEIttQr+Nnrvpn1SVPgMnlg4mBiGk9FyzsHwGWY6QYS9HM7aDuyPAjkymsBG10umbeBscKVe82+RubfdpHwJFkBYk11UAcU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch; spf=pass smtp.mailfrom=lunn.ch; dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b=wo2J7mL7; arc=none smtp.client-ip=156.67.10.101
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lunn.ch
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=lunn.ch;
	s=20171124; h=In-Reply-To:Content-Disposition:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:From:Sender:Reply-To:Subject:
	Date:Message-ID:To:Cc:MIME-Version:Content-Type:Content-Transfer-Encoding:
	Content-ID:Content-Description:Content-Disposition:In-Reply-To:References;
	bh=BopmD4ej1I3AySyHOCfQho1AKWCgy8rC+MWDvyWeOos=; b=wo2J7mL7Skv0L0q4St2tatLz+6
	FsaFza7R224gXzAZh4QMQ68m9JL500OsUXuRH1AizeOGljHYnYsu1nbN5A4vWgwvSCkuSMqQxZGUb
	57at/GYLvjYXCcLm0w5Z/oW7+1cNg9lqw3oIjwTDwk+3vLCiL47/N7VMqzt5ty7qDrKA=;
Received: from andrew by vps0.lunn.ch with local (Exim 4.94.2)
	(envelope-from <andrew@lunn.ch>)
	id 1tifSN-00Dqa0-By; Thu, 13 Feb 2025 21:05:07 +0100
Date: Thu, 13 Feb 2025 21:05:07 +0100
From: Andrew Lunn <andrew@lunn.ch>
To: Jijie Shao <shaojijie@huawei.com>
Cc: davem@davemloft.net, edumazet@google.com, kuba@kernel.org,
	pabeni@redhat.com, andrew+netdev@lunn.ch, horms@kernel.org,
	shenjian15@huawei.com, wangpeiyang1@huawei.com,
	liuyonglong@huawei.com, chenhao418@huawei.com,
	sudongming1@huawei.com, xujunsheng@huawei.com,
	shiyongbang@huawei.com, libaihan@huawei.com,
	jonathan.cameron@huawei.com, shameerali.kolothum.thodi@huawei.com,
	salil.mehta@huawei.com, netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH net-next 5/7] net: hibmcge: Add mac link exception
 handling feature in this module
Message-ID: <dc22a252-2889-4b20-b72c-5e4d44d24f88@lunn.ch>
References: <20250213035529.2402283-1-shaojijie@huawei.com>
 <20250213035529.2402283-6-shaojijie@huawei.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250213035529.2402283-6-shaojijie@huawei.com>

> +int hbg_reset_phy(struct hbg_priv *priv)
> +{
> +	struct phy_device *phydev = priv->mac.phydev;
> +
> +	if (phydev->drv->soft_reset)
> +		return phydev->drv->soft_reset(phydev);
> +
> +	return genphy_soft_reset(phydev);
> +}

A MAC driver should not be doing a soft reset on a PHY. For some
devices, this clears out all the settings. I would suggest you use
phy_stop(), phy_start() which are functions a MAC driver is allowed to
use.

	Andrew

