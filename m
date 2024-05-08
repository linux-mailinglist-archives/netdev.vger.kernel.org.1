Return-Path: <netdev+bounces-94646-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id D35318C00AE
	for <lists+netdev@lfdr.de>; Wed,  8 May 2024 17:12:01 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 6112E1F221D9
	for <lists+netdev@lfdr.de>; Wed,  8 May 2024 15:12:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6CA7A127B72;
	Wed,  8 May 2024 15:11:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=microchip.com header.i=@microchip.com header.b="m4d+ZvIx";
	dkim=pass (2048-bit key) header.d=microchip.com header.i=@microchip.com header.b="lICX6LqO"
X-Original-To: netdev@vger.kernel.org
Received: from esa.microchip.iphmx.com (esa.microchip.iphmx.com [68.232.153.233])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 861AE1272BF;
	Wed,  8 May 2024 15:11:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=68.232.153.233
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715181100; cv=fail; b=iyJY6So8hNBK19AyaBJpG6TLfXaxmehFfx1q4CcnwYkVudOeiiNDuBpXhgG8O2Qofmrw5mvSShtDz7cOs6Tv3SKQW3yCODfIbeKlwokGuazsjAwmF4dXe4ri8y8nbf7WYlfXGUfAO0V1RDUfYhOFj/HQzHaqzk3dafipR6W/FAI=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715181100; c=relaxed/simple;
	bh=vOFatVDc0fJe5mbG4rQPtTjuJ0jzO1aKiKc966AfdfI=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=ZrLu25jbB9TsGBrulzyjivSuGpdUeoAjPvxoLerqO2P/x8/CM/MA1QjiBWjZAezN4dhKqwjtPOlMkdFk39P5i/2UTVCA0jwz5jDx/vaHgj7JrMBK4y1rcGOpml1wmeNW2+VZXJuwzumA/73RHdQvZMsTTIOsxFTQIoDbDgwYpPQ=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=microchip.com; spf=pass smtp.mailfrom=microchip.com; dkim=pass (2048-bit key) header.d=microchip.com header.i=@microchip.com header.b=m4d+ZvIx; dkim=pass (2048-bit key) header.d=microchip.com header.i=@microchip.com header.b=lICX6LqO; arc=fail smtp.client-ip=68.232.153.233
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=microchip.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=microchip.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=microchip.com; i=@microchip.com; q=dns/txt; s=mchp;
  t=1715181099; x=1746717099;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-id:content-transfer-encoding:
   mime-version;
  bh=vOFatVDc0fJe5mbG4rQPtTjuJ0jzO1aKiKc966AfdfI=;
  b=m4d+ZvIx72jTx9+XlanOkl6BKbukOl2H9iHs++Ckc4CI5DlS/2aEyx0p
   dOTfhbhl9kqP/Omhyu3l23A/URT03hhshgKHyTpHyen7HdyNjfm5K7yGA
   wqtrDeTkTz4jSkLqE3WgFxbJL1v8oW2D0k4xyp0BntPkQBrpxm40VHZbN
   IMnvSDlen19t5+1IADBx7Ydy/IvJ3SvEHBaKbltitz6Ph7XrwwKukiQNd
   BstqnzV6H/bDqAcnHam/c7qtJGO8+PJfRH2ibmHAs9BHc/YlJ7BXa76Qk
   KtVnhvxInTLctnQgqeS/Whr4wugtVLN+hcI1si3jdaq7kYjv9S8R/goa7
   g==;
X-CSE-ConnectionGUID: y6LI+8pmQzCNYKQc1TRedA==
X-CSE-MsgGUID: soxZi/mhRCCfYmTpyvjrBw==
X-IronPort-AV: E=Sophos;i="6.08,145,1712646000"; 
   d="scan'208";a="254993005"
X-Amp-Result: SKIPPED(no attachment in message)
Received: from unknown (HELO email.microchip.com) ([170.129.1.10])
  by esa5.microchip.iphmx.com with ESMTP/TLS/ECDHE-RSA-AES128-GCM-SHA256; 08 May 2024 08:11:32 -0700
