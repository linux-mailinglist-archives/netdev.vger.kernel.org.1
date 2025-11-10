Return-Path: <netdev+bounces-237116-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 6AD04C4572C
	for <lists+netdev@lfdr.de>; Mon, 10 Nov 2025 09:52:13 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 134E9188E820
	for <lists+netdev@lfdr.de>; Mon, 10 Nov 2025 08:52:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7CF882F8BCD;
	Mon, 10 Nov 2025 08:52:09 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from smtpbgau1.qq.com (smtpbgau1.qq.com [54.206.16.166])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F2F0CA926
	for <netdev@vger.kernel.org>; Mon, 10 Nov 2025 08:52:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=54.206.16.166
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762764729; cv=none; b=lqM1lE3Z26qxwfe+3VLD62aDqxRcesr75u6v5FPF7bPm0CxB6BcrDibG9kIp/zpb8DYkRKhsbXwO4EgcWnZO+K7MO3eCahpgx3sUEaOn5QtXfQBJcF1CHL14K9XfLWHB93OZ+K4HnD0miituAjdEDAsqMAF5k4US+k6nJZj+VPE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762764729; c=relaxed/simple;
	bh=aYRs5Z3YWm43ALFoB1EI9ydjiQ8JD3to4AlFhM0vjYg=;
	h=Content-Type:Mime-Version:Subject:From:In-Reply-To:Date:Cc:
	 Message-Id:References:To; b=U/H5z3VHQDDcc0vJT/Jlp704CnROAR+MD+j8FL3O456vTMd87DPHaJL01EDzHBM98NO6KpQO2NoNT/w5/rDkT4e3SDpPOBnVnaW3VajDB1X6Vh0vfUtS9iM7t1noUr7UwJjGntsS4XKuOqkoxEq0lSFKxyeSIK/XeE474lzGVRE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=bamaicloud.com; spf=none smtp.mailfrom=bamaicloud.com; arc=none smtp.client-ip=54.206.16.166
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=bamaicloud.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=bamaicloud.com
X-QQ-mid: zesmtpsz9t1762764716tbb0c187f
X-QQ-Originating-IP: 9wU0cIulwaW9fHKEKmOqcgPODeimRibi5qv7Rcf4mk0=
Received: from smtpclient.apple ( [111.204.182.99])
	by bizesmtp.qq.com (ESMTP) with 
	id ; Mon, 10 Nov 2025 16:51:53 +0800 (CST)
X-QQ-SSF: 0000000000000000000000000000000
X-QQ-GoodBg: 0
X-BIZMAIL-ID: 17916478263630461159
EX-QQ-RecipientCnt: 12
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
In-Reply-To: <B6F453DD-3BDA-4618-AD2A-5B317C32048A@bamaicloud.com>
Date: Mon, 10 Nov 2025 16:51:43 +0800
Cc: Jay Vosburgh <jv@jvosburgh.net>,
 netdev@vger.kernel.org,
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
Message-Id: <DC343C80-8B0C-4A7A-A532-FCB2860062AC@bamaicloud.com>
References: <20251028034547.78830-1-tonghao@bamaicloud.com>
 <253222.1762206506@vermin>
 <B6F453DD-3BDA-4618-AD2A-5B317C32048A@bamaicloud.com>
