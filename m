Return-Path: <netdev+bounces-75052-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B29AE867F2A
	for <lists+netdev@lfdr.de>; Mon, 26 Feb 2024 18:47:33 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id BEDDE1C217B4
	for <lists+netdev@lfdr.de>; Mon, 26 Feb 2024 17:47:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9743912C815;
	Mon, 26 Feb 2024 17:47:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=canonical.com header.i=@canonical.com header.b="nbRea0+N"
X-Original-To: netdev@vger.kernel.org
Received: from smtp-relay-internal-1.canonical.com (smtp-relay-internal-1.canonical.com [185.125.188.123])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E18E412EBC8
	for <netdev@vger.kernel.org>; Mon, 26 Feb 2024 17:47:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.125.188.123
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708969641; cv=none; b=YuR9t04cw7PGKFX6ejQUZSBibVqFQFBS6mwLU5MRTdspc6t4VKPJuvzivT4BIyCJko8Ghk1MAdp411LswX/Ibil6zxRpaIcPmGnQTQo9VSg+PMK1ab8eGgzkANqbCg28KDp3XbVtJUmELL45H6fwVUYCBFejYpF1GJDm+0P0HNs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708969641; c=relaxed/simple;
	bh=4wcegm+FrHnOWAQeGINRXP3mpmA+GrZM/54FU/bpXa4=;
	h=From:To:cc:Subject:In-reply-to:References:MIME-Version:
	 Content-Type:Date:Message-ID; b=V/Q+on93W0Gpv4A+NCUFg7RGT/E3uU5kbezd4gT2fmCWyXs7zWXsxAR7u7fkIU5PvXRn9roGw0MnQKpg9+dhCPYxnObROMINMw4oluJWRNQJgZZ+ZKwpaDX4ZT5j4Y0xsX7ZDJqHIXhnmOFDBWjfr45F0AqtOcnzT1EMf22e+2g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=canonical.com; spf=pass smtp.mailfrom=canonical.com; dkim=pass (2048-bit key) header.d=canonical.com header.i=@canonical.com header.b=nbRea0+N; arc=none smtp.client-ip=185.125.188.123
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=canonical.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=canonical.com
Received: from mail-pg1-f200.google.com (mail-pg1-f200.google.com [209.85.215.200])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-relay-internal-1.canonical.com (Postfix) with ESMTPS id 9113D3F26F
	for <netdev@vger.kernel.org>; Mon, 26 Feb 2024 17:46:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canonical.com;
	s=20210705; t=1708969616;
	bh=qlG1XXfMSTJgylXzlZx6s+GnEuZ5LCkwrjatFG2+AN0=;
	h=From:To:cc:Subject:In-reply-to:References:MIME-Version:
	 Content-Type:Date:Message-ID;
	b=nbRea0+NgNRcbz1S6uFkSEm1yQhMjrgSCRZxTetCU9ulRYNPsq1FCAdV7oFkNb20v
	 HW/K5hz7vPdqqqocaJsmm/hL67/9++k2o9mgMda1LHeXkk4S/CEDZnAqVUiXok6+y3
	 e5uzAnoFbr/LZydFzLTWpbCL63+7F/PSw+2XrzjEbQb9NeJq8PsdqwtYjleO8+ivMz
	 0TAIiiAmMbY1+qA4MiKq94dbB4RYytP2uELmAwPGrVG2zg0gT0MfltGrCyq9aEA64q
	 ++mCcSvU6Y+2hjgiqmvxRDO8/iX3JqjnNpeO1UWiq/jVX8ya6W/e8rOYWvTgMQwSra
	 YYDegpFPtlKJA==
