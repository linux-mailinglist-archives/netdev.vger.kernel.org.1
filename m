Return-Path: <netdev+bounces-132762-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 3014B9930CC
	for <lists+netdev@lfdr.de>; Mon,  7 Oct 2024 17:11:59 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 93EAEB26DF3
	for <lists+netdev@lfdr.de>; Mon,  7 Oct 2024 15:11:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 398D51DFF7;
	Mon,  7 Oct 2024 15:10:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="Yuthbse0"
X-Original-To: netdev@vger.kernel.org
Received: from mail-il1-f179.google.com (mail-il1-f179.google.com [209.85.166.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 87AB71D88CD
	for <netdev@vger.kernel.org>; Mon,  7 Oct 2024 15:10:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728313838; cv=none; b=t2PpOK6eQ3Aj0jvC/uX2GBeYFl6BrttQedY1L9RhL/ye6nbC0EUHEXCcJ9vJSRU/5I3/AVv2qsvraRRYv58nsJRYtpSDlPjAChMrwaS5luclpcqYbpzASwucqgZ4H2Q2/MZTBqYmz8I6U64iZCJ0lQK17f/jWpqP9hFH86/O+vg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728313838; c=relaxed/simple;
	bh=uisIxR2PKZ6QtDzKoBXL1kDMAp9MYL8rZsZHTYYAjEg=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=tsR7qYSw0803aGkGGdDisifUBIWCxttYw10x/sdIQ/SGCesn4rU8ecX9twEO42kYpebUDTuMPQDBfUnZGfPMJQd1Z7A4nfMvKV0yWo9N6MEJiWllxsjedSKmWvFGmLcD/6ReT03CEIbPfmL7T4zVtpWBddmSNfz9UYVkF5lNkfw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=Yuthbse0; arc=none smtp.client-ip=209.85.166.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-il1-f179.google.com with SMTP id e9e14a558f8ab-3a36ad4980bso684295ab.0
        for <netdev@vger.kernel.org>; Mon, 07 Oct 2024 08:10:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1728313835; x=1728918635; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=yG/pC1j83pacdSk/k7eGfmJ+vi3pUz+nE4h5FGr0zUg=;
        b=Yuthbse0q4Ulcd+eK7DSuBt42gF8rc2UYpxpc4SdHVhUcB3Nt9rdVHIQ1Vt+HkQC37
         E9je4SMpYZNDUHRFl2+/bnoOqIN7cAmCWG532Ck/GBpL8i32NagpcqeS9RM/veeQLJHk
         hs30EpJqGTfxhcNPzqp5qCd66f0e4PO6NUSU1xCngbo8L1Cl2aLQDgwp9pVenSrO8gn2
         vGzMfTpGTQQ1CkpXdD8CoPZjbG+B99JaCVodEF7Bq/vVd2ubUMU51kdZcgYH6t9Kwk11
         q6XCc1GAEk7s3QQ2DIYJfBA/oHzwj/Pgwd2x1UBXI4iKrz0/PqJT29GvFJLsxcDRm+go
         MCDQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1728313835; x=1728918635;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=yG/pC1j83pacdSk/k7eGfmJ+vi3pUz+nE4h5FGr0zUg=;
        b=TgYRI34DtjxNg1DMYpZCJPUhiSy/B8WPHT3ka9E8tPMdoB9vNFcPhvkYaaocKoMAM4
         mmh0pDZfcpuW5IZZNJF1l2ni+tNxFaOWZ0bwJbSYLJ4LA2/5mlFWcu9hLNAhcJOe/z3F
         Y8W5X8a7OVD+0qIIdrIN0M52taiB4dpu6zsM/krJ1SUEJ0tzj3S0v+Xy64yW0uqfAjpX
         GBtF5/6dr0z4vgzXvwik04IquvYOL+weAyC60LKG6uagpGTslURHfAdIkT7SlOH52kij
         +z7msckdNltPaRCGIfhQJnFpMvywtLRmPTP3D1Go1ZJuCxQbjJv1MqhkQr0nnUI4008H
         hwbQ==
X-Forwarded-Encrypted: i=1; AJvYcCW3s39jS+RxEP8FebVLuyE7aHuuIAD4prAxUdkQty+FA82iBNocqraTDV3faAPN0ZZYgIIvrvg=@vger.kernel.org
X-Gm-Message-State: AOJu0Yz0qPBiVm/uD99DO1VeoNwR5BzWP45uN9XEF85lUndcXzwRigvQ
	5W64kmFgzIOMjefEJ6x3CzbqbRLxiBZHKdg+eNju65txbkW2bOEk79sJS/u/RmLjGgjQWivbzV2
	RVZDsewXHurOAN/ZpGonnP9DAL3KZ/xkhIa/M
X-Google-Smtp-Source: AGHT+IH189tCyHJAs8+uYz1D8cqhCZwvXdA49VduEDJ57i+cfyftNC54nLndjM165u/NxYArkNHUZRkdazpukm/JHig=
X-Received: by 2002:a05:6e02:1528:b0:3a0:b0dc:abfc with SMTP id
 e9e14a558f8ab-3a37c379b15mr6334015ab.7.1728313835376; Mon, 07 Oct 2024
 08:10:35 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <bdaaef9d-4364-4171-b82b-bcfc12e207eb@candelatech.com>
 <20241001193606.GA10530@breakpoint.cc> <CAJuCfpGyPNBQ=MTMeXzNZJcoiqok+zuW-3Ti0tFS7drhMFq1iQ@mail.gmail.com>
 <20241007112904.GA27104@breakpoint.cc>
In-Reply-To: <20241007112904.GA27104@breakpoint.cc>
From: Suren Baghdasaryan <surenb@google.com>
Date: Mon, 7 Oct 2024 08:10:22 -0700
Message-ID: <CAJuCfpEDKkiXm1ye=gs3ohLDJM7gqQc0WwS=6egddbsZ1qRF9A@mail.gmail.com>
Subject: Re: nf-nat-core: allocated memory at module unload.
To: Florian Westphal <fw@strlen.de>
Cc: Ben Greear <greearb@candelatech.com>, netdev <netdev@vger.kernel.org>, 
	kent.overstreet@linux.dev, pablo@netfilter.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Oct 7, 2024 at 4:29=E2=80=AFAM Florian Westphal <fw@strlen.de> wrot=
e:
>
> Suren Baghdasaryan <surenb@google.com> wrote:
> > On Tue, Oct 1, 2024 at 12:36=E2=80=AFPM Florian Westphal <fw@strlen.de>=
 wrote:
> > >
> > > Ben Greear <greearb@candelatech.com> wrote:
> > >
> > > [ CCing codetag folks ]
> >
> > Thanks! I've been on vacation and just saw this report.
> >
> > >
> > > > Hello,
> > > >
> > > > I see this splat in 6.11.0 (plus a single patch to fix vrf xmit dea=
dlock).
> > > >
> > > > Is this a known issue?  Is it a serious problem?
> > >
> > > Not known to me.  Looks like an mm (rcu)+codetag problem.
> > >
> > > > ------------[ cut here ]------------
> > > > net/netfilter/nf_nat_core.c:1114 module nf_nat func:nf_nat_register=
_fn has 256 allocated at module unload
> > > > WARNING: CPU: 1 PID: 10421 at lib/alloc_tag.c:168 alloc_tag_module_=
unload+0x22b/0x3f0
> > > > Modules linked in: nf_nat(-) btrfs ufs qnx4 hfsplus hfs minix vfat =
msdos fat
> > > ...
> > > > Hardware name: Default string Default string/SKYBAY, BIOS 5.12 08/0=
4/2020
> > > > RIP: 0010:alloc_tag_module_unload+0x22b/0x3f0
> > > >  codetag_unload_module+0x19b/0x2a0
> > > >  ? codetag_load_module+0x80/0x80
> > > >  ? up_write+0x4f0/0x4f0
> > >
> > > "Well, yes, but actually no."
> > >
> > > At this time, kfree_rcu() has been called on all 4 objects.
> > >
> > > Looks like kfree_rcu no longer cares even about rcu_barrier(), and
> > > there is no kvfree_rcu_barrier() in 6.11.
> > >
> > > The warning goes away when I replace kfree_rcu with call_rcu+kfree
> > > plus rcu_barrier in module exit path.
> > >
> > > But I don't think its the right thing to do.
> > >
> > > (referring to nf_nat_unregister_fn(), kfree_rcu(priv, rcu_head);).
> > >
> > > Reproducer:
> > > unshare -n iptables-nft -t nat -A PREROUTING -p tcp
> > > grep nf_nat /proc/allocinfo # will list 4 allocations
> > > rmmod nft_chain_nat
> > > rmmod nf_nat                # will WARN.
> > >
> > > Without rmmod, the 4 allocations go away after a few seconds,
> > > grep will no longer list them and then rmmod won't splat.
> >
> > I see. So, the kfree_rcu() was already called but freeing did not
> > happen yet, in the meantime we are unloading the module.
>
> Yes.
>
> > We could add
> > a synchronize_rcu() at the beginning of codetag_unload_module() so
> > that all pending kfree_rcu()s complete before we check codetag
> > counters:
> >
> > bool codetag_unload_module(struct module *mod)
> > {
> >         struct codetag_type *cttype;
> >         bool unload_ok =3D true;
> >
> >         if (!mod)
> >                 return true;
> >
> > +      synchronize_rcu();
> >         mutex_lock(&codetag_lock);
>
> This doesn't help as kfree_rcu doesn't wait for this.
>
> Use of kvfree_rcu_barrier() instead does work though.

I see. That sounds like an acceptable fix. Please post it and I'll ack it.
Thanks!

