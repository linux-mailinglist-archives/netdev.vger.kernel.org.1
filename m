Return-Path: <netdev+bounces-173559-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id ACC30A59758
	for <lists+netdev@lfdr.de>; Mon, 10 Mar 2025 15:17:33 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id DD02016699A
	for <lists+netdev@lfdr.de>; Mon, 10 Mar 2025 14:17:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 742C422ACD4;
	Mon, 10 Mar 2025 14:17:23 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from mail-wm1-f66.google.com (mail-wm1-f66.google.com [209.85.128.66])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8361122B8D5
	for <netdev@vger.kernel.org>; Mon, 10 Mar 2025 14:17:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.66
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741616243; cv=none; b=D6cgMqsQ6z50ynun8yPFVq8yo5ISoIdg6ErF/r6ZT5LYyj2tQYSQORC9ONVzZrs+6MHKWQoyEGhlRaZ8J3IR1/JFnP0himKKW+q1K+c/8ok5saV7cDnNSp0ZalOEm701d5HSC1JiPzemWO2kkqEoZ9S4rfV7kIvFh7yOvjjdUCQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741616243; c=relaxed/simple;
	bh=ADQwOtb0TYlmpiT8gITVc8q/7gl1iFoGrUW6iqRZPMw=;
	h=Message-ID:Date:MIME-Version:Cc:Subject:To:References:From:
	 In-Reply-To:Content-Type; b=KgiQuuHlHfabAOYcLlLXg7fO09pDSY+6NZBcfhm0FEASkn0Jz9+Pn7buFoeTI+rD6Ka/6IMVcs1GwKAVY5fBBp/T1/VlKfGXJSkunGNwuo2lnto73tFy8Pr6Dl/wnEb3mpQ7FA1FUz0F+mTMwglZsUt6rWLOBniGQqnamf6gEuY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ovn.org; spf=pass smtp.mailfrom=gmail.com; arc=none smtp.client-ip=209.85.128.66
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ovn.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f66.google.com with SMTP id 5b1f17b1804b1-43cec5cd73bso10006065e9.3
        for <netdev@vger.kernel.org>; Mon, 10 Mar 2025 07:17:21 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1741616240; x=1742221040;
        h=content-transfer-encoding:in-reply-to:autocrypt:from
         :content-language:references:to:subject:cc:user-agent:mime-version
         :date:message-id:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ALUl14+xLXz+y+da9XWpKjoocHTjV0enYwevQ9YFe5Q=;
        b=OkqwS/nuKTabrep2t2bd6arj0kh6TOy71TLFgd1CrbR2OdKGORIcJhz4MwTeF1jknJ
         9rcdYz+3Zze3YLg7ebaBcp7jKGrc4VBa47N4j5byHLjywNpXLiv29WPX7U4zrLbtljVL
         4vDYSVHhFKX+sF+ZLmULzcfMOHPOlOeZGbyVMwoIfMhmtOUYXOSOSoTPJkNGXKwTqzxW
         BoUomasZ/X19+/cR7euWMfohrmrWI6RlOGJ/COqEEtG6IYnX4qeuZcRw8nVDhHGvFUYS
         erick6FyXCjRKYor396axQYpoNg8aogO1YSdhfjM+S+P8M+5+e+tQTRmy+7g+W/C1C2B
         vV9w==
X-Forwarded-Encrypted: i=1; AJvYcCWDseL9k6v3tYh8AwDu9SmaVJhug4eFV0NOKAfIMtKiBYMdOTITx3l1EQQdaBajqJt0YIRY1i0=@vger.kernel.org
X-Gm-Message-State: AOJu0YxfaE89fDuSBsdkD2U/oqCOlE+fnpHvvOxmG55EAbbWfPBivVDX
	oKa8nvfnGZWX+7cHI2t3xOprAs4ljZezEHJbucZ80hrXRhV+HT5oD78lrKfN
X-Gm-Gg: ASbGncueWBb6e0ui8mIzzorWqQklVKTYh5U5q7h/+raKYFIo2yZnK7RG3QHXRnONKDU
	/+CA+B6zJMKUQyodQM1FQ4vOiW+TKCuIfB+cFRu0npqZ635eyoV6RpB2D48J0FAiHBVw0005sbS
	cfTgOaIqpBlddgprRj6oSui+9qUb5eFw448Be/Lcfd1zUDyrIO58gmVdihaP3eoDcB4M82+7z6J
	YmOZKbfofDQOInIYnflRXU6xgtrOT0a1lBpm5LQfU7YVyACSk3ymaeI7xf8Us8EHomt5VKIw7qH
	HO6316EqS+i/BTpxsFomPXQtLXbvtHkK5RlhJNNgTy4YvoBIxE0Vr7XJsjsu6pELWcFHEs8QlvK
	Zrf4iR19DlFo=
