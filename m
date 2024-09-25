Return-Path: <netdev+bounces-129651-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 06DF098525E
	for <lists+netdev@lfdr.de>; Wed, 25 Sep 2024 07:22:34 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 339CDB230B5
	for <lists+netdev@lfdr.de>; Wed, 25 Sep 2024 05:22:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B4AA514B955;
	Wed, 25 Sep 2024 05:22:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b="ISzlnMSW"
X-Original-To: netdev@vger.kernel.org
Received: from DU2PR03CU002.outbound.protection.outlook.com (mail-northeuropeazon11012021.outbound.protection.outlook.com [52.101.66.21])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4CDD31B85D5;
	Wed, 25 Sep 2024 05:22:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.66.21
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727241745; cv=fail; b=nXiVoL/lVD75qeXcnMfwHiQqKvxzaTEXIOa/etRbBxtxkpJEkIG1QZGHQBypz8i/eM3CIcHzofKem5h3y0d5aZtRAbCJoVhoamSmF21Lz/81lm0ExvcAH3eLTmdZF7HXgsF7P443xzWKl6sAMxRyqal3U4AmtIqLnF8ph0Whcko=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727241745; c=relaxed/simple;
	bh=vYF5mYhzzkWkPXFPKqqHzY7HieGMoHZRnenlADZihj8=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=IYjKYqF6jbz0OfzvRNIQRsI/pR5vs6kOjMi5LT+q+mHDR6jHPf1+XLSI1SivNYRbnZ1xqNibhLtBAIfdRyMJyEuBIFHEAqJTD9SLyMZOz7G5vbEox9KTPPP4MeXAXpZNxKufSXBpMtCZNJpfmBe831dOK75q5NO/tdJMBpJiJYY=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b=ISzlnMSW; arc=fail smtp.client-ip=52.101.66.21
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=g5c4evVcRYDOTa5Z4UfPI+RyKs2NPdDrnft+m98nSLHQNJyn7YkWmYrkfpY+hNI/0Nj76d7D3fmobxqKjlMy7UC3W8JmxJhiLnwm8QstDE5VIXeVBhUkZ3swVRK+zCbHHSfjXw82SnvrASJdMjbczNTkjjtoYDqHvfMJhZrUOXIowfRKGqKKLNYm0g/0/yqnzfStJ2XDEULA1OFiaOflni03AbTQUZ42pKYt6PJwykXzyB7LgWVg692mFnGF1Azrkht+KLt6PRikadRc2qm6ElGr28u1QDFWuQ7n4i2pjgDfd9aHzv7G1CxNYmo9Zjn/yB0IiEArOERQvr/2qcqO6w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=vYF5mYhzzkWkPXFPKqqHzY7HieGMoHZRnenlADZihj8=;
 b=rIXrOWXrnC+VjICdliYBd7Jh9wK3ClT+GxNodTp70CtQXDl1eain+Gog2AWZ3tzsDeDW9nAwi801/aTERbNMr3IybpWmoiKlFKGjtApdoa5ioNvi/Hv8PFYi+Ue2TVTUyFzJkSRPeF+ldEmeXVv/pwJVCofmYvr/mc2s0auVWxulrXqX0ZF4smLS+9fXE8vqfWNt48zPXOQIEE9TTAhqmR6TE8kebrprGJeqHaI9NqSdF/R/1HctBAMV3wD47YdNiENinmcg2HCtqx9OArDkF4/acC+pflqGoskN6YcuBxG0fPYy0ht6736Hx3MZfs/badNqsDvEu7G/ZLpwR/pU/g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=vYF5mYhzzkWkPXFPKqqHzY7HieGMoHZRnenlADZihj8=;
 b=ISzlnMSW2FgKUDyW1sbHcd3Pr3UzyzHQjLoYLDNNQnztVYae+HwVu6yiSHktJiD6cKoJSLzn1F2BdhbwaoUcouZnntobGY/1DP+bcr3tEBd3y8dGobJG8SXReDTIwSqTfMsWM95kxmekLXqldMt/g9tZvXxMx6zwdSU4dZ2za7qoO0WRfXW867DvkhcZMEdRRBcRhmKGdaKjUyxt77SgeU/U86bN2fV4mw/9p0XnUGBKrrB7QuWuiA1w56zK75Df1DtMuXKDkKzYXypEtFzLU2/662gslfUsC4oT8GJEN3e08bIBB/yO+s7dh3Dv6YqKyixbV78NnocLyoSr6VNvAA==
