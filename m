Return-Path: <netdev+bounces-151323-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 92D189EE1BD
	for <lists+netdev@lfdr.de>; Thu, 12 Dec 2024 09:47:23 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id AD0FA18855A2
	for <lists+netdev@lfdr.de>; Thu, 12 Dec 2024 08:47:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EC0AE20CCE7;
	Thu, 12 Dec 2024 08:47:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=microchip.com header.i=@microchip.com header.b="ToNrm6Jq"
X-Original-To: netdev@vger.kernel.org
Received: from NAM10-BN7-obe.outbound.protection.outlook.com (mail-bn7nam10on2084.outbound.protection.outlook.com [40.107.92.84])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 01E39202F88;
	Thu, 12 Dec 2024 08:47:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.92.84
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733993238; cv=fail; b=NCby/YUc919WWAPl4N46ntplcos1wZGg/lgFEisfMO9UJS4YdSJQlUh01Ongvgipnyvj5tzibCNA8aDr5Sm8DGQ13fAMHyrnZyJkgguuJAxnQJ/w+GKRyaCKErxAmLClx6YjW156AjhL8KwoIo+4RFOoEuB3soloc9A0w7XSjcs=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733993238; c=relaxed/simple;
	bh=FH95xah2fwbdijRkd+sdGKqle+/yD2uxsz4qXELj7mA=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=kEkTZ/o6QcN5v3C/fT7v8YBvBbRfr+k9FOyJXhORg1J+ec4X5yclFIbsmQwtPBDBHYxK2dTPNHZDiWk46wvrlj5ecwLTlnf8pft2N49QFQFkdB4/DuF9JHDLy/zAdKu2YMaboLw+u/tVe6oPnN2UutTGIufFGev/LOqCWAm00kM=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=microchip.com; spf=pass smtp.mailfrom=microchip.com; dkim=pass (2048-bit key) header.d=microchip.com header.i=@microchip.com header.b=ToNrm6Jq; arc=fail smtp.client-ip=40.107.92.84
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=microchip.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=microchip.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=crYs5pTveFCNwtozbcczy08txtN8KfZZd5cV2MkO3hiPFZq0FBjttdQyDs7ZMwh63RiT2MXAFHI3bgCJr//4CbBM46MW7Hd8xzRiwOZctKp8F7Gxy2ehpsKHGEDrnwoZpHXp8XQ88BgCi//LV9dqk+6E5Mp2MpoVzKh7Ibm2prc0mWpk8SazFUJMnGE2+3Hl4cDIK0GtODbjfUn/JE9sLal/IWDKtisF2lyEhzHPPQVAS6c6Fr7uXXiOG1St+AGAMQZQj6etOYA4ina1IDi21hVu/zf9y/sTS/U6KliebpwDkVie10h1uYVonBGMxx+WuYMzOkEZozvhvP5douSxlg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=FE+Zq2ScjBuR1PCJQDWOdp11R2YxtvDtfh1n3tK4bvU=;
 b=xuVGGc/4oYCFK63/f/OpTCCMhu3KhK/Lj1SWjUd4ka4UyKUlpPwH1nq5zVZgZGPp/ry2OdhcvMDWTACHd9sRBAjKylgyRDuLWUBWbmmJ3PbIWGGrz7Zy9t9GWxAizkP2TvVJLxDEtQZ21/S7x6Yd0hAy1Ksb0AKZgM4txcnCOV9EgTG0itMlPBCOMEtJCgrir2Ra9+fcL24C/Pf4roxyEmTSDrC7jLS5WAtsKFQM5O5beQI4Acssrw4FY/TCS4dA/kN2p3WWIm9S7GKrwTLsuQO1NXXW6uh+W952TufhazLwBRMyhAFdAHOi6bSkWMIuPTTvzSfT4DfAHfXmWegVkQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=microchip.com; dmarc=pass action=none
 header.from=microchip.com; dkim=pass header.d=microchip.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=microchip.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=FE+Zq2ScjBuR1PCJQDWOdp11R2YxtvDtfh1n3tK4bvU=;
 b=ToNrm6JqebuxKgRpRUs+GlhFrJy+igjrt9l5hkKTDcce6KEoZ6iY2t/Te2tw9D4Oj9JMCQiG/4ot7kTOaiUhpJsUw73RXR4FqFQL0krRhKl8Xjn4M5K9ym7C2AEdRCt1xw+DcADXOZjYhm78umEpZDUHLBXeJ/zfHEG5C+2CsRfnshQg4W9D53PbYpWhgJ2qVNqmBCarVsk4DVMvoedjlFdsw47Gp7wh8/sBOnEEXFSLB8iLHlOLVRnEEifUlS2fFW3I2NanMUcLlzR1Ta1wrIvAo1g3R/U1yyiiZUz1iFPQ0aTAptpE+bI1gEO6+ipkZoz2VZfkeJvNAnZBQ3RYtA==
