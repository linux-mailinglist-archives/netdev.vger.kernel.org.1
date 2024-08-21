Return-Path: <netdev+bounces-120395-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 5EF6A959218
	for <lists+netdev@lfdr.de>; Wed, 21 Aug 2024 03:18:03 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 122C6283CD3
	for <lists+netdev@lfdr.de>; Wed, 21 Aug 2024 01:18:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D41F34687;
	Wed, 21 Aug 2024 01:17:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="KE3mxqOp"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B05D181E
	for <netdev@vger.kernel.org>; Wed, 21 Aug 2024 01:17:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724203079; cv=none; b=IZW2E9lOnkGa1/X1DO9RuKzwoBx5W+aDWVDNnfFAo8n06xZ9682eMJwSY5OWyTK8ag/+UiKFO+h1Y4I03/OEXfxD2l3ObQ4zQo1DfuaNnyZwUDoJWfME+J4h2wPNkjY26USQy4ld59QtJIFYP9w5FqInrtzLxpm45+uN9XqPl9g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724203079; c=relaxed/simple;
	bh=pCmEd14y5e2wIsg6PoTlTbtRUwDdYTsuc/XbVubWU7M=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=TgWrGshqeHV5Y8fe2dZD9Cag3YYA8lzCNuYIkJe09WMkmd0vT/AOC7+wHVZcAyRsW032/6nvjR9OOcqNOWguRBLOBo5Xh6ndnPLT+Y/+bYcOv5c3RBRbHuf6LDJaJQ/pTwc7xa25Mp3fXxaAaeWlSIGKgqEnKLhhDXMnyFTG0bM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=KE3mxqOp; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B0D25C4AF1B;
	Wed, 21 Aug 2024 01:17:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1724203079;
	bh=pCmEd14y5e2wIsg6PoTlTbtRUwDdYTsuc/XbVubWU7M=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=KE3mxqOpxBG13oc0RF4BesSWbthcbdsV6ZrZTkp4TDkKrldWzCqd3d9S4NIXkATmR
	 L9Lz1hALBCl7tsCvlKeXaAhB0yHOEcDXrsrPstSHnaOEI9F38o5j1LZQGJSYrnfOaa
	 zsqKkg0shH8wTudGEYE5rZ0WqGxBzGS1eCm9R2zJnHJKTr+hkzLXkXBdkvmhcUbr0c
	 tnmMR3BRM2MYW9mAsvbVI01QUzP0AmikX4LnoaZoNaiB353eQSUXH47kBG/9wR0WN6
	 yGBK+P0VAm8ibPvz2JnPrKYTPxha9I3pukiKYPNyZoI6QF1caA65dz4nrw95sAwyhe
	 IBWVJYLhZwqvA==
Date: Tue, 20 Aug 2024 18:17:57 -0700
From: Jakub Kicinski <kuba@kernel.org>
To: Tony Nguyen <anthony.l.nguyen@intel.com>
Cc: davem@davemloft.net, pabeni@redhat.com, edumazet@google.com,
 netdev@vger.kernel.org, Alexander Lobakin <aleksander.lobakin@intel.com>,
 przemyslaw.kitszel@intel.com, joshua.a.hay@intel.com,
 michal.kubiak@intel.com, nex.sw.ncis.osdt.itp.upstreaming@intel.com
Subject: Re: [PATCH net-next v2 2/9] libeth: add common queue stats
Message-ID: <20240820181757.02d83f15@kernel.org>
In-Reply-To: <20240819223442.48013-3-anthony.l.nguyen@intel.com>
References: <20240819223442.48013-1-anthony.l.nguyen@intel.com>
	<20240819223442.48013-3-anthony.l.nguyen@intel.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Mon, 19 Aug 2024 15:34:34 -0700 Tony Nguyen wrote:
> + * Return: new &net_device on success, %NULL on error.
> + */
> +struct net_device *__libeth_netdev_alloc(u32 priv, u32 rqs, u32 sqs,
> +					 u32 xdpsqs)

The netdev alloc / free / set num queues can be a separate patch

> +MODULE_DESCRIPTION("Common Ethernet library");

BTW for Intel? Or you want this to be part of the core?
I thought Intel, but you should tell us if you have broader plans.

> +	const struct libeth_netdev_priv *priv = netdev_priv(dev);	      \
> +									      \
> +	memset(stats, 0, sizeof(*stats));				      \
> +	u64_stats_init(&stats->syncp);					      \
> +									      \
> +	mutex_init(&priv->base_##pfx##s[qid].lock);			      \

the mutex is only for writes or for reads of base too?
mutex is a bad idea for rtnl stats

> +/* Netlink stats. Exported fields have the same names as in the NL structs */
> +
> +struct libeth_stats_export {
> +	u16	li;
> +	u16	gi;
> +};
> +
> +#define LIBETH_STATS_EXPORT(lpfx, gpfx, field) {			      \
> +	.li = (offsetof(struct libeth_##lpfx##_stats, field) -		      \
> +	       offsetof(struct libeth_##lpfx##_stats, raw)) /		      \
> +	      sizeof_field(struct libeth_##lpfx##_stats, field),	      \
> +	.gi = offsetof(struct netdev_queue_stats_##gpfx, field) /	      \
> +	      sizeof_field(struct netdev_queue_stats_##gpfx, field)	      \
> +}

humpf

> +#define LIBETH_STATS_DEFINE_EXPORT(pfx, gpfx)				      \
> +static void								      \
> +libeth_get_queue_stats_##gpfx(struct net_device *dev, int idx,		      \
> +			      struct netdev_queue_stats_##gpfx *stats)	      \
> +{									      \
> +	const struct libeth_netdev_priv *priv = netdev_priv(dev);	      \
> +	const struct libeth_##pfx##_stats *qs;				      \
> +	u64 *raw = (u64 *)stats;					      \
> +	u32 start;							      \
> +									      \
> +	qs = READ_ONCE(priv->live_##pfx##s[idx]);			      \
> +	if (!qs)							      \
> +		return;							      \
> +									      \
> +	do {								      \
> +		start = u64_stats_fetch_begin(&qs->syncp);		      \
> +									      \
> +		libeth_stats_foreach_export(pfx, exp)			      \
> +			raw[exp->gi] = u64_stats_read(&qs->raw[exp->li]);     \
> +	} while (u64_stats_fetch_retry(&qs->syncp, start));		      \
> +}									      \

ugh. Please no

> +									      \
> +static void								      \
> +libeth_get_##pfx##_base_stats(const struct net_device *dev,		      \
> +			      struct netdev_queue_stats_##gpfx *stats)	      \
> +{									      \
> +	const struct libeth_netdev_priv *priv = netdev_priv(dev);	      \
> +	u64 *raw = (u64 *)stats;					      \
> +									      \
> +	memset(stats, 0, sizeof(*(stats)));				      \

Have you read the docs for any of the recent stats APIs?

Nack. Just implement the APIs in the driver, this does not seem like 
a sane starting point _at all_. You're going to waste more time coming
up with such abstraction than you'd save implementing it for 10 drivers.