Received: by mail-pg1-f200.google.com with SMTP id 41be03b00d2f7-5dc992f8c8aso3232879a12.3
        for <netdev@vger.kernel.org>; Mon, 26 Feb 2024 09:46:56 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1708969516; x=1709574316;
        h=message-id:date:content-transfer-encoding:mime-version:comments
         :references:in-reply-to:subject:cc:to:from:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=qlG1XXfMSTJgylXzlZx6s+GnEuZ5LCkwrjatFG2+AN0=;
        b=vNOBhS5nICttJbevl+MCaqF17PZorl/3uwSFp+Bcgt5Ex8nduuuVzAKEDbhNCq6nqH
         fqJQ2GeTMkLeXibCDxuONoMDTSUHSQxSrwi3App5LqpbCPrXj+jreHBAbShdDYea7U2c
         evsXI4puM6tKoNnkG64sqPewboHU87wP0/duc+OW33elH4ouz9opUNJaNDezHxTZGvC7
         CiMP+jlJ1y95w5Y1xcieFzqntEkmZUDRZ9iCjWePj0wG5U5TH3zPQtacbL3qN9NF+Sqp
         adQozPxSyz2R8mn/IMA2Lh1oFwGUCuSqRZS8VYq+sYDC8BM0hIu5O5a4qoRMO/bLapJW
         a5VA==
X-Gm-Message-State: AOJu0YxpmR+O2pVOTFUpVXVscYbm9+HubqvH9E73ALCuYXVVQMLoEsGZ
	9ToeP7qI9oeGrgzAQJzNmk0XP7nXXj6goMAAWRED6TTA3z2vp5ZU4XzHACaqsFAKBsgT502UTwj
	9iskQsv0aJsdohrwrCOC3u3lBQ02yWymrFyMnZbUugWhcGEr28BpJUhuzKXE6O7NzlzOmHA==
X-Received: by 2002:a05:6a20:93a6:b0:1a0:e4ac:9c7a with SMTP id x38-20020a056a2093a600b001a0e4ac9c7amr8729913pzh.1.1708969516028;
        Mon, 26 Feb 2024 09:45:16 -0800 (PST)
X-Google-Smtp-Source: AGHT+IFwrH70fY1lfDhaL/wJvKiyVY14zTHKwXoKQrun8J7qB0UIM8KzO1Ma3oQtc6YCvbaQNxkCvA==
X-Received: by 2002:a05:6a20:93a6:b0:1a0:e4ac:9c7a with SMTP id x38-20020a056a2093a600b001a0e4ac9c7amr8729891pzh.1.1708969515647;
        Mon, 26 Feb 2024 09:45:15 -0800 (PST)
Received: from famine.localdomain ([50.125.80.253])
        by smtp.gmail.com with ESMTPSA id l10-20020a056a00140a00b006e50c083b90sm2817375pfu.212.2024.02.26.09.45.15
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 26 Feb 2024 09:45:15 -0800 (PST)
Received: by famine.localdomain (Postfix, from userid 1000)
	id C3BDF604B6; Mon, 26 Feb 2024 09:45:14 -0800 (PST)
Received: from famine (localhost [127.0.0.1])
	by famine.localdomain (Postfix) with ESMTP id BB48C9FAAA;
	Mon, 26 Feb 2024 09:45:14 -0800 (PST)
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
Date: Mon, 26 Feb 2024 09:45:14 -0800
Message-ID: <29939.1708969514@famine>

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
>
>Delete null_mac_addr, which is not required anymore in bond_3ad.c, since
>all references to it are gone.
>
>Signed-off-by: Jones Syue <jonessyue@qnap.com>
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

	I'm not sure this is an equivalent swap, as it is replacing a
test for non-empty of the port's partner MAC with a test of the
aggregator's partner MAC.

	In the port case, it is validating that this specific port has
received a response from its link partner.

	In the aggregator case, it's checking that the aggregator as a
whole has received response from the link partners of members of the
aggregator, which does not include the port under consideration for
inclusion into the aggregator.

	As the port is not yet a member of the aggregator, how is
checking the aggregator's MAC for being non-empty an equivalent test to
the one it replaces?

	-J

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

---
	-Jay Vosburgh, jay.vosburgh@canonical.com

