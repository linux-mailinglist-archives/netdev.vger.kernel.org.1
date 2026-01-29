Return-Path: <netdev+bounces-254758-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id mKUxIhxAe2mNCwIAu9opvQ
	(envelope-from <netdev+bounces-254758-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Thu, 29 Jan 2026 12:10:20 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 0FD85AF72A
	for <lists+netdev@lfdr.de>; Thu, 29 Jan 2026 12:10:20 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 7E5E13059809
	for <lists+netdev@lfdr.de>; Thu, 29 Jan 2026 11:03:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C5CA5385EC1;
	Thu, 29 Jan 2026 11:03:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="H19UJArr"
X-Original-To: netdev@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.11])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4B19D37BE8C;
	Thu, 29 Jan 2026 11:03:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=198.175.65.11
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769684628; cv=fail; b=aajZOM2fUDI5NzFzksSdIuKQAyqGhMk0pSbZzLBlq8Ix1myI/SSfufZt3yi97acQ3Uf0UImQ9ilRO9xrfWHLv57Efyo3i3yQkFVrazrSm9pMBW8TrcRZ5oH8zKacnVzFWRFgIqUNPyjjIkadimZN4K0mupz0bOORx+TXEedh148=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769684628; c=relaxed/simple;
	bh=Q9ck2msIV4HCQWTPJJcVAGuCA+H0NrSoTM8bG6wh6AY=;
	h=Message-ID:Date:Subject:To:CC:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=cQQg101+ey/CNhQe09YdRj+GrViMZbQ/1v9X0QHntDvrnfuaKOZZmcfJANO6dQk4/KRRV8tf8KmnqwU+haG5gGZttGgjDO6SxuucEoBvcIktKftkg+4NhAdtQspd1AVFa2wOduYWwoSDYivCmXtyxcE9MSA9RQ+2ncH5Z2p8MVM=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=H19UJArr; arc=fail smtp.client-ip=198.175.65.11
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1769684627; x=1801220627;
  h=message-id:date:subject:to:cc:references:from:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=Q9ck2msIV4HCQWTPJJcVAGuCA+H0NrSoTM8bG6wh6AY=;
  b=H19UJArrZTE/NHFvZU6GDqecLD36Qk8zdbkkQ9CRrnpG9NMMg0Lkp/hH
   YJH2d9nGn6h1/TNG+YuZ7AaOX/ZkE7jT+1z6gd0Ez6JnzyXsutVEmyl7L
   3lGYb7+SWKCbNA9RHwF+mGw1LOstwZ52I4Oh8v9hnaQBfSmYuOqs3nwPw
   nBZEH6uC6em8GxNKfUEHRN0YKwD8CgxqCX4WfAh4B1/HNmQyy/TN3/ycU
   RVj8s71cfoplULgPSYsHnwDF85PRyk10MG9i49dFyO5BQdTAmqa3b+Bwr
   aXnDm+y5ahKegJgVLNp8CDo4kmlmi+F0aGJQPAZPL7XhNtzI6NpyNc85M
   Q==;
X-CSE-ConnectionGUID: jLe3OvePTQipxlZ7JI7OkA==
X-CSE-MsgGUID: 4M7ZpsWySn6gnuuTcVVmvQ==
X-IronPort-AV: E=McAfee;i="6800,10657,11685"; a="81234508"
X-IronPort-AV: E=Sophos;i="6.21,260,1763452800"; 
   d="scan'208";a="81234508"
Received: from orviesa005.jf.intel.com ([10.64.159.145])
  by orvoesa103.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 29 Jan 2026 03:03:47 -0800
X-CSE-ConnectionGUID: l8xD1gzYTcSbeTV72JHD9w==
X-CSE-MsgGUID: nYnqmNtZRkOhPi0eAGbk6Q==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.21,260,1763452800"; 
   d="scan'208";a="213510663"
Received: from fmsmsx901.amr.corp.intel.com ([10.18.126.90])
  by orviesa005.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 29 Jan 2026 03:03:47 -0800
Received: from FMSMSX901.amr.corp.intel.com (10.18.126.90) by
 fmsmsx901.amr.corp.intel.com (10.18.126.90) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.35; Thu, 29 Jan 2026 03:03:45 -0800
Received: from fmsedg903.ED.cps.intel.com (10.1.192.145) by
 FMSMSX901.amr.corp.intel.com (10.18.126.90) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.35 via Frontend Transport; Thu, 29 Jan 2026 03:03:45 -0800
