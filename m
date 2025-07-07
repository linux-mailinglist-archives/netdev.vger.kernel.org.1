Return-Path: <netdev+bounces-204533-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id B6F86AFB112
	for <lists+netdev@lfdr.de>; Mon,  7 Jul 2025 12:21:54 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 41F653A81D7
	for <lists+netdev@lfdr.de>; Mon,  7 Jul 2025 10:21:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 54738293C6F;
	Mon,  7 Jul 2025 10:21:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="MfpDa/Em"
X-Original-To: netdev@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.11])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5F3202E3712
	for <netdev@vger.kernel.org>; Mon,  7 Jul 2025 10:21:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=198.175.65.11
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751883694; cv=fail; b=OtOjdWF2+uxR/p98hY7pV6/Mj3WxrR+wZjKo9nLg0DOcT2uy0UDYrPmwJt4Cte/lsR/Ykk+aqYQUZWQtGEzCKwVrgoMAB0fdNQ0sTVvFfwP8yxvsRSRYa9wZOypWBjhNJXdPwlZXPX493oR/6mHFRWZ0+nWBsX508s5gZTdypPs=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751883694; c=relaxed/simple;
	bh=cFiPG8QjUXuUCkPpEaLyAT7QAV4UzSGo8hn5toU0ssg=;
	h=Message-ID:Date:Subject:To:CC:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=BkDX0hPdpbkgQJY9s173ZzoV/Jvwlm88Ox++cZAO+2vUsLYndnZHzsb/OiAT7B2wDg0oszrT7q0vXP+jaKHwOBJW3PFyaW05O1tqOKJqcyEz+NqO7WAdE1TLBLWTMT1c/NqpXEZwoZSOX+HZZRMQy/PgO7GoqmOzmBQq56XsN2A=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=MfpDa/Em; arc=fail smtp.client-ip=198.175.65.11
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1751883692; x=1783419692;
  h=message-id:date:subject:to:cc:references:from:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=cFiPG8QjUXuUCkPpEaLyAT7QAV4UzSGo8hn5toU0ssg=;
  b=MfpDa/EmIgS5qFCvUoIAogKUkZ6NEGiyRGe7Lh9R9jBUKW04z8Z8ySTl
   BrOJzEyKPsasbJ4+XPPXYm115uwvJLHA6rN2aHEMz2MdmUGTtYUhAqav/
   Wt+8amxE3dvAMx/kX1mF7mXsMhK6nMmkDoVJiKWncz+xq39aBr0c6lJAK
   yOcmL5i4CT2fSqVKx81cFj/i6qaPUaf8SfMqV/9zW7gLf9HOO8JYwJsTZ
   y3PhH89TzcYy9t6UAhp40zGV//QiqLGjqHI2OtrnohKZsV26/OU2hqpDq
   khPT6E8pJqJ5qKtQn5UEHMn1Jx/+PpVp6Qcp7V/nZZQlvRJNzWeX7moG4
   Q==;
X-CSE-ConnectionGUID: vggtELKXQX+ZX25/u6AZRQ==
X-CSE-MsgGUID: LL9YGwyyQJqGI6z177jDLg==
X-IronPort-AV: E=McAfee;i="6800,10657,11486"; a="64341804"
X-IronPort-AV: E=Sophos;i="6.16,294,1744095600"; 
   d="scan'208";a="64341804"
Received: from orviesa003.jf.intel.com ([10.64.159.143])
  by orvoesa103.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 07 Jul 2025 03:21:31 -0700
X-CSE-ConnectionGUID: Qr7pgTe0TpyZPNnzEV8+gw==
X-CSE-MsgGUID: 3I+SEaPlTQyDNGxhi3TDEw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.16,294,1744095600"; 
   d="scan'208";a="159520277"
Received: from orsmsx903.amr.corp.intel.com ([10.22.229.25])
  by orviesa003.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 07 Jul 2025 03:21:32 -0700
