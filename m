Return-Path: <netdev+bounces-193702-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E9D4DAC524B
	for <lists+netdev@lfdr.de>; Tue, 27 May 2025 17:47:32 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id B55521688B4
	for <lists+netdev@lfdr.de>; Tue, 27 May 2025 15:47:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A4EEC27A463;
	Tue, 27 May 2025 15:47:14 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from smtpbgjp3.qq.com (smtpbgjp3.qq.com [54.92.39.34])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 12E992522B4
	for <netdev@vger.kernel.org>; Tue, 27 May 2025 15:47:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=54.92.39.34
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1748360834; cv=none; b=RIuVr6vQP3V94/phueC5BnM/OnQ8VSEVmOV9louWNs4kau0vMxP8epvgqT09x2yvdQ1IRQ0JkULc5yA/8Tjhtv7lrvvkzJ9doJtOV1WUGg1qmzXTPa0+pu6PwqmWV6xW0s+SbUrvyrvSaspzGcVhcPZLk58o54ynCGmnlilxRjU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1748360834; c=relaxed/simple;
	bh=5VKzfNt2I1BuB8WrTlJh66grAA4b/yGfwXTwJGwY6kY=;
	h=Content-Type:Mime-Version:Subject:From:In-Reply-To:Date:Cc:
	 Message-Id:References:To; b=pz3YzS4DN88HKB40b+n037/lDOsP8l1Vdq9JLHoLGCT8M7ZcN94GfSx0koMG8MpVFDvY6DJNiQcDEJfNUS1ucRRsurPYvsmqsq4yljxxkVx9PEWoFOO4F2XmrY1Z1uZcLC8tOgKt/fcuWMYA7O493EMyF0T72LVZH9BVaxQMX3o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=bamaicloud.com; spf=pass smtp.mailfrom=bamaicloud.com; arc=none smtp.client-ip=54.92.39.34
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=bamaicloud.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bamaicloud.com
X-QQ-mid: zesmtpsz5t1748360785t850ea99c
X-QQ-Originating-IP: sNp7hPDpRUOFyguJi+l160212QmeO/1XYbBiNDAlXGY=
Received: from smtpclient.apple ( [111.201.145.100])
	by bizesmtp.qq.com (ESMTP) with 
	id ; Tue, 27 May 2025 23:46:22 +0800 (CST)
X-QQ-SSF: 0000000000000000000000000000000
X-QQ-GoodBg: 0
X-BIZMAIL-ID: 11200248945312191761
Content-Type: text/plain;
	charset=utf-8
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
Mime-Version: 1.0 (Mac OS X Mail 16.0 \(3826.400.131.1.6\))
Subject: Re: [PATCH RESEND net-next v5 3/4] net: bonding: send peer notify
 when failure recovery
From: Tonghao Zhang <tonghao@bamaicloud.com>
In-Reply-To: <8865be45-e3a8-479e-b98a-b06e5ed6ee65@redhat.com>
Date: Tue, 27 May 2025 23:46:12 +0800
Cc: netdev@vger.kernel.org,
 Jay Vosburgh <jv@jvosburgh.net>,
 "David S. Miller" <davem@davemloft.net>,
 Eric Dumazet <edumazet@google.com>,
 Jakub Kicinski <kuba@kernel.org>,
 Simon Horman <horms@kernel.org>,
 Jonathan Corbet <corbet@lwn.net>,
 Andrew Lunn <andrew+netdev@lunn.ch>,
 Steven Rostedt <rostedt@goodmis.org>,
 Masami Hiramatsu <mhiramat@kernel.org>,
 Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
 Nikolay Aleksandrov <razor@blackwall.org>,
 Zengbing Tu <tuzengbing@didiglobal.com>
Content-Transfer-Encoding: quoted-printable
Message-Id: <7D86A40E-5B09-4ED6-A836-A3DB8050020C@bamaicloud.com>
References: <20250522085516.16355-1-tonghao@bamaicloud.com>
 <20250522085516.16355-4-tonghao@bamaicloud.com>
 <8865be45-e3a8-479e-b98a-b06e5ed6ee65@redhat.com>
