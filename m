Return-Path: <netdev+bounces-193490-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 4A4E2AC4394
	for <lists+netdev@lfdr.de>; Mon, 26 May 2025 20:00:52 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id BD14C7AAFAB
	for <lists+netdev@lfdr.de>; Mon, 26 May 2025 17:59:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4569F13D521;
	Mon, 26 May 2025 18:00:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="f7vNnabh"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pl1-f174.google.com (mail-pl1-f174.google.com [209.85.214.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B185D3D76
	for <netdev@vger.kernel.org>; Mon, 26 May 2025 18:00:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1748282446; cv=none; b=Zx9G4zVGTvf5pZl+m+9Fs5QJP0/oixY6Qj7JvKAouqGvTuVMqFoIjCKUCHmk0V/mIm5+p6d6G4iJGaA2zYBI+j3B1MEaqA23Gao2IJWPWRM8ARj1LqCxVHTwW8vwIaxxmtyOT4ghmeiFQpYP4kr2LE5VUYj8RLGZ20ZhM0PxCFs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1748282446; c=relaxed/simple;
	bh=rI+licYUolL5nhcW9GoIZLfSpbwxMtL6YthxBl22SZU=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=sHRA8cd7cbY9EDZFW7JJgvkxiu6ehYx+UPpXXyS5xtCDoiTHhhiI66kkADsSY/7/uA5w6ifGaMCgqSbRF5BoKc4OdVf+dyIsc6K4OVcQtKbOCVh9mSbLdn1LlZKQOOseri/DyuhkRP3t5YJi7es4bsXp7RVIDeoM8sqJqEakX8o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=f7vNnabh; arc=none smtp.client-ip=209.85.214.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-pl1-f174.google.com with SMTP id d9443c01a7336-2349068ebc7so48425ad.0
        for <netdev@vger.kernel.org>; Mon, 26 May 2025 11:00:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1748282444; x=1748887244; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=BE00iNGaQOBcvJTWH1HJdDZjS8vODDdLLtmR/QEPXS8=;
        b=f7vNnabhvdOz0PP/Pa+YruFib71wohXXIsckWp4N7raMihaWFWdtGU0iwOCFIUuKsp
         rHDtYtQm8cvpalAzewKWO5Qsu2Ni/Lj388MvKw+8Ubnks0PPr3Bu6WhunmtXo3CrKUTv
         FEa4NQNNzeBdCLIOcO2Ablmh3WcJ7VDyumAWkhPl2NY1/AHTPrvmAGd25fjGTMsm7xOb
         OrEVPBJ3NPzLIW5m/zqzTVAZp7HSkx5QIvBX9xBrQ/MifvQxp/reImpMB4t39wpUcN8K
         HaHm7RrnACuH2U8cWM/prs4K4HStYaQkftkA6T25bScCeeNtaw8zc0UukANCGaMPR19P
         GySA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1748282444; x=1748887244;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=BE00iNGaQOBcvJTWH1HJdDZjS8vODDdLLtmR/QEPXS8=;
        b=g9sRBIiwUfOp+l1i1dQ6UCvUGfO97Nskcx+tHJ164S5QTA35cOPs/GxXmRCn0XzWtm
         LgEBcBlJvLPUWR1Pm9aUoJvwwY8zmmCyYuBqQ1dbIRyMGItArDhIx3zMx8xb43VsGyNL
         efwAaelaK60qVN7bCiif0+M4dVThKqtQcP6/Kw5GBkMFoyXcP2mppmY+YmcDdLvgfc46
         Xg3kqBHC1xmvwZh0WyoCQTMKCcXc5f509bDxp/dA1ffOamDwLfLEEgpUnjsb1A8pKExQ
         bvN9tLxycZZ8E5U1ppH4K7ly42kdiask6JiBH6BCEBaXwLsUHTYhawKWOFVggr9DGwpz
         wDCg==
X-Forwarded-Encrypted: i=1; AJvYcCUoU+5YfvBZNaO334f/UZFANYKfXgUr2CVsxqqA1X5VOsuELQ0y7/gPJ8EVKioydQ1zGYVRwBs=@vger.kernel.org
X-Gm-Message-State: AOJu0YyHaUzhUZcnKAqJcRZ5yelXBGxbMgtUZv1vPK0ovHCOZsiLaH4Q
	kP3Uyk778nRhxL8/iDQGzjP5RDhnWFZNpPJoqULLPtlhYuKw3xwHvg7LKMyaypQKQl/i92tLPWt
	qdQNo0Xfz4ghGkj+ThzZmsuBs0zQjzfXtjEk/bZnQ
X-Gm-Gg: ASbGncuKxF8HYdU74cywI8W7KlhD/FoZRsZu3QNjrYhTdrS2laIOsoSF3Sc4qpaZX2j
	p6GUCWKghEBxiP27lbR8v7bfd/1zrvO0j3N3WKbnTiHMUqw6XhRJ6PuMkFfMEEPOTdhlCQsXdWp
	WkdKeHzJ3qXdjU8KFYuTgy64Nin1DNcXE24re1T+E45OIX
X-Google-Smtp-Source: AGHT+IEtmxefPpCTSi1gvHA9a9DIBuanG4oeTpITjr5Cfh4ZkHf1HTV7gnyeYgG8lD3UeMrlJvwRa++zz4aloVbC260=
X-Received: by 2002:a17:902:ec8d:b0:216:6ecd:8950 with SMTP id
 d9443c01a7336-2341b52771amr4576785ad.19.1748282443435; Mon, 26 May 2025
 11:00:43 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250523032609.16334-1-byungchul@sk.com> <20250523032609.16334-14-byungchul@sk.com>
 <CAHS8izOX0j04=KB-=_kpyR+_HZHk+4hKK-xTEtsGNNHzZFvhKQ@mail.gmail.com>
 <20250526030858.GA56990@system.software.com> <20250526081247.GA47983@system.software.com>
In-Reply-To: <20250526081247.GA47983@system.software.com>
From: Mina Almasry <almasrymina@google.com>
Date: Mon, 26 May 2025 11:00:30 -0700
X-Gm-Features: AX0GCFsrsXIO7EOCYLWTkGfVc6XTbNgw4nzAjpdO0g7ysDNdP-dZJFnwMLd86jQ
Message-ID: <CAHS8izOMkgiWnkixFLhJ1+7OWFbYv+N0am83jV_2cgBecj-jxw@mail.gmail.com>
Subject: Re: [PATCH 13/18] mlx5: use netmem descriptor and APIs for page pool
To: Byungchul Park <byungchul@sk.com>
Cc: willy@infradead.org, netdev@vger.kernel.org, linux-kernel@vger.kernel.org, 
	linux-mm@kvack.org, kernel_team@skhynix.com, kuba@kernel.org, 
	ilias.apalodimas@linaro.org, harry.yoo@oracle.com, hawk@kernel.org, 
	akpm@linux-foundation.org, davem@davemloft.net, john.fastabend@gmail.com, 
	andrew+netdev@lunn.ch, asml.silence@gmail.com, toke@redhat.com, 
	tariqt@nvidia.com, edumazet@google.com, pabeni@redhat.com, saeedm@nvidia.com, 
	leon@kernel.org, ast@kernel.org, daniel@iogearbox.net, david@redhat.com, 
	lorenzo.stoakes@oracle.com, Liam.Howlett@oracle.com, vbabka@suse.cz, 
	rppt@kernel.org, surenb@google.com, mhocko@suse.com, horms@kernel.org, 
	linux-rdma@vger.kernel.org, bpf@vger.kernel.org, vishal.moola@gmail.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, May 26, 2025 at 1:12=E2=80=AFAM Byungchul Park <byungchul@sk.com> w=
rote:
>
> On Mon, May 26, 2025 at 12:08:58PM +0900, Byungchul Park wrote:
> > On Fri, May 23, 2025 at 10:13:27AM -0700, Mina Almasry wrote:
> > > On Thu, May 22, 2025 at 8:26=E2=80=AFPM Byungchul Park <byungchul@sk.=
com> wrote:
> > > >
> > > > To simplify struct page, the effort to seperate its own descriptor =
from
> > > > struct page is required and the work for page pool is on going.
> > > >
> > > > Use netmem descriptor and APIs for page pool in mlx5 code.
> > > >
> > > > Signed-off-by: Byungchul Park <byungchul@sk.com>
> > >
> > > Just FYI, you're racing with Nvidia adding netmem support to mlx5 as
> > > well. Probably they prefer to take their patch. So try to rebase on
> > > top of that maybe? Up to you.
> > >
> > > https://lore.kernel.org/netdev/1747950086-1246773-9-git-send-email-ta=
riqt@nvidia.com/
> > >
> > > I also wonder if you should send this through the net-next tree, sinc=
e
> > > it seem to race with changes that are going to land in net-next soon.
> > > Up to you, I don't have any strong preference. But if you do send to
> > > net-next, there are a bunch of extra rules to keep in mind:
> > >
> > > https://docs.kernel.org/process/maintainer-netdev.html
>
> It looks like I have to wait for net-next to reopen, maybe until the
> next -rc1 released..  Right?  However, I can see some patches posted now.
> Hm..
>

We try to stick to 15 patches, but I've seen up to 20 sometimes get reviewe=
d.

net-next just closed unfortunately, so yes you'll need to wait until
it reopens. RFCs are welcome in the meantime, and if you want to stick
to mm-unstable that's fine by me too, FWIW.

--=20
Thanks,
Mina

