Return-Path: <netdev+bounces-249339-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [IPv6:2600:3c09:e001:a7::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 1C85DD16E0F
	for <lists+netdev@lfdr.de>; Tue, 13 Jan 2026 07:43:44 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id 55B5C30081BA
	for <lists+netdev@lfdr.de>; Tue, 13 Jan 2026 06:43:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4BBD6364E9E;
	Tue, 13 Jan 2026 06:43:41 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from mx3.molgen.mpg.de (mx3.molgen.mpg.de [141.14.17.11])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BE6E135CB8D;
	Tue, 13 Jan 2026 06:43:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=141.14.17.11
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768286621; cv=none; b=HFr1tT7MQjJbiXQaMmcwnf6YB5QATqTKtvJxt6JzD8KdXZ1/M1WZLT2jHI6p5pbAeSKie0IsPYhLS/3BRzK6Fkp80KarkQlCe+wxSpvbZakdvBcnX2UJg2+dtJkPPF1RqsPvBSJ71GO8g9/GO2OOchvSVlXLh8OUPZ2AEGqnpa4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768286621; c=relaxed/simple;
	bh=8nblPW4HHXnqfNFD77upb94X/SiBdGAGQIsudbK5C9w=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=uoTWJ/sPdO4wN8gaJsrJvDVaalBY6poWFVFNEs6a8+Bmh2I1HYcPzR75HEHDq7q/9OYkeMSyBHxhTSOhO+FxbDmCe0ZAQpJ10+46hzpq4IEvqq//YDI5uN/sbuEcbYoMh6NqKHiPUakRAlJCcno8ZPubc+8S+FC4EyiMdlE4YNg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=molgen.mpg.de; spf=pass smtp.mailfrom=molgen.mpg.de; arc=none smtp.client-ip=141.14.17.11
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=molgen.mpg.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=molgen.mpg.de
Received: from [192.168.2.217] (p5b13a4a0.dip0.t-ipconnect.de [91.19.164.160])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: pmenzel)
	by mx.molgen.mpg.de (Postfix) with ESMTPSA id B12CF2387DCE2;
	Tue, 13 Jan 2026 07:43:10 +0100 (CET)
Message-ID: <60a8b40a-0f98-46e9-9d3e-9ff3fef745c2@molgen.mpg.de>
Date: Tue, 13 Jan 2026 07:43:07 +0100
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [Intel-wired-lan] [PATCH 2/2] idpf: skip deallocating txq group's
 txqs if it is NULL.
To: Li Li <boolli@google.com>
Cc: Tony Nguyen <anthony.l.nguyen@intel.com>,
 Przemek Kitszel <przemyslaw.kitszel@intel.com>,
 "David S. Miller" <davem@davemloft.net>, Jakub Kicinski <kuba@kernel.org>,
 Eric Dumazet <edumazet@google.com>, intel-wired-lan@lists.osuosl.org,
 netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
 David Decotigny <decot@google.com>, Anjali Singhai
 <anjali.singhai@intel.com>, Sridhar Samudrala <sridhar.samudrala@intel.com>,
 Brian Vazquez <brianvv@google.com>, emil.s.tantilov@intel.com
References: <20260112230944.3085309-1-boolli@google.com>
 <20260112230944.3085309-3-boolli@google.com>
Content-Language: en-US
From: Paul Menzel <pmenzel@molgen.mpg.de>
In-Reply-To: <20260112230944.3085309-3-boolli@google.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

Dear Li,


Thank you for your patch.