Received: from PAXPR04MB8510.eurprd04.prod.outlook.com (2603:10a6:102:211::7)
 by GVXPR04MB9830.eurprd04.prod.outlook.com (2603:10a6:150:113::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7982.25; Wed, 25 Sep
 2024 05:22:15 +0000
Received: from PAXPR04MB8510.eurprd04.prod.outlook.com
 ([fe80::a7c2:e2fa:8e04:40db]) by PAXPR04MB8510.eurprd04.prod.outlook.com
 ([fe80::a7c2:e2fa:8e04:40db%6]) with mapi id 15.20.7918.024; Wed, 25 Sep 2024
 05:22:15 +0000
From: Wei Fang <wei.fang@nxp.com>
To: =?utf-8?B?Q3PDs2vDoXMsIEJlbmNl?= <csokas.bence@prolan.hu>, Frank Li
	<frank.li@nxp.com>
CC: Shenwei Wang <shenwei.wang@nxp.com>, Clark Wang <xiaoning.wang@nxp.com>,
	Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>, Paolo
 Abeni <pabeni@redhat.com>, Richard Cochran <richardcochran@gmail.com>, "David
 S. Miller" <davem@davemloft.net>, "imx@lists.linux.dev"
	<imx@lists.linux.dev>, "netdev@vger.kernel.org" <netdev@vger.kernel.org>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: RE: [PATCH net 2/2] net: fec: Reload PTP registers after link-state
 change
Thread-Topic: [PATCH net 2/2] net: fec: Reload PTP registers after link-state
 change
Thread-Index: AQHbDmVnT9uKuxnUUEaaQmQywDi5ibJn98vg
Date: Wed, 25 Sep 2024 05:22:15 +0000
Message-ID:
 <PAXPR04MB85105AEE29B46B8BF5FF64D288692@PAXPR04MB8510.eurprd04.prod.outlook.com>
References: <20240924093705.2897329-1-csokas.bence@prolan.hu>
 <20240924093705.2897329-2-csokas.bence@prolan.hu>
In-Reply-To: <20240924093705.2897329-2-csokas.bence@prolan.hu>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: PAXPR04MB8510:EE_|GVXPR04MB9830:EE_
x-ms-office365-filtering-correlation-id: edd713c2-3f48-40c0-f439-08dcdd220488
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230040|1800799024|366016|376014|38070700018;
x-microsoft-antispam-message-info:
 =?utf-8?B?b3JIR1JsVDhYNUlXSGFlY2l1Rk44cHEwaDJSYlBSelNjS29CcDRpS1Q3bmVk?=
 =?utf-8?B?eWlORGZaSndVaHFlUUZWV3FBNHZKVS81OFRGMHdkcnpaZ2NuZE9vczhOK2VJ?=
 =?utf-8?B?Szd3Z2dtaUFqVU9lTVByKzhuQnRXd3RVMmlTdDIxalFDMzJuNVExdHkrcWdo?=
 =?utf-8?B?Q0J1bDJveDBrU2hmajgrNUpZQUNqR2oyU3VGdHlUcWZCTzFXVXZOQ1ZGaVlp?=
 =?utf-8?B?UDhCNmlDYmthSHV4OTlOc3FEWTZLOGdJVFM4cGhhWjBudGp4cHduYzJ0MG5q?=
 =?utf-8?B?YkpRRmVuY3ZJa200enBrZm9UVUs0MXAwQyt3ZXpPdkRmY3Rzc2M0OURGSVlB?=
 =?utf-8?B?YkcwSmVIaHBBYzI4QUt0RWxHcVJyUnFISEdBcDlvRWVmUEF3eWpDbFFjZEpz?=
 =?utf-8?B?L3R4SXFQallHYmZsR045ck5jQ0NGM05iZmplb2xEYXFKZ2VoSjB4KytWU1JJ?=
 =?utf-8?B?QWVTSU5VSFNpWDUxcjhyRncwZ2xnbXJ4UUhiRk9HNkU0b3BsaHJ0UW1qQjdp?=
 =?utf-8?B?YzUwUEIySUx5U0RLOFVSekF2bzZJa05xNmVUMWZFb21rcjJkb1ZQSmFRRDhM?=
 =?utf-8?B?WjR3bUZTd1pWUUl3ZmdQaU9nZFA0d2lwVGx0V1VuTkJyNjFEWHU4cHBMcTV6?=
 =?utf-8?B?d2xWRnZPTHFtSTIzakFtUnZTOVoyWXFtVmJxbS9ZK2NJendTUXV3QW5FT3FL?=
 =?utf-8?B?T0JHRmlNNFNUazMrTHI1M0paMnQvK0NlWEtyQjZwNC9vNlBkTGRDd2tqcjB1?=
 =?utf-8?B?RnRUMTBSdVppcG5tYzlKZi9va2JkUmxHZkpjWTJVSkFVV2ZkWERuMllKc1dx?=
 =?utf-8?B?V3RNYWJTdThMTGw5SndaN01kOThNeXNQN2hFcGtOMEIxYXZHbXh2Znh1dk8v?=
 =?utf-8?B?cmIwTVRhdEFkbWJZeFhwekdyOWQ5bVYvRW5YZ2NqdkJLSmNJZCtTOWlhcVV4?=
 =?utf-8?B?OFZtVHFmVGZDak9lMDVROVBERmUvVDZjdDRBdHI5WVdmcVFGZjJpbHY0KzFX?=
 =?utf-8?B?N2l0MjFsQVlES1Q3Z09lVUU3dHpudURlcGRiL3NnakZMaEE5dnFkZURtdTNn?=
 =?utf-8?B?WlRTQUtsMlVPMXVKaHIyK3lyblRVTU53SDN4bXhLdnB3Z2lUK0xjM1Z4c3Jp?=
 =?utf-8?B?VzJVSmtQRHVvRmRaRzRJb0tlKzVRbEY1aU9sTmJ2a0RBUDFlWng4TnhaUW94?=
 =?utf-8?B?a0o0eE83QXFYTDFiMHZHUHRFMURZbjZvb21uV08yKzd6MHpwN2VpK1JjbGVD?=
 =?utf-8?B?T0YwS3M1NkcrUnJkRkdlb0dUNGJkeTFrdXZzOW1uUUhjajcxa2gzTnRYOWhP?=
 =?utf-8?B?UEF0WktGMUtNdFpDclhpL3dhNUZSOWEvSE52RkcxYkk3MEo4YmlsRS9FUzdz?=
 =?utf-8?B?NllpVTQvdnVkeTVOYWIydjhlWkFyWXkvNHl3d1pjUUNPeWZJWUhGZE5QclFz?=
 =?utf-8?B?dU51V08wWEc0RFkxQlczY3htd3RBamZKcHhrUXNMUkpic3N6d2cxbTRmNjAy?=
 =?utf-8?B?akxJVmJDYXMzYjZ2M0JUaUpJZDhjUFo0anltMjBLWWNPYWUzSG5HMWFENlFz?=
 =?utf-8?B?cHJuUkZxOEpWUmx3UVN5ditLTFJtR1hpaU1lL2dWUUFlbFdxSjhpM3dkcDhQ?=
 =?utf-8?B?NjNjeVZtbHNuVlJ0TFdmd2ZpenU4QUV0OUxYcmtHZEZDOHY5M3JGbmxsZ1BP?=
 =?utf-8?B?VmtKQkVjMWdZc2tEQy9lOVk4N3c5L2wyeEhMNUZCL1RWQW5lQ01rRERmK0Jp?=
 =?utf-8?B?a1NtaVQvY0FKbWU5Z01aaGxZRm5iL1U4MmFCUGVMK1RUMTNqM2FleXVCK0lr?=
 =?utf-8?B?QWVHbkZGTGtPMGZsSGtHQVdpc29Qb3d1Z0pRVUVMelNGSHh2d2c3NUNUbUVL?=
 =?utf-8?B?eUx1R0hHMXZlbXlxSnhvWS9Od1JkNkM3NkowaHZrZ3pkN2c9PQ==?=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PAXPR04MB8510.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(376014)(38070700018);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?utf-8?B?SUtha1JnM2JDQXA2aVU1QmVMbnlBNld1WkJVWFlhQ1hiZmNxU1dqd1JIMGJq?=
 =?utf-8?B?VlVKNW8xSWxVQ0RrbW1CTTVDYnpMTFkxYVBnSlpjUDQycDRkTE1Vcnd4a2Z6?=
 =?utf-8?B?OHpyWnNhcTVYWEVVa1Rmb3Y2SFAzWlZ4NG1hNUI5ajR3dHlNVUpCUFh0MjJQ?=
 =?utf-8?B?UDlHdVN5RlB3REVKYUZiTDQ3MTFSSE53VmhOQks5NXUyY2hpV1k5SHAzWExO?=
 =?utf-8?B?UGR5UHZGdHZYaFZLNnQzbWNNSU5LajN0aXNua2FkZlBGQXZYYllyMEI3anRt?=
 =?utf-8?B?QkNOc1hqRUxDdGtzWkxXWm9nTE1PQ1FndVU2SVhjTG12QVM3OEcwNW1hS0dK?=
 =?utf-8?B?OEhiaXo0WUlNSmVjamdVKzFoMnM2U00wc01BaHo5ZStqSS80dzJTOTZNY0ti?=
 =?utf-8?B?Y3oyZ09mcFZycm1qcjF6NjB2endzeW0zbXd5R1hzRUoyQmxURFQ1UUNqTG1Q?=
 =?utf-8?B?dnpUNkhYalBEbTBxMkVuTHh5YkFKVFFtTEZ5bHNPQ2h3cldWWEJpYmRENWdw?=
 =?utf-8?B?eFlBUUNVYlV3VHVXams4MXNJLzh4ajE1NERkY21VbFczSFFxUWpRa05pS01y?=
 =?utf-8?B?dUw3Q1kxWkpJTmpIUXpYaUIrOU03ZUtHZGs4ZFhZbmZ6QUJMU0pWTjBSdzZZ?=
 =?utf-8?B?eVRRZlVlSmx0WGVaU1pLeUdyVnVVR2ZHa0dyRGJqQ3RUNk5KNjJkb0Uwam5z?=
 =?utf-8?B?VWR1SmREOVdJTDhRM2ZhZnN0MmNXL0xSVXRPNGs1QmUwUFFML2pYUGt0NWY0?=
 =?utf-8?B?MEl3RkpJZmVGSStKb2kvZmRZZk1BSysvNGJIaitqTDgvb0lPa3p1N2FTb202?=
 =?utf-8?B?a3Z6ZmtaRVRPQjFTUHdobzdyenhxNkt3c0dpdjdDd3hpY1c5am52UUFta0Nl?=
 =?utf-8?B?YWlka1l1QlRZTHdia05WUTMzNHFtSjlLYXgrVmYxb1NjU0lWbDhaU2ZkLzhP?=
 =?utf-8?B?YVNpQVlDTXdYa2xrYUxYRExqeWdFczlYVDNNdFAvM2RHYThuMzIzVlp3dnpQ?=
 =?utf-8?B?dmZVcEpURlU2NXh4RWoybkRFdEtTbldrWnpUK0VMME5XNk56YjZRT01qTFJH?=
 =?utf-8?B?VDVPUy96ZnNzRUQwZjVBUXluY3lLVittbFpUMmcxWFJnT0E3aTdJWVo2aHEz?=
 =?utf-8?B?V1N6MExUWXFxV3FPYm8ybG9DS0VzaHJXQTY0dkZQYUdFenNqSWNjZCtzb2Uz?=
 =?utf-8?B?b3FrTzZTZ3llU1pmTmFuUnNWdVhkOW10eGsrMHQyWTB1UTVSaFM5Ukh4WFZx?=
 =?utf-8?B?c1FmOE1xcU0vaVpicmc4LzF6SS9lcTVzamxOSlkwdDJSU1FhZlJiM0RveVhP?=
 =?utf-8?B?NENNd29ueFJtTWdoVEN3eGptY0NXVTQyY1k2QVF3SGYvV1Rodzc1dmVIdlVk?=
 =?utf-8?B?WGlkcGc4T2pjY3JqbXFZNncwdkcyZUM3OFdlWmVyc2ZTUE5PVnpwMmlqb003?=
 =?utf-8?B?S2p0NjNZajIvTUVWRHFyQ1pLWkxsRVNOdlFWa3o4TzU2SkswdngvVVFSNFd1?=
 =?utf-8?B?em4wRHVTWHc0R280ajNkU3BJY2t3aXE5SUh2M3UxMVIrdGUrZ3psWm9NZ0Z3?=
 =?utf-8?B?VTk0eUFOR3QrSjFzdGR5U3BIOXJuVmxONnhhVzJQSmR3bndnYWpDZk5CaTJH?=
 =?utf-8?B?bTN2SkhiYmFWclVJNnV0dnNwOFBDMlpaclh3aGhWbDRpVG95eHQ4VmFHdGZs?=
 =?utf-8?B?ZEg2OCtJMXJ1eUhUM2hkMUR3d3c2WmlOajJjNGpRc2JSbnRCcGlkeng3Y3py?=
 =?utf-8?B?T3h5am9EcXhGQUVZeFRzV1FKeWpPRjRUcDFRM1J3eDdNalhyMndKQ1J6ZGRv?=
 =?utf-8?B?ZEc5QllwbGxXaUFGRVhtYkJmYUxSS0JCQXQ5amh5eURjM1NBQkxsYjFGOFp4?=
 =?utf-8?B?dVljclhFL2lUZmV3Y2kzQnFFckhpaDJlVzZVOHB0MlAwNjU1MWg0N2huMFp4?=
 =?utf-8?B?SDBuRVNNR3pBREwrQnV4VkZTRHIxWUtSeTJ5clN5ZUcrWi91NU9rUmFBNnFR?=
 =?utf-8?B?NEhycm1vMU8rNGlLSWo1eE9jL2EwMWF6UUVDU0Y3SC9UL25SZ1lvcytteEJz?=
 =?utf-8?B?aUJJYnlFemJ5aE1CSERRak43UkU5NU96T3d5UDgrbEhuNWRrWnhsYktBMjZG?=
 =?utf-8?Q?M5hw=3D?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: PAXPR04MB8510.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: edd713c2-3f48-40c0-f439-08dcdd220488
X-MS-Exchange-CrossTenant-originalarrivaltime: 25 Sep 2024 05:22:15.4115
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 81NxzKfyWsnznF4bBr0REHwlQVpb57qpVCsvIc2tMOJxVKiBBileAGQ92xID8dB9NfjHz5AnWkxlDn9lQZZslA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: GVXPR04MB9830

PiAtLS0tLU9yaWdpbmFsIE1lc3NhZ2UtLS0tLQ0KPiBGcm9tOiBDc8Oza8OhcywgQmVuY2UgPGNz
b2thcy5iZW5jZUBwcm9sYW4uaHU+DQo+IFNlbnQ6IDIwMjTlubQ55pyIMjTml6UgMTc6MzcNCj4g
VG86IEZyYW5rIExpIDxGcmFuay5MaUBmcmVlc2NhbGUuY29tPjsgRGF2aWQgUy4gTWlsbGVyDQo+
IDxkYXZlbUBkYXZlbWxvZnQubmV0PjsgaW14QGxpc3RzLmxpbnV4LmRldjsgbmV0ZGV2QHZnZXIu
a2VybmVsLm9yZzsNCj4gbGludXgta2VybmVsQHZnZXIua2VybmVsLm9yZw0KPiBDYzogQ3PDs2vD
oXMsIEJlbmNlIDxjc29rYXMuYmVuY2VAcHJvbGFuLmh1PjsgV2VpIEZhbmcgPHdlaS5mYW5nQG54
cC5jb20+Ow0KPiBTaGVud2VpIFdhbmcgPHNoZW53ZWkud2FuZ0BueHAuY29tPjsgQ2xhcmsgV2Fu
Zw0KPiA8eGlhb25pbmcud2FuZ0BueHAuY29tPjsgRXJpYyBEdW1hemV0IDxlZHVtYXpldEBnb29n
bGUuY29tPjsgSmFrdWINCj4gS2ljaW5za2kgPGt1YmFAa2VybmVsLm9yZz47IFBhb2xvIEFiZW5p
IDxwYWJlbmlAcmVkaGF0LmNvbT47IFJpY2hhcmQNCj4gQ29jaHJhbiA8cmljaGFyZGNvY2hyYW5A
Z21haWwuY29tPg0KPiBTdWJqZWN0OiBbUEFUQ0ggbmV0IDIvMl0gbmV0OiBmZWM6IFJlbG9hZCBQ
VFAgcmVnaXN0ZXJzIGFmdGVyIGxpbmstc3RhdGUgY2hhbmdlDQo+IA0KPiBPbiBsaW5rLXN0YXRl
IGNoYW5nZSwgdGhlIGNvbnRyb2xsZXIgZ2V0cyByZXNldCwNCj4gd2hpY2ggY2xlYXJzIGFsbCBQ
VFAgcmVnaXN0ZXJzLCBpbmNsdWRpbmcgUEhDIHRpbWUsDQo+IGNhbGlicmF0ZWQgY2xvY2sgY29y
cmVjdGlvbiB2YWx1ZXMgZXRjLiBGb3IgY29ycmVjdA0KPiBJRUVFIDE1ODggb3BlcmF0aW9uIHdl
IG5lZWQgdG8gcmVzdG9yZSB0aGVzZSBhZnRlcg0KPiB0aGUgcmVzZXQuDQo+IA0KPiBGaXhlczog
NjYwNWI3MzBjMDYxICgiRkVDOiBBZGQgdGltZSBzdGFtcGluZyBjb2RlIGFuZCBhIFBUUCBoYXJk
d2FyZQ0KPiBjbG9jayIpDQo+IFNpZ25lZC1vZmYtYnk6IENzw7Nrw6FzLCBCZW5jZSA8Y3Nva2Fz
LmJlbmNlQHByb2xhbi5odT4NCj4gLS0tDQo+ICBkcml2ZXJzL25ldC9ldGhlcm5ldC9mcmVlc2Nh
bGUvZmVjLmggICAgIHwgIDMgKysrDQo+ICBkcml2ZXJzL25ldC9ldGhlcm5ldC9mcmVlc2NhbGUv
ZmVjX3B0cC5jIHwgMjAgKysrKysrKysrKysrKysrKysrKysNCj4gIDIgZmlsZXMgY2hhbmdlZCwg
MjMgaW5zZXJ0aW9ucygrKQ0KPiANCj4gZGlmZiAtLWdpdCBhL2RyaXZlcnMvbmV0L2V0aGVybmV0
L2ZyZWVzY2FsZS9mZWMuaA0KPiBiL2RyaXZlcnMvbmV0L2V0aGVybmV0L2ZyZWVzY2FsZS9mZWMu
aA0KPiBpbmRleCAwNTUyMzE3YTI1NTQuLjFjY2EwNDI1ZDQ5MyAxMDA2NDQNCj4gLS0tIGEvZHJp
dmVycy9uZXQvZXRoZXJuZXQvZnJlZXNjYWxlL2ZlYy5oDQo+ICsrKyBiL2RyaXZlcnMvbmV0L2V0
aGVybmV0L2ZyZWVzY2FsZS9mZWMuaA0KPiBAQCAtNjkzLDYgKzY5Myw5IEBAIHN0cnVjdCBmZWNf
ZW5ldF9wcml2YXRlIHsNCj4gDQo+ICAJc3RydWN0IHsNCj4gIAkJaW50IHBwc19lbmFibGU7DQo+
ICsJCXU2NCBuc19zeXMsIG5zX3BoYzsNCj4gKwkJdTMyIGF0X2NvcnI7DQo+ICsJCXU4IGF0X2lu
Y19jb3JyOw0KPiAgCX0gcHRwX3NhdmVkX3N0YXRlOw0KPiANCj4gIAl1NjQgZXRodG9vbF9zdGF0
c1tdOw0KPiBkaWZmIC0tZ2l0IGEvZHJpdmVycy9uZXQvZXRoZXJuZXQvZnJlZXNjYWxlL2ZlY19w
dHAuYw0KPiBiL2RyaXZlcnMvbmV0L2V0aGVybmV0L2ZyZWVzY2FsZS9mZWNfcHRwLmMNCj4gaW5k
ZXggZGYxZWYwMjM0OTNiLi5hNGViNmVkYjg1MGEgMTAwNjQ0DQo+IC0tLSBhL2RyaXZlcnMvbmV0
L2V0aGVybmV0L2ZyZWVzY2FsZS9mZWNfcHRwLmMNCj4gKysrIGIvZHJpdmVycy9uZXQvZXRoZXJu
ZXQvZnJlZXNjYWxlL2ZlY19wdHAuYw0KPiBAQCAtNzY3LDI0ICs3NjcsNDQgQEAgdm9pZCBmZWNf
cHRwX2luaXQoc3RydWN0IHBsYXRmb3JtX2RldmljZSAqcGRldiwgaW50DQo+IGlycV9pZHgpDQo+
ICB2b2lkIGZlY19wdHBfc2F2ZV9zdGF0ZShzdHJ1Y3QgZmVjX2VuZXRfcHJpdmF0ZSAqZmVwKQ0K
PiAgew0KPiAgCXVuc2lnbmVkIGxvbmcgZmxhZ3M7DQo+ICsJdTMyIGF0aW1lX2luY19jb3JyOw0K
PiANCj4gIAlzcGluX2xvY2tfaXJxc2F2ZSgmZmVwLT50bXJlZ19sb2NrLCBmbGFncyk7DQo+IA0K
PiAgCWZlcC0+cHRwX3NhdmVkX3N0YXRlLnBwc19lbmFibGUgPSBmZXAtPnBwc19lbmFibGU7DQo+
IA0KPiArCWZlcC0+cHRwX3NhdmVkX3N0YXRlLm5zX3BoYyA9IHRpbWVjb3VudGVyX3JlYWQoJmZl
cC0+dGMpOw0KPiArCWZlcC0+cHRwX3NhdmVkX3N0YXRlLm5zX3N5cyA9IGt0aW1lX2dldF9ucygp
Ow0KPiArDQo+ICsJZmVwLT5wdHBfc2F2ZWRfc3RhdGUuYXRfY29yciA9IHJlYWRsKGZlcC0+aHdw
ICsgRkVDX0FUSU1FX0NPUlIpOw0KPiArCWF0aW1lX2luY19jb3JyID0gcmVhZGwoZmVwLT5od3Ag
KyBGRUNfQVRJTUVfSU5DKSAmDQo+IEZFQ19UX0lOQ19DT1JSX01BU0s7DQo+ICsJZmVwLT5wdHBf
c2F2ZWRfc3RhdGUuYXRfaW5jX2NvcnIgPSAodTgpKGF0aW1lX2luY19jb3JyID4+DQo+IEZFQ19U
X0lOQ19DT1JSX09GRlNFVCk7DQo+ICsNCj4gIAlzcGluX3VubG9ja19pcnFyZXN0b3JlKCZmZXAt
PnRtcmVnX2xvY2ssIGZsYWdzKTsNCj4gIH0NCj4gDQo+ICAvKiBSZXN0b3JlIFBUUCBmdW5jdGlv
bmFsaXR5IGFmdGVyIGEgcmVzZXQgKi8NCj4gIHZvaWQgZmVjX3B0cF9yZXN0b3JlX3N0YXRlKHN0
cnVjdCBmZWNfZW5ldF9wcml2YXRlICpmZXApDQo+ICB7DQo+ICsJdTMyIGF0aW1lX2luYyA9IHJl
YWRsKGZlcC0+aHdwICsgRkVDX0FUSU1FX0lOQykgJiBGRUNfVF9JTkNfTUFTSzsNCj4gIAl1bnNp
Z25lZCBsb25nIGZsYWdzOw0KPiArCXUzMiBjb3VudGVyOw0KPiArCXU2NCBuczsNCj4gDQo+ICAJ
c3Bpbl9sb2NrX2lycXNhdmUoJmZlcC0+dG1yZWdfbG9jaywgZmxhZ3MpOw0KPiANCj4gIAkvKiBS
ZXNldCB0dXJuZWQgaXQgb2ZmLCBzbyBhZGp1c3Qgb3VyIHN0YXR1cyBmbGFnICovDQo+ICAJZmVw
LT5wcHNfZW5hYmxlID0gMDsNCj4gDQo+ICsJd3JpdGVsKGZlcC0+cHRwX3NhdmVkX3N0YXRlLmF0
X2NvcnIsIGZlcC0+aHdwICsgRkVDX0FUSU1FX0NPUlIpOw0KPiArCWF0aW1lX2luYyB8PSAoKHUz
MilmZXAtPnB0cF9zYXZlZF9zdGF0ZS5hdF9pbmNfY29ycikgPDwNCj4gRkVDX1RfSU5DX0NPUlJf
T0ZGU0VUOw0KPiArCXdyaXRlbChhdGltZV9pbmMsIGZlcC0+aHdwICsgRkVDX0FUSU1FX0lOQyk7
DQo+ICsNCj4gKwlucyA9IGt0aW1lX2dldF9ucygpIC0gZmVwLT5wdHBfc2F2ZWRfc3RhdGUubnNf
c3lzICsNCj4gZmVwLT5wdHBfc2F2ZWRfc3RhdGUubnNfcGhjOw0KPiArCWNvdW50ZXIgPSBucyAm
IGZlcC0+Y2MubWFzazsNCj4gKwl3cml0ZWwoY291bnRlciwgZmVwLT5od3AgKyBGRUNfQVRJTUUp
Ow0KPiArCXRpbWVjb3VudGVyX2luaXQoJmZlcC0+dGMsICZmZXAtPmNjLCBucyk7DQo+ICsNCj4g
IAlzcGluX3VubG9ja19pcnFyZXN0b3JlKCZmZXAtPnRtcmVnX2xvY2ssIGZsYWdzKTsNCj4gDQo+
ICAJLyogUmVzdGFydCBQUFMgaWYgbmVlZGVkICovDQo+IC0tDQo+IDIuMzQuMQ0KPiANClRoYW5r
cywNCg0KUmV2aWV3ZWQtYnk6IFdlaSBGYW5nIDx3ZWkuZmFuZ0BueHAuY29tPg0K

