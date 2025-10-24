Return-Path: <netdev+bounces-232677-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id DDB0BC080CE
	for <lists+netdev@lfdr.de>; Fri, 24 Oct 2025 22:25:37 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 301F14006ED
	for <lists+netdev@lfdr.de>; Fri, 24 Oct 2025 20:24:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8DB4E2F3C26;
	Fri, 24 Oct 2025 20:23:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="H+W9kf9d"
X-Original-To: netdev@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.8])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E9A3928EA72;
	Fri, 24 Oct 2025 20:23:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=192.198.163.8
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761337420; cv=fail; b=CEgiBPjb4fvS+qI5C5MQh1+Bsl6dTsbkfLXQVrIJ8pTtdEmhIzwx/gN1tFNuOXrrSR3PcEvMxQOS+zJ0i9Dd57bXKvv4jhJkaOx5lqOaUftPTidoflSxHi/ke0VL0kt8MHnbBvvb4R8Pd7yBPatDc6pkFpOMh3QV9ICelTz2GXw=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761337420; c=relaxed/simple;
	bh=7gUcnhgd/QxY8pjXKdzb8Q+Y4m1UHhEHnOND6lReWL8=;
	h=Message-ID:Date:Subject:To:CC:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=VSsBFd9d1vFhLcONsaSxwThRwNhSNp5EgMwr5is78a8oqIYdFtnpo5eY+tl8fM/JWIE9bJtDnSJLwvZSkE6FPltalssltKdxv3TiZjARnZWaJAPYT1cNI9DnfkLun0unZ8nocSupt8AKQ8tTM+mu1hxsKiljZg5Zae409okFExI=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=H+W9kf9d; arc=fail smtp.client-ip=192.198.163.8
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1761337419; x=1792873419;
  h=message-id:date:subject:to:cc:references:from:
   in-reply-to:mime-version;
  bh=7gUcnhgd/QxY8pjXKdzb8Q+Y4m1UHhEHnOND6lReWL8=;
  b=H+W9kf9d0MEWgd3diqdHr4b8RWahOmliWVfrHf14SlNKPHpHtvKZtfLL
   uixqIVBpLD8aSCblNaEdZvXBX6MciUwtojqNZUwlYAOSowL2GEahihWEB
   gg/wpziCCmhUPwRzT2Gh6H63OPfIIaRNl0UUOfaSBffPioiB+FMO8/Lx0
   PHND73DUmcqaymbppfH8sJgpCgSKlg8F2bG82vCuwwFQ0PeHZzdyu3wTp
   CWj522Dnk8YbZsWr4tXuKryre3itchE4ppLN7w6YTFJAEBK5PuHQuEiOF
   pJzECn1b+OjVKwOz1ufQt1voEHXkqOEMPtEmRfYjkWByT3liqR8S6Dd/a
   A==;
X-CSE-ConnectionGUID: dT4NszrtTail+o4ZJkSmZA==
X-CSE-MsgGUID: JCq6bXG6RZyLTfBJmVLksQ==
X-IronPort-AV: E=McAfee;i="6800,10657,11586"; a="81150052"
X-IronPort-AV: E=Sophos;i="6.19,253,1754982000"; 
   d="asc'?scan'208";a="81150052"
Received: from fmviesa002.fm.intel.com ([10.60.135.142])
  by fmvoesa102.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 24 Oct 2025 13:23:38 -0700
X-CSE-ConnectionGUID: OwzsdPWvRmaOZdJ5qCaVUQ==
X-CSE-MsgGUID: ySPDAcPhRY6nGGDkzq72lQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.19,253,1754982000"; 
   d="asc'?scan'208";a="208153777"
Received: from fmsmsx903.amr.corp.intel.com ([10.18.126.92])
  by fmviesa002.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 24 Oct 2025 13:23:38 -0700
Received: from FMSMSX902.amr.corp.intel.com (10.18.126.91) by
 fmsmsx903.amr.corp.intel.com (10.18.126.92) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.27; Fri, 24 Oct 2025 13:23:37 -0700
