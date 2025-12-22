Return-Path: <netdev+bounces-245730-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 3E484CD6570
	for <lists+netdev@lfdr.de>; Mon, 22 Dec 2025 15:16:06 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id D7422300E002
	for <lists+netdev@lfdr.de>; Mon, 22 Dec 2025 14:16:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 692F62E8B67;
	Mon, 22 Dec 2025 14:16:03 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from smtpbg154.qq.com (smtpbg154.qq.com [15.184.224.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AC787285418
	for <netdev@vger.kernel.org>; Mon, 22 Dec 2025 14:15:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=15.184.224.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1766412963; cv=none; b=V0MhRPVvzLXHk1lb5lUjxbOk/RuKVe24EJVn+TAxlm65dTKVbjHvhdNUdsa1Kr0KUVh3pMDdf2gpxmhzZcx3t1Qhy+O/bWU7aYJlmNC51cBrEbcUDdn4KGYGQ3NJlo18JmmWxAPB87gKeI3FnVtL+dNZWZLXLkMYyOUhQoH1jZM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1766412963; c=relaxed/simple;
	bh=9k+R7YKGCgKEY/Gtt6rpOZNNzCBH2c7BoZ9pqcKokn0=;
	h=Content-Type:Mime-Version:Subject:From:In-Reply-To:Date:Cc:
	 Message-Id:References:To; b=Zg1tWDESrN9wLqryi2kz0y72Ioj6zsTBczG+yVoD9r19+wGbnhvLFaPd0E3bg7538kK9/Bl5ij/GWuSKOocJU5CRyNWaO7yYSuXvGsLuK8d61YM18TOxiIRcmmHhCrutt2fjOWgmPzkeOe2zcUYn8zqeqCKlSew7BF0vWgcNs4k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=bamaicloud.com; spf=none smtp.mailfrom=bamaicloud.com; arc=none smtp.client-ip=15.184.224.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=bamaicloud.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=bamaicloud.com
X-QQ-mid: zesmtpsz4t1766412920tfc430557
X-QQ-Originating-IP: dtNw4MrM7dgoAOuUbsL9wGq3CyzKi0gqj/d+5ozV7SE=
Received: from smtpclient.apple ( [183.241.15.10])
	by bizesmtp.qq.com (ESMTP) with 
	id ; Mon, 22 Dec 2025 22:15:18 +0800 (CST)
X-QQ-SSF: 0000000000000000000000000000000
X-QQ-GoodBg: 0
X-BIZMAIL-ID: 7052341305622169792
Content-Type: text/plain;
	charset=utf-8
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
Mime-Version: 1.0 (Mac OS X Mail 16.0 \(3826.700.81\))
Subject: Re: [PATCH net-next v3 3/4] net: bonding: skip the 2nd trylock when
 first one fail
From: Tonghao Zhang <tonghao@bamaicloud.com>
In-Reply-To: <aS1FPdC98q6wxviG@fedora>
Date: Mon, 22 Dec 2025 22:15:07 +0800
Cc: netdev@vger.kernel.org,
 Jay Vosburgh <jv@jvosburgh.net>,
 "David S. Miller" <davem@davemloft.net>,
 Eric Dumazet <edumazet@google.com>,
 Jakub Kicinski <kuba@kernel.org>,
 Paolo Abeni <pabeni@redhat.com>,
 Simon Horman <horms@kernel.org>,
 Jonathan Corbet <corbet@lwn.net>,
 Andrew Lunn <andrew+netdev@lunn.ch>,
 Nikolay Aleksandrov <razor@blackwall.org>,
 Jason Xing <kerneljasonxing@gmail.com>
Content-Transfer-Encoding: quoted-printable
Message-Id: <10FF7526-38C4-4776-BA00-7ECF6E7E143D@bamaicloud.com>
References: <20251130074846.36787-1-tonghao@bamaicloud.com>
 <20251130074846.36787-4-tonghao@bamaicloud.com> <aS1FPdC98q6wxviG@fedora>
To: Hangbin Liu <liuhangbin@gmail.com>
X-Mailer: Apple Mail (2.3826.700.81)
X-QQ-SENDSIZE: 520
Feedback-ID: zesmtpsz:bamaicloud.com:qybglogicsvrsz:qybglogicsvrsz3b-0
X-QQ-XMAILINFO: NqN/wpVFVRYX9jBeRW+2upmdmdl1anOoRDrWBtAr8eumZsc44uCQAvwb
	i2/wwgT76StUzgi9s65+LKezQxSsozpSManUXHSNbBDY1u8wc4Oq0fgV6RGB8VfO4+sngKZ
	zT7eYQxlBjxRca9xGK8n4FhttOZk65Iet0YqP3yvBZeUSPBGvPkBJ29VqfJeaOhT2VSBdOS
	ALcT2qoZQmNzTkgrz28s/hrbqyd5pk11etjF4PaZ6YOPxhCaerFF+cnzoBJdkdTAcEzLwcq
	/79eNgPLyMqgTA0Hj60rioC2CncYLLo9uO98AdKIDP+7yv30GoM/GCH3i/lO6Xh5psPYoj+
	xsLbtUwA+QRQ4uxXwYw/Qt3HNWnT4eGS2KVzpJj8wrtoA0xFdvL7RqS8uVoV2fLkZ7ZrGZi
	5Qw93Sr91+EuNHxs8N1SN+gy4fSWdM/duNuuNugy0aFaMTBF5WH+345yGBiWyuH2Ohy6dc0
	9t/ZkV4gGAOCx5flwrOQwLJtz1zfif6kjploTtXKm9t7oYirJYckmYvG+MpEV4LRK9PokD7
	4zOqeoNLmeqcjYMOaYOib8v/kpQNlU3NJbYs8ltCio7zQQtkXLdC516pyXuALQf/YQntN6L
	Y6XqWHvvT+UldB5eW4XNN2XaIRLq2AWR2ZxRIfk2lyi70DE9vZi0swxOgXqGRGtwubyFcD3
	apsM1fhohQRDj8UfPIpTN1gId6RcNUsmkJTU+9IndCsWLXzMZGORdeYhhT16d4Xutc5YT3t
	vBGFnMmD/QOgVO73VLvzc9HHy6ZkbKr8BNcbyboR7JynxFFnjmXJt/T6zC6HBjXful5J26i
	g0uZKgTeUaRsvbq6De62Itk3hE9mO7OCqXJby8mnsKrhLlx41OBEy3wQN6CRDXxyRzQqnj5
	rG6XqvUrJYkXERY8YtVWCrPjdmE4pEBvTYj2NvfgQ0wPwq8obRu/2KZhk/2YeQtAEF6B+qi
	XcoY6sY1U3iDZ0s4GhsL75Fd+r8y3mXgYxM5opJTDzxkQl8WTKt6iQzXSzRwjIiDrnBzr9m
	F95u0pU80pmM/Wh1SJ4g6zt2hQBPs86hF4Ihh7JQ==
X-QQ-XMRINFO: NyFYKkN4Ny6FuXrnB5Ye7Aabb3ujjtK+gg==
X-QQ-RECHKSPAM: 0



> On Dec 1, 2025, at 15:35, Hangbin Liu <liuhangbin@gmail.com> wrote:
>=20
> On Sun, Nov 30, 2025 at 03:48:45PM +0800, Tonghao Zhang wrote:
>> After the first trylock fail, retrying immediately is
>> not advised as there is a high probability of failing
>> to acquire the lock again. This optimization makes sense.
>>=20
>> Cc: Jay Vosburgh <jv@jvosburgh.net>
>> Cc: "David S. Miller" <davem@davemloft.net>
>> Cc: Eric Dumazet <edumazet@google.com>
>> Cc: Jakub Kicinski <kuba@kernel.org>
>> Cc: Paolo Abeni <pabeni@redhat.com>
>> Cc: Simon Horman <horms@kernel.org>
>> Cc: Jonathan Corbet <corbet@lwn.net>
>> Cc: Andrew Lunn <andrew+netdev@lunn.ch>
>> Cc: Nikolay Aleksandrov <razor@blackwall.org>
>> Cc: Hangbin Liu <liuhangbin@gmail.com>
>> Cc: Jason Xing <kerneljasonxing@gmail.com>
>> Signed-off-by: Tonghao Zhang <tonghao@bamaicloud.com>
>> ---
>> v1:
>> - splitted from: =
https://patchwork.kernel.org/project/netdevbpf/patch/20251118090431.35654-=
1-tonghao@bamaicloud.com/
>> - this patch only skip the 2nd rtnl lock.
>> - add this patch to series
>> ---
>> drivers/net/bonding/bond_main.c | 16 +++++++++-------
>> 1 file changed, 9 insertions(+), 7 deletions(-)
>>=20
>> diff --git a/drivers/net/bonding/bond_main.c =
b/drivers/net/bonding/bond_main.c
>> index 1b16c4cd90e0..025ca0a45615 100644
>> --- a/drivers/net/bonding/bond_main.c
>> +++ b/drivers/net/bonding/bond_main.c
>> @@ -3756,7 +3756,7 @@ static bool bond_ab_arp_probe(struct bonding =
*bond)
>>=20
>> static void bond_activebackup_arp_mon(struct bonding *bond)
>> {
>> - bool should_notify_rtnl =3D false;
>> + bool should_notify_rtnl;
>> int delta_in_ticks;
>>=20
>> delta_in_ticks =3D msecs_to_jiffies(bond->params.arp_interval);
>> @@ -3784,13 +3784,11 @@ static void bond_activebackup_arp_mon(struct =
bonding *bond)
>> should_notify_rtnl =3D bond_ab_arp_probe(bond);
>> rcu_read_unlock();
>>=20
>> -re_arm:
>> - if (bond->params.arp_interval)
>> - queue_delayed_work(bond->wq, &bond->arp_work, delta_in_ticks);
>> -
>> if (bond->send_peer_notif || should_notify_rtnl) {
>> - if (!rtnl_trylock())
>> - return;
>> + if (!rtnl_trylock()) {
>> + delta_in_ticks =3D 1;
>> + goto re_arm;
>> + }
>>=20
>> if (bond->send_peer_notif) {
>> if (bond_should_notify_peers(bond))
>> @@ -3805,6 +3803,10 @@ static void bond_activebackup_arp_mon(struct =
bonding *bond)
>>=20
>> rtnl_unlock();
>> }
>> +
>> +re_arm:
>> + if (bond->params.arp_interval)
>> + queue_delayed_work(bond->wq, &bond->arp_work, delta_in_ticks);
>> }
>>=20
>> static void bond_arp_monitor(struct work_struct *work)
>> --=20
>> 2.34.1
>>=20
>=20
> Maybe this patch should be merged together with patch 02, since the =
issue
> was introduced there. Before patch 02, both should_notify_peers and
> should_notify_rtnl would be false when the first rtnl_trylock() =
failed,
> so the second trylock() would never be called.
Yes, but Paolo suggested that put it in a separate patch file, because =
this code is unrelated from patch02. It's all good to me.
=E2=80=9C=E2=80=9D"
The above skips the 2nd trylock attempt when the first one fail, which
IMHO makes sense, but its unrelated from the rest of the change here. I
think this specific bits should go in a separate patch.
=E2=80=9C"

=
https://patchwork.kernel.org/project/netdevbpf/patch/20251118090431.35654-=
1-tonghao@bamaicloud.com/
>=20
> Thanks
> Hangbin
>=20


