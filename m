Return-Path: <netdev+bounces-51757-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id AB5397FBEEE
	for <lists+netdev@lfdr.de>; Tue, 28 Nov 2023 17:05:59 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id DB5B91C20C85
	for <lists+netdev@lfdr.de>; Tue, 28 Nov 2023 16:05:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0690E1E4B3;
	Tue, 28 Nov 2023 16:05:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=resnulli-us.20230601.gappssmtp.com header.i=@resnulli-us.20230601.gappssmtp.com header.b="s++m+QFy"
X-Original-To: netdev@vger.kernel.org
Received: from mail-lj1-x231.google.com (mail-lj1-x231.google.com [IPv6:2a00:1450:4864:20::231])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E07C1131
	for <netdev@vger.kernel.org>; Tue, 28 Nov 2023 08:05:51 -0800 (PST)
Received: by mail-lj1-x231.google.com with SMTP id 38308e7fff4ca-2c9b5b72983so9135631fa.2
        for <netdev@vger.kernel.org>; Tue, 28 Nov 2023 08:05:51 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=resnulli-us.20230601.gappssmtp.com; s=20230601; t=1701187550; x=1701792350; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=2HUYIxnMcVzRul71v1shGU6Gtzw1nx93rYPH5W/phMk=;
        b=s++m+QFy1ZkDDBLmSCDKKr2lG5FvW/x0gndS6DncjSxqJqu3e0HeNQr35KqMaH/s2+
         wxVdmP8JpGP9jxOoeIMdsSjQswSf90p7w5j04XzC8jXJ+2OceoK2EsoVIsmCqsGSkL9l
         z3Z4Sk6xqtUpOdozblPlvM2XgdfzWRCUGwKB1pdNdsOsl4vBdx6l34sA6Kevcmran2gX
         8WaFOZhW6Op2HC5ysqeCwtHXIW/JioX+xiVWkx2NDgOl+KB2xppUU6EnMzswaeev90l9
         1fAddhFZHROaQHvTi2fz0FS/cn6/EoM50jCECtPM+hvUUC9OkRN11N7CLj17oidH5AFE
         Z/Ig==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1701187550; x=1701792350;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=2HUYIxnMcVzRul71v1shGU6Gtzw1nx93rYPH5W/phMk=;
        b=Qq30m3A3FTJBUvTd+P7eTgsws2YJ5ASAgDpDsQ2ShvavoIOkGOmPP/56Fx/gyC76nP
         +fAxOrrDb643GofAJTfOVO4gd392EiJZnuTEdN2UeKmip5YXult/7PzCtzfhGptUI28W
         nbGgkJD7bk17mMzdaBerRH7rvib7Sia7twDOqaI057KcdwNJ16P7qEKYP8QB/iaFCvS1
         o+aHHeLD2UnZd1pyv0QKCnSxKnkcgOx2cLNFpUVBj/RyGFu/caJQnuZuylstztyHCJq7
         XYpYIvVENpo2jSl6NB6Iu22LVvHwhJHLb1H4HAGFW/gdrelYsTE3WiTUjP7lFmrTceex
         zhag==
X-Gm-Message-State: AOJu0YwmZ7zBC7l34Qk51l0Blle2Kr5UwtDU3kJ0oJO48Yft0yzNKcRL
	h22BE00vzENFMb8ZjYMt+45HRQ==
X-Google-Smtp-Source: AGHT+IH0s1owdjySRd/0uVq4V4Ex5NcMbjyUL0hGe+Z9gcjgWodH5lkM9SQrHhWijeJlGyunWiTcyA==
X-Received: by 2002:a2e:7012:0:b0:2c9:bb1a:ab72 with SMTP id l18-20020a2e7012000000b002c9bb1aab72mr140974ljc.31.1701187549955;
        Tue, 28 Nov 2023 08:05:49 -0800 (PST)
Received: from localhost (host-213-179-129-39.customer.m-online.net. [213.179.129.39])
        by smtp.gmail.com with ESMTPSA id k26-20020a7bc41a000000b00405718cbeadsm6486wmi.1.2023.11.28.08.05.49
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 28 Nov 2023 08:05:49 -0800 (PST)
Date: Tue, 28 Nov 2023 17:05:48 +0100
From: Jiri Pirko <jiri@resnulli.us>
To: Jakub Kicinski <kuba@kernel.org>
Cc: netdev@vger.kernel.org, pabeni@redhat.com, davem@davemloft.net,
	edumazet@google.com, jacob.e.keller@intel.com, jhs@mojatatu.com,
	johannes@sipsolutions.net, andriy.shevchenko@linux.intel.com,
	amritha.nambiar@intel.com, sdf@google.com, horms@kernel.org
