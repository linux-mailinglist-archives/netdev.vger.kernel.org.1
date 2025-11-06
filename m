Return-Path: <netdev+bounces-236165-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id 37CC2C3912D
	for <lists+netdev@lfdr.de>; Thu, 06 Nov 2025 05:17:02 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 2DBC24E1FA5
	for <lists+netdev@lfdr.de>; Thu,  6 Nov 2025 04:17:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 26F5223185D;
	Thu,  6 Nov 2025 04:16:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="USmEGR4P"
X-Original-To: netdev@vger.kernel.org
Received: from out-177.mta1.migadu.com (out-177.mta1.migadu.com [95.215.58.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1A8BB16D9C2
	for <netdev@vger.kernel.org>; Thu,  6 Nov 2025 04:16:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=95.215.58.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762402619; cv=none; b=K0Y25AZ/QhT+2na1CP+L31Z/a0i8vgo2ivZ69dC2yE5tRaE6rXfk+NNBo/wBoE3FxjQTr7zOgyWxX2LEScLCf5etBlOI0982hsBBxew0Mw822QOeF6gRFORcY8H8k5A5DgC2kRy/QUIc8BQzSCg1s/4D73R9TVLIeB/mR9N7aqo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762402619; c=relaxed/simple;
	bh=bWktklmOZkDwnVOH9HkFHc9GSbR+DbaHhG6ngBQSERE=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=A4JEZoV2Bu8M8/HPu48n+0nz0DtgAv7QQMlY4YJjDKV7Fbm/2s/78ZvY5l/uvALnyGZ6wgOKhHgz0qYNIHFh1tO+QyNCuAIh0oHYgovFFKystsfinf4amv6C5tLkvfNOYQExfdrbtlw94DbF1g4YW0CYxJLGlNFJJfkza8VFmdI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=USmEGR4P; arc=none smtp.client-ip=95.215.58.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Message-ID: <d6a53bed-b197-432c-84e5-ac324b36137e@linux.dev>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1762402614;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=86xDxTdAU6WF+fO8WsDlbcAOxAJjdB5iyg5ImNIxrCg=;
	b=USmEGR4PUEkMQKSmpmgfCNWlfWyYejBACJkWO35dT/HD0qeO2PXyvjKDkq5Fn4edS4gKV8
	j/HRlQ7KyhipoHgQfPMiMYrGg2hE/7jofloUMGaCq/WLTtJf79dVMPuxJ4gz+xcfnOsrBn
	TDLCTe8EhUQo+w4vxtXm7MkqIZKf5Ow=
Date: Wed, 5 Nov 2025 20:16:45 -0800
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Subject: Re: [PATCH bpf-next v4 2/3] net/smc: bpf: Introduce generic hook for
 handshake flow
To: "D. Wythe" <alibuda@linux.alibaba.com>
Cc: ast@kernel.org, daniel@iogearbox.net, andrii@kernel.org,
 pabeni@redhat.com, song@kernel.org, sdf@google.com, haoluo@google.com,
 yhs@fb.com, edumazet@google.com, john.fastabend@gmail.com,
 kpsingh@kernel.org, jolsa@kernel.org, mjambigi@linux.ibm.com,
 wenjia@linux.ibm.com, wintera@linux.ibm.com, dust.li@linux.alibaba.com,
 tonylu@linux.alibaba.com, guwen@linux.alibaba.com, bpf@vger.kernel.org,
 davem@davemloft.net, kuba@kernel.org, netdev@vger.kernel.org,
 sidraya@linux.ibm.com, jaka@linux.ibm.com
References: <20251103073124.43077-1-alibuda@linux.alibaba.com>
 <20251103073124.43077-3-alibuda@linux.alibaba.com>
 <4450b847-6b31-46f2-bc2d-a8b3197d15c7@linux.dev>
 <20251105070140.GA31761@j66a10360.sqa.eu95>
 <dfed97fb-4e0c-416e-b5d8-8de7b3edce69@linux.dev>
 <20251106023302.GA44223@j66a10360.sqa.eu95>
Content-Language: en-US
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Martin KaFai Lau <martin.lau@linux.dev>
In-Reply-To: <20251106023302.GA44223@j66a10360.sqa.eu95>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Migadu-Flow: FLOW_OUT



On 11/5/25 6:33 PM, D. Wythe wrote:
> On Wed, Nov 05, 2025 at 02:58:48PM -0800, Martin KaFai Lau wrote:
>>
>>
>> On 11/4/25 11:01 PM, D. Wythe wrote:
>>> On Tue, Nov 04, 2025 at 04:03:46PM -0800, Martin KaFai Lau wrote:
>>>>
>>>>
>>>> On 11/2/25 11:31 PM, D. Wythe wrote:
>>>>> +#if IS_ENABLED(CONFIG_SMC_HS_CTRL_BPF)
>>>>> +#define smc_call_hsbpf(init_val, sk, func, ...) ({		\
>>>>> +	typeof(init_val) __ret = (init_val);			\
>>>>> +	struct smc_hs_ctrl *ctrl;				\
>>>>> +	rcu_read_lock();					\
>>>>> +	ctrl = rcu_dereference(sock_net(sk)->smc.hs_ctrl);	\
>>>>
>>>> The smc_hs_ctrl (and its ops) is called from the netns, so the
>>>> bpf_struct_ops is attached to a netns. Attaching bpf_struct_ops to a
>>>> netns has not been done before. More on this later.
>>>>
>>>>> +	if (ctrl && ctrl->func)					\
>>>>> +		__ret = ctrl->func(__VA_ARGS__);		\
>>>>> +
>>>>> +	if (static_branch_unlikely(&tcp_have_smc) && tp->syn_smc) {
>>>>> +		tp->syn_smc = !!smc_call_hsbpf(1, sk, syn_option, tp);
>>>>
>>>> ... so just pass tp instead of passing both sk and tp?
>>>>
>>>> [ ... ]
>>>>
>>>
>>> You're right, it is a bit redundant. However, if we merge the parameters,
>>> every user of this macro will be forced to pass tp. In fact, we’re
>>> already considering adding some callback functions that don’t take tp as
>>> a parameter.
>>
>> If the struct_ops callback does not take tp, then don't pass it to the
>> callback. I have a hard time to imagine why the bpf prog will not be
>> interested in the tp/sk pointer though.
>>
>> or you meant the caller does not have tp? and where is the future caller?
> 
> My initial concern was that certain ctrl->func callbacks might
> eventually need to operate on an smc_sock rather than a tcp_sock.

hmm...in that case, I think it first needs to understand where else the 
smc struct_ops is planned to be called in the future. I thought the smc 
struct_ops is something unique to the af_smc address family but I 
suspect the future ops addition may not be the case. Can you share some 
details on where the future callback will be? e.g. in smc_{connect, 
sendmsg, recvmsg...} that has the smc_sock?

