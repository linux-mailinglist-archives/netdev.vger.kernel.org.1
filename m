Return-Path: <netdev+bounces-52145-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 308157FD8CE
	for <lists+netdev@lfdr.de>; Wed, 29 Nov 2023 14:59:44 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 53BF91C2098F
	for <lists+netdev@lfdr.de>; Wed, 29 Nov 2023 13:59:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A06ED22EF2;
	Wed, 29 Nov 2023 13:59:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=resnulli-us.20230601.gappssmtp.com header.i=@resnulli-us.20230601.gappssmtp.com header.b="qm/3ibsE"
X-Original-To: netdev@vger.kernel.org
Received: from mail-wm1-x330.google.com (mail-wm1-x330.google.com [IPv6:2a00:1450:4864:20::330])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1081ED6C
	for <netdev@vger.kernel.org>; Wed, 29 Nov 2023 05:59:35 -0800 (PST)
Received: by mail-wm1-x330.google.com with SMTP id 5b1f17b1804b1-40b5155e154so8196355e9.3
        for <netdev@vger.kernel.org>; Wed, 29 Nov 2023 05:59:34 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=resnulli-us.20230601.gappssmtp.com; s=20230601; t=1701266373; x=1701871173; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=BW4sTGkrb7ypYmbAUJc2IZbw8B6RApVmGJujvJBkk1U=;
        b=qm/3ibsE8t179eUb+sKFOQt5MSrgXUBHvypbK08DVpq402fxZPnzBRt1rmyyU0Kw7x
         Bgg6ae0WxS7bzx4Y9JgSIR/pglszvgZAPbf4zRqw4BXthX8omGHrP/xvrB+K3C2Cavj7
         lYCBTlLRCNFWgNV+yFDEakC9AHr+tSQ1hLU9oqtpllKhFlrDfcLPMibpwBxUou9VyVpV
         Ln521hY1eGZKnWZTE9iCpxPICI7V2ifwb6rbtgG4Hs0cCVneJB7xJ92XNfbpTG8T/O0U
         qN3K2cdz1vS1ZA9lEHf6zc72D+qhUf1LwLU+ec6lDA0frgyMDK9IFdlNpePJ+zp25nsq
         JHKg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1701266373; x=1701871173;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=BW4sTGkrb7ypYmbAUJc2IZbw8B6RApVmGJujvJBkk1U=;
        b=eWIaYKCYf0fywirdatDqSl8ZNdWSk/xvXEqR25wfbmUsrVqESGEBBH+XKzJuaoO1z1
         yfFCaHOtCoO8SZyNwb/oEm5Q3/dJKnPv7r6v+lUXF+H7cy8CAc9ZnO1XHt6L62N+tD9J
         X7C+c5Z4sPH03vcCVM9pGe5xiNhUGcEOL4r1ibxV9aIQE0ZAMl0vGO4TgFMztT5NQiWX
         SoNV95N4n0mdII3E1I2/1wMrPQ+oLSNEUh5dPXSpcYDuT+vto5PQsplyu+346XUWBzNe
         OkdCEFdu8zqO3HaNd028cdNEU36/RQnRXcCPJbm2xHRx56u6GfLsfyG4srWoPQcruWoC
         rMjw==
X-Gm-Message-State: AOJu0YwzTCkwXRlDKevcNVnhHiAilJXUhamBeXgsklrpxKgKNm6S2trq
	X7c8FqGzvWYHwAOe0bCnfA3uSw==
X-Google-Smtp-Source: AGHT+IG7osNPFcDX0askTHqRn7l95saulIrtbGpXdXQCoKHDVibUpwRMaFyiBRZIqLZ2QGz7SPNHyw==
X-Received: by 2002:a5d:6a42:0:b0:32f:8a7f:f00f with SMTP id t2-20020a5d6a42000000b0032f8a7ff00fmr13617732wrw.60.1701266373370;
        Wed, 29 Nov 2023 05:59:33 -0800 (PST)
Received: from localhost (host-213-179-129-39.customer.m-online.net. [213.179.129.39])
        by smtp.gmail.com with ESMTPSA id i1-20020a05600c354100b0040588d85b3asm2343800wmq.15.2023.11.29.05.59.32
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 29 Nov 2023 05:59:32 -0800 (PST)
Date: Wed, 29 Nov 2023 14:59:31 +0100
From: Jiri Pirko <jiri@resnulli.us>
To: Jakub Kicinski <kuba@kernel.org>
Cc: netdev@vger.kernel.org, pabeni@redhat.com, davem@davemloft.net,
	edumazet@google.com, jacob.e.keller@intel.com, jhs@mojatatu.com,
	johannes@sipsolutions.net, andriy.shevchenko@linux.intel.com,
	amritha.nambiar@intel.com, sdf@google.com, horms@kernel.org
