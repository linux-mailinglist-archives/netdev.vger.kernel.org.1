Return-Path: <netdev+bounces-97846-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id DB5EF8CD833
	for <lists+netdev@lfdr.de>; Thu, 23 May 2024 18:16:00 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 8FEC5283608
	for <lists+netdev@lfdr.de>; Thu, 23 May 2024 16:15:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A07AD101E2;
	Thu, 23 May 2024 16:15:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="BDCVQ1Kb"
X-Original-To: netdev@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7C2991BC49
	for <netdev@vger.kernel.org>; Thu, 23 May 2024 16:15:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=198.175.65.12
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716480954; cv=fail; b=qEM3XmZ9zPQBz7YvSPSQVFp9p5mlJek+fmIINoDIoNwneETHzbGEVl0BcP23U9uo2QwhWFhduru/HB11Cx73nZ7ftnopqPylpYk1d5Q2qln0kXKzIjDjKumBHhazUtzv3Rmcmh8AKb7ey/OAQTNprYcsxqd3QTXQ4rjlhfvFtjo=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716480954; c=relaxed/simple;
	bh=dAthKUInwNrfYQwcdoR2WbQaLOvgNiPXIRKnMBKnTPQ=;
	h=Message-ID:Date:Subject:From:To:CC:References:In-Reply-To:
	 Content-Type:MIME-Version; b=cNaKQQ9JSfmZdO9WyWfMg0/LFdnYgpBTles+ioao1tjCqn3/DK/qyWaYdzuacMxb+MObOju9llARKrcVMfhgEQfG/+g2ixOJjxY6E6heP3JIuM1gxViuhWinbgiyIuLbgg+5DUjJheNMPZtA38FNG/qXO5vukXhPmGKBAuUOlI8=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=BDCVQ1Kb; arc=fail smtp.client-ip=198.175.65.12
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1716480953; x=1748016953;
  h=message-id:date:subject:from:to:cc:references:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=dAthKUInwNrfYQwcdoR2WbQaLOvgNiPXIRKnMBKnTPQ=;
  b=BDCVQ1KbW4MRA9lw84CwpIBt2Q1foppn6JZld+wsaoD3Vhck0S0jve72
   HJpiI0+SWngaQDHsY7aqdWcs2ZL4w86btIBThYJ6oUnPRG0+fvz9RkeRf
   6gb4H2IDlZza7KPLDc24NzoOt8QqEzw6/2vBTi9QelWYgW1gPpjHtoT73
   3BZO+aSTeLR3KWYg14az/Ct5XvACBcvS3TtKbKX+fcQQ+A9qOdH/hgyZs
   KF8izaB3M8W7D+jGCObLetgSTbzXuw0XD2p/Bh136zlpK9Rq893DtmcTQ
   ZHMrD2Su8rGa17TUHU0DNwPmWMIJlIOA6U6Y/YNN0XRU4J9hAWmCJUzwF
   w==;
X-CSE-ConnectionGUID: PUjW5vtMSlWn7Y6E2aKmWw==
X-CSE-MsgGUID: 1J4ePmxPTXGEZtry9V+T+Q==
X-IronPort-AV: E=McAfee;i="6600,9927,11081"; a="24224225"
X-IronPort-AV: E=Sophos;i="6.08,183,1712646000"; 
   d="scan'208";a="24224225"
Received: from orviesa003.jf.intel.com ([10.64.159.143])
  by orvoesa104.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 23 May 2024 09:15:52 -0700
X-CSE-ConnectionGUID: BqUkIoaLR+yShkHtiiwZ4w==
X-CSE-MsgGUID: OXn0TLkaStej7O4TarA77A==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.08,183,1712646000"; 
   d="scan'208";a="38496206"
Received: from fmsmsx602.amr.corp.intel.com ([10.18.126.82])
  by orviesa003.jf.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 23 May 2024 09:15:52 -0700
Received: from fmsmsx610.amr.corp.intel.com (10.18.126.90) by
 fmsmsx602.amr.corp.intel.com (10.18.126.82) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39; Thu, 23 May 2024 09:15:50 -0700
Received: from fmsmsx611.amr.corp.intel.com (10.18.126.91) by
 fmsmsx610.amr.corp.intel.com (10.18.126.90) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39; Thu, 23 May 2024 09:15:50 -0700
Received: from fmsedg602.ED.cps.intel.com (10.1.192.136) by
 fmsmsx611.amr.corp.intel.com (10.18.126.91) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39 via Frontend Transport; Thu, 23 May 2024 09:15:50 -0700
