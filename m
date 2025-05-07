Return-Path: <netdev+bounces-188527-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id E73DEAAD321
	for <lists+netdev@lfdr.de>; Wed,  7 May 2025 04:13:38 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 1256F1BC6910
	for <lists+netdev@lfdr.de>; Wed,  7 May 2025 02:13:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id ADAB21922DD;
	Wed,  7 May 2025 02:13:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=codeconstruct.com.au header.i=@codeconstruct.com.au header.b="A1+64qyP"
X-Original-To: netdev@vger.kernel.org
Received: from codeconstruct.com.au (pi.codeconstruct.com.au [203.29.241.158])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C388018DB29
	for <netdev@vger.kernel.org>; Wed,  7 May 2025 02:13:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=203.29.241.158
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746584004; cv=none; b=QM7MH6A10s6B3LMiCDBGWnIx29KPzMW7tYbigJfGscJXw34YLUHAKiUGQTdsxNWVGHJn32sXhT5WnnL3gwy1xWrDwoOjgHk2dc1yAALH78GfmCrBx4n0Q3aqle4cVYXv185PLLrt6JQpBg9wIqIFIDc/qImmw7z38vnalY7Jtv8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746584004; c=relaxed/simple;
	bh=r5q6VspTM5e878nijSRW2hD+pBMuRt0kvn8C/+4yBFs=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=gsXnK5iHH6GSKvXXDuu3V3vIjqMOaRPvp+8OmQPSua3LVKSWccx1vwPBXI1vO1/8IUhxO6tC7Lz08zmjn1ESkEXaI+HoYqWlkcXFG9g+cC2lNhJ0IAZxb7cQsApeTMZO3ud3x+zeQ1DQkS88ugA4x/eI01V8uKd2zKw7TAiO7FI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=codeconstruct.com.au; spf=pass smtp.mailfrom=codeconstruct.com.au; dkim=pass (2048-bit key) header.d=codeconstruct.com.au header.i=@codeconstruct.com.au header.b=A1+64qyP; arc=none smtp.client-ip=203.29.241.158
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=codeconstruct.com.au
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=codeconstruct.com.au
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=codeconstruct.com.au; s=2022a; t=1746584000;
	bh=DuU5ScUR2GdU50JqseFB6J5GnDWkap32mDtYr6N0z4U=;
	h=Subject:From:To:Cc:Date:In-Reply-To:References;
	b=A1+64qyPdq8UDNal5Y//BCLcM3JPtWGmk4l0lQ+GoqF+XJH/LPbLvBFDPYKsI84wG
	 McUZWAfVAPgtIcaqovLq+tMGJ+Dd5usPaetKbCvs5xK3kr5vZp2cuyjS/jUKVWtqgs
	 MHQm68PJrI8813O2bZEUk4yzjLITOND5bAZZqPpwYLtwfYmpZo4ADTGWFU1+imuWAt
	 pNzTPDHhuAt/crw6FHaq4qsscvxpa2XsKha2Rl3tq5rvvzh7cMYRrkr6cVH/qTsmtL
	 WATqNLd+nKXoMRzyuTVjB2TjSnR23gzhnZp8dMpG5AfddhulF3ZvoMZujgmcb90WZj
	 ILwGq6P4WjsLw==
Received: from [192.168.14.220] (unknown [159.196.94.230])
	by mail.codeconstruct.com.au (Postfix) with ESMTPSA id DA8826C00A;
	Wed,  7 May 2025 10:13:19 +0800 (AWST)
Message-ID: <0decca5d2af88ccbe51b7e9c88a258bd8cc6c6e8.camel@codeconstruct.com.au>
Subject: Re: [PATCH net] net: mctp: Don't access ifa_index when missing
From: Matt Johnston <matt@codeconstruct.com.au>
To: Jakub Kicinski <kuba@kernel.org>
Cc: Jeremy Kerr <jk@codeconstruct.com.au>, "David S. Miller"
 <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, Paolo Abeni
 <pabeni@redhat.com>, Simon Horman <horms@kernel.org>,
 netdev@vger.kernel.org, 
 syzbot+e76d52dadc089b9d197f@syzkaller.appspotmail.com, 
 syzbot+1065a199625a388fce60@syzkaller.appspotmail.com
Date: Wed, 07 May 2025 10:13:19 +0800
In-Reply-To: <20250506184124.57700932@kernel.org>
References: <20250505-mctp-addr-dump-v1-1-a997013f99b8@codeconstruct.com.au>
	 <20250506180630.148c6ada@kernel.org>
	 <84b6bdceff61d495661dcf3500fd4bf19cf4e7be.camel@codeconstruct.com.au>
	 <20250506184124.57700932@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.52.3-0ubuntu1 
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0

On Tue, 2025-05-06 at 18:41 -0700, Jakub Kicinski wrote:
> On Wed, 07 May 2025 09:24:29 +0800 Matt Johnston wrote:
> > On Tue, 2025-05-06 at 18:06 -0700, Jakub Kicinski wrote:
> > > On Mon, 05 May 2025 17:05:12 +0800 Matt Johnston wrote: =20
> > > > +		/* Userspace programs providing AF_MCTP must be expecting ifa_in=
dex filter
> > > > +		 * behaviour, as will those setting strict_check.
> > > > +		 */
> > > > +		if (hdr->ifa_family =3D=3D AF_MCTP || cb->strict_check)
> > > > +			ifindex =3D hdr->ifa_index; =20
> > >=20
> > > The use of cb->strict_check is a bit strange here. I could be wrong b=
ut
> > > I though cb->strict_check should only impact validation. Not be used
> > > for changing behavior. =20
> >=20
> > It was following behaviour of inet_dump_addr()/inet6_dump_addr() where
> > filtering is applied if strict check is set.
> > I don't have strong opinion whether strict_check makes sense for MCTP t=
hough
> > - it depends on
> > whether userspace expects strict_check to apply to all families, or jus=
t
> > inet4/inet6.
>=20
> I see your point. And existing user space may expect filtering
> even if !cb->strict_check but family is set to AF_MCTP?

Yes, given mctp_dump_addrinfo() has always applied a filter, mctp-specific
programs likely expect that behaviour.

> > > If you have a reason to believe all user space passes a valid header =
-
> > > how about we just return an error if message is too short?
> > > IPv4 and IPv6 seem to return an error if message is short and
> > > cb->strict_check, so they are more strict. MCTP doesn't have a ton of
> > > legacy user space, we don't have to be lenient at all. My intuition
> > > would be to always act like IP acts under cb->strict_check =20
> >=20
> > The problem is that programs will pass ifa_family=3DAF_UNSPEC with a sh=
ort
> > header, no strict_check=C2=A0
> > (eg busybox "ip addr show").
> > An AF_UNSPEC request will reach mctp_dump_addrinfo(), so we don't want =
that
> > returning an error.
> > Maybe mctp_dump_addrinfo() should ignore AF_UNSPEC requests entirely, a=
nd
> > only populate
> > a response when ifa_family=3DAF_MCTP. That would be OK for the existing=
 mctp
> > userspace programs=C2=A0
> > I know about, though there may be other users that are calling with AF_=
UNSPEC
> > but filtering=C2=A0
> > userspace-side for AF_MCTP addresses.
>=20
> Right, and looks like IP filters with strict_check regardless of family.
> So we'd be even further away from that behavior if we never filtered
> with AF_UNSPEC.


