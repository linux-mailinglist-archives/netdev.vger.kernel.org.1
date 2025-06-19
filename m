Return-Path: <netdev+bounces-199410-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id F107DAE02CD
	for <lists+netdev@lfdr.de>; Thu, 19 Jun 2025 12:39:19 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 46443189F239
	for <lists+netdev@lfdr.de>; Thu, 19 Jun 2025 10:39:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C95DF22256F;
	Thu, 19 Jun 2025 10:39:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=microchip.com header.i=@microchip.com header.b="f1wnbFYm"
X-Original-To: netdev@vger.kernel.org
Received: from NAM02-DM3-obe.outbound.protection.outlook.com (mail-dm3nam02on2043.outbound.protection.outlook.com [40.107.95.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1FF9E178372
	for <netdev@vger.kernel.org>; Thu, 19 Jun 2025 10:39:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.95.43
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750329555; cv=fail; b=dFxAxzhyYNONcDkWVs35FEjVhJ7HA1leesBejKbQ7Y8nqJ3AMxddnyYhcpNb2YMDVWj7Dlg8Pvdu35GWF09Fym58vIb+AQA7G6xTyxX9eXzrRT8mUJqdX2XpH3rxCPVr3HkSywwg7LdxVgPafJpKiNMRM1Qa7V29E8li1YPQ7EY=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750329555; c=relaxed/simple;
	bh=ceyA4sjX+R7ZkjjoC3vXKP+9+7RGDooLfpQa3cmyl+8=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=NM/Z15T/q87pmeDk2kg/sBTOuRV//S+BFAuuo5TAPAk6bSsBa4ciJ+uLmzuF105Z1AqTJKpT4v+7XRDZxbqxHpJB/5lXa5kCS7mXiUNtB7nYah3JjdC8TcbEYAl98WJQPNCj6bS87nPDb+ePLeL39iu/TfdM/oyroOkTlR4+hbU=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=microchip.com; spf=pass smtp.mailfrom=microchip.com; dkim=pass (2048-bit key) header.d=microchip.com header.i=@microchip.com header.b=f1wnbFYm; arc=fail smtp.client-ip=40.107.95.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=microchip.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=microchip.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=mm4PK4J6laUAUGjVGsJ/VcGF/kM/JVATRf4nMjIvyCKtDAi1mFT35lEJyVeswhw7Nju5FyJVCEAmRPQ/4JNBdMvoXxnyafogkcyHJsHHagXAit/P2S6CK5HkFcbtScSkgzQV52aTz9gWHx9Gx5qXoCe98feE2+9JkgHvJ+ISFnL8g0xGXoOcjymDILIrmfFmP5slGqwnzHK9dDeL7yCCw/DtaRwfs1+PZRX+2jajGaG8joKyVd4SaH076wJg5lFAbrPpsESFEmwtSqtq+0i/goGHFUnTwoljU1HeyFqlGU6AXMS+MAJ4Tz2cSoWthBaKbqYGnH/lWY9Jph/zNRNR2w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ceyA4sjX+R7ZkjjoC3vXKP+9+7RGDooLfpQa3cmyl+8=;
 b=OQ7zwAHpzPyrKMVSmHMzC0bML4DHShCVwOcFmbTfdr9wTgymI1mI3Ulgru50evvHizGIL/sCi9dcXANJChERPkOgs/3hszk2TsA9KcWPvvmNUPhQBUDt0sPs779+tDPY0H84g6ZVo4z9nKR+Q4tpZFLrRdCr3AOQH50pRhykDumMmAkyKUorBpA+aFcvaSoc9PV9TJTTTu1ZQEZAYvDuTuKeZ+9ltJgNM9yqSNgl2yM6H6Bnb76fEn+YlNLdTOKbPjA+EPEz4PDgKPFRt48T45kmASOJkpZBY2LH27/naTzo/GEMQX1XCiCnjwU2h9C3wXcudzPh5yu/8uvIMQg9Mw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=microchip.com; dmarc=pass action=none
 header.from=microchip.com; dkim=pass header.d=microchip.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=microchip.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ceyA4sjX+R7ZkjjoC3vXKP+9+7RGDooLfpQa3cmyl+8=;
 b=f1wnbFYmalhyFqrLP/9xLdpV5rmEQs9quDGxi/kfjW3kncUQqJ5Y6GDqUlfX2r1wjKTw4OV3ExjNFwjivoeCB7ENCJvXPHEAqmBmUxAkqzP6dUvHnCvtmEPTijINo/mQkc/LZXyhcKW5j8gHihUQ2GiF8I5lh8NmTzsHOdt5zomkvGJw9NILkdsHR+sTpWXIlEOeJ/JtpiIROYwwXA0ydCEZFdTIW5l++iLqEUL+zX5cG7YxQh10ge56cSIobkCiB28ELEKBZL+V7eU1dEP0p9kdVSoBRSE//Vk93oIdaFbvaOcmSXMRUZ2aFN/ji/Tds6UeZh40FXcyWUgr+fWMSA==
Received: from DS0PR11MB7481.namprd11.prod.outlook.com (2603:10b6:8:14b::16)
 by SA2PR11MB5001.namprd11.prod.outlook.com (2603:10b6:806:118::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8835.29; Thu, 19 Jun
 2025 10:39:11 +0000
Received: from DS0PR11MB7481.namprd11.prod.outlook.com
 ([fe80::1737:4879:9c9c:6d5f]) by DS0PR11MB7481.namprd11.prod.outlook.com
 ([fe80::1737:4879:9c9c:6d5f%6]) with mapi id 15.20.8835.032; Thu, 19 Jun 2025
 10:39:11 +0000
From: <Rengarajan.S@microchip.com>
To: <aleksei.kodanev@bell-sw.com>, <netdev@vger.kernel.org>
CC: <andrew+netdev@lunn.ch>, <Bryan.Whitehead@microchip.com>,
	<davem@davemloft.net>, <Raju.Lakkaraju@microchip.com>, <pabeni@redhat.com>,
	<kuba@kernel.org>, <edumazet@google.com>, <UNGLinuxDriver@microchip.com>,
	<richardcochran@gmail.com>
Subject: Re: [PATCH net-next v2] net: lan743x: fix potential out-of-bounds
 write in lan743x_ptp_io_event_clock_get()
Thread-Topic: [PATCH net-next v2] net: lan743x: fix potential out-of-bounds
 write in lan743x_ptp_io_event_clock_get()
Thread-Index: AQHb3rMyYgI6dXHKSU+AARYFNcNdnrQKTl6A
Date: Thu, 19 Jun 2025 10:39:11 +0000
Message-ID: <d44ccb0adff01e9d36370b705dbc0b0a4fbc4ed3.camel@microchip.com>
References: <20250616113743.36284-1-aleksei.kodanev@bell-sw.com>
In-Reply-To: <20250616113743.36284-1-aleksei.kodanev@bell-sw.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=microchip.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: DS0PR11MB7481:EE_|SA2PR11MB5001:EE_
x-ms-office365-filtering-correlation-id: 4adf3e89-25e7-405a-5145-08ddaf1d8726
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230040|1800799024|366016|376014|38070700018;
x-microsoft-antispam-message-info:
 =?utf-8?B?NzJGNjlSRmxsYkR3cXM5SXN3bGdzV3IwTTVvci9SVGdhaVdCTTFOZkFlRnZV?=
 =?utf-8?B?SWpOamRReXBkcFMrQnZpWmhRWlNuWkplTEpkR3NxN0hZNWZuQUFoQThML2R6?=
 =?utf-8?B?ekwrc05KcGlYcTBVd0MyVXdWeWdweVl0LzFNTXRQQ2ZKdjFXMUpiejNEdHAr?=
 =?utf-8?B?ZmxNVnk2R0F5bmphNkRGQVhUUHNMdmMrV2dVWGZwVG5nM1htT1l5dnhNb25n?=
 =?utf-8?B?VkpjWE9aVzdqam13YVVIcW8xNzNXUCtmcnA2bWpoOFU3TkZvbDF5K0RsRFFI?=
 =?utf-8?B?VE9KajZ2cXN6SlNINWZKVVhjbXdkclRWZjRvbnljNEJKckRVVFBMNE56ello?=
 =?utf-8?B?TG8rdU9oQjcrTUx0M1FOSmRlaXhvTGZZUXJlVnozLy9hNlB5MVBPcGZ4T2Vl?=
 =?utf-8?B?WFo2OUdvRkVlSSswUDZjeHFMbDgvWk5pTzNPTXpFSkhQQWNVQmR4YU13N0ZB?=
 =?utf-8?B?THp1eXFTTU1yQTlSQ2kzSjh6RkZzOFE0ZVlaNlh4U0ZzdzlpUVVEd1B3akNa?=
 =?utf-8?B?ZGFkVm9BcHBocGo3ME8zL2hGbHZKOWRTQmpkakkvSkN1b2pXUm9YUlNINkZH?=
 =?utf-8?B?ZzRsaTNQSWdnTDdlSW9uY0FFMTBIb0JGTWtXZ25lbWdFVnJWd3ZYTXloT3pU?=
 =?utf-8?B?aUR4YjBLRmhIWlhNQjJvdkdEWnpXWmlUTzFVdy8xRHcvdFZLZzhNeHhhckxl?=
 =?utf-8?B?ajdQbEVHT1I1Y2NwOSsvOS9Gaml1M0cyM1g2dFRwTFFac1NiRmZTaHRKeVhV?=
 =?utf-8?B?ZmgxdEhicVFjRFVlRUlaNFRkVVBlOFdzaFhmS1NkYldLejYyWVNQY3RkbnVn?=
 =?utf-8?B?Mk43dVRuSEw2M3NENk9MYjZ4RVl4UWlFYlY0Qmt1ZVgvTTVWcXBjdmhuM2pB?=
 =?utf-8?B?V0VHR2c5enNJN1JWNUozRUVNdjJjVHdKOXNjanhhaHFkMXpIZGM0OHVVb0dx?=
 =?utf-8?B?cUloZTh5UDNxTmZkSzZON2IxQy94S0xPaWszaXRVaWFjODhZR3hibmpWSmJr?=
 =?utf-8?B?a3E3eDczamc3OTdkZ1M2VjFZeFB3QTNKY0NMdnVwNWtnYWY2Rzl6M3A2aDAv?=
 =?utf-8?B?MVlyZDRNYjFvNE5CUXBJWStiSVljNDRRL1BRTExLdFBDYlNKbU1nc3p0R3Vt?=
 =?utf-8?B?c1RLYVhQV3YxdjZodjhoTlp3cE5EakJYcy9QaHVINGNCSEJieDFTODFQY0Zy?=
 =?utf-8?B?ZjlJNytxeThUcVkxU3cxNlZMSmRPU1RTY1doUDkxYndSSW1tMm94KzZabllp?=
 =?utf-8?B?Tk5XTDBHK01sVHFuaVFWL016Nmp2SmtxQmZwMDEyajA4QUowODJtVS9BdTFh?=
 =?utf-8?B?Nm9LWUhFR0pUNStzSGlWSUQwQUU1R3JIUk0rSng1cE4yV1NIZ1YrWFlnRGNJ?=
 =?utf-8?B?cGdIL3VtUDQ5TUFReTZXK1J2d0hMRFJublF0UFhaOWxTdDk3bFpKalBGajJR?=
 =?utf-8?B?MGpyUEZKWWg0QkRvSlA4VzkxSDNTOUxXcUgvNWJvaGUvTGNLbTZCdWNDMWpo?=
 =?utf-8?B?cU95RHV3U01URG0wbG91eXpqSDd3dmUwd2FYcEtKMUJRUVpYcyt3ZkdLSkVm?=
 =?utf-8?B?c2lrNEZwWWRTL2lHb05mUHVtVCtaNENtK0xudVRCbXRqRHkwL2lvNkFnb3Bl?=
 =?utf-8?B?U2RZMDI3Y1o2b1ltZ3hRTzdYaWovbUhuYzlseE4rUll0K1ZKaEVVMTdyaEEw?=
 =?utf-8?B?NUxZRkxXeGxRc0ZsWlFVemtnaUV1MjYwZU9JM0Q2Ly8wR2dFWEdXdlpJaWVV?=
 =?utf-8?B?TEJDYU51WTVmRE9MK3p0MDJaQlRNVEdEc04rTUc3NFJvV2tQOEdOZkFJYXB0?=
 =?utf-8?B?bEF3Uk1ZS21DOEVHcVZDa1dYWlMxVjNESDJRNk90aVU0akc4TDg3K1hQZVJG?=
 =?utf-8?B?RmZGVVV1Y2hINW1na2JOMmlvcTBKKzV5SGpsV3VtdTZrcGNLNGxiQVRaT1dF?=
 =?utf-8?B?YldCUDQ5RnFvZnF2VWJZM2dqMzZuZWh0b2drV2dNR2M3eThqWlJQSlhPdkRZ?=
 =?utf-8?Q?kRDwRyritBbc1AqsBLxkMeaKn0PFC8=3D?=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DS0PR11MB7481.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(376014)(38070700018);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?utf-8?B?ZzlaUExTOEoveTc3Ujh0bDRSTWNKQ3czR0RaZ2hRVWVvSysyM3VWOEMzeFJv?=
 =?utf-8?B?dmFqcVpOU28wcW1weHFaRWcvekQrRWUramhXTXNjZ21FWnI2aWEzVFN2LzZO?=
 =?utf-8?B?R01MVnNHbFQ1Tkc3QW1mTGJxRVo0SXFUWktJTXVEbThJTHRMMjBsSFVyNGRn?=
 =?utf-8?B?eHBxVjUzZW9BbWt3eTRPemR5OG1QOVZOeGxwMzNLM3BVWitMREhuN0FVZ29E?=
 =?utf-8?B?d2tqUlVWR1VYY1NJVmdhanpkUVBoWG53N0RBZzFJS0kvRG1vOEF6ZmovajFy?=
 =?utf-8?B?cWI4UlhBQ1dIVEhMajNiTUhrZ3Z3N00xQ2RWODJIaVdzdkVHYUFsM1U0eDRn?=
 =?utf-8?B?eGtJVnJ4Z1VrK3pxelJxT3NHWUNPSWxERkFQdG5tUkxkSkJlUW9VQ2x6WHlJ?=
 =?utf-8?B?UmdjVnZsUjluZnltQkJ5cUNNaHNHZlBUZXZORFpQK3N4dytjeDA0UVlWMk1K?=
 =?utf-8?B?b09nSEUxUTYveHM3WTk3UkZJemlNVzRRME5KaFkrZU1GL2ZhQTk0R2I2dnQv?=
 =?utf-8?B?M3duc0N6WHh5UFdYRUUyRFRBaXJtd0RhUGFlOXFEcnppaGVZMmg1WkZJQlpK?=
 =?utf-8?B?aE9tVjhaVlNxNk1GQWpiMUFPcEVISHE1a2szZjk0RmdycW5QaGZuQXRXbU0x?=
 =?utf-8?B?UHRMMU9xWnlTRzB0bjRWRVNKUFNwcUdJdlFNV2JSR2FJdUFtTlZaSGdJVWNG?=
 =?utf-8?B?ZlhSeklOeXByT1VSSWFqL1Njak9JMmRDQlNzNWVRVUlOa2U5ZVF4d1F5OGNV?=
 =?utf-8?B?bWpFaVVSbHAwL2sxZFdxTXNXWnRuZjdVRnN2TFdXanZucXBaVTBDRGEwQnhl?=
 =?utf-8?B?WjJnQml4UU52L0hjcWtORVkyTE1tQjFjZ0xaWTk5UVA3MWZBMkd4QjJEYWNS?=
 =?utf-8?B?ZVo5M3hXdkhHQVgzNGpjbCsraDhpbEFnUkc3N0ZieVJ0eWRWZ0dmV3FuRmFk?=
 =?utf-8?B?Z0Rvck12OXczak1tdENscGJKTXB1OVVEaVFBcUhYakw2ZmZ4Y09GYWFRU2Zh?=
 =?utf-8?B?K3VJZys2YmFxU0ZSTHlua0gxNEZwK1BTOFJrVGhOZk1lcWNaRitkL0NqWkRq?=
 =?utf-8?B?RGlDRFd2TzA1ejNuRXE1bGZuS2N3dVE4UElXS0ZHamVyeUJqTFU1anJwYnlx?=
 =?utf-8?B?N2lXNWpRTzFqWGVCVzB0NUFBOWtJN1RZZVBQSFd6czV4UldzUy9IVmhBKzYr?=
 =?utf-8?B?QlM2QVRBNjJnNUFXQWtXWlQ4NWhJZG5Oa0FHR09NOEk5ekwrc0J0dDJOWFhN?=
 =?utf-8?B?T0NyekxiK2tnOTdNQUZnZGY2VWZKUlBrZ29wSjNQUlJORDFCRDRSVXpkWW1W?=
 =?utf-8?B?TFBORVdGejBSamVxNitydUpGZ3pjTUI5eldLOVZLQldvQWdFZHpsSk5zVGwx?=
 =?utf-8?B?eitRSGRDRjczZmJaTnpPTmNHMWdadXoydEMyQXhjYWI0eEFtcjczMmlmZFBm?=
 =?utf-8?B?ZnU1YmExeGxDenhjUUtSTTcwQnN5R1hiMVYyOVMxME5PcWZHaUluWC9kaXNB?=
 =?utf-8?B?VTBxRU9oa0NkWENmeTFOcmw0Skpldk44MGtVcWRrMDdQMVIrWUMxZnEyckxi?=
 =?utf-8?B?Wm9sWUNUU2VSVUIycncwaEJ5bXlnUEZleVQ0Tm40YWtic3BtT3l0NWVUdm1K?=
 =?utf-8?B?L1h6bm9PdWprb2k5bEZINmF3UUFabUs2T2QvZnIxUldWQXJ4Z2JpZWFiZmxt?=
 =?utf-8?B?YUdoWWRreW83aW0vYTVITDBBU05nMFpiVG1ndFptcG9kU0ZGU3hVSHoydG9E?=
 =?utf-8?B?clNEVWliL05xQlBzZWVEY1FiUDF0ZFdKS2tjUnJSVmxqKzRDMlJsWEtCWFFW?=
 =?utf-8?B?dm9nVzNRVCtCTU16dE4rSWV4YWlsc1RsL3Y2V2JDWWl3d0F1VFIybmwxbVRl?=
 =?utf-8?B?Rkp3aUFHVUlqYW8vTUI1aXhiT1UvbFF4YSt0NHJ1WDBhNTVqcGoxR05xRmVT?=
 =?utf-8?B?TGpwbEdjeXBOaklTdFlkR0lpSjBXRDZyWGkweU51UWlZRXcrWFhoSXV4Mkl6?=
 =?utf-8?B?Z3RJOEx4TzhUUGltK0hFMklrSmZlbE91UVhzVFZNUXJ4WCtoQVZjVkhTeHhB?=
 =?utf-8?B?VVJJNnhYSE1wbVpOcU5QMEZHV0lGc3JRTFM0RWNxMDFCWXdvbmp1VnQzVGtG?=
 =?utf-8?B?eHQrbFhoN1NDOFNvY0s1MlZudEY3RkxXMUFTaE1aU3E5aEtXNDNFM1I1OTJ1?=
 =?utf-8?B?U2c9PQ==?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <2481AD7496CF51428048354D1F10FB7B@namprd11.prod.outlook.com>
Content-Transfer-Encoding: base64
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-OriginatorOrg: microchip.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: DS0PR11MB7481.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 4adf3e89-25e7-405a-5145-08ddaf1d8726
X-MS-Exchange-CrossTenant-originalarrivaltime: 19 Jun 2025 10:39:11.1872
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3f4057f3-b418-4d4e-ba84-d55b4e897d88
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: z+HNTsBuwVp+Hf+CZXgdJ8SU4PlI91ADd8uLxQbO7iRVsuFOth5BeoYwABEkpIY7ML4dA1N2jlqTApFp2T5e7LjNEqQMaBVgQ080jbyU31s=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA2PR11MB5001

SGkgQWxleGV5LA0KDQpPbiBNb24sIDIwMjUtMDYtMTYgYXQgMTE6MzcgKzAwMDAsIEFsZXhleSBL
b2RhbmV2IHdyb3RlOg0KPiBFWFRFUk5BTCBFTUFJTDogRG8gbm90IGNsaWNrIGxpbmtzIG9yIG9w
ZW4gYXR0YWNobWVudHMgdW5sZXNzIHlvdQ0KPiBrbm93IHRoZSBjb250ZW50IGlzIHNhZmUNCj4g
DQo+IEJlZm9yZSBjYWxsaW5nIGxhbjc0M3hfcHRwX2lvX2V2ZW50X2Nsb2NrX2dldCgpLCB0aGUg
J2NoYW5uZWwnIHZhbHVlDQo+IGlzIGNoZWNrZWQgYWdhaW5zdCB0aGUgbWF4aW11bSB2YWx1ZSBv
Zg0KPiBQQ0kxMVgxWF9QVFBfSU9fTUFYX0NIQU5ORUxTKDgpLg0KPiBUaGlzIHNlZW1zIGNvcnJl
Y3QgYW5kIGFsaWducyB3aXRoIHRoZSBQVFAgaW50ZXJydXB0IHN0YXR1cyByZWdpc3Rlcg0KPiAo
UFRQX0lOVF9TVFMpIHNwZWNpZmljYXRpb25zLg0KPiANCj4gSG93ZXZlciwgbGFuNzQzeF9wdHBf
aW9fZXZlbnRfY2xvY2tfZ2V0KCkgd3JpdGVzIHRvIHB0cC0+ZXh0dHNbXSB3aXRoDQo+IG9ubHkg
TEFONzQzWF9QVFBfTl9FWFRUUyg0KSBlbGVtZW50cywgdXNpbmcgY2hhbm5lbCBhcyBhbiBpbmRl
eDoNCj4gDQo+ICAgICBsYW43NDN4X3B0cF9pb19ldmVudF9jbG9ja19nZXQoLi4uLCB1OCBjaGFu
bmVsLC4uLikNCj4gICAgIHsNCj4gICAgICAgICAuLi4NCj4gICAgICAgICAvKiBVcGRhdGUgTG9j
YWwgdGltZXN0YW1wICovDQo+ICAgICAgICAgZXh0dHMgPSAmcHRwLT5leHR0c1tjaGFubmVsXTsN
Cj4gICAgICAgICBleHR0cy0+dHMudHZfc2VjID0gc2VjOw0KPiAgICAgICAgIC4uLg0KPiAgICAg
fQ0KPiANCj4gVG8gYXZvaWQgYW4gb3V0LW9mLWJvdW5kcyB3cml0ZSBhbmQgdXRpbGl6ZSBhbGwg
dGhlIHN1cHBvcnRlZCBHUElPDQo+IGlucHV0cywgc2V0IExBTjc0M1hfUFRQX05fRVhUVFMgdG8g
OC4NCj4gDQo+IERldGVjdGVkIHVzaW5nIHRoZSBzdGF0aWMgYW5hbHlzaXMgdG9vbCAtIFN2YWNl
Lg0KPiBGaXhlczogNjA5NDJjMzk3YWY2ICgibmV0OiBsYW43NDN4OiBBZGQgc3VwcG9ydCBmb3Ig
UFRQLUlPIEV2ZW50DQo+IElucHV0IEV4dGVybmFsIFRpbWVzdGFtcCAoZXh0dHMpIikNCj4gU2ln
bmVkLW9mZi1ieTogQWxleGV5IEtvZGFuZXYgPGFsZWtzZWkua29kYW5ldkBiZWxsLXN3LmNvbT4N
Cj4gLS0tDQo+IA0KPiB2MjogSW5jcmVhc2UgTEFONzQzWF9QVFBfTl9FWFRUUyB0byA4DQo+IA0K
PiAgZHJpdmVycy9uZXQvZXRoZXJuZXQvbWljcm9jaGlwL2xhbjc0M3hfcHRwLmggfCA0ICsrLS0N
Cj4gIDEgZmlsZSBjaGFuZ2VkLCAyIGluc2VydGlvbnMoKyksIDIgZGVsZXRpb25zKC0pDQo+IA0K
PiBkaWZmIC0tZ2l0IGEvZHJpdmVycy9uZXQvZXRoZXJuZXQvbWljcm9jaGlwL2xhbjc0M3hfcHRw
LmgNCj4gYi9kcml2ZXJzL25ldC9ldGhlcm5ldC9taWNyb2NoaXAvbGFuNzQzeF9wdHAuaA0KPiBp
bmRleCBlOGQwNzNiZmEyY2EuLmYzM2RjODNjNTcwMCAxMDA2NDQNCj4gLS0tIGEvZHJpdmVycy9u
ZXQvZXRoZXJuZXQvbWljcm9jaGlwL2xhbjc0M3hfcHRwLmgNCj4gKysrIGIvZHJpdmVycy9uZXQv
ZXRoZXJuZXQvbWljcm9jaGlwL2xhbjc0M3hfcHRwLmgNCj4gQEAgLTE4LDkgKzE4LDkgQEANCj4g
ICAqLw0KPiAgI2RlZmluZSBMQU43NDNYX1BUUF9OX0VWRU5UX0NIQU4gICAgICAgMg0KPiAgI2Rl
ZmluZSBMQU43NDNYX1BUUF9OX1BFUk9VVCAgICAgICAgICAgTEFONzQzWF9QVFBfTl9FVkVOVF9D
SEFODQo+IC0jZGVmaW5lIExBTjc0M1hfUFRQX05fRVhUVFMgICAgICAgICAgICA0DQo+IC0jZGVm
aW5lIExBTjc0M1hfUFRQX05fUFBTICAgICAgICAgICAgICAwDQo+ICAjZGVmaW5lIFBDSTExWDFY
X1BUUF9JT19NQVhfQ0hBTk5FTFMgICA4DQo+ICsjZGVmaW5lIExBTjc0M1hfUFRQX05fRVhUVFMg
ICAgICAgICAgICBQQ0kxMVgxWF9QVFBfSU9fTUFYX0NIQU5ORUxTDQo+ICsjZGVmaW5lIExBTjc0
M1hfUFRQX05fUFBTICAgICAgICAgICAgICAwDQo+ICAjZGVmaW5lIFBUUF9DTURfQ1RMX1RJTUVP
VVRfQ05UICAgICAgICAgICAgICAgIDUwDQoNClRoYW5rcyBmb3IgdGhlIHVwZGF0ZS4gQ2hhbmdp
bmcgdGhlIExBTjc0M1hfUFRQX05fRVhUVFMgZnJvbSA0IHRvIDgNCmxvb2tzIHZhbGlkIGhlcmUu
DQoNCj4gDQo+ICBzdHJ1Y3QgbGFuNzQzeF9hZGFwdGVyOw0KPiAtLQ0KPiAyLjI1LjENCj4gDQoN
CkFja2VkLWJ5OiBSZW5nYXJhamFuIFMgPHJlbmdhcmFqYW4uc0BtaWNyb2NoaXAuY29tPg0K

