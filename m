Return-Path: <netdev+bounces-237114-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 1E23AC456C0
	for <lists+netdev@lfdr.de>; Mon, 10 Nov 2025 09:47:52 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id B5E144E1EA3
	for <lists+netdev@lfdr.de>; Mon, 10 Nov 2025 08:47:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 419342FCBEF;
	Mon, 10 Nov 2025 08:47:48 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from smtpbgjp3.qq.com (smtpbgjp3.qq.com [54.92.39.34])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2BAEE2FC87E
	for <netdev@vger.kernel.org>; Mon, 10 Nov 2025 08:47:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=54.92.39.34
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762764468; cv=none; b=EudL1Yx5ikM2fwbnXMt04NeoNMHtd3vdITUPiakd0xTzR3Bl1fY8W/k9zN32qX2KseI+yxz/USqxsOydIxbYeeSBR75SCaY9n41ZNif703Ph2IaeExAJa6DkHt+jEJghea4+A2umLHKja3jdaxyuJmqc1J7GgcliOxfV355U2YU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762764468; c=relaxed/simple;
	bh=hGWFD59KU986RIcpnJvHO2JQ0SSAxI+NAF5/78A/C7I=;
	h=Content-Type:Mime-Version:Subject:From:In-Reply-To:Date:Cc:
	 Message-Id:References:To; b=nJp6gFawUsulRKgf5uU/cUetD6oSxvUaHpKMwIfwamfhAkFu15Z3QkYSEuelSsiyjHUF3enR/vbkDcWXaGoJjL3GYuQnQGK8XjbOvzbMCEmDrEsdVjBiPlK+zhTJ9gF1cS9+aNimBWppcr6Kgh4gwFhDK4VA+bVobIRypf9BVjE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=bamaicloud.com; spf=pass smtp.mailfrom=bamaicloud.com; arc=none smtp.client-ip=54.92.39.34
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=bamaicloud.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bamaicloud.com
X-QQ-mid: esmtpsz21t1762764453t673816e9
X-QQ-Originating-IP: rKplnT7EU2V7n+XwJLMJpSBdQ/exj1W1+8ohrdwgPxE=
Received: from smtpclient.apple ( [111.204.182.99])
	by bizesmtp.qq.com (ESMTP) with 
	id ; Mon, 10 Nov 2025 16:47:30 +0800 (CST)
X-QQ-SSF: 0000000000000000000000000000000
X-QQ-GoodBg: 0
X-BIZMAIL-ID: 8893434775976797232
Content-Type: text/plain;
	charset=us-ascii
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
Mime-Version: 1.0 (Mac OS X Mail 16.0 \(3826.700.81\))
Subject: Re: [PATCH net-next v3] net: bonding: use atomic instead of
 rtnl_mutex, to make sure peer notify updated
From: Tonghao Zhang <tonghao@bamaicloud.com>
In-Reply-To: <975f3126-482a-4963-a125-d51732ddcdac@blackwall.org>
Date: Mon, 10 Nov 2025 16:47:20 +0800
Cc: netdev@vger.kernel.org,
 Jay Vosburgh <jv@jvosburgh.net>,
 "David S. Miller" <davem@davemloft.net>,
 Eric Dumazet <edumazet@google.com>,
 Jakub Kicinski <kuba@kernel.org>,
 Paolo Abeni <pabeni@redhat.com>,
 Simon Horman <horms@kernel.org>,
 Jonathan Corbet <corbet@lwn.net>,
 Andrew Lunn <andrew+netdev@lunn.ch>,
 Hangbin Liu <liuhangbin@gmail.com>
Content-Transfer-Encoding: quoted-printable
Message-Id: <7B4961BE-C847-4881-8E5A-26B76DC386B1@bamaicloud.com>
References: <20251105142739.41833-1-tonghao@bamaicloud.com>
 <975f3126-482a-4963-a125-d51732ddcdac@blackwall.org>
