Return-Path: <netdev+bounces-84999-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 2FD6C898E60
	for <lists+netdev@lfdr.de>; Thu,  4 Apr 2024 20:54:39 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 88EC628C105
	for <lists+netdev@lfdr.de>; Thu,  4 Apr 2024 18:54:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D8CF7133987;
	Thu,  4 Apr 2024 18:53:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=davidwei-uk.20230601.gappssmtp.com header.i=@davidwei-uk.20230601.gappssmtp.com header.b="a0gxONls"
X-Original-To: netdev@vger.kernel.org
Received: from mail-ot1-f42.google.com (mail-ot1-f42.google.com [209.85.210.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F32E41332A7
	for <netdev@vger.kernel.org>; Thu,  4 Apr 2024 18:53:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712256782; cv=none; b=UHqTpEOTfLQVZlIwuph69F5y8CGNkEoxYqkjc/8sH/7MF/4F60sxBU0ehWkwM9Rf+o3la4SOSoRdvVlbdIRz9aSK/1a/h++k/Vcp23Nwi6YAuxau+43OzlbQqD62IZC/yGIULkF7PZw5IYdy3H4UgOSE7XKVbgD2VgV1UiWIkX4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712256782; c=relaxed/simple;
	bh=3mYCJtTk+U2XREpvUQaPISHfL7oDcR0L+27S8gf6+34=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=V01CoTbsq8SQ9O/f1bzRziu+0EY6sOqk+Jt/9xdjAALjn/hFtuCSuk65KHtRoc8J9Tlcpqi13gC4WN6QoMnDaUVB/G8y5eDe4q8zpiv0bw2ULcDUk2r61MhGjmpRt8VGgKCnur96PrkfZRHfF1Fqy4/IeLoUrvjlzYsRCAOtG0Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=davidwei.uk; spf=none smtp.mailfrom=davidwei.uk; dkim=pass (2048-bit key) header.d=davidwei-uk.20230601.gappssmtp.com header.i=@davidwei-uk.20230601.gappssmtp.com header.b=a0gxONls; arc=none smtp.client-ip=209.85.210.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=davidwei.uk
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=davidwei.uk
Received: by mail-ot1-f42.google.com with SMTP id 46e09a7af769-6e9e1a52b74so326892a34.0
        for <netdev@vger.kernel.org>; Thu, 04 Apr 2024 11:53:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=davidwei-uk.20230601.gappssmtp.com; s=20230601; t=1712256780; x=1712861580; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=l1GMzqW+92bdQj5f6UrpjBUYhNGwDvZxpCFBiqWelrU=;
        b=a0gxONlsY3Ki0ydKBNeTNMEJrtF73P2rqxWYAylgAOzzxN99/ZGUwTH0TuLQNpb03N
         wdUwDnjucU+j3t5JtkFcfY5WrwpCssLiH0iWIErHMeU8HPPaJ7ktZFkMZVGLRx7iFqU0
         0q7qJS/XuwHDvHWNqVHLhs6fvok3MvQEa3dj2JR3Knw58ZY3pp+fEDmBtSAKwg7Pg1tT
         JaapMKidjmTM3TcE3CwPCXdvzJC7kDsa84EoZqK39mb9rAK+f2WVBIgBP22Oag7KZMRo
         5zsx0xYx2LijvAae9wD3eAXroJ8OdpxGzydKyr7ZUcwvm5UjwnS8jMKs8nPpb3bjjnFa
         JZUQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1712256780; x=1712861580;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=l1GMzqW+92bdQj5f6UrpjBUYhNGwDvZxpCFBiqWelrU=;
        b=BUUPFJrgr+L/xzhjAV16Hs3MwBtoUyTpgXEczvMwg8UM/qG3sThM0ctdc95e13VmWH
         bfZzfS7LHlfJtkyCjisueYD2WIxjfW/kz64N6ASPjZp/ClAiEz8BUlSRnv3SFRB+WvVl
         nNIVA7pxYL34Caa3pom/pD1SvhpXyBVXcnfkBaQq0A5bagSC8Fhqvog2Xo4+2iPtC6bx
         PIusVeigWvPwe5hIgOh4ERo/ajnT3jAPSb05roxN9zCSYivedTdUX1WIC3baN7ZdqZv4
         Hdv8UENZITg0NJRhbEyCIh8maq6XEHugCfbNrq48rrl2SYW5ESl7/0bIXZPkse/qBXGZ
         HCzQ==
X-Forwarded-Encrypted: i=1; AJvYcCWk8HI8xwA1cAx4mMKc12elDLeqbz9UGnFXxVqNIlvAV9IxGLLyFqrh0wK0LUoZ6uVsNuKpsoW24hMiEpxLlA2pC45/Bf5+
X-Gm-Message-State: AOJu0Yx9Kacotot51g+xtNb3s+B9y4qxK3HzOwTm2TTJx3G2MSG5Z51A
	TZbyov0r9NviyI1BhC5l/6K4N07U9V0YCUv7IusnJLhk/wyDXpwjGioRSgEizYU=
X-Google-Smtp-Source: AGHT+IExEAsG2m7NNZV24uwdfgPTNQFh9S4AbrBP3KO4AxYo0DLlu7n8gPSQXJWf2Ms6MjhwW0r+kA==
X-Received: by 2002:a05:6358:904b:b0:183:6537:8782 with SMTP id f11-20020a056358904b00b0018365378782mr3119075rwf.29.1712256779864;
        Thu, 04 Apr 2024 11:52:59 -0700 (PDT)
Received: from ?IPV6:2a03:83e0:1256:2:c51:2090:e106:83fa? ([2620:10d:c090:500::6:7e1f])
        by smtp.gmail.com with ESMTPSA id l13-20020a63da4d000000b005f3d222eb42sm4655242pgj.20.2024.04.04.11.52.58
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 04 Apr 2024 11:52:59 -0700 (PDT)
Message-ID: <5983d9e0-955b-43c9-98a1-7c770ffac7f7@davidwei.uk>
Date: Thu, 4 Apr 2024 11:52:57 -0700
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [net-next v3 1/2] devlink: Support setting max_io_eqs
Content-Language: en-GB
To: Parav Pandit <parav@nvidia.com>,
 "netdev@vger.kernel.org" <netdev@vger.kernel.org>,
 "davem@davemloft.net" <davem@davemloft.net>,
 "edumazet@google.com" <edumazet@google.com>,
 "kuba@kernel.org" <kuba@kernel.org>, "pabeni@redhat.com"
 <pabeni@redhat.com>, "corbet@lwn.net" <corbet@lwn.net>,
 "kalesh-anakkur.purayil@broadcom.com" <kalesh-anakkur.purayil@broadcom.com>
Cc: Saeed Mahameed <saeedm@nvidia.com>, "leon@kernel.org" <leon@kernel.org>,
 "jiri@resnulli.us" <jiri@resnulli.us>, Shay Drori <shayd@nvidia.com>,
 Dan Jurgens <danielj@nvidia.com>, Dima Chumak <dchumak@nvidia.com>,
 "linux-doc@vger.kernel.org" <linux-doc@vger.kernel.org>,
 "linux-rdma@vger.kernel.org" <linux-rdma@vger.kernel.org>,
 Jiri Pirko <jiri@nvidia.com>
References: <20240403174133.37587-1-parav@nvidia.com>
 <20240403174133.37587-2-parav@nvidia.com>
 <b6f1dc7a-4548-42df-99ae-596dff525226@davidwei.uk>
 <PH0PR12MB548196662E45D680214A6069DC3C2@PH0PR12MB5481.namprd12.prod.outlook.com>
 <e909bd86-a6bc-4234-b895-280cbd9d66e0@davidwei.uk>
 <PH0PR12MB54815B522DAFE87942E15825DC3C2@PH0PR12MB5481.namprd12.prod.outlook.com>
From: David Wei <dw@davidwei.uk>
In-Reply-To: <PH0PR12MB54815B522DAFE87942E15825DC3C2@PH0PR12MB5481.namprd12.prod.outlook.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 2024-04-04 11:50, Parav Pandit wrote:
> 
> 
>> From: David Wei <dw@davidwei.uk>
>> Sent: Friday, April 5, 2024 12:10 AM
>>
>> On 2024-04-04 10:58, Parav Pandit wrote:
>>> Hi David,
>>>
>>>> From: David Wei <dw@davidwei.uk>
>>>> Sent: Thursday, April 4, 2024 10:29 PM
>>>>
>>>> On 2024-04-03 10:41, Parav Pandit wrote:
>>>>> Many devices send event notifications for the IO queues, such as tx
>>>>> and rx queues, through event queues.
>>>>>
>>>>> Enable a privileged owner, such as a hypervisor PF, to set the
>>>>> number of IO event queues for the VF and SF during the provisioning
>> stage.
>>>>>
>>>>> example:
>>>>> Get maximum IO event queues of the VF device::
>>>>>
>>>>>   $ devlink port show pci/0000:06:00.0/2
>>>>>   pci/0000:06:00.0/2: type eth netdev enp6s0pf0vf1 flavour pcivf
>>>>> pfnum 0
>>>> vfnum 1
>>>>>       function:
>>>>>           hw_addr 00:00:00:00:00:00 ipsec_packet disabled max_io_eqs
>>>>> 10
>>>>>
>>>>> Set maximum IO event queues of the VF device::
>>>>>
>>>>>   $ devlink port function set pci/0000:06:00.0/2 max_io_eqs 32
>>>>>
>>>>>   $ devlink port show pci/0000:06:00.0/2
>>>>>   pci/0000:06:00.0/2: type eth netdev enp6s0pf0vf1 flavour pcivf
>>>>> pfnum 0
>>>> vfnum 1
>>>>>       function:
>>>>>           hw_addr 00:00:00:00:00:00 ipsec_packet disabled max_io_eqs
>>>>> 32
>>>>>
>>>>> Reviewed-by: Jiri Pirko <jiri@nvidia.com>
>>>>> Reviewed-by: Shay Drory <shayd@nvidia.com>
>>>>> Signed-off-by: Parav Pandit <parav@nvidia.com>
>>>>> ---
>>>>> changelog:
>>>>> v2->v3:
>>>>> - limited 80 chars per line
>>>>> v1->v2:
>>>>> - limited comment to 80 chars per line in header file
>>>>> ---
>>>>>  .../networking/devlink/devlink-port.rst       | 25 +++++++++
>>>>>  include/net/devlink.h                         | 14 +++++
>>>>>  include/uapi/linux/devlink.h                  |  1 +
>>>>>  net/devlink/port.c                            | 53 +++++++++++++++++++
>>>>>  4 files changed, 93 insertions(+)
>>>>>
>>>>> diff --git a/Documentation/networking/devlink/devlink-port.rst
>>>>> b/Documentation/networking/devlink/devlink-port.rst
>>>>> index 562f46b41274..451f57393f11 100644
>>>>> --- a/Documentation/networking/devlink/devlink-port.rst
>>>>> +++ b/Documentation/networking/devlink/devlink-port.rst
>>>>> @@ -134,6 +134,9 @@ Users may also set the IPsec crypto capability
>>>>> of the function using  Users may also set the IPsec packet
>>>>> capability of the function using  `devlink port function set ipsec_packet`
>> command.
>>>>>
>>>>> +Users may also set the maximum IO event queues of the function
>>>>> +using `devlink port function set max_io_eqs` command.
>>>>> +
>>>>>  Function attributes
>>>>>  ===================
>>>>>
>>>>> @@ -295,6 +298,28 @@ policy is processed in software by the kernel.
>>>>>          function:
>>>>>              hw_addr 00:00:00:00:00:00 ipsec_packet enabled
>>>>>
>>>>> +Maximum IO events queues setup
>>>>> +------------------------------
>>>>> +When user sets maximum number of IO event queues for a SF or a VF,
>>>>> +such function driver is limited to consume only enforced number of
>>>>> +IO event queues.
>>>>> +
>>>>> +- Get maximum IO event queues of the VF device::
>>>>> +
>>>>> +    $ devlink port show pci/0000:06:00.0/2
>>>>> +    pci/0000:06:00.0/2: type eth netdev enp6s0pf0vf1 flavour pcivf
>>>>> + pfnum
>>>> 0 vfnum 1
>>>>> +        function:
>>>>> +            hw_addr 00:00:00:00:00:00 ipsec_packet disabled
>>>>> + max_io_eqs 10
>>>>> +
>>>>> +- Set maximum IO event queues of the VF device::
>>>>> +
>>>>> +    $ devlink port function set pci/0000:06:00.0/2 max_io_eqs 32
>>>>> +
>>>>> +    $ devlink port show pci/0000:06:00.0/2
>>>>> +    pci/0000:06:00.0/2: type eth netdev enp6s0pf0vf1 flavour pcivf
>>>>> + pfnum
>>>> 0 vfnum 1
>>>>> +        function:
>>>>> +            hw_addr 00:00:00:00:00:00 ipsec_packet disabled
>>>>> + max_io_eqs 32
>>>>> +
>>>>>  Subfunction
>>>>>  ============
>>>>>
>>>>> diff --git a/include/net/devlink.h b/include/net/devlink.h index
>>>>> 9ac394bdfbe4..bb1af599d101 100644
>>>>> --- a/include/net/devlink.h
>>>>> +++ b/include/net/devlink.h
>>>>> @@ -1602,6 +1602,14 @@ void devlink_free(struct devlink *devlink);
>>>>>   *			      capability. Should be used by device drivers to
>>>>>   *			      enable/disable ipsec_packet capability of a
>>>>>   *			      function managed by the devlink port.
>>>>> + * @port_fn_max_io_eqs_get: Callback used to get port function's
>>>> maximum number
>>>>> + *			    of event queues. Should be used by device drivers
>>>> to
>>>>> + *			    report the maximum event queues of a function
>>>>> + *			    managed by the devlink port.
>>>>> + * @port_fn_max_io_eqs_set: Callback used to set port function's
>>>> maximum number
>>>>> + *			    of event queues. Should be used by device drivers
>>>> to
>>>>> + *			    configure maximum number of event queues
>>>>> + *			    of a function managed by the devlink port.
>>>>>   *
>>>>>   * Note: Driver should return -EOPNOTSUPP if it doesn't support
>>>>>   * port function (@port_fn_*) handling for a particular port.
>>>>> @@ -1651,6 +1659,12 @@ struct devlink_port_ops {
>>>>>  	int (*port_fn_ipsec_packet_set)(struct devlink_port *devlink_port,
>>>>>  					bool enable,
>>>>>  					struct netlink_ext_ack *extack);
>>>>> +	int (*port_fn_max_io_eqs_get)(struct devlink_port *devlink_port,
>>>>> +				      u32 *max_eqs,
>>>>> +				      struct netlink_ext_ack *extack);
>>>>> +	int (*port_fn_max_io_eqs_set)(struct devlink_port *devlink_port,
>>>>> +				      u32 max_eqs,
>>>>> +				      struct netlink_ext_ack *extack);
>>>>>  };
>>>>>
>>>>>  void devlink_port_init(struct devlink *devlink, diff --git
>>>>> a/include/uapi/linux/devlink.h b/include/uapi/linux/devlink.h index
>>>>> 2da0c7eb6710..9401aa343673 100644
>>>>> --- a/include/uapi/linux/devlink.h
>>>>> +++ b/include/uapi/linux/devlink.h
>>>>> @@ -686,6 +686,7 @@ enum devlink_port_function_attr {
>>>>>  	DEVLINK_PORT_FN_ATTR_OPSTATE,	/* u8 */
>>>>>  	DEVLINK_PORT_FN_ATTR_CAPS,	/* bitfield32 */
>>>>>  	DEVLINK_PORT_FN_ATTR_DEVLINK,	/* nested */
>>>>> +	DEVLINK_PORT_FN_ATTR_MAX_IO_EQS,	/* u32 */
>>>>>
>>>>>  	__DEVLINK_PORT_FUNCTION_ATTR_MAX,
>>>>>  	DEVLINK_PORT_FUNCTION_ATTR_MAX =
>>>> __DEVLINK_PORT_FUNCTION_ATTR_MAX -
>>>>> 1 diff --git a/net/devlink/port.c b/net/devlink/port.c index
>>>>> 118d130d2afd..be9158b4453c 100644
>>>>> --- a/net/devlink/port.c
>>>>> +++ b/net/devlink/port.c
>>>>> @@ -16,6 +16,7 @@ static const struct nla_policy
>>>> devlink_function_nl_policy[DEVLINK_PORT_FUNCTION_
>>>>>  				 DEVLINK_PORT_FN_STATE_ACTIVE),
>>>>>  	[DEVLINK_PORT_FN_ATTR_CAPS] =
>>>>>
>>>> 	NLA_POLICY_BITFIELD32(DEVLINK_PORT_FN_CAPS_VALID_MASK),
>>>>> +	[DEVLINK_PORT_FN_ATTR_MAX_IO_EQS] = { .type = NLA_U32 },
>>>>>  };
>>>>>
>>>>>  #define ASSERT_DEVLINK_PORT_REGISTERED(devlink_port)
>>>> 		\
>>>>> @@ -182,6 +183,30 @@ static int devlink_port_fn_caps_fill(struct
>>>> devlink_port *devlink_port,
>>>>>  	return 0;
>>>>>  }
>>>>>
>>>>> +static int devlink_port_fn_max_io_eqs_fill(struct devlink_port *port,
>>>>> +					   struct sk_buff *msg,
>>>>> +					   struct netlink_ext_ack *extack,
>>>>> +					   bool *msg_updated)
>>>>> +{
>>>>> +	u32 max_io_eqs;
>>>>> +	int err;
>>>>> +
>>>>> +	if (!port->ops->port_fn_max_io_eqs_get)
>>>>> +		return 0;
>>>>> +
>>>>> +	err = port->ops->port_fn_max_io_eqs_get(port, &max_io_eqs,
>>>> extack);
>>>>> +	if (err) {
>>>>> +		if (err == -EOPNOTSUPP)
>>>>> +			return 0;
>>>>
>>>> Docs above says:
>>>>    * Note: Driver should return -EOPNOTSUPP if it doesn't support
>>>>    * port function (@port_fn_*) handling for a particular port.
>>>>
>>>> But here you're returning 0 in both cases of no
>>>> port_fn_max_io_eqs_get or
>>>> port_fn_max_io_eqs_get() returns EOPNOTSUPP.
>>>>
>>> When the port does not support this op, the function pointer is null and, 0
>> is returned as expected.
>>>
>>> When the port for some reason has the ops function pointer set for a port,
>> but if the port does not support the ops, it will return ENOPNOTSUPP.
>>> This may be possible when the driver has chosen to use same ops callback
>> structure for multiple port flavors.
>>>
>>> This code pattern is likely left over code of relatively recent work that
>> moved ops from devlink instance to per port ops.
>>> I propose to keep the current check as done in this patch, and run a
>>> full audit of all the drivers, if all drivers have moved to per port ops, then
>> simplify the code to drop the check for EOPNOTSUPP in a new series that
>> may touch more drivers.
>>> Otherwise, we may end up failing the port show operation when it returns
>> - ENOPNOTSUPP.
>>
>> Thanks for the explanation. So ideally each port flavour has its own unique
>> set of struct ops, and if something is not supported then don't set the func
>> ptr in the struct ops.
>>
>> Yes, I see that 0 has to be returned for devlink_port_fn_caps_fill() to succeed.
>>
>> Had a brief look and there's only a handful of drivers (mlx, nfp, ice) that use
>> devlink_port_ops.
>>
> And netdevsim too. :)
> Can we please the cleanup in a separate series?
> Post this may be later in the month, I may have cycles to audit and simplify.
> Would it be ok with you?

Yeah of course, thanks. I'm making some changes in netdevsim and can do
a drive-by cleanup there too.

>  
>>>
>>>>> +		return err;
>>>>> +	}
>>>>> +	err = nla_put_u32(msg, DEVLINK_PORT_FN_ATTR_MAX_IO_EQS,
>>>> max_io_eqs);
>>>>> +	if (err)
>>>>> +		return err;
>>>>> +	*msg_updated = true;
>>>>> +	return 0;
>>>>> +}
>>>>> +
>>>>>  int devlink_nl_port_handle_fill(struct sk_buff *msg, struct
>>>>> devlink_port *devlink_port)  {
>>>>>  	if (devlink_nl_put_handle(msg, devlink_port->devlink)) @@ -409,6
>>>>> +434,18 @@ static int devlink_port_fn_caps_set(struct devlink_port
>>>> *devlink_port,
>>>>>  	return 0;
>>>>>  }
>>>>>
>>>>> +static int
>>>>> +devlink_port_fn_max_io_eqs_set(struct devlink_port *devlink_port,
>>>>> +			       const struct nlattr *attr,
>>>>> +			       struct netlink_ext_ack *extack) {
>>>>> +	u32 max_io_eqs;
>>>>> +
>>>>> +	max_io_eqs = nla_get_u32(attr);
>>>>> +	return devlink_port->ops->port_fn_max_io_eqs_set(devlink_port,
>>>>> +							 max_io_eqs, extack);
>>>>> +}
>>>>> +
>>>>>  static int
>>>>>  devlink_nl_port_function_attrs_put(struct sk_buff *msg, struct
>>>> devlink_port *port,
>>>>>  				   struct netlink_ext_ack *extack) @@ -428,6
>>>> +465,9 @@
>>>>> devlink_nl_port_function_attrs_put(struct sk_buff *msg, struct
>>>> devlink_port *por
>>>>>  	if (err)
>>>>>  		goto out;
>>>>>  	err = devlink_port_fn_state_fill(port, msg, extack, &msg_updated);
>>>>> +	if (err)
>>>>> +		goto out;
>>>>> +	err = devlink_port_fn_max_io_eqs_fill(port, msg, extack,
>>>>> +&msg_updated);
>>>>>  	if (err)
>>>>>  		goto out;
>>>>>  	err = devlink_rel_devlink_handle_put(msg, port->devlink, @@ -726,6
>>>>> +766,12 @@ static int devlink_port_function_validate(struct
>>>>> +devlink_port
>>>> *devlink_port,
>>>>>  			}
>>>>>  		}
>>>>>  	}
>>>>> +	if (tb[DEVLINK_PORT_FN_ATTR_MAX_IO_EQS] &&
>>>>> +	    !ops->port_fn_max_io_eqs_set) {
>>>>> +		NL_SET_ERR_MSG_ATTR(extack,
>>>> tb[DEVLINK_PORT_FN_ATTR_MAX_IO_EQS],
>>>>> +				    "Function does not support max_io_eqs
>>>> setting");
>>>>> +		return -EOPNOTSUPP;
>>>>> +	}
>>>>>  	return 0;
>>>>>  }
>>>>>
>>>>> @@ -761,6 +807,13 @@ static int devlink_port_function_set(struct
>>>> devlink_port *port,
>>>>>  			return err;
>>>>>  	}
>>>>>
>>>>> +	attr = tb[DEVLINK_PORT_FN_ATTR_MAX_IO_EQS];
>>>>> +	if (attr) {
>>>>> +		err = devlink_port_fn_max_io_eqs_set(port, attr, extack);
>>>>> +		if (err)
>>>>> +			return err;
>>>>> +	}
>>>>> +
>>>>>  	/* Keep this as the last function attribute set, so that when
>>>>>  	 * multiple port function attributes are set along with state,
>>>>>  	 * Those can be applied first before activating the state.

