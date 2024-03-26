Return-Path: <netdev+bounces-81955-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id DACEE88BE4B
	for <lists+netdev@lfdr.de>; Tue, 26 Mar 2024 10:49:08 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 92B152E201D
	for <lists+netdev@lfdr.de>; Tue, 26 Mar 2024 09:49:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B3D2474402;
	Tue, 26 Mar 2024 09:44:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="dGnpn09Z"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8FC047353D
	for <netdev@vger.kernel.org>; Tue, 26 Mar 2024 09:44:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711446299; cv=none; b=jAC3tSVyvYDqU7RzIT6M0DqVLo/X9TxjkLdFf+YRY7aI2hDpj96P4D7IVAsk/RCb2LR6I495BQ2VCMCIV03E5XHcw39xT27PVn9froC0iZEBdVU7AODMSjH1VO+TPA1vBQfcIg8XG7ak2p9/xfoWv4ApdOzk2LsxxlmumJtbCzs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711446299; c=relaxed/simple;
	bh=ElpxHNTEEiL0y5xIxB4Npr6IXo9cqNKlamD7+d1Qkss=;
	h=Content-Type:MIME-Version:In-Reply-To:References:Subject:From:Cc:
	 To:Date:Message-ID; b=VFPy8jamJSX/CqjI/lYhmaBeHaPlLq6uO9qIySAMZsUS7bfmklKAV49sBfLwr/dprs3sX0d0lq0TIkDt+/Ypnw+iDPDJebM52nqB/q/G+KTgTChbIZ5tprWeqQazZYEz56Kx7O0uRQEK6yzJgK4eGU/oT2eLJ+++ez3QTziNV6Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=dGnpn09Z; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id ABF32C433C7;
	Tue, 26 Mar 2024 09:44:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1711446299;
	bh=ElpxHNTEEiL0y5xIxB4Npr6IXo9cqNKlamD7+d1Qkss=;
	h=In-Reply-To:References:Subject:From:Cc:To:Date:From;
	b=dGnpn09Z6pq+pQzIfd1oZXjV0y3rGa9su5wzuPeWU6dGv2qHR1pe6rG0T+x+goZV6
	 w1cRi84SadCAKItX4Ea/plj+gFowb62iNkCW6GAlOgEBPCt0b083a5Jdz5XAS4Ar8g
	 P+CyEGuAytVxz01Va641Kg2QgGu5cpRC1MoZ0n6OfWGjTmhfq6NALly35tLN5DWq1E
	 AR2S2fugMFU5I3nQ6Xq3Bsa6UlgvcQRdWIlQi5qse7PVLtw34s1W+14t5QfbN8WVq/
	 pJZIcpaht+vd31eGsSbGWly3MXEF55Tmu8poEDY9S+nnM/14Nvmf0dmUhKYsDhq6t/
	 QtFaQ/BxFEVkA==
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
In-Reply-To: <6601c4f27529_11bc25294b@willemb.c.googlers.com.notmuch>
References: <20240322114624.160306-1-atenart@kernel.org> <20240322114624.160306-4-atenart@kernel.org> <65fdc00454e16_2bd0fb2948c@willemb.c.googlers.com.notmuch> <171136303579.5526.5377651702776757800@kwain> <6601c4f27529_11bc25294b@willemb.c.googlers.com.notmuch>
Subject: Re: [PATCH net v3 3/4] udp: do not transition UDP GRO fraglist partial checksums to unnecessary
From: Antoine Tenart <atenart@kernel.org>
Cc: steffen.klassert@secunet.com, willemdebruijn.kernel@gmail.com, netdev@vger.kernel.org
To: Willem de Bruijn <willemdebruijn.kernel@gmail.com>, davem@davemloft.net, edumazet@google.com, kuba@kernel.org, pabeni@redhat.com
Date: Tue, 26 Mar 2024 10:44:55 +0100
Message-ID: <171144629575.5526.17151762059541054429@kwain>

Quoting Willem de Bruijn (2024-03-25 19:39:46)
> Antoine Tenart wrote:
> > Quoting Willem de Bruijn (2024-03-22 18:29:40)
> > >=20
> > > Should fraglist UDP GRO and non-fraglist (udp_gro_complete_segment)
> > > have the same checksumming behavior?
> >=20
> > They can't as non-fraglist GRO packets can be aggregated, csum can't
> > just be converted there.
>=20
> I suppose this could be done. But it is just simpler to convert to
> CHECKSUM_UNNECESSARY.

Oh, do you mean using the non-fraglist behavior in fraglist?
udp_gro_complete_segment converts all packets to CHECKSUM_PARTIAL (as
packets could have been aggregated) but that's not required in fraglist.

To say it another way: my understanding is packets in the non-fraglist
case have to be converted to CHECKSUM_PARTIAL, while the fraglist case
can keep the checksum info as-is (and have the conversion to unnecessary
as an optimization when applicable).

> You mean that on segmentation, the segments are restored and thus
> skb->csum of each segment is again correct, right?

In the fraglist case, yes.

> I suppose this could be converted to CHECKSUM_UNNECESSARY if just
> for equivalence between the two UDP_GRO methods and simplicity.
>=20
> But also fine to leave as is.

I'm not sure I got your suggestion as I don't see how non-fraglist
packets could be converted to CHECKSUM_UNNECESSARY when being aggregated
(uh->len can change there).

This series is aiming at fixing known issues and unifying the behavior
would be net-next material IMO. I'll send a v4 for those fixes, but then
I'm happy to discuss the above suggestion and investigate; so let's
continue the discussion here in parallel.

> Can you at least summarize this in the commit message? Currently
> CHECKSUM_COMPLETE is not mentioned, but the behavior is not trivial.
> It may be helpful next time we again stumble on this code and do a
> git blame.

Sure, I'll try to improve the commit log.

Thanks!
Antoine

