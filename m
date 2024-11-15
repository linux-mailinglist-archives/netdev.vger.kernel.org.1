Return-Path: <netdev+bounces-145209-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id B7C679CDAE7
	for <lists+netdev@lfdr.de>; Fri, 15 Nov 2024 09:51:32 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 39E261F230B7
	for <lists+netdev@lfdr.de>; Fri, 15 Nov 2024 08:51:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E66D518E050;
	Fri, 15 Nov 2024 08:51:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="AesYUU43"
X-Original-To: netdev@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.13])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 52A8918D63C
	for <netdev@vger.kernel.org>; Fri, 15 Nov 2024 08:51:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=198.175.65.13
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731660675; cv=fail; b=IzYprMbaTBzJIW3mGPU+73/B0n4kv2s/UVuvwIRnzgZ+LtFFo11P+k4/d9y3t1i9WYdn70P0qXhxHX5sncztZf6M/UR9iKHsH5uXBcFKVGyT7C0CatBJZueRRp2f9ihjaW+wNNGysgtbTe6BrN+8fxAwDNV7J2jiTnWDK2Q1fiI=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731660675; c=relaxed/simple;
	bh=N68Uvl8YaFMYcAMu4o3gNqTUihshnYfKZB3u6YAEKX4=;
	h=Message-ID:Date:Subject:To:CC:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=JLdGglmw8JxDJfj+uNNUFNkvWaNvknAMsOWaa52O+TPqopvT1JLN5xyOaY0NHEPhcJFW0QFoqIgpFYSzD9aKDK4VA2a4u43b5B2+eCBvItwGE6CY+nLINq8viW3oIZdfMH9QNQUs6t9+gewRkxpX7aIrHNS+Bfy1rkVPMAwQrYk=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=AesYUU43; arc=fail smtp.client-ip=198.175.65.13
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1731660674; x=1763196674;
  h=message-id:date:subject:to:cc:references:from:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=N68Uvl8YaFMYcAMu4o3gNqTUihshnYfKZB3u6YAEKX4=;
  b=AesYUU43/d6QP9s+Azs/71A5RPeHOpCn5ngpl0nX4sut3IWfVevy7/RI
   4kxQ1tnw5Ai7aB2e2veYvMjvteTSuSDhSk2/x1XO9OW+A2zx1TBh85zmt
   YfnkSLqufVccrXA9vaa68SiINnFGTtjrp6XcyLhQ2qF3L9kJZ4U/4V5rn
   n5P0ET8X3+leWisZ/DSnB6tB6k6rgWD0fgpMpkwRpKXg3pEQ1b3AHknfz
   AQWb+G68PHQbShTTDfJndOXYJw5Fp7WcQEQH+1RRRNoIn7WfK3t6fGSOb
   f8DHJTHtxDQOCPidN5oJBAA10zP6OqXGf+WYWaQcA7ImX72P+n11PWRXc
   w==;
X-CSE-ConnectionGUID: GPIxXdOZRk6Rn+U9RRCn6g==
X-CSE-MsgGUID: TUMQ2C7QQcS7YBllYRJsNg==
X-IronPort-AV: E=McAfee;i="6700,10204,11256"; a="42740108"
X-IronPort-AV: E=Sophos;i="6.12,156,1728975600"; 
   d="scan'208";a="42740108"
Received: from orviesa010.jf.intel.com ([10.64.159.150])
  by orvoesa105.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 15 Nov 2024 00:51:13 -0800
X-CSE-ConnectionGUID: rv2H58ohSCasVGpk02HMOA==
X-CSE-MsgGUID: N5EgkHoXRl+ApwX2nBDOqQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.12,156,1728975600"; 
   d="scan'208";a="88376905"
Received: from fmsmsx602.amr.corp.intel.com ([10.18.126.82])
  by orviesa010.jf.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 15 Nov 2024 00:51:13 -0800
Received: from fmsmsx602.amr.corp.intel.com (10.18.126.82) by
 fmsmsx602.amr.corp.intel.com (10.18.126.82) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39; Fri, 15 Nov 2024 00:51:11 -0800
Received: from fmsedg601.ED.cps.intel.com (10.1.192.135) by
 fmsmsx602.amr.corp.intel.com (10.18.126.82) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39 via Frontend Transport; Fri, 15 Nov 2024 00:51:11 -0800
