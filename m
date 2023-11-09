Return-Path: <netdev+bounces-46817-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 129B37E68F5
	for <lists+netdev@lfdr.de>; Thu,  9 Nov 2023 11:56:37 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 69BF8280FC6
	for <lists+netdev@lfdr.de>; Thu,  9 Nov 2023 10:56:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C834211198;
	Thu,  9 Nov 2023 10:56:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="mV7VaOAq"
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1DD96111AC
	for <netdev@vger.kernel.org>; Thu,  9 Nov 2023 10:56:32 +0000 (UTC)
Received: from out-180.mta1.migadu.com (out-180.mta1.migadu.com [IPv6:2001:41d0:203:375::b4])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7A43D2702
	for <netdev@vger.kernel.org>; Thu,  9 Nov 2023 02:56:31 -0800 (PST)
Message-ID: <8b6e3211-3f03-4c17-b0cb-26175bf42213@linux.dev>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1699527389;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=qeGPk+gHl3P2I4ggBJdkdrzbLjLy+IO5lnTNjhclVpc=;
	b=mV7VaOAqZQS5RO3EyWeQt/hokUUTdiHfq7bwsraAmdA0h9vJFoa5cl40puD7GbSyQCI6za
	72zI9ZiEQMWMQLXgrTDgcLFDhOBFC7fdNXyWCka1/csHCm43rDXM6mMkAWVSkwzakJ9nt4
	OPdDBLdNg3RyjVhvDHn4dRk69brJSYE=
Date: Thu, 9 Nov 2023 10:56:26 +0000
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Subject: Re: [PATCH net 3/3] dpll: fix register pin with unregistered parent
 pin
Content-Language: en-US
To: "Kubalewski, Arkadiusz" <arkadiusz.kubalewski@intel.com>,
 Jiri Pirko <jiri@resnulli.us>
Cc: "netdev@vger.kernel.org" <netdev@vger.kernel.org>,
 "Michalik, Michal" <michal.michalik@intel.com>,
 "Olech, Milena" <milena.olech@intel.com>,
 "pabeni@redhat.com" <pabeni@redhat.com>, "kuba@kernel.org" <kuba@kernel.org>
References: <20231108103226.1168500-1-arkadiusz.kubalewski@intel.com>
 <20231108103226.1168500-4-arkadiusz.kubalewski@intel.com>
 <ZUukPbTCww26jltC@nanopsycho>
 <DM6PR11MB46572BD8C43DACA0FF15C2CF9BAFA@DM6PR11MB4657.namprd11.prod.outlook.com>
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Vadim Fedorenko <vadim.fedorenko@linux.dev>
In-Reply-To: <DM6PR11MB46572BD8C43DACA0FF15C2CF9BAFA@DM6PR11MB4657.namprd11.prod.outlook.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Migadu-Flow: FLOW_OUT

On 09/11/2023 09:59, Kubalewski, Arkadiusz wrote:
>> From: Jiri Pirko <jiri@resnulli.us>
>> Sent: Wednesday, November 8, 2023 4:08 PM
>>
>> Wed, Nov 08, 2023 at 11:32:26AM CET, arkadiusz.kubalewski@intel.com wrote:
>>> In case of multiple kernel module instances using the same dpll device:
>>> if only one registers dpll device, then only that one can register
>>
>> They why you don't register in multiple instances? See mlx5 for a
>> reference.
>>
> 
> Every registration requires ops, but for our case only PF0 is able to
> control dpll pins and device, thus only this can provide ops.
> Basically without PF0, dpll is not able to be controlled, as well
> as directly connected pins.
> 
But why do you need other pins then, if FP0 doesn't exist?

