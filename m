Return-Path: <netdev+bounces-92275-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 8C3008B65B8
	for <lists+netdev@lfdr.de>; Tue, 30 Apr 2024 00:28:42 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id B89701C20C81
	for <lists+netdev@lfdr.de>; Mon, 29 Apr 2024 22:28:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CCAB6194C67;
	Mon, 29 Apr 2024 22:28:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="UW1dGACz"
X-Original-To: netdev@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.14])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 009951836CF
	for <netdev@vger.kernel.org>; Mon, 29 Apr 2024 22:28:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=198.175.65.14
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714429717; cv=fail; b=IyvAhGe10SX3V+kM0pAPIK9X7rsOaccaNAGsHPLJJUP/VMIJ88sx6+LiVCQIVWXvBqQVj4B0QsTvy1g+O4W68u6ovfLho9REGnYZiV8ywOgov7/R64VLylcl2RubnHZ7b3zsZS20DVgz4XJFRnw2GIF2HJLurULLQwSNdWhq4SU=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714429717; c=relaxed/simple;
	bh=/6bWSYHRFZCCtkKV9pdjwjVtHEvUnjD2OoIM826ygM0=;
	h=Message-ID:Date:Subject:To:CC:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=XS8RTsy/7ndBMiAt9QmIxt8tUwI+BJkbwZpKzsvt4Y/2om3RQWslZauC5a9WYVn/TcPPRObpTMLJSdBZ+6LX6lyMGkCqZ+hhp9ggGQevYrjag7DPY4jbw3LB/piQ9Gva+zqBAIbyDoFYAtxeokTbizgAH95I7M8lbYoWCNAbS1g=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=UW1dGACz; arc=fail smtp.client-ip=198.175.65.14
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1714429716; x=1745965716;
  h=message-id:date:subject:to:cc:references:from:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=/6bWSYHRFZCCtkKV9pdjwjVtHEvUnjD2OoIM826ygM0=;
  b=UW1dGACzQHoriz+oVXILfXA07h1Mqlh9tKcLP2kHo8ujEd4aSdhuep0v
   VepjXWjbK2Gx5c4RSgEqbYACH57U0YwAfrfIWjqRMn4onyZCp0A6pIkg8
   CwQJJYnW/uW8ThtngufS+bNIbh5BnGh0YW3ZJ6esVoO8RIh59D/hqV/sI
   r1E6aq3Wp8jG9vanS5wC7A3IF3kvYv0GQBWr8mtytZRLAAFxp1gCikhI2
   HBlxk36wa4VWinSE7hhRmVIo24tDPPm3ljnFGioiJaeCf0Y+iw7y6qc8R
   Uvb6383PqYViDQN8EFd0je4ULJavsc8vt0ZR7oEHMQ93lKW6KS1sEKe9l
   Q==;
X-CSE-ConnectionGUID: 3KPKY/TDTXKH3lijvC7UoQ==
X-CSE-MsgGUID: 8WgXImCxSpCL3oYGXzyhnw==
X-IronPort-AV: E=McAfee;i="6600,9927,11059"; a="13938482"
X-IronPort-AV: E=Sophos;i="6.07,240,1708416000"; 
   d="scan'208";a="13938482"
Received: from fmviesa002.fm.intel.com ([10.60.135.142])
  by orvoesa106.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 29 Apr 2024 15:28:35 -0700
X-CSE-ConnectionGUID: pG2SrxJ9RmeRTqkOuCnQDg==
X-CSE-MsgGUID: V5Ue/q56QMiheOQQEz3PJw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.07,240,1708416000"; 
   d="scan'208";a="49451717"
Received: from orsmsx601.amr.corp.intel.com ([10.22.229.14])
  by fmviesa002.fm.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 29 Apr 2024 15:28:36 -0700
Received: from orsmsx612.amr.corp.intel.com (10.22.229.25) by
 ORSMSX601.amr.corp.intel.com (10.22.229.14) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35; Mon, 29 Apr 2024 15:28:34 -0700
Received: from orsmsx611.amr.corp.intel.com (10.22.229.24) by
 ORSMSX612.amr.corp.intel.com (10.22.229.25) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35; Mon, 29 Apr 2024 15:28:34 -0700
