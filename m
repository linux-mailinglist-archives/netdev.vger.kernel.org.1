Return-Path: <netdev+bounces-75119-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 514128683F7
	for <lists+netdev@lfdr.de>; Mon, 26 Feb 2024 23:47:30 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 0723828DE49
	for <lists+netdev@lfdr.de>; Mon, 26 Feb 2024 22:47:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A3DB0135A45;
	Mon, 26 Feb 2024 22:47:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=canonical.com header.i=@canonical.com header.b="CFK+xaIU"
X-Original-To: netdev@vger.kernel.org
Received: from smtp-relay-internal-0.canonical.com (smtp-relay-internal-0.canonical.com [185.125.188.122])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 61633135415
	for <netdev@vger.kernel.org>; Mon, 26 Feb 2024 22:47:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.125.188.122
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708987643; cv=none; b=PyFcR1ZT4S3mhKG+QI7we7vHlPGTi2CPgRWQtj0osCP1feGqF0xZNGdC12AYRxLCJAib8MkE8q7dqkwJ438Lqeqyilc6vmi96RF5fkYpdPv5ZPwW/p9RPUz+XVBGsQDoR0/Q2ezOfeOHY5eVb27Fqe5COifZjX6JVQQ9td/5mF0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708987643; c=relaxed/simple;
	bh=6S2iaa1ziWP/+AZL5PVpvzk6dQnjcMLBdQBD+N8qB+8=;
	h=From:To:cc:Subject:In-reply-to:References:MIME-Version:
	 Content-Type:Date:Message-ID; b=oE/zGhk3kCBkUWT8pOfuMsJsi5KMCOHqoqnlSmp0/yR0456/TOrmyYyS0IUbAVKukRwE8NRsB4DGRDZHjVl0nKYD9v3LCKVFB6uxebxJn4b7MeRcbwJqJ+EOYOR4KLHQ3ODG2Ev4NVMXIjAxdb7DfeT0t20gkEiLQhme1zBn9Xk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=canonical.com; spf=pass smtp.mailfrom=canonical.com; dkim=pass (2048-bit key) header.d=canonical.com header.i=@canonical.com header.b=CFK+xaIU; arc=none smtp.client-ip=185.125.188.122
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=canonical.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=canonical.com
Received: from mail-pg1-f197.google.com (mail-pg1-f197.google.com [209.85.215.197])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-relay-internal-0.canonical.com (Postfix) with ESMTPS id D7B2240DAD
	for <netdev@vger.kernel.org>; Mon, 26 Feb 2024 22:47:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canonical.com;
	s=20210705; t=1708987622;
	bh=gr+WKKnlHjOQT4Ki8d0xTGUPBtTeKxzlDsfRKLcxP1U=;
	h=From:To:cc:Subject:In-reply-to:References:MIME-Version:
	 Content-Type:Date:Message-ID;
	b=CFK+xaIUPcUVSrnbVbdF3m479yeP54jHtemC76LrpmDLsFUidpJRXa4CAtDyvVgQO
	 1B3nED1s88jiiCnKtMPwMufPaO5tAemgUC7DJhEt8OmYx2XnJ5zAKDUfsMC86ug++z
	 AHJbEVBqCF/2zdIduVE5d00frrvVpaOCyeT82wYB08X0+POSvzoZn97LzykTw6naT3
	 FmMSdVP+pGa19bJNgvDdRxcUBtC79xuaU6/P78XUOeLtepyggDpVBQqHd1UDA3zkv8
	 UrQ8qZgub8P2VdUKJ1/Vdv4kdtkCO7ACgJ7C1BKvIW2Ii0AIjc/GJ8GC/PEwfnNitW
	 TAJgMS3KVsMJQ==
Received: by mail-pg1-f197.google.com with SMTP id 41be03b00d2f7-5dc90074016so3282560a12.0
        for <netdev@vger.kernel.org>; Mon, 26 Feb 2024 14:47:02 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1708987621; x=1709592421;
        h=message-id:date:content-transfer-encoding:mime-version:comments
         :references:in-reply-to:subject:cc:to:from:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=gr+WKKnlHjOQT4Ki8d0xTGUPBtTeKxzlDsfRKLcxP1U=;
        b=PP6MGSbmxhr1AO8N0dd1dQswXPKfuBD+7giW3dFroYT6HUtVcc6FJwMBfKxbsYUkAK
         014OaajKj1nPlAD7X/CJqR8vYKkGp4FPP+Jq26Ncsvz1ukiIqUMrm6UQL9m6KlF8YJdS
         B60P4WywVrTQKXswXJoSOEpksuCCPesZEAdeLW0qeANUgY5wcG/2BtSxxeRwDe+Yh7zw
         rjghK8QCqkpL9+ENbax9QVp3QnpXv6vA3vr6nNrjTKTolfrYGDGG57JqLTA8r6kxZFY5
         E+Rnwugu08dmJ57/mPYTpBTzWqn6IcVpISjqWJ2aat5TInHeJTZBxqji44ItpB73TVx1
         7fSA==
