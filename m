Return-Path: <netdev+bounces-189608-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 30F98AB2D09
	for <lists+netdev@lfdr.de>; Mon, 12 May 2025 03:34:42 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id B3DCF3BB755
	for <lists+netdev@lfdr.de>; Mon, 12 May 2025 01:33:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 66C1A20D4F4;
	Mon, 12 May 2025 01:28:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=silabs.com header.i=@silabs.com header.b="mnFpCRkH";
	dkim=pass (1024-bit key) header.d=silabs.com header.i=@silabs.com header.b="WBTbl9ow"
X-Original-To: netdev@vger.kernel.org
Received: from mx0b-0024c301.pphosted.com (mx0b-0024c301.pphosted.com [148.163.153.153])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5EFDC1E25F2;
	Mon, 12 May 2025 01:28:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=148.163.153.153
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747013303; cv=fail; b=WUiDyiyXq28StzmrDb7Ab5Mv7rtaVPaHCN9Q8SQqW3ua/ZAbBzToEogqv5bJwGfRFouL/3o6NtPr25NRtuyaFjP1YF5O4EttoF4sOCrVWj7nUWRwHHUs/dEn1HvfIvXo6O3piWg3JSJySJMyJCvTiuVkTow3j4h+6Xtp2T0i3nU=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747013303; c=relaxed/simple;
	bh=eK/k7EIovkmSZVjKEIsFaBDoRXRMlAFp2GgYQCnyZ7c=;
	h=From:To:Subject:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=U0K78WxVbftQEqDxytx9X2C6AaYhSPrRzyiOdiVZr9QZ/iinNyPrzcXo5IpSRvp7SIXQ47888qrMajfrJExcjql3pVZe4Up895WAwsOAWjueVCSVS9wAQ/OlRHiZL38MXV3iw2e9xJWXHwS2TNYvdwsfIej4Ah9ys2u7XO15sYo=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=silabs.com; spf=pass smtp.mailfrom=silabs.com; dkim=pass (2048-bit key) header.d=silabs.com header.i=@silabs.com header.b=mnFpCRkH; dkim=pass (1024-bit key) header.d=silabs.com header.i=@silabs.com header.b=WBTbl9ow; arc=fail smtp.client-ip=148.163.153.153
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=silabs.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=silabs.com
Received: from pps.filterd (m0101742.ppops.net [127.0.0.1])
	by mx0a-0024c301.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 54BNrm01027097;
	Sun, 11 May 2025 20:28:03 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=silabs.com; h=
	content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=pps12202023;
	 bh=M/DQRublAT2MI+0O6RjdaAVpBmczJipl8PbsdN2HZEM=; b=mnFpCRkHLxs2
	sHPsNCBJ90O8W/x3xQZE7y2gUlKX6uUW6pQX3dVHMCp46nmFCHR/nlMbJGk77/SD
	hw1mTy3TxnJ1RANZUsvI70u7k6Tdb54fJ7f3KFeOPZTUk23D8C6qBe9Www7hxmC/
	gIGuBc0HqkSg1hEIcR4R27FipmuJqZWc3MHAzI0Aq0h5Wi0ekKmdfxuG9Zk5Gvq+
	lFS6VRwTwJBd/VHFH5v34p+QFzHKeB+ImQmSSLVCb5gP27Yhzd7gT+7YvQ0Cic00
	RZq34x0k5Fu5nf1GX0DmCHBdT6q350TPRSonDSZXg2BOaRo0fsyx8iasOurKWSGA
	7cyUMeajpQ==
