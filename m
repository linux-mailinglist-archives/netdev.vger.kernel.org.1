Return-Path: <netdev+bounces-266637-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id QM/uC35ksWnsugIAu9opvQ
	(envelope-from <netdev+bounces-266637-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Wed, 11 Mar 2026 13:47:58 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 8B0E1263D2C
	for <lists+netdev@lfdr.de>; Wed, 11 Mar 2026 13:47:57 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 67BD230D20E4
	for <lists+netdev@lfdr.de>; Wed, 11 Mar 2026 12:45:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EE9B31F5834;
	Wed, 11 Mar 2026 12:45:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="VSEQXd9u"
X-Original-To: netdev@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 991BC1A6829
	for <netdev@vger.kernel.org>; Wed, 11 Mar 2026 12:45:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=198.175.65.18
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773233141; cv=fail; b=Tr7645HNWrpLMCXQygw2t2meIRL+9mmHe6UwZsAqFKOvzwsIeM8yWJ4FytswnkzlA+/G2N2RGV4pINgubPAx+zoE3oxDCXJFnBBnRx+VMwXU4H4F4VQy4rj/9cA5v8BkLVXYdHm/ypYRu7bF6U9tt5fhvrXRXeuYklGHCyk1iUA=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773233141; c=relaxed/simple;
	bh=Zf0G6vIp93cXVq5L1JAs/wvu62+4kNzoArVffAV7fLg=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=f1j+7Vc9aI8/Nws8VPx1r3GABIWpm9ADDnajjBHuOOMijGiKA2caNvR1OeBMMtPE+qniYVi5zpwrTMmOAQzk4Pmix3K8DMRE7/DKvwvLh7hO0n9vuGDK5a3Ir4CzgH4nYnbjQuiW1Mjgyu5Z+ju6K2fM9popZF92lyBT4FzDV1E=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=VSEQXd9u; arc=fail smtp.client-ip=198.175.65.18
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1773233139; x=1804769139;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=Zf0G6vIp93cXVq5L1JAs/wvu62+4kNzoArVffAV7fLg=;
  b=VSEQXd9unN6/KV8E/EFAhyIfkE52K/U5+iwtCOgyfHLYbc9k+8xsS4mN
   m1LaP5eiN9wYMAN/cLJdOxAnLgH8DgLGr50wfz6ows7T7x3mqCXPUVZZO
   j5oNYhgNZLmBL5+kentleyB6RXi6X9CLoeCB7b7bt1FuNbG8Z7GIvt9BU
   FbN7YUb9/lh9Z1VBRsy33SrjC4p6G/kLtjI95KyXmPvwIPvrTONtySPaB
   wSUdCB9G0NyqwjNHn/ind3nosQY1sLkD4QzOn1sQpyO8OAH6VDeF+MMgl
   bxlm9RsqWaNprXfwlfRXd84UMu4DPxhxZULFtIk8EPa0DzgtMBhbCx9eg
   Q==;
X-CSE-ConnectionGUID: q6wvyKwrRiyKJlqcLT7zDQ==
X-CSE-MsgGUID: 4xnVy89wRz6tDSkSvqWZTQ==
X-IronPort-AV: E=McAfee;i="6800,10657,11726"; a="74337343"
X-IronPort-AV: E=Sophos;i="6.23,113,1770624000"; 
   d="scan'208";a="74337343"
Received: from fmviesa004.fm.intel.com ([10.60.135.144])
  by orvoesa110.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 11 Mar 2026 05:45:39 -0700
X-CSE-ConnectionGUID: 1Fxb+H9YSDmiyb7JyFmOhw==
X-CSE-MsgGUID: L2Rcfnw2TRurzTzWPUAJcg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.23,113,1770624000"; 
   d="scan'208";a="222991137"
Received: from fmsmsx902.amr.corp.intel.com ([10.18.126.91])
  by fmviesa004.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 11 Mar 2026 05:45:39 -0700
Received: from FMSMSX902.amr.corp.intel.com (10.18.126.91) by
 fmsmsx902.amr.corp.intel.com (10.18.126.91) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.37; Wed, 11 Mar 2026 05:45:38 -0700
Received: from fmsedg901.ED.cps.intel.com (10.1.192.143) by
 FMSMSX902.amr.corp.intel.com (10.18.126.91) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.37 via Frontend Transport; Wed, 11 Mar 2026 05:45:38 -0700
Received: from PH8PR06CU001.outbound.protection.outlook.com (40.107.209.8) by
 edgegateway.intel.com (192.55.55.81) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.37; Wed, 11 Mar 2026 05:45:37 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Q5Oq6w+whJxwTkXTisK5z91NIGgj6k5tRkoBUSd/fXiE+tVjGe++wIjVk/I5HTsMi/yzTpAdBXHTY1BK2hO5UKl/ybUALPlJYBXB57iWmdrqAk6OEblz6v71cj27d2PN/Lz3C7UitTLe3cr/HWi2dCyu1dKUOFSd0lEmTDJzbXzPl+G5p90dvwgogaS3SHvq8cxt2NA0MplKGerRXBpq3/zki3K2QWmUGRCR3eZ/h77fZ8pMs/QfBVSnvILURfXzj7KlTlHVQYmTT44MTzv2MPR8AXC7OjLosPsC8vB1CEkYowVL0pGom8R8ppU5z7EmMiUonBVZkcs9AHdrGiRjNw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Zf0G6vIp93cXVq5L1JAs/wvu62+4kNzoArVffAV7fLg=;
 b=Wd8VQzuaj3CCnh3arBIyHO23s+1GvI0LIVvUVoG4aODdWhnVNvFRlbzEY7albSHWxve3rAUpX9M1g2A6V6HdPO3eA0L1nblQYKkWNINWdA+gtA1DFMHb8J0SSVQefZKE63yjKqXH9ViMDxYAHFwy7wiSyaVXNPfhT5T86FcNp0t60aiTxV0HA7wvyNDxdUZDizS2l26DmvI1PcZ7WU6C9HwcSSlKLbIj0invoS4LtrBtP/hzNxCcprqx8gWh4uGSVAH1D57wf7IjYfW2YUBqkCBWmPC9/1ZrxGPKe1XOeXfgfoSJGQXbI4q1iEtcnXAw5gcbQGRo1YCQ46emGlM4CQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from PH0PR11MB4904.namprd11.prod.outlook.com (2603:10b6:510:40::10)
 by CO1PR11MB4801.namprd11.prod.outlook.com (2603:10b6:303:9c::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9700.11; Wed, 11 Mar
 2026 12:45:32 +0000
Received: from PH0PR11MB4904.namprd11.prod.outlook.com
 ([fe80::ff04:50e9:d186:6305]) by PH0PR11MB4904.namprd11.prod.outlook.com
 ([fe80::ff04:50e9:d186:6305%5]) with mapi id 15.20.9700.010; Wed, 11 Mar 2026
 12:45:32 +0000
From: "Korba, Przemyslaw" <przemyslaw.korba@intel.com>
To: Dawid Osuchowski <dawid.osuchowski@linux.intel.com>,
	"intel-wired-lan@lists.osuosl.org" <intel-wired-lan@lists.osuosl.org>
CC: "netdev@vger.kernel.org" <netdev@vger.kernel.org>, "Nguyen, Anthony L"
	<anthony.l.nguyen@intel.com>, "Kitszel, Przemyslaw"
	<przemyslaw.kitszel@intel.com>
Subject: RE: [Intel-wired-lan] [PATCH iwl-next] i40e: PTP: set supported flags
 in ptp_clock_info
Thread-Topic: [Intel-wired-lan] [PATCH iwl-next] i40e: PTP: set supported
 flags in ptp_clock_info
Thread-Index: AQHcr86Xy2U0MgoCgUGFZQFkE41emrWo+vEAgABO1AA=
Date: Wed, 11 Mar 2026 12:45:32 +0000
Message-ID: <PH0PR11MB490435E85241BA01E82C1F479447A@PH0PR11MB4904.namprd11.prod.outlook.com>
References: <20260309141220.343224-1-przemyslaw.korba@intel.com>
 <b42c280d-f6b9-4fce-99f9-00ff65916585@linux.intel.com>
In-Reply-To: <b42c280d-f6b9-4fce-99f9-00ff65916585@linux.intel.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: PH0PR11MB4904:EE_|CO1PR11MB4801:EE_
x-ms-office365-filtering-correlation-id: c1d4e7e9-92a6-4d35-709c-08de7f6c157a
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230040|376014|366016|1800799024|38070700021|18002099003|56012099003|22082099003;
x-microsoft-antispam-message-info: wJaZeQ25LKj9X9hmCj7KyFu6/5ARsftfij+p/sdDXa2J2a/HWssR2gUZ7thyokxp4pdKt74HXqfQqm19gvYDtOZTw0MbAQMCdL4GMtBycRtBC5ALw4AGNeOxuMje06spFImKn42bFxu9t5aFSCm5IWFBXteuDEFkBLJOVi5Ty/NMQW+zPRMNCMwjXn/cqoIg8udilmKU/znccw0d4LyUOXCpiUhUobAn7d+pkC22Pyfoa4bMlOgSWUPg6q44NzGmcSIsT03kakqT7ncLLxGOXApqP+yxw2FaPI8OFFdUBP7V1BjiCHBa1RQt/PEQ4K8+DPun1NUs4MthnstcXXaSZmVBiM1Kv+zWl/UL0sNGc7i6qIT5ZXIH02CrmXCfc4kNE3YMoHywqXdOrvcDmMQ/63WEtRPIqbnhQ5gi+Z3qCvYEKJ2Jvx8bNelgajBzTUFfVrw6cuFp630cuR0XC/rbNJqX5aArzVroxNVXVWKf5y7bnjiYTDJHAeZl8WCWxib6rRgRdpocoBRU2sQi/c35lxKGiRfQCRJtVSu+yT5RZV+kYxNATOvr+ixVTnBTni6PeFyh/PCCFEUnJcQOOnuqoPW3mPWYsVRHh/QQsndvbFiRj8DEgnCbGoeR7y/8NrIFo/13MAM/Eld5ykB+7K7SHSuG3smYooEhUFsPUhw7EiwZetqHmw7gxM9qqEpPU6egwfB20ZviFtpHReUM9tsxNQJ/8FLCSTUrb+m0l0kE6EOG3El+dHYN/O/xLPs0HXRwT5tq76lwqZ7b6NrouLxBSfZVEKii4FqIP8ZKJJXzR48=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH0PR11MB4904.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(366016)(1800799024)(38070700021)(18002099003)(56012099003)(22082099003);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?MUp5OWpWY2V5Y08vTHFXT3k3TUgwZFMydzREMzg2TFBZK05xQnVCZzZVNjdv?=
 =?utf-8?B?RU9xSDZ5QmZCcnBYUXkwZDUxa0pSSVVSRW1xWlhGbEl0Nzd4YWF5dk5sYnpI?=
 =?utf-8?B?cFZaTHJJYVZQNEtMWUtFd1FyNTJ0ak5xbWYyeUY4KzgvajJEdm90WWdaLzBP?=
 =?utf-8?B?Rnp5WlZLdUZZR3VHNk1wWWVYUjdPdlFqTyt2ZDFZQm8xaTR0RGFJN3BVY3V6?=
 =?utf-8?B?TlVycDBCK0tENWl6SFI3YW5nZEMyeFFrVW9vR0hjTDJCdGpjVFJFckw4M0Zn?=
 =?utf-8?B?RTBkU3VYWEJTaEo1SUgyVUdtOC9ld3E1Z2UvYnhlamNSMzN2Szg3THh2YVdP?=
 =?utf-8?B?K2pRbnZZa3A1WTI2bzRRcmdHcjBIazAxN0FtclZhUTR5R1JjOEZpa1l3endH?=
 =?utf-8?B?RjR3Z2JkbUcyNHJLbnhKSlJNbThDcHdvSU1xb3JoeTNsci8zZzdZVEkrRGd4?=
 =?utf-8?B?QUhLYlh2STRlVGVNYUFqT1BEOGk0eTBiRFVqcWxZNFZ2QXdUdXZiNzEyZDdH?=
 =?utf-8?B?cGVpakoyeVdsdUpjelRqcmw5YTFkeGZtTjZka1VyTVE3N3M4L1dyWU9WaE1B?=
 =?utf-8?B?UUZvNjJibHJLcllqMEpmQ2szTXg4Y05PVElQdDhBMzRBeXk5c2U0bUs5RHVF?=
 =?utf-8?B?L3kxOG5nYXlRNmMzYWwwOEFlakpUYnFuM2Iwd01WUEdERlZZdjlveFQ5YWdM?=
 =?utf-8?B?UTdGd0JSc0d1NDBZWjhDcWljc2orQzQyWXRaSmljSFlyc3RSV1lSL1VlRGZW?=
 =?utf-8?B?ZHA4QXlhVXhUb2Z1V05PMVcxVEcyMWt6VGg5WDl5eDA3cEFwdXc0RE15S0Vm?=
 =?utf-8?B?UkFXUHFFS3VEVUw0ZHhHdW1paUNtNTNBYWJSUk9JT0NlNmZya05IdHNaUnVK?=
 =?utf-8?B?ZnJBbHFMVmo2di92SjVtVldkaThUWnowQnlENU5xMWR3MGNWRTA2R3hUUWIx?=
 =?utf-8?B?ajcyMkFjODMvN0ptTHpnRVc1bG1SeUx5dkZvL0FnNVl6cTkzTW9aRFVJLzla?=
 =?utf-8?B?VEMvemNuQkN2YWdZcU9Ud1NzS0NnU0hLS2FGZnplNFk0bGRhNk9KNVlORG9S?=
 =?utf-8?B?NHd5YWFEcFFCVnBoNm5hWWtVMUE1bjVFenhaV283SWgrVjkySStGRU9YcjhM?=
 =?utf-8?B?ZzZGVE9lZ3ExTkxkOVA0Z1NBaEg5ZjUxZUw5RmNucVJIQTFWVEJoTW92OWlR?=
 =?utf-8?B?a2pqNVo0eGxaandnWk1jcFJCSGU5OEg0R0NEU200YU9tV2lVYnVrSU5zR3J4?=
 =?utf-8?B?NWxyWWJwektzSUwyYWI5a1FkUWsydDJXZk81UzBMajBhVkRjQTJKdVd1clFG?=
 =?utf-8?B?RzQxakdTSHJacmJXMTZ4emRsWjBvMVRWcXRpc3IvSHZuaGVZeEJpVForbisr?=
 =?utf-8?B?bmNrZUZIcC9SS2ZUVHI2ZE9VQ0xublBrbDZuS00ybFh6NFg4bkd0M0dHN0VK?=
 =?utf-8?B?K0dTeTJuQTZKRkJuZTVIelpiNTlaLy9lQzFIbXZtYWUyNjFUK3RWSElaQldF?=
 =?utf-8?B?YWJpcHdBL1EwRE4zMGpZK1REMVFBaGs3T2FCODMrTlJpejc5TnBTNFlDbVp3?=
 =?utf-8?B?TGRLMHpocEZZdXVQbUJwRjFFK1A0RWxiUGNNUXVvd3YyckhibzJHcjh0b2wv?=
 =?utf-8?B?eWJCWkNIbWMxeVhjWXcwSFNNVGQ4dHRZRjM3WCtjMHh5Y1kvd3BFOTIvZHZ4?=
 =?utf-8?B?bG9SSHMwSXo5cUdNQjVzVll1VFhtMGYrU2ZoV2dnZ25CaWVEb2g2Mzhsc3Nh?=
 =?utf-8?B?ME9NSnc5cXltOURVQVBoRkRHOE5wV1M4YUs3cjc3c1htdHMrRVRiNEJCcHdo?=
 =?utf-8?B?Nk1nSEJHam5MNEpFV3V4YjVBMkRGMG42elA2eENOYW11UHJERUVUaVJwNXM1?=
 =?utf-8?B?bmpZZHBzdjF3R2JhTGc5Nm5SbUlieDFqaHhjSG40RDFhckxUaVI3b0xCb01a?=
 =?utf-8?B?RHo2SFk5YTk5N2dweHQvNHZaZlNJdzB6aXg3WFBCeHFzRE80NEJLMVJScXl3?=
 =?utf-8?B?NHVwdnJEeGxjRFZXS3VxR3prSXJHM2lxMU9XT1Q5emVvRy9RMnpROVZSSTZ0?=
 =?utf-8?B?S25aZXNGY2VyNG1SRUxPcHpXMG85UnhTWHpuMTJrY2ZsVzdWWWZ6UFFUb3ly?=
 =?utf-8?B?VWJZWm1xdXMrUDRQUFR4NG1lZ3lsak93V2FJMU9PVnQxNW8renFuWE5oaVJK?=
 =?utf-8?B?eElQcFptclZYeFRQUHAwUTNieEFxU0JlM2YrOTMxL1I2d2UvQmF6bXA2VjVk?=
 =?utf-8?B?TVdVY2YyZTRrRTV2SnQ4bTRJVG4xQy9ZZDF5eXNNT08vdzJXaUtITWdxT1VQ?=
 =?utf-8?B?VlBNWlhjaEJUTEJlcGFmRjdWR0lndHR0TnhNTXRHZzRLbkxza3ZVdz09?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Exchange-RoutingPolicyChecked: d52OWNgHlx/YDZBx/cmbDimmEtgvHxrrgP7kfK7AdDKwIGvWTdmbqvGUrBrmSCz4JuP82gsuu6CfKoOrG1QGYKEdveA2PmujaqoCnSM9q1VX4np6q4+gMJOeHgUc/io1WivRjhYoODvLcHanX2kMwxJPoEEWnXea2bOS58K0fl2IZoRWBVWUhJfR3ttyj+Y8FpCQNS2CfbBMOG4wYU1T3eyzx5ehFJ4TV2j2leXngGMoZxV3fxUCbbmJf9hmupH0/liigTAdkHOKYC0y+k3dX74YFFpkPSEyq3nHKnbwVkCUbsjEqf9NKGAWaxi7kOmCMyT4bS9XPY39RXEN4uDOzQ==
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: PH0PR11MB4904.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: c1d4e7e9-92a6-4d35-709c-08de7f6c157a
X-MS-Exchange-CrossTenant-originalarrivaltime: 11 Mar 2026 12:45:32.6053
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: pv4jD/sWmRsQaefXrmAAFQkX1Giyqu+UPytnch4N/rloaU9B4TCxY9qowqd1ia2wC8a1dn4OQ2cYc/xzAKy2M5BiNz74JMrmmakuyy5r5Wo=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CO1PR11MB4801
X-OriginatorOrg: intel.com
X-Rspamd-Queue-Id: 8B0E1263D2C
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [0.94 / 15.00];
	ARC_REJECT(1.00)[cv is fail on i=2];
	MIME_BASE64_TEXT_BOGUS(1.00)[];
	DMARC_POLICY_ALLOW(-0.50)[intel.com,none];
	R_DKIM_ALLOW(-0.20)[intel.com:s=Intel];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	MIME_BASE64_TEXT(0.10)[];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-266637-lists,netdev=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	TO_DN_EQ_ADDR_SOME(0.00)[];
	TO_DN_SOME(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[PH0PR11MB4904.namprd11.prod.outlook.com:mid,sea.lore.kernel.org:rdns,sea.lore.kernel.org:helo,intel.com:dkim,intel.com:email,osuosl.org:email];
	DKIM_TRACE(0.00)[intel.com:+];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[przemyslaw.korba@intel.com,netdev@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	RCPT_COUNT_FIVE(0.00)[5];
	NEURAL_HAM(-0.00)[-1.000];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	TAGGED_RCPT(0.00)[netdev];
	MISSING_XM_UA(0.00)[];
	RCVD_COUNT_SEVEN(0.00)[10]
X-Rspamd-Action: no action

DQo+IC0tLS0tT3JpZ2luYWwgTWVzc2FnZS0tLS0tDQo+IEZyb206IERhd2lkIE9zdWNob3dza2kg
PGRhd2lkLm9zdWNob3dza2lAbGludXguaW50ZWwuY29tPg0KPiBTZW50OiBXZWRuZXNkYXksIE1h
cmNoIDExLCAyMDI2IDk6MDIgQU0NCj4gVG86IEtvcmJhLCBQcnplbXlzbGF3IDxwcnplbXlzbGF3
LmtvcmJhQGludGVsLmNvbT47IGludGVsLXdpcmVkLWxhbkBsaXN0cy5vc3Vvc2wub3JnDQo+IENj
OiBuZXRkZXZAdmdlci5rZXJuZWwub3JnOyBOZ3V5ZW4sIEFudGhvbnkgTCA8YW50aG9ueS5sLm5n
dXllbkBpbnRlbC5jb20+OyBLaXRzemVsLCBQcnplbXlzbGF3IDxwcnplbXlzbGF3LmtpdHN6ZWxA
aW50ZWwuY29tPg0KPiBTdWJqZWN0OiBSZTogW0ludGVsLXdpcmVkLWxhbl0gW1BBVENIIGl3bC1u
ZXh0XSBpNDBlOiBQVFA6IHNldCBzdXBwb3J0ZWQgZmxhZ3MgaW4gcHRwX2Nsb2NrX2luZm8NCj4g
DQo+IE9uIDIwMjYtMDMtMDkgMzoxMSBQTSwgUHJ6ZW15c2xhdyBLb3JiYSB3cm90ZToNCj4gPiBT
aW5jZSB1cHN0cmVhbSBjb21taXQgZDlmM2U5ZWNjNDU2ICgibmV0OiBwdHA6IGludHJvZHVjZQ0K
PiA+IC5zdXBwb3J0ZWRfcGVyb3V0X2ZsYWdzIHRvIHB0cF9jbG9ja19pbmZvIikgYW5kIGNvbW1p
dCA3YzU3MWFjNTdkOWQgKCJuZXQ6DQo+ID4gcHRwOiBpbnRyb2R1Y2UgLnN1cHBvcnRlZF9leHR0
c19mbGFncyB0byBwdHBfY2xvY2tfaW5mbyIpLCBrZXJuZWwgY29yZSBub3cNCj4gPiByZXF1aXJl
cyB0aGF0IHRoZSBkcml2ZXIgc2V0IHRoZSAuc3VwcG9ydGVkX3Blcm91dF9mbGFncyBhbmQNCj4g
PiAuc3VwcG9ydGVkX2V4dHRzX2ZsYWdzIGZpZWxkcyBpbiBQVFAgY2xvY2sgaW5mby4gT3RoZXJ3
aXNlLCB0aGUgYWRkaXRpb25hbA0KPiA+IGZsYWdzIHdpbGwgYmUgcmVqZWN0ZWQgYnkgdGhlIGtl
cm5lbCBhdXRvbWF0aWNhbGx5Lg0KPiA+DQo+ID4gaTQwZSBkb2VzIG5vdCBzdXBwb3J0IHBlcm91
dCBmbGFncywgc28gcmVqZWN0IGFueSByZXF1ZXN0IHdpdGggcGVyb3V0DQo+ID4gZmxhZ3MuDQo+
ID4NCj4gPiBTaWduZWQtb2ZmLWJ5OiBQcnplbXlzbGF3IEtvcmJhIDxwcnplbXlzbGF3LmtvcmJh
QGludGVsLmNvbT4NCj4gDQo+IEhleSBQcnplbWVrLA0KPiANCj4gKipQbGVhc2UgZG9uJ3QgY2ly
Y3VtdmVudCBvdXIgZXN0YWJsaXNoZWQgcHJvY2VzcyBvZiBnb2luZyB0aHJvdWdoDQo+IGludGVy
bmFsIHJldmlldyBiZWZvcmUgcG9zdGluZyB0byBpd2wqKi4gWW91IHNob3VsZCBzZW5kIHRvIG91
ciBpbnRlcm5hbA0KPiBtYWlsaW5nIGxpc3QgYW5kIGdldCBhdCBsZWFzdCBvbmUgUmV2aWV3ZWQt
YnkgdGFnIGZpcnN0LCBiZWZvcmUgcG9zdGluZw0KPiB0byBpd2wuIEkgdGhpbmsgd2UgbWFrZSBl
eGNlcHRpb25zIG9ubHkgd2hlbiB0aGVyZSBpcyBhIHN0cmljdCB0aW1lDQo+IGNvbnN0cmFpbnQg
YW5kIG5lZWQgdG8gZ2V0IHRoZSBjaGFuZ2Ugb3V0IEZBU1QgKGUuZy4gYnVnIHByZXNlbnQgaW4N
Cj4gVG9ueSdzIHRyZWUgb3IgbmV0ZGV2IGJ1dCBub3QgaW4gTGludXMnIHRyZWUgeWV0KS4gUmVh
Y2ggb3V0IGludGVybmFsbHkNCj4gaWYgeW91IGRvbid0IGtub3cgdGhlIHByb2Nlc3MgYW5kIEkg
Y2FuIHNoYXJlIHRoZSBwcm9wZXIgcmVzb3VyY2VzLg0KPiANCg0KSGksIHRoYW5rIHlvdSBmb3Ig
dGhlIHJldmlldyEgWWVzLCBJJ3ZlIGJlZW4gYSBiaXQgdG9vIHF1aWNrIC0gZ290IGludGVybmFs
IHJldmlldywgYnV0IGRpZCBub3QgcmVjZWl2ZSByZXZpZXdlZC1ieSB0YWcuIFdpbGwga2VlcCB0
aGF0IGluIG1pbmQgbmV4dCB0aW1lLg0KDQo+ID4gLS0tDQo+ID4gICBkcml2ZXJzL25ldC9ldGhl
cm5ldC9pbnRlbC9pNDBlL2k0MGVfcHRwLmMgfCAxMiArKysrKysrKysrKy0NCj4gPiAgIDEgZmls
ZSBjaGFuZ2VkLCAxMSBpbnNlcnRpb25zKCspLCAxIGRlbGV0aW9uKC0pDQo+ID4NCj4gPiBkaWZm
IC0tZ2l0IGEvZHJpdmVycy9uZXQvZXRoZXJuZXQvaW50ZWwvaTQwZS9pNDBlX3B0cC5jIGIvZHJp
dmVycy9uZXQvZXRoZXJuZXQvaW50ZWwvaTQwZS9pNDBlX3B0cC5jDQo+ID4gaW5kZXggN2JjZWE3
ZDk3MjBmLi44ZDc5NTg2OTIyMzUgMTAwNjQ0DQo+ID4gLS0tIGEvZHJpdmVycy9uZXQvZXRoZXJu
ZXQvaW50ZWwvaTQwZS9pNDBlX3B0cC5jDQo+ID4gKysrIGIvZHJpdmVycy9uZXQvZXRoZXJuZXQv
aW50ZWwvaTQwZS9pNDBlX3B0cC5jDQo+ID4gQEAgLTYwMSwxMCArNjAxLDE4IEBAIHN0YXRpYyBp
bnQgaTQwZV9wdHBfZmVhdHVyZV9lbmFibGUoc3RydWN0IHB0cF9jbG9ja19pbmZvICpwdHAsDQo+
ID4gICAJLyogVE9ETzogSW1wbGVtZW50IGZsYWdzIGhhbmRsaW5nIGZvciBFWFRUUyBhbmQgUEVS
T1VUICovDQo+IA0KPiBJZ25vcmluZyBTaW1vbidzIGNvbW1lbnQgKG5vdCBiZWNhdXNlIGl0IGRv
ZXNuJ3QgaGF2ZSBtZXJpdCwgYnV0IGJlY2F1c2UNCj4gSSBkb24ndCBrbm93IHRoaXMgcGFydCBv
ZiB0aGUgZHJpdmVyIGFuZCB0aGUgcmVmZXJlbmNlZCBwYXRjaGVzKSwgZ2l2ZW4NCj4geW91IGp1
c3Qgc2VlbSB0byBoYXZlIGltcGxlbWVudGVkIHNldHRpbmcgKG9yIG1heWJlIGhhbmRsaW5nKSB0
aGVzZQ0KPiBmbGFncyBpbiB0aGlzIGNvbW1pdCwgbWlnaHQgYmUgdGhlIHRpbWUgdG8gcmVtb3Zl
IHRoaXMgVE9ETyBjb21tZW50PyA6KQ0KPiANCg0KSGksIHRoYW5rIHlvdSBmb3IgdGhlIHJldmll
dyEgWWVzLCBJIG1pc3NlZCBpdCAtIHRoYW5rIHlvdQ0KDQo+IC1EYXdpZA0K

