Return-Path: <netdev+bounces-143271-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 055189C1C4C
	for <lists+netdev@lfdr.de>; Fri,  8 Nov 2024 12:41:35 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id BE8BF2812F0
	for <lists+netdev@lfdr.de>; Fri,  8 Nov 2024 11:41:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 366261E3DFC;
	Fri,  8 Nov 2024 11:41:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="N1/+YmRz"
X-Original-To: netdev@vger.kernel.org
Received: from mail-lj1-f182.google.com (mail-lj1-f182.google.com [209.85.208.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5A5CF7B3E1
	for <netdev@vger.kernel.org>; Fri,  8 Nov 2024 11:41:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731066092; cv=none; b=onYJygwS2BXQYgx905H3bEL+qFrEkvR9BkMQqjuN58IHH5slbsApMoj+xqdklsGcz01uub3ovk35X6ynYynY4XNJp9ZX1Ud17ZLVKorCmvsUMM3jqoYsYdontu21neDkk9R+eHaHAvh12FlhDmfL5WgVsif+k8uJCKDYriC9nMA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731066092; c=relaxed/simple;
	bh=uY/iMbf3Vk3sXbHtDhy0LKeHEHnsP2OiGaIvmYFRXgM=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=UWmkGTSP4XE4Ls3ecqfnBo0gvtghcndo8F5FCcIGVkGXyqHpGBtAyR+Ib0X4rDQ9jTVn3JDK47BKcNEnyBbb2oG058rq/cghNKqKFgLkHgPOsVntbXXsFTOXkbtdlo4yHWc+x5tMDdnU2mDUQ8RIuJB9SaFDy3Ddhr1649qQKf0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=N1/+YmRz; arc=none smtp.client-ip=209.85.208.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-lj1-f182.google.com with SMTP id 38308e7fff4ca-2fb3da341c9so20057361fa.2
        for <netdev@vger.kernel.org>; Fri, 08 Nov 2024 03:41:30 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1731066088; x=1731670888; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=CXSvbTMRrcj6fCxF0ufHCuWCloLz1hIjGxoKK8AG/+o=;
        b=N1/+YmRzvTrpmzqpdwplm8fyhDyDjMHX3HdJUTzuz238fVLWX8v/m7m/tOSuhkkEUJ
         8e5m+z+5heAtSJu7E+4im3tjSBZ3gvNCMSPQiSj+QVpWlFg22IuSKQsSwWAvIOIwsMXW
         /LtwUPgw/MWCrkBGIos/OJN+E2hjBLzD3uM6x0KKvAL8KWTLvel2RRwNaT7vkckHcHrX
         llp09Z09VWyYVLetgkW8wzaSxs1nIkUXV1wbu7b8ga/PjwpsoMrNolxzl+0UtLBD2oEb
         30765U0Z6O1kdeD4s68n6abark3xzoc1162X1og0XcxrfTePrybuBZwyr5zCJO538ow2
         C9Fg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1731066088; x=1731670888;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=CXSvbTMRrcj6fCxF0ufHCuWCloLz1hIjGxoKK8AG/+o=;
        b=gCWddXjglT2Vv7VNiInnsrkkGwfkpOGsEpEKCsrpiiuazYxV7wdXBPFgl7oChRlkmy
         rfac8+R3mWxgPrnFc+vT/p8iahjEi587WrUJfRYR9N6pdARQowrlX08AH51U0/EQKgf+
         VXBaz5REpKHKf5qPkyUpf93de32oksgKLcNyrlxKBWAp+iO1wbzH0sjiAP/khzmUvThp
         wz/Bz+hrOEaySkOqPjT2jGT6AiYWVgKx+anVVL9GA9LcZaosVZAcM25whfjGkuUiHmYt
         exI0+uIcFIn0iUcPJssXse0dlvBUbDbF8dKU+3MeNEl4YQiuoazN1PPZD8VaJFgnOkvZ
         NvyA==
X-Forwarded-Encrypted: i=1; AJvYcCVEiAujIfMkOr5jDIYFPtUBWZcWjgADeRxQcxRhGKwKBH9qBKy6SaCsNycGU0fV5opToQutVpk=@vger.kernel.org
X-Gm-Message-State: AOJu0YznKEEPR9DSNe6saP+jCYvmheBYeQ1HrDFfXoDYEuIF2mTHvIin
	hRosrm/aOYNKz9rvp3UNBycbjW3G9hwXn/aGhvly+94TI8yWK58CxpZDns9icgh0f4mH8mgiSzS
	gRCudiQ4amElIe96ExCHOdi6RqrMikNWBsvAOeA==
X-Google-Smtp-Source: AGHT+IG6dsbVHDy06kTkj5zAs70A2/MyWRJqE/mKAm1qvOYLwYQg1hL1cr+88CsDKtRlIRo2uCMtTHRVmKF8kaDiYQk=
X-Received: by 2002:a05:651c:1515:b0:2ef:243b:6dce with SMTP id
 38308e7fff4ca-2ff20185abfmr11928261fa.10.1731066088370; Fri, 08 Nov 2024
 03:41:28 -0800 (PST)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <202410301531.7Vr9UkCn-lkp@intel.com> <CACRpkdbW5kheaWPzKip9ucEwK2uv+Cmf5SwT1necfa3Ynct6Ag@mail.gmail.com>
 <2010cc7a-7f49-4c5b-b684-8e08ff8d17ed@csgroup.eu>
In-Reply-To: <2010cc7a-7f49-4c5b-b684-8e08ff8d17ed@csgroup.eu>
From: Linus Walleij <linus.walleij@linaro.org>
Date: Fri, 8 Nov 2024 12:41:17 +0100
Message-ID: <CACRpkdYQ6Pfn_Y7FJh7MV2Mb8etDXFCJEUrgq=c3JDxkSPOndA@mail.gmail.com>
Subject: Re: drivers/net/ethernet/freescale/ucc_geth.c:2454:64: sparse:
 sparse: incorrect type in argument 1 (different address spaces)
To: Christophe Leroy <christophe.leroy@csgroup.eu>
Cc: kernel test robot <lkp@intel.com>, 
	"linuxppc-dev@lists.ozlabs.org list" <linuxppc-dev@lists.ozlabs.org>, netdev <netdev@vger.kernel.org>, 
	Stanislav Kinsburskii <stanislav.kinsburskii@gmail.com>, oe-kbuild-all@lists.linux.dev, 
	linux-kernel@vger.kernel.org, Michael Ellerman <mpe@ellerman.id.au>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Nov 8, 2024 at 11:30=E2=80=AFAM Christophe Leroy
<christophe.leroy@csgroup.eu> wrote:


> The problem is the __be16 in the function prototype.
>
>         set_mac_addr(&p_82xx_addr_filt->taddr.h, p_enet_addr);
>
> p_82xx_addr_filt->taddr.h is a u16
> and out_be16() expects a u16*
>
> So the following fixes the above warnings:

Ah you are right of course, thanks! :)

Let's wait to the big rework you mentioned to land and I will try
to remember to revisit this in the v6.13 kernel cycle.

Yours,
Linus Walleij

