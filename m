Return-Path: <netdev+bounces-51630-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 264567FB7DC
	for <lists+netdev@lfdr.de>; Tue, 28 Nov 2023 11:31:22 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id D129A28234C
	for <lists+netdev@lfdr.de>; Tue, 28 Nov 2023 10:31:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 72B281DA35;
	Tue, 28 Nov 2023 10:31:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dkim=none
X-Original-To: netdev@vger.kernel.org
Received: from mail-lf1-f42.google.com (mail-lf1-f42.google.com [209.85.167.42])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 62FE13846
	for <netdev@vger.kernel.org>; Tue, 28 Nov 2023 02:31:16 -0800 (PST)
Received: by mail-lf1-f42.google.com with SMTP id 2adb3069b0e04-50bbfdb47d9so42042e87.1
        for <netdev@vger.kernel.org>; Tue, 28 Nov 2023 02:31:16 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1701167474; x=1701772274;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=8yR56X11HWS399diDPUhRtu1xkQ9o5pVqGKNwjok/hc=;
        b=hSX8ZoiFwtZRaAfoQm5BP+UFdixriThP9ycWcojgsRPc+KSmqZpnYS6ND3cvzAt+iG
         kXaoDY+gbJHV0Efhp7/7SXN7025ieS+IrAUBfHOl0cqiGWU8fCI5g5l/fQ9fXof1OlGa
         cGXumwZhxIEhqZacHJd7ED9ONw/J60ijqucw2XKUGZedE71wTp8pq434ZVeWP1ekYtIC
         kcP07ZNAVkp9pFV7XuPzMBFYZHjfJ2nweCZoIt5onVnR4xLDr1uj8cYOWlNct6mM8/jf
         Ye6JvV5O+L9jlAlqgjmWJVZRhGeJ8eDnGCidJE0vw1dYNhKnLe3VQDUNEipQqzLRag/U
         6Dhg==
X-Gm-Message-State: AOJu0YwzFIrSkV0hsxWdR3vM2V67AlAmiIT4OXcAYw8psxqA5+nMqt0e
	cuFuMr0yhfhlAdLyg6SFtdU=
X-Google-Smtp-Source: AGHT+IGJ1s8onHo8QUQVT/hXY+aUbiU0A/sw+v2cTa1kT/gekp8iJ+bOtPT+Poy3Q+hMBDLQUO63lw==
X-Received: by 2002:a05:6512:e86:b0:507:9d5c:62e3 with SMTP id bi6-20020a0565120e8600b005079d5c62e3mr9345653lfb.5.1701167474289;
        Tue, 28 Nov 2023 02:31:14 -0800 (PST)
Received: from [192.168.64.177] (bzq-219-42-90.isdn.bezeqint.net. [62.219.42.90])
        by smtp.gmail.com with ESMTPSA id bh5-20020a05600c3d0500b00405d9a950a2sm17858127wmb.28.2023.11.28.02.31.11
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 28 Nov 2023 02:31:14 -0800 (PST)
Message-ID: <debbb5ef-0e80-45e1-b9cc-1231a1c0f46a@grimberg.me>
Date: Tue, 28 Nov 2023 12:31:11 +0200
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v20 05/20] nvme-tcp: Add DDP offload control path
Content-Language: en-US
To: Aurelien Aptel <aaptel@nvidia.com>, linux-nvme@lists.infradead.org,
 netdev@vger.kernel.org, hch@lst.de, kbusch@kernel.org, axboe@fb.com,
 chaitanyak@nvidia.com, davem@davemloft.net, kuba@kernel.org
Cc: Boris Pismenny <borisp@nvidia.com>, aurelien.aptel@gmail.com,
 smalin@nvidia.com, malin1024@gmail.com, ogerlitz@nvidia.com,
 yorayz@nvidia.com, galshalom@nvidia.com, mgurtovoy@nvidia.com,
 brauner@kernel.org
References: <20231122134833.20825-1-aaptel@nvidia.com>
 <20231122134833.20825-6-aaptel@nvidia.com>
From: Sagi Grimberg <sagi@grimberg.me>
In-Reply-To: <20231122134833.20825-6-aaptel@nvidia.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit



