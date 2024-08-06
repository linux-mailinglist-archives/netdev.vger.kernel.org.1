Return-Path: <netdev+bounces-116143-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 57B9D949453
	for <lists+netdev@lfdr.de>; Tue,  6 Aug 2024 17:16:36 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 8E29BB23A7A
	for <lists+netdev@lfdr.de>; Tue,  6 Aug 2024 15:14:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CA5F31BD50A;
	Tue,  6 Aug 2024 15:14:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="RtEnxn+r"
X-Original-To: netdev@vger.kernel.org
Received: from NAM11-DM6-obe.outbound.protection.outlook.com (mail-dm6nam11on2085.outbound.protection.outlook.com [40.107.223.85])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 420A61EB4AD
	for <netdev@vger.kernel.org>; Tue,  6 Aug 2024 15:14:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.223.85
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722957261; cv=fail; b=Uj2wROpS0v7sTJmUVnwFbOWxl+G4zHlSXiLokEx7ak3riA9aJGZprR/XdUQEn8DbRZ6FmtO2FhCaJop+ZU+psaaqxw+KBHq2sboHJU1EV4fqlE8UvCeI7M4VwxUtuJhJ+dLplb3oXOv9ndPiUa5UzlOTbNWQSN5SshGhemWAvm8=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722957261; c=relaxed/simple;
	bh=OWtfd9WSSUb1nmaMhqS9XG5QFZid7OUP0wd4gljEB/Y=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=WEulht2W/Ih5Vvk8Iq9XsWGQCIgP01LDMiUpmVok2Y9tN5Ik8g/RzoN9/aTY05PbZ/nRodij2/HlgkPB91sIBmmiT3XHqNDujam2h2wMkfpllqcp0ti+EGvUATjVae54eDGcUi15GjZ1DX319ipSkjdhE0Xp5U7v++qQMvvTTIk=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=RtEnxn+r; arc=fail smtp.client-ip=40.107.223.85
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=jMe+fQsbKwAItFJfo3g0okUpyfHBTkDpcWU9xtbRPwlyiizVrc6t+H/t9JVj7+F3oR/MOcNryXyMLIwk0/vzhljq0R0dCQGn9JM5Dh0NUH8lZiVg5xJmhmNYRTwlRtzWGkzIgvZG4oe+h2xzMBMofrkuKh/78JOomUJxmACSylKav72elZtbgfHHIRH1owU7sEIzb0oYvYYnontU2ctrpdatPK/puMPzVaRcTgII20ak3hVv2JYsgwQV62aZJ5SypO0m4+WOfD0g4m6pHg3NEag8FX0kTPLf6vUZoF08iS+pthqetVFYCzcGVyYEUaH2jO1vl0bdhMzKHFzc9cw6jg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=yRvSjk1CRjBxjigulmvm0TWSD/O15mLzKGSiGN53Z6Q=;
 b=SnM43fdos/gVlxtkg+89c0V289zWLW9liYux7NLvWMKHx7wbuB28wRYHZR9sZ9TTS5K1h3erULFmXAGIWJuY1GXuK8awcUhQRRkagF27MhTlTs1I6bxEhkxk9iBVpX/42sO64kC7VUt02xl9CP0gydemqx6RJjTi/cPlLRyDKu8HLpLYt9asfk1+Ag/ctMPpsBSWsthS0Jvx77FRPGrnn//CcDuL/JSf8HWAivsa2iBKi+ir5xRjBItmA57y2d5QuBHwA0fcxi6DD4Z5XCAerp+5ePBOy+xa+r5V7kTAnAsiUU6bu0BbdNG41I1MdQSseVicBQJTT/o3cHfzZHQsuQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=yRvSjk1CRjBxjigulmvm0TWSD/O15mLzKGSiGN53Z6Q=;
 b=RtEnxn+rQBJx0Oe5CiLUzcaJgkUf/wHuqD7rYchLxIfauDTg1I1d0XzadI0MKTpVxT0ID5SaMyc4YHK24vjNKLuffonA2zAl5SyheYpR0OH5cPGtHtvOJCjAeK3NDX6AJ9qF82kBACHYHA56owED3WVWn3gc3v9sMTxW5NkBFaNx2wG7omAdBY4sn1aBFYuViCxiLtvwSxBPuVIC5k6zum4ogWwSLPJPC94VAMVv7IzoFQ0vlbQY/nl1oi8bUCXKOJHSd8iPEXu9j6OPDmKL1tcepfV+NvOZf3qjIFKw9RNCOEXO7OeR0jP8UWg9bjLdbRcRyhcUwSrkDou05XLISw==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from SJ2PR12MB8691.namprd12.prod.outlook.com (2603:10b6:a03:541::10)
 by SJ2PR12MB9116.namprd12.prod.outlook.com (2603:10b6:a03:557::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7828.25; Tue, 6 Aug
 2024 15:14:16 +0000
Received: from SJ2PR12MB8691.namprd12.prod.outlook.com
 ([fe80::63d0:a045:4ab1:d430]) by SJ2PR12MB8691.namprd12.prod.outlook.com
 ([fe80::63d0:a045:4ab1:d430%7]) with mapi id 15.20.7828.023; Tue, 6 Aug 2024
 15:14:16 +0000
Message-ID: <689e3854-12c2-4958-9080-e3b0e16c1402@nvidia.com>
Date: Tue, 6 Aug 2024 18:14:06 +0300
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net-next v2 00/12] ethtool: rss: driver tweaks and netlink
 context dumps
