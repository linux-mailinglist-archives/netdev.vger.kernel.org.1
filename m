Return-Path: <netdev+bounces-105658-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 467569122CA
	for <lists+netdev@lfdr.de>; Fri, 21 Jun 2024 12:48:56 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id B8E93281CF1
	for <lists+netdev@lfdr.de>; Fri, 21 Jun 2024 10:48:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CB18F16DEC9;
	Fri, 21 Jun 2024 10:48:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="kmEjiXER"
X-Original-To: netdev@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ECEB63207;
	Fri, 21 Jun 2024 10:48:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=192.198.163.19
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718966931; cv=fail; b=ahTaOF0iFe8mXDgFXQSHwj6lwasmpXmwaiGoVzDrw3pioaXtb5FqXi42d+/qJAIIV5ytBPkuWy6MN6wEItKV+deSiI59Z983LSWynmI7N7g1EJCq9dhz2MBe60rzuzPXPgSdWlv1bBil0W6Ld4OuQLTP/69BL/A8dhpBSQhueXY=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718966931; c=relaxed/simple;
	bh=JOMyG1/5Z+6B8LQ0Jl31UiVspSs8JV+BTH5YTStwVRI=;
	h=Message-ID:Date:Subject:To:CC:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=Hj/Oww+0WqnUKZlRxR4wXYUH9e5LlukCS0/3Ht+/6bzH2JzmzDhZkQuehVust9EJp9de9fci8OhMDE4BTZRkHdECzH7rnjBoCQ9yDsQ8Xa/6AQbWp44NBqzeqMbDOuShTiz6rQlFV+HB0AJm9iFaXZaMo7ribn3/hFWP5abvtPM=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=kmEjiXER; arc=fail smtp.client-ip=192.198.163.19
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1718966930; x=1750502930;
  h=message-id:date:subject:to:cc:references:from:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=JOMyG1/5Z+6B8LQ0Jl31UiVspSs8JV+BTH5YTStwVRI=;
  b=kmEjiXER0W6HgFRV1j1ux3Q/xTAE2mtIS1Ur/htLBYxQchJ6DSR6cuQb
   scMf6r6K1hFgZe8m4h6cQ9k57CAfpUSNAqETcX9dvrKmhsbQA0pDOidNw
   BJ4niVoqxuvVHSsKrUeugWTZ7PzlTLBV0ekwy/jFuTwiZRQsH5CB4NxJ0
   oLL36z1SyCBVMYjHv/a1jmqi/9rxfmYBDXiuGt4AzS+xzGbNPrAZ7xJw7
   6H+EjNTjQX4sxvj2as0ZesBKGbVRyJ/pfv2vJQv+UqrCMoCpIoTx51Vus
   IouQoRGA+ElhKEWWMWq0vpeu+coiucHe9QLa1W3MG1DRGWQaon4P+UxsM
   g==;
X-CSE-ConnectionGUID: YcxNOOqPSJ2D8+ydNUtOQw==
X-CSE-MsgGUID: 1I4yTLf6QFmTNtunr9JwUA==
X-IronPort-AV: E=McAfee;i="6700,10204,11109"; a="15751625"
X-IronPort-AV: E=Sophos;i="6.08,254,1712646000"; 
   d="scan'208";a="15751625"
Received: from orviesa002.jf.intel.com ([10.64.159.142])
  by fmvoesa113.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 21 Jun 2024 03:48:49 -0700
X-CSE-ConnectionGUID: XeoKRvH9RTGSQ2cfyp+SJQ==
X-CSE-MsgGUID: jOLVDVxiSFCiIM67w/P/qQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.08,254,1712646000"; 
   d="scan'208";a="73304260"
Received: from fmsmsx603.amr.corp.intel.com ([10.18.126.83])
  by orviesa002.jf.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 21 Jun 2024 03:48:49 -0700
Received: from fmsmsx603.amr.corp.intel.com (10.18.126.83) by
 fmsmsx603.amr.corp.intel.com (10.18.126.83) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39; Fri, 21 Jun 2024 03:48:48 -0700
