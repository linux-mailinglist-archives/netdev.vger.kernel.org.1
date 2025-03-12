Return-Path: <netdev+bounces-174195-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 6DBD9A5DD3B
	for <lists+netdev@lfdr.de>; Wed, 12 Mar 2025 14:01:04 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id AAAA516A904
	for <lists+netdev@lfdr.de>; Wed, 12 Mar 2025 13:01:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6BD8326AF6;
	Wed, 12 Mar 2025 13:00:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="XRhyv2oY"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4737D12E7F
	for <netdev@vger.kernel.org>; Wed, 12 Mar 2025 13:00:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741784459; cv=none; b=YPdOlRn2m3mV78pdw4twbgU5ZhH3Q5+6iNfDl7uBx4Orr8sPEuPiHrlMiVlSCwPTgjZ8hJkrMStYDFawVHqhzynW4mG6YzDrdKDKH9B/oskOfiPq6sCPMbV7Ncqgca8BSA4wPaZJFvVvjMRaJFb35Acc89iVYV0ZUuanYib3q2Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741784459; c=relaxed/simple;
	bh=heQsNfi5fLSg2rB4S+vidsMFpvqMeIZOSFEPaCAMKoQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=niZW7W28ce4yNzcJHJDHIN+l7m17pD6A4HeWNC8ptfYBO/FaBR9PhXaDnoTeJGds20K/QjohnIG+268sbW588/w0AyStNvZRdBqzcJL068lyyZwsQL0RSSFtYAHREr6HaIAwEjA0Z5X8tSiJ/bUp3gbi5lOn9A8gL86PRmSX5w8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=XRhyv2oY; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 53DF0C4CEEC;
	Wed, 12 Mar 2025 13:00:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1741784458;
	bh=heQsNfi5fLSg2rB4S+vidsMFpvqMeIZOSFEPaCAMKoQ=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=XRhyv2oYzKy9nK0bTipjW+gWaH2qYly2RFaRQE6ESrkdUB7UQlhXKG6q46/+mteT1
	 ksNpwDmfzE1BU4UiMxFRN0CTGR5duEE9QFaf94GyNRMZ+REmWP/sStRIvCEr7I1Zku
	 DtdQYi6RYy9Z7gJdZVt24vktIIVzuHmKcxyt6do1zzTIzFlOoobjs2Dsv71OiVQdW4
	 y/5aKmijnFG0aAMQ2HBEtl4VtlyUUZSl0SZl0AhVq0zEbcjc7NXmiGCXb2FGuVtb2g
	 AMXfhX4a7AxvTanzf0LkwUDq1xjcO67AJ+mrth+un2FBNNaR8Mi2aDeMlV2v9JrV2G
	 jS3tjq7/6mrYA==
Date: Wed, 12 Mar 2025 15:00:54 +0200
From: Leon Romanovsky <leon@kernel.org>
To: Chiachang Wang <chiachangwang@google.com>
Cc: netdev@vger.kernel.org, steffen.klassert@secunet.com,
	stanleyjhu@google.com, yumike@google.com
Subject: Re: [PATCH ipsec-next v4 2/2] xfrm: Refactor migration setup during
 the cloning process
Message-ID: <20250312130054.GB1322339@unreal>
References: <20250310091620.2706700-1-chiachangwang@google.com>
 <20250310091620.2706700-3-chiachangwang@google.com>
 <20250310115226.GD7027@unreal>
 <CAOb+sWFi+8df32zdAL5AmkfCpFBMG6hU=_+S3U-X_Zd6386r6g@mail.gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAOb+sWFi+8df32zdAL5AmkfCpFBMG6hU=_+S3U-X_Zd6386r6g@mail.gmail.com>

On Mon, Mar 10, 2025 at 08:20:39PM +0800, Chiachang Wang wrote:
> While the xfrm_state_migrate() is the only caller for this method
> currently, this check can be removed indeed.
> I add this for the feasibility of other callers without performing the
> validation. If you have a strong opinion on this. I can update to
> remove this.
> Please let me know if you prefer to do so.

Sure, please remove. We are adding code when it is actually needed.

Thanks

> 
> Thank you!
> 
> Leon Romanovsky <leon@kernel.org> 於 2025年3月10日 週一 下午7:52寫道：
> >
> > On Mon, Mar 10, 2025 at 09:16:20AM +0000, Chiachang Wang wrote:
> > > Previously, migration related setup, such as updating family,
> > > destination address, and source address, was performed after
> > > the clone was created in `xfrm_state_migrate`. This change
> > > moves this setup into the cloning function itself, improving
> > > code locality and reducing redundancy.
> > >
> > > The `xfrm_state_clone_and_setup` function now conditionally
> > > applies the migration parameters from struct xfrm_migrate
> > > if it is provided. This allows the function to be used both
> > > for simple cloning and for cloning with migration setup.
> > >
> > > Test: Tested with kernel test in the Android tree located
> > >       in https://android.googlesource.com/kernel/tests/
> > >       The xfrm_tunnel_test.py under the tests folder in
> > >       particular.
> > > Signed-off-by: Chiachang Wang <chiachangwang@google.com>
> > > ---
> > >  net/xfrm/xfrm_state.c | 18 ++++++++++--------
> > >  1 file changed, 10 insertions(+), 8 deletions(-)
> > >
> > > diff --git a/net/xfrm/xfrm_state.c b/net/xfrm/xfrm_state.c
> > > index 9cd707362767..0365daedea32 100644
> > > --- a/net/xfrm/xfrm_state.c
> > > +++ b/net/xfrm/xfrm_state.c
> > > @@ -1958,8 +1958,9 @@ static inline int clone_security(struct xfrm_state *x, struct xfrm_sec_ctx *secu
> > >       return 0;
> > >  }
> > >
> > > -static struct xfrm_state *xfrm_state_clone(struct xfrm_state *orig,
> > > -                                        struct xfrm_encap_tmpl *encap)
> > > +static struct xfrm_state *xfrm_state_clone_and_setup(struct xfrm_state *orig,
> > > +                                        struct xfrm_encap_tmpl *encap,
> > > +                                        struct xfrm_migrate *m)
> > >  {
> > >       struct net *net = xs_net(orig);
> > >       struct xfrm_state *x = xfrm_state_alloc(net);
> > > @@ -2058,6 +2059,12 @@ static struct xfrm_state *xfrm_state_clone(struct xfrm_state *orig,
> > >                       goto error;
> > >       }
> > >
> > > +     if (m) {
> >
> > Why do you need this "if (m)"? "m" should be valid at this stage.
> >
> > Thanks
> >
> > > +             x->props.family = m->new_family;
> > > +             memcpy(&x->id.daddr, &m->new_daddr, sizeof(x->id.daddr));
> > > +             memcpy(&x->props.saddr, &m->new_saddr, sizeof(x->props.saddr));
> > > +     }
> > > +
> > >       return x;
> 