Received: from ORSMSX903.amr.corp.intel.com (10.22.229.25) by
 ORSMSX903.amr.corp.intel.com (10.22.229.25) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.25; Mon, 7 Jul 2025 03:21:31 -0700
Received: from ORSEDG901.ED.cps.intel.com (10.7.248.11) by
 ORSMSX903.amr.corp.intel.com (10.22.229.25) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.25 via Frontend Transport; Mon, 7 Jul 2025 03:21:31 -0700
Received: from NAM11-DM6-obe.outbound.protection.outlook.com (40.107.223.45)
 by edgegateway.intel.com (134.134.137.111) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.25; Mon, 7 Jul 2025 03:21:28 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=EZ3d2u+m5FuagIPR9//5iHQQBLubW9UyTNi0sRh55WLzSjlpE7X1aPnKToK494p+itgaJpHVdJofpKFcazVxAX/baQ9P3jCJtKfD6HtB3RSUBdGiFgKyhbWWmQQuUVDOFwUm3PxPlZh1gcdMt2X668cS+h04CfpxGqu4hPR5Lgx1ojMVezVHsM03WUnzBojQzB4KAKCTNkTR9Ys49WPVzKZRPZp0UjC+96JfmWdKAhdmEqX4QmKAzExO8IYzOuPqi+NMSCd+wZlTI27R2SlSxmOrCe7WJKNuF14fsmK6mlZh7QqT0oWxWp7R7tExuPg2Qcmr/U64aoeasqa0ULALAA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Ob70bp4DfkGw5vaixkPLtGng3uM5FWiLgZm2dPcySuw=;
 b=rHlNCbjn0usOtN69smcpH5xl9LGmP1wbO07/xTTumHpoqYoBYD4z8FxjO1VjpdIU8MFQ/3EURcF71DxIb0pl86UJacvt/srC8pSQlZRxmUyQJwcZp9eyr/EEiO7D744MKqJe0fT2o1aF9ix51qcpU19izMNkwH5jQo8SO5ZnfN4aswptHZ69E/5LLP/a7s6ecE16wIqaW64F+ACaGTGLzhtSMbOmtGDeYfKACix79b6ab763rwgIwLpNgqFariu4nETskYMgO1jlzUL4TqnBX+rpQj58FF53qgDgTy2aQjPsmw8Jb9omwOQ8Uhwy7/QGi/uWb3H8Wrw65I7Bd/24DA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from MN6PR11MB8102.namprd11.prod.outlook.com (2603:10b6:208:46d::9)
 by IA4PR11MB8944.namprd11.prod.outlook.com (2603:10b6:208:563::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8857.22; Mon, 7 Jul
 2025 10:20:59 +0000
Received: from MN6PR11MB8102.namprd11.prod.outlook.com
 ([fe80::15b2:ee05:2ae7:cfd6]) by MN6PR11MB8102.namprd11.prod.outlook.com
 ([fe80::15b2:ee05:2ae7:cfd6%4]) with mapi id 15.20.8901.023; Mon, 7 Jul 2025
 10:20:59 +0000
Message-ID: <97405349-9b4a-4a4d-a311-5ac56f417399@intel.com>
Date: Mon, 7 Jul 2025 12:20:55 +0200
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH iwl-net v2 1/2] devlink: allow driver to freely name
 interfaces
To: Jedrzej Jagielski <jedrzej.jagielski@intel.com>
CC: <anthony.l.nguyen@intel.com>, <netdev@vger.kernel.org>,
	<intel-wired-lan@lists.osuosl.org>, <dhowells@redhat.com>,
	<David.Kaplan@amd.com>, <jiri@resnulli.us>
References: <20250707085837.1461086-1-jedrzej.jagielski@intel.com>
From: Przemek Kitszel <przemyslaw.kitszel@intel.com>
Content-Language: en-US
In-Reply-To: <20250707085837.1461086-1-jedrzej.jagielski@intel.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: DB7PR05CA0019.eurprd05.prod.outlook.com
 (2603:10a6:10:36::32) To MN6PR11MB8102.namprd11.prod.outlook.com
 (2603:10b6:208:46d::9)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MN6PR11MB8102:EE_|IA4PR11MB8944:EE_
