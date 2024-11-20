Return-Path: <netdev+bounces-146547-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 51BCA9D4299
	for <lists+netdev@lfdr.de>; Wed, 20 Nov 2024 20:36:36 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id F19701F21C77
	for <lists+netdev@lfdr.de>; Wed, 20 Nov 2024 19:36:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B9492158A33;
	Wed, 20 Nov 2024 19:36:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=sipsolutions.net header.i=@sipsolutions.net header.b="BChJXpUX"
X-Original-To: netdev@vger.kernel.org
Received: from sipsolutions.net (s3.sipsolutions.net [168.119.38.16])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F0FBE13D62B;
	Wed, 20 Nov 2024 19:36:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=168.119.38.16
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732131389; cv=none; b=XUvbjqmw2QavB9opY76JntuBHCnsnQRL6IgkLu6urvjD+R4NJQSOTckRFf07jH6XQiS5XThXPCV2OuRG6SS6YNE6rm40+pzbJK1c+/AVqWYMnyBOYCsK60H/uDm/pFuIAegoryJsMa6ApflkWgUNOVK8UQWx+veDbVXDO+3PqgE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732131389; c=relaxed/simple;
	bh=aRpQcbkVqiBnz8nY1bX54yPQRo/vdzAIJPxGVAmUThc=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=XpbK3YADyuk5iETNmyqIBgrNrU5FW3NrLFrCg9FSWmMt8i7VT7XHxDfHGqF0F/LEcsrE0bh5w6GzxivZsC+1HWYdNdSrtv2SGVMXhWygwRS7ks2lyWRYhA0tF1BF+u4m9E3xN1kauTXpaapgxV8t2Qduo3nvBwv97p3ryG99A8c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=sipsolutions.net; spf=pass smtp.mailfrom=sipsolutions.net; dkim=pass (2048-bit key) header.d=sipsolutions.net header.i=@sipsolutions.net header.b=BChJXpUX; arc=none smtp.client-ip=168.119.38.16
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=sipsolutions.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=sipsolutions.net
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=sipsolutions.net; s=mail; h=MIME-Version:Content-Transfer-Encoding:
	Content-Type:References:In-Reply-To:Date:Cc:To:From:Subject:Message-ID:Sender
	:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-To:
	Resent-Cc:Resent-Message-ID; bh=ST+APZ99Qe4bKjcu9QKrBi7ZzZBX6OR6yLTKY5NyDCw=;
	t=1732131388; x=1733340988; b=BChJXpUXVwjTSlXYwNEcLR2Vh4A0CPvwgfa6HaNBh/CQiRs
	GNeeCRK7JZW0y5bPzl4C3sf5Af6ReCvqftABs99Job9Dza5R5s29HLnRzdLBbtvccXw/RMOgmPQXY
	ujojTwFMhY1ottqqrExLha1Ti+qGBQopz9eAhqIZ6qw8kxQQIMxLMgXmajzlV51Qq449lRVdYbndU
	iGweGKwhOhtk8TS9EEJ4PbWZc9R4+bFxUOP/tzRMf8VwBRHEkmMMcGWBmFkxvuYWI8PnLowYSvlOx
	cegRvNfoREdoBYbC17Fg2PUdE7eZ5ST/DHIywLCZ9weOqfMNhgYWBGh8gifrrg1w==;
Received: by sipsolutions.net with esmtpsa (TLS1.3:ECDHE_X25519__RSA_PSS_RSAE_SHA256__AES_256_GCM:256)
	(Exim 4.98)
	(envelope-from <johannes@sipsolutions.net>)
	id 1tDqUu-00000009sE7-3vf3;
	Wed, 20 Nov 2024 20:36:21 +0100
