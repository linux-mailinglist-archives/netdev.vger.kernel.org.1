Return-Path: <netdev+bounces-173594-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 771D1A59BBE
	for <lists+netdev@lfdr.de>; Mon, 10 Mar 2025 17:56:17 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 2D4063A083D
	for <lists+netdev@lfdr.de>; Mon, 10 Mar 2025 16:56:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6D0EE216392;
	Mon, 10 Mar 2025 16:56:14 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from mail-wm1-f67.google.com (mail-wm1-f67.google.com [209.85.128.67])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 54472158538
	for <netdev@vger.kernel.org>; Mon, 10 Mar 2025 16:56:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.67
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741625774; cv=none; b=LXlRd7YHOdMEwp5K73+K/1rLlrPBv9LITblyhwFACb2Jm8yRxRYlGMh6YtGN7kA+NCoHlWsXig/8Jt6YRYPBT/vvUvxGLMPkHRoR4LdkEcmRh6smwJ40Z0fRFzqkjzovuTOEXhdBmvCfllfM293xmiHFQgxrKeOXXiCgzHKMbgY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741625774; c=relaxed/simple;
	bh=oMfS3X01oHkPrFb5lPauuQuRPK0NzVfpXi3RTa7/W44=;
	h=Message-ID:Date:MIME-Version:Cc:Subject:To:References:From:
	 In-Reply-To:Content-Type; b=aWAbsU+vCQW5tQ1WzQt3eh2exd5pBIUJ3Loh4dz0t7YGAyySjqqxcK5QfHVv41NB8nKnt+i9+FVDPP2NMBjgYo+N88u5uoWXt75rAC9CWAcVnVYrLrY89b5eMScyRWVOUwIWvDECsmDmiucuxZg/2Y0n0W931LvcpHs9Jmj2i8w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ovn.org; spf=pass smtp.mailfrom=gmail.com; arc=none smtp.client-ip=209.85.128.67
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ovn.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f67.google.com with SMTP id 5b1f17b1804b1-43cf58eea0fso8288785e9.0
        for <netdev@vger.kernel.org>; Mon, 10 Mar 2025 09:56:12 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1741625771; x=1742230571;
        h=content-transfer-encoding:in-reply-to:autocrypt:from
         :content-language:references:to:subject:cc:user-agent:mime-version
         :date:message-id:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=pvaPe0FnoiUBYSIQbKWkdJ0l3Pi+DPRzAga15PII7CA=;
        b=U5SRR+R4LjPbvR2xTSnwNl0c1DMUYr8I1svHUY3aG3sP3lc95fbI6hTxqNlX2dvnwG
         9L9WcPYRBI+l/+d4V6uRLxVyx/22ucXOOfG5QAGL0SRWO+NTjHVymUny+CnLmI9rRjVH
         574Gnu+ODYHGbf3Lhxu1pVOZmgVKkSC4033UzzIrXrDJzpD9gTpX1BCIRMcp826A0yVm
         iBlvYu2pj4NVzX0R0+JIzFi3mD6IWXOZzl7jecEhzFDJS2VuQ0P7ph4hsSYIxOvnHS3y
         zHjd9K89nKmcx+JUsSNM77MdIEdXEbMteaovjA8pT16YKKRAhsWwCmpkxXInRZIebudo
         r0MQ==
X-Forwarded-Encrypted: i=1; AJvYcCW0FS1fFnMxGFgiVx9RDvMv77c1tqYTKZrgpsnDcAlUm3GDH3Z0GgqC4yTiz7X2PgpO8fctyKo=@vger.kernel.org
X-Gm-Message-State: AOJu0YzRDiKg5V1xcmh1+OwS551q+So6dWjJD+EleZWi/J6aSz4OUMhb
	8c3dgg9EWw0dnKd+kG9K6VGPlEUahytdKBujfMUfv31Ay/zhvz90
