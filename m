Return-Path: <netdev+bounces-239368-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id 0805EC673BE
	for <lists+netdev@lfdr.de>; Tue, 18 Nov 2025 05:19:03 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by tor.lore.kernel.org (Postfix) with ESMTPS id 1A48129C3A
	for <lists+netdev@lfdr.de>; Tue, 18 Nov 2025 04:19:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1BA28270557;
	Tue, 18 Nov 2025 04:18:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="sqwiOmZl"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E7F60248F72
	for <netdev@vger.kernel.org>; Tue, 18 Nov 2025 04:18:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763439539; cv=none; b=VWGy0cDTtU3RYx48myDGV7NMY6dOIM8uNeSzzj49yrfKTEASiWWG2FHJBzXKOw3lPO71o+ApeHnwyWPgLbdDehwo/OGw75E1VJQ2sMSS4+4uFiNwL7p4n9IC0d9ggX05Y6QmZ4Rd1ylESAp/vPdXIdjV61kY2lxFrTvYfRYCtVo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763439539; c=relaxed/simple;
	bh=zrUtZV1s1EbHvUzFp/VFtHhwQ+AHHmQUDtW2MF6icH4=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=ueLrHztShFkIukyLZLg/enItMBDZR++VhILgu/At8Ybj0CZyiZz86xtveuP2kgXK7ilF+i+WYjXWpleo0r0+IUon8UYQSxyyNA8VlXdq3hpv2fNe+IYzP8qS2TQHKHOEk1rjdmb6TTvYcT9jCZB2ybLAxIJna5OcgxvU0LspJYk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=sqwiOmZl; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 815AAC19422;
	Tue, 18 Nov 2025 04:18:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1763439538;
	bh=zrUtZV1s1EbHvUzFp/VFtHhwQ+AHHmQUDtW2MF6icH4=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=sqwiOmZllnOq+JQthu+vKYebPRuP/t4JmHEjWjD+G6nts38+94fgLteC4dGEaL1vC
	 IRpxyyevfJAQRP49H2cM0GEwfEGRqQazU5jsyJeRVBbkVRcPIzlry17+TGwEC3LOWP
	 Rho4TsA/5MWHjSrxfzlabF6MA9jysX2HZl/rx8jrFejKw6OXW+UY7PaiLnc/6Yr5lA
	 cF4GJ7gGVfMLsguRd0p8fpFIaDN/936zfIwQPYaYM7XYZk7NU+7yfDPzfW62hzOHxq
	 e9uVxgdkdi5PM46V4Xb2DdAT8TN81FcaExmW/xgbqIqXpJmjWWxV1+Pv9sdFHNsaxf
	 ieK7obP6TeZyg==
Date: Mon, 17 Nov 2025 20:18:54 -0800
From: Jakub Kicinski <kuba@kernel.org>
To: Xuan Zhuo <xuanzhuo@linux.alibaba.com>
Cc: netdev@vger.kernel.org, Andrew Lunn <andrew+netdev@lunn.ch>, "David S.
 Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, Paolo
 Abeni <pabeni@redhat.com>, Wen Gu <guwen@linux.alibaba.com>, Philo Lu
 <lulie@linux.alibaba.com>, Lorenzo Bianconi <lorenzo@kernel.org>, Vadim
 Fedorenko <vadim.fedorenko@linux.dev>, Dong Yibo <dong100@mucse.com>, Lukas
 Bulwahn <lukas.bulwahn@redhat.com>, Geert Uytterhoeven
 <geert+renesas@glider.be>, Vivian Wang <wangruikang@iscas.ac.cn>, MD Danish
 Anwar <danishanwar@ti.com>, Dust Li <dust.li@linux.alibaba.com>
Subject: Re: [PATCH net-next v14 1/5] eea: introduce PCI framework
Message-ID: <20251117201854.1d32753e@kernel.org>
In-Reply-To: <20251114061506.45978-2-xuanzhuo@linux.alibaba.com>
References: <20251114061506.45978-1-xuanzhuo@linux.alibaba.com>
	<20251114061506.45978-2-xuanzhuo@linux.alibaba.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Fri, 14 Nov 2025 14:15:02 +0800 Xuan Zhuo wrote:
> +config EEA
> +	tristate "Alibaba Elastic Ethernet Adapter support"
> +	depends on PCI_MSI
> +	depends on 64BIT
> +	select PAGE_POOL
> +	default m

drivers should default to n, which is the default default, so please
remove this line

> +	help
> +	  This driver supports Alibaba Elastic Ethernet Adapter"
> +
> +	  To compile this driver as a module, choose M here.