Message-ID: <cf62d3121e50919dafc94d1b89f194799bc4fbcd.camel@sipsolutions.net>
Subject: Re: [PATCH net v2 0/5] Make TCP-MD5-diag slightly less broken
From: Johannes Berg <johannes@sipsolutions.net>
To: Dmitry Safonov <0x7f454c46@gmail.com>
Cc: Jakub Kicinski <kuba@kernel.org>, Dmitry Safonov via B4 Relay
 <devnull+0x7f454c46.gmail.com@kernel.org>, "David S. Miller"
 <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, Paolo Abeni
 <pabeni@redhat.com>, Simon Horman <horms@kernel.org>, David Ahern
 <dsahern@kernel.org>, Ivan Delalande <colona@arista.com>, Matthieu Baerts
 <matttbe@kernel.org>, Mat Martineau <martineau@kernel.org>, Geliang Tang
 <geliang@kernel.org>, John Fastabend <john.fastabend@gmail.com>, Davide
 Caratti <dcaratti@redhat.com>, Kuniyuki Iwashima <kuniyu@amazon.com>, 
 netdev@vger.kernel.org, linux-kernel@vger.kernel.org, mptcp@lists.linux.dev
Date: Wed, 20 Nov 2024 20:36:19 +0100
In-Reply-To: <CAJwJo6ZTT28XZ1HFhC77KrPeFmwVWDkFzYsg7YU1MD0PESAWrw@mail.gmail.com>
References: <20241113-tcp-md5-diag-prep-v2-0-00a2a7feb1fa@gmail.com>
	 <20241115160816.09df40eb@kernel.org>
	 <7fb38122abcbcf28f7af8b9891d0b0852c01f088.camel@sipsolutions.net>
	 <CAJwJo6ZTT28XZ1HFhC77KrPeFmwVWDkFzYsg7YU1MD0PESAWrw@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.52.4 (3.52.4-2.fc40) 
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-malware-bazaar: not-scanned

On Wed, 2024-11-20 at 16:13 +0000, Dmitry Safonov wrote:
> > We have min_dump_alloc, which a number of places are setting much highe=
r
> > than the default, partially at least because there were similar issues,
> > e.g. in nl80211. See e.g. nl80211_dump_wiphy() doing it dynamically.
>=20
> Yeah, your example seems alike what netlink_dump() does with
> min_dump_alloc and max_recvmsg_len. You have there
> .doit =3D nl80211_get_wiphy,
> .dumpit =3D nl80211_dump_wiphy,
>=20
> So at this initial patch set, I'm trying to fix
> inet_diag_handler::dump_one() callback, which is to my understanding
> same as .doit() for generic netlink [should we just rename struct
> inet_diag_handler callbacks to match the generics?].

dump_one() doesn't sound like doit(), it sounds more like dump one
object? In generic netlink dumpit has to handle that internally, and
doit() is for commands, without F_DUMP.

But also generic netlink is just one netlink family, so I wouldn't
really rename anything to match it anyway.

>  See
> inet_diag_handler_cmd() and NLM_F_DUMP in
> Documentation/userspace-api/netlink/intro.rst
> For TCP-MD5-diag even the single message reply may have a variable
> number of keys on a socket's dump.

Right.

> For multi-messages dump, my plan is
> to use netlink_callback::ctx[] and add an iterator type that will
> allow to stop on N-th key between recvmsg() calls.

Right, so userspace has to understand that format. In nl80211 we've made
an input flag attribute (inputs are often unused with dump, but are
present) to request that split format.

> > Kind of ugly? Sure! And we shouldn't use it now with newer userspace
> > that knows to request a more finely split dump. For older userspace it'=
s
> > the only way though.
>=20
> Heh, the comment in nl80211_dump_wiphy() on sending an empty message
> and retrying is ouch!

Yeah ... Luckily we basically converted all userspace to request split
dumps, so we shouldn't ever get there now.

> > For auto-grow you'd also have to have information about the userspace
> > buffer, I think? It still has to fit there, might as well fail anyway i=
f
> > that buffer is too small? I'm not sure we have that link back? But I'm
> > not really sure right now, just remember this as an additional wrinkle
> > from the above-mentioned nl80211 problem.
>=20
> Yeah, netlink_recvmsg() attempts to track what the userspace is asking:
>=20
> :        /* Record the max length of recvmsg() calls for future allocatio=
ns */
> :        max_recvmsg_len =3D max(READ_ONCE(nlk->max_recvmsg_len), len);
> :        max_recvmsg_len =3D min_t(size_t, max_recvmsg_len,
> :                                SKB_WITH_OVERHEAD(32768));
> :        WRITE_ONCE(nlk->max_recvmsg_len, max_recvmsg_len);

Right, OK, so that's sorted then :)

johannes

