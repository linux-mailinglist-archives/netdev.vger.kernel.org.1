Return-Path: <netdev+bounces-189869-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id CBE17AB4412
	for <lists+netdev@lfdr.de>; Mon, 12 May 2025 20:50:09 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 3BC403AD631
	for <lists+netdev@lfdr.de>; Mon, 12 May 2025 18:48:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B74D0296147;
	Mon, 12 May 2025 18:49:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="cBogQu74"
X-Original-To: netdev@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.16])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A95C21EE03B;
	Mon, 12 May 2025 18:48:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=198.175.65.16
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747075740; cv=fail; b=qyqZNBlsMjSmwDp9vn6oP5kxjH7/m5ueq57exC0fMFxw8NUbzUFT5XxilzzxrL9f6EOM3BT2XZSJOJGL3HRKtfNQTu8NI3iSNDAuBANUVNm/U38jxKj3tMltMIV2p5qt7NqJyUOA93Fu7iAZNZoLfeGc84tKItv3B9U31HhP5R8=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747075740; c=relaxed/simple;
	bh=pbc9wehQ8zS5aG0Q6b+KhqXtPj52r85/8LXwzqLIkwo=;
	h=Message-ID:Date:Subject:To:CC:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=J0vGAV75Damz1XsDAX9peImjwNkaySvNi0V0CiJIHZB39iCl7aMio9WRlGaSww8B757wAHP9supfI/7CpXFewepkx8jTKxsAF6h3TkXiDhxT4mZARoT2s0/z4t0mkMkb27qdG82BketRSpFc7GCmUNIYxR5ReuFaAnrr2u458zs=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=cBogQu74; arc=fail smtp.client-ip=198.175.65.16
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1747075739; x=1778611739;
  h=message-id:date:subject:to:cc:references:from:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=pbc9wehQ8zS5aG0Q6b+KhqXtPj52r85/8LXwzqLIkwo=;
  b=cBogQu74Rh9bJq7s8kY6LyiRgCTyCHX10/PnY33K/QnLuht2B7ABYpJM
   GdCfdPPUQE3KlH/XUG85pNH/0rFTpGe8zsR5G/NLio0U+JQsS3Im6GPkK
   f++pFLVchAOcQILXYjLoXUqdHNjNOujHm7ibAdrBt+vOzyX7CCwwDyEUx
   OtpFucG7VukwFujZ3GimQcAKrekM/4t1IyEItcq20eaQWysyteclxG9Vq
   lh8Y1MvI9kj3M/wx9Acg8wAu8wOdhgjQ++uekIwJuDt8gegNVIA5NI02N
   XuGTxb7LLklebYC1r/LOOp3UqyVar24W4rjfqF/OumEPF45rNf0TFsvNv
   Q==;
X-CSE-ConnectionGUID: Lce3ybYhTuyRMabI33mP2w==
X-CSE-MsgGUID: 0LRrnBv1T4eE3tUQZ+E14w==
X-IronPort-AV: E=McAfee;i="6700,10204,11431"; a="48966765"
X-IronPort-AV: E=Sophos;i="6.15,282,1739865600"; 
   d="scan'208";a="48966765"
Received: from orviesa001.jf.intel.com ([10.64.159.141])
  by orvoesa108.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 12 May 2025 11:48:58 -0700
X-CSE-ConnectionGUID: D3zshIQdTTeUr4hkNRZupQ==
X-CSE-MsgGUID: p/FB+urUQg+N1WzoNWFehA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.15,282,1739865600"; 
   d="scan'208";a="174598477"
Received: from orsmsx903.amr.corp.intel.com ([10.22.229.25])
  by orviesa001.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 12 May 2025 11:48:58 -0700
Received: from ORSMSX901.amr.corp.intel.com (10.22.229.23) by
 ORSMSX903.amr.corp.intel.com (10.22.229.25) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.14; Mon, 12 May 2025 11:48:57 -0700
Received: from ORSEDG602.ED.cps.intel.com (10.7.248.7) by
 ORSMSX901.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.14 via Frontend Transport; Mon, 12 May 2025 11:48:57 -0700
