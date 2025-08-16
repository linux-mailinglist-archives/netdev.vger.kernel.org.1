Return-Path: <netdev+bounces-214240-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A6EBCB2899A
	for <lists+netdev@lfdr.de>; Sat, 16 Aug 2025 03:29:58 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id C1126606FC8
	for <lists+netdev@lfdr.de>; Sat, 16 Aug 2025 01:29:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 05171145B3E;
	Sat, 16 Aug 2025 01:29:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="JB4ABSy6"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C4B11136988;
	Sat, 16 Aug 2025 01:29:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755307771; cv=none; b=K5qPHa/YG0/cyM714zaKlxYPBTJgTPernH2PGCXka2LsuizHJyUxoThD0OUDtPEnRYLzeYBZx/S7tbInc5kTX+n/BHoNFZZGXnqnkUt3+WpyTonqkN1eKCAauIKTjfZ05Ya+HpCsTQTq0FwEoJKmkOMdVwnAfjuJOLxxH8NDkVI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755307771; c=relaxed/simple;
	bh=DDOaVcjvN+Gdp6VEXtKQ3oqSO2YyXy4+KuhN05/0C/o=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=I0BLMCoKUep6DsMD17vro1e593PTx4p1FBujAtJjAq6SdBrRCnh2j3mo8mGQsRbdTMt3BL4HXHPJPbD/gUCBFOEG6bPC3iY/kcWLfOxsHX/XJhArElb2vEnYvBc9NjT21s9blKZ8YZNByjR3uh05+O1MuyGZIP5sNb1mKl2caWY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=JB4ABSy6; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id AA582C4CEF4;
	Sat, 16 Aug 2025 01:29:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1755307771;
	bh=DDOaVcjvN+Gdp6VEXtKQ3oqSO2YyXy4+KuhN05/0C/o=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=JB4ABSy62DS6ltXeHJdz3vKd7MkTxYq7DBvqNQnUQH7rWclUeZPUo3N2Mw4kfsVQ4
	 9hpPhf5poMiiyABewuY965yhMOLFf81FGFtyr2C+MUN5jpsOK/cikSam3/qjh22KMe
	 oKIeXTvzK0cIbK6FIZdUAINMSDXD7JDV77XYuy5S+auVihFqABEqfpFT+hOVObVY4y
	 2RkYWy9YnE2f0zu+U7bnH/93kRicuVtbO6Z8IbaGDIFGlNplDj7zmzRLjx4/+ghL+7
	 1SprBtEO+jrSYabo6qrpTb2OSstSXjeqmx3aVpWbkGnzywtQncaeAFh153JPABfMfb
	 828YJ8+KqjKtA==
Date: Fri, 15 Aug 2025 18:29:30 -0700
From: Jakub Kicinski <kuba@kernel.org>
To: Lukasz Majewski <lukasz.majewski@mailbox.org>
Cc: Andrew Lunn <andrew+netdev@lunn.ch>, davem@davemloft.net, Eric Dumazet
 <edumazet@google.com>, Paolo Abeni <pabeni@redhat.com>, Rob Herring
 <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley
 <conor+dt@kernel.org>, Shawn Guo <shawnguo@kernel.org>, Sascha Hauer
 <s.hauer@pengutronix.de>, Pengutronix Kernel Team <kernel@pengutronix.de>,
 Fabio Estevam <festevam@gmail.com>, Richard Cochran
 <richardcochran@gmail.com>, netdev@vger.kernel.org,
 devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
 imx@lists.linux.dev, linux-arm-kernel@lists.infradead.org, Stefan Wahren
 <wahrenst@gmx.net>, Simon Horman <horms@kernel.org>, Andrew Lunn
 <andrew@lunn.ch>
Subject: Re: [net-next v18 2/7] net: mtip: The L2 switch driver for imx287
Message-ID: <20250815182930.196973bb@kernel.org>
In-Reply-To: <20250813070755.1523898-3-lukasz.majewski@mailbox.org>
References: <20250813070755.1523898-1-lukasz.majewski@mailbox.org>
	<20250813070755.1523898-3-lukasz.majewski@mailbox.org>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Wed, 13 Aug 2025 09:07:50 +0200 Lukasz Majewski wrote:
> +	pkts = mtip_switch_rx(napi->dev, budget, &port);
> +	if (pkts == -ENOMEM) {
> +		napi_complete(napi);
> +		return 0;

And what happens next? looks like you're not unmasking the interrupt in
this case so we'll never get an IRQ until timeout kicks in?

> +	}
> +
> +	if ((port == 1 || port == 2) && fep->ndev[port - 1])
> +		mtip_switch_tx(fep->ndev[port - 1]);
> +	else
> +		mtip_switch_tx(napi->dev);
> +
> +	if (pkts < budget) {
> +		napi_complete_done(napi, pkts);

Please take napi_complete_done()'s return value into account

> +		/* Set default interrupt mask for L2 switch */
> +		writel(MCF_ESW_IMR_RXF | MCF_ESW_IMR_TXF,
> +		       fep->hwp + ESW_IMR);
> +	}

