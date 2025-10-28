Return-Path: <netdev+bounces-233468-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 7958CC13E1B
	for <lists+netdev@lfdr.de>; Tue, 28 Oct 2025 10:43:24 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 856043A5EDA
	for <lists+netdev@lfdr.de>; Tue, 28 Oct 2025 09:42:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DF1182EA72A;
	Tue, 28 Oct 2025 09:42:08 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from smtpbgjp3.qq.com (smtpbgjp3.qq.com [54.92.39.34])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EE2D72D877E
	for <netdev@vger.kernel.org>; Tue, 28 Oct 2025 09:42:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=54.92.39.34
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761644528; cv=none; b=V0eR3sF5Fks+RxBBABSqIgpCtZil+eIfjgjXFoNAkVsOH0r9eGQ5hoKAjCKIsznNVjb4rHHBbfNutdRls1NtFDVGRkvP5Z48IWUXXBrNrW6aNzVv57+pYQZFBjDywYK31znweVMqi+BjDQ59Szo4d1f9yg/Ipqt9MCOom52q/EI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761644528; c=relaxed/simple;
	bh=PBB9/l7aElApx/VuGQYqD79A6zVqtOWRmprax2kh69o=;
	h=Content-Type:Mime-Version:Subject:From:In-Reply-To:Date:Cc:
	 Message-Id:References:To; b=QtzeuT57/FIwZMYlj40QuRnE0cfi2Z/fH9u5HiZsO407xceYQBr3zJpZrAhrp0mvAsc2TEUhkWxx299nIAcD6rkRUjMZ0pFh3/q4mZw3ai+eCQuutycJpbr39+Euf/sVrvBdakP05cp2Jn9pNQ98s1WMTj4+9cSmKz/3W/z/7qY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=bamaicloud.com; spf=pass smtp.mailfrom=bamaicloud.com; arc=none smtp.client-ip=54.92.39.34
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=bamaicloud.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bamaicloud.com
X-QQ-mid: zesmtpgz8t1761644516tcf614161
X-QQ-Originating-IP: oCT00P8T/5eKLB582td0Z40qk5L4jb3fXYRRcCsj560=
Received: from smtpclient.apple ( [111.204.182.99])
	by bizesmtp.qq.com (ESMTP) with 
	id ; Tue, 28 Oct 2025 17:41:54 +0800 (CST)
X-QQ-SSF: 0000000000000000000000000000000
X-QQ-GoodBg: 0
X-BIZMAIL-ID: 15770556688580729466
Content-Type: text/plain;
	charset=us-ascii
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
Mime-Version: 1.0 (Mac OS X Mail 16.0 \(3826.700.81\))
Subject: Re: [PATCH net-next] net: bonding: use atomic instead of rtnl_mutex,
 to make sure peer notify updated
From: Tonghao Zhang <tonghao@bamaicloud.com>
In-Reply-To: <20251026095614.48833-1-tonghao@bamaicloud.com>
Date: Tue, 28 Oct 2025 17:41:44 +0800
Cc: Jay Vosburgh <jv@jvosburgh.net>,
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
Message-Id: <149BD40A-5DF0-45FD-8B8C-C10F30A7808F@bamaicloud.com>
References: <20251026095614.48833-1-tonghao@bamaicloud.com>
To: netdev@vger.kernel.org
X-Mailer: Apple Mail (2.3826.700.81)
X-QQ-SENDSIZE: 520
Feedback-ID: zesmtpgz:bamaicloud.com:qybglogicsvrsz:qybglogicsvrsz4a-0
X-QQ-XMAILINFO: NJVYoP7aqd/UMa4t+d3pxAQHaDNhxqjdE0SezKF4M1Lke0rHIGDQpLHi
	Mi/djVwqVZOD9qo+hBwYDCMuscYF4ok1jAvBn8gi0K4hQ8SlO6Ly95E7+UcSGr45ThuWWUf
	aAs3ph1uTEXoCGrEN4/sHj1Nn4flO/mlO7U3fPwRZ47hUx0Y46Wlaw6xAWzMF+XlEhRiq78
	Fnees5B5fSOMAO2t7IMfeBgY6I9F8AL2AUmkJApa+NQXVfYCjxsrJRLQl6mQMaGic8hwxZI
	CY9aiIbqQPj4HPCD1wXU0Lh3ogTt5Zx5eb23RvFVYjhvXRxVMORYTJCfJ75jgihnINrrTiP
	tTDDuF5fycD6cBP4L+TVsC71t2MVVuyBj/EZWhK3YwWttqQVGDj/splAsn87hewKJmADcZz
	u2hy+CNP+LfDRK3TebDJt+IiV3BFb1tTNHJ1vTihaCWP5gabAMRvKqiLV3wbdpH/x7krg0V
	8dWTpfXaM+eI0UGf9a2MxyDgsIXjWcFhNLbC/VhTEhuhCPRnNolMHPOK3O0QUwM/pcVlS0m
	eNiuoD5uKeROtz8EQkO2vfm4JlSsd7YIfAK1LLXbfY5UinpHQe+FAhvpEZYbYeMTLp5xI0V
	8O5YpPAC8ufh88e6BLe7MOEdJ64te1os4cztheX6wzRyI2SlR2T9MGPr6sZvi+4C/FEuzGf
	XpJP00ExAc/h2BImXhCgBu3Fm/wTaqCqKYNydH3FKu52+dmOsJEKSMzol1w2FLThhlj6u44
	Gzxoewg4f/s+KIc0R7Hf57qiYxp1e80gbjRZHY263McT6Y+NWWZ0Cu+8GljqGZ8/gATV49d
	CJbhLjnRVxM/6v0VF/07C4v18QBWTBkZojx6ppmtsi1iPQW6hco+1Il1n6pPOOyFEUSRPzA
	jwNn0UY4QeGaKB9ekJ/x2eNG9xyLjpkyo0a5og5d4V7ML3Id9T6EYMyHXYre4gjcs+++NmN
	KCDz9dvsxnx3OUBcXqO82TuPcIHgrQvTyzKZayrMAsmw3tfMhGs5cnP0xVspn48vw9QamJd
	3pMqiRI/ZNoMiaFE3l10D3zKQkli0U2nx0aWirSw==
