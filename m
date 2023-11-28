Return-Path: <netdev+bounces-51566-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 09F647FB2F2
	for <lists+netdev@lfdr.de>; Tue, 28 Nov 2023 08:40:11 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 40C64B210B3
	for <lists+netdev@lfdr.de>; Tue, 28 Nov 2023 07:40:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C8D81134BA;
	Tue, 28 Nov 2023 07:40:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=resnulli-us.20230601.gappssmtp.com header.i=@resnulli-us.20230601.gappssmtp.com header.b="20iHIdnf"
X-Original-To: netdev@vger.kernel.org
Received: from mail-ej1-x62b.google.com (mail-ej1-x62b.google.com [IPv6:2a00:1450:4864:20::62b])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BC1A21A5
	for <netdev@vger.kernel.org>; Mon, 27 Nov 2023 23:40:01 -0800 (PST)
Received: by mail-ej1-x62b.google.com with SMTP id a640c23a62f3a-a0f49b31868so242508166b.3
        for <netdev@vger.kernel.org>; Mon, 27 Nov 2023 23:40:01 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=resnulli-us.20230601.gappssmtp.com; s=20230601; t=1701157200; x=1701762000; darn=vger.kernel.org;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:from:to
         :cc:subject:date:message-id:reply-to;
        bh=WNW+AP/iJy4h22iOJCWWwkvIsR7DDwCpuo9fTQyorQM=;
        b=20iHIdnfoswOBeNjPrHAiXXtjvBr6xst5vc7dADJiXhho6ToRnm6LVtAvZPHFA40nG
         0PFDvSgV5ZVdZUhEKVfdyECNcii7OEtUIyHZZFeD1M7jUfqalRea6JdXHNcvrVLPJdNk
         RGvhcqVbG55B6+Pk/GiXcaHZtiDRI2YaGn/p220PfjamBDhQ/2sp+PgANyYqgi4oF/O0
         +MWeVbX1A0HrMqQL+SsVWCS0+MYn+sc8IjuIeoHZG1G46dsIyNQWCVIPbiRid4Bhz7o3
         9V4AA7dU/LDPVo40dTJKjrAdJuMjabWQfbfIe0liFnY4AHyaoyjiug3k6KpvW3q9ao4Z
         SuIg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1701157200; x=1701762000;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=WNW+AP/iJy4h22iOJCWWwkvIsR7DDwCpuo9fTQyorQM=;
        b=acZ2WIzYTZ7++C4FwP4lxvFF0ttaq9q5L78VyoQA6Jqhf8igfjhSN/G6OKuFGbUwwO
         jxviaeXmeY8p3zGkRLGEYpD7MCPWui7HNzNGRKFbk2GUU/Lp4bzqtB922he2HTlFW/m4
         Qqp57NxI3sbudKVkT42W/akyK8koxTUBaJ0ydwnrMxERMdfeKINtnSipMp7UVtykpPzo
         kEp4x8UJ0hWnukEQnIH40pw+8fH+U/nrDyQQx3Hsi9pmcFu3Ue2t1hgLZLdVzX+S8edc
         0Du0SlOxBSBX+cTQcudDskcjjby/5OaPFman5VY8zpp95iuem9YjKsen8thQqPdGTxqx
         Q8cQ==
X-Gm-Message-State: AOJu0YwDFsSMGlZEhnC9gY+evmu7aXGYmB6hwI+9KkVr38oiOXZfxntZ
	k2W6luD6XYGIl0sS5NpS9w/OyYjJSLx1plKzxfCr4Q==
X-Google-Smtp-Source: AGHT+IGRzFPrXfU8G8uxvFGrijBNETxbqnuKExItSS62R+wlCk0ZVJk+rWw5fyx6OE9mQGncuGYbZQ==
X-Received: by 2002:a17:906:209c:b0:a0c:46b4:a705 with SMTP id 28-20020a170906209c00b00a0c46b4a705mr7800863ejq.56.1701157200150;
        Mon, 27 Nov 2023 23:40:00 -0800 (PST)
