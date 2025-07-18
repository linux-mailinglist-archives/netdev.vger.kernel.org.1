Return-Path: <netdev+bounces-208258-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D144BB0ABB2
	for <lists+netdev@lfdr.de>; Fri, 18 Jul 2025 23:37:57 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id ADB8E5C0C86
	for <lists+netdev@lfdr.de>; Fri, 18 Jul 2025 21:37:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0F23D21CC6A;
	Fri, 18 Jul 2025 21:37:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="MFIf+hDj"
X-Original-To: netdev@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.10])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6979742AA4
	for <netdev@vger.kernel.org>; Fri, 18 Jul 2025 21:37:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=198.175.65.10
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752874669; cv=fail; b=Oj4S267F2j9iXkf5bCoNTqTv1OcD0Zqjn0Rd4kh+/fpgNk3OjW3yU6T3evK25XUcqwgZQBnMK4IbpmiIXRmivv3AJZIZOPzf6UshZFOlIFDOUxOLM9W/dmRM3f9Ii9boG5gnFbV4/fl4jKjq9B/IxAHkD60geVNMxsISRJXdI3c=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752874669; c=relaxed/simple;
	bh=x9iyHvKIJKkXvuwq8ODakhqNvvMf5H6zOvZpdS9Zoic=;
	h=Message-ID:Date:Subject:To:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=Bmeu4UE2e//lwDBQla5eX+RUNcBwNEnWBz6cT1zh4Bze+DIWzl86ZQR/FkT+dwSgbE3y0DvJ88slM/5CyV+wmH7FpZDaQ1MxT69f0pU1GLYls0ZfPcbqjzjhAMHsH7PaNI1nzo/REtYUQGJKfwaeUefktU4SFW6wRrFQ/Jyk4mE=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=MFIf+hDj; arc=fail smtp.client-ip=198.175.65.10
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1752874669; x=1784410669;
  h=message-id:date:subject:to:references:from:in-reply-to:
   content-transfer-encoding:mime-version;
  bh=x9iyHvKIJKkXvuwq8ODakhqNvvMf5H6zOvZpdS9Zoic=;
  b=MFIf+hDjgbBqC3GFF32a1IP+hM9YAb9k6VZGxO8RXuEthSKPE8879ifV
   fHtKXMN1xlhdHnhjn6g0ZqYbXKMUnKD3LrsFgmLUkwhHeRtin+2cL8YSy
   luvyVK71EGFum/RqVvgaN4zrjxKcok2V/T37lx3tTw6pomJdltT9ArW+a
   BYE+Z0QPqmibyHrBqtvyZ+vgqV2UUNRFdyROTqjPJ2I4Fa6bKVEpda3cE
   Qi7+Ac3dno4xCB9hte8Izwl3u99hjZaICJ4nfCrRg1jG795wROeuJBbXp
   +cfYrdW7tQG8P3LGbbckqx6+ap7tnmOOKiSwipDXZVhJ1sevTSpizPRDw
   A==;
X-CSE-ConnectionGUID: 0HvSxqbmRCW63qaLgL5kjQ==
X-CSE-MsgGUID: bNf8ahVgQbOFKUPeE5QCLw==
X-IronPort-AV: E=McAfee;i="6800,10657,11496"; a="72628000"
X-IronPort-AV: E=Sophos;i="6.16,322,1744095600"; 
   d="scan'208";a="72628000"
Received: from fmviesa004.fm.intel.com ([10.60.135.144])
  by orvoesa102.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 18 Jul 2025 14:37:48 -0700
X-CSE-ConnectionGUID: N0DXCL2/QZ2cAiDDnRLVdw==
X-CSE-MsgGUID: ic0grKwQTbqUEU5LVGEp1g==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.16,322,1744095600"; 
   d="scan'208";a="163730787"
Received: from orsmsx902.amr.corp.intel.com ([10.22.229.24])
  by fmviesa004.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 18 Jul 2025 14:37:45 -0700
Received: from ORSMSX903.amr.corp.intel.com (10.22.229.25) by
 ORSMSX902.amr.corp.intel.com (10.22.229.24) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1748.26; Fri, 18 Jul 2025 14:37:45 -0700
Received: from ORSEDG902.ED.cps.intel.com (10.7.248.12) by
 ORSMSX903.amr.corp.intel.com (10.22.229.25) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1748.26 via Frontend Transport; Fri, 18 Jul 2025 14:37:45 -0700
