Return-Path: <netdev+bounces-266290-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id sBiZEeRgsGloigIAu9opvQ
	(envelope-from <netdev+bounces-266290-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Tue, 10 Mar 2026 19:20:20 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id B0D16256556
	for <lists+netdev@lfdr.de>; Tue, 10 Mar 2026 19:20:19 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 9D69D3060B07
	for <lists+netdev@lfdr.de>; Tue, 10 Mar 2026 18:20:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 478972BEC3F;
	Tue, 10 Mar 2026 18:20:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="FYUgd4V0"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 24CB1295DAC
	for <netdev@vger.kernel.org>; Tue, 10 Mar 2026 18:20:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773166816; cv=none; b=j4gh3+ILRIT8yw78UITB8f+/SgJgmv/NPsJNLb9ZYoesZdo+15PDe1mcQEdBecLtvVREZTz+77vnxwJ+i/KkiMLjudboefn3/Qxi12Q6zHuTjp6HE1F9PdEYflBlCy4Aa8hYJOuStvFCEkJweAooAR6LL7pH2FFtIpCJ6d0cma8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773166816; c=relaxed/simple;
	bh=LgiCSQbpdMiGnsRj49OVFWuPOgHyxYUtAktmSKt5Crg=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=fJBou6O1uq8138xaU5050su5FXhu0/OvnmJL5zHGQ4HEQlF3UK6Fx8P74J7A2RooI+y0TUx8p0h0cUbs93B1+GKVxKg94hYoMb9g0uLzz3Io6h+zErGMN81jNkQNlbN4W+iq6aPS/1BJrYdACwBM93aUvCHdJhmRXXC3IBavCjk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=FYUgd4V0; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 89686C19423;
	Tue, 10 Mar 2026 18:20:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1773166816;
	bh=LgiCSQbpdMiGnsRj49OVFWuPOgHyxYUtAktmSKt5Crg=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=FYUgd4V0qxipLSgxLjrg9osCPm33Iq+cd5pCvGTGPQB89VwkFiS2d0ZMJPT4NrnKf
	 F6ENWBLK6WuW4jdZ0V5Lmnb87LLgku87G/ooELJ0muri15Idee70DwZBbUodpNwpco
	 Q5guiH/yh0dQ+875bTN9E/zE+OrUZnAkyEXlxnfKC9z2HZ+Mq389jJnA8hEch/Zi9i
	 zmqX73N15tkYxgzqQB67/o5rJdAAVkdQ4l9Cnq6MYnGpDCFdZM/QgCSXVJNDgbSMmM
	 L3XHCYmQshZ5PVmCRt2Q1IcVIRk7BGq59oInjfch+lskigins/OvuE5EHwr4QiQaEY
	 U/+jaGPnK8odw==
Date: Tue, 10 Mar 2026 20:20:12 +0200
From: Leon Romanovsky <leon@kernel.org>
To: Sabrina Dubroca <sd@queasysnail.net>
Cc: netdev@vger.kernel.org, Steffen Klassert <steffen.klassert@secunet.com>,
	Herbert Xu <herbert@gondor.apana.org.au>
Subject: Re: [PATCH ipsec-next 01/10] xfrm: state: fix sparse warnings on
 xfrm_state_hold_rcu
Message-ID: <20260310182012.GF12611@unreal>
References: <cover.1773051558.git.sd@queasysnail.net>
 <7388df7238672a92be0e4048f0225e6db294e736.1773051558.git.sd@queasysnail.net>
 <20260310103135.GB12611@unreal>
 <abABg6aO9twGIk7F@krikkit>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <abABg6aO9twGIk7F@krikkit>
X-Rspamd-Queue-Id: B0D16256556
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-1.66 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_RHS_NOT_FQDN(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_SPF_ALLOW(-0.20)[+ip4:172.105.105.114];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-266290-lists,netdev=lfdr.de];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	FROM_HAS_DN(0.00)[];
	MISSING_XM_UA(0.00)[];
	RCPT_COUNT_THREE(0.00)[4];
	NEURAL_HAM(-0.00)[-1.000];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[leon@kernel.org,netdev@vger.kernel.org];
	DKIM_TRACE(0.00)[kernel.org:+];
	TAGGED_RCPT(0.00)[netdev];
	ASN(0.00)[asn:63949, ipnet:172.105.96.0/20, country:SG];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TO_DN_SOME(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:rdns,tor.lore.kernel.org:helo,queasysnail.net:email]
X-Rspamd-Action: no action

On Tue, Mar 10, 2026 at 12:33:23PM +0100, Sabrina Dubroca wrote:
> 2026-03-10, 12:31:35 +0200, Leon Romanovsky wrote:
> > On Mon, Mar 09, 2026 at 11:32:34AM +0100, Sabrina Dubroca wrote:
> > > In all callers, x is not an __rcu pointer. We can drop the annotation to
> > > avoid sparse warnings:
> > > 
> > > net/xfrm/xfrm_state.c:58:39: warning: incorrect type in argument 1 (different address spaces)
> > > net/xfrm/xfrm_state.c:58:39:    expected struct refcount_struct [usertype] *r
> > > net/xfrm/xfrm_state.c:58:39:    got struct refcount_struct [noderef] __rcu *
> > > net/xfrm/xfrm_state.c:1166:42: warning: incorrect type in argument 1 (different address spaces)
> > > net/xfrm/xfrm_state.c:1166:42:    expected struct xfrm_state [noderef] __rcu *x
> > > net/xfrm/xfrm_state.c:1166:42:    got struct xfrm_state *[assigned] x
> > > (repeated for each caller)
> > > 
> > > Signed-off-by: Sabrina Dubroca <sd@queasysnail.net>
> > > ---
> > >  net/xfrm/xfrm_state.c | 2 +-
> > >  1 file changed, 1 insertion(+), 1 deletion(-)
> > > 
> > > diff --git a/net/xfrm/xfrm_state.c b/net/xfrm/xfrm_state.c
> > > index 98b362d51836..7a68c594ce37 100644
> > > --- a/net/xfrm/xfrm_state.c
> > > +++ b/net/xfrm/xfrm_state.c
> > > @@ -53,7 +53,7 @@ static DECLARE_WORK(xfrm_state_gc_work, xfrm_state_gc_task);
> > >  static HLIST_HEAD(xfrm_state_gc_list);
> > >  static HLIST_HEAD(xfrm_state_dev_gc_list);
> > >  
> > > -static inline bool xfrm_state_hold_rcu(struct xfrm_state __rcu *x)
> > > +static inline bool xfrm_state_hold_rcu(struct xfrm_state *x)
> > >  {
> > >  	return refcount_inc_not_zero(&x->refcnt);
> > >  }
> > 
> > This change makes me wonder why we need both xfrm_state_hold_rcu() and
> > xfrm_state_hold().
> 
> Commit 02efdff7e209 ("xfrm: state: use atomic_inc_not_zero to
> increment refcount") and the series around it [0] introduced the
> possibility of that refcount increment failing.
> 
> I can't tell you why a 10-years-old commit made some choice, but
> keeping both variants has the benefit of documenting that one
> increment is expected to never fail (because we already hold a ref on
> the object on that path) and we can skip the error handling. We don't
> want to add error handling that will never get reached, it always goes
> wrong (because it's untested) and it adds uneeded complexity to the
> code.
> 
> So I wouldn't get rid of xfrm_state_hold.

So let's add some comment when this function should be used.

Thanks

> 
> [0] https://lore.kernel.org/netdev/1470737769-30438-1-git-send-email-fw@strlen.de/
> 
> -- 
> Sabrina

