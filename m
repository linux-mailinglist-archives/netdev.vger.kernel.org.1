Return-Path: <netdev+bounces-146429-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 3ADFB9D35BD
	for <lists+netdev@lfdr.de>; Wed, 20 Nov 2024 09:44:22 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id BF71FB23F9B
	for <lists+netdev@lfdr.de>; Wed, 20 Nov 2024 08:44:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3026D175D3A;
	Wed, 20 Nov 2024 08:44:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=sipsolutions.net header.i=@sipsolutions.net header.b="F4l6ECJI"
X-Original-To: netdev@vger.kernel.org
Received: from sipsolutions.net (s3.sipsolutions.net [168.119.38.16])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 70CB160DCF;
	Wed, 20 Nov 2024 08:44:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=168.119.38.16
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732092258; cv=none; b=fxu1eZcfQq5vWyhtxLMn+TJwB0Zk9RHAW1hlYzdOWyroam1vVUppPn2lHWp56MI7eJ/W5EPO3ZXMmNgczsZbtmBazEXhDySjx52Orsa4qzB9hbIAksHQ8GLbri5JlHBG/wnTsv33MTpBWg01FNvu1Op7gRDeiqZL+WZxqZAypmw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732092258; c=relaxed/simple;
	bh=ZwL5nJU69RtxhYAVBEXOeYIdOuT/3F+tq9tKpVGlSkM=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=HWRI3OqyrWfXpkLLuzDuAChwfjh9kbzSzsy4RDDC9kTKEtxeiXbsDy5Rl/b7/bzUm6uuPrWiZdR+DGivYbsxFO4tKBtwx8skdSXPUDxIFVhcR+CSL+sNI9CVTFSXSQnATGpHynPe2oC+DfK+7XY1+dhXB+PTX2DYHLmhWnnV+D4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=sipsolutions.net; spf=pass smtp.mailfrom=sipsolutions.net; dkim=pass (2048-bit key) header.d=sipsolutions.net header.i=@sipsolutions.net header.b=F4l6ECJI; arc=none smtp.client-ip=168.119.38.16
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=sipsolutions.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=sipsolutions.net
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=sipsolutions.net; s=mail; h=MIME-Version:Content-Transfer-Encoding:
	Content-Type:References:In-Reply-To:Date:Cc:To:From:Subject:Message-ID:Sender
	:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-To:
	Resent-Cc:Resent-Message-ID; bh=pRL1Ekiwy+zEofAVAD4Ucj85UIwWt6jNTF2bWcmmVGg=;
	t=1732092256; x=1733301856; b=F4l6ECJIrZaGqVeCAG19vReX6nDC8C1pjkQ4dY7jFGeCNzZ
	hMVk25opdpUGkIQGpq/sKz1tDlW++CoeJbmS/d86iZhEwETh06dKa+EgS+2hvD0QR9gVcSdk5fs1p
	ZxAYL8J6fF6C8ifNn/g45HsXVdL78FiXC9eB4k6rp0vKCS4yjoJfMx2abQMqKCCSQq8uQvHVJZmXu
	hkW/02PZC+eiUkTeLRyAUzCiRQV2KkrUDl1l4ssD5qiLyLBvhcNLaH6y8XCzSkf4Ltczd94kI6Q3h
	H0iKXfzaTgFdr40h/3XJExFXmHQT9lBvdBQlMtLW4lztU3CTWLgxsnbB54FTXm4A==;
Received: by sipsolutions.net with esmtpsa (TLS1.3:ECDHE_X25519__RSA_PSS_RSAE_SHA256__AES_256_GCM:256)
	(Exim 4.98)
	(envelope-from <johannes@sipsolutions.net>)
	id 1tDgJg-00000009eET-1LPC;
	Wed, 20 Nov 2024 09:44:04 +0100
Message-ID: <7fb38122abcbcf28f7af8b9891d0b0852c01f088.camel@sipsolutions.net>
Subject: Re: [PATCH net v2 0/5] Make TCP-MD5-diag slightly less broken
From: Johannes Berg <johannes@sipsolutions.net>
To: Jakub Kicinski <kuba@kernel.org>, Dmitry Safonov via B4 Relay
	 <devnull+0x7f454c46.gmail.com@kernel.org>
Cc: 0x7f454c46@gmail.com, "David S. Miller" <davem@davemloft.net>, Eric
 Dumazet <edumazet@google.com>, Paolo Abeni <pabeni@redhat.com>, Simon
 Horman <horms@kernel.org>, David Ahern <dsahern@kernel.org>, Ivan Delalande
 <colona@arista.com>, Matthieu Baerts <matttbe@kernel.org>, Mat Martineau
 <martineau@kernel.org>, Geliang Tang <geliang@kernel.org>, John Fastabend
 <john.fastabend@gmail.com>, Davide Caratti <dcaratti@redhat.com>, Kuniyuki
 Iwashima <kuniyu@amazon.com>, netdev@vger.kernel.org,
 linux-kernel@vger.kernel.org,  mptcp@lists.linux.dev
Date: Wed, 20 Nov 2024 09:44:03 +0100
In-Reply-To: <20241115160816.09df40eb@kernel.org>
References: <20241113-tcp-md5-diag-prep-v2-0-00a2a7feb1fa@gmail.com>
	 <20241115160816.09df40eb@kernel.org>
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

(Sorry, late to the party)

On Fri, 2024-11-15 at 16:08 -0800, Jakub Kicinski wrote:
> On Wed, 13 Nov 2024 18:46:39 +0000 Dmitry Safonov via B4 Relay wrote:
> > 2. Inet-diag allocates netlink message for sockets in
> >    inet_diag_dump_one_icsk(), which uses a TCP-diag callback
> >    .idiag_get_aux_size(), that pre-calculates the needed space for
> >    TCP-diag related information. But as neither socket lock nor
> >    rcu_readlock() are held between allocation and the actual TCP
> >    info filling, the TCP-related space requirement may change before
> >    reaching tcp_diag_put_md5sig(). I.e., the number of TCP-MD5 keys on
> >    a socket. Thankfully, TCP-MD5-diag won't overwrite the skb, but will
> >    return EMSGSIZE, triggering WARN_ON() in inet_diag_dump_one_icsk().
>=20
> Would it be too ugly if we simply retried with a 32kB skb if the initial
> dump failed with EMSGSIZE?

We have min_dump_alloc, which a number of places are setting much higher
than the default, partially at least because there were similar issues,
e.g. in nl80211. See e.g. nl80211_dump_wiphy() doing it dynamically.

Kind of ugly? Sure! And we shouldn't use it now with newer userspace
that knows to request a more finely split dump. For older userspace it's
the only way though.

Also, we don't even give all the data to older userspace (it must
support split dumps to get information about the more modern features, 6
GHz channels, etc.), but I gather that's not an option here.

> Another option would be to automatically grow the skb. The size
> accounting is an endless source of bugs. We'd just need to scan
> the codebase to make sure there are no cases where someone does
>=20
> 	ptr =3D __nla_reserve();
> 	nla_put();
> 	*ptr =3D 0;
>=20
> Which may be too much of a project and source of bugs in itself.
>=20
> Or do both, retry as a fix, and auto-grow in net-next.

For auto-grow you'd also have to have information about the userspace
buffer, I think? It still has to fit there, might as well fail anyway if
that buffer is too small? I'm not sure we have that link back? But I'm
not really sure right now, just remember this as an additional wrinkle
from the above-mentioned nl80211 problem.

johannes

