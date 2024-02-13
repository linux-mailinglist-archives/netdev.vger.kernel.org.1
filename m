Return-Path: <netdev+bounces-71541-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D8C48853E77
	for <lists+netdev@lfdr.de>; Tue, 13 Feb 2024 23:18:26 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id A37FBB2A374
	for <lists+netdev@lfdr.de>; Tue, 13 Feb 2024 22:07:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5EFAA633F8;
	Tue, 13 Feb 2024 22:04:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="es9WkU2s"
X-Original-To: netdev@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.10])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5B342633F1
	for <netdev@vger.kernel.org>; Tue, 13 Feb 2024 22:04:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=192.198.163.10
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707861849; cv=fail; b=uM6S+WTZB3bve6b6cXFObGiljbsrMRVjf+p4pHHshX7mMKjsQQ7FqjhXbO1jVlt2Jauk564SxV0x+wvibEycdnrw8whXlGJfofsc1v1PrznTnb8Rd3H0HS2+zRa/w3fqm8sliSrzLzO2GYK4IGmxWo9DJ/S5DPEkhaHYJF6JdfM=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707861849; c=relaxed/simple;
	bh=O1GbYvuCG4/72K+KhtYYV6tBY6yuKarBY9LxUFXFuk8=;
	h=Message-ID:Date:Subject:To:CC:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=KxX5ATcWh+Vk/ThSB8QPK27YGbl7N1m3HG8hTtTx5/ZHetTY32k1zgaVLRD0d8Gw5+tmpLIPIBbGom+HALKzH1Btv1e1kRIPCw44/RpGI1hgXbkBGhCvoVqfcsUjc9WSOaOm+lSmWsljSZybA/ImDYS6SGm/Uy+Hd1O4t0SRyIY=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=es9WkU2s; arc=fail smtp.client-ip=192.198.163.10
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1707861848; x=1739397848;
  h=message-id:date:subject:to:cc:references:from:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=O1GbYvuCG4/72K+KhtYYV6tBY6yuKarBY9LxUFXFuk8=;
  b=es9WkU2swyBVwC38RYT3p6IJ2735HZScsEo2HuqIjLbXkypV1VZAQ6jQ
   SQ3GMSnnZ5Mxlx11iMWNLff9BaLLb4/b0WuGfPfg4tVduJybZTQExTqIJ
   BbKkALxrnxjv8LyI0fv0CIc0koHbYWbRYjthWDEbnh+kXKMEyKgQJktGG
   ebQweiDdygw/ZlkkIFeyBCWMCZtyOPsoUuTeazczD9Npm+wBqgZ5DegU7
   gIO5myIrvr/40BTCtzOPtIYBaPbWRbcdtau9GK8yRECgi1UlHatzF0lz4
   Q4+S3+msEnYzut6gVz2fPBkASJ5X3OWvEqxeJ5ycidrI1nnsqSSdfvpUM
   Q==;
X-IronPort-AV: E=McAfee;i="6600,9927,10982"; a="13278352"
X-IronPort-AV: E=Sophos;i="6.06,158,1705392000"; 
   d="scan'208";a="13278352"
Received: from orsmga001.jf.intel.com ([10.7.209.18])
  by fmvoesa104.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 13 Feb 2024 14:04:07 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10982"; a="826226767"
X-IronPort-AV: E=Sophos;i="6.06,158,1705392000"; 
   d="scan'208";a="826226767"
Received: from fmsmsx603.amr.corp.intel.com ([10.18.126.83])
  by orsmga001.jf.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 13 Feb 2024 14:04:05 -0800
Received: from fmsmsx612.amr.corp.intel.com (10.18.126.92) by
 fmsmsx603.amr.corp.intel.com (10.18.126.83) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35; Tue, 13 Feb 2024 14:04:05 -0800
Received: from fmsmsx603.amr.corp.intel.com (10.18.126.83) by
 fmsmsx612.amr.corp.intel.com (10.18.126.92) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35; Tue, 13 Feb 2024 14:04:05 -0800
Received: from fmsedg602.ED.cps.intel.com (10.1.192.136) by
 fmsmsx603.amr.corp.intel.com (10.18.126.83) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35 via Frontend Transport; Tue, 13 Feb 2024 14:04:05 -0800
