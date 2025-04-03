Return-Path: <netdev+bounces-178954-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id C2C9CA799D2
	for <lists+netdev@lfdr.de>; Thu,  3 Apr 2025 03:55:52 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 86655169A7D
	for <lists+netdev@lfdr.de>; Thu,  3 Apr 2025 01:55:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 928B81442E8;
	Thu,  3 Apr 2025 01:55:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Ls8p/otg"
X-Original-To: netdev@vger.kernel.org
Received: from mail-ed1-f46.google.com (mail-ed1-f46.google.com [209.85.208.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DA8FE2EAE5
	for <netdev@vger.kernel.org>; Thu,  3 Apr 2025 01:55:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1743645328; cv=none; b=X67lyQ3L756ceMHhpEVNN+5v1CKMMFMR0fHeXJ3GDkYJn3rycoYA+mNfdbo2igJHG6vQz3yuLEcjhvMx9GVvYyI9vvsiCl8OtwdxdPDCM5hNFrc6ovQVm1vFQqJi0Pf6XKMCF+f9Xea0vroRqVeEfFe1ymxSGbrtQ/MI/xPjoxk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1743645328; c=relaxed/simple;
	bh=mT5uzeRJGBr0jJ9kHKaWV5/vH/CeaXxlltpuyALgAzI=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=uaz+YA5bfoZbaDcHypOsTB94cP4+fCwHyWYOsTXt5lm2yN0EPuubvPoKh3I7ZzA6iNv5hDFVv2fciA1EB86durAguyA7IYNUuSKIKsEY7ucWasQeWJaORLiT3N2O/NIQyn1i/b/cI6/GmgU3FfYfgCB9rKhiGaz7DXm43iXhMeo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Ls8p/otg; arc=none smtp.client-ip=209.85.208.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ed1-f46.google.com with SMTP id 4fb4d7f45d1cf-5e5c9662131so694180a12.3
        for <netdev@vger.kernel.org>; Wed, 02 Apr 2025 18:55:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1743645325; x=1744250125; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=niBS3q+mbbE+k62UK+xBZ45ZjLbJkl6zZwsg/SLggnw=;
        b=Ls8p/otgse5Dz2AIXSL1yR5IJL8I1vZPJg9U/EM/CipFA1ZcFFrRh1s1XcuyLHi3U/
         dNsBSWcHJSq1V9Doggb/5j5HtPwJvero1PLiGI5yQTfu7TBn1f271yAOdv8pX7IxTn8+
         Xynrp+I3XY+QdQxTESW296cPrgQMxmCmtFzw278PsH6q//Ap56VwpPn9ZTcfctBcruzG
         HdbKFGnTmesb6OOYzr6rlEU1TM7LGWqqTZcoyE+7qKHIU7V0f1cj0mwKfF0cYIq0chOs
         jFkoEPWkVxUTSrUgBnSYKJ/UcScwd8wdHW3I+tQ8MtUBVanpWyY065id8VORnlMEWRbl
         TWZw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1743645325; x=1744250125;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=niBS3q+mbbE+k62UK+xBZ45ZjLbJkl6zZwsg/SLggnw=;
        b=Y5coeAaFkHpAkB7srhtfm6UTlWdWh6tWbgmhUcII79bLf0yIkthLaXl6FM994zU9kW
         lGMikLrgaznTwRA6mp29ab2j208lAWl5unSgzUcWet8TZ3Gj0PSwDWEIHaw5fKmVh8pZ
         H4728HsowSIqdHNg3Ewg8h5Ginym37WV2RWtnRVJnVLxIA16GiCqeseTUwdqlVuceyNV
         hI5jlZrcdx2lzm5QCWkJaIKBZD/ZdUWZFCPHpCZfubmB3pN/VZsaJiF1s/k0RhT63Wq1
         vpayRRmLkUN4WQA1fS9Lk75lY2TXfCUhr/COUOQJ84hc2wtQfLOMCbirpCM3Vxuf5xea
         R5HA==
X-Forwarded-Encrypted: i=1; AJvYcCUbyLI5scW/F8McXx/qO7movJ5juSpPxaAFd2KAusYPIn3Juy4TyuRKJv5wJnyesfD4BRbIIro=@vger.kernel.org
X-Gm-Message-State: AOJu0YwCq9+adWgYQO9LSjHTo2NWf/7mbyg7JxOtE1g7gyB+UfXx93lg
	yata8p2gJN7nI280Y0j0NJocEvu1U8wppCOzRa8eH6Q58WWWIoLbmOuX/MphfmUttLNXyX1d8+S
	YG35h+v029KBCUZzZy1SQITp1tRA=
X-Gm-Gg: ASbGnctOXgwlYhHd5uNh71lEJzQrZD8+nEJFFhCRjQdOhLUdmgEcz2UCSU7/6eHWhJ0
	pzqLCxbmG48oQ7q1CXYNEhFU6Nb1WFY1G2zX3yZ5L82+Lq/FNW+9I+dpi8D2KmDh0rRZX6Re57Y
	4jdeb5CdSTZIIQTKtVgV/SUevQO3UC
X-Google-Smtp-Source: AGHT+IFQKqdiTxYMnf+eSmJdtwq5PweiofrIbpDeOSyOPOAgZJ5ThPee8B2fSAnVQex/E+1g6010bnNU+TVBVm9G1pA=
X-Received: by 2002:a05:6402:5204:b0:5ec:96a6:e1cd with SMTP id
 4fb4d7f45d1cf-5edfcc3c23cmr13319673a12.2.1743645324680; Wed, 02 Apr 2025
 18:55:24 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250331114729.594603-1-ap420073@gmail.com> <20250331114729.594603-3-ap420073@gmail.com>
 <CAHS8izOSaXcLB-8U5gFD2sj+pLuq+jMvPHPUj8bsaHzqG4cTsA@mail.gmail.com>
In-Reply-To: <CAHS8izOSaXcLB-8U5gFD2sj+pLuq+jMvPHPUj8bsaHzqG4cTsA@mail.gmail.com>
From: Taehee Yoo <ap420073@gmail.com>
Date: Thu, 3 Apr 2025 10:55:13 +0900
X-Gm-Features: AQ5f1JrxVs4jSBXk-F4MzmmOk3SW5Thi4ae9B6xLpiTvKZjsgabKxKu2Uv3spAM
Message-ID: <CAMArcTVn_SmvrsewzoYaFa-sqT=9bS-3W2qwmSnsQc49-eZWWg@mail.gmail.com>
Subject: Re: [RFC net-next 2/2] eth: bnxt: add support rx side device memory TCP
To: Mina Almasry <almasrymina@google.com>
Cc: davem@davemloft.net, kuba@kernel.org, pabeni@redhat.com, 
	edumazet@google.com, andrew+netdev@lunn.ch, horms@kernel.org, 
	michael.chan@broadcom.com, pavan.chebbi@broadcom.com, 
	ilias.apalodimas@linaro.org, dw@davidwei.uk, netdev@vger.kernel.org, 
	kuniyu@amazon.com, sdf@fomichev.me, aleksander.lobakin@intel.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Apr 3, 2025 at 7:17=E2=80=AFAM Mina Almasry <almasrymina@google.com=
> wrote:
>

Hi Mina,
Thanks a lot for the review!

> On Mon, Mar 31, 2025 at 4:48=E2=80=AFAM Taehee Yoo <ap420073@gmail.com> w=
rote:
>
> > -static int bnxt_alloc_rx_page_pool(struct bnxt *bp,
> > -                                  struct bnxt_rx_ring_info *rxr,
> > -                                  int numa_node)
> > +static int bnxt_alloc_rx_netmem_pool(struct bnxt *bp,
> > +                                    struct bnxt_rx_ring_info *rxr,
> > +                                    int numa_node)
> >  {
> >         struct page_pool_params pp =3D { 0 };
> >         struct page_pool *pool;
> > @@ -3779,15 +3799,20 @@ static int bnxt_alloc_rx_page_pool(struct bnxt =
*bp,
> >         pp.dev =3D &bp->pdev->dev;
> >         pp.dma_dir =3D bp->rx_dir;
> >         pp.max_len =3D PAGE_SIZE;
> > -       pp.flags =3D PP_FLAG_DMA_MAP | PP_FLAG_DMA_SYNC_DEV;
> > +       pp.flags =3D PP_FLAG_DMA_MAP | PP_FLAG_DMA_SYNC_DEV |
> > +                  PP_FLAG_ALLOW_UNREADABLE_NETMEM;
>
> I was expecting to see a check that hdr_split is enabled and threshold
> is 0 before you allow unreadable netmem. Or are you relying on the
> core check at devmem/io_uring binding time to do that for you?

Yes, it relies on the core.
The core already checks conditions very well, such as HDS.
So I think drivers don't need to check these conditions again.

Thanks a lot!
Taehee Yoo

>
> --
> Thanks,
> Mina