Received: from NAM10-BN7-obe.outbound.protection.outlook.com (104.47.70.44) by
 edgegateway.intel.com (192.55.55.70) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.39; Fri, 15 Nov 2024 00:51:11 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=nI1KhY9Warok8b6R9I5v/27Y/zNT/ojRevIfxDeaG6SUyXbQ9rZLJ65BdbSWtaozs4cKIFt2LwNKJxzMzzU2BYw3DRvgqKxwpgvgiC0N11QbC0ZAP36/b96RK7xikcedcFTONGwMcJp9cVUA20d3gTpr9RaiqlA6vxDu1mCZshXsIrRfwn+cf56FCx73iwUQZ0AEPwaxX50N1nwdM0TM5MHDAhYfYj7dKc0MFer5D4Yr9dy7j1cXYbntR7/rt87ozabjtkAMYaj2B0X86vkG8i9vMFm4ZmeBidkxzpIQLUZuk3n1jbG1n5fyF3yQfs53v/0RaHT/DEsWU1ia0MCn0Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Y5I6stExWQHo2LPXjCDokOqszHj4VABsPdsjDuzTsYY=;
 b=f9EVPRamDy34FiXIr5EIPUX8NHYwZ1C3Jg0BTkp84r+E3fvsHu+0y/ph9S2Fim2hLCvw6yc8ja4hb6qZy08ng4gSBMRdC3Ghh8BQpwQIv9h0obcIYsboI+urhCDSdNIX7n0o42dbEtFJVO2SSo7uNfZmkyp6flx9TQdxpCJeFUujB2UwB7UTSpi7SwktG2ZkC6vdrNcX1yAxlo1MMhLYdeMirq3cjQ1gXjS6YdaQQkbxFHpXSvQA00Xzlbp4W8wvZdPHUpIHNtZLK93uH685N57XN6BHSY8sVzEP4Lq5y5sti3NpR3O22I15Spl7Bdi9B1fWRRWMpT6pSXTARP+LJQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from CH0PR11MB8086.namprd11.prod.outlook.com (2603:10b6:610:190::8)
 by BL3PR11MB6411.namprd11.prod.outlook.com (2603:10b6:208:3ba::5) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8158.17; Fri, 15 Nov
 2024 08:51:08 +0000
Received: from CH0PR11MB8086.namprd11.prod.outlook.com
 ([fe80::984b:141d:2923:8ae3]) by CH0PR11MB8086.namprd11.prod.outlook.com
 ([fe80::984b:141d:2923:8ae3%6]) with mapi id 15.20.8158.013; Fri, 15 Nov 2024
 08:51:08 +0000
Message-ID: <7c63c3db-072c-4f44-a487-f7e7de9f39e4@intel.com>
Date: Fri, 15 Nov 2024 09:51:01 +0100
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net v1] ice: do not reserve resources for RDMA when
 disabled
To: <jbrandeb@kernel.org>
CC: <jbrandeburg@cloudflare.com>, <netdev@vger.kernel.org>,
	<intel-wired-lan@lists.osuosl.org>, Dave Ertman <david.m.ertman@intel.com>,
	Tony Nguyen <anthony.l.nguyen@intel.com>, Andrew Lunn
	<andrew+netdev@lunn.ch>, "David S. Miller" <davem@davemloft.net>, "Eric
 Dumazet" <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>, Paolo Abeni
	<pabeni@redhat.com>, "Czapnik, Lukasz" <lukasz.czapnik@intel.com>, "Michal
 Swiatkowski" <michal.swiatkowski@linux.intel.com>, Pawel Chmielewski
	<pawel.chmielewski@intel.com>
References: <20241114000105.703740-1-jbrandeb@kernel.org>
From: Przemek Kitszel <przemyslaw.kitszel@intel.com>
Content-Language: en-US
In-Reply-To: <20241114000105.703740-1-jbrandeb@kernel.org>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: MI1P293CA0029.ITAP293.PROD.OUTLOOK.COM
 (2603:10a6:290:3::15) To CH0PR11MB8086.namprd11.prod.outlook.com
 (2603:10b6:610:190::8)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CH0PR11MB8086:EE_|BL3PR11MB6411:EE_
