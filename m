Return-Path: <netdev+bounces-237105-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id B59CEC45213
	for <lists+netdev@lfdr.de>; Mon, 10 Nov 2025 07:51:22 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 5F34C18832BF
	for <lists+netdev@lfdr.de>; Mon, 10 Nov 2025 06:51:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BDC602E888A;
	Mon, 10 Nov 2025 06:51:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b="gicdIwcy"
X-Original-To: netdev@vger.kernel.org
Received: from DUZPR83CU001.outbound.protection.outlook.com (mail-northeuropeazon11012033.outbound.protection.outlook.com [52.101.66.33])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 94CB72E8B8B;
	Mon, 10 Nov 2025 06:51:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.66.33
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762757477; cv=fail; b=BqYkwVmGz0FqDtptCmW3vBaqfgbCRjRdBJDC3nsQm+S/s96xN4PKYyIoO19REMRDG8YXf7oM5rR91LM02jTU+ae0jgm8CDkA18Gq6byoOM00bin1ArJQQH3Zt5eyja7qUqFgE9kdHB4umWGzGJMzTTDhWrckQkkHa9FbDDkiBpw=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762757477; c=relaxed/simple;
	bh=3VMyy2YADpcoPstDtHBFNLQOD2m7DwW0kwn2J4Ed+lU=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=XNPgZKUJG+mN/mlx5GA/Lwd2KNVMYQ2NdEEoTRRZtJT3+Ew93+zruzFfOgVf0vI9LkWE8oMJeqT+t3kDSKMaJwCJFZlsicBH+r9QB+gGBNFLunDg15ntU/rNNq4JEkfnEWcudiZAeAjUYqDhdZTYXc3Y9IrC0wQWItZREWLEoCs=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b=gicdIwcy; arc=fail smtp.client-ip=52.101.66.33
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=jbDnOn4DGIocvL57Gz4Id03N7m27Ky5gGIFNedfkiQw4038bbzr6rtvbTNeeEG7Ol5D3DYU/BFw8ghrs1QxgT0a/JfYlH1rAYiNhA7v+vrUA+lW5ob9IM4gnyS27J3Cscr4BKQM6KlmpU9nS/5N2a/F94DdXU9eEq/LgBARvwJBdyrjP91bhrwOojNCjffKBRBqjlDlHOtt3QM/fN6+14Iopr6YMifQ1hKCpLlPwdh2A4O6dX84Flod0DUyZekM2EZnxp4cumfNZ6zm0GmaScBGRXxTffPWI2nkdzgpVLJ3rKPulCyJ3D0/p7p0z2Xs1LPL84vE7BSUoIPOvoUB/VA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=mNLT0CC0xdDM2kW5gcW7ilk7EoNTJO1hCsZXHiHkWMA=;
 b=LS047vbfhc9jPZCE8d2LL26B9G+dyVjftzI8M9eS5QUH5DfrGzULnasabstEYPTdSu2UuMA9ECgCTmg2iwxuPt6eXzucztLUTce5U+3EcduQJbLanKBdEC18MJ97RbX7lFsbuw4cwHp4+TCqtGsZ2vmiRi/UZ2/SmWauMNWskJXs61gkFdOW2r4W+pexG0RS9wIkd6d9xMmAwbvseBwBN+9AGiXFg8QhsIhj2LcezTPM6MSnlgZhwVrFPcY6MsXHBex5VgGkZj7Rut5VPFUhWhxm/Enq6BXMzCE30wl/i89XLyzhnTn5UpxP5a4lqN1hQhM1nElYi1BZMPHKca2vGQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=mNLT0CC0xdDM2kW5gcW7ilk7EoNTJO1hCsZXHiHkWMA=;
 b=gicdIwcyyHItDTJNBDtmqtgyGC8K4Kalz2SMGvn+HetY/Uce6+Qau+zg3o1SNdx5jo0zWaLWrfG0QW+NG73/0vYtILFglxmvEM0ZvY4GyNyONsxggHN+/XSVDrSa3jBkOnKhofoMGEQMG1QeYaVeHCIEuncxTF6LBxlyB6X0x9UDKkcwn7ZaN8hiiyC0gT+LVET7Emz41025YXNY50/ul8SOGE8BRnGvTqJXOcAmI+SELmVIg9N5zqHyAi3vs47mXSlUQ69m4r/0XnocaDT6V6JfblPeN+0Z0lvHvOS3JU2Z5PeFXkFh3cCSDUTpYTz0PnzXM1qZAUhovWa1LRfVVQ==
