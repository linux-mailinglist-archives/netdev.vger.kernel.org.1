Return-Path: <netdev+bounces-152332-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 0F3AA9F3743
	for <lists+netdev@lfdr.de>; Mon, 16 Dec 2024 18:17:39 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id CDF8D18856F4
	for <lists+netdev@lfdr.de>; Mon, 16 Dec 2024 17:16:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 14AE5204F75;
	Mon, 16 Dec 2024 17:16:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="nHLdDIaC"
X-Original-To: netdev@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.9])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4F3CF204573;
	Mon, 16 Dec 2024 17:16:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=198.175.65.9
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734369371; cv=fail; b=NHUQMngqtKrHtcDIWEmojOrG1grCl9fVeycpOJ8BV3o7hWJVe/36pf7eeTmSVyydt9rQMIw0ADW/I4xB0DQIFgjwNbMpGv1aBcRXvK+r9zAK42aCCTAsxGKVX/pwkZwwgnkmhrvHYHtm6NqZmy06eDkL+wtnOwX/LnNF0b6tRJU=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734369371; c=relaxed/simple;
	bh=9mper91XNT6NA9I2tskFrvFInOhwuFhcLoSb8cyy9XM=;
	h=Date:From:To:CC:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=AEL2sb7IZ6CItAz5UAfCKUnj8cl4dzLJW/7GPeKenbfjGXoWW6H4TPb/JXsICPF4lMvBiSqiuy8NCiWCLoZpflYxanbRY3tNXNDJElNcm+CtX9+jHU1//EtJJa1uRKurL6sarX0KGQjCKor+W56nuBf84HMJNOUEGz3T4cN+acw=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=nHLdDIaC; arc=fail smtp.client-ip=198.175.65.9
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1734369369; x=1765905369;
  h=date:from:to:cc:subject:message-id:references:
   in-reply-to:mime-version;
  bh=9mper91XNT6NA9I2tskFrvFInOhwuFhcLoSb8cyy9XM=;
  b=nHLdDIaCm81Fi+xP1cIJNAl+sCM1MIZFxleT/yTKwBTlkd3h357OrXXj
   Y+UBBCWqI7wykF+yR7rWMzsj3xiWLlCnHQYbiJNpGaZgOy+l7ebnZlZGb
   Jq1JH00LKc7Qg1YoOLW9AwjvWbBXtPsmeeecpm211f9+auEbbmmdngxvQ
   ajMe81bPE7IqSDgp6Vj8SI+7e7Z4OEeqJPF6BOtsJ/Eb01f3RpXyvQxn/
   gnKxYezn6GLHsZZuZXFYpR6UP/mPSaABzT3dRoPmS82scKpIEvsVS7HdY
   vRIhuxdXjS/UiKz69SgRuXJ+a3qDXyEstSi5FtpEJXtZkc8qu+qouw4Yf
   A==;
X-CSE-ConnectionGUID: zPj/7VO/QQip4Hp49JxPyw==
X-CSE-MsgGUID: 7w0brI3eTw6X2nf0Yhu/rw==
X-IronPort-AV: E=McAfee;i="6700,10204,11288"; a="57247114"
X-IronPort-AV: E=Sophos;i="6.12,239,1728975600"; 
   d="scan'208";a="57247114"
Received: from orviesa003.jf.intel.com ([10.64.159.143])
  by orvoesa101.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 16 Dec 2024 09:16:08 -0800
X-CSE-ConnectionGUID: ZKGHDQwYQyS9hhI9NVJKvw==
X-CSE-MsgGUID: EggsXpbHSXCTOVDfcYWmbg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.11,199,1725346800"; 
   d="scan'208";a="102346485"
Received: from orsmsx602.amr.corp.intel.com ([10.22.229.15])
  by orviesa003.jf.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 16 Dec 2024 09:16:08 -0800
Received: from orsmsx601.amr.corp.intel.com (10.22.229.14) by
 ORSMSX602.amr.corp.intel.com (10.22.229.15) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.44; Mon, 16 Dec 2024 09:16:06 -0800
