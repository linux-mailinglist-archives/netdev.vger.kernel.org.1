Return-Path: <netdev+bounces-198540-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id AE97AADC9A3
	for <lists+netdev@lfdr.de>; Tue, 17 Jun 2025 13:40:27 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 4DE3D178B81
	for <lists+netdev@lfdr.de>; Tue, 17 Jun 2025 11:40:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 42A7A2DF3C1;
	Tue, 17 Jun 2025 11:40:25 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from smtpbgeu2.qq.com (smtpbgeu2.qq.com [18.194.254.142])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7764F1EDA3C
	for <netdev@vger.kernel.org>; Tue, 17 Jun 2025 11:40:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=18.194.254.142
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750160425; cv=none; b=JCtD47wRbLcl5LQf/DnfRB5zFsUUhIbEYa3Km27j/EEu2/NpUN/YvZU3NpESu7KClpjzveGLXyMipI6D/1yrtv9ECP1EXmIOmSbZ1j2UF6MPJHM13LxKxILOX7hsjIWkWeXjVB8LzEcJst365kj+mPgbW7PRZWF3cC0oIMYw5e8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750160425; c=relaxed/simple;
	bh=pQVEUN/gPDpJst8by8S69bN8fit2PMpNZ3mdXuwTddM=;
	h=Content-Type:Mime-Version:Subject:From:In-Reply-To:Date:Cc:
	 Message-Id:References:To; b=Jn8PJvPcaXA3ATZjF03O6gKMn/FCs9NDyAVFifEDJ0qzitb7yd2tdoXWeatczz3u3rhjdWIpiGAsi7aCtI1FxeW1ApvixX0x9RzPKduL7vbiMA9bpRy3UDALm/P8GmnbNyzsBxEoPltRarWPsoP1I9L5J4DiPm558kR/cq6SGbg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=bamaicloud.com; spf=pass smtp.mailfrom=bamaicloud.com; arc=none smtp.client-ip=18.194.254.142
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=bamaicloud.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bamaicloud.com
X-QQ-mid: zesmtpgz6t1750160357t94d16e2c
X-QQ-Originating-IP: B/aYg/ntnd4MNrLCxAjeelwhu8FiS07w5hdTUsJ3o54=
Received: from smtpclient.apple ( [111.202.70.102])
	by bizesmtp.qq.com (ESMTP) with 
	id ; Tue, 17 Jun 2025 19:39:14 +0800 (CST)
X-QQ-SSF: 0000000000000000000000000000000
X-QQ-GoodBg: 0
X-BIZMAIL-ID: 15771769124630019725
EX-QQ-RecipientCnt: 15
Content-Type: text/plain;
	charset=utf-8
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
Mime-Version: 1.0 (Mac OS X Mail 16.0 \(3826.600.51.1.1\))
Subject: Re: [net-next v6 3/4] net: bonding: send peer notify when failure
 recovery
From: Tonghao Zhang <tonghao@bamaicloud.com>
In-Reply-To: <EB500915-0C30-4491-8709-80894B771EC4@bamaicloud.com>
Date: Tue, 17 Jun 2025 19:39:04 +0800
Cc: netdev@vger.kernel.org,
 "David S. Miller" <davem@davemloft.net>,
 Eric Dumazet <edumazet@google.com>,
 Jakub Kicinski <kuba@kernel.org>,
 Paolo Abeni <pabeni@redhat.com>,
 Simon Horman <horms@kernel.org>,
 Jonathan Corbet <corbet@lwn.net>,
 Andrew Lunn <andrew+netdev@lunn.ch>,
 Steven Rostedt <rostedt@goodmis.org>,
 Masami Hiramatsu <mhiramat@kernel.org>,
 Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
 Nikolay Aleksandrov <razor@blackwall.org>,
 Zengbing Tu <tuzengbing@didiglobal.com>,
 Tonghao Zhang <tonghao@bamaicloud.com>
Content-Transfer-Encoding: quoted-printable
Message-Id: <5FC20461-E971-4469-B4D5-CEFB3B61CB44@bamaicloud.com>
References: <cover.1749525581.git.tonghao@bamaicloud.com>
 <81185ef7f9227cff906903fe8e74258727529491.1749525581.git.tonghao@bamaicloud.com>
 <1931522.1750120618@famine>
 <EB500915-0C30-4491-8709-80894B771EC4@bamaicloud.com>
