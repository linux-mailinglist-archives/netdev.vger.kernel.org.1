Return-Path: <netdev+bounces-298352-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id dMkFBHMhK2pF3AMAu9opvQ
	(envelope-from <netdev+bounces-298352-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Thu, 11 Jun 2026 22:58:27 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 5800A675565
	for <lists+netdev@lfdr.de>; Thu, 11 Jun 2026 22:58:26 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=intel.com header.s=Intel header.b=dOTOUXje;
	spf=pass (mail.lfdr.de: domain of "netdev+bounces-298352-lists+netdev=lfdr.de@vger.kernel.org" designates 172.234.253.10 as permitted sender) smtp.mailfrom="netdev+bounces-298352-lists+netdev=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=none) header.from=intel.com;
	arc=reject ("cv is fail on i=2")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 0159130CAE2F
	for <lists+netdev@lfdr.de>; Thu, 11 Jun 2026 20:55:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3DB403921D0;
	Thu, 11 Jun 2026 20:55:36 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.16])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6F616313E24
	for <netdev@vger.kernel.org>; Thu, 11 Jun 2026 20:55:34 +0000 (UTC)
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781211336; cv=fail; b=unWhEoDYaGb/Gxey5D1e0ZeV2ltXn09TQ4cJCBEdXPt0XfsLilx/n8OVixMNepzZv+wx8ZuvDhnJaHTsb/z74Hh8bV42kIo0y+AiM3z1EkIdWa3qKTUAoUeNwCAxYjPB5KYSyXSpwMXGd60H9Qx2iO1wu/QNfN7pYAYuw7w+hUY=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781211336; c=relaxed/simple;
	bh=3a1q4fYi66DoXAsozH2pIih0ZSiRf/hy9EExl5ZxgwU=;
	h=Message-ID:Date:Subject:To:CC:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=tIHP0hBTGRh9Ok5hSC/mrKxtG9eXd4eoxm/5ctdYGqlW6EfK81HnZKwSNXZ5Yi95yj/9QZ9L3qbTqBC8065oES6PwGGsT6QtTuu3/r2NaIqECNcurpyr8aQT32luNGHpRlbd6wlTDR7jjxTFJS4BYh21OATwMRCU+U2Q6KYMsKc=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=dOTOUXje; arc=fail smtp.client-ip=192.198.163.16
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1781211335; x=1812747335;
  h=message-id:date:subject:to:cc:references:from:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=3a1q4fYi66DoXAsozH2pIih0ZSiRf/hy9EExl5ZxgwU=;
  b=dOTOUXje2gMJPFqRXjNackAf/j8qhS8F3q53hL+dN2ZkqpoqtM25wAYP
   lGpIcszUc9CfVzjMcTlojbipYzKZEA/RQ6ptKIQkMqSfmHIfApnSehiJi
   YRYTR+HaR+CKPlznJhbwYvGcwRpv4iMgU6H0G8N41bXJBljSxlqbOqtBf
   Ms5d5cA/3Lo2FIxRSJ100mt5WjbSA2uuU3fV7gUF3QFJT1pBARhl2jnaf
   TpBZd6hjiKeTAtFqbT5Nz0FYh87UtuvT0JGSwTZm/BBO9eRMPDUaZb/sW
   rD4QTHGdDKBPYykKPyjO3OBL0NbVsb8YznTsY79a9F9KW779WOi62rMWh
   w==;
X-CSE-ConnectionGUID: DxGDSqIDSeW9MKfdsT0oTg==
X-CSE-MsgGUID: RiX3l0DLR2mAxeHGwkhfww==
X-IronPort-AV: E=McAfee;i="6800,10657,11813"; a="69584151"
X-IronPort-AV: E=Sophos;i="6.24,199,1774335600"; 
   d="scan'208";a="69584151"
Received: from fmviesa004.fm.intel.com ([10.60.135.144])
  by fmvoesa110.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 11 Jun 2026 13:55:33 -0700
