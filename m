Return-Path: <netdev+bounces-231682-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 3171FBFC9E4
	for <lists+netdev@lfdr.de>; Wed, 22 Oct 2025 16:45:14 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 496CA4281E3
	for <lists+netdev@lfdr.de>; Wed, 22 Oct 2025 14:31:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DFB9934C144;
	Wed, 22 Oct 2025 14:27:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=blackwall.org header.i=@blackwall.org header.b="oQEsosCM"
X-Original-To: netdev@vger.kernel.org
Received: from mail-ej1-f50.google.com (mail-ej1-f50.google.com [209.85.218.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 07A3E34EEFA
	for <netdev@vger.kernel.org>; Wed, 22 Oct 2025 14:27:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761143246; cv=none; b=QCiihSKUW39mq1y+Y411eFjwkTAEdvaD4JLGlBql/zh6UXIt9HXe/yncNTn/hCvNKo53KwZnIicowgmeejEqHLpw5GnDeFR1smiWaZqpDb67vEg6mhfc3UKRED8Si2+pYgwD6RMNc1wNIMT9te6Qp3mqa9gpfQZm2VY5tOeNB1Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761143246; c=relaxed/simple;
	bh=RZM9nt+kwLCYwQZklggOSRY1olXaCxq9hVj3DYtBkOo=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=nuBI80nZx4roOOTuZNyukU5C2DIbGLcWT8jm/ST11z0gMyf13D67BJV1ZeW5+kNfYH2luCqjgCDkWCb/I6qE/vfqLz2vqmVQ6qUQqcK71J9ZK8q1h2AFmFPqlW2FfREHQgm2WJIMkE0h6P3/0n6E0PC3qQLifhyqnkHPPFyR6iM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=blackwall.org; spf=none smtp.mailfrom=blackwall.org; dkim=pass (2048-bit key) header.d=blackwall.org header.i=@blackwall.org header.b=oQEsosCM; arc=none smtp.client-ip=209.85.218.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=blackwall.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=blackwall.org
Received: by mail-ej1-f50.google.com with SMTP id a640c23a62f3a-b5c18993b73so1107096266b.0
        for <netdev@vger.kernel.org>; Wed, 22 Oct 2025 07:27:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=blackwall.org; s=google; t=1761143242; x=1761748042; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=/6JXyTnl4/CTgSiYlD4AsySyt1xWwLhH6bPhS5L6+ns=;
        b=oQEsosCMj+q+bS0XPgzOe/ySDo6EtvE6qpsfUle6q/pc8j7SHko3v30geSxE4i/HvD
         FeakV8V8vZPP3VV6nw4CPHIiLaHpEAzTL1od3ZuxF32PBUwwLmVvsVxZBNDamxZQpY39
         5OSqFKHPCWLUx2lJc5i6ndMxvTcIRfBTsGVa2YyDSfcANuswNVkAZZyIXqK/tri8/VoI
         vSbKKKSUOy7cGicbJik92xi4Gk6dwg2y5qUed39FRhGLgACC9gNTlum2N63ESps54M7f
         1ZcsbqCqL2YRT2HaG1mHCPJA2tZ0ZtQ1eTKDuHgIKG5uoHWJ1TtlrV+Oc39TxGFlkELt
         GCrw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1761143242; x=1761748042;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=/6JXyTnl4/CTgSiYlD4AsySyt1xWwLhH6bPhS5L6+ns=;
        b=v/GS/RJ66uLKqLvy9ic7jxaQV1As+ipmgPMGFover+oU0iF5TxBS6BwdNyYyE47TWA
         G7anbvP7MxiGeu5VwsWVPczuB6cBiCSbrb04JLRYUmTC4zvQ+AEpaoeDnW3GKxjPs5Ha
         y4SRWY/89tpOJCcc2v04OjEGUD9n3FqeQc89R35RNQPXMHKzkgf88PPM7T/Sca9zQ/m4
         p8/hpv9VDLKk5+Jf/vT8UBkq7ltZ5tUqm0Ywp13yGLh0MbLya+3GO9LP8bgT6ntJcBNe
         WCekHGGTxUBXCvIVAY+7B+ACjgChwZ0h9y5Ei6J9lsDFAZMp1vdjq0zIOWm3uP5XYd+R
         PRGw==
X-Forwarded-Encrypted: i=1; AJvYcCUE0q7EXlKi4awnZiqv7UQTHbINLpNFg6Rult3opTSZDkboTKWI3OHd8ChEdBTRLiqEtOiaV6w=@vger.kernel.org
X-Gm-Message-State: AOJu0YwYMyamXcgquJF36OUBezbD1oKl9Ovclbc2VXomMvKKZUe8wjDH
	eZ4i5vJ965oWRMvK4Gbr5vD9HVCajGJY9jcTKm0QZU2uifmv8J4iF/Xs3k4zTNvRh4s=
X-Gm-Gg: ASbGncvcrjscNxWhD4/Dde9Nx/XdkOkAIbZIxonCqOibTpZRw7q4greitgBhumH1PsH
	bjty9B9GsTa8J29SdgfEPLqQbJWDDTBbKjiWrRTOWt58KD+yWYncf3tkbolwqCGruwAXU5vj9Vr
	F8N7GpxnMZNQBWk3Zf0PZXnFC/GCJf/Gm1ycHTHM1UdasEpbOqfXRezy3fa5Ec4BGu+WWaS6MHO
	U9zqIt1KfA4M6W3c+yOFOTJEf/jcdW5sn4BweZIpfLRR3Mvzq/NOBSKvJITBVn7yabNIjU15NFs
	60AXI8gIWE+pJdp88nQbKtCjrJoWyNLyPcdb+/91r1n4f97pIIwZ10ZJu4gWbyvNEYtlbPCCwET
	RoCQA4VKIDxZTFk6DbAHtz7PAuKtxVfHENVvfTvR1tDZHN9VBNC5HhKOipV/sAuLNdRQJ+jWpSU
	lG0MDvAj5DQXkXpBxs4U5vyGYqr18e2m7X
X-Google-Smtp-Source: AGHT+IERjCtVPjayNeyvtIlXJNCXCbJfsnwrTGxOW9ZK5k/XoJSYtSsD3B7zemyh98rdbn4aRjVzNA==
X-Received: by 2002:a17:907:3c92:b0:b6b:d71:6d97 with SMTP id a640c23a62f3a-b6b0d71825amr1475084166b.31.1761143241998;
        Wed, 22 Oct 2025 07:27:21 -0700 (PDT)
Received: from [192.168.0.205] (78-154-15-142.ip.btc-net.bg. [78.154.15.142])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-b65e83937a3sm1374200266b.23.2025.10.22.07.27.20
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 22 Oct 2025 07:27:21 -0700 (PDT)
Message-ID: <50d4a072-209e-4751-80c3-1929c536afcb@blackwall.org>
Date: Wed, 22 Oct 2025 17:27:20 +0300
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net-next v3 15/15] netkit: Add xsk support for af_xdp
 applications
To: Daniel Borkmann <daniel@iogearbox.net>, netdev@vger.kernel.org
Cc: bpf@vger.kernel.org, kuba@kernel.org, davem@davemloft.net,
 pabeni@redhat.com, willemb@google.com, sdf@fomichev.me,
 john.fastabend@gmail.com, martin.lau@kernel.org, jordan@jrife.io,
 maciej.fijalkowski@intel.com, magnus.karlsson@intel.com, dw@davidwei.uk,
 toke@redhat.com, yangzhenze@bytedance.com, wangdongdong.6@bytedance.com
References: <20251020162355.136118-1-daniel@iogearbox.net>
 <20251020162355.136118-16-daniel@iogearbox.net>
Content-Language: en-US
From: Nikolay Aleksandrov <razor@blackwall.org>
In-Reply-To: <20251020162355.136118-16-daniel@iogearbox.net>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 10/20/25 19:23, Daniel Borkmann wrote:
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
>   # ethtool -X eth0 start 0 equal 15
>   # ethtool -X eth0 start 15 equal 1 context new
>   # ethtool --config-ntuple eth0 flow-type ether \
>             src 00:00:00:00:00:00 \
>             src-mask ff:ff:ff:ff:ff:ff \
>             dst $mac dst-mask 00:00:00:00:00:00 \
>             proto 0 proto-mask 0xffff action 15
>   [ ... setup BPF/XDP prog on eth0 to steer into shared xsk map ... ]
>   # ip netns add foo
>   # ip link add numrxqueues 2 nk type netkit single
>   # ./pyynl/cli.py --spec ~/netlink/specs/netdev.yaml \
>                    --do bind-queue \
>                    --json "{"src-ifindex": $(ifindex eth0), "src-queue-id": 15, \
>                             "dst-ifindex": $(ifindex nk), "queue-type": "rx"}"
>   {'dst-queue-id': 1}
>   # ip link set nk netns foo
>   # ip netns exec foo ip link set lo up
>   # ip netns exec foo ip link set nk up
>   # ip netns exec foo qemu-system-x86_64 \
>           -kernel $kernel \
>           -drive file=${image_name},index=0,media=disk,format=raw \
>           -append "root=/dev/sda rw console=ttyS0" \
>           -cpu host \
>           -m $memory \
>           -enable-kvm \
>           -device virtio-net-pci,netdev=net0,mac=$mac \
>           -netdev af-xdp,ifname=nk,id=net0,mode=native,queues=1,start-queue=1,inhibit=on,map-path=$dir/xsks_map \
>           -nographic
> 
> We have tested the above against a dual-port Nvidia ConnectX-6 (mlx5)
> 100G NIC with successful network connectivity out of QEMU. An earlier
> iteration of this work was presented at LSF/MM/BPF [0].
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
> Link: https://bpfconf.ebpf.io/bpfconf2025/bpfconf2025_material/lsfmmbpf_2025_netkit_borkmann.pdf [0]
> ---
>  drivers/net/netkit.c | 71 +++++++++++++++++++++++++++++++++++++++++++-
>  1 file changed, 70 insertions(+), 1 deletion(-)
> 
> diff --git a/drivers/net/netkit.c b/drivers/net/netkit.c
> index a281b39a1047..f69abe5ec4cd 100644
> --- a/drivers/net/netkit.c
> +++ b/drivers/net/netkit.c
> @@ -12,6 +12,7 @@
>  #include <net/netdev_lock.h>
>  #include <net/netdev_queues.h>
>  #include <net/netdev_rx_queue.h>
> +#include <net/xdp_sock_drv.h>
>  #include <net/netkit.h>
>  #include <net/dst.h>
>  #include <net/tcx.h>
> @@ -235,6 +236,71 @@ static void netkit_get_stats(struct net_device *dev,
>  	stats->tx_dropped = DEV_STATS_READ(dev, tx_dropped);
>  }
>  
> +static bool netkit_xsk_supported_at_phys(const struct net_device *dev)
> +{
> +	if (!dev->netdev_ops->ndo_bpf ||
> +	    !dev->netdev_ops->ndo_xdp_xmit ||
> +	    !dev->netdev_ops->ndo_xsk_wakeup)
> +		return false;
> +	if ((dev->xdp_features & NETDEV_XDP_ACT_XSK) != NETDEV_XDP_ACT_XSK)
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
> +
> +	switch (xdp->command) {
> +	case XDP_SETUP_XSK_POOL:
> +		if (nk->pair == NETKIT_DEVICE_PAIR)
> +			return -EOPNOTSUPP;
> +		if (xdp->xsk.queue_id >= dev->real_num_rx_queues)
> +			return -EINVAL;
> +
> +		rxq = __netif_get_rx_queue(dev, xdp->xsk.queue_id);
> +		if (!rxq->peer)
> +			return -EOPNOTSUPP;
> +
> +		phys = rxq->peer->dev;
> +		if (!netkit_xsk_supported_at_phys(phys))
> +			return -EOPNOTSUPP;
> +
> +		memcpy(&xdp_lower, xdp, sizeof(xdp_lower));
> +		xdp_lower.xsk.queue_id = get_netdev_rx_queue_index(rxq->peer);
> +		break;
> +	case XDP_SETUP_PROG:
> +		return -EPERM;
> +	default:
> +		return -EINVAL;
> +	}
> +
> +	return phys->netdev_ops->ndo_bpf(phys, &xdp_lower);
> +}
> +
> +static int netkit_xsk_wakeup(struct net_device *dev, u32 queue_id, u32 flags)
> +{
> +	struct netdev_rx_queue *rxq;
> +	struct net_device *phys;
> +
> +	if (queue_id >= dev->real_num_rx_queues)
> +		return -EINVAL;
> +
> +	rxq = __netif_get_rx_queue(dev, queue_id);
> +	if (!rxq->peer)
> +		return -EOPNOTSUPP;
> +
> +	phys = rxq->peer->dev;
> +	if (!netkit_xsk_supported_at_phys(phys))
> +		return -EOPNOTSUPP;
> +
> +	return phys->netdev_ops->ndo_xsk_wakeup(phys,
> +			get_netdev_rx_queue_index(rxq->peer), flags);
> +}
> +
>  static int netkit_init(struct net_device *dev)
>  {
>  	netdev_lockdep_set_classes(dev);
> @@ -255,6 +321,8 @@ static const struct net_device_ops netkit_netdev_ops = {
>  	.ndo_get_peer_dev	= netkit_peer_dev,
>  	.ndo_get_stats64	= netkit_get_stats,
>  	.ndo_uninit		= netkit_uninit,
> +	.ndo_bpf		= netkit_xsk,
> +	.ndo_xsk_wakeup		= netkit_xsk_wakeup,
>  	.ndo_features_check	= passthru_features_check,
>  };
>  
> @@ -409,10 +477,11 @@ static void netkit_setup(struct net_device *dev)
>  	dev->hw_enc_features = netkit_features;
>  	dev->mpls_features = NETIF_F_HW_CSUM | NETIF_F_GSO_SOFTWARE;
>  	dev->vlan_features = dev->features & ~netkit_features_hw_vlan;
> -
>  	dev->needs_free_netdev = true;
>  
>  	netif_set_tso_max_size(dev, GSO_MAX_SIZE);
> +
> +	xdp_set_features_flag(dev, NETDEV_XDP_ACT_XSK);
>  }
>  
>  static struct net *netkit_get_link_net(const struct net_device *dev)

Reviewed-by: Nikolay Aleksandrov <razor@blackwall.org>