To: jv@jvosburgh.net
X-Mailer: Apple Mail (2.3826.600.51.1.1)
X-QQ-SENDSIZE: 520
Feedback-ID: zesmtpgz:bamaicloud.com:qybglogicsvrsz:qybglogicsvrsz4a-0
X-QQ-XMAILINFO: MsL7hwqo9bYsO677DhYg8Aud70VtDBx+KTPTpBDvvexw99XzvNHQmGdH
	c/6KoFwCDNACzyktlg8EI2POrB23m8ElD5Uj6RdZwgglQC2QinJORxd3c7EaYIw+zKske1H
	HvXCr53IHiePORmyvRBF9XrpGnVecYjRKE9ER9MmYcCP1v7hzLIt/h8Il72Paj4g5XiHvh+
	/i32QDv98VPCeU6NYxbPowwYLIBsJ8GuWLUBJuYisBeXzu/Qjdiqde4CjlDsoZCWNaogZHI
	HnlXylRp/Eiqo2AIBUMhW3SZakCZaAiF43G8wVKtEh75Pjn38fQ99033EqHNQHhTjjT1U4r
	Ii7eiBjLHuovge1yeNAgwSQWl1z1wcGn5n+UdeybfuQcMtCKjsZIx7pTG8+z9IZ2aHkl/nL
	yFqW5aO5zvuOwFD52LKRngfXtKomtTtzSxK/x4y8RFRB3MNPQynzYBlvqrXPp1EU9zOdtQj
	7347A1djk94OClp1Kb+oIji8fLUKdIRxwkATmZbKKAIEn263LiQFUTn+f0itfHalSlwRjjb
	Spg2jgRKfmwcOg/KKev5XbpSBsRtY/5DN3c3AJ9iajA03toTo/A5HfX2OrEBhhijkO2x66e
	7LhVppnrZEGAXfJOJwOPx86Pm04cd/7tqmyxXHXTJJJYSFZXgvq+w/5f7yyninqfccQqZyk
	+3kEgVGBtX3d6G0ouesKBskNZEAiFrt2UZJ6Dqk76QJSe6JZjv4xbVsjYbln9kJewu2fDqZ
	uinI9R8KxQBpAxoZH6MepYr8P+BoGFqGkiRTWPT2m/7hJShQA2Jzmml6Qe1feXvIwWvxsos
	UvASYYDV0QvLIJF2tsJ+WZcG1yEEdPqq/FX2kTwT7hJTPmtO+7loJZkx2fNxNl72W9cfslx
	/Gnt1qrVEJCp7bxF1/qq7aZeKuVr3lvIkMVySfeaZXvnBCKvqg+TNZH4UFFzM+k6YJoiA1N
	ju17gjC25uNuO9JvyPNRRvpLHcflbgv6JsNTWwMqsXxeFmNSkVhZNTuq2dL8semG79SM=
X-QQ-XMRINFO: MPJ6Tf5t3I/ycC2BItcBVIA=
X-QQ-RECHKSPAM: 0