X-CSE-ConnectionGUID: zJc+DJv/R2qd/WaGhxVcgw==
X-CSE-MsgGUID: v5YVtabrQjuD5a2LT9qMKA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.24,199,1774335600"; 
   d="scan'208";a="248503798"
Received: from orsmsx901.amr.corp.intel.com ([10.22.229.23])
  by fmviesa004.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 11 Jun 2026 13:55:33 -0700
Received: from ORSMSX901.amr.corp.intel.com (10.22.229.23) by
 ORSMSX901.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.37; Thu, 11 Jun 2026 13:55:32 -0700
Received: from ORSEDG903.ED.cps.intel.com (10.7.248.13) by
 ORSMSX901.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.37 via Frontend Transport; Thu, 11 Jun 2026 13:55:32 -0700
Received: from PH8PR06CU001.outbound.protection.outlook.com (40.107.209.50) by
 edgegateway.intel.com (134.134.137.113) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.37; Thu, 11 Jun 2026 13:55:32 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=ZSfeIIJAiFJ2Qom7mVDJRVSzSqiaK2ZkB5yYMp9RKCAGJXCXjsz/FZVymkrTm0b6Dtcp5m5M+juglV1q16UKSN8W+opgdpnVFJtXPKjS7YYvtU6NQmaJCdoVNnWcJA1Z9rPFfrxQcoIFvToinL1pRzK7WnKd0Eaj7WMgtXTRiuCpM9YYNitZUOJaRm4+7thbp7EqfbfEfeM5y53rtCdTnUI5OB2O6cPuKtsmUXK69YTnJcWycGVIkLz5jzCTBzJnDH+CbXaSf9mfOpaK4oB3b1Lg++Tob23ZdUHL55rnX+kD5czkPvxUuGod6T+t6wT0gsIx8MHFKNBknTsAmeWzzw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=9HdKL86D155jdy+Gp9Bus7qezdQxGrtMKiLwL4ZNvwU=;
 b=Z2EbFb7rJdoN9R8BRrAfX930I3LrEur615kmiCcOuthc+0VegjvtXNjE88HmtXsst0VpFAOO9+3IBmSE2mOgvsc9sfc21vIwBrk8K+jKzVEEbbXz3HJhu7Owp5WDSYZMX5UVqlmlElzaSRO/t5dkXSYhlioOOEQ4x9fdpvJ2FNkpn2FGqL27dCD/Vli3MCwl9Jwm6TEO69BAXKWFJgzJ7qy5Vs7bM/6wgfu2QrIwbH5JVcMzwPmCzeP93zqzNguAmQ0zN8dZsx/tU9AQmpVrmgjTvSHx/i1VOOGkCEcinDG/4g2IyHF10w4ympOPDXHzRtiW35u3T+9RR4wa7Z1DWw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from DS0PR11MB7381.namprd11.prod.outlook.com (2603:10b6:8:134::14)
 by MN0PR11MB6011.namprd11.prod.outlook.com (2603:10b6:208:372::6) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.113.13; Thu, 11 Jun
 2026 20:55:27 +0000
Received: from DS0PR11MB7381.namprd11.prod.outlook.com
 ([fe80::4c39:dfe6:d6dc:6f58]) by DS0PR11MB7381.namprd11.prod.outlook.com
 ([fe80::4c39:dfe6:d6dc:6f58%5]) with mapi id 15.21.0092.016; Thu, 11 Jun 2026
 20:55:27 +0000
Message-ID: <60421e1d-18cb-434b-a3f6-8acade8199cd@intel.com>
Date: Thu, 11 Jun 2026 13:55:24 -0700
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net-next] ethtool: tsconfig: always take rtnl_lock
To: Jakub Kicinski <kuba@kernel.org>, <davem@davemloft.net>
CC: <netdev@vger.kernel.org>, <edumazet@google.com>, <pabeni@redhat.com>,
	<andrew+netdev@lunn.ch>, <horms@kernel.org>, <andrew@lunn.ch>,
	<gal@nvidia.com>, <sdf@fomichev.me>, <kory.maincent@bootlin.com>
