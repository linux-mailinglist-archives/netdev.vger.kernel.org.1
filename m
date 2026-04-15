Return-Path: <netdev+bounces-278873-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id gIJjOvgB4GltbgAAu9opvQ
	(envelope-from <netdev+bounces-278873-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Wed, 15 Apr 2026 23:24:08 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id 62C83408234
	for <lists+netdev@lfdr.de>; Wed, 15 Apr 2026 23:24:08 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id ED4E6303076F
	for <lists+netdev@lfdr.de>; Wed, 15 Apr 2026 21:24:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6BB8B330D28;
	Wed, 15 Apr 2026 21:24:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="aMjSR2NP"
X-Original-To: netdev@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.14])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 026DF29ACC5;
	Wed, 15 Apr 2026 21:24:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=198.175.65.14
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776288245; cv=fail; b=HjFaVEjmlVt9/sZtgJCSpO1m6VjpuNC4XxPPj+F+/6I3Dss5xx/2SUVpMoouggUivG8bWuLzplTDNuL1YInc1frzCUaskwZXrS3DUPicL2ISMkp51RZBZdlUNntKuZjJs4DuRqMapCLBz+NjCKwQd58npauZJW7gT5QNbs7r9Rs=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776288245; c=relaxed/simple;
	bh=x6u0aG0d1yadygxVcRtRmsGrmT+rIuIgWc5+l+gSzm0=;
	h=Message-ID:Date:Subject:From:To:CC:References:In-Reply-To:
	 Content-Type:MIME-Version; b=ekRSY0+EWmPLioN/RSIMUTibWPJW/TEWGR+f8YvaurUnGNw6oo12yucuqJds9q3FAMct8BTBf1De8YVixgve73OWFOpiw8y/IMjcyQXIhSBt8L6UGNlJEtYKWuFHW36UeRUeeyoJMQEcDdP1mg0/YoYa3IxyjrkgEyTHtvH+Eqw=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=aMjSR2NP; arc=fail smtp.client-ip=198.175.65.14
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1776288243; x=1807824243;
  h=message-id:date:subject:from:to:cc:references:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=x6u0aG0d1yadygxVcRtRmsGrmT+rIuIgWc5+l+gSzm0=;
  b=aMjSR2NPG/DXGJf0oTftoyZddJRA6G6FqZzJhIgDZW4WN8XPtvcfsC2Z
   +Q21VXrGlPDWbHBroDsT4XpVY2NS6kzRSdPyb+xiLQ+Fnn/eNACjKDPCi
   QKq1aef3ru+NTyj/SLZv+n2Ukb1ApYlIrHZV/62ZRUFEjVlfr17c+vHEg
   kt4TwA27KDTs6XK2FqdbHB6doTi36c7t/ACjFu++fzp0fm6a1O4K3jvfK
   agfdn7wqP0ok4GRSZnnczI65ARKTsItq65Hjh6tJfjiTfoIOvllyz94Yi
   A4TXBnNxQ2NygNJtveYt0A5bmv65+PCo1tIg9SMQbB25LlHaxaOJPhmVS
   w==;
X-CSE-ConnectionGUID: 1ovFMkbuRcOYxFMZ4fl9nw==
X-CSE-MsgGUID: oTqYj13pTwqAJWjdsyfTfA==
X-IronPort-AV: E=McAfee;i="6800,10657,11760"; a="81152422"
X-IronPort-AV: E=Sophos;i="6.23,181,1770624000"; 
   d="scan'208";a="81152422"
Received: from orviesa007.jf.intel.com ([10.64.159.147])
  by orvoesa106.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 15 Apr 2026 14:24:02 -0700
X-CSE-ConnectionGUID: GPI58w7DRcei/tfUEhK4JA==
X-CSE-MsgGUID: zYDc6/gtRVW7TCU/LGF+9Q==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.23,181,1770624000"; 
   d="scan'208";a="230777224"
Received: from fmsmsx901.amr.corp.intel.com ([10.18.126.90])
  by orviesa007.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 15 Apr 2026 14:24:02 -0700
Received: from FMSMSX903.amr.corp.intel.com (10.18.126.92) by
 fmsmsx901.amr.corp.intel.com (10.18.126.90) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.37; Wed, 15 Apr 2026 14:24:01 -0700
