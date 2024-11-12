Return-Path: <netdev+bounces-143941-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id C1A649C4CC7
	for <lists+netdev@lfdr.de>; Tue, 12 Nov 2024 03:45:49 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 78E8C1F23303
	for <lists+netdev@lfdr.de>; Tue, 12 Nov 2024 02:45:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E500419CD0E;
	Tue, 12 Nov 2024 02:45:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=microchip.com header.i=@microchip.com header.b="wq7REIYn"
X-Original-To: netdev@vger.kernel.org
Received: from NAM11-CO1-obe.outbound.protection.outlook.com (mail-co1nam11on2070.outbound.protection.outlook.com [40.107.220.70])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4A0292F2E;
	Tue, 12 Nov 2024 02:45:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.220.70
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731379542; cv=fail; b=WXDLMbDAhAsCLLV1myqXgCGPeIK3P0X8CSy1g42U2oz/8p7jdGsixNMUc96Dn+VnUh7b7AoGBtrxIWvSQiQTBKcBsbhdoCsz2C6NqLZkF4vEwi95iy744UyoYzF/inKxP3Hw6aJ3l5r5d9eZRlYVu0CiWn0/hwyU9hUdqOxkCOQ=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731379542; c=relaxed/simple;
	bh=rkUhHk2NWLoU6JiPqGDBaEVagE6quM5Yp20iSaklyP8=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=lbNIO9ljKqF71QJvB46DW5RzrhqB3mp/71T/P8jwKOt/2xmerqfwoem4gY4quH7krmBBJ6NbaZ5rC9yvaOhrAaKJdOZJt0reVDPN7VL5CRJIkdhlC4ikbgRRI9U8HUn7KisrJ7yvU/SkegIWc/7Zqkb7E0sbioH9XWCCpLZRm50=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=microchip.com; spf=pass smtp.mailfrom=microchip.com; dkim=pass (2048-bit key) header.d=microchip.com header.i=@microchip.com header.b=wq7REIYn; arc=fail smtp.client-ip=40.107.220.70
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=microchip.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=microchip.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=jSFGGWSolVsHagzmjl8/pRxEWXWerkCxxWnkIwiRCQL7LKOqbexJ9lrlAH+Crrm605ZjBe40CDVp8jh5gxo0qgWKVZuHfDojA/+1S+gI7uXH4KjG9WkjVG84BIuNKh2GHeSEBZwjzYE2mjwzLzaKAf/IE+BiGc2LFDqLBPvk7ZDjXExZZYgPYxkskRfxTk8tz0l83V0dOmyb85tCtO2TySajXCuNLRVRk57K1TLkPcJ1bWlnWfZ0DywdTvG/zfCJwU4exqjU3/OgmZvzfqA4/ue29rk3MbFk3aHeAdM8iaEC0TEFG8AIdhzntd01crEctz7Gai8QwMZvhDVrSJDCig==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=rkUhHk2NWLoU6JiPqGDBaEVagE6quM5Yp20iSaklyP8=;
 b=KLaLTiIYKTL2HH3uwJ7UwW/V2ZWNLdsM6QvsCSsD/dTFe4U9rPmVAh0Uejlv5FQ5orolEuKgiir+oCGyeIQaTntoWr3t1AwTLh1xKLV2fHt3p13D5rdZCQTZIaX6RYhZeb/+r2o2wXH2fT3LkNxx1njZUzVZS3YVu1yxyLk342eUFyQwiuP92aWd1kad3wWd/6OvduURB1qfWVbIOqnLIReArJM9+n2MkLEnrR57iAzocG37CG/54nmTFO7a0tomlkWIozjbelgX8G74jYEcuRO4NyvLZypZMmjAU0FnldfeKhIus1kUMdF2TFiDq2tUqospJOGy4hS+T0bgaT2VTw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=microchip.com; dmarc=pass action=none
 header.from=microchip.com; dkim=pass header.d=microchip.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=microchip.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=rkUhHk2NWLoU6JiPqGDBaEVagE6quM5Yp20iSaklyP8=;
 b=wq7REIYnm/LXNeDRt5ehdfTOTUdIQTSloKQ+Ho5UwH2cuDU69TG4R1mls8Zc+Gnsu5NfbUvvUuXfr+3JuqptlxFvTlMCHoHzTOSf3MYnNMxbw3WsP9xN1Fp8Her8OS9b0JXLP5TeGqCyTq9rxDKeupF3wDwycp5DxFrKuQ7DodjIABMsW2LZK5K7ZvqcC9fIMauscYt/KqfThX2mTW+5OTGjif3ZbTYx/DNgPcaVZSPAmKspkSeKDwTmbmKsE1JigzVZiIkHDLD7mZIfA8b6LEMZS+k3CW/LUngdiB9u5dJcekUtVG9LVeggK1BElX981Z2KOt78OC9sP3kZKOt98g==
