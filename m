Return-Path: <netdev+bounces-187049-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 33DB1AA4ACD
	for <lists+netdev@lfdr.de>; Wed, 30 Apr 2025 14:14:51 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 53D4718889CA
	for <lists+netdev@lfdr.de>; Wed, 30 Apr 2025 12:13:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8D088259CA6;
	Wed, 30 Apr 2025 12:12:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="TppgadPb"
X-Original-To: netdev@vger.kernel.org
Received: from NAM11-DM6-obe.outbound.protection.outlook.com (mail-dm6nam11on2089.outbound.protection.outlook.com [40.107.223.89])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CB0C9259C9D
	for <netdev@vger.kernel.org>; Wed, 30 Apr 2025 12:12:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.223.89
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746015170; cv=fail; b=knYoQ7h++USNwuCw1C0y0MSf6R/QJrbG6KmyZzgiIFARSV8jiJcYYe/uyYcVDZof0SFuVnSX+FCgRyuAGJ7qSlbUc+BdiqVpxnAJTrVPUut35I5if9LtO8Gxaljy0hYBOzZbiZS1euDVPM2tSemtVyCDgkQb1xKtey7k2CpKnAM=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746015170; c=relaxed/simple;
	bh=o//N5sRSNKlAVoPUImr2E7mAKAvlvqOvW4++XGCfBjU=;
	h=Message-ID:Date:Subject:From:To:Cc:References:In-Reply-To:
	 Content-Type:MIME-Version; b=mm7c/8q33LkDSl0pRIw76dw4Xbn5UNj8kAIW//YHPZ4eMGXlVPQSsWWqGzU73LPJBCiOwkFcUDjAdjLkZaF1QjtkAntFBbsot5f7UcWXnauuAaGTyQ4XDA7ShNTIIYJUq5IzFN/652/lVaYyK03Hi02xAYuYStjL0ihAGra05Ik=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=TppgadPb; arc=fail smtp.client-ip=40.107.223.89
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=LCj8lOLWkN6wac1AwbuJSfly+9VlQKEgEekw2YZaOPGqtQ2lo9A7p0CrzYWJ60gv8l1/SioFmS2j+EzYbqs5X4si0Hc7HD0Mebl+Q1PHfWLFITnvBKHS5sbNEk5BCIJEYvTWJ4oFfva9OAcURZN0mOkoDFPQMrJvCUd2MWVwqpz3OfGa09wohWsnyGLV72jKSTu90SwONVFTeg3pmZRCiXYwKcbhHldgNJeQTwBlN20KY/ZzULk5xnPAHd557+2ovW7mzju4WSfDahpSJ86VMahvyT4GI24uDhUq2ZBR4yxmGgSi5EqfeIwlhWRiukg3DGOwp/7QFCH9uhjDxoPv4A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=y/QamnDmO9J6i0btqMyboBud6Ik7Is6cVEE3Q2amE8U=;
 b=GyaddsJPJpcbRRckVn1OOXDMGLrQTiGNvgEAWSHRkRy5/EvkHyOKEs/BJRfRx8Ray8KbSA8erpxscVcBkVxUmv8mb8xwaVP49SJzSqNlENrbT/6DSKB7UVEdfjpHHm+ykSI1Pm0LsN6E9YfYKIzj6vddbuq6TRmn9kzXTIRuz8lXNovF3pVXTiZJK3tXoorn4uPfHRTOwhfjcKPh0mPGyQiWsbfen91JzA6m94/WwH9chzkX2CRhG3HmwMZOqzylU6a3V+5qaaKNh25l9HbZEsrTyH+4G9o+YRdA5j2rLGDtSt2Farzz19Ybyev3Y1Cb80N/HUi2Xh+fstBkjLu3Dw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=y/QamnDmO9J6i0btqMyboBud6Ik7Is6cVEE3Q2amE8U=;
 b=TppgadPb3ORl0llXMmFLi3ch95RPTlBNTKDe5cTF4oj6VCcR8Zk/+dx+ku5pe5VlJiEcXrmdRnYKKESyuEyknASAG/YOROXgI9H+bb481rsVZbuU+OzkkHrCeNjJ8MZppQgl/RGosZcKT76MPpJfPTUxdF3lD0bypULnJUr632bix+0YFehIbfSZAfAFEVj3cHzKDe/l/9r9qdUXQkLMff8AlmotLb4d92xgJ7SbeHvW2qq63qUrB2i7hiWwFmv2gUSFJxi2cR8tZxeNA/LKleqaEqgnnuAt/wlU7K0Ql4kmKDylvOOTzDKIvNGph19jvgL1gBTPuLmiC8RhBJhgJw==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from MW4PR12MB7141.namprd12.prod.outlook.com (2603:10b6:303:213::20)
 by IA1PR12MB9061.namprd12.prod.outlook.com (2603:10b6:208:3ab::6) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8678.34; Wed, 30 Apr
 2025 12:12:44 +0000
