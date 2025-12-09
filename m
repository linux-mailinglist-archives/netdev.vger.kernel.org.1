Return-Path: <netdev+bounces-244113-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id 033E6CAFEB9
	for <lists+netdev@lfdr.de>; Tue, 09 Dec 2025 13:27:29 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 9ECE2300F716
	for <lists+netdev@lfdr.de>; Tue,  9 Dec 2025 12:27:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D9F2C322A00;
	Tue,  9 Dec 2025 12:27:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=altera.com header.i=@altera.com header.b="E/qtCTKU"
X-Original-To: netdev@vger.kernel.org
Received: from DM5PR21CU001.outbound.protection.outlook.com (mail-centralusazon11011058.outbound.protection.outlook.com [52.101.62.58])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4DD822F8BC5;
	Tue,  9 Dec 2025 12:27:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.62.58
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1765283243; cv=fail; b=gsjYWB8FZ76uTT4pZj6XLGsOFfbYL01CiDjejXzvTAcU3bf8kJEEhrAUouOcyK7QHg+WuaNH25g0hNbLqqB6MORlWYPkOS+iQia9xE/fjXPyWsSOvtJlrKcSKziZcpITADV3f9nimC8TujJJ05QA/I7PBAoN+EirDajpK8/OMu4=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1765283243; c=relaxed/simple;
	bh=S4dEpbfdToLYOQVLl2JcOwIjmpYz+mkHHVPpjQ0CqWo=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=euCaTd3dz5nAASSjAgoFesjRQQX13WG08G6Eok7LNUwhBUD3c5ywtihjbMQzzK4QoqaOlug2dbDsxJKMiJjPiYp3m3jmCpV4FttgunzX41OiLaCvRo1lAx1Lq5d2HHd9a/5O6Sd9whcfxOUobizTXcbXbhL8Md2CGSus8tYvWUs=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=altera.com; spf=pass smtp.mailfrom=altera.com; dkim=pass (2048-bit key) header.d=altera.com header.i=@altera.com header.b=E/qtCTKU; arc=fail smtp.client-ip=52.101.62.58
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=altera.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=altera.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=powPSyK7bQUhL2PvpQEOsUHNLR9PZLgmm8V0CxjeNsMYA8d2VmUpZOteqnrNjN+4cUP03PJLi41o1uGepAM94smIL0ZiMbE1h7DsMLCmZtHkjt2c684Hsf7ZWk37srBwaWCAVbVxuL2cbIl5F4Wsx2lf5y1iM7wwZ6cwUDlJna4XNUsetel5KNC66QAGTwE7aMovrSM38I4ptY0DEThPwt3dyvM4K/1Gk6ho9ju8mpPLZp0dF653RLRyJB3alTtjGlTQhENoo/t02eYnSr0GN62U+u9P9mOU4VP1reTyavYNFXQp+70DFcLhBI3tYJgwxq4OvUk4d3UqL91Lh0GfxQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=TJ/jJLbIKy4X5bl+oBRhTqLaLIf13zlUSxQngiqzjSE=;
 b=PiqMUBxlFiYx19UV+4KhWBn0DLaFWmcsxcxpd5fsdBVEDqppI0YrZOlbMFS7aJe/IuKNnmBBBLuYSjojodV4L3L1B5HeeGuT4Y4DozpwmRvcZPaWsuE3SzDRQO3f104QK9Gq2yczDtNt2f21m6wXQnsbAUf62ohxBcNdo15BNMm2cx7CDZfmxNeFUeEqdJR5gsLtkIG+Dgp5Vy4Cjw13NN56R+DMUtJXzCWyEGO3RQjHFzioTFQ3xgFCnst8n7rtjhYCDYla1AjxEO/6I0WQOtvFD8XpSuhMSUoX6PMMzI6EfGvMyvcZADLiWAEBLHa2ezvTgqGIp+orn/1p179XkA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=altera.com; dmarc=pass action=none header.from=altera.com;
 dkim=pass header.d=altera.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=altera.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=TJ/jJLbIKy4X5bl+oBRhTqLaLIf13zlUSxQngiqzjSE=;
 b=E/qtCTKU9cfNFKWJGPeGCDjL5FSjqiRB8W+J1gk+fjDoX5gTH1F1lcr/C2S3VyS5hnNFHiTn2LlU1Jmh8fSZ1RNWGZ4c+jMA5rhg2V8XlFz0VJx/zPFLpaIx7xBIOM5IfDoRNKFJZAvMJEhD5qlxtoMsN+RKQuYPMQ+2TZsjxiYSmR0ElZi8aA/ETzv9EjRoXZhiL1qb4legyJ58JC4v4KToya4xNyahpF/MyrTuPymYfZ14IRwb3M9toFWgnNKf8tb9joBIiR8roJywHc6Yx2Tqnh1qH7c04OG5DwYAu1+brZB26Kunfi6k2b74EBsNkJDj65FMtLXd3wbo9DYoLA==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=altera.com;