Received: from ORSEDG601.ED.cps.intel.com (10.7.248.6) by
 orsmsx611.amr.corp.intel.com (10.22.229.24) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35 via Frontend Transport; Mon, 29 Apr 2024 15:28:34 -0700
Received: from NAM10-MW2-obe.outbound.protection.outlook.com (104.47.55.101)
 by edgegateway.intel.com (134.134.137.102) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.35; Mon, 29 Apr 2024 15:28:34 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=O0nKFIP4umWj5kYj4863ZKWnPu4z0PuaHmiFZ7FRvCyfyba+DhsEeIC+vvbOgTNu91NSWxV/vyFqjaJDp1vAjYrpWPVcSzV5zsupFi6g82vwXA6IR3qaDcJoTgKDUygNh/rnkS2ZJk9V9/t8Bqr++LHRZAZp4qZMN3BOcIZN2IF4JPMNZtkhFG88q/PzLKoxCyS8P0cmi5QeaMK9ENz/ty3UhHcgMc2dcsb3TwD9DsgLAb1daIBx9Bs/9rMxDPGYXEaAxkK5iqPxbXyNZRrp/mrJfSOGC3WvGxFi3V/vP1gvTRqjtCNBwbnau9n/Ef2hszQdZG+SQXKUMF8gNeJa+w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=AsuQ05LP3wB/gDXbh3LLpABFhH4z6HqbKjJMTnqNChQ=;
 b=AffFPuK5B/7z8PF1u2yk//I4U1bcllriT8teWeE/cajkZ/L4yVNsVmRf6buX+tEFEQMzVugAgufeUDgo0uU2OnuFOr517Zs8jHwaC09JiVsygoJhMjqOxSTwnng3F7YLOTIgM4lv3gbYR03MLxMsKOYbDf59v6pRJRWxoDfGzpIf92lRIVLv/EZ2MRZ84qO+Sr6Iy0YVZcpuD1Lw6EbtuiaWaQhVs6DnsJvRgxIygDG4/Vz61rV2o/z9mYnPOpOUyU1Z2oQ38IILNRwTM9a1O8aefjpU6Gld43O11R1FBgTCgHzTG0jiT40L5hLJ2Id/1ZVEP+2HUr5h3O+3gYT1cg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from CO1PR11MB5089.namprd11.prod.outlook.com (2603:10b6:303:9b::16)
 by DS0PR11MB6400.namprd11.prod.outlook.com (2603:10b6:8:c7::6) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.7519.34; Mon, 29 Apr 2024 22:28:27 +0000
Received: from CO1PR11MB5089.namprd11.prod.outlook.com
 ([fe80::b383:e86d:874:245a]) by CO1PR11MB5089.namprd11.prod.outlook.com
 ([fe80::b383:e86d:874:245a%5]) with mapi id 15.20.7519.031; Mon, 29 Apr 2024
 22:28:26 +0000
Message-ID: <cfe84890-f999-4b97-a012-6f9fd16da8e3@intel.com>
Date: Mon, 29 Apr 2024 15:28:24 -0700
User-Agent: Mozilla Thunderbird
Subject: Re: multi-function devices with global/cross-function interdependence
 (Was Re: [Intel-wired-lan] [PATCH iwl-next v2] ice: Extend auxbus device
 naming)
To: Jiri Pirko <jiri@resnulli.us>, Jakub Kicinski <kuba@kernel.org>, "Russell
 King" <rmk+kernel@arm.linux.org.uk>, Sergey Temerkhanov
	<sergey.temerkhanov@intel.com>, Greg Kroah-Hartman
	<gregkh@linuxfoundation.org>, Michal Schmidt <mschmidt@redhat.com>, "Thomas
 Gleixner" <tglx@linutronix.de>
CC: Przemek Kitszel <przemyslaw.kitszel@intel.com>, "Temerkhanov, Sergey"
	<sergey.temerkhanov@intel.com>, "netdev@vger.kernel.org"
	<netdev@vger.kernel.org>, "intel-wired-lan@lists.osuosl.org"
	<intel-wired-lan@lists.osuosl.org>, "Knitter, Konrad"
	<konrad.knitter@intel.com>, <kuba@kernel.org>, <gregkh@linuxfoundation.org>
