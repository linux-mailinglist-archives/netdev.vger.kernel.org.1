Return-Path: <netdev+bounces-189160-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C5671AB0D04
	for <lists+netdev@lfdr.de>; Fri,  9 May 2025 10:21:12 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 577E2A07FCA
	for <lists+netdev@lfdr.de>; Fri,  9 May 2025 08:19:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2D4402741BD;
	Fri,  9 May 2025 08:19:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="UwrH32Bt"
X-Original-To: netdev@vger.kernel.org
Received: from NAM04-BN8-obe.outbound.protection.outlook.com (mail-bn8nam04on2048.outbound.protection.outlook.com [40.107.100.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B61AF272E6E;
	Fri,  9 May 2025 08:18:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.100.48
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746778740; cv=fail; b=kcAiLlXYBrAYioNTaNGciHJOVCaoMEan8xOFDsXE3alSfweUkR1QbrcNlyySH5snlQybjDjiDMG8veUFtat/SlGdbiqCCB2AFDyfitpfE4nhm27wl2LcUbcETVnptlXS/LvXwbrztjCF+NTzgacgeAx7FqNLajxQZjNlBRFlFLA=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746778740; c=relaxed/simple;
	bh=2V2A/4RfnLnALHMrdT4pIz7zd9vmV0dTcr3jEZ3ypCQ=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=gCh7bIgIFFCuPo/lhF3W0vg7nfaspEf4fd91wem/RjlFqCGP2SoWcuMtnlfWifbovQGU/KNLx90LaDccFFbpGKzp6xIkJAV1a/KH02gKfCpVV9Ci2XHp7SKdqaMWkDixL8JBfcV5VZiU2mShhEPV+MfVVthhnmwj7rHzHLdJVNk=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=UwrH32Bt; arc=fail smtp.client-ip=40.107.100.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=LxjmGcTmuFX+bpm3eMBcG1zozV48cZ3KBb4Nlh4I2pS4IfWAFWXV56F7brSoI9/p3TcYW6QdNur1M3T+QdA496ki7588Y93PXhmI0hHJJY/Epm3GraKpQVQ1nqnhlflGdh+jcs7xx5qEYFuq9zEu2W4/fyBtWYtdChGYDG5tHIAaNj0VeQoS2ue1irYMah4ZNI7DrdMKLdCB/ftln+2U+gEYOyR/mDIbuWk1s3/Ofmwtod5Xrb0b3bms1X6Es8ze4JwI+ZAHfIzhUsoIUjo6RoqxMqTXG19WTUVivR8VcpWWLC2wPuqxuDhoxTL7LTAwIq3jNUI6zHEkAYZ7skr3aQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=hlxKy47YXKrIXB4X06/WVtHtZeE8fD49VWm5K80YoTs=;
 b=q93bSQLB3qTiQdZOdnf89F9g+EaoDUduBhRwkxxE31mEZojLbJ7kdrG/JM/QIh/HGzch5369gA4IdANc5ev4530FY2V6cpS1pciRq4EoX1+ZQdRNure687pztWEmrV+MeJ5HYywE5KV85wUnwLoQQ9tj141p+ShqwWuYmJrZXTul317HBCfWtViUTlSYoQVMVEoy0ta/o5nm6+Iv0gDpcNQtSgksQe2HnyNjz8Jw9xzWwZCYMIQyovC/V/HyKP1Zohsdv29wDeEHn8fUoit1q5GNC1xLDpe3JByh2jyZTGcGajYbubjPv/ztVMwSlz2vhcK1b0Onfoy9Ttma8v6nJg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=hlxKy47YXKrIXB4X06/WVtHtZeE8fD49VWm5K80YoTs=;
 b=UwrH32Bt0OZ9GsJ1XFD/Uk+ZBs3zZD2dPIUS9NzXtHbeUsJCuEubRTyF7mrgkqwg7kAOJkFRl7FZ6tvnUZK20CEVMmtQcjqsKw/eYWzGY9tTu58R3PJd24Stn0B77Ns6yZf+qRR878HC0YUxoHPqS+CvQ74KFltAThdzo84rAZk=
Received: from BL3PR12MB6571.namprd12.prod.outlook.com (2603:10b6:208:38e::18)
 by DM4PR12MB6375.namprd12.prod.outlook.com (2603:10b6:8:a2::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8722.23; Fri, 9 May
 2025 08:18:49 +0000
Received: from BL3PR12MB6571.namprd12.prod.outlook.com
 ([fe80::4cf2:5ba9:4228:82a6]) by BL3PR12MB6571.namprd12.prod.outlook.com
 ([fe80::4cf2:5ba9:4228:82a6%4]) with mapi id 15.20.8722.021; Fri, 9 May 2025
 08:18:49 +0000
From: "Gupta, Suraj" <Suraj.Gupta2@amd.com>
To: "Gupta, Suraj" <Suraj.Gupta2@amd.com>, Can Ayberk Demir
	<ayberkdemir@gmail.com>, "netdev@vger.kernel.org" <netdev@vger.kernel.org>
CC: "Pandey, Radhey Shyam" <radhey.shyam.pandey@amd.com>, Andrew Lunn
	<andrew+netdev@lunn.ch>, "David S . Miller" <davem@davemloft.net>, Eric
 Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>, Paolo Abeni
	<pabeni@redhat.com>, "Simek, Michal" <michal.simek@amd.com>,
	"linux-arm-kernel@lists.infradead.org"
	<linux-arm-kernel@lists.infradead.org>, "linux-kernel@vger.kernel.org"
	<linux-kernel@vger.kernel.org>
Subject: RE: [PATCH v2] drivers: net: axienet: safely drop oversized RX frames
Thread-Topic: [PATCH v2] drivers: net: axienet: safely drop oversized RX
 frames
Thread-Index: AQHbwKzxjgO2LrCKBkeMM+DnkMfdzLPJ6QkwgAALASA=
Date: Fri, 9 May 2025 08:18:48 +0000
Message-ID:
 <BL3PR12MB6571553A36BAC1F5465CCAD8C98AA@BL3PR12MB6571.namprd12.prod.outlook.com>
References: <20250508150421.26059-1-ayberkdemir@gmail.com>
 <20250509063727.35560-1-ayberkdemir@gmail.com>
 <BL3PR12MB6571CC45853F09B6AD9477C9C98AA@BL3PR12MB6571.namprd12.prod.outlook.com>
In-Reply-To:
 <BL3PR12MB6571CC45853F09B6AD9477C9C98AA@BL3PR12MB6571.namprd12.prod.outlook.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
msip_labels:
 MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_ActionId=63c434cb-5c04-4bb9-b1e9-b11825536167;MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_ContentBits=0;MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_Enabled=true;MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_Method=Standard;MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_Name=AMD
 Internal Distribution
 Only;MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_SetDate=2025-05-09T07:37:19Z;MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_SiteId=3dd8961f-e488-4e60-8e11-a82d994e183d;MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_Tag=10,
 3, 0, 1;
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: BL3PR12MB6571:EE_|DM4PR12MB6375:EE_
x-ms-office365-filtering-correlation-id: 84534dc8-ee9a-4126-ffd4-08dd8ed22029
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230040|1800799024|366016|376014|38070700018;
x-microsoft-antispam-message-info:
 =?iso-8859-1?Q?1NG7Gl5/VlHFE4Yw0Evuqc4RJzrz2WhVtCKT/Fc/Le4DnQG8EFUZWtE61B?=
 =?iso-8859-1?Q?bfGDur2wm9o/R3AkZ7jheoUrm6m84X2F+ZM8r/IM6VbtBxQbwMzeTolxhB?=
 =?iso-8859-1?Q?v/dV8bUmA6Yy7cJxxFro/u6aCFi1MyHz0Dz8B7kKaz/iZaly5fqu7vV90R?=
 =?iso-8859-1?Q?Z0GddqBTFXqiKdN8eMAtARoNf/8Gxhr/A1DPXhIAWqcNAn1uz93Tl8GxdM?=
 =?iso-8859-1?Q?yAMQdyYKM4AMpwsfaOtdE8oK5Rd/SG1XQg3JGTDCmRPYcC36kF4KQiCC0b?=
 =?iso-8859-1?Q?9LncDLirZGa2kC2CnoYzLd/w8XboToDch9MznscyUttySk7xZ5/qjvn+Vo?=
 =?iso-8859-1?Q?lqAwTgvkezes4sw6nBxgLCzPMnYemu0WU0ED5qEZgPZnIbkZbOerskh1ha?=
 =?iso-8859-1?Q?j//vHEqzEFn1DZu23cNsuhXQWiWDSUZd0oW3U6JVgxfL3qvVnJtC+XCkiE?=
 =?iso-8859-1?Q?QWnpZ7SwlgAactIzh/A1zzJSdWg9yVy1jNbKgW4kIWBohv8PVMBCjb8TST?=
 =?iso-8859-1?Q?ltT3dOscXWOsUBfmZJJxGGLncolgmraA24jP9iSPH1g+d4BplDQIc14fGA?=
 =?iso-8859-1?Q?o8zGtLCoci393ff+p2zNK9y9L2V8ngYNkGchQVuYtAnFqqdN3wcbM04Afl?=
 =?iso-8859-1?Q?fltfwXIn6bTS11gBz/jVcXs1QBBL3DduFtlYlW43h/X3gwGl3hgh35MV0W?=
 =?iso-8859-1?Q?99Oj14YHVbk2nWG/xKs66sFMbOB7A2T1kIsWj53MaPbYzQSqwmQKWjmiaC?=
 =?iso-8859-1?Q?4dq6WLdacmf8rmSTKavRQLfxSiuIUlP6dWR8AwYLvM7QACyY/JFivMv0tl?=
 =?iso-8859-1?Q?3Zzb+i3yOfIQpxCD2QTCSkZVkAFg/73nh2l0e7EkhJ8pnmvjapRAErcKHT?=
 =?iso-8859-1?Q?sD6HXWZJa9dTQIKcEP9E2hpWmJVge/XIdwj4EbaQ0Z21H73y0d0OifV2R9?=
 =?iso-8859-1?Q?jcyMkIvs8N3H7YLcalVWH/MN+Zvo+WGVDNjiE/YjrjvKPp5+GxCimaK+T/?=
 =?iso-8859-1?Q?7hk/VucNw+7l94qnRUZXj2QA3H/AJlqCaU1uEIvYM8WrBXYoZpyvYqQEI4?=
 =?iso-8859-1?Q?lfp8E4Fxhjw/rH7Eto0Wga+9Rqp2TfhhqD0PCcRaua+sNHgbraKPGm/mEf?=
 =?iso-8859-1?Q?ublJdtEAwMXFZY/zFwI1awpAsKR7ja9Ge0H4tou8ouLaJuRGuEx/6Khdjx?=
 =?iso-8859-1?Q?xMeAFm8V752GV38FFUjZN/lVazd1BLTI6UTgqp+qKYxdEHaZjBzSQ9mze1?=
 =?iso-8859-1?Q?LmOR4e0mC8OjujxXlMFFZA+2X/LrqJZH3AGPjacsSJFaiBScfZfQTyHHPp?=
 =?iso-8859-1?Q?I5cnXD4cQ+TOCvHKuiJ0H160G1bXs8+QUGDPSBifqJsmuO2j8rft8fj1Pb?=
 =?iso-8859-1?Q?r25o+8Tpe7w8ykuWXkyhoWRsQzIcl1wNlgUwHV518kbEZP2I2of4vXpqfB?=
 =?iso-8859-1?Q?H7xTm+8tRet2XbKQ+phyJvPwMXjuNco1w7K6PizWy6NMELw27a7fMiyo6M?=
 =?iso-8859-1?Q?pqBod3gRnNUYux5epKp04YNN7pfIuTsDSmNR7uDLLERoiLBDg5E7HIHLqj?=
 =?iso-8859-1?Q?SOzpefI=3D?=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BL3PR12MB6571.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(376014)(38070700018);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?iso-8859-1?Q?nZQf5O5vjsTNZKbZSLndXOxOJk8ljdBxGlWABEev7ketMIoHtJLqmU02po?=
 =?iso-8859-1?Q?XnPY+R7A0h2hlP/XkImW+3rRY9fMIjMXUhb9ZBIN5GxaIgE3457ywQUc+H?=
 =?iso-8859-1?Q?vuSdDvS9GhZ+uM/d4jcsoP9E2deNt0mRN1MnZmHDkS9WiXdrX0SOBS4vkk?=
 =?iso-8859-1?Q?YAMFHMWDCEsXKvHKmvy/JIjP6J64AwjMM/gB6PXUPL6t09yC5iCSIuA9qp?=
 =?iso-8859-1?Q?wzE+OhyoZubSmOlwtkG2ADCRXOZZ6Xri4nYOTINFeyQgUyRrI18ajYC1Ak?=
 =?iso-8859-1?Q?QXFWGafZW5G6dmwbkZsb7qBDYQKd+sRUstb9AExr6hBmZ7XSUqXLlLtdo9?=
 =?iso-8859-1?Q?KvK/wHp8njUn1Ektmbhsos6TliyjjC79Jy1Sk/6SyIwsxkSnAse8BrJtow?=
 =?iso-8859-1?Q?MqKuL+MjZO3H8CdU0Ju2D4IwiIj279jYVBpV8RPJRinnWZ+039ZDZ92zyp?=
 =?iso-8859-1?Q?Sl1Iltw4zp3ks1Y557jSNesGiCTQpPxm4KNyhluxNQ3DMAt3vlPuzya+Gf?=
 =?iso-8859-1?Q?VMRb/iaRH8wXAvm8t3ARSdLYZq1C1HEcxwRnKgssfwwiRQVe2Ek0KSy0JL?=
 =?iso-8859-1?Q?OKcfSfADKp1XKyF5ZtzVzuRMwbLP7Nyc8kOHfzjuGv11IS4jlaPTraFfh/?=
 =?iso-8859-1?Q?EUja/EH53ZUdqF0a4Xhvw3NC5ZhGvc5iKEGNcLvqSWlLK++mFkya/QQwlu?=
 =?iso-8859-1?Q?SHEmV+4CIbU2fEHX2T1lOIMAIhsGXt9NXlzV17ednvHgECsz4UlmVCI/re?=
 =?iso-8859-1?Q?sn0wYhlcJfYV5769m9JF1WCX4e0l7W4/9LZDnH0cE5ETWVbfi+agFkCI1b?=
 =?iso-8859-1?Q?VsgjC6QJKHRV+YQDgLnk8wYea1OSg6peIH0k4edWASozQrfBb/iMmE3a60?=
 =?iso-8859-1?Q?GLnEAhyDFiVCl76kqjqHTG7kzAICAudVYuvkISwtlCr9AFdS7lY1mEqcaM?=
 =?iso-8859-1?Q?ari0YAGtgNK4KJJdAjElCLN0WCJuo3SJFjiQLTSoegMstHoaPO3GzO+9cc?=
 =?iso-8859-1?Q?nZKnqzV0zlZnZw1UzcNzbYRy8WSI/exsuGQGctrQGNzM4U76WNfFwINTuJ?=
 =?iso-8859-1?Q?LlLbVuqcpTWHx5AEifC8r5c7qQ5IjmJrl8SgKxP/I/D/jYUzSA1FJsYOjj?=
 =?iso-8859-1?Q?7I4lw9Enc+N4srBRF56ZDXI3qtQpBUz9OSehKSIPVLqkcn9LinCu7TCIzh?=
 =?iso-8859-1?Q?LM6j85EKAhXboVkfEkUUcLQXQLMXcz91hiwwZz502q/NXUboKhF3y/SOd8?=
 =?iso-8859-1?Q?1tVZa/xEbRRWHg5XhjRiHFOR3fO2pE4R4jGqJmQDMCkgKJWK9y2OitR3/+?=
 =?iso-8859-1?Q?HFk24mTAjpuPMBMSvrrKpHUjJ22LP8Ss4b9YIw8y2tI7CZiAfCzVJ0+m5z?=
 =?iso-8859-1?Q?se1bGCqDlr9eBzA42oUburVA8d/lJeul46YyujiTTKXkrnsFxCpcdYOCbc?=
 =?iso-8859-1?Q?KTk0/w4dvnAcpBtZeOellLIUmOcpa+KHNJlYsspu8SRSs+Frj/wEXVo9Z3?=
 =?iso-8859-1?Q?fR7trtgLek9OtW2iGp4OAmRR37cSJuad7wanfx/6efU6TXd7hZCBQvUnQ6?=
 =?iso-8859-1?Q?JReOCluOz8rkdbxpa7k5yMPjOFNEDSEexVWd860Ci7YPKram7ejxKkR41V?=
 =?iso-8859-1?Q?lGiB+QCoB76yg=3D?=
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BL3PR12MB6571.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 84534dc8-ee9a-4126-ffd4-08dd8ed22029
X-MS-Exchange-CrossTenant-originalarrivaltime: 09 May 2025 08:18:48.9998
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: l05+M1QCEssSPWQLWVYfpLr89+8FbtnKI1Tc2luPlUNbx20wQxldlOwjiSWhh1W5FflD5A4b1pEkBrrZsEPPYg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM4PR12MB6375

[AMD Official Use Only - AMD Internal Distribution Only]

> -----Original Message-----
> From: Gupta, Suraj <Suraj.Gupta2@amd.com>
> Sent: Friday, May 9, 2025 1:36 PM
> To: Can Ayberk Demir <ayberkdemir@gmail.com>; netdev@vger.kernel.org
> Cc: Pandey, Radhey Shyam <radhey.shyam.pandey@amd.com>; Andrew Lunn
> <andrew+netdev@lunn.ch>; David S . Miller <davem@davemloft.net>; Eric
> Dumazet <edumazet@google.com>; Jakub Kicinski <kuba@kernel.org>; Paolo
> Abeni <pabeni@redhat.com>; Simek, Michal <michal.simek@amd.com>; linux-
> arm-kernel@lists.infradead.org; linux-kernel@vger.kernel.org
> Subject: RE: [PATCH v2] drivers: net: axienet: safely drop oversized RX f=
rames
>
> [AMD Official Use Only - AMD Internal Distribution Only]
>
> Caution: This message originated from an External Source. Use proper caut=
ion
> when opening attachments, clicking links, or responding.
>
>
> [AMD Official Use Only - AMD Internal Distribution Only]
>
> > -----Original Message-----
> > From: Can Ayberk Demir <ayberkdemir@gmail.com>
> > Sent: Friday, May 9, 2025 12:07 PM
> > To: netdev@vger.kernel.org
> > Cc: Pandey, Radhey Shyam <radhey.shyam.pandey@amd.com>; Andrew Lunn
> > <andrew+netdev@lunn.ch>; David S . Miller <davem@davemloft.net>; Eric
> > Dumazet <edumazet@google.com>; Jakub Kicinski <kuba@kernel.org>; Paolo
> > Abeni <pabeni@redhat.com>; Simek, Michal <michal.simek@amd.com>;
> > linux- arm-kernel@lists.infradead.org; linux-kernel@vger.kernel.org;
> > Can Ayberk DEMIR <ayberkdemir@gmail.com>
> > Subject: [PATCH v2] drivers: net: axienet: safely drop oversized RX
> > frames
> >
>
> Since it's bug fix, please use subject prefix [Patch net vx]
>
>

There are compilation errors in your patch. Please test the build and basic=
 data transfer.

drivers/net/ethernet/xilinx/xilinx_axienet_main.c:1227:45: error: 'ndev' un=
declared (first use in this function); did you mean 'cdev'?
 1227 |                                 netdev_warn(ndev,
      |                                             ^~~~
      |                                             cdev


> > Caution: This message originated from an External Source. Use proper
> > caution when opening attachments, clicking links, or responding.
> >
> >
> > From: Can Ayberk DEMIR <ayberkdemir@gmail.com>
> >
> > This patch addresses style issues pointed out in v1.
>
> Please add changelogs below "---" after SOB
> >
> > In AXI Ethernet (axienet) driver, receiving an Ethernet frame larger
> > than the allocated skb buffer may cause memory corruption or kernel
> > panic, especially when the interface MTU is small and a jumbo frame is =
received.
> >
>
> Please add Fixes tag and better to add call trace of kernel crash.
>
> > Signed-off-by: Can Ayberk DEMIR <ayberkdemir@gmail.com>
> > ---
> >  .../net/ethernet/xilinx/xilinx_axienet_main.c | 46
> > +++++++++++--------
> >  1 file changed, 27 insertions(+), 19 deletions(-)
> >
> > diff --git a/drivers/net/ethernet/xilinx/xilinx_axienet_main.c
> > b/drivers/net/ethernet/xilinx/xilinx_axienet_main.c
> > index 1b7a653c1f4e..2b375dd06def 100644
> > --- a/drivers/net/ethernet/xilinx/xilinx_axienet_main.c
> > +++ b/drivers/net/ethernet/xilinx/xilinx_axienet_main.c
> > @@ -1223,28 +1223,36 @@ static int axienet_rx_poll(struct napi_struct
> > *napi, int
> > budget)
> >                         dma_unmap_single(lp->dev, phys, lp->max_frm_siz=
e,
> >                                          DMA_FROM_DEVICE);
> >
> > -                       skb_put(skb, length);
> > -                       skb->protocol =3D eth_type_trans(skb, lp->ndev)=
;
> > -                       /*skb_checksum_none_assert(skb);*/
> > -                       skb->ip_summed =3D CHECKSUM_NONE;
> > -
> > -                       /* if we're doing Rx csum offload, set it up */
> > -                       if (lp->features & XAE_FEATURE_FULL_RX_CSUM) {
> > -                               csumstatus =3D (cur_p->app2 &
> > -                                             XAE_FULL_CSUM_STATUS_MASK=
) >> 3;
> > -                               if (csumstatus =3D=3D XAE_IP_TCP_CSUM_V=
ALIDATED ||
> > -                                   csumstatus =3D=3D XAE_IP_UDP_CSUM_V=
ALIDATED) {
> > -                                       skb->ip_summed =3D CHECKSUM_UNN=
ECESSARY;
> > +                       if (unlikely(length > skb_tailroom(skb))) {
> > +                               netdev_warn(ndev,
> > +                                           "Dropping oversized RX
> > + frame (len=3D%u,
> > tailroom=3D%u)\n",
> > +                                           length, skb_tailroom(skb));
> > +                               dev_kfree_skb(skb);
> > +                               skb =3D NULL;
>
> Update packet drop in netdev stats?
>
> > +                       } else {
> > +                               skb_put(skb, length);
> > +                               skb->protocol =3D eth_type_trans(skb, l=
p->ndev);
> > +                               /*skb_checksum_none_assert(skb);*/
> > +                               skb->ip_summed =3D CHECKSUM_NONE;
> > +
> > +                               /* if we're doing Rx csum offload, set =
it up */
> > +                               if (lp->features & XAE_FEATURE_FULL_RX_=
CSUM) {
> > +                                       csumstatus =3D (cur_p->app2 &
> > +                                                       XAE_FULL_CSUM_S=
TATUS_MASK) >> 3;
> > +                                       if (csumstatus =3D=3D XAE_IP_TC=
P_CSUM_VALIDATED ||
> > +                                           csumstatus =3D=3D XAE_IP_UD=
P_CSUM_VALIDATED) {
> > +                                               skb->ip_summed =3D
> CHECKSUM_UNNECESSARY;
> > +                                       }
> > +                               } else if (lp->features &
> > XAE_FEATURE_PARTIAL_RX_CSUM) {
> > +                                       skb->csum =3D be32_to_cpu(cur_p=
->app3 & 0xFFFF);
> > +                                       skb->ip_summed =3D
> > + CHECKSUM_COMPLETE;
> >                                 }
> > -                       } else if (lp->features & XAE_FEATURE_PARTIAL_R=
X_CSUM) {
> > -                               skb->csum =3D be32_to_cpu(cur_p->app3 &=
 0xFFFF);
> > -                               skb->ip_summed =3D CHECKSUM_COMPLETE;
> > -                       }
> >
> > -                       napi_gro_receive(napi, skb);
> > +                               napi_gro_receive(napi, skb);
> >
> > -                       size +=3D length;
> > -                       packets++;
> > +                               size +=3D length;
> > +                               packets++;
> > +                       }
> >                 }
> >
> >                 new_skb =3D napi_alloc_skb(napi, lp->max_frm_size);
> > --
> > 2.39.5 (Apple Git-154)
> >
>


