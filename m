Return-Path: <netdev+bounces-224378-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A135EB843C8
	for <lists+netdev@lfdr.de>; Thu, 18 Sep 2025 12:55:29 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 52CD3466939
	for <lists+netdev@lfdr.de>; Thu, 18 Sep 2025 10:55:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 86E962FBE1E;
	Thu, 18 Sep 2025 10:55:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=altera.com header.i=@altera.com header.b="QILcSkxq"
X-Original-To: netdev@vger.kernel.org
Received: from CH4PR04CU002.outbound.protection.outlook.com (mail-northcentralusazon11013064.outbound.protection.outlook.com [40.107.201.64])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7BD8E2F25E9;
	Thu, 18 Sep 2025 10:55:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.201.64
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758192922; cv=fail; b=iDCSmgSXfrutPGutSoPio92v1ug0yPJDdhIjB2wo5D6o3zlPsuBRUb/cnCrbMM8T4MHjtqht0HaFGnhSkuPre/sfQl3hQSBQHvbxQTNUI09++w2gmExN36AA/WUlZV3olBfb2TDZ1J8DQunCTsu5qnJZumSiVgig/4u14s3Qa2k=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758192922; c=relaxed/simple;
	bh=STPBuHbdQL63NiFvwzZFD/o23/c1O0bhxOGKrU/GlYA=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=hj2dlO8W6sFrmp6BlvjDryLWhHPAorG8IgMbMnh8bVHUkRwq4LsClyTVVDOeEBl7S14ZFBpYK1/rzw0nklDwkFsY3sIeNnogBQEOKQkZfg6TyheeWTu50Bgdvgn4T2DxdVVhWJ8a+aMInKZJUDdZ/mf7Xe9E8EyVLpymrrPF7F4=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=altera.com; spf=pass smtp.mailfrom=altera.com; dkim=pass (2048-bit key) header.d=altera.com header.i=@altera.com header.b=QILcSkxq; arc=fail smtp.client-ip=40.107.201.64
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=altera.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=altera.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=oGoLwrjt9v8A4N51kU2JAjpvZBMt974pO4rBPexV2py6ye64IAuxWKxyE9Z59S9AeMd6wD1QG03IxRk7ukoges+mab8RpPV//KpSXGx8c4xAKWrMqDiKshdNMcqiphjZdMIXlPcBr+T3pUenLOCXSgM6OmM5c4LDUAyiihcr+NX3Qxe1AM9HWvIxcVDkjLHnjrUXMWd8wIwUZg3Tj1kB6aOh+HxIRqq0sftgBh/C41qZG4DS2K6njKkKQRMd5s78iSiteApqH6+cvj8YaGicwqQNvcEplwJ3dWg+Jx/kfIkBVDBfd8x+d3B5qk1C9H0jI6mLl7fpoD7b+HmoFLX+Ww==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=aKXv9GFbuVOE5qf6K6IHzS8o04CSaTpA1oplbvaAR2c=;
 b=QvrixxxgXDx5r4HMszJoVqsdd78HMiLIhTWMbATMseJcNqHa1wBcanc+CiX7Zj6JGVXmEJ4G0pEYibRci4z/qwo7h7mbG9EgPcOWwmuC50ioc3fRE/Sybjbvqsv9w6ivuHVLnFfe4YIQGNEcO4MRD2EtbVREIdbKk3gfinf8O3+pTfOogj9d6JjgSzrFYOPcbqq4B6Z1SA8tJoSvAmFwk4Q7CZfxdCQcR3iIPTwuGqLeFsKenj/bLGMnXkCgo/jbj/uKumRowtV3kl3MahpiRv+m9a5TjIvmw6PU08qCAFjUkdjlnFlUSvoKq7WDbkjGXYRYTOAW2+aXaYinaRXLJQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=altera.com; dmarc=pass action=none header.from=altera.com;
 dkim=pass header.d=altera.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=altera.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=aKXv9GFbuVOE5qf6K6IHzS8o04CSaTpA1oplbvaAR2c=;
 b=QILcSkxqi9/Xa32GAJLvq5Mvi1mQYtX6p2wd0nN2q94rr7fYvOtSnME4kJT7za5t3RdJdS+snvyoyJeyrx1NwxtFPqC2iwk9bzgz+PDPBueVIHIB98tsgA0jpVbZlLscGirMkgxjk2nlpVHmTf7WH5LFMyeQR0dhlcX9aQFRwwObUOCrkgF+E8ci1R7VHPaLphWQnoeYVF1vtq2bV5PoUC+Gc5+yKJjIpoc5wszBQJQ0A0iAmUSQ9f7upZCn0yoq7zmv//xqBvwaFeOjAMnCtSs2FaliattlyFNDhPTeCW9VkKS3oHjNZ1VI6CYhErwaHo7olCZ4F2gyXRIcdyNjVw==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=altera.com;