Received: from chn-vm-ex02.mchp-main.com (10.10.85.144) by
 chn-vm-ex01.mchp-main.com (10.10.85.143) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35; Wed, 8 May 2024 08:11:26 -0700
Received: from NAM10-MW2-obe.outbound.protection.outlook.com (10.10.215.250)
 by email.microchip.com (10.10.87.72) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35 via Frontend Transport; Wed, 8 May 2024 08:11:26 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=CnqdZJDs7qWki8OjnauSyWsPx9ddnFq+BwUMSDsmWGT6fWaWx/GXyLtEKD8stzwvYN1Hv0rCq+VuU5jv0FFJQ2lCHahlF+KK1Hw7Q8Ag6/JeXJh5LhnvMxlLN84ZVGJEOH/r3FjfDFfpxwtlk5IQU0aJcppIeJXGL33Eke7foaT4qd94x2b7w/B1EvK5BrRrsuBNGKT0JjcCS5hC2LYDjMKEkr0OOWHMEOtaUqN9baEDOTY8+rFPMew3GHBbKl1NKhklkm1vg2OJS4QkbvVXgsoZKduIswK0GMLak5hokIsdtVucJWNVDy4/WWgusk8wwK90tNRlEtQTsRs6z8TDng==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=vOFatVDc0fJe5mbG4rQPtTjuJ0jzO1aKiKc966AfdfI=;
 b=jJvEY3GVBVcsxEo5TRjP32V4/PUnFrwHitzoQSGrRBXfL1i9aVsAsPl2Ty9Pm2/7wW/o1zEPujGYCExuzLEgEbdMM5dRwrYNygFdyui4282x9sINN2ayzyDLDUofkoYqT9FalI6M7lliIqfbobA2/lDpFS8Iju8YxImNC/8rOefYGzxAJIgcaFDJA4V0FvSu+oK77YskbeaIeMkqRIY9NfbOJOC9e1nIJ9r0JSPPbuFRx1XXnGfp1oXLs4OSIUiO9GGg6M2CrNUfFVLzj9pQe+iTuJUZdVhYNkUaKt6HvfCgI7DHTAwUSWncf50vHGCeGXXnvJaLp9yhPNzFtOXBwg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=microchip.com; dmarc=pass action=none
 header.from=microchip.com; dkim=pass header.d=microchip.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=microchip.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=vOFatVDc0fJe5mbG4rQPtTjuJ0jzO1aKiKc966AfdfI=;
 b=lICX6LqOQn7IyJtA8lKkpJXRbUVzdQBfXC63yvyarR7TfN3LUJvHc05SH8F7Ezu18W3nHz+jVrEc68Ju8mYWzheziKY8f+QXsZRZbh0g0lq6rFzhGxLMcsRFqi9UGBhneDT8mtQ79+i5st6j7/FgTY044eDIdnJTSXLA8ub3BnX1eucyFGjQ0nU8qF3rXKPYnnmbo51GUZltRcLHIevAY2FVIM92Gp1w0KuQJ3g8ki//WC/Umi3DgGRoSLNktDLQnImJmiH3AVQf7u2IbYKni8iJ6EQdkSHnq6N7Gd+XV2mkQBw8GyqOWNZfRAUk6iygAelRx5HESmA6CP0Aun22zw==
Received: from PH7PR11MB8033.namprd11.prod.outlook.com (2603:10b6:510:246::12)
 by PH7PR11MB7515.namprd11.prod.outlook.com (2603:10b6:510:278::5) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7544.45; Wed, 8 May
 2024 15:11:24 +0000
Received: from PH7PR11MB8033.namprd11.prod.outlook.com
 ([fe80::22a1:16dd:eea9:330c]) by PH7PR11MB8033.namprd11.prod.outlook.com
 ([fe80::22a1:16dd:eea9:330c%2]) with mapi id 15.20.7544.041; Wed, 8 May 2024
 15:11:24 +0000
