Return-Path: <netdev+bounces-258162-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id WERmG/Sei2noXAAAu9opvQ
	(envelope-from <netdev+bounces-258162-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Tue, 10 Feb 2026 22:11:16 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id BDC2F11F517
	for <lists+netdev@lfdr.de>; Tue, 10 Feb 2026 22:11:15 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 3DCEA3009FB4
	for <lists+netdev@lfdr.de>; Tue, 10 Feb 2026 21:10:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B7AE933342C;
	Tue, 10 Feb 2026 21:10:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="SqTCyn4X"
X-Original-To: netdev@vger.kernel.org
Received: from PH7PR06CU001.outbound.protection.outlook.com (mail-westus3azon11010004.outbound.protection.outlook.com [52.101.201.4])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 66832335BA8
	for <netdev@vger.kernel.org>; Tue, 10 Feb 2026 21:10:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.201.4
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770757844; cv=fail; b=TuACf3OUJ0EBf1gjw0Ui/lXIEr4ToaMibY2ChHNuGRmN6sqgnYcQQ2edPwMlOvTc14MNvbBcifh6Rq0S6R4SoxmHIdibMxv9pwUS9npXtMRbESK7D+u0CwF1LdwvGwvcyb03lW/+hxUJ4xZzEWOaQlZXEX20aY6yUqizmM4Gemw=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770757844; c=relaxed/simple;
	bh=b0q/85VAL0+/umZ9ovE5PuOF/L55ivprf/zkUA5CVlM=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=AxTdVtxvLYaPRqqLbu9w4Uo+YGrnzM1fT2ZrIIe37VSgeGtbiSkeDU355oKpyR1SVV5L1+DNGZh9eGsX1/PC+udpuK2APuAJnq050HGQk2DpkNUi0kmic6XK1Qi39ASFRugJbNe+gVfsolb713JSAF0AZEQNtpvmyPwLVM1Hu1Q=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=SqTCyn4X; arc=fail smtp.client-ip=52.101.201.4
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=wMvIOroFrBYdfMM6ZrvaGWjfV8SHHKQqBzfKNflkibkUh8N+QfTVcg/4ydV5GNSUSzHni+Pvqg4YbhOkvaRf2NrTMs82NM+48i651VxDaJk2nI887a4GAjQWNs5eqiot3mfV4mm8LWhIVY91eNrBDcXjXc1nH6Pm2yfzuLf66YqDTAFGohaISFXe9d3a7OVOWCxmT8JbUUrfoNybylskOLkYqdguaWT4oZoOvPNctCIgC4OEZ3MuChqFc+UcVmf8EkoJKn3nCkA8MLG7UuSMTe6mGYsrzglShqUBkB2oJ9eUh1wsz2ItvbADB3TifFCOcw8mXp9JRVLtwil7gSGnLA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=kGFf8PIHJ8esovxKexD086bHZZZizYo/VGUPb7Pms2w=;
 b=kXov10lWwdg3i6uwUUG+ta1tjnOez+NMTq8etLIH3bkwDS4FY1LQ+KXW4Zsjcng6itwZGFBZdiJCrxIiF8kDbkVTf1jRopwj1GP7e2PrkVuU3+YejQlytimmzhhQSmrjodUiWisAI08xKydyFcfNQ+aJb5F9AkQ5zxPDNkYrWS5/garn/RV2UI5MLHq8uwoTKYXt7vOcXwGHmH1bADBs1mjIqzxBt0eFWB8Ec64QVprHbeiZSBvbEVqSL2EPBEIC88KHxjG9VlLVj7Az9Xul9VyT3YoA+yFxhUwTkhL6Qsu+db1X6pto6h5bxEPPO94lZosJBm8KCUsjfVizj9yUyw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=kGFf8PIHJ8esovxKexD086bHZZZizYo/VGUPb7Pms2w=;
 b=SqTCyn4X0fXgR2paDDplww7mNCI1VDsTNOKehoeD+pSDsKAkHna7OH8c6e6UYcRhBXE3lCrAowxwBbKGiNMJAJvzT7woAunNR0yOIfBXsa2rEwuenk5ys+W0G7i8tYkrbJFTyN5JxmzW870yU5VGRgospJ4GvlGsyYs2Qoei/+g=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from MW6PR12MB8900.namprd12.prod.outlook.com (2603:10b6:303:244::19)
 by SA5PPFC3F406448.namprd12.prod.outlook.com (2603:10b6:80f:fc04::8e0) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9564.16; Tue, 10 Feb
 2026 21:10:39 +0000
Received: from MW6PR12MB8900.namprd12.prod.outlook.com
 ([fe80::ff2c:ccff:3267:b91]) by MW6PR12MB8900.namprd12.prod.outlook.com
 ([fe80::ff2c:ccff:3267:b91%6]) with mapi id 15.20.9587.017; Tue, 10 Feb 2026
 21:10:39 +0000
Message-ID: <64112a86-156e-43cf-8fa5-8038ea0037e9@amd.com>
Date: Tue, 10 Feb 2026 13:10:37 -0800
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net v2 2/2] xsk: Fix zero-copy AF_XDP fragment drop
To: Maciej Fijalkowski <maciej.fijalkowski@intel.com>
Cc: netdev@vger.kernel.org, magnus.karlsson@intel.com, sdf@fomichev.me,
 davem@davemloft.net, edumazet@google.com, kuba@kernel.org,
 pabeni@redhat.com, horms@kernel.org, kerneljasonxing@gmail.com,
 ",nikhil.rao"@amd.com
