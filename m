Return-Path: <netdev+bounces-295159-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id T+wcDllSIWpdDQEAu9opvQ
	(envelope-from <netdev+bounces-295159-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Thu, 04 Jun 2026 12:24:25 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [IPv6:2600:3c09:e001:a7::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id C3BFA63EFB2
	for <lists+netdev@lfdr.de>; Thu, 04 Jun 2026 12:24:24 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=redhat.com header.s=mimecast20190719 header.b=AHeCUvTq;
	dkim=pass header.d=redhat.com header.s=google header.b=psS9YGL3;
	spf=pass (mail.lfdr.de: domain of "netdev+bounces-295159-lists+netdev=lfdr.de@vger.kernel.org" designates 2600:3c09:e001:a7::12fc:5321 as permitted sender) smtp.mailfrom="netdev+bounces-295159-lists+netdev=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=quarantine) header.from=redhat.com;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id 6BB94305EFA1
	for <lists+netdev@lfdr.de>; Thu,  4 Jun 2026 10:18:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8D97C34214A;
	Thu,  4 Jun 2026 10:18:13 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 60A4233B6F8
	for <netdev@vger.kernel.org>; Thu,  4 Jun 2026 10:18:11 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780568293; cv=none; b=nM4esxOmyjvKa6rv+DDChP5D2m6TIDOE7HxIWM8C2G2v12ovSaIDIqsJfTx7KjvIjdDB1fH5TtvA53OE4x/onA/8NpYVbDdbcgYi7M1mejGnGfmsXw4EsRBaRn6UaNz4482fVfcPsL2xEj7itV6kBep4GWqDTo9uE6vbjUbGBLI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780568293; c=relaxed/simple;
	bh=KhLIJUHBbJHC/lHLUecAXzoPMGxTL2ki66v/YWfiaYM=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=Nd5GsN/Sf7CTjwwgTN6i0VMSWXrqfJE0SGYAgPtuwe8SjvM/ZSBpwLK4Vc1PhDZ44MA+pI26KAFkvI0M9A2OdSioKcnaNfymZfnwr3XMSbD1wAAEecyLxDiwxjtYZOzdEpBTrQ8fmvuqaWGkVcCh/mmD3K3fv3jhimNYb8sW4lE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=AHeCUvTq; dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b=psS9YGL3; arc=none smtp.client-ip=170.10.133.124
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1780568290;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=kF73Sj6shq7pcG8t4VFsQHJ7hu1p/CAQIq9b7qcJi98=;
	b=AHeCUvTqNlX6wsauPanw5MyFoHSWvl/ZmtBYiIDzK5ednAO+h/jzf2V+5ND2XfYUOTFSCs
	TSq88rHzUDfn4Fa0Uof9nsyAKWcVu1UfktCFcxRyRq5XFRixod/uMbP9oK8PGlWlO3w6EU
	qfoMbT1SRBO5fIXulDi0+6NamsrZL9o=
Received: from mail-wr1-f70.google.com (mail-wr1-f70.google.com
 [209.85.221.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-418-j2SAN42TMnWS-rqHhyYRMw-1; Thu, 04 Jun 2026 06:18:09 -0400
X-MC-Unique: j2SAN42TMnWS-rqHhyYRMw-1
X-Mimecast-MFC-AGG-ID: j2SAN42TMnWS-rqHhyYRMw_1780568288
Received: by mail-wr1-f70.google.com with SMTP id ffacd0b85a97d-45ef3aeeb41so380466f8f.1
        for <netdev@vger.kernel.org>; Thu, 04 Jun 2026 03:18:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=redhat.com; s=google; t=1780568288; x=1781173088; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:content-language:from
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=kF73Sj6shq7pcG8t4VFsQHJ7hu1p/CAQIq9b7qcJi98=;
        b=psS9YGL3O/HIQ//FZEz0pFVdK7/Du8zJ7p4rd9QpiJofU1KYm3CTRZt8RRznJEBhxE
         SXU+bzOrmQ5ryuzo3FG9oi4EtJzXizsuhMOh+SJnw4orYVIKC93yviyIatwXy3E1W4wI
         aYzwHAAjGHOMO23a5cqTWJnMMXKcZxNAk0/dp7Pbc8/s1mFBjsC/FzWtAYiQ+hTd3dLL
         HYZ05jtBokRrIZO0BvkJ1xLy6agpQ1WObUAjpYTb/KibA9qG/sRNIZemG5+LXwf5h5Ve
         C5XkN+pvhzMx+A5zZwdowo+eYOBAe5FIqCGXwOybDf1dp2aghWGvwmL/es2Xnjur/bVS
         gm8w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1780568288; x=1781173088;
        h=content-transfer-encoding:in-reply-to:content-language:from
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=kF73Sj6shq7pcG8t4VFsQHJ7hu1p/CAQIq9b7qcJi98=;
        b=G5zqMfo6o+Us27Li4z9uuNnT4V1w+ILm4gZ73ndiFT6mpugNESJagq61LDb4wy20R8
         8eQou4SqTOGynIUiBMt8q+YwOo+RaeyCNBNDsRk7CPsY/8e3FuBoLKV/dgVR/GIPoz9i
         L33UYxWhIE/hedX+h8//ywn8RzzX+2nC5yyMEs5JFEbKcygNVoh7L9kewuRUcJbXMrF5
         f0GH37fNwg0xNNDHbbObi1X0rimY7KmMSSXw1eExttNi52jDo5hb2Jb+i6LylLCkon92
         9otMvJbyrUN4Px7rlsmnCNDLWCFSV9rDQOnGzN2dmcMF59KB097s98OMyiqZZ4OXYTeQ
         Uv9Q==
X-Forwarded-Encrypted: i=1; AFNElJ8tnrWARFRwpMrquFFCJZPfsLVYaWBZqB6ZtKrzqg9yDy9KRIaXDkm4qIEc73ufrGyVzaPDLSM=@vger.kernel.org
X-Gm-Message-State: AOJu0YxqmQAiC+65SsBaRBHI4+7nSkN25dF9wLzCsdbzVLX3HlrJya2w
	dpeoak5TsQ78SPMgcDEfo6qoAutgyt3HiNspZgL5aKjWwIa9D8uy+HdA21/IT1VswyXnKDwi1+5
	DZvJO13wWievMnxjo1CKYROTN7ELmvIq2CWSjZoPkKNv76aoR77tCoN1QpMdkpDvmJg==
X-Gm-Gg: Acq92OFn3ByZHHHjb2N/irq4gywoKP3MqTfToMNMUAl3DBP7q6BrWargC+ncyuezeZg
	e3YGVd2LfMCUG4rsHpDfCtGCazA3Rpcb/30p9PwlGI9yerbglp2kwMoy38smXTuLAZjDJBBMtBM
	7FCGqa+yCzF4dN+1wBN6d1xoiNZU6n9ueBByqDmWUd7CqXMCHPEp3jH9RbRRI7PAjWJdiFV0QJW
	ke+1qQvE5jWzNrAJL86zk3Z8IN8QQsj8RGxQS9v4NJ0UkuHcj7JW7+uLn9CVmYQHT18FddwCakX
	bhaUG7Vhqwn2M3InKVWU5b3/byV2LwGN50JO6hMlfBrd87Lj7Gy289zlQ/aNn7TUqRU0NgD1GtT
	g8zpZ0i0fdMVLSFcYDDwdXbTP6Y8WibzhAVtl3dSMnu5Y5Gna6XD2JyGfTbeFT4RuGy8=
X-Received: by 2002:a05:600c:1d09:b0:490:3f7a:108b with SMTP id 5b1f17b1804b1-490b5e51a49mr120275675e9.16.1780568287803;
        Thu, 04 Jun 2026 03:18:07 -0700 (PDT)
X-Received: by 2002:a05:600c:1d09:b0:490:3f7a:108b with SMTP id 5b1f17b1804b1-490b5e51a49mr120275035e9.16.1780568287295;
        Thu, 04 Jun 2026 03:18:07 -0700 (PDT)
Received: from [192.168.88.32] ([212.105.155.59])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-490b79d64e8sm154376175e9.0.2026.06.04.03.18.05
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 04 Jun 2026 03:18:06 -0700 (PDT)
Message-ID: <c5750d8a-5b37-4269-819b-1c3c04be0ddf@redhat.com>
Date: Thu, 4 Jun 2026 12:18:05 +0200
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v17 net-next 05/11] net/nebula-matrix: add channel layer
To: "illusion.wang" <illusion.wang@nebula-matrix.com>,
 dimon.zhao@nebula-matrix.com, alvin.wang@nebula-matrix.com,
 sam.chen@nebula-matrix.com, netdev@vger.kernel.org
Cc: andrew+netdev@lunn.ch, corbet@lwn.net, kuba@kernel.org, horms@kernel.org,
 linux-doc@vger.kernel.org, vadim.fedorenko@linux.dev,
 lukas.bulwahn@redhat.com, edumazet@google.com, enelsonmoore@gmail.com,
 skhan@linuxfoundation.org, hkallweit1@gmail.com,
 open list <linux-kernel@vger.kernel.org>
References: <20260601093149.25905-1-illusion.wang@nebula-matrix.com>
 <20260601093149.25905-6-illusion.wang@nebula-matrix.com>
From: Paolo Abeni <pabeni@redhat.com>
Content-Language: en-US
In-Reply-To: <20260601093149.25905-6-illusion.wang@nebula-matrix.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-0.66 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[redhat.com,quarantine];
	R_DKIM_ALLOW(-0.20)[redhat.com:s=mimecast20190719,redhat.com:s=google];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c09:e001:a7::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FREEMAIL_CC(0.00)[lunn.ch,lwn.net,kernel.org,vger.kernel.org,linux.dev,redhat.com,google.com,gmail.com,linuxfoundation.org];
	TAGGED_FROM(0.00)[bounces-295159-lists,netdev=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FROM_HAS_DN(0.00)[];
	FORGED_SENDER(0.00)[pabeni@redhat.com,netdev@vger.kernel.org];
	MIME_TRACE(0.00)[0:+];
	FORGED_RECIPIENTS(0.00)[m:illusion.wang@nebula-matrix.com,m:dimon.zhao@nebula-matrix.com,m:alvin.wang@nebula-matrix.com,m:sam.chen@nebula-matrix.com,m:netdev@vger.kernel.org,m:andrew+netdev@lunn.ch,m:corbet@lwn.net,m:kuba@kernel.org,m:horms@kernel.org,m:linux-doc@vger.kernel.org,m:vadim.fedorenko@linux.dev,m:lukas.bulwahn@redhat.com,m:edumazet@google.com,m:enelsonmoore@gmail.com,m:skhan@linuxfoundation.org,m:hkallweit1@gmail.com,m:linux-kernel@vger.kernel.org,m:andrew@lunn.ch,s:lists@lfdr.de];
	FORWARDED(0.00)[lists@lfdr.de];
	FORGED_SENDER_MAILLIST(0.00)[];
	DKIM_TRACE(0.00)[redhat.com:+];
	ASN(0.00)[asn:63949, ipnet:2600:3c09::/32, country:SG];
	RCPT_COUNT_TWELVE(0.00)[17];
	FORGED_SENDER_FORWARDING(0.00)[];
	RCVD_COUNT_FIVE(0.00)[6];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[pabeni@redhat.com,netdev@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	ALIAS_RESOLVED(0.00)[];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	MID_RHS_MATCH_FROM(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	TO_DN_SOME(0.00)[]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: C3BFA63EFB2

On 6/1/26 11:31 AM, illusion.wang wrote:
> A channel management layer provides a structured approach to handle
> communication between different components and drivers. Here's a summary
> of its key functionalities:
> 
> 1. Message Handling Framework
>    Message Registration: Functions (nbl_chan_register_msg) allow dynamic
>    registration of message handlers for specific message types, enabling
>    extensible communication protocols.
> 
>    Message Sending/Acknowledgment: Core functions (nbl_chan_send_msg,
>    nbl_chan_send_ack) handle message transmission, including asynchronous
>    operations with acknowledgment (ACK) support. Received ACKs are
>    processed via nbl_chan_recv_ack_msg.
> 
>    Hash-Based Handler Lookup: A hash table (`handle_hash_tbl`) stores
>    message handlers for efficient O(1) lookup by message type. The
>    entire table is removed via `nbl_chan_remove_msg_handler` during
>    driver teardown (per-message-type removal is not implemented
>    in this version).
> 
> 2. Channel Types and Queue Management
>    Mailbox Channel: For direct communication between PF0 and Other PF.
> 
>    Queue Initialization: Functions (nbl_chan_init_queue,
>    nbl_chan_init_tx_queue) allocate resources:
>    - TX descriptors: dmam_alloc_coherent()
>    - RX descriptors: dmam_alloc_coherent()
>    - TX/RX buffer metadata arrays (txq->buf, rxq->buf): devm_kcalloc()
> 
>    Queue Teardown: nbl_chan_teardown_queue() stops queues, cancels
>    pending work items (clean_task), and destroys mutexes. It does NOT
>    free DMA memory, which is released automatically via devm on driver
>    remove.
> 
>    IMPORTANT - Resource Lifecycle Design:
>    DMA memory allocated with dmam_alloc_coherent() is intentionally NOT
>    freed in nbl_chan_teardown_queue(). The queues are allocated once
>    during driver probe and freed only during driver remove (when all
>    devm_ resources are released). This assumes queues are NOT dynamically
>    torn down and recreated per-PF during normal operation.
> 
>    Queue Configuration: Hardware-specific queue parameters (e.g., buffer
>    sizes, entry counts) are set via nbl_chan_config_queue, with hardware
>    interactions delegated to hw_ops.
> 
> 3. Hardware Abstraction Layer (HW Ops)
>    Hardware-Specific Operations: The nbl_hw_ops structure abstracts
>    hardware interactions: queue configuration (config_mailbox_txq/rxq),
>    tail pointer updates (update_mailbox_queue_tail_ptr).
> 
> Signed-off-by: illusion.wang <illusion.wang@nebula-matrix.com>
> ---
>  .../net/ethernet/nebula-matrix/nbl/Makefile   |   3 +-
>  .../nbl/nbl_channel/nbl_channel.c             | 942 +++++++++++++++++-
>  .../nbl/nbl_channel/nbl_channel.h             | 146 +++
>  .../nebula-matrix/nbl/nbl_common/nbl_common.c | 193 ++++
>  .../nebula-matrix/nbl/nbl_common/nbl_common.h |  33 +
>  .../nbl/nbl_hw/nbl_hw_leonis/nbl_hw_leonis.c  | 151 +++
>  .../nebula-matrix/nbl/nbl_hw/nbl_hw_reg.h     |   1 +
>  .../nbl/nbl_include/nbl_def_channel.h         |  84 ++
>  .../nbl/nbl_include/nbl_def_common.h          |  26 +
>  .../nbl/nbl_include/nbl_def_hw.h              |  28 +
>  .../nbl/nbl_include/nbl_include.h             |   6 +
>  11 files changed, 1609 insertions(+), 4 deletions(-)
>  create mode 100644 drivers/net/ethernet/nebula-matrix/nbl/nbl_common/nbl_common.c
>  create mode 100644 drivers/net/ethernet/nebula-matrix/nbl/nbl_common/nbl_common.h
> 
> diff --git a/drivers/net/ethernet/nebula-matrix/nbl/Makefile b/drivers/net/ethernet/nebula-matrix/nbl/Makefile
> index 63116d1d7043..c9bc060732e7 100644
> --- a/drivers/net/ethernet/nebula-matrix/nbl/Makefile
> +++ b/drivers/net/ethernet/nebula-matrix/nbl/Makefile
> @@ -3,7 +3,8 @@
>  
>  obj-$(CONFIG_NBL) := nbl.o
>  
> -nbl-objs +=       nbl_channel/nbl_channel.o \
> +nbl-objs +=       nbl_common/nbl_common.o \
> +				nbl_channel/nbl_channel.o \
>  				nbl_hw/nbl_hw_leonis/nbl_hw_leonis.o \
>  				nbl_hw/nbl_hw_leonis/nbl_resource_leonis.o \
>  				nbl_hw/nbl_hw_leonis/nbl_hw_leonis_regs.o \
> diff --git a/drivers/net/ethernet/nebula-matrix/nbl/nbl_channel/nbl_channel.c b/drivers/net/ethernet/nebula-matrix/nbl/nbl_channel/nbl_channel.c
> index c7689f0e4029..b44dfc8c3eee 100644
> --- a/drivers/net/ethernet/nebula-matrix/nbl/nbl_channel/nbl_channel.c
> +++ b/drivers/net/ethernet/nebula-matrix/nbl/nbl_channel/nbl_channel.c
> @@ -2,12 +2,912 @@
>  /*
>   * Copyright (c) 2025 Nebula Matrix Limited.
>   */
> -
> +#include <linux/delay.h>
>  #include <linux/device.h>
>  #include <linux/pci.h>
> +#include <linux/bits.h>
> +#include <linux/dma-mapping.h>
>  #include "nbl_channel.h"
>  
> +static int nbl_chan_add_msg_handler(struct nbl_channel_mgt *chan_mgt,
> +				    u16 msg_type, nbl_chan_resp func,
> +				    void *priv)
> +{
> +	struct nbl_chan_msg_node_data handler = { 0 };
> +	int ret;
> +
> +	handler.func = func;
> +	handler.priv = priv;
> +	ret = nbl_common_alloc_hash_node(chan_mgt->handle_hash_tbl, &msg_type,
> +					 &handler, NULL);
> +
> +	return ret;
> +}
> +
> +static int nbl_chan_init_msg_handler(struct nbl_channel_mgt *chan_mgt)
> +{
> +	struct nbl_common_info *common = chan_mgt->common;
> +	struct nbl_hash_tbl_key tbl_key = {0};
> +
> +	tbl_key.dev = common->dev;
> +	tbl_key.key_size = sizeof(u16);
> +	tbl_key.data_size = sizeof(struct nbl_chan_msg_node_data);
> +	tbl_key.bucket_size = NBL_CHAN_HANDLER_TBL_BUCKET_SIZE;
> +
> +	chan_mgt->handle_hash_tbl = nbl_common_init_hash_table(&tbl_key);
> +	if (!chan_mgt->handle_hash_tbl)
> +		return -ENOMEM;
> +
> +	return 0;
> +}
> +
> +static void nbl_chan_remove_msg_handler(struct nbl_channel_mgt *chan_mgt)
> +{
> +	nbl_common_remove_hash_table(chan_mgt->handle_hash_tbl, NULL);
> +
> +	chan_mgt->handle_hash_tbl = NULL;
> +}
> +
> +static void nbl_chan_init_queue_param(struct nbl_chan_info *chan_info,
> +				      u16 num_txq_entries, u16 num_rxq_entries,
> +				      u16 txq_buf_size, u16 rxq_buf_size)
> +{
> +	mutex_init(&chan_info->txq_lock);
> +	mutex_init(&chan_info->rxq_lock);
> +	chan_info->num_txq_entries = num_txq_entries;
> +	chan_info->num_rxq_entries = num_rxq_entries;
> +	chan_info->txq_buf_size = txq_buf_size;
> +	chan_info->rxq_buf_size = rxq_buf_size;
> +}
> +
> +static int nbl_chan_init_tx_queue(struct nbl_common_info *common,
> +				  struct nbl_chan_info *chan_info)
> +{
> +	struct nbl_chan_ring *txq = &chan_info->txq;
> +	struct device *dev = common->dev;
> +	size_t size =
> +		chan_info->num_txq_entries * sizeof(struct nbl_chan_tx_desc);
> +	int i;
> +
> +	txq->desc.tx_desc = dmam_alloc_coherent(dev, size, &txq->dma,
> +						GFP_KERNEL);
> +	if (!txq->desc.tx_desc)
> +		return -ENOMEM;
> +
> +	chan_info->wait = devm_kcalloc(dev, chan_info->num_txq_entries,
> +				       sizeof(*chan_info->wait),
> +				       GFP_KERNEL);
> +	if (!chan_info->wait)
> +		return -ENOMEM;
> +	for (i = 0; i < chan_info->num_txq_entries; i++) {
> +		init_waitqueue_head(&chan_info->wait[i].wait_queue);
> +		atomic_set(&chan_info->wait[i].status, NBL_MBX_STATUS_IDLE);
> +	}
> +
> +	txq->buf = devm_kcalloc(dev, chan_info->num_txq_entries,
> +				sizeof(*txq->buf), GFP_KERNEL);
> +	if (!txq->buf)
> +		return -ENOMEM;
> +
> +	return 0;
> +}
> +
> +static int nbl_chan_init_rx_queue(struct nbl_common_info *common,
> +				  struct nbl_chan_info *chan_info)
> +{
> +	struct nbl_chan_ring *rxq = &chan_info->rxq;
> +	struct device *dev = common->dev;
> +	size_t size =
> +		chan_info->num_rxq_entries * sizeof(struct nbl_chan_rx_desc);
> +
> +	rxq->desc.rx_desc = dmam_alloc_coherent(dev, size, &rxq->dma,
> +						GFP_KERNEL);
> +	if (!rxq->desc.rx_desc) {
> +		dev_err(dev,
> +			"Allocate DMA for chan rx descriptor ring failed\n");
> +		return -ENOMEM;
> +	}
> +
> +	rxq->buf = devm_kcalloc(dev, chan_info->num_rxq_entries,
> +				sizeof(*rxq->buf), GFP_KERNEL);
> +	if (!rxq->buf)
> +		return -ENOMEM;
> +
> +	return 0;
> +}
> +
> +static int nbl_chan_init_queue(struct nbl_common_info *common,
> +			       struct nbl_chan_info *chan_info)
> +{
> +	int err;
> +
> +	err = nbl_chan_init_tx_queue(common, chan_info);
> +	if (err)
> +		return err;
> +
> +	err = nbl_chan_init_rx_queue(common, chan_info);
> +
> +	return err;
> +}
> +
> +static void nbl_chan_config_queue(struct nbl_channel_mgt *chan_mgt,
> +				  struct nbl_chan_info *chan_info, bool tx)
> +{
> +	struct nbl_hw_ops *hw_ops = chan_mgt->hw_ops_tbl->ops;
> +	struct nbl_hw_mgt *p = chan_mgt->hw_ops_tbl->priv;
> +	int size_bwid;
> +	struct nbl_chan_ring *ring;
> +	dma_addr_t dma_addr;
> +
> +	if (tx)
> +		ring = &chan_info->txq;
> +	else
> +		ring = &chan_info->rxq;
> +	dma_addr = ring->dma;
> +	if (tx) {
> +		size_bwid = ilog2(chan_info->num_txq_entries);
> +		hw_ops->config_mailbox_txq(p, dma_addr, size_bwid);
> +	} else {
> +		size_bwid = ilog2(chan_info->num_rxq_entries);
> +		hw_ops->config_mailbox_rxq(p, dma_addr, size_bwid);
> +	}
> +}
> +
> +static int nbl_chan_alloc_all_tx_bufs(struct nbl_channel_mgt *chan_mgt,
> +				      struct nbl_chan_info *chan_info)
> +{
> +	struct nbl_chan_ring *txq = &chan_info->txq;
> +	struct device *dev = chan_mgt->common->dev;
> +	struct nbl_chan_buf *buf;
> +	u16 i;
> +
> +	for (i = 0; i < chan_info->num_txq_entries; i++) {
> +		buf = &txq->buf[i];
> +		buf->va = dmam_alloc_coherent(dev, chan_info->txq_buf_size,
> +					      &buf->pa,
> +					      GFP_KERNEL);
> +		if (!buf->va) {
> +			dev_err(dev,
> +				"Allocate buffer for chan tx queue failed\n");
> +			return -ENOMEM;
> +		}
> +	}
> +
> +	txq->next_to_clean = 0;
> +	txq->next_to_use = 0;
> +	txq->tail_ptr = 0;
> +
> +	return 0;
> +}
> +
> +static void nbl_chan_cfg_qinfo_map_table(struct nbl_channel_mgt *chan_mgt)
> +{
> +	struct nbl_hw_ops *hw_ops = chan_mgt->hw_ops_tbl->ops;
> +	struct nbl_common_info *common = chan_mgt->common;
> +	struct nbl_hw_mgt *p = chan_mgt->hw_ops_tbl->priv;
> +	u8 func_id;
> +	u32 pf_mask;
> +
> +	pf_mask = hw_ops->get_host_pf_mask(p);
> +	for (func_id = 0; func_id < NBL_MAX_PF; func_id++) {
> +		if (!(pf_mask & (1 << func_id)))
> +			hw_ops->cfg_mailbox_qinfo(p, func_id, common->hw_bus,
> +						  common->devid,
> +						  common->function + func_id);
> +	}
> +}
> +
> +#define NBL_UPDATE_QUEUE_TAIL_PTR(chan_info, hw_ops, chan_mgt, tail_ptr, qid)\
> +do {									\
> +	(void)(chan_info);						\
> +	typeof(hw_ops) _hw_ops = (hw_ops);				\
> +	typeof(chan_mgt) _chan_mgt = (chan_mgt);			\
> +	typeof(tail_ptr) _tail_ptr = (tail_ptr);			\
> +	typeof(qid) _qid = (qid);					\
> +	(_hw_ops)->update_mailbox_queue_tail_ptr(			\
> +		_chan_mgt->hw_ops_tbl->priv, _tail_ptr, _qid);	\
> +} while (0)
> +
> +static int nbl_chan_alloc_all_rx_bufs(struct nbl_channel_mgt *chan_mgt,
> +				      struct nbl_chan_info *chan_info)
> +{
> +	struct nbl_hw_ops *hw_ops = chan_mgt->hw_ops_tbl->ops;
> +	struct nbl_chan_ring *rxq = &chan_info->rxq;
> +	struct device *dev = chan_mgt->common->dev;
> +	struct nbl_chan_rx_desc *desc;
> +	struct nbl_chan_buf *buf;
> +	u16 i;
> +
> +	for (i = 0; i < chan_info->num_rxq_entries; i++) {
> +		buf = &rxq->buf[i];
> +		buf->va = dmam_alloc_coherent(dev, chan_info->rxq_buf_size,
> +					      &buf->pa,
> +					      GFP_KERNEL);
> +		if (!buf->va) {
> +			dev_err(dev,
> +				"Allocate buffer for chan rx queue failed\n");
> +			goto err;
> +		}
> +	}
> +
> +	desc = rxq->desc.rx_desc;
> +	for (i = 0; i < chan_info->num_rxq_entries - 1; i++) {
> +		buf = &rxq->buf[i];
> +		desc[i].buf_addr = cpu_to_le64(buf->pa);
> +		desc[i].buf_len = cpu_to_le32(chan_info->rxq_buf_size);
> +		desc[i].flags = cpu_to_le16(BIT(NBL_CHAN_RX_DESC_AVAIL));
> +	}
> +
> +	rxq->next_to_clean = 0;
> +	rxq->next_to_use = chan_info->num_rxq_entries - 1;
> +	rxq->tail_ptr = chan_info->num_rxq_entries - 1;
> +
> +	NBL_UPDATE_QUEUE_TAIL_PTR(chan_info, hw_ops, chan_mgt, rxq->tail_ptr,
> +				  NBL_MB_RX_QID);
> +
> +	return 0;
> +err:
> +	return -ENOMEM;
> +}
> +
> +static int nbl_chan_alloc_all_bufs(struct nbl_channel_mgt *chan_mgt,
> +				   struct nbl_chan_info *chan_info)
> +{
> +	int err;
> +
> +	err = nbl_chan_alloc_all_tx_bufs(chan_mgt, chan_info);
> +	if (err)
> +		return err;
> +	err = nbl_chan_alloc_all_rx_bufs(chan_mgt, chan_info);
> +
> +	return err;
> +}
> +
> +static void nbl_chan_stop_queue(struct nbl_channel_mgt *chan_mgt)
> +{
> +	struct nbl_hw_ops *hw_ops = chan_mgt->hw_ops_tbl->ops;
> +
> +	hw_ops->stop_mailbox_rxq(chan_mgt->hw_ops_tbl->priv);
> +	hw_ops->stop_mailbox_txq(chan_mgt->hw_ops_tbl->priv);
> +}
> +
> +static int nbl_chan_teardown_queue(struct nbl_channel_mgt *chan_mgt,
> +				   u8 chan_type)
> +{
> +	struct nbl_chan_info *chan_info = chan_mgt->chan_info[chan_type];
> +
> +	nbl_chan_stop_queue(chan_mgt);
> +	if (chan_info->clean_task)
> +		cancel_work_sync(chan_info->clean_task);
> +	/*
> +	 * Lock and unlock to wait for any in-flight callers that may still
> +	 * be holding the lock. After unlock returns, we are guaranteed that
> +	 * no other thread is using this lock, so it's safe to destroy.
> +	 */
> +	mutex_lock(&chan_info->txq_lock);
> +	mutex_unlock(&chan_info->txq_lock);
> +	mutex_destroy(&chan_info->txq_lock);
> +
> +	mutex_lock(&chan_info->rxq_lock);
> +	mutex_unlock(&chan_info->rxq_lock);
> +	mutex_destroy(&chan_info->rxq_lock);
> +
> +	return 0;
> +}
> +
> +static int nbl_chan_setup_queue(struct nbl_channel_mgt *chan_mgt, u8 chan_type)
> +{
> +	struct nbl_chan_info *chan_info = chan_mgt->chan_info[chan_type];
> +	struct nbl_common_info *common = chan_mgt->common;
> +	int err;
> +
> +	nbl_chan_init_queue_param(chan_info, NBL_CHAN_QUEUE_LEN,
> +				  NBL_CHAN_QUEUE_LEN, NBL_CHAN_BUF_LEN,
> +				  NBL_CHAN_BUF_LEN);
> +	err = nbl_chan_init_queue(common, chan_info);
> +	if (err)
> +		return err;
> +
> +	nbl_chan_config_queue(chan_mgt, chan_info, true); /* tx */
> +	nbl_chan_config_queue(chan_mgt, chan_info, false); /* rx */
> +
> +	err = nbl_chan_alloc_all_bufs(chan_mgt, chan_info);
> +	if (err)
> +		goto chan_q_setup_fail;
> +
> +	return 0;
> +
> +chan_q_setup_fail:
> +	mutex_destroy(&chan_info->txq_lock);
> +	mutex_destroy(&chan_info->rxq_lock);
> +	return err;
> +}
> +
> +static int nbl_chan_update_txqueue(struct nbl_channel_mgt *chan_mgt,
> +				   struct nbl_chan_info *chan_info,
> +				   struct nbl_chan_tx_param *param)
> +{
> +	struct nbl_chan_ring *txq = &chan_info->txq;
> +	struct nbl_chan_tx_desc *tx_desc =
> +		NBL_CHAN_TX_RING_TO_DESC(txq, txq->next_to_use);
> +	struct nbl_chan_buf *tx_buf =
> +		NBL_CHAN_TX_RING_TO_BUF(txq, txq->next_to_use);
> +
> +	if (param->arg_len > NBL_CHAN_BUF_LEN - sizeof(*tx_desc))
> +		return -EINVAL;
> +
> +	tx_desc->dstid = cpu_to_le16(param->dstid);
> +	tx_desc->msg_type = cpu_to_le16(param->msg_type);
> +	tx_desc->msgid = cpu_to_le16(param->msgid);
> +
> +	if (param->arg_len > NBL_CHAN_TX_DESC_EMBEDDED_DATA_LEN) {
> +		memcpy(tx_buf->va, param->arg, param->arg_len);
> +		tx_desc->buf_addr = cpu_to_le64(tx_buf->pa);
> +		tx_desc->buf_len = cpu_to_le16(param->arg_len);
> +		tx_desc->data_len = 0;
> +		memset(tx_desc->data, 0, sizeof(tx_desc->data));
> +	} else {
> +		memset(tx_desc->data, 0, sizeof(tx_desc->data));
> +		memcpy(tx_desc->data, param->arg, param->arg_len);
> +		tx_desc->buf_len = 0;
> +		tx_desc->data_len = cpu_to_le16(param->arg_len);
> +	}
> +	/* Ensure desc body is visible to DMA before writing AVAIL flag */
> +	dma_wmb();
> +	tx_desc->flags = cpu_to_le16(BIT(NBL_CHAN_TX_DESC_AVAIL));
> +
> +	txq->next_to_use =
> +		NBL_NEXT_ID(txq->next_to_use, chan_info->num_txq_entries - 1);
> +	txq->tail_ptr++;
> +
> +	return 0;
> +}
> +
> +static int nbl_chan_kick_tx_ring(struct nbl_channel_mgt *chan_mgt,
> +				 struct nbl_chan_info *chan_info)
> +{
> +	struct nbl_hw_ops *hw_ops = chan_mgt->hw_ops_tbl->ops;
> +	struct nbl_chan_ring *txq = &chan_info->txq;
> +	struct device *dev = chan_mgt->common->dev;
> +	int max_retries = NBL_CHAN_TX_WAIT_TIMES;
> +	struct nbl_chan_tx_desc *tx_desc;
> +	int retry_count = 0;
> +
> +	NBL_UPDATE_QUEUE_TAIL_PTR(chan_info, hw_ops, chan_mgt, txq->tail_ptr,
> +				  NBL_MB_TX_QID);
> +
> +	tx_desc = NBL_CHAN_TX_RING_TO_DESC(txq, txq->next_to_clean);
> +	while (retry_count < max_retries) {
> +		if (le16_to_cpu(READ_ONCE(tx_desc->flags)) &
> +		    BIT(NBL_CHAN_TX_DESC_USED)) {
> +			dma_rmb();
> +			break;
> +		}
> +
> +		if (!(retry_count % NBL_CHAN_TX_REKICK_WAIT_TIMES))
> +			NBL_UPDATE_QUEUE_TAIL_PTR(chan_info, hw_ops, chan_mgt,
> +						  txq->tail_ptr, NBL_MB_TX_QID);
> +		retry_count++;
> +
> +		usleep_range(NBL_CHAN_TX_WAIT_US, NBL_CHAN_TX_WAIT_US_MAX);
> +	}
> +
> +	txq->next_to_clean = txq->next_to_use;
> +	if (retry_count >= max_retries) {
> +		dev_err(dev, "chan send message type: %d timeout\n",
> +			le16_to_cpu(READ_ONCE(tx_desc->msg_type)));
> +		return -ETIMEDOUT;
> +	}
> +
> +	return 0;
> +}
> +
> +static void nbl_chan_recv_ack_msg(void *priv, u16 srcid, u16 msgid, void *data,
> +				  u32 data_len)
> +{
> +	struct nbl_channel_mgt *chan_mgt = (struct nbl_channel_mgt *)priv;
> +	struct nbl_chan_waitqueue_head *wait_head = NULL;
> +	union nbl_chan_msg_id ack_msgid = { { 0 } };
> +	struct device *dev = chan_mgt->common->dev;
> +	struct nbl_chan_info *chan_info =
> +		chan_mgt->chan_info[NBL_CHAN_TYPE_MAILBOX];
> +	u32 *payload = data;
> +	u32 ack_datalen, ack_msgtype = 0;
> +	u32 copy_len;
> +
> +	if (data_len > NBL_CHAN_BUF_LEN ||
> +	    data_len < NBL_CHAN_ACK_HEAD_LEN * sizeof(u32)) {
> +		dev_err(dev, "Invalid ACK data_len: %u\n", data_len);
> +		return;
> +	}
> +	ack_datalen = data_len - NBL_CHAN_ACK_HEAD_LEN * sizeof(u32);
> +	ack_msgtype = le16_to_cpu(*(__le16 *)(payload + NBL_CHAN_MSG_TYPE_POS));
> +	ack_msgid.id = le16_to_cpu(*(__le16 *)(payload + NBL_CHAN_MSG_ID_POS));
> +	if (ack_msgid.info.loc >= NBL_CHAN_QUEUE_LEN) {
> +		dev_err(dev, "chan recv msg loc: %d err\n", ack_msgid.info.loc);
> +		return;
> +	}
> +	wait_head = &chan_info->wait[ack_msgid.info.loc];
> +	if (srcid != wait_head->dstid) {
> +		atomic_set(&wait_head->status, NBL_MBX_STATUS_IDLE);
> +		dev_err(dev, "ACK srcid=%u != dstid=%u, rejecting\n",
> +			srcid, wait_head->dstid);
> +		return;
> +	}
> +	if (!atomic_cmpxchg_acquire(&wait_head->status, NBL_MBX_STATUS_WAITING,
> +				    NBL_MBX_STATUS_ACKD)) {
> +		dev_err(dev, "Skip ack with invalid status, wait_head msgtype:%u msg_index:%u status:%d ack_data_len:%d, ack msgtype:%u msgid:%u datalen:%d\n",
> +			wait_head->msg_type, wait_head->msg_index,
> +			atomic_read(&wait_head->status),
> +			wait_head->ack_data_len, ack_msgtype,
> +			ack_msgid.id, ack_datalen);
> +		return;
> +	}

Sashiko reports a number of issues WRT the atomic status updates:

https://netdev-ai.bots.linux.dev/sashiko/#/patchset/20260601093149.25905-1-illusion.wang%40nebula-matrix.com

It's indeed quite complex to get things right this way. I'm wondering if 
you should use a spin_lock instead to protect the relevant state?

Also a few process related notes:
- to make effective progresses you should proactively reply on the ML WRT
the sashiko comments discussion if and why they are (not) relevant.
- is 'illusion wang' (all lower case) your real name? we can't accept
pseudonims as SoB tag.

/P