References: <20260611200355.2020663-1-kuba@kernel.org>
Content-Language: en-US
From: Jacob Keller <jacob.e.keller@intel.com>
In-Reply-To: <20260611200355.2020663-1-kuba@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: MW4PR03CA0272.namprd03.prod.outlook.com
 (2603:10b6:303:b5::7) To DS0PR11MB7381.namprd11.prod.outlook.com
 (2603:10b6:8:134::14)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS0PR11MB7381:EE_|MN0PR11MB6011:EE_
X-MS-Office365-Filtering-Correlation-Id: 1ce318f6-f9f6-4d25-fa1c-08dec7fbc3cb
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|7416014|376014|23010399003|1800799024|366016|22082099003|18002099003|56012099006|11063799006;
X-Microsoft-Antispam-Message-Info: afigUnlEPkpARkjmFHxHXWgdyax2vYteEIY53t8j7w1aWEos9X6XguSnXznI3QRcTwH6pLUo9SgisaQyy9Wp9B501SbEKAc10FtPQbbCqSZoiDpfEDOz/OiQ4NIWRHkytoRKlT/UkikuJGtUJv/sjXNCYXZploFKdpLyL8ZBOwgxsK+ng8FsXwcyQHzX5BJeoZSMF7i5bn+Koyh2ntvfuPaV+g1b9ovwXcjOrQIqkavqUnujSkVUBU1ZHZfiA+1/4MRthV8kIydkx2jqBHMkWOfPbOimnT6PXT8Znpq19znfXmAv+4XsVuH7KaZhfDU7JY+cn/4MKxYleap1Vb/ysrBkiyKLF2y0UymoFW9Lz2tz6+TX5c4YHM0Np6iy3VwJy0qN9ID7GpvN1T5JYCmL1CGvzmv0yuPRWABCeN6jyWxEW4JqY9ZAdjK8lKSoZDZLP5L1mpo2yxa73PoucymGLPm5iKEGwW97l+dYeM2ei2iIfVxU0JNyL2aSxNyptH3Yk8U4pqRuchEAC+7OfYcD3GexJVJ7NFHUwFzRvrDv2TkwaxmI3lFYxMglR1LVC9o7GvBgKGl+wkU5BwVZaY0rgGkbla6S3GUOKjB7qRUVKnTlkkigorlXXQBako1jkEc98YFBKb72bLAnAhRyRmrvPPQedgPPQqlXJ8smq5TQt+/v/Crw4iIrvhf0nM14iKEz
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DS0PR11MB7381.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(7416014)(376014)(23010399003)(1800799024)(366016)(22082099003)(18002099003)(56012099006)(11063799006);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?R0l6NGRZY3ZKcVduNkthUHZrdTA4eU8wQXRuOWNPS3B3V0dqVTRVTE5DRWJ6?=
 =?utf-8?B?OThxL3Vwc2J6RXc0MTdVNXhTT2dSMkhsekJ1VmtpbEkzSTUxRFQ1ZGdwYjRV?=
 =?utf-8?B?eFQ4RzVVNWw5ZHRUcGM1cVJaMng3S24wSGUrWGh0ODREVlVla0hhTFhLWGZy?=
 =?utf-8?B?UnVndWdYeXZWd2kyY2h4ekp0QWlvRURkZWNsclY0RDBYajBNU3crUStOVDB2?=
 =?utf-8?B?SjdVZGRoOUZ6UWcvYW1Vd2ROYm9qZ2h1d3BjbWxFT2dpRzZHMnQyMnlPQlJN?=
 =?utf-8?B?SWVSWHNRbHBhZGRYVWk0WUxOTjFqdkh0NlVmVkhWRzFjUjF3YzBVU1BKKyt6?=
 =?utf-8?B?azNMd1dLeElFazlZRnplSFBOdzA4SU9VR3FVNnk4cCsvd1pmcXhRbUlicjVw?=
 =?utf-8?B?N09sb1NWd1F4b3J0Q1IwUkRYVXJJMzNmMThMRzZMMmg4ZThtVWdaMExCMGxY?=
 =?utf-8?B?RC9WZmNYSnJMV3ZWeEdpRHdER1NVajRsR0w2UWFPODBGK2p2RHNxZndGR0F0?=
 =?utf-8?B?b3dTRnBZMTBuTit3QTVFMmxYMzV4Uk5QbEhmQ3VVYjluL1ZCOU9wTVFZRWR6?=
 =?utf-8?B?Tm43R0lyVkNqQW1HNFU4QjVCSGZUMDBuaTMyQ0YxUmxTZDFrTWhrRGs0QzFF?=
 =?utf-8?B?anFQS245aGhqMXpHV2NkdTBEcjFUNkU1UG8xb0kyN2ZYUTBGM0NBeUxUa1RN?=
 =?utf-8?B?cGQvZzlKTGYvb1VYOUtYdGJwczJXdytYSkFzS2xSUTFURGYwcnVweUh3NnZ0?=
 =?utf-8?B?ZDAwSHhvZVVnN0NOSkQrMlpYdzBLbENWQW5VZkpNdVpucWJqK1QwSHhoUlQy?=
 =?utf-8?B?OFh1bGxLRzZzTHU4RFYybUZvVWlxdjM1a2t1VjhISlFTZVNSSXNyNFcxV0Vq?=
 =?utf-8?B?TEhHVUZPSEhJZ21mbUxZYXhuSGlYYThrcVBtMHVyZGJnUE9jTlo4b29jWUdm?=
 =?utf-8?B?RW9IY0lUeWR6bmtVdldiWW1aWGRXMDZ0S2dueVVsYjg1cHhHYy9mSkV2NXNY?=
 =?utf-8?B?dm9BaGVrNkltUU9TTVhMSllhS3lqRVZXbmhjWFpCRG5lL3IydC96ajQ1Y0Qx?=
 =?utf-8?B?dVkrRVlkR2Q5REpkU0dhN2VPYWF1ODYvMzZoTlZjQ0IxRjNLSmRrZ0pNd2kx?=
 =?utf-8?B?ZVJUcWVaWGg0d1Btc0RDaWIxTGE4dGQzbkNES2NCT3ZTZXBydGlob0R3NWk1?=
 =?utf-8?B?M01BRmFXTjlwZy9FL0lWT2JkczJyRW5BZXE0aEozSGM4cmREaGR4SEhkY0ds?=
 =?utf-8?B?WXA2ck91L1ZJNHFWQWl2L0NTZkVoZTQzVTliNXUzWWw3S1VGS0w0K1V2TzVx?=
 =?utf-8?B?cVFwUlZQMEN3YmNzVm50SkFmeklHbXNRbjhyWmxSN1ZmckV3TUk1bmJ2cFRT?=
 =?utf-8?B?OFFuV095TzFId2ZTNVJkMWovZXFxbFVRRm44ZXhFWTVVYk9LeUdtUVRlUTBs?=
 =?utf-8?B?VXdKbGI1QVR6ZmZSd3RYWXRKTDR4U0ZNOEEwQzZSSGgwRFpockM4SmhGVmhS?=
 =?utf-8?B?ZmRqZCtxdnRtNlB2N3A2czlRbU9zVmVlZk5XR1RLbk11a3NvZGNhVUdRK1o3?=
 =?utf-8?B?WnV2OXlHdE9UWk1ieFR5bmxCcGVuRjhsV2NwMmRzOHlibUVMWkFsbnYrZVBx?=
 =?utf-8?B?RnRlWE1MTUJ1ZHYxUkpGeXVzdTlWNlNPMzV4TUlZUUN5OWR2eDhaSTZqTXZK?=
 =?utf-8?B?K0VSZkpyWEh6b042NVo3UHcrQ0UxalRQWVM2NmZMNks5QVdDdmx4TmxBc3Y2?=
 =?utf-8?B?ck16N09iSmlyUTVFV1lmRUppK21RazFVTmE4VXcvNE4wVzJGUmFJVmtlWDNS?=
 =?utf-8?B?ZnJQWjN2aW5NektZak02UWYwQkkwTW9wSTZEY1FhWUZPSklMVzJkZmhncDFt?=
 =?utf-8?B?SVhzZzllK3YwdHJSbCsvQ05NdDE5U0RVcnVXaTN3cjZXRDl0OXNGNmpldFhj?=
 =?utf-8?B?K2pTbG4zRWVGYUJweG1XK2xscDlBZ0lsUnpEaU9BdkhJaHZwUWhISVdReXA4?=
 =?utf-8?B?VTQwYit6Z25wNlB5Y3dSOEhiUXBwTSs4UjJ2UmExVmJsZXR4eE5oeXdZZjVr?=
 =?utf-8?B?NFhDek1wU3pWSHhSTy9SUXVnWDhxQ0JUd2s4NEJSdjRqeGo3Y25Sd2pZUEZ2?=
 =?utf-8?B?WVVQei9POHU2RzRDUWtZdkFrTVFLKzJYSnhxQkNMRTNtb1NoUEFwbXpYaDYv?=
 =?utf-8?B?MnpqSEsyOHZGTHo3NjByaUI4Qm05L3lESWV2cEJJWjMvUEpMdjNLaEc2Q0h0?=
 =?utf-8?B?MkFtTXhJeW5HOEhDblVUVE5UT09rM09zbVNVWE91cXc5M1BQTkN6bmF4ckVC?=
 =?utf-8?B?SGFndVArTzVOelhUSytQS2c0MVNTbmRhclpBSHcvdFhmNlo5NUwwVElSSytC?=
 =?utf-8?Q?ywJhSywPQUu//EnA=3D?=
