Return-Path: <netdev+bounces-190313-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 8F3BAAB62C2
	for <lists+netdev@lfdr.de>; Wed, 14 May 2025 08:09:31 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 1B434460460
	for <lists+netdev@lfdr.de>; Wed, 14 May 2025 06:09:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B74991E5B68;
	Wed, 14 May 2025 06:09:27 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from smtpbgeu2.qq.com (smtpbgeu2.qq.com [18.194.254.142])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B05041DF751
	for <netdev@vger.kernel.org>; Wed, 14 May 2025 06:09:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=18.194.254.142
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747202967; cv=none; b=XrbGS5JwOSAvjkKCk8ihPSW1/WpSVBbdTKQljfGUR3ZYF0rdgmiR5IwWkpQok8kgPETjvAlm+RlF12v8WOfyzDkM/VPHw4Oy9fgN8WDx6bNBy+cQeAm9TGkkgxsUvftKUWL34c2pq53Ln9OY+2+5COuYFbYAh+HBQywsWYojsCc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747202967; c=relaxed/simple;
	bh=h5VizB82Shxsayy6U6qRSQmmJDxW73h2fj3YVX0Jp2g=;
	h=Content-Type:Mime-Version:Subject:From:In-Reply-To:Date:Cc:
	 Message-Id:References:To; b=IP9HRYoQlH5NcSP+YNebjU0RRmawjJ1ObAa36AYzc0hlj84oFvLmiDqcCGKVSTE+Z5OZE0IdBcWH8gw+MnrVIhn3lTGRdp44dAPiixp2XHzQZsxPWraO9bCjlydoXly+99NuYS6k0G6AYYKd23OXtli8J3SMpo+FqhJIJjl7FI0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=bamaicloud.com; spf=pass smtp.mailfrom=bamaicloud.com; arc=none smtp.client-ip=18.194.254.142
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=bamaicloud.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bamaicloud.com
X-QQ-mid: esmtpgz10t1747202886tebf79bb0
X-QQ-Originating-IP: XQ5BnhF6ZzTqlAY8GPZahqKRv0Rvzns8NSWwQyXVKig=
Received: from smtpclient.apple ( [111.202.70.100])
	by bizesmtp.qq.com (ESMTP) with 
	id ; Wed, 14 May 2025 14:07:26 +0800 (CST)
X-QQ-SSF: 0000000000000000000000000000000
X-QQ-GoodBg: 0
X-BIZMAIL-ID: 1071933934115154270
Content-Type: text/plain;
	charset=utf-8
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
Mime-Version: 1.0 (Mac OS X Mail 16.0 \(3826.400.131.1.6\))
Subject: Re: [PATCH net-next v2 3/4] net: bonding: send peer notify when
 failure recovery
From: Tonghao Zhang <tonghao@bamaicloud.com>
In-Reply-To: <b7a91eeb-4bf4-4bb7-ab2b-aa4b03ebcf70@blackwall.org>
Date: Wed, 14 May 2025 14:07:55 +0800
Cc: netdev@vger.kernel.org,
 Jay Vosburgh <jv@jvosburgh.net>,
 "David S. Miller" <davem@davemloft.net>,
 Eric Dumazet <edumazet@google.com>,
 Jakub Kicinski <kuba@kernel.org>,
 Paolo Abeni <pabeni@redhat.com>,
 Simon Horman <horms@kernel.org>,
 Jonathan Corbet <corbet@lwn.net>,
 Andrew Lunn <andrew+netdev@lunn.ch>,
 Zengbing Tu <tuzengbing@didiglobal.com>
Content-Transfer-Encoding: quoted-printable
Message-Id: <A07A9C4B-E8E2-402A-AD41-DDB0DA114DF4@bamaicloud.com>
References: <20250513094750.23387-1-tonghao@bamaicloud.com>
 <F5D495B5C2A94D9F+20250513094750.23387-4-tonghao@bamaicloud.com>
 <b7a91eeb-4bf4-4bb7-ab2b-aa4b03ebcf70@blackwall.org>