Received: from BL2PR02CU003.outbound.protection.outlook.com (52.101.52.52) by
 edgegateway.intel.com (192.55.55.83) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.35; Thu, 29 Jan 2026 03:03:45 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=nBfxXdRB5D9tctCwj5kY7VQGj6j2WiVXHdVkUGBT3P76LTriUiSjEYRR6JCsLtk6rtNwBTfjePnWR1WGoAQVYTXExrFFKG0Sl0D0ZyGOV/0DFk2FHW8bPJwe8r+iCgQx08hdL9eav2GZdjbVjhe64EYgochsyowPm9doVVnJYWRGIKByJXAeuB5tpLDMV0Brb99rPm0Ai7zvzFE1cWB9IxVP42KM6yv5NWzkdxZ5Lw/0D82qE+qEZGtL9MoFL0Gr3cGz7Ksum/J7U+6L+bJTx4c6SphQ7ndKNP7U6rcKAbu3y5wwK/O+M+XntYgGsbnSCVyqfZAM7EUxHqyuSPc3XQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=MHUdeMrh0owa9gE7onbAMvD8KH9YU8zM/hl4dzz4IRk=;
 b=WWLcuVPCuhB+fGsmfhJhABOeopMc5l+sWmU9U0vQO5B3siEU9aXdOfe82ZTGpCXwk2TIX+8+9kfmDwgjgEsVUxgPmgTjRvREKseSuLqCTxRaDR3nwaLhMQXzaNuh3znyfaD2TNGUTcuLb8wNi36DaVQBA3i4GfERV+ReyKh54ad2apncjWGZIkgCSf3MnpmGnOgc1qG8+ZYoAUz9VXSqW343zjirSlajZM4g1ApyklgxRlB34wpCstsg5POT1QJvwGj9ELlF8hfQuExv+n0ZxKr8WxDSC+FhpJsJGwEtPdujg+obHbkfN0ZC2DiVtgi/ThekZvj4ZajIXtfoB7AQ6w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from DS0PR11MB8718.namprd11.prod.outlook.com (2603:10b6:8:1b9::20)
 by SJ0PR11MB5152.namprd11.prod.outlook.com (2603:10b6:a03:2ae::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9564.10; Thu, 29 Jan
 2026 11:03:34 +0000
Received: from DS0PR11MB8718.namprd11.prod.outlook.com
 ([fe80::6aa:411d:4bfa:619c]) by DS0PR11MB8718.namprd11.prod.outlook.com
 ([fe80::6aa:411d:4bfa:619c%4]) with mapi id 15.20.9564.006; Thu, 29 Jan 2026
 11:03:34 +0000
Message-ID: <93f55dd6-44a5-4309-aed1-30e352cd2825@intel.com>
Date: Thu, 29 Jan 2026 12:03:28 +0100
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH iwl-next v2 0/5] ice: add support for devmem/io_uring Rx
 and Tx
To: Tony Nguyen <anthony.l.nguyen@intel.com>,
	<intel-wired-lan@lists.osuosl.org>
CC: Przemek Kitszel <przemyslaw.kitszel@intel.com>, Andrew Lunn
	<andrew+netdev@lunn.ch>, "David S. Miller" <davem@davemloft.net>, "Eric
 Dumazet" <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>, Paolo Abeni
	<pabeni@redhat.com>, Simon Horman <horms@kernel.org>, Jacob Keller
	<jacob.e.keller@intel.com>, Aleksandr Loktionov
	<aleksandr.loktionov@intel.com>, <nxne.cnse.osdt.itp.upstreaming@intel.com>,
	<netdev@vger.kernel.org>, <linux-kernel@vger.kernel.org>
References: <20251204155133.2437621-1-aleksander.lobakin@intel.com>
From: Alexander Lobakin <aleksander.lobakin@intel.com>
Content-Language: en-US
In-Reply-To: <20251204155133.2437621-1-aleksander.lobakin@intel.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: DU7P250CA0025.EURP250.PROD.OUTLOOK.COM
 (2603:10a6:10:54f::14) To DS0PR11MB8718.namprd11.prod.outlook.com
 (2603:10b6:8:1b9::20)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS0PR11MB8718:EE_|SJ0PR11MB5152:EE_
