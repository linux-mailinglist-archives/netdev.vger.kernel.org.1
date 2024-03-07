Return-Path: <netdev+bounces-78481-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id CE638875483
	for <lists+netdev@lfdr.de>; Thu,  7 Mar 2024 17:50:25 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 4A22E1F2331A
	for <lists+netdev@lfdr.de>; Thu,  7 Mar 2024 16:50:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 39FBE12F5AD;
	Thu,  7 Mar 2024 16:50:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="V1osucTv"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0F1CD1DA37;
	Thu,  7 Mar 2024 16:50:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709830223; cv=none; b=dHyqSierylRWk5Y7/Li1MujvYJZ6Fhtg22QpqLOSIMiKTI+6a246Mt4OcCRj+zN2SXA+eoM9lvMU1bbj+YaKz5TlGydRlf82jeGhcKfBykp3wBhDyUOpeaoaK1ONl5RV9FJo3RAG6nIFtDTf5nviIFQtvZbX8vcBHQEuxXJePDo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709830223; c=relaxed/simple;
	bh=lHR56V/CodyEaIm3onpnKKQD1mT9eLVoJRYt25cfX0c=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=SJCjGoDssDE1+DGneOUPtadTr5uHss+W7ZVfkl7d/rBKYCoL0YlPlVA+5x1miFcjkaQmRkdjVFQhh0qfIyDQnq7ANFPdixf4FQpHbDquOtVjv7MM8mFUogefHvR8bYa6wdhsMTNvvU3sqd+CTuKintY9Pa9KeTFVvQKwIczVbqA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=V1osucTv; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 13502C43394;
	Thu,  7 Mar 2024 16:50:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1709830222;
	bh=lHR56V/CodyEaIm3onpnKKQD1mT9eLVoJRYt25cfX0c=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=V1osucTvjHURTZv3n8pEZmmxRSeo0uSxeoLhilH3IQFKra8aTlTsuH4yc5w1jhEsE
	 4Fx0FbXpwnh4fsj44LzocdqbU65ryv+cDwg+KwpvYFaQxzJ2KfUXfxgjyaX2QAvXnm
	 MW5aW3l0xHbVvZHnm/MvhRhN3oeLQJtxhr+AXwFbizyimKLX//7zQympipZIUFRQ+t
	 hLt4Fn7m1w2HX1kMyOhL+Bkk35WqsHN/u2gfoF+YlcsNwkAVjHF1+pU1l0Gyagv23M
	 /B9CykPDnYhlzsPt5bzZNsKu1qlb4YHYFUlmEdV5rYY7uTvliMZxsHWmlOxBK5qe5L
	 SdICx32Zr8NOA==
Date: Thu, 7 Mar 2024 08:50:21 -0800
From: Jakub Kicinski <kuba@kernel.org>
To: Xuan Zhuo <xuanzhuo@linux.alibaba.com>
Cc: netdev@vger.kernel.org, "Michael S. Tsirkin" <mst@redhat.com>, Jason
 Wang <jasowang@redhat.com>, "David S. Miller" <davem@davemloft.net>, Eric
 Dumazet <edumazet@google.com>, Paolo Abeni <pabeni@redhat.com>,
 virtualization@lists.linux.dev, Willem de Bruijn
 <willemdebruijn.kernel@gmail.com>, Tariq Toukan <tariqt@nvidia.com>,
 Michael Chan <michael.chan@broadcom.com>, Jesse Brandeburg
 <jesse.brandeburg@intel.com>, Alexander Lobakin
 <aleksander.lobakin@intel.com>, Shannon Nelson <shannon.nelson@amd.com>
Subject: Re: [PATCH net-next v3 3/6] virtio_net: support device stats
Message-ID: <20240307085021.1081777d@kernel.org>
In-Reply-To: <20240227080303.63894-4-xuanzhuo@linux.alibaba.com>
References: <20240227080303.63894-1-xuanzhuo@linux.alibaba.com>
	<20240227080303.63894-4-xuanzhuo@linux.alibaba.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

CC: Willem and some driver folks for more input, context: extending
https://lore.kernel.org/all/20240306195509.1502746-1-kuba@kernel.org/
to cover virtio stats.