Received: from DM3PR11MB8736.namprd11.prod.outlook.com (2603:10b6:0:47::9) by
 DS0PR11MB8719.namprd11.prod.outlook.com (2603:10b6:8:1a8::19) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.8137.28; Tue, 12 Nov 2024 02:45:37 +0000
Received: from DM3PR11MB8736.namprd11.prod.outlook.com
 ([fe80::b929:8bd0:1449:67f0]) by DM3PR11MB8736.namprd11.prod.outlook.com
 ([fe80::b929:8bd0:1449:67f0%6]) with mapi id 15.20.8114.028; Tue, 12 Nov 2024
 02:45:37 +0000
From: <Tristram.Ha@microchip.com>
To: <krzk@kernel.org>
CC: <Woojung.Huh@microchip.com>, <andrew@lunn.ch>, <olteanv@gmail.com>,
	<robh@kernel.org>, <krzk+dt@kernel.org>, <conor+dt@kernel.org>,
	<davem@davemloft.net>, <edumazet@google.com>, <kuba@kernel.org>,
	<pabeni@redhat.com>, <marex@denx.de>, <UNGLinuxDriver@microchip.com>,
	<devicetree@vger.kernel.org>, <netdev@vger.kernel.org>,
	<linux-kernel@vger.kernel.org>
Subject: RE: [PATCH net-next 1/2] dt-bindings: net: dsa: microchip: Add SGMII
 port support to KSZ9477 switch
Thread-Topic: [PATCH net-next 1/2] dt-bindings: net: dsa: microchip: Add SGMII
 port support to KSZ9477 switch
Thread-Index: AQHbMkqetmTrvSsF8k28EHNiQO+m/7Kuw/KAgAQxAAA=
Date: Tue, 12 Nov 2024 02:45:37 +0000
Message-ID:
 <DM3PR11MB8736A69126CEF233DDBF43A5EC592@DM3PR11MB8736.namprd11.prod.outlook.com>
References: <20241109015633.82638-1-Tristram.Ha@microchip.com>
 <20241109015633.82638-2-Tristram.Ha@microchip.com>
 <vy2bqhyyfvi5kum3sfefva7lquw2ixqmstx355egkqbplmte4y@5hovbiuwmqqk>
In-Reply-To: <vy2bqhyyfvi5kum3sfefva7lquw2ixqmstx355egkqbplmte4y@5hovbiuwmqqk>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=microchip.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: DM3PR11MB8736:EE_|DS0PR11MB8719:EE_
x-ms-office365-filtering-correlation-id: b09037fb-dbc8-483f-fd9a-08dd02c416c7
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM3PR11MB8736.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(7416014)(366016)(1800799024)(38070700018);DIR:OUT;SFP:1101;
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam:
 BCL:0;ARA:13230040|376014|7416014|366016|1800799024|38070700018;