Received: from DM6PR03MB5371.namprd03.prod.outlook.com (2603:10b6:5:24c::21)
 by SJ0PR03MB7152.namprd03.prod.outlook.com (2603:10b6:a03:4d5::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9388.14; Tue, 9 Dec
 2025 12:27:17 +0000
Received: from DM6PR03MB5371.namprd03.prod.outlook.com
 ([fe80::8d3c:c90d:40c:7076]) by DM6PR03MB5371.namprd03.prod.outlook.com
 ([fe80::8d3c:c90d:40c:7076%4]) with mapi id 15.20.9388.013; Tue, 9 Dec 2025
 12:27:17 +0000
Message-ID: <29e1a620-1747-4a48-9ead-867c1e5734d0@altera.com>
Date: Tue, 9 Dec 2025 17:57:07 +0530
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net v2] net: stmmac: Fix E2E delay mechanism
To: Paolo Abeni <pabeni@redhat.com>, Andrew Lunn <andrew+netdev@lunn.ch>,
 "David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>,
 Jakub Kicinski <kuba@kernel.org>, Maxime Coquelin
 <mcoquelin.stm32@gmail.com>, Alexandre Torgue
 <alexandre.torgue@foss.st.com>, Richard Cochran <richardcochran@gmail.com>,
 Jose Abreu <Jose.Abreu@synopsys.com>, Fugang Duan <fugang.duan@nxp.com>,
 Kurt Kanzenbach <kurt@linutronix.de>
Cc: netdev@vger.kernel.org, linux-stm32@st-md-mailman.stormreply.com,
 linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
References: <20251129-ext-ptp-2v-v2-1-d23aca3e694f@altera.com>
 <26656845-d9d6-4fd2-bfff-99996cf03741@redhat.com>
Content-Language: en-US
From: "G Thomas, Rohan" <rohan.g.thomas@altera.com>
In-Reply-To: <26656845-d9d6-4fd2-bfff-99996cf03741@redhat.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: MAXP287CA0019.INDP287.PROD.OUTLOOK.COM
 (2603:1096:a00:49::28) To DM6PR03MB5371.namprd03.prod.outlook.com
 (2603:10b6:5:24c::21)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM6PR03MB5371:EE_|SJ0PR03MB7152:EE_
