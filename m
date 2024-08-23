Return-Path: <netdev+bounces-121341-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 257F695CD0F
	for <lists+netdev@lfdr.de>; Fri, 23 Aug 2024 14:58:38 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id D574828A727
	for <lists+netdev@lfdr.de>; Fri, 23 Aug 2024 12:58:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 847BD18595B;
	Fri, 23 Aug 2024 12:58:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="VLChff6x"
X-Original-To: netdev@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B70B718594D
	for <netdev@vger.kernel.org>; Fri, 23 Aug 2024 12:58:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724417916; cv=none; b=F6WpqP1WJrCFwdrVqkK5pKiv3jPeaNboWBEltmflZY64kq2X0spWcoDs8ZTKw2/iEe54gE+OrfL58gz0ytGqwrdekbknOmdDqwSq9m3XZCfKfuB4kF+25HhdRsndXlX0mH/kdZNKb2KSPrQi4jH39IkaymM6WB0ZE0yzvWFx8gw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724417916; c=relaxed/simple;
	bh=mixtUaNsId3MtMd8Qv3PfRQ7R8fSRNsBzkNBdxYGzQw=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=pI5qEhU2o0iIyFq5vLxsAWqbCqw85phIogs03IZ0RIHfKGJmDP/elbHdg+eH5O1HXwNGqAZmTwIeR76j15k4cewEMe0Srqsstz8Ojvatt5ErdRGUHDXYSwM08OcOaeUqFGCGNwfF5YyyhHN4+XD/MCnsxo3bSumxO05i3l57RJI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=VLChff6x; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1724417913;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=nEOO+a+5IcuphHWAfDoyvHX+lxHQ1bFDEwqLKfbx8Rk=;
	b=VLChff6xi84TYp0VrvH/OdGe/iQGndAjyOLe3jhPdLlz9ZVe6ZB9AcEicyTAqmTFk7KMl1
	YthH2+UN49yBOQxnyNWLL3TMhRhDrWRE2T4F88Tz4GVoo3xwluPIiymwiWVlFCULyqVSgp
	uA6IpcoQ4sx7BIJ3lFnvJgp6KujkNAI=
