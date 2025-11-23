Return-Path: <netdev+bounces-241049-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id 035BCC7E16A
	for <lists+netdev@lfdr.de>; Sun, 23 Nov 2025 14:31:23 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id BC5B84E1DC1
	for <lists+netdev@lfdr.de>; Sun, 23 Nov 2025 13:31:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 13C4025EF81;
	Sun, 23 Nov 2025 13:31:19 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from smtpbgjp3.qq.com (smtpbgjp3.qq.com [54.92.39.34])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0EB6035957
	for <netdev@vger.kernel.org>; Sun, 23 Nov 2025 13:31:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=54.92.39.34
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763904679; cv=none; b=IPj8UWWyj4G0BsqzhON6BVPuvPk/1G2e0uKF///Bzr8lMT3lQ+fqKGsR26iinYqOZAtiwcpRj1+hURuPSbaFSDabd2unaL7peMWHBG/dGX1XXtrqfpGA/NWATsHzedScg+42zJ5yTNzg0iCDlemCekY5CmLw9S/HkI3MheOzLj4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763904679; c=relaxed/simple;
	bh=ndQ2uPCniiyF2WhIAYQkHLml92FeaJfrIkV+5E97zfk=;
	h=Content-Type:Mime-Version:Subject:From:In-Reply-To:Date:Cc:
	 Message-Id:References:To; b=pjavVNKJ54lqY9jy6Twonc5DwPg13NSE3sBg6/OZdCBVILqZKpk4vFYLqzfSM9Yld9tBEaYYxrZLAASUxN+bq5rAqrRo2Cgu34vNVzdjsmP5XyJONzFqIpGWeXKr19zAEV7YTa4PmIayAlHG5SWkMZK0gvw1ouZxjecTgeXMumM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=bamaicloud.com; spf=none smtp.mailfrom=bamaicloud.com; arc=none smtp.client-ip=54.92.39.34
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=bamaicloud.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=bamaicloud.com
X-QQ-mid: esmtpsz20t1763904670tc4185d13
X-QQ-Originating-IP: eMY1qN4WQCkEkM9Utl7gbJBJxDZyg3HEgAljKBVK2sw=
Received: from smtpclient.apple ( [183.241.14.219])
	by bizesmtp.qq.com (ESMTP) with 
	id ; Sun, 23 Nov 2025 21:30:34 +0800 (CST)
X-QQ-SSF: 0000000000000000000000000000000
X-QQ-GoodBg: 0
X-BIZMAIL-ID: 4621798053564672210
Content-Type: text/plain;
	charset=us-ascii
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
Mime-Version: 1.0 (Mac OS X Mail 16.0 \(3826.700.81\))
Subject: Re: [PATCH net-next v1] net: bonding: move bond_should_notify_peers,
 e.g. into rtnl lock block
From: Tonghao Zhang <tonghao@bamaicloud.com>
In-Reply-To: <4dcae50b-42f8-4adb-b154-5974f5aec19d@redhat.com>
Date: Sun, 23 Nov 2025 21:30:58 +0800
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
Message-Id: <66B650E7-EBE7-48F4-8B05-F294C2F4964C@bamaicloud.com>
References: <20251118090431.35654-1-tonghao@bamaicloud.com>
 <4dcae50b-42f8-4adb-b154-5974f5aec19d@redhat.com>
To: Paolo Abeni <pabeni@redhat.com>
X-Mailer: Apple Mail (2.3826.700.81)
X-QQ-SENDSIZE: 520
Feedback-ID: esmtpsz:bamaicloud.com:qybglogicsvrsz:qybglogicsvrsz3b-0
X-QQ-XMAILINFO: ND42uzdxTIzrxOyvCcWDvdiE5h042hSDQtkeuPkmzw1Ezgeph3oFpyCK
	mnMUoj/mxUfdDhg0m5DI3knieL2bVg92x/2adaAkTMamLhiQsAofd+Za59RGxG+TJKRSgop
	lE80XOUj0hu2DbKnkDMtpPXTz5wDAoeRPKUQuf8y2nYwtq4+2iXZ1/RFkVA/qwIomZXMPJh
	MLQUd0eeC4F7F9BSdnVC+r3Lu5BZwdXUGoVs7yQwXbr9/GlVNypLw09yixdMS/LnXJlPIDT
	G+lKK2hEHHo0hUymEKD9Cvpf9Ng3ZwcoQC6/yV+JegL1TJd/czOiKKlHHWu+uDD1Y2bX3B5
	CBe5CqFWXDPQs6l62N/7/Yrs1F1cLDq5ZWouYfP6jkN9HQ8jajxJpmK/pK7uegMi7xj4fhp
	CGE2ahoCcL/0qzIqgtDL/i4jDJ520PGsZKiq7wvSWN5CXN8kVDPO0NhZqUaKn4d8gGY/pAS
	+TL8ibK0Jdv2XRVMj26/3Dp/adb9TSiXdY6Jul9hK+VNbyAQajONxvw7uV5EeCH9tZO0rK2
	aakppVZGkHX5i05QOUv/nbE+BjsuAhFzTiLlJawyAmViwYShf3dGNq+FW9KgC0Hg8WbyrfL
	/S61cF0A7ESqOpfBM/acrqQ5OTVeWeg2JwyoV+6F8dXMqPojUdEtfzybavBpbAQ662jI1BK
	DxcFc+kps+fdkBPGZWxNBfu4c+jOB6lU/pL3ZkdsnR6LwKIbJ33KMaifMZb/SmZR+4g5SY/
	YZPWEhoezm+p2bP6bZ8dZI9pxwk8OMOLQJuo1X1XvNRgjAeePCHL35Q+LOb12wHoWe/uSeF
	oevD7jcI2GXONZHGiMz00ckDFbcZ/5lX1L2W54ByX+N6JJMymutj1NcOZA3HXOGHXW2L6sx
	CxFlteo6SmlyXPV8P8NmGwrR/lZuONay5TH0bba3WLvzzDJ+jf4Zr/UTURerKVR7l2C+ZQc
	K6gce2sl03oLhnGTP2QRI34GsXZH7ygQtnv63E7x4s8b5zTkJS5z/lGfxxNHIzgP3uj8b5/
	5go+0KjVhbtoz9KWml20g7mHYeazQ=
