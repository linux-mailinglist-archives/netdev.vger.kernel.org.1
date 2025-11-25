Return-Path: <netdev+bounces-241529-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [213.196.21.55])
	by mail.lfdr.de (Postfix) with ESMTPS id 01A44C851DA
	for <lists+netdev@lfdr.de>; Tue, 25 Nov 2025 14:10:18 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id 7E879350321
	for <lists+netdev@lfdr.de>; Tue, 25 Nov 2025 13:10:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2A69A321F5E;
	Tue, 25 Nov 2025 13:10:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=microchip.com header.i=@microchip.com header.b="58n+PjxN"
X-Original-To: netdev@vger.kernel.org
Received: from CY3PR05CU001.outbound.protection.outlook.com (mail-westcentralusazon11013006.outbound.protection.outlook.com [40.93.201.6])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D0830322A13;
	Tue, 25 Nov 2025 13:10:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.93.201.6
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1764076212; cv=fail; b=i56rDEMFi/zbaAtC/SBsS2UvTbLXdlb7tsOAtFOWDM06ZCJs4k6V8ngEWegf+tmHuBohwWO5AuJdHopdGUydtTVTzR3bwmJb601wWdhCsSmL4gKp70ST4oNEaYfLUmzExdFNN/qf7NnAoA79eWC7UP0rRiua0Qjy4tBIuzTbbso=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1764076212; c=relaxed/simple;
	bh=iVcxsei8TgQwhH3r1v81CcRymLk2h3MROO1xAbvPCEI=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=QdcZ3oyw83Cla9/i/oujS5jY3sPWMqIivUbR+81AS8k7zyMGOdgx4cbFHP2/4BheefmHC7ik+y1cGmIx3GCeWBkhk6vFNUM34FofmRFFZbGfvaLCzZzj5jHUCLjQsu+pXcr2zPX4QimDA6RIBGbd+3cjWWco4e9c36fC8bkL6ks=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=microchip.com; spf=pass smtp.mailfrom=microchip.com; dkim=pass (2048-bit key) header.d=microchip.com header.i=@microchip.com header.b=58n+PjxN; arc=fail smtp.client-ip=40.93.201.6
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=microchip.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=microchip.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=arsf42G8/dATLt1L4a1j/h5r2LWkb7FFT5HhsN951SmVAEJeZNXwTZTFRzJlh+btL/RRZXVbY4YNtQs91qzKyuznMHNEq2Y/Ro/TPA4upOkvOwPBVxEBKM3yYAMX4thD63kCWnprHkbFIqB7npiIZOX6YYVYO7IafTEymx/AgLBlMNMGpspPdeRso4QSGgKfz/SjkoQ05b8pteaKgFZ4n9SAg2NgC0oex7wCufFHmiwk+gRIwHMXXJvG2+AIc22w30cr2lrGm+ZPNqIXDkgHs2u9XKYtgqWeS6foHhCx8ZMmV7GYCJiFcDDrvE5OFRkzjCiVXZ6KYCHxjDHwh8LBQg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=iVcxsei8TgQwhH3r1v81CcRymLk2h3MROO1xAbvPCEI=;
 b=qlVMcjCUrLpjW7k3ZSx51IFgiALNAP0euGdFluUQfoy4PnLg/2dh7gocC/BdOtSighGXxfT1qfUNqIdWfvuqwIn8cAvaW2sFsYPo7TIJoSSt9+i5ozBYvx2NzNH/nA3b0WCSPdrjDnxssPPmRqVwdrUOdCzVW+oBkIBFaTUBxrsDQlAahtXtd4a9faKQb9mdlM3oQz8vXP4eDQtxc+perU+KLwG7v3KdeD3cDtfNnaWlYM01wjWKUpLGA4lgg3QnUL9My0L5Iestclvfyk4iqs5BC/EsXE1iUFu+yD6HD9PH3BD54PLXHMjmDyMpCL/5PGR8rwrbeTe6jpLcy0eJWA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=microchip.com; dmarc=pass action=none
 header.from=microchip.com; dkim=pass header.d=microchip.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=microchip.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=iVcxsei8TgQwhH3r1v81CcRymLk2h3MROO1xAbvPCEI=;
 b=58n+PjxNtk/IiGxQLQAYrha8J8jpZiQbXFcbeyHFjcr4ASqPAcdd5CweJ+nyJMjYkGt7V0QDQx1qou8WqiYDeExbFWRkAIl7VrJ8k5EAfF4kheZ2v43xsROrxROWAr2bH28ZRN/Q9rQl0cg+8LkGMFn2RlfUDGy28WjuDX4XXulckaKCqsusxQdEChbysqdK3gicqG1NW8xARrNJoqpqOpC3wdJBZxfVxn510VBp0DUkgb51KO+tmL0MwNYToGhYv2QOcm2LI7ldBVGV/NUXe5aOX2VotknDSuw11QFSYSB2yinKwAVMFOR/dnr4zrgaK6dTEahgYNb9HaQspblilg==
