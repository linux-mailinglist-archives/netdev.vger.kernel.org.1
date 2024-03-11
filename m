Return-Path: <netdev+bounces-79142-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id C6F5F877F9F
	for <lists+netdev@lfdr.de>; Mon, 11 Mar 2024 13:09:30 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id E5E6C1C2169E
	for <lists+netdev@lfdr.de>; Mon, 11 Mar 2024 12:09:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6E79E3BBF0;
	Mon, 11 Mar 2024 12:09:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b="yhqkeBvF"
X-Original-To: netdev@vger.kernel.org
Received: from out30-98.freemail.mail.aliyun.com (out30-98.freemail.mail.aliyun.com [115.124.30.98])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 56F91383AA
	for <netdev@vger.kernel.org>; Mon, 11 Mar 2024 12:09:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=115.124.30.98
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710158966; cv=none; b=BZAVu2qq4cVYuntRYreZi/cjaGAaFYFpswMixkd+0zuI0i7+vXV9qFRspU3WoGDiZK2aq4ya6AzxMZwghi8Fl5u3sIFnfIUUI9iMHANzQ9Z29gaLdJ7YjspY7Qo7hQGRIMGpFudA3T8r0fJl3lp9y/VSewv65TZWS+2W14DF/rs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710158966; c=relaxed/simple;
	bh=nqy34pYg198XpJLO9ypWndCUgumbnx5qxRl29Tbf1iw=;
	h=Message-ID:Subject:Date:From:To:Cc:References:In-Reply-To; b=NeSbbxc8DTX09A3JxxoeQt5T7BMIh6tX5epKIPfN4883vS6Iad40qqPAO70RGn85NYcv0qT7s2PHvr7UFVKVY+5C0COLqc36V+SDRBG8f/kaNqs5VSa1Qij3iSjMkjfWwQ5KIr5/NDb9FjSWDf+GzvWhd4z+4AFt4CUVMSCNCMM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com; spf=pass smtp.mailfrom=linux.alibaba.com; dkim=pass (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b=yhqkeBvF; arc=none smtp.client-ip=115.124.30.98
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.alibaba.com
DKIM-Signature:v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=linux.alibaba.com; s=default;
	t=1710158961; h=Message-ID:Subject:Date:From:To;
	bh=hrmZX3PRwUYkfvLn6mEOlu/CT3oFk/p5veIc/efHDsA=;
	b=yhqkeBvF8umesXs7aEjLCafMgbU4dQl3wAQOKeALM1zAsKnd2cAKzjjCS4G8C4G5vR8J+bP4i/ta6e6rUkU0ohaS3r8Tjo4J9rwMDUzNMvzNJkJ7/LEEqPi1WRgl+ajO4fNWBIa3UR9+GE7aSyQx5ia7TiijkVDhHICcE7O7bIo=
X-Alimail-AntiSpam:AC=PASS;BC=-1|-1;BR=01201311R261e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=ay29a033018046059;MF=xuanzhuo@linux.alibaba.com;NM=1;PH=DS;RN=14;SR=0;TI=SMTPD_---0W2HdLt1_1710158959;
Received: from localhost(mailfrom:xuanzhuo@linux.alibaba.com fp:SMTPD_---0W2HdLt1_1710158959)
          by smtp.aliyun-inc.com;
          Mon, 11 Mar 2024 20:09:20 +0800
Message-ID: <1710154125.7529383-1-xuanzhuo@linux.alibaba.com>
Subject: Re: [PATCH net-next v3 3/6] virtio_net: support device stats
Date: Mon, 11 Mar 2024 18:48:45 +0800
From: Xuan Zhuo <xuanzhuo@linux.alibaba.com>
To: Jakub Kicinski <kuba@kernel.org>
Cc: netdev@vger.kernel.org,
 "Michael S. Tsirkin" <mst@redhat.com>,
 Jason  Wang <jasowang@redhat.com>,
 "David S. Miller" <davem@davemloft.net>,
 Eric  Dumazet <edumazet@google.com>,
 Paolo Abeni <pabeni@redhat.com>,
 virtualization@lists.linux.dev,
 Willem de Bruijn <willemdebruijn.kernel@gmail.com>,
 Tariq Toukan <tariqt@nvidia.com>,
 Michael Chan <michael.chan@broadcom.com>,
 Jesse Brandeburg <jesse.brandeburg@intel.com>,
 Alexander Lobakin <aleksander.lobakin@intel.com>,
 Shannon Nelson <shannon.nelson@amd.com>
References: <20240227080303.63894-1-xuanzhuo@linux.alibaba.com>
 <20240227080303.63894-4-xuanzhuo@linux.alibaba.com>
 <20240307085021.1081777d@kernel.org>
In-Reply-To: <20240307085021.1081777d@kernel.org>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>

On Thu, 7 Mar 2024 08:50:21 -0800, Jakub Kicinski <kuba@kernel.org> wrote:
> CC: Willem and some driver folks for more input, context: extending
> https://lore.kernel.org/all/20240306195509.1502746-1-kuba@kernel.org/
> to cover virtio stats.
>
> On Tue, 27 Feb 2024 16:03:00 +0800 Xuan Zhuo wrote:
> > +static const struct virtnet_stat_desc virtnet_stats_rx_basic_desc[] = {
> > +	VIRTNET_STATS_DESC(rx, basic, packets),
> > +	VIRTNET_STATS_DESC(rx, basic, bytes),
>
> Covered.

About "packets" and "bytes", here is coming from the hw device.
Actually the driver also count "packets" and "bytes" in SW.
So there are HW and SW versions. Do we need to distinguish them?

>
> > +	VIRTNET_STATS_DESC(rx, basic, notifications),
> > +	VIRTNET_STATS_DESC(rx, basic, interrupts),
>
> I haven't seen HW devices count interrupts coming from a specific
> queue (there's usually a lot more queues than IRQs these days),
> let's keep these in ethtool -S for now, unless someone has a HW use
> case.

OK.

>
> > +	VIRTNET_STATS_DESC(rx, basic, drops),
> > +	VIRTNET_STATS_DESC(rx, basic, drop_overruns),
>
> These are important, but we need to make sure we have a good definition
> for vendors to follow...
>
> drops I'd define as "sum of all packets which came into the device, but
> never left it, including but not limited to: packets dropped due to
> lack of buffer space, processing errors, explicitly set policies and
> packet filters."
> Call it hw-rx-drops ?

I agree.

>
> overruns is a bit harder to precisely define. I was thinking of
> something more broad, like: "packets dropped due to transient lack of
> resources, such as buffer space, host descriptors etc."
>
> For context why not just go with virtio spec definition of "no
> descriptors" - for HW devices, what exact point in the pipeline drops
> depends on how back pressure is configured/implemented, and fetching
> descriptors is high latency, so differentiating between "PCIe is slow"
> and "host didn't post descriptors" is hard in practice.
> Call it hw-rx-drop-overruns ?

OK.

>
> > +static const struct virtnet_stat_desc virtnet_stats_tx_basic_desc[] = {
> > +	VIRTNET_STATS_DESC(tx, basic, packets),
> > +	VIRTNET_STATS_DESC(tx, basic, bytes),
> > +
> > +	VIRTNET_STATS_DESC(tx, basic, notifications),
> > +	VIRTNET_STATS_DESC(tx, basic, interrupts),
> > +
> > +	VIRTNET_STATS_DESC(tx, basic, drops),
>
> These 5 same as rx.
>
> > +	VIRTNET_STATS_DESC(tx, basic, drop_malformed),
>
> These I'd call hw-tx-drop-errors, "packets dropped because they were
> invalid or malformed"?

OK.

>
> > +static const struct virtnet_stat_desc virtnet_stats_rx_csum_desc[] = {
> > +	VIRTNET_STATS_DESC(rx, csum, csum_valid),
>
> I think in kernel parlance that would translate to CHECKSUM_UNNECESSARY?
> So let's call it rx-csum-unnecessary ?
> I'd skip the hw- prefix for this one, it doesn't matter to the user if
> the HW or SW counted it.

OK.

>
> > +	VIRTNET_STATS_DESC(rx, csum, needs_csum),
>
> Hm, I think this is a bit software/virt device specific, presumably
> rx-csum-partial for the kernel, up to you whether to make it ethtool -S
> or netlink.

YES. This is specific for virt device.
I will make it ethtool -S. So somebody has other advice.

>
> > +	VIRTNET_STATS_DESC(rx, csum, csum_none),
> > +	VIRTNET_STATS_DESC(rx, csum, csum_bad),
>
> These two make sense as is in netlink, should be fairly commonly
> reported by devices. Maybe add a note in "bad" that packets with
> bad csum are not discarded, but still delivered to the stack.

OK.


>
> > +static const struct virtnet_stat_desc virtnet_stats_tx_csum_desc[] = {
> > +	VIRTNET_STATS_DESC(tx, csum, needs_csum),
> > +	VIRTNET_STATS_DESC(tx, csum, csum_none),
>
> tx- version of what names we pick for rx-, netlink seems appropriate.
>
> > +static const struct virtnet_stat_desc virtnet_stats_rx_gso_desc[] = {
> > +	VIRTNET_STATS_DESC(rx, gso, gso_packets),
> > +	VIRTNET_STATS_DESC(rx, gso, gso_bytes),
>
> I used the term "GSO" in conversations about Rx and it often confuses
> people. Let's use "GRO", so hw-gro-packets, and hw-gro-bytes ?
> Or maybe coalesce? "hw-rx-coalesce" ? That's quite a bit longer..

GRO may also confuse people.

I like hw-rx-coalesce-packets, hw-rx-coalesce-bytes.

>
> Ah, and please mention in the doc that these counters "do not cover LRO
> i.e. any coalescing implementation which doesn't follow GRO rules".

OK.

>
> > +	VIRTNET_STATS_DESC(rx, gso, gso_packets_coalesced),
>
> hw-gro-wire-packets ?
> No strong preference on the naming, but I find that saying -wire
> makes it 100% clear to everyone what the meaning is.

ok.


>
> > +	VIRTNET_STATS_DESC(rx, gso, gso_bytes_coalesced),
>
> The documentation in the virtio spec seems to be identical
> to the one for gso_packets, which gotta be unintentional?

One for num, one for bytes.


> I'm guessing this is hw-gro-wire-bytes? I.e. headers counted
> multiple times?

This is used to count the bytes of the small packets before coalescing.

> > +static const struct virtnet_stat_desc virtnet_stats_tx_gso_desc[] = {
> > +	VIRTNET_STATS_DESC(tx, gso, gso_packets),
> > +	VIRTNET_STATS_DESC(tx, gso, gso_bytes),
> > +	VIRTNET_STATS_DESC(tx, gso, gso_segments),
> > +	VIRTNET_STATS_DESC(tx, gso, gso_segments_bytes),
>
> these 4 make sense as mirror of the Rx
>
> > +	VIRTNET_STATS_DESC(tx, gso, gso_packets_noseg),
> > +	VIRTNET_STATS_DESC(tx, gso, gso_bytes_noseg),
>
> Not sure what these are :) unless someone knows what it is and that
> HW devices report it, let's keep them in ethtool -S ?

Just for the virtio. Let's keep them in ethtool -S.

>
> > +static const struct virtnet_stat_desc virtnet_stats_rx_speed_desc[] = {
> > +	VIRTNET_STATS_DESC(rx, speed, packets_allowance_exceeded),
>
> hw-rx-drop-ratelimits ?
> "Allowance exceeded" is a bit of a mouthful to me, perhaps others
> disagree. The description from the virtio spec is quite good.

OK.

>
> > +	VIRTNET_STATS_DESC(rx, speed, bytes_allowance_exceeded),
>
> No strong preference whether to expose this as a standard stat or
> ethtool -S, we don't generally keep byte counters for drops, so
> this would be special.

OK.
>
> > +static const struct virtnet_stat_desc virtnet_stats_tx_speed_desc[] = {
> > +	VIRTNET_STATS_DESC(tx, speed, packets_allowance_exceeded),
> > +	VIRTNET_STATS_DESC(tx, speed, packets_allowance_exceeded),
>
> same as rx


Thanks.

