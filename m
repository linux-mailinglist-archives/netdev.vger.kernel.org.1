Return-Path: <netdev+bounces-55866-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id F0C0180C92A
	for <lists+netdev@lfdr.de>; Mon, 11 Dec 2023 13:13:59 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id DF06F1C20F17
	for <lists+netdev@lfdr.de>; Mon, 11 Dec 2023 12:13:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E3C9E3985E;
	Mon, 11 Dec 2023 12:13:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="KUCBgbmD"
X-Original-To: netdev@vger.kernel.org
Received: from out-186.mta0.migadu.com (out-186.mta0.migadu.com [IPv6:2001:41d0:1004:224b::ba])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AE1809B
	for <netdev@vger.kernel.org>; Mon, 11 Dec 2023 04:13:50 -0800 (PST)
Message-ID: <936d6f77-a36a-466c-9ca6-99da8feb5e2e@linux.dev>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1702296828;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=Jm1pg7Z8VtSQ4x24bAoDdq1mHtt6XR6SaNfnCMEe6MM=;
	b=KUCBgbmD57K0bbxsVWA4CqUEihZkaOFTB14i0piVofDzYP91xKqvXZQjw3kN8/hNWgqK4x
	jKmlHgOHJTIlnBNDDMUOsdLKGFKXXSS1KQA+CrrWOYLDlWEzunrlBWYngjjND072dBRzDG
	QsaicQRHXd5LMWpuQPLNdVjceDjcT5o=
Date: Mon, 11 Dec 2023 12:13:44 +0000
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Subject: Re: [patch net] dpll: sanitize possible null pointer dereference in
 dpll_pin_parent_pin_set()
Content-Language: en-US
To: Jiri Pirko <jiri@resnulli.us>
Cc: netdev@vger.kernel.org, kuba@kernel.org, pabeni@redhat.com,
 davem@davemloft.net, edumazet@google.com, arkadiusz.kubalewski@intel.com,
 gregkh@linuxfoundation.org, hdthky0@gmail.com, michal.michalik@intel.com,
 milena.olech@intel.com
References: <20231211083758.1082853-1-jiri@resnulli.us>
 <ffd827e6-95ed-4d96-b5ad-ec1f5b8d4e24@linux.dev>
 <ZXb10Wdef76u2xBy@nanopsycho>
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Vadim Fedorenko <vadim.fedorenko@linux.dev>
In-Reply-To: <ZXb10Wdef76u2xBy@nanopsycho>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Migadu-Flow: FLOW_OUT

On 11/12/2023 11:43, Jiri Pirko wrote:
> Mon, Dec 11, 2023 at 11:46:24AM CET, vadim.fedorenko@linux.dev wrote:
>> On 11/12/2023 08:37, Jiri Pirko wrote:
>>> From: Jiri Pirko <jiri@nvidia.com>
>>>
>>> User may not pass DPLL_A_PIN_STATE attribute in the pin set operation
>>> message. Sanitize that by checking if the attr pointer is not null
>>> and process the passed state attribute value only in that case.
>>>
>>> Reported-by: Xingyuan Mo <hdthky0@gmail.com>
>>> Fixes: 9d71b54b65b1 ("dpll: netlink: Add DPLL framework base functions")
>>> Signed-off-by: Jiri Pirko <jiri@nvidia.com>
>>> ---
>>>    drivers/dpll/dpll_netlink.c | 13 ++++++++-----
>>>    1 file changed, 8 insertions(+), 5 deletions(-)
>>>
>>> diff --git a/drivers/dpll/dpll_netlink.c b/drivers/dpll/dpll_netlink.c
>>> index 442a0ebeb953..ce7cf736f020 100644
>>> --- a/drivers/dpll/dpll_netlink.c
>>> +++ b/drivers/dpll/dpll_netlink.c
>>> @@ -925,7 +925,6 @@ dpll_pin_parent_pin_set(struct dpll_pin *pin, struct nlattr *parent_nest,
>>>    			struct netlink_ext_ack *extack)
>>>    {
>>>    	struct nlattr *tb[DPLL_A_PIN_MAX + 1];
>>> -	enum dpll_pin_state state;
>>>    	u32 ppin_idx;
>>>    	int ret;
>>> @@ -936,10 +935,14 @@ dpll_pin_parent_pin_set(struct dpll_pin *pin, struct nlattr *parent_nest,
>>>    		return -EINVAL;
>>>    	}
>>>    	ppin_idx = nla_get_u32(tb[DPLL_A_PIN_PARENT_ID]);
>>> -	state = nla_get_u32(tb[DPLL_A_PIN_STATE]);
>>> -	ret = dpll_pin_on_pin_state_set(pin, ppin_idx, state, extack);
>>> -	if (ret)
>>> -		return ret;
>>> +
>>> +	if (tb[DPLL_A_PIN_STATE]) {
>>> +		enum dpll_pin_state state = nla_get_u32(tb[DPLL_A_PIN_STATE]);
>>> +
>>> +		ret = dpll_pin_on_pin_state_set(pin, ppin_idx, state, extack);
>>> +		if (ret)
>>> +			return ret;
>>> +	}
>>>    	return 0;
>>>    }
>>
>> I don't believe that "set" command without set value should return 0
>> meaning "request was completed successfully". Maybe it's better to add
>> another check like for DPLL_A_PIN_PARENT_ID and fill extack with
>> description?
> 
> Please see dpll_pin_parent_device_set(). State here is treated exactly
> the same as there. It makes sense during set operation to process only
> the attributes that are passed. In the future, dpll_pin_parent_pin_set()
> can process more attributes, lets be prepared for that.

Ok, let's be ready.

Acked-by: Vadim Fedorenko <vadim.fedorenko@linux.dev>

