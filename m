Return-Path: <netdev+bounces-226718-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id CE96CBA4675
	for <lists+netdev@lfdr.de>; Fri, 26 Sep 2025 17:26:10 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id CE0817AD0B8
	for <lists+netdev@lfdr.de>; Fri, 26 Sep 2025 15:24:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3CFCE1FDA9E;
	Fri, 26 Sep 2025 15:26:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="qyEZYXHA"
X-Original-To: netdev@vger.kernel.org
Received: from out-180.mta0.migadu.com (out-180.mta0.migadu.com [91.218.175.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DE79A158545
	for <netdev@vger.kernel.org>; Fri, 26 Sep 2025 15:26:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.218.175.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758900365; cv=none; b=Kr7FuVJqYeF1GMX3YObjgt2rlm5l7s2jkcXJDtkPH/aY1tAukBMd218nOHhvZfB25N0N6peSoyY7t5URTQQJjYbhD3q9WQaDRUuZjaz46LqJ+XInXtbv/0mjRzZqVkyAGjHfsiT8FPBJfazQdHMa2cO4KuoEi80wvajEXyj9HpM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758900365; c=relaxed/simple;
	bh=bwkzkyipx/cP1lNRqHOo7PCoKFntTqYlPdvPG7UPBJ4=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=oEsOTGdYJQZKjhux2Z/Nd2EhxW5DJxLext0QFWhOu/nyFjLI9/Kko3mMnRpT/rOHwcCIwupcptd2q84Dvv2aNivNmJvIfZBcJFK8KXHukZ+CGRJDKietPQwn1CD2N8uTxjwWTDE6P5H4eJt54AbqPoTsC7TB/UrGfKSy4EtlOrs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=qyEZYXHA; arc=none smtp.client-ip=91.218.175.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Message-ID: <3e3742a7-5cfd-4f7c-8ca9-65b1de08ec29@linux.dev>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1758900361;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=B+eNwpJLHV0SCn7yBkAhB2wqVmm70sNmIzha4a7rhtk=;
	b=qyEZYXHA/uabRpRBi3XevWqW9KgumB2ZuDY893Jb92TOfjQxuslGz7ceS7LPg+8jPIU0Hs
	FargUEciH/I+nZc15VbeFP7HtWtR368aWhHiLSQ3XFr/omvpS7OxP8sbC6MiNE4RrX3EvW
	Pec/8eu8S9ptUBrYWbDhDMo472eclok=
Date: Fri, 26 Sep 2025 16:25:58 +0100
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Subject: Re: [PATCH net-next 2/3] dpll: add phase_offset_avg_factor_get/set
 callback ops
To: Ivan Vecera <ivecera@redhat.com>, netdev@vger.kernel.org
Cc: Arkadiusz Kubalewski <arkadiusz.kubalewski@intel.com>,
 Jiri Pirko <jiri@resnulli.us>, Jonathan Corbet <corbet@lwn.net>,
 Donald Hunter <donald.hunter@gmail.com>, Jakub Kicinski <kuba@kernel.org>,
 "David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>,
 Paolo Abeni <pabeni@redhat.com>, Simon Horman <horms@kernel.org>,
 Prathosh Satish <Prathosh.Satish@microchip.com>,
 Chuck Lever <chuck.lever@oracle.com>, linux-doc@vger.kernel.org,
 linux-kernel@vger.kernel.org, Michal Schmidt <mschmidt@redhat.com>,
 Petr Oros <poros@redhat.com>
References: <20250926142140.691592-1-ivecera@redhat.com>
 <20250926142140.691592-3-ivecera@redhat.com>
Content-Language: en-US
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Vadim Fedorenko <vadim.fedorenko@linux.dev>
In-Reply-To: <20250926142140.691592-3-ivecera@redhat.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Migadu-Flow: FLOW_OUT

On 26/09/2025 15:21, Ivan Vecera wrote:
> Add new callback operations for a dpll device:
> - phase_offset_avg_factor_get(...) - to obtain current phase offset
>    averaging factor from dpll device,
> - phase_offset_avg_factor_set(...) - to set phase offset averaging factor
> 
> Obtain the factor value using the get callback and provide it to the user
> if the device driver implements callbacks. Execute the set callback upon
> user requests.
> 
> Signed-off-by: Ivan Vecera <ivecera@redhat.com>
> ---
>   drivers/dpll/dpll_netlink.c | 76 +++++++++++++++++++++++++++++++++----
>   include/linux/dpll.h        |  6 +++
>   2 files changed, 75 insertions(+), 7 deletions(-)
> 
> diff --git a/drivers/dpll/dpll_netlink.c b/drivers/dpll/dpll_netlink.c
> index 0a852011653c4..55b3ffe08024b 100644
> --- a/drivers/dpll/dpll_netlink.c
> +++ b/drivers/dpll/dpll_netlink.c
> @@ -164,6 +164,28 @@ dpll_msg_add_phase_offset_monitor(struct sk_buff *msg, struct dpll_device *dpll,
>   	return 0;
>   }
>   
> +static int
> +dpll_msg_add_phase_offset_avg_factor(struct sk_buff *msg,
> +				     struct dpll_device *dpll,
> +				     struct netlink_ext_ack *extack)
> +{
> +	const struct dpll_device_ops *ops = dpll_device_ops(dpll);
> +	u32 factor;
> +	int ret;
> +
> +	if (ops->phase_offset_avg_factor_set &&
> +	    ops->phase_offset_avg_factor_get) {
> +		ret = ops->phase_offset_avg_factor_get(dpll, dpll_priv(dpll),
> +						       &factor, extack);

Well, correct me if I'm wrong, but the device can have offset average
factor as a constant, and it can technically report it. I would make
set/get callback optional and don't require both of them to be
implemented.


> +		if (ret)
> +			return ret;
> +		if (nla_put_u32(msg, DPLL_A_PHASE_OFFSET_AVG_FACTOR, factor))
> +			return -EMSGSIZE;
> +	}
> +
> +	return 0;
> +}
> +
>   static int
>   dpll_msg_add_lock_status(struct sk_buff *msg, struct dpll_device *dpll,
>   			 struct netlink_ext_ack *extack)
> @@ -675,6 +697,9 @@ dpll_device_get_one(struct dpll_device *dpll, struct sk_buff *msg,
>   	if (nla_put_u32(msg, DPLL_A_TYPE, dpll->type))
>   		return -EMSGSIZE;
>   	ret = dpll_msg_add_phase_offset_monitor(msg, dpll, extack);
> +	if (ret)
> +		return ret;
> +	ret = dpll_msg_add_phase_offset_avg_factor(msg, dpll, extack);
>   	if (ret)
>   		return ret;
>   
> @@ -839,6 +864,32 @@ dpll_phase_offset_monitor_set(struct dpll_device *dpll, struct nlattr *a,
>   					     extack);
>   }
>   
> +static int
> +dpll_phase_offset_avg_factor_set(struct dpll_device *dpll, struct nlattr *a,
> +				 struct netlink_ext_ack *extack)
> +{
> +	const struct dpll_device_ops *ops = dpll_device_ops(dpll);
> +	u32 factor = nla_get_u32(a), old_factor;
> +	int ret;
> +
> +	if (!(ops->phase_offset_avg_factor_set &&
> +	      ops->phase_offset_avg_factor_get)) {
> +		NL_SET_ERR_MSG_ATTR(extack, a, "dpll device not capable of phase offset averaging");
> +		return -EOPNOTSUPP;
> +	}
> +	ret = ops->phase_offset_avg_factor_get(dpll, dpll_priv(dpll),
> +					       &old_factor, extack);
> +	if (ret) {
> +		NL_SET_ERR_MSG(extack, "unable to get current phase offset averaging factor");
> +		return ret;
> +	}
> +	if (factor == old_factor)
> +		return 0;

I don't think the core should do any checks here. If the user for some
reason wants to re-install the same value - give them a chance. Some
drivers may implement check logic if it's relevant to the hardware, but
not in general.

> +
> +	return ops->phase_offset_avg_factor_set(dpll, dpll_priv(dpll), factor,
> +						extack);
> +}
> +

[...]