Received: from NAM04-BN8-obe.outbound.protection.outlook.com (104.47.74.40) by
 edgegateway.intel.com (192.55.55.71) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.39; Thu, 23 May 2024 09:15:49 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=m5XN+qIH8KZF33xyPJ2uHMzl/3jVMWDRd0pbMNyW8EZbEwTdMqOxI2mStM8D5z4QmALsAJ+i8T1x4uPxrijpSf/htK76cbKaQgU8T6cPOc5sFxM87bzDyIOucRvws8cUHWfrsCh7VynedVmFnKRpelyUNM07r7geGpWTmVsmS0ohaZIIQc0Cecu8ftrm+oCk0Br5yIOHVhjMUTSk8drh4GCHXnrEB3P87F1Szw8au1iVYRMU0D6KEsp/smL1f3qNkNf7ccRhXRYKf3xojdLGdERJbh7OdeBnoSVEhb+qA3qnypmtcT5HgI81NJxbDlkBwMeC+Iw5VE5o4b0UtLGeeQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=YuJ/QThJJpuDkuYG/y/d+kuq7sZN1FVxHXRMuyOR6h4=;
 b=jzWWVYWfFi84QMAsWxeo0D0PvjyjBDpWAUJEzjyNoaC0DI1lANeh5tFsgnxOyioggN9tu2F/RUx7J1YGpklQZVrF/+rzhAdl+XumWwKW/NWnBgNADEvTAyKP7GBmgaLRJD40o4j22iV6qhx+T9MI0zDwXXC8RoNWJrXi6DuVDJu6I7sMVX7CXGCgcTximMr+VX0xRoPy9/h0EU5KWzW95CSlSLvttWxSJrC524+Z4VvNUPCBa9Wl1QBYYLBkdxJ0YC/cE11T/1Rn5sWDwBx142uMkRqP2EJvsmm9GV695B9YpvI4IY4Yq+EVT3wFpBRj7augeRU/8wkicwrLxRvE0A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from CO1PR11MB5089.namprd11.prod.outlook.com (2603:10b6:303:9b::16)
 by DS0PR11MB7411.namprd11.prod.outlook.com (2603:10b6:8:150::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7587.36; Thu, 23 May
 2024 16:15:29 +0000
Received: from CO1PR11MB5089.namprd11.prod.outlook.com
 ([fe80::7de8:e1b1:a3b:b8a8]) by CO1PR11MB5089.namprd11.prod.outlook.com
 ([fe80::7de8:e1b1:a3b:b8a8%5]) with mapi id 15.20.7611.016; Thu, 23 May 2024
 16:15:29 +0000
Message-ID: <655f9036-1adb-4578-ab75-68d8b6429825@intel.com>
Date: Thu, 23 May 2024 09:15:27 -0700
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net] Revert "ixgbe: Manual AN-37 for troublesome link
 partners for X550 SFI"
From: Jacob Keller <jacob.e.keller@intel.com>
To: <kernel.org-fo5k2w@ycharbi.fr>, Jeff Daly <jeffd@silicom-usa.com>, "Simon
 Horman" <horms@kernel.org>
CC: <netdev@vger.kernel.org>
References: <AM0PR04MB5490DFFC58A60FA38A994C5AEAEA2@AM0PR04MB5490.eurprd04.prod.outlook.com>
 <20240520-net-2024-05-20-revert-silicom-switch-workaround-v1-1-50f80f261c94@intel.com>
 <20240521164143.GC839490@kernel.org>
 <1e350a3a8de1a24c5fdd4f8df508f55df7b6ac86@ycharbi.fr>
 <c6519af5-8252-4fdb-86c2-c77cf99c292c@intel.com>
Content-Language: en-US
In-Reply-To: <c6519af5-8252-4fdb-86c2-c77cf99c292c@intel.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: MW4PR04CA0252.namprd04.prod.outlook.com
 (2603:10b6:303:88::17) To CO1PR11MB5089.namprd11.prod.outlook.com
 (2603:10b6:303:9b::16)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CO1PR11MB5089:EE_|DS0PR11MB7411:EE_
