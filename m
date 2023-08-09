Return-Path: <netdev+bounces-25730-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E06777754BB
	for <lists+netdev@lfdr.de>; Wed,  9 Aug 2023 10:05:11 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 1D56C1C2110C
	for <lists+netdev@lfdr.de>; Wed,  9 Aug 2023 08:05:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 07FAE6AD6;
	Wed,  9 Aug 2023 08:05:09 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EDA24654
	for <netdev@vger.kernel.org>; Wed,  9 Aug 2023 08:05:07 +0000 (UTC)
Received: from mail-wr1-f41.google.com (mail-wr1-f41.google.com [209.85.221.41])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A60F69F
	for <netdev@vger.kernel.org>; Wed,  9 Aug 2023 01:05:06 -0700 (PDT)
Received: by mail-wr1-f41.google.com with SMTP id ffacd0b85a97d-3159b524c56so1378311f8f.1
        for <netdev@vger.kernel.org>; Wed, 09 Aug 2023 01:05:06 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1691568305; x=1692173105;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=ycqtuhCoWtsQsxaEDdpgpm5AvhPbSKD4HgJtkoMA3MY=;
        b=mChddAVbT6IyJNbKeyDOVAogTE8akxi2mlxvsjIa4y9R7Ee/F0Tj39GjVVvA1qmmQX
         3TVUcc0cKxXDjp7OWR3eYqSrlazIrMKn2EeqzhKb0ux7H8wRwgqtDADPricuSu9OLa6P
         rkRjsWy0iZOuxF0Nd7aeVOdrgiyFhXP4NOpyufpMVqh8CTPiBZrtDAlFVPWPE3hR54AS
         Sketmsyu6Lle2r1FWI4eJLxEDXC+H8UJSQ44W3p7QWTYrx4yWsVaEWIeQwTAWjBH3mi8
         78xXidmfDz1mzVdGIkYE7oa9dz2v/pY7BpPkdWC73KjwbX3pp2+NNfJ6LnC002QztNnA
         uGLA==
X-Gm-Message-State: AOJu0YxaCAsO1xAFLi7FKwn+XCDASlt1zeDawaqVcvkYMKfUh0KvRCKP
	V90k5xLxfvgfXNJe820Gyps4gt7bOxA=
X-Google-Smtp-Source: AGHT+IHT5ZNEbGQFuD+ogPdomSkAEWAzqst+fNdyZwk2H712/UFR2hXNhncja+zh5uLznQ7B51VPkg==
X-Received: by 2002:a5d:50c4:0:b0:317:5559:a4e with SMTP id f4-20020a5d50c4000000b0031755590a4emr1181858wrt.6.1691568304911;
        Wed, 09 Aug 2023 01:05:04 -0700 (PDT)
Received: from [192.168.64.157] (bzq-219-42-90.isdn.bezeqint.net. [62.219.42.90])
        by smtp.gmail.com with ESMTPSA id n12-20020adff08c000000b00317b5c8a4f1sm15831390wro.60.2023.08.09.01.05.02
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 09 Aug 2023 01:05:04 -0700 (PDT)
Message-ID: <02837791-9e54-5b17-28a5-0df35bb93806@grimberg.me>
Date: Wed, 9 Aug 2023 11:05:01 +0300
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.13.0
Subject: Re: [PATCH v12 12/26] nvme-tcp: Only enable offload with TLS if the
 driver supports it
Content-Language: en-US
To: Aurelien Aptel <aaptel@nvidia.com>, linux-nvme@lists.infradead.org,
 netdev@vger.kernel.org, hch@lst.de, kbusch@kernel.org, axboe@fb.com,
 chaitanyak@nvidia.com, davem@davemloft.net, kuba@kernel.org
Cc: aurelien.aptel@gmail.com, smalin@nvidia.com, malin1024@gmail.com,
 ogerlitz@nvidia.com, yorayz@nvidia.com, borisp@nvidia.com,
 galshalom@nvidia.com, mgurtovoy@nvidia.com
References: <20230712161513.134860-1-aaptel@nvidia.com>
 <20230712161513.134860-13-aaptel@nvidia.com>
From: Sagi Grimberg <sagi@grimberg.me>
In-Reply-To: <20230712161513.134860-13-aaptel@nvidia.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-3.2 required=5.0 tests=BAYES_00,
	FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
	NICE_REPLY_A,RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,
	SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net



On 7/12/23 19:14, Aurelien Aptel wrote:
> Check if ULP offload driver supports ULP-over-TLS before enabling the
> offload with tls.
> 
> Signed-off-by: Aurelien Aptel <aaptel@nvidia.com>
> Signed-off-by: Shai Malin <smalin@nvidia.com>
> Reviewed-by: Max Gurtovoy <mgurtovoy@nvidia.com>
> ---
>   drivers/nvme/host/tcp.c | 4 ++++
>   1 file changed, 4 insertions(+)
> 
> diff --git a/drivers/nvme/host/tcp.c b/drivers/nvme/host/tcp.c
> index e560bdf3a023..afb3dedcbc0c 100644
> --- a/drivers/nvme/host/tcp.c
> +++ b/drivers/nvme/host/tcp.c
> @@ -367,6 +367,10 @@ static inline bool is_netdev_ulp_offload_active(struct net_device *netdev,
>   	if (!nvme_tcp_ddp_query_limits(netdev, queue))
>   		return false;
>   
> +	/* If we are using TLS and netdev doesn't support it, do not offload */
> +	if (queue->ctrl->ctrl.opts->tls && !queue->ddp_limits.tls)
> +		return false;

Same for this, fold to the first patch.

Other than that I had a question on one of my other responses.
I don't think that tls_device supports 1.3, so what does tls
here mean? That any device that enables this supports _all_
tls versions?

