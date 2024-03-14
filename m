Return-Path: <netdev+bounces-79997-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id C960787C5DD
	for <lists+netdev@lfdr.de>; Fri, 15 Mar 2024 00:21:50 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 40B311F2157D
	for <lists+netdev@lfdr.de>; Thu, 14 Mar 2024 23:21:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E39D2FC0B;
	Thu, 14 Mar 2024 23:21:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="EhNGG0Cq"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B497E12E67;
	Thu, 14 Mar 2024 23:21:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710458504; cv=none; b=LfMFEEitUsC7sOwM3Bk190n1hYQ8YJe8J4scw34WLAQk/TFyih+XAivVREJnl852Lk4TPyG0iuXX3+YoJkCPHBaLJM30PjPphbl2l1MQBcDGLHaEtxjzFyX9RvHnQuoP7JwZE4SfkPCEmb/2jbkjjviqVyjDs4vNKagTSwYuiII=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710458504; c=relaxed/simple;
	bh=YuMhRaZvH093ZY63IA1EVCbrxTiyw6BfBGNhm7xZy7o=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=jKpMvgezmSQblqogB6YaLi/p+Nb7ptFtLJPTNVvneJLjgGzhv8PSocGq+rypKvuVPCJq5/lGHABoOJ6DJcfewuecsDPF1e295GZqNlLsQSQTDYWLylRyh/+SUPDnrF+m1YGzA+MN8Pp9abDhE/Osylmcb5/Txp0qZr3nNZYlIvU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=EhNGG0Cq; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6FA0FC433C7;
	Thu, 14 Mar 2024 23:21:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1710458504;
	bh=YuMhRaZvH093ZY63IA1EVCbrxTiyw6BfBGNhm7xZy7o=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=EhNGG0CqUe6UF5gAXCruWkaggThAxoTkrXZ2JM/0mpBN+cF0eqA0bEZkTRl/CEddu
	 gVvZcYBPdIKA/QdNhzCN23PNNiD3lcG/TKsbReHAgaYSQKiTgqnyowHPu6z/XAn9bA
	 d8hL3hyemZrkR78KFUuNcXs/Thy1D/inL0sgtdRzkCHHMorykG3pDwBdrGtZxhC2hT
	 zBm/9Z9mFpW4zu6MeNoR0ztb4SSqwjVgSzY51P8A6/ibRnezlcSJiGREAvX1Me2yBj
	 gjp4VsJQNrLjllL8CQbqG54WEq1FfCh65IWaTooweu+N1IocGaq0nUJ9KCiqnSVCH4
	 u0C/PMRCiZWNA==
Date: Thu, 14 Mar 2024 16:21:42 -0700
From: Jakub Kicinski <kuba@kernel.org>
To: Xuan Zhuo <xuanzhuo@linux.alibaba.com>
Cc: netdev@vger.kernel.org, "David S. Miller" <davem@davemloft.net>, Eric
 Dumazet <edumazet@google.com>, Paolo Abeni <pabeni@redhat.com>, "Michael S.
 Tsirkin" <mst@redhat.com>, Jason Wang <jasowang@redhat.com>, Alexei
 Starovoitov <ast@kernel.org>, Daniel Borkmann <daniel@iogearbox.net>,
 Jesper Dangaard Brouer <hawk@kernel.org>, John Fastabend
 <john.fastabend@gmail.com>, Stanislav Fomichev <sdf@google.com>, Amritha
 Nambiar <amritha.nambiar@intel.com>, Larysa Zaremba
 <larysa.zaremba@intel.com>, Sridhar Samudrala
 <sridhar.samudrala@intel.com>, Maciej Fijalkowski
 <maciej.fijalkowski@intel.com>, virtualization@lists.linux.dev,
 bpf@vger.kernel.org
Subject: Re: [PATCH net-next v4 7/8] netdev: add queue stats
Message-ID: <20240314162142.36b8ff02@kernel.org>
In-Reply-To: <20240314085459.115933-8-xuanzhuo@linux.alibaba.com>
References: <20240314085459.115933-1-xuanzhuo@linux.alibaba.com>
	<20240314085459.115933-8-xuanzhuo@linux.alibaba.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Thu, 14 Mar 2024 16:54:58 +0800 Xuan Zhuo wrote:
> +      -
> +        name: rx-hw-drops
> +        doc: |
> +          Number of packets that arrived at the device but never left it,
> +          encompassing packets dropped for reasons such as insufficient buffer

s/encompassing/including/

> +          space, processing errors, as well as those affected by explicitly
> +          defined policies and packet filtering criteria.

I'm afraid the attempt to "correct my English" ended up decreasing the
clarity. Maybe use what I suggested more directly?

  Number of all packets which entered the device, but never left it,
  including but not limited to: packets dropped due to lack of buffer
  space, processing errors, explicit or implicit policies and packet filters.

> +        type: uint
> +      -
> +        name: rx-hw-drop-overruns
> +        doc: |
> +          Number of packets that arrived at the device but never left it due to
> +          no descriptors.

I put a paragraph in my previous email explaining how tricky this is to
state for HW devices and you just went with the virtio spec :|

  Number of packets dropped due to transient lack of resources, such as
  buffer space, host descriptors etc.

> +      -
> +        name: rx-csum-bad
> +        doc: |
> +          Number of packets that are dropped by device due to invalid checksum.

Quoting myself:

>> Maybe add a note in "bad" that packets with bad csum are not
>> discarded, but still delivered to the stack.

Devices should not drop packets due to invalid L4 checksums.

> +        type: uint
> +      -
> +        name: rx-hw-gro-packets
> +        doc: |
> +          Number of packets that area coalesced from smaller packets by the device,
> +          that do not cover LRO packets.

s/area/were/ ?
s/that do not cover LRO packets/Counts only packets coalesced with the
HW-GRO netdevice feature, LRO-coalesced packets are not counted./

> +        type: uint
> +      -
> +        name: rx-hw-gro-bytes
> +        doc: see `rx-hw-gro-packets`.
> +        type: uint
> +      -
> +        name: rx-hw-gro-wire-packets
> +        doc: |
> +          Number of packets that area coalesced to bigger packets(no LRO packets)
> +          by the device.

s/area/were/
s/packets(no LRO packets)/packets by the HW-GRO feature of the device/

> +        type: uint
> +      -
> +        name: rx-hw-gro-wire-bytes
> +        doc: see `rx-hw-gro-wire-packets`.

Please make sure the "See `xyz`." references are capitalized (See)
and end with a full stop.

> +        type: uint
> +      -
> +        name: rx-hw-drop-ratelimits
> +        doc: |
> +          Number of the packets dropped by the device due to the received
> +          packets bitrate exceeding the device speed limit.

Maybe s/speed/rate/

> +        type: uint
> +      -
> +        name: tx-hw-drops
> +        doc: |
> +          Number of packets that arrived at the device but never left it,
> +          encompassing packets dropped for reasons such as processing errors, as
> +          well as those affected by explicitly defined policies and packet
> +          filtering criteria.
> +        type: uint
> +      -
> +        name: tx-hw-drop-errors
> +        doc: Number of packets dropped because they were invalid or malformed.
> +        type: uint
> +      -
> +        name: tx-csum-none
> +        doc: |
> +          Number of packets that do not require the device to calculate the
> +          checksum.

I think we should use past tense everywhere.

> +        type: uint
> +      -
> +        name: tx-needs-csum
> +        doc: |
> +          Number of packets that require the device to calculate the
> +          checksum.
> +        type: uint
> +      -
> +        name: tx-hw-gso-packets
> +        doc: |
> +          Number of packets that necessitated segmentation into smaller packets
> +          by the device.
> +        type: uint
> +      -
> +        name: tx-hw-gso-bytes
> +        doc: |
> +          Successfully segmented into smaller packets by the device, see
> +          `tx-hw-gso-packets`.

Maybe stick to "see `tx-hw-gso-packets`", none of the other counters
mention the send being "successful".

> +        type: uint
> +      -
> +        name: tx-hw-gso-wire-packets
> +        doc: |
> +          Number of the small packets that segmented from bigger packets by the
> +          device.

Maybe

  Number of wire-sized packets generated by processing
  `tx-hw-gso-packets`

?