Received: from DM4PR11MB6239.namprd11.prod.outlook.com (2603:10b6:8:a7::20) by
 MN2PR11MB4661.namprd11.prod.outlook.com (2603:10b6:208:26b::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8251.16; Thu, 12 Dec
 2024 08:47:10 +0000
Received: from DM4PR11MB6239.namprd11.prod.outlook.com
 ([fe80::244e:154d:1b0b:5eb5]) by DM4PR11MB6239.namprd11.prod.outlook.com
 ([fe80::244e:154d:1b0b:5eb5%5]) with mapi id 15.20.8251.015; Thu, 12 Dec 2024
 08:47:09 +0000
From: <Tarun.Alle@microchip.com>
To: <andrew@lunn.ch>
CC: <Arun.Ramadoss@microchip.com>, <UNGLinuxDriver@microchip.com>,
	<hkallweit1@gmail.com>, <linux@armlinux.org.uk>, <davem@davemloft.net>,
	<edumazet@google.com>, <kuba@kernel.org>, <pabeni@redhat.com>,
	<netdev@vger.kernel.org>, <linux-kernel@vger.kernel.org>
Subject: RE: [PATCH net-next 2/2] net: phy: microchip_t1: Autonegotiaion
 support for LAN887x T1 phy
Thread-Topic: [PATCH net-next 2/2] net: phy: microchip_t1: Autonegotiaion
 support for LAN887x T1 phy
Thread-Index: AQHbSlZZlZ6PJbgtY0e39k2j/3+rdbLeJg2AgAQm8BA=
Date: Thu, 12 Dec 2024 08:47:09 +0000
Message-ID:
 <DM4PR11MB6239DA6E088BB0D420773CE98B3F2@DM4PR11MB6239.namprd11.prod.outlook.com>
References: <20241209161427.3580256-1-Tarun.Alle@microchip.com>
 <20241209161427.3580256-3-Tarun.Alle@microchip.com>
 <1d230d3c-740b-4876-a0f7-e48361b6d238@lunn.ch>
In-Reply-To: <1d230d3c-740b-4876-a0f7-e48361b6d238@lunn.ch>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=microchip.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: DM4PR11MB6239:EE_|MN2PR11MB4661:EE_
x-ms-office365-filtering-correlation-id: 76684306-6778-4a0a-6c79-08dd1a8990b2
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM4PR11MB6239.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(376014)(1800799024)(38070700018);DIR:OUT;SFP:1101;
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230040|366016|376014|1800799024|38070700018;
x-microsoft-antispam-message-info:
 =?us-ascii?Q?o0HsyaQZIXdYxyq7HoJnT3d8dgYnFZBmRPuKNPVFDY9V0b02FNTMW+/Bc0J0?=
 =?us-ascii?Q?TjHDNY3wyfDdl5zA2yUrmJIu3hcnEERird8nSjuiTc+sdUF0y93ICTmxi/2+?=
 =?us-ascii?Q?en/kyK1REemES9w5rZIP/Uw7jppDvbF+M3f5JmhaN/xjcvTQMnzqF1xBVcCC?=
 =?us-ascii?Q?A6Xy17L4NHLBiAuH84jNZD5PhLIFpFJ0QtLPhxNZcfwUL+Aa6z1+Efallgqv?=
 =?us-ascii?Q?avvZQK6+KruQ3iJuNd1qNx8u+SSJGQy27V5LTgyxtwyva+tlO3sH7uStEbXs?=
 =?us-ascii?Q?jd1QBR6Jly9jUAbmuKmYe+mOvW2qMoSXZDwsDRR/NJ4hilymL6fryoaXy0Oz?=
 =?us-ascii?Q?oefsysrQcMihUE1vgn2Ly5HWUBXL3qn7iU5us26041uDAep1JY4+5TBQH/Cd?=
 =?us-ascii?Q?DqZ4Ru6DyElgZX1TpYOXm9qtP0w0VPGo9s2fVAZvibP4myRty7pb5FlaQ/A6?=
 =?us-ascii?Q?0Fa4uq3E/L+SUzpJ6wL2R8WyO+9ql81PAneXMeDYazfXDugpWx+oFg6wyow+?=
 =?us-ascii?Q?md1lmyZP/kRL1+ah2V7XEbdCV3NXTiz2Oxw9CMZTVeI7Fxl0KcOJhueqlJOn?=
 =?us-ascii?Q?3oWSqjWJCfS3nWxdJGK2MbLKebP6yFHsXQiWUKU7U8vdOh6Syeb0s8lraJSN?=
 =?us-ascii?Q?z5aCg76+5GtPY6SwYUN+iimNVVw2CDecMJYmVC3b4rmrw9SNBxaPUfguxKQu?=
 =?us-ascii?Q?QmhzJtr0dftBkgPWv9JLCxC693RlVwgzpKJCzEUrxS5G0b2whXs5WIPSKrXX?=
 =?us-ascii?Q?p37ZhixrGnqcvDtli3eJ9rCgbSpM0f8ruQitVMW+ZhFMO/4F0mZ0hVacmJZO?=
 =?us-ascii?Q?acfztf8NJlwRliwRqsTOC7CpYK2+DhQp28ZL7AkzGlBSfnV4y3aG8i6edUV0?=
 =?us-ascii?Q?czbCK/ciMtJoCoW27elA5hRXlwuHGZHpZc7UbaAnxeZSDf1f+vk06V1n/zXo?=
 =?us-ascii?Q?mlXnMziwl16k+llxiQ8P2tcOdfKKrbFXsbHYd9ToLvrwvV3YfcoQcMZVuuXp?=
 =?us-ascii?Q?ybyXD7NznYN+uiJJIR1CUSsheVEC2ZJ//Lm6CGkOKRykfOr4JcGZpqsdrXov?=
 =?us-ascii?Q?zwW5z4Lzsn9qo3mcOQyNwjw4d1Q+uszkkSG9nUwuw3TysAxBHCocseTTxyyX?=
 =?us-ascii?Q?cSS7QrxLcXTBUYbFXzactKTWwNdJHbC0DEqnZiGevO6H8Xb5/kQ3hFVCS4Ar?=
 =?us-ascii?Q?bk+xE9+v12LiPxSsDLn9o8rb9R/d/BxSHWl5zAImyfCiOkO7N86vgy/cR2BD?=
 =?us-ascii?Q?V9vroe3+dpqoSLuIV3omVvpqr3k3Rz/tqHH1LreMVvCpuCWniEsx8QH3deRp?=
 =?us-ascii?Q?CBSdLFsM8CpijufXTiqIFWXV8X9/W9va+0wTnDbxGSs7SHTyBTR/n5o9cCk9?=
 =?us-ascii?Q?1OVb5LMM0Sjtw3abEsbMD5GfzHQFfLR+Y0W6XTziQ7C9zyfoLA=3D=3D?=
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?us-ascii?Q?K7rJ2dlQq+KoSPBcPwr6kYyNngzVci+bcW7ItACXRSNQ6lGg+TNkPsz/Z1Fv?=
 =?us-ascii?Q?qrbyMsycG9qql5BTiZ+vOiLAbL2MJhVUuzm1QqQBj1VtaF+mnQoCHVzh0Dq2?=
 =?us-ascii?Q?1hdH60HVcruLR2Ss6miVIzfP+09by7Bsbo0nXZZRBN5Ay8B923vCA/EU7r/k?=
 =?us-ascii?Q?LrvPwqILQp4J/NjtBZ4WTiE07vBwoul+GeQhfSBVZCiu3IDOKEhweqrYStHo?=
 =?us-ascii?Q?Q8bOu18JMJXO5+PBfyvPZCfELpQlZdXiEFZOlIJX5ygHvHwSb2FRC8z+N9Sj?=
 =?us-ascii?Q?yHEm/kLLWe4SHXOBfZeCBrJn1zzm4airbsYBCmekt5p3w0XhjdZlqLeS1pJa?=
 =?us-ascii?Q?L0vxIO57rrW/Yws8xIuNbmV+iK09jWBHHQuG+ltln9xdgRQhCGgTbMiKt1BM?=
 =?us-ascii?Q?KgEFIVs3Q8c9S/AZBq+K1sZ0yfR5VIMeBY6mE1ySAj5MXJvxWSo/LFIWBNSQ?=
 =?us-ascii?Q?V8wfsoIjKMAOZfADEbMrdeZmTk9b80tekQuwGIt7WV41A/vjeG0N/ifLSacb?=
 =?us-ascii?Q?xGv9uKZRn/V6oBcSS0xt+INaOAUFGUpyNJLGCJimSctfKYQWFjCJ+lshLWO1?=
 =?us-ascii?Q?VDnqxIaReaQTjy2w2CIbxRbuHs0v5TIRTbJUfdaE2L9Cel+gYCYR1oqyFMD4?=
 =?us-ascii?Q?wtkFVxigvLEAAkFqC11J3x16ySF3Ig+r4Obosyu1H785ouCg8+30Kw15jc1C?=
 =?us-ascii?Q?VYEhQJR7A/FDgbZwaZxb9n4/xisEQDZzKpnoHrfd0jzAWXg2w4hboc/M9fia?=
 =?us-ascii?Q?4yj9/AbmlQ+vG0Aas6OtIk0npTMgRmLrQp3fwO2N7eISgQC2/UTlcRkeOdIX?=
 =?us-ascii?Q?2tAmboxFEhCrTQsG+ipMxPw49dvvuZl8X9s7n+A1VvkBeim+GfR1Gg4trW/g?=
 =?us-ascii?Q?7MBptL/k8aX4ltSMciayo34gqyFSecYS4Kf1GFe682lmt5muTUo2Idz0FZUC?=
 =?us-ascii?Q?eDeq62zpJNk2bfzcdJ5tqm+PXd1ma1w4/ZFfuqxTvC+Wcfcffgyfwjggj8Gh?=
 =?us-ascii?Q?mEzK54O95HVjIebH5z79BCGy2y67pvySAnYqWKuKQd9385qghK5NRd6IoKvF?=
 =?us-ascii?Q?kSmm2Az9jnlwjQyoGGz2RFK5AE5KUhx8GoMHQGijVoAQItdmBF2XIhLagirB?=
 =?us-ascii?Q?UlUpAtxSqtD/iXLJDQ/UzmRSEKoD1kSD0Df6Z0JRYQqJZErDhg2Lk1YVL7Yu?=
 =?us-ascii?Q?AdJIIFwB0toZbw9EpY7J+iYV0KxJZbZhjegjuzD89sL7/pRB9GtEQs/Ov7GW?=
 =?us-ascii?Q?oY4L+CXDoLyS/xKkUrghQ0Wc/QVp+RBsuyJsniNUpJkRsw5dH3ik6X0NKtcy?=
 =?us-ascii?Q?lgGplQbKt7B3pbmFrHpwe8AXjonOanEaKryJK+MppY0lqzONZFkJVLKzwXL+?=
 =?us-ascii?Q?U98fpF8psTC7MKc5m7NsUVNdeQZuti6fAyvoJ/RxSxybBHYcWCcczxzhtmCB?=
 =?us-ascii?Q?aCZWBT4m+KjlOIs96fCgPQL/0UjHT+oipV5pG6VQq8H6e7U5yPqTAfP9Gwam?=
 =?us-ascii?Q?XVpKOL9ukAeeY0JTpNxdERJTQ1rNoFNHX5hYT22CWnRmE2ThJvFv81ZfsF+i?=
 =?us-ascii?Q?t+Mr+kLnltrk8a59qNFgmOKNaKNDXQzvS0Ee1BwN?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-OriginatorOrg: microchip.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: DM4PR11MB6239.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 76684306-6778-4a0a-6c79-08dd1a8990b2
X-MS-Exchange-CrossTenant-originalarrivaltime: 12 Dec 2024 08:47:09.6917
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3f4057f3-b418-4d4e-ba84-d55b4e897d88
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 52whQTsIn0G6Ksr+e8af1T2JmKzVdKnkbAX5xCUwmBh3MTaZXYrUA+Dnll9Ta3j2l1BAbAuj5h+hU4VALVrFWRvGVPh3c4oI7/CY6p3ThCc=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN2PR11MB4661

Hi Andrew,

Thanks for the review comments.

> -----Original Message-----
> From: Andrew Lunn <andrew@lunn.ch>
> Sent: Monday, December 9, 2024 10:41 PM
> To: Tarun Alle - I68638 <Tarun.Alle@microchip.com>
> Cc: Arun Ramadoss - I17769 <Arun.Ramadoss@microchip.com>;
> UNGLinuxDriver <UNGLinuxDriver@microchip.com>;
> hkallweit1@gmail.com; linux@armlinux.org.uk; davem@davemloft.net;
> edumazet@google.com; kuba@kernel.org; pabeni@redhat.com;
> netdev@vger.kernel.org; linux-kernel@vger.kernel.org
> Subject: Re: [PATCH net-next 2/2] net: phy: microchip_t1: Autonegotiaion
> support for LAN887x T1 phy
>=20
> EXTERNAL EMAIL: Do not click links or open attachments unless you know
> the content is safe
>=20
> > -     /* First patch only supports 100Mbps and 1000Mbps force-mode.
> > -      * T1 Auto-Negotiation (Clause 98 of IEEE 802.3) will be added la=
ter.
> > -      */
> > -     linkmode_clear_bit(ETHTOOL_LINK_MODE_Autoneg_BIT, phydev-
> >supported);
> > -
>=20
> What are the backwards compatibility issues here? I would at least expect
> some comments in the commit message. As far as i understand, up until
> this patch, it always required forced configuration. With this patch, it
> suddenly will auto-neg by default? If the link partner is not expecting a=
uto-
> neg, that will fail.
>=20

I will update the commit message.

> > +/* LAN887X Errata: 100M master issue. Dual speed in Aneg is not
> > +supported. */
>=20
> Please could you expand on this. We are now doing auto-neg by default, an=
d
> auto-neg is somewhat broken?
>=20

LAN887X Errata: The device may not link in auto-neg when both 100BASE-T1 an=
d 1000BASE-T1 are advertised.
Hence advertising only one speed. In this case auto-neg to determine Leader=
/Follower.

I will update comment as mentioned above.

>         Andrew

Thanks,
Tarun Alle.

