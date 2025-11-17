Return-Path: <netdev+bounces-239021-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id 2DBE7C626D4
	for <lists+netdev@lfdr.de>; Mon, 17 Nov 2025 06:43:10 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id F2CEE4E14C1
	for <lists+netdev@lfdr.de>; Mon, 17 Nov 2025 05:43:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 32D0030DEDD;
	Mon, 17 Nov 2025 05:43:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=microchip.com header.i=@microchip.com header.b="bGp5C1Z5"
X-Original-To: netdev@vger.kernel.org
Received: from CY7PR03CU001.outbound.protection.outlook.com (mail-westcentralusazon11010029.outbound.protection.outlook.com [40.93.198.29])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 65FA421FF49;
	Mon, 17 Nov 2025 05:43:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.93.198.29
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763358187; cv=fail; b=mbjFcZNcVoBPgRuCcuPjc1A0mklL58mb05O53Yi/QabsFN0jMrDItThVl9K0cLtvL+e77W4dROxyoabN6QFiocUpKITvcbE4iRL4gZEVwHiQdKMChVmQVSC9YYmUfv0rLEpADg9mKc2IfTjXblsZJAMg8slNYemxA91grXFBhzg=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763358187; c=relaxed/simple;
	bh=2uthDStrcFC9oh0k+MzQR9CrUhGh+CboZ/knRLiGwMk=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=KdtOH6VTU0fEqI4gg9t4OcYpKwtY6Sc8L3pq5VZGKTgOb2ZqHE+VdqKDhuOkRVN73kTR1H8ReqhRQN22YEFLvwsjUWIcGKFdXTNNCj2zuDI+6SUfM7E9s2vT22XiQuLhvAB9tjAt6y8ZYsG39v2NKOKODc72/FcYVSK7LUPPI1A=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=microchip.com; spf=pass smtp.mailfrom=microchip.com; dkim=pass (2048-bit key) header.d=microchip.com header.i=@microchip.com header.b=bGp5C1Z5; arc=fail smtp.client-ip=40.93.198.29
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=microchip.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=microchip.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=o5QyWAX9zPSlD9PMiSe7z8St1NJpO3lHzIj9XWBwKT+BwjQJZL/oNZnL3spLvi4iuoc5MGKH6rua394y9unesXBdJg1AaEXuQeeiEfB5bPMhhz9vWhtK+NAexqwhHPQLJzQx1OnL3xyML2p+CmaOydoDhLjGYRxYArgCVN8MQrruRzJx6OtOK9uh/2+HGnlHs74IdInJ4eh+YDaFIqQcCQWLVYLDyGlk11zLnqenkOLApUj+I0SkppNSfF3NsJMXFWBgRkQYEWTD5+NmWjoVs+FiBEu3goZWbshWwk03Baz2m37hF3DNbCrEzF1jMGIwNZHOTjkSYxif/ElmbYH93A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=2uthDStrcFC9oh0k+MzQR9CrUhGh+CboZ/knRLiGwMk=;
 b=J3LAoWLRr7ivtNvek2a4fJ5cHuR+i8z3SuJWppzAFJ8GtanUtbGpZ4FFJBj8f8i2yU5EuMCv2o7IyR8jhNrJsmwdc8EdwX2KDvfPitqxKwxcyJUThtEc0QTtbl6BpM6xMLflujx8bpQpbJmc/TdhmlYvkRNNgwfrjMPiYPk9B7yqhUCngotXvwkea3Sparpc5Y3YeeXgY1/R3kjsVSZAHgH+rYhrdGghONRxF8zyjeG5EDd7LVGELt9KKrx1LJU2gCKlarCJh7+LG0rOo2rRrGMzXLFxKJ+9m2CYSazVwR0q8kVw0/shqOz5EUkX0AKKZ0GB5EoSDDBYs7CUqRHs6A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=microchip.com; dmarc=pass action=none
 header.from=microchip.com; dkim=pass header.d=microchip.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=microchip.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=2uthDStrcFC9oh0k+MzQR9CrUhGh+CboZ/knRLiGwMk=;
 b=bGp5C1Z50Ot/12Hm8OOsPrSBW9VEfOAsU7uqrlblKszfEoKScKFQGrnK1rEXfe2ql3hgp5lKbG3sfJLO/5F28mKmVsVRf2bwn8rk7NUCe0yRlxXSdUTzIE83O6bVEwtB+zZ3WTa0AkaWghvpp/627IpTNGmP8SywI/JwXjh07pIJ2+Hbv9VmBuh5B7Rj9zldkwj9VY1kpEwJrPDYALiJzJ0lqGk5681/D0nUMA4LZWRHQeh4RqpkVD4inAm8SK0DGSJmpJ83oJhhz8HHi25MAOlYdCftpuIEeTq0MxLuS+No5V6P2P9FEaKoSXIlVkQBHQ4J8iqJxh8XXoVD0/FpOw==
