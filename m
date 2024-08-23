Return-Path: <netdev+bounces-121358-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 119B195CE0E
	for <lists+netdev@lfdr.de>; Fri, 23 Aug 2024 15:36:21 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 823AD1F21294
	for <lists+netdev@lfdr.de>; Fri, 23 Aug 2024 13:36:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0188D1586D3;
	Fri, 23 Aug 2024 13:36:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=resnulli-us.20230601.gappssmtp.com header.i=@resnulli-us.20230601.gappssmtp.com header.b="LHi85ZRZ"
X-Original-To: netdev@vger.kernel.org
Received: from mail-lj1-f170.google.com (mail-lj1-f170.google.com [209.85.208.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0EF42186E48
	for <netdev@vger.kernel.org>; Fri, 23 Aug 2024 13:36:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724420175; cv=none; b=nEQnyGI4fOyGZ0de6+6k764ixmIg4Wq0wghAbvStCZzuk7QOyCc80SHaUZjJM0dMIVthMXyxiL2Y631vSerpUo0GilAA9N3xRqWPk7DvyX+zXFrrW4Bu/O8hAS7UVuipn4PWJusBM0PfHxVlr1Tr80P52Fp8OOjck0dq4UrbViU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724420175; c=relaxed/simple;
	bh=h0fW1E/Hqi0rjeZuHpN3QMRPfvncFkvOv9xD5myWszc=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=MEWald3m697EWSPqIIxy2l12g4osQz/0Xlugzcfp2G9MpsMos5cx22C3Mn1I+DTWVzEMqL43IDv4WXlf77KNyVwu9rrMTpmHxV7cBspc4fh70saMO+rKvr4Xt/b4i5jU1S3xe2bOMv2+xwJPxNEb1eh3qgWAc/CNeaiZ6uW1ypQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=resnulli.us; spf=none smtp.mailfrom=resnulli.us; dkim=pass (2048-bit key) header.d=resnulli-us.20230601.gappssmtp.com header.i=@resnulli-us.20230601.gappssmtp.com header.b=LHi85ZRZ; arc=none smtp.client-ip=209.85.208.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=resnulli.us
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=resnulli.us
Received: by mail-lj1-f170.google.com with SMTP id 38308e7fff4ca-2f4f24263acso21998421fa.0
        for <netdev@vger.kernel.org>; Fri, 23 Aug 2024 06:36:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=resnulli-us.20230601.gappssmtp.com; s=20230601; t=1724420172; x=1725024972; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=i/hrlcBOw7taIRVHdg+uznRFul59Cbdga+xEVQ7cyr4=;
        b=LHi85ZRZzX5fiacwJq0B4mkftCdmdHDiUp2y+zbSv7GqKemd+IGkkpR9IIA3LWHfQa
         JttSpDykWQQCaov8tEDJLDKClnRyCMX+2UYNxjNs4ZI2e71dX9fJk1BLoaqKbcoFcZ7Y
         lUeVmFKaDSvz87dDMEWa+dNpeH/n0HT6JbDQqja2bPVebmfo9h4F6ssKiOAsdkFyseqL
         8AWxwBca4DZVPiq5IvwK/kKZB6g5R51WlqANiChv5HaM1JAINCPxsK+xF4B3i1c2VlR9
         Kcn1qnjoxo3CS3ip5RWDWxg6e7ETH6IVaWpOSaeM7VdFPOQQpgatrpFE1wjNs42+d3XY
         irFQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1724420172; x=1725024972;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=i/hrlcBOw7taIRVHdg+uznRFul59Cbdga+xEVQ7cyr4=;
        b=dOKiLnUO3gJr8Go2hJGSntKDmZZvuRMoz5UB/H0SUUO/YYKiTuv9ZPsRmU6ztqjp1t
         tYjoGbQR69N6XxX6mrXqftaDSPSSIrtER8NhLZ0Wr2jDbGMGG+TqUeSYpfSts1vIF5Js
         NZ/6/DIcWHtEdpcZYQZAQBoz3BdGYXhSfKfx/wQrEfsSKxThkA6Y0XGhiqX3GgLhZ7Tn
         MC4/K66SPYvFPeiqarHq2JZe5xJh18vo0ttF6L3QD4ke0ZtykClm3wZRWv1tSKdz0YF1
         6CJ6Y8fHdzyhveGSHrGAnxww++SmtbvlAzLyN4/suQkl4tE+kg8zHwEKwKa394gevChN
         I0CQ==
X-Forwarded-Encrypted: i=1; AJvYcCWC1Yi0evFvsedV2G6+c8vCUPOvyvhvoaBT8J1FoKfjgKiLx/CuXfBDQX6S9wBK5ZG2ugueZFM=@vger.kernel.org
X-Gm-Message-State: AOJu0Yyoqnx++7CJD2yncBup0SSzXTTd2IfI7diKtPciFuAtKvsQ74jP
	WrZonDRC6PtJ/4nnh2V03QiWKTB+3YXQKfYhpiM4Yhjr94kr5ln8pPvxo95W7ss=
X-Google-Smtp-Source: AGHT+IFeKxNev3jHp2LtyOqB5QeH9inrXLuK7HpJosiKT+KPtRN5PJnwk+f1XZsWnq2Px5OysLTxhA==
X-Received: by 2002:a05:651c:199f:b0:2f4:f253:ec7 with SMTP id 38308e7fff4ca-2f4f569add3mr22983301fa.0.1724420171794;
        Fri, 23 Aug 2024 06:36:11 -0700 (PDT)
Received: from localhost (37-48-50-18.nat.epc.tmcz.cz. [37.48.50.18])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-a868f484b29sm259247366b.162.2024.08.23.06.36.10
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 23 Aug 2024 06:36:10 -0700 (PDT)
Date: Fri, 23 Aug 2024 15:36:09 +0200
From: Jiri Pirko <jiri@resnulli.us>
To: Paolo Abeni <pabeni@redhat.com>
Cc: Jakub Kicinski <kuba@kernel.org>, netdev@vger.kernel.org,
	Madhu Chittim <madhu.chittim@intel.com>,
	Sridhar Samudrala <sridhar.samudrala@intel.com>,
	Simon Horman <horms@kernel.org>,
	John Fastabend <john.fastabend@gmail.com>,
	Sunil Kovvuri Goutham <sgoutham@marvell.com>,
	Jamal Hadi Salim <jhs@mojatatu.com>
Subject: Re: [PATCH v3 03/12] net-shapers: implement NL get operation
Message-ID: <ZsiQSfTNr5G0MA58@nanopsycho.orion>
References: <Zr8Y1rcXVdYhsp9q@nanopsycho.orion>
 <4cb6fe12-a561-47a4-9046-bb54ad1f4d4e@redhat.com>
 <ZsMyI0UOn4o7OfBj@nanopsycho.orion>
 <47b4ab84-2910-4501-bbc8-c6a9b251d7a5@redhat.com>
 <Zsco7hs_XWTb3htS@nanopsycho.orion>
 <20240822074112.709f769e@kernel.org>
 <cc41bdf9-f7b6-4b5c-81ad-53230206aa57@redhat.com>
 <20240822155608.3034af6c@kernel.org>
 <Zsh3ecwUICabLyHV@nanopsycho.orion>
 <c7e0547b-a1e4-4e47-b7ec-010aa92fbc3a@redhat.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <c7e0547b-a1e4-4e47-b7ec-010aa92fbc3a@redhat.com>

Fri, Aug 23, 2024 at 02:58:27PM CEST, pabeni@redhat.com wrote:
>On 8/23/24 13:50, Jiri Pirko wrote:
>> Fri, Aug 23, 2024 at 12:56:08AM CEST, kuba@kernel.org wrote:
>> > On Thu, 22 Aug 2024 22:30:35 +0200 Paolo Abeni wrote:
>> > > > > I'm not saying this is deal breaker for me. I just think that if the api
>> > > > > is designed to be independent of the object shaper is bound to
>> > > > > (netdev/devlink_port/etc), it would be much much easier to extend in the
>> > > > > future. If you do everything netdev-centric from start, I'm sure no
>> > > > > shaper consolidation will ever happen. And that I thought was one of the
>> > > > > goals.
>> > > > > 
>> > > > > Perhaps Jakub has opinion.
>> > > > 
>> > > > I think you and I are on the same page :) Other than the "reference
>> > > > object" (netdev / devlink port) the driver facing API should be
>> > > > identical. Making it possible for the same driver code to handle
>> > > > translating the parameters into HW config / FW requests, whether
>> > > > they shape at the device (devlink) or port (netdev) level.
>> > > > 
>> > > > Shaper NL for netdevs is separate from internal representation and
>> > > > driver API in my mind. My initial ask was to create the internal
>> > > > representation first, make sure it can express devlink and handful of
>> > > > exiting netdev APIs, and only once that's merged worry about exposing
>> > > > it via a new NL.
>> > > > 
>> > > > I'm not opposed to showing devlink shapers in netdev NL (RO as you say)
>> > > > but talking about it now strikes me as cart before the horse.
>> > > 
>> > > FTR, I don't see both of you on the same page ?!?
>> > > 
>> > > I read the above as Jiri's preference is a single ndo set to control
>> 
>> "Ndo" stands for netdev op and they are all tightly coupled with
>> netdevices. So, "single ndo set to control both devlink and netdev
>> shapers" sounds like nonsense to me.
>
>In this context, "NDOs" == set of function pointers operating on the same
>object.
>
>> > > Or to phrase the above differently, Jiri is focusing on the shaper
>> > > "binding" (how to locate/access it) while Jakub is focusing on the
>> > > shaper "info" (content/definition/attributes). Please correct me If I
>> > > misread something.
>> 
>> Two(or more) similar ops structs looks odd to me. I think that the ops
>> should should be shared and just the "binding point" should be somehow
>> abstracted out. Code speaks, let me draft how it could be done:
>> 
>> enum net_shaper_binding_type {
>>          NET_SHAPER_BINDING_TYPE_NETDEV,
>>          NET_SHAPER_BINDING_TYPE_DEVLINK_PORT,
>> };
>> 
>> struct net_shaper_binding {
>>          enum net_shaper_binding_type type;
>>          union {
>>                  struct net_device *netdev;
>>                  struct devlink_port *devlink_port;
>>          };
>> };
>> 
>> struct net_shaper_ops {
>> +       /**
>> +        * @group: create the specified shapers scheduling group
>> +        *
>> +        * Nest the @leaves shapers identified by @leaves_handles under the
>> +        * @root shaper identified by @root_handle. All the shapers belong
>> +        * to the network device @dev. The @leaves and @leaves_handles shaper
>> +        * arrays size is specified by @leaves_count.
>> +        * Create either the @leaves and the @root shaper; or if they already
>> +        * exists, links them together in the desired way.
>> +        * @leaves scope must be NET_SHAPER_SCOPE_QUEUE.
>> +        *
>> +        * Returns 0 on group successfully created, otherwise an negative
>> +        * error value and set @extack to describe the failure's reason.
>> +        */
>> +       int (*group)(const struct net_shaper_binding *binding, int leaves_count,
>> +                    const struct net_shaper_handle *leaves_handles,
>> +                    const struct net_shaper_info *leaves,
>> +                    const struct net_shaper_handle *root_handle,
>> +                    const struct net_shaper_info *root,
>> +                    struct netlink_ext_ack *extack);
>> +
>> +       /**
>> +        * @set: Updates the specified shaper
>> +        *
>> +        * Updates or creates the @shaper identified by the provided @handle
>> +        * on the given device @dev.
>> +        *
>> +        * Returns 0 on success, otherwise an negative
>> +        * error value and set @extack to describe the failure's reason.
>> +        */
>> +       int (*set)(const struct net_shaper_binding *binding,
>> +                  const struct net_shaper_handle *handle,
>> +                  const struct net_shaper_info *shaper,
>> +                  struct netlink_ext_ack *extack);
>> +
>> +       /**
>> +        * @delete: Removes the specified shaper from the NIC
>> +        *
>> +        * Removes the shaper configuration as identified by the given @handle
>> +        * on the specified device @dev, restoring the default behavior.
>> +        *
>> +        * Returns 0 on success, otherwise an negative
>> +        * error value and set @extack to describe the failure's reason.
>> +        */
>> +       int (*delete)(const struct net_shaper_binding *binding,
>> +                     const struct net_shaper_handle *handle,
>> +                     struct netlink_ext_ack *extack);
>> +};
>>
>> 
>> static inline struct net_device *
>> net_shaper_binding_netdev(struct net_shaper_binding *binding)
>> {
>>          WARN_ON(binding->type != NET_SHAPER_BINDING_TYPE_NETDEV)
>>          return binding->netdev;
>> }
>> 
>> static inline struct devlink_port *
>> net_shaper_binding_devlink_port(struct net_shaper_binding *binding)
>> {
>>          WARN_ON(binding->type != NET_SHAPER_BINDING_TYPE_DEVLINK_PORT)
>>          return binding->devlink_port;
>> }
>> 
>> Then whoever calls the op fills-up the binding structure accordingly.
>> 
>> 
>> drivers can implement ops, for netdev-bound shaper like this:
>> 
>> static int driverx_shaper_set(const struct net_shaper_binding *binding,
>>                                const struct net_shaper_handle *handle,
>>                                const struct net_shaper_info *shaper,
>>                                struct netlink_ext_ack *extack);
>> {
>>          struct net_device *netdev = net_shaper_binding_netdev(binding);
>>          ......
>> }
>> 
>> struct net_shaper_ops driverx_shaper_ops {
>>          .set = driverx_shaper_set;
>>          ......
>> };
>> 
>> static const struct net_device_ops driverx_netdev_ops = {
>>          .net_shaper_ops = &driverx_shaper_ops,
>>          ......
>> };
>
>If I read correctly, the net_shaper_ops caller will have to discriminate
>between net_device and devlink, do the object-type-specific lookup to get the
>relevant net_device (or devlink) object and then pass to such net_device (or
>devlink) a "generic" binding. Did I misread something? If so I must admit I
>really dislike such interface.

You are right. For example devlink rate set command handler will call
the op with devlink_port binding set.

>
>I personally think it would be much cleaner to have 2 separate set of
>operations, with exactly the same semantic and argument list, except for the
>first argument (struct net_device or struct devlink).

I think it is totally subjective. You like something, I like something
else. Both works. The amount of duplicity and need to change same
things on multiple places in case of bugfixes and extensions is what I
dislike on the 2 separate sets. Plus, there might be another binding in
the future, will you copy the ops struct again then?


>
>The driver implementation could still de-duplicate a lot of code, as far as
>the shaper-related arguments are the same.
>
>Side note, if the intention is to allow the user to touch/modify the
>queue-level and queue-group-level shapers via the devlink object? if that is
>the intention, we will need to drop the shaper cache and (re-)introduce a
>get() callback, as the same shaper could be reached via multiple
>binding/handle pairs and the core will not know all of such pairs for a given
>shaper.

That is a good question, I don't know. But gut feeling is "no".


>
>Thanks,
>
>Paolo
>

