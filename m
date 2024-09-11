Return-Path: <netdev+bounces-127458-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 93E2E975777
	for <lists+netdev@lfdr.de>; Wed, 11 Sep 2024 17:47:55 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id A044A1C22B16
	for <lists+netdev@lfdr.de>; Wed, 11 Sep 2024 15:47:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 30FEC1AC881;
	Wed, 11 Sep 2024 15:47:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="QQofq4qc"
X-Original-To: netdev@vger.kernel.org
Received: from NAM12-DM6-obe.outbound.protection.outlook.com (mail-dm6nam12on2053.outbound.protection.outlook.com [40.107.243.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2F9711AC433;
	Wed, 11 Sep 2024 15:47:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.243.53
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726069662; cv=fail; b=i7vZNithig2GsTktOclJJHFxAaUzH+ZLmAQr2PVviZze6mvuOtVbR6gwuiGP2TFSFkHzsU71PThbY9IQg4QxLMTuIwYEDeJ83DDk/SwAsDTurqURgRwArlTeAsDQQKOq+sDa/3IoCOsdjMxwrwCGUGCHHHUiSFAafpZt3+0ZBLg=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726069662; c=relaxed/simple;
	bh=VoL13qn/kyUUw+vs9MbTIcTjGPHZo4Jm6iUqWA0v3o8=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=sUKi2O50a2e5wrEILELSr54SWlQ68Tgwaw//skp1QP96O3OE6MMYfHyon3214c4uflL75pUMwjLobr05wQBJYVCQhCWTDXlYBE9IsrZnYj2yXxEAbxNoHnBqPbdLU41Hc5/QC+sE/BeNfFw1rZQBEr0cBgdsrbTb512XFoJQfl8=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=QQofq4qc; arc=fail smtp.client-ip=40.107.243.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=iasHWlB7iV15P3PDfChmht7g6TOCCPYCFBI/uKZeOQ3CwO6T/lEtNmxeQuHeMKlQzha1gQ3k+Qu2ceEM8xTRA7RYiad0Cw5RQvcUB2ierI5McXgcNTQRc7kMp9zUf+Rm8vgNz+aTwTY+5lOfYY82bJrvHUvHeYpbZY6vZzId93NXxwQjLlpR04Pywb3BWGZP18P7vIez+S+U9txtkJs5IRVcRQwwDGZZ/Jz6Qz09qNIs4eJxkHLve23GmW0KMmsm18EcsGUQD2Z4k+cTawfrEzc+K2ttSfDnzhFCZhptz8/ZpIuOglfZgZ5Je/m8ihSU4jKPW/iLZ1NOzUegXlgEEg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=YrJQZN7xtsKCnqIhkqvJZIgiEIDQ/wqapQKgG0MWo7A=;
 b=PAWC3qLdr0i0VOotM3vyBg6fetPApoOYEDTzUni4bj+RUW4X4nm/IwBXiMQT+vvAnm8mex6+ML41ySaHvfLAd9ioqKFQJfYVp6kvnwh/mgzqplSdDIAIkCnmji6B2KkIsnboLDoexLdC7GDSO3l4dhbT8zVoTkoHLidibc7LSRqTplwGfNlRpXfxZp+N47dx/YLB5goG8Yv7Mujpt1UhubYc7pe43gU4feSdZhsJCq7+K19h78CzukJEVmCHzFYY0h6eo6yPse/Oy7ylFdwRkoxfpNthy1BeNbOltnlc2e6HeMLkltRmQ0PMXYEJeJtDHosauaUDIxtt4Is3p8ddaA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=YrJQZN7xtsKCnqIhkqvJZIgiEIDQ/wqapQKgG0MWo7A=;
 b=QQofq4qcxVwCEMOVjMfjwfh1P9s4uWMGoakf/Jr/uV6hYasP8yP65f0pLRoBlWP3UUyxZxyIuwCegxZb/Y6DNt9SxylKEJDczA3/we4je5mLkQOIka0pZ4rkderVmNd+NFjsMpF9iDkV1+FsB736GNf2X3trDNRuUdteW/rKMkU=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from PH0PR12MB7982.namprd12.prod.outlook.com (2603:10b6:510:28d::5)
 by PH7PR12MB8179.namprd12.prod.outlook.com (2603:10b6:510:2b8::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7918.27; Wed, 11 Sep
 2024 15:47:37 +0000
Received: from PH0PR12MB7982.namprd12.prod.outlook.com
 ([fe80::bfd5:ffcf:f153:636a]) by PH0PR12MB7982.namprd12.prod.outlook.com
 ([fe80::bfd5:ffcf:f153:636a%3]) with mapi id 15.20.7962.016; Wed, 11 Sep 2024
 15:47:37 +0000
Message-ID: <1eec50e5-6a6d-4ad8-a3ad-b0bbb8e72724@amd.com>
Date: Wed, 11 Sep 2024 08:47:32 -0700
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net-next v2 3/4] ethtool: Add support for configuring
 tcp-data-split-thresh
To: Taehee Yoo <ap420073@gmail.com>, davem@davemloft.net, kuba@kernel.org,
 pabeni@redhat.com, edumazet@google.com, corbet@lwn.net,
 michael.chan@broadcom.com, netdev@vger.kernel.org, linux-doc@vger.kernel.org
Cc: ecree.xilinx@gmail.com, przemyslaw.kitszel@intel.com, andrew@lunn.ch,
 hkallweit1@gmail.com, kory.maincent@bootlin.com, ahmed.zaki@intel.com,
 paul.greenwalt@intel.com, rrameshbabu@nvidia.com, idosch@nvidia.com,
 maxime.chevallier@bootlin.com, danieller@nvidia.com,
 aleksander.lobakin@intel.com
References: <20240911145555.318605-1-ap420073@gmail.com>
 <20240911145555.318605-4-ap420073@gmail.com>
Content-Language: en-US
From: Brett Creeley <bcreeley@amd.com>
In-Reply-To: <20240911145555.318605-4-ap420073@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: CH2PR07CA0055.namprd07.prod.outlook.com
 (2603:10b6:610:5b::29) To PH0PR12MB7982.namprd12.prod.outlook.com
 (2603:10b6:510:28d::5)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH0PR12MB7982:EE_|PH7PR12MB8179:EE_
X-MS-Office365-Filtering-Correlation-Id: 2eb71923-f4f5-4755-fc5d-08dcd2790fa9
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|376014|7416014|366016;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?M1I5dVdmTjArNE5DeXQxZGJYUUhkdUY4NU94U2tMRWxDc2FPNmVSOUdISUJy?=
 =?utf-8?B?NG5MUnlnNDlTNWNKdHEvSDJvNzZ6T05EckNGYzZuNlFiUXk5Vm1rc2lrWkZR?=
 =?utf-8?B?N3oyMmVTY2tkNkRqVGxONkJDSDhkQTZBSUZhOHRodHhJV284UUp6VFE3Nm44?=
 =?utf-8?B?WUtTcC9uVDZiU25pVFVzWG03R2g1a2VxNTU5TkhkSVh0Wk1xRFI4WXA2azVo?=
 =?utf-8?B?ZGRTZGg2TFBTcU1HQjJySWJVKzZIT25PV3hXdE1QN3VsYlNQN2syK3JwYm1H?=
 =?utf-8?B?S0o5Yi9yOUlPdEF2bTZMVE42bUhLNFVEdjhFcXAwcW55Yjc2c3NKbFVxajNG?=
 =?utf-8?B?eGZxTjlha2NMZ0xEUWNjT2JqMmNJVWpEWE9oUEpRUjRCTW51TVI0cFpFczhW?=
 =?utf-8?B?NGhuVFFwMTYrZ2NqOVE4R0dqNjREb1UxVjR4a0dMRnQ2TVd4UDJuSHhrNGcz?=
 =?utf-8?B?aFgyV1VsNXdNRTlPM1dScmZSeDYxMnJBRU4zMkhHY0hNRndoenFwQVc1NHNN?=
 =?utf-8?B?WkhhRytpanNvNUR1VVVXOFp4UTdIaEcyY2dvaGRqNDIvS1pkMW5LVi9tVm04?=
 =?utf-8?B?OW9rUDFDaVpwaWVjeEppNUNHMzJwZmpMQ0NXVlhMb2dzL2xhSE1ZQVJScjVx?=
 =?utf-8?B?STBrVUUreGRKOGxtS1VXa2JzRU1GdDBvcVZzbTZscElKbXQ5WlpUWnRySXFi?=
 =?utf-8?B?cG9LU0NjcllSU05qVmc1aVBGcUpQSFd3cThRMWZqTWNpbEY4NDNZOFRzdmhk?=
 =?utf-8?B?WEJDdzkyV1BWTkxvODVTQ24xbmdmYjNleXI4OUR0dzVXdDNmYzZvbzFZYXM4?=
 =?utf-8?B?T0VrWGpsRkhCZWpMenE5MjBkVWZTdXRVWklvdXN6cXZEM2ZoaFlaN0czZHdJ?=
 =?utf-8?B?K3hXQW5qbmxVOU9ZRjVmaTgwWWJXMEk5NGEzTjhEWnVuczE4d1RRTytTZm1W?=
 =?utf-8?B?djBpVWNoTmgza0cvWmpEalFNeVpteUR5RlJFZENkR3N0dTZWMGk1dForYmVj?=
 =?utf-8?B?bmxYQys1YmJrY2NNdVJpcTZGaDh5eGxRSHd3SDdLZUd4V052OCtmUjlMaTk1?=
 =?utf-8?B?a3crUjA1VnluTG1MZzNIMllkMDhFbUdFVzgvOE5XZnVpaGZqODFjdFlmczhx?=
 =?utf-8?B?QTUxL2Z0Vjg5N00vNnFDVWhNVnh3MWFTNSs2U0MzMHk2RDJJWFpPUVgzUlFu?=
 =?utf-8?B?VU41ZVAxdHJra1Q0Z1o3Ymg4NW1YNjk0TUY4QmR5UktOOHNjd1gxR09RQm1p?=
 =?utf-8?B?MmlWUzFTQXhBcE5DZ1REbVhhOHpoVytoa0d5QVYxME03SjlWTkxNc0FBUHdI?=
 =?utf-8?B?L3ZUYk00djd0cnFGQSt0OWN5Q0hVTWk0ZnpxV2lheC9UcXI2dXI0MHNWNkZt?=
 =?utf-8?B?bzF5SkptRENPZGNvQnBKVzNyVmRqYnhoRllMV2lRemxzRlpKV1gwOWhudlVI?=
 =?utf-8?B?K3hOclprY2pDU1BIOVdoSkIxSUtTSGFUNHVqWmNiOWV4OGYvQTNkaHl1d1Nj?=
 =?utf-8?B?VnhMVFo0VWoyQ3hyZ3pvdmt1Y0ZnRWVYQ0M0TXJrOEdLRk1XS1RuVTgweDcy?=
 =?utf-8?B?WlozV0Z6dm15NWFwUktWQlMvanExN3BTQmUwVUthbVNmN0llU0lMYXFzSk9Y?=
 =?utf-8?B?ck9GbjJDaXR1d2pHUWJWdTloTHJMa2c0eFBjcmxjL1hSMEZZMUtaa3EwWFBk?=
 =?utf-8?B?ZVZrSWJCQmdXSW81dVZYNDkydGVrU1ppWVVOQlJoWXRpRmtvUnpIeEJPaHM0?=
 =?utf-8?B?TlVTTkR4UHVZWVg0YWlDT1RlMHpPTS93R2lOSEUxYTY5cmFhMWE2RXhpejF4?=
 =?utf-8?B?VzN2T2FLN3lSYkJHM0VaZz09?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH0PR12MB7982.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(376014)(7416014)(366016);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?WURCSk5oOU1saE5rYUVtL09YV3EzQjgvVnYzWUN1cUFyK1hQSjliY1BBMzVH?=
 =?utf-8?B?RXdYVUc1M1pUMk5lY2hPTndNcUs4bzh0ZE5GKzgrcDNuNFB4V0R2SitmM1h0?=
 =?utf-8?B?QTMyTk1PemwxMzFiN01zMTMyVElRa2NNS0x0eCttRHlPaW5heFhBRzBVd2t1?=
 =?utf-8?B?eVZzajQ0Q0pnVzV1WjJOYVVPRXRVR1BFQkFOakxUcUZKblZ3T1pPd2JUdGVE?=
 =?utf-8?B?WlVCOHRLbTlYc045S1Zib3Fxb0ExcGFLRERWU2k4c3FrRk5SbzhUWjJyZ05Z?=
 =?utf-8?B?M1A0QTF6UVdvUEt5ZEwvZ3VrT096MmhUeHl4ZDRzWUtKdWlERFVZbkhYaS92?=
 =?utf-8?B?K3pmSEhCdVFHNnR1TlpJTVhhbTJOWnh4N0psdTlLcTgrOGJ5NEl3WldxVUZT?=
 =?utf-8?B?TGFpL1c4aTBZVW5sbTB3Mzdqdk5IUVZuQS9mRG1qK0JHMjc0czlrQWhsUThU?=
 =?utf-8?B?RWhzbTBVd2lNV2ZDU1VrQjB6TXp1ekJMVjVvRUxrOG9ValZFUnpIc0UyL3RS?=
 =?utf-8?B?QWFuWk84aTlJNGFXRnYxQ1VzQ2dQbUVzZFN0aEF2RWJsa3ByM21HeUNzeFNz?=
 =?utf-8?B?djlMM1EvYnpTMUNDMWVNbEVybTdWUHNpdE54T2VNSmdsc2dQZFphM0hoQW9V?=
 =?utf-8?B?WkRwRjhmVm9GZDgzd0hiNFdUS2pKK1lramZiM2NVUCtTTWpSWDk2REpyL0JB?=
 =?utf-8?B?L0wreGlzbDVGZjJXOGhwK0hFZHJSeUJOdFl0bWFnTzhjalpaSlZ6d1ZNbVJW?=
 =?utf-8?B?cVkvTFgrUEVKRmQxVzBaM3FWenlneTBZZVphZTFUaWFMV3lrZ0pLZFhMV3Zo?=
 =?utf-8?B?OEdYbTI3SjVCZ3JVaEZGMEhFRVk3aUFOUjZoczEyV2c2dis2NzdVQThQa0ND?=
 =?utf-8?B?N3FzV0I3NVlnajYwSW1QdUhlZVVpSlJrNjBTUFN2US9UeDcvTmRpdW81RXUr?=
 =?utf-8?B?YTc1T3ZXS09yTzlKdml6VlUvQjRqb1VBWm5NazAyTGdvUDU4MUJuU2JtUTh2?=
 =?utf-8?B?bnFvZjU5VDkxMXFRWDdMUHFudFpkNWRuTjQycFJOb3ZaTUp6QmZGNFNxaGdE?=
 =?utf-8?B?MDlSTXZUcW9KVGxrT3BudzlSbERXaERrWmExSFQ1L091ZzY0WHU1UWhNV0Rr?=
 =?utf-8?B?OUhwZmZwUTdPRnh4b2hORU43VTNPR0NLL0RsWTN0d00zend5N2x5KzlSb2Vr?=
 =?utf-8?B?Q1JDUHdjNmYzcTVMMEFCekRDampRNWpUVy9zMi9mdHRaM0psdkNUMnAzbHEz?=
 =?utf-8?B?cG5qNnlETXVocDM3eWlCT2RQam10MTlwR1VndDZWRFliaVZCTmM5TTVnU2VS?=
 =?utf-8?B?Rmw0bTVhSDFDMWc4Q2hUNWxmdVV3dmNiT240SDBTbU1oRnZqdGtPSHh2SVdU?=
 =?utf-8?B?Yy9DZnV4WkpQcm9Mc1RxV2psTFRrTURWTDB0YXZaOTRoY3BUZzh0Y1lKL2NU?=
 =?utf-8?B?b2lHQklBYWI1d05aeG9VeHQ1NlZSdldHRkJWNnZmemVYclMxM0I1SzUyNlRO?=
 =?utf-8?B?SjVMUnhGdlp1M3ZEdWJ1RFFNWDNwVWJaU1RZV2ZPb2YwazFMMzI2QzczWEZI?=
 =?utf-8?B?OVZEamNNSjRJbDNSSlcvWDF1S0VWM1lpQnJhRWRxd2ZlYkhqQU9kZE1wNmRI?=
 =?utf-8?B?d1BDRERsOWRJcG5Qb2FnY3NQQTNqSnoyMkFmODlRblNicndmZUk1N0hraW5T?=
 =?utf-8?B?blBRMGhuREpuWmN6QmM1a2NoOTRab3lEY2QrNHNxMnNIK0xJSVZtLzFWZlhY?=
 =?utf-8?B?SGIxeGVZNVprSDdXQXNMRWtWM1lTRGFSUURGN2MxSXhwcTJFWnRwc2tOeXcy?=
 =?utf-8?B?c1FBdkd4aDdtRnFYWEo1L3VhTlZoTEdPL2RMQU5RYnJtL3huaTU5eTA1V05U?=
 =?utf-8?B?a0tGY1VrOVlGY0Y2SzE1YUNUVjljbnQ1RnpQNm5IWFdpZWlrbXJtV3VOcmxn?=
 =?utf-8?B?NFZZV0d4Z1Z5R0NLc0pGR2o1cFR6MDh2ZndYa0IyZE5aYWxhNE55Y3cvQmNo?=
 =?utf-8?B?cE1zamphZ25yM2hucjlzWUU2VzZTclczRWJ4UE1pTXBlTVg0aERQWklFVWZr?=
 =?utf-8?B?Y2hWOUdWUzVIMFNsNkdkTElDcm1CdnkrcUhIL2ZMaDVqTC9aU29nVDRhWHFi?=
 =?utf-8?Q?hALV3tHRusfs1gVzTXTJbAG/D?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 2eb71923-f4f5-4755-fc5d-08dcd2790fa9
X-MS-Exchange-CrossTenant-AuthSource: PH0PR12MB7982.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 11 Sep 2024 15:47:37.7016
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 8/JOM1adKSLOkKyQvQ/s20z47xnhnsf4yd466EkxQfGuUTpLeMkcBv5Xi6648ZDRoBoxfTit35KIuK3wYlMecA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR12MB8179



On 9/11/2024 7:55 AM, Taehee Yoo wrote:
> Caution: This message originated from an External Source. Use proper caution when opening attachments, clicking links, or responding.
> 
> 
> The tcp-data-split-thresh option configures the threshold value of
> the tcp-data-split.
> If a received packet size is larger than this threshold value, a packet
> will be split into header and payload.
> The header indicates TCP header, but it depends on driver spec.
> The bnxt_en driver supports HDS(Header-Data-Split) configuration at
> FW level, affecting TCP and UDP too.
> So, like the tcp-data-split option, If tcp-data-split-thresh is set,
> it affects UDP and TCP packets.
> 
> The tcp-data-split-thresh has a dependency, that is tcp-data-split
> option. This threshold value can be get/set only when tcp-data-split
> option is enabled.
> 
> Example:
>     # ethtool -G <interface name> tcp-data-split-thresh <value>
> 
>     # ethtool -G enp14s0f0np0 tcp-data-split on tcp-data-split-thresh 256
>     # ethtool -g enp14s0f0np0
>     Ring parameters for enp14s0f0np0:
>     Pre-set maximums:
>     ...
>     Current hardware settings:
>     ...
>     TCP data split:         on
>     TCP data split thresh:  256
> 
> The tcp-data-split is not enabled, the tcp-data-split-thresh will
> not be used and can't be configured.
> 
>     # ethtool -G enp14s0f0np0 tcp-data-split off
>     # ethtool -g enp14s0f0np0
>     Ring parameters for enp14s0f0np0:
>     Pre-set maximums:
>     ...
>     Current hardware settings:
>     ...
>     TCP data split:         off
>     TCP data split thresh:  n/a
> 
> The default/min/max values are not defined in the ethtool so the drivers
> should define themself.
> The 0 value means that all TCP and UDP packets' header and payload
> will be split.
> Users should consider the overhead due to this feature.
> 
> Signed-off-by: Taehee Yoo <ap420073@gmail.com>
> ---
> 
> v2:
>   - Patch added.
> 
>   Documentation/networking/ethtool-netlink.rst | 31 +++++++++++--------
>   include/linux/ethtool.h                      |  2 ++
>   include/uapi/linux/ethtool_netlink.h         |  1 +
>   net/ethtool/netlink.h                        |  2 +-
>   net/ethtool/rings.c                          | 32 +++++++++++++++++---
>   5 files changed, 51 insertions(+), 17 deletions(-)
> 

<snip>

> diff --git a/net/ethtool/rings.c b/net/ethtool/rings.c
> index b7865a14fdf8..0b68ea316815 100644
> --- a/net/ethtool/rings.c
> +++ b/net/ethtool/rings.c
> @@ -61,7 +61,8 @@ static int rings_reply_size(const struct ethnl_req_info *req_base,
>                 nla_total_size(sizeof(u8))  +    /* _RINGS_TX_PUSH */
>                 nla_total_size(sizeof(u8))) +    /* _RINGS_RX_PUSH */
>                 nla_total_size(sizeof(u32)) +    /* _RINGS_TX_PUSH_BUF_LEN */
> -              nla_total_size(sizeof(u32));     /* _RINGS_TX_PUSH_BUF_LEN_MAX */
> +              nla_total_size(sizeof(u32)) +    /* _RINGS_TX_PUSH_BUF_LEN_MAX */
> +              nla_total_size(sizeof(u32));     /* _RINGS_TCP_DATA_SPLIT_THRESH */
>   }
> 
>   static int rings_fill_reply(struct sk_buff *skb,
> @@ -108,7 +109,10 @@ static int rings_fill_reply(struct sk_buff *skb,
>               (nla_put_u32(skb, ETHTOOL_A_RINGS_TX_PUSH_BUF_LEN_MAX,
>                            kr->tx_push_buf_max_len) ||
>                nla_put_u32(skb, ETHTOOL_A_RINGS_TX_PUSH_BUF_LEN,
> -                         kr->tx_push_buf_len))))
> +                         kr->tx_push_buf_len))) ||
> +           (kr->tcp_data_split == ETHTOOL_TCP_DATA_SPLIT_ENABLED &&
> +            (nla_put_u32(skb, ETHTOOL_A_RINGS_TCP_DATA_SPLIT_THRESH,
> +                        kr->tcp_data_split_thresh))))
>                  return -EMSGSIZE;
> 
>          return 0;
> @@ -130,6 +134,7 @@ const struct nla_policy ethnl_rings_set_policy[] = {
>          [ETHTOOL_A_RINGS_TX_PUSH]               = NLA_POLICY_MAX(NLA_U8, 1),
>          [ETHTOOL_A_RINGS_RX_PUSH]               = NLA_POLICY_MAX(NLA_U8, 1),
>          [ETHTOOL_A_RINGS_TX_PUSH_BUF_LEN]       = { .type = NLA_U32 },
> +       [ETHTOOL_A_RINGS_TCP_DATA_SPLIT_THRESH] = { .type = NLA_U32 },
>   };
> 
>   static int
> @@ -155,6 +160,14 @@ ethnl_set_rings_validate(struct ethnl_req_info *req_info,
>                  return -EOPNOTSUPP;
>          }
> 
> +       if (tb[ETHTOOL_A_RINGS_TCP_DATA_SPLIT_THRESH] &&
> +           !(ops->supported_ring_params & ETHTOOL_RING_USE_TCP_DATA_SPLIT)) {
> +               NL_SET_ERR_MSG_ATTR(info->extack,
> +                                   tb[ETHTOOL_A_RINGS_TCP_DATA_SPLIT_THRESH],
> +                                   "setting TDS threshold is not supported");

Small nit.

Here you use "TDS threshold", but based on the TCP data split extack 
message, it seems like it should be the following for consistency:

"setting TCP data split threshold is not supported"

> +               return -EOPNOTSUPP;
> +       }
> +
>          if (tb[ETHTOOL_A_RINGS_CQE_SIZE] &&
>              !(ops->supported_ring_params & ETHTOOL_RING_USE_CQE_SIZE)) {
>                  NL_SET_ERR_MSG_ATTR(info->extack,
> @@ -196,9 +209,9 @@ ethnl_set_rings(struct ethnl_req_info *req_info, struct genl_info *info)
>          struct kernel_ethtool_ringparam kernel_ringparam = {};
>          struct ethtool_ringparam ringparam = {};
>          struct net_device *dev = req_info->dev;
> +       bool mod = false, thresh_mod = false;
>          struct nlattr **tb = info->attrs;
>          const struct nlattr *err_attr;
> -       bool mod = false;
>          int ret;
> 
>          dev->ethtool_ops->get_ringparam(dev, &ringparam,
> @@ -222,9 +235,20 @@ ethnl_set_rings(struct ethnl_req_info *req_info, struct genl_info *info)
>                          tb[ETHTOOL_A_RINGS_RX_PUSH], &mod);
>          ethnl_update_u32(&kernel_ringparam.tx_push_buf_len,
>                           tb[ETHTOOL_A_RINGS_TX_PUSH_BUF_LEN], &mod);
> -       if (!mod)
> +       ethnl_update_u32(&kernel_ringparam.tcp_data_split_thresh,
> +                        tb[ETHTOOL_A_RINGS_TCP_DATA_SPLIT_THRESH],
> +                        &thresh_mod);
> +       if (!mod && !thresh_mod)
>                  return 0;
> 
> +       if (kernel_ringparam.tcp_data_split == ETHTOOL_TCP_DATA_SPLIT_DISABLED &&
> +           thresh_mod) {
> +               NL_SET_ERR_MSG_ATTR(info->extack,
> +                                   tb[ETHTOOL_A_RINGS_TCP_DATA_SPLIT_THRESH],
> +                                   "tcp-data-split-thresh can not be updated while tcp-data-split is disabled");
> +               return -EINVAL;

I think using the userspace command line argument names makes sense for 
this extack message.

Thanks,

Brett

> +       }
> +
>          /* ensure new ring parameters are within limits */
>          if (ringparam.rx_pending > ringparam.rx_max_pending)
>                  err_attr = tb[ETHTOOL_A_RINGS_RX];
> --
> 2.34.1
> 
> 

