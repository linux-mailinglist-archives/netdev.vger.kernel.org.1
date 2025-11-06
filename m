Return-Path: <netdev+bounces-236473-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 0A9C1C3CC96
	for <lists+netdev@lfdr.de>; Thu, 06 Nov 2025 18:20:26 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 5C0CC4F8734
	for <lists+netdev@lfdr.de>; Thu,  6 Nov 2025 17:16:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0459B3128AF;
	Thu,  6 Nov 2025 17:16:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="r2Vixb8U"
X-Original-To: netdev@vger.kernel.org
Received: from out-188.mta0.migadu.com (out-188.mta0.migadu.com [91.218.175.188])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7DB972D7DF3
	for <netdev@vger.kernel.org>; Thu,  6 Nov 2025 17:16:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.218.175.188
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762449376; cv=none; b=IDtBWgFbf9OZxRbtgUJvd8HlpC6NgOv3ohDqYhL9O3qOej2goReYoG5WPGu+8aC6Ig1EMmSFdnTRKFHVLZycazDI67KSJ7ukhzzbaCFf/Vy7/BkHv1GfiNBuCtlus2WbLyyvSNSMswmfjcpuI0AuJ3HcAcBqjZJHcM+hALA6t1c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762449376; c=relaxed/simple;
	bh=/tqiapIUWbTn7JSjOxYlsJYQVBW7fw0LQMUYqKA3eFw=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=kupmH/x3hw4UU+VhFzncwuEWGOgQNt+IwLGTPzr5vIr8nig3NJzs8tC5B25bqLEpJrOSIORLQ5UaFq3ixmaCVpmB4P5kBeQoG28O8ukefsKkzmxy76KF3ZOStVZk3LJfGGx5lb+9jWfZ0UytzXM5r38aegPHyjhWDTKTN1kFLOw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=r2Vixb8U; arc=none smtp.client-ip=91.218.175.188
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Message-ID: <c4e481e6-570e-45bc-b390-fa21192782f8@linux.dev>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1762449361;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=kFjA5axoqhZvhTZ//Ppasioa8gS/l2K8N0jIR7SCV9w=;
	b=r2Vixb8UTCSHRlBwfuCdPRax36X8bmhbl0QmrqLb1fMN+Mz5fLwSs6a0T1WvOGq91Bh/4S
	u74u+pno4t629iEVGtsfcuKukAlNxNJWisvx2e1inmzhUoAc4tlH3sR7BfrIGmAKnkRAIB
	ZP56sJQVu9iTnLTy7aeRDiAC95DT1Co=
Date: Thu, 6 Nov 2025 09:15:54 -0800
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
 <d6a53bed-b197-432c-84e5-ac324b36137e@linux.dev>
 <20251106083429.GA35123@j66a10360.sqa.eu95>
Content-Language: en-US
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Martin KaFai Lau <martin.lau@linux.dev>
In-Reply-To: <20251106083429.GA35123@j66a10360.sqa.eu95>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Migadu-Flow: FLOW_OUT



