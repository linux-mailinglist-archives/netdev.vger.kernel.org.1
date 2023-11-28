Return-Path: <netdev+bounces-51718-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 5D7177FBDAC
	for <lists+netdev@lfdr.de>; Tue, 28 Nov 2023 16:05:45 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 8A63D1C21015
	for <lists+netdev@lfdr.de>; Tue, 28 Nov 2023 15:05:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2E44D5C91F;
	Tue, 28 Nov 2023 15:05:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=resnulli-us.20230601.gappssmtp.com header.i=@resnulli-us.20230601.gappssmtp.com header.b="bQfSFi8w"
X-Original-To: netdev@vger.kernel.org
Received: from mail-ed1-x52f.google.com (mail-ed1-x52f.google.com [IPv6:2a00:1450:4864:20::52f])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D0637D45
	for <netdev@vger.kernel.org>; Tue, 28 Nov 2023 07:05:37 -0800 (PST)
Received: by mail-ed1-x52f.google.com with SMTP id 4fb4d7f45d1cf-54bb9024378so700709a12.3
        for <netdev@vger.kernel.org>; Tue, 28 Nov 2023 07:05:37 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=resnulli-us.20230601.gappssmtp.com; s=20230601; t=1701183936; x=1701788736; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=a+AzkhaO0AIT9apym6Dc0RO5qAb5Etv5jZXWI4AnBSo=;
        b=bQfSFi8wH0xBzvFHeq21cBqlwTbEMYnU2ueK+rRigmHBrKCW8UZDK2F7X9tvyGK7BU
         L9IHisxOFc+lYN+X6o0Sk7AfP+yNhWRAkhJq84QWwtTIT3FqCrGSwipsgYorc6WUrwWp
         6ZlBXKSmL3LtgFYPrH5eF4SNH1iFrcIueRSWMypzO2GhQnMO6YORACInV2ZSSDQO/rFa
         t974yxYDtnRxyYKpiz2lpB/Gpcj980ItYLUqWj5CAVVDxIouKXAf4KAWggQ+E3842ofS
         fnWlq+2tC7W/7zcsmLYU0790PVcIAZK8CyfuYOpOCEoz1uDfFV2Y+k+7DdM5ewW7nBp6
         bf/g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1701183936; x=1701788736;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=a+AzkhaO0AIT9apym6Dc0RO5qAb5Etv5jZXWI4AnBSo=;
        b=Hu8RERqwjsI0M+7/EG10P68AylOzKXg+7u8y7fqgOPH0hd+HOlebKbW0+tbPusrPz9
         lX7ornHFk7TUnYokjrlup9Y3lbIn7sn+FgkTWlDPyAfQC7NWv2cnQWEkD9XjBm9f2eqE
         R9dyKfXJ5d7enlqyCtOLaaJ2/cAU+qby7Jp1b9bNq8LPbyYSMl8BH0KAAe9kaO03VMYa
         BCWPjm0C+1D4P+KzQSE3HCmHFp2ncYzhRRKFSuJ2XK15ftT6GRiKw7eyFIzIWTo77Lbo
         mgCVifFIopM9sbFJ/Os+XyPDAM0gMNKaBO9yK3G2Va0+I5SZdQN4YD/sTK8uwmpFBzbv
         sPVg==
X-Gm-Message-State: AOJu0Yz99uDzYCHiRu5BZYWKsBvNMAAnTwBU7sUKpH21kYj0w3KX6wyX
	y7gObmn7wRRx0/1IJRu+GBqTbA==
X-Google-Smtp-Source: AGHT+IE3b9Azq0Sw1XpULNZ5aQbwDDGpNrGAMN/M+i4yCxziM4U0ZFv9ptG5rkOqvRAvyWcndQYUqg==
X-Received: by 2002:a17:906:1d5:b0:a0a:c652:9bf8 with SMTP id 21-20020a17090601d500b00a0ac6529bf8mr9256730ejj.45.1701183935712;
        Tue, 28 Nov 2023 07:05:35 -0800 (PST)
Received: from localhost (host-213-179-129-39.customer.m-online.net. [213.179.129.39])
        by smtp.gmail.com with ESMTPSA id o8-20020a17090637c800b009fdb3ec3c57sm6882591ejc.160.2023.11.28.07.05.34
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 28 Nov 2023 07:05:35 -0800 (PST)
Date: Tue, 28 Nov 2023 16:05:33 +0100
From: Jiri Pirko <jiri@resnulli.us>
To: Przemek Kitszel <przemyslaw.kitszel@intel.com>
Cc: kuba@kernel.org, pabeni@redhat.com, davem@davemloft.net,
	edumazet@google.com, jacob.e.keller@intel.com, jhs@mojatatu.com,
	johannes@sipsolutions.net, andriy.shevchenko@linux.intel.com,
	amritha.nambiar@intel.com, sdf@google.com, horms@kernel.org,
	netdev@vger.kernel.org
Subject: Re: [patch net-next v4 5/9] genetlink: introduce per-sock family
 private pointer storage
Message-ID: <ZWYBvX/4z1hhdGUM@nanopsycho>
References: <20231123181546.521488-1-jiri@resnulli.us>
 <20231123181546.521488-6-jiri@resnulli.us>
 <3b586f05-a136-fae2-fd8d-410e61fc8211@intel.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <3b586f05-a136-fae2-fd8d-410e61fc8211@intel.com>

