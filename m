Return-Path: <netdev+bounces-203321-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D6A1AAF152F
	for <lists+netdev@lfdr.de>; Wed,  2 Jul 2025 14:16:45 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 29FE07AF35C
	for <lists+netdev@lfdr.de>; Wed,  2 Jul 2025 12:14:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2E1B126E149;
	Wed,  2 Jul 2025 12:14:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="LbzLfdJH"
X-Original-To: netdev@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1BC6D26D4FB
	for <netdev@vger.kernel.org>; Wed,  2 Jul 2025 12:14:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751458496; cv=none; b=LbQPuKuUqKx43izst0gt5CCx5Psohsx1gOLCRvdaIRxRCpAwrRBmGy5/L9YRocwfsRMywkWmke+eLcceZO0E3sqZx2kM4BPrNx9Pc+p1V5Y3keXriskksAn+jwOckhK6+/5Me0vZmGFCUmPOvq8knq8KBNPwmzK2cwmn/Rwj78E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751458496; c=relaxed/simple;
	bh=ffD3C6JZUyoRI83QKvcvL24B6KroLiNu6UXcdP25Wq8=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=nti38PLyB4dxAWFFKJVMa/wBEe0PuDf8OpnZHpTSrOQjJtVfLrKqLy3le9pFuYJK/nyms/ISi7hZfEuP2PCLlJGQFq8VthDyjSfi2kePDAFE4bLt8up6I3xQtxE7NnUEKn5aaCBhpB2Pn6VIajPKPbC9hAfxIT1g23sNv9jhXqA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=LbzLfdJH; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1751458493;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=LiyZulwdL2gLsLXPBc0GHmqwjrdGSfYjPd+ELklP7Qo=;
	b=LbzLfdJH/pU606fNaCWN8AANQW2X4hxwiRT4OtzkjG2OHF5rIx4/Fiy6ZBY9TmUgZHez4F
	OwaVcko+zOg0+Awb5q9KVSPjNsPwPlUF9Pol6Fwq1JXi9iSgmJbrJMqTUVuZ4FmvyZJjjJ
	hnb4qfbRfROiFAS6Fj+NHqUL9qxQl6E=
Received: from mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-567-8PDotQUjNhacadSIS9XYBg-1; Wed,
 02 Jul 2025 08:14:50 -0400
X-MC-Unique: 8PDotQUjNhacadSIS9XYBg-1
X-Mimecast-MFC-AGG-ID: 8PDotQUjNhacadSIS9XYBg_1751458488
Received: from mx-prod-int-04.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-04.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.40])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 365311800287;
	Wed,  2 Jul 2025 12:14:48 +0000 (UTC)
Received: from RHTRH0061144 (unknown [10.22.65.59])
	by mx-prod-int-04.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id E0F7A19560AB;
	Wed,  2 Jul 2025 12:14:45 +0000 (UTC)
From: Aaron Conole <aconole@redhat.com>
To: Ilya Maximets <i.maximets@ovn.org>
Cc: netdev@vger.kernel.org,  "David S. Miller" <davem@davemloft.net>,  Eric
 Dumazet <edumazet@google.com>,  Jakub Kicinski <kuba@kernel.org>,  Paolo
 Abeni <pabeni@redhat.com>,  Simon Horman <horms@kernel.org>,
  dev@openvswitch.org,  linux-kernel@vger.kernel.org,  Eelco Chaudron
 <echaudro@redhat.com>
Subject: Re: [PATCH net-next] net: openvswitch: allow providing upcall pid
 for the 'execute' command
In-Reply-To: <20250627220219.1504221-1-i.maximets@ovn.org> (Ilya Maximets's
	message of "Sat, 28 Jun 2025 00:01:33 +0200")
References: <20250627220219.1504221-1-i.maximets@ovn.org>
User-Agent: Gnus/5.13 (Gnus v5.13)
Date: Wed, 02 Jul 2025 08:14:43 -0400
Message-ID: <f7tms9mssb0.fsf@redhat.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.40

Ilya Maximets <i.maximets@ovn.org> writes:

> When a packet enters OVS datapath and there is no flow to handle it,
> packet goes to userspace through a MISS upcall.  With per-CPU upcall
> dispatch mechanism, we're using the current CPU id to select the
> Netlink PID on which to send this packet.  This allows us to send
> packets from the same traffic flow through the same handler.
>
> The handler will process the packet, install required flow into the
> kernel and re-inject the original packet via OVS_PACKET_CMD_EXECUTE.
>
> While handling OVS_PACKET_CMD_EXECUTE, however, we may hit a
> recirculation action that will pass the (likely modified) packet
> through the flow lookup again.  And if the flow is not found, the
> packet will be sent to userspace again through another MISS upcall.
>
> However, the handler thread in userspace is likely running on a
> different CPU core, and the OVS_PACKET_CMD_EXECUTE request is handled
> in the syscall context of that thread.  So, when the time comes to
> send the packet through another upcall, the per-CPU dispatch will
> choose a different Netlink PID, and this packet will end up processed
> by a different handler thread on a different CPU.