Received: from nam11-dm6-obe.outbound.protection.outlook.com (mail-dm6nam11lp2171.outbound.protection.outlook.com [104.47.57.171])
	by mx0a-0024c301.pphosted.com (PPS) with ESMTPS id 46j0aahxd2-3
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Sun, 11 May 2025 20:28:02 -0500 (CDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=jLHwkanHtXH7I+o/C4TtK7/y9UqoOLPO5yULjYwNSse8DeCQvDX9PBKah8JYSqfJ1P2Yso9uwCt78Wf5inwaiF5WhF4Zf2qO8dFK4/AGWhLY+qETvY1SIOqreCjSx7p4zUI0QgLawO8WPj1Y2qCWe9JRFJbnDSnX2RbPqYGxbM7P/FvX2I7A13WQLB213+JWQuANQP70qsdVnoqs7jKnWCAoIEMC9PD+NBdBrqL7eOnRiVfd/mH5apEmPc+ICKZPwLz9jZr/LfzBjaCJG0xz3hmsDg77pjOGfkNtEN3BE/qXPdx8KX8UA3ToCMnRlncMrN5F2oYMZBgO3c3H9J4Waw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=M/DQRublAT2MI+0O6RjdaAVpBmczJipl8PbsdN2HZEM=;
 b=KeuM7yv3ey87F+AxQLsqfYlMjlOqm2R6RD13LCF/lMu7oJDei4/LWHmJQeXF5s08DN7vn49LSwyIDRGjC31bjYm+qNWCjikX31QgYfzAopFkeGnAYmApNs8iQLlxyYrYZYkBXAvZI3R6YQ7nzAs1WL5N8EZymz/QEGYBrOZ6SjN3wJs0xOFJ9QY4Fcy5HYWW7a+cIQeeW1hsQmLOq5D/rooGVAS1Req2sxKSgIyraQZfNyI/TOLRVvdo6Vo90XG5R8arhkTNPxrju+JccoNxF39KvaBxOryhQFFASactVNnAV5JYKNMaBc7mbdViZiuhjfne/JnrK2brTZh3Nc0TrA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=silabs.com; dmarc=pass action=none header.from=silabs.com;
 dkim=pass header.d=silabs.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=silabs.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=M/DQRublAT2MI+0O6RjdaAVpBmczJipl8PbsdN2HZEM=;
 b=WBTbl9ow0gfJ4WyUV8r10HNYz/hQ8IUxfOeLNmTXZM4jeyFnJan84VSI3xcqeohxKbuaLDqrQ8I1WI7bEa7aT0cgVycGIoJi33lWYgHTaQaBk7+KFvhwbklNrbg6bTHfUnVn/P5s2spJNJOQI87HSsFR3fuXaTry+KvUXWo3MUM=
Received: from DS0PR11MB8205.namprd11.prod.outlook.com (2603:10b6:8:162::17)
 by IA0PR11MB7953.namprd11.prod.outlook.com (2603:10b6:208:40d::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8722.29; Mon, 12 May
 2025 01:27:58 +0000
Received: from DS0PR11MB8205.namprd11.prod.outlook.com
 ([fe80::c508:9b04:3351:524a]) by DS0PR11MB8205.namprd11.prod.outlook.com
 ([fe80::c508:9b04:3351:524a%4]) with mapi id 15.20.8699.026; Mon, 12 May 2025
 01:27:58 +0000
From: =?UTF-8?q?Damien=20Ri=C3=A9gel?= <damien.riegel@silabs.com>
To: Andrew Lunn <andrew+netdev@lunn.ch>,
        "David S . Miller" <davem@davemloft.net>,
        Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>,
        Paolo Abeni <pabeni@redhat.com>, Rob Herring <robh@kernel.org>,
        Krzysztof Kozlowski <krzk+dt@kernel.org>,
        Conor Dooley <conor+dt@kernel.org>,
        Silicon Labs Kernel Team <linux-devel@silabs.com>,
        netdev@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: [RFC net-next 01/15] net: cpc: add base skeleton driver
Date: Sun, 11 May 2025 21:27:34 -0400
Message-ID: <20250512012748.79749-2-damien.riegel@silabs.com>
X-Mailer: git-send-email 2.49.0
In-Reply-To: <20250512012748.79749-1-damien.riegel@silabs.com>
References: <20250512012748.79749-1-damien.riegel@silabs.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: YT4PR01CA0451.CANPRD01.PROD.OUTLOOK.COM
 (2603:10b6:b01:10d::17) To DS0PR11MB8205.namprd11.prod.outlook.com
 (2603:10b6:8:162::17)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS0PR11MB8205:EE_|IA0PR11MB7953:EE_
X-MS-Office365-Filtering-Correlation-Id: 1990e2da-79fd-48a5-55dd-08dd90f43a75
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|376014|7416014|52116014|1800799024|366016|38350700014|921020;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?aXJ3RXJ6WDZHSU9wRHhoSm5XdmlPR2ovZGxvZy9QOG05YTh2WW1nWG5pa0pI?=
 =?utf-8?B?YmRBL1JqS0FjdEVTU2E3ZWhYWGxqU1cwWm1zWTh4UWM1N1R5S0w2OFNBYWJw?=
 =?utf-8?B?UWw4Wmt0SWNHS1A0di9UUWg1LzZCdHh1QlUxN2o0Nlc4bE5SRHVOcGJPaTcw?=
 =?utf-8?B?amVCQWZyOUlSN1JobitpdlBEblU1VEtUcVVsQ3d6MnJoMW1NKzFreU1xdzV5?=
 =?utf-8?B?TGpuNmVnTHdpT0VRZUZpMVdRbm80KzE4VlBUaVlFZmFCTUVycSsrSkxNdWFW?=
 =?utf-8?B?d3NQMGthUUI2TUtscTRtbDRaU1NjYkpuaXFHbExJSXgrazQ2bXRLMDJWL0gx?=
 =?utf-8?B?Nm45cmJqUG9kdHZsc1J4ZmxOMDNmdHhuendBV1hobkwyc1VXRGl6K0dQUzFz?=
 =?utf-8?B?YVc3TXZuczgwTEhTQ1kwc2EvWVJlNEZIbGNYSzFrVGh5RWhQRVdtc1ZlUzdj?=
 =?utf-8?B?YmdEU1dLaEpPcDR2TUJwaGRPdXJMem5sRnRyRTRpS2VXZ2RIU3ZTM1pOYStk?=
 =?utf-8?B?aXZsRTd3TUdFUEJ2RjlGb1N4RDFGQVh5d1BZT2xqTms4WVB6d1ZUMkh1eVlZ?=
 =?utf-8?B?NytvbXI3UlY1ZXlPK2ZMT3B1MGtYcCtrcXkreFhIMzVqNU9iR0FNTk1yaWsr?=
 =?utf-8?B?RjRsYmw2L01qZHRQdDB1YXBqUWlkK0U3TW9nRlI1STBqbGUyZjFwL2VpWDdF?=
 =?utf-8?B?cFR6K2drdHN5WWhtdElEbWkwZE9IZ1NLbng3RkxkaEJLRGpkelhJTkJlU2tx?=
 =?utf-8?B?MkVQMVVaWHYvOUdKSk1ZaGcwcHc3VHRiOTdKS0hlOENOazRhVUFDK1pnbHZy?=
 =?utf-8?B?RmZyNkpRQUgrVDhsME5UUVUxVHVmM3lDWVpReEcvZXFNZUZiMkFUdlFQYkxu?=
 =?utf-8?B?djg5amJjZWlzRUJIOUhZejJyOXFnSDh0dkd4bFNnY2dEbHhkTCtSamtsV0Zt?=
 =?utf-8?B?MU5GMjBhWHhGVWgrc3dYT0xldlZ4d1ErUmhqMWFWMnpQUjNOYm8xenpLN0N2?=
 =?utf-8?B?cGhaSTVncHFaSGtnVWlsZ2crV0l4c3QyQjZMcUZoZUIrUitjc2hUODk4VURr?=
 =?utf-8?B?Yy9UK1B6SmQ0Y3I1UmJoZVJieHFSTk9tYk1WYnJGZTRQSzFvSDkzdEF5ZGVu?=
 =?utf-8?B?ZTRic2czWERCcllxZ1JldHJiQmtVamJRRUI1MW5QWmswcFNkL1Q2dUxNS2h3?=
 =?utf-8?B?NjFyTEh0L3ltMTNCZC9SU2hxUFNXVHdSMFhjTmpORUtWdXJZNEIwR3RKSHVU?=
 =?utf-8?B?Q1dScFpVWWRMWmdKUS9HOEUvVk03YnFCYjA2Mlh2aktKK2RiWkExclBTcjQ4?=
 =?utf-8?B?bGl1ZlBseTR1ekdxaUVmM2kyZ3ZqWU5PY2VHSjh1QmlvRnBwTXlYYks5WjB1?=
 =?utf-8?B?djFTREtUYXBXWGNDUzVuYnF1QXM2MnpiNFJDRUR3a3VyYXd1NHNyb21nSml1?=
 =?utf-8?B?Z3Jrd2lySlZoZGE4OFVTaUdnVXB5REhIaHR1a0hTV2VTeUhUK2k1bWo1ZmdY?=
 =?utf-8?B?S0FuM3R6VWZTWDJaQWNaRStYZFdwN0U5UUxKZ1IrdCtIb0JNcWszRTMzVXFn?=
 =?utf-8?B?TE1uQmh2N01ibXN0MzF0YVNSU1l2WkxwMXJHRWVOSVQ5ZFFZNTE3TkdyaG1X?=
 =?utf-8?B?bDZKVEJvTERodmZ2TmJDNHhJNnV1a2RFY1RXNlVEUnRndG9RczBPbWRBVlpr?=
 =?utf-8?B?OC9GamZ4MFpZb3kwL1B2SlUxbXhYWHFIUDYzcm02UTNEeDZRU3ZNNDBFTlVl?=
 =?utf-8?B?OEUxaTBIK1k0S1FFcjNqcUM1ZkNRM0VxUXRzcCs2Wnd3cUpoN3pwbWRsZFE2?=
 =?utf-8?B?bXBLM3Z3bElqZ3Ezd0tWdzczdE96OVIwcEJESHRvRXJOclBFOGIwQXVoUklp?=
 =?utf-8?B?dlNWRnVwRlJESnlrMS9FMm4vdDl0RTAra3NuQksxQ3hwekRjaVRKZkxxbnhk?=
 =?utf-8?B?dXRqYlJOQjlpM0x3bmIzUy9LSkZqL2FqaWQyZmNMYmhDdUVyZ2FzQzNCMmY2?=
 =?utf-8?Q?B9wuQgOEs8nYJY5y836txS7tUcz9BE=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DS0PR11MB8205.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(7416014)(52116014)(1800799024)(366016)(38350700014)(921020);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?TzNGd1NJV2J2d3U2SkdhUlNIVldSMHlnSU16b3FDUXNWWWVuTXl2UXVoVFZH?=
 =?utf-8?B?dW11a2VXZ3VYdjFxTUJoajE3d1BITSs1RUY1b1doWkNZeWNhbGhLMjZ5UzNY?=
 =?utf-8?B?elRZbTBBcEthUWE5dWRnMmtUa3A4NkgyYUhHZmJiZ2Y0TTdPNUdRK05tZGN0?=
 =?utf-8?B?cjFlYzdnQTFTVHNCRmV6N2h2ZTczRjFsaEgyYkkrMlVQZytnbHhYRXhMYWV0?=
 =?utf-8?B?aWFEK1ErQ0tUV2lYT1NCZWZSRndLbkVwQjlRRGNkdUhibldiY2h4WkJUM0h6?=
 =?utf-8?B?d3lTbDN4N3NiMk9XbFAyMXlaWHErSlJzQWNJbE85Q29NbEplazZqZTFCMTZ3?=
 =?utf-8?B?L0dkMEhrUlJqY0dKT21UQ0Jtdml4alhUVkZ5akpzaEdtSEM1aUF3Ri9oRFVS?=
 =?utf-8?B?SmtqOUxsT1RnQ1E0VE9zLzZvVmQ0V1ZYbzdIbytFWXFyRi9kZnQ2bXNLY1Fi?=
 =?utf-8?B?T1VmME1SRlV0K1MwR3IwQjFZcmh2dEJaMXEwa0N0d0FsRW1lQyt6K3ZTZGhV?=
 =?utf-8?B?MDFpczNsbFdpNEI0UUg2VVhjRTlDVmQ2YlB5MkwxYWRPUDVXck1OclpZcEpK?=
 =?utf-8?B?enpBNzVDZUJHY0F4d1o0a2E4SFpKeEs4S2JHMVhYdHNqVWkzOE9UK1lqM2Jv?=
 =?utf-8?B?bXBKZUVodkVQR1JuVXRNUTRJc3dFSlNMUmpiMVh4NkQwUWkveFRQVWpaSDdp?=
 =?utf-8?B?dSszR1h3WVlua3dyakh6VllBN2t4UzJhUFJIK2dtbEVmZDcwS09abmNUSlV1?=
 =?utf-8?B?dXJPYXllQXZtQ0JTQVZrYndySjhvc0NWb3hGQjVDaTAybXgxYXZkQllaRmha?=
 =?utf-8?B?N0ZsWFM0UnBzU0NtRVh3SkEvUEp0YmtvZzdpSmxIVlJNS045MHFhelRDTlVY?=
 =?utf-8?B?ZEFzeVpKS3hnY01FTG9XNlNDVk82TWxMOEZqTkxzcktReC9zelc4UzJxOVpu?=
 =?utf-8?B?S3QxdlJuOWhqdUJtYUlRQnp4N2hFenhQV2tGallQaUt3WUJlR0Z5bk5pSTZY?=
 =?utf-8?B?SGVxVUVmQm93T3JlWmZaZDZQQTB0N0E2WnIrOEg0V0RLVmtzRTJDVWtPcWJN?=
 =?utf-8?B?K2VTY2V5enNCWFdsOXFmcjRKYzBUMHQzVEhrdjBXRXFUc3UrZENWcHFiVE1y?=
 =?utf-8?B?akNNYVJwZUlrREFhSHNvR0ZQejl2K0daZWh4Qmp1cGE1NzEyVjFMY1R0ZUI5?=
 =?utf-8?B?MXdMVVM2NXd1cE5SR01CS0tQMFZHR3JkVnFSdEdmRC9hY1pSUSs1Q2RKMFp3?=
 =?utf-8?B?cUxnRmUvNGdvbEpzaU11M2paK08wRzRkRllCVkgxM1kxa2NCaWUreHJYcDhr?=
 =?utf-8?B?bWs1VEd4UCt0bDEyaHcxendMNzdadCtkdHZTVVB0SDRxdEx0cENrWi84WnBv?=
 =?utf-8?B?UlBJSDdXbWhqWi9ncEFTWHFDaUE2N1pKeEp5bTRRQXIvMWVOTDdSSVNZSDZK?=
 =?utf-8?B?R3VTVXNiOUZyNkhLV0pyTDhhZWhGUmlsNHgzbWhWR1RnSXZrOWx6SlRpREpm?=
 =?utf-8?B?ODl4RitwZDlOcDFHeXNiSzNNYlZ4SUdoRHE1eFR1by9JNDdYQWVCRnRVYVA0?=
 =?utf-8?B?TzlwNURGeGlTeFBMcWtqajUwMEN0MURKS1VvdmF2ZUNCU0JyVkdTcDhwRzNy?=
 =?utf-8?B?M3VJdFlKOTUrZGdXNWIxL1U5VkJ6ZUgrdUN2WEJ6SjJLOG0rQVdEaHZKL3lT?=
 =?utf-8?B?QThJVEowYit5RGM2SkduZGZpQ1RaUFBlaWZKcUFZekhEVkduQ2thT1hab3Nw?=
 =?utf-8?B?WDdDTTNLTFBaaVZnSm0wWmRkdENzVGVjbktKUlMrUmgzWU5SL1cxM2o1djBK?=
 =?utf-8?B?QWM1TFd4WEM0MFF0VEhEK2FKVUZWMDkxRzlic0Q5Nkg0ejVOMlFua0ErYStr?=
 =?utf-8?B?d0NHaVRYb3J0anZnd3lBL2ZnUUtINUtXeUpDWmFYbmpYejBjUFZKcjkyM0Zn?=
 =?utf-8?B?L0JmZndLOHo1U0podWFyWFVtMDJJYlNDTm1zVGNYenlUUElidWtwanV3Z1dK?=
 =?utf-8?B?R3A2a1hMdXI5Q2JvMHlQSUZoenZEK3RlQW1qeVJOQU8vU2FRNHJpUFR3U3JM?=
 =?utf-8?B?cUM1WkRteDlGQnFBaHNIaTNlUlFGNFRXWWJiNkthQnYvTHU0WVFLcE9nTldF?=
 =?utf-8?Q?TWSZ4J0DjLAmu8X/xUFGSfvn2?=
X-OriginatorOrg: silabs.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 1990e2da-79fd-48a5-55dd-08dd90f43a75
X-MS-Exchange-CrossTenant-AuthSource: DS0PR11MB8205.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 12 May 2025 01:27:58.4845
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 54dbd822-5231-4b20-944d-6f4abcd541fb
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: ov1QQEtAB5OpM5UVyX474qRjkNo/dxdU60QID3tzuBDH5lPzAAwO/kty36a1ChmoHASVQ2JtlzbYIQp8MsjgzQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA0PR11MB7953
X-Proofpoint-GUID: 4y9mDwosoPb03cOtU86rCcxVcf-p3tNI
X-Authority-Analysis: v=2.4 cv=TMNFS0la c=1 sm=1 tr=0 ts=68214ea2 cx=c_pps a=gIIqiywzzXYl0XjYY6oQCA==:117 a=lCpzRmAYbLLaTzLvsPZ7Mbvzbb8=:19 a=wKuvFiaSGQ0qltdbU6+NXLB8nM8=:19 a=Ol13hO9ccFRV9qXi2t6ftBPywas=:19 a=xqWC_Br6kY4A:10 a=IkcTkHD0fZMA:10
 a=dt9VzEwgFbYA:10 a=M51BFTxLslgA:10 a=i1IsUcr2s-wA:10 a=2AEO0YjSAAAA:8 a=amLC3slWZ4KB8aZvhWUA:9 a=3ZKOabzyN94A:10 a=QEXdDO2ut3YA:10
X-Proofpoint-ORIG-GUID: 4y9mDwosoPb03cOtU86rCcxVcf-p3tNI
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwNTEyMDAxMyBTYWx0ZWRfX49B7FK/slHNO v+NX+sJE28SKuqwTD9mV0HtV5WB1tERCDqpUaW2goGudfiF58Z7qgCdwrfFTNWIYErBf2A1TBcz jMOLFRRxef7Z9cVDg7chKxZtHIch+EGxRusS4mLsapGKj+QobXOER/wftZ1HY4iube8vB8LIiwn
 v9WalYBksouOsL1aSBYtItl7w3TVR945cwQtwym3SWHK4COqdHzNP7ZuIdymj886zMpJvNGukbm aDlM3ORcOdpjFOKlQh3/NsO4wNdx7Pj2GOCDxKLWs6UiPdpHfDdVi22qkSzHIuTBSlfc9XwBow3 Aw9BbqzxruiuB1qtEd5l6uhzBy5LND42R54koOyNVAROEns7FtCQPxHFVKZ7BfAnD9xtSABSaop
 eQPLjH0lz7u01NxtNsWays4iucF0jWFDgyCRRpKNDDmw9aw1ikaNBgzBIFvgAtiT9LNFRsSb
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.0.736,FMLib:17.12.80.40
 definitions=2025-05-11_10,2025-05-09_01,2025-02-21_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 lowpriorityscore=0
 priorityscore=1501 mlxlogscore=999 phishscore=0 mlxscore=0 bulkscore=0
 spamscore=0 clxscore=1011 impostorscore=0 adultscore=0 malwarescore=0
 suspectscore=0 classifier=spam authscore=0 authtc=n/a authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.21.0-2504070000
 definitions=main-2505120013

This commit prepares the addition of a CPC driver. CPC, standing for
Co-Processor Communication, enables users to have multiple stack
protocols over a shared physical link using multiple endpoints.

This patch adds the basic infrastructure for the new module, and
introduces a new structure `cpc_interface`. The goal of this structure
is to abstract a physical link like an SPI device, a SDIO function, or a
UART for instance.

Signed-off-by: Damien Riégel <damien.riegel@silabs.com>
---
 MAINTAINERS                 |  6 +++
 drivers/net/Kconfig         |  2 +
 drivers/net/Makefile        |  1 +
 drivers/net/cpc/Kconfig     | 15 ++++++
 drivers/net/cpc/Makefile    |  5 ++
 drivers/net/cpc/interface.c | 98 +++++++++++++++++++++++++++++++++++++
 drivers/net/cpc/interface.h | 88 +++++++++++++++++++++++++++++++++
 drivers/net/cpc/main.c      | 21 ++++++++
 8 files changed, 236 insertions(+)
 create mode 100644 drivers/net/cpc/Kconfig
 create mode 100644 drivers/net/cpc/Makefile
 create mode 100644 drivers/net/cpc/interface.c
 create mode 100644 drivers/net/cpc/interface.h
 create mode 100644 drivers/net/cpc/main.c

diff --git a/MAINTAINERS b/MAINTAINERS
index 00e94bec401..8256ec0ff8a 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -21731,6 +21731,12 @@ S:	Maintained
 F:	drivers/input/touchscreen/silead.c
 F:	drivers/platform/x86/touchscreen_dmi.c
 
+SILICON LABS CPC DRIVERS
+M:	Damien Riégel <damien.riegel@silabs.com>
+R:	Silicon Labs Kernel Team <linux-devel@silabs.com>
+S:	Supported
+F:	drivers/net/cpc/*
+
 SILICON LABS WIRELESS DRIVERS (for WFxxx series)
 M:	Jérôme Pouiller <jerome.pouiller@silabs.com>
 S:	Supported
diff --git a/drivers/net/Kconfig b/drivers/net/Kconfig
index 1fd5acdc73c..d78ca2f4de5 100644
--- a/drivers/net/Kconfig
+++ b/drivers/net/Kconfig
@@ -508,6 +508,8 @@ source "drivers/atm/Kconfig"
 
 source "drivers/net/caif/Kconfig"
 
+source "drivers/net/cpc/Kconfig"
+
 source "drivers/net/dsa/Kconfig"
 
 source "drivers/net/ethernet/Kconfig"
diff --git a/drivers/net/Makefile b/drivers/net/Makefile
index 13743d0e83b..19878d11c62 100644
--- a/drivers/net/Makefile
+++ b/drivers/net/Makefile
@@ -49,6 +49,7 @@ obj-$(CONFIG_MHI_NET) += mhi_net.o
 obj-$(CONFIG_ARCNET) += arcnet/
 obj-$(CONFIG_CAIF) += caif/
 obj-$(CONFIG_CAN) += can/
+obj-$(CONFIG_CPC) += cpc/
 ifdef CONFIG_NET_DSA
 obj-y += dsa/
 endif
diff --git a/drivers/net/cpc/Kconfig b/drivers/net/cpc/Kconfig
new file mode 100644
index 00000000000..f31b6837b49
--- /dev/null
+++ b/drivers/net/cpc/Kconfig
@@ -0,0 +1,15 @@
+# SPDX-License-Identifier: GPL-2.0
+
+menuconfig CPC
+	tristate "Silicon Labs Co-Processor Communication (CPC) Protocol"
+	depends on NET
+	help
+	  Provide support for the CPC protocol to Silicon Labs EFR32 devices.
+
+	  CPC provides a way to multiplex data channels over a shared physical
+	  link. These data channels can carry Bluetooth, Wi-Fi, or any arbitrary
+	  data. Depending on the part and the firmware, the set of available
+	  channels may differ.
+
+	  Say Y here to compile support for CPC into the kernel or say M to
+	  compile as a module.
diff --git a/drivers/net/cpc/Makefile b/drivers/net/cpc/Makefile
new file mode 100644
index 00000000000..1ce7415f305
--- /dev/null
+++ b/drivers/net/cpc/Makefile
@@ -0,0 +1,5 @@
+# SPDX-License-Identifier: GPL-2.0
+
+cpc-y := interface.o main.o
+
+obj-$(CONFIG_CPC)	+= cpc.o
diff --git a/drivers/net/cpc/interface.c b/drivers/net/cpc/interface.c
new file mode 100644
index 00000000000..4fdc78a0868
--- /dev/null
+++ b/drivers/net/cpc/interface.c
@@ -0,0 +1,98 @@
+// SPDX-License-Identifier: GPL-2.0
+/*
+ * Copyright (c) 2025, Silicon Laboratories, Inc.
+ */
+
+#include <linux/module.h>
+
+#include "interface.h"
+
+#define to_cpc_interface(d) container_of(d, struct cpc_interface, dev)
+
+static DEFINE_IDA(cpc_ida);
+
+/**
+ * cpc_intf_release() - Actual release of interface.
+ * @dev: Device embedded in struct cpc_interface
+ *
+ * This function should not be called directly, users are expected to use cpc_interface_put()
+ * instead. This function will be called when the last reference to the CPC device is released.
+ */
+static void cpc_intf_release(struct device *dev)
+{
+	struct cpc_interface *intf = to_cpc_interface(dev);
+
+	ida_free(&cpc_ida, intf->index);
+	kfree(intf);
+}
+
+/**
+ * cpc_interface_alloc() - Allocate memory for new CPC interface.
+ *
+ * @parent: Parent device.
+ * @ops: Callbacks for this device.
+ * @priv: Pointer to private structure associated with this device.
+ *
+ * Context: Process context as allocations are done with @GFP_KERNEL flag
+ *
+ * Return: allocated CPC interface or %NULL.
+ */
+struct cpc_interface *cpc_interface_alloc(struct device *parent,
+					  const struct cpc_interface_ops *ops,
+					  void *priv)
+{
+	struct cpc_interface *intf;
+
+	intf = kzalloc(sizeof(*intf), GFP_KERNEL);
+	if (!intf)
+		return NULL;
+
+	intf->index = ida_alloc(&cpc_ida, GFP_KERNEL);
+	if (intf->index < 0) {
+		kfree(intf);
+		return NULL;
+	}
+
+	intf->ops = ops;
+
+	intf->dev.parent = parent;
+	intf->dev.release = cpc_intf_release;
+
+	device_initialize(&intf->dev);
+
+	dev_set_name(&intf->dev, "cpc%d", intf->index);
+	dev_set_drvdata(&intf->dev, priv);
+
+	return intf;
+}
+
+/**
+ * cpc_interface_register() - Register CPC interface.
+ * @intf: CPC device to register.
+ *
+ * Context: Process context.
+ *
+ * Return: 0 if successful, otherwise a negative error code.
+ */
+int cpc_interface_register(struct cpc_interface *intf)
+{
+	int err;
+
+	err = device_add(&intf->dev);
+	if (err)
+		return err;
+
+	return 0;
+}
+
+/**
+ * cpc_interface_unregister() - Unregister a CPC interface.
+ * @intf: CPC device to unregister.
+ *
+ * Context: Process context.
+ */
+void cpc_interface_unregister(struct cpc_interface *intf)
+{
+	device_del(&intf->dev);
+	cpc_interface_put(intf);
+}
diff --git a/drivers/net/cpc/interface.h b/drivers/net/cpc/interface.h
new file mode 100644
index 00000000000..797f70119a8
--- /dev/null
+++ b/drivers/net/cpc/interface.h
@@ -0,0 +1,88 @@
+/* SPDX-License-Identifier: GPL-2.0 */
+/*
+ * Copyright (c) 2025, Silicon Laboratories, Inc.
+ */
+
+#ifndef __CPC_INTERFACE_H
+#define __CPC_INTERFACE_H
+
+#include <linux/device.h>
+#include <linux/list.h>
+#include <linux/mutex.h>
+#include <linux/skbuff.h>
+
+struct cpc_interface;
+struct cpc_interface_ops;
+
+/**
+ * struct cpc_interface - Representation of a CPC interface.
+ * @dev: Device structure for bookkeeping..
+ * @ops: Callbacks for this device.
+ * @index: Device index.
+ */
+struct cpc_interface {
+	struct device dev;
+
+	const struct cpc_interface_ops *ops;
+
+	int index;
+};
+
+/**
+ * struct cpc_interface_ops - Callbacks from CPC core to physical bus driver.
+ * @wake_tx: Called by CPC core to wake up the transmit task of that interface.
+ * @csum: Callback to calculate checksum over the payload.
+ *
+ * This structure contains various callbacks that the bus (SDIO, SPI) driver must implement.
+ */
+struct cpc_interface_ops {
+	int (*wake_tx)(struct cpc_interface *intf);
+	void (*csum)(struct sk_buff *skb);
+};
+
+struct cpc_interface *cpc_interface_alloc(struct device *parent,
+					  const struct cpc_interface_ops *ops,
+					  void *priv);
+
+int cpc_interface_register(struct cpc_interface *intf);
+void cpc_interface_unregister(struct cpc_interface *intf);
+
+/**
+ * cpc_interface_get() - Get a reference to interface and return its pointer.
+ * @intf: Interface to get.
+ *
+ * Return: Interface pointer with its reference counter incremented, or %NULL.
+ */
+static inline struct cpc_interface *cpc_interface_get(struct cpc_interface *intf)
+{
+	if (!intf || !get_device(&intf->dev))
+		return NULL;
+	return intf;
+}
+
+/**
+ * cpc_interface_put() - Release reference to an interface.
+ * @intf: CPC interface
+ *
+ * Context: Process context.
+ */
+static inline void cpc_interface_put(struct cpc_interface *intf)
+{
+	if (intf)
+		put_device(&intf->dev);
+}
+
+/**
+ * cpc_interface_get_priv() - Get driver data associated with this interface.
+ * @intf: Interface pointer.
+ *
+ * Return: Driver data, set at allocation via cpc_interface_alloc().
+ */
+static inline void *cpc_interface_get_priv(struct cpc_interface *intf)
+{
+	if (!intf)
+		return NULL;
+	return dev_get_drvdata(&intf->dev);
+}
+
+#endif
diff --git a/drivers/net/cpc/main.c b/drivers/net/cpc/main.c
new file mode 100644
index 00000000000..ba9ab1ccf63
--- /dev/null
+++ b/drivers/net/cpc/main.c
@@ -0,0 +1,21 @@
+// SPDX-License-Identifier: GPL-2.0
+/*
+ * Copyright (c) 2025, Silicon Laboratories, Inc.
+ */
+
+#include <linux/module.h>
+
+static int __init cpc_init(void)
+{
+	return 0;
+}
+module_init(cpc_init);
+
+static void __exit cpc_exit(void)
+{
+}
+module_exit(cpc_exit);
+
+MODULE_DESCRIPTION("Silicon Labs CPC Protocol");
+MODULE_AUTHOR("Damien Riégel <damien.riegel@silabs.com>");
+MODULE_LICENSE("GPL");
-- 
2.49.0


