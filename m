Return-Path: <netdev+bounces-203317-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 77DC5AF149A
	for <lists+netdev@lfdr.de>; Wed,  2 Jul 2025 13:53:33 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id B35F41C41C1A
	for <lists+netdev@lfdr.de>; Wed,  2 Jul 2025 11:53:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E888A2676E6;
	Wed,  2 Jul 2025 11:53:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="qRhEcsd5";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="NEVm0wvm";
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="qRhEcsd5";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="NEVm0wvm"
X-Original-To: netdev@vger.kernel.org
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.223.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B4B1D248F63
	for <netdev@vger.kernel.org>; Wed,  2 Jul 2025 11:53:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.130
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751457206; cv=none; b=gz3RjgcY/qmd7ukeEwJJGd1tPsYn+xqONp3+o9y5GvpxDT0plNaQIjPzL7Dw8A+hmtDv2j/fXngQGBlc0vIBLCag32lPN0zuzCSRO0HF0rSzz+28q4GUVEcJe9Mdj+WZNnmEZwSpinTsDv4qUS1xiljqGhY0hY4hJa0ZM9XF0VM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751457206; c=relaxed/simple;
	bh=70U4/zLUCf9PWmydvmuymM2RHcUxkH8fRjcK8TCjcWo=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=MVnJIU0ncAFHUXmmbyBVcOAMeT1t3jL8eaYFU2dRNiwkKNAFRxNUmVJ59JfYHyO0Dq80MsXobjVJwmk2Nt1Kck8LedR3ai3ctNHiX+k9tTMDn0z2LOFLGlsSySz4PNQjNIrtZ206DpYdW4uNiwSqYY9wXyDfmFgg1D69z+NjGV0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de; spf=pass smtp.mailfrom=suse.de; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=qRhEcsd5; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=NEVm0wvm; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=qRhEcsd5; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=NEVm0wvm; arc=none smtp.client-ip=195.135.223.130
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.de
Received: from imap1.dmz-prg2.suse.org (unknown [10.150.64.97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out1.suse.de (Postfix) with ESMTPS id C27882117F;
	Wed,  2 Jul 2025 11:53:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1751457201; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=I6Yf1LzhkCKlAY8z3bGKpky9446EgntA+tEg7/NTz+4=;
	b=qRhEcsd5mVxRzvmMsya7Gt1EVCoJEOjUIu9kkHhfSxgIV6f1p3mTZNu11wkQEu0Ph6n0v6
	jkAtgcqME3JBsBKLN2jpVagayGs4jtSV1jPbT2cUAeN/BuJaFUax1AJzI9I1++tSMBecZu
	BY9qQAjqonaahoFsBoed7YwsbaPSPS0=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1751457201;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=I6Yf1LzhkCKlAY8z3bGKpky9446EgntA+tEg7/NTz+4=;
	b=NEVm0wvmJ7rc9RmXy0F9jFGHHh2QGCrN/fl+VMjULHpXh+t3gQDgNZueQpXKo2wUQz3555
	t/raB31h+Ub9ZcAg==
Authentication-Results: smtp-out1.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1751457201; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=I6Yf1LzhkCKlAY8z3bGKpky9446EgntA+tEg7/NTz+4=;
	b=qRhEcsd5mVxRzvmMsya7Gt1EVCoJEOjUIu9kkHhfSxgIV6f1p3mTZNu11wkQEu0Ph6n0v6
	jkAtgcqME3JBsBKLN2jpVagayGs4jtSV1jPbT2cUAeN/BuJaFUax1AJzI9I1++tSMBecZu
	BY9qQAjqonaahoFsBoed7YwsbaPSPS0=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1751457201;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=I6Yf1LzhkCKlAY8z3bGKpky9446EgntA+tEg7/NTz+4=;
	b=NEVm0wvmJ7rc9RmXy0F9jFGHHh2QGCrN/fl+VMjULHpXh+t3gQDgNZueQpXKo2wUQz3555
	t/raB31h+Ub9ZcAg==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 8397513A54;
	Wed,  2 Jul 2025 11:53:21 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id pRdcH7EdZWhEDwAAD6G6ig
	(envelope-from <hare@suse.de>); Wed, 02 Jul 2025 11:53:21 +0000
Message-ID: <e5b994ce-247c-4bfa-96a5-eb842ef99e20@suse.de>
Date: Wed, 2 Jul 2025 13:53:21 +0200
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v29 01/20] net: Introduce direct data placement tcp
 offload
To: Aurelien Aptel <aaptel@nvidia.com>, linux-nvme@lists.infradead.org,
 netdev@vger.kernel.org, sagi@grimberg.me, hch@lst.de, kbusch@kernel.org,
 axboe@fb.com, chaitanyak@nvidia.com, davem@davemloft.net, kuba@kernel.org
Cc: Boris Pismenny <borisp@nvidia.com>, aurelien.aptel@gmail.com,
 smalin@nvidia.com, malin1024@gmail.com, ogerlitz@nvidia.com,
 yorayz@nvidia.com, galshalom@nvidia.com, mgurtovoy@nvidia.com,
 tariqt@nvidia.com, gus@collabora.com, edumazet@google.com,
 pabeni@redhat.com, dsahern@kernel.org, ast@kernel.org,
 jacob.e.keller@intel.com
References: <20250630140737.28662-1-aaptel@nvidia.com>
 <20250630140737.28662-2-aaptel@nvidia.com>
Content-Language: en-US
From: Hannes Reinecke <hare@suse.de>
In-Reply-To: <20250630140737.28662-2-aaptel@nvidia.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Spamd-Result: default: False [-2.80 / 50.00];
	BAYES_HAM(-3.00)[100.00%];
	SUSPICIOUS_RECIPS(1.50)[];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	NEURAL_HAM_SHORT(-0.20)[-1.000];
	MIME_GOOD(-0.10)[text/plain];
	MIME_TRACE(0.00)[0:+];
	RCPT_COUNT_TWELVE(0.00)[25];
	ARC_NA(0.00)[];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	DKIM_SIGNED(0.00)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
	FUZZY_BLOCKED(0.00)[rspamd.com];
	FREEMAIL_ENVRCPT(0.00)[gmail.com];
	RCVD_TLS_ALL(0.00)[];
	TO_DN_SOME(0.00)[];
	FROM_EQ_ENVFROM(0.00)[];
	FROM_HAS_DN(0.00)[];
	FREEMAIL_CC(0.00)[nvidia.com,gmail.com,collabora.com,google.com,redhat.com,kernel.org,intel.com];
	RCVD_COUNT_TWO(0.00)[2];
	TAGGED_RCPT(0.00)[];
	MID_RHS_MATCH_FROM(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[suse.de:email,suse.de:mid]
X-Spam-Level: 
X-Spam-Flag: NO
X-Spam-Score: -2.80

On 6/30/25 16:07, Aurelien Aptel wrote:
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
>   7. get_caps - request current ULP DDP capabilities
>   8. get_stats - query NIC driver for ULP DDP stats
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
> skb_condense, we mark the sk->sk_no_condense bit.
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
>   include/linux/netdevice.h          |   5 +
>   include/linux/skbuff.h             |  31 +++
>   include/net/inet_connection_sock.h |   6 +
>   include/net/sock.h                 |   3 +-
>   include/net/tcp.h                  |   3 +-
>   include/net/ulp_ddp.h              | 326 +++++++++++++++++++++++++++++
>   net/Kconfig                        |  20 ++
>   net/core/Makefile                  |   1 +
>   net/core/skbuff.c                  |   4 +-
>   net/core/ulp_ddp.c                 |  56 +++++
>   net/ipv4/tcp_input.c               |   1 +
>   net/ipv4/tcp_offload.c             |   1 +
>   12 files changed, 454 insertions(+), 3 deletions(-)
>   create mode 100644 include/net/ulp_ddp.h
>   create mode 100644 net/core/ulp_ddp.c
> 
> diff --git a/include/linux/netdevice.h b/include/linux/netdevice.h
> index db5bfd4e7ec8..fe510ba65c7b 100644
> --- a/include/linux/netdevice.h
> +++ b/include/linux/netdevice.h
> @@ -1401,6 +1401,8 @@ struct netdev_net_notifier {
>    *			   struct kernel_hwtstamp_config *kernel_config,
>    *			   struct netlink_ext_ack *extack);
>    *	Change the hardware timestamping parameters for NIC device.
> + * struct ulp_ddp_dev_ops *ulp_ddp_ops;
> + *	ULP DDP operations (see include/net/ulp_ddp.h)
>    */
>   struct net_device_ops {
>   	int			(*ndo_init)(struct net_device *dev);
> @@ -1656,6 +1658,9 @@ struct net_device_ops {
>   	 */
>   	const struct net_shaper_ops *net_shaper_ops;
>   #endif
> +#if IS_ENABLED(CONFIG_ULP_DDP)
> +	const struct ulp_ddp_dev_ops *ulp_ddp_ops;
> +#endif
>   };
>   
>   /**
> diff --git a/include/linux/skbuff.h b/include/linux/skbuff.h
> index 4f6dcb37bae8..a9e8fc6582e2 100644
> --- a/include/linux/skbuff.h
> +++ b/include/linux/skbuff.h
> @@ -847,6 +847,7 @@ enum skb_tstamp_type {
>    *	@slow_gro: state present at GRO time, slower prepare step required
>    *	@tstamp_type: When set, skb->tstamp has the
>    *		delivery_time clock base of skb->tstamp.
> + *	@ulp_crc: CRC offloaded
>    *	@napi_id: id of the NAPI struct this skb came from
>    *	@sender_cpu: (aka @napi_id) source CPU in XPS
>    *	@alloc_cpu: CPU which did the skb allocation.
> @@ -1024,6 +1025,9 @@ struct sk_buff {
>   	__u8			csum_not_inet:1;
>   #endif
>   	__u8			unreadable:1;
> +#ifdef CONFIG_ULP_DDP
> +	__u8			ulp_crc:1;
> +#endif
>   #if defined(CONFIG_NET_SCHED) || defined(CONFIG_NET_XGRESS)
>   	__u16			tc_index;	/* traffic control index */
>   #endif
> @@ -5267,5 +5271,32 @@ static inline void skb_mark_for_recycle(struct sk_buff *skb)
>   ssize_t skb_splice_from_iter(struct sk_buff *skb, struct iov_iter *iter,
>   			     ssize_t maxsize, gfp_t gfp);
>   
> +static inline bool skb_is_ulp_crc(const struct sk_buff *skb)
> +{
> +#ifdef CONFIG_ULP_DDP
> +	return skb->ulp_crc;
> +#else
> +	return 0;
> +#endif
> +}
> +
> +static inline bool skb_cmp_ulp_crc(const struct sk_buff *skb1,
> +				   const struct sk_buff *skb2)
> +{
> +#ifdef CONFIG_ULP_DDP
> +	return skb1->ulp_crc != skb2->ulp_crc;
> +#else
> +	return 0;
> +#endif
> +}
> +
> +static inline void skb_copy_ulp_crc(struct sk_buff *to,
> +				    const struct sk_buff *from)
> +{
> +#ifdef CONFIG_ULP_DDP
> +	to->ulp_crc = from->ulp_crc;
> +#endif
> +}
> +
>   #endif	/* __KERNEL__ */
>   #endif	/* _LINUX_SKBUFF_H */
> diff --git a/include/net/inet_connection_sock.h b/include/net/inet_connection_sock.h
> index 1735db332aab..65cca0d4d6c2 100644
> --- a/include/net/inet_connection_sock.h
> +++ b/include/net/inet_connection_sock.h
> @@ -63,6 +63,8 @@ struct inet_connection_sock_af_ops {
>    * @icsk_af_ops		   Operations which are AF_INET{4,6} specific
>    * @icsk_ulp_ops	   Pluggable ULP control hook
>    * @icsk_ulp_data	   ULP private data
> + * @icsk_ulp_ddp_ops	   Pluggable ULP direct data placement control hook
> + * @icsk_ulp_ddp_data	   ULP direct data placement private data
>    * @icsk_ca_state:	   Congestion control state
>    * @icsk_retransmits:	   Number of unrecovered [RTO] timeouts
>    * @icsk_pending:	   Scheduled timer event
> @@ -92,6 +94,10 @@ struct inet_connection_sock {
>   	const struct inet_connection_sock_af_ops *icsk_af_ops;
>   	const struct tcp_ulp_ops  *icsk_ulp_ops;
>   	void __rcu		  *icsk_ulp_data;
> +#ifdef CONFIG_ULP_DDP
> +	const struct ulp_ddp_ulp_ops  *icsk_ulp_ddp_ops;
> +	void __rcu		  *icsk_ulp_ddp_data;
> +#endif
>   	unsigned int		  (*icsk_sync_mss)(struct sock *sk, u32 pmtu);
>   	__u8			  icsk_ca_state:5,
>   				  icsk_ca_initialized:1,
> diff --git a/include/net/sock.h b/include/net/sock.h
> index 0f2443d4ec58..c1b3d6e1e5e5 100644
> --- a/include/net/sock.h
> +++ b/include/net/sock.h
> @@ -507,7 +507,8 @@ struct sock {
>   	u8			sk_gso_disabled : 1,
>   				sk_kern_sock : 1,
>   				sk_no_check_tx : 1,
> -				sk_no_check_rx : 1;
> +				sk_no_check_rx : 1,
> +				sk_no_condense : 1;
>   	u8			sk_shutdown;
>   	u16			sk_type;
>   	u16			sk_protocol;
> diff --git a/include/net/tcp.h b/include/net/tcp.h
> index 761c4a0ad386..389906e53df4 100644
> --- a/include/net/tcp.h
> +++ b/include/net/tcp.h
> @@ -1148,7 +1148,8 @@ static inline bool tcp_skb_can_collapse_rx(const struct sk_buff *to,
>   					   const struct sk_buff *from)
>   {
>   	return likely(mptcp_skb_can_collapse(to, from) &&
> -		      !skb_cmp_decrypted(to, from));
> +		      !skb_cmp_decrypted(to, from) &&
> +		      !skb_cmp_ulp_crc(to, from));
>   }
>   
>   /* Events passed to congestion control interface */
> diff --git a/include/net/ulp_ddp.h b/include/net/ulp_ddp.h
> new file mode 100644
> index 000000000000..7b32bb9e2a08
> --- /dev/null
> +++ b/include/net/ulp_ddp.h
> @@ -0,0 +1,326 @@
> +/* SPDX-License-Identifier: GPL-2.0
> + *
> + * ulp_ddp.h
> + *   Author:	Boris Pismenny <borisp@nvidia.com>
> + *   Copyright (c) 2023, NVIDIA CORPORATION & AFFILIATES.  All rights reserved.
> + */
> +#ifndef _ULP_DDP_H
> +#define _ULP_DDP_H
> +
> +#include <linux/netdevice.h>
> +#include <net/inet_connection_sock.h>
> +#include <net/sock.h>
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
> + * @dgst:	digest types enabled (header or data, see
> + *		enum nvme_tcp_digest_option).
> + *		The netdev will offload crc if it is supported.
> + * @queue_size: number of nvme-tcp IO queue elements
> + */
> +struct nvme_tcp_ddp_config {
> +	u16			pfv;
> +	u8			cpda;
> +	u8			dgst;
> +	int			queue_size;
> +};
> +
> +/**
> + * struct ulp_ddp_config - Generic ulp ddp configuration
> + * Add new instances of ulp_ddp_config in the union below (nvme-tcp, etc.).
> + *
> + * @type:	type of this config struct
> + * @nvmeotcp:	NVMe-TCP specific config
> + * @affinity_hint:	cpu core running the IO thread for this socket
> + */
> +struct ulp_ddp_config {
> +	enum ulp_ddp_type    type;
> +	int		     affinity_hint;
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
> +/**
> + * struct ulp_ddp_stats - ULP DDP offload statistics
> + * @rx_nvmeotcp_sk_add: number of sockets successfully prepared for offloading.
> + * @rx_nvmeotcp_sk_add_fail: number of sockets that failed to be prepared
> + *                           for offloading.
> + * @rx_nvmeotcp_sk_del: number of sockets where offloading has been removed.
> + * @rx_nvmeotcp_ddp_setup: number of NVMeTCP PDU successfully prepared for
> + *                         Direct Data Placement.
> + * @rx_nvmeotcp_ddp_setup_fail: number of PDUs that failed DDP preparation.
> + * @rx_nvmeotcp_ddp_teardown: number of PDUs done with DDP.
> + * @rx_nvmeotcp_drop: number of PDUs dropped.
> + * @rx_nvmeotcp_resync: number of resync.
> + * @rx_nvmeotcp_packets: number of offloaded PDUs.
> + * @rx_nvmeotcp_bytes: number of offloaded bytes.
> + */
> +struct ulp_ddp_stats {
> +	u64 rx_nvmeotcp_sk_add;
> +	u64 rx_nvmeotcp_sk_add_fail;
> +	u64 rx_nvmeotcp_sk_del;
> +	u64 rx_nvmeotcp_ddp_setup;
> +	u64 rx_nvmeotcp_ddp_setup_fail;
> +	u64 rx_nvmeotcp_ddp_teardown;
> +	u64 rx_nvmeotcp_drop;
> +	u64 rx_nvmeotcp_resync;
> +	u64 rx_nvmeotcp_packets;
> +	u64 rx_nvmeotcp_bytes;
> +
> +	/*
> +	 * add new stats at the end and keep in sync with
> +	 * Documentation/netlink/specs/ulp_ddp.yaml
> +	 */
> +};
> +
> +#define ULP_DDP_CAP_COUNT 1
> +
> +struct ulp_ddp_dev_caps {
> +	DECLARE_BITMAP(active, ULP_DDP_CAP_COUNT);
> +	DECLARE_BITMAP(hw, ULP_DDP_CAP_COUNT);
> +};
> +
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
> + * @get_caps:  get device ULP DDP capabilities.
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
> +	void (*get_caps)(struct net_device *dev,
> +			 struct ulp_ddp_dev_caps *caps);
> +	int (*get_stats)(struct net_device *dev,
> +			 struct ulp_ddp_stats *stats);
> +};
> +
> +#define ULP_DDP_RESYNC_PENDING BIT(0)
> +
> +/**
> + * struct ulp_ddp_ulp_ops - Interface to register upper layer
> + *                          Direct Data Placement (DDP) TCP offload.
> + * @resync_request:         NIC requests ulp to indicate if @seq is the start
> + *                          of a message.
> + * @ddp_teardown_done:      NIC driver informs the ulp that teardown is done,
> + *                          used for async completions.
> + */
> +struct ulp_ddp_ulp_ops {
> +	bool (*resync_request)(struct sock *sk, u32 seq, u32 flags);
> +	void (*ddp_teardown_done)(void *ddp_ctx);
> +};
> +
> +/**
> + * struct ulp_ddp_ctx - Generic ulp ddp context
> + *
> + * @type:	type of this context struct
> + * @buf:	protocol-specific context struct
> + */
> +struct ulp_ddp_ctx {
> +	enum ulp_ddp_type	type;
> +	unsigned char		buf[];
> +};
> +
> +static inline struct ulp_ddp_ctx *ulp_ddp_get_ctx(struct sock *sk)
> +{
> +#ifdef CONFIG_ULP_DDP
> +	struct inet_connection_sock *icsk = inet_csk(sk);
> +
> +	return (__force struct ulp_ddp_ctx *)icsk->icsk_ulp_ddp_data;
> +#else
> +	return NULL;
> +#endif
> +}
> +
> +static inline void ulp_ddp_set_ctx(struct sock *sk, void *ctx)
> +{
> +#ifdef CONFIG_ULP_DDP
> +	struct inet_connection_sock *icsk = inet_csk(sk);
> +
> +	rcu_assign_pointer(icsk->icsk_ulp_ddp_data, ctx);
> +#endif
> +}
> +
> +static inline int ulp_ddp_setup(struct net_device *netdev,
> +				struct sock *sk,
> +				struct ulp_ddp_io *io)
> +{
> +#ifdef CONFIG_ULP_DDP
> +	return netdev->netdev_ops->ulp_ddp_ops->setup(netdev, sk, io);
> +#else
> +	return -EOPNOTSUPP;
> +#endif
> +}
> +
> +static inline void ulp_ddp_teardown(struct net_device *netdev,
> +				    struct sock *sk,
> +				    struct ulp_ddp_io *io,
> +				    void *ddp_ctx)
> +{
> +#ifdef CONFIG_ULP_DDP
> +	netdev->netdev_ops->ulp_ddp_ops->teardown(netdev, sk, io, ddp_ctx);
> +#endif
> +}
> +
> +static inline void ulp_ddp_resync(struct net_device *netdev,
> +				  struct sock *sk,
> +				  u32 seq)
> +{
> +#ifdef CONFIG_ULP_DDP
> +	netdev->netdev_ops->ulp_ddp_ops->resync(netdev, sk, seq);
> +#endif
> +}
> +
> +static inline int ulp_ddp_get_limits(struct net_device *netdev,
> +				     struct ulp_ddp_limits *limits,
> +				     enum ulp_ddp_type type)
> +{
> +#ifdef CONFIG_ULP_DDP
> +	limits->type = type;
> +	return netdev->netdev_ops->ulp_ddp_ops->limits(netdev, limits);
> +#else
> +	return -EOPNOTSUPP;
> +#endif
> +}
> +
> +static inline bool ulp_ddp_cap_turned_on(unsigned long *old,
> +					 unsigned long *new,
> +					 int bit_nr)
> +{
> +	return !test_bit(bit_nr, old) && test_bit(bit_nr, new);
> +}
> +
> +static inline bool ulp_ddp_cap_turned_off(unsigned long *old,
> +					  unsigned long *new,
> +					  int bit_nr)
> +{
> +	return test_bit(bit_nr, old) && !test_bit(bit_nr, new);
> +}
> +
> +#ifdef CONFIG_ULP_DDP
> +
> +int ulp_ddp_sk_add(struct net_device *netdev,
> +		   netdevice_tracker *tracker,
> +		   gfp_t gfp,
> +		   struct sock *sk,
> +		   struct ulp_ddp_config *config,
> +		   const struct ulp_ddp_ulp_ops *ops);
> +
> +void ulp_ddp_sk_del(struct net_device *netdev,
> +		    netdevice_tracker *tracker,
> +		    struct sock *sk);
> +
> +bool ulp_ddp_is_cap_active(struct net_device *netdev, int cap_bit_nr);
> +
> +#else
> +
> +static inline int ulp_ddp_sk_add(struct net_device *netdev,
> +				 netdevice_tracker *tracker,
> +				 gfp_t gfp,
> +				 struct sock *sk,
> +				 struct ulp_ddp_config *config,
> +				 const struct ulp_ddp_ulp_ops *ops)
> +{
> +	return -EOPNOTSUPP;
> +}
> +
> +static inline void ulp_ddp_sk_del(struct net_device *netdev,
> +				  netdevice_tracker *tracker,
> +				  struct sock *sk)
> +{}
> +
> +static inline bool ulp_ddp_is_cap_active(struct net_device *netdev,
> +					 int cap_bit_nr)
> +{
> +	return false;
> +}
> +
> +#endif
> +
> +#endif	/* _ULP_DDP_H */
> diff --git a/net/Kconfig b/net/Kconfig
> index ebc80a98fc91..803c4bfda43a 100644
> --- a/net/Kconfig
> +++ b/net/Kconfig
> @@ -541,4 +541,24 @@ config NET_TEST
>   
>   	  If unsure, say N.
>   
> +config ULP_DDP
> +	bool "ULP direct data placement offload"
> +	help
> +	  This feature provides a generic infrastructure for Direct
> +	  Data Placement (DDP) offload for Upper Layer Protocols (ULP,
> +	  such as NVMe-TCP).
> +
> +	  If the ULP and NIC driver supports it, the ULP code can
> +	  request the NIC to place ULP response data directly
> +	  into application memory, avoiding a costly copy.
> +
> +	  This infrastructure also allows for offloading the ULP data
> +	  integrity checks (e.g. data digest) that would otherwise
> +	  require another costly pass on the data we managed to avoid
> +	  copying.
> +
> +	  For more information, see
> +	  <file:Documentation/networking/ulp-ddp-offload.rst>.
> +
> +
>   endif   # if NET
> diff --git a/net/core/Makefile b/net/core/Makefile
> index b2a76ce33932..6d817870d7c3 100644
> --- a/net/core/Makefile
> +++ b/net/core/Makefile
> @@ -20,6 +20,7 @@ obj-$(CONFIG_NETDEV_ADDR_LIST_TEST) += dev_addr_lists_test.o
>   obj-y += net-sysfs.o
>   obj-y += hotdata.o
>   obj-y += netdev_rx_queue.o
> +obj-$(CONFIG_ULP_DDP) += ulp_ddp.o
>   obj-$(CONFIG_PAGE_POOL) += page_pool.o page_pool_user.o
>   obj-$(CONFIG_PROC_FS) += net-procfs.o
>   obj-$(CONFIG_NET_PKTGEN) += pktgen.o
> diff --git a/net/core/skbuff.c b/net/core/skbuff.c
> index d6420b74ea9c..fe5a9df175cc 100644
> --- a/net/core/skbuff.c
> +++ b/net/core/skbuff.c
> @@ -80,6 +80,7 @@
>   #include <net/mctp.h>
>   #include <net/page_pool/helpers.h>
>   #include <net/dropreason.h>
> +#include <net/ulp_ddp.h>
>   
>   #include <linux/uaccess.h>
>   #include <trace/events/skb.h>
> @@ -6940,7 +6941,8 @@ void skb_condense(struct sk_buff *skb)
>   {
>   	if (skb->data_len) {
>   		if (skb->data_len > skb->end - skb->tail ||
> -		    skb_cloned(skb) || !skb_frags_readable(skb))
> +		    skb_cloned(skb) || !skb_frags_readable(skb) ||
> +		    (skb->sk && skb->sk->sk_no_condense))
>   			return;
>   
>   		/* Nice, we can free page frag(s) right now */
> diff --git a/net/core/ulp_ddp.c b/net/core/ulp_ddp.c
> new file mode 100644
> index 000000000000..c02786ed5aeb
> --- /dev/null
> +++ b/net/core/ulp_ddp.c
> @@ -0,0 +1,56 @@
> +// SPDX-License-Identifier: GPL-2.0
> +/*
> + *
> + * ulp_ddp.c
> + *   Author:	Aurelien Aptel <aaptel@nvidia.com>
> + *   Copyright (c) 2023, NVIDIA CORPORATION & AFFILIATES.  All rights reserved.
> + */
> +
> +#include <net/ulp_ddp.h>
> +
> +int ulp_ddp_sk_add(struct net_device *netdev,
> +		   netdevice_tracker *tracker,
> +		   gfp_t gfp,
> +		   struct sock *sk,
> +		   struct ulp_ddp_config *config,
> +		   const struct ulp_ddp_ulp_ops *ops)
> +{
> +	int ret;
> +
> +	/* put in ulp_ddp_sk_del() */
> +	netdev_hold(netdev, tracker, gfp);
> +
> +	ret = netdev->netdev_ops->ulp_ddp_ops->sk_add(netdev, sk, config);
> +	if (ret) {
> +		dev_put(netdev);
> +		return ret;
> +	}
> +
> +	inet_csk(sk)->icsk_ulp_ddp_ops = ops;
> +	sk->sk_no_condense = true;
> +
> +	return 0;
> +}
> +EXPORT_SYMBOL_GPL(ulp_ddp_sk_add);
> +
> +void ulp_ddp_sk_del(struct net_device *netdev,
> +		    netdevice_tracker *tracker,
> +		    struct sock *sk)
> +{
> +	netdev->netdev_ops->ulp_ddp_ops->sk_del(netdev, sk);
> +	inet_csk(sk)->icsk_ulp_ddp_ops = NULL;
> +	sk->sk_no_condense = false;
> +	netdev_put(netdev, tracker);
> +}
> +EXPORT_SYMBOL_GPL(ulp_ddp_sk_del);
> +
> +bool ulp_ddp_is_cap_active(struct net_device *netdev, int cap_bit_nr)
> +{
> +	struct ulp_ddp_dev_caps caps;
> +
> +	if (!netdev->netdev_ops->ulp_ddp_ops)
> +		return false;
> +	netdev->netdev_ops->ulp_ddp_ops->get_caps(netdev, &caps);
> +	return test_bit(cap_bit_nr, caps.active);
> +}
> +EXPORT_SYMBOL_GPL(ulp_ddp_is_cap_active);
> diff --git a/net/ipv4/tcp_input.c b/net/ipv4/tcp_input.c
> index 19a1542883df..2351cc06d458 100644
> --- a/net/ipv4/tcp_input.c
> +++ b/net/ipv4/tcp_input.c
> @@ -5368,6 +5368,7 @@ tcp_collapse(struct sock *sk, struct sk_buff_head *list, struct rb_root *root,
>   
>   		memcpy(nskb->cb, skb->cb, sizeof(skb->cb));
>   		skb_copy_decrypted(nskb, skb);
> +		skb_copy_ulp_crc(nskb, skb);
>   		TCP_SKB_CB(nskb)->seq = TCP_SKB_CB(nskb)->end_seq = start;
>   		if (list)
>   			__skb_queue_before(list, skb, nskb);
> diff --git a/net/ipv4/tcp_offload.c b/net/ipv4/tcp_offload.c
> index d293087b426d..77ae71ea25f6 100644
> --- a/net/ipv4/tcp_offload.c
> +++ b/net/ipv4/tcp_offload.c
> @@ -353,6 +353,7 @@ struct sk_buff *tcp_gro_receive(struct list_head *head, struct sk_buff *skb,
>   
>   	flush |= (ntohl(th2->seq) + skb_gro_len(p)) ^ ntohl(th->seq);
>   	flush |= skb_cmp_decrypted(p, skb);
> +	flush |= skb_cmp_ulp_crc(p, skb);
>   
>   	if (unlikely(NAPI_GRO_CB(p)->is_flist)) {
>   		flush |= (__force int)(flags ^ tcp_flag_word(th2));

Hmm. One wonders: where is the different between this DDP implementation
and the existing DDP implementation added with 4d288d5767f8 ("[SCSI] 
net: add FCoE offload support through net_device") ?

Cheers,

Hannes
-- 
Dr. Hannes Reinecke                  Kernel Storage Architect
hare@suse.de                                +49 911 74053 688
SUSE Software Solutions GmbH, Frankenstr. 146, 90461 Nürnberg
HRB 36809 (AG Nürnberg), GF: I. Totev, A. McDonald, W. Knoblich