X-MS-Office365-Filtering-Correlation-Id: b03be23c-849c-461b-c663-08ddbd3ff787
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|376014|1800799024;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?S0E5RVRrNDc3Z0VuOVRRYTEvSGFiemk3MHN3TStEQm9JTVFCdGtLM2hUTlVR?=
 =?utf-8?B?V2VvT1dING1ybFAvaHVyYTlUZ05RdE1hK3N4OVhWaUZsclZKZGVFTFNWM254?=
 =?utf-8?B?YVJHSWtWQWJNRzIvcEJUR0k5SlJCNlZwTEE3QzR0T09kaVY0cDRia2xlMWdU?=
 =?utf-8?B?QUZkNjF5bHRxM05kOEd1bVBjK2lJVWVZS2J3ZTdHcFJZYkdjUUQvR0o2bk05?=
 =?utf-8?B?bk04Vi9kZXpxUFdQRFVnTkRyZ001VWM2anBzdkkzUCtXRUlkK1N2eit6M0lP?=
 =?utf-8?B?TW9pY245Q3MxSDI4a0MwdzBjSEFVdGphT09uQ252OVBYaGFlZ1lTbEVZWnRL?=
 =?utf-8?B?MktsOThQWHYzUGFNTUhtZHRvdjNLcms3aGltRlRpbGVBek42VDVxdDZuU1M5?=
 =?utf-8?B?ejZDNnlUM21QN29qNTlaRWRhWXp1MEcxbERacWJsTDFkTW00MDZydkFvVmVn?=
 =?utf-8?B?MTVGamMxcVNvOXY1Zmx0UHJ4OXVwWlNYNXFZVDdaMitRR1E3a2N5aEloczYv?=
 =?utf-8?B?Mk5GZHVEaDJwd2NCRzBUc3FNRVdkcjJXRXJWcXhtTW0vVENIUmxpMi9LWEdu?=
 =?utf-8?B?Y29FWGx4WWl1SDJ5RStlWjFaSkNrRm5YUFZTSHdiQVhrUm95cU1JT0RVSGpp?=
 =?utf-8?B?bVI0ZFQ3Q1VROTlQanZ4MjA0L2tuOTlNNThwRlljZmpyWldPSk8wK3F3aVlU?=
 =?utf-8?B?SHgreHIyZmtYOFVWcmhidmlQT0laVGJTTTZyN1YwbEx3M3R6UDJVb2FhSWlC?=
 =?utf-8?B?MjUrK2FkMnhxK2hwUStPbldrSXQrRG9ZbTNueEpzNDYxVXNFRlZ6Nm9idysr?=
 =?utf-8?B?azVqNk42dHdVRGxSQWRHSzhBb3kvUitkZGQxTDZDRXFjWDhJTTZiNmNpK2h2?=
 =?utf-8?B?SGZLZDVzd1RaNEhra09HVExJNko3MEFTZHZFdVBLczhsT3owZUZRVmVCbHEy?=
 =?utf-8?B?TzNidnV2ZTNhTVpjVFk4MnpqS2JHMC9uZ2N0cGFFVU5odnBQYVMwRkNTOG0r?=
 =?utf-8?B?d2o5SGxya3ZGZ1NOTkozN0lha09sd2ZvNjRtS1NXdEZWRUFGL3U0QWZtWXMx?=
 =?utf-8?B?UWpaa1JPbEk1bWU2R2VScUlOUG9oWTN6UVR5dGpjK0NaanlRb2NZaDlVaWp0?=
 =?utf-8?B?T1YrRUtGWDB5ZDc0S0JOaW5ONU5WTERWK3ZVSVhocyszMFUzc0N1ME05dGY0?=
 =?utf-8?B?ek51S3NRRWhNWHhMbTVmNkVNZjE2ODduanBOOUFzdTVJbkFZaUVGVEFTQ3l0?=
 =?utf-8?B?R0VVTFRmcVVoWG1tdHVFZXM2MjY1Zmg4eGxvSmhvSWlVRHVMdUJ2OFYzODZ3?=
 =?utf-8?B?M2NRcWZhNkdBNWU4NWVMK2RaUjdCUmxUMGpJYzF0SFpLWW1FZnNNdmFHdjdt?=
 =?utf-8?B?N3UwUzZWeHVOMzl4L1d0cHV4L2E0cEczU0FWUXplUWtWcDF4cjFlRDZBd3Ix?=
 =?utf-8?B?RTlIRHRxUTVqcWY2cE5PclFEY2ZPZzlLMTVsRGNHSHBma2xqSW5LZ0hzTzV4?=
 =?utf-8?B?cGJDcFN1M2RkdnNwdGxmS1VCeFhyNUFYOXhJUmdZdEFpK2p1RXhMVUtGUjBI?=
 =?utf-8?B?QUF2ZjZnbGNtY3N2NURGSWx4aVVtZElJZ0RtTlAzbzBGbmdmUXQxMXNNRjNG?=
 =?utf-8?B?S2lJbGp0QVk1YlcwOHhuZEh5N1Z0Z3ozdE1sbjUySmNsVmUxajlFelVsellv?=
 =?utf-8?B?QTdFM1hJdFM1b01OcVZOT1JPZFlKeWhxcmtmM3UrNklVNFdVUEZvQ3IxbjdP?=
 =?utf-8?B?c0cxL2ZMb281NWhGeTA4angrTlBsZkcvQU1MdHhGbUZtR1hEZjBlV2hKa2Jn?=
 =?utf-8?B?dmdRNVlZbW1zMGcrZm9kN2hTVU9INGg4WVdjV1lqbkRHRmk0aHJNcSt2c1Nw?=
 =?utf-8?B?OGtXYWNkN0UrUWxCcnFVa1FPV25DWVlzNHNOeTdzZEtDVGc9PQ==?=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MN6PR11MB8102.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(376014)(1800799024);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?QmhBdnNSSzBQRmNuY2hhaDA4b0hiS09hSVRDTHdKUDAzaDZoUkVIUTl6cHBt?=
 =?utf-8?B?Qi9XZzNIT2puMDN3WTFNYkRtT0IzV05aVGJGREpqZXUrSGg2b3NsS1Znb1NX?=
 =?utf-8?B?SU9yaitpRFNrS3NrRTF2MGEvZklnSjFKTnNzN1J0OEVFRjRGL3ZmYTZWbTBh?=
 =?utf-8?B?T2thcStmb2dWZVoyRHR5cHFpNE8vdDBUQXc4cmtJVzZnMkhZekJ1WUJYRzZv?=
 =?utf-8?B?cHRwS2xmNlFsRlcvdmFqSGMwalIrQW91VzdXa3lVNGdpNzlOSDNlMFkzc2Ft?=
 =?utf-8?B?V2YrMXNXaDh0OURXY2FoRlRjQ0M4MjBJV09aOHFYMTBFd0pOZzFaZ0pMVG8w?=
 =?utf-8?B?NnpjSFIxY1VEd1phdGoxVzRmaTdKbWczRmhGNmZQdkxSTmxBZzE4Ynl3TGZJ?=
 =?utf-8?B?VS81bDN6VjJKT1BnN3NwZ3d2UzlGL3pnK1dQTnJuaVl3bXZJL1hoekJIOTdX?=
 =?utf-8?B?STB6L1EwN0JRaVUrdWZhWkVlVG9KdnJIdjM2RUE5dHFIVXlYODNDNlA2d3ZR?=
 =?utf-8?B?SW9raFhKTEE5M2gxbVZQNVNNRjNqMEFvTm9XSXZoQjhLT2p3SE9Ddi9oY2VI?=
 =?utf-8?B?NUx6L3pMQ3pIanBiS1ZPWndDTzZkbjJZRzdSOUdMSnFKbkNLK2EwT3lVYklY?=
 =?utf-8?B?NkszNjVyRDRDNVR2Z1orU3FlRm13V0JvRXVBY25ZNWk4cmZQUHhTWjNDbnlN?=
 =?utf-8?B?UytTMVdzQmpvODBwM2E3c2I0QmlraUs3bndLNEhwQXY4YloyckxGVGZMZlN2?=
 =?utf-8?B?TFJjMkhaa3gxQ3Z5a0JYUCtNV1dpa0NuL3oxazNyKzltYWE1UVByN3VoYmJi?=
 =?utf-8?B?cHdsbFIvaU9naDdpZ3JUa1kyK242NDJoc05GWE5Kd2NHRDhBR1lsMEZmOWpi?=
 =?utf-8?B?OVBUL0xSNytlNStTWVpCejVQVGVDak1pd3NUZXl5WmdzV3l0NFpiWC8vd0hy?=
 =?utf-8?B?TGx3UjBHYWEyNFNBVEZBSUI2a1AwRTU3NDUzeTVZdU1FS0xEbGR1TXFNWUh3?=
 =?utf-8?B?dFl5K20vRHljWjVLTEdoVnVNZFZ0SkdUU01GaHZ6dHQ3dzdIZTR3V0VtVnhB?=
 =?utf-8?B?d2w4cHlhM09EcTNqVklMMVNxRXF5OHFEOUtBZUpWcDNXTCs2WE0vdzBMa1FB?=
 =?utf-8?B?dDR4WjVDdWRudnRyd2p6NWRsVjNFKzY1bnFpMFU5Sk9nWnJMRmZZOVltT3Bo?=
 =?utf-8?B?SkpsQXJUNjhHaXcxZ2o2R0g3cTgvTmcxTXc0U0lyNTJGcHlRMnd2bFJ4UXhV?=
 =?utf-8?B?RTRqeC9uYXVQcmFzekZwT0VQSnJtVDh2T3F3cGViQUNWYlRzcmtIUU1Wd21q?=
 =?utf-8?B?NzlyTmQ4VXl6UUhCa3pTSG9TZFdkdFpseW5mYmhkNHN2WmE2dGdEc1BzMlN1?=
 =?utf-8?B?Y0xoY2N6NWZObmQ1M2FDN21FTDNNVzNoVnB4dGNqbStzZkVCZ1V2a0NmL1pu?=
 =?utf-8?B?M202dUdmWU9Ua2VVRlJCZGhKUjlEUG9rbWxTbWlDNEVlb21HcmJ6blNuS3Ay?=
 =?utf-8?B?dE1raTM0WDFPZG9RU0ZsZWpJSG5xb05MVWVkTnE4S0lqdXVWSUlMZ2VrYjVu?=
 =?utf-8?B?cmZiU21DR2pNODMwbnlzbE1hSUZtTVAwQmhIQ0I4OXlRSVVOdmM3RUhIOVA4?=
 =?utf-8?B?OUpiNlJMNHNqZnBsVDg4MkFnZ202aTY1cEJ1bU9XT2RqdEdBcFE0Y3NNTkpW?=
 =?utf-8?B?Z3dJczA4ZEZ6M2hMaWxaejFpWTVodit4b1MwbXd1UVUwU1VzZE9PbUFqeVpF?=
 =?utf-8?B?M0lOdkMwWXhUN2lGRyt0cVlaOWp0R3ZpYm5IUy9XcEIyaUxBMCsycTFSenNI?=
 =?utf-8?B?ODE3OTZOZHErd204TXltYUxndWlWdWZZUUk2dHJmMWV4NFBHOEdFOGtKcTZp?=
 =?utf-8?B?M0pudWVMVTZnN3ZrNVVvZkM5OFQxYWlxQWtEMFIwTGVqQUFiY2lGbG1uSVNC?=
 =?utf-8?B?OTRJQUV5azdrVWdmZW5obnljRG9tVVU0OXhndUlrbHJWSlJyVVZzZE1vLzVH?=
 =?utf-8?B?OHJ5RmY0UUQ3RFFWUzltbEtZZ0dYTEdKOTE3MnZ5bVA0eUpEczdFUkNmdjgr?=
 =?utf-8?B?UlRFQWdnNHV1SG9uc1c1WTEwSEZXMkptbVRxZ2JnS2l0cDFuYjdaaWdrRGRq?=
 =?utf-8?B?dXRzLzRHbjZ3ZGVCSVcweHoxNDk1ak9kTjVxYUkyWlpHUG9CdHBteEZoQ21R?=
 =?utf-8?B?Z1E9PQ==?=
