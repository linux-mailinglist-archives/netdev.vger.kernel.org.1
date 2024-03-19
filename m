Return-Path: <netdev+bounces-80636-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 97F22880151
	for <lists+netdev@lfdr.de>; Tue, 19 Mar 2024 17:01:47 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 531E62869B0
	for <lists+netdev@lfdr.de>; Tue, 19 Mar 2024 16:01:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 553CE65BAA;
	Tue, 19 Mar 2024 16:01:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="jmWpX5tY"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3167D657AD
	for <netdev@vger.kernel.org>; Tue, 19 Mar 2024 16:01:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710864100; cv=none; b=M/2cwILrLi9e34uxJOP1zYgZI0hOuZ+cMnUbJIeWl6KqBrJ4uv3qJcin+yLTuaQvn7hgjoLZcf++XhqXz4hhb6WE/t2WmYmgGyoQQBqF6eJAtgAdadqDEM1JpBYmA6PCaWUmDKoVosQ1kJokjoZFc1Gj6Bt3Rh4D0DSEHDzzhnY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710864100; c=relaxed/simple;
	bh=ds9DRWtBxdMjHdK+2ASeYlpNgvl7efka+lXHRJw8ArQ=;
	h=Content-Type:MIME-Version:In-Reply-To:References:Subject:From:Cc:
	 To:Date:Message-ID; b=d1wLXfGGvOxhx647URI2kiIK5ZRb5mfX7xVsizJ3bJ5MKSWdux48Pj0svZ09ejqF8sIZrNLxXyttOc8oJawxqDTE0N0kVAWJB+1AuIxVOm8QeY+n4Wa2+pbC7fzRk07TUMeTvqiniRRTrSfGgGutv0Rfd2amjtVG3XI9c4Oxcbg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=jmWpX5tY; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 37E18C433C7;
	Tue, 19 Mar 2024 16:01:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1710864099;
	bh=ds9DRWtBxdMjHdK+2ASeYlpNgvl7efka+lXHRJw8ArQ=;
	h=In-Reply-To:References:Subject:From:Cc:To:Date:From;
	b=jmWpX5tYR4eyKl3PL/+6Qdk+Ukf6r34wNTIfnAv9z0sZf+tYra7tD9r+cpz/oTkNq
	 /zYkIxhy9n/FWplm0jX8E/l4k4aMYxoUmqon/sWT8etdhBF7GLLJpABQ09S8kJodfs
	 AyEP2vskMpnrkJT7WNrUjCxFS8KJu9SJtr+tZrNsRl5H7X82D8FNAfgKT3qeELsy78
	 ZDL8ybNc++3xUZfN+s3/JO9yOKkcGH0d0h8yyfx3hyVNLPgO33F2nSUAg9sWjhB0+q
	 yp4dZe8JF3xXYK5zlMAeZIcjWGP8B42fa5Dx6puRCkUu9ShXdCUoUz6FP6OtsgyoxS
	 QrSCo8/dBrkbQ==
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
In-Reply-To: <65f9954c70e28_11543d294f3@willemb.c.googlers.com.notmuch>
References: <20240319093140.499123-1-atenart@kernel.org> <20240319093140.499123-4-atenart@kernel.org> <65f9954c70e28_11543d294f3@willemb.c.googlers.com.notmuch>
Subject: Re: [PATCH net v2 3/4] udp: do not transition UDP fraglist to unnecessary checksum
From: Antoine Tenart <atenart@kernel.org>
Cc: steffen.klassert@secunet.com, willemdebruijn.kernel@gmail.com, netdev@vger.kernel.org
To: Willem de Bruijn <willemdebruijn.kernel@gmail.com>, davem@davemloft.net, edumazet@google.com, kuba@kernel.org, pabeni@redhat.com
Date: Tue, 19 Mar 2024 17:01:36 +0100
Message-ID: <171086409633.4835.11427072260403202761@kwain>

Quoting Willem de Bruijn (2024-03-19 14:38:20)
> Antoine Tenart wrote:
> > udp4/6_gro_complete transition fraglist packets to CHECKSUM_UNNECESSARY
> > and sets their checksum level based on if the packet is recognized to be
> > a tunneled one. However there is no safe way to detect a packet is a
> > tunneled one and in case such packet is GROed at the UDP level, setting
> > a wrong checksum level will lead to later errors. For example if those
> > packets are forwarded to the Tx path they could produce the following
> > dump:
> >=20
> >   gen01: hw csum failure
> >   skb len=3D3008 headroom=3D160 headlen=3D1376 tailroom=3D0
> >   mac=3D(106,14) net=3D(120,40) trans=3D160
> >   shinfo(txflags=3D0 nr_frags=3D0 gso(size=3D0 type=3D0 segs=3D0))
> >   csum(0xffff232e ip_summed=3D2 complete_sw=3D0 valid=3D0 level=3D0)
> >   hash(0x77e3d716 sw=3D1 l4=3D1) proto=3D0x86dd pkttype=3D0 iif=3D12
> >   ...
> >=20
> > Fixes: 9fd1ff5d2ac7 ("udp: Support UDP fraglist GRO/GSO.")
> > Signed-off-by: Antoine Tenart <atenart@kernel.org>
>=20
> The original patch converted to CHECKSUM_UNNECESSARY for a reason.
> The skb->csum of the main gso_skb is not valid?
>=20
> Should instead only the csum_level be adjusted, to always keep
> csum_level =3D=3D 0?

The above trace is an ICMPv6 packet being tunneled and GROed at the UDP
level, thus we have:
  UDP(CHECKSUM_PARTIAL)/Geneve/ICMPv6(was CHECKSUM_NONE)
csum_level would need to be 1 here; but we can't know that.

There is another issue (no kernel trace): if a packet has partial csum
and is being GROed that information is lost and the packet ends up with
an invalid csum.

Packets with CHECKSUM_UNNECESSARY should end up with the same info. My
impression is this checksum conversion is at best setting the same info
and otherwise is overriding valuable csum information.

Or would packets with CSUM_NONE being GROed would benefit from the
CHECKSUM_UNNECESSARY conversion?

For reference, original commit says:
"""
After validating the csum,  we mark ip_summed as
CHECKSUM_UNNECESSARY for fraglist GRO packets to
make sure that the csum is not touched.
"""

But I'm failing to see where that would happen and how the none to
unnecessary conversion would help. WDYT?

Thanks,
Antoine

