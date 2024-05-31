Return-Path: <netdev+bounces-99729-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 583968D617D
	for <lists+netdev@lfdr.de>; Fri, 31 May 2024 14:14:28 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 17BFC281F91
	for <lists+netdev@lfdr.de>; Fri, 31 May 2024 12:14:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 184151581FF;
	Fri, 31 May 2024 12:14:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=microchip.com header.i=@microchip.com header.b="A3gtHeHR";
	dkim=pass (2048-bit key) header.d=microchip.com header.i=@microchip.com header.b="fejEo5DN"
X-Original-To: netdev@vger.kernel.org
Received: from esa.microchip.iphmx.com (esa.microchip.iphmx.com [68.232.154.123])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2C04C29A0;
	Fri, 31 May 2024 12:14:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=68.232.154.123
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717157665; cv=fail; b=Bhk2aqifb3sH5Fgjh1yDOHiCc8uQlKE6U6fPPlkKRgXbXmaUciUQlbQdBIoTW9oAOWuYXjUhqVXWccCMXOA0DxL5x75sCZmBAP9GXU2rp3Ka0wXw+rCZPGw9B790FI4+Eo6MEnxfTa5UpuhVo9ZpUYUAMVXJqZP71Ux3bTk4ZYo=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717157665; c=relaxed/simple;
	bh=4OJqMEjseHAffrIs3so9lRTFbW2JuTrgIF2NBv9y7B4=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=JXhCw9VBy+HCr0S2MQqDzWSUx9baJ5kYHFXyfYN9fx0YFMASwj56dioBN/+sApg/2pzeBJJapWsNRVBvJrfiLORX1CK+Rpw8PfXavK5XDDXsb+vvf390OsyB280lFCqwZ0vqvgTU6CtMuK+V8xdejcvqNOFMyzzuPz/D89FwCMY=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=microchip.com; spf=pass smtp.mailfrom=microchip.com; dkim=pass (2048-bit key) header.d=microchip.com header.i=@microchip.com header.b=A3gtHeHR; dkim=pass (2048-bit key) header.d=microchip.com header.i=@microchip.com header.b=fejEo5DN; arc=fail smtp.client-ip=68.232.154.123
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=microchip.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=microchip.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=microchip.com; i=@microchip.com; q=dns/txt; s=mchp;
  t=1717157662; x=1748693662;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-id:content-transfer-encoding:
   mime-version;
  bh=4OJqMEjseHAffrIs3so9lRTFbW2JuTrgIF2NBv9y7B4=;
  b=A3gtHeHRvoZar8jcWOr3ui6n6QNUhulIbiMzCPdSddvUaJyj30R0cpth
   u0yKgzK4RHot1TSWDvjxX3dR8SKQ3B4Xx9RQDDq6TGElMTangWc/rT5su
   PSw96tEVCbDobYSSdlaokQGI3U4zoIdFIgy0Wc7b5KJwpLCwRZCgEFEXj
   CdctyTnuzzm1sDrzF04hpiAir8dF0aX2JMEm7qkU+mRkPlyh7B+s3mBRq
   3njsy6sMR0zP1N90f6m5X/xJxlV05e449RyqJ5EughcyvvYj2gC05h94S
   8Sak6h1o4vjVu9cCQ/gJUC0TTq4d4xOg/9YFTLQz/1s2lM7hHfo/vAizR
   A==;
X-CSE-ConnectionGUID: eMRsAoiWSIOuLkGgB02BSQ==
X-CSE-MsgGUID: vgVd9wc6SmOcepQZfOwGYw==
X-IronPort-AV: E=Sophos;i="6.08,204,1712646000"; 
   d="scan'208";a="27426023"
X-Amp-Result: SKIPPED(no attachment in message)
Received: from unknown (HELO email.microchip.com) ([170.129.1.10])
  by esa2.microchip.iphmx.com with ESMTP/TLS/ECDHE-RSA-AES128-GCM-SHA256; 31 May 2024 05:14:21 -0700
Received: from chn-vm-ex01.mchp-main.com (10.10.85.143) by
 chn-vm-ex01.mchp-main.com (10.10.85.143) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35; Fri, 31 May 2024 05:13:57 -0700
