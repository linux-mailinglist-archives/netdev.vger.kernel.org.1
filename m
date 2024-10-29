Return-Path: <netdev+bounces-139810-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 7E0639B444A
	for <lists+netdev@lfdr.de>; Tue, 29 Oct 2024 09:33:46 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 9E72D1C213C9
	for <lists+netdev@lfdr.de>; Tue, 29 Oct 2024 08:33:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 09828202F89;
	Tue, 29 Oct 2024 08:33:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="Q3x0t/YC"
X-Original-To: netdev@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F36951E048B
	for <netdev@vger.kernel.org>; Tue, 29 Oct 2024 08:33:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=192.198.163.18
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730190822; cv=fail; b=NohcDYyKhZe1A0f0E4AgIpCuAQRQFPRiLf9rCf/ayuhg2Z6fhD3aQKvUXEe8bSaEqrUMHv5Wq3uYIKZiAFYPK19F4cZxWdiiIjzocGl03iwXWkippxRfc+4bAEVDEXiwiNQi33uuUGVRIBPZSOAWRkFasIGm1P4m2py5+D4IHQE=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730190822; c=relaxed/simple;
	bh=g6oKl6viG2NgwKpUFKNnAdYAAyUs4FkeH5RvhDZcnag=;
	h=Message-ID:Date:Subject:To:CC:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=DaVD4pARXqS4XygfPzrmIF4G5RuKQt1st3FrWQNouZ85JjEoaT1Kd9uhWxD0AOcCsPmNIOngSQVJQSvXXQLmXdrxD5PJl1hXgKdPZS1grUAKHbwH6PV66gUOvo7mRxnkl6jx35cDbJr2ENxDf+Fz4GMAYrQCEciTHlqUeod8WyY=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=Q3x0t/YC; arc=fail smtp.client-ip=192.198.163.18
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1730190821; x=1761726821;
  h=message-id:date:subject:to:cc:references:from:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=g6oKl6viG2NgwKpUFKNnAdYAAyUs4FkeH5RvhDZcnag=;
  b=Q3x0t/YCg/UzbSG/WN4riWbc9yTYWObWSU1ccXLYT3PpbBIXVHG/FzaO
   x1ZJxFrVsq156Zs4/RjQKTRkobgcz/cvuWTJJPposDPgQoIiichKNJ89j
   IVj27S3dk+n8/+pSQh3jozGCPh6v47xnXofW7TP5RADVCSEwI8OSS0kJW
   kJG6k7qCjpq1UpKVws50H2MWnkh6sKqZ3Va0JcLQlS0wCzrf9Fa2WbttJ
   uvqbROLy7n0ESd0GJz4q6rTdG9cvKsQ66A3HE3ymWvTI+445UccW6PWt+
   9izg1to+imIQweQiUmyU4iYoHWSnOIj82L7cuFTj3yM+0C0jbzifbtnRg
   w==;
X-CSE-ConnectionGUID: onGaRl/lScO784C3ME4+CA==
X-CSE-MsgGUID: EXFG02lQS2y7HtBd8XBkPg==
X-IronPort-AV: E=McAfee;i="6700,10204,11239"; a="29246332"
X-IronPort-AV: E=Sophos;i="6.11,241,1725346800"; 
   d="scan'208";a="29246332"
Received: from orviesa009.jf.intel.com ([10.64.159.149])
  by fmvoesa112.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 29 Oct 2024 01:33:40 -0700
X-CSE-ConnectionGUID: uV8acMt2RmeEFlv4AxhJ+g==
X-CSE-MsgGUID: KDuGvKrVQYCjroAxe2GA0Q==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.11,241,1725346800"; 
   d="scan'208";a="81817352"
Received: from fmsmsx601.amr.corp.intel.com ([10.18.126.81])
  by orviesa009.jf.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 29 Oct 2024 01:33:41 -0700
Received: from fmsmsx603.amr.corp.intel.com (10.18.126.83) by
 fmsmsx601.amr.corp.intel.com (10.18.126.81) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39; Tue, 29 Oct 2024 01:33:39 -0700
Received: from FMSEDG603.ED.cps.intel.com (10.1.192.133) by
 fmsmsx603.amr.corp.intel.com (10.18.126.83) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39 via Frontend Transport; Tue, 29 Oct 2024 01:33:39 -0700
