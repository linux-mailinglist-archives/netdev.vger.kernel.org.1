Return-Path: <netdev+bounces-151681-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id AADDF9F094A
	for <lists+netdev@lfdr.de>; Fri, 13 Dec 2024 11:20:43 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id B967B16973D
	for <lists+netdev@lfdr.de>; Fri, 13 Dec 2024 10:20:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 84A2D1B395E;
	Fri, 13 Dec 2024 10:20:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="lWRJdSV6"
X-Original-To: netdev@vger.kernel.org
Received: from NAM10-MW2-obe.outbound.protection.outlook.com (mail-mw2nam10on2073.outbound.protection.outlook.com [40.107.94.73])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AF3BB1B218D;
	Fri, 13 Dec 2024 10:20:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.94.73
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734085239; cv=fail; b=kBpvrgEMKh6ZY5JTjTgRnraxBL2o7zOdZumuGNisJDFBk+uqEKB9oZWJJ8p7DQfw3pOmB/gNLM/jr7/AJd52vXiv9GIt7jHnip/g/LxnhcrKpRMS6zkIwTsKTTWPhmbHDLGYzo1apUPCEvyiiK5qnKpYXuJQicnP5zMLb1IAO6o=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734085239; c=relaxed/simple;
	bh=IaNJR9FF3Q7o1xEfp1oX5friuxuqpks/cLTTGV6bkIA=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=WIg6045pB3UCPGr0SvO2j5Xl0ntbeXXj/zko+Akl95fCHD4cVaiI7SkDmIz+hg5MwjsTN0XsbF+1FwiKQMwveutiwW6PKNGhk1UxDKI/f0zdWRXVBgDOmJ8w6Q2g7nHmSPDm6TlTkM2F0+QPJD8xWFqnb7SnD5DN8eIPTu/t+ys=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=lWRJdSV6; arc=fail smtp.client-ip=40.107.94.73
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Rg95kHx2iw8pkm1kRQGCzm8bL2JsO7PjlkhfnJTLSe7mFI7R16ZuYG/2qk/lC2i5jlGuVPmhh5SPEQtX9nCSayTuftAaDA1O1A1WffSdDgDhBzMvGPSfdKSshOg0zLGE2nswWS5KoAg44NYBoBWmACaPevms9r8OD1RktIbFOclmJfFBq9h7NGou7XsDMu2YEMCrvMtbw5Zf63iiX3xJnYooGa9m4zSyUMLDO9ILNhyTp7IXSaS+3qSmrcAXwexFYPysXfOuGobBRBHNQBRByAVtmx64Zlo5/egU5zVNkFVR7Otejkk8B+vju5cBOOnoqNX5RLWmDF5pmuem5cxLdQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=WcYZ4q3iFxMYaj/fehADMh/dE808FTjf/n4S340jvQI=;
 b=xpfzuWvaYNQSRvyGH+wkB0p5YtogSxf9Wd4JGvlDF73AnQarta9/61MoiJC8HoySBduF5OjvQGnnJyCtJb0EWRhhzoKqqbEKY99MIIqCy000Q7lv5gMWzSyT4sXN0r7sGJcSQ6XSrzY38Ntx7+UhULUyzMBTCwCprD7gomiRjqPhZQ/m8bCRlTaUbqxw/0dTsgZv/BKfLTNKuD9CwTSRRT9dmdDqeadZ+sOsvfOj4WF91Xj7RrUKXuTmD5KRIKr+wTogv37PFDDXBQLoFzPy8OxznynrPf05thESfYL8I/tmUv9tmQKm0tHDH5ZuoUFrkXxDLiwaobbtcvwarTWpmg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=WcYZ4q3iFxMYaj/fehADMh/dE808FTjf/n4S340jvQI=;
 b=lWRJdSV6g9WGv3nLG3pC9YalGlBUEAS7dob0lmT+cGvdlAXK9G9qFZodHteXiIQ/mtM3KiABZE3g+GOS26cut6KGocO5ZqoeADkgkkMIPI8mt812GK4lGFr2l4jBsihVdiwpkozxssOqBaEP2k03X05Pvqnj1VVXbLOLqJmrZps=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from DM6PR12MB4202.namprd12.prod.outlook.com (2603:10b6:5:219::22)
 by CH2PR12MB4117.namprd12.prod.outlook.com (2603:10b6:610:ae::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8207.16; Fri, 13 Dec
 2024 10:20:35 +0000
Received: from DM6PR12MB4202.namprd12.prod.outlook.com
 ([fe80::f943:600c:2558:af79]) by DM6PR12MB4202.namprd12.prod.outlook.com
 ([fe80::f943:600c:2558:af79%5]) with mapi id 15.20.8230.016; Fri, 13 Dec 2024
 10:20:35 +0000
Message-ID: <e46cd8f0-5e62-5e51-a901-384bdad689fe@amd.com>
Date: Fri, 13 Dec 2024 10:20:30 +0000
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.11.0
Subject: Re: [PATCH v7 28/28] sfc: support pio mapping based on cxl
Content-Language: en-US
To: Simon Horman <horms@kernel.org>, alejandro.lucero-palau@amd.com
Cc: linux-cxl@vger.kernel.org, netdev@vger.kernel.org,
 dan.j.williams@intel.com, martin.habets@xilinx.com, edward.cree@amd.com,
 davem@davemloft.net, kuba@kernel.org, pabeni@redhat.com,
 edumazet@google.com, dave.jiang@intel.com
References: <20241209185429.54054-1-alejandro.lucero-palau@amd.com>
 <20241209185429.54054-29-alejandro.lucero-palau@amd.com>
 <20241212212229.GD2110@kernel.org>
From: Alejandro Lucero Palau <alucerop@amd.com>
In-Reply-To: <20241212212229.GD2110@kernel.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: LO4P265CA0150.GBRP265.PROD.OUTLOOK.COM
 (2603:10a6:600:2c7::10) To DM6PR12MB4202.namprd12.prod.outlook.com
 (2603:10b6:5:219::22)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM6PR12MB4202:EE_|CH2PR12MB4117:EE_
X-MS-Office365-Filtering-Correlation-Id: 21e5a2d5-c689-4f7c-c8a8-08dd1b5fc85f
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|1800799024|7416014|376014;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?a2lpY0syTWpSYnBUME1xOEJZK3dGRUU1YjYrRHV3TzkrbGNmTzdBTEN0bGZK?=
 =?utf-8?B?ZERkSUF2bThLNVNkZ2xvcWtZOEdsK1JXNjFVWGpJYUdlODJQTUJYTDBBTDE4?=
 =?utf-8?B?djE1YUNOMXhNMUkxTUtPVlZmYVN1blVheG8yZzZOTFIyUGllVWxxelQwa2dD?=
 =?utf-8?B?ZU1UZHlEK3pBZVpscXBVWWljQnBJQVVjWWZRVERSRytWcE5PTC8wSWU1TnR3?=
 =?utf-8?B?cXFtSldseng4TnFFWGErOFcwUTdoYVhveFc3UWhMa01kU293cEwxMlRaWFZD?=
 =?utf-8?B?V3YzckMybkNGTm9qUTVLM2VCWnNFS2hUb3p3TUJ4cGUwcVNLYlM0ZVg3QmFP?=
 =?utf-8?B?aXFQcmY5SXl3OHhITnBreGF3Yit2R3lwTmJ0QUtBMkIxRU5xa21ONGVvam9u?=
 =?utf-8?B?QXg5V0pDYk1rOHREcmxqWEloR1FRQkZHYXJyYkRyK2ppdHh0Yy90U2kxdncx?=
 =?utf-8?B?SVpGak0rNVVKdk5xblc1OXNoOGJVWmJiSWtldlowWFJmNXVOVlowMlpPWlc5?=
 =?utf-8?B?Z1dJNVVULzkvQU5yK2t0OUJvV0RHaTdMb0ptSDR6bzNGakJEMHg0OWt5K0I4?=
 =?utf-8?B?NElwYkNVWmJBMlN6c1M3VlZOMENUZDk3U0VPUVdoaUpTSnlhN2lYYWcwTXlr?=
 =?utf-8?B?WG1ZRldRakMyQkFmcWoxQmh4Qmt2RG5TNVhVQ0ZwTFl5d3doM3dadU9kN25F?=
 =?utf-8?B?b05SRW9MRmVrRnorcmlySEJOU2hrUXg5WHNWZDFKQlVubTNNQ3B1amlyWlha?=
 =?utf-8?B?MlB2Sk42aktnRDhIWUltUzNjNnVPOFRtM21MdEJzRUZiQXpadmJhMnFMZlNE?=
 =?utf-8?B?Undndm9xWmFzUzZSQUhnRDRUWUgxUWhDQW1CMyt2TDBPQnJlM3hYTHNvSEdC?=
 =?utf-8?B?QjN6K21zYlhTMkFxNnBiZ1NPcFFQMTFKeFo5amhMVlBlNC9WdVJRaC9ieklV?=
 =?utf-8?B?QzZ4MUNVazhuOTlEZDhJZktXak9CcmRXaW5jeS82b090RHd4THo5b3luWmRv?=
 =?utf-8?B?aWxYb3dlWmVGR0dLS01UMnJRVjRNbnF0Y2RnUEQvdnF6ajFBZCtLNUl1bEQv?=
 =?utf-8?B?TEhGeXV6Z3dWQkVwRUhlb2JUb3BDTk8vQWZ3RnVTNXVTb1R1UzcwcWZKZnZF?=
 =?utf-8?B?K3QwaTdpbzZReUdWMVlkZWNadDJMME9wS1dqaHlyblFOVjhyeTU4RlZQUi9i?=
 =?utf-8?B?THN0ZmcwRm5ocHZDekRYUHhvMVBHMTU0WXo3T2FEbHQxNGowV2U1YVpZTHRI?=
 =?utf-8?B?NnZybzlNbFkyQ2pmRHpHWGVzUDJCYlFuN2ZJNnhUM25hZDJ4bW1wMUpQVm1j?=
 =?utf-8?B?YzBxcmpuM3ByNWFzYjloSmdDQ1dvSDFNWGFWWjNtdkZ1aGZTS0pjdXBsMnda?=
 =?utf-8?B?U1daOFp5UGgxK2Z0dWY2dXdlVWg2WG5UakVUSlNFNHBiQWlQdzJWaE03USt4?=
 =?utf-8?B?Tk1VejVBWUJuK3hOeWNMeWloNm1pNHNLbnQwVG05TGRXemw1OEI0RE5Ga0xP?=
 =?utf-8?B?LzBGYm1EcUpBS0FPLzFQbmZZWDdhNWwrTkl4blR2TDFHM0M5azNQUGRpUENB?=
 =?utf-8?B?Y3YxNUNrMTdaeEkrV1BJQ25FeHowdS9xNjh6a0lXRGZyV0V0T3NNdlVnTzJa?=
 =?utf-8?B?dFhlYWt4TWs4TlVzYmd6amRrbmxQOUU4cWdiT0g5d3hmeGQrOVlNbm1tcFNP?=
 =?utf-8?B?Nkl1bFN3ZDM1WTdRNHFtS0MxQlU3UWFQRlBFMjI5R1Vsb2NqbThlTW1ucEdK?=
 =?utf-8?B?cGhLTmI5SXhCTHZsMXFqM3l3VWJqUnpKMGtobGpVSXRZV2RYZ1VZUzk5RytY?=
 =?utf-8?B?UTRKcGxHOVNZKzVYdDA2Zz09?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM6PR12MB4202.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(7416014)(376014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?SnVRSmwwOTJ2NXArRUVKTlF2Q2lzYTZtRnFjbkJ1cHlCTFIydjdVaU5JcDFi?=
 =?utf-8?B?aDFGMGtpRFVVMkVnZlNiV0NoWldZSU5GWU9tajZrVi8ycThDYW1vOTREYTBB?=
 =?utf-8?B?ZW1LdXR3Z0FDYVBGMit3S29QSmxnVWpTWjlOU0RBVDRBb2FlWDkyUEM1S0E5?=
 =?utf-8?B?Q1FTdG4yTno3NXJIbk4weForWWJsbjFXSzN5K2JFNTFyOE11YWFkeFRYQm82?=
 =?utf-8?B?dmdzT2lEWWZhN1NONnl3TWlseSsyZFZPL3RqZXJ6Rkg2RWtkRFNnYlhLUkhR?=
 =?utf-8?B?QVl1Sno2RkFiWVRxWEtZVkZYcXZ1aDZoNGhXR0tCWit4V0taV3hYWE9xWUxn?=
 =?utf-8?B?SllsdWE2VCtBTFcwZXorbzRtTjA3NVNkYUpxN2tOOFBZekZBR0tTeDJEVTVO?=
 =?utf-8?B?UDRvU09NQll3Tm9vVUFlNXE2dVE4d2RicUJxaXNTeDhHaURjbWI3RHJhcWFN?=
 =?utf-8?B?clg0cmJ4TjhsY1U5WEFBWEdVVS9yWkp2cTJ3RkZ3aVBEOUtFSDI5MVNaYng1?=
 =?utf-8?B?OTQ1NkpCNXpwWm5aTXU3cGI4QUhUUElMZllrTENuQzlqNjJsYk94WXdKbG1F?=
 =?utf-8?B?N0gwaHg0L05yeWIyNFFyWEdpVnlBTDZrSkxPN0hwMk4vcFFXMUhNVlErVWYz?=
 =?utf-8?B?d3d3NFVheHAycHYvem4wWExMNlJnd0g2cDFlalRCV2NBbS9RNG5Ic1VwUHho?=
 =?utf-8?B?VXdqY3hWMm1tT05lR2h1L1BrSE5QM2hENUJ3Zmw3dUc0eXU3QUFER2FtbGh3?=
 =?utf-8?B?dFh2SjRjUjlQWkNDbkRvUzhvaTdFVjhEb1ZaQUV4eWhGQWVRemthSXdsci9i?=
 =?utf-8?B?OTJsOHdmZlRsZ1BwQjc0U3Jjc210RDd4RGpQQ2ZpVjN1aTk2YmNlYkdkN1VM?=
 =?utf-8?B?czZpQU4yVVRJUEhEVnZESHZmZHp4bkxTOFJxcFFGanM1VWxkWTkvTno3RDVy?=
 =?utf-8?B?blUrdVlLTmsvY2xIWUpTNjc4VFczcGVtSGZTZjRpN0YraVJwcTU0VlhwOVE3?=
 =?utf-8?B?THJxZWRYMCtweU1kaDhwKzVUaG1sSTBSSDl0UVdHeUpiRnA0clhiaVpybFB4?=
 =?utf-8?B?bVhOL3B4ZDQxSVR5REhiUlhoWk9hRHZ6Ui9UbE5TaUdsMWV6TEkzQ2g2aGNE?=
 =?utf-8?B?eWdFUlRSNkU2OTd2V2tJZGRzb0IzelRiWExyMTRjUk5adVdua1h4dXp0QnRX?=
 =?utf-8?B?U1JZeEtIQXpoVmtQRW84bnlrN1dvRzFBeHRmWTNkTFprTGEvZVVkUU84dTdn?=
 =?utf-8?B?YjB1MVZobjY0ZkpqdFRHMDhkdWNNRkFFRVZGSlh1cFlscWxXK2dCU09Dd2VG?=
 =?utf-8?B?V0tJaWlCcGVPTzIwR3VLMWlrUWQwTm0yRXU1NURDRG9kdGllOUoyTjgvSGRp?=
 =?utf-8?B?ZU52TkJtUlNkOE0yejVzRThQOVBJcXRLRC94SzUyZWxaMjcrUUdQdlhyRnBi?=
 =?utf-8?B?bnpwbi9rdDRybTVqRkFrMEh3dW8xMC90bHpTZnZrTVNKb1Z0anc5Zi9kWGNy?=
 =?utf-8?B?VFo1VnJiL2E4UVFpR2s0TTk5dDRzMzZYZFVyMkxQcHlpQmhQcCtrck5KUnlj?=
 =?utf-8?B?NTBGdkQ3UVQzc3d1WU1iV25PazFLdDY4SEdMSjc0cnBJYmttK1B1dldlWVg1?=
 =?utf-8?B?SjRJbVVOMDFvUjY2bHZSa1FCdzcrRVBpMU96bXJOOXI2cGgwWDZLUGVDdmRH?=
 =?utf-8?B?Z1oxSzlwcWhzaUp4U2NZcVViaUJxazVqYWpmRXdzL0w3RUJrUjVtY0o0a1ZS?=
 =?utf-8?B?b1Z3b1BCajFvbHpkVzNEaCtJMUlzSklpR0gwbVFlZGRjbXNQUWJFZGYvbng2?=
 =?utf-8?B?dzJBUEVXd1lFU0g3TjNzcEJxK3A1YVVud1FHSVIyYWd0VW9JOWFsSnFGUUhK?=
 =?utf-8?B?L0JBczlLRWk3NjlVTWpJcDFvOUIxeVI4WWxmbUFSQjg1UlVIcXFKNFhtNVVt?=
 =?utf-8?B?bzBsYXZzTU9IRVpCSHlnN09VRkpBa05MUTlWeUFtMjF5U0tadTRHclpmdkZm?=
 =?utf-8?B?dVpqRk9STHFMNHZMdmE0aFY0WDVMSFVnbjBPRHAxenFzL0pzQU14eWlDUzlo?=
 =?utf-8?B?amxYMWJnMEZxZTR6ZjBWREtnSFNWQmQzZFdyK2pyUmxVYWxJZHNsZ2M4Z1Nu?=
 =?utf-8?Q?OHOX0txMYS4hih+mm7C+Scyke?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 21e5a2d5-c689-4f7c-c8a8-08dd1b5fc85f
X-MS-Exchange-CrossTenant-AuthSource: DM6PR12MB4202.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 13 Dec 2024 10:20:35.6562
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: qNKFMGDyELbp0ltu9Ehm5FDASzeGchr7htG6mekRxfSwNTnO5ykbtUT0wMZloslbplebkt3LIKQl5QUAfX/jtw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH2PR12MB4117


On 12/12/24 21:22, Simon Horman wrote:
> On Mon, Dec 09, 2024 at 06:54:29PM +0000, alejandro.lucero-palau@amd.com wrote:
>> From: Alejandro Lucero <alucerop@amd.com>
>>
>> With a device supporting CXL and successfully initialised, use the cxl
>> region to map the memory range and use this mapping for PIO buffers.
>>
>> Signed-off-by: Alejandro Lucero <alucerop@amd.com>
>> ---
>>   drivers/net/ethernet/sfc/ef10.c       | 48 +++++++++++++++++++++++----
>>   drivers/net/ethernet/sfc/efx_cxl.c    | 19 ++++++++++-
>>   drivers/net/ethernet/sfc/net_driver.h |  2 ++
>>   drivers/net/ethernet/sfc/nic.h        |  3 ++
>>   4 files changed, 65 insertions(+), 7 deletions(-)
>>
>> diff --git a/drivers/net/ethernet/sfc/ef10.c b/drivers/net/ethernet/sfc/ef10.c
>> index 452009ed7a43..4587ca884c03 100644
>> --- a/drivers/net/ethernet/sfc/ef10.c
>> +++ b/drivers/net/ethernet/sfc/ef10.c
>> @@ -24,6 +24,7 @@
>>   #include <linux/wait.h>
>>   #include <linux/workqueue.h>
>>   #include <net/udp_tunnel.h>
>> +#include "efx_cxl.h"
>>   
>>   /* Hardware control for EF10 architecture including 'Huntington'. */
>>   
>> @@ -177,6 +178,12 @@ static int efx_ef10_init_datapath_caps(struct efx_nic *efx)
>>   			  efx->num_mac_stats);
>>   	}
> Hi Alejandro,
>
> Earlier in efx_ef10_init_datapath_caps, outbuf is declared using:
>
> 	MCDI_DECLARE_BUF(outbuf, MC_CMD_GET_CAPABILITIES_V4_OUT_LEN);
>
> This will result in the following declaration:
>
> 	efx_dword_t _name[DIV_ROUND_UP(MC_CMD_GET_CAPABILITIES_V4_OUT_LEN, 4)]
>
> Where MC_CMD_GET_CAPABILITIES_V4_OUT_LEN is defined as 78.
> So outbuf will be an array with DIV_ROUND_UP(78, 4) == 20 elements.
>
>>   
>> +	if (outlen < MC_CMD_GET_CAPABILITIES_V7_OUT_LEN)
>> +		nic_data->datapath_caps3 = 0;
>> +	else
>> +		nic_data->datapath_caps3 = MCDI_DWORD(outbuf,
>> +						      GET_CAPABILITIES_V7_OUT_FLAGS3);
>> +
>>   	return 0;
>>   }
>>   
> MC_CMD_GET_CAPABILITIES_V7_OUT_FLAGS3_OFST is defined as 148.
> And the above will result in an access to element 148 / 4 == 37 of
> outbuf. A buffer overflow.


