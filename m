Return-Path: <netdev+bounces-130838-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 46D3098BBB0
	for <lists+netdev@lfdr.de>; Tue,  1 Oct 2024 13:58:27 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 29F031C20F98
	for <lists+netdev@lfdr.de>; Tue,  1 Oct 2024 11:58:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D5FB51BFE1A;
	Tue,  1 Oct 2024 11:58:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=microchip.com header.i=@microchip.com header.b="UNkMd0r2"
X-Original-To: netdev@vger.kernel.org
Received: from NAM11-BN8-obe.outbound.protection.outlook.com (mail-bn8nam11on2087.outbound.protection.outlook.com [40.107.236.87])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4FB5419DF53;
	Tue,  1 Oct 2024 11:58:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.236.87
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727783897; cv=fail; b=WKlTecpwQamQKwlLw5Lfpk4w478C+4cLAsroM/ZlO1IzzRLWaaNzxe8tLDpyJM/cwtH6q74dh6ex4+T1Tu6mCXbcZ9spu/jvoDaPMcTIXX95P1dGCGHakWemOAk1tRtLHyN1baHPftjIBbt3W6EY38eK/XnmLK3T9W1mEU1gPyU=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727783897; c=relaxed/simple;
	bh=T6pwd+jpUXYt3xerWNCcDt5at9vgo6E/YFukBiCvLJk=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=ovPiT0+2OWzregSxrZPvQZADII1qiJ7sMVy/YdJHC//XTl2n9Da9Lx7vkc3Bg/P+C9OiquWLoh92IosJZ/zfe9SlbKLtb1vyGOakU31wKOazmYg0DZyY7a6Aqid49k075TYDAoHDbg1huHeF8NP556buOffrkA8pK02eFp0E7Hk=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=microchip.com; spf=pass smtp.mailfrom=microchip.com; dkim=pass (2048-bit key) header.d=microchip.com header.i=@microchip.com header.b=UNkMd0r2; arc=fail smtp.client-ip=40.107.236.87
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=microchip.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=microchip.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=qSebpC2ughoaIJBBHC15DiQgHgvPfmthSduIIDX0I8rtxPcgGEEaa77J+Gdbj99sTEhjzGI18JgADRRkvaYU3wiiYdZAYygNmTE7OcRff52c9r+RGLg7YRjVc7ut1ABY4b+su+rCoFrvVSTn8zCeLl4DwyTN8uIgLxFUgGnLxG0fW3cMF/atxy9qP/E7Mxf78u9MeWR2yLUid1UMf7oqhLPH1ldnqrdXLad7zgh9DeeQHtW46anGNCgYaDILptchehpG3CTbzS2Vk1Wa58SmiVFLW/LPWFdnJK4khYRzDbpjLzb4CA9SKEBftA/RG0L4G9OxCTAxL4ZIVGmr4cBVsQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=T6pwd+jpUXYt3xerWNCcDt5at9vgo6E/YFukBiCvLJk=;
 b=pYyjuIt0JBQzEGamIXD2aif8MbNvypxPCFcCDm8mYS8XOJhhPFE4kV1yJIHdvu/kdbOxIw4JFwLok7BH2Z9AUdYE9bIswgkS205+g2Ev6LXbz1nIE7ULsEV/XuII5yVUPCEbaq8LckEiANVAEpIAxdj62KiYcj/P1LKQSo4L+ptz5g3PKXTKunYW+4W1P0sbN0kQpwlxtr4gbZLGAdF+0B0gDoYNpC+LSdLgqhvae9HmKNG3U86whxNeBObMgUVTf/4k6RO7/bQcr1deS294Zi6PHqzaDMFvoOM5+XDhfCn7rzHwfhK+uIi+l+FTaZo1JVYaDNqSuXOyxJj+oFW8ww==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=microchip.com; dmarc=pass action=none
 header.from=microchip.com; dkim=pass header.d=microchip.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=microchip.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=T6pwd+jpUXYt3xerWNCcDt5at9vgo6E/YFukBiCvLJk=;
 b=UNkMd0r27MlUKR1NKoAl9JKW0AUNzaWipOvhwQkqROTtFpLiBtBwQxq/nMo6Ptc6pSz4IjGQOnxw8wWQLrKOvNtau+hcmKrhKel02fnVZMmaGJS02N1VhaFpeMWFfD1kS0kQzP8Nh1glffgMC+Ts4/0BXEsd79kqDdlPIqp6K6cs2EC0CEIly3SFtzClrv23OqDWl94G/5kzStY3rYlLKQ7fl8DaMZ0XP312iXvuHz8slcVfDOCpIcATUHbpnm2XuuSudRQwYFQGIlu8kTx8WfOzERGqKGaEqGb0QVv+7RtHXelu1GTobh6Vc7mGgSptdWpLIzKTeJppjBudcgBWaA==
