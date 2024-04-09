Return-Path: <netdev+bounces-86229-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 0F51E89E177
	for <lists+netdev@lfdr.de>; Tue,  9 Apr 2024 19:23:22 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 3238A1C20FB3
	for <lists+netdev@lfdr.de>; Tue,  9 Apr 2024 17:23:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 446F315539C;
	Tue,  9 Apr 2024 17:23:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=kpnmail.nl header.i=@kpnmail.nl header.b="EPl6hG2q"
X-Original-To: netdev@vger.kernel.org
Received: from ewsoutbound.kpnmail.nl (ewsoutbound.kpnmail.nl [195.121.94.168])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EB672155387
	for <netdev@vger.kernel.org>; Tue,  9 Apr 2024 17:23:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.121.94.168
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712683398; cv=none; b=nEaIjLSVcDJjc3333iLBcFUoEHUqiLvueg4sRzyHUK6qKMk3QqjI8Q/IIH7DRi0/ZALmjQvNNSiB4FEkqVdQ4FSHl1jjBizxenTVSeGt7tIPXDT2vheExJ8iEyLHOqIJVe/vJI7LGqmU1QfNxDzB+mO1iiuqB9sQJW1OshFw1LQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712683398; c=relaxed/simple;
	bh=ki8OXuo9fuYlX7ZNs1Jn6u0mDilzdC9nYTn0kSOTEMk=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Vxv3Dy4HgAJCSLtLEQaWwVosaajlVNFr6HulH6yVcpwyfTw2wOmA67dB1XoAgF50m88GmJGmsMGivJruorYUz990+JaatuY8NFTehixaBu0krL93GX++vWgl+Rk19tHdztSUmrEd43IgamcC7NhR2RDCNCPB8+QcqaS7TRiXWTg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=phenome.org; spf=none smtp.mailfrom=phenome.org; dkim=pass (1024-bit key) header.d=kpnmail.nl header.i=@kpnmail.nl header.b=EPl6hG2q; arc=none smtp.client-ip=195.121.94.168
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=phenome.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=phenome.org
X-KPN-MessageId: cf4e2c96-f695-11ee-8fdf-005056aba152
Received: from smtp.kpnmail.nl (unknown [10.31.155.39])
	by ewsoutbound.so.kpn.org (Halon) with ESMTPS
	id cf4e2c96-f695-11ee-8fdf-005056aba152;
	Tue, 09 Apr 2024 19:22:58 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=kpnmail.nl; s=kpnmail01;
	h=content-type:mime-version:message-id:subject:to:from:date;
	bh=jCqNCCx8PtX8sHXc6Cmavkq8TItYxi5Iwq/bMOQ1cNo=;
	b=EPl6hG2qYKnJIAETwMy5TUvtResGhPxuOYhJl8OSRkNmZ+naslRI4LwXAnQV5J+QYYGRkqUulHxPn
	 oYO59DUwDgbEOCGrRd4/2LCm45blinDUpH5vpSYNohZI0SVJ2LHZRZvnRlMRVy/3hky7Gqtj/G5xcP
	 5briSrWv6PgyXi1c=
X-KPN-MID: 33|2BwOKV+a1M3tIFrGD/Xdb8Lb01MCC0Rf9KUS6KCu13mMnvxaBuQQwo4e6dr6+Th
 DcTiHJKR0E0ThIuKhBdyMxQ==
X-KPN-VerifiedSender: No
X-CMASSUN: 33|RLu3R4LsByXGyoHBY+hwItA1hZ84hiXDJITgx1J7gAsBBO9r/P/6Rl1JFa+frrM
 YqAPKlKtLTgwlThkYMKi6DA==
Received: from Antony2201.local (213-10-186-43.fixed.kpn.net [213.10.186.43])
	by smtp.xs4all.nl (Halon) with ESMTPSA
	id d2c8f353-f695-11ee-8d53-005056ab7447;
	Tue, 09 Apr 2024 19:23:05 +0200 (CEST)