Received: from fmsedg901.ED.cps.intel.com (10.1.192.143) by
 FMSMSX902.amr.corp.intel.com (10.18.126.91) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.27 via Frontend Transport; Fri, 24 Oct 2025 13:23:37 -0700
Received: from PH8PR06CU001.outbound.protection.outlook.com (40.107.209.37) by
 edgegateway.intel.com (192.55.55.81) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.27; Fri, 24 Oct 2025 13:23:37 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=D12hefEcloBX501djqN5A96doOCg7TNK4wYoNSBN3HAfwC8KpDyV45SY3EmPPP+xgD/IMDGVYT9/5ICdah02lUo7LmnuwK7EK65LjD/zr41kDTYhnpa4TAzM6vQ4bdt7pDU7bqzwJLivYtRLX/vFi+cInx8ceaM9XloPzgn+TdQSCwSOKsOVIwpML5OGVKkpD5fufO8hiY+iVqsABMM8hdnAO9ACsW7KaZDBNrhhd4UD3GClhc6QIKqdspMM8FImTGwV9IXpxQuqPvl0X9B7peC66vJa+CZpjgfjspar85D2d94+6aE3RICflLQ2MwtpW2ElpUzNmYXpPxtSgkMsLQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=y6B2YOAVyEOD2m+P/AZE3cUt+Izw6ZzqwQyciE1LnkA=;
 b=hqG/6McWAAaOV5Ad6wJrEbgyLTcQ+OfnLwwByHR6S77oUEqJtYN+6wl4vJbMkeEUGrmbJ7vpV7r5KT0ZoDGDQUGbTqnWo32BHQwbsqDjpLAVF5Oyvk4nB/qNeF0Rdn7DGYM85bILQeiT5QxLnbhRZNkoWhhEx3ZMFvJkQCrYlyFOIg6Dmtq2hXvitGcf8ZmUP/1xedueGNME1x5cniIcr5q9Fj0ECzE39MkoOYOjlaazR2Fp08snh07bNNKSn/MRKMp9Ig1zwO/a0DkqsNcOeVEYExQH9fKnl6CYcNy8Mhwju5uSr2GiOUiBCqrGpIeTDs0AfjhgDaQ0AKwsUYkdew==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from CO1PR11MB5089.namprd11.prod.outlook.com (2603:10b6:303:9b::16)
 by SJ0PR11MB8294.namprd11.prod.outlook.com (2603:10b6:a03:478::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9253.13; Fri, 24 Oct
 2025 20:23:36 +0000
Received: from CO1PR11MB5089.namprd11.prod.outlook.com
 ([fe80::81f7:c6c0:ca43:11c3]) by CO1PR11MB5089.namprd11.prod.outlook.com
 ([fe80::81f7:c6c0:ca43:11c3%3]) with mapi id 15.20.9253.011; Fri, 24 Oct 2025
 20:23:36 +0000
Message-ID: <c113043a-e448-4ac8-bf72-dc15c4aebf02@intel.com>
Date: Fri, 24 Oct 2025 13:23:33 -0700
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net 1/3] net: hibmcge: fix rx buf avl irq is not
 re-enabled in irq_handle issue
To: Jijie Shao <shaojijie@huawei.com>, <davem@davemloft.net>,
	<edumazet@google.com>, <kuba@kernel.org>, <pabeni@redhat.com>,
	<andrew+netdev@lunn.ch>, <horms@kernel.org>
CC: <shenjian15@huawei.com>, <liuyonglong@huawei.com>,
	<chenhao418@huawei.com>, <lantao5@huawei.com>,
	<huangdonghua3@h-partners.com>, <yangshuaisong@h-partners.com>,
	<jonathan.cameron@huawei.com>, <salil.mehta@huawei.com>,
	<netdev@vger.kernel.org>, <linux-kernel@vger.kernel.org>
References: <20251021140016.3020739-1-shaojijie@huawei.com>
 <20251021140016.3020739-2-shaojijie@huawei.com>
 <759b7628-76b2-4830-97b2-d3ef28830c08@intel.com>
 <cc7362e8-e8ae-4813-a73b-d752b403332a@huawei.com>