Received: from SA1PR11MB8278.namprd11.prod.outlook.com (2603:10b6:806:25b::19)
 by DM6PR11MB4564.namprd11.prod.outlook.com (2603:10b6:5:2a0::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8005.27; Tue, 1 Oct
 2024 11:58:11 +0000
Received: from SA1PR11MB8278.namprd11.prod.outlook.com
 ([fe80::84fa:e267:e389:fa9]) by SA1PR11MB8278.namprd11.prod.outlook.com
 ([fe80::84fa:e267:e389:fa9%5]) with mapi id 15.20.8005.026; Tue, 1 Oct 2024
 11:58:11 +0000
From: <Parthiban.Veerasooran@microchip.com>
To: <Divya.Koppera@microchip.com>
CC: <Arun.Ramadoss@microchip.com>, <UNGLinuxDriver@microchip.com>,
	<andrew@lunn.ch>, <hkallweit1@gmail.com>, <linux@armlinux.org.uk>,
	<davem@davemloft.net>, <edumazet@google.com>, <kuba@kernel.org>,
	<pabeni@redhat.com>, <netdev@vger.kernel.org>, <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH net-next] net: phy: microchip_t1: Interrupt support for
 lan887x
Thread-Topic: [PATCH net-next] net: phy: microchip_t1: Interrupt support for
 lan887x