Received: from localhost (host-213-179-129-39.customer.m-online.net. [213.179.129.39])
        by smtp.gmail.com with ESMTPSA id hg5-20020a170906f34500b00a0a2cb33ee0sm4658627ejb.203.2023.11.27.23.39.59
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 27 Nov 2023 23:39:59 -0800 (PST)
Date: Tue, 28 Nov 2023 08:39:58 +0100
From: Jiri Pirko <jiri@resnulli.us>
To: Paolo Abeni <pabeni@redhat.com>
Cc: netdev@vger.kernel.org, kuba@kernel.org, davem@davemloft.net,
	edumazet@google.com, jacob.e.keller@intel.com, jhs@mojatatu.com,
	johannes@sipsolutions.net, andriy.shevchenko@linux.intel.com,
	amritha.nambiar@intel.com, sdf@google.com, horms@kernel.org
Subject: Re: [patch net-next v4 3/9] devlink: send notifications only if
 there are listeners
Message-ID: <ZWWZTrS3/f2K3fmQ@nanopsycho>
References: <20231123181546.521488-1-jiri@resnulli.us>
 <20231123181546.521488-4-jiri@resnulli.us>
 <91870cef611bf924ab36dab5d26abecb4b673b76.camel@redhat.com>
 <ZWSFw7cbv64UB4bk@nanopsycho>
 <0455b0ed46dbac54feb13a27b8fede80980b9426.camel@redhat.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <0455b0ed46dbac54feb13a27b8fede80980b9426.camel@redhat.com>

