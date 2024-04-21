Return-Path: <netdev+bounces-89892-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 0B44E8AC199
	for <lists+netdev@lfdr.de>; Mon, 22 Apr 2024 00:06:17 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 28EC21C203D7
	for <lists+netdev@lfdr.de>; Sun, 21 Apr 2024 22:06:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D05864501E;
	Sun, 21 Apr 2024 22:06:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=kpnmail.nl header.i=@kpnmail.nl header.b="ArBf2eMN"
X-Original-To: netdev@vger.kernel.org
Received: from ewsoutbound.kpnmail.nl (ewsoutbound.kpnmail.nl [195.121.94.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 98DA4D2FF
	for <netdev@vger.kernel.org>; Sun, 21 Apr 2024 22:06:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.121.94.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713737172; cv=none; b=Tp6b60LNH3E9WL2TFmkhJWdVJhxTVEICP+OI0yWh/rhLRnKa9HYCu0gOfGur/ryFqhAN0LJx+t8m0fHXDGRiFuFvB0aMOQTfhWUuEfeEo1QxnaWAX8Bn/R5pCo7JN6vG6RFgG5arExKOh3kLkAe7GrXlVzYRHNKNZhqFSvoyrx8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713737172; c=relaxed/simple;
	bh=j2UvxaCohZBtyOIo4qspbKP6i01pDH446byRVSPm7n8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=cWntcNlFpVoYcqgfYBvCee9EVmdixfn7FvSLGB/bJ40vAcEc88DDMGg9PuF7ic6PNQ0N6GncxRSSM7rNUBb32nrSMvhIqyZlNq64vYxzBAmFvrm88KFz2Tp+QVyK1PRBG73fUPX8jTIMevKev5iTRF9xNwpDMKiNqeE2F+Yjpc0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=phenome.org; spf=none smtp.mailfrom=phenome.org; dkim=pass (1024-bit key) header.d=kpnmail.nl header.i=@kpnmail.nl header.b=ArBf2eMN; arc=none smtp.client-ip=195.121.94.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=phenome.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=phenome.org
X-KPN-MessageId: fedd9891-002a-11ef-bfb8-005056ab378f
Received: from smtp.kpnmail.nl (unknown [10.31.155.40])
	by ewsoutbound.so.kpn.org (Halon) with ESMTPS
	id fedd9891-002a-11ef-bfb8-005056ab378f;
	Mon, 22 Apr 2024 00:03:33 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=kpnmail.nl; s=kpnmail01;
	h=content-type:mime-version:message-id:subject:to:from:date;
	bh=iBVQRfmfUjGvOGfjM8IS/dL8j61hdUOzMy8L2qTLKd8=;
	b=ArBf2eMN491Na1EQmoiIqxm82QSLHne8P+Na7K86L79OEoLd2+2BZLmcBxe4rsNkAJZXj4TEtiADO
	 H5d+aBrHAM0Nyl8MP3g1orJgMb1iN7Fal/aiulUXhmoXhokn62ch8palavQXqyZS6a6sTvB+uBxEuu
	 K3Fofz9qNhu787Z4=
X-KPN-MID: 33|PhNoaz8HrMPUx7dOlTf5qBKf96KNFWv2F1eKz0cg9S+KszRLOdI6a8ZofdsgEgQ
 dTEp109wi5SOr1tCdVfGKSrMYe6Nitq0V2RmzyZKLLF0=
X-KPN-VerifiedSender: No
X-CMASSUN: 33|orOhtcb0jdC/nVbIzi5eDbg2ncDTiT/h6Z4+eZnuXGWkK0idTBsE6RnsBd2yaN8
 3y8vYFG5UKMK4iGTxQkyUQA==
Received: from Antony2201.local (213-10-186-43.fixed.kpn.net [213.10.186.43])
	by smtp.xs4all.nl (Halon) with ESMTPSA
	id 2fef00a9-002b-11ef-9f0e-005056ab7584;
	Mon, 22 Apr 2024 00:04:57 +0200 (CEST)
Date: Mon, 22 Apr 2024 00:04:55 +0200
From: Antony Antony <antony@phenome.org>
To: Sabrina Dubroca <sd@queasysnail.net>
Cc: Antony Antony <antony@phenome.org>,
	Antony Antony <antony.antony@secunet.com>,
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
Message-ID: <ZiWNh-Hz9TYWVofO@Antony2201.local>
References: <0e0d997e634261fcdf16cf9f07c97d97af7370b6.1712828282.git.antony.antony@secunet.com>
 <Zh0b3gfnr99ddaYM@hog>
 <Zh4kYUjvDtUq69-h@Antony2201.local>
 <Zh44gO885KtSjBHC@hog>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Zh44gO885KtSjBHC@hog>

Hi Sabrina,

On Tue, Apr 16, 2024 at 10:36:16AM +0200, Sabrina Dubroca wrote:
> 2024-04-16, 09:10:25 +0200, Antony Antony wrote:
> > On Mon, Apr 15, 2024 at 02:21:50PM +0200, Sabrina Dubroca via Devel wrote:
> > > 2024-04-11, 11:40:59 +0200, Antony Antony wrote:
> > > > diff --git a/net/xfrm/xfrm_device.c b/net/xfrm/xfrm_device.c
> > > > index 6346690d5c69..2455a76a1cff 100644
> > > > --- a/net/xfrm/xfrm_device.c
> > > > +++ b/net/xfrm/xfrm_device.c
> > > > @@ -253,6 +253,12 @@ int xfrm_dev_state_add(struct net *net, struct xfrm_state *x,
> > > >  		return -EINVAL;
> > > >  	}
> > > > 
> > > > +	if ((xuo->flags & XFRM_OFFLOAD_INBOUND && x->dir == XFRM_SA_DIR_OUT) ||
> > > > +	    (!(xuo->flags & XFRM_OFFLOAD_INBOUND) && x->dir == XFRM_SA_DIR_IN)) {
> > > > +		NL_SET_ERR_MSG(extack, "Mismatched SA and offload direction");
> > > > +		return -EINVAL;
> > > > +	}
> > > 
> > > It would be nice to set x->dir to match the flag, but then I guess the
> > > validation in xfrm_state_update would fail if userspaces tries an
> > > update without providing XFRMA_SA_DIR. (or not because we already went
> > > through this code by the time we get to xfrm_state_update?)
> > 
> > this code already executed from xfrm_state_construct.
> > We could set the in flag in xuo when x->dir == XFRM_SA_DIR_IN, let me think 
> > again.  May be we can do that later:)
> 
> I mean setting x->dir, not setting xuo, ie adding something like this
> to xfrm_dev_state_add:
> 
>     x->dir = xuo->flags & XFRM_OFFLOAD_INBOUND ? XFRM_SA_DIR_IN : XFRM_SA_DIR_OUT;
> 
> xuo will already be set correctly when we're using offload, and won't
> be present if we're not.

Updating with older tools may fail validation. For instance, if a user creates
an SA using an older iproute2 with offload and XFRM_OFFLOAD_INBOUND flag 
set, the kernel sets x->dir = XFRM_SA_DIR_IN. Then, if the user wants to 
update this SA using the same older iproute2, which doesn't allow setting 
dir, the update will fail.

However, as I proposed, if SA dir "in" and offload is enabled, the kernel
could set xuo->flags &= XFRM_OFFLOAD_INBOUND to avoid double typing. I've
considered this, but I'm unsure of any side effects. Also this could be 
added later, which is why I've ignored it for now:)

> > > > diff --git a/net/xfrm/xfrm_user.c b/net/xfrm/xfrm_user.c
> > > > index 810b520493f3..df141edbe8d1 100644
> > > > --- a/net/xfrm/xfrm_user.c
> > > > +++ b/net/xfrm/xfrm_user.c
> > > > +			return -EINVAL;
> > > > +		}
> > > > +
> > > > +		if (x->replay_esn) {
> > > > +			if (x->replay_esn->replay_window > 1) {
> > > > +				NL_SET_ERR_MSG(extack,
> > > > +					       "Replay window should be 1 for OUT SA with ESN");
> > > 
> > > I don't think that we should introduce something we know doesn't make
> > > sense (replay window = 1 on output). It will be API and we won't be
> > > able to fix it up later. We get a chance to make things nice and
> > > reasonable with this new attribute, let's not waste it.
> > >
> > > As I said, AFAICT replay_esn->replay_window isn't used on output, so
> > > unless I missed something, it should just be a matter of changing the
> > > validation. The additional checks in this version should guarantee we
> > > don't have dir==OUT SAs in the packet input path, so this should work.
> > 
> > I agree. Your message and Steffen's message helped me figure out,
> > how to allow replay-window zero for output SA;
> > It is in v11.
> 
> Nice, thanks.
> 
> > > [...]
> > > >  static int xfrm_add_sa(struct sk_buff *skb, struct nlmsghdr *nlh,
> > > >  		       struct nlattr **attrs, struct netlink_ext_ack *extack)
> > > >  {
> > > > @@ -796,6 +881,16 @@ static int xfrm_add_sa(struct sk_buff *skb, struct nlmsghdr *nlh,
> > > >  	if (!x)
> > > >  		return err;
> > > > 
> > > > +	if (x->dir) {
> > > > +		err = verify_sa_dir(x, extack);
> > > > +		if (err) {
> > > > +			x->km.state = XFRM_STATE_DEAD;
> > > > +			xfrm_dev_state_delete(x);
> > > > +			xfrm_state_put(x);
> > > > +			return err;
> > > 
> > > That's not very nice. We're creating a state and just throwing it away
> > > immediately. How hard would it be to validate all that directly from
> > > verify_newsa_info instead?
> > 
> > Your proposal would introduce redundant code, requiring accessing attributes 
> > in verify_newsa_info() and other functions.
> > 
> > The way I propsed, a state x,  xfrm_state, is created but it remains 
> > km.stae=XFRM_STATE_VOID.
> > Newely added verify is before auditing and generating new genid changes, 
> > xfrm_state_add() or xfrm_state_update() would be called later. So deleteing 
> > a state just after xfrm_staet_constructi() is not  bad!
> > 
> > So I think the current code is cleaner, avoiding the need redundant code in 
> > verify_newsa_info().
> 
> Avoids a few easy accesses to the netlink attributes, but allocating a
> state and all its associated info just to throw it away almost
> immediately is not "cleaner" IMO.
> > > And as we discussed, I'd really like XFRMA_SA_DIR to be rejected in
> > > commands that don't use its value.
> > 
> > I still don't see how to add such a check to about 20 functions. A burte 
> > force method would be 18-20 times copy code bellow, with different extack 
> > message.
> 
> Yes, I think with the current netlink infrastructure and a single
> shared policy for all netlink message types, that's what we have to
> do. Doing it in the netlink core (or with help of the netlink core)
> seems difficult, as only the caller (xfrm_user) has all the
> information about which attributes are acceptable with each message
> type.

yes. If we use netlink infrastructure to reject attributes in some methods
shared policy is not ideal. I tried NLA_POLICY_VALIDATE_FN() that function 
does not get message type as an arguent. So add a seperate function in v11.

> 
> > +++ b/net/xfrm/xfrm_user.c
> > @@ -957,6 +957,11 @@ static int xfrm_del_sa(struct sk_buff *skb, struct nlmsghdr *nlh,
> >         struct km_event c;
> >         struct xfrm_usersa_id *p = nlmsg_data(nlh);
> > 
> > +       if (attrs[XFRMA_SA_DIR]) {
> > +               NL_SET_ERR_MSG(extack, "Delete should not have dir attribute set");
> > +               return -ESRCH;
> > +       }
> > +
> > 
> > I am still trying to figure out netlink examples, including the ones you 
> > pointed out : rtnl_valid_dump_net_req, rtnl_net_valid_getid_req.
> 
> These do pretty much what you wrote. 

> 
> > I wonder if there is a way to specifiy rejeced attributes per method.
> >
> > may be there is  way to call nlmsg_parse_deprecated_strict()
> > with .type = NLA_REJECT.
> 
> For that, we'd have to separate the policies for each netlink
> command. Otherwise NLA_REJECT will reject the SA_DIR attribute for all
> commands, which is not what we want.
> 
> > And also this looks like a general cleanup up to me. I wonder how Steffen 
> > would add such a check for the upcoming PCPU attribute! Should that be 
> > prohibited DELSA or XFRM_MSG_FLUSHSA or DELSA?
> 
> IMO, new attributes should be rejected in any handler that doesn't use
> them. That's not a general cleanup because it's a new attribute, and
> the goal is to allow us to decide later if we want to use that
> attribute in DELSA etc. Maybe in one year, we want to make DELSA able
> to match on SA_DIR. If we don't reject SA_DIR from DELSA now, we won't
> be able to do that. That's why I'm insisting on this.

I have implemented a method to reject in v11, even though it is not my 
preference:) My argument xfrm has no precedence of limiting unused 
attributes in most types. We are not enforcing on all attributes such as 
upcoming PCPU. That is why I think it is a general clean up.

I have also tweaked error messages. Removed ESN from it, in v11 verifications
for ESN and non-ESN are similar. Since output SA with ESN allows replay window
0.

-antony

