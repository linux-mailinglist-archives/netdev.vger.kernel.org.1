Return-Path: <netdev+bounces-117807-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 5D66494F63D
	for <lists+netdev@lfdr.de>; Mon, 12 Aug 2024 20:04:20 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 8E5AD1C21192
	for <lists+netdev@lfdr.de>; Mon, 12 Aug 2024 18:04:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2188B188CB0;
	Mon, 12 Aug 2024 18:04:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="tr8YL8JN"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E9195C156;
	Mon, 12 Aug 2024 18:04:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723485855; cv=none; b=BHG8spZAbJ6TGvQ0QyUVAV1u3zR/WWUChc++7kwrRrBGeE6CJCs5Mt+2Ll8UArK6PnI3+rRUENOplzH5rpHNmujt+QkM88uZ8w5rsA9fuNCoQ50yWQh87Av/PokHnaPzCBlwTIMsBPv02SYWjrlfoGvZ4M2GhWqzEooGcfXUuN0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723485855; c=relaxed/simple;
	bh=IgjD1il0r346H/M/eR16rm7XkHoemxT/cs6DzOrS+5M=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=id7zCXySo561+BFxbhqKG5WY6zy+EdNW+pzyTQtcrWrLsTtcGJnECecTaedjP6/Uw/F/Hsx86gXSdrgtpagJjUqdF5Etq/I3lpb9cF9Q668d26rooSUJ/7r5ur/+iHZ8PjBKOPZ2Qt1NpHJjFPvD/n/r6wNo5AEzNkVI6nk4xNw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=tr8YL8JN; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id F3299C32782;
	Mon, 12 Aug 2024 18:04:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1723485854;
	bh=IgjD1il0r346H/M/eR16rm7XkHoemxT/cs6DzOrS+5M=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=tr8YL8JN+RqdjAZCNZy211uw7rHsCh6d1pfoQtLU/5LK75LUREeyWGglXey68pnAY
	 rT6VC0+QZcDMl/4d4aqxhwGD00SrqgnFZqD82QjtJCB+TjFXK4AqZA29izf6q5qzXv
	 3dbH4AQZrA1A/6K2AlkQwCqP5Wk1smNo0zcRPERcxL650vFiuafIqxc5Ew2aBSONNn
	 yrPKPJfkt3Woa4W5eyWZPPSfnJZ88NY+bUjTBQDzwJxpOHFteaYg4Fi8o+KONCR0MY
	 v5xt2ztz4BYjsTpn4D+HiktF0LAOfDahi4ec2HPOfiXvNxnWlRR/ZR4tuLKyULTWCt
	 JnULt4ZFRK4YA==
Date: Mon, 12 Aug 2024 11:04:13 -0700
From: Jakub Kicinski <kuba@kernel.org>
To: Alexander Lobakin <aleksander.lobakin@intel.com>
Cc: Kees Cook <kees@kernel.org>, "David S. Miller" <davem@davemloft.net>,
 Eric Dumazet <edumazet@google.com>, Paolo Abeni <pabeni@redhat.com>, David
 Ahern <dsahern@kernel.org>, Xuan Zhuo <xuanzhuo@linux.alibaba.com>, Andrew
 Lunn <andrew@lunn.ch>, Willem de Bruijn <willemdebruijn.kernel@gmail.com>,
 <nex.sw.ncis.osdt.itp.upstreaming@intel.com>, <netdev@vger.kernel.org>,
 <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH net-next v3 1/6] netdevice: convert private flags >
 BIT(31) to bitfields
Message-ID: <20240812110413.2ed0d275@kernel.org>
In-Reply-To: <26db3c81-5da6-483a-b9d0-6c9fcda5c5c0@intel.com>
References: <20240808152757.2016725-1-aleksander.lobakin@intel.com>
	<20240808152757.2016725-2-aleksander.lobakin@intel.com>
	<20240809222755.28acd840@kernel.org>
	<26db3c81-5da6-483a-b9d0-6c9fcda5c5c0@intel.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Mon, 12 Aug 2024 14:09:31 +0200 Alexander Lobakin wrote:
> > The kdoc scripts says:
> > 
> > include/linux/netdevice.h:2392: warning: Excess struct member 'priv_flags_fast' description in 'net_device'
> > 
> > I thought you sent a kernel-doc patch during previous cycle to fix this,
> > or was that for something else?  
> 
> Oh crap.
> The patch I sent expands struct_group_tagged() only.
> If I do the same for the regular struct_group(), there'll clearly be a
> ton of new warnings.
> I think I'll just submit v4 with removing this line from the kdoc?

No preference on direction, but not avoiding the warning would be great.

I reckon whether kdoc is useful for the group will depend case by case.
Best would be if we made the kdoc optional in this particular case.
But dunno if you have cycles so you can just delete.