Just wondering but why can't we choose the existing core handler when
running the packet_cmd_execute?  For example, when looking into the
per-cpu table we know what the current core is, can we just queue to
that one?  I actually thought that's what the PER_CPU dispatch mode was
supposed to do.  Or is it that we want to make sure we keep the
association between the skbuff for re-injection always?

> The process continues as long as there are new recirculations, each
> time the packet goes to a different handler thread before it is sent
> out of the OVS datapath to the destination port.  In real setups the
> number of recirculations can go up to 4 or 5, sometimes more.

Is it because the userspace handler threads are being rescheduled across
CPUs?  Do we still see this behavior if we pinned each handler thread to
a specific CPU rather than letting the scheduler make the decision?

> There is always a chance to re-order packets while processing upcalls,
> because userspace will first install the flow and then re-inject the
> original packet.  So, there is a race window when the flow is already
> installed and the second packet can match it and be forwarded to the
> destination before the first packet is re-injected.  But the fact that
> packets are going through multiple upcalls handled by different
> userspace threads makes the reordering noticeably more likely, because
> we not only have a race between the kernel and a userspace handler
> (which is hard to avoid), but also between multiple userspace handlers.
>
> For example, let's assume that 10 packets got enqueued through a MISS
> upcall for handler-1, it will start processing them, will install the
> flow into the kernel and start re-injecting packets back, from where
> they will go through another MISS to handler-2.  Handler-2 will install
> the flow into the kernel and start re-injecting the packets, while
> handler-1 continues to re-inject the last of the 10 packets, they will
> hit the flow installed by handler-2 and be forwarded without going to
> the handler-2, while handler-2 still re-injects the first of these 10
> packets.  Given multiple recirculations and misses, these 10 packets
> may end up completely mixed up on the output from the datapath.
>
> Let's allow userspace to specify on which Netlink PID the packets
> should be upcalled while processing OVS_PACKET_CMD_EXECUTE.
> This makes it possible to ensure that all the packets are processed
> by the same handler thread in the userspace even with them being
> upcalled multiple times in the process.  Packets will remain in order
> since they will be enqueued to the same socket and re-injected in the
> same order.  This doesn't eliminate re-ordering as stated above, since
> we still have a race between kernel and the userspace thread, but it
> allows to eliminate races between multiple userspace threads.
>
> Userspace knows the PID of the socket on which the original upcall is
> received, so there is no need to send it up from the kernel.
>
> Solution requires storing the value somewhere for the duration of the
> packet processing.  There are two potential places for this: our skb
> extension or the per-CPU storage.  It's not clear which is better,
> so just following currently used scheme of storing this kind of things
> along the skb.

With this change we're almost full on the OVS sk_buff control block.
Might be good to mention it in the commit message if you're respinning.

