Return-Path: <netdev+bounces-147973-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 34C509DF9A9
	for <lists+netdev@lfdr.de>; Mon,  2 Dec 2024 04:37:12 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 796BBB21954
	for <lists+netdev@lfdr.de>; Mon,  2 Dec 2024 03:37:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9AAE01F8AC7;
	Mon,  2 Dec 2024 03:37:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=microchip.com header.i=@microchip.com header.b="5jSzKLFY"
X-Original-To: netdev@vger.kernel.org
Received: from NAM02-SN1-obe.outbound.protection.outlook.com (mail-sn1nam02on2087.outbound.protection.outlook.com [40.107.96.87])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 930EE1E260D;
	Mon,  2 Dec 2024 03:37:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.96.87
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733110626; cv=fail; b=fybJJ28Yg53NAnqE/pArRIBKQXiNTZLoQNmhxA6Xcgop9hrrm9eD3//iLeVnpPSwtEVSCLA/DGYdyzKpARjH4vhARsgd30ByCd7qCtvOazFmAThkw34HpfrR/zztsAwtLWAZwVg6Yfr+F+HPhMYCSo/UzsdwrKVAFHJoEsEMxMU=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733110626; c=relaxed/simple;
	bh=TE57mf14YCDl7narxjaZvZogeOraSofYRVjkhvNjTPA=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=WN+HKnMB9BsEvp1TZdNaG7xH9oJzrMS9X8SbvzX+wh/gML9esUWCFRsB8WE/5yDxuzwXP8Gp/VrV8rU/9GlFSdyRYFgTd/OpmmfOPxcEBi/Bwnzy/RUCn7biNxARtM6AMojuHdZRmCsxr7y83Hs1bjTKhGHjKY7nd8i95hV31Jo=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=microchip.com; spf=pass smtp.mailfrom=microchip.com; dkim=pass (2048-bit key) header.d=microchip.com header.i=@microchip.com header.b=5jSzKLFY; arc=fail smtp.client-ip=40.107.96.87
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=microchip.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=microchip.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=SDXS1d4X1gWysdCDcFngwpgQAv92IayTQe+jNIgwKG2wURii4ysmgfJcW14wxQPKnYpJAnL9ED8m9r/f4xZXvDjftC/GpqkMvWRgQIUxGNc8MYj/vPMC7NZ/Lps1h00wYH0EyaBrTI0VO3IQFZTk7sRFm1nLFFls7UgINuZwfoCeTujy81tKukI+J+jwJCYhUOB8UhTedaIEyyWo3YIXE2WA0vtUyfbhiUkmkVghoMYvfchhd30R8J9QX3fVkZGD5J87stSB4/CXC0AM3fxt1p3bNLqQEYOTr77Z1yr29BpgMSoFJSpMYSriGVYBRUuENewDI7fm5CjGlhU/ImRnhg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=TE57mf14YCDl7narxjaZvZogeOraSofYRVjkhvNjTPA=;
 b=nYVjR2BpbXl9RBwdZC+/jIYL14/Ahl6QSaPLqZLFv9dPfdlHTe0dQwyA/hPdwCDOsRtw3vU0Q4e48Gs9N+bC1asSWAUI63Jj0mkN29tPilIf80HNfM1gDTT3EfBT/LCrxoYsGaGx5TWw6aeLaeytxAgRJ5YQo/+OI5NtBgrBMD9T0Tt2wuFSL6+fmtzY6Bdf0YRl3YJVdL7/COnbtNFlymX8P1lpe/qOQvRH0M89i9Fgh5H4nk+psXilxE68+bTwy+RAIK7r+JQe0Qpe4AAJKUVq44AQUADCty+a08PaohEsy4fymb52lCmh0IcZCnLOoclYwP7W4WsrWDi68AV07w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=microchip.com; dmarc=pass action=none
 header.from=microchip.com; dkim=pass header.d=microchip.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=microchip.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=TE57mf14YCDl7narxjaZvZogeOraSofYRVjkhvNjTPA=;
 b=5jSzKLFYHHzbeubP1JFGOaz/tc+2EQkZVXWvtlu2QM61GjZAVgiNLURUElqaMXaXEUBqe2CS4Iuv4fCAwijnrtdVjcQEjPj5iD4Az1REF1GrF36XFRnPDUK9KjSTxo1AKideDZ21CWvyp1H6a8Vx/mzilLSbwoiYk54i5J7A6mqTWz5sGyZ/x4f9rhDXn24m9tnEbQAlcOLj7uIL6IxdNJpMKwxWheYx6k5NbhjMYj9Sbfv91nBCoVlNnJC6IW1vnlAYpUkcG5RQ1fG19rO+E8XOF37Cn+TVZZ+88gWOE5BZyHp5rYRM5rfK64owvKQPf1UuewKrEUM4IYpTdhpz2g==