To: Nikolay Aleksandrov <razor@blackwall.org>
X-Mailer: Apple Mail (2.3826.400.131.1.6)
X-QQ-SENDSIZE: 520
Feedback-ID: esmtpgz:bamaicloud.com:qybglogicsvrsz:qybglogicsvrsz4a-0
X-QQ-XMAILINFO: NdaCjfXsdP3wz32qFNUm2XZj1TGiuFFKu+XWAB1li2LeTjPYededUiWf
	hulvMw+av5wMu70qpkYQ2zAoWE9WAOdh2Bd0Qd4ahsBxK2kxXxdefkaHr03P7R6FM4lVkh2
	2b0TW8uPLo++SZEZ5f70dY/BauBsbzxgSwYtNtXmNivxcMYsW6XTtfV1VOyNfls/FWENy3O
	riDwrggdAbs1d8MJWp0NI/tdZGW6j/WmvZYyqg0kmyC4TUlLlPFz5oZ78x1UCFvUqPnzvZt
	RpnjCk7jiDvRGRws6042dy9Hzmf0BuTiiHLtbf6FVFaYV4/X/asAdSCvhCIh5hwOs1dh+un
	7wEJV7xN2+fmVGodQJMvyxD5rKHlV1/pHVma5zJUI/w+GOXndKpaVNO/akaCAniy+134Mt1
	xsxVlgDRA4M9YNk0enNA9cwYaZzXoTMkykP/ohPjR2MEKEbX0iCCMN6TEEURDP7kFYksIGy
	dRTk5DL+MA9xeKI14Fcc6K44Zppxlec6j+q6hNEpEQAOaAi17+I82OPZK0IIK5HZfSzGs7L
	BDtOieMFN0osRL7rY/hzyC3gVwsi3aidMs09XDUECCnoNAiKZh3PdlIkea58wB/Vp9pTZnD
	3Oyfw174nXDgZep2DFSmlMXuQvh3OgABr6pIShAmukE28wJiPtZyH/iSvYG98S+e3eVI1B4
	TUy9phmjT42XKEOSJCw9cSeAPbkw4h5LT1eOtIrdtSi3lGUJ5M5lcwBPo6Dt/IBexG/MLD6
	Amu+kt5WLLAl3nyNK7l3R/YXL23NJJYae6r+ptQ/QtV1zuMmNLhqcPqMf/PZjTepfTI6wg/
	CviXJ/T++r3yTQ3y5yDaBpzFUIFI4lAjLKtrfiCsA5vh4wNbb7wDe2/wvv2P54CUQN5W+lp
	WigGBY/zOBcTwFM4Ns6tE+JCbshmL6CqR6CHvyOc5I6lEAvgQ0pOmMPIm1rVe4Ayf8T2woc
	xw7R6enanp/6SN1Y+RP2YMuaqZL04eATFQUp1jV33AYdgBoyLWA3bdiOA
X-QQ-XMRINFO: NyFYKkN4Ny6FSmKK/uo/jdU=
X-QQ-RECHKSPAM: 0



