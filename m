Return-Path: <netdev+bounces-264271-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 0K7TL1pYqWnW5wAAu9opvQ
	(envelope-from <netdev+bounces-264271-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Thu, 05 Mar 2026 11:18:02 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 4475A20F918
	for <lists+netdev@lfdr.de>; Thu, 05 Mar 2026 11:18:02 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id B141F300F501
	for <lists+netdev@lfdr.de>; Thu,  5 Mar 2026 10:16:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9711937EFE6;
	Thu,  5 Mar 2026 10:16:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="SImRpksB";
	dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b="D/xquQdW"
X-Original-To: netdev@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B19103793A7
	for <netdev@vger.kernel.org>; Thu,  5 Mar 2026 10:16:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772705803; cv=none; b=FaZy9UDy1xOo6nExd1P3f9YjvLtaI8eWzx9Wmx73xwHYqQnxc47s1VwzPorUHjVbLmT5OujnZtoGq71PoPAc96iBt3MJb4WU2C/URYqrdy8gf+zcff/uHQOu3lD4PmsT5ff+4wQlUDZrmaSGo1+Fwk36x8C6ZEEKDcvXm0PQkzE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772705803; c=relaxed/simple;
	bh=LuVoTGSy+8rbdfWP8yIzBo098f/AfwAMvEWcz9ER6Gw=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=FmWpRGNvA24U8KckOFwpr847HVVhhmzhgilOj5gbbu/ljQJxO/wIMcrLimPlKJSxI4H6Ru3p6tJ5tGH2DJ9e60qQXpG5nwYWc0kRMQudRQksX9hUpGN7/54U0fhKfEOw/4fmun2rD2UF5cFhrkPzF9HQoKuoWNlZWufLB+NLT/A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=SImRpksB; dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b=D/xquQdW; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1772705798;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=4mtNYXzFNXlS8vm7bi59zPJr1q180y4cv5LI061vz/U=;
	b=SImRpksBnj6rTHURKjfsrlwRaQ2n38sK//68ilOfGIn6aePE71GoeiVuC01u81aFAUff5r
	6NLhogn2aOO6dkpYt36TiU+WkCYwuE3uUOc3cXjKjaiHtD5OOKYGyu6NRux+CLyPjKdbsi
	G+fwFIKHa/kmpLeapGkI4dj6+6qqOKo=
Received: from mail-wm1-f70.google.com (mail-wm1-f70.google.com
 [209.85.128.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-472-Qa28JORCOfaPlHKdaaku6w-1; Thu, 05 Mar 2026 05:16:37 -0500
X-MC-Unique: Qa28JORCOfaPlHKdaaku6w-1
X-Mimecast-MFC-AGG-ID: Qa28JORCOfaPlHKdaaku6w_1772705796
Received: by mail-wm1-f70.google.com with SMTP id 5b1f17b1804b1-48379489438so76697385e9.2
        for <netdev@vger.kernel.org>; Thu, 05 Mar 2026 02:16:37 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=redhat.com; s=google; t=1772705796; x=1773310596; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=4mtNYXzFNXlS8vm7bi59zPJr1q180y4cv5LI061vz/U=;
        b=D/xquQdWyQ4uhv7xsSNidAZPcA4NmQfvEHSdST9Ca20gBZy//zOEuMXaESK4DSX9XG
         Rt6xX1EziyC8ORygnd23dES+qkrys1J9pcU236bfpPVdemY1Ug54SD7PiA5Vp8dynEqp
         QpZvPDnGOvWLcyaR89B0r8lfdwlxvQ2Dn/hDjsKlR5yD8kVyDxjAaaVcipjNkNJFRcii
         QH9ruiBguWHIm+8IYrECQTNopEFhFvML730LBoinzOYzlydIafp03tJojWlc2w263aaM
         PrLL4O4mr3JoFO2czgzI4vFOs44iK6QieFiDq8jHas2V6edjw14llBN8JHWF6qhGve9y
         2nXw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1772705796; x=1773310596;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=4mtNYXzFNXlS8vm7bi59zPJr1q180y4cv5LI061vz/U=;
        b=IpSIWI3RFludvvwEceY1t1dykxLEwVMSrcQMZDkDsFoIoPgpFaDdTkSJSUq+q8CaBS
         XHgN0BVlheuAIewXnP9K4aS03ysf1W36aB14UthZfEMtvBaOqTHIlCfGeQ9q7YxZMxeN
         n93xSRWfiyrqsZTyG8LSHwK7cGvwstq1Jpu8P+kMz/qze6/ij2KH7azEJyEachuMbu7X
         oQ1SayMssrNOTs0OIEF8/SkQEqSxVvsDa2BdhX7rqLWpKQa4aV11UWLldIZdDbJrXLlR
         YV0AJwo4EQ4HEuU2rDa/H0UGXbbMmfzGzEKep4XCEkeCwPrsefDUtuaApHLELK0i2IHn
         X5yA==
X-Forwarded-Encrypted: i=1; AJvYcCXL3UayLSy5AHl+ZqJnV6OLPJUQL4oYjMmTrMDMoG569iT3hOQn3HCHtbtRsitAjNSHp49vNPU=@vger.kernel.org
X-Gm-Message-State: AOJu0YzFrPvo/z82MR+DqNFGaWqlLGHE6kZbUABSv2Ks0uPzeA06iKoJ
	bVrMRIcacaGbWUso9szhXTERxNNrlL9gVbEchBMkilEMGyrmfvO7BtnGaamzq4AfZnEUfmyi29L
	3MVnZy2e7KYpOgCUtHj+7U8EzFtR07GVzZ2qkNOUZU8dWWmOF+ssTtaW2GoD9VBlBOA==
X-Gm-Gg: ATEYQzwLwAZaZXQMmcG6aSC8uwrES9Kbz2OaJGeYUYb3EZLD3FSsccry8QRfLXYV7G0
	VYEsUS/iQ3MhAiwMQiuxMFs2cVzKaX73c6c0/MYG02GGEFaCJEl4Rg5rXBGQtHW0l52g6v4mixD
	w4rdzHrjITCtChHv6iMHh/a8Bi9NvApqjQt9uFjBhiaqe/FsVOJw7hmyxGn4Z/ahKVTHxKNJnG/
	A0EAg/tAvWQ9wZRiU92vk8JcnJZxN/zffRHwg9+EX5g+Ff0r4qXEHFs1cQhtsbTHcyIUhlHM3GX
	80iJaBZYEJ8L/OBkqjIPGp9w40VihmGu36uCQDRBekn0wafYcWbRRzGMGeAji3kJeu74kwtJokb
	dIImvQyhVncRCzGJPUFTNbS4MQw==
X-Received: by 2002:a05:600c:8b01:b0:477:9eb8:97d2 with SMTP id 5b1f17b1804b1-48519851b43mr86602895e9.8.1772705795548;
        Thu, 05 Mar 2026 02:16:35 -0800 (PST)
X-Received: by 2002:a05:600c:8b01:b0:477:9eb8:97d2 with SMTP id 5b1f17b1804b1-48519851b43mr86602455e9.8.1772705794923;
        Thu, 05 Mar 2026 02:16:34 -0800 (PST)
Received: from [192.168.88.32] ([212.105.149.216])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4851fadeb5bsm45476665e9.5.2026.03.05.02.16.33
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 05 Mar 2026 02:16:34 -0800 (PST)
Message-ID: <e6c3b053-75d7-46b5-9fd0-ac6de498456f@redhat.com>
Date: Thu, 5 Mar 2026 11:16:32 +0100
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net-next v28 4/8] eea: create/destroy rx,tx queues for
 netdevice open and stop
To: Xuan Zhuo <xuanzhuo@linux.alibaba.com>, netdev@vger.kernel.org
Cc: Andrew Lunn <andrew+netdev@lunn.ch>, "David S. Miller"
 <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>,
 Jakub Kicinski <kuba@kernel.org>, Wen Gu <guwen@linux.alibaba.com>,
 Philo Lu <lulie@linux.alibaba.com>, Lorenzo Bianconi <lorenzo@kernel.org>,
 Vadim Fedorenko <vadim.fedorenko@linux.dev>, Dong Yibo <dong100@mucse.com>,
 Heiner Kallweit <hkallweit1@gmail.com>,
 Lukas Bulwahn <lukas.bulwahn@redhat.com>, Dust Li <dust.li@linux.alibaba.com>
References: <20260302024604.25354-1-xuanzhuo@linux.alibaba.com>
 <20260302024604.25354-5-xuanzhuo@linux.alibaba.com>
Content-Language: en-US
From: Paolo Abeni <pabeni@redhat.com>
In-Reply-To: <20260302024604.25354-5-xuanzhuo@linux.alibaba.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Rspamd-Queue-Id: 4475A20F918
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.66 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[redhat.com,quarantine];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	R_DKIM_ALLOW(-0.20)[redhat.com:s=mimecast20190719,redhat.com:s=google];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FREEMAIL_CC(0.00)[lunn.ch,davemloft.net,google.com,kernel.org,linux.alibaba.com,linux.dev,mucse.com,gmail.com,redhat.com];
	TAGGED_FROM(0.00)[bounces-264271-lists,netdev=lfdr.de];
	FROM_HAS_DN(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[14];
	MIME_TRACE(0.00)[0:+];
	DKIM_TRACE(0.00)[redhat.com:+];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	TO_DN_SOME(0.00)[];
	RCVD_COUNT_FIVE(0.00)[6];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[pabeni@redhat.com,netdev@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[netdev];
	MID_RHS_MATCH_FROM(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:rdns,sea.lore.kernel.org:helo,alibaba.com:email]
X-Rspamd-Action: no action

On 3/2/26 3:46 AM, Xuan Zhuo wrote:
> Add basic driver framework for the Alibaba Elastic Ethernet Adapter(EEA).
> 
> This commit introduces the implementation for the netdevice open and
> stop.
> 
> Reviewed-by: Dust Li <dust.li@linux.alibaba.com>
> Reviewed-by: Philo Lu <lulie@linux.alibaba.com>
> Signed-off-by: Wen Gu <guwen@linux.alibaba.com>
> Signed-off-by: Xuan Zhuo <xuanzhuo@linux.alibaba.com>
> ---
>  drivers/net/ethernet/alibaba/eea/Makefile  |   4 +-
>  drivers/net/ethernet/alibaba/eea/eea_net.c | 530 ++++++++++++++++++++-
>  drivers/net/ethernet/alibaba/eea/eea_net.h |  45 ++
>  drivers/net/ethernet/alibaba/eea/eea_pci.c | 182 ++++++-
>  drivers/net/ethernet/alibaba/eea/eea_pci.h |  13 +
>  drivers/net/ethernet/alibaba/eea/eea_rx.c  | 254 ++++++++++
>  drivers/net/ethernet/alibaba/eea/eea_tx.c  | 104 ++++
>  7 files changed, 1127 insertions(+), 5 deletions(-)
>  create mode 100644 drivers/net/ethernet/alibaba/eea/eea_rx.c
>  create mode 100644 drivers/net/ethernet/alibaba/eea/eea_tx.c
> 
> diff --git a/drivers/net/ethernet/alibaba/eea/Makefile b/drivers/net/ethernet/alibaba/eea/Makefile
> index 91f318e8e046..fa34a005fa01 100644
> --- a/drivers/net/ethernet/alibaba/eea/Makefile
> +++ b/drivers/net/ethernet/alibaba/eea/Makefile
> @@ -3,4 +3,6 @@ obj-$(CONFIG_EEA) += eea.o
>  eea-y := eea_ring.o \
>  	eea_net.o \
>  	eea_pci.o \
> -	eea_adminq.o
> +	eea_adminq.o \
> +	eea_tx.o \
> +	eea_rx.o
> diff --git a/drivers/net/ethernet/alibaba/eea/eea_net.c b/drivers/net/ethernet/alibaba/eea/eea_net.c
> index 31cb9ca5b408..2ebf0053d05e 100644
> --- a/drivers/net/ethernet/alibaba/eea/eea_net.c
> +++ b/drivers/net/ethernet/alibaba/eea/eea_net.c
> @@ -18,6 +18,453 @@
>  
>  #define EEA_SPLIT_HDR_SIZE 128
>  
> +static irqreturn_t eea_irq_handler(int irq, void *data)
> +{
> +	struct eea_irq_blk *blk = data;
> +
> +	napi_schedule_irqoff(&blk->napi);
> +
> +	return IRQ_HANDLED;
> +}
> +
> +static void eea_free_irq_blk(struct eea_net *enet)
> +{
> +	struct eea_irq_blk *blk;
> +	u32 num;
> +	int i;
> +
> +	if (!enet->irq_blks)
> +		return;
> +
> +	num = enet->edev->rx_num;
> +
> +	for (i = 0; i < num; i++) {
> +		blk = &enet->irq_blks[i];
> +
> +		if (blk->ready)
> +			eea_pci_free_irq(blk);
> +
> +		blk->ready = false;
> +	}
> +
> +	kvfree(enet->irq_blks);
> +	enet->irq_blks = NULL;
> +}
> +
> +static int eea_alloc_irq_blks(struct eea_net *enet, u32 num)
> +{
> +	struct eea_device *edev = enet->edev;
> +	struct eea_irq_blk *blk, *irq_blks;
> +	int i, err;
> +
> +	irq_blks = kvcalloc(num, sizeof(*blk), GFP_KERNEL);
> +	if (!irq_blks)
> +		return -ENOMEM;
> +
> +	enet->irq_blks = irq_blks;
> +
> +	for (i = 0; i < num; i++) {
> +		blk = &irq_blks[i];
> +		blk->idx = i;
> +
> +		/* vec 0 is for error notify. */
> +		blk->msix_vec = i + 1;
> +
> +		err = eea_pci_request_irq(edev, blk, eea_irq_handler);
> +		if (err)
> +			goto err_free_irq_blk;
> +
> +		blk->ready = true;
> +	}
> +
> +	return 0;
> +
> +err_free_irq_blk:
> +	eea_free_irq_blk(enet);
> +	return err;
> +}
> +
> +static int eea_update_queues(struct eea_net *enet)
> +{
> +	return netif_set_real_num_queues(enet->netdev, enet->cfg.tx_ring_num,
> +					 enet->cfg.rx_ring_num);
> +}
> +
> +void eea_init_ctx(struct eea_net *enet, struct eea_net_init_ctx *ctx)
> +{
> +	memset(ctx, 0, sizeof(*ctx));
> +
> +	ctx->netdev = enet->netdev;
> +	ctx->edev = enet->edev;
> +	ctx->cfg = enet->cfg;
> +}
> +
> +static void eea_bind_q_and_cfg(struct eea_net *enet,
> +			       struct eea_net_init_ctx *ctx)
> +{
> +	struct eea_irq_blk *blk;
> +	struct eea_net_rx *rx;
> +	struct eea_net_tx *tx;
> +	int i;
> +
> +	enet->cfg = ctx->cfg;
> +	enet->rx = ctx->rx;
> +	enet->tx = ctx->tx;
> +
> +	for (i = 0; i < ctx->cfg.rx_ring_num; i++) {
> +		blk = &enet->irq_blks[i];
> +
> +		rx = ctx->rx[i];
> +		tx = &ctx->tx[i];
> +
> +		rx->enet = enet;
> +		rx->napi = &blk->napi;
> +		rx->ering->msix_vec = blk->msix_vec;
> +
> +		tx->enet = enet;
> +		tx->ering->msix_vec = blk->msix_vec;
> +
> +		blk->rx = rx;
> +	}
> +}
> +
> +static void eea_unbind_q_and_cfg(struct eea_net *enet,
> +				 struct eea_net_init_ctx *ctx)
> +{
> +	struct eea_irq_blk *blk;
> +	struct eea_net_rx *rx;
> +	int i;
> +
> +	ctx->cfg = enet->cfg;
> +	ctx->rx = enet->rx;
> +	ctx->tx = enet->tx;
> +
> +	enet->rx = NULL;
> +	enet->tx = NULL;
> +
> +	for (i = 0; i < ctx->cfg.rx_ring_num; i++) {
> +		blk = &enet->irq_blks[i];
> +
> +		rx = ctx->rx[i];
> +
> +		rx->napi = NULL;
> +
> +		blk->rx = NULL;
> +	}
> +}
> +
> +static void eea_free_rxtx_q_mem(struct eea_net_init_ctx *ctx)
> +{
> +	struct eea_net_rx *rx;
> +	struct eea_net_tx *tx;
> +	int i;
> +
> +	for (i = 0; i < ctx->cfg.rx_ring_num; i++) {
> +		rx = ctx->rx[i];
> +		tx = &ctx->tx[i];
> +
> +		eea_free_rx(rx, &ctx->cfg);
> +		eea_free_tx(tx, &ctx->cfg);
> +	}
> +
> +	kvfree(ctx->rx);
> +	kvfree(ctx->tx);
> +}
> +
> +/* alloc tx/rx: struct, ring, meta, pp, napi */
> +static int eea_alloc_rxtx_q_mem(struct eea_net_init_ctx *ctx)
> +{
> +	struct eea_net_rx *rx;
> +	struct eea_net_tx *tx;
> +	int err, i;
> +
> +	ctx->tx = kvcalloc(ctx->cfg.tx_ring_num, sizeof(*ctx->tx), GFP_KERNEL);
> +	if (!ctx->tx)
> +		return -ENOMEM;
> +
> +	ctx->rx = kvcalloc(ctx->cfg.rx_ring_num, sizeof(*ctx->rx), GFP_KERNEL);
> +	if (!ctx->rx)
> +		goto err_free_tx;
> +
> +	ctx->cfg.rx_sq_desc_size = sizeof(struct eea_rx_desc);
> +	ctx->cfg.rx_cq_desc_size = sizeof(struct eea_rx_cdesc);
> +	ctx->cfg.tx_sq_desc_size = sizeof(struct eea_tx_desc);
> +	ctx->cfg.tx_cq_desc_size = sizeof(struct eea_tx_cdesc);
> +
> +	ctx->cfg.tx_cq_desc_size /= 2;
> +
> +	if (!ctx->cfg.split_hdr)
> +		ctx->cfg.rx_sq_desc_size /= 2;
> +
> +	for (i = 0; i < ctx->cfg.rx_ring_num; i++) {
> +		rx = eea_alloc_rx(ctx, i);
> +		if (!rx)
> +			goto err_free;
> +
> +		ctx->rx[i] = rx;
> +
> +		tx = ctx->tx + i;
> +		err = eea_alloc_tx(ctx, tx, i);
> +		if (err)
> +			goto err_free;
> +	}
> +
> +	return 0;
> +
> +err_free:
> +	for (i = 0; i < ctx->cfg.rx_ring_num; i++) {
> +		rx = ctx->rx[i];
> +		tx = ctx->tx + i;
> +
> +		eea_free_rx(rx, &ctx->cfg);
> +		eea_free_tx(tx, &ctx->cfg);
> +	}
> +
> +	kvfree(ctx->rx);
> +
> +err_free_tx:
> +	kvfree(ctx->tx);
> +	return -ENOMEM;
> +}
> +
> +static int eea_hw_active_ring(struct eea_net *enet)
> +{
> +	return eea_adminq_create_q(enet, /* qidx = */ 0,
> +				   enet->cfg.rx_ring_num +
> +				   enet->cfg.tx_ring_num, 0);
> +}
> +
> +static int eea_hw_unactive_ring(struct eea_net *enet)
> +{
> +	int err;
> +
> +	err = eea_adminq_destroy_all_q(enet);
> +	if (err)
> +		netdev_warn(enet->netdev, "unactive rxtx ring failed.\n");
> +
> +	return err;
> +}
> +
> +/* stop rx napi, stop tx queue. */
> +static void eea_stop_rxtx(struct net_device *netdev)
> +{
> +	struct eea_net *enet = netdev_priv(netdev);
> +	int i;
> +
> +	netif_tx_disable(netdev);
> +
> +	for (i = 0; i < enet->cfg.rx_ring_num; i++)
> +		enet_rx_stop(enet->rx[i]);
> +
> +	netif_carrier_off(netdev);
> +}
> +
> +static void eea_start_rxtx(struct eea_net *enet)
> +{
> +	int i;
> +
> +	for (i = 0; i < enet->cfg.rx_ring_num; i++)
> +		enet_rx_start(enet->rx[i]);
> +
> +	netif_tx_start_all_queues(enet->netdev);
> +	netif_carrier_on(enet->netdev);
> +
> +	enet->started = true;
> +}
> +
> +static int eea_netdev_stop(struct net_device *netdev)
> +{
> +	struct eea_net *enet = netdev_priv(netdev);
> +	struct eea_net_init_ctx ctx;
> +
> +	/* This function can be called during device anomaly recovery. To
> +	 * prevent duplicate stop operations, the `started` flag is introduced
> +	 * for checking.
> +	 */
> +
> +	if (!enet->started) {
> +		netdev_warn(netdev, "eea netdev stop: but dev is not started.\n");
> +		return 0;
> +	}
> +
> +	eea_stop_rxtx(netdev);
> +	eea_hw_unactive_ring(enet);
> +	eea_unbind_q_and_cfg(enet, &ctx);
> +	eea_free_rxtx_q_mem(&ctx);
> +
> +	enet->started = false;
> +
> +	return 0;
> +}
> +
> +static int eea_netdev_open(struct net_device *netdev)
> +{
> +	struct eea_net *enet = netdev_priv(netdev);
> +	struct eea_net_init_ctx ctx;
> +	int err;
> +
> +	if (enet->link_err) {
> +		netdev_err(netdev, "netdev open err, because link error: %d\n",
> +			   enet->link_err);
> +		return -EBUSY;
> +	}
> +
> +	eea_init_ctx(enet, &ctx);
> +
> +	err = eea_alloc_rxtx_q_mem(&ctx);
> +	if (err)
> +		goto err_done;
> +
> +	eea_bind_q_and_cfg(enet, &ctx);
> +
> +	err = eea_update_queues(enet);
> +	if (err)
> +		goto err_free_q;
> +
> +	err = eea_hw_active_ring(enet);
> +	if (err)
> +		goto err_free_q;
> +
> +	eea_start_rxtx(enet);
> +
> +	return 0;
> +
> +err_free_q:
> +	eea_unbind_q_and_cfg(enet, &ctx);
> +	eea_free_rxtx_q_mem(&ctx);
> +
> +err_done:
> +	return err;
> +}
> +
> +/* resources: ring, buffers, irq */
> +int eea_reset_hw_resources(struct eea_net *enet, struct eea_net_init_ctx *ctx)
> +{
> +	struct eea_net_init_ctx ctx_old = {0};
> +	int err, error;
> +
> +	if (!netif_running(enet->netdev) || !enet->started) {
> +		enet->cfg = ctx->cfg;
> +		return 0;
> +	}
> +
> +	err = eea_alloc_rxtx_q_mem(ctx);
> +	if (err) {
> +		netdev_warn(enet->netdev,
> +			    "eea reset: alloc q failed. stop reset. err %d\n",
> +			    err);
> +		return err;
> +	}
> +
> +	eea_stop_rxtx(enet->netdev);
> +	eea_hw_unactive_ring(enet);
> +
> +	eea_unbind_q_and_cfg(enet, &ctx_old);
> +	eea_bind_q_and_cfg(enet, ctx);
> +
> +	err = eea_update_queues(enet);
> +	if (err) {
> +		netdev_err(enet->netdev,
> +			   "eea reset: set real num queues failed. err %d\n",
> +			   err);
> +		goto err_bind_old;
> +	}
> +
> +	err = eea_hw_active_ring(enet);

AFAICS the need for admins queue destroy and recreation on cfg change is
what prevents a safe configuration swap (together with irq allocation,
see below). Could you instead keep the admin queue always alive i.e.
with maximum number of erings configured, and just enable/them as needded?

If not, please document explicitly the constraint in the commit message.

[...]
> @@ -140,14 +591,65 @@ static struct eea_net *eea_netdev_alloc(struct eea_device *edev, u32 pairs)
>  	enet->edev = edev;
>  	edev->enet = enet;
>  
> +	err = eea_alloc_irq_blks(enet, pairs);
> +	if (err) {

I'm likely lost, but AFAICS eea_alloc_irq_blks() is invoked only here,
and allocates edev->rx_num interrupts. rx_num is the number of RX
channel at device probe time.

set_channels can later change such value, i.e. increasing it. But I
don't see other irqs allocated.

Also the irq handler takes a direct pointer to the napi struct, as
opposed to Jakub's suggestion of using a ptr to a p

> +		dev_err(edev->dma_dev,
> +			"eea_alloc_irq_blks failed with pairs %d\n", pairs);
> +		free_netdev(netdev);
> +		return NULL;
> +	}
> +
>  	return enet;
>  }
>  
> +static void eea_update_ts_off(struct eea_device *edev, struct eea_net *enet)
> +{
> +	u64 ts;
> +
> +	ts = eea_pci_device_ts(edev);
> +
> +	enet->hw_ts_offset = ktime_get_real() - ts;
> +}
> +
> +static int eea_net_reprobe(struct eea_device *edev)
> +{
> +	struct eea_net *enet = edev->enet;
> +	int err = 0;
> +
> +	enet->edev = edev;
> +
> +	if (!enet->adminq.ring) {
> +		err = eea_create_adminq(enet, edev->rx_num + edev->tx_num);
> +		if (err)
> +			return err;
> +	}
> +
> +	err = eea_alloc_irq_blks(enet, edev->rx_num);
> +	if (err) {
> +		eea_destroy_adminq(enet);
> +		return -ENOMEM;
> +	}
> +
> +	eea_update_ts_off(edev, enet);
> +
> +	if (edev->ha_reset_netdev_running) {
> +		rtnl_lock();
> +		enet->link_err = 0;
> +		err = eea_netdev_open(enet->netdev);
> +		rtnl_unlock();
> +	}
> +
> +	return err;
> +}
> +
>  int eea_net_probe(struct eea_device *edev)
>  {
>  	struct eea_net *enet;
>  	int err = -ENOMEM;
>  
> +	if (edev->ha_reset)
> +		return eea_net_reprobe(edev);
> +
>  	enet = eea_netdev_alloc(edev, edev->rx_num);
>  	if (!enet)
>  		return -ENOMEM;
> @@ -168,6 +670,7 @@ int eea_net_probe(struct eea_device *edev)
>  	if (err)
>  		goto err_reset_dev;
>  
> +	eea_update_ts_off(edev, enet);
>  	netif_carrier_off(enet->netdev);
>  
>  	netdev_dbg(enet->netdev, "eea probe success.\n");
> @@ -179,10 +682,29 @@ int eea_net_probe(struct eea_device *edev)
>  	eea_destroy_adminq(enet);
>  
>  err_free_netdev:
> +	eea_free_irq_blk(enet);
>  	free_netdev(enet->netdev);
>  	return err;
>  }
>  
> +static void eea_net_ha_reset_remove(struct eea_net *enet,
> +				    struct eea_device *edev,
> +				    struct net_device *netdev)
> +{
> +	rtnl_lock();
> +	edev->ha_reset_netdev_running = false;
> +	if (netif_running(enet->netdev)) {
> +		eea_netdev_stop(enet->netdev);
> +		enet->link_err = EEA_LINK_ERR_HA_RESET_DEV;
> +		edev->ha_reset_netdev_running = true;
> +	}
> +	rtnl_unlock();
> +
> +	eea_device_reset(edev);
> +	eea_destroy_adminq(enet);
> +	eea_free_irq_blk(enet);
> +}
> +
>  void eea_net_remove(struct eea_device *edev)
>  {
>  	struct net_device *netdev;
> @@ -191,12 +713,16 @@ void eea_net_remove(struct eea_device *edev)
>  	enet = edev->enet;
>  	netdev = enet->netdev;
>  
> +	if (edev->ha_reset) {
> +		eea_net_ha_reset_remove(enet, edev, netdev);
> +		return;
> +	}
> +
>  	unregister_netdev(netdev);
> -	netdev_dbg(enet->netdev, "eea removed.\n");
>  
>  	eea_device_reset(edev);
> -
>  	eea_destroy_adminq(enet);
> +	eea_free_irq_blk(enet);
>  
>  	free_netdev(netdev);
>  }
> diff --git a/drivers/net/ethernet/alibaba/eea/eea_net.h b/drivers/net/ethernet/alibaba/eea/eea_net.h
> index ab487bc88af2..0398e781dfdb 100644
> --- a/drivers/net/ethernet/alibaba/eea/eea_net.h
> +++ b/drivers/net/ethernet/alibaba/eea/eea_net.h
> @@ -18,6 +18,8 @@
>  #define EEA_VER_MINOR		0
>  #define EEA_VER_SUB_MINOR	0
>  
> +struct eea_tx_meta;
> +
>  struct eea_net_tx {
>  	struct eea_net *enet;
>  
> @@ -101,6 +103,18 @@ struct eea_net_cfg {
>  	u8 tx_cq_desc_size;
>  
>  	u32 split_hdr;
> +
> +	struct hwtstamp_config ts_cfg;
> +};
> +
> +struct eea_net_init_ctx {
> +	struct eea_net_cfg cfg;
> +
> +	struct eea_net_tx *tx;
> +	struct eea_net_rx **rx;
> +
> +	struct net_device *netdev;
> +	struct eea_device *edev;
>  };
>  
>  enum {
> @@ -109,6 +123,17 @@ enum {
>  	EEA_LINK_ERR_LINK_DOWN,
>  };
>  
> +struct eea_irq_blk {
> +	struct napi_struct napi;
> +	u16 msix_vec;
> +	bool ready;
> +	struct eea_net_rx *rx;
> +	char irq_name[32];
> +	int irq;
> +	int idx;
> +
> +};
> +
>  struct eea_net {
>  	struct eea_device *edev;
>  	struct net_device *netdev;
> @@ -121,6 +146,8 @@ struct eea_net {
>  	struct eea_net_cfg cfg;
>  	struct eea_net_cfg cfg_hw;
>  
> +	struct eea_irq_blk *irq_blks;
> +
>  	u32 link_err;
>  
>  	bool started;
> @@ -134,4 +161,22 @@ struct eea_net {
>  int eea_net_probe(struct eea_device *edev);
>  void eea_net_remove(struct eea_device *edev);
>  
> +int eea_reset_hw_resources(struct eea_net *enet, struct eea_net_init_ctx *ctx);
> +void eea_init_ctx(struct eea_net *enet, struct eea_net_init_ctx *ctx);
> +int eea_queues_check_and_reset(struct eea_device *edev);
> +
> +/* rx apis */
> +void enet_rx_stop(struct eea_net_rx *rx);
> +void enet_rx_start(struct eea_net_rx *rx);
> +
> +void eea_free_rx(struct eea_net_rx *rx, struct eea_net_cfg *cfg);
> +struct eea_net_rx *eea_alloc_rx(struct eea_net_init_ctx *ctx, u32 idx);
> +
> +/* tx apis */
> +int eea_poll_tx(struct eea_net_tx *tx, int budget);
> +netdev_tx_t eea_tx_xmit(struct sk_buff *skb, struct net_device *netdev);
> +
> +void eea_free_tx(struct eea_net_tx *tx, struct eea_net_cfg *cfg);
> +int eea_alloc_tx(struct eea_net_init_ctx *ctx, struct eea_net_tx *tx, u32 idx);
> +
>  #endif
> diff --git a/drivers/net/ethernet/alibaba/eea/eea_pci.c b/drivers/net/ethernet/alibaba/eea/eea_pci.c
> index 97efac753cfb..e42b0298eebb 100644
> --- a/drivers/net/ethernet/alibaba/eea/eea_pci.c
> +++ b/drivers/net/ethernet/alibaba/eea/eea_pci.c
> @@ -13,6 +13,9 @@
>  
>  #define EEA_PCI_DB_OFFSET 4096
>  
> +#define EEA_PCI_CAP_RESET_DEVICE 0xFA
> +#define EEA_PCI_CAP_RESET_FLAG BIT(1)
> +
>  struct eea_pci_cfg {
>  	__le32 reserve0;
>  	__le32 reserve1;
> @@ -51,6 +54,7 @@ struct eea_pci_device {
>  	void __iomem *reg;
>  	void __iomem *db_base;
>  
> +	struct work_struct ha_handle_work;
>  	char ha_irq_name[32];
>  	u8 reset_pos;
>  };
> @@ -67,6 +71,11 @@ struct eea_pci_device {
>  #define cfg_read32(reg, item) ioread32(cfg_pointer(reg, item))
>  #define cfg_readq(reg, item) readq(cfg_pointer(reg, item))
>  
> +/* Due to circular references, we have to add function definitions here. */
> +static int __eea_pci_probe(struct pci_dev *pci_dev,
> +			   struct eea_pci_device *ep_dev);
> +static void __eea_pci_remove(struct pci_dev *pci_dev, bool flush_ha_work);
> +
>  const char *eea_pci_name(struct eea_device *edev)
>  {
>  	return pci_name(edev->ep_dev->pci_dev);
> @@ -250,6 +259,150 @@ void eea_pci_active_aq(struct eea_ring *ering, int msix_vec)
>  				    cfg_read32(ep_dev->reg, aq_db_off));
>  }
>  
> +void eea_pci_free_irq(struct eea_irq_blk *blk)
> +{
> +	irq_update_affinity_hint(blk->irq, NULL);
> +	free_irq(blk->irq, blk);
> +}
> +
> +int eea_pci_request_irq(struct eea_device *edev, struct eea_irq_blk *blk,
> +			irqreturn_t (*callback)(int irq, void *data))
> +{
> +	struct eea_pci_device *ep_dev = edev->ep_dev;
> +	int irq;
> +
> +	snprintf(blk->irq_name, sizeof(blk->irq_name), "eea-q%d@%s", blk->idx,
> +		 pci_name(ep_dev->pci_dev));
> +
> +	irq = pci_irq_vector(ep_dev->pci_dev, blk->msix_vec);
> +
> +	blk->irq = irq;
> +
> +	return request_irq(irq, callback, IRQF_NO_AUTOEN, blk->irq_name, blk);
> +}
> +
> +static void eea_ha_handle_reset(struct eea_pci_device *ep_dev)
> +{
> +	struct eea_device *edev;
> +	struct pci_dev *pci_dev;
> +	u16 reset;
> +	int err;
> +
> +	if (!ep_dev->reset_pos) {
> +		eea_queues_check_and_reset(&ep_dev->edev);
> +		return;
> +	}
> +
> +	edev = &ep_dev->edev;
> +
> +	pci_read_config_word(ep_dev->pci_dev, ep_dev->reset_pos, &reset);
> +
> +	/* clear bit */
> +	pci_write_config_word(ep_dev->pci_dev, ep_dev->reset_pos, 0xFFFF);
> +
> +	if (reset & EEA_PCI_CAP_RESET_FLAG) {
> +		dev_warn(&ep_dev->pci_dev->dev, "recv device reset request.\n");
> +
> +		pci_dev = ep_dev->pci_dev;
> +
> +		/* The pci remove callback may hold this lock. If the
> +		 * pci remove callback is called, then we can ignore the
> +		 * ha interrupt.
> +		 */
> +		if (mutex_trylock(&edev->ha_lock)) {
> +			edev->ha_reset = true;
> +
> +			__eea_pci_remove(pci_dev, false);
> +			err = __eea_pci_probe(pci_dev, ep_dev);
> +			if (err)
> +				dev_err(&ep_dev->pci_dev->dev,
> +					"ha: re-setup failed.\n");

AI still notes:
---
What happens if __eea_pci_probe() fails during HA reset recovery? Jakub
Kicinski's AI review in v25 noted that when probe fails after remove
succeeded, the device is left in a removed state with no error beyond this
single dev_err() message.

The function returns 1 (from the implicit flow) indicating success, even
though reprobe failed and the device is now non-functional. Should this
check
for errors and at minimum log the failure state more prominently?

Reference:
https://lore.kernel.org/netdev/20260204040054.1698677-2-kuba@kernel.org/
---