Received: from SA1PR11MB8278.namprd11.prod.outlook.com (2603:10b6:806:25b::19)
 by DS4PPFA2144AAC3.namprd11.prod.outlook.com (2603:10b6:f:fc02::40) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9320.21; Mon, 17 Nov
 2025 05:43:02 +0000
Received: from SA1PR11MB8278.namprd11.prod.outlook.com
 ([fe80::84fa:e267:e389:fa9]) by SA1PR11MB8278.namprd11.prod.outlook.com
 ([fe80::84fa:e267:e389:fa9%5]) with mapi id 15.20.9320.021; Mon, 17 Nov 2025
 05:43:02 +0000
From: <Parthiban.Veerasooran@microchip.com>
To: <andrew@lunn.ch>
CC: <piergiorgio.beruto@gmail.com>, <hkallweit1@gmail.com>,
	<linux@armlinux.org.uk>, <davem@davemloft.net>, <edumazet@google.com>,
	<kuba@kernel.org>, <pabeni@redhat.com>, <netdev@vger.kernel.org>,
	<linux-kernel@vger.kernel.org>
Subject: Re: [PATCH net-next 1/2] net: phy: phy-c45: add SQI and SQI+ support
 for OATC14 10Base-T1S PHYs
Thread-Topic: [PATCH net-next 1/2] net: phy: phy-c45: add SQI and SQI+ support
 for OATC14 10Base-T1S PHYs
Thread-Index: AQHcVJP+UJpYoKf3DEe3CA5/YgnL/LTwyEWAgAESS4CAAGNUAIAEIwUA
Date: Mon, 17 Nov 2025 05:43:01 +0000
Message-ID: <7c0e51cf-df0b-4be1-851b-c91ea45f3380@microchip.com>
References: <20251113115206.140339-1-parthiban.veerasooran@microchip.com>
 <20251113115206.140339-2-parthiban.veerasooran@microchip.com>
 <f6acd8db-4512-4f5d-a8cc-0cc522573db5@lunn.ch>
 <479bd561-3bc2-44fd-8bab-ecd3e62f9c3e@microchip.com>
 <4576bf3a-0945-4745-b7e9-3833cc45027a@lunn.ch>
In-Reply-To: <4576bf3a-0945-4745-b7e9-3833cc45027a@lunn.ch>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
user-agent: Mozilla Thunderbird
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=microchip.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: SA1PR11MB8278:EE_|DS4PPFA2144AAC3:EE_
x-ms-office365-filtering-correlation-id: be2f2144-580e-4294-033b-08de259c2c32
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam:
 BCL:0;ARA:13230040|7416014|376014|1800799024|366016|38070700021;
