Return-Path: <netdev+bounces-212130-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 0B989B1E280
	for <lists+netdev@lfdr.de>; Fri,  8 Aug 2025 08:49:06 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id C982318911CB
	for <lists+netdev@lfdr.de>; Fri,  8 Aug 2025 06:49:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 743251A2381;
	Fri,  8 Aug 2025 06:49:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="LfTMbHE8"
X-Original-To: netdev@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AA8D338DD8
	for <netdev@vger.kernel.org>; Fri,  8 Aug 2025 06:49:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=192.198.163.18
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754635742; cv=fail; b=PGLKOUpuQoVNlqTzlltAbeJkybye/dz+QeJIO2R/LTlsjrsbx2L22D4hl8UchyHn0H2E4Y0vXt0HXceqz5jGQkwc8zlULJtHvIX/urfDUXnnFOddYEw908O3KmJdAklKoe2oL6hzxml/yTJnKqHob6ATp4fu7684QBclBei7Yf8=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754635742; c=relaxed/simple;
	bh=Mq/tfhD9MK3CNs1S2s12pEzD7XXcxQta5mwvElObbGs=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=WCSKu8/E3wdJPcIrjgQ4Q0IYPDek8mKy9ifUgwdxil42AhaLX7clMR8S3RHuenT80c+NpJPcLPejn1w+3GBhjAdYObwoGq/j7wj9M4Nw7/8M1wV9UBRXNlO1N2Skc6dzxfUggP8nCENS85d2OeraDTW8O/6yCz3AoWyzhA6ZUSM=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=LfTMbHE8; arc=fail smtp.client-ip=192.198.163.18
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1754635741; x=1786171741;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=Mq/tfhD9MK3CNs1S2s12pEzD7XXcxQta5mwvElObbGs=;
  b=LfTMbHE8++NK+ELcCqDVKJHfqCL2CTRAUJ+vudM5Wmjf8BlOh4GA8ukV
   JqvFxshDr7UVEf9C3IDhcNVFTZeW1ZeoUKDsQEu158DSuvfUDmW39hyoc
   tQ6oaB3DMvqyttCHBDyuz8UrjDZldfzkLaTAHLrA64YtIBnE+yiAc5pI5
   royg69v1y4Ow3YicS5pfIWG8mBTZDF+LOv3SwfY89EyRC7zBP0YIuqbrq
   Xun+2EOMKDaBYwNca0BC18qOp5YiRtGYx7bQ0a4Y7EJ216xg8xgFFSxF1
   3itjRoPUubj84ElBphAGxHOJJgBSmOW7HKLufgoufrd+lyfnz7kQcLnT8
   w==;
X-CSE-ConnectionGUID: 8XYETRMySq+7kyPZevGVqw==
X-CSE-MsgGUID: gmovmNSnTxeGmyMrdirYkw==
X-IronPort-AV: E=McAfee;i="6800,10657,11514"; a="56184028"
X-IronPort-AV: E=Sophos;i="6.17,274,1747724400"; 
   d="scan'208";a="56184028"
Received: from fmviesa006.fm.intel.com ([10.60.135.146])
  by fmvoesa112.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 07 Aug 2025 23:49:00 -0700
X-CSE-ConnectionGUID: +6MvQLOJQouces7shp/YqA==
X-CSE-MsgGUID: wVL7g45jQyq05CyDBTIJNA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.17,274,1747724400"; 
   d="scan'208";a="165160101"
Received: from fmsmsx902.amr.corp.intel.com ([10.18.126.91])
  by fmviesa006.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 07 Aug 2025 23:49:00 -0700
Received: from FMSMSX901.amr.corp.intel.com (10.18.126.90) by
 fmsmsx902.amr.corp.intel.com (10.18.126.91) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1748.26; Thu, 7 Aug 2025 23:48:59 -0700
Received: from fmsedg901.ED.cps.intel.com (10.1.192.143) by
 FMSMSX901.amr.corp.intel.com (10.18.126.90) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1748.26 via Frontend Transport; Thu, 7 Aug 2025 23:48:59 -0700