Received: from NAM11-CO1-obe.outbound.protection.outlook.com (40.107.220.73)
 by edgegateway.intel.com (134.134.137.112) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.25; Fri, 18 Jul 2025 14:37:44 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=xo6RX+2CoxV2pqbfinXBgKMaIQm7Lg7H5PBmQARWr3KnFMwJbpcT4ZSl1c8DVoZPIS/MlkiQokMHsKdP3mYdmZrjV8I+u92Pe10rx3TKnymZUaInPbhtKX/tpALTYZYLLgyDP/uSWpRd1E8AlmDU2cHewIc2EBewfIHAXSiIiPmAGrjzSOzUE/QHxnPJ0hVOI8O0Hjvy0Qns4olSNe11F6Ci+sde4MdOHRxzOvqphOTQYxHP10PrvTq50GGri3FxxdqrGo3pWKujr9xGS5huskRtGwy5hWyE/K1HZogka5su6GgnMmjLEBl5WCP1D9NFOo7rhnQNcfpDPAzDR/zJzA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=HCaZjpB19AaKLFRwhYMfaVzORxrJ0Hq5PTkmcd79xzU=;
 b=iklGC9W6zERvBtqNuzjrYGaMWjo7XFr4omzvDMRkzzWVvC1EbalpprAU+wBDdcahEkCHpIz8zcEURir3/3o2s+gSpZi78XsrUaj28Ier2lGv6qokfFVSi0tzMRyqRWDdFdXKK7nvtuIEivBodlZpHmccoZyXRc+P/jwW5kiyLrDid7Ds8rO8vgWpuc+stR+d6zbaMGj8PnzlEdWkSNMhl4iTTpHYGzO+GR7SlGThN+pUGhHTpaGaN1l82J7IMAfTO25TnpclwNOTKAXMtspTmUMGl3DN5J4waBSGifLSMDmDjK4xA3guA0c6GjXT+A6JNvEXmr1RWsyX2i+icKitAQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from BL3PR11MB6435.namprd11.prod.outlook.com (2603:10b6:208:3bb::9)
 by MN0PR11MB6181.namprd11.prod.outlook.com (2603:10b6:208:3c7::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8901.28; Fri, 18 Jul
 2025 21:37:43 +0000
Received: from BL3PR11MB6435.namprd11.prod.outlook.com
 ([fe80::24ab:bc69:995b:e21]) by BL3PR11MB6435.namprd11.prod.outlook.com
 ([fe80::24ab:bc69:995b:e21%4]) with mapi id 15.20.8857.026; Fri, 18 Jul 2025
 21:37:43 +0000
Message-ID: <9d2817f0-5ee8-4133-a139-80e894f32c9f@intel.com>
Date: Fri, 18 Jul 2025 14:37:40 -0700
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net-next 00/13][pull request] Intel Wired LAN Driver
 Updates 2025-07-18 (idpf, ice, igc, igbvf, ixgbevf)
To: <davem@davemloft.net>, <kuba@kernel.org>, <pabeni@redhat.com>,
	<edumazet@google.com>, <andrew+netdev@lunn.ch>, <netdev@vger.kernel.org>
References: <20250718185118.2042772-1-anthony.l.nguyen@intel.com>
Content-Language: en-US
From: Tony Nguyen <anthony.l.nguyen@intel.com>
In-Reply-To: <20250718185118.2042772-1-anthony.l.nguyen@intel.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: MW3PR06CA0013.namprd06.prod.outlook.com
 (2603:10b6:303:2a::18) To BL3PR11MB6435.namprd11.prod.outlook.com
 (2603:10b6:208:3bb::9)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BL3PR11MB6435:EE_|MN0PR11MB6181:EE_
