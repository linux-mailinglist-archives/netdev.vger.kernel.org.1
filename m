Return-Path: <netdev+bounces-206121-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 28DCBB01A7D
	for <lists+netdev@lfdr.de>; Fri, 11 Jul 2025 13:23:51 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 6679A4A092D
	for <lists+netdev@lfdr.de>; Fri, 11 Jul 2025 11:23:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F28F028A719;
	Fri, 11 Jul 2025 11:23:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=adtran.com header.i=@adtran.com header.b="SKWLA39V"
X-Original-To: netdev@vger.kernel.org
Received: from FR4P281CU032.outbound.protection.outlook.com (mail-germanywestcentralazon11022102.outbound.protection.outlook.com [40.107.149.102])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BD6BE28B418;
	Fri, 11 Jul 2025 11:23:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.149.102
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752233026; cv=fail; b=Zqz+JVwpZXmU3DdpOXFbCPbVQiQBxs4eavRQZlNp/R0SxcB/LzvUlIM32KPhioitrxOTzo0aIn+bATl4wwkVrV9wER96McsRMcEpL/2RXhl6NgnKA9FitjBTiwwxQ7NVJDkUGZRZ1WK8maScZTrESJVeXxq3H94J1Z0EKYEVyic=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752233026; c=relaxed/simple;
	bh=jzXdJzqMaSFam3sGB8sgRf8yPJZkdasmfmQFv8uGnZ0=;
	h=From:To:Subject:Date:Message-ID:Content-Type:MIME-Version; b=A8VJ/+vqDF45rAhXstGMx1xAih3dyKnF2wTuVn878KhYnQDBfxDhbUxERKfFL+Qg31YIGdXzxDPzX+bGBd/e9RTxkumBS4wljNj/GYpkHf+19aQwg45SZ5jYV1ADXucoVoX5zfa3VHgk/kPboHJeB6WEuBTdkVCkpQWevimxMbc=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=adtran.com; spf=pass smtp.mailfrom=adtran.com; dkim=pass (1024-bit key) header.d=adtran.com header.i=@adtran.com header.b=SKWLA39V; arc=fail smtp.client-ip=40.107.149.102
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=adtran.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=adtran.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=AJjy2oc0EzkSpgthdIKv7MoeSvivhFYRJrxe5SD2rTMm9ukwCJN9mKTuvUKpZ89m1PS09NT3T/lNd3D062fYoa1ZkrdUo48qJ2Xw9IOIMElZMVMG9cxZQFlOn6kw1FR+YDKUkLg16poTv+NkzTKp2eSrqpa54ntWJRQs1z/onzD04433+nLln06Gk7e+GklVSB/jOHHFYPxCCVu8OiqMxgFg6kwaXtP6U9fDEv+9JHvedCoDzJL1tsHi+fojAkcvuKe2KIVXcMI2y9gcy+kZNLrFzyIFrhmCSFeKJEyG12pxYm6QQ11MiwWmx+RGHnYe6TZ91cYHq6PRIopKRhaJKg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=jzXdJzqMaSFam3sGB8sgRf8yPJZkdasmfmQFv8uGnZ0=;
 b=iKkCZIORqsc/90LBCOuTb7vDnMviAQCYASsxn27bYZujtsL8ei2JD4U1F4M9UcYu5hVaXkpbDtwVDeFwdi2a0tFrjRjq6OwRlu6/7RInWkAC0ESkljl3+fJ0XwRDuDheFXfKKn4QFH7PpKgegOH0M1oSWC6z0HSEkqu97AoVNH3OsF5WYHgmMDlQsoV0e3C9y2GeQqsY7k3gmuYRgsT6xPJIrkKJRSJKicYZjMbTfbbRA5etf0Es41wA4RR6dX7Ocfh/H4eYGn7bfcf7RacGl6YzJF4YQf4M8NxlBFzP/t0rhYBHbuswE9ZjNjyDzP02t3x7wJHW9tNjgBpBEFUxzQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=adtran.com; dmarc=pass action=none header.from=adtran.com;
 dkim=pass header.d=adtran.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=adtran.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=jzXdJzqMaSFam3sGB8sgRf8yPJZkdasmfmQFv8uGnZ0=;
 b=SKWLA39V968x0o15E8Rh0K36SgFl3ldD49/CskEW6SeAzGpCskRRHEGKnn9IKrxNmhSudHOwYqoieC4s7MzK7Euca4osnRcMxEf5OvRMi+HLgQLuYo4qBYpXG0CJosss1D9rE95eSfHgGce78u+efC34HnShz7X5M65tXixBHio=
