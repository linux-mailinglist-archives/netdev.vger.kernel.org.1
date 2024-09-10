Return-Path: <netdev+bounces-126766-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id CBCF497265E
	for <lists+netdev@lfdr.de>; Tue, 10 Sep 2024 02:51:21 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id EFF3A1C2372C
	for <lists+netdev@lfdr.de>; Tue, 10 Sep 2024 00:51:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9273958222;
	Tue, 10 Sep 2024 00:51:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="YOhofLNf"
X-Original-To: netdev@vger.kernel.org
Received: from NAM12-MW2-obe.outbound.protection.outlook.com (mail-mw2nam12on2077.outbound.protection.outlook.com [40.107.244.77])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CF5B555E58;
	Tue, 10 Sep 2024 00:51:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.244.77
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725929478; cv=fail; b=MCfxCEZr4NOJ4DghKpxhtMXrzSA82ouTIrbyLgBAgKtBGNz7WwZX5iYEsi3+BHiLGfjrrOP9BZ1N1/BUe3ve06R+xORBVl6iIYvsbS89HefD89cGAp4Trfjwlqk2yMz3p1uX9mw3kKDDtRMiYhLZckO8zyy+348fCDIgNIfqYeQ=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725929478; c=relaxed/simple;
	bh=PZrWmGO6Bh5XRe2IvFOY82+6MJyS8jf+5FhLnFWbqhc=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=qvtoqORyUr/UwE7pS6F+7z1eoZYNzyRZdPiOVef3hHPZE897ZKBA0TjYU00kAKdqxR62GIAirNMqSqy8D3NhyX7HXZOfemxePaPJqFlVHhhxkcuxN2cSya0kYsWi3x9+/mSsNRuLVRMOQkk+CvuJ8uXHZUlhdPo6uyl0I+wBPqc=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=YOhofLNf; arc=fail smtp.client-ip=40.107.244.77
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=PaNA8c0dwOtHzQkAFWoN4w/YiPBHr5wMj9bSxYwjAyGL+Cu4UY0u3VyuW1rYgIU2+8NROVnuaOaBOIRxQvFDXpQMw9wNSINxTldP8ezpfJrw1hWT1gmCrPAnZQKKhhLL1psUrIhGPKVwQY0d4ga9HEtrUT9Mql9wU8ym76iGm7TbVboBojUHUJcf72os8SGOTH8dq60XCceZGKHFREfZLGieCW4ZeJANQgPx/dDUgAf5l7F+1mUpH1gf6s7aysnsKUXPxRgwOKh2FuEONYlHNl+bleDIT22MZhdUTaqBIcDarZZUrf21x8iq1NXsOAMFUIp1gBbnKGihjBiMw+bGWg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=dLIrpysRuj3lYB0eTMPaAT2wCCET5TVKlOORqn1MpLE=;
 b=LlIUWUfzBMBiYr4/Bk5bKShmldXheMMGoN0BmL9lwoFv0mBd1SHiuDS2LNKWSS1q07ySN4lf1sa9ZfToxzaso83J63YWOJIlZ/IVbsLYRHpn1wnKGecjtQtofIFKUPAF0gCIfG9050PjZKAxxVcqm2fJgq5aHmwVfdHcIaKT+GXKH+kvCkpIPlrnU81XYbQKKJHd4H2sc+1KE247M7zZoWynqwP7jWdFx487D4mQeLPgM4ESb0XQRYly7asTfozUFS5OpFtEUc5RUKgUZnCNZNK+51wbX9uo8+/izUHG60VW9T5nwFO7tJQ1A61MG95uA/YnIN0SR4ue9Cp8XABMHw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=dLIrpysRuj3lYB0eTMPaAT2wCCET5TVKlOORqn1MpLE=;
 b=YOhofLNfzbyrVUNUEwZeHGscORgTuKRwIDXCk0LzGke1mrm5so7aDUOL1WBeouiCxQP/StxgPKuy6TrpXVpcs2HYfNJkIcDVg8b3OzObqmVEGvIh12zn4z1UATHwfVPui45vycSFf04LJaojiyFsq4g7dWZ1l4PcWXdMQQXmntc=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from DS0PR12MB6583.namprd12.prod.outlook.com (2603:10b6:8:d1::12) by
 CH3PR12MB8657.namprd12.prod.outlook.com (2603:10b6:610:172::6) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.7918.23; Tue, 10 Sep 2024 00:51:12 +0000