Mon, Nov 27, 2023 at 04:00:42PM CET, pabeni@redhat.com wrote:
>On Mon, 2023-11-27 at 13:04 +0100, Jiri Pirko wrote:
>> Mon, Nov 27, 2023 at 12:01:10PM CET, pabeni@redhat.com wrote:
>> > On Thu, 2023-11-23 at 19:15 +0100, Jiri Pirko wrote:
>> > > From: Jiri Pirko <jiri@nvidia.com>
>> > > 
>> > > Introduce devlink_nl_notify_need() helper and using it to check at the
>> > > beginning of notification functions to avoid overhead of composing
>> > > notification messages in case nobody listens.
>> > > 
>> > > Signed-off-by: Jiri Pirko <jiri@nvidia.com>
>> > > ---
>> > >  net/devlink/dev.c           | 5 ++++-
>> > >  net/devlink/devl_internal.h | 6 ++++++
>> > >  net/devlink/health.c        | 3 +++
>> > >  net/devlink/linecard.c      | 2 +-
>> > >  net/devlink/param.c         | 2 +-
>> > >  net/devlink/port.c          | 2 +-
>> > >  net/devlink/rate.c          | 2 +-
>> > >  net/devlink/region.c        | 2 +-
>> > >  net/devlink/trap.c          | 6 +++---
>> > >  9 files changed, 21 insertions(+), 9 deletions(-)
>> > > 
>> > > diff --git a/net/devlink/dev.c b/net/devlink/dev.c
>> > > index 7c7517e26862..46407689ef70 100644
>> > > --- a/net/devlink/dev.c
>> > > +++ b/net/devlink/dev.c
>> > > @@ -204,6 +204,9 @@ static void devlink_notify(struct devlink *devlink, enum devlink_command cmd)
>> > >  	WARN_ON(cmd != DEVLINK_CMD_NEW && cmd != DEVLINK_CMD_DEL);
>> > >  	WARN_ON(!devl_is_registered(devlink));
>> > 
>> > minor nit: possibly use ASSERT_DEVLINK_REGISTERED(devlink) above?
>> 
>> Sure, but unrelated to this patch.
>> 
>> 
>> > 
>> > >  
>> > > +	if (!devlink_nl_notify_need(devlink))
>> > > +		return;
>> > > +
>> > >  	msg = nlmsg_new(NLMSG_DEFAULT_SIZE, GFP_KERNEL);
>> > >  	if (!msg)
>> > >  		return;
>> > > @@ -985,7 +988,7 @@ static void __devlink_flash_update_notify(struct devlink *devlink,
>> > >  		cmd != DEVLINK_CMD_FLASH_UPDATE_END &&
>> > >  		cmd != DEVLINK_CMD_FLASH_UPDATE_STATUS);
>> > >  
>> > > -	if (!devl_is_registered(devlink))
>> > > +	if (!devl_is_registered(devlink) || !devlink_nl_notify_need(devlink))
>> > >  		return;
>> > >  
>> > >  	msg = nlmsg_new(NLMSG_DEFAULT_SIZE, GFP_KERNEL);
>> > > diff --git a/net/devlink/devl_internal.h b/net/devlink/devl_internal.h
>> > > index 59ae4761d10a..510990de094e 100644
>> > > --- a/net/devlink/devl_internal.h
>> > > +++ b/net/devlink/devl_internal.h
>> > > @@ -185,6 +185,12 @@ int devlink_nl_put_nested_handle(struct sk_buff *msg, struct net *net,
>> > >  				 struct devlink *devlink, int attrtype);
>> > >  int devlink_nl_msg_reply_and_new(struct sk_buff **msg, struct genl_info *info);
>> > >  
>> > > +static inline bool devlink_nl_notify_need(struct devlink *devlink)
>> > > +{
>> > > +	return genl_has_listeners(&devlink_nl_family, devlink_net(devlink),
>> > > +				  DEVLINK_MCGRP_CONFIG);
>> > > +}
>> > > +
>> > >  /* Notify */
>> > >  void devlink_notify_register(struct devlink *devlink);
>> > >  void devlink_notify_unregister(struct devlink *devlink);
>> > > diff --git a/net/devlink/health.c b/net/devlink/health.c
>> > > index 71ae121dc739..0795dcf22ca8 100644
>> > > --- a/net/devlink/health.c
>> > > +++ b/net/devlink/health.c
>> > > @@ -496,6 +496,9 @@ static void devlink_recover_notify(struct devlink_health_reporter *reporter,
>> > >  	WARN_ON(cmd != DEVLINK_CMD_HEALTH_REPORTER_RECOVER);
>> > >  	ASSERT_DEVLINK_REGISTERED(devlink);
>> > >  
>> > > +	if (!devlink_nl_notify_need(devlink))
>> > > +		return;
>> > > +
>> > >  	msg = nlmsg_new(NLMSG_DEFAULT_SIZE, GFP_KERNEL);
>> > >  	if (!msg)
>> > >  		return;
>> > > diff --git a/net/devlink/linecard.c b/net/devlink/linecard.c
>> > > index 9d080ac1734b..45b36975ee6f 100644
>> > > --- a/net/devlink/linecard.c
>> > > +++ b/net/devlink/linecard.c
>> > > @@ -136,7 +136,7 @@ static void devlink_linecard_notify(struct devlink_linecard *linecard,
>> > >  	WARN_ON(cmd != DEVLINK_CMD_LINECARD_NEW &&
>> > >  		cmd != DEVLINK_CMD_LINECARD_DEL);
>> > >  
>> > > -	if (!__devl_is_registered(devlink))
>> > > +	if (!__devl_is_registered(devlink) || !devlink_nl_notify_need(devlink))
>> > >  		return;
>> > >  
>> > >  	msg = nlmsg_new(NLMSG_DEFAULT_SIZE, GFP_KERNEL);
>> > > diff --git a/net/devlink/param.c b/net/devlink/param.c
>> > > index d74df09311a9..6bb6aee5d937 100644
>> > > --- a/net/devlink/param.c
>> > > +++ b/net/devlink/param.c
>> > > @@ -343,7 +343,7 @@ static void devlink_param_notify(struct devlink *devlink,
>> > >  	 * will replay the notifications if the params are added/removed
>> > >  	 * outside of the lifetime of the instance.
>> > >  	 */
>> > > -	if (!devl_is_registered(devlink))
>> > > +	if (!devlink_nl_notify_need(devlink) || !devl_is_registered(devlink))
>> > 
>> > Minor nit: this is the only statement using this order, perhaps swap
>> > the tests for consistency?
>> 
>> Right. If respin is needed, I'll swap.
>> 
>> 
>> > 
>> > Also possibly add the devlink_nl_notify_need() check in
>> > devl_is_registered to reduce code duplication? plus a
>> 
>> It would be odd to have devlink_nl_notify_need() called from
>> devl_is_registered(). 
>
>Sorry for the confusion, out-of-order on my side. What I really mean
>is: add __devl_is_registered() in devlink_nl_notify_need(). 
>
>> Also, it is non only used on notification paths.
>> I thought about putting the checks in one function, but those are 2
>> separate and unrelated checks, so better to keep them separate.
>
>It looks like devlink_nl_notify_need() implies/requires
>__devl_is_registered() ?
>

__devl_is_registered() and devl_is_registered(), depends on the case.
That's why I prefer to have the check outside devlink_nl_notify_need()


>Cheers,
>
>Paolo
>