Received: from DM6PR03MB5371.namprd03.prod.outlook.com (2603:10b6:5:24c::21)
 by BL1PR03MB6168.namprd03.prod.outlook.com (2603:10b6:208:319::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9137.13; Thu, 18 Sep
 2025 10:55:17 +0000
Received: from DM6PR03MB5371.namprd03.prod.outlook.com
 ([fe80::8d3c:c90d:40c:7076]) by DM6PR03MB5371.namprd03.prod.outlook.com
 ([fe80::8d3c:c90d:40c:7076%4]) with mapi id 15.20.9137.012; Thu, 18 Sep 2025
 10:55:17 +0000
Message-ID: <572d958e-a3db-452c-b888-c15a9fd4afe9@altera.com>
Date: Thu, 18 Sep 2025 16:25:07 +0530
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net v2 2/2] net: stmmac: Consider Tx VLAN offload tag
 length for maxSDU
To: Jakub Kicinski <kuba@kernel.org>,
 Rohan G Thomas via B4 Relay <devnull+rohan.g.thomas.altera.com@kernel.org>
Cc: Andrew Lunn <andrew+netdev@lunn.ch>, "David S. Miller"
 <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>,
 Paolo Abeni <pabeni@redhat.com>, Maxime Coquelin
 <mcoquelin.stm32@gmail.com>, Alexandre Torgue
 <alexandre.torgue@foss.st.com>, Jose Abreu <Jose.Abreu@synopsys.com>,
 Rohan G Thomas <rohan.g.thomas@intel.com>, netdev@vger.kernel.org,
 linux-stm32@st-md-mailman.stormreply.com,
 linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
 Matthew Gerlach <matthew.gerlach@altera.com>,
 "Ng, Boon Khai" <boon.khai.ng@altera.com>
References: <20250915-qbv-fixes-v2-0-ec90673bb7d4@altera.com>
 <20250915-qbv-fixes-v2-2-ec90673bb7d4@altera.com>
 <20250917154920.7925a20d@kernel.org> <20250917155412.7b2af4f1@kernel.org>
Content-Language: en-US
From: "G Thomas, Rohan" <rohan.g.thomas@altera.com>
In-Reply-To: <20250917155412.7b2af4f1@kernel.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: MA0P287CA0009.INDP287.PROD.OUTLOOK.COM
 (2603:1096:a01:d9::9) To DM6PR03MB5371.namprd03.prod.outlook.com
 (2603:10b6:5:24c::21)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM6PR03MB5371:EE_|BL1PR03MB6168:EE_