Received: from DS0PR12MB6583.namprd12.prod.outlook.com
 ([fe80::c8a9:4b0d:e1c7:aecb]) by DS0PR12MB6583.namprd12.prod.outlook.com
 ([fe80::c8a9:4b0d:e1c7:aecb%6]) with mapi id 15.20.7939.022; Tue, 10 Sep 2024
 00:51:12 +0000
Message-ID: <4f33691d-4997-4145-9cfe-f8e5a187e4ac@amd.com>
Date: Mon, 9 Sep 2024 17:51:07 -0700
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net v2] net: xilinx: axienet: Fix IRQ coalescing packet
 count overflow
To: Sean Anderson <sean.anderson@linux.dev>,
 Radhey Shyam Pandey <radhey.shyam.pandey@amd.com>,
 "David S . Miller" <davem@davemloft.net>, Eric Dumazet
 <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>,
 Paolo Abeni <pabeni@redhat.com>, netdev@vger.kernel.org
Cc: Andy Chiu <andy.chiu@sifive.com>, linux-kernel@vger.kernel.org,
 Simon Horman <horms@kernel.org>, Ariane Keller
 <ariane.keller@tik.ee.ethz.ch>, Daniel Borkmann <daniel@iogearbox.net>,
 linux-arm-kernel@lists.infradead.org, Michal Simek <michal.simek@amd.com>
References: <20240909230908.1319982-1-sean.anderson@linux.dev>
Content-Language: en-US
From: "Nelson, Shannon" <shannon.nelson@amd.com>
In-Reply-To: <20240909230908.1319982-1-sean.anderson@linux.dev>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: BL0PR02CA0050.namprd02.prod.outlook.com
 (2603:10b6:207:3d::27) To DS0PR12MB6583.namprd12.prod.outlook.com
 (2603:10b6:8:d1::12)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS0PR12MB6583:EE_|CH3PR12MB8657:EE_
