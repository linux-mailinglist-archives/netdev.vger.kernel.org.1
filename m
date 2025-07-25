Return-Path: <netdev+bounces-210054-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 0B558B11FBF
	for <lists+netdev@lfdr.de>; Fri, 25 Jul 2025 16:06:02 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id E936C1CE4B97
	for <lists+netdev@lfdr.de>; Fri, 25 Jul 2025 14:06:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 432131ADC97;
	Fri, 25 Jul 2025 14:05:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="jMvaaTbL"
X-Original-To: netdev@vger.kernel.org
Received: from fhigh-a1-smtp.messagingengine.com (fhigh-a1-smtp.messagingengine.com [103.168.172.152])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5A3F310FD
	for <netdev@vger.kernel.org>; Fri, 25 Jul 2025 14:05:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.152
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753452358; cv=none; b=p5KdTJisL25XQ6PUTPoFo3B4MEoOL1/5M+crG/c8jVqHbiUOBQrHH5aRXNnajW6oPZVOmZ8qxSlwhO+5+BIYhZCeDTF5wi8b9HC1f3X6Eb/0OMj+75znjcV3sJs75RKwxuATcl38iN+Llvtf9uDnUMwQyWXFET8kKbhpKRUoxVs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753452358; c=relaxed/simple;
	bh=aujr9dQmvuOFtLExiD0PSAA22/xtHkKRICtDiJBFziY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=rLI2fHNY+JuqOdnuGYH9NZ3LtgEZEztQtNx/nwnzhnIuVL2DvzYT8TNK49ctMCgWNp9lRA5/lb+SXx7v+rdJfiCm6lOD28EEZYHMIQlRdlfU7XJ9hUTZ/T4VHaE6+dKrDBaqyaa6jfkSjYVOwDJtE4dtoZJChzMm2AF21xMDAXA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=idosch.org; spf=none smtp.mailfrom=idosch.org; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=jMvaaTbL; arc=none smtp.client-ip=103.168.172.152
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=idosch.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=idosch.org
Received: from phl-compute-03.internal (phl-compute-03.phl.internal [10.202.2.43])
	by mailfhigh.phl.internal (Postfix) with ESMTP id 763BE1400548;
	Fri, 25 Jul 2025 10:05:55 -0400 (EDT)
Received: from phl-mailfrontend-02 ([10.202.2.163])
  by phl-compute-03.internal (MEProxy); Fri, 25 Jul 2025 10:05:55 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm2; t=
	1753452355; x=1753538755; bh=N+kHxpipNhjucJJL9Twh493YZMFMau/Si7R
	ulOH/HL0=; b=jMvaaTbLJMnw3vL6ibfuYQ6IaJJ1wPIoUsokLXahUA8/l7fFdKm
	3f2X40yrnyeXjfmBmws14bVEXxgydQJt7rM3xzMJpWZDJvYz9F0jNxCfZBfby+V3
	Toor8BQLVEBpjudYueu6bF90avTJgV6enJbTu4XYA2WcB5+XUFN9UvVPyR+ti5Zg
	1k4ysobpeLVUTiVBh8bAl/LZf43DxDXZqytpAUoIVVYgUz0RSIQzSrvw19EyP2YM
	PrbPVb1j5Y7jYykGknBHOh5jIc5dducGQSIzrJ99WaQ3V2Js7Co7G9wR6xcS1cPL
	6KbHLtm90uMHW5DGjAC/haw2ywzMzW5XWEQ==
X-ME-Sender: <xms:Q4-DaEaoLKrsnjCV_6L_8XUBw8vhj9WiCvxqgjBSS047jzHLbkBgtQ>
    <xme:Q4-DaMVHR_y7IjmI5ckOV1NnBB0z3FxfracNluZSC4bIEAb9BHeeX7FrGClrOsd_W
    h9onUM4kL3rLWI>