X-MS-Office365-Filtering-Correlation-Id: 83ab31b0-375a-4a6a-db99-08de371e4a7c
X-MS-Exchange-AtpMessageProperties: SA
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|7416014|376014|366016|921020;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?UWZJcU9SR0ZMOXVlci9jdDB3K1E0ZGRRM1hwcHQrd1pRRUd3Zks3N2RZT2hW?=
 =?utf-8?B?djVOUUlQQWtvOE92K1Z1ZzlsdGNSaXl4dXl3amI5Y1Y3a3BNTmUreVNvQURQ?=
 =?utf-8?B?NC9XN2lXZm41aVd5UDYzRUVxaStzcVMwYVFXcDh2UmFNNnMxTURkMk0xaldx?=
 =?utf-8?B?cFdMalZkTXplMmNUby9VdDZ0d1F6ekdtdGplUUhtaWF4ZllPQzFCODAza1Z1?=
 =?utf-8?B?NVZUUlFrRDJOWlREWE1tbCs3OTZNcEJBOWZQazN6Ym1NT05CTEo5aGNiSG9H?=
 =?utf-8?B?SnJUbjl2S0hmUDJHS1I3OWhVcGhUVThBcU1kOWdxRU1oSlJRUS81d2QwQVI5?=
 =?utf-8?B?Z0xJcEVxNkFPNlJQeGJadHlITjRORzEwM0tWLytsdzRPOXNjRjZiTU8rVllZ?=
 =?utf-8?B?b1NpaDJDdWdEWjdvVVllK2JKUzBPT211d3RMOG5yNEVSaTU4czJQNCtVdm5W?=
 =?utf-8?B?TzhvS0N3bThhbTJ1WVhkZHVQRzU5cWJpSi9XcDhZTld3MmJIekF2RjlMcm1R?=
 =?utf-8?B?YWZoZDEwd01xc0pNMEs0UFhEWG9uaFZKTVFNOU9uVjdVSzBXTk5CTXB1N3JR?=
 =?utf-8?B?MnRJQjJlaGd3Z3MyUUJqMG14OVppdFlvYk5vci9pNkhBYU5CSDVRMU00SHZY?=
 =?utf-8?B?K29UOU1LMXVMOHAzTVIwZG1UZGNobFhZT20zNEtVNFZRVVJCSXZsYzAyR0lt?=
 =?utf-8?B?Q01zWU5JcVplWUdBNWlYQUFEcWdiUkoxZ0dHNUFBVG9tVW1tOXJhWmZ4RW82?=
 =?utf-8?B?RW5qbVFTZHd3S2ZZUmxEY1JDSENlTXRQY1pEc2kwSm9HWk13TStMZktYaWxa?=
 =?utf-8?B?dFRWN2ZnNW5nVzNKd2xzV0dwZUxmdzNRenZiM3ZNVjY5ajFSUExvRGRqdURI?=
 =?utf-8?B?VU1oVlRIMDk1TUdFZU5TWUk2NVFHQ2JodVhvVEVUUE5jVnJZKytGVlgvSE4v?=
 =?utf-8?B?cll1Q0VGaWJzWHh6dGwwY3BKQWptM1hxMEp3bkxFYXIxRm9CZE1YMG1BNFFV?=
 =?utf-8?B?ajNQSk9EVVQvcTlWWktGWlgrdTRhbzJaMmVwZ0dNZFVFVEZzSnVTdjB1UGRt?=
 =?utf-8?B?SjFha2ZlMEdaZG4yZkxmb0RwV1FRdEtwbVprVkRrOExGeEhmanptWlVpZGlW?=
 =?utf-8?B?ZFp4K3lHbWFiVG52S0E4OXh4ejlUbGxDWFMzYXpGWTFMdjRUZ29FMTh0N2c5?=
 =?utf-8?B?Zk15U3NlQll3RjJlVDZnbndYVkNrYUVTdUhjRHczR3hURm9ZekFhR25Fa000?=
 =?utf-8?B?VnF2Zk5YQnRBRFVJVUR4V2J0SUtBemtoT0lhQlpzM2N6R0QzQ0FrWUF5Rks0?=
 =?utf-8?B?b1dGNy9welJlVTJzaHFxVHRLZng1ZWxnQnViY0VhMUhUL1EvcXN5ekdabGNr?=
 =?utf-8?B?Tlcyb2p6MGJycnJyWmFKcWVVWFlPTXg2RldHcTNxRlBkd09WU3QzbHE3YXll?=
 =?utf-8?B?dGx6ekRJS3N3RktNT3lHeTM5QWRxak5rdE93MzMxK2h3RjJhb0RFeWhiT0lN?=
 =?utf-8?B?ZnF5L21CbnIzSzhQS2xuZE1rRWh3ckYydThKbmpDd3EzR25acVJwaTlyeXZ0?=
 =?utf-8?B?alVOYVB1QkZhUjlCajZaQ1haZUZFTG00cXhUVURlekRDYUdGN2hwMXM0dVlr?=
 =?utf-8?B?NDB4ay9wZE5kSE1zbTFFc2QrRS9BdCtoYWlGZENDdTNvYmlDVzFUMUZtOTJh?=
 =?utf-8?B?OUh0cTYzTlhOQ3M4V3ZjWGdsNy9wL2o2Nk1xK0IyUEorT05jL09ZVHdoaG1m?=
 =?utf-8?B?M0gvUnRVKzVGc3JZcnZQTGpCekhyWGdFQUgrSno4U3FLMm5yWDNKMGRIM3RX?=
 =?utf-8?B?Mkkzd1dxZW93a296aHFIV1E0Q0pHa0d2a0h3M2dLTGhVd1d6cGdwMHBmd000?=
 =?utf-8?B?c0x1TmU1MU1QSFVkYW9PQTA5TjVlTmJTaC90ZGFzUGF4YWJKTEpoWVBYL1I1?=
 =?utf-8?B?azk1bys4cEtaenlKUWhuMWMwaG44VVE4cDNSeUNaQnVzRDZxaTB4eU9RYWJk?=
 =?utf-8?Q?hkuFf5yzS52O7PNUZgdKESBOCpCvhw=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM6PR03MB5371.namprd03.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(7416014)(376014)(366016)(921020);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?QXIyUHNrbk1SbEUvTE5ETHdJN1NRdEliYlowcWRDSGttd3gveFlGc2JTNHBi?=
 =?utf-8?B?VWVkYnBDczFIQnJlZFNQYld5b282UkdPdlJsdmNvRnFYYkFDcmhXMnJMeDlQ?=
 =?utf-8?B?NTZnVnBBcmRGOGVpaTJYUXlYLy9OVXBVeXhzUkE5Q2pwUU5tVkNNVDJ1elVD?=
 =?utf-8?B?QnU1ZWoyMWQxUnpXRlByU3RyaENQZmYvRUlPbi9JUjRaazZvN1FidFVIb3pw?=
 =?utf-8?B?bVJTTkNHSUozZmFXMGphazZMTGNXZldZUGhnT2V2dEJTQ2w0ZnladVZUb1lE?=
 =?utf-8?B?N3NCNnRCZ00zYzBkWmd3VjZwaXMrejdUSGYwWU1yYVFjcFdsaTh5TnNVY2F3?=
 =?utf-8?B?aE5Tb2xMRHFQdFd2ZjZtdDZIYVVZc29JV0lHaGNEN2U3Z1VWWUlXT3JrdGNo?=
 =?utf-8?B?VXYrTjNzc3JLaEllVTRTQ0lLTmZvdm9nc1AwU0VHNlBXbmFNRU5BeUgvV1Jy?=
 =?utf-8?B?QU9LdnNhcWFyOStNdUlHQVdtTllIdlFrNE9YdVRjQUk1TE8zejY5TmFTWmxK?=
 =?utf-8?B?NXZwQWx4UWdNVkpwYmZEaGV0ZnR0K1NhYm83aVJXbHJuQmowRVh3eEh2YU1y?=
 =?utf-8?B?WFhWbGg0a1kxTzhNeXZISFdvVENhNzhVNjA1N2FCcTlENUdMakNSSW0yNHRS?=
 =?utf-8?B?UnJGLzhEcTBRdG9xQ0VMQlRMUVd1bVgrUUhwWnp5cmltenUyeC9hUERHb0hy?=
 =?utf-8?B?bDZYQS9TK1ZMdEZncnFJeWhkYlczNkpqa1Nta0RjenZISkxuMW4vZXNwVTd4?=
 =?utf-8?B?cSt5UTc1KzZyVDVPbW81bGU1eU5UV21yYnBqMFRQUWlkdUxXblZZcHdKaDZM?=
 =?utf-8?B?K0c2Uk55UklVVThvRFpJTi9ZdThXUzdVRE1FanFta3RrTksvbVdXZ3h5SG5p?=
 =?utf-8?B?NmRNck9JRUdOcXByV1d1V0dQWDNVaElrSXRrVHFoc0xKTGE3VnZmdFg4anhG?=
 =?utf-8?B?SDJDRHNvL0RyN3lqUHh0YnZaV2hUUlErV2M2Z25tMElCMHNlc0gvY1ZQQ1hh?=
 =?utf-8?B?WUhGRHpOZG53NTd6Qys4bVhhdzFUSlp5SGN4RnNJWk80ekVVZVBiS0J6Zk9T?=
 =?utf-8?B?bnloZjRQY0pDOVJ6aldRd0xJQlhZM1paS1JLbiswSUttMUltMU5ZWjJwNlI5?=
 =?utf-8?B?bGNmbjZOb1IrU0phRmhzd0pHWmd6b244QTRtMEZKNTNtSUFrTVppdjVVVHBs?=
 =?utf-8?B?K05vRCs1bnpORUhadWJvdjhuOXo3Unl2VFJCaldSQThvNFdjL3RhZ3ZSeXdX?=
 =?utf-8?B?UHJNRlh0cldmcHRqSDNDdEJkVm8wODFBRVBEVVRNTUpWVmtURUZiUUJiUjB5?=
 =?utf-8?B?SmhnUkNnZnJTdW8wT05DNndQcDBqRGMvTVNOV2FWWnVKRTYwYkVRMzIvUWJK?=
 =?utf-8?B?YURhd2xXTndMTlZPWTZudkV0MmRKNUdyaTFUNnh6blU0SzdMQy9zcFFYSC9y?=
 =?utf-8?B?b2twWm1JN05teW1QL2ZQcWVFc2NSaHVuY2paaE1jaXVCbTViMnlmKzlSSmhY?=
 =?utf-8?B?WTJXK2c4NXYyclRPY3ZSdVpmVFJHT1A0Z3E5ckJCMytZbmRZb0V5Q2RJZzNu?=
 =?utf-8?B?aUtJMFB3a0JxVEdmd20rdjRVWFYrMnpTMkUyZmxWckJjTWtMWmtXK0hrL0s4?=
 =?utf-8?B?dy9lcVhycjBjSkdrZHJra2E1UEFHVE9sS1ZXTjY4L1JFSm5TWUJNSWtoZTFv?=
 =?utf-8?B?RUZKRUs2R1lYMTlIUlgrVDVxRkNqdlBzZGZuck41VlBnbkswcWtEeXg3cGdz?=
 =?utf-8?B?Q1Z1eEtmK0wyUmJYbmdEVGR2djhYQkdQUUlLNkREYUdyTTNQWjJNYVBaVXNR?=
 =?utf-8?B?MDBITVRydkRHTHBUTkVlRU50dzI1b0xXc2NNNFNFb20zWnp2VHFPbzdPSVV0?=
 =?utf-8?B?bHBpSTk2djFCSjUrVlI2WmpmMFhTZ3ZFbzJQNi9VcjJqbTdoZE9TaFNMWDYx?=
 =?utf-8?B?Z2RLckNxZitMcWVaTlJvWVA3OEx1M0QzZ0hkQ1haV2dmM2NQeGp5WVFXUFo1?=
 =?utf-8?B?b290TURCNktnZ0VvcEhjQWRFdzFjNXNJc2pzNTMxeU5kNDZmdnY2eVIzTGxP?=
 =?utf-8?B?TnRVb2Ntb0lVUlpIR2o2U1FpcVJ3Vm0vNHNHVFcrbncrd2tNeStUZDJQNk12?=
 =?utf-8?B?MERrbG9hcyt5a1RHR1dGeGE0TkJCMHBYM1pqbkVGbmZXZk1hU3hDLzdXM0hW?=
 =?utf-8?B?K1E9PQ==?=
