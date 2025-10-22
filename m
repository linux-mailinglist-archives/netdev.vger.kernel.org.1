Return-Path: <netdev+bounces-231494-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id DF9E6BF9A1D
	for <lists+netdev@lfdr.de>; Wed, 22 Oct 2025 03:44:49 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 6D36A19C5CE0
	for <lists+netdev@lfdr.de>; Wed, 22 Oct 2025 01:45:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C24281FA15E;
	Wed, 22 Oct 2025 01:44:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b="FAo5P8m6"
X-Original-To: netdev@vger.kernel.org
Received: from DB3PR0202CU003.outbound.protection.outlook.com (mail-northeuropeazon11010015.outbound.protection.outlook.com [52.101.84.15])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E2C3A1E5213;
	Wed, 22 Oct 2025 01:44:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.84.15
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761097485; cv=fail; b=LrWOY0s0XIg7LVP58wnlcavm4SQaj3EXDxOZc5ufnpeSVrjub4g8UngM+1DlLXwd+Q17EO6OMvM0KWdjQ5Dxzushyiw/qTuzPwiR6nw66Tovt6JD+gHjWnJbspDzthNk1TpN9SAbmOOP/yv9BrMLlfLfHNgHUgXk+AYoXZvB2oY=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761097485; c=relaxed/simple;
	bh=TkM5IWS7JzFPIy7iIY4gNtPhapc+hQ6Y1k3wS1WsIk4=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=B6omYgclYINHk8KE1QSMjZ/532BreBKX2kOmfuh5eyc+XO8hDs3G24+bfrrxgC2eoq/R+mojcg/vzQ6YbYUjWejjqGuGDH0gne3yWOsLdXRhs4BsMI4mgGaKcVhOAQK2SkXpkrvYnM1vWzj5q+axMskQXoqkpX7zSKSoPE9XZec=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b=FAo5P8m6; arc=fail smtp.client-ip=52.101.84.15
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=CQ0NrhDIl7tgE1BsIvQE9hPMJllcVwY1dH5lbL+mYmjzT2IFCHQfy2zfJ7I196pKgzd2ntEiJZANGvpSPUeORIXv3fnK4Il0vX1ZvvZzmJSCx5CpNxUG2ygPqHqjFC6m5rW31S/sqNvvo4UiG+7e4IW028PFT5WfxaG3oXtwpF2SBLim0w1lAsGBo6hf9k0uPwa9Jrqr+qd9Vl7ldoGAJaiok2MCqv0HA6H6+MYOlVDSIM5+or8Y8ARc4lxEeM8i3rcCmPABOp20LGCrIWUN3SIs+RFac8O10vxzBIsVwFgdi6vL4hav8p/3pLq9iuthTLxZSITy8lQ8C+FedSCs3Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=TkM5IWS7JzFPIy7iIY4gNtPhapc+hQ6Y1k3wS1WsIk4=;
 b=xBUhkBGLNuo0RKZBG0ER4a0Trj1S7Hlhe5c5actn9JktOo98aLcMgkjiAJK6+GXJ96svjjQADTzvcSNmr0PArYYnmshh4grcXwcqy6T0W+IYq6Ko5Or5FkFZC4GsytxDxWTbBjPkLDR29Y8dZ1Z3QeZYgmF+OEWEOvwMbUAqUrazxvtFq3zTApiGCtIgvldJsNEWm+pmxy80AZ7NTfSDCWewQM/IgvYhvSdebFX1GWxgQ5dMEkX90S5h8NpGz9ezC1NSntPxV6VkYFrNMVd4I1ZMVMzbHBd8jueDK6Yjk8PAa96XfaKo9diLZ6vIiD7jlk2W7sQMJHsNAncbElybYA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=TkM5IWS7JzFPIy7iIY4gNtPhapc+hQ6Y1k3wS1WsIk4=;
 b=FAo5P8m65L7Abc5IMW9abDHen1JcYzEvGovicFTczytXLc4AqCDOHQi8EOGQHyY1OJWvWvnUdK1O3D5JrIFosWVC2B4mBRSj8XQ2LqVAOwtfN1BY5fsQ12XLlJQgojCH+uZ2hS7Tx+TkjRwqINc7i01uZgya2iYZYWhGVIeDzOqAgQCzXqWd8U1CWJ33o/Oa6bzPQeSn1BGXSPEwrQ8eUwnXjzsoroJKBNRf60XMNwGIZ5HkZb0TeH8X/Uk8JFMwgRCZfzwOszcUqFkY6PVWDbxxBp2uc4CqpWCeA05hFzftXpyP4+tkrgaHiG9EhBlrQ0pjbEw2d3O8hskJE7333Q==