X-MS-Office365-Filtering-Correlation-Id: 4baf4efe-c70d-4c3b-8145-08dc7b439014
X-LD-Processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230031|366007|1800799015|376005;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?TnVsZHN1c0xVTTN4SGtlcFBQekRWUGJ5VEVEYmljSzgyNCtJVDRpeFMveGN6?=
 =?utf-8?B?eTlCQlR0Z3VIUlRFWko0ck9xU0o2YTVUcUFac3ppVkR5VjBiREJMbjVtdjlM?=
 =?utf-8?B?YVpSemNPcTU1YisxWjQ2NHNDQllScG9JUlFlWUNxdzF4aE9QcnEvMEd0Y2Rz?=
 =?utf-8?B?enFXTFAyenhGZjFyczJqRysySEttOHp0ZC9QNlJFbHZBNlZCVXVWZnp5b3l4?=
 =?utf-8?B?bWxwRm4xTmMzRWF3SCtoWFJlcEl6WnVHOFk0K3lHM0JBOVpWNXVXQXRKYXh3?=
 =?utf-8?B?a0ptY3dqNFFhTTVURy81MWROQVF4Tk91WlhUSFU2M1Z1SVBzazJZOFdqdjRP?=
 =?utf-8?B?d3BsWmtJd2svbTZCWGJNZE1nbUtkTFhJa2FpQmtMRDN5VDBsaFZtclMxb1BD?=
 =?utf-8?B?TVNacUh2TElUaHdTMk5hdVRncUpPWWxldzF5dERybUx6ZGlYSWlMamxYRWxL?=
 =?utf-8?B?UUM3MG82SXROa01qa1Bxb0RxR09SOStzYUxKRWh2Tmo1NkI2NEJNb1dmTlo5?=
 =?utf-8?B?dWJZWkZZNmlaRkRIWk80WnN0OG5CUXhsd3BoVHBnZTlJVnJySGcwTlVhT2lo?=
 =?utf-8?B?WEhVdE1QYVRkYW8xZEZtSVVkODNOUWVNQXl5dGsxTEd6UTRkSzIrOGJaeXhi?=
 =?utf-8?B?Zm9wWWxoU0lJVmFzN25heDhGV2V0VUF3K1VvTFZ3MGMzMkdtWjlwRTRFdFJB?=
 =?utf-8?B?MlRlYnhzdVNYT2FFVElsd0JjTGJKbyt4Ti9JdHhORlNxbGt4N3pjNjZlVzNS?=
 =?utf-8?B?b0R3dUpicEMrWWlXelRVbFNQQ0JjTWRXVUxtNHFEbDk3Mkt4Y3kyVjJ3NG5s?=
 =?utf-8?B?SC9yQ24xNlVEdHdhNWNmS0dhRE01aStVbkc4RDlyNVhELzdTNXRVcU5SemMv?=
 =?utf-8?B?REtwTE1xOHI2ZTgzTmZYdHVzbUc2YXVMR1NpVG9ZSFhZSzcxd292T0R1dnow?=
 =?utf-8?B?TGtzWVUzVnRxTTdMYk1xa01jTjc4RmljY08zOEt2ZzF5MC9BamR1U25yOXBl?=
 =?utf-8?B?SXRhVGpNSnpBaGhaUGxyYVNUWktOQ1YvTTBUem14cFZIWFQ2WTl0YlRueUMx?=
 =?utf-8?B?MUNyMGM0d1NBaDg5NFExSjZjMjJwT3doMkl4emoyOHdSZityd2xhTmJ0T3BQ?=
 =?utf-8?B?Z2xWOTV6Y3ZZNlpuL0hWU0M3TlFaMHFCdm90RmViaWtvTUhENUN0TDdzUk1h?=
 =?utf-8?B?QmZUZkR6OXdsZnpXWHNPa2c1UGg1ZUVqbDNUUERDTmhtRG94a2FqZmVFSWVL?=
 =?utf-8?B?R0tkL01PT1lVekU1bXRTYTFMdVpXMWNHTU9sdWpOYTZsU0phVUJKM3YyVG1O?=
 =?utf-8?B?NVBXNGlncHFvcjY0SUdwYVpxcmF0N0trdFdnR3NpOUNUQytmL21tREk0NWZv?=
 =?utf-8?B?VjJxNGw0d2crSFVjOGtjUy9BTU5uRkthVkpkUi9uZHZpdkw3Rk03MTdlaSt3?=
 =?utf-8?B?MzE3SVNtWlIvVU0vZjBUeUF5ZnI2RytZdG1INDhVblZ3bDRsQTUwNFFxbWxl?=
 =?utf-8?B?eVBZNzhzNU9iTXRTZnQvMWN3SklHM1p6SHpadFhpTGs1bXhqd2ZUbldXTWlB?=
 =?utf-8?B?RnZqTlUvRjJvN0NlTVVJbjBjYThKQTlXcVpBS3EwZlZvZFpIUmU5ZXhVT3BQ?=
 =?utf-8?B?aWtOc0xwZUE1Uy8xQUYrYm02eUsxNTI1KzBHMU10MDBsSDZ2ZTdQWWFOaWd2?=
 =?utf-8?B?cmxmUXRqMzNhMG5PeGtaeWJ1OGZ6eXlWZVpTYnpmOHhKTlpwMWhodUp3PT0=?=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CO1PR11MB5089.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(366007)(1800799015)(376005);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?QWFNMnN1UkhhbWd5azhxdHp2TEg4Q3Nud001QXlRT2p1VmQ4blRGb0l2VXh1?=
 =?utf-8?B?eWJjZ3lzWWE0Qko2VWNTWkRqT3JIUk52c0dBdFJibzRqa2txUERFeTBEVGh3?=
 =?utf-8?B?TnVCTldBZElDQ1c0RndSTEdiVnZWU3hMU3VaR05oWTZVVGdsL0xRNFBReE5z?=
 =?utf-8?B?VHpLV2RHUmtUTzBSUHJHMXpuelFNTy9lQVJrTHhHUUVOcnNBMEZ5WHp3ekp5?=
 =?utf-8?B?WFVHNDBNN0JGcVJEUm92eWRYa0RoRXRhK1R2WUFOV3ZsR1BJU1dBQi8yczYv?=
 =?utf-8?B?ZWdzeStRVyt3QzA1dm5wZFhyMXRLZmZhdXl1c1EvZzBNREcxc0JBaTI1aU8v?=
 =?utf-8?B?NVFXMUlZeTlCUlRmSytJZGhhVHZ2azE5Q3liS1ZFVHQrUlZqWmFyWFRoMUkr?=
 =?utf-8?B?cVg0a2VQQkpoK0JXZi8vK3AwWXFWQUVGVFE1am8zUnQrWFE0akN5RHBUSkVy?=
 =?utf-8?B?Vmp3MW9aMDNwT1MybzB1TUtKUzMwR254VFFnanZ1Ni9CanlWSWdxUXo0NVVu?=
 =?utf-8?B?S1BvTDRHaDc1ck9ER2hTMW1rNEJZalRkUnZhU2RSZTBzMnN3dkZqRVR1Umt6?=
 =?utf-8?B?K2Uvb3dDcWthYzNpRkp0ZmF2c3Q1TmMzZ3c4QnJWK0xBQnU5VUpwV0I2dFJB?=
 =?utf-8?B?eXJ2NUV2R1ZCNUkrSUxQUEovMGtUWUIycXFMTFcvWEpPbEx5eW9qbnFPUkNs?=
 =?utf-8?B?WElrNlpLcFhoSzZRb0xWS2VOd1pLT0ZmeEdoS2w0QjZQSkNPNFN0d01ydG9R?=
 =?utf-8?B?N25oTDBieitkd2t5SlNQTUVNRC9mbEVpdHpFZWRtME8rVDN1VTNVODl0Vjlh?=
 =?utf-8?B?OWpyOHFkMzdHNUgyMytRMStFK2Y0T2dKelJFci9mVm1WT25rRmNZTmp5ZSs4?=
 =?utf-8?B?Y1VWdXpGMTc2M3F2RStIR1QzSTUzTmxyZmJJbVB2VkV6ekV2VFJ1QlFhMkF0?=
 =?utf-8?B?R2VlU0VNU0pkeUdjTkZNdjVSemVHRVRsZklpNnRaSy8ySE8xOEdTYlBqVGhj?=
 =?utf-8?B?bXprVDdsYXB4dEkzRW9DMWdkY082WStwSFpISVczZ2tCMVhiK1lZcU1tWmpQ?=
 =?utf-8?B?S3hoWlJ6UmQzYVRYNWoyZUE4ekh2eFh3VmtISGo0N1VKcG0vVG9oSExSajM4?=
 =?utf-8?B?ZUg3OVhWUFkzZFhCTUhPTllyK21FMlVsRkZ0bUd4VytCbXVBZHJhOHVuT2ZQ?=
 =?utf-8?B?QzNpYmVwemxodWxPVGN4MFArblJpSVR3YS9wd0xBRy9vMGVOQ0wva1dlQm53?=
 =?utf-8?B?K1VWcmM0N2pLd2hmQ1U3QWxoMEM2UU1ZN0NnRnVtWlJNM3RLaDZFTGlvbSto?=
 =?utf-8?B?a0xsd3FKdWRpYVM1NXlvM0JXWFBMdDhTRHdsbXBrOTg0VU51U3lkc0h6UVpP?=
 =?utf-8?B?OFhzUmNFbU5qenc4TXNIM2hoc2xHSFB4U3lpMHpXWUZJd1YySHFaNDB5ay9S?=
 =?utf-8?B?d2pRVGlpZ25XdXZzSlBoNkNYZXo1U3RiNEMvRkxMZjNDQi8zSEJBaTE1OERa?=
 =?utf-8?B?dVI4K09jNmV3NzBZQUZVZHFpRlhUREJnZjY0bTRvR0lxczBMZUkvNUo1b0t6?=
 =?utf-8?B?azNGYkp6bjdYR3dSK2dKTW5IQ3Jra0J6L0IwbGJtSXB0YkgxZlJQdHpGdnpz?=
 =?utf-8?B?Kzd1WmIzSVRxbXNRRTdZRXJtQzZpQ3VpYSs1T2wvK3RZVDhmN2hPWXdNeEk5?=
 =?utf-8?B?a205UnMyRlg3ZnZNZmt5VzVrOUtkM2NGa29wUDdmUnVWaXhwL1ZaT3BEZXdx?=
 =?utf-8?B?enVkbmVoN2dzN2lMUWZOUVplV1oydWJHUmFEZWpmcStpRERUL0FZTXRPU05v?=
 =?utf-8?B?OEc4UFltenUwSk5SeVF0cVQrNmJVcVpEdVc5V1Z5TWwwaVZEZk9zakpkR1JL?=
 =?utf-8?B?NG1pYVk4N0lDd0Eyb2wzSndrbmc4R3hjcWlsUDRVSUlzaEF4Tjdtem9QRkZy?=
 =?utf-8?B?RXFMWHh1OFJpaWhsZGtzbGZnVDhKdGU5VWY0dW1aU2RwV1JHd3pxSTBpbHlD?=
 =?utf-8?B?c3lveEwzeHFEMXNCaFZHODdiaXFZMy9UWGo4V2JBZ3Y2dE5kUUswaHdSMnc5?=
 =?utf-8?B?TkxOVzBXeklWRFdDZXdTT2JYQkNqWDhFcmFIY0FjOXRJM1k1bmg4T1ZWbHBq?=
 =?utf-8?B?SjBXam00RHV3bm1tbEhQK1R6NUhlT2tYYitPRFJFMlBoai9ZYnlVQ0s1QzRp?=
 =?utf-8?B?SUE9PQ==?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 4baf4efe-c70d-4c3b-8145-08dc7b439014
