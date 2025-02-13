Return-Path: <netdev+bounces-166148-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id C5E0EA34C1B
	for <lists+netdev@lfdr.de>; Thu, 13 Feb 2025 18:38:31 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 478D618860DB
	for <lists+netdev@lfdr.de>; Thu, 13 Feb 2025 17:38:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E8F172040B7;
	Thu, 13 Feb 2025 17:38:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="1xHGecI8"
X-Original-To: netdev@vger.kernel.org
Received: from NAM04-MW2-obe.outbound.protection.outlook.com (mail-mw2nam04on2060.outbound.protection.outlook.com [40.107.101.60])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BF08628A2D6
	for <netdev@vger.kernel.org>; Thu, 13 Feb 2025 17:38:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.101.60
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739468308; cv=fail; b=Bne/yotuRemJiRbfP7L6YTpU/wH+txZ6awgtkRVTY6NCuUO+2Sc9k9P0mT4KgpB4hLW4q+wktKP35XW7Rgtb0GUmMRWuSqNMT7h9aX/G7il6jCCT8vCs+CQe3U2w3zGUYloj2wa1Jt1pxrsDaZ+N2Xqrq3cMMgipKH2nn5zkxCw=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739468308; c=relaxed/simple;
	bh=sTgCABADTvRbhSgftT/QRH9sbOB/s0a8Ee4tHK8ZfSA=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=UDpWqotODIOqxFz5jk8Z8pqaA9iLF/SE07r9fD+LssZgt6GEfUOPUptvh8X0Od6MNfTAG31qNUSaDaVoJSuKgEaza1OuJGe1a/imYzELSb27ws2ooQvJYfo6y64syElV0kLaKKvFpcYSQwRgHMC6JMrdO94An1jQb2FR+4xFt+0=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=1xHGecI8; arc=fail smtp.client-ip=40.107.101.60
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=ltNkpqfvhlFjKjaK/v75S7Kp1bKWOLnadvr8128ZHY4F0xfCefzj49V223A5QDUoRdXjfs1zSwrZfcJypcphVfD+WM2eER0bTQIuR30i2sdgH9CdaV+G4TTwjT7woQNfAaPBuoRAE5DOSNSWn6+hML1Wh8r96v6Dy0NT/uE3tu/tYaaahmnkKcdRUVObcaDiE+KrVBEVZxwI1p5QJkBDCVphPATasrFCBun6NLpY1/CAl2egJURRMfgFeDoqmRA7z8vZHjAWmXopieejpEFnZJH3UXBpMlABvrXw5/fUBEL0F5PcSbtPCbnK7sHPQ4Q8iozFirEkUyU7NegzL2rc+w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=oZq1OKCt+lLUIDqW13H4giFCMe1Jp5C/4ClBTk5zQ6g=;
 b=IMdhs4A3z9MOGREYSt6nKqKFfK15jY8kWiYLKKB1GIg2OE0/Dy7Ww2pbvxQ7WL1iS1QVN+qwy7xi8TxcXlZKHmPShI5VqrPPftLx4FYbLN4DvaOE7B+boBixIFUiZ56MRamZLJW1axPF0i4Lck2wltVPTCJF3VHOTD9cnMJsAmXlvvoBnAHOIVybw10Aui6mKPLngIM8tE7F5w9WgPvUheHU0emAHtySomSk4E0mXo7Aq/+NbqmHUUtVEMsM6t58pTxB1xsEuF4cry+lmazUEaQywP8f81iM2/yHiqx75VjtUL+i48J+zzahPCyFQ33Uwnuvpw2ypFeGBzf7tXHBcw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=oZq1OKCt+lLUIDqW13H4giFCMe1Jp5C/4ClBTk5zQ6g=;
 b=1xHGecI8bXgQUK4KS0BPv/eV+oDn1aHed6PoWE86gUvyjgcqKuLOHT4EcdZ3f42J+dNMhDwgov7nIjGv2+m2ZrnYjbPNbxY+SbcysmooLTT6eg9i4AHXDUm3v7gQKKTQOeUYmQx5A7ror9UmkiqDjUOpRuNRywtcRJBOa2f2RmA=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from PH0PR12MB7982.namprd12.prod.outlook.com (2603:10b6:510:28d::5)
 by CH2PR12MB4134.namprd12.prod.outlook.com (2603:10b6:610:a7::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8445.17; Thu, 13 Feb
 2025 17:38:23 +0000
Received: from PH0PR12MB7982.namprd12.prod.outlook.com
 ([fe80::bfd5:ffcf:f153:636a]) by PH0PR12MB7982.namprd12.prod.outlook.com
 ([fe80::bfd5:ffcf:f153:636a%4]) with mapi id 15.20.8445.013; Thu, 13 Feb 2025
 17:38:22 +0000
Message-ID: <f6dcafd5-69c1-4981-84da-e7683e84833d@amd.com>
Date: Thu, 13 Feb 2025 09:38:20 -0800
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net-next] eth: fbnic: Add ethtool support for IRQ
 coalescing
