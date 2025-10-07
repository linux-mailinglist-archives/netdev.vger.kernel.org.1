Return-Path: <netdev+bounces-228135-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 39799BC29CC
	for <lists+netdev@lfdr.de>; Tue, 07 Oct 2025 22:18:40 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 1C97A19A0786
	for <lists+netdev@lfdr.de>; Tue,  7 Oct 2025 20:19:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 98E2923C39A;
	Tue,  7 Oct 2025 20:18:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="b7+TXXTm"
X-Original-To: netdev@vger.kernel.org
Received: from mail-wr1-f44.google.com (mail-wr1-f44.google.com [209.85.221.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1D9B623BF9B
	for <netdev@vger.kernel.org>; Tue,  7 Oct 2025 20:18:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759868316; cv=none; b=gZfVnOim7+SyMtg7u5z+nCuREY8VmmeuhYSVnn0F10Nq1EhN/cpDbUBK195R+ObHPHo+ckHaVIlUU2VUeMKbdigNT+uCRuy/XHpmdn0GVnQEgAccRYnSOBq8I0/Ut9AeI3ezzeR/tRC/O8ya4X3kvsNtwmJFPXDqFHh7potNV6Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759868316; c=relaxed/simple;
	bh=dNU8UXH/ENCXuaXWpy+ZfpFYCLrtH2DlLCqzHRgdzgQ=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=uhA//m2zHxdaXgoxB+SpXKI1b+cGAUJAj8F9CvwyFLOcsknebUvhezGX0y2b8OZvfKmhsqG7bv4A7FiatuG+4CPpGX5wV7pJByngOHezz2ouhP66pHI+V1W3DTjXi6k88IsT227Ecer9B5yR4KzAESlismHhKF2gecAQ8fVbUss=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=b7+TXXTm; arc=none smtp.client-ip=209.85.221.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wr1-f44.google.com with SMTP id ffacd0b85a97d-3ecdf2b1751so4715796f8f.0
        for <netdev@vger.kernel.org>; Tue, 07 Oct 2025 13:18:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1759868312; x=1760473112; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=wsn7msj+eKWWk4DGa/To+QxHGGNxWaA55CM+X/OmR4M=;
        b=b7+TXXTmOpeu0p6tlw2p8wELlNH8KpDUcJhiAgUMLEw9ebYTLPVj6oR2SBtQtZa+7z
         GpFbaU/OfFAAK0iCKi0qsnGm6L7zEZTdMq7f4EUELFd2x9R3MUqPYanUf0VqCE4wwU86
         Cm2fRPdNCZ6nksdr4zNbH3q+3nfJuvjfjZJtbFSk+wJXk6bhri7flqX1YxONEfRBspyP
         7FN2ErQ5QyOu/d8ZbmdXJo8QIjwsq8uORHEnVttkBLkwQeBSLaVhFzmqWmb8ZPHzbN6b
         xdS0tbFqAzu8pkqeqGmvLEG1wch/JDQwt8bqCjNQ/dB7P2tMYxsfuIvGNJvBCJyetaS+
         avyg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1759868312; x=1760473112;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=wsn7msj+eKWWk4DGa/To+QxHGGNxWaA55CM+X/OmR4M=;
        b=OskCVoxrzjChREvS//MfReSFbdcha/6CQp4w8h2GOA4DjRh2hCTkaZcoor2Eu4xX0h
         hVfFDZhWUASTMPAOBLQjSzSA6GDc7qSnnWpN1yBmVtGd1aB5lyCYVOUFRc/AimlplHUk
         NisAo0YkJ8G9XliFdhitikiJa2IgT+rfhK7YYpOI89HkkuPGOzZRXESjWmNstMb4tPwl
         8X62fjhSTgR8Ae0sMd3+QPjVplC9Hm9JgSfA1HNb7LM0hN+OnD2dTlNu0jS4NmCewuSu
         NX7U/73sXJDF6Wq0rgBtupdSy5dks5FqKR3ytIFE4aWPuRHglqiYufl0tDaBqkTH2AEw
         8fEw==
X-Forwarded-Encrypted: i=1; AJvYcCWjrLFyPgKWyRDUOme/CWghDBrgSxiiWJ/BPEPp7zHRblcPRVwoGH9/tLgHCmONOhUwEMIdga4=@vger.kernel.org
X-Gm-Message-State: AOJu0YwUzxr/GofZs60SMiDfLli6IVS9U+YOYrPKbHavaTZ96nnQ0eTZ
	JBcvVaZ1O8Dj8Bslb2Y2LnAzy076ERHrMkqHS1qRQYZvMW4OkDXD5D/MVqrMEtNhNCMXpRs+70T
	AbXi1cJvaWZiplIHQTknsRI/eGd4k3g0=
X-Gm-Gg: ASbGncsgAF6krD0Va5Qgcs1LaRTvwJXRHnJ4qJUyBhtpkAiAUDlXkAZyyv9H/+4k5LH
	dobIU5aueUa53jgwAW1CXT5iPSqpiSwGtSGlBRsSsuAw0R3139uZqAVjLgtkWUNnDZAJ00Bt5ws
	ZRkN+a9h0p7GkymMz0u/cl6parEAfYnX6KyzkMgr7DbcAtjyPf+SrUEekakvmnFMuu2b8PJw/Jd
	m1DrW2faQMXbtUNOqRH80DSna89xd2SIdSX8ST9P12XqwA=
X-Google-Smtp-Source: AGHT+IHybdSPOBru1vuVi+jUqKuFtL09CEMcyz9PofdneFjgygELkxE37MwoGUjxQdjcHhDDFCiFi7vrXN9ljQEdQTg=
X-Received: by 2002:a05:6000:3111:b0:3e4:5717:368e with SMTP id
 ffacd0b85a97d-42666ac61bcmr308649f8f.2.1759868311717; Tue, 07 Oct 2025
 13:18:31 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20251003140243.2534865-1-maciej.fijalkowski@intel.com>
 <20251003140243.2534865-2-maciej.fijalkowski@intel.com> <CAADnVQLGocfOT224=9_nJZ6093QDh1M_EDLQ3cNVQZKEDnjwog@mail.gmail.com>
 <aOVsbMAkfc5gv0vO@boxer>
In-Reply-To: <aOVsbMAkfc5gv0vO@boxer>
From: Alexei Starovoitov <alexei.starovoitov@gmail.com>
Date: Tue, 7 Oct 2025 13:18:18 -0700
X-Gm-Features: AS18NWAFPm4pBz65dJYtmCrieN5eLDF6q1nGyQWJvcT-yzIv6_PJ2Dqe4GCdJY8
Message-ID: <CAADnVQLEQ35S0n+GN6wn1ybPW3=SJhidp=f1z5fmq08kQ4ndJA@mail.gmail.com>
Subject: Re: [PATCH bpf 1/2] xdp: update xdp_rxq_info's mem type in XDP
 generic hook
To: Maciej Fijalkowski <maciej.fijalkowski@intel.com>
Cc: bpf <bpf@vger.kernel.org>, Alexei Starovoitov <ast@kernel.org>, 
	Daniel Borkmann <daniel@iogearbox.net>, Jesper Dangaard Brouer <hawk@kernel.org>, 
	Ilias Apalodimas <ilias.apalodimas@linaro.org>, =?UTF-8?B?VG9rZSBIw7hpbGFuZC1Kw7hyZ2Vuc2Vu?= <toke@redhat.com>, 
	Lorenzo Bianconi <lorenzo@kernel.org>, Network Development <netdev@vger.kernel.org>, 
	"Karlsson, Magnus" <magnus.karlsson@intel.com>, Andrii Nakryiko <andrii@kernel.org>, 
	Stanislav Fomichev <stfomichev@gmail.com>, Alexander Lobakin <aleksander.lobakin@intel.com>, 
	syzbot+ff145014d6b0ce64a173@syzkaller.appspotmail.com, 
	Ihor Solodrai <ihor.solodrai@linux.dev>, Octavian Purdila <tavip@google.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Oct 7, 2025 at 12:39=E2=80=AFPM Maciej Fijalkowski
<maciej.fijalkowski@intel.com> wrote:
>
> On Fri, Oct 03, 2025 at 10:29:08AM -0700, Alexei Starovoitov wrote:
> > On Fri, Oct 3, 2025 at 7:03=E2=80=AFAM Maciej Fijalkowski
> > <maciej.fijalkowski@intel.com> wrote:
> > >
> > > Currently, generic XDP hook uses xdp_rxq_info from netstack Rx queues
> > > which do not have its XDP memory model registered. There is a case wh=
en
> > > XDP program calls bpf_xdp_adjust_tail() BPF helper that releases
> > > underlying memory. This happens when it consumes enough amount of byt=
es
> > > and when XDP buffer has fragments. For this action the memory model
> > > knowledge passed to XDP program is crucial so that core can call
> > > suitable function for freeing/recycling the page.
> > >
> > > For netstack queues it defaults to MEM_TYPE_PAGE_SHARED (0) due to la=
ck
> > > of mem model registration. The problem we're fixing here is when kern=
el
> > > copied the skb to new buffer backed by system's page_pool and XDP buf=
fer
> > > is built around it. Then when bpf_xdp_adjust_tail() calls
> > > __xdp_return(), it acts incorrectly due to mem type not being set to
> > > MEM_TYPE_PAGE_POOL and causes a page leak.
> > >
> > > For this purpose introduce a small helper, xdp_update_mem_type(), tha=
t
> > > could be used on other callsites such as veth which are open to this
> > > problem as well. Here we call it right before executing XDP program i=
n
> > > generic XDP hook.
> > >
> > > This problem was triggered by syzbot as well as AF_XDP test suite whi=
ch
> > > is about to be integrated to BPF CI.
> > >
> > > Reported-by: syzbot+ff145014d6b0ce64a173@syzkaller.appspotmail.com
> > > Closes: https://lore.kernel.org/netdev/6756c37b.050a0220.a30f1.019a.G=
AE@google.com/
> > > Fixes: e6d5dbdd20aa ("xdp: add multi-buff support for xdp running in =
generic mode")
> > > Tested-by: Ihor Solodrai <ihor.solodrai@linux.dev>
> > > Co-developed-by: Octavian Purdila <tavip@google.com>
> > > Signed-off-by: Octavian Purdila <tavip@google.com> # whole analysis, =
testing, initiating a fix
> > > Signed-off-by: Maciej Fijalkowski <maciej.fijalkowski@intel.com> # co=
mmit msg and proposed more robust fix
> > > ---
> > >  include/net/xdp.h | 7 +++++++
> > >  net/core/dev.c    | 2 ++
> > >  2 files changed, 9 insertions(+)
> > >
> > > diff --git a/include/net/xdp.h b/include/net/xdp.h
> > > index f288c348a6c1..5568e41cc191 100644
> > > --- a/include/net/xdp.h
> > > +++ b/include/net/xdp.h
> > > @@ -336,6 +336,13 @@ xdp_update_skb_shared_info(struct sk_buff *skb, =
u8 nr_frags,
> > >         skb->pfmemalloc |=3D pfmemalloc;
> > >  }
> > >
> > > +static inline void
> > > +xdp_update_mem_type(struct xdp_buff *xdp)
> > > +{
> > > +       xdp->rxq->mem.type =3D page_pool_page_is_pp(virt_to_page(xdp-=
>data)) ?
> > > +               MEM_TYPE_PAGE_POOL : MEM_TYPE_PAGE_SHARED;
> > > +}
> >
> > AI says that it's racy and I think it's onto something.
> > See
> > https://github.com/kernel-patches/bpf/actions/runs/18224704286/job/5189=
2959919
> > and
> > https://github.com/kernel-patches/bpf/actions/runs/18224704286/job/5189=
2959937
>
> How do we respond to this in future?

The bot will start sending emails eventually, so developers can
respond directly with email to maintainers.

> On first one AI missed the fact we run under napi so two cpus won't play
> with same rx queue concurrently. The second is valid thing to be fixed.

Good point about napi.