Received: from fmsedg601.ED.cps.intel.com (10.1.192.135) by
 fmsmsx603.amr.corp.intel.com (10.18.126.83) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39 via Frontend Transport; Fri, 21 Jun 2024 03:48:48 -0700
Received: from NAM12-DM6-obe.outbound.protection.outlook.com (104.47.59.168)
 by edgegateway.intel.com (192.55.55.70) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.39; Fri, 21 Jun 2024 03:48:48 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=EOQUjdDH42I8sSZ0TQV3Sj4snFk5u8mD5oAbKNA6ZwHIZ04dOKhjS73xczVmNOnR1HhRsDE1bO0lQeDFFDjvbuc4bgRxTdv2q5JKFxxEs4FeWyiUFLlwGMWJOSUFou+qQQUiICoHQHKctRmJuwTtfZqwda8M7JQy0aYRMi86Cx+rWkABnHJnz6/UEVZG05pELmpR0OwwsbGoHZqqcX4p3lJUXBBEDdlKLsghx5a8RoWCeY0ZTzd04k2u4UM5iih81IWaurxE8Jy/rULG5mesFLBctVBBmqHRJ6NGjeDhNdP8k1s9lCV3W5uMGAX/YUPmA20RWUSlXSpn4u7m7hTU2A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=y6VGQZg6LALWDt4jVxsTnIY4Cn+abq39N8aHie9AhrM=;
 b=jmi8rpbVLSbuxYgXMhWhOc500rEoDTju68ZvdKe2KJD00+OALnNzu86osaKzjwI3hduCL0tl/fRCwMhiqV2/jedODqtc4OmnbWARxCcF5cDnU611YnjaxTdaR29GsaI+vd/bE8mviQ1l2AUlXyssBfck+mR7PdvbYGzBUlxPHFG9bShU9ZUWaULUfZ52LR6uqn7bShY07dCFPEK1e41qI/Aro2KCkU+ewyDXqiq0Pu4l/O5OfVg+AwNkq6gkr+cGLzozzvVS5URTTxAd8VViPTkA9Z+c393rYzlZoj/IJgipeIQqCLU8DC9BTIe+f2MK6sTlz8IyA2OXqmQSrozORQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from MW4PR11MB5776.namprd11.prod.outlook.com (2603:10b6:303:183::9)
 by DS0PR11MB7532.namprd11.prod.outlook.com (2603:10b6:8:147::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7698.23; Fri, 21 Jun
 2024 10:48:45 +0000
Received: from MW4PR11MB5776.namprd11.prod.outlook.com
 ([fe80::4bea:b8f6:b86f:6942]) by MW4PR11MB5776.namprd11.prod.outlook.com
 ([fe80::4bea:b8f6:b86f:6942%5]) with mapi id 15.20.7677.030; Fri, 21 Jun 2024
 10:48:45 +0000
Message-ID: <0ec0c543-8b5e-427f-856d-69a9623bb84b@intel.com>
Date: Fri, 21 Jun 2024 12:48:37 +0200
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net-next 1/3] net: dsa: qca8k: do not write port mask
 twice in bridge join/leave
To: Matthias Schiffer <mschiffer@universe-factory.net>, Andrew Lunn
	<andrew@lunn.ch>, Florian Fainelli <f.fainelli@gmail.com>, Vladimir Oltean
	<olteanv@gmail.com>
CC: "David S. Miller" <davem@davemloft.net>, Eric Dumazet
	<edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>, Paolo Abeni
	<pabeni@redhat.com>, Christian Marangi <ansuelsmth@gmail.com>,
	<netdev@vger.kernel.org>, <linux-kernel@vger.kernel.org>
References: <cover.1718899575.git.mschiffer@universe-factory.net>
 <9e5682c68a4930dae2e277b9cecc8b8ec97ba2af.1718899575.git.mschiffer@universe-factory.net>
