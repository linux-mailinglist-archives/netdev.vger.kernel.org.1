Return-Path: <netdev+bounces-147171-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 605999D7CF0
	for <lists+netdev@lfdr.de>; Mon, 25 Nov 2024 09:32:31 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id ABED41634BD
	for <lists+netdev@lfdr.de>; Mon, 25 Nov 2024 08:32:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1D7AC187FFA;
	Mon, 25 Nov 2024 08:32:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="GTmA9zyH"
X-Original-To: netdev@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.9])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 75772188CCA
	for <netdev@vger.kernel.org>; Mon, 25 Nov 2024 08:32:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=198.175.65.9
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732523534; cv=fail; b=Cm3AoaExN/GizRznakGFHoS+CKqdWJcUClGzoiFDhlZM2/sdnwK1krhXmiyu+HY0DDDhEx/oCS1xpA5hof3ZHfT46BoZMYkCzJ2xQmIfWg/kwXGWwC+ourY6YVG1FES8rnt52p/UwSU+8tg3T5IVxCpcSR1ll4BTGxVSHn7pCvM=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732523534; c=relaxed/simple;
	bh=R74lrxQ2ivSmsYtFoa3+8jArwG9EDrP54Yn/UrQWwnY=;
	h=Message-ID:Date:Subject:To:References:From:CC:In-Reply-To:
	 Content-Type:MIME-Version; b=F405fcYyXOvU0jz3g7fgXYc1fTLjPNbuH5IRoO8IkWT6S3eAaLJuAkRWUPEVHpMtlIIFuPcEaHDIp6JFmxa5QNeQwmTEzbZzOCYiWrgfwaYCj+LMDF9Uw9GvRd3kSc06vPOkEDPCPlKp0ZdEPeLDUt7WsmDnd9L8vK8GPFF6scA=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=GTmA9zyH; arc=fail smtp.client-ip=198.175.65.9
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1732523531; x=1764059531;
  h=message-id:date:subject:to:references:from:cc:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=R74lrxQ2ivSmsYtFoa3+8jArwG9EDrP54Yn/UrQWwnY=;
  b=GTmA9zyHBnpg3cxpoAxzg308FWm35UH1GqrKTiPWgUDQ5Bg+2HdGw4ke
   qmonvGQIQonDQ/ZPZ3Iv1iMaIpnzG7dNdpLjLf0+vCJi9pppymX3cSp3j
   vyYFJ6QT0RitQmvrFeTz3bQ4l6jp8Ev2gSd3zVJIRhoarVSTJ3+0sVP0a
   hpVNatOB6dlJVhGyx4L0Jy17K+36uUwbM83izUUF/VBvhurBf8gF+YAyh
   /eU2tCQCu/Ly+bDSW+8202jmeCMSGnjyM0QIW5IOsKKZS8F8LcNnq26mF
   7hruuBDrUPzZu5DhmFgkMBGui9mxV3LabNlWrnjGpKoTiwYMbTVbmGIU2
   w==;
X-CSE-ConnectionGUID: s03OnBOUSLGDwGwrlJ8Lsg==
X-CSE-MsgGUID: XL0He3EcSAKNWzC0DauYLA==
X-IronPort-AV: E=McAfee;i="6700,10204,11266"; a="55119587"
X-IronPort-AV: E=Sophos;i="6.12,182,1728975600"; 
   d="scan'208";a="55119587"
Received: from orviesa007.jf.intel.com ([10.64.159.147])
  by orvoesa101.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 25 Nov 2024 00:32:11 -0800
X-CSE-ConnectionGUID: qPO++9n/RWOyGqRgI/6rZg==
X-CSE-MsgGUID: nFKPioz4SLSwZG3RYA6i0Q==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.12,182,1728975600"; 
   d="scan'208";a="91609522"
Received: from orsmsx601.amr.corp.intel.com ([10.22.229.14])
  by orviesa007.jf.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 25 Nov 2024 00:32:11 -0800