References: <ZiedKc5wE2-3LlaM@nanopsycho>
 <MW3PR11MB468117FD76AC6D15970A6E1080112@MW3PR11MB4681.namprd11.prod.outlook.com>
 <Zie0NIztebf5Qq1J@nanopsycho>
 <3a634778-9b72-4663-b305-3be18bd8f618@intel.com>
 <ZikgQhVpphnaAOpG@nanopsycho>
 <3877b086-142d-4897-866e-e667ca7091d7@intel.com>
 <ZiuNxivU-haEQ5fC@nanopsycho>
 <39daba1e-5fbe-495e-8398-200434f89230@intel.com>
 <Ziuvjj8h7GzsL9RF@nanopsycho>
 <698dd861-951b-44d9-91b0-5a39a953857c@intel.com>
 <Zi-KwL3WJrJd3zdR@nanopsycho>
Content-Language: en-US
From: Jacob Keller <jacob.e.keller@intel.com>
In-Reply-To: <Zi-KwL3WJrJd3zdR@nanopsycho>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: MW4PR04CA0236.namprd04.prod.outlook.com
 (2603:10b6:303:87::31) To CO1PR11MB5089.namprd11.prod.outlook.com
 (2603:10b6:303:9b::16)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CO1PR11MB5089:EE_|DS0PR11MB6400:EE_
