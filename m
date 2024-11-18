Return-Path: <netdev+bounces-145761-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 7A12F9D0A61
	for <lists+netdev@lfdr.de>; Mon, 18 Nov 2024 08:46:15 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 152CFB22967
	for <lists+netdev@lfdr.de>; Mon, 18 Nov 2024 07:46:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 14C6114A60A;
	Mon, 18 Nov 2024 07:46:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=aspeedtech.com header.i=@aspeedtech.com header.b="MkXPSEJF"
X-Original-To: netdev@vger.kernel.org
Received: from HK3PR03CU002.outbound.protection.outlook.com (mail-eastasiaazon11021116.outbound.protection.outlook.com [52.101.129.116])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4D54017BA3;
	Mon, 18 Nov 2024 07:45:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.129.116
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731915969; cv=fail; b=i0lCfCVdY1ZDXuz/K6ZVfTlB4H+/8pRmxF80fxymxPEILUwtNoAi4BAhMAeeyZbltag5My3RvK1F4rVHr+HxKELkjDEa3QUjITWBtBdOxVgjmShF3/p47nOZIrZIVOkjMqRQh279Bd9AImSPuax8q4SuIJ2SQs0dX/gISQnFZkg=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731915969; c=relaxed/simple;
	bh=VyH87H3nNXOPiEdSLVJWeTBfXMpKy0//J7k/rUTTs04=;
	h=From:To:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=lGVJUn8taLyBLIqK49nRSsbeajkIo9de7gieM7SvRQjjZQUyxyXfHTWKRB0SiL7+TS9QZQ6GjMdDVn20Ej8u7KUl/Wn2sLQvR8nmAiG4+As1xs+1YXri3L2vc1r4vrxRP2QQU7eC6cxs+/SQS4UwcxOFDXrnW6Y7n/wokXdDqag=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=aspeedtech.com; spf=pass smtp.mailfrom=aspeedtech.com; dkim=pass (2048-bit key) header.d=aspeedtech.com header.i=@aspeedtech.com header.b=MkXPSEJF; arc=fail smtp.client-ip=52.101.129.116
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=aspeedtech.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=aspeedtech.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=rIx13/F04oCwKup3jh+1csjm7INwmhxKU+xGK5A/g+Z2pxwWH2RixFC8tygWDPVhYv3Tt7FxZDZU74aETPRkgByB/+zbLIXTgfgiQwp6frSWWyQhA2vWpMYV6nmKRJBHLrbWuM4J9aY3DQlK6zx5BEFFhA1T0V6+dwY15d0PC9kX6G0XUt4OAn/Cz+RyNJG9wFZyYgLrpj03JTLXoo6abcitan5ThC7fUaqFtMNhbUuCuyjyIQOoX3aTSOPTOAeKuOdMtdi8eaAEIbhJtDRwnyaX6WHB1HdesOZuYkzknjYd4moNNnihJ3GPSpQYT94ysRLSPE9X630t4ZqzUV2Qkw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=VyH87H3nNXOPiEdSLVJWeTBfXMpKy0//J7k/rUTTs04=;
 b=hLmNMilN+PAL5xv9YH0gefGtjo7Ug7TQEWjzY+LYzHztei57t5P84jgkGCuJJiVH7iirFAky/hvicOz82M8CqRlXGWQ+BksO2Iuv+PSeg1l8qhRfxjJpNAQVlBtxxyOQ3NdiVBu/XiVC++WSteqvx/xuAGaH36nw5HIf3dxfJE9FM9qT6lvBXvi180Z6Eq9/YCUmi/noXlalm+VP2fM0a8shs/gfdgB/qYH26A2CiOoYiZXRG0UTbnBw5cNmqBcHtUORh+zY0n04OggASM179PGhTpME04AT8KcB7mDbZB9VN5DcY2Gur2bjOh/JhUkPjWgBEgwt/NgvDTnt9zrd7w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=aspeedtech.com; dmarc=pass action=none
 header.from=aspeedtech.com; dkim=pass header.d=aspeedtech.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=aspeedtech.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=VyH87H3nNXOPiEdSLVJWeTBfXMpKy0//J7k/rUTTs04=;
 b=MkXPSEJFb1n8ZfCZVcjLej7Xc3qDnm3dUqMnlBIC7fRZb7B1EFXGK14d6z/gsH2MZ87xEpdPedPkII+xDnOg2pQtcVGspNI5mnXKjskqJ8vBDvhi1yYu8dt5gBe7kn7QouN+gCo61BxrkMFkOD6WNG5DDfg9gIfcIzCbA8Tjm9H6LbUsG4rIiw9iS0fE7nSCIbaiT0sGIgVdoBgZ8LgkDfZw5BNsLeWZSqxw+QwVG7byW620BoUc7H43RSZsDuzRfAtZq7xbzeN9IrBB1pd3CSyTVx/sveZBvG9ERCluVRaLT14oIMCB4Xshgx/JYqrWVMHZJaulUj0etVd6dKhDIQ==