Received: from NAM10-BN7-obe.outbound.protection.outlook.com (10.10.215.250)
 by email.microchip.com (10.10.87.71) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35 via Frontend Transport; Fri, 31 May 2024 05:13:57 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=nXJqB5Kd6sun6bn9BpZnNHSxMx8P+zrVlMhJkIfX6BDNnDAYYUwff+z0y0sNVPhbzvLA7mIA1mwG6zWMm6GTHbeYMfRoZo4IYChXUTrrWzChUTaOyl9jBaxCtDBgEaNDo5slR+dv6fqCe9JGQWDYvNQ9xZSoTpAVMaXBBcCz9ZYtyzddeeIL3ulLm45l0i/GazZPCFSP7lgMDIbfpEP9xJO8525K+Yf4ifuTnXN+cbynSBl8jsTNlPSmaPfifuT3wncVX1OFWWIqx5NUQCv3wmay+Y/bkwCEMhYsgHI1waJKJRaRtD0l4VFr7/xJkBWUZrFoTH1o1HSj22mhAacNcg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=4OJqMEjseHAffrIs3so9lRTFbW2JuTrgIF2NBv9y7B4=;
 b=WMW1e9g5XCSXzETWo4lMIrlaCfhoTI8NLLn7a3KRBaBNxbYYct7ecjn4sBVh/YYM1kujJ5PY9N+4z4PO1ZbguRYSuiOSVtIQGMOMQQgeNIM6MeoVMlDed55iKEfIftnrVeQNOgEqUsvmsBR64Z9Lmq5Su7HUlmpGDaqgGEeje9dJP/rQ/6sRfv4+zLMfJVnoacbVTTSYFomGsZShVGy7lniIsdMVjw8Ay85MZKBtm24qdQbZnYqUoA96iGN1N/bcFlYRlwMEV+wvVfxCQf/pcS/b37VY+WuDBTq6qQwDPqjnR43YDXtxgzjXxnmhGI66uBSTZsqui0xjVYi/TxABlA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=microchip.com; dmarc=pass action=none
 header.from=microchip.com; dkim=pass header.d=microchip.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=microchip.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=4OJqMEjseHAffrIs3so9lRTFbW2JuTrgIF2NBv9y7B4=;
 b=fejEo5DNIPbjCuZTZhYGy2UdEAlSQ9L4rGeP0+dCehNpytlkV74W9x0FRJJuOIAlCaoDL1Qbl7A71FQzi6ZVzNC6MMJoeX5jdHphLEv0ZC7aEH4yk1FdW7z6Htm4xGcQFFB7KtRf5JmGx5HRhTwyLVlhIZW6G09bEFgCW4KtrPuSO0cp6olWFj3ng5j/d65J31D0uBi7i4bQp64epomjbpWaYiUjwE22adDvMMftSKVgt/W96jpCBg51p1rrX+ZTakp+1soFvXldEvWOsyuC5AwCQXL/+N9VQcc2otle2ymvsgzpE07Mvn4y8JTCvbljJXvkdq4HjcR2vWKtEdU+FQ==
