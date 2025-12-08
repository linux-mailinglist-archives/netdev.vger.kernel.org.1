Return-Path: <netdev+bounces-243975-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 26A5DCABEF9
	for <lists+netdev@lfdr.de>; Mon, 08 Dec 2025 04:13:32 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 064053009F45
	for <lists+netdev@lfdr.de>; Mon,  8 Dec 2025 03:13:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 49AB2262FC1;
	Mon,  8 Dec 2025 03:13:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=aspeedtech.com header.i=@aspeedtech.com header.b="ptfsg8RL"
X-Original-To: netdev@vger.kernel.org
Received: from SEYPR02CU001.outbound.protection.outlook.com (mail-koreacentralazon11023125.outbound.protection.outlook.com [40.107.44.125])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6877423B62C;
	Mon,  8 Dec 2025 03:13:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.44.125
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1765163610; cv=fail; b=s1fjAOly8XR/j/wfkmFzTPUq6yBeD9q9psPSssws/0Xr8Qn1GtC+kjLvPG0eOEMF4ftlVcxWNYkiVzbC5RUUa7BeaaXtqPAa8MAu88PAPStYZ5VfMZjmbQduxNsbul/NS15H7LmBq3NtKCEkqjzjX3OapPxe95Rh1GxKiLCNOjI=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1765163610; c=relaxed/simple;
	bh=PLzBouP1a9WoeHSqLC+D++j7HYD4BgophOVzWalhGi0=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=nsPlyHOuX108/cRBGwMFBwxxzTwEODkbq/asmod60E0hIPvl++hPglQ7y2gIxU1o5V6pN656sejasRElLyOmx5GeF/v+VKBJdAPq44v56AEs2Zs+hKhUMk4+Y23u4RrXzxWAHucd1DTNtex8ChMFd9SgTOdxoj/q/SgNJMion4E=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=aspeedtech.com; spf=pass smtp.mailfrom=aspeedtech.com; dkim=pass (2048-bit key) header.d=aspeedtech.com header.i=@aspeedtech.com header.b=ptfsg8RL; arc=fail smtp.client-ip=40.107.44.125
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=aspeedtech.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=aspeedtech.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=ifBBkS9vpVOhc54T0qf57V7IGJIiujcK4vr5r5ynJfiNylt4IwoBOic7y5T3ah+J/XGgUo+4SGBxVbId4RyfJmdKEc9X8ISYx0rHjIZtuQFT/uOmj1oAnCDhkuQwaEBoHpLck052RA7d0nsf6bAbuHJMKnw0xvmAW+ZUqA5sXUYBKyeit1EudQbhBRZsYvDK4Q++wgw8zHVTP9Y5a71zz0qbKzCGR6dzne3hpT2l6RzBMfLVLixnkRf+p9uocr6vZ4wW6g4DT2+SA00OBdgoNSth1Rw6H/s8wAV+lgyCSy9qdPsf7poHwkJDtW/er/WnoG88eK9Mbr1FJlg/fzl8xg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=p+gI+CNj0ct7amTcfpmYsEe67RYoepPXmaoBnMx/XpU=;
 b=pgJHzZ1ihR5GbiY2pA5GyzU3nQEt268NcBfGYpV5Pb16BndaHhAia+CRj83XqupVJKEybj5DR83v6dkJ5JwbiecLH8TPyNz/TveuZ92eumlX4O19LZ+yRtjZm8P1Op/C02n+t6UBNHM6PovgfcPsalFZx7n9Q1EwfSSNfj1ZL/E/IZjA8KTgdIpEttglGRm8RXeZ0dh6NxAdYT6d5aBMnGVUSR0dr9Dt/o+F0pfLGpow9qNajGcMRB0PKtxqaSX8b8SzXq2Qm65l+VimMLX7Gym2Wom05PzCIi+MY5MYCz7TtER08x4bci4f6i1wYAZc9c/4WQ8a/fHV1mZgK7bVfQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=aspeedtech.com; dmarc=pass action=none
 header.from=aspeedtech.com; dkim=pass header.d=aspeedtech.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=aspeedtech.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=p+gI+CNj0ct7amTcfpmYsEe67RYoepPXmaoBnMx/XpU=;
 b=ptfsg8RLO7DDmTRCZs4qpbB9c2Oh2y21lTN8C2zzp5DtP6MySOAU0024JCK/jsz8V16q5qWe+h8mZGfcXzXFviODpLKi1lyEaqjT95air++FYrlK/OIQnySvLnOllDEXUePWY89DpmdJNRlnZR/ln07Vp5FatbzmDVg/OO7gAv2VOOLdGr6xiU29rR0ROqLHWdu1sQ4Y3Lz5JzxkFEqSMa9zPnovqnz2g39bwYszM0e+SzKrznx4LVmEpXFse9dbT5j4HQ24cIv/eX+FAkYpKAAgTe/DNpjIdDg19LNqjuHtQE2faiUKMwsYtG4xt7iVXKC8+1HShN+d3Yn9RaoaPw==
