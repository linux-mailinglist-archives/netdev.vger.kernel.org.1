Return-Path: <netdev+bounces-268175-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id uF8CJ04RuGmIYgEAu9opvQ
	(envelope-from <netdev+bounces-268175-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Mon, 16 Mar 2026 15:18:54 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [104.64.211.4])
	by mail.lfdr.de (Postfix) with ESMTPS id A686429B33F
	for <lists+netdev@lfdr.de>; Mon, 16 Mar 2026 15:18:53 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id E286A3040F09
	for <lists+netdev@lfdr.de>; Mon, 16 Mar 2026 14:13:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 27ED139C639;
	Mon, 16 Mar 2026 14:13:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b="AbYcd2v4"
X-Original-To: netdev@vger.kernel.org
Received: from AS8PR04CU009.outbound.protection.outlook.com (mail-westeuropeazon11011040.outbound.protection.outlook.com [52.101.70.40])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BA1C639B976;
	Mon, 16 Mar 2026 14:13:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.70.40
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773670414; cv=fail; b=H85bb368d69aKre6kz/NdS8fUWRHewBC7kGCzNu4pEsugMUM7Xt54nAhCEbKQczzwL+0gagvEW3JiiALphYt9scxe0Qyp6ZxnGbZRb/bUR3OqREYRbtRNYBw5hIORrzZ5eJJZZiksO+a+K6IniALHStPE8qz47UJL22ilkVh4Wc=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773670414; c=relaxed/simple;
	bh=KO+lMYATLJfsLYD0XxP9SUE1Ffhx8TfhVMCn1p97cmg=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=fH+aNVaCrbYSvQdygLXQCkGZlu2C0IP+7hvGTJ6sMOGvE+YCHKjOxqMBsAkF1pNi3iSZHX3HzO3EuKzMFV/75tfm7mnk4vJ1deWcyY8dESw0/fc6gp2x3oq/192bdOAkEoikacZWJrxSfrwGA5C29r8K4dRXqPXig7J+McwM5Qw=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b=AbYcd2v4; arc=fail smtp.client-ip=52.101.70.40
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=EOf05OGXx5gll7urox7tZ3MVgrUa6Y4NoV6DCV7iKd8X0loUCGHlOYj9RSYiMz+4fenk3WJF1kNkiiqm4PB9ZyF+UPlgJVjCME2l+ogpGgEEalLOv3Lls4r22XUkQFLq2nMdzY78rN4JS7Ex0V5aIORG2agR/GgwdzQL63zavHXGSBxocJMr4wIJR/lQDt0bMUo8MIb7DSqLNt3HMPdHHp75DIJyYz8Sh9+UnJFDh4NNlfGyDA456SWIfOOpo/KnEF6BySDuqnznkFPhSFApf8wjbD5tNdHtfi0Ugfc58HpsCN6IHhSvHjRk8hTGv/GtQKWzUo2zA5AgyQ5f/w1+2w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=xDSmupIoZZh7U62J/sRJ1HNzBGNLXKzwBB1uGXEWUiU=;
 b=BWKtqKUZcBVmtUv8qgS7AP72qJLnwZz61qSMRRBWFadEC9JShVGpYGlRufuEl4h/G4+EpYAmWAKD2htX+8X0kItktc9FwKeWTvGcagO7uVbjW4HM6ygKvX9VulMXsKk36S5kqZwtrFB/nIIhzUiS0a4V1h2QMyyAbvVZeqPea5uJeh6SNek0V4RQ65UDky2t1DmEjmR9a8BPMasFtYrwrgyT7ncwl0Bap7lhJGKZtAG1bvDO6IZdtnA9DsRxno8DMqL8v8cNZJ24XVi5bf9ZZcqqSgtmKEGH5RWb5EOVbpUFjdafxTma696iMLy0ACDX5uH9RBi/QnY2fpoSm84D9A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=xDSmupIoZZh7U62J/sRJ1HNzBGNLXKzwBB1uGXEWUiU=;
 b=AbYcd2v4iTQxIRNzlxDSH4x+1pcpoG49NyZnkPLM/SKaxfYFWYlix0wEbfmzNiAJGOuQRiKoZiKTqxfVE+MwbxpCkYLIsIq5a6f2kivaqUVOy0E5rTy2q1tJ23brzlYSImQ4/mt7W/lKpnSbnRdcYy7uzre3S9WpmfR7bOjF2akY5J9qfGqPzndvpwY4UDRr2gM/Nfb5y9rNJN90qCRRZRusBL/nAhMlcCgy9X96iqoY2NgiR8ZeURlWenBYAJkzxL/+P9y+8QvZsdMZy7xbLEcenrNOcR/naNhw9yHqD3SbB9OJEIMsNWZBIKM8yxhryuxwvLIDATwmAuB2GZh4Sw==
