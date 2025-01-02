Return-Path: <netdev+bounces-154682-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id CE34D9FF6C5
	for <lists+netdev@lfdr.de>; Thu,  2 Jan 2025 09:20:08 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 5374B7A1156
	for <lists+netdev@lfdr.de>; Thu,  2 Jan 2025 08:20:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 37C2D13CF82;
	Thu,  2 Jan 2025 08:20:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="rOoVZGNV"
X-Original-To: netdev@vger.kernel.org
Received: from NAM02-SN1-obe.outbound.protection.outlook.com (mail-sn1nam02on2087.outbound.protection.outlook.com [40.107.96.87])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7E2ED22083
	for <netdev@vger.kernel.org>; Thu,  2 Jan 2025 08:20:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.96.87
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1735806002; cv=fail; b=WcgDMRAdsZW/mXAhnFLMBbfKnkEYyBG4Tl+UpXCiz4wVVcdf1rjQrYnsPOZhghrZNJxr0ByVTOXmek7q0YAEZynrHdahW/mT9724HKB8MR9eNB+L6ENcB4HSL+vPKjg6pNsjjC94P0RBVjntoMM8GOU7k0b73Vg5NQaOENJ6wok=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1735806002; c=relaxed/simple;
	bh=ne9m+la3A6pvOBw468vut5EShIl291PViD4WIs2Wsx0=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=o10BdiYoanfyturCEbUC4oN9bt104e/JCrwrqCW+Mcs5puM8o9IQ8tsw95trV+TxacgSQAlrApbutw015OLhcXrZHuQzLKiYy4uVKYH4nco0l9SXBue8S3McjQKYvsWpmqXAjJ3VjQ1+a2wMoiFp++hoh+MDZt1eUmHLzIddp98=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=rOoVZGNV; arc=fail smtp.client-ip=40.107.96.87
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=cl03TEdr3XT8zG0GvgIHGOHgAWpXFj2otsdTYC6rkGEWtAfq9uSe4vlKtKAse4SZuciyPGNzIwIzTVD3vw6aseg+OW8rq2v34GxEj08YD3guWboSvQfAlYuTTBA9/g2wmNsiDwS+sRrnjoLe3uEDdP/Ga8uQoJlmuY5fNfAEA9QYQm6zDSkF9iiZY+9qNKyknK/yv0fNaRLmYmNbt1Mmy3aVQq9iwuMbaIrWm+EPmO1uhmVYxnH6SShXagOqgmzCa6GTQZCquoYZ12W0rq19JV1Blvni+O9yKSLrTgfLhuCdjSUrmhykGxTjXZcfShRb2sKCGpmMXkH29Tz3PCsSKw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ne9m+la3A6pvOBw468vut5EShIl291PViD4WIs2Wsx0=;
 b=DgXsdU/zfppMjY+fulRLFarHKdUUFbuVbeeT8555qPzeUCXs2qRwzrxEJr9QFGEAKpXFgMq0SUjJ42/78k+uX+q2iJvizNxJlkQhjNaFpn0Ns6xShNXeyOvEkpM4GnVmZ2HgfW851hWjdL8RdWYAlBt3ioHfBzVb6fU01zAjQI7uOfQDMEOFJb7WlSwj0CqIRMnd0NedHzTyM1ICbo6zTmNv2pgqyMgF7Aj8JuO2Dy1/Ajw9Vuv/coezEamejyZvWC81k3xy+KaXqjuE5JFcn6YGWT3dI90mm/aJwWkOKAcmJZrMQHrpaTxKaddC1HUy2FlOwb/JBbly6hrlJBRDmg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ne9m+la3A6pvOBw468vut5EShIl291PViD4WIs2Wsx0=;
 b=rOoVZGNVVqbbNI32j3D5CdjoH4CdWZgrFQrbF4PUkBLHdoYOyOkUnCwCqZ6OnVsv4ru+6LwYSiRZXyNnfZglwDhso1ylOvcyIMPbb4/znoV+9Rarul0iVt8XRukdtk9qYzcN51Z+PGI2wxICvl6k89W/NCygBKjljsfFjDGHPUvkzz2CYYlINNWC43WzmxjUPULs22ulchksyDk05FQwoC4+2b8Z5uNe4PdU1Oau9qLe38oF8TLriJdLdfWip2yUWLPQwcAEXPudP5BiQVVVCBvDCQrmMqQGplT1cr7h8WgXnKnduftOePcwTP2ZSlAeVdarLe6QRzxQ9KikL9/efg==
