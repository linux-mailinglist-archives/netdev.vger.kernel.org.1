Return-Path: <netdev+bounces-181594-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 0281BA85989
	for <lists+netdev@lfdr.de>; Fri, 11 Apr 2025 12:23:28 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id CB6E3189FC3E
	for <lists+netdev@lfdr.de>; Fri, 11 Apr 2025 10:22:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A19192BD5B5;
	Fri, 11 Apr 2025 10:18:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="iXsvXbFP"
X-Original-To: netdev@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.11])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F2E9B2BD5AF;
	Fri, 11 Apr 2025 10:18:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=198.175.65.11
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744366706; cv=fail; b=tws35hWmScGjd8wlhrQ8Yr5qtuIEIKUu4H7tUX27vkakGMQ2fG79ZHyWxbxrZUC9SWWPK92uCcxG4CBP1xcJznpAiTuJOlGFGNsn6EXoNAw03cugVxH0g7zghG++OtOHxqysFnvq3LzTffOvu6LXQxSLQHPHmpHzHXwAw8/ZE4Y=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744366706; c=relaxed/simple;
	bh=BnMXYXQV4PC/MlXgR5vgKzj+R+m0ng4+4XrWrx23pGE=;
	h=Date:From:To:CC:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=LoKaKGYASv7gWQfj7pCmX5l0jesS+SmnQiq+cBIxP+v84EZo/kDk/Qp9n5C4CA9Vh+rLcGArqEedFC7qDNcSnkix3dKThwY1RqezuWEJ5cMBImSe0HoJOXfpY+6Vm544zrGtNTRQsaktPUai4BmxbEFIFMuwtp3ls8PMMVKtcdY=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=iXsvXbFP; arc=fail smtp.client-ip=198.175.65.11
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1744366704; x=1775902704;
  h=date:from:to:cc:subject:message-id:references:
   in-reply-to:mime-version;
  bh=BnMXYXQV4PC/MlXgR5vgKzj+R+m0ng4+4XrWrx23pGE=;
  b=iXsvXbFPFZo0VTfNlbUxcgcdH9NwE99X0fWgKdTc1AAiqASJ50llZgdK
   8zr3qttkmTi3vVtoQ++W0BDEE778SWMlsxf1kRb/1a8AwcyZ8igmKi8He
   9SLX1CKsvNKwkPNg99DINDYHUisaGFr7+OW3vt9kPJkV+253++gcF0Y9w
   OpY7onK50Fdj+GOdyzWmYbftssdekPj0jI3Uw/dI/0QsBwEA+Nd3Nf1Qa
   q8gsiMMqow5jJjjfFbGxm5bZWDMQadSe1Bqll0RWTIQogpd6Tw7pJ/sYp
   RowkP1hudFn95BQB/DzY7ngeYyQ07BMk8uQNNKqtlW2DEqCckpfy+qVpv
   Q==;
X-CSE-ConnectionGUID: tKgfMsjUQOKSD1YP9X48qA==
X-CSE-MsgGUID: a+bkLuVvRFqelpWtwVIaCA==
X-IronPort-AV: E=McAfee;i="6700,10204,11400"; a="56097975"
X-IronPort-AV: E=Sophos;i="6.15,203,1739865600"; 
   d="scan'208";a="56097975"
Received: from orviesa003.jf.intel.com ([10.64.159.143])
  by orvoesa103.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 11 Apr 2025 03:18:23 -0700
X-CSE-ConnectionGUID: CBYbNpq3QjONTCQ59PQTYg==
X-CSE-MsgGUID: Agb/OAxvR1S+Y54V6ZCDBg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.15,203,1739865600"; 
   d="scan'208";a="134019810"
Received: from orsmsx903.amr.corp.intel.com ([10.22.229.25])
  by orviesa003.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 11 Apr 2025 03:18:24 -0700
Received: from ORSMSX901.amr.corp.intel.com (10.22.229.23) by
 ORSMSX903.amr.corp.intel.com (10.22.229.25) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.14; Fri, 11 Apr 2025 03:18:22 -0700
Received: from orsedg603.ED.cps.intel.com (10.7.248.4) by
 ORSMSX901.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.14 via Frontend Transport; Fri, 11 Apr 2025 03:18:22 -0700
