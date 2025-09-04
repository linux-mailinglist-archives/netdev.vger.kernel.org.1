Return-Path: <netdev+bounces-219846-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 0F244B436BC
	for <lists+netdev@lfdr.de>; Thu,  4 Sep 2025 11:13:40 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 493793AA42F
	for <lists+netdev@lfdr.de>; Thu,  4 Sep 2025 09:13:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E9A802E1C57;
	Thu,  4 Sep 2025 09:13:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="WYIz2Cfk"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B873A2DFA5C;
	Thu,  4 Sep 2025 09:13:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756977200; cv=none; b=mt1lPq5Od3VL5XN+YLdxDRUfYFUUHix/UkPpg3bpD0eo4EknZplmRnjgdqDVXsqoYj4EWVV/6syC6dwoWEVRYhC4hEdb/NvGr7f/tZYcJO21rge+/AIs/BY/BNvUt0bPavaDNoHfSC6NspLtaEVMPRgNpRb4ZyvWmqQMPFVVgY4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756977200; c=relaxed/simple;
	bh=YWs124h50QsnlAzsLxV+1+ek9G9jWfNKu3Q0CLQIH1s=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=DIX6EPQ6ubRRlf9SQoWcX/cvWIYUZ8WkhP7OYSBEZZ+xkaX754GVJRfgfwacTQ75oPTPUgBkwuNs0awVwwiUUYWcW0hVmKEuBHQL4JzqWsMZFTQuBC5y9qeQGxUVmJJVneB5ywEwgbWsKhCbSc0F6RoKcQ50HJ9AtGH36Cgaltg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=WYIz2Cfk; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9D1F4C4CEF0;
	Thu,  4 Sep 2025 09:13:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1756977200;
	bh=YWs124h50QsnlAzsLxV+1+ek9G9jWfNKu3Q0CLQIH1s=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=WYIz2Cfk1CY+u0nZdgXpFoMkvx02jTRnaFbblTwv6Rx5VBNwqlIwoS9RT/tDGtier
	 grFdVdXgZyMfwTYk3bN2Wwg5oAQ8kEjjhZTjfZPiKXVjDzP0Hc/47MxmhbN+3x53HH
	 7VMUB4qXr1fztPZl4JeHRU7muK9miMwI1xVq6kswLBhn2T4LusZ9B68LpFrE+u6tOP
	 wDPPrYnJG2TD6uhiQQlw2qGyhGuOmNfpScLdGk/UFoTtKJt1/lsUnvL9TY/m1XOyBq
	 GEeLDXTf339uD6S0nwQEibu15CRaZR4SZsUpX4fIojH5eOPbL/bp+2boVyInOX1MRb
	 YQXVUg8vpnc6g==
Date: Thu, 4 Sep 2025 10:13:15 +0100
From: Simon Horman <horms@kernel.org>
To: "Gustavo A. R. Silva" <gustavoars@kernel.org>
Cc: "Michael S. Tsirkin" <mst@redhat.com>, Jason Wang <jasowang@redhat.com>,
	Xuan Zhuo <xuanzhuo@linux.alibaba.com>,
	Eugenio =?utf-8?B?UMOpcmV6?= <eperezma@redhat.com>,
	Andrew Lunn <andrew+netdev@lunn.ch>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	virtualization@lists.linux.dev, netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org, linux-hardening@vger.kernel.org
Subject: Re: [PATCH][next] virtio_net: Fix alignment and avoid
 -Wflex-array-member-not-at-end warning
Message-ID: <20250904091315.GB372207@horms.kernel.org>
References: <aLiYrQGdGmaDTtLF@kspp>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <aLiYrQGdGmaDTtLF@kspp>