x-microsoft-antispam-message-info:
 =?utf-8?B?bThVNjV1bnU3ZjB1Z0NXR0xxZW9jR2x6VEFOdWNWenk5cjJ6azVNS1RGaDR4?=
 =?utf-8?B?Z1NDOThHUVMzSFZPeC9mRWwzMitJUmNocFd4RlFzTEJoVWc1YUx3ZktFb1lj?=
 =?utf-8?B?Z213UWVueXdNMHBDSTFic3huQlBjUE9xWFlNL293MmQxbENlSDVuYTFRQWg2?=
 =?utf-8?B?UFZZbzFtSUdWcWtPTmY5UGVDdU0wdVBIVk9YRWxTeEoxYXNMdWg1V2RKUXFY?=
 =?utf-8?B?R1crcFVxWEJnZERGVDFDVWo1ZmxseVJXY0dyekkyREhiRW1mMHpXSWZ2ancy?=
 =?utf-8?B?TEp2bDZBVzBkTEtJeC9Qc2hrUm9pK3hUL3NkbWpVTmRlSmkwRDFNZG84QnJU?=
 =?utf-8?B?NGJnUEtDdkRYSjBVdnlIajNvYTRqWFBoOTVEZ09Db1VrQm1NcW9wODZ2Y0Qv?=
 =?utf-8?B?TU9VREhMakJrYVVVODJMM3ZZOXVjUWRRYnQ5d1dUbkVRTHhQY2tUUlhvanpi?=
 =?utf-8?B?S0E1OGtNbHRlL3NOYzJRNnRFY3UyS24xUnQ4WmVaMTBtRCtIN2RCeFRvUFdB?=
 =?utf-8?B?bDJSRHQ2eFhHQXd4ZVFOUVg5MnVsRFZJc3VUMGFWZXNhRjJKc0UzTTIyMStt?=
 =?utf-8?B?OXFNd292TmhRMWg5azlCUHcyUEZZTWRqWURsV0NZL2VGUG5Xdy9zYXZ6aVZP?=
 =?utf-8?B?V01WNTZZWGxmbGNTYVJSNVNHbUk0dGFROEd5ZHcxTW9YYStLNTQxMk9keXhT?=
 =?utf-8?B?bVk2aU8yODRud1pzZ1JCdFQvUDFUK0VhdldXMUZxSVFlTlFYS0g4MG1BV2Rw?=
 =?utf-8?B?TlZIM3pIVEE4VFY1WmF6VlFCaGorNndxa01GUjVCNU9MUEs4RmR6NGdUdUpO?=
 =?utf-8?B?aE1TajNSZ21vcTlCalE2UVhTUXQwWnh4L0pERFBhK0FDUWw5aUtZZVZXVVg5?=
 =?utf-8?B?ODBIS1JYOFRkOWQ2R0NtNFYxWXN4aTFCdFB6bXhIVkJZQ3hqZXpTTE5qYlVt?=
 =?utf-8?B?cTFzc0ZLZnpvVm1ESjdHdXA3U3czT0JaSE1ZaVR0am41b252ZC8vTXVweHlK?=
 =?utf-8?B?Zkt6SklxaEhHUm9qbm9tTzVHSFJpaUZhT2g1eUlrQ2o1SUFpaVJTcHd4U1hE?=
 =?utf-8?B?d2tEZm5UQTB6amxLbGNJaVRkSDhvd2NtYzdtNENpRndINkN3andZNEhwSDgv?=
 =?utf-8?B?Y0ZKRER6SjFuZEtCL0JqQ1Q4L3JXUFZrOExnNzdBQnVPcEJsVFUzT3J0cXFz?=
 =?utf-8?B?eFR0VjV4bytQdkpvQUtyUnBCcXgxSTVQVm5ZZ2puRHBKOEdibytJdGpmMmxn?=
 =?utf-8?B?VUJMZHhySGxVVG1Jb1lIcnNYalJHWSs2bURpS3FIZjc2Q0QwVDZmcWVPUm5S?=
 =?utf-8?B?UWRCYUNCVXg0RFE0NXhwd01zVklndzdWbjBYcUtnR3B2Q3FzalhhZG1XcWE3?=
 =?utf-8?B?SFF0bnZwbHhEeG9DK3ErRDU2UVhPcmZSQktxMUJsMWFlOWo4SjlvdDdya3ZR?=
 =?utf-8?B?bTYzcFNCdldycDRsV3dBc1hkUlZkdXJBQjhTdW1lMFgwbS9zclJYVy9NZ2d6?=
 =?utf-8?B?WWtTR2FCbTQ0ZHV3OGYzNmtTY2l6N1RTTk5BeDBtRlVtTGc4elJuVEk5Nllt?=
 =?utf-8?B?dE5jMmRVSUthUDh6V2VhNjNQN1hWUGlQQldTM2p1SEoxYXMrQzJKZVJQUjhu?=
 =?utf-8?B?VjB1VHlrOTFEMG5VZXVPYll5aEVON3NpbmszMHkrMmhTRXN0R1V4Z25zZkdX?=
 =?utf-8?B?TzU2NWdTWnA2RlFmTlAvSDhOdDVpMi9sUnFVM0NSZVpneFM2Rm1WQUI0ekx2?=
 =?utf-8?B?aWh2aE4wVFh5NFVGdGlvMWhuRFEzSUJ4M01vZ1U4ZlhHZXRObGRhQ3c5NS9o?=
 =?utf-8?Q?BtHTKrkq7gHlKLrWujMgFFFZfmFLfBLhd9rz8=3D?=
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?utf-8?B?SzNMYmh4RWRud2YrRFAyNWVqWkFXYWkwUTJOUVJGSjNlZitOSFA3akM2WEVY?=
 =?utf-8?B?KzdQTmR4QUNZSjNRMGU4SlpiVW04T1dpK1NOSWRYcmNZQ2t1eG9VVlExNTZR?=
 =?utf-8?B?RmZIRm5YWkNHU0Zudy9wODQrQjZWYndRN2l5d2wwL2RDRzhnMGVmOHhhWXVv?=
 =?utf-8?B?OGZWUFBKN1lhcUw1Z3dkQSt2NXEyOHJrYjB0c2xJNUY3VWxZdEdBeHJIM0RQ?=
 =?utf-8?B?YzVCMHA4SmZDMWV2d09WK1VQWFNSNXRMMVNJM3ZwbjI2dmJCaGszSlozNVkx?=
 =?utf-8?B?TENYSkJDQVFUcldQZk5pMFhFNElhb21QNkVqSzUrV09hSTc0dnJVM0kxd1hK?=
 =?utf-8?B?R3NUZGp1ZXNVU2l2SmIwbnlJRm85dERIbjhWYWNXcXhGRDlhS0xOdmVXL3FU?=
 =?utf-8?B?SnVodnZHQ2NuR2Y3Ym53WnEwNHBJaWJoRTIvSjIzSlZ1SUdVaG8yWE5jODBU?=
 =?utf-8?B?NXhIeXNoZm1VUlpVMWt2VTR4L1pFRi8zWnJGMm12RHYyYlR6bTFvcHlIbXox?=
 =?utf-8?B?blNvODhuWU42WW1hc1VIK1dBL3RtN2hDTk15bjNTYTY2SW45VFJKcnBRUFR6?=
 =?utf-8?B?ZG40TUw2ejlLd3JTNGx2ZnFWTmJTdlFiVDJzK3BBdjY5c0V6MStSMjgwNExy?=
 =?utf-8?B?VjQwcGlVSVl0YU8rZlJEVnN6RDUvK2pqcmZCcEpFamwraTJzbVJRQmpDaGxT?=
 =?utf-8?B?ZlllWTc5dnlpRnErWUdtSGorOFp2MTd4QUIwRUswRTlQUDhOTFloSURERzg1?=
 =?utf-8?B?UmFscEZIcmxLOThsWWFoOVUvTmoxdFBKdlorU000OW1TYldmK1hkMlNWQm9t?=
 =?utf-8?B?TWNnVEd1SWcvcjZWamFWVU9aZW9qTWlLVU1DZm1lTVM2Q0xkbC9VNjlDbXJ0?=
 =?utf-8?B?SCswRDlNNU55Z0RVZ2FrSktSOUh1bGp2ZENOUUJqSWwvVXJvb0Qxcnc0RUVM?=
 =?utf-8?B?UUljUGovRlh1Y1FVM2paZ0lOSHplbzNTeDNFek1qZjZTUE8vVGlMWDA3Tjd6?=
 =?utf-8?B?UnBPSXllSzFjcUIrTHZjNmgwVEVpWjRxcGtVeUVWdkJjVTFBMW5hU3RhRmQ5?=
 =?utf-8?B?UDdISkJiUVoxdWE3em1BWUUxOVpneWs2YjlaVCszTmduNHdiSUpLYlVsaFFV?=
 =?utf-8?B?T0FMVTNMRWZyRHJhdElmTWpZWVl2UzhwNFZRaVg0SFFXSVBwcElPeDFXc21z?=
 =?utf-8?B?cDE2ZjY1UDByWGVuNS85VnNKalQ5QUU0NVVVVjZBMG1BVGpzMFVOTFBhUXJN?=
 =?utf-8?B?ek9RVVFXMDhMOXlxbU1WbnN3M2hBVnBla1EvaFNKdmpxT0VWLzBBcktLckVr?=
 =?utf-8?B?Z093T1dmK0NqV1FlNjVsSTBjRkNYZ1lRSUhlR1ZOeHhmMlEzVVV4dXZOL1g2?=
 =?utf-8?B?Nkt0UVY0bjZzMkorWVJFdE0rKzJrcGoyMFBDdnh3SHhBUFlObFF0SGhmVzZK?=
 =?utf-8?B?a3FNYVZnQ0FIRWlCTU9jN21QOU1OQTB6a2dnTkZvVlF3dzVEelQ3RU9BSkhR?=
 =?utf-8?B?Qnc5MnR1WE9PTzdQRXdVSkNPYlMweU5qUWFTUGYxS0Q2QjQ4TmgrRjNhdm5E?=
 =?utf-8?B?cUZBY05HTFVOR01JMHBRdTkxZVRtYU5WU1ZrMlZHOE9YeUFHWE9pcjFVZlFv?=
 =?utf-8?B?RzZLU0FUdUFUc0xnQkNndVhTVExiTlJuZlB4TkZzNUc0KzNiazZuamFUSGR4?=
 =?utf-8?B?MWZUQXEwWTdyV0xsNWk0OFhYRWgyYnF0ZVF4VDNQblJBVzdET0k4c3NVVUQ1?=
 =?utf-8?B?aW5ZbE81cld5ZmQvaVk3S0pMU2pLMUU3SzlTem1hRE5rSDVnUGp5QWNHS2hm?=
 =?utf-8?B?SHdPbmI5RVZoTjd6ZnBrbkJETTM2MzBaeGZuZzdnc0NXMEtSajRrNVhaY2tW?=
 =?utf-8?B?UTBQMkxUSUtjWU5iMG1jck1COWRuNWJVM0FsMkhRcmZQaDNQM3hjMHhNajNa?=
 =?utf-8?B?cVFqREdDZDNVc09oSlhJbDhNRlFoVzg1dDJPeXZFNVdjQTRuOUJFWUxHZmdl?=
 =?utf-8?B?b2pxVE5tVENvTGYyNUZKY1JEclpjWTlrZnNNckdiNmlHcVpiTFJNNU5XN1d2?=
 =?utf-8?B?bHB1dFdXNGZma2ltcDZaVkNQYXNuS2oxMDlzcThwUFdqdHNWbk4yZWhGS1Bw?=
 =?utf-8?Q?DfGIokmLP5E1qITJyQEuMq/Co?=
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
X-MS-Exchange-CrossTenant-AuthSource: DM3PR11MB8736.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: b09037fb-dbc8-483f-fd9a-08dd02c416c7
X-MS-Exchange-CrossTenant-originalarrivaltime: 12 Nov 2024 02:45:37.4956
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3f4057f3-b418-4d4e-ba84-d55b4e897d88
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: UZNKJ03LWGPmEpWL1nxOqCvq1zElVWmOM3v7w/TxvVi4d8+QSo2FVzyuVgKqnf81DpXD4u78EbqKy68241sgLJvS3ANdfuAOSrG7bJmF664=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS0PR11MB8719

