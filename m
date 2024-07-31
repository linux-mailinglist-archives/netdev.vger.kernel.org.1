Return-Path: <netdev+bounces-114594-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 028ED942FDA
	for <lists+netdev@lfdr.de>; Wed, 31 Jul 2024 15:14:15 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 267A41C21EF6
	for <lists+netdev@lfdr.de>; Wed, 31 Jul 2024 13:14:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id ABABC1B0136;
	Wed, 31 Jul 2024 13:14:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=fastly.com header.i=@fastly.com header.b="wajVT+5T"
X-Original-To: netdev@vger.kernel.org
Received: from mail-wm1-f44.google.com (mail-wm1-f44.google.com [209.85.128.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1903F1A7F73
	for <netdev@vger.kernel.org>; Wed, 31 Jul 2024 13:14:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722431646; cv=none; b=ilQ0yBaqWMDmLekhyHkZR8a+mKYFzfdrJcMv4LbnQ9GqWkMDWSZI6uaVhVUNjeIPw7G1Eov4kZndPbUpMWFSqL4T0SWwi4H026jA/gVcbQoPPJ7K68Wi3B/0qm1Mr9ZnHavV75Papt+4ZeN3pLugbXru+i6WiNr1MhPDNeA56gw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722431646; c=relaxed/simple;
	bh=dRUl5uO2/1w2AkZ6UsxlBKx5HK2elVKj2ZXm6+VDf4E=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=RPgW2mWUGZOEsVcUgFMha87cEsP0abQKldaLv9gphsXAErE3enGpdWLVFZrHzPtAD4InKIM5O/EdN2eZPpGVnihbwXhn0yOGIEnxbRSZ93m9qgnJSOIlipkSNeZnlarFWzjeeoGhAbvR+wTvmyMwpQXeb+lSty4zMvARGIZZKmo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=fastly.com; spf=pass smtp.mailfrom=fastly.com; dkim=pass (1024-bit key) header.d=fastly.com header.i=@fastly.com header.b=wajVT+5T; arc=none smtp.client-ip=209.85.128.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=fastly.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=fastly.com
Received: by mail-wm1-f44.google.com with SMTP id 5b1f17b1804b1-4266dc7591fso34704135e9.0
        for <netdev@vger.kernel.org>; Wed, 31 Jul 2024 06:14:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=fastly.com; s=google; t=1722431642; x=1723036442; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references
         :mail-followup-to:message-id:subject:cc:to:from:date:from:to:cc
         :subject:date:message-id:reply-to;
        bh=zj5Jtjusxp7Zt+Ae/Nq1thR0rw87CuLNCK2IcHdr3Uo=;
        b=wajVT+5TXV0E7emE5d59vtD5Rhl6FReKntrFjykdVUePrHb/s1UqvIgaM2fKPqVO8E
         PTlJnnsfBXVRPxJFJjigmrta0CmaIXD5WdL69Y/VDAccY1WxeV8NFBJqr+g63OswXP8v
         hNhVjs1mE2UQLAnmRO0bmwZR/sUaCYoQXCi3E=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1722431642; x=1723036442;
        h=in-reply-to:content-disposition:mime-version:references
         :mail-followup-to:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=zj5Jtjusxp7Zt+Ae/Nq1thR0rw87CuLNCK2IcHdr3Uo=;
        b=eGzpOJMD+k7UduadQ6WJDPL9KsM+E8Z8hWpD9/zsIAohp8gLOoWetIRJ+2A3SqbwAA
         aDQGuBmXtx318bhG6OhBxhE6mAdhNaFD09aIuijE1qdO6/EOOZygBA74Eaa3WpkCR8qE
         /Ew9wcCjhxYbg7zq9l6ssykSENGzokmjylRctZF1tVrpcnO6bwL7RmL9zqpIHf40suWT
         +YOWFyerK2shfZv3gh7BF/wgEzndsQYkGm9iM+C5VIRtDKZ5zoaG9W12SiC9Os4LX18m
         fdHab+XmR7KE5duqfed0GmQQOeCiVuDWnALQDoLjHU+Ea44VmosJbvZOizMw4iIdS49l
         5Z5g==
X-Forwarded-Encrypted: i=1; AJvYcCVv1G3K1xKdvjTuBWiVrx2P1/eJvfdjXG9GhOQuMD47gG147gYRO6tz4MqUzVx5Uz2WROD4M+FIof7ZgaettBxmc3i40wcK
X-Gm-Message-State: AOJu0YzV3LJWCEGtlAlDkf+Lyj07hlAc5npM5GOVsDjx6tQVwzbYn0kU
	l0k5+f/Ypa2Oo0pmjuEhnmFUB9fFZptLrY9aqly4L06rPyl6mBcN29uZI8TXmnc=
X-Google-Smtp-Source: AGHT+IGQC6tx/MC7EYcFI4vcnmNoGD0rWPlisuiwk0XIMVJTZY/hSMJAQaLCHm1jOPqmt73OCmxsSw==
X-Received: by 2002:a05:600c:4f0f:b0:426:54c9:dfe5 with SMTP id 5b1f17b1804b1-42811d8c567mr100069335e9.10.1722431642409;
        Wed, 31 Jul 2024 06:14:02 -0700 (PDT)
Received: from LQ3V64L9R2 ([80.208.222.2])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-36b36862516sm16960019f8f.104.2024.07.31.06.14.01
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 31 Jul 2024 06:14:02 -0700 (PDT)
Date: Wed, 31 Jul 2024 14:14:00 +0100
From: Joe Damato <jdamato@fastly.com>
To: Jijie Shao <shaojijie@huawei.com>
Cc: yisen.zhuang@huawei.com, salil.mehta@huawei.com, davem@davemloft.net,
	edumazet@google.com, kuba@kernel.org, pabeni@redhat.com,
	horms@kernel.org, shenjian15@huawei.com, wangpeiyang1@huawei.com,
	liuyonglong@huawei.com, sudongming1@huawei.com,
	xujunsheng@huawei.com, shiyongbang@huawei.com,
	netdev@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [RFC PATCH net-next 04/10] net: hibmcge: Add interrupt supported
 in this module
Message-ID: <Zqo4mGq88BajjLk_@LQ3V64L9R2>
Mail-Followup-To: Joe Damato <jdamato@fastly.com>,
	Jijie Shao <shaojijie@huawei.com>, yisen.zhuang@huawei.com,
	salil.mehta@huawei.com, davem@davemloft.net, edumazet@google.com,
	kuba@kernel.org, pabeni@redhat.com, horms@kernel.org,
	shenjian15@huawei.com, wangpeiyang1@huawei.com,
	liuyonglong@huawei.com, sudongming1@huawei.com,
	xujunsheng@huawei.com, shiyongbang@huawei.com,
	netdev@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20240731094245.1967834-1-shaojijie@huawei.com>
 <20240731094245.1967834-5-shaojijie@huawei.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240731094245.1967834-5-shaojijie@huawei.com>

On Wed, Jul 31, 2024 at 05:42:39PM +0800, Jijie Shao wrote:
> The driver supports four interrupts: TX interrupt, RX interrupt,
> mdio interrupt, and error interrupt.
> 
> Actually, the driver does not use the mdio interrupt.
> Therefore, the driver does not request the mdio interrupt.

I might be reading this wrong, but the commit message seems a bit
confusing? If it's not used then why allocate it?

[...]

> ---
>  .../ethernet/hisilicon/hibmcge/hbg_common.h   |  20 ++
>  .../net/ethernet/hisilicon/hibmcge/hbg_hw.c   |  59 ++++++
>  .../net/ethernet/hisilicon/hibmcge/hbg_hw.h   |   8 +
>  .../net/ethernet/hisilicon/hibmcge/hbg_irq.c  | 189 ++++++++++++++++++
>  .../net/ethernet/hisilicon/hibmcge/hbg_irq.h  |  13 ++
>  .../net/ethernet/hisilicon/hibmcge/hbg_main.c |   9 +
>  .../net/ethernet/hisilicon/hibmcge/hbg_reg.h  |  34 ++++
>  .../hisilicon/hibmcge/hbg_reg_union.h         |  60 ++++++
>  8 files changed, 392 insertions(+)
>  create mode 100644 drivers/net/ethernet/hisilicon/hibmcge/hbg_irq.c
>  create mode 100644 drivers/net/ethernet/hisilicon/hibmcge/hbg_irq.h
 
[...]

> +
> +static const char *irq_names_map[HBG_VECTOR_NUM] = { "tx", "rx", "err", "mdio" };
> +
> +int hbg_irq_init(struct hbg_priv *priv)
> +{
> +	struct hbg_vector *vectors = &priv->vectors;
> +	struct hbg_irq *irq;
> +	int ret;
> +	int i;
> +
> +	ret = pci_alloc_irq_vectors(priv->pdev, HBG_VECTOR_NUM, HBG_VECTOR_NUM,
> +				    PCI_IRQ_MSI);

No MSI-X ?

This seems to request HBG_VECTOR_NUM (4) IRQs and errors out if ret
!= HBG_VECTOR_NUM, but ...

> +	if (ret < 0) {
> +		dev_err(&priv->pdev->dev,
> +			"failed to allocate MSI vectors, vectors = %d\n", ret);
> +		return ret;
> +	}
> +
> +	if (ret != HBG_VECTOR_NUM) {
> +		dev_err(&priv->pdev->dev,
> +			"requested %u MSI, but allocated %d MSI\n",
> +			HBG_VECTOR_NUM, ret);
> +		ret = -EINVAL;
> +		goto free_vectors;
> +	}
> +
> +	vectors->irqs = devm_kcalloc(&priv->pdev->dev, HBG_VECTOR_NUM,
> +				     sizeof(struct hbg_irq), GFP_KERNEL);
> +	if (!vectors->irqs) {
> +		ret = -ENOMEM;
> +		goto free_vectors;
> +	}
> +
> +	/* mdio irq not request */
> +	vectors->irq_count = HBG_VECTOR_NUM - 1;

Here the comment says mdio is not requested? But it does seem like
the IRQ is allocated above, it's just unused?

Maybe above you should remove mdio completely if its not in use?

Or is it used later in some other patch or something?

> +	for (i = 0; i < vectors->irq_count; i++) {
> +		irq = &vectors->irqs[i];
> +		snprintf(irq->name, sizeof(irq->name) - 1, "%s-%s-%s",
> +			 HBG_DEV_NAME, pci_name(priv->pdev), irq_names_map[i]);
> +
> +		irq->id = pci_irq_vector(priv->pdev, i);
> +		irq_set_status_flags(irq->id, IRQ_NOAUTOEN);
> +		ret = request_irq(irq->id, hbg_irq_handle,
> +				  0, irq->name, priv);
> +		if (ret) {
> +			dev_err(&priv->pdev->dev,
> +				"failed to requset irq(%d), ret = %d\n",
> +				irq->id, ret);
> +			goto free_vectors;
> +		}
> +	}
> +
> +	vectors->info_array = hbg_irqs;
> +	vectors->info_array_len = ARRAY_SIZE(hbg_irqs);
> +	return 0;
> +
> +free_vectors:
> +	hbg_irq_uninit(priv);
> +	return ret;
> +}

[...]