> Signed-off-by: Ilya Maximets <i.maximets@ovn.org>
> ---
>  include/uapi/linux/openvswitch.h |  6 ++++++
>  net/openvswitch/actions.c        |  6 ++++--
>  net/openvswitch/datapath.c       | 10 +++++++++-
>  net/openvswitch/datapath.h       |  3 +++
>  net/openvswitch/vport.c          |  1 +
>  5 files changed, 23 insertions(+), 3 deletions(-)
>
> diff --git a/include/uapi/linux/openvswitch.h b/include/uapi/linux/openvswitch.h
> index 3a701bd1f31b..3092c2c6f1d2 100644
> --- a/include/uapi/linux/openvswitch.h
> +++ b/include/uapi/linux/openvswitch.h
> @@ -186,6 +186,11 @@ enum ovs_packet_cmd {
>   * %OVS_PACKET_ATTR_USERSPACE action specify the Maximum received fragment
>   * size.
>   * @OVS_PACKET_ATTR_HASH: Packet hash info (e.g. hash, sw_hash and l4_hash in skb).
> + * @OVS_PACKET_ATTR_UPCALL_PID: Netlink PID to use for upcalls while
> + * processing %OVS_PACKET_CMD_EXECUTE.  Takes precedence over all other ways
> + * to determine the Netlink PID including %OVS_USERSPACE_ATTR_PID,
> + * %OVS_DP_ATTR_UPCALL_PID, %OVS_DP_ATTR_PER_CPU_PIDS and the
> + * %OVS_VPORT_ATTR_UPCALL_PID.
>   *
>   * These attributes follow the &struct ovs_header within the Generic Netlink
>   * payload for %OVS_PACKET_* commands.
> @@ -205,6 +210,7 @@ enum ovs_packet_attr {
>  	OVS_PACKET_ATTR_MRU,	    /* Maximum received IP fragment size. */
>  	OVS_PACKET_ATTR_LEN,	    /* Packet size before truncation. */
>  	OVS_PACKET_ATTR_HASH,	    /* Packet hash. */
> +	OVS_PACKET_ATTR_UPCALL_PID, /* u32 Netlink PID. */
>  	__OVS_PACKET_ATTR_MAX
>  };
>  
> diff --git a/net/openvswitch/actions.c b/net/openvswitch/actions.c
> index 3add108340bf..2832e0794197 100644
> --- a/net/openvswitch/actions.c
> +++ b/net/openvswitch/actions.c
> @@ -941,8 +941,10 @@ static int output_userspace(struct datapath *dp, struct sk_buff *skb,
>  			break;
>  
>  		case OVS_USERSPACE_ATTR_PID:
> -			if (dp->user_features &
> -			    OVS_DP_F_DISPATCH_UPCALL_PER_CPU)
> +			if (OVS_CB(skb)->upcall_pid)
> +				upcall.portid = OVS_CB(skb)->upcall_pid;
> +			else if (dp->user_features &
> +				 OVS_DP_F_DISPATCH_UPCALL_PER_CPU)
>  				upcall.portid =
>  				  ovs_dp_get_upcall_portid(dp,
>  							   smp_processor_id());
> diff --git a/net/openvswitch/datapath.c b/net/openvswitch/datapath.c
> index b990dc83504f..ec08ce72f439 100644
> --- a/net/openvswitch/datapath.c
> +++ b/net/openvswitch/datapath.c
> @@ -267,7 +267,9 @@ void ovs_dp_process_packet(struct sk_buff *skb, struct sw_flow_key *key)
>  		memset(&upcall, 0, sizeof(upcall));
>  		upcall.cmd = OVS_PACKET_CMD_MISS;
>  
> -		if (dp->user_features & OVS_DP_F_DISPATCH_UPCALL_PER_CPU)
> +		if (OVS_CB(skb)->upcall_pid)
> +			upcall.portid = OVS_CB(skb)->upcall_pid;
> +		else if (dp->user_features & OVS_DP_F_DISPATCH_UPCALL_PER_CPU)
>  			upcall.portid =
>  			    ovs_dp_get_upcall_portid(dp, smp_processor_id());
>  		else
> @@ -616,6 +618,7 @@ static int ovs_packet_cmd_execute(struct sk_buff *skb, struct genl_info *info)
>  	struct sw_flow_actions *sf_acts;
>  	struct datapath *dp;
>  	struct vport *input_vport;
> +	u32 upcall_pid = 0;
>  	u16 mru = 0;
>  	u64 hash;
>  	int len;
> @@ -651,6 +654,10 @@ static int ovs_packet_cmd_execute(struct sk_buff *skb, struct genl_info *info)
>  			       !!(hash & OVS_PACKET_HASH_L4_BIT));
>  	}
>  
> +	if (a[OVS_PACKET_ATTR_UPCALL_PID])
> +		upcall_pid = nla_get_u32(a[OVS_PACKET_ATTR_UPCALL_PID]);
> +	OVS_CB(packet)->upcall_pid = upcall_pid;
> +
>  	/* Build an sw_flow for sending this packet. */
>  	flow = ovs_flow_alloc();
>  	err = PTR_ERR(flow);
> @@ -719,6 +726,7 @@ static const struct nla_policy packet_policy[OVS_PACKET_ATTR_MAX + 1] = {
>  	[OVS_PACKET_ATTR_PROBE] = { .type = NLA_FLAG },
>  	[OVS_PACKET_ATTR_MRU] = { .type = NLA_U16 },
>  	[OVS_PACKET_ATTR_HASH] = { .type = NLA_U64 },
> +	[OVS_PACKET_ATTR_UPCALL_PID] = { .type = NLA_U32 },
>  };
>  
>  static const struct genl_small_ops dp_packet_genl_ops[] = {
> diff --git a/net/openvswitch/datapath.h b/net/openvswitch/datapath.h
> index cfeb817a1889..db0c3e69d66c 100644
> --- a/net/openvswitch/datapath.h
> +++ b/net/openvswitch/datapath.h
> @@ -121,6 +121,8 @@ struct datapath {
>   * @cutlen: The number of bytes from the packet end to be removed.
>   * @probability: The sampling probability that was applied to this skb; 0 means
>   * no sampling has occurred; U32_MAX means 100% probability.
> + * @upcall_pid: Netlink socket PID to use for sending this packet to userspace;
> + * 0 means "not set" and default per-CPU or per-vport dispatch should be used.
>   */
>  struct ovs_skb_cb {
>  	struct vport		*input_vport;
> @@ -128,6 +130,7 @@ struct ovs_skb_cb {
>  	u16			acts_origlen;
>  	u32			cutlen;
>  	u32			probability;
> +	u32			upcall_pid;
>  };
>  #define OVS_CB(skb) ((struct ovs_skb_cb *)(skb)->cb)
>  
> diff --git a/net/openvswitch/vport.c b/net/openvswitch/vport.c
> index 8732f6e51ae5..6bbbc16ab778 100644
> --- a/net/openvswitch/vport.c
> +++ b/net/openvswitch/vport.c
> @@ -501,6 +501,7 @@ int ovs_vport_receive(struct vport *vport, struct sk_buff *skb,
>  	OVS_CB(skb)->mru = 0;
>  	OVS_CB(skb)->cutlen = 0;
>  	OVS_CB(skb)->probability = 0;
> +	OVS_CB(skb)->upcall_pid = 0;
>  	if (unlikely(dev_net(skb->dev) != ovs_dp_get_net(vport->dp))) {
>  		u32 mark;


