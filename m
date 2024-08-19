Return-Path: <netdev+bounces-119854-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 31E119573D3
	for <lists+netdev@lfdr.de>; Mon, 19 Aug 2024 20:45:46 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id B28441F21A39
	for <lists+netdev@lfdr.de>; Mon, 19 Aug 2024 18:45:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4EE53154C10;
	Mon, 19 Aug 2024 18:45:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="MY5tcK44"
X-Original-To: netdev@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.14])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F2B671EB3D
	for <netdev@vger.kernel.org>; Mon, 19 Aug 2024 18:45:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=198.175.65.14
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724093124; cv=fail; b=JzTYTP7hlc1OyDqjMN9QMrD/i6RPBxGTWpFnPOyroZeCKSwwD7Qhyu/pToifzaTsH2fUHYF06xnl4Nx/4qVVoUSZ9BH7cSp+5zTQ5Y+R6TNNO5n6Ga7UkhBh92ItGfJD5cfWk8fi7/kfIXAf62oYoXeOPIZKl8zJavvNboQ46Mk=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724093124; c=relaxed/simple;
	bh=E4xt7lP3mTyy+NWqSrEm6BZwRhAhNWmSJ73HzkJ6eIY=;
	h=Message-ID:Date:Subject:To:CC:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=kIxFn5dqOdbC6yNJWq3iYAX/Gv7/OZVkpzwahbB62whxJwIFv8rzQv+xnbEMZfEoRVLfes9B92FAk00tVITzILXELcLmJzxFEkEAAOXIEtTstE7l5Tt5RoWaZIFaxyFTxF/qriLWYd6WgcLBzjUixW70YeiYuPn/b/Ildl5Bukc=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=MY5tcK44; arc=fail smtp.client-ip=198.175.65.14
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1724093122; x=1755629122;
  h=message-id:date:subject:to:cc:references:from:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=E4xt7lP3mTyy+NWqSrEm6BZwRhAhNWmSJ73HzkJ6eIY=;
  b=MY5tcK44DyVYByMv4d/slosb5Z2CquhGMysIibgMeMZEpO7g/yxsWwO7
   KUS0E3GhYBGaY5OO1qnPLws4iPFn7hob76ekmPSpu+LgMzoqFP0a5t8Vn
   i7lFXqkso1Rjw53o/Pqn5yqRkPjnttQx2MzbJbguP0TKqIt0wMzs0AuZg
   Zdy8t3EsYAF7mGlhev/EOj2LQbiAvQucYsPjcyIhG968V4Q+ftcsMe6a9
   KyTkpyfI+JSiFNoPE71bg2Y1PQAuBwCFSb8EEjAQjapRpHqRLk7+q6aYq
   4wrFYZrUfnEhFnHV3n5G9/fxtEnjc8S6oEC6ENXWvJNfYkrCFktBQ2fKV
   A==;
X-CSE-ConnectionGUID: cc9yDxGbRlaOtWroPhZ/jg==
X-CSE-MsgGUID: zEy8/0tnRri5t49WMuTREw==
X-IronPort-AV: E=McAfee;i="6700,10204,11169"; a="26157533"
X-IronPort-AV: E=Sophos;i="6.10,159,1719903600"; 
   d="scan'208";a="26157533"
Received: from orviesa001.jf.intel.com ([10.64.159.141])
  by orvoesa106.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 19 Aug 2024 11:45:22 -0700
X-CSE-ConnectionGUID: RTDJ8XaXSRCuenVYCf/qUg==
X-CSE-MsgGUID: Ee39cx0hQbiqbWNufr86Aw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.10,159,1719903600"; 
   d="scan'208";a="97940480"
Received: from fmsmsx601.amr.corp.intel.com ([10.18.126.81])
  by orviesa001.jf.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 19 Aug 2024 11:45:21 -0700
Received: from fmsmsx601.amr.corp.intel.com (10.18.126.81) by
 fmsmsx601.amr.corp.intel.com (10.18.126.81) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39; Mon, 19 Aug 2024 11:45:20 -0700
Received: from fmsedg601.ED.cps.intel.com (10.1.192.135) by
 fmsmsx601.amr.corp.intel.com (10.18.126.81) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39 via Frontend Transport; Mon, 19 Aug 2024 11:45:20 -0700
