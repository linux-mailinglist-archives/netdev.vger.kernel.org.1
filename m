Return-Path: <netdev+bounces-306084-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id UIcPKE9XT2oMewIAu9opvQ
	(envelope-from <netdev+bounces-306084-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Thu, 09 Jul 2026 10:09:51 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 0C2BF72E126
	for <lists+netdev@lfdr.de>; Thu, 09 Jul 2026 10:09:51 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=redhat.com header.s=mimecast20190719 header.b=Xa7xb0IW;
	dkim=pass header.d=redhat.com header.s=google header.b="l/9DfQSC";
	dmarc=pass (policy=quarantine) header.from=redhat.com;
	spf=pass (mail.lfdr.de: domain of "netdev+bounces-306084-lists+netdev=lfdr.de@vger.kernel.org" designates 2600:3c04:e001:36c::12fc:5321 as permitted sender) smtp.mailfrom="netdev+bounces-306084-lists+netdev=lfdr.de@vger.kernel.org";
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id C69D43004277
	for <lists+netdev@lfdr.de>; Thu,  9 Jul 2026 08:09:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 862F63DFC8F;
	Thu,  9 Jul 2026 08:09:48 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4687B3E6388
	for <netdev@vger.kernel.org>; Thu,  9 Jul 2026 08:09:44 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783584587; cv=none; b=I3nPHxNFwh57msyMTwmlSClsdcKuJ4alt7Xj0CqYiTCr+xprEGFU4C3syly7QiPn6PBev+hXkIkFyYiKQt79TxMOq7ob6Ox5rrDRvCSaM+YK1xxjl6f2cvF3egknDEZd44wqk5wcW/uaB3lidLUrOy9g6LvZNa0DnZx1z4V/SQU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783584587; c=relaxed/simple;
	bh=kIieb1RJGfzjQX1HUNi66dUwAj4pw+RwH3WmjNE0BWc=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=I/K9bDRdbqCsFD3ml9O5F0+Bwi38CJ2SF3xcW+keiIzFrJBERLWXz0vBkU/4FFthwGs8I3b6EmyuTf3rGj1hzVQV+aNWlywiL6Yl5dIAgy3CCF1Vj21pF+3eSokFcqkeoXuSkHPjf2pAMQU+9COF6RSgsAdHq4lA6WsTSkFORMc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=Xa7xb0IW; dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b=l/9DfQSC; arc=none smtp.client-ip=170.10.133.124
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1783584583;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=cxIaab+P2wU9F5kup0v0WeQD0IGCT9hrmMTL/bMy2nA=;
	b=Xa7xb0IWLwJXYK84Froep7xPyLfqrzpxjGiA79LgFrTo4zQyqHbhtLkT5GHdeySe1rXeHk
	uFR7TuSJvqQx8ekZVRsB+qJmI+RSWeDCEAH1CNwhF6zE9MgZwlSQk1jrrAKEho/jSBqIB7
	G6a1C46bdEaiHAe6/YaYR+LOiq7/7RU=
Received: from mail-wm1-f69.google.com (mail-wm1-f69.google.com
 [209.85.128.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-674-7GPV7gepPaeW3lMX0NU6SA-1; Thu, 09 Jul 2026 04:09:41 -0400
X-MC-Unique: 7GPV7gepPaeW3lMX0NU6SA-1
X-Mimecast-MFC-AGG-ID: 7GPV7gepPaeW3lMX0NU6SA_1783584581
Received: by mail-wm1-f69.google.com with SMTP id 5b1f17b1804b1-493bc2b376fso13592965e9.3
        for <netdev@vger.kernel.org>; Thu, 09 Jul 2026 01:09:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=redhat.com; s=google; t=1783584581; x=1784189381; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:in-reply-to:content-language
         :from:references:cc:to:subject:user-agent:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=cxIaab+P2wU9F5kup0v0WeQD0IGCT9hrmMTL/bMy2nA=;
        b=l/9DfQSCodU5kzgxEsjSkVNwLp3zDlojbiO3vbVD0eS4+E296E3eUS5p93WDRe2LkV
         T8Z10OMFbJtrYIcSa1/fJxkOrsof5bTsmdwkPQY5zE9DxjwcUHei43Hvp0hBqclKL7i7
         DGX2vsnmNJz1ltM2adts+y9vlVeGCXWk+bYE0cORG18au+Db/U6mfxM7C3pLmzgyyIXV
         cKkXI+GpqrmxsEN9WrCzdV/mzCHlKZE/tVmdtFI7oAjTx9r7ULTP0G3V03nfUWkH10yL
         L/0EBAwnCipb0gth0kXsnAjd2kzcLHDc97HkOZsfIMMYH6Chrp0g3qup++W/MOSUFNwE
         Pdhw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1783584581; x=1784189381;
        h=content-transfer-encoding:content-type:in-reply-to:content-language
         :from:references:cc:to:subject:user-agent:mime-version:date
         :message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=cxIaab+P2wU9F5kup0v0WeQD0IGCT9hrmMTL/bMy2nA=;
        b=Efzuo6J6HebXfKHKDqIt2HBVPJ8PZWNvPU8IMfOinJBVejl+PApVBMFWKRv4WiWs8q
         J2vsUmAE5PidRkiyx6mPZEBeoRJOzrRTJa9MxRsol6Brhlhy8iZ1dLl+9rHhE0As05BV
         BBGJyI2J6MzyJgTjudE4L1r4fyavwN4vgaeBd0alsRRU4nNZeOMZGpZvPTQ4GNbB5Lox
         6dg/6Zn6CB4vXjxuAE+oW9UgO9C97QAypqDoYSMteYSULhnIXhcFTyXIWbpWPpeix4io
         lCpuCVDRLy4UL+xUv++Rc1Ic9vh937pgYwvhjWOYggY7z+QDbkWDJHgn5BPl3sUH5S5A
         9Pgw==
X-Forwarded-Encrypted: i=1; AHgh+RrYVqDVvphFcT6CcG9wCRsKvupExbiqfZzRT7mG+ow1y0IQQqjxLiiUeU/J354s4+llhJet4bs=@vger.kernel.org
X-Gm-Message-State: AOJu0YyB7OB88alcE0tyCg8I6Ji1M/R2Nf3P6PzXfbUBwtncESjCUQ7q
	1D9YXqzUr38HB/90Hw3M9pGoXL9Y/vLiiHCTT4aubxcJK6CKmicGh9lMxOJ/AfaAg5oXozd6Doi
	tabCqEMsc7EbY1iZ211VzPv3pNNkfX/e+9Ydpdc4/Zgs+/EVfe2GJOB9RTA==
X-Gm-Gg: AfdE7clMx+L+HS5W5kW6YZM667QLCkMnEAMoi6k7TntL3Rx33B9uM/Iq8jiHKF5ECRs
	976bISf8avc4VuUOZBCa5XDmj0Zxfqs+YNaINgqh+P1o0zuAtd0E3OeOUpPok7sZg880nu+svF1
	/rg1JDiTknHp7207S7BpSjRrNgfF5+jHzoPYTOv63rL9igfaA9KftgEO0tU0AZKFZPm1RDsV/PS
	pt1VH+l232BzTzdjllhm6JOMvIed2hzwxmW5eVlnCTvcByyK9xk8NgJ4T8I6Fc9NvlyZpDEJ2IH
	9VjcSigGOvtzD2BiycFASR0kkb6a4TpjWmzMDPsh1wf4ceM9Vl7z2GAu/+KbUv6pIwf5qB3MU55
	vWbJBxOxID4sZW1ou2FsHVlH+gw6VJG2AwvMp6bl1RdYk6RQN2jArqiodP6Kf4q8z68PNxg05MK
	0XZatBR+mmcQK+
X-Received: by 2002:a05:600c:c4b7:b0:490:d38c:7836 with SMTP id 5b1f17b1804b1-493e6892febmr59732975e9.3.1783584580394;
        Thu, 09 Jul 2026 01:09:40 -0700 (PDT)
X-Received: by 2002:a05:600c:c4b7:b0:490:d38c:7836 with SMTP id 5b1f17b1804b1-493e6892febmr59732335e9.3.1783584579738;
        Thu, 09 Jul 2026 01:09:39 -0700 (PDT)
Received: from ?IPV6:2a0d:3344:5521:6b10:58fd:68f:7756:389d? ([2a0d:3344:5521:6b10:58fd:68f:7756:389d])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-493eb6d5055sm44273305e9.5.2026.07.09.01.09.37
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 09 Jul 2026 01:09:38 -0700 (PDT)
Message-ID: <698d9e2d-70e0-40e7-9398-e39ea681245a@redhat.com>
Date: Thu, 9 Jul 2026 10:09:37 +0200
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v21 net-next 04/12] net/nebula-matrix: add channel layer
To: "illusion.wang" <illusion.wang@nebula-matrix.com>,
 dimon.zhao@nebula-matrix.com, alvin.wang@nebula-matrix.com,
 sam.chen@nebula-matrix.com, netdev@vger.kernel.org
Cc: andrew+netdev@lunn.ch, corbet@lwn.net, kuba@kernel.org, horms@kernel.org,
 linux-doc@vger.kernel.org, vadim.fedorenko@linux.dev,
 lukas.bulwahn@redhat.com, edumazet@google.com, enelsonmoore@gmail.com,
 skhan@linuxfoundation.org, hkallweit1@gmail.com,
 open list <linux-kernel@vger.kernel.org>
References: <20260708064742.35391-1-illusion.wang@nebula-matrix.com>
 <20260708064742.35391-5-illusion.wang@nebula-matrix.com>
From: Paolo Abeni <pabeni@redhat.com>
Content-Language: en-US
In-Reply-To: <20260708064742.35391-5-illusion.wang@nebula-matrix.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-0.66 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[redhat.com,quarantine];
	R_DKIM_ALLOW(-0.20)[redhat.com:s=mimecast20190719,redhat.com:s=google];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c04:e001:36c::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FREEMAIL_CC(0.00)[lunn.ch,lwn.net,kernel.org,vger.kernel.org,linux.dev,redhat.com,google.com,gmail.com,linuxfoundation.org];
	TAGGED_FROM(0.00)[bounces-306084-lists,netdev=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FROM_HAS_DN(0.00)[];
	FORGED_SENDER(0.00)[pabeni@redhat.com,netdev@vger.kernel.org];
	MIME_TRACE(0.00)[0:+];
	FORGED_RECIPIENTS(0.00)[m:illusion.wang@nebula-matrix.com,m:dimon.zhao@nebula-matrix.com,m:alvin.wang@nebula-matrix.com,m:sam.chen@nebula-matrix.com,m:netdev@vger.kernel.org,m:andrew+netdev@lunn.ch,m:corbet@lwn.net,m:kuba@kernel.org,m:horms@kernel.org,m:linux-doc@vger.kernel.org,m:vadim.fedorenko@linux.dev,m:lukas.bulwahn@redhat.com,m:edumazet@google.com,m:enelsonmoore@gmail.com,m:skhan@linuxfoundation.org,m:hkallweit1@gmail.com,m:linux-kernel@vger.kernel.org,m:andrew@lunn.ch,s:lists@lfdr.de];
	FORWARDED(0.00)[lists@lfdr.de];
	FORGED_SENDER_MAILLIST(0.00)[];
	DKIM_TRACE(0.00)[redhat.com:+];
	ASN(0.00)[asn:63949, ipnet:2600:3c04::/32, country:SG];
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
X-Rspamd-Queue-Id: 0C2BF72E126

On 7/8/26 8:47 AM, illusion.wang wrote:
> From: illusion wang <illusion.wang@nebula-matrix.com>
> 
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
> Signed-off-by: illusion wang <illusion.wang@nebula-matrix.com>
> ---
>  .../net/ethernet/nebula-matrix/nbl/Makefile   |    4 +-
>  .../nbl/nbl_channel/nbl_channel.c             | 1094 +++++++++++++++++
>  .../nbl/nbl_channel/nbl_channel.h             |  168 +++
>  .../nebula-matrix/nbl/nbl_common/nbl_common.c |  172 +++
>  .../nebula-matrix/nbl/nbl_common/nbl_common.h |   33 +
>  .../net/ethernet/nebula-matrix/nbl/nbl_core.h |   11 +
>  .../nbl/nbl_hw/nbl_hw_leonis/nbl_hw_leonis.c  |  173 +++
>  .../nbl/nbl_hw/nbl_hw_leonis/nbl_hw_leonis.h  |   56 +
>  .../nebula-matrix/nbl/nbl_hw/nbl_hw_reg.h     |   45 +
>  .../nbl/nbl_include/nbl_def_channel.h         |  113 ++
>  .../nbl/nbl_include/nbl_def_common.h          |   17 +
>  .../nbl/nbl_include/nbl_def_hw.h              |   15 +
>  .../nbl/nbl_include/nbl_include.h             |    6 +
>  .../net/ethernet/nebula-matrix/nbl/nbl_main.c |    7 +
>  14 files changed, 1913 insertions(+), 1 deletion(-)
>  create mode 100644 drivers/net/ethernet/nebula-matrix/nbl/nbl_channel/nbl_channel.c
>  create mode 100644 drivers/net/ethernet/nebula-matrix/nbl/nbl_channel/nbl_channel.h
>  create mode 100644 drivers/net/ethernet/nebula-matrix/nbl/nbl_common/nbl_common.c
>  create mode 100644 drivers/net/ethernet/nebula-matrix/nbl/nbl_common/nbl_common.h
> 
> diff --git a/drivers/net/ethernet/nebula-matrix/nbl/Makefile b/drivers/net/ethernet/nebula-matrix/nbl/Makefile
> index caa863d3a582..6dc1539cee1f 100644
> --- a/drivers/net/ethernet/nebula-matrix/nbl/Makefile
> +++ b/drivers/net/ethernet/nebula-matrix/nbl/Makefile
> @@ -3,5 +3,7 @@
>  
>  obj-$(CONFIG_NBL) := nbl.o
>  
> -nbl-objs +=       nbl_hw/nbl_hw_leonis/nbl_hw_leonis.o \
> +nbl-objs +=       nbl_common/nbl_common.o \
> +				nbl_channel/nbl_channel.o \
> +				nbl_hw/nbl_hw_leonis/nbl_hw_leonis.o \
>  				nbl_main.o
> diff --git a/drivers/net/ethernet/nebula-matrix/nbl/nbl_channel/nbl_channel.c b/drivers/net/ethernet/nebula-matrix/nbl/nbl_channel/nbl_channel.c
> new file mode 100644
> index 000000000000..220c740f68b9
> --- /dev/null
> +++ b/drivers/net/ethernet/nebula-matrix/nbl/nbl_channel/nbl_channel.c
> @@ -0,0 +1,1094 @@
> +// SPDX-License-Identifier: GPL-2.0
> +/*
> + * Copyright (c) 2025 Nebula Matrix Limited.
> + */
> +#include <linux/delay.h>
> +#include <linux/device.h>
> +#include <linux/bitfield.h>
> +#include <linux/pci.h>
> +#include <linux/bits.h>
> +#include <linux/dma-mapping.h>
> +#include <linux/atomic.h>
> +#include <linux/wait.h>
> +#include "nbl_channel.h"
> +
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
> +	struct nbl_hash_tbl_key tbl_key = { 0 };
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
> +	if (!chan_mgt->handle_hash_tbl)
> +		return;
> +	nbl_common_remove_hash_table(chan_mgt->handle_hash_tbl);
> +	chan_mgt->handle_hash_tbl = NULL;
> +}
> +
> +static void nbl_chan_init_queue_param(struct nbl_chan_info *chan_info,
> +				      u16 num_txq_entries, u16 num_rxq_entries,
> +				      u16 txq_buf_size, u16 rxq_buf_size)
> +{
> +	mutex_init(&chan_info->txq_lock);
> +	chan_info->num_txq_entries = num_txq_entries;
> +	chan_info->num_rxq_entries = num_rxq_entries;
> +	chan_info->txq_buf_size = txq_buf_size;
> +	chan_info->rxq_buf_size = rxq_buf_size;
> +	atomic_set(&chan_info->inflight_tx_cnt, 0);
> +	chan_info->shutdown = false;
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
> +	txq->desc.tx_desc =
> +		dmam_alloc_coherent(dev, size, &txq->dma, GFP_KERNEL);
> +	if (!txq->desc.tx_desc)
> +		return -ENOMEM;
> +
> +	chan_info->wait = devm_kcalloc(dev, chan_info->num_txq_entries,
> +				       sizeof(*chan_info->wait), GFP_KERNEL);
> +	if (!chan_info->wait)
> +		return -ENOMEM;
> +	for (i = 0; i < chan_info->num_txq_entries; i++) {
> +		init_waitqueue_head(&chan_info->wait[i].wait_queue);
> +		chan_info->wait[i].status = NBL_MBX_STATUS_IDLE;
> +		spin_lock_init(&chan_info->wait[i].status_lock);
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
> +	rxq->desc.rx_desc =
> +		dmam_alloc_coherent(dev, size, &rxq->dma, GFP_KERNEL);
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
> +					      &buf->pa, GFP_KERNEL);
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
> +static inline void nbl_chan_update_tail_ptr(struct nbl_hw_ops *hw_ops,
> +					    void *hw_priv, u32 tail_ptr, u8 qid)
> +{
> +	hw_ops->update_mailbox_queue_tail_ptr(hw_priv, tail_ptr, qid);
> +}
> +
> +static int nbl_chan_alloc_all_rx_bufs(struct nbl_channel_mgt *chan_mgt,
> +				      struct nbl_chan_info *chan_info)
> +{
> +	struct nbl_chan_ring *rxq = &chan_info->rxq;
> +	struct device *dev = chan_mgt->common->dev;
> +	struct nbl_chan_rx_desc *desc;
> +	struct nbl_chan_buf *buf;
> +	u16 i;
> +
> +	for (i = 0; i < chan_info->num_rxq_entries; i++) {
> +		buf = &rxq->buf[i];
> +		buf->va = dmam_alloc_coherent(dev, chan_info->rxq_buf_size,
> +					      &buf->pa, GFP_KERNEL);
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
> +	struct nbl_chan_waitqueue_head *wait_head;
> +	u16 i;
> +
> +	/* Step 1: Mark shutdown flag, reject all new send requests */
> +	WRITE_ONCE(chan_info->shutdown, true);
> +
> +	/* Stop hardware queues */
> +	nbl_chan_stop_queue(chan_mgt);
> +
> +	/* Cancel any pending cleanup work */
> +	if (chan_info->clean_task)
> +		cancel_work_sync(chan_info->clean_task);
> +	for (i = 0; i < chan_info->num_txq_entries; i++) {
> +		wait_head = &chan_info->wait[i];
> +		spin_lock_irq(&wait_head->status_lock);
> +		/* Only wake threads that are actually waiting */
> +		if (READ_ONCE(wait_head->status) == NBL_MBX_STATUS_WAITING) {
> +			/* Mark as timeout so waking threads know to abort */
> +			wait_head->status = NBL_MBX_STATUS_TIMEOUT;
> +			wait_head->acked = 1;
> +			wait_head->ack_err = -EIO;
> +			/* Ensure status is written */
> +			smp_wmb();
> +		}
> +		spin_unlock_irq(&wait_head->status_lock);
> +		if (READ_ONCE(wait_head->status) == NBL_MBX_STATUS_TIMEOUT)
> +			wake_up(&wait_head->wait_queue);
> +	}
> +
> +	/* Step 2: Wait all in-flight send_msg threads exit via counter */
> +	while (atomic_read(&chan_info->inflight_tx_cnt) != 0) {
> +		/* synchronize atomic counter load with other CPUs */
> +		smp_rmb();
> +		usleep_range(100, 1000);
> +	}
> +
> +	/* No concurrent thread holds txq_lock now, safe destroy mutex */
> +	mutex_destroy(&chan_info->txq_lock);
> +
> +	return 0;
> +}
> +
> +static int nbl_chan_setup_queue(struct nbl_channel_mgt *chan_mgt, u8 chan_type)
> +{
> +	struct nbl_chan_info *chan_info = chan_mgt->chan_info[chan_type];
> +	struct nbl_hw_ops *hw_ops = chan_mgt->hw_ops_tbl->ops;
> +	struct nbl_common_info *common = chan_mgt->common;
> +	struct nbl_chan_ring *rxq = &chan_info->rxq;
> +	int err;
> +
> +	if (chan_info->init_done)
> +		return 0;
> +	nbl_chan_init_queue_param(chan_info, NBL_CHAN_QUEUE_LEN,
> +				  NBL_CHAN_QUEUE_LEN, NBL_CHAN_BUF_LEN,
> +				  NBL_CHAN_BUF_LEN);
> +	err = nbl_chan_init_queue(common, chan_info);
> +	if (err)
> +		goto chan_setup_fail;
> +	err = nbl_chan_alloc_all_bufs(chan_mgt, chan_info);
> +	if (err)
> +		goto chan_setup_fail;
> +	nbl_chan_config_queue(chan_mgt, chan_info, true); /* tx */
> +	nbl_chan_config_queue(chan_mgt, chan_info, false); /* rx */
> +	nbl_chan_update_tail_ptr(hw_ops, chan_mgt->hw_ops_tbl->priv,
> +				 rxq->tail_ptr, NBL_MB_RX_QID);
> +	chan_info->init_done = true;
> +	return 0;
> +chan_setup_fail:
> +	mutex_destroy(&chan_info->txq_lock);
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
> +		memset(&tx_desc->buf_addr, 0, sizeof(tx_desc->buf_addr));
> +		memcpy(tx_desc->data, param->arg, param->arg_len);
> +		tx_desc->buf_len = 0;
> +		tx_desc->data_len = cpu_to_le16(param->arg_len);
> +	}
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
> +	nbl_chan_update_tail_ptr(hw_ops, chan_mgt->hw_ops_tbl->priv,
> +				 txq->tail_ptr, NBL_MB_TX_QID);
> +
> +	tx_desc = NBL_CHAN_TX_RING_TO_DESC(txq, txq->next_to_clean);
> +	while (retry_count < max_retries) {
> +		if (le16_to_cpu(READ_ONCE(tx_desc->flags)) &
> +		    BIT(NBL_CHAN_TX_DESC_USED)) {
> +			dma_rmb();
> +			break;
> +		}
> +
> +		retry_count++;
> +		if (retry_count == max_retries) {
> +			dev_err(dev, "chan send message type: %d timeout\n",
> +				le16_to_cpu(READ_ONCE(tx_desc->msg_type)));
> +			txq->next_to_clean = txq->next_to_use;
> +			return -ETIMEDOUT;
> +		}
> +		usleep_range(NBL_CHAN_TX_WAIT_US, NBL_CHAN_TX_WAIT_US_MAX);
> +	}
> +
> +	txq->next_to_clean = txq->next_to_use;
> +
> +	return 0;
> +}
> +
> +static void nbl_chan_recv_ack_msg(void *priv, u16 srcid, u16 msgid, void *data,
> +				  u32 data_len)
> +{
> +	struct nbl_channel_mgt *chan_mgt = (struct nbl_channel_mgt *)priv;
> +	struct nbl_chan_waitqueue_head *wait_head = NULL;
> +	struct device *dev = chan_mgt->common->dev;
> +	struct nbl_chan_info *chan_info =
> +		chan_mgt->chan_info[NBL_CHAN_TYPE_MAILBOX];
> +	u32 ack_datalen, ack_msgtype = 0;
> +	u32 *payload = data;
> +	u16 ack_msgid = 0;
> +	u32 copy_len;
> +
> +	if (data_len > NBL_CHAN_BUF_LEN ||
> +	    data_len < NBL_CHAN_ACK_HEAD_LEN * sizeof(u32)) {
> +		dev_err(dev, "Invalid ACK data_len: %u\n", data_len);
> +		return;
> +	}
> +	ack_datalen = data_len - NBL_CHAN_ACK_HEAD_LEN * sizeof(u32);
> +	ack_msgtype = le16_to_cpu(*(__le16 *)(payload + NBL_CHAN_MSG_TYPE_POS));
> +	ack_msgid = le16_to_cpu(*(__le16 *)(payload + NBL_CHAN_MSG_ID_POS));
> +	if (FIELD_GET(NBL_CHAN_MSGID_LOC_MASK, ack_msgid) >=
> +	    chan_info->num_txq_entries) {
> +		dev_err(dev, "chan recv msg id: %d err\n", ack_msgid);
> +		return;
> +	}
> +	wait_head =
> +		&chan_info->wait[FIELD_GET(NBL_CHAN_MSGID_LOC_MASK, ack_msgid)];
> +	spin_lock_irq(&wait_head->status_lock);
> +	if (srcid != wait_head->dstid) {
> +		/* Do not modify the status; the slot remains WAITING,
> +		 * and the sender will time out normally
> +		 */
> +		spin_unlock_irq(&wait_head->status_lock);
> +		dev_err(dev, "ACK srcid=%u != dstid=%u, rejecting\n", srcid,
> +			wait_head->dstid);
> +		return;
> +	}
> +	if (READ_ONCE(wait_head->status) != NBL_MBX_STATUS_WAITING) {
> +		spin_unlock_irq(&wait_head->status_lock);
> +		dev_err(dev,
> +			"Skip ack with invalid status, wait_head msgtype:%u msg_index:%u status:%d ack_data_len:%d, ack msgtype:%u msgid:%u datalen:%d\n",
> +			READ_ONCE(wait_head->msg_type),
> +			READ_ONCE(wait_head->msg_index),
> +			READ_ONCE(wait_head->status), wait_head->ack_data_len,
> +			ack_msgtype, ack_msgid, ack_datalen);
> +		return;
> +	}
> +
> +	if (READ_ONCE(wait_head->msg_type) != ack_msgtype) {
> +		/*
> +		 * Mismatched ACK. Restore state to WAITING so the original
> +		 * sender will time out and not reuse the slot.
> +		 */
> +		wait_head->status = NBL_MBX_STATUS_WAITING;
> +
> +		dev_err(dev,
> +			"Skip ack msg type donot match, wait_head msgtype:%u msg_index:%u status:%d ack_data_len:%d, ack msgtype:%u msgid:%u datalen:%d\n",
> +			READ_ONCE(wait_head->msg_type),
> +			READ_ONCE(wait_head->msg_index),
> +			READ_ONCE(wait_head->status), wait_head->ack_data_len,
> +			ack_msgtype, ack_msgid, ack_datalen);
> +		spin_unlock_irq(&wait_head->status_lock);
> +		/* Wake up the sender to let it know the ACK was invalid */
> +		wake_up(&wait_head->wait_queue);
> +		return;
> +	}
> +	if (FIELD_GET(NBL_CHAN_MSGID_INDEX_MASK, ack_msgid) !=
> +	    READ_ONCE(wait_head->msg_index)) {
> +		/*
> +		 * Stale ACK. Restore state to WAITING so the original
> +		 * sender will time out and not reuse the slot.
> +		 */
> +		wait_head->status = NBL_MBX_STATUS_WAITING;
> +
> +		dev_err(dev,
> +			"Stale ACK: expected index=%u, got msgid %u\n",
> +			READ_ONCE(wait_head->msg_index), ack_msgid);
> +		spin_unlock_irq(&wait_head->status_lock);
> +		/* Wake up the sender to let it know the ACK was stale */
> +		wake_up(&wait_head->wait_queue);
> +		return;
> +	}
> +
> +	wait_head->ack_err =
> +		le32_to_cpu(*(__le32 *)(payload + NBL_CHAN_ACK_RET_POS));
> +
> +	copy_len = min_t(u32, wait_head->ack_data_len, ack_datalen);
> +	if (wait_head->ack_err >= 0 && copy_len > 0) {
> +		if (!wait_head->ack_data) {
> +			dev_err(dev, "ACK payload dropped: ack_data is NULL\n");
> +			wait_head->ack_data_len = 0;
> +			goto ack_done;
> +		}
> +		memcpy((char *)wait_head->ack_data,
> +		       payload + NBL_CHAN_ACK_HEAD_LEN, copy_len);
> +		wait_head->ack_data_len = (u16)copy_len;
> +	} else {
> +		wait_head->ack_data_len = 0;
> +	}
> +ack_done:
> +	/*
> +	 * Ensure all writes to ack_data and ack_data_len are completed
> +	 * before setting the 'acked' flag. This prevents other threads
> +	 * from observing stale or partially updated data.
> +	 */
> +	smp_wmb();
> +	wait_head->acked = 1;
> +	spin_unlock_irq(&wait_head->status_lock);
> +	if (READ_ONCE(wait_head->acked))
> +		wake_up(&wait_head->wait_queue);
> +}
> +
> +static void nbl_chan_recv_msg(struct nbl_channel_mgt *chan_mgt, void *data)
> +{
> +	struct device *dev = chan_mgt->common->dev;
> +	struct nbl_chan_msg_node_data *msg_handler;
> +	u16 msg_type, payload_len, srcid, msgid;
> +	struct nbl_chan_tx_desc *tx_desc;
> +	void *payload;
> +
> +	tx_desc = data;
> +	msg_type = le16_to_cpu(tx_desc->msg_type);
> +	dev_dbg(dev, "recv msg_type: %d\n", msg_type);
> +
> +	srcid = le16_to_cpu(tx_desc->srcid);
> +	msgid = le16_to_cpu(tx_desc->msgid);
> +	/* Only check if the value exceeds the maximum, relying on the hash
> +	 * table to filter invalid message IDs.
> +	 * The gap values are reserved for future protocol extensions.
> +	 */
> +	if (msg_type >= NBL_CHAN_MSG_MAILBOX_MAX)
> +		return;
> +
> +	if (tx_desc->data_len) {
> +		payload_len = le16_to_cpu(tx_desc->data_len);
> +		if (payload_len > NBL_CHAN_TX_DESC_EMBEDDED_DATA_LEN) {
> +			dev_err(dev,
> +				"data_len=%u exceeds embedded buffer size=%u\n",
> +				payload_len,
> +				NBL_CHAN_TX_DESC_EMBEDDED_DATA_LEN);
> +			return;
> +		}
> +		payload = tx_desc->data;
> +	} else {
> +		payload_len = le16_to_cpu(tx_desc->buf_len);
> +		if (payload_len > NBL_CHAN_BUF_LEN - sizeof(*tx_desc)) {
> +			dev_err(dev,
> +				"buf_len=%u exceeds external buffer size=%zu\n",
> +				payload_len,
> +				NBL_CHAN_BUF_LEN - sizeof(*tx_desc));
> +			return;
> +		}
> +		payload = tx_desc + 1;
> +	}
> +
> +	msg_handler =
> +		nbl_common_get_hash_node(chan_mgt->handle_hash_tbl, &msg_type);
> +	if (!msg_handler || !msg_handler->func) {
> +		dev_err(dev,
> +			"No handler for msg_type: %u (srcid=%u, msgid=%u)\n",
> +			msg_type, srcid, msgid);
> +		return;
> +	}
> +	msg_handler->func(msg_handler->priv, srcid, msgid, payload,
> +			  payload_len);
> +}
> +
> +static void nbl_chan_advance_rx_ring(struct nbl_channel_mgt *chan_mgt,
> +				     struct nbl_chan_info *chan_info,
> +				     struct nbl_chan_ring *rxq)
> +{
> +	struct nbl_hw_ops *hw_ops = chan_mgt->hw_ops_tbl->ops;
> +	struct nbl_chan_rx_desc *rx_desc;
> +	struct nbl_chan_buf *rx_buf;
> +	u16 next_to_use;
> +
> +	next_to_use = rxq->next_to_use;
> +	rx_desc = NBL_CHAN_RX_RING_TO_DESC(rxq, next_to_use);
> +	rx_buf = NBL_CHAN_RX_RING_TO_BUF(rxq, next_to_use);
> +
> +	rx_desc->buf_addr = cpu_to_le64(rx_buf->pa);
> +	rx_desc->buf_len = cpu_to_le32(chan_info->rxq_buf_size);
> +
> +	/*
> +	 * DMA Write Memory Barrier:
> +	 * Ensures all previous DMA-mapped writes (buffer address/length)
> +	 * are completed before the descriptor flags are updated.
> +	 * This prevents hardware from seeing a partially updated descriptor
> +	 * where flags are set but buffer info isn't ready yet.
> +	 */
> +	dma_wmb();
> +
> +	rx_desc->flags = cpu_to_le16(BIT(NBL_CHAN_RX_DESC_AVAIL));
> +
> +	/*
> +	 * CPU Write Memory Barrier:
> +	 * Ensures the descriptor flags update is visible to other CPUs
> +	 * before we update the tail pointer. This is important for:
> +	 * 1. Software cleaning threads that might be checking the tail pointer
> +	 * 2. Maintaining proper memory ordering in multi-core systems
> +	 */
> +	wmb();
> +	rxq->next_to_use++;
> +	if (rxq->next_to_use == chan_info->num_rxq_entries)
> +		rxq->next_to_use = 0;
> +	rxq->tail_ptr++;
> +
> +	nbl_chan_update_tail_ptr(hw_ops, chan_mgt->hw_ops_tbl->priv,
> +				 rxq->tail_ptr, NBL_MB_RX_QID);
> +}
> +
> +/*
> + * Since the channel operates in either polling mode or interrupt mode
> + * (mutually exclusive, configured via set_queue_state), nbl_chan_clean_queue
> + * is always called in a serialized manner:
> + * 1. In polling mode: nbl_chan_clean_queue is called directly within
> + * nbl_chan_send_msg, in the same thread after txq_lock has been released.
> + * No other thread can call it concurrently.
> + * 2. In interrupt mode: nbl_chan_clean_queue is called from a workqueue
> + * (nbl_dev_clean_mailbox_task). Linux workqueue guarantees that the same
> + * work item never runs concurrently on multiple CPUs.
> + * Therefore, at any given time, only one execution context can be inside
> + * nbl_chan_clean_queue. There is no concurrency, and thus no need for
> + * locking
> + */
> +static void nbl_chan_clean_queue(struct nbl_channel_mgt *chan_mgt,
> +				 struct nbl_chan_info *chan_info)
> +{
> +	struct nbl_chan_ring *rxq = &chan_info->rxq;
> +	struct device *dev = chan_mgt->common->dev;
> +	struct nbl_chan_rx_desc *rx_desc;
> +	struct nbl_chan_buf *rx_buf;
> +	bool more_work = false;
> +	u16 next_to_clean;
> +	u32 budget = 64;
> +
> +	next_to_clean = rxq->next_to_clean;
> +	rx_desc = NBL_CHAN_RX_RING_TO_DESC(rxq, next_to_clean);
> +	rx_buf = NBL_CHAN_RX_RING_TO_BUF(rxq, next_to_clean);
> +	while (le16_to_cpu(rx_desc->flags) & BIT(NBL_CHAN_RX_DESC_USED)) {
> +		if (!(le16_to_cpu(rx_desc->flags) &
> +		      BIT(NBL_CHAN_RX_DESC_WRITE)))
> +			dev_dbg(dev,
> +				"mailbox rx flag 0x%x has no NBL_CHAN_RX_DESC_WRITE\n",
> +				le16_to_cpu(rx_desc->flags));
> +
> +		dma_rmb();
> +		nbl_chan_recv_msg(chan_mgt, rx_buf->va);
> +		nbl_chan_advance_rx_ring(chan_mgt, chan_info, rxq);
> +		next_to_clean++;
> +		if (next_to_clean == chan_info->num_rxq_entries)
> +			next_to_clean = 0;
> +		rx_desc = NBL_CHAN_RX_RING_TO_DESC(rxq, next_to_clean);
> +		rx_buf = NBL_CHAN_RX_RING_TO_BUF(rxq, next_to_clean);
> +		if (--budget == 0) {
> +			more_work = true;
> +			break;
> +		}
> +	}
> +	rxq->next_to_clean = next_to_clean;
> +	/* If descriptors remain, reschedule work to avoid stalled RX ring */
> +	if (more_work)
> +		schedule_work(chan_info->clean_task);
> +}
> +
> +static void nbl_chan_clean_queue_subtask(struct nbl_channel_mgt *chan_mgt,
> +					 u8 chan_type)
> +{
> +	struct nbl_chan_info *chan_info = chan_mgt->chan_info[chan_type];
> +
> +	if (!test_bit(NBL_CHAN_INTERRUPT_READY, chan_info->state))
> +		return;
> +
> +	nbl_chan_clean_queue(chan_mgt, chan_info);
> +}
> +
> +static int nbl_chan_get_msg_id(struct nbl_chan_info *chan_info,
> +			       u16 *msgid)
> +{
> +	int valid_loc = chan_info->wait_head_index, i;
> +	struct nbl_chan_waitqueue_head *wait = NULL;
> +	int status;
> +
> +	for (i = 0; i < NBL_CHAN_QUEUE_LEN; i++) {
> +		wait = &chan_info->wait[valid_loc];
> +		status = READ_ONCE(wait->status);
> +		if (status == NBL_MBX_STATUS_IDLE ||
> +		    status == NBL_MBX_STATUS_TIMEOUT) {
> +			wait->msg_index = NBL_NEXT_ID(wait->msg_index,
> +						      NBL_CHAN_MSG_INDEX_MAX);
> +			*msgid =
> +				FIELD_PREP(NBL_CHAN_MSGID_INDEX_MASK,
> +					   wait->msg_index) |
> +				FIELD_PREP(NBL_CHAN_MSGID_LOC_MASK, valid_loc);
> +			valid_loc = NBL_NEXT_ID(valid_loc,
> +						chan_info->num_txq_entries - 1);
> +			chan_info->wait_head_index = valid_loc;
> +			return 0;
> +		}
> +
> +		valid_loc =
> +			NBL_NEXT_ID(valid_loc, chan_info->num_txq_entries - 1);
> +	}
> +
> +	/*
> +	 * the current NBL_CHAN_QUEUE_LEN configuration meets the design
> +	 * requirements and theoretically should not return errors, the
> +	 * following scenarios may still cause the waiting queue to
> +	 * become full:
> +	 * High-concurrency scenarios:
> +	 * If the sender (calling nbl_chan_send_msg()) generates messages
> +	 * at a rate far exceeding the receiver's ability to process
> +	 * acknowledgments (ACKs),the waiting queue may become fully occupied.
> +	 * Delayed or failed ACK handling by the receiver:
> +	 * The receiver may fail to send ACKs in a timely manner due to
> +	 * processing delays, blocking, or faults, causing the sender's
> +	 * waiting queue slots to remain occupied for an extended period.
> +	 */
> +	return -EAGAIN;
> +}
> +
> +static int nbl_chan_send_msg(struct nbl_channel_mgt *chan_mgt,
> +			     struct nbl_chan_send_info *chan_send)
> +{
> +	struct nbl_common_info *common = chan_mgt->common;
> +	struct nbl_chan_waitqueue_head *wait_head;
> +	struct nbl_chan_tx_param tx_param = { 0 };
> +	u16 msgid = 0;
> +	int i = NBL_CHAN_TX_WAIT_ACK_TIMES, ret;
> +	struct nbl_chan_info *chan_info =
> +		chan_mgt->chan_info[NBL_CHAN_TYPE_MAILBOX];
> +	struct device *dev = common->dev;
> +
> +	if (chan_send->resp_len > NBL_CHAN_BUF_LEN) {
> +		dev_err(dev, "resp_len %zu exceeds max %d\n",
> +			chan_send->resp_len, NBL_CHAN_BUF_LEN);
> +		return -EINVAL;
> +	}
> +
> +	/* Reject new send if shutdown already triggered */
> +	if (READ_ONCE(chan_info->shutdown))
> +		return -ESHUTDOWN;
> +	mutex_lock(&chan_info->txq_lock);
> +
> +	if (test_bit(NBL_CHAN_ABNORMAL, chan_info->state)) {
> +		mutex_unlock(&chan_info->txq_lock);
> +		return -EIO;
> +	}
> +	ret = nbl_chan_get_msg_id(chan_info, &msgid);
> +	if (ret) {
> +		mutex_unlock(&chan_info->txq_lock);
> +		dev_err(dev,
> +			"Channel tx wait head full, send msgtype:%u to dstid:%u failed\n",
> +			chan_send->msg_type, chan_send->dstid);
> +		return ret;
> +	}
> +
> +	tx_param.msg_type = chan_send->msg_type;
> +	tx_param.arg = chan_send->arg;
> +	tx_param.arg_len = chan_send->arg_len;
> +	tx_param.dstid = chan_send->dstid;
> +	tx_param.msgid = msgid;
> +
> +	ret = nbl_chan_update_txqueue(chan_mgt, chan_info, &tx_param);
> +	if (ret) {
> +		mutex_unlock(&chan_info->txq_lock);
> +		dev_err(dev,
> +			"Channel tx queue full, send msgtype:%u to dstid:%u failed\n",
> +			chan_send->msg_type, chan_send->dstid);
> +		return ret;
> +	}
> +
> +	wait_head =
> +		&chan_info->wait[FIELD_GET(NBL_CHAN_MSGID_LOC_MASK, msgid)];
> +	spin_lock_irq(&wait_head->status_lock);
> +	wait_head->acked = 0;
> +	wait_head->ack_data = chan_send->resp;
> +	wait_head->ack_data_len = chan_send->resp_len;
> +	wait_head->msg_type = chan_send->msg_type;
> +	wait_head->msg_index = FIELD_GET(NBL_CHAN_MSGID_INDEX_MASK, msgid);
> +	wait_head->dstid = chan_send->dstid;
> +	/* Ensure all fields above are visible before status update, so receiver
> +	 * won't see WAITING with stale data
> +	 */
> +	smp_wmb();
> +	wait_head->status = chan_send->ack ? NBL_MBX_STATUS_WAITING :
> +					     NBL_MBX_STATUS_IDLE;
> +	spin_unlock_irq(&wait_head->status_lock);
> +
> +	atomic_inc(&chan_info->inflight_tx_cnt);
> +	ret = nbl_chan_kick_tx_ring(chan_mgt, chan_info);
> +	if (ret) {
> +		mutex_lock(&chan_info->txq_lock);

coccinelle says:

@@ -94,0 +95 @@
+/srv/nipa-builds-contest/testing/wt-cocci/drivers/net/ethernet/nebula-matrix/nbl/nbl_channel/nbl_channel.c:763:1-11: second lock on line 813

this will deadlock.

Note that sashiko has more comments:

https://sashiko.dev/#/patchset/20260708064742.35391-1-illusion.wang%40nebula-matrix.com

/P