X-QQ-XMRINFO: NyFYKkN4Ny6FSmKK/uo/jdU=
X-QQ-RECHKSPAM: 0

please drop this patch. V2 is post.

> On Oct 26, 2025, at 17:56, Tonghao Zhang <tonghao@bamaicloud.com> =
wrote:
>=20
> Using atomic to protect the send_peer_notif instead of rtnl_mutex.
> This approach allows safe updates in both interrupt and process
> contexts, while avoiding code complexity.
>=20
> In LACP mode, the RTNL might be locked, preventing =
ad_cond_set_peer_notif
> from acquiring the lock and updating send_peer_notif. This patch =
addresses
> the issue by using a atomic. Since updating send_peer_notif does not
> require high real-time performance, such atomic updates are =
acceptable.
>=20
> Cc: Jay Vosburgh <jv@jvosburgh.net>
> Cc: "David S. Miller" <davem@davemloft.net>
> Cc: Eric Dumazet <edumazet@google.com>
> Cc: Jakub Kicinski <kuba@kernel.org>
> Cc: Paolo Abeni <pabeni@redhat.com>
> Cc: Simon Horman <horms@kernel.org>
> Cc: Jonathan Corbet <corbet@lwn.net>
> Cc: Andrew Lunn <andrew+netdev@lunn.ch>
> Cc: Nikolay Aleksandrov <razor@blackwall.org>
> Cc: Hangbin Liu <liuhangbin@gmail.com>
> Suggested-by: Jay Vosburgh <jv@jvosburgh.net>
> Signed-off-by: Tonghao Zhang <tonghao@bamaicloud.com>
> ---
> drivers/net/bonding/bond_3ad.c  |  7 ++---
> drivers/net/bonding/bond_main.c | 45 +++++++++++++++------------------
> include/net/bonding.h           |  9 ++++++-
> 3 files changed, 31 insertions(+), 30 deletions(-)
>=20
> diff --git a/drivers/net/bonding/bond_3ad.c =
b/drivers/net/bonding/bond_3ad.c
> index 49717b7b82a2..05c573e45450 100644
> --- a/drivers/net/bonding/bond_3ad.c
> +++ b/drivers/net/bonding/bond_3ad.c
> @@ -999,11 +999,8 @@ static void ad_cond_set_peer_notif(struct port =
*port)
> {
> struct bonding *bond =3D port->slave->bond;
>=20
> - if (bond->params.broadcast_neighbor && rtnl_trylock()) {
> - bond->send_peer_notif =3D bond->params.num_peer_notif *
> - max(1, bond->params.peer_notif_delay);
> - rtnl_unlock();
> - }
> + if (bond->params.broadcast_neighbor)
> + bond_peer_notify_reset(bond);
> }
>=20
> /**
> diff --git a/drivers/net/bonding/bond_main.c =
b/drivers/net/bonding/bond_main.c
> index 8e592f37c28b..c3841e6a1b97 100644
> --- a/drivers/net/bonding/bond_main.c
> +++ b/drivers/net/bonding/bond_main.c
> @@ -1167,10 +1167,11 @@ static bool bond_should_notify_peers(struct =
bonding *bond)
> {
> struct bond_up_slave *usable;
> struct slave *slave =3D NULL;
> + int send_peer_notif;
>=20
> - if (!bond->send_peer_notif ||
> -    bond->send_peer_notif %
> -    max(1, bond->params.peer_notif_delay) !=3D 0 ||
> + send_peer_notif =3D atomic_read(&bond->send_peer_notif);
> + if (!send_peer_notif ||
> +    send_peer_notif % max(1, bond->params.peer_notif_delay) !=3D 0 ||
>    !netif_carrier_ok(bond->dev))
> return false;
>=20
> @@ -1270,8 +1271,6 @@ void bond_change_active_slave(struct bonding =
*bond, struct slave *new_active)
>      BOND_SLAVE_NOTIFY_NOW);
>=20
> if (new_active) {
> - bool should_notify_peers =3D false;
> -
> bond_set_slave_active_flags(new_active,
>    BOND_SLAVE_NOTIFY_NOW);
>=20
> @@ -1280,19 +1279,17 @@ void bond_change_active_slave(struct bonding =
*bond, struct slave *new_active)
>      old_active);
>=20
> if (netif_running(bond->dev)) {
> - bond->send_peer_notif =3D
> - bond->params.num_peer_notif *
> - max(1, bond->params.peer_notif_delay);
> - should_notify_peers =3D
> - bond_should_notify_peers(bond);
> + bond_peer_notify_reset(bond);
> +
> + if (bond_should_notify_peers(bond))
> + call_netdevice_notifiers(
> + NETDEV_NOTIFY_PEERS,
> + bond->dev);
> +
> + atomic_dec_if_positive(&bond->send_peer_notif);
> }
>=20
> call_netdevice_notifiers(NETDEV_BONDING_FAILOVER, bond->dev);
> - if (should_notify_peers) {
> - bond->send_peer_notif--;
> - call_netdevice_notifiers(NETDEV_NOTIFY_PEERS,
> - bond->dev);
> - }
> }
> }
>=20
> @@ -2801,7 +2798,7 @@ static void bond_mii_monitor(struct work_struct =
*work)
>=20
> rcu_read_unlock();
>=20
> - if (commit || bond->send_peer_notif) {
> + if (commit || atomic_read(&bond->send_peer_notif)) {
> /* Race avoidance with bond_close cancel of workqueue */
> if (!rtnl_trylock()) {
> delay =3D 1;
> @@ -2816,12 +2813,10 @@ static void bond_mii_monitor(struct =
work_struct *work)
> bond_miimon_commit(bond);
> }
>=20
> - if (bond->send_peer_notif) {
> - bond->send_peer_notif--;
> - if (should_notify_peers)
> - call_netdevice_notifiers(NETDEV_NOTIFY_PEERS,
> - bond->dev);
> - }
> + atomic_dec_if_positive(&bond->send_peer_notif);
> +
> + if (should_notify_peers)
> + call_netdevice_notifiers(NETDEV_NOTIFY_PEERS, bond->dev);
>=20
> rtnl_unlock(); /* might sleep, hold no other locks */
> }
> @@ -3773,7 +3768,7 @@ static void bond_activebackup_arp_mon(struct =
bonding *bond)
> return;
>=20
> if (should_notify_peers) {
> - bond->send_peer_notif--;
> + atomic_dec_if_positive(&bond->send_peer_notif);
> call_netdevice_notifiers(NETDEV_NOTIFY_PEERS,
> bond->dev);
> }
> @@ -4267,6 +4262,8 @@ static int bond_open(struct net_device =
*bond_dev)
> queue_delayed_work(bond->wq, &bond->alb_work, 0);
> }
>=20
> + atomic_set(&bond->send_peer_notif, 0);
> +
> if (bond->params.miimon)  /* link check interval, in milliseconds. */
> queue_delayed_work(bond->wq, &bond->mii_work, 0);
>=20
> @@ -4300,7 +4297,7 @@ static int bond_close(struct net_device =
*bond_dev)
> struct slave *slave;
>=20
> bond_work_cancel_all(bond);
> - bond->send_peer_notif =3D 0;
> + atomic_set(&bond->send_peer_notif, 0);
> if (bond_is_lb(bond))
> bond_alb_deinitialize(bond);
> bond->recv_probe =3D NULL;
> diff --git a/include/net/bonding.h b/include/net/bonding.h
> index 49edc7da0586..afdfcb5bfaf0 100644
> --- a/include/net/bonding.h
> +++ b/include/net/bonding.h
> @@ -236,7 +236,7 @@ struct bonding {
> */
> spinlock_t mode_lock;
> spinlock_t stats_lock;
> - u32 send_peer_notif;
> + atomic_t send_peer_notif;
> u8       igmp_retrans;
> #ifdef CONFIG_PROC_FS
> struct   proc_dir_entry *proc_entry;
> @@ -814,4 +814,11 @@ static inline netdev_tx_t bond_tx_drop(struct =
net_device *dev, struct sk_buff *s
> return NET_XMIT_DROP;
> }
>=20
> +static inline void bond_peer_notify_reset(struct bonding *bond)
> +{
> + atomic_set(&bond->send_peer_notif,
> + bond->params.num_peer_notif *
> + max(1, bond->params.peer_notif_delay));
> +}
> +
> #endif /* _NET_BONDING_H */
> --=20
> 2.34.1
>=20


