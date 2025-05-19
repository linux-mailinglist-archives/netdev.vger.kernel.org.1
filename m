Return-Path: <netdev+bounces-191494-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 84848ABB9A8
	for <lists+netdev@lfdr.de>; Mon, 19 May 2025 11:40:59 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id E02C41896467
	for <lists+netdev@lfdr.de>; Mon, 19 May 2025 09:38:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 31EF926C3B0;
	Mon, 19 May 2025 09:24:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=microchip.com header.i=@microchip.com header.b="7LqVAirJ"
X-Original-To: netdev@vger.kernel.org
Received: from NAM12-DM6-obe.outbound.protection.outlook.com (mail-dm6nam12on2051.outbound.protection.outlook.com [40.107.243.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 098E14317D;
	Mon, 19 May 2025 09:23:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.243.51
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747646643; cv=fail; b=VbXInc8UA8gqg4d2zPvBXlItz2EOgAtwFo1ZsmPH9X9f5OK/S3/Rc6rzhq+IupAzCbN6HYXCZnp/pSXOCQRQkh4Wcc4MbozAdg6WUXMl/TCZGn5fLldbizKF+nkOofCo683y2qdsdDk1SxSCZBMHRiRvrH82GIMqIEum6PyoX80=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747646643; c=relaxed/simple;
	bh=EEbEv7KJnCxOimXUjaFy6R7s0kOmrgyizAr6EwWmzGU=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=b1rb1CxxDtAfg9y6qIkq1WnqaDHpUsxyA3WPmIkDonGJjRbQUwCfGQnB25IaAAlGcZRqPV6v+No61klncqIUikeU/881B/Hq0mvIV4s72/xRSV77QeZMPJiBKv+xh2SfDYDTDK2RrxKF94RxOc2wYpuPW2P8Cm6drNGZvpiQqZA=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=microchip.com; spf=pass smtp.mailfrom=microchip.com; dkim=pass (2048-bit key) header.d=microchip.com header.i=@microchip.com header.b=7LqVAirJ; arc=fail smtp.client-ip=40.107.243.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=microchip.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=microchip.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=yh7jq6IRTEJ/yv5AtKZ6nLpDEgp0/0HYmawAP9ZzHBVpArrP5e/S3C2jeehhfn5ciIdE+3r6FCx2UnJj1h6GHDiD8Eih83igtOdaESCGc/U9nTcSApHU6/dKm6wzfbWfP4NTO9WtqHjyiQxElCnzCAvFU95ngOLNTNFVHIT6AQ/FyEIr/ZZCLoSr1Eq/6x/Gk7Kl5a1C1nNwRs1wOL/DrybgS7eIOfNhzvwcPzvelHEopB/sLpCRlyO+Qy8aGmT4CY9ZofW1d/lTuYup91+GkOukQ3R8ssNBdr30rXIIt5TLtkIcWdaRYBSXuyymTqwVa5eGEltwKJMcufMp69RV+g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=EEbEv7KJnCxOimXUjaFy6R7s0kOmrgyizAr6EwWmzGU=;
 b=RBcHXTa7edcCxmQVFAswl9O531Q2ywp1+Mfkxg9K9j2hhoGAbaAHEt6hizSeF6FfE6ejKap23qk+vmkIjeyndvPx8qjQoVbziG0JqfpYkjcaiN0sdSo/oW38pyXGjWmFkaXUvzdIGVDA9SNj5dnPxvR6Kz6FrxbJ6gI+Pt3aZWv4ZOj8WniVsXMTefW4x9rUyPquGd4eLGEJvBIaRLBeV6g0ahVtRuoEk/q01ShePSf84ClOr+EDdEJnUPG8npx14CT78oIrynRusArreNI8sZMVRcY/3NNtfWaMK086Gvy+ovpNOMHRLZ3rE7DlhQvXEQ1uguxR5jErZwnt251R2g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=microchip.com; dmarc=pass action=none
 header.from=microchip.com; dkim=pass header.d=microchip.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=microchip.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=EEbEv7KJnCxOimXUjaFy6R7s0kOmrgyizAr6EwWmzGU=;
 b=7LqVAirJY9DsYy+sVMB/ppW693/SQSsJiBWvw50CeZURjlC2I9NuYB1p3X1b2T9ks0CeXX+UJCaCAP11Pcz7yo/x2WKlUOg72MswJpcnHg8yGVhb/cUWoK0HGeR/rKhG4A+m0lsVLF/P3HUaaWh/oewaoOMGaqxSWwuuTYdutHua3HhOP08hv3ewBjDkLO7ML0tOcjILChCv8sS8nHwi3Ev26dnQOyF+2N2Cqj+qfkYPb+TOUZPcM4i58BTPqyWE/leI8qiYW7rq5lzFTMrSnudPimpgVLDo+ytHAc164dRbtFVkfGWsdbaqIPI0rxDK0OsUyo5LZ8CKnouR8EjFhQ==
Received: from DM6PR11MB3209.namprd11.prod.outlook.com (2603:10b6:5:55::29) by
 SN7PR11MB7566.namprd11.prod.outlook.com (2603:10b6:806:34d::7) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.8746.30; Mon, 19 May 2025 09:23:57 +0000
Received: from DM6PR11MB3209.namprd11.prod.outlook.com
 ([fe80::18d6:e93a:24e4:7924]) by DM6PR11MB3209.namprd11.prod.outlook.com
 ([fe80::18d6:e93a:24e4:7924%3]) with mapi id 15.20.8746.030; Mon, 19 May 2025
 09:23:57 +0000
From: <Thangaraj.S@microchip.com>
To: <kuba@kernel.org>
CC: <andrew+netdev@lunn.ch>, <Bryan.Whitehead@microchip.com>,
	<davem@davemloft.net>, <linux-kernel@vger.kernel.org>,
	<netdev@vger.kernel.org>, <pabeni@redhat.com>, <edumazet@google.com>,
	<UNGLinuxDriver@microchip.com>
Subject: Re: [PATCH v1 net] net: lan743x: Restore SGMII CTRL register on
 resume
Thread-Topic: [PATCH v1 net] net: lan743x: Restore SGMII CTRL register on
 resume
Thread-Index: AQHbxhdD34wCQBQKWkedyDcav/M+M7PV64oAgAPGsgA=
Date: Mon, 19 May 2025 09:23:56 +0000
Message-ID: <067713e1ebaf303fe4aefb9c29cc7e1b70cd722a.camel@microchip.com>
References: <20250516035719.117960-1-thangaraj.s@microchip.com>
	 <20250516164010.49dd5e8b@kernel.org>
In-Reply-To: <20250516164010.49dd5e8b@kernel.org>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=microchip.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: DM6PR11MB3209:EE_|SN7PR11MB7566:EE_
x-ms-office365-filtering-correlation-id: 824e0b75-e794-4426-b30d-08dd96b6e1a6
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230040|1800799024|366016|376014|38070700018;
x-microsoft-antispam-message-info:
 =?utf-8?B?TUxTOHpnVC96eHJoRVcyUTFJU0U0UjZqOWsrR1V1OUczU0Q3QXFhNS9pRUlV?=
 =?utf-8?B?ekRnSVF5a1hIUEQyV1JhWUErdW1RQnhZZHh4anRub0RZUG1Mdy9wUURvdzZt?=
 =?utf-8?B?QVl4Sy9WSUJBTkZXd2RRYjYvdFk4Rk1IRGZ6djVoMmQyYThtZ3Q3YS8yU0JJ?=
 =?utf-8?B?WjZWeEhvcmNVRnh0OEY0cWs5eHpHcDN3Y09pRTBjcndSUzh5SmZmRkIwL3FO?=
 =?utf-8?B?OEN0Wkw3RUczcWJLMXhWTCtocDk2cUJsS2tkSEkvQ2oreGRYQStuc3JPZGIr?=
 =?utf-8?B?Tm1idUk1ZWozTTVqc3poU1U0SHoxMTBmTnc0a0RGeGZGNDliQ2ovVWkvRG4r?=
 =?utf-8?B?bDN3VzNuRCtsaHJ4cHlhOTJZT1oyQ0RVR1JaSXR6amtPRCtISEwwT2FLQnEv?=
 =?utf-8?B?MFJLeHVrMmdBTkdLbnZwOFZlYVZ2aWVhUkRVVE9qMlpOcDJTQ0lVWU5EMFV0?=
 =?utf-8?B?eHVRWndtZU1SK0JhdUxUYk5ZTTRsSTNWbnRiUjZSUHQzaWVxSFkxLzRremhS?=
 =?utf-8?B?Y2ZQM0RrVklZWVMxVmxVMHl5aXl1K1VrVUFkM2pleWxqNzJjRVFvWjZEYktQ?=
 =?utf-8?B?S25jOC8yS3ZGOG9xUTR5QVBJMHk0Sml6ZVpsN2g2MWlSb2FtUmFKNmdRUGgx?=
 =?utf-8?B?NGRueVNyQkRHRDlwVXcwcTZqNnFpRTFwUTVtcmsxZ2ZIMVRGQmNSbXFYclBR?=
 =?utf-8?B?VEdKb2dVT051YjJRNER2T3dIY2NVbWRzdmYxOTVzRzdXeGszN1JGWUN1ZlRX?=
 =?utf-8?B?c1lwQlVzb3IxSzZOS2NzZGZaWEkxY2NOOERaY0llZTVqRDdhZjBvRjFBc0l2?=
 =?utf-8?B?ZHA3dDh5QTZTc2RQZis0aWs5Zlh3WERCVHExb0tvYy9rc2lzTFlGMUxVSVgy?=
 =?utf-8?B?Z05RWC8zOUFjYVR3L3BjbGIwMHdWV0oyMy83YWVFWTlBLzh0Rlh1WTBJM2J6?=
 =?utf-8?B?c09VRWFBcGI4NHFUdHltdFVYc0Y1Nm5ZNGd1OWlRUDJrZ2xPWUZ0WExYWjFt?=
 =?utf-8?B?OVlnTWg3SGcxSHdXS3M5OTlqK1VaeG9XTFhCTGRBa0ZmbnpvMHMxTC9RcU55?=
 =?utf-8?B?R0lZVHlPekR0amNTV2dwcnFrSlQyeG9XcFRKdmU1N1hDc21MVExveDJpc1I5?=
 =?utf-8?B?Ym1ISVhySWNPTVhuaG4wVlJoblpQOGN0WXZEYTRjb1Bxa241djE0NDQ5SU9E?=
 =?utf-8?B?bDR6bkxVV3ZtQ2xzcElaRlZiMU5jc21Kd3R1YXl3eTJqeGVWY0tDdlNKcTdH?=
 =?utf-8?B?TkdFem40SXg2R3RrY1dYclI2Q1hqS3E3ZW1qQ0VkbXFKVmJkQ0pzdlc1TGRS?=
 =?utf-8?B?bkdEVXV1dyt5VGQ1Ui9HZDZzSTRLOVEwZUp1STVPWGpVSGRNUUhLTGxIblY1?=
 =?utf-8?B?YUNhNlJjZkROdEZPSHVuT0ZrUmpNL0I1WUlCdVZscXNiaUo0Z3MvUDNjd0Vo?=
 =?utf-8?B?UlE0TzFIemVBR3lwcmduVzljWlpRdExtNnkyN2JiQ1REUUR0Qm5qREVLNlJW?=
 =?utf-8?B?eE0xYm9jRFJtcVdxUk9GWjltVzVZekJiNU5mdmJlTlVrME5iOFFtYzFXeHNU?=
 =?utf-8?B?eUxKU2lxNkdYYWMvbk9XMmtzcTEvYzIySjBOZUhUZ2RxYlM3Nkp1RzNycGt1?=
 =?utf-8?B?VklyMlBnRjNLazVRSUVFZjZ0QjlIRzBHRytzQjBBcWZPYkVkaXRtQmRjRzdk?=
 =?utf-8?B?WUpld1hMOHpLOWxFQTMxVUI4WEJoVDZIM1RaejcrcElCSTdqd3h6Q3c0ZVlH?=
 =?utf-8?B?U3k2bjdqQ29IdkpQSEUza1VybGFabTQ0NlJFWXpqU1NycS8xUjV1UU1TVkEy?=
 =?utf-8?B?Mi9pU0g1NTM3cDg2aGQ1blg5UEFOQTdMVDMrcTM2VTluL3d2OTQrM2FKd056?=
 =?utf-8?B?eHhYMGR3U0lZWStlRHFFMjJOTUwrVkljdFMwbkZaTTB0Ukw3b0E4cjBuTU5M?=
 =?utf-8?B?STB6akxrTHM3WGZoUXZyVVNnamlHTk03YS93VWhEc0RtU01VZmt3RGpObVM0?=
 =?utf-8?Q?loEtA62XujSJZOp8gkJt9YcZLp+B5w=3D?=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM6PR11MB3209.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(376014)(38070700018);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?utf-8?B?VHFhOG56Z3BBdVc3UFlPMUlSc3NIQUVlZUZaUkM1L08xZG54dlJXaDV0b0RF?=
 =?utf-8?B?RFppWUpzNGJ0dUw0bmVFaGx6SFBhb3hvMDFRK2h1clVBVW85NGk3a0tXRUo3?=
 =?utf-8?B?NWlPaWdBcjRqaGNvQVNpYlBmbXdCdkt5cHNBd3grOW0wU3QwS1dvRUpvUklD?=
 =?utf-8?B?cUhIb0NqNU5wQnVPcjUvYWZ1WTNWdmluaFlURTlncXpna0YxWUR0ZitsWlRh?=
 =?utf-8?B?R3NFQWlBTitBNCtkTjlXY0ZCVU5YcTJOL0tQWGlpVXRsMXU0R3VzcEFZMXo5?=
 =?utf-8?B?aGdQbXRIRzJZNHIyT0xDRmNCRTgyUzkzbllFZTBJMXQwSUVZTUptaUo2OVUr?=
 =?utf-8?B?aVZLSDI0Y3B5cEVOVmg0anNZUGJ0ZWowMHZpUmI5MmNnNVEwUU91cGxITmR6?=
 =?utf-8?B?M3gzSjBCM2ZHZkJMWlpuQnFDVHpjVTZHQkY0TXgrK3pGZ1RGc1NGNGpJbDNh?=
 =?utf-8?B?aUE1WXU5V2hlVHRoVEF4blkrbWIwZ3piWk9LalNMUVBTNVBzcC82cEQ1clor?=
 =?utf-8?B?Z1FWT2dRWDFweWhRS3NrYTk5cHFub1JnZXhnSklBTElvRjB0SGJDRlJDc1RL?=
 =?utf-8?B?TDhCemNuc3FraDdzYXEzMWZkQ0FHZ28raG04Y2x5T0Z5NXU0Y1hNYzlMcWo1?=
 =?utf-8?B?TWhUNjRkaHRwUXcwSkhtZzg3WXJySGFoU2RUS3ppZDlVS1E5TVZlQ0RHc0R4?=
 =?utf-8?B?V1h2YWhIcUJoQkpnMVRwZkpQMXNwV1VFMkwyUUhaWUV2M1J1d3lUWWhSaHVG?=
 =?utf-8?B?a0VGZHJ1NDJKM1FBVFNNdGtlSnZ2WnJ2TytvUnZMV2dwektGcGRMNVF6MkMy?=
 =?utf-8?B?bkxmc3A0N2FJdXlLT29xaU1MakNMMXVaaUlXOU8yMEVHTDhPWkJ1TUpMRVJs?=
 =?utf-8?B?bHlNMWI2WVp3aW9POCtLWGRQZFc5b0F4eno0NDVaNXIxWjZ3YnBnYS9zR3hK?=
 =?utf-8?B?NGtxL2xOMDlnVVFxQnZyOUhoS082Q3BwTEptSzcvRlZuR2Z1WTJKRzltKzBC?=
 =?utf-8?B?WEtjQWV3ODR4YTlXMERiQjEwa0tHM2h2RVBveERZQTI5ZUVVK004RWh1R1ZP?=
 =?utf-8?B?azBwOFVFSEtBYThDR2VKaUJXVHN4MGluZWE5Z1htVzBIMGl6RDcyNm1CeTdR?=
 =?utf-8?B?bkRIdS9YMVZiWHZHMktDV2lWNHkxZWwyY05Dd2szMVNqZ3FQbkxsTmdTZVl4?=
 =?utf-8?B?SjBod05GY3dzVW14S2hXTDV0MDgrTmhLalVPRVRPSG0zZldobzFoT0lvVE81?=
 =?utf-8?B?YW9yMW5VNEdKcDY1MTAySE9rTktFM3hqVXhXazExNjJvTU5DR1EzNGpCMmZ0?=
 =?utf-8?B?U0dYRVk0UGlVTU5zc1dJYlBvYTc3TWdZM1EzeDhRZEpYS2N3dEtMRHArb1VU?=
 =?utf-8?B?VWM5M01LNVdhL3ZzYUtKdy9HeXJYdEpQZkhhMEtDMHlkdzdqT0VIZWN3bnZS?=
 =?utf-8?B?U0JVUDQ0eElPMkhaQWF5aVRuZGc4cGZrS3d3SVBrT25XdGJyb2JadjVsdy9S?=
 =?utf-8?B?RkVKQ2RDSXd6SUxIRThjSjBBTWtUaHZsYldjeEsvcTduYU1pcGhoVnkyQUxP?=
 =?utf-8?B?QjAxR3Q2TzRXZ0oxSDZiWlQ3dWMvazlTUEY2a1JoUkE3MGs3NmRJQkIvbm42?=
 =?utf-8?B?VFFGTWU2TFBpYUJrNENzYVUyeGl4YktWMDlXOHREUkhQWlVvMWdMTFF2bUF6?=
 =?utf-8?B?bk05MVRCS255dHRyWWV0OU1vOUtacUpwbzRWNmF5elVRNmZWYk9HZ0ZZc1Ri?=
 =?utf-8?B?dU12NVozNVZKU0hxSy9KVmJqZDdvdEwwT3RuS1g4S0hMb08yRzRJRk5Ua3Q5?=
 =?utf-8?B?clpoZEZJeGk4Ti8zdDI4OWxId0dlSXFxbXpnNzYwZlM2RFdCL3VMdkY4K3ps?=
 =?utf-8?B?Z2M4Z21pV3l5WVV5WGV3a3I3RTdvUHhJMEZvOXFacVVqZ3V6SDZUcDZIUisz?=
 =?utf-8?B?WDBxSVFIS1B2NEVHYVEzT1BlZnBrWWlHMXJtYkhMZlZLNGc3ajlOOWxJaG8w?=
 =?utf-8?B?YTl0b2JMOUNzYlltQTZqRG0rcFF2QzRHZ2UycmtIY3lEeTBtQnFWSGxFYzBj?=
 =?utf-8?B?QTZRVVE2bTJjcWJEc0dXOTJDVHIzNCtlbWJZRWM2Q29jVEtYMTVneXk0d2RW?=
 =?utf-8?B?WVFWUHdHd0dtZmwxMzlDSzArMWVaYzFzZys2VTF1aHREMXIrUHdNeUNJQ2I0?=
 =?utf-8?B?L1E9PQ==?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <091F122B0EDC5240A1F740DED440E269@namprd11.prod.outlook.com>
Content-Transfer-Encoding: base64
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-OriginatorOrg: microchip.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: DM6PR11MB3209.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 824e0b75-e794-4426-b30d-08dd96b6e1a6
X-MS-Exchange-CrossTenant-originalarrivaltime: 19 May 2025 09:23:57.0209
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3f4057f3-b418-4d4e-ba84-d55b4e897d88
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: xTkHy5k9IuG9HnKV8MJ4z7prs71P9nuV13NrbIuf/jvoleBGScPyYCrlICJ895/H0JHp1EBxveHjTCkds4lc1LDMQWTrxNl1XHRLudkAmtc=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN7PR11MB7566

SGkgSmFrdWIsDQpPbiBGcmksIDIwMjUtMDUtMTYgYXQgMTY6NDAgLTA3MDAsIEpha3ViIEtpY2lu
c2tpIHdyb3RlOg0KPiBFWFRFUk5BTCBFTUFJTDogRG8gbm90IGNsaWNrIGxpbmtzIG9yIG9wZW4g
YXR0YWNobWVudHMgdW5sZXNzIHlvdQ0KPiBrbm93IHRoZSBjb250ZW50IGlzIHNhZmUNCj4gDQo+
IE9uIEZyaSwgMTYgTWF5IDIwMjUgMDk6Mjc6MTkgKzA1MzAgVGhhbmdhcmFqIFNhbXluYXRoYW4g
d3JvdGU6DQo+ID4gU0dNSUlfQ1RSTCByZWdpc3Rlciwgd2hpY2ggc3BlY2lmaWVzIHRoZSBhY3Rp
dmUgaW50ZXJmYWNlLCB3YXMgbm90DQo+ID4gcHJvcGVybHkgcmVzdG9yZWQgd2hlbiByZXN1bWlu
ZyBmcm9tIHN1c3BlbmQuIFRoaXMgbGVkIHRvIGluY29ycmVjdA0KPiA+IGludGVyZmFjZSBzZWxl
Y3Rpb24gYWZ0ZXIgcmVzdW1lIHBhcnRpY3VsYXJseSBpbiBzY2VuYXJpb3MNCj4gPiBpbnZvbHZp
bmcNCj4gPiB0aGUgRlBHQS4NCj4gPiANCj4gPiBUbyBmaXggdGhpczoNCj4gPiAtIE1vdmUgdGhl
IFNHTUlJX0NUUkwgc2V0dXAgb3V0IG9mIHRoZSBwcm9iZSBmdW5jdGlvbi4NCj4gPiAtIEluaXRp
YWxpemUgdGhlIHJlZ2lzdGVyIGluIHRoZSBoYXJkd2FyZSBpbml0aWFsaXphdGlvbiBoZWxwZXIN
Cj4gPiBmdW5jdGlvbiwNCj4gPiB3aGljaCBpcyBjYWxsZWQgZHVyaW5nIGJvdGggZGV2aWNlIGlu
aXRpYWxpemF0aW9uIGFuZCByZXN1bWUuDQo+ID4gDQo+ID4gVGhpcyBlbnN1cmVzIHRoZSBpbnRl
cmZhY2UgY29uZmlndXJhdGlvbiBpcyBjb25zaXN0ZW50bHkgcmVzdG9yZWQNCj4gPiBhZnRlcg0K
PiA+IHN1c3BlbmQvcmVzdW1lIGN5Y2xlcy4NCj4gDQo+IElzIHRoZXJlIGEgcmVhc29uIHlvdSdy
ZSBub3QgQ0NpbmcgUmFqdSBMYWtrYXJhanUgb24gdGhpcz8NCj4gSGF2aW5nIGEgcmV2aWV3IHRh
ZyBmcm9tIHRoZSBhdXRob3Igb2YgdGhlIGNoYW5nZSB1bmRlciBGaXhlcw0KPiBpcyBhbHdheXMg
Z3JlYXQuDQpUaGFua3MgZm9yIHBvaW50aW5nIHRoaXMgb3V0Lg0KUmFqdSBMYWtrYXJhanUgaXMg
bm8gbG9uZ2VyIHdpdGggdGhlIGNvbXBhbnksIGFuZCBhcyBJIGFtIGN1cnJlbnRseW1hbmFnaW5n
IHRoaXMgZHJpdmVyLCBJIGhhdmUgbm90IGluY2x1ZGVkIGhpbSBpbiB0aGUgQ0MuDQoNClRoYW5r
cywNClRoYW5nYXJhaiBTYW15bmF0aGFuDQoNCg0K