Received: from SA1PR11MB8278.namprd11.prod.outlook.com (2603:10b6:806:25b::19)
 by DS4PPFCD40128AE.namprd11.prod.outlook.com (2603:10b6:f:fc02::4f) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9366.11; Tue, 25 Nov
 2025 13:10:07 +0000
Received: from SA1PR11MB8278.namprd11.prod.outlook.com
 ([fe80::3a83:d243:3600:8ecf]) by SA1PR11MB8278.namprd11.prod.outlook.com
 ([fe80::3a83:d243:3600:8ecf%6]) with mapi id 15.20.9366.009; Tue, 25 Nov 2025
 13:10:07 +0000
From: <Parthiban.Veerasooran@microchip.com>
To: <horms@kernel.org>
CC: <piergiorgio.beruto@gmail.com>, <andrew@lunn.ch>, <hkallweit1@gmail.com>,
	<linux@armlinux.org.uk>, <davem@davemloft.net>, <edumazet@google.com>,
	<kuba@kernel.org>, <pabeni@redhat.com>, <netdev@vger.kernel.org>,
	<linux-kernel@vger.kernel.org>
Subject: Re: [PATCH net-next v2 1/2] net: phy: phy-c45: add SQI and SQI+
 support for OATC14 10Base-T1S PHYs
Thread-Topic: [PATCH net-next v2 1/2] net: phy: phy-c45: add SQI and SQI+
 support for OATC14 10Base-T1S PHYs
Thread-Index: AQHcWEg9qwUK9eNs30OCPiUaHs0547T+msQAgATOTgA=
Date: Tue, 25 Nov 2025 13:10:07 +0000
Message-ID: <d2e9183b-6843-4529-8b41-06ac19418fda@microchip.com>
References: <20251118045946.31825-1-parthiban.veerasooran@microchip.com>
 <20251118045946.31825-2-parthiban.veerasooran@microchip.com>
 <aSGioGmSP9rtSLpB@horms.kernel.org>
In-Reply-To: <aSGioGmSP9rtSLpB@horms.kernel.org>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
user-agent: Mozilla Thunderbird
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=microchip.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: SA1PR11MB8278:EE_|DS4PPFCD40128AE:EE_
x-ms-office365-filtering-correlation-id: 02317dd2-84fe-4109-7242-08de2c23f4a0
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam:
 BCL:0;ARA:13230040|1800799024|366016|7416014|376014|38070700021;