X-MS-Office365-Filtering-Correlation-Id: c5469994-b62f-42af-e20e-08ddf6a1da27
X-MS-Exchange-AtpMessageProperties: SA
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|7416014|376014|1800799024;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?RGw2bElaamZQYVlzcnFaMGx4SVRQNmpRaUI0RmdPRGk2dktZU1NTc0RHSmVZ?=
 =?utf-8?B?azNKYWRDSUtRdDk2OUdkSlZFQXNINnpUN25lVjZESHgra1VvYmZLTktaS002?=
 =?utf-8?B?WERLOFh1UGNGdjVaaytDNU1wYW5VRWo2MXBvRjJFL2ZrY0NlK2U1MHVOSWJJ?=
 =?utf-8?B?dm0zK0l0Qm45L2hWRTNCdkErUUZTa2RsYkp5U0tiTkF0Qk1uUDFYYlFyaFNa?=
 =?utf-8?B?akF0NUt2ZHowM0p6aWNoY0hhQmEzYkZQcnNrNzk5dGFVaWtjRmRPOWY4NkYx?=
 =?utf-8?B?d0tKSUhjYlF4OTdtUW8rWE5xOFlBS3RKcVdReUpEamJBeVlYOFI3SFd0TTVm?=
 =?utf-8?B?Wk96eUx2ZUppVXlKRjY4YnRJcFdYTzVBWW9IejdONEhCVWJhOEQ1Qnp2TStw?=
 =?utf-8?B?SjY1d09IaiszTTVOSlprUW4xYnVtRlhVa1lQVnNoV2ROWE8rQlpuanZRYXNo?=
 =?utf-8?B?NnhxelhIR21TUDlxMGszV084SkNZaDFhWUFiaEV2bjljbi9jRkVYRHBYOUFP?=
 =?utf-8?B?VnI0S0NlcUsvZDZTYVY1RWFEeEh2bjBrOG5OY0tRbHBZNnY4UHFmN1NkRXhw?=
 =?utf-8?B?eTNidGIzK3lOMnhPTllaWFlrbHY5ak95eFVpazRrYVh6WjZlczJwNWNNQW1m?=
 =?utf-8?B?cjlqVkZkRS9jbHpRaWxGMkp5aWsvSGhnNHRxSmFCbDFGclJMZWhodW45YmhU?=
 =?utf-8?B?N0hPYU80N0RVU3FiTG1iaUNRaHlUenNnY0ZPU3JRcm52UGw1VlZoTTN5ZHht?=
 =?utf-8?B?b1V2UDN1KysxMGFVUkhlb2R4WXFKVGFJWVFuSHI4dmd2bVVzSGtXM3ZQZTNU?=
 =?utf-8?B?U21GMVE4T2FVbVV2SUdKV0UxT1dhcjUvUDREOHhuSUNmbFZoVTRpK24wUkNz?=
 =?utf-8?B?aEx5eXRCZG41N2NHYnUra0tEVmphODhxdWc4VzU4T1RkN2paRCtrRTcyaWk0?=
 =?utf-8?B?U3BuTDJMY0hZa1RZVWpna2ZOZGJiWGw1V3IyZzlockVtWVpaTmVEWlJvZVBR?=
 =?utf-8?B?L21sNUpTT1RwR3hma3ZWamZxWW0raDBEa2ZmVUViUHNGZE4zSWVCcy9mY3gz?=
 =?utf-8?B?Q1R5QWFCZWtueXRQVTZSVVhTOXlvSy82dXYxNTk0bHpHejBQd05oekVRb0dY?=
 =?utf-8?B?bTRGVDNaZ0xCR1Y2bDRac2RaaDhISUJjSzk5bGFFbkdEaVJTR2lEYVpEdy9G?=
 =?utf-8?B?ejdEeFh2b3VPc0laN3M0dlZwMDM1bDRuQWRra1JqT0kxRWhzanZ2L1gwbUJt?=
 =?utf-8?B?ZFB2WXNFNnFKUnpnRlM5MjFac0pYRXJpQTJBS2Z2UkhoMDFERnJJR0tRRkl2?=
 =?utf-8?B?WjRCRTN3bzFhVThOa2FtRkpFeFpuU3V1UE02SldQU0cxNm13dnJ6TFFLTTRx?=
 =?utf-8?B?QmJ2eDRKckNNZEIzUGpjTlM4RlVRNXVXYlpSOCtxS2xtOW5jeWN2MWFjNGxY?=
 =?utf-8?B?NkdGV25TQ0gxUzlHd0V0UFZDYzAzbzN2NFpxRHMxRlQ0R3BBN1gzMUZaMklW?=
 =?utf-8?B?NWJtYUREa0RYT2dFRHViOGEzcWI5Vm5vZjNDU0F6eDFSYkNQTFR2bStwR3dE?=
 =?utf-8?B?RVdLbEdDRkRXd2pyM1J1REtVWURMT0RpeFJNZCs3MTRaYnZBUlhRb2xSUktW?=
 =?utf-8?B?aXlOWG4ycGVDRFk5QTQ3cm0rbHBhak96MktCOWlWc3VCRDhvbjFLZTN4dzFa?=
 =?utf-8?B?ZXF2SFU0czRiN3lzZWRlYjFQc3JhRG4xNThLUjRXRWdRRUtBeGQ3eTZaR000?=
 =?utf-8?B?NlVzVmYzMTE0ZHBkSmVVVXF1MWpsZG1xYktURHpLZEFLWVF6RFIvU2I2ZjVQ?=
 =?utf-8?B?Y3BRWEIwYlk3SlBvYmJHT1lGYWVXQmRXZUdEVDNMK1BOS0FhN3hRWjkreE5I?=
 =?utf-8?B?Rzc1NU9yV2xVQXlYbmtUQnVac3FKOTh6VzBtTmpsdDZUNlh2Y1ViQ0VWamNS?=
 =?utf-8?Q?Hji3T+RLIgU=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM6PR03MB5371.namprd03.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(7416014)(376014)(1800799024);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?NnF1RmptOHRoWWFPWDBoZEtPVEMwa25DSHQ0OXZYL2NSd2tiQUVPNm15Z29w?=
 =?utf-8?B?TWpZZGpHeVJkUVQ4b2dpR1orQUxmeGR5OEI4ekFrQVN3L1lMcDFrb1Q4QWhF?=
 =?utf-8?B?T2YxL21mb1R0Z2h2QXlCRi9OY0htbDdNMTJXQlREQzdKOE4xalVzWmJIRmxU?=
 =?utf-8?B?MXZCV2RuU3VuT1V0MEJHSlpUa2tJT052L3AzNG5JcVZ3bTNlcmxBTXVlVnRC?=
 =?utf-8?B?dEZ5T2hqZUp2UWNmYnRMblhQM2JSOXc0TjE0dzNuMEJEZnBFMHRLaE5pR3kr?=
 =?utf-8?B?Mk5aeEF2YlRoSVcvckFGQXZlR3BFZ0trWUNvVHhiQmlPWFU3SWVEM2RQNThx?=
 =?utf-8?B?Q2NiUHVPSGVJbjNnK1ViejZRZGhQandNWWpqYXZWdzFpbFVRb1BMdjV5TVRi?=
 =?utf-8?B?Q0Eyb0FvdjZOa2FrTWJZRThLQXJQZXVpeGlCcFVxK0VDY1NDbTNRYytTa00y?=
 =?utf-8?B?NXNNUXR4eG5JTkpJVHE4YnhkSXNWaG1PMHpJOTd1a3F4Ym9TNlZqeVpXRkZZ?=
 =?utf-8?B?ZTh3eDFLNHRqdjJHMmFVdEhVVXYzTUJKT0VJS2JUUy9XVVZjMXRlN3o4ZlFi?=
 =?utf-8?B?SHdNVnpXQUlGWFlaUHYxWFZJTTVTUXpRZ2xWelA5K2kzK1doalBCMklBY1hx?=
 =?utf-8?B?T21ROHZZdjAwdEN1REFBT1lVRm9MOE53Ync4TzYrSkRHMG1zYnZVY2p6b3hN?=
 =?utf-8?B?U0g2citOV3lEWnNjRktrN2JmVkxLVWo0Nm8rTUJCajk4dEZnNzhzM05NK1hU?=
 =?utf-8?B?ZGtyV3E1bFM0TWlVZ1lMQnY1WjlOMTI2dW9EUHREdFlSTXBYWVJidy91VGlq?=
 =?utf-8?B?WkJTK3FON25NakpRWUw4ZjR4eS9aS0djV2JvTXMxQlY2bzdyTjRHL0tPZnNY?=
 =?utf-8?B?UDJjY1hOMTZTd0RXazVNMjMxTFc4Z2ZsVThxdzhFampVTUR2YmVHamVTV3Jv?=
 =?utf-8?B?MFJ3c3NzUmgvdTlETzJYeVByQ1JyaDZIT0Vxbkd5S1hna2tXK3pkYmswQjR4?=
 =?utf-8?B?Q2UvMVdUQkt0RDJMTXNKSlVHOFZNQS9UeHVRZklIZURaMHJiOUVmRGhtL2sy?=
 =?utf-8?B?K0NhQkhtWWNLYWJHMU9pK29PbERLZ1NNNHppeTk3NU8zY05CL2p6WjlaS21X?=
 =?utf-8?B?RS9WTm04a29aR25DWCt6RHJXczhkUVZmVHF1WDA5UThTeE9xM24reGdITWxu?=
 =?utf-8?B?bWsrT3I5aGxTdlVhTE1FeG1FMys3V1ZEWlhwc2EzbHRiS0l1dnErLzhudHBu?=
 =?utf-8?B?NlhWTlgxcnk5bmJwTHlueTlWTXQwZVhSZThVOHBOTEdpODh5a1FPVHVkOExJ?=
 =?utf-8?B?TFVDUWFkaXVrdWRnNVoyMjlyRGhyOUdMMDBad1VMZGJDcFpIbk5ldmdGd0M2?=
 =?utf-8?B?eldUdllTenVMci9pSFVZdFdEck0xMFZzTGJJNzVzbEE2a2pEU0dYVTlYYmRw?=
 =?utf-8?B?MU9MazJGbzZ0YnVUQ2VncmJzUjE5TlNTVUZRT05wVUlEYnhUeGhDaWRqWmV5?=
 =?utf-8?B?MFgzYjYycWdFcXJzc1VzZ1hleEJZTCsvMXM3VXpCdXFnUmNvamV6L3VINmNL?=
 =?utf-8?B?MytTaDJseDZxK29INWxHeWZScGxUZWkwbzlWMzdNc1NsMEkyZ2g3bkhQU3d5?=
 =?utf-8?B?bUdaV3lEdW4weHlvNjlBTDFzS1JUZXRwcEpwci84T0Iwa0VkTSt2ai9kYW1I?=
 =?utf-8?B?RWR2d29qTnFJTlZqOVllZ0w2RGNRNExyWTFBU0d0K1BXSEsrR1liVHpKZStn?=
 =?utf-8?B?YlVtT2ZWUlYyYVl5bWlqZElzK08rTWVoSFNJK3VVYXUyR1hOUFZnN24xcS9m?=
 =?utf-8?B?cmE1Ni9xekc4UmpiRU55SFNmbEhaRnNmRWZadEtxQjFzV1lSUFFhYmdpdy9p?=
 =?utf-8?B?dVpZVEhIQkExNTBJZEpyRjlrUTVBa1BXS2tDaWw1ODFkZXRZTFBEUVdYOS9z?=
 =?utf-8?B?WUhBb2NkZ3QwU0xnd3g0UVBFS2Z4QnJXNEpyekMxRUQwQzd2bUI0OEtJWjQw?=
 =?utf-8?B?S21yT0E1R1oxU1RIYTlZUEZaK1I0dE41VmZBTXdMaE9xL2hZSmdFdTQ4cE1N?=
 =?utf-8?B?YmVTa0krdVVJNjJVNnZZZzlSRU1vRUQ0TFNxTFRvSDBEbndmSS9tUnNiNy8v?=
 =?utf-8?B?R0JHSndJa1B4L0o4eVcrUmg1WFNYVWxna1V0bXVqZmVDUkpsQ0h3VFVsVXh6?=
 =?utf-8?B?SEE9PQ==?=
