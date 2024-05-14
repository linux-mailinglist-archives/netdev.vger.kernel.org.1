Return-Path: <netdev+bounces-96331-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 2DB548C521E
	for <lists+netdev@lfdr.de>; Tue, 14 May 2024 13:34:46 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 51DEB1C2172F
	for <lists+netdev@lfdr.de>; Tue, 14 May 2024 11:34:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 47C2E12BF27;
	Tue, 14 May 2024 11:18:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="JTtjmcDm"
X-Original-To: netdev@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.13])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8112B56B79
	for <netdev@vger.kernel.org>; Tue, 14 May 2024 11:18:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=198.175.65.13
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715685526; cv=fail; b=asdr805yqyh8j+uKasPEW4IDJL34lcbFZpgDk5LhdHQ/WNRQbvJ/LXHoB2w9Hj7rXhhytoUbHVb0rJRkLjYrIqN+jJWnbdN8xPTPDd9io9KQl+dh7Drt2VrEUYTtGT71p7IZhrdOAT1kPaEFgIsN9ZZCk9/H323wPj54DnHwYgI=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715685526; c=relaxed/simple;
	bh=sqlwxzWOiu9vQKkUpAOT9vtnMbbmBpHRruRg62+RCSI=;
	h=Message-ID:Date:Subject:To:CC:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=aZMbbCR2pb2OZ8/7Z/T6Qqdw0JuZ9AQU3nVXteaN96SaczEyPOI3b/rGeWuim+V4wQ3sEYduKsws/izBptfwKXkUmronqIhfmrN6133p9zRnCKSsy1ioeudAYumCZ8DIzzdHIFnQYI/fFnzPqFGgrBisuDnHtApH/6LOAHHItgg=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=JTtjmcDm; arc=fail smtp.client-ip=198.175.65.13
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1715685524; x=1747221524;
  h=message-id:date:subject:to:cc:references:from:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=sqlwxzWOiu9vQKkUpAOT9vtnMbbmBpHRruRg62+RCSI=;
  b=JTtjmcDme8N4FEGDZsqoBXuBUG/JfRWAIeVlfdlZ7tMFqKUMxlYHxfQN
   qs+nzQovA0AZfOZKuaXilbDyhkvu4nDcrkn9HQfJD1m1Jbf60FQNYOx8n
   67DyVdm8tYIhsZEStU3FFMh89sJx04Zwdd7avW+8Tp7rshQwHlIXcFCyi
   +3jXkfL6Q+MtYJpDZtWPRN/egoXRmM/D9obvkHVwCX+QyrJL8uwCkcRxf
   HR3rIOZyVnF/mJu/R68hNL4GA3WBpTDRXJJF4E/JA0oCAvwPG+RQvLwv7
   Y6ObPgsmnaCjODVMAaa9tfd/l5Dg2wcJ9912dOANQlM0VDvobkwywW1XV
   g==;
X-CSE-ConnectionGUID: H6oCpv7yQmKa0Xj4zA+wrQ==
X-CSE-MsgGUID: iGesSaAeQxSQy2kcp3j3Uw==
X-IronPort-AV: E=McAfee;i="6600,9927,11072"; a="22807319"
X-IronPort-AV: E=Sophos;i="6.08,159,1712646000"; 
   d="scan'208";a="22807319"
Received: from orviesa001.jf.intel.com ([10.64.159.141])
  by orvoesa105.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 14 May 2024 04:18:44 -0700
X-CSE-ConnectionGUID: bZhSxNnlSuigJj3TfzzoxQ==
X-CSE-MsgGUID: a7HcMrVnSnycuKrTrplW4g==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.08,159,1712646000"; 
   d="scan'208";a="68120969"
Received: from fmsmsx603.amr.corp.intel.com ([10.18.126.83])
  by orviesa001.jf.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 14 May 2024 04:18:43 -0700
Received: from fmsmsx612.amr.corp.intel.com (10.18.126.92) by
 fmsmsx603.amr.corp.intel.com (10.18.126.83) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35; Tue, 14 May 2024 04:18:43 -0700
Received: from fmsmsx610.amr.corp.intel.com (10.18.126.90) by
 fmsmsx612.amr.corp.intel.com (10.18.126.92) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35; Tue, 14 May 2024 04:18:42 -0700
Received: from fmsedg602.ED.cps.intel.com (10.1.192.136) by
 fmsmsx610.amr.corp.intel.com (10.18.126.90) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35 via Frontend Transport; Tue, 14 May 2024 04:18:42 -0700
