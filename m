Return-Path: <netdev+bounces-122784-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 13835962903
	for <lists+netdev@lfdr.de>; Wed, 28 Aug 2024 15:44:04 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 3A1561C2177C
	for <lists+netdev@lfdr.de>; Wed, 28 Aug 2024 13:44:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8B188187FFE;
	Wed, 28 Aug 2024 13:44:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="TPpBNrq3"
X-Original-To: netdev@vger.kernel.org
Received: from NAM12-BN8-obe.outbound.protection.outlook.com (mail-bn8nam12on2068.outbound.protection.outlook.com [40.107.237.68])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A2183178CEC;
	Wed, 28 Aug 2024 13:43:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.237.68
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724852640; cv=fail; b=IQKvlv3oFSqNDQtFEZjcHAZ9WBiUtLE2dpbeVB3ghZHDWzJsb0SQkxx84s3bIkLOp+/egjaQCeSVish4YeJbR1qezFZJQRTyjq6Ivb83rsO5Viti5ZNtrOce+J4ZB+E6yqdNg1inIjUbrLOCkdoebh3rIXqiWfdKEUK3Zenlb84=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724852640; c=relaxed/simple;
	bh=c8dgK+nZoKpIAC0NhSAvccguDZTq/71jva4eH8i3p9k=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=sV3Lmc7rJ8H27IBGquAcPq8bu586UsNJ3cmbL5JSMp0tRTXrI1t49Fq0IfqqhZe//oktSS2QeSQnzON4VLuNinrsavCzX3qMVlnQ4BSUgx7LHmrS2OINqRto6mkfj3ygJsgyLZRWE2eOF4+fGu7862D59KIRy5hfH0HcGFgAqqQ=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=TPpBNrq3; arc=fail smtp.client-ip=40.107.237.68
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=yKCpYPqwDLNJfCZwyKcUF3bIuJPYr6eZF9aLBLYMa2u+4jo/Obdf4lWDkIlpFg7ZbOKnaoxZ+kVZSMGoJAyTWIdZi6s0l9GMUl82x6MFnKFfrNQhF1Yqysdtk23p7tbrSss4tXaC5wDPcfa74p5R1krTEswMUSMIKAeP+hwfo0fj0JpeW9+sJpws8NzU7MpWW/bdCsGdKgrMIX7CjKEZ1G43obSh/Ij4HOFbfQRoaeKE5txGCwBdyMDH39ttHyXYu9tFeBSiVhpBLWUP4CpWvriYMCV2w3vMzQolCpvExjynX/79XRMUeF9fLigBe1LKDg2iZFltNxTjacil7ZDhhg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=kVP1tywk1E2yvsQmIjPby+1OuSlR4RtkDNjNg4/vXTc=;
 b=OO/ZhN13EVKlgcymLLhdAY2Qc86219vzzweiFFHR8vrTvYThEYzUcXrcHAef8OLlk9qnTFkVkLmtKUwp46Hgte7c9RyWwXsuVgBj6rRfP9kkZ1RRj0PaReMStapoH+3fkiM9fMaPNvF4phvEXOdtt58mWRNVgwz5FruuuoGgBlqU+VgtIeOk2alppLnQSApbB08QOexoBaqkNa78MM6CHBGOK/mXvLR6yihWrd0T7pGG+zJTwlkjFTT0fO34vXqNXyzlukk5i+MTepGvd71Wp3FG/cX7f9CTspg1CnSBtP0xP20y5ibKhaQBEc9/oPIpHHuv0fzHQHgzMy1SmdIdtA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=kVP1tywk1E2yvsQmIjPby+1OuSlR4RtkDNjNg4/vXTc=;
 b=TPpBNrq33nZD2w6VH6KdW1t5xl2b3XOS88g2QrbkIjafnzRii9roIh0V6okNVhYMmayKs32GVE7TELF9DsHOpiYa2HS8Ab4tXKSkwHrsKd2kTy1JsYcqGEWbsalJHhAZ+Wddep2X0uajCWh6MI8OhshhHPmzGH2ohKl7Jk5IFbo=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from DM6PR12MB4202.namprd12.prod.outlook.com (2603:10b6:5:219::22)
 by BL3PR12MB6594.namprd12.prod.outlook.com (2603:10b6:208:38d::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7897.27; Wed, 28 Aug
 2024 13:43:53 +0000
Received: from DM6PR12MB4202.namprd12.prod.outlook.com
 ([fe80::f943:600c:2558:af79]) by DM6PR12MB4202.namprd12.prod.outlook.com
 ([fe80::f943:600c:2558:af79%4]) with mapi id 15.20.7897.027; Wed, 28 Aug 2024
 13:43:52 +0000
Message-ID: <301642a1-ae97-7140-3b52-da0e6e69e7c7@amd.com>
Date: Wed, 28 Aug 2024 14:43:44 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.11.0
Subject: Re: [PATCH v2 08/15] cxl: indicate probe deferral
Content-Language: en-US
To: Zhi Wang <zhiw@nvidia.com>, alejandro.lucero-palau@amd.com
Cc: linux-cxl@vger.kernel.org, netdev@vger.kernel.org,
 dan.j.williams@intel.com, martin.habets@xilinx.com, edward.cree@amd.com,
 davem@davemloft.net, kuba@kernel.org, pabeni@redhat.com,
 edumazet@google.com, richard.hughes@amd.com, targupta@nvidia.com,
 vsethi@nvidia.com
References: <20240715172835.24757-1-alejandro.lucero-palau@amd.com>
 <20240715172835.24757-9-alejandro.lucero-palau@amd.com>
 <20240826204232.000009ce.zhiw@nvidia.com>
From: Alejandro Lucero Palau <alucerop@amd.com>
In-Reply-To: <20240826204232.000009ce.zhiw@nvidia.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: LO2P265CA0344.GBRP265.PROD.OUTLOOK.COM
 (2603:10a6:600:d::20) To DM6PR12MB4202.namprd12.prod.outlook.com
 (2603:10b6:5:219::22)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM6PR12MB4202:EE_|BL3PR12MB6594:EE_
X-MS-Office365-Filtering-Correlation-Id: edd8e6d3-7240-4e5a-791a-08dcc767744d
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|7416014|376014|1800799024;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?TEtteE9OT1hsQlUzUEZYeHNRb2VwdWhFZWtLaFZFMXJQWGpIQ0ZJSzloeTJ2?=
 =?utf-8?B?U1R1aFdyTzRBWURpZ2lXWHl2NGVpM0pLU29RRElaZFhMY1ZKY2c3RkdMYmsy?=
 =?utf-8?B?eEc4QmxSVDh3QWQzZkRiRm1pSTRpOGZzTTcrdDAyQ0RpTUJlSUVOTWU1OFJ0?=
 =?utf-8?B?NFZJaFNIUEg1VnN3WkVCMlE0MVgyd1R1YVJ1enZNZnJGZFJVSytQRDhuOXVO?=
 =?utf-8?B?bXpzZ2YzTkFtVE1GSzJkTWVuSlFMU2RnNmx1R01hMXVvbkZYdmNSaWxPdkcz?=
 =?utf-8?B?VHJrTEhFVVNIU0grWFZNQy9JSTFsVkoyc1FjSUJHbGQ1R215Zi95ZXR5NjlX?=
 =?utf-8?B?RWFhMDZML1ozdjhtOHR3YkZVQUN1akpqV3pDVHNhU3lEUDhjYWdBYjZJWXNn?=
 =?utf-8?B?dmRqQmlkME5ZK05zcDFJUlI3b0xnemg0eUt5UUdJTy9jQ1l3Wnp0OUtwdkpE?=
 =?utf-8?B?eUlQbU0razNxbjRlaFpwOFRZLzhhT1B2cW12UzhFdGlxUE5aazh0SHE3SFR2?=
 =?utf-8?B?a2JhdDZlWjg3WVk0anVEVWUrQUZRSWk5eEpCMzlXVndIS1JjSnhadFN2dDR5?=
 =?utf-8?B?ZTROanBvOW80bHVDZEdFaDdEbnJjSHFtMzlOYUdqQStnQUhwK1YrNHZWVFdY?=
 =?utf-8?B?L210V3lZa3VtdkRvSytBSWdGMTNJOE1VQW45ZCtQbnNMZVBYRjdVU1JWMGk5?=
 =?utf-8?B?cFFhL0g2Zko5QzNYRzhVRjYyYnRwWjJnUXhRSkZwOHVWdDdWTmtNWmFRSlJn?=
 =?utf-8?B?QitNdTJCaTNYcTN3NkZ6MWI2UTdXVGxFdThjdGxxRTVFdk81dlArbkxXYzNk?=
 =?utf-8?B?aTl5NXh1UURXSW1MdmZQbFVhNDFUTFA4WitaRkllTVZhOUwvTkMrSHNKeTU5?=
 =?utf-8?B?L0FVMzhIVk5Ia29pSVdMaXNkMVBkNURSTEtuN01XLzBDZGozQWxqdGIvTFND?=
 =?utf-8?B?S2ZOcWtRcExDa1J6UW1mQk9tblZWNnFLdm9xTVJjOFFMR0owMVBnMDBvMk1k?=
 =?utf-8?B?Q0VsQnkrMU1ablNxd3Ixc3E4ZGdqRVk2Um4zek50Z2tLaHRpdU8ycHNBUXBW?=
 =?utf-8?B?eHFOekZrVHB2V3VJZWNGSFc0Y0ptbitNU1lyMHpZSWtrZGtVZi9pWGxuSDQ2?=
 =?utf-8?B?Rk4vdGJTYk0xQ3hMS2FDVlMva1BoMXFOR1FpMnQ1VlZhWGppdzdTbUIrMHA4?=
 =?utf-8?B?RE1veWo1dXlTY2J3ZWVLSjBEbldsTUZsNCtQOVdjakpVeTVOZWJSUTlHbTly?=
 =?utf-8?B?UWxYNWJudVFTdUZ1SENjRzZIRXNaZThIdG8wZ3J6RWErWU11RFNKa2dYQ3ZO?=
 =?utf-8?B?S04wcG8rUk9yd0VHM0dMckh1VStESjgwWm9mNFFxeDF0b1k4TDl5S1Y3bEtS?=
 =?utf-8?B?MVA0UStTS01udkt0dHdpZ3ZtWDJGbEVKMGxDcjllMmRvVVZpZDlVOWZSM2wy?=
 =?utf-8?B?VlVwdFdLTzBENjlUT2o1NWtna0EyYjhsWTlCRUlTbTRGTFgzQkNreTF0U1ZX?=
 =?utf-8?B?ZEpnMWt4WTRubi8zV0x4a21uWmpGV1BxV3BmcnJFcXVNd3hRNm5aSTF1YmtC?=
 =?utf-8?B?UW03OVQ1N3QwcFZlZm80a3FiZUtKcXUzODJlWlkremFZL0s1QnVscjZCeWlH?=
 =?utf-8?B?WlNzcXBNRlRCOVp5cDZzUkszSHEyNXpxZGxEcXlHUmpvT05WOGNZTDR0REpt?=
 =?utf-8?B?UUlIRjA1bE11MldzMFdVQnMrUkxSZmR2WW0zeWtTclV0SzBtcGMrdnFxci9Q?=
 =?utf-8?Q?EHxkBqRnGJRIc/4cqw=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM6PR12MB4202.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(7416014)(376014)(1800799024);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?eDhMV2RLclpBWmhhZkd6cFpZajFHdXNTMjBJNmlKaG9YWGdJUW1idnVGeS90?=
 =?utf-8?B?UEcyUHZVY29iWG8veVlPMEtla0FmNjlTVjZMTDNwT2ttcjFNcFVHYmg2TUky?=
 =?utf-8?B?UXBUSnF5a2JFdWFsN2Yvb1JpLzFYODQ5clI4M2EzQm9DVFhZcThvbE5IVHZ5?=
 =?utf-8?B?SW9kalllVk10SEdxYUxPOVBGVlcwdWlQQjgxU1BIWGk4c3NUVjA4SEs5c1pQ?=
 =?utf-8?B?OGNyTlE1RzRpbnFlTEsyMDBYUmVKdVBldXpJUUlHTnFQMXkxbXp4WkdQc2pY?=
 =?utf-8?B?R1F6QjhTWWZyUFBwbGdYU2lacEJNVHBGTVRhSlMxcWMzVVBCNDVEellzczhP?=
 =?utf-8?B?NTh2T0VXUUxOSGtzaVVhNTZsVTQ1dmdSWWxwejk5NlRYWDVxRHk4S25pSzlu?=
 =?utf-8?B?ZVBoMjZuZi9QNGJKRno3TERTdDladmVlQ2ViUXhjdk5yY085ZlhSVk1valJi?=
 =?utf-8?B?Ung2Sm1XODFVVndacnBXNEdpMy9ua3d4WkxpaFJmMVhEc2lFYTZCekJ0RVE3?=
 =?utf-8?B?dllXY0t0MHZnRVlXZmdBbWJuYTdReUYwRHhBME5iK2pFcmRWdEErdys2THZp?=
 =?utf-8?B?ZDY5K1NTQmc5dEV4dWxzQ0RqYUUxMzZ2Zm5XVHk2QXJyTDUrTFNxUWFscUxL?=
 =?utf-8?B?TkFmWWVhbWk4b0JINXdNQU5UMkJyeHlDd3daNGtDQkprc0FNQ25SYUMxVmU1?=
 =?utf-8?B?UlNRMEg3dFNxOXlZdlg1MzhrRVlKWVNUd3hsRDFrN24yUVNKN0JMU0ZJNldS?=
 =?utf-8?B?bVBzSHROcS9ZWU9tNGJMK3BrTGFKVlJVVzNhRnNWL2I2WUE5M09aRXNMTlBP?=
 =?utf-8?B?OW4yRnl3ZGllL2kzaDFmaklZb2g0NnozWlF2VlhSNlU2NVowSHorMjJ0SnpY?=
 =?utf-8?B?alRGVldNa0s2K0Z3Q3FIb2QwTHRkclNLcmJnSGwzWlIvQW1wYzVKY3FFZTRN?=
 =?utf-8?B?Y01ZTm1QWTMxZTlkMDF5M2VYRHNQSFFqcnF5bS9nOHV6YlVETDFQUEdvV2Fk?=
 =?utf-8?B?L3pKdVdpd0ZEQ2dnV3FpSjRFN3hXUXEzSGhJemMyeTVNNnhvcFdrc0xFRjVO?=
 =?utf-8?B?bUJLelorcXQxRjRDOURHQ3pVMS8wK210VjhKS2VaSXNGRWxpK2I1MndRMTJa?=
 =?utf-8?B?VVUreVRpZktydndubWthWHBHM1lNZ3FiQzNxOTR2YnVqRFRvQzduM0hISkJ5?=
 =?utf-8?B?QVR1RlNsM0hYaWRJa0VHNlNUd1lxc0IwcnYzcXJjazZoMnFYaC9kNmZXMjBE?=
 =?utf-8?B?Q2VWOTU4QlZ0QmhBelgrQ0NRbkFmbXZkcG5CWGsrVTNZL1FsTTg2cmNodWZB?=
 =?utf-8?B?NUpLUUJiNGRVUlYzMmpNTTR0TUEvdGRjcHN1UVBmTHlBakdpZkxJNWVPakhy?=
 =?utf-8?B?UkM0N0ppMGRCYk1SNi8vdXAyZFRCOFJjaTQyblprUUVPVGFxVjc3dHFKN1JS?=
 =?utf-8?B?cHhkbkxIdVNXWWYzWUhvZklEdzUrTWxwdklYTTJ1OFZYTnRaV2VNdDhkVk5L?=
 =?utf-8?B?L2U0M01HYUNXYmtZT3JjcS8vNnFEcU5rVzhHa0dIM293SStpQlNyQ1NSSFNS?=
 =?utf-8?B?bzNKNDVHOWdzeWNyRkF0YWtmclgvOTNoYUFPZVNGR2I0NlMxK3JiYUw5ckZN?=
 =?utf-8?B?SUNKZnFjTUNVbWZoSG8yTllmZzJFYTUyTVhBZDFiVktFUlF3VEdlbXM3ZGli?=
 =?utf-8?B?TGgzdFlFcFhCM2duSDQrQlhPaHU4RldlU1FiTmhFTkQxQy9rVWtveVVNQ3lQ?=
 =?utf-8?B?MEo4NHUvaVFDQWRndkt6OGE1NWF3a3AyaEJyS3prM1NobXBZUHpSZHRwTFRq?=
 =?utf-8?B?TVcyUFkrNEJrRithWEhuUFJXK3FBd3pyVXQ1U25hQjRTU21PdzE4enlhUjJR?=
 =?utf-8?B?eTZhYUUvcWxtSDB3a3JydXZaYy9OZWtkNlViMVlKTmNQcWdFUmtVb1UwNFdN?=
 =?utf-8?B?MjdJK2dzUzhNcXgxdTZ6cnBTWDRyNFFpUTBsU3I4TDV1Rk1EdHkyTm80NW1X?=
 =?utf-8?B?a0duYmFzenp4elZqK0hsRW9abWNYSGMzTStISjk4NUkrZDRVQlJsdzR3NTZi?=
 =?utf-8?B?VkNoQis3aloxRENNMFpQMU43QkRGUEUyYmVhR0F5YkZDRS95QVVNbVd5Slg1?=
 =?utf-8?Q?vMI/D3ARv9vLj9kasLaFw4brK?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: edd8e6d3-7240-4e5a-791a-08dcc767744d
X-MS-Exchange-CrossTenant-AuthSource: DM6PR12MB4202.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 28 Aug 2024 13:43:52.8777
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 4jYNej+Sr2DaaAUh91ErxFBN4e+nSccNGwx74ezfTXRkCGFq5rQg/TAqz+tmJimwr/AsJpX7z9UHYAct8/L5bQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BL3PR12MB6594


On 8/26/24 18:42, Zhi Wang wrote:
> On Mon, 15 Jul 2024 18:28:28 +0100
> <alejandro.lucero-palau@amd.com> wrote:
>
>> From: Alejandro Lucero <alucerop@amd.com>
>>
>> The first stop for a CXL accelerator driver that wants to establish
>> new CXL.mem regions is to register a 'struct cxl_memdev. That kicks
>> off cxl_mem_probe() to enumerate all 'struct cxl_port' instances in
>> the topology up to the root.
>>
>> If the root driver has not attached yet the expectation is that the
>> driver waits until that link is established. The common cxl_pci_driver
>> has reason to keep the 'struct cxl_memdev' device attached to the bus
>> until the root driver attaches. An accelerator may want to instead
>> defer probing until CXL resources can be acquired.
>>
>> Use the @endpoint attribute of a 'struct cxl_memdev' to convey when
>> accelerator driver probing should be defferred vs failed. Provide that
>> indication via a new cxl_acquire_endpoint() API that can retrieve the
>> probe status of the memdev.
>>
>> The first consumer of this API is a test driver that excercises the
>> CXL Type-2 flow.
>>
> Out of curiosity, when and where do we probe CXL_DVSEC_CACHE_CAPABLE and
> enable the CXL_DVSEC_CACHE_ENABLE bit for a type-2 device?
>
> Thanks,
> Zhi.


As It is mentioned in the cover letter, this is a Type2 device but not 
working on CXL.cache yet.

I hope we can discuss how to deal with CXL.cache in the LPC next month. 
I'll be talking about it and current state of this patchset.

Thank you


>> Based on
>> https://lore.kernel.org/linux-cxl/168592149709.1948938.8663425987110396027.stgit@dwillia2-xfh.jf.intel.com/T/#m18497367d2ae38f88e94c06369eaa83fa23e92b2
>>
>> Signed-off-by: Alejandro Lucero <alucerop@amd.com>
>> Co-developed-by: Dan Williams <dan.j.williams@intel.com>
>> ---
>>   drivers/cxl/core/memdev.c          | 41
>> ++++++++++++++++++++++++++++++ drivers/cxl/core/port.c            |
>> 2 +- drivers/cxl/mem.c                  |  7 +++--
>>   drivers/net/ethernet/sfc/efx_cxl.c | 10 +++++++-
>>   include/linux/cxl_accel_mem.h      |  3 +++
>>   5 files changed, 59 insertions(+), 4 deletions(-)
>>
>> diff --git a/drivers/cxl/core/memdev.c b/drivers/cxl/core/memdev.c
>> index b902948b121f..d51c8bfb32e3 100644
>> --- a/drivers/cxl/core/memdev.c
>> +++ b/drivers/cxl/core/memdev.c
>> @@ -1137,6 +1137,47 @@ struct cxl_memdev *devm_cxl_add_memdev(struct
>> device *host, }
>>   EXPORT_SYMBOL_NS_GPL(devm_cxl_add_memdev, CXL);
>>   
>> +/*
>> + * Try to get a locked reference on a memdev's CXL port topology
>> + * connection. Be careful to observe when cxl_mem_probe() has
>> deposited
>> + * a probe deferral awaiting the arrival of the CXL root driver
>> +*/
>> +struct cxl_port *cxl_acquire_endpoint(struct cxl_memdev *cxlmd)
>> +{
>> +	struct cxl_port *endpoint;
>> +	int rc = -ENXIO;
>> +
>> +	device_lock(&cxlmd->dev);
>> +	endpoint = cxlmd->endpoint;
>> +	if (!endpoint)
>> +		goto err;
>> +
>> +	if (IS_ERR(endpoint)) {
>> +		rc = PTR_ERR(endpoint);
>> +		goto err;
>> +	}
>> +
>> +	device_lock(&endpoint->dev);
>> +	if (!endpoint->dev.driver)
>> +		goto err_endpoint;
>> +
>> +	return endpoint;
>> +
>> +err_endpoint:
>> +	device_unlock(&endpoint->dev);
>> +err:
>> +	device_unlock(&cxlmd->dev);
>> +	return ERR_PTR(rc);
>> +}
>> +EXPORT_SYMBOL_NS(cxl_acquire_endpoint, CXL);
>> +
>> +void cxl_release_endpoint(struct cxl_memdev *cxlmd, struct cxl_port
>> *endpoint) +{
>> +	device_unlock(&endpoint->dev);
>> +	device_unlock(&cxlmd->dev);
>> +}
>> +EXPORT_SYMBOL_NS(cxl_release_endpoint, CXL);
>> +
>>   static void sanitize_teardown_notifier(void *data)
>>   {
>>   	struct cxl_memdev_state *mds = data;
>> diff --git a/drivers/cxl/core/port.c b/drivers/cxl/core/port.c
>> index d66c6349ed2d..3c6b896c5f65 100644
>> --- a/drivers/cxl/core/port.c
>> +++ b/drivers/cxl/core/port.c
>> @@ -1553,7 +1553,7 @@ static int add_port_attach_ep(struct cxl_memdev
>> *cxlmd, */
>>   		dev_dbg(&cxlmd->dev, "%s is a root dport\n",
>>   			dev_name(dport_dev));
>> -		return -ENXIO;
>> +		return -EPROBE_DEFER;
>>   	}
>>   
>>   	parent_port = find_cxl_port(dparent, &parent_dport);
>> diff --git a/drivers/cxl/mem.c b/drivers/cxl/mem.c
>> index f76af75a87b7..383a6f4829d3 100644
>> --- a/drivers/cxl/mem.c
>> +++ b/drivers/cxl/mem.c
>> @@ -145,13 +145,16 @@ static int cxl_mem_probe(struct device *dev)
>>   		return rc;
>>   
>>   	rc = devm_cxl_enumerate_ports(cxlmd);
>> -	if (rc)
>> +	if (rc) {
>> +		cxlmd->endpoint = ERR_PTR(rc);
>>   		return rc;
>> +	}
>>   
>>   	parent_port = cxl_mem_find_port(cxlmd, &dport);
>>   	if (!parent_port) {
>>   		dev_err(dev, "CXL port topology not found\n");
>> -		return -ENXIO;
>> +		cxlmd->endpoint = ERR_PTR(-EPROBE_DEFER);
>> +		return -EPROBE_DEFER;
>>   	}
>>   
>>   	if (resource_size(&cxlds->pmem_res) &&
>> IS_ENABLED(CONFIG_CXL_PMEM)) { diff --git
>> a/drivers/net/ethernet/sfc/efx_cxl.c
>> b/drivers/net/ethernet/sfc/efx_cxl.c index 0abe66490ef5..2cf4837ddfc1
>> 100644 --- a/drivers/net/ethernet/sfc/efx_cxl.c +++
>> b/drivers/net/ethernet/sfc/efx_cxl.c @@ -65,8 +65,16 @@ void
>> efx_cxl_init(struct efx_nic *efx) }
>>   
>>   	cxl->cxlmd = devm_cxl_add_memdev(&pci_dev->dev, cxl->cxlds);
>> -	if (IS_ERR(cxl->cxlmd))
>> +	if (IS_ERR(cxl->cxlmd)) {
>>   		pci_info(pci_dev, "CXL accel memdev creation
>> failed");
>> +		return;
>> +	}
>> +
>> +	cxl->endpoint = cxl_acquire_endpoint(cxl->cxlmd);
>> +	if (IS_ERR(cxl->endpoint))
>> +		pci_info(pci_dev, "CXL accel acquire endpoint
>> failed"); +
>> +	cxl_release_endpoint(cxl->cxlmd, cxl->endpoint);
>>   }
>>   
>>   
>> diff --git a/include/linux/cxl_accel_mem.h
>> b/include/linux/cxl_accel_mem.h index 442ed9862292..701910021df8
>> 100644 --- a/include/linux/cxl_accel_mem.h
>> +++ b/include/linux/cxl_accel_mem.h
>> @@ -29,4 +29,7 @@ int cxl_await_media_ready(struct cxl_dev_state
>> *cxlds);
>>   struct cxl_memdev *devm_cxl_add_memdev(struct device *host,
>>   				       struct cxl_dev_state *cxlds);
>> +
>> +struct cxl_port *cxl_acquire_endpoint(struct cxl_memdev *cxlmd);
>> +void cxl_release_endpoint(struct cxl_memdev *cxlmd, struct cxl_port
>> *endpoint); #endif

