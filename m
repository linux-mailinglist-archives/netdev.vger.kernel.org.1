Return-Path: <netdev+bounces-122150-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D4AD39602A1
	for <lists+netdev@lfdr.de>; Tue, 27 Aug 2024 08:59:19 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 1D4EFB229D4
	for <lists+netdev@lfdr.de>; Tue, 27 Aug 2024 06:59:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D83DD155C9A;
	Tue, 27 Aug 2024 06:58:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="QCDjMXUb"
X-Original-To: netdev@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.14])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 02E5B149DF4;
	Tue, 27 Aug 2024 06:58:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=198.175.65.14
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724741932; cv=fail; b=tncdlB6KxVYZ7eCwgaA/5oDoX+tplG6oJUliNf3DVdNZpCV9eekE3OgZOzbfpKqndv/odMPMKybJiinlW3/ZGPfJz7rWjhB89WPZaOM0KHcrBfueK/TF0jyu/eqSdSXe/kuL6zvDGrxx6Mw/0wYZutS/JiCSRLmqZq5IBN2yO8s=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724741932; c=relaxed/simple;
	bh=IbIGOOjmmzotGrv4HR5FnUH90+QQRAikbDjTHpruhb8=;
	h=Message-ID:Date:Subject:To:CC:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=WueR714I3IHsm0qUPpOwGbzHB27jKsuyLVXwwLRFFVqKn0q3wPRIZ1/jn2JdfOaabtE3K9lCF74MJvyLqx1gDusCAhrhmDU2WyEmnv5LfAeyT0oEceUZTvf+x1aqfOkjfLny8s1e48f1Vg4+rgK9pY2fh3b+W48Xt0oqQFZzMtk=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=QCDjMXUb; arc=fail smtp.client-ip=198.175.65.14
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1724741932; x=1756277932;
  h=message-id:date:subject:to:cc:references:from:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=IbIGOOjmmzotGrv4HR5FnUH90+QQRAikbDjTHpruhb8=;
  b=QCDjMXUbQyXRxGB7sKtqaVgHKNPywyVN05WQWxD+wPZeRWZ3WkDFaXwS
   8qlwWB87SuydHNjC0OgPjvOdbu1g6/siUvDJ3zkQ/GuQcYFHJDBqIj+6g
   57NyBHNX9BLNCblI2ph5DkyDMrGJB8jUx91zljAwiW0co7XZaMdXhBMHE
   bfvuTBZZKxwAkC91eA/BRHMSCii1wUBMlSAebIoTBCvg4Pco4SJ11DY1R
   xE/39BVari1FQWbyFKNGgRs647rRFLWl2XX5eqeB+FyqzhtmobTrSSS3n
   hkgsjalwobIk+LUUPzwiE35WQ5uoHHmAmF1IB6jqvJGPuu0tmmmh/9jwe
   g==;
X-CSE-ConnectionGUID: WlUA+cGrQPC34bsPZOq8Rw==
X-CSE-MsgGUID: Dz79+0ScQ1qx4eNheyapbw==
X-IronPort-AV: E=McAfee;i="6700,10204,11176"; a="26995680"
X-IronPort-AV: E=Sophos;i="6.10,179,1719903600"; 
   d="scan'208";a="26995680"
Received: from fmviesa006.fm.intel.com ([10.60.135.146])
  by orvoesa106.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 26 Aug 2024 23:58:45 -0700
X-CSE-ConnectionGUID: y/cbTQ1gSc20zskBXKFdRA==
X-CSE-MsgGUID: tB2Ib8ygQIa2/WGqxU5bYw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.10,179,1719903600"; 
   d="scan'208";a="62440040"
Received: from orsmsx603.amr.corp.intel.com ([10.22.229.16])
  by fmviesa006.fm.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 26 Aug 2024 23:58:43 -0700
Received: from orsmsx611.amr.corp.intel.com (10.22.229.24) by
 ORSMSX603.amr.corp.intel.com (10.22.229.16) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39; Mon, 26 Aug 2024 23:58:43 -0700
