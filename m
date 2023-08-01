Return-Path: <netdev+bounces-23304-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 241CD76B847
	for <lists+netdev@lfdr.de>; Tue,  1 Aug 2023 17:12:41 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 53BCD1C20F49
	for <lists+netdev@lfdr.de>; Tue,  1 Aug 2023 15:12:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D3E134DC87;
	Tue,  1 Aug 2023 15:12:37 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C8B074DC83
	for <netdev@vger.kernel.org>; Tue,  1 Aug 2023 15:12:37 +0000 (UTC)
X-Greylist: delayed 91605 seconds by postgrey-1.37 at lindbergh.monkeyblade.net; Tue, 01 Aug 2023 08:12:35 PDT
Received: from out-77.mta1.migadu.com (out-77.mta1.migadu.com [IPv6:2001:41d0:203:375::4d])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 82C5A1B1
	for <netdev@vger.kernel.org>; Tue,  1 Aug 2023 08:12:35 -0700 (PDT)
Message-ID: <092b8bd3-e24d-4be2-0a7d-22b845ba069a@linux.dev>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1690902753;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=FN9V8XQ7ny8iOhMwulo6jvLHZzXxY6GfaAvXHYKvoZs=;
	b=Up6YV6vXulLtFQflo/SJ44XC+vBzvR3hbWWVaqRdN4mVbN0QSC61YLYuYoJgkqtLNAqWcG
	1CTOjmlCkGYQfveAupmZEuP3TveUMk/fBzxm8lUuRnC6zbCt3eEbNz98mExwsVpxYcne4T
	uB5+E+C1mbde1Te843Z6MzzAUuHvduk=
Date: Tue, 1 Aug 2023 16:12:27 +0100
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Subject: Re: [PATCH net-next 07/11] netdev: expose DPLL pin handle for
 netdevice
Content-Language: en-US
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Vadim Fedorenko <vadim.fedorenko@linux.dev>
To: Jiri Pirko <jiri@resnulli.us>, Jiri Pirko <jiri@nvidia.com>
Cc: Milena Olech <milena.olech@intel.com>,
 Michal Michalik <michal.michalik@intel.com>,
 linux-arm-kernel@lists.infradead.org, poros@redhat.com, mschmidt@redhat.com,
 netdev@vger.kernel.org, linux-clk@vger.kernel.org,
 Bart Van Assche <bvanassche@acm.org>, Jakub Kicinski <kuba@kernel.org>,
 Arkadiusz Kubalewski <arkadiusz.kubalewski@intel.com>,
 Paolo Abeni <pabeni@redhat.com>, Jonathan Lemon <jonathan.lemon@gmail.com>
References: <20230720091903.297066-1-vadim.fedorenko@linux.dev>
 <20230720091903.297066-8-vadim.fedorenko@linux.dev>
 <4f2e91c7-e2e8-6b3a-fc14-8f44503fb6be@linux.dev>
In-Reply-To: <4f2e91c7-e2e8-6b3a-fc14-8f44503fb6be@linux.dev>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Migadu-Flow: FLOW_OUT
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,SPF_PASS,
	T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

On 01/08/2023 14:23, Vadim Fedorenko wrote:
> On 20/07/2023 10:18, Vadim Fedorenko wrote:
>> From: Jiri Pirko <jiri@nvidia.com>
>>
>> In case netdevice represents a SyncE port, the user needs to understand
>> the connection between netdevice and associated DPLL pin. There might me
>> multiple netdevices pointing to the same pin, in case of VF/SF
>> implementation.
>>
>> Add a IFLA Netlink attribute to nest the DPLL pin handle, similar to
>> how it is implemented for devlink port. Add a struct dpll_pin pointer
>> to netdev and protect access to it by RTNL. Expose netdev_dpll_pin_set()
>> and netdev_dpll_pin_clear() helpers to the drivers so they can set/clear
>> the DPLL pin relationship to netdev.
>>
>> Note that during the lifetime of struct dpll_pin the pin handle does not
>> change. Therefore it is save to access it lockless. It is drivers
>> responsibility to call netdev_dpll_pin_clear() before dpll_pin_put().
>>
>> Signed-off-by: Jiri Pirko <jiri@nvidia.com>
>> Signed-off-by: Arkadiusz Kubalewski <arkadiusz.kubalewski@intel.com>
>> Signed-off-by: Vadim Fedorenko <vadim.fedorenko@linux.dev>
>> ---
>> RFC v9->v0:
>> - rearrange function definition according to usage
>> v8->v9:
>> - net_device->dpll_pin is only valid if IS_ENABLED(CONFIG_DPLL) fix the
>>    code in net/core/rtnetlink.c to respect that.
>> - move dpll_msg_add_pin_handle to "dpll: netlink" patch + export the
>>    function with this patch
>>
>>   drivers/dpll/dpll_netlink.c  | 19 ++++++++++++++++---
>>   include/linux/dpll.h         | 20 ++++++++++++++++++++
>>   include/linux/netdevice.h    | 20 ++++++++++++++++++++
>>   include/uapi/linux/if_link.h |  2 ++
>>   net/core/dev.c               | 22 ++++++++++++++++++++++
>>   net/core/rtnetlink.c         | 35 +++++++++++++++++++++++++++++++++++
>>   6 files changed, 115 insertions(+), 3 deletions(-)
>>
>> diff --git a/drivers/dpll/dpll_netlink.c b/drivers/dpll/dpll_netlink.c
>> index c44dda78737d..e4a9bd767b92 100644
>> --- a/drivers/dpll/dpll_netlink.c
>> +++ b/drivers/dpll/dpll_netlink.c
>> @@ -37,6 +37,18 @@ dpll_msg_add_dev_handle(struct sk_buff *msg, struct 
>> dpll_device *dpll)
>>       return 0;
>>   }
>> +/**
>> + * dpll_msg_pin_handle_size - get size of pin handle attribute for 
>> given pin
>> + * @pin: pin pointer
>> + *
>> + * Return: byte size of pin handle attribute for given pin.
>> + */
>> +size_t dpll_msg_pin_handle_size(struct dpll_pin *pin)
>> +{
>> +    return pin ? nla_total_size(4) : 0; /* DPLL_A_PIN_ID */
>> +}
>> +EXPORT_SYMBOL_GPL(dpll_msg_pin_handle_size);
>> +
>>   /**
>>    * dpll_msg_add_pin_handle - attach pin handle attribute to a given 
>> message
>>    * @msg: pointer to sk_buff message to attach a pin handle
>> @@ -54,6 +66,7 @@ int dpll_msg_add_pin_handle(struct sk_buff *msg, 
>> struct dpll_pin *pin)
>>           return -EMSGSIZE;
>>       return 0;
>>   }
>> +EXPORT_SYMBOL_GPL(dpll_msg_add_pin_handle);
> 
> Jiri, could you please remind me what is the reason to export this 
> function? Because I cannot
> any usage of this function in drivers.
> 

Ah, found it, sorry for the noise.

> 
> [....]


