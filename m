Return-Path: <netdev+bounces-206122-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 8F5E2B01A80
	for <lists+netdev@lfdr.de>; Fri, 11 Jul 2025 13:25:01 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 7657B188BD0F
	for <lists+netdev@lfdr.de>; Fri, 11 Jul 2025 11:25:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B025828B3F9;
	Fri, 11 Jul 2025 11:24:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=adtran.com header.i=@adtran.com header.b="mH/p6FJF"
X-Original-To: netdev@vger.kernel.org
Received: from FR6P281CU001.outbound.protection.outlook.com (mail-germanywestcentralazon11020072.outbound.protection.outlook.com [52.101.171.72])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AF30827A44C;
	Fri, 11 Jul 2025 11:24:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.171.72
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752233096; cv=fail; b=sJfXXdMauLuVwGCvBkpQSbvgI5dfbqvtKahiezz3oNx8Ls1tYxNBugosJMTsfx4jwzD3Ko+sQDpxUSmYfrXNeo1wIZ9wz2CxfP6j+mN+hHkJg+F8dbbL8lBLswRoVNlaxdkLw0Cy59YgxTKGDqPy6nZCBiRAz0aG8ODQjTFY+y4=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752233096; c=relaxed/simple;
	bh=ZT52WsFHVLBmaAr7eXmr8WtJkYoo+3tbEA2FgeZ5KUQ=;
	h=From:To:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=iGAjYnvHua7i7JwEq59xw3EAhMqfsC1KbFYBw9mtMwM31EOOiRREPvXMSrXpDVZqF1ACKbBnDlAHSyDc0gqSV/6+7r26Z5HSEyHInfvVy4R+5w+Item2MXFAx4o5WZzsKvw1z7fo0WXcb4ugm7beLZoThHX0oNJ2hz4mFy5C+vo=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=adtran.com; spf=pass smtp.mailfrom=adtran.com; dkim=pass (1024-bit key) header.d=adtran.com header.i=@adtran.com header.b=mH/p6FJF; arc=fail smtp.client-ip=52.101.171.72
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=adtran.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=adtran.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=a5jrF+RIw9zNQ6Fnf1zEvRxjT4ebt//YR39MigHCy7KiQDOkMri5ygPnrfYZ8r//zORPSNnHbVLjjnHT7ml3ocAdGKGgwln2D38I+p/QuBRRaaauVAwL4moX3KAufIVqJ20BiZqt+BNG4iNegEmLJl/aYs5RPotKjDn/exWcSy5GwWwSEQTvFZLU9GW7VlBH3P01GHkeZEkzbnUTLwDRIFy099qQgxXkQZVFbl+vJ5ysTnfQDcNpmeeprrlh0sbjGIwTa0muNTvK1Rs6y1TyTiqp5RojSKLzn3nhnRlXj5hYM4eDtOGrjUkGeE0WfoC0PdlAo9aoE53BAaTW1giVUg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ZT52WsFHVLBmaAr7eXmr8WtJkYoo+3tbEA2FgeZ5KUQ=;
 b=UK7REyNZjyFigi5bLdUbskoL4cCICVXTxwEyo6l41/swQ25hgG8lf4uLOYAR8A7tLUYffrWGmXVs+/TLOLAsyW73g5lxz95ltcUGuussF4ZSYoSq3IyR3t5EPZo79QDukR0Y4a1MEUgnWQCJsOKzms8XBnduTIaWr4eVqUJtIR8f87SvYjazODemW8LJJS7wPVUOGb8cY8qxc0iRw4V+pTd0Qj2FZj3XgmfnDGydA8o6iLf9vTU+c9II3thehMK+50L0oZQwcG023DRPB9tDkJq0L/68y5CluRoCp85Sx2FMp5MD4g9upQLUVhKMde7iCMyU3hsehXCWaWzQsWapWA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=adtran.com; dmarc=pass action=none header.from=adtran.com;
 dkim=pass header.d=adtran.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=adtran.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ZT52WsFHVLBmaAr7eXmr8WtJkYoo+3tbEA2FgeZ5KUQ=;
 b=mH/p6FJFgDYGZE1CdNw+IRqxk7TgLeZ5JIdhn3xAsuU2FEgYXc5WYKfCo61lt/qrXN4FCFPrIWoLRwYIfjk4df6d3NrlX1k4P79EEQqHnNKNRerIUy8S2K7LCoX8xxy2nNMOmNhXDxe6Gl14PsUuzcy5R56daVS+9366ZyzKvwY=
