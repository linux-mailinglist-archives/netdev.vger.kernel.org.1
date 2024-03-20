Return-Path: <netdev+bounces-80845-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id A7911881430
	for <lists+netdev@lfdr.de>; Wed, 20 Mar 2024 16:08:57 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 5B8CE1F218F1
	for <lists+netdev@lfdr.de>; Wed, 20 Mar 2024 15:08:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 567174AEFE;
	Wed, 20 Mar 2024 15:08:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="MZsKaDnL"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 32356848E
	for <netdev@vger.kernel.org>; Wed, 20 Mar 2024 15:08:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710947333; cv=none; b=A06ixivnl2Lglnai2s45bUONsIDO+b58jPyjgPOOMXKwdIdi6DxEYyZtf83aSjYYq6rMR25gz+WsvchgPj75seyWIGj6XFwH+x2uSTJ0mrcqtsU6mJoBSqe2XMU5SC/KyxC4f4sfD3HY0N2WNRzP+/f4e/9/vNe/7j3AO1VjyBQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710947333; c=relaxed/simple;
	bh=Uw+gOmimtWuv2d7PJnn+iIToqf+2wYCbqCbAl14Xi4Y=;
	h=Content-Type:MIME-Version:In-Reply-To:References:Subject:From:Cc:
	 To:Date:Message-ID; b=cQoisu1iSnfuEJ+aSbFq0LRLeR0FbIwAH7H2gke5d3GaN9oLOZ5xKsPGWTXOTnHxAnqWObDUkP6ejLD3VoDeIs2Ca+Ea0UbEnbHxzDshN3P55fNz7QyHT/UDH0k68WlKn3TUCIEvEjj2lfHUGw2ht7ZQpJqMCWuMGY4TfyXG+ec=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=MZsKaDnL; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 69129C433C7;
	Wed, 20 Mar 2024 15:08:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1710947332;
	bh=Uw+gOmimtWuv2d7PJnn+iIToqf+2wYCbqCbAl14Xi4Y=;
	h=In-Reply-To:References:Subject:From:Cc:To:Date:From;
	b=MZsKaDnL9XvbC5d/32PgoCjETuYdePUM78JLkDniJKOcN9hpy5FFul6kqvKPeFlhC
	 kqCY6zRylgZYDC2ryFliGP7ILq0S8p2CSg0/gFEyYKSeCKvxFwISvjBjOA04c8izM0
	 ySm85ZODbo6A9RmsxjzWoZLVIE5rolMzfaF/6Heymzf8HgoSepM2fXl7FPCf+7+R0g
	 m8rCwzUGGCe2UYgrmqUtggtkpKbcdGwUOsUlf69JX8dGpm08gCLX6VTzlEDUT50RCD
	 FZZzWthQmzOTsK39sQlZxe9jjrIIfwH5+/+ppGavt7sPm0UokjqGoAEXjexI0VBjJz
	 +wkl3dJE69h7A==
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
In-Reply-To: <65fade00e4c24_1c19b8294cf@willemb.c.googlers.com.notmuch>
References: <20240319093140.499123-1-atenart@kernel.org> <20240319093140.499123-4-atenart@kernel.org> <65f9954c70e28_11543d294f3@willemb.c.googlers.com.notmuch> <171086409633.4835.11427072260403202761@kwain> <65fade00e4c24_1c19b8294cf@willemb.c.googlers.com.notmuch>
Subject: Re: [PATCH net v2 3/4] udp: do not transition UDP fraglist to unnecessary checksum
From: Antoine Tenart <atenart@kernel.org>
Cc: steffen.klassert@secunet.com, willemdebruijn.kernel@gmail.com, netdev@vger.kernel.org
To: Willem de Bruijn <willemdebruijn.kernel@gmail.com>, davem@davemloft.net, edumazet@google.com, kuba@kernel.org, pabeni@redhat.com
Date: Wed, 20 Mar 2024 16:08:49 +0100
Message-ID: <171094732998.5492.6523626232845873652@kwain>

Quoting Willem de Bruijn (2024-03-20 14:00:48)
> Antoine Tenart wrote:
> > Quoting Willem de Bruijn (2024-03-19 14:38:20)
> > >=20
> > > The original patch converted to CHECKSUM_UNNECESSARY for a reason.
> > > The skb->csum of the main gso_skb is not valid?
> > >=20
> > > Should instead only the csum_level be adjusted, to always keep
> > > csum_level =3D=3D 0?
> >=20
> > The above trace is an ICMPv6 packet being tunneled and GROed at the UDP
> > level, thus we have:
> >   UDP(CHECKSUM_PARTIAL)/Geneve/ICMPv6(was CHECKSUM_NONE)
> > csum_level would need to be 1 here; but we can't know that.
>=20
> Is this a packet looped internally? Else it is not CHECKSUM_PARTIAL.

I'm not sure to follow, CHECKSUM_NONE packets going in a tunnel will be
encapsulated and the outer UDP header will be CHECKSUM_PARTIAL. The
packet can be looped internally or going to a remote host.

> > There is another issue (no kernel trace): if a packet has partial csum
> > and is being GROed that information is lost and the packet ends up with
> > an invalid csum.
>=20
> CHECKSUM_PARTIAL should be converted to CHECKSUM_UNNECESSARY for this
> reason. CHECKSUM_PARTIAL implies the header is prepared with pseudo
> header checksum. Similarly CHECKSUM_COMPLETE implies skb csum is valid.
> CHECKSUM_UNNECESSARY has neither expectations.

But not if the packet is sent to a remote host. Otherwise an inner
partial csum is never fixed by the stack/NIC before going out.

> > Packets with CHECKSUM_UNNECESSARY should end up with the same info. My
> > impression is this checksum conversion is at best setting the same info
> > and otherwise is overriding valuable csum information.
> >=20
> > Or would packets with CSUM_NONE being GROed would benefit from the
> > CHECKSUM_UNNECESSARY conversion?
>=20
> Definitely. If the packet has CHECKSUM_NONE and GRO checks its
> validity in software, converting it to CHECKSUM_UNNECESSARY avoids
> potential additional checks at later stages in the packet path.

Makes sense. The current code really looks like
__skb_incr_checksum_unnecessary, w/o the CHECKSUM_NONE check to only
convert those packets.

Thanks!
Antoine

