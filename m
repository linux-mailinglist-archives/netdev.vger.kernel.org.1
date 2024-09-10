Return-Path: <netdev+bounces-126802-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id EC23097290C
	for <lists+netdev@lfdr.de>; Tue, 10 Sep 2024 07:55:59 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 0999F1C23C99
	for <lists+netdev@lfdr.de>; Tue, 10 Sep 2024 05:55:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B11E016DEA7;
	Tue, 10 Sep 2024 05:55:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=aspeedtech.com header.i=@aspeedtech.com header.b="D2DRZtTk"
X-Original-To: netdev@vger.kernel.org
Received: from APC01-PSA-obe.outbound.protection.outlook.com (mail-psaapc01on2127.outbound.protection.outlook.com [40.107.255.127])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2D71D166F00;
	Tue, 10 Sep 2024 05:55:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.255.127
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725947754; cv=fail; b=lAAWHICscjuqJus03oJbBM6dPdzFMh8vbFiCE/j8PbqIrOhA4M1VSHbGFO9FEF5PrkpWleUmJzfgQrt9tMNzgXe4qgXxmx+vg7KQ3dGKKqsv4iiOAwRkCA7vbzCKUk3CyGiBBWfZ/UI+rpf6mpw7AJ+n7Aqh7TjQIJbJSFHMblM=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725947754; c=relaxed/simple;
	bh=e5+7Bvt2LJX8ff9py5blCdVFZOT/Pr+yuusqCSHk9lo=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=arjTaKaPFHXBhudTwfq/LnqWB4vmySN6FLx1pwJZMjCCKzC/FWBxwYl7Wh+k87e+h759b8eX5ATkG7ISzmRYW0YAMYCn7rMEBumSMdSnrda0J/sSty+K3mH39+jAGQH1ib7DpFQ/3Po2KSvl8n61C97YXj9vMivgy8G7lv34S5w=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=aspeedtech.com; spf=pass smtp.mailfrom=aspeedtech.com; dkim=pass (2048-bit key) header.d=aspeedtech.com header.i=@aspeedtech.com header.b=D2DRZtTk; arc=fail smtp.client-ip=40.107.255.127
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=aspeedtech.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=aspeedtech.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=R68Iv0bcBq4aZTLSazukI5948WBYn7qUbEz9VXVB8yk7Vajdzwv1fXc/bLxNUPxmozx/PK+0wJPnen+YXoJE9zzkhvL+tr7XmHkQfhYEJUTauttDRqbPx8+V8S8k0Yp67QDw2FfyfUskP2ZMeNUgUxpp9bHxwH7n2OXan+ub987ogFj1XyBbpJs/xXBfqmB5AjC6Am8Qb1TUDNo7j/6W4Bo/X8BvrpJ7juvUqmZwmiyrVByYS7k1ZzVryr7f4KtTtuZfLmvBxz7Ri7CPSs8oCFVm8/yT55eOnnhw9RD6EmTlB0s8I2Cf6Q34Dkt7kvwngnPNZetiD4jyYIr0ao8dnw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=e5+7Bvt2LJX8ff9py5blCdVFZOT/Pr+yuusqCSHk9lo=;
 b=UL38PVfy70zc2pqOiNIjs6+KuQteIHheCqULT3tRFVzhQk+1w3aGKcoaL8osMXbsi39hNdxxHWWUdvjv3PQiU2CxBn2DncDOP9MOCixVdkDr+sY2Lct/Xdk/Rg/n9HawKTdZ+ZGsddHGXIFVMzPBJS6kmJabrwkaXMtix9lsK4TnegB3i/ENcBPUg4upK3WuZ/DD2t1MJj10QkMirdAquT/K8M0iXM3qUkDmfxq9O7DwFU+RQ2aBjeDoHYUeSdR124RItc8aC2pJeXJ6TL2i5UCPOyePWcQvaGqwIdLIVEwUESYskwAU2AmKGgT/su9nT8TzUrrdzNEl8AvjnEOUMg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=aspeedtech.com; dmarc=pass action=none
 header.from=aspeedtech.com; dkim=pass header.d=aspeedtech.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=aspeedtech.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=e5+7Bvt2LJX8ff9py5blCdVFZOT/Pr+yuusqCSHk9lo=;
 b=D2DRZtTkin23U4xGXBpAdNMvwMNLmfR/lnraDGAg8uVM3JpWWknxN1H/EnowueKaI+w/0CcpGIyYT7CprW8OWLi0e/9O6DtTl1StLBa/lERwDRi/RNwlgPIC7n2JSO6z/L1PrCp3W1Al69Gyr/HQffVzUg8RVgSTsEJ0wsjQy/vL2/6udvgwED3/6WbD6URz4DPcjp/rmhjO2OTFEtk/SzQEu6YA0Lk/opE0KlNz7vW9oOBrBVgeIRW8/K1mWDS+3ucr1xg+Kk+viz6URtrqq4Z1gG1q7MJqFkdCwxlSVZFeomCbFeaRtcmPBf3FdLdpJfblvcMoPN7q9AYMWq7zRA==