Received: from BE1PPF3198F3A62.DEUP281.PROD.OUTLOOK.COM (2603:10a6:b18::626)
 by BE0P281MB0050.DEUP281.PROD.OUTLOOK.COM (2603:10a6:b10:b::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8922.25; Fri, 11 Jul
 2025 11:24:50 +0000
Received: from BE1PPF3198F3A62.DEUP281.PROD.OUTLOOK.COM
 ([fe80::8c10:5391:a013:30f2]) by BE1PPF3198F3A62.DEUP281.PROD.OUTLOOK.COM
 ([fe80::8c10:5391:a013:30f2%8]) with mapi id 15.20.8922.023; Fri, 11 Jul 2025
 11:24:50 +0000
From: Piotr Kubik <piotr.kubik@adtran.com>
To: Oleksij Rempel <o.rempel@pengutronix.de>, Kory Maincent
	<kory.maincent@bootlin.com>, Andrew Lunn <andrew+netdev@lunn.ch>, "David S.
 Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, Jakub
 Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, Rob Herring
	<robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley
	<conor+dt@kernel.org>, "netdev@vger.kernel.org" <netdev@vger.kernel.org>,
	"devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: [PATCH net-next v5 1/2] dt-bindings: net: pse-pd: Add bindings for
 Si3474 PSE controller
Thread-Topic: [PATCH net-next v5 1/2] dt-bindings: net: pse-pd: Add bindings
 for Si3474 PSE controller
Thread-Index: AQHb8lZqngBpGj//mUCerkRi/bElpg==
Date: Fri, 11 Jul 2025 11:24:50 +0000
Message-ID: <580972fd-56e9-4f7a-bedf-6dde54f54add@adtran.com>
References: <be0fb368-79b6-4b99-ad6b-00d7897ca8b0@adtran.com>
In-Reply-To: <be0fb368-79b6-4b99-ad6b-00d7897ca8b0@adtran.com>
Accept-Language: pl-PL, en-US
Content-Language: pl-PL
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=adtran.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: BE1PPF3198F3A62:EE_|BE0P281MB0050:EE_
x-ms-office365-filtering-correlation-id: 77ab8e59-663a-4901-0f6d-08ddc06d8cb6
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam:
 BCL:0;ARA:13230040|366016|1800799024|376014|7416014|921020|38070700018;
x-microsoft-antispam-message-info:
 =?utf-8?B?V08xSGpvUFljZUN0TjZ2RkRCL3dZSmtTUUp0OXdOKzg5MXh1SUc2aGV0WE92?=
 =?utf-8?B?UWd5aVVONFRESC95TlBaVzVWdDRxaVQ3dWY0VExENU8rRWthdzArb296SWhS?=
 =?utf-8?B?eXd5SVAzWGV3VnFBL1VwK01BTjEvV21PckN2TEYwcE90SnBYY1htUnBKTVNq?=
 =?utf-8?B?OVhXeUVydllMbHBzSHpDVnpGeG9kQUR0UmRLMnFXYkFGS0x2VDVxTGJreUNL?=
 =?utf-8?B?Z09JY1NhNEVYL3VXUmo4dTFTWHUwRmVXMU5IeHBjZ2d3SzF2VEp0blJVYVhs?=
 =?utf-8?B?SzdNeG1uZ0dxUFRaRmp4RXZtWE9JRWFiTy8rbnhJV0VLOGM4UWRCcFhYaFBa?=
 =?utf-8?B?YWdnaWlPbVhzS25IbUlzTk8wenlCeUU4NjBFS1JYVEhoRnVTcFlja3htQWFM?=
 =?utf-8?B?SDNiUEpRVklKbnFkUTFTcHIyL1NVMjFtL0l6UTlYdWYrOFd2UXAxQXRuUm1I?=
 =?utf-8?B?TVpsNFNYcG1oZzhHbVZrMVVNRHNHS3R6QUZQaldHa1lVcUZ1RmxyV21PdGJ6?=
 =?utf-8?B?NHFYVFU5eUw4eU5IZzVWVmRCWE5hU0MwSStrcjZubm9IS2NkNjV4QW52SXB3?=
 =?utf-8?B?UUVVYkExM3h1N2xKbjlTMWFmbzJLRFFPUFFnOXpnY0NQTW1hQUVDTjBFVzBF?=
 =?utf-8?B?d1pza2h0aXZ6TExKbXNlYTRjakxjbXpGc0pab1NBTVN1Y1BjcHNxUnJPK1U5?=
 =?utf-8?B?UENGbDI1MnRURk9tNjhZNTBWNmZJTmJINjdvTjBtZ0pEbU4rOXA3eER0K3dx?=
 =?utf-8?B?Q0VkcWVRd2w3bTlrSEdrL0MzY0pKb2kwcHNGNWhVS1RrYlM1eGVqZFpEWnN0?=
 =?utf-8?B?QWVPL2tCVVFiV2l3Z3NxUUNYcmRQdW5hc292N3dHeDRQcDQxUERJb3haNUpX?=
 =?utf-8?B?K20rSWJGMS85TlVUOVhwMzdyWndpUmVJVVp5SE9OMENPb1BWWm5XL0VtQjRl?=
 =?utf-8?B?NEJYQXFRSitXeUp1TnpVUkQvZmJIanJPM2Q5TUFXdjRPQ0JzK1ZhUzVZNWlz?=
 =?utf-8?B?UnRqZWlSMEZKSWxXVGVQVzFDVXBZZlAvd2p4UVVKbkJlZmZmMUFnNlFSK2ly?=
 =?utf-8?B?VlRVNTdGRmRMUm1sSUJ0MlJWSXdpVzJKaDNwSTlzUndYdVYzYmJyM0l3bm8w?=
 =?utf-8?B?b3BBSXM4aUEvbFlkMFdFYjBNanRNZXhncGM0QWtjQXA1TUxVYVNRWXhkVi9C?=
 =?utf-8?B?TWcwQzFGK2N3M1NpSGhNOXo4QVlNb2wzdExZVEFDWDVKVWtvN2xRdVFyUFVO?=
 =?utf-8?B?Tks2cTg5VThYbjdnbEtzVFRPeDhwVzByTU5HSUhCSUE3MHVZUk5jSi8vd3RU?=
 =?utf-8?B?ekYzYUJWeGt5b1d5aEdCT0t1dWUvRUZSaEpac1FJeExxdlBzUTQvN1FFZ253?=
 =?utf-8?B?bnRXV0xUcnNvdks5ZGdBdmFLeDNGQTlIQ0VVMHorSS9YSE1EMDA2Q2Z4SkFm?=
 =?utf-8?B?MllPc1FIYldZWWI2UDhldTlWUlpBb3dCa2JpWlI4YkIyNFIxQ0g5Y25nbVVj?=
 =?utf-8?B?a2o5UFRvRVhUUVNZVitoQ3kwQjd1MTFqRkpYeVVzOGR3UGZDcWZBZjlQRkQ5?=
 =?utf-8?B?all3VjRIcUo3MGtrMVBGdHZwTFN2ZWdQTGhmYVdrVWJTeGZXQlBFbUJWK2dz?=
 =?utf-8?B?NU9SMnMySVoxVkQ3QjdqeFYxajBHTktpbkZGeXNxRnJIcTBQMEpBUkhFY1dM?=
 =?utf-8?B?QXlYdmhJeHZRRHVGbkZjZWlHY1RKbm9SbXRJdWRWelhEb3FlZjhSeTZwK3V1?=
 =?utf-8?B?bkYwQUxvZjgrcGNqc1RRNDQ4R2ZzR0V3M012RFVZdFIrS0p1UjRrVHlMQjFq?=
 =?utf-8?B?ODRvSGg3K2tuNzJ3N0JZQUdZTzBzQWpYVEQwSVN0TjVTV1JQYjYraWhiUzJi?=
 =?utf-8?B?WGE0b2xNNmNoY0QzWjNsSG44QU5uSm0zSG5WaU1XQXVTSnlFbHdBenpqcURJ?=
 =?utf-8?Q?emPf5J5eN5lGBsSoPGGNLaJ7HSvl1wXE?=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BE1PPF3198F3A62.DEUP281.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(376014)(7416014)(921020)(38070700018);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?utf-8?B?R2FvS0hVeEx6bDd6eHZUOVlCSDBrdWdINHA1WVdXRGZPUSs5dnlmU1RpMGI0?=
 =?utf-8?B?K0VEZnpTMFdUUW1qUW8xaTRtcExLamZPTFhvdFpSNW9ZRE0rSm5iVjAvbFBW?=
 =?utf-8?B?UWg1ZzB2WGdNQmdKcmhoNWV0bHU3MHhuaWtXMHg5dE9pRHRQU1EzVWpsNHhq?=
 =?utf-8?B?eC85RDJjQ0ZWNjA2cDNiZUQxNzNMaUZxQ21lS1RTKy93K2Z6NFpadlNNb0c0?=
 =?utf-8?B?REkrUitOb0ozVXlCeHpmak9jbjg2QVIxa0VFdy9lMWN4bForSFVDU01GNS83?=
 =?utf-8?B?dHFsZStQRUpOUEJMT1FNL3EvUWNScEdKYnE0azBySUI3MlhEeWRaWFVldGY0?=
 =?utf-8?B?b00rSEg0OTJsZDRUZFAzVS96WTlRR1lra0RPTGpwbHVsRW1NSzNWUXpwa3Vs?=
 =?utf-8?B?ako4MEQzMXQ2UmxxOTBhUVcwZjNHc3lpdlRzVWlOcU55KzlDU0k5aElyUUV3?=
 =?utf-8?B?VlhwN2xYMHhpaTBxaFpnM1dhclE3enRHbGEzSFZJbCtaOU5saWZlR056VVZY?=
 =?utf-8?B?Nk1nRFFnUnFYMWNKWkJlSndoMnNjMkJYTlZQVmgrVFBHb3ZCUW4vem1WS0Q3?=
 =?utf-8?B?NkZhU0s4S2FtRE93MGZTWG5LOVpLeHF0YkovbUFOK1dLdllFQWFNM2Y1Q3k3?=
 =?utf-8?B?Wi9mUDBscnhFbmpRQTQ4MGNGL083QTV4QVM1L2dJYXZQcFQ1anRMMmlqa3dq?=
 =?utf-8?B?aWRvRlBXdzFTNE1QaCtsUGVXMTFJei83SC95Z2gzNjlsYkpWcm1KcXBWVmU4?=
 =?utf-8?B?Zko0V3R4OUF4bTZoZFBNbTROMHNBUTBRZzlUUnhUbi9qWXpBTEZyNkVEa3dP?=
 =?utf-8?B?bVNCelBFODg0VGxrWlBDVG5nWWorNU5UcTA4UFJJUTcyUkJNc2t2UGtuNjgz?=
 =?utf-8?B?Uk9EcGw0VEoyMi8rY3k1bUNpSUpPWTVqMTJnd0NMaW9yTHgxVHVDMHBvamEx?=
 =?utf-8?B?ZGhuOUQzN3YyZE9HVVlNekdZL1RSb3QxR3lpZlR3ODJvWGhGenV1ZDJrdEJJ?=
 =?utf-8?B?aENsa1lpMmhHVGNHTUc4VkM5MTAxM09XVW1rOUUzM25WYkRFRE5sc3dURTEw?=
 =?utf-8?B?dG5sckFjdGo5TkZ1aHNjcjMrNFovcDhiSldXdGNTeXd2b2hCU0RMemFvT2l3?=
 =?utf-8?B?WldQY1Z6VXNYYkNpV2JJMDR4ZTNPc0VuRStxTGFuVk9DaEdzWlhGMWkwd01W?=
 =?utf-8?B?WU5KcHRXemJhSEVIVTR3bUg5NmxaTU5MMFU4T01ndzNGTmR4eW42NjcrWVZN?=
 =?utf-8?B?U1F1OURubWU0TmZHRFE2WGFHd3BaUVBESFBpUDRXYzVIU3lXV3VtVXY4UWRE?=
 =?utf-8?B?Wk1rZVZkTWIwVUhSeWVHZE9LaVJXN3h1MCtyRHRkMmFVQ0l2N0pNRUhWK0Rk?=
 =?utf-8?B?R0I0SHVwcWcwZ09uajR1SW5ua3FycVdHdHJ0YjZHYXgrMjNKZmdxWUNjeEdQ?=
 =?utf-8?B?d1NnVmFUU2NmcHBIRDNDRFBaRW9uRXVreEE2aWdNSmR2Vnc1THNhaWxIYS9C?=
 =?utf-8?B?aTNDdDBxc2VmczdrZWJ4QjA3U2hyNkY5NEFiZXNPcjUram5BVExNeUZOWGZR?=
 =?utf-8?B?alFEWUhuNHpQRDh0ZFZob3pFZnVrWkFmS3JjYUlJUjN3RGhVNmlrVFAyUHA3?=
 =?utf-8?B?UjRDQUhhVkJDZlNBMkg1c3VablJxNlpvUTVNbUFzNHlNcmhLb0M5L09TWTFC?=
 =?utf-8?B?eFdxRy9yL3Z4bk1KODZURi8xb2MwejFLcnZTcjZOZ3duRWI4L1hnVURHVlhX?=
 =?utf-8?B?RnN4UEM0VzZxQTNsTXcvNSttVHh3aFVkU2QzZkJOelNFeDZzd3dSK3hsb1gx?=
 =?utf-8?B?RGJnZWhlL1JLVVNJZTA4bXR6U0dLQnRDNEJpWXE3MWR0OUZ4b0orTXFQNjNJ?=
 =?utf-8?B?czI2dXJMWmVFMzdPdjVUTU9Sb0pGOE5hUDROSHhiZDB1dG9CWjhtaVNzVlJ0?=
 =?utf-8?B?NlFqeFQyU2xmZVFjZkFRbytlOUtmK3EySXQxNjJKNVNhb2xzejNscHArNFg3?=
 =?utf-8?B?VXUxOFI3Y3QraHd5ekpJTTl6ODdNTFhxNG0yRkhmM0pEc3dyWUYwaE5oYzd5?=
 =?utf-8?B?OUFQMnYvZHRjM0xMLzQwbEhyTy8vdFE3SEF1dHF6eEVWWjNydUdrZDhLZ2dC?=
 =?utf-8?Q?cQOByeIBcqMZ5oD0zvTLl3a95?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <E54463C3FDABE14499F21A825C2E7FE7@DEUP281.PROD.OUTLOOK.COM>
Content-Transfer-Encoding: base64
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-OriginatorOrg: adtran.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BE1PPF3198F3A62.DEUP281.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-Network-Message-Id: 77ab8e59-663a-4901-0f6d-08ddc06d8cb6
X-MS-Exchange-CrossTenant-originalarrivaltime: 11 Jul 2025 11:24:50.0633
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 423946e4-28c0-4deb-904c-a4a4b174fb3f
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: whjp++ZfNwsv/FyaeyHODSTPOYgArO3M3rBtHtFtlWQIWhleBnvxC4lHzSrLBO8v9Cbbn28nrn5PM4OuJgBdAA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BE0P281MB0050

RnJvbTogUGlvdHIgS3ViaWsgPHBpb3RyLmt1YmlrQGFkdHJhbi5jb20+DQoNCkFkZCB0aGUgU2kz
NDc0IEkyQyBQb3dlciBTb3VyY2luZyBFcXVpcG1lbnQgY29udHJvbGxlciBkZXZpY2UgdHJlZQ0K
YmluZGluZ3MgZG9jdW1lbnRhdGlvbi4NCg0KU2lnbmVkLW9mZi1ieTogUGlvdHIgS3ViaWsgPHBp
b3RyLmt1YmlrQGFkdHJhbi5jb20+DQpSZXZpZXdlZC1ieTogS3J6eXN6dG9mIEtvemxvd3NraSA8
a3J6eXN6dG9mLmtvemxvd3NraUBsaW5hcm8ub3JnPg0KUmV2aWV3ZWQtYnk6IEtvcnkgTWFpbmNl
bnQgPGtvcnkubWFpbmNlbnRAYm9vdGxpbi5jb20+DQotLS0NCiAuLi4vYmluZGluZ3MvbmV0L3Bz
ZS1wZC9za3l3b3JrcyxzaTM0NzQueWFtbCAgfCAxNDQgKysrKysrKysrKysrKysrKysrDQogMSBm
aWxlIGNoYW5nZWQsIDE0NCBpbnNlcnRpb25zKCspDQogY3JlYXRlIG1vZGUgMTAwNjQ0IERvY3Vt
ZW50YXRpb24vZGV2aWNldHJlZS9iaW5kaW5ncy9uZXQvcHNlLXBkL3NreXdvcmtzLHNpMzQ3NC55
YW1sDQoNCmRpZmYgLS1naXQgYS9Eb2N1bWVudGF0aW9uL2RldmljZXRyZWUvYmluZGluZ3MvbmV0
L3BzZS1wZC9za3l3b3JrcyxzaTM0NzQueWFtbCBiL0RvY3VtZW50YXRpb24vZGV2aWNldHJlZS9i
aW5kaW5ncy9uZXQvcHNlLXBkL3NreXdvcmtzLHNpMzQ3NC55YW1sDQpuZXcgZmlsZSBtb2RlIDEw
MDY0NA0KaW5kZXggMDAwMDAwMDAwMDAwLi5lZGQzNmE0M2EzODcNCi0tLSAvZGV2L251bGwNCisr
KyBiL0RvY3VtZW50YXRpb24vZGV2aWNldHJlZS9iaW5kaW5ncy9uZXQvcHNlLXBkL3NreXdvcmtz
LHNpMzQ3NC55YW1sDQpAQCAtMCwwICsxLDE0NCBAQA0KKyMgU1BEWC1MaWNlbnNlLUlkZW50aWZp
ZXI6IChHUEwtMi4wLW9ubHkgT1IgQlNELTItQ2xhdXNlKQ0KKyVZQU1MIDEuMg0KKy0tLQ0KKyRp
ZDogaHR0cDovL2RldmljZXRyZWUub3JnL3NjaGVtYXMvbmV0L3BzZS1wZC9za3l3b3JrcyxzaTM0
NzQueWFtbCMNCiskc2NoZW1hOiBodHRwOi8vZGV2aWNldHJlZS5vcmcvbWV0YS1zY2hlbWFzL2Nv
cmUueWFtbCMNCisNCit0aXRsZTogU2t5d29ya3MgU2kzNDc0IFBvd2VyIFNvdXJjaW5nIEVxdWlw
bWVudCBjb250cm9sbGVyDQorDQorbWFpbnRhaW5lcnM6DQorICAtIFBpb3RyIEt1YmlrIDxwaW90
ci5rdWJpa0BhZHRyYW4uY29tPg0KKw0KK2FsbE9mOg0KKyAgLSAkcmVmOiBwc2UtY29udHJvbGxl
ci55YW1sIw0KKw0KK3Byb3BlcnRpZXM6DQorICBjb21wYXRpYmxlOg0KKyAgICBlbnVtOg0KKyAg
ICAgIC0gc2t5d29ya3Msc2kzNDc0DQorDQorICByZWc6DQorICAgIG1heEl0ZW1zOiAyDQorDQor
ICByZWctbmFtZXM6DQorICAgIGl0ZW1zOg0KKyAgICAgIC0gY29uc3Q6IG1haW4NCisgICAgICAt
IGNvbnN0OiBzZWNvbmRhcnkNCisNCisgIGNoYW5uZWxzOg0KKyAgICBkZXNjcmlwdGlvbjogVGhl
IFNpMzQ3NCBpcyBhIHNpbmdsZS1jaGlwIFBvRSBQU0UgY29udHJvbGxlciBtYW5hZ2luZw0KKyAg
ICAgIDggcGh5c2ljYWwgcG93ZXIgZGVsaXZlcnkgY2hhbm5lbHMuIEludGVybmFsbHksIGl0J3Mg
c3RydWN0dXJlZA0KKyAgICAgIGludG8gdHdvIGxvZ2ljYWwgIlF1YWRzIi4NCisgICAgICBRdWFk
IDAgTWFuYWdlcyBwaHlzaWNhbCBjaGFubmVscyAoJ3BvcnRzJyBpbiBkYXRhc2hlZXQpIDAsIDEs
IDIsIDMNCisgICAgICBRdWFkIDEgTWFuYWdlcyBwaHlzaWNhbCBjaGFubmVscyAoJ3BvcnRzJyBp
biBkYXRhc2hlZXQpIDQsIDUsIDYsIDcuDQorDQorICAgIHR5cGU6IG9iamVjdA0KKyAgICBhZGRp
dGlvbmFsUHJvcGVydGllczogZmFsc2UNCisNCisgICAgcHJvcGVydGllczoNCisgICAgICAiI2Fk
ZHJlc3MtY2VsbHMiOg0KKyAgICAgICAgY29uc3Q6IDENCisNCisgICAgICAiI3NpemUtY2VsbHMi
Og0KKyAgICAgICAgY29uc3Q6IDANCisNCisgICAgcGF0dGVyblByb3BlcnRpZXM6DQorICAgICAg
J15jaGFubmVsQFswLTddJCc6DQorICAgICAgICB0eXBlOiBvYmplY3QNCisgICAgICAgIGFkZGl0
aW9uYWxQcm9wZXJ0aWVzOiBmYWxzZQ0KKw0KKyAgICAgICAgcHJvcGVydGllczoNCisgICAgICAg
ICAgcmVnOg0KKyAgICAgICAgICAgIG1heEl0ZW1zOiAxDQorDQorICAgICAgICByZXF1aXJlZDoN
CisgICAgICAgICAgLSByZWcNCisNCisgICAgcmVxdWlyZWQ6DQorICAgICAgLSAiI2FkZHJlc3Mt
Y2VsbHMiDQorICAgICAgLSAiI3NpemUtY2VsbHMiDQorDQorcmVxdWlyZWQ6DQorICAtIGNvbXBh
dGlibGUNCisgIC0gcmVnDQorICAtIHBzZS1waXMNCisNCit1bmV2YWx1YXRlZFByb3BlcnRpZXM6
IGZhbHNlDQorDQorZXhhbXBsZXM6DQorICAtIHwNCisgICAgaTJjIHsNCisgICAgICAjYWRkcmVz
cy1jZWxscyA9IDwxPjsNCisgICAgICAjc2l6ZS1jZWxscyA9IDwwPjsNCisNCisgICAgICBldGhl
cm5ldC1wc2VAMjYgew0KKyAgICAgICAgY29tcGF0aWJsZSA9ICJza3l3b3JrcyxzaTM0NzQiOw0K
KyAgICAgICAgcmVnLW5hbWVzID0gIm1haW4iLCAic2Vjb25kYXJ5IjsNCisgICAgICAgIHJlZyA9
IDwweDI2PiwgPDB4Mjc+Ow0KKw0KKyAgICAgICAgY2hhbm5lbHMgew0KKyAgICAgICAgICAjYWRk
cmVzcy1jZWxscyA9IDwxPjsNCisgICAgICAgICAgI3NpemUtY2VsbHMgPSA8MD47DQorICAgICAg
ICAgIHBoeXMwXzA6IGNoYW5uZWxAMCB7DQorICAgICAgICAgICAgcmVnID0gPDA+Ow0KKyAgICAg
ICAgICB9Ow0KKyAgICAgICAgICBwaHlzMF8xOiBjaGFubmVsQDEgew0KKyAgICAgICAgICAgIHJl
ZyA9IDwxPjsNCisgICAgICAgICAgfTsNCisgICAgICAgICAgcGh5czBfMjogY2hhbm5lbEAyIHsN
CisgICAgICAgICAgICByZWcgPSA8Mj47DQorICAgICAgICAgIH07DQorICAgICAgICAgIHBoeXMw
XzM6IGNoYW5uZWxAMyB7DQorICAgICAgICAgICAgcmVnID0gPDM+Ow0KKyAgICAgICAgICB9Ow0K
KyAgICAgICAgICBwaHlzMF80OiBjaGFubmVsQDQgew0KKyAgICAgICAgICAgIHJlZyA9IDw0PjsN
CisgICAgICAgICAgfTsNCisgICAgICAgICAgcGh5czBfNTogY2hhbm5lbEA1IHsNCisgICAgICAg
ICAgICByZWcgPSA8NT47DQorICAgICAgICAgIH07DQorICAgICAgICAgIHBoeXMwXzY6IGNoYW5u
ZWxANiB7DQorICAgICAgICAgICAgcmVnID0gPDY+Ow0KKyAgICAgICAgICB9Ow0KKyAgICAgICAg
ICBwaHlzMF83OiBjaGFubmVsQDcgew0KKyAgICAgICAgICAgIHJlZyA9IDw3PjsNCisgICAgICAg
ICAgfTsNCisgICAgICAgIH07DQorICAgICAgICBwc2UtcGlzIHsNCisgICAgICAgICAgI2FkZHJl
c3MtY2VsbHMgPSA8MT47DQorICAgICAgICAgICNzaXplLWNlbGxzID0gPDA+Ow0KKyAgICAgICAg
ICBwc2VfcGkwOiBwc2UtcGlAMCB7DQorICAgICAgICAgICAgcmVnID0gPDA+Ow0KKyAgICAgICAg
ICAgICNwc2UtY2VsbHMgPSA8MD47DQorICAgICAgICAgICAgcGFpcnNldC1uYW1lcyA9ICJhbHRl
cm5hdGl2ZS1hIiwgImFsdGVybmF0aXZlLWIiOw0KKyAgICAgICAgICAgIHBhaXJzZXRzID0gPCZw
aHlzMF8wPiwgPCZwaHlzMF8xPjsNCisgICAgICAgICAgICBwb2xhcml0eS1zdXBwb3J0ZWQgPSAi
TURJLVgiLCAiUyI7DQorICAgICAgICAgICAgdnB3ci1zdXBwbHkgPSA8JnJlZ19wc2U+Ow0KKyAg
ICAgICAgICB9Ow0KKyAgICAgICAgICBwc2VfcGkxOiBwc2UtcGlAMSB7DQorICAgICAgICAgICAg
cmVnID0gPDE+Ow0KKyAgICAgICAgICAgICNwc2UtY2VsbHMgPSA8MD47DQorICAgICAgICAgICAg
cGFpcnNldC1uYW1lcyA9ICJhbHRlcm5hdGl2ZS1hIiwgImFsdGVybmF0aXZlLWIiOw0KKyAgICAg
ICAgICAgIHBhaXJzZXRzID0gPCZwaHlzMF8yPiwgPCZwaHlzMF8zPjsNCisgICAgICAgICAgICBw
b2xhcml0eS1zdXBwb3J0ZWQgPSAiTURJLVgiLCAiUyI7DQorICAgICAgICAgICAgdnB3ci1zdXBw
bHkgPSA8JnJlZ19wc2U+Ow0KKyAgICAgICAgICB9Ow0KKyAgICAgICAgICBwc2VfcGkyOiBwc2Ut
cGlAMiB7DQorICAgICAgICAgICAgcmVnID0gPDI+Ow0KKyAgICAgICAgICAgICNwc2UtY2VsbHMg
PSA8MD47DQorICAgICAgICAgICAgcGFpcnNldC1uYW1lcyA9ICJhbHRlcm5hdGl2ZS1hIiwgImFs
dGVybmF0aXZlLWIiOw0KKyAgICAgICAgICAgIHBhaXJzZXRzID0gPCZwaHlzMF80PiwgPCZwaHlz
MF81PjsNCisgICAgICAgICAgICBwb2xhcml0eS1zdXBwb3J0ZWQgPSAiTURJLVgiLCAiUyI7DQor
ICAgICAgICAgICAgdnB3ci1zdXBwbHkgPSA8JnJlZ19wc2U+Ow0KKyAgICAgICAgICB9Ow0KKyAg
ICAgICAgICBwc2VfcGkzOiBwc2UtcGlAMyB7DQorICAgICAgICAgICAgcmVnID0gPDM+Ow0KKyAg
ICAgICAgICAgICNwc2UtY2VsbHMgPSA8MD47DQorICAgICAgICAgICAgcGFpcnNldC1uYW1lcyA9
ICJhbHRlcm5hdGl2ZS1hIiwgImFsdGVybmF0aXZlLWIiOw0KKyAgICAgICAgICAgIHBhaXJzZXRz
ID0gPCZwaHlzMF82PiwgPCZwaHlzMF83PjsNCisgICAgICAgICAgICBwb2xhcml0eS1zdXBwb3J0
ZWQgPSAiTURJLVgiLCAiUyI7DQorICAgICAgICAgICAgdnB3ci1zdXBwbHkgPSA8JnJlZ19wc2U+
Ow0KKyAgICAgICAgICB9Ow0KKyAgICAgICAgfTsNCisgICAgICB9Ow0KKyAgICB9Ow0KLS0gDQoy
LjQzLjANCg0K

