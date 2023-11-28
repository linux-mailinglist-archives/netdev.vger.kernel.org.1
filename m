Return-Path: <netdev+bounces-51636-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 40B4A7FB843
	for <lists+netdev@lfdr.de>; Tue, 28 Nov 2023 11:43:01 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id F00C5282AA2
	for <lists+netdev@lfdr.de>; Tue, 28 Nov 2023 10:42:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 986D418C08;
	Tue, 28 Nov 2023 10:42:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dkim=none
X-Original-To: netdev@vger.kernel.org
Received: from mail-lj1-f169.google.com (mail-lj1-f169.google.com [209.85.208.169])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B866A1BD1
	for <netdev@vger.kernel.org>; Tue, 28 Nov 2023 02:42:56 -0800 (PST)
Received: by mail-lj1-f169.google.com with SMTP id 38308e7fff4ca-2c9b57f87f3so929091fa.1
        for <netdev@vger.kernel.org>; Tue, 28 Nov 2023 02:42:56 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1701168175; x=1701772975;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=YKVzGvl+LlWimuqcFatkZrJ/6x3ko69rmC3lpZC3FlM=;
        b=kSyNAcKq696ewXfhmOIdlB7LMRqr/j0QylPL0jCEAICJhzC2ACqDcih48SFDrbeBxd
         WburkjutEmYWu8Z2mUdAGG5jgT/13F4WBzTPkyHX10zwkUa/NBZnkx5Fp01C5QOenYnB
         pD2+U666fIDgYLxFNaThKpEsrVnbo1/jiCsyglMK6Xu51jLkuOnodREpb3YlBHlRe7DL
         Wfwfw3e9k/CrdarFiaKE/TxA1PW3ucgWrHA0rVU9zH2JkpWCDWdPdMTabSCLCvX1YtJj
         FXYqWzRO8kaDaDzn8yy2PewfONw0Gjd6Xr0XC5oaNX+Aq4XhHsQaAM54s/qiwUgILtIx
         2D8w==
X-Gm-Message-State: AOJu0YwqN5oxtV5zBKfntV5dgAdngqZ2XbDDBpSaupqAxsEg3XkZIHCo
	d/feATmh6Pew8XjC4khJHJ0=
X-Google-Smtp-Source: AGHT+IHXqUOVAr2hEym0ib8T1psOwVqNhwmvdtSEWIcqlpLG702FVoysQYOEl62vAw3KRlfkq0+w6Q==
X-Received: by 2002:a2e:5404:0:b0:2c8:38b2:2c33 with SMTP id i4-20020a2e5404000000b002c838b22c33mr8507107ljb.3.1701168174702;
        Tue, 28 Nov 2023 02:42:54 -0800 (PST)
Received: from [192.168.64.177] (bzq-219-42-90.isdn.bezeqint.net. [62.219.42.90])
        by smtp.gmail.com with ESMTPSA id m8-20020a05600c4f4800b0040b347d90d0sm17643343wmq.12.2023.11.28.02.42.52
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 28 Nov 2023 02:42:54 -0800 (PST)
Message-ID: <bc6ec871-de51-477a-b27f-4d516e5bc3e1@grimberg.me>
Date: Tue, 28 Nov 2023 12:42:51 +0200
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v20 07/20] nvme-tcp: RX DDGST offload
Content-Language: en-US
To: Aurelien Aptel <aaptel@nvidia.com>, linux-nvme@lists.infradead.org,
 netdev@vger.kernel.org, hch@lst.de, kbusch@kernel.org, axboe@fb.com,
 chaitanyak@nvidia.com, davem@davemloft.net, kuba@kernel.org
Cc: Yoray Zack <yorayz@nvidia.com>, aurelien.aptel@gmail.com,
 smalin@nvidia.com, malin1024@gmail.com, ogerlitz@nvidia.com,
 borisp@nvidia.com, galshalom@nvidia.com, mgurtovoy@nvidia.com
References: <20231122134833.20825-1-aaptel@nvidia.com>
 <20231122134833.20825-8-aaptel@nvidia.com>
From: Sagi Grimberg <sagi@grimberg.me>
In-Reply-To: <20231122134833.20825-8-aaptel@nvidia.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit



