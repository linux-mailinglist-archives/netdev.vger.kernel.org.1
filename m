Return-Path: <netdev+bounces-37157-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id B817B7B4012
	for <lists+netdev@lfdr.de>; Sat, 30 Sep 2023 13:09:20 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sy.mirrors.kernel.org (Postfix) with ESMTP id 455DBB2099F
	for <lists+netdev@lfdr.de>; Sat, 30 Sep 2023 11:09:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 46E6E8827;
	Sat, 30 Sep 2023 11:09:14 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ABDB515A6
	for <netdev@vger.kernel.org>; Sat, 30 Sep 2023 11:09:12 +0000 (UTC)
Received: from Chamillionaire.breakpoint.cc (Chamillionaire.breakpoint.cc [IPv6:2a0a:51c0:0:237:300::1])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5B670CA;
	Sat, 30 Sep 2023 04:09:10 -0700 (PDT)
Received: from fw by Chamillionaire.breakpoint.cc with local (Exim 4.92)
	(envelope-from <fw@strlen.de>)
	id 1qmXqA-0003rY-Oh; Sat, 30 Sep 2023 13:08:54 +0200
Date: Sat, 30 Sep 2023 13:08:54 +0200
From: Florian Westphal <fw@strlen.de>
To: Yan Zhai <yan@cloudflare.com>
Cc: netdev@vger.kernel.org, "David S. Miller" <davem@davemloft.net>,
	David Ahern <dsahern@kernel.org>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	Aya Levin <ayal@nvidia.com>, Tariq Toukan <tariqt@nvidia.com>,
	linux-kernel@vger.kernel.org, kernel-team@cloudflare.com
Subject: Re: [PATCH net] ipv6: avoid atomic fragment on GSO packets
Message-ID: <20230930110854.GA13787@breakpoint.cc>
References: <ZRcOXJ0pkuph6fko@debian.debian>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ZRcOXJ0pkuph6fko@debian.debian>
User-Agent: Mutt/1.10.1 (2018-07-13)
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,
	RCVD_IN_DNSWL_BLOCKED,SPF_HELO_PASS,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

Yan Zhai <yan@cloudflare.com> wrote:
> GSO packets can contain a trailing segment that is smaller than
> gso_size. When examining the dst MTU for such packet, if its gso_size
> is too large, then all segments would be fragmented. However, there is a
> good chance the trailing segment has smaller actual size than both
> gso_size as well as the MTU, which leads to an "atomic fragment".
> RFC-8021 explicitly recommend to deprecate such use case. An Existing
> report from APNIC also shows that atomic fragments can be dropped
> unexpectedly along the path [1].
> 
> Add an extra check in ip6_fragment to catch all possible generation of
> atomic fragments. Skip atomic header if it is called on a packet no
> larger than MTU.
> 
> Link: https://www.potaroo.net/presentations/2022-03-01-ipv6-frag.pdf [1]
> Fixes: b210de4f8c97 ("net: ipv6: Validate GSO SKB before finish IPv6 processing")
> Reported-by: David Wragg <dwragg@cloudflare.com>
> Signed-off-by: Yan Zhai <yan@cloudflare.com>
> ---
>  net/ipv6/ip6_output.c | 8 +++++++-
>  1 file changed, 7 insertions(+), 1 deletion(-)
> 
> diff --git a/net/ipv6/ip6_output.c b/net/ipv6/ip6_output.c
> index 951ba8089b5b..42f5f68a6e24 100644
> --- a/net/ipv6/ip6_output.c
> +++ b/net/ipv6/ip6_output.c
> @@ -854,6 +854,13 @@ int ip6_fragment(struct net *net, struct sock *sk, struct sk_buff *skb,
>  	__be32 frag_id;
>  	u8 *prevhdr, nexthdr = 0;
>  
> +	/* RFC-8021 recommended atomic fragments to be deprecated. Double check
> +	 * the actual packet size before fragment it.
> +	 */
> +	mtu = ip6_skb_dst_mtu(skb);
> +	if (unlikely(skb->len <= mtu))
> +		return output(net, sk, skb);
> +

This helper is also called for skbs where IP6CB(skb)->frag_max_size
exceeds the MTU, so this check looks wrong to me.

Same remark for dst_allfrag() check in __ip6_finish_output(),
after this patch, it would be ignored.

I think you should consider to first refactor __ip6_finish_output to make
the existing checks more readable (e.g. handle gso vs. non-gso in separate
branches) and then add the check to last seg in
ip6_finish_output_gso_slowpath_drop().

Alternatively you might be able to pass more info down to
ip6_fragment and move decisions there.

In any case we should make same frag-or-no-frag decisions,
regardless of this being the orig skb or a segmented one,

