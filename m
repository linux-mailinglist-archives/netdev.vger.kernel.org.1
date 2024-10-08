Return-Path: <netdev+bounces-133152-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 240FE9951D4
	for <lists+netdev@lfdr.de>; Tue,  8 Oct 2024 16:35:56 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id A212DB2EC21
	for <lists+netdev@lfdr.de>; Tue,  8 Oct 2024 14:32:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7C95D1DFE21;
	Tue,  8 Oct 2024 14:30:46 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from ganesha.gnumonks.org (ganesha.gnumonks.org [213.95.27.120])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 555111DE2A2;
	Tue,  8 Oct 2024 14:30:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=213.95.27.120
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728397846; cv=none; b=Zi5LWK1hR4KMoPdUQi4kxFo3HmFkZkejvRS7WsVkeFCWo4Y340MIB9wEz660O0Z4m1hTJduoy0A2NxmFqNFyivgQlXmMz+NFjMYLtz6j19AhucMLK+NRWsCedmdjwrJcDXoAh00koc1/lyYKMxiM6w0FijMerTHlMyDbdyfEBAg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728397846; c=relaxed/simple;
	bh=i51JtwopsuEOuZ9GwW2Cc+uwa+xFhCmxbKyOy+E0zZc=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=TBKZ0KjqcVOdgLdUIJkLUoFrZfb0WWBoTKBnAmukIrFitLO8bdKD8vc9XP0MSMINyOz07ucSFCktUwD18QmYu8T4q8+olH9LW9VF8E3lSoj3vc77VF4GIuSWRZoUwTgTUZTtGgY2dj3sC/PgoKMa2AOCnrwmpoCcGkzo6UZEnMA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=netfilter.org; spf=pass smtp.mailfrom=gnumonks.org; arc=none smtp.client-ip=213.95.27.120
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=netfilter.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gnumonks.org
Received: from [78.30.37.63] (port=40278 helo=gnumonks.org)
	by ganesha.gnumonks.org with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.94.2)
	(envelope-from <pablo@gnumonks.org>)
	id 1syBET-008caQ-3f; Tue, 08 Oct 2024 16:30:39 +0200
Date: Tue, 8 Oct 2024 16:30:35 +0200
From: Pablo Neira Ayuso <pablo@netfilter.org>
To: Nikolay Aleksandrov <razor@blackwall.org>
Cc: Amedeo Baragiola <ingamedeo@gmail.com>, Roopa Prabhu <roopa@nvidia.com>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	bridge@lists.linux.dev, netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH] bridge: use promisc arg instead of skb flags
Message-ID: <ZwVCC3DYWw0aiOcJ@calendula>
References: <20241005014514.1541240-1-ingamedeo@gmail.com>
 <c06d9227-dcac-4131-9c2d-83dace086a5d@blackwall.org>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <c06d9227-dcac-4131-9c2d-83dace086a5d@blackwall.org>
X-Spam-Score: -1.9 (-)

Hi Nikolay,

On Sat, Oct 05, 2024 at 05:06:56PM +0300, Nikolay Aleksandrov wrote:
> On 05/10/2024 04:44, Amedeo Baragiola wrote:
> > Since commit 751de2012eaf ("netfilter: br_netfilter: skip conntrack input hook for promisc packets")
> > a second argument (promisc) has been added to br_pass_frame_up which
> > represents whether the interface is in promiscuous mode. However,
> > internally - in one remaining case - br_pass_frame_up checks the device
> > flags derived from skb instead of the argument being passed in.
> > This one-line changes addresses this inconsistency.
> >
> > Signed-off-by: Amedeo Baragiola <ingamedeo@gmail.com>
> > ---
> >  net/bridge/br_input.c | 3 +--
> >  1 file changed, 1 insertion(+), 2 deletions(-)
> >
> > diff --git a/net/bridge/br_input.c b/net/bridge/br_input.c
> > index ceaa5a89b947..156c18f42fa3 100644
> > --- a/net/bridge/br_input.c
> > +++ b/net/bridge/br_input.c
> > @@ -50,8 +50,7 @@ static int br_pass_frame_up(struct sk_buff *skb, bool promisc)
> >  	 * packet is allowed except in promisc mode when someone
> >  	 * may be running packet capture.
> >  	 */
> > -	if (!(brdev->flags & IFF_PROMISC) &&
> > -	    !br_allowed_egress(vg, skb)) {
> > +	if (!promisc && !br_allowed_egress(vg, skb)) {
> >  		kfree_skb(skb);
> >  		return NET_RX_DROP;
> >  	}
>
> This is subtle, but it does change behaviour when a BR_FDB_LOCAL dst
> is found it will always drop the traffic after this patch (w/ promisc) if it
> doesn't pass br_allowed_egress(). It would've been allowed before, but current
> situation does make the patch promisc bit inconsistent, i.e. we get
> there because of BR_FDB_LOCAL regardless of the promisc flag.
>
> Because we can have a BR_FDB_LOCAL dst and still pass up such skb because of
> the flag instead of local_rcv (see br_br_handle_frame_finish()).
>
> CCing also Pablo for a second pair of eyes and as the original patch
> author. :)
>
> Pablo WDYT?
>
> Just FYI we definitely want to see all traffic if promisc is set, so
> this patch is a no-go.

promisc is always _false_ for BR_FDB_LOCAL dst:

        if (dst) {
                unsigned long now = jiffies;

                if (test_bit(BR_FDB_LOCAL, &dst->flags))
                        return br_pass_frame_up(skb, false);

                ...
        }

        if (local_rcv)
                return br_pass_frame_up(skb, promisc);

> > -	if (!(brdev->flags & IFF_PROMISC) &&
> > -	    !br_allowed_egress(vg, skb)) {
> > +	if (!promisc && !br_allowed_egress(vg, skb)) {

Then, this is not equivalent.

But, why is br_allowed_egress() skipped depending on brdev->flags & IFF_PROMISC?

I mean, how does this combination work?

BR_FDB_LOCAL dst AND (brdev->flags & IFF_PROMISC) AND BR_INPUT_SKB_CB(skb)->vlan_filtered

> >  		kfree_skb(skb);
> >  		return NET_RX_DROP;
> >  	}

