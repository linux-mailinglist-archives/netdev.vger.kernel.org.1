Return-Path: <netdev+bounces-143071-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 9B33C9C10B3
	for <lists+netdev@lfdr.de>; Thu,  7 Nov 2024 22:11:54 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id CCF531C22D3E
	for <lists+netdev@lfdr.de>; Thu,  7 Nov 2024 21:11:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A1E731DC04A;
	Thu,  7 Nov 2024 21:08:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="XQ6fthhP"
X-Original-To: netdev@vger.kernel.org
Received: from mail-qt1-f182.google.com (mail-qt1-f182.google.com [209.85.160.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 046D4218306
	for <netdev@vger.kernel.org>; Thu,  7 Nov 2024 21:08:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731013694; cv=none; b=iQMU2BpNUGu1OQcR5DkwpejPcCOW9Q3GQzRHHjblQ3tC64I1V/PcJyunmqheIlcdX42ULkUHjsFDZBS/BfmzAX5Y6Phd1ndlx6GVZkfYw8fkU4vQ5dGEvf7flf5vuKU9a7vFTyA13fLetuRp1QuNqs1S6u7VwytEGwUMZGzttWM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731013694; c=relaxed/simple;
	bh=EMxt7kYIYpj0aTE8SaO6Cet7tiJN1I4Ls+423fh4Wfk=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=kHE3SHxpJ5pi14Nkp/vINtd3XRuNcSdjZq3mCrK210SYnZ2wEuZr0cl+ig45eSqirXfmpQUFwwMJYNFlrHgBZg4ur2PtYgsVxcnRymBwzvv5t4NJF4FIIt6qzgQFeP4cTfGuM7qDJnKPS5PLjfwwTxJIN3m2HUA8gpSm61S4Jw8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=XQ6fthhP; arc=none smtp.client-ip=209.85.160.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-qt1-f182.google.com with SMTP id d75a77b69052e-460a8d1a9b7so6721cf.1
        for <netdev@vger.kernel.org>; Thu, 07 Nov 2024 13:08:12 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1731013692; x=1731618492; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=EMxt7kYIYpj0aTE8SaO6Cet7tiJN1I4Ls+423fh4Wfk=;
        b=XQ6fthhPaLHGGP2gFO8RTINYS6eiFl7bg/v+iBhou5J2wu+PH5LLfSIvUGNxWPK8ez
         oI0d0RlNkuyDHz0/T4DIwWXl5j5Ai5vTHHNyEUp7TY3sKm45FtmM9GleXdROKa8NtbOp
         IEZu/h8M5T1BmoReXU8yqJLteCkTd1BI3XXqoMoJ+rSvZX3qZevp8H5yiN2MHPlCMbXb
         M6wISunbcJQx94RKSUjsbOATPOzhf8ouhkwMy+d1Ej9dkb11FiaR05ywMSuSqISbU2aR
         wqQe5TeNeEp0qTgM3SLSvycHN2A1rc37L29Od2KXy4DX7xYC8ZOaHT8Eb8XCdsXM6YZF
         yeVA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1731013692; x=1731618492;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=EMxt7kYIYpj0aTE8SaO6Cet7tiJN1I4Ls+423fh4Wfk=;
        b=dq4o5+OInd1oKRJjzNtt20OeSV66p7Y+OxfFTi4QSMg9uW9yZElQ2DB9h/gPmmX86s
         0CvKy8txMN/lfXF95n1WRG0XyCiiAodkitCNvJfSXITvs21pFusTnN/cT6D/nGWrv2tG
         zsinn78kJHB/NnC12NTKYFGOXb7J0YMezhY9/4mLke595ew1w3bC0CLLMBG6f+vXN8Rb
         4l/dCOVBiHoT8rF0VT9OSxboXkh6xuFGwB81glM8g/p7rHnugdPQQgWsRZRaXiDhNbI8
         NCqLkzve1getbjN3keMl3omVkUBca6FwgSwA9ylZbmzUERYBGOYOnKQDc6mURpEzhZo/
         A0Og==
X-Forwarded-Encrypted: i=1; AJvYcCVPW2uDK4xFiv2FDx+gFs7UjjoRyNsG9yv9PdxwFqD+IMqwvbXwUCLo0KnlMWEAPyCWVRJJsEw=@vger.kernel.org
X-Gm-Message-State: AOJu0YyhvUrNTblk8weJIxVXeJo1qQkrR4+Du2C+JmcEiIgzsXpYfRcG
	8MXe0vljGps3WOm1o3DkS4s9n0EtQL5Gi8Z74aAyLRz/oGQmwJUnNMF+/Cusj4EoMKcrvSNyBhS
	vG8EMJjWu2eUyyF8iS15JN9L8aVA3Z6tT4rzU
X-Gm-Gg: ASbGncs1brcH3C6N06jQ3iIW5lLnPm6wByZ10A0sCfG0TFU7feQNW9O0WNHVDVmXoDm
	h1D0oYF0jb/Gc+udjNvBCsc6C63ckq08=
X-Google-Smtp-Source: AGHT+IGVwRKmmDdCXrJ9yts4PX0oCLDtCnr3iWhEQX4cctr2L6Hn+5HNxGpsOGoqz1dx/nbffB51ZSEpbDnMPa46nQo=
X-Received: by 2002:ac8:5710:0:b0:460:e7fa:cf2 with SMTP id
 d75a77b69052e-462fa6112e8mr5871971cf.23.1731013691732; Thu, 07 Nov 2024
 13:08:11 -0800 (PST)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20241029204541.1301203-1-almasrymina@google.com>
 <20241029204541.1301203-3-almasrymina@google.com> <763d9630-3064-4d88-8e99-549a07328ec8@huawei.com>
 <CAHS8izMgF8nx87D9pWPmq1pfDm1v8x5Z6gc_eMHcYo8zKX-Lrw@mail.gmail.com> <1d8c55c7-1406-4af6-9dce-0b296cd40fc9@gmail.com>
In-Reply-To: <1d8c55c7-1406-4af6-9dce-0b296cd40fc9@gmail.com>
From: Mina Almasry <almasrymina@google.com>
Date: Thu, 7 Nov 2024 13:08:00 -0800
Message-ID: <CAHS8izPuwiPk49yjWgBYYa+uGuQ4fNtXaRF8+9cWJsf3gk04Hg@mail.gmail.com>
Subject: Re: [PATCH net-next v1 2/7] net: page_pool: create page_pool_alloc_netmem
To: Yunsheng Lin <yunshenglin0825@gmail.com>
Cc: Yunsheng Lin <linyunsheng@huawei.com>, netdev@vger.kernel.org, 
	linux-kernel@vger.kernel.org, linux-kselftest@vger.kernel.org, 
	"David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, 
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, Simon Horman <horms@kernel.org>, 
	Jesper Dangaard Brouer <hawk@kernel.org>, Ilias Apalodimas <ilias.apalodimas@linaro.org>, 
	Shuah Khan <shuah@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Sun, Nov 3, 2024 at 6:35=E2=80=AFAM Yunsheng Lin <yunshenglin0825@gmail.=
com> wrote:
>
> On 11/1/2024 9:10 PM, Mina Almasry wrote:
>
> ...
>
> >>
> >> Isn't it a little odd that old and new are not following the same
> >> pattern?
> >
> > Hi Yunsheng,
> >
> > The intention is that page_pool_alloc_pages is mirrored by
> > page_pool_alloc_netmems.
> >
> > And page_pool_alloc is mirrored by page_pool_alloc_netmem.
> >
> >>From your description, the behavior is the same for each function and
> > its mirror. What is the gap in the pattern that you see?
>
> I was mostly referring to the API naming pattern.
>
> Isn't it better if page_pool_alloc is mirrored by netmem_pool_alloc and
> netmem_pool_alloc_netmems is mirrored by page_pool_alloc_pages() from
> API naming prespective?
>

I've been treating the page_pool_* prefix to all the page_pool
functions as constant in all the renames so far. I replace 'page' with
'netmem' when available, or add a _netmem postfix when available.

> And maybe page_pool_alloc_frag can be mirrored by netmem_pool_alloc_frag
> in the future?
>
> Also, it would be good to update Documentation/networking/page_pool.rst
> for those new netmem APIs, or create a new doc file for them.
>

Heard. I do have an action item to update the docs. Currently, outside
of drivers immediately looking to immediately adopt devmem tcp, there
is no need yet to use the netmem APIs, but I do hope to make them more
widespread (and perhaps deprecate the page APIs when it's time to do
so).

--=20
Thanks,
Mina

