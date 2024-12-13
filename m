Return-Path: <netdev+bounces-151671-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 4F7BA9F0846
	for <lists+netdev@lfdr.de>; Fri, 13 Dec 2024 10:43:03 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 83980188BE75
	for <lists+netdev@lfdr.de>; Fri, 13 Dec 2024 09:43:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E3F0F1B392E;
	Fri, 13 Dec 2024 09:42:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="dcSUHA5K"
X-Original-To: netdev@vger.kernel.org
Received: from NAM10-MW2-obe.outbound.protection.outlook.com (mail-mw2nam10on2076.outbound.protection.outlook.com [40.107.94.76])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 554FF1B2193;
	Fri, 13 Dec 2024 09:42:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.94.76
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734082978; cv=fail; b=ejljSF1X+9zrGYjDc9jFwKGZrflXh7pN1irxUy6cDYyCTeW/I7kCf0b/gfykbMG5xNqxGTBK6DmpkStIixwaiaamlmXd+xBZQHao3olDEwV8alXbU17y321CWEYPdCaQh2CNte7EZto48BlIZ5mx5szDjeBZYJqgyu/vC3XodJc=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734082978; c=relaxed/simple;
	bh=AG7HVcVKce5rRpAq+BKww8UFXS7yL+d0Ra2p0kVgloU=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=a6mE+BO7yLmPZTLyUrYJjJ9iNkBGEcdU5NiMzW6feCK1KQXmWPTLC1sydfDztYEQ+IJT+hTsZpfP5vRQGPf1LSYQ99W303yVPCg8qg/g3pmwPRifgAws3OjtuBMIgQtLlWkbHcTY3kdWuafxQ8neElxtdlm1pMpcPGZHCOKcNaA=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=dcSUHA5K; arc=fail smtp.client-ip=40.107.94.76
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=OXULL2l8cv5O9lYjFxNmq5EpqIXpvnuIZtQCv4mDyPKKU2qAdcw0gATEqtHbqWZ/bY2yZpuV5Fh5UImQ31TT993gzSbU+ty0XvIyRpgkMMYHyDHu9JHibtryrOV0jDw8PpNBHq2QdUruUtUkUeERXHJUGcvhqCYcQnfsJcxl4LLe24omFGsRJNe/9tKK/PGVS7e9eP/SrpKdMokcjCsxM2JDF/EoslndhJnLvLh431JPskiXzbkmUotgsWIvqCPmhncabSqjp0z8q3W6YJxDa+Bnto3GkDQnM4ic8KjT1FzD+GYxuY5XRPc5u/SB0lLRztg02h6W+G9QZS7Z11HKQA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=KcCJfar660mHUQkiE6pcQntiCutssxtwlssr/fleX14=;
 b=R4HYRIaWgSsPXbWpt9FV/4jmfu9zgdCPvd3rcaxMTdbw5G+muwFHHuuMefwNzSDKNtDn+xulwd44PkSil4FH1mii5esG5nWIb+fFYRi6yMPSh3BNQMjWS8zAmy89DOd5l78fPTI8IJzUKT4iBu4NqvG0syf2vAmQ2fyKh1mCCFx12PkJd1PeCsNvilD91l73eK0Lz10d9jKuS+SACgJiPV69Uee6C9RcWnJ0QgRE+8QfREVkevI4PfWwLP4yAcWyLD7T4owy0GJUcHez0gCqfV8HDLViT0C3u1Gp0NruWmDyuVk88DgGEK4dj9x7xUR9xvfUiqF88Whc8Jg1wAlWog==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=KcCJfar660mHUQkiE6pcQntiCutssxtwlssr/fleX14=;
 b=dcSUHA5KSD3eL6lNuphuU33JKvSjfScERL5HOhuli0Ko/wf2jfBAd6ZHCeoxD1wmpN1qyc/HHk6hgejmsUV+ekQFyaoN+wR3fYqSaMX0xHfhfSU3z06p0zXldN2IDXq7YjklGXPzaeHH69BzwIqHzwT7j/iP0Ml+GAMlCbIAxUk=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from DM6PR12MB4202.namprd12.prod.outlook.com (2603:10b6:5:219::22)
 by CH3PR12MB7738.namprd12.prod.outlook.com (2603:10b6:610:14e::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8251.17; Fri, 13 Dec
 2024 09:42:54 +0000
Received: from DM6PR12MB4202.namprd12.prod.outlook.com
 ([fe80::f943:600c:2558:af79]) by DM6PR12MB4202.namprd12.prod.outlook.com
 ([fe80::f943:600c:2558:af79%5]) with mapi id 15.20.8230.016; Fri, 13 Dec 2024
 09:42:54 +0000
Message-ID: <229f8d42-9252-eb48-0e89-2a8d7e076779@amd.com>
Date: Fri, 13 Dec 2024 09:42:49 +0000
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.11.0
Subject: Re: [PATCH v7 18/28] sfc: get endpoint decoder
Content-Language: en-US
To: Simon Horman <horms@kernel.org>, alejandro.lucero-palau@amd.com
Cc: linux-cxl@vger.kernel.org, netdev@vger.kernel.org,
 dan.j.williams@intel.com, martin.habets@xilinx.com, edward.cree@amd.com,
 davem@davemloft.net, kuba@kernel.org, pabeni@redhat.com,
 edumazet@google.com, dave.jiang@intel.com
References: <20241209185429.54054-1-alejandro.lucero-palau@amd.com>
 <20241209185429.54054-19-alejandro.lucero-palau@amd.com>
 <20241212182110.GA2110@kernel.org>
From: Alejandro Lucero Palau <alucerop@amd.com>
In-Reply-To: <20241212182110.GA2110@kernel.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: LO4P265CA0096.GBRP265.PROD.OUTLOOK.COM
 (2603:10a6:600:2bc::14) To DM6PR12MB4202.namprd12.prod.outlook.com
 (2603:10b6:5:219::22)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM6PR12MB4202:EE_|CH3PR12MB7738:EE_
X-MS-Office365-Filtering-Correlation-Id: 4eb41b51-9a7e-4e4b-ef71-08dd1b5a84a9
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|1800799024|376014|7416014;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?aWJXVk0rTEJpeXlsU1JFcVJIbE54M2ZLemhLdDEvYSt1M1ZiYU5zeUFkVFZ3?=
 =?utf-8?B?bTlYdFVMU0NwVUszRzYyN0hXQ1ZQYU9CTzJZZ1pkeDl3Z09aNlJOWmdJOEpU?=
 =?utf-8?B?TUpnRUFhZ0VrVDUybHNSbVdLdHV3eXZUTnQ3QXVidll5UzgrRjJKa2ZxT1Ny?=
 =?utf-8?B?ZXhOMndhS0dVZHJvWFlRMFMrOUM4WDRBbHkzeHVSMk90SUZOS0drTHFCN0Jh?=
 =?utf-8?B?Q3FSRjZRM0lVNFUySXlLd0NaTGlEYlYvcEoxWE9KT2p2RDAvY0N4RGdkNGl0?=
 =?utf-8?B?dHVkUjZKUFJHd1haTHBIOVo1NjZvQWdsSjBUeVNueU1EcUdmMjVIVDI1MGJG?=
 =?utf-8?B?RFpLS2V1K2piQnQ3VTYzb1RRQTJEOFRHMExHSm52MFplVnI2bENHWXRxblJ3?=
 =?utf-8?B?WVhrM3M3dTF2Qld2T1J0MWVyNFcwS29SY0hzcmhSWjRFMExXYWJQMzkyajJO?=
 =?utf-8?B?MTdlckpTUmpDY21xd1JEL1NaSFF5Y2tRSHNGTDBBVDJtSExNREpzQTlWNmpm?=
 =?utf-8?B?SU9Ub0RPWkRnYjVIR096YU1BTk1hM255MXNPc01vQzFRN1cwQW16MG1CTVRR?=
 =?utf-8?B?ckZwNnBjV2lmcUVpRmg2blhVQTVSQ2lYWGxjR0RqV2JnMXVwUXdtdW5EVnU4?=
 =?utf-8?B?N0RsWHF2U1BKeGRvTGM5QTB1aWtsYUNlYnVuR3NaYU94d0pBOG4yZURkdVJu?=
 =?utf-8?B?RWl0VzR0UFN2WkhMbnRwbFplelpIZkViUGZRSWNTRU5HanErd1cvU1drbUFw?=
 =?utf-8?B?elA4bEg4Nms1bTlFdXZxdU8zUkR0RU04eW1RZFBKeHpYTU1NdFFHUzE5ZTBv?=
 =?utf-8?B?WUl2cWRnejBvOGlkWmY4SlRLRDA5MzR3MnJqYTFkT25CWGVqUWFMYXM5dXhJ?=
 =?utf-8?B?RDdHUUVNVGFnOGpIdHJjNDFjV2pUZ1dxOFZTMkJNVDFISDI2VFM2MFJOL0xV?=
 =?utf-8?B?WGV1OG1XNWZXaExEMkJmeVdDNnQ3NXFPR3k1MEcvOFg1cytLbWZRc21CNFRX?=
 =?utf-8?B?M3MvTmZ5K202aUh2ZzdzYTZGZDVYM2MvUkpzbDRrVVpQL2d1M00rSVJIcWh2?=
 =?utf-8?B?elZYYm1JaUp2VFZZNHZ5K0UwZCtmUnBUQkZqamo5RGNtUXhEaTJ1dFo2c3lK?=
 =?utf-8?B?R2YzcWpVQXYva3NHNkErUXFpTDVOZXZGY05TdTJ3RkRydzBQV1dLK05hNkhy?=
 =?utf-8?B?K09GQkRHYmVuQ054SXJmK2htV2plVjFRazZlbUZjL0drbXM4MHRZT1YxRy85?=
 =?utf-8?B?MllRVEVIMDFPc0lLMTYvK2NLbVB4RDVPOTZBNHlaZVNZNTBNM0JZSVJGVVZZ?=
 =?utf-8?B?VmRtS3M1NjZaTDJiSUdiZTF5MnZhZ091UE84elJMNXdCNi8wWHRHalJ5ZGJ4?=
 =?utf-8?B?M2NiYjFuZEswOEFUNGl1cUJhYk81S1JaV1kyNUlabFV1ZDhlQjgzZitkeFBm?=
 =?utf-8?B?aG50ZUlWN2RlbHFpZDMzRFhIa1JFT09xM1hxbjN2c3Jaa01OTnNiUnRvTE9v?=
 =?utf-8?B?Yk02b25kU1h5a1JWQ2hrblZUZGdRN3dlRFhRUTY4Ynp5ZHhnUWtsWDZxWTdr?=
 =?utf-8?B?MVMzeE9SYm1SK0tKZGxHc0toLy90cnBUd2d0VFhGelVjaWhVemlySnViTTRS?=
 =?utf-8?B?TFF5MXo0VWtUQTdsc0RMYldESFFza1A4Vlk4eEIyb3U2cHJKWHBiRWhhYlV2?=
 =?utf-8?B?eGF2U2RrMTZVTFA5aTY5Z3NRVGJaZXBnSXdHdzhZN2dnZWtGVXdmM2p2VWlk?=
 =?utf-8?B?Z0lXODIzRTdJaWhuL2hyejFlNzYzbldzbkdZSFc4Z1pwSG1mQStNejdxT0Ji?=
 =?utf-8?B?VS9OaTdicjlCOTRrQVp4dz09?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM6PR12MB4202.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(376014)(7416014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?NFprYnR5YitqbVJSeUVITWRNVjZsdDFtenJYM0hRVGVjRTVPeFo0dGVZZlZU?=
 =?utf-8?B?OWxyamJkditwaERoSlhFOWlyK2NGRkNqMVhLYWYwOWdRYWRPWFB5TktWZWZQ?=
 =?utf-8?B?TDA0Tmd0d0pyZ3QrUE0yYmFkeE9EcGlPSmtsOVN1MjdrS3kyOWQ3UlM1Y0Vo?=
 =?utf-8?B?ZHVGOVUxd2FTZDBlaTJPbnZPSTBuMHlkbFdrOVllYWV6MW9FaURoajA0S1R0?=
 =?utf-8?B?aXorWDcxTGxHdFJ4ZWJmaHBuYnp3KzFUbk9QWDVvVVJSN3lYUmkyLzVrYWJO?=
 =?utf-8?B?dDNjVFI4b3JhQ0F4SzlSNTFYdzZDL1hOMWN6YjBvb0hrekkvaHc1L2Yvb25S?=
 =?utf-8?B?YjIvL2lpR01wd1ZmZDlnUm16cFg0OC95OWNNejkvZ0JNMjdab040VTJSLzVK?=
 =?utf-8?B?bnF0TXo2elF6eHA0M1VrRk5qdFpmcHdvMWIrWDNjdDB5SWxoYlpHQytPK0VZ?=
 =?utf-8?B?UHZhT1Zqc24yNWJGNW9LN0ljNFdVSmE0bTVtY3dxMUpodmNFTFpWaHJCb0Zt?=
 =?utf-8?B?NUwzblZYRTBPT1BoQmVPTUduckVDSzA5VVRFbk02TmsvaUErZk9YeVhlV0p2?=
 =?utf-8?B?ZFhIVW5jRmNVdlR6aXJoTEdmUXlkcXpmSGtER3RzUVk1TkgwTFZMbzRmZkY3?=
 =?utf-8?B?N2NkWXpFQ3FVWmQwTVFBOURBSG5WS2FLeUxTV3IvQ0ZVcUUwWGp3bGRTakZ0?=
 =?utf-8?B?UGk3aTBYVytGZFBBYzhGRjN6amdUM0JtQ24xdjAzYXd0QUVrN2VhSzZIM1Fu?=
 =?utf-8?B?WXJ6WG0yc1lyMmhyWkVEc0RFbkxxTExWK2lFUm9tcU43dGF5ekxDZjNMWFEx?=
 =?utf-8?B?QVBvYUZVVm56OEtMUS9QUGNLSXhjd2ZTWE96bVAxMGxCL2tzZVg4SVo3V25C?=
 =?utf-8?B?aHdJczBZMjY5eis3U213Lzg1eE8rSkdjN1VNVXRZMGJzLzkrM0lGOWRmQmJl?=
 =?utf-8?B?U2VMdHk4bXlHei9GMDIxa0pTbHZIK1ZzVXpWQUZ2YVNBaU5NT0VXWkV5ZDVF?=
 =?utf-8?B?dmkxN2RONXNIeVVlRmtqWm91M2czbXlobUtrcXZlT2ZPMEVneElzVUh2Y1NL?=
 =?utf-8?B?N01WbjRpcnJmbjNWN2w1YmoxRGVjakFGRnVFMHNMa2Qrb2lzRjRITFlIaVh5?=
 =?utf-8?B?V291Ni9OVWZlQ3hiTkYrTHRFNmVEOWVwYnVST1BLZ0JoSXgwblpJQVZ3TG5y?=
 =?utf-8?B?bVEvL2djKzkwdWwvSjNWRENHZWpZb0pUaWRHWEZqWHhkSHZ6VGErb3BYNW84?=
 =?utf-8?B?ZXJ3cys2UkRscXVwWFREU2J0N2N4cGJHdDVZNFpjNjlhL2t2clB1YWdVRHBF?=
 =?utf-8?B?ajlDSHV4Rm5aRytiOExQdkh5SndHOSthTW5OeVpYdURwRG1YNVkrSm5zZi9z?=
 =?utf-8?B?Rk5tQlAwUjY3a3Fhbm8yR2FlOEczYWtCMXVTdXRWVDRKd3NuOGhOME1XSFJ3?=
 =?utf-8?B?em9GdUlSell5V0gvNGoxdWRtL3dzamYreHUxbTUvanFTVGZXS3lXcWcrbTcx?=
 =?utf-8?B?VU4vM0ZraytBVHRYN3AxZm9peGdBRnMyUGJNVHkrZUNvSGhiWkxDS0QzejdY?=
 =?utf-8?B?a0Fwby9sS1RKZDNFVnJhYnJsTzZjY2ZMTW9CeXZoZUp3RTV3U3RBK1d5bDlr?=
 =?utf-8?B?bHVQNjdGeWJPaHJlcXRnQThNMjBLVUI1OVU3NVJHdURUWDY3UzVMMTZuZmRB?=
 =?utf-8?B?R2t3WEhyc05iazRjTVB4M1ZxWC9FQnZvZHVQY3NyTmFBb2Q4NEFmZ3BCS3p1?=
 =?utf-8?B?TUxvTEJnUTNFSms5RTEwaC9iR3MwZ3IwenpDSWVSU3lFTHNrOWwwRm9UR3h5?=
 =?utf-8?B?S3NxTkZVRWxIL0luL3I3Rk1aamo0Q3VaMEIzZFU1c3ZkZ0gyb085bEtrTUp1?=
 =?utf-8?B?K1g2b01ZK3NqYmtLL0xMSndWVHRtem56aDRqNksrZjY3c040SUlHeVNHd0ln?=
 =?utf-8?B?M0lGNWVqaTZTY1VuN3pvL2FmTU9IZWVKVEx2RXNHM0YyNTBxN212Z3FEN1hH?=
 =?utf-8?B?YXBUSmRBU1RoSnY1d3BWVjgvTlFaWllSUDl0N3VvMUErTEhUd3JFT01qNHVR?=
 =?utf-8?B?NXBuUU1UeWdOZ1FCQlorQWRRWUZJclJjaVpEVERrSlZ0cDRyVHVWVHY4Q1NT?=
 =?utf-8?Q?HbuaVfDV1W7t+kOP+VUizLBZz?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 4eb41b51-9a7e-4e4b-ef71-08dd1b5a84a9
X-MS-Exchange-CrossTenant-AuthSource: DM6PR12MB4202.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 13 Dec 2024 09:42:54.5635
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: QJ99eNGitQjzIsgItE/t1EuyLEvAhSsRmt+/o3hk7VnEAd0u+R3Qz1mvniPbfWKgqvSv0pnAk2pWAPD/xfpGuQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH3PR12MB7738


On 12/12/24 18:21, Simon Horman wrote:
> On Mon, Dec 09, 2024 at 06:54:19PM +0000, alejandro.lucero-palau@amd.com wrote:
>> From: Alejandro Lucero <alucerop@amd.com>
>>
>> Use cxl api for getting DPA (Device Physical Address) to use through an
>> endpoint decoder.
>>
>> Signed-off-by: Alejandro Lucero <alucerop@amd.com>
>> Reviewed-by: Martin Habets <habetsm.xilinx@gmail.com>
>> ---
>>   drivers/net/ethernet/sfc/efx_cxl.c | 9 +++++++++
>>   1 file changed, 9 insertions(+)
>>
>> diff --git a/drivers/net/ethernet/sfc/efx_cxl.c b/drivers/net/ethernet/sfc/efx_cxl.c
>> index f2dc025c9fbb..09827bb9e861 100644
>> --- a/drivers/net/ethernet/sfc/efx_cxl.c
>> +++ b/drivers/net/ethernet/sfc/efx_cxl.c
>> @@ -120,6 +120,14 @@ int efx_cxl_init(struct efx_probe_data *probe_data)
>>   		goto err3;
>>   	}
>>   
>> +	cxl->cxled = cxl_request_dpa(cxl->cxlmd, true, EFX_CTPIO_BUFFER_SIZE,
>> +				     EFX_CTPIO_BUFFER_SIZE);
>> +	if (IS_ERR_OR_NULL(cxl->cxled)) {
> Hi Alejandro,
>
> The Kernel doc for cxl_request_dpa says that it returns either
> a valid pointer or an error pointer. So perhaps IS_ERR() is
> sufficient here.
>
>> +		pci_err(pci_dev, "CXL accel request DPA failed");
>> +		rc = PTR_ERR(cxl->cxlrd);
> Otherwise, if cxl->cxlrd is NULL here, then rc, the return value for
> this function, will be 0 here. Which doesn't seem to align with the
> error message on the line above.


Indisputable.


I'll fix it.


Thanks!


> Flagged by Smatch.
>
>> +		goto err3;
>> +	}
>> +
>>   	probe_data->cxl = cxl;
>>   
>>   	return 0;
>> @@ -136,6 +144,7 @@ int efx_cxl_init(struct efx_probe_data *probe_data)
>>   void efx_cxl_exit(struct efx_probe_data *probe_data)
>>   {
>>   	if (probe_data->cxl) {
>> +		cxl_dpa_free(probe_data->cxl->cxled);
>>   		cxl_release_resource(probe_data->cxl->cxlds, CXL_RES_RAM);
>>   		kfree(probe_data->cxl->cxlds);
>>   		kfree(probe_data->cxl);
>> -- 
>> 2.17.1
>>
>>

