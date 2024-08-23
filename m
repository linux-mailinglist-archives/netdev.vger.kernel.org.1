Return-Path: <netdev+bounces-121281-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 7634B95C864
	for <lists+netdev@lfdr.de>; Fri, 23 Aug 2024 10:52:17 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 2CFBC2818DE
	for <lists+netdev@lfdr.de>; Fri, 23 Aug 2024 08:52:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 45CCD146D78;
	Fri, 23 Aug 2024 08:52:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="GpIHJxn4"
X-Original-To: netdev@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7E3B744C76
	for <netdev@vger.kernel.org>; Fri, 23 Aug 2024 08:52:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724403133; cv=none; b=u8m+lflbSoZJixJDBwf+tuo4TFHPUWtZah6CH332Te0AUu9D9rJnJWXSoFJAAhQaUB3rPcI03goIxGEYs9qR99im8kKiNI2l94pu4w62Ijms2MFgOFOIq2sman/99yKoTWF8ELbPICcvKEesTd6vOnRf6NHQFwtCx0BO6Pc+KEY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724403133; c=relaxed/simple;
	bh=9mm9LIKQPf1tpxPInZjd8lTdWPk3mYTFpuBygy9nxOo=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=UIOHNmbIuCBXj+Zoi34EKkTuPbx8J83GRW8AdZE0NQVfBUzqPJFIpMsXSVlMlUSZqvWfBSK20DsKMRkxZlSrKJ7CycSsJ/vdscOJ6YT5iePypC2xbKVjrkJLY80y+Bs4FPlNVGz7tqjmunJ5Mn8mfBBO/I6QhlkE3WbbXrPAH7I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=GpIHJxn4; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1724403130;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=oCIlWRAQNbUskKmxEfRTC1/T7ZuQpdkZ3ksWA+VFm+0=;
	b=GpIHJxn4gU1fzxLoMB2ADCQNH1KInSdZge7pZNV2gsimAL9T6CnAbQ515R1cpfByGIemea
	1rkruIBHRSyxVTuIdQs3QAEZlRFdKQmIuYVU7pDVN4qa6Ixi+WcckX5XFPgK/kAxaT0JSx
	Fwvn8OFxNTu4BoWj24Hdir6FO/SO76g=