From: <Arun.Ramadoss@microchip.com>
To: <andrew@lunn.ch>, <olteanv@gmail.com>, <davem@davemloft.net>,
	<Woojung.Huh@microchip.com>, <pabeni@redhat.com>, <o.rempel@pengutronix.de>,
	<edumazet@google.com>, <f.fainelli@gmail.com>, <kuba@kernel.org>
CC: <kernel@pengutronix.de>, <dsahern@kernel.org>, <san@skov.dk>,
	<willemb@google.com>, <linux-kernel@vger.kernel.org>,
	<netdev@vger.kernel.org>, <horms@kernel.org>, <UNGLinuxDriver@microchip.com>
Subject: Re: [PATCH net-next v1 3/3] net: dsa: microchip: dcb: set default
 apptrust to PCP only
Thread-Topic: [PATCH net-next v1 3/3] net: dsa: microchip: dcb: set default
 apptrust to PCP only
Thread-Index: AQHaoTQmmxkmJC7tK0SYoMdLNTn/s7GNchMA
Date: Wed, 8 May 2024 15:11:24 +0000
Message-ID: <d4f7d3be15d46b07d7139ee4d453d7366d7aedc3.camel@microchip.com>
References: <20240508103902.4134098-1-o.rempel@pengutronix.de>
	 <20240508103902.4134098-4-o.rempel@pengutronix.de>