x-microsoft-antispam-message-info:
 =?utf-8?B?b3Rsd28rQ0FpQ0tvM25qOXJ1TExuOG9iYlh0SnlXcm9OVzgvdTVrWnF0SW9M?=
 =?utf-8?B?cURBbWZoTmpucHJiRW51Nk8yb2JnMkhCUWFjd1FoZk9NY1c5c1dFQjJ6YXRT?=
 =?utf-8?B?YzhteEM5NVN6NmRkSVBkRGNQdUZjQnhWWTFZMmRuNWM4bCt2ZC9NM1ZlMzVh?=
 =?utf-8?B?U2d5YXAzb29RaHA3aFVIcndBcThURXFzckJpa2dFL2NKVHhFZjVDVzY0QTda?=
 =?utf-8?B?b1Z0bm8xZEdxRnFoQlJLakhzMWFLN016dU5xeng5Z2R6dS9VdnZUNkdETEtq?=
 =?utf-8?B?TTUzSlQ5a3ZZUlA2bW9Ub1BzVHhKc3dPbkVvdWppcXpvOTlUU1RYV0d1WmZS?=
 =?utf-8?B?QUNmYk5ncCtvbVZPTnplb2ZTS1ZTMjlIV1Nmckx3UmFBckI3cW5wRVJKSWZr?=
 =?utf-8?B?c2xjSjNrRnhGa2Q1RnAwZ1Job2tpRTBOMlNvT3hCUE1Cd2V2OVVhcHJRWkJ3?=
 =?utf-8?B?YWM1VDgvdzgvSm9wQlpKNVh3N2puVmN0K1lyTEZEN3NsWE1yVU5MVUtpem55?=
 =?utf-8?B?SWRvdHBxYlhCZ21XVm5BK2JLWHRUM3JMeXEvdmQ3SFlBYnRqTm9zRDN2Z3Vz?=
 =?utf-8?B?TDJ3UEhYRkRpSGxMYlVoRGxqWUxDZUorTHdoU3hMbkNpbkMxVDRaQlpXMFFx?=
 =?utf-8?B?bS9OVk5RMDVOdmZBWFgzZTFiSy9za2YxMzJlc3VIVnRBYmd0bEpzeXdURU9O?=
 =?utf-8?B?TEQ1UG1kdWhSZVFmT29QcjVVdmFMVnA4enZUdEJoWElWdGY2U2ZlRndmN2VH?=
 =?utf-8?B?RVNSWFNSMUpaVkY2K3kvdVZ0SXVZOVZYTTJVd0JMdm1ibUJiekVWZ2VXZXBr?=
 =?utf-8?B?enUxNCtwWmJxVm9oRlNQZGZ3TVhia3I5SDNqc0pwTHo5Uk5KV3UyMm4wbDlE?=
 =?utf-8?B?TGlKcHc0OW05UUV5UTk3T2NDbzV4MjVSU3RadWVsKzllcWpiaDMrVnMyQVo1?=
 =?utf-8?B?V1huZmJEbTBIbnNvWVlUSHpyOFpPeFJSSFpMb1g0UlRxbDBIUXVRenQzc0pL?=
 =?utf-8?B?MkczdUw3QWFiYTI0R0FUMXRxWndPVVJscTJHd1IyRi9ROVJ3K2Y2M1MyL1hM?=
 =?utf-8?B?QWtiUGY4N3k2LzIxZDNJMGZBUFY5V3JBcHVJZ244cEEzVm5pZHg5bmZqT1Z0?=
 =?utf-8?B?ODhPQjN1SWNZcWpQYjlubnpRT1NjSU0zckZ2VEMvaldpcjM2MzBVVGthRW4x?=
 =?utf-8?B?dnh0VEdMVDl5ZThxTmdyeDJTY3duZmRXOHR1RHl6UWE1b3B5MXVHWE82L0F6?=
 =?utf-8?B?SnF5bVlxWmNuWmlZU3VMcjlLdkN2QmUyNkdqMWxkMnh4SW5abkkvRmRVQmlx?=
 =?utf-8?B?akFhTmQ5YXN5aURRd3JUaU5TQWtuOC9wS2tJaytsYTFseWR2bWRWL3ViZHhJ?=
 =?utf-8?B?Nm1mdUFOVCt2UEIvcS83Nmo3M0xwZU1hQk84V09QTWdlNzhYazFiTUdvNjBa?=
 =?utf-8?B?RGR6aUNxcHdkWGxzMlZ4bFkyMTVYdFJmbFJ2Y3V3c3JWcG9mRW9YTjZ0YWRv?=
 =?utf-8?B?OHM5aW16R0s2VHdsakt1ZmlHTVRhcFlMRVZuNlA1aHRPWE1NRHpYYXF2NzQ4?=
 =?utf-8?B?dHQ0MHRiMmVLak1OaWU4L0dtWWhzZmkvUXVkTjRVaFhkUENUMUlGcEkxYm9H?=
 =?utf-8?B?eE9NcFphamUrbXZpSlhTNjFlTmo3NzVjeVFrcWJLbFlvRDRzd3ZuY09VdVl0?=
 =?utf-8?B?NnluOWxaclAyRnVXUHRmeHgraUNjNDdrUmNyNGdwM09ESzNvdEUxellENmFJ?=
 =?utf-8?B?aFBXTzRLZ3J6Z3hKMVhQUmpHbjRnTExOVVdmMzE2RmNOaHNwVitLTm1DQ0Ew?=
 =?utf-8?B?NmZ0WVQxS29ZY1BEMFhKdExlTCtjUnlmcmx3NTcyN1hPcnd3bWVadlJUY2I5?=
 =?utf-8?B?TnBEZGcvUTBGNDU0dTZtNjhvaDhmSVVQK0gwc0ZUNm5UNUpINEVETXVGemRF?=
 =?utf-8?B?anBEOUREaDNmQWJKQ0F4azFIaHhRMDgrRkhZNUxuZFBjV2R1ZVZlRFBsNUtn?=
 =?utf-8?B?TFlLTEdDWmZnSGFKUzBoQkxqY0dvdm5VUlBmNUpZaVhNaEZOSGI3Ymx5eFhl?=
 =?utf-8?Q?4vIno1?=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SA1PR11MB8278.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(7416014)(376014)(1800799024)(366016)(38070700021);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?utf-8?B?M1hHVFZZSUI5ZXNOaVhGbjFiajNtV2RLdzcxWlVwem9VTC9KRjdXNjI5eFE3?=
 =?utf-8?B?TVYrYWE3K1VJcERkeFRNV3RpdE1PZDN5bFVOU1h3TC8yNS8vcUQxY2tlWEtp?=
 =?utf-8?B?RG1TeE0xWnlONVNrTTc2QTh5ZkVvWW9RdVNkK1Yra0FlVTgveEVIbVMrbmtv?=
 =?utf-8?B?d2t2bHZyQWZSQVk5cTJ6WDJ4MjBaQzgxenV2bnh5emRXVHd0RXJkd292MU03?=
 =?utf-8?B?REZ5ZmhHbkNuS2FBVUswb2VhbnhZb1FPRERDZFdUejRJczZ6cTFzdlpmSEE3?=
 =?utf-8?B?ZjFVOSs3N05UbTVWWWdDcG5nTW9xOTdabTBvcFliQWVKYzgxTXRSVno3azRh?=
 =?utf-8?B?MjQxQ0h1aU9QSGJYbWZ2V21XNVRUZXZiWi90dFQwcmxpdjNYWkZmREdUQmFv?=
 =?utf-8?B?NU5pdW5UWURCN3Vlbko2UUE5QjZYdXRwT28wMm53N0VLY2ZnL1pDeTA3U1pn?=
 =?utf-8?B?SVBuL3pXUnJrWTlQSGRSc0VUVjJHR2lXdEY5QVppSUptdkZFQTFmTEV4ZU1x?=
 =?utf-8?B?QlFFa1NHbjdreFF2UlVUT05OMGZTYTdud2FUclRJYysrTlZ5M2FYWUUvbHNs?=
 =?utf-8?B?YmxMVUVya2o4OTY4QUJ2UnhMMjE2eVZOQW8zY1ZaSlNvd3d6cXRKSGxsekZu?=
 =?utf-8?B?Z3AzWVUyZVVXZE9KSDlaQjVwbnNLSVFzQzFSelR4bFRpRVQrQ0FmcURRcWp1?=
 =?utf-8?B?SHh5L3paZWY2Z2dTUG8zRkdXTE5hcXl0Y3FFS3FDQ1NPVGgvdEVFWW5vS0ls?=
 =?utf-8?B?WG1ZYk56b1lqR1Z5MFlJc2xtbzdZczQ1Ry9PV2tsSE5wN1hRbkdBNVQyMzcw?=
 =?utf-8?B?SVVMWE9XR3U0M1RPaG9LcFFwMm1WSGxaYTB6M29HZ3ZZYk43dWd2ekZZU2FM?=
 =?utf-8?B?eENDSURkZUlJSUFycWxHbytueWlxMWxNNnNzR3NubGM5SmwzeVNNSHQwSzZq?=
 =?utf-8?B?dkN1REozOEdiTGMvOTF6REdBN2gyd3NvZnVLTlFjVk5xU2ZEUndPazVQdmJM?=
 =?utf-8?B?cW9zU1dWQTB6UEFybGFRb1ZKYi9pWkhyS2lraUVkUSsyVmN1TDJGZHJ1dXZs?=
 =?utf-8?B?ZzRJTlB6c2tZRjJMZG5xTU1namZFU0NQN2w2V3FYNkd5amVDS0ZBbktLSzN5?=
 =?utf-8?B?TEdwZk5RQW9ZTnhMSldmemZDbHFzWlF5c3NZUkR6MTFhNk1TRGpqMndTakdS?=
 =?utf-8?B?bkYvM0VMTHFUb0Z1RHFrK1Azd3J4bnBwUkFtU3RERzUvL1gzeENkbS81eGdh?=
 =?utf-8?B?ZEJjS0YvZDJ5Qi9sN0N3SE9BcGZwVkFQVlM3bTB5OE52UTZvZFhKazRST1ht?=
 =?utf-8?B?RHROTG1rSkg3NFZpYk1XVncvRHNwb05jMVVUSitSNUlObFVDMUNwd0dWMGxC?=
 =?utf-8?B?NmtHMkRsRWVPbzRIS0dkTzIyQ1F1TG5QWUhPWjJkN2I0MDVidFB5akNRU3VF?=
 =?utf-8?B?OVNvZFRaRW5nOWNnWFR6QjhtWXlwNUYxUDExaldQcWRSYTl3YTlyNXlITXlw?=
 =?utf-8?B?YUZsdUN0NktHNmY4TVpldWVtcTQwRUYyUHR0V2dkSFFxVTVkbmlyaXVLQ1Fy?=
 =?utf-8?B?a0taek5ycEZxSHJIYnF3VzdoUWpweXZFVC9IdGVUVEIrR0ZBUXFDSUZ3Vnpk?=
 =?utf-8?B?YzEzbUFTbFlkQnoxZHpNOW1FazVBcFp3SStCTEhMS1AxcklqUjU5NUkxTm9a?=
 =?utf-8?B?b1RxZjN4cnpUV0FWaFpuMGttbzlvMFluZStVV1VnZHM3cGRkZklrR2laY0xW?=
 =?utf-8?B?eHFSRWNIMmRIUHkrR3VERUkrRU5sZDFpRm1TS2U2VU5ueGNCR0RKUVh5eWYv?=
 =?utf-8?B?ZFA1S0haemtGMWsrNmVialcwWFdTRjZ5QWdhYVNDY0p0Y01ueTYvNVBDUkEw?=
 =?utf-8?B?MGdTbldKMWdIYThaZ2dnNk1SbGVTNURJenJHdFdZcmxTanJnd1VoOC96Nmla?=
 =?utf-8?B?aEc0eXdGcUFRYVhLT2FPZklCZXFZdlU5OEExL3N4cWdqUUJ6ZXBuaWRtT3pr?=
 =?utf-8?B?ekgxVkp2TzhidDR1UnkrYi9tOEoxOEI4K1p4T1dyT0VsdGFuZUdVZUZSMkdw?=
 =?utf-8?B?SkptM0dveDF2Z2Q2MUpTY0FmTkp3NFRhY0o2U2xEWEo4MStyUE94QTVoOUl5?=
 =?utf-8?B?cVhKYWZCZnN5MEorU2hkcmxjUGkwWGVWU0xzOTYwYnZaRUVVSDVrelBhL3U5?=
 =?utf-8?B?T2c9PQ==?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <968BA013EA7B8742B3482BDCD621ED5A@namprd11.prod.outlook.com>
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
X-MS-Exchange-CrossTenant-Network-Message-Id: be2f2144-580e-4294-033b-08de259c2c32
X-MS-Exchange-CrossTenant-originalarrivaltime: 17 Nov 2025 05:43:01.9364
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3f4057f3-b418-4d4e-ba84-d55b4e897d88
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: rRMXY+t4WOgRG3Kgn55uj5TXoRDUAst2P7qUY35FhRltolYm3/L740C6UseZDY83ONLHf595iTPg/F+toLSVd4694U2trOXWdzKNKgbXPZyT1D6gj2rQd495whVaWTfn
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS4PPFA2144AAC3

