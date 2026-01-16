Return-Path: <netdev+bounces-250448-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id DAFAED2BE97
	for <lists+netdev@lfdr.de>; Fri, 16 Jan 2026 06:24:06 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 80005300997D
	for <lists+netdev@lfdr.de>; Fri, 16 Jan 2026 05:24:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2CA4E3375D3;
	Fri, 16 Jan 2026 05:24:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=microchip.com header.i=@microchip.com header.b="lh7X9JHX"
X-Original-To: netdev@vger.kernel.org
Received: from SN4PR2101CU001.outbound.protection.outlook.com (mail-southcentralusazon11012056.outbound.protection.outlook.com [40.93.195.56])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D7770322B83;
	Fri, 16 Jan 2026 05:24:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.93.195.56
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768541043; cv=fail; b=Z3uj4x6psV7EkZ4jsHt4daNSYI4LLQknxTXlJBeCwsxQDTcpOMCXnSXpzWR5QD5mI/Sq3rMhRJMjCxiFAKrc5w1BGTZCG02yiKhMNIgdEr/JvONIFl84cItmZ+rDd4aE9lQldaVi9K2AcHr1DGGLCSzwTunKHh/5MTTiZWu2QeU=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768541043; c=relaxed/simple;
	bh=Gzo5Pb67ZK2URp9j6s8twP48fr00tpXiaZhoEyw+Io0=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=nndofk0yRYhQlK9S2A/kTXm6/l3EWGW0+fXnUH35N/YonviI0K9p5hsvZv77lXN17DocXsCcDONyYRSJJStIOgoLn9YwYHes8JaZSlFhFuISrss5Ru0P3dipXPcPPDMkExvskwC9uUasyjvg52/kiTMGAAoyHzsj0w1s9L39wTY=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=microchip.com; spf=pass smtp.mailfrom=microchip.com; dkim=pass (2048-bit key) header.d=microchip.com header.i=@microchip.com header.b=lh7X9JHX; arc=fail smtp.client-ip=40.93.195.56
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=microchip.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=microchip.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=scgW3E37MK50sxWQyT5q/Nds1W5OE10r3T+A6JUgLg0uXGoj5v26Bmp7IefUpWKCVgwBMuXXPTNksOuZ/esBkUSatObuhL3Ky/ssNi4uN0QEKG+ugt/Xu8sYFzz4S446hSgn7YM6jWk6nw4geXyySslfWL2YJgliCyyJ+6Cj9gM0HCQdAImHmmKRkCGpvTbSaA0eEzzwYQWFYjNL080StDy1k6HC9tXXDEjSr6CRJ8E0qibKsG5LWDojid1o4mGwB1EbLSRDQIh565SyzKIVs2U8rZJMFLM21WgrYn/zOwSktaMONdUI22ntPm4NaOFhkHHpTHxp9UHDoUUjcLQl2w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=anPweXSQaLJSRBQTtb+0RK+AZNwlAJf3fw5bw9jtyI4=;
 b=XKYkVQb36UfxeGpPFWmC1uUzty4EasmqO/eZAHJgsdZ1moX1tEg03TgdMa5CKM6SqIdzqJmT72XQ7GMcbUb0Z46oX+rtfkP/3avWi8guarmhMbw5IHQ0RmpJPAiMiwgXXuyQ0Msx2YXgAOGG9iUMFh1kcOokgZM1Ld5R+FWFtWrPwY2gFs8/fotT4MrmGEN40jwrIc6Yd3uD+ciFFBqTLGE2W8AM082NQg6WEcn7JtBo8/vDpStpsevD455H0KY2Xu3slFvXbROGJatCPImPWq/7/oczNrW5gxKut11aKqZjJIiggniLPxvsql/4T5bl/d0C6HGpDqFyq4Kru/KrgA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=microchip.com; dmarc=pass action=none
 header.from=microchip.com; dkim=pass header.d=microchip.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=microchip.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=anPweXSQaLJSRBQTtb+0RK+AZNwlAJf3fw5bw9jtyI4=;
 b=lh7X9JHXKTb9O5AROPoPhe7CXMLkTYAfOPdqAFpndhUQ/0bFwz1seB51JqYfVVsKF4K9YK37JE5TKKKai+RXALTmldTTVNH3bIoybWWT5Dfyy29f8C7eoxhw6/s06I8dRMzBg7MGKUdWRUH//6MyiFH1UU8NBZHefH3NP0vzGKjiKmtXXo9NnsbgmlUBQIrsHjB2WYxSqvmy8AJsmsI9wX6rUhWOVVYAUqe1pNKK0jDK3HRMxFEPylBkOru43FE7jy+Mv2gKBOe+xviHC0q+vp1aOXspij2PzOPt/kguZPbZh3+IkGMCqDIpSZ31y34LPnHY2NHHXRXXC8r/8pIeXA==