Received: from PAXPR04MB8510.eurprd04.prod.outlook.com (2603:10a6:102:211::7)
 by DU2PR04MB8646.eurprd04.prod.outlook.com (2603:10a6:10:2dd::6) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9253.12; Wed, 22 Oct
 2025 01:44:39 +0000
Received: from PAXPR04MB8510.eurprd04.prod.outlook.com
 ([fe80::a7c2:e2fa:8e04:40db]) by PAXPR04MB8510.eurprd04.prod.outlook.com
 ([fe80::a7c2:e2fa:8e04:40db%4]) with mapi id 15.20.9253.011; Wed, 22 Oct 2025
 01:44:39 +0000
From: Wei Fang <wei.fang@nxp.com>
To: Paolo Abeni <pabeni@redhat.com>
CC: "imx@lists.linux.dev" <imx@lists.linux.dev>, "netdev@vger.kernel.org"
	<netdev@vger.kernel.org>, "linux-kernel@vger.kernel.org"
	<linux-kernel@vger.kernel.org>, "devicetree@vger.kernel.org"
	<devicetree@vger.kernel.org>, "robh@kernel.org" <robh@kernel.org>,
	"krzk+dt@kernel.org" <krzk+dt@kernel.org>, "conor+dt@kernel.org"
	<conor+dt@kernel.org>, Claudiu Manoil <claudiu.manoil@nxp.com>, Vladimir
 Oltean <vladimir.oltean@nxp.com>, Clark Wang <xiaoning.wang@nxp.com>, Frank
 Li <frank.li@nxp.com>, "andrew+netdev@lunn.ch" <andrew+netdev@lunn.ch>,
	"davem@davemloft.net" <davem@davemloft.net>, "edumazet@google.com"
	<edumazet@google.com>, "kuba@kernel.org" <kuba@kernel.org>,
	"richardcochran@gmail.com" <richardcochran@gmail.com>
Subject: RE: [PATCH net-next 6/8] net: enetc: add basic support for the ENETC
 with pseudo MAC for i.MX94
Thread-Topic: [PATCH net-next 6/8] net: enetc: add basic support for the ENETC
 with pseudo MAC for i.MX94
Thread-Index: AQHcPomx5rXumqsTlUupdMb7PmTNILTMOwsAgAEv5XA=
Date: Wed, 22 Oct 2025 01:44:38 +0000
Message-ID:
 <PAXPR04MB851033505FB2A4673A15EBD488F3A@PAXPR04MB8510.eurprd04.prod.outlook.com>
References: <20251016102020.3218579-1-wei.fang@nxp.com>
 <20251016102020.3218579-7-wei.fang@nxp.com>
 <11ffb7d0-4e52-496e-84c7-0d93bf03e4cf@redhat.com>
In-Reply-To: <11ffb7d0-4e52-496e-84c7-0d93bf03e4cf@redhat.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: PAXPR04MB8510:EE_|DU2PR04MB8646:EE_
x-ms-office365-filtering-correlation-id: 5a167fbf-06fa-414d-0f64-08de110c9044
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam:
 BCL:0;ARA:13230040|366016|1800799024|7416014|376014|19092799006|38070700021;