Received: from orsmsx601.amr.corp.intel.com (10.22.229.14) by
 ORSMSX601.amr.corp.intel.com (10.22.229.14) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39; Mon, 25 Nov 2024 00:32:10 -0800
Received: from orsedg603.ED.cps.intel.com (10.7.248.4) by
 orsmsx601.amr.corp.intel.com (10.22.229.14) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39 via Frontend Transport; Mon, 25 Nov 2024 00:32:10 -0800
Received: from NAM12-MW2-obe.outbound.protection.outlook.com (104.47.66.46) by
 edgegateway.intel.com (134.134.137.100) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.39; Mon, 25 Nov 2024 00:32:10 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=lAvXoVra/3ho58nY+QUX6JooBDVjbPaJunvY89kerWlcDlk8N9NFmQpyHSmQGxfdKUfgH6R+PEe8CUnXPIG7Yfs+ysR5cmzt8k/mtjJvJLgN3YGaXQmos42l9O+MCgz1Irfyxf/faRRa6GJ42cHU9KQKu7/IXGl4X2qmDsHuZXG5RXcuRghAnH48+QLtxv+TibrONfWkQpzZqW4siT4gWlqr6Geu68GdnX7Zvy7oLyi3vWr24Pn4YZdu8CeZxeURiLFldEop79DAtsyKgdenZeDJsLhWjMNQUqzGRBBsaDxvQ0e2mIMQoeXQqeAAy2vuXBt6O/s8DOz/Ux4uDthxew==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=kyigCivkKAhas5STNpsXpBu05u1oJtxplStLLOGXFjA=;
 b=LHYgv/PyST1QeAgZq9F+SnfXES1K1K5Q/lx2H0TvpmupRi4KW9Xz8ex3vSeEi1fEUNPnrHaxiQF9Xg26baNcM2yKRAPZUnONIkclMQvCvy9Y3bhBfnCSf5eT12j8/IHTXokRlZssUt+oGe+6aD49bK9U9M3ZyRtXlm6oaC3a6ljclvuaX5GV+btTuN8taGuzsjXS27sIFYnfOkAo3EVWcItNZKjw6G1Y5FPkxLGx+gg+icj3ZS0firXQzH5GCZ/x+ph9QiXOOl9bcbBCJteqisI87h6bmjGSjF9N0v0ZV0pWtycTqPBS03exNUM3YREx/iRxf6Io+U2TN3Y/hRKFPw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from MN6PR11MB8102.namprd11.prod.outlook.com (2603:10b6:208:46d::9)
 by PH8PR11MB7022.namprd11.prod.outlook.com (2603:10b6:510:222::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8158.18; Mon, 25 Nov
 2024 08:32:08 +0000
Received: from MN6PR11MB8102.namprd11.prod.outlook.com
 ([fe80::15b2:ee05:2ae7:cfd6]) by MN6PR11MB8102.namprd11.prod.outlook.com
 ([fe80::15b2:ee05:2ae7:cfd6%4]) with mapi id 15.20.8182.019; Mon, 25 Nov 2024
 08:32:07 +0000
Message-ID: <793f72a2-54c3-42b5-84c1-a2ae24b87223@intel.com>
Date: Mon, 25 Nov 2024 09:32:03 +0100
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net v1] ice: do not reserve resources for RDMA when
 disabled
To: "Ertman, David M" <david.m.ertman@intel.com>, Jesse Brandeburg
	<jesse.brandeburg@linux.dev>, "jbrandeb@kernel.org" <jbrandeb@kernel.org>
References: <20241114000105.703740-1-jbrandeb@kernel.org>
 <IA1PR11MB619459AFADE5BB3A515C0577DD5B2@IA1PR11MB6194.namprd11.prod.outlook.com>
 <45ce4333-57da-4c32-ad06-c368d90b1328@linux.dev>
 <acd9c54a-bfaa-44f3-94b3-85442277a65f@linux.dev>
 <IA1PR11MB61942704E6FF9FDEE627DE7BDD232@IA1PR11MB6194.namprd11.prod.outlook.com>