Hi Simon,


This is, obviously, quite serious, although being the first and only 
flag in that MCDI extension explains why has gone hidden and harmless 
(as it is a read).


I'll definitely fix it.


Thanks!


>
> Flagged by gcc-14 W=1 allmodconfig builds as:
>
> In file included from drivers/net/ethernet/sfc/net_driver.h:33,
>                   from drivers/net/ethernet/sfc/ef10.c:7:
> drivers/net/ethernet/sfc/ef10.c: In function 'efx_ef10_init_datapath_caps':
> drivers/net/ethernet/sfc/bitfield.h:167:35: warning: array subscript 37 is above array bounds of 'efx_dword_t[20]' {aka 'union efx_dword[20]'} [-Warray-bounds=]
>    167 |         (EFX_EXTRACT32((dword).u32[0], 0, 31, low, high) &      \
> drivers/net/ethernet/sfc/bitfield.h:129:11: note: in definition of macro 'EFX_EXTRACT_NATIVE'
>    129 |          (native_element) << ((min) - (low)))
>        |           ^~~~~~~~~~~~~~
> ./include/linux/byteorder/generic.h:89:21: note: in expansion of macro '__le32_to_cpu'
>     89 | #define le32_to_cpu __le32_to_cpu
>        |                     ^~~~~~~~~~~~~
> drivers/net/ethernet/sfc/bitfield.h:167:10: note: in expansion of macro 'EFX_EXTRACT32'
>    167 |         (EFX_EXTRACT32((dword).u32[0], 0, 31, low, high) &      \
>        |          ^~~~~~~~~~~~~
> drivers/net/ethernet/sfc/bitfield.h:187:9: note: in expansion of macro 'EFX_EXTRACT_DWORD'
>    187 |         EFX_EXTRACT_DWORD(dword, EFX_LOW_BIT(field),            \
>        |         ^~~~~~~~~~~~~~~~~
> drivers/net/ethernet/sfc/mcdi.h:257:9: note: in expansion of macro 'EFX_DWORD_FIELD'
>    257 |         EFX_DWORD_FIELD(*_MCDI_DWORD(_buf, _field), EFX_DWORD_0)
>        |         ^~~~~~~~~~~~~~~
> drivers/net/ethernet/sfc/ef10.c:184:44: note: in expansion of macro 'MCDI_DWORD'
>    184 |                 nic_data->datapath_caps3 = MCDI_DWORD(outbuf,
>        |                                            ^~~~~~~~~~
> In file included from drivers/net/ethernet/sfc/ef10.c:12:
> drivers/net/ethernet/sfc/ef10.c:110:26: note: while referencing 'outbuf'
>    110 |         MCDI_DECLARE_BUF(outbuf, MC_CMD_GET_CAPABILITIES_V4_OUT_LEN);
>        |                          ^~~~~~
> drivers/net/ethernet/sfc/mcdi.h:187:21: note: in definition of macro '_MCDI_DECLARE_BUF'
>    187 |         efx_dword_t _name[DIV_ROUND_UP(_len, 4)]
>        |                     ^~~~~
> drivers/net/ethernet/sfc/ef10.c:110:9: note: in expansion of macro 'MCDI_DECLARE_BUF'
>    110 |         MCDI_DECLARE_BUF(outbuf, MC_CMD_GET_CAPABILITIES_V4_OUT_LEN);
>        |         ^~~~~~~~~~~~~~~~
>
> ...
>