Received: from ORSEDG601.ED.cps.intel.com (10.7.248.6) by
 orsmsx601.amr.corp.intel.com (10.22.229.14) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.44 via Frontend Transport; Mon, 16 Dec 2024 09:16:06 -0800
Received: from NAM12-MW2-obe.outbound.protection.outlook.com (104.47.66.41) by
 edgegateway.intel.com (134.134.137.102) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.44; Mon, 16 Dec 2024 09:16:06 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=rM/jqyppab5bYOJknozLe9PFG/az3EfA+ABwv8lfri2jlKLAm7BbkjIjCmmN+1/yPZQRReUX9obl+fryps5NeilRpJ/w5z5VVZ89GTpHsatXUmeBDmcfLHQ+g3VcEtuLelgevx6VkUiznZuqskCZoAccxw7Pj3cnqwvME3/jf+8ZBSgiHX/a49vc2ck9RfG6fwygPW6uLuJu/dW0nqJSXX0BHpx+meaR5/UxxAPMQhZQ0k5MMOuOpVjXQG2RbZ/NS0HH2Kb4wvMaihBXAMJOY03Dz2htgFla2cAwNIZkOIQmm3lLTr/b3fR72wtzvf6DCo6Vjj3WbS9UP4n/gG9Tjw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=95DyQ0WO7KuZ7Mbuc1TAzDgAuAWe1zTuD8pi38ojrOY=;
 b=X8oO77F/HGv+epfu9ytU97WrM8EaYmVeCQRd3WKM2BtOEjlzxdYqWljNwH/BfTDR3WFoLac8gPqpilxcYXOBh2/EfB9lxQTzihlAWj/J0tFez0dlPh+7y6pZtTYt6p7UTU8NsXVXQpAmwuuHshF38cOHqGaDcrm21vP/bFVwkDbbOZ0XcY8H7J3nQTjyKsEcE5MiW+df3EcZ3rbQLY7EsFrqXmihOQ7pO6AWgE48ssNSRKzI5oyL3pw8y1ORmX0C92IZIcU92WYd85msnzhC8k4WdUmSZANX3mNefWRvtMpReEskZNAcutQRiD3uo3Hz6NJxl55NdJhMNp25D9c4+A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from SN7PR11MB7540.namprd11.prod.outlook.com (2603:10b6:806:340::7)
 by SJ0PR11MB6623.namprd11.prod.outlook.com (2603:10b6:a03:479::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8251.21; Mon, 16 Dec
 2024 17:16:04 +0000
Received: from SN7PR11MB7540.namprd11.prod.outlook.com
 ([fe80::399f:ff7c:adb2:8d29]) by SN7PR11MB7540.namprd11.prod.outlook.com
 ([fe80::399f:ff7c:adb2:8d29%5]) with mapi id 15.20.8251.015; Mon, 16 Dec 2024
 17:16:02 +0000
Date: Mon, 16 Dec 2024 18:15:47 +0100
From: Larysa Zaremba <larysa.zaremba@intel.com>
To: Parthiban Veerasooran <parthiban.veerasooran@microchip.com>
CC: <andrew+netdev@lunn.ch>, <davem@davemloft.net>, <edumazet@google.com>,
	<kuba@kernel.org>, <pabeni@redhat.com>, <netdev@vger.kernel.org>,
	<linux-kernel@vger.kernel.org>, <UNGLinuxDriver@microchip.com>,
	<jacob.e.keller@intel.com>
Subject: Re: [PATCH net v4 2/2] net: ethernet: oa_tc6: fix tx skb race
 condition between reference pointers
Message-ID: <Z2BgQ54+QOOib/Fe@lzaremba-mobl.ger.corp.intel.com>
References: <20241213123159.439739-1-parthiban.veerasooran@microchip.com>
 <20241213123159.439739-3-parthiban.veerasooran@microchip.com>
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <20241213123159.439739-3-parthiban.veerasooran@microchip.com>
X-ClientProxiedBy: MI0P293CA0014.ITAP293.PROD.OUTLOOK.COM
 (2603:10a6:290:44::14) To SN7PR11MB7540.namprd11.prod.outlook.com
 (2603:10b6:806:340::7)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SN7PR11MB7540:EE_|SJ0PR11MB6623:EE_
X-MS-Office365-Filtering-Correlation-Id: 3ff6ad55-0a77-4561-304d-08dd1df55135
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|376014|366016;
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?vUj/LPZVOmh8NVyrlTqTbLXbBg8eHxpQmtLQRvu47Ht6wZKgXMdaPtfK4JFj?=
 =?us-ascii?Q?4Bb2+Pq7XP+yx2VFSgx8dZUbwIi5soGnMJqHo7SOT1gcwfLruKoDSPFdc00f?=
 =?us-ascii?Q?KmkQ8S6dK8XnuuIHFM8OD3GSRCBr5mEpMTSCD4/Mq/IHFFaPcM/q/l7d+JYM?=
 =?us-ascii?Q?QgIGjHTPs5VsuvaHeEzfGNhWqx8NPl/YpCi+TUB8LFxauXYXSjUwJGCXuYvF?=
 =?us-ascii?Q?3a7zMW0KPrXnJhuJFQx1E2yB6c1P0EVHXA75Cx7PbHEomxrbozuhKmiw4z2H?=
 =?us-ascii?Q?y+d1RhXNHfV7HwVRW0igfiL/wAYsyu9chqOTzqGZLbhSZn2nHVx8XWHtQlIq?=
 =?us-ascii?Q?r+3iM0aZwe5tWf6Gzfz7rV1fN6MwvRJLyntyqxYTA3arPjzflvn9VLbaG172?=
 =?us-ascii?Q?KtK99KwniGQ9pvqKvIzUS36J6lfiGCx91gWekc1gCNHuiYp6RHv5u1+AA4j6?=
 =?us-ascii?Q?tFGCVqG3n1M15Zhyrw+JCDD/Wa4zlTcUddOr7FS06cGAVN+4K3DSJvlmNzI5?=
 =?us-ascii?Q?zzG8OI2TKv+JHrv+0s1+sGKfv17KC1jxCbLjrm+cijZDHilDn9c+XJEagYwF?=
 =?us-ascii?Q?h5pAihA7K8o4EsNhBc4gBMR2Moml0UNS90uOe7heBnHQ7VqSIr7n3vJRKQkg?=
 =?us-ascii?Q?AdlBGpbjxEo4QsOMRNpZvto4IoSbb5EbGyp5aj3W8n2WdO56OlVChwDE9sa3?=
 =?us-ascii?Q?+RssaydJRl4PN7N0UP/UTXPJtS2k3/ERtvP/BJoA9mBFa8rHyMqi5FmYXxa2?=
 =?us-ascii?Q?/8hfwHUxqlAVay6OX46JdwQGi0HKB9EK4r3tOhWDqZnvuJuiw4Genlj/35v3?=
 =?us-ascii?Q?rvn5vay0qfmSOlM74zXCWEjTqne5cEj+832tiyuusff8+CCGb5wzGvfxzbNh?=
 =?us-ascii?Q?wAaRxhRhUIjgy29kepAGxXiVF6GslPYA934gsDXDbfV1c9TxBGa/IKbMEthe?=
 =?us-ascii?Q?uzYsvh/LIpOpBybQrqmzNm67z+d2a5YEfvmpT7ln429HZlP2gqH+5Zf6VILg?=
 =?us-ascii?Q?+8COX65XK9LFJxNcDzec2eB+SsSBORoU1nsP4bPC5p/KJdUKSaVt/y5B3hHW?=
 =?us-ascii?Q?WYdzwFvkgKTcJQINhCoY4ImpqM3eIJYz8YJlivsYofrwICJwF4r6tGxE7LYp?=
 =?us-ascii?Q?gaTSqT5x0UEE6yGiUTyG5/yfMw0bl0kX06I6FZJUaeA7Vs0reLbh4ENLGBPA?=
 =?us-ascii?Q?zt4Yk/Edk42KmwQ7mRoVK0YbewfkLMReZMVmKoLevh1tfjRaT2crCjXv3gCr?=
 =?us-ascii?Q?akE1YOm+UdE4/9mTGNyDRNb43SI/P12e5er3/tH9zDW6RnwnUlT+vaJYaG0q?=
 =?us-ascii?Q?Km2F8U2dAMXNJ9goHR99Hgwa9U3p/ku/QO7oPVFlMTfZjLNCOxBqubHnT1hM?=
 =?us-ascii?Q?EE519wRCdiDJGvJsMi/u31OnFO/j?=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SN7PR11MB7540.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(376014)(366016);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?FRTt24cJE8BperY5Y8j2wG2JPdO35jHdAo70x8h3nVAdzfVFfzBh09Zh1FO+?=
 =?us-ascii?Q?M+uH44kmhX9TCXL86YH2+ygpxTWosiMSsDku9Izxe1Jv+F52zVISzanrigA8?=
 =?us-ascii?Q?aN803sPBBvRDxdTlDbMhvRP2A5QbOIF33Lb3BUB9Og8KB8xdKwhsRx0rC1aQ?=
 =?us-ascii?Q?vm+9EFX/frkf9+9wvdmA9DFEZdVMpYOTvZYwowII79390DvieAKTZuml155B?=
 =?us-ascii?Q?srfSn9pcsiCEs1RVA7LfLrpUHrDpRc33l5qbyN0UfT8jrJn/kxQRRsbC98Ai?=
 =?us-ascii?Q?kbKo+BIrNJqotZaf9tCnhZVxrMj3hiEYgjMOL8jNoSoEG0PN3Rvhnp46HkAZ?=
 =?us-ascii?Q?TYlcTGLBuuJc+W3IKKCCjo+dBXFhtHLphE4G+82o/ZT5L6YdfGbkuq/vDddy?=
 =?us-ascii?Q?MphI8pdHlhVtBfGWdW+yAwGZUD7eoRfG0CMQ5A4JxRSrlVQ/c3JzY90lYe3j?=
 =?us-ascii?Q?TlY/GU9D543MaDxCDf1ZPDnoMw236dTs41htXMaNVDnihtGkc/dNDaYNlYFx?=
 =?us-ascii?Q?e4CweiF8OOb+4g6emys17Cd6SodycBE07qKEijyHU3P2GSbzivI1RzyB3gcR?=
 =?us-ascii?Q?UPfkI6kbhVslOfAyHKvsXIDKrOt+Tbshkw+NItbW4UIfcPu8/F6xtLCDu0hX?=
 =?us-ascii?Q?WDlyTBBuQNeWy0g9g3rToG4zA99slnVOsSecGicu7n5lnS88EqwRTZWrm7de?=
 =?us-ascii?Q?7O7xeBqKe/PO5vQeA57ZF557Zd097LA8GJfILiOg+08kl+j1kF1bP2F51ZON?=
 =?us-ascii?Q?ISHPlJ/2+4Ixva9SaBKbrk+LvrOdnttluP+0DUnm3XMILb0WfoQ9GLQsj6td?=
 =?us-ascii?Q?f9lRpuuOj+0DjLySvztPxQufdZQCC6RlaaivDn1thN19VN+Ys1oXvKsYo7zr?=
 =?us-ascii?Q?rVDyFYJq4yEc4+Ea2IxtWvNvzbSM5D1e2wKZhJQkfUh0fPzNXTlSS5tDnv4N?=
 =?us-ascii?Q?fTrr30rrhd3N4vMlsX3WrEQxW/pKlxkFZ+ZdfzJQ5NKlCLYQYYQCj7bIuwvr?=
 =?us-ascii?Q?303AzudjNs2X4WRVmqhBOMdtnXgHC661347UIMbCWybI0NGw0oYhUeFvReec?=
 =?us-ascii?Q?jgCgBlSiR63FecsWTlEWStErFzDjOJUSmIqBS+vMCLTHiHSeYsdcJNL7/Na9?=
 =?us-ascii?Q?ioaNTWN86u6waHL+nUiYVO26NcYEIm+hC99X0+T9zSU+bf0bnO7KxOnz8hn3?=
 =?us-ascii?Q?D6ie459+kW/ae7ULcxK+YNBKbMpM/zRalIndo1/Y20oFC6YV30yZBLW1wA+O?=
 =?us-ascii?Q?vOAYpEaJmPIt349+6767Y6Rh+Ryhwat4K+DMWI7Mlz3JzRvz8GbuUFRCQrNV?=
 =?us-ascii?Q?OL/F6kcwmMOPptkWISXBX2a+BjT0I1idxobNC+Hk77UgZiyqNZGwqlanVv0y?=
 =?us-ascii?Q?rwbrbTReTAURBbNjZ+3DBve8E2LrkA6hrX4YPtXyWe60Tzn7i3yiZ9HaZLJr?=
 =?us-ascii?Q?OS4l9++aeD0wGYm8ShHLu0kuX1VyQ888joCsWAGn22UvQYMpwqpUtAMkiX4s?=
 =?us-ascii?Q?5KZTIa6GFiAKXhahuEYVlDE7rUxwsE9FE7uNLgWccjP+hnVjy/1oMgsRAe0/?=
 =?us-ascii?Q?EbJrRpQDO1lak/TnDipPs06TIPHI/rL375BCUzX3jHs2ozxEZhfrwUBjpcB/?=
 =?us-ascii?Q?Rg=3D=3D?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 3ff6ad55-0a77-4561-304d-08dd1df55135
X-MS-Exchange-CrossTenant-AuthSource: SN7PR11MB7540.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 16 Dec 2024 17:16:02.4603
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: X6FKNUYigEhUu74XrDFy5LmuVH9+7oEapln80BafgiinXZVrqDrFvTGjmNVdbtfi2GW7YYmXG1Xkiv5UsaEBBzFXEKRoQuWJXJWX6noutxs=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ0PR11MB6623
X-OriginatorOrg: intel.com

On Fri, Dec 13, 2024 at 06:01:59PM +0530, Parthiban Veerasooran wrote:
> There are two skb pointers to manage tx skb's enqueued from n/w stack.
> waiting_tx_skb pointer points to the tx skb which needs to be processed
> and ongoing_tx_skb pointer points to the tx skb which is being processed.
> 
> SPI thread prepares the tx data chunks from the tx skb pointed by the
> ongoing_tx_skb pointer. When the tx skb pointed by the ongoing_tx_skb is
> processed, the tx skb pointed by the waiting_tx_skb is assigned to
> ongoing_tx_skb and the waiting_tx_skb pointer is assigned with NULL.
> Whenever there is a new tx skb from n/w stack, it will be assigned to
> waiting_tx_skb pointer if it is NULL. Enqueuing and processing of a tx skb
> handled in two different threads.
> 
> Consider a scenario where the SPI thread processed an ongoing_tx_skb and
> it moves next tx skb from waiting_tx_skb pointer to ongoing_tx_skb pointer
> without doing any NULL check. At this time, if the waiting_tx_skb pointer
> is NULL then ongoing_tx_skb pointer is also assigned with NULL. After
> that, if a new tx skb is assigned to waiting_tx_skb pointer by the n/w
> stack and there is a chance to overwrite the tx skb pointer with NULL in
> the SPI thread. Finally one of the tx skb will be left as unhandled,
> resulting packet missing and memory leak.
> 
> - Consider the below scenario where the TXC reported from the previous
> transfer is 10 and ongoing_tx_skb holds an tx ethernet frame which can be
> transported in 20 TXCs and waiting_tx_skb is still NULL.
> 	tx_credits = 10; /* 21 are filled in the previous transfer */
> 	ongoing_tx_skb = 20;
> 	waiting_tx_skb = NULL; /* Still NULL */
> - So, (tc6->ongoing_tx_skb || tc6->waiting_tx_skb) becomes true.
> - After oa_tc6_prepare_spi_tx_buf_for_tx_skbs()
> 	ongoing_tx_skb = 10;
> 	waiting_tx_skb = NULL; /* Still NULL */
> - Perform SPI transfer.
> - Process SPI rx buffer to get the TXC from footers.
> - Now let's assume previously filled 21 TXCs are freed so we are good to
> transport the next remaining 10 tx chunks from ongoing_tx_skb.
> 	tx_credits = 21;
> 	ongoing_tx_skb = 10;
> 	waiting_tx_skb = NULL;
> - So, (tc6->ongoing_tx_skb || tc6->waiting_tx_skb) becomes true again.
> - In the oa_tc6_prepare_spi_tx_buf_for_tx_skbs()
> 	ongoing_tx_skb = NULL;
> 	waiting_tx_skb = NULL;
> 
> - Now the below bad case might happen,
> 
> Thread1 (oa_tc6_start_xmit)	Thread2 (oa_tc6_spi_thread_handler)
> ---------------------------	-----------------------------------
> - if waiting_tx_skb is NULL
> 				- if ongoing_tx_skb is NULL
> 				- ongoing_tx_skb = waiting_tx_skb
> - waiting_tx_skb = skb
> 				- waiting_tx_skb = NULL
> 				...
> 				- ongoing_tx_skb = NULL
> - if waiting_tx_skb is NULL
> - waiting_tx_skb = skb
> 
> To overcome the above issue, protect the moving of tx skb reference from
> waiting_tx_skb pointer to ongoing_tx_skb pointer and assigning new tx skb
> to waiting_tx_skb pointer, so that the other thread can't access the
> waiting_tx_skb pointer until the current thread completes moving the tx
> skb reference safely.
>

This fixes the above race condition and spin_lock_bh() is appropriate.

Reviewed-by: Larysa Zaremba <larysa.zaremba@intel.com>
 
> Fixes: 53fbde8ab21e ("net: ethernet: oa_tc6: implement transmit path to transfer tx ethernet frames")
> Signed-off-by: Parthiban Veerasooran <parthiban.veerasooran@microchip.com>
> ---
>  drivers/net/ethernet/oa_tc6.c | 6 ++++++
>  1 file changed, 6 insertions(+)
> 
> diff --git a/drivers/net/ethernet/oa_tc6.c b/drivers/net/ethernet/oa_tc6.c
> index 4c8b0ca922b7..db200e4ec284 100644
> --- a/drivers/net/ethernet/oa_tc6.c
> +++ b/drivers/net/ethernet/oa_tc6.c
> @@ -113,6 +113,7 @@ struct oa_tc6 {
>  	struct mii_bus *mdiobus;
>  	struct spi_device *spi;
>  	struct mutex spi_ctrl_lock; /* Protects spi control transfer */
> +	spinlock_t tx_skb_lock; /* Protects tx skb handling */
>  	void *spi_ctrl_tx_buf;
>  	void *spi_ctrl_rx_buf;
>  	void *spi_data_tx_buf;
> @@ -1004,8 +1005,10 @@ static u16 oa_tc6_prepare_spi_tx_buf_for_tx_skbs(struct oa_tc6 *tc6)
>  	for (used_tx_credits = 0; used_tx_credits < tc6->tx_credits;
>  	     used_tx_credits++) {
>  		if (!tc6->ongoing_tx_skb) {
> +			spin_lock_bh(&tc6->tx_skb_lock);
>  			tc6->ongoing_tx_skb = tc6->waiting_tx_skb;
>  			tc6->waiting_tx_skb = NULL;
> +			spin_unlock_bh(&tc6->tx_skb_lock);
>  		}
>  		if (!tc6->ongoing_tx_skb)
>  			break;
> @@ -1210,7 +1213,9 @@ netdev_tx_t oa_tc6_start_xmit(struct oa_tc6 *tc6, struct sk_buff *skb)
>  		return NETDEV_TX_OK;
>  	}
>  
> +	spin_lock_bh(&tc6->tx_skb_lock);
>  	tc6->waiting_tx_skb = skb;
> +	spin_unlock_bh(&tc6->tx_skb_lock);
>  
>  	/* Wake spi kthread to perform spi transfer */
>  	wake_up_interruptible(&tc6->spi_wq);
> @@ -1240,6 +1245,7 @@ struct oa_tc6 *oa_tc6_init(struct spi_device *spi, struct net_device *netdev)
>  	tc6->netdev = netdev;
>  	SET_NETDEV_DEV(netdev, &spi->dev);
>  	mutex_init(&tc6->spi_ctrl_lock);
> +	spin_lock_init(&tc6->tx_skb_lock);
>  
>  	/* Set the SPI controller to pump at realtime priority */
>  	tc6->spi->rt = true;
> -- 
> 2.34.1
> 
> 

