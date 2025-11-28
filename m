Return-Path: <netdev+bounces-242597-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [IPv6:2a01:60a::1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id B98DFC9278B
	for <lists+netdev@lfdr.de>; Fri, 28 Nov 2025 16:46:00 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id 424163442BB
	for <lists+netdev@lfdr.de>; Fri, 28 Nov 2025 15:46:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DE2DD23185E;
	Fri, 28 Nov 2025 15:45:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=azey.net header.i=me@azey.net header.b="3yL9wV+q"
X-Original-To: netdev@vger.kernel.org
Received: from sender-of-o58.zoho.eu (sender-of-o58.zoho.eu [136.143.169.58])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E46F6189906;
	Fri, 28 Nov 2025 15:45:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=136.143.169.58
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1764344755; cv=pass; b=DIycy1duYZl2rRm8uwYkhwkFs/Ac3uIKNRhN1Kyv3/UU5DbDqT7Mheka2+M27d5aYTppW16/h3s85v167XBM/l0zXJ+4XSDZ+zLPWF+JjpE9OvuizM/DC9l1OLpsthFvGBBZ60VTK8cydbC8+Jpy3rgIW3kBXZYN5Fv5qbT+A/s=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1764344755; c=relaxed/simple;
	bh=SDeJB2DhmyuxRr/IrrEem7gl6bO9EHEybTVFANUVeQE=;
	h=Date:From:To:Cc:Message-ID:In-Reply-To:References:Subject:
	 MIME-Version:Content-Type; b=CkEnC5qQ3bgbjwB8CDZDXb1I/xwz+Ign4QkX4ptLSnGFgxJ8nbbw9b/FGJp0dawryjaXqT8Z2WKl+CjEe8k0OCpsUtTqPAZO/EV+nmanWyMsrh43Q6mezKeT5bMMeAf2sQNT+ZarlVHWwlBNwpyXNNnkKkRHfcYAcgFYVs/eDK8=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=azey.net; spf=pass smtp.mailfrom=azey.net; dkim=pass (1024-bit key) header.d=azey.net header.i=me@azey.net header.b=3yL9wV+q; arc=pass smtp.client-ip=136.143.169.58
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=azey.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=azey.net
ARC-Seal: i=1; a=rsa-sha256; t=1764344726; cv=none; 
	d=zohomail.eu; s=zohoarc; 
	b=gukMW8nDXNx1ZNYNhJ+TYbWUk6m/QIS3xYiC+NcNrtquf0boX4N7kQaMBjoQ4ApEZ4n4FzOeju7dRoWvca9UAfwuUrnsmICJvCnz1GE47puduYfagd98OoHpPkByBKtXvfiFYQX92YnaI/Y9QJLhmzykcbFuXI7Hhg+tY9UN4SM=
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=zohomail.eu; s=zohoarc; 
	t=1764344726; h=Content-Type:Content-Transfer-Encoding:Cc:Cc:Date:Date:From:From:In-Reply-To:MIME-Version:Message-ID:References:Subject:Subject:To:To:Message-Id:Reply-To; 
	bh=WsPPAYvzNsMcmw4LxcvRF6A3l/ktMTo3Zx/nU5ujzGg=; 
	b=LPy8VfgH3paRIgYjm8i2/jCUCPaPp2HigjAIVH1a6Nol2QNjIqzsB4YaLLWXMbmq6fT370jAZeKeI19RHMyuWNPbxlCmyu6xXOR82SYu+YKGVuGSF8lJlReTSwgc/42AejKznJSiC9BZO7JStdwpDMO9wuens8QUpUrWqcdrYiU=
ARC-Authentication-Results: i=1; mx.zohomail.eu;
	dkim=pass  header.i=azey.net;
	spf=pass  smtp.mailfrom=me@azey.net;
	dmarc=pass header.from=<me@azey.net>
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; t=1764344726;
	s=zmail; d=azey.net; i=me@azey.net;
	h=Date:Date:From:From:To:To:Cc:Cc:Message-ID:In-Reply-To:References:Subject:Subject:MIME-Version:Content-Type:Content-Transfer-Encoding:Message-Id:Reply-To;
	bh=WsPPAYvzNsMcmw4LxcvRF6A3l/ktMTo3Zx/nU5ujzGg=;
	b=3yL9wV+qIj4I2NFcwfd+iDxN8cqxGpeLj5IVGNDXajycvoxeU+U5pgXUKlaAdpfl
	f3jufpEOXxSI+6Yp2E3x4oCG/NFuNV9VdgXwX+BtXH9PWyJmjHQzFr73F8eXrDkMafp
	RTeJyuOUIzXiNaRDToG+lbETlZqHCPirnz4ERQxQ=
Received: from mail.zoho.eu by mx.zoho.eu
	with SMTP id 1764344724752623.9422997264804; Fri, 28 Nov 2025 16:45:24 +0100 (CET)
Date: Fri, 28 Nov 2025 16:45:24 +0100
From: azey <me@azey.net>
To: "nicolasdichtel" <nicolas.dichtel@6wind.com>
Cc: "Jakub Kicinski" <kuba@kernel.org>, "David Ahern" <dsahern@kernel.org>,
	"David S. Miller" <davem@davemloft.net>,
	"Eric Dumazet" <edumazet@google.com>,
	"Paolo Abeni" <pabeni@redhat.com>, "Simon Horman" <horms@kernel.org>,
	"netdev" <netdev@vger.kernel.org>,
	"linux-kernel" <linux-kernel@vger.kernel.org>
Message-ID: <19acb23fcf6.126ff53f1199305.3435243475109739554@azey.net>
In-Reply-To: <da447d68-8461-4ca5-87ae-dcfdec1308db@6wind.com>
References: <3k3facg5fiajqlpntjqf76cfc6vlijytmhblau2f2rdstiez2o@um2qmvus4a6b>
 <20251124190044.22959874@kernel.org>
 <19ac14b0748.af1e2f2513010.3648864297965639099@azey.net>
 <85a27a0d-de08-413d-af07-0eb3a3732602@6wind.com>
 <19ac5a2ee05.c5da832c80393.3479213523717146821@azey.net>
 <1d44e105-77bd-42e7-81f5-6e235fd12554@6wind.com>
 <19aca794ddd.105d1f97f173752.5540866508598154532@azey.net> <da447d68-8461-4ca5-87ae-dcfdec1308db@6wind.com>
Subject: Re: [PATCH v2] net/ipv6: allow device-only routes via the multipath
 API
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Importance: Medium
User-Agent: Zoho Mail
X-Mailer: Zoho Mail

On 2025-11-28 16:28:57 +0100  Nicolas Dichtel <nicolas.dichtel@6wind.com> w=
rote:
> Le 28/11/2025 =C3=A0 13:38, azey a =C3=A9crit :
> > On 2025-11-28 09:38:07 +0100  Nicolas Dichtel <nicolas.dichtel@6wind.co=
m> wrote:
> >> With IPv6, unlike IPv4, the ECMP next hops can be added one by one. Yo=
ur commit
> >> doesn't allow this:
> >>
> >> $ ip -6 route add 2002::/64 via fd00:125::2 dev ntfp2
> >> $ ip -6 route append 2002::/64 dev ntfp3
> >> $ ip -6 route
> >> 2002::/64 via fd00:125::2 dev ntfp2 metric 1024 pref medium
> >> 2002::/64 dev ntfp3 metric 1024 pref medium
> >> ...
> >> $ ip -6 route append 2002::/64 via fd00:175::2 dev ntfp3
> >> $ ip -6 route
> >> 2002::/64 metric 1024 pref medium
> >>         nexthop via fd00:125::2 dev ntfp2 weight 1
> >>         nexthop via fd00:175::2 dev ntfp3 weight 1
> >>
> >> Note that the previous route via ntfp3 has been removed.
> >=20
> > I just tested your example in a VM with my patch, and everything works
> > as you described. This is due to fib6_explicit_ecmp not overriding
> I tested your patch ;-)
>=20
> 'ip -6 route append 2002::/64 dev ntfp3' failed to add the next hop, a se=
cond
> route was created.

Right, sorry! Still though, I tested the same thing without my patch and
observed the exact same behavior:

$ ip -6 r add 2002::/64 via fd00::2 dev wg0
$ ip -6 r append 2002::/64 dev wg1
$ ip -6 r
2002::/64 via fd00::2 dev wg0 metric 1024 pref medium
2002::/64 dev wg1 metric 1024 pref medium
...
$ ip -6 r append 2002::/64 via fd01::2 dev wg1
$ ip -6 r
2002::/64 metric 1024 pref medium
=09nexthop via fd00::2 dev wg0 weight 1=20
=09nexthop via fd01::2 dev wg1 weight 1
...

The 2002::/64 dev wg1 route also gets removed. Could you test this on
your side to confirm? I think this is actually the current behavior.

