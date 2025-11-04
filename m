Return-Path: <netdev+bounces-235502-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 5D477C31A01
	for <lists+netdev@lfdr.de>; Tue, 04 Nov 2025 15:51:54 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 53BDB426FCF
	for <lists+netdev@lfdr.de>; Tue,  4 Nov 2025 14:48:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0AF9232D0FC;
	Tue,  4 Nov 2025 14:48:36 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from smtpbgjp3.qq.com (smtpbgjp3.qq.com [54.92.39.34])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E05A9330B29
	for <netdev@vger.kernel.org>; Tue,  4 Nov 2025 14:48:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=54.92.39.34
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762267715; cv=none; b=LZJyOmndQYwyBO0FjaEg5pjwIcEwyl5FXEKuh06PcB0vrlbaHS0AVRbOif/fnRZ1BMK+AWdZvlwRiHHNKJNtR/eX+sad6IOGG4uA1cKtrxEZ12+I53/w0fWE1t7Kxmg9yPz39DKHfAe0uE6YAhySfxJJaZjlOHEdK7h5CIHkciw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762267715; c=relaxed/simple;
	bh=doX3JLZS+sUy3hMCh55sr9woAe4LOITHXgCSwAS52nY=;
	h=Content-Type:Mime-Version:Subject:From:In-Reply-To:Date:Cc:
	 Message-Id:References:To; b=AszmH+xbitEvVvu+1Jb18yZr61tbGMZ/4I10RAMb/qUIbQYVZNBaIMvMd4JTugVJa2wAMoJC7oBa3+USV0SqL5SXmmAFGieblk4Xfg6SZSyDT6ASiV1xk0WO7jqCZzm1RPKhufD8r9UMG8nuoH3ulwxxSpxzJTAEorad6+Ums1Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=bamaicloud.com; spf=pass smtp.mailfrom=bamaicloud.com; arc=none smtp.client-ip=54.92.39.34
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=bamaicloud.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bamaicloud.com
X-QQ-mid: zesmtpgz1t1762267697t54f1d4f7
X-QQ-Originating-IP: N6+T5IVqLjlqbiMdXL38f31oQ+ykeXd7yIlqb+cbVtU=
Received: from smtpclient.apple ( [183.241.14.145])
	by bizesmtp.qq.com (ESMTP) with 
	id ; Tue, 04 Nov 2025 22:48:15 +0800 (CST)
X-QQ-SSF: 0000000000000000000000000000000
X-QQ-GoodBg: 0
X-BIZMAIL-ID: 5340102109755934879
Content-Type: text/plain;
	charset=utf-8
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
Mime-Version: 1.0 (Mac OS X Mail 16.0 \(3826.700.81\))
Subject: Re: [PATCH v2] net: bonding: use atomic instead of rtnl_mutex, to
 make sure peer notify updated
From: Tonghao Zhang <tonghao@bamaicloud.com>
In-Reply-To: <253222.1762206506@vermin>
Date: Tue, 4 Nov 2025 22:48:04 +0800
Cc: netdev@vger.kernel.org,
 "David S. Miller" <davem@davemloft.net>,
 Eric Dumazet <edumazet@google.com>,
 Jakub Kicinski <kuba@kernel.org>,
 Paolo Abeni <pabeni@redhat.com>,
 Simon Horman <horms@kernel.org>,
 Jonathan Corbet <corbet@lwn.net>,
 Andrew Lunn <andrew+netdev@lunn.ch>,
 Nikolay Aleksandrov <razor@blackwall.org>,
 Hangbin Liu <liuhangbin@gmail.com>
Content-Transfer-Encoding: quoted-printable
Message-Id: <B6F453DD-3BDA-4618-AD2A-5B317C32048A@bamaicloud.com>
References: <20251028034547.78830-1-tonghao@bamaicloud.com>
 <253222.1762206506@vermin>