Received: from NAM11-BN8-obe.outbound.protection.outlook.com (104.47.58.173)
 by edgegateway.intel.com (192.55.55.71) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.35; Tue, 14 May 2024 04:18:41 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Ll8eGkNJR3tTv1ykxi8zPtjsYfXug5aCpn/HHE4Gy3lhH7xNkSh7kvIZoKbTP0fyszlqa9Zf0EjbNkDSvSyFROM5s9zU/Lrhw44UalpNpKNOfdYQml+A9F8WOyAieEFrxe57GeIp+7CMglcqYHLpJJ04xpQal7K2uZo1JVUudCepMjr5Fu4fZBzEVqc3el4t8uin0cNJ7zWMBHrnCHddzz7qIVflKEOHoJW+lO6DcOPrkNgp31F2AsovI2R2NFb0ktxCu6YtgQKzwxMbJa8QzsQN1gRg0BTJVfIfNmqtAC4sRdoHrUcN08grJnqczcGf4kjZK77344dxt4C0n+EJCg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=v8Gyo9ZPwQ3kyrrs8AGDeF/yz+myUiDo04uUAUjx4VY=;
 b=kVUMEb3Tp5l9g8NkCRsppLBIPQOcWMUJJ30estI9MBCy1I0lCfBLbi5KGvFh3G1JlcsVL0Ho1OMMnldMQtBajYnQTE37Zjx7rQPtHLaYxGTCZaewE901sfLt3FvZKLDNXwVbs/A8nNfArmJ9lzvmYHzRNfMR8cb8is+Y3bxxdxVzYUv/ufahPy2bnnsiJw+vScDi+ZO1s56fpeXr2a065mncdIw/4t4YLXwq4s85rWKdb8ex2QslF64q+hAkHL6pMo2LBVMrH5paTtIKw/Vibx5tmFkXQ0VDbZyLAgYuIWxrSS439KkOr1JEZ/brtnmzQgkWT0QhHjw/nM2u3AMABQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from DS0PR11MB8718.namprd11.prod.outlook.com (2603:10b6:8:1b9::20)
 by PH7PR11MB8249.namprd11.prod.outlook.com (2603:10b6:510:1a7::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7544.55; Tue, 14 May
 2024 11:18:39 +0000
Received: from DS0PR11MB8718.namprd11.prod.outlook.com
 ([fe80::4b3b:9dbe:f68c:d808]) by DS0PR11MB8718.namprd11.prod.outlook.com
 ([fe80::4b3b:9dbe:f68c:d808%4]) with mapi id 15.20.7544.052; Tue, 14 May 2024
 11:18:39 +0000
Message-ID: <e7e6cbde-8f66-454b-b417-64581cc3896c@intel.com>
Date: Tue, 14 May 2024 13:17:27 +0200
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net 2/2] r8169: disable interrupts also for GRO-scheduled
 NAPI
To: Eric Dumazet <edumazet@google.com>
CC: Heiner Kallweit <hkallweit1@gmail.com>, Paolo Abeni <pabeni@redhat.com>,
	Jakub Kicinski <kuba@kernel.org>, David Miller <davem@davemloft.net>, Realtek
 linux nic maintainers <nic_swsd@realtek.com>, "netdev@vger.kernel.org"
	<netdev@vger.kernel.org>, Ken Milmore <ken.milmore@gmail.com>
References: <6d4a0450-9be1-4d91-ba18-5e9bd750fa40@gmail.com>
 <ef333a8c-1bb2-49a7-b721-68b28df19b0e@gmail.com>
 <CANn89iLgj0ph5gRWOA2M2J8N_4hQd3Ndm73gATR8WODXaOM_LA@mail.gmail.com>
 <e8f548f8-6d16-4a30-9408-80e4212afe9c@intel.com>
 <CANn89i+yKgXGHUyJxVLYTAMKj7wpoV+8X7UR8cWh75yxVLSA6Q@mail.gmail.com>
From: Alexander Lobakin <aleksander.lobakin@intel.com>
Content-Language: en-US
In-Reply-To: <CANn89i+yKgXGHUyJxVLYTAMKj7wpoV+8X7UR8cWh75yxVLSA6Q@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: MI0P293CA0013.ITAP293.PROD.OUTLOOK.COM
 (2603:10a6:290:44::18) To DS0PR11MB8718.namprd11.prod.outlook.com
 (2603:10b6:8:1b9::20)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS0PR11MB8718:EE_|PH7PR11MB8249:EE_
