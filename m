Return-Path: <netdev+bounces-134479-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 64963999BF4
	for <lists+netdev@lfdr.de>; Fri, 11 Oct 2024 07:06:49 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 3D4E11C20B8D
	for <lists+netdev@lfdr.de>; Fri, 11 Oct 2024 05:06:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CA78F1F4FDC;
	Fri, 11 Oct 2024 05:06:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="rtAru53S"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pj1-f49.google.com (mail-pj1-f49.google.com [209.85.216.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4DA791BFDF7
	for <netdev@vger.kernel.org>; Fri, 11 Oct 2024 05:06:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728623203; cv=none; b=fvKbRMDqCjp8osxEObGemw13yPxuS5c1cbPULnESGNU1xI8Ti4iRExJpXCupi4zJLTm9dpg9oYPQw9ASFgfFev1tTXsbn20LJXeGXcRnuCpZc5ia120utT+13hXzsWgFBcI9ma+UzILi3i8xKhM1uAZHYPoPGATwF/FWsF4YmVE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728623203; c=relaxed/simple;
	bh=J4uZD2ticb9y1gX4UfHAeWDZG2392fPdEO/lHgBL3nI=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=SiW7LRYYaKcfoYvljir6keyj9WgvrdCejC98FeDCVjoX7ho6dQTSlnFTFPYbnHxBnwJxgO7cdtO3mDL5GzEyi3mlgOHcvLvwqmaIRz0P8/SMC51YZhkDNGZaTKtxf17Xt+o9NC7KwxYN2iRU34wT+RSxayiEvSSKjhwvlwlHojQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=rtAru53S; arc=none smtp.client-ip=209.85.216.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-pj1-f49.google.com with SMTP id 98e67ed59e1d1-2e2a999b287so1443582a91.0
        for <netdev@vger.kernel.org>; Thu, 10 Oct 2024 22:06:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1728623201; x=1729228001; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=J4uZD2ticb9y1gX4UfHAeWDZG2392fPdEO/lHgBL3nI=;
        b=rtAru53SezxPsfcHOnV/8foj5dlkKpNsVzMcMbzDWT1QHADxIii0dy+k6d7zF6dLKd
         Xv9Hc3aTFP1t4eEbgWpXOpfBM6x2e3YE7USW78Z1Fb8Z2WyBdD9UOkBjf0ni5Fd511C4
         GZJayvLuVrFg1UUbDnwD+GY9/aCHANFEB9kiVKMCn2XiFeV7IYBj3h4U6UruZritdNag
         fP/37Af2QCuzmuCYqca2HZxEyJsiA6RcOwb+x6MD1A4/2eTJ/gr+NIKkQM7HXlkfZCF8
         axo8+DntxiHoTmwFX8ozIpCUJjA0Vxj12cvRzjbz5z8WxWKn+MGieoKgc0MqrpIFM9v/
         2wrA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1728623201; x=1729228001;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=J4uZD2ticb9y1gX4UfHAeWDZG2392fPdEO/lHgBL3nI=;
        b=tDdPsTfGCwkc8h3+Pz7Z0LoKebxPaPqDrxn8jht76KwwkNxnh7Kj5rctvlsFiiZus+
         CSXugihCo43tvG+BdOKCADwwkShzK/WC2O0JJ2A/Yx7vVJvqu0XrZ7jOlFInW4bzW16T
         +lkh32bLExI6mPklsjeeCidTKKA9X5oPCT7NTPABJhOlJJXaTLDCrbXEzQPIsXxfGJ0R
         Utkslwa+t/Nqd1QaHMERqpJoQtN7WrIqWJwlHYq10ctpZ3jEm/9+s4PTtkAjIKdeB2M6
         0QcLwWU/u9n6y2XG+87MXJYnCU4Fl3zoqEUo2qxPnr+RKiU9rq7SyW+kapAx7L99SQZ3
         45zA==
X-Forwarded-Encrypted: i=1; AJvYcCVP+n7Eph8OvEnhlimcy6xdLY54B76ebtIewmmHqlPtrXEDic/dxHA0/Im+8FERWbxTAQT0Dd8=@vger.kernel.org
X-Gm-Message-State: AOJu0YyhpA+OA1vBsah9427lAf9/P8jz9hlXyS/vkkAEjt0xKCIJj39e
	9b1tTvmXDtdw060uHB0rrHWs2Y9g9BqLnhq8UAeDfyjCeVOldqXr96fkNuv+MTzFriCdtIDR7wI
	FIV6GrlOhN03+j5+qdoyImHyEmB8/veaaBf6+033Jnu6bnKdsS6I=
X-Google-Smtp-Source: AGHT+IF2UKkZO/KPx4VxT3b3zp+LfxkUvgapEeMAwfLsk65H8dL6bieyuMdum17C7XC0R5hWpJnsr+i4U/WOUpCeWPU=
X-Received: by 2002:a17:90b:d97:b0:2e2:ebbb:7619 with SMTP id
 98e67ed59e1d1-2e2f0ab98cfmr1883401a91.9.1728623201577; Thu, 10 Oct 2024
 22:06:41 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20241010114019.1734573-1-0x1207@gmail.com> <601d59f4-d554-4431-81ca-32bb02fb541f@huawei.com>
 <20241011101455.00006b35@gmail.com>
In-Reply-To: <20241011101455.00006b35@gmail.com>
From: Ilias Apalodimas <ilias.apalodimas@linaro.org>
Date: Fri, 11 Oct 2024 08:06:04 +0300
Message-ID: <CAC_iWjL7Z6qtOkxXFRUnnOruzQsBNoKeuZ1iStgXJxTJ_P9Axw@mail.gmail.com>
Subject: Re: [PATCH net-next v1] page_pool: check for dma_sync_size earlier
To: Furong Xu <0x1207@gmail.com>
Cc: Yunsheng Lin <linyunsheng@huawei.com>, netdev@vger.kernel.org, 
	linux-kernel@vger.kernel.org, Jesper Dangaard Brouer <hawk@kernel.org>, 
	"David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, 
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, xfr@outlook.com
Content-Type: text/plain; charset="UTF-8"

Hi Furong,

On Fri, 11 Oct 2024 at 05:15, Furong Xu <0x1207@gmail.com> wrote:
>
> On Thu, 10 Oct 2024 19:53:39 +0800, Yunsheng Lin <linyunsheng@huawei.com> wrote:
>
> > Is there any reason that those drivers not to unset the PP_FLAG_DMA_SYNC_DEV
> > when calling page_pool_create()?
> > Does it only need dma sync for some cases and not need dma sync for other
> > cases? if so, why not do the dma sync in the driver instead?
>
> The answer is in this commit:
> https://git.kernel.org/netdev/net/c/5546da79e6cc

I am not sure I am following. Where does the stmmac driver call a sync
with len 0?

Thanks
/Ilias

