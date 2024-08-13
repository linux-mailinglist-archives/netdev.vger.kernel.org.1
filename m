Return-Path: <netdev+bounces-117885-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 92B3494FAD6
	for <lists+netdev@lfdr.de>; Tue, 13 Aug 2024 02:48:40 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 6F1161C20E60
	for <lists+netdev@lfdr.de>; Tue, 13 Aug 2024 00:48:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8A3B87F8;
	Tue, 13 Aug 2024 00:48:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="cVA4Ov3W"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6534CEDB
	for <netdev@vger.kernel.org>; Tue, 13 Aug 2024 00:48:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723510116; cv=none; b=eY1RgRwK1DPuba9pxhigGq0LzFK+xdFhBibGHASPZzfnwI/j6wt5LeJjN6zR8ZIas32PfcbflH4RvmCqwad5DPJiJj+iRHgSiF3NEMcgFHuN45oeDic8ZyO6TfvuqhI5Hdez+EhoyVMYiJHNy4E98tq9Obz2Xf46RH+cGiO5AmU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723510116; c=relaxed/simple;
	bh=aTNNr5ibBLTY0+6IsVLPxtd5h+0E1OwQtcBOxgUqDjk=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=geUSU5MPpmmov1sPpQPNMxGRRCS8wXtXLbKcSL4GMIH0kzLCw2veqH10AVCtTizD4j6RAP4JNrHavmoPO/qbcBZ8nkhaFP01u4EgM41/CIP37i6quac+lfRNKoLlYflL/oR6plqQsjC6F6WrswmW8pMCeQuhQImsD46thuZsbM0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=cVA4Ov3W; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 70585C4AF0E;
	Tue, 13 Aug 2024 00:48:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1723510115;
	bh=aTNNr5ibBLTY0+6IsVLPxtd5h+0E1OwQtcBOxgUqDjk=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=cVA4Ov3WeRuz0lSLfOGJ/gcUE39He13vNQfkgwU7yaV12RHpZQxG1uV1Em78APrkf
	 NWct92I6sbricuoIxGFWjxYlM7eZzW0MlXlpsO+IjtYXGIXzL4wUWWxxMvXr0LueIy
	 6j7wTLdp+VK6LpIcZkI8UTbES446r2QRAQAk+gTx/xe3dbbHScxps6nYsAR5tiwYVD
	 UH+tCL7EzczNHzj8pM+nfMBNQLsCw8PByTuqhFcLO/LRhWoEaMYsRFC9c4LnMiECEG
	 sSRNX1jxTEWpUaYUfOsZ/2LmEs7eBmME6fUeEMH/TQZcTad5DkR11YORe/noi7Z4de
	 g1bas2carROSw==
Date: Mon, 12 Aug 2024 17:48:34 -0700
From: Jakub Kicinski <kuba@kernel.org>
To: Tariq Toukan <tariqt@nvidia.com>
Cc: "David S. Miller" <davem@davemloft.net>, Paolo Abeni
 <pabeni@redhat.com>, Eric Dumazet <edumazet@google.com>, "Jay Vosburgh"
 <jv@jvosburgh.net>, Andy Gospodarek <andy@greyhouse.net>,
 <netdev@vger.kernel.org>, Saeed Mahameed <saeedm@nvidia.com>, Gal Pressman
 <gal@nvidia.com>, Leon Romanovsky <leonro@nvidia.com>, Hangbin Liu
 <liuhangbin@gmail.com>, Jianbo Liu <jianbol@nvidia.com>
Subject: Re: [PATCH net V3 1/3] bonding: implement xdo_dev_state_free and
 call it after deletion
Message-ID: <20240812174834.4bcba98d@kernel.org>
In-Reply-To: <20240805050357.2004888-2-tariqt@nvidia.com>
References: <20240805050357.2004888-1-tariqt@nvidia.com>
	<20240805050357.2004888-2-tariqt@nvidia.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Mon, 5 Aug 2024 08:03:55 +0300 Tariq Toukan wrote:
> +static void bond_ipsec_free_sa(struct xfrm_state *xs)
> +{
> +	struct net_device *bond_dev = xs->xso.dev;
> +	struct net_device *real_dev;
> +	struct bonding *bond;
> +	struct slave *slave;
> +
> +	if (!bond_dev)
> +		return;

can xs->xso.dev be NULL during the dev_free_state callback?

> +	rcu_read_lock();
> +	bond = netdev_priv(bond_dev);
> +	slave = rcu_dereference(bond->curr_active_slave);
> +	real_dev = slave ? slave->dev : NULL;
> +	rcu_read_unlock();

What's holding onto real_dev once you drop the rcu lock here?

