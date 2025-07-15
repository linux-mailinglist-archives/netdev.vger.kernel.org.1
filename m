Return-Path: <netdev+bounces-207135-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 91CFEB05EC6
	for <lists+netdev@lfdr.de>; Tue, 15 Jul 2025 15:56:53 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id BD60450046A
	for <lists+netdev@lfdr.de>; Tue, 15 Jul 2025 13:50:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 89D402E7631;
	Tue, 15 Jul 2025 13:44:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=altera.com header.i=@altera.com header.b="qihK7e/G"
X-Original-To: netdev@vger.kernel.org
Received: from NAM12-BN8-obe.outbound.protection.outlook.com (mail-bn8nam12on2052.outbound.protection.outlook.com [40.107.237.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C29C42D372D;
	Tue, 15 Jul 2025 13:44:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.237.52
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752587077; cv=fail; b=Viaunt6FFqUKu1n4tBIL3q/+lFzRFmxY4KeaHcsBEjQ3uIb2+GMytQMXouZxz4CtZHka/bxA2lRex/jwVMC1WedAPLZzSd68pn/wBKHY2e+d5IUu9PGm6/L4qcLTf7/l7fvcbXt0yqE6amg/5KqipQzz0gPwbSxEUmsrFimBhUs=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752587077; c=relaxed/simple;
	bh=O+SOfU63agRhAJIFa3UvKM47KP8kNoA+eYxcH8Q6Psw=;
	h=Message-ID:Date:From:Subject:To:Cc:References:In-Reply-To:
	 Content-Type:MIME-Version; b=WxWLwNpvQ/5b7UtxzkLsAKNP2uYwkzbxZvWCzj6iiSjdctW2nYEOL9KuBXy5egVx6H8AglcXO1LS7R1bECscPy7I5IYPqMM4Ka2Ae23atMQniDVC5Ny/jnJUIP5/nhseaUNQPcv2cQZ4ZpbUKPdPP9gfkr1joSsaqo8OWO+K7Fc=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=altera.com; spf=pass smtp.mailfrom=altera.com; dkim=pass (2048-bit key) header.d=altera.com header.i=@altera.com header.b=qihK7e/G; arc=fail smtp.client-ip=40.107.237.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=altera.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=altera.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=pWeIfuOXJNaFk2U7hQBKj/96zEml7lXjFbPsgL7g4185c9Pe99XZAb7iQX7LL/3e8gdFWwleLY+8A/dSf1V6qwkRiPgrFtwipVmbjxiiqSY+z+UqraJiK1Se+l51u1fp58RCr2ZflRIYFlSvfWtxP39GCCCrgnXpaS8J2GuiuPUg+42yHz2wfP4Nx5JuxZHQW29oMI2pkybVnArZSWbVP3fTMXvyNiTmbKZlbGMeUTBeGFpdOoEcllRm/iHUDRwHwDFBCycox2S8+SC2xOStlON0zfE+P/+vzp6eWVtn4CwrZoBRA40AxVwSgfw4+Wgtd8W8W0Y5cw2BNX9SGs13Qw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=VAUlL8zVqmMXuGZNA/Icc7HbRigfwrN0m1s7+P2JppE=;
 b=FSPFs+zf/TyeSkzCy19U1k/XqNZ3azkYR5C39Zt/jGiw/0yDbwHVXStzqG/v+Lbf/aplNWqJmH/5QUs8X5K2dA5BCgjvVxdKDiTBVexWpCEg4J6l4UQZb6ySj339JvMu3/K1vrTVh4GMDlBhGOlMAvfkUR1vPWpwcuSFd/LHeJ42aCQTQKeJJ0feJDYw51/xCqVvKaTsHtPvhOs98PVjuDrttkatcMq37vtH4arqNoydeMIAlF7EQ4//YywJBysrujglyHO78228n2NRAudl3dL8a1K/6Jl6H5oPYjcsP64nq/yj1th8XWsf9RP1eFnpMjS/38sJh2wjtJ9NiFDiVg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=altera.com; dmarc=pass action=none header.from=altera.com;
 dkim=pass header.d=altera.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=altera.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=VAUlL8zVqmMXuGZNA/Icc7HbRigfwrN0m1s7+P2JppE=;
 b=qihK7e/GBX5hiGeEJ75sBPi0CS/D4//MW9r1eSxZVge/8RGgnodcOu+tTf9j4V+RPA888/fq/7m2dVa5tmPBbJ3nxPI2LPzFiMxz02LuVV6HN3geWdyn6dF74AFMq8aswD5iTe2/16AeiH35jyDOsMFrzoH6CbHWOzMnsLIumi0+Ve8mvuB2XUWgVLbmaj43/oSSazt1c17h3WL3fhfNGer3fxyZXygSvcEWwKH7mpfvenH/Lujd9cAY8FTBiTcLwUNz/o3JvFc76sT4vuyo6wiNrqWgtAGg5yWGMW+BufvqUGiFzlIaq7zKzBtjAIIRX4bZS2QWcwssxG7D/ipdsQ==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=altera.com;
Received: from DM6PR03MB5371.namprd03.prod.outlook.com (2603:10b6:5:24c::21)
 by BN9PR03MB6090.namprd03.prod.outlook.com (2603:10b6:408:11b::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8922.32; Tue, 15 Jul
 2025 13:44:33 +0000
Received: from DM6PR03MB5371.namprd03.prod.outlook.com
 ([fe80::8d3c:c90d:40c:7076]) by DM6PR03MB5371.namprd03.prod.outlook.com
 ([fe80::8d3c:c90d:40c:7076%3]) with mapi id 15.20.8922.025; Tue, 15 Jul 2025
 13:44:33 +0000
Message-ID: <9f4acd69-12ff-4b2f-bb3a-e8d401b23238@altera.com>
Date: Tue, 15 Jul 2025 19:14:21 +0530
User-Agent: Mozilla Thunderbird
From: "G Thomas, Rohan" <rohan.g.thomas@altera.com>
Subject: Re: [PATCH net-next 3/3] net: stmmac: Set CIC bit only for TX queues
 with COE
To: Simon Horman <horms@kernel.org>
Cc: Andrew Lunn <andrew+netdev@lunn.ch>, "David S. Miller"
 <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>,
 Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
 Maxime Coquelin <mcoquelin.stm32@gmail.com>,
 Alexandre Torgue <alexandre.torgue@foss.st.com>,
 Serge Semin <fancer.lancer@gmail.com>,
 Romain Gantois <romain.gantois@bootlin.com>, netdev@vger.kernel.org,
 linux-stm32@st-md-mailman.stormreply.com,
 linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
 Matthew Gerlach <matthew.gerlach@altera.com>
References: <20250714-xgmac-minor-fixes-v1-0-c34092a88a72@altera.com>
 <20250714-xgmac-minor-fixes-v1-3-c34092a88a72@altera.com>
 <20250714134012.GN721198@horms.kernel.org>
Content-Language: en-US
In-Reply-To: <20250714134012.GN721198@horms.kernel.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: MA0PR01CA0027.INDPRD01.PROD.OUTLOOK.COM
 (2603:1096:a01:b8::20) To DM6PR03MB5371.namprd03.prod.outlook.com
 (2603:10b6:5:24c::21)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM6PR03MB5371:EE_|BN9PR03MB6090:EE_
X-MS-Office365-Filtering-Correlation-Id: f9a81e44-bfe6-4375-b556-08ddc3a5baeb
X-MS-Exchange-AtpMessageProperties: SA
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|7416014|366016|1800799024;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?bm9rcktyV3FHVWZ3eWNPMW5wRk5IQXdWSmVqV21raHlzeFg1Qnl5REliL1Jk?=
 =?utf-8?B?ZzNLdU50ejYzTHpEVnJGSkovbEIwZGNvMHZlaUJsMkNOdUpLZWo3K2k1MHJ3?=
 =?utf-8?B?cmpMQ0VQWUxRdlFwRWpDbkY1OTJIZGo0bWRKdWY1K0xuczlwamVvS1RPcmNw?=
 =?utf-8?B?TDhsNGVid2tuaER6VkpQQkdFK28wSWdSd0VnZ2pxK2VpbHdmczdya3htblY0?=
 =?utf-8?B?K1VRZjJETXd2cHpISXlwd0hIK0p3Nm1RNW9RblVRQW9sblhWUEFya0JoV3c1?=
 =?utf-8?B?bG9qeTVaV1AxNXBqa0JSTDVEMFZpcDJxWXRuTytPaUFrNnZFN3hXQ2ZvZEZh?=
 =?utf-8?B?QXBGa1FUaTRBMjN3NUx0a3BXaTRrRzVrSExkdS92ODRadU9EaEVoV3RDVjNS?=
 =?utf-8?B?SWt6VEg0U3hEd1kybHlUbEM3NVlEVmZHN044OUh5S0NXMkhObTJzRTBlNGx4?=
 =?utf-8?B?K1B1S2FNWm94K3ZUQTEyczZIUlBEVkJZbDMyN0dveE1nRFpkV0RlREt6cFJv?=
 =?utf-8?B?QXpoeTBxWmZrYUx1cStLcEhGOUZNNVB0RERCRGNyVXJuYlFSREF2bWk4RWhB?=
 =?utf-8?B?U2FSbTBLR1krMFFwWUl6MXRPclMwMGFXbVRTL2NSdjMyUE5WU1h3OFozeE1o?=
 =?utf-8?B?a1hXTkpsZXlnN3JFVVBsNVI4TGpXRHl2bUNuUVROcXZrem1ZWXJhbFhqZExm?=
 =?utf-8?B?RjFYanV2WmZrQmpQZUJYUlM4Z0J5NVo4RDU4RGZNUkFYRjdHczJ1OTBLMVkr?=
 =?utf-8?B?QjcvRSthZ3FpT1o5Ymx2YnlsVEJ3TlNJU01DOHR1c082L2hsR1VPOUtNOENR?=
 =?utf-8?B?Q3A1NTZHazd5WVhNUXBROTVxK01zd09SbVFvZVk5RkNTZFR4cXFsMjFzbTI2?=
 =?utf-8?B?clNHV0puVXFzR0t3MDlGSG43VTBxY25pQ2xnRXhPSGxIL3pKc0xhZTJhNksv?=
 =?utf-8?B?U2QyVTRnTGpUSVY1Sml4U3hJMlUyREJvRSs2SkJxd2Rva2NRL3lKcmZldmxK?=
 =?utf-8?B?S1U0clQ2VUZpZzdnc29VT3ZkMEVrL1FXb2lRU0hNMHdvdnBzWW1xYVdGcEFp?=
 =?utf-8?B?ZjVadGhuSFYrNFE4T1pEVktKbUd0NEQ5SEIxSkdValRyZ1k5STEyMWhsUGQz?=
 =?utf-8?B?NDhGZlE4c3pUTUIvWGUxVXV5cXhGbUdDVEVZdjFqaEFWaWdTZ0ZjM01Yc3Vl?=
 =?utf-8?B?dCtINVNDRFh4TWt6Z2hCV09wVWFpZ2c0MjhneVV4UTZwZmphV1U5YmhIcW43?=
 =?utf-8?B?YWZ1Q0ZIR0VCZzRybDFSRXFUb3lQQVkxWlFVZDFwUEdjYWNMRjZjUGI2bVJK?=
 =?utf-8?B?T3E5OXF5R0lBTFNIUFhMNmpyakFFUyt2NmFQbmhYWmF2SXZWelNYQ1dvYjha?=
 =?utf-8?B?djhLRkQ1UjBpTDE1STF4cGQwTUFxSS9NalJzZ2VvcUVobWkxVXF2WFRVNnE5?=
 =?utf-8?B?N1dBUi8zWXFMM2JFVUZjMkZ6V2JVQ2lYS0pXUlp6VUQ0bzRpa2hvTVRrQTJu?=
 =?utf-8?B?aUVhK08rZFRhdHpUNGpGNHQzVmEvWHlLTDFkZjdEeUs0OFNxV01ta3h4UnFj?=
 =?utf-8?B?Lys0bHlEWFA4WFpjZlFhWTVHZjloQnhZZ3k4MGFWd3EvVmRNOU5HcWJMYi9P?=
 =?utf-8?B?Y1lYbHNWd01pY2xpM0lLaEEzSm81eFBoZmNqcnZCNHk2WHRLaHA5NGRlWTk3?=
 =?utf-8?B?VXU4THBicnVpZDZFVVA5ODUvT0FoSFBhUTVxc1hoVEZHSC9JNkE0OWkxM1gy?=
 =?utf-8?B?d1YvOVpGZHkvMkp1ZmdHMFo2YnRJbk9IK01XcEJseXFMYWNtTkU1aUEvKzhx?=
 =?utf-8?B?ODBGYkczRVJUZm85czViaXU2VHlHYmdoSG9iN2FkRU5TWDk4cEY5RmJnT1hn?=
 =?utf-8?B?bEgvd0xNNEtqZWFoQ2VEZlZENFZBQ1p3MjgvYldwTEoxaHc9PQ==?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM6PR03MB5371.namprd03.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(7416014)(366016)(1800799024);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?N293ZENnc3lBVFdSOFdpeUhHc1k4cnhaT0FFUTRHcmhvRGdTM3ZWck1EMCtn?=
 =?utf-8?B?QlkzZm83Njhnbm15QU53ZnpuOU9EZWEwcnR3VGVlaThqMzZvMjV1RTZKVXZn?=
 =?utf-8?B?TzNzdnFHTWpIbGFzQ2YzMFp6Y2xPMXdvTS9wazJoL1JZRG05L1F2Rm9YdnBK?=
 =?utf-8?B?c2NBTWJLbEVtNlhKSFl2b3ZJd2Q3c1hNaVk0RTJaTU9aUVdRRGtUbElTbEk2?=
 =?utf-8?B?TGkzemJMYkFXRmI0MTFqdEE4Si83RWxHc1E2NEJKNi83WWlFdHVWOTlNUDVy?=
 =?utf-8?B?RzNzbUF0Ym1KWDdwUHBzUEQ0U3NJcCtORnBXZmhnSnMySUZFS1J6T3JNZ0hZ?=
 =?utf-8?B?Wi9xR2hFaU1qRDdEMWRKSzdQb2Z1SHcyRU9RclRvZm5lempKS29sNDNEOXdD?=
 =?utf-8?B?aEpwQzkyeEVIM25tVysvUmpJMXo2VW9WN0pEVDVRcDVHdUhNVklmcjVsZjFQ?=
 =?utf-8?B?QzFzN0piZHJqTHZiUGVoNW5QeXlkVHFoUTRuMTdLZjhIa3pPb1hKdFk1dVh6?=
 =?utf-8?B?SWhPaVVMdmhLUHBCZzlodjg0UDJvaVI4VSs1aTJDZ0hvSENiY0JHaE85cTRX?=
 =?utf-8?B?aUt1dFF5UXJCNDQ2ZFJiS1FxYTVOMElvcDI4K1hZUXkzVFBmSnNsTno4amJs?=
 =?utf-8?B?UnpYQVZ2Mm00ODdsYWFCOHcvVGRRVHlURXNZMkF3UkRPVUZYNUkxdVloWEEv?=
 =?utf-8?B?T1laWDhhZmJ5bzJ3L2xNaWVUMnAyYUczWmpIb0Jod2RTWDVtYnQ2RTc4Z284?=
 =?utf-8?B?R0s0S0czRS9NVjRZcmtESHhnZVM1K2tJZ1AxOW5OQUFXd0tTc1ZHcVNqSFZP?=
 =?utf-8?B?ckVDRHZHNlZhRkFFeGxKNEpkSXc0cHh6KzVvWU5rRnFKMHJaSCtSb0V6Um1Y?=
 =?utf-8?B?OVZVaHVnYTgybUZrRkxZU3Y0MTJTa0RnRTVuYkRmb3BpNVlyTGFhNEVSTzNJ?=
 =?utf-8?B?MitkUG84dThvOVM5ZVUyOTBESFF3dkZ4Rlhlek5ya2w5amtZOEZNV3RqZFE0?=
 =?utf-8?B?dzNHc0xwMW9OdWpJc05ZUERNNFEvbk8zQ3NDWTRzWUthTExmRDM2ekJmZHhn?=
 =?utf-8?B?cmEwRUwyYnhvYy9EYVEyTkg3NVJ5c0FXL292d2R3S2xmYThjSm1HbU9TSzhn?=
 =?utf-8?B?QVFhbGJNZk9yYmlhaTNlTFV6LzhtdUVqSkhXVHNmUHRaMWFzT2JPZTBoU3lN?=
 =?utf-8?B?S0hwTjVCUmNSaWNtWlBMWXhMVDZjY1h1a2E0dkJMR09nNnVhemExc0xvdmNM?=
 =?utf-8?B?ZzFPOXVUenl5YlZMVDRxUTYvNEpIRTJRdkdjUUI1aFRqZUlnUkViN0lVUXBs?=
 =?utf-8?B?YkFGL3RYTEZPYmkzalN2bUgra0MrSjdFMWVUWHFTbjA4YmJKZDNmT0pTTFdL?=
 =?utf-8?B?eU1TQWlaVVdNQ1VBQTJMRGN3UlI0aEhaRnVhQzltTFJWa2ZvSEp0UThNQzNj?=
 =?utf-8?B?WGhZRFNxby9NM3BXRjUrU0s4enpMRGtiUExqaDVFSTAwREtVQ3lIZ1RVUzRX?=
 =?utf-8?B?c3c2VE0wczhmWE5UZlk2T1VtUlNCblZQb2tid2FtaFZ6SnlaMXZ2djZtMWJC?=
 =?utf-8?B?ejFMNFd2dXJ4NE9JUTI0RnMyYVNRTlRWeGs0VTdmSStBMmo2U016TzNaenRm?=
 =?utf-8?B?bGo4R2tHVXNZeDZLUmRtbldEVi9HWENjNzR1T3R2cUJCajZUL2gvcHdkQnZE?=
 =?utf-8?B?KzFXNGtLRkZLWDZUdGFwbHlaV2pBVjJoS2Nib2hoVlZWbVJDWlVWTTZvaEhj?=
 =?utf-8?B?c2hWS1hEcjlUTFEzdjg2endrVzlaRDJXcjgvOGkxR2g3RTBhOEFJZURqUWZY?=
 =?utf-8?B?Uk13bXBUSGdOanVsbzdENW9iSEZpRzk1TmV4NWZEZi91VVFQamgyL2lRektO?=
 =?utf-8?B?OXNXcE10YnNUSWhqdmtLNEkzYVN0VG9iV3ZzVHA2YmVmc0RzNWlBWXgvSVlE?=
 =?utf-8?B?ZnRic3h4d1hUOGFFOTFFeVEvVmxhK2t2RXRySDZKY2cwMURyV1JvZEFscENk?=
 =?utf-8?B?VlpiL0k0YzZCRGNodzBDem8wTjg5NjE4UGJQa0lrb3lBUi9lSWFrNTR4N3RJ?=
 =?utf-8?B?WkU4WUd3S2dST2V1Tlp5OXRJVVFrakVXaHpNTWJxN1daTzBJRG1NcjhiVHFO?=
 =?utf-8?B?UmtlbjhBQlRhVjhsR0lrZUN0QXp1MWQvZ25Yd2pkNk1sV3UxTk00RGRMOUI1?=
 =?utf-8?B?enc9PQ==?=
X-OriginatorOrg: altera.com
X-MS-Exchange-CrossTenant-Network-Message-Id: f9a81e44-bfe6-4375-b556-08ddc3a5baeb
X-MS-Exchange-CrossTenant-AuthSource: DM6PR03MB5371.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 15 Jul 2025 13:44:33.3019
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: fbd72e03-d4a5-4110-adce-614d51f2077a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: n5x7zE2FptIHYdtn/BeFNZMwMnb3AagyBtmTvCnlsgNNcNOQNhIh/lx2Q+4r5sPIyiUhGiNaFnFfykcKH635CGB13Mpch7AQaPGhX1JuU1M=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BN9PR03MB6090

Hi Simon,

Thanks for reviewing the patch.

On 7/14/2025 7:10 PM, Simon Horman wrote:
> On Mon, Jul 14, 2025 at 03:59:19PM +0800, Rohan G Thomas via B4 Relay wrote:
>> From: Rohan G Thomas <rohan.g.thomas@altera.com>
>>
>> Currently, in the AF_XDP transmit paths, the CIC bit of
>> TX Desc3 is set for all packets. Setting this bit for
>> packets transmitting through queues that don't support
>> checksum offloading causes the TX DMA to get stuck after
>> transmitting some packets. This patch ensures the CIC bit
>> of TX Desc3 is set only if the TX queue supports checksum
>> offloading.
>>
>> Signed-off-by: Rohan G Thomas <rohan.g.thomas@altera.com>
>> Reviewed-by: Matthew Gerlach <matthew.gerlach@altera.com>
> 
> Hi Rohan,
> 
> I notice that stmmac_xmit() handles a few other cases where
> checksum offload should not be requested via stmmac_prepare_tx_desc:
> 
>          csum_insertion = (skb->ip_summed == CHECKSUM_PARTIAL);
>          /* DWMAC IPs can be synthesized to support tx coe only for a few tx
>           * queues. In that case, checksum offloading for those queues that don't
>           * support tx coe needs to fallback to software checksum calculation.
>           *
>           * Packets that won't trigger the COE e.g. most DSA-tagged packets will
>           * also have to be checksummed in software.
>           */
>          if (csum_insertion &&
>              (priv->plat->tx_queues_cfg[queue].coe_unsupported ||
>               !stmmac_has_ip_ethertype(skb))) {
>                  if (unlikely(skb_checksum_help(skb)))
>                          goto dma_map_err;
>                  csum_insertion = !csum_insertion;
>          }
> 
> Do we need to care about them in stmmac_xdp_xmit_zc()
> and stmmac_xdp_xmit_xdpf() too?

This patch only addresses avoiding the TX DMA hang by ensuring the CIC
bit is only set when the queue supports checksum offload. For DSA tagged
packets checksum offloading is not supported by the DWMAC IPs but no TX
DMA hang. AFAIK, currently AF_XDP paths don't have equivalent handling
like skb_checksum_help(), since they operate on xdp buffers. So this
patch doesn't attempt to implement a sw fallback but just avoids DMA
stall.

> 
> ...

Best Regards,
Rohan

