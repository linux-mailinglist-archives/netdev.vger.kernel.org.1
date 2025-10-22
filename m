Return-Path: <netdev+bounces-231623-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 94032BFB981
	for <lists+netdev@lfdr.de>; Wed, 22 Oct 2025 13:19:23 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 47A313B06B4
	for <lists+netdev@lfdr.de>; Wed, 22 Oct 2025 11:19:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 415A032C949;
	Wed, 22 Oct 2025 11:19:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=blackwall.org header.i=@blackwall.org header.b="JgvN19QO"
X-Original-To: netdev@vger.kernel.org
Received: from mail-ej1-f45.google.com (mail-ej1-f45.google.com [209.85.218.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2D3B33164AF
	for <netdev@vger.kernel.org>; Wed, 22 Oct 2025 11:19:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761131958; cv=none; b=L6cylqf6yS1RyxiHrM572ay+1KATMtrTb5R36XIWtf0h9Lw56OwLGfjUN+IjJQBuQDwec4HovExfMYknBrUf52o7zM0+hLBPtwpZOoxJR/djaXfvsHIATsS6G6M2A310XPueCdA3zGM0kP1/onOkDLhGASCFq9fL8byBLX9AZ5I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761131958; c=relaxed/simple;
	bh=2WhDNMfegPzWfyJ/dke8gaKvwVwn/zu0a4qfHUsUgK4=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=FGLwLOYGWXtGejT/cQuo3z+Vf6vp+ahweIR/KQ5TIvXkC93wiO2Yb3nLQx1p3gNIP0KaJV9/Kcb45QuNrYALKzWy+bbiU+l4XzHyIUeM+Rv6aIajS/42eVt3vIxKtaC896oK0l30I+/CKH2fOmqndA+lYinVU0fO7z9vbZwPbeI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=blackwall.org; spf=none smtp.mailfrom=blackwall.org; dkim=pass (2048-bit key) header.d=blackwall.org header.i=@blackwall.org header.b=JgvN19QO; arc=none smtp.client-ip=209.85.218.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=blackwall.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=blackwall.org
Received: by mail-ej1-f45.google.com with SMTP id a640c23a62f3a-b3b27b50090so1247120166b.0
        for <netdev@vger.kernel.org>; Wed, 22 Oct 2025 04:19:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=blackwall.org; s=google; t=1761131954; x=1761736754; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=T/qh6PKMUNfdz+R/KppJadnWH5TddSqylASYFyICgm0=;
        b=JgvN19QO2zSyk9H2V8nRXwACLAotdG3L1CVKwwQCh8qp8KlVlNsdJ0FHDgq5kU5Y0r
         82NM17jdWf0ngM9JesZQLAGFHiUt5uakQUGim9u4QopeMa3CqYwD8RiziDrRRO+ZcJW8
         Y7+VOwGzJGrHiFoiAJkqP6CliY50y3ATieSvnBB0w5DYa7LcOmB/lbDrAF4qrdc6SnAR
         SqD4St10yg+A04hH//K8D9FchCoZCg23R9CcHzDSb8bvCSkH0M71np/XVgy+IQX+keWb
         7/04cy2ZcKyN1uxitg/BxdZASVk/tus+Cmc5hrEt4TAJksMjxWkTbBdCjN/GNd1qygzF
         pDTw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1761131954; x=1761736754;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=T/qh6PKMUNfdz+R/KppJadnWH5TddSqylASYFyICgm0=;
        b=wOCfZWCAduaGPgKpDrjQabJGj2ubQaJLXcG54ypko3OcFBenGjS8dpQzLrDLP1j6xK
         LU5164gJLQDFKKpz9foO57cFlMwnxl9UKDo/UDGEIWq+7c4gDd4I4lH5K+DBoFWEen7p
         zPYNdF0KkKrf1LP5KDM1NIzqRN4KcNm8Fkcz6Mwbz9TxGDFkqSJQQFgHzuIdNKglsmSn
         7aKhriYkt7enCSrtN5HAlFL8a6NKsh+uihPtYUxFW6dy4ciC0+AEyAJ7eT6Tn2Ss2S5w
         DC4yfFl+wX4P6R0c1nZ4QnIjN+9eRQDbFaYLqdfcLeydOi61OJXK9HhKnRUz3rKJOicK
         T1ZQ==
X-Forwarded-Encrypted: i=1; AJvYcCXqQfl+SXoUdXyh4qitKtA5IdiswVLsIP8eIyEzvdNbmylCyyMxMI+o3H4lez4zZUwq+2VdM18=@vger.kernel.org
X-Gm-Message-State: AOJu0Yy6+oVNjWv+QkTA3UXHIdnOArKZ4SDoZqdGDRzgh1Q0R98Oegzn
	w3geocwk7ZGklUU6UMhIBgnOgXqjAvJN7nelVXpQBMnn2EJGbAB6Zp/4gu8OV3PPQUA=
X-Gm-Gg: ASbGnctG/EW6aAv9QD3k3x7mRx1DOXsXQAEsXPxg5wNzNfz19pdJkNhPv6qB5AbI0S7
	1ctYsuL7e3KkoWWv2QmEEBR8fpAAZpZzxX/oOmO32LcJEx2hb/Nb/v+uLTU4+t8t4GVB3cwsQxc
	1FMZa0c7h2nhqiip5ZTKOirTIganfNKlsSVy8V8q8oZnZ7KqHoUZgYCH76rRl62suEtFO9CXWrv
	/R8CVsvDFC5NkZEGZK4pCwaSUKFfJsFChFo4y89yq+xHCar2ZM4pChQ0XXonDc/PNlJlFyl2pJZ
	LOuPZXAgXIKXWg5wGyfixPl5ZsSY0X//TnpSrmUkf5Zq8USboghXTFODsvOKS3vX3ziu7VPYO9R
	yalKn31rxUVcyrUuOi1/eEaSVSoZmeDc5Huj9YkQzrUH479M0edc9ex78aZf7Z4EIlMv+cFaLfx
	uXrOkCfPuYz9R7qGt1C4RZMsYSdKnKlX0C
X-Google-Smtp-Source: AGHT+IEBEisdZpx6fwi1lVwPLIYA3aR0VLGWLjVhZnYhlvz2MrDOJf7me4N+eu9/BN669eYIw2QRpA==
X-Received: by 2002:a17:907:86a6:b0:b40:2873:a61a with SMTP id a640c23a62f3a-b6472d5bb62mr2113008866b.6.1761131954381;
        Wed, 22 Oct 2025 04:19:14 -0700 (PDT)
Received: from [192.168.0.205] (78-154-15-142.ip.btc-net.bg. [78.154.15.142])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-b65e838b946sm1315500666b.19.2025.10.22.04.19.13
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 22 Oct 2025 04:19:13 -0700 (PDT)
Message-ID: <c0d0bb6a-a7b6-4eab-90a8-6b2c31becd9f@blackwall.org>
Date: Wed, 22 Oct 2025 14:19:12 +0300
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net-next v3 01/15] net: Add bind-queue operation
To: Daniel Borkmann <daniel@iogearbox.net>, netdev@vger.kernel.org
Cc: bpf@vger.kernel.org, kuba@kernel.org, davem@davemloft.net,
 pabeni@redhat.com, willemb@google.com, sdf@fomichev.me,
 john.fastabend@gmail.com, martin.lau@kernel.org, jordan@jrife.io,
 maciej.fijalkowski@intel.com, magnus.karlsson@intel.com, dw@davidwei.uk,
 toke@redhat.com, yangzhenze@bytedance.com, wangdongdong.6@bytedance.com
References: <20251020162355.136118-1-daniel@iogearbox.net>
 <20251020162355.136118-2-daniel@iogearbox.net>
Content-Language: en-US
From: Nikolay Aleksandrov <razor@blackwall.org>
In-Reply-To: <20251020162355.136118-2-daniel@iogearbox.net>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 10/20/25 19:23, Daniel Borkmann wrote:
> From: David Wei <dw@davidwei.uk>
> 
> Add a ynl netdev family operation called bind-queue that creates a new
> rx queue in a virtual netdev (i.e. netkit or veth) and binds it to an rx
> queue in a real netdev. This forms a queue pair, where the peer queue of
> the pair in the virtual netdev acts as a proxy for the peer queue in the
> real netdev. Thus, the peer queue in the virtual netdev can be used by
> processes running in a container to use both memory providers (io_uring
> zero-copy rx and devmem) and AF_XDP. An early implementation had only
> driver-specific integration [0], but in order for other virtual devices
> to reuse, it makes sense to have this as a generic API.
> 
> src-ifindex and src-queue-id is the real netdev and its rx queue id
> respectively. dst-ifindex is the virtual netdev. Note that this op doesn't
> take dst-queue-id because a new rx queue is created. The virtual netdev
> must have real_num_rx_queues less than num_rx_queues at the time of
> calling bind-queue. The queue-type must be rx as only rx queues are
> supported for now.
> 
> Signed-off-by: David Wei <dw@davidwei.uk>
> Co-developed-by: Daniel Borkmann <daniel@iogearbox.net>
> Signed-off-by: Daniel Borkmann <daniel@iogearbox.net>
> Link: https://bpfconf.ebpf.io/bpfconf2025/bpfconf2025_material/lsfmmbpf_2025_netkit_borkmann.pdf [0]
> ---
>  Documentation/netlink/specs/netdev.yaml | 60 +++++++++++++++++++++++++
>  include/uapi/linux/netdev.h             | 12 +++++
>  net/core/netdev-genl-gen.c              | 25 +++++++++++
>  net/core/netdev-genl-gen.h              |  1 +
>  net/core/netdev-genl.c                  |  5 +++
>  tools/include/uapi/linux/netdev.h       | 12 +++++
>  6 files changed, 115 insertions(+)
> 
> diff --git a/Documentation/netlink/specs/netdev.yaml b/Documentation/netlink/specs/netdev.yaml
> index e00d3fa1c152..20bb00b7e9ac 100644
> --- a/Documentation/netlink/specs/netdev.yaml
> +++ b/Documentation/netlink/specs/netdev.yaml
> @@ -561,6 +561,46 @@ attribute-sets:
>          type: u32
>          checks:
>            min: 1
> +  -
> +    name: queue-pair
> +    attributes:
> +      -
> +        name: queue-type
> +        doc: |
> +          Queue type as rx, tx, for src-queue-id and dst-queue-id.
> +          Currently only pairing queues of type rx is supported.
> +        type: u32
> +        enum: queue-type
> +      -
> +        name: src-ifindex
> +        doc: |
> +          Specifies the netdev ifindex of the physical device to pair
> +          src-queue-id from.
> +        type: u32
> +        checks:
> +          min: 1
> +          max: s32-max
> +      -
> +        name: src-queue-id
> +        doc: |
> +          Specifies the netdev queue id of the physical device with
> +          src-ifindex to pair a queue from.
> +        type: u32
> +      -
> +        name: dst-ifindex
> +        doc: |
> +          Specifies the netdev ifindex of the virtual device to pair
> +          a new queue with the src-queue-id from src-ifindex.
> +        type: u32
> +        checks:
> +          min: 1
> +          max: s32-max
> +      -
> +        name: dst-queue-id
> +        doc: |
> +          Specifies the new netdev queue id of the virtual device after
> +          a successful pairing operation.
> +        type: u32
>  
>  operations:
>    list:
> @@ -772,6 +812,26 @@ operations:
>            attributes:
>              - id
>  
> +    -
> +      name: bind-queue
> +      doc: |
> +        Bind a physical netdevice queue to a virtual one. The binding
> +        creates a queue pair, where a queue can reference its peer queue.
> +        This is useful for memory providers and AF_XDP operations which
> +        take an ifindex and queue id to allow auch applications to bind
> +        against virtual devices in containers.
> +      attribute-set: queue-pair
> +      do:
> +        request:
> +          attributes:
> +            - queue-type
> +            - src-ifindex
> +            - src-queue-id
> +            - dst-ifindex
> +        reply:
> +          attributes:
> +            - dst-queue-id
> +
>  kernel-family:
>    headers: ["net/netdev_netlink.h"]
>    sock-priv: struct netdev_nl_sock
> diff --git a/include/uapi/linux/netdev.h b/include/uapi/linux/netdev.h
> index 48eb49aa03d4..4ef04d0bc412 100644
> --- a/include/uapi/linux/netdev.h
> +++ b/include/uapi/linux/netdev.h
> @@ -210,6 +210,17 @@ enum {
>  	NETDEV_A_DMABUF_MAX = (__NETDEV_A_DMABUF_MAX - 1)
>  };
>  
> +enum {
> +	NETDEV_A_QUEUE_PAIR_QUEUE_TYPE = 1,
> +	NETDEV_A_QUEUE_PAIR_SRC_IFINDEX,
> +	NETDEV_A_QUEUE_PAIR_SRC_QUEUE_ID,
> +	NETDEV_A_QUEUE_PAIR_DST_IFINDEX,
> +	NETDEV_A_QUEUE_PAIR_DST_QUEUE_ID,
> +
> +	__NETDEV_A_QUEUE_PAIR_MAX,
> +	NETDEV_A_QUEUE_PAIR_MAX = (__NETDEV_A_QUEUE_PAIR_MAX - 1)
> +};
> +
>  enum {
>  	NETDEV_CMD_DEV_GET = 1,
>  	NETDEV_CMD_DEV_ADD_NTF,
> @@ -226,6 +237,7 @@ enum {
>  	NETDEV_CMD_BIND_RX,
>  	NETDEV_CMD_NAPI_SET,
>  	NETDEV_CMD_BIND_TX,
> +	NETDEV_CMD_BIND_QUEUE,
>  
>  	__NETDEV_CMD_MAX,
>  	NETDEV_CMD_MAX = (__NETDEV_CMD_MAX - 1)
> diff --git a/net/core/netdev-genl-gen.c b/net/core/netdev-genl-gen.c
> index e9a2a6f26cb7..69f8126c3e42 100644
> --- a/net/core/netdev-genl-gen.c
> +++ b/net/core/netdev-genl-gen.c
> @@ -26,6 +26,16 @@ static const struct netlink_range_validation netdev_a_napi_defer_hard_irqs_range
>  	.max	= S32_MAX,
>  };
>  
> +static const struct netlink_range_validation netdev_a_queue_pair_src_ifindex_range = {
> +	.min	= 1ULL,
> +	.max	= S32_MAX,
> +};
> +
> +static const struct netlink_range_validation netdev_a_queue_pair_dst_ifindex_range = {
> +	.min	= 1ULL,
> +	.max	= S32_MAX,
> +};
> +
>  /* Common nested types */
>  const struct nla_policy netdev_page_pool_info_nl_policy[NETDEV_A_PAGE_POOL_IFINDEX + 1] = {
>  	[NETDEV_A_PAGE_POOL_ID] = NLA_POLICY_FULL_RANGE(NLA_UINT, &netdev_a_page_pool_id_range),
> @@ -106,6 +116,14 @@ static const struct nla_policy netdev_bind_tx_nl_policy[NETDEV_A_DMABUF_FD + 1]
>  	[NETDEV_A_DMABUF_FD] = { .type = NLA_U32, },
>  };
>  
> +/* NETDEV_CMD_BIND_QUEUE - do */
> +static const struct nla_policy netdev_bind_queue_nl_policy[NETDEV_A_QUEUE_PAIR_DST_IFINDEX + 1] = {
> +	[NETDEV_A_QUEUE_PAIR_QUEUE_TYPE] = NLA_POLICY_MAX(NLA_U32, 1),
> +	[NETDEV_A_QUEUE_PAIR_SRC_IFINDEX] = NLA_POLICY_FULL_RANGE(NLA_U32, &netdev_a_queue_pair_src_ifindex_range),
> +	[NETDEV_A_QUEUE_PAIR_SRC_QUEUE_ID] = { .type = NLA_U32, },
> +	[NETDEV_A_QUEUE_PAIR_DST_IFINDEX] = NLA_POLICY_FULL_RANGE(NLA_U32, &netdev_a_queue_pair_dst_ifindex_range),
> +};
> +
>  /* Ops table for netdev */
>  static const struct genl_split_ops netdev_nl_ops[] = {
>  	{
> @@ -204,6 +222,13 @@ static const struct genl_split_ops netdev_nl_ops[] = {
>  		.maxattr	= NETDEV_A_DMABUF_FD,
>  		.flags		= GENL_CMD_CAP_DO,
>  	},
> +	{
> +		.cmd		= NETDEV_CMD_BIND_QUEUE,
> +		.doit		= netdev_nl_bind_queue_doit,
> +		.policy		= netdev_bind_queue_nl_policy,
> +		.maxattr	= NETDEV_A_QUEUE_PAIR_DST_IFINDEX,
> +		.flags		= GENL_CMD_CAP_DO,
> +	},
>  };
>  
>  static const struct genl_multicast_group netdev_nl_mcgrps[] = {
> diff --git a/net/core/netdev-genl-gen.h b/net/core/netdev-genl-gen.h
> index cf3fad74511f..309248fe2b9e 100644
> --- a/net/core/netdev-genl-gen.h
> +++ b/net/core/netdev-genl-gen.h
> @@ -35,6 +35,7 @@ int netdev_nl_qstats_get_dumpit(struct sk_buff *skb,
>  int netdev_nl_bind_rx_doit(struct sk_buff *skb, struct genl_info *info);
>  int netdev_nl_napi_set_doit(struct sk_buff *skb, struct genl_info *info);
>  int netdev_nl_bind_tx_doit(struct sk_buff *skb, struct genl_info *info);
> +int netdev_nl_bind_queue_doit(struct sk_buff *skb, struct genl_info *info);
>  
>  enum {
>  	NETDEV_NLGRP_MGMT,
> diff --git a/net/core/netdev-genl.c b/net/core/netdev-genl.c
> index 470fabbeacd9..ce1018ea390f 100644
> --- a/net/core/netdev-genl.c
> +++ b/net/core/netdev-genl.c
> @@ -1120,6 +1120,11 @@ int netdev_nl_bind_tx_doit(struct sk_buff *skb, struct genl_info *info)
>  	return err;
>  }
>  
> +int netdev_nl_bind_queue_doit(struct sk_buff *skb, struct genl_info *info)
> +{
> +	return -EOPNOTSUPP;
> +}
> +
>  void netdev_nl_sock_priv_init(struct netdev_nl_sock *priv)
>  {
>  	INIT_LIST_HEAD(&priv->bindings);
> diff --git a/tools/include/uapi/linux/netdev.h b/tools/include/uapi/linux/netdev.h
> index 48eb49aa03d4..4ef04d0bc412 100644
> --- a/tools/include/uapi/linux/netdev.h
> +++ b/tools/include/uapi/linux/netdev.h
> @@ -210,6 +210,17 @@ enum {
>  	NETDEV_A_DMABUF_MAX = (__NETDEV_A_DMABUF_MAX - 1)
>  };
>  
> +enum {
> +	NETDEV_A_QUEUE_PAIR_QUEUE_TYPE = 1,
> +	NETDEV_A_QUEUE_PAIR_SRC_IFINDEX,
> +	NETDEV_A_QUEUE_PAIR_SRC_QUEUE_ID,
> +	NETDEV_A_QUEUE_PAIR_DST_IFINDEX,
> +	NETDEV_A_QUEUE_PAIR_DST_QUEUE_ID,
> +
> +	__NETDEV_A_QUEUE_PAIR_MAX,
> +	NETDEV_A_QUEUE_PAIR_MAX = (__NETDEV_A_QUEUE_PAIR_MAX - 1)
> +};
> +
>  enum {
>  	NETDEV_CMD_DEV_GET = 1,
>  	NETDEV_CMD_DEV_ADD_NTF,
> @@ -226,6 +237,7 @@ enum {
>  	NETDEV_CMD_BIND_RX,
>  	NETDEV_CMD_NAPI_SET,
>  	NETDEV_CMD_BIND_TX,
> +	NETDEV_CMD_BIND_QUEUE,
>  
>  	__NETDEV_CMD_MAX,
>  	NETDEV_CMD_MAX = (__NETDEV_CMD_MAX - 1)

Reviewed-by: Nikolay Aleksandrov <razor@blackwall.org>


