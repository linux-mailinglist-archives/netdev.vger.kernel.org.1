Return-Path: <netdev+bounces-247923-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 952F2D00913
	for <lists+netdev@lfdr.de>; Thu, 08 Jan 2026 02:38:01 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 7A894300D4B5
	for <lists+netdev@lfdr.de>; Thu,  8 Jan 2026 01:37:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8B44B19CCEF;
	Thu,  8 Jan 2026 01:37:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=aspeedtech.com header.i=@aspeedtech.com header.b="O6sD9puQ"
X-Original-To: netdev@vger.kernel.org
Received: from OS8PR02CU002.outbound.protection.outlook.com (mail-japanwestazon11022082.outbound.protection.outlook.com [40.107.75.82])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D036C757EA;
	Thu,  8 Jan 2026 01:37:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.75.82
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1767836274; cv=fail; b=Ujv0OO9Gq/Rwj1ydE+PsSIV/5pIM5oLXUtyUAIsvbA2BoJgbDxRk+AUPtbrjGNP/ixlOj8R/vVqVBj0aMlZTZhaAo31SE52aD3rDxgLc2cJihKzZNttt5smwnRhbnmwo7126J7A4vCq/vX/93MbgsJDkPgHIXmDxfPMSFR42jWc=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1767836274; c=relaxed/simple;
	bh=jrW2gtMJs9v2p47sndtrFwCNp9RwYjVrVzbDkuXTrPA=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=gzmIqRy6jEN/E5rVJ/7dP/mttAw/D6xagE5t3TOdoZtQyVw+fLzQWvvvPxng1cwOA+EtMhTzLJfQF2+v2dSd2H/xy9fKburYgDYO0rVeX8uOejRof3KSvH/uDDU6qK/wXYkY2xPeFnQByZrFjot3j8QfBSTMVKXwYfcvWbpNh+o=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=aspeedtech.com; spf=pass smtp.mailfrom=aspeedtech.com; dkim=pass (2048-bit key) header.d=aspeedtech.com header.i=@aspeedtech.com header.b=O6sD9puQ; arc=fail smtp.client-ip=40.107.75.82
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=aspeedtech.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=aspeedtech.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=SXwST3Jm1qxFE1aoV37lPcc+9QIemUM9cbmK10tPamNUsIjR3DX1yUZ9mASjQq2fkOHrRuR4M30Ywr4vceYYxenTIkmgKT3aMM8r/YjRa14UTOY39aDGZUZj74/6QUuyMPDbRVRXNpvCmRRsuFk3Ny4+cToW0uZ+D19q7N3P7PMYMufYhwcKluKXa7lBrekDJRTia61VEGiFCWBXpMXXyKQl6toeeZWIUFGyJ5DUjQwrddw2y1OTz6LHxYiVs1icFi3IbqFvlwSEunEfYL/nJcfciiri4rwfq7f4R8vleJs15uP0Rr/SeG1SZ+6r/od2itbkF1kSrqzMVC1eUu0jQA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=MndV3awltG3+8Vce9MpPbPOV7WnMGncPm/LxwFeyyzk=;
 b=yhsB2yqN+WKsBFSbYdQ1EF7GorhkYDCO1kF6An/U1E8HK9d26gtPaBpI/eUyb+DGVC9/SAvUgYbtok8SHsiqo0EbsD4SIIoaapWtUrY8MZRZViboCyHDeJfgk7T3xGrNsD6PnFdX3oBtEo7Mmw4UEGD+pnmBuONeCxDl3/chDc2gRlf/LnQi1oeyCREtFfPnbEGycGJvOmjD26+4zsylW37gYWV7U5FwCRw5o24stD6YnGak1TgWJOiNRnlfq5ujouw0lwWn0fBIYfJPLQ+WeHA/JDs5MK8fktNk+zymKiJESENd3zpnfr/M3zJ8Nx1tjW+u+U40r8Vn+QeByR79GA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=aspeedtech.com; dmarc=pass action=none
 header.from=aspeedtech.com; dkim=pass header.d=aspeedtech.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=aspeedtech.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=MndV3awltG3+8Vce9MpPbPOV7WnMGncPm/LxwFeyyzk=;
 b=O6sD9puQQO+5SzC1DrY9dKL0ZJsR9t0qQFjfzjeLVad+wneAj8S2F7estwzLsrpjlMiHBRvUJiKC42sqsKOw64E9O43YJozdjSbBNnmldB9diohFErNrxxHEPHeUE6ZRrxtlRuo4p4q722PjN0rTB8vALSzYTvZk9/FhDg0W+Lq0KRZAk27ltUX2T1TQccTfdgeMIYNnjYYmIB/7jh9yGqCsOLtmWRd6+03fJ5uyagD9HQgp9++Jb/JiSk/Bzc+9Gl89jaTUb7GvD8yYrytNg5Hyz9IjTatrj4XNgdd4CqIVbL4PFEJa3wSI45AQxh405Gd8tWGObACYD/wnBBpYIQ==