x-microsoft-antispam-message-info:
 =?utf-8?B?L2pDWjRWQnRIZzN5ak5IVVlqOHVkTjFmUDJqUjd4VUNjZ1FJZXMyemhuNmgv?=
 =?utf-8?B?NlJKS1pHS0dKSFNMaWhybUxuU0N6QWRNc1RNNjJnQUtFQXdnYUVlZjUrQWpo?=
 =?utf-8?B?eHN2VzBJck4zZXBzNHVPUS9OY1lORy92U2p1V2ZuRDdrQkpBVTFpSVFpYTdB?=
 =?utf-8?B?N2E3TTVkWjVHdFpzV1k3TGt4Y2RzREQvRVI5UndTbDRGdEJpUTJWSWJjOGhX?=
 =?utf-8?B?MHNSbFhibzMwS3JxTUZ3ZlRZWW00UUhHTDAxRjJScmY2S09oUkZwNTliSzZt?=
 =?utf-8?B?TkNBT0daWCsrSTY1Y0VhM2EwdXNQeFRXUWRVTmxDOTBvTXB6ZmdSSGd0ZVln?=
 =?utf-8?B?MkZPME0zbGVBZ2dCRG1FTzQyaFdnYVp1d013aVU5RFRJdjJQclZoZ3hxNHRh?=
 =?utf-8?B?eHRUYmNSb2M5bFdZZmxvUWRVUVRrdGh0YVpsUnczSSs5cERIT3hBQ2JiYkVu?=
 =?utf-8?B?SXMzbWp4emRHU3lvMUUvK2hETW1ITFdyYTdlMTJIdHRZZHNlK2YwQ3JRM2pH?=
 =?utf-8?B?TFRCdDN6c3ZPNHpRTjZreHFhOHNHaENyeUpSdUR2akFheWUwRkxRMi8wSC85?=
 =?utf-8?B?dUlxM1BzenBPMFphb1RBbUlFQ1VwaS9WZjNWYTZBSXdHRXVFOFhNR0oyYkM4?=
 =?utf-8?B?ZmJYNmVkSDBUdEN3blRyeGFzWk9KeXBZajRXNnRndVVCd2Q3aUZSUG1XTFVk?=
 =?utf-8?B?Mlo1Q1BZNkU1ejJ0SnlYRHExUDA1dE1uMFBJUzd0SXJVRnBKOFRFMk44SnZj?=
 =?utf-8?B?S2EvUFk0VnBCVzlHSk9Pc1VoQ1ltOEJCdDV5N2hRc3d1d1ZjL0krTERJWTgr?=
 =?utf-8?B?S2h4Wlc4T3lEbHBPSW5wZFpyKzJBYXpia293OHMxaTJWMS9CeDlBSlJzVzhp?=
 =?utf-8?B?UkxpMkN0S3Q0bjJtNmpiV0JHckZOazIyMG8vMnJOelpzRmRSYVY5MEpPeUJh?=
 =?utf-8?B?TmlNM1VidWM1eDAzM0pSOFZJWWNuM2JQa2hiZTY1N0hBZkZvYUJMR3hCMy9k?=
 =?utf-8?B?eEtXMFR0aTBlQWdxdStKWU9BcmtXVUVnelIwbkU4Qk9MRDBvdG9BZjNQTVRU?=
 =?utf-8?B?LzErQnMzbkpQdi8wZmRJc0EyL08zM3ZQaXZ4VG9Cd1lUTU5rSGVSbzlJZEVh?=
 =?utf-8?B?YXo3ZXVzS1RnTWQ3b254VU5UWWlMZWRwd0RMVUt2MXdaY0tnUDM1RVk0bEp1?=
 =?utf-8?B?SnhncE5WOUxHTitxL2IyN2xRMnhKWXgvYmw2Q0w0NWJhTUtMWm5QVWdqd3By?=
 =?utf-8?B?anlpbkVEam4xQ1RsZjVSVHQwb1AyaTBYUXp1UUowTFUyb01BTXFveUdENmtm?=
 =?utf-8?B?dHFKczNSTThOUHRveXE3VFZucDlTRVJtTmpNMEhMKzYrazQybFZraDkxekV6?=
 =?utf-8?B?NnhVakJRV1NiOGg4UmF1ZWZ6YWpCT2hyRW9UUEFJRnMwcnlsMWhINVB3Y1Mx?=
 =?utf-8?B?VVJPUDcwSE8wenhIMzdWRVhjTWdneW1XUGtEbkhqeENEZTZNY3lmQWJmWmV2?=
 =?utf-8?B?a1FHMjc1bEJZelArd3lZNkVNeFBzLzZUNFZsNHQ5VkNPVlhscGlrNkEvL2VJ?=
 =?utf-8?B?TmYwNzQza2pMa0FXL1UvOHg3WjRISXIvRmxJT1BzWmxweUpmcExqRG1sOTcv?=
 =?utf-8?B?TTdHRFp2UnRYa3lEZVNhdTJkYWhXWVhYU2xYSHljVVgzN3dDOWFGNEp1Nmdz?=
 =?utf-8?B?cm5rYWF2bkc1eXlWZTQvRkZaajkyTlczY05YalV1c2E3SDl4VENRTi9wVmFu?=
 =?utf-8?B?TEtYbzZadk10UklValo2dllPdzg5MiswTjJRTUxrMzBrTXNhVXRiM0FrM3o0?=
 =?utf-8?B?MDVKa3FnNU1YNXNUQ3FxZWxBUVZmMmVHNm1UWjJoWGhUZk9maFFVNUFTc1Bt?=
 =?utf-8?B?ME5nR1FvM3Z5akdtN1QwMi9QSmlMbU0rZ2x2aElJMkcyUmc3aC9wZFVSSTFX?=
 =?utf-8?B?N0RGQjg3Z2J5RWlmUlNjQW0ybW5YNC9NaVVGRVJTK0FtRW5oUFZZR3had1ZV?=
 =?utf-8?B?RXRTZ1doLzl3MDdhaUFKUW5LeDd5MlNtRVBwTGI3QUVWYjBFZ0tvdDRCWGgr?=
 =?utf-8?Q?xXphX1?=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SA1PR11MB8278.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(7416014)(376014)(38070700021);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?utf-8?B?ZklhdWQ1YWdBUHF6SHhKOFZBQkRkZ0ZkN0hEOWE0MkJXZFRhaUFuN3JYaTZn?=
 =?utf-8?B?UDZDazRnSHhxcVNIT3RlTWZidnlleTlJOCttbDB4Nyt1dWx4NmhQL1ZkZjFw?=
 =?utf-8?B?ZVRyQ1k1akJzTktTcytJU2Jkb0hQQlgzU1JqSXVKYnBjWWdwZ2JjN3V6d05h?=
 =?utf-8?B?alhXSmxWTXlqVzlYL2pTYytjSUVnQUg5V3FZaktsUWJMNldIOGVrU0YwZVRJ?=
 =?utf-8?B?NlgxNjlvMyszODZyU0c4VmV0VXZNYzhjbmh2T3FrYm54NTkwNEN4bHQ5Y29C?=
 =?utf-8?B?NUhmRzhIc2U1SFVBeEIxOVJ6Y1lZTUdQbVZPUnNLRCtFc3dtWkZ4T2pRMGoy?=
 =?utf-8?B?amp6RkliR2JpVHRhWXVqY2FHaGtUWE44WkxBUldYZllpa1FDQWxsYkNUaTc1?=
 =?utf-8?B?SmdWelE1MUIxc1BwOW5nQ09jSTdEMW16YnZwMzl0V1Z3b3B6QVdNbVVBRE1Q?=
 =?utf-8?B?RjlYcTZDS2hUWTlOY1YralN5SjRuV3ZueFJsdkdRZ1lqSG50OVl6Vmx6UGlU?=
 =?utf-8?B?VVozU2ZDWHZ4YVpZYzhwTElDZTR5TGNFT2IvVzM2bXFZYmg0SWMreXNwYVVB?=
 =?utf-8?B?TWJzWDlWclo1VDFBb3ZUT1ZQVksvTk1acE5Fb1U1eVk4T3BON09yMzRGemZl?=
 =?utf-8?B?Q2NncDNOZ2F1NVZiREU5RXluOFRoclRMdTVKb2lleTAxejFKN0o2aHFSRnNv?=
 =?utf-8?B?dVlEQjR5M1lJY1Q1dmsva1NIWXFQQ3F1V2ZOVitYU1BaYlZyL2tQZTFOV0lJ?=
 =?utf-8?B?MFF2SXgwWkFkdVNmM2kwZXFlckJkcXVRSlpUaUxkMFRNYUprUmlzdlVQNnJ0?=
 =?utf-8?B?a0Y0WHVDUGN6Q2lDN0RPa2ZQMllhWnQwb2FLNHlCcjhqZ1BKRXNtekFIMmNE?=
 =?utf-8?B?bWhJcVZhZ0FwK29idVlJR1JxMEdmWHVXZnpabm8ybFc2VDVGLzR5MXFXR1Vq?=
 =?utf-8?B?a2VrWXZXb1dSZ3czT04xa1V5ajBMcXdBcHVvQi9QblkwekdheXp1R0wxZDhY?=
 =?utf-8?B?SE11VmNQSStGT2FjcU5USEQzQW1ZQ0VyYVB6MThEKzRtenFwZlprQkg2cE5M?=
 =?utf-8?B?cjU1a3dsaUxnMFBIcXZwQnhidVdjZVFPbUZINHkxQ2ZVZmhnRzVQTEk1dVAv?=
 =?utf-8?B?TkJQL0orMlkxNjZTT0pzZ0ZVOFJ2OUt2dm8xd0ZsMktjN25Kblhnd0FMU3VZ?=
 =?utf-8?B?VnNTMG9FQTJVclo2aGNGcEpUMElJUUVCVjN6VzVHTkxQalV0OW01U0VSM1ZO?=
 =?utf-8?B?aEs2alpDYnc2am4vYm9YRzdUQnRtaUtjOGdLSXMzZ01zVE82cUtWdVF5ZUFv?=
 =?utf-8?B?dnpBVWZ3WUFpTnp4S0JmUFA2ZDNORHkvdzQwSWsySGhCcHBvTHMzckpGbnNY?=
 =?utf-8?B?THY4WWg0Qng5aXd2NjZaeW8wZ3RlWHNTWkpHYXJBU0ljakFYQnB2TmZCV0p5?=
 =?utf-8?B?T2ZTcDFvYUdUSXQvYjhrL3NKcVNFbk56ZHNWOE5sOWJFbll6SUVZNGhvSUQ5?=
 =?utf-8?B?eHJqR29FT3BuN1NGVTZnUUZIOXZ3ZHZIbGlmM3BvZk5aQXRKbVV1YlJCY0NQ?=
 =?utf-8?B?dUVwRVdkclFKMlNTaWxQMlF6UGlGT1JmelBhdmc0NEMybTQ0Q25UNGdQbUE3?=
 =?utf-8?B?L0UwUXBzeFQ4a3BzZDZ6emI4RExOZGxlVmhYYlF0OXZkanYwTkhoRzVaY0M1?=
 =?utf-8?B?bEY4TXUxSklmaUwwdVZGMjVpRVZ3d1ZLVDY4SVdkNHovZzZTc09jQXRPU0xT?=
 =?utf-8?B?NG93Z01xNE40djUwenMxbG5ESGFOMGoreEZyWkdoaHpoQ3BiVnlRZDltaGpa?=
 =?utf-8?B?NXZqQUNYZDNEemR2MDQyRzQwcU9PcmVVQllBWUdiWFplQnV5VWlqUmgzVk5H?=
 =?utf-8?B?empocXFadVE3Nmg2WHVQclNyVHlTSU5sODhVYWIyVHBSU2xtcmZWSEpUR0Fz?=
 =?utf-8?B?R2ExWEpucURuanhseGs3dWM4ZXI2VWlURjMzQ2tSa0lWK3h0Um5SZ29tdDdo?=
 =?utf-8?B?YTd0cllqMnc4UUxtc2p3ODZDTFREMi9LanVxQ29wdzkxSUhuaGxrZ1J5VTVR?=
 =?utf-8?B?djF3Z2RaZ2FYb2FUdXpNd0lCa1ljTEVSaFRPWjNkcGxTUnZ1L0ZEb2FRYjRs?=
 =?utf-8?B?M1JYMlQ2VWVpL0QxM1BzeUE1a29YZDhhaE5ZVWlPZmR0MURUVzNrSkxSOUNY?=
 =?utf-8?B?cnc9PQ==?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <FD96C8EDE9B6FA4EA41ACDBF9C9A171A@namprd11.prod.outlook.com>