To: Nikolay Aleksandrov <razor@blackwall.org>
X-Mailer: Apple Mail (2.3826.700.81)
X-QQ-SENDSIZE: 520
Feedback-ID: esmtpsz:bamaicloud.com:qybglogicsvrsz:qybglogicsvrsz3b-0
X-QQ-XMAILINFO: MG1k13TElWXsG0eXJtuBgayO00O6JBWUeJ+5fRzbsa5jnotT8vAQyu1/
	aRcLPtzVxiqtf46DDlEEd7Dl+uxKeRcMXbM8DtimU6OeuXZAkq4/faRn60t1YOHo+G3OyDU
	V5//f36lJfElQqurziKqUndIETkZETrigZt2KmW00KYy9+bkajYGtcuc3xjkOI9+8qaPNXN
	v/iEHVnFSsJIoCw76WUMqw8JT00pJjxbTMOPXDiYPBWRf0/l+JVe9JHsl/wyDIlZyK8j3m2
	hZMq5/R88Ujq2uTyVPSD9pFU50/mx4sgOVFulOO/Syjz28ZCwSNOvsJ5NDPBflBN5Px51YR
	Bya6cVugwPCP177U3BKsaS7dDPdVbzKKbzHFgbChoc7q7NK2Pm7q8KxHUuiWKwm7l8VDp1Q
	5Ndxi4WD/vnR02JCgTvPDNmOPcj4ZQOHFDBKip6OWpP4ZFyGKfIBf+Ouka6ZfqGQHDQjM/V
	L/1SYc6zZ3jfX1soNL4w3Codsy14UywJa8HqTAd/NMzrvMIyCjlakkd0FygDNiPsJ7ZvVQM
	2JfCUMHE8ueKnKLQ4p7n6xPBUZT0piqEzQ4C2ttHCHXKJIJ86lugjELfDFMSB1+qUP7c7Is
	huMkBlGWAaiSW0oRgU7ZuDteEjfcyorGGAXk8sUgDeQcLw/JHkFJ7h+bn5xSgxCYmjyRsmR
	JpetiHxKma//lU/UhkFm8TAKnpHjrpxCA4CVGnODFRohTOsPRcEYYrLTEjQEew2U1M3Demg
	UOY5+Dz+0EaNtBf9Z9iArgCLIk08jLAn2cOxIZofqkAbnVZWbXtdM+WI4Tcm1nP8RJxOLxz
	9RT3LadvKRpbdzvwmNC3x0f+a0awapBZajcR+PGPv0/rMe+eQxvwQnDMqH8MXyGmhXNsAcR
	/CCmnuhjj2AJsu2B9G23YpZOVzagZkVpPI4trTTRlD6ugb/EaKMXK05Ah6+mxREU6tISYvu
	sSLZevd2z9hKgSr9QJdcb3/tPLawhJ4J/QeLmIm0cZY6KjT70CuNPUUPeYH/WQguQqzQ=
X-QQ-XMRINFO: OWPUhxQsoeAVDbp3OJHYyFg=
X-QQ-RECHKSPAM: 0



