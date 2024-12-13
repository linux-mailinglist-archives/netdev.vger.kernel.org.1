Return-Path: <netdev+bounces-151689-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 5BDC19F0997
	for <lists+netdev@lfdr.de>; Fri, 13 Dec 2024 11:35:13 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 17CE528139E
	for <lists+netdev@lfdr.de>; Fri, 13 Dec 2024 10:35:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F1D921BB6BA;
	Fri, 13 Dec 2024 10:35:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=microchip.com header.i=@microchip.com header.b="B1mTM7zp"
X-Original-To: netdev@vger.kernel.org
Received: from NAM11-DM6-obe.outbound.protection.outlook.com (mail-dm6nam11on2043.outbound.protection.outlook.com [40.107.223.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5D3AC1B21AB;
	Fri, 13 Dec 2024 10:35:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.223.43
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734086109; cv=fail; b=j6/KFZ/Wae0rANTABYyTS+VEaWNBgxJb4hDjolrLvrQVs6+WTf5mfDWIQUw3FYiOYpjioqrRHQmMfDAjk2TyK50c0n+jfPgVMGHh8pwLAi3e3agzkyc2wVsE4desZPqoNU3AFE2EhiFD+6n422ZVMOgoU8j2Be1xGbURdODDOrI=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734086109; c=relaxed/simple;
	bh=5FZDCP8V3dp/cy56nDZXTaQ3fvwL99P02zOCDf20es0=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=NxQWRk/Xf9k0I1f0bzn3h+GS4gTEpBgSOsRO7VSttl14mckdHDnwU1fWcTWm5fmmA587molrO3ZI6A6IPfY6J6vQjQetLFLNBvJIh9sktLeOK7jdakJrIAHE9LrT6Gx280W7Jq154wUd0fvNKJPW00ApvDtKkblmP6/vUMkPloU=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=microchip.com; spf=pass smtp.mailfrom=microchip.com; dkim=pass (2048-bit key) header.d=microchip.com header.i=@microchip.com header.b=B1mTM7zp; arc=fail smtp.client-ip=40.107.223.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=microchip.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=microchip.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=SXvTUgGGWqtmO4k5cevKZAqvc5AVlfF/dEgYCLb181/SG3ta8xYfp22kAFC5gN7hY3s1gfJSjACYeSg4Y1nSPpLFgWg8gKdVUs/8MMDWuoMiDCIvm1PLLD484T/scnjW8OVQvmDrjr0a3OpyJsKDyZkqki60KDuPvee8zzewy6/VbgECH9MbIXxpsDnLWftizjoT6SlrdtwspAHOvr5uUV3bvzkjpMwPUTaLP9VLRz3PMCwpmqs7WAKSj8jbj7E8ZU0ipOa1HcYQnnod99rL2vdEsavjwZC/E+5aJUP5YhOEKNVJhwyKj2smm/5liNwA2wJZFocI8/YXHgrAmTQtsQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=5FZDCP8V3dp/cy56nDZXTaQ3fvwL99P02zOCDf20es0=;
 b=k9P+vN+AXqykPYrnW5keEzpkKg/ju/PBG/8USndYKkUqC7i+3EuT5ra+QJYYFa4d9NuZN/JXrNHrPazmf3zAMR1HSgUQ6JLLYhMqMBRSj//rdDnvdZFi4rOhD0lBSEv/fhzrpLDX3D1JWH6DSQk7leC3pf5Ze27fB9hcgbBuV2prdEy4pvnjhJ3X6Xc+OigpQt3oM5h9JVsr6zfXDEGA97fSvOtezxM8hLvjdQ2IFXKZumMh3AELbrQT1hlWdOWG+2EuuONfhL93HXbzbux0WexWoMxLCBacmrJOJejhSyEX52dRvvwOFBtj3lZh4Htzu/F+KaxDgUQvXAtdjswgzg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=microchip.com; dmarc=pass action=none
 header.from=microchip.com; dkim=pass header.d=microchip.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=microchip.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=5FZDCP8V3dp/cy56nDZXTaQ3fvwL99P02zOCDf20es0=;
 b=B1mTM7zp0jyLcoozzOvoYcwr/2yZMaP2C3AoI3jbuJUoWbCOCnpreUq0RvrCLgLW942/lwU6/yMUngiEPEEQPOBr+mu1HVXektPMrlxji77VLhAzZZ/D7ATrQx2MjbeRICphZ9IDMkz4zRXtbSZE845nG7DtGThPoBJbf4UQrxOAVtWGDV0W+U1p/2EX/5i+MDihIQrkN2HPATvmQJ5q/KBNCYqEwpwIObvKNSLJpQR1OMiMfCN2SZQdX9sCE+hrvBSncknRHE7jXnu18UWm/NHG9JDoBCfTUgaIIzbI5FuRpNT7FnzRoJHth4NROdvNeEt4Y1mbV7K4YWQsOImq+A==
Received: from SA1PR11MB8278.namprd11.prod.outlook.com (2603:10b6:806:25b::19)
 by MW3PR11MB4634.namprd11.prod.outlook.com (2603:10b6:303:54::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8230.11; Fri, 13 Dec
 2024 10:35:03 +0000
Received: from SA1PR11MB8278.namprd11.prod.outlook.com
 ([fe80::84fa:e267:e389:fa9]) by SA1PR11MB8278.namprd11.prod.outlook.com
 ([fe80::84fa:e267:e389:fa9%3]) with mapi id 15.20.8251.015; Fri, 13 Dec 2024
 10:35:03 +0000
From: <Parthiban.Veerasooran@microchip.com>
To: <kuba@kernel.org>
CC: <andrew+netdev@lunn.ch>, <davem@davemloft.net>, <edumazet@google.com>,
	<pabeni@redhat.com>, <netdev@vger.kernel.org>,
	<linux-kernel@vger.kernel.org>, <UNGLinuxDriver@microchip.com>,
	<jacob.e.keller@intel.com>
Subject: Re: [PATCH net v3 2/2] net: ethernet: oa_tc6: fix tx skb race
 condition between reference pointers
Thread-Topic: [PATCH net v3 2/2] net: ethernet: oa_tc6: fix tx skb race
 condition between reference pointers
Thread-Index: AQHbRlFobveu+PlKfkaa7qgOKnJVrLLeo4gAgAP0CwCAAXEfAA==
Date: Fri, 13 Dec 2024 10:35:03 +0000
Message-ID: <b7a48bbf-d783-4636-8f75-35c9904ffe05@microchip.com>
References: <20241204133518.581207-1-parthiban.veerasooran@microchip.com>
 <20241204133518.581207-3-parthiban.veerasooran@microchip.com>
 <20241209161140.3b8b5c7b@kernel.org>
 <5670b4c0-9345-4b11-be7d-1c6426d8db86@microchip.com>
In-Reply-To: <5670b4c0-9345-4b11-be7d-1c6426d8db86@microchip.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
user-agent: Mozilla Thunderbird
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=microchip.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: SA1PR11MB8278:EE_|MW3PR11MB4634:EE_
x-ms-office365-filtering-correlation-id: 7a8abaad-1de9-4131-50f9-08dd1b61cda6
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SA1PR11MB8278.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(376014)(366016)(38070700018);DIR:OUT;SFP:1101;
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230040|1800799024|376014|366016|38070700018;
x-microsoft-antispam-message-info:
 =?utf-8?B?SXRobGdEdEl6TGNjaGdkM2kzeFpIdENORkkzS25LNDFRSE1BVE1hMCthZlJi?=
 =?utf-8?B?OWtNQ2phcURraWlsS0xrYmFCWVR4RVhaem1qOGhaeVNYeXJWMWNiTWo0SXJa?=
 =?utf-8?B?bExNa1JENm5zUnQ3ODRhRUhPVU1VNE9STWVpQkFHcWVSR2k4K1JTMko2UEpW?=
 =?utf-8?B?S3REYUYraGNMa2V6M2ZGK1VsUHQ5L2V4OG0wZlhUMkY3ejlhQ0VEUkgrSnlz?=
 =?utf-8?B?a1haU255a1BWNGVvWjRNVUVxdmx2a3hlYm5XTkIzVnR6V1h4MkxOV1pRdEdr?=
 =?utf-8?B?WnBWVUw5WkFqTUp0azF1cmNSNCt1cUN5VUR4bEVINnlEdlBEZHhBazQ4eWor?=
 =?utf-8?B?U2hlY28wODRxWis3eGF1bXFWS3pvcVhLWWVFdFJ2b0ZhQk10eElwRU1Db3Js?=
 =?utf-8?B?SWQ5dlpmZzNyTHc0N3o1ZVVOUW1OWnQrOThLbUl2NHdKM1dwQjAyNW13SVFB?=
 =?utf-8?B?MkNlUG5QQW4ydndCUDFEaHBWTFkveFdhN2w5MHlDbVRrM25EdmZxOFhZMUhG?=
 =?utf-8?B?WjVwb25IQXY3bzNSYkNUMUp6bFVDOWtZeElwQURoRWQ2S0ZpU0htajFRUVpp?=
 =?utf-8?B?MnppVmtJY3BUMzd3MExWSVZiNEllV293YXhGTmRjdnN0Mk41RzR4cmNsRisv?=
 =?utf-8?B?TGNkVjJKYlpCUEZEQnVyT0l6TjFHYzAxNlNlSmZQTDFVOWF5K1p5b1J2OUk1?=
 =?utf-8?B?Tm1QOEROeFo2bnpSY01ZYWNpSW5hckpTVERhbjlFTFpOQVAvSVh2STh0eGRk?=
 =?utf-8?B?d3FYRHhyZG03T2JUa3RVMGFKNGd0S2haTXR2MUNjUVUzUnRQUmxiVWllY3R2?=
 =?utf-8?B?WkVDRm9TYS9IcllVclF2L1J0N3lub0swYW4zOUkxdFZhaUl6bHNkeTFsbzEv?=
 =?utf-8?B?dTNLb0pnWE5wNDZkMXd3bU1QQVNTQUJWRDVYTzVKcGIrTWZjL0FmSXQ3a3BZ?=
 =?utf-8?B?QnloZlFTZzFSMzFYTHkvS1VsSEhURlIrWUlWczl3OTdjYnkvck80MS9qeSt6?=
 =?utf-8?B?UUdQekE5RUNoMDlUMUEwTHFEYXVDVVNNWEF4Y0JaNS8yMVg1dzQrd3dyTlA5?=
 =?utf-8?B?MUlHeExxd2RpcDZGUHlWSHN5RFJxdERob1RtZTBTYUNTT2Naelp0dmk1WHNh?=
 =?utf-8?B?ODN3eTJ4djhxQVZwbmpnaE5EUWdrRHVpNG9VbnFzbHBNYVRhOGJjSTN1OHpk?=
 =?utf-8?B?Sm5pWVlwQkRjMUk5TmFiN3NvWGtWZ3FUZHlvYVBqRXJCeUdCN3lvSHFLcldH?=
 =?utf-8?B?RG9rRElTd2tDaThRVGVHcmoyTkdGQ3ViTU5SdUU3ejJ5Y3NESEJiWGNSbWp2?=
 =?utf-8?B?RkQwY21KUTBZMC9IUncwL2V2c3I2bHVJei9kZmp3NHVYYytXc1dCQ3J0Zkw1?=
 =?utf-8?B?U2o1S1lGN3VGZ21WYnVMSXdZa24xN20rUm1XNGJiazRweTRURFVDSXE5L1pH?=
 =?utf-8?B?MVBRbU82RUF2MzYwdkhNalFNMGhmUU1sN0xISytUYUZtSkFLV3pzcmpHZXZK?=
 =?utf-8?B?QjFBL1dRM3FMMHRCOTZjOFJ6SUxBT0h0b2o5d3ZrTDl1Wmo0cENYL2JHM0J4?=
 =?utf-8?B?WXJ1bE9UYTc1WFlwcGFZbVFGWkY5OXFWQzYxNEg4S2NkbVNTK3pkUkVkYmRS?=
 =?utf-8?B?R09hYnlVL1I4d0RGaTVndU9iN2R1UFBtajhhTDE4eVcrKy9McUkzaVZ2bEc1?=
 =?utf-8?B?ZSs3clk0R1dRMlkvTXg5bld3Y2tuL2lwNHlXQ2NycHFnbUw2eDNzS1h0Q0NE?=
 =?utf-8?B?Q0hGRmM1VFhRSVROdUowc0JPd1FKeGJZV1ExRmpwQlhsN2s0ZjFwRG5mVUE4?=
 =?utf-8?B?WlY2czJ1UmpVNTI4Q21ZMXdidzJjTkM1UDJEeXMxc0lLbGVKT01adnFMemlC?=
 =?utf-8?B?Wm1mcGNsenVka0dHaXBOemlyY1ZLKzN4TThpRWI1SE5TTkE9PQ==?=
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?utf-8?B?QzBKQi92aDB2Q0VxdHpZOUVXMlV3by9WTjJmSENOcDd5ZndEUTFVMiswcHVJ?=
 =?utf-8?B?N0N6SGppaXZWWHZaTUVUR3lsZXA3RUV2bUlCcDZIdXhnSVhYeW9DK3VZM2hM?=
 =?utf-8?B?Mm9WV1hWKzVjL2F3ZGl5clRvRDd4dmdnem1KNktKME1qbFB0WGNLMkxhWEdL?=
 =?utf-8?B?U2ZHWVN1S1VMQXVhb052NnJmVys0TFZ2ZUZmQ0xFK1hQQjJsT2xQZTVXRFI4?=
 =?utf-8?B?cyswZEJFZmFPV2x5MDJhRHVoTHIrZjVNeFNWK25HOHVaSVJrMVhIU0V3Nkw3?=
 =?utf-8?B?eGhya3M3ak14cVdBY3pTQk93NkEveTY1MndML0hJd3c0NFRtbUgvdGZxeUJH?=
 =?utf-8?B?ZHRTUlFHa1RpMjhsL25XS2JvZENjalMrT1F6R1hnMlFSQzFnemV3M3dUWExW?=
 =?utf-8?B?allKd0N6bmtKKzUraTEvYUZXK3JES1psQk9JVGJFRHoxc2JWWkRVK3JuSGxH?=
 =?utf-8?B?aHNUNmpkRXZ6aXkvQXlySjhZNzhEWmsvL2JWTlJCaVM3eU80UCtscHVpMnBI?=
 =?utf-8?B?NXpjL1VXQm5YU2N5b3ROaGZKcS9FSWQ1QWZrN0FQejQ2a05lWHI1VTBSd1Nx?=
 =?utf-8?B?eFRzV1oxMWRCT09odFhYQjFXQWtzQkRBOHhxQ1l2V2tXTjFGUlRtZEt2Q05y?=
 =?utf-8?B?S1VhNTNHR01rcjBnOG96QmVja1BvbjBVckJJMjBmUnliR0NWNDViVnFXbDcx?=
 =?utf-8?B?Q25vamRYZks1dlZvK0J0dlRXWWlCa096QXpEemNUQTJ0UXJoYUx3TU9CMk9G?=
 =?utf-8?B?WTNQU3dlcUZVbDZIOGhZS1FTaHBwM3NESm5qZEpvZmZrUXAzZ3paNGxRTmRB?=
 =?utf-8?B?ZDJHVW12cnBQZFdTb2N6cDEyU2g4eUpQWmFpbUQ0c0QrYXM1TjRNK0UxbWxO?=
 =?utf-8?B?YzVLbkxXc0k4TGpoWW9YOUtpRTV1ZzVZcFJoUXlDWTdSLzRVdDdDbzlxUmhO?=
 =?utf-8?B?QWJqM1FLajFsRm5ITitobHA5aFZHL0Fsc3JRQTk3WWw5SWJuZjFhdkNQNGVH?=
 =?utf-8?B?S0VMTk1yTm1WYVRzbGJvb0NQeHVzNExlTExVWmx5endlRzR6b3dBTVV0MUhJ?=
 =?utf-8?B?bDc2UndEdE1hS3BqandOaDh5S1NqNVA4R1BkMkRxZklGMExqYnJXUkk0ZW5a?=
 =?utf-8?B?UDMwT2pPZjdsd0VqeUw4WnA4TGVGb2FHOHI1OWNJUmt0WjBqOEVVdWo1Slkv?=
 =?utf-8?B?OTV0QkNicXJCYU1hbk9CTGFzVmNkRDJHOHJ6MTNxdTZDdlZHTk0vejh4T0Na?=
 =?utf-8?B?WnpHQ0RYYnZaMlpZcGZBQS9iZFprbFdDZll6eFRwQldvOXFwd0F0RHR4M0w2?=
 =?utf-8?B?ZzVHcG5oS2V0L0cyS2dnRGJJaGw4emNUZ21ieVFNNWt0ZkpjWjMxTUV4bTdy?=
 =?utf-8?B?SGpOK1VKU0JNd2RLZUJYZDE5MG11WEM4NkIzdXVXN3FYM2wrNVhxaHdXVjdJ?=
 =?utf-8?B?MzJBMkJGSlo4TlBzVEJlRjNIWjg3SEp0R1NCMlVWWU1pOWxxTy95L3RSNFJR?=
 =?utf-8?B?RG9KYXZDUm4xS2tYbGpZMDQ5eEhka2EzQWVSZEo1QU9zenROcGdpeE51UDEw?=
 =?utf-8?B?UDJNRHhML2RUTzgzbTdoNW8vbmxwZk9RZkwvb01QZXVpbE10dk1UdHZydVU2?=
 =?utf-8?B?SkU1TG1xUmIxWXhaakhZSEkramo1aWMwTVZoenRNOXlDdU1pRk9IU0p3cGJr?=
 =?utf-8?B?TWVTeHlMelVFb2xJTG0zam9XUlRJRWRJemROTjBhYjBKK3RlNm9zZU9jQ2Jn?=
 =?utf-8?B?RU92aVFjZTJaZnpwYW9lZFUzbmQrT2o2bGJIOEp5cDBaTCs5UThiL0tWNXRi?=
 =?utf-8?B?SncwRmtOZlA1SkQ5OGxzSFhrbkZqcHVlZmVsQlVYV1E4YXBIY0NsL0d6VTNz?=
 =?utf-8?B?NnRZSE1NNmxDb1NYMFMxYlV0K1ZVSFp2UjBON1AwNTZBVjJyR0VFZE1vTTRL?=
 =?utf-8?B?cWp2TkhPbmNQdk9ZTlU3dldCa2JFaVVWTmExMWMwbGFlRCtwUEo4a3gxTElI?=
 =?utf-8?B?ZGxLSTByTkdCNHRjM3VUU2UwOWpxZXJjZkI3Zm5leUk2b2kzMURVMWFSdUJB?=
 =?utf-8?B?RnhNdFVpSk1YL2ZDVkdzT1AzR29VbENxVGF1emR2bnpNeVR0VW1PRklwS3E2?=
 =?utf-8?B?UmdTQkdNTDBYOUQ5THRBWTlkTTFtK2VrWFJMSG1DdTJ5bkhjbUxqQUxzZWl1?=
 =?utf-8?B?ZFE9PQ==?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <5CF7CEA352F9EA4D9C31FA9539237B26@namprd11.prod.outlook.com>
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
X-MS-Exchange-CrossTenant-Network-Message-Id: 7a8abaad-1de9-4131-50f9-08dd1b61cda6
X-MS-Exchange-CrossTenant-originalarrivaltime: 13 Dec 2024 10:35:03.2444
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3f4057f3-b418-4d4e-ba84-d55b4e897d88
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: zgq8LJ3ryYfc971HW7ABsUX99OAAZfL4RHSjf6NKZVFl38K5HnpATJblmRHy/lPbEFvFMT76ABzradaKI3jwPgScYA5PnH+eCT/haXJasjWbsM7IE3fP0QztDfq0pPOF
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW3PR11MB4634

SGkgSmFrdWIsDQoNCk9uIDEyLzEyLzI0IDY6MDMgcG0sIFBhcnRoaWJhbi5WZWVyYXNvb3JhbkBt
aWNyb2NoaXAuY29tIHdyb3RlOg0KPiBIaSBKYWt1YiwNCj4gDQo+IE9uIDEwLzEyLzI0IDU6NDEg
YW0sIEpha3ViIEtpY2luc2tpIHdyb3RlOg0KPj4gRVhURVJOQUwgRU1BSUw6IERvIG5vdCBjbGlj
ayBsaW5rcyBvciBvcGVuIGF0dGFjaG1lbnRzIHVubGVzcyB5b3Uga25vdyB0aGUgY29udGVudCBp
cyBzYWZlDQo+Pg0KPj4gT24gV2VkLCA0IERlYyAyMDI0IDE5OjA1OjE4ICswNTMwIFBhcnRoaWJh
biBWZWVyYXNvb3JhbiB3cm90ZToNCj4+PiBAQCAtMTIxMCw3ICsxMjEzLDkgQEAgbmV0ZGV2X3R4
X3Qgb2FfdGM2X3N0YXJ0X3htaXQoc3RydWN0IG9hX3RjNiAqdGM2LCBzdHJ1Y3Qgc2tfYnVmZiAq
c2tiKQ0KPj4+ICAgICAgICAgICAgICAgICByZXR1cm4gTkVUREVWX1RYX09LOw0KPj4+ICAgICAg
ICAgfQ0KPj4+DQo+Pj4gKyAgICAgbXV0ZXhfbG9jaygmdGM2LT50eF9za2JfbG9jayk7DQo+Pj4g
ICAgICAgICB0YzYtPndhaXRpbmdfdHhfc2tiID0gc2tiOw0KPj4+ICsgICAgIG11dGV4X3VubG9j
aygmdGM2LT50eF9za2JfbG9jayk7DQo+Pg0KPj4gc3RhcnRfeG1pdCBydW5zIGluIEJIIC8gc29m
dGlycSBjb250ZXh0LiBZb3UgY2FuJ3QgdGFrZSBzbGVlcGluZyBsb2Nrcy4NCj4+IFRoZSBsb2Nr
IGhhcyB0byBiZSBhIHNwaW4gbG9jay4gWW91IGNvdWxkIHBvc3NpYmx5IHRyeSB0byB1c2UgdGhl
DQo+PiBleGlzdGluZyBzcGluIGxvY2sgb2YgdGhlIHR4IHF1ZXVlIChfX25ldGlmX3R4X2xvY2so
KSkgYnV0IHRoYXQgbWF5IGJlDQo+PiBtb3JlIGNoYWxsZW5naW5nIHRvIGRvIGNsZWFubHkgZnJv
bSB3aXRoaW4gYSBsaWJyYXJ5Li4NCj4gVGhhbmtzIGZvciB0aGUgaW5wdXQuIFllcywgaXQgbG9v
a3MgbGlrZSBpbXBsZW1lbnRpbmcgYSBzcGluIGxvY2sgd291bGQNCj4gYmUgYSByaWdodCBjaG9p
Y2UuIEkgd2lsbCBpbXBsZW1lbnQgaXQgYW5kIGRvIHRoZSB0ZXN0aW5nIGFzIHlvdQ0KPiBzdWdn
ZXN0ZWQgYmVsb3cgYW5kIHNoYXJlIHRoZSBmZWVkYmFjay4NCkkgdHJpZWQgdXNpbmcgc3Bpbl9s
b2NrX2JoKCkgdmFyaWFudHMgKGFzIHRoZSBzb2Z0aXJxIGludm9sdmVkKSBvbiBib3RoIA0Kc3Rh
cnRfeG1pdCgpIGFuZCBzcGlfdGhyZWFkKCkgd2hlcmUgdGhlIGNyaXRpY2FsIHJlZ2lvbnMgbmVl
ZCB0byBiZSANCnByb3RlY3RlZCBhbmQgdGVzdGVkIGJ5IGVuYWJsaW5nIHRoZSBLY29uZmlncyBp
biB0aGUgDQprZXJuZWwvY29uZmlncy9kZWJ1Zy5jb25maWcuIERpZG4ndCBub3RpY2UgYW55IHdh
cm5pbmdzIGluIHRoZSBkbWVzZyBsb2cuDQoNCk5vdGU6IFByaW9yIHRvIHRoZSBhYm92ZSB0ZXN0
LCBwdXJwb3NlZnVsbHkgSSB0cmllZCB3aXRoIHNwaW5fbG9jaygpIA0KdmFyaWFudHMgb24gYm90
aCB0aGUgc2lkZXMgdG8gY2hlY2svc2ltdWxhdGUgZm9yIHRoZSB3YXJuaW5ncyB1c2luZyANCktj
b25maWdzIGtlcm5lbC9jb25maWdzL2RlYnVnLmNvbmZpZy4gR290IHNvbWUgd2FybmluZ3MgaW4g
dGhlIGRtZXNnIA0KcmVnYXJkaW5nIGRlYWRsb2NrIHdoaWNoIGNsYXJpZmllZCB0aGUgZXhwZWN0
ZWQgYmVoYXZpb3IuIEFuZCB0aGVuIEkgDQpwcm9jZWVkZWQgd2l0aCB0aGUgYWJvdmUgZml4IGFu
ZCBpdCB3b3JrZWQgYXMgZXhwZWN0ZWQuDQoNCklmIHlvdSBhZ3JlZSwgSSB3aWxsIHByZXBhcmUg
dGhlIG5leHQgdmVyc2lvbiB3aXRoIHRoaXMgZml4IGFuZCBwb3N0Lg0KDQpCZXN0IHJlZ2FyZHMs
DQpQYXJ0aGliYW4gVg0KPiANCj4gQmVzdCByZWdhcmRzLA0KPiBQYXJ0aGliYW4gVg0KPj4NCj4+
IFBsZWFzZSBtYWtlIHN1cmUgeW91IHRlc3Qgd2l0aCBidWlsZHMgaW5jbHVkaW5nIHRoZQ0KPj4g
a2VybmVsL2NvbmZpZ3MvZGVidWcuY29uZmlnIEtjb25maWdzLg0KPj4gLS0NCj4+IHB3LWJvdDog
Y3INCj4gDQoNCg==

