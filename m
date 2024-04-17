Return-Path: <netdev+bounces-88656-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id ACC5D8A8128
	for <lists+netdev@lfdr.de>; Wed, 17 Apr 2024 12:40:12 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id D91031C22512
	for <lists+netdev@lfdr.de>; Wed, 17 Apr 2024 10:40:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7539B13C3EB;
	Wed, 17 Apr 2024 10:39:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="J9P0gExF"
X-Original-To: netdev@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 63DA1139CEF
	for <netdev@vger.kernel.org>; Wed, 17 Apr 2024 10:39:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=192.198.163.12
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713350397; cv=fail; b=JCWuAy6g2xjnCt9P+VZkbIaeBHzErDb/D6sbL5eEZWt7DQRdOtxGge0DSdq+ioT/QX0TU1bROncnAbb3e9P8zdrpu6uoVoAoAyK8iQt/S3CY2EpEnZumSDwSaDDT7bv5Z6ROFtr/jmlOBQ8+51Jpt3IcQFjZlXHxICw++qgA9NE=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713350397; c=relaxed/simple;
	bh=GddD99I0mMYDOXAehA1JIHw/3ofcKWaWUpgjOJy4Avw=;
	h=Message-ID:Date:Subject:To:CC:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=BDs0GGiZeuDful4uXynnW5CaAyljhWDJKBaI5Kr8yDQZ0Rq1qRtVRdF1HnS0N39+TDIBz0R1mcHKk9vPdf5lnowXAqyQIDE90uTtaIio2Z7FvtmqwsBKCY9Ura0A9sL8lGw3z3GntjEzG9gRJ29t8bAxEpFf5Ro0DDDkVpwxf5I=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=J9P0gExF; arc=fail smtp.client-ip=192.198.163.12
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1713350396; x=1744886396;
  h=message-id:date:subject:to:cc:references:from:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=GddD99I0mMYDOXAehA1JIHw/3ofcKWaWUpgjOJy4Avw=;
  b=J9P0gExFfKSHmsvlm+btmacDDH4BcZ2OjEEi200MIfN7PYrNy1d8pZFM
   0ddHweRWgF3EHCiokDIcQexEont0uSEtZZKjlqpwP8zSDv7POIjKBZoiQ
   sKugipwJwiiLywFBKAH8+dpGi5f2CqSGAV7WF7HKKDkqMaxaEttMLHA3X
   jRxL07kshBUlo7Mv76gUD6hCMhPLrxcs6EIDOQ0WkeksW+z/D6zLhSSzU
   GlxihL7gbM32OA4zjQHxvP6YAROsoAzLL1L5UhzauCTn9/NFF03sbslgy
   bzExcnikPij6IBG3Aw1MqVDw3nyVqTtlNxUQ6APxomKgVTO7lz1ki0X5w
   g==;
X-CSE-ConnectionGUID: +hT3bTqdQhSfbBMsuvcKNQ==
X-CSE-MsgGUID: pwsxey2kQceCQagfiwHLBQ==
X-IronPort-AV: E=McAfee;i="6600,9927,11046"; a="12615193"
X-IronPort-AV: E=Sophos;i="6.07,209,1708416000"; 
   d="scan'208";a="12615193"
Received: from fmviesa007.fm.intel.com ([10.60.135.147])
  by fmvoesa106.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 17 Apr 2024 03:39:53 -0700
X-CSE-ConnectionGUID: g0CcWyfSSt6qsjPdR2q03Q==
X-CSE-MsgGUID: lNhPjOJvRge6S0QDcwnX5Q==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.07,209,1708416000"; 
   d="scan'208";a="22660827"
Received: from fmsmsx602.amr.corp.intel.com ([10.18.126.82])
  by fmviesa007.fm.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 17 Apr 2024 03:39:53 -0700
Received: from fmsmsx611.amr.corp.intel.com (10.18.126.91) by
 fmsmsx602.amr.corp.intel.com (10.18.126.82) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35; Wed, 17 Apr 2024 03:39:52 -0700
