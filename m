Return-Path: <netdev+bounces-146714-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 6C8E09D540A
	for <lists+netdev@lfdr.de>; Thu, 21 Nov 2024 21:36:20 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id C60AAB21994
	for <lists+netdev@lfdr.de>; Thu, 21 Nov 2024 20:36:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E87501C8FD3;
	Thu, 21 Nov 2024 20:36:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="Xkm476Xu"
X-Original-To: netdev@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.20])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2F7081BC07D;
	Thu, 21 Nov 2024 20:36:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=198.175.65.20
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732221369; cv=fail; b=WOf5Kj0CduYp5vgMRW9q5cQDW8FC9WZq0aneupLpU8jTy0Gonjxpee9vIZMewheNpBh3B6aNadBMHvKRPx46DFdt60hHDaY+PI2/pRrEno7LV7bDMbEpsc63hSEMJignB9sXR3qlXPcnIAqUgpqTRLYMs5BUG0vErAEokD4qt4c=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732221369; c=relaxed/simple;
	bh=fpftyKphrOqQEgoDfRjShErfyOyrHRngfqKEJUumfj4=;
	h=Message-ID:Date:Subject:To:CC:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=bdkf4aJJYA5w/daEk1VuRUQa3/U8J4FaupGXzwSgRszc+yDwCAwGYN+XCKPgZcQwJ3hLqi0giJAx7r06jvpFMdrwd6FulDpuKaFznzr/QGyRMMFCFZ1zG8MG48w6t5vIJK8hv3zwFRNBDYnc++2Qo+jEXq5JTaDmXWSt0ugM9cc=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=Xkm476Xu; arc=fail smtp.client-ip=198.175.65.20
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1732221368; x=1763757368;
  h=message-id:date:subject:to:cc:references:from:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=fpftyKphrOqQEgoDfRjShErfyOyrHRngfqKEJUumfj4=;
  b=Xkm476XucGK64miTXg/eASJGaTuEsZwIdboBwr8w2uoVYujEUMIsPg6U
   FHYo/pHTvlGdvVojoFSuLaWV8nqc+aZmaZk5OiF80P1Ny3Z1hnylsBgCP
   3MppKdbGF42KsaFm1sAhE38PGNi2E/SI7cvHVPE/fFAQ+Eno3C47lfYvG
   NVV2sCCKeUALCoaRR4X3xp1hSpE9F3xg0RvPcFGnVZfmV72p8vI9VGVqp
   FPZQHb/oVou9zZMsqFJ1QY5MfvhJTObyw0Le7z3CzRyBxwoq+2tEhTIyu
   DGwJAHxQAXbBvQOyB1jOFycTtqKc8yyayaxdo0mzbOYppf6F+V0D94m5B
   w==;
X-CSE-ConnectionGUID: +dsiwTIvRne807TJD1qSVA==
X-CSE-MsgGUID: ujbarbsdSJ+XVtMifAFjJA==
X-IronPort-AV: E=McAfee;i="6700,10204,11263"; a="32108603"
X-IronPort-AV: E=Sophos;i="6.12,173,1728975600"; 
   d="scan'208";a="32108603"
Received: from fmviesa003.fm.intel.com ([10.60.135.143])
  by orvoesa112.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 21 Nov 2024 12:36:07 -0800
X-CSE-ConnectionGUID: L9KSOjB+TgOEKqO9HikNng==
X-CSE-MsgGUID: Bd/zNdgSS5y3J4Crpwc4tg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.12,173,1728975600"; 
   d="scan'208";a="94454946"
Received: from orsmsx603.amr.corp.intel.com ([10.22.229.16])
  by fmviesa003.fm.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 21 Nov 2024 12:36:07 -0800
Received: from orsmsx601.amr.corp.intel.com (10.22.229.14) by
 ORSMSX603.amr.corp.intel.com (10.22.229.16) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39; Thu, 21 Nov 2024 12:36:06 -0800
Received: from ORSEDG601.ED.cps.intel.com (10.7.248.6) by
 orsmsx601.amr.corp.intel.com (10.22.229.14) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39 via Frontend Transport; Thu, 21 Nov 2024 12:36:06 -0800
