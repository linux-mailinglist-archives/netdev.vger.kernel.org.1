Return-Path: <netdev+bounces-86462-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A441389EE16
	for <lists+netdev@lfdr.de>; Wed, 10 Apr 2024 10:56:55 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 5A32E2855B1
	for <lists+netdev@lfdr.de>; Wed, 10 Apr 2024 08:56:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4D90E154BF6;
	Wed, 10 Apr 2024 08:56:51 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from us-smtp-delivery-44.mimecast.com (us-smtp-delivery-44.mimecast.com [205.139.111.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DF3AB13D2A0
	for <netdev@vger.kernel.org>; Wed, 10 Apr 2024 08:56:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.139.111.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712739411; cv=none; b=HMJQPseI6JAKEJr/6jhooBIKzmQ3uqhezeFTJFMpEEzYjc3fR0XTo+YIqxvFTHKkbYcg4Slq7ymKyjyyz/EvQioQ6tru6e/SgnlvBugePMvLZFOGGK56jNSOmT4qeBky7dawCTPYQgl8sZzqgk2J/2LW7G+3n2inW+lOjY6x1yw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712739411; c=relaxed/simple;
	bh=flUaicSaFYFakxxYfTiINyaUEHoftoHJE/+AAF8LlBI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 In-Reply-To:Content-Type:Content-Disposition; b=Bv/cnxBB4oegOnVU6K6AKoG+QrU6aQgL+aLyRG3dH9IMOyTvm62jrBrVQkzo7EKxL7sAd3TzSPn7Ipf1pemC2HXWnAmZ2NYkDPE1r7zAqC7WTkjfX/MecXrKC8o6j/Sm4mMVZxd5ds2nOb0726vgx79nRNDcmOyWFBZu588Tqsc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=queasysnail.net; spf=none smtp.mailfrom=queasysnail.net; arc=none smtp.client-ip=205.139.111.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=queasysnail.net
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=queasysnail.net
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-224-u1TV1jBZOXmpEJzNeO7udA-1; Wed, 10 Apr 2024 04:56:42 -0400
X-MC-Unique: u1TV1jBZOXmpEJzNeO7udA-1
Received: from smtp.corp.redhat.com (int-mx07.intmail.prod.int.rdu2.redhat.com [10.11.54.7])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 12A081887313;
	Wed, 10 Apr 2024 08:56:42 +0000 (UTC)
Received: from hog (unknown [10.39.192.7])
	by smtp.corp.redhat.com (Postfix) with ESMTPS id 1C1671C06667;
	Wed, 10 Apr 2024 08:56:39 +0000 (UTC)
Date: Wed, 10 Apr 2024 10:56:34 +0200
From: Sabrina Dubroca <sd@queasysnail.net>
To: Antony Antony <antony@phenome.org>
Cc: Nicolas Dichtel <nicolas.dichtel@6wind.com>,
	Antony Antony <antony.antony@secunet.com>,
	Herbert Xu <herbert@gondor.apana.org.au>, netdev@vger.kernel.org,
	devel@linux-ipsec.org, Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	"David S. Miller" <davem@davemloft.net>
Subject: Re: [devel-ipsec] [PATCH ipsec-next v6] xfrm: Add Direction to the
 SA in or out
Message-ID: <ZhZUQoOuvNz8RVg8@hog>
References: <a53333717022906933e9113980304fa4717118e9.1712320696.git.antony.antony@secunet.com>
 <ZhBzcMrpBCNXXVBV@hog>
 <ZhJX-Rn50RxteJam@Antony2201.local>
 <ZhPq542VY18zl6z3@hog>
 <ZhV5eG2pkrsX0uIV@Antony2201.local>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
In-Reply-To: <ZhV5eG2pkrsX0uIV@Antony2201.local>
X-Scanned-By: MIMEDefang 3.4.1 on 10.11.54.7
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: queasysnail.net
Content-Type: text/plain; charset=UTF-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

2024-04-09, 19:23:04 +0200, Antony Antony wrote:
> On Mon, Apr 08, 2024 at 03:02:31PM +0200, Sabrina Dubroca wrote:
> > 2024-04-07, 10:23:21 +0200, Antony Antony wrote:
> > > Thank you for raising this point.  I thought that introducing a patch=
 for=20
> > > the replay window check could stir more controversy, which might dela=
y the=20
> > > acceptance of the essential 'dir' feature.
> >=20
> > I'm not convinced it's *that* critical. People have someone managed to
>=20
> Understood, but from a user's perspective, I've seen significant confusio=
n=20
> around this issue. Labeling it as 'historical' and unchangeable ignores i=
ts=20
> real impact on usability. I feel adding "dir"  would help a lot.

Sure. I meant that also in relation to IPTFS development:

> > use IPsec without it for all those years. Is the intention to only
> > allow setting up IPTFS SAs when this new 'dir' attribute is provided?
> > If not, then this patch is not really blocking for IPTFS.


[...]
> > > For non-ESN scenarios, the outbound SA should have a replay window se=
t to 0?
> >=20
> > Looks ok.
> >=20
> > > And for ESN 1?
> >=20
> > Why 1 and not 0?
>=20
> Current implemenation does not allow 0.

So we have to pass a replay window even if we know the SA is for
output? That's pretty bad.

> Though supporting 0 is higly desired=20
> feature and probably a hard to implement feature in xfrm code.=20

Why would it be hard for outgoing SAs? The replay window should never
be used on those. And xfrm_replay_check_esn and xfrm_replay_check_bmp
already have checks for 0-sized replay window.

> Supporting 0=20
> is also a long standing argument:)
>=20
> https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/tree/n=
et/xfrm/xfrm_replay.c#n781
>=20
> int xfrm_init_replay(struct xfrm_state *x, struct netlink_ext_ack *extack=
)
>=20
> 781                         if (replay_esn->replay_window =3D=3D 0) {
> 782                                 NL_SET_ERR_MSG(extack, "ESN replay wi=
ndow must be > 0");
> 783                                 return -EINVAL;
> 784                         }
>=20
> > Does setting xfrm_replay_state_esn->{oseq,oseq_hi} on an input SA (and
> > {seq,seq_hi} on output) make sense?
>=20
> Good point. I will add  {seq,seq_hi} validation. I don't think we add a f=
or=20
> {oseq,oseq_hi} as it might be used by strongSwan with: ESN  replay-window=
 1,=20
> and migrating an SA.

I'm not at all familiar with that. Can you explain the problem?

Also, this is a new bit of API. We don't have to accept strange
configs with it, userspace should adapt to the strict rules we
require.

> > And xfrm_state_update probably needs to check that the dir value
> > matches?  If we get this far we know the new state had matching
> > direction and properties, but maybe the old one didn't?
>=20
> Yes. I will add this too.
>=20
> > In XFRMA_SA_EXTRA_FLAGS, both XFRM_SA_XFLAG_DONT_ENCAP_DSCP and
> > XFRM_SA_XFLAG_OSEQ_MAY_WRAP look like they're only used on output. A
> > few of the flags defined with xfrm_usersa_info also seem to work only
> > in one direction (XFRM_STATE_DECAP_DSCP, XFRM_STATE_NOPMTUDISC,
> > XFRM_STATE_ICMP).
>=20
> I'm familiar with one flag, but my knowledge on the rest is limited, stil=
l I=20
> believe they aren't direction-specific. If anyone has more specific insig=
ht,=20
> please do share. Are any of these flags or x flags direction specific?

[I typically wait for answers to my questions before I post the next
version of a patch. Otherwise, reviewers have to do more work, looking
at each version.]

BTW I just looked at all the flags defined in uapi, and asked cscope
where they were used. For some, the function names were clearly only
output path, for some just input, or both directions.

[...]
> > I think it would also make sense to only accept this attribute in
> > xfrm_add_sa, and not for any of the other message types. Sharing
>=20
> > xfrma_policy is convenient but not all attributes are valid for all
> > requests. Old attributes can't be changed, but we should try to be
> > more strict when we introduce new attributes.
>=20
> To clarify your feedback, are you suggesting the API should not permit=20
> XFRMA_SA_DIR for methods like XFRM_MSG_DELSA, and only allow it for=20
> XFRM_MSG_NEWSA and XFRM_MSG_UPDSA? I added XFRM_MSG_UPDSA, as it's used=
=20
> equivalently to XFRM_MSG_NEWSA by *swan.

Not just DELSA, also all the *POLICY, ALLOCSPI, FLUSHSA, etc. NEWSA
and UPDSA should accept it, but I'm thinking none of the other
operations should. It's a property of SAs, not of other xfrm objects.

Thanks.

--=20
Sabrina


