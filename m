Return-Path: <netdev+bounces-242925-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id EE2CAC9673E
	for <lists+netdev@lfdr.de>; Mon, 01 Dec 2025 10:48:23 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 6B1324E22CA
	for <lists+netdev@lfdr.de>; Mon,  1 Dec 2025 09:46:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0E58A2F3617;
	Mon,  1 Dec 2025 09:46:27 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from smtpbgeu2.qq.com (smtpbgeu2.qq.com [18.194.254.142])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4159D19995E
	for <netdev@vger.kernel.org>; Mon,  1 Dec 2025 09:46:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=18.194.254.142
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1764582386; cv=none; b=WHktr7qsVxh3rLjHqxuFY7wiRfCZwn5kMkvS3pYtNCFEqO54cE27+Qv+05eis0J55rsXRACKNNSxZfMe9tTtyvWeTP/Vvfn78LN3vk5WP57y2dRy5auqx2XystWk90N7/JmZcPn3Mup7ZjF0nmR+QxYfJVno25FlWwH/nHkIpIU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1764582386; c=relaxed/simple;
	bh=5Y0hn8nkC9LGTZ5XMDIQh8dVhWoWNGPaBgfxjGxZ/iw=;
	h=Content-Type:Mime-Version:Subject:From:In-Reply-To:Date:Cc:
	 Message-Id:References:To; b=KpjfEpDS8foz6Ys4q78zvczhKAh4vrr1Zd4gRCLG/q6aTRlti3Qou0idL9u1wTaQCr626S92034ooZ17DnJmDOj4Fux6YNWs90cVZ9yYKtPX7VmnGE/c2JSbX63TAMpwcE/uRz1RVHpTy8qHExHSvLQtLpsIs6fQaPdEJcYxZ88=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=bamaicloud.com; spf=none smtp.mailfrom=bamaicloud.com; arc=none smtp.client-ip=18.194.254.142
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=bamaicloud.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=bamaicloud.com
X-QQ-mid: zesmtpgz3t1764582361t9faf1c1e
X-QQ-Originating-IP: AeS33ztC4eLIv/8DAggTKYwHgPU4rvN/WNgW5d9WlIE=
Received: from smtpclient.apple ( [111.204.182.99])
	by bizesmtp.qq.com (ESMTP) with 
	id ; Mon, 01 Dec 2025 17:45:59 +0800 (CST)
X-QQ-SSF: 0000000000000000000000000000000
X-QQ-GoodBg: 0
X-BIZMAIL-ID: 4488293634609648182
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
In-Reply-To: <aS08d1dOC2EOvz-U@fedora>
Date: Mon, 1 Dec 2025 17:45:49 +0800
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
Message-Id: <AACE3A98-C0C0-4B24-BC29-B8EC3A758D90@bamaicloud.com>
References: <20251130074846.36787-1-tonghao@bamaicloud.com>
 <20251130074846.36787-2-tonghao@bamaicloud.com> <aS08d1dOC2EOvz-U@fedora>