X-Gm-Gg: ASbGnctLsCPhZCvECwz/RIP+GBQlHbwK8TwCyPw9Msv0LiRb4+Rt5R1kMKw7EG/39fN
	XBbeMwWMDqOs3DLzXleKfCwergJRuwqgd+/BpQHRMAJzr45keQL5AWgXEWQzPCMTaRe9/ireMzJ
	cGk+u9lxhCcfQw1pThcyVX1yacE0vYahj/ObvOhTbuI4qyXcpGMkNtxWFcVTvgKtyfdiaKvuVc6
	OrIaggNA/5B40J5O+LJhnx8CgbmK+h/nH059kDNyjEkZki2zKhYo3Dofet31sOIyCQIVSoWihQH
	Z85aK9P2E8uZI2xR5D2D6EQrmPvMNQrHl5Xyu7RRe+nJR+IJOg6RSdfHjKdB5Qs00OwXfkFt6Yw
	A
X-Google-Smtp-Source: AGHT+IGNDCvM77UA0nZLbqPpGrowhXz79vy6Dz09e/0U+L+xgeq1oT731u3LflQFI85ZJ3rrUrLxkQ==
X-Received: by 2002:a05:600c:5248:b0:43c:f4b3:b094 with SMTP id 5b1f17b1804b1-43d01bd1b62mr5077145e9.6.1741625770414;
        Mon, 10 Mar 2025 09:56:10 -0700 (PDT)
Received: from [192.168.0.13] (ip-86-49-44-151.bb.vodafone.cz. [86.49.44.151])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-3912bfdfe61sm15738375f8f.38.2025.03.10.09.56.09
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 10 Mar 2025 09:56:10 -0700 (PDT)
Message-ID: <fd4c8167-0c2d-4f5f-bf70-1efcdf3de2fb@ovn.org>
Date: Mon, 10 Mar 2025 17:56:09 +0100
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Cc: i.maximets@ovn.org, netdev@vger.kernel.org,
 linux-rt-devel@lists.linux.dev, dev@openvswitch.org,
 Eric Dumazet <edumazet@google.com>, Simon Horman <horms@kernel.org>,
 Jakub Kicinski <kuba@kernel.org>, Thomas Gleixner <tglx@linutronix.de>,
 Paolo Abeni <pabeni@redhat.com>, "David S. Miller" <davem@davemloft.net>
Subject: Re: [ovs-dev] [PATCH net-next 11/18] openvswitch: Use nested-BH
 locking for ovs_actions.
To: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
References: <20250309144653.825351-1-bigeasy@linutronix.de>
 <20250309144653.825351-12-bigeasy@linutronix.de>
 <9a1ededa-8b1f-4118-94b4-d69df766c61e@ovn.org>
 <20250310144459.wjPdPtUo@linutronix.de>
Content-Language: en-US
From: Ilya Maximets <i.maximets@ovn.org>
Autocrypt: addr=i.maximets@ovn.org; keydata=
 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