To: Tonghao Zhang <tonghao@bamaicloud.com>
X-Mailer: Apple Mail (2.3826.700.81)
X-QQ-SENDSIZE: 520
Feedback-ID: zesmtpsz:bamaicloud.com:qybglogicsvrsz:qybglogicsvrsz3b-0
X-QQ-XMAILINFO: MiwvI+Xv4jIRRQMa85TY0GgN+5K1iIC8KbT3yC11HLXyiNwZ5wiMu9o4
	34D0OQGhY6Q4ATpVFGdD7UHD54XG/a/tdvXs5jigsmxioZXKkJdLKvA6IQWM8PrpZQtNsMB
	JGgNsVWwVY1Eh/2z2AM3dqrxhrG1JFwkKtd7baDatYUlkBKc0zDMSeeZZsJOJJoBwnE2rbj
	/syN60y9u0o9UgNR/o0nlrSx+WQTlFsTxtd2NxidtbIjO7UBhL5zK4xlADNoEVW7TVT+Pyw
	a/Ne1BbsbNCx9Nks5uwSlG0HKz5uoZ75wMZ20J1H2p+E00byu7pOYkr/FOV3A/buHR7Rw6Z
	accvfhGoHMO/LiF+Gq/EQvVjpooQBcvlehC1yjieLjULzC3/uKM4rO7c6LY7J89UXLcFdvb
	VogwRGLITkj0ul0dgrZMZX2bQNy4VlA15zAeP2bGB/fINyDCIgkFiegXZTqVe1fRVPTy8eG
	SFynX389lR7j+8uhJOD+AfFCX5pI2NzWfoPMarSjN/YM92CCWSj7o7L2vObhuwJagpcSU4Q
	tt7hKnNTLE18UKCqVg15xrn75fg9UO+fMBOJihj9wY3HT8rF56WzpPcVdkKx79+o4RFwdae
	kB/ide4tQUsDDl+BSt/gm44JtdAH8g3Hnhoaogx0D1yxOTWnMAzbOytdzCv4/omzhamAVtg
	+o6EzeQ8kxlHsyU36XgeMvbnB8nsrQ2RYbQK0/F5ZgvJZ67Yy+apPD1JDrN45Tq6SgL0B8+
	l4eG5HHogJyG3IbbuMi1wzv5kNjXejoNslS61kJ1vQPjMYTdjoN78WsOFAndr31lXeT2vNl
	P75dKSgfpjkgpUCBcfZg42mq004nOJd/d0XNp6mrpIV05FITt688c7gYecQ0gU7dVUM7/mK
	49Kb32H/kLKBmQqHoYnD5EIWFl2PJM5kR7mCHvC+IFmWccA6xBzc7umpA5t7v6lDlvd9Yp/
	EVrW97mIxYRrDtWJ7CDM8VxE03GFujoDpk6Hh9JhBe1uojglO2EsrWFxe4BIwyWgwWywkNH
	evYSCxYwR1CbE4IQc410KzGUaU5eSdjZhhGe+siFsKQMa9VWlHTgjt6osof+IvRHGCwUfC3
	VGHHbrGoZHTtFBZHn2a9Nk=
X-QQ-XMRINFO: NI4Ajvh11aEj8Xl/2s1/T8w=
X-QQ-RECHKSPAM: 0



