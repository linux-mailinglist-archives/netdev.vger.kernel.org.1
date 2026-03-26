Return-Path: <netdev+bounces-271977-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id ELRcDFUOxWkI6AQAu9opvQ
	(envelope-from <netdev+bounces-271977-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Thu, 26 Mar 2026 11:45:41 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 9151D333B07
	for <lists+netdev@lfdr.de>; Thu, 26 Mar 2026 11:45:40 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 6D50B30E9B31
	for <lists+netdev@lfdr.de>; Thu, 26 Mar 2026 10:32:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D67ED3D2FFD;
	Thu, 26 Mar 2026 10:32:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b="k63QOvfR"
X-Original-To: netdev@vger.kernel.org
Received: from AS8PR04CU009.outbound.protection.outlook.com (mail-westeuropeazon11011029.outbound.protection.outlook.com [52.101.70.29])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 65E7B3BED76;
	Thu, 26 Mar 2026 10:32:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.70.29
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774521167; cv=fail; b=uGsCaVhNw/vJcMpivTU5toeh56iltoQXlAVsMB6YRJpx4Kftxy4y44erLISUseQEXpX4iSl9aC8F5svZ3iwNSNLe7Eqn7FS8Sl3QsLIKOdfhOGhkvklLGmmahJuV9HWua7MhP7uRDj5Po+3zq0+2CLtkVBwOCiqSj8ca9oq3Fs8=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774521167; c=relaxed/simple;
	bh=Sg7SaSet/gRfMrkUPkml85bn6sOdqIxUGJx5Y5jdJnM=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=FQdjtBSpGxKYNQDjB9CrAiXhnCJvDlMRG0a0JlWIndqrS/6NEa+8ix2iVXd2rjJ9A0AeJjv1eAREIsbsQ45PyWHBWA3NdywhEmrwdSjsIjMO1vxgw+GJFYSjhNMtAXUh/2iVQmh4zGRlYjjqSshH45zwbape5tRw9ljJ60KSWDI=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b=k63QOvfR; arc=fail smtp.client-ip=52.101.70.29
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=TDkX1FlbyS9TKunN2uQIDNekkEZSpfUsbnJdjYfWpmeVPVEeutZMw15UtW5F1oNTWn7TuKck/OByHA35u3SK6ECdxUjxafcZekG+W3D1Oy/cgZk0p9eb/YbgHqKzHvLeRszYYgdVnPaS/GQCh4nZQW1dbGCHLNlAZnDGD9eJ23+4QEDBrnStfzy5kYLgcz3UYoOlKV35vwbD3PQQ8Pg8FJF6i+a5R2r5V0VYOnv/l7J72gUjWp/mdDpT7Q7iOtWc6ngVCZU+R8idC9ACx+I2j6db8dHGLY6nnbmnHsFp6OeCYIwNT8nr43mNkHrMA2WdDDsMPUKpgF6DERA3Xa9XNw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Sg7SaSet/gRfMrkUPkml85bn6sOdqIxUGJx5Y5jdJnM=;
 b=Vc64WsDYPxGANBqBBWsxYmA7WasWhloUFdgNWQgDgMlKHSyvAsk1t2WkQpg4BvodXq8EHoSYyiqPGyzFBi8/7FhsGe9k4sUWhlyardxeKaMjIH8kg7XgmqzHgW3OELxZ5H7bU81TK+MYjRN/EmGI3CdQEQ62mPW393gHpaDbDrEY+YsTlWm9MOjzfrgMb2enfcOC5UA8HKE2c2p8y+Q1eWky52TYUNLMAnYqwkoL1hc6g012ZTMSxP/vCUvTDZLOSQpvoCpflRneGiydFraRyFYIgLlOaW+1ZCc1bO8k5c/7EW3XCWpEnW9lsMq99A+S3bgNarQ/i02HBczKs/UYjA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Sg7SaSet/gRfMrkUPkml85bn6sOdqIxUGJx5Y5jdJnM=;
 b=k63QOvfRpBPfYUWCXMShxsvVviS6+ttmbuntvGwefG0t/aO4TbZWeItjZXM+R06vRicajkxRJmILMts4ykgNOjonfxhNghZ2DzBn+8Ti9WDJ/tiWDd59y8kkatkc80IL7nuRDoE6Vgd/1PQ/BlVTM2Jxxfb6v27/qWihd4LQivjGIq4Z5NLWnfV6/ZceIX7yPUw5mzvyVEhePa3N4isKzpAqwfSa1TiHIhSrgx1QNCunJH27uug7gg79mRVzs+sUMop0HqU9shSt6SxE5DYLgqGOBHu6c9SOK0hODKVzm0giyC5fuzBXPvch207vG+6rEBzItOyuG5VpjNjZRhqf2g==
Received: from GV2PR04MB11740.eurprd04.prod.outlook.com
 (2603:10a6:150:2cd::13) by PA1PR04MB10225.eurprd04.prod.outlook.com
 (2603:10a6:102:467::14) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9723.31; Thu, 26 Mar
 2026 10:32:35 +0000
Received: from GV2PR04MB11740.eurprd04.prod.outlook.com
 ([fe80::ca5f:7e1c:a67a:a490]) by GV2PR04MB11740.eurprd04.prod.outlook.com
 ([fe80::ca5f:7e1c:a67a:a490%6]) with mapi id 15.20.9745.022; Thu, 26 Mar 2026
 10:32:35 +0000
From: Claudiu Manoil <claudiu.manoil@nxp.com>
To: Wei Fang <wei.fang@nxp.com>, Vladimir Oltean <vladimir.oltean@nxp.com>,
	Clark Wang <xiaoning.wang@nxp.com>, "andrew+netdev@lunn.ch"
	<andrew+netdev@lunn.ch>, "davem@davemloft.net" <davem@davemloft.net>,
	"edumazet@google.com" <edumazet@google.com>, "kuba@kernel.org"
	<kuba@kernel.org>, "pabeni@redhat.com" <pabeni@redhat.com>, Alexandru
 Marginean <alexandru.marginean@nxp.com>
CC: "netdev@vger.kernel.org" <netdev@vger.kernel.org>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
	"imx@lists.linux.dev" <imx@lists.linux.dev>
Subject: RE: [PATCH v2 net 2/2] net: enetc: do not allow VF to configure the
 RSS key
Thread-Topic: [PATCH v2 net 2/2] net: enetc: do not allow VF to configure the
 RSS key
Thread-Index: AQHcvPU+NGFPB7XWsU20tygwDiCkj7XAnZhA
Date: Thu, 26 Mar 2026 10:32:35 +0000
Message-ID:
 <GV2PR04MB1174060F6CBB0CD1F52F950E79656A@GV2PR04MB11740.eurprd04.prod.outlook.com>
References: <20260326075233.3628047-1-wei.fang@nxp.com>
 <20260326075233.3628047-3-wei.fang@nxp.com>
In-Reply-To: <20260326075233.3628047-3-wei.fang@nxp.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: GV2PR04MB11740:EE_|PA1PR04MB10225:EE_
x-ms-office365-filtering-correlation-id: 939a3e2a-ffbc-45f5-8a6a-08de8b22fec3
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam:
 BCL:0;ARA:13230040|376014|1800799024|19092799006|366016|38070700021|56012099003|22082099003|18002099003;
x-microsoft-antispam-message-info:
 axBcDuAJSEb2GGOFmZRdYZdoey2NFnxyFOvkt+sAfuHZsu3/UNnTGgurqH6TgQ/ICol54zzr/xpkGqVsoC5hEBHHB+AQzic6s0Unqo21WEXBZEHmqU9/DxqD6/68OmUghvgHM0Pnnyudjbiv6RGqrmctT7DFGFxKUfXDYjBto4U/os1FrMWvHutn2Q5l0xWRhuXnd/VuOc1zsvaYsUnNclD87TFF3Y0ZoVT19uD4cfTaxA4D9M9tc/BCPvmIhUck6/DcsVAXp9Lg5ylZk4I2oC05C40vMUaqptMK7xImyX4OnYeNwD+776qmX44Gdnoi/akede6x8hy0N5w7C2legm3TRYui72KGp8XzUew9e2O5bwiULkYMBkQG8xd+HaeSmgJ4wtRFIN8fchGaIRZv6/LTq6KOfz6pFs+hl8RA8Y1oONO765t8+/DjjPzj3uvjApvUNgmgzAIfP3081cWHNsu1Q3rXTdxFJgRlYrNO7+mxuIc11k0AR0wRrIjxnTF179+84rIHNEiFLBNzYULk6qHRYGZRlQCX3eYhIz8P58WH9l7OsMk6HSYL54gSbcqKdLqbFYAZuk/ITrWHVsMSptBDgaoLpdro5Yh30y+c2X6gwGdvaA+694fsxnBh3cmOl0NO9dJTFAmDVtR6FeBRYFBIiPIcv4PZdu/aw/13t5A5o0us2Dt4srSuDu9JTRyUwj/4GHS0We4Qk7g7kQkIFjRfF+vE1pfmv2qqKDsNykh9lKHv0h7BlSCIgPj/Dipn4Gm3fRAfjDzJv6nxOsMPk9iPbA+Uy7Abbbl+/DDFYKw=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:GV2PR04MB11740.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(1800799024)(19092799006)(366016)(38070700021)(56012099003)(22082099003)(18002099003);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?us-ascii?Q?xfX+mQp85OGHlcLXBBND3j6WK2vhjECh+qcwIwRMvWp1jahFzkFuzKCt1PJL?=
 =?us-ascii?Q?pPgqsqcQkcAgqj5qDl4X7xh/HfFs3YuQu3fSxJOoxkM6HUifQo0Rpvlf2DKy?=
 =?us-ascii?Q?kPE4u2x721OQ4UKqpxm8miJNs25rMTNuIjg1fm+CgtcB+xzoe0MtDGcyvifp?=
 =?us-ascii?Q?1iKznj4/J9b6yTPVhzTV92gM9O+lPHNHR6pdrzss0+2lL3woktOKfPlGd1dz?=
 =?us-ascii?Q?3s4xe1ppIIt/16Jl5YBGu2arU0m9/M3NcQOaCvJrzBaFuWf2iXMX+4jTZ9xn?=
 =?us-ascii?Q?oW1S2xXavQnIVGNHt6CaUWdEk3oBqL3D7hu50FOM85S3d/+jrzjz/ebrX0D+?=
 =?us-ascii?Q?kMVovFcFkf0jJLSV6+ppZg0NpZ22ILa7xNE5Vb3KlZQujyaM7yfK33TqtRrW?=
 =?us-ascii?Q?/b56p0SHKq7TRbHCK0/U5rFPvkwPZnGk/YUzNupoJJpspKyGgR6HaSg2HMQa?=
 =?us-ascii?Q?GpLEmPzr328uV1mbrLrIK+9y9XxkkBMtw1H1U+Ony145gzyxKQh0rmCKT7ZO?=
 =?us-ascii?Q?7Ly50r3zOyRpF1wRfOdYeEAvq48d/0yMc6MoiGcUeZa1WKNTF84JgDUkGHXf?=
 =?us-ascii?Q?aZPTiIhmzHG+q2fbZM64PBOgpXEpdPCliM0dhcytLS474gEPtk13yuDnECrK?=
 =?us-ascii?Q?JIQrCJ6M27eYo8jTXgXynlHXDyLMTymqLJuOn8eafCzl+E9+ByzyPGSOxYcq?=
 =?us-ascii?Q?lPtvpnGxcJt7V9T3KlxhQlyqleqNVsO6DjiZ1Ln+XbbqloBvHg5ipWZfWlQN?=
 =?us-ascii?Q?g4Ezy1XBBuH/ngXP+9h/fbYynQ2Aq1wPHs2X5VqlXIEEZJDgZmBS9tV284sX?=
 =?us-ascii?Q?jAp9HGfwHitnqf2zFANx6iKAwsJWFIGLNv3Zm5Ydhkb0I4eGwsOgUMRlPaXo?=
 =?us-ascii?Q?Hf/CCllK5KaYM+Qa/iTMlJuoQ5z7dkc1WR051MNEj6NGPSOSBQX1oeH+C9Z7?=
 =?us-ascii?Q?AatRZAm+nLnSEcVme5IuJEEv3GX6EqNVV3SoIkwhFLS+WPsIbqNYnIojx1L/?=
 =?us-ascii?Q?+5pIe54835ks3jDsUHudWV8iP3YaaKPe20IaAGcrlrzTaPa+uh1OqqubwhpX?=
 =?us-ascii?Q?CHQO7VVXf73rHurIlAae7EIqBZ7mIF8bOTNrw3SOearJeNi6huF3rgVlaXWw?=
 =?us-ascii?Q?93Pn3hPPOr0E0gD7gXDVB4gMtQ4O32neSr8OLj0yrM3jv7JO/rHsHJPn82Lc?=
 =?us-ascii?Q?YqrcoDycl6vyiEJjwQudxyZyfuD++Do4a95x+p24p+qcH75GwaVjwqoFvJjj?=
 =?us-ascii?Q?cT16EiPmPzt75HTXP2Has4xqnm72PFRib24c0oklez7U63p+2yMgNI14tMbq?=
 =?us-ascii?Q?yONLinKwK7SXy8AG3DmIBkMHXip7RhUS8wxZ3sehM2zHp8iWdyxXRKtChY9u?=
 =?us-ascii?Q?7UwB8DvhM33Xza5ZmJVlbPP/Ka6vzjS8esx3Otk6Nl4BVwJ2RW+XyYjTQKVs?=
 =?us-ascii?Q?OIFuzC9I4xZRjlJIGNdc/krO5SN+irxITH/jNeZkN1JGZkCR01SzfJzBkxsP?=
 =?us-ascii?Q?I9d0iDJWsNmn8Lbp9lCyEszD2Hqc7r2MawbsOOemK5DDlmpmSOCrAoZjCr7G?=
 =?us-ascii?Q?3jYEsmWLP9GdOiQauRzUBVqG78YrvIhP4SPO8740ixP/mYDNAvBeiOKTRssH?=
 =?us-ascii?Q?aeY/2u8PmI3MfSNau0q7oDJdhA9hg7GZ8p+HGfGSjJ4TwRxOq6f/9AJRGpR9?=
 =?us-ascii?Q?Ic6uyAW0CBuy88V48mZ6bsGKNfwuaelLHTI2FFnjAd1jhOkjucRLHAT67DLj?=
 =?us-ascii?Q?wTHivyTa4Q=3D=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: GV2PR04MB11740.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 939a3e2a-ffbc-45f5-8a6a-08de8b22fec3
X-MS-Exchange-CrossTenant-originalarrivaltime: 26 Mar 2026 10:32:35.2173
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: SJ+cwXDCVEhA+TAFRN9lf7vf3qAyfkqibJ5WnAWHzO97CerPI35hOEhAptQa/dkLza/HHc87ameMAWxyBZ1lZg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PA1PR04MB10225
X-Spamd-Result: default: False [1.34 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_REJECT(1.00)[cv is fail on i=2];
	DMARC_POLICY_ALLOW(-0.50)[nxp.com,none];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	R_DKIM_ALLOW(-0.20)[nxp.com:s=selector1];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-271977-lists,netdev=lfdr.de];
	FORGED_SENDER_MAILLIST(0.00)[];
	TO_DN_EQ_ADDR_SOME(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[12];
	MIME_TRACE(0.00)[0:+];
	DKIM_TRACE(0.00)[nxp.com:+];
	MISSING_XM_UA(0.00)[];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[claudiu.manoil@nxp.com,netdev@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	TAGGED_RCPT(0.00)[netdev];
	NEURAL_HAM(-0.00)[-1.000];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[nxp.com:dkim,nxp.com:email,sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,GV2PR04MB11740.eurprd04.prod.outlook.com:mid]
X-Rspamd-Queue-Id: 9151D333B07
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

> -----Original Message-----
> From: Wei Fang <wei.fang@nxp.com>
> Sent: Thursday, March 26, 2026 9:53 AM
[...]
> Subject: [PATCH v2 net 2/2] net: enetc: do not allow VF to configure the =
RSS
> key
>=20
> VFs do not have privilege to configure the RSS key because the registers
> are owned by the PF. Currently, if VF attempts to configure the RSS key,
> enetc_set_rxfh() simply skips the configuration and does not generate a
> warning, which may mislead users into thinking the feature is supported.
> To improve this situation, add a check to reject RSS key configuration
> on VFs.
>=20
> Fixes: d382563f541b ("enetc: Add RFS and RSS support")
> Signed-off-by: Wei Fang <wei.fang@nxp.com>
> Reviewed-by: Clark Wang <xiaoning.wang@nxp.com>

Reviewed-by: Claudiu Manoil <claudiu.manoil@nxp.com>

