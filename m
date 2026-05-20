Return-Path: <netdev+bounces-289733-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id KA8aGK4nDWo8twUAu9opvQ
	(envelope-from <netdev+bounces-289733-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Wed, 20 May 2026 05:17:02 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id A1BFC587214
	for <lists+netdev@lfdr.de>; Wed, 20 May 2026 05:17:01 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id B972430DE568
	for <lists+netdev@lfdr.de>; Wed, 20 May 2026 03:11:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F3A58332608;
	Wed, 20 May 2026 03:11:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="E4IFha/6"
X-Original-To: netdev@vger.kernel.org
Received: from out-182.mta0.migadu.com (out-182.mta0.migadu.com [91.218.175.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 16449330B3F
	for <netdev@vger.kernel.org>; Wed, 20 May 2026 03:11:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.218.175.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779246662; cv=none; b=nZJw4hvzf58a32oCLqeSkA0AYCDnEw7E8v6+EJSXvAGns18/+36Xhhwi9dX2b0UHq+clZTd+5lLEv3Gw43PkPS5SSuVD+JPv1ji882T18+0nqC8pHVBpuKcXtELPGeYbo6xVO9qhLgoTzId4vuK/eaWsjRGSOn4R8LXS9bRGsM0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779246662; c=relaxed/simple;
	bh=93soFO02Nlw34bW/hRvnSdyjRergmvVGYyO8yz7cxww=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=Yo66/juBO/gGlAKS5HWWYM80UJUVEs2ZNTxRowda2adGbboPksGJeyJ4RS+gb4xx85G71mf3zSkTd/213kwK1/aEww2HXLFgpcrQEBZrcTR2AZPGwOcszJ/VJMTW4tlE+IbRWzHf6aT0LmHtHn8mO4XpKlLlPdtVZ1vzpi9+T+w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=E4IFha/6; arc=none smtp.client-ip=91.218.175.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Message-ID: <ea99efb4-6ac0-4b29-8b38-e9865b46526c@linux.dev>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1779246659;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=HbhqSwHJRBvVY/YFqq2MqMGzG69k4R41OWaenpX1b5Q=;
	b=E4IFha/6BAJvOwWsLsB7N8R0uMBdnyCaYx2ZD3VhxDH5YxwhpQ30Hvu56pO2RwVSKx9JBu
	x17pa/FrMTIug+SiK8SfozucDOAYgKZT8uHOso3quqig7yoOlS8rXKZKb1gZOewk20jNPh
	Te0rDHHyp6trWgU6AS5wjN1ZOl+xk14=
Date: Tue, 19 May 2026 20:10:52 -0700
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Subject: Re: [PATCH net-next v11 13/14] netkit: Add xsk support for af_xdp
 applications
To: Daniel Borkmann <daniel@iogearbox.net>, netdev@vger.kernel.org,
 "yanjun.zhu@linux.dev" <yanjun.zhu@linux.dev>
Cc: bpf@vger.kernel.org, kuba@kernel.org, davem@davemloft.net,
 razor@blackwall.org, pabeni@redhat.com, willemb@google.com, sdf@fomichev.me,
 john.fastabend@gmail.com, martin.lau@kernel.org, jordan@jrife.io,
 maciej.fijalkowski@intel.com, magnus.karlsson@intel.com, dw@davidwei.uk,
 toke@redhat.com, yangzhenze@bytedance.com, wangdongdong.6@bytedance.com
References: <20260402231031.447597-1-daniel@iogearbox.net>
 <20260402231031.447597-14-daniel@iogearbox.net>
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Zhu Yanjun <yanjun.zhu@linux.dev>
In-Reply-To: <20260402231031.447597-14-daniel@iogearbox.net>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Migadu-Flow: FLOW_OUT
X-Spamd-Result: default: False [-0.66 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[linux.dev,none];
	R_DKIM_ALLOW(-0.20)[linux.dev:s=key1];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-289733-lists,netdev=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	RCVD_COUNT_THREE(0.00)[3];
	TO_DN_EQ_ADDR_SOME(0.00)[];
	FREEMAIL_CC(0.00)[vger.kernel.org,kernel.org,davemloft.net,blackwall.org,redhat.com,google.com,fomichev.me,gmail.com,jrife.io,intel.com,davidwei.uk,bytedance.com];
	RCPT_COUNT_TWELVE(0.00)[19];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	MISSING_XM_UA(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[yanjun.zhu@linux.dev,netdev@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[linux.dev:+];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[netdev];
	MID_RHS_MATCH_FROM(0.00)[];
	TO_DN_SOME(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[blackwall.org:email,ebpf.io:url,iogearbox.net:email,sea.lore.kernel.org:rdns,sea.lore.kernel.org:helo,davidwei.uk:email,lpc.events:url,linux.dev:mid,linux.dev:dkim]
X-Rspamd-Queue-Id: A1BFC587214
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

在 2026/4/2 16:10, Daniel Borkmann 写道:
> Enable support for AF_XDP applications to operate on a netkit device.
> The goal is that AF_XDP applications can natively consume AF_XDP
> from network namespaces. The use-case from Cilium side is to support
> Kubernetes KubeVirt VMs through QEMU's AF_XDP backend. KubeVirt is a
> virtual machine management add-on for Kubernetes which aims to provide
> a common ground for virtualization. KubeVirt spawns the VMs inside
> Kubernetes Pods which reside in their own network namespace just like
> regular Pods.
> 
> Raw QEMU AF_XDP backend example with eth0 being a physical device with
> 16 queues where netkit is bound to the last queue (for multi-queue RSS
> context can be used if supported by the driver):
> 
>    # ethtool -X eth0 start 0 equal 15
>    # ethtool -X eth0 start 15 equal 1 context new
>    # ethtool --config-ntuple eth0 flow-type ether \
>              src 00:00:00:00:00:00 \
>              src-mask ff:ff:ff:ff:ff:ff \
>              dst $mac dst-mask 00:00:00:00:00:00 \
>              proto 0 proto-mask 0xffff action 15
>    [ ... setup BPF/XDP prog on eth0 to steer into shared xsk map ... ]
>    # ip netns add foo
>    # ip link add numrxqueues 2 nk type netkit single
>    # ynl --family netdev --output-json --do queue-create \
>          --json "{"ifindex": $(ifindex nk), "type": "rx", \
>                   "lease": { "ifindex": $(ifindex eth0), \
>                              "queue": { "type": "rx", "id": 15 } } }"
>    {'id': 1}
>    # ip link set nk netns foo
>    # ip netns exec foo ip link set lo up
>    # ip netns exec foo ip link set nk up
>    # ip netns exec foo qemu-system-x86_64 \
>            -kernel $kernel \
>            -drive file=${image_name},index=0,media=disk,format=raw \
>            -append "root=/dev/sda rw console=ttyS0" \
>            -cpu host \
>            -m $memory \
>            -enable-kvm \
>            -device virtio-net-pci,netdev=net0,mac=$mac \
>            -netdev af-xdp,ifname=nk,id=net0,mode=native,queues=1,start-queue=1,inhibit=on,map-path=$dir/xsks_map \
>            -nographic
> 
> We have tested the above against a dual-port Nvidia ConnectX-6 (mlx5)
> 100G NIC with successful network connectivity out of QEMU. An earlier
> iteration of this work was presented at LSF/MM/BPF [0] and more
> recently at LPC [1].
> 
> For getting to a first starting point to connect all things with
> KubeVirt, bind mounting the xsk map from Cilium into the VM launcher
> Pod which acts as a regular Kubernetes Pod while not perfect, is not
> a big problem given its out of reach from the application sitting
> inside the VM (and some of the control plane aspects are baked in
> the launcher Pod already), so the isolation barrier is still the VM.
> Eventually the goal is to have a XDP/XSK redirect extension where
> there is no need to have the xsk map, and the BPF program can just
> derive the target xsk through the queue where traffic was received
> on.

Sorry, this may be a bit late regarding this commit.

If I remember correctly, eBPF is already supported in netkit. Since eBPF 
can cover everything XDP does, I’m wondering what the motivation was for 
adding explicit XDP support to the netkit driver.

Thanks,
Zhu Yanjun

> 
> The exposure through netkit is because Cilium should not act as a
> proxy handing out xsk sockets. Existing applications expect a netdev
> from kernel side and should not need to rewrite just to implement
> against a CNI's protocol. Also, all the memory should not be accounted
> against Cilium but rather the application Pod itself which is consuming
> AF_XDP. Further, on up/downgrades we expect the data plane to being
> completely decoupled from the control plane; if Cilium would own the
> sockets that would be disruptive. Another use-case which opens up and
> is regularly asked from users would be to have DPDK applications on
> top of AF_XDP in regular Kubernetes Pods.
> 
> Signed-off-by: Daniel Borkmann <daniel@iogearbox.net>
> Co-developed-by: David Wei <dw@davidwei.uk>
> Signed-off-by: David Wei <dw@davidwei.uk>
> Reviewed-by: Nikolay Aleksandrov <razor@blackwall.org>
> Link: https://bpfconf.ebpf.io/bpfconf2025/bpfconf2025_material/lsfmmbpf_2025_netkit_borkmann.pdf [0]
> Link: https://lpc.events/event/19/contributions/2275/ [1]
> ---
>   drivers/net/netkit.c | 86 ++++++++++++++++++++++++++++++++++++++++++++
>   1 file changed, 86 insertions(+)
> 
> diff --git a/drivers/net/netkit.c b/drivers/net/netkit.c
> index 1ec21aef348f..5619209329d5 100644
> --- a/drivers/net/netkit.c
> +++ b/drivers/net/netkit.c
> @@ -12,6 +12,7 @@
>   #include <net/netdev_lock.h>
>   #include <net/netdev_queues.h>
>   #include <net/netdev_rx_queue.h>
> +#include <net/xdp_sock_drv.h>
>   #include <net/netkit.h>
>   #include <net/dst.h>
>   #include <net/tcx.h>
> @@ -236,6 +237,86 @@ static void netkit_get_stats(struct net_device *dev,
>   	stats->tx_dropped = DEV_STATS_READ(dev, tx_dropped);
>   }
>   
> +static bool netkit_xsk_supported_at_phys(const struct net_device *dev)
> +{
> +	if (!dev->netdev_ops->ndo_bpf ||
> +	    !dev->netdev_ops->ndo_xdp_xmit ||
> +	    !dev->netdev_ops->ndo_xsk_wakeup)
> +		return false;
> +	return true;
> +}
> +
> +static int netkit_xsk(struct net_device *dev, struct netdev_bpf *xdp)
> +{
> +	struct netkit *nk = netkit_priv(dev);
> +	struct netdev_bpf xdp_lower;
> +	struct netdev_rx_queue *rxq;
> +	struct net_device *phys;
> +	bool create = false;
> +	int ret = -EBUSY;
> +
> +	switch (xdp->command) {
> +	case XDP_SETUP_XSK_POOL:
> +		if (nk->pair == NETKIT_DEVICE_PAIR)
> +			return -EOPNOTSUPP;
> +		if (xdp->xsk.queue_id >= dev->real_num_rx_queues)
> +			return -EINVAL;
> +
> +		rxq = __netif_get_rx_queue(dev, xdp->xsk.queue_id);
> +		if (!rxq->lease)
> +			return -EOPNOTSUPP;
> +
> +		phys = rxq->lease->dev;
> +		if (!netkit_xsk_supported_at_phys(phys))
> +			return -EOPNOTSUPP;
> +
> +		create = xdp->xsk.pool;
> +		memcpy(&xdp_lower, xdp, sizeof(xdp_lower));
> +		xdp_lower.xsk.queue_id = get_netdev_rx_queue_index(rxq->lease);
> +		break;
> +	case XDP_SETUP_PROG:
> +		return -EOPNOTSUPP;
> +	default:
> +		return -EINVAL;
> +	}
> +
> +	netdev_lock(phys);
> +	if (create &&
> +	    (phys->xdp_features & NETDEV_XDP_ACT_XSK) != NETDEV_XDP_ACT_XSK) {
> +		ret = -EOPNOTSUPP;
> +		goto out;
> +	}
> +	if (!create || !dev_get_min_mp_channel_count(phys))
> +		ret = phys->netdev_ops->ndo_bpf(phys, &xdp_lower);
> +out:
> +	netdev_unlock(phys);
> +	return ret;
> +}
> +
> +static int netkit_xsk_wakeup(struct net_device *dev, u32 queue_id, u32 flags)
> +{
> +	struct netdev_rx_queue *rxq, *rxq_lease;
> +	struct net_device *phys;
> +
> +	if (queue_id >= dev->real_num_rx_queues)
> +		return -EINVAL;
> +
> +	rxq = __netif_get_rx_queue(dev, queue_id);
> +	rxq_lease = READ_ONCE(rxq->lease);
> +	if (unlikely(!rxq_lease))
> +		return -EOPNOTSUPP;
> +
> +	/* netkit_xsk already validated full xsk support, hence it's
> +	 * fine to call into ndo_xsk_wakeup right away given this
> +	 * was a prerequisite to get here in the first place. The
> +	 * phys xsk support cannot change without tearing down the
> +	 * device (which clears the lease first).
> +	 */
> +	phys = rxq_lease->dev;
> +	return phys->netdev_ops->ndo_xsk_wakeup(phys,
> +			get_netdev_rx_queue_index(rxq_lease), flags);
> +}
> +
>   static int netkit_init(struct net_device *dev)
>   {
>   	netdev_lockdep_set_classes(dev);
> @@ -256,6 +337,8 @@ static const struct net_device_ops netkit_netdev_ops = {
>   	.ndo_get_peer_dev	= netkit_peer_dev,
>   	.ndo_get_stats64	= netkit_get_stats,
>   	.ndo_uninit		= netkit_uninit,
> +	.ndo_bpf		= netkit_xsk,
> +	.ndo_xsk_wakeup		= netkit_xsk_wakeup,
>   	.ndo_features_check	= passthru_features_check,
>   };
>   
> @@ -569,6 +652,9 @@ static int netkit_new_link(struct net_device *dev,
>   	nk->headroom = headroom;
>   	bpf_mprog_bundle_init(&nk->bundle);
>   
> +	if (pair == NETKIT_DEVICE_SINGLE)
> +		xdp_set_features_flag(dev, NETDEV_XDP_ACT_XSK);
> +
>   	err = register_netdevice(dev);
>   	if (err < 0)
>   		goto err_configure_peer;