Received: from SEYPR06MB5134.apcprd06.prod.outlook.com (2603:1096:101:5a::12)
 by PUZPR06MB5721.apcprd06.prod.outlook.com (2603:1096:301:f7::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9388.14; Mon, 8 Dec
 2025 03:13:24 +0000
Received: from SEYPR06MB5134.apcprd06.prod.outlook.com
 ([fe80::6b58:6014:be6e:2f28]) by SEYPR06MB5134.apcprd06.prod.outlook.com
 ([fe80::6b58:6014:be6e:2f28%6]) with mapi id 15.20.9388.009; Mon, 8 Dec 2025
 03:13:24 +0000
From: Jacky Chou <jacky_chou@aspeedtech.com>
To: Andrew Lunn <andrew@lunn.ch>
CC: Heiner Kallweit <hkallweit1@gmail.com>, Russell King
	<linux@armlinux.org.uk>, "David S. Miller" <davem@davemloft.net>, Eric
 Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>, Paolo Abeni
	<pabeni@redhat.com>, Joel Stanley <joel@jms.id.au>, Andrew Jeffery
	<andrew@codeconstruct.com.au>, "netdev@vger.kernel.org"
	<netdev@vger.kernel.org>, "linux-arm-kernel@lists.infradead.org"
	<linux-arm-kernel@lists.infradead.org>, "linux-aspeed@lists.ozlabs.org"
	<linux-aspeed@lists.ozlabs.org>, "linux-kernel@vger.kernel.org"
	<linux-kernel@vger.kernel.org>
Subject: [PATCH net-next] net: mdio: aspeed: add dummy read to avoid
 read-after-write issue
Thread-Topic: [PATCH net-next] net: mdio: aspeed: add dummy read to avoid
 read-after-write issue
Thread-Index: AQHcZYe49RFyTPixR0iTb6WbCAs6pLUTEaWAgAQD4IA=
Date: Mon, 8 Dec 2025 03:13:24 +0000
Message-ID:
 <SEYPR06MB5134571388AC51EEAC45AF739DA2A@SEYPR06MB5134.apcprd06.prod.outlook.com>
References:
 <20251205-aspeed_mdio_add_dummy_read-v1-1-60145ae20ea7@aspeedtech.com>
 <230147e8-e27b-48e1-9a62-7aa8abc3f492@lunn.ch>
In-Reply-To: <230147e8-e27b-48e1-9a62-7aa8abc3f492@lunn.ch>
Accept-Language: zh-TW, en-US
Content-Language: zh-TW
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=aspeedtech.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: SEYPR06MB5134:EE_|PUZPR06MB5721:EE_
x-ms-office365-filtering-correlation-id: 37ce0aca-f056-42a0-23a4-08de3607bfe9
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam:
 BCL:0;ARA:13230040|1800799024|7416014|366016|376014|38070700021;
x-microsoft-antispam-message-info:
 =?us-ascii?Q?0xC/708BXOKZomL4R4BNsMZdRuOLi2nhQ+mvg1CNczGg7J3QJV4y9Hn7zOwB?=
 =?us-ascii?Q?TNyMBdVs2xnXm1ZG2K1pwYqymhgt1B2nWjcvPw+QkUbenDxxlhxpavRIH8Wz?=
 =?us-ascii?Q?T7R8fnYhVz+nY1XaruxRv1RE9Vk7Dhcl/CxsM0oUbN3BhfdSYpN799HRxseB?=
 =?us-ascii?Q?V0SApyQrm19Jdb+JkuW3b6qjObTIEhJYpcFJ8vnPLP9BHVHXEF1s5bZFnbl2?=
 =?us-ascii?Q?34DHza5XIfxr2lnmg8KNd+34LNihQD1MK1i5bDMd/BHv4ta2QYazEfvZ7nU0?=
 =?us-ascii?Q?3l+fjmSVUGfnziGjfw6d/onppmLEXZJF4JUFIpB0hYqOXbhr0ofdscboMSWd?=
 =?us-ascii?Q?J4gMgLnil3KylswqFJAoEct8gqeWyPXRBVv2Zz1KC6i1y7OS4YojOXdBBO7V?=
 =?us-ascii?Q?bYUREymPOWk1EWncgmBvLByhOZLlB8mIgQvF9g1824wrKXpWO7dd8a8QmLlj?=
 =?us-ascii?Q?fgEHRSFD3LCkDOykBL58jZMsyn4ZJPoOIo2L4RVQC8xYdfvy3T9sZF4gwerf?=
 =?us-ascii?Q?kmsArohaQpTsRtrVkHVevlRN+F8FgoDdlIkpCZzF1ceClO8z76ZLJyjDWgda?=
 =?us-ascii?Q?fRi+R4PbVFaS9SKBk6c6PWPMvArTusePBYucecgIIgGih9aaEMJR+RCNQvQU?=
 =?us-ascii?Q?b7UYXz6CXXFKegB+A+90IRlkOG3CT4HOvcfQKrNewFLc7kLE+4z7bHOpIz+3?=
 =?us-ascii?Q?uYfpF4STx0IRl8idTM84prclEsDriDc0/ly4QQJaneq+YQFkKSoUxwtTwJjR?=
 =?us-ascii?Q?4G1uu2BL80ZsPiX6A1vEDqdk8U+jUaHlDO2akLDcEsARN6RAFiOVcwaJVRrX?=
 =?us-ascii?Q?SBQt7s6hL/cXJP3hsH9gdRf3ThdP/UPrgUcrotPG52HoIpTZ8lylUA+Cpueb?=
 =?us-ascii?Q?O7XLxhCEWeDuAlstBVZLQKDMH+7+MMyrCELDLdqqsgUROivlMrYdceSyxxRd?=
 =?us-ascii?Q?hzV4n4cL5GGOQAc4Vb7IW/z5eovtUqQnKUAn87v5AT6ulqa/i/knCJuYiPJS?=
 =?us-ascii?Q?WNqXG2Ilk69m4uSaOv0Xp2eb+X44l+ZieBk26UpU+xmxnhDeQZufqmDOBBlj?=
 =?us-ascii?Q?Qnk1dqpKzJjCDQXblqr4syGZ95oVA3PqQxXlWH0Bk9D5T2tqF/K7O+wyAkiU?=
 =?us-ascii?Q?JpivvdjxqCExqev0ZlaAl/aa8feuIcIlNmt0jWgq0+j9/UdkIFAIVewnn9kl?=
 =?us-ascii?Q?K0vumnjoajO2Jn04yl79B84Pq7xuibAd+4FjbDByuH6QYeitQFb5DvoWnHel?=
 =?us-ascii?Q?2dGuZvc0ZY+QTlJJ9d1/XPkfOT2yEzd1rfJL4xsynffgpM9XZr4/z3z5IWop?=
 =?us-ascii?Q?FPblIBFXqcmDj4bGv+n9bnRMYjZZi6Jk9bMdd2MU+WdvgdES6C21ZaWuqfgu?=
 =?us-ascii?Q?L5Zizp/Zs/7A7Y2Qusv1BWSxjagSEfnZHezMatGNqPGBNsAKq4IwRdD06bHc?=
 =?us-ascii?Q?JSJaKotHZ0F6djxHjsdqMy4HKVOzG0IQbMHx9HUOX9eKpwAAbKCN9WsP1/7a?=
 =?us-ascii?Q?DB8dyXCFPwdYSitv/QyLVQJJLr0C6x9UNhfE?=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SEYPR06MB5134.apcprd06.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(7416014)(366016)(376014)(38070700021);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?us-ascii?Q?uIOfIXrFqgK3WKAoVv37/ibqVQKsQ5xNta+rvoKQfNV65rTEPfsdT7oMU3k8?=
 =?us-ascii?Q?K4rYhBtTKFBLMZe+5Icix8R1kc0rq3AwfHENJOhxsw7vDUdKmtRhiwJcPcw7?=
 =?us-ascii?Q?iGv1jOVrpFLMLEJ+Hc/xeKx9tsZhC6dVcTKPprFT23yuo5fCqbufRBjXHKmU?=
 =?us-ascii?Q?333/QgU1/oJJvVcvR5nmpbVJGLz/EMpiDDMMSoKrEeRv8YlwdMlF4uEa/cpA?=
 =?us-ascii?Q?WnsLh07pHKo2HTdof1wEdDZvh8YZszCM9Coo0IQDJn5jKUJ5fmXX424HPp5v?=
 =?us-ascii?Q?d+AwO3YJwfjB9IR+WNY82BAshanklKQsYNx3kVWdjOPFHrYyxIpx+M/2B45A?=
 =?us-ascii?Q?68Hz+eGLO+alkpVGqSONMgEvLLpO7VDyAy2vYaq8VRxKv3309MzvP6uSnMZA?=
 =?us-ascii?Q?5Tej/1kH154XN1dKedLyYtCNt89fjP1UOJmR+t1hxbOnQe4YIK0aoy/MYQw2?=
 =?us-ascii?Q?xfg8eaczs5V5SITKepznigZliF52tCgCVps5VqjJ17HlCbgsUzTrSHkNGoHQ?=
 =?us-ascii?Q?Tnt/6wnYLYTa3uXLjh3QHoAiEVYNH6oLJsy9KK6CV5N6fTneCxkjtC3yG4z5?=
 =?us-ascii?Q?WYbOt/++yzw93H46ll5o15BOS64kmDNh4XcXtNb/TvWAbarH9emA3r8mIZaM?=
 =?us-ascii?Q?l7rNsN3/dO72a7Sg8U0QPPnXeSY9DQ3Hi2ZTGOunWeBqaGOahrZ4tC2VO3da?=
 =?us-ascii?Q?mNeTCgspG0xjls1ZhLDQ+cAMbPEhjpvygikpDKgHt3btYadGNAW6UWDbZ+Xt?=
 =?us-ascii?Q?8RdrbwGbpBZO9a2cUYGKwe0dzrVvLn/+5HQ1khPMfibqtz/9bnxVul1gimBz?=
 =?us-ascii?Q?f5mKs9rmxlSf5uNYB4iWKnPyA36PTEtlKVcjjzZhpD52G+l48nUPh8ZDlakV?=
 =?us-ascii?Q?8ki58LPjUx/CM8BiZ8xVcEI7p5uYMfJ/0SQnGipyDDfsGW5pZ/niwShIOd+d?=
 =?us-ascii?Q?O+2nH3pBKTaPgSvEgHik/z/JN4CETzTKH2NwoyB+RegZRP1ZXXtnlbczkdic?=
 =?us-ascii?Q?6IiHCONo3ti+jkHjX2mwk+DZqxqBw9qaU5XHaMDJG2/WbPXzqBm/mIwW5hPI?=
 =?us-ascii?Q?QAicF2ZAMI9eGzdc0i30eltMJmkpYc+P4qR1xKTayRz66re479lhfENHAXRa?=
 =?us-ascii?Q?qMAfHcGwF3sGe3uyyoGfFhoqNDPX1T7VMJ4Y/EuNCRbEGc+4ZF/DJikbU19b?=
 =?us-ascii?Q?u0RlkKN/UOQwYElGyvpT0eIifY7M6CkoN2yLBLA+bk1DKTyZPdKIJ33oYn0s?=
 =?us-ascii?Q?FRsgl5RCX10EeM3Z0MZgO+3Sa1BcVbMX1Zvhc7YmSYKMqJuphHSGg1EYlJn+?=
 =?us-ascii?Q?KZRCpBeBLMVo+d0WVVnzsP/nNkXzqhjs6PFyQVI288qf5Q+QV1Y62mgWB1w4?=
 =?us-ascii?Q?Reb6/2RMzrrmvT3WqVVQp36w14JcPBsVojAexW9FVbv+5rS3vl7dJ7KDlTlv?=
 =?us-ascii?Q?Csop7BsAy9Eq4B2PJeocPHbrINcEXxCCuuyjZeP9ogBpIAf4oBBp2Q+jmXYL?=
 =?us-ascii?Q?27WdIqP5o55/o9mMgLJnCGRVCWX8bm4NxZtJ+EX4M8Er7nkPKJmyU5srPh9f?=
 =?us-ascii?Q?yRvSP5UB5ATLP7CODsHOptaugyrRFKgoET5z5iul?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-OriginatorOrg: aspeedtech.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: SEYPR06MB5134.apcprd06.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 37ce0aca-f056-42a0-23a4-08de3607bfe9
X-MS-Exchange-CrossTenant-originalarrivaltime: 08 Dec 2025 03:13:24.5181
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 43d4aa98-e35b-4575-8939-080e90d5a249
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: UFMJn4UFijqFZC+0nl4ncrhYoM4/8ZVhltIjc+UvqgCVO0FKV1CMrxiRnqVszeP/h+7/9Sr5QvOT78lPM1OWl3w8GuOqJ30NzkRHGeA+DwU=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PUZPR06MB5721

Hi Andrew,

Thank you for your reply

> > The Aspeed MDIO controller may return incorrect data when a read
> > operation follows immediately after a write. Due to a controller bug,
> > the subsequent read can latch stale data, causing the polling logic to
> > terminate earlier than expected.
> >
> > To work around this hardware issue, insert a dummy read after each
> > write operation. This ensures that the next actual read returns the
> > correct data and prevents premature polling exit.
> >
> > This workaround has been verified to stabilize MDIO transactions on
> > affected Aspeed platforms.
> >
> > Signed-off-by: Jacky Chou <jacky_chou@aspeedtech.com>
>=20
> This seems like a bug fix. Please add a Fixes: tag, for base it on net, n=
ot
> net-next.
>=20

Yes, it is a bug fix on HW design.
I will send it to net again and add Fixes tag.

> > ---
> >  drivers/net/mdio/mdio-aspeed.c | 6 ++++++
> >  1 file changed, 6 insertions(+)
> >
> > diff --git a/drivers/net/mdio/mdio-aspeed.c
> > b/drivers/net/mdio/mdio-aspeed.c index e55be6dc9ae7..00e61b922876
> > 100644
> > --- a/drivers/net/mdio/mdio-aspeed.c
> > +++ b/drivers/net/mdio/mdio-aspeed.c
> > @@ -62,6 +62,12 @@ static int aspeed_mdio_op(struct mii_bus *bus, u8 st=
,
> u8 op, u8 phyad, u8 regad,
> >  		| FIELD_PREP(ASPEED_MDIO_DATA_MIIRDATA, data);
> >
> >  	iowrite32(ctrl, ctx->base + ASPEED_MDIO_CTRL);
> > +	/* Workaround for read-after-write issue.
>=20
> Blank line before the comment please.
>=20

Agreed.

Thanks,
Jacky

