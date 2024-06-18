Return-Path: <netdev+bounces-104633-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 5771190DACB
	for <lists+netdev@lfdr.de>; Tue, 18 Jun 2024 19:40:37 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id F24A02828E8
	for <lists+netdev@lfdr.de>; Tue, 18 Jun 2024 17:40:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2946313FD72;
	Tue, 18 Jun 2024 17:40:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="TzWiLNrA"
X-Original-To: netdev@vger.kernel.org
Received: from NAM11-CO1-obe.outbound.protection.outlook.com (mail-co1nam11on2050.outbound.protection.outlook.com [40.107.220.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4A05A2139D8
	for <netdev@vger.kernel.org>; Tue, 18 Jun 2024 17:40:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.220.50
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718732433; cv=fail; b=hoiCIKnoyOb4Zd3UkVkdNB9Iooqe7JEtY2CAnKlrE+9Rj+sJ2ob0FSI+9lV7SD6A9EEhyo4I1aj4Id7FFHUFXxYDJNgcKvoY2F9q3Bpbxv4m/iySSKDELbA3TYQzlRQWIewpHZucqDUO7QTiTJGOdtZvHQngOD5kTGpLnZfkNTs=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718732433; c=relaxed/simple;
	bh=xA1NNj65fC6Ek/CfKPrrZL/CMPMpoTZyNA3a6p52wZ8=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=qRFo3s0RtJfwDN7BMYU/rD0lnAxnIQG2VWxaeFd7wTFLadKVYVff6OGwT3P032hXutWruMfKILnaAPUA/f0mThx6UMyyW9v9uPgwLG5wvNU58coiCi4d6zwqHKqRWc1dndNLb1Jl5kEemJwmN3179pdhyTMpLz1qsZDaIAOvueY=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=TzWiLNrA; arc=fail smtp.client-ip=40.107.220.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=B2CU7Mso+avpr/SymVSX6nXrxbfZIYTz7RGPvkJG6yTtD6e4f5xJNmkKVpNDfW0KfqU43pYj2FhA6z2uM7x4/SXaWlwKg5fFJ859fqps9xFATXpd2g4WDv2WY/o09PEeRcucxzNYi3kFJzS4HhUK+j9feTaDJo437HBXjcB47HroQGPCGEMaJ8wqbzCDgnMsoCYafZYLqY6TbDOqJzEUrdZ47YLL6YashfJH8AytNbjaJB62g0mcll/7AeGTZvu3nUupj+7FvBwEA0GFPsPT8Dr566eBffNk5Oz85zG1E1jaqRi1CgLccADXm/CIBwS96MxKt8ynODz+HD0ycsme3g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=3MpgJRkWuw/hW5fjKjOHSW6Wzcj5o6yF0lmE0OxHluE=;
 b=nAaUwXCeHe7/KCQKhKr5dv78iXE1zyC8P2hir4QHc0+8EWw6Kr110q7g3bPWWlM0RJrv/h4Iupu/h3NKAQHoPpwDL8r7AlkN1wlsoTLfaH80PRn6/ke1/1jJePZMKQJ34KyJ4ZHsBJjT3v4sA1p44xfhG2nHj1JxdVGiY5dJqJ7tFifTOICSBsowgMtphohvTjnFUsYfriBbJBYrW5aFJg7sptfjyxJQSVX8iA8qnedmpODn6KjP+LHSv2SUe760h4FmG6JUb9fQ3GTJLF9//9mDPQjBz6l5UAVLXw97+IuB5lFPYFvWG1wQ3d6zYvoHVSSYZfUYgQ8wHC3PZGPwRQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=3MpgJRkWuw/hW5fjKjOHSW6Wzcj5o6yF0lmE0OxHluE=;
 b=TzWiLNrAixtU7xJP/qIslKOQjKTSGD6wkSxOMkW0tFP/eNSEffqo1de0rzvYAH5/IP05FYrlUi6EN9w/4uH5cCH/i7qfvz2AXIp66QXhg8ssWM6wXU7SLHafRBt1UqWSOJXGiv1+pWs+1SwEcu5MFOlhvKsyrQgDwrdDa/Aw6Hw=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from DS0PR12MB6583.namprd12.prod.outlook.com (2603:10b6:8:d1::12) by
 SJ2PR12MB8955.namprd12.prod.outlook.com (2603:10b6:a03:542::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7677.28; Tue, 18 Jun
 2024 17:40:28 +0000
Received: from DS0PR12MB6583.namprd12.prod.outlook.com
 ([fe80::c8a9:4b0d:e1c7:aecb]) by DS0PR12MB6583.namprd12.prod.outlook.com
 ([fe80::c8a9:4b0d:e1c7:aecb%4]) with mapi id 15.20.7677.030; Tue, 18 Jun 2024
 17:40:28 +0000
Message-ID: <4bd3afe4-55c8-4a05-ade9-f9bd54f3211a@amd.com>
Date: Tue, 18 Jun 2024 10:40:26 -0700
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net] ionic: fix kernel panic due to multi-buffer handling
To: Taehee Yoo <ap420073@gmail.com>, davem@davemloft.net, kuba@kernel.org,
 pabeni@redhat.com, edumazet@google.com, brett.creeley@amd.com,
 drivers@pensando.io, netdev@vger.kernel.org
Cc: jacob.e.keller@intel.com
References: <20240618041412.3184919-1-ap420073@gmail.com>
Content-Language: en-US
From: "Nelson, Shannon" <shannon.nelson@amd.com>
In-Reply-To: <20240618041412.3184919-1-ap420073@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: SJ0PR03CA0202.namprd03.prod.outlook.com
 (2603:10b6:a03:2ef::27) To DS0PR12MB6583.namprd12.prod.outlook.com
 (2603:10b6:8:d1::12)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS0PR12MB6583:EE_|SJ2PR12MB8955:EE_
X-MS-Office365-Filtering-Correlation-Id: 8e09cc56-1ffd-4836-ccde-08dc8fbdbdeb
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230037|1800799021|376011|366013;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?bzJMZHh6cTVMRFRId21wTlVRaS9leGhkaE5haGZuOHFlNzRtdWVXYTlEajl0?=
 =?utf-8?B?VGt1RjlOdkRXdWE4SDNwZm5aMWJPVjg3N3VDTzNmQTQzVTUycXVqMkZZSld2?=
 =?utf-8?B?OXZpWGN6RjNBdXdRTDFzRmd1aHZFK0JxZkpXTHJJV1FRaks5a2Rta1R0YVpT?=
 =?utf-8?B?MFJWSlc3eVJoLzh4L01OTmJHcEN1cGtuN0JIaExZZm1NT2VFaGg1MWt2SkhT?=
 =?utf-8?B?K0dTV000bEZCZ1FZZmdySDR3eDA3Zm5rbmRTM0hCak5UYXJYNU1nVFpROUtx?=
 =?utf-8?B?UWI4Q1pEZWxhangvZVRUL0RBYzJDVEg3ZFVrT3doVnc5OFNaaVNoYVg2Q1Z4?=
 =?utf-8?B?TnpvcEJtWmZ5NHpvVzNuSzlSam0vdW13Q1U5dEJVSFBxYUdyRTFnREsxQ1Fw?=
 =?utf-8?B?UXRKWk1yQkttWGZOdzNvNWFVSjZ1WStVYU52VEJVRzhla3d0dUxxNERNb2Yr?=
 =?utf-8?B?RHNXQjNSUDBjZ09lczNuK1BheWxWdnhuYksxcFNxODErbVdPTjVhVjJOSnlX?=
 =?utf-8?B?bmM5UzRsNnhFK1paUlkzaXIwc3hodW5iaFl4TnUvRXRLRVNGQUVQM2V4UnA0?=
 =?utf-8?B?SjV5NXpWemswR2FPaDhQNXpsNE1aRTMvSzJ6UWRvMkxIRGwrNDRrSVA3ekFk?=
 =?utf-8?B?TDh3NHFpbDFtZ0lhQVFVMjhwb09XNktsUjh6Nk55RndHTE1oSXRxWFZxNnhn?=
 =?utf-8?B?SzJBTzBHSk94M1BPSWNGbTVUL0ZndG44eXZZbE9Ya3h0RDd6YVc2RUpFN0kv?=
 =?utf-8?B?VmU5RVd3QVloQ2tvcmh4ZXZlK3dPeUsydktXM1gxYXhzcVdKZ0I2cFdtb0Jj?=
 =?utf-8?B?TjI3aW50QS93UGxxNTkxUTBJTndzZ1hjWXNCcko4WDhrbnRBWWw5VXNBRkJ3?=
 =?utf-8?B?VEZWNDR4aE12dmtubUYxVVNRWDdLSEt5eFhKZ2t4TlpRSU9rdXpLWTA5cFMz?=
 =?utf-8?B?RGQ2RHNTQnBnZ1U4QlZja2piWGVJOXpjdGxLUSt5RHcrZFdQRjJwM2l3akZz?=
 =?utf-8?B?bGFEK3B6MGQ3OXFnWVJGVGw5aFZaTUpCb1k5MllCVGVqNnpNT3FxOEhxOHl3?=
 =?utf-8?B?NjZBZlptMTZVOUJMT2Rla2tYQlpUQ3kwZjBRWHN1cktYa2pVSmRZcGlpRVMv?=
 =?utf-8?B?eEkwQzZGTUpGUHhMQnRvZ1EvRHZMbU5mUERJcmtnbE9KODN3ZytXN2FyYjdk?=
 =?utf-8?B?Uitacjl4ZXNzTDJXUkZXcDFoZVlDNWwwLzEyam1lRWM3RXQzTWIzejB5bnl5?=
 =?utf-8?B?Ynh1bTFDVUtndzJHRUFFYWlsbnQ4R0Fwdlp5YzQxQ3d2WVd1T2luR1hXZHhC?=
 =?utf-8?B?NDVIWUZrSnJSa2RWWHg1MXgrVkRNczRoOFI1dkdKazBwTUZxSFdxTk1uT01K?=
 =?utf-8?B?dnp1bVpKUDRYQng4QjMwNi9oM2ZPTk9aUVNiWGl0SmNnUmxBQTc4cFF1WjNE?=
 =?utf-8?B?UFRxWTUrUU5jcG81WUhaTCtXT2x2a1lyVG9Xd0VpVXAySUZvK2dNMGkyZDBo?=
 =?utf-8?B?MWxpZjBzVWU1QmYzVUl2andJcmpaUmxpa2lXZWNVVGZwNzB5OE56bXhGRmxS?=
 =?utf-8?B?OTc3NU9pcE5PbDBvb2Q4SGYxSEF0OXF3Z01kSmRhdlBJUEVYL0pYajViSHZ3?=
 =?utf-8?B?VXFDemJ2bHdkWjRkNHYwckwzczdJUUxlc2orWU5hdTlhVEtWMXhEbDFZWUNl?=
 =?utf-8?B?Ri9ad25LcUJKWVJrRmkwdXVTdVNNZmcydHhiSjMxc2huM3NkRW5VaERQL2ZI?=
 =?utf-8?Q?EImnZTJFTIWrQggWA4=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DS0PR12MB6583.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230037)(1800799021)(376011)(366013);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?Nk9qeEJVbGlOb09pWnN2dWZBN2VXS0lrdHVORzJON0ZIYkhScU9rMXVFaXRs?=
 =?utf-8?B?bE56U0RyS3ROUUJ5WG9aam1hR3k5aU5hTU9OYkVSNEdWdmhxOXJuRWJxOFJ4?=
 =?utf-8?B?ZHlmemFEL0hMb2dXZG5saVFPUFV4N2hlZSswb1JKVmdOaG5oVDROTkNkS0JB?=
 =?utf-8?B?aTNIRDdDZ3ROTmFrMmRYSHV4UTJtSEY4SWwvV0NCeDlBM1g1Qk1lYkc3L3FO?=
 =?utf-8?B?bGJyREVDc3owZWVKM1I1TVpyc0dHcm15ZkdjQlJ4b1Jsa09SQVpSNWNCUnJy?=
 =?utf-8?B?ZHAvbHFuMmFwdGh4eGFzeVowQ0ZMbGUvR0kwVTN6WjVTa0RzQkVWK05zRDg5?=
 =?utf-8?B?UGFIZ2VVM0dGL1NmOHVDOERyam5ieko5Y0VuYk04TnV1Z3pFNVBFOEo4elJX?=
 =?utf-8?B?RUU0ZXUwZS9BOXplSVF1Yitta1h2cWZFRmpZN1VhbDQ2MVU3TjkzeWRTOW9x?=
 =?utf-8?B?blJmZzBWNndzN0pTenIrR05UbVpzSjBSeWhVR2xrZTlwTEE4VW1Xd3VtVzMx?=
 =?utf-8?B?U1hPdSt2QXAzMFJCakNZS0FqSjh0bzRMTWxlWUNPT2pEaWxWQzVEeGx1WXpH?=
 =?utf-8?B?dyttUHRlVjBmUkVKSGIwV0ZkYWVDam94cVY5SEIwUDI3S3d5TFBwcEJ5MGxW?=
 =?utf-8?B?NjN5VmxVeGNGaGtuSmNmYjArWXd0WDR2aUM4WnBmWlVzWTIzNFhKTnZSeWth?=
 =?utf-8?B?M1dMb1NQQkVrOUJZRytzdnVPanJPaGtZLzNaeEMyZmFhTWxXTTBFdUtZT0ZN?=
 =?utf-8?B?djA5ZGl3VXhHcEVvT1R4K0hFRXkzcDRhMTBWQmluOEVrRFhvZlB6OXdTZmhT?=
 =?utf-8?B?Vy81NUxVTkRCMHFTM1dzVW5VeWVTYklNTlZ0a1FQVmdPeGNrTzRZZHpQazVG?=
 =?utf-8?B?Y1A5RERuZjd1YzYwaUFBakc1Wm5tZTZRb0hTWmRGSkR4ZGloRzE4c2lHL0cw?=
 =?utf-8?B?QXVuODc4RkhxOHJpVW1aWStxWnBHaVA4Z1UxamtjZm02dSt2T1FjRDJ2cEFi?=
 =?utf-8?B?dlBid3RESEYzcUNkdzFhTjhHdXFFYjNWV2dQQVBhL0o5elUxUWNrUWJzVW4y?=
 =?utf-8?B?bks2VnVCRjIwdlJPZm9yYXlreDllRTBydkNweGRRdlNNcmpuNnVlZjBKYlM0?=
 =?utf-8?B?V25qNmRSU0svdVhOaXl6VWxKUm9TZ29HQmJQTURxRGxWRzFSWWxuWm93aWwv?=
 =?utf-8?B?S2xSbktYa3p0Y0ViL0xhTnM1ZWtBVlI2WWJhaVpsMFhoc25kWGlWWXdwNlBt?=
 =?utf-8?B?WmxCMlVidFI2R2Rmd3RHa1FWQTg2SVJpaXBGZEd4MnJEUTJmeWx3K2k5T05v?=
 =?utf-8?B?anc5WG9XZTNPUjJEbXkvUFg0ZHlJeElST2xuaUEvYStkZGlWWVAxZUV4UUE1?=
 =?utf-8?B?UVFEc2RCT21GeUpYS0dya2hJd2NWZVBuVS91NWViNUlRbUVOakZJdmtvbGY5?=
 =?utf-8?B?OUIxSnBBb3dVUlRXMDY2MjA3NU54cGdjZjRpSk9OdlFhcldxV05xSXRPdGxG?=
 =?utf-8?B?UDNXQ3oyVldScWRaeHdOQkJ2Mm9UcjFaR3gzR2s5VmdhRDhOc05qM1V2K1lQ?=
 =?utf-8?B?YTNKN3ZoMk9tWmhOQi9YaElyOEdVUTQ1dThPWVJlT1lEZVN6Y1E3akM1STRs?=
 =?utf-8?B?SW12NDRWcDZOMmR5eGdKamUvMzFsalFQY0s2U0RHbXAzb3dBMEJ6dlowRlBi?=
 =?utf-8?B?eEFrVFduVERtVTREc0RWVEVsb3A4cS9CQTQxNjhSRjYzTzJLZjJFV0RDN2Uz?=
 =?utf-8?B?Zm1IbHF4QS83d0RjVnY0WmRrdlo5Z1RzSkFzNUR3enhsTmFNbnBmbGNBQkd0?=
 =?utf-8?B?UHpsTzJab2M3cTV0VnJRdkFqdStyUGsvOEZwZ09nS1JiamNUQitFS3B6dG1q?=
 =?utf-8?B?VWRaaHBRVk1ZOEdtaVdVVVNFaXdzamRHaDVaZG9MS0JCS2M1L3BRc0VWaUtt?=
 =?utf-8?B?ekdON3F0cmFRcDltVUs4blRUWEZwZlNObjJ1RVFiSDFLTVlQdXBaRHNKZ2Fn?=
 =?utf-8?B?WlJQc1JXZ1RpM2hJZEgvczlHQmlkMFVoRW5KQi9KSUQ2NXF2SlFZTUI2TmNi?=
 =?utf-8?B?dkhJSmp1b1Y5WUhoMUR2WTNwZThmYk1PQURBaGNFUnR1TjJPVC9xZ2VCaFZW?=
 =?utf-8?Q?k8VhpMM9o1ojRFS7Xh4ZFwjTx?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 8e09cc56-1ffd-4836-ccde-08dc8fbdbdeb
X-MS-Exchange-CrossTenant-AuthSource: DS0PR12MB6583.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 18 Jun 2024 17:40:27.8958
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: qrv+t/GEEiAMhuXTeoXbCIvDgc/xjOWfNsw/GiWWhb95axMZaBHTEWmqls9X8NkTlwN8By+Nh7+8CV2WR1mRtg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ2PR12MB8955

On 6/17/2024 9:14 PM, Taehee Yoo wrote:
> 
> Currently, the ionic_run_xdp() doesn't handle multi-buffer packets
> properly for XDP_TX and XDP_REDIRECT.
> When a jumbo frame is received, the ionic_run_xdp() first makes xdp
> frame with all necessary pages in the rx descriptor.
> And if the action is either XDP_TX or XDP_REDIRECT, it should unmap
> dma-mapping and reset page pointer to NULL for all pages, not only the
> first page.
> But it doesn't for SG pages. So, SG pages unexpectedly will be reused.
> It eventually causes kernel panic.
> 
> Oops: general protection fault, probably for non-canonical address 0x504f4e4dbebc64ff: 0000 [#1] PREEMPT SMP NOPTI
> CPU: 3 PID: 0 Comm: swapper/3 Not tainted 6.10.0-rc3+ #25
> RIP: 0010:xdp_return_frame+0x42/0x90
> Code: 01 75 12 5b 4c 89 e6 5d 31 c9 41 5c 31 d2 41 5d e9 73 fd ff ff 44 8b 6b 20 0f b7 43 0a 49 81 ed 68 01 00 00 49 29 c5 49 01 fd <41> 80 7d0
> RSP: 0018:ffff99d00122ce08 EFLAGS: 00010202
> RAX: 0000000000005453 RBX: ffff8d325f904000 RCX: 0000000000000001
> RDX: 00000000670e1000 RSI: 000000011f90d000 RDI: 504f4e4d4c4b4a49
> RBP: ffff99d003907740 R08: 0000000000000000 R09: 0000000000000000
> R10: 000000011f90d000 R11: 0000000000000000 R12: ffff8d325f904010
> R13: 504f4e4dbebc64fd R14: ffff8d3242b070c8 R15: ffff99d0039077c0
> FS:  0000000000000000(0000) GS:ffff8d399f780000(0000) knlGS:0000000000000000
> CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
> CR2: 00007f41f6c85e38 CR3: 000000037ac30000 CR4: 00000000007506f0
> PKRU: 55555554
> Call Trace:
>   <IRQ>
>   ? die_addr+0x33/0x90
>   ? exc_general_protection+0x251/0x2f0
>   ? asm_exc_general_protection+0x22/0x30
>   ? xdp_return_frame+0x42/0x90
>   ionic_tx_clean+0x211/0x280 [ionic 15881354510e6a9c655c59c54812b319ed2cd015]
>   ionic_tx_cq_service+0xd3/0x210 [ionic 15881354510e6a9c655c59c54812b319ed2cd015]
>   ionic_txrx_napi+0x41/0x1b0 [ionic 15881354510e6a9c655c59c54812b319ed2cd015]
>   __napi_poll.constprop.0+0x29/0x1b0
>   net_rx_action+0x2c4/0x350
>   handle_softirqs+0xf4/0x320
>   irq_exit_rcu+0x78/0xa0
>   common_interrupt+0x77/0x90
> 
> Fixes: 5377805dc1c0 ("ionic: implement xdp frags support")
> Signed-off-by: Taehee Yoo <ap420073@gmail.com>
> ---
> 
> In the XDP_DROP and XDP_ABORTED path, the ionic_rx_page_free() is called
> to free page and unmap dma-mapping.
> It resets only the first page pointer to NULL.
> DROP/ABORTED path looks like it also has the same problem, but it's not.
> Because all pages in the XDP_DROP/ABORTED path are not used anywhere it
> can be reused without any free and unmap.
> So, it's okay to remove the function in the xdp path.
> 
> I will send a separated patch for removing ionic_rx_page_free() in the
> xdp path.
> 
>   .../net/ethernet/pensando/ionic/ionic_txrx.c  | 26 +++++++++++++++----
>   1 file changed, 21 insertions(+), 5 deletions(-)
> 
> diff --git a/drivers/net/ethernet/pensando/ionic/ionic_txrx.c b/drivers/net/ethernet/pensando/ionic/ionic_txrx.c
> index 2427610f4306..792e530e3281 100644
> --- a/drivers/net/ethernet/pensando/ionic/ionic_txrx.c
> +++ b/drivers/net/ethernet/pensando/ionic/ionic_txrx.c
> @@ -487,14 +487,13 @@ static bool ionic_run_xdp(struct ionic_rx_stats *stats,
>                            struct ionic_buf_info *buf_info,
>                            int len)
>   {
> +       int remain_len, frag_len, i, err = 0;
> +       struct skb_shared_info *sinfo;
>          u32 xdp_action = XDP_ABORTED;
>          struct xdp_buff xdp_buf;
>          struct ionic_queue *txq;
>          struct netdev_queue *nq;
>          struct xdp_frame *xdpf;
> -       int remain_len;
> -       int frag_len;
> -       int err = 0;

There's no need to change these 3 declarations.

> 
>          xdp_init_buff(&xdp_buf, IONIC_PAGE_SIZE, rxq->xdp_rxq_info);
>          frag_len = min_t(u16, len, IONIC_XDP_MAX_LINEAR_MTU + VLAN_ETH_HLEN);
> @@ -513,7 +512,6 @@ static bool ionic_run_xdp(struct ionic_rx_stats *stats,
>           */
>          remain_len = len - frag_len;
>          if (remain_len) {
> -               struct skb_shared_info *sinfo;
>                  struct ionic_buf_info *bi;
>                  skb_frag_t *frag;
> 
> @@ -576,7 +574,6 @@ static bool ionic_run_xdp(struct ionic_rx_stats *stats,
> 
>                  dma_unmap_page(rxq->dev, buf_info->dma_addr,
>                                 IONIC_PAGE_SIZE, DMA_FROM_DEVICE);
> -

You can leave the whitespace alone

>                  err = ionic_xdp_post_frame(txq, xdpf, XDP_TX,
>                                             buf_info->page,
>                                             buf_info->page_offset,
> @@ -587,12 +584,22 @@ static bool ionic_run_xdp(struct ionic_rx_stats *stats,
>                          goto out_xdp_abort;
>                  }
>                  buf_info->page = NULL;
> +               if (xdp_frame_has_frags(xdpf)) {

You could use xdp_buff_has_frags(&xdp_buf) instead, or just drop this 
check and let nr_frags value handle it in the for-loop test, as long as 
you init sinfo->nr_frags = 0 at the start.


> +                       for (i = 0; i < sinfo->nr_frags; i++) {
> +                               buf_info++;
> +                               dma_unmap_page(rxq->dev, buf_info->dma_addr,
> +                                              IONIC_PAGE_SIZE, DMA_FROM_DEVICE);
> +                               buf_info->page = NULL;
> +                       }
> +               }
> +
>                  stats->xdp_tx++;
> 
>                  /* the Tx completion will free the buffers */
>                  break;
> 
>          case XDP_REDIRECT:
> +               xdpf = xdp_convert_buff_to_frame(&xdp_buf);
>                  /* unmap the pages before handing them to a different device */
>                  dma_unmap_page(rxq->dev, buf_info->dma_addr,
>                                 IONIC_PAGE_SIZE, DMA_FROM_DEVICE);
> @@ -603,6 +610,15 @@ static bool ionic_run_xdp(struct ionic_rx_stats *stats,
>                          goto out_xdp_abort;
>                  }
>                  buf_info->page = NULL;
> +               if (xdp_frame_has_frags(xdpf)) {

If you use xdp_buff_has_frags() then you would not have to waste time 
with xdp_convert_buff_to_frame().  Or, again, if you init nr_flags at 
the start then you could skip the test altogether and let the for-loop 
test deal with it.

> +                       for (i = 0; i < sinfo->nr_frags; i++) {
> +                               buf_info++;
> +                               dma_unmap_page(rxq->dev, buf_info->dma_addr,
> +                                              IONIC_PAGE_SIZE, DMA_FROM_DEVICE);
> +                               buf_info->page = NULL;
> +                       }
> +               }
> +

Since this is repeated code, maybe build a little function, something like

static void ionic_xdp_rx_put_frags(struct ionic_queue *q,
				   struct ionic_buf_info *buf_info,
				   int nfrags)
{
	int i;

	for (i = 0; i < nfrags; i++) {
		buf_info++;
		dma_unmap_page(rxq->dev, buf_info->dma_addr,
			       IONIC_PAGE_SIZE, DMA_FROM_DEVICE);
		buf_info->page = NULL;
	}
}

and call this with
	ionic_xdp_rx_put_frags(rxq, buf_info, sinfo->nr_frags);


Meanwhile, before removing ionic_rx_page_free(), be sure to check that 
ionic_rx_fill() notices that there are useful pages already there that 
can be reused and doesn't end up leaking pages.

We have some draft patches for converting this all to page_pool, which I 
think takes care of this and some other messy bits.  We've been side 
tracked internally, but really need to get back to those.

Thanks,
sln

>                  rxq->xdp_flush = true;
>                  stats->xdp_redirect++;
>                  break;
> --
> 2.34.1
> 