Tue, Nov 28, 2023 at 01:30:51PM CET, przemyslaw.kitszel@intel.com wrote:
>On 11/23/23 19:15, Jiri Pirko wrote:
>> From: Jiri Pirko <jiri@nvidia.com>
>> 
>> Introduce a priv pointer into struct netlink_sock. Use it to store a per
>> socket xarray that contains family->id indexed priv pointer storage.
>> Note I used xarray instead of suggested linked list as it is more
>> convenient, without need to have a container struct that would
>> contain struct list_head item.
>> 
>> Introduce genl_sk_priv_store() to store the priv pointer.
>> Introduce genl_sk_priv_get() to obtain the priv pointer under RCU
>> read lock.
>> 
>> Assume that kfree() is good for free of privs for now, as the only user
>> introduced by the follow-up patch (devlink) will use kzalloc() for the
>> allocation of the memory of the stored pointer. If later on
>> this needs to be made custom, a callback is going to be needed.
>> Until then (if ever), do this in a simple way.
>> 
>> Signed-off-by: Jiri Pirko <jiri@nvidia.com>
>> ---
>> v3->v4:
>> - new patch
>> ---
>>   include/net/genetlink.h  |  3 ++
>>   net/netlink/af_netlink.h |  1 +
>>   net/netlink/genetlink.c  | 98 ++++++++++++++++++++++++++++++++++++++++
>>   3 files changed, 102 insertions(+)
>> 
>> diff --git a/include/net/genetlink.h b/include/net/genetlink.h
>> index e18a4c0d69ee..66c1e50415e0 100644
>> --- a/include/net/genetlink.h
>> +++ b/include/net/genetlink.h
>> @@ -300,6 +300,9 @@ int genl_register_family(struct genl_family *family);
>>   int genl_unregister_family(const struct genl_family *family);
>>   void genl_notify(const struct genl_family *family, struct sk_buff *skb,
>>   		 struct genl_info *info, u32 group, gfp_t flags);
>> +void *genl_sk_priv_get(struct sock *sk, struct genl_family *family);
>> +void *genl_sk_priv_store(struct sock *sk, struct genl_family *family,
>> +			 void *priv);
>>   void *genlmsg_put(struct sk_buff *skb, u32 portid, u32 seq,
>>   		  const struct genl_family *family, int flags, u8 cmd);
>> diff --git a/net/netlink/af_netlink.h b/net/netlink/af_netlink.h
>> index 2145979b9986..5d96135a4cf3 100644
>> --- a/net/netlink/af_netlink.h
>> +++ b/net/netlink/af_netlink.h
>> @@ -51,6 +51,7 @@ struct netlink_sock {
>>   	struct rhash_head	node;
>>   	struct rcu_head		rcu;
>>   	struct work_struct	work;
>> +	void __rcu		*priv;
>>   };
>>   static inline struct netlink_sock *nlk_sk(struct sock *sk)
>> diff --git a/net/netlink/genetlink.c b/net/netlink/genetlink.c
>> index 92ef5ed2e7b0..aae5e63fa50b 100644
>> --- a/net/netlink/genetlink.c
>> +++ b/net/netlink/genetlink.c
>> @@ -21,6 +21,7 @@
>>   #include <linux/idr.h>
>>   #include <net/sock.h>
>>   #include <net/genetlink.h>
>> +#include "af_netlink.h"
>>   static DEFINE_MUTEX(genl_mutex); /* serialization of message processing */
>>   static DECLARE_RWSEM(cb_lock);
>> @@ -1699,12 +1700,109 @@ static int genl_bind(struct net *net, int group)
>>   	return ret;
>>   }
>> +struct genl_sk_ctx {
>> +	struct xarray family_privs;
>> +};
>> +
>> +static struct genl_sk_ctx *genl_sk_ctx_alloc(void)
>> +{
>> +	struct genl_sk_ctx *ctx;
>> +
>> +	ctx = kzalloc(sizeof(*ctx), GFP_KERNEL);
>> +	if (!ctx)
>> +		return NULL;
>> +	xa_init_flags(&ctx->family_privs, XA_FLAGS_ALLOC);
>> +	return ctx;
>> +}
>> +
>> +static void genl_sk_ctx_free(struct genl_sk_ctx *ctx)
>> +{
>> +	unsigned long family_id;
>> +	void *priv;
>> +
>> +	xa_for_each(&ctx->family_privs, family_id, priv) {
>> +		xa_erase(&ctx->family_privs, family_id);
>> +		kfree(priv);
>> +	}
>> +	xa_destroy(&ctx->family_privs);
>> +	kfree(ctx);
>> +}
>> +
>> +/**
>> + * genl_sk_priv_get - Get per-socket private pointer for family
>> + *
>> + * @sk: socket
>> + * @family: family
>> + *
>> + * Lookup a private pointer stored per-socket by a specified
>> + * Generic netlink family.
>> + *
>> + * Caller should make sure this is called in RCU read locked section.
>> + *
>> + * Returns: valid pointer on success, otherwise NULL.
>
>since you are going to post next revision,
>
>kernel-doc requires "Return:" section (singular form)
>https://docs.kernel.org/doc-guide/kernel-doc.html#function-documentation
>
>for new code we should strive to fulfil the requirement
>(or piss-off someone powerful enough to change the requirement ;))

Okay, will fix. I just thought this is okay when scripts/kernel-doc is
happy.

>
>
>
>[snip]

