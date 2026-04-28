Return-Path: <netdev+bounces-281903-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id SJhPEVjD8GloYQEAu9opvQ
	(envelope-from <netdev+bounces-281903-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Tue, 28 Apr 2026 16:25:28 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id B1A86486E48
	for <lists+netdev@lfdr.de>; Tue, 28 Apr 2026 16:25:27 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id D733C30674EE
	for <lists+netdev@lfdr.de>; Tue, 28 Apr 2026 14:00:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 61F4043C067;
	Tue, 28 Apr 2026 14:00:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="EyOMkrZy"
X-Original-To: netdev@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.10])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 424DC438FF3;
	Tue, 28 Apr 2026 14:00:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=198.175.65.10
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777384834; cv=fail; b=FsPhZISkXToMWxePN4eRFUnyh3i6fJ3D85Ct+nmM1pFuUVJzatFvgRMyF6snAEtIh6VpRO0SU8VV8b5rwCesqRp2zSuhvtwkRF9B76+Olqtltct3uxyjLhlyAziG0U4klU97XCy5YI+PTUUJbYaXBpuaEbz2MMPyjZtZZDB2t6U=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777384834; c=relaxed/simple;
	bh=bEGcQA0XTjSK8aPRwrU7CJ5D6EpM/t6+Z0309CNKC/E=;
	h=Message-ID:Date:Subject:To:CC:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=pBpl2VrvSaAAPth6MHg8doBjqutTTiwFpo35BDRzuK7Usdo+3w362/W/bPjDOczpQzMv8e9jIoBAh1jbz5mNRTDJvayYVchDZG07kl6WJ9qFdviBAhVrzzUB2HdTyn+TMBZ9dsBXnVKCOE3Zx67OI1dfWXkoZY9hlO+FHyEEqNs=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=EyOMkrZy; arc=fail smtp.client-ip=198.175.65.10
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1777384833; x=1808920833;
  h=message-id:date:subject:to:cc:references:from:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=bEGcQA0XTjSK8aPRwrU7CJ5D6EpM/t6+Z0309CNKC/E=;
  b=EyOMkrZyLYEyBHGCx8vXVGqAKwXEtI33DtTCqVErZzEBwjW2TSaCDgfQ
   pXHHMc0Fl+bhp9pq1wfic9g7jn0QpLLxeYNVarbBIpbOBY7QB0hrOhK5m
   udsQEvJFUSrrI5W9YPiNLZOtD0c0CiuFIKaTgjaCtl1obTt+kF6+SVXfv
   N0DCd3ETToTg7RJLqFHO8vYQOevCBNqRKc+NqGmsNV65BqyhezOKzh3il
   iBLnVKIqNQdxLJ2kQD+l20Awkd7Nly8t8Ia3WlB2blLDIrdaBut5dgPYJ
   R3m3FQbV0FE8aA1SU0XZ68qWE6DENgtleLA1d4Iic85GXYptYduJB+tvV
   Q==;
X-CSE-ConnectionGUID: u1XaDI3+QY+fPGzYDF7EVw==
X-CSE-MsgGUID: r7dYTFQaSRKZFUmXx03c0A==
X-IronPort-AV: E=McAfee;i="6800,10657,11770"; a="95709274"
X-IronPort-AV: E=Sophos;i="6.23,204,1770624000"; 
   d="scan'208";a="95709274"
Received: from fmviesa008.fm.intel.com ([10.60.135.148])
  by orvoesa102.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 28 Apr 2026 07:00:29 -0700
X-CSE-ConnectionGUID: YjYRpLJjSA+QhbOMtw5vKg==
X-CSE-MsgGUID: vn+ksTVYTK6LPGoWzYDDUw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.23,204,1770624000"; 
   d="scan'208";a="231322641"
Received: from fmsmsx901.amr.corp.intel.com ([10.18.126.90])
  by fmviesa008.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 28 Apr 2026 07:00:28 -0700
