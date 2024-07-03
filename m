Return-Path: <netdev+bounces-108895-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A9D729262C8
	for <lists+netdev@lfdr.de>; Wed,  3 Jul 2024 16:02:58 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id BCB131C20D21
	for <lists+netdev@lfdr.de>; Wed,  3 Jul 2024 14:02:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8F462139D16;
	Wed,  3 Jul 2024 14:02:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="RAkqiiDC"
X-Original-To: netdev@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.20])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3D7A21DA318
	for <netdev@vger.kernel.org>; Wed,  3 Jul 2024 14:02:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=198.175.65.20
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720015374; cv=fail; b=Ahu/WTQjZ1PO3yt7eCluifd+h4O8vR2Erqdcw6Xl2iufQl5T+BELpamHf0PGNcDaBHgF8SJTgSJ9EMsojVb9NaJxJ1oT5IvlGjNlsDqQFtx7zOq6oMb9Nt6yFisIsorIUUJeAhMfUmHhAIJRvJ5OnU6zzH53UxtxPtrCBKB+AAQ=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720015374; c=relaxed/simple;
	bh=6sfdEdXNuixxspL/P9bEcdHSpUbVD44y9WlZUp2GIng=;
	h=Message-ID:Date:Subject:To:CC:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=S+rqL7ArzT1d8GukyHCCuLdQan//teopYDBsiicV4HZ6z9aQAljy4nu2dC0SGd1KcH3TycTfMPVql+YGLpnXgUShHhKO29rdVBYpc3e/TA3Mj1mIWj09L+eEycQw3LR9g5VPDRb6TTzjaS7PhkgnBhGMl3DuPcFuVU3SAdB2QLU=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=RAkqiiDC; arc=fail smtp.client-ip=198.175.65.20
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1720015371; x=1751551371;
  h=message-id:date:subject:to:cc:references:from:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=6sfdEdXNuixxspL/P9bEcdHSpUbVD44y9WlZUp2GIng=;
  b=RAkqiiDCJ4IShecVJpx6lMCXAvmI9qA6Dknp7YCipo0h+pWf4loZcbg3
   Ib6aWepLI4ymgpquYD2Hfax7xIQnVm9GXG8MWFXANqKx5yTwXryf1/MAT
   ATgBo0kO7iIIL+YeD2xTwX4T3AUX1Os/iBzqJSmry+bCVXr0EcHXUjL00
   VNRjg0i4pa49Fp9k8q2V82PIofMa0bYhiGvizb7BmB7EGQtCF1Uzt9smW
   yeUHrtjJGcDP7Lsll/jMEl6fo6jYl/c4suej9TxNX9mcVTP8vj9mzZgTD
   Pc8FxeyNzYcViVmpWLbul4WAQUgK/Y3WvX2dyW6NQVVEvSwNg09d6CEwV
   A==;
X-CSE-ConnectionGUID: kn3qeQlSQBOtAzO/r3FNKQ==
X-CSE-MsgGUID: lYJODZeQSESJgew1rRb4wQ==
X-IronPort-AV: E=McAfee;i="6700,10204,11121"; a="17069779"
X-IronPort-AV: E=Sophos;i="6.09,182,1716274800"; 
   d="scan'208";a="17069779"
Received: from orviesa006.jf.intel.com ([10.64.159.146])
  by orvoesa112.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 03 Jul 2024 07:02:50 -0700
X-CSE-ConnectionGUID: MS4FZfHOTIWkrFQ6rgllnw==
X-CSE-MsgGUID: 9jRL0SLITN6ra7GKnOKthw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.09,182,1716274800"; 
   d="scan'208";a="46692294"
Received: from orsmsx603.amr.corp.intel.com ([10.22.229.16])
  by orviesa006.jf.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 03 Jul 2024 07:02:49 -0700
Received: from orsmsx611.amr.corp.intel.com (10.22.229.24) by
 ORSMSX603.amr.corp.intel.com (10.22.229.16) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39; Wed, 3 Jul 2024 07:02:49 -0700
Received: from orsmsx610.amr.corp.intel.com (10.22.229.23) by
 ORSMSX611.amr.corp.intel.com (10.22.229.24) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39; Wed, 3 Jul 2024 07:02:48 -0700
Received: from ORSEDG601.ED.cps.intel.com (10.7.248.6) by
 orsmsx610.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39 via Frontend Transport; Wed, 3 Jul 2024 07:02:48 -0700