Subject: Re: [patch net-next v4 5/9] genetlink: introduce per-sock family
 private pointer storage
Message-ID: <ZWdDw2EJJbv6ecJ5@nanopsycho>
References: <20231123181546.521488-1-jiri@resnulli.us>
 <20231123181546.521488-6-jiri@resnulli.us>
 <20231127144626.0abb7260@kernel.org>
 <ZWWj8VZF5Puww2gm@nanopsycho>
 <20231128071116.1b6aed13@kernel.org>
 <ZWYP3H0wtaWxwneR@nanopsycho>
 <20231128083605.0c8868cd@kernel.org>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20231128083605.0c8868cd@kernel.org>

Tue, Nov 28, 2023 at 05:36:05PM CET, kuba@kernel.org wrote:
>On Tue, 28 Nov 2023 17:05:48 +0100 Jiri Pirko wrote:
>> >Not necessarily, you can have a helper which doesn't allocate, too.
>> >What I'm saying is that the common case for ops will be to access
>> >the state and allocate if it doesn't exist.
>> >
>> >How about genl_sk_family_priv() and genl_sk_has_family_priv() ?  
>> 
>> My point is, with what you suggest, it will look something like this:
>> 
>> 1) user does DEVLINK_CMD_NOTIFY_FILTER_SET
>> 2) devlink calls into genetlink code for a sk_priv and inserts in xa_array
>> 3) genetlink allocates sk_priv and returns back
>> 4) devlink fills-up the sk_priv
>> 
>> 5) user does DEVLINK_CMD_NOTIFY_FILTER_SET, again
>> 6) devlink calls into genetlink code for a sk_priv
>> 7) genetlink returns already exising sk_priv found in xa_array
>> 8) devlink fills-up the sk_priv
>> 
>> Now the notification thread, sees sk_priv zeroed between 3) and 4)
>> and inconsistent during 4) and 8)
>> 
>> I originally solved that by rcu, DEVLINK_CMD_NOTIFY_FILTER_SET
>> code always allocates and flips the rcu pointer. Notification thread
>> always sees sk_priv consistent.
>> 
>> If you want to allocate sk_priv in genetlink code once, hard to use
>> the rcu mechanism and have to protect the sk_priv memory by a lock.
>
>No, you can do exact same thing, just instead of putting the string
>directly into the xarray you put a struct which points to the string.

I'm lost. What "string" are you talking about exactly? I'm not putting
any string to xarray.

In the existing implementation, I have following struct:
struct devlink_obj_desc {
        struct rcu_head rcu;
        const char *bus_name;
        const char *dev_name;
        unsigned int port_index;
        bool port_index_valid;
        long data[];
};

This is the struct put pointer to into the xarray. Pointer to this
struct is dereferenced under rcu in notification code and the struct
is freed by kfree_rcu().


>
>> What am I missing?
>
>The fact that someone in the future may want to add another devlink
>priv field, and if the state is basically a pointer to a string,

"the state is basically a pointer to a string". I don't follow what you
mean by this :/


>with complicated lifetime, they will have to suffer undoing that.
>
>> >> If it is alloceted automatically, why is it needed?  
>> >
>> >Because priv may be a complex type which has member that need
>> >individual fields to be destroyed (in fullness of time we also
>> >need a constructor which can init things like list_head, but
>> >we can defer that).
>> >
>> >I'm guessing in your case the priv will look like this:
>> >
>> >struct devlink_sk_priv {
>> >	const char *nft_fltr_instance_name;
>> >};
>> >
>> >static void devlink_sk_priv_free(void *ptr)
>> >{
>> >	struct devlink_sk_priv *priv = ptr;
>> >
>> >	kfree(priv->nft_fltr_instance_name);
>> >}  
>> 
>> If genetlink code does the allocation, it should know how to free.
>> Does not make sense to pass destructor to genetlink code to free memory
>> it actually allocated :/
>> 
>> If devlink does the allocation, this callback makes sense. I was
>> thinking about having it, but decided kfree is okay for now and
>> destructor could be always introduced if needed.
>
>Did you read the code snippet above?

Sure.


>
>Core still does the kfree of the container (struct devlink_sk_priv).
>But what's inside the container struct (string pointer) has to be
>handled by the destructor.
>
>Feels like you focus on how to prove me wrong more than on
>understanding what I'm saying :|

Not at all, I have no reason for it. I just want to get my job done
and I am having very hard time to understand what you want exactly.