X-MS-Exchange-CrossTenant-Network-Message-Id: b03be23c-849c-461b-c663-08ddbd3ff787
X-MS-Exchange-CrossTenant-AuthSource: MN6PR11MB8102.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 07 Jul 2025 10:20:59.1820
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: AeSq4jmXdy0DvbrthLW8+yusC5nlQqJXUaWYINfHUEL1y91ILUUlU1nGxYN3a9kwdmFM9sCJI5iCI8MUbtXzCULCdKQrABYqw/naTefmIwM=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA4PR11MB8944
X-OriginatorOrg: intel.com

On 7/7/25 10:58, Jedrzej Jagielski wrote:
> Currently when adding devlink port it is prohibited to let
> a driver name an interface on its own. In some scenarios
> it would not be preferable to provide such limitation,
> eg some compatibility purposes.
> 
> Add flag skip_phys_port_name_get to devlink_port_attrs struct
> which indicates if devlink should not alter name of interface.
> 
> Suggested-by: Jiri Pirko <jiri@resnulli.us>
> Signed-off-by: Jedrzej Jagielski <jedrzej.jagielski@intel.com>
> ---
> v2: add skip_phys_port_name_get flag to skip changing if name
> ---
>   include/net/devlink.h | 7 ++++++-
>   net/devlink/port.c    | 3 +++
>   2 files changed, 9 insertions(+), 1 deletion(-)

