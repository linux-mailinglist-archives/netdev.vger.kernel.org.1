Return-Path: <netdev+bounces-232957-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id AA6C0C0A5B2
	for <lists+netdev@lfdr.de>; Sun, 26 Oct 2025 11:00:35 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 57E3B3A6FED
	for <lists+netdev@lfdr.de>; Sun, 26 Oct 2025 10:00:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A6FF31AC88A;
	Sun, 26 Oct 2025 10:00:32 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from smtpbguseast2.qq.com (smtpbguseast2.qq.com [54.204.34.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E496AEEAB
	for <netdev@vger.kernel.org>; Sun, 26 Oct 2025 10:00:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=54.204.34.130
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761472832; cv=none; b=X9Of5T+pHKGxzuhZIv1a7ASwyfT1R3Pt2wi92+vVE3/6pGDfQcTYK88NwWyeixpuU3O0d0SAKymqNFC6ach5zm70YalB1w9+uz7IsSSFvGIrX+tEo9kLjuNRIglR6T9bV0U0OT+oygkct0IsihfUYv3iGti2bB+RyevMYGiIJ4s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761472832; c=relaxed/simple;
	bh=tK+X99XbODIyUxIr07azIQRN7RQ0WquTCFTmYL+OgEM=;
	h=Content-Type:Mime-Version:Subject:From:In-Reply-To:Date:Cc:
	 Message-Id:References:To; b=HaMhI2FVKV8pFJ4+ClTMA/9ViGDGnTCACwCyepz8IUtt6/1nsFK/cgh5GXvn+3CJrmjjp2vbfWeVHTWsUKvqXbDTBZEq+v6uaHSCQk+Vsdt+kxDG9KrXXApJBAHdZbXLkRXz5tGzxWbLsN/S+mjK6FCeGRjfhuhSX2T+CQLl668=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=bamaicloud.com; spf=none smtp.mailfrom=bamaicloud.com; arc=none smtp.client-ip=54.204.34.130
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=bamaicloud.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=bamaicloud.com
X-QQ-mid: zesmtpsz5t1761472799ta874b65c
X-QQ-Originating-IP: WXqRoCKnk0GNIcChPMhDRsBySMvPwpepsk6PSsAT+b0=
Received: from smtpclient.apple ( [183.241.14.145])
	by bizesmtp.qq.com (ESMTP) with 
	id ; Sun, 26 Oct 2025 17:59:57 +0800 (CST)
X-QQ-SSF: 0000000000000000000000000000000
X-QQ-GoodBg: 0
X-BIZMAIL-ID: 8147361236136901801
Content-Type: text/plain;
	charset=us-ascii
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
Mime-Version: 1.0 (Mac OS X Mail 16.0 \(3826.700.81\))
Subject: Re: [PATCH net-next] net: bonding: use workqueue to make sure peer
 notify updated
From: Tonghao Zhang <tonghao@bamaicloud.com>
In-Reply-To: <955201.1761098579@famine>
Date: Sun, 26 Oct 2025 17:59:47 +0800
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
Message-Id: <52C32611-1FE3-4BB2-B5A6-340FB83E6803@bamaicloud.com>
References: <20251021052249.47250-1-tonghao@bamaicloud.com>
 <955201.1761098579@famine>
To: Jay Vosburgh <jv@jvosburgh.net>
X-Mailer: Apple Mail (2.3826.700.81)
X-QQ-SENDSIZE: 520
Feedback-ID: zesmtpsz:bamaicloud.com:qybglogicsvrsz:qybglogicsvrsz4a-0
X-QQ-XMAILINFO: OO2wLqYBHUeBAxmy6erKyfU0ah2ZrFnej5s+THF763j63eBNc9y5K53w
	FrqDsEtQIfWjYLjo/3l00X/rgqxhIuUd1/2tWOlyRFR8buYkEH2Wzq0wKLOPf+JT45fRF4A
	bPN8UKni1TFcWw51L+J/Mr8DhyUdOAhE7w8PblbpxMHHiYlmtcuOxxXcLMk+lJZttwjkyjo
	JPYXzUaTPBdUn+4LMI0XrTMRmI6LUJXepw/xSyEoarEDiCWFJzoGGl3aNH2tOjE7/aWR0ZJ
	iZZPB18bSjuf01YJDKQSM7ctrGh9/fOV7zFAarGRn27wX2+fLeeEYdLm9QcVfZUaurvCVyj
	/SuKL2tmQulGyOJnVy0GDkLKT/8S8pe2XyNWiDEcju3KsJdE9zSO3fSS+HHzYboRH69hFPk
	Mq5apr+lyREuCOhc3dr2lmr9qtk6oPh0Vn+x6OfIOcGeU4RclAiQ8lyxLQ+5+nVWwVKKxux
	Vo1z+5dlCAHtVmqj4dkrnrmy+svKJ6TRBoNcIRX0wgwHf88ala2LBVOcIbwyKyVKhXgzbrt
	Ywi8CL4RLaxHFA/6lnSN3d7Ds8mWkmuE+UVr9lqTBTIk1z1L7+j2LF2FXdWOhUlXg7d+I+T
	4f4ekCXqxKPCFncF/KHtS603ufdJnnMJD9RnOQ0ssQbYm0JbP9x0hYDqRZcjPPpWknv5UJk
	iKYq+GzBAXGkLITJlmHo0w7q3nmnrZskfMFVRWK+k6gp9XPGEASdZSzDjSVeRBy63031xhh
	zJBGwd25hCAr/jMtdD90ETTRzM/EjGo6U1p11cvs7p+s6BjSl+9WlC5lnNNfwXIG5yV9450
	heYPq5RJPQSgfCgjfVXdHD6CGakfSSHHI1kZQi4VodK8vpM0Zhs5fRiWyVfV9zALXKAEQU2
	0I47V/hBipAHy9hpFg1LZqSPy9JOLnKcDqpMkY2i9FDpSrC7P8o4pzlJIkipH+pnbtTgqUe
	5ogWr9KDG8apS2Vt+RQiavbH+WBXM3hcMsBkmZr0YTw/iacWT5lKYmiKsdq+Dk05bOf06y4
	ObzKj9CeHb/oTFzwYnP1IyWTFY3A0=
X-QQ-XMRINFO: MPJ6Tf5t3I/ycC2BItcBVIA=
X-QQ-RECHKSPAM: 0



> On Oct 22, 2025, at 10:02, Jay Vosburgh <jv@jvosburgh.net> wrote:
>=20
> Tonghao Zhang <tonghao@bamaicloud.com> wrote:
>=20
>> The RTNL might be locked, preventing ad_cond_set_peer_notif from =
acquiring
>> the lock and updating send_peer_notif. This patch addresses the issue =
by
>> using a workqueue. Since updating send_peer_notif does not require =
high
>> real-time performance, such delayed updates are entirely acceptable.
>=20
> Would it be less complicated overall to convert send_peer_notif
> to an atomic_t, and handle updates via atomic_inc/dec/etc instead of
> messing with workqueues and RTNL just to change one variable?
>=20
> As you say, it's not performance critical, and, despite your
> previous patch that moves some send_peer_notif code inside an RTNL
> block, if using atomic makes the code less complicated that may be
> better in the long run.
Your suggestion is helpful to me, I post new patch, using the atomic =
instead of workqueue.
>=20
> -J
>=20
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
>> Suggested-by: Hangbin Liu <liuhangbin@gmail.com>
>> Signed-off-by: Tonghao Zhang <tonghao@bamaicloud.com>
>> ---
>> drivers/net/bonding/bond_3ad.c  |  7 ++-----
>> drivers/net/bonding/bond_main.c | 27 +++++++++++++++++++++++++++
>> include/net/bonding.h           |  2 ++
>> 3 files changed, 31 insertions(+), 5 deletions(-)
>>=20
>> diff --git a/drivers/net/bonding/bond_3ad.c =
b/drivers/net/bonding/bond_3ad.c
>> index 2fca8e84ab10..1db2e34a351f 100644
>> --- a/drivers/net/bonding/bond_3ad.c
>> +++ b/drivers/net/bonding/bond_3ad.c
>> @@ -986,11 +986,8 @@ static void ad_cond_set_peer_notif(struct port =
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
>> + bond_peer_notify_work_rearm(bond, 0);
>> }
>>=20
>> /**
>> diff --git a/drivers/net/bonding/bond_main.c =
b/drivers/net/bonding/bond_main.c
>> index 2d6883296e32..5791c3e39baa 100644
>> --- a/drivers/net/bonding/bond_main.c
>> +++ b/drivers/net/bonding/bond_main.c
>> @@ -3990,6 +3990,31 @@ static void bond_arp_monitor(struct =
work_struct *work)
>> bond_loadbalance_arp_mon(bond);
>> }
>>=20
>> +/* Use this to update send_peer_notif when RTNL may be held in other =
places. */
>> +void bond_peer_notify_work_rearm(struct bonding *bond, unsigned long =
delay)
>> +{
>> + queue_delayed_work(bond->wq, &bond->peer_notify_work, delay);
>> +}
>> +
>> +/* Peer notify update handler. Holds only RTNL */
>> +static void bond_peer_notify_handler(struct work_struct *work)
>> +{
>> + struct bonding *bond =3D container_of(work, struct bonding,
>> +     peer_notify_work.work);
>> +
>> + if (!rtnl_trylock())
>> + goto rearm;
>> +
>> + bond->send_peer_notif =3D bond->params.num_peer_notif *
>> + max(1, bond->params.peer_notif_delay);
>> +
>> + rtnl_unlock();
>> + return;
>> +
>> +rearm:
>> + bond_peer_notify_work_rearm(bond, 1);
>> +}
>> +
>> /*-------------------------- netdev event handling =
--------------------------*/
>>=20
>> /* Change device name */
>> @@ -4412,6 +4437,7 @@ void bond_work_init_all(struct bonding *bond)
>> INIT_DELAYED_WORK(&bond->arp_work, bond_arp_monitor);
>> INIT_DELAYED_WORK(&bond->ad_work, bond_3ad_state_machine_handler);
>> INIT_DELAYED_WORK(&bond->slave_arr_work, bond_slave_arr_handler);
>> + INIT_DELAYED_WORK(&bond->peer_notify_work, =
bond_peer_notify_handler);
>> }
>>=20
>> static void bond_work_cancel_all(struct bonding *bond)
>> @@ -4422,6 +4448,7 @@ static void bond_work_cancel_all(struct bonding =
*bond)
>> cancel_delayed_work_sync(&bond->ad_work);
>> cancel_delayed_work_sync(&bond->mcast_work);
>> cancel_delayed_work_sync(&bond->slave_arr_work);
>> + cancel_delayed_work_sync(&bond->peer_notify_work);
>> }
>>=20
>> static int bond_open(struct net_device *bond_dev)
>> diff --git a/include/net/bonding.h b/include/net/bonding.h
>> index e06f0d63b2c1..4ce530371416 100644
>> --- a/include/net/bonding.h
>> +++ b/include/net/bonding.h
>> @@ -255,6 +255,7 @@ struct bonding {
>> struct   delayed_work ad_work;
>> struct   delayed_work mcast_work;
>> struct   delayed_work slave_arr_work;
>> + struct   delayed_work peer_notify_work;
>> #ifdef CONFIG_DEBUG_FS
>> /* debugging support via debugfs */
>> struct  dentry *debug_dir;
>> @@ -710,6 +711,7 @@ struct bond_vlan_tag =
*bond_verify_device_path(struct net_device *start_dev,
>>       int level);
>> int bond_update_slave_arr(struct bonding *bond, struct slave =
*skipslave);
>> void bond_slave_arr_work_rearm(struct bonding *bond, unsigned long =
delay);
>> +void bond_peer_notify_work_rearm(struct bonding *bond, unsigned long =
delay);
>> void bond_work_init_all(struct bonding *bond);
>>=20
>> #ifdef CONFIG_PROC_FS
>> --=20
>> 2.34.1
>>=20
>>=20
>=20
> ---
> -Jay Vosburgh, jv@jvosburgh.net