Received: from CY5PR11MB6462.namprd11.prod.outlook.com (2603:10b6:930:32::10)
 by SJ2PR11MB8402.namprd11.prod.outlook.com (2603:10b6:a03:545::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9520.5; Fri, 16 Jan
 2026 05:23:54 +0000
Received: from CY5PR11MB6462.namprd11.prod.outlook.com
 ([fe80::10d1:11dd:5088:7559]) by CY5PR11MB6462.namprd11.prod.outlook.com
 ([fe80::10d1:11dd:5088:7559%5]) with mapi id 15.20.9520.005; Fri, 16 Jan 2026
 05:23:54 +0000
From: <Prathosh.Satish@microchip.com>
To: <ivecera@redhat.com>, <netdev@vger.kernel.org>
CC: <donald.hunter@gmail.com>, <kuba@kernel.org>, <davem@davemloft.net>,
	<edumazet@google.com>, <pabeni@redhat.com>, <horms@kernel.org>,
	<vadim.fedorenko@linux.dev>, <arkadiusz.kubalewski@intel.com>,
	<jiri@resnulli.us>, <poros@redhat.com>, <linux-kernel@vger.kernel.org>,
	<mschmidt@redhat.com>
Subject: RE: [PATCH net-next v3 3/3] dpll: zl3073x: Implement device mode
 setting support
Thread-Topic: [PATCH net-next v3 3/3] dpll: zl3073x: Implement device mode
 setting support
Thread-Index: AQHchVE53rjvGpeeJEOt0SuyhadL0rVUP9fQ
Date: Fri, 16 Jan 2026 05:23:54 +0000
Message-ID:
 <CY5PR11MB64627D56C60F8F76D22619F4EC8DA@CY5PR11MB6462.namprd11.prod.outlook.com>
References: <20260114122726.120303-1-ivecera@redhat.com>
 <20260114122726.120303-4-ivecera@redhat.com>
In-Reply-To: <20260114122726.120303-4-ivecera@redhat.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=microchip.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: CY5PR11MB6462:EE_|SJ2PR11MB8402:EE_
x-ms-office365-filtering-correlation-id: 7d87dda0-abeb-4ae5-5b7f-08de54bf7139
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam:
 BCL:0;ARA:13230040|7416014|1800799024|376014|366016|38070700021|18082099003;
x-microsoft-antispam-message-info:
 =?us-ascii?Q?ET13rMQyusDlXNhtVd0jl8n0O2H3AmNHVdix9iOPdJh09Ura9AJxCFkZcOqe?=
 =?us-ascii?Q?YeVaPOFCFUEUA1rmHLACxCABbmJj1HJ3BbA4XnuQK63nni5r7jqezOY+COVh?=
 =?us-ascii?Q?kcAlN0oR93wXl+UpdJRXbzLfVtFB4GvYSAt/3NeerxnQAVc3j45OBVj6fHy9?=
 =?us-ascii?Q?HTazhi+Ny1xuVFPAh1LF8q2Nj/MLQEXw7MEwdEY0uMU2e6Wq6kQ0vVnVnRzq?=
 =?us-ascii?Q?CnaOq7h9n66whd/LBgZ0e9e+64JlQ0hRWgGaAiPiSFRKRomrtFkpzlK/gn8n?=
 =?us-ascii?Q?Ir2YFELEcEpPJqmpzCz3W+4kwzzHJlhCbt0YnuAgNMkwsluEZ5xdOXKe4+RW?=
 =?us-ascii?Q?hjJ8PKBiVTnGDoDcZG6pEqLNnGx+HAWpFx0dEWhCtJdlbPhsYpJT0ZxCgafs?=
 =?us-ascii?Q?3VIZ6eM+fJWT1ybFkI9e2eooWXfMUX9Z+BIYZHL4mUQKqGxa6nQ4VMtPeS9K?=
 =?us-ascii?Q?wL/4c5Y2v1579Yrls+Rt1+9uDwSVJrvntM99fNE2dUgx0sowIyhS9Q8nHtz0?=
 =?us-ascii?Q?EAjk0AYLxPPZmd0ArWCzmNLD+HzofXwnY0O2PT4caKOSqPQH6rs1ATLqxkjt?=
 =?us-ascii?Q?8pdWDuFZCDv64GyagbS3GbLxNglQ7Ptt9AmzE97R0rZoffNpTKdDRXbEQnUH?=
 =?us-ascii?Q?cf+vZGY1PLvURmAHqWACOpibIpUTLUtnAGFGgYMvqeBfUqfiMKjbcWJhmL31?=
 =?us-ascii?Q?cRdsCgo3BUl7mZkBpx22tYYJNx5sM/35ZUpl1hEPjfzwwaGJusCVGua/L2gE?=
 =?us-ascii?Q?/wfGOGWlD5GF3x2pUdsonTDKTpc4/2sAugd/N4u3egC2aVAGE3XSbRE/+AqS?=
 =?us-ascii?Q?wWWjVq0RMUmw6lOZlAnNcjhbQ1QOT7p7pBq6XIy0ucKzq1OPnhFIzupd//c/?=
 =?us-ascii?Q?TQJk7nZsmG1HLTZCJc6r4bWaPEwz41E+pi78T1Id1rjfCfborcPlpTlAr5yp?=
 =?us-ascii?Q?46qVeJiMUC/gI1C2DHy4swxHcEhTot17B/HdQIkoQNPrhHVIz5/zRTAorR3/?=
 =?us-ascii?Q?+RepX7mDa+HKokUWqleOOAWCb7MpSRpeghGmeffdPeMRPshnLybZCopccBxl?=
 =?us-ascii?Q?OSBTXhM5NA8fRvuyF34/fLbhIXU+dujCfgPE6iFunpROE0evKLGGc5eioCgH?=
 =?us-ascii?Q?tU3306jFrSczvwbxXlHtN3OFV+N6PALMfZFkrhPP8DvUpv+rGnPRQQ4eNRuw?=
 =?us-ascii?Q?4RiiOwj5Q4tgpcP7s5nk4Opm1cFt4drZorv/tRTnC9I56CRbLLzcJc+27aGc?=
 =?us-ascii?Q?SArIfohWPPYLPLzhwlxv983eQIcTI+JXOlsqJXbi4ox0E7B0PBq9NNhSz6iQ?=
 =?us-ascii?Q?dX3CyhUnIcdBpbHSWW6u9mQa/azAevv6xYl63bfIQlrI9CHDQnTAv7yD2IvH?=
 =?us-ascii?Q?9n/zg87H7Aj8p+Yoq+K+9Tn+x3WrtG8VvlzE+HdirhnhcnmkvIsJ6WZZDkYb?=
 =?us-ascii?Q?6lAXIYz3UYQcW3oZGcqZb/kv0WdNAVSRxtejXDN6QcCPsivLl0acNt4IhZ4A?=
 =?us-ascii?Q?3Z7idJ9OnWjQZaz2ERwsAfECXQ9hB9TH+F2MHJoIhiv6dvjQvJMB9gyC9bST?=
 =?us-ascii?Q?NG3c6VI/YmXT6AIytaHsj2FdJ0ppfuQhp9VcWuAmRnbbhZr1jn1NLrkvY/Gw?=
 =?us-ascii?Q?eGqhfSwWTmp9OsT5XeSAqxE=3D?=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CY5PR11MB6462.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(7416014)(1800799024)(376014)(366016)(38070700021)(18082099003);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?us-ascii?Q?ISNMn/1iT72BfnrMKqcdCxa1lGu6sU1JKFoatiyK4uxt72Kptckb+xiGa9JA?=
 =?us-ascii?Q?xDO6OQmWPYjJUi99xxTTL1Q+lgwk2kj2Lf5h2TEMWfaIG1M89N1HRxBkk7ze?=
 =?us-ascii?Q?NW8YCKVY2ERUMYlkxDdbzPxKbMqD8SwCDnXuO/aS5B7MFj60G24alkP31/Ro?=
 =?us-ascii?Q?hwtz3vGuje9W2iqNBTlUPbvCXFCit+Bk56MCWzX9771t3OyTmOmPwIw9pxJC?=
 =?us-ascii?Q?/OHLwYQtcALEnd0krOYrvP/HlJDqr0an/1KbzJ5Nx2b1WD/IBpHJgKChr4gF?=
 =?us-ascii?Q?Rlji7aqcvOVFOKgSNUR3kmqDZqX2jAecDVjWRK82OHvYDZVSk7BEzfpHhTLw?=
 =?us-ascii?Q?FwzVpJTvPLq8jlchWwtcz7YRdZGUoKw6J0ltui8YZGGyfMesLw0f6qyh5T1/?=
 =?us-ascii?Q?ZmTl3A50pUcf9UEv+ic4Vk24BvebscVFHz+Lvykmnf6dlhGIhpL4tqh4DE9q?=
 =?us-ascii?Q?dqeFguNZ4v6YTsxh7AVW4fAauhpdWVWWL8Ikd8FB3J1jzb+fPXk5dQ/zCWfV?=
 =?us-ascii?Q?vd8Q4A8NMsdoWcQd+pk9sFjGzv59nXxEU38+VQZ+yneP0ucs4RVW0nAn1Bwd?=
 =?us-ascii?Q?NdSY0FJMN5ozwY7gdftzZJH8C/qLKNAWH9h2q8XEK3IgCx//xlFexqClNIMG?=
 =?us-ascii?Q?A7NbGr1VfHFfGXPU5lb7/SIkrrZsrDR9Cn78ZjY8UWOfUIVD60fgQ4+npzdR?=
 =?us-ascii?Q?XP0dshPWhI+V9tzx7DVUVokLOrY4Okizoe4ZKQAwea7g0LgR1D6cXhphXWHi?=
 =?us-ascii?Q?tvSuQzlx67BNdgYKcNAy1l4OBzcNNVt6J0BbAny+Y60l5Crik/lVPr3vH7WE?=
 =?us-ascii?Q?j+Ur6iyXlc8mEEipuhW0LvAyTixsSdrxkXRtSsShv4UIphUXYaWK5Jnq8EJP?=
 =?us-ascii?Q?ct2WuS6KG+FxDfHud4IEazW6Y0diOTgofBRRo16+uQ1IzxnNxcUFZ5HmTATU?=
 =?us-ascii?Q?UZsAOTV3jnHzWoIVmUMRc2sKT9hn+QFKCv1DrK+AJo7yOluAtsstYO6aPDGU?=
 =?us-ascii?Q?ztuRwB4k0t0nnvAL9XS/VTc1vUImLkhsBdv5uw8+RKqEOP6WgQs8hdUt7Tta?=
 =?us-ascii?Q?DaQW6V/L0YyjfLuCKR7qLQLX0RZ7PZzHbNAZwWGDCsE1U9EJfmzEJA6Lln4U?=
 =?us-ascii?Q?GF70FebGnq7xFpbciwm4BmZby7QSnioUa+biKb7X3R+hSlZbYzkmpogwMlNo?=
 =?us-ascii?Q?aoFjcrUxqSCh1jwa7EVPbAahILYG6XkWM1CfnBU1gcpKoDMb9dSTjF5WP3ml?=
 =?us-ascii?Q?LUqQRWT/HArjWQX4SNmKD60kXE+ItnQeIp1s0RGHI6BUDiGqdSXvsovZT/VZ?=
 =?us-ascii?Q?K1HsHb4hQwiW/IdX62gwpbFPdf3VqqawyU1LZbQzMKa5XV453XIvMSUQZsqk?=
 =?us-ascii?Q?EnYzB7PXi69dkJx17ywtMG2L0qscNGzM37+oisvFndqsgff5ShRbpczEtAMN?=
 =?us-ascii?Q?u1NolcxmJ6WsAkIVJBPOo5wOn+gaXH/rSoiHgMEFRM68PsWYmDzLTFazvG8H?=
 =?us-ascii?Q?rD1i1kjwM2hW1a19PwhNOe3TUkgZlZkt8qCXBcK4cHZft9KNBGQijI/+N3OW?=
 =?us-ascii?Q?wZK6WNAqemSb0JM1sHLHezo2Tjua4jFX2ysci4BsEe3nXvLq/8t4FaNnx4/k?=
 =?us-ascii?Q?m9VpfAk5v3ZjoxI14XAs/fOYhE95B/I/ydWVmm0R09UjYGEED4fF0tU9wWe2?=
 =?us-ascii?Q?X2IWygIhHcrAFNhs6iOu/WDgBLLJxP+1CQSfAyzXs15kQvz9GjFgB7v4dRVb?=
 =?us-ascii?Q?SWxs3y5gTg=3D=3D?=
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
X-MS-Exchange-CrossTenant-AuthSource: CY5PR11MB6462.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 7d87dda0-abeb-4ae5-5b7f-08de54bf7139
X-MS-Exchange-CrossTenant-originalarrivaltime: 16 Jan 2026 05:23:54.8163
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3f4057f3-b418-4d4e-ba84-d55b4e897d88
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: aX3OT4CqPgBbK0CAXaxIJn/ziNZFlNeh7ffmb5oxUFovNLD2EM+Bw5G16dyceE2//tLI5HqsyVpOHUjQ/km4FUzoTfp4/OvfI2AJnnn+AKQ=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ2PR11MB8402

Reviewed-by: Prathosh Satish <Prathosh.Satish@microchip.com>

-----Original Message-----
From: Ivan Vecera <ivecera@redhat.com>=20
Sent: Wednesday 14 January 2026 12:27
To: netdev@vger.kernel.org
Cc: Donald Hunter <donald.hunter@gmail.com>; Jakub Kicinski <kuba@kernel.or=
g>; David S. Miller <davem@davemloft.net>; Eric Dumazet <edumazet@google.co=
m>; Paolo Abeni <pabeni@redhat.com>; Simon Horman <horms@kernel.org>; Vadim=
 Fedorenko <vadim.fedorenko@linux.dev>; Arkadiusz Kubalewski <arkadiusz.kub=
alewski@intel.com>; Jiri Pirko <jiri@resnulli.us>; Prathosh Satish - M66066=
 <Prathosh.Satish@microchip.com>; Petr Oros <poros@redhat.com>; linux-kerne=
l@vger.kernel.org; Michal Schmidt <mschmidt@redhat.com>
Subject: [PATCH net-next v3 3/3] dpll: zl3073x: Implement device mode setti=
ng support

EXTERNAL EMAIL: Do not click links or open attachments unless you know the =
content is safe

Add support for .supported_modes_get() and .mode_set() callbacks to enable =
switching between manual and automatic modes via netlink.

Implement .supported_modes_get() to report available modes based on the cur=
rent hardware configuration:

* manual mode is always supported
* automatic mode is supported unless the dpll channel is configured
  in NCO (Numerically Controlled Oscillator) mode

Implement .mode_set() to handle the specific logic required when transition=
ing between modes:

1) Transition to manual:
* If a valid reference is currently active, switch the hardware
  to ref-lock mode (force lock to that reference).
