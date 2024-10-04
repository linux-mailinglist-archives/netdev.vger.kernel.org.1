Return-Path: <netdev+bounces-132288-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 1C7309912D7
	for <lists+netdev@lfdr.de>; Sat,  5 Oct 2024 01:13:51 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id A2C26B22FBF
	for <lists+netdev@lfdr.de>; Fri,  4 Oct 2024 23:13:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1435D146000;
	Fri,  4 Oct 2024 23:13:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="rgCxxXvk"
X-Original-To: netdev@vger.kernel.org
Received: from mail-qt1-f177.google.com (mail-qt1-f177.google.com [209.85.160.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 734631BF24
	for <netdev@vger.kernel.org>; Fri,  4 Oct 2024 23:13:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728083624; cv=none; b=Hv419VUFo5oa8mP1tGNO+EeyKmUxSnhB06hkXzK8SkG/GlHQ01vq33PQ8nWmh5f+iHT2vQMIweAZapbo6YwqPVrwv/WhHxl36SbRXih9hhmdayaxMEAf2JPW1TwZYx+wWZJwk9MtHw6jrPDV54hpchpT5jdfT9+INaSQwqdXFkM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728083624; c=relaxed/simple;
	bh=gbRPKMB1SNb1ehJgLfvlcHBra/aECc4nEiduSlmuSZw=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=KzrHdI0FnWfWeneprk6LTU2haCvLQrrIuOe1oF+dnRWtmz4GAfuzEI7b67yhV1QQmOq79e+EOfJZ879q1zQxh1UH5qbFab9+oNyLdQumr42QjHibWoyxgY6kJjJ+YBSCdlXuoMr0vlcIsl7G+1Kk0/ts/uuggD8JML3zVvtTNdw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=rgCxxXvk; arc=none smtp.client-ip=209.85.160.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-qt1-f177.google.com with SMTP id d75a77b69052e-4581cec6079so92631cf.0
        for <netdev@vger.kernel.org>; Fri, 04 Oct 2024 16:13:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1728083621; x=1728688421; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=l5nF8kPXlszWtLW1pc3Yzsh/1zN9c/7fuO4eQR8EnH0=;
        b=rgCxxXvkpeSM7el49istVPEW0TxVC24bKIGRTnoMJkQq4YwBtFxwIiYKYDKCIuhNLj
         cGZyxsNCKqKTbeE/UXdjhBY7V6XCr0gJAZ9wYqT3jxRK2/ucJUHJLsOPaYT0S7aBtHgZ
         pyAVLBxWLUhjdB4lwXBzOWlkLE638pj0tzkZj+TPAlV/gjZpl/eSKoAFlN9xLDecyy3M
         fcSUUhb4OGVce/MMMH5zcOPj4rAmTzYfvJmWyBLcpY5awoV35I/rJgMgm5lajA7ePTQX
         YqdMLktxHvWgZ/TV6yB/6SbT3Vg5ABg/6tgV6s3Yv+aE4gq6HdnVE/dkCwBLtKCqQlvm
         KjLg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1728083621; x=1728688421;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=l5nF8kPXlszWtLW1pc3Yzsh/1zN9c/7fuO4eQR8EnH0=;
        b=l2+PwUEQCCNjLUbEegP8VD0NabYxuerEs+aSuB0+1W8bLPooswki8T+mxuC5L+xJVm
         QURDKqS1N9i/3zuTezycvl3hgVyXu0171pgOl6aZlStm++QlQragYpuV7rep2pIxjsNT
         hipSJHumBwxWzjg1RdymH0yxFBo9MLTuwUfG6dQK5zrK9yvgD2DfSzN5TTcsEZlAGFhb
         pSLHQhV4FwU6LeWa8kEkHKjGVyah5SCRHPIg5vAASt3Zi2i2liPnJ4msXu6FOUOVsf+r
         X9eWBRSjBb33qMqaxugxouBckuohpCbgDNFKlYTCgIlrGdg2ov7y21DGiW+AR0eqG+t7
         uzjQ==
X-Forwarded-Encrypted: i=1; AJvYcCWtU5bOUDDD8qDIUjL8FBqMNfSQeb3+NA9pHhRvd3h6KIq8JmSn8zYiwomoRwQJveeQKxIfI7U=@vger.kernel.org
X-Gm-Message-State: AOJu0Yzn0ou6cEEKKN/PFN5nkQxqWJZ82pSk2KQ5VvIzl78rECPc3cVS
	km388ohpovBdbwTbplTBefpkXMwgSWt72dQwJCtKF1Yf9QaRpqeu0wtULTvVw6oQmJ5Ba0/qIA+
	x3MPOmXqnmNsOQRxXbbMkaNaNbDbEc4/LkXXy
X-Google-Smtp-Source: AGHT+IF/pZIrJ06Ua0hv5UzWqUJEMUlykdps7dgPHY0tI18MLf4pmrffG15AoLquBweKZy/B9Biy9pexirBpAufjg4A=
X-Received: by 2002:a05:622a:a38c:b0:447:e59b:54eb with SMTP id
 d75a77b69052e-45da8827780mr1114561cf.26.1728083620988; Fri, 04 Oct 2024
 16:13:40 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <bdaaef9d-4364-4171-b82b-bcfc12e207eb@candelatech.com> <20241001193606.GA10530@breakpoint.cc>
In-Reply-To: <20241001193606.GA10530@breakpoint.cc>
From: Suren Baghdasaryan <surenb@google.com>
Date: Fri, 4 Oct 2024 16:13:26 -0700
Message-ID: <CAJuCfpGyPNBQ=MTMeXzNZJcoiqok+zuW-3Ti0tFS7drhMFq1iQ@mail.gmail.com>
Subject: Re: nf-nat-core: allocated memory at module unload.
To: Florian Westphal <fw@strlen.de>
Cc: Ben Greear <greearb@candelatech.com>, netdev <netdev@vger.kernel.org>, 
	kent.overstreet@linux.dev, pablo@netfilter.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Oct 1, 2024 at 12:36=E2=80=AFPM Florian Westphal <fw@strlen.de> wro=
te:
>
> Ben Greear <greearb@candelatech.com> wrote:
>
> [ CCing codetag folks ]

Thanks! I've been on vacation and just saw this report.

>
> > Hello,
> >
> > I see this splat in 6.11.0 (plus a single patch to fix vrf xmit deadloc=
k).
> >
> > Is this a known issue?  Is it a serious problem?
>
> Not known to me.  Looks like an mm (rcu)+codetag problem.
>
> > ------------[ cut here ]------------
> > net/netfilter/nf_nat_core.c:1114 module nf_nat func:nf_nat_register_fn =
has 256 allocated at module unload
> > WARNING: CPU: 1 PID: 10421 at lib/alloc_tag.c:168 alloc_tag_module_unlo=
ad+0x22b/0x3f0
> > Modules linked in: nf_nat(-) btrfs ufs qnx4 hfsplus hfs minix vfat msdo=
s fat
> ...
> > Hardware name: Default string Default string/SKYBAY, BIOS 5.12 08/04/20=
20
> > RIP: 0010:alloc_tag_module_unload+0x22b/0x3f0
> >  codetag_unload_module+0x19b/0x2a0
> >  ? codetag_load_module+0x80/0x80
> >  ? up_write+0x4f0/0x4f0
>
> "Well, yes, but actually no."
>
> At this time, kfree_rcu() has been called on all 4 objects.
>
> Looks like kfree_rcu no longer cares even about rcu_barrier(), and
> there is no kvfree_rcu_barrier() in 6.11.
>
> The warning goes away when I replace kfree_rcu with call_rcu+kfree
> plus rcu_barrier in module exit path.
>
> But I don't think its the right thing to do.
>
> (referring to nf_nat_unregister_fn(), kfree_rcu(priv, rcu_head);).
>
> Reproducer:
> unshare -n iptables-nft -t nat -A PREROUTING -p tcp
> grep nf_nat /proc/allocinfo # will list 4 allocations
> rmmod nft_chain_nat
> rmmod nf_nat                # will WARN.
>
> Without rmmod, the 4 allocations go away after a few seconds,
> grep will no longer list them and then rmmod won't splat.

I see. So, the kfree_rcu() was already called but freeing did not
happen yet, in the meantime we are unloading the module. We could add
a synchronize_rcu() at the beginning of codetag_unload_module() so
that all pending kfree_rcu()s complete before we check codetag
counters:

bool codetag_unload_module(struct module *mod)
{
        struct codetag_type *cttype;
        bool unload_ok =3D true;

        if (!mod)
                return true;

+      synchronize_rcu();
        mutex_lock(&codetag_lock);

Could you please try the above one-line change and see if that fixes the is=
sue?

BTW, I'm working on some optimizations and once
https://lore.kernel.org/all/20240902044128.664075-3-surenb@google.com
gets accepted this issue will be eliminated altogether.
Thanks,
Suren.

>