Received: from mail-wr1-f72.google.com (mail-wr1-f72.google.com
 [209.85.221.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-576-jLh0AMlLPqituhok-mDyaw-1; Fri, 23 Aug 2024 08:58:32 -0400
X-MC-Unique: jLh0AMlLPqituhok-mDyaw-1
Received: by mail-wr1-f72.google.com with SMTP id ffacd0b85a97d-371ab0c02e0so1504097f8f.3
        for <netdev@vger.kernel.org>; Fri, 23 Aug 2024 05:58:32 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1724417911; x=1725022711;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=nEOO+a+5IcuphHWAfDoyvHX+lxHQ1bFDEwqLKfbx8Rk=;
        b=WY29CyCGrdClTO+ffYTY2pubpXRsuoswdmbNQM7RYMUsup/NbSd9puMf8tX2BeulLZ
         WcTF9EX+26nQMExXRZEDTAnvItoUjoc45/faKJNK/8v4POP1W4/SIEV9skH0sKhx2v4Z
         YkG5rJ2JTUGGvOLNB2Z3yfSN/n1AiCkqrGPK/Q/DeUibuUVHlRMZEHj5g5dHIolkvyAm
         XdUBMbP+f/LZxUFldccmXGLGqF3zC+eZOncXA/rwzzfDbbDCU8yKPUEQgDuRcN2gcFCg
         aJn0z35AAtJZfrtD3VMBjPwU0WBt/4L/MbP9c1xW6JI3yM61LtHTvfg7pj2bDrat6Oem
         VDgg==
X-Gm-Message-State: AOJu0YwOvU65rwMTtZGEJfSSZeZGh6NheogW6v1s7Ze19YCcvhPOv0X1
	2Owk0R7OBo8IJEWRz/+rpUv93dczH4GcnJZRHyndPAg4Jax4kbrYkLGBc19pxsxwQGmZs679IqE
	I9mtCQjiuZ/onnMQtTW2yyDwDJ3h+gDh4fjTIuQNuv7aRkNxz6AOhJw==
X-Received: by 2002:a5d:650b:0:b0:371:8bce:7a7c with SMTP id ffacd0b85a97d-37311840071mr1602849f8f.13.1724417910767;
        Fri, 23 Aug 2024 05:58:30 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IGuUXCyTppPdsbaPGcfN+wJdEHWb+kGk+95A50XA7qxUE84GMaSEXFqr2rCeczzsLFtQcI0Jg==
X-Received: by 2002:a5d:650b:0:b0:371:8bce:7a7c with SMTP id ffacd0b85a97d-37311840071mr1602818f8f.13.1724417910203;
        Fri, 23 Aug 2024 05:58:30 -0700 (PDT)
Received: from ?IPV6:2a0d:3344:1b51:3b10::f71? ([2a0d:3344:1b51:3b10::f71])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-37308157c55sm4100687f8f.46.2024.08.23.05.58.28
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 23 Aug 2024 05:58:29 -0700 (PDT)
Message-ID: <c7e0547b-a1e4-4e47-b7ec-010aa92fbc3a@redhat.com>
Date: Fri, 23 Aug 2024 14:58:27 +0200
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 03/12] net-shapers: implement NL get operation
To: Jiri Pirko <jiri@resnulli.us>, Jakub Kicinski <kuba@kernel.org>
Cc: netdev@vger.kernel.org, Madhu Chittim <madhu.chittim@intel.com>,
 Sridhar Samudrala <sridhar.samudrala@intel.com>,
 Simon Horman <horms@kernel.org>, John Fastabend <john.fastabend@gmail.com>,
 Sunil Kovvuri Goutham <sgoutham@marvell.com>,
 Jamal Hadi Salim <jhs@mojatatu.com>
References: <ZrxsvRzijiSv0Ji8@nanopsycho.orion>
 <f320213f-7b1a-4a7b-9e0c-94168ca187db@redhat.com>
 <Zr8Y1rcXVdYhsp9q@nanopsycho.orion>
 <4cb6fe12-a561-47a4-9046-bb54ad1f4d4e@redhat.com>
 <ZsMyI0UOn4o7OfBj@nanopsycho.orion>
 <47b4ab84-2910-4501-bbc8-c6a9b251d7a5@redhat.com>
 <Zsco7hs_XWTb3htS@nanopsycho.orion> <20240822074112.709f769e@kernel.org>
 <cc41bdf9-f7b6-4b5c-81ad-53230206aa57@redhat.com>
 <20240822155608.3034af6c@kernel.org> <Zsh3ecwUICabLyHV@nanopsycho.orion>
Content-Language: en-US
From: Paolo Abeni <pabeni@redhat.com>
In-Reply-To: <Zsh3ecwUICabLyHV@nanopsycho.orion>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 8/23/24 13:50, Jiri Pirko wrote:
> Fri, Aug 23, 2024 at 12:56:08AM CEST, kuba@kernel.org wrote:
>> On Thu, 22 Aug 2024 22:30:35 +0200 Paolo Abeni wrote:
>>>>> I'm not saying this is deal breaker for me. I just think that if the api
>>>>> is designed to be independent of the object shaper is bound to
>>>>> (netdev/devlink_port/etc), it would be much much easier to extend in the
>>>>> future. If you do everything netdev-centric from start, I'm sure no
>>>>> shaper consolidation will ever happen. And that I thought was one of the
>>>>> goals.
>>>>>
>>>>> Perhaps Jakub has opinion.
>>>>
>>>> I think you and I are on the same page :) Other than the "reference
>>>> object" (netdev / devlink port) the driver facing API should be
>>>> identical. Making it possible for the same driver code to handle
>>>> translating the parameters into HW config / FW requests, whether
>>>> they shape at the device (devlink) or port (netdev) level.
>>>>
>>>> Shaper NL for netdevs is separate from internal representation and
>>>> driver API in my mind. My initial ask was to create the internal
>>>> representation first, make sure it can express devlink and handful of
>>>> exiting netdev APIs, and only once that's merged worry about exposing
>>>> it via a new NL.
>>>>
>>>> I'm not opposed to showing devlink shapers in netdev NL (RO as you say)
>>>> but talking about it now strikes me as cart before the horse.
>>>
>>> FTR, I don't see both of you on the same page ?!?
>>>
>>> I read the above as Jiri's preference is a single ndo set to control
> 
> "Ndo" stands for netdev op and they are all tightly coupled with
> netdevices. So, "single ndo set to control both devlink and netdev
> shapers" sounds like nonsense to me.

In this context, "NDOs" == set of function pointers operating on the 
same object.

