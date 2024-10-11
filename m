Return-Path: <netdev+bounces-134533-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 008A899A022
	for <lists+netdev@lfdr.de>; Fri, 11 Oct 2024 11:26:20 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id A2A8E285146
	for <lists+netdev@lfdr.de>; Fri, 11 Oct 2024 09:26:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4B35220CCC8;
	Fri, 11 Oct 2024 09:26:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="L84q4j1E"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pl1-f171.google.com (mail-pl1-f171.google.com [209.85.214.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C7B601F942F;
	Fri, 11 Oct 2024 09:26:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728638774; cv=none; b=dK3kbp1OD81Vdo4xBOUIF65S5GU/zQgJkQydvLmjZsT3bBcfoAfRyLrhRB2YDNm1wY3T9DaanUnp7jZBgrVIHd6Zan8Q5R1FjwpHG5s+SzWn7OfTMunm1TdCtVYv07iAlaI2nc2vT/4B8fhcdEJpKwBVpcFxWjC2l3EOkuvXUBY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728638774; c=relaxed/simple;
	bh=0JZEa30zw3PPcL/DVddTSy6dEGgoUXxbAN+8nDTk8NE=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=NBxeN51IOIrVN95S8H9nhKC9bBMPkpfvba+H6SB/VAQUJVy3KtorCASIozhWwBNn4FJPsg0aE37Za4ak/Z6THIzWAbT3Q3Fov4W5YRLUW7Ij66vQi5Ujtad+knzX+v9BSCTeVrVBVc5UobcYgI/72k2gaqr2fDsDVN7M+u56IF8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=L84q4j1E; arc=none smtp.client-ip=209.85.214.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f171.google.com with SMTP id d9443c01a7336-20bc2970df5so14558545ad.3;
        Fri, 11 Oct 2024 02:26:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1728638772; x=1729243572; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:subject:cc:to:from:date:from:to:cc:subject:date
         :message-id:reply-to;
        bh=dWzersFr/wVsYoAvihIjoT0wE8hmLxZ8cWMhmFp8KNI=;
        b=L84q4j1EFQdT4EBJ44DGsV1PUPnZ33DvsbwT/4lqmw8kSkL5B1/DJn6lRVX8gEZlmA
         J4+6PQRPgEYtwcRZnj5EXiVqeKcgLSbv/2kXE+CiiT8vRaX8Qs2ARYm/VxymN7a8rjw5
         S2vCmQQJsS3VwnxGofp3e64KyTLOZjnY0hLHUZ7G5uoSqaq6080LE6sY3bBDBxolkpn5
         03Y978ccCYAnmSr2noNqOS6XfWeo8+BjDOc6BC/Fro8tzDq/ESst/JCi8Y1rkPQpr7bu
         qisJMwN2nDAB3WJEyVPRtcN5E+/fiTPgwVCdm07NNAvFHLC4HG+H873Tnh3IZ+LKHpYq
         3/tw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1728638772; x=1729243572;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:subject:cc:to:from:date:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=dWzersFr/wVsYoAvihIjoT0wE8hmLxZ8cWMhmFp8KNI=;
        b=DcEFq7io6ydsmxYsc0PRKS7g+KtVJg4d4DfZST9nb+vlDfKoTc6HRGJ8/tspAGWnol
         fq3YjzWG+Vrs5fnfmnuOrhyyVc83NVxFCA+ZuMjfYZIOmaNdNc7cF75IaSJpdAeBxyS1
         yD1SxFVgnbbXULp01NszNDo5FedM7XU/J6ivAjLuBdvyOz9LYK4C1dw9MZ5brQNfPxl1
         xiMjBz9LzylEkkEOLyVDPCzmdTOYz95YSP8uZsnewMccanCF+Y6dXAismQpqEzYSYHso
         bbYwx0JTWQN9Ni0q2PNg1lTsNxgj4nu1ax296IF/IhH9MVSzjWfw/lOSddk1mg8S7FCi
         bAxg==
X-Forwarded-Encrypted: i=1; AJvYcCVvbIsK85CjfUUkKF53jkaT/7qT3mzaTBYdfkxAa3brZsJr4Zw0iln9/kmP6w7lme7JOiaFGCZo@vger.kernel.org, AJvYcCWrWjuC2y96AXg+6asLNAa7j6jcJRoJ36hI6O/+IBMz+g2ImP8bHPwSKhxPaPQmRiPWmZeXDeQrS4pkfD0=@vger.kernel.org
X-Gm-Message-State: AOJu0YwJnl4eoWO1BtMOWjh9ECHFV/6+7AHVeZhDqtuEtt05d+fD8YiC
	pecB4VOEs+CEnwgMyWHLQWt25Lyn5ek8uZCcdfvXKE41HvW+l7oW
X-Google-Smtp-Source: AGHT+IGzNaItIs7FPB7yAcQsKEDGesNKzGVBIjzitVu55tYyJFsMZZMkw5eMxIwUw0uwkdiW0uPC2A==
X-Received: by 2002:a17:902:ce8d:b0:20b:b794:b39f with SMTP id d9443c01a7336-20ca147fa3cmr29851265ad.30.1728638771991;
        Fri, 11 Oct 2024 02:26:11 -0700 (PDT)
Received: from localhost ([129.146.253.192])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-20c8bad99d2sm20511615ad.31.2024.10.11.02.26.08
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 11 Oct 2024 02:26:11 -0700 (PDT)
Date: Fri, 11 Oct 2024 17:26:05 +0800
From: Furong Xu <0x1207@gmail.com>
To: Yunsheng Lin <linyunsheng@huawei.com>, Jakub Kicinski <kuba@kernel.org>
Cc: Ilias Apalodimas <ilias.apalodimas@linaro.org>,
 <netdev@vger.kernel.org>, <linux-kernel@vger.kernel.org>, "Jesper Dangaard
 Brouer" <hawk@kernel.org>, "David S. Miller" <davem@davemloft.net>, "Eric
 Dumazet" <edumazet@google.com>, Paolo Abeni <pabeni@redhat.com>,
 <xfr@outlook.com>
Subject: Re: [PATCH net-next v1] page_pool: check for dma_sync_size earlier
Message-ID: <20241011172605.0000142f@gmail.com>
In-Reply-To: <21036339-3eeb-4606-9a84-d36bddba2b31@huawei.com>
References: <20241010114019.1734573-1-0x1207@gmail.com>
	<601d59f4-d554-4431-81ca-32bb02fb541f@huawei.com>
	<20241011101455.00006b35@gmail.com>
	<CAC_iWjL7Z6qtOkxXFRUnnOruzQsBNoKeuZ1iStgXJxTJ_P9Axw@mail.gmail.com>
	<20241011143158.00002eca@gmail.com>
	<21036339-3eeb-4606-9a84-d36bddba2b31@huawei.com>
X-Mailer: Claws Mail 4.3.0 (GTK 3.24.42; x86_64-w64-mingw32)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

Hi Jakub,

On Fri, 11 Oct 2024 16:55:34 +0800, Yunsheng Lin <linyunsheng@huawei.com> wrote:

> On 2024/10/11 14:31, Furong Xu wrote:
> > Hi Ilias,
> > 
> > On Fri, 11 Oct 2024 08:06:04 +0300, Ilias Apalodimas <ilias.apalodimas@linaro.org> wrote:
> >   
> >> Hi Furong,
> >>
> >> On Fri, 11 Oct 2024 at 05:15, Furong Xu <0x1207@gmail.com> wrote:  
> >>>
> >>> On Thu, 10 Oct 2024 19:53:39 +0800, Yunsheng Lin <linyunsheng@huawei.com> wrote:
> >>>    
> >>>> Is there any reason that those drivers not to unset the PP_FLAG_DMA_SYNC_DEV
> >>>> when calling page_pool_create()?
> >>>> Does it only need dma sync for some cases and not need dma sync for other
> >>>> cases? if so, why not do the dma sync in the driver instead?    
> >>>
> >>> The answer is in this commit:
> >>> https://git.kernel.org/netdev/net/c/5546da79e6cc    
> >>
> >> I am not sure I am following. Where does the stmmac driver call a sync
> >> with len 0?  
> > For now, only drivers/net/ethernet/freescale/fec_main.c does.
> > And stmmac driver does not yet, but I will send another patch to make it call sync with
> > len 0. This is a proper fix as Jakub Kicinski suggested.  
> 
> In order to support the above use case, it seems there might be two
> options here:
> 1. Driver calls page_pool_create() without PP_FLAG_DMA_SYNC_DEV and
>    handle the dma sync itself.
> 2. Page_pool may provides a non-dma-sync version of page_pool_put_page()
>    API even when Driver calls page_pool_create() with PP_FLAG_DMA_SYNC_DEV.
> 
> Maybe option 2 is better one in the longer term as it may provide some
> flexibility for the user and enable removing of the DMA_SYNC_DEV in the
> future?

What is your opinion about this?
Thanks.