X-MS-Exchange-CrossTenant-AuthSource: CO1PR11MB5089.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 23 May 2024 16:15:29.1011
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: PrcTqwlheNthwVC4yfeZ1vDrXMRMtIgMvDELm3bMP0jJ+dIjqbXoazfcp00CnBR3v/n2ohEk1uY7qKgIZ0iyXu1nZmHmQ4ittCbYkMwYp7w=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS0PR11MB7411
X-OriginatorOrg: intel.com



On 5/21/2024 2:05 PM, Jacob Keller wrote:
> 
> 
> On 5/21/2024 10:12 AM, kernel.org-fo5k2w@ycharbi.fr wrote:
>> If any of you have the skills to develop a patch that tries to satisfy everyone, please know that I'm always available for testing on my hardware. If Jeff also has the possibilities, it's not impossible that we could come to a consensus. All we'd have to do would be to test the behavior of our equipment in the problematic situation.
>>
> 
> I would love a solution which fixes both cases. I don't currently have
> any idea what it would be.
> 

It looks like netdev pulled the revert. Given the lack of a full
understanding of the original fix posted from Jeff, I think this is the
right decision.

>> Isn't there someone at Intel who can contribute their expertise on the underlying technical reasons for the problem (obviously level 1 OSI) in order to guide us towards a state-of-the-art solution?
>>

I did create an internal ticket here to track and try to get a
reproduction so that some of our link experts can diagnose the issue
being seen.

I hope to have news I can report on this soon.

> I guess there is the option of some sort of toggle via ethtool/otherwise
> to allow selection... But users might try to enable this when link is
> faulty and end up hitting the case where once we try the AN-37, the
> remote switch refuses to try again until a cycle.
> 

Given that we have two cases where our current understanding is a need
for mutually exclusive behavior, we (Intel) would be open to some sort
of config option, flag, or otherwise toggle to enable the Silicom folks
without breaking everything else. I don't know what the acceptance for
such an idea is with the rest of the community.

I hope that internal reproduction task above may lead to a better
understanding and possibly a fix that can resolve both cases.