In-Reply-To: <20250310144459.wjPdPtUo@linutronix.de>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 3/10/25 15:44, Sebastian Andrzej Siewior wrote:
> On 2025-03-10 15:17:17 [+0100], Ilya Maximets wrote:
>>> --- a/net/openvswitch/actions.c
>>> +++ b/net/openvswitch/actions.c
>>> @@ -82,6 +82,8 @@ struct ovs_action {
>>>  	struct action_fifo action_fifos;
>>>  	struct action_flow_keys flow_keys;
>>>  	int exec_level;
>>> +	struct task_struct *owner;
>>> +	local_lock_t bh_lock;
>>>  };
>>>  
>>>  static DEFINE_PER_CPU(struct ovs_action, ovs_actions);
>>> @@ -1690,8 +1692,14 @@ int ovs_execute_actions(struct datapath *dp, struct sk_buff *skb,
>>>  			const struct sw_flow_actions *acts,
>>>  			struct sw_flow_key *key)
>>>  {
>>> +	struct ovs_action *ovs_act = this_cpu_ptr(&ovs_actions);
>>>  	int err, level;
>>>  
>>> +	if (ovs_act->owner != current) {
>>> +		local_lock_nested_bh(&ovs_actions.bh_lock);
>>
>> Wouldn't this cause a warning when we're in a syscall/process context?
> 
> My understanding is that is only invoked in softirq context. Did I
> misunderstood it?

It can be called from the syscall/process context while processing
OVS_PACKET_CMD_EXECUTE request.

> Otherwise that this_cpu_ptr() above should complain
> that preemption is not disabled and if preemption is indeed not disabled
> how do you ensure that you don't get preempted after the
> __this_cpu_inc_return() in several tasks (at the same time) leading to
> exceeding the OVS_RECURSION_LIMIT?

We disable BH in this case, so it should be safe (on non-RT).  See the
ovs_packet_cmd_execute() for more details.

> 
>> We will also be taking a spinlock in a general case here, which doesn't
>> sound particularly great, since we can potentially be holding it for a
>> long time and it's also not free to take/release on this hot path.
>> Is there a version of this lock that's a no-op on non-RT?
> 
> local_lock_nested_bh() does not acquire any lock on !PREEMPT_RT. It only
> verifies that in_softirq() is true.

Ah, you're right.  It does more things, but only under lock debug.

> 
>>> +		ovs_act->owner = current;
>>> +	}
>>> +
>>>  	level = __this_cpu_inc_return(ovs_actions.exec_level);
>>>  	if (unlikely(level > OVS_RECURSION_LIMIT)) {
>>>  		net_crit_ratelimited("ovs: recursion limit reached on datapath %s, probable configuration error\n",
>>> @@ -1710,5 +1718,10 @@ int ovs_execute_actions(struct datapath *dp, struct sk_buff *skb,
>>>  
>>>  out:
>>>  	__this_cpu_dec(ovs_actions.exec_level);
>>> +
>>> +	if (level == 1) {
>>> +		ovs_act->owner = NULL;
>>> +		local_unlock_nested_bh(&ovs_actions.bh_lock);
>>> +	}
>>
>> Seems dangerous to lock every time the owner changes but unlock only
>> once on level 1.  Even if this works fine, it seems unnecessarily
>> complicated.  Maybe it's better to just lock once before calling
>> ovs_execute_actions() instead?
> 
> My understanding is this can be invoked recursively. That means on first
> invocation owner == NULL and then you acquire the lock at which point
> exec_level goes 0->1. On the recursive invocation owner == current and
> you skip the lock but exec_level goes 1 -> 2.
> On your return path once level becomes 1, then it means that dec made it
> go 1 -> 0, you unlock the lock.

My point is: why locking here with some extra non-obvious logic of owner
tracking if we can lock (unconditionally?) in ovs_packet_cmd_execute() and
ovs_dp_process_packet() instead?  We already disable BH in one of those
and take appropriate RCU locks in both.  So, feels like a better place
for the extra locking if necessary.  We will also not need to move around
any code in actions.c if the code there is guaranteed to be safe by holding
locks outside of it.

> The locking part happens only on PREEMPT_RT because !PREEMPT_RT has
> softirqs disabled which guarantee that there will be no preemption.
> 
> tools/testing/selftests/net/openvswitch should cover this?

It's not a comprehensive test suite, it covers some cases, but it
doesn't test anything related to preemptions specifically.

> 
>> Also, the name of the struct ovs_action doesn't make a lot of sense,
>> I'd suggest to call it pcpu_storage or something like that instead.
>> I.e. have a more generic name as the fields inside are not directly
>> related to each other.
> 
> Understood. ovs_pcpu_storage maybe?

It's OK, I guess, but see also a point about locking inside datapath.c
instead and probably not needing to change anything in actions.c.

> 
>> Best regards, Ilya Maximets.
> 
> Sebastian