X-MS-Office365-Filtering-Correlation-Id: 0627c0e8-7e64-47af-3184-08ddc64353f6
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|1800799024|376014;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?N3N4Y3hoVFZLZEk0Y2NqVGJTaU1PbDdOUHhISWV6OFQzSVhmNVV4QzV6dW54?=
 =?utf-8?B?Q00ySUxRdWk1STFROEp4QWUreDhJOEg4M3ZkM0haNlkvMGhXYm9IWnZVbkRn?=
 =?utf-8?B?UncveHBLc1FFZ29WRTM3MGpXOUVUN3pBYWtabm5tWDViSUQySTQ0SngvT3Mw?=
 =?utf-8?B?YXRSS1kxT3NtQnk5RGlrcHVmSXlOSVYrNVdrVlozcW5rbmlWclYwTGVVUHh3?=
 =?utf-8?B?V09nTzRBbElFNDk4WDNiNDRwQnFyeVprZlRYa0daWVRLZTlHQko3K1htZkNo?=
 =?utf-8?B?SVpVaXprUE5CejVrd2hEZFAzODRhTFhvNEJHMTFPZWUvdTBjTU1keklJQzZM?=
 =?utf-8?B?NE5pTUE0SFVDQnpmNmJQTDRiUUptbGVVM0ZWS0lKejZSVVQ0cTRUSmVyclow?=
 =?utf-8?B?L3NWYXRBclpPQldHWXA5bVVhRERwTXdzSUoweE5kTE9NZWt0cU1WM1lYNkFX?=
 =?utf-8?B?eVBLelBYRG51YkxhMjJvcGhxcW5TaEYyVG9YenVMVVVCdE1OVTNiZWc0ekxF?=
 =?utf-8?B?eEExY1pnRzFEQzF6NVMxOTRhNnE2d1JpOUUwR1REMnhXenI0QXVwdDZWMFdp?=
 =?utf-8?B?d1AwY3JqRDhkYytkZCtuU2FKQ0p1OTdPNmdNWjM5enE0dGkzbmJtNXJKd05j?=
 =?utf-8?B?NjRna0RoWlhFZ1plNC9tbEtvQnJ1WWozNC82VHJ3R1N0b2J3NEtzZmhRZXZv?=
 =?utf-8?B?NlRaSzRBN3RSYjUxSWY3aXBuc2xaZ3hNUGdYYVk3Q3UxZUJwclIwOHBXVDJE?=
 =?utf-8?B?NmNPeFFTelRMMEZjSHpFMVJXSzBEVWJNTlpMcUpqUnhJYm9qKyt4ODNmUmI2?=
 =?utf-8?B?RERmOFAxUWhGWVYwSHFtaC9pZEc3V29ESFdyTmJkdWVIL0JTOGw3NGZxcmh2?=
 =?utf-8?B?eDJpLy8wYXhGU3N4QTdHOFFBNkN4cE9RSC9ZSDAzdzEvT3BrZTJnMVRxSWpi?=
 =?utf-8?B?RFJzbThZMVc4MFRRd2ZnRVVQWlVKOWNkbWlTeUFOMTQ3b0MzaGdZQTZoZ0hI?=
 =?utf-8?B?N081UUUyLzlmOVhLdVZRbWMvbmc0NlJldzJoMVdKU3ZRc2R6K1c0V2ltYitR?=
 =?utf-8?B?M3NTUEZnbUhzZFV2aVlNYjRwSjM2ZFc0aTBBM2s5RG5KZzBqZVFrSUNoVlpZ?=
 =?utf-8?B?bnFZZkVwWFdFWU82ZXJwbStkRDZFNDhwNFEzVlAxNDBpcGl3QkQ5RDhUL1g0?=
 =?utf-8?B?WVZiRDlQMHNzdXVvN08wWU1CajhkaDFUVDIwNkgzZzJvQys5Tm5DWmRpRkt4?=
 =?utf-8?B?MVN5Vm11cE9GOVlNeFZwa2VOR0RMenVvcHVUbEFuckt3ZGR0WTBLQlduOEU5?=
 =?utf-8?B?Z3VqTXY0bkFPZlAvZWx6ZytiQTFPZWtxQWgyNjFkMi80ZlF5RTZGcFdPQ3Ba?=
 =?utf-8?B?N091VnlLZkhOTXVzcXBETG5ySU4yQWgzSjZOR0E2NlhLMzh3QmtlNVhpSkZJ?=
 =?utf-8?B?Q3Z5WEFDRjJIRUNRSmtLM3lKQmdMNGowdzU1MjBrMmN2eGRnMzRuQlJaeEtK?=
 =?utf-8?B?QnNkQjd1cjBlYjZtZlBRTitxcGVRM0ZlbjRaQVlmUXVBWTMrVUliejdZSlJX?=
 =?utf-8?B?cFVHWktGMTc0dHF4WmMwY0QrWlYvSGdqN2RXMTV0eUM4dkxtdlprbVBPSHZM?=
 =?utf-8?B?UWZFQUZkSDQwbjU0VzFKaVUwd1VZRDFKNVZLcGwxbWMyejdweWZiZEdwU3Ev?=
 =?utf-8?B?UjhzMXR3cGpLZUZJcWN1eUtUSXJHQmhJQURjS1MyampTbDdHQ2VNVkNkK3hF?=
 =?utf-8?B?MjNXcWJKemVuSnF4K21lcnkxWlVpSVJ2ckdlK2tyK3F1NDJTUW9zVnAwdzFn?=
 =?utf-8?B?b09GNTVBYVN4dGZab0ZiY3AwaHNEVnNpTVFweFBsVVl6dUdOQkdoekxQWVRV?=
 =?utf-8?B?UFM3UWxTS0ZGQkQ0Y01mWG1tRmdpcGpOam1jOVl4aXE1WjRWcEZ4TlFBK2dq?=
 =?utf-8?Q?ZP05m+FRuaA=3D?=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BL3PR11MB6435.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(376014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?eHJIN0oya2lKUzBaRDM0SE5OeDB3TzI2cGdRU2h5cE5lKzdMVUVMbDNkaHBS?=
 =?utf-8?B?RUtWdnFmUXJCNmpqTVNOV2NHUFRpN3BzRjJhM29hUFdsTU1vVURBbTdycmhk?=
 =?utf-8?B?OVVldGN6MVdBNXJxQmtnRDU0ZERZTDEzRndKQVc4YVphMUI5WFNGR0RNeGti?=
 =?utf-8?B?N0l6aXk0MWtUUmxibVdkMGhjWk1zSnV3UkNmcmJ0V0NZNzZFWEZEeVF1a2tx?=
 =?utf-8?B?WVlFaUtIbkcyaDd6blAyeGRKa1FHV0VaaW5uaUVacVQyWCtneUExeENvN014?=
 =?utf-8?B?ejFudEZzdVFHRUpadjdvc0VOUUVjK3RvTHMyWXEyQ3hyaU9DbXV0ck8rbEpv?=
 =?utf-8?B?SGh2KytyTHdxRDVRc1g5R2gvclcvMGJnamQ2QXJ3RXArOXFqUHhuT0Frc0Mv?=
 =?utf-8?B?SzYrS1ZPbllSdjJDNzZRZUlCWGtFLzdWdklMbGZnSWtnTEo4YVpybmxvUW1o?=
 =?utf-8?B?Vk5MYmRiSzg0ZDJ5N1pKcUZxUVg2TzYyMDhGeFlVTDFBMnJvK09pL3BBc29L?=
 =?utf-8?B?cnJOK1pRakZIemZwNDNwN1BXMlRDbmdja29pMThiNnlBUlZhdStnVzJMcGVL?=
 =?utf-8?B?aVJJSEw0Z1NrTXJlcWRsVTFnZVg4UWdnazVld21QSTl2ZndNdXF5Y3JDcFhu?=
 =?utf-8?B?Sm9WK25SLzc4V1c1M0hpQ1htZTVpdzR0T0lSZUVKc3EyRHpEZ0pzUnIyNnpF?=
 =?utf-8?B?WTY3YlJtY2pBMFl1NEhOZkRjNVA1WjhQU1VrbGQ2MXlxaURjandLQWZlRFFr?=
 =?utf-8?B?K25Ua0M2cHNpRWZELzZoTGF6Q3BMR0QxTDdjTkFDa3lTbmkxK3hGTllSSisw?=
 =?utf-8?B?VzBPUjZ0YVZoWm1ybTcxVWpMakRlY1czeVBSSmJQOWNRQ1FUUWVJWFZoRENq?=
 =?utf-8?B?eGlKQkJzM1BEeVgwaTlZTTJLbkFpNjRvdnRoUW1MTlJxV29kdldVZ2RjUjZG?=
 =?utf-8?B?ZFU2RHdIY1dNN2tFU0NxSXlxclNzdjRQcE40dXBDdmRJWjdPQWs4S1FBQVY0?=
 =?utf-8?B?aE5sL2VFSDB4MXZ0UjZ4eVA3MXg0b1piQ2NNam1neWJqZnNPUUxaN1hlaXBu?=
 =?utf-8?B?czQ3OXlVSmlmWjcvam81QXhCc0FGRUhGYTFRNFltV0JwZTFCVGpOUkNrKy84?=
 =?utf-8?B?MXc4T3NRcU5Dbm50SklJRjExRVhBdzZUUURYSkhuSDZyQjlqcjV1N0NRb3lw?=
 =?utf-8?B?MVJlZHlQcWQzLzdxamlIT2RtMnV3M0ZUYWZhZjAvV3poQ0VYZHRkc3FqcDlP?=
 =?utf-8?B?eGlyaW9JTlp0UitkN3ZIeUZ1WG5VaGhsZlVIQXljNXZ5NGcrU0xaNklpTEJD?=
 =?utf-8?B?NVJjMlgvZUZUSzdhRXFFeFJDZGY3ZlhkZUlBMjNGSWhLTmxNSUpVdnpiMlhR?=
 =?utf-8?B?L0xpNERnOEhKc05pR2ZzakVnVTZoR0t5L1JsRzhpSmhtZ09DUHZCa1dKamtW?=
 =?utf-8?B?Q0ZvQ0RqNkVLMVNLaDJYM3RRZU01VEQxUkhuUWdEYTlSNHNNdEFhVGN6TVRQ?=
 =?utf-8?B?SDQ2MnRRaFNteU9pVjdiQU9vcmtGR3BtUklVTFNuUXF2QmxRN0VsZVN0d1JB?=
 =?utf-8?B?SkpYbFFGSWdEMXZMbDVTZkl2WE9FZE9qaWdvVmdla1dqM040UVFnb29aVDE2?=
 =?utf-8?B?MFdwUTFBSy9JRjNrTVFtVy9JQUdpbFI2TWlNNTBUSWtQNXNRRThOc0NuNGNm?=
 =?utf-8?B?L2V5T0FMNVJQeldtNUZBcXF1ZFFKY3RYL3BoU3lXSlgza25yL3FZeGJOL0pw?=
 =?utf-8?B?SVRPRjE2YU9iWVFhdmNaM2NueGV0d1llcVMrLzBUMW81aG92cjRYQzhKUk9X?=
 =?utf-8?B?Q3ZDeU5ZUDR0K2NIZDNBa1NlMTFKVU5EMUxkYUdIMGNuZ1RIQ2duZmhBTElz?=
 =?utf-8?B?c2hqVERCbnhIK3QwNkQxdlpaNFFNdDJNQ3NrVmNpbFQ5S2haYmt4aTFvQURn?=
 =?utf-8?B?aHJOc0R2OU5oZGc5ZEZOUGcwVDlMR1dpYm10UWJWeUcxVFlBRFZRNjNkNEtE?=
 =?utf-8?B?MmJNdzloYWZSQzRScmJJN2t5VlUzKzBXbGNybzJuckd3dGQyc21KUXlzZE12?=
 =?utf-8?B?WU9oaDNLMWI4NWVFc2lIQWNZWGpEdUU4aDQvYXNTQmlabUdIRVd3V2RxbDdG?=
 =?utf-8?B?OU5TQzQ4TlFhaCtrVUMzaU44K25PMWdJUjRiNlRWRXZMZW5NSGRpS2h6Tmp3?=
 =?utf-8?B?Znc9PQ==?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 0627c0e8-7e64-47af-3184-08ddc64353f6
X-MS-Exchange-CrossTenant-AuthSource: BL3PR11MB6435.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 18 Jul 2025 21:37:43.2376
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: Sij7mcw7cPg8O8QbTpUTYSPJB1ReneH/ebq4zgTM0AwGlsPxgNfTpLp65BnSVh+hitj4eiPqujgpt70m4zGVxOm+1cgzeue52vXIga4l3VI=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN0PR11MB6181
X-OriginatorOrg: intel.com



On 7/18/2025 11:51 AM, Tony Nguyen wrote:
> For idpf:
> Ahmed and Sudheer add support for flow steering via ntuple filters.
> Current support is for IPv4 and TCP/UDP only.

I blanked on the .get_rxfh_fields and .set_rxfh_fields ethtool 
callbacks; we'll need to adjust for that.

--
pw-bot: changes-requested