Received: from NAM12-BN8-obe.outbound.protection.outlook.com (104.47.55.174)
 by edgegateway.intel.com (192.55.55.68) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.39; Tue, 29 Oct 2024 01:33:39 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=kyzoWozpyoALatnNsnbVVsJHqhcpeBuBpCATZEh7X+hEg2ljZz0mFuUeN5VSuWZ8eavitp+FfTJcOwuuLKxcy8XZ26mF8JaYHCLm8yc5D9ePA4KU5/HagY7wV4P0jHv1DdJq4D/QQCW+Mgvut9UHyM5pVvG9Y7RbujWhr+Zp7ywkx9Jop6ge5kdhauPJZj0JJbGNveCMrkJJaV2P/dTQfR4cNHqZIH1IWNnzrdw4ikntvMS/OmCJfbVM5FLknP7kbQn40jE+4+YCgMFXQNh26H/siAfaTTeRU6afqqLu4n2QSQ1EYEXXEWZHOfecELx18cIVdQW5FpbhaNSwjcM2eg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=a2xM5k5LKwKnQNoVGYCss59eg6WrS9L+zRwnmS1QxkM=;
 b=Yeb2WNUYEYQwkyacg6kTLMPGf4smnJtgrfJ/AjJGlEMplFd7Uj4YN0c7RDxnx3513IW3BOQca/HWfo7rh623ne6Xd/vuastnOxz2DUpgTLEZwo4K80II7xBv4YZtwLOYB0nuy1H8pfhsvk0caBwy8EWy1zUwG2AuuCLNJ9LTOEFGUx8uw/A4bnBqBTM7uWiV+lHvo7yhhN+HDwDDPaT/NjGc0pi661AiXTPYYPPldUp+bXq46eu3GtwfsbUsuljy5tPf94fFnxlRlc9QD9fgxHQBGfa64T8fyHN8g5SMLAEFh7dLyd5e/a5hEfMUYEjPzDG53DUsBIjV4jW9S6KWMQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from MN6PR11MB8102.namprd11.prod.outlook.com (2603:10b6:208:46d::9)
 by PH7PR11MB7663.namprd11.prod.outlook.com (2603:10b6:510:27c::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8093.23; Tue, 29 Oct
 2024 08:33:36 +0000
Received: from MN6PR11MB8102.namprd11.prod.outlook.com
 ([fe80::15b2:ee05:2ae7:cfd6]) by MN6PR11MB8102.namprd11.prod.outlook.com
 ([fe80::15b2:ee05:2ae7:cfd6%6]) with mapi id 15.20.8093.024; Tue, 29 Oct 2024
 08:33:36 +0000
Message-ID: <b6abb7f2-22a3-4e93-a201-292e2b5f907b@intel.com>
Date: Tue, 29 Oct 2024 09:33:32 +0100
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 iwl-net 0/4] Fix E825 initialization
To: Grzegorz Nitka <grzegorz.nitka@intel.com>
CC: <netdev@vger.kernel.org>, <anthony.l.nguyen@intel.com>,
	<intel-wired-lan@lists.osuosl.org>
References: <20241028204543.606371-1-grzegorz.nitka@intel.com>
From: Przemek Kitszel <przemyslaw.kitszel@intel.com>
Content-Language: en-US
In-Reply-To: <20241028204543.606371-1-grzegorz.nitka@intel.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: WA1P291CA0008.POLP291.PROD.OUTLOOK.COM
 (2603:10a6:1d0:19::19) To MN6PR11MB8102.namprd11.prod.outlook.com
 (2603:10b6:208:46d::9)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MN6PR11MB8102:EE_|PH7PR11MB7663:EE_