Received: from mail-wm1-f71.google.com (mail-wm1-f71.google.com
 [209.85.128.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-401-0bbNU2rtOQaS-HNP6TgBOQ-1; Fri, 23 Aug 2024 04:52:08 -0400
X-MC-Unique: 0bbNU2rtOQaS-HNP6TgBOQ-1
Received: by mail-wm1-f71.google.com with SMTP id 5b1f17b1804b1-42809eb7b99so9902965e9.0
        for <netdev@vger.kernel.org>; Fri, 23 Aug 2024 01:52:07 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1724403127; x=1725007927;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=oCIlWRAQNbUskKmxEfRTC1/T7ZuQpdkZ3ksWA+VFm+0=;
        b=oaUngylIssSkcwrU9RNRnyWFCAcqig/1HWPnbg06CcQBv/uCClTSMniNuusJN0if1H
         wYwzpXh+AcOMmTQ/ZBkdoTra2GWKpqGwpZOcdYgYWYKMiY9e/fMrrA3+Gi5E8AW+WDCR
         jvyDSDmmqT5R+6mKdB40A8N/u2/PbVGNBmp3GigCwfvINXCqETlIz3DDwPI2a1D22qRs
         VJ44esA0AZVeVy5n6bmhnJc/K17mLhWHpWR0gIOs66xXuM2iSdX6XyFG0GIwryotQbV7
         /DLv81y4/ZvCbvl2CZ7V3vvZFXxRVj6JwCBPJAw82YilhQ++FEMSk136E6Oevi0DI7Vf
         Awdw==
X-Gm-Message-State: AOJu0YwhnUDie3kZsMUcasob0MVbANoIsqAX3Ep3DNc2IhrVmL1WUSVD
	h9S9/upINiAh/On4YoHkWa7TL5V/hi4FfT0q61G6JCREkTLFyYWQJGCij3vcWHi13Fz9sMGfbCJ
	qWqUPYXvg+wQQ5IicxpoGmz/w2Yxe/2fH/yJIbmgNlaEdZ7D0VopWvQ==
X-Received: by 2002:a05:600c:1ca9:b0:428:e820:37dc with SMTP id 5b1f17b1804b1-42acc8dd67amr8789475e9.7.1724403126765;
        Fri, 23 Aug 2024 01:52:06 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IGHJUaD1t9jnfLSHLF9dXbe+FuaBC77bxfrNMciN4ximu2X5OSJ9VQXU0ICGNklwSmrjl7MXw==
X-Received: by 2002:a05:600c:1ca9:b0:428:e820:37dc with SMTP id 5b1f17b1804b1-42acc8dd67amr8789295e9.7.1724403126247;
        Fri, 23 Aug 2024 01:52:06 -0700 (PDT)
Received: from ?IPV6:2a0d:3344:1b51:3b10::f71? ([2a0d:3344:1b51:3b10::f71])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-3730811001fsm3640069f8f.20.2024.08.23.01.52.05
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 23 Aug 2024 01:52:05 -0700 (PDT)
Message-ID: <0e5c2178-22e2-409e-8cbd-9aaa66594fdc@redhat.com>
Date: Fri, 23 Aug 2024 10:52:04 +0200
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v4 net-next 03/12] net-shapers: implement NL get operation
To: Jakub Kicinski <kuba@kernel.org>
Cc: netdev@vger.kernel.org, Jiri Pirko <jiri@resnulli.us>,
 Madhu Chittim <madhu.chittim@intel.com>,
 Sridhar Samudrala <sridhar.samudrala@intel.com>,
 Simon Horman <horms@kernel.org>, John Fastabend <john.fastabend@gmail.com>,
 Sunil Kovvuri Goutham <sgoutham@marvell.com>,
 Jamal Hadi Salim <jhs@mojatatu.com>, Donald Hunter <donald.hunter@gmail.com>
References: <cover.1724165948.git.pabeni@redhat.com>
 <c5ad129f46b98d899fde3f0352f5cb54c2aa915b.1724165948.git.pabeni@redhat.com>
 <20240822191042.71a19582@kernel.org>
Content-Language: en-US
From: Paolo Abeni <pabeni@redhat.com>
In-Reply-To: <20240822191042.71a19582@kernel.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 8/23/24 04:10, Jakub Kicinski wrote:
> On Tue, 20 Aug 2024 17:12:24 +0200 Paolo Abeni wrote:
>> --- a/include/linux/netdevice.h
>> +++ b/include/linux/netdevice.h
>> @@ -81,6 +81,8 @@ struct xdp_frame;
>>   struct xdp_metadata_ops;
>>   struct xdp_md;
>>   struct ethtool_netdev_state;
>> +struct net_shaper_ops;
>> +struct net_shaper_data;
> 
> no need, forward declarations are only needed for function declarations
> 
>> + * struct net_shaper_ops - Operations on device H/W shapers
>> + *
>> + * The initial shaping configuration at device initialization is empty:
>> + * does not constraint the rate in any way.
>> + * The network core keeps track of the applied user-configuration in
>> + * the net_device structure.
>> + * The operations are serialized via a per network device lock.
>> + *
>> + * Each shaper is uniquely identified within the device with an 'handle'
> 
> a handle
> 
>> + * comprising the shaper scope and a scope-specific id.
>> + */
>> +struct net_shaper_ops {
>> +	/**
>> +	 * @group: create the specified shapers scheduling group
>> +	 *
>> +	 * Nest the @leaves shapers identified by @leaves_handles under the
>> +	 * @root shaper identified by @root_handle. All the shapers belong
>> +	 * to the network device @dev. The @leaves and @leaves_handles shaper
>> +	 * arrays size is specified by @leaves_count.
>> +	 * Create either the @leaves and the @root shaper; or if they already
>> +	 * exists, links them together in the desired way.
>> +	 * @leaves scope must be NET_SHAPER_SCOPE_QUEUE.
> 
> Or SCOPE_NODE, no?

I had a few back-and-forth between the two options, enforcing only QUEUE 
leaves or allowing even NODE.

I think the first option is general enough - can create arbitrary 
topologies with the same amount of operations - and leads to slightly 
simpler code, but no objections for allow both.

> 
>> +	 * Returns 0 on group successfully created, otherwise an negative
>> +	 * error value and set @extack to describe the failure's reason.
> 
> the return and extack lines are pretty obvious, you can drop
> 
>> +	 */
>> +	int (*group)(struct net_device *dev, int leaves_count,
>> +		     const struct net_shaper_handle *leaves_handles,
>> +		     const struct net_shaper_info *leaves,
>> +		     const struct net_shaper_handle *root_handle,
>> +		     const struct net_shaper_info *root,
>> +		     struct netlink_ext_ack *extack);
> 
>> +#endif
>> +
> 
> ooh, here's one of the trailing whitespace git was mentioning :)
> 
>>   #include <linux/kernel.h>
>> +#include <linux/bits.h>
>> +#include <linux/bitfield.h>
>> +#include <linux/idr.h>
>> +#include <linux/netdevice.h>
>> +#include <linux/netlink.h>
>>   #include <linux/skbuff.h>
>> +#include <linux/xarray.h>
>> +#include <net/net_shaper.h>
> 
> kernel.h between idr.h and netdevice.h
> 
>> +static int net_shaper_fill_handle(struct sk_buff *msg,
>> +				  const struct net_shaper_handle *handle,
>> +				  u32 type, const struct genl_info *info)
>> +{
>> +	struct nlattr *handle_attr;
>> +
>> +	if (handle->scope == NET_SHAPER_SCOPE_UNSPEC)
>> +		return 0;
> 
> In what context can we try to fill handle with scope unspec?

Uhmm... should happen only in buggy situation. What about adding adding 
WARN_ON_ONCE() ?

>> +	handle_attr = nla_nest_start_noflag(msg, type);
>> +	if (!handle_attr)
>> +		return -EMSGSIZE;
>> +
>> +	if (nla_put_u32(msg, NET_SHAPER_A_SCOPE, handle->scope) ||
>> +	    (handle->scope >= NET_SHAPER_SCOPE_QUEUE &&
>> +	     nla_put_u32(msg, NET_SHAPER_A_ID, handle->id)))
>> +		goto handle_nest_cancel;
> 
> So netdev root has no id and no scope?

I don't understand the question.

The root handle has scope NETDEV and id 0, the id will not printed out 
as redundant: there is only a scope NETDEV shaper per struct net_device.

Thanks,

Paolo


