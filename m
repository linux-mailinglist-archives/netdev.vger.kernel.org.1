Return-Path: <netdev+bounces-108946-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id DD4B39264B7
	for <lists+netdev@lfdr.de>; Wed,  3 Jul 2024 17:19:22 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 9ECE6282D6C
	for <lists+netdev@lfdr.de>; Wed,  3 Jul 2024 15:19:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9801C180A99;
	Wed,  3 Jul 2024 15:19:10 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from Chamillionaire.breakpoint.cc (Chamillionaire.breakpoint.cc [91.216.245.30])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 01F0117C21F
	for <netdev@vger.kernel.org>; Wed,  3 Jul 2024 15:19:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.216.245.30
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720019950; cv=none; b=oQ+njgn1xry++ieSnxJirJ4RuMy110OE2DN9v068wv4IBeCiLHPk6dCvW+Qxl1A+ftlvjuxjBAxx+VGiJ1PC9y0SlRu3iSOYXHazQuoPhyBM28cwhdTaVIaFlZFjJ0qe+7EgbEk3OZdlWCLwS0xLceC5ERwEJ12seJ/pFZBT/2o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720019950; c=relaxed/simple;
	bh=kPql63NPj19iy67c1mFngQ5TyHHW8eTW6MQQI2cSIbk=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=hcTaynwzJG51HaZcgsiuNFgqdmZ+NpkhPi3mRrgiTD2zcypaeijTKSIRaRkRvNEg6zyvj96aXOTy0pNYkQhvzul0LV9lhq7dxJRkAOE4xP/+E3zbmgS9jtirY9/jdhAqQXJvsMXdWBbpbPv/RurDFlgBrEHSuKBdpuMmbyOij2c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=strlen.de; spf=pass smtp.mailfrom=strlen.de; arc=none smtp.client-ip=91.216.245.30
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=strlen.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=strlen.de
Received: from fw by Chamillionaire.breakpoint.cc with local (Exim 4.92)
	(envelope-from <fw@strlen.de>)
	id 1sP1l6-00011k-OQ; Wed, 03 Jul 2024 17:19:00 +0200
Date: Wed, 3 Jul 2024 17:19:00 +0200
From: Florian Westphal <fw@strlen.de>
To: Aaron Conole <aconole@redhat.com>
Cc: Florian Westphal <fw@strlen.de>, dev@openvswitch.org, pshelar@ovn.org,
	netdev@vger.kernel.org, Dumitru Ceara <dceara@redhat.com>,
	Marcelo Leitner <mleitner@redhat.com>
Subject: Re: [PATCH net-next] openvswitch: prepare for stolen verdict coming
 from conntrack and nat engine
Message-ID: <20240703151900.GC29258@breakpoint.cc>
References: <20240703104640.20878-1-fw@strlen.de>
 <f7t34oqplmh.fsf@redhat.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <f7t34oqplmh.fsf@redhat.com>
User-Agent: Mutt/1.10.1 (2018-07-13)

Aaron Conole <aconole@redhat.com> wrote:
> > verdict with NF_DROP_REASON() helper,
> >
> > This helper releases the skb instantly (so drop_monitor can pinpoint
> > precise location) and returns NF_STOLEN.
> >
> > Prepare call sites to deal with this before introducing such changes
> > in conntrack and nat core.
> >
> > Signed-off-by: Florian Westphal <fw@strlen.de>
> > ---
> 
> AFAIU, these changes are only impacting the existing NF_DROP cases, and
> won't impact how ovs + netfilter communicate about invalid packets.  One
> important thing to note is that we rely on:
> 
>  * Note that if the packet is deemed invalid by conntrack, skb->_nfct will be
>  * set to NULL and 0 will be returned.

Right, this is about how to communicate 'packet dropped'.

NF_DROP means 'please call kfree_skb for me'.  Problem from introspection point
of view is that drop monitor will blame nf_hook_slow() (for netfilter)
and ovs resp. act_ct for the drop.

Plan is to allow conntrack/nat engine to return STOLEN verdict ("skb
might have been free'd already").

Example change:
@@ -52,10 +53,8 @@ nf_nat_masquerade_ipv4(struct sk_buff *skb, unsigned int hooknum,
        rt = skb_rtable(skb);
        nh = rt_nexthop(rt, ip_hdr(skb)->daddr);
        newsrc = inet_select_addr(out, nh, RT_SCOPE_UNIVERSE);
-       if (!newsrc) {
-               pr_info("%s ate my IP address\n", out->name);
-               return NF_DROP;
-       }
+       if (!newsrc)
+               return NF_DROP_REASON(skb, SKB_DROP_REASON_NETFILTER_DROP, EADDRNOTAVAIL);


Where NF_DROP_REASON() is:

static __always_inline int
NF_DROP_REASON(struct sk_buff *skb, enum skb_drop_reason reason, u32 err)
{
        BUILD_BUG_ON(err > 0xffff);

        kfree_skb_reason(skb, reason);

        return ((err << 16) | NF_STOLEN);
}

So drop monitoring tools will blame nf_nat_masquerade.c:nf_nat_masquerade_ipv4 and not
the consumer of the NF_DROP verdict.

I can't make such changes ATM because ovs and act_ct assume conntrack
returns only ACCEPT and DROP, so we'd get double-free.  Hope that makes
sense.

Thanks!