Received: from orsmsx610.amr.corp.intel.com (10.22.229.23) by
 ORSMSX611.amr.corp.intel.com (10.22.229.24) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39; Mon, 26 Aug 2024 23:58:42 -0700
Received: from ORSEDG601.ED.cps.intel.com (10.7.248.6) by
 orsmsx610.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39 via Frontend Transport; Mon, 26 Aug 2024 23:58:42 -0700
Received: from NAM10-MW2-obe.outbound.protection.outlook.com (104.47.55.44) by
 edgegateway.intel.com (134.134.137.102) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.39; Mon, 26 Aug 2024 23:58:42 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=u8WCrgAQi0xWGYQWwl5c3IT+3vc9CZh8f+OhnjWKzwRQNDdSRhj0bznafe49E5Oe71ajrFkXRa+wLos5hVwLN7hy0Gc7P9C3nrLSH/dZ4ngFGqr6zRhT7/rZYOITbau/E8uhu05/Q90BIUtUcso5yqMpid+/xFsbE4QfYtVTJiiefryhcm9bd/cDdZzNl996OvZRQw1pF6g2kyueboOAOv3Ayc9i1S5cW3MppNLgpVBJ0SLLHmPDW8TB6msGNH6EeiZJyf89U0isfqiwT5oWlnuzqJ/7l8TqdQYTd+1LHoZjzaUuf1wU4fvuBqI9vEdRWIyiWIhpA0CLMnT8C7l2ug==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=J8XQzEZlWmBLYOJAcLtCYhLlqsj90FIpq3P6heXt6TQ=;
 b=Jq81MIBdhes2t9yxkjnTLCm3g8jpuoJo3pBaMuqzUJauZ/tBWtea8rOiaiwcJP9aPAJshMPnPnoSMI0SXaREEyPxWyW8DiHd+Sv/HNxCKmh4X5MnOHRw1d4oJqlMfsDnXwifXbuNTuYeFwBYJPfRGZAYm2Rjq2vKQ1ZZZ9hHfGQLtubRSN4bdcC1yUxH8CyzvacdU5i+BXly18W9jz6J/FBt0wa1mPQF3k5Uhza9T0BJdVKPuiKG6ZCDWV5Mjf8TcBgihaf6HwHfmxfLKzKukVh9SAE2Hkh5dMTcT5Ev2ZYmzJZ4MXeaCUKl6qePoW6wwAuyRgZJIaWARRypzGZt9Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from MN6PR11MB8102.namprd11.prod.outlook.com (2603:10b6:208:46d::9)
 by SA1PR11MB8475.namprd11.prod.outlook.com (2603:10b6:806:3a3::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7897.24; Tue, 27 Aug
 2024 06:58:40 +0000
Received: from MN6PR11MB8102.namprd11.prod.outlook.com
 ([fe80::15b2:ee05:2ae7:cfd6]) by MN6PR11MB8102.namprd11.prod.outlook.com
 ([fe80::15b2:ee05:2ae7:cfd6%4]) with mapi id 15.20.7897.021; Tue, 27 Aug 2024
 06:58:40 +0000
Message-ID: <dafcfb71-52b5-4bf7-8145-aae2dfc06e10@intel.com>
Date: Tue, 27 Aug 2024 08:58:33 +0200
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net-next] idpf: Slightly simplify memory management in
 idpf_add_del_mac_filters()
To: Christophe JAILLET <christophe.jaillet@wanadoo.fr>
CC: Tony Nguyen <anthony.l.nguyen@intel.com>, "David S. Miller"
	<davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, Jakub Kicinski
	<kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	<linux-kernel@vger.kernel.org>, <kernel-janitors@vger.kernel.org>,
	<intel-wired-lan@lists.osuosl.org>, <netdev@vger.kernel.org>, "Pavan Kumar
 Linga" <pavan.kumar.linga@intel.com>, Alexander Lobakin
	<aleksander.lobakin@intel.com>, Dan Carpenter <dan.carpenter@linaro.org>