In-Reply-To: <20240508103902.4134098-4-o.rempel@pengutronix.de>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
user-agent: Evolution 3.36.5-0ubuntu1 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=microchip.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: PH7PR11MB8033:EE_|PH7PR11MB7515:EE_
x-ms-office365-filtering-correlation-id: c817ce08-c3aa-47e4-a571-08dc6f71205e
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230031|376005|7416005|1800799015|366007|38070700009;
x-microsoft-antispam-message-info: =?utf-8?B?eHZ4S3pDV3lxNkx3ZFF4U0RyM3VGV280b2NTZlVuVEdvYStYMVdzbUxoMndG?=
 =?utf-8?B?VlR2NWMxRC8vOU5aTmJBTEc1YTR5KzBqYzhvSVlHZVFESGtkeE9BUy90elVa?=
 =?utf-8?B?WG5XTnZnT2c4RTZ1ZXk1VXpUbTVObTJhblFjZDc3WXUwSVFORWlSb3IvclhE?=
 =?utf-8?B?WVh5MTh0MFRIVDYwZzR2cmpWTGFmM3lZeFovWjI3NExBUzRMd3ZaWW1NZ1c2?=
 =?utf-8?B?MTZidzlrL3FudFRnTXpIWDRadVdVckhOVG9JZi9aWnQ2ODgyZ2hVZC9TZWlI?=
 =?utf-8?B?N21sR1JEd2tUYUJYUVpOZ3I4RG5Fbkt4VmVPQ2psSFJlS3JyN29QQ3VQUStQ?=
 =?utf-8?B?R25RdFlUZDlvd29vVlZ6SUcreklPUTlMTmhnWksyeENhOERNOG1PUzZ2Z3JT?=
 =?utf-8?B?UU9ZR3VXVTdHVlVNUG56aFJ6T24xK0FNaFVHWUVuZDVEUHo2TWhyUmZwa0tv?=
 =?utf-8?B?dDVJTkRXV2h3RjBoS2hBaTZ4bXVJV3V5MUZPY0tnMG9OV2lLR29Jd0xucXZI?=
 =?utf-8?B?cmZuNGpEZ0FhSDhMTU1jTTJsTVFTdFdpMzNITDlwOFJUSVVISGZwUFQxbWVw?=
 =?utf-8?B?ZFNHSlJMT2wxMGpna2J6dzBibDBqb2VEOXg4WkhscFJhUkZObzVmc2VPOTlB?=
 =?utf-8?B?N3I3czZWSE5BdldDa3NDNXNYM0xtVldGZGZ2Z2EydG9KN0g5bW5uWFg1Qm92?=
 =?utf-8?B?VUlYdUJtbUxHaHBXZkFRZ0RhWEJ0bFpRemQvSVZFVCtNUUVMZG91R3JvbmN0?=
 =?utf-8?B?WmxPZTFZUTcwMmRoQkJYSDdiU0ZNY3N1RjJRNlRER1hIejk2M3l4Ync1NnNq?=
 =?utf-8?B?dituUWVPV1JhTFFkREp4T2pVUlhWTU8wQWV6aG4ySEhvRmV4N3NKNkl1RFpa?=
 =?utf-8?B?V2hmMGNOUEdRR3pSMVErSENGTnhFSXY3SzV6dUVzakQ2RUlQc0FNR2NXOFo0?=
 =?utf-8?B?aHRWdFJ0RVZNR3BGN3JBVXVmazdQZzV3ZnpJUUZtV1F1WDEzK0VyQzNOMUxQ?=
 =?utf-8?B?elJ3anFWOURjUHgvMmsvOTlFUTF5NElkRzdGK05SZExEVUZ3OGNDM3ZYdWxM?=
 =?utf-8?B?aGk0K2M1aGZFRDNIY1l0aHpuMG5iNkxaNXh5OW51ZWh4SGVqYUNudkZ2MlM1?=
 =?utf-8?B?RUV1eml2RFVrL29QWjk0YjZjQ1owSnZCRDdMUnlEZEpnSEZHM2VPMTZsdG9i?=
 =?utf-8?B?MXJCZ1VmamdiNHE3WituME1ETUJqTlVTU2h4KzhTNXFOTkN1V1k0YVlJeFRZ?=
 =?utf-8?B?UVhEaHVneEsvaFd1R3NiZGthdzN2Vjl5UE5oTUozaldoWEdnVWV6Sk1PODRs?=
 =?utf-8?B?NmtwV0NYVkZrOGV1UXNTYjVMMEZqV3lxdkdON0hiRVFRNEtSNGx1c2QxY1NE?=
 =?utf-8?B?YllFUkJ6bkJMNVU3ZnNrMUtXTTV1V1Q4ME4yN1NST3k2OENSQXFGOEIwN2FQ?=
 =?utf-8?B?WFF2VWtaQ1U4TUZabjBHbGNGKzhNUjlXMGJJZzh5NDZwTDVzcUgrY1JKNEFN?=
 =?utf-8?B?Z05MWXd1SHlWOTA4ZVZ0cWdWdVJ5Z2hHTy95TGE2M2lLTHR2YzVaTG5GaEtY?=
 =?utf-8?B?RXBwVHJ0ZVRKdTc3QS96OWcwa0QzR2FWSndRV1F1dUxHME0xNWdwQWNMblhw?=
 =?utf-8?B?VGxKSkxHOTJxcnFsSmsrdy9Wc1VSR09vbStSUkxBeE9NQW5QN1lDS1ZWYXlz?=
 =?utf-8?B?OCtBVXNzZGxYWGtIOXMxLzM0NzhJTExqQXhOLzUwKzhmc2RVYWpGanFqa29m?=
 =?utf-8?B?M2hhNHloQjJFVzQrSGtLaFVCd3p0OHdwZlRlYmhQSnA3a0JGSE5KZWNBUVN0?=
 =?utf-8?B?Qmh6L01wb3RYdlpYc0thQT09?=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH7PR11MB8033.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(376005)(7416005)(1800799015)(366007)(38070700009);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?NFpqcU1MbnBURFI1RkQ0Rnk0TmtXOFpOQkNlZVowSi9UbnB5SUIxZThpMml3?=
 =?utf-8?B?cjFGTTlseE9UbXdwL0NoVjZTTTRxcEppb2wwWmRCbUZ2NXZNZXhxaXRKeVdF?=
 =?utf-8?B?cFMyRmZrSURzOUgxMzhVbldlQkZ2UTRacXhveEV3NU5tQ2xzamJyZlMxTE43?=
 =?utf-8?B?QmtoYmFkMXBDK2lCWmFSdjhzejQ4bGoyR2FhNk51cTRja2xQdEV5UEE3TUpU?=
 =?utf-8?B?QU0zUzE0R1lFUThGb3VrMnZIdm5Remg1SWFlVUdYUWI5UjVIVCtRSWhQRU10?=
 =?utf-8?B?ZDV5TVZYc0VKb0ZhWDJES3FQU1p6WFhHVXpIWmwvUzlZdU1JcVh4d3RxajF6?=
 =?utf-8?B?WUFvQjNuL2ZGZHh5eXpPSTBlMmVwZnkrTEVOVTZDbTV0Rkh3N3JaVTNtS01K?=
 =?utf-8?B?SXBLenA5akxaVVU1TXdyRzFkMmovNVNLMnpHS1pTS0RpL1VYcHJwY2NVNXR1?=
 =?utf-8?B?TFAxek1oaGFJWkV1Z1c3QlV1SUZwb1FwYjJOQTc5YXM0SmthQW9zTCt1MWtG?=
 =?utf-8?B?TlFVQzBIUWQ5d3dLY0Z3bG40M0RsRHE0eUpnRkRXanR0dWFUZHZGQXFWNm0x?=
 =?utf-8?B?dlNNR1FIWnpwVFdOdzZFUkgwdHNYdjNYTlNENm5XOXp0Ty9ZSXN2SEJ4Yjhr?=
 =?utf-8?B?NXZ0R1VQbXJEY1lUUFZXQTFINGRvVFozTGJjQXhhTW9JMzZGRHNtbmQ1OUZp?=
 =?utf-8?B?allVczA1cnRPMUViZ3JvM2JsdFNVS1NPUHg4WkhBSkhVVmhWZnQxczJXaVJ0?=
 =?utf-8?B?M0doamhyNUlTSzVVVmRkUkM1b280em1PVjdPL3NjWit0VjlxMzR2QnFIVURz?=
 =?utf-8?B?d1luNTVYZGlacjBRRjcwMkxKMmlZdDU4aEVFWkFwbytNTjdocjlyVVJKN1lx?=
 =?utf-8?B?LzUvZ2ZJR1ZaRjRVdUtUNWdMU0NtZkp2NGpzMDE0bi9jeUZNeUVDS2hvbDVJ?=
 =?utf-8?B?R1M2QWROSm9Iam5zSTBpb1BIVXp5SGl1UjBuK2RyOWhaQzVHWTQ1SXBFdFlO?=
 =?utf-8?B?dndnZ2RuVld6RlBPSElvb2gwenVGMmMwQkg2dzhoSzRERWlsUi9BbUVrREx1?=
 =?utf-8?B?VVNzR1hXTmh5ZnErQjF1SHU3M2lKeXZFYkZZTGZINmZwWXJCTDcvZWVwRElF?=
 =?utf-8?B?eFZnZWNTV1FXOE1ETm5vSThYMWtiampVMzN0M0FxWVZ0eWE0T1VtS2FrSTN0?=
 =?utf-8?B?NjhOeWpUc3YxV3Q4dVFodjNhbE5GU3ZnVk5Kd2FUOFNodEgzQ3FiV2VFdGtT?=
 =?utf-8?B?dCsxYUdaZ0FEM3VFODRQcU5GM3dXRXNFaW05dTRjSjFZNFhzZm5aZ0QzekFX?=
 =?utf-8?B?TEJhekZUVmd3Qm53aVRUMXZSTjgwT1RSRVFmbjI3U2Y4V0lsdGQ1UUZ5K1M2?=
 =?utf-8?B?UEJmcGRHdXhyV1grKy9YSnJGaTkrai9Jbmp0bTVMNW9SVUQwL3pJaGJHRkgy?=
 =?utf-8?B?c0V2RlBKQ29HTEk2R3NSVHJBbWRlTytmRFp3UXNPYVp0a3NxdkdyOEJmTzZF?=
 =?utf-8?B?ZkdNUDBIS1Y2UTE5YWpvNENQT2g2TlFRVWpPM3d6RzNiS1JrK2EzV2JxN3ox?=
 =?utf-8?B?RXpVMlZRaTVEaUVvTkpQcm1CNnJnZnRMaUZXQ05kRkJGMTc3TjhKQ0drRGU1?=
 =?utf-8?B?RE5CNk5vUGZDVUc0REVWSmpVdUxXeTNJWGlnVTBBMGZ0SFZaNG5LNTVNdU1Q?=
 =?utf-8?B?bWwvU3dMQ3JUcXlEWkRxQXdJck83UE9YVFRDV2tFbnhna292akJSK3V6WGlK?=
 =?utf-8?B?NmlUNzB4WDdxM01OUUpCa0l2enBMdVdiQU95WUZmMU9mdzNhQWdsVzlKblZR?=
 =?utf-8?B?MXVib1oxMzFUcDNvRDNZVUZ6U0ZCaUlMT2NLYUdoS1Z0dUdmczQxMDVHMUh2?=
 =?utf-8?B?TjhjcG5ybUUyWnlacDFrRGVBajNJU2lCZ2pZNENXRHZyNVIwZXEweXZ1OGNC?=
 =?utf-8?B?MUQ3MkdOQUl5RUM0SHR2MlJRNThUNXdkM0Y2TzVEYi9xV2xsc0xZTmxnUEh4?=
 =?utf-8?B?N2FIYUYwWUhpVjJ5aTVLYzVoakhzRFd1TDFsMDRmUVE5NUU1OXBYNTVobEJi?=
 =?utf-8?B?bXdKWG01MU43STZXeFNsTmYzdjNROTJiMis5ckRCd3JmV1Q0VEV3cklEZnMr?=
 =?utf-8?B?VlZkaW52K1RCa1cydDV6SlVIWmtLeDVqSlRZYk4yR0djMnhMeGsyckFnVG5P?=
 =?utf-8?B?L1E9PQ==?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <09C7D29A4178BE41A26463A7D83A6E2C@namprd11.prod.outlook.com>