To: Hangbin Liu <liuhangbin@gmail.com>
X-Mailer: Apple Mail (2.3826.700.81)
X-QQ-SENDSIZE: 520
Feedback-ID: zesmtpgz:bamaicloud.com:qybglogicsvrsz:qybglogicsvrsz3b-0
X-QQ-XMAILINFO: MX+1SEN3H+wA6OistimiH0VjHGl/NkxNuFPcQ8+1UVx7B6MOu5igg1x4
	eOI82r3hays0divj0O/wFrZzVQ3uiS7g4i9sJjfzgUThEIC22wUhFV+bVfwGHbxhbgX5R4q
	LcnN0lVMaTDeyWEb9HlSjJ1nW6HkxRyjxAQj1G7YpvgfzqpSvgCv03Rl9MK8qpNQ8dcdYR+
	vevIRa1eJ0xQhYUt2ApMGyA585k3GhEWeD9jgocmVKwoU3Vvl0PzlbFe7ELPjhMKxxSpUOj
	52ocP7e+aS+p5VWldX0XXeS9psLGNdoSL9yoFpPv0ZyaEil9np3q6PnplY27Y/ZcO+I3bT7
	KV5k50bsnTYafy+RianJJYCJ3oS581sGhXp4a0jGh2EZJ4pSSqZQ7z+iCEFhCGxZxd4+9FH
	bUSCe1wYfhLjXKVPGlkDK0cKFuM7AioyYbJ9z+mRpMSQzSgLHbYHtV2RY2rX+8n1fBvPTdB
	7bOhr2p1M4/bpAJJEI4w+gt8qGEQvqBJ0a0nUtclzoGYGDixKahBgRUM5CaJXMxxZ3TZyzX
	2eAeyX5CIlqSK9bP3yi4IJQgjVkDf71HD6z+inMWhWCMJDTEqSTu8KUFbyR8pzuol4CydGM
	kRffMBfZf8MkXoMr9pIhXIXqT3/nW9Fy16ZQBsM2bdu5ljaseNf0uSjGfEmEIoWsrgkWSQp
	ENxAoBm8LNhtZR+9vvzto//uBiie3bLx8tsBjzqM+t9HdppYG+NDa1e77fq8npJvDtD+J22
	BOSI+lJLRjuolhdq79jHmvWrorNIKZAnXa2VKEVTQihDEjGWw7lGbTJX7U8yRsYfodD6ohC
	gJesssilInr/+ekRRJRnPeDTIXQNmhX+mPtZvtRP7ZWf3Giguy13N9mziI2Cs+c3/jkyk/W
	TuWzBt3jvmSsq6C5Om9DwfyIusKTsZ12eCBuNGcnsSi1eZbjTwVOXHQ/RbOO3JzRUKhrC1W
	Keq6wQW5DxzF73u6c7PncnaKm0xw/zwO9zQ6gVCezYSFs0PmXDPpw2AJVNUVZHQtJKKg7y4
	To4NwALNhPWfX+hpio84WYe/l6mTc=
X-QQ-XMRINFO: MPJ6Tf5t3I/ycC2BItcBVIA=
X-QQ-RECHKSPAM: 0



> On Dec 1, 2025, at 14:57, Hangbin Liu <liuhangbin@gmail.com> wrote:
>=20
> Hi Tonghao,
> On Sun, Nov 30, 2025 at 03:48:43PM +0800, Tonghao Zhang wrote:
>> ---
>> v1:
>> - This patch is actually version v3, =
https://patchwork.kernel.org/project/netdevbpf/patch/20251118090305.35558-=
1-tonghao@bamaicloud.com/
>> - add a comment why we use the trylock.
>> - add this patch to series
>> ---
>=20
> I think you can move the change logs to cover letter.
>=20
>> /**
>>  * bond_change_active_slave - change the active slave into the =
specified one
>>  * @bond: our bonding struct
>> @@ -1270,8 +1299,6 @@ void bond_change_active_slave(struct bonding =
*bond, struct slave *new_active)
>>      BOND_SLAVE_NOTIFY_NOW);
>>=20
>> if (new_active) {
>> - bool should_notify_peers =3D false;
>> -
>> bond_set_slave_active_flags(new_active,
>>    BOND_SLAVE_NOTIFY_NOW);
>>=20
>> @@ -1280,19 +1307,17 @@ void bond_change_active_slave(struct bonding =
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
>> + bond->send_peer_notif--;
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
>=20
> I don=E2=80=99t see the benefit of moving NETDEV_NOTIFY_PEERS before =
NETDEV_BONDING_FAILOVER.
> Is there a specific reason or scenario where this ordering change is =
required?
No, to simplify the code, and use common peer notify reset function.
>=20
> Thanks
> Hangbin
>=20
>=20