Thread-Index: AQHbE03lgADHDJuJ0kOnB6FdBgmww7Jxy8SA
Date: Tue, 1 Oct 2024 11:58:11 +0000
Message-ID: <e585b195-3213-46d2-807c-5906d5332502@microchip.com>
References: <20240930153423.16893-1-divya.koppera@microchip.com>
In-Reply-To: <20240930153423.16893-1-divya.koppera@microchip.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
user-agent: Mozilla Thunderbird
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=microchip.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: SA1PR11MB8278:EE_|DM6PR11MB4564:EE_
x-ms-office365-filtering-correlation-id: b0201faa-80ef-4c7a-bbdd-08dce21052e4
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SA1PR11MB8278.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(376014)(366016)(38070700018);DIR:OUT;SFP:1101;
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230040|1800799024|376014|366016|38070700018;
x-microsoft-antispam-message-info:
 =?utf-8?B?S0drYnVlVTcrVkJxRGY2Uzc5LzRkdUJmQzlxOHZvU0svSVpKSGJLMXd3SEV1?=
 =?utf-8?B?ZS95Wml3M2JIdElUU29aR0JJZXdBMjVxZ0ZhZzFVNnZvRk5VZ2thNm0xUlht?=
 =?utf-8?B?QnN2bzlPTmRKc0xqRkZNSk84cXFtRGFFM0ZQUXExSUJZbkNrTy9hQjFSNGhK?=
 =?utf-8?B?WGtCQng0OGVuZXI2czcxeUE4YWM5TXhBUkZwa1JpTmdKWkd3NXFTN090NXEw?=
 =?utf-8?B?UWxLV0I0aERsTWxBaVhyNC9XMzR5MkdVZUZRSkR0SGVYMUQxaFdKVlhvSkdT?=
 =?utf-8?B?dEp3U296UjZYVlB0UXJnUnVxQkpvVTFOMzhFOEtLeCtmM2Y5ZENIdGJxWk04?=
 =?utf-8?B?TmdZcGdwSzhwWWs4WHJPdkJkNm8wc2hCQVVpSFBxOFRCTmdlY2pneDNocm9L?=
 =?utf-8?B?K0wrMm51Z2VMUUFBbHRiN01rQ2pWSmhVejFjNGZ1akdKd2plakFFSnBqcW50?=
 =?utf-8?B?emFpZStFcllRSEtDelVzSzJGbWxjdGFhM0pTaHFvaVk3VVRhY3BNbDVkSDlQ?=
 =?utf-8?B?UTZ0L3Blb2FSU09ERXZTOFp3emx4by92d1hTV0pIUTNISVNwTmd5U1JVMWVI?=
 =?utf-8?B?cDNpRVI1R29MQldTUEZxRTl6dWpZN0k1aXJMZzNJOEk1bjNLbG9iUGl4Vjhu?=
 =?utf-8?B?SDQweFpCOHZGWEJsOHFJQWRmNmNBZXpVcWZtaXd4amtNaVVaOWxWZnpnWG1O?=
 =?utf-8?B?cmRLMmVlNmxBZU1aY080K3lKYzMyemkveFVaQW9qUzNiMll1eFF6ZFFZTHRE?=
 =?utf-8?B?QmtwajRpMVF0bUEwNzY4UWRoV0tUQXA0cFVGYzAwYy9GVUwyUGVrdWpIcGsv?=
 =?utf-8?B?UG9MUS81SUxlMUpVSHdpOWZCWlN1TEx2M2RzTlN2bWJaV2hkaGh3QjZIeWoy?=
 =?utf-8?B?QS9iaU82VU9tTmlNbkJTbWM1M2ptNndFa1FTbTFsWkpMOWx3RWlTT21pUUpQ?=
 =?utf-8?B?R08rVU1EODd4VjNISFc2N2tQS1R2Z295UjM3aTEzbVI2NDRwME1OdFAzWFk0?=
 =?utf-8?B?VmVwUlVmVVdnbVZ0Q29rSm41TGVwaHRBRWpXUVJWQ0l5ZXlLYWcvdmNmcTJr?=
 =?utf-8?B?aW5zQXZEOXZIb01sU0hMcjNjSnRyMFJWd25jWDBGWEYxczRuZENtNk1CNmxi?=
 =?utf-8?B?NCt2eHFqQVNQWTlxeHZhMDVBODRva1gzelltVlU1dlVEU1B2aWF3Q3ltOW5u?=
 =?utf-8?B?TDhsM0R3UEVvelZUOGdRb1FSTnUwSlNzakdSdDNwUUVvQ1kxZHFoVkg3UUdq?=
 =?utf-8?B?NUwwOUxhbHFMaVA4SERxaG04L2R3UVd1VWpNRVUrc09LU3J0QjNOSnlXOHBN?=
 =?utf-8?B?a2tQV2xmc3lnQzJRREdOcFBBaUJoWVlHZjI2WVVQbFYxVWdBaWtid1dibDBC?=
 =?utf-8?B?ZVJXdFhZRXo5UnpQOWIrV1RTYXV3bnZXS2ZodVlxaDVNbUdMWlRlVkk5U0Fv?=
 =?utf-8?B?UE1IcXEza2Z2clJrMENwdjZsKzFocmZleVBtNlVzdDRWQlBrREd5SXREV1RQ?=
 =?utf-8?B?b2txM0pyckV3V2ZZYmQ5RHkvaXBBVkNzU0VvZndtN1dNeE5uRTRiK1BxV0Zn?=
 =?utf-8?B?VHd1a2grQS9VQUpBK2xZZmR1L2Y0L2lEeVZySDhsa0hoOVJwazN1cSs2cEFo?=
 =?utf-8?B?OVdLOU10RzVvTHQwQkRBcW9UN3IyZEtkUHNETWlkNE15bEZHSE0zdVNPbENE?=
 =?utf-8?B?RjJGZzc0VTlrdU1JT294di9ucjRGcGl0UC9VVDBRUHhmaDFKMkV1R3lvdnE3?=
 =?utf-8?B?OUVaamthOEhUMEJ1YjZCUWRyNXVQMytSeWxHc2Q3ekNrYnpIWENDYnNmVkc1?=
 =?utf-8?B?RkE1UUppVjlVai9DQ3JLZz09?=
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?utf-8?B?RzYrMCtOenh4TmR0eStPZWd1b3h5NGIxcVFwTUluc2dKZ0wwdWo3NWkyWU5L?=
 =?utf-8?B?UnlrdE4xU05mYmxBVm0xK2QxN3ZsUzNDOWdyN2Z6SjBINDhpMGtjdGp6M3I4?=
 =?utf-8?B?TUgvRHJONzRRanFJMVdKMkd3Y2JObkQ1VENhZW14V0VZK2Q5L3c3Rjd6aE5L?=
 =?utf-8?B?MHhCbTRIdUIrM25nbHVpQ2xXOVhMQ3dXUmsxZEtYdHlXQ0EyQ3pUTnNnSFBy?=
 =?utf-8?B?YkpKTzdORGRnT1JOaE5oV2U3aTJ1V2lrOWxJaEpFL0RQbGFBVE9ZcmsyTTcz?=
 =?utf-8?B?UWExeGp0MTlOVnVhY0lNZ3d3d3JjNklPTEgzWTA4MVQ3R3oxaklGeXloMTZo?=
 =?utf-8?B?cnk4amtlQS9jaERVcndNN3hReTZUbkp6YlBhaHB3NWQ3RmtTaCtjaGRZMnRz?=
 =?utf-8?B?Y0tseUV6c1d1TExreFlkbThROGFyVkVzdzR1WWlPWW5KR1ZEdzhvakF5SHBa?=
 =?utf-8?B?S1kveGNjV1JzaWpQS2VieGk3RmdKb3hsOFIwanV5Rzc1dnh3YzB2VXRGSlFi?=
 =?utf-8?B?UlgzWkVWcCtuTEEzZVh2UVhUVEZWTzIvaHhZNFRaVnJQY2VobFdET0xNWFM1?=
 =?utf-8?B?YlYzVVYySDYzekR1QVpERkN4MTl1S3hKSlNtWDByemkybTV6aTkxRktuSW9H?=
 =?utf-8?B?SUpmMzBwQTZOcFNJS0JuRGt5Q0xMUzhRaTE0NU9yU2h1NXlhV3EzQVhpenFv?=
 =?utf-8?B?U3dhM3ZPODRnSWFXZDUwNnY4ZkpzZWtQcFZTNWxYZ2tJYk1RQnlLbkpnWnZH?=
 =?utf-8?B?ZzA2c2xYc2hqcWxjQ3pCKzVXbDQ1V3pmL0hjeWJsQVRSdlBKMXJoSEFaaGFR?=
 =?utf-8?B?MXpqTG9SZ3c2RngxcHlFMFB4ZjFucVZ2Znc2bFNKZVE1b0xRSkZRS2tQZVNz?=
 =?utf-8?B?U2lSTkYrbm1qQ0lMMXB2SWxFRmFNQ1Q5SGlmMU1GVXYvNDBpRmo5VWwxUDlu?=
 =?utf-8?B?bW4xdmhvTWRVSGhXdUNFWU1hV0J6TDU2dWhGWU1MMUtYQkR0WlFzQ2ZLV1Vt?=
 =?utf-8?B?dnVTQ1RUMTN1bE83ZGRqQk5Bc2lycktJRCtTb1JNSGpwY1RyU2ZLVnM2NGxl?=
 =?utf-8?B?L05UMUFHQmdvem0rZ2hKdGlLdWhhQ1BEUUZFS1dpY3pYd1NsRTFTWEJQc29y?=
 =?utf-8?B?ZTJQcTVsNHZ0MmMveHFDaENlMDVobXR5dnA2b3o1aWxJZzNlbTJtVmtpZTQ0?=
 =?utf-8?B?WkpWeHBoL09aSitsOVFsZGZnNXp6Yk1mVVdiU0NMUHI5c1FGNUZtdTJIQnpS?=
 =?utf-8?B?N2ZlMkxER2tUbDRkSXhYUzFLNXZualRNWVlhS1FGZFVwKysydG1qTSt2VERP?=
 =?utf-8?B?T2hOcm1iSXl1NStkRUU4ZENuQXh6Sy9ORHV4WVFFU2ZXb2E5N0cwY0dJSWRY?=
 =?utf-8?B?UlJrN0ZnQk5HcFNiL3dsZk0vNjJDTkdBSXFZSTViU1hDa2lpWW1MYkdqUUV1?=
 =?utf-8?B?MlNhMHhXVm4rSlQ1UGdjblA0ejVvb05vMlZjVTlWS0VUV25aa00vYWsrbW0v?=
 =?utf-8?B?ZVhlVlFPVmJ1MVNFMGJnRHJMb0JhNXg1L1ArTHNRZlNsWmVUYU5maUxJVmVK?=
 =?utf-8?B?SU1mUjZJc1BQYnppUGNTMFBRbjkzdUkwU0pTTDJmK2hrdXFXVEFBTWVCYUpH?=
 =?utf-8?B?aTRoekxJNFd2TEZ6VnZJZ2ZxRmhENi8wUW1lS3k3VDI0N1M2b3B1QnF5Q2pi?=
 =?utf-8?B?QTZBWVFrVHlxeEJLM29NNUFBQmxadW12SzNhUFA1Z2lUanRDUGo1dkRWeThV?=
 =?utf-8?B?ZGFRQ0lYT3RNejk1M0NGL2cvZG9zMTZ2ekVxRVRBVkZqSzdLSGU0M09aYmFH?=
 =?utf-8?B?Q2xhcm15YWRvNzZETHBQdTd3YmhZTnhHZy96RkIxUEVTQ0RHZ2NVK0N1VG1S?=
 =?utf-8?B?dy8ybWNxQ0l1U1RubEZHaUJJU1pwZU5BQzhzNmx0TUhlSGloQlFGNHY2d1Qr?=
 =?utf-8?B?UDJvdWxqNkZicTVUcEhXa25SR2JtQU9DUTlweFdDMGo5TEJVbmVrcjdnRDlJ?=
 =?utf-8?B?dWsyKy9ydEtXcjA4WkNxT0JlL0JPUTNTMWJvdUtqdWxMRlp2dmZkU2FqTkZQ?=
 =?utf-8?B?ZDVFb2cvWHU5dG8vajAwVThtZXVEdjRMRzlNbmhVVUFhL0hMb1dKUDN1NFl0?=
 =?utf-8?B?alAzeEJsNmtqZkdscWhEd1VseE9TcEorWXpwK1JvaC9HbW5ZZzZYdWVzV1Nu?=
 =?utf-8?B?NXc9PQ==?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <821CBBB4A31C094D8D7678F1E1537063@namprd11.prod.outlook.com>
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
X-MS-Exchange-CrossTenant-Network-Message-Id: b0201faa-80ef-4c7a-bbdd-08dce21052e4
X-MS-Exchange-CrossTenant-originalarrivaltime: 01 Oct 2024 11:58:11.7241
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3f4057f3-b418-4d4e-ba84-d55b4e897d88
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: HPJDWhqkIaE1zqfd9HQX+4498dP5EnavGXSe/UJMf+1ZMP1O3VOcVB2D07SZonA7eRR03ZnEj57F5686RjbLSnBPp8tTEB++xJne5Xee3QHLMDVyC1Y75TyjIgC1cJWD
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR11MB4564

