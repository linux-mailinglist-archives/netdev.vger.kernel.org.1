Return-Path: <netdev+bounces-102987-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 9370C905DD1
	for <lists+netdev@lfdr.de>; Wed, 12 Jun 2024 23:40:28 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 4A30A1F22966
	for <lists+netdev@lfdr.de>; Wed, 12 Jun 2024 21:40:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A31F685956;
	Wed, 12 Jun 2024 21:40:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="bXke5Ux+"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7DC38537FF
	for <netdev@vger.kernel.org>; Wed, 12 Jun 2024 21:40:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718228424; cv=none; b=flz0k0UlIlxWH/l+RKzrMEeBHCqxLWoEeenqE159bUq/PRKG4y1QwumujlYgHm9Cpaxoa6LYQQkcvZ0Gd410oC/CbZ527aRGxyY+195gw6i/rk3ytQIAbrXE0qvUAf6rZIQWWbJIwCYG7n3XZoq+f2Rf2f1/+kxPqVfSNAbdWb4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718228424; c=relaxed/simple;
	bh=yUaAV5Fl/gIYOovs56RPcBazsdM2NhoyY0GzS2kdvnQ=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=MARJTD6G1A/K7uALSqGVz0tX22JedJ0IS7EvVorrtmjfVM7RMjk7zm1oHlAjhzfwJIgg/gYNK90xmyU+z1HQQb7vABoLSrERdQIUq7rhImBBuvfOYwHqKdX5cMpWx1JFVzkMFORE4/gTMwkFkdaZ0mEkewO9TqabMx7E2weMWlo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=bXke5Ux+; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E98F4C116B1;
	Wed, 12 Jun 2024 21:40:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1718228424;
	bh=yUaAV5Fl/gIYOovs56RPcBazsdM2NhoyY0GzS2kdvnQ=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=bXke5Ux+/I3chsd4wQ9BBuyUw38smV0GzbzY3DNb9oeKhs98OUAZRFNgybLqKHerU
	 5R0fe4Lm3eh5LlSeDVLY975E9tOxW8jXODHN5sx1XRWPG1qnReIMwIexEQl6V6+eUw
	 YaELICDqTpvL0zaIj6u7AJwPQ9GelLS7hR5WTrkc/TiFNAmdAVxOZlEVO1xqjtJXMm
	 fzc0uliWujI/H1IGLSQVBTx/dBKni79RT+LmZ41sownfTuRPiyAzK70IIDxfA3rx47
	 7wQpWCLiPbO0GXXs/6pXfW00/fJBPAjPVNj17rVvzr70pJtklegSyUHRga70mRst3u
	 amadXxkG87Oqg==
Date: Wed, 12 Jun 2024 14:40:23 -0700
From: Jakub Kicinski <kuba@kernel.org>
To: Jason Xing <kerneljasonxing@gmail.com>
Cc: edumazet@google.com, pabeni@redhat.com, davem@davemloft.net,
 dsahern@kernel.org, mst@redhat.com, jasowang@redhat.com,
 xuanzhuo@linux.alibaba.com, eperezma@redhat.com, leitao@debian.org,
 netdev@vger.kernel.org, Jason Xing <kernelxing@tencent.com>
Subject: Re: [PATCH net-next v2] net: dqs: introduce IFF_NO_BQL private flag
 for non-BQL drivers
Message-ID: <20240612144023.15f8032b@kernel.org>
In-Reply-To: <20240611033203.54845-1-kerneljasonxing@gmail.com>
References: <20240611033203.54845-1-kerneljasonxing@gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Tue, 11 Jun 2024 11:32:03 +0800 Jason Xing wrote:
> +++ b/include/linux/netdevice.h
> @@ -1649,6 +1649,9 @@ struct net_device_ops {
>   * @IFF_SEE_ALL_HWTSTAMP_REQUESTS: device wants to see calls to
>   *	ndo_hwtstamp_set() for all timestamp requests regardless of source,
>   *	even if those aren't HWTSTAMP_SOURCE_NETDEV.
> + * @IFF_NO_BQL: driver doesn't use BQL for flow control for now. It's used
> + *	to check if we should create byte_queue_limits directory in dqs
> + *	(see netdev_uses_bql())

Sorry for nit but since it's netdevice.h.. can we rephrase the comment
a bit? How about just:

+ * @IFF_NO_BQL: driver doesn't support BQL, don't create "byte_queue_limits"
+ *	directories in sysfs.

