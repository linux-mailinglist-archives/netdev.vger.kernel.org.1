Return-Path: <netdev+bounces-158151-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id DE323A10986
	for <lists+netdev@lfdr.de>; Tue, 14 Jan 2025 15:35:35 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id DC15B18857E9
	for <lists+netdev@lfdr.de>; Tue, 14 Jan 2025 14:35:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 266B513A879;
	Tue, 14 Jan 2025 14:35:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="U8MvawYY"
X-Original-To: netdev@vger.kernel.org
Received: from NAM10-MW2-obe.outbound.protection.outlook.com (mail-mw2nam10on2040.outbound.protection.outlook.com [40.107.94.40])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 00BA4146D6E;
	Tue, 14 Jan 2025 14:35:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.94.40
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736865332; cv=fail; b=TRYaBImHuwGCLpkM7veqLXz337S/i3NebTsz2cYL6GKYX7CLZShxJhOllSGE/Feejqt7dbUnPNTNC1i34ZPuzPnsZ7nCyS4c5IGsm+4QxrbsablbuHRe4qvVthEEDmkfTcyyYAW76rOBVgT4h1tbm5Yqa3SeSe/p1qqxjZAfO0w=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736865332; c=relaxed/simple;
	bh=bJwkNClSbaAek6Azu6ane3lcuo3WrTNBvz4DCZua/ys=;
	h=Message-ID:Date:Subject:From:To:References:In-Reply-To:
	 Content-Type:MIME-Version; b=g7Xq5P1HDG0W1sIH7O/NckvLHHqIzkj7m1VhWxLPaSGkWUub6cyMJyx0RjaKtsnvS0cfJPvu62vPpoCSwD2P+NTq3WZtfrzFErHUkBY8+BawDRYzM8nWrLIY4OgTEeXc9qZU7ntsZM1+1ZVCgACb2J+cvD5DSJmFCg68zUNaQaI=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=U8MvawYY; arc=fail smtp.client-ip=40.107.94.40
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=dThSpWwtuQ7EnNuGTSphEl2S/Q4AJlgr+Y+eQMZtEDyCHC96taaO90Ya2hMWnCTqc/1p+lQzAyS5NcsfTTgEPksFFx3wBoDphomg0HzgkwibisEd2JlUXYpmHMl6BaTxMCgiOFtvvpasquV97bTrTfgJp9W1qMXsnfzAKk+gCl5cUOtHyPOdTU/iCBtm0gVf7hv7YD8JmzmHRl2/9lEFsppFgnV4qe1Rr83xmaY3i0RS/dpSNNA+EB+itiqNQJ9d5KsO/lA5WAq6oLiLLdYOylkavo5kjP4QlxX5xXRnDwzOhLJLFYofC/ApoiKhLIxXXaLsGMZFEqnDL9zlnPbAqg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=rYCYmAwCswt8SNa6ZEGA3JxYOMKbf80lxaME9ug/HS8=;
 b=aoeSYKB7Mhhh0hFgQ6ad8q5TDpTN6mXkTzmyGE46F5AIM6di77IA6bgJSvmuEIsiqBRML5Luih7dk/m2U1UxK2Fc+MEQ02UAapxEZPoCykU1c7BE2Ud0nTvptI+IHOf/vO6vJGiBErT088usvycmC4T7tw3TttI3bNdLg5l7AR+4WYlj8TMzjBSYd4ZoIdZ86HlTAOeMiKNBi6puNWKpbRZ+raeguCRRwuIKXeylRVegKz/UirR+b/P86a3PqDO+lFHe4lh8wYz1OdfMGAZciHqDQN6jvbJf7gBZ4fKTlvwWYMt4pA0fu7MhVw40HJaM0NeosDpY+nHKviZ/8R7lDg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=rYCYmAwCswt8SNa6ZEGA3JxYOMKbf80lxaME9ug/HS8=;
 b=U8MvawYYvkLe6R8UP7Bb8UJN0bzDwiDBg8hcZlNMHjzmaUGROctxx77JgYvkozVxBiEapMuUIcPdDIH/KgMa3iF3Zsm3p56B4/0hkpXCwLvwOz/4Yp4VS3sRNqp0nR1FhDEpzYVDA+/0SdYyO/t/rss7/OWbvuU1DwqBbZk8Akg=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from DM6PR12MB4202.namprd12.prod.outlook.com (2603:10b6:5:219::22)
 by CH3PR12MB8356.namprd12.prod.outlook.com (2603:10b6:610:130::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8335.18; Tue, 14 Jan
 2025 14:35:27 +0000
Received: from DM6PR12MB4202.namprd12.prod.outlook.com
 ([fe80::f943:600c:2558:af79]) by DM6PR12MB4202.namprd12.prod.outlook.com
 ([fe80::f943:600c:2558:af79%7]) with mapi id 15.20.8335.017; Tue, 14 Jan 2025
 14:35:27 +0000
Message-ID: <92e3b256-b660-5074-f3aa-c8ab158fcb8b@amd.com>
Date: Tue, 14 Jan 2025 14:35:21 +0000
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.11.0
Subject: Re: [PATCH v8 01/27] cxl: add type2 device basic support
Content-Language: en-US
From: Alejandro Lucero Palau <alucerop@amd.com>
To: Dan Williams <dan.j.williams@intel.com>, alejandro.lucero-palau@amd.com,
 linux-cxl@vger.kernel.org, netdev@vger.kernel.org, martin.habets@xilinx.com,
 edward.cree@amd.com, davem@davemloft.net, kuba@kernel.org,
 pabeni@redhat.com, edumazet@google.com, dave.jiang@intel.com
References: <20241216161042.42108-1-alejandro.lucero-palau@amd.com>
 <20241216161042.42108-2-alejandro.lucero-palau@amd.com>
 <677dbbd46e630_2aff42944@dwillia2-xfh.jf.intel.com.notmuch>
 <677dd5ea832e6_f58f29444@dwillia2-xfh.jf.intel.com.notmuch>
 <c3812ef0-dd17-a6f5-432a-93d98aff70b7@amd.com>
In-Reply-To: <c3812ef0-dd17-a6f5-432a-93d98aff70b7@amd.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: PR1P264CA0091.FRAP264.PROD.OUTLOOK.COM
 (2603:10a6:102:345::10) To DM6PR12MB4202.namprd12.prod.outlook.com
 (2603:10b6:5:219::22)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM6PR12MB4202:EE_|CH3PR12MB8356:EE_
X-MS-Office365-Filtering-Correlation-Id: 6c546075-cefd-4557-6587-08dd34a8b04c
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|366016|1800799024|376014|7053199007|921020;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?QnFZbUhSYVY0OWQ2RTZrWDM5Umg5OTNRUlZ2akVzNTYwOWRQY1Vad2ZMa0dF?=
 =?utf-8?B?M3IwTm40R0RPRldVeDB5d0ZnWkpaNUp2aTZ2dWh5bFNGcjROcktacnpuYjA4?=
 =?utf-8?B?SWM3d25UcE1RRDd4eFRjSUJvenRuakZ4SmVqMm9zejlOejRVQldWVEh2SjR0?=
 =?utf-8?B?bm8xQ25WeVdZZW81cUw5MDZhWW9uWkNNMWZjQmxQZDNLM044N21oZ1hWdkZG?=
 =?utf-8?B?OFV4eHo4cGZqKzlwWm1XeElwTlpMbFNCOGRMc2NGMmt6cDJ0WDhXakFNZWFr?=
 =?utf-8?B?bXF1ZVRPbGI2akIvYmZBbmZrUEJQK1kwNTdSZUJIZjk5aGROeXFzR0w5dzBm?=
 =?utf-8?B?S2tNK3NvMm9HbXFkTVluRXlXcGM3dGJ0QkNMRXZUQVhQTWJ2ZUFmZWdpSk9s?=
 =?utf-8?B?bFlVMVpvV0dETEsvZ2pCSlJtZDhDWjgyYW01MFNvZFZIdjMrclpOWGlqRkZi?=
 =?utf-8?B?dUY3TWFPbTd1RlZ3Um4yTXpHZmFsOXk3ZnVCbmR2UVJ2M0pLUzg1aUZFUHkx?=
 =?utf-8?B?TW1OQkx3ODV0aWwyWUw3M2Vjbi92c3dUU1ZRcCtOa01FS2l4Zy9GQ0V0UXp2?=
 =?utf-8?B?VW5VMjJwaU5za00vQXNuc3hDb1FteVlUcE5XeEUzaGJHZkd6YVg5S0dZZlJo?=
 =?utf-8?B?V3hveGs3Znk1SmJRbndVRjBpTFBlSVlrZHlyTVpPWkNsT3JVRnBnRDJjTzUy?=
 =?utf-8?B?QWZSWmtjMU91cE5MM0tBd0NXTlA1VkpaN0szZVJqUGk2cW1laWpyQkxUR0hw?=
 =?utf-8?B?bFlaR25KZDM2ay9yUUlEblFzdHhLekVJUXZ1Zm84NGNzdmxtd2NQMmRuUUhY?=
 =?utf-8?B?QzlxVGE1Z2RWbVhMWTRXY0tCUkFvandHRUEvb3B5WWUreFRranVIR2xxZFFS?=
 =?utf-8?B?Zks4MU9DNEQzNjBLQjBrRlVlYjVrNC9tOFVnSktCWWJibnczVlFyS0FpUExD?=
 =?utf-8?B?QmxzUlRjV3daS3JMdlllQUViWGd2SUVqdzgyRDA0SThJS0xacXFncGRMQmsr?=
 =?utf-8?B?VHYvdXBBbGUyeldLVThPYUhzaEhlOFdidFI5QllUcWVHcUcxOHlTa3lvZUh5?=
 =?utf-8?B?WFFraDJHWFo1b2pndS9zdjRqUk1vdjQ1MFFnT1M3dUlsK2wzMCtKK2tVc2hT?=
 =?utf-8?B?ZkR2UDJ3RWY5WWRMMjZNYzhJNEh1Y3pXcVFTK3dYNjNqWnlMa3crbVpZNnBE?=
 =?utf-8?B?UzBwWEtMWlZYZEdHaE00QzUwd0NieGJUYmhOejJQTlFJdTA5VFJrdWd3b29O?=
 =?utf-8?B?c2Z2bnc0Q2dTWW90T0o5UCtEcDBWQWtOQzFXRS9MN1BPOWhBUENrd1BpTmFR?=
 =?utf-8?B?OWVlUUxmTTVhSkFKc0VmWENraXdmajBNcW5ZcEZ2RFdDdkVzb0pOL1IvdlBV?=
 =?utf-8?B?QUhuV3pPT0kwV05zNjllNjgzQ3E0VkprK3FRL0p4L2VDMUJldTdNYUlGK1Nu?=
 =?utf-8?B?WWtGb1M1ZVhYdUhkT3BKL29lcDFRcVFwSXU1a2p5eG5Idnk5QU93bzJrOUVi?=
 =?utf-8?B?cmhvVGFaUEhDVGh3SkNvSzJRem1mNTZzYlB0c3ZCVzVacUE3ZlQvWlhsUHhX?=
 =?utf-8?B?OHFQL2Vxbmt0dWNCSkZHejZZaTJ6eHlNNEtOeXdIQjBodHM5NUtQSW91VG9D?=
 =?utf-8?B?Q0tjTmpPblFKaWxpZ0ZvSVQwWDAzYnVHS1VKaGRmWWM0Qnd4MjVwYW95SzBp?=
 =?utf-8?B?RnpsaEdRN3JmbFltVktYYmpTSVp0TGtRQi82WFp3UXdVQ2ZHUTY4ZVpaT3U5?=
 =?utf-8?B?NWdxVXJFa28xcERRRFJGNTErVitLMThpSjdvT0lFMmtsbmlrK1o4UEIzcTZo?=
 =?utf-8?B?VFJCcTlRTVRQY1lGQW92K1hteUFvQmlWZmhDZzNqKzlYMHNWTzVsdnRqalpV?=
 =?utf-8?B?YUM0Qm5XbGxUVkpCUERNL09oRkhGeTVNLytCVDdpSWZPb3htRlNoOUl3VEpM?=
 =?utf-8?Q?UUqYgmY63hrUWeyfF2Rbbt1n69yoWCzV?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM6PR12MB4202.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(376014)(7053199007)(921020);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?ZFVRT1FPNTA4RVJQays0VVVnU2FFZDl4UHZnd2NMOFkrYnFvVklQeHE1QitJ?=
 =?utf-8?B?YUNPbVNrdzM3NFk0OG5oMHNGNFY3eHpGTVJGcmN6WlNDcEE5aENOelRGTEM5?=
 =?utf-8?B?QkVmZHV5SUk2NDJsaFpNcHNmckRzTS92bmdSQlFSZnliSjJkOHJoalpJcVVn?=
 =?utf-8?B?WnhsYVFYbUpCL29vcEdNaWd2Wm9SNWVRdTl0WC82d1V2OVN6WVZwUHpLSmZP?=
 =?utf-8?B?YWdPWENnVlVPcm1Zdm4xRXZnMzY1Ymloa3BGYi9BQ1d4MHZXYlpGTTlRZlR3?=
 =?utf-8?B?OUtwa25MaStWbzVOVi92R2M5QTJoTnh3T2dVVytMMFRvYk50N25PSC8ycHdY?=
 =?utf-8?B?ME1IQmh4c0dYK29GQmRxUmVRbTNDZG9jVXQ4TTNuZ0hUalBwQk4wZFFTSmV0?=
 =?utf-8?B?SGhvVzcrVTdYQW41VWV4elgxWDVWdXdHbkxvRjVKMnhSbkFGQmhGb1FoRkpJ?=
 =?utf-8?B?VGd2REVjNUhFMXIwdHE5R0R6SWlDT3Z3cVB4aitPaHNwTDJOdGRXL0l1bU9m?=
 =?utf-8?B?UmQzSG85QW9TWVFxNmJscDY4VzFqZ0VDYXNBVktGeTUrYTRKdFQyUGpzYjV2?=
 =?utf-8?B?MWowR2tvTStmemRxSGFwNkUzSXRxYUVqUHRBaFJlazVOQlJrMDR1Z2ZLTmx0?=
 =?utf-8?B?UExiTFdPaDdNbGxUaGFLMUhXY1BsNVRMZ0psNEhpZ0Fhc1J3N21saklDSVlV?=
 =?utf-8?B?eHFFSW5zTjJjT2lFUGpmVis5L1N4QXN3RFhIRHNzRS9hZmdSYWJVNzk3ZDRV?=
 =?utf-8?B?bmc4NjAxZGpoRW1lanB0YmgzS0V3Tk8vUzRHem51NWVNVU1uejRCNFdTa1cr?=
 =?utf-8?B?NDlYbXFQY1ZjTmo0cVBHNGxJY0RHQ1EwblhPd0RPcVVBOElBQnVIeG9KZVRX?=
 =?utf-8?B?aFJRZ0JTcGtYMDRENGwwc0tSb0xNbTREQ2lZOHNlUGV1SS9VL3J0ajBEY1BY?=
 =?utf-8?B?QkVzNDlBWUFLZmJoaUVWYzJIMnJVZDVrRksyRlpRWmJ1UTcyZFZBZDNXcVNX?=
 =?utf-8?B?VVV6eW1jUm9kOUl5LzBmM1QwWGRpdnFnY1dxMDQ4a2ZZUk9LSU9XMGxJM0tV?=
 =?utf-8?B?YXRydFdod0s5OEg2WWR1a2dPNExXYXZiZG1aM2lhRmE2WkhWT0NDM1FsNHly?=
 =?utf-8?B?aVZ0T1hPLzA3T2VQZUxqVlRVVmZJRmdWeXZqZkkwdGMxTk5ZNlRsb2hQdGtP?=
 =?utf-8?B?QTJHVEUyME9Fa1NWanZMNEgxdmhmZ2greGdIOFQ5VzByc3JIUE50dnhZUC9G?=
 =?utf-8?B?cTNUVUk5M1htRW9MTlFnV2lrSTJzK3U0cTY4dndIdzl1dlNYTGorRGVmSzVp?=
 =?utf-8?B?QWhjK1dHZmJScm9TdGZuVVduN2NhL3dvaVdEWEpaZTJSREpXaGUvNUJlVWND?=
 =?utf-8?B?VWxvWkpRbFlLL2crblg0b0R6NVdwMW9MMVc3Yk5LS2MvSjFjREdyZC9IRHlO?=
 =?utf-8?B?NmRWZXB0dTFrNWlIc2VYTHZNSTZ1czNrVUVVL2liZ2tPeStUZTY3YkUwbVIw?=
 =?utf-8?B?aE95RWR2Y1RzUmpaVjhXUUczV0pTKzRTUHM3d0szQXFBR0xRdUdwOEpERUVD?=
 =?utf-8?B?RkpucWdLbWlycjJzREFxcUhST1Bha3NzMG5jaXBZamZFMmFueG1pM0k0QzZp?=
 =?utf-8?B?eVhkUktWT1RxY1dSejF0Mk5zK084eTRyWk9WWm5LaWpwdXM0OVpyOUI2VjM5?=
 =?utf-8?B?dmdIQmJDMzh3NVhUSTBlUWhJUUkzVHkvOWlTZUluZFNUWlZXaWVMcDc1dDN0?=
 =?utf-8?B?MGE4ZzRGVFM3bTU4ZXZvcDZuZUVtS0hyWFowZ05tRVd5a0tUbmVQZ1F4eVB1?=
 =?utf-8?B?UWZra29udTFUaDB2U0F6UTNqaCtvT3Q1dkRhb1I5U1U5VEdBd1hNUDRqSENz?=
 =?utf-8?B?THRMWmluNlU3M0JhYkVMYUZ3UmhxMFdxODRZVTFmUHQ2a0hPQS9CZkEyUEdj?=
 =?utf-8?B?d2NYSW9wdVNUNDdRQ09wOHNUQkw0enRybFEvSThWdHJxeEhNVks5b3k0a2lS?=
 =?utf-8?B?V1F4VVlGR28xbmkwVnNxLzBEd1UrNzdmRGFvbkxWd2hqSlR3WUlMcEh6RjFJ?=
 =?utf-8?B?cmZtaUJIaEVOYlN4QysxVzBEL3ZRd0xXREVaY1R4eGg5QndMNWNMOXdsUWo0?=
 =?utf-8?Q?GmWIAUor7Aqn0XmLr9qYWbwiq?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 6c546075-cefd-4557-6587-08dd34a8b04c
X-MS-Exchange-CrossTenant-AuthSource: DM6PR12MB4202.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 14 Jan 2025 14:35:27.5573
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 4XV6L9NGWkGoz5oUezYJWfMO5Sj8OpgqtP/8Jaob+qG61z/nUU4joBs87P0d7j+agH+CmtR0BlcL+S3Kuno5jA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH3PR12MB8356


On 1/8/25 14:32, Alejandro Lucero Palau wrote:
>
> On 1/8/25 01:33, Dan Williams wrote:
>> Dan Williams wrote:
>>> alejandro.lucero-palau@ wrote:
>>>> From: Alejandro Lucero <alucerop@amd.com>
>>>>
>>>> Differentiate CXL memory expanders (type 3) from CXL device 
>>>> accelerators
>>>> (type 2) with a new function for initializing cxl_dev_state.
>>>>
>>>> Create accessors to cxl_dev_state to be used by accel drivers.
>>>>
>>>> Based on previous work by Dan Williams [1]
>>>>
>>>> Link: [1] 
>>>> https://lore.kernel.org/linux-cxl/168592160379.1948938.12863272903570476312.stgit@dwillia2-xfh.jf.intel.com/
>>>> Signed-off-by: Alejandro Lucero <alucerop@amd.com>
>>>> Co-developed-by: Dan Williams <dan.j.williams@intel.com>
>>>> Reviewed-by: Dave Jiang <dave.jiang@intel.com>
>>>> Reviewed-by: Fan Ni <fan.ni@samsung.com>
>>> This patch causes
>> Whoops, forgot to complete this thought. Someting in this series causes:
>>
>> depmod: ERROR: Cycle detected: ecdh_generic
>> depmod: ERROR: Cycle detected: tpm
>> depmod: ERROR: Cycle detected: cxl_mock -> cxl_core -> cxl_mock
>> depmod: ERROR: Cycle detected: encrypted_keys
>> depmod: ERROR: Found 2 modules in dependency cycles!
>>
>> I think the non CXL ones are false likely triggered by the CXL causing
>> depmod to exit early.
>>
>> Given cxl-test is unfamiliar territory to many submitters I always offer
>> to fix up the breakage. I came up with the below incremental patch to
>> fold in that also addresses my other feedback.
>>
>> Now the depmod error is something Alison saw too, and while I can also
>> see it on patch1 if I do:
>>
>> - apply whole series
>> - build => see the error
>> - rollback patch1
>> - build => see the error
>>
>> ...a subsequent build the error goes away, so I think that transient
>> behavior is a quirk of how cxl-test is built, but some later patch in
>> that series makes the failure permanent.
>>
>> In any event I figured that out after creating the below fixup and
>> realizing that it does not fix the cxl-test build issue:
>
>
> Ok. but it is a good way of showing what you had in your mind about 
> the suggested changes.
>
> I'll use it for v10.
>
> Thanks
>

Hi Dan,


There's a problem with this approach and it is the need of the driver 
having access to internal cxl structs like cxl_dev_state.

Your patch does not cover it but for an accel driver that struct needs 
to be allocated before using the new cxl_dev_state_init.

I think we reached an agreement in initial discussions about avoiding 
this need through an API for accel drivers indirectly doing whatever is 
needed regarding internal CXL structs. Initially it was stated this 
being necessary for avoiding drivers doing wrong things but Jonathan 
pointed out the main concern being changing those internal structs in 
the future could benefit from this approach. Whatever the reason, that 
was the assumption.


I could add a function for accel drivers doing the allocation as with 
current v9 code, and then using your changes for having common code.


Also, I completely agree with merging the serial and dvsec 
initializations through arguments to cxl_dev_state_init, but we need the 
cxl_set_resource function for accel drivers. The current code for adding 
resources with memdev is relying on mbox commands, and although we could 
change that code for supporting accel drivers without an mbox, I would 
say the function/code added is simple enough for not requiring that 
effort. Note my goal is for an accel device without an mbox, but we will 
see devices with one in the future, so I bet for leaving any change 
there to that moment.

Let me know what you think about these two things. I would like to send 
v10 this week.


Thank you


>
>>
>> -- 8< --
>> diff --git a/drivers/cxl/core/mbox.c b/drivers/cxl/core/mbox.c
>> index 548564c770c0..584766d34b05 100644
>> --- a/drivers/cxl/core/mbox.c
>> +++ b/drivers/cxl/core/mbox.c
>> @@ -1435,7 +1435,7 @@ int cxl_mailbox_init(struct cxl_mailbox 
>> *cxl_mbox, struct device *host)
>>   }
>>   EXPORT_SYMBOL_NS_GPL(cxl_mailbox_init, "CXL");
>>   -struct cxl_memdev_state *cxl_memdev_state_create(struct device *dev)
>> +struct cxl_memdev_state *cxl_memdev_state_create(struct device *dev, 
>> u64 serial, u16 dvsec)
>>   {
>>       struct cxl_memdev_state *mds;
>>   @@ -1445,11 +1445,9 @@ struct cxl_memdev_state 
>> *cxl_memdev_state_create(struct device *dev)
>>           return ERR_PTR(-ENOMEM);
>>       }
>>   +    cxl_dev_state_init(&mds->cxlds, dev, CXL_DEVTYPE_CLASSMEM, 
>> serial,
>> +               dvsec);
>>       mutex_init(&mds->event.log_lock);
>> -    mds->cxlds.dev = dev;
>> -    mds->cxlds.reg_map.host = dev;
>> -    mds->cxlds.reg_map.resource = CXL_RESOURCE_NONE;
>> -    mds->cxlds.type = CXL_DEVTYPE_CLASSMEM;
>>       mds->ram_perf.qos_class = CXL_QOS_CLASS_INVALID;
>>       mds->pmem_perf.qos_class = CXL_QOS_CLASS_INVALID;
>>   diff --git a/drivers/cxl/core/memdev.c b/drivers/cxl/core/memdev.c
>> index 99f533caae1e..9b8b9b4d1392 100644
>> --- a/drivers/cxl/core/memdev.c
>> +++ b/drivers/cxl/core/memdev.c
>> @@ -617,24 +617,18 @@ static void detach_memdev(struct work_struct 
>> *work)
>>     static struct lock_class_key cxl_memdev_key;
>>   -struct cxl_dev_state *cxl_accel_state_create(struct device *dev)
>> +void cxl_dev_state_init(struct cxl_dev_state *cxlds, struct device 
>> *dev,
>> +            enum cxl_devtype type, u64 serial, u16 dvsec)
>>   {
>> -    struct cxl_dev_state *cxlds;
>> -
>> -    cxlds = kzalloc(sizeof(*cxlds), GFP_KERNEL);
>> -    if (!cxlds)
>> -        return ERR_PTR(-ENOMEM);
>> -
>>       cxlds->dev = dev;
>> -    cxlds->type = CXL_DEVTYPE_DEVMEM;
>> +    cxlds->type = type;
>> +    cxlds->reg_map.host = dev;
>> +    cxlds->reg_map.resource = CXL_RESOURCE_NONE;
>>         cxlds->dpa_res = DEFINE_RES_MEM_NAMED(0, 0, "dpa");
>>       cxlds->ram_res = DEFINE_RES_MEM_NAMED(0, 0, "ram");
>>       cxlds->pmem_res = DEFINE_RES_MEM_NAMED(0, 0, "pmem");
>> -
>> -    return cxlds;
>>   }
>> -EXPORT_SYMBOL_NS_GPL(cxl_accel_state_create, "CXL");
>>     static struct cxl_memdev *cxl_memdev_alloc(struct cxl_dev_state 
>> *cxlds,
>>                          const struct file_operations *fops)
>> @@ -713,37 +707,6 @@ static int cxl_memdev_open(struct inode *inode, 
>> struct file *file)
>>       return 0;
>>   }
>>   -void cxl_set_dvsec(struct cxl_dev_state *cxlds, u16 dvsec)
>> -{
>> -    cxlds->cxl_dvsec = dvsec;
>> -}
>> -EXPORT_SYMBOL_NS_GPL(cxl_set_dvsec, "CXL");
>> -
>> -void cxl_set_serial(struct cxl_dev_state *cxlds, u64 serial)
>> -{
>> -    cxlds->serial = serial;
>> -}
>> -EXPORT_SYMBOL_NS_GPL(cxl_set_serial, "CXL");
>> -
>> -int cxl_set_resource(struct cxl_dev_state *cxlds, struct resource res,
>> -             enum cxl_resource type)
>> -{
>> -    switch (type) {
>> -    case CXL_RES_DPA:
>> -        cxlds->dpa_res = res;
>> -        return 0;
>> -    case CXL_RES_RAM:
>> -        cxlds->ram_res = res;
>> -        return 0;
>> -    case CXL_RES_PMEM:
>> -        cxlds->pmem_res = res;
>> -        return 0;
>> -    }
>> -
>> -    return -EINVAL;
>> -}
>> -EXPORT_SYMBOL_NS_GPL(cxl_set_resource, "CXL");
>> -
>>   static int cxl_memdev_release_file(struct inode *inode, struct file 
>> *file)
>>   {
>>       struct cxl_memdev *cxlmd =
>> diff --git a/drivers/cxl/cxlmem.h b/drivers/cxl/cxlmem.h
>> index 2a25d1957ddb..1e4b64b8f35a 100644
>> --- a/drivers/cxl/cxlmem.h
>> +++ b/drivers/cxl/cxlmem.h
>> @@ -4,6 +4,7 @@
>>   #define __CXL_MEM_H__
>>   #include <uapi/linux/cxl_mem.h>
>>   #include <linux/pci.h>
>> +#include <cxl/cxl.h>
>>   #include <linux/cdev.h>
>>   #include <linux/uuid.h>
>>   #include <linux/node.h>
>> @@ -380,20 +381,6 @@ struct cxl_security_state {
>>       struct kernfs_node *sanitize_node;
>>   };
>>   -/*
>> - * enum cxl_devtype - delineate type-2 from a generic type-3 device
>> - * @CXL_DEVTYPE_DEVMEM - Vendor specific CXL Type-2 device 
>> implementing HDM-D or
>> - *             HDM-DB, no requirement that this device implements a
>> - *             mailbox, or other memory-device-standard manageability
>> - *             flows.
>> - * @CXL_DEVTYPE_CLASSMEM - Common class definition of a CXL Type-3 
>> device with
>> - *               HDM-H and class-mandatory memory device registers
>> - */
>> -enum cxl_devtype {
>> -    CXL_DEVTYPE_DEVMEM,
>> -    CXL_DEVTYPE_CLASSMEM,
>> -};
>> -
>>   /**
>>    * struct cxl_dpa_perf - DPA performance property entry
>>    * @dpa_range: range for DPA address
>> @@ -411,9 +398,9 @@ struct cxl_dpa_perf {
>>   /**
>>    * struct cxl_dev_state - The driver device state
>>    *
>> - * cxl_dev_state represents the CXL driver/device state.  It 
>> provides an
>> - * interface to mailbox commands as well as some cached data about 
>> the device.
>> - * Currently only memory devices are represented.
>> + * cxl_dev_state represents the minimal data about a CXL device to 
>> allow
>> + * the CXL core to manage common initialization of generic CXL and 
>> HDM capabilities of
>> + * memory expanders and accelerators with device-memory
>>    *
>>    * @dev: The device associated with this CXL state
>>    * @cxlmd: The device representing the CXL.mem capabilities of @dev
>> @@ -426,7 +413,7 @@ struct cxl_dpa_perf {
>>    * @pmem_res: Active Persistent memory capacity configuration
>>    * @ram_res: Active Volatile memory capacity configuration
>>    * @serial: PCIe Device Serial Number
>> - * @type: Generic Memory Class device or Vendor Specific Memory device
>> + * @type: Generic Memory Class device or an accelerator with CXL.mem
>>    * @cxl_mbox: CXL mailbox context
>>    */
>>   struct cxl_dev_state {
>> @@ -819,7 +806,8 @@ int cxl_dev_state_identify(struct 
>> cxl_memdev_state *mds);
>>   int cxl_await_media_ready(struct cxl_dev_state *cxlds);
>>   int cxl_enumerate_cmds(struct cxl_memdev_state *mds);
>>   int cxl_mem_create_range_info(struct cxl_memdev_state *mds);
>> -struct cxl_memdev_state *cxl_memdev_state_create(struct device *dev);
>> +struct cxl_memdev_state *cxl_memdev_state_create(struct device *dev, 
>> u64 serial,
>> +                         u16 dvsec);
>>   void set_exclusive_cxl_commands(struct cxl_memdev_state *mds,
>>                   unsigned long *cmds);
>>   void clear_exclusive_cxl_commands(struct cxl_memdev_state *mds,
>> diff --git a/drivers/cxl/pci.c b/drivers/cxl/pci.c
>> index 36098e2b4235..b51e47fd28b3 100644
>> --- a/drivers/cxl/pci.c
>> +++ b/drivers/cxl/pci.c
>> @@ -922,21 +922,19 @@ static int cxl_pci_probe(struct pci_dev *pdev, 
>> const struct pci_device_id *id)
>>           return rc;
>>       pci_set_master(pdev);
>>   -    mds = cxl_memdev_state_create(&pdev->dev);
>> -    if (IS_ERR(mds))
>> -        return PTR_ERR(mds);
>> -    cxlds = &mds->cxlds;
>> -    pci_set_drvdata(pdev, cxlds);
>> -
>> -    cxlds->rcd = is_cxl_restricted(pdev);
>> -    cxl_set_serial(cxlds, pci_get_dsn(pdev));
>>       dvsec = pci_find_dvsec_capability(pdev, PCI_VENDOR_ID_CXL,
>>                         CXL_DVSEC_PCIE_DEVICE);
>>       if (!dvsec)
>>           dev_warn(&pdev->dev,
>>                "Device DVSEC not present, skip CXL.mem init\n");
>>   -    cxl_set_dvsec(cxlds, dvsec);
>> +    mds = cxl_memdev_state_create(&pdev->dev, pci_get_dsn(pdev), 
>> dvsec);
>> +    if (IS_ERR(mds))
>> +        return PTR_ERR(mds);
>> +    cxlds = &mds->cxlds;
>> +    pci_set_drvdata(pdev, cxlds);
>> +
>> +    cxlds->rcd = is_cxl_restricted(pdev);
>>         rc = cxl_pci_setup_regs(pdev, CXL_REGLOC_RBI_MEMDEV, &map);
>>       if (rc)
>> diff --git a/include/cxl/cxl.h b/include/cxl/cxl.h
>> index aa4480d49e48..9db4fb6d2c74 100644
>> --- a/include/cxl/cxl.h
>> +++ b/include/cxl/cxl.h
>> @@ -4,21 +4,25 @@
>>   #ifndef __CXL_H
>>   #define __CXL_H
>>   -#include <linux/ioport.h>
>> +#include <linux/types.h>
>>   -enum cxl_resource {
>> -    CXL_RES_DPA,
>> -    CXL_RES_RAM,
>> -    CXL_RES_PMEM,
>> +/*
>> + * enum cxl_devtype - delineate type-2 from a generic type-3 device
>> + * @CXL_DEVTYPE_DEVMEM - Vendor specific CXL Type-2 device 
>> implementing HDM-D or
>> + *             HDM-DB, no requirement that this device implements a
>> + *             mailbox, or other memory-device-standard manageability
>> + *             flows.
>> + * @CXL_DEVTYPE_CLASSMEM - Common class definition of a CXL Type-3 
>> device with
>> + *               HDM-H and class-mandatory memory device registers
>> + */
>> +enum cxl_devtype {
>> +    CXL_DEVTYPE_DEVMEM,
>> +    CXL_DEVTYPE_CLASSMEM,
>>   };
>>     struct cxl_dev_state;
>>   struct device;
>>   -struct cxl_dev_state *cxl_accel_state_create(struct device *dev);
>> -
>> -void cxl_set_dvsec(struct cxl_dev_state *cxlds, u16 dvsec);
>> -void cxl_set_serial(struct cxl_dev_state *cxlds, u64 serial);
>> -int cxl_set_resource(struct cxl_dev_state *cxlds, struct resource res,
>> -             enum cxl_resource);
>> +void cxl_dev_state_init(struct cxl_dev_state *cxlds, struct device 
>> *dev,
>> +            enum cxl_devtype type, u64 serial, u16 dvsec);
>>   #endif
>> diff --git a/tools/testing/cxl/test/mem.c b/tools/testing/cxl/test/mem.c
>> index 347c1e7b37bd..24cac1cc30f9 100644
>> --- a/tools/testing/cxl/test/mem.c
>> +++ b/tools/testing/cxl/test/mem.c
>> @@ -1500,7 +1500,7 @@ static int cxl_mock_mem_probe(struct 
>> platform_device *pdev)
>>       if (rc)
>>           return rc;
>>   -    mds = cxl_memdev_state_create(dev);
>> +    mds = cxl_memdev_state_create(dev, pdev->id, 0);
>>       if (IS_ERR(mds))
>>           return PTR_ERR(mds);
>>   @@ -1516,7 +1516,6 @@ static int cxl_mock_mem_probe(struct 
>> platform_device *pdev)
>>       mds->event.buf = (struct cxl_get_event_payload *) 
>> mdata->event_buf;
>>       INIT_DELAYED_WORK(&mds->security.poll_dwork, 
>> cxl_mockmem_sanitize_work);
>>   -    cxlds->serial = pdev->id;
>>       if (is_rcd(pdev))
>>           cxlds->rcd = true;