Content-Language: en-US
From: Jacob Keller <jacob.e.keller@intel.com>
Autocrypt: addr=jacob.e.keller@intel.com; keydata=
 xjMEaFx9ShYJKwYBBAHaRw8BAQdAE+TQsi9s60VNWijGeBIKU6hsXLwMt/JY9ni1wnsVd7nN
 J0phY29iIEtlbGxlciA8amFjb2IuZS5rZWxsZXJAaW50ZWwuY29tPsKTBBMWCgA7FiEEIEBU
 qdczkFYq7EMeapZdPm8PKOgFAmhcfUoCGwMFCwkIBwICIgIGFQoJCAsCBBYCAwECHgcCF4AA
 CgkQapZdPm8PKOiZAAEA4UV0uM2PhFAw+tlK81gP+fgRqBVYlhmMyroXadv0lH4BAIf4jLxI
 UPEL4+zzp4ekaw8IyFz+mRMUBaS2l+cpoBUBzjgEaFx9ShIKKwYBBAGXVQEFAQEHQF386lYe
 MPZBiQHGXwjbBWS5OMBems5rgajcBMKc4W4aAwEIB8J4BBgWCgAgFiEEIEBUqdczkFYq7EMe
 apZdPm8PKOgFAmhcfUoCGwwACgkQapZdPm8PKOjbUQD+MsPBANqBUiNt+7w0dC73R6UcQzbg
 cFx4Yvms6cJjeD4BAKf193xbq7W3T7r9BdfTw6HRFYDiHXgkyoc/2Q4/T+8H
In-Reply-To: <cc7362e8-e8ae-4813-a73b-d752b403332a@huawei.com>
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature";
	boundary="------------SZNqxzdrNAv9IY5btfX5JtJE"
X-ClientProxiedBy: MW4PR04CA0252.namprd04.prod.outlook.com
 (2603:10b6:303:88::17) To CO1PR11MB5089.namprd11.prod.outlook.com
 (2603:10b6:303:9b::16)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CO1PR11MB5089:EE_|SJ0PR11MB8294:EE_
