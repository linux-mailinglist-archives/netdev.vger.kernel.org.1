Return-Path: <netdev+bounces-80319-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C55B887E56A
	for <lists+netdev@lfdr.de>; Mon, 18 Mar 2024 10:09:48 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 806402829B7
	for <lists+netdev@lfdr.de>; Mon, 18 Mar 2024 09:09:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7A62328DB3;
	Mon, 18 Mar 2024 09:09:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="s4hQSg5N"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 55E9D2C180
	for <netdev@vger.kernel.org>; Mon, 18 Mar 2024 09:09:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710752984; cv=none; b=Q2JGZ+hlIDJtwd4JGxX4p1u1l+5E/hvRy9jKGgOyEsWKGvxXQSIBet1+IfmM00V77auke2krY/UYOAH85SNub3MHuj6J0wcFMnOyTpKuDmlbjSJbCmM6xVXmCLtA9Gci6Xnj+nwve+Q7k9gW7z3fdKus16YINX9wD33Wrk4DqKI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710752984; c=relaxed/simple;
	bh=wj85Fvt4sCIpn1V2tKZ/t5jzyp/tPGuTzmF/d6jZEkA=;
	h=Content-Type:MIME-Version:In-Reply-To:References:Subject:From:Cc:
	 To:Date:Message-ID; b=mLskBJPcz0apH1EtUgFVcOAxk8AfFQNE+I3dyMniR3Cb1L8av1ZFA1PBdAUeVQxwhaTPdersU2GeDkOQU9rKU5gOekkqzvP+t3ZZEbxUmQRfedLkqsQGeVLT+Xrj8r7Sc+ST78BEhe/XmFRCWQjZ2/xP6h+kO9+kn7BQluylBqs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=s4hQSg5N; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 82CE7C433F1;
	Mon, 18 Mar 2024 09:09:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1710752984;
	bh=wj85Fvt4sCIpn1V2tKZ/t5jzyp/tPGuTzmF/d6jZEkA=;
	h=In-Reply-To:References:Subject:From:Cc:To:Date:From;
	b=s4hQSg5Nd9QV7ZhxYm9ry0nqlY8aBOVlCVGjCt72nFBdIKfbM3BaiRQDvC+3WTKJb
	 Lz5o5otGBlsKKrW7qIcd8aFhQ8a/5JGIX3JqBqpOthofC0Uf0OsVVAE8hPLwGup/Yx
	 +1y+GEwxIQ1i3+upOsiQQbdZ5DH67dOWTKWXSK5OYVOGvNlmyGTIpwrFf39QsfUULi
	 t8GgkZuBI0X+uLUMMqknwQ0d8aWFVs3QbBUXZaw5T188n51INO1HcCzcAkYfWdP/Pe
	 mLq3fZUK8Ixuoe+PZDBItarSlSZgz6XhMBxh3E028Em9jAhHb2K2wdEltpLqjC8eYG
	 Shs87FiQcFr2Q==
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
In-Reply-To: <65f5b9d952450_6ef3e294f1@willemb.c.googlers.com.notmuch>
References: <20240315151722.119628-1-atenart@kernel.org> <20240315151722.119628-3-atenart@kernel.org> <65f5b9d952450_6ef3e294f1@willemb.c.googlers.com.notmuch>
Subject: Re: [PATCH net 2/4] gro: fix ownership transfer
From: Antoine Tenart <atenart@kernel.org>
Cc: steffen.klassert@secunet.com, netdev@vger.kernel.org
To: Willem de Bruijn <willemdebruijn.kernel@gmail.com>, davem@davemloft.net, edumazet@google.com, kuba@kernel.org, pabeni@redhat.com
Date: Mon, 18 Mar 2024 10:09:40 +0100
Message-ID: <171075298053.25781.9212858495086366536@kwain>

Quoting Willem de Bruijn (2024-03-16 16:25:13)
> Antoine Tenart wrote:
> > Issue was found while using rx-gro-list. If fragmented packets are GROed
>=20
> Only if you need to respin: "If packets are GROed with fraglist"
>=20
> A bit pedantic, but this is subtle stuff. These are not IP fragmented
> packets. Or worse, UDP fragmentation offload.

Right, that was only describing which kind of packets were GROed in my
test. Looks like that's confusing, I'll remove it.

> > in skb_gro_receive_list, they might be segmented later on and continue
> > their journey in the stack. In skb_segment_list those skbs can be reused
> > as-is. This is an issue as their destructor was removed in
> > skb_gro_receive_list but not the reference to their socket, and then
> > they can't be orphaned. Fix this by also removing the reference to the
> > socket.
> >=20
> > For example this could be observed,
> >=20
> >   kernel BUG at include/linux/skbuff.h:3131!  (skb_orphan)
> >   RIP: 0010:ip6_rcv_core+0x11bc/0x19a0
> >   Call Trace:
> >    ipv6_list_rcv+0x250/0x3f0
> >    __netif_receive_skb_list_core+0x49d/0x8f0
> >    netif_receive_skb_list_internal+0x634/0xd40
> >    napi_complete_done+0x1d2/0x7d0
> >    gro_cell_poll+0x118/0x1f0
> >=20
> > A similar construction is found in skb_gro_receive, apply the same
> > change there.
> >=20
> > Fixes: 5e10da5385d2 ("skbuff: allow 'slow_gro' for skb carring sock ref=
erence")
> > Signed-off-by: Antoine Tenart <atenart@kernel.org>
>=20
> Looks fine to me on the understanding that the only GSO packets that
> arrive with skb->sk are are result of the referenced commit, and thus
> had sock_wfree as destructor.

The root cause of the issue is a disparity between skb->destructor and
skb->sk; either skb with skb->{destructor,sk} could arrive there and
that was not an issue, or they could not. In both cases the above commit
is introducing that behavior.

Thanks!
Antoine

