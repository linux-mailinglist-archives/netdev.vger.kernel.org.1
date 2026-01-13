Return-Path: <netdev+bounces-249337-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 683E8D16D9A
	for <lists+netdev@lfdr.de>; Tue, 13 Jan 2026 07:33:40 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 425C3304BD31
	for <lists+netdev@lfdr.de>; Tue, 13 Jan 2026 06:32:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DD41429D27D;
	Tue, 13 Jan 2026 06:32:20 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from mx3.molgen.mpg.de (mx3.molgen.mpg.de [141.14.17.11])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D84C01F03D2;
	Tue, 13 Jan 2026 06:32:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=141.14.17.11
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768285940; cv=none; b=B/oWzEFYI64AXkwJHhTxJhU91R0hbOI1afPiITb/kcWRsJVryfHgn3lBo4D7uaxESB3LiIMMPGLL/tagMOzfrSqoLOw0u4gkrmDJIfKLYTagMksDO/EDX/pF4dIf1OxuIaesbv32dEFAYZJ4dIpmEwuzzlClaI9q8gGOOJZVRiU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768285940; c=relaxed/simple;
	bh=UA31FQf1viklPq7HWKsmKC1TjuApN6+rsemqkYi7wxo=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=JTZm5hdc7DnBSCxf2FNyVwlO8UmPa9GiR3e+T+t55B6vDO+T/N8oO+3fkgrmf3+/a9LKMVEasj+j6K0g6F9A9lqCN9r0NKWdeXMU5SM+qVMAaNnNDuHx6JNujEmsqewIQFo6YJHjIOaS4x3pHVcFVGGcXGt2k4jXTGHirrs+JxA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=molgen.mpg.de; spf=pass smtp.mailfrom=molgen.mpg.de; arc=none smtp.client-ip=141.14.17.11
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=molgen.mpg.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=molgen.mpg.de
Received: from [192.168.2.217] (p5b13a4a0.dip0.t-ipconnect.de [91.19.164.160])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: pmenzel)
	by mx.molgen.mpg.de (Postfix) with ESMTPSA id D52C123997D77;
	Tue, 13 Jan 2026 07:31:29 +0100 (CET)
Message-ID: <164caca4-f57f-4363-a8f1-0e090a4eb192@molgen.mpg.de>
Date: Tue, 13 Jan 2026 07:31:26 +0100
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [Intel-wired-lan] [PATCH 1/2] idpf: skip deallocating bufq_sets
 from rx_qgrp if it is NULL.
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
 <20260112230944.3085309-2-boolli@google.com>
Content-Language: en-US
From: Paul Menzel <pmenzel@molgen.mpg.de>
In-Reply-To: <20260112230944.3085309-2-boolli@google.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

Dear Li,


Thank you for your patch.