X-Google-Smtp-Source: AGHT+IH/ybWFrbKltPasLcmIsvBylq43GvravCSeAHHc4qEBgIAK3rFRPJY0tz/2x9rnDHVXCBviEQ==
X-Received: by 2002:a05:6000:178d:b0:390:e9ea:59a with SMTP id ffacd0b85a97d-39132d77a7emr8012306f8f.5.1741616239585;
        Mon, 10 Mar 2025 07:17:19 -0700 (PDT)
Received: from [192.168.0.13] (ip-86-49-44-151.bb.vodafone.cz. [86.49.44.151])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-3912bfba87csm15468119f8f.17.2025.03.10.07.17.18
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 10 Mar 2025 07:17:19 -0700 (PDT)
Message-ID: <9a1ededa-8b1f-4118-94b4-d69df766c61e@ovn.org>
Date: Mon, 10 Mar 2025 15:17:17 +0100
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Cc: dev@openvswitch.org, Eric Dumazet <edumazet@google.com>,
 Simon Horman <horms@kernel.org>, Jakub Kicinski <kuba@kernel.org>,
 Thomas Gleixner <tglx@linutronix.de>, Paolo Abeni <pabeni@redhat.com>,
 "David S. Miller" <davem@davemloft.net>, i.maximets@ovn.org
Subject: Re: [ovs-dev] [PATCH net-next 11/18] openvswitch: Use nested-BH
 locking for ovs_actions.
To: Sebastian Andrzej Siewior <bigeasy@linutronix.de>,
 netdev@vger.kernel.org, linux-rt-devel@lists.linux.dev
References: <20250309144653.825351-1-bigeasy@linutronix.de>
 <20250309144653.825351-12-bigeasy@linutronix.de>
Content-Language: en-US
From: Ilya Maximets <i.maximets@ovn.org>
Autocrypt: addr=i.maximets@ovn.org; keydata=
 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
In-Reply-To: <20250309144653.825351-12-bigeasy@linutronix.de>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 3/9/25 15:46, Sebastian Andrzej Siewior wrote:
> ovs_actions is a per-CPU variable and relies on disabled BH for its
> locking. Without per-CPU locking in local_bh_disable() on PREEMPT_RT
> this data structure requires explicit locking.
> The data structure can be referenced recursive and there is a recursion
> counter to avoid too many recursions.
> 
> Add a local_lock_t to the data structure and use
> local_lock_nested_bh() for locking. Add an owner of the struct which is
> the current task and acquire the lock only if the structure is not owned
> by the current task.
> 
> Cc: Pravin B Shelar <pshelar@ovn.org>
> Cc: dev@openvswitch.org
> Signed-off-by: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
> ---
>  net/openvswitch/actions.c | 13 +++++++++++++
>  1 file changed, 13 insertions(+)
> 
> diff --git a/net/openvswitch/actions.c b/net/openvswitch/actions.c
> index 322ca7b30c3bc..c4131e04c1284 100644
> --- a/net/openvswitch/actions.c
> +++ b/net/openvswitch/actions.c
> @@ -82,6 +82,8 @@ struct ovs_action {
>  	struct action_fifo action_fifos;
>  	struct action_flow_keys flow_keys;
>  	int exec_level;
> +	struct task_struct *owner;
> +	local_lock_t bh_lock;
>  };
>  
>  static DEFINE_PER_CPU(struct ovs_action, ovs_actions);
> @@ -1690,8 +1692,14 @@ int ovs_execute_actions(struct datapath *dp, struct sk_buff *skb,
>  			const struct sw_flow_actions *acts,
>  			struct sw_flow_key *key)
>  {
> +	struct ovs_action *ovs_act = this_cpu_ptr(&ovs_actions);
>  	int err, level;
>  
> +	if (ovs_act->owner != current) {
> +		local_lock_nested_bh(&ovs_actions.bh_lock);

Wouldn't this cause a warning when we're in a syscall/process context?

We will also be taking a spinlock in a general case here, which doesn't
sound particularly great, since we can potentially be holding it for a
long time and it's also not free to take/release on this hot path.
Is there a version of this lock that's a no-op on non-RT?

> +		ovs_act->owner = current;
> +	}
> +
>  	level = __this_cpu_inc_return(ovs_actions.exec_level);
>  	if (unlikely(level > OVS_RECURSION_LIMIT)) {
>  		net_crit_ratelimited("ovs: recursion limit reached on datapath %s, probable configuration error\n",
> @@ -1710,5 +1718,10 @@ int ovs_execute_actions(struct datapath *dp, struct sk_buff *skb,
>  
>  out:
>  	__this_cpu_dec(ovs_actions.exec_level);
> +
> +	if (level == 1) {
> +		ovs_act->owner = NULL;
> +		local_unlock_nested_bh(&ovs_actions.bh_lock);
> +	}

Seems dangerous to lock every time the owner changes but unlock only
once on level 1.  Even if this works fine, it seems unnecessarily
complicated.  Maybe it's better to just lock once before calling
ovs_execute_actions() instead?

Also, the name of the struct ovs_action doesn't make a lot of sense,
I'd suggest to call it pcpu_storage or something like that instead.
I.e. have a more generic name as the fields inside are not directly
related to each other.

Best regards, Ilya Maximets.