X-QQ-XMRINFO: OD9hHCdaPRBwq3WW+NvGbIU=
X-QQ-RECHKSPAM: 0



> On Nov 20, 2025, at 20:53, Paolo Abeni <pabeni@redhat.com> wrote:
>=20
> On 11/18/25 10:04 AM, Tonghao Zhang wrote:
>> In bond_mii_monitor()/bond_activebackup_arp_mon(), when we hold the =
rtnl lock:
>>=20
>> - check send_peer_notif again to avoid unconditionally reducing this =
value.
>> - send_peer_notif may have been reset. Therefore, it is necessary to =
check
>>  whether to send peer notify via bond_should_notify_peers() to avoid =
the
>>  loss of notification events.
>=20
> This looks strictly related to:
>=20
> =
https://patchwork.kernel.org/project/netdevbpf/patch/20251118090305.35558-=
1-tonghao@bamaicloud.com/
>=20
> you probably should bundle both in a series.
Ok
>=20
>> diff --git a/drivers/net/bonding/bond_main.c =
b/drivers/net/bonding/bond_main.c
>> index b7370c918978..6f0fa78fa3f3 100644
>> --- a/drivers/net/bonding/bond_main.c
>> +++ b/drivers/net/bonding/bond_main.c
>> @@ -2810,11 +2810,10 @@ static void bond_mii_monitor(struct =
work_struct *work)
>> {
>> struct bonding *bond =3D container_of(work, struct bonding,
>>    mii_work.work);
>> - bool should_notify_peers;
>> - bool commit;
>> - unsigned long delay;
>> - struct slave *slave;
>> struct list_head *iter;
>> + struct slave *slave;
>> + unsigned long delay;
>> + bool commit;
>>=20
>> delay =3D msecs_to_jiffies(bond->params.miimon);
>>=20
>> @@ -2823,7 +2822,6 @@ static void bond_mii_monitor(struct work_struct =
*work)
>>=20
>> rcu_read_lock();
>>=20
>> - should_notify_peers =3D bond_should_notify_peers(bond);
>> commit =3D !!bond_miimon_inspect(bond);
>>=20
>> rcu_read_unlock();
>> @@ -2844,10 +2842,10 @@ static void bond_mii_monitor(struct =
work_struct *work)
>> }
>>=20
>> if (bond->send_peer_notif) {
>=20
> The first `bond->send_peer_notif` access is outside the lock. I think
> the compiler could do funny things and read the field only outside the
> lock: I guess you need additional ONCE annotation, and that could be a
> separate patch.
Ok
>=20
>> - bond->send_peer_notif--;
>> - if (should_notify_peers)
>> + if (bond_should_notify_peers(bond))
>> call_netdevice_notifiers(NETDEV_NOTIFY_PEERS,
>> bond->dev);
>> + bond->send_peer_notif--;
>> }
>>=20
>> rtnl_unlock(); /* might sleep, hold no other locks */
>> @@ -3759,8 +3757,7 @@ static bool bond_ab_arp_probe(struct bonding =
*bond)
>>=20
>> static void bond_activebackup_arp_mon(struct bonding *bond)
>> {
>> - bool should_notify_peers =3D false;
>> - bool should_notify_rtnl =3D false;
>> + bool should_notify_rtnl;
>> int delta_in_ticks;
>>=20
>> delta_in_ticks =3D msecs_to_jiffies(bond->params.arp_interval);
>> @@ -3770,15 +3767,12 @@ static void bond_activebackup_arp_mon(struct =
bonding *bond)
>>=20
>> rcu_read_lock();
>>=20
>> - should_notify_peers =3D bond_should_notify_peers(bond);
>> -
>> if (bond_ab_arp_inspect(bond)) {
>> rcu_read_unlock();
>>=20
>> /* Race avoidance with bond_close flush of workqueue */
>> if (!rtnl_trylock()) {
>> delta_in_ticks =3D 1;
>> - should_notify_peers =3D false;
>> goto re_arm;
>> }
>>=20
>> @@ -3791,18 +3785,15 @@ static void bond_activebackup_arp_mon(struct =
bonding *bond)
>> should_notify_rtnl =3D bond_ab_arp_probe(bond);
>> rcu_read_unlock();
>>=20
>> -re_arm:
>> - if (bond->params.arp_interval)
>> - queue_delayed_work(bond->wq, &bond->arp_work, delta_in_ticks);
>> -
>> - if (should_notify_peers || should_notify_rtnl) {
>> + if (bond->send_peer_notif || should_notify_rtnl) {
>> if (!rtnl_trylock())
>> return;
>=20
> The above skips the 2nd trylock attempt when the first one fail, which
> IMHO makes sense, but its unrelated from the rest of the change here. =
I
> think this specific bits should go in a separate patch.
Ok, thanks.
>=20
> /P
>=20
>=20
>=20