SGksDQoNCk9uIDMwLzA5LzI0IDk6MDQgcG0sIERpdnlhIEtvcHBlcmEgd3JvdGU6DQo+IEFkZCBz
dXBwb3J0IGZvciBsaW5rIHVwIGFuZCBsaW5rIGRvd24gaW50ZXJydXB0cyBpbiBsYW44ODd4Lg0K
PiANCj4gU2lnbmVkLW9mZi1ieTogRGl2eWEgS29wcGVyYSA8ZGl2eWEua29wcGVyYUBtaWNyb2No
aXAuY29tPg0KPiAtLS0NCj4gICBkcml2ZXJzL25ldC9waHkvbWljcm9jaGlwX3QxLmMgfCA2MyAr
KysrKysrKysrKysrKysrKysrKysrKysrKysrKysrKysrDQo+ICAgMSBmaWxlIGNoYW5nZWQsIDYz
IGluc2VydGlvbnMoKykNCj4gDQo+IGRpZmYgLS1naXQgYS9kcml2ZXJzL25ldC9waHkvbWljcm9j
aGlwX3QxLmMgYi9kcml2ZXJzL25ldC9waHkvbWljcm9jaGlwX3QxLmMNCj4gaW5kZXggYTVlZjhm
ZTUwNzA0Li4zODMwNTBhNWIwZWQgMTAwNjQ0DQo+IC0tLSBhL2RyaXZlcnMvbmV0L3BoeS9taWNy
b2NoaXBfdDEuYw0KPiArKysgYi9kcml2ZXJzL25ldC9waHkvbWljcm9jaGlwX3QxLmMNCj4gQEAg
LTIyNiw2ICsyMjYsMTggQEANCj4gICAjZGVmaW5lIE1JQ1JPQ0hJUF9DQUJMRV9NQVhfVElNRV9E
SUZGCVwNCj4gICAJKE1JQ1JPQ0hJUF9DQUJMRV9NSU5fVElNRV9ESUZGICsgTUlDUk9DSElQX0NB
QkxFX1RJTUVfTUFSR0lOKQ0KPiAgIA0KPiArI2RlZmluZSBMQU44ODdYX0lOVF9TVFMJCQkJMHhm
MDAwDQo+ICsjZGVmaW5lIExBTjg4N1hfSU5UX01TSwkJCQkweGYwMDENCj4gKyNkZWZpbmUgTEFO
ODg3WF9JTlRfTVNLX1QxX1BIWV9JTlRfTVNLCQlCSVQoMikNCj4gKyNkZWZpbmUgTEFOODg3WF9J
TlRfTVNLX0xJTktfVVBfTVNLCQlCSVQoMSkNCj4gKyNkZWZpbmUgTEFOODg3WF9JTlRfTVNLX0xJ
TktfRE9XTl9NU0sJCUJJVCgwKQ0KPiArDQo+ICsjZGVmaW5lIExBTjg4N1hfTVhfQ0hJUF9UT1Bf
TElOS19NU0sJKExBTjg4N1hfSU5UX01TS19MSU5LX1VQX01TSyB8XA0KPiArCQkJCQkgTEFOODg3
WF9JTlRfTVNLX0xJTktfRE9XTl9NU0spDQo+ICsNCj4gKyNkZWZpbmUgTEFOODg3WF9NWF9DSElQ
X1RPUF9BTExfTVNLCShMQU44ODdYX0lOVF9NU0tfVDFfUEhZX0lOVF9NU0sgfFwNCj4gKwkJCQkJ
IExBTjg4N1hfTVhfQ0hJUF9UT1BfTElOS19NU0spDQo+ICsNCj4gICAjZGVmaW5lIERSSVZFUl9B
VVRIT1IJIk5pc2FyIFNheWVkIDxuaXNhci5zYXllZEBtaWNyb2NoaXAuY29tPiINCj4gICAjZGVm
aW5lIERSSVZFUl9ERVNDCSJNaWNyb2NoaXAgTEFOODdYWC9MQU45Mzd4L0xBTjg4N3ggVDEgUEhZ
IGRyaXZlciINCj4gICANCj4gQEAgLTE0NzQsNiArMTQ4Niw3IEBAIHN0YXRpYyB2b2lkIGxhbjg4
N3hfZ2V0X3N0cmluZ3Moc3RydWN0IHBoeV9kZXZpY2UgKnBoeWRldiwgdTggKmRhdGEpDQo+ICAg
CQlldGh0b29sX3B1dHMoJmRhdGEsIGxhbjg4N3hfaHdfc3RhdHNbaV0uc3RyaW5nKTsNCj4gICB9
DQo+ICAgDQo+ICtzdGF0aWMgaW50IGxhbjg4N3hfY29uZmlnX2ludHIoc3RydWN0IHBoeV9kZXZp
Y2UgKnBoeWRldik7DQo+ICAgc3RhdGljIGludCBsYW44ODd4X2NkX3Jlc2V0KHN0cnVjdCBwaHlf
ZGV2aWNlICpwaHlkZXYsDQo+ICAgCQkJICAgIGVudW0gY2FibGVfZGlhZ19zdGF0ZSBjZF9kb25l
KQ0KPiAgIHsNCj4gQEAgLTE1MDQsNiArMTUxNywxMCBAQCBzdGF0aWMgaW50IGxhbjg4N3hfY2Rf
cmVzZXQoc3RydWN0IHBoeV9kZXZpY2UgKnBoeWRldiwNCj4gICAJCWlmIChyYyA8IDApDQo+ICAg
CQkJcmV0dXJuIHJjOw0KPiAgIA0KPiArCQlyYyA9IGxhbjg4N3hfY29uZmlnX2ludHIocGh5ZGV2
KTsNCj4gKwkJaWYgKHJjIDwgMCkNCj4gKwkJCXJldHVybiByYzsNCj4gKw0KPiAgIAkJcmMgPSBs
YW44ODd4X3BoeV9yZWNvbmZpZyhwaHlkZXYpOw0KPiAgIAkJaWYgKHJjIDwgMCkNCj4gICAJCQly
ZXR1cm4gcmM7DQo+IEBAIC0xODMwLDYgKzE4NDcsNTAgQEAgc3RhdGljIGludCBsYW44ODd4X2Nh
YmxlX3Rlc3RfZ2V0X3N0YXR1cyhzdHJ1Y3QgcGh5X2RldmljZSAqcGh5ZGV2LA0KPiAgIAlyZXR1
cm4gbGFuODg3eF9jYWJsZV90ZXN0X3JlcG9ydChwaHlkZXYpOw0KPiAgIH0NCj4gICANCj4gK3N0
YXRpYyBpbnQgbGFuODg3eF9jb25maWdfaW50cihzdHJ1Y3QgcGh5X2RldmljZSAqcGh5ZGV2KQ0K
PiArew0KPiArCWludCByZXQ7DQo+ICsNCj4gKwlpZiAocGh5ZGV2LT5pbnRlcnJ1cHRzID09IFBI
WV9JTlRFUlJVUFRfRU5BQkxFRCkgew0KPiArCQkvKiBDbGVhciB0aGUgaW50ZXJydXB0IHN0YXR1
cyBiZWZvcmUgZW5hYmxpbmcgaW50ZXJydXB0cyAqLw0KPiArCQlyZXQgPSBwaHlfcmVhZF9tbWQo
cGh5ZGV2LCBNRElPX01NRF9WRU5EMSwgTEFOODg3WF9JTlRfU1RTKTsNCj4gKwkJaWYgKHJldCA8
IDApDQo+ICsJCQlyZXR1cm4gcmV0Ow0KPiArDQo+ICsJCS8qIFVubWFzayBmb3IgZW5hYmxpbmcg
aW50ZXJydXB0ICovDQo+ICsJCXJldCA9IHBoeV93cml0ZV9tbWQocGh5ZGV2LCBNRElPX01NRF9W
RU5EMSwgTEFOODg3WF9JTlRfTVNLLA0KPiArCQkJCSAgICAodTE2KX5MQU44ODdYX01YX0NISVBf
VE9QX0FMTF9NU0spOw0KPiArCX0gZWxzZSB7DQo+ICsJCXJldCA9IHBoeV93cml0ZV9tbWQocGh5
ZGV2LCBNRElPX01NRF9WRU5EMSwgTEFOODg3WF9JTlRfTVNLLA0KPiArCQkJCSAgICBHRU5NQVNL
KDE1LCAwKSk7DQo+ICsJCWlmIChyZXQgPCAwKQ0KPiArCQkJcmV0dXJuIHJldDsNCj4gKw0KPiAr
CQlyZXQgPSBwaHlfcmVhZF9tbWQocGh5ZGV2LCBNRElPX01NRF9WRU5EMSwgTEFOODg3WF9JTlRf
U1RTKTsNCj4gKwl9DQo+ICsNCj4gKwlyZXR1cm4gcmV0IDwgMCA/IHJldCA6IDA7DQo+ICt9DQo+
ICsNCj4gK3N0YXRpYyBpcnFyZXR1cm5fdCBsYW44ODd4X2hhbmRsZV9pbnRlcnJ1cHQoc3RydWN0
IHBoeV9kZXZpY2UgKnBoeWRldikNCj4gK3sNCj4gKwlpbnQgcmV0ID0gSVJRX05PTkU7DQpJIHRo
aW5rIHlvdSBjYW4gcmVtb3ZlICdyZXQnIGJ5IHNpbXBseSByZXR1cm5pbmcgSVJRX0hBTkRMRUQg
YW5kIA0KSVJRX05PTkUgZGlyZWN0bHkgdG8gc2F2ZSBvbmUgbGluZS4NCg0KQmVzdCByZWdhcmRz
LA0KUGFydGhpYmFuIFYNCj4gKwlpbnQgaXJxX3N0YXR1czsNCj4gKw0KPiArCWlycV9zdGF0dXMg
PSBwaHlfcmVhZF9tbWQocGh5ZGV2LCBNRElPX01NRF9WRU5EMSwgTEFOODg3WF9JTlRfU1RTKTsN
Cj4gKwlpZiAoaXJxX3N0YXR1cyA8IDApIHsNCj4gKwkJcGh5X2Vycm9yKHBoeWRldik7DQo+ICsJ
CXJldHVybiBJUlFfTk9ORTsNCj4gKwl9DQo+ICsNCj4gKwlpZiAoaXJxX3N0YXR1cyAmIExBTjg4
N1hfTVhfQ0hJUF9UT1BfTElOS19NU0spIHsNCj4gKwkJcGh5X3RyaWdnZXJfbWFjaGluZShwaHlk
ZXYpOw0KPiArCQlyZXQgPSBJUlFfSEFORExFRDsNCj4gKwl9DQo+ICsNCj4gKwlyZXR1cm4gcmV0
Ow0KPiArfQ0KPiArDQo+ICAgc3RhdGljIHN0cnVjdCBwaHlfZHJpdmVyIG1pY3JvY2hpcF90MV9w
aHlfZHJpdmVyW10gPSB7DQo+ICAgCXsNCj4gICAJCVBIWV9JRF9NQVRDSF9NT0RFTChQSFlfSURf
TEFOODdYWCksDQo+IEBAIC0xODgxLDYgKzE5NDIsOCBAQCBzdGF0aWMgc3RydWN0IHBoeV9kcml2
ZXIgbWljcm9jaGlwX3QxX3BoeV9kcml2ZXJbXSA9IHsNCj4gICAJCS5yZWFkX3N0YXR1cwk9IGdl
bnBoeV9jNDVfcmVhZF9zdGF0dXMsDQo+ICAgCQkuY2FibGVfdGVzdF9zdGFydCA9IGxhbjg4N3hf
Y2FibGVfdGVzdF9zdGFydCwNCj4gICAJCS5jYWJsZV90ZXN0X2dldF9zdGF0dXMgPSBsYW44ODd4
X2NhYmxlX3Rlc3RfZ2V0X3N0YXR1cywNCj4gKwkJLmNvbmZpZ19pbnRyICAgID0gbGFuODg3eF9j
b25maWdfaW50ciwNCj4gKwkJLmhhbmRsZV9pbnRlcnJ1cHQgPSBsYW44ODd4X2hhbmRsZV9pbnRl
cnJ1cHQsDQo+ICAgCX0NCj4gICB9Ow0KPiAgIA0KDQo=

