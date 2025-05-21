Return-Path: <netdev+bounces-192295-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 7FB5AABF475
	for <lists+netdev@lfdr.de>; Wed, 21 May 2025 14:39:05 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 9FE8F1BC14F3
	for <lists+netdev@lfdr.de>; Wed, 21 May 2025 12:39:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F2B8B264A70;
	Wed, 21 May 2025 12:39:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b="Yvg9H27L"
X-Original-To: netdev@vger.kernel.org
Received: from vps0.lunn.ch (vps0.lunn.ch [156.67.10.101])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0B26E25F780
	for <netdev@vger.kernel.org>; Wed, 21 May 2025 12:38:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=156.67.10.101
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747831141; cv=none; b=bZD1vB1ey+yXKBhMGgjAk8Odi7RCc9cI/WHq5H5NDgJAgwe+Z84kxYtu5IwIF0L5ieDEaDwfGPi3yB9a+qtmbevgGCpNA3C7iuNrc28qrr+Lf1aDw4g/Lt6P8L7v1tWUdEIy8dLO+0yJFHm7KqRPoGMiQFw16iPlFLe5veRfbBQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747831141; c=relaxed/simple;
	bh=qWMAPGB9xFxH0t20J6WKXEgnY4vN/FHrVAh0RLd6Q38=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=RVZGFek3vg7UPhJeZaZZuLtzNQM2+tAj1zlzn4DVE4TTWlSbrwcCKwKYEtQ7bIB0plhfkmodFSZ9YLsq8oom0lGoThlfR8dMQWK9PramXZ5/KLhXuvHr0ef/FKEEf0U8krXJVmQxhnNJheZHow6LuhHD2k/Wp7K4Y81H0abrVXc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch; spf=pass smtp.mailfrom=lunn.ch; dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b=Yvg9H27L; arc=none smtp.client-ip=156.67.10.101
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lunn.ch
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=lunn.ch;
	s=20171124; h=In-Reply-To:Content-Disposition:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:From:Sender:Reply-To:Subject:
	Date:Message-ID:To:Cc:MIME-Version:Content-Type:Content-Transfer-Encoding:
	Content-ID:Content-Description:Content-Disposition:In-Reply-To:References;
	bh=/VsUTiGm3Nqk3gcBgf9r0gZcCoay07Dn2jWkPIaWuAA=; b=Yvg9H27L6BzTvbkji382HdjjVH
	yurZnREZoSaiBR+xoQERiIEGdvxwXB7cS+SXDwhp6A9VeX0vgrlsA1mQzWtTUxUxnhuByJLHJAKBK
	A4LLRuVkJWAl5vH0TQc2gTSD3vqI0BI5BTR3kuwwLeIyA4SXHHcLLG2w6FctfpwemhJ8=;
Received: from andrew by vps0.lunn.ch with local (Exim 4.94.2)
	(envelope-from <andrew@lunn.ch>)
	id 1uHiim-00DGoZ-Cm; Wed, 21 May 2025 14:38:56 +0200
Date: Wed, 21 May 2025 14:38:56 +0200
From: Andrew Lunn <andrew@lunn.ch>
To: David Arinzon <darinzon@amazon.com>
Cc: David Miller <davem@davemloft.net>, Jakub Kicinski <kuba@kernel.org>,
	netdev@vger.kernel.org, Eric Dumazet <edumazet@google.com>,
	Paolo Abeni <pabeni@redhat.com>, Simon Horman <horms@kernel.org>,
	Richard Cochran <richardcochran@gmail.com>,
	"Woodhouse, David" <dwmw@amazon.com>,
	"Machulsky, Zorik" <zorik@amazon.com>,
	"Matushevsky, Alexander" <matua@amazon.com>,
	Saeed Bshara <saeedb@amazon.com>, "Wilson, Matt" <msw@amazon.com>,
	"Liguori, Anthony" <aliguori@amazon.com>,
	"Bshara, Nafea" <nafea@amazon.com>,
	"Schmeilin, Evgeny" <evgenys@amazon.com>,
	"Belgazal, Netanel" <netanel@amazon.com>,
	"Saidi, Ali" <alisaidi@amazon.com>,
	"Herrenschmidt, Benjamin" <benh@amazon.com>,
	"Kiyanovski, Arthur" <akiyano@amazon.com>,
	"Dagan, Noam" <ndagan@amazon.com>,
	"Bernstein, Amit" <amitbern@amazon.com>,
	"Agroskin, Shay" <shayagr@amazon.com>,
	"Ostrovsky, Evgeny" <evostrov@amazon.com>,
	"Tabachnik, Ofir" <ofirt@amazon.com>,
	"Machnikowski, Maciek" <maciek@machnikowski.net>,
	Rahul Rameshbabu <rrameshbabu@nvidia.com>,
	Gal Pressman <gal@nvidia.com>,
	Vadim Fedorenko <vadim.fedorenko@linux.dev>,
	Leon Romanovsky <leon@kernel.org>
Subject: Re: [PATCH v9 net-next 5/8] net: ena: Add debugfs support to the ENA
 driver
Message-ID: <0754879f-5dbe-4748-8af3-0a588c90bcc0@lunn.ch>
References: <20250521114254.369-1-darinzon@amazon.com>
 <20250521114254.369-6-darinzon@amazon.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250521114254.369-6-darinzon@amazon.com>

> +void ena_debugfs_init(struct net_device *dev)
> +{
> +	struct ena_adapter *adapter = netdev_priv(dev);
> +
> +	adapter->debugfs_base =
> +		debugfs_create_dir(dev_name(&adapter->pdev->dev), NULL);
> +	if (IS_ERR(adapter->debugfs_base))
> +		netdev_err(dev, "Failed to create debugfs dir\n");

Don't check return codes from debugfs_ calls. It does not matter if it
fails, it is just debug, and all debugfs_ calls are happy to take a
NULL pointer, ERR_PTR() etc.

	Andrew

