Return-Path: <netdev+bounces-255861-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id mBvQNfSegGl2/wIAu9opvQ
	(envelope-from <netdev+bounces-255861-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Mon, 02 Feb 2026 13:56:20 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 540C8CC869
	for <lists+netdev@lfdr.de>; Mon, 02 Feb 2026 13:56:19 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 0A980301184C
	for <lists+netdev@lfdr.de>; Mon,  2 Feb 2026 12:54:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4AC1D1A5B9E;
	Mon,  2 Feb 2026 12:54:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=huawei.com header.i=@huawei.com header.b="TalsC5oY"
X-Original-To: netdev@vger.kernel.org
Received: from canpmsgout04.his.huawei.com (canpmsgout04.his.huawei.com [113.46.200.219])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 07AA3199FAC
	for <netdev@vger.kernel.org>; Mon,  2 Feb 2026 12:54:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=113.46.200.219
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770036846; cv=none; b=KnlXWZ0xqsksVrwB1vpzfYfrooI/Rg0XKp5IBLAmgG4PVuXXgPcxvbwEf9naXVliBpVcHIiwIMogvJUG7CXWjw4TfE1LxlTS+XzC09Mg+1SUQ8I5y32Ss3a0XOCT+DhkqN4pxtyITSYLTvftAFYha6d9CWo6irqtwT9cE6c5c2I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770036846; c=relaxed/simple;
	bh=cosfBNIN7L3c4jhjdlmyyBBU1waSFPgeMbzGNcZNZpc=;
	h=Message-ID:Date:MIME-Version:Subject:To:CC:References:From:
	 In-Reply-To:Content-Type; b=YyTF+qAdZCY8KuO9lPm7F1GUb86996IEBVMwxO+d30Xgs2Tvoq8gQt0vcrFw0VAMemH1C7mdE2PP+8QCoR3bdoW/hdzb+MWGAGOix8p5XVdQCU7u/plyWmjZrmuey0JEUmcGUd6SugxQTFD4TiipnPtTODJaN7aEAEj0ORNWTpA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=huawei.com; dkim=pass (1024-bit key) header.d=huawei.com header.i=@huawei.com header.b=TalsC5oY; arc=none smtp.client-ip=113.46.200.219
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
dkim-signature: v=1; a=rsa-sha256; d=huawei.com; s=dkim;
	c=relaxed/relaxed; q=dns/txt;
	h=From;
	bh=DoEHeSEz5BuOy39fRx7cDEHXYzqftlVWK2wOiFdbyRo=;
	b=TalsC5oY9+Rl4hNmwVf6/TWzZ4/l2VVzlE3vXuDu4f+So5nqmTyVIDsb/aTQOfk9aH4N8uDMH
	cqbT+mib2n0Y1CJU4LizyZa9aeYHoyL4e6onYppCnlsxwz3+zMJeWfxi1JXGmArZZTMI8bCn82u
	wtMDowA6Cw+bJ55Hvf7AZIY=
Received: from mail.maildlp.com (unknown [172.19.162.144])
	by canpmsgout04.his.huawei.com (SkyGuard) with ESMTPS id 4f4RKm38Gwz1prLN;
	Mon,  2 Feb 2026 20:50:20 +0800 (CST)
Received: from dggemv706-chm.china.huawei.com (unknown [10.3.19.33])
	by mail.maildlp.com (Postfix) with ESMTPS id 60A8E40538;
	Mon,  2 Feb 2026 20:53:53 +0800 (CST)
Received: from kwepemq200002.china.huawei.com (7.202.195.90) by
 dggemv706-chm.china.huawei.com (10.3.19.33) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.11; Mon, 2 Feb 2026 20:53:53 +0800
Received: from [10.174.177.223] (10.174.177.223) by
 kwepemq200002.china.huawei.com (7.202.195.90) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.11; Mon, 2 Feb 2026 20:53:52 +0800
Message-ID: <7befb796-be66-4518-96a5-6df607edd41d@huawei.com>
Date: Mon, 2 Feb 2026 20:53:51 +0800
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 net] net: add RCU protection to (struct
 packet_type)->dev
To: Eric Dumazet <edumazet@google.com>, "David S . Miller"
	<davem@davemloft.net>, Jakub Kicinski <kuba@kernel.org>, Paolo Abeni
	<pabeni@redhat.com>
CC: Simon Horman <horms@kernel.org>, Willem de Bruijn <willemb@google.com>,
	<netdev@vger.kernel.org>, <eric.dumazet@gmail.com>, Yin Fengwei
	<fengwei_yin@linux.alibaba.com>
