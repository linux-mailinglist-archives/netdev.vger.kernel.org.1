Return-Path: <netdev+bounces-104009-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 51B6C90AD66
	for <lists+netdev@lfdr.de>; Mon, 17 Jun 2024 13:55:25 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 444A81C22D1A
	for <lists+netdev@lfdr.de>; Mon, 17 Jun 2024 11:55:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A1110194C9C;
	Mon, 17 Jun 2024 11:55:10 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from relay9-d.mail.gandi.net (relay9-d.mail.gandi.net [217.70.183.199])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7CA2B19308B;
	Mon, 17 Jun 2024 11:55:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.70.183.199
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718625310; cv=none; b=j0sZ3xx6sob8F/qOlcjIL9qTIPp2FKOF3v4FG9Nynv8QcjLFCg0HwPxxZZ/il0MaGvZYcsY//PKihGISpJw3WNB1KMb8GoubFeiEm68gxmt2ZQ4qCpE8g7RF6hIj+oicO5kcjp8bjTLSa2NMsbygTIDTFnrHbvxJIv8jUjvhW8c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718625310; c=relaxed/simple;
	bh=dB32catZqEoQQB/UFYcx6SPTdmDhLF8vJ7YC+ZQFOGE=;
	h=Message-ID:Date:MIME-Version:Cc:Subject:To:References:From:
	 In-Reply-To:Content-Type; b=LsQbJm45bToXN9/7q3QAE+eToqQx+rLLwmXaHdfcSJ2ACfqg2Winx4CykPNpVNCb1CDevieVLaz29RSbIi+qOjcTvN9ya3F7xLep9GJTC2naWNVSK3s2Ff3EZc0JqKdLi3JTZuNDhTEI+0ej/DKvGj2eLN1tJkl12MG7wck7Nkg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ovn.org; spf=pass smtp.mailfrom=ovn.org; arc=none smtp.client-ip=217.70.183.199
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ovn.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ovn.org
Received: by mail.gandi.net (Postfix) with ESMTPSA id 0AB92FF809;
	Mon, 17 Jun 2024 11:55:03 +0000 (UTC)
Message-ID: <8624ccf8-e9e2-4a95-a25c-7d3166bb3256@ovn.org>
Date: Mon, 17 Jun 2024 13:55:02 +0200
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Cc: i.maximets@ovn.org, aconole@redhat.com, echaudro@redhat.com,
 horms@kernel.org, dev@openvswitch.org, Pravin B Shelar <pshelar@ovn.org>,
 "David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>,
 Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
 linux-kernel@vger.kernel.org
Subject: Re: [PATCH net-next v2 7/9] net: openvswitch: do not notify drops
 inside sample
To: Adrian Moreno <amorenoz@redhat.com>, netdev@vger.kernel.org
References: <20240603185647.2310748-1-amorenoz@redhat.com>
 <20240603185647.2310748-8-amorenoz@redhat.com>
Content-Language: en-US
From: Ilya Maximets <i.maximets@ovn.org>
Autocrypt: addr=i.maximets@ovn.org; keydata=
 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
In-Reply-To: <20240603185647.2310748-8-amorenoz@redhat.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-GND-Sasl: i.maximets@ovn.org

On 6/3/24 20:56, Adrian Moreno wrote:
> The OVS_ACTION_ATTR_SAMPLE action is, in essence,
> observability-oriented.
> 
> Apart from some corner case in which it's used a replacement of clone()
> for old kernels, it's really only used for sFlow, IPFIX and now,
> local emit_sample.
> 
> With this in mind, it doesn't make much sense to report
> OVS_DROP_LAST_ACTION inside sample actions.
> 
> For instance, if the flow:
> 
>   actions:sample(..,emit_sample(..)),2
> 
> triggers a OVS_DROP_LAST_ACTION skb drop event, it would be extremely
> confusing for users since the packet did reach its destination.
> 
> This patch makes internal action execution silently consume the skb
> instead of notifying a drop for this case.
> 
> Unfortunately, this patch does not remove all potential sources of
> confusion since, if the sample action itself is the last action, e.g:
> 
>     actions:sample(..,emit_sample(..))
> 
> we actually _should_ generate a OVS_DROP_LAST_ACTION event, but we aren't.
> 
> Sadly, this case is difficult to solve without breaking the
> optimization by which the skb is not cloned on last sample actions.
> But, given explicit drop actions are now supported, OVS can just add one
> after the last sample() and rewrite the flow as:
> 
>     actions:sample(..,emit_sample(..)),drop
> 
> Signed-off-by: Adrian Moreno <amorenoz@redhat.com>
> ---
>  net/openvswitch/actions.c | 13 +++++++++++--
>  1 file changed, 11 insertions(+), 2 deletions(-)
> 
> diff --git a/net/openvswitch/actions.c b/net/openvswitch/actions.c
> index 33f6d93ba5e4..54fc1abcff95 100644
> --- a/net/openvswitch/actions.c
> +++ b/net/openvswitch/actions.c
> @@ -82,6 +82,15 @@ static struct action_fifo __percpu *action_fifos;
>  static struct action_flow_keys __percpu *flow_keys;
>  static DEFINE_PER_CPU(int, exec_actions_level);
>  
> +static inline void ovs_drop_skb_last_action(struct sk_buff *skb)
> +{
> +	/* Do not emit packet drops inside sample(). */
> +	if (OVS_CB(skb)->probability)
> +		consume_skb(skb);
> +	else
> +		ovs_kfree_skb_reason(skb, OVS_DROP_LAST_ACTION);
> +}
> +
>  /* Make a clone of the 'key', using the pre-allocated percpu 'flow_keys'
>   * space. Return NULL if out of key spaces.
>   */
> @@ -1061,7 +1070,7 @@ static int sample(struct datapath *dp, struct sk_buff *skb,
>  	if ((arg->probability != U32_MAX) &&
>  	    (!arg->probability || get_random_u32() > arg->probability)) {
>  		if (last)
> -			ovs_kfree_skb_reason(skb, OVS_DROP_LAST_ACTION);
> +			ovs_drop_skb_last_action(skb);
>  		return 0;
>  	}
>  
> @@ -1579,7 +1588,7 @@ static int do_execute_actions(struct datapath *dp, struct sk_buff *skb,
>  		}
>  	}
>  
> -	ovs_kfree_skb_reason(skb, OVS_DROP_LAST_ACTION);
> +	ovs_drop_skb_last_action(skb);

I don't think I agree with this one.  If we have a sample() action with
a lot of different actions inside and we reached the end while the last
action didn't consume the skb, then we should report that.  E.g.
"sample(emit_sample(),push_vlan(),set(eth())),2"  should report that the
cloned skb was dropped.  "sample(push_vlan(),emit_sample())" should not.

The only actions that are actually consuming the skb are "output",
"userspace", "recirc" and now "emit_sample".  "output" and "recirc" are
consuming the skb "naturally" by stealing it when it is the last action.
"userspace" has an explicit check to consume the skb if it is the last
action.  "emit_sample" should have the similar check.  It should likely
be added at the point of action introduction instead of having a separate
patch.

Best regards, Ilya Maximets.