Received: from GV2PR04MB11740.eurprd04.prod.outlook.com
 (2603:10a6:150:2cd::13) by PAXPR04MB8670.eurprd04.prod.outlook.com
 (2603:10a6:102:21d::15) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9700.24; Mon, 16 Mar
 2026 14:13:28 +0000
Received: from GV2PR04MB11740.eurprd04.prod.outlook.com
 ([fe80::ca5f:7e1c:a67a:a490]) by GV2PR04MB11740.eurprd04.prod.outlook.com
 ([fe80::ca5f:7e1c:a67a:a490%5]) with mapi id 15.20.9700.021; Mon, 16 Mar 2026
 14:13:04 +0000
From: Claudiu Manoil <claudiu.manoil@nxp.com>
To: Wei Fang <wei.fang@nxp.com>, Vladimir Oltean <vladimir.oltean@nxp.com>,
	Clark Wang <xiaoning.wang@nxp.com>, "andrew+netdev@lunn.ch"
	<andrew+netdev@lunn.ch>, "davem@davemloft.net" <davem@davemloft.net>,
	"edumazet@google.com" <edumazet@google.com>, "kuba@kernel.org"
	<kuba@kernel.org>, "pabeni@redhat.com" <pabeni@redhat.com>,
	"linux@armlinux.org.uk" <linux@armlinux.org.uk>, Frank Li <frank.li@nxp.com>,
	"horms@kernel.org" <horms@kernel.org>, "saikrishnag@marvell.com"
	<saikrishnag@marvell.com>
CC: "netdev@vger.kernel.org" <netdev@vger.kernel.org>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
	"imx@lists.linux.dev" <imx@lists.linux.dev>
Subject: RE: [PATCH v5 net 3/3] net: enetc: do not access non-existent
 registers on pseudo MAC
Thread-Topic: [PATCH v5 net 3/3] net: enetc: do not access non-existent
 registers on pseudo MAC
Thread-Index: AQHcss4OdjkBizJEX0ia8TBogJfoTLWxNqYw
Date: Mon, 16 Mar 2026 14:13:04 +0000
Message-ID:
 <GV2PR04MB11740DD2AEB7641D7617E452F9640A@GV2PR04MB11740.eurprd04.prod.outlook.com>
References: <20260313094644.1132411-1-wei.fang@nxp.com>
 <20260313094644.1132411-4-wei.fang@nxp.com>
In-Reply-To: <20260313094644.1132411-4-wei.fang@nxp.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: GV2PR04MB11740:EE_|PAXPR04MB8670:EE_
x-ms-office365-filtering-correlation-id: a2227e45-fb03-4cf0-8e73-08de836623df
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam:
 BCL:0;ARA:13230040|1800799024|366016|376014|7416014|19092799006|921020|18002099003|56012099003|22082099003|38070700021;
