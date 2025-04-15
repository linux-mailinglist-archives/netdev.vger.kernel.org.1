Return-Path: <netdev+bounces-182874-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 059D4A8A412
	for <lists+netdev@lfdr.de>; Tue, 15 Apr 2025 18:26:43 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 55FC018968C4
	for <lists+netdev@lfdr.de>; Tue, 15 Apr 2025 16:26:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4634B211472;
	Tue, 15 Apr 2025 16:26:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="TWI6KNXr"
X-Original-To: netdev@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 58D072DFA36
	for <netdev@vger.kernel.org>; Tue, 15 Apr 2025 16:26:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744734399; cv=none; b=VoicabbITuLv2I40J6NmQG/gMj09FsC1rOyPAlNdZUTfLiAN00Cl3xLPba+Xxgx6HAQpV5abGr2EZrqW2kpl7SKZmY93YUb3PlNdDGc7kr6UXulCKfLuBUjh1dMME9+CgUvY8m43Nnihkq4BQuzV9kygVEiCsyrz27kUOVA9gio=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744734399; c=relaxed/simple;
	bh=Ecx2E8Qv1YxpBOd6fr3EdPQkzR19k2SUX06TQq+HJA8=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=elveWjOyxLwR3fZjr1VD5uCHel1GbWmv2Uiylz/aEYBB86TDuPly69fa8gLBrDUkw7IBHpngLIYIFCk/GWhNizfIG2nEYjzFYopbMRNUH99bulHmvMwL11gPSym1lkbobhrWws8QwOVO/fX73JlhG1lFHr5s9z6PejicbOrXQAY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=TWI6KNXr; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1744734396;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=YYp/FjE/Zl3CgCYwBLXeVS/jejb255JAZD9BteBawL4=;
	b=TWI6KNXrIGM+RnyZ9ZYUHbVsmmUeISYSTtxpzGEVbuRxLrSEzgK4sPE1vReksjLRburghV
	LIm+I4jVHSEYY778sWeyJnRHGSYw9ya5b1MHvGz59BnaGjzzOYyEsbg/8srQsglgyi2InX
	bpIrgEt9vo3nnroNkqAW4BE0JkCxJyU=
Received: from mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-653-KRlL5dWRN2GejVf7s3zmBA-1; Tue,
 15 Apr 2025 12:26:30 -0400
X-MC-Unique: KRlL5dWRN2GejVf7s3zmBA-1
X-Mimecast-MFC-AGG-ID: KRlL5dWRN2GejVf7s3zmBA_1744734389
Received: from mx-prod-int-04.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-04.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.40])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 9B15D1868034;
	Tue, 15 Apr 2025 16:26:18 +0000 (UTC)
Received: from RHTRH0061144 (unknown [10.22.64.251])
	by mx-prod-int-04.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 8E82619560AD;
	Tue, 15 Apr 2025 16:26:15 +0000 (UTC)
From: Aaron Conole <aconole@redhat.com>
To: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
Cc: netdev@vger.kernel.org,  linux-rt-devel@lists.linux.dev,  "David S.
 Miller" <davem@davemloft.net>,  Eric Dumazet <edumazet@google.com>,  Jakub
 Kicinski <kuba@kernel.org>,  Paolo Abeni <pabeni@redhat.com>,  Simon
 Horman <horms@kernel.org>,  Thomas Gleixner <tglx@linutronix.de>,  Eelco
 Chaudron <echaudro@redhat.com>,  Ilya Maximets <i.maximets@ovn.org>,
  dev@openvswitch.org
Subject: Re: [PATCH net-next v2 12/18] openvswitch: Move
 ovs_frag_data_storage into the struct ovs_pcpu_storage
In-Reply-To: <20250414160754.503321-13-bigeasy@linutronix.de> (Sebastian
	Andrzej Siewior's message of "Mon, 14 Apr 2025 18:07:48 +0200")
References: <20250414160754.503321-1-bigeasy@linutronix.de>
	<20250414160754.503321-13-bigeasy@linutronix.de>
Date: Tue, 15 Apr 2025 12:26:13 -0400
Message-ID: <f7tbjsxfl22.fsf@redhat.com>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.40

Sebastian Andrzej Siewior <bigeasy@linutronix.de> writes:

> ovs_frag_data_storage is a per-CPU variable and relies on disabled BH for its
> locking. Without per-CPU locking in local_bh_disable() on PREEMPT_RT
> this data structure requires explicit locking.
>
> Move ovs_frag_data_storage into the struct ovs_pcpu_storage which already
> provides locking for the structure.
>
> Cc: Aaron Conole <aconole@redhat.com>
> Cc: Eelco Chaudron <echaudro@redhat.com>
> Cc: Ilya Maximets <i.maximets@ovn.org>
> Cc: dev@openvswitch.org
> Signed-off-by: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
> ---

I'm going to reply here, but I need to bisect a bit more (though I
suspect the results below are due to 11/18).  When I tested with this
patch there were lots of "unexplained" latency spikes during processing
(note, I'm not doing PREEMPT_RT in my testing, but I guess it would
smooth the spikes out at the cost of max performance).