On Tue, 27 Feb 2024 16:03:00 +0800 Xuan Zhuo wrote:
> +static const struct virtnet_stat_desc virtnet_stats_rx_basic_desc[] = {
> +	VIRTNET_STATS_DESC(rx, basic, packets),
> +	VIRTNET_STATS_DESC(rx, basic, bytes),

Covered.

> +	VIRTNET_STATS_DESC(rx, basic, notifications),
> +	VIRTNET_STATS_DESC(rx, basic, interrupts),

I haven't seen HW devices count interrupts coming from a specific
queue (there's usually a lot more queues than IRQs these days),
let's keep these in ethtool -S for now, unless someone has a HW use
case.

> +	VIRTNET_STATS_DESC(rx, basic, drops),
> +	VIRTNET_STATS_DESC(rx, basic, drop_overruns),

These are important, but we need to make sure we have a good definition
for vendors to follow...

drops I'd define as "sum of all packets which came into the device, but
never left it, including but not limited to: packets dropped due to
lack of buffer space, processing errors, explicitly set policies and
packet filters." 
Call it hw-rx-drops ?

overruns is a bit harder to precisely define. I was thinking of
something more broad, like: "packets dropped due to transient lack of
resources, such as buffer space, host descriptors etc."

For context why not just go with virtio spec definition of "no
descriptors" - for HW devices, what exact point in the pipeline drops
depends on how back pressure is configured/implemented, and fetching
descriptors is high latency, so differentiating between "PCIe is slow"
and "host didn't post descriptors" is hard in practice.
Call it hw-rx-drop-overruns ?

> +static const struct virtnet_stat_desc virtnet_stats_tx_basic_desc[] = {
> +	VIRTNET_STATS_DESC(tx, basic, packets),
> +	VIRTNET_STATS_DESC(tx, basic, bytes),
> +
> +	VIRTNET_STATS_DESC(tx, basic, notifications),
> +	VIRTNET_STATS_DESC(tx, basic, interrupts),
> +
> +	VIRTNET_STATS_DESC(tx, basic, drops),

These 5 same as rx.

> +	VIRTNET_STATS_DESC(tx, basic, drop_malformed),

These I'd call hw-tx-drop-errors, "packets dropped because they were
invalid or malformed"?

> +static const struct virtnet_stat_desc virtnet_stats_rx_csum_desc[] = {
> +	VIRTNET_STATS_DESC(rx, csum, csum_valid),

I think in kernel parlance that would translate to CHECKSUM_UNNECESSARY?
So let's call it rx-csum-unnecessary ?
I'd skip the hw- prefix for this one, it doesn't matter to the user if
the HW or SW counted it.

> +	VIRTNET_STATS_DESC(rx, csum, needs_csum),

Hm, I think this is a bit software/virt device specific, presumably
rx-csum-partial for the kernel, up to you whether to make it ethtool -S
or netlink.

> +	VIRTNET_STATS_DESC(rx, csum, csum_none),
> +	VIRTNET_STATS_DESC(rx, csum, csum_bad),

These two make sense as is in netlink, should be fairly commonly
reported by devices. Maybe add a note in "bad" that packets with
bad csum are not discarded, but still delivered to the stack.

> +static const struct virtnet_stat_desc virtnet_stats_tx_csum_desc[] = {
> +	VIRTNET_STATS_DESC(tx, csum, needs_csum),
> +	VIRTNET_STATS_DESC(tx, csum, csum_none),

tx- version of what names we pick for rx-, netlink seems appropriate.

> +static const struct virtnet_stat_desc virtnet_stats_rx_gso_desc[] = {
> +	VIRTNET_STATS_DESC(rx, gso, gso_packets),
> +	VIRTNET_STATS_DESC(rx, gso, gso_bytes),

I used the term "GSO" in conversations about Rx and it often confuses
people. Let's use "GRO", so hw-gro-packets, and hw-gro-bytes ?
Or maybe coalesce? "hw-rx-coalesce" ? That's quite a bit longer..

Ah, and please mention in the doc that these counters "do not cover LRO
i.e. any coalescing implementation which doesn't follow GRO rules".

> +	VIRTNET_STATS_DESC(rx, gso, gso_packets_coalesced),

hw-gro-wire-packets ?
No strong preference on the naming, but I find that saying -wire
makes it 100% clear to everyone what the meaning is.

> +	VIRTNET_STATS_DESC(rx, gso, gso_bytes_coalesced),

The documentation in the virtio spec seems to be identical 
to the one for gso_packets, which gotta be unintentional?
I'm guessing this is hw-gro-wire-bytes? I.e. headers counted
multiple times?

> +static const struct virtnet_stat_desc virtnet_stats_tx_gso_desc[] = {
> +	VIRTNET_STATS_DESC(tx, gso, gso_packets),
> +	VIRTNET_STATS_DESC(tx, gso, gso_bytes),
> +	VIRTNET_STATS_DESC(tx, gso, gso_segments),
> +	VIRTNET_STATS_DESC(tx, gso, gso_segments_bytes),

these 4 make sense as mirror of the Rx

> +	VIRTNET_STATS_DESC(tx, gso, gso_packets_noseg),
> +	VIRTNET_STATS_DESC(tx, gso, gso_bytes_noseg),

Not sure what these are :) unless someone knows what it is and that
HW devices report it, let's keep them in ethtool -S ?

> +static const struct virtnet_stat_desc virtnet_stats_rx_speed_desc[] = {
> +	VIRTNET_STATS_DESC(rx, speed, packets_allowance_exceeded),

hw-rx-drop-ratelimits ?
"Allowance exceeded" is a bit of a mouthful to me, perhaps others
disagree. The description from the virtio spec is quite good.

> +	VIRTNET_STATS_DESC(rx, speed, bytes_allowance_exceeded),

No strong preference whether to expose this as a standard stat or
ethtool -S, we don't generally keep byte counters for drops, so
this would be special.

> +static const struct virtnet_stat_desc virtnet_stats_tx_speed_desc[] = {
> +	VIRTNET_STATS_DESC(tx, speed, packets_allowance_exceeded),
> +	VIRTNET_STATS_DESC(tx, speed, packets_allowance_exceeded),

same as rx