Content-Transfer-Encoding: base64
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-OriginatorOrg: microchip.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: SA1PR11MB8278.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 02317dd2-84fe-4109-7242-08de2c23f4a0
X-MS-Exchange-CrossTenant-originalarrivaltime: 25 Nov 2025 13:10:07.2332
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3f4057f3-b418-4d4e-ba84-d55b4e897d88
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: Cw8Yv9PpxmHi8QNQCakY6m4pRbImHu+1ulAAoM6sl2IfIw/k6WfN1TZqbN1CT0YEfcskbyJdsJ+zDfQE1Wkc6qBngFQl2jEl15qjNYNdiDC2V7DqxBeAf9PiSLhYAl9i
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS4PPFCD40128AE

SGkgU2ltb24sDQoNClRoYW5rIHlvdSBmb3IgcmV2aWV3aW5nIHRoZSBwYXRjaC4NCg0KT24gMjIv
MTEvMjUgNToxNiBwbSwgU2ltb24gSG9ybWFuIHdyb3RlOg0KPiBFWFRFUk5BTCBFTUFJTDogRG8g
bm90IGNsaWNrIGxpbmtzIG9yIG9wZW4gYXR0YWNobWVudHMgdW5sZXNzIHlvdSBrbm93IHRoZSBj
b250ZW50IGlzIHNhZmUNCj4gDQo+IE9uIFR1ZSwgTm92IDE4LCAyMDI1IGF0IDEwOjI5OjQ1QU0g
KzA1MzAsIFBhcnRoaWJhbiBWZWVyYXNvb3JhbiB3cm90ZToNCj4gDQo+IC4uLg0KPiANCj4+IEBA
IC0xNjk1LDMgKzE2OTUsODkgQEAgaW50IGdlbnBoeV9jNDVfb2F0YzE0X2NhYmxlX3Rlc3Rfc3Rh
cnQoc3RydWN0IHBoeV9kZXZpY2UgKnBoeWRldikNCj4+ICAgICAgICAgICAgICAgICAgICAgICAg
ICAgICAgICBPQVRDMTRfSEREX1NUQVJUX0NPTlRST0wpOw0KPj4gICB9DQo+PiAgIEVYUE9SVF9T
WU1CT0woZ2VucGh5X2M0NV9vYXRjMTRfY2FibGVfdGVzdF9zdGFydCk7DQo+PiArDQo+PiArLyoq
DQo+PiArICogZ2VucGh5X2M0NV9vYXRjMTRfZ2V0X3NxaV9tYXggLSBHZXQgbWF4aW11bSBzdXBw
b3J0ZWQgU1FJIG9yIFNRSSsgbGV2ZWwgb2YNCj4+ICsgKiAgICAgICAgICAgICAgICAgICAgICAg
ICAgICAgIE9BVEMxNCAxMEJhc2UtVDFTIFBIWQ0KPj4gKyAqIEBwaHlkZXY6IHBvaW50ZXIgdG8g
dGhlIFBIWSBkZXZpY2Ugc3RydWN0dXJlDQo+PiArICoNCj4+ICsgKiBUaGlzIGZ1bmN0aW9uIHJl
YWRzIHRoZSBhZHZhbmNlZCBjYXBhYmlsaXR5IHJlZ2lzdGVyIHRvIGRldGVybWluZSB0aGUgbWF4
aW11bQ0KPj4gKyAqIHN1cHBvcnRlZCBTaWduYWwgUXVhbGl0eSBJbmRpY2F0b3IgKFNRSSkgb3Ig
U1FJKyBsZXZlbA0KPj4gKyAqDQo+PiArICogUmV0dXJuOg0KPj4gKyAqICogTWF4aW11bSBTUUkv
U1FJKyBsZXZlbCAo4omlMCkNCj4+ICsgKiAqIC1FT1BOT1RTVVBQIGlmIG5vdCBzdXBwb3J0ZWQN
Cj4+ICsgKiAqIE5lZ2F0aXZlIGVycm5vIG9uIHJlYWQgZmFpbHVyZQ0KPj4gKyAqLw0KPj4gK2lu
dCBnZW5waHlfYzQ1X29hdGMxNF9nZXRfc3FpX21heChzdHJ1Y3QgcGh5X2RldmljZSAqcGh5ZGV2
KQ0KPj4gK3sNCj4+ICsgICAgIHU4IGJpdHM7DQo+PiArICAgICBpbnQgcmV0Ow0KPj4gKw0KPj4g
KyAgICAgcmV0ID0gcGh5X3JlYWRfbW1kKHBoeWRldiwgTURJT19NTURfVkVORDIsIE1ESU9fT0FU
QzE0X0FERkNBUCk7DQo+PiArICAgICBpZiAocmV0IDwgMCkNCj4+ICsgICAgICAgICAgICAgcmV0
dXJuIHJldDsNCj4+ICsNCj4+ICsgICAgIC8qIENoZWNrIGZvciBTUUkrIGNhcGFiaWxpdHkNCj4+
ICsgICAgICAqIDAgLSBTUUkrIGlzIG5vdCBzdXBwb3J0ZWQNCj4+ICsgICAgICAqICgzLTgpIGJp
dHMgZm9yICg4LTI1NikgU1FJKyBsZXZlbHMgc3VwcG9ydGVkDQo+PiArICAgICAgKi8NCj4+ICsg
ICAgIGJpdHMgPSBGSUVMRF9HRVQoT0FUQzE0X0FERkNBUF9TUUlQTFVTX0NBUEFCSUxJVFksIHJl
dCk7DQo+PiArICAgICBpZiAoYml0cykgew0KPj4gKyAgICAgICAgICAgICBwaHlkZXYtPm9hdGMx
NF9zcWlwbHVzX2JpdHMgPSBiaXRzOw0KPj4gKyAgICAgICAgICAgICAvKiBNYXggc3FpKyBsZXZl
bCBzdXBwb3J0ZWQ6ICgyIF4gYml0cykgLSAxICovDQo+PiArICAgICAgICAgICAgIHJldHVybiBC
SVQoYml0cykgLSAxOw0KPj4gKyAgICAgfQ0KPj4gKw0KPj4gKyAgICAgLyogQ2hlY2sgZm9yIFNR
SSBjYXBhYmlsaXR5DQo+PiArICAgICAgKiAwIC0gU1FJIGlzIG5vdCBzdXBwb3J0ZWQNCj4+ICsg
ICAgICAqIDEgLSBTUUkgaXMgc3VwcG9ydGVkICgwLTcgbGV2ZWxzKQ0KPj4gKyAgICAgICovDQo+
PiArICAgICBpZiAocmV0ICYgT0FUQzE0X0FERkNBUF9TUUlfQ0FQQUJJTElUWSkNCj4+ICsgICAg
ICAgICAgICAgcmV0dXJuIE9BVEMxNF9TUUlfTUFYX0xFVkVMOw0KPj4gKw0KPj4gKyAgICAgcmV0
dXJuIC1FT1BOT1RTVVBQOw0KPj4gK30NCj4+ICtFWFBPUlRfU1lNQk9MKGdlbnBoeV9jNDVfb2F0
YzE0X2dldF9zcWlfbWF4KTsNCj4+ICsNCj4+ICsvKioNCj4+ICsgKiBnZW5waHlfYzQ1X29hdGMx
NF9nZXRfc3FpIC0gR2V0IFNpZ25hbCBRdWFsaXR5IEluZGljYXRvciAoU1FJKSBmcm9tIGFuIE9B
VEMxNA0KPj4gKyAqICAgICAgICAgICAgICAgICAgICAgICAgICAxMEJhc2UtVDFTIFBIWQ0KPj4g
KyAqIEBwaHlkZXY6IHBvaW50ZXIgdG8gdGhlIFBIWSBkZXZpY2Ugc3RydWN0dXJlDQo+PiArICoN
Cj4+ICsgKiBUaGlzIGZ1bmN0aW9uIHJlYWRzIHRoZSBTUUkrIG9yIFNRSSB2YWx1ZSBmcm9tIGFu
IE9BVEMxNC1jb21wYXRpYmxlDQo+PiArICogMTBCYXNlLVQxUyBQSFkuIElmIFNRSSsgY2FwYWJp
bGl0eSBpcyBzdXBwb3J0ZWQsIHRoZSBmdW5jdGlvbiByZXR1cm5zIHRoZQ0KPj4gKyAqIGV4dGVu
ZGVkIFNRSSsgdmFsdWU7IG90aGVyd2lzZSwgaXQgcmV0dXJucyB0aGUgYmFzaWMgU1FJIHZhbHVl
Lg0KPj4gKyAqDQo+PiArICogUmV0dXJuOg0KPj4gKyAqICogU1FJL1NRSSsgdmFsdWUgb24gc3Vj
Y2Vzcw0KPj4gKyAqICogTmVnYXRpdmUgZXJybm8gb24gcmVhZCBmYWlsdXJlDQo+PiArICovDQo+
PiAraW50IGdlbnBoeV9jNDVfb2F0YzE0X2dldF9zcWkoc3RydWN0IHBoeV9kZXZpY2UgKnBoeWRl
dikNCj4+ICt7DQo+PiArICAgICB1OCBzaGlmdDsNCj4+ICsgICAgIGludCByZXQ7DQo+PiArDQo+
PiArICAgICAvKiBDYWxjdWxhdGUgYW5kIHJldHVybiBTUUkrIHZhbHVlIGlmIHN1cHBvcnRlZCAq
Lw0KPj4gKyAgICAgaWYgKHBoeWRldi0+b2F0YzE0X3NxaXBsdXNfYml0cykgew0KPiANCj4gSGkg
UGFydGhpYmFuLA0KPiANCj4gQUZBSUNUIG9hdGMxNF9zcWlwbHVzX2JpdHMgd2lsbCBhbHdheXMg
YmUgMCB1bnRpbA0KPiBnZW5waHlfYzQ1X29hdGMxNF9nZXRfc3FpX21heCgpIGlzIGNhbGxlZCwg
YWZ0ZXIgd2hpY2gNCj4gaXQgbWF5IGJlIHNvbWUgb3RoZXIgdmFsdWUuDQo+IA0KPiBCdXQgYWNj
b3JkaW5nIHRvIHRoZSBmbG93IG9mIGxpbmtzdGF0ZV9wcmVwYXJlX2RhdGEoKQ0KPiBpdCBzZWVt
cyB0aGF0IGdlbnBoeV9jNDVfb2F0YzE0X2dldF9zcWlfbWF4KCkNCj4gd2lsbCBiZSBjYWxsZWQg
YWZ0ZXIgZ2VucGh5X2M0NV9vYXRjMTRfZ2V0X3NxaSgpLg0KPiANCj4gSW4gd2hpY2ggY2FzZSB0
aGUgY29uZGl0aW9uIGFib3ZlIHdpbGwgYmUgZmFsc2UNCj4gKHVubGVzcyBnZW5waHlfYzQ1X29h
dGMxNF9nZXRfc3FpX21heCB3YXMgc29tZWhvdyBhbHJlYWR5DQo+IGNhbGxlZCBieSBzb21lIG90
aGVyIG1lYW5zLikNCj4gDQo+IFRoaXMgZG9lc24ndCBzZWVtIHRvIGJlIGluIGxpbmUgd2l0aCB0
aGUgaW50ZW50aW9uIG9mIHRoaXMgY29kZS4NCj4gDQo+IEZsYWdnZWQgYnkgQ2xhdWRlIENvZGUg
d2l0aCBodHRwczovL2dpdGh1Yi5jb20vbWFzb25jbC9yZXZpZXctcHJvbXB0cy8NCkdvb2QgY2F0
Y2ghIG9hdGMxNF9zcWlwbHVzX2JpdHMgaXMgbm90IHVwZGF0ZWQgdGhlIGZpcnN0IHRpbWUgDQpn
ZW5waHlfYzQ1X29hdGMxNF9nZXRfc3FpKCkgaXMgY2FsbGVkLCBhbmQgaXMgbGF0ZXIgdXBkYXRl
ZCBieSANCmdlbnBoeV9jNDVfb2F0YzE0X2dldF9zcWlfbWF4KCkuIFRoYW5rIHlvdSBmb3IgcG9p
bnRpbmcgaXQgb3V0OyBJIHdpbGwgDQpmaXggaXQgaW4gdGhlIG5leHQgdmVyc2lvbi4NCg0KQmVz
dCByZWdhcmRzLA0KUGFydGhpYmFuIFYNCj4gDQo+PiArICAgICAgICAgICAgIHJldCA9IHBoeV9y
ZWFkX21tZChwaHlkZXYsIE1ESU9fTU1EX1ZFTkQyLA0KPj4gKyAgICAgICAgICAgICAgICAgICAg
ICAgICAgICAgICAgTURJT19PQVRDMTRfRENRX1NRSVBMVVMpOw0KPj4gKyAgICAgICAgICAgICBp
ZiAocmV0IDwgMCkNCj4+ICsgICAgICAgICAgICAgICAgICAgICByZXR1cm4gcmV0Ow0KPj4gKw0K
Pj4gKyAgICAgICAgICAgICAvKiBTUUkrIHVzZXMgTiBNU0JzIG91dCBvZiA4IGJpdHMsIGxlZnQt
YWxpZ25lZCB3aXRoIHBhZGRpbmcgMSdzDQo+PiArICAgICAgICAgICAgICAqIENhbGN1bGF0ZSB0
aGUgcmlnaHQtc2hpZnQgbmVlZGVkIHRvIGlzb2xhdGUgdGhlIE4gYml0cy4NCj4+ICsgICAgICAg
ICAgICAgICovDQo+PiArICAgICAgICAgICAgIHNoaWZ0ID0gOCAtIHBoeWRldi0+b2F0YzE0X3Nx
aXBsdXNfYml0czsNCj4+ICsNCj4+ICsgICAgICAgICAgICAgcmV0dXJuIChyZXQgJiBPQVRDMTRf
RENRX1NRSVBMVVNfVkFMVUUpID4+IHNoaWZ0Ow0KPj4gKyAgICAgfQ0KPj4gKw0KPj4gKyAgICAg
LyogUmVhZCBhbmQgcmV0dXJuIFNRSSB2YWx1ZSBpZiBTUUkrIGNhcGFiaWxpdHkgaXMgbm90IHN1
cHBvcnRlZCAqLw0KPj4gKyAgICAgcmV0ID0gcGh5X3JlYWRfbW1kKHBoeWRldiwgTURJT19NTURf
VkVORDIsIE1ESU9fT0FUQzE0X0RDUV9TUUkpOw0KPj4gKyAgICAgaWYgKHJldCA8IDApDQo+PiAr
ICAgICAgICAgICAgIHJldHVybiByZXQ7DQo+PiArDQo+PiArICAgICByZXR1cm4gcmV0ICYgT0FU
QzE0X0RDUV9TUUlfVkFMVUU7DQo+PiArfQ0KPj4gK0VYUE9SVF9TWU1CT0woZ2VucGh5X2M0NV9v
YXRjMTRfZ2V0X3NxaSk7DQo+IA0KPiAuLi4NCg0K

