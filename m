Return-Path: <netdev+bounces-116011-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 00666948C88
	for <lists+netdev@lfdr.de>; Tue,  6 Aug 2024 12:03:40 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id A6B611F24A75
	for <lists+netdev@lfdr.de>; Tue,  6 Aug 2024 10:03:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2A90C1BE23A;
	Tue,  6 Aug 2024 10:03:20 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from Chamillionaire.breakpoint.cc (Chamillionaire.breakpoint.cc [91.216.245.30])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A871C1BE24B
	for <netdev@vger.kernel.org>; Tue,  6 Aug 2024 10:03:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.216.245.30
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722938600; cv=none; b=TB6Bb0hHEnqv1xrapZ1hx0Ark29FS+nAuWyzIV3L2xqjfQD8v6Ize6OkX4s+n2NZcfLqPUuNe21zohp0KT+LJjF2cknch9a2dOzcSOm6Nibf2tVqwAblk7v1MP1h12bwB10Vra2RgXa+QSVt7tz1i3NG2oUk7UmY3fnzK51Gmx0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722938600; c=relaxed/simple;
	bh=Ps1wwGlQ1i0N4A4gT/Dw9C18xNP/2VEgmmtKTYvIdvc=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=iSQggYiX5BDORHPkDC+diVPbUtRHm5fskc+P0VZlSchjHKjYPyx1J1j8sKBE+evHUITUgDByHioZuYp6tO43qxofpZT8H13rUrj0fGof2cPT4Jdf9hK7QzJrAhy3/3U70CQt9tqe3Bx3jnacBjnD74IUHyuutVKEZA2Iy7qtkYM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=strlen.de; spf=pass smtp.mailfrom=strlen.de; arc=none smtp.client-ip=91.216.245.30
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=strlen.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=strlen.de
Received: from fw by Chamillionaire.breakpoint.cc with local (Exim 4.92)
	(envelope-from <fw@strlen.de>)
	id 1sbH20-0008Sp-KJ; Tue, 06 Aug 2024 12:03:04 +0200
Date: Tue, 6 Aug 2024 12:03:04 +0200
From: Florian Westphal <fw@strlen.de>
To: Christian Hopps <chopps@chopps.org>
Cc: Sabrina Dubroca <sd@queasysnail.net>, devel@linux-ipsec.org,
	Steffen Klassert <steffen.klassert@secunet.com>,
	netdev@vger.kernel.org, Christian Hopps <chopps@labn.net>
Subject: Re: [PATCH ipsec-next v8 10/16] xfrm: iptfs: add fragmenting of
 larger than MTU user packets
Message-ID: <20240806100304.GA32447@breakpoint.cc>
References: <20240804203346.3654426-1-chopps@chopps.org>
 <20240804203346.3654426-11-chopps@chopps.org>
 <Zq__9Z4ckXNdR-Ec@hog>
 <m2a5hr7iek.fsf@ja-home.int.chopps.org>
 <ZrHjByjZnnDgjvfo@hog>
 <m2le1aouzf.fsf@ja-home.int.chopps.org>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <m2le1aouzf.fsf@ja-home.int.chopps.org>
User-Agent: Mutt/1.10.1 (2018-07-13)

Christian Hopps <chopps@chopps.org> wrote:
> > > > > +	if (!l3resv) {
> > > > > +		resv = XFRM_IPTFS_MIN_L2HEADROOM;
> > > > > +	} else {
> > > > > +		resv = skb_headroom(tpl);
> > > > > +		if (resv < XFRM_IPTFS_MIN_L3HEADROOM)
> > > > > +			resv = XFRM_IPTFS_MIN_L3HEADROOM;
> > > > > +	}
> > > > > +
> > > > > +	skb = alloc_skb(len + resv, GFP_ATOMIC);
> > > > > +	if (!skb) {
> > > > > +		XFRM_INC_STATS(dev_net(tpl->dev), LINUX_MIB_XFRMNOSKBERROR);
> > > >
> > > > Hmpf, so we've gone from incrementing the wrong counter to
> > > > incrementing a new counter that doesn't have a precise meaning.
> > > 
> > > The new "No SKB" counter is supposed to mean "couldn't get an SKB",
> > > given plenty of other errors are logged under "OutErr" or "InErr"
> > > i'm not sure what level of precision you're looking for here. :)
> > 
> > OutErr and InErr would be better than that new counter IMO.
> 
> Why?
> 
> My counter tracks the SKB depletion failure that is actually happening. Would you have me now pass in the direction argument just so I can tick the correct overly general MIB counter that provides less value to the user in identifying the actual problem? How is that good design?
> 
> I'm inclined to just delete the thing altogether rather than block on this thing that will almost never happen.

Makes sense to me, skb allocation failure is transient anyway, there is
no action that could be taken if this error counter is incrementing.

You might want to pass GFP_ATOMIC | __GFP_NOWARN to alloc_skb() to avoid
any splats given this is a high-volume allocation.