On 11/22/23 15:48, Aurelien Aptel wrote:
> From: Boris Pismenny <borisp@nvidia.com>
> 
> This commit introduces direct data placement offload to NVME
> TCP. There is a context per queue, which is established after the
> handshake using the sk_add/del NDOs.
> 
> Additionally, a resynchronization routine is used to assist
> hardware recovery from TCP OOO, and continue the offload.
> Resynchronization operates as follows:
> 
> 1. TCP OOO causes the NIC HW to stop the offload
> 
> 2. NIC HW identifies a PDU header at some TCP sequence number,
> and asks NVMe-TCP to confirm it.
> This request is delivered from the NIC driver to NVMe-TCP by first
> finding the socket for the packet that triggered the request, and
> then finding the nvme_tcp_queue that is used by this routine.
> Finally, the request is recorded in the nvme_tcp_queue.
> 
> 3. When NVMe-TCP observes the requested TCP sequence, it will compare
> it with the PDU header TCP sequence, and report the result to the
> NIC driver (resync), which will update the HW, and resume offload
> when all is successful.
> 
> Some HW implementation such as ConnectX-7 assume linear CCID (0...N-1
> for queue of size N) where the linux nvme driver uses part of the 16
> bit CCID for generation counter. To address that, we use the existing
> quirk in the nvme layer when the HW driver advertises if the device is
> not supports the full 16 bit CCID range.
> 
> Furthermore, we let the offloading driver advertise what is the max hw
> sectors/segments via ulp_ddp_limits.
> 
> A follow-up patch introduces the data-path changes required for this
> offload.
> 
> Socket operations need a netdev reference. This reference is
> dropped on NETDEV_GOING_DOWN events to allow the device to go down in
> a follow-up patch.
> 
> Signed-off-by: Boris Pismenny <borisp@nvidia.com>
> Signed-off-by: Ben Ben-Ishay <benishay@nvidia.com>
> Signed-off-by: Or Gerlitz <ogerlitz@nvidia.com>
> Signed-off-by: Yoray Zack <yorayz@nvidia.com>
> Signed-off-by: Shai Malin <smalin@nvidia.com>
> Signed-off-by: Aurelien Aptel <aaptel@nvidia.com>
> Reviewed-by: Chaitanya Kulkarni <kch@nvidia.com>
> ---
>   drivers/nvme/host/tcp.c | 259 ++++++++++++++++++++++++++++++++++++++--
>   1 file changed, 246 insertions(+), 13 deletions(-)
> 
> diff --git a/drivers/nvme/host/tcp.c b/drivers/nvme/host/tcp.c
> index 89661a9cf850..7ad6a4854fce 100644
> --- a/drivers/nvme/host/tcp.c
> +++ b/drivers/nvme/host/tcp.c
> @@ -21,6 +21,10 @@
>   #include <net/busy_poll.h>
>   #include <trace/events/sock.h>
>   
> +#ifdef CONFIG_ULP_DDP
> +#include <net/ulp_ddp.h>
> +#endif
> +
>   #include "nvme.h"
>   #include "fabrics.h"
>   
> @@ -46,6 +50,16 @@ MODULE_PARM_DESC(tls_handshake_timeout,
>   		 "nvme TLS handshake timeout in seconds (default 10)");
>   #endif
>   
> +#ifdef CONFIG_ULP_DDP
> +/* NVMeTCP direct data placement and data digest offload will not
> + * happen if this parameter false (default), regardless of what the
> + * underlying netdev capabilities are.
> + */
> +static bool ddp_offload;
> +module_param(ddp_offload, bool, 0644);
> +MODULE_PARM_DESC(ddp_offload, "Enable or disable NVMeTCP direct data placement support");
> +#endif
> +
>   #ifdef CONFIG_DEBUG_LOCK_ALLOC
>   /* lockdep can detect a circular dependency of the form
>    *   sk_lock -> mmap_lock (page fault) -> fs locks -> sk_lock
> @@ -119,6 +133,7 @@ enum nvme_tcp_queue_flags {
>   	NVME_TCP_Q_ALLOCATED	= 0,
>   	NVME_TCP_Q_LIVE		= 1,
>   	NVME_TCP_Q_POLLING	= 2,
> +	NVME_TCP_Q_OFF_DDP	= 3,
>   };
>   
>   enum nvme_tcp_recv_state {
> @@ -146,6 +161,18 @@ struct nvme_tcp_queue {
>   	size_t			ddgst_remaining;
>   	unsigned int		nr_cqe;
>   
> +#ifdef CONFIG_ULP_DDP
> +	/*
> +	 * resync_tcp_seq is a speculative PDU header tcp seq number (with
> +	 * an additional flag in the lower 32 bits) that the HW send to
> +	 * the SW, for the SW to verify.
> +	 * - The 32 high bits store the seq number
> +	 * - The 32 low bits are used as a flag to know if a request
> +	 *   is pending (ULP_DDP_RESYNC_PENDING).
> +	 */
> +	atomic64_t		resync_tcp_seq;
> +#endif
> +
>   	/* send state */
>   	struct nvme_tcp_request *request;
>   
> @@ -188,6 +215,12 @@ struct nvme_tcp_ctrl {
>   	struct delayed_work	connect_work;
>   	struct nvme_tcp_request async_req;
>   	u32			io_queues[HCTX_MAX_TYPES];
> +
> +	struct net_device	*ddp_netdev;
> +	u32			ddp_threshold;
> +#ifdef CONFIG_ULP_DDP
> +	struct ulp_ddp_limits	ddp_limits;
> +#endif
>   };
>   
>   static LIST_HEAD(nvme_tcp_ctrl_list);
> @@ -291,6 +324,166 @@ static inline size_t nvme_tcp_pdu_last_send(struct nvme_tcp_request *req,
>   	return nvme_tcp_pdu_data_left(req) <= len;
>   }
>   
> +#ifdef CONFIG_ULP_DDP
> +
> +static struct net_device *
> +nvme_tcp_get_ddp_netdev_with_limits(struct nvme_tcp_ctrl *ctrl)
> +{
> +	struct net_device *netdev;
> +	bool ok;
> +
> +	if (!ddp_offload)
> +		return NULL;
> +
> +	/* netdev ref is put in nvme_tcp_stop_admin_queue() */
> +	netdev = get_netdev_for_sock(ctrl->queues[0].sock->sk);
> +	if (!netdev) {
> +		dev_dbg(ctrl->ctrl.device, "netdev not found\n");
> +		return NULL;
> +	}
> +
> +	ok = ulp_ddp_query_limits(netdev, &ctrl->ddp_limits,
> +				  ULP_DDP_NVME, ULP_DDP_CAP_NVME_TCP,
> +				  ctrl->ctrl.opts->tls);
> +	if (!ok) {

please use a normal name (ret).

Plus, its strange that a query function receives a feature and returns
true/false based on this. The query should return the limits, and the
caller should look at the limits and see if it is appropriately
supported.

The rest looks fine I think.