Content-Transfer-Encoding: base64
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: PH7PR11MB8033.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: c817ce08-c3aa-47e4-a571-08dc6f71205e
X-MS-Exchange-CrossTenant-originalarrivaltime: 08 May 2024 15:11:24.4430
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3f4057f3-b418-4d4e-ba84-d55b4e897d88
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 9strp1dQMdtx+dqacAEo0RzjTCSrvDxeJceM2aAi0lCpAhzyUOghnIUhSYu1TmuqkagGuqgnFzATI/4KmTBVFJHA3G8bc6LT8fmk27bcJWs=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR11MB7515

SGkgT2xla3NpaiwNCg0KT24gV2VkLCAyMDI0LTA1LTA4IGF0IDEyOjM5ICswMjAwLCBPbGVrc2lq
IFJlbXBlbCB3cm90ZToNCj4gRVhURVJOQUwgRU1BSUw6IERvIG5vdCBjbGljayBsaW5rcyBvciBv
cGVuIGF0dGFjaG1lbnRzIHVubGVzcyB5b3UNCj4ga25vdyB0aGUgY29udGVudCBpcyBzYWZlDQo+
IA0KPiANCj4gLXN0YXRpYyBjb25zdCB1OCBrc3o4X3BvcnQyX3N1cHBvcnRlZF9hcHB0cnVzdFtd
ID0gew0KPiAtICAgICAgIERDQl9BUFBfU0VMX1BDUCwNCj4gLX07DQo+IC0NCj4gIHN0YXRpYyBj
b25zdCBjaGFyICogY29uc3Qga3N6X3N1cHBvcnRlZF9hcHB0cnVzdF92YXJpYW50c1tdID0gew0K
PiAgICAgICAgICJlbXB0eSIsICJkc2NwIiwgInBjcCIsICJkc2NwIHBjcCINCj4gIH07DQo+IEBA
IC03NzEsOSArNzY3LDggQEAgaW50IGtzel9wb3J0X2dldF9hcHB0cnVzdChzdHJ1Y3QgZHNhX3N3
aXRjaCAqZHMsDQo+IGludCBwb3J0LCB1OCAqc2VsLCBpbnQgKm5zZWwpDQo+ICAgKi8NCj4gIGlu
dCBrc3pfZGNiX2luaXRfcG9ydChzdHJ1Y3Qga3N6X2RldmljZSAqZGV2LCBpbnQgcG9ydCkNCj4g
IHsNCj4gLSAgICAgICBjb25zdCB1OCAqc2VsOw0KPiArICAgICAgIGNvbnN0IHU4IGtzel9kZWZh
dWx0X2FwcHRydXN0W10gPSB7IERDQl9BUFBfU0VMX1BDUCB9Ow0KPiAgICAgICAgIGludCByZXQs
IGlwbTsNCj4gLSAgICAgICBpbnQgc2VsX2xlbjsNCj4gDQo+ICAgICAgICAgaWYgKGlzX2tzejgo
ZGV2KSkgew0KPiAgICAgICAgICAgICAgICAgaXBtID0gaWVlZTgwMjFxX3R0X3RvX3RjKElFRUU4
MDIxUV9UVF9CRSwNCj4gQEAgLTc4OSwxOCArNzg0LDggQEAgaW50IGtzel9kY2JfaW5pdF9wb3J0
KHN0cnVjdCBrc3pfZGV2aWNlICpkZXYsDQo+IGludCBwb3J0KQ0KPiAgICAgICAgIGlmIChyZXQp
DQo+ICAgICAgICAgICAgICAgICByZXR1cm4gcmV0Ow0KPiANCj4gLSAgICAgICBpZiAoa3N6X2lz
X2tzejg4eDMoZGV2KSAmJiBwb3J0ID09IEtTWl9QT1JUXzIpIHsNCj4gLSAgICAgICAgICAgICAg
IC8qIEtTWjg4eDMgZGV2aWNlcyBkbyBub3Qgc3VwcG9ydCBEU0NQIGNsYXNzaWZpY2F0aW9uDQo+
IG9uDQo+IC0gICAgICAgICAgICAgICAgKiAiUG9ydCAyLg0KPiAtICAgICAgICAgICAgICAgICov
DQo+IC0gICAgICAgICAgICAgICBzZWwgPSBrc3o4X3BvcnQyX3N1cHBvcnRlZF9hcHB0cnVzdDsN
Cj4gLSAgICAgICAgICAgICAgIHNlbF9sZW4gPSBBUlJBWV9TSVpFKGtzejhfcG9ydDJfc3VwcG9y
dGVkX2FwcHRydXN0KTsNCg0KSWYgd2UgcmVtb3ZlIHRoaXMsIEhvdyB0aGUgdXNlciBhcHBsaWNh
dGlvbiBrbm93cyBhYm91dCB0aGUgRFNDUA0KcmVzaXN0cmljdGlvbiBvZiBLU1o4IHBvcnQgMi4g
SXMgaXQgaW1wbGVtZW50ZWQgaW4gb3RoZXIgZnVuY3Rpb25zPw0KDQo+IC0gICAgICAgfSBlbHNl
IHsNCj4gLSAgICAgICAgICAgICAgIHNlbCA9IGtzel9zdXBwb3J0ZWRfYXBwdHJ1c3Q7DQo+IC0g
ICAgICAgICAgICAgICBzZWxfbGVuID0gQVJSQVlfU0laRShrc3pfc3VwcG9ydGVkX2FwcHRydXN0
KTsNCj4gLSAgICAgICB9DQo+IC0NCj4gLSAgICAgICByZXR1cm4ga3N6X3BvcnRfc2V0X2FwcHRy
dXN0KGRldi0+ZHMsIHBvcnQsIHNlbCwgc2VsX2xlbik7DQo+ICsgICAgICAgcmV0dXJuIGtzel9w
b3J0X3NldF9hcHB0cnVzdChkZXYtPmRzLCBwb3J0LA0KPiBrc3pfZGVmYXVsdF9hcHB0cnVzdCwN
Cj4gKyAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgIEFSUkFZX1NJWkUoa3N6X2Rl
ZmF1bHRfYXBwdHJ1c3QpDQo+ICk7DQo+ICB9DQo+IA0KPiAgLyoqDQo+IC0tDQo+IDIuMzkuMg0K
PiANCg==