X-Gm-Message-State: AOJu0YzvZxp06wvczAVoH6UES8oNJeEldMbGPTnNeE2UOx+OwqFmOGRV
	vulkU+lUdUXMquxfxZj63KVqjserC3b2Ku2NF5APisJHxuFOQFw9Ms+csOLeGjiKSMv+kh7e98Q
	SFps4LYIu/KEwAjwmP8Rg3gR4BimvL8A2uvrq5C3dQa2j2h/+RE4nL9U1ans246LikKuGJg==
X-Received: by 2002:a17:90a:1210:b0:29a:adb5:b045 with SMTP id f16-20020a17090a121000b0029aadb5b045mr4473990pja.9.1708987621427;
        Mon, 26 Feb 2024 14:47:01 -0800 (PST)
X-Google-Smtp-Source: AGHT+IFfO8b7Km0xOTYWEQV0dBP+d4tg1/74p4NInrzrufP6TwLpfyBM1I5NvyZZu8SzCRkTtprVwA==
X-Received: by 2002:a17:90a:1210:b0:29a:adb5:b045 with SMTP id f16-20020a17090a121000b0029aadb5b045mr4473974pja.9.1708987621028;
        Mon, 26 Feb 2024 14:47:01 -0800 (PST)
Received: from famine.localdomain ([50.125.80.253])
        by smtp.gmail.com with ESMTPSA id e4-20020a17090ab38400b0029a75101532sm4909195pjr.50.2024.02.26.14.47.00
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 26 Feb 2024 14:47:00 -0800 (PST)
Received: by famine.localdomain (Postfix, from userid 1000)
	id 34BF0604B6; Mon, 26 Feb 2024 14:47:00 -0800 (PST)
Received: from famine (localhost [127.0.0.1])
	by famine.localdomain (Postfix) with ESMTP id 2EF979FAAA;
	Mon, 26 Feb 2024 14:47:00 -0800 (PST)
From: Jay Vosburgh <jay.vosburgh@canonical.com>
To: =?us-ascii?Q?=3D=3Fiso-2022-jp=3FB=3FSm9uZXMgU3l1ZSAbJEJpLVhnPSEbKEI?= =?us-ascii?Q?=3D=3F=3D?= <jonessyue@qnap.com>
cc: "netdev@vger.kernel.org" <netdev@vger.kernel.org>,
    "andy@greyhouse.net" <andy@greyhouse.net>,
    "davem@davemloft.net" <davem@davemloft.net>,
    "edumazet@google.com" <edumazet@google.com>,
    Jakub Kicinski <kuba@kernel.org>,
    "pabeni@redhat.com" <pabeni@redhat.com>,
    "corbet@lwn.net" <corbet@lwn.net>, Jiri Pirko <jiri@resnulli.us>,
    "linux-doc@vger.kernel.org" <linux-doc@vger.kernel.org>,
    "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH net-next v3] bonding: 802.3ad replace MAC_ADDRESS_EQUAL with __agg_has_partner
In-reply-to: <SI2PR04MB5097BCA8FF2A2F03D9A5A3EEDC5A2@SI2PR04MB5097.apcprd04.prod.outlook.com>
References: <SI2PR04MB5097BCA8FF2A2F03D9A5A3EEDC5A2@SI2PR04MB5097.apcprd04.prod.outlook.com>
Comments: In-reply-to =?us-ascii?Q?=3D=3Fiso-2022-jp=3FB=3FSm9uZXMgU3l1ZSA?=
 =?us-ascii?Q?bJEJpLVhnPSEbKEI=3D=3F=3D?= <jonessyue@qnap.com>
   message dated "Mon, 26 Feb 2024 02:24:52 +0000."
X-Mailer: MH-E 8.6+git; nmh 1.6; Emacs 29.0.50
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Mon, 26 Feb 2024 14:47:00 -0800
Message-ID: <16063.1708987620@famine>

Jones Syue =E8=96=9B=E6=87=B7=E5=AE=97 <jonessyue@qnap.com> wrote:

