Return-Path: <netdev+bounces-126911-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id C2402972E54
	for <lists+netdev@lfdr.de>; Tue, 10 Sep 2024 11:42:16 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 7FF73287AD0
	for <lists+netdev@lfdr.de>; Tue, 10 Sep 2024 09:42:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5454618D64E;
	Tue, 10 Sep 2024 09:41:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="Cq24zBmm"
X-Original-To: netdev@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AE89C18C932
	for <netdev@vger.kernel.org>; Tue, 10 Sep 2024 09:41:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725961280; cv=none; b=DiTQU6YXGkUgiyfvWsMmZA8mZEml6Amt+x+M+qkNgieE7zg6R75vG3kG3o6m8lOi7AyF7x4ZK3F01JmL7WEcXCq3ccz3zQhIWPruv7jNPMKoUixBVZyYi8q4C//GbMFYaCEGDlQTGgCWzcYR52d5xYA8CjiBZfPeYZKbolDeeLE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725961280; c=relaxed/simple;
	bh=DykOP0GmIn4GVdryQvldTFp7Scbm7z6qv/XJ3V/veHU=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=PyTQFGkOwK/w/FA3K1sp03KSdzyeGEcQfqcpZmDTntwaPRGWx3AKX2uKsJwsLn8WotU+PZDTLBa/xwB3eX/qhHN87wtIPYDNK4UqBkCMdMrW3g1ZU/6wZIPsd2OxWOgMmVZVgjKB6UTn8ksUn62fatUyx4iQZYpSS9UEpPy6/Xc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=Cq24zBmm; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1725961277;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=SqUMNjfQs5Iu02+GukJzTHIzHLUxHpQRKRcR4WnGu9w=;
	b=Cq24zBmm0NGMCb1MZtVpaPGQu9HMDt4DkAwevxxhuizQ+YCLc1BcHB0okPgbMiVKwhp2PA
	99TnZxB8POfKfPIleX1GDPk98nFWfYkJBodjv5NmEQp/lj2LY2loA8IXgOOcym+X07WDlH
	iOJM3OAYYcCUnw3w7rStrx7LfcNMM7Y=
