Return-Path: <netdev+bounces-282689-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 4E0/BqYL82mSwwEAu9opvQ
	(envelope-from <netdev+bounces-282689-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Thu, 30 Apr 2026 09:58:30 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id 7E4F749EF96
	for <lists+netdev@lfdr.de>; Thu, 30 Apr 2026 09:58:29 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 22BD8300D714
	for <lists+netdev@lfdr.de>; Thu, 30 Apr 2026 07:58:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 356963FA5FA;
	Thu, 30 Apr 2026 07:58:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="MwIsbE/E"
X-Original-To: netdev@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.16])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B0E8519049B
	for <netdev@vger.kernel.org>; Thu, 30 Apr 2026 07:58:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=198.175.65.16
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777535907; cv=fail; b=s80rVejt8Y1Fir+nkzuXgKKEjLj2U816FeqU1tkqKUL+Nr49wufwxQ5abXb+grZmkDk/aMD3LLKr4EzHKpEF5bfOue5X6PbFJTxGMulDMcvEXVXUWmbzXJlGr81zo3cre2aTj/hg4ngd87kSqwlDODuxNsNLAoC8i5NIiq8apCk=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777535907; c=relaxed/simple;
	bh=lSPNSMBDPNDffaaQ/lT8If+FOpUEQVOaDrDTQupTHK8=;
	h=Message-ID:Date:Subject:To:CC:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=WLY6k1LrJVDDDelHWBDJggDQkzGhGySWEMSXxdHxMmphw4SNhd6C9Yu31lXbrV7IEGZziVrTVgVuZFb1oGZOFQMQvMx1Yl+SYD8YQwe14BTaEK83iuNa/F5fwkRovTXXJou2I5KYUCsmd0rstumGU8WvLIKiEVuxLtBSO1uv3es=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=MwIsbE/E; arc=fail smtp.client-ip=198.175.65.16
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1777535906; x=1809071906;
  h=message-id:date:subject:to:cc:references:from:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=lSPNSMBDPNDffaaQ/lT8If+FOpUEQVOaDrDTQupTHK8=;
  b=MwIsbE/EVggXb9b5pBGdtl7yY7pjVic2VbiVn597OnVCKZaAdeUaS6rM
   kd2j1hzHlMtxfIlTIMYaNgbs9cNCaOQSMF02lwSaBFDf7wA8PLPFuq55E
   WyxYCfQGloy7HjUQTcskY/T0NZzvRVunf8GJ88p3AUC5XkxGAqeHd0MJA
   gZtE0loqLnxpjioTF8ye/fzQNCb0PuA8UmcPGa/aM8wQCfvRIleouiya3
   l/wfFYlBheH3xNj+5rY3byBrizJdK1nGl+E7AusZACsbrVcYhS3/ycaLM
   EInJ8tNe5+DzsomPJC59VI3VS4MzFBE+OULD+enklJX5s7VPjxoL280WO
   A==;
X-CSE-ConnectionGUID: fBT/WlLvTJ2X3hpnYcUlKw==
X-CSE-MsgGUID: Ygqc0lOnSWeMs3I3KX7qXA==
X-IronPort-AV: E=McAfee;i="6800,10657,11771"; a="78669638"
X-IronPort-AV: E=Sophos;i="6.23,207,1770624000"; 
   d="scan'208";a="78669638"
Received: from fmviesa010.fm.intel.com ([10.60.135.150])
  by orvoesa108.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 30 Apr 2026 00:58:20 -0700
X-CSE-ConnectionGUID: onpzzg1iRoCnNe3VJrRokQ==
X-CSE-MsgGUID: rg31K5n3SQG0ZXDoXgFsow==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.23,207,1770624000"; 
   d="scan'208";a="230160772"
Received: from orsmsx902.amr.corp.intel.com ([10.22.229.24])
  by fmviesa010.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 30 Apr 2026 00:58:18 -0700
Received: from ORSMSX902.amr.corp.intel.com (10.22.229.24) by
 ORSMSX902.amr.corp.intel.com (10.22.229.24) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.37; Thu, 30 Apr 2026 00:58:18 -0700