Received: from MW4PR12MB7141.namprd12.prod.outlook.com
 ([fe80::932c:7607:9eaa:b1f2]) by MW4PR12MB7141.namprd12.prod.outlook.com
 ([fe80::932c:7607:9eaa:b1f2%5]) with mapi id 15.20.8678.025; Wed, 30 Apr 2025
 12:12:44 +0000
Message-ID: <e40e5776-7c37-4b8b-853c-d4ba693a5f9d@nvidia.com>
Date: Wed, 30 Apr 2025 15:12:37 +0300
User-Agent: Mozilla Thunderbird
Subject: Re: net-shapers plan
From: Carolina Jubran <cjubran@nvidia.com>
To: Jakub Kicinski <kuba@kernel.org>
Cc: Cosmin Ratiu <cratiu@nvidia.com>,
 "netdev@vger.kernel.org" <netdev@vger.kernel.org>,
 "horms@kernel.org" <horms@kernel.org>,
 "andrew+netdev@lunn.ch" <andrew+netdev@lunn.ch>,
 "davem@davemloft.net" <davem@davemloft.net>, Tariq Toukan
 <tariqt@nvidia.com>, Gal Pressman <gal@nvidia.com>,
 "jiri@resnulli.us" <jiri@resnulli.us>,
 "edumazet@google.com" <edumazet@google.com>,
 Saeed Mahameed <saeedm@nvidia.com>, "pabeni@redhat.com" <pabeni@redhat.com>
References: <d9831d0c940a7b77419abe7c7330e822bbfd1cfb.camel@nvidia.com>
 <20250328051350.5055efe9@kernel.org>
 <a3e8c008-384f-413e-bfa0-6e4568770213@nvidia.com>
 <20250401075045.1fa012f5@kernel.org>
 <1fc5aaa2-1c3d-48cc-99a8-523ed82b4cf9@nvidia.com>
 <20250409150639.30a4c041@kernel.org>
 <2f747aac-767c-4631-b1db-436b11b83015@nvidia.com>
 <20250410161611.5321eb9f@kernel.org>
 <9768e1e0-3a76-47af-b0f5-17793721bb0a@nvidia.com>
 <20250414092700.5965984a@kernel.org>
 <a6beaa28-cd5d-4a8b-9df5-9f09b2632849@nvidia.com>
Content-Language: en-US
In-Reply-To: <a6beaa28-cd5d-4a8b-9df5-9f09b2632849@nvidia.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: MI2P293CA0011.ITAP293.PROD.OUTLOOK.COM
 (2603:10a6:290:45::11) To MW4PR12MB7141.namprd12.prod.outlook.com
 (2603:10b6:303:213::20)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MW4PR12MB7141:EE_|IA1PR12MB9061:EE_