Date: Tue, 9 Apr 2024 19:23:04 +0200
From: Antony Antony <antony@phenome.org>
To: Sabrina Dubroca <sd@queasysnail.net>
Cc: Antony Antony <antony@phenome.org>,
	Nicolas Dichtel <nicolas.dichtel@6wind.com>,
	Antony Antony <antony.antony@secunet.com>,
	Herbert Xu <herbert@gondor.apana.org.au>, netdev@vger.kernel.org,
	devel@linux-ipsec.org, Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	"David S. Miller" <davem@davemloft.net>
Subject: Re: [devel-ipsec] [PATCH ipsec-next v6] xfrm: Add Direction to the
 SA in or out
Message-ID: <ZhV5eG2pkrsX0uIV@Antony2201.local>
References: <a53333717022906933e9113980304fa4717118e9.1712320696.git.antony.antony@secunet.com>
 <ZhBzcMrpBCNXXVBV@hog>
 <ZhJX-Rn50RxteJam@Antony2201.local>
 <ZhPq542VY18zl6z3@hog>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ZhPq542VY18zl6z3@hog>

On Mon, Apr 08, 2024 at 03:02:31PM +0200, Sabrina Dubroca wrote:
> 2024-04-07, 10:23:21 +0200, Antony Antony wrote:
> > Hi Sabrina,
> > 
> > On Fri, Apr 05, 2024 at 11:56:00PM +0200, Sabrina Dubroca via Devel wrote:
> > > Hi Antony,
> > > 
> > > 2024-04-05, 14:40:07 +0200, Antony Antony wrote:
> > > > This patch introduces the 'dir' attribute, 'in' or 'out', to the
> > > > xfrm_state, SA, enhancing usability by delineating the scope of values
> > > > based on direction. An input SA will now exclusively encompass values
> > > > pertinent to input, effectively segregating them from output-related
> > > > values. 
> > > 
> > > But this patch isn't doing that for existing properties (I'm thinking
> > > of replay window, not sure if any others are relevant [1]). Why not?
> > 
> > Thank you for raising this point.  I thought that introducing a patch for 
> > the replay window check could stir more controversy, which might delay the 
> > acceptance of the essential 'dir' feature.
> 
> I'm not convinced it's *that* critical. People have someone managed to

Understood, but from a user's perspective, I've seen significant confusion 
around this issue. Labeling it as 'historical' and unchangeable ignores its 
real impact on usability. I feel adding "dir"  would help a lot.

> use IPsec without it for all those years. Is the intention to only
> allow setting up IPTFS SAs when this new 'dir' attribute is provided?
> If not, then this patch is not really blocking for IPTFS.

> And yes, people will sometimes make comments on patches that cause
> delays in getting the patches accepted. Some patches even end up
> getting rejected. The kernel is better thanks to that process, even if
> it can be annoying to the submitter (including me! it would be a lot
> more relaxing if my patches always just went in at v1 :)).
> 
> Nicolas, since you were objecting to the informational nature of the
> attribute in v5: would you still object to the new attribute (and not
> just limited to offload cases) if it properly restricted attributes
> that don't match the direction?
> 
> >  My primary goal at this stage is 
> > to get this basic feature  in and to convince Chris to integrate the "dir" 
> > attribute into IP-TFS. This patch has partly contributed to the delays in 
> > IP-TFS's development.
> > 
> > Given your input, I'm curious about the specific conditions you have in 
> > mind. See the attached patch.
> 
> I didn't look into details when I wrote that email. The rough idea was
> "Whatever makes the kernel do replay protection on incoming packets"
> (and if any attribute is output-only, skip those on input SAs).
> 
> > For non-ESN scenarios, the outbound SA should have a replay window set to 0?
> 
> Looks ok.
> 
> > And for ESN 1?
> 
> Why 1 and not 0?

Current implemenation does not allow 0. Though supporting 0 is higly desired 
feature and probably a hard to implement feature in xfrm code. Supporting 0 
is also a long standing argument:)

