Return-Path: <netdev+bounces-134574-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id CD60D99A387
	for <lists+netdev@lfdr.de>; Fri, 11 Oct 2024 14:13:55 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 80FAD1F22C93
	for <lists+netdev@lfdr.de>; Fri, 11 Oct 2024 12:13:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E9E5A216A3E;
	Fri, 11 Oct 2024 12:13:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="JcIR+2Mc"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pl1-f177.google.com (mail-pl1-f177.google.com [209.85.214.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 500141BDAA1
	for <netdev@vger.kernel.org>; Fri, 11 Oct 2024 12:13:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728648833; cv=none; b=JM0f1d+n6c2bSpBKak9dnrlKxFzLlJXYQoTk7FSplju+4c5Z967NihKLAfdeIUMGCivnxPHFNL9D8psY1aYxhTuc2TasldgancFZ0mej/SO4vzwGGkgg23iBGQfYFPXDPXFnuMgAPdS5VK1w++fs2TpJ4+TaJGdddVajk6inaxQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728648833; c=relaxed/simple;
	bh=pVgQ4qeBPZp/jrWkLQ9CTTXSj/41aLXmAoXMA/Sm+W4=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=E4xHMmzGVXNwY/TGWNXxJFBLmZNV/dnO8n2IeC0EbWqllYLnndGkMPb5QQbpwEg5Y61iu039iPGdkLIdnqkjaOUJpdHjQ4PN6mwND781lmcFeuDE74W6CKBHggCtK1cmdVMKgx11Ew3wWBiaTANlz80QOqnWeO9PDBIOZasfHTI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=JcIR+2Mc; arc=none smtp.client-ip=209.85.214.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-pl1-f177.google.com with SMTP id d9443c01a7336-20bc506347dso15955495ad.0
        for <netdev@vger.kernel.org>; Fri, 11 Oct 2024 05:13:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1728648832; x=1729253632; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=6DV8FmK9n2s3xaJw37bhq13Y2oj4hKbJoV0faMjnNfw=;
        b=JcIR+2McKtwOE5Jd5A3c99BsRdTBzErzRGkGdtQDCZhtwGNaRfsM0HbWj1veOd22mW
         /Owtk+Zyg0K0aJ93Mufj8B4Llmq/gr68p8Gk5lQk88nKgX60/DfaqyeoO1VAqkN6t5AU
         2p+v2WZ9lAm+/quhSqJUv2BsrmPnAFhhA4x3PxLJq6eeVopDBuxTPH7JHI7i+2ciKu51
         rr9H2uStt+n65k67NuTrIRq32N15k3wg9piyvlWUZiz0CmFku+AsMQ/jRNKYbNrQkruS
         ZOHK7ubNkqkRV3WNcWmMm2/KxNeeOeLFsHxn0b7FfBny+iaq/LtbE6oEsE0Duy8olaCJ
         AUOw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1728648832; x=1729253632;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=6DV8FmK9n2s3xaJw37bhq13Y2oj4hKbJoV0faMjnNfw=;
        b=JKdMy31frdu/n3UXWApswqDbnv7rTgEmSZdFgGnQE/Au4VTW4sSbT6twmphvLEsuOg
         bMwuVn+3mOqD4niChH50uiP66s1QJ3/Ar5WnuSV/fQLWKJFm1uGdU+clLuVsmxENHnpa
         ilPoKpcXq7PbEo1qW+fSq7kcWp6p3Ba9cuMWc/3LpnNt5wewFQJF5uEiqKo6vPPDLfCV
         pd3AWjJpzW0gIWmwW9pq3zW0ClKjOuG1TaYSctpNddxp9JtKBv5w7BIOamV+Ejx1r9G7
         ngOFz1SkXhtj1W59EgvTpXQjjdn9ppfjp4SwWUEE/s85cfS1Bj729m3s81TVwdnvYvaC
         tsTQ==
X-Forwarded-Encrypted: i=1; AJvYcCVJRek8m7gyE7bFMBwBM1PvVZe9RcBTucNPZtgKOyRYblvwhngJpOSzHG+slVE64LlHIAvABPw=@vger.kernel.org
X-Gm-Message-State: AOJu0YxDqwX+Q9Xgmc2HdEiLq8hLW+gocyPN6L3lq6V7bl00ROldV6Hc
	KWvlMUZ0skUwT6hY5xHZ4JhPDN1oiTuuXxrItSSkDRV+4PUEc2YDt1B9pFw9xnDJl22/wDQr6Qe
	7qwIUihVE8+6hrsmxcfgoW2WFVF7mrNSC/t/MBQ==
X-Google-Smtp-Source: AGHT+IEhHh7IyxNNVXdhpzK7DYdwX3u4HJLwqzq8zbFcpGhkbrrdEfGF3mSpDzSVS0AcPKmBvtOSTltyzsarT9dBX/Q=
X-Received: by 2002:a17:902:e845:b0:20b:b93f:300a with SMTP id
 d9443c01a7336-20ca14246b0mr37785885ad.7.1728648831700; Fri, 11 Oct 2024
 05:13:51 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20241010114019.1734573-1-0x1207@gmail.com> <601d59f4-d554-4431-81ca-32bb02fb541f@huawei.com>
 <20241011101455.00006b35@gmail.com> <CAC_iWjL7Z6qtOkxXFRUnnOruzQsBNoKeuZ1iStgXJxTJ_P9Axw@mail.gmail.com>
 <20241011143158.00002eca@gmail.com> <21036339-3eeb-4606-9a84-d36bddba2b31@huawei.com>
In-Reply-To: <21036339-3eeb-4606-9a84-d36bddba2b31@huawei.com>
From: Ilias Apalodimas <ilias.apalodimas@linaro.org>
Date: Fri, 11 Oct 2024 15:13:15 +0300
Message-ID: <CAC_iWjLE+R8sGYx74dZqc+XegLxvd4GGG2rQP4yY_p0DVuK-pQ@mail.gmail.com>
Subject: Re: [PATCH net-next v1] page_pool: check for dma_sync_size earlier
To: Yunsheng Lin <linyunsheng@huawei.com>
Cc: Furong Xu <0x1207@gmail.com>, netdev@vger.kernel.org, linux-kernel@vger.kernel.org, 
	Jesper Dangaard Brouer <hawk@kernel.org>, "David S. Miller" <davem@davemloft.net>, 
	Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, 
	xfr@outlook.com
Content-Type: text/plain; charset="UTF-8"

On Fri, 11 Oct 2024 at 11:55, Yunsheng Lin <linyunsheng@huawei.com> wrote:
>
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

Case 2 would be what this patch does. We already treat -1 as the
maximum DMA memory size. I think it's ok to treat 0 as 'don't sync'. I
need to figure out why people need this.
IOW you still have to sync the page to use it. Now you can do it when
allocating it, but why is that cheaper or preferable?

Thanks
/Ilias

