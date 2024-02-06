Return-Path: <netdev+bounces-69491-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 7158684B77C
	for <lists+netdev@lfdr.de>; Tue,  6 Feb 2024 15:10:25 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 56780B2702C
	for <lists+netdev@lfdr.de>; Tue,  6 Feb 2024 14:10:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 32398131727;
	Tue,  6 Feb 2024 14:10:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="erznLLVv"
X-Original-To: netdev@vger.kernel.org
Received: from out-176.mta0.migadu.com (out-176.mta0.migadu.com [91.218.175.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5BB1D6A349
	for <netdev@vger.kernel.org>; Tue,  6 Feb 2024 14:10:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.218.175.176
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707228616; cv=none; b=TDXZSppjQ0/E9jUY7fpkRTI56lf2KwnDith6n3O8Nq9VLNDaBkoKHcvkwsa4+hzOKJjEGii2/wUx3P2I8sP6uXupdf9vdHHc3thrCSdJKJXeu9e9UTnOeBUvIQjcbUixYL2tR28uCCh9R1etSNbvDjsR0n40niGGdmZhpNih1Hk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707228616; c=relaxed/simple;
	bh=cZeQl+T2HhEdGamQaRbIIa2pc/7wCTGf87gW2IW+1sI=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=m/AluZbV687gm8U7vH0sLt2zmYgQ6HzC0vz5bAmTBE0LgEtY6iQMGpiB6hEtneo/OlwHqgxJdpC/fw/PjoCIlyt8Jl34E1QALjfA1g0Jy853m8hUvfvJmZeTW9srpT5hIYTpn2nT6ZzeKBkxGhMQ9eh/JgcJuCcx7BvLHbtUU0g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=erznLLVv; arc=none smtp.client-ip=91.218.175.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Message-ID: <dcbd7098-be09-4309-a95f-c613977be389@linux.dev>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1707228612;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=2iB64trQ9tMkLCadbXXhUKodOl8BVJTxT7fnE2qC/6I=;
	b=erznLLVvMSxVXTzh+lT+1nvzrsu2SG9SpcbxDaXlly0mk1gTeVFotSL8Ojj0G7nAXPAlzz
	Es46SAu6k5PSm05jMr9PkU4+dL2jOJEe7tCPjsiJeoNoor/VDdTFRpE6SqNVrLCUjuT4QA
	TuxMWoNWG3jgHhdDFdNCZrdg8QjJvp4=
Date: Tue, 6 Feb 2024 14:10:05 +0000
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Subject: Re: [patch net] dpll: fix possible deadlock during netlink dump
 operation
Content-Language: en-US
To: Jiri Pirko <jiri@resnulli.us>, netdev@vger.kernel.org
Cc: arkadiusz.kubalewski@intel.com
References: <20240206125145.354557-1-jiri@resnulli.us>
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Vadim Fedorenko <vadim.fedorenko@linux.dev>
In-Reply-To: <20240206125145.354557-1-jiri@resnulli.us>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Migadu-Flow: FLOW_OUT

On 06/02/2024 12:51, Jiri Pirko wrote:
> From: Jiri Pirko <jiri@nvidia.com>
> 
> Recently, I've been hitting following deadlock warning during dpll pin
> dump:
> 
> [52804.637962] ======================================================
> [52804.638536] WARNING: possible circular locking dependency detected
> [52804.639111] 6.8.0-rc2jiri+ #1 Not tainted
> [52804.639529] ------------------------------------------------------
> [52804.640104] python3/2984 is trying to acquire lock:
> [52804.640581] ffff88810e642678 (nlk_cb_mutex-GENERIC){+.+.}-{3:3}, at: netlink_dump+0xb3/0x780
> [52804.641417]
>                 but task is already holding lock:
> [52804.642010] ffffffff83bde4c8 (dpll_lock){+.+.}-{3:3}, at: dpll_lock_dumpit+0x13/0x20
> [52804.642747]
>                 which lock already depends on the new lock.
> 
> [52804.643551]
>                 the existing dependency chain (in reverse order) is:
> [52804.644259]
>                 -> #1 (dpll_lock){+.+.}-{3:3}:
> [52804.644836]        lock_acquire+0x174/0x3e0
> [52804.645271]        __mutex_lock+0x119/0x1150
> [52804.645723]        dpll_lock_dumpit+0x13/0x20
> [52804.646169]        genl_start+0x266/0x320
> [52804.646578]        __netlink_dump_start+0x321/0x450
> [52804.647056]        genl_family_rcv_msg_dumpit+0x155/0x1e0
> [52804.647575]        genl_rcv_msg+0x1ed/0x3b0
> [52804.648001]        netlink_rcv_skb+0xdc/0x210
> [52804.648440]        genl_rcv+0x24/0x40
> [52804.648831]        netlink_unicast+0x2f1/0x490
> [52804.649290]        netlink_sendmsg+0x36d/0x660
> [52804.649742]        __sock_sendmsg+0x73/0xc0
> [52804.650165]        __sys_sendto+0x184/0x210
> [52804.650597]        __x64_sys_sendto+0x72/0x80
> [52804.651045]        do_syscall_64+0x6f/0x140
> [52804.651474]        entry_SYSCALL_64_after_hwframe+0x46/0x4e
> [52804.652001]
>                 -> #0 (nlk_cb_mutex-GENERIC){+.+.}-{3:3}:
> [52804.652650]        check_prev_add+0x1ae/0x1280
> [52804.653107]        __lock_acquire+0x1ed3/0x29a0
> [52804.653559]        lock_acquire+0x174/0x3e0
> [52804.653984]        __mutex_lock+0x119/0x1150
> [52804.654423]        netlink_dump+0xb3/0x780
> [52804.654845]        __netlink_dump_start+0x389/0x450
> [52804.655321]        genl_family_rcv_msg_dumpit+0x155/0x1e0
> [52804.655842]        genl_rcv_msg+0x1ed/0x3b0
> [52804.656272]        netlink_rcv_skb+0xdc/0x210
> [52804.656721]        genl_rcv+0x24/0x40
> [52804.657119]        netlink_unicast+0x2f1/0x490
> [52804.657570]        netlink_sendmsg+0x36d/0x660
> [52804.658022]        __sock_sendmsg+0x73/0xc0
> [52804.658450]        __sys_sendto+0x184/0x210
> [52804.658877]        __x64_sys_sendto+0x72/0x80
> [52804.659322]        do_syscall_64+0x6f/0x140
> [52804.659752]        entry_SYSCALL_64_after_hwframe+0x46/0x4e
> [52804.660281]
>                 other info that might help us debug this:
> 
> [52804.661077]  Possible unsafe locking scenario:
> 
> [52804.661671]        CPU0                    CPU1
> [52804.662129]        ----                    ----
> [52804.662577]   lock(dpll_lock);
> [52804.662924]                                lock(nlk_cb_mutex-GENERIC);
> [52804.663538]                                lock(dpll_lock);
> [52804.664073]   lock(nlk_cb_mutex-GENERIC);
> [52804.664490]
> 
> The issue as follows: __netlink_dump_start() calls control->start(cb)
> with nlk->cb_mutex held. In control->start(cb) the dpll_lock is taken.
> Then nlk->cb_mutex is released and taken again in netlink_dump(), while
> dpll_lock still being held. That leads to ABBA deadlock when another
> CPU races with the same operation.
> 
> Fix this by moving dpll_lock taking into dumpit() callback which ensures
> correct lock taking order.
> 
> Fixes: 9d71b54b65b1 ("dpll: netlink: Add DPLL framework base functions")
> Signed-off-by: Jiri Pirko <jiri@nvidia.com>

Good catch, thanks!

Reviewed-by: Vadim Fedorenko <vadim.fedorenko@linux.dev>

> ---
>   drivers/dpll/dpll_netlink.c | 20 ++++++--------------
>   drivers/dpll/dpll_nl.c      |  4 ----
>   2 files changed, 6 insertions(+), 18 deletions(-)
> 
> diff --git a/drivers/dpll/dpll_netlink.c b/drivers/dpll/dpll_netlink.c
> index 314bb3775465..4ca9ad16cd95 100644
> --- a/drivers/dpll/dpll_netlink.c
> +++ b/drivers/dpll/dpll_netlink.c
> @@ -1199,6 +1199,7 @@ int dpll_nl_pin_get_dumpit(struct sk_buff *skb, struct netlink_callback *cb)
>   	unsigned long i;
>   	int ret = 0;
>   
> +	mutex_lock(&dpll_lock);
>   	xa_for_each_marked_start(&dpll_pin_xa, i, pin, DPLL_REGISTERED,
>   				 ctx->idx) {
>   		if (!dpll_pin_available(pin))
> @@ -1218,6 +1219,8 @@ int dpll_nl_pin_get_dumpit(struct sk_buff *skb, struct netlink_callback *cb)
>   		}
>   		genlmsg_end(skb, hdr);
>   	}
> +	mutex_unlock(&dpll_lock);
> +
>   	if (ret == -EMSGSIZE) {
>   		ctx->idx = i;
>   		return skb->len;
> @@ -1373,6 +1376,7 @@ int dpll_nl_device_get_dumpit(struct sk_buff *skb, struct netlink_callback *cb)
>   	unsigned long i;
>   	int ret = 0;
>   
> +	mutex_lock(&dpll_lock);
>   	xa_for_each_marked_start(&dpll_device_xa, i, dpll, DPLL_REGISTERED,
>   				 ctx->idx) {
>   		hdr = genlmsg_put(skb, NETLINK_CB(cb->skb).portid,
> @@ -1389,6 +1393,8 @@ int dpll_nl_device_get_dumpit(struct sk_buff *skb, struct netlink_callback *cb)
>   		}
>   		genlmsg_end(skb, hdr);
>   	}
> +	mutex_unlock(&dpll_lock);
> +
>   	if (ret == -EMSGSIZE) {
>   		ctx->idx = i;
>   		return skb->len;
> @@ -1439,20 +1445,6 @@ dpll_unlock_doit(const struct genl_split_ops *ops, struct sk_buff *skb,
>   	mutex_unlock(&dpll_lock);
>   }
>   
> -int dpll_lock_dumpit(struct netlink_callback *cb)
> -{
> -	mutex_lock(&dpll_lock);
> -
> -	return 0;
> -}
> -
> -int dpll_unlock_dumpit(struct netlink_callback *cb)
> -{
> -	mutex_unlock(&dpll_lock);
> -
> -	return 0;
> -}
> -
>   int dpll_pin_pre_doit(const struct genl_split_ops *ops, struct sk_buff *skb,
>   		      struct genl_info *info)
>   {
> diff --git a/drivers/dpll/dpll_nl.c b/drivers/dpll/dpll_nl.c
> index eaee5be7aa64..1e95f5397cfc 100644
> --- a/drivers/dpll/dpll_nl.c
> +++ b/drivers/dpll/dpll_nl.c
> @@ -95,9 +95,7 @@ static const struct genl_split_ops dpll_nl_ops[] = {
>   	},
>   	{
>   		.cmd	= DPLL_CMD_DEVICE_GET,
> -		.start	= dpll_lock_dumpit,
>   		.dumpit	= dpll_nl_device_get_dumpit,
> -		.done	= dpll_unlock_dumpit,
>   		.flags	= GENL_ADMIN_PERM | GENL_CMD_CAP_DUMP,
>   	},
>   	{
> @@ -129,9 +127,7 @@ static const struct genl_split_ops dpll_nl_ops[] = {
>   	},
>   	{
>   		.cmd		= DPLL_CMD_PIN_GET,
> -		.start		= dpll_lock_dumpit,
>   		.dumpit		= dpll_nl_pin_get_dumpit,
> -		.done		= dpll_unlock_dumpit,
>   		.policy		= dpll_pin_get_dump_nl_policy,
>   		.maxattr	= DPLL_A_PIN_ID,
>   		.flags		= GENL_ADMIN_PERM | GENL_CMD_CAP_DUMP,