X-MS-Office365-Filtering-Correlation-Id: 872d46f8-a380-4e00-db8c-08dc74079ad2
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230031|366007|1800799015|376005;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?TXI4VGNOa1lpL3JHWjBuTWlKcUNlV2kwSnMxWiszTUJ4emRHeUpsdHlzOWNM?=
 =?utf-8?B?RWxpRGk1TW9GSVJmN2FoTmV0cUsrTVZWeGNmOWRzNUdCZ1M2QjYzQ1VUcS9E?=
 =?utf-8?B?RlJkUllkMnZCc1YwaUZlaEVpbmVLelFGOGZjdlpVVTVZQ0JyMlI0WDNhQ1J6?=
 =?utf-8?B?V3B2TDV4UC95VHkxMjQ2N2tFMG8vanl2MXd1Ulk1M1dKV01QMWI2NVJ3TnFQ?=
 =?utf-8?B?RUJQN3JHMGQ1OCtQYVdhUFRXWjJDK2R3K3NqZGNQc21SNTNXWmVuZkNoNzlW?=
 =?utf-8?B?dGhNdDV2eU1JQlNHQ1B3T1Z2NWtSamNHdzNnOW1RTGltb1UwSEltNjdJR0lW?=
 =?utf-8?B?bnBCNThzWGswQitkNVFUTldFK1RQNXFNU2xvcTN1VFZKRU5JK1pCc2IzQkU3?=
 =?utf-8?B?aldybjVxdUlicVE0Wk9uOXhNWGZYdWJXdGUwVzdza2pSbnpuYW9WdzJPQ3hO?=
 =?utf-8?B?WG9rSzVkSUkydkwrWEE4cEwvN1JYc1BJM1V6bDBCZ3NCL3Y0bzg0djRsZ0FQ?=
 =?utf-8?B?QlVlQ0FyRTBwUkx1Z1YxekREU3ozL3RDSkhycHhtMU05Y3RFRHdlQU8vOFhn?=
 =?utf-8?B?ZzQ4eG5xSXIvbWVHMkUzUmIwd3dxYnhZM2M3VWgvTzl1dDViL2dCbFkvbHE1?=
 =?utf-8?B?NVZ2UDArL3VrYy9kbjZJeExHamlOV29kVE40SWR1Q0tVcTJaaituOEVncVBD?=
 =?utf-8?B?ZlpCaWRIdWlJZXZEZnVuUG9ZTTczeDBNNERiYVh6aHA5VWlLdE1rTWxGbzVD?=
 =?utf-8?B?RWZqUEJpSkN1ZU1BWjN0S3M1R3l1am9odHFGczJXV09IaEMwZUJ3MkxQSHZx?=
 =?utf-8?B?TXhtaGRhV09VRWVDY1FSTTlFWC9lcyt1bE5ZaSthU29odHRVZVB3MlpKaVFB?=
 =?utf-8?B?UzJxdFlMMmNEREJoR2hzUGRVa0c3RHRlRVJvUC9zRTE4eHlsWStuVmZxWUky?=
 =?utf-8?B?S2FQc3hpVHRRL2w4R2ljV0ZxaVVEVGl2RmloVHNBWWZlRmZScStXd2tiZkZV?=
 =?utf-8?B?OVVlZzNQZkpNbGlhQVpVam1CNW43ankzalFUYnNwRk9kMEtiWmNjNVBFbFlh?=
 =?utf-8?B?TXJaSGRiMnJwdEJiTzQwUDQyQXdXZktES2ZKZklrR1pWaWhoZlhwdHdseEox?=
 =?utf-8?B?cjV4bkVJL1ljNkYzeGlpQWp3UjVkYzBSck1MZ1ExeU9aYzRpWlRPOUlxY1pH?=
 =?utf-8?B?WHUrMEZQUGJDcVFRT3NTeFVKNVlMMlJXZTI5V3BjajJRRWI5aC9XRm1iT2RF?=
 =?utf-8?B?dGc1UGZvVVZReUxFeWZtMGR4TnN1UWNnaEdONUs4WU1sQVF2bSt2UVU1Qk9C?=
 =?utf-8?B?R29tWHpOYjdDWkRZSHVnQm52Y0RtdVpyZ2pjMEIwNTZuU0NIekdJYlAxWm5a?=
 =?utf-8?B?NEVSZjZIUUhmeHUvUUhYeU9TdjA4dFJyRkRMYmhlaU5XeUZSUjBlaXFoVTVJ?=
 =?utf-8?B?dGEranErc2dJamFwU25QcjZzOXRwV3VTMHI2b1IvVW15elBnbWg3OE1uRFRa?=
 =?utf-8?B?SjA0SHVERE5QUjdvQlJEeGJxSmxuUHVCYUdMVmVnWjR4aTU1d0tGTXQ1SHpj?=
 =?utf-8?B?VUNpT29EQWp0V2Vub1Jpam5yL2VQRXhqS2JvejFYQmp0UEM5bjBvdmprTXdL?=
 =?utf-8?B?Q0lOcGtrU1lzS2p1RlQxcHNMWUdCQ3Z2Yk92ZnFZUVd5b012ZUE1RndMVSto?=
 =?utf-8?B?NXJwaFJlUXFMM0dCUTJUM1owTTI0MTJvSk9paDRrTHNaYkVKOWswTGtRPT0=?=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DS0PR11MB8718.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(366007)(1800799015)(376005);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?K2FZeXlBN1F0cFhoSmNtSk5JWTdvUWFSUDN6ZC9HUzBSUmNmeXB2SndhdzNM?=
 =?utf-8?B?bWNqYWppaWZsWEgrcG9SWXlDSWFnQkRWcXdNZzgzY2o1eUtOeGkrOHpRVjUw?=
 =?utf-8?B?K2UrQjhiZUx1Q0NkYkhwYWVzREE3dVRkRVVkdStkTXlCQWQwcko5amxORHV0?=
 =?utf-8?B?MDlySnAwN0lIR0E0K1R3WWZwazJMWDhjNVB0ZG50UmhlUlBYZWVwdmJoWCtD?=
 =?utf-8?B?WFpPWkFpNWEvQjh1d2lEMk8vSnNmSXpyU09JYVp2MGozSzcwZWdoQUJ1ZDJY?=
 =?utf-8?B?bXIvNFJ5Q3c3NU8vSE5SMUFZWWVVcG81bGtVMjkrQW9nSDFwU3dyei9rRWxw?=
 =?utf-8?B?NHU1OHVIVk1BdWMxY05VSUNaWkw0Q05CVERKM1VNT0RhZHZXWHdnRVNIcXZw?=
 =?utf-8?B?QmRWNENtbXhTZlJSRW9tMldvbms4aVhpZzA3c05xT05HUFp6azhPWVVEUTJl?=
 =?utf-8?B?cEJyL29NSlJGeElPTFptcVJ0SFVKTU9RSklYaDhrRnpjWjNaeThBZW8xQUZx?=
 =?utf-8?B?U3duZUc3d3A3MmJ4dGlKQ0lwNWVFQ04wRzU5d0hKT2tVcUcvbkN4WTJhWGdR?=
 =?utf-8?B?Z21lQWdSaCthWnI5S3dMREpYL0tiWlhSN2k4L01zT0NFMVk5UzNFL2t0R2JY?=
 =?utf-8?B?MlMreVdkaSt6Zmw4MzBXd2x6YU5Cc2ZadE1DWHFmU3h5NUtjSnZPMnRLOVBy?=
 =?utf-8?B?c2NSZkEwbTgrWStJUFN4b0NJR0FSMGMvaVQzNnlvbFZPdmR6QzBTZGFsT2xL?=
 =?utf-8?B?WWZlcloxQ3ArSlQ5UmNxUXp4Wk9XVUw2Z2RoeUdvQkttbmhpWW81ZUhTT0Rw?=
 =?utf-8?B?WWdxZ2RFVSttWFJ4RmpTa0RueXpoWWk2UUMzNWJhMTJFTUJLeHl0RDhxS1Nx?=
 =?utf-8?B?cUEydEc3a3lSUzhqbnU5ckZqbThVQVlsOWtJbnk4Vi9pVWJ1NFo2blByT1ZI?=
 =?utf-8?B?QjB6elZGR3dBdmNsREp6M2Y5Z0FlT2w2K2ZWMlhlUU1UVVllOXMvU1hiN3NC?=
 =?utf-8?B?cG5QbWZ1aitEUWRLS0JEQTlBQ3RnS3lIS3lqOXFKS0NtQXFoSHlMdSt1ZUJS?=
 =?utf-8?B?WXplVEV5eDdSMjQ5R01FVkt3Y1BBaHlSZ3BhOVpHWWdiNm00aTJWMXVPdVZz?=
 =?utf-8?B?S0I3Q28wVXc1VlI5REF1TlhZM0JVRW9xbHRBWFFxYTlaWWxqUmhWK1RpMlZj?=
 =?utf-8?B?WmZqV2FScFduUnZURkh6UmJSR1VFeGZubUpHSGRSaXhDMVpMR3ZkWlN5RkFM?=
 =?utf-8?B?U2s2c1NZZTF3dE5IMXlPNFMwWGxsdXZIcGoxK3dERTlXRStjYUdGSE5Sd1BH?=
 =?utf-8?B?dWpJOWRCQ0JTek5JWitGYStiazRWT01rRHN5OFdzcEhCaVZJREQ4NXQvWjA5?=
 =?utf-8?B?dU9QVkVTZjVIZXl1SmMvSkw3a2xhZmRpcVNnWHFZNnRETXd5L29iVk5qS0pz?=
 =?utf-8?B?SWU2eDN5aEZFS3pGTko2K0xaM2JuRGxYTXNpcHJOLzNtYmpMZTd4Q09DbU5I?=
 =?utf-8?B?RWYzZ3dMS0QzWU1wMVQvWkdud3dJTTFZTlk5b2l3M0RFOWwyY2JhMC9oT3Q1?=
 =?utf-8?B?UW53bFpIMUxKcWpFSGFQOUVIbGE2bGxJaUhKWlhoNFBhTkEvWU5ncFh5OU9m?=
 =?utf-8?B?aHQ3RHkyMis4ZldnMUsyWTdXQVZ4VGd6Q3M3azQ4NWUySXZCRUFYazN4ZDFr?=
 =?utf-8?B?R1ZrWStXQ1o2dElPMHp3WFdjN0crZC83WXFnUmQyYm5XdWZ5NFNTWStLM1Ix?=
 =?utf-8?B?MHZ4bWxUa2VYZGJKS3RVZTRxYitpNU04VzFob3BNTThFOHk3SW1lRWw1bzRM?=
 =?utf-8?B?bkpUSGhtRXA3SzJZeDhEZHhHOXBNSm8yY0JKVW1QamVqN2h4ODJoKytHVDRp?=
 =?utf-8?B?TzZOZlFPWmhkZUdlbVVjTTlQQUp6QzdrS1owTC9TcStKSzZnSGJ4LzRuOE1B?=
 =?utf-8?B?aEVhNUpXV1lGNTQvWDloWllkazVHNWd5WW5yRmgxOGJwbkxHS0NMSGh0c2dT?=
 =?utf-8?B?RlpCMHMzSzQvZnBQREtWTTZiRmgvZUt3NGVmRjl2cWtnZjZJQmkwV29LQkVp?=
 =?utf-8?B?aWRwWHdyM0I2LytkZFRvMFJSYS95S1dBSUVnOTZiczFOYmx1Z24valp0TEVH?=
 =?utf-8?B?Y1Z4MmY2ektjVi9Ob0p0TDBsbVVNY0g0OU56dzBOeXBoelk0cHI4SjBBWTk2?=
 =?utf-8?B?bXc9PQ==?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 872d46f8-a380-4e00-db8c-08dc74079ad2