Received: from NAM11-BN8-obe.outbound.protection.outlook.com (104.47.58.175)
 by edgegateway.intel.com (134.134.137.103) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.44; Mon, 12 May 2025 11:48:57 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=W0tZ24v/S2io30pPixyjTLvxKsezlupME16iDlBoW6LeqLvWVcwd6rcrrmKfCKzXrkaxMgfUn73qY0KLlAUk7KNgyEhz7xeib0BKd9BtijwIViHuO9kprDnk7CgwUCZ1LKtfpc7Y3V0KjC8mNzG8V1bD1lCzf6YeYrNp0HD2YS8bOUpKITYeSfatGjNhG9y+3k3TWZZ5PcKpiA0frPSgXbNl4UoGjUC/KHud/6/cOwiXmIBhkLzCEnWPGq3UQG705m2d6scc1Fk+Yia11nqoAWxq+xlv3wEhZimVmOPBQIBO7+0DeusZC/F+7sXOLnwj34Y7PEJoIg62qyijKHkhcw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=VXLTEmYWfKf8GnYvBK/vE9pDBYfIo+1B2csnBYXRrao=;
 b=NGG7Xgn2ZyURqYEBjfmUr0DmkDxF390B9qGiPPbH8fXGI55GsJgvRBcr9BHIEDaJtX522V47BJ6wLar1Ar94m0cojF7iCM8aJZeDNg/D/WprEyEIXkwjg/1F+VsLR59Ttp2jYCXMH4F/kiV1oVJ4PRS2jYEDhf8M3pIgXCtcbUxZ2kxAPv15s/PtRhCYSmiN/cVbA4iFjdikf2sqQ4d09AenqTS/rWdtPK/9I2bIw5k8chnFJGBiRFKa4pShu3pFbzHcY8KWf1ZLmvasCMdw89oIvh48qeKNwWx0JPsYu0ku92DFWPp5HvTAhtKkjYHpYLdxdnOxcDPIQDRvTfQfxg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from CO1PR11MB5089.namprd11.prod.outlook.com (2603:10b6:303:9b::16)
 by SN7PR11MB6924.namprd11.prod.outlook.com (2603:10b6:806:2ab::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8722.29; Mon, 12 May
 2025 18:48:54 +0000
Received: from CO1PR11MB5089.namprd11.prod.outlook.com
 ([fe80::7de8:e1b1:a3b:b8a8]) by CO1PR11MB5089.namprd11.prod.outlook.com
 ([fe80::7de8:e1b1:a3b:b8a8%5]) with mapi id 15.20.8722.027; Mon, 12 May 2025
 18:48:54 +0000
Message-ID: <1fc956cf-8bc8-4822-90d3-9d8200e483b0@intel.com>
Date: Mon, 12 May 2025 11:48:52 -0700
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net-next v4 5/5] eth: fbnic: Add devlink dev flash support
To: Lee Trager <lee@trager.us>, Alexander Duyck <alexanderduyck@fb.com>,
	"Jakub Kicinski" <kuba@kernel.org>, <kernel-team@meta.com>, "David S. Miller"
	<davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, Paolo Abeni
	<pabeni@redhat.com>, Simon Horman <horms@kernel.org>, Jonathan Corbet
	<corbet@lwn.net>, Andrew Lunn <andrew+netdev@lunn.ch>, Mohsin Bashir
	<mohsin.bashr@gmail.com>, Sanman Pradhan <sanman.p211993@gmail.com>, Su Hui
	<suhui@nfschina.com>, Al Viro <viro@zeniv.linux.org.uk>, Michal Swiatkowski
	<michal.swiatkowski@linux.intel.com>
CC: Andrew Lunn <andrew@lunn.ch>, <netdev@vger.kernel.org>,
	<linux-doc@vger.kernel.org>, <linux-kernel@vger.kernel.org>
References: <20250510002851.3247880-1-lee@trager.us>
 <20250510002851.3247880-6-lee@trager.us>
Content-Language: en-US
From: Jacob Keller <jacob.e.keller@intel.com>
In-Reply-To: <20250510002851.3247880-6-lee@trager.us>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: MW4P221CA0028.NAMP221.PROD.OUTLOOK.COM
 (2603:10b6:303:8b::33) To CO1PR11MB5089.namprd11.prod.outlook.com
 (2603:10b6:303:9b::16)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CO1PR11MB5089:EE_|SN7PR11MB6924:EE_