To: Mohsin Bashir <mohsin.bashr@gmail.com>, netdev@vger.kernel.org
Cc: alexanderduyck@fb.com, kuba@kernel.org, andrew+netdev@lunn.ch,
 davem@davemloft.net, edumazet@google.com, pabeni@redhat.com,
 linux@armlinux.org.uk, sanman.p211993@gmail.com, vadim.fedorenko@linux.dev,
 suhui@nfschina.com, horms@kernel.org, sdf@fomichev.me, jdamato@fastly.com,
 brett.creeley@amd.com, przemyslaw.kitszel@intel.com, kernel-team@meta.com
References: <20250212234946.2536116-1-mohsin.bashr@gmail.com>
Content-Language: en-US
From: Brett Creeley <bcreeley@amd.com>
In-Reply-To: <20250212234946.2536116-1-mohsin.bashr@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: SJ0PR03CA0190.namprd03.prod.outlook.com
 (2603:10b6:a03:2ef::15) To PH0PR12MB7982.namprd12.prod.outlook.com
 (2603:10b6:510:28d::5)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH0PR12MB7982:EE_|CH2PR12MB4134:EE_
X-MS-Office365-Filtering-Correlation-Id: a686860f-de47-47e8-8fd3-08dd4c553627
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|7416014|376014|1800799024|366016|7053199007;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?eEFNNW5uTHBxUk5wRDllTWE5aWQ5eVBaRFFjb3lGQmVtTWg1YWFLQk4xVGwv?=
 =?utf-8?B?NXlwSnE4cCtRaFhiZFRsV2VyMjdyNkxPcUxybm9wTlBjOG5nZXdGN211K3hY?=
 =?utf-8?B?RWsxMmFKMWtBVlpJT29tN1c3NjNZaUtGYW5XY0dKWkJMNm1kS2VGeTd6RU9P?=
 =?utf-8?B?SVhBMVJSL2YxL3JtZG9VSkxObGs1anBpMTJvZnFZc0ZLM001OVJDdkdTeVJI?=
 =?utf-8?B?N1ljT0xQdGpuUmE2SUppY3dQWHE4WDNoWGFwbzBnanVReFJHQWRHS3NaVzBl?=
 =?utf-8?B?ZUtFUUVaTktIaVV6VXRrSUJUcldPTkVQMlhpQ2dSclNNWkFXQkxHQWc5ajNG?=
 =?utf-8?B?QWpIL2FvdG84Y0FtaTdrR3Zma09OUFpIWmR5WUh0ZXVvNHdBWTBReFBhQXh6?=
 =?utf-8?B?cyszWVloeTl0cEpPbHZCeGNMVWJwL3FIMkY2eVAxRng5d2l3Q0hJcXlKNlMr?=
 =?utf-8?B?dWQySjYyRU1NUzlpTE05MWlaOVpuTXhjRzNCV2U2YTNRcHFUSm4rekU0Y0o5?=
 =?utf-8?B?azJSZ2RMMmtFT2swQTRGejhicUFQRE44RkpPUkg0aUdaL0h5N3luVS8zUy9q?=
 =?utf-8?B?RlNiTS9Fek8reGw3Z3pwWml2Tmh1NjRQWElGWkNXR3ExTXlsYkZaYnJidSt2?=
 =?utf-8?B?VmM5eDRwaUVnYy9VQ3NnTjVQbzBYQnByOFJiY2dLeGN4VW1iYVV1enlTcTFu?=
 =?utf-8?B?UktIaWlLU3dyWmhBSmpIVk5nQWcwUjNDaHZ6YnhiSVRVb3hwMTNleEZPZC9W?=
 =?utf-8?B?UXkrc2lXOWxpTEQ3TzMyQTAzUlNsaEtPSUx5UVNoRVhjcG91WUhIYmplVU4x?=
 =?utf-8?B?RmozbHJYRklrM1M5cVJXeEdTSkZYR0pUQWNYN0s2UStJd2VKUUc3Ymw0dDF4?=
 =?utf-8?B?aFYzTnJWM0RNVlkyT0llV1MwSG4vOFRXb3ZCZTV3R0NWUS9uQjA2Q0Rpcy9l?=
 =?utf-8?B?WFk2MkNyNGtDT1UyRUVtdER2RlhLMTNRWXNiMDNTSk1hcGdiaEF4eXdpcmJY?=
 =?utf-8?B?S1RkRUE2V3lYalVUNFNTa3k2SXovMjZ2Q1Y5SVhodUZqb3p6Tmp0NTNaWHc3?=
 =?utf-8?B?MTZ5eWN4RmtsYnNxa1VVUU8zeXB2VXBYZFB6a3ZVcy9YYzA2N3l6dVVBdCtT?=
 =?utf-8?B?b09CbnAvYnJVZVhvQjFQdUxEWFFHdkYyYkR3U0JGNlk4b0cxQk0yaEdRWkhH?=
 =?utf-8?B?MnlKODNEdzREdk5TY3dHV0lYZWdSVTlsVW1kZi9RUnlRTFVpaHpGWDlRTCtX?=
 =?utf-8?B?T291S3F1NGNVN2FQNEVrZWxSbGJqTW43NWxvY3dqcEhibkx0YUQwM29DTjNP?=
 =?utf-8?B?d29jREFXbS9hL0dmNm9qZkdGWkpOZENJOU9oRXU0OGdUd1gvRUkxc3ZpNUxt?=
 =?utf-8?B?VVkvN3lPVXRpdlFNdFhFN2psM2tEMi9sSGdXdE5tYk9ZUTJlTDdRK2JlVFpP?=
 =?utf-8?B?MTY5YjBGeHZqZ3lHU2x2d3V4WWRuU3hrRTU1OFY2aGZOc1Zyb3NqNDBkYkJw?=
 =?utf-8?B?Z0YzM2dZeGJpVzN3OFNLWThJb3RFTEtKa3BRSS8ranR5Zm9iTTRiK1Vlb3hp?=
 =?utf-8?B?VmhJU1BXYzh2djNUdmhyZzFCRHY3WEFJb0tFc0FBeFZjakZGTVhyWGRXODg0?=
 =?utf-8?B?bDA1cUlzZDF3d0orUlExd0ZRR2MwdFBsZ3p4ZWtxeXNpdnArMVB3SEwrVTR5?=
 =?utf-8?B?VVJnUGNWemgrT0tTNldzZjVQYUowNUtGcWwrMWdHUVgrZ3EvMjVMcittaHlO?=
 =?utf-8?B?TlBEN3dBUXdTNmh2UlB2aTA0dDR4R1U0NU1sT2JoVWlPZG9oWXBmQlRyajhz?=
 =?utf-8?B?cmFMVklUblRZRDc2djlYcjd0dkJhMWYxUkZQSWtUbXlyV2E1YUtMVnpKWlQ5?=
 =?utf-8?Q?UffhTE7OeG3Ji?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH0PR12MB7982.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(7416014)(376014)(1800799024)(366016)(7053199007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?ZmVsY2lqZlVaSW5aQjJqMHhWVi9raDNKck53eU1nY3BMMWM4OWJjcFU5R3Jr?=
 =?utf-8?B?Q0IzU0IyY0tTd2NQMmM0SWVieGxrZWF3UGhvTm43d0tLSGtGbTlKMS9oKytx?=
 =?utf-8?B?c0NZaWRyQ05yRnMwREdvWExqNTJyOVVZYXVZSTRYRnNJdDhIeFdTQXdkaEZC?=
 =?utf-8?B?S250OCtmZ1g4NW4yRVMvWVpDSkpkbEY0M25INm1mUnN6WGs2WEg2cmJDMllr?=
 =?utf-8?B?YjZHTm9yZlduMXZpa1A3ckg0QzRyaDJKdE41SDM5WjZ1dnd2NDdaRE1mY1Jt?=
 =?utf-8?B?ZDVSMnBOWHBIRGd2Z1hsMEhMeFIyTkxkMVpDcmR5NTJEVzRxRHkvT0UreHJ6?=
 =?utf-8?B?UlRRTFRjUHdRNFpTcFg2bEJkajlOR2FhRFh4dXZyZGZjTTVFcXphTHR4N3NY?=
 =?utf-8?B?c2RnbXozQTNFaG5zQ1d2NlhVR2hxaTFNbEszd0dDUWpjV2VQV1VqVHJFVGJE?=
 =?utf-8?B?MHRVVGdod3J4eVF1QVZQSVNqQ3BCY0RnNmZKQ3FSYmRVZXJDSTFyeGg5aU9G?=
 =?utf-8?B?SnlDQ2NIOWdsTjdibytxNUc0bTJhejU4UEVTNloxNjcrMXAyQ1dqaEk1aXJk?=
 =?utf-8?B?Um92eTBLSGlVM09jc1hmNWRVVTJXTjJzNUVCc2p5T0laSkx3UE5DcXE2TXVG?=
 =?utf-8?B?YytyaHNpTXY3Z1VjR2wyWkhJSlg4OGR6UEFMR2h0dDlMS1NCL2djLzh0OWJa?=
 =?utf-8?B?T1lEWVFFcVcxS3BBaVpJdjY1VzdmMTFadFVVdVNVdUR2WUtyWU44cUw3TG9Q?=
 =?utf-8?B?QXE4NmwzUERjcWxtbDJ1Yk1XZ0xsWVNhaUNNcDJtREdKNGJVc0pQZk00TGxn?=
 =?utf-8?B?czV4bWFGYS9NK1gwb0dnZ0NlSDZvNm8wTENxWnZUR0EzUzMxSEJFUC9YdE5k?=
 =?utf-8?B?OWE4ckNuMERyK3NuLy9qb2ZtMitlVWUvclNhYTh1eXlkZER1OFVMUHUrdzJD?=
 =?utf-8?B?TVhqVXEzRUZVZHZDYVB5ekpHL1IzeHA2MmJEdTRPUWNmZ0NManpSalQ3WkVx?=
 =?utf-8?B?SFFrcW0xaGhycDZhQzErM0dheG1tTElQc3hPdWlneS9US1gzcVdwTzQ5MTNm?=
 =?utf-8?B?VFJZMUZ6ZlBUUFFjU1VnbkNCNjFiTUhqMy9hMS9DaEp1Rzd5UkxLVzVaL0dO?=
 =?utf-8?B?aENpcmNqa0hmTG5RclNIYXhxMW9wRTVHWmM2WHlCWmx1NW1aQmtSeE9ILzFQ?=
 =?utf-8?B?ODFUQmNldEFiUnNpME9aaFBjM1N0MEFEbkFRZys3M1JJQUg0ZmZnK1FIekxx?=
 =?utf-8?B?bTliRk9Sc09Ea2Y4dXRtRlE0RXI0bWFMLzNRejJnREZwVktIUThJaXcyS0VW?=
 =?utf-8?B?TkFBQTNvRVpEeWlEM2lReG5JNUpObUpuR0h3dDlHTGtaaFFTa1dYNE1QczNX?=
 =?utf-8?B?TE5ob1FmUm82M0tWUE5RYmNMNTE3RHhsSUxkQ1puVHkvMnVlS1VsVTRXenVH?=
 =?utf-8?B?MEFvMnV6b1RDUi9NbnljVmVkVVpwQlYrMkFrVzR4VHlKYlZHYjQ4aFhJZWRP?=
 =?utf-8?B?dU9OWE1mcU1NTk9aREVnZkJsQWVlRHNMT2NDUisvcVNTLzhjVzkwTTc0MU12?=
 =?utf-8?B?NW9UaDJaRUtDOEdjczIyWlJTK2FUOUxsOU5uRTJXS0VYczh0ZmhTMnZlU2FT?=
 =?utf-8?B?cGhiL0hrWDFZWWZlU2tiLzFmMW9iM1JhZHVNdlgvSFF0NkFRYm9rWEVSd1dr?=
 =?utf-8?B?ZzJUMXF1MDNFNUU0VytpQ2lPMm5ERllCcVdMUGhFdWMvM3ZldzE1Yk8xT0k2?=
 =?utf-8?B?S251TmhhQlB2WHd4RUExSFZxS1VLeFJFWis0Kzg0bEJaT3FtcDgvajNyNGVC?=
 =?utf-8?B?WEdFNFlpeElUYTIvZFdLTTI1dlF0USsvbGFrL05ZVUswbUcvdlh6RWxoRGxZ?=
 =?utf-8?B?QnU4VmZ4U1lHbVNhaUh4ZVh3WStkeHlPY3BLUkJLSVdvWUdodTY0U2xmMTBi?=
 =?utf-8?B?ZFF0T1d4ZWZUYnd5SGV2ZCt1clpudWRIS1I5VjNHZkVsL09KTnZIZS9jaHA5?=
 =?utf-8?B?Tm9DakJwYlRWdi9EMXNNL0RjY2FJUlRVUTFkNnljYStZdE1jL2h3Q21aS0N5?=
 =?utf-8?B?c1RvUS95SmU1K0Z2YXY2cGZXM2E4VmM3S2oxbGNPYWRBRHRab3c1NzRUUENI?=
 =?utf-8?Q?lYOUV761g59lWkrDFHrr8W47/?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: a686860f-de47-47e8-8fd3-08dd4c553627
X-MS-Exchange-CrossTenant-AuthSource: PH0PR12MB7982.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 13 Feb 2025 17:38:22.2705
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: M3xxMxE2ja/wk+iLrAqg3tIhS6NszgT5CVazzaEHr0NFzy89XDhXwgJ6eRm9PHjjQEcR71rfWhn8NZ7Yvpub5A==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH2PR12MB4134



On 2/12/2025 3:49 PM, Mohsin Bashir wrote:
> Caution: This message originated from an External Source. Use proper caution when opening attachments, clicking links, or responding.
> 
> 
> Add ethtool support to configure the IRQ coalescing behavior. Support
> separate timers for Rx and Tx for time based coalescing. For frame based
> configuration, currently we only support the Rx side.
> 
> The hardware allows configuration of descriptor count instead of frame
> count requiring conversion between the two. We assume 2 descriptors
> per frame, one for the metadata and one for the data segment.
> 
> When rx-frames are not configured, we set the RX descriptor count to
> half the ring size as a fail safe.
> 
> Default configuration:
> ethtool -c eth0 | grep -E "rx-usecs:|tx-usecs:|rx-frames:"
> rx-usecs:       30
> rx-frames:      0
> tx-usecs:       35
> 
> IRQ rate test:
> With single iperf flow we monitor IRQ rate while changing the tx-usesc and
> rx-usecs to high and low values.
> 
> ethtool -C eth0 rx-frames 8192 rx-usecs 150 tx-usecs 150
> irq/sec   13k
> irq/sec   14k
> irq/sec   14k
> 
> ethtool -C eth0 rx-frames 8192 rx-usecs 10 tx-usecs 10
> irq/sec  27k
> irq/sec  28k
> irq/sec  28k
> 
> Signed-off-by: Mohsin Bashir <mohsin.bashr@gmail.com>
> ---
>   drivers/net/ethernet/meta/fbnic/fbnic.h       |  3 +
>   .../net/ethernet/meta/fbnic/fbnic_ethtool.c   | 52 ++++++++++++++++++
>   .../net/ethernet/meta/fbnic/fbnic_netdev.c    |  4 ++
>   .../net/ethernet/meta/fbnic/fbnic_netdev.h    |  6 ++
>   drivers/net/ethernet/meta/fbnic/fbnic_txrx.c  | 55 ++++++++++++++++---
>   drivers/net/ethernet/meta/fbnic/fbnic_txrx.h  |  3 +
>   6 files changed, 115 insertions(+), 8 deletions(-)
> 
> diff --git a/drivers/net/ethernet/meta/fbnic/fbnic.h b/drivers/net/ethernet/meta/fbnic/fbnic.h
> index 14751f16e125..548e882381ce 100644
> --- a/drivers/net/ethernet/meta/fbnic/fbnic.h
> +++ b/drivers/net/ethernet/meta/fbnic/fbnic.h
> @@ -180,6 +180,9 @@ void fbnic_dbg_exit(void);
>   void fbnic_csr_get_regs(struct fbnic_dev *fbd, u32 *data, u32 *regs_version);
>   int fbnic_csr_regs_len(struct fbnic_dev *fbd);
> 
> +void fbnic_config_txrx_usecs(struct fbnic_napi_vector *nv, u32 arm);
> +void fbnic_config_rx_frames(struct fbnic_napi_vector *nv);
> +
>   enum fbnic_boards {
>          fbnic_board_asic
>   };
> diff --git a/drivers/net/ethernet/meta/fbnic/fbnic_ethtool.c b/drivers/net/ethernet/meta/fbnic/fbnic_ethtool.c
> index 20cd9f5f89e2..7a149d73edb5 100644
> --- a/drivers/net/ethernet/meta/fbnic/fbnic_ethtool.c
> +++ b/drivers/net/ethernet/meta/fbnic/fbnic_ethtool.c
> @@ -135,6 +135,54 @@ static void fbnic_clone_free(struct fbnic_net *clone)
>          kfree(clone);
>   }
> 
> +static int fbnic_get_coalesce(struct net_device *netdev,
> +                             struct ethtool_coalesce *ec,
> +                             struct kernel_ethtool_coalesce *kernel_coal,
> +                             struct netlink_ext_ack *extack)
> +{
> +       struct fbnic_net *fbn = netdev_priv(netdev);
> +
> +       ec->tx_coalesce_usecs = fbn->tx_usecs;
> +       ec->rx_coalesce_usecs = fbn->rx_usecs;
> +       ec->rx_max_coalesced_frames = fbn->rx_max_frames;
> +
> +       return 0;
> +}
> +
> +static int fbnic_set_coalesce(struct net_device *netdev,
> +                             struct ethtool_coalesce *ec,
> +                             struct kernel_ethtool_coalesce *kernel_coal,
> +                             struct netlink_ext_ack *extack)
> +{
> +       struct fbnic_net *fbn = netdev_priv(netdev);
> +
> +       /* Verify against hardware limits */
> +       if (ec->rx_coalesce_usecs >
> +           FIELD_MAX(FBNIC_INTR_CQ_REARM_RCQ_TIMEOUT) ||
> +           ec->tx_coalesce_usecs >
> +           FIELD_MAX(FBNIC_INTR_CQ_REARM_TCQ_TIMEOUT) ||
> +           ec->rx_max_coalesced_frames * FBNIC_MIN_RXD_PER_FRAME >
> +           FIELD_MAX(FBNIC_QUEUE_RIM_THRESHOLD_RCD_MASK))
> +               return -EINVAL;
> +
> +       fbn->tx_usecs = ec->tx_coalesce_usecs;
> +       fbn->rx_usecs = ec->rx_coalesce_usecs;
> +       fbn->rx_max_frames = ec->rx_max_coalesced_frames;
> +
> +       if (netif_running(netdev)) {
> +               int i;
> +
> +               for (i = 0; i < fbn->num_napi; i++) {
> +                       struct fbnic_napi_vector *nv = fbn->napi[i];
> +
> +                       fbnic_config_txrx_usecs(nv, 0);
> +                       fbnic_config_rx_frames(nv);
> +               }
> +       }
> +
> +       return 0;
> +}
> +
>   static void fbnic_get_strings(struct net_device *dev, u32 sset, u8 *data)
>   {
>          int i;
> @@ -586,9 +634,13 @@ fbnic_get_eth_mac_stats(struct net_device *netdev,
>   }
> 
>   static const struct ethtool_ops fbnic_ethtool_ops = {
> +       .supported_coalesce_params      = ETHTOOL_COALESCE_USECS |
> +                                         ETHTOOL_COALESCE_RX_MAX_FRAMES,
>          .get_drvinfo            = fbnic_get_drvinfo,
>          .get_regs_len           = fbnic_get_regs_len,
>          .get_regs               = fbnic_get_regs,
> +       .get_coalesce           = fbnic_get_coalesce,
> +       .set_coalesce           = fbnic_set_coalesce,
>          .get_strings            = fbnic_get_strings,
>          .get_ethtool_stats      = fbnic_get_ethtool_stats,
>          .get_sset_count         = fbnic_get_sset_count,
> diff --git a/drivers/net/ethernet/meta/fbnic/fbnic_netdev.c b/drivers/net/ethernet/meta/fbnic/fbnic_netdev.c
> index 1db57c42333e..8b6be6b60945 100644
> --- a/drivers/net/ethernet/meta/fbnic/fbnic_netdev.c
> +++ b/drivers/net/ethernet/meta/fbnic/fbnic_netdev.c
> @@ -618,6 +618,10 @@ struct net_device *fbnic_netdev_alloc(struct fbnic_dev *fbd)
>          fbn->ppq_size = FBNIC_PPQ_SIZE_DEFAULT;
>          fbn->rcq_size = FBNIC_RCQ_SIZE_DEFAULT;
> 
> +       fbn->tx_usecs = FBNIC_TX_USECS_DEFAULT;
> +       fbn->rx_usecs = FBNIC_RX_USECS_DEFAULT;
> +       fbn->rx_max_frames = FBNIC_RX_FRAMES_DEFAULT;
> +
>          default_queues = netif_get_num_default_rss_queues();
>          if (default_queues > fbd->max_num_queues)
>                  default_queues = fbd->max_num_queues;
> diff --git a/drivers/net/ethernet/meta/fbnic/fbnic_netdev.h b/drivers/net/ethernet/meta/fbnic/fbnic_netdev.h
> index a392ac1cc4f2..46af92a8f781 100644
> --- a/drivers/net/ethernet/meta/fbnic/fbnic_netdev.h
> +++ b/drivers/net/ethernet/meta/fbnic/fbnic_netdev.h
> @@ -12,6 +12,7 @@
>   #include "fbnic_txrx.h"
> 
>   #define FBNIC_MAX_NAPI_VECTORS         128u
> +#define FBNIC_MIN_RXD_PER_FRAME                2
> 
>   struct fbnic_net {
>          struct fbnic_ring *tx[FBNIC_MAX_TXQS];
> @@ -27,6 +28,11 @@ struct fbnic_net {
>          u32 ppq_size;
>          u32 rcq_size;
> 
> +       u16 rx_usecs;
> +       u16 tx_usecs;
> +
> +       u32 rx_max_frames;
> +
>          u16 num_napi;
> 
>          struct phylink *phylink;
> diff --git a/drivers/net/ethernet/meta/fbnic/fbnic_txrx.c b/drivers/net/ethernet/meta/fbnic/fbnic_txrx.c
> index d4d7027df9a0..978dce1e4eaa 100644
> --- a/drivers/net/ethernet/meta/fbnic/fbnic_txrx.c
> +++ b/drivers/net/ethernet/meta/fbnic/fbnic_txrx.c
> @@ -2010,9 +2010,53 @@ static void fbnic_config_drop_mode_rcq(struct fbnic_napi_vector *nv,
>          fbnic_ring_wr32(rcq, FBNIC_QUEUE_RDE_CTL0, rcq_ctl);
>   }
> 
> +static void fbnic_config_rim_threshold(struct fbnic_ring *rcq, u16 nv_idx, u32 rx_desc)
> +{
> +       u32 threshold;
> +
> +       /* Set the threshold to half the ring size if rx_frames
> +        * is not configured
> +        */
> +       threshold = rx_desc ? : rcq->size_mask / 2;
> +
> +       fbnic_ring_wr32(rcq, FBNIC_QUEUE_RIM_CTL, nv_idx);
> +       fbnic_ring_wr32(rcq, FBNIC_QUEUE_RIM_THRESHOLD, threshold);
> +}
> +
> +void fbnic_config_txrx_usecs(struct fbnic_napi_vector *nv, u32 arm)
> +{
> +       struct fbnic_net *fbn = netdev_priv(nv->napi.dev);
> +       struct fbnic_dev *fbd = nv->fbd;
> +       u32 val = arm;
> +
> +       val |= FIELD_PREP(FBNIC_INTR_CQ_REARM_RCQ_TIMEOUT, fbn->rx_usecs) |
> +              FBNIC_INTR_CQ_REARM_RCQ_TIMEOUT_UPD_EN;
> +       val |= FIELD_PREP(FBNIC_INTR_CQ_REARM_TCQ_TIMEOUT, fbn->tx_usecs) |
> +              FBNIC_INTR_CQ_REARM_TCQ_TIMEOUT_UPD_EN;
> +
> +       fbnic_wr32(fbd, FBNIC_INTR_CQ_REARM(nv->v_idx), val);
> +}
> +
> +void fbnic_config_rx_frames(struct fbnic_napi_vector *nv)
> +{
> +       struct fbnic_net *fbn = netdev_priv(nv->napi.dev);
> +       struct fbnic_q_triad *qt;
> +       int i, t;
> +
> +       t = nv->txt_count;
> +
> +       for (i = 0; i < nv->rxt_count; i++, t++) {
> +               qt = &nv->qt[t];

Tiny nit, but struct fbnic_q_triad's scope can be reduced to this for loop.

Another nit.. This logic is a bit confusing to me, but I'm not familiar 
with the fnbic driver, so maybe that's why.

Would something like this make sense? Then the need for the extra t 
local variable is removed as well.

for (i = nv->txt_count; i < nv->rxt_count + nv->txt_count; i++) {...}

> +               fbnic_config_rim_threshold(&qt->cmpl, nv->v_idx,
> +                                          fbn->rx_max_frames *
> +                                          FBNIC_MIN_RXD_PER_FRAME);
> +       }
> +}
> +
>   static void fbnic_enable_rcq(struct fbnic_napi_vector *nv,
>                               struct fbnic_ring *rcq)
>   {
> +       struct fbnic_net *fbn = netdev_priv(nv->napi.dev);
>          u32 log_size = fls(rcq->size_mask);
>          u32 rcq_ctl;
> 
> @@ -2040,8 +2084,8 @@ static void fbnic_enable_rcq(struct fbnic_napi_vector *nv,
>          fbnic_ring_wr32(rcq, FBNIC_QUEUE_RCQ_SIZE, log_size & 0xf);
> 
>          /* Store interrupt information for the completion queue */
> -       fbnic_ring_wr32(rcq, FBNIC_QUEUE_RIM_CTL, nv->v_idx);
> -       fbnic_ring_wr32(rcq, FBNIC_QUEUE_RIM_THRESHOLD, rcq->size_mask / 2);
> +       fbnic_config_rim_threshold(rcq, nv->v_idx, fbn->rx_max_frames *
> +                                                  FBNIC_MIN_RXD_PER_FRAME);
>          fbnic_ring_wr32(rcq, FBNIC_QUEUE_RIM_MASK, 0);
> 
>          /* Enable queue */
> @@ -2080,12 +2124,7 @@ void fbnic_enable(struct fbnic_net *fbn)
> 
>   static void fbnic_nv_irq_enable(struct fbnic_napi_vector *nv)
>   {
> -       struct fbnic_dev *fbd = nv->fbd;
> -       u32 val;
> -
> -       val = FBNIC_INTR_CQ_REARM_INTR_UNMASK;
> -
> -       fbnic_wr32(fbd, FBNIC_INTR_CQ_REARM(nv->v_idx), val);
> +       fbnic_config_txrx_usecs(nv, FBNIC_INTR_CQ_REARM_INTR_UNMASK);
>   }
> 
>   void fbnic_napi_enable(struct fbnic_net *fbn)
> diff --git a/drivers/net/ethernet/meta/fbnic/fbnic_txrx.h b/drivers/net/ethernet/meta/fbnic/fbnic_txrx.h
> index c2a94f31f71b..483e11e8bf39 100644
> --- a/drivers/net/ethernet/meta/fbnic/fbnic_txrx.h
> +++ b/drivers/net/ethernet/meta/fbnic/fbnic_txrx.h
> @@ -31,6 +31,9 @@ struct fbnic_net;
>   #define FBNIC_HPQ_SIZE_DEFAULT         256
>   #define FBNIC_PPQ_SIZE_DEFAULT         256
>   #define FBNIC_RCQ_SIZE_DEFAULT         1024
> +#define FBNIC_TX_USECS_DEFAULT         35
> +#define FBNIC_RX_USECS_DEFAULT         30
> +#define FBNIC_RX_FRAMES_DEFAULT                0
> 
>   #define FBNIC_RX_TROOM \
>          SKB_DATA_ALIGN(sizeof(struct skb_shared_info))
> --
> 2.43.5
> 


