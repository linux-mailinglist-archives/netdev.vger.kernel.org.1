Return-Path: <netdev+bounces-212875-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 5109AB2259A
	for <lists+netdev@lfdr.de>; Tue, 12 Aug 2025 13:15:51 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id ED3CE3A4DDC
	for <lists+netdev@lfdr.de>; Tue, 12 Aug 2025 11:12:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 498462ECD3C;
	Tue, 12 Aug 2025 11:12:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=adtran.com header.i=@adtran.com header.b="XoG7n8Tr"
X-Original-To: netdev@vger.kernel.org
Received: from BEUP281CU002.outbound.protection.outlook.com (mail-germanynorthazon11020080.outbound.protection.outlook.com [52.101.169.80])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 260182EBB9B;
	Tue, 12 Aug 2025 11:12:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.169.80
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754997140; cv=fail; b=VYdEf2H1N1g0Vz32CGcS0sPtdxWNtXJjETXUiaFUs/7MBahomH854XSyD5A6xTtcSSNgZDXqe6BzmMIjPIeZjsdTe2KJtFaNmkrCbcPxC5WrHBp5AprRSb3eBKH6TfU+NW+LwqzclNq07h7Zv/t5xRzpOyBbdU1OzK+FfxCDJK8=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754997140; c=relaxed/simple;
	bh=NhLENZPWwRjHzqDtN7qFh1gAqpoMArAu7BtEqXTe460=;
	h=From:To:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=pxehqTsXtQTeYPuTTPWWUqW2kvlF664jIA3HgCtWpN07pRxuWrQElTttEp1SuYNNSZuClbDvtgN+0ayLvGX+2B+bUPa0bDehwsg2279c6REt5Qy/K+ANA4bwOTgKppDrlyKIpp2moo/iAW6+0k0Z0VENC2SZTT6HVCUbrLomhaw=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=adtran.com; spf=pass smtp.mailfrom=adtran.com; dkim=pass (1024-bit key) header.d=adtran.com header.i=@adtran.com header.b=XoG7n8Tr; arc=fail smtp.client-ip=52.101.169.80
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=adtran.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=adtran.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=RDRtZnikPsXfb5p5KAiRPRg1ynZQyySSPw0ppE6UxL4LIbTlSDTdI7hlcDCgywqlS8e4oEB4WzkKYUlOdZ5aN1ja6jgcYcxTFk0vrNU0jBB/Mrf4OAaaRJi8ml13w5qEKHeRUU8LFukfkcgCk27epMkNdMGM7NiJfIZgDUPZMHde3K6GG13F6jOzR/3DMheVmk7//v0EN0UUJu4muMcFPczjps8KCTY31zV4goqAwgc2WZMeDBZeV4ovhwBb6LgMQylNllTy5H3OrDHxeP99spA2MJLza3rrTOnac9QU+JoZs58OIrJDEf56+Ez5L3OBzvAiaV2Wl/9DNePTzm8amw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=NhLENZPWwRjHzqDtN7qFh1gAqpoMArAu7BtEqXTe460=;
 b=hmAYW8XgCWcqinh7ST33cbt0CRTBCcBmJs+1YYbRnY3NdD/tRXMy+1X5q/B2K3HeIqy74f15D7UCvLkgMTSSzw67bnG/5Gze0BnJ0Jm5Rtxo/rXXJeZuHRAA5VjkZt1YZoGE2WGHUKIA5QrssCpXW7AcECaByFeERLrgYE0Vnbk5+uuWX8RsSOxQpAJ2GTzd11WYPaoJYfIC/BjuntGOiqRzzyLxUckGNSLXeCsfqpdhJuLrutGN0ltiVHCGNQrck5qz3kzqWpG3AZgANSELktNv1eivomD3zQ7khj+pIZeT2lBNsuhaXesybMnjlu/cZ7vicEGwncPXAX9hl8j6sw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=adtran.com; dmarc=pass action=none header.from=adtran.com;
 dkim=pass header.d=adtran.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=adtran.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=NhLENZPWwRjHzqDtN7qFh1gAqpoMArAu7BtEqXTe460=;
 b=XoG7n8TrGXJtNLFd0APiu1oWPbWV9SFrFYbcz8jWjFt01/h7zZVWoO6CWKK3BZ2emHzg48/3zJi9eAu3L/8BDfRnGFCvk4f7CkBmfmIAHCIOOMZRjePgKGqklsPZpt7iasX88QpV2JRoVz/nW5q1bR5r/MC90ZhHSJTHL6ZoBZ4=