X-MS-Office365-Filtering-Correlation-Id: 1c6047c4-bd7f-435d-def0-08dd87e04fd9
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|376014|366016;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?ZDBDS3ZHZlVLa2tUREd6QXZkanFhV1ZNUis2Lys4NWROM1Z0L01ZN0JiZ3Zj?=
 =?utf-8?B?Mnlib1crcFU5MEkvbzZqakFLVm1DaHZleGhwZ3Z3V3h6aXo4WUg4REtNRGlu?=
 =?utf-8?B?YUpQNGlLN1FtbXh2UlljbkdqdDJvUEhNQVdGYU5pWkp0aXRFRG5KSmR6Sjlm?=
 =?utf-8?B?L0tMV05ra3M2Mk5EM2ZoNmYybEh1VFZOeWNqTVZaL3oyL21tTS91UFU4L2gx?=
 =?utf-8?B?czdmaHRwQnBYdEkwcFFSVUZXRmQ5b0d1bXRJM0hrV1ZvOUMxbHFEYkpKMmpE?=
 =?utf-8?B?dExKSFVwTkJGNFJmK09oRGpFa3FFV29RVC9wSzFyMWdNSXVQRnlWWmt1aTZ5?=
 =?utf-8?B?NExmZWREa0ZPd01tczhtTXlSSVJ3dWU5bkladWRpdmtQZmx2bGZhT0xoK1lh?=
 =?utf-8?B?YnR4aWhhbWJyUWRqVDN2SFZwTUprZDJCMlpNWWhKa3JXS0xxeG5qellONS85?=
 =?utf-8?B?M2hEVWNIUVp0UnZvRjNaVC9JbzljakpwZ2IrZE45Q3lEMm5yUExvQkdPaE5y?=
 =?utf-8?B?OEFkUnJUaWxkdFQveUpaMHJnbUU1c3Vqam9KU2VLcnVMelJCWVJOWE5VNnpM?=
 =?utf-8?B?eGxnNy9TTWcrbWpBNFhrZ1FLcDIydXE2OFd4TmM2bVpwNlV5ZEV1cmxZVVZy?=
 =?utf-8?B?TlBBOHdQRFVra1JMSWFRVFlxTktKNnlHdzVlQ1BWdCszTjhWYTU5Qy9XRitF?=
 =?utf-8?B?U0xVWmF2emF3SGtRVFA0UEtXWkRVUEttbys1cHFWOWEwcWRmL1hKemkzcTJE?=
 =?utf-8?B?Smp5RklhZWRmS2pPTndFbnpSSHRtaXY3U0VsM01nWGd2aEFqOUdWbWtDRSt0?=
 =?utf-8?B?cjFmRG5SclhndnhDa1lCckorUU80RVZkWVAxMm1zUkxRdnhJMkthUHl2SXZF?=
 =?utf-8?B?Y0UvTSsrbEEzRk1TdUxVbEoraUxuR1ladVZFaUsyTE93Y0E0dVJWTy9ZV3du?=
 =?utf-8?B?c1dOeHd1QkFLSlNocDBlWWpjUHMwSk4yWStxOE80Nk1GUUZPTGVBMEs2cmc5?=
 =?utf-8?B?cEwvRkl5WWQwNFp2L1RRN1RBMXZSNFRES3RYSVhDY2tpU3VzNG5zd1NJWUxY?=
 =?utf-8?B?MjhJd0xhenVOd1lpQStOYllpbk5vTkxyUiswekRTQThrZ3BCczZPb1BwcG5D?=
 =?utf-8?B?REc0aWtoWThrOFlmZXNOR1dKVmNzTE5QbkN6ZkdWcGFYd3NBNkIxNzBNQ2Fw?=
 =?utf-8?B?OHJMUzk0c2cvRThsOFYyVHkzRDZnTEVmbWJGOWs3K3ZIZlJWcThXQXNLb202?=
 =?utf-8?B?d0FGbk4vNFRMbVJMM3dqS1BuYWVMT1Q4NWpuTVlIUE9jQVcvMjU0aGY1Yk1j?=
 =?utf-8?B?TUVoa0h1YTFSeWN2ekZOY1hKWWM5MWxoU3dqVEdRWTI4ZWtxay9CeFZhVUhv?=
 =?utf-8?B?bldvZ21MaEFLUUwzZVhoazdQTVRtTnFISTA2UzZPMWp0K25MN3VmNE9GMEYv?=
 =?utf-8?B?elNVSDk2V00vV2Eza3hjam53cEpObVBmZ2JOZUJEWngzdTVWbkRLdVdwSXYw?=
 =?utf-8?B?QUcrdk5nZHNmd3p6ancwUmx3MkduRE1uU1ZieVR2OU5ocVFKb3F5NzlET0lX?=
 =?utf-8?B?cXcyRE1PQ0tFZXUrUW41ODB6WnluYTFZdWdNSnNqM3E2UEIzYU5LTCt3amwx?=
 =?utf-8?B?QzhDV3JHekxnUU1NWmMzNUJIVzZJZ1k4LzdtejFJRjdQc003YmxJNm1nMFBx?=
 =?utf-8?B?QnBmNHZRb3FmVEZwLzlXcGFHMzFSWFBPaWRBdlpsbHFCNVlSSHNEaU9MdnA3?=
 =?utf-8?B?bTJzSmhabCtQRjBJNnhYVHozNlFJVVdodDdidWtQUnovM2FXbGQ4Q1ZKakN3?=
 =?utf-8?B?WUZ4cG01d3NzUTdwa3hIbEZndUJjanRsZzBrK3lORE0yY3Buc1hnSmFsVzJV?=
 =?utf-8?B?RXJIVDdwbTRCb3I1WHRjcGxvOExpVmZxdHNTUmQ1Rm5IN1o0cWF5MHpNOVd1?=
 =?utf-8?Q?wSsK0Xb4OyU=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MW4PR12MB7141.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(376014)(366016);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?RTVKOWJGSUZJNUFTNTY1ZU1ETVJxcnhUR0RyMjlsL0pqdGhORW5GZm5OK2J1?=
 =?utf-8?B?QVprQ3BpMDZyTklrbnVWWEg4aDVyQ1RiNytSSG5QTWF4K1ZWelJnMENSbEd5?=
 =?utf-8?B?SHQ2OHMrZEg5L0xCa3V4VExoT3QvaHRXbG9CRzJuNkU2alJQM3g2cnFIUkJ3?=
 =?utf-8?B?a09vSWFoT25TcFpPUWRSSU4yTEk5QXhKNzNhOFJxcjYrUzJUWVJUYmJlOWpG?=
 =?utf-8?B?aXpmMUx2SUNueGJUcWVrQnhZNlRackUwNWpnTngyNjFjWlN4Wnc1RVNtMjhp?=
 =?utf-8?B?MDFNZzU2T1RNZngyV3ZYQjY2aDNZY2VKTGM3YXY5TWE0Y0Q4UHJhd2k3aGR4?=
 =?utf-8?B?d0hUZ1dBaUNkVVErTndPOGRWaE12MHVzVWZhTFB4aXdEMHptZVRQWS9aWk9B?=
 =?utf-8?B?MHJQVTJSNjdFa3FZRkVMcWo5L05mK3lBTC85SDJyRWlIREY1TEVDb2UzVmVI?=
 =?utf-8?B?Ym9oWlZVRHlhZ09zMndsMXRDWCtTQ0o1L2puQkU3aThKcVNrdEZ6eGxiaDN3?=
 =?utf-8?B?eVgveFZwQ0dnNktEcmMyd3dmdEl4bmo4T05abnFJdC9rSUZhZWRPZzY5MHNj?=
 =?utf-8?B?cnZRS2pEYW85a0JiempscHl3dWFENjZMUDlEbE5ya3hnTGdjS3ZPeXJBSloz?=
 =?utf-8?B?MU91VU9EY0JMd3Zpa3V5cytsSC9HenZZZklqaUNMTXpNb3o5WkZrQlhpWWNt?=
 =?utf-8?B?NGlySWorM2JycnFnMm1uYmZmRjNOalNkdENWODBSNXFGcU9QYTRkTUdKWkZQ?=
 =?utf-8?B?cUwyeHNHL2dlNm9NTlZUYkdkTzVIMkt3QzNpdGZMaU1OUDFPcDI5U1dkVklM?=
 =?utf-8?B?Y0pGWDQrV0MxN2dJN3JYWjNBdTJUSkplVVdSNzFqSHdtdmhsWFh3SC8vSk5v?=
 =?utf-8?B?MndMcE41RnpFVG5vaDV3WXhqaDUxZzZuMDJQM3pNZDdGc21kaStYZjBSSkR4?=
 =?utf-8?B?VEU3SU9mbTcwbzYvOHRZc0RDWE4wQnZkTFArTHlvU0VUTHdSRnF3K2RCWkR0?=
 =?utf-8?B?TjJSMFA4Sm9LWHBIVzNMT3Z1YS9JTi80RE8rYlZKUWY2MG1mbm9nd0FTeHZR?=
 =?utf-8?B?TVNJa1hGblYySTlieU1ici9adUh1ZnVmd1lERXJ3RzJrajJXYkUvc3h4RG9C?=
 =?utf-8?B?OHdSV25nQnFHWndlbTEzdGxXOXo0bXl2ZTVxMFFDSG1VdnpIRU5NZzF4Y3hC?=
 =?utf-8?B?aHF1VXVLVWJiL2ZtSndVa1p0NWpEUTRtK29hYkI0d2pLaDVlYXdURFhrTWRC?=
 =?utf-8?B?NWMwMFZZMER5b2d3WkN5dGRnMGxueDYwdE0vajE2ellwTGI2Z1VIREtUSDRB?=
 =?utf-8?B?SGFodzQ4L3VRcEFZQVNDT3VQcTJ1L2FsSC92amFIUHpSRTl3OEJ0K2lwbjAz?=
 =?utf-8?B?MU1tZkhuWjl0R2VkL2ZqZEFENzRYVGd0ZU81RVN6Z3dEQStqUHFXdGM0d2NE?=
 =?utf-8?B?QUtzd29iZGFkQVQzSU0xamxUWlA5NEdFWjJiWExXVlZ6ei9ZR3htSStsSy9w?=
 =?utf-8?B?YWNhbzBmT0U0SnlySCsvMXBVVGV1ekRUK2Z3VGNieVljS0ZFN1BleGlCSWpX?=
 =?utf-8?B?R3dKdVByRGZ0V1JaS3VUY0gvaERJWFdBTlVIWnl3dUdRRkcxNDU5S3pVUURw?=
 =?utf-8?B?S2NrWEY0dkpLYlF5SENWalhLM2p5Lyt6UXdrZG16bVpHQW5wWVFxSUhiZ0Zs?=
 =?utf-8?B?dWNYcS9Ia09wa3JEUkRmR2w3NFNwWndUWk5JYnQ4Mkt3eFp0OE5qdEtiZCtI?=
 =?utf-8?B?SDJ1YmwrQnpvUDZNVjlnVlc0YVp2dVdNRUVrUkt6SDhXc1YzSFdiSXgxUk5s?=
 =?utf-8?B?eW16ZHMzUzR5ZW9nYzdoeFNJc0w3TWdWVEhTa3pheWZyWWt3ZlVVWDZ3Tk1o?=
 =?utf-8?B?c3FYSjRWVVBvYTlJWEFWUXk2TkVFK1czQ1pZUktNN24vcjdGbjlvNWV2aXI0?=
 =?utf-8?B?RVpLZTZSWU9GbFBwM1lmdHlKL0RFYnMzdkIrN2hmNzZqUHgzN3RWNlpOajBG?=
 =?utf-8?B?dDZuN3hmYXQ2WmppaWlrbG9seURueFMzeXZPZmFRMzZZdFBrODRuZjdNa2ZP?=
 =?utf-8?B?aXlkZW11a0oyYURYTGJkT083dVpPL0FRTXBBSnlqdUM2TzgxRjMrcjkzeTFy?=
 =?utf-8?Q?wKKDTEk28ZQZRQB9d9+sQeSBi?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 1c6047c4-bd7f-435d-def0-08dd87e04fd9
