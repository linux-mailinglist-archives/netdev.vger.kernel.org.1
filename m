Return-Path: <netdev+bounces-125027-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 0B0FA96BA8F
	for <lists+netdev@lfdr.de>; Wed,  4 Sep 2024 13:28:37 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 8E7261F232A4
	for <lists+netdev@lfdr.de>; Wed,  4 Sep 2024 11:28:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 22A4D1CF7CB;
	Wed,  4 Sep 2024 11:25:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=microchip.com header.i=@microchip.com header.b="HTsVMoxc"
X-Original-To: netdev@vger.kernel.org
Received: from NAM04-DM6-obe.outbound.protection.outlook.com (mail-dm6nam04on2069.outbound.protection.outlook.com [40.107.102.69])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0F8241CF2AB;
	Wed,  4 Sep 2024 11:25:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.102.69
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725449143; cv=fail; b=X6YeGLrXNv5lsnItu15ag7V50kDgZIN9IUVjFFYU/hiYbZnxh40/cndxhHXHGHbXCcpiAFuvwFcEEBSB23NDDaRKmRhK3uFgyD7FltIe2p4gxbbLxNSdS5x2DXWTiXD4ZJY8FEyiGOmIG3elheOYE/lL9MHR0lWdI5+EhtH6oFE=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725449143; c=relaxed/simple;
	bh=KpyLnRb7w4/kfmqrV7teXDppIMLKRjqp9jxIy/1C6to=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=Lp4ZIsXO3gE98OHb2zwEj4MYRuC1Zy/mPxB8GDTYenXv0Z0unok2q3OVTr8fPhGTTbRcq+le5Rx8UWC6LMTU29XsFuCVBXSyy7pLw+atBiN/JFLhS6VmuZp4QLgGa27FJw1RDTQTz1GS28+oeI9NTvRDp+dEe7H+B4dv6ZKNX0Q=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=microchip.com; spf=pass smtp.mailfrom=microchip.com; dkim=pass (2048-bit key) header.d=microchip.com header.i=@microchip.com header.b=HTsVMoxc; arc=fail smtp.client-ip=40.107.102.69
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=microchip.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=microchip.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=N+Ri4+tJTgjWBWtUqIR2e6RSaXZEzZGAr51lGVHkkt626t5NicvXvLIkg5+kUAY1wP8zOLKr/t164/cq8uOtH/r2RsoDO8Yg6Sv3/fiXmZWl4N0zQ+RpFEZgoaaoKY/U9WWKm1CB7BIVmbOiFByBi8osUtSuqP807EXuUxBUz8wP8G0PEB06vL9w5bY8Z+UXknGjt/+geyEhgGufrXCXeJRYmTdV4W6b6KdrlkfKS29UbmbtcSPIOwHG4w0Zwgbix5DZEQfLWO0vv0DhU9ga1Q5a0u/oPsmOgHzcxL2vZUUq47ztpWVlI+izgar4RJcxhVo7+X043lbGp0C5jptqJQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=KpyLnRb7w4/kfmqrV7teXDppIMLKRjqp9jxIy/1C6to=;
 b=Bu9d79ieIvVc5OP/H3+2Bxnk9TQWWPkLfL/NujzBgZDvOwYCM/jvpLj/UzAtbXo+4nOz90dSYY8aqkQIJUzHB8zq/XK35JA+rqL3X3zVwoheB+hFO0L/556ydcz0+RRBCy5adZ9JKlhEMmKKkbRYzllSSQsw7h9YX6YBrrhBVjXiqhWckKyHhFOh9wgjTwzuc4JYExBI9tLYpLjXChBqGYs3sP+v8r6RPUAnFWuqEtccqXwfPoxMf9NA+UyssU1ayINOMvT9UjGzSnwIYSAqQZ+aAdv4vQGHe7yym0XIKBvOOsJYNg13mKm+lXNHQdPzgJqWXH2/wARoUuzIT/rzDQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=microchip.com; dmarc=pass action=none
 header.from=microchip.com; dkim=pass header.d=microchip.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=microchip.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=KpyLnRb7w4/kfmqrV7teXDppIMLKRjqp9jxIy/1C6to=;
 b=HTsVMoxc5QoolWh03rt7A/gUSxpeR1rBm8X+pciOIO3cTtMh4Exx5fL0SdpUCzgxWs1U2YDS8cPMNAgvhEC1+W5aUVFgKIDr1uQCsKOaUVwBq8ZS33gYaP5eok0fwFlZ3BAXxna1E+DebQvKTwgnlaZhgP1hWu1kfK9NY8QfWLo0NBv+tT0XESxe8ySRWFralfmRYuQ3NtpzifwyzJUU2odGaxd+opeFHYrPAm7EdNS29BM++XFIIwqCvoqbSS509hTStu8MegtqFuwrG2ojFrpkm4H1QreE2cNI6QJzosmsAJ5RlgXWPbkLl5RZHkIKagWDgIao1vsojLn7ZYjIxQ==
