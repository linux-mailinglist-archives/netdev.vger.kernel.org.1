Return-Path: <netdev+bounces-25717-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 13C467753F0
	for <lists+netdev@lfdr.de>; Wed,  9 Aug 2023 09:15:44 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 372001C2110C
	for <lists+netdev@lfdr.de>; Wed,  9 Aug 2023 07:15:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CCF3D6110;
	Wed,  9 Aug 2023 07:15:40 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BB553566D
	for <netdev@vger.kernel.org>; Wed,  9 Aug 2023 07:15:40 +0000 (UTC)
Received: from mail-wm1-f43.google.com (mail-wm1-f43.google.com [209.85.128.43])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9A6EA1BCF
	for <netdev@vger.kernel.org>; Wed,  9 Aug 2023 00:15:38 -0700 (PDT)
Received: by mail-wm1-f43.google.com with SMTP id 5b1f17b1804b1-3fe4f3b5f25so9201665e9.0
        for <netdev@vger.kernel.org>; Wed, 09 Aug 2023 00:15:38 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1691565337; x=1692170137;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=X5B2K2pvwKA9Wq8Dl+kWR4xuQovpDnJXA1ylw11/oa4=;
        b=jLxiljhB3oGTmt59R5o4RW6fRUhbzyySFX87sEF9wFW1phxgP7/pbmjTToKUkygbGX
         bO0t8vrvzXSsi9xUr4/gG2er4qPwrmSxb5Sfwtqm80iKy0SfHmYzN1rqoyGRMFWOkRmb
         DC7Ekswv6LL2omgGpQSBmkgDBncpzlV6+l+MHcN+KSjKRuxNJrh27QOKjveYY8RPFUEx
         Ma1El0Q240DIG8gT1wyEt6qY/HRP69GitYBgV0VoXisvhXS6Vw/ld5uIq6iM5BKIts7s
         xGlrRJ1ooV40g5Pc34IquZr6sJwHOyDJ70+jf/16vzs9eHHvtUE4iIjSdodSQ6dp61W6
         bl+g==
X-Gm-Message-State: AOJu0YzEvcVLhZAPW7KCHj7kiT4yNO0cg/XGWjUWEdNc0nNwd/z7uC/a
	Jrk+uy2AslG351tqzQ/3WLw=
X-Google-Smtp-Source: AGHT+IEa1EpdphkSe/8HGXyk+ZABdA2vbaF1wVjFQHRTGCarxSViS8i7obm9/cb/RrB9dxxX7bqF2Q==
X-Received: by 2002:a05:600c:1d19:b0:3fe:21a6:a18 with SMTP id l25-20020a05600c1d1900b003fe21a60a18mr1575937wms.3.1691565336707;
        Wed, 09 Aug 2023 00:15:36 -0700 (PDT)
Received: from [192.168.64.157] (bzq-219-42-90.isdn.bezeqint.net. [62.219.42.90])
        by smtp.gmail.com with ESMTPSA id 8-20020a05600c228800b003fbcf032c55sm1036871wmf.7.2023.08.09.00.15.32
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 09 Aug 2023 00:15:36 -0700 (PDT)
Message-ID: <eb7c7bee-7105-ef0d-0f62-c251a2919128@grimberg.me>
Date: Wed, 9 Aug 2023 10:15:31 +0300
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.13.0
Subject: Re: [PATCH v12 01/26] net: Introduce direct data placement tcp
 offload
Content-Language: en-US
To: Aurelien Aptel <aaptel@nvidia.com>, linux-nvme@lists.infradead.org,
 netdev@vger.kernel.org, hch@lst.de, kbusch@kernel.org, axboe@fb.com,
 chaitanyak@nvidia.com, davem@davemloft.net, kuba@kernel.org
Cc: Boris Pismenny <borisp@nvidia.com>, aurelien.aptel@gmail.com,
 smalin@nvidia.com, malin1024@gmail.com, ogerlitz@nvidia.com,
 yorayz@nvidia.com, galshalom@nvidia.com, mgurtovoy@nvidia.com
