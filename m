Return-Path: <netdev+bounces-235013-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 58976C2B371
	for <lists+netdev@lfdr.de>; Mon, 03 Nov 2025 12:02:33 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 9EB091891F2D
	for <lists+netdev@lfdr.de>; Mon,  3 Nov 2025 11:02:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 83C992E8B6C;
	Mon,  3 Nov 2025 11:02:30 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from smtpbgau1.qq.com (smtpbgau1.qq.com [54.206.16.166])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E015020E702
	for <netdev@vger.kernel.org>; Mon,  3 Nov 2025 11:02:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=54.206.16.166
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762167750; cv=none; b=mbVLz60CUmDi5wukwB9QQmLRAgqzTxORO8287xLmr8mKwSEUJQHuj7j5WPrbCSoueqPhrGUCYhv+wcU7S6/3oFMK5m44wuyjXAorO/RgsTUKEorVYXYCzLY89XM4+uzojNa3MR/qkAP09EXyK2A/kxDgY7hLtqAyEe8FPIL9dyY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762167750; c=relaxed/simple;
	bh=HjvtxY6MV1MM5++oQI1o/H/YRSFC+sCXZFXrScCeuhM=;
	h=Content-Type:Mime-Version:Subject:From:In-Reply-To:Date:Cc:
	 Message-Id:References:To; b=E3xbqQjhdBa8Q8qnYADL91vaP9T0GqRroMuaeT6pZRDDPOdg+mNHiMyTMhMsAIY7Hbt29Fa3a3bVJHkhXDh1tVS4Q2/nm+sz+F6iArsh9U+F9p2UbA7ncPVeJeoydRjk7Vzq+mZeFe+4wBsBV3qtd0CryKIGY1MRgYKPkh0j1yg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=bamaicloud.com; spf=none smtp.mailfrom=bamaicloud.com; arc=none smtp.client-ip=54.206.16.166
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=bamaicloud.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=bamaicloud.com
X-QQ-mid: zesmtpgz4t1762167736t5698bd10
X-QQ-Originating-IP: JjMPZLciM32FLqYPuTsNnlsNYZsAXdV8bpeS0Uls/8A=
Received: from smtpclient.apple ( [111.204.182.99])
	by bizesmtp.qq.com (ESMTP) with 
	id ; Mon, 03 Nov 2025 19:02:14 +0800 (CST)
X-QQ-SSF: 0000000000000000000000000000000
X-QQ-GoodBg: 0
X-BIZMAIL-ID: 16132773687347379873
Content-Type: text/plain;
	charset=us-ascii
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
Mime-Version: 1.0 (Mac OS X Mail 16.0 \(3826.700.81\))
Subject: Re: [PATCH v2] net: bonding: use atomic instead of rtnl_mutex, to
 make sure peer notify updated
From: Tonghao Zhang <tonghao@bamaicloud.com>
In-Reply-To: <20251028034547.78830-1-tonghao@bamaicloud.com>
Date: Mon, 3 Nov 2025 19:02:04 +0800
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
Message-Id: <0F27DF5A-9AAC-4FBD-B559-C7491A5EA789@bamaicloud.com>
References: <20251028034547.78830-1-tonghao@bamaicloud.com>
To: netdev@vger.kernel.org
X-Mailer: Apple Mail (2.3826.700.81)
X-QQ-SENDSIZE: 520
Feedback-ID: zesmtpgz:bamaicloud.com:qybglogicsvrsz:qybglogicsvrsz4a-0
X-QQ-XMAILINFO: MNAQAfYnLn52mjq6a/p1BoRLcN9ZuZPCp4KwYu14JurU/4Gx4Jp1eEyL
	bhlCnbJGwFNwQr9nHnHfHvPqA4abLoujSWC7hhdF0uJQBEMhht2oyTagLVXAl5IGOpuiyYd
	qk0bUOwIb1F1h3bn3gXLAMD1b9TphfX3G+7RlcFpFGoRo5GZKEj7YqVMZdOV3nGNC6w+mVt
	CHLbMDiAlThU4rVDxhyBtLkDqjFMX2oNxtDXhetq/yWy7hTBq3v+aCukrmdJ+SboMbGt5C1
	v9dOTSjT9OEKw1YtTNFyMZyTzxBP/lqdYuRp7Z8NJWUZ1b24oWNzpnMwa1Va67vOmMPVV2R
	RaGHjuKu+EX7ISnVcWrJutXa572So1M0BzMiuuh9Z9ZpVSQlXPOmh8SGxIYxbxfMMRwe3Wa
	vWHy3urtC84aaZd/rUdkWij0udPCkgHYB7bwz4v+fKhcf6N6ZjeKPwEVCJWaASiVwtd1wwS
	7ZoDj/Jow11HaTFnu0U0wNBWH5xv5MBHMpgiR6d3JdR1wgcrjcTZGrkfPiLEAwD47/vWPm0
	WF90lEEb94qXIAZgs0AJ2wyzS+m5OtCFdVQ0aT5VMp63BUU9A8vrgemSrHg2x3c1FypLVuy
	bj0Yen/AXtFY9svf09NjpH7riSWlOfQOG7Ji91DSQMe8xk7GhITHw5UiWzgwauHE2RGSYdz
	D3x9uUxm8BBr8SA4bk1dE3dXD3Q2EaFU6YQIJnAAL84njwze6Uw38bWxDH2dJgMNR2ampSL
	1sxfuhn/4kld3LKnGSjIZgkWG1poNyJHccEzZACR/jvSU+f1yjbekc55wE8iqW+FHg3oyZ5
	8o0T80DE2AQ0If/+K96dQ3lEnQ6TJGs2HAj31/tYY/TEy3j+5qWahrKE/gGjJtH41wXkLqO
	z+jxJCy8OjAc9qITPkbrcVJkv9jjkuuJqgNFM5/LctdDQcP7yblexwCD1rgFPSooUdQraDn
	/L7t9lFqE/nF0QihCyW0aFgsJNKwIxW+3sSqk822DgMOA/qrn0UIfxA9P
