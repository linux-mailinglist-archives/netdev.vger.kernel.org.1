Return-Path: <netdev+bounces-22817-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 15143769571
	for <lists+netdev@lfdr.de>; Mon, 31 Jul 2023 14:03:11 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 466651C20C0D
	for <lists+netdev@lfdr.de>; Mon, 31 Jul 2023 12:03:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B6E4F182AE;
	Mon, 31 Jul 2023 12:02:59 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 73CC0182A7
	for <netdev@vger.kernel.org>; Mon, 31 Jul 2023 12:02:58 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D4D23C433C7;
	Mon, 31 Jul 2023 12:02:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1690804978;
	bh=cBSymYPkjmxohnnaoxyxwZuTdKvrG00Ch3k3nTvBjRE=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=t8FHtgQdz7fIkyhoeSAUrF8hO5Q26wudZMKsPbiv3v+SfGrdCoCiq6w6maC0D5YPn
	 UCTUkioaI0VCzInyUM7SyefFMmLSM5fBtz47+leXGtVYjXOFEkxxId8OpJ7R6xhlqY
	 0BkVmJYHQWjNxiixk3QjRp1WQ3p4KWp3d1fdNI2+SKNCkslxuEBduLZItsJUzZC88X
	 Xwn+kRqtsatuwPS2yurm0fcdbNi2kmJhPgLfnXwqjqlHCHVZY+jNhg/4qz7DoQ1r+C
	 e3Ljftk6oMkkUM2Tcr2sdR67g5wEkXs0OAhlDhRRmUEBKlZKy9OWVBEjQSOrGrYPoY
	 dqFZWnUzanc4Q==
Date: Mon, 31 Jul 2023 15:02:54 +0300
From: Leon Romanovsky <leon@kernel.org>
To: Ratheesh Kannoth <rkannoth@marvell.com>
Cc: netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
	sgoutham@marvell.com, lcherian@marvell.com, gakula@marvell.com,
	jerinj@marvell.com, hkelam@marvell.com, sbhatta@marvell.com,
	davem@davemloft.net, edumazet@google.com, kuba@kernel.org,
	pabeni@redhat.com, jhs@mojatatu.com, xiyou.wangcong@gmail.com,
	jiri@resnulli.us
Subject: Re: [PATCH net-next 2/4] tc: flower: support for SPI
Message-ID: <20230731120254.GB87829@unreal>
References: <20230731113408.2586913-1-rkannoth@marvell.com>
 <20230731113408.2586913-3-rkannoth@marvell.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230731113408.2586913-3-rkannoth@marvell.com>