> On Nov 5, 2025, at 22:46, Nikolay Aleksandrov <razor@blackwall.org> =
wrote:
>=20
> On 11/5/25 16:27, Tonghao Zhang wrote:
>> Using atomic to protect the send_peer_notif instead of rtnl_mutex.
>> This approach allows safe updates in both interrupt and process
>> contexts, while avoiding code complexity.
>>=20
>> In lacp mode, the rtnl might be locked, preventing =
ad_cond_set_peer_notif()
>> from acquiring the lock and updating send_peer_notif. This patch =
addresses
>> the issue by using a atomic. Since updating send_peer_notif does not
>> require high real-time performance, such atomic updates are =
acceptable.
>>=20
>> After coverting the rtnl lock for send_peer_notif to atomic, in =
bond_mii_monitor(),
>> we should check the should_notify_peers (rtnllock required) instead =
of
>> send_peer_notif. By the way, to avoid peer notify event loss, we =
check
>> again whether to send peer notify, such as active-backup mode =
failover.
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
>> Suggested-by: Jay Vosburgh <jv@jvosburgh.net>
>> Signed-off-by: Tonghao Zhang <tonghao@bamaicloud.com>
>> ---
>> v3:
>> - add the comment, *_dec_if_positive is safe.
>> v2:
>> - refine the codes
>> - check bond_should_notify_peers again in bond_mii_monitor(), to =
avoid event loss.
>> v1:
>> - =
https://patchwork.kernel.org/project/netdevbpf/patch/20251026095614.48833-=
1-tonghao@bamaicloud.com/
>> ---
>> drivers/net/bonding/bond_3ad.c  |  7 ++---
>> drivers/net/bonding/bond_main.c | 47 =
++++++++++++++++-----------------
>> include/net/bonding.h           |  9 ++++++-
>> 3 files changed, 33 insertions(+), 30 deletions(-)
>>=20
>> diff --git a/drivers/net/bonding/bond_3ad.c =
b/drivers/net/bonding/bond_3ad.c
>> index 49717b7b82a2..05c573e45450 100644
>> --- a/drivers/net/bonding/bond_3ad.c
>> +++ b/drivers/net/bonding/bond_3ad.c
>> @@ -999,11 +999,8 @@ static void ad_cond_set_peer_notif(struct port =
*port)
>> {
>> struct bonding *bond =3D port->slave->bond;
>>=20
>> - if (bond->params.broadcast_neighbor && rtnl_trylock()) {
>> - bond->send_peer_notif =3D bond->params.num_peer_notif *
>> - max(1, bond->params.peer_notif_delay);
>> - rtnl_unlock();
>> - }
>> + if (bond->params.broadcast_neighbor)
>> + bond_peer_notify_reset(bond);
>> }
>>=20
>> /**
>> diff --git a/drivers/net/bonding/bond_main.c =
b/drivers/net/bonding/bond_main.c
>> index 8e592f37c28b..4da92f3b129c 100644
>> --- a/drivers/net/bonding/bond_main.c
>> +++ b/drivers/net/bonding/bond_main.c
>> @@ -1167,10 +1167,11 @@ static bool bond_should_notify_peers(struct =
bonding *bond)
>> {
>> struct bond_up_slave *usable;
>> struct slave *slave =3D NULL;
>> + int send_peer_notif;
>>=20
>> - if (!bond->send_peer_notif ||
>> -    bond->send_peer_notif %
>> -    max(1, bond->params.peer_notif_delay) !=3D 0 ||
>> + send_peer_notif =3D atomic_read(&bond->send_peer_notif);
>> + if (!send_peer_notif ||
>> +    send_peer_notif % max(1, bond->params.peer_notif_delay) !=3D 0 =
||
>>    !netif_carrier_ok(bond->dev))
>> return false;
>>=20
>> @@ -1270,8 +1271,6 @@ void bond_change_active_slave(struct bonding =
*bond, struct slave *new_active)
>>      BOND_SLAVE_NOTIFY_NOW);
>>=20
>> if (new_active) {
>> - bool should_notify_peers =3D false;
>> -
>> bond_set_slave_active_flags(new_active,
>>    BOND_SLAVE_NOTIFY_NOW);
>>=20
>> @@ -1280,19 +1279,17 @@ void bond_change_active_slave(struct bonding =
*bond, struct slave *new_active)
>>      old_active);
>>=20
>> if (netif_running(bond->dev)) {
>> - bond->send_peer_notif =3D
>> - bond->params.num_peer_notif *
>> - max(1, bond->params.peer_notif_delay);
>> - should_notify_peers =3D
>> - bond_should_notify_peers(bond);
>> + bond_peer_notify_reset(bond);
>> +
>> + if (bond_should_notify_peers(bond)) {
>> + atomic_dec(&bond->send_peer_notif);
>> + call_netdevice_notifiers(
>> + NETDEV_NOTIFY_PEERS,
>> + bond->dev);
>> + }
>> }
>>=20
>> call_netdevice_notifiers(NETDEV_BONDING_FAILOVER, bond->dev);
>> - if (should_notify_peers) {
>> - bond->send_peer_notif--;
>> - call_netdevice_notifiers(NETDEV_NOTIFY_PEERS,
>> - bond->dev);
>> - }
>> }
>> }
>>=20
>> @@ -2801,7 +2798,7 @@ static void bond_mii_monitor(struct work_struct =
*work)
>>=20
>> rcu_read_unlock();
>>=20
>> - if (commit || bond->send_peer_notif) {
>> + if (commit || should_notify_peers) {
>> /* Race avoidance with bond_close cancel of workqueue */
>> if (!rtnl_trylock()) {
>> delay =3D 1;
>> @@ -2816,16 +2813,16 @@ static void bond_mii_monitor(struct =
work_struct *work)
>> bond_miimon_commit(bond);
>> }
>>=20
>> - if (bond->send_peer_notif) {
>> - bond->send_peer_notif--;
>> - if (should_notify_peers)
>> - call_netdevice_notifiers(NETDEV_NOTIFY_PEERS,
>> - bond->dev);
>> - }
>> + /* check again to avoid send_peer_notif has been changed. */
>> + if (bond_should_notify_peers(bond))
>> + call_netdevice_notifiers(NETDEV_NOTIFY_PEERS, bond->dev);
>>=20
>> rtnl_unlock(); /* might sleep, hold no other locks */
>> }
>>=20
>> + /* this's safe to *_dec_if_positive, even when peer notify =
disabled. */
>> + atomic_dec_if_positive(&bond->send_peer_notif);
>> +
>> re_arm:
>> if (bond->params.miimon)
>> queue_delayed_work(bond->wq, &bond->mii_work, delay);
>> @@ -3773,7 +3770,7 @@ static void bond_activebackup_arp_mon(struct =
bonding *bond)
>> return;
>>=20
>> if (should_notify_peers) {
>> - bond->send_peer_notif--;
>> + atomic_dec(&bond->send_peer_notif);
>=20
> this can run in parallel with the active slave change and they both =
can
> read the same send_peer_notif count and do an unconditional decrement
> even though only one of them should, should_notify_peers is read =
outside
> of the lock and can race with active slave change
This appears to be the original issue, but I have fixed it in the next =
version.
>=20
>> call_netdevice_notifiers(NETDEV_NOTIFY_PEERS,
>> bond->dev);
>> }
>> @@ -4267,6 +4264,8 @@ static int bond_open(struct net_device =
*bond_dev)
>> queue_delayed_work(bond->wq, &bond->alb_work, 0);
>> }
>>=20
>> + atomic_set(&bond->send_peer_notif, 0);
>> +
>> if (bond->params.miimon)  /* link check interval, in milliseconds. */
>> queue_delayed_work(bond->wq, &bond->mii_work, 0);
>>=20
>> @@ -4300,7 +4299,7 @@ static int bond_close(struct net_device =
*bond_dev)
>> struct slave *slave;
>>=20
>> bond_work_cancel_all(bond);
>> - bond->send_peer_notif =3D 0;
>> + atomic_set(&bond->send_peer_notif, 0);
>> if (bond_is_lb(bond))
>> bond_alb_deinitialize(bond);
>> bond->recv_probe =3D NULL;
>> diff --git a/include/net/bonding.h b/include/net/bonding.h
>> index 49edc7da0586..afdfcb5bfaf0 100644
>> --- a/include/net/bonding.h
>> +++ b/include/net/bonding.h
>> @@ -236,7 +236,7 @@ struct bonding {
>> */
>> spinlock_t mode_lock;
>> spinlock_t stats_lock;
>> - u32 send_peer_notif;
>> + atomic_t send_peer_notif;
>> u8       igmp_retrans;
>> #ifdef CONFIG_PROC_FS
>> struct   proc_dir_entry *proc_entry;
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
>> +}
>> +
>> #endif /* _NET_BONDING_H */
>=20
>=20


