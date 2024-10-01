Return-Path: <netdev+bounces-130906-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 143D898BEE6
	for <lists+netdev@lfdr.de>; Tue,  1 Oct 2024 16:04:25 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 76AA0B21FCF
	for <lists+netdev@lfdr.de>; Tue,  1 Oct 2024 14:04:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C2D0C1C243B;
	Tue,  1 Oct 2024 14:04:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=microchip.com header.i=@microchip.com header.b="QRgFHeqF"
X-Original-To: netdev@vger.kernel.org
Received: from NAM02-DM3-obe.outbound.protection.outlook.com (mail-dm3nam02on2082.outbound.protection.outlook.com [40.107.95.82])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8DAA328F4;
	Tue,  1 Oct 2024 14:04:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.95.82
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727791460; cv=fail; b=VbmddnmNYAN8SPCYgV4e2JU8X0bLk2F1bXuotPL50F4IHyl2p/4hNwwq6GPy/PRV92sAPTmRDE8XmO4EgVTXSZBP/BnGI49A/RDudyir25Ll/F5HZ77suVkzdUT/SrWB7r/ebGLmJyRcqzbOPcS3H1eIOVu478zkg3C3WuAexTM=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727791460; c=relaxed/simple;
	bh=eM5HJ+/UVfC33c6bb0lqJoGF7ot/kmOz4q55AlDcVcE=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=uNKYue9eCfcl2aoHb79s1XhvWGopBpp+2ySjvQahwnm5HR/IFSKaa8Dh1johcS5EQ8HIvU42zJRXk9UIZ2qQb9cS53bvk2Qz6d4N0/L7/a1XhyoFgLCT8w//1C2FhUZJbvj7A0OQLxS8xjm4nk/wdl4MlDxoP8PHWqz0cqVqBqo=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=microchip.com; spf=pass smtp.mailfrom=microchip.com; dkim=pass (2048-bit key) header.d=microchip.com header.i=@microchip.com header.b=QRgFHeqF; arc=fail smtp.client-ip=40.107.95.82
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=microchip.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=microchip.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=thTTN1vcKFD9wgEEkRKQgcLJbuXAHbWMK3+bbrlMJfaTrdSIGIHxx48RLMaWdy2JvvA1YhPTLbppor+78iuLTqWiDIi8/F2s/Vz9+2ST5bMDyCICR2UtIQmNzJ6KXIGFI9/Jd3PUxzrnCVEh8hJx6GpidmVX52rT+ZUUvqQM+BZ/P/EFZ2kJgMRmlp9tut2RjWDjiLuCvPEzgxq1/EPaxneNVbmTN3KvS//8/ZcYip6F9OM4A/oRdmmBdy5jSUCbZkulx75xFkOSeEWMycn0T/rPce0322/nPOBQJyYM9QGZtWRz88ZOJ4HgJ5HH+lihvVLVRD4CqpG2jlKVaixMqQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=eM5HJ+/UVfC33c6bb0lqJoGF7ot/kmOz4q55AlDcVcE=;
 b=c1qANALk3bIUsJXuJ8tujPFnLiLHKLsNtDRh7k5QV6qSDtuwaXGT46k06fF7H6Ng2UIrrTGDY5RNj/daErbmQN3zKLDARGAAqvC4F61r3Z7ffTiqQ+sLaG3fGsx4loUEzd4fKVVXd23KXByT3VAYcPNIRtKwlO07DjaJojvVrX8FXzixTiX3Ox0e71Q7eQ4E33MRzlSjD7sYDhFTHMX2pJy0TwIfnkysTaR962Wk21+GPChMsUexJK0QDVtUehkEp/sOi43dpVYrdSyvjzOtdApdGh0bdfyT39vj1HAw5UB180jKmiZRytGyUkbC3UFu8IYrVjNNp180PUpplmZISw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=microchip.com; dmarc=pass action=none
 header.from=microchip.com; dkim=pass header.d=microchip.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=microchip.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=eM5HJ+/UVfC33c6bb0lqJoGF7ot/kmOz4q55AlDcVcE=;
 b=QRgFHeqF8PPxzLUbimL0udun6CptFwrGW3bvq9/1HkJNFpshPOlmL/QQigg9Y6anskXQYFkZ3VcGgPY+rlWGvuQUd99EDv8z1jXtsKoE5WHV5d9xXMLhdZnX3Yo4d1ROapm6H709gMC82gZoJ88SM+Fgkc5tIZywFnC2IfkBIe4MWn+sRCYTOd3Y1CBA502HC1fKBDaS8ZieZRJ9oqqoFM61z7uRqk89ZYWySVFc4Hl6dZ1pb/3ttKR7ARxgdt6wy6ek7cSzi2NLsfvIKtsRFk/9Wde/wHawSPWtKK5gvd3RAbOLwlIuN8bjyTfaVN9yIsjNAeyj28Wl/gKrh2CYNg==