With the series:
[SUM]   0.00-300.00 sec  3.28 TBytes  96.1 Gbits/sec  9417             sender
[SUM]   0.00-300.00 sec  3.28 TBytes  96.1 Gbits/sec                  receiver

Without the series:
[SUM]   0.00-300.00 sec  3.26 TBytes  95.5 Gbits/sec  149             sender
[SUM]   0.00-300.00 sec  3.26 TBytes  95.5 Gbits/sec                  receiver

And while the 'final' numbers might look acceptable, one thing I'll note
is I saw multiple stalls as:

[  5]  57.00-58.00  sec   128 KBytes   903 Kbits/sec    0   4.02 MBytes

But without the patch, I didn't see such stalls.  My testing:

1. Install openvswitch userspace and ipcalc
2. start userspace.
3. Setup two netns and connect them (I have a more complicated script to
   set up the flows, and I can send that to you)
4. Use iperf3 to test (-P5 -t 300)

As I wrote I suspect the locking in 11 is leading to these stalls, as
the data I'm sending shouldn't be hitting the frag path.

Do these results seem expected to you?

>  net/openvswitch/actions.c  | 20 ++------------------
>  net/openvswitch/datapath.h | 16 ++++++++++++++++
>  2 files changed, 18 insertions(+), 18 deletions(-)
>
> diff --git a/net/openvswitch/actions.c b/net/openvswitch/actions.c
> index f4996c11aefac..4d20eadd77ceb 100644
> --- a/net/openvswitch/actions.c
> +++ b/net/openvswitch/actions.c
> @@ -39,22 +39,6 @@
>  #include "flow_netlink.h"
>  #include "openvswitch_trace.h"
>  
> -#define MAX_L2_LEN	(VLAN_ETH_HLEN + 3 * MPLS_HLEN)
> -struct ovs_frag_data {
> -	unsigned long dst;
> -	struct vport *vport;
> -	struct ovs_skb_cb cb;
> -	__be16 inner_protocol;
> -	u16 network_offset;	/* valid only for MPLS */
> -	u16 vlan_tci;
> -	__be16 vlan_proto;
> -	unsigned int l2_len;
> -	u8 mac_proto;
> -	u8 l2_data[MAX_L2_LEN];
> -};
> -
> -static DEFINE_PER_CPU(struct ovs_frag_data, ovs_frag_data_storage);
> -
>  DEFINE_PER_CPU(struct ovs_pcpu_storage, ovs_pcpu_storage) = {
>  	.bh_lock = INIT_LOCAL_LOCK(bh_lock),
>  };
> @@ -771,7 +755,7 @@ static int set_sctp(struct sk_buff *skb, struct sw_flow_key *flow_key,
>  static int ovs_vport_output(struct net *net, struct sock *sk,
>  			    struct sk_buff *skb)
>  {
> -	struct ovs_frag_data *data = this_cpu_ptr(&ovs_frag_data_storage);
> +	struct ovs_frag_data *data = this_cpu_ptr(&ovs_pcpu_storage.frag_data);
>  	struct vport *vport = data->vport;
>  
>  	if (skb_cow_head(skb, data->l2_len) < 0) {
> @@ -823,7 +807,7 @@ static void prepare_frag(struct vport *vport, struct sk_buff *skb,
>  	unsigned int hlen = skb_network_offset(skb);
>  	struct ovs_frag_data *data;
>  
> -	data = this_cpu_ptr(&ovs_frag_data_storage);
> +	data = this_cpu_ptr(&ovs_pcpu_storage.frag_data);
>  	data->dst = skb->_skb_refdst;
>  	data->vport = vport;
>  	data->cb = *OVS_CB(skb);
> diff --git a/net/openvswitch/datapath.h b/net/openvswitch/datapath.h
> index 4a665c3cfa906..1b5348b0f5594 100644
> --- a/net/openvswitch/datapath.h
> +++ b/net/openvswitch/datapath.h
> @@ -13,6 +13,7 @@
>  #include <linux/skbuff.h>
>  #include <linux/u64_stats_sync.h>
>  #include <net/ip_tunnels.h>
> +#include <net/mpls.h>
>  
>  #include "conntrack.h"
>  #include "flow.h"
> @@ -173,6 +174,20 @@ struct ovs_net {
>  	bool xt_label;
>  };
>  
> +#define MAX_L2_LEN	(VLAN_ETH_HLEN + 3 * MPLS_HLEN)
> +struct ovs_frag_data {
> +	unsigned long dst;
> +	struct vport *vport;
> +	struct ovs_skb_cb cb;
> +	__be16 inner_protocol;
> +	u16 network_offset;	/* valid only for MPLS */
> +	u16 vlan_tci;
> +	__be16 vlan_proto;
> +	unsigned int l2_len;
> +	u8 mac_proto;
> +	u8 l2_data[MAX_L2_LEN];
> +};
> +
>  struct deferred_action {
>  	struct sk_buff *skb;
>  	const struct nlattr *actions;
> @@ -200,6 +215,7 @@ struct action_flow_keys {
>  struct ovs_pcpu_storage {
>  	struct action_fifo action_fifos;
>  	struct action_flow_keys flow_keys;
> +	struct ovs_frag_data frag_data;
>  	int exec_level;
>  	struct task_struct *owner;
>  	local_lock_t bh_lock;


