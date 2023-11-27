Return-Path: <netdev+bounces-51286-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 1D58D7F9F39
	for <lists+netdev@lfdr.de>; Mon, 27 Nov 2023 13:04:37 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 3F99FB20F74
	for <lists+netdev@lfdr.de>; Mon, 27 Nov 2023 12:04:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F304B1BDDC;
	Mon, 27 Nov 2023 12:04:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=resnulli-us.20230601.gappssmtp.com header.i=@resnulli-us.20230601.gappssmtp.com header.b="i4MyyV4X"
X-Original-To: netdev@vger.kernel.org
Received: from mail-lf1-x133.google.com (mail-lf1-x133.google.com [IPv6:2a00:1450:4864:20::133])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E234BE6
	for <netdev@vger.kernel.org>; Mon, 27 Nov 2023 04:04:22 -0800 (PST)
Received: by mail-lf1-x133.google.com with SMTP id 2adb3069b0e04-507adc3381cso5562077e87.3
        for <netdev@vger.kernel.org>; Mon, 27 Nov 2023 04:04:22 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=resnulli-us.20230601.gappssmtp.com; s=20230601; t=1701086661; x=1701691461; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=PoAWr/jRY4BDZF3G51MGzKb8hai+nY9Ti6PJE1vtk74=;
        b=i4MyyV4XiFwHvwBWFgN/SkG8XYyhbPzM1BrIEi2Vbowkojyp6eHMuhbRqnBMU2xxcz
         uUA2EBqyRjgyWc8V/E6Ak0aZT8mV3ui8pvIvyg+Y1j8wl9TchMJtN3bvgjGBonsxBJXp
         MFuVmvy+As91kGlUYZbXYnnAZk2VKJIP2YQTbT7EVacGegY8q2MgtqUClupBJGNF+pPX
         KSgAvWB1UIRWs6HyJUWGa52OZE2xRJhYKdnB6vkG+KDmrSOymftzu+p0yI4JnnzQafoO
         tYBMI/glTfSlkH2y39ZrU6xMCIe55dLupc0f55ld+iNvz9uvPi2+VZJDKih7TR9S7lW+
         uinQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1701086661; x=1701691461;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=PoAWr/jRY4BDZF3G51MGzKb8hai+nY9Ti6PJE1vtk74=;
        b=Q/9IAGnrxp6QnTPC2Hv2J52jtgE6WL5ZFGrTUxrmaEAMCHdXer5n7QbEfwHvKvFr2c
         mXFUWTsdzAtvDKvBBGdp9ogMmtn4VlwqQI1zhZtL+1GbbKRKzl1ZPG5KqKZaAue9jKbi
         XTS6pAtIfC3ieik9aeC4V4bH2bbLFrZz4h3x7spn/Rh/VRog0oI7Zm0ZxAuaBcNV3dt2
         WGQVe84B9ltqseH+ycrLxFdvMJE5ehx9YoAIuzTRLt7GWctJNYjXhfZWVASkdNN9VvzR
         o6cyy/sIDWMsL0W2NtF4j36pa9ko3mHuIzaekwE9VfOvxSV8FN1/Jy4H+CwXHDLB+JJe
         UAbw==
X-Gm-Message-State: AOJu0YwY45ZzOC+xBRWAE6pjhuolOmRKnye0KzHgx7guGvO5qa0l1rje
	LcICddIIqi9JXuBTSp45QKPN9A==
X-Google-Smtp-Source: AGHT+IFXqoWPAFFqu2iq1sowoJmwCLPX4t7TGCbVKuVL377xIJAbuSZEEbbRZKB/wA2A0RVIwwjAAg==
X-Received: by 2002:a19:5f5e:0:b0:503:2555:d1e7 with SMTP id a30-20020a195f5e000000b005032555d1e7mr6624296lfj.45.1701086661077;
        Mon, 27 Nov 2023 04:04:21 -0800 (PST)
Received: from localhost ([86.61.181.4])
        by smtp.gmail.com with ESMTPSA id g22-20020a056402115600b0054887e27dc8sm5088819edw.62.2023.11.27.04.04.20
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 27 Nov 2023 04:04:20 -0800 (PST)
Date: Mon, 27 Nov 2023 13:04:19 +0100
From: Jiri Pirko <jiri@resnulli.us>
To: Paolo Abeni <pabeni@redhat.com>
Cc: netdev@vger.kernel.org, kuba@kernel.org, davem@davemloft.net,
	edumazet@google.com, jacob.e.keller@intel.com, jhs@mojatatu.com,
	johannes@sipsolutions.net, andriy.shevchenko@linux.intel.com,
	amritha.nambiar@intel.com, sdf@google.com, horms@kernel.org
Subject: Re: [patch net-next v4 3/9] devlink: send notifications only if
 there are listeners
Message-ID: <ZWSFw7cbv64UB4bk@nanopsycho>
References: <20231123181546.521488-1-jiri@resnulli.us>
 <20231123181546.521488-4-jiri@resnulli.us>
 <91870cef611bf924ab36dab5d26abecb4b673b76.camel@redhat.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <91870cef611bf924ab36dab5d26abecb4b673b76.camel@redhat.com>

