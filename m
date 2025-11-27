Return-Path: <netdev+bounces-242201-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [213.196.21.55])
	by mail.lfdr.de (Postfix) with ESMTPS id 49778C8D668
	for <lists+netdev@lfdr.de>; Thu, 27 Nov 2025 09:48:08 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id B36F734D3AC
	for <lists+netdev@lfdr.de>; Thu, 27 Nov 2025 08:48:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 85C4021FF23;
	Thu, 27 Nov 2025 08:48:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=aspeedtech.com header.i=@aspeedtech.com header.b="ctyKHF9k"
X-Original-To: netdev@vger.kernel.org
Received: from SEYPR02CU001.outbound.protection.outlook.com (mail-koreacentralazon11023133.outbound.protection.outlook.com [40.107.44.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A7C2E1F5EA;
	Thu, 27 Nov 2025 08:48:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.44.133
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1764233284; cv=fail; b=plLvqF7oUnfkLXfUuZ2YTywC34sREW0XadY2QMqZTBNcZkQE+z8PwsApylWCZXAuDoWEl4BhjzaHEdQnKhfzW4AdYb7g6sdd+37hh+GNvFBvD332RuXRAIm+SzZMnDM7VonynMhT4mnShMH2nL+eMygG6AHDJlnmtQPVZjP+ndw=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1764233284; c=relaxed/simple;
	bh=uf3GAWl6jVajrIrFShlLKzRLLAFATFR9uuKEB++wxsI=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=XkVyQ1f8ul2VGuYulbsVLGy2JJx3uO//yez7b8lc0Sj2v5xyfNRmS7SIn8VSicrjkRHWHn5t3vREBNnxBqcpncTX2ImVg55R58Kj3d3TeZlEslwJWxHxS5M1V920KTtRJbLCpSAlFwy8WHxxbKj4S5DrHQ9ZmIHI46BqBye/LsQ=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=aspeedtech.com; spf=pass smtp.mailfrom=aspeedtech.com; dkim=pass (2048-bit key) header.d=aspeedtech.com header.i=@aspeedtech.com header.b=ctyKHF9k; arc=fail smtp.client-ip=40.107.44.133
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=aspeedtech.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=aspeedtech.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=nFWx/Td4tuSfxfKZLNIXjY7NGjmYgKs11c9NWlfFwiRyb2NCk93m1SnVRZAR0EfZ8CLeHmROkzDlLS0l0nxm7c4Beyz9dTra7B1pJ69l30Jp6kXukmuoYysnvRGTFE0siafOmKjcAZz0bd3yOSnSR+iNZC7t7YjhJnio84yMI1m2X3LWZpxyWf3WQw4820RNxMm82WXzj6Yfcvu9QlxWTo6BORY+CgwKDgaN09Mc5NEV9C6HJo5G9z+//Q4aUt2e/mfsnN2HZdlfVOf4p+DHTrBL7NIbPHXkt/DWDwKXx0/mdhEovk4u5Zfsyw3FMQ0OnAiNr5kE//bbvXAP33O1yQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=uf3GAWl6jVajrIrFShlLKzRLLAFATFR9uuKEB++wxsI=;
 b=vZ+4alRTc5iJYd6fDBETTaC6A/ZDd71GONZnAxbT+2KQTLwnurekh52s/FYGZfp1rABbmXaHAlN6ia2YUzMHb//I7VrGKnddBw07h4SnU65M2ISeoX5c3AXSKg1Pz97M+nawtx6tbT5kiA+i9rbyrAVyanGuSsbsCd2tUh1OUnZTK464om6hldWC7AuMppxNvn4D1K2PKs25/f9h0TGnHOH/Nr3hUevXf7FHOj7HTCJuDhMRoEK5bzlkcTKUxKlImPNxMQDTgpUNGXqZKmHkTj4GNu5+5xynSaklOIYbyn6+kOd+2iTi8Y7fO6+nwiGvFo6x8q7QCJDchT/mKnhWFA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=aspeedtech.com; dmarc=pass action=none
 header.from=aspeedtech.com; dkim=pass header.d=aspeedtech.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=aspeedtech.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=uf3GAWl6jVajrIrFShlLKzRLLAFATFR9uuKEB++wxsI=;
 b=ctyKHF9kDH/V4zRWAK7oZXHWscQWzufZisIdreGVh++t6NxrRwcyrVJKDjFZBO8mdWKdj2qsvKOHKV0adcRBEHWM6wGl9LrAnjsgmiBicaeZfsI4RkVcWKhATPksFXV0bfAG9GAcvA0BZUXhCHRU/T3OiteqrjOnHr8zDiVQck0kDKoK3fcaDP8b0FlkK+ySraz4nmn/1/tFJVi2U4Nm9GVok8k/Hb8VEJ2RDWYU+bh7ug5DZFY0unaOG9dkH47H3Yex9TQx9xL9D2YLTRUtKS2vkz9R1gprwixNhVsxuV2iAD4yhX3V3ldIMdM/aTafQ2fkeXhIxWtbsvi5G7aSyA==
Received: from SEYPR06MB5134.apcprd06.prod.outlook.com (2603:1096:101:5a::12)
 by TYSPR06MB7136.apcprd06.prod.outlook.com (2603:1096:405:90::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9366.13; Thu, 27 Nov
 2025 08:47:54 +0000
Received: from SEYPR06MB5134.apcprd06.prod.outlook.com
 ([fe80::6b58:6014:be6e:2f28]) by SEYPR06MB5134.apcprd06.prod.outlook.com
 ([fe80::6b58:6014:be6e:2f28%6]) with mapi id 15.20.9366.009; Thu, 27 Nov 2025
 08:47:54 +0000
From: Jacky Chou <jacky_chou@aspeedtech.com>
To: Tao Ren <rentao.bupt@gmail.com>, Andrew Lunn <andrew@lunn.ch>
CC: Andrew Lunn <andrew+netdev@lunn.ch>, "David S. Miller"
	<davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, Jakub Kicinski
	<kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, Rob Herring
	<robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley
	<conor+dt@kernel.org>, Po-Yu Chuang <ratbert@faraday-tech.com>, Joel Stanley
	<joel@jms.id.au>, Andrew Jeffery <andrew@codeconstruct.com.au>,
	"netdev@vger.kernel.org" <netdev@vger.kernel.org>,
	"devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
	"linux-arm-kernel@lists.infradead.org"
	<linux-arm-kernel@lists.infradead.org>, "linux-aspeed@lists.ozlabs.org"
	<linux-aspeed@lists.ozlabs.org>, "taoren@meta.com" <taoren@meta.com>
Subject: [PATCH net-next v4 4/4] net: ftgmac100: Add RGMII delay support for
 AST2600
Thread-Topic: [PATCH net-next v4 4/4] net: ftgmac100: Add RGMII delay support
 for AST2600
Thread-Index:
 AQHcUjKRp/5wUPPeG0Wo2Pz9fS4A+7TsCtCAgAJeVpCAAKBqgIABWbLAgAPq3QCADnQYkIABZcyAgACY8gCAAYfhoA==
Date: Thu, 27 Nov 2025 08:47:54 +0000
Message-ID:
 <SEYPR06MB513424DDB2D32ADB9C30B5119DDFA@SEYPR06MB5134.apcprd06.prod.outlook.com>
References: <20251110-rgmii_delay_2600-v4-0-5cad32c766f7@aspeedtech.com>
 <20251110-rgmii_delay_2600-v4-4-5cad32c766f7@aspeedtech.com>
 <68f10ee1-d4c8-4498-88b0-90c26d606466@lunn.ch>
 <SEYPR06MB5134EBA2235B3D4BE39B19359DCCA@SEYPR06MB5134.apcprd06.prod.outlook.com>
 <3af52caa-88a7-4b88-bd92-fd47421cc81a@lunn.ch>
 <SEYPR06MB51342977EC2246163D14BDC19DCDA@SEYPR06MB5134.apcprd06.prod.outlook.com>
 <041e23a2-67e6-4ebb-aee5-14400491f99c@lunn.ch>
 <SEYPR06MB5134BC17E80DB66DD385024D9DD1A@SEYPR06MB5134.apcprd06.prod.outlook.com>
 <1c2ace4e-f3bb-4efa-a621-53c3711f46cb@lunn.ch> <aSbA8i5S36GeryXc@fedora>
In-Reply-To: <aSbA8i5S36GeryXc@fedora>
Accept-Language: zh-TW, en-US
Content-Language: zh-TW
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=aspeedtech.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: SEYPR06MB5134:EE_|TYSPR06MB7136:EE_
x-ms-office365-filtering-correlation-id: 5685a1b4-cf2a-4821-2c42-08de2d91a826
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam:
 BCL:0;ARA:13230040|7416014|376014|1800799024|366016|38070700021;
x-microsoft-antispam-message-info:
 =?us-ascii?Q?HOZRwR85wt+gihx14wmrWBmGz700ZaniOaMWkVCntgBJ7vUIe79JmSUpM0o/?=
 =?us-ascii?Q?vuiAkTsOxKf7vnzHEIJkf0+7Ij7hAum2XRJK13+EOMyHuzQ/xL7ZzvV2UYiA?=
 =?us-ascii?Q?xrsBoiG/xYKHYvjgDx5/juWPhP6/UtSqZQvsDiOEn1xHpnGCrQH0BlZ02jnU?=
 =?us-ascii?Q?Etggg0J8pp5vNWbWm4PpbKgGUFjxzlzqPfgtIvm/7RKVsFGPkiYJuWXUxdcd?=
 =?us-ascii?Q?m2eRfem3DKUPcY/aKvttVuAApahx46DZmhC9rbjmqbxzF7sVfXtdaFc8L1kj?=
 =?us-ascii?Q?L08FVnZX07NlTcibnoaqf7MFIjuEa2cWEq0EITlXQ/MisX3fXpJkqDXsPEpP?=
 =?us-ascii?Q?YoksZ2TGpakSIVdqHdG6x1z3wXo+/R4XH8c40j0zkFGLeqj4D54WBtnDyma5?=
 =?us-ascii?Q?N4qvEV6OIwGIeDHhBqEUOKYQBwnzfAy5uAWy3bXmG4FK9moFI1Y8JL3VJqU2?=
 =?us-ascii?Q?uybEdwlD19hxYTGW4T5+qWkvncefF+/4VuvnOvTl7KCBwIviFxQwi4Iw9m2u?=
 =?us-ascii?Q?CWZ7gVHmp2xJlq8lX/JzloZY5y7pJjirxULEvTDmmWSu5QMRklhFnrtkgz/i?=
 =?us-ascii?Q?nGgvO1g/eLiTAAkomZZNJ7mYX6MOfUAQxnOxDByekT0ONVhwuM5PVfZXIC6U?=
 =?us-ascii?Q?Tsa1W5KEUevdU7iTHugxrvza9jScDGsYNna8bmQojP7xttqqcJJaCfc6uiGZ?=
 =?us-ascii?Q?4oFwfTJWlLXBgmQZrMsj03TXtN3KXBWc4T6pvG4IDbuibdCncYT01M3gwKJU?=
 =?us-ascii?Q?JjLwFz7QyKffTN+RMAVwFJrdjSOlBFTrH6kYAEd5+UNT4GApXnc4hBwjigL6?=
 =?us-ascii?Q?JiJ8UjYYiHILSm+cgpHO2DU+YOFZnKCWlFlKqCh2h0ptE459TFHB7z2jOTuc?=
 =?us-ascii?Q?1tB5ufZraRIyh+Y9tOQ9JoGE6x3BRVfzneX65D2bSehZm5P8mEPwyNHNmqVd?=
 =?us-ascii?Q?9jPR+WbeI5OQ4eOGfzIyukuQ7oHltEKhCwPvgz3cEGLm7gR5e5WmrVPcJU5J?=
 =?us-ascii?Q?EtlT/+0Jw7TUgc4ifqp4x3O8jcCSa1oNhTA2Y5CBqG8Jvb1i/YgtvNcz/9U2?=
 =?us-ascii?Q?51NChMH6Xof0LQ+dWYP6D0sJeVL6dhwjAwSjzjiH85xAS0l5eUAuSx9GR5Sn?=
 =?us-ascii?Q?IYZhAZvUaND1kd9Yj2f1jqJNyebpAEeiI9NEoV8KPFvC4itGYusG2P3arZ58?=
 =?us-ascii?Q?eRKGIdyHG8VP9xRplCAhsQ2fJ7qVch8JUwPfmZ9g5gq/OBtMgwIO1AJJpDOK?=
 =?us-ascii?Q?b7Md3pNevR4+4sGOfloMzqsdxpdfrGJbIGL+ary8w+TOw3g4JUF2WOgZnzaF?=
 =?us-ascii?Q?oSuBJiinXL/DhograAkaS5sAEDpdhMvcHkni5/gg3iKeA7C4xtyfwvjadtAH?=
 =?us-ascii?Q?2GeCE6NR3Yn6mc+YzmvvxKpEmzCq6S06pclf3pjha/xHP+FAlN8nr+pJeJwS?=
 =?us-ascii?Q?M76kg1Henz5GehQqTtL2S948rE1I1bb0z0U1HozPOW60mrW2CwRlAmKndYJL?=
 =?us-ascii?Q?z6SS6INKuTWIfvuC90WtaZqYcryG/fGCJQ8I?=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SEYPR06MB5134.apcprd06.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(7416014)(376014)(1800799024)(366016)(38070700021);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?us-ascii?Q?D03X1v1/Y+pUIS4llCDvZGhJMM3aL7JwuN3Ur7nQDRLQXLnwEL67RtVt52bh?=
 =?us-ascii?Q?2v7qmcji5WJxcemQc5M+qH6+jwr/ITFl2mq3K0Riie4Er+enzMse2wOZx1qW?=
 =?us-ascii?Q?tow80r9/BnKDi4ST7Una43iO0jlOPCMgFBc3Tj8PX0UH5F9/tLjT0mYGOyZH?=
 =?us-ascii?Q?OXAsSCzWQ6OdLM98jh58oQ+wA3cie9udRSI8avMg/OLycL5ixZGsh94M9poN?=
 =?us-ascii?Q?GilAoV8GbI5qgMDZhgh4GrPu5Bg5GD8s9jjOpG5f05yunOCMpskaFygB5twu?=
 =?us-ascii?Q?idPeahHQtR94f6L+oBMs7ryhgCFYQNO7MbebK7oSeXQYyyk5zyvh4fHfvexY?=
 =?us-ascii?Q?/rb5DRMhnikQW0zKoQ+dBnP08I+N1DfY9BGro7j1ISvKk0h6vuuqOQoO7yjd?=
 =?us-ascii?Q?eSlbjmIc6JncRSdQTk2ZNNWVjd68niuvvEr5XfUBpw6fOjfVBQk/6qSinwhy?=
 =?us-ascii?Q?uWpu1YOs01NL6pxLWuxC4eWG4v79DqSBey0EqgIcS9wfWb1wuAliAu5Ji1HI?=
 =?us-ascii?Q?c0BqfrKfO1pYqSUZQxzoE7O2lIUcAPRTC1HX9jpXQ3COIn1dqdT8mNn700I1?=
 =?us-ascii?Q?KFPY3492VEUrCyKyphyZbKtRonyfcIVK6M2F8PpSt/y27IFFe4kgpN61YfDW?=
 =?us-ascii?Q?3CQskCf015gusWFBY7KpHn3X9ph7rulp0YJtjBDuKbFcuwiI/ZBNkURq4/b1?=
 =?us-ascii?Q?vuyOLndwq8foaYOFyTyUsnfx57YIUZJK0AXFmY4eKEc2QgVSMN9mRh0wm4j8?=
 =?us-ascii?Q?DiDtGi29J91InaTDVJhni+pH5rUu+hEeo53oIeoY/upIVljIo5Yn609Uk3uj?=
 =?us-ascii?Q?ShCmA+RydxRwTtbp5H2qTGoQ/qihKhWTqtuvpWIfnxDXzhnWQws/sTYMZvZX?=
 =?us-ascii?Q?7AOXbAi1DrYSM9ZLJ7TllpS/9u+2nPB5gv+zje1Dop16q6qWefQZp990MD6c?=
 =?us-ascii?Q?9/7LnIwMjh89VtVqi/iIb+jorvSb9v6pETNOrJS8x6p28lCZlyt+G0GqfmaQ?=
 =?us-ascii?Q?FbOhz9sFqPyFzck4OPvAdOO7PpIHoQaClKrGh8ok14E1pk6OpCvGN/D6ATFb?=
 =?us-ascii?Q?myqOK6G4IUpAhKe378DWs+mHrp3jYtK77aiSq9QVukopvHAUNmDpRESDdkDF?=
 =?us-ascii?Q?DlXLfQHMSCqySYA4NDalqpji8VAbrCmtE/L0areV/1BMOTHbrRq12csVdVss?=
 =?us-ascii?Q?7FoTRbjXxd/lDP3Vk6ABJkBlQmH4CK58ad6+LoCH2x4gFmDvlE+cV8Wpz8W5?=
 =?us-ascii?Q?gA2/B7aBFykmL03ZeBKFMa2XMcTeRETObK4q+D/4Fh6PKJWJyVDQ37Gh1ID3?=
 =?us-ascii?Q?ikrCi9WTVHleGFAK5jwm/SyHspKLkK3xA6Ya6zEaUtD0M9Lg/bYVHOWR6uua?=
 =?us-ascii?Q?GRgOz+xF2xWfGSL+TbkiJFDcuFa+CdnblxH24eWsz+qSbSZJxPMv4BnuhZoB?=
 =?us-ascii?Q?JJGn84s26/7CkdcnXx0epncf4tH+74lrWxBqkMVR7KDTY7z+NHUtB1qVDrjD?=
 =?us-ascii?Q?fvICkE+Gd8C+Yqiixbkj5hv2YMAKytxcgPB0S/jEY9+K7oJejI1WkigAzIAx?=
 =?us-ascii?Q?BuKOOaFwvHUK7/r9zW3TYvSftfd3InihzIytrF/okxXaSFjleF/kyZtYWh0Y?=
 =?us-ascii?Q?Zg=3D=3D?=
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
X-MS-Exchange-CrossTenant-Network-Message-Id: 5685a1b4-cf2a-4821-2c42-08de2d91a826
X-MS-Exchange-CrossTenant-originalarrivaltime: 27 Nov 2025 08:47:54.7340
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 43d4aa98-e35b-4575-8939-080e90d5a249
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: QPi4Izr7xLR2vq90hpz90sIuZNn6JM3iRzFiwR99xPeORKBI66eFw6dHkC2q0qcO8pUhCRb6I+UETHDt0KR2w2Q6CKUAdDDEcXsGZ/sDNCs=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: TYSPR06MB7136

> > How many different boards do you have you can test with? Do you only
> > have access to RDKs? Or do you have a test farm of customer boards for
> > regression testing. I would throw the patchset at as many boards as
> > you can to make sure there are no regressions.
>=20
> I synced with Jacky offline a few times, and I'm happy to test the patche=
s on my
> Facebook Network OpenBMC platforms.
>=20
> Hi Jacky,
>=20
> Looking forward to your v5, and please don't hesitate to ping me offline =
if you
> need more info about my test hardware.
>=20
>=20

Hi Andrew,

Thank you for your suggestions and feedback.
I will update the patches based on our discussion in the next version.

Hi Tao,

Thank you for your support.
Once I have version 5 ready, I will reach out to you. I appreciate your hel=
p in=20
verifying the patches on your hardware.

Thanks,
Jacky

