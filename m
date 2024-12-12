Return-Path: <netdev+bounces-151570-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 68FB69F003E
	for <lists+netdev@lfdr.de>; Fri, 13 Dec 2024 00:36:53 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 23571287C73
	for <lists+netdev@lfdr.de>; Thu, 12 Dec 2024 23:36:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 059E51DE899;
	Thu, 12 Dec 2024 23:36:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="FPUm0mO4"
X-Original-To: netdev@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 12D3F1D6188
	for <netdev@vger.kernel.org>; Thu, 12 Dec 2024 23:36:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=198.175.65.19
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734046609; cv=fail; b=ebGcIjWUf6wZndQP0jy0VvkGGRsgOW3G5SO9Udylx3nP7ABnQEFg+7vu/4VbrAb1k8+zeg3tjF/l/UgLLkMjUMpTrEm3R2J5spoo1x+q63h8gfzcf0TGL7MhfLe27pVFr090xKTOQit3o9DCMiP3yArubY54aSPP0gEVIXX8n00=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734046609; c=relaxed/simple;
	bh=LhtypLHbLTcXWlTRAU1nylRxd0ZfrZlrD1DzoxKK+l8=;
	h=Message-ID:Date:Subject:To:CC:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=Eu0bL4xrIl1KS23BiDvYEyUXQWlGFDqwT4lpe5bol4vBVsOILP8fpiDMPJrqDrZukTVGNFrM1iD+9SemhJzGjTAbghCjUtzHykVFfBwXRUneA4vnfrxNM4NPxBB4/e4IpjU34+1X0JLD6uF92/hqS7xVqLyuLjk0zVpVVChZeg0=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=FPUm0mO4; arc=fail smtp.client-ip=198.175.65.19
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1734046608; x=1765582608;
  h=message-id:date:subject:to:cc:references:from:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=LhtypLHbLTcXWlTRAU1nylRxd0ZfrZlrD1DzoxKK+l8=;
  b=FPUm0mO4uug4M310hLaIFFqyRA0eTUVVPgjPfY4QHQvuCZrpvpbEtNPH
   mzZwEfrrWg0RMMWm6mmYFlVUCas87CrtQD355udxHmqLz5kJfJ++LxBsh
   uMtTd3LBH58aTeEL9u9lnAD4UUCOmTLMrqCn3GyLboBewfXWgqBj0wVCh
   zf8Zq7hOhMl5LppJNNJP12OPXoulCKKzn+SizJkdkaeq0Zu93OvR4no0D
   DKjdEnXQxSF327e1mPnp704y+JEIg9/R/M9YGnVv7FLxJoeKZHcpY1yLO
   D2n0VlCU+p80xmapdNflTl9x4L5/zxHxQtm4iZzjNKBsShcORId5/fcbL
   A==;
X-CSE-ConnectionGUID: KiXfHw9tTguCqDUh5//IMQ==
X-CSE-MsgGUID: CxetrSOkTrCvGonz3iRhJQ==
X-IronPort-AV: E=McAfee;i="6700,10204,11284"; a="34363149"
X-IronPort-AV: E=Sophos;i="6.12,229,1728975600"; 
   d="scan'208";a="34363149"
Received: from fmviesa002.fm.intel.com ([10.60.135.142])
  by orvoesa111.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 12 Dec 2024 15:36:47 -0800
X-CSE-ConnectionGUID: +b/QHGkBQWyVPAnWkHI/Dg==
X-CSE-MsgGUID: lAg5ym60Tfu2hboE5ICpCw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.12,224,1728975600"; 
   d="scan'208";a="119624287"
Received: from orsmsx601.amr.corp.intel.com ([10.22.229.14])
  by fmviesa002.fm.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 12 Dec 2024 15:36:47 -0800
Received: from orsmsx601.amr.corp.intel.com (10.22.229.14) by
 ORSMSX601.amr.corp.intel.com (10.22.229.14) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.44; Thu, 12 Dec 2024 15:36:46 -0800
