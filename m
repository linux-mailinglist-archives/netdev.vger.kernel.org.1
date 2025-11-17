Return-Path: <netdev+bounces-239014-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id B41A1C62495
	for <lists+netdev@lfdr.de>; Mon, 17 Nov 2025 04:58:49 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 802F44E864E
	for <lists+netdev@lfdr.de>; Mon, 17 Nov 2025 03:57:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2F3CD2F12C7;
	Mon, 17 Nov 2025 03:57:24 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from smtpbgbr1.qq.com (smtpbgbr1.qq.com [54.207.19.206])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 060512DC333
	for <netdev@vger.kernel.org>; Mon, 17 Nov 2025 03:57:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=54.207.19.206
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763351844; cv=none; b=D0DVJt3xsQzx5M/Cwkslp5gl8C1Xw1r6ygn27BRsHaxrIdgrprm7AXY5SgGhpmM0tbEiJEWp9VBhwUxo6cYMKR/RoE+7/b2+h8kgtFcA/ws4fla+fLmEI4pPEBOSVd5oTFGk6GTUYkGasJixkriuxz9ITm80QhugHagj6g6F5h8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763351844; c=relaxed/simple;
	bh=P+mN5TmYfrfGTUbwhnvF3q751daKiqLrKpsduT/Lk1I=;
	h=Content-Type:Mime-Version:Subject:From:In-Reply-To:Date:Cc:
	 Message-Id:References:To; b=fNxsNUpeJ0f5hd9MbLQxhbP5kt+AiANZN18hrIkzNW6fkD3VhvhXB0Mfmk7JSBWnY5ySnRAQ+hvQUsPpxG8J1O3Fz7Zei/8TXq4/frks2yF9Q9VUXQmtMdxrui0h1BzOwpRvYTg6Adh4CE3s/jJHwgVfiQ7KpQPc2kiloljnlsg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=bamaicloud.com; spf=none smtp.mailfrom=bamaicloud.com; arc=none smtp.client-ip=54.207.19.206
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=bamaicloud.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=bamaicloud.com
X-QQ-mid: zesmtpgz7t1763351828t02cb7208
X-QQ-Originating-IP: g7Y7KIGF/+48XBPFEQ8fo6mCKg+hWNS2zIu9ctGLPWM=
Received: from smtpclient.apple ( [111.204.182.99])
	by bizesmtp.qq.com (ESMTP) with 
	id ; Mon, 17 Nov 2025 11:57:06 +0800 (CST)
X-QQ-SSF: 0000000000000000000000000000000
X-QQ-GoodBg: 0
X-BIZMAIL-ID: 3054361057146573181
Content-Type: text/plain;
	charset=us-ascii
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
Mime-Version: 1.0 (Mac OS X Mail 16.0 \(3826.700.81\))
Subject: Re: [PATCH net-next v4] net: bonding: use atomic instead of
 rtnl_mutex, to make sure peer notify updated
From: Tonghao Zhang <tonghao@bamaicloud.com>
In-Reply-To: <dc26959a-ee51-4480-9a03-2fe4fc897f70@redhat.com>
Date: Mon, 17 Nov 2025 11:56:56 +0800
Cc: netdev@vger.kernel.org,
 Jay Vosburgh <jv@jvosburgh.net>,
 "David S. Miller" <davem@davemloft.net>,
 Eric Dumazet <edumazet@google.com>,
 Jakub Kicinski <kuba@kernel.org>,
 Simon Horman <horms@kernel.org>,
 Jonathan Corbet <corbet@lwn.net>,
 Andrew Lunn <andrew+netdev@lunn.ch>,
 Nikolay Aleksandrov <razor@blackwall.org>,
 Hangbin Liu <liuhangbin@gmail.com>
Content-Transfer-Encoding: quoted-printable
Message-Id: <7E50B628-5ABD-4263-BCCC-31227A1E02E8@bamaicloud.com>
References: <20251110091337.43517-1-tonghao@bamaicloud.com>
 <dc26959a-ee51-4480-9a03-2fe4fc897f70@redhat.com>
To: Paolo Abeni <pabeni@redhat.com>,
 Jay Vosburgh <jv@jvosburgh.net>
