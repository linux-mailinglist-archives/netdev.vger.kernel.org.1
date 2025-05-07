Return-Path: <netdev+bounces-188521-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id D4B84AAD2DD
	for <lists+netdev@lfdr.de>; Wed,  7 May 2025 03:41:29 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 0AD041B6813D
	for <lists+netdev@lfdr.de>; Wed,  7 May 2025 01:41:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A0B2372625;
	Wed,  7 May 2025 01:41:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="abssLpaG"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7AFB529CEB
	for <netdev@vger.kernel.org>; Wed,  7 May 2025 01:41:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746582086; cv=none; b=LiFyN1E5Ej+i7oJZehvFbakHrDbx9NPm0uZvTLa/oDFbIEx9NQmYQBIav1oicDx6A5Zjtxua+TEe9KlQw/6pxTdnzmJq1qJDHBhzFyCifL0SMZoamPE6G7WsAtV5Ybm8RuIztTfFJEMgPAxAkPRfjf5NmeDDbXIYpZCVNbDpxP0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746582086; c=relaxed/simple;
	bh=GZFLDeUyW8WFAHz/9MDCaM7AUYGFJNyq42ShthiUUnk=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=nedbZRLtRawIHfw8WZobSDrtajmTA6C3oNkjZKwvNpWxbMX17Gxz0r3S8COI9J6sZWMpVqIj5rSNWLK25Q2lrg4FcDone9DQqddCSbBS8Mgkwb6Jxd5yEXcSVM466hKztylxAzQT4ZZFm87YV7hlEgV+Cxb/bElXpHBqB4BPaEs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=abssLpaG; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 87498C4CEE4;
	Wed,  7 May 2025 01:41:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1746582086;
	bh=GZFLDeUyW8WFAHz/9MDCaM7AUYGFJNyq42ShthiUUnk=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=abssLpaGIHuWeSISN34r/Maw43STUkNAXGJWf2SVDwpHYRSy6sdcDhNNS124SwPNB
	 RAarj3ZiVuY+ojnv4Rk/h6MbnZBL56GR22IbKL+03hbdFn72ozGpwBs0+kVRypT99i
	 nRbDOwB1DSAEqtqPZamXyvMjPTlUZOr6u8EL4SGKATIb28VQ0/CN/NCoLONxoQKnVx
	 a90umNvacRTqOkrLRufcNmSK/4RyV1cqmt7i4BHOjZZ/lWAhWPXEXnL+iReMR3Qgf/
	 +Pf3DL5gg6/rJgIn6OtW4H1zChC3bivw9rt+KOhWrZLlBCOtQB9HH+Zjh0BAJOGadr
	 cjQ8g4E53DEWg==
Date: Tue, 6 May 2025 18:41:24 -0700
From: Jakub Kicinski <kuba@kernel.org>
To: Matt Johnston <matt@codeconstruct.com.au>
Cc: Jeremy Kerr <jk@codeconstruct.com.au>, "David S. Miller"
 <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, Paolo Abeni
 <pabeni@redhat.com>, Simon Horman <horms@kernel.org>,
 netdev@vger.kernel.org,
 syzbot+e76d52dadc089b9d197f@syzkaller.appspotmail.com,
 syzbot+1065a199625a388fce60@syzkaller.appspotmail.com
Subject: Re: [PATCH net] net: mctp: Don't access ifa_index when missing
Message-ID: <20250506184124.57700932@kernel.org>
In-Reply-To: <84b6bdceff61d495661dcf3500fd4bf19cf4e7be.camel@codeconstruct.com.au>
References: <20250505-mctp-addr-dump-v1-1-a997013f99b8@codeconstruct.com.au>
	<20250506180630.148c6ada@kernel.org>
	<84b6bdceff61d495661dcf3500fd4bf19cf4e7be.camel@codeconstruct.com.au>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

On Wed, 07 May 2025 09:24:29 +0800 Matt Johnston wrote:
> On Tue, 2025-05-06 at 18:06 -0700, Jakub Kicinski wrote:
> > On Mon, 05 May 2025 17:05:12 +0800 Matt Johnston wrote: =20
> > > +		/* Userspace programs providing AF_MCTP must be expecting ifa_inde=
x filter
> > > +		 * behaviour, as will those setting strict_check.
> > > +		 */
> > > +		if (hdr->ifa_family =3D=3D AF_MCTP || cb->strict_check)
> > > +			ifindex =3D hdr->ifa_index; =20
> >=20
> > The use of cb->strict_check is a bit strange here. I could be wrong but
> > I though cb->strict_check should only impact validation. Not be used
> > for changing behavior. =20
>=20
> It was following behaviour of inet_dump_addr()/inet6_dump_addr() where
> filtering is applied if strict check is set.
> I don't have strong opinion whether strict_check makes sense for MCTP tho=
ugh
> - it depends on
> whether userspace expects strict_check to apply to all families, or just
> inet4/inet6.

I see your point. And existing user space may expect filtering
even if !cb->strict_check but family is set to AF_MCTP?

> > If you have a reason to believe all user space passes a valid header -
> > how about we just return an error if message is too short?
> > IPv4 and IPv6 seem to return an error if message is short and
> > cb->strict_check, so they are more strict. MCTP doesn't have a ton of
> > legacy user space, we don't have to be lenient at all. My intuition
> > would be to always act like IP acts under cb->strict_check =20
>=20
> The problem is that programs will pass ifa_family=3DAF_UNSPEC with a short
> header, no strict_check=C2=A0
> (eg busybox "ip addr show").
> An AF_UNSPEC request will reach mctp_dump_addrinfo(), so we don't want th=
at
> returning an error.
> Maybe mctp_dump_addrinfo() should ignore AF_UNSPEC requests entirely, and
> only populate
> a response when ifa_family=3DAF_MCTP. That would be OK for the existing m=
ctp
> userspace programs=C2=A0
> I know about, though there may be other users that are calling with AF_UN=
SPEC
> but filtering=C2=A0
> userspace-side for AF_MCTP addresses.

Right, and looks like IP filters with strict_check regardless of family.
So we'd be even further away from that behavior if we never filtered
with AF_UNSPEC.