Received: from SA1PR11MB8278.namprd11.prod.outlook.com (2603:10b6:806:25b::19)
 by DM4PR11MB7397.namprd11.prod.outlook.com (2603:10b6:8:103::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8207.17; Mon, 2 Dec
 2024 03:37:01 +0000
Received: from SA1PR11MB8278.namprd11.prod.outlook.com
 ([fe80::84fa:e267:e389:fa9]) by SA1PR11MB8278.namprd11.prod.outlook.com
 ([fe80::84fa:e267:e389:fa9%3]) with mapi id 15.20.8207.017; Mon, 2 Dec 2024
 03:37:01 +0000
From: <Parthiban.Veerasooran@microchip.com>
To: <pabeni@redhat.com>
CC: <netdev@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
	<UNGLinuxDriver@microchip.com>, <jacob.e.keller@intel.com>,
	<andrew+netdev@lunn.ch>, <davem@davemloft.net>, <edumazet@google.com>,
	<kuba@kernel.org>
Subject: Re: [PATCH net v2 2/2] net: ethernet: oa_tc6: fix tx skb race
 condition between reference pointers
Thread-Topic: [PATCH net v2 2/2] net: ethernet: oa_tc6: fix tx skb race
 condition between reference pointers
Thread-Index: AQHbPMhxyo9k5olCKE6AJRp1Vi8GwrLJZfuAgAGUbYCAABbkgIABJgCAgAYmCIA=
Date: Mon, 2 Dec 2024 03:37:01 +0000
Message-ID: <ba984578-318c-4bf3-8ffb-875ab851ee0e@microchip.com>
References: <20241122102135.428272-1-parthiban.veerasooran@microchip.com>
 <20241122102135.428272-3-parthiban.veerasooran@microchip.com>
 <1d7f6fbc-bc3c-4a21-b55e-80fcd575e618@redhat.com>
 <8f06872b-1c6f-47fb-a82f-7d66a6b1c49b@microchip.com>
 <7f5fd10d-aaf9-4259-9505-3fbabc3ba102@redhat.com>
 <b3e23d57-3b3b-474c-ae45-cbbf4eaaef3a@microchip.com>
In-Reply-To: <b3e23d57-3b3b-474c-ae45-cbbf4eaaef3a@microchip.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
user-agent: Mozilla Thunderbird
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=microchip.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: SA1PR11MB8278:EE_|DM4PR11MB7397:EE_
x-ms-office365-filtering-correlation-id: c64942ea-90ae-4206-8f7c-08dd12829537
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SA1PR11MB8278.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(376014)(38070700018);DIR:OUT;SFP:1101;
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230040|366016|1800799024|376014|38070700018;
x-microsoft-antispam-message-info:
 =?utf-8?B?YlBzSzRnekpMS294bmlweklra1gySzl5SW9mcVJ4aXZnc3dmaHFrUVVuWmla?=
 =?utf-8?B?MXByQnZhdjY4a3EvRFdoNE50aHJlWWtTcFc2TDZuYUM4UDlUam9pQUVQbDNY?=
 =?utf-8?B?VHF3am4yaFBTeXdhWjI5bXJ1WTlERjR4aWtBOXU3QUJ6dE1ud0lrak80dDB3?=
 =?utf-8?B?V1N2UWxHVm1mSmdYWGtkZWRHS1JXSmVLeE1YNFdKUnJwMCtBYWFXcXlQeDFX?=
 =?utf-8?B?MjZXQW1vQXNzVGRuYnJ2U3gxWDdzc0RaaEdyY20wcmptUWE1aG1nOWl4UTVO?=
 =?utf-8?B?dHdieHRheWc2VkJRSnFkMjA2cXFIVStMZE1tNVNSdGJVOE52ZmdRbU9ZSXR4?=
 =?utf-8?B?MGdIOEFCQTFQd2JXTWxtZERtLzMzMS9DU3lCNFdjMldSWTA5Z2xyZlhWQ2JJ?=
 =?utf-8?B?NUgrV1d6amVMOEpVR3F1VU1iSk04ZmFnK0c1dGhnQ0lvTm5wTXoxZGQzaGJX?=
 =?utf-8?B?S2ZsMDQ2UDU4NEZhbEVvQkJQSnZIbmN0YTIvOW9NRzM3ZGFhemdLaW01WUxK?=
 =?utf-8?B?elZVM25JYURiRHlvQWZuN2lsMkU5QVBiZi9CdnM3a2E3UU5tV0NoV2cybllu?=
 =?utf-8?B?em1Bc3MvdmxEWWt5UEdDSjF3bEJHQW9aTENmOTEvSXU2bGh3UTFHTXdPc2dN?=
 =?utf-8?B?M3FpaldmSlRtbGVTRzZFMlczaHRIM0VVSVJRWklFWDJidUVpMFBvb0FmaTdN?=
 =?utf-8?B?bjRyVXo1Wlh1T01sV1dienFQaUg0RTZMR2JpSElaZW9tYWRvckVIVmVxcDg0?=
 =?utf-8?B?UlcrRDdzeTdIR0htRHkvdS9GMnEyZnBMY3FQRDFQM21ra3Via043ZkRkd0px?=
 =?utf-8?B?R0p6bG8zUGoyQXJyVDFjNGJMLzQweUVIUDlFOXdsa3dOVmtyNDdxdWU0ZkJE?=
 =?utf-8?B?ald4Z21weDYyWUhIY2FLckMwYkEwMitPNTI2N252emZBNkJvU3pyR1lKZjd5?=
 =?utf-8?B?SDI0VGl1L294MmZCWGJ3S0hWbXV3NDBJSE9TcFE2ODJxVmE1bnlqRWtJaXZF?=
 =?utf-8?B?M1A0TVBheDlhTUFkMzZMR1dFSmkya2EyempFZHpJalZnMzFjVm12TTJDVG02?=
 =?utf-8?B?Q2F6R3lMVVZtOWhIWjBJMUhMUXdHVFlaRkZDVGZlL0JudGRsNzNlZk9BdjFZ?=
 =?utf-8?B?cjZiaTgrMTJLWjB3YmQ1MmlUY2JFT3NlcjdnZlNMeFNpS3BiMHlOeWRMUkxQ?=
 =?utf-8?B?a2c5UjZ3cGdHT3BhbkVMdy9OdFZmMno0aUw0V2VpWk9TYnUyZDBycmtKSUdm?=
 =?utf-8?B?WDZVazF0RlUxYk1pbmpkczlJRWFlU3lQaTZJSmpTU29JZTBjMmNwaERJTzdR?=
 =?utf-8?B?OEFTbFhGMXZrVWcyS2xnWVFuK0ZzZm54ZmdRYW1jSHpXb2hhSVVNai8xRDNp?=
 =?utf-8?B?cTJ4ekNlNXRuczk1VTdKanFlVnM5RTdTRSt5SGVwVEoyM0FJV2dac1Z1N3ZV?=
 =?utf-8?B?eWZURHREb0pZMThsT3pnTFM0RDROdVNZTG4zbzVBZ1FwWmRqU3MreE1kK0VL?=
 =?utf-8?B?b0RDSThFQitieDl6UG9BTWdDVWNTYWt0amFGYnZmT2RqMGNYTGtVQThzbXJP?=
 =?utf-8?B?eWkwN3RKcUhSZzJKU0c1akE3R0pRUjJ6OEZKT1IzTjh1RHdwaVl0Nis0VDEw?=
 =?utf-8?B?V2IrdkZvRUlveGlHdW94MmU1cTgzUk9US1VrdFNGSjUzZTBHc3ZFelE1VFAv?=
 =?utf-8?B?ZVdkR241dlZjT2ZPNUhQRjVmdHhtQWpsWnRxazJlQ0h0dzJFNGY5YVVQSUVI?=
 =?utf-8?B?TmJvdDBqZUcraGt3R1ZmSHkxUzVFOE5jSysyUUUrWFB4SW4xRm1lcm51ZFQ2?=
 =?utf-8?Q?KqDrAxJtd7H3+HCuo+XvbW+5eUKMGb5NukvWU=3D?=
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?utf-8?B?ZHY1Tnc4NXQ3Qmh0TjdzOURDL1owajErVnljS0M1cWYwRUF3MUhCYVhmMXRF?=
 =?utf-8?B?eTZCS2lBNm5HcnFiYWRubFVacXhxemFoUE9SVTFqTEJHL0o2NkYwWjBWREtS?=
 =?utf-8?B?NlNYQVdybVUxRmZlaG42b2dNVW91TzMwWSsvV0JqOEl1QnBKN0ZlVEpwN2Zk?=
 =?utf-8?B?blVsSWoweHZEcFFvOE9mQWhPS3dJd3JJN25XWTBtMEI0elJMVWpJdHZVYXpm?=
 =?utf-8?B?bGlFTXlpRjdXaXNtNWZNZElGZEM5ekJrNkwzeTNpZDZiSDNxcjJKbDduWjNW?=
 =?utf-8?B?eEo0NkcxZzNwKzNOYndLbUU2Rm1wSjNMbjhoYjljVmtSTlBGZTFJUEpPMkxr?=
 =?utf-8?B?enl6TU1xVWdpZkZkOVdjcHpVVXRDdEgzWFJBMitRdUUzTmFUcTRtVXcyR3ov?=
 =?utf-8?B?V05id1VyNzNsdkQ2ZGx4U0pza29sME5hQURqZjB0TjVBNElzdlZ3QkE0bXg2?=
 =?utf-8?B?cnZmSmRPZEF4disydzVYZTlEbjJOYkVXcjZtNWxKNHllVlZ5dTA1TmlocEJS?=
 =?utf-8?B?bk9yQ0tVU3BFN3VNT204TUFvSDU0U3ZqS3VIZlNvOHhLYkU3bjRWRXZjMW5T?=
 =?utf-8?B?QXBDMEM3RGZ4SXE4Um9ubWZiSnBOWXF0dmcvL2J3dXhic2VNQTBNdURDZGJN?=
 =?utf-8?B?RjYxbXhrSmc2ekVqa0h1UFliRWViUzAxbHlyUHpscVpxNW44TC84NFNncXkv?=
 =?utf-8?B?b3NOb3NDS1R1cW03endGZzBlZGpORDJRNmxPdnJoSENoaU9ORGZZZEh3VERQ?=
 =?utf-8?B?aHdkT1YyU0NDSUp6ckhYZldSUG9BWUxqVjhWKzNTOUhDYWd0U0xXVDMxcng2?=
 =?utf-8?B?SmIvSVc0eFhmTllLTWdpQ2hZakxZeEdxcVhRR2hiK05Xb2FhMndXdnJNNi9Q?=
 =?utf-8?B?N3JlYjAxRWMza2toK1dITmhNZmRCQUFaSEYzWHpNdkhqcHZKNWN2M1NmdUR2?=
 =?utf-8?B?VERmVzYxelpwalpTOWdzTXFMTDUzZU5pbVM2L0IyNUFudktBVzFSMFB5RzVN?=
 =?utf-8?B?NFc0OTVRR0ppM0oyWlQ5azljdGJzNDUwS3Rua3JyZnI4QzdaRzJhNm4xaGsv?=
 =?utf-8?B?TFRRYVNiREhZM0ZsUU14SjM0N2xpbm9NaXFYVFh3a1hpcUVTYmtEQVk1ck5o?=
 =?utf-8?B?WUZhZUlNaTJkSFBKdzF5NFJWNk1oVy9BUVA1dXU4cFpJRlhYNXZaRW9PTXp4?=
 =?utf-8?B?ZzJ1dDZSQm9wTDBydTNnU2FpRkJmakJHeVBIZVJjdlRQczlqVi84cEZXaGF4?=
 =?utf-8?B?bTV4VVN1bWd5cDhoVTBZdUhBK2JHbXZQZ0NJYWkzcjdtUWNFc2hZY2NSNmNJ?=
 =?utf-8?B?dGFMdUtta0JjZ0UyV3hydERIK082L2RNOTFBVm1zWXNwS3pJb3JrbDNQeS8y?=
 =?utf-8?B?Rk01NzI1YllDRUNqT3kwUDBXN2Q3WlZHelZFYWhHdEswQVJFVTRRRWVjUW1s?=
 =?utf-8?B?NDM3N0FRanUzNG94aVFQS1ZpUk1aMGl6NENxZVRCb3haQzN1ckZ2ZzJMcHN5?=
 =?utf-8?B?Z3pPUXJ5ZnhaUWszd0prd0NMTGpvL2VZMm9rRFE4c2piQ3NnaEsvcXZIa1ZF?=
 =?utf-8?B?eUlRQThMM01KNS9xL3lDcUpIYXRMZkU5Y1ZxSzVydG90bjg1T09Vb1VuaU9V?=
 =?utf-8?B?Rm9VVml4UGwxcGw2NDNFQ1c5K0taV1E0R3dsOFl0d3ZXOEVCZHk3RmFnRk5W?=
 =?utf-8?B?N283OUp3Y2RCZG9aWjhpK1RaU2xwczYwb2diV3ZmV1MwbTNkTjJoZnFSQjl0?=
 =?utf-8?B?Y09YcEorV0czSWlTL2JnMzNwTXQySC9Nei9FY3JUUXhvWmp4MXRvbjQxY1Y5?=
 =?utf-8?B?UmtqVXAzeGRYblg3Zzk2SHRKTDhzMlIrc0JKcEZUd1dWK0dHL3JrZmRMSGlt?=
 =?utf-8?B?ZmVKNDcyQ2diZFZDdXZXdkhxQ3NPMTZESnZMekY2N25ZeTdiVUdHbVV0MlU1?=
 =?utf-8?B?d2lvZW5NdVN0TUxLSFBSTjIwT3ZlUmRyV1d3clUxSFpiTFJvdzVJV1k3MWlJ?=
 =?utf-8?B?b2xrcGNKaDdTeXVHUk9yMERCWVdUUVNhQjN0NjIvZi9DMGxJNjh5d2pVeGVG?=
 =?utf-8?B?RnBFS1Y2NkJSM2tjbndLL3hOQlZNWlR3ZTJ4elZkUWVvQTVqb2pKTnJHWHZB?=
 =?utf-8?B?UFpjaDJ3U0tveEt3Rm5uWTM0VzhrRFl3S1ZoMDFnOUtQeWVLMzFVQlI0K3Za?=
 =?utf-8?B?V1E9PQ==?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <140DB7AFCA7D0146B4A994999CECF95C@namprd11.prod.outlook.com>
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
X-MS-Exchange-CrossTenant-Network-Message-Id: c64942ea-90ae-4206-8f7c-08dd12829537
X-MS-Exchange-CrossTenant-originalarrivaltime: 02 Dec 2024 03:37:01.4891
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3f4057f3-b418-4d4e-ba84-d55b4e897d88
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: SbFtySyzfI90cMaom0CykUEWzFsNVcJ8RVrTrokOFlTROvBQ83XV90UeFxGhBsQsIdG4zjWPAuzP3WhlIjfFrybfHqOBMaR+R/iQJNWdkK+4obCsHn+ExIyaDzIQC+vs
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM4PR11MB7397

SGkgUGFvbG8sDQoNCkRvZXMgdGhlIGJlbG93IHJlcGx5IGNsYXJpZmllcyB5b3VyIHF1ZXN0aW9u
IGFuZCBzaGFsbCBJIHByb2NlZWQgdG8gDQpwcmVwYXJlIHRoZSBuZXh0IHZlcnNpb24/IE9SIHN0
aWxsIGRvIHlvdSBoYXZlIGFueSBjb21tZW50cyBvbiB0aGF0Pw0KDQpCZXN0IHJlZ2FyZHMsDQpQ
YXJ0aGliYW4gVg0KT24gMjgvMTEvMjQgMTE6MTMgYW0sIFBhcnRoaWJhbi5WZWVyYXNvb3JhbkBt
aWNyb2NoaXAuY29tIHdyb3RlOg0KPiBIaSBQYW9sbywNCj4gDQo+IE9uIDI3LzExLzI0IDU6NDEg
cG0sIFBhb2xvIEFiZW5pIHdyb3RlOg0KPj4gRVhURVJOQUwgRU1BSUw6IERvIG5vdCBjbGljayBs
aW5rcyBvciBvcGVuIGF0dGFjaG1lbnRzIHVubGVzcyB5b3Uga25vdyB0aGUgY29udGVudCBpcyBz
YWZlDQo+Pg0KPj4gT24gMTEvMjcvMjQgMTE6NDksIFBhcnRoaWJhbi5WZWVyYXNvb3JhbkBtaWNy
b2NoaXAuY29tIHdyb3RlOg0KPj4+IE9uIDI2LzExLzI0IDQ6MTEgcG0sIFBhb2xvIEFiZW5pIHdy
b3RlOg0KPj4+PiBFWFRFUk5BTCBFTUFJTDogRG8gbm90IGNsaWNrIGxpbmtzIG9yIG9wZW4gYXR0
YWNobWVudHMgdW5sZXNzIHlvdSBrbm93IHRoZSBjb250ZW50IGlzIHNhZmUNCj4+Pj4NCj4+Pj4g
T24gMTEvMjIvMjQgMTE6MjEsIFBhcnRoaWJhbiBWZWVyYXNvb3JhbiB3cm90ZToNCj4+Pj4+IFRo
ZXJlIGFyZSB0d28gc2tiIHBvaW50ZXJzIHRvIG1hbmFnZSB0eCBza2IncyBlbnF1ZXVlZCBmcm9t
IG4vdyBzdGFjay4NCj4+Pj4+IHdhaXRpbmdfdHhfc2tiIHBvaW50ZXIgcG9pbnRzIHRvIHRoZSB0
eCBza2Igd2hpY2ggbmVlZHMgdG8gYmUgcHJvY2Vzc2VkDQo+Pj4+PiBhbmQgb25nb2luZ190eF9z
a2IgcG9pbnRlciBwb2ludHMgdG8gdGhlIHR4IHNrYiB3aGljaCBpcyBiZWluZyBwcm9jZXNzZWQu
DQo+Pj4+Pg0KPj4+Pj4gU1BJIHRocmVhZCBwcmVwYXJlcyB0aGUgdHggZGF0YSBjaHVua3MgZnJv
bSB0aGUgdHggc2tiIHBvaW50ZWQgYnkgdGhlDQo+Pj4+PiBvbmdvaW5nX3R4X3NrYiBwb2ludGVy
LiBXaGVuIHRoZSB0eCBza2IgcG9pbnRlZCBieSB0aGUgb25nb2luZ190eF9za2IgaXMNCj4+Pj4+
IHByb2Nlc3NlZCwgdGhlIHR4IHNrYiBwb2ludGVkIGJ5IHRoZSB3YWl0aW5nX3R4X3NrYiBpcyBh
c3NpZ25lZCB0bw0KPj4+Pj4gb25nb2luZ190eF9za2IgYW5kIHRoZSB3YWl0aW5nX3R4X3NrYiBw
b2ludGVyIGlzIGFzc2lnbmVkIHdpdGggTlVMTC4NCj4+Pj4+IFdoZW5ldmVyIHRoZXJlIGlzIGEg
bmV3IHR4IHNrYiBmcm9tIG4vdyBzdGFjaywgaXQgd2lsbCBiZSBhc3NpZ25lZCB0bw0KPj4+Pj4g
d2FpdGluZ190eF9za2IgcG9pbnRlciBpZiBpdCBpcyBOVUxMLiBFbnF1ZXVpbmcgYW5kIHByb2Nl
c3Npbmcgb2YgYSB0eCBza2INCj4+Pj4+IGhhbmRsZWQgaW4gdHdvIGRpZmZlcmVudCB0aHJlYWRz
Lg0KPj4+Pj4NCj4+Pj4+IENvbnNpZGVyIGEgc2NlbmFyaW8gd2hlcmUgdGhlIFNQSSB0aHJlYWQg
cHJvY2Vzc2VkIGFuIG9uZ29pbmdfdHhfc2tiIGFuZA0KPj4+Pj4gaXQgbW92ZXMgbmV4dCB0eCBz
a2IgZnJvbSB3YWl0aW5nX3R4X3NrYiBwb2ludGVyIHRvIG9uZ29pbmdfdHhfc2tiIHBvaW50ZXIN
Cj4+Pj4+IHdpdGhvdXQgZG9pbmcgYW55IE5VTEwgY2hlY2suIEF0IHRoaXMgdGltZSwgaWYgdGhl
IHdhaXRpbmdfdHhfc2tiIHBvaW50ZXINCj4+Pj4+IGlzIE5VTEwgdGhlbiBvbmdvaW5nX3R4X3Nr
YiBwb2ludGVyIGlzIGFsc28gYXNzaWduZWQgd2l0aCBOVUxMLiBBZnRlcg0KPj4+Pj4gdGhhdCwg
aWYgYSBuZXcgdHggc2tiIGlzIGFzc2lnbmVkIHRvIHdhaXRpbmdfdHhfc2tiIHBvaW50ZXIgYnkg
dGhlIG4vdw0KPj4+Pj4gc3RhY2sgYW5kIHRoZXJlIGlzIGEgY2hhbmNlIHRvIG92ZXJ3cml0ZSB0
aGUgdHggc2tiIHBvaW50ZXIgd2l0aCBOVUxMIGluDQo+Pj4+PiB0aGUgU1BJIHRocmVhZC4gRmlu
YWxseSBvbmUgb2YgdGhlIHR4IHNrYiB3aWxsIGJlIGxlZnQgYXMgdW5oYW5kbGVkLA0KPj4+Pj4g
cmVzdWx0aW5nIHBhY2tldCBtaXNzaW5nIGFuZCBtZW1vcnkgbGVhay4NCj4+Pj4+IFRvIG92ZXJj
b21lIHRoZSBhYm92ZSBpc3N1ZSwgcHJvdGVjdCB0aGUgbW92aW5nIG9mIHR4IHNrYiByZWZlcmVu
Y2UgZnJvbQ0KPj4+Pj4gd2FpdGluZ190eF9za2IgcG9pbnRlciB0byBvbmdvaW5nX3R4X3NrYiBw
b2ludGVyIHNvIHRoYXQgdGhlIG90aGVyIHRocmVhZA0KPj4+Pj4gY2FuJ3QgYWNjZXNzIHRoZSB3
YWl0aW5nX3R4X3NrYiBwb2ludGVyIHVudGlsIHRoZSBjdXJyZW50IHRocmVhZCBjb21wbGV0ZXMN
Cj4+Pj4+IG1vdmluZyB0aGUgdHggc2tiIHJlZmVyZW5jZSBzYWZlbHkuDQo+Pj4+DQo+Pj4+IEEg
bXV0ZXggbG9va3Mgb3ZlcmtpbGwuIFdoeSBkb24ndCB5b3UgdXNlIGEgc3BpbmxvY2s/IHdoeSBs
b2NraW5nIG9ubHkNCj4+Pj4gb25lIHNpZGUgKHRoZSB3cml0ZXIpIHdvdWxkIGJlIGVub3VnaD8N
Cj4+PiBBaCBteSBiYWQsIG1pc3NlZCB0byBwcm90ZWN0IHRjNi0+d2FpdGluZ190eF9za2IgPSBz
a2IuIFNvIHRoYXQgaXQgd2lsbA0KPj4+IGJlY29tZSBsaWtlIGJlbG93LA0KPj4+DQo+Pj4gbXV0
ZXhfbG9jaygmdGM2LT50eF9za2JfbG9jayk7DQo+Pj4gdGM2LT53YWl0aW5nX3R4X3NrYiA9IHNr
YjsNCj4+PiBtdXRleF91bmxvY2soJnRjNi0+dHhfc2tiX2xvY2spOw0KPj4+DQo+Pj4gQXMgYm90
aCBhcmUgbm90IGNhbGxlZCBmcm9tIGF0b21pYyBjb250ZXh0IGFuZCB0aGV5IGFyZSBhbGxvd2Vk
IHRvDQo+Pj4gc2xlZXAsIEkgdXNlZCBtdXRleCByYXRoZXIgdGhhbiBzcGlubG9jay4NCj4+Pj4N
Cj4+Pj4gQ291bGQgeW91IHBsZWFzZSByZXBvcnQgdGhlIGV4YWN0IHNlcXVlbmNlIG9mIGV2ZW50
cyBpbiBhIHRpbWUgZGlhZ3JhbQ0KPj4+PiBsZWFkaW5nIHRvIHRoZSBidWcsIHNvbWV0aGluZyBh
bGlrZSB0aGUgZm9sbG93aW5nPw0KPj4+Pg0KPj4+PiBDUFUwICAgICAgICAgICAgICAgICAgICAg
ICAgICAgICAgICAgICAgQ1BVMQ0KPj4+PiBvYV90YzZfc3RhcnRfeG1pdA0KPj4+PiAgICAgLi4u
DQo+Pj4+ICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICBvYV90YzZf
c3BpX3RocmVhZF9oYW5kbGVyDQo+Pj4+ICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAg
ICAgICAgICAgICAgLi4uDQo+Pj4gR29vZCBjYXNlOg0KPj4+IC0tLS0tLS0tLS0NCj4+PiBDb25z
aWRlciB3YWl0aW5nX3R4X3NrYiBpcyBOVUxMLg0KPj4+DQo+Pj4gVGhyZWFkMSAob2FfdGM2X3N0
YXJ0X3htaXQpICAgVGhyZWFkMiAob2FfdGM2X3NwaV90aHJlYWRfaGFuZGxlcikNCj4+PiAtLS0t
LS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0gICAtLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0t
LS0tLQ0KPj4+IC0gaWYgd2FpdGluZ190eF9za2IgaXMgTlVMTA0KPj4+IC0gd2FpdGluZ190eF9z
a2IgPSBza2INCj4+PiAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgIC0gaWYgb25nb2lu
Z190eF9za2IgaXMgTlVMTA0KPj4+ICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgLSBv
bmdvaW5nX3R4X3NrYiA9IHdhaXRpbmdfdHhfc2tiDQo+Pj4gICAgICAgICAgICAgICAgICAgICAg
ICAgICAgICAgICAtIHdhaXRpbmdfdHhfc2tiID0gTlVMTA0KPj4+ICAgICAgICAgICAgICAgICAg
ICAgICAgICAgICAgICAgLi4uDQo+Pj4gICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAt
IG9uZ29pbmdfdHhfc2tiID0gTlVMTA0KPj4+IC0gaWYgd2FpdGluZ190eF9za2IgaXMgTlVMTA0K
Pj4+IC0gd2FpdGluZ190eF9za2IgPSBza2INCj4+PiAgICAgICAgICAgICAgICAgICAgICAgICAg
ICAgICAgIC0gaWYgb25nb2luZ190eF9za2IgaXMgTlVMTA0KPj4+ICAgICAgICAgICAgICAgICAg
ICAgICAgICAgICAgICAgLSBvbmdvaW5nX3R4X3NrYiA9IHdhaXRpbmdfdHhfc2tiDQo+Pj4gICAg
ICAgICAgICAgICAgICAgICAgICAgICAgICAgICAtIHdhaXRpbmdfdHhfc2tiID0gTlVMTA0KPj4+
ICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgLi4uDQo+Pj4gICAgICAgICAgICAgICAg
ICAgICAgICAgICAgICAgICAtIG9uZ29pbmdfdHhfc2tiID0gTlVMTA0KPj4+IC4uLi4NCj4+Pg0K
Pj4+IEJhZCBjYXNlOg0KPj4+IC0tLS0tLS0tLQ0KPj4+IENvbnNpZGVyIHdhaXRpbmdfdHhfc2ti
IGlzIE5VTEwuDQo+Pj4NCj4+PiBUaHJlYWQxIChvYV90YzZfc3RhcnRfeG1pdCkgICBUaHJlYWQy
IChvYV90YzZfc3BpX3RocmVhZF9oYW5kbGVyKQ0KPj4+IC0tLS0tLS0tLS0tLS0tLS0tLS0tLS0t
LS0tLSAgIC0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tDQo+Pj4gLSBpZiB3YWl0
aW5nX3R4X3NrYiBpcyBOVUxMDQo+Pj4gLSB3YWl0aW5nX3R4X3NrYiA9IHNrYg0KPj4+ICAgICAg
ICAgICAgICAgICAgICAgICAgICAgICAgICAgLSBpZiBvbmdvaW5nX3R4X3NrYiBpcyBOVUxMDQo+
Pg0KPj4gQUZBSUNTLCBpZiAnd2FpdGluZ190eF9za2IgPT0gTlVMTCBhbmQgVGhyZWFkMiBpcyBp
bg0KPj4gb2FfdGM2X3NwaV90aHJlYWRfaGFuZGxlcigpL29hX3RjNl9wcmVwYXJlX3NwaV90eF9i
dWZfZm9yX3R4X3NrYnMoKQ0KPj4gdGhlbiBvbmdvaW5nX3R4X3NrYiBjYW4gbm90IGJlIE5VTEws
IGR1ZSB0byB0aGUgcHJldmlvdXMgY2hlY2sgaW46DQo+Pg0KPj4gaHR0cHM6Ly9lbGl4aXIuYm9v
dGxpbi5jb20vbGludXgvdjYuMTIvc291cmNlL2RyaXZlcnMvbmV0L2V0aGVybmV0L29hX3RjNi5j
I0wxMDY0DQo+Pg0KPj4gVGhpcyBsb29rcyBsaWtlIGEgc2luZ2xlIHJlYWRlci9zaW5nbGUgd3Jp
dGUgc2NlbmFyaW9zIHRoYXQgZG9lcyBub3QNCj4+IG5lZWQgYW55IGxvY2sgdG8gZW5zdXJlIGNv
bnNpc3RlbmN5Lg0KPj4NCj4+IERvIHlvdSBvYnNlcnZlIGFueSBtZW1vcnkgbGVhayBpbiByZWFs
IGxpZmUgc2NlbmFyaW9zPw0KPj4NCj4+IEJUVyBpdCBsb29rcyBsaWtlIGJvdGggb2FfdGM2X3N0
YXJ0X3htaXQgYW5kIG9hX3RjNl9zcGlfdGhyZWFkX2hhbmRsZXINCj4+IGFyZSBwb3NzaWJseSBs
YWNraW5nIG1lbW9yeSBiYXJyaWVycyB0byBhdm9pZCBtaXNzaW5nIHdha2UtdXBzLg0KPiBBY3R1
YWxseSB0aGUgdHJhbnNtaXQgZmxvdyBjb250cm9sIGlzIGRvbmUgdXNpbmcgdGhlIFRYQyByZXBv
cnRlZCBmcm9tDQo+IE1BQy1QSFkgYW5kIGl0IGlzIGRvbmUgaW4gdGhlIGJlbG93IGZvciBsb29w
LiBUWEMgaXMgVHJhbnNtaXQgQ3JlZGl0DQo+IENvdW50IHJlcHJlc2VudHMgdGhlIHJvb21zIGF2
YWlsYWJsZSB0byBwbGFjZSB0aGUgdHggY2h1bmtzIGluIHRoZSBNQUMtUEhZLg0KPiANCj4gaHR0
cHM6Ly9lbGl4aXIuYm9vdGxpbi5jb20vbGludXgvdjYuMTIvc291cmNlL2RyaXZlcnMvbmV0L2V0
aGVybmV0L29hX3RjNi5jI0wxMDA0DQo+IA0KPiAtIENvbnNpZGVyIGEgc2NlbmFyaW8gd2hlcmUg
dGhlIFRYQyByZXBvcnRlZCBmcm9tIHRoZSBwcmV2aW91cyB0cmFuc2Zlcg0KPiBpcyAxMCBhbmQg
b25nb2luZ190eF9za2IgaG9sZHMgYW4gdHggZXRoZXJuZXQgZnJhbWUgd2hpY2ggY2FuIGJlDQo+
IHRyYW5zcG9ydGVkIGluIDIwIFRYQ3MgYW5kIHdhaXRpbmdfdHhfc2tiIGlzIHN0aWxsIE5VTEwu
DQo+IAl0eF9jcmVkaXRzID0gMTA7IC8qIDIxIGFyZSBmaWxsZWQgaW4gdGhlIHByZXZpb3VzIHRy
YW5zZmVyICovDQo+IAlvbmdvaW5nX3R4X3NrYiA9IDIwOw0KPiAJd2FpdGluZ190eF9za2IgPSBO
VUxMOyAvKiBTdGlsbCBOVUxMICovDQo+IC0gU28sICh0YzYtPm9uZ29pbmdfdHhfc2tiIHx8IHRj
Ni0+d2FpdGluZ190eF9za2IpIGJlY29tZXMgdHJ1ZS4NCj4gLSBBZnRlciBvYV90YzZfcHJlcGFy
ZV9zcGlfdHhfYnVmX2Zvcl90eF9za2JzKCkNCj4gCW9uZ29pbmdfdHhfc2tiID0gMTA7DQo+IAl3
YWl0aW5nX3R4X3NrYiA9IE5VTEw7IC8qIFN0aWxsIE5VTEwgKi8NCj4gLSBQZXJmb3JtIFNQSSB0
cmFuc2Zlci4NCj4gLSBQcm9jZXNzIFNQSSByeCBidWZmZXIgdG8gZ2V0IHRoZSBUWEMgZnJvbSBm
b290ZXJzLg0KPiAtIE5vdyBsZXQncyBhc3N1bWUgcHJldmlvdXNseSBmaWxsZWQgMjEgVFhDcyBh
cmUgZnJlZWQgc28gd2UgYXJlIGdvb2QgdG8NCj4gdHJhbnNwb3J0IHRoZSBuZXh0IHJlbWFpbmlu
ZyAxMCB0eCBjaHVua3MgZnJvbSBvbmdvaW5nX3R4X3NrYi4NCj4gCXR4X2NyZWRpdHMgPSAyMTsN
Cj4gCW9uZ29pbmdfdHhfc2tiID0gMTA7DQo+IAl3YWl0aW5nX3R4X3NrYiA9IE5VTEw7DQo+IC0g
U28sICh0YzYtPm9uZ29pbmdfdHhfc2tiIHx8IHRjNi0+d2FpdGluZ190eF9za2IpIGJlY29tZXMg
dHJ1ZSBhZ2Fpbi4NCj4gLSBJbiB0aGUgb2FfdGM2X3ByZXBhcmVfc3BpX3R4X2J1Zl9mb3JfdHhf
c2ticygpDQo+IAlvbmdvaW5nX3R4X3NrYiA9IE5VTEw7DQo+IAl3YWl0aW5nX3R4X3NrYiA9IE5V
TEw7DQo+IA0KPiBOb3cgdGhlIGJlbG93IGJhZCBjYXNlIG1pZ2h0IGhhcHBlbiwNCj4gDQo+IFRo
cmVhZDEgKG9hX3RjNl9zdGFydF94bWl0KQlUaHJlYWQyIChvYV90YzZfc3BpX3RocmVhZF9oYW5k
bGVyKQ0KPiAtLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0JLS0tLS0tLS0tLS0tLS0tLS0tLS0t
LS0tLS0tLS0tLS0tLS0NCj4gLSBpZiB3YWl0aW5nX3R4X3NrYiBpcyBOVUxMDQo+IAkJCQktIGlm
IG9uZ29pbmdfdHhfc2tiIGlzIE5VTEwNCj4gCQkJCS0gb25nb2luZ190eF9za2IgPSB3YWl0aW5n
X3R4X3NrYg0KPiAtIHdhaXRpbmdfdHhfc2tiID0gc2tiDQo+IAkJCQktIHdhaXRpbmdfdHhfc2ti
ID0gTlVMTA0KPiAJCQkJLi4uDQo+IAkJCQktIG9uZ29pbmdfdHhfc2tiID0gTlVMTA0KPiAtIGlm
IHdhaXRpbmdfdHhfc2tiIGlzIE5VTEwNCj4gLSB3YWl0aW5nX3R4X3NrYiA9IHNrYg0KPiANCj4g
SG9wZSB0aGlzIGNsYXJpZmllcy4NCj4gDQo+IEJlc3QgcmVnYXJkcywNCj4gUGFydGhpYmFuIFYN
Cj4+DQo+PiBDaGVlcnMsDQo+Pg0KPj4gUGFvbG8NCj4+DQo+IA0KDQo=