> 2025=E5=B9=B45=E6=9C=8813=E6=97=A5 18:37=EF=BC=8CNikolay Aleksandrov =
<razor@blackwall.org> =E5=86=99=E9=81=93=EF=BC=9A
>=20
> On 5/13/25 12:47, Tonghao Zhang wrote:
>> After LACP protocol recovery, the port can transmit packets.
>> However, if the bond port doesn't send gratuitous ARP/ND
>> packets to the switch, the switch won't return packets through
>> the current interface. This causes traffic imbalance. To resolve
>> this issue, when LACP protocol recovers, send ARP/ND packets.
>>=20
>> Cc: Jay Vosburgh <jv@jvosburgh.net>
>> Cc: "David S. Miller" <davem@davemloft.net>
>> Cc: Eric Dumazet <edumazet@google.com>
>> Cc: Jakub Kicinski <kuba@kernel.org>
>> Cc: Paolo Abeni <pabeni@redhat.com>
>> Cc: Simon Horman <horms@kernel.org>
>> Cc: Jonathan Corbet <corbet@lwn.net>
>> Cc: Andrew Lunn <andrew+netdev@lunn.ch>
>> Signed-off-by: Tonghao Zhang <tonghao@bamaicloud.com>
>> Signed-off-by: Zengbing Tu <tuzengbing@didiglobal.com>
>> ---
>> Documentation/networking/bonding.rst |  5 +++--
>> drivers/net/bonding/bond_3ad.c       | 13 +++++++++++++
>> drivers/net/bonding/bond_main.c      | 21 ++++++++++++++++-----
>> 3 files changed, 32 insertions(+), 7 deletions(-)
>>=20
>> diff --git a/Documentation/networking/bonding.rst =
b/Documentation/networking/bonding.rst
>> index 14f7593d888d..f8f5766703d4 100644
>> --- a/Documentation/networking/bonding.rst
>> +++ b/Documentation/networking/bonding.rst
>> @@ -773,8 +773,9 @@ num_unsol_na
>> greater than 1.
>>=20
>> The valid range is 0 - 255; the default value is 1.  These options
>> - affect only the active-backup mode.  These options were added for
>> - bonding versions 3.3.0 and 3.4.0 respectively.
>> + affect the active-backup or 802.3ad (broadcast_neighbor enabled) =
mode.
>> + These options were added for bonding versions 3.3.0 and 3.4.0
>> + respectively.
>>=20
>> =46rom Linux 3.0 and bonding version 3.7.1, these notifications
>> are generated by the ipv4 and ipv6 code and the numbers of
>> diff --git a/drivers/net/bonding/bond_3ad.c =
b/drivers/net/bonding/bond_3ad.c
>> index c6807e473ab7..d1c2d416ac87 100644
>> --- a/drivers/net/bonding/bond_3ad.c
>> +++ b/drivers/net/bonding/bond_3ad.c
>> @@ -982,6 +982,17 @@ static int ad_marker_send(struct port *port, =
struct bond_marker *marker)
>> return 0;
>> }
>>=20
>> +static void ad_cond_set_peer_notif(struct port *port)
>> +{
>> + struct bonding *bond =3D port->slave->bond;
>> +
>> + if (bond->params.broadcast_neighbor && rtnl_trylock()) {
>> + bond->send_peer_notif =3D bond->params.num_peer_notif *
>> + max(1, bond->params.peer_notif_delay);
>> + rtnl_unlock();
>> + }> +}
>> +
>> /**
>>  * ad_mux_machine - handle a port's mux state machine
>>  * @port: the port we're looking at
>> @@ -2061,6 +2072,8 @@ static void =
ad_enable_collecting_distributing(struct port *port,
>> __enable_port(port);
>> /* Slave array needs update */
>> *update_slave_arr =3D true;
>> + /* Should notify peers if possible */
>> + ad_cond_set_peer_notif(port);
>> }
>> }
>>=20
>> diff --git a/drivers/net/bonding/bond_main.c =
b/drivers/net/bonding/bond_main.c
>> index 8ee26ddddbc8..70bb1e33cee2 100644
>> --- a/drivers/net/bonding/bond_main.c
>> +++ b/drivers/net/bonding/bond_main.c
>> @@ -1243,17 +1243,28 @@ static struct slave =
*bond_find_best_slave(struct bonding *bond)
>> /* must be called in RCU critical section or with RTNL held */
>> static bool bond_should_notify_peers(struct bonding *bond)
>> {
>> - struct slave *slave =3D =
rcu_dereference_rtnl(bond->curr_active_slave);
>> + struct bond_up_slave *usable;
>> + struct slave *slave =3D NULL;
>>=20
>> - if (!slave || !bond->send_peer_notif ||
>> + if (!bond->send_peer_notif ||
>>     bond->send_peer_notif %
>>     max(1, bond->params.peer_notif_delay) !=3D 0 ||
>> -     !netif_carrier_ok(bond->dev) ||
>> +     !netif_carrier_ok(bond->dev))>   return false;
>>=20
>> + if (BOND_MODE(bond) =3D=3D BOND_MODE_8023AD) {
>> + usable =3D rtnl_dereference(bond->usable_slaves);
>=20
> If mii monitor is enabled in 802.3ad bond mode then this will be=20
> dereferenced in bond_mii_monitor() with rcu, so you'd have to use
> rcu_dereference_rtnl() instead.
Ok, thanks for your review.
>=20
>> + if (!usable || !READ_ONCE(usable->count))
>> + return false;
>> + } else {
>> + slave =3D rcu_dereference_rtnl(bond->curr_active_slave);
>> + if (!slave || test_bit(__LINK_STATE_LINKWATCH_PENDING,
>> +        &slave->dev->state))
>> + return false;
>> + }
>> +
>> netdev_dbg(bond->dev, "bond_should_notify_peers: slave %s\n",
>> -    slave ? slave->dev->name : "NULL");
>> +    slave ? slave->dev->name : "all");
>>=20
>> return true;
>> }



