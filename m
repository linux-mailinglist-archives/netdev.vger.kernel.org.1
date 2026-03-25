Return-Path: <netdev+bounces-271423-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id eAV0JwGNw2nJrQQAu9opvQ
	(envelope-from <netdev+bounces-271423-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Wed, 25 Mar 2026 08:21:37 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id F16BE3209A9
	for <lists+netdev@lfdr.de>; Wed, 25 Mar 2026 08:21:36 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 1E82A300E271
	for <lists+netdev@lfdr.de>; Wed, 25 Mar 2026 07:17:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0CF942F691F;
	Wed, 25 Mar 2026 07:17:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b="m8q+KYo+"
X-Original-To: netdev@vger.kernel.org
Received: from GVXPR05CU001.outbound.protection.outlook.com (mail-swedencentralazon11013030.outbound.protection.outlook.com [52.101.83.30])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B2239285068;
	Wed, 25 Mar 2026 07:17:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.83.30
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774423072; cv=fail; b=Rq6QGwWpbN86LDbzr4gSx8yGGcDP4HrY6l83lSeBhO8JFjylBfa5N6LUmhcLaXnoq/BeSrs/a8/v9X0fBZengH9FpZ1yK6AdT/wjMRWExmXd9Wtx+st/ReqqSibnnyd3LyPOS2c7gBXAGd0E7snGlzwL0m31jHfurJzNd1OFZ7E=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774423072; c=relaxed/simple;
	bh=XYW4Nmro2/eYl1ceCX6OE4EMyRzm7ZxQrjJr3J1y6b4=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=sqf7bPO6DRYveZnkNgGj7LyaWAS63lZbm7kmaG3IEZevlNgGl/Jqp07SMZ083iMH08fJz11X/Jf0Xfzp9OW2SD38yrFfQ1hLBlChxRfgqxAACt+becl9to0BZYnqkjxQnthP+ci25dxal42M4wE3bKCjscBGRX9nPYBl8OXFChA=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b=m8q+KYo+; arc=fail smtp.client-ip=52.101.83.30
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=C1sRw/oC4/GBocMGIcrK45vW6Mf4yP2bKQmsRpUrzsxoK37TKe6Fxgd1UoSxah7YoIj0zHrz5N+9SYdj4JGdelf4vPkYY+UHuxGnlArchGv23NT8IOnXHhuBl3NeXm39A1wZBC1yw9cYzNgqkAYJ1KNb4lrahm0+9fIojIc6v0B9UADy18mejRC8fmL3NnUJ3/mHENSX0LFUVADyf3lOnux7ZxvihwbCVbxfVFc1aNwB/D4lEt1Sp0sGJKYexXjWIE81QFixHoZvNeel3lGx3cwyKUJn2rf7nbWH6gAvHn4IFkNBSIdCr55PEzrQuRgtlMmnz7XEyqaxjoZZxKZAKw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=XYW4Nmro2/eYl1ceCX6OE4EMyRzm7ZxQrjJr3J1y6b4=;
 b=JZMAlhNfu8ECSUi/CNIFKUsYKAcco/f6ssCVqymoav4mwmSI0uhCZof3YIzMbpN2odmrMI/J0WNuy7etH1yLaiKGs+uDOzdLlUxq+asvZM/EVMVGFCEJxK/R33f/NQFuhTSVREJR6cCTxr3VSHkrD+JDvYQOuDeT/zIw5H/t0vVD8++9WJN/KvSqotQAff+dz042fQpAoPPpnw2oP8pH1GspDdViz9+RslRql/3HSvAdvynE7ObBu9HELjMT9QVZJLZvwuFlEnBcfDnZ9UBcQxlsL1mbvqs08mzLittCF9y1ygfW3w4/kSNGbAmIq+7jthQk9qRUrRLvIY9Z3Nsiqg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=XYW4Nmro2/eYl1ceCX6OE4EMyRzm7ZxQrjJr3J1y6b4=;
 b=m8q+KYo+86NAq1H9fMlVnW3gVNMN0plxHIBea9skoaJ1pSjG+DoJOuR07gr15mGJo8ke+bIcOORbIXcWxGB8IvNpkp7YolSRpM3qiHw2OWZsAEEExnjiLhZPm/KMOCBAGlpC0nxCCdPuvze7uS5gOyf9DIhcoTVpTiFk+FTwyy83acF3UCA0uQDMtVnY9yUnx/RdUsZwCch13qnRAGcjUZZX5iiHqPqFjG9ZuHsJVajcBM/Dq1h9hzlvhE2xJBCepER7UWw/M+gt0tP9rmbfgYCG0N4VcmnILilZ3vdiKgYrAYu2vO6jeQUS6RLE9ZKoBGNEl4zZSR1tyzYXalUIWA==
Received: from AM9PR04MB8382.eurprd04.prod.outlook.com (2603:10a6:20b:3ea::11)
 by VI1PR04MB7040.eurprd04.prod.outlook.com (2603:10a6:800:121::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9745.20; Wed, 25 Mar
 2026 07:17:47 +0000
Received: from AM9PR04MB8382.eurprd04.prod.outlook.com
 ([fe80::f02b:c2a0:7fd:6d63]) by AM9PR04MB8382.eurprd04.prod.outlook.com
 ([fe80::f02b:c2a0:7fd:6d63%3]) with mapi id 15.20.9745.019; Wed, 25 Mar 2026
 07:17:47 +0000
From: Clark Wang <xiaoning.wang@nxp.com>
To: Wei Fang <wei.fang@nxp.com>, Claudiu Manoil <claudiu.manoil@nxp.com>,
	Vladimir Oltean <vladimir.oltean@nxp.com>, "andrew+netdev@lunn.ch"
	<andrew+netdev@lunn.ch>, "davem@davemloft.net" <davem@davemloft.net>,
	"edumazet@google.com" <edumazet@google.com>, "kuba@kernel.org"
	<kuba@kernel.org>, "pabeni@redhat.com" <pabeni@redhat.com>, Alexandru
 Marginean <alexandru.marginean@nxp.com>
CC: "netdev@vger.kernel.org" <netdev@vger.kernel.org>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
	"imx@lists.linux.dev" <imx@lists.linux.dev>
Subject: RE: [PATCH net 2/2] net: enetc: do not allow VF to configure the RSS
 key
Thread-Topic: [PATCH net 2/2] net: enetc: do not allow VF to configure the RSS
 key
Thread-Index: AQHcvCRQVx2UZfYHtkqRsqFhCqvEr7W+1PfA
Date: Wed, 25 Mar 2026 07:17:46 +0000
Message-ID:
 <AM9PR04MB8382771E1FF250E566382691F349A@AM9PR04MB8382.eurprd04.prod.outlook.com>
References: <20260325065647.2882997-1-wei.fang@nxp.com>
 <20260325065647.2882997-3-wei.fang@nxp.com>
In-Reply-To: <20260325065647.2882997-3-wei.fang@nxp.com>
Accept-Language: en-US, zh-CN
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: AM9PR04MB8382:EE_|VI1PR04MB7040:EE_
x-ms-office365-filtering-correlation-id: a533a711-4d65-409d-9ea6-08de8a3e9dc7
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam:
 BCL:0;ARA:13230040|376014|1800799024|366016|19092799006|38070700021|18002099003|22082099003|56012099003;
x-microsoft-antispam-message-info:
 o1VGZlhFzOutWK3w3ne+HhlkRJj8qm9GxNBjmQG27rM5IF+dfz9/XcJqWnv1OQK5NSvZ1OOngUVcC77vnv93dvxVKSKZxVTGJ3DFeQ7kRGp7jCajVI9k4qIx008O72nncsv3PzZ0ldTwmJ6Os2D/dCJppScItkw5f4/vNHsQw+5EshLNfATg3IlJ1hTL7ThzQ1u2vpt5asz7EqiBPa6Kdvo2SWs/w0rjBSxhW11Lg7w6u44wEBBrWNajx6e9chG6GX4FvHyHkKRufHhHrLhpX95QNNwqGTHb5pdAtt8tKndiYkxY5MQs+Xp6A3dTdefp7CJuGvmIzUSAUSIonxT5oD19NtUBvAsqUL/B5UnZ3QvACmSQgYzWmP2750dgeEppL+ZBTiuhKgCp7HYNZJOvfbD6FJlyChsydHum6JV2kwGrpCiWluoWpI3Gy04KY8mR3BCog/xxVfc6jFybRAAxwGpDTzKqFk/+CiJyC4Mt5tYLvLljTfkKb7cOp8wW8PmUMJNpf+uLI+uTblj+9ELR7NPdd2SZT0hlGov0eN2jap+pAJa7enlgs8ArX3blXera79mTbMCr7HLezJ41on7KmUk7AvKJOA2XGz6Sv3eOvUMf+AEcvcPeS5n8cwtAcyBxmdmTiI4/6DxV75pDY9IoBjARyObd0jNJWaZWFhuCs7jeHEQ+T32NCFtZXorYiu8PKyLuAlNfmT8eX5MAKrFDkc3zLVok+C+a2jtefbhiqTkuNcla5HVmBufDrKUjrqDCU+Zpciw9UYFQgq2Yi4MBCR6xBHkXSZeLizmOpLYGlLY=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AM9PR04MB8382.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(1800799024)(366016)(19092799006)(38070700021)(18002099003)(22082099003)(56012099003);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?us-ascii?Q?JTXYIaK6zqPB25N7LX8V0RD+8P0uK1uD9RQRWKUWjc3gukF2E5h4OBqU4r6o?=
 =?us-ascii?Q?NEuig79hT47yiojp4CzrzwyL+0SCY7cv6oCtBXYEFCjeJcglG6YajXJWmCNc?=
 =?us-ascii?Q?jh15Mu+W1ftd/Mpxg+LsSBPGorQrT2f0ZOHHw4XhsVy/82iBqxm+1vV+piUo?=
 =?us-ascii?Q?RTYgJwGejZ7hGwc1l9FfmIwtZkXtihN/X64LarvheIHlKl2KiKgv3H8WygFe?=
 =?us-ascii?Q?5YNwevrZYpZ0P3L5m1LUzOdZ++Tf7Q2EhFHfmpRbWEij+j4T11hSijD+j9r3?=
 =?us-ascii?Q?ch7bZRwrQt8yhDlMKaipOLoA4a9pyI5FC79u0cyKeYm0yMuJSIszwdLOD7/Y?=
 =?us-ascii?Q?QV+XznSOFlIZf5LU45Z9Zn39w+KYVxJ3FN6c8oTJeMPcny66gz5R9Nu6lOaL?=
 =?us-ascii?Q?nJIP56muqRr9yqmYKnvLmKsowmXvUzm8USqxgR1x0RY1GT/8Vq/DmaM4gRyQ?=
 =?us-ascii?Q?lUZaVTDBTxKU8AWthVbQBkNE5+d3Ru5HbZ/Ss6IfHvbsAvOd8Nufklh6MhxQ?=
 =?us-ascii?Q?+JYA1xbhSrH6byMAsZ7fn5ugay65ZEt2FgsjmnMUKVyoYz0b+o8e0kLpUok5?=
 =?us-ascii?Q?yPzVBJsz8nQ5O5YZSvOaJiuwMHxHnjkBgYyJacDBXHuRWtrJvFYVjHiWaO3H?=
 =?us-ascii?Q?/dbrIrdKOsIH78hBmbfAriylhRopMn6MQKGqEoNBFFi6deJE7Jj/frmZpEB8?=
 =?us-ascii?Q?CiWrSEHb3gzmXxgrZwI8RTp5j7+T43dfaLAHQNsnFWdr6g/j/ML7YAq28/vn?=
 =?us-ascii?Q?hUdDisBess/1n+k628e1KqLrBApXi8eq16YMqUkDWjxFErd9Vokvjd7LFvLp?=
 =?us-ascii?Q?l3xjnIh+6OCk8Ydh19UVNhDa7rG3fPKl87sUoVn7AQS0BRXvmYO5gRVe0kLx?=
 =?us-ascii?Q?8ZIVsM5ac9eRn5T0zH1oXYjrFQ5mBe0FnnwwC/egnr2LOpWW/EcRjqT6EyAJ?=
 =?us-ascii?Q?n3/sop4JeauQEx8CZb3UuqKK5Fx07mfcnMzhpR3LsIFsZhyfYa2aIXYcDnGB?=
 =?us-ascii?Q?9zu+j5m+kDydvRxCheaV5XMSFAjVN8ooGddXN7sjJEzz/yWMfoDydSf6JZVL?=
 =?us-ascii?Q?mkN3wocR8+HG4fGDtcGSp664zrp9TBZlc/ZPn0q9OnS0a3aCPap+/5qwGqVd?=
 =?us-ascii?Q?df2Eg2ULDjfaZt0P+ppJZsBHfaiydkTQNY0gF2EHpZGjpx48fZqlTY3oemw+?=
 =?us-ascii?Q?2uVjfASV2I9MuGwn+3c9a6/qTAowlNMsDiE2WnGTLppJiSANeZlDi1B6gxAi?=
 =?us-ascii?Q?09a+XVj/vZAjmnYH7VcvhrmYcwIr7iEfcHPTBRwS4NGAW/AN2ck1feTSVY0H?=
 =?us-ascii?Q?pGlz8kOSlEFx+i9mC2HjGalASQYEtY2cL2j5GW/UJQRgJkngKTj3mCWRt05b?=
 =?us-ascii?Q?RsxFNLuukfTOIlPqy3HhFI94Ra0zuTjpRNmEtUxOwKqX5VKYMlbgQQaqlZKF?=
 =?us-ascii?Q?Tnvlsbks1nFSKU6osiEa3sD6cZEG8N/B/8T5MgbtOR0rfKL8AWB9E0+km+lG?=
 =?us-ascii?Q?wjgT6xOGIh/jIjrthlLLXxb82Ivyh46SixT3kZbxRgk2g3/f9O/DAjVHfYsE?=
 =?us-ascii?Q?kZ2VGX8rkb9pi6nCgh4tWJDF9ROq/Z0BIfPyPoVvnv/o8OSLlzQyHrX99dNK?=
 =?us-ascii?Q?5FW2NfFIAoowMSZBaxcR8zam1GiLGz166w+t9TXgwErL/s7CIp5CwxqEUV9Q?=
 =?us-ascii?Q?gCuakFy3ufko6o9BLieTGUlxJb5NMiDOmF7dYyqRak4FgNYK?=
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
X-MS-Exchange-CrossTenant-AuthSource: AM9PR04MB8382.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: a533a711-4d65-409d-9ea6-08de8a3e9dc7
X-MS-Exchange-CrossTenant-originalarrivaltime: 25 Mar 2026 07:17:47.2586
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: GjM2WjoS0d194cZn8S3Gax5u0+8lbaAzDqfHqLBMZiKrNJSC0AfohJ2f06DvOC21kdaPVSzkQrBwQHprW3SR4g==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VI1PR04MB7040
X-Spamd-Result: default: False [1.34 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_REJECT(1.00)[cv is fail on i=2];
	DMARC_POLICY_ALLOW(-0.50)[nxp.com,none];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	R_DKIM_ALLOW(-0.20)[nxp.com:s=selector1];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-271423-lists,netdev=lfdr.de];
	FORGED_SENDER_MAILLIST(0.00)[];
	TO_DN_EQ_ADDR_SOME(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[12];
	MIME_TRACE(0.00)[0:+];
	DKIM_TRACE(0.00)[nxp.com:+];
	MISSING_XM_UA(0.00)[];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[xiaoning.wang@nxp.com,netdev@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	TAGGED_RCPT(0.00)[netdev];
	NEURAL_HAM(-0.00)[-1.000];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[nxp.com:dkim,nxp.com:email,sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: F16BE3209A9
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

>=20
> VFs do not have privilege to configure the RSS key because the registers
> are owned by the PF. Currently, if a VF attempts to onfigure the RSS key,
Typo here: onfigure -> configure

> enetc_set_rxfh() simply skips the configuration and does not generate a
> warning, which may mislead users into thinking the feature is supported.
> To improve this situation, add a check to reject RSS key configuration
> on VFs.
>=20
> Fixes: d382563f541b ("enetc: Add RFS and RSS support")
> Signed-off-by: Wei Fang <wei.fang@nxp.com>

With the typo fixed, Reviewed-by: Clark Wang <xiaoning.wang@nxp.com>