From: Przemek Kitszel <przemyslaw.kitszel@intel.com>
Content-Language: en-US
CC: "netdev@vger.kernel.org" <netdev@vger.kernel.org>,
	"intel-wired-lan@lists.osuosl.org" <intel-wired-lan@lists.osuosl.org>
In-Reply-To: <IA1PR11MB61942704E6FF9FDEE627DE7BDD232@IA1PR11MB6194.namprd11.prod.outlook.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: ZR2P278CA0046.CHEP278.PROD.OUTLOOK.COM
 (2603:10a6:910:53::19) To MN6PR11MB8102.namprd11.prod.outlook.com
 (2603:10b6:208:46d::9)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MN6PR11MB8102:EE_|PH8PR11MB7022:EE_
X-MS-Office365-Filtering-Correlation-Id: 3b56c79b-eb4a-4a56-012a-08dd0d2ba613
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|376014|366016|7053199007;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?VDdzMmZIazU1QVBNZjNBeUt6eE5qTGd6dUdUSUduVllwZFg2NjM2NUVxdlJk?=
 =?utf-8?B?V0hxNThDdjhuZ09FbHFlNklraDBBVm1RemZZaVRmSUljc08xUXp1Y2hrWWVU?=
 =?utf-8?B?VEUzYUF1dlo2eXNLTUM1V25wUjFKZXpQbS9udDZyaUQ1K2FERDIrNXhjckdy?=
 =?utf-8?B?RWRCR25NUGg5b3YrTUJhNTVoNGFWT1A3ZDBWeE1MSGpPMEZRWm03TFlySjBH?=
 =?utf-8?B?dTRoKzNaQ3p6dUV2ekU1Z09JRkJEaFJ0VXMraDVsYVVUbXZvZU1LNGc3c1dJ?=
 =?utf-8?B?ZFVhSmlRT1V2bldpQUxPa2ZaRkFQTisvc3lreHpQTkx3NWpUL0lHZGZVTm1X?=
 =?utf-8?B?MzZ6UDhPRUpvVE5sZ2t5Ulo2Mm5vQmI4b2Q5TEtabGxZTzlnTy9jZ3pMdVZR?=
 =?utf-8?B?NnJUaDlscWtkMHpZeDBySkdtMmJnVm5OVHFNTEhKZXlHa3FLeElEU2tZMmk0?=
 =?utf-8?B?aFlSYXpCMXNaejcrR1lDT2F0bjIyVzNKVm1FYXVkK1c4TGpodFVja3FRUThk?=
 =?utf-8?B?V2cyakl4d0ZQdHYxa1JCWnIzdGNwL2h5aytzQ21pZjhKN2lsWDBJcjFmVG5z?=
 =?utf-8?B?dmx1SU1wYjlZWTdXdFZhQ3BnN0E1cW50OXVqVDlzNlBxTThqVXFSZ1BsYmxR?=
 =?utf-8?B?OW54SkltK2ZoVnJJV2hpbE9xOUtKV25VQkRSN0Y4bCs5WlQ4a1A5blNiOXU0?=
 =?utf-8?B?STI2VUVmVUpNS3pMT09kd1o3b3hpZ2duc2VXcEhvMXA1OUduaU14bkdGMEl3?=
 =?utf-8?B?QzdpSHJIMlRQWVZROTMyR1V1b0tmR2xMczBWZWI4bndqNWxLZmZWVWpOcnBu?=
 =?utf-8?B?MmVBRUFXMmF2SUhnY1NOTnMzRG1VbkU0ZkpvblQ0aFRXaGpqNE9wYUtGRzg5?=
 =?utf-8?B?cHZtYU5DR3RyV2xuOTVJZWZFb092YXYxZU92NzJTWDY0d2VlL3lFMmI5OGhz?=
 =?utf-8?B?YktPemRONjlFazloM2kwUnNIREVCclkyL1QzNTBmZEJCeC9ZRjBlRDFkajd6?=
 =?utf-8?B?YjZJd3VxSUhPakFZSDRzRTUyYTJHVFhUTDFXMlZwbzRpUCtwWFZTRFpzUyt5?=
 =?utf-8?B?K2w3S1hBamYwQzRnOWdrKzhaeng2aXJ6Nkc1dDhOejNtR01lR0RrbVoxcEF1?=
 =?utf-8?B?SC9sUm50bjlmcjQyMjZ5ZGxkVFIzTldtSXllR1J6eGh2Wk5kVHZMUk81UTRO?=
 =?utf-8?B?SldxSjhpam5EaHpTVmlzdlNCV2dUdWJPU2h0TkZCTUtHeWJ6MDR2OTFzbVJi?=
 =?utf-8?B?TGRNTDRnVW9aZTJaTDV2Y2dOTWRyaFRwRDltUzhYUFBuZ0xhR1d1WktqMERv?=
 =?utf-8?B?ZXN0am9haTl3S3ROMlJUZTRTS0hSNmtwOUp5QzRDbW1nOHBBa1VPMmVxaWY5?=
 =?utf-8?B?RUplZU9UUndFVUxxLzNTSk9pL0U0MWdUK0JOYVJYSDc0czJEMVd5d1V0SytP?=
 =?utf-8?B?NUpxemhKMW5KTTcxTHB5azFTSGxNRmROblVOWk0ySjRheEtuVFQ4ZHFvNDI5?=
 =?utf-8?B?QytPWUxLRE81MHlxSzR5dFlZUTR1b3JjMVA5VjFmNnE5WnhUOXd5Q20xTDNj?=
 =?utf-8?B?TGpJcmNwaHR0TlRjc1p0Y2E2cUFSYTRqZTFxZm5EVkhQallBbU1nVjl1U3NV?=
 =?utf-8?B?RSt4N3U5Ny9MbEIvb2pZQlYxNCszUzBxVkxObEUrNk9SdzA2bm1vSVV6TlZy?=
 =?utf-8?B?cW42a0QrcE96NGR0RjZaMkU4dy8xRGxjaE1jUlJjQVVXNHYxWEczRzhPaG9M?=
 =?utf-8?B?TmFjdEc3eFErVFpPeTZIcmUrdUZWdzRLUUlVL0VxdXFBZ2ZzLzFxYWxMNlU2?=
 =?utf-8?B?RzkzVUY5dnBMOWJ3SnRPUT09?=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MN6PR11MB8102.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(376014)(366016)(7053199007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?dGl0S0IxRWdMM2hLVTY3Nnk0L21MT1dsWUx2cEpZWXhxbENHdGJwc1diTTdu?=
 =?utf-8?B?b1Z1ZTU0N2RQQUhRdzVrQ2VLZyt0MitBU2lHempUSDZ5Q1Q0T0lSNVNMeHEv?=
 =?utf-8?B?Vmh3VTJXcmlNWDlJWjcrNUYyaG54cEFaVUc1TkNLcGxWWHZKMUxYVVRqdldV?=
 =?utf-8?B?OWNXYStHWm9IQzBCZm1GMVZjUWo4WnB1WnVxRDB0WHd1bWdDU2hJeDROL0RW?=
 =?utf-8?B?QWtaUTdKaDdJK3FxdUZaejdHYVpMaytrc2tndmNRSURZWWFPU3dMYWRzaEgv?=
 =?utf-8?B?QzVVZ1RoczZZRld6T0x4S0FqWllrem5PQ2hVVUM5U0NveWJqMzBoaThIWlls?=
 =?utf-8?B?bm8vVHMwVzB0bTlLTTREVmwwOTc3Z05iVEVhWGJWbXp5WER6V0JxV0xTVk1Z?=
 =?utf-8?B?WkFIMUNDZE9rUTF2VGx5ekgxbUEzQ0l6ZVNrWE1lM0greXZPRkx0Q2JpYUtz?=
 =?utf-8?B?WlJLbG00Y0xBZG5iK0FpTTg3N3NWeTErc1RpNUxzazBzOS9mTXdVWGVKS3RH?=
 =?utf-8?B?eTkwVjdsU0dSL2tGMTNoZ2hyWENlTkp1YXN3SmlXZnNqa0xmNmFZUW1GS2p3?=
 =?utf-8?B?QmVPQzA1WGJxQytYMWhXU1cxUjBOL3RUanVCZXF2T0VmaTE4RkRiSVo1MUFq?=
 =?utf-8?B?THlOVEpBYnhVT3FrNzNqV1R6NzY4U3djbDBwUWNPUE5QNmRNL0NidXViT0xa?=
 =?utf-8?B?M1RDN1lLNEZmbVR5VVBpZkt2OXRmQlhpcDhvTVF4MGRoUHdUVFAxcTdkcWtB?=
 =?utf-8?B?V0FYZ21XdmM3c05zTkJzalF3d045TXJLK2RDK2ozOUpiWEJpcDZQWkt4L29p?=
 =?utf-8?B?NGNBbFRHdHVuZm5GUDFDWW9TR1F0Zzk0dkFaU0oxTUxiRWU1R0dvYkpwbWhk?=
 =?utf-8?B?bW9IWC9LVTRGR1IyT2dzUlFLVHBheUFpTHM5dkp4Z3k2Zmd2eG1QT3hPRVo5?=
 =?utf-8?B?aEhzN2VQSkJzampJQkJZSEZwclhyaHRyOTFaU2ZhN0ppSDd2RllBd2ZIenZ5?=
 =?utf-8?B?RG9ZVWhuYklaSndWNjc0Z1pjV2NxblhxY3JjMHdoaFFYSXhHb0dXQ0tGcVp5?=
 =?utf-8?B?czlFL21DREZkQVpxTnRRdVZZRWlQOU9jclk2MUFlMFdqTnZRcmVKM0o2M1g1?=
 =?utf-8?B?NC9xeUlSWUd4NGgrZitkYWNKZHI3eTRoS0JEUzJjS2YwUmNEaElUZkhzdzdl?=
 =?utf-8?B?WHR1eGhIMEFTUVhZR1pnbWFaOHJNQXVGaVk4dUhqaXRrQm43L1doZkk0dklY?=
 =?utf-8?B?OW40TWVaZ2NOdEYyRGtLWEZKUkszbTlWTWhXVHRiRFVCUk9pdEdqQ3hoaWFQ?=
 =?utf-8?B?QlYrd3FwVkJBMXp4Y1BHZUZONkgvUnViSFZibGgwMHd1MVNnc1N5OWhRUVIw?=
 =?utf-8?B?SHNGU1lvbzVIeHFrT1JadTdITjNDZkcvb2ZqT0hIdVpPQW9ZTms0UGxtUWJP?=
 =?utf-8?B?ZDh2dUU4QU9nVXRDazJxNmhHSnVNTDR0dlhWYnRuNDNLWTN2MnA5Z3lUclF3?=
 =?utf-8?B?SjdzSHhMYWM5TFd1WjNZTVZINHFiWEpxd1d5c1VESng4R0F4V2Z6Zm5KQmJy?=
 =?utf-8?B?eGFYN3RrOGJMdktzVGF3bjgzbmt5TTdtdVdaL3J0b0tEWkxibjBmOXZOQytS?=
 =?utf-8?B?b2hQQ01mbmRHT0dWRmtyTGR6RmJXWDZuZzNmWllxekVMVExnQVZkQnRicGxa?=
 =?utf-8?B?ejhYeTdjTHFQeGFNSUltYjQzemJUaFg0WVp4UE9TcUdzUUF2K3lPakNhZ1Zz?=
 =?utf-8?B?MDcrRjQwamw3YmsxZ2pkai8vdW1hOU5EOC9YNUZwdktqa2FaWHBVdzh2UmVB?=
 =?utf-8?B?elpQYVV5SDcxQlFVLzN3MUEwbHVNdjVlR0dFRFhCYXI1anFBMDIxSUU4TStK?=
 =?utf-8?B?blFrOUtKWjRrNEd5djdXaTF4TEhpMUYrQ0tmSitncmZhWVB0c1lmOEZJQ1dD?=
 =?utf-8?B?MzJraDBWbWxnK0dyT3NGV29hb01iTTBaa1ZTd2Rxa3JoQk80RmZNMFhGTldF?=
 =?utf-8?B?TWdPVURPckpsQVZlMEY4ZUVDdlByTGZuOTRKM3YreWtnU05nQlF4RlZoUTFv?=
 =?utf-8?B?WkNBOUJPV0dVN2RPY3pBanE4dFZCbUNjK0hadFpZWnFGNnhsOS9aYUltbXZ4?=
 =?utf-8?B?MTFEUjdrVWJWSGhzcWZvNEZBVWJqRVIrdnNBam9sNVF3WkNXMzg3Um42TklT?=
 =?utf-8?B?ZVE9PQ==?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 3b56c79b-eb4a-4a56-012a-08dd0d2ba613
X-MS-Exchange-CrossTenant-AuthSource: MN6PR11MB8102.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 25 Nov 2024 08:32:07.8616
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: MPGFndvWDt+UTLlOgQdXR7hiliOHSErfmK/JXOe1VnJzcz1Vn/zfVv6mc2TD0VhrYNw8AUyv3y6ZHFui/cWKdOU9VG/8PrisvaE8jm/x6dE=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH8PR11MB7022
X-OriginatorOrg: intel.com

[CC IWL]

On 11/22/24 23:35, Ertman, David M wrote:
>> -----Original Message-----
>> From: Jesse Brandeburg <jesse.brandeburg@linux.dev>
>> Sent: Thursday, November 21, 2024 5:50 PM
>> To: Ertman, David M <david.m.ertman@intel.com>; jbrandeb@kernel.org;
>> netdev@vger.kernel.org
>> Subject: Re: [PATCH net v1] ice: do not reserve resources for RDMA when
>> disabled
>>
>> On 11/15/24 10:46 AM, Jesse Brandeburg wrote:
>>> On 11/14/24 10:06 AM, Ertman, David M wrote:
>>>>>        case ICE_AQC_CAPS_RDMA:
>>>>> -        caps->rdma = (number == 1);
>>>>> +        if (IS_ENABLED(CONFIG_INFINIBAND_IRDMA))
>>>>> +            caps->rdma = (number == 1);
>>>>>            ice_debug(hw, ICE_DBG_INIT, "%s: rdma = %d\n", prefix,
>>>>
>>>> The HW caps struct should always accurately reflect the capabilities
>>>> of the HW being probed.  Since this
>>>
>>> why must it accurately reflect the capability of the hardware? The
>>> driver state and capability is a reflection of the combination of both,
>>> so I'm not sure what the point of your statement.
>>>
>>>> is a kernel configuration (i.e. software) consideration, the more
>>>> appropriate approach would be to control
>>>> the PF flag "ICE_FLAG_RDMA_ENA" based on the kernel CONFIG setting.
>>>
>>> I started making the changes you suggested, but the ICE_FLAG_RDMA_ENA is
>>> blindly set by the LAG code, if the cap.rdma is enabled. see
>>> ice_set_rdma_cap(). This means the disable won't stick.
>>>
>>> Unless I'm misunderstanding something, ICE_FLAG_RDMA_ENA is used both as
>>> a gate and as a state, which is a design issue. This leaves no choice
>>> but to implement the way I did in this v1 patch. Do you see any other
>>> option to make a simple change that is safe for backporting to stable?
>>
>> Any comments here Dave?
> 
> Jesse,
> 
> Looking at the FLAG as used in the ice driver, it is used as an ephemeral state for
> the enablement of RDMA (gated by the value of the capabilities struct).  So, I agree
> that a kernel-wide config value should not be tied to it as well.
> 
> Since the kernel config value will not change for the life of the driver, it should be
> OK to alter the capabilities struct value based on the kernel's configuration.
> 
> Sorry for the thrash.
> 
> DaveE
> 
> Acked-by: Dave Ertman <david.m.ertman@intel.com>