Received: from orsedg603.ED.cps.intel.com (10.7.248.4) by
 orsmsx601.amr.corp.intel.com (10.22.229.14) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.44 via Frontend Transport; Thu, 12 Dec 2024 15:36:46 -0800
Received: from NAM11-DM6-obe.outbound.protection.outlook.com (104.47.57.176)
 by edgegateway.intel.com (134.134.137.100) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.39; Thu, 12 Dec 2024 15:36:46 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=XX01yf+ZgGr9YlN6z7osZK9xpUKKIsCahhTKH3fzjr8m4VXIAQ8Z72DdWVBZqhKPiBYfxN3p582e+5lF/6xTgu5Xybb9hH7EdkhMMFURVHjjxSrlnAQfMf6JolQ/wyiDChQCDiHI8GX7uHSB8CbYuiVCD0VXHJbQIPt5m8QbMfesmX5YEq3VZOO7Xtda+BoUZVEF8QG2RJsGf1bdWayfLNeCxiQjyZSzI6rFlbXWNHbeb+MVq7V4izMUwMV1LqsZUYxi8TlumTgXyhFVMB2qbGRoR1UENWrmfbfqseEWyrL2+LTFztRZ2E0INYmQ+8XLcvKc4EFfOtcorJ3BhA1i4g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=WlLdO5qlcRj3HAXj2Km97v39lcdU+7RRZeQF/+B+Jb8=;
 b=cX5S0+GN9nlh9xbE511zT36Vend5fkVL7Qm0ddmtOLW5OLXjphTz93NwGeg/097niil3EJxQKdtMDGf9gv/QMvb7fzHDoYuFe2Iw5jG61RVsWEUnnfYySoTPs+cZTw5y+LDLN8YvXMOTJeOxNGF1VFx/V5N1cngHyn8de77xwKwMsOO/Dh3EERuhBHdwlWTru8wASX9r11mG9Fhr/N+RWUaM81YXnW9gSIa5v1c2GhkOZ4rZXsPhuT0G5zmTqFIqRt7/mkcZZdHaPRQUwk2i/N3XAStmdco/AlQGCmITtu+jrb8aMp0JgCTJQiKf8Zdv8835J60lS1A0S9Fl6uANGw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from CO1PR11MB5089.namprd11.prod.outlook.com (2603:10b6:303:9b::16)
 by PH8PR11MB6854.namprd11.prod.outlook.com (2603:10b6:510:22d::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8251.16; Thu, 12 Dec
 2024 23:36:43 +0000
Received: from CO1PR11MB5089.namprd11.prod.outlook.com
 ([fe80::7de8:e1b1:a3b:b8a8]) by CO1PR11MB5089.namprd11.prod.outlook.com
 ([fe80::7de8:e1b1:a3b:b8a8%4]) with mapi id 15.20.8251.015; Thu, 12 Dec 2024
 23:36:43 +0000
Message-ID: <d07d76ae-a3f5-426d-ad85-6ed3046404fc@intel.com>
Date: Thu, 12 Dec 2024 15:36:40 -0800
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net-next v10 00/10] lib: packing: introduce and use
 (un)pack_fields
To: Vladimir Oltean <vladimir.oltean@nxp.com>
CC: Andrew Morton <akpm@linux-foundation.org>, Eric Dumazet
	<edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>, Paolo Abeni
	<pabeni@redhat.com>, Tony Nguyen <anthony.l.nguyen@intel.com>, "Przemek
 Kitszel" <przemyslaw.kitszel@intel.com>, Masahiro Yamada
	<masahiroy@kernel.org>, netdev <netdev@vger.kernel.org>
References: <20241210-packing-pack-fields-and-ice-implementation-v10-0-ee56a47479ac@intel.com>
 <20241211202106.ic2nlfj7ep3j4f3s@skbuf>
Content-Language: en-US
From: Jacob Keller <jacob.e.keller@intel.com>
In-Reply-To: <20241211202106.ic2nlfj7ep3j4f3s@skbuf>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: SJ0PR03CA0295.namprd03.prod.outlook.com
 (2603:10b6:a03:39e::30) To CO1PR11MB5089.namprd11.prod.outlook.com
 (2603:10b6:303:9b::16)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CO1PR11MB5089:EE_|PH8PR11MB6854:EE_