On Wed, Sep 03, 2025 at 09:36:13PM +0200, Gustavo A. R. Silva wrote:
> -Wflex-array-member-not-at-end was introduced in GCC-14, and we are
> getting ready to enable it, globally.
> 
> Use the new TRAILING_OVERLAP() helper to fix the following warning:
> 
> drivers/net/virtio_net.c:429:46: warning: structure containing a flexible array member is not at the end of another structure [-Wflex-array-member-not-at-end]
> 
> This helper creates a union between a flexible-array member (FAM)
> and a set of members that would otherwise follow it (in this case
> `u8 rss_hash_key_data[VIRTIO_NET_RSS_MAX_KEY_SIZE];`). This
> overlays the trailing members (rss_hash_key_data) onto the FAM
> (hash_key_data) while keeping the FAM and the start of MEMBERS aligned.
> The static_assert() ensures this alignment remains, and it's
> intentionally placed inmediately after `struct virtnet_info` (no
> blank line in between).
> 
> Notice that due to tail padding in flexible `struct
> virtio_net_rss_config_trailer`, `rss_trailer.hash_key_data`
> (at offset 83 in struct virtnet_info) and `rss_hash_key_data` (at
> offset 84 in struct virtnet_info) are misaligned by one byte. See
> below:
> 
> struct virtio_net_rss_config_trailer {
>         __le16                     max_tx_vq;            /*     0     2 */
>         __u8                       hash_key_length;      /*     2     1 */
>         __u8                       hash_key_data[];      /*     3     0 */
> 
>         /* size: 4, cachelines: 1, members: 3 */
>         /* padding: 1 */
>         /* last cacheline: 4 bytes */
> };
> 
> struct virtnet_info {
> ...
>         struct virtio_net_rss_config_trailer rss_trailer; /*    80     4 */
> 
>         /* XXX last struct has 1 byte of padding */
> 
>         u8                         rss_hash_key_data[40]; /*    84    40 */
> ...
>         /* size: 832, cachelines: 13, members: 48 */
>         /* sum members: 801, holes: 8, sum holes: 31 */
>         /* paddings: 2, sum paddings: 5 */
> };
> 
> After changes, those members are correctly aligned at offset 795:
> 
> struct virtnet_info {
> ...
>         union {
>                 struct virtio_net_rss_config_trailer rss_trailer; /*   792     4 */
>                 struct {
>                         unsigned char __offset_to_hash_key_data[3]; /*   792     3 */
>                         u8         rss_hash_key_data[40]; /*   795    40 */
>                 };                                       /*   792    43 */
>         };                                               /*   792    44 */
> ...
>         /* size: 840, cachelines: 14, members: 47 */
>         /* sum members: 801, holes: 8, sum holes: 35 */
>         /* padding: 4 */
>         /* paddings: 1, sum paddings: 4 */
>         /* last cacheline: 8 bytes */
> };
> 
> As a last note `struct virtio_net_rss_config_hdr *rss_hdr;` is also
> moved to the end, since it seems those three members should stick
> around together. :)
> 
> Signed-off-by: Gustavo A. R. Silva <gustavoars@kernel.org>
> ---
> 
> This should probably include the following tag:
> 
> 	Fixes: ed3100e90d0d ("virtio_net: Use new RSS config structs")
> 
> but I'd like to hear some feedback, first.

I tend to agree given that:

On the one hand:

1) in virtnet_init_default_rss(), netdev_rss_key_fill() is used
   to write random data to .rss_hash_key_data

2) In virtnet_set_rxfh() key data written to .rss_hash_key_data

While

3) In virtnet_commit_rss_command() virtio_net_rss_config_trailer,
   including the contents of .hash_key_data based on the length of
   that data provided in .hash_key_length is copied.

It seems to me that step 3 will include 1 byte of uninitialised data
at the start of .hash_key_data. And, correspondingly, truncate
.rss_hash_key_data by one byte.

It's unclear to me what the effect of this - perhaps they key works
regardless. But it doesn't seem intended. And while the result may be
neutral, I do  suspect this reduces the quality of the key. And I more
strongly suspect it doesn't have any positive outcome.

So I would lean towards playing it safe and considering this as a bug.

Of course, other's may have better insight as to the actual effect of this.

...

