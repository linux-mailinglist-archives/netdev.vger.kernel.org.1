Return-Path: <netdev+bounces-51296-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id E43D87FA002
	for <lists+netdev@lfdr.de>; Mon, 27 Nov 2023 13:51:15 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 95D9A280F88
	for <lists+netdev@lfdr.de>; Mon, 27 Nov 2023 12:51:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 58706208A0;
	Mon, 27 Nov 2023 12:51:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=resnulli-us.20230601.gappssmtp.com header.i=@resnulli-us.20230601.gappssmtp.com header.b="wCvStXfd"
X-Original-To: netdev@vger.kernel.org
Received: from mail-ej1-x630.google.com (mail-ej1-x630.google.com [IPv6:2a00:1450:4864:20::630])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 53B11D7
	for <netdev@vger.kernel.org>; Mon, 27 Nov 2023 04:51:07 -0800 (PST)
Received: by mail-ej1-x630.google.com with SMTP id a640c23a62f3a-a0f49b31868so122884266b.3
        for <netdev@vger.kernel.org>; Mon, 27 Nov 2023 04:51:07 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=resnulli-us.20230601.gappssmtp.com; s=20230601; t=1701089466; x=1701694266; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=RJg7fWP6WJ1dp5xwkRNBYqJn/x7cr875w6U//eFscW8=;
        b=wCvStXfdvLuE31PgGKweR4R8V7okyVafPd3nB7d5eoIv9C2wd/XzeVFe8mM6botW1G
         htKKSvz1XS1g5tU9ZimpmPBQskJuajZlZO81o5WP6YSDfPfKKgcLbY2Eh1sTUbr/g6xY
         yN2zoTowxn4xmcu3Mv3qqhN7NPwPMlXqvCFOClat3pZ3XTLAhSEvrwJAG9uPWYhD/bi7
         tjtCZ+a3buDE93wNAWRLjpF5c+0Yl3FDqSqtX7pekQ46za/0soQaq0T7s2icIcXlhvwQ
         0OIJHEKIYgc164JWzIhfQtlLT9JDyrAcXCLF3B07JwcNyAmKINxB0GZIRkj54Sjp9At5
         P8+w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1701089466; x=1701694266;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=RJg7fWP6WJ1dp5xwkRNBYqJn/x7cr875w6U//eFscW8=;
        b=d3Q0V1U8eXtnfszFx5jRFseFuk9FOjhAJB53PXnuhg6I9OTwuGvf05EKNltEjD1M2q
         GsQ3AUxFvYHXyDH4k+F3YfkmF6IlDcypGVEpIyjNtUwguKvI884bb1VqsDfaO6jQF6NR
         sK6bMXUmh4fJs7EkauoeSqjpFs1tuPnJVMgF03zZqfr2/DmczP1T+pFz31mT4UUV0Amg
         tWYf8+HAFobDu5YTLzUvi8nNavv2gftIBFbL0F5OselbMogeS8idyk572LGDXxqfmSU3
         9jxirYDe4wVtjIdqaWg26sajBksjk1HU9dXdEyYFGp4zUYUrtx1oS4TcRZZwk7RQjO+m
         5ydA==
X-Gm-Message-State: AOJu0YyNRG5I8oYNK9B4paUfjTYjmajZGo7uK8fYj0c3ifXLOMBY36+v
	IX5xyYEcpy20GHX3T4VL41Y61A==
X-Google-Smtp-Source: AGHT+IGh27SrAwaF+fQOOyAnS7B6s8xTySnJIhLrmhpuv6oAwdsaux9fE/04QntwVXKB/22iVMaNyg==
X-Received: by 2002:a17:906:73c5:b0:a10:ef07:fa9e with SMTP id n5-20020a17090673c500b00a10ef07fa9emr932942ejl.6.1701089465681;
        Mon, 27 Nov 2023 04:51:05 -0800 (PST)
Received: from localhost (host-213-179-129-39.customer.m-online.net. [213.179.129.39])
        by smtp.gmail.com with ESMTPSA id h18-20020a1709063b5200b009fdd2c6d042sm5772257ejf.148.2023.11.27.04.51.04
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 27 Nov 2023 04:51:05 -0800 (PST)
Date: Mon, 27 Nov 2023 13:51:03 +0100
From: Jiri Pirko <jiri@resnulli.us>
To: Przemek Kitszel <przemyslaw.kitszel@intel.com>
Cc: netdev@vger.kernel.org, kuba@kernel.org, pabeni@redhat.com,
	davem@davemloft.net, edumazet@google.com, jacob.e.keller@intel.com,
	jhs@mojatatu.com, johannes@sipsolutions.net,
	andriy.shevchenko@linux.intel.com, amritha.nambiar@intel.com,
	sdf@google.com, horms@kernel.org
Subject: Re: [patch net-next v4 8/9] devlink: add a command to set
 notification filter and use it for multicasts
Message-ID: <ZWSQtw/w7HvK4wzx@nanopsycho>
References: <20231123181546.521488-1-jiri@resnulli.us>
 <20231123181546.521488-9-jiri@resnulli.us>
 <98ece061-f21d-bc21-815a-19f34584f268@intel.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <98ece061-f21d-bc21-815a-19f34584f268@intel.com>

