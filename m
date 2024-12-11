Return-Path: <netdev+bounces-150918-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 1C3459EC17F
	for <lists+netdev@lfdr.de>; Wed, 11 Dec 2024 02:28:12 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 5F0D4284B9B
	for <lists+netdev@lfdr.de>; Wed, 11 Dec 2024 01:28:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9C31E3BBC9;
	Wed, 11 Dec 2024 01:28:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="jXhj8XuQ"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7779F179BD
	for <netdev@vger.kernel.org>; Wed, 11 Dec 2024 01:28:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733880484; cv=none; b=XZmHDor+wyTMc1rbC1tBrhS36rJFXJxUCndzpM3FsqBxVReXH9IgvIglqM7UZ/cnjKoz4S4bWakX/5bbuZtq9WWLPl9OIGtg3Vo9/g5cZazLjoobNQtw6RIDFPFiuQG8vfPr+HdkeGckl/rzU8VWNBhq7q/Wk662ik9BjzwdJjc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733880484; c=relaxed/simple;
	bh=Vl2EMTCaUtEnOeOF48k96OqejBMhlk+jdcj3u36qXDI=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=bswT5MPQnaoCGJrzdqWoP3I220pw0tLHzuCYF6S8NKKFA5/YVnyjtd8Ki0k6vHoucEtOeocofbgV0U1J5xfbO7Gqr1atKBHUEoP7/VqjnGAn/lzsimKL55ykTHfZ/JgouWNiOV52hEvtvDgHHiUrgofDBIVrnygvd/unS12oQB4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=jXhj8XuQ; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 807F0C4CED6;
	Wed, 11 Dec 2024 01:28:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1733880484;
	bh=Vl2EMTCaUtEnOeOF48k96OqejBMhlk+jdcj3u36qXDI=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=jXhj8XuQzZr+Uk45OA53prcuJRA/LJLLZ2IoAGmNGCVshJnGCbOrnlKV63rB2ZbRA
	 S+2dBUtCQ7zxPwTfggnSVjSQt0TW+rV6qp7b7XPowXVmZDBYENjT8AqCzTeuHmGThO
	 BivubXlWv4LKTcHy9Fl2sgtpQmVF6RA1DtqnwQUn56tSTYIDVghCMsqtnJwG2InfaT
	 etKtl4nuGsmICEqS1jAFc06fMgMrsyKA5JyNmNHov/IztG0JrTyPditnXaz8gZQd/q
	 9Ci4g+ECL8lov+SKpM08ex0A1hZq5akHBjQ31hzqSuqU5n41cQVrMhLDOe/jwgT12W
	 Wbr6c+nGIRi2Q==
Date: Tue, 10 Dec 2024 17:28:02 -0800
From: Jakub Kicinski <kuba@kernel.org>
To: Toke =?UTF-8?B?SMO4aWxhbmQtSsO4cmdlbnNlbg==?= <toke@redhat.com>
Cc: Dave Taht <dave.taht@gmail.com>, Jiri Pirko <jiri@resnulli.us>,
 netdev@vger.kernel.org, Jamal Hadi Salim <jhs@mojatatu.com>,
 cake@lists.bufferbloat.net, Eric Dumazet <edumazet@google.com>, Simon
 Horman <horms@kernel.org>, Cong Wang <xiyou.wangcong@gmail.com>, Paolo
 Abeni <pabeni@redhat.com>, "David S. Miller" <davem@davemloft.net>
Subject: Re: [Cake] [PATCH net-next] net_sched: sch_cake: Add drop reasons
Message-ID: <20241210172802.410c76a6@kernel.org>
In-Reply-To: <87a5d46i9c.fsf@toke.dk>
References: <20241209-cake-drop-reason-v1-1-19205f6d1f19@redhat.com>
	<20241209155157.6a817bc5@kernel.org>
	<CAA93jw4chUsQ40LQStvJBeOEENydbv58gOWz8y7fFPJkATa9tA@mail.gmail.com>
	<87a5d46i9c.fsf@toke.dk>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

On Tue, 10 Dec 2024 09:42:55 +0100 Toke H=C3=B8iland-J=C3=B8rgensen wrote:
> > While I initially agreed with making this generic, preserving the qdisc=
 from
> > where the drop came lets you safely inspect the cb block (timestamp, et=
c),
> > format of which varies by qdisc. You also get insight as to which
> > qdisc was dropping.
> >
> > Downside is we'll end up with SKB_DROP_REASON_XXX_OVERLIMIT for
> > each of the qdiscs. Etc. =20
>=20
> Yeah, I agree that a generic "dropped by AQM" reason will be too generic
> without knowing which qdisc dropped it.

Why does type of the qdisc matter if the qdisc was overlimit?

> I guess any calls directly to kfree_skb_reason() from the qdisc will
> provide the calling function, but for qdisc_drop_reason() the drop
> will be deferred to __dev_queue_xmit(), so no way of knowing where
> the drop came from, AFAICT?

Can you tell me why I'd need to inspect the skb->cb[] in cake if packet
is overlimit? Actually, none of the fields of the cb are initialized
when the packet is dropped for overlimit, AFAIU.

If someone is doing serious / advanced debug they mostly care about
access to the qdisc and can trivially check if its ops match the
expected symbol. (Speaking from experience, I've been debugging FQ
packet loss on Nov 23rd.)

If someone is just doing high level drop attribution having to list all
possible qdiscs under "qdisc discard" is purely pain.

Can we start with OVERLIMIT and CONGESTION as generic values and we can
specialize if anyone has a clear need?

