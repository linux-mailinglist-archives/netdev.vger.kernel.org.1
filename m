Return-Path: <netdev+bounces-133709-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id B9E1A996C16
	for <lists+netdev@lfdr.de>; Wed,  9 Oct 2024 15:33:33 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 46E53B27352
	for <lists+netdev@lfdr.de>; Wed,  9 Oct 2024 13:33:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 74762196C86;
	Wed,  9 Oct 2024 13:33:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="M94rIV8+"
X-Original-To: netdev@vger.kernel.org
Received: from out-178.mta0.migadu.com (out-178.mta0.migadu.com [91.218.175.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E938F192583
	for <netdev@vger.kernel.org>; Wed,  9 Oct 2024 13:33:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.218.175.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728480804; cv=none; b=oV3h5Dm0UCf9mUfda70KVvxwWEFze77QsVVU5UOI6HyP9Kb9x21yHtwgNOo/XXRnECcb7TeBcQqeOT/swSouvqJr+dkQyA3tb+XtAFPpLWhmZjipOaiBq/GGkwFY+t6ihLILLoimzzH4JMplEW9nBmqavDJTLMVtF4cDNEvMoJA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728480804; c=relaxed/simple;
	bh=t8Gyvp201gdH0ebX64mK9PMksGJURSETiT+yOjwOA5k=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=N9qvYbQcRs8Xh0f7y3/ZwMdshDIhPuFXwiIk92niRTWspWCzTKb4ubuqAZPKukp3nwBQTvq4nMRYGGFRyYOsd9ZG2R9dbvHclwjrZ92t7sqiwiDgFJzCPaErHmXZeGP9zKxb2gjSSFrQAcD97omwC1IO1dlI98qme3HxqWZ+rFc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=M94rIV8+; arc=none smtp.client-ip=91.218.175.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Message-ID: <0655aa46-498d-4e8e-be6c-be5fb630c006@linux.dev>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1728480800;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=EVKhJGKvz5hRymisvRJ+RIKCkrs+zd8FmINE0LaAFfk=;
	b=M94rIV8+pcFydCmphAJD/NW0deCbtW8Sqg6rhbY7ww4n8xbxxBTPbptFHORrARWl7V8nxu
	k+cJPWG7WSdfD+bQEZknC5MDnViMRfm4KHDPi0qsrLwdAuNQek6SyPLpzWKWaGU/kkAID5
	nt3i2ydRt+x88+Qf6ZdZV686DpMSB1Q=
Date: Wed, 9 Oct 2024 14:33:13 +0100
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Subject: Re: [PATCH net-next 1/2] dpll: add clock quality level attribute and
 op
To: Jiri Pirko <jiri@resnulli.us>, netdev@vger.kernel.org,
 Maciek Machnikowski <maciek@machnikowski.net>
Cc: davem@davemloft.net, edumazet@google.com, kuba@kernel.org,
 pabeni@redhat.com, donald.hunter@gmail.com, arkadiusz.kubalewski@intel.com,
 saeedm@nvidia.com, leon@kernel.org, tariqt@nvidia.com
References: <20241009122547.296829-1-jiri@resnulli.us>
 <20241009122547.296829-2-jiri@resnulli.us>
Content-Language: en-US
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Vadim Fedorenko <vadim.fedorenko@linux.dev>
In-Reply-To: <20241009122547.296829-2-jiri@resnulli.us>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Migadu-Flow: FLOW_OUT

On 09/10/2024 13:25, Jiri Pirko wrote:
> From: Jiri Pirko <jiri@nvidia.com>
> 
> In order to allow driver expose quality level of the clock it is
> running, introduce a new netlink attr with enum to carry it to the
> userspace. Also, introduce an op the dpll netlink code calls into the
> driver to obtain the value.

The idea is good, it matches with the work Maciek is doing now in terms
of improving POSIX clock interface. See a comment below.

> Signed-off-by: Jiri Pirko <jiri@nvidia.com>
> ---
>   Documentation/netlink/specs/dpll.yaml | 28 +++++++++++++++++++++++++++
>   drivers/dpll/dpll_netlink.c           | 22 +++++++++++++++++++++
>   include/linux/dpll.h                  |  4 ++++
>   include/uapi/linux/dpll.h             | 21 ++++++++++++++++++++
>   4 files changed, 75 insertions(+)
> 
> diff --git a/Documentation/netlink/specs/dpll.yaml b/Documentation/netlink/specs/dpll.yaml
> index f2894ca35de8..77a8e9ddb254 100644
> --- a/Documentation/netlink/specs/dpll.yaml
> +++ b/Documentation/netlink/specs/dpll.yaml
> @@ -85,6 +85,30 @@ definitions:
>             This may happen for example if dpll device was previously
>             locked on an input pin of type PIN_TYPE_SYNCE_ETH_PORT.
>       render-max: true
> +  -
> +    type: enum
> +    name: clock-quality-level
> +    doc: |
> +      level of quality of a clock device.
> +    entries:
> +      -
> +        name: prc
> +        value: 1
> +      -
> +        name: ssu-a
> +      -
> +        name: ssu-b
> +      -
> +        name: eec1
> +      -
> +        name: prtc
> +      -
> +        name: eprtc
> +      -
> +        name: eeec
> +      -
> +        name: eprc
> +    render-max: true
>     -
>       type: const
>       name: temp-divider
> @@ -252,6 +276,10 @@ attribute-sets:
>           name: lock-status-error
>           type: u32
>           enum: lock-status-error
> +      -
> +        name: clock-quality-level
> +        type: u32
> +        enum: clock-quality-level
>     -
>       name: pin
>       enum-name: dpll_a_pin
> diff --git a/drivers/dpll/dpll_netlink.c b/drivers/dpll/dpll_netlink.c
> index fc0280dcddd1..689a6d0ff049 100644
> --- a/drivers/dpll/dpll_netlink.c
> +++ b/drivers/dpll/dpll_netlink.c
> @@ -169,6 +169,25 @@ dpll_msg_add_temp(struct sk_buff *msg, struct dpll_device *dpll,
>   	return 0;
>   }
>   
> +static int
> +dpll_msg_add_clock_quality_level(struct sk_buff *msg, struct dpll_device *dpll,
> +				 struct netlink_ext_ack *extack)
> +{
> +	const struct dpll_device_ops *ops = dpll_device_ops(dpll);
> +	enum dpll_clock_quality_level ql;
> +	int ret;
> +
> +	if (!ops->clock_quality_level_get)
> +		return 0;
> +	ret = ops->clock_quality_level_get(dpll, dpll_priv(dpll), &ql, extack);
> +	if (ret)
> +		return ret;
> +	if (nla_put_u32(msg, DPLL_A_CLOCK_QUALITY_LEVEL, ql))
> +		return -EMSGSIZE;
> +
> +	return 0;
> +}
> +
>   static int
>   dpll_msg_add_pin_prio(struct sk_buff *msg, struct dpll_pin *pin,
>   		      struct dpll_pin_ref *ref,
> @@ -557,6 +576,9 @@ dpll_device_get_one(struct dpll_device *dpll, struct sk_buff *msg,
>   	if (ret)
>   		return ret;
>   	ret = dpll_msg_add_lock_status(msg, dpll, extack);
> +	if (ret)
> +		return ret;
> +	ret = dpll_msg_add_clock_quality_level(msg, dpll, extack);
>   	if (ret)
>   		return ret;
>   	ret = dpll_msg_add_mode(msg, dpll, extack);
> diff --git a/include/linux/dpll.h b/include/linux/dpll.h
> index 81f7b623d0ba..e99cdb8ab02c 100644
> --- a/include/linux/dpll.h
> +++ b/include/linux/dpll.h
> @@ -26,6 +26,10 @@ struct dpll_device_ops {
>   			       struct netlink_ext_ack *extack);
>   	int (*temp_get)(const struct dpll_device *dpll, void *dpll_priv,
>   			s32 *temp, struct netlink_ext_ack *extack);
> +	int (*clock_quality_level_get)(const struct dpll_device *dpll,
> +				       void *dpll_priv,
> +				       enum dpll_clock_quality_level *ql,
> +				       struct netlink_ext_ack *extack);
>   };
>   
>   struct dpll_pin_ops {
> diff --git a/include/uapi/linux/dpll.h b/include/uapi/linux/dpll.h
> index b0654ade7b7e..0572f9376da4 100644
> --- a/include/uapi/linux/dpll.h
> +++ b/include/uapi/linux/dpll.h
> @@ -79,6 +79,26 @@ enum dpll_lock_status_error {
>   	DPLL_LOCK_STATUS_ERROR_MAX = (__DPLL_LOCK_STATUS_ERROR_MAX - 1)
>   };
>   
> +/**
> + * enum dpll_clock_quality_level - if previous status change was done due to a
> + *   failure, this provides information of dpll device lock status error. Valid
> + *   values for DPLL_A_LOCK_STATUS_ERROR attribute
> + */
> +enum dpll_clock_quality_level {
> +	DPLL_CLOCK_QUALITY_LEVEL_PRC = 1,
> +	DPLL_CLOCK_QUALITY_LEVEL_SSU_A,
> +	DPLL_CLOCK_QUALITY_LEVEL_SSU_B,
> +	DPLL_CLOCK_QUALITY_LEVEL_EEC1,
> +	DPLL_CLOCK_QUALITY_LEVEL_PRTC,
> +	DPLL_CLOCK_QUALITY_LEVEL_EPRTC,
> +	DPLL_CLOCK_QUALITY_LEVEL_EEEC,
> +	DPLL_CLOCK_QUALITY_LEVEL_EPRC,

I think it would be great to provide some explanation of levels here.
People coming from SDH area may not be familiar with some of them. Or at
least mention ITU-T/IEEE recommendations documents to get the meanings
of these levels.

> +
> +	/* private: */
> +	__DPLL_CLOCK_QUALITY_LEVEL_MAX,
> +	DPLL_CLOCK_QUALITY_LEVEL_MAX = (__DPLL_CLOCK_QUALITY_LEVEL_MAX - 1)
> +};
> +
>   #define DPLL_TEMP_DIVIDER	1000
>   
>   /**
> @@ -180,6 +200,7 @@ enum dpll_a {
>   	DPLL_A_TEMP,
>   	DPLL_A_TYPE,
>   	DPLL_A_LOCK_STATUS_ERROR,
> +	DPLL_A_CLOCK_QUALITY_LEVEL,
>   
>   	__DPLL_A_MAX,
>   	DPLL_A_MAX = (__DPLL_A_MAX - 1)


