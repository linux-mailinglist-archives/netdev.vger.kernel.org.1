Return-Path: <netdev+bounces-38132-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 45E407B9879
	for <lists+netdev@lfdr.de>; Thu,  5 Oct 2023 01:00:15 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by ny.mirrors.kernel.org (Postfix) with ESMTP id 7494D1C208CB
	for <lists+netdev@lfdr.de>; Wed,  4 Oct 2023 23:00:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BA985262BA;
	Wed,  4 Oct 2023 23:00:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="CzeoVMFO"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 999EB219F6
	for <netdev@vger.kernel.org>; Wed,  4 Oct 2023 23:00:10 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 12414C433C8;
	Wed,  4 Oct 2023 23:00:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1696460410;
	bh=+Juc3gxhxIDmmvNuiHtVzjfy/yxZLQSF6j30i7q/Akc=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=CzeoVMFO/ZaJ6nI7zGm7BjjahqDVRw5avIv+0QWlUmrL0V1610tkRCzAIyWWQMsSM
	 xb5/L7HEIYBrawbVZMxB3okyobZ4ci5LP7hiBOFX3RGiJhkfU6O+I1F+ItqrqUbarp
	 JmM2I7sCt7GV4GfrxT53mpu8+jAfNxpjDThbIZHfPcHcorlGUh4ei4Ts+kNR4QlJLG
	 K68UGyPIh2/0hE8ELgCXOLUQycdR1Dogou2DKEtWUJhDdclZtxDwPnYOXKg7b6TI7H
	 7X5n0hAC7CSVWfIYvAkGZkArA27Naa9XdmMj74O86OmGnnL6xriz4vNlEEU+MWkXX8
	 o/aMBnMwe3gww==
Date: Wed, 4 Oct 2023 16:00:07 -0700
From: Jakub Kicinski <kuba@kernel.org>
To: <edward.cree@amd.com>
Cc: <linux-net-drivers@amd.com>, <davem@davemloft.net>,
 <edumazet@google.com>, <pabeni@redhat.com>, Edward Cree
 <ecree.xilinx@gmail.com>, <netdev@vger.kernel.org>,
 <habetsm.xilinx@gmail.com>, <sudheer.mogilappagari@intel.com>,
 <jdamato@fastly.com>, <andrew@lunn.ch>, <mw@semihalf.com>,
 <linux@armlinux.org.uk>, <sgoutham@marvell.com>, <gakula@marvell.com>,
 <sbhatta@marvell.com>, <hkelam@marvell.com>, <saeedm@nvidia.com>,
 <leon@kernel.org>
Subject: Re: [PATCH v4 net-next 2/7] net: ethtool: attach an XArray of
 custom RSS contexts to a netdevice
Message-ID: <20231004160007.095b55fc@kernel.org>
In-Reply-To: <4a41069859105d8c669fe26171248aad7f88d1e9.1695838185.git.ecree.xilinx@gmail.com>
References: <cover.1695838185.git.ecree.xilinx@gmail.com>
	<4a41069859105d8c669fe26171248aad7f88d1e9.1695838185.git.ecree.xilinx@gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Wed, 27 Sep 2023 19:13:33 +0100 edward.cree@amd.com wrote:
> +	struct ethtool_rxfh_context *ctx;
> +	unsigned long context;
> +
> +	if (dev->ethtool_ops->set_rxfh_context)

Can there be contexts if there's no callback to create them?
Perhaps you need this for later patches but would be good to
mention "why" in the commit message.

> +		xa_for_each(&dev->ethtool->rss_ctx, context, ctx) {
> +			u32 *indir = ethtool_rxfh_context_indir(ctx);
> +			u8 *key = ethtool_rxfh_context_key(ctx);
> +			u32 concast = context;
> +
> +			xa_erase(&dev->ethtool->rss_ctx, context);
> +			dev->ethtool_ops->set_rxfh_context(dev, indir, key,
> +							   ctx->hfunc, &concast,
> +							   true);
> +			kfree(ctx);
> +		}