X-MS-Office365-Filtering-Correlation-Id: d42c6efb-250f-4022-a477-08dd9185a528
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|366016|376014|7416014|7053199007|921020;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?RUpkVC8raktVS3J1WEV5RXZ6eWFQTFdNSmZyNFpZaVltODNqRWtwMjBJNjNh?=
 =?utf-8?B?QVVQS0JvbXN5Q0dTSkpYRS9DcWt1dkxhUndPVEc3RS9QTm5SVVNFRkFwM0p1?=
 =?utf-8?B?aTRjVVFETHhuSFlWVktGU2d0bXBIVis5cEtSdnZJRFRydHlIbG9oNWQzTmFS?=
 =?utf-8?B?QVFGamszcWs0dHk0cHF3d0pRbFRUL09sQitVdmlsKzRoWmtEYkZPbmIvckhj?=
 =?utf-8?B?V0R4MzFVR1BGZis2QUhvaUIxK3l5NFBKL29zRGlqMlZhbThMTVNITjJEVThB?=
 =?utf-8?B?M2VKN1FxYXZaOEJVVFhFMU5EalQ0aExOUUdMZFNDVEFCM3hoYUplOW1mSTAr?=
 =?utf-8?B?MnVlcFFaakRxenFyNEZST1F2eWE0NDJub3RuRWFUT0hlazh6RGRwZWJxRWNp?=
 =?utf-8?B?M3JQajRuUDBkWEdjcCtKOUZkTG94cmlWVDBiaTF4STVBcWZKNDJSWFVIaTda?=
 =?utf-8?B?WnRMejdNUlBuS1BoMWo4bkZlcDBsb1kwbHVJVjJ6Wmx3NEtCR2NKcXBVa3RZ?=
 =?utf-8?B?V25jdmVqUkVJZU0wZkk4Z3FNQUh2VjZtcE5Ec01XNW55U05KZldDNmR0cWFY?=
 =?utf-8?B?US85TTQwandmTExUSUYyV0tLSWM2Y21ZWDREY2hPVzRtT0s3eHJJcnRObE1r?=
 =?utf-8?B?ZXBoT1NHYzBkR1dhdDc3dy9qa2U3K1hEdDBTQUxvZHdYdXowWVBwQjQxV1Fx?=
 =?utf-8?B?MzRmN2M3ZnhTMEJFKzVGdTJwa2txam9rbUVLUWhac3VDRXUwNGh6amFWZWp1?=
 =?utf-8?B?bERoNENIRHBSWHZSeWlNMm5iZXVFeGtVTk9tazdRNGhCS21jdXdlcURwbk9L?=
 =?utf-8?B?UDdWWStONjJSOGNmVm1LODAraFhsZ055WHFaaVJORkhqUmp1Vy9aMTFnK3M5?=
 =?utf-8?B?djR5V2hPckdHeHg0VXFPcm9OZG83VFUxa3hCeEhNNXM0OEhaVGk3Z3d0dnBs?=
 =?utf-8?B?YTQ0SnhlNWpDdTAxT3Y5VzFGNE94TTRXNVBMYUd5dFFRZnYwcnNOdENWUk5I?=
 =?utf-8?B?QXZRTVRsR0tEVk13UTd2NU9TNnJYc1h3dGRoM3Q4UzhEaTFHblJGTHhoSHVR?=
 =?utf-8?B?b1A5L3VHaStUNTlDNUNodGcrOHB6N0VjU095bHk3V2RnZnowWnZlc204YUFW?=
 =?utf-8?B?aURlWWVnODZaQi9pQ0tXcmNFUTlaQlVCQ1JkTk1vdGZndjFSWHlyLzhVNThJ?=
 =?utf-8?B?MjYxSmJVRXhyMlFwZFpsKzM0QTRnVUszejZ2dmRXN013WmdWcWxNZXNuUFpR?=
 =?utf-8?B?UnVONE1XMmlwMU9YVzVJYzBWS2VSUVNoYU1IYndpeFVNVWExMmdwemM1SjVZ?=
 =?utf-8?B?VUxLcm5HQ3A0VzY2Mis5LzlxczRXd1RNT1F2YUk3d1QvVm1yMkQ2WXdKcThW?=
 =?utf-8?B?N3F2d1dYOHRoTzNLOW1WNGI5WjM5UVZ3Sm5PcTdEbldVM3k2N1R0VFRNNng5?=
 =?utf-8?B?RmM3MmdXL1FqVHR1aFVvY0pPSi9pUmJURENPYlYrZG4xRnVSenUzVWJ5VkFy?=
 =?utf-8?B?L2NmRUM0QU10NHJaaUUvU3lQK216bE4vTUtlUEhTUHVEdlVXNFdIckRMaEsr?=
 =?utf-8?B?ZnVNWjFLb0h5N1phUFZZby90TnR4SnEyYi8rc2xoeSt4VllEQktTSTVPNnVh?=
 =?utf-8?B?Sjlnb1VNcFo1dVAyVG5kQ2hUQUIyRjlNR21NaVk2MHRBYXJkZnkvMHhwT1RO?=
 =?utf-8?B?TUNiUVVDZ1gySVpvTUduVHB6MnNoZXErQ3BXekQxZkpLeEVndERmNis0WmJ2?=
 =?utf-8?B?c2hzditxYjRrdjZMK0tib3dQTnpZTzdmSDBYaHB5dEpMb3Vld3ZQK3RTbkdh?=
 =?utf-8?B?NEJ5VFdXeks4QUloWDgyd0dmZWw1M2Z4NEFmWC9NYm9ZWTY4dksrSWU5dGpt?=
 =?utf-8?B?RGNzaEZHMGp2ejlkS3hLUlNKL254ZGw4UHJ5RHcyaUZ0VlFydlZpNU4wWXhz?=
 =?utf-8?B?S0VhZUpEVDJKTVh6Unk2ZHBHMjNyUWRNdG5mWEcxNjBwMmlVV2phakVhYklD?=
 =?utf-8?B?T1NPNDFhbmpRPT0=?=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CO1PR11MB5089.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(376014)(7416014)(7053199007)(921020);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?TG40eURjMXVuMzNCZ3ZuL0RTMElVcmJWRVgyZk1mclBxTWdsM25EMi9QYXdF?=
 =?utf-8?B?K05IdG9uWFN0NDBMa3RnOUIrZlpEQlB6U0tMcnEvdzc1K2JFcDk2NjZvZHJx?=
 =?utf-8?B?Z2ZVVWYzYVlyK093c2trZHdnb3JHclZJZDB6QjlTSG1oUm52Uk1XaGMxVVhQ?=
 =?utf-8?B?NGxrOGhHTWFRaWFxTWNId3RuUHpCbCtKM0QwUnRKRHlrRC90NkZXM2IvTHdO?=
 =?utf-8?B?TjNnMDYrS0Y0aGtOdktKRDN5QXVPeWZwK1hVVktnYnl4bXRpSGRsbVVuNGoy?=
 =?utf-8?B?TzdvZjJXSmh6elRhdDRGRlU2cEU0ZTg2aFJ4Q3RsU1Zqa0hDTTl6NUxRRFBo?=
 =?utf-8?B?UGRxYU54eXQybG1aZTdQd2hKRTRCNnZ6UmJyNjlSR013M3E5Y0dkemJSUTI3?=
 =?utf-8?B?RXNIUmFSTUVOUFRxbGo3UkJ3S0NydjBMWU9PTlRJcFF2SjV6d3NtZ3JVcm92?=
 =?utf-8?B?ZzE4V0UvWUk0eUlCcVlKKzFtRXRlcTFFYzN5cW5tUDZ1MHp1VjlkdWpxSEZo?=
 =?utf-8?B?TnREZXdNcWpNbkEzQUVnUWdpUjVuSTdjQlFqODc0LzZnWWtPUU1RVGk0V3Nu?=
 =?utf-8?B?VDlKNXlteExOMGtLSmw1eTFGZVNhS0tHQS9DTFJycWJzaERZRGd0UjBacEFR?=
 =?utf-8?B?VTMxaUJVVi9LK09PSmsrVTBNdW9oRkljTmtMdzZsRFpuZEtnSStsYVZ0YWtM?=
 =?utf-8?B?bXRVM20wcnVuUm1La3NDV2ZKRjJLeU0xWlZpT0NtZURBOGxqNGplMXFuR3p1?=
 =?utf-8?B?U1RzbDB2YmNwS0hBQi9iQ3NKNkF4NUh3K0UrSFRYL1JBdWpOYi9hVWYxeU5n?=
 =?utf-8?B?QlQ0cnduMmJqV2duU2YwTVp6aXJUK2k2VTI1UGd1R3NYZ3Awc2FQUDF0bEty?=
 =?utf-8?B?Q0lRQ0xsVEM3NUdpalg4VFdpeFJwSnI1YW5JV2RZb3lnajFxeHdDSzY0NkVs?=
 =?utf-8?B?OGM5K0Y3OTFOOGJIa21qZ2EweEhUMHdSdzFOMUxoWXJNeFFueHh5TG9GYXZ4?=
 =?utf-8?B?K000Z0hTTFJlc2pKSG51OWVkcFdQTTBOaG53QW1aV3NhKzBRSW1va2tJSEZx?=
 =?utf-8?B?QTZxN2VUekhjZzZsQk9iY0Q0VjkySVBOdGZ4NFh3RVN5Ty9jamg2ZnJ0Mmxx?=
 =?utf-8?B?T0NvS0E3azJKN0tocWNpVm1ONmhUaTBwRUR6OFQ2RW9wWG5uNXNJSXVHNTlM?=
 =?utf-8?B?WG1mRmxqK0drTUFmSkhORldPN2NCenNxQmw5aE1LcXkyOVpRTXBSbi80K1ky?=
 =?utf-8?B?QXdKZGx3UkxPMlpoOWZhWEtJWkFON2VlVnc5Uzhxb1dzamZ0VUx1YTlKcEsv?=
 =?utf-8?B?TjRGNFRMVGpmS3JBTW81cDNuTXNaenNmVjFEZGRBN0NzdmY1NUVUVkZ4aDll?=
 =?utf-8?B?OWdneUtUcFlROTM2NXpZalZjOEtBcVlGVjZwSzV3cUUvUCtqa3c2dVBscjl5?=
 =?utf-8?B?eWN6N1RSRXd2aVdKdXdlM0MrNUpKRVRRVVpHSk5iSmZHWjJMa1VtMXZoejV6?=
 =?utf-8?B?ZG5XbHBvWFZiNFRMRXEvOXkxL1FST0N4Q3dqNllyU0dWcllZVWIwVVhXZEZl?=
 =?utf-8?B?TUdBdSt4KytsWlhnRmE0Yml2R2daZXR3NHN0U0tyNmxiMXkvakptOGwzcGp3?=
 =?utf-8?B?bHpKdk4yWWV6cExlRFJOZ1cxV0hqL2ducmJUZDlmZ1lLZ0NWT2RjeVBSRm9a?=
 =?utf-8?B?NHY4VHFPeTVyU1lORFdld1JSZjlXZyt0VS9ESlZMY1JGQlVyWUJWUTYwc29Q?=
 =?utf-8?B?bTFrdWorbmQ1ZEpzaW1GOThBZW5WUTI0SjBtZkVMR1B2OWdXQUtGNlhlMnlz?=
 =?utf-8?B?UE5VMGZITXg2TnRSTVRGTStrdVVFTlhTQUZxYlB5cERQUDdUc1owUFFTa09L?=
 =?utf-8?B?MzBoMG5RNzhwWXRKc1l1L2M5bnBsNUFCNkFqWTNMcHRGQ0JaeUpDMThoVnVP?=
 =?utf-8?B?M05iaXBpSk5kWUgyM0luRWsyUUJOQ2l4TVlXdk52Vi9CaDQ4bTRDRGcrU2wy?=
 =?utf-8?B?aHlBKzE2ZUhqQzZhUHdpSmRWSVBIalg1VVNkKzhldjU0M2hUaGE2MUVDRHZa?=
 =?utf-8?B?OHkrMnhkQ3BWY29IMWorRnFDYXdMektOTExFS1lrRU5Vb1kwcGdPNnl1RmxR?=
 =?utf-8?B?c2RHMkpjUk5DaG8xS05nKzJuek1mWFpvQzFZcFBXcUJaQWdsZVY2NVJNMSs3?=
 =?utf-8?B?MUE9PQ==?=
X-MS-Exchange-CrossTenant-Network-Message-Id: d42c6efb-250f-4022-a477-08dd9185a528
X-MS-Exchange-CrossTenant-AuthSource: CO1PR11MB5089.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 12 May 2025 18:48:54.5135
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: lFxEtTumiITDfXpx/dIIsV/bgXw0j9XzH6caU80cQJ0kahGzRJJvTj0hXKW/+EsIE8VUvujku8JnasuhbwXZsBr89NC5WdispDNPIXd/U1M=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN7PR11MB6924
X-OriginatorOrg: intel.com



On 5/9/2025 5:21 PM, Lee Trager wrote:
> Add support to update the CMRT and control firmware as well as the UEFI
> driver on fbnic using devlink dev flash.
> 
> Make sure the shutdown / quiescence paths like suspend take the devlink
> lock to prevent them from interrupting the FW flashing process.
> 
> Signed-off-by: Lee Trager <lee@trager.us>
> Signed-off-by: Jakub Kicinski <kuba@kernel.org>
> ---
Glad to see the work I put into the lib/pldmfw is able to be re-used!

Reviewed-by: Jacob Keller <jacob.e.keller@intel.com>