X-MS-Office365-Filtering-Correlation-Id: f4903114-b313-485f-56b4-08de133b35b8
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|376014|7416014|366016;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?blZKVDRCYUhnRTJDa29pdTBjMjlWeXZhcXBSN2daeU8yZWw3TCtGKzNvTU1H?=
 =?utf-8?B?SjhGaXlFY21YZ2d6RkhHVnIxbUpxZlRYQk0xdWF5SFI0SmpJd2VKZXczMEt5?=
 =?utf-8?B?c1l6YThUL1V5Y1JxM3hJUUQ2L2JFZlF4M1NDOTZKRUtPN0RiL2lZVi9zS2FN?=
 =?utf-8?B?N2g4TjZtVUVENzRjeXF6b2ZRM3VOVEdjSlNOU1Nob2FRTUFNelptM1A1YWpY?=
 =?utf-8?B?V3BBeEJpUnFMdHB0MURDSzJlVTlnRDBaWXI3WldONm1LNGdiT2JjZ2RvRFlT?=
 =?utf-8?B?MUxEVklJM1owSGNrekRpSHlyZ1Yrb1V0ZnF5MG9YYkQwMGFtaVNrYjNlVHBu?=
 =?utf-8?B?VGtvWnRzdGp1NG5seTN1SlJSWm1SS08vNFVnaXBRNHJPUnBFOXBEbm9zbUh2?=
 =?utf-8?B?Ny9NaGJBYi9ZeHdYaEVmSW1yb21rWFpLa3grT3dFT1pkZmovZHpLUWhMVFRn?=
 =?utf-8?B?MDYvSDI0dzNxSU81czNjeXZ5WjZzajgvc0dBTklaV3NrSC9LYzM0d2VhK2Vl?=
 =?utf-8?B?TnhZM0Zpb1o2T1JoQXJOT2dyb3U1c2ZFUFRTMldqdzVqa3c0ZzE5aEZJV0No?=
 =?utf-8?B?TmpIMHpyQnZrcTlSZk9FZDhSMThUdGNJUXZMRkNIMEx1ZGhEZDZoZUtENHlw?=
 =?utf-8?B?a1Yyd21ybUUxMEdnYUVMTno0dHFOd3V5Und6T2V1TmltU3dTM20ydUU4My90?=
 =?utf-8?B?VFJNMUh1U3RzTU5Zd0dGbFZEYVkzZjN0UlZXY1pEMnk4Y2FhTnB3ODdtWWJm?=
 =?utf-8?B?UDlmS2RDVVpORVBzS2NKWmRodEZsYWJDV0dhT0lISWd2bmprUVNjZUhlcVhM?=
 =?utf-8?B?eFBWdUtkTFQ3RUlKcVFWY0g5bE16bWxtWmJEWnVTTEtseWhaTmowbTZ0VVZx?=
 =?utf-8?B?VkluS1VYa1Q1bnhPSFp1NS9Db01SdHlDclp0aUMwaFFNd3BINnNwd2I2WTFz?=
 =?utf-8?B?K3FacVJaSm1BbUdKdytyVVc1MS85Tkpud3A5Vk55S1ZRdkJvTzgrdlJzRVhP?=
 =?utf-8?B?akJuS2lkNjBrMExqYWtqOFQ2WnFJZ21tRkkxeVNyajh1WFd5Vzl0eDlxQ3NU?=
 =?utf-8?B?emw1VGp2cy8yOFJnaVdhVkZmVWFIdjFLSms4VzRPK24vajFxRE1obWV2VkJG?=
 =?utf-8?B?NEV4UEJKZEsxREVHTjQxVVRHOUpBSG12UnZvSXVod29uR3RxSUhObnZoYksy?=
 =?utf-8?B?amhwOVJSQmJTczBYS2dhZXZTczJZaDFCY3RaZzM1RWJ0RjBremxKQWdYRXlt?=
 =?utf-8?B?QmdMR2s0YTJvWklrWWZVNE84dTlwOXVqMFlQU1pybkpsaVlXeW9mYTh3SEpm?=
 =?utf-8?B?Z0VKY3JJOWQ1UjJWZEMwWHlxUDE4V2kxR0FZeVZ1VktHM1FjT1cwc0hGOG5O?=
 =?utf-8?B?RDAySGpOOEtUYy9tZVhvQUlGMG41cEJKYlExaCtocGtWczJkb3E0aXc3aDUw?=
 =?utf-8?B?V3MvWUEzZlVLb3UzOUhHQVgwQ1RKZHJXRHBkeGNvNHIrTCtjTTF2dURpU0FD?=
 =?utf-8?B?U0FQRFlnalIweWJjU3dZcW9yaVdBQTNlcUVuZjZSWG5yaTYrdHZmdnR3K0kx?=
 =?utf-8?B?bFVpZjY0N2lDSU1jQ3M0MDZCMGpIZ2JVUGsxZkxUZksvd3JUNWNqTjRWZzFS?=
 =?utf-8?B?NG5MSDYrRHppL2N0L1BaQjg0SC9oTW9vK1VtSnptMlA5RFB3MUdPR3ZJSmRP?=
 =?utf-8?B?R3dWTVBaa0dVMEprL25zemIwNWhSYjFhZFRGMmZLK3VtQmQ0d0F1bmZTcFJx?=
 =?utf-8?B?Wis2OGdJTmNPUGRXV2JJV3FqNS93Q3BSNHQ4Y3JoQ3pPaTcwZFJLOHExczUy?=
 =?utf-8?B?VG00NUJrZXQ0Y2wyMDU4VFNKK0tCV1JtNmE4a0dYNnZqSG5Eb0x1TlNwcW1w?=
 =?utf-8?B?WUFiSzNVenU0c0wzNGt0azRLV3A5Z1BEblE2bHFuSFM4Ky9iOFJ4NGQ2d24x?=
 =?utf-8?Q?EPYFlfbmjMAl254UuFlpTPAPXYSsTBcy?=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CO1PR11MB5089.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(376014)(7416014)(366016);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?TVk4MWh5MituTGtQdEp2cFVTK3F0YzRoekdjVmdyckxJQmlIWTdreXlRN2Z1?=
 =?utf-8?B?anZNL0J0WUlIZVBpVW5nZXdQdk5vZVJaalZVb2NwWUk3NjN5ejM3RzlPdlBO?=
 =?utf-8?B?bXhZUUg5WGhBcmlKRzNwODRGOWt5cGtTTkY2OXhyck5iWExjcGx6eUk1NnBL?=
 =?utf-8?B?WFU1bGovSUUybVFITUlCeHZBNktsdmRmVTF5bStnMmtEWklVT2FGQVY3UWFn?=
 =?utf-8?B?Y3k4ek1lQjF6dmxxaXgwT2drbms3c1N6Y1k1QjVzalQzRkVuWmNFMEVHRytG?=
 =?utf-8?B?K0x4aE85OGgycDAzM3UwUTVaaVdmb3B3WnIxZTRmZHhmMVVCL0FRdmFVU3Zu?=
 =?utf-8?B?TmpCZGJkdFJVUURjMnQrRXdiek9PNStWdVJEK0JLTFVBQzUwTzkvNEhBQnZz?=
 =?utf-8?B?dFZBOFBQQ1BsMDhRdlFYaGdyM3NvSlFJVnRGK210UmY0S0F2REM4QnRBMlVj?=
 =?utf-8?B?akk4bTFDOGE0UERHaEk4WTlrWm42YXNZNzl2NHQ3S0dJZ0ptQ1pYMS9veGtB?=
 =?utf-8?B?bHNlckRxVnMrdUs3M1V2T2wvMlhEZjhUenl4M1NtWFJWTi9kSkRCQ2NzNG9Q?=
 =?utf-8?B?eWhuWHFZeU04Um9ndkpESHcvVHBQZGozeGZsVFdVRHVBb0dPWDJDNkJmMm1m?=
 =?utf-8?B?YWlDdEVRUVVab25FUFBkZjdySXR6bjdYdm5xSmNMU3VVM3BCNkRUa3hycjV3?=
 =?utf-8?B?RGdVRXVrb0kvdWlJOXZjamR4cWRIMkU5NU1MTlMwQ2VVMHhRMWVlSmtuSlVp?=
 =?utf-8?B?RVNmMHpBSkJwaTRUT01lT3ArdUsyekdac24rMG5kYUsreFkzTURtWTk0NmNo?=
 =?utf-8?B?RjBJdWM4NTVlc20wcGtHeVFqcFRQbFZzU2hPSG51am55M2g0a2g1WDY3Mzc3?=
 =?utf-8?B?U09TWkM5SzQwdk0yeVd4S2RYK3BNRGlMTmdzajdTNkVyc3N4RE9ZNk5jdVFC?=
 =?utf-8?B?aXR2djZJQkd5VzBmb2YxUFlGOWlCYjkvZHJWSHBuc2x6T2ZObmk3eTdIT0Na?=
 =?utf-8?B?bEtwNjRKcVFsWDNVdzNqTmhBZmlJRTJuWk5lUnBBZUFOSnBuS3ZyaHNGK2xy?=
 =?utf-8?B?akVXZWxjZXpNQjUxaXROclhXbVFQSUhtemlyNCsxT3RCK0VtSHZOWXJRZHlu?=
 =?utf-8?B?WFdEOFV1eHVRVG5DdWQrY0E2enlqWlBwWFI1L01pSGlJVTlGZHFudmkxNW1Q?=
 =?utf-8?B?V1Bab3BZNHh2bS9ZeUV2QUZLZDRsN25BdzBOcDd3WHM4RTN2Tm9lbUJibXJJ?=
 =?utf-8?B?STI5WmI3ekdhL2EyaTZvUkdacXFBRUtKOHA3VWtjM3Q3Ri9wSVEwTDI2YXNJ?=
 =?utf-8?B?OEVYY0Y3aUZBL0N4S2NpWkxwRFVCN2VsQ1dNU0FXejdyWXlLQ2F2bG5BK2lL?=
 =?utf-8?B?eTZjUklnNmU1aWlORS83VWxHMGVXV2t1RDBXNTkrdDNCVHFIaWhGWFdKSEpG?=
 =?utf-8?B?WDNPWFFLbU1TSFYxWHRUZDBNMGtuTGwrTnZQL2w2OURRbmJmdTBScjFHQXNm?=
 =?utf-8?B?dzUyNERrUUhWYW9VenhnL3E4L1dmM2dKZ0pQNDI0RkNLVk95Vmg1b2tVWW9r?=
 =?utf-8?B?WXNBcisxNGU2MGR6VTFMSDdPcUtOTE1CYzVLbkF4MjkyNmlJQ0E0SEhlMzhn?=
 =?utf-8?B?SGdYSHpGZU9Da0JMUHA2YnFmS2tuMElTYy9YVVVqL1dOSC9xYVNiNWdQTzRW?=
 =?utf-8?B?NE40NktycnVERWpubTQvNUVuNjdSRnRKYVVQNnRLbnJUcDZBOUp2cm9QR2ps?=
 =?utf-8?B?c3FpQlQ4UkJncUJMV1ZxTkduVVdVNUczUXFlSDV6WERpRDZELytpUU9kbWtN?=
 =?utf-8?B?bzVCUlRXZWM5UGhuc0FKV2tDN0UxVFhlZ3lnY0ZXZUNPVEhxVjdMQXRGSnBi?=
 =?utf-8?B?d2V1ejA3WGc2MnNpK0c3eHpreURvRGNPaHgzeTBUaHk0OVpWUHlHd25raU1E?=
 =?utf-8?B?YmNyRUdGWHAvWWVCM0xyQWJEU29zcjMxUDI4cGRGMEJ3NE9FTk9lVHNaK3lD?=
 =?utf-8?B?NTJUeHhMbzdzN3R2dHFIdEpRS3ZxbWFCSStqVGd6dFJpQ2ZsRDdXdzNJUFpy?=
 =?utf-8?B?N3FwTE5wc2NOd1Fhd2NzWWlzWm5aTm5QYUJZOWNiVVZkelZ6MmJEdStwMUw4?=
 =?utf-8?B?Rk1RamRaY0RaZmZHWERDWDFwbDhzNkdYM0xXWDhlcWMxclNBUjBQNmhrMkdr?=
 =?utf-8?B?Umc9PQ==?=
