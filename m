Return-Path: <netdev+bounces-247922-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 0B410D008DD
	for <lists+netdev@lfdr.de>; Thu, 08 Jan 2026 02:32:21 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 0D494300C360
	for <lists+netdev@lfdr.de>; Thu,  8 Jan 2026 01:32:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 16112222587;
	Thu,  8 Jan 2026 01:32:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=aspeedtech.com header.i=@aspeedtech.com header.b="LRiR3rJL"
X-Original-To: netdev@vger.kernel.org
Received: from TYPPR03CU001.outbound.protection.outlook.com (mail-japaneastazon11022142.outbound.protection.outlook.com [52.101.126.142])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3B2961DF254;
	Thu,  8 Jan 2026 01:32:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.126.142
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1767835939; cv=fail; b=P6eOpa2CHq96HJgpddh4cnFHBJtNzN86V4+20UbBdbxLalaTX9bdQhn8mFFh2R5aVs+csRAsTCgCwIr72fN7hfhK2l4iGcJWVBD7c02FtMCbCIxRjYV8fUeuViLSm9Waqj6Ox7QrTnljPIBYoMfiTbNRV6n0R0zYhCK32mA8Cys=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1767835939; c=relaxed/simple;
	bh=2dv1X2cQUqcWqZd3ieUdZW1sJqyFwzLeY+Vg61Az9jY=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=MV6uObTGpYpcIBEenaDdT5C/2pypVX5vwWcfWZnsspOYtaxM8Ua3DYT7cVerNyMH6QvbqvRJeVHUkWghK7yEeNyra4jtjvyci+ZBZpRSLfSsqYcvpCAjUmQxwl4cP8oknvyZxHwBHqx5nOIgp66rcSpGsOECg3U5cwAd6/Oxdgc=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=aspeedtech.com; spf=pass smtp.mailfrom=aspeedtech.com; dkim=pass (2048-bit key) header.d=aspeedtech.com header.i=@aspeedtech.com header.b=LRiR3rJL; arc=fail smtp.client-ip=52.101.126.142
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=aspeedtech.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=aspeedtech.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=slgd641VKlu9lmWJDY5nMDrc6YNO9ZpfCRK7765qnhuIkY/fd1NsdICU5x/ULhe1mzc+FteDtw/0/qE2U472DZDhG+3o/h49zNDbVnLMFE5kTBpYBNJiER2Dt+ySK4SRgl2aWpCrDVeydIIG8R285FXf07kkS/7MldFY18Ofbbu1K44LzSUughmY+eqtgcAiQWXEnzfmunPyymV3ScfrQdHB36P7GRgmM+8dDp/U6b37fK+yAnOEjVh8822S+jXIazN7MbAOMo0sq5SX6JBPmnjijhh3tqfjhe237b3F8jSFsMobn1UdwFffjrpbOR66grCctnI4XPeLkFQoqeYP0Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=2dv1X2cQUqcWqZd3ieUdZW1sJqyFwzLeY+Vg61Az9jY=;
 b=WIJnykQdRQ9ej6hDXMpRwt5Ziy6EOSve42w3w+hioRvAdtqFcdnySikUQTWkbTzAhn/AyYAMWaKTRn0QnPai0KKT+NgENZPBqQJ5OJzEG/4bDLfKijGwCBNh/Wo9eGtnT1Qq18Dhm3m4VQjal4iYaxDwvKUl/hmfOWJ4I31PDex42XsVO/U72sYzKuV0WFFi26TR9dHEY+2NZ6CLG1fLQ22eSNcRESdu6eCr6n5gIgbVQPh66UxItBmfQHFofrJ7y4qUk5OyCsymk0srssJBGzCdRJfFCgYHuhDm/7ptEMLUqEU5XkrDkvIEjVmwD0jM4Ag7kgDFCTU+WlZbrHirbg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=aspeedtech.com; dmarc=pass action=none
 header.from=aspeedtech.com; dkim=pass header.d=aspeedtech.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=aspeedtech.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=2dv1X2cQUqcWqZd3ieUdZW1sJqyFwzLeY+Vg61Az9jY=;
 b=LRiR3rJLp0QCM/SIryoz8ykJUCrKpLTIhN33pEA+it09sOO9auh1d75Ecegl/aBCBwQ9vpzb0rUVfpDc0gBeLJcMX2TcuTmw8H1/yTfLZ02wX2rduj+iYneQ5dCkLfnNpTbw5Ynl6Uix4f+HeSyatwAzErKfjGmBqDaxOj6yf8nI51HabeoRnSemLXAfC9UQwI8/n1PEu+rORyYTRLNopocgb8Ynd69ce8X0IPgnglfa/z9/vnasJhLjxPUthGonG8c/1Ps6KD4T18om9C4cvppsRKRGXtbh1GnTS8xVL2lA40NpBHj1oRc9pNUoJVuiWxhw1RpA5LNTqUl7ojMCUA==