Received: from SA1PR11MB8278.namprd11.prod.outlook.com (2603:10b6:806:25b::19)
 by BL1PR11MB5955.namprd11.prod.outlook.com (2603:10b6:208:386::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7633.21; Fri, 31 May
 2024 12:13:53 +0000
Received: from SA1PR11MB8278.namprd11.prod.outlook.com
 ([fe80::84fa:e267:e389:fa9]) by SA1PR11MB8278.namprd11.prod.outlook.com
 ([fe80::84fa:e267:e389:fa9%4]) with mapi id 15.20.7587.030; Fri, 31 May 2024
 12:13:53 +0000
From: <Parthiban.Veerasooran@microchip.com>
To: <Pier.Beruto@onsemi.com>, <andrew@lunn.ch>
CC: <Selvamani.Rajagopal@onsemi.com>, <davem@davemloft.net>,
	<edumazet@google.com>, <kuba@kernel.org>, <pabeni@redhat.com>,
	<horms@kernel.org>, <saeedm@nvidia.com>, <anthony.l.nguyen@intel.com>,
	<netdev@vger.kernel.org>, <linux-kernel@vger.kernel.org>, <corbet@lwn.net>,
	<linux-doc@vger.kernel.org>, <robh+dt@kernel.org>,
	<krzysztof.kozlowski+dt@linaro.org>, <conor+dt@kernel.org>,
	<devicetree@vger.kernel.org>, <Horatiu.Vultur@microchip.com>,
	<ruanjinjie@huawei.com>, <Steen.Hegelund@microchip.com>,
	<vladimir.oltean@nxp.com>, <UNGLinuxDriver@microchip.com>,
	<Thorsten.Kummermehr@microchip.com>, <Nicolas.Ferre@microchip.com>,
	<benjamin.bigler@bernformulastudent.ch>, <Viliam.Vozar@onsemi.com>,
	<Arndt.Schuebel@onsemi.com>
Subject: Re: [PATCH net-next v4 00/12] Add support for OPEN Alliance
 10BASE-T1x MACPHY Serial Interface
Thread-Topic: [PATCH net-next v4 00/12] Add support for OPEN Alliance
 10BASE-T1x MACPHY Serial Interface
Thread-Index: AQHakY/2Zb5TFJZ12UCHjfgce9+PGrF0voeAgAA2YoCAGHimAIAAQu0AgAFPUYCAAH8FAIAA9qQAgBaf9gCAAAnAAIAABQ8AgAACngCACKHOAIABvDEA
Date: Fri, 31 May 2024 12:13:53 +0000
Message-ID: <39a62649-813a-426c-a2a6-4991e66de36e@microchip.com>
References: <5f73edc0-1a25-4d03-be21-5b1aa9e933b2@lunn.ch>
 <32160a96-c031-4e5a-bf32-fd5d4dee727e@lunn.ch>
 <2d9f523b-99b7-485d-a20a-80d071226ac9@microchip.com>
 <6ba7e1c8-5f89-4a0e-931f-3c117ccc7558@lunn.ch>
 <8b9f8c10-e6bf-47df-ad83-eaf2590d8625@microchip.com>
 <44cd0dc2-4b37-4e2f-be47-85f4c0e9f69c@lunn.ch>
 <b941aefd-dbc5-48ea-b9f4-30611354384d@microchip.com>
 <BYAPR02MB5958A4D667D13071E023B18F83F52@BYAPR02MB5958.namprd02.prod.outlook.com>
 <6e4c8336-2783-45dd-b907-6b31cf0dae6c@lunn.ch>
 <BY5PR02MB6786619C0A0FCB2BEDC2F90D9DF52@BY5PR02MB6786.namprd02.prod.outlook.com>
 <0581b64a-dd7a-43d7-83f7-657ae93cefe5@lunn.ch>
 <BY5PR02MB6786FC4808B2947CA03977429DF32@BY5PR02MB6786.namprd02.prod.outlook.com>
In-Reply-To: <BY5PR02MB6786FC4808B2947CA03977429DF32@BY5PR02MB6786.namprd02.prod.outlook.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
user-agent: Mozilla Thunderbird
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=microchip.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: SA1PR11MB8278:EE_|BL1PR11MB5955:EE_
x-ms-office365-filtering-correlation-id: 5c8fac3b-690b-40aa-ecc4-08dc816b2348
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230031|7416005|1800799015|376005|366007|38070700009;
x-microsoft-antispam-message-info: =?utf-8?B?UHcwMnVGK0d1T2tDbnJIOEZhY2xJa3dxblBaSjYyL2lmckRvV0JVck9Ma2tm?=
 =?utf-8?B?VXZFTXVNVmhFY0ZhK1NJUU8yV3JvS254NjJOdlNTN2E3RmFTWFpWeG9Qd1FH?=
 =?utf-8?B?NFFFTHQvS3JhZm5HOGRrQWRRUURBaXVTWFd1dCtGUmExVGRjSXlKZm5OdlY2?=
 =?utf-8?B?OTUxcVBvV3YyZGVLUEdzajR2blo0MWs0aTJMMDBlWER1d0RJU2xKTjdDZk1P?=
 =?utf-8?B?dDVIU2hLVFlHV0RVK2lPQnhrV0doeCthNzRxL01CYm1LRStEOHVUQ1dnRG1T?=
 =?utf-8?B?N05ZWVlQM21RVXNpRWhmSkVDdkZMVEtQOU1NcTliK2wzTkhJQU9vRlRCWmZm?=
 =?utf-8?B?a3Vsekt5WFVFY3pJOXlJYnpGemY0aGZFMTREYlZHeEc4MFdWSkY2SzhELzVI?=
 =?utf-8?B?MnUwUjRTN09pdnBsSTRVblZyeElJK1dCUHMvdkNVb3FhMzhjS0l0OXlBdFRw?=
 =?utf-8?B?a25WQ0M1bVdvM0plTUN5OFkyM2NGRHpRZUE0LzVVNGdpWmFFUnBXb2tma1M3?=
 =?utf-8?B?ay9VcnJOdHJEQjNMTXp1Q01IeDJOMTRmZmRmLy8rcmdBVkFUNk9reUlkeU4v?=
 =?utf-8?B?dGJyZmdBbXhCc0N0NnErejRBYVJFWDhzaXRjU3FXNDRTWTdPSUxFdmYrRldl?=
 =?utf-8?B?Z1F2U1ZTMHlweGNwY3dnR0dEcDZKS1o4dkFMUU0xMHZFVmJCcU1MMDhPR3pD?=
 =?utf-8?B?b1FqQm1VYTkvcWhTNW5mMVdZa1FQQjJGdTJYb1UyN3lSVyt4ejJIK1BNdE0r?=
 =?utf-8?B?ODI1b1FGTllRNFpTZ1lWMXNPMFZMVlhHSXFnemF6UEtTVHFPN1lOdGxUVCtq?=
 =?utf-8?B?a1hhNEtDVllnOGVtMWVKVStKdlIzc1VMNW1Vanp0aldhU0FCTmdDYkdoenE2?=
 =?utf-8?B?S2J1ckJYZ291UFBaYnhKckxYQ0xNTEJVcmIvREFBZGpzb1lPL3J0V3ZkdDc5?=
 =?utf-8?B?Y0ROVGhhN1dDWk93dms0dFBseEtyOXA0MEhuUFR5MVo0ZlFCanBrL3JqTzVw?=
 =?utf-8?B?RjF0MlVsTzQrTVFTK1FvTWdjR01nQ3JwV3A3VlpiQ1FENWt4MUdqL3d4a29H?=
 =?utf-8?B?WEZWRVpGQ1pwbnExQ1NGcG9nMDA0ZXpLVUo0Tk9kamI1MVNweWJzS25qdkVQ?=
 =?utf-8?B?UVJQOGdwcUtBZnZxVXVqZTEwUk9rbS9COS9wNEV0b3VHdkUwVEppY08vUllB?=
 =?utf-8?B?U3BVUFJtVGduR1c2V2dsaEN5YkhYNjk4R3BGVSs1a0dpNzg5ZXF3WHdKU0RG?=
 =?utf-8?B?b0lxeEVtUUJQdC9iWGY3VkNhNHBpaXBobDZUSjJGR3JEd2hXNUdjQlNPcElH?=
 =?utf-8?B?anZtd05CeG4vN1VyNU9wOTVleUlZTmlvSy84YVdxQ09OOFdyMlRHckZhUDAr?=
 =?utf-8?B?NEpwaE9QeUVUR25xNlZrb0tIYVdxaGJFaE5Kbm91SUNwK2htZWV1Smc0bVJl?=
 =?utf-8?B?WEZMUVNwMDZvRytUWjVBUEt2QjR2N0lNa0NON3g1dm15NllpTm1XalFIZ0h2?=
 =?utf-8?B?a0FvcXJsZVQ2Rml6dmZLdUxMaWtLMUhUZ0VQaVNIS0J3ZG1hV3lyb05STlha?=
 =?utf-8?B?dHZ0QmdwWEo2WXpOcVhyUGJ3VTdiK0JWYVB6akNlZ2IwYVcydWxLUlRscWpX?=
 =?utf-8?B?OVVPalZzaGc1RVJBMHRZSjFPVzlpRGdpUzJ5R3NrSkM2NUhzNnNkVUtjeERH?=
 =?utf-8?B?ZjFPakhHd3drT0NEQXpJZE1lUjVtTTZkK1dZZlQ1ZW5Hc3pLR0wxbnAxRzNC?=
 =?utf-8?B?OXJsUGQ0Mi8xMmhTYXhsU01mNVY0WGZTT0tQMGhXaG1NanBPbEZUS0tHT3Rp?=
 =?utf-8?B?SEtueGdBZFQzK015czhMUT09?=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SA1PR11MB8278.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(7416005)(1800799015)(376005)(366007)(38070700009);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?a29LUEF3eWJHazB1T0pDSjYrWnh2L0E0bkkycXZEeml6ekpMaFNpZ2g2VVM1?=
 =?utf-8?B?elZjNnAxSnBndFJBVWc0d3BBRFRNbTlQTzM2OVRQdHVJY0ZJeWs0b3BGTXo5?=
 =?utf-8?B?L090UnhRcmJmKzIzZTVvNUFjU3JOQ2Jibm8rZXQzNy96M3BucUMrSnYxSEti?=
 =?utf-8?B?NFdpSUZXcnczQjJSL0hOY0xGb1FkTWVOWWVCczlKMnp1RDlvcFdRNTlEZXgz?=
 =?utf-8?B?RDNDSTV4a0dUcGIvZGJRQWFybHVGSkRqTXBOUVhyaytWRGdNSWFkY1pYRmRW?=
 =?utf-8?B?S1hwWGRtb1IwQi9UQlN6MlNLTUhaWXhFWG1adk9tZktDaDBIcVcvektRc2or?=
 =?utf-8?B?VHFnalRmdEFZY2FOMlIydWtqVFdyMy90RlE4Wms1MFhkaGducHk5Z3hTR3Br?=
 =?utf-8?B?bzJYZUdFV0ttek9uamsxemVpNWNNLzRpRWVKUFFEOUxTcG5VVVFoNXdDTXVz?=
 =?utf-8?B?cVZDcHNlZUhZTjJHdFBkbDRIekpQL0VkM0tKNDRQTndHbEw0bWlrQitBT2Rz?=
 =?utf-8?B?d3FVN2pqcU05ZTIzMlF0YnlxSXBYdHRlTWhRTk5vY25FeTh3MDBMeDYvUDJq?=
 =?utf-8?B?OXhCQi93M25WR1ZtTHB5bUFtNzRvWUlENW1BaUVUaWtTbUFwUXdWb3dMa3lw?=
 =?utf-8?B?VTFzU0JMNDVjZTFia0ROV09MQll5TGxUK0pUYi9aRFF0RmNMYjlNODh6SGJw?=
 =?utf-8?B?bU45dUpFc1JnaENnZFdHN0hhb3pWRDQvTThlZHpSSFh3VHNFdkQrejRKdHRl?=
 =?utf-8?B?bzlGY0hhZnVwQnhKQi9vNTUrUmQ1MXkrZ3NSVG5JQjBsR1gyUnd0RGV2QkRu?=
 =?utf-8?B?aHB0ZW02MFF4UzNuSlV2VjVvL3Q4c0UwdGs4U1Vqay91RTY5TlZaMnRzZm9k?=
 =?utf-8?B?MlB5Y3dPT2NnRjh1Q3hGSk5COTRwUnhwbXo4OG45MXBBTFNRTmxpY01pOFYv?=
 =?utf-8?B?ZUZadVV0WC9tZjY0Uy9rMnhtRlFCUENvUkxDZEhBV0NJMnBVZTlZaTRQODJ1?=
 =?utf-8?B?c2phT0k4bERHUU90Wm1ZSkRpOHZISmZ6QURFMzhEcXNqbjhuWHRlZXJZd0JV?=
 =?utf-8?B?ZnlRWXVOWE13UXF5OG43M1ZncFB2WElxOFQzVm44T2FFMFhwVzVGNWlwSnJ1?=
 =?utf-8?B?TW1qbTR4a01Xd2o2bDNSa202TVphUVdkNHpvcjdiYTdhdnVKenQrWlF0amVy?=
 =?utf-8?B?TjJCY1UvMHZzV0E0UDZ1QjJJekVjcnlNNkx0UmNpd004T2Y0Nmp5aGluUkdl?=
 =?utf-8?B?TG1lcUZXTWQvMlBLUG8xRUlPOVRCTEZVZklkQXFwSXlVcXVPNzB6RnR0V09C?=
 =?utf-8?B?SFV2Nm5qdDlnNjNVSkRQVDNJdEpEZFFLWktuWTlYT0d1UnFwZ1U0SnJZaWhQ?=
 =?utf-8?B?N0p0czRmeHp0cDU1RXBSK1E2eExleXVWZlZMdnZJN2NFc0xxUnk1SXNRNGVh?=
 =?utf-8?B?NTUrcGRyajF4WkhhQjNrdkVZNmp2ZG4vTkZERzZhY28ydGtUWVN3cnNaWVBT?=
 =?utf-8?B?S2U2SUxNcEFKRmNPZ0JtUmd6dTRmbnJIUHYySlVSZzluSWFUdmdiVitOb01E?=
 =?utf-8?B?WUtlUXkvb2F5TFA5S0lyT2JuU3RuSmQ1Z0JCWDE5djlBN1FMUVRUWjdiVVpv?=
 =?utf-8?B?Z1lpYlRrZDJsdUtCekJqalVhcTAzdW9rZERWSkFRcFZGWU5FWkxKUTlLc2tM?=
 =?utf-8?B?cnpGM003b2xoT010dC9jTFoyNzJ2YThkVDIwaGhyZm0zTU5lTGVkVEY2bzNX?=
 =?utf-8?B?S1IweHVoT0FwandUeERkdE1xdEpuL29hMVNNa3VTTW5RNnorRG5nVWlBNlA3?=
 =?utf-8?B?Ky9PVXFTK0YyZ3FZVjROa0Y1ZmdXbFFvMU4rNjBwZU93MHY1OTNRelV4LzFu?=
 =?utf-8?B?N3Fra1MxYWdnZS9ObVFUalJuaVZOTEtxZ1h5OE5HSjR3VktSc05Cc2MrdWFr?=
 =?utf-8?B?L1pPanB3aW43N1UrM3hqWXZiSS9YZk54L29mcHRWeGVjdFdPa01OZkVIZ0N6?=
 =?utf-8?B?bWpuc3Vub2dnV1FLTk5Ud0NsRzBrR3grWkRKSlBSS1NJNURhbll0c3kyOXdk?=
 =?utf-8?B?YjRFWVdyRzYvVFpmREhUdWVWa0RyU21uUlp0cDRGMTdGOWdOdUNkdGRJZmk1?=
 =?utf-8?B?WHFhL0svNG1CMEh4cTNNRC9EWm43a1VSNVIvMi9pMHRkbTFPTlFDdDdMQ203?=
 =?utf-8?B?QWc9PQ==?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <20E5F8EC73CC7649ABCEDBC14DE09C99@namprd11.prod.outlook.com>
Content-Transfer-Encoding: base64
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: SA1PR11MB8278.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 5c8fac3b-690b-40aa-ecc4-08dc816b2348
X-MS-Exchange-CrossTenant-originalarrivaltime: 31 May 2024 12:13:53.2764
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3f4057f3-b418-4d4e-ba84-d55b4e897d88
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: t7tupx+hgiyWZOVdPrEIg8/EjFhrQ7DAqKFlEoTZUFxEUWtT1fPTMJB0slFhFet8mO6my+ZXYUwsoPMYWR8a1gBnrw0gRdiOcifR4GfC6OSjgyb9OmnULGiS7aeIKsU4
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BL1PR11MB5955

SGkgQWxsLA0KDQpGaXJzdCBvZiBhbGwsIEkgdGhhbmsgYWxsIG9mIHlvdSBmb3IgdGhlIGNvbW1l
bnRzIGFuZCByZXNwb25zZS4gSW4gbXkgDQpvcGluaW9uLCB0aGUgZnJhbWV3b3JrIHdoYXQgd2Ug
aGF2ZSBpbiB0aGlzIHBhdGNoIHNlcmllcyB3aWxsIHN1cHBvcnQgDQphbGwgdGhlIG5lY2Vzc2Fy
eSBmZWF0dXJlcyB0byBlbmFibGUgYmFzaWMgMTBCYXNlLVQxUyBFdGhlcm5ldCANCmNvbW11bmlj
YXRpb24gYW5kIGFsc28gd2UgdGVzdGVkIHRoaXMgd2l0aCBNaWNyb2NoaXAgTEFOODY1MC8xLiBJ
ZiBpdCBpcyANCm5vdCBzdXBwb3J0aW5nIGZvciBvdGhlciB2ZW5kb3IncyBkZXZpY2VzLCB0aGVu
IHBsZWFzZSBsZXQgbWUga25vdyB3ZSANCmNhbiBhZGQgbmVjZXNzYXJ5IGNoYW5nZXMgdG8gc3Vw
cG9ydCB0aGVtLiBUaGUgYmFzaWMgaWRlYSB3aXRoIHRoaXMgDQpwYXRjaCBzZXJpZXMgaXMgdG8g
YmFzZWxpbmUgYW4gaW5pdGlhbCB2ZXJzaW9uIHdoaWNoIGJhc2ljYWxseSBzdXBwb3J0cyANCjEw
QmFzZS1UMVMgRXRoZXJuZXQgY29tbXVuaWNhdGlvbi4NCg0KSSBhZ3JlZSB3ZSBtYXkgaGF2ZSBz
b21lIG1vcmUgZnVydGhlciBmZWF0dXJlcyB0byBiZSBpbXBsZW1lbnRlZCBpbiB0aGUgDQpmcmFt
ZXdvcmsgYnV0IHRoZXkgY2FuIGJlIGRvbmUgbGF0ZXIgb25jZSB3ZSBoYXZlIGEgYmFzaWMgdmVy
c2lvbiANCm1haW5saW5lZC4gV2UgY2FuJ3QgaGF2ZSBhbGwgdGhpbmdzIHRvZ2V0aGVyIGluIHRo
ZSAxc3QgdmVyc2lvbiBvZiB0aGUgDQpwYXRjaCBzZXJpZXMgd2hpY2ggd2lsbCBjcmVhdGUgdW5u
ZWNlc3NhcnkgZGV2aWF0aW9ucyBmcm9tIG91ciBmb2N1cy4NCg0KU28gSSB3b3VsZCByZXF1ZXN0
IGFsbCBvZiB5b3UgdG8gZ2l2ZSB5b3VyIGNvbW1lbnRzIG9uIHRoZSBleGlzdGluZyANCmltcGxl
bWVudGF0aW9uIGluIHRoZSBwYXRjaCBzZXJpZXMgdG8gaW1wcm92ZSBiZXR0ZXIuIE9uY2UgdGhp
cyB2ZXJzaW9uIA0KaXMgbWFpbmxpbmVkIHdlIHdpbGwgZGlzY3VzcyBmdXJ0aGVyIHRvIGltcGxl
bWVudCBmdXJ0aGVyIGZlYXR1cmVzIA0Kc3VwcG9ydGVkLiBJIGZlZWwgdGhlIGN1cnJlbnQgZGlz
Y3Vzc2lvbiBkb2Vzbid0IGhhdmUgYW55IGltcGFjdCBvbiB0aGUgDQpleGlzdGluZyBpbXBsZW1l
bnRhdGlvbiB3aGljaCBzdXBwb3J0cyBiYXNpYyAxMEJhc2UtVDFTIEV0aGVybmV0IA0KY29tbXVu
aWNhdGlvbi4NCg0KVGhhbmtzIGZvciB5b3VyIHVuZGVyc3RhbmRpbmcuIFBsZWFzZSBsZXQgbWUg
a25vdyBpZiB5b3UgaGF2ZSBhbnkgDQpvcGluaW9uIG9uIHRoaXMuDQoNCkJlc3QgcmVnYXJkcywN
ClBhcnRoaWJhbiBWDQoNCk9uIDMwLzA1LzI0IDM6MTMgcG0sIFBpZXJnaW9yZ2lvIEJlcnV0byB3
cm90ZToNCj4gRVhURVJOQUwgRU1BSUw6IERvIG5vdCBjbGljayBsaW5rcyBvciBvcGVuIGF0dGFj
aG1lbnRzIHVubGVzcyB5b3Uga25vdyB0aGUgY29udGVudCBpcyBzYWZlDQo+IA0KPiBIZWxsbyBB
bmRyZXcsDQo+IA0KPiBJIHdhcyByZWFkaW5nIGJhY2sgaW50byB0aGUgTUFDUEhZIHNwZWNpZmlj
YXRpb25zIGluIE9QRU4gQWxsaWFuY2UsIGFuZCBpdCBzZWVtcyBsaWtlIE1NUyAxMCB0byBNTVMg
MTUgYXJlIGFjdHVhbGx5IGFsbG93ZWQgYXMgdmVuZG9yIHNwZWNpZmljIHJlZ2lzdGVycy4gU2Vl
IHBhZ2UgNTAuDQo+IFRoZSBzcGVjaWZpY2F0aW9ucyBmdXJ0aGVyIHNheSB0aGF0IHZlbmRvciBz
cGVjaWZpYyByZWdpc3RlcnMgb2YgdGhlIFBIWSB0aGF0IHdvdWxkIG5vcm1hbGx5IGJlIGluIE1N
RDMwLTMxIChpZSwgZXhjbHVkaW5nIHRoZSBQTENBIHJlZ2lzdGVycyBhbmQgdGhlIG90aGVyIE9Q
RU4gc3RhbmRhcmQgcmVnaXN0ZXJzKSB3b3VsZCBnbyBpbnRvIE1NUzEwIHRvIE1NUzE1Lg0KPiAN
Cj4gU28gSSdtIHdvbmRlcmluZywgd2h5IGlzIGl0IGJhZCB0byBoYXZlIHZlbmRvciBzcGVjaWZp
YyByZWdpc3RlcnMgaW50byBNTUQxMCB0byBNTUQxNT8NCj4gSSB0aGluayB0aGUgZnJhbWV3b3Jr
IHNob3VsZCBhbGxvdyBub24tc3RhbmRhcmQgc3R1ZmYgdG8gYmUgbWFwcGVkIGludG8gdGhlc2Us
IG5vPw0KPiANCj4gVGhhbmtzLA0KPiBQaWVyZ2lvcmdpbw0KPiANCj4gLS0tLS1PcmlnaW5hbCBN
ZXNzYWdlLS0tLS0NCj4gRnJvbTogQW5kcmV3IEx1bm4gPGFuZHJld0BsdW5uLmNoPg0KPiBTZW50
OiAyNCBNYXksIDIwMjQgMjM6NTUNCj4gVG86IFBpZXJnaW9yZ2lvIEJlcnV0byA8UGllci5CZXJ1
dG9Ab25zZW1pLmNvbT4NCj4gQ2M6IFNlbHZhbWFuaSBSYWphZ29wYWwgPFNlbHZhbWFuaS5SYWph
Z29wYWxAb25zZW1pLmNvbT47IFBhcnRoaWJhbi5WZWVyYXNvb3JhbkBtaWNyb2NoaXAuY29tOyBk
YXZlbUBkYXZlbWxvZnQubmV0OyBlZHVtYXpldEBnb29nbGUuY29tOyBrdWJhQGtlcm5lbC5vcmc7
IHBhYmVuaUByZWRoYXQuY29tOyBob3Jtc0BrZXJuZWwub3JnOyBzYWVlZG1AbnZpZGlhLmNvbTsg
YW50aG9ueS5sLm5ndXllbkBpbnRlbC5jb207IG5ldGRldkB2Z2VyLmtlcm5lbC5vcmc7IGxpbnV4
LWtlcm5lbEB2Z2VyLmtlcm5lbC5vcmc7IGNvcmJldEBsd24ubmV0OyBsaW51eC1kb2NAdmdlci5r
ZXJuZWwub3JnOyByb2JoK2R0QGtlcm5lbC5vcmc7IGtyenlzenRvZi5rb3psb3dza2krZHRAbGlu
YXJvLm9yZzsgY29ub3IrZHRAa2VybmVsLm9yZzsgZGV2aWNldHJlZUB2Z2VyLmtlcm5lbC5vcmc7
IEhvcmF0aXUuVnVsdHVyQG1pY3JvY2hpcC5jb207IHJ1YW5qaW5qaWVAaHVhd2VpLmNvbTsgU3Rl
ZW4uSGVnZWx1bmRAbWljcm9jaGlwLmNvbTsgdmxhZGltaXIub2x0ZWFuQG54cC5jb207IFVOR0xp
bnV4RHJpdmVyQG1pY3JvY2hpcC5jb207IFRob3JzdGVuLkt1bW1lcm1laHJAbWljcm9jaGlwLmNv
bTsgTmljb2xhcy5GZXJyZUBtaWNyb2NoaXAuY29tOyBiZW5qYW1pbi5iaWdsZXJAYmVybmZvcm11
bGFzdHVkZW50LmNoDQo+IFN1YmplY3Q6IFJlOiBbUEFUQ0ggbmV0LW5leHQgdjQgMDAvMTJdIEFk
ZCBzdXBwb3J0IGZvciBPUEVOIEFsbGlhbmNlIDEwQkFTRS1UMXggTUFDUEhZIFNlcmlhbCBJbnRl
cmZhY2UNCj4gDQo+IFtFeHRlcm5hbCBFbWFpbF06IFRoaXMgZW1haWwgYXJyaXZlZCBmcm9tIGFu
IGV4dGVybmFsIHNvdXJjZSAtIFBsZWFzZSBleGVyY2lzZSBjYXV0aW9uIHdoZW4gb3BlbmluZyBh
bnkgYXR0YWNobWVudHMgb3IgY2xpY2tpbmcgb24gbGlua3MuDQo+IA0KPj4gSW4gcmVhbGl0eSwg
aXQgaXMgbm90IHRoZSBQSFkgaGF2aW5nIHJlZ2lzdGVyIGluIE1NUzEyLCBhbmQgbm90IGV2ZW4N
Cj4+IHRoZSBNQUMuIFRoZXNlIGFyZSByZWFsbHkgImNoaXAtc3BlY2lmaWMiIHJlZ2lzdGVycywg
dW5yZWxhdGVkIHRvDQo+PiBuZXR3b3JraW5nIChlLmcuLCBHUElPcywgSFcgZGlhZ25vc3RpY3Ms
IGV0Yy4pLg0KPiANCj4gSGF2aW5nIGEgR1BJTyBkcml2ZXIgd2l0aGluIHRoZSBNQUMgZHJpdmVy
IGlzIE8uSy4gRm9yIGhhcmR3YXJlIGRpYWdub3N0aWNzIHlvdSBzaG91bGQgYmUgdXNpbmcgZGV2
bGluaywgd2hpY2ggbWFueSBNQUMgZHJpdmVycyBoYXZlLiBTbyBpIGRvbid0IHNlZSBhIG5lZWQg
Zm9yIHRoZSBQSFkgZHJpdmVyIHRvIGFjY2VzcyBNTVMgMTIuDQo+IA0KPiBBbnl3YXksIHdlIGNh
biBkbyBhIHJlYWwgcmV2aWV3IHdoZW4geW91IHBvc3QgeW91ciBjb2RlLg0KPiANCj4+IEFsdGhv
dWdoLCBJIHRoaW5rIGl0IGlzIGEgZ29vZCBpZGVhIGFueXdheSB0byBhbGxvdyB0aGUgTUFDUEhZ
IGRyaXZlcnMNCj4+IHRvIGhvb2sgaW50byAvIGV4dGVuZCB0aGUgTURJTyBhY2Nlc3MgZnVuY3Rp
b25zLiAgSWYgYW55dGhpbmcsIGJlY2F1c2UNCj4+IG9mIHRoZSBoYWNrcyB5b3UgbWVudGlvbmVk
LiBCdXQgYWxzbyB0byBhbGxvdyB2ZW5kb3Itc3BlY2lmaWMNCj4+IGV4dGVuc2lvbnMuDQo+IA0K
PiBCdXQgd2UgZG9uJ3Qgd2FudCB2ZW5kb3Igc3BlY2lmaWMgZXh0ZW5zaW9ucy4gT1MgMTAxLCB0
aGUgT1MgaXMgdGhlcmUgdG8gbWFrZSBhbGwgaGFyZHdhcmUgbG9vayB0aGUgc2FtZS4gQW5kIGlu
IGdlbmVyYWwsIGl0IGlzIG5vdCBvZnRlbiB0aGF0IHZlbmRvcnMgYWN0dWFsbHkgY29tZSB1cCB3
aXRoIGFueXRoaW5nIHVuaXF1ZS4gQW5kIGlmIHRoZXkgZG8sIGFuZCBpdCBpcyB1c2VmdWwsIG90
aGVyIHZlbmRvcnMgd2lsbCBjb3B5IGl0LiBTbyByYXRoZXIgdGhhbiBkb2luZyB2ZW5kb3Igc3Bl
Y2lmaWMgZXh0ZW5zaW9ucywgeW91IHNob3VsZCBiZSB0aGlua2luZyBhYm91dCBob3cgdG8gZXhw
b3J0IGl0IGluIGEgd2F5IHdoaWNoIGlzIGNvbW1vbiBhY3Jvc3MgbXVsdGlwbGUgdmVuZG9ycy4N
Cj4gDQo+ICAgICBBbmRyZXcNCg0K