Reviewed-by: Przemek Kitszel <przemyslaw.kitszel@intel.com>

> 
> diff --git a/include/net/devlink.h b/include/net/devlink.h
> index 0091f23a40f7..414ae25de897 100644
> --- a/include/net/devlink.h
> +++ b/include/net/devlink.h
> @@ -78,6 +78,7 @@ struct devlink_port_pci_sf_attrs {
>    * @flavour: flavour of the port
>    * @split: indicates if this is split port
>    * @splittable: indicates if the port can be split.
> + * @skip_phys_port_name_get: if set devlink doesn't alter interface name
>    * @lanes: maximum number of lanes the port supports. 0 value is not passed to netlink.
>    * @switch_id: if the port is part of switch, this is buffer with ID, otherwise this is NULL
>    * @phys: physical port attributes
> @@ -87,7 +88,11 @@ struct devlink_port_pci_sf_attrs {
>    */
>   struct devlink_port_attrs {
>   	u8 split:1,
> -	   splittable:1;
> +	   splittable:1,
> +	   skip_phys_port_name_get:1; /* This is for compatibility only,
> +				       * newly added driver/port instance
> +				       * should never set this.
> +				       */
>   	u32 lanes;
>   	enum devlink_port_flavour flavour;
>   	struct netdev_phys_item_id switch_id;
> diff --git a/net/devlink/port.c b/net/devlink/port.c
> index 939081a0e615..bf52c8a57992 100644
> --- a/net/devlink/port.c
> +++ b/net/devlink/port.c
> @@ -1522,6 +1522,9 @@ static int __devlink_port_phys_port_name_get(struct devlink_port *devlink_port,
>   	if (!devlink_port->attrs_set)
>   		return -EOPNOTSUPP;
>   
> +	if (devlink_port->attrs.skip_phys_port_name_get)
> +		return 0;
> +
>   	switch (attrs->flavour) {
>   	case DEVLINK_PORT_FLAVOUR_PHYSICAL:
>   		if (devlink_port->linecard)