Received: from DM6PR12MB4516.namprd12.prod.outlook.com (2603:10b6:5:2ac::20)
 by SJ2PR12MB9085.namprd12.prod.outlook.com (2603:10b6:a03:564::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8314.12; Thu, 2 Jan
 2025 08:19:54 +0000
Received: from DM6PR12MB4516.namprd12.prod.outlook.com
 ([fe80::43e9:7b19:9e11:d6bd]) by DM6PR12MB4516.namprd12.prod.outlook.com
 ([fe80::43e9:7b19:9e11:d6bd%2]) with mapi id 15.20.8314.013; Thu, 2 Jan 2025
 08:19:53 +0000
From: Danielle Ratson <danieller@nvidia.com>
To: Daniel Zahka <daniel.zahka@gmail.com>
CC: "netdev@vger.kernel.org" <netdev@vger.kernel.org>, Jakub Kicinski
	<kuba@kernel.org>, Ido Schimmel <idosch@nvidia.com>, "mkubecek@suse.cz"
	<mkubecek@suse.cz>
Subject: RE: [RFC ethtool] ethtool: mock JSON output for --module-info
Thread-Topic: [RFC ethtool] ethtool: mock JSON output for --module-info
Thread-Index:
 AQHbHz7DQv+I+3IfGkOF2TEcLZxABLKPd+pQgAHPmYCACQ73QIAuaH6AgAJJKNCAAGFwgIABVcQggBTmQACAANtR8IAJxpXAgAHyqoCAFWV7kA==
Date: Thu, 2 Jan 2025 08:19:53 +0000
Message-ID:
 <DM6PR12MB451618A6A98EA0F5D4A6A549D8142@DM6PR12MB4516.namprd12.prod.outlook.com>
References: <7d3b3d56-b3cf-49aa-9690-60d230903474@gmail.com>
 <DM6PR12MB451628E919440310BC5726E5D8422@DM6PR12MB4516.namprd12.prod.outlook.com>
 <f0d2811d-e69f-4ef4-bf0f-21ab9c5a8b36@gmail.com>
 <DM6PR12MB4516A5E32EB6C663F907C24BD8492@DM6PR12MB4516.namprd12.prod.outlook.com>
 <cd258b2f-d43f-4ae6-bd7c-ca22777d35e3@gmail.com>
 <MN2PR12MB45179CC5F6CC57611E5024E2D8282@MN2PR12MB4517.namprd12.prod.outlook.com>
 <f3272bbe-3b3d-496e-95c6-9a35d469b6e7@gmail.com>
 <DM6PR12MB45169CD5A409D9B133EF3658D8292@DM6PR12MB4516.namprd12.prod.outlook.com>
 <02060f90-1520-4c17-9efe-8b701269f301@gmail.com>
 <DM6PR12MB4516F7998D67014D9835C5F5D83F2@DM6PR12MB4516.namprd12.prod.outlook.com>
 <DM6PR12MB4516E1A2E2C99E36ECA9D87AD8062@DM6PR12MB4516.namprd12.prod.outlook.com>
 <9e022720-f413-411c-be64-77c8b324549a@gmail.com>
In-Reply-To: <9e022720-f413-411c-be64-77c8b324549a@gmail.com>
Accept-Language: he-IL, en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: DM6PR12MB4516:EE_|SJ2PR12MB9085:EE_
x-ms-office365-filtering-correlation-id: 247fc8d6-d652-4a7e-bf74-08dd2b063bec
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230040|1800799024|376014|366016|38070700018;
x-microsoft-antispam-message-info:
 =?utf-8?B?S2NtWksrWnZHQThRRy80RVd4d3VUSS9hSnJNM0RncmJOTVJkTW5aaytxRzRV?=
 =?utf-8?B?TUMyNk0xZVVHT3ZIYWVFWEQ3NmFtY01IbGxRN3R0ajNNUkU3M1hXRVNIbkJD?=
 =?utf-8?B?ckxDZ1J4Y0s2L3lDZVZxczBKeXJrbXNpVW1XekhZU3ZJN2pOc0R2aTdkOW05?=
 =?utf-8?B?c1RJc2ErUXBNMDlYMmNQaTN3MnlSN085RzFvWTd3R3hDYWFiakc4M0xNa3or?=
 =?utf-8?B?Y21hTVZyRG9yY3NISDVDK0F6NGhRbXdiTHcrYWR5dFVOVnhzME5DN1ZTUjFK?=
 =?utf-8?B?M0RYZWNlLzdqcGdpbXE1WkNzeEE3YzJObWNkMSsrc25uR0ZCcmhmSnFtd2Nt?=
 =?utf-8?B?Z3VIZ3pxZ0hXcEJ4VmFHZFBuVkkvQ3pDODEvdHJKLzdCRFZlTi9NVm8waHNp?=
 =?utf-8?B?Nmw1U0xMdjdUNERBZW84ZCthYVZoU1hsL2RRK0h6ZlNLQ0tnbTVocnZiVGhZ?=
 =?utf-8?B?S3ZjemRONGNtZ0V1MnRCTU9KaVlNM1NjL2hCc01EVXFndVlINzY2OUwrWjFh?=
 =?utf-8?B?T1cwbnhDSFg1Z0lNdTkxS2JnTVJBUkp3TXpDbVVuMFE2a05qeWxXUGRsY2dr?=
 =?utf-8?B?aVV1aHN0a1hjWEFLZlcxVy92d3d1Sko4U0F1U21iREZGd0c2SCttNW1OUGw2?=
 =?utf-8?B?RWZEbkdXWjlwczBhQkNQSzhIdTMvOEF3a2VlS3lVbk1PR3kzcGlXYlkrUWlG?=
 =?utf-8?B?RktOeWVoeDIwTE9yNmc2Ri9kSWJtK2k5TDlob0I1a2RoMjIxRmRoekdjR3pu?=
 =?utf-8?B?S0Zid2dyQVBvNjZBNFdNR3hNMkx6YkdhcWRVRWNpdkFCdHc1SXJ5dkdNb3A4?=
 =?utf-8?B?RmlzVEtpZm8ycHQzYWJpdFNxSjJlWVFwV0xycVZVZmp0bFp0clhkRHM3SWFt?=
 =?utf-8?B?Z2YrOTV1ZUxNeC8xNXdqenIyM0pJa245TkYvOVlRb3VLb0ZHamlpekZ5aFMy?=
 =?utf-8?B?RitqYm91WXA2QXZILzN0R3hLM2tzVkJWclZ5N01vRzRKdkdOQVJ2KzVENGRw?=
 =?utf-8?B?cXcxTXdEaWpKaVRxRGFqdUNzQ0xSRTJZMkQvY0NOalFWRXcrVUE4aEMwWG8x?=
 =?utf-8?B?ak1RczJ3dE14OTloamI1YWFoTzlhaWxFbVZlSEVPRDNyclZTU0NndVp1ZXRl?=
 =?utf-8?B?SFY4QzJOYUpRSjRHdWpaVEhNakZIQmxpaGNLOUhXRktPU0tySy90RGFzcDlP?=
 =?utf-8?B?UWN4TTNGVkVOTU8zRUt1Snd6NEhOM2xNcXB1K0RJUng1bjhJNGZqR2F2cjRz?=
 =?utf-8?B?OFNNUVp5aFA1S2xtUVE0dE80b0krT3BsMXRDRHBFTEN6bDlnT2pEWUF2YnBU?=
 =?utf-8?B?MTRTTDJDeWc1cGpmVTg1VllNYlRnUTVLSkRYLzRSM1NEajcxYlNnMi9kVGoy?=
 =?utf-8?B?bnFodnJ5b21xb010MzhyMjRFWVBYVTUzdW4vb1lEaEkzK1ZjdjVHQ0JNYnFh?=
 =?utf-8?B?ang0TnE3OUwxNmJsdSttR01tb3FZeStoSW5YejJmM3kzQ0VtaXJTZVR3OFJk?=
 =?utf-8?B?OXR4MjVtUFlFM0ZnSVlNTjdMbk5RcEp4RUpaYzFsY2JORnp1eHRUL2hOUE5Q?=
 =?utf-8?B?R1hVdTdhcmRxVGZ6VDZmV0RHVGFkNzhEbDNkZ2VmaUlNOVcwdDY3bitrbm9o?=
 =?utf-8?B?UG1ydDJTRFZBM0FqM3M2TlhSaGxxYVo4UWVBNVFkNSthRTdGQUNYKzJYbzFp?=
 =?utf-8?B?LzFJbm1NMW1YR2ZGWkRLd1lCK3dJWW53TFhzSXI0TUFjYkNHQnJBSGVIS1Vk?=
 =?utf-8?B?NkVTVzFzNnRnUXF0ZW93dkJsMnZQc0JTK3pqb25hM3NRVVQ4aVZnVE0zRUdp?=
 =?utf-8?B?cW0ycFYzbWhRTFA0RTVVV1AxUDh6RFBBQVh0di9sYWRQeUFzUzFqZWxqQzFN?=
 =?utf-8?B?c1FFTGN1Y3N1N0U4UEp5RWo1SFhidk5xd29QS0Y0VTR0Qy9waEN5Z0lRemZR?=
 =?utf-8?Q?BrC0PAcReaId/dK9+AEIs147FSDpSx0d?=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM6PR12MB4516.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(376014)(366016)(38070700018);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?utf-8?B?ckRCKzhrVVFTSGJ6SzhObjVpYmRmQUp5MlI2bzYwR0t1QXJWNy9kMm10Tnp2?=
 =?utf-8?B?eFMwRXlpU0hXYlJXTkZOb1lUd3BYR2FNRnlTeTBJdFRJY2VIRDZjTUt5VERO?=
 =?utf-8?B?SXNUM3ZKSmIrdG5hMWlyQk9ENXp3Wlpja3BNRkNFZWt6cThVR2NLWTBoZUhz?=
 =?utf-8?B?YlRjdCtWVWorbjUwVW50TGY0SFFFeXdySFlPN2FVQlZOT2o1OG5lS25PQi9p?=
 =?utf-8?B?T3ZrN1ZZekNmQitjV0d4aGRYYnQ4YjdZYkhZREpkbWhJRGFld0s4L1VYL1Ri?=
 =?utf-8?B?ejZNZGZMKy9PZ2JkWGJ1U0tGSHlLYkRWb3IvbW9KU0RsbGxEVml2UjI3dldr?=
 =?utf-8?B?VndWMDFYWVB0OUdJYnlMZE9Sby9WekN1czhQRW1uK2Fmb01MV3ljOG5aNmY1?=
 =?utf-8?B?OW9LY2xwZ1NNV01KdDFWSkxQOUhDaW9SNng2UDY1QzBWUTBXWHNvdFpiUU5E?=
 =?utf-8?B?UlRiUnhwQWVQYnFLWDg4QUpreGVQR0FSb2dPQmJPZXpiMGZ4TDFabGlmNko2?=
 =?utf-8?B?RUFpdFdBZGFwSmxJZVNyOVpRK1dMdHlsb3hEbGdKNG0rMjRPTHo5bUdjVnVK?=
 =?utf-8?B?d0ZKZzN5cVpTcEdMUVR2VmVTVGl6NDEzbDJNdU45Nm9wZmUya1FwbGhGbVdi?=
 =?utf-8?B?YUtSMEwwMmtSYUJlUURoYU42WmMzclhVdXF3Qk9ldlBnR1VGSnl1c0Y4TGdk?=
 =?utf-8?B?Nno4WENwcDhXUlR6QWFxSmh0dXZJQjRqdmtkc0NDVUpyanV2SDhnYXRReHRo?=
 =?utf-8?B?c3NMb1dRN3Fvd1hQVmxNQ1BwWmd6dHcyNzAwbFlXeHQ4YjFVaGdPNXEwUVhI?=
 =?utf-8?B?ZjRmZGJ0czU4VEdHUjZ6S0F3Y3gyWXNlakkxb3pXd3BoYkV4Y0hMeXU4QzJv?=
 =?utf-8?B?Z2tqeTJFb0k0bUdkMHVURThDa24yNDlYNGtBcldPMUE1Rmo2NFJhMURIMmFy?=
 =?utf-8?B?QldoY05pN2d4a1VYMnF2OWM5ZWl5TlZ0YjVMUWorVHphK3dDMGIxRUl3YzB3?=
 =?utf-8?B?K0djT0lnalNRZ1pzTFZRWFhEcnMzcXF1M1pJb0c0VXRndWJ1OU82Z1JqTkMv?=
 =?utf-8?B?QjQ0bnV3UHVKckduaEtLQmloZGZqRmxpcWVZNXkyajRkZHhPYkVlRGVyL0pS?=
 =?utf-8?B?UUx0R3FXTVA2eldYdzZZSjFOeEgxcE9TM21EanBITnpoZE1KTDlNRFpCc2VU?=
 =?utf-8?B?UnRrODlTM0N4VnJINEtTS2w0NnV3dklLbkJBQkZJa25TdXFSV3I2MFdXVjZS?=
 =?utf-8?B?Tm9xOTNBSVN6TXd5NGpWUk1xSGdVc0FkUUU0MEI0M0RMdDdkaFdsdU5CbG5C?=
 =?utf-8?B?eXBWWGJlMzNmcEgvOUFNdml0bzYvVlRQb24raUJib3RDajBZVC9ZalpiTGRQ?=
 =?utf-8?B?cU1mZXBQcHovTW05YUhvRzNjeDBOcUlOSkFUY3ZVZTNsZFZYM3RWZmtiVnJR?=
 =?utf-8?B?d3VXUkRjWE9zcmplVjZRREdBM08rcDUrMmtQbCtxbVlrTWw5UURVNkVubldT?=
 =?utf-8?B?bUFBb000RHdHdVZqcXFDTTIzam1PQ0Vua3I3RW1ab3d0ZnE2QTAwWnRHVzVw?=
 =?utf-8?B?ZlpKYUtQLzJxY0paR3VtSjhVUFRraytoVlBLZHJpSnN0RmwybzM4R2tOeHVT?=
 =?utf-8?B?S2JWeEFmL1g1UGp6bjBRR00xRkFpUmZOWWpzTFVqbkxwQnR5b3RkWFowb1BT?=
 =?utf-8?B?MzEzRGZUa3cxbmFWMmJyK2o5bCtNVERmeG9ydGNRNDVHajc3S0JaVkRQdEJ3?=
 =?utf-8?B?cTdXc1VLejBGZy9pNlc1S0JWdDlhbHZlTk9Jb20yRGo4VHY0L1RNWXRhaXlI?=
 =?utf-8?B?Qnc2dzJ3Y3hSRWVmSnkxZEJ6OGF3ak5FaEp2NWN6WkV0SFFabTlpZHpNTmVo?=
 =?utf-8?B?aWxCbUJzbXZYdWh3bnZBVUNEL2dRTXBKVng3VWlySmEwVnZPUkU5WFBpUExR?=
 =?utf-8?B?aWRBSXhiMTFtQzl4QVBNY1dVd2RtUU5aYzM1dUZETEpDSkhEelU4NFg0OWZS?=
 =?utf-8?B?MUcwYkIxYnMvc25FblkwZW1Na3NDME0vWDJMY1kxMHFjU0JqNDhDWWVVL2wv?=
 =?utf-8?B?b1J3NmgySlVjUnJ2RDlvamtHM1NUVjczdHFQb29nN0VxbDZMekpTSXZQdEFn?=
 =?utf-8?Q?uH5dK9ORXE94iDOsRgYyLBsgb?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: DM6PR12MB4516.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 247fc8d6-d652-4a7e-bf74-08dd2b063bec
X-MS-Exchange-CrossTenant-originalarrivaltime: 02 Jan 2025 08:19:53.1598
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: sycJ2Kga2zwsAaGLUpuVAAMsXh1/SpzUpkGSanLxI0hQqwys6ec2cRHkuk9DOXKx5pcTOBIHwbkHZMVolfSFMQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ2PR12MB9085

SGksDQoNCkFueSBjb21tZW50cz8NCg0KPiAtLS0tLU9yaWdpbmFsIE1lc3NhZ2UtLS0tLQ0KPiBG
cm9tOiBEYW5pZWwgWmFoa2EgPGRhbmllbC56YWhrYUBnbWFpbC5jb20+DQo+IFNlbnQ6IFRodXJz
ZGF5LCAxOSBEZWNlbWJlciAyMDI0IDE5OjM1DQo+IFRvOiBEYW5pZWxsZSBSYXRzb24gPGRhbmll
bGxlckBudmlkaWEuY29tPg0KPiBDYzogbmV0ZGV2QHZnZXIua2VybmVsLm9yZzsgSmFrdWIgS2lj
aW5za2kgPGt1YmFAa2VybmVsLm9yZz47IElkbyBTY2hpbW1lbA0KPiA8aWRvc2NoQG52aWRpYS5j
b20+OyBta3ViZWNla0BzdXNlLmN6DQo+IFN1YmplY3Q6IFJlOiBbUkZDIGV0aHRvb2xdIGV0aHRv
b2w6IG1vY2sgSlNPTiBvdXRwdXQgZm9yIC0tbW9kdWxlLWluZm8NCj4gDQo+IA0KPiBPbiAxMi8x
OS8yNCA5OjE4IEFNLCBEYW5pZWxsZSBSYXRzb24gd3JvdGU6DQo+ID4gSGkgRGFuaWVsLA0KPiA+
DQo+ID4gSSBkaWRu4oCZdCBnZXQgYSByZXBseSBmcm9tIHlvdS4NCj4gPiBBbnl3YXksIGhlcmUn
cyBhIGxpa2UgdG8gbXkgZ2l0IHJlcG9zaXRvcnk6DQo+IGh0dHBzOi8vZ2l0aHViLmNvbS9kYW5p
ZWxsZXJ0cy9ldGh0b29sL3RyZWUvZWVwcm9tX2pzb25fcmZjLg0KPiA+IFRoZSBsYXN0IDQgY29t
bWl0cyBhcmUgdGhlIHJlbGV2YW50IG9uZXMuDQo+ID4NCj4gPiBBbGwgdGhlIENNSVMgbW9kdWxl
cyBkdW1wIGZpZWxkcyBhcmUgaW1wbGVtZW50ZWQgd2VyZSBzZW50IHRvIGludGVybmFsDQo+IHJl
dmlldy4NCj4gPg0KPiA+IFRoYW5rcywNCj4gPiBEYW5pZWxsZQ0KPiANCj4gDQo+IFRoYW5rIHlv
dSEgSSdsbCB0cnkgaXQgb3V0IG9uIG15IG1hY2hpbmVzLg0KDQo=