X-MS-Office365-Filtering-Correlation-Id: 344074b5-7d47-4968-ef58-08dc689bb01a
X-LD-Processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230031|376005|1800799015|366007;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?WVRvdkRtdEJNYXpvaERteTdQcTgxd2pVM0RBR0c5bGRsVUNITk9aRmxGTWlq?=
 =?utf-8?B?dk11N2t5REdXRTByTjM3OVlEbnJOMk9BQTQvUFkwR0pJMjFiM3ZaN1k3OTdz?=
 =?utf-8?B?YjhkUks1a0VleDBrTEd3VzY0akVjMFBTcUo1ODlXVmxyYmU3eC9rVlJoTUo1?=
 =?utf-8?B?SXZKdUZxK2pnZURtK244MGVqbTUzaWpXeXJNZE1IMS9BR0g4azg5ekZUL3lD?=
 =?utf-8?B?dXpFZ3Z2N2R4UE50eTN1d0R5dGJyYXVXK0tQbWovRDlJcmkxLzlFM3hlVVVR?=
 =?utf-8?B?UHp5SEVvbjN2Ym5hMmNib0JaQXJqZ2RxY1grVkJkdStlS2RkVjdLUU1LcVhU?=
 =?utf-8?B?RytrT0wvOW1jSE5FdWFKQS9ISU9IK1ErbGkrOGdpNWdOZW5DeUpLWWFML0No?=
 =?utf-8?B?UkxQRWFFaWYzcU9ZcEx5ZmszV1BKdGUzZ2pGUmtpWk5lNmJ4dkpvOVVCNisv?=
 =?utf-8?B?Y2hDVzhRU0VEMWdtanNvRTZ3UUYvVytBSERsdXFrMkFkMnFldHpIMXRqdzM3?=
 =?utf-8?B?YW9DUGUvNU5XcVh2OUtoUVY2VlplVzN4NVYwMnVsRXFmTUQ2bkZLa29YQ2hq?=
 =?utf-8?B?d1UvWmxaKzFWUm9NTVY2ZmhLMkVGSHR1RTg4T2VmQngzcmt6a0IrWFBoRDl4?=
 =?utf-8?B?d0pZMXhITDd4d0NpM0ZDTlFSd0N4aTFOTEpOKzFYUWFyeEZWNWNlZ3l0SHhB?=
 =?utf-8?B?UEtBUmRvcTQwcmlydlljWFB4dk9KdnFNL0s0K3htQVBCcEFWejBtWHBKM3pj?=
 =?utf-8?B?d3pvMWxmaDcwQ1c1RUN2RStCN0xIeU8rVWp4SXRvWTR5R2cvSWNBcitESVAr?=
 =?utf-8?B?N0F5Y21CejJMWnIrZHNtME4ya2lNK1ZJdjNNWDc0TUxyeWZKWitiRG10Y1VF?=
 =?utf-8?B?d2xiT01jdDgyd2Vpc3g0aUQ5Vml1SWMzb3FkVlNDTk5BcFRtemFTc1JQV2hx?=
 =?utf-8?B?U0RFdUlYazY5dlZ1YXdJbFRpMDJPOWh6Qlp6aFFPU00rV3U4enN3WGdlV203?=
 =?utf-8?B?c0J2NUlGNXNXVHZYU3FaKzNNK29Na3NVdmpvWXdQcjZjZ0FlSEJKVXBlT3BL?=
 =?utf-8?B?ZFQ3U2kvaWk5ZHlLU2JRRXpJL29ROGUvbUxjU0xsWEVHNnhuUDg1SjVqWERK?=
 =?utf-8?B?Z0ZaTFA4UUkxd0QvaXRtcVpoUGJrQmxOT01tTmI5LzZUdHNOV2I1eUpBeDFY?=
 =?utf-8?B?TDB2RG5SZXhZaFlEa29nT2ZFZUQrMGtYRnFDb1VCVTJpeWtzc1NuTCs3OElV?=
 =?utf-8?B?L0JhNFZVbXhTMWUwUlYxczBuaDczL2dqNDNId0NXWTRKQnFCSUpWNUJOb09n?=
 =?utf-8?B?VWtIeXJCajlzZlpRcHkvYmswM24zS0pnSWpTL0VJaks1SGVRRE1PcWk5M0Y2?=
 =?utf-8?B?QWQrUi94QXJSSm00NXZvK1NIRENLdHUzczJraEpKd0ZKVFV4Qk1vNGRVVHpS?=
 =?utf-8?B?aW1zT0lOY1U3WHNrWnZiQTNOcUNZdGdJempVUjI5WXRKOCtNcmdRbkZRT1pH?=
 =?utf-8?B?ZEFKYTByaFNxdEFvWnlidkhQZkppM2YwQW1mNUQ3bkpqWGFWT2JMSHNrYUJs?=
 =?utf-8?B?VDB0VnROSy8vZlFpc1ZaL3pISWkwM0ZVT3lpdXY2SHdBN29yQnJVV3B5Ykxr?=
 =?utf-8?B?bVlBRzFtRHhMcWNJWGx1ZHJWSTRoMmgvaUZCeU9WOVc0L3pqSW5vcWFwY3NG?=
 =?utf-8?B?ZWs0OU1IQi9NQjBBYUNiK3BabHIvTnF2cW82SkpSTVV5bjJKVVBQNE1GSTNK?=
 =?utf-8?Q?BMddk9RYp6Xt+A3mP4=3D?=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CO1PR11MB5089.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(376005)(1800799015)(366007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?UUhoVkFiaEJEOXpHNGZSWkZqaktmTFN2L2tqWUxIdTNMdlJPU0NGS20zdCtn?=
 =?utf-8?B?MTIzWlZra3BpSmxwNFJ0MElOL25VbW9TcGhFVFRheElGSGlnMzZQeHRsdHZX?=
 =?utf-8?B?QTFwa2ljMXNJbm5WVVhXRVdHY0s2YVlrbW8wdXR4eFVuaUw2MVlWQnJqUUth?=
 =?utf-8?B?OWVaaW90SzJsYndJREg2aWdOR0Rpb0VKMXhIQlBtVzdzalRDUGpDSFpBcDNG?=
 =?utf-8?B?eGp3eE9tZjljTmNoRGtkREJ1UXJaa0ZQVHJUV3FudzBvbjNMNy84VDNkeWdm?=
 =?utf-8?B?R2xGRmpGNkcxeWdGdUVDM2VlMzc2c0FhYVUxVmluYytYNHNNN2FkdlNiTzVB?=
 =?utf-8?B?b2x4NlF1bjhCYkNsZUFsOEt4bFd6L0tJTzZ0dkVuaDdMTEw0L2cwMlVnRXFp?=
 =?utf-8?B?aVlYMmFqb1hncWUwdzgzQWVaZHcyWUl3aUVneDZPenA3bHVXNm91dm5vbzRQ?=
 =?utf-8?B?NGJOVWVubkhURDNQVkVtVzZqUUROMGg1aDJoOFpXK0Z0MjZMT0NEWm5zUjR0?=
 =?utf-8?B?eXZBZnlKSzcxVmN0anpJTlhvUmlPb1hjTUIxUTUrd3BjMXZYZGdEVk04ZHJR?=
 =?utf-8?B?N1I2b3RpU29pUE1wcGtXK2N5bVdGK0JkaUJTVXgrd3Q2UEhqTkw1SW9ZOFB1?=
 =?utf-8?B?S0Z6NUVhOFlQQkMybkRkQTMrb0RmN1NGelNteWl1R0ZhWFM0L2w0aVVyb3Rs?=
 =?utf-8?B?SElaWHhSUU5Db3ZrdnNJMzZZL0hTdmV6ZFIxdjMxL3R1MnE1MTYzMDBDSSto?=
 =?utf-8?B?OWU2RlpybndJdmRFOENmOHlyQ1ZzdEU1emVNa3Jmb1Z6K3F4aUFsK3NnMDQ0?=
 =?utf-8?B?WXgyYWx4bFJKK3Rjbm5MdXJPT1JwMjQzdHR4MWpDWFRNYzlSS1VTYWRKaFFI?=
 =?utf-8?B?a2UvaGV6NXRiQTdRWDRrbmhXc1J1T1A4QXdTQWZJTW1OamRrMk5VSmhDWFpZ?=
 =?utf-8?B?YXdPeXkyVGpYWlhhRmdmODk2MFZpV0pmTGsvN1owS0FaVGxmdWdsMEFxNTIr?=
 =?utf-8?B?VDNZbUlSWHpoKzBvVUFITW80OVQrMHlXYU5vaGpkK1M0VVdVVW5xMXdsV2Jr?=
 =?utf-8?B?NjZPY0pGUk9nbXlCa0NYaE1salpHTkZmc0RBQ3E2SnVzWGhUMmc2emkzVERj?=
 =?utf-8?B?SG9Vckg5SUkxaTJsQi9sOFFxb3hXR1cyUVozbm8zeVZYM3RORHcrSWVlM2hB?=
 =?utf-8?B?MHNpcFcwbklpeVA5YWhXcDJFRTFubFFrQm9jYW85T3pqZnQ0UHY3L3hCcUpz?=
 =?utf-8?B?K0RYazZnUDZqS0ZkNUNPaDhoMkhDdko5N2Nkb0FockhWczlsUGM0RTloWmxF?=
 =?utf-8?B?Wkg2RWxBMVZUbnFCU04wbFYyaWYwcUI0MVNyRlhCSDhvSlQ1WE10b0pxTkVr?=
 =?utf-8?B?blJNNWxCc1UzMmFNT3NEWEtCYmdoUjF2alBUYXFMV2crY0tsOXowNVg5ZXRT?=
 =?utf-8?B?aXJVeXlaN1d4c0ZGL2lUM1R0bU9KWHJRM2F0TWttcmV2bUU3ZG1mQVhGZStO?=
 =?utf-8?B?Z2UvQ2NmY1lwOWhSaWNidXo2UWdldVEyQUw3OFZDdTRDWFJ5bHpMQUE3a0ZB?=
 =?utf-8?B?ZmtHUnoyWW5vNFlwVHhQZGxlYkxnMjVCNHowQWg0QUV6M1RzM1dtRWppb0c5?=
 =?utf-8?B?bzNqUzl6aEo0RlUrbTh0OHVEakdRMFVPblhZeHdQZHZibmVpRlkyUnBrL2hR?=
 =?utf-8?B?em11OGVtZlFoUHpBOE1YVXRxQ29qQjhtOVVXbmxtOWNqS1lrMHFxRzRBeEdW?=
 =?utf-8?B?VzYvQkQyKzRlK3h5Q1Q2MHUxZmY5d3NkSkJpbjlkN1FFNW9vSTRrdXlXd2M5?=
 =?utf-8?B?UnpCWkNranBkNHlocXExYXNLK0hxYTBuNUtxdFBrTXdNTVAxN0xiYWc0Q2Yx?=
 =?utf-8?B?QjliVzZBcFYwM0tuMWZmOXpmbk40alhKOEhvTyt3Q0xneGkzY0pZY0VlNk9k?=
 =?utf-8?B?SXZLYVhHVDIza1Y1VXJVU2RoaVVKa2ZJNWZhak5EZUs3Z0ErcmxYamplenRx?=
 =?utf-8?B?YzFMYk5RNUhWby9YbWoxNzlidlFJTGhyaWlUeDkvbkR4Qi9JTGZGR0NIVGZG?=
 =?utf-8?B?aEJlVHRlN2FaN202VjNESWJpQVNBeXNGaGR0QlBXYXFaTUc5UDZKZlRPZmhE?=
 =?utf-8?B?eWllOFBHQ29TOG9WUmZ0RzV1b3I5Nm82bWlKb0dKWWw3YzBEYVd0dHFTVWxq?=
 =?utf-8?B?YUE9PQ==?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 344074b5-7d47-4968-ef58-08dc689bb01a
X-MS-Exchange-CrossTenant-AuthSource: CO1PR11MB5089.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 29 Apr 2024 22:28:26.4923
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: epJ98OYXKaTZPCtffmcyvdbPcpAaO8KtKjmYsq/poOq3YkT5hNNZvDXW8Rj9lmg6z69BUKeTQBEw+k+fBJ2BHsgg7w9EhJMH75BEKV29R3s=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS0PR11MB6400
X-OriginatorOrg: intel.com

Hi,

I'm attempting to widen the audience a bit for a discussion about the
ice driver and its current (ab)use and future of using auxiliary bus to
manage cross-function inter-dependencies.

I've included the latest discussion with Jiri, but the full context can
be read from lore.kernel.org:

https://lore.kernel.org/intel-wired-lan/20240423091459.72216-1-sergey.temerkhanov@intel.com/

There is also related work from Karol for the 2xNAC case discussed below:

https://lore.kernel.org/intel-wired-lan/20240424133542.113933-26-karol.kolacinski@intel.com/

As a short summary, ice is currently (as of at least commit d938a8cca88a
("ice: Auxbus devices & driver for E822 TS") merged in v6.7) using
auxiliary bus to handle some challenges we have when dealing with the
multi-function hardware that has global functionality that cannot be
independently controlled by each function. The specific context is the
IEEE 1588 PTP Hardware Clock functionality, but there are other areas of
the device which have similar challenges.

Other auxiliary driver and bus implementations are intended for
abstracting some device functionality into a separate driver. A single
module creates a bus, and then devices connect to it, each device then
talks to that driver.

In the ice model, each PF that owns a clock creates its own bus, and
then each port (including the PF that owns the clock) creates a device
on the matching bus for that physical PCI device.

As part of developing a new product, we were refactoring this auxiliary
bus implementation when Jiri pointed out that the entire use of
auxiliary bus seems incorrect. We are generating the bus name so that it
includes information about the PCI device, in order to ensure that ports
connecting to the bus connect to the driver "driver". In addition we're
basically *only* using this to get a reference to each driver without
really providing a coherent logical separation of functionality.

The future 2xNAC product complicates things even further, as we have in
that case multiple chips on the board, called NACs, and each of these is
a PCI device with its own functions. The hardware clock on NAC 0 is
connected to NAC 1, so that functions on NAC 1 ports share the same
clock domain as the functions on NAC 0. So in this case not only do we
need to tie functions on the same multi-function device together, but we
also need to in some boards to tie two sets of functions across two
devices together.

Jiri's arguments in the above thread have convinced me that we should
not be using auxiliary bus to solve this problem. It was never intended
to solve this kind of problem.

Fundamentally the issue is that we have a PCI device with multiple
functions, but these functions are not fully independent. Some parts of
the functionality cannot be correctly managed by all functions at once,
and functions need to be aware of what the other functions are doing.
For PTP, this means one function controlling and exposing the PTP
hardware clock which is used for timestamping across multiple functions.
There are also various global registers which modifying affects the
entire device. This is not managed very well in the existing drivers,
and breaks the simple PCI model of functions being independent devices.

Recently, Michal added struct ice_adapter to the driver. This is a
reference counted structure which each function acquires as it loads,
based on the PCI information so that all functions on a device get the
same ice_adapter. Sergey is currently investigating refactoring the rest
of the PTP logic to use ice_adapter instead of auxiliary bus.

Jiri also pointed out the component logic in drivers/base/component.c
which seems to be a subsystem extension to manage a related problem of
multiple devices that work together to provide functionality of an
aggregate device.

The component code doesn't seem to quite match what we want for ice, as
it requires the aggregate device to register. In the ice case, we might
have 2, 4, or 8 functions each with a pci_dev and then no struct device
to represent the combined adapter.

I also have considered something like an extension of the PCI driver
model to allow adding a combined instance that manages the device so
we'd have a sort of like "adapter driver" and a "function driver" or
similar. Jiri pointed out that the problem feels a bit more generic and
sort of "above" the PCI layer though.

Essentially, we want something like a device subsystem improvement where
we can have each function register to connect to a combined manager
device which can control the global functionality of the device. In the
2xNAC case, this would need to cross both NAC devices.

It is likely we can extend ice_adapter to do this for the ice driver,
but this would then be a bespoke device specific solution. It also
doesn't provide the struct device. We could re-use the struct device
from function 0, but then we aren't really representing topology of the
connected devices as neatly.

While the focus is currently on the PTP case, there are also some other
bits that could be improved such as exposing only a single devlink
instance for the whole device instead of one devlink instance per function.

I'm hoping we can get some direction on what method we should pursue,
and possibly pointers to folks who might have an interest in this, and
could help us figure out the path towards a better solution.

For now, Sergey is going to continue prototyping and experimenting with
the ice_adapter implementation.

Here follows the most recent part of the discussion:

On 4/29/2024 4:55 AM, Jiri Pirko wrote:
> Sat, Apr 27, 2024 at 12:25:44AM CEST, jacob.e.keller@intel.com wrote:
>> On 4/26/2024 6:43 AM, Jiri Pirko wrote:
>>> Fri, Apr 26, 2024 at 02:49:40PM CEST, przemyslaw.kitszel@intel.com wrote:
>>>> On 4/26/24 13:19, Jiri Pirko wrote:
>>>>> Wed, Apr 24, 2024 at 06:56:37PM CEST, jacob.e.keller@intel.com wrote:
>>>>>> On 4/24/2024 8:07 AM, Jiri Pirko wrote:
>>>>>>> Wed, Apr 24, 2024 at 12:03:25AM CEST, jacob.e.keller@intel.com wrote:
>>>>>>>> On 4/23/2024 6:14 AM, Jiri Pirko wrote:
>>>>>>>>> Tue, Apr 23, 2024 at 01:56:55PM CEST, sergey.temerkhanov@intel.com wrote:
>>>>
>>>> offtop:
>>>> It will be a good hook to put resources that are shared across ports
>>>> under it in devlink resources, so making this "merged device" an entity
>>>> would enable higher layer over what we have with devlink xxx $pf.
>>>
>>> Yes. That would be great. I think we need a "device" in a sense of
>>> struct device instance. Then you can properly model the relationships in
>>> sysfs, you can have devlink for that, etc.
>>>
>>> drivers/base/component.c does merging of multiple devices, but it does
>>> not create a "merged device", this is missing there. So we have 2
>>> options:
>>>
>>> 1) extend drivers/base/component.c to allow to create a merged device
>>>    entity
>>> 2) implement merged device infrastructure separatelly.
>>>
>>> IDK. I believe we need to rope more people in.
>>>
>>>
>>
>> drivers/base/component.c looks pretty close to what we want. Each PF
>> would register as a component, and then a driver would register as the
>> component master. It does lack a struct device, so might be challenging
>> to use with devlink unless we just opted to pick a device from the
>> components as the main device?
> 
> If I read the code correctly, the master component has to be a device as
> well. This is the missing piece I believe.
> 
> 
>>
>> extending components to have a device could be interesting, though
>> perhaps its not exactly the best place. It seems like components are
>> about combining a lot of small devices that ultimately combine into one
>> functionality at a logical level.
>>
>> That is pretty close to what we want here: one entity to control global
>> portions of an otherwise multi-function card.
>>
>> Extending it to include a struct device could work but I'm not 100% sure
>> how that fits into the component system.
> 
> Who knows? we need to rope them into this discussion...
> 



> 
>>
>> We could try extending PCI subsystem to do something similar to
>> components which is vaguely what I described a couple replies ago.
> 
> Well, feels to me this is more generic problem than PCI. One level
> above.
> 
> 
>>
>> ice_adapter is basically doing this but more bespoke and custom, and
>> still lacks the extra struct device.
> 
> Correct.
>

