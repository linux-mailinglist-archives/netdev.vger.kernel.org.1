Return-Path: <netdev+bounces-61602-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 1EB7A8245FB
	for <lists+netdev@lfdr.de>; Thu,  4 Jan 2024 17:17:49 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id AE6B71F21EC5
	for <lists+netdev@lfdr.de>; Thu,  4 Jan 2024 16:17:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CF20D24A19;
	Thu,  4 Jan 2024 16:17:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b="TUgPjPe/"
X-Original-To: netdev@vger.kernel.org
Received: from relay5-d.mail.gandi.net (relay5-d.mail.gandi.net [217.70.183.197])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C981624A1F
	for <netdev@vger.kernel.org>; Thu,  4 Jan 2024 16:17:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bootlin.com
Received: by mail.gandi.net (Postfix) with ESMTPSA id 9DB651C0007;
	Thu,  4 Jan 2024 16:17:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=gm1;
	t=1704385054;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=0ERV5hCJhkGOZWkG0u85yucJJrRaa+wHuhSFCaFV8bw=;
	b=TUgPjPe/GGxRtocpFjcFK86G4Dul95ASnlAun3AiS+34Dl8Q1QwOiaoYggd18uHfdUHemO
	gJZzQkJx1FvG3yO3PVf007JEjcR0dzGdaOiASirrQw9vTJJU7pCZuI7Rh6x41FQbX+hbdb
	w+VP5V3SLtV3EmOAvnfmwST48PRg05ceuI8Xn0uqnpEV8mjSLP71bZovyf7jVC3avL3kt8
	ycPCmHsbvuLL7nVbrkOf713/wGrLEeSRRo+vmSTPCfLMptQJVDPduvCOrv3A28i4nBl7Ef
	63+eDYvc8P8FtKcjGAqVcHtH5Kd+dsiiZYb4q7tAvm9hgMLsAaDpwrSGjMjCkw==
Date: Thu, 4 Jan 2024 17:17:32 +0100
From: Maxime Chevallier <maxime.chevallier@bootlin.com>
To: Marek =?UTF-8?B?QmVow7pu?= <kabel@kernel.org>
Cc: Michal Kubecek <mkubecek@suse.cz>, netdev@vger.kernel.org, Andrew Lunn
 <andrew@lunn.ch>, Russell King <linux@armlinux.org.uk>, Heiner Kallweit
 <hkallweit1@gmail.com>
Subject: Re: ethtool ioctl ABI: preferred way to expand uapi structure
 ethtool_eee for additional link modes?
Message-ID: <20240104171732.5a3219b1@device-28.home>
In-Reply-To: <20240104161416.05d02400@dellmb>
References: <20240104161416.05d02400@dellmb>
Organization: Bootlin
X-Mailer: Claws Mail 4.2.0 (GTK 3.24.39; x86_64-redhat-linux-gnu)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
X-GND-Sasl: maxime.chevallier@bootlin.com

Hello Marek,

On Thu, 4 Jan 2024 16:14:16 +0100
Marek Beh=C3=BAn <kabel@kernel.org> wrote:

> Hello,
>=20
> the legacy ioctls ETHTOOL_GSET and ETHTOOL_SSET, which pass structure
> ethtool_cmd, were superseded by ETHTOOL_GLINKSETTINGS and
> ETHTOOL_SLINKSETTINGS.
>=20
> This was done because the original structure only contains 32-bit words
> for supported, advertising and lp_advertising link modes. The new
> structure ethtool_link_settings contains member
>   s8 link_mode_masks_nwords;
> and a flexible array
>   __u32 link_mode_masks[];
> in order to overcome this issue.
>=20
> But currently we still have only legacy structure ethtool_eee for EEE
> settings:
>   struct ethtool_eee {
>     __u32 cmd;
>     __u32 supported;
>     __u32 advertised;
>     __u32 lp_advertised;
>     __u32 eee_active;
>     __u32 eee_enabled;
>     __u32 tx_lpi_enabled;
>     __u32 tx_lpi_timer;
>     __u32 reserved[2];
>   };
>=20
> Thus ethtool is unable to get/set EEE configuration for example for
> 2500base-T and 5000base-T link modes, which are now available in
> several PHY drivers.

If I am not mistake, I think this series from Heiner tries to address
exactly that :
https://lore.kernel.org/netdev/783d4a61-2f08-41fc-b91d-bd5f512586a2@gmail.c=
om/

Thanks,

Maxime