Received: from FMSMSX902.amr.corp.intel.com (10.18.126.91) by
 fmsmsx901.amr.corp.intel.com (10.18.126.90) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.37; Tue, 28 Apr 2026 07:00:27 -0700
Received: from fmsedg903.ED.cps.intel.com (10.1.192.145) by
 FMSMSX902.amr.corp.intel.com (10.18.126.91) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.37 via Frontend Transport; Tue, 28 Apr 2026 07:00:27 -0700
Received: from CY3PR05CU001.outbound.protection.outlook.com (40.93.201.60) by
 edgegateway.intel.com (192.55.55.83) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.37; Tue, 28 Apr 2026 07:00:27 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=I7RMVWihNEBUvNampPgk0RZCrQPAMv5NStUBKfRgQZbbaa0YaRs9tLoW7X4ZqW57d/iHVELIs0cusG+9faZ129GAfuejsNw4gdfMgZ8AJiaKd8EL8Hx99n4rRtlN9WVa/EI7u25ReMAMDkN1CZ/xmBqJ2eHeMoRLiJEMhJ3O5Y+8oS0WfbIzBuc2qsU8sK9IiEVtQU/POIDeSiVhlM3CoPFtYR9RYc0BXlw5cQShFTmlnR5Kt25vhQ8N1MDCFaW+SeYMnDydJPK/9KWD/Z2GlzRFgZkEHB9WOfj7aDVXnJCuwOJG1KaIcPsvu0NehsX+t8sgHjfdHJmY6HsGikc0FQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=gSLRsLptk4Nxtna+iaLfFpJ5ic58n9VYEUByl5fAD9Q=;
 b=oezQYFiDFKaxQ4+4zd+m7dh8i6FZoPnxk0iCXv1OIEuWEVTEBy7avhjXp3UGJatBsljYTYJ14/22nL9kiEkKRhLT8NTiLJ3oBm+WFrlKkvz0MAAssgDEP+stfw8G9qutUnzVwG/WT3R5xnSo6j3TFvbw9ybXsYONPuB85GI3V3ToqDvT6C6fSj83BrVYkgclGrYXkWtUvUBd9w50LSOWxB6lz+YVY2vJA0nmSdLAwhQ9tDga54NL56zX4gqs8rFhSeTrUtw5+SaSF+rHtgyccEuzjy0CKaYUQxsI/x2IoMggUHnLRH5swzABYVBhU0w0H72wu6E3B1toS3h3Q0Zk9Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from MN6PR11MB8102.namprd11.prod.outlook.com (2603:10b6:208:46d::9)
 by SA3PR11MB7581.namprd11.prod.outlook.com (2603:10b6:806:31b::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9870.18; Tue, 28 Apr
 2026 14:00:23 +0000
Received: from MN6PR11MB8102.namprd11.prod.outlook.com
 ([fe80::8d98:e538:8d7:6311]) by MN6PR11MB8102.namprd11.prod.outlook.com
 ([fe80::8d98:e538:8d7:6311%5]) with mapi id 15.20.9870.013; Tue, 28 Apr 2026
 14:00:23 +0000
Message-ID: <2106884f-6914-437f-84eb-262581b9fef7@intel.com>
Date: Tue, 28 Apr 2026 15:59:46 +0200
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net] ice: fix stats array overflow when VF requests more
 queues
To: Michal Schmidt <mschmidt@redhat.com>
CC: Tony Nguyen <anthony.l.nguyen@intel.com>, Andrew Lunn
	<andrew+netdev@lunn.ch>, "David S. Miller" <davem@davemloft.net>, "Eric
 Dumazet" <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>, Paolo Abeni
	<pabeni@redhat.com>, Jacob Keller <jacob.e.keller@intel.com>, Petr Oros
	<poros@redhat.com>, <intel-wired-lan@lists.osuosl.org>,
	<netdev@vger.kernel.org>, <linux-kernel@vger.kernel.org>
