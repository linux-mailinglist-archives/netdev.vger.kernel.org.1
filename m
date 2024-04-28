Return-Path: <netdev+bounces-92007-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id E1D748B4C43
	for <lists+netdev@lfdr.de>; Sun, 28 Apr 2024 16:49:22 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 9875528196B
	for <lists+netdev@lfdr.de>; Sun, 28 Apr 2024 14:49:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 94CFF6A8C1;
	Sun, 28 Apr 2024 14:49:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b="aZSW12tT"
X-Original-To: netdev@vger.kernel.org
Received: from out30-131.freemail.mail.aliyun.com (out30-131.freemail.mail.aliyun.com [115.124.30.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7A5174A01;
	Sun, 28 Apr 2024 14:49:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=115.124.30.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714315760; cv=none; b=RFWYTtLHFFQ36pBUxBZtoP2++4ktWbNDIIHL5Db70dX6qfUlbg+Z9RB4Oebv8l/YfLLJ/hI3vdbzK1b36MjkKEKY64aR48sgoolLnhqs+Ukbguv1D4sXZJkfPn5VkVEquWC7r0JSSmcKUH6qm2E5juAwendTpYg8tFHTgV/FFBo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714315760; c=relaxed/simple;
	bh=Gx8Bl8oxMzhObPEzoyeEamN1Usii98lpjVn6IC4b+4M=;
	h=Message-ID:Date:MIME-Version:From:Subject:To:Cc:References:
	 In-Reply-To:Content-Type; b=qiB7PPuciasLeo6+Ywq0+fMG3jhzeeTkZnHHOkxXIi7bpTJg00owEw50lSIsyQztFEeZukbP+26fUKpvk/Gl1Wu1RfOwuNZSAAljRwOpZ7Q6LXHbifAAsUtNcy+f0r4t7A1yIeSpUtyTrA10ONl6JO54yC3p61hXnFulvswEbbA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com; spf=pass smtp.mailfrom=linux.alibaba.com; dkim=pass (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b=aZSW12tT; arc=none smtp.client-ip=115.124.30.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.alibaba.com
DKIM-Signature:v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=linux.alibaba.com; s=default;
	t=1714315753; h=Message-ID:Date:MIME-Version:From:Subject:To:Content-Type;
	bh=u02jNOLec3wS9eP4thytMYIQBn0MzOguZkCBipolzlE=;
	b=aZSW12tTSmPnOnnzN2cj7+mD67scYvLdWIcZ+Vl6/j79ThW8HtStRnfshEuKXo3cc8AbUblmSWJziv8JXFdanfZftRk/5Dh/h05vHxrMDj0kVC8BPpggU+YmtuS7Naa57jRgXT/yQEU/pQIV8jIQsR2ZMsezrZqRWUHFxZh2cs8=
X-Alimail-AntiSpam:AC=PASS;BC=-1|-1;BR=01201311R601e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=maildocker-contentspam033037067113;MF=hengqi@linux.alibaba.com;NM=1;PH=DS;RN=23;SR=0;TI=SMTPD_---0W5OQwN0_1714315749;
Received: from 30.32.88.124(mailfrom:hengqi@linux.alibaba.com fp:SMTPD_---0W5OQwN0_1714315749)
          by smtp.aliyun-inc.com;
          Sun, 28 Apr 2024 22:49:10 +0800
Message-ID: <98ea9d4d-1a90-45b9-a4e0-6941969295be@linux.alibaba.com>
Date: Sun, 28 Apr 2024 22:49:09 +0800
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
From: Heng Qi <hengqi@linux.alibaba.com>
Subject: Re: [PATCH net-next v10 2/4] ethtool: provide customized dim profile
 management
To: Jakub Kicinski <kuba@kernel.org>
Cc: netdev@vger.kernel.org, virtualization@lists.linux.dev,
 "David S . Miller" <davem@davemloft.net>, Paolo Abeni <pabeni@redhat.com>,
 Eric Dumazet <edumazet@google.com>, Jason Wang <jasowang@redhat.com>,
 "Michael S . Tsirkin" <mst@redhat.com>, Brett Creeley <bcreeley@amd.com>,
 Ratheesh Kannoth <rkannoth@marvell.com>,
 Alexander Lobakin <aleksander.lobakin@intel.com>,
 Xuan Zhuo <xuanzhuo@linux.alibaba.com>, Tal Gilboa <talgi@nvidia.com>,
 Jonathan Corbet <corbet@lwn.net>, linux-doc@vger.kernel.org,
 Maxime Chevallier <maxime.chevallier@bootlin.com>,
 Jiri Pirko <jiri@resnulli.us>, Paul Greenwalt <paul.greenwalt@intel.com>,
 Ahmed Zaki <ahmed.zaki@intel.com>, Vladimir Oltean
 <vladimir.oltean@nxp.com>, Kory Maincent <kory.maincent@bootlin.com>,
 Andrew Lunn <andrew@lunn.ch>,
 "justinstitt @ google . com" <justinstitt@google.com>
References: <20240425165948.111269-1-hengqi@linux.alibaba.com>
 <20240425165948.111269-3-hengqi@linux.alibaba.com>
 <20240426183333.257ccae5@kernel.org>
In-Reply-To: <20240426183333.257ccae5@kernel.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit


在 2024/4/27 上午9:33, Jakub Kicinski 写道:
> On Fri, 26 Apr 2024 00:59:46 +0800 Heng Qi wrote:
>> The NetDIM library, currently leveraged by an array of NICs, delivers
>> excellent acceleration benefits. Nevertheless, NICs vary significantly
>> in their dim profile list prerequisites.
>>
>> Specifically, virtio-net backends may present diverse sw or hw device
>> implementation, making a one-size-fits-all parameter list impractical.
>> On Alibaba Cloud, the virtio DPU's performance under the default DIM
>> profile falls short of expectations, partly due to a mismatch in
>> parameter configuration.
>>
>> I also noticed that ice/idpf/ena and other NICs have customized
>> profilelist or placed some restrictions on dim capabilities.
>>
>> Motivated by this, I tried adding new params for "ethtool -C" that provides
>> a per-device control to modify and access a device's interrupt parameters.
>>
>> Usage
>> ========
>> The target NIC is named ethx.
>>
>> Assume that ethx only declares support for rx profile setting
>> (with DIM_PROFILE_RX flag set in profile_flags) and supports modification
>> of usec and pkt fields.
>>
>> 1. Query the currently customized list of the device
>>
>> $ ethtool -c ethx
>> ...
>> rx-profile:
>> {.usec =   1, .pkts = 256, .comps = n/a,},
>> {.usec =   8, .pkts = 256, .comps = n/a,},
>> {.usec =  64, .pkts = 256, .comps = n/a,},
>> {.usec = 128, .pkts = 256, .comps = n/a,},
>> {.usec = 256, .pkts = 256, .comps = n/a,}
>> tx-profile:   n/a
>>
>> 2. Tune
>> $ ethtool -C ethx rx-profile 1,1,n_2,n,n_3,3,n_4,4,n_n,5,n
>> "n" means do not modify this field.
>> $ ethtool -c ethx
>> ...
>> rx-profile:
>> {.usec =   1, .pkts =   1, .comps = n/a,},
>> {.usec =   2, .pkts = 256, .comps = n/a,},
>> {.usec =   3, .pkts =   3, .comps = n/a,},
>> {.usec =   4, .pkts =   4, .comps = n/a,},
>> {.usec = 256, .pkts =   5, .comps = n/a,}
>> tx-profile:   n/a
>>
>> 3. Hint
>> If the device does not support some type of customized dim profiles,
>> the corresponding "n/a" will display.
>>
>> If the "n/a" field is being modified, -EOPNOTSUPP will be reported.
>>
>>
>> --- a/include/uapi/linux/ethtool_netlink.h
>> +++ b/include/uapi/linux/ethtool_netlink.h
>> @@ -416,12 +416,32 @@ enum {
>>   	ETHTOOL_A_COALESCE_TX_AGGR_MAX_BYTES,		/* u32 */
>>   	ETHTOOL_A_COALESCE_TX_AGGR_MAX_FRAMES,		/* u32 */
>>   	ETHTOOL_A_COALESCE_TX_AGGR_TIME_USECS,		/* u32 */
>> +	ETHTOOL_A_COALESCE_RX_PROFILE,			/* nest - _A_PROFILE_IRQ_MODERATION */
>> +	ETHTOOL_A_COALESCE_TX_PROFILE,			/* nest - _A_PROFILE_IRQ_MODERATION */
>>   
>>   	/* add new constants above here */
>>   	__ETHTOOL_A_COALESCE_CNT,
>>   	ETHTOOL_A_COALESCE_MAX = (__ETHTOOL_A_COALESCE_CNT - 1)
>>   };
>>   
>> +enum {
>> +	ETHTOOL_A_PROFILE_UNSPEC,
>> +	ETHTOOL_A_PROFILE_IRQ_MODERATION,		/* nest, _A_IRQ_MODERATION_* */
>> +
>> +	__ETHTOOL_A_PROFILE_CNT,
>> +	ETHTOOL_A_PROFILE_MAX = (__ETHTOOL_A_PROFILE_CNT - 1)
>>
>> +};
> I think this doesn't match what you described in the YAML spec.
> There is no "irq-moderation" layer there and no multi-attr: true...
> Does tools/net/ynl/cli.py work with the new attributes?

Yes, YAML requires an extra layer for tools/net/ynl/cli.py to work

properly. It has been fixed now.

> +void net_dim_free_irq_moder(struct net_device *dev)
> +{
> +	struct dim_cq_moder *rx_profile, *tx_profile;
> +
> +	if (!dev->irq_moder)
> +		return;
> +
> +	rcu_read_lock();
> +	rx_profile = rcu_dereference(dev->irq_moder->rx_profile);
> +	tx_profile = rcu_dereference(dev->irq_moder->tx_profile);
> +	rcu_read_unlock();
> rtnl_dereference() ? use of the pointers you got outside of the read
> critical section looks wrong

rtnl_lock is not held in the current context. The next version will hold rtnl_lock

in the driver, and the function is as follows:

struct dim_cq_moder {
         u16 usec;
         u16 pkts;
         u16 comps;
         u8 cq_period_mode;
+        struct rcu_head rcu;
+};


+/* RTNL lock is held. */
+void net_dim_free_irq_moder(struct net_device *dev)
+{
+       struct dim_cq_moder *rxp, *txp;
+
+       if (!dev->irq_moder)
+               return;
+
+       rxp = rtnl_dereference(dev->irq_moder->rx_profile);
+       txp = rtnl_dereference(dev->irq_moder->tx_profile);
+
+       rcu_assign_pointer(dev->irq_moder->rx_profile, NULL);
+       rcu_assign_pointer(dev->irq_moder->tx_profile, NULL);
+
+       kfree_rcu(rxp, rcu);
+       kfree_rcu(txp, rcu);
+       kfree(dev->irq_moder);
+}
+EXPORT_SYMBOL(net_dim_free_irq_moder);

>> +	rcu_assign_pointer(dev->irq_moder->tx_profile, NULL);
>> +	rcu_assign_pointer(dev->irq_moder->rx_profile, NULL);
>> +
>> +	synchronize_rcu();
> Better to use kfree_rcu(), synchronize_rcu() can be quite slow


Ok.


>> +	
>>   static bool coalesce_put_u32(struct sk_buff *skb, u16 attr_type, u32 val,
>> @@ -127,6 +137,75 @@ static bool coalesce_put_bool(struct sk_buff *skb, u16 attr_type, u32 val,
>>   	return nla_put_u8(skb, attr_type, !!val);
>>   }
>>   
>> +#if IS_ENABLED(CONFIG_DIMLIB)
> Can we decrease the use of IS_ENABLED() here, somehow?
> Do we need to protect anything else than accesses to dev->irq_moder ?
> Does coalesce_put_profile() need CONFIG_DIMLIB to build?


I will try to decrease this.


>   static int coalesce_fill_reply(struct sk_buff *skb,
>   			       const struct ethnl_req_info *req_base,
>   			       const struct ethnl_reply_data *reply_base)
> @@ -134,6 +213,12 @@ static int coalesce_fill_reply(struct sk_buff *skb,
>   	const struct coalesce_reply_data *data = COALESCE_REPDATA(reply_base);
>   	const struct kernel_ethtool_coalesce *kcoal = &data->kernel_coalesce;
>   	const struct ethtool_coalesce *coal = &data->coalesce;
> +#if IS_ENABLED(CONFIG_DIMLIB)
> +	struct net_device *dev = req_base->dev;
> +	struct dim_irq_moder *irq_moder = dev->irq_moder;
> +	u8 coal_flags;
> +	int ret;
> +#endif
>   	u32 supported = data->supported_params;
>   
>   	if (coalesce_put_u32(skb, ETHTOOL_A_COALESCE_RX_USECS,
> @@ -192,11 +277,51 @@ static int coalesce_fill_reply(struct sk_buff *skb,
>   			     kcoal->tx_aggr_time_usecs, supported))
>   		return -EMSGSIZE;
>   
> +#if IS_ENABLED(CONFIG_DIMLIB)
> +	if (!irq_moder)
> +		return 0;
> +
> +	coal_flags = irq_moder->coal_flags;
> +	rcu_read_lock();
> +	if (irq_moder->profile_flags & DIM_PROFILE_RX) {
> +		ret = coalesce_put_profile(skb, ETHTOOL_A_COALESCE_RX_PROFILE,
> +					   rcu_dereference(irq_moder->rx_profile),
> rtnl_deference can be used there, I assume updates are protected by
> rtnl_lock


The update-side does hold rtnl_lock. But here is the read-side,

so I think rcu_read_lock + rcu_dereference is enough.


>> +					   coal_flags);
>> +		if (ret) {
>> +			rcu_read_unlock();
>> +			return ret;
>> +		}
>> +	}
>> +
>> +	if (irq_moder->profile_flags & DIM_PROFILE_TX) {
>> +		ret = coalesce_put_profile(skb, ETHTOOL_A_COALESCE_TX_PROFILE,
>> +					   rcu_dereference(irq_moder->tx_profile),
>> +					   coal_flags);
>> +		if (ret) {
>> +			rcu_read_unlock();
>> +			return ret;
>> +		}
>> +	}
>> +	rcu_read_unlock();
>> +#endif
>>   	return 0;
>>   }
>>   
>>   /* COALESCE_SET */
>>   
>>   static int
>> @@ -234,6 +365,9 @@ ethnl_set_coalesce_validate(struct ethnl_req_info *req_info,
>>   			    struct genl_info *info)
>>   {
>>   	const struct ethtool_ops *ops = req_info->dev->ethtool_ops;
>> +#if IS_ENABLED(CONFIG_DIMLIB)
>> +	struct net_device *dev = req_info->dev;
>> +#endif
>>   	struct nlattr **tb = info->attrs;
>>   	u32 supported_params;
>>   	u16 a;
>> @@ -243,6 +377,15 @@ ethnl_set_coalesce_validate(struct ethnl_req_info *req_info,
>>   
>>   	/* make sure that only supported parameters are present */
>>   	supported_params = ops->supported_coalesce_params;
>> +#if IS_ENABLED(CONFIG_DIMLIB)
>> +	if (dev->irq_moder) {
> This may be NULL


Do you mean dev may be null or dev->irq_moder may be null?
The former has been excluded (see const struct ethtool_ops *ops

= req_info->dev->ethtool_ops;).

And we are ruling out the latter using 'if (dev->irq_moder)'.

Or something else?


>> +		if (dev->irq_moder->profile_flags & DIM_PROFILE_RX)
>> +			supported_params |= ETHTOOL_COALESCE_RX_PROFILE;
>> +
>> +		if (dev->irq_moder->profile_flags & DIM_PROFILE_TX)
>> +			supported_params |= ETHTOOL_COALESCE_TX_PROFILE;
>> +	}
>> +#endif
>>   	for (a = ETHTOOL_A_COALESCE_RX_USECS; a < __ETHTOOL_A_COALESCE_CNT; a++)
>>   		if (tb[a] && !(supported_params & attr_to_mask(a))) {
>>   			NL_SET_ERR_MSG_ATTR(info->extack, tb[a],
>> @@ -253,12 +396,104 @@ ethnl_set_coalesce_validate(struct ethnl_req_info *req_info,
>>   	return 1;
>>   }
>>   
>> +#if IS_ENABLED(CONFIG_DIMLIB)
>> +/**
>> + * ethnl_update_profile - get a profile nla nest with child nla nests from userspace.
>> + * @dev: netdevice to update the profile
>> + * @dst: profile get from the driver and modified by ethnl_update_profile.
>> + * @nests: nest attr ETHTOOL_A_COALESCE_*X_PROFILE to set profile.
>> + * @extack: Netlink extended ack
>> + *
>> + * Layout of nests:
>> + *   Nested ETHTOOL_A_COALESCE_*X_PROFILE attr
>> + *     Nested ETHTOOL_A_PROFILE_IRQ_MODERATION attr
>> + *       ETHTOOL_A_IRQ_MODERATION_USEC attr
>> + *       ETHTOOL_A_IRQ_MODERATION_PKTS attr
>> + *       ETHTOOL_A_IRQ_MODERATION_COMPS attr
>> + *     ...
>> + *     Nested ETHTOOL_A_PROFILE_IRQ_MODERATION attr
>> + *       ETHTOOL_A_IRQ_MODERATION_USEC attr
>> + *       ETHTOOL_A_IRQ_MODERATION_PKTS attr
>> + *       ETHTOOL_A_IRQ_MODERATION_COMPS attr
>> + *
>> + * Return: 0 on success or a negative error code.
>> + */
>> +static int ethnl_update_profile(struct net_device *dev,
>> +				struct dim_cq_moder __rcu **dst,
>> +				const struct nlattr *nests,
>> +				struct netlink_ext_ack *extack)
>> +{
>> +	struct nlattr *moder[ARRAY_SIZE(coalesce_irq_moderation_policy)];
>> +	struct dim_irq_moder *irq_moder = dev->irq_moder;
>> +	struct dim_cq_moder *new_profile, *old_profile;
>> +	int ret, rem, i = 0, len;
>> +	struct nlattr *nest;
>> +
>> +	if (!nests)
>> +		return 0;
>> +
>> +	if (!*dst)
>> +		return -EINVAL;
>> +
>> +	old_profile = rtnl_dereference(*dst);
>> +	len = NET_DIM_PARAMS_NUM_PROFILES * sizeof(*old_profile);
>> +	new_profile = kmemdup(old_profile, len, GFP_KERNEL);
>> +	if (!new_profile)
>> +		return -ENOMEM;
>> +
>> +	nla_for_each_nested_type(nest, ETHTOOL_A_PROFILE_IRQ_MODERATION, nests, rem) {
>> +		ret = nla_parse_nested(moder,
>> +				       ARRAY_SIZE(coalesce_irq_moderation_policy) - 1,
>> +				       nest, coalesce_irq_moderation_policy,
>> +				       extack);
>> +		if (ret)
>> +			return ret;
>> +
>> +		if (!NL_REQ_ATTR_CHECK(extack, nest, moder, ETHTOOL_A_IRQ_MODERATION_USEC)) {
>> +			if (irq_moder->coal_flags & DIM_COALESCE_USEC)
> There are 3 options here, not 2:
>
> 	if (irq_moder->coal_flags & flag) {
> 		if (NL_REQ_ATTR_CHECK())
> 			val = nla_get_u32(...);
> 		else
> 			return -EINVAL;
> 	} else {
> 		if (moder[attr_type)) {
> 			BAD_ATTR()
> 			return -EOPNOTSUPP;
> 		}
> 	}

Maybe we missed something.

As shown in the commit log, the user is allowed to modify only
a certain fields in irq-moderation. It is assumed that the driver
supports modification of usec and pkts, but the user may only
modify usec and only fill in the usec attr.

Therefore, the kernel only gets usec attr here. Of course, the user
may have passed in 5 groups of "n, n, n", which means that nothing
is modified, and rx_profile and irq_moderation attrs are all empty.

Thanks!


> you probably want to factor this out to a helper..
>
>