Received: from SEYPR06MB5134.apcprd06.prod.outlook.com (2603:1096:101:5a::12)
 by JH0PR06MB7031.apcprd06.prod.outlook.com (2603:1096:990:6f::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8158.16; Mon, 18 Nov
 2024 07:45:53 +0000
Received: from SEYPR06MB5134.apcprd06.prod.outlook.com
 ([fe80::6b58:6014:be6e:2f28]) by SEYPR06MB5134.apcprd06.prod.outlook.com
 ([fe80::6b58:6014:be6e:2f28%4]) with mapi id 15.20.8182.011; Mon, 18 Nov 2024
 07:45:52 +0000
From: Jacky Chou <jacky_chou@aspeedtech.com>
To: Arnd Bergmann <arnd@arndb.de>, "andrew+netdev@lunn.ch"
	<andrew+netdev@lunn.ch>, "David S . Miller" <davem@davemloft.net>, Eric
 Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>, Paolo Abeni
	<pabeni@redhat.com>, Rob Herring <robh@kernel.org>, "krzk+dt@kernel.org"
	<krzk+dt@kernel.org>, Conor Dooley <conor+dt@kernel.org>, Philipp Zabel
	<p.zabel@pengutronix.de>, Netdev <netdev@vger.kernel.org>,
	"devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject:
 =?big5?B?pl7C0DogW25ldC1uZXh0IHYyIDMvN10gbmV0OiBmdGdtYWMxMDA6IEFkZCByZXNl?=
 =?big5?Q?t_toggling_for_Aspeed_SOCs?=
Thread-Topic: [net-next v2 3/7] net: ftgmac100: Add reset toggling for Aspeed
 SOCs
Thread-Index: AQHbOX9r9yI8DsQIiE+JZHcx3y+hz7K8lCmAgAASL2A=
Date: Mon, 18 Nov 2024 07:45:52 +0000
Message-ID:
 <SEYPR06MB5134798B2F2890FF527775FD9D272@SEYPR06MB5134.apcprd06.prod.outlook.com>
References: <20241118060207.141048-1-jacky_chou@aspeedtech.com>
 <20241118060207.141048-4-jacky_chou@aspeedtech.com>
 <6a7570d0-2b3d-4403-afb1-f95433ad6ecb@app.fastmail.com>
In-Reply-To: <6a7570d0-2b3d-4403-afb1-f95433ad6ecb@app.fastmail.com>
Accept-Language: zh-TW, en-US
Content-Language: zh-TW
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=aspeedtech.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: SEYPR06MB5134:EE_|JH0PR06MB7031:EE_
x-ms-office365-filtering-correlation-id: 61f119a4-2ede-4fa3-c17d-08dd07a506ee
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam:
 BCL:0;ARA:13230040|376014|7416014|366016|1800799024|38070700018|921020;
x-microsoft-antispam-message-info:
 =?big5?B?bFlKbFlQRTFqSkJ4bFJ0K0dSOFdORlBQWUltQnZhU2Zpc1VoVEh4SEZOUWxqTTFn?=
 =?big5?B?bVZHRkExeU9LMXNXOHJSRzNqcmxlS3RwSFJDWmpCUlZwNFdtQUQzdnExdmcxVGZW?=
 =?big5?B?aGdtblRtcHI0N2FSalpsVGFNV3p3QTIvaTgvNDczaUx4VEx5K1lvMGNzaWNxZFZP?=
 =?big5?B?SVBOY0xXRWxsZ0N1SjFYWTIyUGNTaEFTYW81SThHbkNmbnZWbXVWLzRqOUZGbzc0?=
 =?big5?B?K3VWUFUvNDA3RzFKUFB6UW5HZ1FXY1NJYzBZbkh0andqMXpVSnR3LytvL05FR09T?=
 =?big5?B?UjhnT0tJcTlkeXJ2VUVodGRrczFHbVNad0NGb1hyNjhPQ2RsOEFvWWhHVi9BS2dG?=
 =?big5?B?alRyWllpVlhYTGdWakhveWdkOThTTmVtM0tsejFoUDZ6UHRBNlpnZmR3WFJJRjMv?=
 =?big5?B?dXRKcXgzbXJoZFVQSm4zRmZRT202RWxEcW4vcHN0QzlkMkE5a2FtREdlekRBSTZz?=
 =?big5?B?K242dldiVFJMUTZkMjVTMExsRkdWU00vMFpuamZaTkp1ekNMMXppMnRyQzBtYzMv?=
 =?big5?B?RHNVYzZpYUtWU1NPTnY0Y25YQy9Qa2ZtbDQrWHhMVHNHQ1ptY0NUR2pHV0p5dTRp?=
 =?big5?B?NGNqOFpWMEQxeWNWVGtzRCtUdW5KNk00NXFtVkVyV3NpWDIrOExUckxCUE1SNCt6?=
 =?big5?B?dmhsWEJueXlUVHMxdVJTTHYxUkJUTFQwRW12Zk5Ham5sRVcyTnFueTNGV3hGczhv?=
 =?big5?B?Z1d4RVZ5QkNyVEVTZHQ3ZTZqTUZTM25qWmEvUCtCbXRkRERnUjR4dDMwYmo3bUIy?=
 =?big5?B?MW5tOE41V2I5WmhXZTk2eGxLby9Bd0dxSzYvSFpHNzltb2loaE15anYzZklLMjRw?=
 =?big5?B?d0NSdEdSdFlFczdIRXY3dkg1Y2NnOWFFZU5KVk4rb0dKa25XNjRIWmlDR2hYRE9B?=
 =?big5?B?UUltOXNiS2RPY2V3QTVPeERQMU9MZVpQeDRDZWJnK3kvS0crZ0xVNTErZ2RKbVFE?=
 =?big5?B?Q3lWdXZWYk1hYWlZMWxhQ2M1RENPdk1FZ21lOGpsRjZCQllvTVhwYTVzMnEvMWo0?=
 =?big5?B?UzRTUk5jaEl1WldlNTY0d0FpS3lQSlcvZGxNS1ZkQ1ZzWGxtczJWenBIa1JvZThJ?=
 =?big5?B?Q2M2UDdWYUtRSWkzUFE2aDJBVVdwTFlJZFppMzJHbDNVRWpqMjQrbG5Fdng0NUVD?=
 =?big5?B?dW5KMDVtdDczc0RWaUx4TmQ2di9vdWhlcjh6K0o0YzlqV3RtNWZuamtvbVplZ09F?=
 =?big5?B?Nk8xK3BMRThVMnBtb0haMGtTbDZPZzBMenh2SGR6V0QvM25UeE5QREZxaC9DMXZ0?=
 =?big5?B?SWpHMC8yKzlSb3ZTVk0wMGhvWHpEd2VMSkRTMk1LUktlUTFkcnplRy9XdlVnVmxn?=
 =?big5?B?WXIwOTErc1prU0tGT0RqVUNoZm5wOTF6anlkSmcvVjJieHF0b2U5bjdWRkc4VWJo?=
 =?big5?B?SnBsUEtMeE1jUlRDSWlxNlRCcTJkYkRFU1hDZDI5c0ZpM1BYVlVVL09Ka3JiNU55?=
 =?big5?B?Z1Y0UTdGQTErdFBxdStXSnROaWpQNWlOcGZWZGtrdmd5NEhTbEwxVWZ1S1JKR29R?=
 =?big5?B?YklmYmRkUDlydWNRTHdzemVvL0lFUlJZMEhjUVg2OER5aXZ4SUNUMkE0VHNYTExC?=
 =?big5?B?SjFjMGpkK3RxUGtkU014bUlHQTd1QmhsVzltODhxMmVWd3ZPa3RYQVh4YjEyMmNX?=
 =?big5?B?VFROdTRLN2R0RVMwTDFzZGZibEsvNFptclpWZUVya1doU1pQRHlTb2lqNHBrbkll?=
 =?big5?B?MnYzMUQ3L05KcitLVG1GdzFZbFloVnR6OXJubEFOWVdkR1hUSDRvSHlmTGZtRUdP?=
 =?big5?Q?7z/gzWUeqhpTCrvl?=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:zh-tw;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SEYPR06MB5134.apcprd06.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(7416014)(366016)(1800799024)(38070700018)(921020);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?big5?B?Nmo4dDR6WnRGSmhmYWZUbEFSUHA4TkZkb2dMK1hjdDNjUFVCVkJoUkNaektDUWRQ?=
 =?big5?B?SHoxeXJ1RW1DUzdMWFRncnBkbHBXd2xRWmJ4cE8rU0twNjFwWFR1aVZLeXR0bVM1?=
 =?big5?B?b1BUcCtuS0E1bzl3ZFZDWXVRVkFvMzAzVkg3UjZkQUYzUXorOHAvSCs0SExxSkZV?=
 =?big5?B?cUM0MmdKNGwydCtBWHhoR2lFenJoZHJOSzMrVEJldGg4SzdDU056WUZidU8rSEhW?=
 =?big5?B?VVcxeUZPam1XYkpUQ29NRS8xQ2thN1h4dWI4aWJzbDZqRWZsZG43dXovQ1MrUllX?=
 =?big5?B?d09POUxBQVM3MG1MeGVBa0l1OTEyWUNpTC93N2h2b3U2SWdNa0w3YytTckcwbzE3?=
 =?big5?B?aE5nSEcwNjZTZU5qNWtBTUw0VXlRbTViNUpZMWFxUUwyZXlWYmxYSDFNOUpjVEkz?=
 =?big5?B?bS9Wb2I1eHZtRHNYa0ZISUsyWDZFZlhzTVFBZ3U3TlVHdkMvSmpyKzBycVJ2Ylpr?=
 =?big5?B?ZDlBSUJzWkUrVlZEUHVXK3dBMU1CYnh4b1lxcTNOVHpXdDU2UHNQcnJRZTFHQ3B3?=
 =?big5?B?UE9Fayt1bTdES21vMWFRelJWZ2lwd3BxUWtqTk0rNHV6dDBYWGZWYWxlTlQxWTBp?=
 =?big5?B?Ump1b1g4bVp6dmRTTE1lNlc5VEp2aFluY2p4K1NlWUNXVFV1NU5RcTIvNnNPYm9T?=
 =?big5?B?YTFTTVNrMCtjZnB2eGlBNExXcXVINnBXWlNiaWN5dkVxVEUwSmJlcWlVR0dmT3M2?=
 =?big5?B?Nzh3cjlwRTMwMmE4Z2ZIZi9rQjNKRVhCbmJ0UUsyRFM3NFI1MUVKdDhwV2wxbTBU?=
 =?big5?B?NENDN3ZoZS8vNTBud3hzdGpSMk1IZWU0SjBxRmNCOXlwc2EvenNrVG5Tcmg3VGRz?=
 =?big5?B?RFBYLy8wSi81bEwya2dEME5HdUlCQzFhNjN1dWwxTjJPQzZub2NZdk5QUjdwWElD?=
 =?big5?B?NGhOMzAyQlFOU1FEWEt5RC84ekZZUDM1NmVMNW9mREQ1SXFQS1ozTWJUQ1FvQW85?=
 =?big5?B?ay8yUEtKaDU0MGJhUHIwZlJDVU95YUdXRFpqejVMaVR1czdJenNvR2l4VnRhbFdP?=
 =?big5?B?WHFhenYxbnZIZ0o5TWlySDJkNXhsbklvWGxzOVcxcFJ6djM3bzV0MGd0QWxrQ3Bk?=
 =?big5?B?WFlXd2R3b0FXL3Jka2hKWjdPQVFuTk10OWJrL1NZc0RzMStnYVljMWVFS1ZyQm9t?=
 =?big5?B?eUI0cWN3dlAzeGkxZ3dodmVQWk1vYUd4VTBSR3NwVFlVVHlPZXA5bW43N2hUQ0Rr?=
 =?big5?B?RnFRZUh0WTJyLzRYa0tuYUoraUFPMjBvenMySXpGbkd2QUZKTTRNSlBXUlhTV2Z2?=
 =?big5?B?c0dWT1ZHMzJVWHdyNTUyOGwvRDE3dXpoWDhtZnJqL1FNTWtlTmxUOHNmZGFJM3F1?=
 =?big5?B?bm1uS2FlUFFMY1JMa2x1U2tSaTlScWJHRDluM0dHeTNCcjgwVnhlek4vN3VobFdP?=
 =?big5?B?YzlGbGdSWEdvaGMrSDlROXhEZmlQQVg2bUVxZURMTnJROEw2MU9LMDBwbm51bnNP?=
 =?big5?B?ZWVqYmJaUG1hSG4veG1NT3JKZUE5RVlac3Z2WVl1OXh2WlJIZS96M0Z4NjgwV1g5?=
 =?big5?B?QTFCNnE4dkg5bm9xTEJvb3ZGMTZTRjZiSy9XUURiY2tabnpGU3p0T0dTVkxNaFNp?=
 =?big5?B?WUJsOCtTTDM5bUc1dWhwMUpJcjhnM1NMOUpHWU1JbDFSM2REeStOQVY1ZENacE1F?=
 =?big5?B?YkYzSGlVVkkrWU9TUnlOemliQU1wSkpneEtITFEySVNoVFZpdS9YaFNXQlA4UGtQ?=
 =?big5?B?SDYzRDVkZVRZOTdYQjNJc3NrWllvam5HUEZmYkRtNXVEL1VXR2Y5OUZ3Z3VKaHJS?=
 =?big5?B?b3luRjU5Rmp2ZmtxaW9XbTBiRW5zVm9nMFlKTE5DZjRUeTVrdVgxemxoczFzVUYy?=
 =?big5?B?aHJIN3Njd1F6aWlRR1NLK0tRTHh0Q2w4K1FIakxDbHBKcDZyUit4QXRoOWo5cnNa?=
 =?big5?B?dWthc24wWmxHVDJZWXZvNU1DYjJvZEdPcGNoS2c1MTkxVk5keU5QaHVHZ1BXMEFt?=
 =?big5?B?dWY5UVAzUGFLRU05akU4VHNBTnhTRzFKNUNaaDlQTDI3UGJYU011YzNyZjVIMmFk?=
 =?big5?Q?pHHsSYTmFi2fxPB6?=
Content-Type: text/plain; charset="big5"
Content-Transfer-Encoding: base64
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-OriginatorOrg: aspeedtech.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: SEYPR06MB5134.apcprd06.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 61f119a4-2ede-4fa3-c17d-08dd07a506ee
X-MS-Exchange-CrossTenant-originalarrivaltime: 18 Nov 2024 07:45:52.3583
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 43d4aa98-e35b-4575-8939-080e90d5a249
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 3tAhwZFMuYMVmDPiJ+LvnAaSMDrEXURIrEN7dF/BqMGLbDPKaVk59xWidC6pZr24O2uCKrh9oJSlOe1XF8CYn4TJ2HGD0qUj5YEOxwoMZ2Y=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: JH0PR06MB7031

SGkgQXJuZCwNCg0KVGhhbmsgeW91IGZvciB5b3UgcmVwbHkuDQoNCj4gPiAgCX0NCj4gPg0KPiA+
ICAJaWYgKHByaXYtPmlzX2FzcGVlZCkgew0KPiA+ICsJCXN0cnVjdCByZXNldF9jb250cm9sICpy
c3Q7DQo+ID4gKw0KPiA+ICAJCWVyciA9IGZ0Z21hYzEwMF9zZXR1cF9jbGsocHJpdik7DQo+ID4g
IAkJaWYgKGVycikNCj4gPiAgCQkJZ290byBlcnJfcGh5X2Nvbm5lY3Q7DQo+ID4NCj4gPiArCQly
c3QgPSBkZXZtX3Jlc2V0X2NvbnRyb2xfZ2V0X29wdGlvbmFsKHByaXYtPmRldiwgTlVMTCk7DQo+
ID4gKwkJaWYgKElTX0VSUihyc3QpKQ0KPiA+ICsJCQlnb3RvIGVycl9yZWdpc3Rlcl9uZXRkZXY7
DQo+ID4gKwkJcHJpdi0+cnN0ID0gcnN0Ow0KPiA+ICsNCj4gPiArCQllcnIgPSByZXNldF9jb250
cm9sX2Fzc2VydChwcml2LT5yc3QpOw0KPiANCj4gU2luY2UgdGhhdCByZXNldCBsaW5lIGlzIG9w
dGlvbmFsLCBob3cgYWJvdXQgbWFraW5nIGl0IHBhcnQgb2YgdGhlIG5vcm1hbCBwcm9iZQ0KPiBw
cm9jZWR1cmUsIG5vdCBqdXN0IHRoZSBpZihhc3BlZWQpIHNlY3Rpb24/IEl0IHNlZW1zIHRoaXMg
ZG9lcyBub3RoaW5nIGZvciBvbGRlcg0KPiBkZXZpY2VzIGJ1dCBtYXkgaGVscCBmb3IgZnV0dXJl
IG9uZXMgcmVnYXJkbGVzcyBvZiB0aGUgU29DIGZhbWlseS4NCg0KQWdyZWUuDQpCZWNhdXNlIGl0
IGlzIG9wdGlvbmFsLCBldmVuIGlmIHJlc2V0IGxpbmUgZG9lcyBub3QgZXhpc3Qgb24gb3RoZXIg
U29DcywgaXQgd2lsbCANCm5vdCBhZmZlY3QgdGhlIGJlaGF2aW9yIG9mIHRoZSBjb2RlLg0KVGhh
bmsgeW91IGZvciBwb2ludGluZyB0aGlzIG91dC4NCkkgd2lsbCBhZGp1c3QgaXQgdG8gbm9ybWFs
IHByb2JlIHByb2NlZHVyZSBpbiBuZXh0IHZlcnNpb24uDQpPciBJIHdpbGwgc2VwYXJhdGUgaXQg
ZnJvbSBBc3BlZWQgQVNUMjcwMCBzdXBwb3J0IHNlcmllcy4NCg0KSmFja3kNCg==

