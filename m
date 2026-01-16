Return-Path: <netdev+bounces-250405-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 7219BD2A4F4
	for <lists+netdev@lfdr.de>; Fri, 16 Jan 2026 03:46:30 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 78D81301D30B
	for <lists+netdev@lfdr.de>; Fri, 16 Jan 2026 02:46:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BB9AA33EAFE;
	Fri, 16 Jan 2026 02:46:27 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from smtpbgbr2.qq.com (smtpbgbr2.qq.com [54.207.22.56])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0655D33E37B
	for <netdev@vger.kernel.org>; Fri, 16 Jan 2026 02:46:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=54.207.22.56
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768531586; cv=none; b=qjKkThFNOkW78R9lavfUIt0yxAzNc3n/aGh9g/N/DQ/Qd+mnJFlXCpA4EKfOrzAbRGsrqbGD6hv0UG3jzz8XqblEmpE8d0l/pYFZFvtBk6KP649oXT0e07+Fks5zkuRzCAC/rJyQeURBJtCLo9PlIvTjcIsHi7MSmxlp48i1BJw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768531586; c=relaxed/simple;
	bh=fDxqUTJ5a422b1iXBItAoMyTXHF8QiMOXih+SPw61Dg=;
	h=Content-Type:Mime-Version:Subject:From:In-Reply-To:Date:Cc:
	 Message-Id:References:To; b=ijO45Nwe+E9KOuRukBT3fNRPAnUpKZQqUqsgd/MdN12VFxZGJQPnCMnBBrcA2M5HvBGLFo2N1gAu5bx5rmdSPG8dckKyIuDpeIaibRZeYkc5clXzbZLdRvFqFcLRFh02vU4TjE9KgbZgNB8Adal/Kq+V54fyZ03HqdVuYcX+fxI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=bamaicloud.com; spf=pass smtp.mailfrom=bamaicloud.com; arc=none smtp.client-ip=54.207.22.56
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=bamaicloud.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bamaicloud.com
X-QQ-mid: zesmtpgz5t1768531557tc239c1ea
X-QQ-Originating-IP: UdlMbTbSi6nEeY5pCdSTA2V2jNTtq4lzP7k+iCZPq0c=
Received: from smtpclient.apple ( [111.202.70.101])
	by bizesmtp.qq.com (ESMTP) with 
	id ; Fri, 16 Jan 2026 10:45:55 +0800 (CST)
X-QQ-SSF: 0000000000000000000000000000000
X-QQ-GoodBg: 0
X-BIZMAIL-ID: 595557629738534240
Content-Type: text/plain;
	charset=us-ascii
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
Mime-Version: 1.0 (Mac OS X Mail 16.0 \(3826.700.81.1.4\))
Subject: Re: [PATCH RESEND net-next v4 1/4] net: bonding: use workqueue to
 make sure peer notify updated in lacp mode
From: Tonghao Zhang <tonghao@bamaicloud.com>
In-Reply-To: <d3624dc9-848a-4c59-84d2-8663f0827937@redhat.com>
Date: Fri, 16 Jan 2026 10:45:44 +0800
Cc: netdev@vger.kernel.org,
 Jay Vosburgh <jv@jvosburgh.net>,
 "David S. Miller" <davem@davemloft.net>,
 Eric Dumazet <edumazet@google.com>,
 Jakub Kicinski <kuba@kernel.org>,
 Simon Horman <horms@kernel.org>,
 Jonathan Corbet <corbet@lwn.net>,
 Andrew Lunn <andrew+netdev@lunn.ch>,
 Nikolay Aleksandrov <razor@blackwall.org>,
 Hangbin Liu <liuhangbin@gmail.com>,
 Jason Xing <kerneljasonxing@gmail.com>
Content-Transfer-Encoding: quoted-printable
Message-Id: <487B5F85-0D9F-42B3-B9EB-E3DCFB09A35D@bamaicloud.com>
References: <cover.1768184929.git.tonghao@bamaicloud.com>
 <895aa5609ef5be99150b4f3579ac0aa96ed083a7.1768184929.git.tonghao@bamaicloud.com>
 <d3624dc9-848a-4c59-84d2-8663f0827937@redhat.com>
