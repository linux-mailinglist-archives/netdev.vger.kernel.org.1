Return-Path: <netdev+bounces-131016-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 496DA98C628
	for <lists+netdev@lfdr.de>; Tue,  1 Oct 2024 21:36:53 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id EBF4C1F259F3
	for <lists+netdev@lfdr.de>; Tue,  1 Oct 2024 19:36:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 053A61CDFC4;
	Tue,  1 Oct 2024 19:36:19 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from Chamillionaire.breakpoint.cc (Chamillionaire.breakpoint.cc [91.216.245.30])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C2F981CDFDA
	for <netdev@vger.kernel.org>; Tue,  1 Oct 2024 19:36:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.216.245.30
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727811378; cv=none; b=n8wAH7V/he3Z3L4uUak61p3B1M9BbkqEimqFF/YSF+iPcD03WzrLeYGlNH0UXAoUrnCfGWCbCS62hNngTQd2l+ELi5KFb6B3/sGDG+omPKgLbtvrhjgRFozSNIMCltcwS6tQZvCpozG3+pRyisJJi4fiXuwFSR81zc0lEbxS62g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727811378; c=relaxed/simple;
	bh=7qgvZCGl9L0K8NsxKwAwANVYLKAycFej1Rrdno8rvsw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=fjX76WtrJ3FVTCrorVAittiB+Pu+qEWLLJIimrFQWgGWwS31gOtoYw5TiFnni05NyCTkyyxvtMDyICR1ykCg18GRAst6ZtJ39VXoA2S3i9x6ubIkJfuyPjIX0VbazpY+HszC977A9vwicGjTDELhjEsTJqH9bX+ySyjRcFK0T7Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=strlen.de; spf=pass smtp.mailfrom=strlen.de; arc=none smtp.client-ip=91.216.245.30
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=strlen.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=strlen.de
Received: from fw by Chamillionaire.breakpoint.cc with local (Exim 4.92)
	(envelope-from <fw@strlen.de>)
	id 1svifG-0002qm-9O; Tue, 01 Oct 2024 21:36:06 +0200
Date: Tue, 1 Oct 2024 21:36:06 +0200
From: Florian Westphal <fw@strlen.de>
To: Ben Greear <greearb@candelatech.com>
Cc: netdev <netdev@vger.kernel.org>, kent.overstreet@linux.dev,
	surenb@google.com, pablo@netfilter.org
Subject: Re: nf-nat-core: allocated memory at module unload.
Message-ID: <20241001193606.GA10530@breakpoint.cc>
References: <bdaaef9d-4364-4171-b82b-bcfc12e207eb@candelatech.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <bdaaef9d-4364-4171-b82b-bcfc12e207eb@candelatech.com>
User-Agent: Mutt/1.10.1 (2018-07-13)

Ben Greear <greearb@candelatech.com> wrote:

[ CCing codetag folks ]

> Hello,
> 
> I see this splat in 6.11.0 (plus a single patch to fix vrf xmit deadlock).
> 
> Is this a known issue?  Is it a serious problem?

Not known to me.  Looks like an mm (rcu)+codetag problem.

> ------------[ cut here ]------------
> net/netfilter/nf_nat_core.c:1114 module nf_nat func:nf_nat_register_fn has 256 allocated at module unload
> WARNING: CPU: 1 PID: 10421 at lib/alloc_tag.c:168 alloc_tag_module_unload+0x22b/0x3f0
> Modules linked in: nf_nat(-) btrfs ufs qnx4 hfsplus hfs minix vfat msdos fat
...
> Hardware name: Default string Default string/SKYBAY, BIOS 5.12 08/04/2020
> RIP: 0010:alloc_tag_module_unload+0x22b/0x3f0
>  codetag_unload_module+0x19b/0x2a0
>  ? codetag_load_module+0x80/0x80
>  ? up_write+0x4f0/0x4f0

"Well, yes, but actually no."

At this time, kfree_rcu() has been called on all 4 objects.

Looks like kfree_rcu no longer cares even about rcu_barrier(), and
there is no kvfree_rcu_barrier() in 6.11.

The warning goes away when I replace kfree_rcu with call_rcu+kfree
plus rcu_barrier in module exit path.

But I don't think its the right thing to do.

(referring to nf_nat_unregister_fn(), kfree_rcu(priv, rcu_head);).

Reproducer:
unshare -n iptables-nft -t nat -A PREROUTING -p tcp
grep nf_nat /proc/allocinfo # will list 4 allocations
rmmod nft_chain_nat
rmmod nf_nat		    # will WARN.

Without rmmod, the 4 allocations go away after a few seconds,
grep will no longer list them and then rmmod won't splat.