Received: from NAM12-MW2-obe.outbound.protection.outlook.com (104.47.66.42) by
 edgegateway.intel.com (192.55.55.70) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.39; Mon, 19 Aug 2024 11:45:20 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=yCuC1BZXyUZrcJR7eqc0Kh4djLOasoIjoW9BO2lIkMHlsLlVb9wPMf/XWTUr75tQGWVin2rsbo2HhugeD95w2UhTAbhBtoxzka/a3HlD/Oy2yvKjGEb8z9xQdz3a1WqR7OVqHZFHiLjkvFhcQz0/gQCfGoNjXeUg46/O8BO0wD6+xjVYDabos8XoeNQWn5/QjJj2cdVu/hiWHphJxmWQVEOVqSICnLStfafx38idwArJA1FUwg/5jYKVfq/y6VVcScwUFyjlAKKMIu/1FHX+OcD3S9GsDDlIfc/if7bJYRcYCNsqenQWEFyLRIEsDd0TCdQBtrr7lcTYuLp/TBapGw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=xQhTH8nte0TIgf1lOEPQA3qAn/zqAkO2PFLKQwvu+LE=;
 b=KPqcyjQSlni9JuCqCRpn03KkwxCazrNglLZMZzA/Pjv/Wzwjy6vhbJoYfqIAFP8ICBo8//gouVvzyXYzQNjGIGAzZcULexenDHM9LayrzxnxN3K7hjQgiHnCqsyveV12UKrRdaSAt1x/o4nWwU/ZT8V6RiLCnwN2HgsNACNlo9MJbVrGAv/+20kiYHGzv2xpCE1JTVmuclkB+x2unjmIns1hVTG6wqlWt49eaSKd65Ssqa64EfJDgEmwbXBQXiaQFk9wj8VAy9tn/OFe+jhn6FY8gwByxToXC8BIypaWj4jLp+nPb6/0obF1qdATsmF30a/0ee+rYwmDUQXkNrItpA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from CO1PR11MB5089.namprd11.prod.outlook.com (2603:10b6:303:9b::16)
 by CO1PR11MB5108.namprd11.prod.outlook.com (2603:10b6:303:92::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7875.21; Mon, 19 Aug
 2024 18:45:19 +0000
Received: from CO1PR11MB5089.namprd11.prod.outlook.com
 ([fe80::7de8:e1b1:a3b:b8a8]) by CO1PR11MB5089.namprd11.prod.outlook.com
 ([fe80::7de8:e1b1:a3b:b8a8%2]) with mapi id 15.20.7875.019; Mon, 19 Aug 2024
 18:45:19 +0000
Message-ID: <fcd9eaf4-3eb7-42e1-9b46-4c03e666db69@intel.com>
Date: Mon, 19 Aug 2024 11:45:16 -0700
User-Agent: Mozilla Thunderbird
Subject: Re: lib/packing.c behaving weird if buffer length is not multiple of
 4 with QUIRK_LSW32_IS_FIRST
To: Vladimir Oltean <olteanv@gmail.com>
CC: "netdev@vger.kernel.org" <netdev@vger.kernel.org>
References: <a0338310-e66c-497c-bc1f-a597e50aa3ff@intel.com>
 <0e523795-a4b2-4276-b665-969c745b20f6@intel.com>
 <20240818132910.jmsvqg363vkzbaxw@skbuf>
Content-Language: en-US
From: Jacob Keller <jacob.e.keller@intel.com>
In-Reply-To: <20240818132910.jmsvqg363vkzbaxw@skbuf>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: MW4PR04CA0135.namprd04.prod.outlook.com
 (2603:10b6:303:84::20) To CO1PR11MB5089.namprd11.prod.outlook.com
 (2603:10b6:303:9b::16)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CO1PR11MB5089:EE_|CO1PR11MB5108:EE_
X-MS-Office365-Filtering-Correlation-Id: b2c03d6d-1091-4080-ade2-08dcc07f12e3
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|376014|366016;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?SDhITkh2SWVkUk5RdERaSlVsa1IzMUtROXpaY2ZZTXV4dWxSVjJ3MUtoMnNE?=
 =?utf-8?B?VUJSZk55ekNSeWNNTm1zdWpraTU5QTRFMW15MzVNa001ZFFYbXRsSDdnd0JP?=
 =?utf-8?B?NitMRTdzMUtCUmV5KzJjYktmS3lRQVpyenFyNkhORnRwaGQ0T05aL1E4Nzlp?=
 =?utf-8?B?UldEMGFLc0wyUFFnRG0vSkRqYkMwbXlvd1pnaHBaUHM3bXBvUGNnTTAzOW1G?=
 =?utf-8?B?N0ViNWNsY3c3ZTdGeDFvcVZpRFdnM3hueEpVM043d05XZ2dxdnFWU0cwRFpO?=
 =?utf-8?B?QSt1WHZYRW5LaERpNlZTSElJOVhDejI1N2lYUGFLVnVCUFkxdW1nckRaYUxF?=
 =?utf-8?B?SC9oVUJNVXEwdXpOc2lSclZDZVpTdVBacGpoOE00VFNWTE1FMUJGdDZ5NGVv?=
 =?utf-8?B?L2FCaHhKa3FnR2NwQittRTRpMDB0Tk9TQzI1V0tkRUlucGQrVFJRaHczOW9M?=
 =?utf-8?B?TXJ6OEZVREs2Q1ZHWlNPMi9MRVZKTkVweEw1VGZOQUx2cEdEZnQ5YlVZZU9R?=
 =?utf-8?B?cDJLOFMyd1FrMEE0elRiNkp2OTEwT3ZkdlpOZk9CaHNnRGt1aUJNMlVKVExL?=
 =?utf-8?B?REpOc0Z6bHRQZ2pwVThXY0RGOTF1Wi9FNmJUTlNQYUVZdFpOVjVuT3hSNkp5?=
 =?utf-8?B?cGJoK0c3ZHF0S2NadFJvQ2hsMVJvNWVKdXNva0VoM1NIWTB1Z25XelVHWWdq?=
 =?utf-8?B?QzI0VTZCNExPMHorbXYya1lJUldzdVBHLytiZ2hVVXFVTTJyTUFwV25TOEkz?=
 =?utf-8?B?WitHdlZBV3BZdGpaalJSbnd2OENkT3JkNVA3RDdiZDVnTTRXZzVBTFJIMWlX?=
 =?utf-8?B?c3J3TUFYL1EySjJjSGRMZFltR2thRy9VenhHKy9GQSt3d3JwN3FYTXVXeVdT?=
 =?utf-8?B?NmZPU2JkdWZvd2YyaEZPOXRoc1YvQlJHSFVnQVRCUWFjVnAvcjhBQ2x6TFAw?=
 =?utf-8?B?NjBLR3o0NFVDeDc2L2J6b0RwTURJbFRlS2ZGTWVRMG5GRzh0bGgzSVJTRVlH?=
 =?utf-8?B?T3FQZTE3U2svb3l5elRPTm1HUTcwYStSZFhPaUxCMWV4RU5QUFRtbFhxSXgr?=
 =?utf-8?B?L3ZHVk5PNno4eG5VRlhaYnFTa2JiQ3NHV1E3YVU3d0VHSXhDTmRwbFM0aE1N?=
 =?utf-8?B?TXVOOE5tZGpIK0lNZnZDZ0VBNlk4WldSS0RNTVNIUnBWTUozZ3NlYW9EOSsv?=
 =?utf-8?B?Rmk3dlpqOVF1dDNEbDN4aDZKMndlWXlCQ290ZS9EOWJQL3VzTUZDTW9kd2NX?=
 =?utf-8?B?d2toNkxnUnNHb1lBVUVmdGpmSE9YZWJHMmloQ0NOZzVUakt0UEo5RmRmekI5?=
 =?utf-8?B?K3RmWGZpTXNGZTBFQzgxd3RiN1FyOERmQ1BheWlMTU1IOWFlY0N4Zm1NaU1P?=
 =?utf-8?B?NlE5ZmZQWks4WGNqWUtJclhCMW1QZnZLYVRobVEzSlhyYnF4VWdaSTk4aSt5?=
 =?utf-8?B?SDVoelNIZ25OS0FCaUFNV2NQTjlERU53K1FsY3RSK3hyb3k3ZEh6LzAzY0ds?=
 =?utf-8?B?OW5tbEFKd1V2MnFLME9tODJQbVhJKy9LcUR6RW5iYlFibXJyM0JucjMvNDVF?=
 =?utf-8?B?N29sZFVzSFdTM0hRcFUxN1QrMTNKaFI3bUtXRVlhK1FWRE5DS200OHNuVUdz?=
 =?utf-8?B?cFhINEt5QVAwVjJTSGhtMVBWclREdVVDNGx3aUd0ck8wL3h5VDFJNHl5citk?=
 =?utf-8?B?N09Uai9DR09ybVVVeEpaWWNsdHY1bzUxQ0U2M2VBYmhuampNK0JGTnFMZ1FT?=
 =?utf-8?B?VllzZElURkR3OWJyWUNaNzZ5Q014UEkrUkU4VjAvRjRBRWliaEViNHgvbVBn?=
 =?utf-8?B?UlZWNjFscFc2bTZPTml2QT09?=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CO1PR11MB5089.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(376014)(366016);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?MnQ1MktLOU1UTGsweC9jU2FLY2o5RkYzNE9mbFpyUXlpc0FIalFzTmZyT0ht?=
 =?utf-8?B?Z2JURURyeDJnMTZRMGtWSWhCMnBBZWUyMVEyZFNZMVhHZGZmakVVT2tsV3or?=
 =?utf-8?B?UVdXbGVpT0FoUTFvbkttdzVnK0orYjMwbUF3QjNQb2xzWWRYWS9VanY4b1R1?=
 =?utf-8?B?ZVFyS2V6RXA1ZUtVZjNPTHJZRDdrdnVUQ3o5VjJoSiswZUYvNEU3MThMc1Ar?=
 =?utf-8?B?eE85aEpDOVVOTDFtNkh5RjJHWDRybFErejFGTjJaaVBpNnNWbTl2Z0hEVFNp?=
 =?utf-8?B?OVhoaVRTcVhpZnltZzQ5c1lhaUlieE90eDVYYm5ZN0hxY0g5T2hQMHJrc1p3?=
 =?utf-8?B?L2tuYm1BR1BMTGE1Y2F1R0RBQ0VtUHZNa05DdWNqZkkzWjd2RWhJWjlVWnla?=
 =?utf-8?B?N043VmJZTXpJQUlERUFTdXRJaDZCM21xbmEyWmNpYlJ4bC8vQzFYQThya0tk?=
 =?utf-8?B?Rk54UndiR0JLVmpPbTFqZFFsZUZRZ2dFUnY0aGM0VVBMdUQvV3R5WDVvUm9Z?=
 =?utf-8?B?T0Y5bzJlaGhuZHE1NEJwWmk2b1B5MnFmdzc2Z2FmYnk0MjhJdkUrUmJqbkQ4?=
 =?utf-8?B?Qmp6UlVNSzBZUkZDN0Z2elArYkJGaDFjdGEyamlaQWhSSzdreDJ1aFR4TWc1?=
 =?utf-8?B?WkppbEhjYUFFVjFyMWxnanhHOE9UT1pWRjhLT2VianIrdmh1dGRtOVpKd3g2?=
 =?utf-8?B?V3VsbHRFdlJsMzlIdlNJZHZ0cCs1QzNwcGFCOVB4bWVVTEkzbE9tVElrNWpm?=
 =?utf-8?B?WGNxeDRBRVE5UEw2ZmNVY3IvNEtqYzRaOGhBODB3eUh6aHpBZEVIWlFLaXdG?=
 =?utf-8?B?enRZa3R6a2trdkVSeDBCRkllMk5Ja0wxcFptNGoxUGZ1dllUaC9IUmF4UHQ4?=
 =?utf-8?B?Y3RzZlAyZWFJYVhlL0RBZ2ZBMUp4bzVtZTJjNEk2b3JUWlZraEFGY2hKbUtZ?=
 =?utf-8?B?d0pwSXdzWGVKYjd2dDBFVEc0N3N3WEp4YkN4WGJCSHNDbGo5RmJHSUhlbHFM?=
 =?utf-8?B?cEhOQm5KR1QrRktCWXAzYWV4WGJRLytWd1c1NFNwWVRsOEt4MjU0T0lxYlI3?=
 =?utf-8?B?djZLZGgvVi8yZ0lvaVVxaHIwRHpTRTJEUC9uekRGVmlqTHBFK291VmRiNXdY?=
 =?utf-8?B?TSt2KzNsZGZaYVJXZ2xPRmRvZ2NiTzlFeUErVnNiTGd3ekthS1ZFUGJ5dmEv?=
 =?utf-8?B?TEh0OU94MnhUTEpkWkVnTEVUaS9kK0poaEVCd3VqMTl6ZWVid1p1RGlhN0Vx?=
 =?utf-8?B?NEhQdVJnU1M2VGduRHhDMUhtV1M3TFpDZEJPSjh1ZnlvaXYrKzgwSGlFQmZO?=
 =?utf-8?B?Sk1LajFrNk5yZjNqbENqQWhRQTV1U29jSkhxZEVXa1htNm1hNkhrVEdheDlP?=
 =?utf-8?B?ejNsRm5zVUdtbExIRmI0NkFSTHhZOUJSQ1pJbWN6UUhIN2dCK1VjVkZGUFhl?=
 =?utf-8?B?UzFBNzJJRXJhSXBNcXgwUFh3WGZEOUpHbGVoTjM2dStHcnhmVytTNk5ZUS9L?=
 =?utf-8?B?MGpHZjBRTU83ZWhFUmJremJMQm8vRHlIQzhnSmdUdVd5b0NhZFhuZWJsOUcy?=
 =?utf-8?B?RndJQW9Zc1NvSFo4ZlFXaU0rdllFY1VGbERxRVg4ZUNJZkZZdFl3a0xyVXZr?=
 =?utf-8?B?aldhamJqM05Qd3lVQUp0WFNVc3BSVzZrVXlPaW1pQlp6Tk5uWFRINDYwbThO?=
 =?utf-8?B?dUgraGcxZFUvRDd3ZXFVcHN1Wm9EYTN0aklXMVJMMzBGM3A4NFluWEZaMjM4?=
 =?utf-8?B?VGpPd0xZVUJvSUJFU09lMEFPTHZvOW9MMlpISE1uaGdpaUJIMTh0UEVMQlJl?=
 =?utf-8?B?Rm8vbU9EMUpvdlJqdkRSWDMyWGxCWDJZRkt3SkRZbzZkRm1HWFVldVlnUS84?=
 =?utf-8?B?Vng2OE8zbFJmQWVZdDRZMUlvdnk2UjZBeDRVRXhjeG0yYXVOeXRXSjUvNTFO?=
 =?utf-8?B?dEQrUlI5dTBmS3AzREtsdlVubTlnWnQzdTY1OFFYN2lUSWQwZUJUdU1vQ2R6?=
 =?utf-8?B?bG9DMmVxZmh6b1BaNkttTG9zUE1rOHl5dE1RU1hPbUFaSkQ5YXNaVFdUdkhk?=
 =?utf-8?B?R3NETHI2RDAybENtRVBadFpkUUNJa2duTXhieG45bmNkYWkwVnNCWEh0dGVN?=
 =?utf-8?B?a2ZCb0NJMHFldVhadGF4UU5OQTFhTFZzMWRrdXEyMEFIODYvYWNJcGk5bXZS?=
 =?utf-8?B?Unc9PQ==?=
X-MS-Exchange-CrossTenant-Network-Message-Id: b2c03d6d-1091-4080-ade2-08dcc07f12e3
X-MS-Exchange-CrossTenant-AuthSource: CO1PR11MB5089.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 19 Aug 2024 18:45:19.0747
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: J/M7AO+z4DcZmFtO1jkEN6ndl8kLOr4j+tgPzzXqNcoCqQXCTY1USfCoF5al6hNEwGJloc26A+D7yakTpj203dlRcEKT5SUXUZSnBkbf3Fg=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CO1PR11MB5108
X-OriginatorOrg: intel.com



On 8/18/2024 6:29 AM, Vladimir Oltean wrote:
> Hi Jake,
> 
> On Fri, Aug 16, 2024 at 04:37:22PM -0700, Jacob Keller wrote:
>> I'm honestly not sure what the right solution here is, because the way
>> LITTLE_ENDIAN and LSW32_IS_FIRST work they effectively *require*
>> word-aligned sizes. If we use a word-aligned size, then they both make
>> sense, but my hardware buffer isn't word aligned. I can cheat, and just
>> make sure I never use bits that access the invalid parts of the buffer..
>> but that seems like the wrong solution... A larger size would break
>> normal Big endian ordering without quirks...
> 
> It is a use case that I would like to support. Thanks for having the
> patience to explain the issue to me.
> 

Great, thank!

>> Really, what my hardware buffer wants is to map the lowest byte of the
>> data to the lowest byte of the buffer. This is what i would consider
>> traditionally little endian ordering.
>>
>> This also happens to be is equivalent to LSW32_IS_FIRST and
>> LITTLE_ENDIAN when sizes are multiples of 4.
> 
> Yes, "traditionally little endian" would indeed translate into
> QUIRK_LSW32_IS_FIRST | QUIRK_LITTLE_ENDIAN. Your use of the API seems
> correct. I did need that further distinction between "little endian
> within a group of 4 bytes" and "little endian among groups of 4 bytes"
> because the NXP SJA1105 memory layout is weird like that, and is
> "little endian" in one way but not in another. Anyway..


Yea, I figured the distinction was based on real hardware.

> 
> I've attached 2 patches which hopefully make the API usable for your
> driver. I've tested them locally and did not notice issues.

I'll check these out and get back to you!

Thanks,
Jake

