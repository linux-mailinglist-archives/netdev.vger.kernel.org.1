Return-Path: <netdev+bounces-88201-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 5C25D8A6491
	for <lists+netdev@lfdr.de>; Tue, 16 Apr 2024 09:10:44 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 13639282F86
	for <lists+netdev@lfdr.de>; Tue, 16 Apr 2024 07:10:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 089BA7FBC4;
	Tue, 16 Apr 2024 07:10:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=kpnmail.nl header.i=@kpnmail.nl header.b="CTmQZy5a"
X-Original-To: netdev@vger.kernel.org
Received: from ewsoutbound.kpnmail.nl (ewsoutbound.kpnmail.nl [195.121.94.168])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D402E78274
	for <netdev@vger.kernel.org>; Tue, 16 Apr 2024 07:10:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.121.94.168
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713251432; cv=none; b=cmF+hli3BJuyAPtLeLjqpoXzFUBqqd/RJ+OobmoDblpCImPIh2FjXZ9d2THLmi0dpeAznndEYaZ2+2aEpKYu0l45nSElqOX+jnC825ruRYGbjxZTkq5tKkX5wPU53ou7rKaBuRkFgaIx6lkwBMpTRLz9KLtvWmbhqPP748aFxjc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713251432; c=relaxed/simple;
	bh=6KtZVrfUgv7NFlHvshVY0CeRFcl3xDbihu1O6NRicXE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=trQm+vOLlQFAO9Zj5VR25fDMiLXBvUjOmIpTBFnvCEs58gKTgiDYLyDMiOKWkM3azLWPuuHVttCO4uwjC6VmPP9PY44XqTZyZYTPZqYG8zD6NGiSJ4BWicf7mBOkRNOD9UR/tDqORa74xvSm+13mSdzzQp+D4RXOE1itvZvbWEU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=phenome.org; spf=none smtp.mailfrom=phenome.org; dkim=pass (1024-bit key) header.d=kpnmail.nl header.i=@kpnmail.nl header.b=CTmQZy5a; arc=none smtp.client-ip=195.121.94.168
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=phenome.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=phenome.org
X-KPN-MessageId: 60693421-fbc0-11ee-8fdf-005056aba152
Received: from smtp.kpnmail.nl (unknown [10.31.155.40])
	by ewsoutbound.so.kpn.org (Halon) with ESMTPS
	id 60693421-fbc0-11ee-8fdf-005056aba152;
	Tue, 16 Apr 2024 09:10:16 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=kpnmail.nl; s=kpnmail01;
	h=content-type:mime-version:message-id:subject:to:from:date;
	bh=lYDa+YN/DDiQIYy7joqqN/HQ3zv4Gh4lKY9bA89ktOg=;
	b=CTmQZy5atymt5Ys9Reso/GbgSadoO18/zwaY31mIPPq06J/Y8MTZj3/s1Mivt1aPKDMjdUhERd+iv
	 hZKZqaEsXHHaCMh204mAXPwLhxnpBkuueCSujoZ52ZpfawsTJqo4Flavx4ICPBCBseAS/SBQQzFSEa
	 0OdlEbyRv2XP+3hg=
X-KPN-MID: 33|IIl5i5fzby3fhIYkEnavkDs88dB5IHb5gKtT95DpLz2HApNMFPLaGXtHwDamp2s
 /dCXCXMr0uYotCX7jOb4knxuulPFRcLmI888MNN/V3ZU=
X-KPN-VerifiedSender: No
X-CMASSUN: 33|Fh1Bs2F6Y/uaDSBxCvgF5ywPvsHr553M5IG1riIThmxt8O66hgktHuw9P4f5Qx+
 38C7Xw6Xjou41eIe+QM5LSA==
Received: from Antony2201.local (213-10-186-43.fixed.kpn.net [213.10.186.43])
	by smtp.xs4all.nl (Halon) with ESMTPSA
	id 65afea57-fbc0-11ee-9f0d-005056ab7584;
	Tue, 16 Apr 2024 09:10:26 +0200 (CEST)
Date: Tue, 16 Apr 2024 09:10:25 +0200
From: Antony Antony <antony@phenome.org>
To: Sabrina Dubroca <sd@queasysnail.net>
Cc: Antony Antony <antony.antony@secunet.com>,
	Steffen Klassert <steffen.klassert@secunet.com>,
	Herbert Xu <herbert@gondor.apana.org.au>, netdev@vger.kernel.org,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	devel@linux-ipsec.org, Leon Romanovsky <leon@kernel.org>,
	Eyal Birger <eyal.birger@gmail.com>,
	Nicolas Dichtel <nicolas.dichtel@6wind.com>
Subject: Re: [devel-ipsec] [PATCH ipsec-next v10 1/3] xfrm: Add Direction to
 the SA in or out
Message-ID: <Zh4kYUjvDtUq69-h@Antony2201.local>
References: <0e0d997e634261fcdf16cf9f07c97d97af7370b6.1712828282.git.antony.antony@secunet.com>
 <Zh0b3gfnr99ddaYM@hog>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Zh0b3gfnr99ddaYM@hog>