Received: from FR3PPF3200C8D6F.DEUP281.PROD.OUTLOOK.COM (2603:10a6:d18:2::126)
 by FR5P281MB4300.DEUP281.PROD.OUTLOOK.COM (2603:10a6:d10:117::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9009.22; Tue, 12 Aug
 2025 11:12:14 +0000
Received: from FR3PPF3200C8D6F.DEUP281.PROD.OUTLOOK.COM
 ([fe80::92f0:48d2:2be9:13c6]) by FR3PPF3200C8D6F.DEUP281.PROD.OUTLOOK.COM
 ([fe80::92f0:48d2:2be9:13c6%2]) with mapi id 15.20.9009.021; Tue, 12 Aug 2025
 11:12:14 +0000
From: Piotr Kubik <piotr.kubik@adtran.com>
To: Oleksij Rempel <o.rempel@pengutronix.de>, Kory Maincent
	<kory.maincent@bootlin.com>, Andrew Lunn <andrew+netdev@lunn.ch>, "David S.
 Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, Jakub
 Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, Rob Herring
	<robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley
	<conor+dt@kernel.org>, "netdev@vger.kernel.org" <netdev@vger.kernel.org>,
	"devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: [PATCH net-next v6 1/2] dt-bindings: net: pse-pd: Add bindings for
 Si3474 PSE controller
Thread-Topic: [PATCH net-next v6 1/2] dt-bindings: net: pse-pd: Add bindings
 for Si3474 PSE controller
Thread-Index: AQHcC3n0zXGFQsL+jk+Et3nG2SZWLQ==
Date: Tue, 12 Aug 2025 11:12:14 +0000
Message-ID: <1ecdf826-3483-4cbe-a4c5-eefbf47c7a8e@adtran.com>
References: <2378ee79-db60-45fb-9077-f21e8f7571eb@adtran.com>
In-Reply-To: <2378ee79-db60-45fb-9077-f21e8f7571eb@adtran.com>
Accept-Language: pl-PL, en-US
Content-Language: pl-PL
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=adtran.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: FR3PPF3200C8D6F:EE_|FR5P281MB4300:EE_
x-ms-office365-filtering-correlation-id: a9284c10-8f62-47ae-b585-08ddd9911765
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam:
 BCL:0;ARA:13230040|7416014|1800799024|376014|366016|38070700018|921020;
x-microsoft-antispam-message-info:
 =?utf-8?B?c3E0MG1ML1g3d2FLTnUxM3J4TjlMc1RSVEdyRERnRGRFWW9MS3lINi9Ba3hF?=
 =?utf-8?B?ZzNjbGRNR2tVVEE0eElHdUlvU2hLUGNnd0dqd3NrSkwyREF2Wm5zbHBlZjRy?=
 =?utf-8?B?UC9zYlB3YXdIVUVJeURRbVJQWStrMWUydlBoSndvTHFuZFBWVjlWbW5EOWxv?=
 =?utf-8?B?ZmFVTzFoOFcrZ2VIWUI2VElHSFZuWk5KRlNNRXQ2YUhLY3F1d0tpZkg2aEVT?=
 =?utf-8?B?dDJaZzRqMGFPVU1aamdhNzZyMW12ODlUNVlyeWFiYXVCbVU1WUUxSlptY1dv?=
 =?utf-8?B?Wk9KanlyOG93RWtOVlRxNDFFZFVqT2VYN3hkNmpFLzNJQTNEL0lMYjRzamhn?=
 =?utf-8?B?NHBJVWJPUWwzN1pCcTd3YlFLMDVvcjVmWnRRdkdHRFp6cWZtSnpud3JuQWVa?=
 =?utf-8?B?UHBXR3A2WXZsZTFrdjlKbUs5TkRGdkxITjdORlhRTVZZc1l0WUtrMThweE5i?=
 =?utf-8?B?UlB5c282ZVV1Nlh1Z21wZnk2bU9xWHpVOXo1bGxQNTd0enVxSlNjTHk3OEFT?=
 =?utf-8?B?cTc2OHZobEd3bGZIVEJLYXdhOHZPSnpQWmRVaG16RGdZVWpjbVdydldKcHJt?=
 =?utf-8?B?WDFOc2RmU1laYU5tMnkrQmovKzA0QWl3VU5EWXlPdkk1eEJYWjBEaVArd2xX?=
 =?utf-8?B?WHVKcUYrZmpmTUNraXZsOWxzVzZVS3Z1d0VuaEZmWUtXcEZDd0U0YzNPQktE?=
 =?utf-8?B?MU16dTRLS2loc1p2UnVZMUI0NDRENEE2VzNabDUyK1dHOWZQZm53TzBHMGxy?=
 =?utf-8?B?dHd3RldjZXpYSExzMHFhcHlySnFLQnVYdjd6WXFkd2hmb0V6a056ZVRSWmJq?=
 =?utf-8?B?akdpRmFmY3JKWkpjUEx4V1hORkRibHdPNjZMQ0M1QXZ2WFRuRzl4SS9uU2Fo?=
 =?utf-8?B?UjJBd2RIUmZaeVdPTnRUQTdPYzF2U3NXOUVwc3ZSVFZFQlM3WmtnUW9NOFJE?=
 =?utf-8?B?YlJlUnh4TzNTclhlSVpmRzNKcDY2Wk1ONyt5d0dCd1IrWHArbXA3QldUQ2xz?=
 =?utf-8?B?dGtiUUM2S2taSkVoc250dkRXMUtIbDh4ajllYXFvK1I3OW12bklLeGFRODBt?=
 =?utf-8?B?SnJrdHJJRGV2YTFRb0pOemVBdFdSKzB5QTZJTW8ySWRuY3AzWWQ1WkpqRktX?=
 =?utf-8?B?UEp0ckN3YXNWWTNNZkhvS2xiMExzSVM1Ly9MRW4xVUZua0ZiWVhQbW1NQzdH?=
 =?utf-8?B?bjU5RmMrSCtEU2hhbS80eEVOWjZ4Kzk2UlFWdzA1VHJUTGNVMDJKZWdMQjVu?=
 =?utf-8?B?dGN4Nzg5bE0yT2FKTVd0Qjc5aytnREc0NXhCcWYzS1RrUWhTY0lDODRRUGNp?=
 =?utf-8?B?U3dWcmZ6cURtVjYxeDQ4a1M4N0t3c1dKcHBLajF5QWRVYmdYZkQ2aHo5SGdT?=
 =?utf-8?B?OE9GSm5nVk5EbG5XeWE4OHZOSlBUZmtpc0xKM3JMbWFoNXIvTmUwT1pHQnIv?=
 =?utf-8?B?a1V3SDcxRWJOUVEwUjhhWGIzTVYxZU54QXl1T0wxTWcxWTFqbTUzUGNwRk85?=
 =?utf-8?B?Q1p4ZWNIQ2dodm0vU1NubjhCZTBGUHRTTVRQMXNnTXNkeS9sanhiSmlYRmpq?=
 =?utf-8?B?L3g3eHBXelo0VW5RVDlOWk5IbDROUjV0UFRZQm02SHkyUlZWYkVodE9RT0tZ?=
 =?utf-8?B?ZUMvNTRsNC9LUGozTWxoTnBiSDVhRmNkQUNGWStyZldPRGtoaHNyZ2pXaDVz?=
 =?utf-8?B?SFFjV2VxY1UxSzZzRUplVWQ5NzhTNTc0SmlJVU53Y005MWEzRE1RUWQ3N3Zj?=
 =?utf-8?B?VmFxcURrSlkxdTZzQ09qRHdya2dRSW8xVm9yQUkzVkhhU1QvN1FiVDV4bVFu?=
 =?utf-8?B?T3JEVUFsOG1wbnJYVVlqTzQ5a0xIbi9CNWEzZWsrRWp2YU9ZVDgzQ1oxc3g4?=
 =?utf-8?B?ZEpGdGFDS0gwcmtCcGk0bjNKMkQ3bnJMTDhaL2VSNDdxdkRRbU9xNS9OejhM?=
 =?utf-8?Q?Q8GlUS3EY70bDN0nWfXAZ0vV592RQ2FT?=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:FR3PPF3200C8D6F.DEUP281.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230040)(7416014)(1800799024)(376014)(366016)(38070700018)(921020);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?utf-8?B?MDBNWENZMTBTZnlSdktLeXd6dkJDQTk2aVpPb3E0aXV4TFlINWNNai8waFZv?=
 =?utf-8?B?YWhsRGVBN0czazBlQk5JWWxRWWpKeXpFZ21xYWM2dEo0VTBMLzNvRXhmYVJN?=
 =?utf-8?B?RXJtNnVSVDdiM2x3VUQyR2lSaFlkcEpoa2ltS01VaEZLT2lwdTJKQUJxMnhR?=
 =?utf-8?B?Y1N2VEdwMy9sMW50dWptZXlwang3UGc3WDJGR2hKdXR1dTZkeTJ1dDRobENN?=
 =?utf-8?B?a0VneDEvencrZDNqZXN2OFFRTjhDMWdSMGUycHdkbURoNXJBbkZoR1Q5YnJl?=
 =?utf-8?B?VTZwTVJNc3NZTkhPL004bWo0SG92emVaNkc5VmUwcFZDMjhSVnVMYTlIcURV?=
 =?utf-8?B?OFNOQzErRDhzTHJNZTZmbWR5TGVYQ1FiKytRSjB1dGp1V3ROWGNudG9meXVJ?=
 =?utf-8?B?a0NqZ1phMXNyeEloa3RQb210VkliTWxURmx0Yml6c3Jsdk9xZmV2aERPZzBI?=
 =?utf-8?B?UGZvbnFYcmV4anVIWUUvRDBOdnpsSzUwT3QrWEpueTNxdmNXVjFkTG5EWjZr?=
 =?utf-8?B?elZPeTk1eVpDWnlwRHdkMHhhTDFUSVF6Z00wR013engzNnpMWENIeWIrL2o0?=
 =?utf-8?B?ZVA3MUg1S2EyNGxxOVhLcDY1THRaYmwzNVpqTjBuTExvNEUxK05FYldjc0Vz?=
 =?utf-8?B?QktIQ05zZStBYlNlNkRES2VHNTdjY3U1VDNwS25uM0NLQ0FNVDVtQk0yQUFC?=
 =?utf-8?B?ckRPa3hFS0VQVFhDQzZBL3Q4dDFsSzR1YUw0WStYS3FrVVpFUDlvOUhSc0Zi?=
 =?utf-8?B?ZVVhbXNwSXY5ejFHeU5waUVNaXNwY2tRWm16cjVtdnMyUmRRQ3pSc0c4ZG1n?=
 =?utf-8?B?QkxEWVB5Sm9OOFhuYVcrcWl6dGpjYTFpMnQxUnVhc0FTZVlzdE1HQjY2NklP?=
 =?utf-8?B?Y2diblh6bkFzZkZNN3RpMnRFdFhZQzk5VUFUdkJzTHhMekUzZUczQXU3VXVJ?=
 =?utf-8?B?U1FyeG9mcHVlbmg0Nm8xeHJaSnJIcUtCanF5Wlk1UmxqOE9La2d4WGpLS1hN?=
 =?utf-8?B?Z3VLaUh4VmpNbS9PblR1d2NBdnlpVnJsWDRKRDJFTU5SRGVjM1JTTUZCTW5I?=
 =?utf-8?B?YXIrVlZwZVpvd2hlQzZ3UEFjb0FrQ2M2d2ZJUVZOV00zSGZaUGxZcmY0aCsx?=
 =?utf-8?B?TkJiOEFpWGVveDFHUGozczllRFluaDBycWlyOWRXb09FaUMxclkwalhYM0Yx?=
 =?utf-8?B?cTRHU1VrYWtWalgxaW9lbm4vTXdjc2k5RjlRbVUzN1NnRi9uQjcxeSt4RzRX?=
 =?utf-8?B?TUZtSnozUUJuZXlMYjFqcjIyQjk4aEF3TEdkcnVwanFxaVlMVmJJWWFSUU45?=
 =?utf-8?B?WWxvZE5mYWZ4dWI3YnN4UzIvR3dwWVRPancwcTArd0hxeHp4NHM2djh5cGRm?=
 =?utf-8?B?bWdXWGlXdWlGQWIzTU9nTjk1YUlXU3ZOQklJZzYxRXU2L3RoYTBnVUR5SnV6?=
 =?utf-8?B?dVhwTWJUL056SE9ucklicTI2eWVqQ1lmNlZMS2IyUFJ4SkZWTEM5Yy9qM1VM?=
 =?utf-8?B?enY3N1FpMDVYRXFtY2lHQTZIY2hYUCtiTXVVanQzaStLSkJZNHAxUjJtN01P?=
 =?utf-8?B?T2FtT3I2SUVSV2RyVUU1eTNOVXRPeWhGWGJhSzFURGtrbjljajlJaFJCNkx4?=
 =?utf-8?B?Tjl2YjM1SzdBcm1hN0RNYlpIR1RpVjZwWC9jZUdwSGMwSGJYQkhKT2tzcFNo?=
 =?utf-8?B?ZklTNm9tdGR6T1M2M2tUOXFrR0ZYcngvOEVUNFNiUWVKMDdsakVTOFRVamJR?=
 =?utf-8?B?aW4zd3p1M2lJbmRGd0pLWkQwM0JoeW92YTlCWGNjSm9sNVBpT0xObFErdEFY?=
 =?utf-8?B?SkdzUUlHSEZwVWlOdkxxVHVlM3RJMEFGWENKbVF1NlMzL0Zqd005SVFPOThQ?=
 =?utf-8?B?NnZmUzdnUEhKTTNGOW5uaXdLNTVjenVENkR6KzhYdlo1d3BaMXpWV3pFY1BZ?=
 =?utf-8?B?Zmdpd3FwakpyZzVwNldmY0g5a1RwR3NQSE1UcTFRQkpwL2VZcFFncExQRFJl?=
 =?utf-8?B?K0JLUTNHblUxZVc4aWFMdk5xVjBLaldnbWZKbGlPZXMxRnFmd2NDWVA4OVpL?=
 =?utf-8?B?Rnphc0h1OVdoVldIMkV1dmxkZmMyYmQ5SFppM0IvaS8xM2tTYTBteGhJOFNS?=
 =?utf-8?Q?7Rzyfky8cs6c7yTvRF9Q9oWXa?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <74CFB6BD4BCD3F4D842709733D563F71@DEUP281.PROD.OUTLOOK.COM>
