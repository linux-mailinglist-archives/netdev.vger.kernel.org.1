Return-Path: <netdev+bounces-233742-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id A94E5C17E43
	for <lists+netdev@lfdr.de>; Wed, 29 Oct 2025 02:26:25 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 75DAD4EC1BF
	for <lists+netdev@lfdr.de>; Wed, 29 Oct 2025 01:26:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5010A2D3A96;
	Wed, 29 Oct 2025 01:26:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="idNYHHoX"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 27BC617B50F;
	Wed, 29 Oct 2025 01:26:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761701167; cv=none; b=qkY/BrAjWRCFtM1RmnGFJcol3qWqy31U3skFML7riueTiqoc/XtdJpVSCQCZKNc19aYRt7+k5N9kenNVoEXTTX41FiGBea2yhhoSdMI3t9Cd8/XmZOfBfLPg0L8oeAQOFu4CzkCooVFrvo0fZCZnTpYqNHhs+SkjChB690/+e70=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761701167; c=relaxed/simple;
	bh=6lVql+4xrJUU8L0Plfqy3I66gi1LL1lw3Wf2hqWqjH0=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=K/8j72Im32+7bNWpHakwlaDYEtPpQZ7MQ1f82Qd1LT73lOvki+ZPQnHzy/SQEha32tJXts3J1b/qOMnKStBK0ju3IOQ4UFUVvc+KmFbSFMcdy+VOwKEi4GmHTAaT9TJ2QD4s/MIk5dwJeRHdpXS/968YqefuED6Bo0optXsPd0E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=idNYHHoX; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 93617C4CEE7;
	Wed, 29 Oct 2025 01:26:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1761701167;
	bh=6lVql+4xrJUU8L0Plfqy3I66gi1LL1lw3Wf2hqWqjH0=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=idNYHHoXRWUWxhq9Wp3VloF9yWGXyOnFvjtO4jhITTVgsT8HDlHwNf29Xazjj+Gg/
	 56qsOPQrwWo5yYkcGZgNj2ZAWyVnO7FPEMVHlDslCJky2x52ydnnAO2x6cbFeAK33L
	 +O4ZaZojt7sgTK/8gWkkwybGVHmOaqreM9HOzOabJjyqSjy+08XargkDtL8Aa6rg5G
	 9TCFldWOw6EfZ57BgiEuLdtAotuRPTcxataCHw0d4ZsERfhx3hl/YAO/CNvmy2H8X7
	 bUfMIxO0+0PZ+hCsN/TiSJ1X8880unnQUwa6ZbGym/QOofanFn/oICq1X20Jxr+F8O
	 qoTB87pHKHFUA==
Date: Tue, 28 Oct 2025 18:26:05 -0700
From: Jakub Kicinski <kuba@kernel.org>
To: Buday Csaba <buday.csaba@prolan.hu>
Cc: Andrew Lunn <andrew@lunn.ch>, Heiner Kallweit <hkallweit1@gmail.com>,
 Russell King <linux@armlinux.org.uk>, "David S. Miller"
 <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, Paolo Abeni
 <pabeni@redhat.com>, Philipp Zabel <p.zabel@pengutronix.de>,
 <netdev@vger.kernel.org>, <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH net-next v4 4/4] net: mdio: reset PHY before attempting
 to access registers in fwnode_mdiobus_register_phy
Message-ID: <20251028182605.06840664@kernel.org>
In-Reply-To: <bebbaef2c6801f6973ea00500a594ed934e40e47.1761124022.git.buday.csaba@prolan.hu>
References: <cover.1761124022.git.buday.csaba@prolan.hu>
	<bebbaef2c6801f6973ea00500a594ed934e40e47.1761124022.git.buday.csaba@prolan.hu>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Wed, 22 Oct 2025 11:08:53 +0200 Buday Csaba wrote:
> +/* Hard-reset a PHY before registration */
> +static int fwnode_reset_phy(struct mii_bus *bus, u32 addr,
> +			    struct fwnode_handle *phy_node)
> +{
> +	struct mdio_device *tmpdev;
> +	int err;
> +
> +	tmpdev = mdio_device_create(bus, addr);
> +	if (IS_ERR(tmpdev))
> +		return PTR_ERR(tmpdev);
> +
> +	fwnode_handle_get(phy_node);
> +	device_set_node(&tmpdev->dev, phy_node);
> +	err = mdio_device_register_reset(tmpdev);
> +	if (err) {
> +		mdio_device_free(tmpdev);
> +		return err;

Should we worry about -EPROBE_DEFER on any of the error paths here?
If not maybe consider making this function void? We can add errors
back if the caller starts to care.

> +	}
> +
> +	if (mdio_device_has_reset(tmpdev)) {
> +		dev_info(&bus->dev,
> +			 "PHY device at address %d not detected, resetting PHY.",
> +			 addr);

IDK if this is still strictly necessary but I guess \n at the end of
the info msg would be idiomatic