X-OriginatorOrg: altera.com
X-MS-Exchange-CrossTenant-Network-Message-Id: c5469994-b62f-42af-e20e-08ddf6a1da27
X-MS-Exchange-CrossTenant-AuthSource: DM6PR03MB5371.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 18 Sep 2025 10:55:17.1623
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: fbd72e03-d4a5-4110-adce-614d51f2077a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: /Xq6JKx3ZRpfCLGInThKISDqZqyTuJBB8EUR/uKbIgJXe1UVvucknasDa/5ca87Ky071agwDzSB/RImWFqFOkITZbaXdXnHWPUQjZzOkFJI=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BL1PR03MB6168

Hi Jakub,

Thanks for reviewing the patch.

On 9/18/2025 4:24 AM, Jakub Kicinski wrote:
> On Wed, 17 Sep 2025 15:49:20 -0700 Jakub Kicinski wrote:
>> On Mon, 15 Sep 2025 16:17:19 +0800 Rohan G Thomas via B4 Relay wrote:
>>> From: Rohan G Thomas <rohan.g.thomas@altera.com>
>>>
>>> On hardware with Tx VLAN offload enabled, add the VLAN tag
>>> length to the skb length before checking the Qbv maxSDU.
>>> Add 4 bytes for 802.1Q an add 8 bytes for 802.1AD tagging.
>>>
>>> Fixes: c5c3e1bfc9e0 ("net: stmmac: Offload queueMaxSDU from tc-taprio")
>>> Signed-off-by: Rohan G Thomas <rohan.g.thomas@altera.com>
>>> Reviewed-by: Matthew Gerlach <matthew.gerlach@altera.com>
>>> ---
>>>   drivers/net/ethernet/stmicro/stmmac/stmmac_main.c | 25 ++++++++++++++++-------
>>>   1 file changed, 18 insertions(+), 7 deletions(-)
>>>
>>> diff --git a/drivers/net/ethernet/stmicro/stmmac/stmmac_main.c b/drivers/net/ethernet/stmicro/stmmac/stmmac_main.c
>>> index 8c8ca5999bd8ad369eafa0cd8448a15da55be86b..c06c947ef7764bf40291a556984651f4edd7cb74 100644
>>> --- a/drivers/net/ethernet/stmicro/stmmac/stmmac_main.c
>>> +++ b/drivers/net/ethernet/stmicro/stmmac/stmmac_main.c
>>> @@ -4537,6 +4537,7 @@ static netdev_tx_t stmmac_xmit(struct sk_buff *skb, struct net_device *dev)
>>>   	bool has_vlan, set_ic;
>>>   	int entry, first_tx;
>>>   	dma_addr_t des;
>>> +	u32 sdu_len;
>>>   
>>>   	tx_q = &priv->dma_conf.tx_queue[queue];
>>>   	txq_stats = &priv->xstats.txq_stats[queue];
>>> @@ -4553,13 +4554,6 @@ static netdev_tx_t stmmac_xmit(struct sk_buff *skb, struct net_device *dev)
>>>   			return stmmac_tso_xmit(skb, dev);
>>>   	}
>>>   
>>> -	if (priv->est && priv->est->enable &&
>>> -	    priv->est->max_sdu[queue] &&
>>> -	    skb->len > priv->est->max_sdu[queue]){
>>> -		priv->xstats.max_sdu_txq_drop[queue]++;
>>> -		goto max_sdu_err;
>>> -	}
>>> -
>>>   	if (unlikely(stmmac_tx_avail(priv, queue) < nfrags + 1)) {
>>>   		if (!netif_tx_queue_stopped(netdev_get_tx_queue(dev, queue))) {
>>>   			netif_tx_stop_queue(netdev_get_tx_queue(priv->dev,
>>> @@ -4575,6 +4569,23 @@ static netdev_tx_t stmmac_xmit(struct sk_buff *skb, struct net_device *dev)
>>>   	/* Check if VLAN can be inserted by HW */
>>>   	has_vlan = stmmac_vlan_insert(priv, skb, tx_q);
>>>   
>>> +	sdu_len = skb->len;
>>> +	if (has_vlan) {
>>> +		/* Add VLAN tag length to sdu length in case of txvlan offload */
>>> +		if (priv->dev->features & NETIF_F_HW_VLAN_CTAG_TX)
>>> +			sdu_len += VLAN_HLEN;
>>> +		if (skb->vlan_proto == htons(ETH_P_8021AD) &&
>>> +		    priv->dev->features & NETIF_F_HW_VLAN_STAG_TX)
>>> +			sdu_len += VLAN_HLEN;
>>
>> Is the device adding the same VLAN tag twice if the proto is 8021AD?
>> It looks like it from the code, but how every strange..
>>
>> In any case, it doesn't look like the driver is doing anything with
>> the NETIF_F_HW_VLAN_* flags right? stmmac_vlan_insert() works purely
>> off of vlan proto. So I think we should do the same thing here?
> 
> I suppose the double tagging depends on the exact SKU but first check
> looks unnecessary. Maybe stmmac_vlan_insert() should return the number
> of vlans it decided to insert?
> 

Agreed, those checks using NETIF_F_HW_VLAN_*_TX flags are redundant, as
stmmac_vlan_insert() already returns true. As you suggested I'll update 
stmmac_vlan_insert() to return the VLAN header length it decides to 
insert, so the logic can be simplified and made more concise.

>>> +	}
>>> +
>>> +	if (priv->est && priv->est->enable &&
>>> +	    priv->est->max_sdu[queue] &&
>>> +	    sdu_len > priv->est->max_sdu[queue]) {
>>> +		priv->xstats.max_sdu_txq_drop[queue]++;
>>> +		goto max_sdu_err;
>>> +	}
>>> +
>>>   	entry = tx_q->cur_tx;
>>>   	first_entry = entry;
>>>   	WARN_ON(tx_q->tx_skbuff[first_entry]);
>>>    
>>
> 

Best Regards,
Rohan