x-microsoft-antispam-message-info:
 sfQiX5iBg9yoRY78D3NkNxlMfeQ5tO5PTGlVRcy5wHCA9ylka77WknBimepgWjJQmqya4FwW9NmD2LikSw/nOfdRBWXhcwDx61YZVdRfHLeoCq56KdX6eVd9AoQ81mvkCtl35wfa91gQ3sjfwGgO8s3iUiS9JkM6FjxMVspISvO6wq/QykbyLN41OwMTuQQQPkn0nVRx5W0b70gtSO7rM7dUcJOFdY8XSZvTfFSJBC2KnAQ4T8+ubTwjekY9lLMwfLSwnHJuDDL+WBlwvNIXmgZjJkC2TDiFeg/QP6XWSZQUHnpnPpQ4a/r8GTxCU+sbKJPOZRIuOZ5lKHHGngbhohjs4BZzcmyRfNWNk9zjEgkKZXp1JeytHhQBhPnUc0Yz7TimHs6407ay4DcuCDERZplEceDnga/upv48lpigziQB9UuAjmSdZVtLT7hNJuSOusCzwZjDWfecbDGBIsAymMZva5WyCQ39JfkL6+qF4P+VqsBaAagigRW9zDMqrJ62YozHkCWh9+ll6HVbWBmJXe/eSunrZW7+w+GtKkH0wRBfd2g34hqkcBwVjIuQ9Xc8NcYhy7CbwPAomYPxgUf9C9+rllO0OVw7EMW2L8b3C4Q3TJt88mtNJHY2b3mhSEOxyJhZKQdqXoxplGwb0ubEwWxEX9cu5g53di4RGmP82R5v4sRRAN/7lHXoFXVPjzfdjFM9mdCionaaFIXuXpXMVfHvDsWS+Y/uxy319tSAR6FrQNTWqPdQ7KruRv4+JKdZURS8frPlhzP1ZENnep1AN9XrvGblZ5+rzJ8gGM2tdbpnpKoJLjGQOWP/Ldn3RCRM
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:GV2PR04MB11740.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(376014)(7416014)(19092799006)(921020)(18002099003)(56012099003)(22082099003)(38070700021);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?us-ascii?Q?ODCsPC8ecp053NTVp9GXmT/21jFaYj3xxowK02ujx8Gh0JtSGs2Gb88O8Yn9?=
 =?us-ascii?Q?mvsZrSDbdDbCxC6bmiHgBzvPP2OKg8vEYFvgnAlUv3QH4AmRJpcvEAD5ljsa?=
 =?us-ascii?Q?TmyDieTT3+U+p5jPvyuuSh/xawXqwyUTPxK0UQ5CfS8CzTFYUqSVdlZeZRDv?=
 =?us-ascii?Q?D37+VRTkMVHP0dz7RwbTK50Pm7JfEDnBanNVEeI/9Gb+PVeltsqMYVIXH6nm?=
 =?us-ascii?Q?j750k7Wn+peRAFQUeTKpGk1zoNygLAUxSpgfgJb/Jw5TW7g9BsEAPNw40CCH?=
 =?us-ascii?Q?jd5VQXnEieWyyZrOJJPDIeHbxFmO2L6rudYEi4ho3jsHgWbQm9G4JJSijGgV?=
 =?us-ascii?Q?1T//zOj5b2hAUI6NC2Vezw4RHl2WieSChZRzUpN285ewUlUg0ovjxuVxSUeG?=
 =?us-ascii?Q?WdmslZ+kcrmoD0SGzRuQlM/1RuW+hja0l6RpM2C+L14VbVk0c7is3irmE1vd?=
 =?us-ascii?Q?qvVAo6XZ44ZBUT9HUD4iLu3FBcy5zpMBBczZcapuyarAlZB9JXwF9yiOYQLi?=
 =?us-ascii?Q?A4Hw772tfP1oPP+E0yefmNQgt+9+DTTi8vDwR5FqyricGhGWgHG+6FBPbOXz?=
 =?us-ascii?Q?MogRT+o7Li64lD5MEWzCkU8dlASAcSZ9drDTUMeBzqOd5ctcyvAiXW/J+evX?=
 =?us-ascii?Q?mJddMts0hjx+6Z5AMUVeTlYBpKJlUfTEeVds+jzi6UmJvSsn0UUBHEqAkOTj?=
 =?us-ascii?Q?A82LHOSHB4n1b+otNAITjqWA7Sb1g8yfkDSMLxmP/0ozuiKXD5yw9DXcELw8?=
 =?us-ascii?Q?OFOHl8QEzLNtGwvWQO3Hrg+CfQyVj+4669MTYrinjofzRO/1XLpSvCoaem02?=
 =?us-ascii?Q?CnylpNUD/EjlzwNZlkF5W5JUuTdhxGix/0mollENft9xDhBozYVqCWYnRo59?=
 =?us-ascii?Q?mL5G64A4knJHSmq89njLkIG8OE+VKuf/0IGDCiwhNyOQnSkWQcuK99bSf20B?=
 =?us-ascii?Q?l208NMNLJn3xL6nWD9f6gga7ZzBIuCBLAs7EugjWVj4r0BHz2KB93MjSQExo?=
 =?us-ascii?Q?zPKZUyfnDUJmhKErfehpyQb9JitsulxAAp2H7sI/3oMAfCMV/81MTOJn3onL?=
 =?us-ascii?Q?7fU/4vwHuHF7gwA60gmHOvLBDM+q94GgRgNFPIyhRLcNbkquHzzrpBS2tAkD?=
 =?us-ascii?Q?PSfeyUp/fy13Ubi021wXEhKhvXlZRxvFKLZ1jMbLeLxHg+Oy3HegQX5Kc14i?=
 =?us-ascii?Q?830txkxOsvwXAv/WXzUudHhDea5GHHmgh9xhv01Wv4WYHmbQeANOt4mQcU7y?=
 =?us-ascii?Q?9RGcoN1/Tb2DRXZj7YflXcxu4kzppnCAzTBIPLyuKLvIU+GWK9fCzC6EFUbm?=
 =?us-ascii?Q?DiUvygErjbZeuvODCY4xy7F04TflTVSPFPw1YpSQRSFLCgJ8aBoUKiKlXQyd?=
 =?us-ascii?Q?EZqiDauXu8mdAUyjUCuH9SMM4sc5XP3AK03QtW3YHGgKMvXh+E2VhVS2owxL?=
 =?us-ascii?Q?J7Kd0O0d0ZAEAmeeDnaSUz+/ZuxzEBTnXJhCpJB0sfF86d3PHFMPLh9D/ycZ?=
 =?us-ascii?Q?1mrrkLheS6pgsz30gF/iOe7NngYJ6dD9naaSK7rhRIHmq5xifOJphIXD9g4l?=
 =?us-ascii?Q?lhwd7KeFB18AjNTpJE4y4ZHSW1dTNTMHfWUU4uYGFBRNFvqUgcwcxl3gywy2?=
 =?us-ascii?Q?Iwc3JfAA0E6u4pk10v/cx3KLe0NByfx0hdNzjmNOy+kW1aWf1W4u2+r8AH2+?=
 =?us-ascii?Q?O9sXQW28tw9ThMcAD3gxtfzNUL3ugd9U6zWB5s+vGzPD4O6bec2JiCP18/gb?=
 =?us-ascii?Q?6Z9gkhNdQQ=3D=3D?=
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
X-MS-Exchange-CrossTenant-Network-Message-Id: a2227e45-fb03-4cf0-8e73-08de836623df
X-MS-Exchange-CrossTenant-originalarrivaltime: 16 Mar 2026 14:13:04.4332
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: tOZSmloHD6KJFaf+VG1HK/bBF2w6h+TuUYZVIl7hh34sw+AXdrZ3eH6cvrdLFNdrDfIS5fVc/wvsCUwq3pOTnw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PAXPR04MB8670
X-Spamd-Result: default: False [1.34 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_REJECT(1.00)[cv is fail on i=2];
	DMARC_POLICY_ALLOW(-0.50)[nxp.com,none];
	R_SPF_ALLOW(-0.20)[+ip4:104.64.211.4:c];
	R_DKIM_ALLOW(-0.20)[nxp.com:s=selector1];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-268175-lists,netdev=lfdr.de];
	FORGED_SENDER_MAILLIST(0.00)[];
	TO_DN_EQ_ADDR_SOME(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[15];
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
	ASN(0.00)[asn:63949, ipnet:104.64.192.0/19, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sin.lore.kernel.org:helo,sin.lore.kernel.org:rdns,nxp.com:dkim,nxp.com:email,GV2PR04MB11740.eurprd04.prod.outlook.com:mid]
X-Rspamd-Queue-Id: A686429B33F
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr



> -----Original Message-----
> From: Wei Fang <wei.fang@nxp.com>
> Sent: Friday, March 13, 2026 11:47 AM
[...]
> Subject: [PATCH v5 net 3/3] net: enetc: do not access non-existent regist=
ers on
> pseudo MAC
>=20
> The ENETC4_PM_IEVENT and ENETC4_PM_CMD_CFG registers do not exist on
> the
> ENETC pseudo MAC, so the driver should prevent from accessing them.
>=20
> Fixes: 5175c1e4adca ("net: enetc: add basic support for the ENETC with ps=
eudo
> MAC for i.MX94")
> Signed-off-by: Wei Fang <wei.fang@nxp.com>
> ---
> Note that the commit 5175c1e4adca ("net: enetc: add basic support for
> the ENETC with pseudo MAC for i.MX94") does not have such issue, this
> patch depends on the patch 2 in this patch set.
> ---
>  drivers/net/ethernet/freescale/enetc/enetc4_pf.c | 7 +++++++
>  1 file changed, 7 insertions(+)
>=20
> diff --git a/drivers/net/ethernet/freescale/enetc/enetc4_pf.c
> b/drivers/net/ethernet/freescale/enetc/enetc4_pf.c
> index 53cecbb23a97..56899f2254aa 100644
> --- a/drivers/net/ethernet/freescale/enetc/enetc4_pf.c
> +++ b/drivers/net/ethernet/freescale/enetc/enetc4_pf.c
> @@ -814,6 +814,9 @@ static void enetc4_mac_tx_graceful_stop(struct enetc_=
pf
> *pf)
>  	val |=3D POR_TXDIS;
>  	enetc_port_wr(hw, ENETC4_POR, val);
>=20
> +	if (enetc_is_pseudo_mac(si))
> +		return;
> +

Shouldn't the ~PM_CMD_CFG_TX_EN step apply to pseudo-MACs too?

>  	enetc4_mac_wait_tx_empty(si, 0);
>  	if (si->hw_features & ENETC_SI_F_QBU)
>  		enetc4_mac_wait_tx_empty(si, 1);
> @@ -856,6 +859,9 @@ static void enetc4_mac_rx_graceful_stop(struct enetc_=
pf
> *pf)
>  	struct enetc_si *si =3D pf->si;
>  	u32 val;
>=20
> +	if (enetc_is_pseudo_mac(si))
> +		goto check_rx_busy;
> +

Shouldn't the ~PM_CMD_CFG_RX_EN step apply to pseudo-MACs too?

>  	if (si->hw_features & ENETC_SI_F_QBU) {
>  		val =3D enetc_port_rd(hw, ENETC4_PM_CMD_CFG(1));
>  		val &=3D ~PM_CMD_CFG_RX_EN;
> @@ -868,6 +874,7 @@ static void enetc4_mac_rx_graceful_stop(struct enetc_=
pf
> *pf)
>  	enetc_port_wr(hw, ENETC4_PM_CMD_CFG(0), val);
>  	enetc4_mac_wait_rx_empty(si, 0);
>=20
> +check_rx_busy:
>  	if (read_poll_timeout(enetc_port_rd, val,
>  			      !(val & PSR_RX_BUSY),
>  			      100, 10000, false, hw,
> --
> 2.34.1