On 11/6/25 12:34 AM, D. Wythe wrote:
> On Wed, Nov 05, 2025 at 08:16:45PM -0800, Martin KaFai Lau wrote:
>>
>>
>> On 11/5/25 6:33 PM, D. Wythe wrote:
>>> On Wed, Nov 05, 2025 at 02:58:48PM -0800, Martin KaFai Lau wrote:
>>>>
>>>>
>>>> On 11/4/25 11:01 PM, D. Wythe wrote:
>>>>> On Tue, Nov 04, 2025 at 04:03:46PM -0800, Martin KaFai Lau wrote:
>>>>>>
>>>>>>
>>>>>> On 11/2/25 11:31 PM, D. Wythe wrote:
>>>>>>> +#if IS_ENABLED(CONFIG_SMC_HS_CTRL_BPF)
>>>>>>> +#define smc_call_hsbpf(init_val, sk, func, ...) ({		\
>>>>>>> +	typeof(init_val) __ret = (init_val);			\
>>>>>>> +	struct smc_hs_ctrl *ctrl;				\
>>>>>>> +	rcu_read_lock();					\
>>>>>>> +	ctrl = rcu_dereference(sock_net(sk)->smc.hs_ctrl);	\
>>>>>>
>>>>>> The smc_hs_ctrl (and its ops) is called from the netns, so the
>>>>>> bpf_struct_ops is attached to a netns. Attaching bpf_struct_ops to a
>>>>>> netns has not been done before. More on this later.
>>>>>>
>>>>>>> +	if (ctrl && ctrl->func)					\
>>>>>>> +		__ret = ctrl->func(__VA_ARGS__);		\
>>>>>>> +
>>>>>>> +	if (static_branch_unlikely(&tcp_have_smc) && tp->syn_smc) {
>>>>>>> +		tp->syn_smc = !!smc_call_hsbpf(1, sk, syn_option, tp);
>>>>>>
>>>>>> ... so just pass tp instead of passing both sk and tp?
>>>>>>
>>>>>> [ ... ]
>>>>>>
>>>>>
>>>>> You're right, it is a bit redundant. However, if we merge the parameters,
>>>>> every user of this macro will be forced to pass tp. In fact, we’re
>>>>> already considering adding some callback functions that don’t take tp as
>>>>> a parameter.
>>>>
>>>> If the struct_ops callback does not take tp, then don't pass it to the
>>>> callback. I have a hard time to imagine why the bpf prog will not be
>>>> interested in the tp/sk pointer though.
>>>>
>>>> or you meant the caller does not have tp? and where is the future caller?
>>>
>>> My initial concern was that certain ctrl->func callbacks might
>>> eventually need to operate on an smc_sock rather than a tcp_sock.
>>
>> hmm...in that case, I think it first needs to understand where else
>> the smc struct_ops is planned to be called in the future. I thought
>> the smc struct_ops is something unique to the af_smc address family
>> but I suspect the future ops addition may not be the case. Can you
>> share some details on where the future callback will be? e.g. in
>> smc_{connect, sendmsg, recvmsg...} that has the smc_sock?
> 
> The design scope of hs_ctrl (handshake control) is limited to
> the SMC protocol's handshake phase. This means it will not be involved
> in data transmission functions like smc_sendmsg and smc_recvmsg, Instead,
> its focus is on:
> 
> 1. During the TCP three-way handshake
> 2. During the SMC protocol's own handshake. (proposal -> confirm ->
> accept)
> 
> Within the SMC module, hs_ctrl's primary future call points are
> concentrated within the __smc_connect() and smc_listen_work(). These
> two functions cover the SMC protocol handshake process.
> 
> And we have a plan involving private extensions to the SMC protocol.
> In the SMC protocol, different implementers can extend protocol functionality
> based on their Vendor Organizationally Unique Identifier (vendor_oui). You might
> notice that currently, the SMC implementation only has this vendor_oui field,
> but without corresponding functionality. This is highly significant for our
> applications, as many of our internal features rely on these private extensions.
> However, due to their inherent nature, these private features cannot be
> upstreamed. Therefore, BPF is the best way to implement these. Since
> these private extensions are essentially part of the SMC handshake
> process, hs_ctrl has become our first choice.
> 
> Beyond that, we are also considering other minor extensions to be
> implemented via hs_ctrl. These include assisting in the selection of the
> appropriate SMC device type and making decisions regarding which RDMA
> GID to use. (also in __smc_connect() and smc_listen_work()).

Thanks for the details.

Regarding the "net" passing and the future smc_sock, the net can still 
be obtained from smc_sock. It seems like a naming change on "tp" is 
needed when it may be a smc_sock in the future. It is a nit, so I will 
leave it as a fruit of thought for you and feel free to ignore.

Please re-spin.