Content-Language: en-US
From: Wojciech Drewek <wojciech.drewek@intel.com>
In-Reply-To: <9e5682c68a4930dae2e277b9cecc8b8ec97ba2af.1718899575.git.mschiffer@universe-factory.net>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: VI1PR09CA0152.eurprd09.prod.outlook.com
 (2603:10a6:803:12c::36) To MW4PR11MB5776.namprd11.prod.outlook.com
 (2603:10b6:303:183::9)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MW4PR11MB5776:EE_|DS0PR11MB7532:EE_
X-MS-Office365-Filtering-Correlation-Id: 8c2da392-a943-401d-a421-08dc91dfb981
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230037|1800799021|376011|7416011|366013;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?YnRQcFVyUEJxT3RncW9sVXpHNVVPbkw5ZzJCWTE1Nlo4eUNKOUhSNmlueU5X?=
 =?utf-8?B?Zm9jUnYvWnEyUWlOVDV4TDJROFZPSUZ5U0RzZUxrLzB3RXBHZmlSS292RFE3?=
 =?utf-8?B?YVV5OGkyeWc4TndwMlNPWlVsRkhuZE5xMzM3cXB3V3NrOUJDa0ZvNEsrSmhz?=
 =?utf-8?B?dmF0OXhvSTN2enpEYkx1ZTRZYmEzaUMyTVVrN2xNS01PdS93L085UmY2L2Q5?=
 =?utf-8?B?Si9uQjdqUWZhQkc0R3UraFZORXZVYW1kQlh0dG1iYzl4blduZUhqcDh4T1hs?=
 =?utf-8?B?eHd3Rk42OVIwNDcvWEtPOUI3Q0VkaGNpdlFpS2J3SnlJd0FtVFlneUxmQUJz?=
 =?utf-8?B?ellIMTVFWjBEYlpEb09lRVRETUpsVnF5QW9lc3dweldLZHNLYXllYjR3QmlM?=
 =?utf-8?B?ZElOdXJnbUdVMmZBVzZwL3NDSmt4aTFWVUoxMjZqYnNESFF5Rk5oc1Q5aGVS?=
 =?utf-8?B?UXFTZTFQSmJRbXhsUHc4OFlSaVdrVTNTT2pUZjZHcU5JVzZvOHVFOEM3d2FD?=
 =?utf-8?B?YmJKNGFhNHk4eWtJV3hhSXExeGZGM1JBUjBNWHBjRmJpdGY1U1laK0drMHNh?=
 =?utf-8?B?N3RNN2l0enhUQ1pGNStNbTM3cXJkUjdzRnIzZERQRWpVM2VmS0tudDlKcisv?=
 =?utf-8?B?cmdJdHZ6RlloNlE0ZEViRjl5RXY3dTBBUzl0K2E5aXJaWlhPMHVRc1RLL1ZH?=
 =?utf-8?B?ZU9DVThySE1WeUc2ZzkyS08xZVAzZmdYMWxaVmtYQ3Q0L0FKU0Z1RTRqdkh4?=
 =?utf-8?B?ZVNlSCs5M24wY3p4TmZYSENhaFErM1VUU0tseXBDZEF2VEhIT2d2SVM5ZEZ3?=
 =?utf-8?B?SVA0bExiQTZuQWJDWGNmOVdRRFF3dUhmMkt4ZnlhbEhvcXZwSkI0bEcrYk1N?=
 =?utf-8?B?d21CSXJmSTdEV1pLWGk3djdDeUp0bWVQZFEvVmlXSWdsWDlDcUFIRjdzSG1u?=
 =?utf-8?B?Z0lPQkZxUGgxWm5QNHVGRzFOcXlxZ2VXVnNLTlRvVFNpbjhwZHhwRTc0NnBi?=
 =?utf-8?B?cERQcTBVeXcvaUcrVVJpeSs3UTIva1Y4VDgxVjZwNVVVQjNZRmw5c0FGdUJK?=
 =?utf-8?B?QytDWUFtRlI3ODEyVUVTQ21Fb0NMMGJsRWY0STkzWFRVRjNwM2diem04TjlE?=
 =?utf-8?B?TjhvSmZTZ0ZHOEtHWlFVTE9zV0VBa3JqenZPQitINGJjeG1HcFdwUTc2ajJ0?=
 =?utf-8?B?cnh5WEx3T281RzVqL2dWOFc2MmVHdTd1Q21SMVl2VFlyOTNPZkFiVVozRlE2?=
 =?utf-8?B?YjRyOVVrMWN4WVZYNDFtRTBwT21zZHROSFQ0YVZSRElWc2VEcFk1WHZkM2FD?=
 =?utf-8?B?Y0Z3TGVOa1M3TTI2NXJBWFFwTEl1Umx0ckNjMmxRQThYUm80TTBqUWRGZ3c4?=
 =?utf-8?B?VmxXbm9TRzdTNXYxUnBQeXcxNDdXL3FLK3NOVzJMVVJHekpQR2hCU296aEdJ?=
 =?utf-8?B?WllwQUh1VzV5NCt1TlpMZjNmeml3bEdHTk1yQmtTaGpGbTNLUlVtQXpKRW85?=
 =?utf-8?B?U0lhQU5Nd0ludTlrRnFYTzFaaDg0TUdseFpDblZKc2Y2TytzeVZKRVVxNEIw?=
 =?utf-8?B?OVpYckxUMm5zc3RNc2tEczBCZ21CQXBsL0hYWHZRbGMrblZEenNEanlNTko5?=
 =?utf-8?B?NGRFWXNSNWpJOW14bVF0bHNvVGluU21qR1pkcE1VWXd1ckZrdGJzT0FaWUpu?=
 =?utf-8?B?Sm8rdE1XejcrSi9wQ2FweVIvQXVqdk9oZTQwMnZoa1pjYk9sU04waW1RMXhU?=
 =?utf-8?Q?FMSP5e9D6URiiGjR7zAdVZNvLFA70gjkM7sj9PF?=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MW4PR11MB5776.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230037)(1800799021)(376011)(7416011)(366013);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?OHljU0tVbnl0cXE3emJ6eVFDYXBkN3hLbDVGQkdEMDhJMzFjYVIxZmtBZWds?=
 =?utf-8?B?aUZMTFB3MUxpSzQ5d1oweDZXZndYZE1IWWxtdVlpbXJVc0ovQzM3UXR0VU1N?=
 =?utf-8?B?ZlpadTlDRUZlejZadWRMNk52eFpyVGVMMTBTZWlBZmdkd09qUVFVd0k5UXRs?=
 =?utf-8?B?ZGRCZHg4cnJVYVRHU2NkVHBCOGY0V3NpZkRZSlBsY1dUQ2ZSWWN4bGVZakdj?=
 =?utf-8?B?UnNzNVQzRXZ5RjlKV1lvTFVKK1hZLzVlTnBmREFzQ3hkK0N2MFFKcEJpLzRC?=
 =?utf-8?B?MGV3SVptYm1INDZzZGxhV0dXV1NWVnVhemJ2dEMvN2YwOER0Tkp3TEszWm9u?=
 =?utf-8?B?QlVtdFo0KzIwYTB2Q2VXNm4vZ3NwaVFXL2k1ZlVGN3FuTjBvcm1BcFJlZGJB?=
 =?utf-8?B?cityanE1cFlWRWFWeWlBM0p2TStxSHptYjRETEFxS0xuNXhDaFIyVWRLTWJh?=
 =?utf-8?B?cVljZ1hBVU1qd05jaUZXV1NFc1R2bGxWenk2UUxBUDQ3ZEZydUFVQzBmTzRk?=
 =?utf-8?B?aUNxa0QyTVZWRkpBdXdCVmU0UlpiSWR6TUd0V1VVOE1FeCtsSzBPVEhOSkhZ?=
 =?utf-8?B?RFRoU3dMQTducGpsRVQrcFU0Rk83bnY3RFlWRy84cFQweXFaM0EwYlVueldh?=
 =?utf-8?B?OWZWcXoyRXFZWGhwTGhIR3p0NWVwaHVqNy96TjFiNTBUTE1PS2ZvclE5cVdO?=
 =?utf-8?B?VnN2TXphekZNa0F4OTc5YjZ5aGsxalBTK2pPRDRzWlY5M1NKcDJ6QjA1cDVU?=
 =?utf-8?B?VkM5azNVckJGbFRIdVYxQzFKOGI0aS9aQXlHYjdpdzFFOEJSMCsvYTRzNnUz?=
 =?utf-8?B?b2E5dGEwL25CLzVxc25zaVBtY3Q0aUE4ZW1RRXNyY1ZmdE5WOWQ0bjJpSmFN?=
 =?utf-8?B?b3NPbzRqcUZjZ1RzdWZzczB6anlsQUUyOTlWbVBlNGZwMnlxUmVQMTBYV1E0?=
 =?utf-8?B?bEdMWG5PWUFsek9lS05oWTN0U3NvNHd4Ymkxdi9CdzRicDZ5SjRCMEpHQjNl?=
 =?utf-8?B?Z3NaYXJxYjRjMTNUOVU2WUpTWTBjdGNISUV6dWJJMnEwaS80dVJ6cnZrYnBD?=
 =?utf-8?B?cXg2UzhLSFo4Y2RQS0lpdDE0K2Q1Z0FmK3lZOXI2ZXVSUDVVdmZDWUFTejVz?=
 =?utf-8?B?cFh5ZWkxSlROc2xXa1pYWnh2Y1A1S1NzdnlaRHA3VkMxck1BR3Rha3hkZWRl?=
 =?utf-8?B?WXA3OFhWd1lIay8wLzZyNU9yNUNCeWRzN3dUQW5qVzliNXFvcy9zU3pNUGFK?=
 =?utf-8?B?TjVMR2xmNjIwMnNBRFpUY0VsWHFnc1Erc2RVRUNyZnN5c1FjOUluV3lST0VJ?=
 =?utf-8?B?U3JxTHJhRmdHcFhCdWlDblp2NktBbnhsUUpqY3dXc3FuSjltOEFFcEtrUVBD?=
 =?utf-8?B?Ykp5SzdiQzlLdE5UbjlsZmxUOWFDWC9OU2lvSHZXU1NmVExMRHhWMFZKd1o5?=
 =?utf-8?B?MjJJMkwyTldPTkh0V3p2ZTVGbzJPRW02cW1SZXVGaWtJYkNGSGxJUkZsY2x4?=
 =?utf-8?B?emZxUkJSQ1pUeVZCWWZmT1JkendsRFY0RVhlQmE2OEpScWdDZ2w1TzFiblgx?=
 =?utf-8?B?T0loWEU4cTA1bVU3RmtmQVdVN205RDJDUlU0UU91NVB2bm8reWNUZ1dMNXpR?=
 =?utf-8?B?NWI3OGVxanZFdUNNQ3pPNGlQd2NPRTVUcmlwTWZXSStpNFlHZUUzK2xwZVpp?=
 =?utf-8?B?MUJiNU9Pa0U0bTFIdXRKYlhkbC9hY0ZHb1JLNFZQK3h5MXh2MUVrTnpldzV5?=
 =?utf-8?B?d2tsVXRPUXBsT0ZyZzVPVnhlUEJGbGhBY0NKUWVzT2Z6QlhBTmRXenlTNjBL?=
 =?utf-8?B?eDl5eXlhWWhwOUp6Ym1xUWFQQlFQNk1SYnc5dHRhNCtod0k5NkdvdnRlaFhU?=
 =?utf-8?B?WlZmZVhmTDhrY3IzM2ZjM2p4azc5bVVjcy9VQUR6YWZmanU2enhHaHZnRkcz?=
 =?utf-8?B?am9UYm05dmg1eTdCT0k4cndTbzRPZTdTVEhKdjU1R0IwTmZsUlVnb0ovMU9Q?=
 =?utf-8?B?UXl1QlVQa3ViYkg3TmlncTVYL05SS2p4TSthRXArM0o5R0RlVWtDTy9LMmp5?=
 =?utf-8?B?MTVXNk5hVFcrUjZRMTZ1SHZydUwvdWJNV1VrRFJiVzE5cUdkNDBDcGVNZnlW?=
 =?utf-8?B?VU5zL29nYVNRY0xpQkdTTHRMbGg0OUhkNE11Z0MxWUpYbm9McTZITUZmbTR6?=
 =?utf-8?B?a3c9PQ==?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 8c2da392-a943-401d-a421-08dc91dfb981