x-microsoft-antispam-message-info:
 =?utf-8?B?VHhGVzZlYzJ3YXA3dXB0WnNSVHVuU2R0N0c0OU1jWER2RHYvSHE5ZVhQd2ty?=
 =?utf-8?B?NGhWbWRPQlUyQmFUeitOWXB1TkRNNC94bHJsNWZXaEZtUERqcldrWHlXU3Mx?=
 =?utf-8?B?ZlBESkR2OGdLY0ZWcjZwNG5NdkdhNzdTVUYxVkx3UElvZ2huNzc2NVFmakU3?=
 =?utf-8?B?TSsySVhJZ28rdFRmdGJwWHRTbkhnWTRWNnhyK3UyYm9tUVlBZjBqVjFxRTFs?=
 =?utf-8?B?YlgvL2JXNDIwQnYrTDJ1RWNsM1R0ODBWTEhnT0FwbCttdnlNdXo3QXBmMDMw?=
 =?utf-8?B?NEpPZFk0NlE4Mzc4eVp1WG5GVzlqVGFkUWIzUmNRYlFQTVNxUnRoQVBnVVdL?=
 =?utf-8?B?UnlIOE9TWHpzdUxldWJtdnVyYkFBNkIvZkhSWXR2eXFXZ3lpL1ZRVDdMZjA2?=
 =?utf-8?B?SldHZVEvZXVLcDNGYmFhVm5XMVY0N0d2dHBFRHlZNDlGaXltamp3cmNYVU5q?=
 =?utf-8?B?TlcyblN5cFY2b2Z3akpIbkdWT0xucVZib09UVHB5SVBvajZuMkh5ZEVnNVUw?=
 =?utf-8?B?WFY1UkIzUmgrYW5zYjVMcXFTS2pCTzhkWnRkWURtNGNOWHl0RnJ0ME05QkVk?=
 =?utf-8?B?Y2I4Q3BvdjY3WVNtUWhCeCtmbk1VaWRJNVhIK0xtZFBpVVphem5nTkpFMVR2?=
 =?utf-8?B?WDRobElZdklxQTgySjRPUlU4QS9UTU5xanA3dkR6WmZvbUt6RWZoaHZmaHpN?=
 =?utf-8?B?TE5BTng2UXB3ZDJDeTY5ZXYya3FjQTNyTG94dUtJNElPdEVqUTJQUG1HSHVB?=
 =?utf-8?B?MmNtTThoaXdDL1RXYm40b28zQ2pjL2ZTOFJ0djNRUUFaWnVrMnVONXRSVTNQ?=
 =?utf-8?B?dXkrMkcwcXBaZmo4bFBpVVJ5d0lqRWlFQVlod0Q4SEhUeU1mNStBVlE3c1Zv?=
 =?utf-8?B?ZGVpalc1WWczUFJkcHVQY1lMVlQwS0pncUNmdStDU0hMb3BkMkR5dmRZMkI3?=
 =?utf-8?B?Y1poM3R0L2s3WUl3V1Zma0FGcEIwVi82SGFvbU5JZ0RjS2FrNnBIZUk4dXp5?=
 =?utf-8?B?cmhUNkw4Wk9jMGNjb0VVREttUEkxaXEwU1hJbDdzejBFZjZpVWdWVGRFZnd2?=
 =?utf-8?B?YnFUMkV5c1phYnE3TlgvamRSM2YwdDlmNnBHaVZXbU53OTliNXVMNVRrYmtp?=
 =?utf-8?B?N2w1MFNXclhiSlphVE9VWHhycFpUVWc2S0orUnBUSEVnUFQ5S2srRmxKWTQ5?=
 =?utf-8?B?RkdNdUdPenhQTWMxMkRzU3ZRRDRQZjJmY2RSYi9yUmxJenNhYTJpczZ5Uyta?=
 =?utf-8?B?NEwwMElPaGYvUjdya2JzVkNqN2hzMFZmbEJsLzA0Y0RLamxhQUNmVTg1YnBu?=
 =?utf-8?B?Z3Jpak5pUi85ckNCVUt2RjdLeEZsb21sT09mYXpLTTFnK3ZUVHRlL1hoRmlk?=
 =?utf-8?B?WUZZK0lmQi9aK3d1Z3VwRzZSWm5oMXY0K3N1b0hnY1RyME9EKzBieTFXVXVN?=
 =?utf-8?B?d1p4dC9TYXRpUytBRWMvUmgrRUlZYnlpQ2dON2tsU09nLzh3OEdUSjlxQmdt?=
 =?utf-8?B?TnNnaWg3RHQwRnJQaUgvUmxrbDhWS3FTbFoyMFYzQU1HczZKVWlrL0FxMHk3?=
 =?utf-8?B?OXJhdkcwdVRhVmphNEZ5WXp2TTFjME50SFZ5SUY0NDZTMExwbFdaajMwZ1BI?=
 =?utf-8?B?YUhGWmZOTUxIQms1RW5iM0o1eG1WNVI3NFM3MHlvVkhxWW4yemk3T0dxZnRN?=
 =?utf-8?B?V1A2YWpsUThLc2ZlUmhXMGR0NStqdW94K0M4UzhRK09DKzVCbXVobTQxa1pk?=
 =?utf-8?B?V2pwazFDNVNoRk9WeEUxbFFQc2VJV2pUR3NNbzdGOVY0SUdSdDhBeGdPNmJ6?=
 =?utf-8?B?Z3pZZmtuSGY2RG9sTFh5Q0ZSTU9CblZvTjU1dmE2Si8xdGYyUHZySDJZRk1s?=
 =?utf-8?B?TnNpdGhqNkU4MG1nZTZaVktSN3dzZGR4VEVmUGN3K1dadW13YzcvWXZpNzRR?=
 =?utf-8?B?OCtNOUNySzEwQzY3SXRSZk1xWlJTb1JuNCtiL3Rnd0dSS2VyN25DeVlEbjJO?=
 =?utf-8?B?UVhnZEY3UlkvODk5R3JLTlN0UlplUm8vcmF3Z0x1UmlUWEVXejh0Wlc3UVJR?=
 =?utf-8?Q?atulb3?=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PAXPR04MB8510.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(7416014)(376014)(19092799006)(38070700021);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?utf-8?B?cU9OSTFOQ0xoK3lRK3pXQkJCWFRqaWlGa04zQ1VBZnVDU0NaTnVCUW5qclFM?=
 =?utf-8?B?VUVHUUhQRlpzY3kxMkRSdnBJN0ZsQmhIUXB5Zm1iMncrR2RGR1J0MHJFaWI4?=
 =?utf-8?B?L0JBU25KZi91dFVhdXVMa1ZBSnJ0TWRYcm5wNm9LN2NlS1EzQ2h3eXVLV1ZU?=
 =?utf-8?B?eFhMU0NSbElTRnAwL1d5clBlQ1g0Vk9LazNZQU5oekgzZlhNaDk4MUdCdzVN?=
 =?utf-8?B?azZHNTdPZnJtLysxK0kzcXRWdXh5Wkd1ZEZZTldBVjNLQXVhZkhOY25mZXFn?=
 =?utf-8?B?eWVHc2xSa1VoT25IVXJkYXdXZk94a0wzYSs1RFhHQ0xoWEhLb1lJaWdaTVJI?=
 =?utf-8?B?YlpEK0JzVkNJbk1LTVdxeXB3bWV3enRvVEN1ei9RWUg1S3g4RDEvQTZaMW9X?=
 =?utf-8?B?MDZaaDQzN2g5MlRhSmtvVUVFTVVpMVB0ekFMeTFNYVpheTBXRFhVL0dPM1J5?=
 =?utf-8?B?NUxDRW4yRGM0S3grUE56K3NSbjMyVWxBeFQxT0FSRHNmeWxjTTZUOUN5cVRx?=
 =?utf-8?B?VFJCYmVZWFdrcE1ZL25PemcwSmNyU1EwUytQZ3RQdnlDVmpybVRjMjV0Z2J6?=
 =?utf-8?B?R0hwdU9kQUZoTEZMY0lwRTVWWi9ESWo0ZDVSeE1OL2RPUktVVkpQanBKeThY?=
 =?utf-8?B?T2JmcTJ1ZGtvMHdNYkZQM0ZIcXlaSjl4TVAxaVZFSVQxNXIzZlhEeGM2SXht?=
 =?utf-8?B?VWxZYklWdUFBRjVHemJqSWtHcXdOOUxhVFJFeGZpSFB1YWZIZDAra3BtK2VT?=
 =?utf-8?B?NXBaR0dXcGFqeFpib2M4RHY4ZCtmeStoRkR5b3NSNkhyMkNjVjdVcVEvdmM2?=
 =?utf-8?B?UWRoUHJSbWZiQVBQNkRYcmtOc01UVHFQQ25OQk1ZdnRDdWhybWJaZEljZkln?=
 =?utf-8?B?bFRYV0dWQlpmdG5sT2NhU2cxWjQrU0cybTdrMVNTeHlFMjJBRzZHKzdoNW13?=
 =?utf-8?B?UUJmWlM3L1lZc1laYk4yNFU0Vk9JQjVNazFZQVozY1RSR1lLekxYQ3BPMzBv?=
 =?utf-8?B?V3dGcjQ1cm5IenBzSHpXRWs5bi9CcmxsWTFmR0dBVTYwVFpETlEzSjJOdmZw?=
 =?utf-8?B?dzRkdFZacWdpeG1zcTBzQ0hhNkVWQkhBeVdzQ0svV0NNZXZPL1FIcU9GWUJ0?=
 =?utf-8?B?bjROUVIydGx1cG5hOGxoditYdk81VTN0RzJndnRvUUpUMGtFUlIxWDBDYzUw?=
 =?utf-8?B?ZE1WQkYrNWFCanZnQXRSODFYMXNZUTJsVE9kTDk5UjBUaThqSUVTZUdaaG5Z?=
 =?utf-8?B?UDVzWExVVXdUU3BqRTVnV1RCK2dyZVhoZGNLK0YyUFg5SkhjazFid3ZhbVdl?=
 =?utf-8?B?cXBxMFVxQmxtTW1tcVJPM2hYTzNNRzh6MDllNy8wQS9oSXN4ckR5WUpubGVx?=
 =?utf-8?B?Y2VkMU5YYmJ1VGZyVVAxOWdiSVloSDM4K3BKd251L2Z6eEZud3k5cTRNRGJk?=
 =?utf-8?B?ZzFOdG5SVXE5Mmd5UVdHTWdZamFWeXFraThkUmlDd1Bta3ZjbnNZYndtNkpN?=
 =?utf-8?B?aVhqN0pFUVFVbWlGMXd4L1FocGFyREkrektBSFZxOGZDeTZZQ1ppdHkyNldv?=
 =?utf-8?B?MFNYaXpSQ3lWL1YzQUtVUmhFOVUvTk1NS3FtcWdoTDFCQmpxc3FsazZrNjRj?=
 =?utf-8?B?NmZhcGpoOXZ0UXFWZENtd1pRV3NEK09SS0VYMUFNT1B1TEpXRnJOVXdDdW1J?=
 =?utf-8?B?MDd4UGVYTDZ2SlNtajNKR3A0TWQ4YkdKU3AyOEVzRW1sMXlLT3FYMEZZS0Vy?=
 =?utf-8?B?Z0V4MFRMM3did09ZS3FzQVluQk00bW1mS25CaXJ4aHpkTitwSk81WWlDbzZK?=
 =?utf-8?B?cnZoeVFEVkFjS2pDOXVBVXp2ek5nUDBHZm1mSFdNUUN1V2kyU1RtNVQ0OGE5?=
 =?utf-8?B?SVYvOVFwSzArdExUeENjRlNLVUprMlJWUUhWVjh4VzBGeXFZNFU1WDg4NU9E?=
 =?utf-8?B?VVBSQWhLbFNlRVlFRUxkLzhPNHhaUS9aYnZhWEhQQUFlZ2FCSnlEM2E3d29u?=
 =?utf-8?B?UnNiUm9YczFKSHlXU0FZWVV0eDAydFgvRWRNazhhNkdMbEE5ZWtGUG44dlFL?=
 =?utf-8?B?UUpGcXdUTUY3U0dYUzNTV0MvNmRwMFIvK0w1K3B6V0dxWU5LYUdzL2RSWkt6?=
 =?utf-8?Q?//D8=3D?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: PAXPR04MB8510.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 5a167fbf-06fa-414d-0f64-08de110c9044
