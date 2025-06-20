Return-Path: <netdev+bounces-199645-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id DD113AE119C
	for <lists+netdev@lfdr.de>; Fri, 20 Jun 2025 05:16:12 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 790E54A32AE
	for <lists+netdev@lfdr.de>; Fri, 20 Jun 2025 03:16:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A014A433B1;
	Fri, 20 Jun 2025 03:16:02 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from smtpbgau2.qq.com (smtpbgau2.qq.com [54.206.34.216])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 24FB11DE4C5
	for <netdev@vger.kernel.org>; Fri, 20 Jun 2025 03:15:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=54.206.34.216
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750389362; cv=none; b=BowgomP5LOywm6zBL78cTs/T1eDYOXMDBX4bJ4aLwXa+mYbBAh8xZIujPEMFpJxsjOGrhHfcWjp5Ku9JjxJTn+Rv7ZoBWLzqjW/rWFGJY5DSsp3PaQ7V4NAMsdFIvVh98G56FOuekQTf0c8GBeYqEQZnNfEnzLWtd8Hrw/Bslig=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750389362; c=relaxed/simple;
	bh=PsaUAxfRj9CuYUjCQXDco1nqJRJzkfZTLOJqsh1HqT4=;
	h=Content-Type:Mime-Version:Subject:From:In-Reply-To:Date:Cc:
	 Message-Id:References:To; b=unLxtZ4cUHMdzPEvo08E4VgKyWZZHHaWnnQZRvHxQ2ytOeCZcn9H47osPTNSZVp3KV7x31v9LjGjd8rUZFF4LMRU1aIQTf0BnxpoyiDwLcZ4SsqnyqAj5Y45+4TEKzXMdaMb/8eZcmg+Z0hgPBD6BNZA7gD+YU5aFhaHdT9BQCI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=bamaicloud.com; spf=pass smtp.mailfrom=bamaicloud.com; arc=none smtp.client-ip=54.206.34.216
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=bamaicloud.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bamaicloud.com
X-QQ-mid: esmtpgz12t1750389349teda56343
X-QQ-Originating-IP: Zo98sSbsqoUDsUkXJ0WApzQJ12Ats2G0qcArjT+Gb7M=
Received: from smtpclient.apple ( [111.202.70.99])
	by bizesmtp.qq.com (ESMTP) with 
	id ; Fri, 20 Jun 2025 11:15:46 +0800 (CST)
X-QQ-SSF: 0000000000000000000000000000000
X-QQ-GoodBg: 0
X-BIZMAIL-ID: 2506058706453155900
Content-Type: text/plain;
	charset=utf-8
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
Mime-Version: 1.0 (Mac OS X Mail 16.0 \(3826.600.51.1.1\))
Subject: Re: [PATCH] bonding: Improve the accuracy of LACPDU transmissions
From: Tonghao Zhang <tonghao@bamaicloud.com>
In-Reply-To: <20250618195309.368645-1-carlos.bilbao@kernel.org>
Date: Fri, 20 Jun 2025 11:15:36 +0800
Cc: jv@jvosburgh.net,
 andrew+netdev@lunn.ch,
 davem@davemloft.net,
 edumazet@google.com,
 kuba@kernel.org,
 pabeni@redhat.com,
 horms@kernel.org,
 netdev@vger.kernel.org,
 linux-kernel@vger.kernel.org,
 sforshee@kernel.org,
 bilbao@vt.edu
Content-Transfer-Encoding: quoted-printable
Message-Id: <341249BC-4A2E-4C90-A960-BB07FAA9C092@bamaicloud.com>
References: <20250618195309.368645-1-carlos.bilbao@kernel.org>
To: carlos.bilbao@kernel.org
X-Mailer: Apple Mail (2.3826.600.51.1.1)
X-QQ-SENDSIZE: 520
Feedback-ID: esmtpgz:bamaicloud.com:qybglogicsvrsz:qybglogicsvrsz4a-0
X-QQ-XMAILINFO: NqN/wpVFVRYXrbkBge0ilKLhm6UJeqAo81HLE5j2rsIbbdBPfq6KszVa
	r7sALgPs3eGv0ydjpWVRsV9qG4MZFDrV7CSjvvQMsEjbtIXplNS1mqBiy5r6Mr/SHoST1sD
	a1rMNqKrLSsI9F2RHZaSJHPxhPlnP3kHp+Q6l/wDvIPRsAjlEycfhOhfXQjoyUvZsjtdBix
	y9ZLeHmckZ21v5oO+z0B3bsqKwHv/Fp0K+bvQQownSB76eilqeW/vPxE91l9nIp4DMlAYVr
	rgpOafdPFzK0qcO8hUVrM2SRWNkkezSHbePPpmbzLMu2Sa9D1amospkvP8EmnmSgXA3TcrN
	zfASImTRiPO41Im6GfgoQitu6LKCARPpDT5Brw3DLxGA17MlkUqPVhKhYvq28UuF3Ookz+M
	0Tb0TWkb17sTuH0m+wMIOmxJbbk/uUNRwMjFLuukljoj/bol95Id/MNKmeDbErWEXpMXcdB
	LlvwsXYJw24m9CRxlt3v8SFHI00whfN8QK5NFqoGmaowy9zvK4nK5THlFmnDzCiZwscuX9b
	JenNT8S9XoKRGziekETx3/I+cj1x9G0mnrWXzwUpidkt1MzT6b5O0Ix5E8dT7dvFlm6to4y
	cpcdTZpxHGZWiKsH0xm/UN/HQFslUD86kfjw8UnFSO9vPhgzUaWPF1OWYjA2GP9AUjWMEl0
	yULU0TD0yZi1DKXnocQemGltFd/2n6kv+4j6orWNb5sIdLQqW4UNkE5JCyiEIlWXe3cmC6L
	NwovG5GZJzpX3NGVp8PwUWC98IZ27UG4cyuKNVl7hHjv7XSgZoZTRNgBAntlJY3qqw9MkxC
	ZvkRg38THhd4hrjsnE0RBu11uwMccjefOvgDA/j2rH905Pe737ZRuPn3qrEakg2pDp9G/nU
	ESD/c/LROSTMuWjr9qk9UgqYhRrCwhHOWEzpEUAOhsFVWRjfnMRHhiJ3D0hbpcLw+rLmtT7
	VlE/5rpQMYXIgvg==
