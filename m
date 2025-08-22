Return-Path: <netdev+bounces-215947-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 0B950B31148
	for <lists+netdev@lfdr.de>; Fri, 22 Aug 2025 10:12:08 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 40BBE1C801BE
	for <lists+netdev@lfdr.de>; Fri, 22 Aug 2025 08:07:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D47772EA752;
	Fri, 22 Aug 2025 08:05:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=microchip.com header.i=@microchip.com header.b="v5A87za5"
X-Original-To: netdev@vger.kernel.org
Received: from NAM11-DM6-obe.outbound.protection.outlook.com (mail-dm6nam11on2080.outbound.protection.outlook.com [40.107.223.80])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 137121F463C;
	Fri, 22 Aug 2025 08:05:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.223.80
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755849955; cv=fail; b=HdBpWvlCBHXSAFlFswh6KYu04hfq5sqcMmsGX3TwV2U8HyibNKG5tsg0FBzcd5uh2LbMd1qIAeolw4ooAWoWuMQaSQW/T1ulAW0xk5b4vJkG1MzJJDmAFSACfmI1gF2mhoZrPVAl9tTyvFgmtYhLv9ZYsd+6K5+O08cNLWrUpzI=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755849955; c=relaxed/simple;
	bh=QAm5tzfHndHEdnLpDCTlEZx0JdMPg6Au6nNDFfuc9R0=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=sUZ0AdQxU3TOYHU8/qMexGHQlQvK0phnm3Ulrrk3+00Un4/u55GfPn3/36q/iOz46uM6aDUrCb7NqHYUVzUHPCDnZsgCnAsuKrk7IOkvflWcEE8jJicAfwqEHu/K2Px0cFtbo7q2p5CtivlJXBl2TbO6dQXP5Q12lcIzeDwSzJA=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=microchip.com; spf=pass smtp.mailfrom=microchip.com; dkim=pass (2048-bit key) header.d=microchip.com header.i=@microchip.com header.b=v5A87za5; arc=fail smtp.client-ip=40.107.223.80
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=microchip.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=microchip.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=X5iXMHnWy72AIaQP+VqDbnd46jcStEFOyYL9HWuapJFy5DyXTOxLwsodcmwgIiGvm7LFFjz2ZsnauF6B33v4q0jCT2zwfH771rJFbYM0M44GZIuPThPnQPbC35vxWQx6ODMJugpbiQtW1ss1uqHg9MQmbRpzBOY6xjRGQ4drb3DsX9I9LcBbq2uUbgWfIQftPXD3UxTE2nlfueMstSMMC4bm24SGKO2eQ5QKcvjm0m/50WghNsk/9z8aQsGJSG5/G6Ycb3mo6bZeQbbJqnHYdz/3FYnapvv6ABcnwh9pu0y+SuDxN098rHptWjjiPAEuOVLtjQUT7E7vwM8NdMmRAA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=QAm5tzfHndHEdnLpDCTlEZx0JdMPg6Au6nNDFfuc9R0=;
 b=w3GKsoMkQOqU5fPeSF7doxIiXtV/OVKdNOePH/+Mp/sFwvP8f8OLHageyg2zp62Pf3WIyq5OTB1NSy0f0iOTrKsdPwWoEmSMx6tVJO1e789mnC+gP+yJvTCpXYMoajHemH3y8XiaZoBlY6qOIvxJ6vJgumini9MMMU0bufFuJPwSLybodPrmRyhpg1PT51xDXKHu8nTALNHarM/i2ISgnssg6oahAE3nYPKKcQF8k4PKJaNDzz7NntDnlAwMn+Xk1k32ibqQ8JPU0keVWztpistq8/KTB7GKMEnOktxIfzBuw+ih7QEU09OJFUuDZsyWvzIEzEPxXzqIQWhESxN8yw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=microchip.com; dmarc=pass action=none
 header.from=microchip.com; dkim=pass header.d=microchip.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=microchip.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=QAm5tzfHndHEdnLpDCTlEZx0JdMPg6Au6nNDFfuc9R0=;
 b=v5A87za5/Zkxf+x/sohlZDRiLrzMGQtn00wBiJR7qkGxS7YY2lFO3N47Yp78FvpCAYy6SSFjIVRsOl8MZAMeb1Du12knbKVRodGZGb6umfC9R18hKG/+89n9/VNkvHs6qS1OqT7JWdLMhxiwy28FLEYUVrZd2UyFghTt9dqHviy4ig2p1VjyYvhggcuToE5Ks+ViTwJw4bJGbaiFtJ1LGxGms9qbTADEDtnhLYSNNDHIIFVVW9dT41DgIv+kCfkI7klO63QthBkqOCW80YAAHJ3JkLv16UhVFo4QkKyArogC1UU7F/lgzzglGSzSTx/wfF9SDY6aCLUSh8oD7UjGQA==