* If no reference is valid and the DPLL is unlocked, switch to freerun.
* Otherwise, switch to Holdover.

2) Transition to automatic:
* If the currently selected reference pin was previously marked
  as non-selectable (likely during a previous manual forcing
  operation), restore its priority and selectability in the hardware.
* Switch the hardware to Automatic selection mode.

Signed-off-by: Ivan Vecera <ivecera@redhat.com>
---
v2:
* added extack error messages in error paths
---
 drivers/dpll/zl3073x/dpll.c | 112 ++++++++++++++++++++++++++++++++++++
 1 file changed, 112 insertions(+)

diff --git a/drivers/dpll/zl3073x/dpll.c b/drivers/dpll/zl3073x/dpll.c inde=
x 9879d85d29af0..7d8ed948b9706 100644
--- a/drivers/dpll/zl3073x/dpll.c
+++ b/drivers/dpll/zl3073x/dpll.c
@@ -100,6 +100,20 @@ zl3073x_dpll_pin_direction_get(const struct dpll_pin *=
dpll_pin, void *pin_priv,
        return 0;
 }

+static struct zl3073x_dpll_pin *
+zl3073x_dpll_pin_get_by_ref(struct zl3073x_dpll *zldpll, u8 ref_id) {
+       struct zl3073x_dpll_pin *pin;
+
+       list_for_each_entry(pin, &zldpll->pins, list) {
+               if (zl3073x_dpll_is_input_pin(pin) &&
+                   zl3073x_input_pin_ref_get(pin->id) =3D=3D ref_id)
+                       return pin;
+       }
+
+       return NULL;
+}
+
 static int
 zl3073x_dpll_input_pin_esync_get(const struct dpll_pin *dpll_pin,
                                 void *pin_priv, @@ -1137,6 +1151,26 @@ zl3=
073x_dpll_lock_status_get(const struct dpll_device *dpll, void *dpll_priv,
        return 0;
 }

+static int
+zl3073x_dpll_supported_modes_get(const struct dpll_device *dpll,
+                                void *dpll_priv, unsigned long *modes,
+                                struct netlink_ext_ack *extack) {
+       struct zl3073x_dpll *zldpll =3D dpll_priv;
+
+       /* We support switching between automatic and manual mode, except i=
n
+        * a case where the DPLL channel is configured to run in NCO mode.
+        * In this case, report only the manual mode to which the NCO is ma=
pped
+        * as the only supported one.
+        */
+       if (zldpll->refsel_mode !=3D ZL_DPLL_MODE_REFSEL_MODE_NCO)
+               __set_bit(DPLL_MODE_AUTOMATIC, modes);
+
+       __set_bit(DPLL_MODE_MANUAL, modes);
+
+       return 0;
+}
+
 static int
 zl3073x_dpll_mode_get(const struct dpll_device *dpll, void *dpll_priv,
                      enum dpll_mode *mode, struct netlink_ext_ack *extack)=
 @@ -1217,6 +1251,82 @@ zl3073x_dpll_phase_offset_avg_factor_set(const stru=
ct dpll_device *dpll,
        return 0;
 }

+static int
+zl3073x_dpll_mode_set(const struct dpll_device *dpll, void *dpll_priv,
+                     enum dpll_mode mode, struct netlink_ext_ack=20
+*extack) {
+       struct zl3073x_dpll *zldpll =3D dpll_priv;
+       u8 hw_mode, mode_refsel, ref;
+       int rc;
+
+       rc =3D zl3073x_dpll_selected_ref_get(zldpll, &ref);
+       if (rc) {
+               NL_SET_ERR_MSG_MOD(extack, "failed to get selected referenc=
e");
+               return rc;
+       }
+
+       if (mode =3D=3D DPLL_MODE_MANUAL) {
+               /* We are switching from automatic to manual mode:
+                * - if we have a valid reference selected during auto mode=
 then
+                *   we will switch to forced reference lock mode and use t=
his
+                *   reference for selection
+                * - if NO valid reference is selected, we will switch to f=
orced
+                *   holdover mode or freerun mode, depending on the curren=
t
+                *   lock status
+                */
+               if (ZL3073X_DPLL_REF_IS_VALID(ref))
+                       hw_mode =3D ZL_DPLL_MODE_REFSEL_MODE_REFLOCK;
+               else if (zldpll->lock_status =3D=3D DPLL_LOCK_STATUS_UNLOCK=
ED)
+                       hw_mode =3D ZL_DPLL_MODE_REFSEL_MODE_FREERUN;
+               else
+                       hw_mode =3D ZL_DPLL_MODE_REFSEL_MODE_HOLDOVER;
+       } else {
+               /* We are switching from manual to automatic mode:
+                * - if there is a valid reference selected then ensure tha=
t
+                *   it is selectable after switch to automatic mode
+                * - switch to automatic mode
+                */
+               struct zl3073x_dpll_pin *pin;
+
+               pin =3D zl3073x_dpll_pin_get_by_ref(zldpll, ref);
+               if (pin && !pin->selectable) {
+                       /* Restore pin priority in HW */
+                       rc =3D zl3073x_dpll_ref_prio_set(pin, pin->prio);
+                       if (rc) {
+                               NL_SET_ERR_MSG_MOD(extack,
+                                                  "failed to restore pin p=
riority");
+                               return rc;
+                       }
+
+                       pin->selectable =3D true;
+               }
+
+               hw_mode =3D ZL_DPLL_MODE_REFSEL_MODE_AUTO;
+       }
+
+       /* Build mode_refsel value */
+       mode_refsel =3D FIELD_PREP(ZL_DPLL_MODE_REFSEL_MODE, hw_mode);
+
+       if (ZL3073X_DPLL_REF_IS_VALID(ref))
+               mode_refsel |=3D FIELD_PREP(ZL_DPLL_MODE_REFSEL_REF, ref);
+
+       /* Update dpll_mode_refsel register */
+       rc =3D zl3073x_write_u8(zldpll->dev, ZL_REG_DPLL_MODE_REFSEL(zldpll=
->id),
+                             mode_refsel);
+       if (rc) {
+               NL_SET_ERR_MSG_MOD(extack,
+                                  "failed to set reference selection mode"=
);
+               return rc;
+       }
+
+       zldpll->refsel_mode =3D hw_mode;
+
+       if (ZL3073X_DPLL_REF_IS_VALID(ref))
+               zldpll->forced_ref =3D ref;
+
+       return 0;
+}
+
 static int
 zl3073x_dpll_phase_offset_monitor_get(const struct dpll_device *dpll,
                                      void *dpll_priv, @@ -1276,10 +1386,12=
 @@ static const struct dpll_pin_ops zl3073x_dpll_output_pin_ops =3D {  sta=
tic const struct dpll_device_ops zl3073x_dpll_device_ops =3D {
        .lock_status_get =3D zl3073x_dpll_lock_status_get,
        .mode_get =3D zl3073x_dpll_mode_get,
+       .mode_set =3D zl3073x_dpll_mode_set,
        .phase_offset_avg_factor_get =3D zl3073x_dpll_phase_offset_avg_fact=
or_get,
        .phase_offset_avg_factor_set =3D zl3073x_dpll_phase_offset_avg_fact=
or_set,
        .phase_offset_monitor_get =3D zl3073x_dpll_phase_offset_monitor_get=
,
        .phase_offset_monitor_set =3D zl3073x_dpll_phase_offset_monitor_set=
,
+       .supported_modes_get =3D zl3073x_dpll_supported_modes_get,
 };

 /**
--
2.52.0