Am 13.01.26 um 00:09 schrieb Li Li:
> In idpf_txq_group_alloc(), if any txq group's txqs failed to
> allocate memory:
> 
> 	for (j = 0; j < tx_qgrp->num_txq; j++) {
> 		tx_qgrp->txqs[j] = kzalloc(sizeof(*tx_qgrp->txqs[j]),
> 					   GFP_KERNEL);
> 		if (!tx_qgrp->txqs[j])
> 			goto err_alloc;
> 	}
> 
> It would cause a NULL ptr kernel panic in idpf_txq_group_rel():
> 
> 	for (j = 0; j < txq_grp->num_txq; j++) {
> 		if (flow_sch_en) {
> 			kfree(txq_grp->txqs[j]->refillq);
> 			txq_grp->txqs[j]->refillq = NULL;
> 		}
> 
> 		kfree(txq_grp->txqs[j]);
> 		txq_grp->txqs[j] = NULL;
> 	}
> 
> [    6.532461] BUG: kernel NULL pointer dereference, address: 0000000000000058
> ...
> [    6.534433] RIP: 0010:idpf_txq_group_rel+0xc9/0x110
> ...
> [    6.538513] Call Trace:
> [    6.538639]  <TASK>
> [    6.538760]  idpf_vport_queues_alloc+0x75/0x550
> [    6.538978]  idpf_vport_open+0x4d/0x3f0
> [    6.539164]  idpf_open+0x71/0xb0
> [    6.539324]  __dev_open+0x142/0x260
> [    6.539506]  netif_open+0x2f/0xe0
> [    6.539670]  dev_open+0x3d/0x70
> [    6.539827]  bond_enslave+0x5ed/0xf50
> [    6.540005]  ? rcutree_enqueue+0x1f/0xb0
> [    6.540193]  ? call_rcu+0xde/0x2a0
> [    6.540375]  ? barn_get_empty_sheaf+0x5c/0x80
> [    6.540594]  ? __kfree_rcu_sheaf+0xb6/0x1a0
> [    6.540793]  ? nla_put_ifalias+0x3d/0x90
> [    6.540981]  ? kvfree_call_rcu+0xb5/0x3b0
> [    6.541173]  ? kvfree_call_rcu+0xb5/0x3b0
> [    6.541365]  do_set_master+0x114/0x160
> [    6.541547]  do_setlink+0x412/0xfb0
> [    6.541717]  ? security_sock_rcv_skb+0x2a/0x50
> [    6.541931]  ? sk_filter_trim_cap+0x7c/0x320
> [    6.542136]  ? skb_queue_tail+0x20/0x50
> [    6.542322]  ? __nla_validate_parse+0x92/0xe50 ro[o t   t o6 .d5e4f2a5u4l0t]-  ? security_capable+0x35/0x60
> [    6.542792]  rtnl_newlink+0x95c/0xa00
> [    6.542972]  ? __rtnl_unlock+0x37/0x70
> [    6.543152]  ? netdev_run_todo+0x63/0x530
> [    6.543343]  ? allocate_slab+0x280/0x870
> [    6.543531]  ? security_capable+0x35/0x60
> [    6.543722]  rtnetlink_rcv_msg+0x2e6/0x340
> [    6.543918]  ? __pfx_rtnetlink_rcv_msg+0x10/0x10
> [    6.544138]  netlink_rcv_skb+0x16a/0x1a0
> [    6.544328]  netlink_unicast+0x20a/0x320
> [    6.544516]  netlink_sendmsg+0x304/0x3b0
> [    6.544748]  __sock_sendmsg+0x89/0xb0
> [    6.544928]  ____sys_sendmsg+0x167/0x1c0
> [    6.545116]  ? ____sys_recvmsg+0xed/0x150
> [    6.545308]  ___sys_sendmsg+0xdd/0x120
> [    6.545489]  ? ___sys_recvmsg+0x124/0x1e0
> [    6.545680]  ? rcutree_enqueue+0x1f/0xb0
> [    6.545867]  ? rcutree_enqueue+0x1f/0xb0
> [    6.546055]  ? call_rcu+0xde/0x2a0
> [    6.546222]  ? evict+0x286/0x2d0
> [    6.546389]  ? rcutree_enqueue+0x1f/0xb0
> [    6.546577]  ? kmem_cache_free+0x2c/0x350
> [    6.546784]  __x64_sys_sendmsg+0x72/0xc0
> [    6.546972]  do_syscall_64+0x6f/0x890
> [    6.547150]  entry_SYSCALL_64_after_hwframe+0x76/0x7e
> [    6.547393] RIP: 0033:0x7fc1a3347bd0
> ...
> [    6.551375] RIP: 0010:idpf_txq_group_rel+0xc9/0x110
> ...
> [    6.578856] Rebooting in 10 seconds..
> 
> We should skip deallocating txqs[j] if it is NULL in the first place.
> 
> Tested: with this patch, the kernel panic no longer appears.

The reproduction steps would be nice to have documented.

> Fixes: 1c325aac10a8 ("idpf: configure resources for TX queues")
> 
> Signed-off-by: Li Li <boolli@google.com>
> ---
>   drivers/net/ethernet/intel/idpf/idpf_txrx.c | 3 +++
>   1 file changed, 3 insertions(+)
> 
> diff --git a/drivers/net/ethernet/intel/idpf/idpf_txrx.c b/drivers/net/ethernet/intel/idpf/idpf_txrx.c
> index b4dab4a8ee11b..25207da6c995d 100644
> --- a/drivers/net/ethernet/intel/idpf/idpf_txrx.c
> +++ b/drivers/net/ethernet/intel/idpf/idpf_txrx.c
> @@ -1311,6 +1311,9 @@ static void idpf_txq_group_rel(struct idpf_vport *vport)
>   		struct idpf_txq_group *txq_grp = &vport->txq_grps[i];
>   
>   		for (j = 0; j < txq_grp->num_txq; j++) {
> +			if (!txq_grp->txqs[j])
> +				continue;
> +
>   			if (flow_sch_en) {
>   				kfree(txq_grp->txqs[j]->refillq);
>   				txq_grp->txqs[j]->refillq = NULL;

Reviewed-by: Paul Menzel <pmenzel@molgen.mpg.de>


Kind regards,

Paul