>>> Or to phrase the above differently, Jiri is focusing on the shaper
>>> "binding" (how to locate/access it) while Jakub is focusing on the
>>> shaper "info" (content/definition/attributes). Please correct me If I
>>> misread something.
> 
> Two(or more) similar ops structs looks odd to me. I think that the ops
> should should be shared and just the "binding point" should be somehow
> abstracted out. Code speaks, let me draft how it could be done:
> 
> enum net_shaper_binding_type {
>          NET_SHAPER_BINDING_TYPE_NETDEV,
>          NET_SHAPER_BINDING_TYPE_DEVLINK_PORT,
> };
> 
> struct net_shaper_binding {
>          enum net_shaper_binding_type type;
>          union {
>                  struct net_device *netdev;
>                  struct devlink_port *devlink_port;
>          };
> };
> 
> struct net_shaper_ops {
> +       /**
> +        * @group: create the specified shapers scheduling group
> +        *
> +        * Nest the @leaves shapers identified by @leaves_handles under the
> +        * @root shaper identified by @root_handle. All the shapers belong
> +        * to the network device @dev. The @leaves and @leaves_handles shaper
> +        * arrays size is specified by @leaves_count.
> +        * Create either the @leaves and the @root shaper; or if they already
> +        * exists, links them together in the desired way.
> +        * @leaves scope must be NET_SHAPER_SCOPE_QUEUE.
> +        *
> +        * Returns 0 on group successfully created, otherwise an negative
> +        * error value and set @extack to describe the failure's reason.
> +        */
> +       int (*group)(const struct net_shaper_binding *binding, int leaves_count,
> +                    const struct net_shaper_handle *leaves_handles,
> +                    const struct net_shaper_info *leaves,
> +                    const struct net_shaper_handle *root_handle,
> +                    const struct net_shaper_info *root,
> +                    struct netlink_ext_ack *extack);
> +
> +       /**
> +        * @set: Updates the specified shaper
> +        *
> +        * Updates or creates the @shaper identified by the provided @handle
> +        * on the given device @dev.
> +        *
> +        * Returns 0 on success, otherwise an negative
> +        * error value and set @extack to describe the failure's reason.
> +        */
> +       int (*set)(const struct net_shaper_binding *binding,
> +                  const struct net_shaper_handle *handle,
> +                  const struct net_shaper_info *shaper,
> +                  struct netlink_ext_ack *extack);
> +
> +       /**
> +        * @delete: Removes the specified shaper from the NIC
> +        *
> +        * Removes the shaper configuration as identified by the given @handle
> +        * on the specified device @dev, restoring the default behavior.
> +        *
> +        * Returns 0 on success, otherwise an negative
> +        * error value and set @extack to describe the failure's reason.
> +        */
> +       int (*delete)(const struct net_shaper_binding *binding,
> +                     const struct net_shaper_handle *handle,
> +                     struct netlink_ext_ack *extack);
> +};
 >
> 
> static inline struct net_device *
> net_shaper_binding_netdev(struct net_shaper_binding *binding)
> {
>          WARN_ON(binding->type != NET_SHAPER_BINDING_TYPE_NETDEV)
>          return binding->netdev;
> }
> 
> static inline struct devlink_port *
> net_shaper_binding_devlink_port(struct net_shaper_binding *binding)
> {
>          WARN_ON(binding->type != NET_SHAPER_BINDING_TYPE_DEVLINK_PORT)
>          return binding->devlink_port;
> }
> 
> Then whoever calls the op fills-up the binding structure accordingly.
> 
> 
> drivers can implement ops, for netdev-bound shaper like this:
> 
> static int driverx_shaper_set(const struct net_shaper_binding *binding,
>                                const struct net_shaper_handle *handle,
>                                const struct net_shaper_info *shaper,
>                                struct netlink_ext_ack *extack);
> {
>          struct net_device *netdev = net_shaper_binding_netdev(binding);
>          ......
> }
> 
> struct net_shaper_ops driverx_shaper_ops {
>          .set = driverx_shaper_set;
>          ......
> };
> 
> static const struct net_device_ops driverx_netdev_ops = {
>          .net_shaper_ops = &driverx_shaper_ops,
>          ......
> };

If I read correctly, the net_shaper_ops caller will have to discriminate 
between net_device and devlink, do the object-type-specific lookup to 
get the relevant net_device (or devlink) object and then pass to such 
net_device (or devlink) a "generic" binding. Did I misread something? If 
so I must admit I really dislike such interface.

I personally think it would be much cleaner to have 2 separate set of 
operations, with exactly the same semantic and argument list, except for 
the first argument (struct net_device or struct devlink).

The driver implementation could still de-duplicate a lot of code, as far 
as the shaper-related arguments are the same.

Side note, if the intention is to allow the user to touch/modify the 
queue-level and queue-group-level shapers via the devlink object? if 
that is the intention, we will need to drop the shaper cache and 
(re-)introduce a get() callback, as the same shaper could be reached via 
multiple binding/handle pairs and the core will not know all of such 
pairs for a given shaper.

Thanks,

Paolo