Received: from NAM04-BN8-obe.outbound.protection.outlook.com (104.47.74.40) by
 edgegateway.intel.com (134.134.137.100) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.44; Fri, 11 Apr 2025 03:18:22 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=jmNT4K1klTJ2s2xAXE5QZ0idZI+4dNDpI5RnP5hbDg4b6/DLU9BX0bsZIKvLU9Fft0Wv7OjVsA0Z5WcF3XL9VLmW1ByAKpc03ug+aA3NY+VcXveYv+DKidtjg3UxeWad9/lNYsYNKgo2YTbJ43e/M5LmI+qSt8W4rQafw3A0XFzP0I96KJjoa7TbFssquFi8AyrMy6xuUcrdgtvOGguwTtkeylrUxEAWUrmCm5szBdA0nBkXLq9EE7ttgF41LkVsu79sCg2lq1D2QPlXqw7VhNAyDjRaqIIGwtr3PZS7m6hJGw/p8YFN7mO3uYDCep461ENsWLbP4GbMl/wf7WEQRA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=HxqBP7IBNDAjzU7Q08PQTXph1wP6dR0rZ6e0N4PMJMg=;
 b=IiQqyfm6FFpuxxw4+sSjjFUnlpmiQXB78D05cb3VexzdB6HomMM+Ou93SwpvUUBhyeDx5EChrQAn2h/wJoXAQtnGKFUbWZmw8NBIOUidfgq2S/w0etRMV5r9O4b7myT3VzrtqX+dZyMDqY0fnnHvjp8LB2rCRsEFUmKNdFlEARSYPMAjfIWBmbeKNgP2o3MPcffEdbRKdP+2tybaX4Xg1in19otwY13tASUAvML7F3721r+pJ9z2KTREkb14vmkqMVPLpIirJ2ogj+Ih4J9tI4dftB4iDnddISu6LbQ+33VDndU4yNworUlzozZrf+6W8IYjpyfm63Z0mHMu2g1t0A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from SN7PR11MB7540.namprd11.prod.outlook.com (2603:10b6:806:340::7)
 by DM6PR11MB4724.namprd11.prod.outlook.com (2603:10b6:5:2ad::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8632.27; Fri, 11 Apr
 2025 10:18:17 +0000
Received: from SN7PR11MB7540.namprd11.prod.outlook.com
 ([fe80::399f:ff7c:adb2:8d29]) by SN7PR11MB7540.namprd11.prod.outlook.com
 ([fe80::399f:ff7c:adb2:8d29%4]) with mapi id 15.20.8606.029; Fri, 11 Apr 2025
 10:18:16 +0000
Date: Fri, 11 Apr 2025 12:18:03 +0200
From: Larysa Zaremba <larysa.zaremba@intel.com>
To: Raju Rangoju <Raju.Rangoju@amd.com>
CC: <andrew+netdev@lunn.ch>, <davem@davemloft.net>, <edumazet@google.com>,
	<kuba@kernel.org>, <pabeni@redhat.com>, <netdev@vger.kernel.org>,
	<linux-kernel@vger.kernel.org>, <Shyam-sundar.S-k@amd.com>
Subject: Re: [PATCH net-next 3/5] amd-xgbe: add support for new XPCS routines
Message-ID: <Z_jsW6Y4n_NwhlnP@soc-5CG4396X81.clients.intel.com>
References: <20250408182001.4072954-1-Raju.Rangoju@amd.com>
 <20250408182001.4072954-4-Raju.Rangoju@amd.com>
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <20250408182001.4072954-4-Raju.Rangoju@amd.com>
X-ClientProxiedBy: VI1P194CA0049.EURP194.PROD.OUTLOOK.COM
 (2603:10a6:803:3c::38) To SN7PR11MB7540.namprd11.prod.outlook.com
 (2603:10b6:806:340::7)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SN7PR11MB7540:EE_|DM6PR11MB4724:EE_
X-MS-Office365-Filtering-Correlation-Id: d48b0860-71fa-4a73-f0ca-08dd78e22cc8
X-LD-Processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|376014|366016|10070799003|7053199007;
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?e3jWtFGTwOM8ofC0fX982/n/TDGRXLii1qg43UOsyF9+Wxe8suThTdA6O+AU?=
 =?us-ascii?Q?V8y6r08vPQY9p+mDd5+Rk2eTxMyx+1kkRmHpTebSUUtcQO8bXR4rCRRj9XnT?=
 =?us-ascii?Q?bIrEVpZI0XdSdGsrGx0xzfy0bQZJMyuVdIvTL4PsAySVV0YAyNm6jOt2vK9J?=
 =?us-ascii?Q?SYJCK5YAJ7/be0KKod5+Nzoj50w2oBZp7JQup/rzxW7YvvsukR55uZrtNfSb?=
 =?us-ascii?Q?jGooqNJUxp3GDc58oai2J5PtEpfux0UZXMmb3cMtGIs9+y4OEKo1/bhje+3f?=
 =?us-ascii?Q?q78MWq3OIPoprkpqe9dyfl1MzNfwXf7+CO5O6pgAvVy3zzN2U9DEuSKAyf56?=
 =?us-ascii?Q?1REH085svWB4sxHarXUY45Jupkpe/h5YCuEwl489ZS6YgXR3MEnRJlYFeexj?=
 =?us-ascii?Q?emmDxe+6Or7HQzV+TzcVY4BSkpwBfVfLFyTNESXremGGzXZANEjVKcKzgf7M?=
 =?us-ascii?Q?WP0t2g3pCl13Mfr+rt3emFrddp3uOm3LywHeL76suGF3thbbaHIlp/1r51p3?=
 =?us-ascii?Q?Bi65uH9pUEjfMrDAyUAx8G3JWXzVmhNOUTagAxtioakwwl7PvZPYAD+24PWZ?=
 =?us-ascii?Q?93CCLis3BX2tmmbyHB+iV+hhvj+r/Jgi28TebXuL+CD3F0P1MhpGnQ9wMUC2?=
 =?us-ascii?Q?XAfXEPqlXNhaAnTxkrB/g6GtWZPp2n6ZWjz/kuLe4AI/SRZrhwd+dB9ndh7f?=
 =?us-ascii?Q?hza8e2Z3Ho4F6T4nsykz9zsAIveDpI9EILtTFbPYpwJUAhRjnZdb1IFQFAfS?=
 =?us-ascii?Q?QD381xo2iUJpk19YScS8qp9T9GAnd15BfWS8WYP3iJKUmEkLUmhWbfwZpWqx?=
 =?us-ascii?Q?TaQn1Pyu/6cW++Qcwu1PapRlSa8j4/JZDCyKswKZvuCHc82Oy50aQdXBqao7?=
 =?us-ascii?Q?CFiY1d98hruCgr38vdyLhpFXqxnSj9ujWl3Byj9gPg0m9meRhiJyktgHif68?=
 =?us-ascii?Q?f4X3OMMtuAjkZONFZUupdiT7E8yoAx3jPi6i1ca01uKP8pFxKJ1YyIxElFqW?=
 =?us-ascii?Q?E5fd5XrKNeTQpBsEZ+v3TTsqMNrt9LkmAFD8vicJcaSVk+XhxRdwxrP+o53Q?=
 =?us-ascii?Q?C8FQSI5NusebIJ/qMm1xYk7GqUK2Rc01a0Tl16iXR6luxYG2SWd8axvYEv9r?=
 =?us-ascii?Q?r4jt7vuSxaF2KhXs2NUPXpU7I1PHnlQJoa7y8XwMVddIM7Zsg0AmPeKnOlXI?=
 =?us-ascii?Q?AR6SHecy0ZaAeosxILMAhiJnEt39Qdee6IXdecYmYZ7abypVQm7Z0gmSY+QX?=
 =?us-ascii?Q?x58tjSOpIzapPvqXu6+tsohE7xXKvm93oOZKwwoi2GtmI1VSWyctiEaR9XDe?=
 =?us-ascii?Q?mr2h9lI2yfFKDQOwKn/UA8rVtne5GJtjyO3orOlgazU/HvZC3RkuLTFOLx2x?=
 =?us-ascii?Q?AAQLd/D190UkvI93/zd0PX0oxI9XZhP7Ky8+4HgohPZ2bUf29P1jq7yajuL1?=
 =?us-ascii?Q?M8YjBwbkshc=3D?=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SN7PR11MB7540.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(376014)(366016)(10070799003)(7053199007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?Rx0u3sehQR9/G8OLvnOBrmNKmw2pUR4g/B+ZT8jRLhm/ickXdGRpuH7P9GU9?=
 =?us-ascii?Q?d1LX6oR4PL/ZXCN4Db4AeAPsqC2taqedDLxqVbCo9QS2nzRtJTDGVLypn/J/?=
 =?us-ascii?Q?e8lU9BfdWZR26brIEyztOadJG3oDd/xVPpKnnNorr2tnZN5QBWfrESWV7hwN?=
 =?us-ascii?Q?R/E4jK9eCt+2pfhCcEdgaetabEsy4K9LuqQ31UtTym+P7iXDVy4GTlY4LE37?=
 =?us-ascii?Q?evpqyweIC0SCfXtxlh5aAh4bMrAOr0IkLoqTSosjzNHUVcrdzwwkuW4GwZ9p?=
 =?us-ascii?Q?+xzCzm6MXuntfC8lZbRieyJmsCh2GByKZox6UTbBWq24qbcYoz8pwV745G0E?=
 =?us-ascii?Q?4wTNXIydcZks3JX2urOULGthOTqoxvD1OVK3UaviGmb1TrpANypfRe7teo4q?=
 =?us-ascii?Q?CiENAkZcRxNPQd53wA5BqGi1zYTsCElpPPe7r10Nb/VSwKMCMbvuyE5HyHVK?=
 =?us-ascii?Q?PnMh4MiQFl4AwwAzil8gLN91SA2gYV/Qumn0E7eZZKBk9lV+OnmVsnrMCPjv?=
 =?us-ascii?Q?tvaYHMbWmV2H8n2nlkbK6YW+jP+ffo6M2puabOUeZPTdmm0I/dCTDYEP0jAw?=
 =?us-ascii?Q?QnmayIaZJjEO+wTK1WAJBFFuiHI3zAVgc3z6X6rBT7OYan+9/AO3FQOF1Ebb?=
 =?us-ascii?Q?qwU7Sp+pbT7Or+7c8daoUQ7YWX4hVVNK5BERa3e5M+qYjK6rd4OH5PMBLlDF?=
 =?us-ascii?Q?5Hgmk3NFGuRm8MHYyis2pbzv8VinXrUE1PrwILey7cgq8yjvS35yxjrS0GLB?=
 =?us-ascii?Q?7pTyieO6tcQ1qEfLk6Uq+ayAf4lhw9zsmqlJ6Oxix+4nZP9C3Ny7EAa8+lN7?=
 =?us-ascii?Q?3+88QwXEDtVoMlnjC1VL+OXRXv28zeke7WUBswGRi8/0/VC62IOq/7zDs8Fp?=
 =?us-ascii?Q?/ofTptCHy+CVIeCNLb0jLGMguvbj+QKJ5SZC1MxvD8OJFwIp/ehCjhCRuN3V?=
 =?us-ascii?Q?m5o2f8wBGgqBegGrHJCYLq1byW/B38fHoqcJa77m8dCtIctYcETweZ+w0Au1?=
 =?us-ascii?Q?zR544rMQhjxmpuVUQWD2Nm7HiqkTmeFOpV4FTvKwGY0GyZUqmdYaEb3uzwWd?=
 =?us-ascii?Q?i4nm+hFhJGN64rYdTAHngKpp6H9uicAMruY4U5nyIiJcp1+viMlNXp5WiCFr?=
 =?us-ascii?Q?9qKdTH7xIzElH0QAp30HPhaRt3v5qOfkn3aZnVjvbiwoOcN9OYoL7ysU5zOY?=
 =?us-ascii?Q?nUVRNf4VTZAySQ35wiRMs2+heMupjWmeMRpAxMpho8DIIeolE7oSJZvb0dN4?=
 =?us-ascii?Q?CTweoCa5AbUxbbgKgaLIc9AZKP8056OFHWvhCGpumEsdnCF3EGr47lY1JNBa?=
 =?us-ascii?Q?zxE3wR1CAQr9Fq3Q8cfbF4mgNHjUGv6lGfMGTkzYZJ5DSm5/pcbGW0T7mdKJ?=
 =?us-ascii?Q?njOpAL+NRgeXmp5V2HRwV0XxL2QLP5VxCc0gKwbJ5VftRWukd42NBAQRS7d5?=
 =?us-ascii?Q?ctkhfuI3nhbOjs8oAwrPwp2vFFDvM7H5Sv8RU2z9101PgNFN1tkZDLQZnzyW?=
 =?us-ascii?Q?fAbr6wDj6puhcY1pL4wRFaamkKZactskKnjdBKmMSyUolobTMHqAfhbFOlmz?=
 =?us-ascii?Q?7vzYStuEeEckqIJ271BTxiWKS9xymfN2Sh1btWQNKQvNHQ2hj/SDTjE0+DOa?=
 =?us-ascii?Q?0GyrC8QYQQCfz536n6pX3LaPsTxfUOYQIa4SIqe3z7ou8XOjajCNf029NnE8?=
 =?us-ascii?Q?Lu75gA=3D=3D?=
X-MS-Exchange-CrossTenant-Network-Message-Id: d48b0860-71fa-4a73-f0ca-08dd78e22cc8
X-MS-Exchange-CrossTenant-AuthSource: SN7PR11MB7540.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 11 Apr 2025 10:18:16.8313
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 1XeNbh4OygVObxJi8xVGzgnewi7/w4vkct7dUtyTPIskQTOY5JEzCuxfusrWDVwrrXKpqbKXy+0Gw7qxMToQc5/q2AqsGlMvIBEsZv2IgVw=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR11MB4724
X-OriginatorOrg: intel.com

On Tue, Apr 08, 2025 at 11:49:59PM +0530, Raju Rangoju wrote:
> Add the necessary support to enable Crater ethernet device. Since the
> BAR1 address cannot be used to access the XPCS registers on Crater, use
> the smn functions.
> 
> Signed-off-by: Raju Rangoju <Raju.Rangoju@amd.com>
> ---
>  drivers/net/ethernet/amd/xgbe/xgbe-dev.c | 79 ++++++++++++++++++++++++
>  drivers/net/ethernet/amd/xgbe/xgbe.h     |  6 ++
>  2 files changed, 85 insertions(+)
> 
> diff --git a/drivers/net/ethernet/amd/xgbe/xgbe-dev.c b/drivers/net/ethernet/amd/xgbe/xgbe-dev.c
> index ae82dc3ac460..d75cf8df272f 100644
> --- a/drivers/net/ethernet/amd/xgbe/xgbe-dev.c
> +++ b/drivers/net/ethernet/amd/xgbe/xgbe-dev.c
> @@ -11,6 +11,7 @@
>  #include <linux/bitrev.h>
>  #include <linux/crc32.h>
>  #include <linux/crc32poly.h>
> +#include <linux/pci.h>
>  
>  #include "xgbe.h"
>  #include "xgbe-common.h"
> @@ -1066,6 +1067,78 @@ static void get_pcs_index_and_offset(struct xgbe_prv_data *pdata,
>  	*offset = pdata->xpcs_window + (mmd_address & pdata->xpcs_window_mask);
>  }
>  
> +static int xgbe_read_mmd_regs_v3(struct xgbe_prv_data *pdata, int prtad,
> +				 int mmd_reg)
> +{
> +	unsigned int mmd_address, index, offset;
> +	struct pci_dev *rdev;
> +	unsigned long flags;
> +	int mmd_data;
> +
> +	rdev = pci_get_domain_bus_and_slot(0, 0, PCI_DEVFN(0, 0));
> +	if (!rdev)
> +		return 0;

Why do you operate on the root device's config space? Is this SoC-specific, 
like in ixgbe_x550em_a_has_mii()? If so, would be nice to have a comment or at 
least something in the commit message.

> +
> +	mmd_address = get_mmd_address(pdata, mmd_reg);
> +
> +	get_pcs_index_and_offset(pdata, mmd_address, &index, &offset);
> +
> +	spin_lock_irqsave(&pdata->xpcs_lock, flags);
> +	pci_write_config_dword(rdev, 0x60, (pdata->xphy_base + pdata->xpcs_window_sel_reg));
> +	pci_write_config_dword(rdev, 0x64, index);
> +	pci_write_config_dword(rdev, 0x60, pdata->xphy_base + offset);
> +	pci_read_config_dword(rdev, 0x64, &mmd_data);
> +	mmd_data = (offset % 4) ? FIELD_GET(XGBE_GEN_HI_MASK, mmd_data) :
> +				  FIELD_GET(XGBE_GEN_LO_MASK, mmd_data);
> +
> +	pci_dev_put(rdev);
> +	spin_unlock_irqrestore(&pdata->xpcs_lock, flags);
> +
> +	return mmd_data;
> +}
> +
> +static void xgbe_write_mmd_regs_v3(struct xgbe_prv_data *pdata, int prtad,
> +				   int mmd_reg, int mmd_data)
> +{
> +	unsigned int pci_mmd_data, hi_mask, lo_mask;
> +	unsigned int mmd_address, index, offset;
> +	struct pci_dev *rdev;
> +	unsigned long flags;
> +
> +	rdev = pci_get_domain_bus_and_slot(0, 0, PCI_DEVFN(0, 0));
> +	if (!rdev)
> +		return;
> +
> +	mmd_address = get_mmd_address(pdata, mmd_reg);
> +
> +	get_pcs_index_and_offset(pdata, mmd_address, &index, &offset);
> +
> +	spin_lock_irqsave(&pdata->xpcs_lock, flags);
> +	pci_write_config_dword(rdev, 0x60, (pdata->xphy_base + pdata->xpcs_window_sel_reg));
> +	pci_write_config_dword(rdev, 0x64, index);
> +	pci_write_config_dword(rdev, 0x60, pdata->xphy_base + offset);
> +	pci_read_config_dword(rdev, 0x64, &pci_mmd_data);
> +
> +	if (offset % 4) {
> +		hi_mask = FIELD_PREP(XGBE_GEN_HI_MASK, mmd_data);
> +		lo_mask = FIELD_GET(XGBE_GEN_LO_MASK, pci_mmd_data);
> +	} else {
> +		hi_mask = FIELD_PREP(XGBE_GEN_HI_MASK,
> +				     FIELD_GET(XGBE_GEN_HI_MASK, pci_mmd_data));
> +		lo_mask = FIELD_GET(XGBE_GEN_LO_MASK, mmd_data);
> +	}
> +
> +	pci_mmd_data = hi_mask | lo_mask;
> +
> +	pci_write_config_dword(rdev, 0x60, (pdata->xphy_base + pdata->xpcs_window_sel_reg));
> +	pci_write_config_dword(rdev, 0x64, index);
> +	pci_write_config_dword(rdev, 0x60, (pdata->xphy_base + offset));
> +	pci_write_config_dword(rdev, 0x64, pci_mmd_data);
> +	pci_dev_put(rdev);
> +
> +	spin_unlock_irqrestore(&pdata->xpcs_lock, flags);
> +}
> +
>  static int xgbe_read_mmd_regs_v2(struct xgbe_prv_data *pdata, int prtad,
>  				 int mmd_reg)
>  {
> @@ -1160,6 +1233,9 @@ static int xgbe_read_mmd_regs(struct xgbe_prv_data *pdata, int prtad,
>  	case XGBE_XPCS_ACCESS_V2:
>  	default:
>  		return xgbe_read_mmd_regs_v2(pdata, prtad, mmd_reg);
> +
> +	case XGBE_XPCS_ACCESS_V3:
> +		return xgbe_read_mmd_regs_v3(pdata, prtad, mmd_reg);
>  	}
>  }
>  
> @@ -1173,6 +1249,9 @@ static void xgbe_write_mmd_regs(struct xgbe_prv_data *pdata, int prtad,
>  	case XGBE_XPCS_ACCESS_V2:
>  	default:
>  		return xgbe_write_mmd_regs_v2(pdata, prtad, mmd_reg, mmd_data);
> +
> +	case XGBE_XPCS_ACCESS_V3:
> +		return xgbe_write_mmd_regs_v3(pdata, prtad, mmd_reg, mmd_data);
>  	}
>  }
>  
> diff --git a/drivers/net/ethernet/amd/xgbe/xgbe.h b/drivers/net/ethernet/amd/xgbe/xgbe.h
> index 2e9b3be44ff8..6c49bf19e537 100644
> --- a/drivers/net/ethernet/amd/xgbe/xgbe.h
> +++ b/drivers/net/ethernet/amd/xgbe/xgbe.h
> @@ -242,6 +242,10 @@
>  #define XGBE_RV_PCI_DEVICE_ID	0x15d0
>  #define XGBE_YC_PCI_DEVICE_ID	0x14b5
>  
> + /* Generic low and high masks */
> +#define XGBE_GEN_HI_MASK	GENMASK(31, 16)
> +#define XGBE_GEN_LO_MASK	GENMASK(15, 0)
> +
>  struct xgbe_prv_data;
>  
>  struct xgbe_packet_data {
> @@ -460,6 +464,7 @@ enum xgbe_speed {
>  enum xgbe_xpcs_access {
>  	XGBE_XPCS_ACCESS_V1 = 0,
>  	XGBE_XPCS_ACCESS_V2,
> +	XGBE_XPCS_ACCESS_V3,
>  };
>  
>  enum xgbe_an_mode {
> @@ -951,6 +956,7 @@ struct xgbe_prv_data {
>  	struct device *dev;
>  	struct platform_device *phy_platdev;
>  	struct device *phy_dev;
> +	unsigned int xphy_base;
>  
>  	/* Version related data */
>  	struct xgbe_version_data *vdata;
> -- 
> 2.34.1
> 
> 