On Mon, Jul 31, 2023 at 05:04:06PM +0530, Ratheesh Kannoth wrote:
> tc flower rules support to classify ESP/AH
> packets matching SPI field.
> 
> Signed-off-by: Ratheesh Kannoth <rkannoth@marvell.com>
> ---
>  include/uapi/linux/pkt_cls.h |  3 +++
>  net/sched/cls_flower.c       | 35 +++++++++++++++++++++++++++++++++++
>  2 files changed, 38 insertions(+)
> 
> diff --git a/include/uapi/linux/pkt_cls.h b/include/uapi/linux/pkt_cls.h
> index 7865f5a9885b..a90b0e3d351f 100644
> --- a/include/uapi/linux/pkt_cls.h
> +++ b/include/uapi/linux/pkt_cls.h
> @@ -594,6 +594,9 @@ enum {
>  
>  	TCA_FLOWER_KEY_L2TPV3_SID,	/* be32 */
>  
> +	TCA_FLOWER_KEY_SPI,		/* be32 */
> +	TCA_FLOWER_KEY_SPI_MASK,	/* be32 */
> +

You can't add new fields in the middle of UAPI exposed enum. It will
break all applications were compiled against old header but run on new
kernel and vice versa.

Thanks

>  	TCA_FLOWER_L2_MISS,		/* u8 */
>  
>  	TCA_FLOWER_KEY_CFM,		/* nested */
> diff --git a/net/sched/cls_flower.c b/net/sched/cls_flower.c
> index 8da9d039d964..eca260272845 100644
> --- a/net/sched/cls_flower.c
> +++ b/net/sched/cls_flower.c
> @@ -72,6 +72,7 @@ struct fl_flow_key {
>  	struct flow_dissector_key_num_of_vlans num_of_vlans;
>  	struct flow_dissector_key_pppoe pppoe;
>  	struct flow_dissector_key_l2tpv3 l2tpv3;
> +	struct flow_dissector_key_ipsec ipsec;
>  	struct flow_dissector_key_cfm cfm;
>  } __aligned(BITS_PER_LONG / 8); /* Ensure that we can do comparisons as longs. */
>  
> @@ -726,6 +727,8 @@ static const struct nla_policy fl_policy[TCA_FLOWER_MAX + 1] = {
>  	[TCA_FLOWER_KEY_PPPOE_SID]	= { .type = NLA_U16 },
>  	[TCA_FLOWER_KEY_PPP_PROTO]	= { .type = NLA_U16 },
>  	[TCA_FLOWER_KEY_L2TPV3_SID]	= { .type = NLA_U32 },
> +	[TCA_FLOWER_KEY_SPI]		= { .type = NLA_U32 },
> +	[TCA_FLOWER_KEY_SPI_MASK]	= { .type = NLA_U32 },
>  	[TCA_FLOWER_L2_MISS]		= NLA_POLICY_MAX(NLA_U8, 1),
>  	[TCA_FLOWER_KEY_CFM]		= { .type = NLA_NESTED },
>  };
> @@ -795,6 +798,24 @@ static void fl_set_key_val(struct nlattr **tb,
>  		nla_memcpy(mask, tb[mask_type], len);
>  }
>  
> +static int fl_set_key_spi(struct nlattr **tb, struct fl_flow_key *key,
> +			  struct fl_flow_key *mask,
> +			  struct netlink_ext_ack *extack)
> +{
> +	if (key->basic.ip_proto != IPPROTO_ESP &&
> +	    key->basic.ip_proto != IPPROTO_AH) {
> +		NL_SET_ERR_MSG(extack,
> +			       "Protocol must be either ESP or AH");
> +		return -EINVAL;
> +	}
> +
> +	fl_set_key_val(tb, &key->ipsec.spi,
> +		       TCA_FLOWER_KEY_SPI,
> +		       &mask->ipsec.spi, TCA_FLOWER_KEY_SPI_MASK,
> +		       sizeof(key->ipsec.spi));
> +	return 0;
> +}
> +
>  static int fl_set_key_port_range(struct nlattr **tb, struct fl_flow_key *key,
>  				 struct fl_flow_key *mask,
>  				 struct netlink_ext_ack *extack)
> @@ -1894,6 +1915,12 @@ static int fl_set_key(struct net *net, struct nlattr **tb,
>  			return ret;
>  	}
>  
> +	if (tb[TCA_FLOWER_KEY_SPI]) {
> +		ret = fl_set_key_spi(tb, key, mask, extack);
> +		if (ret)
> +			return ret;
> +	}
> +
>  	if (tb[TCA_FLOWER_KEY_ENC_IPV4_SRC] ||
>  	    tb[TCA_FLOWER_KEY_ENC_IPV4_DST]) {
>  		key->enc_control.addr_type = FLOW_DISSECTOR_KEY_IPV4_ADDRS;
> @@ -2066,6 +2093,8 @@ static void fl_init_dissector(struct flow_dissector *dissector,
>  			     FLOW_DISSECTOR_KEY_PPPOE, pppoe);
>  	FL_KEY_SET_IF_MASKED(mask, keys, cnt,
>  			     FLOW_DISSECTOR_KEY_L2TPV3, l2tpv3);
> +	FL_KEY_SET_IF_MASKED(mask, keys, cnt,
> +			     FLOW_DISSECTOR_KEY_IPSEC, ipsec);
>  	FL_KEY_SET_IF_MASKED(mask, keys, cnt,
>  			     FLOW_DISSECTOR_KEY_CFM, cfm);
>  
> @@ -3364,6 +3393,12 @@ static int fl_dump_key(struct sk_buff *skb, struct net *net,
>  				 sizeof(key->l2tpv3.session_id)))
>  		goto nla_put_failure;
>  
> +	if (key->ipsec.spi &&
> +	    fl_dump_key_val(skb, &key->ipsec.spi, TCA_FLOWER_KEY_SPI,
> +			    &mask->ipsec.spi, TCA_FLOWER_KEY_SPI_MASK,
> +			    sizeof(key->ipsec.spi)))
> +		goto nla_put_failure;
> +
>  	if ((key->basic.ip_proto == IPPROTO_TCP ||
>  	     key->basic.ip_proto == IPPROTO_UDP ||
>  	     key->basic.ip_proto == IPPROTO_SCTP) &&
> -- 
> 2.25.1
> 
> 

