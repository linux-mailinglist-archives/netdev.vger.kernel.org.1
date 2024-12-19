Return-Path: <netdev+bounces-153156-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 16D019F7171
	for <lists+netdev@lfdr.de>; Thu, 19 Dec 2024 01:41:56 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id C7657189327B
	for <lists+netdev@lfdr.de>; Thu, 19 Dec 2024 00:41:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 76F9D111A8;
	Thu, 19 Dec 2024 00:41:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="oUyqBEyo"
X-Original-To: netdev@vger.kernel.org
Received: from NAM11-DM6-obe.outbound.protection.outlook.com (mail-dm6nam11on2087.outbound.protection.outlook.com [40.107.223.87])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 633016FC5;
	Thu, 19 Dec 2024 00:41:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.223.87
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734568907; cv=fail; b=YDLzIB//F892iVo0eb1vg52Ao55mW9pXrykdw5EPeCx+Qzlzple/q5pXo1dg6MRX/2+oZsyBVNPTIRlOMC/x4Vp9XWZQRNdCl3bGWdHVCUI3v5ZMjvMA2/675/7HH7MgOYFCG3sfxyKb/oOaDXTwCbkezsDHXNwsWfAK65UZ0Pw=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734568907; c=relaxed/simple;
	bh=FM2v8qWjCKSZWQy2vSXUsKIyZVSfm36/W5BcDAXxYHo=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=ifV3/qVEC9IeCjJSnXsn85S/f/7ozEztUGBWNbo+/xETVQZysv0ubPFL/ZJKvcCCpJcIIg2gbsn+tet4ksiKlum56FFw7gdH6Wgj3JbMOomcFFZNmTxNII+3geYYcVi1Y04cgMTvi3n0yND4UFikU4BCGLsrnprv7A+ljH04DOE=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=oUyqBEyo; arc=fail smtp.client-ip=40.107.223.87
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=LYmtDgLgfOsKV6gVVc6fBRF2i3CfFgVKa0FAcMnpso5tS47ialWIHFJs2qdEk0qJ1rLyN6I2p7v+Inii35wTp1FZxMWgpGRdKHg9PUGadMjhCON40W0eaTI4QehQOJTZhrF4cryCOtUHHSps4VRZu0Ag6pE/5WikNm+qj8N1QoZG8p0LbBZwAeBJy6dErO1A0SJMFVy8Irw88JSGNkvQeJ89gCJWC27HZX2gxCMXfifY4RwH0HJqK2TBkwmJBrwQBdzczZsgl5cQnazxAp64hEE112F1uOJueJG19yE3A8QVaas8U2NWjVXZDHybRGH8TjsF3F1ylqQFqrR4Q95XgQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=BNPY1IjNL1sZ2xf6AfH5pQN+z+27MM2AX8Sz4oRBG6E=;
 b=Mv/PNkKqGNE2JHZnxkixB4BgR9ebPe56cikYUIf+3KGevN6Fd/t1cD3/72TKx3u+PLi9oxklOIK/66GJZ35VQ2ccMUZPbABRjP0SM0El0gjNQTBUgM/+tZ33vh9z4bBePMs2O6QObj/3B7P7Lsi03IaP5Hpl/ZQ1dd+vU87NmHax6CsEokhsLkCF1kVq516yjZckHrUJMs0kwjETZdqTH5ZXM39TPQtSZfoJJoPO/rlhI9FGYs6tKWJFOnR13xTA2fIbEaKQH0Uf/mBuhQUM7gLZl1w8o/E1d1oEWNo+iheu9trh75vsi3Jwc4lRrBTbSivh9NzhjZDtDE8E3D9c9Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=BNPY1IjNL1sZ2xf6AfH5pQN+z+27MM2AX8Sz4oRBG6E=;
 b=oUyqBEyowJqoGofz0tzNO5/Xnbn9FqS13SirezxhJXfH870/zBhREkVfBYHhoah/0E6tQXx+zuKhx2oxjKp9OZcXNcX+YD5SdbDRDoH6ZXmRT5vE04gkKqFlkAlI1tnZZ1Go0k5xJcq7ZFRlXpZlXuqOdh+WTQsswY+Fv3hhUJw=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from DS0PR12MB6583.namprd12.prod.outlook.com (2603:10b6:8:d1::12) by
 CH0PR12MB8551.namprd12.prod.outlook.com (2603:10b6:610:186::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8272.13; Thu, 19 Dec
 2024 00:41:43 +0000
Received: from DS0PR12MB6583.namprd12.prod.outlook.com
 ([fe80::c8a9:4b0d:e1c7:aecb]) by DS0PR12MB6583.namprd12.prod.outlook.com
 ([fe80::c8a9:4b0d:e1c7:aecb%4]) with mapi id 15.20.8272.005; Thu, 19 Dec 2024
 00:41:43 +0000
Message-ID: <2c3dc9f5-7dfa-46d3-b8fc-3bcbaaa3c540@amd.com>
Date: Wed, 18 Dec 2024 16:41:41 -0800
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net-next v5] net: Document netmem driver support
To: Mina Almasry <almasrymina@google.com>, netdev@vger.kernel.org,
 linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org