X-MS-Office365-Filtering-Correlation-Id: 5c6499eb-c739-4768-d98c-08dcf7f461de
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|376014|1800799024;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?akdtRXFXQkVQVlppN282aFpMVGN0Vkh3NVdRdVpVN205THNSSTNlSU8xbFUw?=
 =?utf-8?B?N2p1QTJNQ1pOQ2JBTGhBa210bmFweFJUZUxXMFE3bVQ0SGFleStCcGo0MEJP?=
 =?utf-8?B?UFF5STFkQW1WMHVocXIvSXBlMktzbk83QUZyY25EaS91bHlXT0J3Qmw4dXQy?=
 =?utf-8?B?ZXFUa1lYWUFPU0ZLVG1mWUtLaW42RVhRQ2tnaWoyVi9iZFd3d0VJbDkxN3BK?=
 =?utf-8?B?NWVFSE9rdU5nY0NDditKRzJYdUxEeGhhNWFhQ2xya3lYOVZwTUZtdTVFYzlq?=
 =?utf-8?B?eVAyWnRJK2lVQWJRaVJwVWg0VlNDZWtHVkI4Y2s2c0ZVU0lzbFFuQmlDWTlY?=
 =?utf-8?B?SlIvWXhwaThOMXVGY3VSbHkvcGd5d1IzdnFXa3JiRGlKMUROK3hESW1sclp3?=
 =?utf-8?B?ekZPS3plQnFzNjNCYjNxZzZVZ0d1OU1sUjBpbDVFQVRrM1gwZXNMOFU2NGJZ?=
 =?utf-8?B?aUZ3ZVNQeUE1MXk4cGNldE1QRUczTno5akgvaXdhemc2S0NUYTVCQUF6dVU2?=
 =?utf-8?B?dTJ1a0Z6QW1scVpwZWhVNFdoekM1Qm9ac1FzVmp5TytnZ0lWNitvZ2VSOXlU?=
 =?utf-8?B?ZGtXWGFQODR1ZUN6YUZISFkwT2F3VUdFQjhlaDlZcXlaakc1dCtUOXMzeUEw?=
 =?utf-8?B?eXp4ODdsQzNTZG43aUNiOE4yaTIrbktNVTdmQ2xwRDVZMXIzajdGYmVDT1lR?=
 =?utf-8?B?VlJrKzk5clkrOXdrZGNWbU4xd3VaaFBQempwN295Mnd0QTZNbWszd08zejNL?=
 =?utf-8?B?TkhPU2FTMVVnYzJIVnJsc1NjS3liWHlpZmNTM3gyYW44OWFxM0VjL0ZjTzBi?=
 =?utf-8?B?N0p0S1BDbXdvaW0rWG1qT2V5ekRsdWVMVEY3TTE2am4zN3ZZWU1GOVVSOEpP?=
 =?utf-8?B?Y2FNdjA5UzIrMk1YZVBUT3ZUallQcmpiWjlPeExiK1BtcmpTekF4MXJSeVA0?=
 =?utf-8?B?UHdtTVpHbEZEZldTTnFoT2xOOCtTeHk5WHQzTHB4YXhiS0xmUUgzdDJJTDFm?=
 =?utf-8?B?b2Y4UzZFZFF0TEc5dHQ5c1BQZHpaMERUeVByayttUmVXNWdHVklYWTJKbjRG?=
 =?utf-8?B?ZmF2ZThFYmFFd2Z5b2RLdWpwbS9lamxVU1NwM3ppZE5uQ2JWc2swS2szcWVX?=
 =?utf-8?B?NDdBb0pjbmRaMGFjTXY0MDlBbHhFNkVtc285Q1BHRW5vajhxbHlCZm9lL1RE?=
 =?utf-8?B?Z2FmK2plMzBRYjFFOXZ5ZXBmZkN0ZHhnK1Z0a3Z2NGpjNFhrWTgyZEtmUFNW?=
 =?utf-8?B?Vy9xKzdxVjBnakV4dUVEbTNpaTIvUGhwUmNFMzMwWnFBWlNBOTFLL3NvNVVZ?=
 =?utf-8?B?Q2dNb3dXalM2SS9qSVJESm9nT0tCQ0pJTnY2T1FoWTVZM2I0d0RxaDlEQ1pv?=
 =?utf-8?B?bE50dXF1M1dJd3N6WUFxdGRFakVGYTh6QU5DY0MxNjVjZFpNUUhIN1JXRTRS?=
 =?utf-8?B?SzFpaFUwWTA0OHNPQkphR0xFNERzbHpGcEFnQVJoTzZxcDVqaVlza1hpU1or?=
 =?utf-8?B?MW90NjY2bklmbTA3S0ZoNDhyOHV6clZYZ1diWmU4NHpjUWVGU2o1aG5Ic1p2?=
 =?utf-8?B?aVR3MCtOdWNJR2ZkLytIeERkbUFXcUpuRUFxNFFvYnZQUFlzRnZjTkkwV0tZ?=
 =?utf-8?B?dWdkYVZidmNSUk9ld3NRNmtIWmxmQnFCRTVsa29OcDZYRGVva3ZrWG1pUEpB?=
 =?utf-8?B?UE1ZOVBmL1FjQ3krbE5jRmlqZDFlUWQ5NzhYMkk4SUFSb2ZzVUVLdDVTMDNM?=
 =?utf-8?Q?qjyJVvMGnZlw7jSex24W0ca84IeUpKoRsSPxRYQ?=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MN6PR11MB8102.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(376014)(1800799024);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?TC9LakFjNk5oTlQvQVE4QkxrdmY0T1p2aVVyZFVQSytMZG53TlRjUFJaMUFL?=
 =?utf-8?B?Zks2dVFRWWJHZHFjblJnVmp6cmRXWG92TlVjaUIrbmhaV1B3MDA4Y2NHQWVk?=
 =?utf-8?B?b1pZQUZhekczRzNpOGsvaERNR1JGZkZ6cE5qcnp2cy80NmxUc3IvYkNYZWhN?=
 =?utf-8?B?ODZWTE5Ybjd2cEt5YS9CYVdaTUxPTXR2QUVNNnZKZEdTWWVyK1VDUFVTNFpp?=
 =?utf-8?B?ZXlMYzh5djlHL1lZcC9xV1ZqTHFIOFd6cjhzdkpuMUdEdUsydUY4bTdLeFdO?=
 =?utf-8?B?VTlEUDJQRG1WVW5nbTF5OWp2YzhHMDNDbi94L0FJbHFUM0dlWHE0NHBWNEox?=
 =?utf-8?B?MUNvNkdoWFBSSkFrakRick9JYzhqZzdFa1Q2cjM5MHpoZ2NoSlh1WUticXNp?=
 =?utf-8?B?Tm8yRXZlbXppVG02UVgvK1c2V0ZWR0RQcEQrMzRWQ2liVEFuNk5WbnlLNkRs?=
 =?utf-8?B?L0dTRW40NDVFb3dlUGNnemVUcVlablJvcmxHek84VnlieE9ENjRCbk5BNFNh?=
 =?utf-8?B?OWJrYXZkakhhdkJneXduZEI3Yk5uYy9lblNXd2gxTENmSUl1NkdoSS9TejNZ?=
 =?utf-8?B?WDg4NXNjelhNVmZ3UjhIeThRTnR4YXlGN3FKbktpbndSdWZiNjJNOFZvaHNl?=
 =?utf-8?B?NDAyZTduaWhySjI2cjgvTk5hYjVCNmRzQXpIVmYxeUs2eHlYKzV5Wk5BUDA1?=
 =?utf-8?B?QWU5SXdpUUpKTUFHeEl1Qmx0eTdKL1JmVy90TkZDeDB0WmU2eWZPRDhpaXhs?=
 =?utf-8?B?UWtFWkltNW8yRmx3bzlCZ00rSTJGRVN2NFo4LzJzc05HRmlHeG0vdU8zK0Y4?=
 =?utf-8?B?ak4xMjNvTUk5cXBRV1ZkUGRkb0Z5R09XYjV0d1ZiOFN1UnhFQ09OWmRyNFR5?=
 =?utf-8?B?QmFMZTNuME91d3VQbUI3eVhqaWZnMkhPVW11RTROSmZLU0tyZnE2TTJnOFZN?=
 =?utf-8?B?SUF3RGhPWHFFcjlYU3Y2eUxlTlpvbjBEUExmdG8wZ0NVamdkTXJwTUhSK291?=
 =?utf-8?B?Y1RZOTZXUUdlVUVLUVJOaUhNL1cxaUtBa2RmRE5UNnJ4a2RHZzBpRzN1N2lG?=
 =?utf-8?B?bWE3bEVjeTRXVTdIRjI4ckhjWVdQL1hVY1VzejJ0bW9aQ25DOUVtbkx2RTJU?=
 =?utf-8?B?VG56dkJiTFVkK0dyc0lJLy9xSDlEOXRzWDR6bXhzRTI2cmRMZ1dGNTY0MlY0?=
 =?utf-8?B?ZjR1anFiNnh0d1grKzREN0ZNRG1sMVJsWWw5dXVNeTNwYmNISExxNHJjKzJV?=
 =?utf-8?B?bVNmbHFiTU12ZWVUUE9WT3BKR0ljT3JNWjBpZmx5bEVvaWhOckpIWUp5YUVI?=
 =?utf-8?B?SCttY2FXaTlJRU1va2lTWUJELzVNYmlabG01ME9yWFViVmd5N05ocGhtU1o4?=
 =?utf-8?B?dHNWSS80WmFEbWx3aHRTMkx5d1hhcHJBK2c1cURwazVZbSsyU2F6QkVvamxm?=
 =?utf-8?B?ZVlSMEFEMVZaSkRZQXdpa3BtclJpYWdoU0ZSYTB3dVA4V2RSTzh0NlA4bHV6?=
 =?utf-8?B?RSs1cjFBMkczcmU0anV4RGNIUU11T3FGZ0VlV2dNbzh4NGVIOUE0MHhscW5V?=
 =?utf-8?B?N2JNYUxUaUlwVFNRWlR6UXJaQ0xqSDlhMzhFV0s2NTA2SXJRMUZqTUZNT0Uy?=
 =?utf-8?B?MzFUODZoMnNiMVB0Q2VIWDMyYllnVWtwM3ZiTGFHSmYzL3g4bWZVN0w3UkI3?=
 =?utf-8?B?RzQvVXhaeTVsb21tMVQxUkRoc294ek00VUI0K1ZiMWk5OGxiQm5PR3pCZmJP?=
 =?utf-8?B?VE96Tm56UVhZZUR2V1VFNXBKT0w3QmkyajUvMysrWUxUWWpGNUk1RHhlbTlN?=
 =?utf-8?B?a3FtMnJITit5OXViTStOaWRzaHNHK0F1K2ZuZTBPb05UV1VTVmlRTkg4QVV6?=
 =?utf-8?B?VVlCWnVpYWtQL3ZVVzdQVXF2UytSRExsbFBKTXlWbE1wNmI2UldYV2pwWjV6?=
 =?utf-8?B?NVB5cDZ4RFcrRGFDeEh1eUNxUjdNTkhuaitWajQ5M3J3OHhjVU5xSS8rb3lM?=
 =?utf-8?B?OW1PVjNlQUFQVWJZVytBQXJwY1RiSjBkYVlXYjZTSFdoSTRnSFpGV1BsTlpE?=
 =?utf-8?B?bjA3VmFiZFlSZW05YlBZTWgvM1hqMjZld1JpS0NNZzFiaktHK3ZqY2ZUdlFO?=
 =?utf-8?B?Z201VC93QVc3R2NCY015ME9lbXZNMExpMTE5d05Cc3hNMDlTQk9kV0VjeHMw?=
 =?utf-8?B?V0E9PQ==?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 5c6499eb-c739-4768-d98c-08dcf7f461de