X-MS-Exchange-CrossTenant-AuthSource: MW4PR11MB5776.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 21 Jun 2024 10:48:45.8383
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: JPoTBOxwevCjn2sC2uhyvQSzxnN/yRIgeiV/3xukXYvvtygMU2mb+U/nKT7+OzsOUfntFimrckfYNe/sohrywyYgivBi9/LVE+925KMZ0ko=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS0PR11MB7532
X-OriginatorOrg: intel.com



On 20.06.2024 19:25, Matthias Schiffer wrote:
> qca8k_port_bridge_join() set QCA8K_PORT_LOOKUP_CTRL() for i == port twice,
> once in the loop handling all other port's masks, and finally at the end
> with the accumulated port_mask.
> 
> The first time it would incorrectly set the port's own bit in the mask,
> only to correct the mistake a moment later. qca8k_port_bridge_leave() had
> the same issue, but here the regmap_clear_bits() was a no-op rather than
> setting an unintended value.
> 
> Remove the duplicate assignment by skipping the whole loop iteration for
> i == port. The unintended bit setting doesn't seem to have any negative
> effects (even when not reverted right away), so the change is submitted
> as a simple cleanup rather than a fix.
> 
> Signed-off-by: Matthias Schiffer <mschiffer@universe-factory.net>
> ---

