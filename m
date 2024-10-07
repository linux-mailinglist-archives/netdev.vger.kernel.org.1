Return-Path: <netdev+bounces-132645-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id CD4F5992A31
	for <lists+netdev@lfdr.de>; Mon,  7 Oct 2024 13:29:17 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 5C107B2271C
	for <lists+netdev@lfdr.de>; Mon,  7 Oct 2024 11:29:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C0A5B1CACC0;
	Mon,  7 Oct 2024 11:29:11 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from Chamillionaire.breakpoint.cc (Chamillionaire.breakpoint.cc [91.216.245.30])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EF2AA2AD05
	for <netdev@vger.kernel.org>; Mon,  7 Oct 2024 11:29:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.216.245.30
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728300551; cv=none; b=oajicV3CY/sYUB7Jl2O04OcFTSSf0Ylv253RtQqQBvaaEnreHSIFImJD+zDUMR4St3tybtH+xscbTrF3mC5O6BCz/cuYT5vpJFCyjV45PxI8sIZDF3hroKg+JN9qHBVb0qVeNMSAN+udg0ZfjIPmXWExmhtmZg9k9K4vxUHtc94=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728300551; c=relaxed/simple;
	bh=Zcb9bTja9eypmKC5oGkEJ2RmUr8BxDhQokPpviezBpY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=YWvS1Rk2kwlfwQcr7AVVBlJY4LI+gXA/BZEtdoYACwwYl/cWKDCEMjTZeOfRBsBnm1WjO/c/yTNWus2cCmNdVjxnLVi1JaZBq0zm7aYk4R9H4a9BotqC7RyI3Gos0Sp18ao+b6t7yijpSR5BIK6XjgO248uBWCFZlH6DNbY7isQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=strlen.de; spf=pass smtp.mailfrom=strlen.de; arc=none smtp.client-ip=91.216.245.30
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=strlen.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=strlen.de
Received: from fw by Chamillionaire.breakpoint.cc with local (Exim 4.92)
	(envelope-from <fw@strlen.de>)
	id 1sxlvE-000797-8c; Mon, 07 Oct 2024 13:29:04 +0200
Date: Mon, 7 Oct 2024 13:29:04 +0200
From: Florian Westphal <fw@strlen.de>
To: Suren Baghdasaryan <surenb@google.com>
Cc: Florian Westphal <fw@strlen.de>, Ben Greear <greearb@candelatech.com>,
	netdev <netdev@vger.kernel.org>, kent.overstreet@linux.dev,
	pablo@netfilter.org
Subject: Re: nf-nat-core: allocated memory at module unload.
Message-ID: <20241007112904.GA27104@breakpoint.cc>
References: <bdaaef9d-4364-4171-b82b-bcfc12e207eb@candelatech.com>
 <20241001193606.GA10530@breakpoint.cc>
 <CAJuCfpGyPNBQ=MTMeXzNZJcoiqok+zuW-3Ti0tFS7drhMFq1iQ@mail.gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAJuCfpGyPNBQ=MTMeXzNZJcoiqok+zuW-3Ti0tFS7drhMFq1iQ@mail.gmail.com>
User-Agent: Mutt/1.10.1 (2018-07-13)

Suren Baghdasaryan <surenb@google.com> wrote:
> On Tue, Oct 1, 2024 at 12:36 PM Florian Westphal <fw@strlen.de> wrote:
> >
> > Ben Greear <greearb@candelatech.com> wrote:
> >
> > [ CCing codetag folks ]
> 
> Thanks! I've been on vacation and just saw this report.
> 
> >
> > > Hello,
> > >
> > > I see this splat in 6.11.0 (plus a single patch to fix vrf xmit deadlock).
> > >
> > > Is this a known issue?  Is it a serious problem?
> >
> > Not known to me.  Looks like an mm (rcu)+codetag problem.
> >
> > > ------------[ cut here ]------------
> > > net/netfilter/nf_nat_core.c:1114 module nf_nat func:nf_nat_register_fn has 256 allocated at module unload
> > > WARNING: CPU: 1 PID: 10421 at lib/alloc_tag.c:168 alloc_tag_module_unload+0x22b/0x3f0
> > > Modules linked in: nf_nat(-) btrfs ufs qnx4 hfsplus hfs minix vfat msdos fat
> > ...
> > > Hardware name: Default string Default string/SKYBAY, BIOS 5.12 08/04/2020
> > > RIP: 0010:alloc_tag_module_unload+0x22b/0x3f0
> > >  codetag_unload_module+0x19b/0x2a0
> > >  ? codetag_load_module+0x80/0x80
> > >  ? up_write+0x4f0/0x4f0
> >
> > "Well, yes, but actually no."
> >
> > At this time, kfree_rcu() has been called on all 4 objects.
> >
> > Looks like kfree_rcu no longer cares even about rcu_barrier(), and
> > there is no kvfree_rcu_barrier() in 6.11.
> >
> > The warning goes away when I replace kfree_rcu with call_rcu+kfree
> > plus rcu_barrier in module exit path.
> >
> > But I don't think its the right thing to do.
> >
> > (referring to nf_nat_unregister_fn(), kfree_rcu(priv, rcu_head);).
> >
> > Reproducer:
> > unshare -n iptables-nft -t nat -A PREROUTING -p tcp
> > grep nf_nat /proc/allocinfo # will list 4 allocations
> > rmmod nft_chain_nat
> > rmmod nf_nat                # will WARN.
> >
> > Without rmmod, the 4 allocations go away after a few seconds,
> > grep will no longer list them and then rmmod won't splat.
> 
> I see. So, the kfree_rcu() was already called but freeing did not
> happen yet, in the meantime we are unloading the module.

Yes.

> We could add
> a synchronize_rcu() at the beginning of codetag_unload_module() so
> that all pending kfree_rcu()s complete before we check codetag
> counters:
> 
> bool codetag_unload_module(struct module *mod)
> {
>         struct codetag_type *cttype;
>         bool unload_ok = true;
> 
>         if (!mod)
>                 return true;
> 
> +      synchronize_rcu();
>         mutex_lock(&codetag_lock);

This doesn't help as kfree_rcu doesn't wait for this.

Use of kvfree_rcu_barrier() instead does work though.

