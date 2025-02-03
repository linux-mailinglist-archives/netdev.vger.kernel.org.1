Return-Path: <netdev+bounces-162309-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id AB9A1A267F0
	for <lists+netdev@lfdr.de>; Tue,  4 Feb 2025 00:36:43 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 5CD2A3A1EEE
	for <lists+netdev@lfdr.de>; Mon,  3 Feb 2025 23:36:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D888620FA8E;
	Mon,  3 Feb 2025 23:36:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="rOgRIgcr"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B1E1B1E7C19
	for <netdev@vger.kernel.org>; Mon,  3 Feb 2025 23:36:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1738625794; cv=none; b=X3oLglXDZ4V/V3Cs8TwRmfCFiNhhEu+MP+OmxNGEmfkDQQ4tAOWDG73LjdXJWdV/qcEE+mlykqsGiL7YAjt6V56iHj+sS80lcFHHxysdyeBVsQpjvLAPYW85V3oGVporEuQ0YTJBr+fbBUF8VEm1LhVyPDVXxk6vEqYhBwfUBuA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1738625794; c=relaxed/simple;
	bh=hVHMsnDJkVN4Y89zn9wdETNaL+MlpWPIdO11yhc81hQ=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=Tn2JMyEWwHlR1g7chCW5+IP+5T5RBjWUQjtDO3LfkIeWOwViC7vhzlXmrPZ33qt669mG/ZXWQdb7PrPrCa54agtBwo9iQ59f8dcDOQbNCnm54taDD+AoeGNzwA5R3aq9Dx/v7a4be8sjDC0N26Z/4hrd/qR/qtZKmHj/shniGqc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=rOgRIgcr; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D2BEAC4CEE0;
	Mon,  3 Feb 2025 23:36:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1738625794;
	bh=hVHMsnDJkVN4Y89zn9wdETNaL+MlpWPIdO11yhc81hQ=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=rOgRIgcruVNjhMikgLwBI81Q9YiDUlc8Uob6HZxa1cPGO3V269VyGF01mSNWp0N6Q
	 3D9C9z9itM3nMp4LHK6tdKrE7nBkJYm4VTjtdAC6lL6642Es9gC9Bi/2517lnRT6bU
	 /St3Es+TlaDoJoOgjT7BUhQKN72sDqLrMndEZgydQlAXatTCoE/yy5K0gsj/iKcOql
	 BFQl8nF8pmxTpwS4uHZwpx945fv4yAIfmys99ArX8ywzJ2issVSdqqNF11B7zzu79S
	 MDxzzyPwcU4x94KW0B4rYcu8ly6CtvJvIh+hx9jx6ghGfz39Gs0EhV6EOUnawwDv39
	 Uncr2llSApg5g==
Date: Mon, 3 Feb 2025 15:36:33 -0800
From: Jakub Kicinski <kuba@kernel.org>
To: Eric Dumazet <edumazet@google.com>
Cc: "David S . Miller" <davem@davemloft.net>, Paolo Abeni
 <pabeni@redhat.com>, netdev@vger.kernel.org, Kuniyuki Iwashima
 <kuniyu@amazon.com>, Simon Horman <horms@kernel.org>,
 eric.dumazet@gmail.com
Subject: Re: [PATCH v2 net 09/16] ipv4: icmp: convert to dev_net_rcu()
Message-ID: <20250203153633.46ce0337@kernel.org>
In-Reply-To: <20250203143046.3029343-10-edumazet@google.com>
References: <20250203143046.3029343-1-edumazet@google.com>
	<20250203143046.3029343-10-edumazet@google.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Mon,  3 Feb 2025 14:30:39 +0000 Eric Dumazet wrote:
> @@ -611,9 +611,9 @@ void __icmp_send(struct sk_buff *skb_in, int type, int code, __be32 info,
>  		goto out;
>  
>  	if (rt->dst.dev)
> -		net = dev_net(rt->dst.dev);
> +		net = dev_net_rcu(rt->dst.dev);
>  	else if (skb_in->dev)
> -		net = dev_net(skb_in->dev);
> +		net = dev_net_rcu(skb_in->dev);
>  	else
>  		goto out;

Hm. Weird. NIPA says this one is not under RCU.

[  275.730657][    C1] ./include/net/net_namespace.h:404 suspicious rcu_dereference_check() usage!
[  275.731033][    C1] 
[  275.731033][    C1] other info that might help us debug this:
[  275.731033][    C1] 
[  275.731471][    C1] 
[  275.731471][    C1] rcu_scheduler_active = 2, debug_locks = 1
[  275.731799][    C1] 1 lock held by swapper/1/0:
[  275.732000][    C1]  #0: ffffc900001e0ae8 ((&n->timer)){+.-.}-{0:0}, at: call_timer_fn+0xe8/0x230
[  275.732354][    C1] 
[  275.732354][    C1] stack backtrace:
[  275.732638][    C1] CPU: 1 UID: 0 PID: 0 Comm: swapper/1 Not tainted 6.13.0-virtme #1
[  275.732643][    C1] Hardware name: Bochs Bochs, BIOS Bochs 01/01/2011
[  275.732646][    C1] Call Trace:
[  275.732647][    C1]  <IRQ>
[  275.732651][    C1]  dump_stack_lvl+0xb0/0xd0
[  275.732663][    C1]  lockdep_rcu_suspicious+0x1ea/0x280
[  275.732678][    C1]  __icmp_send+0xb0d/0x1580
[  275.732695][    C1]  ? tcp_data_queue+0x8/0x22d0
[  275.732701][    C1]  ? lockdep_hardirqs_on_prepare+0x12b/0x410
[  275.732712][    C1]  ? __pfx___icmp_send+0x10/0x10
[  275.732719][    C1]  ? tcp_check_space+0x3ce/0x5f0
[  275.732742][    C1]  ? rcu_read_lock_any_held+0x43/0xb0
[  275.732750][    C1]  ? validate_chain+0x1fe/0xae0
[  275.732771][    C1]  ? __pfx_validate_chain+0x10/0x10
[  275.732778][    C1]  ? hlock_class+0x4e/0x130
[  275.732784][    C1]  ? mark_lock+0x38/0x3e0
[  275.732788][    C1]  ? sock_put+0x1a/0x60
[  275.732806][    C1]  ? __lock_acquire+0xb9a/0x1680
[  275.732822][    C1]  ipv4_send_dest_unreach+0x3b4/0x800
[  275.732829][    C1]  ? neigh_invalidate+0x1c7/0x540
[  275.732837][    C1]  ? __pfx_ipv4_send_dest_unreach+0x10/0x10
[  275.732850][    C1]  ipv4_link_failure+0x1b/0x190
[  275.732856][    C1]  arp_error_report+0x96/0x170
[  275.732862][    C1]  neigh_invalidate+0x209/0x540
[  275.732873][    C1]  neigh_timer_handler+0x87a/0xdf0
[  275.732883][    C1]  ? __pfx_neigh_timer_handler+0x10/0x10
[  275.732886][    C1]  call_timer_fn+0x13b/0x230
[  275.732891][    C1]  ? call_timer_fn+0xe8/0x230
[  275.732894][    C1]  ? call_timer_fn+0xe8/0x230
[  275.732899][    C1]  ? __pfx_call_timer_fn+0x10/0x10
[  275.732902][    C1]  ? mark_lock+0x38/0x3e0
[  275.732920][    C1]  __run_timers+0x545/0x810
[  275.732925][    C1]  ? __pfx_neigh_timer_handler+0x10/0x10
[  275.732936][    C1]  ? __pfx___run_timers+0x10/0x10
[  275.732939][    C1]  ? __lock_release+0x103/0x460
[  275.732947][    C1]  ? do_raw_spin_lock+0x131/0x270
[  275.732952][    C1]  ? __pfx_do_raw_spin_lock+0x10/0x10
[  275.732956][    C1]  ? lock_acquire+0x32/0xc0
[  275.732958][    C1]  ? timer_expire_remote+0x96/0xf0
[  275.732967][    C1]  timer_expire_remote+0x9e/0xf0
[  275.732970][    C1]  tmigr_handle_remote_cpu+0x278/0x440
[  275.732977][    C1]  ? __pfx_tmigr_handle_remote_cpu+0x10/0x10
[  275.732981][    C1]  ? __pfx___lock_release+0x10/0x10
[  275.732985][    C1]  ? __pfx_lock_acquire.part.0+0x10/0x10
[  275.733015][    C1]  tmigr_handle_remote_up+0x1a6/0x270
[  275.733027][    C1]  ? __pfx_tmigr_handle_remote_up+0x10/0x10
[  275.733036][    C1]  __walk_groups.isra.0+0x44/0x160
[  275.733051][    C1]  tmigr_handle_remote+0x20b/0x300

Decoded:
https://netdev-3.bots.linux.dev/vmksft-mptcp-dbg/results/976941/vm-crash-thr0-1

