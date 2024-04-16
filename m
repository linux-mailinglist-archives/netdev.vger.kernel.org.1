Return-Path: <netdev+bounces-88354-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E47FB8A6D4A
	for <lists+netdev@lfdr.de>; Tue, 16 Apr 2024 16:06:05 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 9C2B1287ABE
	for <lists+netdev@lfdr.de>; Tue, 16 Apr 2024 14:06:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1AB5E12CD99;
	Tue, 16 Apr 2024 14:05:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="Mv+UtPHN"
X-Original-To: netdev@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1E2C112D20E
	for <netdev@vger.kernel.org>; Tue, 16 Apr 2024 14:05:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=192.198.163.18
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713276354; cv=fail; b=dSY00XwoBMfTZs6alNDimIXfGsc7cOc2FLGfBdPSFIFB0Yv2TGQ4Qpc5/i3MGyriiw2xy1xOFe4OZNgvvfHD8SY0Bo5XjSE1v4hvKhMzOyoWvFB9SwgO+7T2X0gVJnd2KXD6OAHFNSKLvI0vYkzA+VgrC4+9odabiD+T0rqD6iA=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713276354; c=relaxed/simple;
	bh=URq3Jaxz7jcdiCs+p+Wpt2dPO5rjhPvE+2sU13aqzls=;
	h=Message-ID:Date:Subject:To:CC:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=TeEiFSwwrWmLkR9lXcVXBD7gYHwzlJzoo23vn6tfBNMFlwpATuDm6/wuvh3EXQEhbeDvBp4J7QTEfwb6HisEyhQv+VtMXq0820mOKrRRL7T0CbynXcJIg7f06qJs6FCiwnDsUTcUrzGoTEbEyPUnxDiidnxiqnCLuQcwdQynfZw=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=Mv+UtPHN; arc=fail smtp.client-ip=192.198.163.18
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1713276352; x=1744812352;
  h=message-id:date:subject:to:cc:references:from:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=URq3Jaxz7jcdiCs+p+Wpt2dPO5rjhPvE+2sU13aqzls=;
  b=Mv+UtPHNSR887C75FfwdQ5dnN0nUjJVemyy9Wnrjzy0EG4Dgh/cTEogd
   zv3Di3AzeR229S+McGPYbBwr8cua/WOuy1O994KjijdMGXDJqRPpPgcEr
   1ttCMLhBc9HTcZdrtq7bKR7/UPqZ/9mMSP+BsTUjPyNkZCvfuOSMHr3Ok
   gDkMR6mByDqx9HG8kE2P+W1Usc+8cUEi0I9jwxuIvBl1XfPydQCvnVXFL
   sDDNLdVifxxVvmD2FavBHbwk7WC2UUZYKzeGvRFRap0T+CEibBKp0Zkld
   74Pi8pR6fsdZIxUFjj7pC/wern19PtgQ0vEQ09EBFVzfKl4f396fRzWBr
   A==;
X-CSE-ConnectionGUID: ZlN6k/W2TQWJRxNkjDuZqA==
X-CSE-MsgGUID: rAvwqN7IS/ui32uKGBWuFw==
X-IronPort-AV: E=McAfee;i="6600,9927,11046"; a="8578959"
X-IronPort-AV: E=Sophos;i="6.07,206,1708416000"; 
   d="scan'208";a="8578959"
Received: from orviesa002.jf.intel.com ([10.64.159.142])
  by fmvoesa112.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 16 Apr 2024 07:05:51 -0700
X-CSE-ConnectionGUID: v4qOZQ13SPCD5bFzKJrdug==
X-CSE-MsgGUID: ECklBIbkSy2vbo/kuy4iZA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.07,206,1708416000"; 
   d="scan'208";a="53251565"
Received: from orsmsx603.amr.corp.intel.com ([10.22.229.16])
  by orviesa002.jf.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 16 Apr 2024 07:05:51 -0700
Received: from orsmsx612.amr.corp.intel.com (10.22.229.25) by
 ORSMSX603.amr.corp.intel.com (10.22.229.16) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35; Tue, 16 Apr 2024 07:05:50 -0700
Received: from orsmsx611.amr.corp.intel.com (10.22.229.24) by
 ORSMSX612.amr.corp.intel.com (10.22.229.25) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35; Tue, 16 Apr 2024 07:05:49 -0700