Cc: "David S. Miller" <davem@davemloft.net>,
 Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>,
 Paolo Abeni <pabeni@redhat.com>, Simon Horman <horms@kernel.org>,
 Jonathan Corbet <corbet@lwn.net>
References: <20241217201206.2360389-1-almasrymina@google.com>
Content-Language: en-US
From: "Nelson, Shannon" <shannon.nelson@amd.com>
In-Reply-To: <20241217201206.2360389-1-almasrymina@google.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: BYAPR07CA0097.namprd07.prod.outlook.com
 (2603:10b6:a03:12b::38) To DS0PR12MB6583.namprd12.prod.outlook.com
 (2603:10b6:8:d1::12)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS0PR12MB6583:EE_|CH0PR12MB8551:EE_
X-MS-Office365-Filtering-Correlation-Id: 1b37aa9e-d39f-42f1-8dd7-08dd1fc5e8a1
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|376014|7416014|1800799024|366016|7053199007;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?TEVQTDRicm9KZ2pvaTdwRHVwNnpGT1dzTkNVS1hUWmIxZFJOUU02N3I2M3Vr?=
 =?utf-8?B?NTA4ZW5XR0w0NTk2eHkvNjFlcFVQU1dBYngyNjVwMm5sbld3UU1FLzJDQTd3?=
 =?utf-8?B?RjVtR3FaNm9ibVBvL1d2NFFwdDU2Nk5yOXhHdG1SQjlUMXIzbm4vSGQyLy9n?=
 =?utf-8?B?TEpjYWxQWUxHcVlVeER2Wmljckc4dTRxaWhRQ2dWdHZzLy9ybEcyRnVTRTIy?=
 =?utf-8?B?REE3aU1oU0JGcG5VUVFKU2REMkVFeG1PYmU5QXJJTndSZEJrdzU2YzdNOW9H?=
 =?utf-8?B?emZLcU9pZzFxMkdvWGl5TEZpVUdRSmNRMmVKOElYN2lDN2xKM0lxNmRINkdG?=
 =?utf-8?B?b1dRQ3VPNnJrenhrRlB2d3F5TXN2Q3ZrVUtDTEN2Q1F3UC9wUjFuN3lKVDFo?=
 =?utf-8?B?Zzl1UC95U2NrUTNSYVNoVE1JQTNMOExjQ0tIM1lkQnJDY1E2dHQ5TStRUkg1?=
 =?utf-8?B?d3lGdS92bS9GR1R2ZlFhRnV3T3czOUJCMTh1VnI3aFVmdHpKZStlb0RQTEJX?=
 =?utf-8?B?eTduS25GWEhGckY3MmZxNVEyelFsNk9yY3VMTHRtMUE2eXV1bEw1Y1Uyb2hR?=
 =?utf-8?B?TEJXSzF3ZXc5a2VvTzFBNUwvUnlxQnM2bnYvN25OT0lRd1FpNWdKb1cxOFBS?=
 =?utf-8?B?OHgxVDgwYXM5Vkt2SHBZU2lhV3BzZDBpenMyc0JOcWJMdU5maEtKMVNRTTNZ?=
 =?utf-8?B?aHBDdXhkeCtNRkZWaVVyZ2dSK04xMTF2aVRFeCsxS2doazVjd0s4TkVLUHpT?=
 =?utf-8?B?cXFMdnFQV2kzV2dCaUNabkJwcUorSVhzaTg3SThVdmxiODRURXVITFZwU2hU?=
 =?utf-8?B?R2VZVXBlcTdQVy9WK1IvM01QLzdIMGhNem5rWm8vRm03VjRUMGV3d2x3L2Ni?=
 =?utf-8?B?emxtYU5SN3RpR1ZnbHZWek4zUDRUczViVVdKWkZtdjRTVlhEc2huUWEwRkxk?=
 =?utf-8?B?Rm1acFhkSzhBM0dDVFhGdERpdHFPcENGYSsxcGtXWGdQZ05tTXhYYUVMREU3?=
 =?utf-8?B?WnR5dVB2NEhaOUNxRHZzSGdnTUc5VVRIdEQyUWx1YWZUcjFsdndoTG9OcG8v?=
 =?utf-8?B?dE9RSUdUeFArY1NUaXhhTmVKN09GQkRaOGhNc0k3cWtha09tRGhkRWp0Q1kx?=
 =?utf-8?B?YStKQnp3RkhwbytSbHY4MTg1QnlTMWtHZ0FXK05VSlE1em5iWFE1NW1qNXpl?=
 =?utf-8?B?THN4WEVWODNGdzhoRDluY2toZjJCNytPRWdvZDhNR3VKVDVVU0Q4TExyeDND?=
 =?utf-8?B?SzNTSCtuVEY0QmJhNVN1TWhjSUNmM0JsUmQ0YjlTdmhhcitKQ0ZnbTQ2UUto?=
 =?utf-8?B?cE5EUWlCOGthWitzdXZZL1JDUzRVZzNxbFY4aW5KcHVsQ3UrbVkwZld0bldo?=
 =?utf-8?B?MldjS2dOTzVxTXQxamtUME1BdktwdC9DK3dBKzdJb0ZWMDA4WjI3RVJJa3pX?=
 =?utf-8?B?OFRmZzBXYWZMOWtpT25yZGRERHhnMVV5T2RaQUdHaDB6clJ0cTlLRXduMStq?=
 =?utf-8?B?VGlFbmRKZGRWREhVUVB0Wk5UVHBIZy9PQ1pBNUFCb1l3TDI3dE1KcnVYUERl?=
 =?utf-8?B?MnFTc3FmaVg5dkM4dlRsK0x0Q1BSWU9kTk9Ec2hzdlpqb0wxdS9BTHpsSXJC?=
 =?utf-8?B?aFRRLzBJc1B0aGViQWozTmw3Z3lFME93aDJGZVNHZTZhdStiS1cvNm5ESitX?=
 =?utf-8?B?ZHhKY1YveGo0OUdHSHhZd01nVE5QZ25hTUNoRkhSNjBGcU9ORnZ1M25ZTjBM?=
 =?utf-8?B?L3RINkp6cmllaFByQ2ZkTEFBQ3VvcUpxbFNkajdmY3dxSW50UGhUaDNnbEJB?=
 =?utf-8?B?RWpJS3FjVEJrbFZraWhGY2h1VEptMlNHSnZHL1gyYUZ5QURyVDdnT2tGOWpo?=
 =?utf-8?Q?8QKVWtxvwXP/d?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DS0PR12MB6583.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(7416014)(1800799024)(366016)(7053199007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?d25EUlVlUFM2dlpBU1ZUQWNzNkt2Z3orV0RzNHBMTVkvK0VSQmIvcElBS1pY?=
 =?utf-8?B?V3JwUHY4UDBNamZzdTRDNGlrWVRpWjUrVFZwV20rL2oxVy9oOEt2akJVaTZz?=
 =?utf-8?B?TndyU2RkWjVvSXZlRXc5VE5LVXZaditRcG1JdlBuZXVTVVRlbTQ3c2Q3cDF1?=
 =?utf-8?B?OUlhRVlqNTJ4OHVrc0RRNDVrSEU4R0dlWUxzUjFkMThGWGRFT2RHdk1aRHpl?=
 =?utf-8?B?dzhpRUtqdENraWt4QlkyZkFEcmtFbWsrQWdZVXJHcmdOWVQyc1ZLQUlCYzc0?=
 =?utf-8?B?ck9mUzhxVWtwUUZ5TzcrN2tDOFp4N2tCMXNGb2IrajB5cTNGUVZkWmdzNElT?=
 =?utf-8?B?aGh1UnBmQmFXNlJyaXc3VEN3ZWlHUXN0K0htLzgrd1FBL2hrNUtLT3MyMmda?=
 =?utf-8?B?NmIwbVdlRVhRUW1UcjdjN3JpR1lIc1J6WVV2NHlLYWFrTllzMUlodkhkV2p0?=
 =?utf-8?B?VlVFSkxjb1lmbWVTRmxiQjFSMlplMml2aVhIVUFKZjlzRVlzeUY4MWtZbnFl?=
 =?utf-8?B?VHhxM00xTktpaVE5TW5WbG5qWWlOV0pNaE1FZ3Q3aERYVVBrTFZiR1pvZHBK?=
 =?utf-8?B?MVZkTHRCbENYUXJKd3VwUU9MOCt4c05SUDJ3SWZZeWJQU1diVVJEVTZTYm1G?=
 =?utf-8?B?bHZ4MUVaNmdiNEI0WGRhbDBPU1ZqWWJQS0tSN0JudGRxbGVSRDRVNm5GakFY?=
 =?utf-8?B?MWlIZmtXemJ5bzBkb0ZSV0E5b2xlaW1kM3NSY1ltM0QxZHhCdjl5aTNGWW9t?=
 =?utf-8?B?cW04eU1qSXdPbXBiejFpS2pSNGcvVld4QWZ0ejVjUkkrYnBqc1NmOTNVRnlj?=
 =?utf-8?B?QUNSZ2RqaDJ6dzFnWkNvUmFrMVBLdC9KcDh2NFFrTUhVMFdJbG5vejBKQmp4?=
 =?utf-8?B?UWYwanc2cmZKNGNsdDhWQXlSVHpEb2xUcGdHK2xEZWpobE9wVnQ2dzNGeWp6?=
 =?utf-8?B?SjdSNmgwcnFjOTdDenJtRlpQSXFsRFNHNXN4WVhrU2hLMmUxUVFXVnZPUmZL?=
 =?utf-8?B?aUtZcSs5TG83dS83TTd2bXFGTXV3MUh2WGRXeDN6TU4waUpwZXc4KzR1TXBT?=
 =?utf-8?B?K0RlcklUNkU1NVMrSy9yRFYzenR5TXJWNW9qcDRmV0NpdFRmV3lTa2FPYm1m?=
 =?utf-8?B?R3daUmhXK0VJNlVrSUQwZ011c2hGUDNyUFJtalN0bTZFNXpFZU5TaWlNZ3o0?=
 =?utf-8?B?djl3VXJyamo2TkwxYm9QMHpYNUZyVWI0SWV5WlY4K1RGbzZjamgyaG1yWDFY?=
 =?utf-8?B?OXRsNjNvU0tyQzllYkxkSjM0dUt2U0wvYWliRGwvWGZ2VjhkU05pUGhqMVBl?=
 =?utf-8?B?SURwdlVsMGM2bkYrbHFHWFhCbWx2ay80RUdVV284bUZOZ2ZSdnZOQldMNXNY?=
 =?utf-8?B?d1pCa3VhQlE0dW9MWU1iQXhEVE93cHFkMXBUZTE3YVA4R2RjbUlYK0F1Wkl4?=
 =?utf-8?B?VnBROWZRcStRK1ZuVlk0RzhpZ2tUSmp0MFZwTC9paTkwczcvOTJucFUzWVRm?=
 =?utf-8?B?ZUluejYvbnN3ci8wTld0OW1renR1N0U4Smw3bnpQOHYzZmd0Y0FGT21yRGZD?=
 =?utf-8?B?VUdnSDBvL2NSNHd2aDczcFJaTkZuOW11bUNxWnlHRDM5cWR5RGNkVm5BckVj?=
 =?utf-8?B?dGQzSkYwb0kyWWkyMktHMW9VeTRJYmVFejRxZGRvNG5oL2lvN090UzBMUURX?=
 =?utf-8?B?ZEJvV05MNWJncUZOQkY0Z2MrdElFM2lia1FaYnhKRTJXOVM0WHMrdjZ3Mnpu?=
 =?utf-8?B?SlU0QmlhZWpjc1J2T0ZVV3c0TnNPcTA5Zm4rSmhkMkVLV0RhSndRUEF1QVN6?=
 =?utf-8?B?U25ERktZZCtMOHdkOERUcUFnN0hubVI2RlJieTNsUitxNXhVQlJybjZSRFhI?=
 =?utf-8?B?WnBCVVlhOUU3aTNoRXpFL1lXQ0xxZXZSWWp4RlVNRjdnT2hPbllBUFpNazhh?=
 =?utf-8?B?c2ZYbGhKdGZBQ3JpZGJzWXIraE0zYWxYcTJuaTc0OERsRlNWNVZjRktwTG9u?=
 =?utf-8?B?OW5zbkVZOVkvc0lqeXh1aVhRNXJuWGFUQlpVaTdDeDFvVldacHdDWUhLR1R6?=
 =?utf-8?B?Q0ttZ1k3dElKaFB2cEd2bkpUOXZWQXVlUjkxZEhHeCsxOXI4ZVEzQ1YreGlj?=
 =?utf-8?Q?0p8aOYPCBNKaRP9Vl1e5nf1hc?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 1b37aa9e-d39f-42f1-8dd7-08dd1fc5e8a1
X-MS-Exchange-CrossTenant-AuthSource: DS0PR12MB6583.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 19 Dec 2024 00:41:43.0541
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: gHf8zF5H9Kh9mcm1KIrmX7iK+xcM4gkkvot40oMzi7QVGo5LGoKGL4Pp+kgBz9V8cvFUL9lo3RNuogWsE4/H+w==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH0PR12MB8551

On 12/17/2024 12:12 PM, Mina Almasry wrote:
> 
> Document expectations from drivers looking to add support for device
> memory tcp or other netmem based features.
> 
> Signed-off-by: Mina Almasry <almasrymina@google.com>
> 
> ---
> 
> v5 (forked from the merged series):
> - Describe benefits of netmem (Shannon).
> - Specify that netmem is for payload pages (Jakub).
> - Clarify what  recycling the driver can do (Jakub).
> - Clarify why the driver needs to use DMA_SYNC and DMA_MAP pp flags
>    (Shannon).
> 
> v4:
> - Address comments from Randy.
> - Change docs to netmem focus (Jakub).
> - Address comments from Jakub.
> 
> ---
>   Documentation/networking/index.rst  |  1 +
>   Documentation/networking/netmem.rst | 79 +++++++++++++++++++++++++++++
>   2 files changed, 80 insertions(+)
>   create mode 100644 Documentation/networking/netmem.rst
> 
> diff --git a/Documentation/networking/index.rst b/Documentation/networking/index.rst
> index 46c178e564b3..058193ed2eeb 100644
> --- a/Documentation/networking/index.rst
> +++ b/Documentation/networking/index.rst
> @@ -86,6 +86,7 @@ Contents:
>      netdevices
>      netfilter-sysctl
>      netif-msg
> +   netmem
>      nexthop-group-resilient
>      nf_conntrack-sysctl
>      nf_flowtable
> diff --git a/Documentation/networking/netmem.rst b/Documentation/networking/netmem.rst
> new file mode 100644
> index 000000000000..7de21ddb5412
> --- /dev/null
> +++ b/Documentation/networking/netmem.rst
> @@ -0,0 +1,79 @@
> +.. SPDX-License-Identifier: GPL-2.0
> +
> +==================================
> +Netmem Support for Network Drivers
> +==================================
> +
> +This document outlines the requirements for network drivers to support netmem,
> +an abstract memory type that enables features like device memory TCP. By
> +supporting netmem, drivers can work with various underlying memory types
> +with little to no modification.
> +
> +Benefits of Netmem :
> +
> +* Flexibility: Netmem can be backed by different memory types (e.g., struct
> +  page, DMA-buf), allowing drivers to support various use cases such as device
> +  memory TCP.
> +* Future-proof: Drivers with netmem support are ready for upcoming
> +  features that rely on it.
> +* Simplified Development: Drivers interact with a consistent API,
> +  regardless of the underlying memory implementation.
> +
> +Driver Requirements
> +===================
> +
> +1. The driver must support page_pool.
> +
> +2. The driver must support the tcp-data-split ethtool option.
> +
> +3. The driver must use the page_pool netmem APIs for payload memory. The netmem
> +   APIs currently 1-to-1 correspond with page APIs. Conversion to netmem should
> +   be achievable by switching the page APIs to netmem APIs and tracking memory
> +   via netmem_refs in the driver rather than struct page * :
> +
> +   - page_pool_alloc -> page_pool_alloc_netmem
> +   - page_pool_get_dma_addr -> page_pool_get_dma_addr_netmem
> +   - page_pool_put_page -> page_pool_put_netmem
> +
> +   Not all page APIs have netmem equivalents at the moment. If your driver
> +   relies on a missing netmem API, feel free to add and propose to netdev@, or
> +   reach out to the maintainers and/or almasrymina@google.com for help adding
> +   the netmem API.
> +
> +4. The driver must use the following PP_FLAGS:
> +
> +   - PP_FLAG_DMA_MAP: netmem is not dma-mappable by the driver. The driver
> +     must delegate the dma mapping to the page_pool, which knows when
> +     dma-mapping is (or is not) appropriate.
> +   - PP_FLAG_DMA_SYNC_DEV: netmem dma addr is not necessarily dma-syncable
> +     by the driver. The driver must delegate the dma syncing to the page_pool,
> +     which knows when dma-syncing is (or is not) appropriate.
> +   - PP_FLAG_ALLOW_UNREADABLE_NETMEM. The driver must specify this flag iff
> +     tcp-data-split is enabled.
> +
> +5. The driver must not assume the netmem is readable and/or backed by pages.
> +   The netmem returned by the page_pool may be unreadable, in which case
> +   netmem_address() will return NULL. The driver must correctly handle
> +   unreadable netmem, i.e. don't attempt to handle its contents when
> +   netmem_address() is NULL.
> +
> +   Ideally, drivers should not have to check the underlying netmem type via
> +   helpers like netmem_is_net_iov() or convert the netmem to any of its
> +   underlying types via netmem_to_page() or netmem_to_net_iov(). In most cases,
> +   netmem or page_pool helpers that abstract this complexity are provided
> +   (and more can be added).
> +
> +6. The driver must use page_pool_dma_sync_netmem_for_cpu() in lieu of
> +   dma_sync_single_range_for_cpu(). For some memory providers, dma_syncing for
> +   CPU will be done by the page_pool, for others (particularly dmabuf memory
> +   provider), dma syncing for CPU is the responsibility of the userspace using
> +   dmabuf APIs. The driver must delegate the entire dma-syncing operation to
> +   the page_pool which will do it correctly.
> +
> +7. Avoid implementing driver-specific recycling on top of the page_pool. Drivers
> +   cannot hold onto a struct page to do their own recycling as the netmem may
> +   not be backed by a struct page. However, you may hold onto a page_pool
> +   reference with page_pool_fragment_netmem() or page_pool_ref_netmem() for
> +   that purpose, but be mindful that some netmem types might have longer
> +   circulation times, such as when userspace holds a reference in zerocopy
> +   scenarios.
> --
> 2.47.1.613.gc27f4b7a9f-goog
> 
> 

Thanks for the updates, looks good.

Reviewed-by: Shannon Nelson <shannon.nelson@amd.com>


