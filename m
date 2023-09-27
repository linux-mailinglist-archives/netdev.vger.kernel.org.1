Return-Path: <netdev+bounces-36467-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 39F2B7AFE42
	for <lists+netdev@lfdr.de>; Wed, 27 Sep 2023 10:25:50 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sv.mirrors.kernel.org (Postfix) with ESMTP id DE61E2812CE
	for <lists+netdev@lfdr.de>; Wed, 27 Sep 2023 08:25:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 12B7C1C6B6;
	Wed, 27 Sep 2023 08:25:48 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E7F305384
	for <netdev@vger.kernel.org>; Wed, 27 Sep 2023 08:25:45 +0000 (UTC)
Received: from relay8-d.mail.gandi.net (relay8-d.mail.gandi.net [IPv6:2001:4b98:dc4:8::228])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3520C1B5
	for <netdev@vger.kernel.org>; Wed, 27 Sep 2023 01:25:44 -0700 (PDT)
Received: by mail.gandi.net (Postfix) with ESMTPSA id 7D0291BF20C;
	Wed, 27 Sep 2023 08:25:41 +0000 (UTC)
Message-ID: <8dc83d57-3e92-1d50-321c-fff6fde58bac@ovn.org>
Date: Wed, 27 Sep 2023 10:26:32 +0200
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.13.0
Cc: dev@openvswitch.org, i.maximets@ovn.org
Subject: Re: [ovs-dev] [RFC PATCH 1/7] net: openvswitch: Move NSH buffer out
 of do_execute_actions
Content-Language: en-US
To: Nicholas Piggin <npiggin@gmail.com>, netdev@vger.kernel.org
References: <20230927001308.749910-1-npiggin@gmail.com>
 <20230927001308.749910-2-npiggin@gmail.com>
From: Ilya Maximets <i.maximets@ovn.org>
In-Reply-To: <20230927001308.749910-2-npiggin@gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-GND-Sasl: i.maximets@ovn.org
X-Spam-Status: No, score=-2.6 required=5.0 tests=BAYES_00,NICE_REPLY_A,
	RCVD_IN_DNSWL_BLOCKED,SPF_HELO_PASS,SPF_NEUTRAL autolearn=ham
	autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

On 9/27/23 02:13, Nicholas Piggin wrote:
> This takes do_execute_actions stack use from 544 bytes to 288
> bytes. execute_push_nsh uses 336 bytes, but it is a leaf call not
> involved in recursion.
> 
> Signed-off-by: Nicholas Piggin <npiggin@gmail.com>
> ---
>  net/openvswitch/actions.c | 27 +++++++++++++++++----------
>  1 file changed, 17 insertions(+), 10 deletions(-)

Hi, Nicholas.  I made the same change about a week ago:
  https://lore.kernel.org/netdev/20230921194314.1976605-1-i.maximets@ovn.org/
So, you can drop this patch from your set.

Best regards, Ilya Maximets.

> 
> diff --git a/net/openvswitch/actions.c b/net/openvswitch/actions.c
> index fd66014d8a76..8933caa92794 100644
> --- a/net/openvswitch/actions.c
> +++ b/net/openvswitch/actions.c
> @@ -1286,6 +1286,21 @@ static int execute_dec_ttl(struct sk_buff *skb, struct sw_flow_key *key)
>  	return 0;
>  }
>  
> +static noinline_for_stack int execute_push_nsh(struct sk_buff *skb,
> +					       struct sw_flow_key *key,
> +					       const struct nlattr *attr)
> +{
> +	u8 buffer[NSH_HDR_MAX_LEN];
> +	struct nshhdr *nh = (struct nshhdr *)buffer;
> +	int err;
> +
> +	err = nsh_hdr_from_nlattr(attr, nh, NSH_HDR_MAX_LEN);
> +	if (likely(!err))
> +		err = push_nsh(skb, key, nh);
> +
> +	return err;
> +}
> +
>  /* Execute a list of actions against 'skb'. */
>  static int do_execute_actions(struct datapath *dp, struct sk_buff *skb,
>  			      struct sw_flow_key *key,
> @@ -1439,17 +1454,9 @@ static int do_execute_actions(struct datapath *dp, struct sk_buff *skb,
>  			err = pop_eth(skb, key);
>  			break;
>  
> -		case OVS_ACTION_ATTR_PUSH_NSH: {
> -			u8 buffer[NSH_HDR_MAX_LEN];
> -			struct nshhdr *nh = (struct nshhdr *)buffer;
> -
> -			err = nsh_hdr_from_nlattr(nla_data(a), nh,
> -						  NSH_HDR_MAX_LEN);
> -			if (unlikely(err))
> -				break;
> -			err = push_nsh(skb, key, nh);
> +		case OVS_ACTION_ATTR_PUSH_NSH:
> +			err = execute_push_nsh(skb, key, nla_data(a));
>  			break;
> -		}
>  
>  		case OVS_ACTION_ATTR_POP_NSH:
>  			err = pop_nsh(skb, key);