X-ME-Received: <xmr:Q4-DaKmqWekKTiJVZVjEktbmdaIKtnCW1lgSW45Kwv2-iPdEdYmbb51VBfFOf91A_SkvwoAECyKZfdAwCYC370Ac>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeffedrtdefgdekfeejvdcutefuodetggdotefrod
    ftvfcurfhrohhfihhlvgemucfhrghsthforghilhdpuffrtefokffrpgfnqfghnecuuegr
    ihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenucfjug
    hrpeffhffvvefukfhfgggtuggjsehttdertddttddvnecuhfhrohhmpefkughoucfutghh
    ihhmmhgvlhcuoehiughoshgthhesihguohhstghhrdhorhhgqeenucggtffrrghtthgvrh
    hnpedvudefveekheeugeeftddvveefgfduieefudeifefgleekheegleegjeejgeeghfen
    ucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepmhgrihhlfhhrohhmpehiughosh
    gthhesihguohhstghhrdhorhhgpdhnsggprhgtphhtthhopeekpdhmohguvgepshhmthhp
    ohhuthdprhgtphhtthhopegtphgrrghstghhsehophgvnhgrihdrtghomhdprhgtphhtth
    hopegushgrhhgvrhhnsehkvghrnhgvlhdrohhrghdprhgtphhtthhopegurghvvghmsegu
    rghvvghmlhhofhhtrdhnvghtpdhrtghpthhtohepvgguuhhmrgiivghtsehgohhoghhlvg
    drtghomhdprhgtphhtthhopehkuhgsrgeskhgvrhhnvghlrdhorhhgpdhrtghpthhtohep
    phgrsggvnhhisehrvgguhhgrthdrtghomhdprhgtphhtthhopehhohhrmhhssehkvghrnh
    gvlhdrohhrghdprhgtphhtthhopehnvghtuggvvhesvhhgvghrrdhkvghrnhgvlhdrohhr
    gh
X-ME-Proxy: <xmx:Q4-DaHAOjPSdjrLuMtuNVCEAKVUCtf9RJjzFBH5Y4QES3nILq_uigg>
    <xmx:Q4-DaJjDkkRpuuvk4_n6o0xG1z8ViF7d4vWW9V1mIqcAYDW8p7FYVA>
    <xmx:Q4-DaEwoG7G4ptjDtVO8dgMOcsl6NbuNubkcH5of-jAM8BOWOwN1BQ>
    <xmx:Q4-DaK1QiA_abq2F201aUSHl1wO6EoaEIL8h94WXwncJoIvww90myQ>
    <xmx:Q4-DaOA04CKDgbQeT4lZzJQHY-OcH1-oIdAi7l1-dcV_0Zyhq-cq1K46>
Feedback-ID: i494840e7:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Fri,
 25 Jul 2025 10:05:54 -0400 (EDT)
Date: Fri, 25 Jul 2025 17:05:52 +0300
From: Ido Schimmel <idosch@idosch.org>
To: cpaasch@openai.com
Cc: David Ahern <dsahern@kernel.org>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	Simon Horman <horms@kernel.org>, netdev@vger.kernel.org
Subject: Re: [PATCH net-next] net: Make nexthop-dumps scale linearly with the
 number of nexthops
Message-ID: <aIOPQH-S5LAPCb1u@shredder>
References: <20250724-nexthop_dump-v1-1-6b43fffd5bac@openai.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250724-nexthop_dump-v1-1-6b43fffd5bac@openai.com>

On Thu, Jul 24, 2025 at 05:10:36PM -0700, Christoph Paasch via B4 Relay wrote:
> From: Christoph Paasch <cpaasch@openai.com>
> 
> When we have a (very) large number of nexthops, they do not fit within a
> single message. rtm_dump_walk_nexthops() thus will be called repeatedly
> and ctx->idx is used to avoid dumping the same nexthops again.
> 
> The approach in which we avoid dumpint the same nexthops is by basically