Received: from PAXPR04MB8510.eurprd04.prod.outlook.com (2603:10a6:102:211::7)
 by AM8PR04MB7857.eurprd04.prod.outlook.com (2603:10a6:20b:24e::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9298.16; Mon, 10 Nov
 2025 06:51:12 +0000
Received: from PAXPR04MB8510.eurprd04.prod.outlook.com
 ([fe80::a7c2:e2fa:8e04:40db]) by PAXPR04MB8510.eurprd04.prod.outlook.com
 ([fe80::a7c2:e2fa:8e04:40db%4]) with mapi id 15.20.9298.015; Mon, 10 Nov 2025
 06:51:11 +0000
From: Wei Fang <wei.fang@nxp.com>
To: Jakub Kicinski <kuba@kernel.org>
CC: Shenwei Wang <shenwei.wang@nxp.com>, Clark Wang <xiaoning.wang@nxp.com>,
	"andrew+netdev@lunn.ch" <andrew+netdev@lunn.ch>, "davem@davemloft.net"
	<davem@davemloft.net>, "edumazet@google.com" <edumazet@google.com>,
	"pabeni@redhat.com" <pabeni@redhat.com>, "eric@nelint.com" <eric@nelint.com>,
	"imx@lists.linux.dev" <imx@lists.linux.dev>, "netdev@vger.kernel.org"
	<netdev@vger.kernel.org>, "linux-kernel@vger.kernel.org"
	<linux-kernel@vger.kernel.org>
Subject: RE: [PATCH net] net: fec: correct rx_bytes statistic for the case
 SHIFT16 is set
Thread-Topic: [PATCH net] net: fec: correct rx_bytes statistic for the case
 SHIFT16 is set
Thread-Index: AQHcTsL86P+56d7xokqiU0/1pmVGN7ToGemAgANk2nA=
Date: Mon, 10 Nov 2025 06:51:11 +0000
Message-ID:
 <PAXPR04MB85107EBD34691508E453F3E188CEA@PAXPR04MB8510.eurprd04.prod.outlook.com>
References: <20251106021421.2096585-1-wei.fang@nxp.com>
 <20251107185937.0cbaf200@kernel.org>
In-Reply-To: <20251107185937.0cbaf200@kernel.org>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: PAXPR04MB8510:EE_|AM8PR04MB7857:EE_
x-ms-office365-filtering-correlation-id: 349c679a-9a20-4e65-0300-08de20258908
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam:
 BCL:0;ARA:13230040|376014|366016|1800799024|19092799006|38070700021;
x-microsoft-antispam-message-info:
 =?us-ascii?Q?eXzWHVmeBGKahloZaxffjkNlEEo5l3XXdCaXknPxCkmlII+QYhjdLTJiVFiX?=
 =?us-ascii?Q?cWr+aujCo66/vVNukM0NiR2Iysqj18je8sSzpsra6OdAsyt3bw4s2reuh1Zr?=
 =?us-ascii?Q?KDn7AEyr64GLRq03cmfeubrN+mrc5cfYJNQQTDkOQMyybwTlLz512N0H/oSu?=
 =?us-ascii?Q?XTCPtu5YnKjSuMqeX2Iu5+pjCDOLOZ+86FGW7cHUKYFjpLGXXCIkn2hA9RKi?=
 =?us-ascii?Q?d3cre4t/Ih6P6WMsa2dGYvzSNS+PDkU7PGpCZ1iVY789WUOdBtQQRhrsBKgV?=
 =?us-ascii?Q?ggRFwglOQQUWYVWiUePNTbZOgcgzVVz17QbYpoH7pCC4LafKcJp8YpcE7LWI?=
 =?us-ascii?Q?ezV8FWOUlizA4xRDYR5Lyxr/zIksH3lhN3v9rnVKaBO50jCpiOI3KFPGuG0g?=
 =?us-ascii?Q?gt0pA9Jk9zQe8JZO9lbF0iMQp8wWRKRUlFjk/iuPc6Z0ZcAY0BJOtWoFvjzi?=
 =?us-ascii?Q?ha8zoOqOerbzV4fR/UXbyjexOYEmm/WO+HGPorMdENs8JJXLgTTACQ/s/bF7?=
 =?us-ascii?Q?qPOdVo54ZFCDJqjogYhjBcKgrJ9LmUlFpmVgYLdxAzknU73p5S9ckNnMXAmB?=
 =?us-ascii?Q?Io5HznupOXboWDmIlvmFmOtOG3hMveBHJT3uM5y7kKr80zGD6JrKjFx+oYCF?=
 =?us-ascii?Q?/gO7snSNQdM8CjLLHOHIc70Mi+m7B4CP8IPatdp9ZXuUhJR1mMlqRN2/4pVx?=
 =?us-ascii?Q?UKlR7Jnhxbg1GWGAEEBdgz36E4lNKD+gjynC8zQvD9z+SscJJ/uQ6h+obevY?=
 =?us-ascii?Q?aXIMUFPIcgvKbTiG80b4p+c1JkjKlBsFH+M5O+OIXXvieHqaIOmoJYqZD8Qi?=
 =?us-ascii?Q?O5UqBcxp/Xv7Id/zo+p+CFEwiSQWgaRCt3DdJUuglBGEjNoGMcg86VkBFLhA?=
 =?us-ascii?Q?MjJGZetHmX6P4Mof9pvIUxmbeqQRmrf7oTZIMGgPLygnfXiGzNgaTC+Ox1Ly?=
 =?us-ascii?Q?DuH8KbJPgTz0KsNpGETJzg/LLnIuWp1XOpl/HJTwc/VHMhY5JDsOzcBbE0dr?=
 =?us-ascii?Q?GrVoHOzbMohCwwk15x0rLxVpR3I9G6t1kZoIqXN25gHPs0Q6PW3qyhGkQCOq?=
 =?us-ascii?Q?Jq5Ye6JZ4tp+b1NlnGdPWSf83LbB1/NhO3aZLrwi7OahEFDIG74NF4nxY+QM?=
 =?us-ascii?Q?Dd8kXLMTX8bq7H3LtBVdbf2oy0baUmXBoBrEeo3BFU/wc3H2uXuk3KD8vcaS?=
 =?us-ascii?Q?3rcwxZ70BdEdLuaEubdeIV+e6zGetSi6Xu4PdPoGsRvIL+8LxihFu9+4uX6M?=
 =?us-ascii?Q?0YBuk0truPW8llAi2CxyVTdNWxamuJ+Jaztuj2SKWj6HYRgqrG52X3tHfyac?=
 =?us-ascii?Q?iX4ep20YlD3WKQSWSYssILMmxpITa79UZaZSufAI+Xl00l1dC1fTV/zYXoUd?=
 =?us-ascii?Q?a8QHr7l8h3YrVUMCb5Mt2hChXhXpL+/lySexaNYXoQQ3cZmxK4rC5paGUlc/?=
 =?us-ascii?Q?TlEvWyOZ+/t5LzatpQH4WHs5K0x04GnnaPJ4BA5Pw4DMKNNEirNBjnzJNtkW?=
 =?us-ascii?Q?OqvronTwuRo+/5rF56w0PDuUCZ+BeXypslKs?=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PAXPR04MB8510.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(366016)(1800799024)(19092799006)(38070700021);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?us-ascii?Q?U7QWq1Htwr3vYUIRbpF8g8iXqSk4SHvl45zW8YDlCPzR4t3iMkyx8wporTHZ?=
 =?us-ascii?Q?oLxerwjllrXkX718uPwUNvYIfDm8N2fmIxv6JWLLynY8DmDmtRgfBXIl6jLt?=
 =?us-ascii?Q?E+i8D8SlrDzA0fOxz2nell/C+VXjCgsEb+bIzBybqRKBe9s8kG/XtkPxdula?=
 =?us-ascii?Q?qijexX5TAtXmTrP0j0BugLrLax77v7SnisfF0tUjr5qbYSigdq3rbgmqqfvk?=
 =?us-ascii?Q?s8LxlvVhTQJrfk2kC/j+oJ1VSXRkq8NLd8XCoZ1K3OxHpN9MIyzMZ398izKX?=
 =?us-ascii?Q?Kd6n7xV8lCBW9g85g62xFBieLdbID984WCJrbTl2tcdnCnnyY7e+3mw3aSM4?=
 =?us-ascii?Q?9IvpjhZtoyUiBzky3RQS8Zp2UTjiZpK448CEDCCbe2tnn362dR7Sq0ymT9Ae?=
 =?us-ascii?Q?2X2smopJkqMuq0F7cBHnT2vJY0oxi2Wk6nwSMXU6cXaKU+9Hl4EZLkT/yZ2c?=
 =?us-ascii?Q?AG9LzWmpw/hWZ9ILa0vWBoC5CJ+nw0SVbDVareAZFogeruEuHzr07GZ4WzHP?=
 =?us-ascii?Q?PUjKfVD+AoAGZPpvJVcE7Ux8e83bQ7rZ6dKMrG3Jne/fAfKh8lp8BJ/n/Kpt?=
 =?us-ascii?Q?n8Z4exI3N6sU4FjJdH8Re24SMwSQR+XjHL5K1AKTMwDHtS98DwjMN7i1dJBl?=
 =?us-ascii?Q?zwsrc8EAMYTGjV/JXwAkNAPfTw5k1VI8uAE9imhJCSS7GSj8Lp4c3yv3sU27?=
 =?us-ascii?Q?2PZ9vbzwNx0QOQ5/5bmwvdBw9KvXu1Ku9XMy91u4DOV3luakfyifutiiAJNg?=
 =?us-ascii?Q?Gxs9zLGEHA56WKh19peZum65fqfQ5nUDKjVFyQ5oabe1kMGZmCOQdOhopYFl?=
 =?us-ascii?Q?naP/FUhB4pnRyDGBBqTU1BvKl+84YRm2XLdbRqWoTKki3c48AiLaPGL0I4VF?=
 =?us-ascii?Q?GaKDrp7jbPpd1hsepbkTdkClwiJDJsOXfpsKhVBConQicP6PuZtcUojIcjnj?=
 =?us-ascii?Q?E3kXuxzhDLsLWiZNsSlF/riA6/an3+4E6t1oEu/OO8KZH3+fv5JDqcxFLioZ?=
 =?us-ascii?Q?YvoOvsmp3oDdokirvclklrMLyiGmNVGdhiisVOIMrkeYqAqif9/ZQ2EfQ68d?=
 =?us-ascii?Q?LGZrRkyzjZJtGJUcGk9RkrsYUG025Mw8e3jCo/JTFmobCNKD4n1yxYOqjSLg?=
 =?us-ascii?Q?5Hs5SuE1Hht3vurx44rhsmHSAdDvflbms+/ISWm8BrsSmc0jjdZSherSrqPf?=
 =?us-ascii?Q?PIKiEnOmKegylP9zPwxS6eMGZtEHgoLHe0HvrsZQCtDJ5Ga2HghT8SVaTIet?=
 =?us-ascii?Q?QOb9zHV6UZuWY3erj2OYX/UofbEyd5uCNaWhghQo0W4ggwKVJGzHjQyFehZz?=
 =?us-ascii?Q?Bb7Nhfsig2rbQhSnzlpwWg+QZCBe+uMxA5gq4vStRQoS7v834jzI+47yittF?=
 =?us-ascii?Q?bJwrMQdlumw5z20C5yuFNopl21lf7GhWU1kz2/F2ZE7YlVquS76ex26DaUK/?=
 =?us-ascii?Q?5PSxdKfpWHm8dBA4xZ1bSde4K7s1hhsgylf+byMD9iU6iTpTaHTW59VLc8+q?=
 =?us-ascii?Q?DLqC9G2TazlsNOs+xo2jr21lswdmJ2/8N1uU0B6fQ8IitA0ctMHuVbGrRGnT?=
 =?us-ascii?Q?/ZwVsSINYVzvRWVt8Dw=3D?=
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
X-MS-Exchange-CrossTenant-AuthSource: PAXPR04MB8510.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 349c679a-9a20-4e65-0300-08de20258908
X-MS-Exchange-CrossTenant-originalarrivaltime: 10 Nov 2025 06:51:11.7516
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: VodOcOfL3Ezv8oH36zahqjVNuA+Y9X95g4CLIzmPRcpMq6oPqlHTEof60/nt/eHO03HF8RtNt4ip06X6z41dIw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM8PR04MB7857

> Subject: Re: [PATCH net] net: fec: correct rx_bytes statistic for the cas=
e SHIFT16
> is set
>=20
> On Thu,  6 Nov 2025 10:14:21 +0800 Wei Fang wrote:
> >  		ndev->stats.rx_bytes +=3D pkt_len;
> > +		if (fep->quirks & FEC_QUIRK_HAS_RACC)
> > +			ndev->stats.rx_bytes -=3D 2;
>=20
> Orthogonal to this patch, but why not:
>=20
> 	ndev->stats.rx_bytes +=3D pkt_len - sub_len;
>=20
> ? Is this driver intentionally counting FCS as bytes?

Yes, the FEC hardware does not remove the FCS from the frame, so the
frame received by the driver contains the FCS and will be included in the
statistics.