Received: from CO1PR11MB4771.namprd11.prod.outlook.com (2603:10b6:303:9f::9)
 by CY5PR11MB6305.namprd11.prod.outlook.com (2603:10b6:930:23::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8005.27; Tue, 1 Oct
 2024 14:04:14 +0000
Received: from CO1PR11MB4771.namprd11.prod.outlook.com
 ([fe80::bfb9:8346:56a5:e708]) by CO1PR11MB4771.namprd11.prod.outlook.com
 ([fe80::bfb9:8346:56a5:e708%2]) with mapi id 15.20.8005.026; Tue, 1 Oct 2024
 14:04:14 +0000
From: <Divya.Koppera@microchip.com>
To: <Parthiban.Veerasooran@microchip.com>
CC: <Arun.Ramadoss@microchip.com>, <UNGLinuxDriver@microchip.com>,
	<andrew@lunn.ch>, <hkallweit1@gmail.com>, <linux@armlinux.org.uk>,
	<davem@davemloft.net>, <edumazet@google.com>, <kuba@kernel.org>,
	<pabeni@redhat.com>, <netdev@vger.kernel.org>, <linux-kernel@vger.kernel.org>
Subject: RE: [PATCH net-next] net: phy: microchip_t1: Interrupt support for
 lan887x
Thread-Topic: [PATCH net-next] net: phy: microchip_t1: Interrupt support for
 lan887x
Thread-Index: AQHbE01nB5y9tkf9zECXlzvwEYnrpLJxy8WAgAAhWWA=
Date: Tue, 1 Oct 2024 14:04:14 +0000
Message-ID:
 <CO1PR11MB477110AF5986F0BB3A0003ADE2772@CO1PR11MB4771.namprd11.prod.outlook.com>
References: <20240930153423.16893-1-divya.koppera@microchip.com>
 <e585b195-3213-46d2-807c-5906d5332502@microchip.com>
In-Reply-To: <e585b195-3213-46d2-807c-5906d5332502@microchip.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=microchip.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: CO1PR11MB4771:EE_|CY5PR11MB6305:EE_
x-ms-office365-filtering-correlation-id: 7d89c6f6-3bee-48af-3359-08dce221ee90
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CO1PR11MB4771.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(376014)(1800799024)(38070700018);DIR:OUT;SFP:1101;
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230040|366016|376014|1800799024|38070700018;
x-microsoft-antispam-message-info:
 =?utf-8?B?RnFQdE1jK0pCTVJBVTFyTEJlWVYvZE5GTTRtL20zVDYvUXJGY0dmaTVrV3ds?=
 =?utf-8?B?LzJzOThzQkhxODNEZVRiWUUrME16UGVwMXhkbStuSTVEM1YwQkt6azNpYWpR?=
 =?utf-8?B?L0p2K2NrYm5NRnhXTi8zS0ZyNHZ3aXNGQThwR3U1bkJ2cm8zQ0E0ZTNWWG9z?=
 =?utf-8?B?NXJxTmxndmRCVHU4a2t4MDVCMzBCUjlCckRjUWh5SjhNUDZKYkJpTmNjSFZE?=
 =?utf-8?B?NlcwRnpzTTRmazJxand4V2hRVFhBemc2dXZXRGlUdFI0NmRqRTRCTUxZdUoy?=
 =?utf-8?B?aHFHdVRnWWZLVU1QMlRaUGhDZTY4VDlrbjZRelhXQ2pjNWxydXNqaGt5ekhz?=
 =?utf-8?B?eFdoaUkyODZGK2ZNTW1KNXp1NWhrSm5mSVY4TWQ3T2lHYmR0RllucXVqZWRO?=
 =?utf-8?B?R3MwL0VLaWoyRGcwYiszWWZ1WUJtRitDcUV4TklaU2ZiNHQ3TDVGa0laeTlL?=
 =?utf-8?B?amh3OXpGNi8veEpOTDh4NitoWVR4YWlYeU5KL2lIU1VOeEU2R1JUWUVyMUhF?=
 =?utf-8?B?VjZKdWVnaEJwZWRYMHpGc1lRT0daWXNML1BkWmV1NkpjYmgyMDhoSTNRL1Rk?=
 =?utf-8?B?QmowZDkxUXUvZm5BNGx2WW9yM0ZsWS8rZGVmUm8zWEk0SnlGWDJFR1ZLNFZZ?=
 =?utf-8?B?VkdZbmg0T05aODR2U21YamxPS3FWSnpha0lWZTlONGsrVEdMak9DM2NtUisv?=
 =?utf-8?B?dW9tM2h2TnM2elhZN3dFNWlTL3Nxa1llbE9iVk1kVkltQnBZVjkvcm5aaFo5?=
 =?utf-8?B?Sk03WERuQXdvSmxyVkZ4a1BJNVJIZFBIaGV3OUZ5QlVqWUdkM0RORWVpa0Vj?=
 =?utf-8?B?QkRtaTdubElvVm5ZVW9XMVFWbEF5WFlXbUUxYlpXbGI1RDNzMi9HRHphYjdN?=
 =?utf-8?B?VzZNSjlhdTYreWE1TmZhSWdiWUlGTldDOHVPN0ZIdHZ2YjM4MHBGVFMyOGgy?=
 =?utf-8?B?NDZhcHVOQ2NFeWtIbm5nenkzVFdCcnNyUVp4aDlVSFhaS3FPcXgzaXJ5UEN3?=
 =?utf-8?B?ZnNheWh2dWVpUGJWU2pVcVFMcGVIV1VDYmNVanFESHhodDRPVXpuUWVHRGFq?=
 =?utf-8?B?VXJhZ0dYaWdlbnNUZDVUc1A3VDR2eUtVcHB5alo0RDlDT2hMeTRFV3JlVzNq?=
 =?utf-8?B?ZGk5N0ltaGNyMzZkVytZNmVDQjA3UkhGTkNLVGRsalhsbFRZaU11cm5OVG45?=
 =?utf-8?B?K3UzcFB0RllNZVJmeTAwejNJQ2UzNlBqcXp6WFZwV3daTW5BR2ZSTXJyWjZ1?=
 =?utf-8?B?T0hRVHJDNDQzZHNzSGRXVU80SnoyV3F1RE9tOERSWWh5U1V4NlRCdmxPZVB4?=
 =?utf-8?B?UW9NNUNTL1lJR0hxbXZ4L3JVSENEUkZQdUphWEprWXZsRm5rS2tyVjJ4cUg5?=
 =?utf-8?B?blJTQVRCN1hFK2ZVUUdBYXRkekEvTlVMTWt6c0x0a1lMQ2ZxU1RTL2c3VUZK?=
 =?utf-8?B?aHpLMlhHaXVtSG5ndHpQRm9ESDMxa2I3TUpqTHFheHkyb3lLcGF3dkE1c1Ur?=
 =?utf-8?B?YWVPM29RQVZMK0dYaXFCeTVZbklSaDVBMHJ1TGRsTVdKYVZ6cTY0U3E4eUM0?=
 =?utf-8?B?SjQzcGQ3TDc4aHkycWhYMnV5S0kyZFdRRmRMMUVlVitDSHRzU2FpaVlXdjhk?=
 =?utf-8?B?c3EvZFJFQVdjdlBjbFRTOFM3eXVpK3hzK3V4YlgvNk0wWnN4aFZJZHc3RkdB?=
 =?utf-8?B?UHY0YmQ1OFBkb3NFZWVtYjBhQXRKMm13VXhpN3RzMXFSL2U1Wi85c1pjNVhm?=
 =?utf-8?B?WmlpVlJxOE52cUJlb2l4SExEajlTR0RYcHVjdkhyVmtmRU9UdlRxZ3ljQzdS?=
 =?utf-8?B?WEtRSEEvcDlxalRxYXdQVjEzaFAxN3NDcUhPaUthZnNrZ3dWM3NNSSthUHVG?=
 =?utf-8?B?b1U2ZlYyQ3VXNzlVbkhyWkxIeCtNSi9PbVJmL2lHV2Ircmc9PQ==?=
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?utf-8?B?NC9xcDU3ak43TzVVb01VZ1BJcGhJV2JQZUtGU0FxZWg2VHF1SXJvNjhyV0VM?=
 =?utf-8?B?YmFpMmpzd0tYazk2c2NxV2ZKemJpNnZkNVc3cXRBYnBJenRkNDNSVXF1QXhU?=
 =?utf-8?B?WU5DeGNLckNoMFBqaUpDVU4zVVErUy9RTEdJSE5tKy9jOTJuZExhL2huQjBD?=
 =?utf-8?B?dCtHWllRMWluSy9MYWRzRGJKelEzenN1UGs5L1d6endWNm12Sk5kajFnRzJ1?=
 =?utf-8?B?YUN1R1pacEVNNkVnSnNmNnRqZkFpK05JV1kxNmZEaSt2MVhFazFCZ21vRC8w?=
 =?utf-8?B?clRpUWNHcWluR0xEQzloaHM4NXhrckM2d2dtNFdxQlRjVEpPWDdPUWpOd2J5?=
 =?utf-8?B?SWpJeGd3SFRnbzVHZmZVems0YUk0V0FsQStRYy8xNVlzbFFwb1FqUXVOaC9Q?=
 =?utf-8?B?bmk1a1VTZFFhVTUwNGhaL05DZUlMQzlLUjVqMkcraFZleUtjMUhUNkM5eEpW?=
 =?utf-8?B?QXdMajZNcUZEdzhPU1k3c0t1bXN5ZmZKUVZhdHY3WVJhckx0aUVBQUxPWFZ5?=
 =?utf-8?B?S2FNY2pqWkRqWjRhbjJUMTJ2MWZQazlUVWlpbmxiUGUvQm1mTnB5ZWdFRloz?=
 =?utf-8?B?OVZYMWR3SDlVS3p3dHVhK0t3UWcvRnRRY29iZkdXcFJMMFhaYWcvNHozQWF1?=
 =?utf-8?B?T1dDNjllOS8rZ2p5UjlHVExmOGh3Ryt4aUpyekgyZGI4enErUm1IOUphdUEx?=
 =?utf-8?B?Y20xL0NHUnhSbGh6dk8ya2htWW51TnNrQVBSVUw3RkQ0OExHc2ZlOG5JSlhF?=
 =?utf-8?B?OGg4M0NGVUJ6TEMxVXNxNHhYd2VvYml1cWNUVkx5cFRHQlZZWnBPVlFIWGJp?=
 =?utf-8?B?Y0tmQXpqcDlzQWtLNk0rUU9MVTg4c0FKUHViRloyNVU0N1hTdFNObHJQNk5S?=
 =?utf-8?B?dDVZSVJDWExCV2pZWXBCeXg5V2RxWXlvRElmQk40bWFKTjFjMmpuMkhBQ3pk?=
 =?utf-8?B?ZG5KV05jQk0xanNuQkxpNmEwVTR4alAwbzkvRU51b29ZYXV4YmFqZ1BRSkhq?=
 =?utf-8?B?Tmd2d2lvcFdpOUs4OG84cFNRdjR1QXNJYjEwZTY5YWVXQmc1SXhtanJNQS9Z?=
 =?utf-8?B?S0wzaEtNTDYwUndaRm92c0lzV2UyaHdKM3BvK21Da1U4QmxML1J1ZG1sT0th?=
 =?utf-8?B?TTNyNkl0amVFSXRSL3lXT2dxNVZBNUMvaTNSVkg1QzB2bXFUM0VGdHEybzVr?=
 =?utf-8?B?OHFQRjUvL3FtS0RyY1p3N29XOEF1V0JTTnA1eEtXOXd5eGl5ZzVNMFpEbDhh?=
 =?utf-8?B?S0tlNlZqdDA2MGVwTlNvRHR6ODlzcFM1bGcvR05DNkdBWWROaDNhaWJsVFhE?=
 =?utf-8?B?cks5SlM2b0x3RG5ZcDUzNnBjeTRoL1ZUMEI2d29rY2RhVDJ6bGlpSG5MVGt2?=
 =?utf-8?B?V3pRSFhqSTVnQ2ViZkJXQTZwRkRPdTBVWjRuWWdoa0dqT1BYUk5RYnBOVWdS?=
 =?utf-8?B?aE5GaTR3UFhiczlrNEF6anE4eERGSWIrVWk0WUR5aFNJRUJObzlrL1ViQVdV?=
 =?utf-8?B?M0ZUWmtmMW1tbWxXVktCYTJ5SnJ0S2NVNmFHS1FUZVVDa1NhSHJ6aTRxZTBw?=
 =?utf-8?B?RmRMWFFMOWxlc21HWUMzS285UlNmQTJXbU9GcjgwSlVhRUVBOFR3Y3NVTEps?=
 =?utf-8?B?THppak5INGpUTXZyZGhBd3dQZzVraXdmYUJ6Y2lJeFpYUnF4RUZqd1NSRkor?=
 =?utf-8?B?TXJOZDN6MXdCL29uRkYyWVBlSUtEOXZnQ1hnUUlTdWVhYzB0UzZRbHhaYzE0?=
 =?utf-8?B?S3A0RVR6MlE1Qk5LTFg0ZGN5blQwUUs0aVNVUU5hb25SRnkxb25IOG9TU05Y?=
 =?utf-8?B?YUFqSXIwRmZTZktXUEdSY0l6QlZueEZRR1Q1L2RKUGRNK2RqVFV4Q1pwekI1?=
 =?utf-8?B?MHMyNi9tUHV0d1llczNvVFpGNEpvMUZPd0VPeDVYM0cyM044UUltTFpOakZ2?=
 =?utf-8?B?Z2dyREVBMit3Y0xXSmlLeHdhS3M2djdDcll3Q1RWbnJSMnFVSGtvcnZ1ZkNR?=
 =?utf-8?B?UzF3TTcrLy8zekwrdW04RXFnamhVM0g3c1p1WTdEVnZycElxcGt6NStzb1JY?=
 =?utf-8?B?bVRuOVNZY25qZUtBUjVaUHJ1b3lKMDhwU201dG54ZzlUcUMyMVg5MmFhL0dU?=
 =?utf-8?Q?wKgbbSd/fQHAGSFA3AYtwAPWI?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-OriginatorOrg: microchip.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: CO1PR11MB4771.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 7d89c6f6-3bee-48af-3359-08dce221ee90
X-MS-Exchange-CrossTenant-originalarrivaltime: 01 Oct 2024 14:04:14.3769
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3f4057f3-b418-4d4e-ba84-d55b4e897d88
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: W8EVpUTPmVrPhJ+9jdSBi1D8xXKzHBQWMTNjGHZO1qxABHd2v8VDnm2kfc9AZ8HFoh0lis7rCGroMoliHQ8ywI8dit95GAvW7QMKl0QxOW4=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY5PR11MB6305

SGkgUGFydGhpYmFuLA0KDQpUaGFua3MgZm9yIHRoZSByZXZpZXcgY29tbWVudHMuIFBsZWFzZSBm
aW5kIG15IHJlcGx5IGlubGluZS4NCg0KPiAtLS0tLU9yaWdpbmFsIE1lc3NhZ2UtLS0tLQ0KPiBG
cm9tOiBQYXJ0aGliYW4gVmVlcmFzb29yYW4gLSBJMTcxNjQNCj4gPFBhcnRoaWJhbi5WZWVyYXNv
b3JhbkBtaWNyb2NoaXAuY29tPg0KPiBTZW50OiBUdWVzZGF5LCBPY3RvYmVyIDEsIDIwMjQgNToy
OCBQTQ0KPiBUbzogRGl2eWEgS29wcGVyYSAtIEkzMDQ4MSA8RGl2eWEuS29wcGVyYUBtaWNyb2No
aXAuY29tPg0KPiBDYzogQXJ1biBSYW1hZG9zcyAtIEkxNzc2OSA8QXJ1bi5SYW1hZG9zc0BtaWNy
b2NoaXAuY29tPjsNCj4gVU5HTGludXhEcml2ZXIgPFVOR0xpbnV4RHJpdmVyQG1pY3JvY2hpcC5j
b20+OyBhbmRyZXdAbHVubi5jaDsNCj4gaGthbGx3ZWl0MUBnbWFpbC5jb207IGxpbnV4QGFybWxp
bnV4Lm9yZy51azsgZGF2ZW1AZGF2ZW1sb2Z0Lm5ldDsNCj4gZWR1bWF6ZXRAZ29vZ2xlLmNvbTsg
a3ViYUBrZXJuZWwub3JnOyBwYWJlbmlAcmVkaGF0LmNvbTsNCj4gbmV0ZGV2QHZnZXIua2VybmVs
Lm9yZzsgbGludXgta2VybmVsQHZnZXIua2VybmVsLm9yZw0KPiBTdWJqZWN0OiBSZTogW1BBVENI
IG5ldC1uZXh0XSBuZXQ6IHBoeTogbWljcm9jaGlwX3QxOiBJbnRlcnJ1cHQgc3VwcG9ydCBmb3IN
Cj4gbGFuODg3eA0KPiANCj4gSGksDQo+IA0KPiBPbiAzMC8wOS8yNCA5OjA0IHBtLCBEaXZ5YSBL
b3BwZXJhIHdyb3RlOg0KPiA+IEFkZCBzdXBwb3J0IGZvciBsaW5rIHVwIGFuZCBsaW5rIGRvd24g
aW50ZXJydXB0cyBpbiBsYW44ODd4Lg0KPiA+DQo+ID4gU2lnbmVkLW9mZi1ieTogRGl2eWEgS29w
cGVyYSA8ZGl2eWEua29wcGVyYUBtaWNyb2NoaXAuY29tPg0KPiA+IC0tLQ0KPiA+ICAgZHJpdmVy
cy9uZXQvcGh5L21pY3JvY2hpcF90MS5jIHwgNjMNCj4gKysrKysrKysrKysrKysrKysrKysrKysr
KysrKysrKysrKw0KPiA+ICAgMSBmaWxlIGNoYW5nZWQsIDYzIGluc2VydGlvbnMoKykNCj4gPg0K
PiA+IGRpZmYgLS1naXQgYS9kcml2ZXJzL25ldC9waHkvbWljcm9jaGlwX3QxLmMNCj4gPiBiL2Ry
aXZlcnMvbmV0L3BoeS9taWNyb2NoaXBfdDEuYyBpbmRleCBhNWVmOGZlNTA3MDQuLjM4MzA1MGE1
YjBlZA0KPiA+IDEwMDY0NA0KPiA+IC0tLSBhL2RyaXZlcnMvbmV0L3BoeS9taWNyb2NoaXBfdDEu
Yw0KPiA+ICsrKyBiL2RyaXZlcnMvbmV0L3BoeS9taWNyb2NoaXBfdDEuYw0KPiA+IEBAIC0yMjYs
NiArMjI2LDE4IEBADQo+ID4gICAjZGVmaW5lIE1JQ1JPQ0hJUF9DQUJMRV9NQVhfVElNRV9ESUZG
CVwNCj4gPiAgIAkoTUlDUk9DSElQX0NBQkxFX01JTl9USU1FX0RJRkYgKw0KPiBNSUNST0NISVBf
Q0FCTEVfVElNRV9NQVJHSU4pDQo+ID4NCj4gPiArI2RlZmluZSBMQU44ODdYX0lOVF9TVFMJCQkJ
MHhmMDAwDQo+ID4gKyNkZWZpbmUgTEFOODg3WF9JTlRfTVNLCQkJCTB4ZjAwMQ0KPiA+ICsjZGVm
aW5lIExBTjg4N1hfSU5UX01TS19UMV9QSFlfSU5UX01TSwkJQklUKDIpDQo+ID4gKyNkZWZpbmUg
TEFOODg3WF9JTlRfTVNLX0xJTktfVVBfTVNLCQlCSVQoMSkNCj4gPiArI2RlZmluZSBMQU44ODdY
X0lOVF9NU0tfTElOS19ET1dOX01TSwkJQklUKDApDQo+ID4gKw0KPiA+ICsjZGVmaW5lIExBTjg4
N1hfTVhfQ0hJUF9UT1BfTElOS19NU0sNCj4gCShMQU44ODdYX0lOVF9NU0tfTElOS19VUF9NU0sg
fFwNCj4gPiArDQo+IExBTjg4N1hfSU5UX01TS19MSU5LX0RPV05fTVNLKQ0KPiA+ICsNCj4gPiAr
I2RlZmluZSBMQU44ODdYX01YX0NISVBfVE9QX0FMTF9NU0sNCj4gCShMQU44ODdYX0lOVF9NU0tf
VDFfUEhZX0lOVF9NU0sgfFwNCj4gPiArCQkJCQkgTEFOODg3WF9NWF9DSElQX1RPUF9MSU5LX01T
SykNCj4gPiArDQo+ID4gICAjZGVmaW5lIERSSVZFUl9BVVRIT1IJIk5pc2FyIFNheWVkIDxuaXNh
ci5zYXllZEBtaWNyb2NoaXAuY29tPiINCj4gPiAgICNkZWZpbmUgRFJJVkVSX0RFU0MJIk1pY3Jv
Y2hpcCBMQU44N1hYL0xBTjkzN3gvTEFOODg3eCBUMQ0KPiBQSFkgZHJpdmVyIg0KPiA+DQo+ID4g
QEAgLTE0NzQsNiArMTQ4Niw3IEBAIHN0YXRpYyB2b2lkIGxhbjg4N3hfZ2V0X3N0cmluZ3Moc3Ry
dWN0IHBoeV9kZXZpY2UNCj4gKnBoeWRldiwgdTggKmRhdGEpDQo+ID4gICAJCWV0aHRvb2xfcHV0
cygmZGF0YSwgbGFuODg3eF9od19zdGF0c1tpXS5zdHJpbmcpOw0KPiA+ICAgfQ0KPiA+DQo+ID4g
K3N0YXRpYyBpbnQgbGFuODg3eF9jb25maWdfaW50cihzdHJ1Y3QgcGh5X2RldmljZSAqcGh5ZGV2
KTsNCj4gPiAgIHN0YXRpYyBpbnQgbGFuODg3eF9jZF9yZXNldChzdHJ1Y3QgcGh5X2RldmljZSAq
cGh5ZGV2LA0KPiA+ICAgCQkJICAgIGVudW0gY2FibGVfZGlhZ19zdGF0ZSBjZF9kb25lKQ0KPiA+
ICAgew0KPiA+IEBAIC0xNTA0LDYgKzE1MTcsMTAgQEAgc3RhdGljIGludCBsYW44ODd4X2NkX3Jl
c2V0KHN0cnVjdCBwaHlfZGV2aWNlDQo+ICpwaHlkZXYsDQo+ID4gICAJCWlmIChyYyA8IDApDQo+
ID4gICAJCQlyZXR1cm4gcmM7DQo+ID4NCj4gPiArCQlyYyA9IGxhbjg4N3hfY29uZmlnX2ludHIo
cGh5ZGV2KTsNCj4gPiArCQlpZiAocmMgPCAwKQ0KPiA+ICsJCQlyZXR1cm4gcmM7DQo+ID4gKw0K
PiA+ICAgCQlyYyA9IGxhbjg4N3hfcGh5X3JlY29uZmlnKHBoeWRldik7DQo+ID4gICAJCWlmIChy
YyA8IDApDQo+ID4gICAJCQlyZXR1cm4gcmM7DQo+ID4gQEAgLTE4MzAsNiArMTg0Nyw1MCBAQCBz
dGF0aWMgaW50IGxhbjg4N3hfY2FibGVfdGVzdF9nZXRfc3RhdHVzKHN0cnVjdA0KPiBwaHlfZGV2
aWNlICpwaHlkZXYsDQo+ID4gICAJcmV0dXJuIGxhbjg4N3hfY2FibGVfdGVzdF9yZXBvcnQocGh5
ZGV2KTsNCj4gPiAgIH0NCj4gPg0KPiA+ICtzdGF0aWMgaW50IGxhbjg4N3hfY29uZmlnX2ludHIo
c3RydWN0IHBoeV9kZXZpY2UgKnBoeWRldikgew0KPiA+ICsJaW50IHJldDsNCj4gPiArDQo+ID4g
KwlpZiAocGh5ZGV2LT5pbnRlcnJ1cHRzID09IFBIWV9JTlRFUlJVUFRfRU5BQkxFRCkgew0KPiA+
ICsJCS8qIENsZWFyIHRoZSBpbnRlcnJ1cHQgc3RhdHVzIGJlZm9yZSBlbmFibGluZyBpbnRlcnJ1
cHRzICovDQo+ID4gKwkJcmV0ID0gcGh5X3JlYWRfbW1kKHBoeWRldiwgTURJT19NTURfVkVORDEs
DQo+IExBTjg4N1hfSU5UX1NUUyk7DQo+ID4gKwkJaWYgKHJldCA8IDApDQo+ID4gKwkJCXJldHVy
biByZXQ7DQo+ID4gKw0KPiA+ICsJCS8qIFVubWFzayBmb3IgZW5hYmxpbmcgaW50ZXJydXB0ICov
DQo+ID4gKwkJcmV0ID0gcGh5X3dyaXRlX21tZChwaHlkZXYsIE1ESU9fTU1EX1ZFTkQxLA0KPiBM
QU44ODdYX0lOVF9NU0ssDQo+ID4gKwkJCQkgICAgKHUxNil+TEFOODg3WF9NWF9DSElQX1RPUF9B
TExfTVNLKTsNCj4gPiArCX0gZWxzZSB7DQo+ID4gKwkJcmV0ID0gcGh5X3dyaXRlX21tZChwaHlk
ZXYsIE1ESU9fTU1EX1ZFTkQxLA0KPiBMQU44ODdYX0lOVF9NU0ssDQo+ID4gKwkJCQkgICAgR0VO
TUFTSygxNSwgMCkpOw0KPiA+ICsJCWlmIChyZXQgPCAwKQ0KPiA+ICsJCQlyZXR1cm4gcmV0Ow0K
PiA+ICsNCj4gPiArCQlyZXQgPSBwaHlfcmVhZF9tbWQocGh5ZGV2LCBNRElPX01NRF9WRU5EMSwN
Cj4gTEFOODg3WF9JTlRfU1RTKTsNCj4gPiArCX0NCj4gPiArDQo+ID4gKwlyZXR1cm4gcmV0IDwg
MCA/IHJldCA6IDA7DQo+ID4gK30NCj4gPiArDQo+ID4gK3N0YXRpYyBpcnFyZXR1cm5fdCBsYW44
ODd4X2hhbmRsZV9pbnRlcnJ1cHQoc3RydWN0IHBoeV9kZXZpY2UNCj4gPiArKnBoeWRldikgew0K
PiA+ICsJaW50IHJldCA9IElSUV9OT05FOw0KPiBJIHRoaW5rIHlvdSBjYW4gcmVtb3ZlICdyZXQn
IGJ5IHNpbXBseSByZXR1cm5pbmcgSVJRX0hBTkRMRUQgYW5kDQo+IElSUV9OT05FIGRpcmVjdGx5
IHRvIHNhdmUgb25lIGxpbmUuDQo+IA0KPiBCZXN0IHJlZ2FyZHMsDQo+IFBhcnRoaWJhbiBWDQoN
ClRoaXMgaXMgZGVjbGFyZWQgZm9yIGZ1dHVyZSBzZXJpZXMgcHVycG9zZS4NCkFzIHN1Z2dlc3Rl
ZCwgSSdsbCByZW1vdmUgdGhpcyB2YXJpYWJsZSBub3cgYW5kIGludHJvZHVjZSBpbiBuZXh0IHNl
cmllcy4NCg0KL0RpdnlhDQoNCj4gPiArCWludCBpcnFfc3RhdHVzOw0KPiA+ICsNCj4gPiArCWly
cV9zdGF0dXMgPSBwaHlfcmVhZF9tbWQocGh5ZGV2LCBNRElPX01NRF9WRU5EMSwNCj4gTEFOODg3
WF9JTlRfU1RTKTsNCj4gPiArCWlmIChpcnFfc3RhdHVzIDwgMCkgew0KPiA+ICsJCXBoeV9lcnJv
cihwaHlkZXYpOw0KPiA+ICsJCXJldHVybiBJUlFfTk9ORTsNCj4gPiArCX0NCj4gPiArDQo+ID4g
KwlpZiAoaXJxX3N0YXR1cyAmIExBTjg4N1hfTVhfQ0hJUF9UT1BfTElOS19NU0spIHsNCj4gPiAr
CQlwaHlfdHJpZ2dlcl9tYWNoaW5lKHBoeWRldik7DQo+ID4gKwkJcmV0ID0gSVJRX0hBTkRMRUQ7
DQo+ID4gKwl9DQo+ID4gKw0KPiA+ICsJcmV0dXJuIHJldDsNCj4gPiArfQ0KPiA+ICsNCj4gPiAg
IHN0YXRpYyBzdHJ1Y3QgcGh5X2RyaXZlciBtaWNyb2NoaXBfdDFfcGh5X2RyaXZlcltdID0gew0K
PiA+ICAgCXsNCj4gPiAgIAkJUEhZX0lEX01BVENIX01PREVMKFBIWV9JRF9MQU44N1hYKSwNCj4g
PiBAQCAtMTg4MSw2ICsxOTQyLDggQEAgc3RhdGljIHN0cnVjdCBwaHlfZHJpdmVyIG1pY3JvY2hp
cF90MV9waHlfZHJpdmVyW10NCj4gPSB7DQo+ID4gICAJCS5yZWFkX3N0YXR1cwk9IGdlbnBoeV9j
NDVfcmVhZF9zdGF0dXMsDQo+ID4gICAJCS5jYWJsZV90ZXN0X3N0YXJ0ID0gbGFuODg3eF9jYWJs
ZV90ZXN0X3N0YXJ0LA0KPiA+ICAgCQkuY2FibGVfdGVzdF9nZXRfc3RhdHVzID0gbGFuODg3eF9j
YWJsZV90ZXN0X2dldF9zdGF0dXMsDQo+ID4gKwkJLmNvbmZpZ19pbnRyICAgID0gbGFuODg3eF9j
b25maWdfaW50ciwNCj4gPiArCQkuaGFuZGxlX2ludGVycnVwdCA9IGxhbjg4N3hfaGFuZGxlX2lu
dGVycnVwdCwNCj4gPiAgIAl9DQo+ID4gICB9Ow0KPiA+DQoNCg==