Received: from ORSEDG601.ED.cps.intel.com (10.7.248.6) by
 orsmsx611.amr.corp.intel.com (10.22.229.24) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35 via Frontend Transport; Tue, 16 Apr 2024 07:05:49 -0700
Received: from NAM11-CO1-obe.outbound.protection.outlook.com (104.47.56.169)
 by edgegateway.intel.com (134.134.137.102) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.35; Tue, 16 Apr 2024 07:05:49 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Il0tpoUvX8SB17W67ewAgn8YZCgY15hyiE8wrGCe8yq77AzlvifeC5PKg2nIokEFFOvyCWVM6Vt/wuzJKonyc5S7LMkY1Y2cyhTNVAe8i4LMjBB276+o0DxbSsl8lZlhODLrY7xIZgtqBe69UdvS5cgA7fIelaFVM2rbW75iH/y1V79atIpIoxZuHjHLuuoMPfyhInNgO/TrCZ/IPrr8K4XwvD+eLoc0Kk4pKaNvy+wUpK0FySAo4t8Z114ZTnmaQEgs2xE1OA/9grnI0bQy1dSBoJEVWpOcAnzyozB2zUVN3CtcCssOt2KqLLktp7ln/rGjhC9OtXWmfxmmRjw2lA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=E65dxOEJJ45n7k/TalOAyczt4GOU0JZCpW73wL8+f2A=;
 b=A9YL6fDa3zUJhApYJ358wlXIlqqG3SH5Y3XwscKob2M2qfPNhzFvvqFJbCPMQYDxysxhSGuf9juTr21e6aK8rdVcrPc69GEa9I0u701egbQfSVvZEIa1pTKtiYk8IJr8jg2vIfEdskw53wKdrcI1A7iJCZRLkCIOHKH40M59wzAtkoqzINEapNT79ZmMyt5CHAMRVm4dv1ey75RnL+7vOd7ST6V+PhQLTM3egsoTG08SYOX98MDAS1EEEQ2daroyrMTPfA/yUxYIolWoVeRv4AfHnUBIxXVAdrH+0ktwsxvIphTY4Mk7eaMu2To7yTqaXXVbVGRJXC73fRx3BG3mwg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from DS0PR11MB8718.namprd11.prod.outlook.com (2603:10b6:8:1b9::20)
 by DM4PR11MB6504.namprd11.prod.outlook.com (2603:10b6:8:8d::5) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.7472.31; Tue, 16 Apr 2024 14:05:46 +0000
Received: from DS0PR11MB8718.namprd11.prod.outlook.com
 ([fe80::654c:d66a:ec8e:45e9]) by DS0PR11MB8718.namprd11.prod.outlook.com
 ([fe80::654c:d66a:ec8e:45e9%6]) with mapi id 15.20.7472.027; Tue, 16 Apr 2024
 14:05:46 +0000
Message-ID: <008a9e73-16a4-4d45-9559-0df7a08e9855@intel.com>
Date: Tue, 16 Apr 2024 16:05:41 +0200
User-Agent: Mozilla Thunderbird
Subject: Re: [net-next PATCH 13/15] eth: fbnic: add basic Rx handling
To: Alexander Duyck <alexander.duyck@gmail.com>
CC: Jakub Kicinski <kuba@kernel.org>, Yunsheng Lin <linyunsheng@huawei.com>,
	<netdev@vger.kernel.org>, Alexander Duyck <alexanderduyck@fb.com>,
	<davem@davemloft.net>, <pabeni@redhat.com>
References: <171217454226.1598374.8971335637623132496.stgit@ahduyck-xeon-server.home.arpa>
 <171217496013.1598374.10126180029382922588.stgit@ahduyck-xeon-server.home.arpa>
 <41a39896-480b-f08d-ba67-17e129e39c0f@huawei.com>
 <CAKgT0Uf6MdYX_1OuAFAXadh86zDX_w1a_cwpoPGMxpmC4hGyEA@mail.gmail.com>
 <53b80db6-f2bc-d824-ea42-4b2ac64625f2@huawei.com>
 <CAKgT0UeQS5q=Y2j3mmu9AhWyUMbey-iFL+sKES1UrBtoAXMdzw@mail.gmail.com>
 <0e5e3196-ca2f-b905-a6ba-7721e8586ed7@huawei.com>
 <CAKgT0UeRWsJ+NiniSKa7Z3Law=QrYZp3giLAigJf7EvuAbjkRA@mail.gmail.com>
 <bf070035-ba9c-d028-1b11-72af8651f979@huawei.com>
 <CAKgT0UccovDVS8-TPXxgGbrTAqpeVHRQuCwf7f2qkfcPaPOA-A@mail.gmail.com>
 <20240415101101.3dd207c4@kernel.org>
 <CAKgT0UcGN3-6R4pt8BQv2hD04oYk48GfFs1O_UGChvrrFT5eCw@mail.gmail.com>