References: <fa4f19064be084d5e740e625dcf05805c0d71ad0.1724394169.git.christophe.jaillet@wanadoo.fr>
 <c786a345-9ec4-4e41-8e69-506239db291c@stanley.mountain>
 <2896a4b2-2297-44cd-b4c7-a4d320298740@intel.com>
 <bbe06f51-459a-4973-9322-56b3d27427f1@wanadoo.fr>
From: Przemek Kitszel <przemyslaw.kitszel@intel.com>
Content-Language: en-US
In-Reply-To: <bbe06f51-459a-4973-9322-56b3d27427f1@wanadoo.fr>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: VE1PR03CA0003.eurprd03.prod.outlook.com
 (2603:10a6:802:a0::15) To MN6PR11MB8102.namprd11.prod.outlook.com
 (2603:10b6:208:46d::9)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MN6PR11MB8102:EE_|SA1PR11MB8475:EE_
X-MS-Office365-Filtering-Correlation-Id: 0ff67e4c-a978-4850-adc8-08dcc665aead
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|376014|7416014|366016;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?djBGa0VTY3ordmczZXJrbnlCakwzSE1VRm43Y3lBWkMxOTZuNGUxODZpYUpG?=
 =?utf-8?B?dXU5ZHhiVzUyZ0RqOUlvbXZ0dlExTHkwb1hKQ09oNTBiaDVxMHZYVlUwNWNV?=
 =?utf-8?B?UWJSS0g5Y1krcTltKzFXajZsZ1o5OUNBYTBHb2VhanZsZzM5eW8vK1NnLzd5?=
 =?utf-8?B?Vml2alo3dnlac3hOdmtDSTg2bHFTWWtSVS8zVlpZUXA1bUoxQXNaaXZYZ2h2?=
 =?utf-8?B?S2hRUlIwalM5V0VqYXpWVjZnWDl5Q1RuVS9ySHI3RXhzVHVnd25oSDFDQlFS?=
 =?utf-8?B?dzBFZURva2UrV2M1L2ZaelhxZ3l1Rk81S3lNR0xvSk14V3ZDMTdpOGl3Zm9C?=
 =?utf-8?B?bmRXbHBNUFJQaStaOG12T0NBcDBvLzB2ZWNNdXZZNFNKVDdYNzRweHYybmxL?=
 =?utf-8?B?S1kvckxPNHRsN1F4QUlnR2x2bnFNQzFsS0RIbnYyMjJQa2FDeWI0K1ZPY2o0?=
 =?utf-8?B?RTR6SzBmeUZIYXpTVXZ6RjBCZzcrVVNnL256NnJtMWtXbkU4elJEeVhqdEJZ?=
 =?utf-8?B?MWljZ1lxOHJMSys3WHNXd1FYUUplVGlPM2VIM0tMMi85T1pVclc2QTlEazFi?=
 =?utf-8?B?TW1Zd3hpeUMvMitueEUwaWpyZlhvaDNnaXBrdkFRRFJaWXF2ZUFtVzNvODZp?=
 =?utf-8?B?L0pRazQ3Q3FiVG1qM1c2OHF4YklNV1RzcHpvMTYzOUdSbytuanA1YnNyREtZ?=
 =?utf-8?B?b2lrai8vUE1JWXlHemtpU3c3TTJBaStvWWtFUkNpOFB5cXlseXFhYU5PZTIz?=
 =?utf-8?B?azRnRHZjZnJPeFFQUHEweHlwQkRrdVRHQVFEWlBwOXNoQXEvYnFmY0hneEND?=
 =?utf-8?B?TkdqVnlyZWN2Z3JBV0JTM2xTbHFCUE5QaFF3aDU4Rm93dHhtZ3dIL1l6eEFG?=
 =?utf-8?B?OG1MOFhZWTRTMUxqblFSbUE1cUtmb2pNM3FRTkpGYmp1bnFjN3JKbndmbEo3?=
 =?utf-8?B?bU5CYjRMMG5Yd0VkWTlIVHNBMjZlaGxpMDJZckJrYUlETXZ1eklsUG8zbE1w?=
 =?utf-8?B?TVN2Q240dVRMNWFOM3g5QVhBU3kyS0FRbTNjWWV0dVoxN1VmMEJpWHI4blQr?=
 =?utf-8?B?aFIyazJWczFKNjRJc3ZDQi9xdFJ1UnRQZ3ZpL01zMWQwSTZPVkVjemFLaG11?=
 =?utf-8?B?ajBMNlJDbkVFMUFITXZURnZjMk1KY2F4aGltdjAzeHZyUEhXWFVIWGNUV1lp?=
 =?utf-8?B?ZzRnZ1F5ZDNNaGErZGNDNG5TQ2NMVlZJdGxkRmtKYll6b1UwM1ZOOGNiNkZp?=
 =?utf-8?B?UUZGd1piT21icFhDU08vejRoZ1cwVzY4K3dOT1JpNkFLajVIZmVwQlR6ajIr?=
 =?utf-8?B?NDQ1TS83SjlrRHVKdDlUZnZheDNlWlRVdTkzOFpEcy9YSTdTVm9yQXowcUdv?=
 =?utf-8?B?Zk45dHQ0S3VnYWk2REFaL0xGUTJDblVxd3pPVlZQejlKcDBvTzIwLzdPTTlP?=
 =?utf-8?B?cUVWRFk2WXRpcVBxM3BLVk1BZmE3Q0ErUllvcHhQUjduUkVUbHFRYVlwTkRy?=
 =?utf-8?B?MitKMktYa3I5TTBrRDkzOHVJSkdUSVA0WlVQUHJ3ZmxzOWM1WFV3ckRRSjZz?=
 =?utf-8?B?ZjdEQXhXY3pncjRsVjhhZlI1VzdRRDB4citzRU9aYXNFTnBVeGh2MFVKMGRB?=
 =?utf-8?B?NHFJUDI2RGs1a0RKd1NWR2VmVldEZ1pmK0Z6dGRYT2h6U2pLV0V6d1VTdWdO?=
 =?utf-8?B?YlpBWFBtUUVvb0xyVitIYlQ2dHEveVRIa0FZWVRWOUtMMXdTdUI0TzlJZTJs?=
 =?utf-8?B?a01Ed0paVG5UbDNDT1ozZ2Z0VVR4MUNOeVl2Vkdqdm9iMkZKTnNHdW1WaGZk?=
 =?utf-8?B?SlZHMmMrSUtFZTJ0bkN1Zz09?=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MN6PR11MB8102.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(376014)(7416014)(366016);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?bVpMZDRSQ3FWdHpFYTZKc0M2cjBpczI0L3dvUi9XUEN1ZFdjMktHMkF1Y3NO?=
 =?utf-8?B?enpjdTVGbEIvSk1ycU80SkEyQ0N6WDA0SE1nc3d3eVlLRll0TzJvTitHTXFU?=
 =?utf-8?B?OXZCbENuVnV4N1U4VTA1RHBBRnJuU3dyZzh1ekhJbS83Tm9WT3ZybVZYblIr?=
 =?utf-8?B?NExDMXVzblVYd04wajZJenBnWXFKbktpNUdTVEZ4RmRqZzMrWmxwNVllNE5m?=
 =?utf-8?B?MDh5c1NaOGhVWEU1a2tmYmlYVkVqSDFmUWZ0TUpjbVpoWllqRFh1ZWluL1du?=
 =?utf-8?B?UHFSMDdnQkhvcWtKY0hKL2Fhb244d0hhV0p4RnJKSGxsWXQ2S3lTSWF1MFlS?=
 =?utf-8?B?NEdMNmNYdWp6MlBxRzYyT1ZMbndyOUJsS3pXdkZibU5NZDd3Ty9McjBEVHNk?=
 =?utf-8?B?VHpEMWRONGUrK2swZmh1MjFEKy9hMTkvMnRoYXJrMTJFMHI3cVU1SG9FRjM4?=
 =?utf-8?B?YWZoMjR3RHcyNVd3Q2xmQ0JuaG0rNXZaUWNVNnlkWmhLZU9jSjNiUzVGRENM?=
 =?utf-8?B?NWlvNm1Yb3lpRDBsd2V1VG8yaG4wOTl4VDN4bTU1Nk55WmcxYzRQVWdIeXcz?=
 =?utf-8?B?SEZFb3NkaXZlWlNDZlZPU2xRT2pnZVRpTURuR0ZzdDd1VERmZHFvckdpeFBr?=
 =?utf-8?B?YTNTbFB4NERxMS9Td21sZ2FPa3RiYTR3ZytubTdOK3FZVHU5dmVvaDJRS3VM?=
 =?utf-8?B?MGgxYURhVUU1YUlFTkM2NkFEUHNDbW83YXI4S0t2dk5ZTSt3dU5Xb2w3VG42?=
 =?utf-8?B?eFhsNnR3TVZYQ2p4UjVFNXhDM2hXdXRNZDBJZlR3czlXV3FtTHYrME03c29v?=
 =?utf-8?B?WDk2dDZiUE9VOWFWaCt3M0pvdDBoZ0RnRklTbDlCQkl6RW9YRDZiZFl6RkdE?=
 =?utf-8?B?amVNV05hU2Q2dWpHUFFpSGFHRjJIcXYwVUNWajIxK2JDaGlCY2RxSTFha3VQ?=
 =?utf-8?B?endLalFKVHk2TklWcGRSdFI0QXVPYmtHTFBGODVEMndONVR3YUNoc2VSano3?=
 =?utf-8?B?bVFVM0RoTEs4NWV0NFp1Nmt3SHZ5V3BTelBYc2krcUl5WEVoem9OV0ZIYTQr?=
 =?utf-8?B?MTgzQmNObXE5dmJzTDlUd1lJQzIwb3gwam05VFlsSlNQN25XR1JnSEpUZmZu?=
 =?utf-8?B?dndUVXZ1blBONUhCOVN3WG83bzVwemNGbnVQM2NaK050ZjNaR1ZndzA2NVR4?=
 =?utf-8?B?bEZoZjJlZTdyVHZQVHJvY2QrR2dSWWFSeUp1SG5lR1p1aGVLdXBaSm9icklB?=
 =?utf-8?B?WXBxcHJiRlFxeUVkMmJLYVY4NGo3UkdkM3V4R2FlcTd1bTVPbXZyMU44UGxn?=
 =?utf-8?B?Tk91b1FmZUt5cEMwb2QyelpTZmRBSUFiME02Y255anl5Wk5wbzFEQ1crdXdP?=
 =?utf-8?B?bnl3L1FoazJpeDVLOEROSTlySUhUdGIvNnM1T1E4UHpZdUV2dlcvRnRFZmh1?=
 =?utf-8?B?di9Yd0YrQWlsSS9sSDBGcmdGSmpadlVxM3hhTERDY0Q3aCt5ZUM5MitkMnhP?=
 =?utf-8?B?S0VUWFFLeVBEbVpLaFJzZXUzaUtubnhpaFQyRjRuTnZRVmNGcHlDNWxqOGoz?=
 =?utf-8?B?UG5oZk5jMXBnREpIdkQxa2hEK3BQdHplaXlGK1NqMVVXbHVNKzhwQXVCbVVI?=
 =?utf-8?B?NFpXU2Q3c3BwQmp3d1RDT0RXZXA5c0VsREZNaW44c0FQeXJIVFVNRmhWZVNj?=
 =?utf-8?B?NFAwVTRvVHZBZ0JaU3hHQjQ2MXllbm5TZTBGTW5xRkk0S01xNHUwRU9vam9i?=
 =?utf-8?B?RFFYdzNjV1dXYTByMlJjWWdNdFFNMFNuT2Z4NDhNRTNqcGtCdy9UeC9GUGQ0?=
 =?utf-8?B?b0VkQ24rTGlzbkhwNmhJd3E1dGtVSWNOQ0F1TzY5VEZoSHl0cXRCS2dqdkdp?=
 =?utf-8?B?NHA4dUQxSlRacThSV1BNeGNRUXdicUkrMGJMQWY1Yy9hQVRIaHFBS3ovWUxJ?=
 =?utf-8?B?akdUOTJsZTBHdEhITTU4WGFQTUlMemhSbzB4MlY3TEZlN0VJY090TUx6Vy95?=
 =?utf-8?B?cktVd1A0cTc5NDVsK2oxcnZ1azBIUTdmK0R5U0VqWDlwR1VYNDkwTzhDb1Yw?=
 =?utf-8?B?TjVqNmpJaUN3cWpxQ0dONEdIeWhjb29hYWsxaS9ITEVKZnhsUnMvSkhVZUt5?=
 =?utf-8?B?ZEdQeFJVUTFPZXB5bVB2QWNqbDhabWRvWkduK0lySnAzL0pkTmg0b3gwRVZH?=
 =?utf-8?B?cFE9PQ==?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 0ff67e4c-a978-4850-adc8-08dcc665aead
