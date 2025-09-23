Return-Path: <netdev+bounces-225595-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 3EDA2B95D67
	for <lists+netdev@lfdr.de>; Tue, 23 Sep 2025 14:23:13 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 2982319C3099
	for <lists+netdev@lfdr.de>; Tue, 23 Sep 2025 12:23:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 703F13233E6;
	Tue, 23 Sep 2025 12:23:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="LY41MA3X"
X-Original-To: netdev@vger.kernel.org
Received: from mail-qt1-f182.google.com (mail-qt1-f182.google.com [209.85.160.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A3702322DD8
	for <netdev@vger.kernel.org>; Tue, 23 Sep 2025 12:23:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758630188; cv=none; b=a1DeMpHGbkKDKHUTII1az9kki1FLae4cBDWsFFtOTrXkzcBnANOUe4Vn8NkIxv3ciDOO1g4r7uirbh50g/Yz7EUctfgKFVPN5y7PDFPGQyjA/oT423kzZoznCdu6JmnljZIDlQW1QY6DdsXfCrZsd2fRlRvhyVklsSfkrD8KOHk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758630188; c=relaxed/simple;
	bh=BFGnLkTyxG5CWj434DyaihpV1L3IRvyU9N1P1Uas47s=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=bV1HyLmhTzABF5hlyxSE6NYtOZVq/1Isr63JxKLg+IvxYJnry4bRPBhRHHP63H4oiL9bX7b5h79wvPUcjH0ftLL48lf9s7ZbxKOaNOSIiz+G2mFnuo5NXPSjNZ35gQAkvVQsPemIT9lL9izMXKgbryvLdxQnEoykIN+7tuzLPx0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=LY41MA3X; arc=none smtp.client-ip=209.85.160.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-qt1-f182.google.com with SMTP id d75a77b69052e-4b61161dd37so35916181cf.3
        for <netdev@vger.kernel.org>; Tue, 23 Sep 2025 05:23:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1758630185; x=1759234985; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=RYw72GHSIaVFNAW7nyagklGsuEGPDFWwsCJHXkPOGuQ=;
        b=LY41MA3Xjgt1LSvyIMnym91lq+Jv9Ck0EL5UWx2WgStqqpD7/tib32nECZuyNw2mFx
         i8IUlUy929Kj5i+d9FW7N8VQPY/P24TYhYFKwtxq2ND6iRECFTuIrvFnZGwzkWzdNMyn
         92YUrZmrDA/uIjgiuvDQaJ+UzfluRoTbboOdQUjOQbE0bkYrCNB9EKcBdojszmK96N7w
         NiyVrS7xD7q1B/J7Ke5hyqcK7kOyjL79rTLk0DpaTggPmHVUx6+mtEEdhXCxsxEH2b/H
         ZJaEVxdLVAsFtmQPH1TPs7f8RooNcsX8iJaHIqMhf1TDC69rQKq74WPY6koeW9viwiTu
         vVjg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1758630185; x=1759234985;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=RYw72GHSIaVFNAW7nyagklGsuEGPDFWwsCJHXkPOGuQ=;
        b=AQ4d4Wz/cPm1e3f1nvJF+gcGAGTufd4I1EfqamiSA127zJRrlfbWeIdUCJTwHPKG4f
         XI5pGUkZGfG182+M5ip0mLeLL5ejYoc4sQ36N/Fpig/lO7oh6ShQbjOUmZ1aD/HMltlB
         diWeA56r892MbzFDydjXD7CKm3NfNaFe9YqYdLveDQ1G3FuIWgrIGtc/q/t6V1TJQ6oI
         89EeCguiQy9f+lKbY3ojffexc3XRefX3VyYPIC4ZyGVOtqpGYANaJg6MV+PquAZLY0me
         x2epRUe8qInH6VDo5QC48sm9LDxjyEa7RaQnOQr76aFhErq8odjqcJTHaqB0bOOpgScv
         ocTg==
X-Forwarded-Encrypted: i=1; AJvYcCXLfEiJ3Z1SOYHT4SRILB4oca9nCnyQUzFzNC26OacMgkpt9/2hiLYpZi2lNJ8WNdicRLDNh90=@vger.kernel.org
X-Gm-Message-State: AOJu0YyQ6fPBt3ioFiIdld6lSauCIfhCZAln4H6vzFTB//xRRyzskdvv
	GX3F0Znym8pNorL7Xu4G0N6+Yh4Fd5wQsWS3a7K2jFBA+Nw/y0jFPCTuoSBLYdvVH2tbPg2lQiA
	poNmbZdKloMKFXGIhHxbA2s10cB6D4dVn1iD3dSpv
X-Gm-Gg: ASbGncuWmxPUkb/U/KL4XZ2CouGIacZ7HmdyPfmgkX7JS7NRQrnnYAGE7J/gwmZ/7o2
	iVJlB3XQBhk6QCL1lSb9n4o2km3+J7AsS+T9MRfVDs3LdLx5lup9srt6b3GJmCVW3RSlTyaJ79b
	3kJ13HlOlzxIgKm+p97NPU14x4y8y6YvuA+D5/aTLBhit6D7Xjp8dCxUHVAcUtm4tR2C9irf1sA
	YEfjIOghEoiAGcn6TRJHK1I
X-Google-Smtp-Source: AGHT+IGrYM8VhDBIAtWE43v7Xjqcz7XbiOUMkh1bakAOuayQn0Wv4K6UIIEuTrU/vgHY/Ua3HMXnzBUdkjKU0pZUwSs=
X-Received: by 2002:ac8:5a41:0:b0:4b7:aa52:a710 with SMTP id
 d75a77b69052e-4d372f06fedmr22809391cf.80.1758630184946; Tue, 23 Sep 2025
 05:23:04 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250922194819.182809-1-d-tatianin@yandex-team.ru>
 <20250922194819.182809-2-d-tatianin@yandex-team.ru> <CANn89i+GoVZLcdHxuf33HpmgyPNKxGqEjXGpi=XiB-QOsAG52A@mail.gmail.com>
 <5f1ff52a-d2c2-40de-b00c-661b75c18dc7@yandex-team.ru> <aNKGWZSxY9RC0VWS@strlen.de>
 <348f209e-89bc-4289-aaf9-e57437e31b0d@yandex-team.ru>
In-Reply-To: <348f209e-89bc-4289-aaf9-e57437e31b0d@yandex-team.ru>
From: Eric Dumazet <edumazet@google.com>
Date: Tue, 23 Sep 2025 05:22:53 -0700
X-Gm-Features: AS18NWCUlsVncWRX_rIi2JXd1cRtLKWu7ITQJaelz93wkMzIZ5RXOIaaUsfTDD0
Message-ID: <CANn89iKDXXjf-OFu+oAYfKp9WOdq4v=HBWpFn=7HRNUCy_9RFg@mail.gmail.com>
Subject: Re: [PATCH 1/3] netfilter/x_tables: go back to using vmalloc for xt_table_info
To: Daniil Tatianin <d-tatianin@yandex-team.ru>
Cc: Florian Westphal <fw@strlen.de>, Pablo Neira Ayuso <pablo@netfilter.org>, 
	Jozsef Kadlecsik <kadlec@netfilter.org>, Phil Sutter <phil@nwl.cc>, 
	"David S. Miller" <davem@davemloft.net>, David Ahern <dsahern@kernel.org>, 
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, Simon Horman <horms@kernel.org>, 
	netfilter-devel@vger.kernel.org, coreteam@netfilter.org, 
	linux-kernel@vger.kernel.org, netdev@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Sep 23, 2025 at 5:04=E2=80=AFAM Daniil Tatianin
<d-tatianin@yandex-team.ru> wrote:
>
> On 9/23/25 2:36 PM, Florian Westphal wrote:
>
> > Daniil Tatianin <d-tatianin@yandex-team.ru> wrote:
> >>> On Mon, Sep 22, 2025 at 12:48=E2=80=AFPM Daniil Tatianin
> >>> <d-tatianin@yandex-team.ru> wrote:
> >>>> This code previously always used vmalloc for anything above
> >>>> PAGE_ALLOC_COSTLY_ORDER, but this logic was changed in
> >>>> commit eacd86ca3b036 ("net/netfilter/x_tables.c: use kvmalloc() in x=
t_alloc_table_info()").
> >>>>
> >>>> The commit that changed it did so because "xt_alloc_table_info()
> >>>> basically opencodes kvmalloc()", which is not actually what it was
> >>>> doing. kvmalloc() does not attempt to go directly to vmalloc if the
> >>>> order the caller is trying to allocate is "expensive", instead it on=
ly
> >>>> uses vmalloc as a fallback in case the buddy allocator is not able t=
o
> >>>> fullfill the request.
> >>>>
> >>>> The difference between the two is actually huge in case the system i=
s
> >>>> under memory pressure and has no free pages of a large order. Before=
 the
> >>>> change to kvmalloc we wouldn't even try going to the buddy allocator=
 for
> >>>> large orders, but now we would force it to try to find a page of the
> >>>> required order by waking up kswapd/kcompactd and dropping reclaimabl=
e memory
> >>>> for no reason at all to satisfy our huge order allocation that could=
 easily
> >>>> exist within vmalloc'ed memory instead.
> >>> This would hint at an issue with kvmalloc(), why not fixing it, inste=
ad
> >>> of trying to fix all its users ?
> > I agree with Eric.  There is nothing special in xtables compared to
> > kvmalloc usage elsewhere in the stack.  Why "fix" xtables and not e.g.
> > rhashtable?
> >
> > Please work with mm hackers to improve the situation for your use case.
> >
> > Maybe its enough to raise __GFP_NORETRY in kmalloc_gfp_adjust() if size
> > results in >=3D PAGE_ALLOC_COSTLY_ORDER allocation.
>
> Thanks for your reply! Perhaps this is the way to go, although this
> might have
> much broader implications since there are tons of other callers to take
> into account.
>
> I'm not sure whether rhashtable's size also directly depends on user
> input, I was only
> aware of x_table since this is the case we ran into specifically.
>
> >
> >> Thanks for the quick reply! From my understanding, there is a lot of
> >> callers of kvmalloc
> >> who do indeed benefit from the physical memory being contiguous, becau=
se
> >> it is then
> >> used for hardware DMA etc., so I'm not sure that would be feasible.
> > How can that work?  kvmalloc won't make vmalloc backed memory
> > physically contiguous.
>
> The allocated physical memory won't be contiguous only for fallback
> cases (which should be rare),
> I assume in that case the hardware operation may end up being more
> expensive with larger scatter-gather
> lists etc. So most of the time such code can take optimized paths for
> fully contiguous memory. This is not
> the case for x_tables etc.

At least some years ago, we were seeing a performance difference.

x_tables data is often read sequentially, I do not know if modern
cpus hardware prefetches use TLB (virtual space). I do not know
if they can span a 4K page, even if physically contiguous.


Some context :

commit 6c5ab6511f718c3fb19bcc3f78a90b0e0b601675
Author: Michal Hocko <mhocko@suse.com>
Date:   Mon May 8 15:57:15 2017 -0700

    mm: support __GFP_REPEAT in kvmalloc_node for >32kB

    vhost code uses __GFP_REPEAT when allocating vhost_virtqueue resp.
    vhost_vsock because it would really like to prefer kmalloc to the
    vmalloc fallback - see 23cc5a991c7a ("vhost-net: extend device
    allocation to vmalloc") for more context.  Michael Tsirkin has also
    noted:

commit 23cc5a991c7a9fb7e6d6550e65cee4f4173111c5
Author: Michael S. Tsirkin <mst@redhat.com>
Date:   Wed Jan 23 21:46:47 2013 +0100

    vhost-net: extend device allocation to vmalloc

