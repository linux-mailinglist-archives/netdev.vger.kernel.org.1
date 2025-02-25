Return-Path: <netdev+bounces-169554-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 12532A44904
	for <lists+netdev@lfdr.de>; Tue, 25 Feb 2025 18:54:28 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id B23E316A107
	for <lists+netdev@lfdr.de>; Tue, 25 Feb 2025 17:53:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A25BA19DF4F;
	Tue, 25 Feb 2025 17:52:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="WpTiRDw0"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 78FF5156F3A;
	Tue, 25 Feb 2025 17:52:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740505970; cv=none; b=Hm2lM2PMR0uQJFoP/Y54MupDkMuyG68MEOKlD6SCKy1wyGb29uxT6cfspVp7vNG/we05Sq2XqGMDyCBDPg6UmQG9AaCTKa79RldjM0TSK6rDj45tHjfaCbkHBcI0BgpdnzID39UsdX8ur+9HvCiX035dNBtB43POtg1Khwg6s+0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740505970; c=relaxed/simple;
	bh=d0t9rXLhHAXX0NVT+x5MRPfAjVyc1kKHxRNBrEIT23s=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=lLe16Rs3oM9IQOf3oSjchYLdi21tB15GOie5hyOiDDV15z7rHeTpqQB+qLxPEKXQVPAJVf8LaZpUIJE4mJtCHoaZbIESev/lTUhfGvbF4tSLaNxnuXRfy5cObwv6jT8RGpyHivM6BgkzuPNWmZ3qJhrTQbPN42p3XzmtLv4xff8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=WpTiRDw0; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4E3E9C4CEDD;
	Tue, 25 Feb 2025 17:52:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1740505970;
	bh=d0t9rXLhHAXX0NVT+x5MRPfAjVyc1kKHxRNBrEIT23s=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=WpTiRDw0wjnGHw0Ox0FmOD2AlDKO02UVoOewDYRyi+AjjEnwBQzvDi7f3/aPlPskf
	 y0rMtlzQhcYnJ6vHYE/UCnqUNw0sSxdc8SFRbDxNCrKcWa0cwjzYuDYaBvZ2KuyzVF
	 VEPI1HbxIVSWJujVOqpf10Eze1gOpHAN8CWHH+0S1NH1Txr73iW5scNeF2brOiUfIz
	 3AePUWc217KeTcMdegW7foOXi2u7zJrOHvT8PvhU/TAmiTksQeJ2boN8Kqgh6gT4Bj
	 9sJUJJypTnqDIGSLQSM+FNAJ3iixeGAuGNOF8dXrW8t3iX+b9TvKZnkVwI6oh8PR+n
	 yyRTCVT6pEn9w==
Message-ID: <e8039b96-1765-4464-b534-d6d1385b46eb@kernel.org>
Date: Tue, 25 Feb 2025 18:52:45 +0100
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird Beta
Subject: Re: [PATCH v2 mptcp] mptcp: fix 'scheduling while atomic' in
 mptcp_pm_nl_append_new_local_addr
Content-Language: en-GB
To: Krister Johansen <kjlx@templeofstupid.com>,
 Mat Martineau <martineau@kernel.org>
Cc: Geliang Tang <geliang@kernel.org>, "David S. Miller"
 <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>,
 Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
 Simon Horman <horms@kernel.org>, netdev@vger.kernel.org,
 mptcp@lists.linux.dev
References: <9ef28d50-dad0-4dc6-8a6d-b3f82521fba1@redhat.com>
 <20250224232012.GA7359@templeofstupid.com>
From: Matthieu Baerts <matttbe@kernel.org>
Autocrypt: addr=matttbe@kernel.org; keydata=
 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
 lzVbFe7fduHbABmYz9cefQpO7wDE/Q==
Organization: NGI0 Core
In-Reply-To: <20250224232012.GA7359@templeofstupid.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

Hi Krister,

On 25/02/2025 00:20, Krister Johansen wrote:
> If multiple connection requests attempt to create an implicit mptcp
> endpoint in parallel, more than one caller may end up in
> mptcp_pm_nl_append_new_local_addr because none found the address in
> local_addr_list during their call to mptcp_pm_nl_get_local_id.  In this
> case, the concurrent new_local_addr calls may delete the address entry
> created by the previous caller.  These deletes use synchronize_rcu, but
> this is not permitted in some of the contexts where this function may be
> called.  During packet recv, the caller may be in a rcu read critical
> section and have preemption disabled.

Thank you for this patch, and for having taken the time to analyse the
issue!

> An example stack:
> 
>    BUG: scheduling while atomic: swapper/2/0/0x00000302
> 
>    Call Trace:
>    <IRQ>
>    dump_stack_lvl+0x76/0xa0
>    dump_stack+0x10/0x20
>    __schedule_bug+0x64/0x80
>    schedule_debug.constprop.0+0xdb/0x130
>    __schedule+0x69/0x6a0
>    schedule+0x33/0x110
>    schedule_timeout+0x157/0x170
>    wait_for_completion+0x88/0x150
>    __wait_rcu_gp+0x150/0x160
>    synchronize_rcu+0x12d/0x140
>    mptcp_pm_nl_append_new_local_addr+0x1bd/0x280
>    mptcp_pm_nl_get_local_id+0x121/0x160
>    mptcp_pm_get_local_id+0x9d/0xe0
>    subflow_check_req+0x1a8/0x460
>    subflow_v4_route_req+0xb5/0x110
>    tcp_conn_request+0x3a4/0xd00
>    subflow_v4_conn_request+0x42/0xa0
>    tcp_rcv_state_process+0x1e3/0x7e0
>    tcp_v4_do_rcv+0xd3/0x2a0
>    tcp_v4_rcv+0xbb8/0xbf0
>    ip_protocol_deliver_rcu+0x3c/0x210
>    ip_local_deliver_finish+0x77/0xa0
>    ip_local_deliver+0x6e/0x120
>    ip_sublist_rcv_finish+0x6f/0x80
>    ip_sublist_rcv+0x178/0x230
>    ip_list_rcv+0x102/0x140
>    __netif_receive_skb_list_core+0x22d/0x250
>    netif_receive_skb_list_internal+0x1a3/0x2d0
>    napi_complete_done+0x74/0x1c0
>    igb_poll+0x6c/0xe0 [igb]
>    __napi_poll+0x30/0x200
>    net_rx_action+0x181/0x2e0
>    handle_softirqs+0xd8/0x340
>    __irq_exit_rcu+0xd9/0x100
>    irq_exit_rcu+0xe/0x20
>    common_interrupt+0xa4/0xb0
>    </IRQ>
Detail: if possible, next time, do not hesitate to resolve the
addresses, e.g. using: ./scripts/decode_stacktrace.sh

> This problem seems particularly prevalent if the user advertises an
> endpoint that has a different external vs internal address.  In the case
> where the external address is advertised and multiple connections
> already exist, multiple subflow SYNs arrive in parallel which tends to
> trigger the race during creation of the first local_addr_list entries
> which have the internal address instead.
> 
> Fix by skipping the replacement of an existing implicit local address if
> called via mptcp_pm_nl_get_local_id.
The v2 looks good to me:

Reviewed-by: Matthieu Baerts (NGI0) <matttbe@kernel.org>

I'm going to apply it in our MPTCP tree, but this patch can also be
directly applied in the net tree directly, not to delay it by one week
if preferred. If not, I can re-send it later on.

Cheers,
Matt
-- 
Sponsored by the NGI0 Core fund.