On 11/22/23 15:48, Aurelien Aptel wrote:
> From: Yoray Zack <yorayz@nvidia.com>
> 
> Enable rx side of DDGST offload when supported.
> 
> At the end of the capsule, check if all the skb bits are on, and if not
> recalculate the DDGST in SW and check it.
> 
> Signed-off-by: Yoray Zack <yorayz@nvidia.com>
> Signed-off-by: Boris Pismenny <borisp@nvidia.com>
> Signed-off-by: Ben Ben-Ishay <benishay@nvidia.com>
> Signed-off-by: Or Gerlitz <ogerlitz@nvidia.com>
> Signed-off-by: Shai Malin <smalin@nvidia.com>
> Signed-off-by: Aurelien Aptel <aaptel@nvidia.com>
> Reviewed-by: Chaitanya Kulkarni <kch@nvidia.com>
> ---
>   drivers/nvme/host/tcp.c | 84 ++++++++++++++++++++++++++++++++++++++---
>   1 file changed, 79 insertions(+), 5 deletions(-)
> 
> diff --git a/drivers/nvme/host/tcp.c b/drivers/nvme/host/tcp.c
> index 680d909eb3fb..5537f04a62fd 100644
> --- a/drivers/nvme/host/tcp.c
> +++ b/drivers/nvme/host/tcp.c
> @@ -141,6 +141,7 @@ enum nvme_tcp_queue_flags {
>   	NVME_TCP_Q_LIVE		= 1,
>   	NVME_TCP_Q_POLLING	= 2,
>   	NVME_TCP_Q_OFF_DDP	= 3,
> +	NVME_TCP_Q_OFF_DDGST_RX = 4,
>   };
>   
>   enum nvme_tcp_recv_state {
> @@ -178,6 +179,7 @@ struct nvme_tcp_queue {
>   	 *   is pending (ULP_DDP_RESYNC_PENDING).
>   	 */
>   	atomic64_t		resync_tcp_seq;
> +	bool			ddp_ddgst_valid;
>   #endif
>   
>   	/* send state */
> @@ -360,6 +362,33 @@ nvme_tcp_get_ddp_netdev_with_limits(struct nvme_tcp_ctrl *ctrl)
>   	return netdev;
>   }
>   
> +static inline bool nvme_tcp_ddp_ddgst_ok(struct nvme_tcp_queue *queue)
> +{
> +	return queue->ddp_ddgst_valid;
> +}
> +
> +static inline void nvme_tcp_ddp_ddgst_update(struct nvme_tcp_queue *queue,
> +					     struct sk_buff *skb)
> +{
> +	if (queue->ddp_ddgst_valid)
> +		queue->ddp_ddgst_valid = skb_is_ulp_crc(skb);
> +}
> +
> +static void nvme_tcp_ddp_ddgst_recalc(struct ahash_request *hash,
> +				      struct request *rq,
> +				      __le32 *ddgst)
> +{
> +	struct nvme_tcp_request *req;
> +
> +	if (!rq)
> +		return;

How is this even possible? And what happens down the road if this is
indeed a null rq?

> +
> +	req = blk_mq_rq_to_pdu(rq);
> +	ahash_request_set_crypt(hash, req->ddp.sg_table.sgl, (u8 *)ddgst,
> +				req->data_len);
> +	crypto_ahash_digest(hash);
> +}
> +
>   static bool nvme_tcp_resync_request(struct sock *sk, u32 seq, u32 flags);
>   static void nvme_tcp_ddp_teardown_done(void *ddp_ctx);
>   static const struct ulp_ddp_ulp_ops nvme_tcp_ddp_ulp_ops = {
> @@ -430,6 +459,8 @@ static void nvme_tcp_setup_ddp(struct nvme_tcp_queue *queue,
>   static int nvme_tcp_offload_socket(struct nvme_tcp_queue *queue)
>   {
>   	struct ulp_ddp_config config = {.type = ULP_DDP_NVME};
> +	bool offload_ddgst_rx = ulp_ddp_is_cap_active(queue->ctrl->ddp_netdev,
> +						      ULP_DDP_CAP_NVME_TCP_DDGST_RX);

Not sure a local variable is needed here.

