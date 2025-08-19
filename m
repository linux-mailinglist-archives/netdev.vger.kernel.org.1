Return-Path: <netdev+bounces-214853-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 7A875B2B713
	for <lists+netdev@lfdr.de>; Tue, 19 Aug 2025 04:35:35 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 4B3A87AB2B3
	for <lists+netdev@lfdr.de>; Tue, 19 Aug 2025 02:34:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 72EA6218ABD;
	Tue, 19 Aug 2025 02:35:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="JWLnKbPu"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 47815157E6B;
	Tue, 19 Aug 2025 02:35:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755570931; cv=none; b=LKkBPjHOnFY1cIOSiI8vnzgeKYKXGNB+7P+P6U//2Q2/VV+X5l9lszWpAppivQHlL3sMFbSEaVV/Mf1FbVeKdvlaoZi49seVe0YBbjDhtMXD3s/8o0tkSiWezEEwKT2Xvp2KqCnPU8qd1Lln/zlny4aQYfwJSaNnKc/Hi6V1ZJM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755570931; c=relaxed/simple;
	bh=JZIl/RDVfGiBvF896NQ1rSVbvjvYhCYvsXQ35Z7vriU=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=NJEAphwI8Huawp4Mmp2/ulnrDcv041tJUSNMaLmyia03VQkpNn6oe5VW1XHTUgiRe1kqeI9vcvrv9QneZeybdy5ZDQqXFYa93jdg8FP7voLyuKCl5+cPdnqLHUo+PJmXf79grswtxR4GDB9H7UYxchb2AmghCLGk7bAQjH4FqSc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=JWLnKbPu; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 30615C4CEEB;
	Tue, 19 Aug 2025 02:35:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1755570930;
	bh=JZIl/RDVfGiBvF896NQ1rSVbvjvYhCYvsXQ35Z7vriU=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=JWLnKbPu2IhWQL8ZQiPiPTFn5zqATCw1/Ou1YiJcn3NbkMTluLKGVkrMq8SoQLwNK
	 4mzac93Ql5i3ZsRdv84//B2z4iqpwaVzhku+MI2TYn2tb03SAbMUj54egM2b53p/yW
	 97sYAZf61sVztG4VxDyTI9dx06imXtLE2sNUlioj5BUymSStgT+TjQtNhn9xPXlsx3
	 Qu6BwsB3xJQl5Knih4XRPuEtHPl7K8uNbHUshw1bAaVvwXXbdcE8bvM3yk+VtMkQo9
	 YwvpgVfJZK48f+eNViycGIRiM+GbAnuI+GWkQhz2/8ukwkjS8Va13d+QgrE5KdF2Z4
	 DdGw1M6SNnvzQ==
Date: Mon, 18 Aug 2025 19:35:29 -0700
From: Jakub Kicinski <kuba@kernel.org>
To: Oleksij Rempel <o.rempel@pengutronix.de>
Cc: Andrew Lunn <andrew@lunn.ch>, "David S. Miller" <davem@davemloft.net>,
 Eric Dumazet <edumazet@google.com>, Paolo Abeni <pabeni@redhat.com>, Simon
 Horman <horms@kernel.org>, Donald Hunter <donald.hunter@gmail.com>,
 Jonathan Corbet <corbet@lwn.net>, Heiner Kallweit <hkallweit1@gmail.com>,
 Russell King <linux@armlinux.org.uk>, Kory Maincent
 <kory.maincent@bootlin.com>, Maxime Chevallier
 <maxime.chevallier@bootlin.com>, Nishanth Menon <nm@ti.com>,
 kernel@pengutronix.de, linux-kernel@vger.kernel.org,
 netdev@vger.kernel.org, UNGLinuxDriver@microchip.com,
 linux-doc@vger.kernel.org, Michal Kubecek <mkubecek@suse.cz>, Roan van Dijk
 <roan@protonic.nl>
Subject: Re: [PATCH net-next v2 3/5] ethtool: netlink: add lightweight MSE
 reporting to LINKSTATE_GET
Message-ID: <20250818193529.365d49fe@kernel.org>
In-Reply-To: <20250815063509.743796-4-o.rempel@pengutronix.de>
References: <20250815063509.743796-1-o.rempel@pengutronix.de>
	<20250815063509.743796-4-o.rempel@pengutronix.de>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Fri, 15 Aug 2025 08:35:07 +0200 Oleksij Rempel wrote:
> diff --git a/include/uapi/linux/ethtool_netlink_generated.h b/include/uapi/linux/ethtool_netlink_generated.h
> index 9c37a96a320b..6ef03a7de4ab 100644
> --- a/include/uapi/linux/ethtool_netlink_generated.h
> +++ b/include/uapi/linux/ethtool_netlink_generated.h
> @@ -322,6 +322,9 @@ enum {
>  	ETHTOOL_A_LINKSTATE_EXT_STATE,
>  	ETHTOOL_A_LINKSTATE_EXT_SUBSTATE,
>  	ETHTOOL_A_LINKSTATE_EXT_DOWN_CNT,
> +	ETHTOOL_A_LINKSTATE_MSE_VALUE,
> +	ETHTOOL_A_LINKSTATE_MSE_MAX,
> +	ETHTOOL_A_LINKSTATE_MSE_CHANNEL,
>  
>  	__ETHTOOL_A_LINKSTATE_CNT,
>  	ETHTOOL_A_LINKSTATE_MAX = (__ETHTOOL_A_LINKSTATE_CNT - 1)

This changes is not reflected in the YAML spec.
-- 
pw-bot: cr