To: Paolo Abeni <pabeni@redhat.com>
X-Mailer: Apple Mail (2.3826.400.131.1.6)
X-QQ-SENDSIZE: 520
Feedback-ID: zesmtpsz:bamaicloud.com:qybglogicsvrsz:qybglogicsvrsz4a-0
X-QQ-XMAILINFO: ODsO5K7oJDFnqOmd8G7lX5ItJqxsmYAmwy54nULeLdZ0DXr/EXYyk5QU
	vFTJQs8JNAmC11nU+uQrwTcrEIJdYs1yvQn1nON6XF/CFMpo67JpSy0cQFabcTHDX7nSSNW
	5MI/FEnzRXE7ViJ0G0J38yA1FCBkddD88CXvON2wykxRqH+drsmdB1ddOVocyBkc+0EdXju
	KC6kpUaTAVGRYRgJEp69TlKUM/s2wcn//M2BN/hCJdkf60cx3fyGMlyfAXJkxW6NpGu9Xg2
	m2KOdJQGVshEd6HwgYkhPt/JauVQfRZVXU3aG74QUnQMNfE9w2Ds4gau/qM0OR7/dRF1dG5
	deUblJtGvW6M2aYQbqUkrxVjpjq2XF/oeXc4RwLD4Q4NUR8fdLNTFm/UBl/xIaQv5oqG4C2
	QUXa0Xgt2S9MGxkajdPMX3vBv+8DfNY4Nlwsd/59xUCVaELtAvFTNGQHqszFN9CqzIdQSlY
	92eqYo5Z9shsLr/+acv9W1yDvy2rg1WhCZKw6Amom9YZkUk9E9Zz2x0zNH4LSOX3rn/2NFT
	dCeKAl+951wllSlep1JtFY0Lm5cTtKpiCJlBQ8xE6SRNhRgXJsPrfiSc2B1l4FG99HpRJAk
	DDgUiCB1T1kq0C22dpdJlRA8u+5iOCwh8NcRYPsEGeRWDBVVwgFLe89Vqz/vmL8rHSp7R8r
	BODJGGHO2hqEDEL+1z+5+67hIoT1OkcbUsDQBf1q9ZGXKddlqdSZy59lY8rLuI9FDmSRyxi
	EKQwtq2wzHrei53PLrklxTPtX2KpCj+1Z+ytzrarF7dfMaWNKI1K/LUTqmf5l2r0hNNz0fk
	/2+aMoDy/AR3vP8YmVMc8A+81bxgJC3H7Xn+ueUJkMVIPs0Hm5i8txpz3UUyowMyPSOSTqi
	9qYdgYFWHIn/FAhhJuDjo6NwyYkwbArm8sAbfKYQtkRDwsgp0+UE8HGXBpGMJgG+T4ALhM4
	mIy6kchCEyocMLAIsM6PdXLvvVYuQxhrzU2Hu/pYzi+AfEZGPVSRh5xaaCR2q7aYNnw02ir
	oeqlswhObGTEZ603l5
X-QQ-XMRINFO: M/715EihBoGSf6IYSX1iLFg=
X-QQ-RECHKSPAM: 0



> 2025=E5=B9=B45=E6=9C=8827=E6=97=A5 22:09=EF=BC=8CPaolo Abeni =
<pabeni@redhat.com> =E5=86=99=E9=81=93=EF=BC=9A
>=20
> On 5/22/25 10:55 AM, Tonghao Zhang wrote:
>> diff --git a/drivers/net/bonding/bond_main.c =
b/drivers/net/bonding/bond_main.c
>> index b5c34d7f126c..7f03ca9bcbba 100644
>> --- a/drivers/net/bonding/bond_main.c
>> +++ b/drivers/net/bonding/bond_main.c
>> @@ -1242,17 +1242,28 @@ static struct slave =
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
>>    bond->send_peer_notif %
>>    max(1, bond->params.peer_notif_delay) !=3D 0 ||
>> -    !netif_carrier_ok(bond->dev) ||
>> -    test_bit(__LINK_STATE_LINKWATCH_PENDING, &slave->dev->state))
>> +    !netif_carrier_ok(bond->dev))
>> return false;
>>=20
>> + if (BOND_MODE(bond) =3D=3D BOND_MODE_8023AD) {
>> + usable =3D rcu_dereference_rtnl(bond->usable_slaves);
>> + if (!usable || !READ_ONCE(usable->count))
>> + return false;
>=20
> The above unconditionally changes the current behavior for
> BOND_MODE_8023AD regardless of the `broadcast_neighbor` value. Why the
> new behavior is not conditioned by broadcast_neighbor =3D=3D true?
In active-backup or lacp mode, we can the  change send_peer_notif, so we =
check send_peer_notif firstly in this fuction. This is common function =
for sending ARP/ND packets.=20
For lacp mode, if usable_slaves is null, so unnecessarily sending ARP/ND =
packets, and we change send_peer_notif in mux state and add the comment =
in patch 3.

--- a/drivers/net/bonding/bond_3ad.c
+++ b/drivers/net/bonding/bond_3ad.c
@@ -982,6 +982,17 @@ static int ad_marker_send(struct port *port, struct =
bond_marker *marker)
        return 0;
 }

+static void ad_cond_set_peer_notif(struct port *port)
+{
+       struct bonding *bond =3D port->slave->bond;
+
+       if (bond->params.broadcast_neighbor && rtnl_trylock()) {
+               bond->send_peer_notif =3D bond->params.num_peer_notif *
+                       max(1, bond->params.peer_notif_delay);
+               rtnl_unlock();
+       }
+}
+
 /**
  * ad_mux_machine - handle a port's mux state machine
  * @port: the port we're looking at
@@ -2061,6 +2072,8 @@ static void =
ad_enable_collecting_distributing(struct port *port,
                __enable_port(port);
                /* Slave array needs update */
                *update_slave_arr =3D true;
+               /* Should notify peers if possible */
+               ad_cond_set_peer_notif(port);
        }
 }
=20
>=20
> At least a code comment is deserved.
>=20
> Thanks,
>=20
> Paolo
>=20
>=20
>=20