Mon, Nov 27, 2023 at 12:01:10PM CET, pabeni@redhat.com wrote:
>On Thu, 2023-11-23 at 19:15 +0100, Jiri Pirko wrote:
>> From: Jiri Pirko <jiri@nvidia.com>
>> 
>> Introduce devlink_nl_notify_need() helper and using it to check at the
>> beginning of notification functions to avoid overhead of composing
>> notification messages in case nobody listens.
>> 
>> Signed-off-by: Jiri Pirko <jiri@nvidia.com>
>> ---
>>  net/devlink/dev.c           | 5 ++++-
>>  net/devlink/devl_internal.h | 6 ++++++
>>  net/devlink/health.c        | 3 +++
>>  net/devlink/linecard.c      | 2 +-
>>  net/devlink/param.c         | 2 +-
>>  net/devlink/port.c          | 2 +-
>>  net/devlink/rate.c          | 2 +-
>>  net/devlink/region.c        | 2 +-
>>  net/devlink/trap.c          | 6 +++---
>>  9 files changed, 21 insertions(+), 9 deletions(-)
>> 
>> diff --git a/net/devlink/dev.c b/net/devlink/dev.c
>> index 7c7517e26862..46407689ef70 100644
>> --- a/net/devlink/dev.c
>> +++ b/net/devlink/dev.c
>> @@ -204,6 +204,9 @@ static void devlink_notify(struct devlink *devlink, enum devlink_command cmd)
>>  	WARN_ON(cmd != DEVLINK_CMD_NEW && cmd != DEVLINK_CMD_DEL);
>>  	WARN_ON(!devl_is_registered(devlink));
>
>minor nit: possibly use ASSERT_DEVLINK_REGISTERED(devlink) above?

Sure, but unrelated to this patch.


>
>>  
>> +	if (!devlink_nl_notify_need(devlink))
>> +		return;
>> +
>>  	msg = nlmsg_new(NLMSG_DEFAULT_SIZE, GFP_KERNEL);
>>  	if (!msg)
>>  		return;
>> @@ -985,7 +988,7 @@ static void __devlink_flash_update_notify(struct devlink *devlink,
>>  		cmd != DEVLINK_CMD_FLASH_UPDATE_END &&
>>  		cmd != DEVLINK_CMD_FLASH_UPDATE_STATUS);
>>  
>> -	if (!devl_is_registered(devlink))
>> +	if (!devl_is_registered(devlink) || !devlink_nl_notify_need(devlink))
>>  		return;
>>  
>>  	msg = nlmsg_new(NLMSG_DEFAULT_SIZE, GFP_KERNEL);
>> diff --git a/net/devlink/devl_internal.h b/net/devlink/devl_internal.h
>> index 59ae4761d10a..510990de094e 100644
>> --- a/net/devlink/devl_internal.h
>> +++ b/net/devlink/devl_internal.h
>> @@ -185,6 +185,12 @@ int devlink_nl_put_nested_handle(struct sk_buff *msg, struct net *net,
>>  				 struct devlink *devlink, int attrtype);
>>  int devlink_nl_msg_reply_and_new(struct sk_buff **msg, struct genl_info *info);
>>  
>> +static inline bool devlink_nl_notify_need(struct devlink *devlink)
>> +{
>> +	return genl_has_listeners(&devlink_nl_family, devlink_net(devlink),
>> +				  DEVLINK_MCGRP_CONFIG);
>> +}
>> +
>>  /* Notify */
>>  void devlink_notify_register(struct devlink *devlink);
>>  void devlink_notify_unregister(struct devlink *devlink);
>> diff --git a/net/devlink/health.c b/net/devlink/health.c
>> index 71ae121dc739..0795dcf22ca8 100644
>> --- a/net/devlink/health.c
>> +++ b/net/devlink/health.c
>> @@ -496,6 +496,9 @@ static void devlink_recover_notify(struct devlink_health_reporter *reporter,
>>  	WARN_ON(cmd != DEVLINK_CMD_HEALTH_REPORTER_RECOVER);
>>  	ASSERT_DEVLINK_REGISTERED(devlink);
>>  
>> +	if (!devlink_nl_notify_need(devlink))
>> +		return;
>> +
>>  	msg = nlmsg_new(NLMSG_DEFAULT_SIZE, GFP_KERNEL);
>>  	if (!msg)
>>  		return;
>> diff --git a/net/devlink/linecard.c b/net/devlink/linecard.c
>> index 9d080ac1734b..45b36975ee6f 100644
>> --- a/net/devlink/linecard.c
>> +++ b/net/devlink/linecard.c
>> @@ -136,7 +136,7 @@ static void devlink_linecard_notify(struct devlink_linecard *linecard,
>>  	WARN_ON(cmd != DEVLINK_CMD_LINECARD_NEW &&
>>  		cmd != DEVLINK_CMD_LINECARD_DEL);
>>  
>> -	if (!__devl_is_registered(devlink))
>> +	if (!__devl_is_registered(devlink) || !devlink_nl_notify_need(devlink))
>>  		return;
>>  
>>  	msg = nlmsg_new(NLMSG_DEFAULT_SIZE, GFP_KERNEL);
>> diff --git a/net/devlink/param.c b/net/devlink/param.c
>> index d74df09311a9..6bb6aee5d937 100644
>> --- a/net/devlink/param.c
>> +++ b/net/devlink/param.c
>> @@ -343,7 +343,7 @@ static void devlink_param_notify(struct devlink *devlink,
>>  	 * will replay the notifications if the params are added/removed
>>  	 * outside of the lifetime of the instance.
>>  	 */
>> -	if (!devl_is_registered(devlink))
>> +	if (!devlink_nl_notify_need(devlink) || !devl_is_registered(devlink))
>
>Minor nit: this is the only statement using this order, perhaps swap
>the tests for consistency?

Right. If respin is needed, I'll swap.


>
>Also possibly add the devlink_nl_notify_need() check in
>devl_is_registered to reduce code duplication? plus a

It would be odd to have devlink_nl_notify_need() called from
devl_is_registered(). Also, it is non only used on notification paths.
I thought about putting the checks in one function, but those are 2
separate and unrelated checks, so better to keep them separate.


>__devl_is_registered() variant for the 2 cases above not requiring the
>additional check.
>
>No need to repost for the above.
>
>Cheers,
>
>Paolo
>