Received: from NAM11-CO1-obe.outbound.protection.outlook.com (104.47.56.169)
 by edgegateway.intel.com (134.134.137.102) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.39; Thu, 21 Nov 2024 12:36:06 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=NVadFvAbfGo+BF5CNtlcDEHzyfDWsR/N6pOhpzMXujJsG96xd2xr2uDfJwcqQR76eFT5Z16Wn31ECx71UHFH4OyFcSqecEiLNFjh8I5lNkMy10Bob5VaWrKjtPh3yPuZKN26+UwTHGKJ8iA26P1FXY7rgrlSoirvlVO0Iozyn4LXpIHuXSpn7ylX52fTL7GQHZegUUkWf5eIfjxtLkFKI4YPEP2IqhMNkFM/ke04KpRXM9+6CD1FZFDM4J6YRmi7JAc75wAFz636vwTFO8ZMk+aIryltExq4Wvw8bM75JckPAFt4ydzflYGr6ZIT/lDJiCZB7n58Vh0fqCbSHa99Ww==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=xJ8HO4bgVdFBe4oHB7gv14O6N2gBJM1Zhu1txIWA3Aw=;
 b=I94qQf5oFRotxy6odnabla5hwbA+SM0a0dJ69DSSrZfMKknAgNVHuJZxK28QXryW7BXZiyn1t4tW3KB7J2BzXZfs3EjP0UHLhJCrN4JeBk3oJbwyfIJRwTDxbCxjBU2PU7vGufUTOKzHYq2J8wVKB6fYtNXoYnhQyVHoOt8NzatSKBq3QkN03UY16xFIQpOYVmZlf4GSKFNmHpQ/au7y1mBVLQ+Kr0CepLZ1vtiw8J+pG6YRqrzvx6x/bM5h0wV+BkR/Tmku0j4iWIPyS1wfH0lDbaaFEzaUXi9a78Z+DiBP5G1X+TdiaYuL32ZJpAdn6WZTyHweZ7nZii3kuk50gQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from CO1PR11MB5089.namprd11.prod.outlook.com (2603:10b6:303:9b::16)
 by MW6PR11MB8440.namprd11.prod.outlook.com (2603:10b6:303:242::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8182.17; Thu, 21 Nov
 2024 20:36:04 +0000
Received: from CO1PR11MB5089.namprd11.prod.outlook.com
 ([fe80::7de8:e1b1:a3b:b8a8]) by CO1PR11MB5089.namprd11.prod.outlook.com
 ([fe80::7de8:e1b1:a3b:b8a8%4]) with mapi id 15.20.8158.024; Thu, 21 Nov 2024
 20:36:04 +0000
Message-ID: <2b28f8bf-3327-41a4-95bb-858f07fcfcfb@intel.com>
Date: Thu, 21 Nov 2024 12:35:53 -0800
User-Agent: Mozilla Thunderbird
Subject: Re: [RESEND PATCH] net: microchip: vcap: Add typegroup table
 terminators in kunit tests
To: Guenter Roeck <linux@roeck-us.net>, Lars Povlsen
	<lars.povlsen@microchip.com>
CC: Steen Hegelund <Steen.Hegelund@microchip.com>, Daniel Machon
	<daniel.machon@microchip.com>, <UNGLinuxDriver@microchip.com>, Andrew Lunn
	<andrew+netdev@lunn.ch>, "David S . Miller" <davem@davemloft.net>, "Eric
 Dumazet" <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>, Paolo Abeni
	<pabeni@redhat.com>, <linux-arm-kernel@lists.infradead.org>,
	<netdev@vger.kernel.org>, <linux-kernel@vger.kernel.org>
References: <20241119213202.2884639-1-linux@roeck-us.net>
Content-Language: en-US
From: Jacob Keller <jacob.e.keller@intel.com>
In-Reply-To: <20241119213202.2884639-1-linux@roeck-us.net>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: MW4PR04CA0097.namprd04.prod.outlook.com
 (2603:10b6:303:83::12) To CO1PR11MB5089.namprd11.prod.outlook.com
 (2603:10b6:303:9b::16)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CO1PR11MB5089:EE_|MW6PR11MB8440:EE_
X-MS-Office365-Filtering-Correlation-Id: 6e2105f9-c456-48e2-4206-08dd0a6c1e4a
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|366016|7416014|376014|7053199007;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?Z1U4N2l5UW03SFFjeUZLMEplQkpsWGZ2dGtpUU5JNXZTaGZXc21ObnFvS1FG?=
 =?utf-8?B?bE5BU3BOTkY1VldwRkV0YWJXTmxBL3RuODUxMk8rZ2VLd1VrbUEwZjJtMW5i?=
 =?utf-8?B?WFZEWFhhYmlCMXdJZFk1dHpvTjZvNm5BR1BVSVA0Y3huUW5EZENxS2h4bDhw?=
 =?utf-8?B?Z3VJeTZOdXc4Qnk5bVQ2QkdRYXU5UEtnSFZybGoydkI2Zy9jVnNXU0JHM3Bn?=
 =?utf-8?B?aVRDWlY3U0txZmJTdHRxVzNiL2YvUHhyL3VGajVOdzhWM3RqbHhpM2lxMnJk?=
 =?utf-8?B?bnlseTR2MzcxY0p3Vy8zWDQwSnZSc1NGdmplNDZCT1RkV2dyVVdvcVNQTms3?=
 =?utf-8?B?M3RScXR4UTR3cWYza3ViV2NZVk4wUkd0YU5zbHhWdUpNTDJTL0VLOHA3a0o0?=
 =?utf-8?B?V3U3VGE4V0NXMm5xWk55cWY2bzErZG5ReThGbE9GR29PVEthNytlMG9VMnFu?=
 =?utf-8?B?MklSSzh2ZjFhMXFRemV6cG1CMDN0cDBLUmorM2lRL1RTK3JMWHFjNlErTDZ5?=
 =?utf-8?B?Sm52Yis4WGpqL1pkMUUrSDhlOEtjTlJ3Qy9JWEs3Mi95eEx3QkdPRFNSd0hF?=
 =?utf-8?B?M1JwNHZpSFI1ZHhUNC9QSGRpbTBsZGVBMTlBZXo4bUhNdWRBajBsd2ZzZThs?=
 =?utf-8?B?YmxNMVNHblE5d1BMdjNvWVdvcjRSM3VFNitVOWhjdW9KRXFBdlppTCtNYnN2?=
 =?utf-8?B?dHVwR01ydVNBczBTT3k5UTQwV0JkT2VySE8yN05XelBNYzVaRTBzSGhsMVZk?=
 =?utf-8?B?M3drOE4wWXhpOVdTcXlGQVpUb2p4WnFVcDYyTWpDVFFXSittazRjcHp1RGJS?=
 =?utf-8?B?VHNueGRIMUIySEVudTB0NTByTC9uRXhtSTAvekM1YnQyTVB2T2F6RWE5a05W?=
 =?utf-8?B?V3R5bjdnZEtGcGtLVzJpaytDV29jWXRRZ21rb1VtRGFjbTQzY0RYZE5OSS9U?=
 =?utf-8?B?OEt6MU9pZmh4dFFWRzlXdk9ubGd3QkpYYklxRjJoMzFUTE9STFIyNEJLVFg4?=
 =?utf-8?B?NzBtOWg3WmVQQVlpNGFDTXdBSk9CSVE1QjIzV2l6MCtuQ2RUR1dONnlTeGRO?=
 =?utf-8?B?SXREN2VGbzdqRVQwaEdPTEQzbUJMMlpYVXoxdE81bk9FeG1hM2xxcEk5L0NK?=
 =?utf-8?B?UlVXRjl1T29oZkVJdnc5d052ZmRKS0k5aVllZnR5YzF5YzdYT0VFbDQvR2dl?=
 =?utf-8?B?QWJFcGRxKzhMUkFXWTU4U2FubzNnU2JZSFBEZ0ZtQnJSZTNiZ2VxcTUzcG04?=
 =?utf-8?B?K1RTMnZhSjJYVUplTDUzVm8rdU9HRWhGKzdhRS9HdzlOYjg3RGxiUWlBNXJq?=
 =?utf-8?B?V1lKU0VpVWp4dXE1SkhBU2k4QnlTVCtUQ2Z1TmVuVE9zRHZzRzdWd1QxTDZE?=
 =?utf-8?B?WHh1cTdCcXlnenlmdEFjWVpiR2I0U3RQTHp3UjA1Um5pQ2JRVUxlNTdEZGZv?=
 =?utf-8?B?ZGdTN1c3aUxzc1hCcEU4NS9JTlcza2djSmUxSmZDUmFxVEJQRFRBSm91dHU1?=
 =?utf-8?B?QVJGQWYveERPcTNHbEtoN00rSWRsKzVpYk1nSTEybytMUEdiL0xFR2t6Zzdz?=
 =?utf-8?B?bTV1MnI5UUhUNUlPY1Y2eFBBSzlnTFg5dkVydVZKQitqc2pSU0o2cFh6SUZz?=
 =?utf-8?B?WUIzenJSTDMyT0Q3YVQyK3FvZ2VpNkVwK0tGa1VlVjV6T3NlR1pmYzVINStw?=
 =?utf-8?B?VjlaV010bjErMWZBb2xnY2VWU3NsVWVBU1k1T3JNRFl1U3E0MDVkemdUbmpr?=
 =?utf-8?Q?CWKtpvuTzGNF4paiAs=3D?=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CO1PR11MB5089.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(7416014)(376014)(7053199007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?Z1VFRFlnNzVCUTlHdHdSeWJTVEUra1NxMlhreWUwN1ZIbGZDOGlXMWFkSXN5?=
 =?utf-8?B?YW9TZ0hKTGo1cUlkbmxZcTJ5NnorUFVGMXpWN3FncWtCZ1hHRjlSM3VkbWFh?=
 =?utf-8?B?ZVF1L1JBVTEvNnlIb3ZtRHlqRkV0RG1PdjNVV3Q0MjFod0RibTVTWlltTmlN?=
 =?utf-8?B?ZWtzZjl2M0NiQTlFc0wzQ3F1RXBhMWFRa01NUWd2cXZhV0NBSWNJVjl6a2hk?=
 =?utf-8?B?QndoV0w5NTBoL2NnUy9yQzh5UGJmREFaV1FUYkk1SU8wN0dZYmNiRWlWcWJP?=
 =?utf-8?B?aXlrbkczR085c09mZXp5clVWZG9KSHQ1cGR3RGxwL0daMFRFYjM5SWJxOUFj?=
 =?utf-8?B?VVdnY3hZcEVWOCs1ODNHQ2xvSDJTOTRYUVIxYVBBRFYyUE9VQUFjZ0pFdXh2?=
 =?utf-8?B?ZFEwUFlXNExzM0VsRGFQNml0Tzl2Z0tsVFVnL29sUDJJRSt2d1F3Y3VNN2h2?=
 =?utf-8?B?bmduSXoweFBhRU55U3F2NTFqays2eitwQkhNT045Y0hkczladk9IdzNJWlVx?=
 =?utf-8?B?RmFacGZqeGFoL2pwSnFKdzFXNDFFRUVsaVZjdUxwNkdyWTlBUDdXbzA4RW1Z?=
 =?utf-8?B?QkQrYTZJaUdRRWxucWhWWW41bVduRFpHUWNJb3VXc0VMNDRETzlhUld3QTFw?=
 =?utf-8?B?V3ZsZHJTQm1mR3RjNVJlNDhkY3RDcEFhaEZTdUhoc0tiVDY3ZkZFazJhZUgx?=
 =?utf-8?B?dW1QbGFzdEk4L2JBd3gvZU9vRTd5NExGQVZDemVNYnFBVHU4Vm1VY0duRmcy?=
 =?utf-8?B?ejlRWUQyUVRIM0tpZHlDR051SCtUWDczVHJWdW9ja0NzZGFKWDV5cFFxK3Rw?=
 =?utf-8?B?VWlEeEdJYmJSUlhXYUl1cXFENjd1QWxsOHRxdGtubHlqMlhIbE9uUDdkYk1w?=
 =?utf-8?B?WkVwQTZHUyswV0RiSHRGY0FTRjgyekdjb0hkMlVuZERjWi96SVlnZkh6SFBM?=
 =?utf-8?B?eWs1VTBmMVg5c3U4ekx3RXk5dkRWZ0VVMldJU0I2K1FHNFk2OFY5MDFOQTc5?=
 =?utf-8?B?cFU3MllmTkFaTmZpeUs1RVZlU09iY21iVjVsM0o2YnFLZ0EwbHhKUTFnQllk?=
 =?utf-8?B?RDVaK3lMa0ZFWGxpZUJ3OTFDZXB1anBkczVEdkZJc3Q2V1dKc1VTYkgwV2d2?=
 =?utf-8?B?V216VDd3cjZESW9vQUhad0pJQ2pPQllmNE4vbFdMdFRVR1B5M0d0UWhJZ1kw?=
 =?utf-8?B?RXhuSWJvc1BqQ1NGMEZDYWk3ekNZenJhazREL2RENWVnNXlNdml0ZUlQYkRG?=
 =?utf-8?B?WHR3b1V5K2x1T2MrWTRoaDdOTTdtc3orVTJwSEJKekg0U1RRK0FrS1JTWFQx?=
 =?utf-8?B?VzREamlsVTRWMHMyamIyWEhmdlRJK3NUNnIwbFZBSDczUTFLYVo2NDF3NWdL?=
 =?utf-8?B?TVROcFB1UGJNMldhNEliclhPYmFtSlJDV3FySE5CdjVuZXBtdHhTeFRUeHZx?=
 =?utf-8?B?emxPMTZCYW5YeCtpMG10RW5mWS9QeHhmV015WDE3dGR6U0FPak9MTG1ZR29R?=
 =?utf-8?B?Z3lVQUJrZzlRSHhLZDRwT3JLalJJY1dRYmJJa0FPUFoxOXlHTzNTaEtFeUE5?=
 =?utf-8?B?S2lOb1VPN3BmdFJsbmpqWnhGdTBXQy9LK3dKVlV4S2JsUnAwQzVwR0RHTFF5?=
 =?utf-8?B?L2FqbndpcVFBejJoMUxLNXFmVXhiWlZ6ODdLc2xiYXpqQUxIMkhEL0FMTGNn?=
 =?utf-8?B?Z0JmVFgyZmZQUWs3dUZZRS95ckVLUXQ5MUNRcVRUWW5TMSt6WVBhQTJUY3lu?=
 =?utf-8?B?RjFtcnZpQkVjMDdnVHJ4UUsrYkdTRk5MMlZkdVgreG1VOGwrTE40TGdiY3h5?=
 =?utf-8?B?bEVZQ09GTnRFejMvQThpZ0hlcEJMWjhOZkZCZlJrdlFRcVRWMWFwVThDMDBW?=
 =?utf-8?B?UU1EaDJNTlJwbFdjS2pqajJqVlFYMkMrclRUOEZiQm5oVEhCNVhkY2VTSUtq?=
 =?utf-8?B?aU1IZDZXOVFNYW1od3F5cEZiQUhSd3hLYUhNTXdzdHUrWlpGNTd2NnR5c0NK?=
 =?utf-8?B?YytvU05YNTI2bkVaTWtwdXZYMDN3T0YzY3B1TlFLK2pkSS9uLy9DT25ucW1q?=
 =?utf-8?B?ekxPUi9VQjhOV1FsQkhLT0FmSUVWMlRsRzkrZmNNMGVmbUJEUHE0K3pzUmxU?=
 =?utf-8?B?eVdTdDZYN2V5YlRMdWlkMEx4bk9XNE5KVWRmWTIzbGhIYjlBalBobmk3QVRY?=
 =?utf-8?B?WlE9PQ==?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 6e2105f9-c456-48e2-4206-08dd0a6c1e4a
X-MS-Exchange-CrossTenant-AuthSource: CO1PR11MB5089.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 21 Nov 2024 20:36:04.1731
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 4kdabCx00XQ1A1qI/Dhx6KyU195EAiPDx6AZSazN8w39qcIgGUjqk7YAKcwPvOgb2tiT6hPGq851kHQNg+g0HXmv8e3g84sLrZ04cdBwLcc=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW6PR11MB8440
X-OriginatorOrg: intel.com



On 11/19/2024 1:32 PM, Guenter Roeck wrote:
> VCAP API unit tests fail randomly with errors such as
> 
>    # vcap_api_iterator_init_test: EXPECTATION FAILED at drivers/net/ethernet/microchip/vcap/vcap_api_kunit.c:387
>    Expected 134 + 7 == iter.offset, but
>        134 + 7 == 141 (0x8d)
>        iter.offset == 17214 (0x433e)
>    # vcap_api_iterator_init_test: EXPECTATION FAILED at drivers/net/ethernet/microchip/vcap/vcap_api_kunit.c:388
>    Expected 5 == iter.reg_idx, but
>        iter.reg_idx == 702 (0x2be)
>    # vcap_api_iterator_init_test: EXPECTATION FAILED at drivers/net/ethernet/microchip/vcap/vcap_api_kunit.c:389
>    Expected 11 == iter.reg_bitpos, but
>        iter.reg_bitpos == 15 (0xf)
>    # vcap_api_iterator_init_test: pass:0 fail:1 skip:0 total:1
> 
> Comments in the code state that "A typegroup table ends with an all-zero
> terminator". Add the missing terminators.
> 
> Some of the typegroups did have a terminator of ".offset = 0, .width = 0,
> .value = 0,". Replace those terminators with "{ }" (no trailing ',') for
> consistency and to excplicitly state "this is a terminator".
> 
> Fixes: 67d637516fa9 ("net: microchip: sparx5: Adding KUNIT test for the VCAP API")
> Cc: Steen Hegelund <steen.hegelund@microchip.com>
> Signed-off-by: Guenter Roeck <linux@roeck-us.net>
> ---

Reviewed-by: Jacob Keller <jacob.e.keller@intel.com>