References: <20260202102658.858769-1-edumazet@google.com>
From: "dongchenchen (A)" <dongchenchen2@huawei.com>
In-Reply-To: <20260202102658.858769-1-edumazet@google.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: kwepems100001.china.huawei.com (7.221.188.238) To
 kwepemq200002.china.huawei.com (7.202.195.90)
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.66 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[huawei.com,quarantine];
	R_DKIM_ALLOW(-0.20)[huawei.com:s=dkim];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FREEMAIL_CC(0.00)[kernel.org,google.com,vger.kernel.org,gmail.com,linux.alibaba.com];
	RCVD_TLS_LAST(0.00)[];
	DKIM_TRACE(0.00)[huawei.com:+];
	TAGGED_FROM(0.00)[bounces-255861-lists,netdev=lfdr.de];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[huawei.com:email,huawei.com:dkim,huawei.com:mid,sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,alibaba.com:email];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[dongchenchen2@huawei.com,netdev@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	NEURAL_HAM(-0.00)[-1.000];
	RCPT_COUNT_SEVEN(0.00)[9];
	MID_RHS_MATCH_FROM(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	RCVD_COUNT_SEVEN(0.00)[7]
X-Rspamd-Queue-Id: 540C8CC869
X-Rspamd-Action: no action


在 2026/2/2 18:26, Eric Dumazet 写道:
> Yin Fengwei reported an RCU stall in ptype_seq_show() and provided a patch.
>
> Real issue is that (struct packet_type)->dev needs RCU protection:
>
> ptype_seq_show() runs under rcu_read_lock(), and reads pt->dev
> to get device name without any barrier.
>
> At the same time, concurrent writer can remove a packet_type structure
> (which is correctly freed after an RCU grace period) _and_ clear pt->dev
> without an RCU grace period.
>
> Fix this issue by using proper RCU on pt->dev pointer.
>
> Then, we need to record this dev pointer in ptype_iter_state
> so that ptype_seq_next() can properly detect the end of dev->ptype_all.
>
> We also need to add full RCU protection in ptype_seq_next().
> (Missing READ_ONCE() when reading .next values)
>
> Many thanks to Dong Chenchen for providing a repro.
>
> Fixes: 1da177e4c3f4 ("Linux-2.6.12-rc2")
> Fixes: 1d10f8a1f40b ("net-procfs: show net devices bound packet types")
> Fixes: c353e8983e0d ("net: introduce per netns packet chains")
> Signed-off-by: Eric Dumazet <edumazet@google.com>
> Reported-by: Yin Fengwei <fengwei_yin@linux.alibaba.com>
> Reported-by: Dong Chenchen <dongchenchen2@huawei.com>
> Closes: https://lore.kernel.org/netdev/CANn89iKRRKPnWjJmb-_3a=sq+9h6DvTQM4DBZHT5ZRGPMzQaiA@mail.gmail.com/T/#m7b80b9fc9b9267f90e0b7aad557595f686f9c50d
> ---
>   drivers/net/ethernet/amd/xgbe/xgbe-selftest.c |  2 +-
>   .../ethernet/mellanox/mlx5/core/en_selftest.c |  2 +-
>   .../stmicro/stmmac/stmmac_selftests.c         | 12 ++---
>   drivers/scsi/bnx2fc/bnx2fc_fcoe.c             |  4 +-
>   drivers/scsi/fcoe/fcoe.c                      |  6 +--
>   include/linux/netdevice.h                     |  2 +-
>   net/batman-adv/hard-interface.c               |  2 +-
>   net/core/dev.c                                | 30 ++++++-----
>   net/core/net-procfs.c                         | 51 +++++++++++++------
>   net/core/selftests.c                          |  2 +-
>   net/ncsi/ncsi-manage.c                        |  2 +-
>   net/packet/af_packet.c                        | 24 +++++----
>   net/tipc/bearer.c                             |  6 +--
>   13 files changed, 85 insertions(+), 60 deletions(-)

Hi, Eric! Obtaining dev from ptype_iter_stateis sufficient to solve this issue, so it seems we do not need to add RCU 
protection for dev in ptype procfs. Perhaps the changes related to RCU 
could be moved to another patch? -----
Best Regards,
Dong Chenchen

> diff --git a/net/core/net-procfs.c b/net/core/net-procfs.c
> index 70e0e9a3b650c0753f0b865642aa372a956a4bf5..ad63556c9e0abd15cbfac7777c31894d2eef037b 100644
> --- a/net/core/net-procfs.c
> +++ b/net/core/net-procfs.c
> @@ -170,8 +170,15 @@ static const struct seq_operations softnet_seq_ops = {
>   	.show  = softnet_seq_show,
>   };
>   
> +
> +struct ptype_iter_state {
> +	struct seq_net_private	p;
> +	struct net_device	*dev;
> +};
> +
>   static void *ptype_get_idx(struct seq_file *seq, loff_t pos)
>   {
> +	struct ptype_iter_state *iter = seq->private;
>   	struct list_head *ptype_list = NULL;
>   	struct packet_type *pt = NULL;
>   	struct net_device *dev;
> @@ -181,12 +188,16 @@ static void *ptype_get_idx(struct seq_file *seq, loff_t pos)
>   	for_each_netdev_rcu(seq_file_net(seq), dev) {
>   		ptype_list = &dev->ptype_all;
>   		list_for_each_entry_rcu(pt, ptype_list, list) {
> -			if (i == pos)
> +			if (i == pos) {
> +				iter->dev = dev;
>   				return pt;
> +			}
>   			++i;
>   		}
>   	}
>   
> +	iter->dev = NULL;
> +
>   	list_for_each_entry_rcu(pt, &seq_file_net(seq)->ptype_all, list) {
>   		if (i == pos)
>   			return pt;
> @@ -218,6 +229,7 @@ static void *ptype_seq_start(struct seq_file *seq, loff_t *pos)
>   
>   static void *ptype_seq_next(struct seq_file *seq, void *v, loff_t *pos)
>   {
> +	struct ptype_iter_state *iter = seq->private;
>   	struct net *net = seq_file_net(seq);
>   	struct net_device *dev;
>   	struct packet_type *pt;
> @@ -229,19 +241,21 @@ static void *ptype_seq_next(struct seq_file *seq, void *v, loff_t *pos)
>   		return ptype_get_idx(seq, 0);
>   
>   	pt = v;
> -	nxt = pt->list.next;
> -	if (pt->dev) {
> -		if (nxt != &pt->dev->ptype_all)
> +	nxt = READ_ONCE(pt->list.next);
> +	dev = iter->dev;
> +	if (dev) {
> +		if (nxt != &dev->ptype_all)
>   			goto found;
>   
> -		dev = pt->dev;
>   		for_each_netdev_continue_rcu(seq_file_net(seq), dev) {
> -			if (!list_empty(&dev->ptype_all)) {
> -				nxt = dev->ptype_all.next;
> +			nxt = READ_ONCE(dev->ptype_all.next);
> +			if (nxt != &dev->ptype_all) {
> +				iter->dev = NULL;
>   				goto found;
>   			}
>   		}
> -		nxt = net->ptype_all.next;
> +		iter->dev = NULL;
> +		nxt = READ_ONCE(net->ptype_all.next);
>   		goto net_ptype_all;
>   	}
>   
> @@ -252,20 +266,20 @@ static void *ptype_seq_next(struct seq_file *seq, void *v, loff_t *pos)
>   
>   		if (nxt == &net->ptype_all) {
>   			/* continue with ->ptype_specific if it's not empty */
> -			nxt = net->ptype_specific.next;
> +			nxt = READ_ONCE(net->ptype_specific.next);
>   			if (nxt != &net->ptype_specific)
>   				goto found;
>   		}
>   
>   		hash = 0;
> -		nxt = ptype_base[0].next;
> +		nxt = READ_ONCE(ptype_base[0].next);
>   	} else
>   		hash = ntohs(pt->type) & PTYPE_HASH_MASK;
>   
>   	while (nxt == &ptype_base[hash]) {
>   		if (++hash >= PTYPE_HASH_SIZE)
>   			return NULL;
> -		nxt = ptype_base[hash].next;
> +		nxt = READ_ONCE(ptype_base[hash].next);
>   	}
>   found:
>   	return list_entry(nxt, struct packet_type, list);
> @@ -279,19 +293,24 @@ static void ptype_seq_stop(struct seq_file *seq, void *v)
>   
>   static int ptype_seq_show(struct seq_file *seq, void *v)
>   {
> +	struct ptype_iter_state *iter = seq->private;
>   	struct packet_type *pt = v;
> +	struct net_device *dev;
>   
> -	if (v == SEQ_START_TOKEN)
> +	if (v == SEQ_START_TOKEN) {
>   		seq_puts(seq, "Type Device      Function\n");
> -	else if ((!pt->af_packet_net || net_eq(pt->af_packet_net, seq_file_net(seq))) &&
> -		 (!pt->dev || net_eq(dev_net(pt->dev), seq_file_net(seq)))) {
> +		return 0;
> +	}
> +	dev = iter->dev;
> +	if ((!pt->af_packet_net || net_eq(pt->af_packet_net, seq_file_net(seq))) &&
> +		 (!dev || net_eq(dev_net(dev), seq_file_net(seq)))) {
>   		if (pt->type == htons(ETH_P_ALL))
>   			seq_puts(seq, "ALL ");
>   		else
>   			seq_printf(seq, "%04x", ntohs(pt->type));
>   
>   		seq_printf(seq, " %-8s %ps\n",
> -			   pt->dev ? pt->dev->name : "", pt->func);
> +			   dev ? dev->name : "", pt->func);
>   	}
>   
>   	return 0;
> @@ -315,7 +334,7 @@ static int __net_init dev_proc_net_init(struct net *net)
>   			 &softnet_seq_ops))
>   		goto out_dev;
>   	if (!proc_create_net("ptype", 0444, net->proc_net, &ptype_seq_ops,
> -			sizeof(struct seq_net_private)))
> +			sizeof(struct ptype_iter_state)))
>   		goto out_softnet;
>   
>   	if (wext_proc_init(net))
>