X-MS-Office365-Filtering-Correlation-Id: 78c873b1-e479-4c37-1895-08de5f260bbf
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|1800799024|366016;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?RGlVd2o4VTdrWHo3NVptZVVpd29rMWd6SEJleGVwTTloR0VuWnpVcm1YeUhk?=
 =?utf-8?B?b2JTalRJclMveHhNSk5ubmt1aGc3K0tNMTNGOTlMNy9pNTFHa1N4ZWNlRzdT?=
 =?utf-8?B?YmNHSkl6ZnI0alUyOTA5UkJCWUlPNTBHUmdJRUhkNG8rcG9sUzJ0SjB0Q3ZK?=
 =?utf-8?B?THFGcldoWlQyQTNwVndwWTdBakg0a3NILzUxMFRHZWN5Y1VmdUpzSThDQkJa?=
 =?utf-8?B?Uk5IdnNoNFVJTVg2Z1pVWUdSaXp0TUxQd0MvUUxnT09LQVIyR3lrRDVENEdt?=
 =?utf-8?B?UEZwcGRxWmNEQ3BFV25JK3REcVpOQzBLMmtLNXRaM215Q052R3o5aEpnZkJr?=
 =?utf-8?B?OEZ5NXFqUVBvS1IvVzN2OE0xSDhGRW9samZ0dDlqd3pnWVA4VE5ubEtuelJw?=
 =?utf-8?B?bXVyQTdTbTN2NlNzWnlxeC8rY2UzMWw2dkw4QldDTG1FZERYSVVVNDkwNHp6?=
 =?utf-8?B?Zmg4SGZ1eVoxNTdvMDRKS2FHb2k0QVorSEFVZG1BZjVLM1V3ZDFTNnpNa0sy?=
 =?utf-8?B?K0FVMXMvWHZ0eDAxSVlzTTlEbFBOOHVzRnd3ZXpJU2MwbXQ5R3d6MUJTRmJ5?=
 =?utf-8?B?ek9nSFJKdVZ6SFIwOWpkVlpuRjRkeXlPUUZMK0JmSEZFcjRHd2Y0aEttV1F4?=
 =?utf-8?B?aElRQmg2b250eVZYQllEcklXZWtEMnhJb2tieDFVVTUrWERwVVdhR0xYbU9o?=
 =?utf-8?B?TVdGcDc4VTl3aU9FVDF1TGg1d05aa3JrVU52RDhTdlpicnA5VEZtT2pxZ01p?=
 =?utf-8?B?eElCNVpreUxOL2Z6RkZUV0laRS9DTWd3MVFtVUh4bG44U0ExNXNDeWRWRDRO?=
 =?utf-8?B?Z2o5dXpyd2VPNmlOUkZjdWk3elArZXNWTUtHbGptUldHcGpTK3BtNENobmx4?=
 =?utf-8?B?V21DS2FYcFg2c3R0ZlNEZ2NsOFo1a0hBZXYvUEFrVi9DODR6Uzd0ZG5JVDlQ?=
 =?utf-8?B?RXFMaGRyRWNhcFY4RU9LckRyRGl3eFZOMGtkQmJzVzJLWW5tRkxwcW5pWEhB?=
 =?utf-8?B?QWxVY2dSUkh0bVVXYWhJdkpFUk5vc05JbW5IMHBLUnRNTVVXNjNQaXN4SFN4?=
 =?utf-8?B?cEFXWWFJL3BZRXBMWTdYS2N6WU5LZDM5UXZUc05NRmdsRC83NTBFT00reFMx?=
 =?utf-8?B?RWxBT0diWjY5VFB2cGNtSGVETitYVmF4REVuSVZxN0FOcXhvdjdkdCtPdXhX?=
 =?utf-8?B?UDdtVU16cEc1R0gvUW9MQURmL0NzejAxdXptdWR5bFRCaDBxaG1wOXhySWt3?=
 =?utf-8?B?Q0JXWFRiNi8wbnA1MlF2YTMzSVpEakxwVU5UcDl6ai9GK0lwZHBXM3docFFR?=
 =?utf-8?B?cDRxdU5mQ01adjF0MlBHMjU4WUpUckt5SmlvNlZvQmFkUHFhOWJXbnlIME1t?=
 =?utf-8?B?bHZZeVBLS1FueWtmRFVKbjlWcE1KK08rNEhwa0g0bnlyV3htNEFnVTRmcXRP?=
 =?utf-8?B?R2pFUWxsSXlMWXU2bzNkZ1d2SGdXcXN4WnFpYkJseWV1RTJPbW1pT1RqSkdE?=
 =?utf-8?B?YU9Wa0VZM3Vub0MrVTh5YnJxSVQva0hvUGo3M1BBRGhXdEFJdmFOVlBjU1Vr?=
 =?utf-8?B?ei84MjdNdjJBK2ZqU0x4TUU2WjR3VCtPazFwRzI4N3hPeVRlRVM5SEYyOWUx?=
 =?utf-8?B?NGIrSElLd1lQMlhtcFB4SDVRSG1FRUNvcHBKaU9KSmxIUGZTcndlT1gzMWp6?=
 =?utf-8?B?S1d0WUxMcHYvcVVzVnNCNGxqSTJiV2VtZG9kM1M1Q001QzRRMGhnUkVnY25o?=
 =?utf-8?B?bHpIWklrZVQ3bWlpbFJqRUNEY1gyMGZ5UXJCSGs2YzJJTVhTazF3a2J0NlZI?=
 =?utf-8?B?RUhYYjFOczFDd1V5TTAyY1RhSCs4WVJXNmtpSFIvYzBsdWdvaWI2VUQ4ellM?=
 =?utf-8?B?TW9kRTRXS1crYnlQVEJtMkFQS1YwN2dveEw2T3hCWXFsckwyQXppdjYrUG9D?=
 =?utf-8?B?OW91bmJYZms4UnVFazFPcXV1UTRGbUR3cUd3YXBaNDZqbEF6THF6OHhxNm8r?=
 =?utf-8?B?S1ZoMFJtNW5vck8zOCthVmNWUW0rNFVFRG8zN01EWnVPNnN0QTdmQUJ4RXpF?=
 =?utf-8?B?UzVOY0ZCN3MzVnU0ZU94MU56djQ0eVJzZHE5OTdOR3BTaCtTZlpzT1dVR3hv?=
 =?utf-8?Q?d0UE=3D?=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DS0PR11MB8718.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(1800799024)(366016);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?UlFiNGFHNXFFdjJhUnd1REE4YUlqdkxITGRDZWNjNEdnZTUxR0RENmthRzdy?=
 =?utf-8?B?Ync3d2ZhUmN0eEVYcE1rOUhicVJNVGs3eWRVMm56OHRYeVRIM1pvcGdqSmla?=
 =?utf-8?B?N3E2bDJ0MCswNkdCUFlqcktncnkzNUpBbElaQ3BydXlDanlaQlFndmxWN3Q3?=
 =?utf-8?B?L2lqWTk0ZjIyQ056N2p5T2M5V2ppYnVSQ0RaaTM5eHNHclY5TkZsWWo0dzNU?=
 =?utf-8?B?TEJ6akdBSXI1NlRpYmVFdWNxRmo0NkxpZHJyaDBzOXBzbjRQZXF0M0p3RnJw?=
 =?utf-8?B?OE44ZTZWcWRGNkhtVVNGYjI0clVYaU1sZkxNOHFjdFRSenFRaW5lL013eHNx?=
 =?utf-8?B?YXNOek5tMXRxZklERDFob3FtOVQ1N1Y2Y2xZSlhiVTBuUzNCUW5CVDZHTXN2?=
 =?utf-8?B?eGdhdW91QzlYNnRqeXNMdEk0Z2VhSTh3dm5nNkhtUTVzSmNtWTJad05WUlNM?=
 =?utf-8?B?MGloYmtQc0t5UE1uM3FxWUdYUG9BemxLQ0o2M2ZJeVp1dlBDZTNETWF1R1BJ?=
 =?utf-8?B?aitBT1pTMURwamR0dk84ZCs4T2xoaUVjTEphcm00THFqL2ZGNjBoNFFHNDhl?=
 =?utf-8?B?dmhEOXdCSDU0TzlpYkFKazQ5anF6NTh2bW94WVhDd0t6bDBLTmJjMmpzZHgr?=
 =?utf-8?B?SkRjemNTdTZiSWRQVDBzVEYvYmp5WExvRnYzWDRUaC9sYkZ6TTlDKzlKTU1J?=
 =?utf-8?B?WEoyTzQvY0R0Znd5NjF6QlhpOXRtb2RDVHJ5U0pnK3RCTXJFWk56dHhBOXVt?=
 =?utf-8?B?TnRwakdnKzkxN3lqaVlQemVWRVNhZ2sycHhiRFhjbStVRWJQS3lvQ3RwSm9B?=
 =?utf-8?B?MG5iN2RuZ1pHdGFlNWRRamhNQlEzNStFQVJtYUpOM3RFUlFpMHV3aDRQb1ZY?=
 =?utf-8?B?ajZtajExL3QxcElNcW1zU0NLd0ora2ZpaExzamtyVmlUWS8raU9rYXIvQ3ZE?=
 =?utf-8?B?ZGpjamx5RDBSZUExUGVhbWZ0SktsOUFpeGhxckVEQ1E4VVZoemJtZllmL3g1?=
 =?utf-8?B?d1BidGRYYlhwSHNQTnIycHVEeW01Z3pBZFozK3Bock94RGxkVFpVSzVxYjBl?=
 =?utf-8?B?b3pUSzRjWkRMT1gwZU5pWFMzaDRDWkVjR1ZmY2xHUmM5WGF1eFBRWDhKUWpt?=
 =?utf-8?B?UnFWSExHbUpDRXNGRXVsL0tReUJ6cjg1Zmg2N0NFcXU3L1A1U21xeStCQ1ZM?=
 =?utf-8?B?L0NKWHBxZTdOeGsxZUdvVVRBMC9CbU1Fc1kxTXZkams0Ly93Q0RWaEZYVnRH?=
 =?utf-8?B?RFUrY0E4NDdEM1NSeHBaVlcyTVJZNll5WnZ3Zmxqd0QyUXNmRXZSbFo5MDhy?=
 =?utf-8?B?REZQbzRJUFo4Zy96V3hnSGtYVHloRDZ5YWZmcGRSNEtoKzMwdGFyVDdFWTVv?=
 =?utf-8?B?THJYRE4xVG90R3JTNWhrR1JselFYUUFKaDhuUGZwUVVSVVlVVGdKbnpHMExI?=
 =?utf-8?B?S2lJbTJFcm1DTk5YdWd5ZDlTUG05azRlU3lWWlhVSC92cWZCOXJKVjR5YkJM?=
 =?utf-8?B?TVRBcmhjSmxwSHplVmg3L1MvZzllNVdpbVFzY09DTElZUTBkcys2V2pKdGpo?=
 =?utf-8?B?ZytER0l3YnRURWsva2pHNy9TTVpvRE96bTJzR3RxenNmMCtVQituRmxyOStL?=
 =?utf-8?B?LzVlL1VWYUM2QUVCR1U5MU1kSGNVVm5jR0xweUxTQmp0MkUrVGI3ejArS1hk?=
 =?utf-8?B?dUdiSlZuQVVuUW5MUk9yV0hLbk55OTVwOWgyS3lkU0VuSGdlZVpCVWduS3VZ?=
 =?utf-8?B?WXc4UjNRTktpZXBkNFkxTDFTZWpDdHJENnFibHdPbVJxMU5TUDIzUGVYVjZW?=
 =?utf-8?B?amQ5KytxcWlQY0xvOWI4WTd2cGNEeXN0cmVmdUNLSFcrdXBML0pmMG5hODh6?=
 =?utf-8?B?YlNVT0RTUmNXWXY2UWhjSlJ6eVJOckRZczdhc1Y5VzJqcFFoVFNya1MwMVRM?=
 =?utf-8?B?d3hUMzhlVWl2ejlyMHZiTU13ajlFNGphWVJTUnIvbXdZcTVkSnd6MDRCQUVT?=
 =?utf-8?B?RVliVGd3K1RraDR6emN6OTYvM1ZiWkNIM1A4eE9ucW9JYngzMFY1MVRSdlRB?=
 =?utf-8?B?K1hrUi9TdGxvcHBkeGMyMXcwMTAzK2c2c1U0QzZieCtzVHBhR3NsSk1HRWhq?=
 =?utf-8?B?TVNIdkQ4MlRlRXBNM3IyZm9rZEhXWmtRSEpzVlQwN3NuYTg1NzU2WGlNMUlW?=
 =?utf-8?B?WVVXdXZFUjExUHJPWTRIUHJyMFVuNlUralRYN2E3V1M1M1NqeGhiZTZmQjFK?=
 =?utf-8?B?aEs0czlnTXRjM3JKdk5Ya3VZdGR4Zjc3dm1Bd2xMS1phb3E1YWkvK28vajJk?=
 =?utf-8?B?bjJmcjNxblVQYlh3ZGs2U3Z0Qm1POU8yVGhvWUR6bmpmbEh3QXJlcW9KUHdP?=
 =?utf-8?Q?viBJBJ3GBOpDloV0=3D?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 78c873b1-e479-4c37-1895-08de5f260bbf