Subject: Re: [patch net-next v4 5/9] genetlink: introduce per-sock family
 private pointer storage
Message-ID: <ZWYP3H0wtaWxwneR@nanopsycho>
References: <20231123181546.521488-1-jiri@resnulli.us>
 <20231123181546.521488-6-jiri@resnulli.us>
 <20231127144626.0abb7260@kernel.org>
 <ZWWj8VZF5Puww2gm@nanopsycho>
 <20231128071116.1b6aed13@kernel.org>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20231128071116.1b6aed13@kernel.org>

Tue, Nov 28, 2023 at 04:11:16PM CET, kuba@kernel.org wrote:
>On Tue, 28 Nov 2023 09:25:21 +0100 Jiri Pirko wrote:
>> >Put the xarray pointer here directly. Plus a lock to protect the init.  
>> 
>> Okay, just to make this clear. You want me to have:
>> 	struct xarray __rcu		*family_privs;
>> 
>> in struct netlink_sock, correct?
>> 
>> 
>> Why I need a lock? If I read things correctly, skbs are processed in
>> serial over one sock. Since this is per-sock, should be safe.
>
>Okay, then add an assertion that the socket lock is held, at least.

No socket lock, but I assumed revcmsg could be called only in parallel.
But I guess that with multiple threads, this assumption is broken.
Okay, will add a spin lock.


>Also, is the socket lock not held yet when the filtering happens?

Nope.


>Maybe the __rcu annotation isn't necessary then either?
>
>> >The size of the per-family struct should be in family definition,
>> >allocation should happen on first get automatically. Family definition  
>> 
>> Yes, I thought about that. But I decided to do this lockless, allocating
>> new priv every time the user sets the filter and replace the xarray item
>> so it could be accessed in rcu read section during notification
>> processing.
>> 
>> What you suggest requires some lock to protect the memory being changed
>> during filter set and suring accessing in in notify. But okay,
>> if you insist.
>
>Not necessarily, you can have a helper which doesn't allocate, too.
>What I'm saying is that the common case for ops will be to access
>the state and allocate if it doesn't exist.
>
>How about genl_sk_family_priv() and genl_sk_has_family_priv() ?

My point is, with what you suggest, it will look something like this:

1) user does DEVLINK_CMD_NOTIFY_FILTER_SET
2) devlink calls into genetlink code for a sk_priv and inserts in xa_array
3) genetlink allocates sk_priv and returns back
4) devlink fills-up the sk_priv

5) user does DEVLINK_CMD_NOTIFY_FILTER_SET, again
6) devlink calls into genetlink code for a sk_priv
7) genetlink returns already exising sk_priv found in xa_array
8) devlink fills-up the sk_priv

Now the notification thread, sees sk_priv zeroed between 3) and 4)
and inconsistent during 4) and 8)

I originally solved that by rcu, DEVLINK_CMD_NOTIFY_FILTER_SET
code always allocates and flips the rcu pointer. Notification thread
always sees sk_priv consistent.

If you want to allocate sk_priv in genetlink code once, hard to use
the rcu mechanism and have to protect the sk_priv memory by a lock.

What am I missing?


>
>> >should also hold a callback to how the data is going to be freed.  
>> 
>> If it is alloceted automatically, why is it needed?
>
>Because priv may be a complex type which has member that need
>individual fields to be destroyed (in fullness of time we also
>need a constructor which can init things like list_head, but
>we can defer that).
>
>I'm guessing in your case the priv will look like this:
>
>struct devlink_sk_priv {
>	const char *nft_fltr_instance_name;
>};
>
>static void devlink_sk_priv_free(void *ptr)
>{
>	struct devlink_sk_priv *priv = ptr;
>
>	kfree(priv->nft_fltr_instance_name);
>}

If genetlink code does the allocation, it should know how to free.
Does not make sense to pass destructor to genetlink code to free memory
it actually allocated :/

If devlink does the allocation, this callback makes sense. I was
thinking about having it, but decided kfree is okay for now and
destructor could be always introduced if needed.

Quoting the patch description:
    Assume that kfree() is good for free of privs for now, as the only user
    introduced by the follow-up patch (devlink) will use kzalloc() for the
    allocation of the memory of the stored pointer. If later on
    this needs to be made custom, a callback is going to be needed.
    Until then (if ever), do this in a simple way.



