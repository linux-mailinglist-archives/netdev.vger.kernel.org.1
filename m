Return-Path: <netdev+bounces-118372-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 2947D9516B3
	for <lists+netdev@lfdr.de>; Wed, 14 Aug 2024 10:37:29 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id ABC591F24274
	for <lists+netdev@lfdr.de>; Wed, 14 Aug 2024 08:37:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7A58713D8AC;
	Wed, 14 Aug 2024 08:37:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=resnulli-us.20230601.gappssmtp.com header.i=@resnulli-us.20230601.gappssmtp.com header.b="aNxrhwFf"
X-Original-To: netdev@vger.kernel.org
Received: from mail-ed1-f49.google.com (mail-ed1-f49.google.com [209.85.208.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B91244D8B6
	for <netdev@vger.kernel.org>; Wed, 14 Aug 2024 08:37:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723624644; cv=none; b=FKqqQ9MiBa7JeEcatOyqHQ90UU61VIR/rkMwQICsYjjfFVnooVBjo9ZFPHhAh0PfMPKA9VGdYYX6HEx+DgFGorojxlCDEDc5uFvSU0yv41LOVQDN/qMF0XpCt91PauY4JQYeSJiB7sh+9zHfkLe9tn+ZXSBnYR9kbWSqxJ6HtZI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723624644; c=relaxed/simple;
	bh=7hHP3/JAuegSxC8y/3vWytROoBj+oftsSNsmXnaaHbc=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=VdI2zQFflLBDICQwM3W3c1h/qqqFKnHeocO+OLrgkn8huR/C+UtAJ+1Y6j/0nx59g3tFoBldPaDHoKQ3SmKmSYrpHsT32YcF7EQxyD27mlCR48FTiVBkpbw0GGUDjzOTB6fO+vKCRafJa0oJYNLX8LvvpEAKtpd7F5kKHHSudp8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=resnulli.us; spf=none smtp.mailfrom=resnulli.us; dkim=pass (2048-bit key) header.d=resnulli-us.20230601.gappssmtp.com header.i=@resnulli-us.20230601.gappssmtp.com header.b=aNxrhwFf; arc=none smtp.client-ip=209.85.208.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=resnulli.us
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=resnulli.us
Received: by mail-ed1-f49.google.com with SMTP id 4fb4d7f45d1cf-5a10835487fso8493321a12.1
        for <netdev@vger.kernel.org>; Wed, 14 Aug 2024 01:37:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=resnulli-us.20230601.gappssmtp.com; s=20230601; t=1723624640; x=1724229440; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=OuYAUzTFHg5I0KpjLyCBE3URxWRbARYHFC0DuaPOX8w=;
        b=aNxrhwFfxsHAO8fzCWxyO/Oc2OPFWlF65nO3v51LStJvUY/jolfnCaqtf2QcEZRQeQ
         WjQj9pVySJVGM6nDXKx1O7sYScNaEuIitXb/KxnGlT4oHz1jaFs0xw1PtFVUp8FBSekM
         mnCKfE8lF31XY1Jw/whmGi5RPx805sscxCdykH7n70fY2McmbSO0u3+e9j7S1QOiunvo
         4nM06zLt2CvviSpxLu35yL+Oqs4iSW1puSrb4jA9iyXczJk6IjKmzidvN87wojTrhhOX
         U9QI3cvlLS62zeaM+Ybx+oIpJF2DX2tnrUM8LQNIxgBzwvegUebT6Oyx0lUz9rlWqa9Y
         b1CQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1723624640; x=1724229440;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=OuYAUzTFHg5I0KpjLyCBE3URxWRbARYHFC0DuaPOX8w=;
        b=StOOR0MSLjVRYhPptFuGQkGJCThoG5euXuWZd5b3PmK2KmwDM1DeIasQz/4ozplimc
         OjHQnoqSWSoATcG+YCWp2tk4tpUMkWWqVIAyKkF1UW4/Omrl4IuO6gH9c1054Oc7fve1
         gRS6MqqtbRxCLvuoYu4gMKoj0zKFCn542+FvqfEOL7w5vyMHXrpiQ70lpEX6qPfH5dtt
         dMF8TiUIRdg6x7x/HjsoEam7vDKU4DkZhEExDdq3ZUKvzU1R15l2b6XBUWBu7q7QTq2K
         vyrPwBkCtUFbhvN1vR0ZOd5nlQ44Vl+dI3zfmKpPh+UYMZbGR3OEdhrp/giXXbAGGOF3
         5uSw==
X-Gm-Message-State: AOJu0Yy1RH+YgRz7Y+aPhkvgJP7VRZ6T4cG1oj1EStSwYlTogGHLe9zg
	mufyoRMHqOYvh/NUOMnFHRdwWJIG4DczA6wLUHNJX9TuQyYmBidZQJwxJBtpBKo=
X-Google-Smtp-Source: AGHT+IEfeBhs1MWO6cG+8CxFN1Fpt75dyeb/tRozYReUJMVvbN6jtk7ryUMuDYTS9I/bO3uTg5Y6CA==
X-Received: by 2002:a17:906:bc25:b0:a77:eb34:3b49 with SMTP id a640c23a62f3a-a8366d49989mr133468466b.37.1723624639575;
        Wed, 14 Aug 2024 01:37:19 -0700 (PDT)
Received: from localhost (37-48-50-18.nat.epc.tmcz.cz. [37.48.50.18])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-a80f4183f72sm142859966b.205.2024.08.14.01.37.18
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 14 Aug 2024 01:37:19 -0700 (PDT)
Date: Wed, 14 Aug 2024 10:37:17 +0200
From: Jiri Pirko <jiri@resnulli.us>
To: Paolo Abeni <pabeni@redhat.com>
Cc: netdev@vger.kernel.org, Jakub Kicinski <kuba@kernel.org>,
	Madhu Chittim <madhu.chittim@intel.com>,
	Sridhar Samudrala <sridhar.samudrala@intel.com>,
	Simon Horman <horms@kernel.org>,
	John Fastabend <john.fastabend@gmail.com>,
	Sunil Kovvuri Goutham <sgoutham@marvell.com>,
	Jamal Hadi Salim <jhs@mojatatu.com>
Subject: Re: [PATCH v3 03/12] net-shapers: implement NL get operation
Message-ID: <ZrxsvRzijiSv0Ji8@nanopsycho.orion>
References: <cover.1722357745.git.pabeni@redhat.com>
 <7ed5d9b312ccda58c3400c7ba78bca8e5f8ea853.1722357745.git.pabeni@redhat.com>
 <ZquQyd6OTh8Hytql@nanopsycho.orion>
 <b75dfc17-303a-4b91-bd16-5580feefe177@redhat.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <b75dfc17-303a-4b91-bd16-5580feefe177@redhat.com>

Tue, Aug 13, 2024 at 05:17:12PM CEST, pabeni@redhat.com wrote:
>On 8/1/24 15:42, Jiri Pirko wrote:
>> Tue, Jul 30, 2024 at 10:39:46PM CEST, pabeni@redhat.com wrote:
>> > +/**
>> > + * net_shaper_make_handle - creates an unique shaper identifier
>> > + * @scope: the shaper scope
>> > + * @id: the shaper id number
>> > + *
>> > + * Return: an unique identifier for the shaper
>> > + *
>> > + * Combines the specified arguments to create an unique identifier for
>> > + * the shaper. The @id argument semantic depends on the
>> > + * specified scope.
>> > + * For @NET_SHAPER_SCOPE_QUEUE_GROUP, @id is the queue group id
>> > + * For @NET_SHAPER_SCOPE_QUEUE, @id is the queue number.
>> > + * For @NET_SHAPER_SCOPE_VF, @id is virtual function number.
>> > + */
>> > +static inline u32 net_shaper_make_handle(enum net_shaper_scope scope,
>> > +					 int id)
>> > +{
>> > +	return FIELD_PREP(NET_SHAPER_SCOPE_MASK, scope) |
>> > +		FIELD_PREP(NET_SHAPER_ID_MASK, id);
>> 
>> Perhaps some scopes may find only part of u32 as limitting for id in
>> the future? I find it elegant to have it in single u32 though. u64 may
>> be nicer (I know, xarray) :)
>
>With this code the id limit is 2^26 for each scope. The most capable H/W I'm
>aware of supports at most 64K shapers, overall. Are you aware of any specific
>constraint we need to address?

Nope. Just thinking out loud.


>
>[...]
>> > int net_shaper_nl_get_doit(struct sk_buff *skb, struct genl_info *info)
>> > {
>> > -	return -EOPNOTSUPP;
>> > +	struct net_shaper_info *shaper;
>> > +	struct net_device *dev;
>> > +	struct sk_buff *msg;
>> > +	u32 handle;
>> > +	int ret;
>> > +
>> > +	ret = fetch_dev(info, &dev);
>> 
>> This is quite net_device centric. Devlink rate shaper should be
>> eventually visible throught this api as well, won't they? How do you
>> imagine that?
>
>I'm unsure we are on the same page. Do you foresee this to replace and
>obsoleted the existing devlink rate API? It was not our so far.

Driver-api-wise, yes. I believe that was the goal, to have drivers to
implement one rate api.


>
>> Could we have various types of binding? Something like:
>> 
>> NET_SHAPER_A_BINDING nest
>>    NET_SHAPER_A_BINDING_IFINDEX u32
>> 
>> or:
>> NET_SHAPER_A_BINDING nest
>>    NET_SHAPER_A_BINDING_DEVLINK_PORT nest
>>      DEVLINK_ATTR_BUS_NAME string
>>      DEVLINK_ATTR_DEV_NAME string
>>      DEVLINK_ATTR_PORT_INDEX u32
>> 
>> ?
>
>Somewhat related, the current get()/dump() operations currently don't return
>the shaper ifindex. I guess we can include 'scope' and 'id' under
>NET_SHAPER_A_BINDING and replace the existing handle attribute with it.
>
>It should cover eventual future devlink extensions and provide all the
>relevant info for get/dump sake.

Sounds fine.


>
>> > +
>> > static int __init shaper_init(void)
>> 
>> 
>> 
>> fetch_dev
>> fill_handle
>> parse_handle
>> sc_lookup
>> __sc_container
>> dev_shaper_flush
>> shaper_init
>> 
>> 
>> Could you perhaps maintain net_shaper_ prefix for all of there?
>
>Most of the helpers are static and should never be visible outside this
>compilation unit, so I did not bother with a prefix, I'll add it in the next
>revision.

Thanks.


>
>Thanks,
>
>Paolo
>

