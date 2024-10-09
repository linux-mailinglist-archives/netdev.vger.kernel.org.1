Return-Path: <netdev+bounces-133862-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 866589974DB
	for <lists+netdev@lfdr.de>; Wed,  9 Oct 2024 20:24:07 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 4E973281488
	for <lists+netdev@lfdr.de>; Wed,  9 Oct 2024 18:24:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 34EE41A704B;
	Wed,  9 Oct 2024 18:24:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="JAcNpSW/"
X-Original-To: netdev@vger.kernel.org
Received: from mail-qt1-f176.google.com (mail-qt1-f176.google.com [209.85.160.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8D0191A2567
	for <netdev@vger.kernel.org>; Wed,  9 Oct 2024 18:24:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.176
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728498243; cv=none; b=QHNr4fLQ/jh/36JM0mcZoJo04sjXY4FNpDX5RDysV4jlNqdlV7oeFNcjVDBnM8zLKzyj9qe2v+rACl8kNoM/p92Bd3n8RjQCpbZlNJJkxHVQ4YO3Wv3f2c5+I78zV138q9a8uWnzI6PjTKlrvnXR8LXkgydG9GY5Lpx1p8FWdm8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728498243; c=relaxed/simple;
	bh=Du7MxFnc9fJ5x2sDF7g7GL1lRTPGEzwbKzesjT+w9II=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=OZuftsIBawlIBUC/3orfDcHwPgnBIMQ5cGBSRSODyOpQZVNyKQP9WRYi4WoGx86QA6RHLiXtGM8BafFqFEOuKqXVOCEXUMxbG7DKkkitgIHO1U7o5cp0wZzZPIUHs6WoD/vbJ/SnATDAHHqZJFRbykKwVGcd9TXXqQznntIsPZg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=JAcNpSW/; arc=none smtp.client-ip=209.85.160.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-qt1-f176.google.com with SMTP id d75a77b69052e-4603d3e0547so39191cf.0
        for <netdev@vger.kernel.org>; Wed, 09 Oct 2024 11:24:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1728498240; x=1729103040; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=64u/Sszni0jrQotY6FrX9smK68t82YpAAEZc7XF+L40=;
        b=JAcNpSW/mGDNdhEnCyHChv7IX/+zKD1+q9p5iGRjX+4hPlWRm0q6kD2K6YmowHrxfL
         hrdti+HO21fCIK02Bcmm2kr1CHyHS+Dg/a7yFdZvq6kJoyL+DgoQ67ZpB7114FmcqJI5
         X2mSWOPh66yX8OaCEVqzcJ8vDXqDMqGmxXkHt3bqcnVIlODGTyvB/9Wyb6zPrix9CmYF
         L2eNZeOUJt8xYYxcTDyRdDTfDfzZm6lNy3c1PYgqwvV21Y39w5+BO1CYwy/HwYHEyow2
         sAvmM084CA1vsflKD9rXMCJ5VUsQoJ+efZZbVFDGkHLfqQlp+wO/9jrXcpe9MGFgrBW7
         P4bw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1728498240; x=1729103040;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=64u/Sszni0jrQotY6FrX9smK68t82YpAAEZc7XF+L40=;
        b=V0bMcCYDscIFC2M5sD3Th8X4fMLmhd7yqnOp3cHSa+mbsi/J+RZdF3ZSCmTmvjmmbd
         b2THWN0URWlCVmfuscVQXnEKtqIjd5Vgs8DtRowLWUqOMQ6UP1e+UAGSa8GSL/HTyGHI
         F+RUIk9W282wHguUTKThcG6iL4AkFM1sNDbApYFyKt0LT7a9O4uklUThYB8+LtyfFBF4
         4BqO5XonJLItziZt0aY2/si5lgSzAcQtCTabn3cML2TDsXnlMbTZONxa8TBrZL4GIgUa
         8jllsdKLfdEICGjWekb9IOe5XDxE87sR9pfrKuU+XLpB4PNEwqkIFTctFkpbjoswFWlG
         nSpw==
X-Forwarded-Encrypted: i=1; AJvYcCX+gJE7Z29MkTMKOSeqlzyCWiKzRlVJloEFzOKxLNsu80/2gYok8PtBRdAv0CsaznCg1aHcnU0=@vger.kernel.org
X-Gm-Message-State: AOJu0YwDTJbkzuC2YIqa7mw+Hw6e7+i9DIq1bgEnBKEfCyLOG9gmUL1J
	TTNoOUvmp/QE4O5qw0qiMS/G3zxSDMfqU0JqyJ914+r6ObKv/Wu7Zi2KqBNmfZHl85HZONYvLJW
	kUfaYtAIQHAPKYKAZBF6MDwM9NcjKmaK9TqBp
X-Google-Smtp-Source: AGHT+IExOfgiX94Y6FfFhkG7aRNZJVVTQbGwSdN5NB5R+9DGjQCq2MSHP/m0f0GW7YXBGfnlZ3Ewy5oToJJyOacJ4r8=
X-Received: by 2002:a05:622a:5497:b0:447:dbac:facd with SMTP id
 d75a77b69052e-46040469e85mr180651cf.24.1728498239982; Wed, 09 Oct 2024
 11:23:59 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <bdaaef9d-4364-4171-b82b-bcfc12e207eb@candelatech.com>
 <20241001193606.GA10530@breakpoint.cc> <CAJuCfpGyPNBQ=MTMeXzNZJcoiqok+zuW-3Ti0tFS7drhMFq1iQ@mail.gmail.com>
 <20241007112904.GA27104@breakpoint.cc> <CAJuCfpEDKkiXm1ye=gs3ohLDJM7gqQc0WwS=6egddbsZ1qRF9A@mail.gmail.com>
 <64e4009e-3a02-a139-4f82-f120f395e369@candelatech.com>
In-Reply-To: <64e4009e-3a02-a139-4f82-f120f395e369@candelatech.com>
From: Suren Baghdasaryan <surenb@google.com>
Date: Wed, 9 Oct 2024 11:23:47 -0700
Message-ID: <CAJuCfpH_g2ousOyUe19hwUpTGsQZa=w8sK9TCvU-aUsNKDdJTw@mail.gmail.com>
Subject: Re: nf-nat-core: allocated memory at module unload.
To: Ben Greear <greearb@candelatech.com>
Cc: Florian Westphal <fw@strlen.de>, netdev <netdev@vger.kernel.org>, kent.overstreet@linux.dev, 
	pablo@netfilter.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Oct 9, 2024 at 11:20=E2=80=AFAM Ben Greear <greearb@candelatech.com=
> wrote:
>
> On 10/7/24 08:10, Suren Baghdasaryan wrote:
> > On Mon, Oct 7, 2024 at 4:29=E2=80=AFAM Florian Westphal <fw@strlen.de> =
wrote:
> >>
> >> Suren Baghdasaryan <surenb@google.com> wrote:
> >>> On Tue, Oct 1, 2024 at 12:36=E2=80=AFPM Florian Westphal <fw@strlen.d=
e> wrote:
> >>>>
> >>>> Ben Greear <greearb@candelatech.com> wrote:
> >>>>
> >>>> [ CCing codetag folks ]
> >>>
> >>> Thanks! I've been on vacation and just saw this report.
> >>>
> >>>>
> >>>>> Hello,
> >>>>>
> >>>>> I see this splat in 6.11.0 (plus a single patch to fix vrf xmit dea=
dlock).
> >>>>>
> >>>>> Is this a known issue?  Is it a serious problem?
> >>>>
> >>>> Not known to me.  Looks like an mm (rcu)+codetag problem.
> >>>>
> >>>>> ------------[ cut here ]------------
> >>>>> net/netfilter/nf_nat_core.c:1114 module nf_nat func:nf_nat_register=
_fn has 256 allocated at module unload
> >>>>> WARNING: CPU: 1 PID: 10421 at lib/alloc_tag.c:168 alloc_tag_module_=
unload+0x22b/0x3f0
> >>>>> Modules linked in: nf_nat(-) btrfs ufs qnx4 hfsplus hfs minix vfat =
msdos fat
> >>>> ...
> >>>>> Hardware name: Default string Default string/SKYBAY, BIOS 5.12 08/0=
4/2020
> >>>>> RIP: 0010:alloc_tag_module_unload+0x22b/0x3f0
> >>>>>   codetag_unload_module+0x19b/0x2a0
> >>>>>   ? codetag_load_module+0x80/0x80
> >>>>>   ? up_write+0x4f0/0x4f0
> >>>>
> >>>> "Well, yes, but actually no."
> >>>>
> >>>> At this time, kfree_rcu() has been called on all 4 objects.
> >>>>
> >>>> Looks like kfree_rcu no longer cares even about rcu_barrier(), and
> >>>> there is no kvfree_rcu_barrier() in 6.11.
> >>>>
> >>>> The warning goes away when I replace kfree_rcu with call_rcu+kfree
> >>>> plus rcu_barrier in module exit path.
> >>>>
> >>>> But I don't think its the right thing to do.
>
> Hello,
>
> Is this approach just ugly, or plain wrong?

I think the approach is correct.

>
> kvfree_rcu_barrier does not existing in 6.10 kernel.

Yeah, I'll try backporting kvfree_rcu_barrier() to 6.10 and 6.11 for
this change.

>
> Thanks,
> Ben
>
> >>>>
> >>>> (referring to nf_nat_unregister_fn(), kfree_rcu(priv, rcu_head);).
> >>>>
> >>>> Reproducer:
> >>>> unshare -n iptables-nft -t nat -A PREROUTING -p tcp
> >>>> grep nf_nat /proc/allocinfo # will list 4 allocations
> >>>> rmmod nft_chain_nat
> >>>> rmmod nf_nat                # will WARN.
> >>>>
> >>>> Without rmmod, the 4 allocations go away after a few seconds,
> >>>> grep will no longer list them and then rmmod won't splat.
> >>>
> >>> I see. So, the kfree_rcu() was already called but freeing did not
> >>> happen yet, in the meantime we are unloading the module.
> >>
> >> Yes.
> >>
> >>> We could add
> >>> a synchronize_rcu() at the beginning of codetag_unload_module() so
> >>> that all pending kfree_rcu()s complete before we check codetag
> >>> counters:
> >>>
> >>> bool codetag_unload_module(struct module *mod)
> >>> {
> >>>          struct codetag_type *cttype;
> >>>          bool unload_ok =3D true;
> >>>
> >>>          if (!mod)
> >>>                  return true;
> >>>
> >>> +      synchronize_rcu();
> >>>          mutex_lock(&codetag_lock);
> >>
> >> This doesn't help as kfree_rcu doesn't wait for this.
> >>
> >> Use of kvfree_rcu_barrier() instead does work though.
> >
> > I see. That sounds like an acceptable fix. Please post it and I'll ack =
it.
> > Thanks!
> >
> --
> Ben Greear <greearb@candelatech.com>
> Candela Technologies Inc  http://www.candelatech.com
>
>