X-MS-Exchange-CrossTenant-originalarrivaltime: 22 Oct 2025 01:44:39.0807
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: gpG/OaOrPRNAS6w1e8LnfHrbGxsr8sVVG+LXg20bQfMYwq5rAx56kHG+vsGPQZgbNx1Rx/+qb/UNiLfiQu2Wnw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DU2PR04MB8646

PiBPbiAxMC8xNi8yNSAxMjoyMCBQTSwgV2VpIEZhbmcgd3JvdGU6DQo+ID4gQEAgLTYzNSwyOCAr
NjQ5LDEwIEBAIHN0YXRpYyB2b2lkIGVuZXRjNF9wbF9tYWNfY29uZmlnKHN0cnVjdA0KPiBwaHls
aW5rX2NvbmZpZyAqY29uZmlnLCB1bnNpZ25lZCBpbnQgbW9kDQo+ID4NCj4gPiAgc3RhdGljIHZv
aWQgZW5ldGM0X3NldF9wb3J0X3NwZWVkKHN0cnVjdCBlbmV0Y19uZGV2X3ByaXYgKnByaXYsIGlu
dCBzcGVlZCkNCj4gPiAgew0KPiA+IC0JdTMyIG9sZF9zcGVlZCA9IHByaXYtPnNwZWVkOw0KPiA+
IC0JdTMyIHZhbDsNCj4gPiAtDQo+ID4gLQlpZiAoc3BlZWQgPT0gb2xkX3NwZWVkKQ0KPiA+IC0J
CXJldHVybjsNCj4gPiAtDQo+ID4gLQl2YWwgPSBlbmV0Y19wb3J0X3JkKCZwcml2LT5zaS0+aHcs
IEVORVRDNF9QQ1IpOw0KPiA+IC0JdmFsICY9IH5QQ1JfUFNQRUVEOw0KPiA+IC0NCj4gPiAtCXN3
aXRjaCAoc3BlZWQpIHsNCj4gPiAtCWNhc2UgU1BFRURfMTAwOg0KPiA+IC0JY2FzZSBTUEVFRF8x
MDAwOg0KPiA+IC0JY2FzZSBTUEVFRF8yNTAwOg0KPiA+IC0JY2FzZSBTUEVFRF8xMDAwMDoNCj4g
PiAtCQl2YWwgfD0gKFBDUl9QU1BFRUQgJiBQQ1JfUFNQRUVEX1ZBTChzcGVlZCkpOw0KPiA+IC0J
CWJyZWFrOw0KPiA+IC0JY2FzZSBTUEVFRF8xMDoNCj4gPiAtCWRlZmF1bHQ6DQo+ID4gLQkJdmFs
IHw9IChQQ1JfUFNQRUVEICYgUENSX1BTUEVFRF9WQUwoU1BFRURfMTApKTsNCj4gPiAtCX0NCj4g
PiArCXUzMiB2YWwgPSBlbmV0Y19wb3J0X3JkKCZwcml2LT5zaS0+aHcsIEVORVRDNF9QQ1IpOw0K
PiA+DQo+ID4gIAlwcml2LT5zcGVlZCA9IHNwZWVkOw0KPiA+ICsJdmFsID0gdTMyX3JlcGxhY2Vf
Yml0cyh2YWwsIFBDUl9QU1BFRURfVkFMKHNwZWVkKSwgUENSX1BTUEVFRCk7DQo+ID4gIAllbmV0
Y19wb3J0X3dyKCZwcml2LT5zaS0+aHcsIEVORVRDNF9QQ1IsIHZhbCk7DQo+ID4gIH0NCj4gDQo+
IFRoZSBhYm92ZSBjaHVuayBsb29rcyB1bnJlbGF0ZWQgZnJvbSB0aGUgcmVzdCBvZiB0aGlzIHBh
dGNoLiBQZXJoYXBzDQo+IHdvcnRoIG1vdmluZyB0byBhIHNlcGFyYXRlIHBhdGNoIGluIHRoaXMg
c2VyaWVzPyBPciBhZGQgc29tZSBjb21tZW50cw0KPiBleHBsYWluaW5nIHdoeSBpdCdzIG5lZWRl
ZC4NCj4gDQoNCkJlY2F1c2UgdGhlIGludGVybmFsIGxpbmsgKFRoZSBsaW5rIGJldHdlZW4gRU5F
VEMgYW5kIHRoZSBDUFUgcG9ydCBvZg0KTkVUQyBzd2l0Y2gpIGhhcyBhIHVuY29tbW9uIGxpbmsg
c3BlZWQgYW5kIGl0IGlzIGNvbmZpZ3VyYWJsZS4gU28gSQ0KcmVtb3ZlZCB0aGUgc3dpdGNoIHN0
YXRlbWVudC4gQnV0IEkgcmVhbGl6ZWQgdGhhdCBzaW1wbHkgbW9kaWZ5aW5nIHRoZQ0KZml4ZWQt
bGluayBzcGVlZCBpbiBEVFMgdG8gc3VwcG9ydCB0aGlzIHVuY29tbW9uIGxpbmsgc3BlZWQgaXMg
bm90IGVub3VnaC4NCkFsdGhvdWdoIGl0IHdpbGwgbm90IGFmZmVjdCB0aGUgZnVuY3Rpb25hbGl0
eSwgcGh5bGluayB3aWxsIHJlcG9ydCBhIHdhcm5pbmcuDQpGb3IgaS5NWDk0LCBJIHdpbGwgc2V0
IHRoZSBzcGVlZCB0byAyNTAwTWJwcyBpbiB0aGUgZml4ZWQtbGluayBub2RlLiBTbyBJDQp3aWxs
IHJldmVydCB0aGlzIGNoYW5nZS4NCg0K