Received: from SEYPR06MB5134.apcprd06.prod.outlook.com (2603:1096:101:5a::12)
 by KL1PR06MB5941.apcprd06.prod.outlook.com (2603:1096:820:df::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9499.2; Thu, 8 Jan
 2026 01:32:13 +0000
Received: from SEYPR06MB5134.apcprd06.prod.outlook.com
 ([fe80::f53d:547a:8c11:fc6c]) by SEYPR06MB5134.apcprd06.prod.outlook.com
 ([fe80::f53d:547a:8c11:fc6c%4]) with mapi id 15.20.9499.002; Thu, 8 Jan 2026
 01:32:13 +0000
From: Jacky Chou <jacky_chou@aspeedtech.com>
To: Simon Horman <horms@kernel.org>
CC: Andrew Lunn <andrew+netdev@lunn.ch>, "David S. Miller"
	<davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, Jakub Kicinski
	<kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, "netdev@vger.kernel.org"
	<netdev@vger.kernel.org>, "linux-kernel@vger.kernel.org"
	<linux-kernel@vger.kernel.org>, Andrew Lunn <andrew@lunn.ch>
Subject: [PATCH 08/15] net: ftgmac100: Move NCSI probe code into a helper
Thread-Topic: [PATCH 08/15] net: ftgmac100: Move NCSI probe code into a helper
Thread-Index: AQHcfhIrXSon7xjtjUuUIVCMEmMbCbVG4AcAgACgv4A=
Date: Thu, 8 Jan 2026 01:32:13 +0000
Message-ID:
 <SEYPR06MB5134323A3EE5DF43EB2FDE819D85A@SEYPR06MB5134.apcprd06.prod.outlook.com>
References: <20260105-ftgmac-cleanup-v1-0-b68e4a3d8fbe@aspeedtech.com>
 <20260105-ftgmac-cleanup-v1-8-b68e4a3d8fbe@aspeedtech.com>
 <20260107155546.GD345651@kernel.org>
In-Reply-To: <20260107155546.GD345651@kernel.org>
Accept-Language: zh-TW, en-US
Content-Language: zh-TW
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=aspeedtech.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: SEYPR06MB5134:EE_|KL1PR06MB5941:EE_
x-ms-office365-filtering-correlation-id: 20a6606a-f52f-4fdf-234d-08de4e55bff5
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230040|366016|376014|1800799024|38070700021;
x-microsoft-antispam-message-info:
 =?us-ascii?Q?MUdk/9ywjmi08CqfN9z6ceKTDjWgG/qNTb2rP8X+mQS0D8ui+S2V36GuDmiz?=
 =?us-ascii?Q?ouwHM7NkYYl+A/lq9y3MFLyVqEPSxcnoukf+vK1Ive1bnK95ps2/78nt40m1?=
 =?us-ascii?Q?ndEDFGUCa0obAZheiv9dH+75MZPDdPvE1XBRF4HwaPds6EajMywELQQXhwfy?=
 =?us-ascii?Q?SA93Q586RDxqj/4hjb+/tkyu7bbOglWMI8jOj5UQMMBTfUK3eYf+yjqDDRTA?=
 =?us-ascii?Q?4lcx571gwMKb/jMPvTR7UsQSkt6f+jwS70ESvRgOoDWvoMICb2vz92m2Yw7Z?=
 =?us-ascii?Q?NVutNy7yrFpG1NCRbqss/deGTs/mEwt31Cg/RDJZoqNQrZZVun6LqtM5niY9?=
 =?us-ascii?Q?i6UXRkH0E1brQECmIIuqoVU+GSpYBoKOOyMYmY2fXVpK4iopr2ju0CES+CUx?=
 =?us-ascii?Q?ExUhvCKDfKWwWEoqjYh4wgPl/W+d9f7RyYZvFzjMlNcxF2G1/xVcbYyaMNgh?=
 =?us-ascii?Q?z0gn+raf0Dt59MoMuuEqaskAAOt14YAX2SoAaTE1/uIBrAxNYAaZpJ0X5Hty?=
 =?us-ascii?Q?I6m5LZPOfpiK+AFVyoRr0SwTMDIdnAvJhOgzeXvTcKHghq581UbT1NsFO9GS?=
 =?us-ascii?Q?lZth8+Bmi1sfY8kyREIxQXGqn706oVQQJ/9KYr0mI120ECRFUpSUkffUPfkO?=
 =?us-ascii?Q?Em+dvuzPcqyPzD2CODRC/a4RJZJz24YEg/8iXCQv7jhhBKlDAgnBQdGNlRfl?=
 =?us-ascii?Q?SZiOH28DV8s2KkLe+gavtcj9WZnY+GylJyaUPCExvpiHpgJIKIdo0LAfmNGs?=
 =?us-ascii?Q?+8cBXJ3eHuwX/FqnlO0zEi+KBbme1nYce8SSkMesJPun8ffM6o56cAPpM7J4?=
 =?us-ascii?Q?5bpm+0eXY1YSeLm0QwnP0xbet+e6LI6nqKVOBtl8uSYswKqVNb9kLlr4QCAd?=
 =?us-ascii?Q?PfjLLOrczG1OL9Y/7OH5kRlab68WnBgmEfmYuCWGrOyie+0YTlLtbzojkWsX?=
 =?us-ascii?Q?3jDMqhCYhQd15sqLephI1TL0jUJDq/N+cNYBaexHLDH4SeSkoAVxYuDKn6Af?=
 =?us-ascii?Q?i4hXophKktDHM53udRL6kFCKpF5G9vr5Xx21XannpM0EQOKZAenjcJ7fiOfh?=
 =?us-ascii?Q?iunuxweD4KnA+7VtkupG3aJ4J2f5xSl+AsiGS0KKPKDOnfuxqRTqx+ilSx/d?=
 =?us-ascii?Q?eRsJQyXYYw5x8EdupUa8O5jQodWI7CgeKyZM6ZSuu0Ga8PqTt5N12o8j+mTN?=
 =?us-ascii?Q?8+ATAEzgJsTy9mjam4GKTrX/RjdrovTKUL9GxowF66bdIgCfGK0iqtsD6QAE?=
 =?us-ascii?Q?olvTTUsCH6ZNozmZHJslm2Ay8mZ4kYaGYo2KVMdRh0BObSKo5L5z490ncbQd?=
 =?us-ascii?Q?xAQqYHeV9yEHAYFN0VTT43i8jlpcwdn9a0/SgF65PyaBSQpWkbPGSXW9plNv?=
 =?us-ascii?Q?7XgiWbNgx5Tzl63WgeGO7ixjPUPn3zLPum7QQFPwqGz55vdJny0/MX8ygx6J?=
 =?us-ascii?Q?mKxN+jvhOaBvGh/QB2PP5Osn3vvGGWtB0hNm0tkGE4Q6SF84b48Xmggb8URo?=
 =?us-ascii?Q?LN0MM2jqMP1y1bN73cqME8vK78EZkZE1gps7?=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SEYPR06MB5134.apcprd06.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(376014)(1800799024)(38070700021);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?us-ascii?Q?hPME2rDbW4wZPNJOoaoggAs4Co4ZyfQJeYAVM4qHakuJlyg6hkigIl6z4dSQ?=
 =?us-ascii?Q?JSt9EI2wGHki1oq1X3PSL8bXPCDReEShjqzFYfPkTaScRGsrCTuzOSMsBDWG?=
 =?us-ascii?Q?cQGo0a/F8pdkt8nzCY8AMCk3uAt6EiYRYY/kuiXdVnG/e0QwM/3azrRpabb3?=
 =?us-ascii?Q?hmaxBXAvXv59fx99LuiHGGeSZ9Diu2Ir8/JxiBblTXMwF9dx1AN2cVfb0PRF?=
 =?us-ascii?Q?Qh2ggLQUGKEOv0lifMpBsp31irofUbx2GTQmnkYrZrq+aP7PSnIHvHE/q/UR?=
 =?us-ascii?Q?Sv2INp2LAhXlPzFe4JmXXErXmIvKf9X0emJLsV0goWuTh+yUnoFmPXx7x2Xc?=
 =?us-ascii?Q?Ch+pluEJsdxiTBTy0DL+T68+U3H6nENO5fdPSudlSV+EgPHwwP2DIcsU4fwY?=
 =?us-ascii?Q?obZm0hia2tPC+s/W16BUXU/YMCb+wf7ajox1y06i41lxIx6L70JvTeGk0Odp?=
 =?us-ascii?Q?uYiVMy9I4XNRkRgQG2dR8vkOfGFeHaTT0IZvNWMQ5sX31+etZZYF2dijbyAj?=
 =?us-ascii?Q?q0OtI+vG+9gscIfkBgbQgQ4WDjhlYcghaVEfG0SmZCJ177istaFBlGvaKo3E?=
 =?us-ascii?Q?gyCxj2LsXHR1igqRnkGNaXuUopMGMrkydB/bAx2OKH/RnV/JGqZVxzdaM/o5?=
 =?us-ascii?Q?sNF3TEmblu5tPQqxrUCLY6r96KukPl2rd9a99NVEAgVjnPz8xAqVaUL96ASO?=
 =?us-ascii?Q?GedmBU+kSRoKlVgK31LOIJYOI1V423Gj59NgWGXkQtoRLDDV9S6gHhdfaR5K?=
 =?us-ascii?Q?WlOKBLWlHO+Kf9UGcIRN5jY7XMbA1YqG73Yu1avTvgQ9oDM0FeW7rdICcSy6?=
 =?us-ascii?Q?qx043dlHqBYieeU7ItMUkxyxrGngkIIlcf+0fD8p0BDse9RktRM9l4Xt+AJ4?=
 =?us-ascii?Q?uZOWYX3SakaVcOUj54OoVu3GuXjTU6K06ViIHiw+vpGBUOI+Y3cSV2lmKHvZ?=
 =?us-ascii?Q?8PiaXIqeFIAFma2VbTP+y22zE0XuaWJUeT9s7Eds6YKWbP2FnFEB5VLGkQfX?=
 =?us-ascii?Q?pTkdO1oNtI1zJXpqTuLK2qrv8RWWYnBcrQ0OnS0QNY1S0++5crAxPdJE/LTa?=
 =?us-ascii?Q?Ti82hGbLMI8Gt99vTk4bqZWLtxBi+l7m5E9PHv+pgR9Hpl3Z+d1nPUSXbgjS?=
 =?us-ascii?Q?6tndgroeLcrEfjKXvAi9i/v+h/NzW/feglb2rNfwbLcBEnPwsogvr3MHdllO?=
 =?us-ascii?Q?mltkmJO3RaiumR7qpR8zW/AQuSe44oWlq72+b0+omMSci+skXFVTubvNPplE?=
 =?us-ascii?Q?N8btcpMt/J2RrX1rLRkDDrAy/ybCIjjaA4BzXLqO0FEix3i1sCrxfz9Ff7X1?=
 =?us-ascii?Q?ImlJFwXfJMx8vTshRUj8ScrIzOn+iVmcTlTJvbiFh6RzXdFlHM54FcsKv6dz?=
 =?us-ascii?Q?7wbR/VOURsN3ftIOrJt9tZZkmfUignm8vqyQo8to5cCZ1f9i7DsrV6UYOWGT?=
 =?us-ascii?Q?CU+WBVDOnqKxEbdPJV6QfijGknc3AkPzxq8MElb/Oyme+GA+4bFtGle7cUSz?=
 =?us-ascii?Q?7k/lTRC7D3w/oatpGJLxA7oEfwYrIVhYqHAwvdE/mv70pCILMAdlghBti1za?=
 =?us-ascii?Q?TwXINZALep8LCRuqX6eANXA9Es2XHNP6zAGHfggjByIm0S2DbChzwUJ5Jwin?=
 =?us-ascii?Q?ZBACqPd/aFKfL7vImwb3t3pnfjrJHXACD+wqWzTZw51TMRSOMx7TQlfneHfS?=
 =?us-ascii?Q?dgp1KfBGi3IEAGEi9eNLtMyNrEet3C7oHsP3hIf6emdHhXRncLSJE29l/M/C?=
 =?us-ascii?Q?iuybzzKQ9A=3D=3D?=
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
X-MS-Exchange-CrossTenant-Network-Message-Id: 20a6606a-f52f-4fdf-234d-08de4e55bff5
X-MS-Exchange-CrossTenant-originalarrivaltime: 08 Jan 2026 01:32:13.2698
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 43d4aa98-e35b-4575-8939-080e90d5a249
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: gSHRyiN8274TUGu+F8c2gufgmvOL/G8OyYyIjo0jR1Ljk0slctuY8YQijinvwAuj/h/mXGJdLVKvDFhP+iAPZ7zYpNq+S6EpUhxfkW693LA=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: KL1PR06MB5941

> > To help reduce the complexity of the probe function move the NCSI
> > probe code into a help. No functional change intended.
>=20
> nit: help -> helper
>=20

Thank you for your reply.
I will modify it in next version.

Thanks,
Jacky