X-QQ-XMRINFO: M/715EihBoGSf6IYSX1iLFg=
X-QQ-RECHKSPAM: 0

ping

> On Oct 28, 2025, at 11:45, Tonghao Zhang <tonghao@bamaicloud.com> =
wrote:
>=20
> Using atomic to protect the send_peer_notif instead of rtnl_mutex.
> This approach allows safe updates in both interrupt and process
> contexts, while avoiding code complexity.
>=20
> In lacp mode, the rtnl might be locked, preventing =
ad_cond_set_peer_notif()
> from acquiring the lock and updating send_peer_notif. This patch =
addresses
> the issue by using a atomic. Since updating send_peer_notif does not
> require high real-time performance, such atomic updates are =
acceptable.
>=20
> After coverting the rtnl lock for send_peer_notif to atomic, in =
bond_mii_monitor(),
> we should check the should_notify_peers (rtnllock required) instead of
> send_peer_notif. By the way, to avoid peer notify event loss, we check
> again whether to send peer notify, such as active-backup mode =
failover.
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
> v2:
> - refine the codes
> - check bond_should_notify_peers again in bond_mii_monitor(), to avoid
>  event loss.=20
> - v1 =
https://patchwork.kernel.org/project/netdevbpf/patch/20251026095614.48833-=
1-tonghao@bamaicloud.com/
> ---
> drivers/net/bonding/bond_3ad.c  |  7 ++---
> drivers/net/bonding/bond_main.c | 46 ++++++++++++++++-----------------
> include/net/bonding.h           |  9 ++++++-
> 3 files changed, 32 insertions(+), 30 deletions(-)
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
> index 8e592f37c28b..ae90221838d4 100644
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
> + if (bond_should_notify_peers(bond)) {
> + atomic_dec(&bond->send_peer_notif);
> + call_netdevice_notifiers(
> + NETDEV_NOTIFY_PEERS,
> + bond->dev);
> + }
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
> + if (commit || should_notify_peers) {
> /* Race avoidance with bond_close cancel of workqueue */
> if (!rtnl_trylock()) {
> delay =3D 1;
> @@ -2816,16 +2813,15 @@ static void bond_mii_monitor(struct =
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
> + /* check again to avoid send_peer_notif has been changed. */
> + if (bond_should_notify_peers(bond))
> + call_netdevice_notifiers(NETDEV_NOTIFY_PEERS, bond->dev);
>=20
> rtnl_unlock(); /* might sleep, hold no other locks */
> }
>=20
> + atomic_dec_if_positive(&bond->send_peer_notif);
> +
> re_arm:
> if (bond->params.miimon)
> queue_delayed_work(bond->wq, &bond->mii_work, delay);
> @@ -3773,7 +3769,7 @@ static void bond_activebackup_arp_mon(struct =
bonding *bond)
> return;
>=20
> if (should_notify_peers) {
> - bond->send_peer_notif--;
> + atomic_dec(&bond->send_peer_notif);
> call_netdevice_notifiers(NETDEV_NOTIFY_PEERS,
> bond->dev);
> }
> @@ -4267,6 +4263,8 @@ static int bond_open(struct net_device =
*bond_dev)
> queue_delayed_work(bond->wq, &bond->alb_work, 0);
> }
>=20
> + atomic_set(&bond->send_peer_notif, 0);
> +
> if (bond->params.miimon)  /* link check interval, in milliseconds. */
> queue_delayed_work(bond->wq, &bond->mii_work, 0);
>=20
> @@ -4300,7 +4298,7 @@ static int bond_close(struct net_device =
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