Received: from fmsmsx610.amr.corp.intel.com (10.18.126.90) by
 fmsmsx611.amr.corp.intel.com (10.18.126.91) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35; Wed, 17 Apr 2024 03:39:52 -0700
Received: from FMSEDG603.ED.cps.intel.com (10.1.192.133) by
 fmsmsx610.amr.corp.intel.com (10.18.126.90) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35 via Frontend Transport; Wed, 17 Apr 2024 03:39:52 -0700
Received: from NAM04-BN8-obe.outbound.protection.outlook.com (104.47.74.41) by
 edgegateway.intel.com (192.55.55.68) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.35; Wed, 17 Apr 2024 03:39:51 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=fhh8mqucrgpLko/3kKvvRHFWpANGTSTsTTth3xgLI6gqi9L4XBk+nZJRd2e6SnLjyYp78YrOLZN/4qr7mtoPuqeloWwBiBfG8I434eb81Gj0ejnV9kRg3/13w+8uUKnucWLZSbqeGvuSbdB5OhiwftpV7Z7LF3iV02dqUk6XXUGRMXIQ9qLHjvSWEtqlxBcVXow+Cpz4pC1qb+diEs+9+SI41mCGHTcnNy7mm3NhB0+2B/EdjPPwQdbo851UeHYGHQRkfoNjFIW4vHyRtaCHlfhHkLC5XyFID3LqrGxuQU/3H3nDNNd3Ut5H+d2SvrQGHatLG1s1icFOu/o396qi/A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=zk+uAB9FK+EYbAA0L5wACpx38l92FscCt5o+BlsXmw0=;
 b=iIdJ90IdZG5rpgJwl+w1syGwZIf1ygDvQwDxGo2UAxMdixr5SWqll8YNER3dtwcLEUILvDPEv6yf5/yqi5Z32c4J/XcKkGjKWKvSZdi7Wje2cXvZAYk57Ei5vQJWqtOlEbXWKy7I2qCv9qiCOGVaHMnthuUt7s3LwSwMdHKJ8gf+g7guGL5a0v2k66AAiksgL55Q1bUIlV8YaesWdqu9CFdr8yuZhBj9wzFEPreCY+LGh08FTKuxdLGJAiD7fOUYNA0SEGR30HE73SqvV5rWwXbCYIDtv2hlzqRWJETTvAJ+6g9tpKNiPUoLmRU89HclZAovpKgRn3aXRShUuY85Yw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from DS0PR11MB8718.namprd11.prod.outlook.com (2603:10b6:8:1b9::20)
 by SJ2PR11MB8587.namprd11.prod.outlook.com (2603:10b6:a03:568::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7472.26; Wed, 17 Apr
 2024 10:39:49 +0000
Received: from DS0PR11MB8718.namprd11.prod.outlook.com
 ([fe80::654c:d66a:ec8e:45e9]) by DS0PR11MB8718.namprd11.prod.outlook.com
 ([fe80::654c:d66a:ec8e:45e9%6]) with mapi id 15.20.7472.027; Wed, 17 Apr 2024
 10:39:43 +0000
Message-ID: <dabd8755-16f6-448d-b054-9245f2f27a67@intel.com>
Date: Wed, 17 Apr 2024 12:39:38 +0200
User-Agent: Mozilla Thunderbird
Subject: Re: [net-next PATCH 13/15] eth: fbnic: add basic Rx handling
To: Alexander Duyck <alexander.duyck@gmail.com>
CC: Jakub Kicinski <kuba@kernel.org>, Yunsheng Lin <linyunsheng@huawei.com>,
	<netdev@vger.kernel.org>, Alexander Duyck <alexanderduyck@fb.com>,
	<davem@davemloft.net>, <pabeni@redhat.com>
References: <171217454226.1598374.8971335637623132496.stgit@ahduyck-xeon-server.home.arpa>
 <171217496013.1598374.10126180029382922588.stgit@ahduyck-xeon-server.home.arpa>
 <41a39896-480b-f08d-ba67-17e129e39c0f@huawei.com>
 <CAKgT0Uf6MdYX_1OuAFAXadh86zDX_w1a_cwpoPGMxpmC4hGyEA@mail.gmail.com>
 <53b80db6-f2bc-d824-ea42-4b2ac64625f2@huawei.com>
 <CAKgT0UeQS5q=Y2j3mmu9AhWyUMbey-iFL+sKES1UrBtoAXMdzw@mail.gmail.com>
 <0e5e3196-ca2f-b905-a6ba-7721e8586ed7@huawei.com>
 <CAKgT0UeRWsJ+NiniSKa7Z3Law=QrYZp3giLAigJf7EvuAbjkRA@mail.gmail.com>
 <bf070035-ba9c-d028-1b11-72af8651f979@huawei.com>
 <CAKgT0UccovDVS8-TPXxgGbrTAqpeVHRQuCwf7f2qkfcPaPOA-A@mail.gmail.com>
 <20240415101101.3dd207c4@kernel.org>
 <CAKgT0UcGN3-6R4pt8BQv2hD04oYk48GfFs1O_UGChvrrFT5eCw@mail.gmail.com>
 <008a9e73-16a4-4d45-9559-0df7a08e9855@intel.com>
 <CAKgT0UfyAQaPKApZoV6YJhMPAac3q3KBN4yHdF0j48mKZopsBw@mail.gmail.com>
From: Alexander Lobakin <aleksander.lobakin@intel.com>
Content-Language: en-US
In-Reply-To: <CAKgT0UfyAQaPKApZoV6YJhMPAac3q3KBN4yHdF0j48mKZopsBw@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: MI1P293CA0006.ITAP293.PROD.OUTLOOK.COM
 (2603:10a6:290:2::16) To DS0PR11MB8718.namprd11.prod.outlook.com
 (2603:10b6:8:1b9::20)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS0PR11MB8718:EE_|SJ2PR11MB8587:EE_
X-MS-Office365-Filtering-Correlation-Id: cb707f59-dcfa-48d8-7a62-08dc5ecab138
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: vv1sue20Y8Mn9lIMWMXIzzU9ou12uNRCDxWVmOGq51KTuc843PKEuPxUaG+CeKPrGPmENh4VYtsxGZS67okVvjxmneof8gIeR15KMTEE7gv30bKes3K0bVD3gItYYx5oMlDtNXTZAA6BB0dHxwKLm/UcIM0spaC4CRysGTZ8uj+G+/R7HXu4R7MWs2e24OalHFJ6p3k9ALOfsNXYPAtOQDbFiJkSluNGGxaLm5gGnxiXMV+ySKlK/ERMiavac6IQuU8HCO4sRyVVOStiGeyuUC4viLmuBWTUkBg+zxwN40ch1QSesA/bK2cysaCI+VKkVxYQFi3VMpOlClIrm/gJVj8JycXwHTe7Dw/gju3yU48sQ/f4zLSKtkDIwwp/hA2+iTRhqSRpKYAS99B8TMgUb8Dwd+BSsT6Q0ocWjLsK3NJ1Dyoj4RpwwLS0gdCGhRYSNsGbfnhmzA6K2n3b2q3SmN+ekJKp+Jh2bIeQcPL+PWlUKCpD9ehhmD6rjPjy4cjcmAi/asiK0Lb6QoYYgDyimJ5vBfOzQQmxChHKMX9ZVcXWlw/0yMZESoQfjTSUBL4cEIDMbqOVqRvg4/pE6wC14EI/HP0RcUrfvkNvL2ZiGLmqfR1hdZVs1/I8YH9zvuw0gCuiS5OcyMhkt4ex3AlrkmFHvcOrIxWpqAmSpVUE1rk=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DS0PR11MB8718.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(366007)(1800799015)(376005);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?Zy9YbzlRckd4ZVM4Mm5JekduRUMxdGFoeVpqWDZjUUNRYm0zQXFwcG14dGZs?=
 =?utf-8?B?U3ltQ3ZJSUxMcnB2MkFORHI5NE1FNjJ3TGZHdThxUjNSckpjL3FrOXh1NnpV?=
 =?utf-8?B?UWdJMU1JU2xqV2doamxPdkhmZ0RIdzdaTVNFYkNCcXBOVmdXRXZ0QXc1V3hJ?=
 =?utf-8?B?ek5UUWM3b2cxMlB2NW83M0FVNmFTdGc0cXdkb0ZuZS91ejFmbE1TbXBUdW5K?=
 =?utf-8?B?RVNwdWx5TFIyWnVlTHlkT2FTbm1YTmZ1bkNLK2tzSENiRC91eXBrUm5xTEtZ?=
 =?utf-8?B?QlRXc044VEgwZlVjUUxyN1RZQ3pFcGpOS2R3bzhacWlwNFkxOE9KRjJSUE5n?=
 =?utf-8?B?TzRNUDNLZjA4ZEZzZjM0YkU2YkowZ0w3TzBUbEZYVWRZUHFSM1JoQ2ltS3c0?=
 =?utf-8?B?S2NZbXFVV1dUY0xreVJJUkpRY2hqYW05ZDNDMzFxSDBHL1JLdU5keE84cW9v?=
 =?utf-8?B?Q3hUeFBqaEp0K1kwaktZMzV2eTd1aGN3Qy9mazZ1K1FPc1R5SklrOUdXWWFi?=
 =?utf-8?B?aWNMWm9RVEFiMUwxbGwwT29xN1k1cWJhNHhGaGJ4Qllkbm9icWNNMDdOcFVD?=
 =?utf-8?B?WFBKN3kwU0pqbkVCQ3BYSHg4ZWtMVTFZUmo4cjVnRm4zS2xxaWg4Qmx0UXdp?=
 =?utf-8?B?d0FxZjc1azl0NFIzOCtNRXc1TzVTbG5WTmx3THNHeGd5VHZsdmJPY0Yxd25N?=
 =?utf-8?B?dXFoTGFwMXJmMkE4UHloYUVkbDR1WE9zRjRCaGtESUIvcGdzMUNDeUQwbDRJ?=
 =?utf-8?B?UU53dWhVS09iczltQUN5Y29LcEFYMDl6L2pvL0pzdTZYdnhsVks3ZlZGMlFz?=
 =?utf-8?B?Y0J0NkFWVTZPY0ptamZ4N3VaeStUWEQrVlhSY1JqaFhPVER0ZzlHb1p0d245?=
 =?utf-8?B?d2JkR1lMM2Jkc0hSbHU4MzRNZkk1U3lyMWduTUFpSExrWWx2RlIwc2xCY2Vn?=
 =?utf-8?B?d1RZanhVb2htOFh5Mng5c0RJK3U1a0twamROL3NxdCtXZHp2dFNlN2tEdEN0?=
 =?utf-8?B?S2dvY3UyOSt1RlRwTlY4WkpJZzdUN3h0VVl0bGZyaDJlalYwTnYycWV3OXRw?=
 =?utf-8?B?Y0JzRjdtUGRtMkRLVDNjbkRqZ1pha1FpRXB0TTI4LzBIZ0xpMXl3WVN5L1VC?=
 =?utf-8?B?UjJOOUNuY1Y0cS9pWXlZSDh2Vjg1UG8vbTFxaFB5ak5DUmVTL1F3NzI5YXVM?=
 =?utf-8?B?L1QzQ21PYzFvalg5ZmJCTHorTTM5T2tLbFlvL25wY2djT0VWNmFSTnNGa1Qy?=
 =?utf-8?B?bXpKcDBRVkdSSzhsOUpaUXNWV2JmWXc2L0ZreHZFT2NST2FQR2FiS0xXRHcy?=
 =?utf-8?B?cEQxZHRDUzNwd3QvSWJxejNkc0haQmplekU2NU9RaVVwNXlEMVpCNzVYODJq?=
 =?utf-8?B?ckRIWHVCNG1PMEo5Z0VWSXM3QU1lM1pZdWdHS0YvVWJ1QjBrMzVOTGFYYTAy?=
 =?utf-8?B?aTZvQVYzUHR6QWFTejVtT3FrWFFGN3UwQm5CbEZQSGhSSjh5OVpXdXhUTStD?=
 =?utf-8?B?clNlZFpLN0k2WFJ6UzRuVUt2T0dJMzRpR0gxMDNRSGFrZ0pWWk1Wc2tDMGdk?=
 =?utf-8?B?d25IR1diQmVhbVVhVi85NmlhUkZveHRjWVZaYnVCaWZ5dVVVY1p0UGQwS3RE?=
 =?utf-8?B?bERodEVzTnk5akZpa1FXVzFPaTViTlpPMFFrSnR0emlXcEl5Z0t6NjZYd0xy?=
 =?utf-8?B?dmY2Yk1RZWc5K3VzZzBBVHRsREVCUjVTb1daRHdFYnpldS9EQW9IUjJic0lk?=
 =?utf-8?B?V256c1RKQlF2S0htTytBYkNLdlozdldtQ1lQdHRVWHptR0RrekJNdUdqM3NT?=
 =?utf-8?B?cUxqMDNXV09IS05nRU5lNHBvb1o1ODN1aDllU3NmRjlPSnNLNzRmSnU5U0I5?=
 =?utf-8?B?Y0VSU2FvdzJOZkUxWkFQMW1ETzMxQUQyQllvWGdJYnVIVFg0eWZodVRzOTV3?=
 =?utf-8?B?OVQyM293S29UMkVlVEhDbE1QVEY4S2tuVFdJNG1Xb0hrU1oydm9rS29DWldt?=
 =?utf-8?B?RUIzOGFVZEtXb28wZGljZi93cDluWGVIaEVaSkJzVjhqT1dVUDU2VG5iT3Bj?=
 =?utf-8?B?cWJINWgvMWMwbXZnN3lNeTFwQjBiMEZCeDN2TFZoRTYvdytZaGNDODYveDB0?=
 =?utf-8?B?M0dVcTFCaTNBK1dZRWExYzBweUs2dFM0RUNJemFFbmNPcjlNbjdrUm1oSXlI?=
 =?utf-8?B?M1E9PQ==?=
X-MS-Exchange-CrossTenant-Network-Message-Id: cb707f59-dcfa-48d8-7a62-08dc5ecab138
X-MS-Exchange-CrossTenant-AuthSource: DS0PR11MB8718.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 17 Apr 2024 10:39:43.0479
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: mI8fgooV7zBuPyuBVj2uDq+ZgB5oYNvyZV9YaraUjynm5l2v+pRuCfB+kH6MGK90OfosvbGqu34RJnvuRd7eU7LQ70kQtubQFQP7AefcEAw=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ2PR11MB8587
X-OriginatorOrg: intel.com

From: Alexander Duyck <alexander.duyck@gmail.com>
Date: Tue, 16 Apr 2024 07:46:06 -0700

> On Tue, Apr 16, 2024 at 7:05 AM Alexander Lobakin
> <aleksander.lobakin@intel.com> wrote:
>>
>> From: Alexander Duyck <alexander.duyck@gmail.com>
>> Date: Mon, 15 Apr 2024 11:03:13 -0700
>>
>>> On Mon, Apr 15, 2024 at 10:11 AM Jakub Kicinski <kuba@kernel.org> wrote:
>>>>
>>>> On Mon, 15 Apr 2024 08:03:38 -0700 Alexander Duyck wrote:
>>>>>>> The advantage of being a purpose built driver is that we aren't
>>>>>>> running on any architectures where the PAGE_SIZE > 4K. If it came to
>>>>>>
>>>>>> I am not sure if 'being a purpose built driver' argument is strong enough
>>>>>> here, at least the Kconfig does not seems to be suggesting it is a purpose
>>>>>> built driver, perhaps add a 'depend on' to suggest that?
>>>>>
>>>>> I'm not sure if you have been following the other threads. One of the
>>>>> general thoughts of pushback against this driver was that Meta is
>>>>> currently the only company that will have possession of this NIC. As
>>>>> such Meta will be deciding what systems it goes into and as a result
>>>>> of that we aren't likely to be running it on systems with 64K pages.
>>>>
>>>> Didn't take long for this argument to float to the surface..
>>>
>>> This wasn't my full argument. You truncated the part where I
>>> specifically called out that it is hard to justify us pushing a
>>> proprietary API that is only used by our driver.
>>>
>>>> We tried to write some rules with Paolo but haven't published them, yet.
>>>> Here is one that may be relevant:
>>>>
>>>>   3. External contributions
>>>>   -------------------------
>>>>
>>>>   Owners of drivers for private devices must not exhibit a stronger
>>>>   sense of ownership or push back on accepting code changes from
>>>>   members of the community. 3rd party contributions should be evaluated
>>>>   and eventually accepted, or challenged only on technical arguments
>>>>   based on the code itself. In particular, the argument that the owner
>>>>   is the only user and therefore knows best should not be used.
>>>>
>>>> Not exactly a contribution, but we predicted the "we know best"
>>>> tone of the argument :(
>>>
>>> The "we know best" is more of an "I know best" as someone who has
>>> worked with page pool and the page fragment API since well before it
>>> existed. My push back is based on the fact that we don't want to
>>
>> I still strongly believe Jesper-style arguments like "I've been working
>> with this for aeons", "I invented the Internet", "I was born 3 decades
>> before this API was introduced" are not valid arguments.
> 
> Sorry that is a bit of my frustration with Yunsheng coming through. He
> has another patch set that mostly just moves my code and made himself
> the maintainer. Admittedly I am a bit annoyed with that. Especially
> since the main drive seems to be to force everything to use that one
> approach and then optimize for his use case for vhost net over all
> others most likely at the expense of everything else.
> 
> It seems like it is the very thing we were complaining about in patch
> 0 with other drivers getting penalized at the cost of optimizing for
> one specific driver.
> 
>>> allocate fragments, we want to allocate pages and fragment them
>>> ourselves after the fact. As such it doesn't make much sense to add an
>>> API that will have us trying to use the page fragment API which holds
>>> onto the page when the expectation is that we will take the whole
>>> thing and just fragment it ourselves.
>>
>> [...]
>>
>> Re "this HW works only on x86, why bother" -- I still believe there
>> shouldn't be any hardcodes in any driver based on the fact that the HW
>> is deployed only on particular systems. Page sizes, Endianness,
>> 32/64-bit... It's not difficult to make a driver look like it's
>> universal and could work anywhere, really.
> 
> It isn't that this only works on x86. It is that we can only test it
> on x86. The biggest issue right now is that I wouldn't have any
> systems w/ 64K pages that I could test on, and the worst that could
> happen based on the current code is that the NIC driver will be a
> memory hog.
> 
> I would much prefer the potential of being a memory hog on an untested
> hardware over implementing said code untested and introducing
> something like a memory leak or page fault issue.
> 
> That is why I am more than willing to make this an x86_64 only driver
> for now and we can look at expanding out as I get time and get
> equipment to to add support and test for other architectures.

I don't see any issue to not limit it to x86_64 only. It compiles just
fine and if you run it later on a non-x86_64 system, you'll test it
then. I don't think anyone will run it on a different platform prior to
that.

Thanks,
Olek