>Replace macro MAC_ADDRESS_EQUAL() for null_mac_addr checking with inline
>function__agg_has_partner(). When MAC_ADDRESS_EQUAL() is verifiying
>aggregator's partner mac addr with null_mac_addr, means that seeing if
>aggregator has a valid partner or not. Using __agg_has_partner() makes it
>more clear to understand.
>
>In ad_port_selection_logic(), since aggregator->partner_system and
>port->partner_oper.system has been compared first as a prerequisite, it is
>safe to replace the upcoming MAC_ADDRESS_EQUAL() for null_mac_addr checking
>with __agg_has_partner().

	Ok, I missed this bit when I read the patch this morning, so you
can ignore my earlier email's question.  Patch looks good to me, glad to
see null_mac_addr get the boot.

>Delete null_mac_addr, which is not required anymore in bond_3ad.c, since
>all references to it are gone.
>
>Signed-off-by: Jones Syue <jonessyue@qnap.com>

Acked-by: Jay Vosburgh <jay.vosburgh@canonical.com>

	-J

>---
>v3:
>  - replace macro with inline function in ad_port_selection_logic()
>  - delete static variable null_mac_addr in bond_3ad.c
>  - re-phrase patch description with more precise text
>  - re-phrase patch description in imperative mood
>v2: https://lore.kernel.org/netdev/SI2PR04MB5097AA23EE6799B3E56C0762DC552@=
SI2PR04MB5097.apcprd04.prod.outlook.com/
>  - add correct CC list by 'get_maintainer.pl -f .../bonding.rst'
>v1: https://lore.kernel.org/netdev/SI2PR04MB50977DA9BB51D9C8FAF6928ADC562@=
SI2PR04MB5097.apcprd04.prod.outlook.com/
>---
> drivers/net/bonding/bond_3ad.c | 14 +++-----------
> 1 file changed, 3 insertions(+), 11 deletions(-)
>
>diff --git a/drivers/net/bonding/bond_3ad.c b/drivers/net/bonding/bond_3ad=
.c
>index f2942e8c6c91..c6807e473ab7 100644
>--- a/drivers/net/bonding/bond_3ad.c
>+++ b/drivers/net/bonding/bond_3ad.c
>@@ -82,10 +82,6 @@ enum ad_link_speed_type {
> #define MAC_ADDRESS_EQUAL(A, B)	\
> 	ether_addr_equal_64bits((const u8 *)A, (const u8 *)B)
>=20
>-static const u8 null_mac_addr[ETH_ALEN + 2] __long_aligned =3D {
>-	0, 0, 0, 0, 0, 0
>-};
>-
> static const u16 ad_ticks_per_sec =3D 1000 / AD_TIMER_INTERVAL;
> static const int ad_delta_in_ticks =3D (AD_TIMER_INTERVAL * HZ) / 1000;
>=20
>@@ -1588,7 +1584,7 @@ static void ad_port_selection_logic(struct port *por=
t, bool *update_slave_arr)
> 		     (aggregator->partner_system_priority =3D=3D port->partner_oper.sys=
tem_priority) &&
> 		     (aggregator->partner_oper_aggregator_key =3D=3D port->partner_oper=
.key)
> 		    ) &&
>-		    ((!MAC_ADDRESS_EQUAL(&(port->partner_oper.system), &(null_mac_addr)=
) && /* partner answers */
>+		    ((__agg_has_partner(aggregator) && /* partner answers */
> 		      !aggregator->is_individual)  /* but is not individual OR */
> 		    )
> 		   ) {
>@@ -2036,9 +2032,7 @@ static void ad_enable_collecting(struct port *port)
>  */
> static void ad_disable_distributing(struct port *port, bool *update_slave=
_arr)
> {
>-	if (port->aggregator &&
>-	    !MAC_ADDRESS_EQUAL(&port->aggregator->partner_system,
>-			       &(null_mac_addr))) {
>+	if (port->aggregator && __agg_has_partner(port->aggregator)) {
> 		slave_dbg(port->slave->bond->dev, port->slave->dev,
> 			  "Disabling distributing on port %d (LAG %d)\n",
> 			  port->actor_port_number,
>@@ -2078,9 +2072,7 @@ static void ad_enable_collecting_distributing(struct=
 port *port,
> static void ad_disable_collecting_distributing(struct port *port,
> 					       bool *update_slave_arr)
> {
>-	if (port->aggregator &&
>-	    !MAC_ADDRESS_EQUAL(&(port->aggregator->partner_system),
>-			       &(null_mac_addr))) {
>+	if (port->aggregator && __agg_has_partner(port->aggregator)) {
> 		slave_dbg(port->slave->bond->dev, port->slave->dev,
> 			  "Disabling port %d (LAG %d)\n",
> 			  port->actor_port_number,
>--=20
>2.1.4
>