Received: from NAM12-MW2-obe.outbound.protection.outlook.com (104.47.66.41) by
 edgegateway.intel.com (192.55.55.71) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.35; Tue, 13 Feb 2024 14:04:05 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=XRPHvGWHmC/oXbLGuKtVvoSPZRp5jsGPhaQzoyCusw1vyph5fARUx/VTEWI70iV32kgk1E0OR7Nucpr4H61Qz3jv5D5Hpme+WTcGuW6A9+Cv6M0/0PcxAcfRKK2Q8ylbCTOvFI4eIXgyepnuLJHo2ApTYkgwijMGm5UYdo00LlLb70KffG6DcqfSz1uH/ZkmtCxTdPmS/SzBsowkoLzxXkD3c4RjtIB0KKepQYQZsRDRpWW3GXr5kC42PLa5G1ljK2HQqsfI/jKbmWtDtzPswoNR5LmpIVbZ/n7iLm0nsxyH3D2cFj7G+hu5StF13N/ShTEX+kpA5VL2sW+7ciLdLQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=FJZLsykniWWZfrpLmJPd5M6OLo46/sdjXb8DrRYPtbo=;
 b=k9GRPjN8OtbVJZODDYby6JiFGLHnjTK5OnvSnua3IU2Pwkd0ozMOY8iUtu01atwpffbux2RawHNjT9PzUBPP4F6VTJu3SJA0wyX67y72ONa8zOjsYrElEnhuP8Ak9qB0Z010nMCQH/uPPv4npLvqtosmavaowTkO8zuTdRiTvWjmPWML472n9QnShqnuhkunhcIn2dkGtE0i7QB0GCZlttSGbQ+hji4BN/laMP0fRI73w9RfGr/JYmBYBQiipTjcD6lojHzlZlyQA7k2+gqWQP177Yhl1wYG2zsys9HKH1OK8SLsz4FasXefEbq0AWc9t/hkGQKUmMuqdQXn0lcImA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from CO1PR11MB5089.namprd11.prod.outlook.com (2603:10b6:303:9b::16)
 by MN2PR11MB4568.namprd11.prod.outlook.com (2603:10b6:208:266::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7292.25; Tue, 13 Feb
 2024 22:04:03 +0000
Received: from CO1PR11MB5089.namprd11.prod.outlook.com
 ([fe80::4069:eb50:16b6:a80d]) by CO1PR11MB5089.namprd11.prod.outlook.com
 ([fe80::4069:eb50:16b6:a80d%4]) with mapi id 15.20.7270.033; Tue, 13 Feb 2024
 22:04:03 +0000
Message-ID: <6b62fe60-b1e2-49e0-b374-775ef42d07dd@intel.com>
Date: Tue, 13 Feb 2024 14:04:00 -0800
User-Agent: Mozilla Thunderbird
Subject: Re: [iwl-next v1 07/15] ice: add auxiliary device sfnum attribute
Content-Language: en-US
To: Michal Swiatkowski <michal.swiatkowski@linux.intel.com>, Jiri Pirko
	<jiri@resnulli.us>
CC: <intel-wired-lan@lists.osuosl.org>, <netdev@vger.kernel.org>,
	<michal.kubiak@intel.com>, <maciej.fijalkowski@intel.com>,
	<sridhar.samudrala@intel.com>, <przemyslaw.kitszel@intel.com>,
	<wojciech.drewek@intel.com>, <pio.raczynski@gmail.com>, Piotr Raczynski
	<piotr.raczynski@intel.com>
References: <20240213072724.77275-1-michal.swiatkowski@linux.intel.com>
 <20240213072724.77275-8-michal.swiatkowski@linux.intel.com>
 <ZcsvYt4-f_MHT3QC@nanopsycho> <Zcs8LsRrbOfUdIL7@mev-dev>
 <ZctSpPamhrlF4ILg@nanopsycho> <ZctYm9CVJzV+uxip@mev-dev>
From: Jacob Keller <jacob.e.keller@intel.com>
In-Reply-To: <ZctYm9CVJzV+uxip@mev-dev>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: MW4PR03CA0006.namprd03.prod.outlook.com
 (2603:10b6:303:8f::11) To CO1PR11MB5089.namprd11.prod.outlook.com
 (2603:10b6:303:9b::16)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CO1PR11MB5089:EE_|MN2PR11MB4568:EE_
X-MS-Office365-Filtering-Correlation-Id: 700f4406-529f-4bb6-57ba-08dc2cdfb049
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: l8EQQ8NuxmD/AsspKcvN8BMk8bblXG54OqJ+GsSfT+SEd8NzGHeNkln/T/cdZfBdDwmqxut7h0/I0JSlJMWp98GAx7po0z+P7Cv6dsPLSYffgWd7yRZatRGWyrniNn1Whhyi0EQi5boyweVZhUA7mxidehfq66FJXjFLbCmfILe7rJDmOmrQg5UGxoZtePB/YekJsIGKTWa0ywcdle/tEqL23A/e3bj9lJgYyUuvHaSJBa/QTOitDFQ6uKK+++2Gub+mEgbDAsEz+ucE5ZO56bD/u+xnRVlRA9wfFUixCzuHjOIru8Wjwq3nco9aiTQ/aUAvQjT6mBn0byZ5+0nHs5tBexxHrDBID5enox/jHYJDl/gPoqNVFmSmZz3dt67i+vtmMTr7qCHwXbau/iw5Em+dp7+PCdY0gFQWBlUSagkqVFmVKCkxyKJwPJqD4cUPwkg4BgMkQ6zZ/qgMwPC/Z1g5y79po88pM0roOERz6sE9Y8Dbvrx3Y5EwktM81nwCrxaFM/jN4XfWm4WRS7WnFYhBQHA3qqQ5Lvl4gmhYbz2ZgOKiUhACe6kiRdFEo1Fs
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CO1PR11MB5089.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(366004)(396003)(346002)(136003)(376002)(39860400002)(230922051799003)(1800799012)(186009)(451199024)(64100799003)(8676002)(2616005)(41300700001)(83380400001)(66946007)(6512007)(66556008)(8936002)(66476007)(6486002)(53546011)(6506007)(4326008)(478600001)(316002)(110136005)(36756003)(38100700002)(31696002)(82960400001)(86362001)(26005)(2906002)(31686004)(5660300002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?S3hVVDRQN0hOQ1hqL1dGUXJxSzArT0hqalVhWmx0SnVrR2pVd0lndWx5U1Jt?=
 =?utf-8?B?MU1vMmw1OThZak5vaXdrenc5aGg1YU5oTTliZlR2UnFjcGdJVDVUOTlRUGdj?=
 =?utf-8?B?NFlaKzd3MXFXRkRiM3FxaFZRRVB4RzFjbE42TVk0UWIycnZmVUtKOWhudVdw?=
 =?utf-8?B?RVJUbXJqSlJLaHVvbFBJTHVDQ2NaUWU1WmZCUURXY1d2YldYdy9oYTFMa29p?=
 =?utf-8?B?NFFsNVZWOElhS1hBalN2NUJOMkNoNVZFTHg0WVI2bTBSUllXUXhXZEdna0Jt?=
 =?utf-8?B?emRSRDhwSVk0Q2ZrSGFrOCt0Z1ZFbVY5b2ZzYndqOTBnWEtINnNBWXhYU29P?=
 =?utf-8?B?dGNDc0lQNFZWVXpCZlZJTkU3RTAwOTJEUkdRbE1qb1F5NGlhWkpBck0rYWdE?=
 =?utf-8?B?OG5IaDMyd0tsRXVpVytLMmNsUDBTdm1zazVLS3ZRL01RQ05sT3hhV004US9y?=
 =?utf-8?B?d29RRmwwNVBjRzJ4eEhQZ2RjNWd1MlYxVUZHUnZkTDJGODRxSVkyWG45cUJk?=
 =?utf-8?B?WldCNHpSK0hPM016Tm50ZE5KN3JvZEhlVktFemw4NlEvUjF5R1RTaDdjRFh2?=
 =?utf-8?B?QUYrWGFCMW45UFlvZW5RQ1VObzhQN0ljNDJvT25uY2gvdkJWNWtpRGt5M0Vk?=
 =?utf-8?B?VVBJUGZsQ1MwUUZ3N2cvYzNaZUxqc0E1L0ROUkhsRzU3Rk9JUTRTQ3ZDdCtS?=
 =?utf-8?B?L3VxUVFJWVFQSHZ4MVJwM0ZHdWliS3FLVGt2Wkw1RmtWZSs5TVN0SExlY3dJ?=
 =?utf-8?B?QUV1aVMycDh3S2loRGo1SnhTbEhoSmtKNTB1Y29LS3pISnJHNlhGVHo5ZFR1?=
 =?utf-8?B?a3doY01CWWVmN28yKzdPRzFySG1XdG5mWUhTUlZtNjBhMjZKU05EQTE3Wmsz?=
 =?utf-8?B?WCtiWDNaRHdpOWJ5WmN4TDJFZDVBNUJrZ245QXZPWU9pVGs2aVlBN0F6ZGNs?=
 =?utf-8?B?NXpSZC9NUmpVVDlRRG1rTEVkWEVlMVBxM3MwY1RkWGRBRktldHRjWGpJeGZx?=
 =?utf-8?B?ckE5U3VZVVI1bnI2ait0T2t6MSsrVzlhbHhwK3JKcVUwRU9FNHpndW4yelJ3?=
 =?utf-8?B?SnZZcERJK0Y5VlVoalFZd09qblphK2Z2V3g1OVdnZnJUS1JocE5Qa1FQeXpR?=
 =?utf-8?B?OVRKSVh4enl0SjNSamNxZUp5OXhrMHJtM2M1WjhLcm43RzBEaEYzTEUxT2po?=
 =?utf-8?B?V0MwQk1KWktQTVVxWmk4UWtoQnl0SFI3aU5uRUt4ZXFQeURyb1MyaThGMUVE?=
 =?utf-8?B?ajJGS0l2TjBoWDZCMnRyRWRQcXpHQ2Q3U09BQ0NOSUF4SldmN0JZMjhaQkFQ?=
 =?utf-8?B?dHRQWXZodHhXZ1lwbU9oUmtIVUQxaVhBSU4rMVozaGlsVThpZ0xQR0FVSHRl?=
 =?utf-8?B?TTVDclh4V1o2b29EQWtMdy9NTzhSZWFrWlVMbU4vc3pRSFZLWVJKT0dodThn?=
 =?utf-8?B?S2JVczdXUWd2c0hYZnFGYXJEWEdQK2JZOE9nNEtWZ21FZ1dkUlRHaElodXRL?=
 =?utf-8?B?Uy9WeHV3Vmw2a2x3MFRhUFlqOHV0VkIvdWwxdmZUcG9qYm9kWDUvdGxZZkJQ?=
 =?utf-8?B?UU9jZnd6OEdjcFgrdDQrak5BVmM4Ny96LzZBYTBBVUpHMXhHRlV2dUpBWHpk?=
 =?utf-8?B?b1V3WTl4emhNcmgxdkoyK3J3L0FXWVM1VGk0L25tOVdtcyttYTVreHRVV01F?=
 =?utf-8?B?NEEzemRHOC9VY2NydjN1eW8vUTVOdC9jMFJkWFpTcGkxUWc4S1VwVlZmaWtH?=
 =?utf-8?B?MTlhQzNlbnJCNUhlN2xqWmxNOHFrT1ppSWZxZ3J6dVlQWjY3MlFpTU5DaUpn?=
 =?utf-8?B?WTk3cWoyT2NUc2t3NWRQRzFneDVDa2hmTmNpTEk1WENMQWFSalJsZGVtbklB?=
 =?utf-8?B?WllFVVh0T0NqT2pUS0p2WTdpTE1pdlgyb1JBWW5weVFKQ1NFOXZ5ZDdlemFQ?=
 =?utf-8?B?dTNoS2sxZ21RbUF4MUljM21FcktzWE4yUUo1MWJmQytmeGJrbVIvdXJkVmxE?=
 =?utf-8?B?ZmRGT3ZTdkhRcUlFQXJpYzJmSkpneHVSZ25OcCtiUFBrWTJjcmJ3cmp0czJF?=
 =?utf-8?B?ay9sNzR2VmRNNTBidHE4bEw5Z0FnZnZXelQxQ2xCd2JVNkFsc3p2NVFpcGhW?=
 =?utf-8?B?dk1YdXAwdm84NS9lRTB0b2JXZXEwTVpLaTVBc0ZiM0Z5YXFPaUFtblFEZzMr?=
 =?utf-8?B?c3c9PQ==?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 700f4406-529f-4bb6-57ba-08dc2cdfb049
X-MS-Exchange-CrossTenant-AuthSource: CO1PR11MB5089.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 13 Feb 2024 22:04:02.8943
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: fFgmDcrlr52h0MERwp3FhaW5D/jS2T2WNroW9TCS/OQRWPMTYBGKWZx+rdGep5ocsL+f7eHB4hxuePI9zdIjOTqeZi2u0WGWayqWgzgliVg=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN2PR11MB4568
X-OriginatorOrg: intel.com



On 2/13/2024 3:55 AM, Michal Swiatkowski wrote:
> On Tue, Feb 13, 2024 at 12:29:40PM +0100, Jiri Pirko wrote:
>> Tue, Feb 13, 2024 at 10:53:50AM CET, michal.swiatkowski@linux.intel.com wrote:
>>> On Tue, Feb 13, 2024 at 09:59:14AM +0100, Jiri Pirko wrote:
>>>> Tue, Feb 13, 2024 at 08:27:16AM CET, michal.swiatkowski@linux.intel.com wrote:
>>>>> From: Piotr Raczynski <piotr.raczynski@intel.com>
>>>>>
>>>>> Add read only sysfs attribute for each auxiliary subfunction
>>>>> device. This attribute is needed for orchestration layer
>>>>> to distinguish SF devices from each other since there is no
>>>>> native devlink mechanism to represent the connection between
>>>>> devlink instance and the devlink port created for the port
>>>>> representor.
>>>>>
>>>>> Reviewed-by: Wojciech Drewek <wojciech.drewek@intel.com>
>>>>> Signed-off-by: Piotr Raczynski <piotr.raczynski@intel.com>
>>>>> Signed-off-by: Michal Swiatkowski <michal.swiatkowski@linux.intel.com>
>>>>> ---
>>>>> drivers/net/ethernet/intel/ice/ice_sf_eth.c | 31 +++++++++++++++++++++
>>>>> 1 file changed, 31 insertions(+)
>>>>>
>>>>> diff --git a/drivers/net/ethernet/intel/ice/ice_sf_eth.c b/drivers/net/ethernet/intel/ice/ice_sf_eth.c
>>>>> index ab90db52a8fc..abee733710a5 100644
>>>>> --- a/drivers/net/ethernet/intel/ice/ice_sf_eth.c
>>>>> +++ b/drivers/net/ethernet/intel/ice/ice_sf_eth.c
>>>>> @@ -224,6 +224,36 @@ static void ice_sf_dev_release(struct device *device)
>>>>> 	kfree(sf_dev);
>>>>> }
>>>>>
>>>>> +static ssize_t
>>>>> +sfnum_show(struct device *dev, struct device_attribute *attr, char *buf)
>>>>> +{
>>>>> +	struct devlink_port_attrs *attrs;
>>>>> +	struct auxiliary_device *adev;
>>>>> +	struct ice_sf_dev *sf_dev;
>>>>> +
>>>>> +	adev = to_auxiliary_dev(dev);
>>>>> +	sf_dev = ice_adev_to_sf_dev(adev);
>>>>> +	attrs = &sf_dev->dyn_port->devlink_port.attrs;
>>>>> +
>>>>> +	return sysfs_emit(buf, "%u\n", attrs->pci_sf.sf);
>>>>> +}
>>>>> +
>>>>> +static DEVICE_ATTR_RO(sfnum);
>>>>> +
>>>>> +static struct attribute *ice_sf_device_attrs[] = {
>>>>> +	&dev_attr_sfnum.attr,
>>>>> +	NULL,
>>>>> +};
>>>>> +
>>>>> +static const struct attribute_group ice_sf_attr_group = {
>>>>> +	.attrs = ice_sf_device_attrs,
>>>>> +};
>>>>> +
>>>>> +static const struct attribute_group *ice_sf_attr_groups[2] = {
>>>>> +	&ice_sf_attr_group,
>>>>> +	NULL
>>>>> +};
>>>>> +
>>>>> /**
>>>>>  * ice_sf_eth_activate - Activate Ethernet subfunction port
>>>>>  * @dyn_port: the dynamic port instance for this subfunction
>>>>> @@ -262,6 +292,7 @@ ice_sf_eth_activate(struct ice_dynamic_port *dyn_port,
>>>>> 	sf_dev->dyn_port = dyn_port;
>>>>> 	sf_dev->adev.id = id;
>>>>> 	sf_dev->adev.name = "sf";
>>>>> +	sf_dev->adev.dev.groups = ice_sf_attr_groups;
>>>>
>>>> Ugh. Custom driver sysfs files like this are always very questionable.
>>>> Don't do that please. If you need to expose sfnum, please think about
>>>> some common way. Why exactly you need to expose it?
>>>
>>> Uh, hard question. I will drop it and check if it still needed to expose
>>> the sfnum, probably no, as I have never used this sysfs during testing.
>>>
>>> Should devlink be used for it?
>>
>> sfnum is exposed over devlink on the port representor. If you need to
>> expose it on the actual SF, we have to figure it out. But again, why?
>>
>>

I vaguely remember some internal discussion about orchestration software
wanting to know which subfunction was associated with which auxiliary
device. However, I think a much better solution would be to expose the
auxiliary device ID out of devlink_port instead, through devlink port.

I can't find any notes on this and it was quite some time ago so maybe
things have changed.

If we enable support for user-space configurable sfnum, then we can just
have the orchestration software pick its sfnum (or check the netlink
return value from the port add), so probably this is not that useful.