Received: from mail-wm1-f70.google.com (mail-wm1-f70.google.com
 [209.85.128.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-573-2kIwh5ZhMZ-9RoMwvvEzGg-1; Tue, 10 Sep 2024 05:41:16 -0400
X-MC-Unique: 2kIwh5ZhMZ-9RoMwvvEzGg-1
Received: by mail-wm1-f70.google.com with SMTP id 5b1f17b1804b1-42cb5b01c20so16851475e9.1
        for <netdev@vger.kernel.org>; Tue, 10 Sep 2024 02:41:16 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1725961275; x=1726566075;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=SqUMNjfQs5Iu02+GukJzTHIzHLUxHpQRKRcR4WnGu9w=;
        b=lptejZNsXww3YSZTytHODrC1kAOlDhEM2qb4ECGrlWJCmhUKouNURr3DzvYLrK69to
         eqvqxItK4TguRtJ5WhA117PBm0nLSn4PFZoN0tEE/eexzbK9kK1FVI22xB31NaRkUdsp
         2jIHRI5VUDj4UfFY1oSPQAMLUbCC4Ne2xhfdIDGbH9c1L1YYFDwwUhe01fNxEcZfCHvh
         uQABwda+boGzBASrwEI4OphP03Lh8nwYvAib7WXcLNkCa4C+3lKE2+hV8WSNYGX/J/7O
         h+YlBUNLqWNdKDm5QHJ0SKP/0JuEQ0Yyfs5AW2TEQEXEfI9UC557wcMfGhirhlntl5pE
         zt6w==
X-Forwarded-Encrypted: i=1; AJvYcCX0afHiiFl9PI+0aex7XqqphtO04OIJn3OgU4L/x5pMdrjPX7jcmCl3RlFJflSwIFBOKCstuqQ=@vger.kernel.org
X-Gm-Message-State: AOJu0Yy6B47JVTE/Du6TfVK40je0eelE1CCneJVRwLqh1abhz7X6kxJX
	Zq0lo1r/iMu4mTztgPYSlVEuj2Je+CI8DOCi3Z+gKsDMQH3SduwUIo/vvDdcvp8xM+0DfpUyhYJ
	f99S2M4J7r1VnlDyXz8SFJJR2Cs9+L2jeEz4bCoPZxNiMZO8XuOeBOWD/hjY7mDbC
X-Received: by 2002:a05:600c:1385:b0:42b:892d:54c0 with SMTP id 5b1f17b1804b1-42c9f97de8dmr87828935e9.12.1725961274937;
        Tue, 10 Sep 2024 02:41:14 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IGHB/azzGs1se//4AVjkYy8KLuUDEvuyu3UvaFCkZFJtXmeKm2kktKHKACCP84fIu4JeFBKsw==
X-Received: by 2002:a05:600c:1385:b0:42b:892d:54c0 with SMTP id 5b1f17b1804b1-42c9f97de8dmr87828625e9.12.1725961274412;
        Tue, 10 Sep 2024 02:41:14 -0700 (PDT)
Received: from [192.168.88.27] (146-241-69-130.dyn.eolo.it. [146.241.69.130])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-42ca05c6340sm140968805e9.4.2024.09.10.02.41.12
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 10 Sep 2024 02:41:13 -0700 (PDT)
Message-ID: <d58d7b9a-ae20-4c07-af17-425cbdfd861b@redhat.com>
Date: Tue, 10 Sep 2024 11:41:11 +0200
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [net-next PATCH v2 2/4] octeontx2-pf: Add new APIs for queue
 memory alloc/free.
To: Geetha sowjanya <gakula@marvell.com>, netdev@vger.kernel.org,
 linux-kernel@vger.kernel.org
Cc: kuba@kernel.org, davem@davemloft.net, jiri@resnulli.us,
 edumazet@google.com, sgoutham@marvell.com, sbhatta@marvell.com,
 hkelam@marvell.com
References: <20240905094935.26271-1-gakula@marvell.com>
 <20240905094935.26271-3-gakula@marvell.com>
Content-Language: en-US
From: Paolo Abeni <pabeni@redhat.com>
In-Reply-To: <20240905094935.26271-3-gakula@marvell.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 9/5/24 11:49, Geetha sowjanya wrote:
> Group the queue(RX/TX/CQ) memory allocation and free code to single APIs.
> 
> Signed-off-by: Geetha sowjanya <gakula@marvell.com>
> ---
>   .../marvell/octeontx2/nic/otx2_common.h       |  2 +
>   .../ethernet/marvell/octeontx2/nic/otx2_pf.c  | 54 +++++++++++++------
>   2 files changed, 40 insertions(+), 16 deletions(-)
> 
> diff --git a/drivers/net/ethernet/marvell/octeontx2/nic/otx2_common.h b/drivers/net/ethernet/marvell/octeontx2/nic/otx2_common.h
> index a47001a2b93f..df548aeffecf 100644
> --- a/drivers/net/ethernet/marvell/octeontx2/nic/otx2_common.h
> +++ b/drivers/net/ethernet/marvell/octeontx2/nic/otx2_common.h
> @@ -997,6 +997,8 @@ int otx2_pool_init(struct otx2_nic *pfvf, u16 pool_id,
>   int otx2_aura_init(struct otx2_nic *pfvf, int aura_id,
>   		   int pool_id, int numptrs);
>   int otx2_init_rsrc(struct pci_dev *pdev, struct otx2_nic *pf);
> +void otx2_free_queue_mem(struct otx2_qset *qset);
> +int otx2_alloc_queue_mem(struct otx2_nic *pf);
>   
>   /* RSS configuration APIs*/
>   int otx2_rss_init(struct otx2_nic *pfvf);
> diff --git a/drivers/net/ethernet/marvell/octeontx2/nic/otx2_pf.c b/drivers/net/ethernet/marvell/octeontx2/nic/otx2_pf.c
> index 4cfeca5ca626..6dfd6d1064ad 100644
> --- a/drivers/net/ethernet/marvell/octeontx2/nic/otx2_pf.c
> +++ b/drivers/net/ethernet/marvell/octeontx2/nic/otx2_pf.c
> @@ -1770,15 +1770,23 @@ static void otx2_dim_work(struct work_struct *w)
>   	dim->state = DIM_START_MEASURE;
>   }
>   
> -int otx2_open(struct net_device *netdev)
> +void otx2_free_queue_mem(struct otx2_qset *qset)
> +{
> +	kfree(qset->sq);
> +	qset->sq = NULL;
> +	kfree(qset->cq);
> +	qset->cq = NULL;
> +	kfree(qset->rq);
> +	qset->rq = NULL;
> +	kfree(qset->napi);

It's strange that the napi ptr is not reset here. You should add a 
comment describing the reason or zero such field, too.

Thanks,

Paolo