X-MS-Exchange-CrossTenant-Network-Message-Id: f4903114-b313-485f-56b4-08de133b35b8
X-MS-Exchange-CrossTenant-AuthSource: CO1PR11MB5089.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 24 Oct 2025 20:23:35.9758
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 4W2kIQXhJafg6zziq2jmmByYulN/gpm71HJyJFzRcRfO6pn0fcxLenMzCEIlHlk5GQ4kt+wEQ+Q56czznmDRnbtGjeGxJMEZU9FHId7U5eA=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ0PR11MB8294
X-OriginatorOrg: intel.com

--------------SZNqxzdrNAv9IY5btfX5JtJE
Content-Type: multipart/mixed; boundary="------------hmKYoOerwtB02eb8JGZPfwIX";
 protected-headers="v1"
Message-ID: <c113043a-e448-4ac8-bf72-dc15c4aebf02@intel.com>
Date: Fri, 24 Oct 2025 13:23:33 -0700
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net 1/3] net: hibmcge: fix rx buf avl irq is not
 re-enabled in irq_handle issue
To: Jijie Shao <shaojijie@huawei.com>, davem@davemloft.net,
 edumazet@google.com, kuba@kernel.org, pabeni@redhat.com,
 andrew+netdev@lunn.ch, horms@kernel.org