Received: from NAM11-BN8-obe.outbound.protection.outlook.com (104.47.58.172)
 by edgegateway.intel.com (134.134.137.102) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.39; Wed, 3 Jul 2024 07:02:48 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=gQrtTfOUweDyyGiDK+BCvfHpoJi7vfyVnxp7zGm0yeNs1I1vWt2t7sJBkrk2+i7tUZiOxY0ntSObhrwFAF5+T/wPjM9Ou+HvkliXzMM/gEdp0ZpXWHS79yZoR9an4s58w+3DaXvl/8MIcv2tF8MZzVaJsBHq8rduqZ9dTOWcwx5aPuGj0BsYkpoSPdIAgrO6AOzeHfrmG4teJ+rOpLUqLGo92mnxbPtQ4HsG6WkSd2+ZbJafPOIaJ0VikqAh5HRuuisQPWck5EQN11wrHL/e5pmUVT6KAaYEToFWqCGOhi511pQKf2AAJvibF568Yba59nLNBKH926YztfgLcNBt+A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=rfnhrvzJrkyRaYvoSAHFr2r5i6fAwy2q1X1wWzmHaug=;
 b=g2vkLoUusDsoxPfGNorsSLtbXJbbhRittpZs+n8rSBXCqqmB7RhOl/ZRXIGp9mDhPxF4fxNutU4yU/qjlYC+fsC7Jw78x4lZt0FjBvZhXovcKyeiZ1On6rdkj0TtSTarrZVbcBTdbV76KNvc5H49KpkPQwOvnLroGTxnYrbOkXzs2VWnalgrb0Eh1+yc6IMWXp0leh1QOMJs8R0NXv2AUSKt4e0UzrL2Uf1gsjjvha6FBWTM056qZwFvXIpawG9zTpoEDAHTkhNKJzS7eHJQpL8Ewn2Ra3ReI+NWakO47NzRUv5CBxdH1OoQdpyI6G/jj3uKcto3/pomnKyO7jV1Cg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from MN6PR11MB8102.namprd11.prod.outlook.com (2603:10b6:208:46d::9)
 by SJ2PR11MB7620.namprd11.prod.outlook.com (2603:10b6:a03:4d1::5) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7741.25; Wed, 3 Jul
 2024 14:02:45 +0000
Received: from MN6PR11MB8102.namprd11.prod.outlook.com
 ([fe80::15b2:ee05:2ae7:cfd6]) by MN6PR11MB8102.namprd11.prod.outlook.com
 ([fe80::15b2:ee05:2ae7:cfd6%7]) with mapi id 15.20.7741.017; Wed, 3 Jul 2024
 14:02:44 +0000
Message-ID: <969b53a8-0f66-4b5b-9465-c2e5d6d4164b@intel.com>
Date: Wed, 3 Jul 2024 16:02:38 +0200
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net-next 09/11] eth: bnxt: bump the entry size in indir
 tables to u32
To: Jakub Kicinski <kuba@kernel.org>
CC: <netdev@vger.kernel.org>, <edumazet@google.com>, <davem@davemloft.net>,
	<pabeni@redhat.com>, <ecree.xilinx@gmail.com>, <michael.chan@broadcom.com>
References: <20240702234757.4188344-1-kuba@kernel.org>
 <20240702234757.4188344-11-kuba@kernel.org>
 <0a790e16-792b-448c-abaa-a4bf8cc9ebb0@intel.com>
 <20240703064909.2cbd1d49@kernel.org>
Content-Language: en-US
From: Przemek Kitszel <przemyslaw.kitszel@intel.com>
In-Reply-To: <20240703064909.2cbd1d49@kernel.org>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: MI1P293CA0024.ITAP293.PROD.OUTLOOK.COM (2603:10a6:290:3::6)
 To MN6PR11MB8102.namprd11.prod.outlook.com (2603:10b6:208:46d::9)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MN6PR11MB8102:EE_|SJ2PR11MB7620:EE_
