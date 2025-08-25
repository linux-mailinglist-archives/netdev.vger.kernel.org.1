Return-Path: <netdev+bounces-216472-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A4DD9B33F95
	for <lists+netdev@lfdr.de>; Mon, 25 Aug 2025 14:35:23 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 68E112057D8
	for <lists+netdev@lfdr.de>; Mon, 25 Aug 2025 12:35:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9DAD778F58;
	Mon, 25 Aug 2025 12:34:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b="nAQktCiu"
X-Original-To: netdev@vger.kernel.org
Received: from DB3PR0202CU003.outbound.protection.outlook.com (mail-northeuropeazon11010051.outbound.protection.outlook.com [52.101.84.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1C386288D6;
	Mon, 25 Aug 2025 12:34:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.84.51
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756125257; cv=fail; b=an3eyZJ+1ljamnUF6+Oj9obgwoVnAmZ/nx5m6siQBXJQlyZljMKLLUiNL1oaT/xPCml0Qu2NF78mKDRvjPVKeV4+xwkIg0VOAF6Q+3AQuVFDzal3PY5qA2eeJ85qHwlqX2u+ChFDNHxv2EDYkL7UOt4U6NYEeYB1XPsQUbFchlU=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756125257; c=relaxed/simple;
	bh=qb0obiDGSQqChEKiZOs8T+InjcYdvI+rlC/kwvYYJig=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=LcyVMjIr8lEk8dx//I6Frz1BRQGLVN0YOmX7LnCCkDB5ebjobze0hGxsZsYf4+nbTiquWYTIOUQ1vkDhQjGHPGM7NdXMAHL7QuL1RqsNLRSDIj+lOUI1X4hteWG/VnL9/v0nAZHfGQsTKxt7DUqZIVLGb0sFMGBwIgyIGgnpyfo=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b=nAQktCiu; arc=fail smtp.client-ip=52.101.84.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=eTqAXicAwaJW2yQQsMzlBulhkY4aeZii0VV/DFZ8h2SdIREoCXJdEPvdmFKF8lcLWmp5ILMAFN9jI0wOGI4738HGo2PlqZZ4+UumnLzHEeCM7hEf4H18xekI31t0pa4/GqeybUhgVt1yhIc4lB0xGKiPT9vfW4yTz8zfLE2WFozwR84aRoOTquTo4RqgVvTKeZl6vCJYjXlF60gjfVClOG4Fi2MrwqFFcomtFS6M+S52xWThlH4S5uRixrQAbI/tJ8PAA7Nl6pWuT7RYpXP3nzsSYfxDOubE4CUIDWVgRuKaWlfIkQ2mgIWaqzfEV6DLfoQnURfjYrSHOGhgz4HeaQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=dBuo509ju51WcjnvBGrRVyWFyEk9OuH6VbgHGe1zR0E=;
 b=eMTKGO5p+NlCcSjgMymYzoIYeUlVDy5u0xz+3wLVCS3KF2XRW+umY/LsL+3NyrLXq0ccI5Ay3RGQPX/6fCKDYh+izYpkhYbW8N71crDBTtOAcTSfJTrPXy5gNzbNwxrZ32lES7Xdxz0G4Mpwgtk6bmICbCnGpQPVQfRmjxjCBYKTRnDtk4zDXA7kxKRzhnvuTyD3pg483m0+otbNhJlhnrb8SJGPpRHTqkgh3UVLmfhXLQ/EvMgv1i/4v0dhWRKYa7JR51IAfecQUOZGaX32k4OHRM5cPflomg1jwEycc8v6TlOjbC1IFfG5/j8h5GW8LqBIcewzX0U8sYfHZBiQIg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=dBuo509ju51WcjnvBGrRVyWFyEk9OuH6VbgHGe1zR0E=;
 b=nAQktCiuDlV0SS5ymTifnI4VrqGnH229PJvI3Or9TC42xWXbHg7dC1PFvzkqIXF9zw9qvPTue91CewAOA9cV3nNClZSFJWJer1BjO2oRFwnTCrJvzqPZk72WxtWi9hlQQbmqvQa4ZB6lhDGNQTEb+pIIVU4ppYtbKAaGMzmG/o2t3iIq6thiTe4TLaUC9+H2INY+7YcBNJvjvpJVjg6Kia18bv1C1s7BWNQN6yw7V7HrpuakNmE6gyRqbGtzMtm7cjWbp5usYgKLUwoSux+BQPZRn8rWX4344Db/0Y6yo5yAD2CeKFaSlAk77+BFHG35eEWwj8F4O+p1ujG/2IpQuQ==
Received: from PAXPR04MB9185.eurprd04.prod.outlook.com (2603:10a6:102:231::11)
 by AS8PR04MB9207.eurprd04.prod.outlook.com (2603:10a6:20b:44e::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9073.11; Mon, 25 Aug
 2025 12:34:11 +0000
Received: from PAXPR04MB9185.eurprd04.prod.outlook.com
 ([fe80::21bf:975e:f24d:1612]) by PAXPR04MB9185.eurprd04.prod.outlook.com
 ([fe80::21bf:975e:f24d:1612%7]) with mapi id 15.20.9073.010; Mon, 25 Aug 2025
 12:34:10 +0000
From: Shenwei Wang <shenwei.wang@nxp.com>
To: Wei Fang <wei.fang@nxp.com>
CC: Clark Wang <xiaoning.wang@nxp.com>, Stanislav Fomichev <sdf@fomichev.me>,
	"imx@lists.linux.dev" <imx@lists.linux.dev>, "netdev@vger.kernel.org"
	<netdev@vger.kernel.org>, "linux-kernel@vger.kernel.org"
	<linux-kernel@vger.kernel.org>, dl-linux-imx <linux-imx@nxp.com>, Andrew Lunn
	<andrew+netdev@lunn.ch>, "David S. Miller" <davem@davemloft.net>, Eric
 Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>, Paolo Abeni
	<pabeni@redhat.com>, Alexei Starovoitov <ast@kernel.org>, Daniel Borkmann
	<daniel@iogearbox.net>, Jesper Dangaard Brouer <hawk@kernel.org>, John
 Fastabend <john.fastabend@gmail.com>
Subject: RE: [PATCH v2 net-next 4/5] net: fec: add change_mtu to support
 dynamic buffer allocation
Thread-Topic: [PATCH v2 net-next 4/5] net: fec: add change_mtu to support
 dynamic buffer allocation
Thread-Index: AQHcEso09J4T5pZDZES+itLWSHrcIrRubkkAgAIk3cCAAhLWgIAArQDA
Date: Mon, 25 Aug 2025 12:34:10 +0000
Message-ID:
 <PAXPR04MB9185A682B7B3D37E157F4184893EA@PAXPR04MB9185.eurprd04.prod.outlook.com>
References: <20250821183336.1063783-1-shenwei.wang@nxp.com>
 <20250821183336.1063783-5-shenwei.wang@nxp.com>
 <PAXPR04MB85102101663ACE21F6D75562883DA@PAXPR04MB8510.eurprd04.prod.outlook.com>
 <PAXPR04MB91850A2E4ED6ED29D45BF27C893CA@PAXPR04MB9185.eurprd04.prod.outlook.com>
 <PAXPR04MB85107C52F0CB3A45943FBEF5883EA@PAXPR04MB8510.eurprd04.prod.outlook.com>
In-Reply-To:
 <PAXPR04MB85107C52F0CB3A45943FBEF5883EA@PAXPR04MB8510.eurprd04.prod.outlook.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: PAXPR04MB9185:EE_|AS8PR04MB9207:EE_
x-ms-office365-filtering-correlation-id: 5133b4d3-5bc1-4371-bacf-08dde3d3b12c
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam:
 BCL:0;ARA:13230040|376014|19092799006|7416014|1800799024|366016|38070700018;
x-microsoft-antispam-message-info:
 =?us-ascii?Q?U/femg8ShHt2ZVyb3rcSXwmel0T1d+w5D/TVQksf7NJ2N/CbRcUyof6tm2Zw?=
 =?us-ascii?Q?ZTOZ/ke1e7ExdWEQXLynNePTJGbrNfkkO1wsoHTxByN4RxC1fCwT9UyPp2XQ?=
 =?us-ascii?Q?33Y6wCidYtdsT2b2BUSXsCeSziWMpLLx1pokH7H+IS/U2R0pYssr2v9NJO/Z?=
 =?us-ascii?Q?ehjb7I6Enox5bOLBeW2E70w6PLtLUBzEoNmN1BRYNLwF6o5xtA+2uyibZGFO?=
 =?us-ascii?Q?FcK8kgGDuDBKhEjmWkxyGs/PnS1icx3i3pF5AsmCeUUFTi+wA0mVzrGhONNL?=
 =?us-ascii?Q?fi3m19er5Fssh4YvuLXJmmaCyhaF+v5bhwtd5Hq5iHB1wu7XjzUqSPM5lbUu?=
 =?us-ascii?Q?nsxmKDL1cqyMLsRoX+UmIXY1cqCw2GWRDJIBpdNQL0BsIJp+unHylxGQIW++?=
 =?us-ascii?Q?CQ+AbmgAVnA5NcF1KOwPWTLSoC+mEm5q6koZ5ZEUBZ7aKsMcCSEH4sBPbtVI?=
 =?us-ascii?Q?jmI4TPxXNXz5qW3IMNchMhNB2tiOkqvND/cowMidbYBB2JuQp+HQfqq6Lajw?=
 =?us-ascii?Q?kwVfA0dQKEfbXL7M45Vh3vLTgdYdGmecqfCDqS9zr2NTAZhHG3iLHHzExfTa?=
 =?us-ascii?Q?sDg7amxd2uwqQ988NCGa96O1HKjzYy9u1ai9GzT3Vb2ImKAQg9eDlANziiYZ?=
 =?us-ascii?Q?76g1qQ/zi2iA3lJQNfGLoI56NhvXBeNr3mfOVgM0g2Y/EiNHpyjnEHfp3JD4?=
 =?us-ascii?Q?XgMaqP8qZTYE6NoVSKzW8OcHUURxqmeKRlbf+5bK5Tb/EaOeevH2XlYdkCOn?=
 =?us-ascii?Q?PgPi4LPOBV6vRcTqDgfIXL2keQkJJH+KbFVX0GUpZIc1gQdLQe4wXW4tJJ6U?=
 =?us-ascii?Q?GRT0Db66jcG+O58N/IUmFn6gelZw03MgwCPA3crlqFXqasjatw27Z/NGkXq9?=
 =?us-ascii?Q?+OuMy4jiq45BliS8U/bx/xLXwYaG+9L+E9j5PYxfkIrUJuC7J2rKRylaVJaG?=
 =?us-ascii?Q?YFz42Zv9reb7Lg5oCYVOOwMZzo2/Vlby2gDqBy3HKu+aGDu3BRotbBWSTYOU?=
 =?us-ascii?Q?xyc56Q6s1364CxC+QpX2Heas7wIBh5S531aqdbm+QS9QZHWrFxBiAdOCUPSA?=
 =?us-ascii?Q?nWoUeMFBm8o4V935jGhgtHdI5I+qd5nUC8BIByBJjRRsqz5MGxd0wK/tkHTm?=
 =?us-ascii?Q?MaJBgHWu/uBhEhfMvQkjMxKJE9+JIwRlJ1Z41hupvV9tmqmfH1bfdhnvTqeh?=
 =?us-ascii?Q?NgRm1wQIRHj6Y4BATKZX+xKnafnt/AMMa9urJclPgfDNsFDH36O6lX1OxDu8?=
 =?us-ascii?Q?XdZyjiehyVUStb623Uqy60Utn++VPwyP6NRr9JGGmaQne+eI4NO4SMXbpYIc?=
 =?us-ascii?Q?k+UkMrcd1q4e5OEkFT8+OwSn/9/+mstKNlAB4Fz7FurSsalK1N3bU2rLIyaV?=
 =?us-ascii?Q?qMa1gMhf9xu1XuSOjEJDudJLaWgs1wvQgyRUpHz2GVnUghfRw04cCtRyRISR?=
 =?us-ascii?Q?Il4vCzW6OgebY9VqgzYva4mj0zNZyWZd+OTyPGUaYwEzVEG9yNJz6Q=3D=3D?=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PAXPR04MB9185.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(19092799006)(7416014)(1800799024)(366016)(38070700018);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?us-ascii?Q?ZwlrnDhlKxt2IUFDv9djR074PfX9irMBArWAGfsGyGv4VKa4brNKsDK0euWW?=
 =?us-ascii?Q?7jBF74F8p/+KkXeHuTgxtMIacvldOss6q+I0SGr15YghtiOB7gGUvTaVwUcu?=
 =?us-ascii?Q?+JqcTPgEVflPWGtfWvsYpUoQsfVzgz2m2GmBXgNxXGjxZIdCIiMJQAClEd6w?=
 =?us-ascii?Q?5sfLt6nln0UbpZHz2HYwZCNSwkWVVz8C8xSXXmXHiP5blpzc7NYPhNtlqTaS?=
 =?us-ascii?Q?D54mnJ0RzqrSUiF+Jq28sehBV8Jh8uCkO6w1ptH42tSaAoPELbPhPXK6LOhJ?=
 =?us-ascii?Q?wuQIVBrf5hO8hYxQxPe0FPuN8hU2XT2JgglOzqhcka1XjWPg4u6MyK9A/P2s?=
 =?us-ascii?Q?LsMaaJvxhipIlA3Wl2FeL/Bl+PhXGphFQkZDwskcxyTUSryxhOFtlYgNkkfM?=
 =?us-ascii?Q?K5VpH+vez72AS6KKbGZdOWkT07eohtQrqGHmQwwELTkYykf8c8DupulaEuNE?=
 =?us-ascii?Q?ylQMZxdg7ZeLlKpzxLuzhzf7CvHvONnBY1zAEUkMd9KR2mjXHn09u49zkr+t?=
 =?us-ascii?Q?62imrOct5U6qBpTRy7VjvOHEQyQIiBVl/Bydc32R5r6a/ge7JdyRppd+yeEL?=
 =?us-ascii?Q?zrGsSruKmdjV3pl99u59fNEfIn9rHIASF/dQFBistCpBpxc25Wjpgbneovzr?=
 =?us-ascii?Q?SUTVJgTb9RBxLbbfNJZUc0hDy1cviWqpvbBlMO5YCHlkPEHs4OF3yYVzk0BR?=
 =?us-ascii?Q?B4HqmAAAZOcOmuyAEsBLO/wtNFk3EdYBZ6LoXMf4sRw6bpqHeQdv76lozYAe?=
 =?us-ascii?Q?OJc6bSxU5bfn0ASkO0L2jK6jGxZoFj8AjdNXRjOrjiXgsnIIqClaljbMmCjK?=
 =?us-ascii?Q?chjLS4EQSF0LrvWXDWOrak/5zdji3UAgKgPtLKxUH7UXK8SZgtDvY7Z+G3zu?=
 =?us-ascii?Q?uNARq0qCtZSV1eEMANEd+yR6qimrVSmztBsGHjzOECj0xrYLNPOEKk4AV8Pz?=
 =?us-ascii?Q?yzImuNRj5KpXko/G+X4lYpQSJ/LU6OHQpp1HCqZ6LUiZfUNtWEnHYsR/9DqN?=
 =?us-ascii?Q?IyRlOUbz9s4lhZmk6+ZYTlNCOiUW+gAxsCg0/NyZvOlm39Iwq2CIVCDKlcw8?=
 =?us-ascii?Q?LF/Q8s+dHK2KOVU/7u5v9K08fhhH2asevKWk8Ye0d3/xb8tlK/hDdNhwbOYI?=
 =?us-ascii?Q?R7p5AwcLIkNqSGYCyC8WM7yQm61CfgvbFMebEQUnsfJ1oTShdIGpurtUlyzY?=
 =?us-ascii?Q?fId6FmRShoAvzI5lONqnFMPsPsX57XvTEil1USjzPsRvYlBBkGLVgxtGbaWq?=
 =?us-ascii?Q?oGfGQxCD7LpzNclEekzvT3roydn8nRKndTFJpd1fIVePvglZxSOOfLlCqSWo?=
 =?us-ascii?Q?dFl15Wk0dShHw7gTF8xkODjnNGqh3AvRTJIIBrnxd0npdjsIBFUvJ/1Ynj4P?=
 =?us-ascii?Q?AXQYP0M7RKL4CpuF+vO/Ma++Gr1SoKVrdSlxmOgMfNgMDjzqVRJYVnEdJCeb?=
 =?us-ascii?Q?LDB8PijEyvr1LlAJL7gLjyd3PuWV41b2noTMk4DPmsHmkohzY9RuZ8vzKBFX?=
 =?us-ascii?Q?F6mHz66L6cPt5b4DdyDaRIdtRRsTdyxLYgfVbixDJIe/eFkoxhh4d9M6zkoU?=
 =?us-ascii?Q?cgA80HH2E+bYqm3P0Xk=3D?=
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
X-MS-Exchange-CrossTenant-AuthSource: PAXPR04MB9185.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 5133b4d3-5bc1-4371-bacf-08dde3d3b12c
X-MS-Exchange-CrossTenant-originalarrivaltime: 25 Aug 2025 12:34:10.6147
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: TUXLKm1/WJMdL3Di+wvHtWPObFsq0PM4eAy9aFZSzJOnjt9MQn9jjviWkG0p3lBzJvdu8itnbdmQ3fHinwtNFA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AS8PR04MB9207



> -----Original Message-----
> From: Wei Fang <wei.fang@nxp.com>
> Sent: Sunday, August 24, 2025 9:13 PM
> To: Shenwei Wang <shenwei.wang@nxp.com>
> Cc: Clark Wang <xiaoning.wang@nxp.com>; Stanislav Fomichev
> <sdf@fomichev.me>; imx@lists.linux.dev; netdev@vger.kernel.org; linux-
> kernel@vger.kernel.org; dl-linux-imx <linux-imx@nxp.com>; Andrew Lunn
> <andrew+netdev@lunn.ch>; David S. Miller <davem@davemloft.net>; Eric
> Dumazet <edumazet@google.com>; Jakub Kicinski <kuba@kernel.org>; Paolo
> Abeni <pabeni@redhat.com>; Alexei Starovoitov <ast@kernel.org>; Daniel
> Borkmann <daniel@iogearbox.net>; Jesper Dangaard Brouer
> <hawk@kernel.org>; John Fastabend <john.fastabend@gmail.com>
> Subject: RE: [PATCH v2 net-next 4/5] net: fec: add change_mtu to support
> dynamic buffer allocation
>=20
> > > > +static int fec_change_mtu(struct net_device *ndev, int new_mtu) {
> > > > +	struct fec_enet_private *fep =3D netdev_priv(ndev);
> > > > +	int order, done;
> > > > +	bool running;
> > > > +
> > > > +	order =3D get_order(new_mtu + ETH_HLEN + ETH_FCS_LEN);
> > > > +	if (fep->pagepool_order =3D=3D order) {
> > > > +		WRITE_ONCE(ndev->mtu, new_mtu);
> > > > +		return 0;
> > > > +	}
> > > > +
> > > > +	fep->pagepool_order =3D order;
> > > > +	fep->rx_frame_size =3D (PAGE_SIZE << order) -
> > > FEC_ENET_XDP_HEADROOM
> > > > +			     - SKB_DATA_ALIGN(sizeof(struct skb_shared_info));
> > > > +
> > >
> > > I think we need to add a check for rx_frame_size, as
> > > FEC_R_CNTRL[MAX_FL]
> > and
> > > FEC_FTRL[TRUNC_FL] only have 14 bits.
> >
> > That would be redundant, since rx_frame_size cannot exceed
> > max_buf_size which value would either be PKT_MAXBUF_SIZE or
> > MAX_JUMBO_BUF_SIZE.
> >
>=20
> Looked at the entire patch set, the rx_frame_size is set to FEC_FTRL[TRUN=
C_FL]
> and FEC_R_CNTRL[MAX_FL], and both TRUNC_FL and MAX_FL are 14 bits, if the
> value set exceeds the hardware capability, the driver should return an er=
ror.
>=20
> For example, the order is 3, so rx_frame_size is 0x7dc0, but MAX_FL will =
be set to
> 0x3dc0, that is not correct.

How can you get the order of 3? If the PAGE_SIZE is 4k, the order is no gre=
ater than 2.

Regards,
Shenwei