X-QQ-XMRINFO: Nq+8W0+stu50PRdwbJxPCL0=
X-QQ-RECHKSPAM: 0



> 2025=E5=B9=B46=E6=9C=8819=E6=97=A5 03:53=EF=BC=8Ccarlos.bilbao@kernel.or=
g =E5=86=99=E9=81=93=EF=BC=9A
>=20
> From: Carlos Bilbao <carlos.bilbao@kernel.org>
>=20
> Improve the timing accuracy of LACPDU transmissions in the bonding =
802.3ad
> (LACP) driver. The current approach relies on a decrementing counter =
to
> limit the transmission rate. In our experience, this method is =
susceptible
> to delays (such as those caused by CPU contention or soft lockups) =
which
> can lead to accumulated drift in the LACPDU send interval. Over time, =
this
> drift can cause synchronization issues with the top-of-rack (ToR) =
switch
> managing the LAG, manifesting as lag map flapping. This in turn can =
trigger
> temporary interface removal and potential packet loss.
>=20
> This patch improves stability with a jiffies-based mechanism to track =
and
> enforce the minimum transmission interval; keeping track of when the =
next
> LACPDU should be sent.
>=20
> Suggested-by: Seth Forshee (DigitalOcean) <sforshee@kernel.org>
> Signed-off-by: Carlos Bilbao (DigitalOcean) <carlos.bilbao@kernel.org>
> ---
> drivers/net/bonding/bond_3ad.c | 18 ++++++++----------
> include/net/bond_3ad.h         |  5 +----
> 2 files changed, 9 insertions(+), 14 deletions(-)
>=20
> diff --git a/drivers/net/bonding/bond_3ad.c =
b/drivers/net/bonding/bond_3ad.c
> index c6807e473ab7..47610697e4e5 100644
> --- a/drivers/net/bonding/bond_3ad.c
> +++ b/drivers/net/bonding/bond_3ad.c
> @@ -1375,10 +1375,12 @@ static void ad_churn_machine(struct port =
*port)
>  */
> static void ad_tx_machine(struct port *port)
> {
> - /* check if tx timer expired, to verify that we do not send more =
than
> - * 3 packets per second
> - */
> - if (port->sm_tx_timer_counter && !(--port->sm_tx_timer_counter)) {
> + unsigned long now =3D jiffies;
> +
> + /* Check if enough time has passed since the last LACPDU sent */
> + if (time_after_eq(now, port->sm_tx_next_jiffies)) {
> + port->sm_tx_next_jiffies +=3D ad_ticks_per_sec / =
AD_MAX_TX_IN_SECOND;
> +
> /* check if there is something to send */
> if (port->ntt && (port->sm_vars & AD_PORT_LACP_ENABLED)) {
> __update_lacpdu_from_port(port);
> @@ -1395,10 +1397,6 @@ static void ad_tx_machine(struct port *port)
> port->ntt =3D false;
> }
> }
> - /* restart tx timer(to verify that we will not exceed
> - * AD_MAX_TX_IN_SECOND
> - */
> - port->sm_tx_timer_counter =3D ad_ticks_per_sec/AD_MAX_TX_IN_SECOND;
> }
> }
>=20
> @@ -2199,9 +2197,9 @@ void bond_3ad_bind_slave(struct slave *slave)
> /* actor system is the bond's system */
> __ad_actor_update_port(port);
> /* tx timer(to verify that no more than MAX_TX_IN_SECOND
> - * lacpdu's are sent in one second)
> + * lacpdu's are sent in the configured interval (1 or 30 secs))
> */
> - port->sm_tx_timer_counter =3D ad_ticks_per_sec/AD_MAX_TX_IN_SECOND;
> + port->sm_tx_next_jiffies =3D jiffies + ad_ticks_per_sec / =
AD_MAX_TX_IN_SECOND;

If CONFIG_HZ is 1000, there is 1000 tick per second, but =
"ad_ticks_per_sec / AD_MAX_TX_IN_SECOND=E2=80=9D =3D=3D 10/3 =3D=3D 3, =
so that means send lacp packets every 3 ticks ?

>=20
> __disable_port(port);
>=20
> diff --git a/include/net/bond_3ad.h b/include/net/bond_3ad.h
> index 2053cd8e788a..956d4cb45db1 100644
> --- a/include/net/bond_3ad.h
> +++ b/include/net/bond_3ad.h
> @@ -231,10 +231,7 @@ typedef struct port {
> mux_states_t sm_mux_state; /* state machine mux state */
> u16 sm_mux_timer_counter; /* state machine mux timer counter */
> tx_states_t sm_tx_state; /* state machine tx state */
> - u16 sm_tx_timer_counter; /* state machine tx timer counter
> - * (always on - enter to transmit
> - *  state 3 time per second)
> - */
> + unsigned long sm_tx_next_jiffies;/* expected jiffies for next LACPDU =
sent */
> u16 sm_churn_actor_timer_counter;
> u16 sm_churn_partner_timer_counter;
> u32 churn_actor_count;
> --=20
> 2.43.0
>=20
>=20
>=20