X-MS-Office365-Filtering-Correlation-Id: d81f3aa9-09b8-4696-2c96-08dd1b05d5ff
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|366016|376014;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?MnlUT0dkbDFVSlBhTVdwMk1OaEFsS0tWOHBSNXBjRkVwb3NvTmVrL3lySDdr?=
 =?utf-8?B?RUFIN2hwQ2Y5MHhMeHpMWGlRNStENVorTzRsUDVTSFUwZHNqeExTc0t6b3lG?=
 =?utf-8?B?TjUzRjNBQmM3UVBOQU1pNG44Z3NOM0xIL1BwYVNJYWhUSjY4U1lXQm81T0hv?=
 =?utf-8?B?SVRhMEUrZ1N4UkJwM0RJWHk5cXNDcEE5bVFPZVpOby94QTh6MkVwakVzZ3dP?=
 =?utf-8?B?eUUxRG9QNGVUQm1nZEoxNW1pMFZXd1Fjb0p5dStmZTNuMVlSenlwWVpkTFRp?=
 =?utf-8?B?a1l5V0RTa2JzTS91aHE5a28rVHI0VW9RNDdxQTlvR2h0UUoyR205VHJ2SWdp?=
 =?utf-8?B?SThsRFpIbC9KZEp4YU1nTDZwN1BWRUhQVVBXRlFzTE1YZVVvUkx1R1JOdW1y?=
 =?utf-8?B?WDd2TVpmZFRaSm9oM2lFZTJHdmdOdERxcnY4R0dkdXo5c1FSMFpHdTlpc3Ar?=
 =?utf-8?B?ZUkxYkNCNGlzZExpbWw1aHpYUXhPSE5YWmJSRXVkUUk0ZksxdXBNeFFyL0dq?=
 =?utf-8?B?eDdMYTB1SEc3d29FaDlpbWJEb1dYR1J6dGhTN0VNNmtXcnVaVXdlL3lVLzdW?=
 =?utf-8?B?WFYxaDFJY2x4eWRtaGY5WmI0MjVMV1MwdFBodEhuckI3Q3dPVjlMN2NGNFVU?=
 =?utf-8?B?KzlWRUY5ckFiVWFZcjZlZTIxK1BVRHZBbVBXUlZZS3dURXhZeEx4MzRWRTI3?=
 =?utf-8?B?ZUR3UWpPajBKcko5ZFFzeTFrY084MDlqV0ZLVTFLTG5sd0h1dnVodERvMHRh?=
 =?utf-8?B?UUVqRmdPS2ZydVA5U2l4WHJzN2lDNUVGTk8wT1Z4N051NEtPUVRSeWRML0ZH?=
 =?utf-8?B?d1dRZnlhVEhtM1dCbjRvNWcvajZxYmFmdzJ5empFa29xUEwyangydk5DbEtE?=
 =?utf-8?B?WDlCWUtuUHFQUVRoZkMrMEkrY2FlbFJHVmduQkR6Mk92dndHZHBKWHlneGNI?=
 =?utf-8?B?bEgzaGZUWmJ5K1QxRmJBSVBJQ24ySjh1RU9ray9iMG5kK1VEdXVOM0VEKzVa?=
 =?utf-8?B?KzJVYnN0VzI5MTRYZGo1M0UwVlc0b29sc21IekhCZ2RyUTFWb0RjOFh3RmRY?=
 =?utf-8?B?ZEN6SEtvbEFSNWtzczVxZHRTdkhQejZSbE5NazlnODlQTkRHamFPU2c3Z3BT?=
 =?utf-8?B?RXl6czFLQ05vbnlKc1liK2VDTU92QUgrQVZOMWVJb2lob1lVMmdmbC9NYUF4?=
 =?utf-8?B?YVBCVzRBNTJjOEIwbW13Qzg5Q29CdXBTMUV6NEpoR2VBTHlndVlrbmI3TDdH?=
 =?utf-8?B?d1piYm14d1l1UXJPYmpEcy9zWjNQVFdNQnFVbFExaGVPbzRWa0tNUEJFS29z?=
 =?utf-8?B?VzVBcGdnWGU1bGlOYnZtK3hqS3g2UGNxQWNjMXZQU2lYYVVqempVQWVvcE43?=
 =?utf-8?B?N2t6MlVGSVRubU8wbVVrUHZUd056VjdQdWxNN3J5Y0FZS0JyYzZjSUxnbXN6?=
 =?utf-8?B?Mkl4R0FweWcwT3p0K2F5a3ZPbHIyTU4xRUZBUnBsZXRSY0xiV3NrMFo4dGZH?=
 =?utf-8?B?K3Eva2ZQU1NaTWZ5Zzd1Vk9EaHNkWXIzd1JMcW5MTGhIZHhPa2JHM09GOXY4?=
 =?utf-8?B?K3JJcy9yQ3lrQTdORmNhb3R0UHA1amxHSTdoM2RQRG04Y0dTdGg0bWp4bXVE?=
 =?utf-8?B?YW91RVVtREs0S2Yvc3dnRittaktqajBubHBWV2RHTFUrVnR2Y0dMYWd0blhi?=
 =?utf-8?B?V3JERU9WTmVvK3ZLWFBnQlJHbkIyWWp0Ti9QRWZuTGJaQkF3Q1J3c3VzTDV3?=
 =?utf-8?B?YVJxaHFpaEdURkx6cXU4QTNKbVpGMVF4RmNQV0dUT1NZTmxkRmdBZlBoczJJ?=
 =?utf-8?B?L1VmY1BaMXF0bG5YRU9XQT09?=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CO1PR11MB5089.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(376014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?d2JGc2dFVEFuVnBoa20yVmtvdG0vMXRXZDYvMW1TaHdDYVhQVjJBd2pHQXgv?=
 =?utf-8?B?em9FS3NGN0lCT1Y3N1JDZCtCQ1hzc0Y5WnRSMzNaamR2bGZjTklaa2xmLzdr?=
 =?utf-8?B?ME1TWHZVdkFpcERCMDZvRFF6NU5BMm1tcWdvNGVsSHZPYWJJSFdFMzdNZVRB?=
 =?utf-8?B?NnduRHZ3WEhnVXRRdjNtb3h2bUszQ3RqRExIZTJPbXp6ZDBkMytVTExndjZi?=
 =?utf-8?B?TEF6aFZkcThWUkVVTDVScHFORk12cWFIbjh0T3phNVBHNE43Z00reDZEallO?=
 =?utf-8?B?OE5PZ0VrRXIyMmdLSHZvajZtMGphZXcyMDJSazJRb0NHWGJJT2RVa29PYlZ1?=
 =?utf-8?B?eCs1dmhHK2tQNmdVaTY3cDgza3dHdkhvbnlwREE1TWRiUEdwV1loWXJCbjV0?=
 =?utf-8?B?RDZtU1VUcWE2MFp4eUdxTERvcUliUW9MNCtrSVlmMlFibWtMTHkzRGhRa2Mv?=
 =?utf-8?B?cUZWOXRkWjBISHN3a0l0UkZTWlBKRWJVTDRraTdHSU4xdGlKZlMrZ1RFcjNn?=
 =?utf-8?B?VHFLUFhzSW9iVVMrUksycWZVZmJnRHJNakQrQUplU0JQcDZFVEY1L2J1YXRO?=
 =?utf-8?B?cXBRbXJ6UlBiVnZVVE5jc0pRTDRTblVra0JILzkxSFlTdlR1WXkzS3Jxek5x?=
 =?utf-8?B?WG5NaCtoblE2bWdSNTY2dE5nVXVRdU5IUUljOGVCRm5uQzNrQnV5UkRhMFFJ?=
 =?utf-8?B?VzVnTTlnWWxSWTBjWmk5S0lZVzhkbFA0K05kMFNmY1o1czRibzlIS2QxVlNy?=
 =?utf-8?B?V281TUxkeUtvWVJjNy85K1Z5Y1RVeDltVU5OQUNnVVdmL2pKaWhocUlmeFBD?=
 =?utf-8?B?TDk1ZHFPcWxNaXVOV0pVckRzbDZIL1gwcGNzaTdxSmlNMm54UjZjVTJtQWEx?=
 =?utf-8?B?SkRQT3NGVDNXbVdMQnd1MGRUOXpVZ3FRbFNsbzhyeHQ2cE1XM2NiMk9yNG1W?=
 =?utf-8?B?QWhQbXNJc2JXdXdWQnZHMWJYVHVrNzVyWU84Qzg4T0JkOGFKbURKVjR3QXda?=
 =?utf-8?B?OWF6aVZrZmRFbkJaNkZTZW9vTUpLdzNXVEZLMk15a0txR0c2Zk1DVVVNVVNm?=
 =?utf-8?B?UEgrcW5nZFhFMEp4M3Q3b291c2lITzBBbHVqVVZmWnNwemRZbHBLNGFZN0lT?=
 =?utf-8?B?OHhuVSt6VERRVEdJbmJ0WU5LbVlXZ1ZBQ3REeWN5b3MwelRydGF2MDZMc3VX?=
 =?utf-8?B?M3NiVFFvZFZHYUc4VFF5UU1UbXQvU244cUVheU9rdjhUaGo4Y0VKM1dDNzBD?=
 =?utf-8?B?eU15Q0YzZGFoUmxHWHVvcTB1SlludmtTRko0aFFhaThIWWhXd0hnYkVWNjBl?=
 =?utf-8?B?UEg5ejdJaC9YaHpFUWMyNVF3UWw0QWtHQVFKUVUwQUhwWjlyZHRPS040Q3N4?=
 =?utf-8?B?ZE9ZVnV3clp3RFE4NTdYUTM2YkdwY3FQSUU3Q295eGVreWl1UzdSV2dDdHpD?=
 =?utf-8?B?OUlPUllUZWwxN0xOMWZrWE9vckR3V1BQUXV1cWFZMG9USG5kR0s5VEVUdWxj?=
 =?utf-8?B?eHB2aXZ5L0hRMzhqZlhoMHk4QTlKS2tEOTlHd2tnNnErVElRS2RoeFVid3lY?=
 =?utf-8?B?bEc1bitZV1daY09ublRFZGVlZmZsS0xaWUp0VDg2NUlvalh0cUhMZkhLbG5K?=
 =?utf-8?B?Y0kwL0ZHOGdCK1lITHF1c2xXT2NlT3JjdTBmeGpTRExPbkpLRGVXbTAxeVFm?=
 =?utf-8?B?K0NlOXBPN2NRMGdQSUNSZDVyWGhGaVV2ejFBWkhTdkZSN1NxR1RlSzZvTm1u?=
 =?utf-8?B?T2ovTmIzNUQ2RloxVFZDMXlKZy9lWmsxMTZJd1ZFUlhJSm1sVXc4bW85eEha?=
 =?utf-8?B?ZUFGUmM0MzB2S1FTcitqeGEydFVtbE5yVmpSQTFsMXlWK3JlbXBIOWVPYWlj?=
 =?utf-8?B?QjZ6YzBXUTdKSlkvU0VZSkNMMk9ZTmliTjM3ZnZEK21Nc0p3LzlpRldWc2FP?=
 =?utf-8?B?RnJWNWczSzJ3ZVAwTTJTeGhnbjQreFpJNWc5MWZHNXdMVWtwbWxvTG1YUjdn?=
 =?utf-8?B?WlRWNnIvaEZUSHVQQ1Vjd1NTa0ZXYjlkMmJJYW1talcxMW5TY1NlVCtUS2Uv?=
 =?utf-8?B?djhZeERsMGpJWDBXUTBZYU9XSS9nYzBJRlhCa0xzWCt4YlhQVW1WME8vR2Z3?=
 =?utf-8?B?OFJZYVh5cVI2YXppMUZsRzltTk9uem84bDVUd3NqQzR1eVV5bzJReEcwcWEz?=
 =?utf-8?B?T2c9PQ==?=
X-MS-Exchange-CrossTenant-Network-Message-Id: d81f3aa9-09b8-4696-2c96-08dd1b05d5ff
X-MS-Exchange-CrossTenant-AuthSource: CO1PR11MB5089.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 12 Dec 2024 23:36:43.6716
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: g8ZeTnd//McHUWZAMzzO1kLfQ7SjSv9kClYa6eo5mB69VbJDt3FXeIL458kOpeGxqpZ4UIOjmoyz0b+8aIaFGRW6baPrO3LeZfeX4T4iMA4=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH8PR11MB6854
X-OriginatorOrg: intel.com



On 12/11/2024 12:21 PM, Vladimir Oltean wrote:
> On Tue, Dec 10, 2024 at 12:27:09PM -0800, Jacob Keller wrote:
>> This series improves the packing library with a new API for packing or
>> unpacking a large number of fields at once with minimal code footprint. The
>> API is then used to replace bespoke packing logic in the ice driver,
>> preparing it to handle unpacking in the future. Finally, the ice driver has
>> a few other cleanups related to the packing logic.
>>
>> The pack_fields and unpack_fields functions have the following improvements
>> over the existing pack() and unpack() API:
>>
>>  1. Packing or unpacking a large number of fields takes significantly less
>>     code. This significantly reduces the .text size for an increase in the
>>     .data size which is much smaller.
>>
>>  2. The unpacked data can be stored in sizes smaller than u64 variables.
>>     This reduces the storage requirement both for runtime data structures,
>>     and for the rodata defining the fields. This scales with the number of
>>     fields used.
>>
>>  3. Most of the error checking is done at compile time, rather than
>>     runtime, via CHECK_PACKED_FIELD macros.
>>
>> The actual packing and unpacking code still uses the u64 size
>> variables. However, these are converted to the appropriate field sizes when
>> storing or reading the data from the buffer.
>>
>> This version now uses significantly improved macro checks, thanks to the
>> work of Vladimir. We now only need 300 lines of macro for the generated
>> checks. In addition, each new check only requires 4 lines of code for its
>> macro implementation and 1 extra line in the CHECK_PACKED_FIELDS macro.
>> This is significantly better than previous versions which required ~2700
>> lines.
>>
>> The CHECK_PACKED_FIELDS macro uses __builtin_choose_expr to select the
>> appropriately sized CHECK_PACKED_FIELDS_N macro. This enables directly
>> adding CHECK_PACKED_FIELDS calls into the pack_fields and unpack_fields
>> macros. Drivers no longer need to call the CHECK_PACKED_FIELDS_N macros
>> directly, and we do not need to modify Kbuild or introduce multiple CONFIG
>> options.
>>
>> The code for the CHECK_PACKED_FIELDS_(0..50) and CHECK_PACKED_FIELDS itself
>> can be generated from the C program in scripts/gen_packed_field_checks.c.
>> This little C program may be used in the future to update the checks to
>> more sizes if a driver with more than 50 fields appears in the future.
>> The total amount of required code is now much smaller, and we don't
>> anticipate needing to increase the size very often. Thus, it makes sense to
>> simply commit the result directly instead of attempting to modify Kbuild to
>> automatically generate it.
>>
>> This version uses the 5-argument format of pack_fields and unpack_fields,
>> with the size of the packed buffer passed as one of the arguments. We do
>> enforce that the compiler can tell its a constant using
>> __builtin_constant_p(), ensuring that the size checks are handled at
>> compile time. We could reduce these to 4 arguments and require that the
>> passed in pbuf be of a type which has the appropriate size. I opted against
>> that because it makes the API less flexible and a bit less natural to use
>> in existing code.
>>
>> Signed-off-by: Jacob Keller <jacob.e.keller@intel.com>
>> ---
> 
> Any reason why you aren't carrying over my review and test tags from one
> version to another?
> 
> Reviewed-by: Vladimir Oltean <vladimir.oltean@nxp.com>

Sorry about that, I forgot my usual step of running b4 trailers.