From: Alexander Lobakin <aleksander.lobakin@intel.com>
Content-Language: en-US
In-Reply-To: <CAKgT0UcGN3-6R4pt8BQv2hD04oYk48GfFs1O_UGChvrrFT5eCw@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: MI0P293CA0010.ITAP293.PROD.OUTLOOK.COM
 (2603:10a6:290:44::12) To DS0PR11MB8718.namprd11.prod.outlook.com
 (2603:10b6:8:1b9::20)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS0PR11MB8718:EE_|DM4PR11MB6504:EE_
X-MS-Office365-Filtering-Correlation-Id: f5e14eab-e7fb-47c6-337b-08dc5e1e4fe2
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: defNgkRL8PMp443OX4Aqpiex8R9ERdW1ZXIBr4u2wIQoDPdvTK98Jx8yO3T8UpJP9eNZEpI2hgfBwbJh3/k0UWqmXwmGvGRzGVJNliiySDvk4t7xxhIjVFKVBImOBuUcqL64pHNuXI1P/1IgCViSW9qBP3EBF4C1V9QxUT2OJaMFk9Kwb0TE9PH3MUCwYqtTh0P6olNvB/TFyu/GfFfWCqUhIaVkT6ZOpR3xg17YdXR77hliK6Mzi4h/2PpnBClBm9qfbsfZz2vxJaO+gVboDcP4yPOhjcXHCWrifRNb36VELy00C+K+O0FNW6++3VVbKgvHawQzAaDXvwuBm93tov6VgxIHSNsUVoWFjepzdVW4sU3G/lQC1PK3jI8usrRq6ON8gMF5hf0UEQHyEQY66GLgktGMHZt/ElI5WIfRwv+IalL+NGqpUWhVz1QazQtHXvOTL4HoG0E4J58zEn+Xav8IOHqht1Asbknr6xoeVvNSn5NuSGB1rOiGVU2S+rZ/YL5DAUUFZAniO3MagjANVNAUeGTxBoA6M90O1YXRapf0op3ssMfk2eqWc+Vawc+FoTv8NX2P4XBYvSzS3nAks1vLpKowZuPlT4MohbEbFpQqidyFtapi72eQMckakcFVm7YdWNgpJGV6qEOJtxXKVgVvO+spDokvInnIX1hkRSg=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DS0PR11MB8718.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(376005)(366007)(1800799015);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?N0x5Z2hmbFpMY0pkQlR3cGIxMVhhT3ErUFBXSlBhVktNT0d3dXB6RXFkbnlL?=
 =?utf-8?B?bmFNS0E0YXBHUGtSV0tURjJRNWM3QjVRVU1zYlR1YWNyTVJjU01EbW1xSEZh?=
 =?utf-8?B?UVBzL0kzS0Vzc3craE5kbXdsbk54WGpxZExLYVg2N0NpMndjR0lnbVp6dm1i?=
 =?utf-8?B?bmJrdDJDdjlvajNNbmN3Y3dXRDl6L3NlRjdIemo2QlRPUjc5dWVSYVpnNzJL?=
 =?utf-8?B?VU1Pcjc4SE5CSndyalcvVWFsWkN1ZFpHTTJZbklJUFplR1g0R1QzZ0lrOGVF?=
 =?utf-8?B?QmVQSUs4T2QvdEtPOEFoYllGTkFwbUNxeFVndEZ3MXhYVWt1WklLUDZIQkhS?=
 =?utf-8?B?TXYxRWp3REg4OUJyRVJLSUZ2aWdlUXc2RVllYWVSaTVKdHY4SG5ZRHE3U01H?=
 =?utf-8?B?NzBuZXpoSHh6Nlh3WHNwajJiTUkwOWpmRWh1MkQ3WGZFOGJaTldDd1hCSCs2?=
 =?utf-8?B?SkR6ODlQallkOGJ1elN4MjVXKzVNN282Y3VocXZjRElhUmw2M3E4ZFdORGJV?=
 =?utf-8?B?Nko1dFFnWWx3V3gyenJ1QW9ja2Uvb0ZnMndLUFdLMC8yOW1VbEU3SUc5blor?=
 =?utf-8?B?dFhxSk04ZjZnVG9kaitBUFJKNlNsaXBTUUN1RWJXN0pnclk3ZTNENEZXLzZU?=
 =?utf-8?B?Rko2T1JOODgvaFZXYkkxY0Vtd2ZncnYzQitBYUVJNWtTWEt1bGlPcHE5SWFk?=
 =?utf-8?B?TWRZbG94dDZMdmZycEk5OHlTbFFKeHZsa25GK3cvcG5rekc4Mit4dmowaDZL?=
 =?utf-8?B?T0pEU2I1bVV2bFF4cWNjUk95bU5JZDV4V1JvRVppeUdHQ1FtVUxlSDhxWTI5?=
 =?utf-8?B?MGZwTHBJck5LbG9XcmRpUnRGU0xWSXc1TS9zVnI3SXpRMjRrb2g3N1NpTE02?=
 =?utf-8?B?alNHKzdzZG9BM0tDeWhUb0xLQzdqRCtEY3RjNjk2UFB6TDlycHlld2c3UlZy?=
 =?utf-8?B?M3lnbGRQeE1VVVd4QzFpVWJPdE5ic0pYN3QzNXV0S2I0a2x4SHB0eS9qK3hQ?=
 =?utf-8?B?NkkzSnJJZEk3MWUwUXZXQU5Pc3IxRW1VcHJtdmxwOHdUY1ZrRXEwRlI1UG1D?=
 =?utf-8?B?d3VjVzhBaVJSNG43bExLajFhVUN4dzEwN21xU0c5WjlROFpzQk9qTWxvc2Zl?=
 =?utf-8?B?R2lHb090QnYydDdOZitKdG9tcDNqSi93OXdaSUNUSWdKZU5tclFrcUZaa2hF?=
 =?utf-8?B?TzNRQUlmMyt2bFZORTAwOEhPdGRFcXJBNVB1eFhBbDVRN2R1dUJNMDJNWWZJ?=
 =?utf-8?B?VlJOWTZLaUFQRGhVNzJPR3pJUWpjVWpKd0JibzhLSk5MeE9hN1RKRkFySE5v?=
 =?utf-8?B?MGl6Q2lpNkNOMzZzZXRwTUtXL3VFUFFrQlR1SDBuZmdpU25UKzBZYmgvLytr?=
 =?utf-8?B?aXdQcFlycTJZeXNRQndTOXZmTXBIOTNZdWdvU1hnTlJwOUVpWEFTLy9FQjVR?=
 =?utf-8?B?cDBtK294VlNQdlJIUEQ5V0MvNkI4UVdqeDMvOGJBTTBMRlRrK1hDMEVac2ZP?=
 =?utf-8?B?Zlp2Um5lcUdGNFVuYWVyd3ZRSWRjVS83eGJ1MzFFYStJYjk3SXJCeW5EUDJq?=
 =?utf-8?B?QWdGSkR3VGVNbEVDWWZZaEl0M1dGcWpPeG1ObnJXaDI5NmdCWHVnVENvL2Ru?=
 =?utf-8?B?VW9jdUMveHlqVGNneEZhbFQxSDFLMG1wYTdmYm84enFCMGlqalJaYkdTZUdZ?=
 =?utf-8?B?eGxtVjN1clptbUh5U3lOc0hDODR1Sy9iUEF4TkZDVHdiK3BMTVVCWEFLV2hH?=
 =?utf-8?B?MmxxSkY2ZjF3MWNTVE1CWDhNTzNpZHlBZ0JPWVFiNmk4dnVaSExxYkVEZ1RD?=
 =?utf-8?B?Rm40eVhlU2NVWXJLTHFZZVVST3hBYVdORHFlZ08xakhZUlh2ZDFDRStZSkNk?=
 =?utf-8?B?eFZuLzVvUTJlUXd5YmVPZlhGc000aXJHQTduYTdidFhmWXdlY1E1SmJKNmVq?=
 =?utf-8?B?RUdNRTNjbElTZ3RHbjl1RnIreVkxNkU0MnVjVmtVNzZObHI3UlNBNGFuSFRw?=
 =?utf-8?B?NmwwakcrSTJJN1JuNlVWNnA1NHJFSVNYQXpSYTh2ekFob3BBaUtUUTdtT09v?=
 =?utf-8?B?QXV4Qy9BSEJHa2FUZ0RrbXNRN3RQWE5tMmRhVWZ5QW4waFEwS0ljL1lzUjR3?=
 =?utf-8?B?S0RibUpFQ1lJbDFrWkZJNXlGWjdUL0E5M1hqazJ6cFlEeXhUd3h4RGRIZmVY?=
 =?utf-8?B?SUE9PQ==?=
