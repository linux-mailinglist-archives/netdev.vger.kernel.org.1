Return-Path: <netdev+bounces-202912-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C7F85AEFA81
	for <lists+netdev@lfdr.de>; Tue,  1 Jul 2025 15:29:36 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 953BB487C35
	for <lists+netdev@lfdr.de>; Tue,  1 Jul 2025 13:26:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9A54927933A;
	Tue,  1 Jul 2025 13:23:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="R+0cHPoF"
X-Original-To: netdev@vger.kernel.org
Received: from NAM11-DM6-obe.outbound.protection.outlook.com (mail-dm6nam11on2089.outbound.protection.outlook.com [40.107.223.89])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1DFA4279337
	for <netdev@vger.kernel.org>; Tue,  1 Jul 2025 13:23:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.223.89
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751376237; cv=fail; b=A/StXsOY4+j7D0WfT0aCW4aCk4GdsTu4k7R8rFswbMb0aHkUYvb4WpcBbprYktLRYZn7Qbc5BEG2ZEi+naD0tUwZmU717MZ7kkSxSH/lcxZM6uXLMlLUPQGYID82jF40LrVwF5FJAEghrTCG/sqAQL1hUlw7DXWtMmu2kfn5SbM=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751376237; c=relaxed/simple;
	bh=uDYokywU/bkDaxNp5zY/bDpnh7gy7kFjH5eXx1wB/+c=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 Content-Type:MIME-Version; b=laxUMayiOpC15EOAez6Kis/SfjZpNeOtcQrmhHAtxo/oqLffdi3GeBKxQbVjPtPyv9sKUY4xibtJMikk60K9eSgypl6PxcJAdR6ZvQ7kjwPU+s/WKSsGeG7sPcNMSWS/3eUY2KqZPn1aMn/X8MBsnXUuMy0bZmREUSckejAYqVo=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=R+0cHPoF; arc=fail smtp.client-ip=40.107.223.89
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=mYaPvfTXlsrywvd1UKd0OGtnAyfHEYZLVd9Mka9SSTLnZ8cwvZHgEO0HW02uHuDlHN4vKezw3ydfwypZKYqIRKBIxGFfQfcCw3P3Y3mUoclEok5dngPRGuvwCePTleL7qwOMEW9EUCG7DZATV8l4BTWLhn9tV1jkM6hBKd1UgkhIzHJmAS8LPGrdid5n0zvuAyGO19V64w/j4yEz7yeJuPoP/TyIMqT8f/Al/aMOjE+T4GgRbUSzbJSiSpZkhGaQUNsQWO0pyk37qCLezbOZD1l+NnaJUFtXzGG8F4u0/a+Skwt/fLi8SIpaBK74XfQUvgtB7q+UMY71OCKvqywoog==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=kbopjbMX05HsGEB8b9CMGwcN2421EIHxwznTQ/qwPqs=;
 b=m4J9JL+X/wAEgn3wrLCS+Wu4sB8jg1Mhy7rgxysWqApw6zgHD9aGr6ZhCXJkWOaxBhVERZlsr4FyQanyvIe1WxkCfksq62J3QjN1uH2kqe6fxhFLl3QDh5agaJMteB8krljTWZiowPz2MnZAZTIY8n3KFk0gsFAfDwR0SD8bsx2/EoghO0BAgenFHRDMp+w9C0NHymuRp5LYD30OCBxVktCDgJQL8v2A8MI3Pk38Rm1ew95VAS0pc42U77MiPa31aGe/M5LhBXnCJHR4DRb9hpIbae5MWv/KC5tr/agLXi+k9OivPacQMKRySt1O+mdvWgzqqSJLR1eTis9FnWu16A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=kbopjbMX05HsGEB8b9CMGwcN2421EIHxwznTQ/qwPqs=;
 b=R+0cHPoFzi0m0cR4ityQ9Bt4sXZUqIte9+hOmVzsfXBctuKdyOhSeGy9+ryzf1u+Jt3c0Wi+aj3lZIKZZGBX7kn1KBhs+sabsL2JD8FOoIy6676adFM+QaFbsLNGRYl51CkW4vFO1GcqFic8ufK/hYvNrgviZ3kgZWQAQMP3R+e0V0BkgCnHpRKhZr3rz4Obo9awXN6ix7wZoFoeRDY+DOI2S3lsve1xpa78KGa5So8TZJkPpkAFB4nCr0fh/j5gC8+yx08Ci+DJUCZHOuOrc27ZL2KJGLXUxXm8JAfOv54L9FofqDDYtZEyKsyxMIIulgv6UGUIPo9Kaooi00xj3Q==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from SJ2PR12MB8943.namprd12.prod.outlook.com (2603:10b6:a03:547::17)
 by SA3PR12MB7974.namprd12.prod.outlook.com (2603:10b6:806:307::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8901.20; Tue, 1 Jul
 2025 13:23:51 +0000
Received: from SJ2PR12MB8943.namprd12.prod.outlook.com
 ([fe80::7577:f32f:798c:87cc]) by SJ2PR12MB8943.namprd12.prod.outlook.com
 ([fe80::7577:f32f:798c:87cc%4]) with mapi id 15.20.8901.018; Tue, 1 Jul 2025
 13:23:51 +0000
From: Aurelien Aptel <aaptel@nvidia.com>
To: Simon Horman <horms@kernel.org>
Cc: linux-nvme@lists.infradead.org, netdev@vger.kernel.org,
 sagi@grimberg.me, hch@lst.de, kbusch@kernel.org, axboe@fb.com,
 chaitanyak@nvidia.com, davem@davemloft.net, kuba@kernel.org, Boris
 Pismenny <borisp@nvidia.com>, aurelien.aptel@gmail.com, smalin@nvidia.com,
 malin1024@gmail.com, ogerlitz@nvidia.com, yorayz@nvidia.com,
 galshalom@nvidia.com, mgurtovoy@nvidia.com, tariqt@nvidia.com,
 gus@collabora.com, edumazet@google.com, pabeni@redhat.com,
 dsahern@kernel.org, ast@kernel.org, jacob.e.keller@intel.com
Subject: Re: [PATCH v29 01/20] net: Introduce direct data placement tcp offload
In-Reply-To: <20250701123328.GO41770@horms.kernel.org>
References: <20250630140737.28662-1-aaptel@nvidia.com>
 <20250630140737.28662-2-aaptel@nvidia.com>
 <20250701123328.GO41770@horms.kernel.org>
Date: Tue, 01 Jul 2025 16:23:46 +0300
Message-ID: <2538ql83uzh.fsf@mtr-vdi-124.i-did-not-set--mail-host-address--so-tickle-me>
Content-Type: text/plain
X-ClientProxiedBy: TL2P290CA0007.ISRP290.PROD.OUTLOOK.COM (2603:1096:950:2::9)
 To SJ2PR12MB8943.namprd12.prod.outlook.com (2603:10b6:a03:547::17)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ2PR12MB8943:EE_|SA3PR12MB7974:EE_
X-MS-Office365-Filtering-Correlation-Id: 7e39aba4-70d1-4b8d-05bb-08ddb8a284c4
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|366016|376014|7416014|1800799024|7053199007;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?mNSpZq806W8gIASSbdPANaheHslHSl/4tch7a2RbxC1AcUd7ZwPpETCvRrB/?=
 =?us-ascii?Q?V+2BAtVSPYXAFd+UMWXjMKfp/iQLBn+N2yVkN6FBf/2KAlVIidYMDLTRgLNV?=
 =?us-ascii?Q?Qrxaoc61+o6x6vjq0OZc8fVeTjM9Tlp1xq7lCza8nxww+E/Hr6Gc618yvxPt?=
 =?us-ascii?Q?0oDicz+HYn7EM0DkMxlC/80+noi0fw0muZjTAYIwnY94Dj9sU1yHhlVQMyee?=
 =?us-ascii?Q?Bmv8RoV5UZqbU7D+1ugOJHZJvR9IFUPtLMezJXu6HH5mLpJ+xoC0cjhJg+YZ?=
 =?us-ascii?Q?GAnbhwwfq5jGNoDDnEfFdXl/qTxvQkcsNH7TZeEMu+Rha3TZtHCYU3pKAm7e?=
 =?us-ascii?Q?LhnOdqIdDo0fUuME6B7vTiAQGiReSWjpMKu3croRy9vpnqWWW5vPBj78Xt11?=
 =?us-ascii?Q?QoHaMT22/fzVEqKUGk5HaQqcLzdQuq/MM2oXiFGyLq0UE9yzJXoF0w4YGY4y?=
 =?us-ascii?Q?dJkYz9k7Bhm2Ud1yDe9pQkwX/UBdi287Ij2JReJUynwGyQyt59c8ADgPm1Pf?=
 =?us-ascii?Q?qz9YbN0gV21gYMXWGy/cV4wYpW4KSrQ7gMUZN5ac7uOK3nqrXGluUcAcO1Iq?=
 =?us-ascii?Q?FwJioBPGLzEP5Cv4gvPr7FWY0cnn6dv5l2/XUIO+NBkRyiNM6VDscrAtP9PD?=
 =?us-ascii?Q?nDnp6S8Iutm07M+xVcsaiALrDJRh5mGk+8iPii486+zDCCWOx1HmRN1k9qXN?=
 =?us-ascii?Q?dr7AjueMFQI50zLaxkOLqZVHKtW6o0bK2PUgUXnObYvqQ7oC9ThkD7frMuom?=
 =?us-ascii?Q?8YDQQ0vKdE6Ob4ys1LkDt4GIsEN4mtuwAOaWZ8gFMRqypezxpT7wI0FL/os0?=
 =?us-ascii?Q?2eTp+3pKdlbRo2MPHFTqUx5jV87ft1RDQ8Ydtwgc9EYOyH6mukiPfl87aluP?=
 =?us-ascii?Q?7gAR7gx0tckBlMg58wtanrqHtSIc8qqrMECIvsrzfPZgDxRhGIGCdPGLYhT8?=
 =?us-ascii?Q?/BgIqF6OO/B/7yzD9dgmNP0y/nLNxKR01/0U6acVazJKOMYrQ+gZCxySGpKy?=
 =?us-ascii?Q?8K65s49xaB2UYPGAp3k35gXSzdr2bC2KdiJ0ngdicdCVMT13iPQtPnqBQeO1?=
 =?us-ascii?Q?IJfLel8YpyqDKA+tMm1IIxLbmblVaD46xKHVbs8P6FxhrPm2GlnNrkVkLkfW?=
 =?us-ascii?Q?iF/GK/e/MYiqomCVaECkKbz8s2ka9qalhdx7fCdUzMAKRfEqN0B9U3ELn08k?=
 =?us-ascii?Q?NXmtTx9a1/nfBz8YUDtXLqdZL7LyVpyFP/MImwWxuK7jKRaqqezzdzQ3GSrQ?=
 =?us-ascii?Q?5qMP9hU8ENueFCBZxrlHpR/y2Ng48Z5I4pSD47F19v7nCT8g5V27YRcUPf6q?=
 =?us-ascii?Q?EIWFcke2OfS1I3DTxTUnYRxbXGbD6hC74R8q5/6SXeifVfGl8/Y+/M0UvImu?=
 =?us-ascii?Q?XFPc4KTDTi2U9STOl03uc7K61yRiM2ZHigFZriK4zb44CVkWoA=3D=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SJ2PR12MB8943.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(376014)(7416014)(1800799024)(7053199007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?CighoNukRSckEZarM0TkP8GxFQks/+N3Z6/7de2wCRtXUtpdMl6ashhOqUij?=
 =?us-ascii?Q?YqG3B51ChcR6Wqoj01nxX57ldo9za4Ew+TmFFohw8uKVO0TfYk/18KiHhmOR?=
 =?us-ascii?Q?RwIy90yP9N7en66zsUWSB30S1OddKEoGggeK40h992Cmo2+MIQRSZu39yIYY?=
 =?us-ascii?Q?a1+UigZSdPkPtKZwoOd0m2L4ME84QZRKv2B0AWnpVIFzGnu/0+5+ojuwTFhs?=
 =?us-ascii?Q?slMnxHI+hJVL1tuPX2pfsnXVrkZJUrpud6ofhWl2P5/HbRPvWqVnulWCei50?=
 =?us-ascii?Q?/ZpNk8W8XofUbwoA5b+1+BtBLs9Ebadt7f1+XaxKYWt6QgAxlFj33X0oJNMp?=
 =?us-ascii?Q?SE46I0BZkDy0KmV3u5RDuezdyAcyi9XDvqCX3BMyg4/2QG5jcAz2PnUFE90h?=
 =?us-ascii?Q?pZ1N5HAlsKFCZ/8CPMDzH6k8bliMaKQd9ZXJSXPiomV+JsR75z71DlCw6Pe3?=
 =?us-ascii?Q?xO6Kk8MdBns1XUD2izOufRoa/KjAuNZjwWFnRhxf0xeEpkkwyVYgD0HYY0xL?=
 =?us-ascii?Q?4V3fgU9dh1bcOtfHrcPRRyYctHbtOJaT1h2z3k9E5k1e+XK3ujwWCp+C1kJV?=
 =?us-ascii?Q?G+mds2IdEW+2PKXmddT6U6UrDrFg8gRvBKCOPmaJuPdvCJadnbp2RElujFTs?=
 =?us-ascii?Q?95t/9huZ7uTqM2GUB4x6jFqUzfOLTaU4l+SOwb4KLAnUE6v+OyMQdTjFa0aw?=
 =?us-ascii?Q?8RCE/1UOgasDcM6bpBkbWgeqlSL2jFGOde+7uC1t/SjC00ztZm1Ct/Bt+CjC?=
 =?us-ascii?Q?DomJKYVy5X9yA2Woe4zVEAEPkIVALIJi99FosOVqZL1lSQ01qhb8FyaGb4u1?=
 =?us-ascii?Q?YyTT27MyWyzqxLNCqfB7KzP8xeRMFXvxYU4vexWzH8eMqFDsFas2WTzXzM2L?=
 =?us-ascii?Q?ZkmCEcHP7YBxoCswggI92sJdRG1fKQNKANcMOgFCtKRqBCBPUOeIgOaaDQ+M?=
 =?us-ascii?Q?Y/9lRRLzcBR44l5F8RUtiZpoHk4NQPbcw8nM3hN7VpCMdB6sOnEf1jJS3RyA?=
 =?us-ascii?Q?5WYEZnae6PA0a0efyqR5qprgQ0gBYtUJyDSgD+0lP0mWeCtCAPXc/uCG1o1J?=
 =?us-ascii?Q?/dmISkHcYzJiwchicUmK/KVLySLv/kXrfoUqBk9MQkJ+zF8v2T68gk6PB1gO?=
 =?us-ascii?Q?hGqMqolFv1sX2KFBoIovj84AxQ/emkGU/u0eUsz6T472rdzqkE/Dh4ye2tU9?=
 =?us-ascii?Q?PHW7LqeIqHO/W0QC5YJ+l5f5JqgtPz+eKhpqMrTB8UmROvSRRXtZz9mNbWa4?=
 =?us-ascii?Q?3ck0vwYGTY62SMHPXuq2lqkr0hbcF+LHa6U++Q+dMWzYRFFYXeXSMl+/km4v?=
 =?us-ascii?Q?epO08sjcEusnQfBJxGPFrq9O1Q3Fjy9Nqzs5girJHUu3SvexraMiHgVdZFJ1?=
 =?us-ascii?Q?Buomy6WGj1Ec3rsvhaUMvnKemB2oh42pHCWH24fNLqIPkivQijcUvnu/d5vd?=
 =?us-ascii?Q?CpYPsNTNMttuQVeTLLjAw6Gpo0flLLXqpX/OxkJWoOkYXBudzZ3B8mhz9BXC?=
 =?us-ascii?Q?McardNQOeE6r4Y/SxOBxLvuIOE7Zna5kxYfQaoHCIhQXb4sTeyYimRRyIpsu?=
 =?us-ascii?Q?bdPB3JX22Dlc04IZxBj//LePOwetuWF/ZS1+Ydl4?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 7e39aba4-70d1-4b8d-05bb-08ddb8a284c4
X-MS-Exchange-CrossTenant-AuthSource: SJ2PR12MB8943.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 01 Jul 2025 13:23:51.0400
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: A+euCJOZB1Vv9gqNbsWBZoQDAdXOYtN3Awef8KUxysjdRYSGLrKUhZ+iUPEutEohiv6KdA3IGCBFXZUq/AR1kA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA3PR12MB7974


Simon Horman <horms@kernel.org> writes:
>> -                             sk_no_check_rx : 1;
>> +                             sk_no_check_rx : 1,
>> +                             sk_no_condense : 1;
>
> nit: sk_no_condense should be added to the kernel doc for struct sock
>
>      Flagged by ./scripts/kernel-doc -none
>

Ok, we will add the following docstring:

@sk_no_condense: when set, skip condensing skbs from this sock (see
                 skb_condense())

Thanks


