Return-Path: <netdev+bounces-208136-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 75E6FB0A18E
	for <lists+netdev@lfdr.de>; Fri, 18 Jul 2025 13:05:58 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 0DCCD1C8145B
	for <lists+netdev@lfdr.de>; Fri, 18 Jul 2025 11:05:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3F78E2BE634;
	Fri, 18 Jul 2025 11:05:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=aspeedtech.com header.i=@aspeedtech.com header.b="ZEmPttAC"
X-Original-To: netdev@vger.kernel.org
Received: from OS8PR02CU002.outbound.protection.outlook.com (mail-japanwestazon11022117.outbound.protection.outlook.com [40.107.75.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6C8CA33985;
	Fri, 18 Jul 2025 11:05:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.75.117
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752836733; cv=fail; b=BXEcOw8rh6L1nMcWX1g8t9tq8WnAWA3mdW2biw59LwB26muWZK5mYtXyJNC649wmyS54y4ouKOjwEz2JbnOqLCM0JFeg24bH9/lWPremvE4fGMguE57SmkMkbqhnZwfvgZzeAPauY7v0YVx/72uZvv4sirZ7OGwqG6eEPYuPc+o=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752836733; c=relaxed/simple;
	bh=nolBXnIQuPKkwhcygEkicZycVCbSs0/y8UbrF2n53UY=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=IWjlrVmb21VasfX5BH7arQE9evK4qSzBtiXoD8sSafjVLoYlccTYT1P27qzvD75189f3OShQVJBN7TOnwv+s+biFK0/K9NrxL/FY5nl1GObfOFlTtEu2Jphh0A5sVlVgtiK2U8nK71qTSgSCrWHGbK3z0NnLMl4c77UsP+uDmpc=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=aspeedtech.com; spf=pass smtp.mailfrom=aspeedtech.com; dkim=pass (2048-bit key) header.d=aspeedtech.com header.i=@aspeedtech.com header.b=ZEmPttAC; arc=fail smtp.client-ip=40.107.75.117
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=aspeedtech.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=aspeedtech.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=AsPUtTVsac1plDHIbEK4WshgQTidio98LgTMasDjvhQK9sANwi3JEqe292bUvfJcOpgUqFBU4IIeARN6XymS3t6cDa4UtZlCkN3QU53QnW/shf758oN1jq0Zcoj64VWIi5SlkKh/iFSbqr7adowT/Yx+L3UAXFJj6BVy8x/hU5HowHOwbLS7P4/FCwUm3a+CIjk+Mx/d+jebuc3uQmLW6T0E+tZCKwhY5lfhPn2BREaDDkeJXtpF/f9Sq2jC4p27U0pllSIigI3wDcStN3DXK00Gf9NumPPgwoD1ZL5KzTEpjJRsIgjXWBNT5s+YExa9LorzmLr1hhI0kUiaeOW88A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=umBTQoUjDR0l2BqfmGb0wAk213imEZSwMgPyN3bI2RI=;
 b=k3JDY7Mx5JqCKxZKVs/jgB5eFF7jJqrRCC0g1MunkYH2iplXM7/pEAMBfaevdZgq3S2qGhMg3iy7V9xBuaj79zMzrKH3Gw4EiJSEKxWzD86Xd2BV91ZXdvf7K2sUxgRTr7kk0t9HQy0P8FdeNUI5iKbTzGh0fBTrzvEZ/bIT4KrCm0bcAKFVHAIyPytaN2tnq0DTYzbV5v2YAO8efLFYTMV4NwEcJHxR+IyOGbIvt5ImrZoZ/EnQM8/dgFYpIYeF99OPtjz0JCrpTta/f8hAF3oP28wZWia+xe4gQBVV3wlX4KEvLsNZG3r16RZ9q8CRX46MQALpXdh33NpMTZEu9w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=aspeedtech.com; dmarc=pass action=none
 header.from=aspeedtech.com; dkim=pass header.d=aspeedtech.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=aspeedtech.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=umBTQoUjDR0l2BqfmGb0wAk213imEZSwMgPyN3bI2RI=;
 b=ZEmPttACCn/QkJQ0Kploo7hHCdcp/VtA5FjFZiIUYvMXL9Lq2/eec13/xAagt6RTB3q4EOMNVYIxpNLkJaQJEt/JppcwmRLCn5FAWDTbkiIfLpxegAXlqR9gTwBrSALcvmvWpUCaiWtQhpJjT9q5mz2kEpu7yhlDHQOnUt5CTTmn8w6z+tjYxE8mpebUs6/6PjjHEXDES0Gt8YC5yT0MaUK41F2rORNSrML3aw24xauXCv5+qaDypHVnvdir19sUCD0Wq0/1gbTLmiP3cTTCnadxs7nKZvyVH66dmL0cTLLMpJfbthWIqBFJjzqaWdDggbX/TVcieI6XRmT8aN7Zmw==
Received: from SEZPR06MB5763.apcprd06.prod.outlook.com (2603:1096:101:ab::9)
 by KL1PR06MB6961.apcprd06.prod.outlook.com (2603:1096:820:120::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8922.39; Fri, 18 Jul
 2025 11:05:23 +0000
Received: from SEZPR06MB5763.apcprd06.prod.outlook.com
 ([fe80::ba6c:3fc5:c2b5:ee71]) by SEZPR06MB5763.apcprd06.prod.outlook.com
 ([fe80::ba6c:3fc5:c2b5:ee71%4]) with mapi id 15.20.8943.024; Fri, 18 Jul 2025
 11:05:22 +0000
From: YH Chung <yh_chung@aspeedtech.com>
To: Jeremy Kerr <jk@codeconstruct.com.au>, Khang D Nguyen
	<khangng@amperemail.onmicrosoft.com>, "matt@codeconstruct.com.au"
	<matt@codeconstruct.com.au>, "andrew+netdev@lunn.ch" <andrew+netdev@lunn.ch>,
	"davem@davemloft.net" <davem@davemloft.net>, "edumazet@google.com"
	<edumazet@google.com>, "kuba@kernel.org" <kuba@kernel.org>,
	"pabeni@redhat.com" <pabeni@redhat.com>, "linux-kernel@vger.kernel.org"
	<linux-kernel@vger.kernel.org>, "netdev@vger.kernel.org"
	<netdev@vger.kernel.org>, BMC-SW <BMC-SW@aspeedtech.com>
CC: Hieu Le <lhieu@os.amperecomputing.com>
Subject: RE: [PATCH] net: mctp: Add MCTP PCIe VDM transport driver
Thread-Topic: [PATCH] net: mctp: Add MCTP PCIe VDM transport driver
Thread-Index:
 AQHb9Igk7vn3xpIukEauwkU1/K0+nrQxUL6AgAACe7CAAQ2aAIAAWoUggAMVaICAAZVdAIAABFIAgAA3uJA=
Date: Fri, 18 Jul 2025 11:05:22 +0000
Message-ID:
 <SEZPR06MB576396B0430AE23A03450ED39050A@SEZPR06MB5763.apcprd06.prod.outlook.com>
References: <20250714062544.2612693-1-yh_chung@aspeedtech.com>
	 <a01f2ed55c69fc22dac9c8e5c2e84b557346aa4d.camel@codeconstruct.com.au>
	 <SEZPR06MB57635C8B59C4B0C6053BC1C99054A@SEZPR06MB5763.apcprd06.prod.outlook.com>
	 <27c18b26e7de5e184245e610b456a497e717365d.camel@codeconstruct.com.au>
	 <SEZPR06MB5763AD0FC90DD6AF334555DA9051A@SEZPR06MB5763.apcprd06.prod.outlook.com>
	 <7e8f741b24b1426ae71171dff253921315668bf1.camel@codeconstruct.com.au>
	 <5182407d-c252-403a-bb62-ebd11b0f126a@amperemail.onmicrosoft.com>
 <59d6a0ee7f47346d8beb0283ee79a493c76dbb45.camel@codeconstruct.com.au>
In-Reply-To:
 <59d6a0ee7f47346d8beb0283ee79a493c76dbb45.camel@codeconstruct.com.au>
Accept-Language: zh-TW, en-US
Content-Language: zh-TW
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=aspeedtech.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: SEZPR06MB5763:EE_|KL1PR06MB6961:EE_
x-ms-office365-filtering-correlation-id: 95d19da6-96f9-40bb-d133-08ddc5eafdc7
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam:
 BCL:0;ARA:13230040|1800799024|7416014|366016|42112799006|376014|921020|38070700018;
x-microsoft-antispam-message-info:
 =?us-ascii?Q?ZzQMKzoF2wRqqEUrhmT0GCeSc6eZKRmyHVtgCB1H0zC5TtLit4MHaoXvTJ/X?=
 =?us-ascii?Q?fZcgiBgns96ZLnJ77DDutObH20xWmbmPINPsilBXrBWKapWD11Eoc/2rWVyM?=
 =?us-ascii?Q?ynNd1Sa2nj7uPf7QKP+Y5vIJJLMBGut0NwRr0Zw4QZ874HPr12USeP6nKv5Y?=
 =?us-ascii?Q?QwlN9A0/UUiGI/kP03b2T5nTt/yFCzs27wg1lZcSLbWfCsakKmkTEbXi1hD+?=
 =?us-ascii?Q?W6QAhR5njBLnNYkcE8IAlE+uQ+LtXUOfC53UEaVh46uBOqDNA8b6hw87QGLH?=
 =?us-ascii?Q?KdYXpyjuG3IbEfKUbMKAKRjeBk5CQEsa+EJ0fbaiZUX+kiem+WQ1BwCD0gEL?=
 =?us-ascii?Q?I9VbM3ruiS+XLvGHLYdFgGhQDZZfoD3QAQq1HZ433H0cJCstJuzJvVgMGSuu?=
 =?us-ascii?Q?w9GcDvvv3aW+Cl1mxSct7h9YObXGhtTayH2ojj8Xjhtc+8y9diN2nv3DCDEy?=
 =?us-ascii?Q?8n+hl1URnqHaq7MJi2/Sh96i2Z49Mt2IgJY0gCSDPGTPiNK31uJlXiVZsuGh?=
 =?us-ascii?Q?+ISPFZ/+qrAKFwR+Dbzicu13ZTIY85JsY+OXJggEEZenrKOZr2X9dV4z63NN?=
 =?us-ascii?Q?UPa4fAo1AczYc3FeSMXImF2z1V9LiEzyLuwDipmQlHHh6mZBFwxxzVQ7iE6J?=
 =?us-ascii?Q?e990A/h8T8dYSGTflgsKDTPIJjnhrCaE9XJtGYgWttUWwAcslr9/FoHxVdya?=
 =?us-ascii?Q?nRVDPUPzAZ+/q1CR3IwY5JhxtgkqSBvCMbuxbSOrM32Ad8IUj4qhltzDsVr1?=
 =?us-ascii?Q?hegPv8MTtH5kTX+CMdlsgEHcm6yQGfFz+BnG2abGdNJpJY/exhS0dQnN8M3x?=
 =?us-ascii?Q?rUq8Ma1xDXWC+mfAA7A9sUZbiWN8EevaO8jvFEKWLV+4ixY06nDe/1u+45Rg?=
 =?us-ascii?Q?79M2S/+QaMaqek7MkbAw/II/JNmtlisp0A4RKtTLBsSrN6iAL+FOXJFlfoaH?=
 =?us-ascii?Q?EsTairPmTN0EEpjiue7//BVR9o2Ay9g3dLVqZIGsxow/0wZasOS7+MOqLe8/?=
 =?us-ascii?Q?OEYF6v3j9bwSc5KdDdkpGr9B94Qh3gMY+KBV81fwYPdsG7W+XRjlGXxuUWBS?=
 =?us-ascii?Q?Iy22guQAIeBlWVUO8MFymyuendi3GTXBStFEp98AlYuJhrtoAe7YZU2+mUdo?=
 =?us-ascii?Q?VBUih+tUDLVQF+MugRMprB4lcENdoH25ykn3dX0C7ykeEnXMCQPxqDwJrURZ?=
 =?us-ascii?Q?g7t24tAi2FWt9J2TP/PExv735CFKw2dRwialAOSKX+MJTXCycRft/Xf0vnDS?=
 =?us-ascii?Q?qQsoiIu7K6Oof6Wqz11IQIsyuMv+B2A4zPZVNVmT3hhcQktccLF5v1U12Q+H?=
 =?us-ascii?Q?0IU8aRXzfLSPM7JQovfzC3rV7uaiPU+T6GLPV3+6Ldrydsn6nY60HOdcIG1Q?=
 =?us-ascii?Q?rP36hNjsz2ApHl/F6B2JKIVckUuv6XO2VlerFs0Jrqp9I6kKPoBypwRBXYcY?=
 =?us-ascii?Q?K2KYx6VZ+xvkwARCnBo2lK1UWzlRsG2VixHggQUKFFbyPRm6IhqPT/OM45Hu?=
 =?us-ascii?Q?f5GqgBCPQNvIRi4=3D?=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SEZPR06MB5763.apcprd06.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(7416014)(366016)(42112799006)(376014)(921020)(38070700018);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?us-ascii?Q?bGtBMsRfX0q+WAwU9hOyi1nfD3dvdLELGM2l/dPSZO0f5vI+Bjl/s6nPthSg?=
 =?us-ascii?Q?ChKRUDjUXvtkwPUeJYw/cxrZFmJPq4fBHu29U3zbSY2XO/kTnxNfkOCcFAC1?=
 =?us-ascii?Q?OL5tFsqpd3DHwcn7YwaCwN/TKAm8QPHX6VxfISvgc2afqAeMVLHNUi4VAcdA?=
 =?us-ascii?Q?M4l+B36r33sOvgElImDwYUQALo8JCEkrtCIcbmJDwuZxpTZfM5beNAEbg60W?=
 =?us-ascii?Q?Wh4UNA2PW+Sf17GmHt6gc/FIer/ziZ75vmVtLLPxjIhMjY+bX8lBkrUQcWv1?=
 =?us-ascii?Q?/3GFzWb7eRQUg9BEku76S2tlTvktRHNK2+zIrMcPL3eNl8xtyvhjJunnzm6n?=
 =?us-ascii?Q?PJ1M/k4wwLpGnvSKcQ7nkaWwKLKrfb3fwxDiYzcvJvxuGBBjBmPLw42ixgTD?=
 =?us-ascii?Q?7pKGd6TRDjhkyUjjSjFV+3oAijKpaWx0DrRlrDYMbd41kNfPHJy1flhOeGLY?=
 =?us-ascii?Q?ET5K8meckcmzfdKGsXXlYL2D1MjehzQtRvBg1h9lVFeZSj3OBlPk9+AEmiLO?=
 =?us-ascii?Q?PMlM5M/zL8iKCnn0FBtxWoEln22DyLKJaH9pKfbDNGVRUEPGAvaBg7Oc3KlA?=
 =?us-ascii?Q?UjlqLUrfOOmM/F6JRJpjMZBqkz6mYc4cpkr48TaEn+6cRPlPQ72liD1CwkGI?=
 =?us-ascii?Q?tXdkr6w+sO8VVSIQXWZxjP8/XmgUNAYIqZpGuwubfer6G42rWHaY1je/VdAZ?=
 =?us-ascii?Q?2Tx1lr+mcXwUfzWNStm8v+MYVR84T5GplMROmLT8Jfbo5IbNZvZs1yaiJO25?=
 =?us-ascii?Q?qlGHQZjY1XbFdztxkZZjuKFUt0mH+3KLy6dUYZSwdnSiNZhJO/x0zB+7tfyP?=
 =?us-ascii?Q?pQSLAh25jyjzBDcXp22cJ024gomJQFqo2AAqlm9YltxUVtJbVqlN2AYN0AaT?=
 =?us-ascii?Q?1ltnB5saGUzBC/MY86PCGSatzvNbfmi2S2ck2lPl2H8TrMKAANMYDkyCkdJ6?=
 =?us-ascii?Q?jfABZu2HPe885g7KoVMlyEmDEZrvI7HtqdgNugdvxetCwsgJxgXpy9WgPaCk?=
 =?us-ascii?Q?yG9qV+fxxkBVG2NQWZZ+wDn/lnbIpiQTiTAczVk8dDxmQnmBKdnIxd5+YOam?=
 =?us-ascii?Q?ctMMEWZyklk6nB+Qb9JlK8kL18RMdzBT1jnVprruBwj+kZYLxyf3iKNQiKFh?=
 =?us-ascii?Q?tJiDo+sldzxp5MZWUXn2+hMVGe1M+7TG80FGbsSDu6xJXdrIIvmzA2H3Ca96?=
 =?us-ascii?Q?zz5qjUKJX1PkgCdEVJ8VPrGW5oTVjHpUac2ScawT2dTg/6T5OYKEiPgTFLl2?=
 =?us-ascii?Q?QiJ5U1HP4KPjWUGa/5J/t+jMe0fElQvms2Wsf4Q0skgysRnmXS8jjLrRzfLH?=
 =?us-ascii?Q?wXVrIlM64mv4vyAR+8v1SEJnPfgSltNskeEgo49LQWzOLgqfgZk3D7acVQJu?=
 =?us-ascii?Q?jao97B2aP3olVqP3dhaGyweNRQcoJO8uhdkqKKmg8imOaaGN1zIZG2nEUWOc?=
 =?us-ascii?Q?SjU/2/y4LOnkfLdBab/vt2GTfekz9IlmYjR6KNBzaKKTEVa3w5oDWF+mJIeU?=
 =?us-ascii?Q?cEJX77CjQwwS/mLtNIYYZUxQxTqs1kn0lNqkitgzAQc609TGCITvKTQvrNhr?=
 =?us-ascii?Q?eg6MOnW77YA+pHV453uA7/HNACS3FaWWk7AFnLRK?=
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
X-MS-Exchange-CrossTenant-AuthSource: SEZPR06MB5763.apcprd06.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 95d19da6-96f9-40bb-d133-08ddc5eafdc7
X-MS-Exchange-CrossTenant-originalarrivaltime: 18 Jul 2025 11:05:22.6703
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 43d4aa98-e35b-4575-8939-080e90d5a249
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: +QYM20pQ6CfcBkOeXdokuSJ9KGIB5/AamMXeyJvdxl0q7KQD1yz8OgBvf/6LUHMi2jVn7PrEyGmIWY7qy4GIOQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: KL1PR06MB6961

Hi Jeremy,

>Just put them in the top-level at drivers/net/mctp/ for now. There's not m=
uch in
>there at present, so will be simple to keep organised. If you end up with =
two
>drivers and a common set of utils between the two, that's a total of four =
files,
>which I think we can manage.

Understood, thanks for the guidance!
We plan to start with the AST2700 driver in the next submission, along with=
 the shared utility code.

>YH: so we would just have the three-byte format for your proposed
>driver:
>
>   [0]: routing type (bits 0:2, others reserved)
>   [1]: bus
>   [2]: device / function
>
>- assuming you're only handling non-flit mode for now.
>
Sounds good-We'll apply this format in the next patch.


Hi Adam,

> Would the mailbox abstraction work for this?  It is what I am using in th=
e MCTP over PCC code.  Perhaps a PCIe VDM mailbox implementation will have =
a wider use  than just MCTP.
>
Thanks a lot for the suggestion! For now, we're planning to remove the curr=
ent abstraction and use a set of common utility functions shared between th=
e AST2600 and AST2700 drivers.
As Jeremy mentioned, we'd prefer to hold off on introducing a PCIe VDM abst=
raction layer until there are more concrete use cases that would benefit fr=
om it.

>My suggestiong  is: Keep it simple.  There are only a handful of mctp devi=
ce
>drivers thus far, and there seems to be little justification for a deeper =
hierarchy.
>
>Just focus on the cleanest implementation.  Having two drivers plus a sing=
le
>common source code for each in drivers/net/mctp seems to be easier to
>manage for now.

Appreciate the guidance!
We'll proceed as you and Jeremy suggested and keep everything under drivers=
/net/mctp for now.