Cc: shenjian15@huawei.com, liuyonglong@huawei.com, chenhao418@huawei.com,
 lantao5@huawei.com, huangdonghua3@h-partners.com,
 yangshuaisong@h-partners.com, jonathan.cameron@huawei.com,
 salil.mehta@huawei.com, netdev@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20251021140016.3020739-1-shaojijie@huawei.com>
 <20251021140016.3020739-2-shaojijie@huawei.com>
 <759b7628-76b2-4830-97b2-d3ef28830c08@intel.com>
 <cc7362e8-e8ae-4813-a73b-d752b403332a@huawei.com>
Content-Language: en-US
From: Jacob Keller <jacob.e.keller@intel.com>
Autocrypt: addr=jacob.e.keller@intel.com; keydata=
 xjMEaFx9ShYJKwYBBAHaRw8BAQdAE+TQsi9s60VNWijGeBIKU6hsXLwMt/JY9ni1wnsVd7nN
 J0phY29iIEtlbGxlciA8amFjb2IuZS5rZWxsZXJAaW50ZWwuY29tPsKTBBMWCgA7FiEEIEBU
 qdczkFYq7EMeapZdPm8PKOgFAmhcfUoCGwMFCwkIBwICIgIGFQoJCAsCBBYCAwECHgcCF4AA
 CgkQapZdPm8PKOiZAAEA4UV0uM2PhFAw+tlK81gP+fgRqBVYlhmMyroXadv0lH4BAIf4jLxI
 UPEL4+zzp4ekaw8IyFz+mRMUBaS2l+cpoBUBzjgEaFx9ShIKKwYBBAGXVQEFAQEHQF386lYe
 MPZBiQHGXwjbBWS5OMBems5rgajcBMKc4W4aAwEIB8J4BBgWCgAgFiEEIEBUqdczkFYq7EMe
 apZdPm8PKOgFAmhcfUoCGwwACgkQapZdPm8PKOjbUQD+MsPBANqBUiNt+7w0dC73R6UcQzbg
 cFx4Yvms6cJjeD4BAKf193xbq7W3T7r9BdfTw6HRFYDiHXgkyoc/2Q4/T+8H