s/dumpint/dumping/

> walking the entire nexthop rb-tree from the left-most node until we find
> a node whose id is >= s_idx. That does not scale well.
> 
> Instead of this non-efficient  approach, rather go directly through the
                               ^ double space
s/non-efficient/inefficient/ ?

> tree to the nexthop that should be dumped (the one whose nh_id >=
> s_idx). This allows us to find the relevant node in O(log(n)).
> 
> We have quite a nice improvement with this:
> 
> Before:
> =======
> 
> --> ~1M nexthops:
> $ time ~/libnl/src/nl-nh-list | wc -l
> 1050624
> 
> real	0m21.080s
> user	0m0.666s
> sys	0m20.384s
> 
> --> ~2M nexthops:
> $ time ~/libnl/src/nl-nh-list | wc -l
> 2101248
> 
> real	1m51.649s
> user	0m1.540s
> sys	1m49.908s
> 
> After:
> ======
> 
> --> ~1M nexthops:
> $ time ~/libnl/src/nl-nh-list | wc -l
> 1050624
> 
> real	0m1.157s
> user	0m0.926s
> sys	0m0.259s
> 
> --> ~2M nexthops:
> $ time ~/libnl/src/nl-nh-list | wc -l
> 2101248
> 
> real	0m2.763s
> user	0m2.042s
> sys	0m0.776s

I was able to reproduce these results.

> 
> Signed-off-by: Christoph Paasch <cpaasch@openai.com>
> ---
>  net/ipv4/nexthop.c | 34 +++++++++++++++++++++++++++++++++-
>  1 file changed, 33 insertions(+), 1 deletion(-)
> 
> diff --git a/net/ipv4/nexthop.c b/net/ipv4/nexthop.c
> index 29118c43ebf5f1e91292fe227d4afde313e564bb..226447b1c17d22eab9121bed88c0c2b9148884ac 100644
> --- a/net/ipv4/nexthop.c
> +++ b/net/ipv4/nexthop.c
> @@ -3511,7 +3511,39 @@ static int rtm_dump_walk_nexthops(struct sk_buff *skb,
>  	int err;
>  
>  	s_idx = ctx->idx;
> -	for (node = rb_first(root); node; node = rb_next(node)) {
> +
> +	/*
> +	 * If this is not the first invocation, ctx->idx will contain the id of
> +	 * the last nexthop we processed.  Instead of starting from the very first
> +	 * element of the red/black tree again and linearly skipping the
> +	 * (potentially large) set of nodes with an id smaller than s_idx, walk the
> +	 * tree and find the left-most node whose id is >= s_idx.  This provides an
> +	 * efficient O(log n) starting point for the dump continuation.
> +	 */

Please try to keep lines at 80 characters.

> +	if (s_idx != 0) {
> +		struct rb_node *tmp = root->rb_node;
> +
> +		node = NULL;
> +		while (tmp) {
> +			struct nexthop *nh;
> +
> +			nh = rb_entry(tmp, struct nexthop, rb_node);
> +			if (nh->id < s_idx) {
> +				tmp = tmp->rb_right;
> +			} else {
> +				/* Track current candidate and keep looking on
> +				 * the left side to find the left-most
> +				 * (smallest id) that is still >= s_idx.
> +				 */

I'm aware that netdev now accepts both comment styles, but it's a bit
weird to mix both in the same commit and at the same function.

> +				node = tmp;
> +				tmp = tmp->rb_left;
> +			}
> +		}
> +	} else {
> +		node = rb_first(root);
> +	}
> +
> +	for (; node; node = rb_next(node)) {
>  		struct nexthop *nh;
>  
>  		nh = rb_entry(node, struct nexthop, rb_node);

The code below is:

if (nh->id < s_idx)
	continue;

Can't it be removed given the above code means we start at a nexthop
whose identifier is at least s_idx ?