To: Paolo Abeni <pabeni@redhat.com>
X-Mailer: Apple Mail (2.3826.700.81.1.4)
X-QQ-SENDSIZE: 520
Feedback-ID: zesmtpgz:bamaicloud.com:qybglogicsvrsz:qybglogicsvrsz3b-0
X-QQ-XMAILINFO: MShfLn39PbN2d325jm3EO+FhmXd2Tb1cPBObQkhKQNOnO13luWZaeqPz
	ahTnCmnI6PjxvGO61hmn9/JmAjLyDSh1qU/c/wSDoNXdJySe5AUcl3N8zP6u2bdBXP4wiJR
	m//GCoyAolTeMbEI2qR3kIG5przt7GQSicQADPzlrpYShvZNmqKExKwELc41EGkx1DKjp+M
	8Idg2kn+fQvhC+C6l3whDj2H0xX4PNmTzFYFHTrggWR5VeKF19jLE5+jQjlNXjIvo/d6bOH
	fHQofAfNiLuAzwzTcqjNKG+uVj6bqg0VBfc2WXiQxtk+6jgqBzn7opscj/Lt/v+a463Szzz
	Zh6/GZaiCfU5Zxkky6/OQeMYpiZTNiamevix+iCrpfbf9ljoHmO1zlTj0OnafWvvIONKejU
	F/uCiq59l2oNiCN2YEI1uXy/p8VBfong4N3JVAnvXdePnRqg0MLNSspiwDqBVUB1p1wfPhX
	eo7/+JsRr456CfA7/Uaq2IfRIEsZ5XVetih1sIoBy1syndKZto/lGoTnqvCITpjuvcVE0F1
	TiY8blqAFTBSDJH2a2EsII7In9tLsjUD6C/vi3IzafL0H9rf+atu6GGYvrthw4TVdPmuzDN
	OxoMv6iE8D6o8Mp4yQKVLftoMYsqzaospYYQknwtFwlDwJ2A82Xvc+m+5/lILGr9VkytuwJ
	OqDaAQ69X92aAgMcFKWQ5/2LuCJ5kku8MfkiV66aJ0Q8FHZBU8kBixYansl5h4rjKDDWs7N
	4+nYuXtkvG+YqmpCtpvrl0ZrZ9dibXYVbQ1WMWvFiOZ0v5uRXhj9N3Skj/WFIbgOLEvSyLt
	a3XlqKHE10WqhvmKUhmzsO/Xskv0PwcMtwsAqUcIXwZgeJE2ptNIjj8nN396q37eZwE70Ql
	DKENjDbfKLSPgL0ka6/tgLdo1IyCwb0cP6jv3M1tu8V3Z6r/RujTaJUdn2gEk0jNChToVoD
	fu9vD1Oyu0qKODP/EFA3eLNMHv4An2WRMkq1T4Qud8/TANuuu6M1IOSaHcYCIJYchLxfejk
	Al1U0j6sv/mQpH9g6d
X-QQ-XMRINFO: NI4Ajvh11aEjEMj13RCX7UuhPEoou2bs1g==
X-QQ-RECHKSPAM: 0



> On Jan 15, 2026, at 18:46, Paolo Abeni <pabeni@redhat.com> wrote:
>=20
> On 1/12/26 3:40 AM, Tonghao Zhang wrote:
>> +static void bond_peer_notify_handler(struct work_struct *work)
>> +{
>> + struct bonding *bond =3D container_of(work, struct bonding,
>> +    peer_notify_work.work);
>> +
>> + if (!rtnl_trylock()) {
>> + bond_peer_notify_work_rearm(bond, 1);
>> + return;
>> + }
>> +
>> + bond_peer_notify_reset(bond);
>> +
>> + rtnl_unlock();
>> + return;
>=20
> I'm sorry for nit picking, but this is a bit ugly: please remove the
> `return;` statement above.
oops, ok, thanks.
>=20
>> @@ -1279,19 +1306,17 @@ void bond_change_active_slave(struct bonding =
*bond, struct slave *new_active)
>> bond_do_fail_over_mac(bond, new_active,
>>      old_active);
>>=20
>> + call_netdevice_notifiers(NETDEV_BONDING_FAILOVER, bond->dev);
>> +
>> if (netif_running(bond->dev)) {
>> - bond->send_peer_notif =3D
>> - bond->params.num_peer_notif *
>> - max(1, bond->params.peer_notif_delay);
>> - should_notify_peers =3D
>> - bond_should_notify_peers(bond);
>> - }
>> + bond_peer_notify_reset(bond);
>>=20
>> - call_netdevice_notifiers(NETDEV_BONDING_FAILOVER, bond->dev);
>> - if (should_notify_peers) {
>> - bond->send_peer_notif--;
>> - call_netdevice_notifiers(NETDEV_NOTIFY_PEERS,
>> - bond->dev);
>> + if (bond_should_notify_peers(bond)) {
>> + bond->send_peer_notif--;
>> + call_netdevice_notifiers(
>> + NETDEV_NOTIFY_PEERS,
>> + bond->dev);
>=20
> Since a repost is needed, plase move this if block to a separate =
helper
> to reduce indentation and avoid bad formatting.
ok
>=20
> Thanks,
>=20
> Paolo
>=20
>=20