X-Exchange-RoutingPolicyChecked: YC2QzEjUqzgLI4E5vTnGFqSv6ku5KpR61Nfj8UClJpU8bJ99pJ3CXPsOjF6V1BVwGHy5ponyKAYu6KWzz5YuHN9Syuxw2CU0P3f+9xk+p+o+LQ3TdZ7elcoKHkc7Y8WVPsjzLJuSqQo9sYfQZBKSb207FMvYUKRR16mr8KkotY+aBB9/eulBltfLCYvXdn3bInUa3V8E0oaD+If5ht/hxz90yuMFrwtdqm+E8j4Ux10NpSjh6FdMLUW2VsGq7OqxAeawBaMGdQQf24aUV/yVDjAE4B0PVaCB3wORkQhop4mJ6ssp2RXc+Owm5jo5vwj4YJZQfTDFL20tuN+NJxtyAg==
X-MS-Exchange-CrossTenant-Network-Message-Id: 1ce318f6-f9f6-4d25-fa1c-08dec7fbc3cb
X-MS-Exchange-CrossTenant-AuthSource: DS0PR11MB7381.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 11 Jun 2026 20:55:27.0690
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 7alKmv1JvuiukFfg+mzDwDSHf4DxTZSvWIgXMknl6CAF6jevDYl6JdT/k0FTqz9nHQER2/KvMORnfZTEJehaQfMYY7IOyNrHDR7Fhs5W4qs=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN0PR11MB6011
X-OriginatorOrg: intel.com
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-1.66 / 15.00];
	WHITELIST_SPF_DKIM(-3.00)[intel.com:d:+,kernel.org:s:+];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_REJECT(1.00)[cv is fail on i=2];
	DMARC_POLICY_ALLOW(-0.50)[intel.com,none];
	R_DKIM_ALLOW(-0.20)[intel.com:s=Intel];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FORWARDED(0.00)[lists@lfdr.de];
	MIME_TRACE(0.00)[0:+];
	TAGGED_FROM(0.00)[bounces-298352-lists,netdev=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FORGED_RECIPIENTS(0.00)[m:kuba@kernel.org,m:davem@davemloft.net,m:netdev@vger.kernel.org,m:edumazet@google.com,m:pabeni@redhat.com,m:andrew+netdev@lunn.ch,m:horms@kernel.org,m:andrew@lunn.ch,m:gal@nvidia.com,m:sdf@fomichev.me,m:kory.maincent@bootlin.com,s:lists@lfdr.de];
	FORGED_SENDER_MAILLIST(0.00)[];
	FORGED_SENDER(0.00)[jacob.e.keller@intel.com,netdev@vger.kernel.org];
	DBL_BLOCKED_OPENRESOLVER(0.00)[vger.kernel.org:from_smtp,intel.com:dkim,intel.com:email,intel.com:mid,intel.com:from_mime,lunn.ch:email,sea.lore.kernel.org:rdns,sea.lore.kernel.org:helo,fomichev.me:email];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[jacob.e.keller@intel.com,netdev@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[intel.com:+];
	ALIAS_RESOLVED(0.00)[];
	MID_RHS_MATCH_FROM(0.00)[];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	RCPT_COUNT_SEVEN(0.00)[11];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	TAGGED_RCPT(0.00)[netdev];
	RCVD_COUNT_SEVEN(0.00)[10]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 5800A675565

On 6/11/2026 1:03 PM, Jakub Kicinski wrote:
> mlx5 throws ASSERT_RTNL() warnings on timestamp config, because
> it tries to update features. mlx5e_hwtstamp_set() calls
> netdev_update_features().
> 
> I missed this while grepping the drivers because tsconfig goes
> through ndo_hwtstamp_set/get, not ethtool ops, even tho the new
> uAPI is in ethtool Netlink. We could add a dedicated opt out bit
> for mlx5, but NDOs were not supposed to be part of the ethtool locking
> conversion in the first place.

Makes sense, even if we have plans to improve that in the future we
didn't plan to change it right now.

Reviewed-by: Jacob Keller <jacob.e.keller@intel.com>

> 
> The mlx5 features update is related to the "compressed CQE" format
> which lacks timestamp, apparently. See commit c0194e2d0ef0 ("net/mlx5e:
> Disable rxhash when CQE compress is enabled").
> 
> Fixes: 6e9e2eed4f39 ("net: ethtool: Add support for tsconfig command to get/set hwtstamp config")
> Signed-off-by: Jakub Kicinski <kuba@kernel.org>
> ---
> CC: andrew@lunn.ch
> CC: gal@nvidia.com
> CC: jacob.e.keller@intel.com
> CC: sdf@fomichev.me
> CC: kory.maincent@bootlin.com
> ---
>  net/ethtool/common.h | 7 +++++++
>  1 file changed, 7 insertions(+)
> 
> diff --git a/net/ethtool/common.h b/net/ethtool/common.h
> index e3052972f953..2b3847f00801 100644
> --- a/net/ethtool/common.h
> +++ b/net/ethtool/common.h
> @@ -113,6 +113,13 @@ ethtool_nl_msg_needs_rtnl(const struct net_device *dev, u8 cmd)
>  		return ops->op_needs_rtnl & ETHTOOL_OP_NEEDS_RTNL_SPAUSEPARAM;
>  	case ETHTOOL_MSG_RSS_SET:
>  		return ops->op_needs_rtnl & ETHTOOL_OP_NEEDS_RTNL_RSS;
> +	case ETHTOOL_MSG_TSCONFIG_GET:
> +	case ETHTOOL_MSG_TSCONFIG_SET:
> +		/* tsconfig calls ndos (ndo_hwtstamp_set/get), not ethtool ops.
> +		 * Also, there is no corresponding ethtool ioctl, therefore
> +		 * these cases are Netlink-only.
> +		 */
> +		return true;
>  	}
>  	return false;
>  }