On Mon, Apr 15, 2024 at 02:21:50PM +0200, Sabrina Dubroca via Devel wrote:
> 2024-04-11, 11:40:59 +0200, Antony Antony wrote:
> > diff --git a/net/xfrm/xfrm_compat.c b/net/xfrm/xfrm_compat.c
> > index 655fe4ff8621..007dee03b1bc 100644
> > --- a/net/xfrm/xfrm_compat.c
> > +++ b/net/xfrm/xfrm_compat.c
> > @@ -98,6 +98,7 @@ static const int compat_msg_min[XFRM_NR_MSGTYPES] = {
> >  };
> > 
> >  static const struct nla_policy compat_policy[XFRMA_MAX+1] = {
> > +	[XFRMA_UNSPEC]          = { .strict_start_type = XFRMA_SA_DIR },
> >  	[XFRMA_SA]		= { .len = XMSGSIZE(compat_xfrm_usersa_info)},
> >  	[XFRMA_POLICY]		= { .len = XMSGSIZE(compat_xfrm_userpolicy_info)},
> >  	[XFRMA_LASTUSED]	= { .type = NLA_U64},
> > @@ -129,6 +130,7 @@ static const struct nla_policy compat_policy[XFRMA_MAX+1] = {
> >  	[XFRMA_SET_MARK_MASK]	= { .type = NLA_U32 },
> >  	[XFRMA_IF_ID]		= { .type = NLA_U32 },
> >  	[XFRMA_MTIMER_THRESH]	= { .type = NLA_U32 },
> > +	[XFRMA_SA_DIR]          = { .type = NLA_U8}
> 
> nit: <...> },
> 
> (space before } and , afterwards)
> 
> See below for a comment on the policy itself.

fixed in v11.

> 
> 
> > diff --git a/net/xfrm/xfrm_device.c b/net/xfrm/xfrm_device.c
> > index 6346690d5c69..2455a76a1cff 100644
> > --- a/net/xfrm/xfrm_device.c
> > +++ b/net/xfrm/xfrm_device.c
> > @@ -253,6 +253,12 @@ int xfrm_dev_state_add(struct net *net, struct xfrm_state *x,
> >  		return -EINVAL;
> >  	}
> > 
> > +	if ((xuo->flags & XFRM_OFFLOAD_INBOUND && x->dir == XFRM_SA_DIR_OUT) ||
> > +	    (!(xuo->flags & XFRM_OFFLOAD_INBOUND) && x->dir == XFRM_SA_DIR_IN)) {
> > +		NL_SET_ERR_MSG(extack, "Mismatched SA and offload direction");
> > +		return -EINVAL;
> > +	}
> 
> It would be nice to set x->dir to match the flag, but then I guess the
> validation in xfrm_state_update would fail if userspaces tries an
> update without providing XFRMA_SA_DIR. (or not because we already went
> through this code by the time we get to xfrm_state_update?)

this code already executed from xfrm_state_construct.
We could set the in flag in xuo when x->dir == XFRM_SA_DIR_IN, let me think 
again.  May be we can do that later:)