X-MS-Exchange-CrossTenant-AuthSource: MN6PR11MB8102.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 29 Oct 2024 08:33:36.6810
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: gsoOjGndA5cEZT6kPbYaOawwmhw8kvIyKMyPio9KtuHdlBMXDbKKgBSLTRS3hmKA0GV3KOJFIevpmri5GDrEWBg2aw5jYcdEpEq8DS9zA3c=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR11MB7663
X-OriginatorOrg: intel.com

On 10/28/24 21:45, Grzegorz Nitka wrote:
> E825 products have incorrect initialization procedure, which may lead to
> initialization failures and register values.
> 
> Fix E825 products initialization by adding correct sync delay, checking
> the PHY revision only for current PHY and adding proper destination
> device when reading port/quad.
> 
> In addition, E825 uses PF ID for indexing per PF registers and as
> a primary PHY lane number, which is incorrect.
> 
> Karol Kolacinski (4):
>    ice: Fix E825 initialization
>    ice: Fix quad registers read on E825
>    ice: Fix ETH56G FC-FEC Rx offset value
>    ice: Add correct PHY lane assignment

Grzegorz, thank you for picking this series up!
It is legally required that you sign-off too, but please wait for other
feedback instead of rushing with re-send ;)

> 
>   .../net/ethernet/intel/ice/ice_adminq_cmd.h   |   1 +
>   drivers/net/ethernet/intel/ice/ice_common.c   |  47 ++-
>   drivers/net/ethernet/intel/ice/ice_common.h   |   1 +
>   drivers/net/ethernet/intel/ice/ice_main.c     |   6 +-
>   drivers/net/ethernet/intel/ice/ice_ptp.c      |  23 +-
>   drivers/net/ethernet/intel/ice/ice_ptp.h      |   4 +-
>   .../net/ethernet/intel/ice/ice_ptp_consts.h   |  77 +----
>   drivers/net/ethernet/intel/ice/ice_ptp_hw.c   | 281 ++++++++++--------
>   drivers/net/ethernet/intel/ice/ice_ptp_hw.h   |  37 ++-
>   drivers/net/ethernet/intel/ice/ice_sbq_cmd.h  |   7 +-
>   drivers/net/ethernet/intel/ice/ice_type.h     |   2 -
>   11 files changed, 247 insertions(+), 239 deletions(-)
> 
> V2 -> V3: Removed net-next hunks from "ice: Fix E825 initialization",
>            replaced lower/upper_32_bits calls with lower/upper_16_bits
>            in "ice: Fix quad registers read on E825",
>            improved ice_get_phy_lane_number function in "ice: Add correct
>            PHY lane assignment"
> V1 -> V2: Removed net-next hunks from "ice: Fix E825 initialization",
>            whole "ice: Remove unnecessary offset calculation for PF
>            scoped registers" patch and fixed kdoc in "ice: Fix quad
>            registers read on E825"
> 
> base-commit: 19acd6818aa7404d96cd5d0e4373d4ebe71448c2