Received: from NAM10-BN7-obe.outbound.protection.outlook.com (40.107.92.54) by
 edgegateway.intel.com (192.55.55.81) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1748.26; Thu, 7 Aug 2025 23:48:59 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=mJzt14CiYQhOPCX9ug7h+wtSiWksSFuEuPnD+Wu6dlHW6SpV/VeqQW1ZQKFhxUDIhXLUXzcYyrYlt8ZvRBGZ+JpIxDQ+yMhr7Uqo0PN2t9yXSq2OmIJxHGnDlycpq2nDYZLkFrPGGMocbwqkFXqspBOroz4iTr6FlAciGFSy/ne+y5AJ2vSfTAIy871syWovOnIuo4hFRy4PehJelLWoBC3uhDkS3bXj4K5hc+LFvMiWbNDsA+6kLxn4egXpEyvZeWbIxQxDyRQ/+GXlCjch4WIMjIIw2Ev43Hqxjl4rgEoZlzjRMXT3m2yPBFkWzPuulfjgAcJbRPP7IfUfVU0pxA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Mq/tfhD9MK3CNs1S2s12pEzD7XXcxQta5mwvElObbGs=;
 b=LnbMuGz3XcvaG1ezZOcHjvk2oTQdcLmoxBzzbIhd0K13Lvt6ZdLME998MFkH/Z+3yyG4wIumnaJVcEdMnbTJQEzbHj4DcmuxZUqiPMPbSsUkCUdl8Jmnh0p+6QWojjsTllMTnxqMW9kL8PbYCui7O0lhWz1TwNUQ2QFxckbICqdXs7FVPjmEyLHzTxxoJmQXHnwtgnU3/syUkjGLnsnGjKJYs4snxk6GjtyVQm86pr+ASIZ8K3M2YjpybVI8SAnA17v2muXN1Brz+msFEA9sMh2xOa1TSH7Jjp39le0W8azqlghPg7cKia2zP57vjZ4WLH8rTz2BuD7lppnAypoBKg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from IA3PR11MB8986.namprd11.prod.outlook.com (2603:10b6:208:577::21)
 by IA0PR11MB7934.namprd11.prod.outlook.com (2603:10b6:208:40d::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9009.14; Fri, 8 Aug
 2025 06:48:57 +0000
Received: from IA3PR11MB8986.namprd11.prod.outlook.com
 ([fe80::395e:7a7f:e74c:5408]) by IA3PR11MB8986.namprd11.prod.outlook.com
 ([fe80::395e:7a7f:e74c:5408%4]) with mapi id 15.20.9009.013; Fri, 8 Aug 2025
 06:48:57 +0000
From: "Loktionov, Aleksandr" <aleksandr.loktionov@intel.com>
To: "Keller, Jacob E" <jacob.e.keller@intel.com>, "Kitszel, Przemyslaw"
	<przemyslaw.kitszel@intel.com>, Intel Wired LAN
	<intel-wired-lan@lists.osuosl.org>, "netdev@vger.kernel.org"
	<netdev@vger.kernel.org>
CC: "Keller, Jacob E" <jacob.e.keller@intel.com>
Subject: RE: [Intel-wired-lan] [PATCH iwl-net 1/2] ice: fix NULL access of
 tx->in_use in ice_ptp_ts_irq
Thread-Topic: [Intel-wired-lan] [PATCH iwl-net 1/2] ice: fix NULL access of
 tx->in_use in ice_ptp_ts_irq
Thread-Index: AQHcB8G7iXBS3idtm0G98HdGrM0yHLRYUXgg
Date: Fri, 8 Aug 2025 06:48:57 +0000
Message-ID: <IA3PR11MB8986E0CA0981F097D733C1B0E52FA@IA3PR11MB8986.namprd11.prod.outlook.com>
References: <20250807-jk-ice-fix-tx-tstamp-race-v1-0-730fe20bec11@intel.com>
 <20250807-jk-ice-fix-tx-tstamp-race-v1-1-730fe20bec11@intel.com>
In-Reply-To: <20250807-jk-ice-fix-tx-tstamp-race-v1-1-730fe20bec11@intel.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: IA3PR11MB8986:EE_|IA0PR11MB7934:EE_
x-ms-office365-filtering-correlation-id: 5f942011-81c5-4050-e530-08ddd647a5ef
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230040|1800799024|366016|376014|38070700018;
x-microsoft-antispam-message-info: =?utf-8?B?WkxFSHRYbXR1bmFLYkZ6ZGFLZXBPc1dja3FkcDVzUmpRSkIwSTAzREJCalEr?=
 =?utf-8?B?S2lUdWFEZ3Q4a29DbEpVUGcveU1hLzJpTXVIZGZCVDVSOFRKSWNGUnJocmh5?=
 =?utf-8?B?VWZnbm5lRjdjR1Jxc1hmdDZieFVYMGlaNm1wdUwySzhKaVN5UjhRWFpyK0pJ?=
 =?utf-8?B?SlpBL0xkNU5NVFQ3QmE0N2EzOHJ5MEMvcGF6Z2c4UEtwWis1Z1ZTN3QvcUtH?=
 =?utf-8?B?MHJJQ1V5MHI5MzhBMXBvZjh3aWNiSFhCNjVnQnNJM3hZbGNPaGRYdWtmRFdD?=
 =?utf-8?B?L09NNnFPN0xRcFB3UHVjTGlrWGxMUkVISUo4UzVmZEt4cGI0UEUxQUtBcE15?=
 =?utf-8?B?Q0E0QkNzWm1tcm55N21tUXJBR1Y0aW0rSVgyMkV2dEZIQzBrY1JUc0tnNTJk?=
 =?utf-8?B?MFBVd2hwbDYrZm51YllUczdjUmNTZlBqYUViWmRNTUZKc1k0ZjhmemVsME9y?=
 =?utf-8?B?WmRiWEMyUjJZWTBlQzV1T3BQL0VZSDg4SVdielJQZEtta3M4ZFJmUTN2cTBm?=
 =?utf-8?B?d2tjTkYrRFplbStjd3NEbW1jU0ZnNEl5cFJsTzFTZkZUbkVwSXl6Wk5DbklN?=
 =?utf-8?B?R2dHd0VyVHloa1AvdDNZc0hJdm83ZVdzN09MNnVwRHEwNzR4Q1diUE9SQzls?=
 =?utf-8?B?KzNQV05wNU5qUzlVSnNCbTNTeG9MWFVmUWRuZDA0czRpUVQvV0Q1ZEczUkdX?=
 =?utf-8?B?YjZYaHQ3VU9tc1E1UlB2WEE0cWZ6eFk3cFAvdkJZQ29Wdm5zS0NjbHlOVlRH?=
 =?utf-8?B?b2poWmhQL1QyT0Z3N2VTSmVsNmhDMjdocDVFRVpqZzdzZjJYVUpTeXg3Sjhl?=
 =?utf-8?B?VG5DbS9vWWxpT1licG5UbVBrZ2xUeko2VE9LbDI5MnhaZThmcUs0VXFldW1L?=
 =?utf-8?B?NndkK3Zibk9LQWFLcXRLRFZVTG1HTFFxaUE5WElrN1lZdXYxZ25zTVhZeG54?=
 =?utf-8?B?TUlIMzB4QkRwaEp1TnBjZGgvaWNrN1plWkU2clYxcnQ5bUJibkg4dG5FSXJX?=
 =?utf-8?B?dldZWk9WNk81cnFEbEp5OWtyZzY2RXZqem9RUXpndHJRUWs0NmZScVRpZzZN?=
 =?utf-8?B?MWQvZi9SLzIrVG9BSHUxaXBlNnNKZFlkU3FiYnlXenRkZUFTY1UxZWdJd1ln?=
 =?utf-8?B?SGp6UFdvUit4U0JwZVA5WWd1a2RMb1lLZStxSy9iNFFQcFp4NTZlR3h6YVg0?=
 =?utf-8?B?K3c1WGpSRnlUTUNwQnQvRTRldDlGL2ZQTVh4THdRZ0dFK2Yzd2srL0NOZkl4?=
 =?utf-8?B?QlBOY0tyQWNmU1hPZEpYcFV1OEswSHZaa1FlRmNEWkJQWWw3eG5OVlVScEtt?=
 =?utf-8?B?bFZESlBKanRxdWw0YnFId2FaeUd0ZitULy9yNTdiaDNLUGZPelFxM2tqTDkz?=
 =?utf-8?B?WC94Rllzamk2SzBVaHJmdm9RY0JBSzNDaEdVU0ZUNmRIUUVGeWdIRm5LTVpY?=
 =?utf-8?B?MW9KQ3V4aTV4YUF2T3BvKzB2OE94NEFwUnhUMHRxMzZERnNvdGhVbXRoNUlj?=
 =?utf-8?B?d2lKdjU4dVZFT2Q3djdRTC9Rd2xQcjVXMHJTYVR4SnQ4L0dVaTJEdTBsUlJC?=
 =?utf-8?B?aTAxYzJMNE80ZXU2Tld5Wm8rUW5jVC9URkZZVGlKYmZML0tLb1pkOXlRWmUv?=
 =?utf-8?B?UStpQTlYQU52VEl0RUNLYm1iVDMxZGxoVk9UM2Qwb2F2WmdSWW9UTXVZTWZP?=
 =?utf-8?B?SUZZcDZmQjluVFExSkFVenhMbmF0Ym56OEt5MFl1c28wcExrTGVrWEJoWVlr?=
 =?utf-8?B?bCsyc0t0VVRUY1hWWjhzNGY0Y2JzZUxlenhXd2tOVVlVeWJ0ZFliVWpCRDZU?=
 =?utf-8?B?OFBIYkV6cHFTd284bzNGWm9NcHVYZ2Q1bE4wRU5QYnIxdW5CS0VhWW1yK0h6?=
 =?utf-8?B?SDhJMTNYSE9TcXBTRHJMeS9RS0R3ekhsY0lCS0t4cW5zQlRXSmtnM21YR1J5?=
 =?utf-8?B?dkdQS0crUEFtVW0vc3ArbG9hdk92cXl4a212c0pnanpWdWZXbVFXRWtQWjly?=
 =?utf-8?Q?2sLbgRVl5iCn4Qk0t6pPO+ePHPfsaQ=3D?=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:IA3PR11MB8986.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(376014)(38070700018);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?T2pENEJGVlQyd0lhN1hFNmZSOEhWUUtpenBPNVFKd0YrZ3AyK3JBTkRwbWtD?=
 =?utf-8?B?QmlIWlRBYVpHd2JSRGV5R3hocTJabGtoM3h5UlN3R0R6Y21qTHo2b1B4TmFl?=
 =?utf-8?B?cXdNZDJTNFFURkllMUtYUjBiNE9rdzhIYzc0dEM5SDFzSXB3NUlvM214dmtz?=
 =?utf-8?B?VWNUZW1jS1p1VEROVmRyaW81ejNTNHhzMnJOcUVhc0FhU3ZzUVF2OHlMZ0lS?=
 =?utf-8?B?cFlkWjVTcDVVa0ZUSTlOTjdsVWhCVHdxOU9YWmtQeDhPdTZ1S2VaejlzL1Zj?=
 =?utf-8?B?MlVyQUY3QkNtdnM3RkFqK0RyWkk0cjFXRk9oZWlCUnU0TVlLRGZJaWU2QUsv?=
 =?utf-8?B?cUUwV1V0YVBrNS9jcDQ4UjlGS21nak01cHk4UEtVanpwaXpOUDZYSC8zVUt2?=
 =?utf-8?B?dVdvT1VGblJyVTJWVTVlcDFPcDh0WHNjcGtVdEhWY240NHgyakhWTkVvekdJ?=
 =?utf-8?B?YnZjL3hneEltSzZMRzQvTVU2dFlmeVJ6V0dhKzNrUGhZVDhta3VmQlNGaEtX?=
 =?utf-8?B?a1N3d3dRRWIvdmZYaGladTFlczZFdUpMVEYyVzVLRUdtSkJCYTVsV1N4NytU?=
 =?utf-8?B?Q1ZPLzlLSEdYT0k0UmJpQlhNeXVwajFEOXBocnlJY2E3SlFYb0JHL1M4eXR2?=
 =?utf-8?B?YjdvMzF0OWY2UjZjY3NsZTZGMk1UY1FNeU9nQ0NnUXNCKzNPdVhDaVFiWHM5?=
 =?utf-8?B?Rnc0OTdwU3AvNmVrNjdVSjFHK3JibzBIaU45U1VORW1vQndERElkZEVGd2hY?=
 =?utf-8?B?WnRUL3RtRklEc3BzcEhLUWtPRE0zZFduQ2tJd29qeDRPbDE2ZFMxYnhiaXlr?=
 =?utf-8?B?cE9GYzIzUDJuV3E4aVg3VEZRUHh5YnZkTVBKQjZkU0JWdnUzbEFHUU4yMkIy?=
 =?utf-8?B?YXovS0FZaFdReVppU2t5VkM5SWY4VUpDVzRTMHBEZ1pjOGJmR25WYnh6Rmph?=
 =?utf-8?B?MVI3T2VNelVzYTF2cHNnZ1VMU1VRZXpzSzhUK0hhUUNyU2YvbVhsdzhiY1NQ?=
 =?utf-8?B?Q2FFd3Z0Rk9SODB2U1pBdU5qOW5ya3BTVmJDZHNLckszUjZOQitJL041Skdk?=
 =?utf-8?B?Yy9zWSt6STVnUlVVcjB6N2tMRHZia0hmazZSbi9oZysyMnlEY051eHp2bG9O?=
 =?utf-8?B?eHVtR0lVb3c2YTNUOTVaam1YSHBpNWw5akVCZ0tRaVhvdC93Nzg2OFZNcWVu?=
 =?utf-8?B?cTNJK0NkeFhxemZhd1h4T010cnJLSDlEM3hrL0VEbmRVOUdtLzc0amZEY2RV?=
 =?utf-8?B?SUVIWmpZdVhZWXV4ZkQweStqelc4WGlDNEZYTXMzWk81MEVObVVtUkQ3UlZT?=
 =?utf-8?B?czVxQSs2ZUl3TFE5QjAxK1JNYzdGemZZZWE3R2d2ZU9vNGllRGZpaXlTVGJu?=
 =?utf-8?B?aHJsSkZjOWVnaldFZnNTd2xJK2xkMUVPa1J0TVVuRkRYT0tCQ1VJS2ZSbURw?=
 =?utf-8?B?ZDB6eEhmQ2tZRXpMcW9yc1Y1SDlBY2cxQ09NWmt2OFpManFFdzRBUjUvRDB1?=
 =?utf-8?B?YWZGTnowQVZzNE1oazFWZWxNTlNyZ2wzTk9nTGduTzVhV3NsZkdyN1pQRjE2?=
 =?utf-8?B?eWgrNHArejhXdldxTUU2Q1FGR3YvM2RmL0Y5aU5wYmI4Sis3akx3VUFLTTV2?=
 =?utf-8?B?dnRpaU93UGw0THk5UXlsNlBYS2lUd1VUQkZyOTFGem0wVlBRQkwvalZMRmUr?=
 =?utf-8?B?SVprdGIwK3o1RFJ2Yzd4T24rcDBnUEtBaE95QjBOK1lEeDRMMlBuRFJ6RnZO?=
 =?utf-8?B?bkZWYVVEcitSQTZMVk9SY3gzTmJsWEREMVpPanRvU1VFSzMyN255aHRxUFJI?=
 =?utf-8?B?b3hqMmYrU1YwYUZVYmpNS2VsS0R0ZG03Q2dCRUV5QkoreE5pODdSOXdMNG4z?=
 =?utf-8?B?aVlFQURpckFEWkpXNExmZnJFUDdtbUtlWVFFU0hkeVRBa0NhWlpDK09OL1NB?=
 =?utf-8?B?ZHRqOGl1RVFPZU4zd1F5eU9GNGxWVTkwNXlEa2JtZ085aHBrRVZUSmEwOUxv?=
 =?utf-8?B?SVdjb2VzTXlGbUFkZDdjTGdtenBCQmlISXliVEVpZGQ1d2gxczNjaHBmR3VC?=
 =?utf-8?B?U0FTYUhJSE83VTJ5dkRJNURyQ1p1YUJaRm1zbWM2RkRpZHpHblUwOWluVUlh?=
 =?utf-8?B?VGVYa0ZxUSt2djZuYmN6NXBGRFEwR2xXR1JrWXFCOEdGaFNPTVN3cDdGeFJi?=
 =?utf-8?B?WlE9PQ==?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: IA3PR11MB8986.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 5f942011-81c5-4050-e530-08ddd647a5ef
X-MS-Exchange-CrossTenant-originalarrivaltime: 08 Aug 2025 06:48:57.1264
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: arTbDPVFoqgiDHUJ7/9B+KsjsbeaRjEooVI8Vx3TDX2C/HAjA4aeubOuAXxFUEcx5nBbkwVPUZqU/ilDwGaBE1XmKUsSzq962Papf8FQtzQ=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA0PR11MB7934
X-OriginatorOrg: intel.com

DQoNCj4gLS0tLS1PcmlnaW5hbCBNZXNzYWdlLS0tLS0NCj4gRnJvbTogSW50ZWwtd2lyZWQtbGFu
IDxpbnRlbC13aXJlZC1sYW4tYm91bmNlc0Bvc3Vvc2wub3JnPiBPbiBCZWhhbGYNCj4gT2YgSmFj
b2IgS2VsbGVyDQo+IFNlbnQ6IFRodXJzZGF5LCBBdWd1c3QgNywgMjAyNSA3OjM1IFBNDQo+IFRv
OiBLaXRzemVsLCBQcnplbXlzbGF3IDxwcnplbXlzbGF3LmtpdHN6ZWxAaW50ZWwuY29tPjsgSW50
ZWwgV2lyZWQNCj4gTEFOIDxpbnRlbC13aXJlZC1sYW5AbGlzdHMub3N1b3NsLm9yZz47IG5ldGRl
dkB2Z2VyLmtlcm5lbC5vcmcNCj4gQ2M6IEtlbGxlciwgSmFjb2IgRSA8amFjb2IuZS5rZWxsZXJA
aW50ZWwuY29tPg0KPiBTdWJqZWN0OiBbSW50ZWwtd2lyZWQtbGFuXSBbUEFUQ0ggaXdsLW5ldCAx
LzJdIGljZTogZml4IE5VTEwgYWNjZXNzIG9mDQo+IHR4LT5pbl91c2UgaW4gaWNlX3B0cF90c19p
cnENCj4gDQo+IFRoZSBFODEwIGRldmljZSBoYXMgc3VwcG9ydCBmb3IgYSAibG93IGxhdGVuY3ki
IGZpcm13YXJlIGludGVyZmFjZSB0bw0KPiBhY2Nlc3MgYW5kIHJlYWQgdGhlIFR4IHRpbWVzdGFt
cHMuIFRoaXMgaW50ZXJmYWNlIGRvZXMgbm90IHVzZSB0aGUNCj4gc3RhbmRhcmQNCj4gVHggdGlt
ZXN0YW1wIGxvZ2ljLCBkdWUgdG8gdGhlIGxhdGVuY3kgb3ZlcmhlYWQgb2YgcHJveHlpbmcgc2lk
ZWJhbmQNCj4gY29tbWFuZCByZXF1ZXN0cyBvdmVyIHRoZSBmaXJtd2FyZSBBZG1pblEuDQo+IA0K
PiBUaGUgbG9naWMgc3RpbGwgbWFrZXMgdXNlIG9mIHRoZSBUeCB0aW1lc3RhbXAgdHJhY2tpbmcg
c3RydWN0dXJlLA0KPiBpY2VfcHRwX3R4LCBhcyBpdCB1c2VzIHRoZSBzYW1lICJyZWFkeSIgYml0
bWFwIHRvIHRyYWNrIHdoaWNoIFR4DQo+IHRpbWVzdGFtcHMuDQo+IA0KPiBVbmZvcnR1bmF0ZWx5
LCB0aGUgaWNlX3B0cF90c19pcnEoKSBmdW5jdGlvbiBkb2VzIG5vdCBjaGVjayBpZiB0aGUNCj4g
dHJhY2tlcg0KPiBpcyBpbml0aWFsaXplZCBiZWZvcmUgaXRzIGZpcnN0IGFjY2Vzcy4gVGhpcyBy
ZXN1bHRzIGluIE5VTEwNCj4gZGVyZWZlcmVuY2Ugb3INCj4gdXNlLWFmdGVyLWZyZWUgYnVncyBz
aW1pbGFyIHRvIHRoZSBmb2xsb3dpbmc6DQo+IA0KPiBbMjQ1OTc3LjI3ODc1Nl0gQlVHOiBrZXJu
ZWwgTlVMTCBwb2ludGVyIGRlcmVmZXJlbmNlLCBhZGRyZXNzOg0KPiAwMDAwMDAwMDAwMDAwMDAw
DQo+IFsyNDU5NzcuMjc4Nzc0XSBSSVA6IDAwMTA6X2ZpbmRfZmlyc3RfYml0KzB4MTkvMHg0MA0K
PiBbMjQ1OTc3LjI3ODc5Nl0gQ2FsbCBUcmFjZToNCj4gWzI0NTk3Ny4yNzg4MDldICA/IGljZV9t
aXNjX2ludHIrMHgzNjQvMHgzODAgW2ljZV0NCj4gDQo+IFRoaXMgY2FuIG9jY3VyIGlmIGEgVHgg
dGltZXN0YW1wIGludGVycnVwdCByYWNlcyB3aXRoIHRoZSBkcml2ZXIgcmVzZXQNCj4gbG9naWMu
DQo+IA0KPiBGaXggdGhpcyBieSBvbmx5IGNoZWNraW5nIHRoZSBpbl91c2UgYml0bWFwIChhbmQg
b3RoZXIgZmllbGRzKSBpZiB0aGUNCj4gdHJhY2tlciBpcyBtYXJrZWQgYXMgaW5pdGlhbGl6ZWQu
IFRoZSByZXNldCBmbG93IHdpbGwgY2xlYXIgdGhlIGluaXQNCj4gZmllbGQNCj4gdW5kZXIgbG9j
ayBiZWZvcmUgaXQgdGVhcnMgdGhlIHRyYWNrZXIgZG93biwgdGh1cyBwcmV2ZW50aW5nIGFueQ0K
PiB1c2UtYWZ0ZXItZnJlZSBvciBOVUxMIGFjY2Vzcy4NCj4gDQo+IEZpeGVzOiBmOTQ3MmFhYWJk
MWYgKCJpY2U6IFByb2Nlc3MgVFNZTiBJUlEgaW4gYSBzZXBhcmF0ZSBmdW5jdGlvbiIpDQo+IFNp
Z25lZC1vZmYtYnk6IEphY29iIEtlbGxlciA8amFjb2IuZS5rZWxsZXJAaW50ZWwuY29tPg0KUmV2
aWV3ZWQtYnk6IEFsZWtzYW5kciBMb2t0aW9ub3YgPGFsZWtzYW5kci5sb2t0aW9ub3ZAaW50ZWwu
Y29tPg0KPiAtLS0NCj4gIGRyaXZlcnMvbmV0L2V0aGVybmV0L2ludGVsL2ljZS9pY2VfcHRwLmMg
fCAxMyArKysrKysrKy0tLS0tDQo+ICAxIGZpbGUgY2hhbmdlZCwgOCBpbnNlcnRpb25zKCspLCA1
IGRlbGV0aW9ucygtKQ0KPiANCj4gZGlmZiAtLWdpdCBhL2RyaXZlcnMvbmV0L2V0aGVybmV0L2lu
dGVsL2ljZS9pY2VfcHRwLmMNCj4gYi9kcml2ZXJzL25ldC9ldGhlcm5ldC9pbnRlbC9pY2UvaWNl
X3B0cC5jDQo+IGluZGV4IGUzNThlYjFkNzE5Zi4uZmIwZjYzNjVhNmQ2IDEwMDY0NA0KPiAtLS0g
YS9kcml2ZXJzL25ldC9ldGhlcm5ldC9pbnRlbC9pY2UvaWNlX3B0cC5jDQo+ICsrKyBiL2RyaXZl
cnMvbmV0L2V0aGVybmV0L2ludGVsL2ljZS9pY2VfcHRwLmMNCj4gQEAgLTI3MDEsMTYgKzI3MDEs
MTkgQEAgaXJxcmV0dXJuX3QgaWNlX3B0cF90c19pcnEoc3RydWN0IGljZV9wZiAqcGYpDQo+ICAJ
CSAqLw0KPiAgCQlpZiAoaHctPmRldl9jYXBzLnRzX2Rldl9pbmZvLnRzX2xsX2ludF9yZWFkKSB7
DQo+ICAJCQlzdHJ1Y3QgaWNlX3B0cF90eCAqdHggPSAmcGYtPnB0cC5wb3J0LnR4Ow0KPiAtCQkJ
dTggaWR4Ow0KPiArCQkJdTggaWR4LCBsYXN0Ow0KPiANCj4gIAkJCWlmICghaWNlX3BmX3N0YXRl
X2lzX25vbWluYWwocGYpKQ0KPiAgCQkJCXJldHVybiBJUlFfSEFORExFRDsNCj4gDQo+ICAJCQlz
cGluX2xvY2soJnR4LT5sb2NrKTsNCj4gLQkJCWlkeCA9IGZpbmRfbmV4dF9iaXRfd3JhcCh0eC0+
aW5fdXNlLCB0eC0+bGVuLA0KPiAtCQkJCQkJIHR4LT5sYXN0X2xsX3RzX2lkeF9yZWFkICsNCj4g
MSk7DQo+IC0JCQlpZiAoaWR4ICE9IHR4LT5sZW4pDQo+IC0JCQkJaWNlX3B0cF9yZXFfdHhfc2lu
Z2xlX3RzdGFtcCh0eCwgaWR4KTsNCj4gKwkJCWlmICh0eC0+aW5pdCkgew0KPiArCQkJCWxhc3Qg
PSB0eC0+bGFzdF9sbF90c19pZHhfcmVhZCArIDE7DQo+ICsJCQkJaWR4ID0gZmluZF9uZXh0X2Jp
dF93cmFwKHR4LT5pbl91c2UsIHR4LQ0KPiA+bGVuLA0KPiArCQkJCQkJCSBsYXN0KTsNCj4gKwkJ
CQlpZiAoaWR4ICE9IHR4LT5sZW4pDQo+ICsJCQkJCWljZV9wdHBfcmVxX3R4X3NpbmdsZV90c3Rh
bXAodHgsDQo+IGlkeCk7DQo+ICsJCQl9DQo+ICAJCQlzcGluX3VubG9jaygmdHgtPmxvY2spOw0K
PiANCj4gIAkJCXJldHVybiBJUlFfSEFORExFRDsNCj4gDQo+IC0tDQo+IDIuNTAuMQ0KDQo=