https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/tree/net/xfrm/xfrm_replay.c#n781

int xfrm_init_replay(struct xfrm_state *x, struct netlink_ext_ack *extack)

781                         if (replay_esn->replay_window == 0) {
782                                 NL_SET_ERR_MSG(extack, "ESN replay window must be > 0");
783                                 return -EINVAL;
784                         }

> Does setting xfrm_replay_state_esn->{oseq,oseq_hi} on an input SA (and
> {seq,seq_hi} on output) make sense?

Good point. I will add  {seq,seq_hi} validation. I don't think we add a for 
{oseq,oseq_hi} as it might be used by strongSwan with: ESN  replay-window 1, 
and migrating an SA.

> And xfrm_state_update probably needs to check that the dir value
> matches?  If we get this far we know the new state had matching
> direction and properties, but maybe the old one didn't?

Yes. I will add this too.

> In XFRMA_SA_EXTRA_FLAGS, both XFRM_SA_XFLAG_DONT_ENCAP_DSCP and
> XFRM_SA_XFLAG_OSEQ_MAY_WRAP look like they're only used on output. A
> few of the flags defined with xfrm_usersa_info also seem to work only
> in one direction (XFRM_STATE_DECAP_DSCP, XFRM_STATE_NOPMTUDISC,
> XFRM_STATE_ICMP).

I'm familiar with one flag, but my knowledge on the rest is limited, still I 
believe they aren't direction-specific. If anyone has more specific insight, 
please do share. Are any of these flags or x flags direction specific?

 - XFRM_STATE_ICMP should not be allowed on "out" SA. This is good point. I 
   have seen users getting confused about this.

> > non-ESN
> > ip xfrm state add src 10.1.3.4 dst 10.1.2.3 proto esp spi 3 reqid 2  \
> > mode tunnel dir out aead 'rfc4106(gcm(aes))' \
> > 0x2222222222222222222222222222222222222222 96 if_id 11 replay-window 10
> > Error: Replay-window too big > 0 for OUT SA.
> 
> I'd probably change the string to "Replay window should not be set for
> OUT SA", that makes a bit more sense to me. "too big" implies that
> some values are valid, which isn't really the case.
>

good point. fixed in v8.

> > The current impelementation does not replay window 0 with ESN.  Even though 
> > disabling replay window with ESN is a desired feature.
> > 
> > ip xfrm state add src 10.1.3.4 dst 10.1.2.3 proto esp spi 3 reqid 2 mode 
> > tunnel dir out flag esn  aead  'rfc4106(gcm(aes))'  \
> > 0x2222222222222222222222222222222222222222 96 if_id 11 replay-window 10
> > Error: ESN replay-window too big > 1 for OUT SA.ww
> > 
> > I wonder would the attached patch get accepted quickly.
> 
> I'm more interested in getting things right if we're going to
> introduce a new bit of API. IMO a new "dir" attribute that doesn't
> fully lock down the options on an SA is worse than no attribute (as
> Nicolas said previously, it's really confusing).
> And I'm not that familiar with all the API for xfrm SAs, so the
> properties I listed above may not be everything we should lock down
> (and maybe some are wrong).
> 
> I think it would also make sense to only accept this attribute in
> xfrm_add_sa, and not for any of the other message types. Sharing

> xfrma_policy is convenient but not all attributes are valid for all
> requests. Old attributes can't be changed, but we should try to be
> more strict when we introduce new attributes.

To clarify your feedback, are you suggesting the API should not permit 
XFRMA_SA_DIR for methods like XFRM_MSG_DELSA, and only allow it for 
XFRM_MSG_NEWSA and XFRM_MSG_UPDSA? I added XFRM_MSG_UPDSA, as it's used 
equivalently to XFRM_MSG_NEWSA by *swan.

> Sorry that I didn't notice this when you posted the previous versions.

thanks your review.

-antony

