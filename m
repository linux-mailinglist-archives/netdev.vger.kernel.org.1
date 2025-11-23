Return-Path: <netdev+bounces-241048-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id DC99EC7E167
	for <lists+netdev@lfdr.de>; Sun, 23 Nov 2025 14:30:47 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 902F53ABF5D
	for <lists+netdev@lfdr.de>; Sun, 23 Nov 2025 13:30:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1360F190477;
	Sun, 23 Nov 2025 13:30:44 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from smtpbgsg1.qq.com (smtpbgsg1.qq.com [54.254.200.92])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B1E8D72628
	for <netdev@vger.kernel.org>; Sun, 23 Nov 2025 13:30:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=54.254.200.92
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763904644; cv=none; b=PwZcIAM6DMbXDV2gywqkutF7KIjv4YAgCITYY0tLXNY1xuMYVYx60dQ8qLEX0V/tjGdAUwxD4/1pStHbRGmIF/hlYLkW+Kl8dDmqZhWDuzfaV6t9TOjc90wqH3r+1SVadYtu4oejPlHgjdi1kgqKOVXv/SQHVUphf7+2Fc2paT4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763904644; c=relaxed/simple;
	bh=t2X+sBqgcT6nd1g3JjPpxhAaqkMxjSu1z/LJBGzNP0M=;
	h=Content-Type:Mime-Version:Subject:From:In-Reply-To:Date:Cc:
	 Message-Id:References:To; b=hD3FL+FWe+9sD9qsrPmdCQ6MnYpKoACyPLYoPz/1UknbUOen21QSQX6DdPyKcpuDvh7GxQ2kzQWxl+wYtdO6JsvhWlLeJ9immvZmASmVPZbEpHW4xzoybWODk4dqKNoEr+fnZXW4tUHElyK4A0xvWtKqvwVXJoh2yyPjEaU66WI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=bamaicloud.com; spf=pass smtp.mailfrom=bamaicloud.com; arc=none smtp.client-ip=54.254.200.92
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=bamaicloud.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bamaicloud.com
X-QQ-mid: esmtpsz20t1763904632t7bc04ae6
X-QQ-Originating-IP: yMzwJojfjZL/kQaVLDG3aIN9XQQUOOEbVvqxQShzGOs=
Received: from smtpclient.apple ( [183.241.14.219])
	by bizesmtp.qq.com (ESMTP) with 
	id ; Sun, 23 Nov 2025 21:30:29 +0800 (CST)
X-QQ-SSF: 0000000000000000000000000000000
X-QQ-GoodBg: 0
X-BIZMAIL-ID: 2594309119891335526
Content-Type: text/plain;
	charset=us-ascii
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
Mime-Version: 1.0 (Mac OS X Mail 16.0 \(3826.700.81\))
Subject: Re: [PATCH net-next v2] net: bonding: use workqueue to make sure peer
 notify updated in lacp mode
From: Tonghao Zhang <tonghao@bamaicloud.com>
In-Reply-To: <0b9e0c0e-9684-495f-ba30-9fc77b7b33b5@redhat.com>
Date: Sun, 23 Nov 2025 21:30:19 +0800
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
Message-Id: <AE75D960-0AFD-4F18-9B1F-1F693338C056@bamaicloud.com>
References: <20251118090305.35558-1-tonghao@bamaicloud.com>
 <9eb3b5bd-5866-49fb-b4fc-5491cb3d426c@redhat.com>
 <0b9e0c0e-9684-495f-ba30-9fc77b7b33b5@redhat.com>
To: Paolo Abeni <pabeni@redhat.com>
X-Mailer: Apple Mail (2.3826.700.81)
X-QQ-SENDSIZE: 520
Feedback-ID: esmtpsz:bamaicloud.com:qybglogicsvrsz:qybglogicsvrsz3b-0
X-QQ-XMAILINFO: NUTz4BkILuKLnp6KaM7rVWevn4eg8DlJZU9zN0XAkpiRjt6IKz7FEgVs
	+OKe57XnxqVjbxvqiOXKz0WJsk6djs9iVdADQthXoirwn2AS9hG5W7eXMGG9+Cg0pLRE889
	lDarEdu+JLAGyajQjWPxYDNIsPfo6k7YhRWvMYVq2x0ya+u4ZmkEeHNO2l7L9QITFGPrWnq
	vr4hnJQ4q0pR81TSSgE08OEXg5bsCUOG16YXJEHH5FQTa2kmAjpa/Lua4iqh1FLhciY4/Wc
	uD86ULqdnU4oTrOoddwn9CUNquzwrqi/S37QSnw9RypS6FXsOepsPza8cZfvCF6pozqk0f8
	MkZXUuELYbdl/11m3Dabo90JAimzo40mn/h4NqncG7MYHy4eZ8sh0gS9cVy7tEavPeft5kA
	pqFt7pV/EqIkjZFIJr+gMSboWhSH/LCUJHsL5DCnpxrfsoYF+dMToLn8Q0d43kJiQK+t9b/
	r7k3anSHRt8e2LDMbbzyLCsCtwJl0IvKh2T0uI+Ooki3ytyy0lJyfcTOL/p6ZZK3ygpy2+Q
	d1l22nfram/sak5w/1v/tDBwfFl6XwqQ+1RciGb4Uhd6sjgCD3XHP5EQRInZKwfAIKYru7C
	0Lx3CxPNV/IwdasdLym75EskI/z9PbkMqeWd+4SQc7ZMruhdfn7sfJOJ01YxgAqEWge9cK7
	7wf+/vWsTBWfI+G9SJaSyjQKs9DDaU83QNO8EZ2KACAzYU3f9uwt149dmQoNVh4bUpSV4pG
	luggZbnAILq3uQmMp4BtIWrU15YYO3Laob5CqBLQOo/aFbKvzmRe1WiMgYNZoPCivicHFEF
	rnTGSJSr5oz9czq6Wq4LbyJVWvb+eB4A/949DLo6/6dysS87Ggw2wPmz6Z7bbmbXbK7ybU/
	IqbHX0qtcFVw4kcehTZzLyk7bozsVzl7LA9C273BlxVA6oiQA034Cs04QKQWtixD0TRrerR
	io19rT9xbDpz+qhdH/J9HHzsC5RFfV3iI5sgnbfumxjp0v652Wz5uMQc/3It8PzlGEQTUi3
	vpO116oA==
X-QQ-XMRINFO: NS+P29fieYNw95Bth2bWPxk=
X-QQ-RECHKSPAM: 0



> On Nov 20, 2025, at 20:42, Paolo Abeni <pabeni@redhat.com> wrote:
>=20
>=20
> On 11/20/25 1:33 PM, Paolo Abeni wrote:
>> On 11/18/25 10:03 AM, Tonghao Zhang wrote:
>>> +static void bond_peer_notify_handler(struct work_struct *work)
>>> +{
>>> + struct bonding *bond =3D container_of(work, struct bonding,
>>> +     peer_notify_work.work);
>>> +
>>> + if (!rtnl_trylock())
>>> + goto rearm;
>>=20
>> Why trylock() here? This is process context, you could just call
>>=20
>> rtnl_lock();
>>=20
>> and no re-schedule.
>=20
> Whoops, sorry, I lacked the context. ndo_close() will try to flush the
> work under the rtnl lock; the workqueue must not block on such lock to
> avoid deadlock.
>=20
> Still a comment above would be nice/useful for future memory.
Yes, I will add a comment in bond_work_init_all(), so if others add new =
workqueue, they should see the reminder.
>=20
> /P