Mon, Nov 27, 2023 at 01:30:04PM CET, przemyslaw.kitszel@intel.com wrote:
>On 11/23/23 19:15, Jiri Pirko wrote:
>> From: Jiri Pirko <jiri@nvidia.com>
>> 
>> Currently the user listening on a socket for devlink notifications
>> gets always all messages for all existing instances, even if he is
>> interested only in one of those. That may cause unnecessary overhead
>> on setups with thousands of instances present.
>> 
>> User is currently able to narrow down the devlink objects replies
>> to dump commands by specifying select attributes.
>> 
>> Allow similar approach for notifications. Introduce a new devlink
>> NOTIFY_FILTER_SET which the user passes the select attributes. Store
>> these per-socket and use them for filtering messages
>> during multicast send.
>> 
>> Signed-off-by: Jiri Pirko <jiri@nvidia.com>
>> ---
>> v3->v4:
>> - rebased on top of genl_sk_priv_*() introduction
>> ---
>>   Documentation/netlink/specs/devlink.yaml | 10 ++++
>>   include/uapi/linux/devlink.h             |  2 +
>>   net/devlink/devl_internal.h              | 34 ++++++++++-
>>   net/devlink/netlink.c                    | 73 ++++++++++++++++++++++++
>>   net/devlink/netlink_gen.c                | 15 ++++-
>>   net/devlink/netlink_gen.h                |  4 +-
>>   tools/net/ynl/generated/devlink-user.c   | 31 ++++++++++
>>   tools/net/ynl/generated/devlink-user.h   | 47 +++++++++++++++
>>   8 files changed, 212 insertions(+), 4 deletions(-)
>> 
>> diff --git a/Documentation/netlink/specs/devlink.yaml b/Documentation/netlink/specs/devlink.yaml
>> index 43067e1f63aa..6bad1d3454b7 100644
>> --- a/Documentation/netlink/specs/devlink.yaml
>> +++ b/Documentation/netlink/specs/devlink.yaml
>> @@ -2055,3 +2055,13 @@ operations:
>>               - bus-name
>>               - dev-name
>>               - selftests
>> +
>> +    -
>> +      name: notify-filter-set
>> +      doc: Set notification messages socket filter.
>> +      attribute-set: devlink
>> +      do:
>> +        request:
>> +          attributes:
>> +            - bus-name
>> +            - dev-name
>> diff --git a/include/uapi/linux/devlink.h b/include/uapi/linux/devlink.h
>> index b3c8383d342d..130cae0d3e20 100644
>> --- a/include/uapi/linux/devlink.h
>> +++ b/include/uapi/linux/devlink.h
>> @@ -139,6 +139,8 @@ enum devlink_command {
>>   	DEVLINK_CMD_SELFTESTS_GET,	/* can dump */
>>   	DEVLINK_CMD_SELFTESTS_RUN,
>> +	DEVLINK_CMD_NOTIFY_FILTER_SET,
>> +
>>   	/* add new commands above here */
>>   	__DEVLINK_CMD_MAX,
>>   	DEVLINK_CMD_MAX = __DEVLINK_CMD_MAX - 1
>> diff --git a/net/devlink/devl_internal.h b/net/devlink/devl_internal.h
>> index 84dc9628d3f2..82e0fb3bbebf 100644
>> --- a/net/devlink/devl_internal.h
>> +++ b/net/devlink/devl_internal.h
>> @@ -191,11 +191,41 @@ static inline bool devlink_nl_notify_need(struct devlink *devlink)
>>   				  DEVLINK_MCGRP_CONFIG);
>>   }
>> +struct devlink_obj_desc {
>> +	struct rcu_head rcu;
>> +	const char *bus_name;
>> +	const char *dev_name;
>> +	long data[];
>
>could you please remove that data pointer?,
>you are not using desc as flex pointer as of now

But I am. See devlink_nl_notify_filter_set_doit()


>
>> +};
>> +
>> +static inline void devlink_nl_obj_desc_init(struct devlink_obj_desc *desc,
>
>given next patch of the series with port index, you could rename this
>function to devlink_nl_obj_desc_names_set(), and move 0-init outside.

I don't see why. This init will be called all the time, even if in
future more attrs selection is going to be used.


>
>> +					    struct devlink *devlink)
>> +{
>> +	memset(desc, 0, sizeof(*desc));
>> +	desc->bus_name = devlink->dev->bus->name;
>> +	desc->dev_name = dev_name(devlink->dev);
>> +}
>> +
>> +int devlink_nl_notify_filter(struct sock *dsk, struct sk_buff *skb, void *data);
>> +
>> +static inline void devlink_nl_notify_send_desc(struct devlink *devlink,
>> +					       struct sk_buff *msg,
>> +					       struct devlink_obj_desc *desc)
>> +{
>> +	genlmsg_multicast_netns_filtered(&devlink_nl_family,
>> +					 devlink_net(devlink),
>> +					 msg, 0, DEVLINK_MCGRP_CONFIG,
>> +					 GFP_KERNEL,
>> +					 devlink_nl_notify_filter, desc);
>> +}
>> +
>>   static inline void devlink_nl_notify_send(struct devlink *devlink,
>>   					  struct sk_buff *msg)
>>   {
>> -	genlmsg_multicast_netns(&devlink_nl_family, devlink_net(devlink),
>> -				msg, 0, DEVLINK_MCGRP_CONFIG, GFP_KERNEL);
>> +	struct devlink_obj_desc desc;
>
>`= {};` would wipe out the need for memset().

True. If there is going to be a respin, I'll change this.


>
>> +
>> +	devlink_nl_obj_desc_init(&desc, devlink);
>> +	devlink_nl_notify_send_desc(devlink, msg, &desc);
>>   }
>>   /* Notify */
>
>[snip]