X-MS-Exchange-CrossTenant-AuthSource: DS0PR11MB8718.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 29 Jan 2026 11:03:34.6000
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: jNNGUxykMRsRwuxKdaVadFm99VhFXmpZ4vjEUP6g7mzPftyMbh4sTCf0jYcWO2O0BBxuwws6RmN9PabnDPQFvTel0WM8TwPYjN4vE6cBZ10=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ0PR11MB5152
X-OriginatorOrg: intel.com
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [1.34 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_REJECT(1.00)[cv is fail on i=2];
	DMARC_POLICY_ALLOW(-0.50)[intel.com,none];
	R_DKIM_ALLOW(-0.20)[intel.com:s=Intel];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	MIME_TRACE(0.00)[0:+];
	RCPT_COUNT_TWELVE(0.00)[14];
	TAGGED_FROM(0.00)[bounces-254758-lists,netdev=lfdr.de];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[intel.com:email,intel.com:dkim,intel.com:mid,devmem.py:url,iou-zcrx.py:url,sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[aleksander.lobakin@intel.com,netdev@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[intel.com:+];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[netdev];
	MID_RHS_MATCH_FROM(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	RCVD_COUNT_SEVEN(0.00)[10]
X-Rspamd-Queue-Id: 0FD85AF72A
X-Rspamd-Action: no action

From: Alexander Lobakin <aleksander.lobakin@intel.com>
Date: Thu, 4 Dec 2025 16:51:28 +0100

> Now that ice uses libeth for managing Rx buffers and supports
> configurable header split, it's ready to get support for sending
> and receiving packets with unreadable (to the kernel) frags.
> 
> Extend libeth just a little bit to allow creating PPs with custom
> memory providers and make sure ice works correctly with the netdev
> ops locking. Then add the full set of queue_mgmt_ops and don't
> unmap unreadable frags on Tx completion.
> No perf regressions for the regular flows and no code duplication
> implied.
> 
> Credits to the fbnic developers, which's code helped me understand
> the memory providers and queue_mgmt_ops logics and served as
> a reference.
> 
> Alexander Lobakin (5):
>   libeth: pass Rx queue index to PP when creating a fill queue
>   libeth: handle creating pools with unreadable buffers
>   ice: migrate to netdev ops lock
>   ice: implement Rx queue management ops
>   ice: add support for transmitting unreadable frags
> 
>  drivers/net/ethernet/intel/ice/ice_lib.h    |  11 +-
>  drivers/net/ethernet/intel/ice/ice_txrx.h   |   2 +
>  drivers/net/ethernet/intel/idpf/idpf_txrx.h |   2 +
>  include/net/libeth/rx.h                     |   2 +
>  include/net/libeth/tx.h                     |   2 +-
>  drivers/net/ethernet/intel/iavf/iavf_txrx.c |   1 +
>  drivers/net/ethernet/intel/ice/ice_base.c   | 194 ++++++++++++++------
>  drivers/net/ethernet/intel/ice/ice_lib.c    |  56 +++++-
>  drivers/net/ethernet/intel/ice/ice_main.c   |  50 ++---
>  drivers/net/ethernet/intel/ice/ice_sf_eth.c |   2 +
>  drivers/net/ethernet/intel/ice/ice_txrx.c   |  43 +++--
>  drivers/net/ethernet/intel/ice/ice_xsk.c    |   4 +-
>  drivers/net/ethernet/intel/idpf/idpf_txrx.c |  13 ++
>  drivers/net/ethernet/intel/libeth/rx.c      |  46 +++++
>  14 files changed, 325 insertions(+), 103 deletions(-)
> 
> ---
> From v1[0]:
> * rebase on top of the latest next-queue;
> * fix a typo 'rxq_ixd' -> 'rxq_idx' (Tony).
> 
> Testing hints:
> * regular Rx and Tx for regressions;
> * <kernel root>/tools/testing/selftests/drivers/net/hw/ contains
>   scripts for testing netmem Rx and Tx, namely devmem.py and
>   iou-zcrx.py (read the documentation first).
> 
> [0] https://lore.kernel.org/intel-wired-lan/20251125173603.3834486-1-aleksander.lobakin@intel.com

Current status from the validation:

* io_uring tests pass, except for tests which try to setup RSS Rx
  contexts -- after recent changes in the kernel, seems like at least
  some of our drivers return -EOPNOTSUPP when trying to configure RSS.

Tony, did you have any related reports or planned fixes?

* devmem -- only the Tx test fails, may be related to our complicated
  .ndo_start_xmit() logic in ice, I'll investigate this as soon as
  I get some details from the val.

Thanks,
Olek