SGkgQW5kcmV3LA0KDQpPbiAxNC8xMS8yNSA4OjAyIHBtLCBBbmRyZXcgTHVubiB3cm90ZToNCj4g
RVhURVJOQUwgRU1BSUw6IERvIG5vdCBjbGljayBsaW5rcyBvciBvcGVuIGF0dGFjaG1lbnRzIHVu
bGVzcyB5b3Uga25vdyB0aGUgY29udGVudCBpcyBzYWZlDQo+IA0KPj4gSWYgSSB1bmRlcnN0YW5k
IGNvcnJlY3RseSwgZG8geW91IG1lYW4gdG8gc3RvcmUgdGhlIGNhcGFiaWxpdHkgZGV0YWlscw0K
Pj4gaW4gdGhlIHBoeWRldiBzdHJ1Y3R1cmUgd2hlbiBnZW5waHlfYzQ1X29hdGMxNF9nZXRfc3Fp
X21heCgpIGlzIGNhbGxlZCwNCj4+IGFuZCB0aGVuIHVzZSB0aGVtIGluIHRoZSBnZW5waHlfYzQ1
X29hdGMxNF9nZXRfc3FpKCkgZnVuY3Rpb24/DQo+Pg0KPj4gSW4gdGhhdCBjYXNlLCBJIG1heSBu
ZWVkIHRvIGludHJvZHVjZSBuZXcgcGFyYW1ldGVycyBpbiB0aGUgcGh5ZGV2DQo+PiBzdHJ1Y3R1
cmUuIERvIHlvdSB0aGluayBpbnRyb2R1Y2luZyBuZXcgcGFyYW1ldGVycyBpbiB0aGUgcGh5ZGV2
DQo+PiBzdHJ1Y3R1cmUgaXMgc3RpbGwgbmVjZXNzYXJ5IGZvciB0aGlzPw0KPiANCj4gSSdtIG5v
dCBzdXJlIGl0IGlzIHdvcnRoIGl0LiBEbyB3ZSBleHBlY3QgYW4gU05NUCBhZ2VudCBwb2xsaW5n
IHRoZQ0KPiBTUUkgdmFsdWUgb25jZSBwZXIgc2Vjb25kPyBPbmNlIHBlciBtaW51dGU/IE9uZSBl
eHRyYSByZWFkIHBlciBtaW51dGUNCj4gY29zdHMgbm90aGluZy4gSWYgaXQgd2FzIGhhcHBlbmlu
ZyBtb3JlIGZyZXF1ZW50bHksIHRoZW4gaXQgbWlnaHQgYmUNCj4gd29ydGggY2FjaGluZyB0aGUg
Y2FwYWJpbGl0aWVzLg0KPiANCj4gSG93IGRvIHlvdSBzZWUgdGhpcyBiZWluZyB1c2VkPw0KDQpH
b29kIHBvaW50IOKAlCB0aGFua3MgZm9yIHBvaW50aW5nIGl0IG91dC4NCg0KQ3VycmVudGx5LCBl
dGh0b29sIHJlYWRzIHRoZSBTUUkgdmFsdWUgYW5kIGRpc3BsYXlzIGl0IGFzIHBhcnQgb2YgdGhl
IA0Kc3RhdGlzdGljcy4gSXQgbG9va3MgbGlrZSB0aGUgY3VycmVudCBTTk1QIGFnZW50IGltcGxl
bWVudGF0aW9uIGlzbuKAmXQgDQpwb2xsaW5nIHRoZSBTUUkgdmFsdWUuIEhvd2V2ZXIsIGl0IGlz
IHBvc3NpYmxlIHRoYXQgc29tZSB2ZW5kb3JzIG1heSANCmltcGxlbWVudCB0aGlzIGluIHRoZWly
IG5ldHdvcmtzLCBpbiB3aGljaCBjYXNlIHdlIG1pZ2h0IHJ1biBpbnRvIHRoZSANCmlzc3VlIG9m
IHJlYWRpbmcgU1FJIGNhcGFiaWxpdGllcyBtdWx0aXBsZSB0aW1lcy4NCg0KVG8gYmUgb24gdGhl
IHNhZmUgc2lkZSwgYW5kIHBlciB5b3VyIHN1Z2dlc3Rpb24sIEkgd2lsbCBjYWNoZS9zdG9yZSB0
aGUgDQpTUUkgY2FwYWJpbGl0eSBkZXRhaWxzIGluIHRoZSBQSFkgZGV2aWNlIHN0cnVjdHVyZSBp
biB0aGUgbmV4dCB2ZXJzaW9uLg0KDQpCZXN0IHJlZ2FyZHMsDQpQYXJ0aGliYW4gVg0KPiANCj4g
ICAgICAgICAgQW5kcmV3DQoNCg==