X-MS-Office365-Filtering-Correlation-Id: 5e09d4d4-4869-4d02-3f9c-08dd0552a594
X-LD-Processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|1800799024|376014|7416014;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?eGRJS0dIdWZhVi9DNlpwUlVsSzlBY1E5aW1uRDJPcG5qMndCdEYxWEN4MkMv?=
 =?utf-8?B?bTZiRzIrRGg0WHQ1dDlFSnVQTm5XblNTVU1ES253NjEzNDkyTTN5UDcyTGNB?=
 =?utf-8?B?dFN3OS9Gc3FQcURzVkhWR2Fpd1NFN2dpUmhxdGgvNmJvaE9MUyswblRRRGQv?=
 =?utf-8?B?MFEyUHkvV3UrOW96K24vMk5zbkpZc0NNN2RQSURDZk1VUWQ4UlN3dkUxUlpm?=
 =?utf-8?B?OHZrenZhdzh6Tk9QRDhFNk1PL0dlVndwMkxyYUlOWU9mQU50dHp0bzdJL3g0?=
 =?utf-8?B?Y2VuVnVhblZDZHg1c3UvNEpNK2pQRFQyUnUrSkVjckxCbkRKcU1pbVhiSi9P?=
 =?utf-8?B?Sk9EQlJ2bHVvdlgyWlRZR3lKK05WcnJCZVV5VFlFTFo5NWNkQmt0TlpER3ow?=
 =?utf-8?B?SG05bVg0M01BQ1FGaWpudzIxV0E4QzVNZzdPN1JDcnBHWit1N1BTdmF1dzBm?=
 =?utf-8?B?bEYwQW5wQ3NHbms3bGgweW5qbFgzVFI1WS9PUDVMYUdhRGpyQkxTanVZV2V2?=
 =?utf-8?B?engyRjA1d0ZzdUlVZHNjOVg0c2hCNjV1OGFDeTQ2V0FYQkhGS2JFV3dRUUg0?=
 =?utf-8?B?NXNpdVBhQ1FMZ2lLejFGTlgxbG8wNDFmVFYrWDJ2UmpjOG1sTWpTVVJINkFa?=
 =?utf-8?B?TnRsV0xGbDQ1VjB2ejJGeHp1cnJxLy9VU1FxR1l4Q1FhZGRDVitUczNqYjkw?=
 =?utf-8?B?QXcwZ1h1VHdXbGEwVmVuMXp4bTE3dFlXdzJPTEFWaHY2d01XZjVLTFROd2x4?=
 =?utf-8?B?bUV1OXBYWUhndmJnZjVadHk3N05mcXVvSVdIam94aSt4NjNrOUlyeGRVZU9p?=
 =?utf-8?B?Y1M0OE9GSHNKbmtmYUxuUHhmVWMycm02bXhnQUhIUzFWOENpRm5ZYm13dnJZ?=
 =?utf-8?B?bHJGdnpEdmY5UEJJdnhxQlg3aFE2R1lUMTFVVkJNM204dEthSXN2TXhIMHQ5?=
 =?utf-8?B?aExGMUJyMWpiRkxBNlFmbTByaHhFK2F1U0hxT0hLc3h0SEduT1YrWmV6L2xZ?=
 =?utf-8?B?am9POHVjRDg5bDhUVzBEaVhsNENpWVZkT0tBSGxuTFRvUmgwOWx0bmxOVXRH?=
 =?utf-8?B?Ym1uWUdwNWtLTXFGRTluU1hmNkNLQklPUENuNzBvcGFUTDJHVnFnT0FOekJV?=
 =?utf-8?B?Umd2cEJGZ0pXbjhzcGNSSWRJem9ZSTNYRFMxVER5UlQzY0xXdWV0MGszdnNW?=
 =?utf-8?B?YTVEczlOYVE4WWY5ZXFXV2dLODZUY1hTYWtxd05WNFUzMHBJMTJqOEg3bDFp?=
 =?utf-8?B?STVLc3JxMnJkdEVIVTdOaXZ3L1RNSXZtY0ZlamxJTVIzV0hOTDBZdnZMWUw4?=
 =?utf-8?B?WHpRbXlkZnh2Sk14YjRsdThOWGwyRXlyeE9lS1pSd0RRZ2pwZTJiOWd1TW0z?=
 =?utf-8?B?akhOYnUzTmlMbjg0TjJrZWVOSGlMeVljdVRwRnZOMEU3UEVyalhGWUk5OFRT?=
 =?utf-8?B?ZFh2b2piVnM1ckN3RzB3T1grR2RJT093OU9mRnNGbmNnWDgwY25zTDV5UjQ5?=
 =?utf-8?B?eDlYR1FzM1Qrdm1WbzdWVXdGQktIY2d6T3FLdXl6dDB0RERzSWFLR0ZPZkVU?=
 =?utf-8?B?NzEremp2SDNzY01XYkF2cjNLVHhvdEJNNkRURlg0ZzZwUEVsbGtnMFVzZVNx?=
 =?utf-8?B?eEprRW5hSEhZV1hvTm1NcnB0QzJvOWg0WWRVMWZYTEt0OTljTGZLb1lGR2Yy?=
 =?utf-8?B?SEZ5ZXJqNTk2U3ZKdGJERkV2VmphdGFjQTUxa1lVNWs5bEljQWtUN1NRPT0=?=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CH0PR11MB8086.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(376014)(7416014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?SUNHY2k0VTQveE9HYTJnYU9MZUF4YVkwN24vdHA2ei9VYzJkVGRuTGtReVAz?=
 =?utf-8?B?KzZpUWdQWGY3ZkJoMVM4QjVRRzN0ZHQxNUxTRFhEZVp0dHR2a2J3VGRET09q?=
 =?utf-8?B?Sk80UEtibEErL3BVbi8rMVU2c0k0ZlAwMXp4Y0ZIT1pDdmVFMUhLY0tmMXQy?=
 =?utf-8?B?TFo1RmF2SkduVCs2YTNyemhPb2VEUmVIaktONEdaWElQR3djR1Q5S2xKVmtz?=
 =?utf-8?B?bzFQbzdOU2hYelRRVmM5bmx6ZTVKdThQNldnL2JlT29HMS8zUUkwSnhaRDdK?=
 =?utf-8?B?Z1lMOTU3aVhxcWtjQTBEcHExM1BtL2RZb1dRR0d5MzIxQlh5NkM1Szk4SmtP?=
 =?utf-8?B?M2RMa0ZrR0xxVVcxOFN5dTlIZ1hORC9lbzJaMXExSzRYYjgzNGZtMHJybFhS?=
 =?utf-8?B?WG9rTElzYjZpc25DS29WRHpObitjRFZRQllWZndwNlhiK3AySW9STGNVSzZI?=
 =?utf-8?B?d1FYaGNvZUEydTVGMktrM2EzVE1qSnFUdU9tV3NJZXdBT3JZMmRTWnFxWllI?=
 =?utf-8?B?ckFEeWhnOU1YeU5tZWtwbm4wVVBZU1JPMUxIekc3bFAyY2VvVkRnTzYwVjAy?=
 =?utf-8?B?aU5Mb0JpS0JTRzdMTkQ1cElaTS9qQmdMaGpNa214cmxodW5sL2tsZXlybHd5?=
 =?utf-8?B?KzlxQUw5Rnl0YytEaDlQcWJsS01IZmRSZklwcUdaZGN1bFdCenJTTDU0MU9P?=
 =?utf-8?B?cE9sR083REgwOENNZnQwZG4ybng2NnFBV2ZZRnhwTkFOTXdzanFSTkQ4aG5Y?=
 =?utf-8?B?QUw2eitQSUY3UmU5S1BTTjZDUDBXVjZFNzZCNjJBNVUwSFdDRUdxVXpsR25n?=
 =?utf-8?B?ZkN6Si9LeVJ3VDFuclZoUmlxZFcwWTFWN0ljQnRzWTBOYkM4R1FrK2hZVi9P?=
 =?utf-8?B?V2dFTnRPN1BXaDFZMGg4U255UkQrd1YrcE8zOU1OdDhtc2Y2bUR5UFNKd0dC?=
 =?utf-8?B?dFVNWVpVWEZwcllDdFIrTCtWUlhUTnc5WXlZdS9USWlSams4QWZNSzFKTDdR?=
 =?utf-8?B?SnVidDYrYnJvb09jdkdiUGRjbDREZlVGUnRJcE0zRGdqWUpOZEoyZFVnUEpm?=
 =?utf-8?B?ckhQNjIwbDNzMUZPVTVGRlFlQTcvUTBqdXNMUHBEYVhBc1ZsNUtvV2dKb01Z?=
 =?utf-8?B?Z2hLTGhzS290OTVDSkxKRDZqYk1MeERBMlF0Y1hCaXl2VUZ1RUxjWnNFQVFM?=
 =?utf-8?B?OVUrOHMydUQrZkRlaGRwcHA1Q2c5Y3B2ZDExR2ZUN1FaWDFobE9VTmRmRnFh?=
 =?utf-8?B?OGVBL2F6YTJ5Yi92MmxLNzVsRWhXb0U2Q2RRbU9XS0prNGZ4elhGUXpaQUdV?=
 =?utf-8?B?aGpXNjlvdmZ6Uy9oVnFrbWEvWmpla0VzNmVmZk1Fd01Jc3BFd000NThGaWE5?=
 =?utf-8?B?emZDSjl2V1JZbC9Ja3V0WU5Cb3BLTERWV082WTJwVVdBV0hsS0k4TWpYVkJl?=
 =?utf-8?B?ekV0NVVRSEpScGZyK0JMWit4Ri8xM2UwN3VVdFh2WVhTNXRFTkNqSnp4dDJa?=
 =?utf-8?B?NTRmelpPbzI4bE4xNG9peWtrTDVzWGZwS0t5QzYyU3VrL3lIRjFJRkZaZU4v?=
 =?utf-8?B?ZlBiaEJ1dC9NaW1pY3krWG1QdHE0N2FSNWdFdlRKZzd1SkRTTEVTbHEwaXBY?=
 =?utf-8?B?MWFKc3dYbkw2Q2Q0MktQWDk4ekFucE9ySWVzSnZ0aVBrUnZzNGpZcE1BTGta?=
 =?utf-8?B?Uzk4SWkxMllzNzBpbUpvdTE2RXhwZEZDWTFjaWFEYUxmTFBKaXJIa0MvUk9H?=
 =?utf-8?B?TG9ldFFpS2pobmJNMFc1aTdzUFU5UCtBV0JaczlqQndOeVVTd2t3V3lRRmlX?=
 =?utf-8?B?NUJvbnNjK3RCdk1tTzJnYUd2VHowNnNTMEZRQmZUMldseG9TOUxxQVc0b3M5?=
 =?utf-8?B?OFIvMnIyVHRoN2RWa2VYWCtUMVJQZUE0ODlCTmdjVmthZGsyR0MzWHR3VFNn?=
 =?utf-8?B?bXdpZnF0dDlmU0xkUGkvcm9oSDVjdWxWSHpzaE5WRjJpRC9GVzVCdDNVYkZP?=
 =?utf-8?B?NTM1R1RLWktQZHB6NEt2M2Z4Wk1OVTRLUlIyVHFnUEV1dVdsTUxSMHdvRXZY?=
 =?utf-8?B?dHhQby9Keko1RFFNNWtyWlVyVmgxMHdKbXNwcDk2N21ObUg4cXZPYWNONWNl?=
 =?utf-8?B?ajM5ZC9HRVp2VTR4UW0ySGNsdmJFdzNwVmxxQ0VjbjdSNXpjbjVsWVh0Tk1I?=
 =?utf-8?B?aUE9PQ==?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 5e09d4d4-4869-4d02-3f9c-08dd0552a594
X-MS-Exchange-CrossTenant-AuthSource: CH0PR11MB8086.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 15 Nov 2024 08:51:08.2354
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: V94NeC4wMjdvXM8regPB993fjMMoYpLdPjrxScurZsd1FTz9rDrRSjkNOyKseAWN6tFBOp4fYp58aG53CFXE6mIkZz/NhBx6P1YjWIgHt1k=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BL3PR11MB6411
X-OriginatorOrg: intel.com

On 11/14/24 01:00, jbrandeb@kernel.org wrote:
> From: Jesse Brandeburg <jbrandeb@kernel.org>
> 
> If the CONFIG_INFINIBAND_IRDMA symbol is not enabled as a module or a
> built-in, then don't let the driver reserve resources for RDMA.
> 
> Do this by avoiding enabling the capability when scanning hardware
> capabilities.
> 
> Fixes: d25a0fc41c1f ("ice: Initialize RDMA support")
> CC: Dave Ertman <david.m.ertman@intel.com>
> Signed-off-by: Jesse Brandeburg <jbrandeb@kernel.org>
> ---

Hi Jesse, it's good to hear back from you :)

we are already working on resolving the issue of miss-allocating
too many resources (would be good to know what beyond MSI-x'es
you care about) for RDMA in the default (likely non-RDMA heavy) case. 
Here is a series from Michal that lets user to manage it a bit:
https://lore.kernel.org/netdev/20241114122009.97416-3-michal.swiatkowski@linux.intel.com/T/

and we want to post another one later that changes defaults from the
current "grab a lot when there are many CPUs" policy to more resonable

