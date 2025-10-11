Return-Path: <netdev+bounces-228597-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 6DCD1BCF74F
	for <lists+netdev@lfdr.de>; Sat, 11 Oct 2025 16:30:14 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 3D7864E1C1A
	for <lists+netdev@lfdr.de>; Sat, 11 Oct 2025 14:30:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DD26E20468E;
	Sat, 11 Oct 2025 14:30:10 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from Chamillionaire.breakpoint.cc (Chamillionaire.breakpoint.cc [91.216.245.30])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6BD3286347;
	Sat, 11 Oct 2025 14:30:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.216.245.30
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760193010; cv=none; b=ZxurTww8tYki6D16iqXRf1qOtLK4mK0AMQSPLei7cBEyrqAnCoLOX5VpGU1TEStkxTIzDzQW5q3V0qC8LZoDzKNZU6X3Mr2t8k0Ckuji0AsrOW2Cj3iFE26N7F76awGEjc6BK6bTuNJA2K8wxikiWOQRSB9Pn2BhJVXj3clYZ6s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760193010; c=relaxed/simple;
	bh=wczVGQH1eHpzXRC3+L/CdGXCe/iIQeLXs4DV7ZAvwck=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=c5UIKSISCffuF5ZxQEuo4lNiERNVBqCKUGtkkB4xLFvAjLxQTYD21UnrYVbL2g3LepSd29xSHm19TRM3GYOn/bTBDF3cjvbQyIwVMU0hF6VWU5+nZD22xpK8dqHu1Ms4+PGI5s2mox0REwQb6MueVogsPuwHFIAdizHI3Ov8kCA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=strlen.de; spf=pass smtp.mailfrom=strlen.de; arc=none smtp.client-ip=91.216.245.30
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=strlen.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=strlen.de
Received: by Chamillionaire.breakpoint.cc (Postfix, from userid 1003)
	id A522160742; Sat, 11 Oct 2025 16:30:06 +0200 (CEST)
Date: Sat, 11 Oct 2025 16:30:06 +0200
From: Florian Westphal <fw@strlen.de>
To: Stanislav Fomichev <stfomichev@gmail.com>
Cc: netdev@vger.kernel.org, Paolo Abeni <pabeni@redhat.com>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, linux-kernel@vger.kernel.org,
	sdf@fomichev.me
Subject: Re: [PATCH net 2/2] net: core: split unregister_netdevice list into
 smaller chunks
Message-ID: <aOpp7n2E9ZVS6RJh@strlen.de>
References: <20251010135412.22602-1-fw@strlen.de>
 <20251010135412.22602-3-fw@strlen.de>
 <aOmK5i5e_Oi93JiO@mini-arch>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <aOmK5i5e_Oi93JiO@mini-arch>

Stanislav Fomichev <stfomichev@gmail.com> wrote:
> On 10/10, Florian Westphal wrote:
> > +static void unregister_netdevice_close_many_lockdep(struct list_head *head)
> > +{
> > +#ifdef CONFIG_LOCKDEP
> > +	unsigned int lock_depth = lockdep_depth(current);
> > +	unsigned int lock_count = lock_depth;
> > +	struct net_device *dev, *tmp;
> > +	LIST_HEAD(done_head);
> > +
> > +	list_for_each_entry_safe(dev, tmp, head, unreg_list) {
> > +		if (netdev_need_ops_lock(dev))
> > +			lock_count++;
> > +
> > +		/* we'll run out of lockdep keys, reduce size. */
> > +		if (lock_count >= MAX_LOCK_DEPTH - 1) {
> > +			LIST_HEAD(tmp_head);
> > +
> > +			list_cut_before(&tmp_head, head, &dev->unreg_list);
> > +			unregister_netdevice_close_many(&tmp_head);
> > +			lock_count = lock_depth;
> > +			list_splice_tail(&tmp_head, &done_head);
> > +		}
> > +	}
> > +
> > +	unregister_netdevice_close_many(head);
> > +
> > +	list_for_each_entry_safe_reverse(dev, tmp, &done_head, unreg_list)
> > +		list_move(&dev->unreg_list, head);
> > +#else
> > +	unregister_netdevice_close_many(head);
> > +#endif
> 
> 
> Any reason not to morph the original code to add this 'no more than 8 at a
> time' constraint? Having a separate lockdep path with list juggling
> seems a bit fragile.
> 
> 1. add all ops locked devs to the list
> 2. for each MAX_LOCK_DEPTH (or 'infinity' in the case of non-lockdep)
>   2.1 lock N devs
>   2.2 netif_close_many
>   2.3 unlock N devs
> 3. ... do the non-ops-locked ones
> 
> This way the code won't diverge too much I hope.

I think that having extra code for LOCKDEP (which means debug kernel
that often also includes k?san, kmemleak etc. is ok.

I was more concerned with having no changes to normal (non-lockdep)
kernel.

Let me try again, I tried to do your solution above before going with
this extra lockdep-only juggling but I ended up making a mess.