X-MS-Exchange-CrossTenant-Network-Message-Id: f5e14eab-e7fb-47c6-337b-08dc5e1e4fe2
X-MS-Exchange-CrossTenant-AuthSource: DS0PR11MB8718.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 16 Apr 2024 14:05:46.5208
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: dgk8PXj8A9bDQdz8fu5KAj7q1c7ZhnvMBd1HRfC6YmLiWVaWU9yidY158VXHjfc3vejRqI6AtQ3k+HHe2RhjFxE7LlWm0CEG7eqwocjAfx0=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM4PR11MB6504
X-OriginatorOrg: intel.com

From: Alexander Duyck <alexander.duyck@gmail.com>
Date: Mon, 15 Apr 2024 11:03:13 -0700

> On Mon, Apr 15, 2024 at 10:11 AM Jakub Kicinski <kuba@kernel.org> wrote:
>>
>> On Mon, 15 Apr 2024 08:03:38 -0700 Alexander Duyck wrote:
>>>>> The advantage of being a purpose built driver is that we aren't
>>>>> running on any architectures where the PAGE_SIZE > 4K. If it came to
>>>>
>>>> I am not sure if 'being a purpose built driver' argument is strong enough
>>>> here, at least the Kconfig does not seems to be suggesting it is a purpose
>>>> built driver, perhaps add a 'depend on' to suggest that?
>>>
>>> I'm not sure if you have been following the other threads. One of the
>>> general thoughts of pushback against this driver was that Meta is
>>> currently the only company that will have possession of this NIC. As
>>> such Meta will be deciding what systems it goes into and as a result
>>> of that we aren't likely to be running it on systems with 64K pages.
>>
>> Didn't take long for this argument to float to the surface..
> 
> This wasn't my full argument. You truncated the part where I
> specifically called out that it is hard to justify us pushing a
> proprietary API that is only used by our driver.
> 
>> We tried to write some rules with Paolo but haven't published them, yet.
>> Here is one that may be relevant:
>>
>>   3. External contributions
>>   -------------------------
>>
>>   Owners of drivers for private devices must not exhibit a stronger
>>   sense of ownership or push back on accepting code changes from
>>   members of the community. 3rd party contributions should be evaluated
>>   and eventually accepted, or challenged only on technical arguments
>>   based on the code itself. In particular, the argument that the owner
>>   is the only user and therefore knows best should not be used.
>>
>> Not exactly a contribution, but we predicted the "we know best"
>> tone of the argument :(
> 
> The "we know best" is more of an "I know best" as someone who has
> worked with page pool and the page fragment API since well before it
> existed. My push back is based on the fact that we don't want to

I still strongly believe Jesper-style arguments like "I've been working
with this for aeons", "I invented the Internet", "I was born 3 decades
before this API was introduced" are not valid arguments.

> allocate fragments, we want to allocate pages and fragment them
> ourselves after the fact. As such it doesn't make much sense to add an
> API that will have us trying to use the page fragment API which holds
> onto the page when the expectation is that we will take the whole
> thing and just fragment it ourselves.

[...]

Re "this HW works only on x86, why bother" -- I still believe there
shouldn't be any hardcodes in any driver based on the fact that the HW
is deployed only on particular systems. Page sizes, Endianness,
32/64-bit... It's not difficult to make a driver look like it's
universal and could work anywhere, really.

Thanks,
Olek