Received: from fmsedg901.ED.cps.intel.com (10.1.192.143) by
 FMSMSX903.amr.corp.intel.com (10.18.126.92) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.37 via Frontend Transport; Wed, 15 Apr 2026 14:24:01 -0700
Received: from SA9PR02CU001.outbound.protection.outlook.com (40.93.196.58) by
 edgegateway.intel.com (192.55.55.81) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.37; Wed, 15 Apr 2026 14:24:00 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=IoFCYkptTsc0SerPlYXY1/nqWKoWuB72IHXXwt26/6plR+yHIuRHOuJ2l0QSEHkKf09Ae7DnkMBBtWUTAar4/H0jb2WK034o3179yZLg2AMlOH1egpdtjKnGYzEbE2kAcgA1jMd9nYc+Gqu+FI+pM9wQhcIqIdiwQSmnWoSGfqX/IXCqowTPmjTqNkeO53bUJ5o6tKGAfeXNmgtFJubV3XaniOIp74JdfjOLITiMY1HMSZPQRza0yz43w44IxVC+ubDc7hu7iscCESaslE1asTDHO/R/BtxifOiE0rIomiOIbLTfC5hHkleSdmdDW9s8RXFSTpJQk0+s6Gc32tPRWw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=4aeY6KNeuZkjQ86ehcQ577perAhKwLIgsVl3aRyb2Yw=;
 b=Imyvia/G4wJCdQUe6cWST7hOh9R3ydsbdDT8U+qw0DCWCDc/OTGRCHGY9WVjoIY9gT/2Z/bEjUB7J4oVgy/Xp2yVlxDUdkdlxHCNmEpgfQacy5HhackY31IwnBqR1Gl6sMnXoj9Td49bdr6wSHSR7aJiTnjQesB/DFg7BVAW8KJguSfpvpn5UgrZvfJW8cQ+wAH82/gh4IfTrshfeE+xbrFetU/+jND97ntXRrd+4Kcgd27B8aymx1T89Nxhwqud21O8BaWTljyijXHU+sGyieXceAayt6m7smDuBkcUpZzbg7+Rgl1INn5gyYkGQQxsIrLtLnCbCbY7ypa4rDVMOA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from DS0PR11MB7579.namprd11.prod.outlook.com (2603:10b6:8:14d::5) by
 IA1PR11MB6097.namprd11.prod.outlook.com (2603:10b6:208:3d7::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9818.17; Wed, 15 Apr
 2026 21:23:56 +0000
Received: from DS0PR11MB7579.namprd11.prod.outlook.com
 ([fe80::4199:4cb5:cf88:e79e]) by DS0PR11MB7579.namprd11.prod.outlook.com
 ([fe80::4199:4cb5:cf88:e79e%5]) with mapi id 15.20.9818.014; Wed, 15 Apr 2026
 21:23:56 +0000
Message-ID: <363a062f-4e73-4492-adef-98687b53f5b1@intel.com>
Date: Wed, 15 Apr 2026 14:23:52 -0700
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH iwl-net] ice: fix infinite recursion in ice_cfg_tx_topo
 via ice_init_dev_hw
From: Jacob Keller <jacob.e.keller@intel.com>
To: Simon Horman <horms@kernel.org>, Petr Oros <poros@redhat.com>
CC: <netdev@vger.kernel.org>, Tony Nguyen <anthony.l.nguyen@intel.com>,
	Przemek Kitszel <przemyslaw.kitszel@intel.com>, Andrew Lunn
	<andrew+netdev@lunn.ch>, "David S. Miller" <davem@davemloft.net>, "Eric
 Dumazet" <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>, Paolo Abeni
	<pabeni@redhat.com>, Aleksandr Loktionov <aleksandr.loktionov@intel.com>,
	Nikolay Aleksandrov <razor@blackwall.org>, Daniel Zahka
	<daniel.zahka@gmail.com>, Paul Greenwalt <paul.greenwalt@intel.com>, "Dave
 Ertman" <david.m.ertman@intel.com>, Michal Swiatkowski
	<michal.swiatkowski@linux.intel.com>, <intel-wired-lan@lists.osuosl.org>,
	<linux-kernel@vger.kernel.org>