X-MS-Exchange-CrossTenant-AuthSource: MW4PR12MB7141.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 30 Apr 2025 12:12:44.1534
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: AggPOfd1726ewHugbjVab9ucFgWnovk5NDvxGOC9x64RPj63aDPKHfYXiCelQeOgTRFvf57Q1Jc479zGfWJj2Q==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA1PR12MB9061



On 23/04/2025 9:50, Carolina Jubran wrote:
> 
> 
> On 14/04/2025 19:27, Jakub Kicinski wrote:
>> On Mon, 14 Apr 2025 11:27:00 +0300 Carolina Jubran wrote:
>>>> I hope you understand my concern, tho. Since you're providing the first
>>>> implementation, if the users can grow dependent on such behavior we'd
>>>> be in no position to explain later that it's just a quirk of mlx5 and
>>>> not how the API is intended to operate.
>>>
>>> Thanks for bringing this up. I want to make it clear that traffic
>>> classes must be properly matched to queues. We don’t rely on the
>>> hardware fallback behavior in mlx5. If the driver or firmware isn’t
>>> configured correctly, traffic class bandwidth control won’t work as
>>> expected — the user will suffer from constant switching of the TX queue
>>> between scheduling queues and head-of-line blocking. As a result, users
>>> shouldn’t expect reliable performance or correct bandwidth allocation.
>>> We don’t encourage configuring this without proper TX queue mapping, so
>>> users won’t grow dependent on behavior that only happens to work 
>>> without it.
>>> We tried to highlight this in the plan section discussing queue
>>> selection and head-of-line blocking: To make traffic class shaping work,
>>> we must keep traffic classes separate for each transmit queue.
>>
>> Right, my concern is more that there is no requirement for explicit
>> configuration of the queues, as long as traffic arrives silo'ed WRT
>> DSCP markings. As long as a VF sorts the traffic it does not have
>> to explicitly say (or even know) that queue A will land in TC N.
>>
> 
> Even if the VF sends DSCP marked traffic, the packet's classification 
> into a traffic class still depends on the prio-to-TC mapping set by the 
> hypervisor. Without that mapping, the hardware can't reliably classify 
> packets, and traffic may not land in the intended TC.
> 
> Overall, for traffic class separation and scheduling to work as 
> intended, the VF and hypervisor need to be in sync. The VF provides the 
> markings, but the hypervisor owns the classification logic.
> 
> The hypervisor sets up the classification mechanism; it’s up to the VFs 
> to use it correctly, otherwise, packets will be misclassified. In a 
> virtualized setup, VFs are untrusted and don’t control classification or 
> shaping, they just select which queue to transmit on.
> 
>> BTW the classification is before all rewrites? IOW flower or any other
>> forwarding rules cannot affect scheduling?
> 
> The classification happens after forwarding actions. So yes, if the user 
> modifies DSCP or VLAN priority as part of a TC rule, that rewritten 
> value is what we use for classification and scheduling. The 
> classification reflects how the packet will look on the wire.
> 

Just to add a clarification on top of my previous reply:

The hardware does not reclassify packets. The packet's priority (from 
DSCP or VLAN PCP) is interpreted based on the prio-to-TC mapping set by 
the hypervisor, and that classification remains unchanged.

What actually happens is that if the packet’s traffic class differs from 
the TC associated with the current scheduler of the SQ, the SQ is moved 
to the correct TC scheduler to maintain traffic separation. This SQ 
movement does not change the packet’s classification.

This is necessary to avoid sending traffic through the wrong TC 
scheduler. Otherwise, packets would bypass the intended shaping 
hierarchy, and traffic isolation between classes would break.

In particular, without this queue movement, backpressure applied to a 
traffic class would incorrectly stall packets from other classes, 
leading to HOL blocking, exactly the kind of behavior we want to prevent 
by keeping queues bound to a single TC.

So this is not a reclassification of the packet itself, but a necessary 
mechanism to enforce correct scheduling and maintain class based 
isolation. Smart SQ selection helps improve performance by avoiding 
scheduler transitions, but it's just an optimization, not something that 
affects classification.