References: <20230712161513.134860-1-aaptel@nvidia.com>
 <20230712161513.134860-2-aaptel@nvidia.com>
From: Sagi Grimberg <sagi@grimberg.me>
In-Reply-To: <20230712161513.134860-2-aaptel@nvidia.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-3.2 required=5.0 tests=BAYES_00,
	FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
	NICE_REPLY_A,RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,
	SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net



On 7/12/23 19:14, Aurelien Aptel wrote:
> From: Boris Pismenny <borisp@nvidia.com>
> 
> This commit introduces direct data placement (DDP) offload for TCP.
> 
> The motivation is saving compute resources/cycles that are spent
> to copy data from SKBs to the block layer buffers and CRC
> calculation/verification for received PDUs (Protocol Data Units).
> 
> The DDP capability is accompanied by new net_device operations that
> configure hardware contexts.
> 
> There is a context per socket, and a context per DDP operation.
> Additionally, a resynchronization routine is used to assist
> hardware handle TCP OOO, and continue the offload. Furthermore,
> we let the offloading driver advertise what is the max hw
> sectors/segments.
> 
> The interface includes the following net-device ddp operations:
> 
>   1. sk_add - add offload for the queue represented by socket+config pair
>   2. sk_del - remove the offload for the socket/queue
>   3. ddp_setup - request copy offload for buffers associated with an IO
>   4. ddp_teardown - release offload resources for that IO
>   5. limits - query NIC driver for quirks and limitations (e.g.
>               max number of scatter gather entries per IO)
>   6. set_caps - request ULP DDP capabilities enablement
>   7. get_stats - query NIC driver for ULP DDP stats
> 
> Using this interface, the NIC hardware will scatter TCP payload
> directly to the BIO pages according to the command_id.
> 
> To maintain the correctness of the network stack, the driver is
> expected to construct SKBs that point to the BIO pages.
> 
> The SKB passed to the network stack from the driver represents
> data as it is on the wire, while it is pointing directly to data
> in destination buffers.
> 
> As a result, data from page frags should not be copied out to
> the linear part. To avoid needless copies, such as when using
> skb_condense, we mark the skb->ulp_ddp bit.
> In addition, the skb->ulp_crc will be used by the upper layers to
> determine if CRC re-calculation is required. The two separated skb
> indications are needed to avoid false positives GRO flushing events.
> 
> Follow-up patches will use this interface for DDP in NVMe-TCP.
> 
> Capability bits stored in net_device allow drivers to report which
> ULP DDP capabilities a device supports. Control over these
> capabilities will be exposed to userspace in later patches.
> 
> Signed-off-by: Boris Pismenny <borisp@nvidia.com>
> Signed-off-by: Ben Ben-Ishay <benishay@nvidia.com>
> Signed-off-by: Or Gerlitz <ogerlitz@nvidia.com>
> Signed-off-by: Yoray Zack <yorayz@nvidia.com>
> Signed-off-by: Shai Malin <smalin@nvidia.com>
> Signed-off-by: Aurelien Aptel <aaptel@nvidia.com>
> ---
>   include/linux/netdevice.h          |  15 +++
>   include/linux/skbuff.h             |  25 +++-
>   include/net/inet_connection_sock.h |   6 +
>   include/net/ulp_ddp.h              | 191 +++++++++++++++++++++++++++++
>   include/net/ulp_ddp_caps.h         |  35 ++++++
>   net/Kconfig                        |  20 +++
>   net/core/skbuff.c                  |   3 +-
>   net/ipv4/tcp_input.c               |  13 +-
>   net/ipv4/tcp_ipv4.c                |   3 +
>   net/ipv4/tcp_offload.c             |   3 +
>   10 files changed, 311 insertions(+), 3 deletions(-)
>   create mode 100644 include/net/ulp_ddp.h
>   create mode 100644 include/net/ulp_ddp_caps.h
> 
> diff --git a/include/linux/netdevice.h b/include/linux/netdevice.h
> index b828c7a75be2..26e25b2df6fa 100644
> --- a/include/linux/netdevice.h
> +++ b/include/linux/netdevice.h
> @@ -54,6 +54,10 @@
>   #include <net/net_debug.h>
>   #include <net/dropreason-core.h>
>   
> +#ifdef CONFIG_ULP_DDP
> +#include <net/ulp_ddp_caps.h>
> +#endif
> +
>   struct netpoll_info;
>   struct device;
>   struct ethtool_ops;
> @@ -1418,6 +1422,8 @@ struct netdev_net_notifier {
>    *	Get hardware timestamp based on normal/adjustable time or free running
>    *	cycle counter. This function is required if physical clock supports a
>    *	free running cycle counter.
> + * struct ulp_ddp_dev_ops *ulp_ddp_ops;
> + *	ULP DDP operations (see include/net/ulp_ddp.h)
>    */
>   struct net_device_ops {
>   	int			(*ndo_init)(struct net_device *dev);
> @@ -1652,6 +1658,9 @@ struct net_device_ops {
>   	ktime_t			(*ndo_get_tstamp)(struct net_device *dev,
>   						  const struct skb_shared_hwtstamps *hwtstamps,
>   						  bool cycles);
> +#if IS_ENABLED(CONFIG_ULP_DDP)
> +	const struct ulp_ddp_dev_ops	*ulp_ddp_ops;
> +#endif
>   };
>   
>   struct xdp_metadata_ops {
> @@ -1825,6 +1834,9 @@ enum netdev_ml_priv_type {
>    *	@mpls_features:	Mask of features inheritable by MPLS
>    *	@gso_partial_features: value(s) from NETIF_F_GSO\*
>    *
> + *	@ulp_ddp_caps:	Bitflags keeping track of supported and enabled
> + *			ULP DDP capabilities.
> + *
>    *	@ifindex:	interface index
>    *	@group:		The group the device belongs to
>    *
> @@ -2121,6 +2133,9 @@ struct net_device {
>   	netdev_features_t	mpls_features;
>   	netdev_features_t	gso_partial_features;
>   
> +#ifdef CONFIG_ULP_DDP
> +	struct ulp_ddp_netdev_caps ulp_ddp_caps;
> +#endif
>   	unsigned int		min_mtu;
>   	unsigned int		max_mtu;
>   	unsigned short		type;
> diff --git a/include/linux/skbuff.h b/include/linux/skbuff.h
> index 91ed66952580..cfa65945874d 100644
> --- a/include/linux/skbuff.h
> +++ b/include/linux/skbuff.h
> @@ -813,6 +813,8 @@ typedef unsigned char *sk_buff_data_t;
>    *		delivery_time in mono clock base (i.e. EDT).  Otherwise, the
>    *		skb->tstamp has the (rcv) timestamp at ingress and
>    *		delivery_time at egress.
> + *	@ulp_ddp: DDP offloaded
> + *	@ulp_crc: CRC offloaded
>    *	@napi_id: id of the NAPI struct this skb came from
>    *	@sender_cpu: (aka @napi_id) source CPU in XPS
>    *	@alloc_cpu: CPU which did the skb allocation.
> @@ -992,7 +994,10 @@ struct sk_buff {
>   #if IS_ENABLED(CONFIG_IP_SCTP)
>   	__u8			csum_not_inet:1;
>   #endif
> -
> +#ifdef CONFIG_ULP_DDP
> +	__u8                    ulp_ddp:1;
> +	__u8			ulp_crc:1;
> +#endif
>   #ifdef CONFIG_NET_SCHED
>   	__u16			tc_index;	/* traffic control index */
>   #endif
> @@ -5040,5 +5045,23 @@ static inline void skb_mark_for_recycle(struct sk_buff *skb)
>   ssize_t skb_splice_from_iter(struct sk_buff *skb, struct iov_iter *iter,
>   			     ssize_t maxsize, gfp_t gfp);
>   
> +static inline bool skb_is_ulp_ddp(struct sk_buff *skb)
> +{
> +#ifdef CONFIG_ULP_DDP
> +	return skb->ulp_ddp;
> +#else
> +	return 0;
> +#endif
> +}
> +
> +static inline bool skb_is_ulp_crc(struct sk_buff *skb)
> +{
> +#ifdef CONFIG_ULP_DDP
> +	return skb->ulp_crc;
> +#else
> +	return 0;
> +#endif
> +}
> +
>   #endif	/* __KERNEL__ */
>   #endif	/* _LINUX_SKBUFF_H */
> diff --git a/include/net/inet_connection_sock.h b/include/net/inet_connection_sock.h
> index c2b15f7e5516..b11fbbc95541 100644
> --- a/include/net/inet_connection_sock.h
> +++ b/include/net/inet_connection_sock.h
> @@ -68,6 +68,8 @@ struct inet_connection_sock_af_ops {
>    * @icsk_ulp_ops	   Pluggable ULP control hook
>    * @icsk_ulp_data	   ULP private data
>    * @icsk_clean_acked	   Clean acked data hook
> + * @icsk_ulp_ddp_ops	   Pluggable ULP direct data placement control hook
> + * @icsk_ulp_ddp_data	   ULP direct data placement private data
>    * @icsk_ca_state:	   Congestion control state
>    * @icsk_retransmits:	   Number of unrecovered [RTO] timeouts
>    * @icsk_pending:	   Scheduled timer event
> @@ -98,6 +100,10 @@ struct inet_connection_sock {
>   	const struct tcp_ulp_ops  *icsk_ulp_ops;
>   	void __rcu		  *icsk_ulp_data;
>   	void (*icsk_clean_acked)(struct sock *sk, u32 acked_seq);
> +#ifdef CONFIG_ULP_DDP
> +	const struct ulp_ddp_ulp_ops  *icsk_ulp_ddp_ops;
> +	void __rcu		  *icsk_ulp_ddp_data;
> +#endif
>   	unsigned int		  (*icsk_sync_mss)(struct sock *sk, u32 pmtu);
>   	__u8			  icsk_ca_state:5,
>   				  icsk_ca_initialized:1,
> diff --git a/include/net/ulp_ddp.h b/include/net/ulp_ddp.h
> new file mode 100644
> index 000000000000..b85fda4450b4
> --- /dev/null
> +++ b/include/net/ulp_ddp.h
> @@ -0,0 +1,191 @@
> +/* SPDX-License-Identifier: GPL-2.0
> + *
> + * ulp_ddp.h
> + *	Author:	Boris Pismenny <borisp@nvidia.com>
> + *	Copyright (c) 2023, NVIDIA CORPORATION & AFFILIATES.  All rights reserved.
> + */
> +#ifndef _ULP_DDP_H
> +#define _ULP_DDP_H
> +
> +#include <linux/netdevice.h>
> +#include <net/inet_connection_sock.h>
> +#include <net/sock.h>
> +
> +#include "ulp_ddp_caps.h"
> +
> +enum ulp_ddp_type {
> +	ULP_DDP_NVME = 1,
> +};
> +
> +/**
> + * struct nvme_tcp_ddp_limits - nvme tcp driver limitations
> + *
> + * @full_ccid_range:	true if the driver supports the full CID range
> + */
> +struct nvme_tcp_ddp_limits {
> +	bool			full_ccid_range;
> +};
> +
> +/**
> + * struct ulp_ddp_limits - Generic ulp ddp limits: tcp ddp
> + * protocol limits.
> + * Add new instances of ulp_ddp_limits in the union below (nvme-tcp, etc.).
> + *
> + * @type:		type of this limits struct
> + * @max_ddp_sgl_len:	maximum sgl size supported (zero means no limit)
> + * @io_threshold:	minimum payload size required to offload
> + * @tls:		support for ULP over TLS
> + * @nvmeotcp:		NVMe-TCP specific limits
> + */
> +struct ulp_ddp_limits {
> +	enum ulp_ddp_type	type;
> +	int			max_ddp_sgl_len;
> +	int			io_threshold;
> +	bool			tls:1;

Is this a catch-all for tls 1.2/1.3 or future ones?

> +	union {
> +		struct nvme_tcp_ddp_limits nvmeotcp;
> +	};
> +};
> +
> +/**
> + * struct nvme_tcp_ddp_config - nvme tcp ddp configuration for an IO queue
> + *
> + * @pfv:	pdu version (e.g., NVME_TCP_PFV_1_0)
> + * @cpda:	controller pdu data alignment (dwords, 0's based)
> + * @dgst:	digest types enabled (header or data, see enum nvme_tcp_digest_option).
> + *		The netdev will offload crc if it is supported.
> + * @queue_size: number of nvme-tcp IO queue elements
> + * @queue_id:	queue identifier
> + * @io_cpu:	cpu core running the IO thread for this queue
> + */
> +struct nvme_tcp_ddp_config {
> +	u16			pfv;
> +	u8			cpda;
> +	u8			dgst;
> +	int			queue_size;
> +	int			queue_id;
> +	int			io_cpu;
> +};
> +
> +/**
> + * struct ulp_ddp_config - Generic ulp ddp configuration
> + * Add new instances of ulp_ddp_config in the union below (nvme-tcp, etc.).
> + *
> + * @type:	type of this config struct
> + * @nvmeotcp:	NVMe-TCP specific config
> + */
> +struct ulp_ddp_config {
> +	enum ulp_ddp_type    type;
> +	union {
> +		struct nvme_tcp_ddp_config nvmeotcp;
> +	};
> +};
> +
> +/**
> + * struct ulp_ddp_io - ulp ddp configuration for an IO request.
> + *
> + * @command_id: identifier on the wire associated with these buffers
> + * @nents:	number of entries in the sg_table
> + * @sg_table:	describing the buffers for this IO request
> + * @first_sgl:	first SGL in sg_table
> + */
> +struct ulp_ddp_io {
> +	u32			command_id;
> +	int			nents;
> +	struct sg_table		sg_table;
> +	struct scatterlist	first_sgl[SG_CHUNK_SIZE];
> +};
> +
> +struct ethtool_ulp_ddp_stats;
> +struct netlink_ext_ack;
> +
> +/**
> + * struct ulp_ddp_dev_ops - operations used by an upper layer protocol
> + *                          to configure ddp offload
> + *
> + * @limits:    query ulp driver limitations and quirks.
> + * @sk_add:    add offload for the queue represented by socket+config
> + *             pair. this function is used to configure either copy, crc
> + *             or both offloads.
> + * @sk_del:    remove offload from the socket, and release any device
> + *             related resources.
> + * @setup:     request copy offload for buffers associated with a
> + *             command_id in ulp_ddp_io.
> + * @teardown:  release offload resources association between buffers
> + *             and command_id in ulp_ddp_io.
> + * @resync:    respond to the driver's resync_request. Called only if
> + *             resync is successful.
> + * @set_caps:  set device ULP DDP capabilities.
> + *	       returns a negative error code or zero.
> + * @get_stats: query ULP DDP statistics.
> + */
> +struct ulp_ddp_dev_ops {
> +	int (*limits)(struct net_device *netdev,
> +		      struct ulp_ddp_limits *limits);
> +	int (*sk_add)(struct net_device *netdev,
> +		      struct sock *sk,
> +		      struct ulp_ddp_config *config);
> +	void (*sk_del)(struct net_device *netdev,
> +		       struct sock *sk);
> +	int (*setup)(struct net_device *netdev,
> +		     struct sock *sk,
> +		     struct ulp_ddp_io *io);
> +	void (*teardown)(struct net_device *netdev,
> +			 struct sock *sk,
> +			 struct ulp_ddp_io *io,
> +			 void *ddp_ctx);
> +	void (*resync)(struct net_device *netdev,
> +		       struct sock *sk, u32 seq);
> +	int (*set_caps)(struct net_device *dev, unsigned long *bits,
> +			struct netlink_ext_ack *extack);
> +	int (*get_stats)(struct net_device *dev,
> +			 struct ethtool_ulp_ddp_stats *stats);
> +};

It would be beneficial to have proper wrappers to these that
can also do some housekeeping work around the callbacks.