Reviewed-by: Wojciech Drewek <wojciech.drewek@intel.com>

>  drivers/net/dsa/qca/qca8k-common.c | 7 +++++--
>  1 file changed, 5 insertions(+), 2 deletions(-)
> 
> diff --git a/drivers/net/dsa/qca/qca8k-common.c b/drivers/net/dsa/qca/qca8k-common.c
> index 7f80035c5441..b33df84070d3 100644
> --- a/drivers/net/dsa/qca/qca8k-common.c
> +++ b/drivers/net/dsa/qca/qca8k-common.c
> @@ -653,6 +653,8 @@ int qca8k_port_bridge_join(struct dsa_switch *ds, int port,
>  	port_mask = BIT(cpu_port);
>  
>  	for (i = 0; i < QCA8K_NUM_PORTS; i++) {
> +		if (i == port)
> +			continue;
>  		if (dsa_is_cpu_port(ds, i))
>  			continue;
>  		if (!dsa_port_offloads_bridge(dsa_to_port(ds, i), &bridge))
> @@ -665,8 +667,7 @@ int qca8k_port_bridge_join(struct dsa_switch *ds, int port,
>  				      BIT(port));
>  		if (ret)
>  			return ret;
> -		if (i != port)
> -			port_mask |= BIT(i);
> +		port_mask |= BIT(i);
>  	}
>  
>  	/* Add all other ports to this ports portvlan mask */
> @@ -685,6 +686,8 @@ void qca8k_port_bridge_leave(struct dsa_switch *ds, int port,
>  	cpu_port = dsa_to_port(ds, port)->cpu_dp->index;
>  
>  	for (i = 0; i < QCA8K_NUM_PORTS; i++) {
> +		if (i == port)
> +			continue;
>  		if (dsa_is_cpu_port(ds, i))
>  			continue;
>  		if (!dsa_port_offloads_bridge(dsa_to_port(ds, i), &bridge))