To: Jakub Kicinski <kuba@kernel.org>
Cc: davem@davemloft.net, netdev@vger.kernel.org, edumazet@google.com,
 pabeni@redhat.com, dxu@dxuuu.xyz, ecree.xilinx@gmail.com,
 przemyslaw.kitszel@intel.com, donald.hunter@gmail.com, tariqt@nvidia.com,
 willemdebruijn.kernel@gmail.com, jdamato@fastly.com,
 Ahmed Zaki <ahmed.zaki@intel.com>
References: <20240803042624.970352-1-kuba@kernel.org>
 <05ae8316-d3aa-4356-98c6-55ed4253c8a7@nvidia.com>
 <20240805151317.5c006ff7@kernel.org>
 <cbdb41f5-c157-49a5-acc0-cbce5516ea62@nvidia.com>
 <20240806072041.06bf085e@kernel.org>
From: Gal Pressman <gal@nvidia.com>
Content-Language: en-US
In-Reply-To: <20240806072041.06bf085e@kernel.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: GVX0EPF00011B50.SWEP280.PROD.OUTLOOK.COM
 (2603:10a6:144:1:0:8:0:a) To SJ2PR12MB8691.namprd12.prod.outlook.com
 (2603:10b6:a03:541::10)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ2PR12MB8691:EE_|SJ2PR12MB9116:EE_