X-MS-Exchange-CrossTenant-AuthSource: DS0PR11MB8718.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 14 May 2024 11:18:39.1878
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: lhLndOPCSy3vBvLfJv0hMGVonhw6+8G1ZRhbHePiFDUtxKq2SnDtRw5ofhxDV2gwkrdsTHApvPcBMu7PhIkRXA9EGyDcChXr8OAgBZx/hGE=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR11MB8249
X-OriginatorOrg: intel.com

From: Eric Dumazet <edumazet@google.com>
Date: Tue, 14 May 2024 13:05:55 +0200

> On Tue, May 14, 2024 at 12:53 PM Alexander Lobakin
> <aleksander.lobakin@intel.com> wrote:
>>
>> From: Eric Dumazet <edumazet@google.com>
>> Date: Tue, 14 May 2024 11:45:05 +0200
>>
>>> On Tue, May 14, 2024 at 8:52 AM Heiner Kallweit <hkallweit1@gmail.com> wrote:
>>>>
>>>> Ken reported that RTL8125b can lock up if gro_flush_timeout has the
>>>> default value of 20000 and napi_defer_hard_irqs is set to 0.
>>>> In this scenario device interrupts aren't disabled, what seems to
>>>> trigger some silicon bug under heavy load. I was able to reproduce this
>>>> behavior on RTL8168h.
>>>> Disabling device interrupts if NAPI is scheduled from a place other than
>>>> the driver's interrupt handler is a necessity in r8169, for other
>>>> drivers it may still be a performance optimization.
>>>>
>>>> Fixes: 7274c4147afb ("r8169: don't try to disable interrupts if NAPI is scheduled already")
>>>> Reported-by: Ken Milmore <ken.milmore@gmail.com>
>>>> Signed-off-by: Heiner Kallweit <hkallweit1@gmail.com>
>>>> ---
>>>>  drivers/net/ethernet/realtek/r8169_main.c | 6 ++++--
>>>>  1 file changed, 4 insertions(+), 2 deletions(-)
>>>>
>>>> diff --git a/drivers/net/ethernet/realtek/r8169_main.c b/drivers/net/ethernet/realtek/r8169_main.c
>>>> index e5ea827a2..01f0ca53d 100644
>>>> --- a/drivers/net/ethernet/realtek/r8169_main.c
>>>> +++ b/drivers/net/ethernet/realtek/r8169_main.c
>>>> @@ -4639,6 +4639,7 @@ static irqreturn_t rtl8169_interrupt(int irq, void *dev_instance)
>>>>  {
>>>>         struct rtl8169_private *tp = dev_instance;
>>>>         u32 status = rtl_get_events(tp);
>>>> +       int ret;
>>>>
>>>>         if ((status & 0xffff) == 0xffff || !(status & tp->irq_mask))
>>>>                 return IRQ_NONE;
>>>> @@ -4657,10 +4658,11 @@ static irqreturn_t rtl8169_interrupt(int irq, void *dev_instance)
>>>>                 rtl_schedule_task(tp, RTL_FLAG_TASK_RESET_PENDING);
>>>>         }
>>>>
>>>> -       if (napi_schedule_prep(&tp->napi)) {
>>>> +       ret = __napi_schedule_prep(&tp->napi);
>>>> +       if (ret >= 0)
>>>>                 rtl_irq_disable(tp);
>>>> +       if (ret > 0)
>>>>                 __napi_schedule(&tp->napi);
>>>> -       }
>>>>  out:
>>>>         rtl_ack_events(tp, status);
>>>>
>>>
>>> I do not understand this patch.
>>>
>>> __napi_schedule_prep() would only return -1 if NAPIF_STATE_DISABLE was set,
>>> but this should not happen under normal operations ?
>>
>> Without this patch, napi_schedule_prep() returns false if it's either
>> scheduled already OR it's disabled. Drivers disable interrupts only if
>> it returns true, which means they don't do that if it's already scheduled.
>> With this patch, __napi_schedule_prep() returns -1 if it's disabled and
>> 0 if it was already scheduled. Which means we can disable interrupts
>> when the result is >= 0, i.e. regardless if it was scheduled before the
>> call or within the call.
>>
>> IIUC, this addresses such situations:
>>
>> napi_schedule()         // we disabled interrupts
>> napi_poll()             // we polled < budget frames
>> napi_complete_done()    // reenable the interrupts, no repoll
>>   hrtimer_start()       // GRO flush is queued
>>     napi_schedule()
>>       napi_poll()       // GRO flush, BUT interrupts are enabled
>>
>> On r8169, this seems to cause issues. On other drivers, it seems to be
>> okay, but with this new helper, you can save some cycles.
>>
>> Reviewed-by: Alexander Lobakin <aleksander.lobakin@intel.com>
> 
> Rephrasing the changelog is not really helping.
> 
> Consider myself as a network maintainer, not as a casual patch reviewer.

And?

> 
> "This seems to cause issues" is rather weak.

It has "Reported-by", so it really causes issues.

> 
> I would simply revert the faulty commit, because the interrupts are
> going to be disabled no matter what.
> 
> Old logic was very simple and rock solid. A revert is a clear stable candidate.
> 
> rtl_irq_disable(tp);
> napi_schedule(&tp->napi);
> 
> If this is still broken, we might have similar issues in old/legacy drivers.

I might agree that we could just revert the mentioned commit for stable,
but for the next net-next, avoid unnecessary
scheduling/enabling/disabling interrupts makes sense, not only for
"old/legacy" drivers.
"Very simple and rock solid" is not an argument for avoiding improvements.

Thanks,
Olek

