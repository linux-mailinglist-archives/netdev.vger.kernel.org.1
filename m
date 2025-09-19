Return-Path: <netdev+bounces-224929-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 374A5B8BA6A
	for <lists+netdev@lfdr.de>; Sat, 20 Sep 2025 01:57:53 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id E5FDCA80BD3
	for <lists+netdev@lfdr.de>; Fri, 19 Sep 2025 23:57:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 228DE2D24BA;
	Fri, 19 Sep 2025 23:57:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="hzqYTfKp"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EAA9517A2EA;
	Fri, 19 Sep 2025 23:57:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758326269; cv=none; b=eIpkxLIot9Gz5H0c4YYhe/wqADNCrBJWQT9PvS9Vv1cVDl3J9+gae1gEcgiwQgV9OBHfVAXu4JS9KcQZM2TtQ6tui7FESJPZb43a4nr/PkHDg2U6ogjrmBxC3Bc7YfB7Npwpf7p4HNNysWufT00k2ukc/bp3CQiLdh87+kbmBcc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758326269; c=relaxed/simple;
	bh=G/0NaZRHkE0QjTqR59c6aAdqxCqI7WLim83gK5JQ7uA=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=EmzVjVjcxy0oVS+mvb1/T5kludUpVlBs0/5yD9wyDsV3ivxIksi40NSwP+52kMy4qEwWNm9mOmVOEqgo0PgmVJPGiOZauDgUoPelGEFbcn3Q5sivGHROzOen13+hP+NIN5mpw/oFQxoE83lTHV4/bddpjqpiYvavmeNZByejAW4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=hzqYTfKp; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id EA8BAC4CEF0;
	Fri, 19 Sep 2025 23:57:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1758326267;
	bh=G/0NaZRHkE0QjTqR59c6aAdqxCqI7WLim83gK5JQ7uA=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=hzqYTfKpisba3UBm5gNBe42yqPhNNphsptxr8Hviej0yAhdr2cEkyhTQiwpysvhYN
	 awEj/B+QTYGcY24kWuzh+vxrplCC0AY06V8rlM5zxg+GUtzI/sDAlGtl6CvJgqKjNU
	 yJbQqsRC92HAfk0X4A6Xn0KM5c4PgC5K7hnehocqF/se86CC+BQ9nqttjZW6SDvhTo
	 gdygwPNWAv79l430xJejhGDzOIbJJMhI5Qiqj6/SauXxq4RNPHS0FAKI+X3TiQYNt8
	 TUFxlCVrr7IzrS6R2BSMR7hr7/5jJwd+Qx9j+ZKkX4BpUkRN8SwVDCFFwbAPkKYmVk
	 uKcpZhPNUkYsg==
Date: Fri, 19 Sep 2025 16:57:46 -0700
From: Jakub Kicinski <kuba@kernel.org>
To: Dragos Tatulea <dtatulea@nvidia.com>
Cc: Jesper Dangaard Brouer <hawk@kernel.org>, "David S. Miller"
 <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, Paolo Abeni
 <pabeni@redhat.com>, Simon Horman <horms@kernel.org>, Ilias Apalodimas
 <ilias.apalodimas@linaro.org>, "Sebastian Andrzej Siewior"
 <bigeasy@linutronix.de>, Clark Williams <clrkwllms@kernel.org>, Steven
 Rostedt <rostedt@goodmis.org>, <netdev@vger.kernel.org>, "Tariq Toukan"
 <tariqt@nvidia.com>, <linux-kernel@vger.kernel.org>,
 <linux-rt-devel@lists.linux.dev>
Subject: Re: [PATCH net-next] page_pool: add debug for release to cache from
 wrong CPU
Message-ID: <20250919165746.5004bb8c@kernel.org>
In-Reply-To: <20250918084823.372000-1-dtatulea@nvidia.com>
References: <20250918084823.372000-1-dtatulea@nvidia.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Thu, 18 Sep 2025 11:48:21 +0300 Dragos Tatulea wrote:
> Direct page releases to cache must be done on the same CPU as where NAPI
> is running.

You talk about NAPI..

>  /* Only allow direct recycling in special circumstances, into the
>   * alloc side cache.  E.g. during RX-NAPI processing for XDP_DROP use-case.
>   *
> @@ -768,6 +795,18 @@ static bool page_pool_recycle_in_cache(netmem_ref netmem,
>  		return false;
>  	}
>  
> +#ifdef CONFIG_DEBUG_PAGE_POOL_CACHE_RELEASE
> +	if (unlikely(!page_pool_napi_local(pool))) {
> +		u32 pp_cpuid = READ_ONCE(pool->cpuid);

but then you print pp->cpuid?

The patch seems half-baked. If the NAPI local recycling is incorrect
the pp will leak a reference and live forever. Which hopefully people
would notice. Are you adding this check just to double confirm that
any leaks you're chasing are in the driver, and not in the core?

