Return-Path: <netdev+bounces-116886-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 5B82994BFAE
	for <lists+netdev@lfdr.de>; Thu,  8 Aug 2024 16:31:15 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 14B652822F8
	for <lists+netdev@lfdr.de>; Thu,  8 Aug 2024 14:31:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 074891EA90;
	Thu,  8 Aug 2024 14:31:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="IUO/DhF3"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pf1-f173.google.com (mail-pf1-f173.google.com [209.85.210.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 81352637
	for <netdev@vger.kernel.org>; Thu,  8 Aug 2024 14:31:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723127471; cv=none; b=QD1tDkRm7iljq+ehYiPNuY9cMtZ3AJEtP6PEY9CF34JpkLu8JXgsEmHEE63X+E9ABGhsxtEVcoKXhOHhR1f1Ze0KChrFLq4YPDVLwwopII4s/L4IX1/1dVm0ycG5kxlm8f7mH1H4uOrxaJljA3WLOSALH8roY9nZaG3X52wZLDE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723127471; c=relaxed/simple;
	bh=4ttwbHHarj/j16j5LCghrycCNQbko61NjkFQv47KK5U=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=aHGPmiy6Big7UvcA3+a/1iSp1t4dahJ+A5eCST8tsvuA2lEmb63zOrbeWeaDYNt+yOimFE7qLFtoC5obGQLy9GyMZHK5hAX/oAxg3jUGdArw6GW6dd98KxJ3Y2zmX8dKQWt1LiEiw677NxwgEKVyZXBSVvMI+nLD/BwIFrpsQBg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=IUO/DhF3; arc=none smtp.client-ip=209.85.210.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-pf1-f173.google.com with SMTP id d2e1a72fcca58-710afd56c99so817366b3a.0
        for <netdev@vger.kernel.org>; Thu, 08 Aug 2024 07:31:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1723127469; x=1723732269; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=4ttwbHHarj/j16j5LCghrycCNQbko61NjkFQv47KK5U=;
        b=IUO/DhF3/2lA3dZuSju/DCz+AGscHDHt5OoXIpoFp1/q78REaOqo96BNU9k4NxmOb6
         V9xTSyxToo5ANU3BcNKysgXCldrJCWsjgJBHXpJg/N8YMa/qKNf5cPgeUFRnM4oZTY+C
         FumueulCkXimeRQ/2st4NVHMClIHz60BTzZMp0dmfW5tRiQE5npghGjdsFskNkWk2rOp
         gJrya50A6Gtt+/AUn8YB34YzNfxZURbT10iy8ezQTSWScK3tOM0fJ1ZlyA7Wy4dIxciG
         MFCJTg+TPMcCQFUd4WdqjdXXkm5U8b10FKlKPaN7GMCpnF83kfztp1cFYBFs6BVfugXw
         wSow==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1723127469; x=1723732269;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=4ttwbHHarj/j16j5LCghrycCNQbko61NjkFQv47KK5U=;
        b=d7Bq88O5jZs0leK2dD3ZhymYzyCzVtT7lfrtLM23U/aZ+HJtwkBFV6K5yVuf/rzKXD
         ZKCX+w9dahrnuo3UwrQvFyQKqhk56XQ7oCcAGx1b+sF8z9oflCSwbtGOHoXRwFdCLE+H
         KLv17S4sKKEBXBuaKvIb+aMb3CrMI+1XK0ZRO8+Rq/cyb05tvkYoe6642mGT0Br9fKBF
         OPwmWZtLdLvatU41DBn3A61isgX79O8uqptBBUNq8tmPZ6ihd5pP6jZ2g71Hq5hwE0Sp
         /h66Tfs42Mq8ry7tOJJTNh1mxDB/IB+q/mIRv3g9SccGgfhUkqrvPCfPBzbSv6k4m0Iu
         OxzA==
X-Gm-Message-State: AOJu0YzQ8PTIi3YEA/0KjrNP9yuSU/0fNI1Mq7imj8E9N7vEZJpQj3Sf
	V1TKl/S+fpDy5BJjlLEA7vn1hwFikFuWRpTJbHfNKgnovFYRO3bFhyHdEkhQVkKYmUOUBAsiNwz
	kFTmHnsVDsVa2bRMx7g5FPxEgTqky9PcG/IKRCg==
X-Google-Smtp-Source: AGHT+IFcrT4gVDgddBsQw1ifnfON30h2AAklhIeEUH4u6w0QOauM0MTZCp/9JDfxet4Ddq+R3cKcZbSwHUpeXslCFgY=
X-Received: by 2002:a05:6a00:4604:b0:710:9d5d:fd13 with SMTP id
 d2e1a72fcca58-710cc356fa9mr2938656b3a.0.1723127468627; Thu, 08 Aug 2024
 07:31:08 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240806151618.1373008-1-kuba@kernel.org> <CAC_iWj+G_Rrqw8R5PR3vZsL5Oid+_tzNOLOg6Hoo1jt3vhGx5A@mail.gmail.com>
 <20240808065228.4188e5d3@kernel.org>
In-Reply-To: <20240808065228.4188e5d3@kernel.org>
From: Ilias Apalodimas <ilias.apalodimas@linaro.org>
Date: Thu, 8 Aug 2024 17:30:31 +0300
Message-ID: <CAC_iWj+z_6QZCOWv9DKZ1-ScOREtjSTzOBPw5VQCaWacJy3toQ@mail.gmail.com>
Subject: Re: [RFC net] net: make page pool stall netdev unregistration to
 avoid IOMMU crashes
To: Jakub Kicinski <kuba@kernel.org>
Cc: netdev@vger.kernel.org, davem@davemloft.net, edumazet@google.com, 
	pabeni@redhat.com, Jesper Dangaard Brouer <hawk@kernel.org>, 
	Alexander Duyck <alexander.duyck@gmail.com>, Yonglong Liu <liuyonglong@huawei.com>, 
	Yunsheng Lin <linyunsheng@huawei.com>
Content-Type: text/plain; charset="UTF-8"

Hi Jakub,

On Thu, 8 Aug 2024 at 16:52, Jakub Kicinski <kuba@kernel.org> wrote:
>
> On Thu, 8 Aug 2024 14:12:34 +0300 Ilias Apalodimas wrote:
> > In any case why do you want to hold on the IOMMU? The network
> > interface -- at least in theory -- should be down and we wont be
> > processing any more packets.
>
> I should have you a link to Yonglong's report:
>
> https://lore.kernel.org/all/8743264a-9700-4227-a556-5f931c720211@huawei.com/

Ah I read that bug report during my vacation but completely forgot about it...
Thanks this helps.

>
> we get_device() hoping that it will keep the IOMMU machinery active
> (even if the device won't use the page we need to unmap it when it's
> freed), but it sounds like IOMMU dies when driver is unbound. Even if
> there are outstanding references to the device.
>
> I occasionally hit this problem reloading drivers during development,
> TBH, too. And we have been told we "use the API wrong" so let's fix
> it on our end?..

It's been a while since I looked at the use cases, but I don't love
the idea of stalling the netdev removal until sockets process all
packets. There's a chance that the device will stay there forever.
I'll have to take a closer look but the first thing that comes to mind
is to unmap the pages early, before page_pool_destroy() is called and
perhaps add a flag that says "the pool is there only to process
existing packets, but you can't DMA into it anymore".

Thanks
/Ilias