X-OriginatorOrg: altera.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 83ab31b0-375a-4a6a-db99-08de371e4a7c
X-MS-Exchange-CrossTenant-AuthSource: DM6PR03MB5371.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 09 Dec 2025 12:27:17.5156
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: fbd72e03-d4a5-4110-adce-614d51f2077a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: ZMKZuXUJAynGqnc5pSxnj9VbyxVMGNfOdVbfqBf3xuN+xLT6rsnO7cDxLHzl3F/UbVJk3BUU/UCapWTpTJ8Evb02LNx8Vl/DlAu4uQP6KKo=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ0PR03MB7152

Hi Paolo,

On 12/4/2025 3:28 PM, Paolo Abeni wrote:
> On 11/29/25 4:07 AM, Rohan G Thomas wrote:
>> For E2E delay mechanism, "received DELAY_REQ without timestamp" error
>> messages show up for dwmac v3.70+ and dwxgmac IPs.
>>
>> This issue affects socfpga platforms, Agilex7 (dwmac 3.70) and
>> Agilex5 (dwxgmac). According to the databook, to enable timestamping
>> for all events, the SNAPTYPSEL bits in the MAC_Timestamp_Control
>> register must be set to 2'b01, and the TSEVNTENA bit must be cleared
>> to 0'b0.
>>
>> Commit 3cb958027cb8 ("net: stmmac: Fix E2E delay mechanism") already
>> addresses this problem for all dwmacs above version v4.10. However,
>> same holds true for v3.70 and above, as well as for dwxgmac. Updates
>> the check accordingly.
>>
>> Fixes: 14f347334bf2 ("net: stmmac: Correctly take timestamp for PTPv2")
>> Fixes: f2fb6b6275eb ("net: stmmac: enable timestamp snapshot for required PTP packets in dwmac v5.10a")
>> Fixes: 3cb958027cb8 ("net: stmmac: Fix E2E delay mechanism")
>> Signed-off-by: Rohan G Thomas <rohan.g.thomas@altera.com>
>> ---
>> v1 -> v2:
>>     - Rebased patch to net tree
>>     - Replace core_type with has_xgmac
>>     - Nit changes in the commit message
>>     - Link: https://lore.kernel.org/all/20251125-ext-ptp-fix-v1-1-83f9f069cb36@altera.com/
> 
> Given there is some uncertain WRT the exact oldest version to be used,
> it would be great to have some 3rd party testing/feedback on this. Let's
> wait a little more.

Thanks for reviewing the patch. Sure, will wait for additional feedback.

> 
> Thanks,
> 
> Paolo
> 

Best Regards,
Rohan