>>
>>> directly connected pins with a dpll device. If unregistered parent
>>> determines if the muxed pin can be register with it or not, it forces
>>> serialized driver load order - first the driver instance which
>>> registers the direct pins needs to be loaded, then the other instances
>>> could register muxed type pins.
>>>
>>> Allow registration of a pin with a parent even if the parent was not
>>> yet registered, thus allow ability for unserialized driver instance
>>
>> Weird.
>>
> 
> Yeah, this is issue only for MUX/parent pin part, couldn't find better
> way, but it doesn't seem to break things around..
> 

I just wonder how do you see the registration procedure? How can parent
pin exist if it's not registered? I believe you cannot get it through
DPLL API, then the only possible way is to create it within the same
driver code, which can be simply re-arranged. Am I wrong here?

> Thank you!
> Arkadiusz
> 
>>
>>> load order.
>>> Do not WARN_ON notification for unregistered pin, which can be invoked
>>> for described case, instead just return error.
>>>
>>> Fixes: 9431063ad323 ("dpll: core: Add DPLL framework base functions")
>>> Fixes: 9d71b54b65b1 ("dpll: netlink: Add DPLL framework base
>>> functions")
>>> Signed-off-by: Arkadiusz Kubalewski <arkadiusz.kubalewski@intel.com>
>>> ---
>>> drivers/dpll/dpll_core.c    | 4 ----
>>> drivers/dpll/dpll_netlink.c | 2 +-
>>> 2 files changed, 1 insertion(+), 5 deletions(-)
>>>
>>> diff --git a/drivers/dpll/dpll_core.c b/drivers/dpll/dpll_core.c index
>>> 4077b562ba3b..ae884b92d68c 100644
>>> --- a/drivers/dpll/dpll_core.c
>>> +++ b/drivers/dpll/dpll_core.c
>>> @@ -28,8 +28,6 @@ static u32 dpll_xa_id;
>>> 	WARN_ON_ONCE(!xa_get_mark(&dpll_device_xa, (d)->id, DPLL_REGISTERED))
>>> #define ASSERT_DPLL_NOT_REGISTERED(d)	\
>>> 	WARN_ON_ONCE(xa_get_mark(&dpll_device_xa, (d)->id, DPLL_REGISTERED))
>>> -#define ASSERT_PIN_REGISTERED(p)	\
>>> -	WARN_ON_ONCE(!xa_get_mark(&dpll_pin_xa, (p)->id, DPLL_REGISTERED))
>>>
>>> struct dpll_device_registration {
>>> 	struct list_head list;
>>> @@ -641,8 +639,6 @@ int dpll_pin_on_pin_register(struct dpll_pin *parent,
>> struct dpll_pin *pin,
>>> 	    WARN_ON(!ops->state_on_pin_get) ||
>>> 	    WARN_ON(!ops->direction_get))
>>> 		return -EINVAL;
>>> -	if (ASSERT_PIN_REGISTERED(parent))
>>> -		return -EINVAL;
>>>
>>> 	mutex_lock(&dpll_lock);
>>> 	ret = dpll_xa_ref_pin_add(&pin->parent_refs, parent, ops, priv); diff
>>> --git a/drivers/dpll/dpll_netlink.c b/drivers/dpll/dpll_netlink.c index
>>> 963bbbbe6660..ff430f43304f 100644
>>> --- a/drivers/dpll/dpll_netlink.c
>>> +++ b/drivers/dpll/dpll_netlink.c
>>> @@ -558,7 +558,7 @@ dpll_pin_event_send(enum dpll_cmd event, struct
>> dpll_pin *pin)
>>> 	int ret = -ENOMEM;
>>> 	void *hdr;
>>>
>>> -	if (WARN_ON(!xa_get_mark(&dpll_pin_xa, pin->id, DPLL_REGISTERED)))
>>> +	if (!xa_get_mark(&dpll_pin_xa, pin->id, DPLL_REGISTERED))
>>> 		return -ENODEV;
>>>
>>> 	msg = genlmsg_new(NLMSG_GOODSIZE, GFP_KERNEL);
>>> --
>>> 2.38.1
>>>


