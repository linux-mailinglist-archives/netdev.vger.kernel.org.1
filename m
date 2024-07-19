Return-Path: <netdev+bounces-112159-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 70F6A9372CE
	for <lists+netdev@lfdr.de>; Fri, 19 Jul 2024 05:41:27 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id A32B61C21223
	for <lists+netdev@lfdr.de>; Fri, 19 Jul 2024 03:41:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8527C18EAD;
	Fri, 19 Jul 2024 03:41:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b="upO//+/5"
X-Original-To: netdev@vger.kernel.org
Received: from vps0.lunn.ch (vps0.lunn.ch [156.67.10.101])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AE949B647;
	Fri, 19 Jul 2024 03:41:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=156.67.10.101
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721360481; cv=none; b=tQQK1Ks6wxBA3xAPeLR0+BcJI3AikGwnza6gEALA6r+ptZv0w/XdeKR+6FLbKMaMtLsk0WhTAeEuFV9rLfGxol5QE3JRLXYHZtWDFFy86v9b5vW/wtIS3C27tK7Iwx5YgCMD+b2Y56vc2L1oK3ldVYhNn9Rk/pCQuLHe/4rh3mI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721360481; c=relaxed/simple;
	bh=4WKdQq8GuoIscG7M0jS8ZeXv9mS/vGyTZ9wTvMGupak=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=XChF0wo7B7quM0/iAEKQYXLMmSs0hv3yCKhFK+xsMyDDCyzI2dil20l3Nd7qpODTng2vfOLYu9mYIhXKd2VsoVuU/yeEsNz32LPghSWChKWOv6wJa/T+eB7bhwpgpGMQSEo551nAX9Mdv4Ol3czwdPrAucCtfvixriYuNXFQo+w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch; spf=pass smtp.mailfrom=lunn.ch; dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b=upO//+/5; arc=none smtp.client-ip=156.67.10.101
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lunn.ch
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=lunn.ch;
	s=20171124; h=In-Reply-To:Content-Disposition:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:From:Sender:Reply-To:Subject:
	Date:Message-ID:To:Cc:MIME-Version:Content-Type:Content-Transfer-Encoding:
	Content-ID:Content-Description:Content-Disposition:In-Reply-To:References;
	bh=LccjuBpq1WI9w8ftUT3alSqaP6+1EeLDsXgofkwSyXw=; b=upO//+/5SvhSGctofyVU7VFUOi
	R5uCSVv9Oua7ozMH79AKrh/0DJFYI5JzPv+fsFPGps/jiNkNqLZ2s9uMFLt/uRJCepOM+TS6dbv4h
	tC2yP1fvfgtMF7VjRccUA1wr0NVTPVh/CTsTYvbcdHBO4Fulr2KCNOcxc5m2qgTEczP4=;
Received: from andrew by vps0.lunn.ch with local (Exim 4.94.2)
	(envelope-from <andrew@lunn.ch>)
	id 1sUeUT-002oc2-QT; Fri, 19 Jul 2024 05:41:05 +0200
Date: Fri, 19 Jul 2024 05:41:05 +0200
From: Andrew Lunn <andrew@lunn.ch>
To: Jon Hunter <jonathanh@nvidia.com>
Cc: Bartosz Golaszewski <brgl@bgdev.pl>,
	Heiner Kallweit <hkallweit1@gmail.com>,
	Russell King <linux@armlinux.org.uk>,
	"David S . Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
	Bartosz Golaszewski <bartosz.golaszewski@linaro.org>,
	"linux-tegra@vger.kernel.org" <linux-tegra@vger.kernel.org>,
	Brad Griffis <bgriffis@nvidia.com>
Subject: Re: [RESEND PATCH net-next v3 3/4] net: phy: aquantia: wait for the
 GLOBAL_CFG to start returning real values
Message-ID: <708b9c82-afdd-46b7-ad63-b0e65be23b6b@lunn.ch>
References: <20240708075023.14893-1-brgl@bgdev.pl>
 <20240708075023.14893-4-brgl@bgdev.pl>
 <7c0140be-4325-4005-9068-7e0fc5ff344d@nvidia.com>
 <CAMRc=McF93F6YsQ+eT9oOe+c=2ZCQ3rBdj+-3Ruy8iO1B-syjw@mail.gmail.com>
 <CAMRc=Mc=8Sa76TOZujMMZcaF2Dc8OL_HKo=gXuj-YALaH4zKHg@mail.gmail.com>
 <6e12f5a5-8007-4ddc-a5ad-be556656af71@nvidia.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <6e12f5a5-8007-4ddc-a5ad-be556656af71@nvidia.com>

> Interestingly, the product brief for these PHYs [0] do show that both the
> AQR113C and AQR115C both support 10M. So I wonder if it is our ethernet
> controller that is not supporting 10M? I will check on this too.

The PHY should enumerate what it supports, look at
genphy_read_abilities(), which reads the Basic Mode Status Register,
and there are bits in there which indicate if the PHY supports 10Half
and 10Full.

The MAC should also be indicating what it support, and ethtool will be
showing you the combination of the two.

	Andrew