In-Reply-To: <cc7362e8-e8ae-4813-a73b-d752b403332a@huawei.com>

--------------hmKYoOerwtB02eb8JGZPfwIX
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable



On 10/23/2025 11:39 PM, Jijie Shao wrote:
>=20
> on 2025/10/24 9:15, Jacob Keller wrote:
>>
>> On 10/21/2025 7:00 AM, Jijie Shao wrote:
>>> irq initialized with the macro HBG_ERR_IRQ_I will automatically
>>> be re-enabled, whereas those initialized with the macro HBG_IRQ_I
>>> will not be re-enabled.
>>>
>>> Since the rx buf avl irq is initialized using the macro HBG_IRQ_I,
>>> it needs to be actively re-enabled.
>>>
>> This seems like it would be quite a severe issue. Do you have
>> reproduction or example of what the failure state looks like?
>=20
> priv->stats.rx_fifo_less_empty_thrsld_cnt can only be increased to 1
> and cannot be increased further.
>=20
> It is not a very serious issue, it affects the accuracy of a statistica=
l item.
>=20

Right, since it only affects this one cause. Got it.

>>
>>  From the fixed commit, the RX_BUF_AVL used to be HBG_ERR_IRQ_I but no=
w
>> it uses HBG_IRQ_I so that it can have its own custom handler.. but
>> HBG_IRQ_I doesn't set re_enable to true...
>>
>> It seems like a better fix would be having an HBG_ERR_IRQ_I variant th=
at
>> lets you pass your own function instead of making the handler have to =
do
>> the hbg_hw_irq_enable call in its handler?
>=20
> Currently, only the RX_BUF_AVL interrupt needs to be enabled separately=
=2E
> Personally, I think it is acceptable to temporarily not use the an HBG_=
ERR_IRQ_I variant.
>=20

Sure that seems reasonable.

Reviewed-by: Jacob Keller <jacob.e.keller@intel.com>

--------------hmKYoOerwtB02eb8JGZPfwIX--

--------------SZNqxzdrNAv9IY5btfX5JtJE
Content-Type: application/pgp-signature; name="OpenPGP_signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="OpenPGP_signature.asc"

-----BEGIN PGP SIGNATURE-----

wnsEABYIACMWIQQgQFSp1zOQVirsQx5qll0+bw8o6AUCaPvgRgUDAAAAAAAKCRBqll0+bw8o6K10
AP44FF1KahHGYt0Ric4v+pmaQkwqLqjISQOnhmfb4MISawD/ZC2r5PKYUDi1l3CoHvsQuxj3Npbu
vFHaBb5y7rryQQE=
=R0Ut
-----END PGP SIGNATURE-----

--------------SZNqxzdrNAv9IY5btfX5JtJE--

