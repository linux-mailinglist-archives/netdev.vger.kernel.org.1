Return-Path: <netdev+bounces-234732-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id A8BA1C26AC9
	for <lists+netdev@lfdr.de>; Fri, 31 Oct 2025 20:09:24 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 70A613B1D4D
	for <lists+netdev@lfdr.de>; Fri, 31 Oct 2025 19:09:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F35232F6917;
	Fri, 31 Oct 2025 19:09:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b="Rh4RskUx"
X-Original-To: netdev@vger.kernel.org
Received: from vps0.lunn.ch (vps0.lunn.ch [156.67.10.101])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B7F852F4A0E;
	Fri, 31 Oct 2025 19:09:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=156.67.10.101
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761937760; cv=none; b=XECkXuQ0iQpuBDHeeRoDxAdZkaHgwmX5hCfhzz3nYKJ2DnRtkBO4MzKybEPC/bIMHTp8cQHuha0a9bNGxt8ExfzyEi/vFlzdxOlJAERgJRcxm3HoZV+3vICuixh5ZdQBA4rmkqZxAf3EZMXX5/Wyq2rgFRIcEgTyUBxk4ziIDaw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761937760; c=relaxed/simple;
	bh=8qiCPwTgnNfDHjbq6rSc285bTMBEqC9dApMvKPkE0cE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=rh8Bf0EfN5JyZ6Gdk/hUabWgXQiDQLgP06+E1cOAmMKNNgc2xlmYkNVqQZInEq2eudf7t3snkO0JEvlEfmwAFbwJ62s4YSAipolg6sCeO6/JGA8f2aCgUyuu3hG6xwcP4JKvN1UaFMdn8Ac3ra060qsMAHI79hZc2RR6OzCp1fs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch; spf=pass smtp.mailfrom=lunn.ch; dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b=Rh4RskUx; arc=none smtp.client-ip=156.67.10.101
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lunn.ch
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=lunn.ch;
	s=20171124; h=In-Reply-To:Content-Disposition:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:From:Sender:Reply-To:Subject:
	Date:Message-ID:To:Cc:MIME-Version:Content-Type:Content-Transfer-Encoding:
	Content-ID:Content-Description:Content-Disposition:In-Reply-To:References;
	bh=fZbwnF0IXrXAvskVUJyWEUURmd1EUkmYdeFz0aHKm0w=; b=Rh4RskUximfWawYaQMpIiNGE4b
	sigRhS3iY6SvDjtSm8658JQepX0r+I62HFBmr8JRqqEjyGE/9k+3n1tNskalQwnkexpKLQstxm7f2
	ecw66PEigqEOLQ8QXM67bDR3jyPQDi4VIJPGz66DetkJVV4OCEa7I0dpygDToOFxl1bk=;
Received: from andrew by vps0.lunn.ch with local (Exim 4.94.2)
	(envelope-from <andrew@lunn.ch>)
	id 1vEuUa-00Ccto-Al; Fri, 31 Oct 2025 20:08:56 +0100
Date: Fri, 31 Oct 2025 20:08:56 +0100
From: Andrew Lunn <andrew@lunn.ch>
To: Vivian Wang <wangruikang@iscas.ac.cn>
Cc: Andrew Lunn <andrew+netdev@lunn.ch>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	Yixun Lan <dlan@gentoo.org>,
	Maxime Chevallier <maxime.chevallier@bootlin.com>,
	Troy Mitchell <troy.mitchell@linux.spacemit.com>,
	Vadim Fedorenko <vadim.fedorenko@linux.dev>, netdev@vger.kernel.org,
	linux-riscv@lists.infradead.org, spacemit@lists.linux.dev,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH net v2] net: spacemit: Check IFF_UP in
 emac_set_pauseparam()
Message-ID: <f2303a61-184a-4a4b-adfe-228573dcb41c@lunn.ch>
References: <20251101-k1-ethernet-remove-fc-v2-1-014ac3bc280e@iscas.ac.cn>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20251101-k1-ethernet-remove-fc-v2-1-014ac3bc280e@iscas.ac.cn>

> +	if (!(dev->flags & IFF_UP))
> +		return -ENETDOWN;
> +

This is a lot better, but please use netif_running().

    Andrew

---
pw-bot: cr