To: Jay Vosburgh <jv@jvosburgh.net>
X-Mailer: Apple Mail (2.3826.700.81)
X-QQ-SENDSIZE: 520
Feedback-ID: zesmtpgz:bamaicloud.com:qybglogicsvrsz:qybglogicsvrsz4a-0
X-QQ-XMAILINFO: MNbA5mkmBXEJ6JEEIiOxayS33mbGZd8HvgdUtoR2af/3GhDYJLNxEuG3
	bEaVZSJzNfCQxVqeYxwqXq1mGq3u9KTyDR/BvfD/w0rGimgY8Qo7iUwCvJ79TDyj350FheG
	x0Uz1WSKe/krcdcplL/0NDLULwNABOeUQzhEdcsLMFbc5O72cjie9g3gVNko2E6gTtetBe1
	Rc6HHF/CBAgF9oGT9+UcVX076hA3K4XnEmV407pGn5genPM2s3z7/hwBVWfkWzse1jWhOsG
	5vJmKFlvANeeLwbxO9fhH7b7sP9jrIJsQi+U5xNu4x31Jd0ajM17KA3ARNeJO3iDVVlOuFX
	WrnpTQ7wrYV4N56JqZawIkke6vvOv8Zzyapdse3viPVXlfHCd0ilLarRil8m/2TyS7b3aoy
	CqWePDNVjFhvtr0zq+6jNUSYPrk/8AtKGVH8DrpX+zManQAfVxvyGvP31HO6SsMOHcxNA81
	Lp4nQw2EBNBu6w6v0qIach7IhPl2z5jTHgbOGgyaKb+L6+xuZ/87XRH2PoExWnSQ/CNKJux
	PP28wlvaBvhg1tUipmw+c5tJuxwF6VBL9KQvTwgV5OCCaneZNmHqPiQM5RRESSKif4x/4M5
	q36LDpiyxfcJ5v9216x7CSGBNczWxrFgy+Re1L9FdawcZn3G0fS/LOUZjQSIJjvjv4sS4Nl
	x3qi/CHOsYQEp7jJvoyLT/1LvnSa+ktrlIq3li+PEt+RhaBc9+b6NVKNz3Y5WGUYD7DgmB2
	zKZPd7SWeFZpxpdzhDsDIhG6EFP8cA5ab1K5PPCqyK3viOYeLJwvstR4ZuHhX9ERtiXnUDF
	0kiKHOuBmaqL+UI12FW4K2iXB+2shCpIam+5Uz87+tg9UO3WRDfggbThl96pLd1GquvC37j
	UjiUA5yi0RrFenIjSJ1vAYcPvy7mvnDkMZ9cqsShPERgnwKgU/FyYtRMgwWqt2opMd9fVjn
	hB+WbXxQUD3kpvt5NLbIt7kU6Kn252glzAxxivPLdI61LXH2SLKB0qxJD2uDkUijdOnuuBx
	tzqNWw8KNG5Tl9MHtH
X-QQ-XMRINFO: M/715EihBoGSf6IYSX1iLFg=
X-QQ-RECHKSPAM: 0