PiBTdWJqZWN0OiBSZTogW1BBVENIIG5ldC1uZXh0IDEvMl0gZHQtYmluZGluZ3M6IG5ldDogZHNh
OiBtaWNyb2NoaXA6IEFkZCBTR01JSSBwb3J0DQo+IHN1cHBvcnQgdG8gS1NaOTQ3NyBzd2l0Y2gN
Cj4gDQo+IEVYVEVSTkFMIEVNQUlMOiBEbyBub3QgY2xpY2sgbGlua3Mgb3Igb3BlbiBhdHRhY2ht
ZW50cyB1bmxlc3MgeW91IGtub3cgdGhlIGNvbnRlbnQNCj4gaXMgc2FmZQ0KPiANCj4gT24gRnJp
LCBOb3YgMDgsIDIwMjQgYXQgMDU6NTY6MzJQTSAtMDgwMCwgVHJpc3RyYW0uSGFAbWljcm9jaGlw
LmNvbSB3cm90ZToNCj4gPiBGcm9tOiBUcmlzdHJhbSBIYSA8dHJpc3RyYW0uaGFAbWljcm9jaGlw
LmNvbT4NCj4gPg0KPiA+IFVwZGF0ZSB0aGUgS1NaOTQ3NyBzd2l0Y2ggZXhhbXBsZSB0byB1c2Ug
U0ZQIGNhZ2UgZm9yIFNHTUlJIHN1cHBvcnQuDQo+IA0KPiBXaHk/IFRoYXQncyBqdXN0IGFuIGV4
YW1wbGUuIFdoeSBkbyB3ZSB3YW50IGl0PyBXaHkgbm8gY2hhbmdlcyB0bw0KPiBiaW5kaW5ncz8g
WW91ciBjb21taXQgbXNnIG11c3QgYW5zd2VyIHRvIGFsbCB0aGVzZS4NCg0KQXMgdGhlIGFkZGVk
IFNHTUlJIHN1cHBvcnQgbmVlZHMgdGhlIGNvcnJlY3QgZGV2aWNlIHRyZWUgZGVjbGFyYXRpb24g
dG8NCmFjdGl2YXRlIHRoZSBTRlAgY29kZSwgdXNlcnMgbWF5IG5lZWQgdGhhdCB0byB1c2UgdGhl
IHBvcnQuICBIb3dldmVyIHRoZQ0KZHJpdmVyIGNhbiBvcGVyYXRlIHRoZSBwb3J0IHdpdGhvdXQg
dGhhdCBjb2RlLCBpZiB0aGUgY3VycmVudCBwYXRjaCBpcw0KYWNjZXB0ZWQuICBCdXQgaWYgeW91
IHNheSBpdCBpcyBub3QgbmVjZXNzYXJ5IHRoZW4gaXQgaXMgYmV0dGVyIHRvIG5vdA0KY2hhbmdl
IHRoZSBmaWxlLg0KDQo=