> > diff --git a/net/xfrm/xfrm_user.c b/net/xfrm/xfrm_user.c
> > index 810b520493f3..df141edbe8d1 100644
> > --- a/net/xfrm/xfrm_user.c
> > +++ b/net/xfrm/xfrm_user.c
> [...]
> > @@ -779,6 +793,77 @@ static struct xfrm_state *xfrm_state_construct(struct net *net,
> >  	return NULL;
> >  }
> > 
> > +static int verify_sa_dir(const struct xfrm_state *x, struct netlink_ext_ack *extack)
> > +{
> > +	if (x->dir == XFRM_SA_DIR_OUT)  {
> > +		if (x->props.replay_window > 0) {
> > +			NL_SET_ERR_MSG(extack, "Replay window should not be set for OUT SA");
> > +			return -EINVAL;
> > +		}
> > +
> > +		if (x->replay.seq || x->replay.bitmap) {
> > +			NL_SET_ERR_MSG(extack,
> > +				       "Replay seq, or bitmap should not be set for OUT SA with ESN");
> 
> I thought x->replay was for non-ESN, since we have x->replay_esn.
> 
you are right. It is a wrong text due to copy paste.
Fixed in v11.

> > +			return -EINVAL;
> > +		}
> > +
> > +		if (x->replay_esn) {
> > +			if (x->replay_esn->replay_window > 1) {
> > +				NL_SET_ERR_MSG(extack,
> > +					       "Replay window should be 1 for OUT SA with ESN");
> 
> I don't think that we should introduce something we know doesn't make
> sense (replay window = 1 on output). It will be API and we won't be
> able to fix it up later. We get a chance to make things nice and
> reasonable with this new attribute, let's not waste it.


>
> As I said, AFAICT replay_esn->replay_window isn't used on output, so
> unless I missed something, it should just be a matter of changing the
> validation. The additional checks in this version should guarantee we
> don't have dir==OUT SAs in the packet input path, so this should work.

I agree. Your message and Steffen's message helped me figure out,
how to allow replay-window zero for output SA;
It is in v11.

> > +				return -EINVAL;
> > +			}
> > +
> > +			if (x->replay_esn->seq || x->replay_esn->seq_hi || x->replay_esn->bmp_len) {
> > +				NL_SET_ERR_MSG(extack,
> > +					       "Replay seq, seq_hi, bmp_len should not be set for OUT SA with ESN");
> > +				return -EINVAL;
> > +			}
> > +		}
> > +
> > +		if (x->props.flags & XFRM_STATE_DECAP_DSCP) {
> > +			NL_SET_ERR_MSG(extack, "Flag NDECAP_DSCP should not be set for OUT SA");
> 
>                                                      ^ extra N?
> 
> > +			return -EINVAL;
> > +		}
> > +
> 
> [...]
> >  static int xfrm_add_sa(struct sk_buff *skb, struct nlmsghdr *nlh,
> >  		       struct nlattr **attrs, struct netlink_ext_ack *extack)
> >  {
> > @@ -796,6 +881,16 @@ static int xfrm_add_sa(struct sk_buff *skb, struct nlmsghdr *nlh,
> >  	if (!x)
> >  		return err;
> > 
> > +	if (x->dir) {
> > +		err = verify_sa_dir(x, extack);
> > +		if (err) {
> > +			x->km.state = XFRM_STATE_DEAD;
> > +			xfrm_dev_state_delete(x);
> > +			xfrm_state_put(x);
> > +			return err;
> 
> That's not very nice. We're creating a state and just throwing it away
> immediately. How hard would it be to validate all that directly from
> verify_newsa_info instead?

Your proposal would introduce redundant code, requiring accessing attributes 
in verify_newsa_info() and other functions.

The way I propsed, a state x,  xfrm_state, is created but it remains 
km.stae=XFRM_STATE_VOID.
Newely added verify is before auditing and generating new genid changes, 
xfrm_state_add() or xfrm_state_update() would be called later. So deleteing 
a state just after xfrm_staet_constructi() is not  bad!

So I think the current code is cleaner, avoiding the need redundant code in 
verify_newsa_info().

> 
> [...]
> > @@ -3018,6 +3137,7 @@ EXPORT_SYMBOL_GPL(xfrm_msg_min);
> >  #undef XMSGSIZE
> > 
> >  const struct nla_policy xfrma_policy[XFRMA_MAX+1] = {
> > +	[XFRMA_UNSPEC]		= { .strict_start_type = XFRMA_SA_DIR },
> >  	[XFRMA_SA]		= { .len = sizeof(struct xfrm_usersa_info)},
> >  	[XFRMA_POLICY]		= { .len = sizeof(struct xfrm_userpolicy_info)},
> >  	[XFRMA_LASTUSED]	= { .type = NLA_U64},
> > @@ -3049,6 +3169,7 @@ const struct nla_policy xfrma_policy[XFRMA_MAX+1] = {
> >  	[XFRMA_SET_MARK_MASK]	= { .type = NLA_U32 },
> >  	[XFRMA_IF_ID]		= { .type = NLA_U32 },
> >  	[XFRMA_MTIMER_THRESH]   = { .type = NLA_U32 },
> > +	[XFRMA_SA_DIR]          = { .type = NLA_U8 }
> 
> With
> 
>     .type = NLA_POLICY_RANGE(NLA_U8, XFRM_SA_DIR_IN, XFRM_SA_DIR_OUT) },
> 
> you wouldn't need to validate the attribute's values in
> verify_newsa_info and xfrm_alloc_userspi. And same for the xfrm_compat
> version of this.

thanks, this is much better.

 
> (also a nit on the formatting: a "," after the } would be nice, so
> that the next addition doesn't need to touch this line)
> 
> 
> And as we discussed, I'd really like XFRMA_SA_DIR to be rejected in
> commands that don't use its value.

I still don't see how to add such a check to about 20 functions. A burte 
force method would be 18-20 times copy code bellow, with different extack 
message.

+++ b/net/xfrm/xfrm_user.c
@@ -957,6 +957,11 @@ static int xfrm_del_sa(struct sk_buff *skb, struct nlmsghdr *nlh,
        struct km_event c;
        struct xfrm_usersa_id *p = nlmsg_data(nlh);

+       if (attrs[XFRMA_SA_DIR]) {
+               NL_SET_ERR_MSG(extack, "Delete should not have dir attribute set");
+               return -ESRCH;
+       }
+

I am still trying to figure out netlink examples, including the ones you 
pointed out : rtnl_valid_dump_net_req, rtnl_net_valid_getid_req.
I wonder if there is a way to specifiy rejeced attributes per method.

may be there is  way to call nlmsg_parse_deprecated_strict()
with .type = NLA_REJECT.

And also this looks like a general cleanup up to me. I wonder how Steffen 
would add such a check for the upcoming PCPU attribute! Should that be 
prohibited DELSA or XFRM_MSG_FLUSHSA or DELSA?

-antony

