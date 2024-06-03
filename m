Return-Path: <netdev+bounces-100317-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 9EEBB8D8886
	for <lists+netdev@lfdr.de>; Mon,  3 Jun 2024 20:21:24 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id CDFC61C2193C
	for <lists+netdev@lfdr.de>; Mon,  3 Jun 2024 18:21:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 24963137C3C;
	Mon,  3 Jun 2024 18:21:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="LL1cwgaM"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F23C913440A
	for <netdev@vger.kernel.org>; Mon,  3 Jun 2024 18:21:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717438880; cv=none; b=RY0N2lQLvPVnBpiC+m0ij5Va8bzAAr2J0QaeEb1/zFvQYJHdDQYJ96bi2uGA5MpFER+tptVs8SrDlCnSBam1ADJc4j7qr0faVXCDavgmhT/NnpvjKCKmN9kI08onyx1aG+Ua6llORneU8NZrJ3KyhFJaI0qcn3YVq4NTnFfCDd0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717438880; c=relaxed/simple;
	bh=3Fn64sKfrxKDF8xR51D9WwRt+gPjXTaku6LPuk4DDnY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=s171RGUllQYWylI3kClHNOAL1Niqu6TJ3bFc7BRWU1fKpYLENrMPqzzb53QsZNrXihA+Sakns9Xfi9RQD5BKUSoQxcK1gnViOIqxUdrIxY/Gz0fbphFMiYITCY5RrdpjY8lWlf522bnrnevHs+QcqZTxF1pdIi/p7K6f+U9qP2k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=LL1cwgaM; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 76774C2BD10;
	Mon,  3 Jun 2024 18:21:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1717438879;
	bh=3Fn64sKfrxKDF8xR51D9WwRt+gPjXTaku6LPuk4DDnY=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=LL1cwgaMi3tDyuicwVaFOu7xU1u2oWhKK6MI4AkUUOGFeLpYlg3rg9TNBuYnzlp3g
	 ndApycOq7p7lox9ShC9av1Q1dNCJwjB9aKVYByg6czDVUCEzL9qDpgfuAc5V66QvmZ
	 eibV3i7Ni/cnctQU5NXXZ6Hy2mZkzmih0ZzohndAtIKmnVS82/Hx/0cDXtxiTs7exT
	 y5neM3EKGG7qZbc4izWI9gbEILXPC3Hi9EnAK8UBkLo9OMb4h0OyQwY1ArDbOH1UTt
	 IYQVv/LqhwM/ldPLjfydSTMcguoPg2TXN0QAj7xPS8OQyk4KMR/h2mzTh4HW2T8Q0m
	 0F14gio2fFRMw==
Date: Mon, 3 Jun 2024 19:21:16 +0100
From: Simon Horman <horms@kernel.org>
To: Jianguo Wu <wujianguo106@163.com>
Cc: netdev <netdev@vger.kernel.org>, contact@proelbtn.com,
	pablo@netfilter.org, David Ahern <dsahern@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>
Subject: Re: [PATCH net-next] seg6: fix parameter passing when calling
 NF_HOOK() in End.DX4 and End.DX6 behaviors
Message-ID: <20240603182116.GJ491852@kernel.org>
References: <2a78f16a-0ff5-46bf-983b-9ab038f5a5cd@163.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <2a78f16a-0ff5-46bf-983b-9ab038f5a5cd@163.com>

On Thu, May 30, 2024 at 03:43:38PM +0800, Jianguo Wu wrote:
> From: Jianguo Wu <wujianguo@chinatelecom.cn>
> 
> input_action_end_dx4() and input_action_end_dx6() call NF_HOOK() for PREROUTING hook,
> for PREROUTING hook, we should passing a valid indev, and a NULL outdev to NF_HOOK(),
> otherwise may trigger a NULL pointer dereference, as below:

nit: The text above should be line-wrapped so that it is
     no more than 75 columns wide.

Link: https://www.kernel.org/doc/html/latest/process/submitting-patches.html#describe-your-changes

> 
>     [74830.647293] BUG: kernel NULL pointer dereference, address: 0000000000000090
>     [74830.655633] #PF: supervisor read access in kernel mode
>     [74830.657888] #PF: error_code(0x0000) - not-present page
>     [74830.659500] PGD 0 P4D 0
>     [74830.660450] Oops: 0000 [#1] PREEMPT SMP PTI
>     ...
>     [74830.664953] Hardware name: Red Hat KVM, BIOS 0.5.1 01/01/2011
>     [74830.666569] RIP: 0010:rpfilter_mt+0x44/0x15e [ipt_rpfilter]
>     ...
>     [74830.689725] Call Trace:
>     [74830.690402]  <IRQ>
>     [74830.690953]  ? show_trace_log_lvl+0x1c4/0x2df
>     [74830.692020]  ? show_trace_log_lvl+0x1c4/0x2df
>     [74830.693095]  ? ipt_do_table+0x286/0x710 [ip_tables]
>     [74830.694275]  ? __die_body.cold+0x8/0xd
>     [74830.695205]  ? page_fault_oops+0xac/0x140
>     [74830.696244]  ? exc_page_fault+0x62/0x150
>     [74830.697225]  ? asm_exc_page_fault+0x22/0x30
>     [74830.698344]  ? rpfilter_mt+0x44/0x15e [ipt_rpfilter]
>     [74830.699540]  ipt_do_table+0x286/0x710 [ip_tables]
>     [74830.700758]  ? ip6_route_input+0x19d/0x240
>     [74830.701752]  nf_hook_slow+0x3f/0xb0
>     [74830.702678]  input_action_end_dx4+0x19b/0x1e0
>     [74830.703735]  ? input_action_end_t+0xe0/0xe0
>     [74830.704734]  seg6_local_input_core+0x2d/0x60
>     [74830.705782]  lwtunnel_input+0x5b/0xb0
>     [74830.706690]  __netif_receive_skb_one_core+0x63/0xa0
>     [74830.707825]  process_backlog+0x99/0x140
>     [74830.709538]  __napi_poll+0x2c/0x160
>     [74830.710673]  net_rx_action+0x296/0x350
>     [74830.711860]  __do_softirq+0xcb/0x2ac
>     [74830.713049]  do_softirq+0x63/0x90
> 
> input_action_end_dx4() passing a NULL indev to NF_HOOK(), and finally trigger a
> NULL dereference in rpfilter_mt()->rpfilter_is_loopback():
>     static bool
>     rpfilter_is_loopback(const struct sk_buff *skb, const struct net_device *in)
>     {
>             // in is NULL
>             return skb->pkt_type == PACKET_LOOPBACK || in->flags & IFF_LOOPBACK;
>     }
> 
> Fixes: 7a3f5b0de364 ("netfilter: add netfilter hooks to SRv6 data plane")

nit: no blank line here.

> 
> Signed-off-by: Jianguo Wu <wujianguo@chinatelecom.cn>

I am slightly puzzled that this bug was in
the tree for so long without being noticed.

But the above not withstanding, this looks good to me.

Reviewed-by: Simon Horman <horms@kernel.org>

...