Received: from SA1PR11MB8278.namprd11.prod.outlook.com (2603:10b6:806:25b::19)
 by PH0PR11MB5952.namprd11.prod.outlook.com (2603:10b6:510:147::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9052.14; Fri, 22 Aug
 2025 08:05:50 +0000
Received: from SA1PR11MB8278.namprd11.prod.outlook.com
 ([fe80::84fa:e267:e389:fa9]) by SA1PR11MB8278.namprd11.prod.outlook.com
 ([fe80::84fa:e267:e389:fa9%7]) with mapi id 15.20.8989.011; Fri, 22 Aug 2025
 08:05:50 +0000
From: <Parthiban.Veerasooran@microchip.com>
To: <dong100@mucse.com>
CC: <andrew+netdev@lunn.ch>, <davem@davemloft.net>, <edumazet@google.com>,
	<kuba@kernel.org>, <pabeni@redhat.com>, <horms@kernel.org>, <corbet@lwn.net>,
	<gur.stavi@huawei.com>, <maddy@linux.ibm.com>, <mpe@ellerman.id.au>,
	<danishanwar@ti.com>, <lee@trager.us>, <gongfan1@huawei.com>,
	<lorenzo@kernel.org>, <geert+renesas@glider.be>, <lukas.bulwahn@redhat.com>,
	<alexanderduyck@fb.com>, <richardcochran@gmail.com>, <kees@kernel.org>,
	<gustavoars@kernel.org>, <netdev@vger.kernel.org>,
	<linux-doc@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
	<linux-hardening@vger.kernel.org>
Subject: Re: [PATCH net-next v7 4/5] net: rnpgbe: Add basic mbx_fw support
Thread-Topic: [PATCH net-next v7 4/5] net: rnpgbe: Add basic mbx_fw support
Thread-Index: AQHcEw1/LwXdpHe+ukGdpS5U/+GtHLRuGj+AgAANZQCAAAhvgIAADDUAgAAUwYA=
Date: Fri, 22 Aug 2025 08:05:50 +0000
Message-ID: <bb6826d4-2e17-4cdd-a64f-26d346224805@microchip.com>
References: <20250822023453.1910972-1-dong100@mucse.com>
 <20250822023453.1910972-5-dong100@mucse.com>
 <9fc58eb7-e3d8-4593-9d62-82ec40d4c7d2@microchip.com>
 <7D780BA46B65623F+20250822053740.GC1931582@nic-Precision-5820-Tower>
 <8fc334ac-cef8-447b-8a5b-9aa899e0d457@microchip.com>
 <A1F3F9E0764A4308+20250822065132.GA1942990@nic-Precision-5820-Tower>
In-Reply-To:
 <A1F3F9E0764A4308+20250822065132.GA1942990@nic-Precision-5820-Tower>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
user-agent: Mozilla Thunderbird
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=microchip.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: SA1PR11MB8278:EE_|PH0PR11MB5952:EE_
x-ms-office365-filtering-correlation-id: 06e81864-c1e1-4523-a12d-08dde152b56e
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam:
 BCL:0;ARA:13230040|7416014|376014|1800799024|366016|38070700018;
x-microsoft-antispam-message-info:
 =?utf-8?B?NnFDK0J0TmdHbGR1SkltREwvYm85SlNSZ0QvQldDdHp4NGZRZG81ZUFqcStH?=
 =?utf-8?B?MXJ3NWJraHhUUldFc0JwZXJTQmFLZmFMMXZJVnF3M05RaURiWWc3bjYzb3Vs?=
 =?utf-8?B?cEJEU3B4c3VNdDgybll0WHhCUE9lTkorUE5MY29LZERSMWhrRXNybW5OWjdI?=
 =?utf-8?B?VVkzaXBjTDBoSUtoc1AxcVl0MnJUdTBMTGlZMXVsQkUzL1Z2OElsWk83NFJu?=
 =?utf-8?B?ODFaYlVqZDkrNm1Xb3BSOC9qaHJoQk0wR2pSUFg0VTNkY3ZYOVpoR2kyWUly?=
 =?utf-8?B?V1M2UnI2TGhkV2ZJZ2U4M2hqbXhSZGFxQWVac2V3MHZSelhRU21KejM2ZmJl?=
 =?utf-8?B?aThmOElTOHF3S2FzazRJcHRlYngzYXZEajJGOFI2Nmg0TzJ1bkZPTVhJT01F?=
 =?utf-8?B?TVdkZjFLZkxTME53NEpaSlVDamZVRHdWTm5hb1pvQjRzR3BlYVFMc0N3UG1r?=
 =?utf-8?B?ekg2MXNKaitKUWs4UVlRTWVDV1J4emMvUkV4WXplcXRudktlRitMRkFwN0xT?=
 =?utf-8?B?UitUNTY1bWw5WnIwWitSMjJuVnRuckV0U3N5ZUZvVi8wbk1EQ1g1RVdMYXhk?=
 =?utf-8?B?RExYbXI3UWo4Q09FL0toYWd1Q2JIRC8xVnRpRXFOcnFpK2ZibVBQbkFRWGQ0?=
 =?utf-8?B?d09mS3RmTVZzWDlxWGR5S3VmbU5HNHYvUzcwNUJham80WWZSL2N3YWg4RHNL?=
 =?utf-8?B?RU9kcGlvQXVVY2hlVGpsaEZLNW02MXZjZkQxSlczQzRVYVJncVE1eW9VZXA5?=
 =?utf-8?B?SHEvQVRkelBGVmdraExNNUhtT2Jlc1FLVnZEcm1zWTRWemlZMlNSN2F5RVMw?=
 =?utf-8?B?V05UbG5ldGZCSE5ENU9adDU4WjZ6eklNeXZpWWJzTkR0SmJUZjNGbnVRQ2cy?=
 =?utf-8?B?TUpIRi9pejlXMldjckVMdGpaNXNSN212Z0tBK1B2cE9VdU9NdFhNclFmbmx4?=
 =?utf-8?B?cmxONEpxdmxFeXY4aGFrTWVLOVdYdWRUMS9QQ0c2Zng5d1FydzZOZjBCejRw?=
 =?utf-8?B?NkdmNHVYbnFQanI3SWdHeFAxbmNQamVwQlZrU1FVNzROZzY1d1RNQUl6M2t4?=
 =?utf-8?B?MVl4NWZ6NUwxa01RVExRZjF3WTZocDBVa21RS3FQejU5NUtsQ0pHNVZLSDVq?=
 =?utf-8?B?dWs2QVcvWVVnc1RQNm0yaHpaQjVQdm9UR0lYeDRFamtxUmpDWnE3TFg5N1V2?=
 =?utf-8?B?ZnAwS0l3QjBHSHBmdEw5WkZhdDBiTitabVF4dDdRN3UyYUp3ekNXUTdPbXlK?=
 =?utf-8?B?SUl3T3V4MjhrZm9PS3c1a2I5T1lSNHNtNlhrVXlML2oySzYwYnBBMG9wNGZj?=
 =?utf-8?B?ODNLajkvSFdUQ1ZtYlJuZmxUbnZneVR4Y3had3JFQ2liOGcxYk1XVGE0Tm8w?=
 =?utf-8?B?UjlJVEl5a09sQkhQbzlJb0grbTdDNktYcWpVczlDMENyN1BQWGZmbkNLMFFn?=
 =?utf-8?B?dWdEZGFQTUd2Z2F0U2RTd21Hc0QxNjl5YWJvQ05JU2tZRElDT2g2ak5JcmR5?=
 =?utf-8?B?Q3h6M213c1JRQzdMUEREN21laTkzUmovVWZWMktJejdIemZnZXc0UWlZMTRP?=
 =?utf-8?B?dWM2ek1zUktxSjZTamdkR3kvVmgxK2JmTU12RFdJcVV6ME5Nck9pSDFtelRE?=
 =?utf-8?B?R0dPTURtM1hDRk0reWU4cVBNcTF1UWFCMURhMFlhWFptYS95WDFHSitQY2NP?=
 =?utf-8?B?cG9UZXRqZkd4VkQrOXJuSmd1NHRmM0xyWDZ3RzdJOE0rdENBejZNUnFwSmtG?=
 =?utf-8?B?U2c1MUJKMmRiL1N1aElEb1Fvb2VpV05yS2pNZkp2M2JmYitPaFo0R1dOekV3?=
 =?utf-8?B?TmJESmVqRnJKTFVXYUliRFVzdkk4Sk84bWJDQ1JuR3V4b21hRUdXbHMyMllO?=
 =?utf-8?B?aUFkZlYzMzVIL0FjbDNtVmV5QmVadnIyT0xsTlc3RSsrald6c1l0M3RhZjBT?=
 =?utf-8?B?NWVsRzdQT3I5ZXZvUUpUZW5JQm1BS3dqUEtFa2duMVR1bU5PSUp4UWZTM2Ry?=
 =?utf-8?B?dy9ldjlFT1hRPT0=?=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SA1PR11MB8278.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(7416014)(376014)(1800799024)(366016)(38070700018);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?utf-8?B?RVpSOUczRHBLb21BclQ5NGtVZFdVZHJxNU9QQldwSkJaM3V5emxKNGZHbjdK?=
 =?utf-8?B?dFl0aXl4a1NFWEhpR2Q2aTJMZE9ZVTl6L2NETUU4aERXd1RLV2N0dWRFNXNO?=
 =?utf-8?B?TkR4RHI3bW1iaEJTbWxCUkN2SHdhcm9qNWNwNGVJczBpY0x1akJ2eUNBNG1T?=
 =?utf-8?B?M3JDYkZjRFByOXc3bzJaYVpFWUtsQ0FtNWtVeE1DWUdMSklpOU83L3FIMXQr?=
 =?utf-8?B?U3NtWDlFV0ZhcTYzRmI3Y09yVm5lRHh3ajFFeC9HZFZXYVgyWnBWVDRhQm8w?=
 =?utf-8?B?K2lKbXBNTndJTysyL3dXdzVQM2JQTnl5U0tndTdFV3lnSElkbVNDZ1lYT3ds?=
 =?utf-8?B?cXRZNDdZWXRFSDNtQ1crZjN3b3pzVXpUcUF1Wkpsdmp4WnZkdDFzTmFkdUhh?=
 =?utf-8?B?UGMzbFpUSHU4eml2S01XeTBRWkh6N3gwQStJQk5VeGZvejR5OHdYTmM3VUIr?=
 =?utf-8?B?Q3R0dGRVRkJkV1Y4cmkyR0Fzak15YU4yanB2WGxPcXljQ0VlSzhRcU50NDZm?=
 =?utf-8?B?N3ROV3cwdTFSRDNCVllEOUNLd3Jkb1Fod2Z2VCt4MXRpOHFNYXkxUHg3ZDYw?=
 =?utf-8?B?SWJWUlN5RXEzMXdmNEVIRlRsZW1ZaFJKakNqSERUb3FUVU81c2lZVEdQWXNJ?=
 =?utf-8?B?M0FDYTFlSXpMK3ZjUUFBQ3YrQks5aGJjbjcxZncyQmhyZ0RxNkRIN09pS3JU?=
 =?utf-8?B?NDFoeUJ2Y1ZTMDNPWEZ5bE03WjRPTC9OdjBKSGdUNjk2VDJYZG56UmVXQ3A2?=
 =?utf-8?B?eXRhT1N1ZnRndnZ4QWhxdno0RktoN3lVQjFRbVZvWk1aT2VIS0pKaW0xeG1h?=
 =?utf-8?B?YTBmajg2K2dNUENlc0JZR2FwVW12SVJZNzVPN092RmZDR2VtM0JaRUZVMUFO?=
 =?utf-8?B?dzlhRmpkMy9tQlZPc2MweHpzTnZ5MVlFRzMzWEdJZmFqaGl1akxTenZjU2Zt?=
 =?utf-8?B?a1ZTZFhSZUd0VFg1NjZrdURCQ3VQSFNWcDJ4dGt0Q2Q4anlZRm5CZFFhZXB2?=
 =?utf-8?B?Ynl4K0RYOGFDT3ZhTVNtNXczU2h3czBkaXlYR2RDMzZxajhVK3ZQQjhQU0Nx?=
 =?utf-8?B?UCtUOVovZ2IvOWJKTThSa2JMUjVSTTVUNEtCdmZycythOUJrc09WSmtyMGxj?=
 =?utf-8?B?N2xJc1FQTWJUSEJyNWpaTUZxM1RlNEh1dHlDWTloMURpek1CYndqTTI4d2dD?=
 =?utf-8?B?TTYzMEpFVGFGbGsvaS85QlM3MlY2VVhtUTJnVVJQdityTDBoMk9XYmdSTm92?=
 =?utf-8?B?VEV3ZVVNanV3RXJKNVlMZUR1cERmRkpPOUtzbCsrQjk1MHhCM1dWZGM2SjQ5?=
 =?utf-8?B?ak91aURPUUl2Q21Yc2UxcGR1Tkk5dzBFdUoySE1SUkhIdExURXBIeGZxdlFM?=
 =?utf-8?B?U3EweTN3R0FLSnZCWE43RnNyQzVXVytEeWhjcEFRLzFVbFRJZFNHVjA0Mmk0?=
 =?utf-8?B?Yzl0cmQ5Z29ySHpJQms1TVlUdlJJZFVSL01RZGp2M29HT3FnaVNuS2JBdEQ3?=
 =?utf-8?B?ZnRsM3kwWUxjYWdKTEtjRjhxcG5GM1JUVk16OUd1cm9Nd3F2Q2p3UkgvbTFE?=
 =?utf-8?B?V045a1hQOVdYNmhjSEV6OWladmttWEVNOE5OWEhyL0ZXYkVGeXR0ZE40MUdu?=
 =?utf-8?B?MVlYWTRWejhGMEY5N0NRcTB1K3NnTlVJc2JiNk15dkkxZkdjdVZMNm9JLy9m?=
 =?utf-8?B?a05SN29vMTNlendtNTJ2cDRqVkFSZThSMmpMOGdGemdwNkJTT0Y0aEowUlZi?=
 =?utf-8?B?T0xCaTFVQllRN2JacXd5Vm83aWdHeW16ZmZmSE41eG5qb3dvR0ZLaG9zY2hi?=
 =?utf-8?B?aUErTWJwMytVS3I2WVRaYXQrRlZLMlgrSEFNS1RYb1RPc0VUWGdLbFFWNFBk?=
 =?utf-8?B?R29ZSFcrMGUwenl2OXpGdnZRVUtadzIyR3JGdllqcUVpTDU2WDc2Q3R0Sm1a?=
 =?utf-8?B?TVYyanRwQTlSNTJBWW9yL21UTjFCbk5Ub2FQVTBsUW1CYURhajkzQlJ0aFh4?=
 =?utf-8?B?bnUrV1Y5MmdVaktiSFdJbGUxK1d6d1UyTzU4d3Q0OS9oVEVSdkE5bW4ybFJj?=
 =?utf-8?B?OXE5UERoTUlVOHBxWkNnOTk2STlISDc2Sml4bTNXd05WZWgwd0lhWDBhZVlp?=
 =?utf-8?B?b1pFVVp5eC9QQWVONUdjMGhoRzZHWlBjUXRISTFlSng4U09ycm5ORlR5cHA4?=
 =?utf-8?Q?l8VXEgZXj1rUxLQ4ux8yol4=3D?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <D22099E1AD411E41A74D8BB70B4D450B@namprd11.prod.outlook.com>
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
X-MS-Exchange-CrossTenant-Network-Message-Id: 06e81864-c1e1-4523-a12d-08dde152b56e
X-MS-Exchange-CrossTenant-originalarrivaltime: 22 Aug 2025 08:05:50.3516
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3f4057f3-b418-4d4e-ba84-d55b4e897d88
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: Y2sQGmtNW5wWGDGDPs+8dIuX4T90EWnkKTcBTzjrcoUjXcshVuxWJHtzdcGxGifm374q0eBwIcoc1uBr795ndWU2jw+g10N/HPW1ddHX4iBxGWTZP5qCSNT+s5V8Ac28
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH0PR11MB5952

T24gMjIvMDgvMjUgMTI6MjEgcG0sIFlpYm8gRG9uZyB3cm90ZToNCj4gRVhURVJOQUwgRU1BSUw6
IERvIG5vdCBjbGljayBsaW5rcyBvciBvcGVuIGF0dGFjaG1lbnRzIHVubGVzcyB5b3Uga25vdyB0
aGUgY29udGVudCBpcyBzYWZlDQo+IA0KPiBPbiBGcmksIEF1ZyAyMiwgMjAyNSBhdCAwNjowNzo1
MUFNICswMDAwLCBQYXJ0aGliYW4uVmVlcmFzb29yYW5AbWljcm9jaGlwLmNvbSB3cm90ZToNCj4+
IE9uIDIyLzA4LzI1IDExOjA3IGFtLCBZaWJvIERvbmcgd3JvdGU6DQo+Pj4gRVhURVJOQUwgRU1B
SUw6IERvIG5vdCBjbGljayBsaW5rcyBvciBvcGVuIGF0dGFjaG1lbnRzIHVubGVzcyB5b3Uga25v
dyB0aGUgY29udGVudCBpcyBzYWZlDQo+Pj4NCj4+PiBPbiBGcmksIEF1ZyAyMiwgMjAyNSBhdCAw
NDo0OTo0NEFNICswMDAwLCBQYXJ0aGliYW4uVmVlcmFzb29yYW5AbWljcm9jaGlwLmNvbSB3cm90
ZToNCj4+Pj4gT24gMjIvMDgvMjUgODowNCBhbSwgRG9uZyBZaWJvIHdyb3RlOg0KPj4+Pj4gKy8q
Kg0KPj4+Pj4gKyAqIG11Y3NlX21ieF9nZXRfY2FwYWJpbGl0eSAtIEdldCBodyBhYmlsaXRpZXMg
ZnJvbSBmdw0KPj4+Pj4gKyAqIEBodzogcG9pbnRlciB0byB0aGUgSFcgc3RydWN0dXJlDQo+Pj4+
PiArICoNCj4+Pj4+ICsgKiBtdWNzZV9tYnhfZ2V0X2NhcGFiaWxpdHkgdHJpZXMgdG8gZ2V0IGNh
cGFiaXRpZXMgZnJvbQ0KPj4+Pj4gKyAqIGh3LiBNYW55IHJldHJ5cyB3aWxsIGRvIGlmIGl0IGlz
IGZhaWxlZC4NCj4+Pj4+ICsgKg0KPj4+Pj4gKyAqIEByZXR1cm46IDAgb24gc3VjY2VzcywgbmVn
YXRpdmUgb24gZmFpbHVyZQ0KPj4+Pj4gKyAqKi8NCj4+Pj4+ICtpbnQgbXVjc2VfbWJ4X2dldF9j
YXBhYmlsaXR5KHN0cnVjdCBtdWNzZV9odyAqaHcpDQo+Pj4+PiArew0KPj4+Pj4gKyAgICAgICBz
dHJ1Y3QgaHdfYWJpbGl0aWVzIGFiaWxpdHkgPSB7fTsNCj4+Pj4+ICsgICAgICAgaW50IHRyeV9j
bnQgPSAzOw0KPj4+Pj4gKyAgICAgICBpbnQgZXJyID0gLUVJTzsNCj4+Pj4gSGVyZSB0b28geW91
IG5vIG5lZWQgdG8gYXNzaWduIC1FSU8gYXMgaXQgaXMgdXBkYXRlZCBpbiB0aGUgd2hpbGUuDQo+
Pj4+DQo+Pj4+IEJlc3QgcmVnYXJkcywNCj4+Pj4gUGFydGhpYmFuIFYNCj4+Pj4+ICsNCj4+Pj4+
ICsgICAgICAgd2hpbGUgKHRyeV9jbnQtLSkgew0KPj4+Pj4gKyAgICAgICAgICAgICAgIGVyciA9
IG11Y3NlX2Z3X2dldF9jYXBhYmlsaXR5KGh3LCAmYWJpbGl0eSk7DQo+Pj4+PiArICAgICAgICAg
ICAgICAgaWYgKGVycikNCj4+Pj4+ICsgICAgICAgICAgICAgICAgICAgICAgIGNvbnRpbnVlOw0K
Pj4+Pj4gKyAgICAgICAgICAgICAgIGh3LT5wZnZmbnVtID0gbGUxNl90b19jcHUoYWJpbGl0eS5w
Zm51bSkgJiBHRU5NQVNLX1UxNig3LCAwKTsNCj4+Pj4+ICsgICAgICAgICAgICAgICByZXR1cm4g
MDsNCj4+Pj4+ICsgICAgICAgfQ0KPj4+Pj4gKyAgICAgICByZXR1cm4gZXJyOw0KPj4+Pj4gK30N
Cj4+Pj4+ICsNCj4+Pg0KPj4+IGVyciBpcyB1cGRhdGVkIGJlY2F1c2UgJ3RyeV9jbnQgPSAzJy4g
QnV0IHRvIHRoZSBjb2RlIGxvZ2ljIGl0c2VsZiwgaXQgc2hvdWxkDQo+Pj4gbm90IGxlYXZlIGVy
ciB1bmluaXRpYWxpemVkIHNpbmNlIG5vIGd1YXJhbnRlZSB0aGF0IGNvZGVzICd3aHRoaW4gd2hp
bGUnDQo+Pj4gcnVuIGF0IGxlYXN0IG9uY2UuIFJpZ2h0Pw0KPj4gWWVzLCBidXQgJ3RyeV9jbnQn
IGlzIGhhcmQgY29kZWQgYXMgMywgc28gdGhlICd3aGlsZSBsb29wJyB3aWxsIGFsd2F5cw0KPj4g
ZXhlY3V0ZSBhbmQgZXJyIHdpbGwgZGVmaW5pdGVseSBiZSB1cGRhdGVkLg0KPj4NCj4+IFNvIGlu
IHRoaXMgY2FzZSwgdGhlIGNoZWNrIGlzbuKAmXQgbmVlZGVkIHVubGVzcyB0cnlfY250IGlzIGJl
aW5nIG1vZGlmaWVkDQo+PiBleHRlcm5hbGx5IHdpdGggdW5rbm93biB2YWx1ZXMsIHdoaWNoIGRv
ZXNu4oCZdCBzZWVtIHRvIGJlIGhhcHBlbmluZyBoZXJlLg0KPj4NCj4+IEJlc3QgcmVnYXJkcywN
Cj4+IFBhcnRoaWJhbiBWDQo+Pj4NCj4+PiBUaGFua3MgZm9yIHlvdXIgZmVlZGJhY2suDQo+Pj4N
Cj4+Pg0KPj4NCj4gDQo+IElzIGl0IGZpbmUgaWYgSSBhZGQgc29tZSBjb21tZW50IGxpa2UgdGhp
cz8NCj4gLi4uLi4NCj4gLyogSW5pdGlhbGl6ZWQgYXMgYSBkZWZlbnNpdmUgbWVhc3VyZSB0byBo
YW5kbGUgZWRnZSBjYXNlcw0KPiAgICogd2hlcmUgdHJ5X2NudCBtaWdodCBiZSBtb2RpZmllZA0K
PiAgICovDQo+ICAgaW50IGVyciA9IC1FSU87DQo+IC4uLi4uDQo+IA0KPiBBZGRpdGlvbmFsbHks
IGtlZXBpbmcgdGhpcyBpbml0aWFsaXphdGlvbiBlbnN1cmVzIHdl4oCZbGwgbm8gbmVlZCB0byBj
b25zaWRlcg0KPiBpdHMgaW1wYWN0IGV2ZXJ5IHRpbWUgJ3RyeV9jbnQnIGlzIG1vZGlmaWVkIChB
bHRob3VnaCB0aGlzIHNpdHVhdGlvbiBpcw0KPiBhbG1vc3QgaW1wb3NzaWJsZSkuDQpJZiB5b3Un
cmUgY29uY2VybmVkIHRoYXQgJ3RyeV9jbnQnIG1pZ2h0IGJlIG1vZGlmaWVkLCB0aGVuIGxldCdz
IGtlZXAgDQp0aGUgZXhpc3RpbmcgaW1wbGVtZW50YXRpb24gYXMgaXMuIEkgYWxzbyB0aGluayB0
aGUgY29tbWVudCBtaWdodCBub3QgYmUgDQpuZWNlc3NhcnksIHNvIGZlZWwgZnJlZSB0byBpZ25v
cmUgbXkgZWFybGllciBzdWdnZXN0aW9uLg0KDQpCZXN0IHJlZ2FyZHMsDQpQYXJ0aGliYW4gVg0K
PiANCj4gVGhhbmtzIGZvciB5b3VyIGZlZWRiYWNrLg0KPiANCj4gDQoNCg==

