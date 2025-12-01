Return-Path: <netdev+bounces-242951-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [IPv6:2a01:60a::1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id B1F0CC96CA8
	for <lists+netdev@lfdr.de>; Mon, 01 Dec 2025 12:02:05 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id 1F1F1342AA6
	for <lists+netdev@lfdr.de>; Mon,  1 Dec 2025 11:02:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 78C8123D7DC;
	Mon,  1 Dec 2025 11:02:00 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from smtpbgsg2.qq.com (smtpbgsg2.qq.com [54.254.200.128])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1105121CC4F
	for <netdev@vger.kernel.org>; Mon,  1 Dec 2025 11:01:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=54.254.200.128
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1764586920; cv=none; b=Ev9vHUuoBe1wqYnz2n74+ELuflpXmPUwOYVCLh3qbYaveoJxunhlAcjMWaaDcmZYp0z6TSKsYNEoyB37j+hiQsHmDZ5/u0hOWYUeK39hkM34YBhbNGUek2z/FfVtBbP9bf9FoqaeeK8krQxMmfuZJSzxOSFJ+PFCzhLJXZEAPf4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1764586920; c=relaxed/simple;
	bh=k8YF0TexvZYUICH6jQOBBBzFlCevZ9XMPKUjp2Ay8qA=;
	h=Content-Type:Mime-Version:Subject:From:In-Reply-To:Date:Cc:
	 Message-Id:References:To; b=uD//v/H7D8PKadxow/zdrBDeyNMYsNLHizX9uzc4ybwpRQfbxvVXxCAVhewQfbEFGdptB6mprk2P2otSyIh6jyuG3fzFtAHhosgMMhb1M7oK52cd34+IdS12fXh1AYVXyICsVnPbboE/+Tg47yGomg8Vn9+8mK5K7gmH0TNBtFA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=bamaicloud.com; spf=none smtp.mailfrom=bamaicloud.com; arc=none smtp.client-ip=54.254.200.128
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=bamaicloud.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=bamaicloud.com
X-QQ-mid: esmtpgz11t1764586896tffa88e50
X-QQ-Originating-IP: 7Iz/aiWQq7+qhIE8oRQ+oRI9Iyx6tRCCjsQeX0WWbog=
Received: from smtpclient.apple ( [111.204.182.99])
	by bizesmtp.qq.com (ESMTP) with 
	id ; Mon, 01 Dec 2025 19:01:34 +0800 (CST)
X-QQ-SSF: 0000000000000000000000000000000
X-QQ-GoodBg: 0
X-BIZMAIL-ID: 14794200317869420372
Content-Type: text/plain;
	charset=utf-8
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
Mime-Version: 1.0 (Mac OS X Mail 16.0 \(3826.700.81\))
Subject: Re: [PATCH net-next v3 1/4] net: bonding: use workqueue to make sure
 peer notify updated in lacp mode
From: Tonghao Zhang <tonghao@bamaicloud.com>
In-Reply-To: <aS1ocogQc01owxSC@fedora>
Date: Mon, 1 Dec 2025 19:01:23 +0800
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
Message-Id: <7FEDE75E-551D-4B29-86A2-526AA3556CDC@bamaicloud.com>
References: <20251130074846.36787-1-tonghao@bamaicloud.com>
 <20251130074846.36787-2-tonghao@bamaicloud.com> <aS08d1dOC2EOvz-U@fedora>
 <AACE3A98-C0C0-4B24-BC29-B8EC3A758D90@bamaicloud.com>
 <aS1ocogQc01owxSC@fedora>
To: Hangbin Liu <liuhangbin@gmail.com>
X-Mailer: Apple Mail (2.3826.700.81)
X-QQ-SENDSIZE: 520
Feedback-ID: esmtpgz:bamaicloud.com:qybglogicsvrsz:qybglogicsvrsz3b-0
X-QQ-XMAILINFO: MpO6L0LObisWf97dfrZ2G8SbQZikz3xXznwqacXhK1joGf++44cJDrLX
	6NebScTyobvenqtKScIgRmStIQ7PANL3N5V5GzvciiIejvH2qbCL+bWFR06wDHJXkrXo0CJ
	4xqBg91PUolgA4ywPafKh1xCaW3oSQ04Htw5iwfn7E7ER7f4zCx/0js9HDtZTxczlz5+7sW
	0NQouIk8928SwAVRsNsvpFbmcj25nO4qjcNBsohWIWeRtpydiMHzfrI2FLJAn7rlAm7Jjci
	PYxM5VVZ0s7FehJ0c8BouA08NocfqFJyvr17i0jseMeVHsYS+4VGV0kjzODoqpr/JfVDIYE
	SCqYsgbOHR3sX5lhifIqVrUizxWiI12x6OqKQIhWJrVtNH66regklleM/KauvxRX3MpSjyZ
	BxXD3d4XT5b0GXVCq7eMCXxBnzBRFbwu2U172NjzDcaXfyDYPVao49o4YDBFz0FVTBstcAF
	yepEoJYYY4RJOJLxUJ9Mj4RXgHfNTWp3N0O6ctY9yd1CW07Q/rcEwMIfGBaa91d5Y2ZtuPU
	PpBYvG+MOG9OIrvfgNw4GA8aAcQREO+/fSRqiO+lTw9ArajpCOjXkpElLCgeO/RoN1TTKGe
	hpJGv5yqj9/rX1nvRegzSpMgsLGl+VzjPLJW2sE/57A7fqfLNe5pEiwxE052HjvWbV5/gjL
	1/3zce3IAgCMxAQ/3eU/CMMBNpe0kwrUWk8tgESEnNaDY10o51OFLvyhMHoCWs/hx41TA7r
	kcBV714NBVjhr8rk63L3yAtkrmnbAm50bkenatrl16++OWrKN9DFjLQ32o7m+tjDcbYJhVH
	Qr9XEw1uZWovsh9GxKc02oud0Wc0tsAuNV/fobO/C54qiWwJVj+n8FXGk4GY1YjD5Wd3a56
	c+VD6f949lsBjb3keRPgRPum9Q2hZLYFn4CtKIJtZz4aiAFG5HB1xUZXGNidR9UHM/nr6SR
	QkQIHljzJ0WUsgDZpHAW/bHFILKKWq0/PnAuOP9dilzgvsLr2o46NoaPQ4JBXQvWoOoRVus
	14Nmfz6ILn/k5K/gL+
X-QQ-XMRINFO: OWPUhxQsoeAVDbp3OJHYyFg=
X-QQ-RECHKSPAM: 0



> On Dec 1, 2025, at 18:05, Hangbin Liu <liuhangbin@gmail.com> wrote:
>=20
> On Mon, Dec 01, 2025 at 05:45:49PM +0800, Tonghao Zhang wrote:
>>>> * bond_change_active_slave - change the active slave into the =
specified one
>>>> * @bond: our bonding struct
>>>> @@ -1270,8 +1299,6 @@ void bond_change_active_slave(struct bonding =
*bond, struct slave *new_active)
>>>>     BOND_SLAVE_NOTIFY_NOW);
>>>>=20
>>>> if (new_active) {
>>>> - bool should_notify_peers =3D false;
>>>> -
>>>> bond_set_slave_active_flags(new_active,
>>>>   BOND_SLAVE_NOTIFY_NOW);
>>>>=20
>>>> @@ -1280,19 +1307,17 @@ void bond_change_active_slave(struct =
bonding *bond, struct slave *new_active)
>>>>     old_active);
>>>>=20
>>>> if (netif_running(bond->dev)) {
>>>> - bond->send_peer_notif =3D
>>>> - bond->params.num_peer_notif *
>>>> - max(1, bond->params.peer_notif_delay);
>>>> - should_notify_peers =3D
>>>> - bond_should_notify_peers(bond);
>>>> + bond_peer_notify_reset(bond);
>>>> +
>>>> + if (bond_should_notify_peers(bond)) {
>>>> + bond->send_peer_notif--;
>>>> + call_netdevice_notifiers(
>>>> + NETDEV_NOTIFY_PEERS,
>>>> + bond->dev);
>>>> + }
>>>> }
>>>>=20
>>>> call_netdevice_notifiers(NETDEV_BONDING_FAILOVER, bond->dev);
>>>> - if (should_notify_peers) {
>>>> - bond->send_peer_notif--;
>>>> - call_netdevice_notifiers(NETDEV_NOTIFY_PEERS,
>>>> - bond->dev);
>>>> - }
>>>> }
>>>> }
>>>=20
>>> I don=E2=80=99t see the benefit of moving NETDEV_NOTIFY_PEERS before =
NETDEV_BONDING_FAILOVER.
>>> Is there a specific reason or scenario where this ordering change is =
required?
>> No, to simplify the code, and use common peer notify reset function.
>=20
> bond_change_active_slave() is called under RTNL lock. We can use
> bond_peer_notify_reset() here. But I don't think there is a need to =
move
> NETDEV_NOTIFY_PEERS before NETDEV_BONDING_FAILOVER.
Is there a dependency relationship between NETDEV_NOTIFY_PEERS and =
NETDEV_BONDING_FAILOVER?
In vlan, macvlan, ipvlan netdev, NETDEV_NOTIFY_PEERS and =
NETDEV_BONDING_FAILOVER use the same action.
net/8021q/vlan.c
drivers/net/macvlan.c
drivers/net/ipvlan/ipvlan_main.c
>=20
> Thanks
> Hangbin
>=20
>=20