Content-Transfer-Encoding: base64
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-OriginatorOrg: adtran.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: FR3PPF3200C8D6F.DEUP281.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-Network-Message-Id: a9284c10-8f62-47ae-b585-08ddd9911765
X-MS-Exchange-CrossTenant-originalarrivaltime: 12 Aug 2025 11:12:14.2471
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 423946e4-28c0-4deb-904c-a4a4b174fb3f
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: WyWMrpfi8fJRMouQXjdPASpyFVU7T/PZWG/eXrX4Of4OARxUNX16x904BGf/yHESqVdaYzpyUYJQQUo3kfo6BQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: FR5P281MB4300

RnJvbTogUGlvdHIgS3ViaWsgPHBpb3RyLmt1YmlrQGFkdHJhbi5jb20+DQoNCkFkZCB0aGUgU2kz
NDc0IEkyQyBQb3dlciBTb3VyY2luZyBFcXVpcG1lbnQgY29udHJvbGxlciBkZXZpY2UgdHJlZQ0K
YmluZGluZ3MgZG9jdW1lbnRhdGlvbi4NCg0KU2lnbmVkLW9mZi1ieTogUGlvdHIgS3ViaWsgPHBp
b3RyLmt1YmlrQGFkdHJhbi5jb20+DQpSZXZpZXdlZC1ieTogS3J6eXN6dG9mIEtvemxvd3NraSA8
a3J6eXN6dG9mLmtvemxvd3NraUBsaW5hcm8ub3JnPg0KUmV2aWV3ZWQtYnk6IEtvcnkgTWFpbmNl
bnQgPGtvcnkubWFpbmNlbnRAYm9vdGxpbi5jb20+DQotLS0NCg0KQ2hhbmdlcyBpbiB2MzoNCiAg
LSBVcGRhdGUgY2hhbm5lbCBub2RlIGRlc2NyaXB0aW9uLg0KICAtIFJlb3JkZXIgcmVnIGFuZCBy
ZWctbmFtZXMgcHJvcGVydGllcy4NCiAgLSBSZW5hbWUgYWxsICJzbGF2ZSIgcmVmZXJlbmNlcyB0
byAic2Vjb25kYXJ5Ii4NCg0KLS0tDQogLi4uL2JpbmRpbmdzL25ldC9wc2UtcGQvc2t5d29ya3Ms
c2kzNDc0LnlhbWwgIHwgMTQ0ICsrKysrKysrKysrKysrKysrKw0KIDEgZmlsZSBjaGFuZ2VkLCAx
NDQgaW5zZXJ0aW9ucygrKQ0KIGNyZWF0ZSBtb2RlIDEwMDY0NCBEb2N1bWVudGF0aW9uL2Rldmlj
ZXRyZWUvYmluZGluZ3MvbmV0L3BzZS1wZC9za3l3b3JrcyxzaTM0NzQueWFtbA0KDQpkaWZmIC0t
Z2l0IGEvRG9jdW1lbnRhdGlvbi9kZXZpY2V0cmVlL2JpbmRpbmdzL25ldC9wc2UtcGQvc2t5d29y
a3Msc2kzNDc0LnlhbWwgYi9Eb2N1bWVudGF0aW9uL2RldmljZXRyZWUvYmluZGluZ3MvbmV0L3Bz
ZS1wZC9za3l3b3JrcyxzaTM0NzQueWFtbA0KbmV3IGZpbGUgbW9kZSAxMDA2NDQNCmluZGV4IDAw
MDAwMDAwMDAwMC4uZWRkMzZhNDNhMzg3DQotLS0gL2Rldi9udWxsDQorKysgYi9Eb2N1bWVudGF0
aW9uL2RldmljZXRyZWUvYmluZGluZ3MvbmV0L3BzZS1wZC9za3l3b3JrcyxzaTM0NzQueWFtbA0K
QEAgLTAsMCArMSwxNDQgQEANCisjIFNQRFgtTGljZW5zZS1JZGVudGlmaWVyOiAoR1BMLTIuMC1v
bmx5IE9SIEJTRC0yLUNsYXVzZSkNCislWUFNTCAxLjINCistLS0NCiskaWQ6IGh0dHA6Ly9kZXZp
Y2V0cmVlLm9yZy9zY2hlbWFzL25ldC9wc2UtcGQvc2t5d29ya3Msc2kzNDc0LnlhbWwjDQorJHNj
aGVtYTogaHR0cDovL2RldmljZXRyZWUub3JnL21ldGEtc2NoZW1hcy9jb3JlLnlhbWwjDQorDQor
dGl0bGU6IFNreXdvcmtzIFNpMzQ3NCBQb3dlciBTb3VyY2luZyBFcXVpcG1lbnQgY29udHJvbGxl
cg0KKw0KK21haW50YWluZXJzOg0KKyAgLSBQaW90ciBLdWJpayA8cGlvdHIua3ViaWtAYWR0cmFu
LmNvbT4NCisNCithbGxPZjoNCisgIC0gJHJlZjogcHNlLWNvbnRyb2xsZXIueWFtbCMNCisNCitw
cm9wZXJ0aWVzOg0KKyAgY29tcGF0aWJsZToNCisgICAgZW51bToNCisgICAgICAtIHNreXdvcmtz
LHNpMzQ3NA0KKw0KKyAgcmVnOg0KKyAgICBtYXhJdGVtczogMg0KKw0KKyAgcmVnLW5hbWVzOg0K
KyAgICBpdGVtczoNCisgICAgICAtIGNvbnN0OiBtYWluDQorICAgICAgLSBjb25zdDogc2Vjb25k
YXJ5DQorDQorICBjaGFubmVsczoNCisgICAgZGVzY3JpcHRpb246IFRoZSBTaTM0NzQgaXMgYSBz
aW5nbGUtY2hpcCBQb0UgUFNFIGNvbnRyb2xsZXIgbWFuYWdpbmcNCisgICAgICA4IHBoeXNpY2Fs
IHBvd2VyIGRlbGl2ZXJ5IGNoYW5uZWxzLiBJbnRlcm5hbGx5LCBpdCdzIHN0cnVjdHVyZWQNCisg
ICAgICBpbnRvIHR3byBsb2dpY2FsICJRdWFkcyIuDQorICAgICAgUXVhZCAwIE1hbmFnZXMgcGh5
c2ljYWwgY2hhbm5lbHMgKCdwb3J0cycgaW4gZGF0YXNoZWV0KSAwLCAxLCAyLCAzDQorICAgICAg
UXVhZCAxIE1hbmFnZXMgcGh5c2ljYWwgY2hhbm5lbHMgKCdwb3J0cycgaW4gZGF0YXNoZWV0KSA0
LCA1LCA2LCA3Lg0KKw0KKyAgICB0eXBlOiBvYmplY3QNCisgICAgYWRkaXRpb25hbFByb3BlcnRp
ZXM6IGZhbHNlDQorDQorICAgIHByb3BlcnRpZXM6DQorICAgICAgIiNhZGRyZXNzLWNlbGxzIjoN
CisgICAgICAgIGNvbnN0OiAxDQorDQorICAgICAgIiNzaXplLWNlbGxzIjoNCisgICAgICAgIGNv
bnN0OiAwDQorDQorICAgIHBhdHRlcm5Qcm9wZXJ0aWVzOg0KKyAgICAgICdeY2hhbm5lbEBbMC03
XSQnOg0KKyAgICAgICAgdHlwZTogb2JqZWN0DQorICAgICAgICBhZGRpdGlvbmFsUHJvcGVydGll
czogZmFsc2UNCisNCisgICAgICAgIHByb3BlcnRpZXM6DQorICAgICAgICAgIHJlZzoNCisgICAg
ICAgICAgICBtYXhJdGVtczogMQ0KKw0KKyAgICAgICAgcmVxdWlyZWQ6DQorICAgICAgICAgIC0g
cmVnDQorDQorICAgIHJlcXVpcmVkOg0KKyAgICAgIC0gIiNhZGRyZXNzLWNlbGxzIg0KKyAgICAg
IC0gIiNzaXplLWNlbGxzIg0KKw0KK3JlcXVpcmVkOg0KKyAgLSBjb21wYXRpYmxlDQorICAtIHJl
Zw0KKyAgLSBwc2UtcGlzDQorDQordW5ldmFsdWF0ZWRQcm9wZXJ0aWVzOiBmYWxzZQ0KKw0KK2V4
YW1wbGVzOg0KKyAgLSB8DQorICAgIGkyYyB7DQorICAgICAgI2FkZHJlc3MtY2VsbHMgPSA8MT47
DQorICAgICAgI3NpemUtY2VsbHMgPSA8MD47DQorDQorICAgICAgZXRoZXJuZXQtcHNlQDI2IHsN
CisgICAgICAgIGNvbXBhdGlibGUgPSAic2t5d29ya3Msc2kzNDc0IjsNCisgICAgICAgIHJlZy1u
YW1lcyA9ICJtYWluIiwgInNlY29uZGFyeSI7DQorICAgICAgICByZWcgPSA8MHgyNj4sIDwweDI3
PjsNCisNCisgICAgICAgIGNoYW5uZWxzIHsNCisgICAgICAgICAgI2FkZHJlc3MtY2VsbHMgPSA8
MT47DQorICAgICAgICAgICNzaXplLWNlbGxzID0gPDA+Ow0KKyAgICAgICAgICBwaHlzMF8wOiBj
aGFubmVsQDAgew0KKyAgICAgICAgICAgIHJlZyA9IDwwPjsNCisgICAgICAgICAgfTsNCisgICAg
ICAgICAgcGh5czBfMTogY2hhbm5lbEAxIHsNCisgICAgICAgICAgICByZWcgPSA8MT47DQorICAg
ICAgICAgIH07DQorICAgICAgICAgIHBoeXMwXzI6IGNoYW5uZWxAMiB7DQorICAgICAgICAgICAg
cmVnID0gPDI+Ow0KKyAgICAgICAgICB9Ow0KKyAgICAgICAgICBwaHlzMF8zOiBjaGFubmVsQDMg
ew0KKyAgICAgICAgICAgIHJlZyA9IDwzPjsNCisgICAgICAgICAgfTsNCisgICAgICAgICAgcGh5
czBfNDogY2hhbm5lbEA0IHsNCisgICAgICAgICAgICByZWcgPSA8ND47DQorICAgICAgICAgIH07
DQorICAgICAgICAgIHBoeXMwXzU6IGNoYW5uZWxANSB7DQorICAgICAgICAgICAgcmVnID0gPDU+
Ow0KKyAgICAgICAgICB9Ow0KKyAgICAgICAgICBwaHlzMF82OiBjaGFubmVsQDYgew0KKyAgICAg
ICAgICAgIHJlZyA9IDw2PjsNCisgICAgICAgICAgfTsNCisgICAgICAgICAgcGh5czBfNzogY2hh
bm5lbEA3IHsNCisgICAgICAgICAgICByZWcgPSA8Nz47DQorICAgICAgICAgIH07DQorICAgICAg
ICB9Ow0KKyAgICAgICAgcHNlLXBpcyB7DQorICAgICAgICAgICNhZGRyZXNzLWNlbGxzID0gPDE+
Ow0KKyAgICAgICAgICAjc2l6ZS1jZWxscyA9IDwwPjsNCisgICAgICAgICAgcHNlX3BpMDogcHNl
LXBpQDAgew0KKyAgICAgICAgICAgIHJlZyA9IDwwPjsNCisgICAgICAgICAgICAjcHNlLWNlbGxz
ID0gPDA+Ow0KKyAgICAgICAgICAgIHBhaXJzZXQtbmFtZXMgPSAiYWx0ZXJuYXRpdmUtYSIsICJh
bHRlcm5hdGl2ZS1iIjsNCisgICAgICAgICAgICBwYWlyc2V0cyA9IDwmcGh5czBfMD4sIDwmcGh5
czBfMT47DQorICAgICAgICAgICAgcG9sYXJpdHktc3VwcG9ydGVkID0gIk1ESS1YIiwgIlMiOw0K
KyAgICAgICAgICAgIHZwd3Itc3VwcGx5ID0gPCZyZWdfcHNlPjsNCisgICAgICAgICAgfTsNCisg
ICAgICAgICAgcHNlX3BpMTogcHNlLXBpQDEgew0KKyAgICAgICAgICAgIHJlZyA9IDwxPjsNCisg
ICAgICAgICAgICAjcHNlLWNlbGxzID0gPDA+Ow0KKyAgICAgICAgICAgIHBhaXJzZXQtbmFtZXMg
PSAiYWx0ZXJuYXRpdmUtYSIsICJhbHRlcm5hdGl2ZS1iIjsNCisgICAgICAgICAgICBwYWlyc2V0
cyA9IDwmcGh5czBfMj4sIDwmcGh5czBfMz47DQorICAgICAgICAgICAgcG9sYXJpdHktc3VwcG9y
dGVkID0gIk1ESS1YIiwgIlMiOw0KKyAgICAgICAgICAgIHZwd3Itc3VwcGx5ID0gPCZyZWdfcHNl
PjsNCisgICAgICAgICAgfTsNCisgICAgICAgICAgcHNlX3BpMjogcHNlLXBpQDIgew0KKyAgICAg
ICAgICAgIHJlZyA9IDwyPjsNCisgICAgICAgICAgICAjcHNlLWNlbGxzID0gPDA+Ow0KKyAgICAg
ICAgICAgIHBhaXJzZXQtbmFtZXMgPSAiYWx0ZXJuYXRpdmUtYSIsICJhbHRlcm5hdGl2ZS1iIjsN
CisgICAgICAgICAgICBwYWlyc2V0cyA9IDwmcGh5czBfND4sIDwmcGh5czBfNT47DQorICAgICAg
ICAgICAgcG9sYXJpdHktc3VwcG9ydGVkID0gIk1ESS1YIiwgIlMiOw0KKyAgICAgICAgICAgIHZw
d3Itc3VwcGx5ID0gPCZyZWdfcHNlPjsNCisgICAgICAgICAgfTsNCisgICAgICAgICAgcHNlX3Bp
MzogcHNlLXBpQDMgew0KKyAgICAgICAgICAgIHJlZyA9IDwzPjsNCisgICAgICAgICAgICAjcHNl
LWNlbGxzID0gPDA+Ow0KKyAgICAgICAgICAgIHBhaXJzZXQtbmFtZXMgPSAiYWx0ZXJuYXRpdmUt
YSIsICJhbHRlcm5hdGl2ZS1iIjsNCisgICAgICAgICAgICBwYWlyc2V0cyA9IDwmcGh5czBfNj4s
IDwmcGh5czBfNz47DQorICAgICAgICAgICAgcG9sYXJpdHktc3VwcG9ydGVkID0gIk1ESS1YIiwg
IlMiOw0KKyAgICAgICAgICAgIHZwd3Itc3VwcGx5ID0gPCZyZWdfcHNlPjsNCisgICAgICAgICAg
fTsNCisgICAgICAgIH07DQorICAgICAgfTsNCisgICAgfTsNCi0tIA0KMi40My4wDQoNCg==