> +        type: uint
> +      -
> +        name: tx-hw-gso-wire-bytes
> +        doc: See `tx-hw-gso-wire-packets`.
> +
> +        type: uint
> +      -
> +        name: tx-hw-drop-ratelimits
> +        doc: |
> +          Number of the packets dropped by the device due to the transmit
> +          packets bitrate exceeding the device speed limit.

s/speed/rate/

> +        type: uint
>  
>  operations:
>    list:
> diff --git a/include/net/netdev_queues.h b/include/net/netdev_queues.h
> index 1ec408585373..c7ac4539eafc 100644
> --- a/include/net/netdev_queues.h
> +++ b/include/net/netdev_queues.h
> @@ -9,11 +9,38 @@ struct netdev_queue_stats_rx {
>  	u64 bytes;
>  	u64 packets;
>  	u64 alloc_fail;
> +
> +	u64 hw_drops;
> +	u64 hw_drop_overruns;
> +
> +	u64 csum_unnecessary;
> +	u64 csum_none;
> +	u64 csum_bad;
> +
> +	u64 hw_gro_packets;
> +	u64 hw_gro_bytes;
> +	u64 hw_gro_wire_packets;
> +	u64 hw_gro_wire_bytes;
> +
> +	u64 hw_drop_ratelimits;
>  };
>  
>  struct netdev_queue_stats_tx {
>  	u64 bytes;
>  	u64 packets;
> +
> +	u64 hw_drops;
> +	u64 hw_drop_errors;
> +
> +	u64 csum_none;
> +	u64 needs_csum;
> +
> +	u64 hw_gso_packets;
> +	u64 hw_gso_bytes;
> +	u64 hw_gso_wire_packets;
> +	u64 hw_gso_wire_bytes;
> +
> +	u64 hw_drop_ratelimits;
>  };
>  
>  /**
> diff --git a/include/uapi/linux/netdev.h b/include/uapi/linux/netdev.h
> index bb65ee840cda..702d69b09f14 100644
> --- a/include/uapi/linux/netdev.h
> +++ b/include/uapi/linux/netdev.h
> @@ -147,6 +147,26 @@ enum {
>  	NETDEV_A_QSTATS_TX_BYTES,
>  	NETDEV_A_QSTATS_RX_ALLOC_FAIL,
>  

Looks hand written. Once you update the yaml file, you should run:

./tools/net/ynl/ynl-regen.sh

This will generate the uAPI changes for you.

> +	NETDEV_A_QSTATS_RX_HW_DROPS,
> +	NETDEV_A_QSTATS_RX_HW_DROP_OVERRUNS,
> +	NETDEV_A_QSTATS_RX_CSUM_UNNECESSARY,
> +	NETDEV_A_QSTATS_RX_CSUM_NONE,
> +	NETDEV_A_QSTATS_RX_CSUM_BAD,
> +	NETDEV_A_QSTATS_RX_HW_GRO_PACKETS,
> +	NETDEV_A_QSTATS_RX_HW_GRO_BYTES,
> +	NETDEV_A_QSTATS_RX_HW_GRO_WIRE_PACKETS,
> +	NETDEV_A_QSTATS_RX_HW_GRO_WIRE_BYTES,
> +	NETDEV_A_QSTATS_RX_HW_DROP_RATELIMITS,
> +	NETDEV_A_QSTATS_TX_HW_DROPS,
> +	NETDEV_A_QSTATS_TX_HW_DROP_ERRORS,
> +	NETDEV_A_QSTATS_TX_CSUM_NONE,
> +	NETDEV_A_QSTATS_TX_NEEDS_CSUM,
> +	NETDEV_A_QSTATS_TX_HW_GSO_PACKETS,
> +	NETDEV_A_QSTATS_TX_HW_GSO_BYTES,
> +	NETDEV_A_QSTATS_TX_HW_GSO_WIRE_PACKETS,
> +	NETDEV_A_QSTATS_TX_HW_GSO_WIRE_BYTES,
> +	NETDEV_A_QSTATS_TX_HW_DROP_RATELIMITS,
> +
>  	__NETDEV_A_QSTATS_MAX,
>  	NETDEV_A_QSTATS_MAX = (__NETDEV_A_QSTATS_MAX - 1)
>  };