X-MS-Exchange-CrossTenant-AuthSource: MN6PR11MB8102.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 27 Aug 2024 06:58:40.5282
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: B1hj7iCGm9vaWTxKxAJ3IcnP6LlDclCTZVpwOSHwQnU35563x5qGRam4Wbzxz6TWbleyCNADI5H0yUMZ2iRXO0qtyZw2mu38qJf2Jziq7fQ=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA1PR11MB8475
X-OriginatorOrg: intel.com

On 8/26/24 19:14, Christophe JAILLET wrote:
> Le 26/08/2024 à 11:15, Przemek Kitszel a écrit :
>> On 8/23/24 11:10, Dan Carpenter wrote:
>>> On Fri, Aug 23, 2024 at 08:23:29AM +0200, Christophe JAILLET wrote:

>>> It would be even nicer to move the ma_list allocation outside the loop:
>>>
>>>          buf_size = struct_size(ma_list, mac_addr_list, 
>>> IDPF_NUM_FILTERS_PER_MSG);
>>>          ma_list = kmalloc(buf_size, GFP_ATOMIC);
>>
>> good point
>>
>> I've opened whole function for inspection and it asks for even more,
>> as of now, we allocate an array in atomic context, just to have a copy
>> of some stuff from the spinlock-protected list.
>>
>> It would be good to have allocation as pointed by Dan prior to iteration
>> and fill it on the fly, sending when new message would not fit plus once
>> at the end. Sending procedure is safe to be called under a spinlock.
> 
> If I understand correctly, you propose to remove the initial copy in 
> mac_addr and hold &vport_config->mac_filter_list_lock till the end of 
> the function?
> 
> That's it?

You got it right. Thanks for your further analysis below.

> 
> There is a wait_for_completion_timeout() in idpf_vc_xn_exec() and the 
> default time-out is IDPF_VC_XN_DEFAULT_TIMEOUT_MSEC    (60 * 1000)
> 
> So, should an issue occurs, and the time out run till the end, we could 
> hold the 'mac_filter_list_lock' spinlock for up to 60 seconds?
> Is that ok?

Messing with this list while we are not done processing does not sound
right either.
But the most concerning part for me with my proposition is that it could
be very slow to just "abort and unload the driver".

> 
> 
> And if in asynch update mode, idpf_mac_filter_async_handler() also takes 
> &vport_config->mac_filter_list_lock;. Could we dead-lock?

indeed looks so :( sorry

> 
> 
> So, I'm not sure to understand what you propose, or the code in 
> idpf_add_del_mac_filters() and co.
> 
>>
>> CCing author; CCing Olek to ask if there are already some refactors that
>> would conflict with this.
> 
> I'll way a few days for these feedbacks and send a v2.

Would be good to have simple memory cleanup first, and later (if at all)
to untangle our locks a bit.