X-MS-Office365-Filtering-Correlation-Id: 11604e09-7322-48fd-5a00-08dc9b68cfea
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|1800799024|376014;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?UmJMRzl3R2pxalpUZWpKMWg3ZFhaV0dCTGVETnZ2MFd0U2YrTXlVc2ZXeUFJ?=
 =?utf-8?B?VGo4aXQ2SHdxc2Z6SG44MlA4V2pGUkVvTEpCL0t5Z0JHUDlSYVJ0SXI3TXdi?=
 =?utf-8?B?RnVleXVTbUVoZUVFWXEvam1XWmM1OVEwcVlLVDFEcFpwQm9wcGptVEdsYlVZ?=
 =?utf-8?B?bVJzRTc4UkM3ajJBaHNoek43bklWVDVRNGZzSUl1K3I1NEtHUTg0WGF5TGdr?=
 =?utf-8?B?eE5PN3diVFRYc01XdGJtZWprUXRNTUVMbjE4d2UwUzE2VVFvUytNbVgwbjlE?=
 =?utf-8?B?TjQ3VjVSb1pvYzlQTzZ1TUsyWlhpaTVCTHZwQTAvMjhsVUwwMGQ2TzZtWEoy?=
 =?utf-8?B?QjJmaGl4Z3oyOXg4alM5enhtNUhzZjdhSHVBU1U1OUJtUWwrbDJqZXB4NXla?=
 =?utf-8?B?VlhkWm5KeENub05NaUZNWU03V2VsSDZWWndRQWFnSjR3YmlYdlM3ZFNRdmlY?=
 =?utf-8?B?ZklQRC9pTHRTUmNTaDNrZldsNml2VVRpbnZjbm5TM3hnL0U2RjRWZWlvLzRZ?=
 =?utf-8?B?UFVDS2RibGJCNllXbnkwK29nWDJPVkZrb2hqOUhYUXMvaitiN2QzWTN6NDh4?=
 =?utf-8?B?WmpmU09oSEx6cmJhTml3RnRYVXdSU1VuKzh0MkxxS2dWMnNIcmFrLzcxK2dt?=
 =?utf-8?B?Zk5kR0xuSGRha1d0SThPUUx2SGRwMlhRMUI1T2ttd0lZWGMyRzFHb3c3YmNh?=
 =?utf-8?B?eWxMVVRYSDdUd2dLMVNOeThURGswbVM4SkR1WEdwVWV4aGFEYm5MTStYcTJx?=
 =?utf-8?B?WnhiUzlaY016dk11WXJhSTZQWEYzWHB3Vk5CbUpJcFQ2WlZsb1NrMDFnbDZz?=
 =?utf-8?B?dCtDOEVqemN5ZjIyRkRhbzE2ZEdSQnQxSkpRWU0rTGxjcGRrYjRqb214Yldl?=
 =?utf-8?B?Z1hjaWxZQWY4akpRY1NwSkRpNXJ6NEJwNjVnNXh6MGt0c2FVWTNYKzRocnN6?=
 =?utf-8?B?QXRBMEsvVkVYbjlpTlJmY2Z1QndaTEcrM2gySURiMnlaL3VTMGJxQ0E2NzJB?=
 =?utf-8?B?M3FzSWQ3am9rbEE1NWROdTdVOHZObGRaZW5oTU1ka0EwazlMOU16RzRqdk5Y?=
 =?utf-8?B?KzJUTlh1VnhMSDZXRmE1STFYQmxMaVZFRmFOSm1aWjNWd1Z0SzBIeHZRVERG?=
 =?utf-8?B?UEJNWVFOUmFRM0w4QVhMT3d1WE9aWVY2bzZ6VGg4OVNDc3V3M0h5bENoNldV?=
 =?utf-8?B?RndtVERQeTVQVVJmMGdRb1ZXOVNpV2xUTGQ4Yml4bzlyQXBRcmw2YWlhbTQz?=
 =?utf-8?B?RWp0RjBhd3h0bS9XT29FYWw5YkRvbUpDSTI5NzlaRXo0czNtYlFxaWhGQmJZ?=
 =?utf-8?B?bmJsTUNyTGNCQjVMZ2tFSXVPcmU2aFYrQ2o3QmJuNnpsWWF5SkxUYzQvT0FL?=
 =?utf-8?B?Yk9iUEtRSE5uT01TNVFJUG1pQ2N0U0poZ3djSW9OSXZUSXFPVERkNzAyM25w?=
 =?utf-8?B?L2V6Z0g2RE50Ry81dHpSWldSY3M2ZGtDN2JnRUZGS1VNY1l5YURwaTFzeWUz?=
 =?utf-8?B?ZHJqak9FVU9PTmJUUWgzZE53NW4wTkxwK2xYVW5MVndMWGtlNlpmRGlUR1k2?=
 =?utf-8?B?ZXNVaFhOZXR3VGxZVmJIb09zTlErQWtaSG5tSjFQb2NBSzFHU0pSUTdabEpv?=
 =?utf-8?B?VGtVVEhiQlRMNldxS2I0TXFOZXhLSHlscVZTQmNrZWJsTlJZRzBLckxHWDRr?=
 =?utf-8?B?Y0JydXp5NS9ITnJ3UFhZa2hvUzNQSDlQY0t6SHNzNEhNSmlEWlZUb2UrUGhU?=
 =?utf-8?B?TTBjTVhuSzV4dmVJWWRuTU9oZFV0VU41TUlLQkxrVE1jQys5UkI0TVNiK1ZU?=
 =?utf-8?B?a01BVXpjR21GakhYMkhyUT09?=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MN6PR11MB8102.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(376014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?NVBTaHIvV212MzFIcDF4cVBvYXVFVnJ2NFBrcSszTEV3ZXdtSFIrRHNDeENW?=
 =?utf-8?B?c1MvaTF3N2VZOWhUbDNZUjZLNVhOMTVJQ1RoT2Z4SUZyQnlSRFpld0ZpeHdU?=
 =?utf-8?B?akxNdmJRL0Q3eGQzaVpaZVFpazV1eWExYXpKYTg2eEFFNnZ4MlYzQlppM2dR?=
 =?utf-8?B?bklBejRkaGJRc3FQTHlnY0Y4dVJIVDZ5NW9YMWRiUkFJdnhQNFdJOVV1UjRP?=
 =?utf-8?B?RGhpVXA4RTRCcWo0WTRLaFZXMC9SbWRKd09QVXBEVmFObDgzR1RoZHF2eG10?=
 =?utf-8?B?UEpYbkNyenhzOUNuNjdGVVF3ekdxcllWa3AzN0lPQU9wbGpOUFF6Yklta2ZO?=
 =?utf-8?B?V2tTRUZEZHkzR0dOb2ZxbHNQaUdHNjM5ak5xNjh5RktQUnlJRkY5V29LUGcy?=
 =?utf-8?B?d2RzRVNxTVBNbkp2Yk9DL1YwWG1Vc3JBUTg4ZXV1ZXdjU3RoblZOYkdVeEYv?=
 =?utf-8?B?MEk5c2U5U1ZBTjdTTHNhOFZhcFdJTGo0Rld4M2tscUN5Z3NCWGFJSTdLYU1u?=
 =?utf-8?B?QmRJam9jQ3k0OTJBRzhjTEhWQlVRZGZybk1OSDdLMGh6MEtzUTU4ZFRoc1JK?=
 =?utf-8?B?K1lnZVdObWtIS3U2dktKQ2NlYjNyMzFCTlpRQ1Jmbkl2Uy8vK2VzRzNmS1Ur?=
 =?utf-8?B?a1UvaHNGNFlRNEtHOEZuWDQyaDBCQmFOWHVaTXJrL0FKVkZGVjUyR3FsVFpU?=
 =?utf-8?B?QVdoTk5LWFZyemJnNmdVZXh1WDkzUHB1d1B6bUFlRTg3aW9aa3Bka2hPUmY0?=
 =?utf-8?B?NUVMWXBQSGlOUTQwa1V5cXdlQWhDaWVqb2RYODRlMDFZTGM1b0NHVjJ5MEVj?=
 =?utf-8?B?ckZFZUxuVHRCSnI4bGhUS1lySUhuSkIrVVh1dnNIRnROYk4yMnRFTlRWc1lP?=
 =?utf-8?B?bGJ2M1M4OXRON3BocU5WVmY1UnRpRWNybzNBSk9GWVlaTVZ2d015RGpYK1Rq?=
 =?utf-8?B?VjIrZEg3Lzg4VVJoQTRvbW5lNEs3L0Rvbnl5dkpJaWRRdHN4MVJmNVkrMDFU?=
 =?utf-8?B?Z3c3S003RVZyaXlXci9XcmhBWWZmMDZqL3hHSkx0SnM0R3FkanA5MVFHZm1Y?=
 =?utf-8?B?ek9XelUvTHVQY2pJNXE0eUZzQ1VRdmVaTHo4RTNHaHFHOFJ6TVppTUhxSUxv?=
 =?utf-8?B?ajcyWVEyTGg2eE9yamRDcnpXRWNjTzB6Zjd5NFBkb09hNVBrMEtJbkxUZDg2?=
 =?utf-8?B?RnQyQndiN0p5TU1pNjlCclNub21xMk42d1FKb2xwQ1NIbVBlK3AyRENJRkRw?=
 =?utf-8?B?VlNGQXY0MlozZEpmNE5LQjZrbDY4Tzg4MzltM085N3pFSDJvemZVbmFQelEy?=
 =?utf-8?B?eG44RTZteGdFcmJZV21iN3BsMEt0ZStmOHVwMG9SbnZSQVJGRzJyd0psYjd3?=
 =?utf-8?B?NlZnZUlEZjl6M0RnYlJKbVlpazJPRVZBUFlKNlFNSTIvalI5LzBHWFpLdUdP?=
 =?utf-8?B?eFdzdnR4TGpzMU8yOWNOYzlRMVZaajhBaGNYQ1Vyc1NCWGU2cFduVllKd01a?=
 =?utf-8?B?SGVBQTFLVGVVYklSOXhaeW9Hb2swM3kzelM3c1Fxc0x6WEtlZzJaT1RFZzdx?=
 =?utf-8?B?c1lDSXNDN2hnZlpSRjZnVEROUTBPSWpWSkE4dVlXc2hZYXpIS2liVzJEbzVa?=
 =?utf-8?B?T2JpS1paekNtV0Flakg4UW92Sk8reFM2RCtGUEJ2M3IyZUpMYzdDZWdxRjJu?=
 =?utf-8?B?bHRkTG1qcmw5UU9EbHZPcm1PZ2tybWoxSEgxekxFUnJSZlVHOHQxWkRoNmRw?=
 =?utf-8?B?dlJGdVJ0NDdYanNBWWFOT3JUVVUyYWFMeVVhWFkrVXV1VWpmR3pHNHF3MXlT?=
 =?utf-8?B?NmxaVXpmZXVIMWFTWk1Fd0wvNWxIK1orcDdWUjBiWXMveUhpbExYWGFzRnRN?=
 =?utf-8?B?TVY1aDZtTjZ1cXVVekVsSnRkR2o0WFJNMFROeFJGNkkvdlJubnlJOVFoR0Zn?=
 =?utf-8?B?RzdHZTczVVF2SjFPRmZTRUhrMUcwa2w2cTJtbDFtUWdsajUwWU9xNTIxU2k5?=
 =?utf-8?B?WVhkTjlRdnZ6T3JUMjMrV0dFNDkwcmFGQ1h5VWpBTUQ4K1BGd2o5NHRFZGlN?=
 =?utf-8?B?dlNZRnpUVmFyWEhXZ01HcVF6VFNUU09ZTUN1ZjI1ZTNDS0pMZWxTR2xVMEU1?=
 =?utf-8?B?b05ubHVnZ3JPNWRBeDZYVG51UFhLWWRxeXhXTE1ybmJZYzhpWVAyUVlsd3hO?=
 =?utf-8?B?YVE9PQ==?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 11604e09-7322-48fd-5a00-08dc9b68cfea
X-MS-Exchange-CrossTenant-AuthSource: MN6PR11MB8102.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 03 Jul 2024 14:02:44.8581
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: RRKloNJtoDdZQp2ZU9Bzpr7pTmAm0jBO2SCpKTUwH+am9JjWelQPLO9fPqZiYdpkb26QN7BgwlrNt6Uh+L1DtiXLGQm9uYxUYS/GtLKwIPw=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ2PR11MB7620
X-OriginatorOrg: intel.com

On 7/3/24 15:49, Jakub Kicinski wrote:
> On Wed, 3 Jul 2024 12:51:58 +0200 Przemek Kitszel wrote:
>> OTOH, I assume we need this in-driver table only to keep it over the
>> up→down→up cycle. Could we just keep it as inactive in the core?
>> (And xa_mark() it as inactive to avoid reporting to the user or any
>> other actions that we want to avoid)
> 
> Do you mean keep the table for the default context / context 0
> in the core as well?
> 

it was not obvious for me that this is only about the default one,
but that would yield more uniformity and cleanups I guess

