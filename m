Return-Path: <netdev+bounces-178733-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 64255A7896C
	for <lists+netdev@lfdr.de>; Wed,  2 Apr 2025 10:04:00 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id C53A8189273D
	for <lists+netdev@lfdr.de>; Wed,  2 Apr 2025 08:04:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1EE8E21ABC3;
	Wed,  2 Apr 2025 08:03:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="r4iLrorL"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E61E31362
	for <netdev@vger.kernel.org>; Wed,  2 Apr 2025 08:03:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1743581037; cv=none; b=H7uMV6z/FLHRHldw1eS3IdYUDBepxsmD85rCFFf9wpmmtSRqQy1MvaDoyam/iVdPf0vXQ3MNQBWUT25jSnk2I3bHPB73qkkIXwKTbOkNRuCalYXMAQsK6X0zKH7DqP8hbCzDQd/yM7z7dKJUs7Ynd320htfXBJ9/YiWEnaFVfMw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1743581037; c=relaxed/simple;
	bh=v75S2pEh4Qe+XJvompSAPPPcr3paP4/kJxRsItEtRAU=;
	h=Content-Type:MIME-Version:In-Reply-To:References:Subject:From:Cc:
	 To:Date:Message-ID; b=T9tjlfsMuA3cimM4Cm2wxuza4RU3Qngu7bJWDa+dA72TahX2i6wV37U7Atoy/fP9o3+P4lbpvn+4PosjCrD+rClZolw561VMu0yX8Y3+Hj9XPK+SWUU3yTqzrp49VDMqoP2PdmBemBIYdkqShVBp9Qfsj/bN/+yU7hwX37aWrXU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=r4iLrorL; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id AF05EC4CEDD;
	Wed,  2 Apr 2025 08:03:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1743581036;
	bh=v75S2pEh4Qe+XJvompSAPPPcr3paP4/kJxRsItEtRAU=;
	h=In-Reply-To:References:Subject:From:Cc:To:Date:From;
	b=r4iLrorLST1bpcyC7GZikZPBOEkkzdZkL61R0TDaKCc1AjRvo4iB1VslJYi6QU6Ly
	 iVguOOLLkfkIdx6O7FX2mURnKQQctsp6W1UZs/Et9sTK9thEb4PTHeG7Izmyiavspt
	 eWz9UyE4c+ERoIHHUl90ARFVsuR0VdAit378ahUSbmvnUshvEpZu088b1VP6QvkGRO
	 sx8uqukbCCJOtMKd8LiiLqmrq/KBNeWhs/QGhnE8pcJzpkVy0Gf076PJZcbjUufL8J
	 78pFESobTdpyMo8bkKo+l0hV+pAKVL5CF1iXXKB4Jp81WVlqWonmzDygCXXePJiDaL
	 NP7yZT9Z6EjqQ==
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
In-Reply-To: <89dcde93-8e5a-4193-aa01-fde5dd5ee1fd@redhat.com>
References: <20250326173634.31096-1-atenart@kernel.org> <89dcde93-8e5a-4193-aa01-fde5dd5ee1fd@redhat.com>
Subject: Re: [PATCH net] net: decrease cached dst counters in dst_release
From: Antoine Tenart <atenart@kernel.org>
Cc: netdev@vger.kernel.org
To: Paolo Abeni <pabeni@redhat.com>, davem@davemloft.net, edumazet@google.com, kuba@kernel.org
Date: Wed, 02 Apr 2025 10:03:52 +0200
Message-ID: <174358103232.4506.6967775691343340999@kwain>

Hi Paolo,

Quoting Paolo Abeni (2025-04-01 10:00:56)
> On 3/26/25 6:36 PM, Antoine Tenart wrote:
> >=20
> > diff --git a/net/core/dst.c b/net/core/dst.c
> > index 9552a90d4772..6d76b799ce64 100644
> > --- a/net/core/dst.c
> > +++ b/net/core/dst.c
> > @@ -165,6 +165,14 @@ static void dst_count_dec(struct dst_entry *dst)
> >  void dst_release(struct dst_entry *dst)
> >  {
> >       if (dst && rcuref_put(&dst->__rcuref)) {
> > +#ifdef CONFIG_DST_CACHE
> > +             if (dst->flags & DST_METADATA) {
> > +                     struct metadata_dst *md_dst =3D (struct metadata_=
dst *)dst;
> > +
> > +                     if (md_dst->type =3D=3D METADATA_IP_TUNNEL)
> > +                             dst_cache_reset_now(&md_dst->u.tun_info.d=
st_cache);
>=20
> I think the fix is correct, but I'm wondering if we have a similar issue
> for the METADATA_XFRM meta-dst. Isn't:
>=20
>         dst_release(md_dst->u.xfrm_info.dst_orig);
>=20
> in metadata_dst_free() going to cause the same UaF? Why don't we need to
> clean such dst here, too?

I don't know much about XFRM but if the orig_dst doesn't have
DST_NOCOUNT (which I guess is the case) you're right. Also Eric noted in
ac888d58869b,

"""
    1) in CONFIG_XFRM case, dst_destroy() can call
       dst_release_immediate(child), this might also cause UAF
       if the child does not have DST_NOCOUNT set.
       IPSEC maintainers might take a look and see how to address this.
"""

but here I'm not sure if that is the case nor of the implications of
moving that release.

As the dst_orig one seems logical I can move it to dst_release too, but
it seems a deeper look by XFRM experts would be needed in any way.

Thanks!
Antoine