Received: from SEYPR06MB5134.apcprd06.prod.outlook.com (2603:1096:101:5a::12)
 by TYZPR06MB6094.apcprd06.prod.outlook.com (2603:1096:400:33c::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7939.17; Tue, 10 Sep
 2024 05:55:47 +0000
Received: from SEYPR06MB5134.apcprd06.prod.outlook.com
 ([fe80::6b58:6014:be6e:2f28]) by SEYPR06MB5134.apcprd06.prod.outlook.com
 ([fe80::6b58:6014:be6e:2f28%3]) with mapi id 15.20.7939.022; Tue, 10 Sep 2024
 05:55:46 +0000
From: Jacky Chou <jacky_chou@aspeedtech.com>
To: Dan Carpenter <dan.carpenter@linaro.org>
CC: "David S. Miller" <davem@davemloft.net>, Eric Dumazet
	<edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>, Paolo Abeni
	<pabeni@redhat.com>, =?utf-8?B?VXdlIEtsZWluZS1Lw7ZuaWc=?=
	<u.kleine-koenig@pengutronix.de>, Jacob Keller <jacob.e.keller@intel.com>,
	"netdev@vger.kernel.org" <netdev@vger.kernel.org>,
	"kernel-janitors@vger.kernel.org" <kernel-janitors@vger.kernel.org>
Subject:
 =?utf-8?B?5Zue6KaGOiBbUEFUQ0ggbmV0LW5leHRdIG5ldDogZnRnbWFjMTAwOiBGaXgg?=
 =?utf-8?Q?potential_NULL_dereference_in_error_handling?=
Thread-Topic: [PATCH net-next] net: ftgmac100: Fix potential NULL dereference
 in error handling
Thread-Index: AQHa/1rfMsgzpIAVIUKgpr/yLMfBE7JKRNDwgAZB3ICAAATZ0A==
Date: Tue, 10 Sep 2024 05:55:46 +0000
Message-ID:
 <SEYPR06MB51346AA79267B5EC278F51CA9D9A2@SEYPR06MB5134.apcprd06.prod.outlook.com>
References: <3f196da5-2c1a-4f94-9ced-35d302c1a2b9@stanley.mountain>
 <SEYPR06MB51342F3EC5D457CC512937259D9E2@SEYPR06MB5134.apcprd06.prod.outlook.com>
 <aa2cbf22-ae6d-4adf-be5a-b3ea566d4489@stanley.mountain>
In-Reply-To: <aa2cbf22-ae6d-4adf-be5a-b3ea566d4489@stanley.mountain>
Accept-Language: zh-TW, en-US
Content-Language: zh-TW
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=aspeedtech.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: SEYPR06MB5134:EE_|TYZPR06MB6094:EE_
x-ms-office365-filtering-correlation-id: c6d19fd6-0301-45f5-6ae1-08dcd15d3713
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230040|1800799024|366016|376014|38070700018;
x-microsoft-antispam-message-info:
 =?utf-8?B?bzkrRkpISXNJbldVU0tScnRRcmlnSmRaanNjc0ZCS2c2TGptbGZvNUM4L2V0?=
 =?utf-8?B?UE5aa3FjZW15eTdsU2xyVEozMlhSTk0vZFlXRVRUS2dndGw2cG1WU2g3WVZ5?=
 =?utf-8?B?czVLRExndjlzSUdXcXFtUFN2dzJVYlc5bDhqTzBzMjJNUldzVCtnaE8xNkls?=
 =?utf-8?B?R0lSOFdhNmRrK0djUlBmNW8zN3NZZkMrRU1vemVQUEprcEpYNys1cHJVM2dB?=
 =?utf-8?B?WWliajY3ZzlxWFY4c2IvY2s3YWgvbVZtMmltQkVFRit6RVdUaEFFajJVRExP?=
 =?utf-8?B?eTgrT1F4d1lHTC9NVGFzZXBoMktDQVpHdXh5MkRCeWpnMFRNMGE0UEpLK216?=
 =?utf-8?B?NVZKYm5hWFFNNXpVWFdGQW16WG01Zjh4RmhKcmVsUjc3US9DT0lLZFVnSndY?=
 =?utf-8?B?WWVSTC92ZXhFczJ2cjlaNHNBMWd3cW15TEdzemRlQ2s5TDFJN3BkSVNhOVBE?=
 =?utf-8?B?UFovK29KUEE4Rkg1dXRVSzNkaWVITFFXUFJDbHJGeWtDQ215cWlUYTV4andL?=
 =?utf-8?B?OFVLem5aaEZDTDI5ckt1TjJFVDZKTkQwOEdsSDJKK2U5eDVZaFhzSTBGUGlD?=
 =?utf-8?B?c093SFhFeTgwZ0IxMVV0ZlFuMW13ZlVmYituQVNMT0VtejFMeHFTcGRmYzg0?=
 =?utf-8?B?M0JYUjN4Z0hWdWhoT3JlelpXbk5UK2pmaUI4RFE1dDNBR3Zvc25COWFyZjJo?=
 =?utf-8?B?aEdlTGErSlVpakdiRHN1VGkxNjRoTU82SXZncUFGZU55YkxWTjE5N0lXYnBk?=
 =?utf-8?B?N1crcXljOFl3QWZRSFlTZXBYNGs3YmJLOStTbTcxWWNRNkNCTHMyWTBuZTJL?=
 =?utf-8?B?MGZjTzRmNUg5V1pjOGozYVZaZHhhSnlPejRZdytTRnVTZFNsNS9WdFB0dGxF?=
 =?utf-8?B?VzgvZW1WNTJTVVV2WEhKWWQzUFlWSU9KTkFzRnVPWnd0V2RHQ1RNV3VubWF6?=
 =?utf-8?B?TlhjWHdtVE1NVlcwb2lyNWdKMjVBZFlyS3F6SU9OajFWRjhkSFpveEQ1dWRy?=
 =?utf-8?B?OGlDeUlyT0VIcVVUd2ZzVktKZEZzMHpmN0pUVnhzaG9FUHNWQndYR0FtMGUz?=
 =?utf-8?B?Ui9hc2dFR2tEczhWbXhNRnM5TVkxSkxFNjltSDhrNkhVUmNiL3BIWndxT0Zn?=
 =?utf-8?B?ZFhnUUZRbEdSMlhsWUY1NFN2TjRraFhIQzVzMDdCb05QZ2RpQklwSnFYeTlH?=
 =?utf-8?B?WkdGTCtCWXdjT1J4eVk3Tm1ZSnErRmUyZ3lrM1A2SmVBbTllb1liNWIxdzZY?=
 =?utf-8?B?TWpWZ092S3drVmhGNkl5cnVsT1ZJR2dWdGsrWTBwcnFOQU5hbGdRU1p4QmZX?=
 =?utf-8?B?RHltZmtyZFVuZG40VW80Z2Fwb3E5UW5vSWNmSkNUL0MzRWJrakR1RW5NZEk5?=
 =?utf-8?B?STlHeDV1a1o2TWE3bGFEc1NVUGR1VXpxMm5WMkFjWFFtVktRcms2R2pjaG1D?=
 =?utf-8?B?MjVkNEZoQTlFYmVjelFhM0VFQllCVGxsV1QydzQrb1dZMlE4OUhYZjJKWElW?=
 =?utf-8?B?Z2V5M2ZzcUpmNjNQb3BhTm1YRVY3MEloWktPT204THFtdWtJVkpuSlkyckMw?=
 =?utf-8?B?dDFVQXYrOFhzQTlWanRnY1FlaHVXUGlMMmd6bmhudDF2d0kwNjFGM0pYa2xB?=
 =?utf-8?B?a212MWVRT0dlKy9NdVRqWFlmWVUxaG9KZDdwV2pLZUlEc1hqV0FPODFLd0Fs?=
 =?utf-8?B?bDY2dlV3K3JJeE5YWGZYOWFtdG1Ha1lscGI4UGo5UElzTkpveVhkQ0s2NEJ2?=
 =?utf-8?B?WU5ubUE0V3NQenNxNldjUktzbWNPM1lBa0p1R2NJNmxzZ29PM2R6cnIxVXVX?=
 =?utf-8?B?TXV4Z2F4bGpRczJhcHJDNUFjWURzcTFhem5vRmkvT3p3dkV3K1h3U2lmeDVx?=
 =?utf-8?B?bDFrUEN6dnJzT1FHeTNKSGRnV21samNtb2U3bWlQQ01ZUHc9PQ==?=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:zh-tw;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SEYPR06MB5134.apcprd06.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(376014)(38070700018);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?utf-8?B?cU1ZV09PU200VDg0bG0xbWlTcEVSUmdQc3hKRkMyOGFNWkM1VzBKaFFMb0hQ?=
 =?utf-8?B?akpVMnVzMG84d3B0TTBEVVB1N3dXRGJjYVZFY0tkMWErTWhFdXpoZk9jYWtr?=
 =?utf-8?B?NXd0OXAvd01waXFjdTMrWk5ObDNzNUVEY1BjRnYwSDdscytqWlZMcXRZMm9Z?=
 =?utf-8?B?dHdjcVRIOFV3VDl3ZkllTU5USnNYUVBJRTVvcmdVSFkyc1BiREhPQUE3RFBj?=
 =?utf-8?B?bkZYVW9RTlZmWDJ0SzN3WFpjRUZwNU1FbGxuWTUxSEhnYXRHUDNlMGduUVdz?=
 =?utf-8?B?Vy9LbzN0ZGxudHE1eWE1YXRKVDRtMjFCTnRnSlQwdzd3b25tYmdDWUtXdzlo?=
 =?utf-8?B?L3RsZ3JVRUJZcy9yaTVHOFdwVzA3S1NMTG1nOUhVb1dxOHB0ZXBLdnVFZUVp?=
 =?utf-8?B?YW4weE0vUDhsU2ZMUGEvNm9Cb0FZRVhxN1ptbE91cllWQ1ZVdWZGZjlyWlVw?=
 =?utf-8?B?eFFpa3gwTXZESlhxUWNIRWVCN25SWmY5aXh6VDBqLzhnRUo3VVNOZWNlVEli?=
 =?utf-8?B?TzA2bUNrWklrbk1Bcm1EaDk0TW1hRzFqenZ1Z29nV2JybkpaMzFOYVd1S0Mr?=
 =?utf-8?B?bEhOM3R2QUdGKzV2WlArSXQwK28vMmNxMlF0djBMcEJ2bFZKQ2pMeUc4MEtN?=
 =?utf-8?B?eGJIc0VYVFpvbnV0a1dyMHhQd2VuNWxDWVcwb3RZNzF4WGpCQ2NIU05GYU9n?=
 =?utf-8?B?ZU4xWjJOd2Y4aWJNTit4UzdWUHFBa1Z3elFqRmRpQndrazZlOU54Y3lXVStv?=
 =?utf-8?B?Nm9KSlBJbHNuUFBRbUZLU2tQcGRTTDZjZnUzTStMeFpkZFR0VVdCeG90c0oy?=
 =?utf-8?B?K1djZ0Q2c0tqaDBmL1BvY1FFS3lHUFlHYXp5UzB5SzZyY0xBVnZ0MmY2Y1I5?=
 =?utf-8?B?Qlp1Vis4ako0cVdkZnAzR1FUR3JOWWFPbVFTWVh2S2J2L0xlVElDWWxiOWM4?=
 =?utf-8?B?VC9TSnJaWWdnVXA1TU54cmx5ZThQWDJIZmtEVE8vaXdiR245bHc5YzRiMU9F?=
 =?utf-8?B?ZUo3MzFvYSt3Ymw3UUJuclVFQ0xqK2dtNU9rTjdFWFNFQ3lhMVNUdGh1UnRK?=
 =?utf-8?B?MGJoYU5jUmluVHlCRTJzR1lrcGdvYmRXaTgyTkxmMkt6R1lOOTdld0RuYlhZ?=
 =?utf-8?B?OHZMTUZSVXpqQW83N290R0swWDRiV3l2RUlNRFprb2daWnZCTnRRZVlQNzNv?=
 =?utf-8?B?WHh2clJpZnZ6VFZHbkdZWlZEU0UzdEdZY2h1WlBtMGJtK2RlSmpTRHNPdGd4?=
 =?utf-8?B?cWIxTUI5cG5TcEg3S2k4dzFwVlVxUzV5dGRlZ1VSYlhpU3lzK3FXNzRCMHI3?=
 =?utf-8?B?bmYvcjd2NS9RdjkxSzhrdW84eVRJRWUvRlVta3g4b3JzZ0FsS3hwRm5FRXZP?=
 =?utf-8?B?OHpwN3ZmSGNiVzBaYy8rYmZUMVpMUnNManFHUURvUnFtMWFZVC9rUXVscm9L?=
 =?utf-8?B?UHJTdlNJSXBWTWgxWllVT1RDMmNhMUNYcE5iamloRkhHNTZCczZSRlBoUGZV?=
 =?utf-8?B?Y2VQYlVmS201NW54ZWxGUFlqbXdKdUhiUzlpRnpsSGlvbGtPRmJJbzFaSUdE?=
 =?utf-8?B?T1pFQXhoVzZSTFFVUVZhUEREU0VpQ2RaaU5wVzE5SDl5cUR4ai9NV3BVRHVN?=
 =?utf-8?B?R2RrOWpNV2Vmd0w3aENad2JYc2ZaVWltRjhuc0NET3FjUjF0OEIwblJSQU9L?=
 =?utf-8?B?eU1RVTlFcC9UV0hhSjhuc3FseHdHVWgyQlJKYXBpcmd3d1ovQjgxbzJ5OVI0?=
 =?utf-8?B?Z0UrRExPemhoU0RaNzNCV1d5cE9CVFExUVUrRE5raFFKd203T3RpRWtPcHZn?=
 =?utf-8?B?ZWpwRVhmV2tyN2tGbCtUV2NDcUljTzlwTmlDeUIzVmRHcUx6eHpLM1crWTkv?=
 =?utf-8?B?SU40UkhFU283Q0p3bWl0VnBIbWsyQnh4VzdOcGRtVklHZkpDUWZub2UyRnRp?=
 =?utf-8?B?a2huVm85Z2VTbVBoeE5sclc2Q1lBVHFpM1NLK2pXMU8ybFlteGFTYWx4ajlq?=
 =?utf-8?B?allVUXVCYlRmalhoTU1HYVlUNnM5WDZsQlFEL05qemppYldXb1pId0dmMW43?=
 =?utf-8?B?cmhLenA3SlQ0NkJyRTZjMC83bW80eWdwTmNrM1NuK0Y2bkFBL3V4Z2FJWTZa?=
 =?utf-8?Q?o8wwA7jyahLggIQDGuAqfMLf9?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-OriginatorOrg: aspeedtech.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: SEYPR06MB5134.apcprd06.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: c6d19fd6-0301-45f5-6ae1-08dcd15d3713
X-MS-Exchange-CrossTenant-originalarrivaltime: 10 Sep 2024 05:55:46.5388
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 43d4aa98-e35b-4575-8939-080e90d5a249
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: wHrQPfR1rZ49LsS0Wecaq0KiuJ2GAHSIb3acKBh1lRSrzOkkb1x49lFug06lMTjnXgxwbdUo/V6nixlDXsIkox+5BebAEByGTK/Pa+ScOFo=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: TYZPR06MB6094

SGVsbG8sIERhbiwNCg0KPiA+ID4NCj4gPiA+IFdlIG1pZ2h0IG5vdCBoYXZlIGEgcGh5IHNvIHdl
IG5lZWQgdG8gY2hlY2sgZm9yIE5VTEwgYmVmb3JlIGNhbGxpbmcNCj4gPiA+IHBoeV9zdG9wKG5l
dGRldi0+cGh5ZGV2KSBvciBpdCBjb3VsZCBsZWFkIHRvIGFuIE9vcHMuDQo+ID4gPg0KPiA+ID4g
Rml4ZXM6IGUyNGE2Yzg3NDYwMSAoIm5ldDogZnRnbWFjMTAwOiBHZXQgbGluayBzcGVlZCBhbmQg
ZHVwbGV4IGZvcg0KPiA+ID4gTkMtU0kiKQ0KPiA+ID4gU2lnbmVkLW9mZi1ieTogRGFuIENhcnBl
bnRlciA8ZGFuLmNhcnBlbnRlckBsaW5hcm8ub3JnPg0KPiA+ID4gLS0tDQo+ID4gPiAgZHJpdmVy
cy9uZXQvZXRoZXJuZXQvZmFyYWRheS9mdGdtYWMxMDAuYyB8IDMgKystDQo+ID4gPiAgMSBmaWxl
IGNoYW5nZWQsIDIgaW5zZXJ0aW9ucygrKSwgMSBkZWxldGlvbigtKQ0KPiA+ID4NCj4gPiA+IGRp
ZmYgLS1naXQgYS9kcml2ZXJzL25ldC9ldGhlcm5ldC9mYXJhZGF5L2Z0Z21hYzEwMC5jDQo+ID4g
PiBiL2RyaXZlcnMvbmV0L2V0aGVybmV0L2ZhcmFkYXkvZnRnbWFjMTAwLmMNCj4gPiA+IGluZGV4
IGYzY2MxNGNjNzU3ZC4uMGU4NzNlNmY2MGQ2IDEwMDY0NA0KPiA+ID4gLS0tIGEvZHJpdmVycy9u
ZXQvZXRoZXJuZXQvZmFyYWRheS9mdGdtYWMxMDAuYw0KPiA+ID4gKysrIGIvZHJpdmVycy9uZXQv
ZXRoZXJuZXQvZmFyYWRheS9mdGdtYWMxMDAuYw0KPiA+ID4gQEAgLTE1NjUsNyArMTU2NSw4IEBA
IHN0YXRpYyBpbnQgZnRnbWFjMTAwX29wZW4oc3RydWN0IG5ldF9kZXZpY2UNCj4gPiA+ICpuZXRk
ZXYpDQo+ID4gPiAgCXJldHVybiAwOw0KPiA+ID4NCj4gPiA+ICBlcnJfbmNzaToNCj4gPiA+IC0J
cGh5X3N0b3AobmV0ZGV2LT5waHlkZXYpOw0KPiA+ID4gKwlpZiAobmV0ZGV2LT5waHlkZXYpDQo+
ID4gPiArCQlwaHlfc3RvcChuZXRkZXYtPnBoeWRldik7DQo+ID4gV2hlbiB1c2luZyAiIHVzZS1u
Y3NpIiBwcm9wZXJ0eSwgdGhlIGRyaXZlciB3aWxsIHJlZ2lzdGVyIGEgZml4ZWQtbGluaw0KPiA+
IHBoeSBkZXZpY2UgYW5kIGJpbmQgdG8gbmV0ZGV2IGF0IHByb2JlIHN0YWdlLg0KPiA+DQo+ID4g
aWYgKG5wICYmIG9mX2dldF9wcm9wZXJ0eShucCwgInVzZS1uY3NpIiwgTlVMTCkpIHsNCj4gPg0K
PiA+IAkJLi4uLi4uDQo+ID4NCj4gPiAJCXBoeWRldiA9IGZpeGVkX3BoeV9yZWdpc3RlcihQSFlf
UE9MTCwgJm5jc2lfcGh5X3N0YXR1cywgTlVMTCk7DQo+ID4gCQllcnIgPSBwaHlfY29ubmVjdF9k
aXJlY3QobmV0ZGV2LCBwaHlkZXYsIGZ0Z21hYzEwMF9hZGp1c3RfbGluaywNCj4gPiAJCQkJCSBQ
SFlfSU5URVJGQUNFX01PREVfTUlJKTsNCj4gDQo+IFRoaXMgaXMgYW5vdGhlciBidWcuICBUaGVy
ZSBuZWVkcyB0byBiZSBlcnJvciBjaGVja2luZyBpbiBjYXNlDQo+IGZpeGVkX3BoeV9yZWdpc3Rl
cigpIGZhaWxzLCBvdGhlciB3aXNlIGl0IGNyYXNoZXMgd2hlbiB3ZSBjYWxsDQo+IHBoeV9jb25u
ZWN0X2RpcmVjdCgpLiAgRm9yIGV4YW1wbGUsIGlmIHRoZSBwcm9iZSgpIG9yZGVyaW5nIGlzIHVu
bHVja3kNCj4gZml4ZWRfcGh5X3JlZ2lzdGVyKCkgY2FuIHJldHVybiAtRVBST0JFX0RFRkVSIHNv
IGl0J3Mgbm90IGV2ZW4gdW51c3VhbCBlcnJvcg0KPiBjYXNlcywgd2hpY2ggY2FuIGxlYWQgdG8g
YSBjcmFzaCBidXQganVzdCBub3JtYWwgc3R1ZmYuDQpZb3UgYXJlIHJpZ2h0LiBJdCBpcyBteSBm
YXVsdC4NCkkgZGlkIG1pc3MgY2hlY2tpbmcgdGhlIHJldHVybiBzdGF0dXMgb2YgdGhlIGZpeGVk
X3BoeV9yZWdpc3RlcigpIGZ1bmN0aW9uLg0KVGhhbmsgeW91IGZvciByZW1pbmRpbmcgbWUgdGhp
cyBidWcuDQoNCj4gDQo+ID4gCQlpZiAoZXJyKSB7DQo+ID4gCQkJZGV2X2VycigmcGRldi0+ZGV2
LCAiQ29ubmVjdGluZyBQSFkgZmFpbGVkXG4iKTsNCj4gPiAJCQlnb3RvIGVycl9waHlfY29ubmVj
dDsNCj4gPiAJCX0NCj4gPiB9IGVsc2UgaWYgKG5wICYmIG9mX3BoeV9pc19maXhlZF9saW5rKG5w
KSkgew0KPiA+DQo+ID4gVGhlcmVmb3JlLCBpdCBkb2VzIG5vdCBuZWVkIHRvIGNoZWNrIGlmIHRo
ZSBwb2ludCBpcyBOVUxMIGluIHRoaXMgZXJyb3INCj4gaGFuZGxpbmcuDQo+ID4gVGhhbmtzLg0K
PiANCj4gSXQncyByZWFsbHkgdW5zYWZlIHRvIGFzc3VtZSB0aGF0IHdlIHdpbGwgbmV2ZXIgYWRk
IG1vcmUgZ290b3MgdG8gdGhlDQo+IGZ0Z21hYzEwMF9vcGVuKCkgZnVuY3Rpb24uICBJZiB5b3Ug
aW5zaXN0LCBJIGNvdWxkIHJlbW92ZSB0aGUgRml4ZXMgdGFnLi4uICBMZXQNCj4gbWUga25vdy4N
Ckkgd2lsbCByZWZpbmUgdGhpcyBwYXJ0IGFuZCBzZW5kIHRoZSBvdGhlciBwYXRjaCB0byBmaXgg
bXkgYnVnLiBUaGFuayB5b3UuDQo+IA0KPiANCj4gcmVnYXJkcywNCj4gZGFuIGNhcnBlbnRlcg0K
DQo=

