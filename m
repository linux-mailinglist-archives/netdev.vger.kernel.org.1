Return-Path: <netdev+bounces-300989-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id 4WIdKHLvOGomkQcAu9opvQ
	(envelope-from <netdev+bounces-300989-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Mon, 22 Jun 2026 10:16:50 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id A1FA26AD9C7
	for <lists+netdev@lfdr.de>; Mon, 22 Jun 2026 10:16:49 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=intel.com header.s=Intel header.b=mp1MvJsQ;
	spf=pass (mail.lfdr.de: domain of "netdev+bounces-300989-lists+netdev=lfdr.de@vger.kernel.org" designates 172.105.105.114 as permitted sender) smtp.mailfrom="netdev+bounces-300989-lists+netdev=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=none) header.from=intel.com;
	arc=reject ("cv is fail on i=2")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id E3BF4304B8A2
	for <lists+netdev@lfdr.de>; Mon, 22 Jun 2026 08:11:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 843C638F95E;
	Mon, 22 Jun 2026 08:11:51 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.11])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 900BF38F24D;
	Mon, 22 Jun 2026 08:11:49 +0000 (UTC)
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782115911; cv=fail; b=OKvGUPn90noyAkbPT+M/7cf5sP5vNv1N6aJ1nuBZtZJgqYKAds7lX169sRnRc2QwSBkfUqRoX1gDEstlh14PtfZ/XLAyyL/woJKozywZ7YlwAes4uhjAYJltNBvFbyJO2GplA3YTHe+m6PO7JxDr8rjZGMf6TV845a94N6Z8HGc=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782115911; c=relaxed/simple;
	bh=6kx1616S+BSNE+tCjV1OtigG1NIfAIJLgsXXfZAL1jw=;
	h=Message-ID:Date:Subject:To:CC:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=t/IqOQ/3rkH4fdh+j++yPTqjP9EGXhW4fWSuC68VAqRWJKR/SyLYE2WGe+VCqDUOCdFm8O/rTsKS6fIEjDVhI5JLnZCtbMTXxBQs8rhSSv30yDqWESosPzkPOo+y43DHIOUhc14STk0LMNWsMaodGZoOXvMRVEArYE1zZsSC84I=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=mp1MvJsQ; arc=fail smtp.client-ip=198.175.65.11
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1782115910; x=1813651910;
  h=message-id:date:subject:to:cc:references:from:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=6kx1616S+BSNE+tCjV1OtigG1NIfAIJLgsXXfZAL1jw=;
  b=mp1MvJsQ7JaJxgdfWSJp0Bb7ttb4zFovcJoX++bTUQA/AhtEtTAHD4LF
   8h2/gtAqdzi8KPmjeggj5fbV61p4zTEp+fDyNFxwL4Sm3ekJAaSvkBxWV
   kqX9i6YDmY3lm4quRR7ztDAqw++z2jS74B26dDhz8XOsJa/oaEedr0xvi
   yNc/APnr9ajxRYaWpbPkum9EWSNAzCj73tvtKA96A3XttwRgEWX4taoM+
   HTCi0QW7c3gA5mQ+ETRcwhBcf3ZxO673bMe5CzZK3XWVlSTRf+ITUVNWZ
   LMXAS4gMvisa4qKvKzvX+n9R2m5hDnsS98FvV+yDMERlUC0sSwmNg6bmi
   w==;
X-CSE-ConnectionGUID: KbxuygRYRBKFHqtGCwqC9w==
X-CSE-MsgGUID: xdWW7MGLSom4Lwe7sNZhKg==
X-IronPort-AV: E=McAfee;i="6800,10657,11824"; a="93206122"
X-IronPort-AV: E=Sophos;i="6.24,218,1774335600"; 
   d="scan'208";a="93206122"
Received: from fmviesa010.fm.intel.com ([10.60.135.150])
  by orvoesa103.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 22 Jun 2026 01:11:50 -0700
X-CSE-ConnectionGUID: 819bPjH1Ryyjbg/x1lXKWA==
X-CSE-MsgGUID: x9ZENP1ZTsum61n8FOEMMw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.24,218,1774335600"; 
   d="scan'208";a="245013785"
Received: from fmsmsx902.amr.corp.intel.com ([10.18.126.91])
  by fmviesa010.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 22 Jun 2026 01:11:49 -0700