References: <20260427151827.43342-1-mschmidt@redhat.com>
From: Przemek Kitszel <przemyslaw.kitszel@intel.com>
Content-Language: en-US
In-Reply-To: <20260427151827.43342-1-mschmidt@redhat.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: VI1PR02CA0054.eurprd02.prod.outlook.com
 (2603:10a6:802:14::25) To MN6PR11MB8102.namprd11.prod.outlook.com
 (2603:10b6:208:46d::9)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MN6PR11MB8102:EE_|SA3PR11MB7581:EE_
X-MS-Office365-Filtering-Correlation-Id: 6a5dd7e6-6665-4270-cb79-08dea52e7dde
X-LD-Processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|7416014|376014|1800799024|366016|22082099003|18002099003|56012099003;
X-Microsoft-Antispam-Message-Info: S04Q54y+cgnYVl7rLsb+bNyTo/4SmpJu9VMqOoJwn5k6H4H5YDZRCPTkIlxfqKr+PLfDm03sf/6CZBZWSmKAqM0iQu/kmhvnXZSOnRzFVOM8eH+DOGC1sq2MA6fbIhaNFgJfBx3WPtalp8rBkmh8EYDAEOpLzfhFwn0jzqqyImqUUjVUfay5+9r/VTMhDYsHZyEaNoInMQaPmhzKb88B/9tvxJPN3DWx2psbbbsuqOWw7z+HRJcNNHRK2H+59v4sq6JxcmYOiTxzLTSLbMgNK3wW4Z40OfsqMC/eybLfhwIMEwAYbPJPNFA+X8qhRJj2Ak0ENJ01flXeYM7YcTivw5+TO21aBzsdB/kDozApnc9JDE/TvIQhvgFJPxZe0xzCPJxEg3J0MOkf7RqP2xaY+6Uxc6CsrD9yAxWuYxhwHZWRKIAM95qbBBkiOKoWtXf4qRZPgC1+W8YXrAKSRAuEsiQnXYlDigcdEsRULV/773C/AB56fyQD1G12ynQlS2zt4WHZUQJbmh6I4LmfxHk7W1JferMXbZsRerSvWqEalEv7EuG9V9JD+6Hl6A0YPtofYqbycB/7Un4+6CIiVk7c6Kez1amWHzlL1x3+eA39Yd3urS9NhxlaJd6wChgfNVOIUxduQCEWgYyb2k+fJzOnH0r7krQlK6vYiLFr9PoETUzmWvi1lj4gXxiOjq+0xD/X0MJARUI8CvDBw7+8nPoXRW/b8xDa0CC6/YlowjSfeRD5CqKhTXlam/8y6ugK/8jm
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MN6PR11MB8102.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(7416014)(376014)(1800799024)(366016)(22082099003)(18002099003)(56012099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?bDJqQmVJb0YyWkhhU2M0YlhDZ3licE9pUGdYRVYwWlk2ZWNIZWxzU3lFWXZY?=
 =?utf-8?B?aEdNS3Y5UXBUSlVIOCt1WW9Yekl0dytnL0lGcUlVZTVyUE1TNFZvSWpHUFZT?=
 =?utf-8?B?bXpwVW0rZ2F2aFhUOERjT2F2cUpIY1E1QUZ1bGgwakF6eXIwak80VnNTa3JR?=
 =?utf-8?B?NFpJNXpBdGdnaE4zTEpseDR3K1ROQUNla2RmcnVwODUwNGFxdXJucWgwcGNW?=
 =?utf-8?B?aXF1VC9XY3ozei9sQkRnVU9GRmdLUGN3aHQwY0NNcWxvSTZ6K0RrRTdLcnN4?=
 =?utf-8?B?a0NlcWFLemNBQlZQcVZ1alVBalhpNlA4Ym1zY2FLN1VWMVlnOFBsU2ZZZWdV?=
 =?utf-8?B?M3hvTGpUWXNrdElsV1BuaGJpeUZSTXVNV0xHcmFVVGw1dmFMQk9jSkdmMVlZ?=
 =?utf-8?B?L2wxTWhQR29DL28xOWtpVlNIeWtFSVRXWnplVU9ZSS9mZTlacXRCYk9WSHBq?=
 =?utf-8?B?UlpoTjJDblR2L0trbUUxeCtFVytPUmV4dGcraG4vOHB5UXgzRko2L0M4N0xV?=
 =?utf-8?B?VDQvK3JaOCt6aSt0aDJINUllNWpDdzZRV29tM0F2eTE2UmtYNGpKeEpRZHYy?=
 =?utf-8?B?MHBNWDFZQndLaEtSNFVFTDIvY1hqTWhzWXlITkRtVjlJUi9ZZ0M4Si9GcDBW?=
 =?utf-8?B?N1lWMFErUE8rYmFqbFdIUXJVNWtJZDNvTjAwNUxLY0RxcjkzWkJpcWxtbnM4?=
 =?utf-8?B?NGxMaFpWRVd1LzVJT1A4aXN1YUV0eVVRenhyZEZtSXhTL3VJT0VYNi9Ma0g2?=
 =?utf-8?B?MVVJWW8yQ1RDYlhWQjZ4RjlSZHMxbmFXaEcvV0pqZG1ON3JheG4xaUtsWHZl?=
 =?utf-8?B?M2I2STlldDBxSlNJQitHWExYc3ZHMjJmT0F0Mm5VRUVYWFY4dnEvRzNlQ2JL?=
 =?utf-8?B?Ym5xTXgrc29FOXNQZDgyeDBxWDFobTBEK3lOWGxaMW50bHUxMU1WaXQ4N3FV?=
 =?utf-8?B?SFd4NS94YmFzbmdkOUVEeHo1NXhiNUdVTjZqQ1c4SytJOHlNQzNOc3drRC9S?=
 =?utf-8?B?MnJ6SzFsdktnZ0dheFFDNTFOWkRjaUFTOTR2aEg3OGxMd1pLY1NTTVNlR0pI?=
 =?utf-8?B?eFhOYmFiVDJWc25DTlU3Y2tpVnlJT0s3MTA1RXNScUUvUkhjQWg4UWtUcWpG?=
 =?utf-8?B?cFYwL1NMYjREMG1Dd2Y5OE8rVEF0TnA1RGFqTW1qNzJIYys0bjBKa0V2Q1BE?=
 =?utf-8?B?aStneCtMQXZGeDA4bENoVUJQZmZhcXkra1pmOVplMEhQVmlwMEY4dmQrUlZG?=
 =?utf-8?B?WHV2OXk3K25vN3VURENCbDhmM1daMXQ4QlQ3MXYxVDd1ZUxiMEdpZFdGNWVE?=
 =?utf-8?B?MWcwSm81M2xUd1FQa0NudHBxeFBXMW8xSThLbHNjcU15cXA1OVNxN2R5dnB2?=
 =?utf-8?B?ZU9BS2Y1cktKKzVtUE0vVm9XL3hQaW95ZVl5OENTa0crRWpzdEljRCtPajRJ?=
 =?utf-8?B?cERFZVRqU3lhT2llUmxESVArWXZQRUpYWEF0TlJoa1RzSHpHMUE0Szdsa25Q?=
 =?utf-8?B?TG1hOHE5MW9pMm9qenhpNHhSYk9yUGk2TzUzREJZMGN2dEh0SEc4YWxFR3FE?=
 =?utf-8?B?UnY4RGthTE9idkVEZHc1NUNZNXdQTzIwQzdWMjc0V2ZVZEN2Q3d2ZmN3RHJ5?=
 =?utf-8?B?TnBjcXpzc1Q0R2twb1h6YmYvbHRPR0ZpZXBLODhHdVRJbVhRcEtUWmZCalMx?=
 =?utf-8?B?bzhvNWNJemlpd0ZOSlFrS3dOYmJHbUNHMmdVdlAyR3BZN0crZTNJWkNVQ2J1?=
 =?utf-8?B?ZzR2S0d0K2MvckFZTDBGdGZmcU5WVHhlclpkM1ZaM3JaVHo4VTF0a3FiWDdj?=
 =?utf-8?B?R0hkYVZSbnNjRnBHeEZZWDA5dTQwYVQrTWYrS1c2N2IycEIrRFlsUWM3eGhF?=
 =?utf-8?B?Z0s3RFlWZ0JYd0sxSGRmQ1liR1lJMVdLaXFhZzExVHFBQjVOSmV4bk1tcmV2?=
 =?utf-8?B?dExnL3VXTXlvbzZLTWk2bWJEa1REaVlYcVRKRmpmVk43OUNCb0tJSU52M05l?=
 =?utf-8?B?SElvdm93cFRsUm5kWnRnRnZHY0hwV3FydFJnNSsvRzM4bFNoMThTQ1Vqd0E0?=
 =?utf-8?B?d0JGNnVWRmhXTndQdTIvQ2hVdHRLeG4xWHR5cUtVOEM3RE1qUUlEWmhuQVk2?=
 =?utf-8?B?NFRMa2luSG5uR09JMUhDUi94VXRjZmNSTzY5WTFXcmhIYUhudCsvWU5uV3ZT?=
 =?utf-8?B?WlRRNnZmdVlSWEJMNDBUM01sWWI1SVZsZ3BRNHJlWmJLbSswY2szTUZSbXBH?=
 =?utf-8?B?c2JaZDNBQ2MzbDlzS21XV2R2OCtzZXAyTmg4cUNFdWZvYlRWVE03MVFENUR0?=
 =?utf-8?B?WjA1VG13SDlLOWlPQlFSQU9CZUlsdldETVlaNE5BYzdNNkxFK2dMSlZPTXBQ?=
 =?utf-8?Q?esJmNF2tNjETIwiU=3D?=
X-Exchange-RoutingPolicyChecked: XRarYtphcsrBzNNyml+KaE5VLKaOFv1m2D7lC0UG/6z7enmOiyxliGLaE8R+2II1+v7jW4jFK7ylhdEkIqjo7YoSlTveq8I1ATZjA8Ws7E3M7hUhpLMjmvMI/uq/53ofVFUJnWHqaeSvDu2Aq1n0RV4hUoDuzMeg8BPBhBzadDeY2L+bVRZ6tpsmApGBv3B3jF/ehdxOGdHzVi53Smh5LGikaiFcxsDZ0MCNpCX2luh0fjJR4BTnyhyYE5Y9TKMtXkG6Q0lM6XUYdieUoYBWpCQhKmIA6U69we/fEz9eBg0Yov3iYEG11614T/gDY597QPqdmv38k1LSkq/0wzLgwA==
X-MS-Exchange-CrossTenant-Network-Message-Id: 6a5dd7e6-6665-4270-cb79-08dea52e7dde
X-MS-Exchange-CrossTenant-AuthSource: MN6PR11MB8102.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 28 Apr 2026 14:00:23.5120
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: PsMJfDHP2cAw6EHcBvMu8mNhU9Z0kENqwy7yis8Mfr+CzmEj0xIf57h0ofN4gbeQd8z5W6Ci6roucrk18fqnCtBP1agwSO9i8YjsPiszzIE=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA3PR11MB7581
X-OriginatorOrg: intel.com
X-Rspamd-Queue-Id: B1A86486E48
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [1.34 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_REJECT(1.00)[cv is fail on i=2];
	DMARC_POLICY_ALLOW(-0.50)[intel.com,none];
	R_DKIM_ALLOW(-0.20)[intel.com:s=Intel];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	MIME_TRACE(0.00)[0:+];
	RCPT_COUNT_TWELVE(0.00)[12];
	TAGGED_FROM(0.00)[bounces-281903-lists,netdev=lfdr.de];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[intel.com:dkim,intel.com:mid,sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,atlassian.net:url];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[przemyslaw.kitszel@intel.com,netdev@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[intel.com:+];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[netdev];
	MID_RHS_MATCH_FROM(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	RCVD_COUNT_SEVEN(0.00)[10]

On 4/27/26 17:18, Michal Schmidt wrote:
> When a VF increases its queue count via VIRTCHNL_OP_REQUEST_QUEUES,
> ice_vc_request_qs_msg() sets vf->num_req_qs and triggers a VF reset.
> The reset calls ice_vf_reconfig_vsi(), which does ice_vsi_decfg()
> followed by ice_vsi_cfg(). ice_vsi_decfg() does not free the per-ring
> stats arrays. Inside ice_vsi_cfg_def(), ice_vsi_set_num_qs() updates
> alloc_txq/alloc_rxq to the new larger value, but
> ice_vsi_alloc_stat_arrays() returns early because the stats already
> exist. ice_vsi_alloc_ring_stats() then iterates using the new larger
> alloc_txq and writes beyond the bounds of the old, smaller
> tx_ring_stats/rx_ring_stats pointer arrays, corrupting adjacent SLUB
> metadata.
> 

thank you for reproducing the bug, it is exactly the situation that
I was facing
have you tried with my proposed (unfortunately not public yet) fix
to just combine ice_vsi_alloc_stat_arrays() and
ice_vsi_realloc_stat_arrays() into one function?

I will check yours too, but need to rebuild.

> KASAN detects the bug:
>   ==================================================================
>   BUG: KASAN: slab-out-of-bounds in ice_vsi_alloc_ring_stats+0x385/0x4a0 [ice]
>   Read of size 8 at addr ffff88810affea60 by task kworker/u131:7/221
> 
>   CPU: 24 UID: 0 PID: 221 Comm: kworker/u131:7 Not tainted 7.1.0-rc1+ #1 PREEMPT(lazy)
>   ...
>   Workqueue: ice ice_service_task [ice]
>   Call Trace:
>    <TASK>
>    ...
>    kasan_report+0xd7/0x120
>    ice_vsi_alloc_ring_stats+0x385/0x4a0 [ice]
>    ice_vsi_cfg_def+0x12e2/0x2060 [ice]
>    ice_vsi_cfg+0xb5/0x3c0 [ice]
>    ice_reset_vf+0x858/0xf80 [ice]
>    ice_vc_request_qs_msg+0x1da/0x290 [ice]
>    ice_vc_process_vf_msg+0xb15/0x1430 [ice]
>    __ice_clean_ctrlq+0x70d/0x9d0 [ice]
>    ice_service_task+0x840/0xf20 [ice]
>    process_one_work+0x690/0xff0
>    worker_thread+0x4d9/0xd20
>    kthread+0x322/0x410
>    ret_from_fork+0x332/0x660
>    ret_from_fork_asm+0x1a/0x30
>    </TASK>
> 
>   Allocated by task 2439:
>    kasan_save_stack+0x1c/0x40
>    kasan_save_track+0x10/0x30
>    __kasan_kmalloc+0x96/0xb0
>    __kmalloc_noprof+0x1d8/0x580
>    ice_vsi_cfg_def+0x115c/0x2060 [ice]
>    ice_vsi_cfg+0xb5/0x3c0 [ice]
>    ice_vsi_setup+0x180/0x320 [ice]
>    ice_start_vfs+0x1f3/0x590 [ice]
>    ice_ena_vfs+0x66d/0x798 [ice]
>    ice_sriov_configure.cold+0xe4/0x121 [ice]
>    sriov_numvfs_store+0x279/0x480
>    kernfs_fop_write_iter+0x331/0x4f0
>    vfs_write+0x4c4/0xe40
>    ksys_write+0x10c/0x240
>    do_syscall_64+0xd9/0x650
>    entry_SYSCALL_64_after_hwframe+0x76/0x7e
> 
>   The buggy address belongs to the object at ffff88810affea40
>                  which belongs to the cache kmalloc-32 of size 32
>   The buggy address is located 0 bytes to the right of
>                  allocated 32-byte region [ffff88810affea40, ffff88810affea60)
>   ...
>   ==================================================================
> 
> ice_vsi_rebuild() handles this correctly by calling
> ice_vsi_realloc_stat_arrays() before reconfiguration, but
> ice_vf_reconfig_vsi() was missing this call.
> 
> Fix by calling ice_vsi_realloc_stat_arrays() in ice_vf_reconfig_vsi()
> before ice_vsi_decfg(), mirroring the ice_vsi_rebuild() pattern. Set
> vsi->req_txq/req_rxq from vf->num_req_qs so the realloc function knows
> the target array size.
> 
> See the linked RHEL Jira item for a reproducer.
> 
> Fixes: 2a2cb4c6c181 ("ice: replace ice_vf_recreate_vsi() with ice_vf_reconfig_vsi()")
> Closes: https://redhat.atlassian.net/browse/RHEL-164321
> Signed-off-by: Michal Schmidt <mschmidt@redhat.com>
> Assisted-by: Claude:claude-opus-4-6 semcode
> ---
>   drivers/net/ethernet/intel/ice/ice_lib.c    | 2 +-
>   drivers/net/ethernet/intel/ice/ice_lib.h    | 1 +
>   drivers/net/ethernet/intel/ice/ice_vf_lib.c | 7 +++++++
>   3 files changed, 9 insertions(+), 1 deletion(-)
> 
> diff --git a/drivers/net/ethernet/intel/ice/ice_lib.c b/drivers/net/ethernet/intel/ice/ice_lib.c
> index 837b71b7b2b7..fc78176a2a8d 100644
> --- a/drivers/net/ethernet/intel/ice/ice_lib.c
> +++ b/drivers/net/ethernet/intel/ice/ice_lib.c
> @@ -3015,7 +3015,7 @@ ice_vsi_rebuild_set_coalesce(struct ice_vsi *vsi,
>    * ice_vsi_realloc_stat_arrays - Frees unused stat structures or alloc new ones
>    * @vsi: VSI pointer
>    */
> -static int
> +int
>   ice_vsi_realloc_stat_arrays(struct ice_vsi *vsi)
>   {
>   	u16 req_txq = vsi->req_txq ? vsi->req_txq : vsi->alloc_txq;
> diff --git a/drivers/net/ethernet/intel/ice/ice_lib.h b/drivers/net/ethernet/intel/ice/ice_lib.h
> index 49454d98dcfe..6f7da84384e5 100644
> --- a/drivers/net/ethernet/intel/ice/ice_lib.h
> +++ b/drivers/net/ethernet/intel/ice/ice_lib.h
> @@ -66,6 +66,7 @@ int ice_ena_vsi(struct ice_vsi *vsi, bool locked);
>   void ice_vsi_decfg(struct ice_vsi *vsi);
>   void ice_dis_vsi(struct ice_vsi *vsi, bool locked);
>   
> +int ice_vsi_realloc_stat_arrays(struct ice_vsi *vsi);
>   int ice_vsi_rebuild(struct ice_vsi *vsi, u32 vsi_flags);
>   int ice_vsi_cfg(struct ice_vsi *vsi);
>   struct ice_vsi *ice_vsi_alloc(struct ice_pf *pf);
> diff --git a/drivers/net/ethernet/intel/ice/ice_vf_lib.c b/drivers/net/ethernet/intel/ice/ice_vf_lib.c
> index 772f6b07340d..9edb2c14f553 100644
> --- a/drivers/net/ethernet/intel/ice/ice_vf_lib.c
> +++ b/drivers/net/ethernet/intel/ice/ice_vf_lib.c
> @@ -268,6 +268,13 @@ static int ice_vf_reconfig_vsi(struct ice_vf *vf)
>   
>   	vsi->flags = ICE_VSI_FLAG_NO_INIT;
>   
> +	vsi->req_txq = vf->num_req_qs;
> +	vsi->req_rxq = vf->num_req_qs;
> +
> +	err = ice_vsi_realloc_stat_arrays(vsi);
> +	if (err)
> +		return err;
> +
>   	ice_vsi_decfg(vsi);
>   	ice_fltr_remove_all(vsi);
>   


