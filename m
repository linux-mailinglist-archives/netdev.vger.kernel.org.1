Return-Path: <netdev+bounces-193807-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 2580FAC5EE4
	for <lists+netdev@lfdr.de>; Wed, 28 May 2025 03:50:12 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id BB8321BA47A2
	for <lists+netdev@lfdr.de>; Wed, 28 May 2025 01:50:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E113B1A2643;
	Wed, 28 May 2025 01:50:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=aspeedtech.com header.i=@aspeedtech.com header.b="XRaDHrx/"
X-Original-To: netdev@vger.kernel.org
Received: from OS8PR02CU002.outbound.protection.outlook.com (mail-japanwestazon11022140.outbound.protection.outlook.com [40.107.75.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 044C410942;
	Wed, 28 May 2025 01:50:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.75.140
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1748397006; cv=fail; b=mo5tCEZh7bB0YFx0zdg6Zhwy4on9dVsbCCwDbpnS9yMjhWY6FdDMeA8vFnToMnWyNlGojk+yRg3gZ40UTq08HLi+jtO3j8Qee8k9ee4K0fq6jk5ktBSWDRGWMFMH2quIbQiInWTNTBFeSvo1vxWP8UcANv8Glf9t1303JRhQt+U=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1748397006; c=relaxed/simple;
	bh=/o+RCouCo5ZVC2WN/3Xud3a2CWZ0lNgzZlJRMQBLv8I=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=tU7WrcZxncTXHJ1Amx0facm2J/yFkoEH8q9bXsjx75VuKKG1xvv27ho5r6jc5KdQzZj9LLyqtDvRMVj3d/+AkyY8979+IbrARj2jlgrSj4l8jNIP7KLhWJ0ayvCu7sZV0c0L6JtdbH5O9MkxUL/HTGjun4ifuVKMHAEQUVbqWLk=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=aspeedtech.com; spf=pass smtp.mailfrom=aspeedtech.com; dkim=pass (2048-bit key) header.d=aspeedtech.com header.i=@aspeedtech.com header.b=XRaDHrx/; arc=fail smtp.client-ip=40.107.75.140
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=aspeedtech.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=aspeedtech.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=MObpab1Agxxqa0e4PV0b6eXJUCTS5M/ioBrhtGj3ETB8uK2+olD+fWQUnxGHhI/zQWfrl2xCnDm/Kb+njAiVoKbjU+Oqljsh9B3shQr+wlI3zdV8wil/6nh6aFSttCdVK/cwa2ZqmVYANa5fWgTa6klzO72o7SZSyEvN810E2MCK7z69+3E3hLqy9SXsMNi3cgOWCEQImKF3agX1l91PdfVLaWXJPJk9Ww7Uia+guQtGKfB3vHwhvfE1xwMzv8Kz6543v2jYhOUrUq3RduZTYPtveDsI7ZnUFLPRy61W+k84BqCVYSYKVt/KtlWSbFaXg+SUGmFTS6Nk6df4XuCo1Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=/o+RCouCo5ZVC2WN/3Xud3a2CWZ0lNgzZlJRMQBLv8I=;
 b=A2jzGPGdcDchTg78qmdqZA4mqdkb4YrEHiXOBc0z/lgfN/ySASgddmfTxJM7k4ziApQearMS18OEF2DWeShz5onLsMhqzrHh/uKZewdR/BPhuEVL5Vhk4JiLuN/EeNbHrF6HDT4k+fqNzeIAAGQgjW3QKMUDBo5bkUJGFG7IgmPDiG5qqR0c2BuuhFd7vqyXlZq/uP7fCQJvN6d351MKjvfwpeOKTC1xYt0wqYEaPhND6AVwA0XHQ1duIVnLf20sjzaTcEfpzWsmZbe4LGvh3y/9DnAFRT5nykU5hk9sOAwxa2d+tA8La4LTKYP3nfYxQDh7562ENHGFnfraULLSpw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=aspeedtech.com; dmarc=pass action=none
 header.from=aspeedtech.com; dkim=pass header.d=aspeedtech.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=aspeedtech.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=/o+RCouCo5ZVC2WN/3Xud3a2CWZ0lNgzZlJRMQBLv8I=;
 b=XRaDHrx/VuRMwnDiQWPaJq/ZYCp3/oyTl7qgI80Odg8cyMBdn+664rqFokCRiVNb9vNME76nZMfzLrTsHsmQJll8wscJMow1CNNURzq8G6Z8lLWSa9yKI8835ukNqIiDiQ9UHbodCGamygWDQc+seMfRh0FOcWLzPSkd2Tp4s0DP3s4Be3yQO3bXK8rM0nzjKSFeOpuuTrEt4pTaT7ph6J/n6dljE5dphG5hszdwxvyEy5lyHUbZUDIONTH6+CWbdeR45BwYMyCGFoYNjZA86OqPE1nXm8XW+B3uO7P0Ex0TscN/7FnKSs4WKvwL7I2wJ6IXwxMm5grm4F1YmUk75g==
Received: from SEYPR06MB5134.apcprd06.prod.outlook.com (2603:1096:101:5a::12)
 by SEZPR06MB7345.apcprd06.prod.outlook.com (2603:1096:101:255::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8769.24; Wed, 28 May
 2025 01:49:58 +0000
Received: from SEYPR06MB5134.apcprd06.prod.outlook.com
 ([fe80::6b58:6014:be6e:2f28]) by SEYPR06MB5134.apcprd06.prod.outlook.com
 ([fe80::6b58:6014:be6e:2f28%5]) with mapi id 15.20.8769.022; Wed, 28 May 2025
 01:49:58 +0000
From: Jacky Chou <jacky_chou@aspeedtech.com>
To: Conor Dooley <conor@kernel.org>
CC: "netdev@vger.kernel.org" <netdev@vger.kernel.org>,
	"devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
	"linux-clk@vger.kernel.org" <linux-clk@vger.kernel.org>,
	"linux-arm-kernel@lists.infradead.org"
	<linux-arm-kernel@lists.infradead.org>, "linux-aspeed@lists.ozlabs.org"
	<linux-aspeed@lists.ozlabs.org>, "andrew+netdev@lunn.ch"
	<andrew+netdev@lunn.ch>, "davem@davemloft.net" <davem@davemloft.net>,
	"edumazet@google.com" <edumazet@google.com>, "kuba@kernel.org"
	<kuba@kernel.org>, "pabeni@redhat.com" <pabeni@redhat.com>, "robh@kernel.org"
	<robh@kernel.org>, "krzk+dt@kernel.org" <krzk+dt@kernel.org>,
	"conor+dt@kernel.org" <conor+dt@kernel.org>, "joel@jms.id.au"
	<joel@jms.id.au>, "andrew@codeconstruct.com.au"
	<andrew@codeconstruct.com.au>, "mturquette@baylibre.com"
	<mturquette@baylibre.com>, "sboyd@kernel.org" <sboyd@kernel.org>,
	"p.zabel@pengutronix.de" <p.zabel@pengutronix.de>, BMC-SW
	<BMC-SW@aspeedtech.com>
Subject:
 =?big5?B?pl7C0DogW25ldCAxLzRdIGR0LWJpbmRpbmdzOiBuZXQ6IGZ0Z21hYzEwMDogQWRk?=
 =?big5?Q?_resets_property?=
Thread-Topic: [net 1/4] dt-bindings: net: ftgmac100: Add resets property
Thread-Index: AQHbyWmbzc4DO9TZvEidHe0NP79ULbPbqjGAgAod+ZCAAMf9AIAAwfmA
Date: Wed, 28 May 2025 01:49:58 +0000
Message-ID:
 <SEYPR06MB5134B705B97DA376D60DDA149D67A@SEYPR06MB5134.apcprd06.prod.outlook.com>
References: <20250520092848.531070-1-jacky_chou@aspeedtech.com>
 <20250520092848.531070-2-jacky_chou@aspeedtech.com>
 <20250520-creature-strenuous-e8b1f36ab82d@spud>
 <SEYPR06MB51346A27CD1C50C2922FE30C9D64A@SEYPR06MB5134.apcprd06.prod.outlook.com>
 <20250527-sandy-uninvited-084d071c4418@spud>
In-Reply-To: <20250527-sandy-uninvited-084d071c4418@spud>
Accept-Language: zh-TW, en-US
Content-Language: zh-TW
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=aspeedtech.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: SEYPR06MB5134:EE_|SEZPR06MB7345:EE_
x-ms-office365-filtering-correlation-id: b640ea60-94a4-4fd3-e5c4-08dd9d89f40f
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam:
 BCL:0;ARA:13230040|1800799024|366016|376014|7416014|38070700018;
x-microsoft-antispam-message-info:
 =?big5?B?bnRESHl6cFhLOEYrN1k4UGphZ0VJZW5Ua29OWHBqUlRFWWkrOHhMZE9DS2pMdHBs?=
 =?big5?B?S2duN2ZVZnVSeXM1YmdlSTNLRjZhMDlibERxdVNRQkxSTCt1TXpqYjdJSDdzZDF1?=
 =?big5?B?TVJZR2VSYVBWZ2EwN2xHdW9SQXBhL0gzWUtGS3ZiZTBrWTk0dW5ha1hSREZlVGVl?=
 =?big5?B?bEZvS08wOGtSd05JR0RCZ3VrQnRzSmF2a29ocjFtWHVkeW1yNThXV3Q1cU5ZTk9I?=
 =?big5?B?ZTVycWRMMWpicjhqTEUzcHQzUnBxcVFiaUE1MElMMDI1dE10dC9oSVU0bXBYT0V3?=
 =?big5?B?dXNEeUpTUk5qQmlOWmlTM0Y4aW1YejNzaDlBWnV0cHNqQWZNNjJaZCt6K3N4Smtx?=
 =?big5?B?TjEzelpTb1lRZytZeWZKSEsxMll0M3dnS01GQndRWU9uYmhUUWg2MnNJaEVENTRm?=
 =?big5?B?c3lRWFZzbnMxYkRyZUxPVHF4U0dWS21rQmV0Vk1mdHdxWDFRN28wSlZTRklWdWgx?=
 =?big5?B?SmhwTFlKeXdsL05pKzZDNWhsTm1pRnFoVGhwbE9uTVpvdmIvbU56YXJsK0UyTlE4?=
 =?big5?B?RnZWUzNXczA1STI0SkYwc0JvbWx6cmYwNG43OUVPYTB1L3B1ZHZkVGxMVVlRWlZ5?=
 =?big5?B?ckxXU3k1UDVlWFZkLytuZkUwb05OZmRWNjcwQmhwQzFla0REazlWTUx4RE80Nm1V?=
 =?big5?B?QnpTcnIzMUZXRSt1MU9OeFhsc3YyWVhnaG5OVDkrV1BwRTNYL1A1alFVZXVYY0Jn?=
 =?big5?B?ZVRIUmhMUHJTWEZzU0JERkZSVllTTDBuQlhXZno4alJCZHl6alBKQTdOejlBN3Nr?=
 =?big5?B?VUJXMHhPWGZUWk5FdkUvWnptc2tEaG9YU1FEM2hHYXBJWmRGMUR4U3hrVWJtd2pv?=
 =?big5?B?eHdFU1hTTGoyY1RSVFlYU1ZIQkpoTU1EUk9NbHc1eTFNNTdlalhkYlNNYUFCSUVx?=
 =?big5?B?anBMeVNmUUdqb2RTNWhzWGpJY1M5MHFVZ1czRjRldTNTay9QSkNFN01yREFBazZ3?=
 =?big5?B?NTc3dlBQQVh5anp1c3N3NHF4MUpXSEdrMjgvZDJnRDllTXRzTEtRZGpvN3RUNERz?=
 =?big5?B?c2hwVkMrYVhDQUM0MmdxaDZRRDBjUFFjd0NlblZYQytpRzhOckZsV0Q4Njh0a1Q0?=
 =?big5?B?Q0FNandMSitIdHFzbnNTY1luM1o0NFN4Z3g3VE4vV3N6RmZRUStzK0xINzBXS1Qz?=
 =?big5?B?bFRYbU04eUh6dVllMzBQb1R3MlNpVDlaUWJVYTV6bTlnL2ZkNlJvTVVaZ21jRXJF?=
 =?big5?B?VUsvOHF4VGozYUNxOUhrSXRKUFZ3UFpGVlljbnloZTY0MW5KOGhxcm5MS2FUbWY2?=
 =?big5?B?NTdHVFgyU0hUcUREQU5VZHgyWXJZRklBeld5NzdPaG42UEgyUHZkMnVMWE9qcUFH?=
 =?big5?B?VGZFU0oxYzdvdW85Wk8rbUpoeU04SUNIT09YUURkajBCV1hyWWw0cGM2b3ErWFJx?=
 =?big5?B?dTZ0MmR5K3lYUjBBbHZIUTVLeUxGWEZCRk01eVNiamt1RVhmaXYzM2x6dXg5Qndo?=
 =?big5?B?OTRhUFdsV1J6ZisvTjVlZEZ5MDF4RWVOdDhTVlVUV2h6MVJoSzU3eW9BNG51cEVk?=
 =?big5?B?Z3RLZTBWd0JTY1diL0lib3haeXFuV1BUK2R6dndqQUI0bFE1Y3dYSThhUFFZZ1dU?=
 =?big5?B?Q0lrOTAzK1VpakJvbDd4UlErS0Z3QnE4dFJnaW1IenM2dmZRZXhZRkloREZoWkEz?=
 =?big5?B?MjB3b0FFdjU2S05PaUMrZEFYbndYdG5jejBHRHBKVC9wc0RjUnhQK0NTL0Z6ZTA1?=
 =?big5?B?ZGtwUVdEa1VkN2NTdWQvdTJrTkQreFJDTlNBeHYrc1BFTy9pUVRNdi9mSGQxR3pT?=
 =?big5?B?aXVVRmR5a2ZHNXNsRmYzRFpuUkpucUkvWngzaVhtM0hIcWFHWUF1MThYMFlkZ1Jx?=
 =?big5?B?VUk2TWtVbEovMG82VnVwODkxUUV4TEY0dVU1RWZrZmcrQVFnSG5BeXJNRWFUa0R3?=
 =?big5?B?cUQ2N2Z3PT0=?=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:zh-tw;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SEYPR06MB5134.apcprd06.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(376014)(7416014)(38070700018);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?big5?B?dTRNSzN6aUZFaC85M0NzRVBmTnZXVktnRmgzanBlbE1FVUpORVdjdEZUaDZnYzR5?=
 =?big5?B?V0lrQzlzdFZqVWg5dmhFNUl6RDM2Ri83SFZMMUlidlN6dlFjTG9xdXAwb1F4K040?=
 =?big5?B?T042WkVodzg1Wml4Qm9PZ0VwYUwxUldQelpFTGY5Y2drclFvNjdRUjM1QUZSTWpH?=
 =?big5?B?Skp5bWlXYkJtZnMrSnVXS2c2WkJmL0Z2aWhOWDlOOWowWFAyeDRIUFdMcjhTNy9C?=
 =?big5?B?ZjRBNXFRSXZpdlhNMlZDLzZDYXpnUW9xbTRxSjcwRENqNXc2RkNxWFB1VnZtWTV6?=
 =?big5?B?NTh5TlNRaDI3MkhuclZadUwyZ3VSYnEzd2lycTJzanlLYlNoZytTRGh1ckxVNTBR?=
 =?big5?B?Zitib2Q0d0xVcUJjYzlPTC9oVEhFcEp4bks0bWs0T1p1bzJpYVNWRXRDNWhKeWpt?=
 =?big5?B?di9lZXBMbWw2cmVYaVdqNkdSMzRtS0UwYnZSaUczQkFRdCsrRjVER3pUcjVhcW8z?=
 =?big5?B?TzM4V3htVzdLbk52ekxaM0loSWE3OWVaSmxFQnI5VUloaGJhR2Rtd2NtQWwwVEUz?=
 =?big5?B?NENnSlo1R2VDTVlkQmhxSjJIR216WXhmbmZUMWlIcjNrbGgrMERUZ3NNbUQ1djg4?=
 =?big5?B?RjAxTCtUcTRLMzdFNE5HemN3a250eXJXMFNXR05rTlVodDA0VUJJRTFsZS9nYkZH?=
 =?big5?B?VmEyWXVIL2hvaCt6S1gySVpwNlN5VnByN0Z1cWRtUG1aeUpENTFMbFV1dzFQWm5Z?=
 =?big5?B?dmIxeTBrQ2pnMnNIQ1BncnhUZ2dobkd4R3FaTHBZVjlya3VlMnlSK0dHZlVvdUVy?=
 =?big5?B?VHVUNmhMWVdjSnp5YXFJKzFueGR4YnJmWWxiNVBmQzN5anZUdnM2UU12NURhTXdt?=
 =?big5?B?YW9ROVZEc2QwL2NoTzZQTmtub3FDNzM3czFnNk52ckV5Rmgva01BM1VQWVc4cmxJ?=
 =?big5?B?enlKNXdSc3BodU9xbFhrdTVma21UckNaTVhkdnFYNlFUU3J0OXpzR3NqNnZVVDNx?=
 =?big5?B?bS9weFg0Y2ZYL0FmeTZnNnpzUGhiMU5raGNnbWpsTVUwdEhvYW42Syt4ZS9VNFlk?=
 =?big5?B?eXZyQTBEZGFlZHAxMTZ5UHd6ZXhmd3F4eVRUemp2ZHR6SHRzNE44ck82dW1LN0VE?=
 =?big5?B?Uk80TDY0R1B0Z3F1WW9XL1VDTVBKZzRYeGhrQWlXT3pIbDRJbFRXRkpUeDVxQ2xo?=
 =?big5?B?YythRFVNWGRmejNjS1ZCTXBBSkdYcmt3RU84MnljZ2t5WGJNcVNtUUdod0ROMTdN?=
 =?big5?B?ZzRiT2pkQk53UFVPakFhOTI4YmxQaHc2MWYzdmlCTzJPNW1JQno2UXpYazNOWWsz?=
 =?big5?B?TlovNjZTY1dpYmphenVDUzJ6VERFbmZqdCtQbjNPWTFCSXdETldpZ1U5Z1I1SFlC?=
 =?big5?B?dVBTdWdOTDcxWUZwV1hpMVMrNGRMRkdUekErUlBlbk5Fa0tsT2hmYVY4bFRjNFcx?=
 =?big5?B?ZmlvMFQ3ZEJhZW16SnhqNzlkK29nRlFrdFh4Y2sveUJBb1pSeHFialN5V0F6d3oy?=
 =?big5?B?MUlmNWdsVm9ZZGhjdmV6bEN3MGRqNVliVmI2b2p6cnI2cjFPMGtNSHJabGtCUVJH?=
 =?big5?B?UzljT09RK3NzWkJBdW0ydGU4MEJDTSsxUW1DajJpc201OHpQN1BVbXd6OCszUDVx?=
 =?big5?B?emRQeVB0bERXWE96bzVUdWRMTHlJMlNDTjVDVDNCdnlsTUlTK3hvMlExN2E4STZw?=
 =?big5?B?Mk1zVDdvdkR0c0RtQnoxdnF1TUp0alY2dnB4RUdORnFoRWZOcEZMUHJTdm1QdkZN?=
 =?big5?B?bjVZelRFME11OHdldTJUZ1o2VlA2K0RIelh0bXRZNFYyZFpHRU1zQmsraHJXdXVX?=
 =?big5?B?eW1hWGd0NXYrcTRiQllwaGo2R1VyUnExekVlSTFiMm5rVXNORzRIOUF1VytNbXNp?=
 =?big5?B?OE5ZTGtXekZzR1hVRDdZd09pODNuSGF0RUJXZEdLd1VpZEpaNjY5NkhEVlNWV0Mx?=
 =?big5?B?aDUxejVKcWh6a05OOHlmOU1iSHczMDVTUFdGYlJPL0JxSFBzY1h1YnZPa3RzWWpQ?=
 =?big5?B?VTFnWDZMc0cyTmJVc2ZuMHNxeUs5blpIMmtrTkxLeUhkLytSVy9IcVRNUGFnV1hR?=
 =?big5?Q?CsGk/G2Vyp7vTCCU?=
Content-Type: text/plain; charset="big5"
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
X-MS-Exchange-CrossTenant-Network-Message-Id: b640ea60-94a4-4fd3-e5c4-08dd9d89f40f
X-MS-Exchange-CrossTenant-originalarrivaltime: 28 May 2025 01:49:58.7054
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 43d4aa98-e35b-4575-8939-080e90d5a249
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: D5+9q5BXPQRXrAwo8NVw6cJyYPAFwXgWeqG1dgGA5GQyfvc6uTKsszi2IcdorMGnB6PwSHap9EnJwC3fozWdHr9PlyqxPCmwss0M9E3r9m4=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SEZPR06MB7345

SGkgQ29ub3IgRG9vbGV5LA0KDQoNCj4gPiA+ID4gKyAgcmVzZXRzOg0KPiA+ID4gPiArICAgIG1h
eEl0ZW1zOiAxDQo+ID4gPiA+ICsgICAgZGVzY3JpcHRpb246DQo+ID4gPiA+ICsgICAgICBPcHRp
b25hbCByZXNldCBjb250cm9sIGZvciB0aGUgTUFDIGNvbnRyb2xsZXIgKGUuZy4gQXNwZWVkDQo+
ID4gPiA+ICsgU29DcykNCj4gPiA+DQo+ID4gPiBJZiBvbmx5IGFzcGVlZCBzb2NzIHN1cHBvcnQg
dGhpcywgdGhlbiBwbGVhc2UgcmVzdHJpY3QgdG8ganVzdCB5b3VyIHByb2R1Y3RzLg0KPiA+ID4N
Cj4gPg0KPiA+IFRoZSByZXNldCBmdW5jdGlvbiBpcyBvcHRpb25hbCBpbiBkcml2ZXIuDQo+ID4g
SWYgdGhlcmUgaXMgcmVzZXQgZnVuY3Rpb24gaW4gdGhlIG90aGVyIFNvQywgaXQgY2FuIGFsc28g
dXNlcyB0aGUgcmVzZXQgcHJvcGVydHkNCj4gaW4gdGhlaXIgU29DLg0KPiANCj4gImlmIiwgc3Vy
ZS4gQnV0IHlvdSBkb24ndCBrbm93IGFib3V0IGFueSBvdGhlciBTb0NzLCBzbyBwbGVhc2UgcmVz
dHJpY3QgaXQgdG8gdGhlDQo+IHN5c3RlbXMgdGhhdCB5b3UgZG8ga25vdyBoYXZlIGEgcmVzZXQu
DQoNCkFncmVlZC4NCkkgd2lsbCByZXN0cmljdCBpdCBpbiBuZXh0IHZlcnNpb24uDQoNCkphY2t5
DQo=

