Return-Path: <netdev+bounces-188923-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 10E4EAAF646
	for <lists+netdev@lfdr.de>; Thu,  8 May 2025 11:04:42 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id E47D89E0A94
	for <lists+netdev@lfdr.de>; Thu,  8 May 2025 09:04:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4163E2222BD;
	Thu,  8 May 2025 09:04:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="AQhwxlSX"
X-Original-To: netdev@vger.kernel.org
Received: from NAM02-SN1-obe.outbound.protection.outlook.com (mail-sn1nam02on2042.outbound.protection.outlook.com [40.107.96.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8FEBE256D
	for <netdev@vger.kernel.org>; Thu,  8 May 2025 09:04:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.96.42
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746695078; cv=fail; b=FnuIO/6/a17hKfAO/gpDeNjYcqeOWCNAOlGwmLQB/esW8jSCboOTwkwB38Z/O3FvUG+DLjpW4cEcT4QAIFrR6qfqzK+TOSMsZPIL/1x7VMLaZGD0/lX0Zd4Oncq+po5uFuBPUuOSLkonMhzsw4dbJ+4qTCqOOUjld2mjEpwkKeQ=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746695078; c=relaxed/simple;
	bh=N0oOuXdU7dP62WP3tvBFWnKegsCY6MU3JDIKk7SlYsI=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=t9KdXLG0gRASOp+EK6amLso4uURHN1x9ovjHWgKhnG3nE3wRAOJKST/d9SHD2udqCZQWF8tS/E5nKjKLWfqT312LIRJ9SizXhwjQoxFZ5KGOradef/5J/GvqqwI9mRdbg6LPDaQ4e9TQB/7ii/sFnm7Jtukbv3+G4IsssbBFeDs=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=AQhwxlSX; arc=fail smtp.client-ip=40.107.96.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=XfvyYkll+Xs3G3nPeEITsxM6N8xnpivkxAhIl76iFweABiqoMhpcpz6fhGwllJTTYWo0gPgJ31NFWjzpgupatjSYOXqqljk4HPhonFwivwse5cxyornfby0wbMR2Fn2bMYUbh/reij8DTjK8yAtM7bqGzHzi7HEQtycZHNSYfqGbuTZQGVBn0xOX4MCwSd+Hl1oUlJsbvZbJGoU9vwqFdHAWOMbL8cxSFFsbfGzazYvuFHe8RvLG2NGuDD5QTHIBoLfTSF0YUtREO68mfGxYkAupr5XvE7ZfsQMdnaW1b5LCggudasbGucOpbYQHK9mZOeoITk33Ltg59F400M8+CA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=PczFitcMovXNRqbHgJ/mmhEC7aSwoJuMugi9TkIl3D0=;
 b=KAJcnZM/23eSdilLrHIJcw2Bd4J5qUBPjwCxFXIYnEEBln2YG5+Fn4hitFkpI62+PASU96VYgPsA300J3vd4aJLBdrbjSZd/cjGFjzRbk4BkR9S1xE/6iPbZqIkIPM0dVHjyjfpMwZe/cFHUzX4RPlg1Qk2dXCh9rNBIHyc0hTprixdJCDpIzDPWXv1yw1X8sQUM7dsHpBACNPCs3atarjvvEiARJa/ThB7mEAuNHrAa2L7ED3eQIP0pXWDR9cNsF30d8SSxSsxnu06B5VQPRdXnYH3bvIMICl+jf8S4AnauOuEDh00cnvvK2Nvt1PmKLPglyGnMDPp2Vi4qEZ5JWQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=PczFitcMovXNRqbHgJ/mmhEC7aSwoJuMugi9TkIl3D0=;
 b=AQhwxlSXXcVmwtraB0zIeNk5z+MLV+dsA/c/2SLoaUn6GgYchM9c5zFWcQFQAzaiEFjbeLWbdycSK8ikGLdeNbUzIAlPBWIXCt6dTtU8P2kVcgNiiNtFOFcNZ6MaUz3hgy3xwWqsccyGeFod1Ry6XAbBmNL+9C+sG532+fy8Zic5fD9SZQ4hFk+ZbnFKw11+s5zTcDSoi43xn3Lzi8qyNSw57eMNYI9HTpSuyZqMOo/QdEXA2VUyF0tGiO/7oUk237C5reYjuSWwVv92YyDjYtBMI1GKzCoIGDw7q8/UAQUNlmqNXBikdePTXPpqpwprvR721abWtxK6z3CK+cl7HA==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from CH3PR12MB7548.namprd12.prod.outlook.com (2603:10b6:610:144::12)
 by DS2PR12MB9568.namprd12.prod.outlook.com (2603:10b6:8:27c::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8699.25; Thu, 8 May
 2025 09:04:29 +0000
Received: from CH3PR12MB7548.namprd12.prod.outlook.com
 ([fe80::e8c:e992:7287:cb06]) by CH3PR12MB7548.namprd12.prod.outlook.com
 ([fe80::e8c:e992:7287:cb06%3]) with mapi id 15.20.8722.018; Thu, 8 May 2025
 09:04:29 +0000
Message-ID: <bee1e240-cc6a-4c30-a2ae-6f7974627053@nvidia.com>
Date: Thu, 8 May 2025 12:04:22 +0300
User-Agent: Mozilla Thunderbird
Subject: Re: [RFC net-next 0/5] devlink: Add unique identifier to devlink port
 function
To: Jakub Kicinski <kuba@kernel.org>
Cc: Moshe Shemesh <moshe@nvidia.com>, netdev@vger.kernel.org,
 "David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>,
 Paolo Abeni <pabeni@redhat.com>, Simon Horman <horms@kernel.org>,
 Donald Hunter <donald.hunter@gmail.com>, Jiri Pirko <jiri@resnulli.us>,
 Jonathan Corbet <corbet@lwn.net>, Andrew Lunn <andrew+netdev@lunn.ch>,
 Tariq Toukan <tariqt@nvidia.com>
References: <1745416242-1162653-1-git-send-email-moshe@nvidia.com>
 <20250424162425.1c0b46d1@kernel.org>
 <95888476-26e8-425b-b6ae-c2576125f484@nvidia.com>
 <20250428111909.16dd7488@kernel.org>
 <507c9e1f-f31a-489c-8161-3e61ae425615@nvidia.com>
 <20250501173922.6d797778@kernel.org>
 <d5241829-bd20-4c41-9dec-d805ce5b9bcc@nvidia.com>
 <20250505115512.0fa2e186@kernel.org>
 <c19e7dec-7aae-449d-b454-4078c8fbd926@nvidia.com>
 <20250506082032.1ab8f397@kernel.org>
 <aa57da6b-bb1b-4d77-bffa-9746c3fe94ba@nvidia.com>
 <20250507174308.3ec23816@kernel.org>
Content-Language: en-US
From: Mark Bloch <mbloch@nvidia.com>
In-Reply-To: <20250507174308.3ec23816@kernel.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: FR0P281CA0175.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:b4::9) To CH3PR12MB7548.namprd12.prod.outlook.com
 (2603:10b6:610:144::12)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CH3PR12MB7548:EE_|DS2PR12MB9568:EE_
X-MS-Office365-Filtering-Correlation-Id: 499a94a7-9db4-4790-58cd-08dd8e0f567a
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|1800799024|7416014|376014;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?N1pWMlpwWGIxcGZQTGEra1RnVk9mazVpY1NhNWFMZUtodGpMY2U0aEhaMWdI?=
 =?utf-8?B?TFdLcmU3Y3VmRlJ5SGVKc0ZMb2dBZjVBNHNMSjFGVUVtVk5IRENBUWFrQTdP?=
 =?utf-8?B?NHorN1JLVTRCWlJuUmFRM3krdkNtM3BVNnJNa21xR3dtZUxuN213R2k3bXVU?=
 =?utf-8?B?OENqTVkyZGNiWHJ5TVlxVmtzQmI4VkpncUpZVWMvMXBQNEQzWjhxRTZoVGw1?=
 =?utf-8?B?dUxaUzNETjBqemhEUXdUM05WRWNScEpiWWVaM2lUa3ZyUzA3TGhVNGtjUnlj?=
 =?utf-8?B?bGJRWDVOd2xnWDdMU3d2aWZuNjJXcHUyMVpjV2JXMlg5WnAvUmthUmJhTjdN?=
 =?utf-8?B?WkY3M2Q3MVhYZmgveW9UdUROTk9IOWF5K0ZFcEVWQW13RTE1V1FJRHZrSWZ1?=
 =?utf-8?B?VmZOdWNaa2c1M0pGSkJCVUZUUnpHSUtRNE9rNERnQ0I5UVdiZkN3TDIxQTRR?=
 =?utf-8?B?QmtxWTM0RThrdnJJaERVQTBXRGwxUzRWSXdCVXlUTWx5VUE0dWljRG9qdWhM?=
 =?utf-8?B?Qitsc0lDZnhOU25OTDBpZCttM0haUjQ0SjdhSjB2c1QvNEpUa2ZZOTQ0eVJy?=
 =?utf-8?B?UEM5ZksxNTdMTU13TjlPZkUvbFZ4Nno0M2MzZjV0VVlpVjhBQXN5MFdCcWNJ?=
 =?utf-8?B?dHgwQThyNnI0UzdNMnVhYVN0eDlvdTB0N0xxam13R1ZGK01EaGhxamhVSEc4?=
 =?utf-8?B?KzM5dXZmVElrb0VoS3BYNDVnbDNlWWJYMnFTNWxkd0xCcXR0QmJKV2RaTlVV?=
 =?utf-8?B?bW1ENE5GdGtCUVVVaU5IMjJ6dWpNZzJjSExSVHlTQzc3czcrMzdlckRWQ2FK?=
 =?utf-8?B?SXFpZGc2ZzVxaW5DUm8yLzl4emk1YTJSeEI2U2dGY1J1cEsxZ2RkQWdGVG1R?=
 =?utf-8?B?SDZhSlVGWlhhbGNXK29hZ1UvUkVNZ1FCY3dtZmNmNHlNSlBiV0prTllMZFh2?=
 =?utf-8?B?K2tKVkQ2T2VoQm1kc2J1S3lwM01WMElwaXdBazNiNlNkNzJaMkZEZU1QVWNM?=
 =?utf-8?B?UlFTTjFHWGtCWXA3OFVsaG1sSzJxZHNMbHBreXgvVDQvNms5WU9XY2paTlZU?=
 =?utf-8?B?eU1BY2pmcTdtVmJtZFdjMEIzR3hpQVVCUUZGYk9UWGFWTk5ZK0VySmlhYWZr?=
 =?utf-8?B?OTRlaklnUFJPZktEYXgxM0cwYVB5M1pMeG12QlA2R2VsTzdkMHhzSXpOTzM1?=
 =?utf-8?B?QmpMemVnckJXbUFrVmRQY1c1Y3AvZGdKUGZRZHVjb3kxb2Y4SzRFNU9TZGts?=
 =?utf-8?B?Z2YxM2lBSS9GeGdjMnF4eGdzNUZmY01FV0JIOTdYNGNyUXNrTkFUb0pqVlpI?=
 =?utf-8?B?L2szdHVzaTRES1pIRkpGNXBTdjF4NGxvWERTUWJiTmdxSGZ4WXczWkRWNXFC?=
 =?utf-8?B?MGpFSnE0SWZXc3UvQk1ReXdtc1BHN2tJbm45Q3ZabmRVRzNFdUQ5YUJCNUda?=
 =?utf-8?B?cy9zRjhmeUFlZ0k1bGd3M3NtSnFYZzI5VWJYMTBjc1JrMXlueWd0MlBaQ2Vw?=
 =?utf-8?B?UEtqR3RoUWNMRk9qZVZLOTU4WFRKQk5qdmhmeG1ESzhEYTVmUzliQUdkcTFJ?=
 =?utf-8?B?QUxlb3p4UUNLL2p6RTFKN2RzVlNYZG52bm9MVVUwM0I0aTVpTnhGa25iWnl1?=
 =?utf-8?B?ZlRQQVdBeVNYbGZiU3huZGlvbzN2NDEwUzFJSnZsaDBhLzRodW5GWTlLN1Jn?=
 =?utf-8?B?ZThCUEhoL01rN0UyM2p3T2Y5VS9JQ2t2MFpDOGZLcUI0dWdaOWNwem9WZXUz?=
 =?utf-8?B?cUxub2xpbGZRT21kdWNkcS9FS0xWSDFDdFd0MHh6ZkNhWGpFUUoyM25odHd0?=
 =?utf-8?B?NlpyeGhZZU91MklRamEvdjhBYUduV2h3bTJxWElHSWkremlCY2tOcmNPY3A1?=
 =?utf-8?B?bllLdWRJRDlneTVjMlBYNjJNY0Qzc0ZtM2JCM21jb2tCZFlrSUZFQllZSHNs?=
 =?utf-8?Q?iM5feF0Dzmg=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CH3PR12MB7548.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(7416014)(376014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?dHkrNW5xTHRBTmlxT3o5YjN1ei80NTJqeG1YS3FSd2tnR1pPdkV0MlFlWVd2?=
 =?utf-8?B?WWpJZ1Q5a1h2MUNBdytJOFE4d2wxcUVEM0pVM2VhVmFrZ2xwdDloQTltejcz?=
 =?utf-8?B?eFVmenpiV1dpSU9ldzV4b0hQaGVwRmV3UTBwQXk3TGZJMENiZXZ3Rkl4R0Jt?=
 =?utf-8?B?SmYwQjY1ZTBwUmFMMGlVMStYQ3A1UGtxR2s0QzZmNGhRaVNPL09kemY3Wnc5?=
 =?utf-8?B?SkdONks1NjZoQytYRHl2MFRpSVIwZkVSeHV3akgyRk0vQTZ4aDZKVmM5VURz?=
 =?utf-8?B?MEYvYy9saDZyem1HVmtINnlVUklnaFF4R3poWkVnZ1BJSU02WC9wdldOa1dY?=
 =?utf-8?B?VFd1Zk5VTVc2MVpXYTE3YzdrVkdadWsxajVkOC9mOXEvQnp6ajZZMjY3QVF4?=
 =?utf-8?B?RVpUdzdobjVnRWFIN3I2TzQrOFZwYU45YnhKN0p1NWdNNkI1VHZhbzhZb0tr?=
 =?utf-8?B?ck1ocGZpc1p3T1hhVGNZc2ZEZktEL1BzWnhqWFdTb3VNbmlTVjZ1OUhab1hY?=
 =?utf-8?B?Rm9RWUJlUUxhY3E5YXlrSnFkMTJObU4wVDBkSHEzMVFEb3JEMGRsVUlLL0tZ?=
 =?utf-8?B?ZnkwWnN5Y1pVbHFpUE0rdkx3NHkvaC9QM0JVSU4wNmR1bmtnNXYvckl4MVFT?=
 =?utf-8?B?SExQZmdjQ2JSZ2ovRFdvMDNOTVM4Z3pFbDFicmcyUFpjN1JqN3NJalVuNnN2?=
 =?utf-8?B?NjlCSmsrejE5bnRGNHVEbGlhWEVkSERzTGxzbmFWdzUvY0xHQm1QQlNkOXA2?=
 =?utf-8?B?UE04ODNCT2UxTHJVdExobFhaUnJRS01zdm9BK014dmxhRzc5TSsxU241SnIw?=
 =?utf-8?B?aVh2SzZKbk95NVlzM3o3ZjJaNExVRVJpUHNyc3ZFYVFyMis4bWlLLzNIRER5?=
 =?utf-8?B?M1gzNktnZG1FOEY4Z09JZDdpMmthTVh1UXhvRldWbkNhZnRhWUdtbXd3dVli?=
 =?utf-8?B?RGI1bFZLZ0hGSFI2c1FmZWVoVE11WFRyeUxOTkp6SGtoOXZycW5NZnRCdXFa?=
 =?utf-8?B?a3RzUkkzeENVMk5SZm44UERaWVdremJoMzF4eElvaExFK1FNVG1YdVh2YTBI?=
 =?utf-8?B?S1dDWTV4NmdPaWFIVG0rdU9zNjRsc2psSVNXcDliOWFjSnlidWZzM3R4TWdy?=
 =?utf-8?B?VTZEWC9OWEdrb0VreSswR210RnAxVWxNYkxvbGM1MmZvL0xLT21BZVpMdnEz?=
 =?utf-8?B?RFR2cEVZTnM1YWdHZEQxeTg2MUxVbGJxQUFiVmFOMHVxb1lqTzJEb1d0VmJC?=
 =?utf-8?B?MU94akRWeFVDN2Z3MmZoZnRFRk5vam1xbC9UMEpFTUtDQUFlRlhTNTI1NkRD?=
 =?utf-8?B?Q0lCMVVxdjN0ZnplQ2E5c2dHOHRYdGxlN3dudFM4V21zTy9pOEJGK01UaStK?=
 =?utf-8?B?ZytqamVHeGYxbUZzTDVuSFNQL2IzTFoyUW85aWlYL0VOZm5wc0lSVjZkenJW?=
 =?utf-8?B?M1NKYzR0eUMwQk1YM3c4NHNZNzR1N1dXZ29mRjZyL3J6N2FZS1RiUzQyOUd0?=
 =?utf-8?B?c2xWMHgyYXpVQ0IvSkZjUFdpdDdwRjUyQ3Q0T3Voc0JvL3JkWWpRcng4WFUw?=
 =?utf-8?B?bzlFdnVTYzFzYWVQa1dSVnFVZFdTRHhSL2lCTkppLzVmMFpKYkJudlJFNWhI?=
 =?utf-8?B?aFR1b0FWOWp3aHRXaE5ocHVjWjFGbnBjYlNyakpmTUZrTThPYURlSjFZdXZG?=
 =?utf-8?B?R0hkZm5MQVpVVGl5NGpPYjAxWkRVVTNJYWxKMkJZTWpOaG9sUnNZUEg2VWJ1?=
 =?utf-8?B?WnV2RG1XNGc4NVlJTlg1cHVOSmVzZzZYVXBoYlYvcUI3eXU4YUhFVmZicUVp?=
 =?utf-8?B?RTRKMkZwTUxtQ1Z2bWFBTUJsUlJYYm9lcmNxanRUS0hpRVgvTEtvcG9iQXJG?=
 =?utf-8?B?Wm5Zd1JqQnlNVmc5NFkyK2lOeE1mWXlFdnVjNTFHeEhVcGd2c3pmbEhuMDJI?=
 =?utf-8?B?R2h5V1pSWk1DbTUrQ3B6R0RXQmZ3YitPWmdVbHBtZnRyNkQrcG56TEVhVDl1?=
 =?utf-8?B?ZFdCZngzZVBkbW15NjFBU1RsOE5kQlR4M0swcm9ub3FCQ3Njd0FpbHQ5YzIz?=
 =?utf-8?B?UlBIZWZLM3VpZzdnV1k1Z0FRelg3Z3RMc3hMaFdjY0IydzFGdzFIUHgyV3dk?=
 =?utf-8?Q?r8+2fCFDFtyz3VRw+flbt+6Nc?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 499a94a7-9db4-4790-58cd-08dd8e0f567a
X-MS-Exchange-CrossTenant-AuthSource: CH3PR12MB7548.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 08 May 2025 09:04:29.4304
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: CM3l0aMOIzvjfcAdam2JCvasN19rIM4AAOUuleNMnQDSqif3m51y1JCIP2u71PCCqBha0k4H7u1rpPLKIfhl2w==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS2PR12MB9568



On 08/05/2025 3:43, Jakub Kicinski wrote:
> On Tue, 6 May 2025 18:34:22 +0300 Mark Bloch wrote:
>>>> Flow:
>>>> 1. A user requests a container with networking connectivity.
>>>> 2. Kubernetes allocates a VF on host X. An agent on the host handles VF
>>>>    configuration and sends the PF number and VF index to the central
>>>>    management software.  
>>>
>>> What is "central management software" here? Deployment specific or
>>> some part of k8s?  
>>
>> It's the k8s API server.
>>
>>>   
>>>> 3. An agent on the DPU side detects the changes made on host X. Using
>>>>    the PF number and VF index, it identifies the corresponding
>>>>    representor, attaches it to an OVS bridge, and allows OVN to program
>>>>    the relevant steering rules.  
>>>
>>> What does it mean that DPU "detects it", what's the source and 
>>> mechanism of the notification?
>>> Is it communicating with the central SW during  the process?  
>>
>> The agent (running in the ARM/DPU) listens for events from the k8s API server.
> 
> Interesting. So a deployment with no security boundaries. The internals
> of the IPU and the k8s on the host are in the same domain of control.

The VF is created on host X, but the corresponding representor appears
on a different host, the IPU. Naturally, they need to be able to
synchronize and exchange information for everything to work correctly.

> 
> So how does the user remotely power cycle the hosts?

Why should a user be able to power cycle the hosts?
Are you are asking about the administrator?

> 
> What I'm getting at is that your mental model seems to be missing any
> sort of HW inventory database, which lists all the hosts and how they
> plug into the DC. The administrator of the system must already know
> where each machine is exactly in the chassis for basic DC ops. And
> that HW DB is normally queried in what you describe. If there is any
> security domain crossing in the picture it will require cross checking
> against that HW DB.

You're assuming that external host numbering and PCI enumeration are
stable, also users can determine the mapping only after creating
VFs. But even then, the mapping is indirect e.g: “I created a VF on
this PF, and I see a single representor appear on the IPU, so they
must be linked.” That approach is fragile and error prone.

Also, keep in mind: the external hosts and their kernels shouldn’t
be aware they’re part of a multi-host system. With our current
approach, you just need to provide a host-to-IPU mapping
upfront, no guesswork involved.

Just thinking out loud, once this feature is in place, we might
not even need a static mapping between external hosts and IPU hosts.

If VUID and FUID are globally unique, the following workflow
becomes possible:

- A user requests a container with network connectivity.
- k8s allocates and configures a VF on one of the hosts.
  It then sends the VUID, PF number, and VF index for the new VF
  to the k8S API server.
- Somewhere in the network, a representor appears. An agent detects
  this and notifies the k8s API server, including its FUID,
  PF number, and VF index.
- The API server matches the VF and representor data based on the
  globally unique identifiers and sends the relevant information
  back to the agent that reported the representor creation.
- The agent attaches the representor to the OVS bridge, and with
  OVN configures the appropriate steering rules.

This would remove the need for pre defined host to IPU mappings
and allow for a more dynamic and flexible setup.

> 
> I don't think this is sufficiently well established to warrant new uAPI.
> You can use a UUID and pass it via ndo_get_phys_port_id.

phys_port_id only applies to netdev interfaces, whereas this use case is
broader and more aligned with devlink. We believe devlink is a more
appropriate place for this functionality.

Mark