Received: from FMSMSX903.amr.corp.intel.com (10.18.126.92) by
 fmsmsx902.amr.corp.intel.com (10.18.126.91) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.37; Mon, 22 Jun 2026 01:11:48 -0700
Received: from fmsedg903.ED.cps.intel.com (10.1.192.145) by
 FMSMSX903.amr.corp.intel.com (10.18.126.92) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.37 via Frontend Transport; Mon, 22 Jun 2026 01:11:48 -0700
Received: from CH5PR02CU005.outbound.protection.outlook.com (40.107.200.47) by
 edgegateway.intel.com (192.55.55.83) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.37; Mon, 22 Jun 2026 01:11:42 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Up7YVBav+voPukzvIYSU2L8iTUXlkHEJja2+MnYnCCTE3eqJXRj1ASaYy51xyaAePG5vNe1w+QwUr078zzoLjdyFNrG2+N0qU3WMXiYE0kyXlse7nbQGRUepG52svXNoF/GSkb/K2kxLlyRhPlCPS7jSx3A9SIhM6ZJ631DaPZe9EgFmzAsl05+bmSmZMDbifpnMcUNytRkkvqr19ziD9yjqIfcYiNz3jxWf9m6dAWOqhDWnO7PJWPTxezUieJx21UeLsbhv8tUe3PvmkiWWOCHiz0+Fj7uLfRYBpoQ/2tq/2afBzHB3PeUAWDJcs1t4Ivtj05CVbo4C/mWvKXZJWw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=F6ir5jVXbosxx0QXoEg81pgaLVoALPALuOajrSWAR70=;
 b=fcf3rf6MYGEqpO3SZBXOPjo+IqS9oVlG1FWYa8RArGzsjgz+hndmJZWLpaCcKaAr0tu64pY+dahCQmSwQwXliFVpznoGfYq+2pLSv1qbcUbWhPvDK++mWupUicx2FqqVJqGRLsvJu6gnNjFqBcNI+uV55dMadzLBhmduVTBEq8xbMUS3Ysic+umraSuXkoPJfa4dsCSfbI6Z2tApvBGrhmm2BOiv+o/RYBlJuZktmGQP9HUQ66B1svvHrBCiaiv7cKnNE3YkQVfP1z9sDPIS6qpvBDdckubh0UNzGKIsxwQjIoI9o0qIDFY+JLuzXXiOGe8WqlRdjrNgpf2MKb1GmA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from SA1PR11MB8448.namprd11.prod.outlook.com (2603:10b6:806:3a3::17)
 by SA1PR11MB8840.namprd11.prod.outlook.com (2603:10b6:806:469::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.139.19; Mon, 22 Jun
 2026 08:11:33 +0000
Received: from SA1PR11MB8448.namprd11.prod.outlook.com
 ([fe80::38f:6a4:ce6b:d5b8]) by SA1PR11MB8448.namprd11.prod.outlook.com
 ([fe80::38f:6a4:ce6b:d5b8%5]) with mapi id 15.21.0139.018; Mon, 22 Jun 2026
 08:11:33 +0000
Message-ID: <db5a9f18-198f-4c88-bcba-ad408252c1a4@intel.com>
Date: Mon, 22 Jun 2026 11:11:26 +0300
User-Agent: Mozilla Thunderbird
Subject: Re: [Intel-wired-lan] [PATCH iwl-next v5 3/4] igc: replace goto out
 with direct returns in igc_config_fc_after_link_up()
To: "Ruinskiy, Dima" <dima.ruinskiy@intel.com>, KhaiWenTan
	<khai.wen.tan@linux.intel.com>, <anthony.l.nguyen@intel.com>,
	<przemyslaw.kitszel@intel.com>, <andrew+netdev@lunn.ch>,
	<davem@davemloft.net>, <edumazet@google.com>, <kuba@kernel.org>,
	<pabeni@redhat.com>
CC: <intel-wired-lan@lists.osuosl.org>, <netdev@vger.kernel.org>,
	<linux-kernel@vger.kernel.org>, <faizal.abdul.rahim@intel.com>,
	<hong.aun.looi@intel.com>, <hector.blanco.alcaine@intel.com>,
	<khai.wen.tan@intel.com>, Faizal Rahim <faizal.abdul.rahim@linux.intel.com>
References: <20260507214706.309984-1-khai.wen.tan@linux.intel.com>
 <20260507214706.309984-4-khai.wen.tan@linux.intel.com>
 <58af982a-1531-43f8-934c-e83b45111b1f@intel.com>
Content-Language: en-US
From: "Kadosh, MoriyaX" <moriyax.kadosh@intel.com>
Organization: Intel Israel (74) Limited
In-Reply-To: <58af982a-1531-43f8-934c-e83b45111b1f@intel.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: TL2P290CA0013.ISRP290.PROD.OUTLOOK.COM (2603:1096:950:2::7)
 To SA1PR11MB8448.namprd11.prod.outlook.com (2603:10b6:806:3a3::17)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SA1PR11MB8448:EE_|SA1PR11MB8840:EE_
X-MS-Office365-Filtering-Correlation-Id: c2fd6e8e-bcaa-4401-be72-08ded035df79
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|23010399003|1800799024|7416014|366016|921020|18002099003|22082099003|56012099006|4143699003|11063799006;
X-Microsoft-Antispam-Message-Info: plA4y1mjmNJ5cHkrh8ljVuifZziEQ/luo2/ABEAtz8xOmUr7x/tXJzT5SsiEkELPL54Wwq32wcGwDHJf+xTbJ+yuV7NR4NzAn/B9DOBYXQY1UFog6L2RppXLy159RWbrXA8QWaB9/z49fzhOIkiCKvS1DLKeDiii9CHbWbZwpGPinUGzLX6DRkAZRAKzw0CHC7afAW8u7JXVXbVbAO3WxzQGoasrqgjtx3a5JGVYAOaDKgk/oZJUnxF6ADoFCuxcnPb7OP0BwZgDdDQ1qtF4wyc4d3zcyvD5UWAx44Op87/UuDEeODuTuc3Iz+VBqFGnyazhJYoqgzuDztczedg2rWhWrybeiguFj7gNv7HtCrvM8Fj70uWCMXkAGm8anw0H7CkjFf6SPh2GSOZ7my8m9KIc9mhJ+PLyWAqQuEiebWsu2m9QSTL5ribiGXMsnhapLklmTkraZ5cuEj+b1JiZmevjLMcAjtjC7TLNBwu1m/qtbA0v5/kJ+cfeIcStjLu8vRMBxm9nd73qqWhvoqQT6RoL/e68z0ASDgkzY0Orx/I3/r3+H2tvQfLI1S1uP152gmvFnzyU5xPD4wZLKj09QMSIAGHmZ5Cf3TmbXEQcuBz4cpneK2Z1wpKhordEAapy+/W6Rx9huhanzJyHRX/K5DPI+z1hAvR0EJFOmtsqNkBK1sktpvrW+fGEqCOZz2t/tcKyJxwc8m9DNrBuCrC0gg==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SA1PR11MB8448.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(23010399003)(1800799024)(7416014)(366016)(921020)(18002099003)(22082099003)(56012099006)(4143699003)(11063799006);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?WVZJcERVVm1SSWg3d0IvK0ZtdHpubC9uR0dYRXpKVWlBUnc5NUlDSGIwTkxH?=
 =?utf-8?B?RHI1aEh0ZVNydE12ZHJ1elRHdHV4VlFlZVkwWUF2U2RneStKanVHeEFaQ0Nq?=
 =?utf-8?B?cG1tcXJMV2lUQlAxeTdoUSt5QlRtMGFzWnphRUdlenFBSHRnZGIrN0FleDFU?=
 =?utf-8?B?RGZ0K2g4QXZjbUNTKzBiMTF0dkJUSVIyaTgvVldjSldEMVZ5ZS95bVR2QkZz?=
 =?utf-8?B?Q2Jjb2pCREpEc0sxbGhXbU1vZjd2UWNVK0U4TDdYWmpHRGJDYWNINEdJanpQ?=
 =?utf-8?B?SHYyUitVNGF4T1dqQStrU2tMRDM3NXJ2WWc2c0xxT2VsbUNjZElydjJjYzRC?=
 =?utf-8?B?b0tQZW1JR0RtNlFVR3VCdEFVTXJMMkxIdHNmWTc5SlUranRHSW8wTkRhLzU5?=
 =?utf-8?B?WUtINVNTWU5lTmNJcU9DNzJSbVJMV0tMQkxJQVM4a0l6cnY5MnhnZjdoSkNr?=
 =?utf-8?B?OHJjSmY2YTZ2MlJyWkNDZnBDdm0yR2toc2hkSk8yV0ZqR2MyTFBBSkg3T2o3?=
 =?utf-8?B?NlZuTmZtVDZYdWQwOUhOMVhCaDJSOWhlV2xnOXZOL0R6LzZXa0pobWM2L2g1?=
 =?utf-8?B?bFdRbEYwYlpwY1ZtUmtCbmhPOGtVcEgvWlFOZkdLM2gzT3ZvZkhPcDBIMnlk?=
 =?utf-8?B?YjRyc0lVMDVtVFpkaFlMOXpyWVBnbE9ZSXI3eTZ2YVVqM2pmMU5ud214cS91?=
 =?utf-8?B?eTR6bkRtazlla0E3TDBVVHNiVjUzaVBlWTlIMnVpakYrTHQ5YndqanYxUlBW?=
 =?utf-8?B?RUhwRXZ6d05WVEVHMXdxWWFRSTRLR0t1YVBRYUR1elVoK2UreHd4YzE1VGZt?=
 =?utf-8?B?ZW4yRzRWTGQ5VmZHa3RCRFJCZTh4bStpekMxUlpLVFFwc3dYYTFrVTZvMlJE?=
 =?utf-8?B?akN6WGxlZVVSV0FHSWx0YjUwM0hNMGhEQnNiTVB0TUpHaE1GbXFKK3hTeU1Z?=
 =?utf-8?B?c1ZaRjNONHZuNFFyQWs3L2wrTWF4TXJ5Q1FNcUxFMmJoZzB3M3JtK3RXb1Nw?=
 =?utf-8?B?TXB1S3FQa1pyc0hnT2lvalRETHo2YnRWWWViTVFwOGFUWGtOcDg4VXJscEFG?=
 =?utf-8?B?aE9ZeE0vVG50WW9xRlVndkRvNUhZUlAyU0hxU1luWTk3UWtiWCtPYW92bE16?=
 =?utf-8?B?QUZTY2tnRUdqVFduTnlib09JSnhSSFlFMzJJMWhDZ0dLY214T3hZSThmRnFs?=
 =?utf-8?B?MGhtWjZVMHJwcTd0OThGaVZrL2E2OGhiQjRkSG1hQ1ZvaktrVlZNMkZySmN6?=
 =?utf-8?B?eWhpdWYvT1luVmZDdzQ4Z1EvWUIxdG5BczlVWGo5QjFlWGpQSG5RTmdNa1Nv?=
 =?utf-8?B?REdZWFpLZ0hxUkV0SnlZZy9SanlrSlhjZGRSQVk1cWlBaTRsQTBPdWxZcnhi?=
 =?utf-8?B?VERZSHJ6TkNudlZsUVlmNHZsbTdoTWx5Y09CWnhFU2RYSHJINGhDQjVBaTh0?=
 =?utf-8?B?anh1bjF4dGZTeHNyVC9DUzMrbGZYNGNmSjVzZVVLMzRQLyszb1prUnFKaU9j?=
 =?utf-8?B?NStZbFYyYnZkMEZzVUtiU0ZDdXVnS2kyTzcrK2lla3VIR0NlSUJURWFPa3NW?=
 =?utf-8?B?eDdFS3dZalNONkxrWHRSOG50UXdwd1NHbkhhdlJuT1FFTTBHZGhrWlYvODAy?=
 =?utf-8?B?WmwzS2JmeGlDVmdPY2tDMVEzNWUzRUdWU3poSTFaZ1Z6a3IrbVA0UWNvUkRH?=
 =?utf-8?B?NXExU0dKSml0eSt3UWVsVmJNRUdVTTZkOHBaVDNHVjdiSmNXK1BOM0t5S1hR?=
 =?utf-8?B?Qlk3em9XblM1KzhoQXJ4enkyU3hxbnV4U3BvcVZHNjhlRmxFS1FROGxWSkV5?=
 =?utf-8?B?WDlES0V1WnBEQVpzV1RJeExmU1ZHUndES1FsNThXSFlwSkFIajZLdS9FTWt3?=
 =?utf-8?B?Q0RuYithdHZaYVBXRHpIMFl2aVFjVXI3cC80YXlPaHVNbnF6WXJMNXY2WUho?=
 =?utf-8?B?d2p4aS8xdG5IVmxSOXNBSVFoQUxnNlNKMFdmZE9ZS1RSRE9sYkZGbGxxbnFl?=
 =?utf-8?B?WEZ3WmxoRXdGa0g0OEJicGl3NHNQOXJpTnN1L3lWSTNpUkFGSHdLNjYyN29H?=
 =?utf-8?B?VEE4ZzVKanYyQ3F0dEZBcUpJTXR0ZzBCdG4rN2xLUldRNnA1OWlBRWlRWWZa?=
 =?utf-8?B?WTRnWHVJVEdFV3Q2dkdoUUJCa3g4WU43d1gxVEJxcEpSQkxOUzRHWjEwc3ZQ?=
 =?utf-8?B?UFN3eks4c0ZvcTZtei9WbHhZVEdnWVZISVJVclVPcVlsdFJwYVQyRHo4dWZa?=
 =?utf-8?B?NjFPcXBrdWw0NEp1bjJaNzZpeTZJVXJub3hwbDlGdEpVbDdyYXBnQXR6MFVB?=
 =?utf-8?B?NWZHRzI0R1pCT2hwNUU4NTFWYmROcVljYTg3d1FFZkpPbU5BcnhYZEhQTis3?=
 =?utf-8?Q?GH0T4zy9Z6hcpGv8=3D?=
X-Exchange-RoutingPolicyChecked: bzfwujYwku+arJ3pq2hLWLp4njPWxlf9dnlCwAvmlgmZmeDCZqsi9VxJSVxovuXibOS9aPk9kDpplsQ12OLaEqGVba3w021+2fUNi7wijTSd3FXdDgscACLFmaiFhIUO37SKBQOEEx0Eq6U1h/WsT1lsHt9oJKCARSpWY51oodzdePt+bT8gevbeMlkhbkfsntcw3AVd8TahHg1Z6a0lkfcEOY63TasbPuDO7vyeBojLFnf3rn/3Ax9Q8w1is89rB7SONVUdHfekmkA0t3xuTPH0Cu6vw8AUHALOMs/bDqNquHYvmRoS2sQn4RZY67delWSL24piZySwS5XltNYinA==
X-MS-Exchange-CrossTenant-Network-Message-Id: c2fd6e8e-bcaa-4401-be72-08ded035df79
X-MS-Exchange-CrossTenant-AuthSource: SA1PR11MB8448.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 22 Jun 2026 08:11:33.5736
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: dU7/bl1sg3FIcLCo9NOy9Bh5P1DelcQEEmjddE+1eIqzXMMtdpPwX1RBioBS5YFRA7NqHWLi+fo8n7AegCqWmHju13id7XnURoIB+RrKaoQ=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA1PR11MB8840
X-OriginatorOrg: intel.com
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-1.66 / 15.00];
	WHITELIST_SPF_DKIM(-3.00)[intel.com:d:+,kernel.org:s:+];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_REJECT(1.00)[cv is fail on i=2];
	DMARC_POLICY_ALLOW(-0.50)[intel.com,none];
	R_SPF_ALLOW(-0.20)[+ip4:172.105.105.114:c];
	R_DKIM_ALLOW(-0.20)[intel.com:s=Intel];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	HAS_ORG_HEADER(0.00)[];
	TAGGED_FROM(0.00)[bounces-300989-lists,netdev=lfdr.de];
	RCPT_COUNT_TWELVE(0.00)[17];
	RCVD_TLS_LAST(0.00)[];
	FORGED_RECIPIENTS(0.00)[m:dima.ruinskiy@intel.com,m:khai.wen.tan@linux.intel.com,m:anthony.l.nguyen@intel.com,m:przemyslaw.kitszel@intel.com,m:andrew+netdev@lunn.ch,m:davem@davemloft.net,m:edumazet@google.com,m:kuba@kernel.org,m:pabeni@redhat.com,m:intel-wired-lan@lists.osuosl.org,m:netdev@vger.kernel.org,m:linux-kernel@vger.kernel.org,m:faizal.abdul.rahim@intel.com,m:hong.aun.looi@intel.com,m:hector.blanco.alcaine@intel.com,m:khai.wen.tan@intel.com,m:faizal.abdul.rahim@linux.intel.com,m:andrew@lunn.ch,s:lists@lfdr.de];
	MIME_TRACE(0.00)[0:+];
	FORWARDED(0.00)[lists@lfdr.de];
	FORGED_SENDER(0.00)[moriyax.kadosh@intel.com,netdev@vger.kernel.org];
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:rdns,tor.lore.kernel.org:helo,intel.com:dkim,intel.com:email,intel.com:mid,intel.com:from_mime,vger.kernel.org:from_smtp];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[moriyax.kadosh@intel.com,netdev@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[intel.com:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	MID_RHS_MATCH_FROM(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.105.96.0/20, country:SG];
	ALIAS_RESOLVED(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	RCVD_COUNT_SEVEN(0.00)[10]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: A1FA26AD9C7



On 14/06/2026 10:17, Ruinskiy, Dima wrote:
> On 08/05/2026 0:47, KhaiWenTan wrote:
>> From: Faizal Rahim <faizal.abdul.rahim@linux.intel.com>
>>
>> The out: label only returns ret_val with no cleanup. The kernel coding
>> style guide states: "If there is no cleanup needed then just return
>> directly." (Documentation/process/coding-style.rst, section 7).
>>
>> This improves readability ahead of a subsequent patch that introduces a
>> new goto label in this function.
>>
>> No functional change.
>>
>> Reviewed-by: Looi Hong Aun <hong.aun.looi@intel.com>
>> Signed-off-by: Faizal Rahim <faizal.abdul.rahim@linux.intel.com>
>> Signed-off-by: Khai Wen Tan <khai.wen.tan@linux.intel.com>
>> ---
>>   drivers/net/ethernet/intel/igc/igc_mac.c | 15 +++++++--------
>>   1 file changed, 7 insertions(+), 8 deletions(-)
>>
>> diff --git a/drivers/net/ethernet/intel/igc/igc_mac.c b/drivers/net/ 
>> ethernet/intel/igc/igc_mac.c
>> index 142beb9ae557..0a3d3f357505 100644
>> --- a/drivers/net/ethernet/intel/igc/igc_mac.c
>> +++ b/drivers/net/ethernet/intel/igc/igc_mac.c
>> @@ -458,15 +458,15 @@ s32 igc_config_fc_after_link_up(struct igc_hw *hw)
>>       ret_val = hw->phy.ops.read_reg(hw, PHY_STATUS,
>>                          &mii_status_reg);
>>       if (ret_val)
>> -        goto out;
>> +        return ret_val;
>>       ret_val = hw->phy.ops.read_reg(hw, PHY_STATUS,
>>                          &mii_status_reg);
>>       if (ret_val)
>> -        goto out;
>> +        return ret_val;
>>       if (!(mii_status_reg & MII_SR_AUTONEG_COMPLETE)) {
>>           hw_dbg("Copper PHY and Auto Neg has not completed.\n");
>> -        goto out;
>> +        return ret_val;
>>       }
>>       /* The AutoNeg process has completed, so we now need to
>> @@ -478,11 +478,11 @@ s32 igc_config_fc_after_link_up(struct igc_hw *hw)
>>       ret_val = hw->phy.ops.read_reg(hw, PHY_AUTONEG_ADV,
>>                          &mii_nway_adv_reg);
>>       if (ret_val)
>> -        goto out;
>> +        return ret_val;
>>       ret_val = hw->phy.ops.read_reg(hw, PHY_LP_ABILITY,
>>                          &mii_nway_lp_ability_reg);
>>       if (ret_val)
>> -        goto out;
>> +        return ret_val;
>>       /* Two bits in the Auto Negotiation Advertisement Register
>>        * (Address 4) and two bits in the Auto Negotiation Base
>>        * Page Ability Register (Address 5) determine flow control
>> @@ -598,7 +598,7 @@ s32 igc_config_fc_after_link_up(struct igc_hw *hw)
>>       ret_val = hw->mac.ops.get_speed_and_duplex(hw, &speed, &duplex);
>>       if (ret_val) {
>>           hw_dbg("Error getting link speed and duplex\n");
>> -        goto out;
>> +        return ret_val;
>>       }
>>       if (duplex == HALF_DUPLEX)
>> @@ -610,10 +610,9 @@ s32 igc_config_fc_after_link_up(struct igc_hw *hw)
>>       ret_val = igc_force_mac_fc(hw);
>>       if (ret_val) {
>>           hw_dbg("Error forcing flow control settings\n");
>> -        goto out;
>> +        return ret_val;
>>       }
>> -out:
>>       return ret_val;
>>   }
> Reviewed-by: Dima Ruinskiy <dima.ruinskiy@intel.com>
Tested-by: Moriya Kadosh <moriyax.kadosh@intel.com>