X-MS-Office365-Filtering-Correlation-Id: c1c4e552-9a0d-4550-124f-08dcb62a6fca
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|1800799024|7416014|366016;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?VDJNNXRSK3NjemRFM0xPQ1RXcGFpUnYvcW5JNTlBNzlRbUpXMmpIdFJRZTR2?=
 =?utf-8?B?SGJmc2s5NWRCM0I4ZnNwRmFZYStMTk1sNUJ3ZTJMSlpYQzU3TVlUb1NWRDdD?=
 =?utf-8?B?U245MmR6clNjQVp2aEJoeGFPenpJNHNybldtbnlQSHY4L243b1ZVd1JZRVZG?=
 =?utf-8?B?UXVNb1VLbUdWVmFsc01sMDZucG5BS1pSelJRcFNVcDg1M1ZJZ1dRb3FvWm1y?=
 =?utf-8?B?YW5EaWx5ckZxR2xBVzUrT3Z1K1lBbGlxS3hhckM3OWQ3YmVIdGhpNnJMajBz?=
 =?utf-8?B?d0ZJQklUbjMrM28rNVRNUzlUdlAzaDJ1cndVYVhDOVR0N2Frb2w1dHluQ2Zj?=
 =?utf-8?B?WVdEOUg3NElpQ0w2cEQvTmRHYWtNdDJmSU9GcWdIZkZjeHVyZkRwZlo3WWU2?=
 =?utf-8?B?RXI1ZEtocHhiTGdNZVpia2oxRnpEbm9iN3U3STV3U2RmUWJJWHQ1UHg2cWV3?=
 =?utf-8?B?Q2p1ZE5tWnIxN2x4enlJNVZkWVJoTlVWOWkyc1NxYUxWUUs5Z1I0TjFMOVUz?=
 =?utf-8?B?KzNGdE1RSmMvNFBiNkhIbDNxUktKS3pPaWFoR3h5UjFkYkowN3lBeGF6RHN1?=
 =?utf-8?B?K0NHS05xL0ExRkpwQU9oUUlXSlRjR1gvUUpzeHVYc0MydnhMUi9sNjNmM1F6?=
 =?utf-8?B?MEVJU1dDSnFJd1VYN3VmdHI0UFM5dEl0Tm5pNEg3aXU3Y29BRXFFamhNNE9C?=
 =?utf-8?B?SkFQVzFhUXlhRHp2eDVmMFBPMEF3WnU5Z1E1bkhTSnN4Y1pyOUY3c2hkY2Jz?=
 =?utf-8?B?TnYxRkZrLzdPY1ZJdzI3R2tubk9UMldob3d6YWgvdFJnR1VpZE5Ka2Ywdmts?=
 =?utf-8?B?c3J0VmtRSXhiUHZZOUZLRTVxRElIR1dtTmN0ZmRzbkk5aTh4OHRQZ3Y1OHVM?=
 =?utf-8?B?UGZCeTJhOGEyOXg2WDdzUGNXZktNa3BoNUxlTWtUM3lRV0h5bFp5N0FVRXdx?=
 =?utf-8?B?M3JMUlJtcko0NzFNWmtPOXYzQU5SS3RHeTQ1bXdaL242WWNwbjViZFFJd1Rq?=
 =?utf-8?B?ZDZxRHRWWWFhcUxwNFphVFVqRjE2UU1iSXBWMGtlMFFvYTJ0azJvUmtDcytR?=
 =?utf-8?B?OWExZ3dvNGFjNDd3dVkvaDJ0MVZwOXhiRllHRm9OdksxaERFY0pqYXN3UjVk?=
 =?utf-8?B?MTNSWldxL1BwWXNMRTZlM05aUXFLZzFoTUsrQkhuNEUwUURmdHBEckRtN0du?=
 =?utf-8?B?ZlU2ekxUWXdqK0dpeG9aeDhZeVB6OCtFS1YxcmRpSnpCazd4QzRaWnJpNk1K?=
 =?utf-8?B?ZDhQeEpFRFJ0L0lCblFQcHJlcDg0RG1YSGFuYlBSUkdUZElvSXN0c0pCangw?=
 =?utf-8?B?cjdacWpvZXFRUS94Tm45eFpIS2w4VS84b0ZqdG1qelhKT1NwNE96VXFMckx6?=
 =?utf-8?B?WU1jRzcxb1U0b1BvbkJKT2hYYklLN252bWd1SlpKU0Fkdzd5bVlEcHhRZ3hY?=
 =?utf-8?B?WmNqNXlPdUdpUUNFeThSQjltNmpKZWxVZWFRMzAyaytwZGJnc05hVjZsWHNt?=
 =?utf-8?B?SC9oN3pNNlRwUm9yZkhtTHJYOEtDV2RjajJzcGp4OUtWU1lyem84OWl2ZXV1?=
 =?utf-8?B?OVRvY3pabzl1L1VrMEZpL1gyWVRmTzkzOTV5V1p3eno1OFNLMjY2aHdZQW02?=
 =?utf-8?B?SEJvSXp5K01ZdDhscUUvUVJtSURxWUJZcTJrMHRGUlJlc3J0ZHlIZU9tZi83?=
 =?utf-8?B?K09aMHRIakJKeHhCWjFUcW53RnpDY2NaZk5VRUQ1Vk00U3FFbXRFUEdoZSs3?=
 =?utf-8?B?NEZmSVhXMXdnYVF0TEtHU292T09kRWYzNGs0TjRyRXFES1A0eVlKUnVXb0tj?=
 =?utf-8?B?ZE90SFgvNVpjajNDVTVzZz09?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SJ2PR12MB8691.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(1800799024)(7416014)(366016);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?cDdJRWl0WlkweTdBbGRIUWVkazFOOWp0RmNwRUJNeEkvTlJvVEVja3ArOEZv?=
 =?utf-8?B?Z1p0K0tCNUpJVXNOYzJ4L0dXVjVHZnhTWkFDS0V4NXBNNjBweWhTYUx0QVVB?=
 =?utf-8?B?MXZnbTduSUVwdXJQN2hTOTlNTDlSM0xDdmQ3NnBJNkNzVExlcmlBS1NxalN2?=
 =?utf-8?B?SmdIa2ltWUxOd0dUbGN3Z1doUTNWMVp2RTJCWnY1VUxxaExoM3YrSWtSVzE3?=
 =?utf-8?B?d2JWOGdBSDJRMlpoZllQSHV6QTJCVHo3Ny9MdVBzaFFPNExHdjhLTUlEL0k3?=
 =?utf-8?B?aWpuSlVLUmxKdnhsRDhQNHc3dHRiSDBveERDTVJtYlY2RlpOOExnNGs0bEN5?=
 =?utf-8?B?a1JNTHRJUEYrMDNZcWZ0RjRxbHZSMkk5U0R1Z3RRMHRCaDFFT0UyaUp0cTZZ?=
 =?utf-8?B?eVl3UGlob002UTVuaDdBU2hoZ1I3N3FlZDhOVVdzVE5RYXFCUHA4cUt3WDZm?=
 =?utf-8?B?Q2NpVGxYVENGYmJycWV6U0p0TEhtc1NwWWhqOGpPSk4yNk5nNWFIVmUrVU81?=
 =?utf-8?B?K2FOSTlwNGJGZEVGaWlDSlJGNzk3VlRpd0gzTkp4Z0RBTFZEWXU1REwvT3Vi?=
 =?utf-8?B?dTZKS0s2ZDZXdG5JOVNaTmJMWHV2djk5Z2c2RGhuaU9temo1c0hkTEt3R3FM?=
 =?utf-8?B?UDRIRWNEQUxXZHc3cTBRcWRhQU0wdWhGbm9ZeHowSUVYSU1WSndDM1ZXRTdJ?=
 =?utf-8?B?clR6U0VQQ3k4a2kvWFVvUldSNVFWczZ0aEx5QU4rZVowMWN4Y3dLQWtoblRG?=
 =?utf-8?B?MC81VUZvSFZwQ1BYQVcraEZQaVVPS2owTnh0ZElvaHp3L0JKM0liQXZZU0xu?=
 =?utf-8?B?T0ZlN0U2ZlczbXZOY2tBWmtuVnNiOFRCc05XSmc5Q0FocUJYbHU2WFVEZER2?=
 =?utf-8?B?NUNQbWh6eFBVYWIrTjJjdDNwU2ZSZENNaE14NUdzdiswSFpvbEV1eGdOMGR5?=
 =?utf-8?B?eVBMVXVsNVRvSm5zemxWR3E0em5qSU5XZEYwUmFSN0QxNXdGUjY3Z1JNdkdm?=
 =?utf-8?B?NXUvZWFTYjVkekFrWE56U3NJb2ZrK1FkVVd1TXBDbXpOaEVIdWpzSytPSm5s?=
 =?utf-8?B?UENvZFBiMStuVzFLUG5JSEJZVEFPcG9NU3lGZ05SODdEaWdxNXBWVTBocG5w?=
 =?utf-8?B?UC85TkRLQ2xPc25QNUplWU15SXQwVXk1dVZmZU1uK3pVeHYxV05UYzUxVTFp?=
 =?utf-8?B?MHpvRnhJU1VyeGk0M1M1dGJoUXQ1UXB4M3p2bGg1Tyt2OFVEV1NFMEV5KzRU?=
 =?utf-8?B?NGF4WWVQdVVhVXdBQVY3WEZNN2hmVWRsbFZRc1hlTkRDUXpVNXZya0d5YVpt?=
 =?utf-8?B?ZWZobWFkc3pMaXVKMDkwTjh0RXZGSzJZWUZ3YWp6MGNiZk8xU0xGbFQxcDAw?=
 =?utf-8?B?RTdFQmh3R21xcWRxNnJsTG4wY0tnbTZLbDVzRTBxbHRrak9XUDUwZ21xRWJs?=
 =?utf-8?B?REVPTThXRjJuVnNsTnJ5Q0kzTjAzLytEakhaR0FxcENPQ3dDS3hFc1dHYlZT?=
 =?utf-8?B?ekF6MG9RcW50NzVIUWdBR0RiclVmVTNaV0FubXQ1d1ZUbWt3a1ZyemYwVlJw?=
 =?utf-8?B?Qy8xbXROcGVieEMwcENBY0FkSmtEZ2RTczdHZmFjS2NWMXRnMUtZSG5vcUly?=
 =?utf-8?B?dE51Q01KQmdGdU5pQ1pLV0YwRnNCTWUzMnQyZ1g1aUJnVXNQck9JWTVsS3FP?=
 =?utf-8?B?QnczR0xXRGVHUUVuOVBFQzZNUnprSFJCQmZJSWhHRURkTTd1dWF2VUJvc3Fv?=
 =?utf-8?B?N2xHWFZvTnZseHdLOGxPU0RXUnBYVFQrc3E2WU9ab2hrVGMvMVdlUUlTVEgz?=
 =?utf-8?B?djZFVExlck5lUWVITFlsa1pLU3BJZS96YUNNb3NadjEvRHpQVnNZcXF1MUNk?=
 =?utf-8?B?Q3hRc0djNWVhUmsyWE5qS1RVOGlMUWY3VmI0UnZBY1BtMDlOSGM1U1BLMDRF?=
 =?utf-8?B?bHM3S1RjOXNCdkdvYzVBaXdJclYrdjNIaHdPVzYxcTdVQ0FzdHZsdEdtUks5?=
 =?utf-8?B?TG1YSno0Q2EvdEF0M0QzeWZWMGw3REwzNTB4YnpNRnFneEkzRXVCNlcyYmhp?=
 =?utf-8?B?RGFYd3BUVWJNa3dVSldVdUZVWUxINXQxVnFZb28yQVJWcEE3YmpEWGZkR1hU?=
 =?utf-8?Q?SBVo=3D?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: c1c4e552-9a0d-4550-124f-08dcb62a6fca
X-MS-Exchange-CrossTenant-AuthSource: SJ2PR12MB8691.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 06 Aug 2024 15:14:16.3540
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: FlfvqKlHPBi+qOxMCQPf14JXeQ/s6c05t0502JpecHmY/1Lq2FqA0BCpp2nE5Qmn
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ2PR12MB9116

On 06/08/2024 17:20, Jakub Kicinski wrote:
> On Tue, 6 Aug 2024 15:22:07 +0300 Gal Pressman wrote:
>>> I guess we just need to throw "&& !create" into the condition?
>>> Sounds good!   
>>
>> Yes.
>>
>>> We should probably split the "actual invalid" from 
>>> the "nothing specified" checks.  
>>
>> And make the "no change" check return zero?
> 
> My knee jerk reaction would be to keep the error return code.
> But I guess one could argue in either direction.

Yea, maybe it's better to not risk upsetting users with a behavior change.
I'll start with a net submission for the fix, then figure out what
should be done for net-next.

Repeating what I said in my earlier mail, I do not think there's a way
to actually solve the compatibility issue. There is no way for the
kernel to differentiate between old userspace that is not aware of
input_xfrm vs. new userspace that explicitly sets it to zero, I guess
we're stuck with this bug :\.