Received: from SA1PR11MB8278.namprd11.prod.outlook.com (2603:10b6:806:25b::19)
 by CY8PR11MB7946.namprd11.prod.outlook.com (2603:10b6:930:7e::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7918.27; Wed, 4 Sep
 2024 11:25:37 +0000
Received: from SA1PR11MB8278.namprd11.prod.outlook.com
 ([fe80::84fa:e267:e389:fa9]) by SA1PR11MB8278.namprd11.prod.outlook.com
 ([fe80::84fa:e267:e389:fa9%5]) with mapi id 15.20.7918.024; Wed, 4 Sep 2024
 11:25:37 +0000
From: <Parthiban.Veerasooran@microchip.com>
To: <horms@kernel.org>
CC: <andrew@lunn.ch>, <hkallweit1@gmail.com>, <linux@armlinux.org.uk>,
	<davem@davemloft.net>, <edumazet@google.com>, <kuba@kernel.org>,
	<pabeni@redhat.com>, <ramon.nordin.rodriguez@ferroamp.se>,
	<netdev@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
	<UNGLinuxDriver@microchip.com>, <Thorsten.Kummermehr@microchip.com>
Subject: Re: [PATCH net-next v2 5/7] net: phy: microchip_t1s: add support for
 Microchip's LAN867X Rev.C1
Thread-Topic: [PATCH net-next v2 5/7] net: phy: microchip_t1s: add support for
 Microchip's LAN867X Rev.C1
Thread-Index: AQHa/UVsk7N7cPnfk0yr27b2znlQErJFq+AAgAHT6AA=
Date: Wed, 4 Sep 2024 11:25:37 +0000
Message-ID: <0e150f38-b2a2-46f5-9c64-8c72dd4a5471@microchip.com>
References: <20240902143458.601578-1-Parthiban.Veerasooran@microchip.com>
 <20240902143458.601578-6-Parthiban.Veerasooran@microchip.com>
 <20240903073054.GO23170@kernel.org>
In-Reply-To: <20240903073054.GO23170@kernel.org>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
user-agent: Mozilla Thunderbird
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=microchip.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: SA1PR11MB8278:EE_|CY8PR11MB7946:EE_
x-ms-office365-filtering-correlation-id: 9567560d-00a5-4b45-2d15-08dcccd44ca5
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SA1PR11MB8278.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(7416014)(376014)(366016)(38070700018);DIR:OUT;SFP:1101;
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam:
 BCL:0;ARA:13230040|1800799024|7416014|376014|366016|38070700018;
x-microsoft-antispam-message-info:
 =?utf-8?B?aU16Q0VmMjBGN2VTT01nTWZ0UWp5blV5cHVmdDd0YTNaM011WFppdnkzWG9v?=
 =?utf-8?B?M0ZwT201VERGQ1N3aXNvWkkza3dUVmtzb1NvZlNUdjFkcXRwL0RTOTkrdy90?=
 =?utf-8?B?c25HZTVXTVpyc2N1bm5nYUk2SUxXT3E1QVIwR0wyZ2NDWEpXLzFUaDdyaUo3?=
 =?utf-8?B?bHRoK0hoaDhwN2ZSZFhIeVVUWVExdUtoNXQ2cUdqeUgzTGJMbTg4RlNoSjZF?=
 =?utf-8?B?N2ZYWmlZclpTWDVwWnVXV2FQTkxSQ21TT3ZSTFlDamRIbWtXVDJhQjNwRTQ3?=
 =?utf-8?B?M1BiTDVQM05hOTdIZ3E0T3MwcGFKbkVEcHVGdjJISkZaeEN3dFM1dXlNNnp6?=
 =?utf-8?B?YmZSZ2gwQ1UyZ1pXTnBleWxaRTFUc2tES0ZNdEtITWQ2SnloQWhmTnFjanVx?=
 =?utf-8?B?SEFFc0FJcVNScEZRaXRHckR2bUErY3plL2RLNDFTNS9tYUtPdlNtYm9FR1BT?=
 =?utf-8?B?dUlDSlYyZStqODJYV1VKTTFuck1hVDJGbGRUM3F4VjFQUVJBV29ITVdZU3JX?=
 =?utf-8?B?bFBLaXZ0ME8vRW9tK2RYQ2ZkTEpPM1NZV085c09BRm1DS3hWdFQxVks3Ulll?=
 =?utf-8?B?dG5pMXRvV1FuMlJkL3dxcUo5Wm83RVhqaWdBeVhGci8raWl2N1laY2JqM1NI?=
 =?utf-8?B?WDFEbGhNZm1yN1dQRndsQzhvZm5iQ2JacEE1b1k3MktSRnppeWZ3WjFZSDgr?=
 =?utf-8?B?eW03V1UyS05iZU5xdVQ2bFlNK25NRlJZRnY0QS9ZY2ttR053Vi9hcFRxY29Q?=
 =?utf-8?B?aldkQmYyL3VRUEJhWkRBclYxMWR3MTJrTDFBSkRUNUhLM0kycy8rQldHQkhG?=
 =?utf-8?B?dzVNeWo2d09OU3VNRmZaTWVYSk14TWpVbTVpblNBeEpuSTg5K0pBRGVFNFlw?=
 =?utf-8?B?azRqQ2VLcjRmQzRETWFvT1VyVEtxd2gxWFpPa2I5cVlKTXViS0YxaGZESThz?=
 =?utf-8?B?WkhOZzlXbllKWVR5ZG8xb1dSWnluODN0cjlLOFlDb2JlQ2FreG4xd1VVcWM3?=
 =?utf-8?B?a3F3bHA4ZGxzMCtoQ1hNUFRRclVWM25DeUNyTHFBSGdGOTNvcGVha1YvZVQv?=
 =?utf-8?B?K3diYXlJM211ZXd1SFRCVDlNU0NXV1E2ci9ITjE0aUNPazNIL3RaQjZaUjN2?=
 =?utf-8?B?anpMWDJob3VnVS9BUi9GOSttNnNXQnh1dUtHZkE3SWF0QllrL2R5RjN5L3Jx?=
 =?utf-8?B?YmZST29RdERNR3ZuVStuWUN1QmIyTEplRy8vUVhYMlBFVEtOTEM4bWs3Z1VD?=
 =?utf-8?B?RG9YcjF0L3VIQXQ1TW1LTkk2SjhXalVBUSs4T0ExdWRpcW5JbHhQRXVtNVJR?=
 =?utf-8?B?ZEtaTjJkTFFnK1hoMzJ4ZTQ4blhuNElSdG1ybTl1K0tmQkVpM3RGNDgydnQ2?=
 =?utf-8?B?TVJqN3RCQnBUOXBiZG41NXVqcnNla2wrU0ptVW44NVBCUThyS2ExM3VYL0Jz?=
 =?utf-8?B?SjdLc2lYdmpKZFFJN0RldUpwa2FOWjdLMzBiRytNVXZ3WDhxbHE5V0lOM1JT?=
 =?utf-8?B?L3ZvRnhkUElxOEhUcGlzbUsrUlJPK0N3RFNhemQvTFdSQnI2dUhkME9iQkN5?=
 =?utf-8?B?dU8vc09TY2FBVjF5UU1nWDJ4eGhKU0QxeEVPYm5RSk5wc1M4ajJtUXJENG93?=
 =?utf-8?B?ZnlMOWtiaFFLYlB4eWdTNENtK0w3ZG1rWWdSNFZNbmFRUHB4WjhwanZSZ1hL?=
 =?utf-8?B?S01iVCt5Z2lQbjcyV2N2SEN6MG9mL3JPM056V09VZXdYSmU0Wnc3aFQveGc3?=
 =?utf-8?B?d1FOT0kzVVhHbEF0TTA3L2lRNm1scVJMZmZUWkNNYkYxVFl5UkJaL29DK1dM?=
 =?utf-8?B?MFU4UmxEMWZVNW8xa1FMa0V2U3R5RzVLUllYb0lKcFdrWjRnVGpLazdCM0RK?=
 =?utf-8?B?bmkrdTF6UEhqdUxoZ1JUbERkaUJicGV5Z1ZxbTN4UnRtNDFud3UyL2Q0bVMv?=
 =?utf-8?Q?BeAb1u5y3e4=3D?=
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?utf-8?B?VDV4UFEwZEJob2tTV2lyTTRSbDh1VzlrdHY0NHNmeDIrM05jL3QxMWxpcGx5?=
 =?utf-8?B?N1N1R3ZLZEJ4Nk9uYldtZWJCYWdzbCtQT21ERWhiYXkrTXExdzZwTFh0aEhI?=
 =?utf-8?B?RUkwTlJzMmRWRm5KbnMvY0ErczludzVMS09NbnFhTDZoZGY0R3VPb1ZHOFEy?=
 =?utf-8?B?a3kwQ3ZIZHE0MEVwTU96VWJiUlBpVW5JQXdsK3cyNkE5TXBtNGRjOXc1dkZX?=
 =?utf-8?B?OWl3Ujg1RWw3Qit2SE1CK3FKVkgwdEdyN1RRUVNWN1d2NkxwL3BHM3JNSUU3?=
 =?utf-8?B?b25ZdnlIcUNuSElEM0cwL1lUWHFUblE2OHdCYmxwMEtzK0l2b085YW05bzgy?=
 =?utf-8?B?cHZUaEZjdTd5c1RhM3hPbXRzdUJOQlVjMjFGMWlCbGVTZHRuVms3OXQvc0o4?=
 =?utf-8?B?eUNKeXVyVXY2Y3ErTm92UEFjd0lnL3NGdGxBN3RvbXYxK2JIblY0YXBCNXpD?=
 =?utf-8?B?enpnby9CTGdReCt5TGhGNktaQlpzWDQ5NjlHSTN0dXNiMFpUTUNBUlRQRUUx?=
 =?utf-8?B?ZExaSHNvYXRzVnp4QjAzbmNGblplSmdTNkh1NDhRelZSdVV1UHdMQ28zdXYr?=
 =?utf-8?B?SGwxZzJiMDJqZUtIU0czVkR4WFRPSnFSVXJXdFNCSGJXbEJ4RkgzTWF1NFky?=
 =?utf-8?B?dGZVVzd4bm43c3RpVlhWWk94SXRmRGdLM0FqU2FCNnRKc21vY0Y1MVJqNDZs?=
 =?utf-8?B?QU42N0lMSk1QeUI0TmEwbmxrU1FMTGhuZHpSUVRyVisyYVRQN2wyZkhnbnlQ?=
 =?utf-8?B?YzlsNjRDaTNLRzhseHFMdlREVk50MnlaQ2JnMENrbG5adXIweXlRVzlIRE5G?=
 =?utf-8?B?aldWUmkzS2svbVdibVI2TlJMMzJmcDdLMG1jMXRCV3RTQThFYitiSjNEcERY?=
 =?utf-8?B?NDFuTUQ5WURmMEtiQktTcFlPTjBqb05mdFR1ald3WTd6UFpkYU1VOFdpd1A4?=
 =?utf-8?B?YVBRSGRsR2xmMDlvaE54elV0d1RPNjBsNmFOZjBHZCtYUTROQVpobDNzVlli?=
 =?utf-8?B?cXR1MlAxNFhaRVpYeEdLemN5KzNXOWhVU0tDbGdGVEw2cTNOaHhJbk1Kaytr?=
 =?utf-8?B?aVNkRVQ0cjJpOWdmU01IR0V1citCaVJYQ2JtY2YyWFhtZmhUV1NaaFlwejhi?=
 =?utf-8?B?NUpnbVdyakYzYmVncjlvQlNyT3IzZ0hKaWZ1SU1Qdm01UXNDWk1naWJRbjY2?=
 =?utf-8?B?aEcrZm5sczVDTXgvZDgvNkhpVmRuSG9GRUw2WHhmZ2pObHd0b3dkMmhwc2pB?=
 =?utf-8?B?VVNRNmhmaXVOMkNwYmFWR3ZZMWRtVjI3YmNCUTdOSzNLSG1TK3o2ZHQwOXpC?=
 =?utf-8?B?UW5uNUxCS0xPVlpzeitraktCZTd5ZVRHd3hOL0xUdDR1aWpYd1kzYVUrSDFQ?=
 =?utf-8?B?aHRaRGo3YVFjem5qVWlWQXBwaGQra21vZkdqdmhTcUppejc4YjJ5Mitwd29N?=
 =?utf-8?B?SlZJUDV4dFhjTC8zOVg0QmpvZlZDdENXbTNOOUFZZTRXYnFkZ2t5eVNNQS82?=
 =?utf-8?B?RDlrdzc4T0xRSU5xNWN1b3ZtUlUwVnpJSG5GcXBJMjhraDlTdThQMkVGZE0r?=
 =?utf-8?B?RDh1b044OGVqN0NjTHZYQXJBd2xBTUZ3aTg3enBSN1d3ZE12WmJmVTdsaktK?=
 =?utf-8?B?dTllcG83ZHdaNDdBNVhIN2tQZGUvOUtxUW51ZmNOVitraGxzU2x1K0JRZHBL?=
 =?utf-8?B?cHdMckI3eTdyWW5BZXV1NmtqcXV6OVhKQlYvUkhLQy9qV3FDenNOZEJIMFBP?=
 =?utf-8?B?RFltRFZSYUNSNS9BK1UzZ0FUeDRnVkRNZmJTZzBKemFwSnM4MFJUaDBiVWds?=
 =?utf-8?B?ZmVqSWJHZ2JWczh3b2FCSjd1dTc0L2VHQ21SeFFyRmR2WnE3V1hnL3F0aDhs?=
 =?utf-8?B?Uk5hdC9ycG5YbUZ4QVhvVkRtTEdOQ3F3NWFIR0VJemJNVlFsSjVMenoxZjd2?=
 =?utf-8?B?RFJOaVhqc3FIc2FSYmdBUkZRUlR6V3B2OWNqOWlraHRjbFJ3TlFReFpLckZH?=
 =?utf-8?B?OTkrRlRmTHI1MFVmcEI5dEhkUzdaeUJJQkM1RXIyMXQxczVSYk9kNDJUOXFD?=
 =?utf-8?B?aUxIb1V2UTFLcmY0aWlyaWZlS0RtenZXYkFNalNXbFByYzBPaVVINVU5M1lv?=
 =?utf-8?B?Nmw3V3g0cENBeXVYNWF2Rit6SHhSV01NUzVSbXlwY3FXc3g5RGM1dGtvaU5Z?=
 =?utf-8?B?TGc9PQ==?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <96B49BE02843D74FB7D0AA829B75525E@namprd11.prod.outlook.com>
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
X-MS-Exchange-CrossTenant-Network-Message-Id: 9567560d-00a5-4b45-2d15-08dcccd44ca5
X-MS-Exchange-CrossTenant-originalarrivaltime: 04 Sep 2024 11:25:37.0497
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3f4057f3-b418-4d4e-ba84-d55b4e897d88
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: +Ehv/gDmZsSWPTIoZjyIG5SEUcd7jqnC5L+wgKNFIBigXGbJSD90RSHULB+tbQ7lEx5Ak+O3Q4w5ZZ9noAec9Io8sRKdTgKJ+AKb3A0phJmvIDjFG3RYssSQlXXjbMnL
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY8PR11MB7946

SGkgU2ltb24sDQoNCk9uIDAzLzA5LzI0IDE6MDAgcG0sIFNpbW9uIEhvcm1hbiB3cm90ZToNCj4g
RVhURVJOQUwgRU1BSUw6IERvIG5vdCBjbGljayBsaW5rcyBvciBvcGVuIGF0dGFjaG1lbnRzIHVu
bGVzcyB5b3Uga25vdyB0aGUgY29udGVudCBpcyBzYWZlDQo+IA0KPiBPbiBNb24sIFNlcCAwMiwg
MjAyNCBhdCAwODowNDo1NlBNICswNTMwLCBQYXJ0aGliYW4gVmVlcmFzb29yYW4gd3JvdGU6DQo+
PiBUaGlzIHBhdGNoIGFkZHMgc3VwcG9ydCBmb3IgTEFOODY3MC8xLzIgUmV2LkMxIGFzIHBlciB0
aGUgbGF0ZXN0DQo+PiBjb25maWd1cmF0aW9uIG5vdGUgQU4xNjk5IHJlbGVhc2VkIChSZXZpc2lv
biBFIChEUzYwMDAxNjk5RiAtIEp1bmUgMjAyNCkpDQo+PiBodHRwczovL3d3dy5taWNyb2NoaXAu
Y29tL2VuLXVzL2FwcGxpY2F0aW9uLW5vdGVzL2FuMTY5OQ0KPj4NCj4+IFNpZ25lZC1vZmYtYnk6
IFBhcnRoaWJhbiBWZWVyYXNvb3JhbiA8UGFydGhpYmFuLlZlZXJhc29vcmFuQG1pY3JvY2hpcC5j
b20+DQo+IA0KPiAuLi4NCj4gDQo+PiBkaWZmIC0tZ2l0IGEvZHJpdmVycy9uZXQvcGh5L21pY3Jv
Y2hpcF90MXMuYyBiL2RyaXZlcnMvbmV0L3BoeS9taWNyb2NoaXBfdDFzLmMNCj4gDQo+IC4uLg0K
PiANCj4+IEBAIC0yOTAsNiArMjkxLDU4IEBAIHN0YXRpYyBpbnQgbGFuODY3eF9jaGVja19yZXNl
dF9jb21wbGV0ZShzdHJ1Y3QgcGh5X2RldmljZSAqcGh5ZGV2KQ0KPj4gICAgICAgIHJldHVybiAw
Ow0KPj4gICB9DQo+Pg0KPj4gK3N0YXRpYyBpbnQgbGFuODY3eF9yZXZjMV9jb25maWdfaW5pdChz
dHJ1Y3QgcGh5X2RldmljZSAqcGh5ZGV2KQ0KPj4gK3sNCj4+ICsgICAgIHM4IG9mZnNldHNbMl07
DQo+PiArICAgICBpbnQgcmV0Ow0KPj4gKw0KPj4gKyAgICAgcmV0ID0gbGFuODY3eF9jaGVja19y
ZXNldF9jb21wbGV0ZShwaHlkZXYpOw0KPj4gKyAgICAgaWYgKHJldCkNCj4+ICsgICAgICAgICAg
ICAgcmV0dXJuIHJldDsNCj4+ICsNCj4+ICsgICAgIHJldCA9IGxhbjg2NXhfZ2VuZXJhdGVfY2Zn
X29mZnNldHMocGh5ZGV2LCBvZmZzZXRzKTsNCj4+ICsgICAgIGlmIChyZXQpDQo+PiArICAgICAg
ICAgICAgIHJldHVybiByZXQ7DQo+PiArDQo+PiArICAgICAvKiBMQU44Njd4IFJldi5DMSBjb25m
aWd1cmF0aW9uIHNldHRpbmdzIGFyZSBlcXVhbCB0byB0aGUgZmlyc3QgOQ0KPj4gKyAgICAgICog
Y29uZmlndXJhdGlvbiBzZXR0aW5ncyBhbmQgYWxsIHRoZSBzcWkgZml4dXAgc2V0dGluZ3MgZnJv
bSBMQU44NjV4DQo+PiArICAgICAgKiBSZXYuQjAvQjEuIFNvIHRoZSBzYW1lIGZpeHVwIHJlZ2lz
dGVycyBhbmQgdmFsdWVzIGZyb20gTEFOODY1eA0KPj4gKyAgICAgICogUmV2LkIwL0IxIGFyZSB1
c2VkIGZvciBMQU44Njd4IFJldi5DMSB0byBhdm9pZCBkdXBsaWNhdGlvbi4NCj4+ICsgICAgICAq
IFJlZmVyIHRoZSBiZWxvdyBsaW5rcyBmb3IgdGhlIGNvbXBhcmlzaW9uLg0KPiANCj4gbml0OiBj
b21wYXJpc29uDQo+IA0KPiAgICAgICBGbGFnZ2VkIGJ5IGNoZWNrcGF0Y2gucGwgLS1jb2Rlc3Bl
bGwNCkFoIHllcywgd2lsbCBjb3JyZWN0IGl0IGluIHRoZSBuZXh0IHZlcnNpb24uDQoNCkJlc3Qg
cmVnYXJkcywNClBhcnRoaWJhbiBWDQo+IA0KPj4gKyAgICAgICogaHR0cHM6Ly93d3cubWljcm9j
aGlwLmNvbS9lbi11cy9hcHBsaWNhdGlvbi1ub3Rlcy9hbjE3NjANCj4+ICsgICAgICAqIFJldmlz
aW9uIEYgKERTNjAwMDE3NjBHIC0gSnVuZSAyMDI0KQ0KPj4gKyAgICAgICogaHR0cHM6Ly93d3cu
bWljcm9jaGlwLmNvbS9lbi11cy9hcHBsaWNhdGlvbi1ub3Rlcy9hbjE2OTkNCj4+ICsgICAgICAq
IFJldmlzaW9uIEUgKERTNjAwMDE2OTlGIC0gSnVuZSAyMDI0KQ0KPj4gKyAgICAgICovDQoNCg==