References: <20260209182642.237904-1-nikhil.rao@amd.com>
 <20260209182642.237904-3-nikhil.rao@amd.com> <aYpXxAowNQe99cEm@boxer>
 <aYtaioooXhsXVL0G@boxer>
Content-Language: en-US
From: "Rao, Nikhil" <nikhirao@amd.com>
In-Reply-To: <aYtaioooXhsXVL0G@boxer>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: BYAPR05CA0082.namprd05.prod.outlook.com
 (2603:10b6:a03:e0::23) To MW6PR12MB8900.namprd12.prod.outlook.com
 (2603:10b6:303:244::19)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MW6PR12MB8900:EE_|SA5PPFC3F406448:EE_
X-MS-Office365-Filtering-Correlation-Id: 87d76343-8a51-4ec0-cab5-08de68e8d7ae
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|1800799024|376014|7416014;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?WlE5alNJZEE0SEZuaFFqNVp2b1BPL0hJc2R3OElJb3FHZ2tVTTJjOXI2bEoy?=
 =?utf-8?B?bmZSNWdLZXQ5S1h6ZnFrNkJBU1F3RGc1U1hVZldyYXNILzlKNUlsWTJmZ0N6?=
 =?utf-8?B?MlJFOEJRMHZUZlNDelhVWFMwN2N3d1lTd0xYcm5Hc3dmSmFCclFLYUp5SHEy?=
 =?utf-8?B?bGQvS2pJd0pCaGZERFFmejk2RUFXb0tCYzVWMmQ0cXFCYytkYkd3ZFdRZ1FV?=
 =?utf-8?B?SU5kMHVET0JHTXdDNHlEYzV6SnZ5OFJOVE1yY3RuemhZaElvTjY5b1FEdUlr?=
 =?utf-8?B?NzVWQWNyMmJLdGFTdU1xbUE5cVQ4emNyWnk5TVhsejNyNGQySHhNVVowc0Jj?=
 =?utf-8?B?REtvWnB0NEExMi9sOXIzRW1CbHpPbWg4dTFJSGdKbDlZYjNNOWdTWXlJOGpT?=
 =?utf-8?B?d0IvVlVuQ1J3Zzc0UExrVVdXRm9TK1RaSWhSNHNHUUdueU1yL09wU3NrNU91?=
 =?utf-8?B?NWpBWXBwVnYwWUxMaHBSRTRhRVhOUnBjNTJKREFURWFZZDhNeTZWSzRCTHZz?=
 =?utf-8?B?NkxsdUwvUUlXdVpnVk9DVHpNNjZPUUFMNStJZXJScXlVeVAzLzZYWHc3R2FT?=
 =?utf-8?B?dGdBZk9uVmtqWjQwTVVQaG0rNEZ4N0krUDNNcnFFQmV6RklwL09pbTNGSFdJ?=
 =?utf-8?B?Ykt5SnJzaEtSa1dzRDVvbVRzMmxuY21ZVGVNR1FnT3FLOFlLY1R0dGVhdXE1?=
 =?utf-8?B?MnZLcFR2NEM3eGJpQ0JVRjlRV3VPKzBwSklCaVpFVXZkWFI3VWQ2SUZTRWNm?=
 =?utf-8?B?a1cxN0xGQkpyU2pVYzdDeVkyVEtqdkIxM2N5azZWV2pxUFdHT2VySVhxL1JS?=
 =?utf-8?B?UG0zM1hvTFdML3VubFNkenYyVUZuNnE2dTVvU1lnNVJyVzh5Mkx5ZkFpTFZV?=
 =?utf-8?B?d01BdHFPOUZoVWZPMXBrSlRzRWVpbUZFTzdxMDVoK0wxNXNncXVJays0SlN0?=
 =?utf-8?B?WmZ1ekxLK0ZWblJKaWdtNnVZa21UMWRoN1NOKzUvNEFMazV3a0VZOGRObWFt?=
 =?utf-8?B?NHBtOXFVL2Fqb1E0MmlZZE5WWSt1dGpwSW44aEVTOXhHanBNSXVidFZWcHFO?=
 =?utf-8?B?NTRmcHAveitwUGFiS0RZNXplOFRCRDRHd1h4Rll3ZUF6Y1pEV2o1VlUrQzNE?=
 =?utf-8?B?U1NLdHdyZE10YXdreVp6SUJMeDB0Sjkzb1p3dzgreWNhS0xmQlowdVZLVEJn?=
 =?utf-8?B?V25FTFZWZzZmZ3JHOUlHOFBlbzVPMS9tQi9sR0YxUW96WTc0c0o3bUk2ZFRk?=
 =?utf-8?B?REY0YUFSVjdmSGFXZk9jTHU2bTczaEI3eEtGdHNwS0ZlbStxSXowT05KNnZs?=
 =?utf-8?B?M3Y4U2RQaUVjOVUvc2QrRzdLK0M4b3dMTFpGTXpRazVITVp6UXJnVHAzcGhN?=
 =?utf-8?B?Q0xGbVNYUVhpZllaMWkvUG0zWnZWMGdSRExocGt0Umo3NVRHODBjMC9HSHdB?=
 =?utf-8?B?eis3V0tHMThZUTY2RUpWckt2S2FHZzlCRDczMDNGU0tPZzFYMUVDeGJXSEcr?=
 =?utf-8?B?Z1R4RXV6UGVOcXVlN3U3cnRHZzNkajFERlM2SmFvVzJKSnEzQlVBQnZSRWU5?=
 =?utf-8?B?VWFOcUpFSDBUWmxkMDgwckN0YWVIR25lSFVadjFqTU44enhxcG1WK2Q2RS84?=
 =?utf-8?B?azlqL1ZDdzFYLzJvM0s5K0I3eHcwN0RETE03WXU2SHdNUGk2OVdiMGYyWXps?=
 =?utf-8?B?cHNnejEwa0VCbW5TSFlLUmxrM0M5WUk0WXhNeHNLTlR4cXRPNitueS9JVXBr?=
 =?utf-8?B?bGU2UjRrRzJKWkhuSDZ5UmZya1VUSjMyYXpZc3o1NzBNOThCakxNOWtNN1VL?=
 =?utf-8?B?OUxBcnI1bEpKZGNPU3hhRmVPa2tteGo3SCtYK3VVNWtNclZZQUVjUmd0R1Fu?=
 =?utf-8?B?T1B1UFdzSU56T2paVmVkeitSeE9oa2xDcVFmV3MxNkZtTEw4eUhTbEtBeXRO?=
 =?utf-8?B?QW9JWjRnY21TTllMVmhWNEoxMUI1dmd6VkRoTTZHMWRvMVhMLzVwczNyNkZJ?=
 =?utf-8?B?RTdrbENiQktFYzROQzNSTEtqZ0lxbXU3S2NBemxwbDlCWnN0ZVJjZng1OGNH?=
 =?utf-8?B?dmMwdXJ0U1RIam5tTjVZamloOEN6VTBTN0hBc2Y3eTgvOFI3ZDgvY1diWllP?=
 =?utf-8?Q?qLCw=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MW6PR12MB8900.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(376014)(7416014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?UWt0N2Z6eUVCcGtwWXN4ZUpmSW9TUHlTY2NGNGlFZWwvSy9qNENkcnJJcWtD?=
 =?utf-8?B?aUxzTUZjUWFPdjV6bkdSbmM1WWVhUHhJZmZ1MWova2luaXhBZmF4cmsxYU94?=
 =?utf-8?B?NlArM1lQdXRxRzZuRm01WkMyV3FsY3BMVWJDck1sS0FqRkNOUTlJS1I4TFlN?=
 =?utf-8?B?UmRUdnpIZUgxVTlxbFNpTHFseWFza3EwNWFzNllaVi9LRTNXa0VtTWN4bmI5?=
 =?utf-8?B?WEVKK3pLTzFtT1BVRmlLa1k1U3BCR2YvdVJ4SEVyOTlDd01RZkt3U2phc3F6?=
 =?utf-8?B?VStTODAzYzZoZHFOTm5PcGlIR1FCc2hYaVlzS2JJRjlxRnpZRVpmMC8vcXJ1?=
 =?utf-8?B?QWYwREhEVFJWRk1Sb1c1NGdZcmI1N0VQcDM0MHcvWCtJVGFITk9SREpuZ2Zz?=
 =?utf-8?B?d1FDMDFocnBsd2daNTF0NklUVkU0WUkySzQrMXM0MVVpMVVBOFJRbEdLTEQr?=
 =?utf-8?B?Q2xhM2piUTgrSEpJWFZGWmU4bVVubUR2MTlVMVF4SEp1dnEwQmY3b1hjYUcr?=
 =?utf-8?B?Sll2VlAwY1BnVDRSNVIxMW4rY2c2NHJ2RjlnejNLNVZjWjVzeng1bWZybXFB?=
 =?utf-8?B?MjQyVlRBa0tneWt2aVhVZS9IYWNFc2Y3bGZ0RVQ1QUozbytEU2VGY242N0F3?=
 =?utf-8?B?ampqT2dXdDNTWitlZTRDcjJvQWJhaWdpbm1KcG1WUU1uREEwcW13MU5KQmlV?=
 =?utf-8?B?Q3FOei9vUmtxeDNlZm95QTFZbjFlckVhMUFWbHU1NWF6dlJqdEVzK3N1K2JP?=
 =?utf-8?B?TmRwZEtjZUZrSUQxZVcrUWpFNHU4aU1QZk9GQ3RHWFRRQ0Q0UXlnR2ZFYkdx?=
 =?utf-8?B?NFp0WkdPc0djV1NoaGVLelZLODU1RXRjSksrY0djUlFBemxXNk0yaTJCUys2?=
 =?utf-8?B?a2RkbmF6Y3JPYVZWRE5tMHM3cTVTZW5oTnY4MkNKL0ZZUW0zMk45aWhrNm51?=
 =?utf-8?B?N1MxOW44OXNJOHJoOFhYT2pFZFMyVDdVcGZDM0VZb0oyYnU2T2M4djhOalZG?=
 =?utf-8?B?ak8vdlhxWk5hNE9XbWQyWkFkSUkvMkNoZDJxdmt5K1JHM2w2MzFEUTFCaklJ?=
 =?utf-8?B?WitmYkJPTHcyTWF3STRRU1ZKRmZBRGk1VUZVUzhnTDhOVUJjV0FEWFkxUFpF?=
 =?utf-8?B?ejZDWFlKOTc0d1dDSy9IMlJtd0FVdmxtN2hyWm5KRUFsUjMyTmZNOVU2Ymor?=
 =?utf-8?B?aHlvRS9xUVVQdDIwaUNnOXNsdnYyUzJnUzhtMzJWN2dOcmdjbmFpY1dxN2o1?=
 =?utf-8?B?cnJUMGNyQjFzSVNCNUVnS2Q1R0M1Wnk1Q3F4RkV4ditSY3pRK2FlV3JTcWlC?=
 =?utf-8?B?UmZKc1pmdXN2V0NvcEdveW9KT2h1VkNIRHVoNk1RRmpkRk93R29TSEU1cWw4?=
 =?utf-8?B?Ty9EaFpIdWtVMHRBQ0VZS092WkRYcW5DZDNWSUZHSFpaamFlSzVGZUlCNVdo?=
 =?utf-8?B?cUlBSGxGWmUzWHd6ZW1vektLVDFNZndYYXVoNmF4OFJnZGc5WVhEM1ZJSmRT?=
 =?utf-8?B?MlluOEZoQjI1dS9CdXVTWGNndmk0ZXBLOEx5T1psMlF1ckJyL2xacVJGakZQ?=
 =?utf-8?B?TDUwQVBIbkluNHFEeGl3VVVPZzJNMU5sZDBacFMyeDJXRFY3ZXpwSFVmUkFp?=
 =?utf-8?B?RzlTa1FjOVdHLzY1SzZUQ2JTcmVSMDJWS0tWV0lJdDZ6Rnd0dGJPQytnQWNw?=
 =?utf-8?B?dmpmVzJna0w4S3Z3bHRMZ1hVaURYRGpiam9LNXVPTlUxVTB4VFgzTFRmQlVF?=
 =?utf-8?B?WTh0VlhOaTJDdUFaRWs1aXVJS2R6bzhyb3ZuWEdERE9mNXBQSEk2djFjSXlZ?=
 =?utf-8?B?dU1KWkhwaGtheFpHVzA3MTMxUTRnanptNi90cjkrbHBKd3pSQ1hYamJjb0h5?=
 =?utf-8?B?UkRDbCt5c0NFUWlybDRQWHkraWttdjJKZE54MlNQVndDcFl3eGZxTVhPa0lz?=
 =?utf-8?B?SytXWXpyVHdBbnlabG9hcHEyWVVuM1VMcG9BVHJkS3Z2MnhGR3A5Yk5hV21Y?=
 =?utf-8?B?VVVTbXBEMzd1b2tSK0ZGYUFBaDB2VDRnN3QxcE9RTmcwZzBsM3pvM0w3bDNK?=
 =?utf-8?B?Uld0Nk9xZnBjNDlGSFREdndWaFQ0dWlmaFkyOWlLUXIxeUFRYy9FeERPVUhx?=
 =?utf-8?B?VGt4RjM0Vy9raVRrL29QcDduNE93ZEtQbWZGWTZzN2l3Y1dVOVRleEU0MDlp?=
 =?utf-8?B?aTNMb2RLZlB3THAzR3BFTndxU2c1RmJKdjMwbUUrL2tyelZralkxZ1BoRU9Y?=
 =?utf-8?B?R3BzaHVCemxiVEpobUVsRFlrRVV2elBPQXA1OXVkVHhuQ0NrM3NNYTZNVFZC?=
 =?utf-8?B?ZUw2SXVhdk9MNVA1cnBEdnl4S3hQVEZyUVlzQzRPU0FQc0FlNWR1Zz09?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 87d76343-8a51-4ec0-cab5-08de68e8d7ae
X-MS-Exchange-CrossTenant-AuthSource: MW6PR12MB8900.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 10 Feb 2026 21:10:39.5146
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: O0o+bWHUPSG31EyOdHW8KeqzQ7VxOKwp2iaqPMQdMHXLx/TkzIKlTAUfWceV5d2EdQrqLcR9C8Qx/UQqiX/LTQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA5PPFC3F406448
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.16 / 15.00];
	ARC_REJECT(1.00)[cv is fail on i=2];
	DMARC_POLICY_ALLOW(-0.50)[amd.com,quarantine];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	R_DKIM_ALLOW(-0.20)[amd.com:s=selector1];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FREEMAIL_CC(0.00)[vger.kernel.org,intel.com,fomichev.me,davemloft.net,google.com,kernel.org,redhat.com,gmail.com,amd.com];
	TAGGED_FROM(0.00)[bounces-258162-lists,netdev=lfdr.de];
	FROM_HAS_DN(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	DKIM_TRACE(0.00)[amd.com:+];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[nikhirao@amd.com,netdev@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	RCPT_COUNT_SEVEN(0.00)[11];
	MID_RHS_MATCH_FROM(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,intel.com:email,amd.com:mid,amd.com:dkim,amd.com:email]
X-Rspamd-Queue-Id: BDC2F11F517
X-Rspamd-Action: no action


Sorry for the duplicate - sending without html this time.

On 2/10/2026 8:19 AM, Maciej Fijalkowski wrote:
> 
> On Mon, Feb 09, 2026 at 10:55:16PM +0100, Maciej Fijalkowski wrote:
>> On Mon, Feb 09, 2026 at 06:24:51PM +0000, Nikhil P. Rao wrote:
>>> AF_XDP should ensure that only a complete packet is sent to application.
>>> In the zero-copy case, if the Rx queue gets full as fragments are being
>>> enqueued, the remaining fragments are dropped.
>>
>> All of the descs that current xdp_buff was carrying will be dropped which
>> is incorrect as some of them have been exposed to Rx queue already and I
>> don't see the error path that would rewind them. So that's my
>> understanding of this issue.
>>
>> However, we were trying to keep the single-buf case as fast as we can, see
>> below.
>>
>>>
>>> Add a check to ensure that the Rx queue has enough space for all
>>> fragments of a packet before starting to enqueue them.
>>>
>>> Fixes: 24ea50127ecf ("xsk: support mbuf on ZC RX")
>>> Signed-off-by: Nikhil P. Rao <nikhil.rao@amd.com>
>>> ---
>>>   net/xdp/xsk.c | 22 +++++++++++-----------
>>>   1 file changed, 11 insertions(+), 11 deletions(-)
>>>
>>> diff --git a/net/xdp/xsk.c b/net/xdp/xsk.c
>>> index f2ec4f78bbb6..b65be95abcdc 100644
>>> --- a/net/xdp/xsk.c
>>> +++ b/net/xdp/xsk.c
>>> @@ -166,15 +166,20 @@ static int xsk_rcv_zc(struct xdp_sock *xs, struct xdp_buff *xdp, u32 len)
>>>      u32 frags = xdp_buff_has_frags(xdp);
>>>      struct xdp_buff_xsk *pos, *tmp;
>>>      struct list_head *xskb_list;
>>> +   u32 num_desc = 1;
>>>      u32 contd = 0;
>>> -   int err;
>>>
>>> -   if (frags)
>>> +   if (frags) {
>>> +           num_desc = xdp_get_shared_info_from_buff(xdp)->nr_frags + 1;
>>>              contd = XDP_PKT_CONTD;
>>> +   }
>>>
>>> -   err = __xsk_rcv_zc(xs, xskb, len, contd);
>>> -   if (err)
>>> -           goto err;
>>> +   if (xskq_prod_nb_free(xs->rx, num_desc) < num_desc) {
>>
>> this will hurt single buf performance unfortunately, I'd rather have frag
>> part still executed separately. Did you measure what impact on throughput
>> this patch has?
>>
>> Further thought here is once we are sure about sufficient space in xsk
>> queue then we could skip sanity check that xskq_prod_reserve_desc()
>> contains. Look at batching that is done on Tx side.
>>
>> Please see what works best here. Whether keeping linear part execution
>> separate from frags + producing frags in a 'batched' way or including
>> linear part with this 'batched' production of descriptors.
> 
> What I meant was patch below. However this is not a fix so I wouldn't
> incorporate it to your set. Maybe let's go with just processing linear
> part separately just like it used to be and then I can follow-up with this
> diff.
>
Agreed, this change can be implemented without any change to single buf 
performance.

Let me know if this looks good to you:

     if (frags) {

     } else {

         /* handle single buf */

     }

     /* handle multi-buf */

>>From 153e1bc5d2baf6328667956ae16d47103085eac8 Mon Sep 17 00:00:00 2001
> From: Maciej Fijalkowski <maciej.fijalkowski@intel.com>
> Date: Tue, 10 Feb 2026 13:39:17 +0000
> Subject: [PATCH bpf-next] xsk: avoid double checking against rx queue being
>   full
> 

