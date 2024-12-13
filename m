Return-Path: <netdev+bounces-151720-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id CFECB9F0B91
	for <lists+netdev@lfdr.de>; Fri, 13 Dec 2024 12:45:56 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 8B7EF280EE8
	for <lists+netdev@lfdr.de>; Fri, 13 Dec 2024 11:45:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 96A031DEFD9;
	Fri, 13 Dec 2024 11:45:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="aTEdEZvo"
X-Original-To: netdev@vger.kernel.org
Received: from NAM11-BN8-obe.outbound.protection.outlook.com (mail-bn8nam11on2055.outbound.protection.outlook.com [40.107.236.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B12C71DDC0D;
	Fri, 13 Dec 2024 11:45:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.236.55
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734090350; cv=fail; b=EooKgWxA8LsJrVtDx2mEoCFP7V/oD7IicncziluAwG8DuZP61OkK0j0EjjrVp0QmD8R3/j8v0eImLECK20MV9+FUN4l7bA1W61hKdYplMg6A/9+c/zDRS6ton5Dkq0c2VzLEs4kDUzRzIVGWhDo4pLebKL1DhBuW8SJUcFcC3VI=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734090350; c=relaxed/simple;
	bh=DaehtssCMJT1IOTkLgG6tetBPHd1iK2rqSGSNSkV5h4=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=DP7PEVEGVdpBFmMF/6tVNoEGLKVY7qh2AHDkXvUrFmyRmAepSH+CUKhhqnLk/qaRODe/KqHye2/ISlek5r6xVX4QSAWQ0muug0aXgfYKvNcW/sEmkBJemJHU87x182rqQLcv3vR81E+o8NiKrL2iZY9n0Qyr8f2McC39EUC3N10=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=aTEdEZvo; arc=fail smtp.client-ip=40.107.236.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=nIDbgUueBwsLI2R5sCAhuu7WnNKA8PkDn+guNFfh2HhA/g4YYoiU4fJnp4zVY74xYh5I0ldQ3bAz7b1Hn+BSjdwq6+/tldhkXILN03tGMrhzi8uhtC/xyFvjEA7Zfqnj9UF4BtAicKNCkndeB1c2mnjZhK6ALbVHTUNj/gqlsUblgjsbXYk619aLninAGTjaT1ohAogQbYmZztb/6AyeYbBt/3e2wXgtVxL5YirdRvyqd2bVHmC96BneHXiciKQAEwkt0tKHG55nEJG5Ra74Nv3BsMRS0nKi25dkSSQhYjeZ7Nm28Ntn6qd4lRNb3MYqNB864xquGqJgGm9NsBI/kQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=L38bVpHtB/CscZmxz6eqhhnbxsEaVSkpl0GZI/vW1Ek=;
 b=sx6vLFyfoZWdLwwlIWWnnAv8glXpyROVJcRJLdnB+bZj+ynEipWllNlQVtJRH+pYSu51pPavACaQhb5+J76sFPVNR49WQgAMKNUNzbCykX+NZBNwzvOm/Piio2rzLGY+2W79aCGJ6TMuHSBmC6MtZgfFeLXLiftagdzMQ2wKRGOQNhj0oaQVOJvlCwR/xwsLtC9680/drKZ3HaRGBwaGTGP3Bxt2E35DHdnfkcgRZPLuvZRgYYFBmg476dgcROimisEOxA+iR+Pxq8RZ2rp8v0ue+3MegVJLCaooiCFZ/Cfk93SOyjDONaYUktiG+K0NZitZOlpqMoAY1iOdoaGWNA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=L38bVpHtB/CscZmxz6eqhhnbxsEaVSkpl0GZI/vW1Ek=;
 b=aTEdEZvokjzLY/+cd8OZZc3incvaF9yANZJxIo85bRasIl0K2JtLhKVKn9+ltGXkXLKiylYssYZn6LagrmwfQiCBVOxlcJF/qi2XzOaiChQRykvshEq70/MtRGllyZJw1EKhnTgAxSjcwe4AohbAFaWVexE/fnlkCcCK+79jRI4=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from DM6PR12MB4202.namprd12.prod.outlook.com (2603:10b6:5:219::22)
 by SA1PR12MB6725.namprd12.prod.outlook.com (2603:10b6:806:254::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8251.16; Fri, 13 Dec
 2024 11:45:46 +0000
Received: from DM6PR12MB4202.namprd12.prod.outlook.com
 ([fe80::f943:600c:2558:af79]) by DM6PR12MB4202.namprd12.prod.outlook.com
 ([fe80::f943:600c:2558:af79%5]) with mapi id 15.20.8230.016; Fri, 13 Dec 2024
 11:45:46 +0000
Message-ID: <d816e960-eb12-4e19-5e47-c4980df924e8@amd.com>
Date: Fri, 13 Dec 2024 11:45:41 +0000
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.11.0
Subject: Re: [PATCH v7 28/28] sfc: support pio mapping based on cxl
Content-Language: en-US
To: Simon Horman <horms@kernel.org>
Cc: alejandro.lucero-palau@amd.com, linux-cxl@vger.kernel.org,
 netdev@vger.kernel.org, dan.j.williams@intel.com, martin.habets@xilinx.com,
 edward.cree@amd.com, davem@davemloft.net, kuba@kernel.org,
 pabeni@redhat.com, edumazet@google.com, dave.jiang@intel.com
References: <20241209185429.54054-1-alejandro.lucero-palau@amd.com>
 <20241209185429.54054-29-alejandro.lucero-palau@amd.com>
 <20241212212229.GD2110@kernel.org>
 <e46cd8f0-5e62-5e51-a901-384bdad689fe@amd.com>
 <20241213102439.GI2110@kernel.org>
From: Alejandro Lucero Palau <alucerop@amd.com>
In-Reply-To: <20241213102439.GI2110@kernel.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: LO4P265CA0235.GBRP265.PROD.OUTLOOK.COM
 (2603:10a6:600:315::12) To DM6PR12MB4202.namprd12.prod.outlook.com
 (2603:10b6:5:219::22)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM6PR12MB4202:EE_|SA1PR12MB6725:EE_
X-MS-Office365-Filtering-Correlation-Id: 2cc10613-61f5-4634-5b09-08dd1b6bae7f
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|7416014|376014|366016|1800799024;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?WkdXYmpYM3RvUk10SWNSSkNzTTVGWkdOc25zYVRJaXh1L2UzaGNWOTFJa0o5?=
 =?utf-8?B?dm5oNWdCTVc1bTFhOC8xV1JKaUp6RUdjT1RKSzRsRy9jYWxJS1UrUEhjMG5F?=
 =?utf-8?B?QWNSNTNMRWVrQm5XbTdJUDNjWEw2aGJhWmUxK3EwVGFSS0dCN1R6Ri9TQ3Fh?=
 =?utf-8?B?bWI1QVB3c1BJL2NBMWxjbVlEbzdJVDY4MXA1VmRtcU0rSFpYMWl5YktNMVR3?=
 =?utf-8?B?UzU0YnZmOTRZa0dpTHhiVjArNlAwQ1NEeXFkaEVrSWhYand5VlBxcGs5eXRo?=
 =?utf-8?B?aHRDUVJrQlhTRCt4U29GZ0pqK2ZFdkl3c3RnOURlRzU3U2lTSTFFcWVNcXJX?=
 =?utf-8?B?c3hiWTN5OUMvUm5GQ2lFclJEZHNIQWFPc3pFK1hTVnF2RmU3ckRzNTFyQ1pu?=
 =?utf-8?B?ZkZNWFZOZnNMeFE4czFLaVlEVGt6WUh1ZTRuQ29Bc0p1L1o0N3dEVUdxOHVO?=
 =?utf-8?B?WGpLUXZvbWhDazZHRHZFN0htalJBUmkxc2JQZDlwRkp6cXBPWEFNZ2s2Wktm?=
 =?utf-8?B?M1NRUmljelRycTVBMTNNNXUvejFCeGNLWDIvRU9iamVEYVNFRXRWdlBTZEEy?=
 =?utf-8?B?UXNlR1N5WjdXNWVwMEQ2bGQxTzF1UlZySXkyTU02Vm5WUjhnZ3gxbHd5bDRC?=
 =?utf-8?B?d0R4OGxsM0pocUhvUVJxSktyZVFJUzBtU0l6QzNBRFF4S2pkdkxONFp5QThV?=
 =?utf-8?B?bCs1WC8vYmlhcEhPQWdQdG5CYk54YllvU05wREsxZElQeEJPV1FxL3ErZVpY?=
 =?utf-8?B?UnU5UDNMNTJzR096UFQvdDNPMzlmU0RQc2dGckxWZDFzZHZwT1hVRWR0ck9D?=
 =?utf-8?B?TnpqQUxKTnZaOGRPUTYwNDN3cmZxWkRaR2RicnE2WkNUR0lvNmt6Y2h2eWQz?=
 =?utf-8?B?ZU9kOSs1OGdJMENzQko3bHh4SzZ4ekpUZElCMnBYNjJnbEhiRUF4TEFTNDNv?=
 =?utf-8?B?cEtKRHlyV0ZOLytyK1d6WVVxT29DbFZsQ05HZWsveHNkcC9nNUcwUm14TmJn?=
 =?utf-8?B?bkMrc2xnaEpab1RHMThvRTNIVHlJdnA3bTdUMnFOL083OUFXOWpIWVBoeUpC?=
 =?utf-8?B?ckFGd200SUNETHhtU1NFNG1jeWd1N2JLbVptSFJ5Y3RCblZNc0lCTmJ2MEQz?=
 =?utf-8?B?ejhKcGcwTU1QUTFIZk5ZQmQxOEpzUnhjampRZDNjMUFPMjY0NnAxZW02M05X?=
 =?utf-8?B?WXNlV2txdDBqeDF6b2IrNE9sNEZnUlNFODBLUGRla08wS1p1KzlBTmJmRGtt?=
 =?utf-8?B?LzR1Y1YvWEJqZWNVMEFjaTBjOTNTUjVrbS8vZkh5WkNqT2p3MkR3MHhPSENI?=
 =?utf-8?B?emQ4WStSZjV1T01iU1RtMXVrR1B1aUVLU0NyQm9QRm5FZWVheVJIc0J5dUhy?=
 =?utf-8?B?cUxKMlV5U2k4S3gva29jWDRUckhrZHhONmxFS1dQbCtJSTQ3OWFVZGdjSmJJ?=
 =?utf-8?B?dnNoWmhESEdoQzVaYWRoVUp1UFNzZll1RmY0OCt1Rkp2U2pweFlxWHFybTdj?=
 =?utf-8?B?Qkp1QUR5NHI5TmRqQWxHZmZUUW5xN1FIYTBXWTZ4L3FsS3hkMHF0QWFrRUJZ?=
 =?utf-8?B?aE9ZMTdHNTZTSGFoNDJpUnJob281SjJkZ2wzamIwREpJVkJ4alk2U1ZMWEpV?=
 =?utf-8?B?OWU1SVBBNnR1N0RXNFg3M0hQZVVaQllLSTg5d2trTHppY2NQdjMvR3hlbVZU?=
 =?utf-8?B?MTg1S1F3Q2QvUzZ6bVVNQko3R1huQTR5ZzdNTXMvUXRXU1poc2M4d2l6NHJz?=
 =?utf-8?B?Z1FTdFdnWTZ1UzNCamdJMVlvd0crbkJGbmlKZElGaXhBU3dQczVxbmRkcW5x?=
 =?utf-8?B?Rm12cmd2dmY2RmM1QlQ4R1pVUWZENitrdWtlVWZjcGMvc2p2dlJMdU1oV0My?=
 =?utf-8?Q?VWlDC6MgYSkLe?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM6PR12MB4202.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(7416014)(376014)(366016)(1800799024);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?VWQ0QVYxYnpvTTFIQUJMOU1tWWhETGpuVlBBbnhZTDdBTnBpdlFpTkFqME5t?=
 =?utf-8?B?OFlZNndwNUdVNStxNnRCZnBRZVgrT0kzZ25DdUZGbXFyTlptSjFkTTF2UERD?=
 =?utf-8?B?YUlRT2pTQ1ZDRkJUQWlFL0M3VUh1L01kRUJDaGw3MkZhZkw5WXlhNDd0YS9z?=
 =?utf-8?B?WG16Z3dhd0tMQndERWVDQ2RxZzJSY3hYSjVSUC85VUorU2QyVVJnUlpjWFBM?=
 =?utf-8?B?TTRGTFhvM2pMMnZkWTFoWjh3YnhNaDJCbXhCQ2VKSk0yb2dmWG9yNi83RDRs?=
 =?utf-8?B?TDhLMFlPd1N2bHZRQldmZTRKVGtISjgwNWJHQkFXTU41V0hrM0paMW9GaE1r?=
 =?utf-8?B?NGJmVU9MYmZnclN4SFh5T1FTYnNEem5iK3IrNVVaOWNRSmxWWEx0djZBQjRH?=
 =?utf-8?B?R244dHVWM2xERDJDVEMycGJVeUxhOW12STZLNWFuUXlHK09XWlZGSmtKdXFB?=
 =?utf-8?B?WHdkWFNwMjQ1aUZKOHBnSGNTcWhTdUhuT0NYNUIwNEMyYlhmemw4RzNXZFFE?=
 =?utf-8?B?c0MvVmpUSStNLzJiaDh0a2pBWGFWUkpxTk5vYWV0QXkzYnpPSGhMaU5JbThM?=
 =?utf-8?B?MVlmZ21ickZyaHdWZHorZWx5eVBPOGF5bk03aW5lQTh5MTNsdEtjTDRkaEV4?=
 =?utf-8?B?TUtYRTNKdHFiZlNRNjQ1VnVHTlBBM0JnU0hPejZHa0RnVE9Hc0xUak16U1Bp?=
 =?utf-8?B?NFhldXNOeGVlS1lPWXRvd0lqL3JpdnVKSEdRblBvYmpac2x1MGJtek1nWHdJ?=
 =?utf-8?B?NmF5Wnc1K1kyaGdqQmg2NlhuWVlXc0NRbkc2OUw5UnVWeGNlVDJiaW9xRkZB?=
 =?utf-8?B?ak9mVmR4SnVJU1FGZHNKS2F0Y2pGeS9lYVlSdnc5bE5aaEpFbFh6bEtCeXZv?=
 =?utf-8?B?TC9kVEJMYzhOTGRBVmRaWEdDZ1BQL2NBNFdMNkhWK2t6dCtha04vSlFGWU91?=
 =?utf-8?B?WExyYjVmSDhtWXMxNTQyekNqTEhSOTNKdmk5OGFsWEVJRENvMVpKTTFVczRs?=
 =?utf-8?B?Zzh6SjVtMGVlSGR5aXgyMTZzYW5QYmNSOCtoKzBYWEtyS3FWd1lJVnJMMlBp?=
 =?utf-8?B?UDJqczVKWWdXV2IwNml5MmprMjNxNU1WUGUya1VPMG44TGdYYkw1UHRoeWdw?=
 =?utf-8?B?MktRVXl6VHkwRzFCSHgyNG1nZGRBbTRBWDBoZDFZTFBPdGw1bzN2cng4U0hH?=
 =?utf-8?B?N3ZwaWlxcmlobS8xOFgxQUVqYnVGa3lpNGlvbkdhWWloL2U2aHFodlY1WVJJ?=
 =?utf-8?B?Ymo4aFQ3SnpLRXJnYmVCdWY4Y3M2MFdCWFI2ei9wRVNEc0V4dGxTS1RjVC9V?=
 =?utf-8?B?blkzMW5JbENVaE9BcUdLOC82YldWbXR0WkZCZi9WenJFSEdOd2d2SHRsbGNh?=
 =?utf-8?B?Zk5kcEFucitqYy9ma3Y2WU1BOGJEMHdDeEdhZ01aNm9LQTlKaUlUSmN1Nm9k?=
 =?utf-8?B?MnIvVE1zd1l0T3dpSWJvOWVNbjUxTCt6VmpBUENxS3Nvend6ZW1CeFhRdCtE?=
 =?utf-8?B?SlpnOFFBNXpMVlhpVzRXZWVWZjc4OWFhMWREMU5icWF1RTdpMjQ0WmcwcURz?=
 =?utf-8?B?UFNqbHcyZlBQOVJHc0lIUFV4dGQzVzg5VDV6RnlKUUIwNDRUa3d5RnNtODJM?=
 =?utf-8?B?MEV2UitJTS9Za0FQcjZPa2h5c3FEcWM1aGY5czhjRVh4NG1sUlVYRm5mMHJw?=
 =?utf-8?B?WVNaR2FaVStsaXpZMjVETlM4QUJYQ2dQb3luek5XK1luQlp0RDZRVjJYZUZO?=
 =?utf-8?B?QzdZZkpOQ0RDVk15Q2gzWWZsY2NrNWtTL3NJQXdQcnRIWHdya0dlRmhjK2Vo?=
 =?utf-8?B?bkVwT05rbTBkNDdiYzRtM3B6KzJnUmRmK1BhY05IODI2R1dON0N5NDZ6NVJ2?=
 =?utf-8?B?VTIzNFZySklYckNsaFZCTU1tM0NTR2JqbkhRcWVjTmhldzVTc3MvRWRRMzZi?=
 =?utf-8?B?QlVadStxWHdva0ZSZUJacDkxYVBJeDFrbjBpaTAzTllPRHgycTI1cHpIeXdB?=
 =?utf-8?B?NEloeXpKN09Jd3BhNHNjb2RNMlRhbHp5REtzREkzSG5tTzNvYXYrZXFxZGFT?=
 =?utf-8?B?WXE3RWFJK25JTWJ1dUpITEhkdzRsRTdoRlU3dWdZMXp0dWJ3ZTFvcHY4RzVR?=
 =?utf-8?Q?3hSsPfY2L0GR+qlbKRXfEwe+e?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 2cc10613-61f5-4634-5b09-08dd1b6bae7f
X-MS-Exchange-CrossTenant-AuthSource: DM6PR12MB4202.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 13 Dec 2024 11:45:46.2006
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 2vqhA7m09oCXCNqN0C6t+JxYrYh/NwRoj1SH/q8ffjTpcZG5LAWFac8QtDvdAHCeTtk1dNza45MyYFFKKnJ8Gg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA1PR12MB6725


On 12/13/24 10:24, Simon Horman wrote:
> On Fri, Dec 13, 2024 at 10:20:30AM +0000, Alejandro Lucero Palau wrote:
>> On 12/12/24 21:22, Simon Horman wrote:
>>> On Mon, Dec 09, 2024 at 06:54:29PM +0000, alejandro.lucero-palau@amd.com wrote:
>>>> From: Alejandro Lucero <alucerop@amd.com>
>>>>
>>>> With a device supporting CXL and successfully initialised, use the cxl
>>>> region to map the memory range and use this mapping for PIO buffers.
>>>>
>>>> Signed-off-by: Alejandro Lucero <alucerop@amd.com>
>>>> ---
>>>>    drivers/net/ethernet/sfc/ef10.c       | 48 +++++++++++++++++++++++----
>>>>    drivers/net/ethernet/sfc/efx_cxl.c    | 19 ++++++++++-
>>>>    drivers/net/ethernet/sfc/net_driver.h |  2 ++
>>>>    drivers/net/ethernet/sfc/nic.h        |  3 ++
>>>>    4 files changed, 65 insertions(+), 7 deletions(-)
>>>>
>>>> diff --git a/drivers/net/ethernet/sfc/ef10.c b/drivers/net/ethernet/sfc/ef10.c
>>>> index 452009ed7a43..4587ca884c03 100644
>>>> --- a/drivers/net/ethernet/sfc/ef10.c
>>>> +++ b/drivers/net/ethernet/sfc/ef10.c
>>>> @@ -24,6 +24,7 @@
>>>>    #include <linux/wait.h>
>>>>    #include <linux/workqueue.h>
>>>>    #include <net/udp_tunnel.h>
>>>> +#include "efx_cxl.h"
>>>>    /* Hardware control for EF10 architecture including 'Huntington'. */
>>>> @@ -177,6 +178,12 @@ static int efx_ef10_init_datapath_caps(struct efx_nic *efx)
>>>>    			  efx->num_mac_stats);
>>>>    	}
>>> Hi Alejandro,
>>>
>>> Earlier in efx_ef10_init_datapath_caps, outbuf is declared using:
>>>
>>> 	MCDI_DECLARE_BUF(outbuf, MC_CMD_GET_CAPABILITIES_V4_OUT_LEN);
>>>
>>> This will result in the following declaration:
>>>
>>> 	efx_dword_t _name[DIV_ROUND_UP(MC_CMD_GET_CAPABILITIES_V4_OUT_LEN, 4)]
>>>
>>> Where MC_CMD_GET_CAPABILITIES_V4_OUT_LEN is defined as 78.
>>> So outbuf will be an array with DIV_ROUND_UP(78, 4) == 20 elements.
>>>
>>>> +	if (outlen < MC_CMD_GET_CAPABILITIES_V7_OUT_LEN)
>>>> +		nic_data->datapath_caps3 = 0;
>>>> +	else
>>>> +		nic_data->datapath_caps3 = MCDI_DWORD(outbuf,
>>>> +						      GET_CAPABILITIES_V7_OUT_FLAGS3);
>>>> +
>>>>    	return 0;
>>>>    }
>>> MC_CMD_GET_CAPABILITIES_V7_OUT_FLAGS3_OFST is defined as 148.
>>> And the above will result in an access to element 148 / 4 == 37 of
>>> outbuf. A buffer overflow.
>>
>> Hi Simon,
>>
>>
>> This is, obviously, quite serious, although being the first and only flag in
>> that MCDI extension explains why has gone hidden and harmless (as it is a
>> read).
>>
>>
>> I'll definitely fix it.
>>
>>
>> Thanks!
> Likewise, thanks.
>
> Please to look at my analysis with a sceptical eye.
> It is my understanding based on looking at the code in
> the context of the compiler warnings.
>

Yes, I need to confirm this, but it looks a problem.


BTW, I can not get the same warning/error with gcc 11.4. Just for being 
sure, are you just compiling with make W=1 or applying some other gcc 
param or kernel config option?