> On Nov 4, 2025, at 05:48, Jay Vosburgh <jv@jvosburgh.net> wrote:
>=20
> Tonghao Zhang <tonghao@bamaicloud.com> wrote:
>=20
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
>> v2:
>> - refine the codes
>> - check bond_should_notify_peers again in bond_mii_monitor(), to =
avoid
>> event loss.=20
>> - v1 =
https://patchwork.kernel.org/project/netdevbpf/patch/20251026095614.48833-=
1-tonghao@bamaicloud.com/
>> ---
>> drivers/net/bonding/bond_3ad.c  |  7 ++---
>> drivers/net/bonding/bond_main.c | 46 =
++++++++++++++++-----------------
>> include/net/bonding.h           |  9 ++++++-
>> 3 files changed, 32 insertions(+), 30 deletions(-)
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
>> index 8e592f37c28b..ae90221838d4 100644
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
>> -     bond->send_peer_notif %
>> -     max(1, bond->params.peer_notif_delay) !=3D 0 ||
>> + send_peer_notif =3D atomic_read(&bond->send_peer_notif);
>> + if (!send_peer_notif ||
>> +     send_peer_notif % max(1, bond->params.peer_notif_delay) !=3D 0 =
||
>>     !netif_carrier_ok(bond->dev))
>> return false;
>>=20
>> @@ -1270,8 +1271,6 @@ void bond_change_active_slave(struct bonding =
*bond, struct slave *new_active)
>>       BOND_SLAVE_NOTIFY_NOW);
>>=20
>> if (new_active) {
>> - bool should_notify_peers =3D false;
>> -
>> bond_set_slave_active_flags(new_active,
>>     BOND_SLAVE_NOTIFY_NOW);
>>=20
>> @@ -1280,19 +1279,17 @@ void bond_change_active_slave(struct bonding =
*bond, struct slave *new_active)
>>       old_active);
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
>> -  bond->dev);
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
>> @@ -2816,16 +2813,15 @@ static void bond_mii_monitor(struct =
work_struct *work)
>> bond_miimon_commit(bond);
>> }
>>=20
>> - if (bond->send_peer_notif) {
>> - bond->send_peer_notif--;
>> - if (should_notify_peers)
>> - call_netdevice_notifiers(NETDEV_NOTIFY_PEERS,
>> -  bond->dev);
>> - }
>> + /* check again to avoid send_peer_notif has been changed. */
>> + if (bond_should_notify_peers(bond))
>> + call_netdevice_notifiers(NETDEV_NOTIFY_PEERS, bond->dev);
>=20
> Is the risk here that user space may have set send_peer_notify
> to zero?
If user sapce set the bond_should_notify_peers =3D=3D 0,  =
bond_should_notify_peers return the false. So NETDEV_NOTIFY_PEERS is =
disalbed, there is no peer notify.
>=20
>=20
>>=20
>> rtnl_unlock(); /* might sleep, hold no other locks */
>> }
>>=20
>> + atomic_dec_if_positive(&bond->send_peer_notif);
>> +
>=20
> Also, it's a bit subtle, but I think this has to be outside of
> the if block, or peer_notif_delay may be unreliable.  I'm not sure it
> needs a comment, but could you confirm that's why this line is where =
it
> is?
Yes, I will add comment in next version. That is why this line is here.
- whether there is a commit/peer notify or not,  send_peer_notif-- in =
each loop. Therefore should be placed outside of if block.
- make sure send_peer_notif-- after the commit or peer notify process to =
avoid that send_peer_notif=E2=80=94  but the rtnl_trylock failed.
- regardless of whether send_peer_notif is set or not, =
atomic_dec_if_positive always be expected to execute and will not be =
less than 0.[will be comment that is safe.]
>=20
> -J
>=20
>> re_arm:
>> if (bond->params.miimon)
>> queue_delayed_work(bond->wq, &bond->mii_work, delay);
>> @@ -3773,7 +3769,7 @@ static void bond_activebackup_arp_mon(struct =
bonding *bond)
>> return;
>>=20
>> if (should_notify_peers) {
>> - bond->send_peer_notif--;
>> + atomic_dec(&bond->send_peer_notif);
>> call_netdevice_notifiers(NETDEV_NOTIFY_PEERS,
>>  bond->dev);
>> }
>> @@ -4267,6 +4263,8 @@ static int bond_open(struct net_device =
*bond_dev)
>> queue_delayed_work(bond->wq, &bond->alb_work, 0);
>> }
>>=20
>> + atomic_set(&bond->send_peer_notif, 0);
>> +
>> if (bond->params.miimon)  /* link check interval, in milliseconds. */
>> queue_delayed_work(bond->wq, &bond->mii_work, 0);
>>=20
>> @@ -4300,7 +4298,7 @@ static int bond_close(struct net_device =
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
>>  */
>> spinlock_t mode_lock;
>> spinlock_t stats_lock;
>> - u32  send_peer_notif;
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
>> --=20
>> 2.34.1
>>=20
>=20
> ---
> -Jay Vosburgh, jv@jvosburgh.net



