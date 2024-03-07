Return-Path: <netdev+bounces-78301-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 352D1874A69
	for <lists+netdev@lfdr.de>; Thu,  7 Mar 2024 10:11:39 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 5938E1C236AC
	for <lists+netdev@lfdr.de>; Thu,  7 Mar 2024 09:11:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 78FD482D87;
	Thu,  7 Mar 2024 09:11:35 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from mail-wm1-f45.google.com (mail-wm1-f45.google.com [209.85.128.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 89D8D1C2A3
	for <netdev@vger.kernel.org>; Thu,  7 Mar 2024 09:11:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709802695; cv=none; b=aDt+x0Z2I037tMAgdhnd2D+ZvOWu8soA/6Eb7allbK4JIreyqiDMXGT6zKZ1OgGhcBJofrhbO4XHJlE8uOm7dOuWQAanbRrlCB311equz95UB5MJAaD4PSNV2ucoucFz+S3c1W31FV55u+JsN6fPbITHHBJs6HonoVFnMERp5LY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709802695; c=relaxed/simple;
	bh=PD6+hEJVEL+joCZ8ukO8+KpMDk7DMbQf/hB+cGOleBc=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=fEqef00Kg36XWz9jU6VIhn/qQYYZ87xFhGZ5MvUJ+Ww+GNZajHpJtgt1KTH70SRSDbjuWzEgv9XmURPVrm5inwuBFg38DhnTEk2r/kFjTldWYo+Y2gJ+fDILMUYn1N3s3vaRdRRK+2QMPicENwar8z3ZS1b62AJLnO4dtZVy7Yc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=grimberg.me; spf=pass smtp.mailfrom=gmail.com; arc=none smtp.client-ip=209.85.128.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=grimberg.me
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f45.google.com with SMTP id 5b1f17b1804b1-412b30be60dso264415e9.0
        for <netdev@vger.kernel.org>; Thu, 07 Mar 2024 01:11:33 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1709802692; x=1710407492;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=sV3KILdFqbeFakxvfHcfUPh4TO4RadSbVMLMqsrWXCE=;
        b=YHH0hGxsntHKE/4cvWR1IO2WuMicTdXsr1uBQvofcNolwWZRenGnTXTh8mpJXd44Ar
         souc636TyLDXex0CDdv0tLiL7/zhWb2kwOkOBkfPQKF39v8AK4fWSymyWPBPk1fotbiv
         NIQWR+sts5jko36vLnlF5ILlaZ3bQsokBQB7SthxLX1N6DzlQ87M+kQz3xrY72JgFO5g
         T9e2Bxs23ovih3vlISzoqm5OPwoOLVyutC5faH80P9fx87Xm0yRSgrR2FfJF1j+Xk+to
         pT82Z5hAE2tivpT55mnVrzczeoGAXHIVrQZZBZ+jM8K+Y5xAKrCdCIi2lFChHEwRfJ7/
         P9RA==
X-Forwarded-Encrypted: i=1; AJvYcCW6vsF5mThjq0iOqrYArhwAGPgSABZMIs7Yf/eM6cvWjotafVycZo9Ijuv+8qFVGvxidGEHQb/j353fuHduFuOZP1tHHLxC
X-Gm-Message-State: AOJu0YwrRY0G9lSNX43qrZrL57puTDTfwBWnGOjk2pxxdT0ZA6TvDIDE
	wgC2+/pCcwEz3sstsnQSlYl5y0vV+2aLKs+aCpEJAodtgq6xKv0P
X-Google-Smtp-Source: AGHT+IH5hk5HWDcCvZj69/cVtnB8bv0xOEaLSP0SK26TFBSl19Jr2zcxrzmQ4QQIvUus+UHDocxLUw==
X-Received: by 2002:a05:600c:3b26:b0:412:b7bc:bad with SMTP id m38-20020a05600c3b2600b00412b7bc0badmr926633wms.2.1709802691801;
        Thu, 07 Mar 2024 01:11:31 -0800 (PST)
Received: from [10.100.102.74] (46-117-80-176.bb.netvision.net.il. [46.117.80.176])
        by smtp.gmail.com with ESMTPSA id q8-20020a05600c46c800b00413099fc248sm1996099wmo.3.2024.03.07.01.11.30
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 07 Mar 2024 01:11:31 -0800 (PST)
Message-ID: <40a01a90-b91f-4526-a404-462de3ffa38a@grimberg.me>
Date: Thu, 7 Mar 2024 11:11:29 +0200
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v23 06/20] nvme-tcp: Add DDP data-path
Content-Language: en-US
To: Aurelien Aptel <aaptel@nvidia.com>, linux-nvme@lists.infradead.org,
 netdev@vger.kernel.org, hch@lst.de, kbusch@kernel.org, axboe@fb.com,
 chaitanyak@nvidia.com, davem@davemloft.net, kuba@kernel.org
Cc: Boris Pismenny <borisp@nvidia.com>, aurelien.aptel@gmail.com,
 smalin@nvidia.com, malin1024@gmail.com, ogerlitz@nvidia.com,
 yorayz@nvidia.com, galshalom@nvidia.com, mgurtovoy@nvidia.com
References: <20240228125733.299384-1-aaptel@nvidia.com>
 <20240228125733.299384-7-aaptel@nvidia.com>
From: Sagi Grimberg <sagi@grimberg.me>
In-Reply-To: <20240228125733.299384-7-aaptel@nvidia.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit



On 28/02/2024 14:57, Aurelien Aptel wrote:
> From: Boris Pismenny <borisp@nvidia.com>
>
> Introduce the NVMe-TCP DDP data-path offload.
> Using this interface, the NIC hardware will scatter TCP payload directly
> to the BIO pages according to the command_id in the PDU.
> To maintain the correctness of the network stack, the driver is expected
> to construct SKBs that point to the BIO pages.
>
> The data-path interface contains two routines: setup/teardown.
> The setup provides the mapping from command_id to the request buffers,
> while the teardown removes this mapping.
>
> For efficiency, we introduce an asynchronous nvme completion, which is
> split between NVMe-TCP and the NIC driver as follows:
> NVMe-TCP performs the specific completion, while NIC driver performs the
> generic mq_blk completion.
>
> Signed-off-by: Boris Pismenny <borisp@nvidia.com>
> Signed-off-by: Ben Ben-Ishay <benishay@nvidia.com>
> Signed-off-by: Or Gerlitz <ogerlitz@nvidia.com>
> Signed-off-by: Yoray Zack <yorayz@nvidia.com>
> Signed-off-by: Shai Malin <smalin@nvidia.com>
> Signed-off-by: Aurelien Aptel <aaptel@nvidia.com>
> Reviewed-by: Chaitanya Kulkarni <kch@nvidia.com>
> Reviewed-by: Max Gurtovoy <mgurtovoy@nvidia.com>
> ---
>   drivers/nvme/host/tcp.c | 135 ++++++++++++++++++++++++++++++++++++++--
>   1 file changed, 130 insertions(+), 5 deletions(-)
>
> diff --git a/drivers/nvme/host/tcp.c b/drivers/nvme/host/tcp.c
> index 86a9ad9f679b..b7cfe14661d6 100644
> --- a/drivers/nvme/host/tcp.c
> +++ b/drivers/nvme/host/tcp.c
> @@ -120,6 +120,10 @@ struct nvme_tcp_request {
>   	struct llist_node	lentry;
>   	__le32			ddgst;
>   
> +	/* ddp async completion */
> +	__le16			nvme_status;
> +	union nvme_result	result;
> +
>   	struct bio		*curr_bio;
>   	struct iov_iter		iter;
>   
> @@ -127,6 +131,11 @@ struct nvme_tcp_request {
>   	size_t			offset;
>   	size_t			data_sent;
>   	enum nvme_tcp_send_state state;
> +
> +#ifdef CONFIG_ULP_DDP
> +	bool			offloaded;
> +	struct ulp_ddp_io	ddp;
> +#endif
>   };
>   
>   enum nvme_tcp_queue_flags {
> @@ -333,6 +342,25 @@ static inline size_t nvme_tcp_pdu_last_send(struct nvme_tcp_request *req,
>   
>   #ifdef CONFIG_ULP_DDP
>   
> +static bool nvme_tcp_is_ddp_offloaded(const struct nvme_tcp_request *req)
> +{
> +	return req->offloaded;
> +}
> +
> +static int nvme_tcp_ddp_alloc_sgl(struct nvme_tcp_request *req, struct request *rq)
> +{
> +	int ret;
> +
> +	req->ddp.sg_table.sgl = req->ddp.first_sgl;
> +	ret = sg_alloc_table_chained(&req->ddp.sg_table,
> +				     blk_rq_nr_phys_segments(rq),
> +				     req->ddp.sg_table.sgl, SG_CHUNK_SIZE);
> +	if (ret)
> +		return -ENOMEM;
> +	req->ddp.nents = blk_rq_map_sg(rq->q, rq, req->ddp.sg_table.sgl);
> +	return 0;
> +}
> +
>   static struct net_device *
>   nvme_tcp_get_ddp_netdev_with_limits(struct nvme_tcp_ctrl *ctrl)
>   {
> @@ -366,10 +394,68 @@ nvme_tcp_get_ddp_netdev_with_limits(struct nvme_tcp_ctrl *ctrl)
>   }
>   
>   static bool nvme_tcp_resync_request(struct sock *sk, u32 seq, u32 flags);
> +static void nvme_tcp_ddp_teardown_done(void *ddp_ctx);
>   static const struct ulp_ddp_ulp_ops nvme_tcp_ddp_ulp_ops = {
>   	.resync_request		= nvme_tcp_resync_request,
> +	.ddp_teardown_done	= nvme_tcp_ddp_teardown_done,
>   };
>   
> +static void nvme_tcp_teardown_ddp(struct nvme_tcp_queue *queue,
> +				  struct request *rq)
> +{
> +	struct net_device *netdev = queue->ctrl->ddp_netdev;
> +	struct nvme_tcp_request *req = blk_mq_rq_to_pdu(rq);
> +
> +	ulp_ddp_teardown(netdev, queue->sock->sk, &req->ddp, rq);
> +	sg_free_table_chained(&req->ddp.sg_table, SG_CHUNK_SIZE);
> +}
> +
> +static void nvme_tcp_ddp_teardown_done(void *ddp_ctx)
> +{
> +	struct request *rq = ddp_ctx;
> +	struct nvme_tcp_request *req = blk_mq_rq_to_pdu(rq);
> +
> +	if (!nvme_try_complete_req(rq, req->nvme_status, req->result))
> +		nvme_complete_rq(rq);
> +}
> +
> +static void nvme_tcp_setup_ddp(struct nvme_tcp_queue *queue,
> +			       struct request *rq)
> +{
> +	struct net_device *netdev = queue->ctrl->ddp_netdev;
> +	struct nvme_tcp_request *req = blk_mq_rq_to_pdu(rq);
> +	int ret;
> +
> +	if (rq_data_dir(rq) != READ ||
> +	    queue->ctrl->ddp_threshold > blk_rq_payload_bytes(rq))
> +		return;
> +
> +	/*
> +	 * DDP offload is best-effort, errors are ignored.
> +	 */
> +
> +	req->ddp.command_id = nvme_cid(rq);
> +	ret = nvme_tcp_ddp_alloc_sgl(req, rq);
> +	if (ret)
> +		goto err;
> +
> +	ret = ulp_ddp_setup(netdev, queue->sock->sk, &req->ddp);
> +	if (ret) {
> +		sg_free_table_chained(&req->ddp.sg_table, SG_CHUNK_SIZE);
> +		goto err;
> +	}
> +
> +	/* if successful, sg table is freed in nvme_tcp_teardown_ddp() */
> +	req->offloaded = true;
> +
> +	return;
> +err:
> +	WARN_ONCE(ret, "ddp setup failed (queue 0x%x, cid 0x%x, ret=%d)",
> +		  nvme_tcp_queue_id(queue),
> +		  nvme_cid(rq),
> +		  ret);
> +}
> +
>   static int nvme_tcp_offload_socket(struct nvme_tcp_queue *queue)
>   {
>   	struct ulp_ddp_config config = {.type = ULP_DDP_NVME};
> @@ -473,6 +559,11 @@ static bool nvme_tcp_resync_request(struct sock *sk, u32 seq, u32 flags)
>   
>   #else
>   
> +static bool nvme_tcp_is_ddp_offloaded(const struct nvme_tcp_request *req)
> +{
> +	return false;
> +}
> +
>   static struct net_device *
>   nvme_tcp_get_ddp_netdev_with_limits(struct nvme_tcp_ctrl *ctrl)
>   {
> @@ -490,6 +581,14 @@ static int nvme_tcp_offload_socket(struct nvme_tcp_queue *queue)
>   static void nvme_tcp_unoffload_socket(struct nvme_tcp_queue *queue)
>   {}
>   
> +static void nvme_tcp_setup_ddp(struct nvme_tcp_queue *queue,
> +			       struct request *rq)
> +{}
> +
> +static void nvme_tcp_teardown_ddp(struct nvme_tcp_queue *queue,
> +				  struct request *rq)
> +{}
> +
>   static void nvme_tcp_resync_response(struct nvme_tcp_queue *queue,
>   				     struct sk_buff *skb, unsigned int offset)
>   {}
> @@ -765,6 +864,24 @@ static void nvme_tcp_error_recovery(struct nvme_ctrl *ctrl)
>   	queue_work(nvme_reset_wq, &to_tcp_ctrl(ctrl)->err_work);
>   }
>   
> +static void nvme_tcp_complete_request(struct request *rq,
> +				      __le16 status,
> +				      union nvme_result result,
> +				      __u16 command_id)
> +{
> +	struct nvme_tcp_request *req = blk_mq_rq_to_pdu(rq);
> +
> +	if (nvme_tcp_is_ddp_offloaded(req)) {
> +		req->nvme_status = status;

this can just be called req->status I think.

> +		req->result = result;

I think it will be cleaner to always capture req->result and req->status
regardless of ddp offload.