> On Nov 4, 2025, at 22:48, Tonghao Zhang <tonghao@bamaicloud.com> =
wrote:
>=20
>=20
>=20
>> On Nov 4, 2025, at 05:48, Jay Vosburgh <jv@jvosburgh.net> wrote:
>>=20
>> Tonghao Zhang <tonghao@bamaicloud.com> wrote:
>>=20
>>> Using atomic to protect the send_peer_notif instead of rtnl_mutex.
>>> This approach allows safe updates in both interrupt and process
>>> contexts, while avoiding code complexity.
>>>=20
>>> In lacp mode, the rtnl might be locked, preventing =
ad_cond_set_peer_notif()
>>> from acquiring the lock and updating send_peer_notif. This patch =
addresses
>>> the issue by using a atomic. Since updating send_peer_notif does not
>>> require high real-time performance, such atomic updates are =
acceptable.
>>>=20
>>> After coverting the rtnl lock for send_peer_notif to atomic, in =
bond_mii_monitor(),
>>> we should check the should_notify_peers (rtnllock required) instead =
of
>>> send_peer_notif. By the way, to avoid peer notify event loss, we =
check
>>> again whether to send peer notify, such as active-backup mode =
failover.
>>>=20
>>> Cc: Jay Vosburgh <jv@jvosburgh.net>
>>> Cc: "David S. Miller" <davem@davemloft.net>
>>> Cc: Eric Dumazet <edumazet@google.com>
>>> Cc: Jakub Kicinski <kuba@kernel.org>
>>> Cc: Paolo Abeni <pabeni@redhat.com>
>>> Cc: Simon Horman <horms@kernel.org>
>>> Cc: Jonathan Corbet <corbet@lwn.net>
>>> Cc: Andrew Lunn <andrew+netdev@lunn.ch>
>>> Cc: Nikolay Aleksandrov <razor@blackwall.org>
>>> Cc: Hangbin Liu <liuhangbin@gmail.com>
>>> Suggested-by: Jay Vosburgh <jv@jvosburgh.net>
>>> Signed-off-by: Tonghao Zhang <tonghao@bamaicloud.com>
>>> ---
>>> v2:
>>> - refine the codes
>>> - check bond_should_notify_peers again in bond_mii_monitor(), to =
avoid
>>> event loss.=20
>>> - v1 =
https://patchwork.kernel.org/project/netdevbpf/patch/20251026095614.48833-=
1-tonghao@bamaicloud.com/
>>> ---
>>> drivers/net/bonding/bond_3ad.c  |  7 ++---
>>> drivers/net/bonding/bond_main.c | 46 =
++++++++++++++++-----------------
>>> include/net/bonding.h           |  9 ++++++-
>>> 3 files changed, 32 insertions(+), 30 deletions(-)
>>>=20
>>> diff --git a/drivers/net/bonding/bond_3ad.c =
b/drivers/net/bonding/bond_3ad.c
>>> index 49717b7b82a2..05c573e45450 100644
>>> --- a/drivers/net/bonding/bond_3ad.c
>>> +++ b/drivers/net/bonding/bond_3ad.c
>>> @@ -999,11 +999,8 @@ static void ad_cond_set_peer_notif(struct port =
*port)
>>> {
>>> struct bonding *bond =3D port->slave->bond;
>>>=20
>>> - if (bond->params.broadcast_neighbor && rtnl_trylock()) {
>>> - bond->send_peer_notif =3D bond->params.num_peer_notif *
>>> - max(1, bond->params.peer_notif_delay);
>>> - rtnl_unlock();
>>> - }
>>> + if (bond->params.broadcast_neighbor)
>>> + bond_peer_notify_reset(bond);
>>> }
>>>=20
>>> /**
>>> diff --git a/drivers/net/bonding/bond_main.c =
b/drivers/net/bonding/bond_main.c
>>> index 8e592f37c28b..ae90221838d4 100644
>>> --- a/drivers/net/bonding/bond_main.c
>>> +++ b/drivers/net/bonding/bond_main.c
>>> @@ -1167,10 +1167,11 @@ static bool bond_should_notify_peers(struct =
bonding *bond)
>>> {
>>> struct bond_up_slave *usable;
>>> struct slave *slave =3D NULL;
>>> + int send_peer_notif;
>>>=20
>>> - if (!bond->send_peer_notif ||
>>> -     bond->send_peer_notif %
>>> -     max(1, bond->params.peer_notif_delay) !=3D 0 ||
>>> + send_peer_notif =3D atomic_read(&bond->send_peer_notif);
>>> + if (!send_peer_notif ||
>>> +     send_peer_notif % max(1, bond->params.peer_notif_delay) !=3D 0 =
||
>>>    !netif_carrier_ok(bond->dev))
>>> return false;
>>>=20
>>> @@ -1270,8 +1271,6 @@ void bond_change_active_slave(struct bonding =
*bond, struct slave *new_active)
>>>      BOND_SLAVE_NOTIFY_NOW);
>>>=20
>>> if (new_active) {
>>> - bool should_notify_peers =3D false;
>>> -
>>> bond_set_slave_active_flags(new_active,
>>>    BOND_SLAVE_NOTIFY_NOW);
>>>=20
>>> @@ -1280,19 +1279,17 @@ void bond_change_active_slave(struct bonding =
*bond, struct slave *new_active)
>>>      old_active);
>>>=20
>>> if (netif_running(bond->dev)) {
>>> - bond->send_peer_notif =3D
>>> - bond->params.num_peer_notif *
>>> - max(1, bond->params.peer_notif_delay);
>>> - should_notify_peers =3D
>>> - bond_should_notify_peers(bond);
>>> + bond_peer_notify_reset(bond);
>>> +
>>> + if (bond_should_notify_peers(bond)) {
>>> + atomic_dec(&bond->send_peer_notif);
>>> + call_netdevice_notifiers(
>>> + NETDEV_NOTIFY_PEERS,
>>> + bond->dev);
>>> + }
>>> }
>>>=20
>>> call_netdevice_notifiers(NETDEV_BONDING_FAILOVER, bond->dev);
>>> - if (should_notify_peers) {
>>> - bond->send_peer_notif--;
>>> - call_netdevice_notifiers(NETDEV_NOTIFY_PEERS,
>>> -  bond->dev);
>>> - }
>>> }
>>> }
>>>=20
>>> @@ -2801,7 +2798,7 @@ static void bond_mii_monitor(struct =
work_struct *work)
>>>=20
>>> rcu_read_unlock();
>>>=20
>>> - if (commit || bond->send_peer_notif) {
>>> + if (commit || should_notify_peers) {
>>> /* Race avoidance with bond_close cancel of workqueue */
>>> if (!rtnl_trylock()) {
>>> delay =3D 1;
>>> @@ -2816,16 +2813,15 @@ static void bond_mii_monitor(struct =
work_struct *work)
>>> bond_miimon_commit(bond);
>>> }
>>>=20
>>> - if (bond->send_peer_notif) {
>>> - bond->send_peer_notif--;
>>> - if (should_notify_peers)
>>> - call_netdevice_notifiers(NETDEV_NOTIFY_PEERS,
>>> -  bond->dev);
>>> - }
>>> + /* check again to avoid send_peer_notif has been changed. */
>>> + if (bond_should_notify_peers(bond))
>>> + call_netdevice_notifiers(NETDEV_NOTIFY_PEERS, bond->dev);
>>=20
>> Is the risk here that user space may have set send_peer_notify
>> to zero?
> If user sapce set the bond_should_notify_peers =3D=3D 0,  =
bond_should_notify_peers return the false. So NETDEV_NOTIFY_PEERS is =
disalbed, there is no peer notify.
>>=20
>>=20
>>>=20
>>> rtnl_unlock(); /* might sleep, hold no other locks */
>>> }
>>>=20
>>> + atomic_dec_if_positive(&bond->send_peer_notif);
>>> +
>>=20
>> Also, it's a bit subtle, but I think this has to be outside of
>> the if block, or peer_notif_delay may be unreliable.  I'm not sure it
>> needs a comment, but could you confirm that's why this line is where =
it
>> is?
> Yes, I will add comment in next version. That is why this line is =
here.
> - whether there is a commit/peer notify or not,  send_peer_notif-- in =
each loop. Therefore should be placed outside of if block.
> - make sure send_peer_notif-- after the commit or peer notify process =
to avoid that send_peer_notif=E2=80=94  but the rtnl_trylock failed.
> - regardless of whether send_peer_notif is set or not, =
atomic_dec_if_positive always be expected to execute and will not be =
less than 0.[will be comment that is safe.]
Although I have explained a lot, in fact, it is still more appropriate =
to put it in the if block.
Please help me review the next version
>>=20
>> -J
>>=20
>>> re_arm:
>>> if (bond->params.miimon)
>>> queue_delayed_work(bond->wq, &bond->mii_work, delay);
>>> @@ -3773,7 +3769,7 @@ static void bond_activebackup_arp_mon(struct =
bonding *bond)
>>> return;
>>>=20
>>> if (should_notify_peers) {
>>> - bond->send_peer_notif--;
>>> + atomic_dec(&bond->send_peer_notif);
>>> call_netdevice_notifiers(NETDEV_NOTIFY_PEERS,
>>> bond->dev);
>>> }
>>> @@ -4267,6 +4263,8 @@ static int bond_open(struct net_device =
*bond_dev)
>>> queue_delayed_work(bond->wq, &bond->alb_work, 0);
>>> }
>>>=20
>>> + atomic_set(&bond->send_peer_notif, 0);
>>> +
>>> if (bond->params.miimon)  /* link check interval, in milliseconds. =
*/
>>> queue_delayed_work(bond->wq, &bond->mii_work, 0);
>>>=20
>>> @@ -4300,7 +4298,7 @@ static int bond_close(struct net_device =
*bond_dev)
>>> struct slave *slave;
>>>=20
>>> bond_work_cancel_all(bond);
>>> - bond->send_peer_notif =3D 0;
>>> + atomic_set(&bond->send_peer_notif, 0);
>>> if (bond_is_lb(bond))
>>> bond_alb_deinitialize(bond);
>>> bond->recv_probe =3D NULL;
>>> diff --git a/include/net/bonding.h b/include/net/bonding.h
>>> index 49edc7da0586..afdfcb5bfaf0 100644
>>> --- a/include/net/bonding.h
>>> +++ b/include/net/bonding.h
>>> @@ -236,7 +236,7 @@ struct bonding {
>>> */
>>> spinlock_t mode_lock;
>>> spinlock_t stats_lock;
>>> - u32  send_peer_notif;
>>> + atomic_t send_peer_notif;
>>> u8       igmp_retrans;
>>> #ifdef CONFIG_PROC_FS
>>> struct   proc_dir_entry *proc_entry;
>>> @@ -814,4 +814,11 @@ static inline netdev_tx_t bond_tx_drop(struct =
net_device *dev, struct sk_buff *s
>>> return NET_XMIT_DROP;
>>> }
>>>=20
>>> +static inline void bond_peer_notify_reset(struct bonding *bond)
>>> +{
>>> + atomic_set(&bond->send_peer_notif,
>>> + bond->params.num_peer_notif *
>>> + max(1, bond->params.peer_notif_delay));
>>> +}
>>> +
>>> #endif /* _NET_BONDING_H */
>>> --=20
>>> 2.34.1
>>>=20
>>=20
>> ---
>> -Jay Vosburgh, jv@jvosburgh.net