References: <20260413191420.3524013-1-poros@redhat.com>
 <20260415163003.GP772670@horms.kernel.org>
 <f30ad78e-1eb9-4c9d-9034-c8873966de66@intel.com>
Content-Language: en-US
In-Reply-To: <f30ad78e-1eb9-4c9d-9034-c8873966de66@intel.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: MW4PR04CA0195.namprd04.prod.outlook.com
 (2603:10b6:303:86::20) To DS0PR11MB7579.namprd11.prod.outlook.com
 (2603:10b6:8:14d::5)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS0PR11MB7579:EE_|IA1PR11MB6097:EE_
X-MS-Office365-Filtering-Correlation-Id: b2b85555-e6f9-40e9-1587-08de9b354cd7
X-LD-Processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|366016|7416014|376014|22082099003|18002099003|56012099003;
X-Microsoft-Antispam-Message-Info: ZXeAnMaH7g5Gk6F0lWXdO0EX0YPaKPnIQB3B7h8a4PKChYXzRO19wYs8EBzTZlekQV7N7btGuCu5QHTKv91H4BRJdubKITQHAvgioJYYYVmBO8hNEQcLT0vmJLX6byU2nB4+FIxpk4ClEUyxdZbxOkUCvl840kkJU3cke6wleX8qndfdH19lPp0czAisWlW9c2E/68GX3cUMOpv+R5kOC9HeqY68CFYMlZi3gqpJhdR6RFjlFIm17yLmpCp+giKcOUvJ1Y/5ApYYj4PxXRkgzxmvBWBgAQc+igCsqbOE2kFgKHFkx+Zkyc+aA0bVNgkGZZnblzmmqCHxtJG4pbL1y4vJaTdAomy6Zb+/Ae3GMX9V/RBCArwyqIASmP746li4mLgy388zLLi+/rYz6+onlMytmnfBqRqVjjVmoKwqde9xnQa7PvpjkIRNJAK/eeQeFlD45PkUwHuaRuFsZ6Lynv9b6AAAQ0Y9zNbdG9JTIoqr+miJQ2NffZY0MQT+1igvWMkoh8Gl6e6QDZNMBeQOFDM7gkdeWp4mAQhMIJT+OtRcA98akp57680Hx/DFVDm9+oZ3mzc3XBp+5EYaN/E27KNjXUbWq3tzf7WSLuqZ7D+MlMfeTkObC+hKLjeSDl0n8R5N2sBZqOqEi4PFiszUs840uRkhrMkV5xZvZ2r6VQ+9HbXx2mD0DElJoR5nZdG1FXzdHiT+ZrCLXq24cNbtRDRuNVajWcklLQsu0JEX9W8=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DS0PR11MB7579.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(7416014)(376014)(22082099003)(18002099003)(56012099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?OE40dW5IREZJRUV3VVNnZ242a0gwcXlLNFN3a2hkaERLdmdpM1FOcEZYU3Zh?=
 =?utf-8?B?REVabkxpQS9hY0xrNDAydFVlSmtQbVlFcndVVGFzNXBnL3lqbGw1bDJ5ck9X?=
 =?utf-8?B?eUZtTVU3aUZBWVkyOUNkS0p6Vko0bjRWSUo0cGRQVnBHSmVjeHVwOGcrMkgy?=
 =?utf-8?B?QmdUUzlHUlZvUjJRTHZsOUN0OS8ycmYyVERLWEllVHFKTENDcjU4eFQzV3Bu?=
 =?utf-8?B?RWVxOFJxRU5qbzBOYmduZTZuSGJFUlJjbWZCRWtIYnNDbTVSb3hsaXBVUXlq?=
 =?utf-8?B?T3NqRHFVdFFwN2RHamFWcHRlYyt0bE1hQXFjSDc0OFF4TFkwTVR1c0xIZXVn?=
 =?utf-8?B?b0k0ZG13U1BDK201aHBBNVRYT04zdEIzTmxEYmZkWE9ncnV2MUpJdzM5UlRC?=
 =?utf-8?B?Z2xEWjJuR3NxUkpsUXpXTlkvVXNZSDBIalcva3dJNHh5UC85UUYxUkFjQ2I0?=
 =?utf-8?B?SkY2a0pCbUYzcTJSbmwya3RPdEpkN0NENVhsejJUQ1ZFWXB1Ti9rbXJuK0dv?=
 =?utf-8?B?ZHdzZFAzMHJPL1RDVE9uRGNMb3VwU3RXWUt3SXFlSmpicnpmc2V2eFV4MEtU?=
 =?utf-8?B?K2dQZ2phbDJtTUhta2JOVURjcUpCRWdsakFkYWtPTTFRM25TR212NlVFWjE2?=
 =?utf-8?B?K0hJUEZsTUM0N2VJdDl6TXZWOHZHYzJuTTF6OW5KUjA4VThHR1ZQUytYVGt5?=
 =?utf-8?B?d3hSd0dERjJaTFFCVFFranAvZm1tZjZOMmZFclhrMVNLN0ptbkxaMlRybitS?=
 =?utf-8?B?b0EraUZlVGx6WXhCdlZ1RFAzQ0lCbTBneGV3R0dheER6MUZRRkI0SWx3N05F?=
 =?utf-8?B?VERSWW5rR2RFV3VpSkloSHJuK1Jlc1pwVE15RDZJNmgzZEtnTkxQQ01YbUNj?=
 =?utf-8?B?YlNXUmRLbytCSk1EY0o5UWFVcUVPdHhTb2hLcWJLdlN5dWFnTW9KZlVvNWZQ?=
 =?utf-8?B?eDBFWmFBOTR0TlJDbnI4MTlmUjhtZ1RXanBTUW14MmJpN3BkekNvSjg4MmRi?=
 =?utf-8?B?QUxKUEtGWnFBYnpPWURjcHltdWtJZ0ZBemJycXFkb202bG5qazBoUTYzWnNr?=
 =?utf-8?B?UXpaZTZJRG13Ym4vU1ExbERFdDJleUs5MWhmM0VTUllleFdRSE4wTzhDT1BK?=
 =?utf-8?B?cStXTUZXaWVqQjVYeXRTTW1VY2Q4dDhqc3U5bVRjK2V5Y0ZRcmNwaFdWQ1NH?=
 =?utf-8?B?eWt2VlpYejEyemRyVWRpUHRqb0M4dk5xODlLdDVLUFZDblB3K0RqVTQzcmNl?=
 =?utf-8?B?Y2QzMW9LRFlUcUI0NkFyNUsyNlo5U3dUTEl0K0ZzVzUwdzgzSlBTS1J2U0V6?=
 =?utf-8?B?T0VXUkJhYVhTcndvb3d4M084RDVWRytzTzdWUGVNbTFkellxUloxTTE4dFh1?=
 =?utf-8?B?MFptYjVUZnRDQ2FwbmVRZVJhSW9qTmJPdU9OWnc4Mmt6ekFYdlQ5ZWhIS3A4?=
 =?utf-8?B?eHZvTmNIWTZ6bVFJdzh0aE9IWlg1WVFzK256ODgzK29rWXRqMEdaTS83ajhy?=
 =?utf-8?B?K05yS0xNSFJtWUxlTnB2K2kxRDkrUUEvZzQyZi9tU1Q1a0NES0FKQ0JNWFYx?=
 =?utf-8?B?Mkw4MVNRVmR5aHFPeG1LNVppRjFoV3V2SVFxR085U1ZlUllVaUh2aHFhTmFm?=
 =?utf-8?B?V2czVTJ1VCtmWmhqZDhNeS9jcUdLaWtPYkludlZ2Zmg1Zk50S1JUK0ZTSXNn?=
 =?utf-8?B?Tkk2NE16YlNPTHFvNnBZNSs3R0s4MFRlQ1JHZzI3OUdBcytkRE1IWWtjSGZn?=
 =?utf-8?B?RXRaRjU3ZEdYRS82S1hlR3lEV0k2L01zYXZsanJiZ0RiN0lBWC95NkVRKzQr?=
 =?utf-8?B?bll4Wm55a0FhQTdjTzJwVllZSXYvczMxSm1HbWU3VVRsb0ZtUVByUng2ZUJI?=
 =?utf-8?B?K1JQMUZhejg3ZzRJYzVNZDI2N3E1dThQZE9pOG4xUEtCQkVrVzd4cG1lckhB?=
 =?utf-8?B?LytQdElPVEs2amdaUmdycjdIU1JFM1RrVHRDaTJPVmttdmpEMUc0NjV0dmlt?=
 =?utf-8?B?Y1Y0TmJTL1pKcmgvMWJNcGh5SWEvRndFTXZFTDFDMzI0Z2U0d2JXeTViS0Q4?=
 =?utf-8?B?SFhRdFhWYi9TUmF2RHdhRit1aVV3ckZ6cTB3N2kzdytoM2paQ200Y1gySlBs?=
 =?utf-8?B?TG5JT1MyZE9BWmdtUTdEOHkwQU9DZ0tOTnNybXA1dTVxRWxOSldYWUtrNXFh?=
 =?utf-8?B?NmhBd1VXaDVZdkdENUREOG51Q01tVm5FdlFFekUrMko4aWJxL1dJL2luR1Jr?=
 =?utf-8?B?aHVYRms1S0o2YnFobEU4cnp1WmNDWkdvNmtRS1Rjb2dyZVI5Q29GcXZJTUpB?=
 =?utf-8?B?VU1OcDBrWk1BTmRpUitqcmlwR2habzl6Y1c0WVNVZ2cxUEd5c1d0Qi8zck5F?=
 =?utf-8?Q?JGdVEJwZHyTI36DA=3D?=
X-Exchange-RoutingPolicyChecked: T3roxbFIWS62CFG+SyUDFEwxUY+b6m24IlXc8RDb1eQfT2xMWyeC7LA8ImGaBkAwYNcUXmTIBOL85L2hw7KABEetGkZJI14gDEB1qOZJabdyUoMYxC16K+KOUju4S964jHdofUnOQDnF0adQXcZBFix9Vsi8xy2YBrkUjUk30/bHJldY905V8U0+ztmpA75axG/f/mvGzDJLiwLFf6nsXKXonRBvFcAk3+QOpkmZ9naXUPE8vno/eRWERnPqP9spLuCdsRHsw2llhlpiFGJpF3omn1V3EywWi8yDPLzv2rn4pLAGuFeiq9b4z9l2Bn5LF63Ft0H087YLmSjfBHi+LQ==
X-MS-Exchange-CrossTenant-Network-Message-Id: b2b85555-e6f9-40e9-1587-08de9b354cd7
X-MS-Exchange-CrossTenant-AuthSource: DS0PR11MB7579.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 15 Apr 2026 21:23:55.9634
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: xJ4f++2aM6TtKY2fqPtVM13ihrfHF/lBl2B55GveakwWPEPonh4d6BtubwImCXJ8EM4GRY+8qtT6hTQYbZZ+x4vp7pgjNhcz928DZqBJlVI=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA1PR11MB6097
X-OriginatorOrg: intel.com
X-Spamd-Result: default: False [1.34 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_REJECT(1.00)[cv is fail on i=2];
	DMARC_POLICY_ALLOW(-0.50)[intel.com,none];
	R_SPF_ALLOW(-0.20)[+ip4:172.105.105.114:c];
	R_DKIM_ALLOW(-0.20)[intel.com:s=Intel];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	MIME_TRACE(0.00)[0:+];
	RCPT_COUNT_TWELVE(0.00)[18];
	FORGED_SENDER_MAILLIST(0.00)[];
	TAGGED_FROM(0.00)[bounces-278873-lists,netdev=lfdr.de];
	FREEMAIL_CC(0.00)[vger.kernel.org,intel.com,lunn.ch,davemloft.net,google.com,kernel.org,redhat.com,blackwall.org,gmail.com,linux.intel.com,lists.osuosl.org];
	RCVD_TLS_LAST(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[intel.com:dkim,intel.com:mid,tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[jacob.e.keller@intel.com,netdev@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[intel.com:+];
	NEURAL_HAM(-0.00)[-0.999];
	TAGGED_RCPT(0.00)[netdev];
	MID_RHS_MATCH_FROM(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.105.96.0/20, country:SG];
	RCVD_COUNT_SEVEN(0.00)[10]
X-Rspamd-Queue-Id: 62C83408234
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

On 4/15/2026 2:22 PM, Jacob Keller wrote:
> I'll take a look as well. I recently included this fix in Intel Wired
> LAN update last night, so hopefully nothing too problematic...
> 

Correction, and I need more caffeine: I think I had considered including
this fix but didn't quite make the cut last night when sending.

