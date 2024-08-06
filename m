Return-Path: <netdev+bounces-115929-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 258619486A8
	for <lists+netdev@lfdr.de>; Tue,  6 Aug 2024 02:40:07 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 44BAE1C21EB4
	for <lists+netdev@lfdr.de>; Tue,  6 Aug 2024 00:40:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E551617C9;
	Tue,  6 Aug 2024 00:40:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="AqRtDVlu"
X-Original-To: netdev@vger.kernel.org
Received: from mail-wr1-f49.google.com (mail-wr1-f49.google.com [209.85.221.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2AD4663C;
	Tue,  6 Aug 2024 00:40:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722904803; cv=none; b=L6yjf5oNp/ib9PWdlap+49qhR2gxuSy+GLOEkj8kFYkkK8eynoW2Ll6Ljzn+wy/jRicmHtUHNZini6VB2LQr56FixebIFrBNvHUdLRe4891LRHy1Vam63k5LRldqh4jux3j8Ct9cMFrETfPskLMzRFevesV7gpj565tjqUP1vqI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722904803; c=relaxed/simple;
	bh=fRR3DATEsRrbV2lk8KRxjtv1/FxWvxec6i6bzpLg/mA=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=V8we7MZh4JsAi8+62ub3JxhcouQXmEy1HkT4ZBKIFbYOQdb3eQzw2rBf2jUp/XUttWY5oj9+sjA4cWWNcDYNzCmWBuI2hpd99CLF6bihsXNCjBrvZYrx2e+UhRjp9aMjfYw93247WlT+B/I96kwgEJVa4JE7qx7V3qXYKxHBo+s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=AqRtDVlu; arc=none smtp.client-ip=209.85.221.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wr1-f49.google.com with SMTP id ffacd0b85a97d-3685b3dbcdcso111151f8f.3;
        Mon, 05 Aug 2024 17:40:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1722904800; x=1723509600; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=fRR3DATEsRrbV2lk8KRxjtv1/FxWvxec6i6bzpLg/mA=;
        b=AqRtDVluNkcdWZVDRIDDgzt23wl8AUkvKOncS3HCrc3XPB92zBbk2GTndAQ/CX/G1l
         trxOqd4UQYTWj5N2oVcgyrCMIY8Hll/MKwSR/QhQzxnkWEEmzTSbM5Fe+n8OlJkzwU+S
         4UM9HG1CwJKhbMewxIKvLOsXrb8q15TVgslObHTsH989DEgC8sP7R5IXIs2/2hdE1FWY
         RRSXbubW0sq0md/vhqeQz40ypqErCTzWzTUJqaBeMggm1xEqf9J9tjb6obG5SK497CTJ
         whNgtZBtCFSkWsjwoDWxx68reUYvm0Y116JnP5tNg2kbZf4bLfJtc6ohUZkirCboanTY
         NhRQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1722904800; x=1723509600;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=fRR3DATEsRrbV2lk8KRxjtv1/FxWvxec6i6bzpLg/mA=;
        b=bWmjlDSpAcNb5fahNYKi0pEfHj+cG5CZaRPs6ogJz3WRxZwipAelcFrzX9SB3bzQl1
         m9rtswQYfJQsNGdYsRhIdGRjGrow8d6HxNf+BEutZekjmGMXcuE8sz09SXOveEA7Q5Ht
         CoNci3nn8AklGeM6dOt2Z4Cf7rbLGpVeqjv0eoIWMOU07bz0JNcfb3G0l2MPw/Ob4060
         nyDyqQQhy0zK3AinnLLBK0Re9MPbVRch1aj/Q86MP0AFqyYWnDznW+VS6Sv9SwRM0h5c
         IL75Gw5rLuNxYIfFR5uhfQSkWeq8OTHfcAx9LlGkFMEtC1Q7Kq5RrtZD2RNIm2LD9Fha
         eIAg==
X-Forwarded-Encrypted: i=1; AJvYcCXDuzFFiZHrOyp4EHTHiisvqappoUf+khqG8dmj6fD6Mua+3nuTHjYZwJLkuhp3HDzL+WODsupWAlNx64O4DUghGlxl6z/b0sq7KB0jmEwBxyEw0kW+ZEq5cLRkpxQJHnXBQDYj
X-Gm-Message-State: AOJu0YzOiF1/vBQy827SeFtzPcdS+FJ2sf+SdkFKhy7vy8kJlms84oKB
	laWyhgYHxNAdUTW2ln393u39QK7hf2Axn0aiL+PR2f0xpeqd+B3gc8584gtkgTvDD1sqfuVaL1M
	SlbgPrxNrGPLucQ28k8BAsWrqFNI=
X-Google-Smtp-Source: AGHT+IEQwDIjU1uPDtehVAQaw1/z3fKCHW7xjJpO2iSqDasNkhxHmMjofXQkPJJAKw0wBpE4lz/mcTzeUCXMSbOYxuo=
X-Received: by 2002:a05:6000:4028:b0:366:e7e2:13c8 with SMTP id
 ffacd0b85a97d-36bbc0f7a96mr13980593f8f.11.1722904800170; Mon, 05 Aug 2024
 17:40:00 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <0e54954b-0880-4ebc-8ef0-13b3ac0a6838@huawei.com>
 <8743264a-9700-4227-a556-5f931c720211@huawei.com> <CAKgT0Uf4xBJDLMxa3awSnzgZvbb-LN82APkPi7uVpWw+j7wqRA@mail.gmail.com>
 <8d4b6398-1b7d-4c14-b390-0456a6158681@huawei.com>
In-Reply-To: <8d4b6398-1b7d-4c14-b390-0456a6158681@huawei.com>
From: Alexander Duyck <alexander.duyck@gmail.com>
Date: Tue, 6 Aug 2024 06:09:23 +0530
Message-ID: <CAKgT0Ue1+wvoFzymvMhUvbbSTRgW8=qYySkH80KqRKHCXdHWPg@mail.gmail.com>
Subject: Re: [BUG REPORT]net: page_pool: kernel crash at iommu_get_dma_domain+0xc/0x20
To: Yunsheng Lin <linyunsheng@huawei.com>
Cc: Yonglong Liu <liuyonglong@huawei.com>, "David S. Miller" <davem@davemloft.net>, 
	Jakub Kicinski <kuba@kernel.org>, pabeni@redhat.com, hawk@kernel.org, 
	ilias.apalodimas@linaro.org, netdev@vger.kernel.org, 
	linux-kernel@vger.kernel.org, Alexei Starovoitov <ast@kernel.org>, 
	"shenjian (K)" <shenjian15@huawei.com>, Salil Mehta <salil.mehta@huawei.com>, iommu@lists.linux.dev
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Aug 5, 2024 at 6:20=E2=80=AFPM Yunsheng Lin <linyunsheng@huawei.com=
> wrote:
>
> On 2024/8/3 0:38, Alexander Duyck wrote:
>
> ...
>
> >
> > The issue as I see it is that we aren't unmapping the pages when we
> > call page_pool_destroy. There need to be no pages remaining with a DMA
> > unmapping needed *after* that is called. Otherwise we will see this
> > issue regularly.
> >
> > What we probably need to look at doing is beefing up page_pool_release
> > to add a step that will take an additional reference on the inflight
> > pages, then call __page_pool_put_page to switch them to a reference
> > counted page.
>
> I am not sure if I understand what you meant about, did you mean making
> page_pool_destroy() synchronously wait for the all in-flight pages to
> come back before returning to driver?

Part of the issue is the device appears to be removed from the iommu
before all the pages have been unmap. To fix that we would either need
to unmap all the pages or force the kernel to wait until all of the
pages have been unmapped before the device can be removed from the
iommu group.

> >
> > Seems like the worst case scenario is that we are talking about having
> > to walk the page table to do the above for any inflight pages but it
>
> Which page table are we talking about here?

The internal memory being managed by the kernel in the form of struct
page. Basically we would need to walk through all the struct page
entries and if they are setup to use the page_pool we are freeing we
would have to force them out of the pool.

> > would certainly be a much more deterministic amount of time needed to
> > do that versus waiting on a page that may or may not return.
> >
> > Alternatively a quick hack that would probably also address this would
> > be to clear poll->dma_map in page_pool_destroy or maybe in
>
> It seems we may need to clear pool->dma_sync too, and there may be some
> time window between clearing and checking/dma_unmap?

That is a possibility. However for many platforms dma_sync is a no-op.

> > page_pool_unreg_netdev so that any of those residual mappings would
> > essentially get leaked, but we wouldn't have to worry about trying to
> > unmap while the device doesn't exist.
>
> But how does the page_pool know if it is just the normal unloading proces=
sing
> without VF disabling where the device still exists or it is the abnormal =
one
> caused by the VF disabling where the device will disappear? If it is the =
first
> one, does it cause resource leaking problem for iommu if some calling for=
 iommu
> is skipped?

It wouldn't. Basically we would have to do this for any page pool that
is being destroyed with pages left in-flight. That is why the
preference would likely be to stall for some time and hope that the
pages get unmapped on their own, and then if they can't we would need
to force this process to kick in so we don't spend forever.