Received: from BE1PPF3198F3A62.DEUP281.PROD.OUTLOOK.COM (2603:10a6:b18::626)
 by BE0P281MB0050.DEUP281.PROD.OUTLOOK.COM (2603:10a6:b10:b::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8922.25; Fri, 11 Jul
 2025 11:23:38 +0000
Received: from BE1PPF3198F3A62.DEUP281.PROD.OUTLOOK.COM
 ([fe80::8c10:5391:a013:30f2]) by BE1PPF3198F3A62.DEUP281.PROD.OUTLOOK.COM
 ([fe80::8c10:5391:a013:30f2%8]) with mapi id 15.20.8922.023; Fri, 11 Jul 2025
 11:23:38 +0000
From: Piotr Kubik <piotr.kubik@adtran.com>
To: Oleksij Rempel <o.rempel@pengutronix.de>, Kory Maincent
	<kory.maincent@bootlin.com>, Andrew Lunn <andrew+netdev@lunn.ch>, "David S.
 Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, Jakub
 Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, Rob Herring
	<robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley
	<conor+dt@kernel.org>, "netdev@vger.kernel.org" <netdev@vger.kernel.org>,
	"devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: [PATCH net-next v5 0/2] Add Si3474 PSE controller driver
Thread-Topic: [PATCH net-next v5 0/2] Add Si3474 PSE controller driver
Thread-Index: AQHb8lY/XYeBAa9+BUWjJ9YZiuYVaA==
Date: Fri, 11 Jul 2025 11:23:38 +0000
Message-ID: <be0fb368-79b6-4b99-ad6b-00d7897ca8b0@adtran.com>
Accept-Language: pl-PL, en-US
Content-Language: pl-PL
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=adtran.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: BE1PPF3198F3A62:EE_|BE0P281MB0050:EE_
x-ms-office365-filtering-correlation-id: bcb62849-9b8f-4fa3-70a2-08ddc06d620d
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam:
 BCL:0;ARA:13230040|366016|1800799024|376014|7416014|921020|38070700018;
x-microsoft-antispam-message-info:
 =?utf-8?B?dllYbjdBaWtiMDNsNWpCZWpjbndMZHYxOU1xZUFyR0NvcGo4TzlBYjdGUGNC?=
 =?utf-8?B?amdXa240S2w4V2p1WVNPdXgrSTlSaVFoNW8vYzhQQVlXYlJiQXpCdkF5eFBj?=
 =?utf-8?B?VEo0RXorb3EwVDZOZ241UWg3MjBYSUZ3NXRuZ0kyTzhKNlVDUTREREVmNlI2?=
 =?utf-8?B?SGRxeGd6TG9MOGJXQzlMdnk0QWRvSkdncElqQ1ZmRzQ1YXZvRWxtaDNZWjFl?=
 =?utf-8?B?RllrWVhDVTZnVEpkM2tqRFA3c2RtTHpzMnc5ZElpeWViSnN2cTIvMkxDMjI0?=
 =?utf-8?B?SFdNdFFBb0hHTkE0b1cxZC84aHk5OFJwb3hrZWxycHdUa3JVY01BK1EvUEtB?=
 =?utf-8?B?QTZveGZraWJqUjF0Y0YzaGpIV3k4bEU0eGl3Z1lTb0UybHNlT0VYMWNpMjFQ?=
 =?utf-8?B?ZlVQVXNwYXdPTnlZTEVXV2RpdloweGM4Q3ZCTmtTWVlNQ2RIYlBKdFFZYnY3?=
 =?utf-8?B?UnlVMDJuTWJBNHc2dXJQM2FsbHNmSXlLSU8wRDk3NmEwaGQvN1B1clExMWNE?=
 =?utf-8?B?UFZDc3ZtTHdaMUEwQ2M4aDU2U001cEhQVVExVE0zNTlOTzdtUDB4enB3Z2VZ?=
 =?utf-8?B?MVRXZEU5allIYndpZFhKNktUaTFObnZUcUVJNWR3cytFUlAvMVJ5U0JGV1I3?=
 =?utf-8?B?dlpFWEgzZlZNN3dSdlhoRTNGOWJUVlJ2S2RLQ1F3bEdoQUtsRnFsZDBMSElC?=
 =?utf-8?B?Mmo5MFp0UVNTOXFsdG5ENHpjSE5OYlE4R1I1U1FnZEtCbys2Mk1uMCtlN09J?=
 =?utf-8?B?amx6dWI1Q01xVm1LWmh4UjNUMzBZclFDemo5a2ZyNlFRamIwQkdOR05VMnY4?=
 =?utf-8?B?M1NuUklxbFl5ZHcxSjY3Szl4WGFYN0NTTjkwWk1SWUZLVGQxRnE0TnNlY1k5?=
 =?utf-8?B?R2d1MGNHZWpOUDRxNHYydkRuc0VKNUJVZytGb3BVOXExdlA3UkczbW1zZ25t?=
 =?utf-8?B?T2x4QWFQZ25lTzJFWXdQMFkwN0NwNWdnS1RnY2wwWktibnF5Z2hJZ1dpTDZT?=
 =?utf-8?B?ZkxYT1JDalJnQ012RTlSaURSdXZKZkk5VUtyZExsTy9vbmxLb1NCQTQwS3l6?=
 =?utf-8?B?MjhldUdyQURNYXhES1FJSWpjVWVsMlNiWlRZdzBFTHB2TUd4STMzcm8vT2o5?=
 =?utf-8?B?ZnhPRWtPeEszNGtlZzN3ZlB3cVZoM2pYME1LM0xPZnZLdzVNTzJtVXZHRkp5?=
 =?utf-8?B?UUp6WmpNM1QwZnY3eVdUR21wdzE2MGxMWmw4NEhYTlFIcEp1Qy9waFRhWDRk?=
 =?utf-8?B?Y2lFWFE1N0NlNFc4MHpsMGlPUlBKMm0vU0NQbVlNZ2tKU2ozUWxQL3NDalFO?=
 =?utf-8?B?YzY4enB0MEdkQmNqemJWQW5KV1A1TlhYaEpiQzBMRUN2VFVxbjUzVkxGR0JS?=
 =?utf-8?B?Y1M1aUlkQ0RrbEJnbHRyOUN5cnNPWjhYTU5YVFJjUEtkRWNrakVHclFoSVNI?=
 =?utf-8?B?TmJPbUo2TFpsYnFUSlBvMHErYXB1Uitkd0dyRHhodlIvYTI4YXkxckdJZFhL?=
 =?utf-8?B?QS9ROGozU1g2bUgwRGpGMVM1RHdBc1pYMVh4MFdvbzBrbDZJTDd1bTBYM1FY?=
 =?utf-8?B?SkppbmZ1dzE2NkdyZFM2aW53VUlIMmFIVUwrR0ZCZE5YL3JjT1E1YmpsZVdB?=
 =?utf-8?B?SnZaNVVBa0RibHc5cWg4QjFpZzFnUWY0dlkxT1JzSmlZekZtdndNTnFxWm1O?=
 =?utf-8?B?M0FIUjV0TXZBSENPMVI3ZDVSZ1FtWG9aWVMxZy8rUGNwV3FLWVIxeDJRMnM1?=
 =?utf-8?B?M3B0Y29ZZ3lZSU1HRVhqL2VuRFRoYjlHS1krVE53WVkrZklpWkhjVUVLcVZm?=
 =?utf-8?B?ajIwMC96Sm02Z1I5cVpzeUtvRjZPY0hsSEZtUndhcEVwMHVydmE2VDFMOHQx?=
 =?utf-8?B?YnZtbmFKcHk2NTh6SGJBa3Q5bE9ta1lpa0ZGQW9UcHRkVkZEQ0tKYTlaSTA1?=
 =?utf-8?B?bFE1dkVDUG0yUkRaRHFFLzlVNU1kUVFtWlR5dHJwVTF6RVRSMC9VZytSN096?=
 =?utf-8?B?b25ZZERiaUM3UEg4S3ArL051SWkwRWk3V1NOd3B5ZTVSSzJtdGc4ZlNMZEpJ?=
 =?utf-8?Q?n8EKXy?=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BE1PPF3198F3A62.DEUP281.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(376014)(7416014)(921020)(38070700018);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?utf-8?B?bEZkSk52allHcjNCR1JlUFBUcG52RXdhVUNoZnZ5c01oVFRvZ1NEbXZVMmNw?=
 =?utf-8?B?blZSNFpObUdUb29zdStoZGpiRmVDUDFLRjdKaDZOZCtrVll6Uko0S3VYMEFO?=
 =?utf-8?B?OXN1M0FydVpVRTlFaHovU0QxRUJ5WXMvZ2QwRjl6YXhVeStWQzR4dktGc2Nr?=
 =?utf-8?B?cHdKM0loWXpCVTVaSDZQdE5iR1d5SC9EaHdtRmlnaHB5SC9Fa3NYMEx4UHNS?=
 =?utf-8?B?UFFMbm5Ld0lmTWZzcloyd1IrYkp4cmRPNUlVN1c3NHpVV2dZMERWTTF5K1dn?=
 =?utf-8?B?eFBONFNPYS92UGI0enlTQkhPV2d1UzErQWJ4c29nc0lMUXdCZStBRGpFdCsy?=
 =?utf-8?B?endtK0hQQi9qZmxVbTRablFMQ0p0Unh4bFNzYlZYSnkzQjFzb3NQMUtiNHpV?=
 =?utf-8?B?bm1iNU9zQlRWbENuU3I5TUFWOE4zZVFZRGFwWkk5ZE5CeW1IaDdORmNuVFJO?=
 =?utf-8?B?c3J6OWJuU01HRSs1QzgxSnhZTFRMUWh4MTZTOTVvdGZwQ3lSbjhjc3liR2ll?=
 =?utf-8?B?Zi9lNW5HZ2E4ekVZamNoeEpMOEIzNzhjYkVxenpQN0tiVHVUbHluNVFveEVZ?=
 =?utf-8?B?d2hNNFltSCtkQmYwUXo0Z3BuNjE5dWlQQXFMOFU2dGZ4RElPb1hNWEx1dWpE?=
 =?utf-8?B?MVdYKzVDdG44YWNvTExQTmNNc2RUU2ZsS2lSeTZGdHpHdjJCZlRVc0o0bTlI?=
 =?utf-8?B?S1Y0clhvcWlwUm41dERlVnU2eXlzdjZPbXVQblFCYmt0Uk1EM0hvT3VFcEh6?=
 =?utf-8?B?WGo0WGJ1MTZ5Z0dBTSs0Q0NTdnk0NjR1YjJzSW0zYjBLMjNBRlYzcHk4NTFG?=
 =?utf-8?B?SE5Mcit0anAwVExjUDZtVU9DUVg5blZhb01oRlJjVWZOUWpKelhuMXVhRnNN?=
 =?utf-8?B?ZjdHazJyQ1NILzluZjdmYXlpQm91UTcrQnBuRlFzRE5SKzZ5bUtpVVh0RFFl?=
 =?utf-8?B?QXJIUjV6REM4aXVIak5zZ1RudTV3T3NrQ1h6VE9ZQ3I4SGZGV0NtYjRxam1w?=
 =?utf-8?B?WjlCZCtrVFFnbTNIc3k5Q1ptc3BaMTNxOHFQbGlUTk5FN1ZlRCtkR3ZwWGRu?=
 =?utf-8?B?YnVhL2tHdmxpcVhsWFFQQUo5cndhZ0R0UlkydjBCTEpocmdXMXgxa0I1VmF1?=
 =?utf-8?B?TE5aVFlsMUpwU0R3NWNzYTl4VkxhQVRSZFBUYjEwOWpudkpZNGhsTUhjdjlv?=
 =?utf-8?B?ZktocnoxSVlIeTRPcmFCSE5saDExMVg2RGxCYWFQTUV1TzMrZUlVbGN3ODFk?=
 =?utf-8?B?K0s4RHBUeW1ZWm5WY082QUNqUUlkU3VSeVhNc09lTnpWRDBEeUJuUGdPWEox?=
 =?utf-8?B?bUJyekNub0p2Y2VnN1NZQXNlczdTcFFONW9ZOHgraHJibWZaVkE5Q2ZoeElV?=
 =?utf-8?B?NjNOYXhOMEY5b1JKbm9hQTRUdHFtdDFKYVZkMEcrUktxa3FjZStMODVhKzZi?=
 =?utf-8?B?a0xLWVhIRDluVlVWc2pDbmUycGtXOXRVZlcxTEs2azU4ZFJUVmlNZHM0ejRw?=
 =?utf-8?B?MjZmWjBDRjU4ZVc4R3JaMGdGL1BtM2twMEdXNktYeGJhOVJ5ZmdOSk0ybFNJ?=
 =?utf-8?B?YzhxWmhacDllTXA5M1drR08rS3BRM2lmSitsYW5UQUxFMUZLYXp1U1lEdGZa?=
 =?utf-8?B?QXE2TC90TnlUS0RWQ1FWZGlZdHkyaXV0SmJNeWdHemhhQmNoUkhVdEtMOXNO?=
 =?utf-8?B?aFd5OGZ4UlVrcEpHdUN3TFVaVmtCMEdFS2VyaVBlcWJRc2dRbUtuY1FzYjhs?=
 =?utf-8?B?b3A4VjJhc1NiZFBZa2l6RVVtMkJRTkF2Z0l1OWdUUDNINVV3RWliZkhBc3pr?=
 =?utf-8?B?Q1BQTFF6RGgvcVU5Z0hiYXRMREFrQ2QwNGt4ck9JeDRDcHVJaFpQY2s2aFM3?=
 =?utf-8?B?QllobGpvUC9WMnI0UDg1MXlpQ1RmNG10Wi95UjdjSVY5akVqdWRQRWxTK3lP?=
 =?utf-8?B?U2tHU2FHOTRnUVVRSjZYRkpGZUdnNmlLWFRmTmFWQlRYRUZ6VGtxRy9lT2lj?=
 =?utf-8?B?V1FmYkgvdHZDcUtINCtkdXBkVGZPa3FhQ2JMOFpzNnBDaWVZL2ZKdmhpWlBt?=
 =?utf-8?B?OWRsQWhaSjBhQjRINXE3VXZOWUgxZnc5ckcxQ1Q2b2UzaDY1QzNJd3oya1p1?=
 =?utf-8?Q?RlHlc7ctL55rhTcn1+nSgePJA?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <8A8EBF83D0F2DE48A3C5233C5655E4DB@DEUP281.PROD.OUTLOOK.COM>
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
X-MS-Exchange-CrossTenant-Network-Message-Id: bcb62849-9b8f-4fa3-70a2-08ddc06d620d
X-MS-Exchange-CrossTenant-originalarrivaltime: 11 Jul 2025 11:23:38.5215
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 423946e4-28c0-4deb-904c-a4a4b174fb3f
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: zEFLAgVaWW6sWDY8XI/cOMQqal8wuYWbTMHW4mCQNPrRsSABKKOnEcjy5C4TNQp5DdR6kpTYp3lZ9WZK74SwEA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BE0P281MB0050

RnJvbTogUGlvdHIgS3ViaWsgPHBpb3RyLmt1YmlrQGFkdHJhbi5jb20+DQoNClRoZXNlIHBhdGNo
IHNlcmllcyBwcm92aWRlIHN1cHBvcnQgZm9yIFNreXdvcmtzIFNpMzQ3NCBJMkMgUG93ZXINClNv
dXJjaW5nIEVxdWlwbWVudCBjb250cm9sbGVyLg0KDQpCYXNlZCBvbiB0aGUgVFBTMjM4ODEgZHJp
dmVyIGNvZGUuDQoNClN1cHBvcnRlZCBmZWF0dXJlcyBvZiBTaTM0NzQ6DQotIGdldCBwb3J0IHN0
YXR1cywNCi0gZ2V0IHBvcnQgcG93ZXIsDQotIGdldCBwb3J0IHZvbHRhZ2UsDQotIGVuYWJsZS9k
aXNhYmxlIHBvcnQgcG93ZXINCg0KU2lnbmVkLW9mZi1ieTogUGlvdHIgS3ViaWsgPHBpb3RyLmt1
YmlrQGFkdHJhbi5jb20+DQotLS0NCg0KQ2hhbmdlcyBpbiB2NToNCiAgLSBSZW1vdmUgaW5saW5l
IGZ1bmN0aW9uIGRlY2xhcmF0aW9ucy4NCiAgLSBGaXggY29kZSBzdHlsZSBpc3N1ZXMgKGFwcGx5
IHJldmVyc2UgeG1hcyB0cmVlIG5vdGF0aW9uLCByZW1vdmUgZXh0cmEgYnJhY2tldHMpLg0KICAt
IFJlbW92ZSB1bm5lY2Vzc2FyeSAiIT0gMCIgY2hlY2suDQogIC0gTGluayB0byB2NDogaHR0cHM6
Ly9sb3JlLmtlcm5lbC5vcmcvbmV0ZGV2L2MwYzI4NGI4LTY0MzgtNDE2My1hNjI3LWJiZjVmNGJj
YzYyNEBhZHRyYW4uY29tDQoNCkNoYW5nZXMgaW4gdjQ6DQogIC0gUmVtb3ZlIHBhcnNpbmcgb2Yg
cHNlLXBpcyBub2RlOyBub3cgcmVsaWVzIHNvbGVseSBvbiB0aGUgcGNkZXYtPnBpW3hdIHByb3Zp
ZGVkIGJ5IHRoZSBmcmFtZXdvcmsuDQogIC0gU2V0IHRoZSBERVRFQ1RfQ0xBU1NfRU5BQkxFIHJl
Z2lzdGVyLCBlbnN1cmluZyByZWxpYWJsZSBQSSBwb3dlci11cCB3aXRob3V0IGFydGlmaWNpYWwg
ZGVsYXlzLg0KICAtIEludHJvZHVjZSBoZWxwZXIgbWFjcm9zIGZvciBiaXQgbWFuaXB1bGF0aW9u
IGxvZ2ljLg0KICAtIEFkZCBzaTM0NzRfZ2V0X2NoYW5uZWxzKCkgYW5kIHNpMzQ3NF9nZXRfY2hh
bl9jbGllbnQoKSBoZWxwZXJzIHRvIHJlZHVjZSByZWR1bmRhbnQgY29kZS4NCiAgLSBLY29uZmln
OiBDbGFyaWZ5IHRoYXQgb25seSA0LXBhaXIgUFNFIGNvbmZpZ3VyYXRpb25zIGFyZSBzdXBwb3J0
ZWQuDQogIC0gRml4IHNlY29uZCBjaGFubmVsIHZvbHRhZ2UgcmVhZCBpZiB0aGUgZmlyc3Qgb25l
IGlzIGluYWN0aXZlLg0KICAtIEF2b2lkIHJlYWRpbmcgY3VycmVudHMgYW5kIGNvbXB1dGluZyBw
b3dlciB3aGVuIFBJIHZvbHRhZ2UgaXMgemVyby4NCiAgLSBMaW5rIHRvIHYzOiBodHRwczovL2xv
cmUua2VybmVsLm9yZy9uZXRkZXYvZjk3NWYyM2UtODRhNy00OGU2LWEyYjItMThjZWI5MTQ4Njc1
QGFkdHJhbi5jb20NCg0KQ2hhbmdlcyBpbiB2MzoNCiAgLSBVc2UgX3Njb3BlZCB2ZXJzaW9uIG9m
IGZvcl9lYWNoX2NoaWxkX29mX25vZGUoKS4NCiAgLSBSZW1vdmUgcmVkdW5kYW50IHJldHVybiB2
YWx1ZSBhc3NpZ25tZW50cyBpbiBzaTM0NzRfZ2V0X29mX2NoYW5uZWxzKCkuDQogIC0gQ2hhbmdl
IGRldl9pbmZvKCkgdG8gZGV2X2RiZygpIG9uIHN1Y2Nlc3NmdWwgcHJvYmUuDQogIC0gUmVuYW1l
IGFsbCBpbnN0YW5jZXMgb2YgInNsYXZlIiB0byAic2Vjb25kYXJ5Ii4NCiAgLSBSZWdpc3RlciBk
ZXZtIGNsZWFudXAgYWN0aW9uIGZvciBhbmNpbGxhcnkgaTJjLCBzaW1wbGlmeWluZyBjbGVhbnVw
IGxvZ2ljIGluIHNpMzQ3NF9pMmNfcHJvYmUoKS4NCiAgLSBBZGQgZXhwbGljaXQgcmV0dXJuIDAg
b24gc3VjY2Vzc2Z1bCBwcm9iZS4NCiAgLSBEcm9wIHVubmVjZXNzYXJ5IC5yZW1vdmUgY2FsbGJh
Y2suDQogIC0gVXBkYXRlIGNoYW5uZWwgbm9kZSBkZXNjcmlwdGlvbiBpbiBkZXZpY2UgdHJlZSBi
aW5kaW5nIGRvY3VtZW50YXRpb24uDQogIC0gUmVvcmRlciByZWcgYW5kIHJlZy1uYW1lcyBwcm9w
ZXJ0aWVzIGluIGRldmljZSB0cmVlIGJpbmRpbmcgZG9jdW1lbnRhdGlvbi4NCiAgLSBSZW5hbWUg
YWxsICJzbGF2ZSIgcmVmZXJlbmNlcyB0byAic2Vjb25kYXJ5IiBpbiBkZXZpY2UgdHJlZSBiaW5k
aW5ncyBkb2N1bWVudGF0aW9uLg0KICAtIExpbmsgdG8gdjI6IGh0dHBzOi8vbG9yZS5rZXJuZWwu
b3JnL25ldGRldi9iZjllNWM3Ny01MTJkLTRlZmItYWQxZC1mMTQxMjBjNGUwNmJAYWR0cmFuLmNv
bQ0KDQpDaGFuZ2VzIGluIHYyOg0KICAtIEhhbmRsZSBib3RoIElDIHF1YWRzIHZpYSBzaW5nbGUg
ZHJpdmVyIGluc3RhbmNlDQogIC0gQWRkIGFyY2hpdGVjdHVyZSAmIHRlcm1pbm9sb2d5IGRlc2Ny
aXB0aW9uIGNvbW1lbnQNCiAgLSBDaGFuZ2UgcGlfZW5hYmxlLCBwaV9kaXNhYmxlLCBwaV9nZXRf
YWRtaW5fc3RhdGUgdG8gdXNlIFBPUlRfTU9ERSByZWdpc3Rlcg0KICAtIFJlbmFtZSBwb3dlciBw
b3J0cyB0byAncGknDQogIC0gVXNlIGkyY19zbWJ1c193cml0ZV9ieXRlX2RhdGEoKSBmb3Igc2lu
Z2xlIGJ5dGUgcmVnaXN0ZXJzDQogIC0gQ29kaW5nIHN0eWxlIGltcHJvdmVtZW50cw0KICAtIExp
bmsgdG8gdjE6IGh0dHBzOi8vbG9yZS5rZXJuZWwub3JnL25ldGRldi9hOTJiZTYwMy03YWQ0LTRk
ZDMtYjA4My01NDg2NThhNDQ0OGFAYWR0cmFuLmNvbQ0KDQotLS0NClBpb3RyIEt1YmlrICgyKToN
CiAgZHQtYmluZGluZ3M6IG5ldDogcHNlLXBkOiBBZGQgYmluZGluZ3MgZm9yIFNpMzQ3NCBQU0Ug
Y29udHJvbGxlcg0KICBuZXQ6IHBzZS1wZDogQWRkIFNpMzQ3NCBQU0UgY29udHJvbGxlciBkcml2
ZXINCg0KIC4uLi9iaW5kaW5ncy9uZXQvcHNlLXBkL3NreXdvcmtzLHNpMzQ3NC55YW1sICB8IDE0
NCArKysrKw0KIGRyaXZlcnMvbmV0L3BzZS1wZC9LY29uZmlnICAgICAgICAgICAgICAgICAgICB8
ICAxMSArDQogZHJpdmVycy9uZXQvcHNlLXBkL01ha2VmaWxlICAgICAgICAgICAgICAgICAgIHwg
ICAxICsNCiBkcml2ZXJzL25ldC9wc2UtcGQvc2kzNDc0LmMgICAgICAgICAgICAgICAgICAgfCA1
ODQgKysrKysrKysrKysrKysrKysrDQogNCBmaWxlcyBjaGFuZ2VkLCA3NDAgaW5zZXJ0aW9ucygr
KQ0KIGNyZWF0ZSBtb2RlIDEwMDY0NCBEb2N1bWVudGF0aW9uL2RldmljZXRyZWUvYmluZGluZ3Mv
bmV0L3BzZS1wZC9za3l3b3JrcyxzaTM0NzQueWFtbA0KIGNyZWF0ZSBtb2RlIDEwMDY0NCBkcml2
ZXJzL25ldC9wc2UtcGQvc2kzNDc0LmMNCg0KLS0gDQoyLjQzLjANCg0K