Am 13.01.26 um 00:09 schrieb Li Li via Intel-wired-lan:
> In idpf_rxq_group_alloc(), if rx_qgrp->splitq.bufq_sets failed to get
> allocated:
> 
> 	rx_qgrp->splitq.bufq_sets = kcalloc(vport->num_bufqs_per_qgrp,
> 					    sizeof(struct idpf_bufq_set),
> 					    GFP_KERNEL);
> 	if (!rx_qgrp->splitq.bufq_sets) {
> 		err = -ENOMEM;
> 		goto err_alloc;
> 	}
> 
> idpf_rxq_group_rel() would attempt to deallocate it in
> idpf_rxq_sw_queue_rel(), causing a kernel panic:
> 
> ```
> [    7.967242] early-network-sshd-n-rexd[3148]: knetbase: Info: [    8.127804] BUG: kernel NULL pointer dereference, address: 00000000000000c0
> ...
> [    8.129779] RIP: 0010:idpf_rxq_group_rel+0x101/0x170
> ...
> [    8.133854] Call Trace:
> [    8.133980]  <TASK>
> [    8.134092]  idpf_vport_queues_alloc+0x286/0x500
> [    8.134313]  idpf_vport_open+0x4d/0x3f0
> [    8.134498]  idpf_open+0x71/0xb0
> [    8.134668]  __dev_open+0x142/0x260
> [    8.134840]  netif_open+0x2f/0xe0
> [    8.135004]  dev_open+0x3d/0x70
> [    8.135166]  bond_enslave+0x5ed/0xf50
> [    8.135345]  ? nla_put_ifalias+0x3d/0x90
> [    8.135533]  ? kvfree_call_rcu+0xb5/0x3b0
> [    8.135725]  ? kvfree_call_rcu+0xb5/0x3b0
> [    8.135916]  do_set_master+0x114/0x160
> [    8.136098]  do_setlink+0x412/0xfb0
> [    8.136269]  ? security_sock_rcv_skb+0x2a/0x50
> [    8.136509]  ? sk_filter_trim_cap+0x7c/0x320
> [    8.136714]  ? skb_queue_tail+0x20/0x50
> [    8.136899]  ? __nla_validate_parse+0x92/0xe50
> [    8.137112]  ? security_capable+0x35/0x60
> [    8.137304]  rtnl_newlink+0x95c/0xa00
> [    8.137483]  ? __rtnl_unlock+0x37/0x70
> [    8.137664]  ? netdev_run_todo+0x63/0x530
> [    8.137855]  ? allocate_slab+0x280/0x870
> [    8.138044]  ? security_capable+0x35/0x60
> [    8.138235]  rtnetlink_rcv_msg+0x2e6/0x340
> [    8.138431]  ? __pfx_rtnetlink_rcv_msg+0x10/0x10
> [    8.138650]  netlink_rcv_skb+0x16a/0x1a0
> [    8.138840]  netlink_unicast+0x20a/0x320
> [    8.139028]  netlink_sendmsg+0x304/0x3b0
> [    8.139217]  __sock_sendmsg+0x89/0xb0
> [    8.139399]  ____sys_sendmsg+0x167/0x1c0
> [    8.139588]  ? ____sys_recvmsg+0xed/0x150
> [    8.139780]  ___sys_sendmsg+0xdd/0x120
> [    8.139960]  ? ___sys_recvmsg+0x124/0x1e0
> [    8.140152]  ? rcutree_enqueue+0x1f/0xb0
> [    8.140341]  ? rcutree_enqueue+0x1f/0xb0
> [    8.140528]  ? call_rcu+0xde/0x2a0
> [    8.140695]  ? evict+0x286/0x2d0
> [    8.140856]  ? rcutree_enqueue+0x1f/0xb0
> [    8.141043]  ? kmem_cache_free+0x2c/0x350
> [    8.141236]  __x64_sys_sendmsg+0x72/0xc0
> [    8.141424]  do_syscall_64+0x6f/0x890
> [    8.141603]  entry_SYSCALL_64_after_hwframe+0x76/0x7e
> [    8.141841] RIP: 0033:0x7f2799d21bd0
> ...
> [    8.149905] Kernel panic - not syncing: Fatal exception
> [    8.175940] Kernel Offset: 0xf800000 from 0xffffffff81000000 (relocation range: 0xffffffff80000000-0xffffffffbfffffff)
> [    8.176425] Rebooting in 10 seconds..
> ```
> 
> Tested: With this patch, the kernel panic no longer appears.

Is it easy to reproduce?

> Fixes: 95af467d9a4e ("idpf: configure resources for RX queues")
> 

(Just for the future, a blank in the “tag section” is uncommon.)

> Signed-off-by: Li Li <boolli@google.com>
> ---
>   drivers/net/ethernet/intel/idpf/idpf_txrx.c | 2 ++
>   1 file changed, 2 insertions(+)
> 
> diff --git a/drivers/net/ethernet/intel/idpf/idpf_txrx.c b/drivers/net/ethernet/intel/idpf/idpf_txrx.c
> index e7b131dba200c..b4dab4a8ee11b 100644
> --- a/drivers/net/ethernet/intel/idpf/idpf_txrx.c
> +++ b/drivers/net/ethernet/intel/idpf/idpf_txrx.c
> @@ -1337,6 +1337,8 @@ static void idpf_txq_group_rel(struct idpf_vport *vport)
>   static void idpf_rxq_sw_queue_rel(struct idpf_rxq_group *rx_qgrp)
>   {
>   	int i, j;
> +	if (!rx_qgrp->splitq.bufq_sets)
> +		return;
>   
>   	for (i = 0; i < rx_qgrp->vport->num_bufqs_per_qgrp; i++) {
>   		struct idpf_bufq_set *bufq_set = &rx_qgrp->splitq.bufq_sets[i];

Reviewed-by: Paul Menzel <pmenzel@molgen.mpg.de>


Kind regards,

Paul