Received: from SEYPR06MB5134.apcprd06.prod.outlook.com (2603:1096:101:5a::12)
 by SI2PR06MB5363.apcprd06.prod.outlook.com (2603:1096:4:1eb::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9499.2; Thu, 8 Jan
 2026 01:37:47 +0000
Received: from SEYPR06MB5134.apcprd06.prod.outlook.com
 ([fe80::f53d:547a:8c11:fc6c]) by SEYPR06MB5134.apcprd06.prod.outlook.com
 ([fe80::f53d:547a:8c11:fc6c%4]) with mapi id 15.20.9499.002; Thu, 8 Jan 2026
 01:37:47 +0000
From: Jacky Chou <jacky_chou@aspeedtech.com>
To: Simon Horman <horms@kernel.org>
CC: Andrew Lunn <andrew+netdev@lunn.ch>, "David S. Miller"
	<davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, Jakub Kicinski
	<kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, "netdev@vger.kernel.org"
	<netdev@vger.kernel.org>, "linux-kernel@vger.kernel.org"
	<linux-kernel@vger.kernel.org>, Andrew Lunn <andrew@lunn.ch>
Subject: [PATCH 00/15] net: ftgmac100: Various probe cleanups
Thread-Topic: [PATCH 00/15] net: ftgmac100: Various probe cleanups
Thread-Index: AQHcfhInJWdOBpwZaEuBYtwuSeaWNLVG36mAgAChemA=
Date: Thu, 8 Jan 2026 01:37:47 +0000
Message-ID:
 <SEYPR06MB513424718263D12DE440451B9D85A@SEYPR06MB5134.apcprd06.prod.outlook.com>
References: <20260105-ftgmac-cleanup-v1-0-b68e4a3d8fbe@aspeedtech.com>
 <20260107155427.GB345651@kernel.org>
In-Reply-To: <20260107155427.GB345651@kernel.org>
Accept-Language: zh-TW, en-US
Content-Language: zh-TW
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=aspeedtech.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: SEYPR06MB5134:EE_|SI2PR06MB5363:EE_
x-ms-office365-filtering-correlation-id: e5383d2a-c7ff-46b2-caec-08de4e568710
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230040|1800799024|376014|366016|38070700021;
x-microsoft-antispam-message-info:
 =?us-ascii?Q?TKnn/uCRC0YYEYF91imfrKySQkaXI9q3AIyaV5U8IDEdWBGUeA0quI5E0uYB?=
 =?us-ascii?Q?yypmfO0+8ZsPainSosTWKijkJPdJWpR+w0Zbw9Flg5Rb4NDPBZQH1apyX9I+?=
 =?us-ascii?Q?gSzG3fkUxF/WUFaBuamXuafPeOgewkhDo2Rb0SfU5Tk5UvF1ZLLD8Y1n/p9m?=
 =?us-ascii?Q?pSuyHJw6j+7WdmGFalhtJJ62GjUxKVkQ5/u4FmrjRVB+gHDkcvJybY9aX9zL?=
 =?us-ascii?Q?pkx6AknkDljzfhC8HS+0MFdg3JC5uxZEZoRsGnre0Gph1Hq/Flbtrt3qOul5?=
 =?us-ascii?Q?urZlDLUb+M/puhcYHte+2L4ZD3mWKG43PRGrnWE8DIiAk5kdNX1yeOtKonxk?=
 =?us-ascii?Q?kEsoJs+gOEOYvlSAii5zcmDY8N900vKl3wghQRDECZddo5PU0r66ZlOIBEDd?=
 =?us-ascii?Q?xaTgMjuiELHzKLcaJbjY8QPNRAgcsjmRLX1vfimk7RQYjgqkvxqCOL3DU5rX?=
 =?us-ascii?Q?ZxXopMVWhed+86pz/5MroEvDlTEXXBXrsJAR4R4S/L0A56jElODr1SRGNiIl?=
 =?us-ascii?Q?bXHpmldxgvyWPZ4n7cay46txiZrSunu+SL/8ftajyxuJNdKwUPMW/pOHddiD?=
 =?us-ascii?Q?4OldH7eIw7JXP9fAI5XzwZTdIzqXmtSDxYPmj0lmt+aUKgYxVWI3GbVLztmS?=
 =?us-ascii?Q?1Bq8tkEUWr7pyqIOzKu6aWSlxv0asXh1brofTKKZisENrBaRiKO1ryBM9c/K?=
 =?us-ascii?Q?2NJb9CXcMViaaPwfg7pTdgPe4DvLeeAzL1ICW8QIRrScS55/EhDPFuBdv10a?=
 =?us-ascii?Q?G1gJrTs4h1MxDUiUsdsK65OlK+hukqtbkdF076sxFwv8GOoq3xcD5YJWUcYQ?=
 =?us-ascii?Q?L9Bb1r8g1G349f1jyJW2aykyTK5KILv5kg8rYcAs/XXHa51EyT61bN4Z4nSX?=
 =?us-ascii?Q?BO6PYSpycUVjC4x0uTxhvQGeSQ/NRhHQ0nfED7StMsJIBMTrUx+TXmnXs5OJ?=
 =?us-ascii?Q?X43bzSCFvRH0i7KVoc75QAqkBOuAvHWSmg6QD6f+XUlmsvoPyLhPoeE+FieU?=
 =?us-ascii?Q?EgGGT5DzZsDSsBtwvKX8zSAWl4joNuJDVdrQuRP5JVpah2cuy2WBN+GRTEB2?=
 =?us-ascii?Q?iQIpSSYZUcbcox0oD4HJ295f0Rp79b9w7LEGm4d2N9moSL686Ee3sUreIAKe?=
 =?us-ascii?Q?jWYSLj7rE+T0k/qcyCqItD+sFRcQEnd6AmUlpqLei7QTmwNsNH5IEWg+1PmZ?=
 =?us-ascii?Q?DiO+iI9hx93zcO1bxeL14w85+EGRcthqlwwBURR0k2TfhdlWOBcfRZgOKv1q?=
 =?us-ascii?Q?pBIDfxZX2a+2CwNI8I/CAIwnjfzhM9nMdlsrXfLggiVqCdtXQwFNkKfiddjj?=
 =?us-ascii?Q?EeAOsscaOZNTQabT8VozFZYMcteNUB6J7MctOa8KuIv7iEAMtlluc0OMRpj/?=
 =?us-ascii?Q?E1NXBCKSrINmN0N9SDipeuMTr08RJnwRZhwPny1yzro2PE7UW9oGgqwV+NRf?=
 =?us-ascii?Q?rJeoos0Dbje1P09p+3TQwpYjsKZKs/ROOSdNJll3Sj6vzGepIf6iZOM0s4UX?=
 =?us-ascii?Q?spHs513Osh051x9SXbIBs4VtuKUONcgsvxXy?=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SEYPR06MB5134.apcprd06.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(376014)(366016)(38070700021);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?us-ascii?Q?N0nIzwf9QgphvpaGE0823lQhCBfA3LJkYvej6gZLZy7YsQeLfCEauoldWSkz?=
 =?us-ascii?Q?ZrFkoG8sjrXC5K18g9rFEeoKTQb9DLAQUbbk4FTQwTmBcgvt32ve/F560ic/?=
 =?us-ascii?Q?h3c3IBgH+KEa3udUxMB6qiCGsTQQTr3ax1sirj14sbxnI994jB3wlaeDCYo2?=
 =?us-ascii?Q?TD7Y8NSbsul5nyQTLv3iH9VDW9Vdy1LuQDtYB5rcKvETWrb6IDC9Vv1lbnxk?=
 =?us-ascii?Q?ndtyfXKynUwxe5B2lzNe22u01/xiMBSyETUSfVEJ659L45ZJyFmK3hSKFY46?=
 =?us-ascii?Q?RSirlVjEBJedodXMM6rMZdzzcULLvsFIXzt98k0McBZJRIoUSKT81HYbrK0i?=
 =?us-ascii?Q?KQlhfvoVbcWk22i3x1+T4EgMRD9vQAfzbS+sOURmJOjacjO87h63x+U5GB29?=
 =?us-ascii?Q?eAJTP+r1iGUByJMb3QF2w8dRJ/DuM6NyYqoxdyTCUbmUGCtn2kNcbSKn+ZxS?=
 =?us-ascii?Q?TJL2SIPuiYKcvQFCL90BFpTE0otj+PsXnqBjVhXbHwR424Lg+d9nqQejxtIg?=
 =?us-ascii?Q?j7OZSIBKY3TPOcA8FhVGO/kVdIL/E2S4FmuCiDduVL2ZuWAGT/a83ZuESdrt?=
 =?us-ascii?Q?+L0KFChS52HdQJTwjjaTqJUcoWyYyjQikFQ3x3fDrsMHYJdKAHNGM8K565g3?=
 =?us-ascii?Q?oUW0tNro+7wGPNCuRpnNtvVpKV+JWHZjrUW8nXWrfuj5VyOYMISPwC9htUV8?=
 =?us-ascii?Q?4XNu7uqb7a+DlKGRN1DuNxc0ydC9J4JJFHNrr/mkL8IaMfto5O707cr5s73M?=
 =?us-ascii?Q?Pt33NP0gh2s/IwOTD73TBhmPT8g/0ACoksHKnsIqoazW6Ynd5mS6+QwO5ClJ?=
 =?us-ascii?Q?TIhTu417FmPo8vP7qVZajgF+MaVLX0BPcnitG81HLuGp5oWmO/3zzkL0XkzB?=
 =?us-ascii?Q?KrewIPft4Y55h4ztAYIjOPO2M6RNccspjxNsf3f+VEOmAkXyfiWLvWO2ohpK?=
 =?us-ascii?Q?xjQ73+XfuX1cSTf4814lVU78ETs44p58COKEwGK14sXfRweeiFG4ojwQMbFT?=
 =?us-ascii?Q?TLj1vQ8FV2iWgY+wZuL5w9YfEuAeiIC/U6oHHRjg7xD+wRdsqvC0QHjstIA5?=
 =?us-ascii?Q?tZ5g+mlIqBixuUdL/oPTE5KwiXvRJoUi+2YfTWO7m2eY6CyFsWLv5D/lm2XP?=
 =?us-ascii?Q?M8LAhT7Eri/yVGepECagtGNwh/WRVPHCdj/YgLclolpYd75rMNEos3vie6zK?=
 =?us-ascii?Q?gKa7bxm5OZANktb6ZIi08rD3SyfmdfAKDwnAp0RDndh3Wq0ePYnKDQweOwia?=
 =?us-ascii?Q?6N75/iKsLnL7aZvirPlqHByGg9JLQ7Uj7P46plqLZ33QIPp30WF1as/5k8mZ?=
 =?us-ascii?Q?9OZ7tMv4wNkSTJR7SkFsHxfIqHGNWEMpk1dUYLLdQZ9MswO7JLQ6ZakuzMkQ?=
 =?us-ascii?Q?d4+syuGc/uPEyI2oaK/KSqqsrRV9THfz/KFoVZxLxqJw3YLX2KQh+b+MKvWl?=
 =?us-ascii?Q?QSaN7ZLiH7BOzjeSiIZiDbpY0uFni5ckgY+Jq1ejuWI4p9WqK34CueKalx1K?=
 =?us-ascii?Q?ylFCGblX9sn7KpoX8mTtgiODzOyOlXh0ghyKFtOHaO1A9zXTQWbQbJBtCIEN?=
 =?us-ascii?Q?d3juVg0uLuSy+a4AnMQY8Bf5OYUWSBc1VXub4+m18dy7cxWvzjLuxB4+J/8Q?=
 =?us-ascii?Q?/VP4bfdj/TzSfR4gupO1zyCzRBAYlQA27yZTsIdFWSPI+urQf6IoyItKDgjX?=
 =?us-ascii?Q?Md+z4V2Zylz7mO9MnZxgFxIwnwffagEbrKZ96BaD4cRPDRa4c+9FMNmr2Tpm?=
 =?us-ascii?Q?thiYRWVjTQ=3D=3D?=
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
X-MS-Exchange-CrossTenant-Network-Message-Id: e5383d2a-c7ff-46b2-caec-08de4e568710
X-MS-Exchange-CrossTenant-originalarrivaltime: 08 Jan 2026 01:37:47.3135
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 43d4aa98-e35b-4575-8939-080e90d5a249
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: BTGSmJYLUliPL9PljRtZ2Tp5tH6ApoPhHoY+Hc1AzzviLnIvtHawiwVkEEAIfbw1vI4hyTUVeIL9PhXJaT1AEu8ocY3sEBauQGQvLbhun6M=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SI2PR06MB5363

> I'm slightly unclear on the providence of this patchset.
> But overall it looks good to me. And I particularly like how it has been =
split up
> into bite-sized chunks.
>=20
> I don't see anything that should block progress, but I do have a few mino=
r nits
> that I'll raise just in case there is a v2 for other reasons.
>=20
> The first nit is that the patch-set should be targeted at net-next, by in=
cluding
> inet-next in the Subjects, like this:
>=20
>   [PATCH net-net 00/15] ...
>=20
> The other minor nits are patch-specifically, so I'll respond to those pat=
ches
> accordingly.
>=20
> Again, overall this looks good to me.
> So for the series:
>=20
> Reviewed-by: Simon Horman <horms@kernel.org>

Hi Simon,

Thank you very much for the careful review and the positive feedback.

We really appreciate Andrew's help in organizing and shaping this patch ser=
ies -=20
his guidance was invaluable in getting it into its current form.
We'll incorporate your suggestion regarding targeting net-next (including t=
he
net-next tag in the subject) and will make the appropriate adjustments in t=
he
next revision of the series.

Thanks again for your time and for the detailed review.

Best regards,
Jacky


