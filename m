Return-Path: <netdev+bounces-238715-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id C1D8FC5E5BB
	for <lists+netdev@lfdr.de>; Fri, 14 Nov 2025 17:55:02 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 8ECD2506C22
	for <lists+netdev@lfdr.de>; Fri, 14 Nov 2025 16:10:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2614832C955;
	Fri, 14 Nov 2025 16:03:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="tz9b3Qgb"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0173321C9EA
	for <netdev@vger.kernel.org>; Fri, 14 Nov 2025 16:03:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763136187; cv=none; b=fIi398SEA3onvGUIEA2+vhqAJ3z42epmNt2Z+90Xai4S6ggF1lwjPkwP/l0qK8Ixo1+ebQXnzeF7ASS13utYlqsQ6+UAkXQJSdjcBW1bmPMGx9dbWGJx0v6Mtbu241pkM8TE+mLD/3paOHQ1AQdV1E5qRcuMlG4zjhmA/dBxaDM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763136187; c=relaxed/simple;
	bh=Gug63O31uXdMLrnpz+G89mRGIkLeG5Y311JrJGMg+YI=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=hkEgwE+nBAAuNOWGBMCoUcpfemYSpTH8eZanCfdxIFMPy0ZIp90tA0U7un6mtnv6HBM+PZl/Ydcd8KgZTM6Dz4Yh5SvKIK1woGbPg6ap8mCow/kJiOBffpx5U5Ob2b1pH9Zm4OKQXnkQNLJEwLcZE/nv9JR+nNOI/J7et2uUkJI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=tz9b3Qgb; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 29BEFC4CEF1;
	Fri, 14 Nov 2025 16:03:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1763136186;
	bh=Gug63O31uXdMLrnpz+G89mRGIkLeG5Y311JrJGMg+YI=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=tz9b3QgbWSfm2tO5hgG/g3P3mLgSWK1o/R441Kt1SOvEl79ZNtI5YP9oqfQaja8Cp
	 +wc5sqZQX/+FX0XzRbBBEoQAVpYlgVPrHWDMtlgCaMSqYeT1df6i7PJjx4nWMH9Th4
	 shbJyr5FshB+YrVGthHM1FSpzb+YWdRhkPqXGJ93dg7WKYeDNITMeW9cuhPqAzXFLh
	 QZ6Mx5zKo5njpQwJszD9U7RFEOSm5q28nVEj+/fK61pICdUtxBZzdzS0P5e3O0Iykl
	 av4FvZZ13QpphAVYNHXOelUi0KjgOKMTV5CF3jI2pqQxSoR5D7SBzgHYVPxa2OuqNh
	 s2u2yLCThKuJg==
Date: Fri, 14 Nov 2025 08:03:05 -0800
From: Jakub Kicinski <kuba@kernel.org>
To: Eric Dumazet <edumazet@google.com>
Cc: "David S . Miller" <davem@davemloft.net>, Paolo Abeni
 <pabeni@redhat.com>, Simon Horman <horms@kernel.org>, Neal Cardwell
 <ncardwell@google.com>, Kuniyuki Iwashima <kuniyu@google.com>,
 netdev@vger.kernel.org, eric.dumazet@gmail.com
Subject: Re: [PATCH net] tcp: reduce tcp_comp_sack_slack_ns default value to
 10 usec
Message-ID: <20251114080305.6c275a7d@kernel.org>
In-Reply-To: <CANn89iLp_7voEq8SryQXUFhDDTPaRosryNtHersRD6RM49Kh0g@mail.gmail.com>
References: <20251114135141.3810964-1-edumazet@google.com>
	<CANn89iLp_7voEq8SryQXUFhDDTPaRosryNtHersRD6RM49Kh0g@mail.gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

On Fri, 14 Nov 2025 06:08:58 -0800 Eric Dumazet wrote:
> On Fri, Nov 14, 2025 at 5:51=E2=80=AFAM Eric Dumazet <edumazet@google.com=
> wrote:
> >
> > net.ipv4.tcp_comp_sack_slack_ns current default value is too high.
> >
> > When a flow has many drops (1 % or more), and small RTT, adding 100 usec
> > before sending SACK stalls the sender relying on getting SACK
> > fast enough to keep the pipe busy.
> >
> > Decrease the default to 10 usec.
> >
> > This is orthogonal to Congestion Control heuristics to determine
> > if drops are caused by congestion or not.
> >
> > Signed-off-by: Eric Dumazet <edumazet@google.com> =20
>=20
> This was meant for net-next, but applying this to net tree should be
> fine as well.
>=20
> No need for backports though.

Sorry to piggy back on a random post but looks like the changes from
a ~week ago made ncdevmem flaky:=20

https://netdev.bots.linux.dev/contest.html?executor=3Dvmksft-fbnic-qemu&tes=
t=3Ddevmem-py

Specifically it says:

using ifindex=3D3
using queues 2..3
got tx dmabuf id=3D5
Connect to 2001:db8:1::2 37943 (via enp1s0)
sendmsg_ret=3D6
ncdevmem: did not receive tx completion

This is what was in the branch that made the test fail:

[+] tcp: add net.ipv4.tcp_comp_sack_rtt_percent
[+] net: increase skb_defer_max default to 128
[+] net: fix napi_consume_skb() with alien skbs
[+] net: allow skb_release_head_state() to be called multiple times

https://netdev.bots.linux.dev/static/nipa/branch_deltas/net-next-hw-2025-11=
-08--00-00.html

I'm guessing we need to take care of the uarg if we defer freeing=20
of Tx skbs..

