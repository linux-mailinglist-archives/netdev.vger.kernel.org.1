Return-Path: <netdev+bounces-122538-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 052BA961A04
	for <lists+netdev@lfdr.de>; Wed, 28 Aug 2024 00:27:26 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 262C8B22CE4
	for <lists+netdev@lfdr.de>; Tue, 27 Aug 2024 22:27:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 349691D2F6E;
	Tue, 27 Aug 2024 22:27:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="2IZT1TZj"
X-Original-To: netdev@vger.kernel.org
Received: from NAM11-BN8-obe.outbound.protection.outlook.com (mail-bn8nam11on2052.outbound.protection.outlook.com [40.107.236.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6DBE684D34
	for <netdev@vger.kernel.org>; Tue, 27 Aug 2024 22:27:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.236.52
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724797639; cv=fail; b=ZhcYVkD3KEzLqpceVrGsB3tHJRmuYYYuGRzT4CbMG0Hg+DmUhMTD9lSsiovxV00v+J2tLve3fVuGXXuRveR+jVe8lgmFX7w5J9KAbzAKZY/NahKAZemXWHr8g7ek2umNKgChyGSlaJ3S+zl6BTez+PaH+PPA5pjDJlhvBGYXfK8=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724797639; c=relaxed/simple;
	bh=dC4pKzPB78SaszYq8nwYENjVcbiZLN960rqt7pXbf6M=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=AQAMv41svQjvpXFI36aE9lqlLLz1pqTe7GJoXxeB1+ai1LYgHTrr4i3ezfoe3ZZPdlwNnBAg0XlRSgsvv58AsiLMHOi7mBy8BZL5Fgd5mYxzBIccMBvLe/my8fMOCm8a1a2mnsulYPHuMOJnu3ZvWbiQ0aE9YTVQD5IddSc+paE=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=2IZT1TZj; arc=fail smtp.client-ip=40.107.236.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=xzw/4jzQG/PKO9bzu6V7wMhjB93QMB1mUo1+lH1eMVVoxdVJ6FTsoTADoMPR1VKbnQeaxlFqhLL6TdoJ8ezsfR6u4E4Mf11ZYjCYWDAnp5YPYNfIOgenBksv0nOCs1NXQSBWKfKX/tK/tx6V1Z5/Ts4bddmv748Urw9hCFfzxbZHD+PoenE49rsJMzxwgt6jnGMjtveAoGs4oXkui7IEtBhPKF2rqQ8EEME2JTcpRsO0LAXYg2Xs9LiWwvynb6pUtXulJuMKmTNjaWIQ4/1NVTboE2/SBC2u+muBsSZoTuDB1Tvdco7ffR3tcddzky9+jWWJ4tePCwvBQmz8Jx972g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=h7z52HI6x6ZyONNLMRV/LgsdBG1CM1IIk4dbKoFMeE8=;
 b=NSznzzbSgadBtC0g/nx1KrA85JlfuqMw832fLG4A0G/TRrWBIOuWqRujsM4qUn6rYeSBhIarQ8Q6ZhzdVkjvyEQluAWzv0s8ECexc+k+dS13KUu6of4gbVr557s7Z1IzlntDuW6RDRMg992S/niwS3c/1QDNO9Cz5Hvo8v+hUNujD51MA5ZKBCZuPKNvweBf19g7D0uhnPtOi4nMg8AOWjlLBP3uV1Gm5NoD7BuQSsYoi4azmQYlZawadMagDOa87kU/i441r9fCzih8C6Jh0Ds68gBHkWN9d5oStaHYZazEruYcL74pg9ijrwCrWG7aVnUU9RlISatjuyeUdCInQA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=h7z52HI6x6ZyONNLMRV/LgsdBG1CM1IIk4dbKoFMeE8=;
 b=2IZT1TZj5u+nTw9Aj77OgVfvmM4NpEpIpiSllGRhzRhGr435lU8oKz5+VYKJIixZzdJqwHC9A5dgZuyn2K7tRxPAwVpDAfjlyrCjutNkIAtE+Jsa9pFH3ybsP2SahATouO8Ipr+kvAE+X+hETC2Xo9bdAbMQPpTYe9a5h4NFHWw=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from PH0PR12MB7982.namprd12.prod.outlook.com (2603:10b6:510:28d::5)
 by MW6PR12MB7070.namprd12.prod.outlook.com (2603:10b6:303:238::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7875.21; Tue, 27 Aug
 2024 22:27:13 +0000
Received: from PH0PR12MB7982.namprd12.prod.outlook.com
 ([fe80::bfd5:ffcf:f153:636a]) by PH0PR12MB7982.namprd12.prod.outlook.com
 ([fe80::bfd5:ffcf:f153:636a%3]) with mapi id 15.20.7897.021; Tue, 27 Aug 2024
 22:27:13 +0000
Message-ID: <33f605bc-e151-4494-8d54-a17a7fe31371@amd.com>
Date: Tue, 27 Aug 2024 15:27:11 -0700
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 net-next 3/5] ionic: use per-queue xdp_prog
To: Larysa Zaremba <larysa.zaremba@intel.com>,
 Brett Creeley <brett.creeley@amd.com>
Cc: netdev@vger.kernel.org, davem@davemloft.net, kuba@kernel.org,
 edumazet@google.com, pabeni@redhat.com, shannon.nelson@amd.com
References: <20240826184422.21895-1-brett.creeley@amd.com>
 <20240826184422.21895-4-brett.creeley@amd.com>
 <Zs28CpU2ZkglgUiZ@lzaremba-mobl.ger.corp.intel.com>
 <Zs2/N7K/IIATcANm@lzaremba-mobl.ger.corp.intel.com>
Content-Language: en-US
From: Brett Creeley <bcreeley@amd.com>
In-Reply-To: <Zs2/N7K/IIATcANm@lzaremba-mobl.ger.corp.intel.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: BYAPR03CA0002.namprd03.prod.outlook.com
 (2603:10b6:a02:a8::15) To PH0PR12MB7982.namprd12.prod.outlook.com
 (2603:10b6:510:28d::5)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH0PR12MB7982:EE_|MW6PR12MB7070:EE_
X-MS-Office365-Filtering-Correlation-Id: a4dd73f1-b9ae-4195-2085-08dcc6e765f4
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|376014|1800799024;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?NWRTZC95UEpmUkwwRXpXUnh5ZjBVQnQwbVZ2MWNLWnd1LzU2clF2RW1QbmY0?=
 =?utf-8?B?R0JKejluOHh1ZTV2dEpsbVFUbXB2aDRkMGZLRENLZDg5ZklEUlFVNzhmY2Rq?=
 =?utf-8?B?LytXd2Fua0pOWDlnakVTM3RBTnFPaFp6dnZObjFDdmhZaWxiak95S0RJLzQv?=
 =?utf-8?B?aUx1MWRER0dIYm0zNU5KcGJJWk5UMERadnVaSUErcFZYN0J5dTlxWUFGVUVF?=
 =?utf-8?B?L29ZcGRCOENzNmFYQzhNRENUWHpEY3JjUDhOdk5OMnpPdlZaYlk0bTdyaTVx?=
 =?utf-8?B?Z21QcllVM3kxTERET1FWWS9qYUkvdUUycUhvOTk5aDNpY1hVNXMvbHBpdmpO?=
 =?utf-8?B?MTlGWUdTekwvSUdSTFltTzdvelB4MFljcGNBTnhLNzdqSHJkcURScGczdENF?=
 =?utf-8?B?d0pLdWpUdUd2dno3ZXNlcHZJSnFhN01hd2hvUkdOMzl6ZjVWd0themtoV0hR?=
 =?utf-8?B?ajVpZXkxOUhhdUV6dklQUWp0anNqZ3dTM1ErNVpHVzRMTmQzKzhzTk40cmsr?=
 =?utf-8?B?R29DTnh5ZFpOLzlNeW9XdXhVTXcyVSs3NWdoeWMrQzVIa1JWTFpyZmxnZWx4?=
 =?utf-8?B?K3d5T1ZJZmtqUzF4ZFhjcWxoMnhkRWg1VHBnOGw5VzdjRjROTFE5WFdLMHV2?=
 =?utf-8?B?dnEyelpOWVg5Mkd5WFhtMk4zVCtob0d3OFNtRktWblVKVU1BcklEaUQ3OEtN?=
 =?utf-8?B?eXJhYWxjR29oMWZyekdtOWdFazJLcjQyZEl3RHNXZ3BNVXkwY2JlVTEwL1hC?=
 =?utf-8?B?QVNoUkZobWV5TkVNUkE2LzBtTUk3UTNaWVQ5T3RNRHFSdVZ6NHVlSSs4SWd5?=
 =?utf-8?B?Z2Nubk10dWFET1cvMHVmdXdBRlA5eUFsQ1lnUzMyc09QNDNRd09GYmt0WFVr?=
 =?utf-8?B?VS92U3JYc0Y4SEtQdTZvdHd4TGVVaCsyS3I2QzFMa3dza3IwamxjOHhySlE5?=
 =?utf-8?B?YXVQdjBUSWVnOUNRSGN3dGdLeUdLTEpBYTNMZFVRaE5pYjA5WkNuaWR2WmxC?=
 =?utf-8?B?a0puWDNSZElxb2g5U0pVQjV2WWcxNFRqSG5HWFBkTE9CMWNlNDJSL3VicVN4?=
 =?utf-8?B?T2ZzdnovZHhBRkEvdnhmN045OWtqZWRsZkpNZWUvWUw1VFZRaUZiY21IS3dk?=
 =?utf-8?B?Y1p2MTBlWndqNGd6Z0NuTWZ1OVY1eTNoMDUrdWUvZGZMZEhGaTkzeVpaaG5Z?=
 =?utf-8?B?QlJ1UnM4UW1XeUpMOTlFNWMwYzBHbmZkQXRDYVNkNjM2VDUvN3hQWXNsUlpa?=
 =?utf-8?B?ZTFkTU9hM2JlTEhjaUIyYnVYdmtKZDVtRTdoOHFtanU5cnVxOThxMnZTNmN1?=
 =?utf-8?B?MlN1OXhXM3VCRHNhSEU4amZsZ2pWcDZwR2FuVk42cDltSVJxekRnY3lOcGZy?=
 =?utf-8?B?TXlGRUk3VlZQRW9BYlpISDdYRVBEUmRhTy9LK2VpNStNUVRwdldWUXlQVzB5?=
 =?utf-8?B?bW5ZSU1YZUtCbGsxa0NkYk5EYndPWTFFa1pHM2QxN0k2T0ZpbWlNeWp4c3Zh?=
 =?utf-8?B?QVcyWjVPdjlxZ0hEdUJWanR1bHNGdGNQNzMzc2k1RmEvbzZCNFVMT0oxUE9m?=
 =?utf-8?B?R1VVeEFjVDFvV0tFR05kSGd5ZWI5MWNIR044WWhrZzgwOGdYOG9wOGwvQUNz?=
 =?utf-8?B?bjVPazdIOVNCN1A2MGd4SkZ2eUNiRWxEVHFRYWlUYjlvOXhSdStVTms1eGxn?=
 =?utf-8?B?VlJ1THhURkhGeFNqMmdYQ3VqRXAyTEVNKzFRUkVtNUdpUnZqd2JLajh6czla?=
 =?utf-8?B?dDRZSVZDVU83NUhSZVUyTS9JSm5kWXZqWGV2Q0pqYk9ZUGUyMCtBZEN2TjIx?=
 =?utf-8?B?TXNMM2tia09XSDFZZlIwQT09?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH0PR12MB7982.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(376014)(1800799024);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?ZldCTzJDNkVUUVd2ZmVieWh4SzJYdUhNNnZ5NUtRZ3BzZTlEODBqVlUzUWJk?=
 =?utf-8?B?cW5KTFBrOHZPZ3ZDa0JucmxzTDRzeG5ZbTNXdVN5VG9rbTZnUlBvb0g5RnFW?=
 =?utf-8?B?dlNyMG9TNEVsTVVwNmdzdUw0Lzg1Q0tidkYzYS9GZTI2Z3ozbjlPckQvQ1BH?=
 =?utf-8?B?WFZGUFJFdmtyZktVN1pId25FSHhCbnJGNWdaeFloWFhQTytLUUd4RHNnYTUx?=
 =?utf-8?B?M3loWnRNOWlFdUtzOHJnUHdMRmNvTHFxUGxrL3VncEF4RXRJVFRmQW5zNlVm?=
 =?utf-8?B?TG9heTlOS05oS1JGaVVUb0NCbEJpQllKOUltSnE2VW81VFNadnlsZjRlbUFM?=
 =?utf-8?B?SG1HMVF0cmZMc2ozTWRwUHpmRlordm9qMGlmWXFhWEo5a1NzVll1ZG4wanJ4?=
 =?utf-8?B?M0pLQ1N0NXVSN2pQMjdNRjdlTXllZnJaWlBoMHBFYUEvMXUrRjkvYzJqWnln?=
 =?utf-8?B?RndmU1BOa2I5UjRpcUQvYnlSYUhzWGRCeTMwUzBSSkdqdmdIcE9tazVBSHJ1?=
 =?utf-8?B?SG1kVDVGYW9rQ0h6ZDFwQkVadklmTnFncU1kQUpqb2JmVGxPekdva3oraVJU?=
 =?utf-8?B?YzJXWXhEejQyNDNpWWtjK0E5SkdyQncwdjJ3dlZrNGt0bi9IMUkwU2NHYlZW?=
 =?utf-8?B?R0Z1L1hvMHIzeFZwakoxRzNPZXNNdWdFMHV3eG9ud2xCSEE3Ym0ramhLUER0?=
 =?utf-8?B?QlZVbHN0T1FwMTdWaHpzR2xjUmJ5Z0ZXYkNVV3BoQ05YYndUaEl3RWJnN3FF?=
 =?utf-8?B?S05JR3B0cnl5VzJQT01QZUx6VU1LUzBXNXNwYStkcmRvUWthc25FR0FyMnE3?=
 =?utf-8?B?NWFoY1lFejZ5TWV3bWl3NXZMYmhXRzk1WU5xK0t3MjFGbE9NMGRrK2VucG85?=
 =?utf-8?B?OER3TWJYWG9SVHgyZWFTMlV6NmdHdU03Y1pKVVoya3EyMS9LN2hNVVhqcTZm?=
 =?utf-8?B?dWZxcWRlWGhhUTFHU2hiSXpNSXlGWmNyN3pBcVd2ZmNVV0ViMHBEY05FNlZP?=
 =?utf-8?B?d1ZBY0x5elJET09lRkx5Mmp0TStYUysxMXRpMmlTL0VYak1GSzZBeERDWkJR?=
 =?utf-8?B?MW5XRHpTcnl2MnhDZG5ZQzY5elZYblc3VzZqVEFnZTNQU3gwY2hyamRGNk80?=
 =?utf-8?B?dVljRzMyeFE4Q2R4V054aTZHa2NScFh4YmxrTjR2enZWd0VPNnN5VlNFT1pK?=
 =?utf-8?B?QXl0NTR5TTZYdzBMYVhjMXVsMUpzVUZBTWlRaWQzU0tqY1J6WFhCQ2hmajFw?=
 =?utf-8?B?SlFISkpKbXNTcWJEcXFRRDVmbXdmcFFjWmxlR2pGVDZLY3NvcGVSYlpqbHdW?=
 =?utf-8?B?MmlENkkvTkNTeXZVVlZBVG9ESUNWV3BOWGduZnArVEpwcGo2SkhJWmRidEdy?=
 =?utf-8?B?L2VUSGlZUkVtblVSWHR6M3M5V2RCRzNGeU5kbE13dGFzTWNxNDdoSk41Umtz?=
 =?utf-8?B?cmh1Kys3cmtPVnJQZ2VFTWhUTlRmWmZ5dTViMTdwQ3JKNFBxc3RqZkI4LytG?=
 =?utf-8?B?OFZvL1FCK3dNRVRMYVJNVE56RlJMVUVla3Z0SVJJRk9LNklMYTQ1bzhUNWVC?=
 =?utf-8?B?dHlLVTYxcndtS0xrWnJ6RTM2Nk1SVnBSeGdBczRzUkxDRUFrc1BJdUY1aDJa?=
 =?utf-8?B?ZnE3bXo5TGRMOUtLNy95MDZ2Umt5eWF2TU1TVk0yUkFpYnA1b3QxV0NYZXNw?=
 =?utf-8?B?dDdHdTJnSmxzVEpzZk8xV0pYUGtubDNHYW5RdWpHcDRDZUp2RGk4Z3N6bmEy?=
 =?utf-8?B?SExpWWVKL05OMm15dDliZ3BrNW5pazdYK1dFSFpsdVp1ZHBhNlViWHJ2Q1N2?=
 =?utf-8?B?Wk1lbXNBM3pFL3hPdzJFYitEMEJyM2x6Qlh3bFBVaVZDMEZoVVN6QVNXREtK?=
 =?utf-8?B?bU5ydXF6b0wyenNRYXREeVBwSGo4aHM3ZlJzeVl4N0F2c0grU2p3RC9BK3Qw?=
 =?utf-8?B?L2llZTBmNmNFMW9Ha1hUYm1OMXV0VW9laGhiU01tamdteXhrblRzbGFkNVFF?=
 =?utf-8?B?T1YxeXhrVFBBazBoMGk2ZXNETXJCYnhrM1c4c0V6TCtJTE05eW96Rk5IRVgy?=
 =?utf-8?B?cW16Z2huT0JmSE9HaFI5S3BYNHZ6Y2I5UHFKMjBHcitqcEszTU42NVptWnFM?=
 =?utf-8?Q?BGuhSkIn2nHcUQNJcI6WoujFL?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: a4dd73f1-b9ae-4195-2085-08dcc6e765f4
X-MS-Exchange-CrossTenant-AuthSource: PH0PR12MB7982.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 27 Aug 2024 22:27:13.4282
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: HrsD/WHs65umjxVQW2LX3DsWgTcnF2hgEWL7nkzWq52T6UUMzeLraq4AUStJsrMHn5WptgLhQtr2GxgDde5gwg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW6PR12MB7070



On 8/27/2024 4:57 AM, Larysa Zaremba wrote:
> Caution: This message originated from an External Source. Use proper caution when opening attachments, clicking links, or responding.
> 
> 
> On Tue, Aug 27, 2024 at 01:44:10PM +0200, Larysa Zaremba wrote:
>> On Mon, Aug 26, 2024 at 11:44:20AM -0700, Brett Creeley wrote:
>>> From: Shannon Nelson <shannon.nelson@amd.com>
>>>
>>> We originally were using a per-interface xdp_prog variable to track
>>> a loaded XDP program since we knew there would never be support for a
>>> per-queue XDP program.  With that, we only built the per queue rxq_info
>>> struct when an XDP program was loaded and removed it on XDP program unload,
>>> and used the pointer as an indicator in the Rx hotpath to know to how build
>>> the buffers.  However, that's really not the model generally used, and
>>> makes a conversion to page_pool Rx buffer cacheing a little problematic.
>>>
>>> This patch converts the driver to use the more common approach of using
>>> a per-queue xdp_prog pointer to work out buffer allocations and need
>>> for bpf_prog_run_xdp().  We jostle a couple of fields in the queue struct
>>> in order to keep the new xdp_prog pointer in a warm cacheline.
>>>
>>> Signed-off-by: Shannon Nelson <shannon.nelson@amd.com>
>>> Signed-off-by: Brett Creeley <brett.creeley@amd.com>
>>
>> Reviewed-by: Larysa Zaremba <larysa.zaremba@intel.com>
>>
> 
> I would like to rewoke the tag, see below why.
> 
>> If you happen to send another version, please include in a commit message a note
>> about READ_ONCE() removal. The removal itself is OK, but an indication that this
>> was intentional would be nice.
>>
>>> ---
>>>   .../net/ethernet/pensando/ionic/ionic_dev.h   |  7 +++++--
>>>   .../net/ethernet/pensando/ionic/ionic_lif.c   | 14 +++++++------
>>>   .../net/ethernet/pensando/ionic/ionic_txrx.c  | 21 +++++++++----------
>>>   3 files changed, 23 insertions(+), 19 deletions(-)
>>>
>>> diff --git a/drivers/net/ethernet/pensando/ionic/ionic_dev.h b/drivers/net/ethernet/pensando/ionic/ionic_dev.h
>>> index c647033f3ad2..19ae68a86a0b 100644
>>> --- a/drivers/net/ethernet/pensando/ionic/ionic_dev.h
>>> +++ b/drivers/net/ethernet/pensando/ionic/ionic_dev.h
>>> @@ -238,9 +238,8 @@ struct ionic_queue {
>>>      unsigned int index;
>>>      unsigned int num_descs;
>>>      unsigned int max_sg_elems;
>>> +
>>>      u64 features;
>>> -   unsigned int type;
>>> -   unsigned int hw_index;
>>>      unsigned int hw_type;
>>>      bool xdp_flush;
>>>      union {
>>> @@ -261,7 +260,11 @@ struct ionic_queue {
>>>              struct ionic_rxq_sg_desc *rxq_sgl;
>>>      };
>>>      struct xdp_rxq_info *xdp_rxq_info;
>>> +   struct bpf_prog *xdp_prog;
>>>      struct ionic_queue *partner;
>>> +
>>> +   unsigned int type;
>>> +   unsigned int hw_index;
>>>      dma_addr_t base_pa;
>>>      dma_addr_t cmb_base_pa;
>>>      dma_addr_t sg_base_pa;
>>> diff --git a/drivers/net/ethernet/pensando/ionic/ionic_lif.c b/drivers/net/ethernet/pensando/ionic/ionic_lif.c
>>> index aa0cc31dfe6e..0fba2df33915 100644
>>> --- a/drivers/net/ethernet/pensando/ionic/ionic_lif.c
>>> +++ b/drivers/net/ethernet/pensando/ionic/ionic_lif.c
>>> @@ -2700,24 +2700,24 @@ static int ionic_xdp_register_rxq_info(struct ionic_queue *q, unsigned int napi_
>>>
>>>   static int ionic_xdp_queues_config(struct ionic_lif *lif)
>>>   {
>>> +   struct bpf_prog *xdp_prog;
>>>      unsigned int i;
>>>      int err;
>>>
>>>      if (!lif->rxqcqs)
>>>              return 0;
>>>
>>> -   /* There's no need to rework memory if not going to/from NULL program.
>>> -    * If there is no lif->xdp_prog, there should also be no q.xdp_rxq_info
>>> -    * This way we don't need to keep an *xdp_prog in every queue struct.
>>> -    */
>>> -   if (!lif->xdp_prog == !lif->rxqcqs[0]->q.xdp_rxq_info)
>>> +   /* There's no need to rework memory if not going to/from NULL program.  */
>>> +   xdp_prog = READ_ONCE(lif->xdp_prog);
>>> +   if (!xdp_prog == !lif->rxqcqs[0]->q.xdp_prog)
>>>              return 0;
> 
> In a case when we replace a non-NULL program with another non-NULL program this
> would create a situation where lif and queues have different pointers on them.

Yeah, you are right. Good catch. We will get this fixed up in the next 
version.

Thanks,

Brett

> 
>>>
>>>      for (i = 0; i < lif->ionic->nrxqs_per_lif && lif->rxqcqs[i]; i++) {
>>>              struct ionic_queue *q = &lif->rxqcqs[i]->q;
>>>
>>> -           if (q->xdp_rxq_info) {
>>> +           if (q->xdp_prog) {
>>>                      ionic_xdp_unregister_rxq_info(q);
>>> +                   q->xdp_prog = NULL;
>>>                      continue;
>>>              }
>>>
>>> @@ -2727,6 +2727,7 @@ static int ionic_xdp_queues_config(struct ionic_lif *lif)
>>>                              i, err);
>>>                      goto err_out;
>>>              }
>>> +           q->xdp_prog = xdp_prog;
>>>      }
>>>
>>>      return 0;
> 
> [...]