X-MS-Office365-Filtering-Correlation-Id: 9b6cb96d-4ce7-464e-622c-08dcd132aaae
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|7416014|366016|376014;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?OGtBL0UxV2JxUUdncEIzQTMrZlYwOEN0aWlnU3k4K0hHUFpvNEplRC91OUJt?=
 =?utf-8?B?aTFOMGlmdHFmbERUNGs0U0JuMHExQWQ5YjVPRnArcjhrNkt2VTlSNWQxb2hw?=
 =?utf-8?B?YS9FcmR4NkhMWHVjZXhaSmsrN0dhREdVeEIxZC9oOWVlVXl6MzUzendtam1J?=
 =?utf-8?B?SEdmMUJBVVNhK2hNemFHU1V1elRBMFpPcEVHUWZGZTg0dUlVQ0JCdkg1bDB2?=
 =?utf-8?B?VUozcFFkajJWTDFneTZlYUxKZjc0bnVQdUovWTdGV3FTbjlBd2o1UGphM0dU?=
 =?utf-8?B?QmNEYjZOWGgzL2J4YktHMGc3dytRTEVieTFtbnB0RnQyQy9GckVpMVdrS3JQ?=
 =?utf-8?B?dEJSZDY1cnhUQm0yK3N5QnFHdncvRVRrR2QwTG9wcGhQbTZaalZNZ2orZXpG?=
 =?utf-8?B?cXVRVTNnNjdiSk1EMlZpYlF6ZkdoZ0MyRm9kZ0dTYTRZZkRhMU81SkQycjF0?=
 =?utf-8?B?Qk11bUJhRUp6M1lUbWFXNWxmdU1aaDFKeEsyRytXZTBCNDZPdmkrM0hObHBB?=
 =?utf-8?B?eUZKbFowaGRseWJwS3JMVEZlemJaRnc5MElILzZxemJQSU5TQjkrZzlJTGk1?=
 =?utf-8?B?eDhtMk12c2wrVG5SRGVraExUa3hWc0VtM25xMlRBOHFWUy9aVFFvb2RVek04?=
 =?utf-8?B?YmVnK3EyMUdDekU0UkZMazBjNmRUV0dYOWFYVGtuVUpVMkpyMml4VFZxeUp4?=
 =?utf-8?B?OWN3bW9RcVlBQnZlZDJrcVpHelZlYjVnUnZ4SmhVU1htYnVXZTdlUkhGT3Av?=
 =?utf-8?B?L2czenhXbGQvNkd6RUdOZE8yNGY3ZnZlRzM2NEdZZHgyWHFCYi9xVkN2dVpa?=
 =?utf-8?B?bW9mcGZCQm9GOFNNRSttNlRIT0ZhNUtoY2MwRjIzZExUSVN0SE8vaExsMmkx?=
 =?utf-8?B?VVU3RWJxYVoxR0gySkZ0UmpkR3pMVENJVC9halJVWWdENHJSNStWbGx0WFVk?=
 =?utf-8?B?aEhhRkJ2YjdEaTJidndyOUl1c1o0aHZzN1lkUDUydnpqS2V0a0xLblVrYjBD?=
 =?utf-8?B?eFp1TVRSZVFVaW5idTFtSHJFME42Wm9MSFRvdGg2bTcvUW9ycUovMFV6VDNv?=
 =?utf-8?B?L2lDSHZaSG4rYmxXYzZ0OWZ3bWZuUzFBSFFZNjJEWFJIcUVsTlU5WGxmdWp2?=
 =?utf-8?B?eTBIelh6bjdCVzhhbUNPT3BIdGZSUDhYbW85WEFzQUh0bWRaa0dYU1ZXUVAy?=
 =?utf-8?B?M2VPZFdwd0FCZzY1aHVscXExTmFBZkc3V1hyZVhvV3NTd1gzTFc0bW0wZmpm?=
 =?utf-8?B?NFprb1IxQkZjbnRGdk05U29FNlI3Q0J0bE1TcTVzVjZWQTZaR3ZkZTlEUFpE?=
 =?utf-8?B?ZmEybDZBeStzNGF4eUJ4S0hUdURDRTZzY2h2cmk2YStBRTRwekozQzI5Mmsr?=
 =?utf-8?B?b1kzODUwMzRkZnBpeTdsWWhwc3hzOWFUWmh0bm82WW1sN2xiemtPK3N0TDNi?=
 =?utf-8?B?YUl5N2VIcmZTNWZSNVMyUGZCY3c5Tnk0QTBwWFVyWmUxKzBXekF6SHB5MzlD?=
 =?utf-8?B?OWJDR2JiZnlYT0lMbUNNOWp4eEdnVUIzOFFhNFR5U3dDTjVQaDJRcWtrYWk3?=
 =?utf-8?B?TDBkSVBqMDRrdzBsWU4yUVBneSsvYVF4SnFNL1NaZXh0eTdIMkQ3SDNsY0di?=
 =?utf-8?B?QnppeTVmR0lQVFluZFA3UmtIZkhBOVY3VGxmcFE5WlJlSnV2cWJyVjVraTNh?=
 =?utf-8?B?QU9YVXpkM2VBSWxINWJ1SFpGWlJ5KzBJOHdWYUxPR3RhVEZMQTZJVkcveTR6?=
 =?utf-8?B?bHQwc3ZlMitYRFk0WllkS2YyV0xWSlpEU1ZwOEMxSjd3RFY4RGJtRTdma25p?=
 =?utf-8?B?U3Qwam84b21abjRsd3BCQT09?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DS0PR12MB6583.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(7416014)(366016)(376014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?ZERYSktXMkk4cVBzbSt0cGJ2ZE9ZVE9wcCtOUGZHTjZhVXd5Z1NPMGhPQWh1?=
 =?utf-8?B?OEpxSXNoNXVaR0g5V2pKeVA0U3lXNCtQMDBQTXhWRnpURnJ5UUxYdE5acm51?=
 =?utf-8?B?VVlJK0hOcUJGTkprM0poeGhkakVncVdyQXdWN1RJLzIxS0NZTkxBdG5xQ3hY?=
 =?utf-8?B?elREdVE2QVU2Y3ZBekVFNGdPaFBNTjIxRitzL1hIZzRicEJnbllwZ3QwN0s2?=
 =?utf-8?B?bWhoZVVXOEROQVNrQm03Qlp0cVFjcE40WitoTzJNVXVqMVBZTnZSVVcwSitH?=
 =?utf-8?B?azBQeUVVMnptVkN6aHFxRFlOS3FLRGhiTWlvTUNjMTVnNEhTaTRqVktQMUNk?=
 =?utf-8?B?VHJBNENKWjE0cy8vVE1HTnJsdjNkcGdVK1R0NS9GaGpqdkNjRXVZOVYzV2xX?=
 =?utf-8?B?cXAwOW8xUkZRYUJNU3dLT2MyNnRpWVpSVFVRNXdzZnlvY09WTFFOY1BObk1i?=
 =?utf-8?B?cm0rbjA4cU1vYWgrMWgvWUdBTG41Sy80ZjdFZEZIWlhVUW12RFFCZEF6Y2NZ?=
 =?utf-8?B?VlljOVlMdTFjVS9jR2hBM1JuS2lMWWMySW5zQnNNYkNqOHRlRGZ0QlJ6Skxo?=
 =?utf-8?B?ZmhhQ3N6emt6SmV3UkNkTVVNWnhrVE9FaW1FTDhka2o2ZXlEZDJBWGJBa0xo?=
 =?utf-8?B?NkJCcmxNci8rNjQrTWM2dGx5ckNqTEhSa29iMWE5QkV4RzVxWDIwODg2cmZy?=
 =?utf-8?B?c0UzK0l6cWFOdyt1d056QmNvbWt2Q2ZDazdWRjBOTlRLc2VVQkNYN2VUMzdr?=
 =?utf-8?B?M2JRKys3cWcyNzltZmV6c2xlNEVrVUNqYjNFMTJPN3RwVkxwSldmdnR0TUEw?=
 =?utf-8?B?NVdlTjJ5WWZGQmxUUUlaSEdiVDB3aVdNNWVzNG1IRTVWbG1ROC9YZVRDbXFq?=
 =?utf-8?B?QWNST1kwTlEwN1RPSDhqS09DZ3U5R0Z5cHFLdTJaS1hMUFlUT3RldEcyUlJr?=
 =?utf-8?B?ZUJRcGNZMTg2NXM0cGZjell4K3dBa2JuWE5IRE9YZ1RYc05PYzBBS0NWSnN0?=
 =?utf-8?B?anJqNEg4dmdrNmdCUXFUL2NXemVIUW9PN0w2TEtsSmRIUUZxaExuSWJyNEVh?=
 =?utf-8?B?bGdNbVZxbFAyZ2pqRVdmL3hGbUpUelBZVlprYWhpY0ZwSmdvUWtQKytTN1hQ?=
 =?utf-8?B?UStOaFRKaWNPWis0V25xUDU2SVVXTFFpS0w0bW1Bb2l0aXNtMnRkVVNhdmNP?=
 =?utf-8?B?WFNDVlBvcmE1dGkvcnJxTXI0UGVtNzRTS245WmJGTG42MDAvTUZYTkxtWFB2?=
 =?utf-8?B?cDB4RXNWbnRwaWlkMlF4OXRSeFZYelI3YTJMRjlYbDlWUkE1d0pCZnNsNGlh?=
 =?utf-8?B?bkhoTDJ5UDFNTy95MXh1Y3RtT1pqdUZ2TjgxZkNvMHNydmZOSzA1bHBoTmdY?=
 =?utf-8?B?WUYvMDI0LzY4cytPMUdNSHg2MmJuTmZkcWJMWFNKWEpuT3NOVmJJU3FEVmZV?=
 =?utf-8?B?U3VldVd0Y1c0UW1wWUc5NGFsSTYyZzhzWVdyNk52WXZ4bVplcHZWM0FqRWlN?=
 =?utf-8?B?ZUtid2Z2aFBPc0VudVhEQTJEbGlhUU5wTDNIWDd4RllmR0pHRkFPWTJQUXR4?=
 =?utf-8?B?U2x4VW9wanVFNVQ1cDZUaXJzalp2WjRGa1Fmc2ZnaXp3K2l1NjV1Mzk4Qi80?=
 =?utf-8?B?UzJKb1ZERUlJZ2VjSGRoMEpCN2FzWWF0ak1xQWZjamJ1Y1dUSnE1ZnIvdTdk?=
 =?utf-8?B?ZWVHWHdkQjcyNWM0U2dpRWlRQURXQjZhMjcrK09JY0F0UDllZ3AvQTRyRThh?=
 =?utf-8?B?MDZsc0JQcjEvbzJpQ1dISmJleE51Yk1GRVRZSHcrZkVsc3VCTEcxOExVeE1H?=
 =?utf-8?B?R0o2U3lSYjlSVm1RQ2dRcFhkcmJFcmdEU1NYZVBZN1BQRDlUNlB5RHpWaXNB?=
 =?utf-8?B?SW9vWlc1dG55dFZsdGllN25KRnJ5d2I5NDQzemllNzVKUndzUEpyUFA2MmVI?=
 =?utf-8?B?VXdVcXNJcjY3NXRuTHlXZGpiMTNyZllxN3p5UWdNRkJLOWVZbU43N0hzQ3dh?=
 =?utf-8?B?aTd6YUxJaExUMUpVcnV5czBHUTZYZGpHb2t1RWZVZi8wOFQwU2hyTjZPeE5W?=
 =?utf-8?B?c1hvM3ZBays5cGo5cFJUMGlDbjAzSXExclFnL2RtWStpZnk5TWlrbDdWK1Bn?=
 =?utf-8?Q?5goj57DkOO8gtqWp0GwtvR8Re?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 9b6cb96d-4ce7-464e-622c-08dcd132aaae
X-MS-Exchange-CrossTenant-AuthSource: DS0PR12MB6583.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 10 Sep 2024 00:51:12.3286
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: hKLN2xtwqSJmqTE/dzfW6eXJ17NQVd2CiGA8vp+k0ptCvVA/5CE7JyJdtJcEzi+JBchCpO4f0jRfwXqSjoGl8w==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH3PR12MB8657

On 9/9/2024 4:09 PM, Sean Anderson wrote:
> 
> If coalece_count is greater than 255 it will not fit in the register and

s/coalece_count/coalesce_count/

Otherwise

Reviewed-by: Shannon Nelson <shannon.nelson@amd.com>


> will overflow. This can be reproduced by running
> 
>      # ethtool -C ethX rx-frames 256
> 
> which will result in a timeout of 0us instead. Fix this by clamping the
> counts to the maximum value.
> 
> Signed-off-by: Sean Anderson <sean.anderson@linux.dev>
> Fixes: 8a3b7a252dca ("drivers/net/ethernet/xilinx: added Xilinx AXI Ethernet driver")
> ---
> 
> Changes in v2:
> - Use FIELD_MAX to extract the max value from the mask
> - Expand the commit message with an example on how to reproduce this
>    issue
> 
>   drivers/net/ethernet/xilinx/xilinx_axienet.h      | 5 ++---
>   drivers/net/ethernet/xilinx/xilinx_axienet_main.c | 8 ++++++--
>   2 files changed, 8 insertions(+), 5 deletions(-)
> 
> diff --git a/drivers/net/ethernet/xilinx/xilinx_axienet.h b/drivers/net/ethernet/xilinx/xilinx_axienet.h
> index 1223fcc1a8da..54db69893565 100644
> --- a/drivers/net/ethernet/xilinx/xilinx_axienet.h
> +++ b/drivers/net/ethernet/xilinx/xilinx_axienet.h
> @@ -109,11 +109,10 @@
>   #define XAXIDMA_BD_CTRL_TXEOF_MASK     0x04000000 /* Last tx packet */
>   #define XAXIDMA_BD_CTRL_ALL_MASK       0x0C000000 /* All control bits */
> 
> -#define XAXIDMA_DELAY_MASK             0xFF000000 /* Delay timeout counter */
> -#define XAXIDMA_COALESCE_MASK          0x00FF0000 /* Coalesce counter */
> +#define XAXIDMA_DELAY_MASK             ((u32)0xFF000000) /* Delay timeout counter */
> +#define XAXIDMA_COALESCE_MASK          ((u32)0x00FF0000) /* Coalesce counter */
> 
>   #define XAXIDMA_DELAY_SHIFT            24
> -#define XAXIDMA_COALESCE_SHIFT         16
> 
>   #define XAXIDMA_IRQ_IOC_MASK           0x00001000 /* Completion intr */
>   #define XAXIDMA_IRQ_DELAY_MASK         0x00002000 /* Delay interrupt */
> diff --git a/drivers/net/ethernet/xilinx/xilinx_axienet_main.c b/drivers/net/ethernet/xilinx/xilinx_axienet_main.c
> index 9eb300fc3590..89b63695293d 100644
> --- a/drivers/net/ethernet/xilinx/xilinx_axienet_main.c
> +++ b/drivers/net/ethernet/xilinx/xilinx_axienet_main.c
> @@ -252,7 +252,9 @@ static u32 axienet_usec_to_timer(struct axienet_local *lp, u32 coalesce_usec)
>   static void axienet_dma_start(struct axienet_local *lp)
>   {
>          /* Start updating the Rx channel control register */
> -       lp->rx_dma_cr = (lp->coalesce_count_rx << XAXIDMA_COALESCE_SHIFT) |
> +       lp->rx_dma_cr = FIELD_PREP(XAXIDMA_COALESCE_MASK,
> +                                  min(lp->coalesce_count_rx,
> +                                      FIELD_MAX(XAXIDMA_COALESCE_MASK))) |
>                          XAXIDMA_IRQ_IOC_MASK | XAXIDMA_IRQ_ERROR_MASK;
>          /* Only set interrupt delay timer if not generating an interrupt on
>           * the first RX packet. Otherwise leave at 0 to disable delay interrupt.
> @@ -264,7 +266,9 @@ static void axienet_dma_start(struct axienet_local *lp)
>          axienet_dma_out32(lp, XAXIDMA_RX_CR_OFFSET, lp->rx_dma_cr);
> 
>          /* Start updating the Tx channel control register */
> -       lp->tx_dma_cr = (lp->coalesce_count_tx << XAXIDMA_COALESCE_SHIFT) |
> +       lp->tx_dma_cr = FIELD_PREP(XAXIDMA_COALESCE_MASK,
> +                                  min(lp->coalesce_count_tx,
> +                                      FIELD_MAX(XAXIDMA_COALESCE_MASK))) |
>                          XAXIDMA_IRQ_IOC_MASK | XAXIDMA_IRQ_ERROR_MASK;
>          /* Only set interrupt delay timer if not generating an interrupt on
>           * the first TX packet. Otherwise leave at 0 to disable delay interrupt.
> --
> 2.35.1.1320.gc452695387.dirty
> 
> 