Received: from ORSEDG903.ED.cps.intel.com (10.7.248.13) by
 ORSMSX902.amr.corp.intel.com (10.22.229.24) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.37 via Frontend Transport; Thu, 30 Apr 2026 00:58:18 -0700
Received: from SA9PR02CU001.outbound.protection.outlook.com (40.93.196.70) by
 edgegateway.intel.com (134.134.137.113) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.37; Thu, 30 Apr 2026 00:58:16 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=YL/JRO3yM1jDXcl4+yZdY4vOkOWypUkcsmium9V0p6oAKhMxSJXdra2O7FQTrSiOP0csGRZ8D1s+TkLgvUao8ZoOJNcHLnlBcHh35WM389Vx1yg8DCdmrz+2MBevNL4ljeRcFAV8MWPTz/2EN73niw1aASUrmU0palDLfQVconWutmWR0LJbO7MZlEVs35VC0D5vfxBKWqE3CYwbJfjwn2Of9ZYGUOrSzgfMR1rHMNKADjQ4IooRlPJP1xaPSXElVtRNrlZwTkfxKdXuGXn18ziiEO0JK6JwG4YMp8kgGIJIaQbRFcm9P8ZwXFlF3TyI8zPNv2Y175jRUvYF/rMBZw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=5RLa+CbHtjEIVsdAlz97A4N/ZWgcGU+m2kViPtYTqj8=;
 b=EQZF2O930LLrV30ZXU0QKqKMpxaFLudYcuoK5ilmcosJJvdz/Qk2pKyVPoAFDpyAYP0cSTTMQ2K9DGBp6ZXw5FbKJCpWB9r93BE5Rux6j7VAIQtx+rcN5O+K+4gdZibbTKTl0sWrw4KwH8E6dwFJd7coe6zEiR4qFJa5vmT+7ZeD/Rf+ReKbBMCtsZqQhvrcX/x1Jwux7gzAaZoC62HhX784hYlPc6Qn65xhVm8AwEfE/zx3PonMkej4rPFjx1g891d+hyWiZkln3zpXrJhMjzLmj8HElESc400F7A5sYb0H7Uv7U7xOUDzdG9uhwykKK9Gqvg6QD9A04rP7z6jWAQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from PH8PR11MB8013.namprd11.prod.outlook.com (2603:10b6:510:239::8)
 by PH7PR11MB5983.namprd11.prod.outlook.com (2603:10b6:510:1e2::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9870.18; Thu, 30 Apr
 2026 07:58:14 +0000
Received: from PH8PR11MB8013.namprd11.prod.outlook.com
 ([fe80::26a5:58f7:7e5d:5572]) by PH8PR11MB8013.namprd11.prod.outlook.com
 ([fe80::26a5:58f7:7e5d:5572%6]) with mapi id 15.20.9870.020; Thu, 30 Apr 2026
 07:58:14 +0000
Message-ID: <4d1db513-8b3f-4a74-aaee-3748e8c820e3@intel.com>
Date: Thu, 30 Apr 2026 10:58:05 +0300
User-Agent: Mozilla Thunderbird
Subject: Re: [Intel-wired-lan] [PATCH iwl-net v1] igc: set tx buffer type for
 SMD frames
To: Kohei Enju <kohei@enjuk.jp>, <intel-wired-lan@lists.osuosl.org>,
	<netdev@vger.kernel.org>
CC: Tony Nguyen <anthony.l.nguyen@intel.com>, Przemek Kitszel
	<przemyslaw.kitszel@intel.com>, Andrew Lunn <andrew+netdev@lunn.ch>, "David
 S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, "Jakub
 Kicinski" <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, "Choong Yong
 Liang" <yong.liang.choong@linux.intel.com>, Vladimir Oltean
	<vladimir.oltean@nxp.com>, Vinicius Costa Gomes <vinicius.gomes@intel.com>,
	Chwee-Lin Choong <chwee.lin.choong@intel.com>, Simon Horman
	<horms@kernel.org>
References: <20260417193223.291093-1-kohei@enjuk.jp>
Content-Language: en-US
From: "Dahan, AvigailX" <avigailx.dahan@intel.com>
In-Reply-To: <20260417193223.291093-1-kohei@enjuk.jp>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: TL0P290CA0003.ISRP290.PROD.OUTLOOK.COM
 (2603:1096:950:5::18) To SA3PR11MB8021.namprd11.prod.outlook.com
 (2603:10b6:806:2fd::21)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH8PR11MB8013:EE_|PH7PR11MB5983:EE_
X-MS-Office365-Filtering-Correlation-Id: 2286837d-9ac1-4cd3-8e16-08dea68e3acb
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|7416014|366016|376014|1800799024|18002099003|22082099003|56012099003;
X-Microsoft-Antispam-Message-Info: l2BDqJs/cWXPfYNDXznWpfHeHPZgpDqiq2WxbayRyCDXKs4+AuAxEH6r0nqmcpMD7EedgTqei2Tg2lEOKkAZ4HJSqewsaE5/7P4ZqDBpLYWkQPz5fUtAy48vVX8cZPnHLKfIs0pyr2ALHjdQnyQEj1X4o5V5cZDA2WRvX8O4n722poMCr8d86reTFvxMI3w5HYvjU40QU9cCbGzZZjNkZvIg6Dsvg+E3HJzAtcZhlT/ab7pgprSYdGxm2UfHyRjFyNvVKVs+xW9ByeFC82hM0Qe9Rkfd9H3EPqiHg+NgDSb25o4uwGAL1ogMgAl4AVLXsY7+n9TxbNhL1fMiYNvpvwPrgdJlT2bFIBz+r0cppYoHUagOvCbj8Y9mAq2txhoxHsbRIk09nQWsEMZ8/vpi1QtH7JtLEXCzIuZQH9NswI7Q0uWTrY3ebWI4GBEk76b7Y/LyaXQyCaXH06R6BHJiFLb9Uj9LJgq+VncWWhuSZt8IyK/MruyMO7SvOXlm2Qw401Ur0QPWTTnCji6MwThPy2c+QCSUwnmbU7cNGbPQU8BHUQwNwVGDER6gmtX4pe3ZL7OGsMxQUSV8CQB0e5FjaJ3HKVFTE+LaUe5V9TGqIsOH7dr8cO/ScPFZg+sZWXrIqYEpUn14RnXnAS7C+1e2LzRJLUP1si7yURU4dqYQJnSUUGfd5rJd7K2wbWlyDBih
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH8PR11MB8013.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(7416014)(366016)(376014)(1800799024)(18002099003)(22082099003)(56012099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?bmc4R2M3RlAzMjZrQ2d5d1JJbi9wSndadFd2Skk5R1dheUU1WFdxR2RyOE5E?=
 =?utf-8?B?OTMzMWNYOVhOWVVXWUdOL0EvT3dEKzUxak9XTHZMS1Z3Z3AyNk5ybjQ2eWFV?=
 =?utf-8?B?SzRWU2d0S0lmQy9GaExncm05aE9XNjdwczJKd09jSEhrMTFtaUorenR5OXdh?=
 =?utf-8?B?eTM4aVByQjZiSHUrcEZENC9LQk55VEhFd1VZbFVtQ1FXdTR3Z2hWL0dQMmNi?=
 =?utf-8?B?SWpFNFdTU1ZOSjhTTm8xR3dGbmgrNjdma2lKKyt2ZWVhN0hwbnlnNmFJWDNB?=
 =?utf-8?B?WGZlV0JXWjRBZEZoMnpCRzRzVFUrckozcTh5MlpHbkhNVHRGa1V2MG1KR0lM?=
 =?utf-8?B?dHVTQmNHeGFIL1lwejBHVGlMRiszeVZCNUp5Y3ZLSGpTbkRmSzBXVlNNQmdu?=
 =?utf-8?B?LzE4QjhmK0F2bnlvNFh0TjhUcm12M0ZVMXRydGNOSXVuQTF5Ymk3S1pzZCtr?=
 =?utf-8?B?OUxuZUhPTFl1NllGaUZEeTVScGpyQWtsY1BRT3hpekdnNW1HUlNLcVFTcXBT?=
 =?utf-8?B?TjJRTnlEODNzMktxK1pHejhFTUNnZFQ5bG4yNnFqSG5nejFqNlFXcVgzT3RF?=
 =?utf-8?B?cmF2K2p0VUppOSttVjJmU2NSaFpxdllqUmJ2QUFGSkhQWW0wWVEvQ0RGL0VS?=
 =?utf-8?B?bW5rUHRIT3VZNHE0MGl5eU5vSTYzd3I5ZmZMWXBsOUxXN2phVndsWU5ieTVk?=
 =?utf-8?B?QXZZcmpxcDVJNVdpOGsyUEhXYm13VUhzZWoxRkxXeVNzWmErSWxpN0hvT1JX?=
 =?utf-8?B?TnJQQ0lvZjFWZjRYVnFiYW15bjdzQm1zRUJpcVU3dEllVGoxZFFlYkZqRlUw?=
 =?utf-8?B?TEc2QVIwZkplYndEa0R5SjlnWU50VU9UbWxxYVdxUGZ5R29uZGh2QkpqS1RC?=
 =?utf-8?B?V0JMZ0NjbElmVXp1VGYwV2RXN0RBTmxsM0lqZHkyOUNqNjBPNjFTRHdWeFg0?=
 =?utf-8?B?bTZ5ZUdzTFdGSzhKc2twY2VKd2RsbWgxcDBTbkdwY0grVmVTdUNYd0NrdGpU?=
 =?utf-8?B?c1BrWTZ4aUdFRWxkSmNDak5lbEI3aEwzaGtRTVVTMmNBU0tVMXRIOUsrUEI5?=
 =?utf-8?B?N1UwWERXT1d4OUR1TmkxZUVZSENiZkFubVZWblR3NUZYcGRXRGZPUC9rYjlC?=
 =?utf-8?B?aW5rdS9uWnAvdFlIYm9wczY4OFNmUU4rWG43QkRuN2xjTVVCZkV3eXlRRTZm?=
 =?utf-8?B?Z1Z4UnVsWHFTVkRSSEFUeFQ4MFRVT1BuYk1MTGUrcGlDemF0MHpSQS9XL2VF?=
 =?utf-8?B?aWdUT0pnTHFFTkZGLy9jRWFSSVpHOTZHTzluN3VsZGF4RTRNeTBrRTdiYklM?=
 =?utf-8?B?dWZtSmQyZHp6SmJscmNRclZoTDhmdE9pbnNOU1c3dU1EaXFDeWY1SEdNMDZ1?=
 =?utf-8?B?Szh6d0x2SlpWRjJPZnIxaHdwMkFndUVmWXRPNGFWVnpZbW9jamxWc3FtaGw1?=
 =?utf-8?B?dXpwWWI0djJrSG1BMmZHcGtNaHpsS2pyN1h4OEhGRTJiY1lBUVdpUnY3dVk3?=
 =?utf-8?B?VFZxVlg0b05JdWdrVFFzSnVTYytLVWFQWDQwekNRaUpFY2QwUFJnclZYTWMr?=
 =?utf-8?B?Z2FXUFFneFVIV3JFMS8wVklmbnNXaG5XaWZUWmYwSGk5c0poRUFUYXNzdGxn?=
 =?utf-8?B?czVFcWh2U2c0Q2ptN21oVnltUVI1TThOUitTWTRGVzJYTHdxcVlIV0o4UGdx?=
 =?utf-8?B?QzlGTE5CWlRGdi9DYXIrNzE1RGJsY2xaMzUralFjRm5MQXhoMysycFZJWVox?=
 =?utf-8?B?SjM3M1NtRGY5bkQ0NFpFUkpXMkR6MEJiRTVlYWNzNnFZWTdHcSt4bDZ3OUtk?=
 =?utf-8?B?dWlXaWwrN0J2NkxFamM1WVY4SDdkam96SGRyTE0zMEdqdHQ5N0o0MmQwNjFs?=
 =?utf-8?B?N0ROM1RoY0N4aVR1djZ0YjBITU1WU3BSUDYxUlpYdWN1SWY2M0hheGtLa2FG?=
 =?utf-8?B?VUN6R2IzMittMy9weUtFcU1rWENSUnZ2Wld4dUhYalh5SUNsZC8xT1NubERV?=
 =?utf-8?B?UUFLUnVOdDVOaEZCbndaRGFUVGFpakIxMkFzRDQxR0VheXdIQ0pDNEtaemM2?=
 =?utf-8?B?d05yc3FnSHVJQ2FXR1dZR0Y5WjI2ZTNaQjY2NXBqdCtFci92WGhYZVE3Znlj?=
 =?utf-8?B?TTVrWHc0RFRUUHFPSEc4NExLZER5RmFXUktVYnBNUkkrSHBRbm1zM3J2QU03?=
 =?utf-8?B?bUFSTkUxekF5bGo2UWNyb1N1QVhHV2xOcFlHb2VTZERXTmVzQ0VBRzh4L016?=
 =?utf-8?B?blRmSkJUelZWdXRDbk45RzBwTC9HSkIzUnVEeU1MejNKMXVXczhGVHdrZlAx?=
 =?utf-8?B?eXhMeFNicnpCdXFVVzJxbkR6V3NpR3BabTdEa0NKaUIwWnhSazlpMnk0OVZZ?=
 =?utf-8?Q?KLUa6USKKSAOarw4=3D?=
X-Exchange-RoutingPolicyChecked: rMETLBG51JjtJCFST14x4xgGwS7Sear860RHVdFrUl0f4LtJ1LutZDWORjch6i/xR+tqnXROsNSOeDcQ2UJeWGQXNpY3w+x8zDYG45bJW1g+mMhMnWy635C7WaSMFx0dGUUfkg/Y/G0H8WYY4zNlvaV4Fb/gNk8PJbNKBAR3JYnKfeFk6jh/kEvWC10oaEaHbUueaGDCMASsQs86As8WuNCWipZQyfy1avQ2pcACo88YvdIigRJCTfmL24WkF6JiArP5HCW2AmocATehPlA0oA9/8MMU9PrOmGn0qWkoO9KHAx81etN4+a4LmTplfq0Xgp7aBeD2hPTfRA5qjurEvg==
X-MS-Exchange-CrossTenant-Network-Message-Id: 2286837d-9ac1-4cd3-8e16-08dea68e3acb
X-MS-Exchange-CrossTenant-AuthSource: SA3PR11MB8021.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 30 Apr 2026 07:58:14.1203
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: DwQ+Yi71xprjN79y/nZZcbCKn+M1VsmFezxOLXxGonF8IjV/8r/g+8LLlCyk6+YcirB0mwAs2n1I3YOzX7LCY+dOSex64Nd94+9iiD/O0Ys=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR11MB5983
X-OriginatorOrg: intel.com
X-Rspamd-Queue-Id: 7E4F749EF96
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [1.34 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_REJECT(1.00)[cv is fail on i=2];
	DMARC_POLICY_ALLOW(-0.50)[intel.com,none];
	R_DKIM_ALLOW(-0.20)[intel.com:s=Intel];
	R_SPF_ALLOW(-0.20)[+ip4:172.105.105.114:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	MIME_TRACE(0.00)[0:+];
	RCPT_COUNT_TWELVE(0.00)[15];
	TAGGED_FROM(0.00)[bounces-282689-lists,netdev=lfdr.de];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns,enjuk.jp:email,sashiko.dev:url,intel.com:email,intel.com:dkim,intel.com:mid];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[avigailx.dahan@intel.com,netdev@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[intel.com:+];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[netdev];
	MID_RHS_MATCH_FROM(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.105.96.0/20, country:SG];
	RCVD_COUNT_SEVEN(0.00)[10]



On 17/04/2026 22:31, Kohei Enju wrote:
> Sashiko pointed out that igc_fpe_init_smd_frame() initializes
> igc_tx_buffer fields for an SMD skb, but does not set the buffer type:
> https://sashiko.dev/#/patchset/20260415025226.114115-1-kohei%40enjuk.jp
> 
> Since igc_tx_buffer entries are reused, a stale XDP or XSK type can
> remain and make TX completion use the wrong cleanup path.
> 
> Set the buffer type to IGC_TX_BUFFER_TYPE_SKB.
> 
> Fixes: 5422570c0010 ("igc: add support for frame preemption verification")
> Signed-off-by: Kohei Enju <kohei@enjuk.jp>
> ---
>   drivers/net/ethernet/intel/igc/igc_tsn.c | 1 +
>   1 file changed, 1 insertion(+)
> 
Tested-by: Avigail Dahan <avigailx.dahan@intel.com>