> 2025=E5=B9=B46=E6=9C=8817=E6=97=A5 18:47=EF=BC=8CTonghao Zhang =
<tonghao@bamaicloud.com> =E5=86=99=E9=81=93=EF=BC=9A
>=20
>=20
>=20
>> 2025=E5=B9=B46=E6=9C=8817=E6=97=A5 08:36=EF=BC=8CJay Vosburgh =
<jv@jvosburgh.net> =E5=86=99=E9=81=93=EF=BC=9A
>>=20
>> Tonghao Zhang <tonghao@bamaicloud.com> wrote:
>>=20
>>> After LACP protocol recovery, the port can transmit packets.
>>> However, if the bond port doesn't send gratuitous ARP/ND
>>> packets to the switch, the switch won't return packets through
>>> the current interface. This causes traffic imbalance. To resolve
>>> this issue, when LACP protocol recovers, send ARP/ND packets.
>>=20
>> I think the description above needs to mention that the
>> gratuitous ARP/ND only happens if broadcast_neighbor is enabled.
> Ok, thanks
>>=20
>> I'll note that the documentation update does include this
>> caveat.
>>=20
>>> Cc: Jay Vosburgh <jv@jvosburgh.net>
>>> Cc: "David S. Miller" <davem@davemloft.net>
>>> Cc: Eric Dumazet <edumazet@google.com>
>>> Cc: Jakub Kicinski <kuba@kernel.org>
>>> Cc: Paolo Abeni <pabeni@redhat.com>
>>> Cc: Simon Horman <horms@kernel.org>
>>> Cc: Jonathan Corbet <corbet@lwn.net>
>>> Cc: Andrew Lunn <andrew+netdev@lunn.ch>
>>> Cc: Steven Rostedt <rostedt@goodmis.org>
>>> Cc: Masami Hiramatsu <mhiramat@kernel.org>
>>> Cc: Mathieu Desnoyers <mathieu.desnoyers@efficios.com>
>>> Cc: Nikolay Aleksandrov <razor@blackwall.org>
>>> Signed-off-by: Tonghao Zhang <tonghao@bamaicloud.com>
>>> Signed-off-by: Zengbing Tu <tuzengbing@didiglobal.com>
>>> Reviewed-by: Nikolay Aleksandrov <razor@blackwall.org>
>>> ---
>>> Documentation/networking/bonding.rst |  5 +++--
>>> drivers/net/bonding/bond_3ad.c       | 13 +++++++++++++
>>> drivers/net/bonding/bond_main.c      | 21 ++++++++++++++++-----
>>> 3 files changed, 32 insertions(+), 7 deletions(-)
>>>=20
>>> diff --git a/Documentation/networking/bonding.rst =
b/Documentation/networking/bonding.rst
>>> index 14f7593d888d..f8f5766703d4 100644
>>> --- a/Documentation/networking/bonding.rst
>>> +++ b/Documentation/networking/bonding.rst
>>> @@ -773,8 +773,9 @@ num_unsol_na
>>> greater than 1.
>>>=20
>>> The valid range is 0 - 255; the default value is 1.  These options
>>> - affect only the active-backup mode.  These options were added for
>>> - bonding versions 3.3.0 and 3.4.0 respectively.
>>> + affect the active-backup or 802.3ad (broadcast_neighbor enabled) =
mode.
>>> + These options were added for bonding versions 3.3.0 and 3.4.0
>>> + respectively.
>>>=20
>>> =46rom Linux 3.0 and bonding version 3.7.1, these notifications
>>> are generated by the ipv4 and ipv6 code and the numbers of
>>> diff --git a/drivers/net/bonding/bond_3ad.c =
b/drivers/net/bonding/bond_3ad.c
>>> index c6807e473ab7..d1c2d416ac87 100644
>>> --- a/drivers/net/bonding/bond_3ad.c
>>> +++ b/drivers/net/bonding/bond_3ad.c
>>> @@ -982,6 +982,17 @@ static int ad_marker_send(struct port *port, =
struct bond_marker *marker)
>>> return 0;
>>> }
>>>=20
>>> +static void ad_cond_set_peer_notif(struct port *port)
>>> +{
>>> + struct bonding *bond =3D port->slave->bond;
>>> +
>>> + if (bond->params.broadcast_neighbor && rtnl_trylock()) {
>>> + bond->send_peer_notif =3D bond->params.num_peer_notif *
>>> + max(1, bond->params.peer_notif_delay);
>>> + rtnl_unlock();
>>> + }
>>> +}
>>> +
>>> /**
>>> * ad_mux_machine - handle a port's mux state machine
>>> * @port: the port we're looking at
>>> @@ -2061,6 +2072,8 @@ static void =
ad_enable_collecting_distributing(struct port *port,
>>> __enable_port(port);
>>> /* Slave array needs update */
>>> *update_slave_arr =3D true;
>>> + /* Should notify peers if possible */
>>> + ad_cond_set_peer_notif(port);
>>> }
>>> }
>>>=20
>>> diff --git a/drivers/net/bonding/bond_main.c =
b/drivers/net/bonding/bond_main.c
>>> index 12046ef51569..0acece55d9cb 100644
>>> --- a/drivers/net/bonding/bond_main.c
>>> +++ b/drivers/net/bonding/bond_main.c
>>> @@ -1237,17 +1237,28 @@ static struct slave =
*bond_find_best_slave(struct bonding *bond)
>>> /* must be called in RCU critical section or with RTNL held */
>>> static bool bond_should_notify_peers(struct bonding *bond)
>>> {
>>> - struct slave *slave =3D =
rcu_dereference_rtnl(bond->curr_active_slave);
>>> + struct bond_up_slave *usable;
>>> + struct slave *slave =3D NULL;
>>>=20
>>> - if (!slave || !bond->send_peer_notif ||
>>> + if (!bond->send_peer_notif ||
>>>    bond->send_peer_notif %
>>>    max(1, bond->params.peer_notif_delay) !=3D 0 ||
>>> -     !netif_carrier_ok(bond->dev) ||
>>> -     test_bit(__LINK_STATE_LINKWATCH_PENDING, &slave->dev->state))
>>> +     !netif_carrier_ok(bond->dev))
>>> return false;
>>>=20
>>> + if (BOND_MODE(bond) =3D=3D BOND_MODE_8023AD) {
>>> + usable =3D rcu_dereference_rtnl(bond->usable_slaves);
>>> + if (!usable || !READ_ONCE(usable->count))
>>> + return false;
>>> + } else {
>>> + slave =3D rcu_dereference_rtnl(bond->curr_active_slave);
>>> + if (!slave || test_bit(__LINK_STATE_LINKWATCH_PENDING,
>>> +        &slave->dev->state))
>>> + return false;
>>> + }
>>> +
>>> netdev_dbg(bond->dev, "bond_should_notify_peers: slave %s\n",
>>> -    slave ? slave->dev->name : "NULL");
>>> +    slave ? slave->dev->name : "all");
>>=20
>> Is it actually correct that if slave =3D=3D NULL, the notify peers
>> logic will send to all ports?  I'm not sure why this changed.
> when bond is lacp mode, and send_peer_notif > 0, usable_slaves > 0, =
then slave =3D=3D NULL, the debug log will print info =
"bond_should_notify_peers: slave all=E2=80=9D.
In lacp mode, when broadcast_neighbor enabled, send_peer_notif will be =
set in ad_cond_set_peer_notif.
>=20
> In active-backup mode, slave is not NULL, that means =
"bond_should_notify_peers: slave xx".
>>=20
>> -J
>>=20
>>>=20
>>> return true;
>>> }
>>> --=20
>>> 2.34.1
>>=20
>> ---
>> -Jay Vosburgh, jv@jvosburgh.net