X-Mailer: Apple Mail (2.3826.700.81)
X-QQ-SENDSIZE: 520
Feedback-ID: zesmtpgz:bamaicloud.com:qybglogicsvrsz:qybglogicsvrsz3b-0
X-QQ-XMAILINFO: OFwcIyq3IdMxdF/Cjfp2e4Em9unyCQ7hxBx9+vYhU51OTZ4xW4fwsmI2
	rISyO9k2qHhBbuvuBy8XEa3tXhNwCOpZ7+mD7aV9SxMcYFd24cIYPVzwQrIF1Fg8RpJUqag
	7GQdAI6BUNLRBKLImAa+Joa4w3rEZkUr7jU6nSrXZD3mmRLK/jxBD+nuA3sLYpVjQNILgmK
	kUcEPRysguI4XVLURo/isuSAO7pv/XrX0kOIQhIPFUh1YLJ2wEXl0x0cPSkDVaiceBzyO3L
	uVH1ph9UmVkHCemtx3fgICljrEruMgpQiE/3soxKXzAIBESMVK5iCUkUpJiHHt5lavzPeeC
	9RvV55Sh0BrEhNNF/HkoQ1lICU/r1tyQUZfpOJ+5NAMei3BELr70Li57Jp7Mxp4ACNChIPA
	B5rhwuVChkvO0c7KmyqMQ8XD+KpF58lJ/iUrBGxCuhwOa6tq5ARVQdL4c5vnidv9tiGgaB5
	GdhGjogLsfY7oJF4NiOYXt1bzEB+tE/66aYU6BeS/msJSHJXgx3Dj11gdRWI5lPxe8/qCBB
	D6QBBh05cbYCWc4vRcjW/eLsiXM6QgIqtUXLjdEpKV9IfOsamztxKegxazsVJXzJDK9eJ7o
	CYTxgZ+CBAvwsqD9zp22m1GT5z9p+EUSS2YkKtqvTGD7orVofVMN18j4nEYrd0I0Ki4gn1S
	MKGIePqbXgDCh1fjlfylN0xAdgjO4JZEhYnUXoN9U9DsrRFhK5cUhDY3YaxWe2eIRfnJhAi
	JjbP78Lok6SVLkozxnKEZUljhCNJbvVUG9xnH38KrCAp3gev4RacDR6nW0jBBSeQV/CHEHV
	/VWtjXZ4mFUL7E0p4rJE3zKzzDKlmpnHxlb233uduAqkUggV8XoMFeKZ+VR69nvya3mbTRf
	fEaQVXe8e03lSePmoakpnowewRD+BvFNjWS1xuVQZP0Dee2Nrlfk662DAOkoo1UIhvRNdFX
	V1asWfTniSshN2fTjrQvAD204w5F0sQd88xIu3uAc1jrY086NeY4RorFUJUm7WTwHNrPcPF
	X+S0sw1w==
X-QQ-XMRINFO: OD9hHCdaPRBwq3WW+NvGbIU=
X-QQ-RECHKSPAM: 0



> On Nov 13, 2025, at 18:25, Paolo Abeni <pabeni@redhat.com> wrote:
>=20
> On 11/10/25 10:13 AM, Tonghao Zhang wrote:
>> @@ -814,4 +814,11 @@ static inline netdev_tx_t bond_tx_drop(struct =
net_device *dev, struct sk_buff *s
>> return NET_XMIT_DROP;
>> }
>>=20
>> +static inline void bond_peer_notify_reset(struct bonding *bond)
>> +{
>> + atomic_set(&bond->send_peer_notif,
>> + bond->params.num_peer_notif *
>> + max(1, bond->params.peer_notif_delay));
>=20
> The above reads params.* without any due lock; at very least it should
> include READ_ONCE() annotation here (and WRITE_ONCE on the param =
update
> side).
Yes, the rtnl lock is necessary.
>=20
> But it also mean it could observe inconsistent values for
> params.num_peer_notif and params.peer_notif_delay in case of =
concurrent
> update.
>=20
> The possible race between bond_mii_monitor() and
> bond_change_active_slave() concurrently updating
> send_peer_notif is still avoided by the rtnl lock, so the changelog is
> IMHO confusing WRT the actual code semantic.
In fact, replacing rtnl lock with atomic is not easy (bonding parameters =
updates and call_netdevice_notifiers still require rtnl lock), and =
atomic makes the update logic more complicated. I think the workqueue =
can solve the problem of updating send_peer_notif.

Hi Jay, can I repost the patch? =
https://patchwork.kernel.org/project/netdevbpf/patch/20251021052249.47250-=
1-tonghao@bamaicloud.com/
>=20
> /P
>=20
>=20


