Return-Path: <netdev+bounces-301998-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id gEbJA0tGPWqQ0ggAu9opvQ
	(envelope-from <netdev+bounces-301998-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Thu, 25 Jun 2026 17:16:27 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 3ED696C6FC2
	for <lists+netdev@lfdr.de>; Thu, 25 Jun 2026 17:16:26 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=intel.com header.s=Intel header.b=aAueJ4nO;
	spf=pass (mail.lfdr.de: domain of "netdev+bounces-301998-lists+netdev=lfdr.de@vger.kernel.org" designates 172.234.253.10 as permitted sender) smtp.mailfrom="netdev+bounces-301998-lists+netdev=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=none) header.from=intel.com;
	arc=reject ("cv is fail on i=2")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 7997D3017C3F
	for <lists+netdev@lfdr.de>; Thu, 25 Jun 2026 15:14:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 77E9A3E8324;
	Thu, 25 Jun 2026 15:14:54 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4905F3E832B;
	Thu, 25 Jun 2026 15:14:52 +0000 (UTC)
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782400494; cv=fail; b=tGs3w/jxMc8ACtZU7l+Vz6B26IhmtsXdvzKSfLPhb9bjDjNGt05rcOGdLzRzlYdOkpJFlBWUVqC7+sY/2nqghXa3MAPqVXZh4gnAIpfkJGKmzmCnI0ZpUVntaZ69oRIfYYo2qmgAAkuaMtUFR3rzRYBiPAj2BK/gV5Y12jz+S6s=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782400494; c=relaxed/simple;
	bh=zw5I0964Wlqso03QcGCHWePYFtbuYKne9fEP455vfH4=;
	h=Message-ID:Date:Subject:To:CC:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=M+x5AhPEBKaW6b1NE37YAjb2J8L+n+xH17G7tlI6SECTQEv7gZknc8Udh+z8JZsTACvJ1IH8TeSFvuwPffpvLJuG9xvS8kDNfyU3lwArzXNeHwQfQ8xJunzZXxkpdUisk/YaVgwFO9qQsxyzqyskDm6qp24DCrNf3lfeZNnPt6g=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=aAueJ4nO; arc=fail smtp.client-ip=198.175.65.19
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1782400492; x=1813936492;
  h=message-id:date:subject:to:cc:references:from:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=zw5I0964Wlqso03QcGCHWePYFtbuYKne9fEP455vfH4=;
  b=aAueJ4nOenqE/qR9Zun/e/ZJlUJkEF3mhwCz47IuE3tXZJCq0SleXe13
   UyVZs7gaDgVzT4ZpgDnYJ3GVHi0y5ct0X/1ivedvAv9+aCB5imlnvUABA
   Iwk7yozsX+RLI+MN9dzb0WNB9uoDBDVcBcHlxVbLFLGijs9NDIXH5voYN
   PxLbi0r5q7/NVGji6+IY4XEBEU07peQ8+t4YBrFfCFTMi/uvYrXfakhgL
   yq6dxJd/8aN1fOarz17yvBzmggxmnKTZqzoi1/GIVD9F1BrBmdfGLYYIe
   0x9mVsZ5BkpsKaqkst8B6I6nPIZK1qqplfdFfjVcwbpogA0vD+Ynw9hUh
   w==;
X-CSE-ConnectionGUID: Bd0wu4QIStudGPxe1S9URw==
X-CSE-MsgGUID: zbLg89hDQ8yqRLSR5n18Zg==
X-IronPort-AV: E=McAfee;i="6800,10657,11827"; a="83185801"
X-IronPort-AV: E=Sophos;i="6.24,224,1774335600"; 
   d="scan'208";a="83185801"
Received: from fmviesa004.fm.intel.com ([10.60.135.144])
  by orvoesa111.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 25 Jun 2026 08:14:49 -0700
X-CSE-ConnectionGUID: AzLVO/7jRiu+1rQUzheuoA==
X-CSE-MsgGUID: IGLSuSCxQ8mIHGphYHIKsA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.24,224,1774335600"; 
   d="scan'208";a="252747186"
Received: from orsmsx901.amr.corp.intel.com ([10.22.229.23])
  by fmviesa004.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 25 Jun 2026 08:14:49 -0700
Received: from ORSMSX902.amr.corp.intel.com (10.22.229.24) by
 ORSMSX901.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.37; Thu, 25 Jun 2026 08:14:48 -0700
Received: from ORSEDG901.ED.cps.intel.com (10.7.248.11) by
 ORSMSX902.amr.corp.intel.com (10.22.229.24) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.37 via Frontend Transport; Thu, 25 Jun 2026 08:14:48 -0700
Received: from PH0PR06CU001.outbound.protection.outlook.com (40.107.208.41) by
 edgegateway.intel.com (134.134.137.111) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.37; Thu, 25 Jun 2026 08:14:48 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=HGonVFx2bXiC6beumzGax4NQth1JInk/l6QMovWEd1CpKp9uchC/cPt2KLnVhONeqBUnoQ53p6vKY/4GlJuW8dEaDfnZF0TjZRK/+GJpSfd083LrHVwCgmknQ2Ndn27chvh09kTfdbjbokHKcIXEPemYE2KQPLwa/o84Xz02DPdXVLpR2c6Ox2vCvXJQzl4UbWBvgLlfM0ZpXz/+plLbQcqb8YP2NzWMemrty8VzUSELNrQ8EtQqVDj7fcxvmwREM8EKG1lB68DBySBVpOJhKpbS6fY2FG1IP4PSAhD39U+PXq268xPEOF8SzOjvfPkUv14coJbGLp2KiFBDnfsg4w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=WMbEJMM5HHDaMsun9A6NY4J1Ldl1ws96hty2Pacnq/0=;
 b=V/2S4b6ZsklJEQEdar+F3qUkPoLrq+7oWHXtuh8zahBisF3/C1A92gcXLOxjNisdMnVI3odzetOezsE7Ivn9UMhT+2fiC7vBBw+YTJg806mqAnEL/0gaGlVIn9EX/33U8Gx7Pr77zlSYHLzLfG/GrEZVrEuY3ZNt+4AEyPtuG6P1+QUeGbOEUro/cJi8mQ7Durtb1tcp0K5k+V2Bk/T1c+fPropX7lT9FZcv7wGgIQtYK5em2LfnB7rdR0AicKoOGwAJFYWpvkKXdE8LXyGsDSw2WL1R+PQeNKXx3RDf87Zdy+3XykalU9FERXslUWsf5ZnTT7938dmWexf9/PFQNQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from DS0PR11MB8718.namprd11.prod.outlook.com (2603:10b6:8:1b9::20)
 by SJ0PR11MB5150.namprd11.prod.outlook.com (2603:10b6:a03:2d4::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.159.17; Thu, 25 Jun
 2026 15:14:46 +0000
Received: from DS0PR11MB8718.namprd11.prod.outlook.com
 ([fe80::6aa:411d:4bfa:619c]) by DS0PR11MB8718.namprd11.prod.outlook.com
 ([fe80::6aa:411d:4bfa:619c%4]) with mapi id 15.21.0159.015; Thu, 25 Jun 2026
 15:14:46 +0000
Message-ID: <0922ce5d-48d8-44e7-983c-e547f3126ef4@intel.com>
Date: Thu, 25 Jun 2026 17:14:06 +0200
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] xsk: fix memory corruptions in net/core/xdp.c
To: Clement Lecigne <clecigne@google.com>
CC: <edumazet@google.com>, <netdev@vger.kernel.org>, <bpf@vger.kernel.org>,
	<linux-kernel@vger.kernel.org>, <kuba@kernel.org>, <sdf@fomichev.me>,
	<horms@kernel.org>, <john.fastabend@gmail.com>, <ast@kernel.org>,
	<daniel@iogearbox.net>
References: <20260624084130.2382335-1-clecigne@google.com>
From: Alexander Lobakin <aleksander.lobakin@intel.com>
Content-Language: en-US
In-Reply-To: <20260624084130.2382335-1-clecigne@google.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: TL2P290CA0022.ISRP290.PROD.OUTLOOK.COM (2603:1096:950:3::6)
 To DS0PR11MB8718.namprd11.prod.outlook.com (2603:10b6:8:1b9::20)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS0PR11MB8718:EE_|SJ0PR11MB5150:EE_
X-MS-Office365-Filtering-Correlation-Id: f4226760-36af-47ba-db51-08ded2cc7dae
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|23010399003|376014|7416014|1800799024|366016|18002099003|22082099003|11063799006|56012099006|6133799003;
X-Microsoft-Antispam-Message-Info: STdY5N86fvVHERjmRsbe9ZM0RkodCME1VFs9eGN5GWnJZryM76pe/MRdhuXWlHC4CFfKcu93XruwBGgvmTe84/q3iW/FBX2iNKenQ4hJo8pIoQ2dq/lTm0OAtJCDkaHgzATtAa0mHkmaYqhXtHsw4cVgjBEBxmEUCwPCYuam52xzQ1v+BRnOcIywP0RfiwRdh1Js0edWAgOlWawDuhusgWGygiVv7iF80Rs9Hh2Ik0UiZyB2iiKELmPlLlVHPKLjj31njfetO50zrM6Sl/5F+JuLxh9s1pVJv8zIKAA8xzVxe4RXs/eUPI/Dr+3SUh97igPJpQuQbV+4RsYQ8vLng0bJd/pmKwm0RBuNEltKVEICB6rAbsZo8koB3emewYY1kxu9ZmtVYq+RvmyfwmL8k7YH9mP7ii4UuMDVdiKfWqQEvanpJR17oT6GQ5fK6arnoeR6Y+PV78SZIAXt3afVsQknPFtdpCkAL+cMd+7s+7X5Xv/TKdPbDvKofP+ZKP6HwHbZnen6QojLTQM8QX51D3NHtQeWs1RA3GSujUrjTcfTtmV5P3KNJhYdqQaOnzBhtSnCXjeoG9JIRNNRebpKPcdxyfBKxZm+Ulrnl7XG4BqNh4J8yLwSPfztjZ5hUsLom3UfazZZCFEx7ZtsbPHKuHH59vvFhurQ3DQZ+Dxjp6g=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DS0PR11MB8718.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(23010399003)(376014)(7416014)(1800799024)(366016)(18002099003)(22082099003)(11063799006)(56012099006)(6133799003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?clI0bjlMTUJOVFVrZVlGdmtaQ1ptdldmdExHUGpwekUvT2dmUXl1cVhsdFl6?=
 =?utf-8?B?UFhXVkUrbHh4T2RBY1p3S2h1RVk4VGZNT1FDYmRQSEg1cUxDQmVRVEU2WVFw?=
 =?utf-8?B?dmFQMmNNTGJUOFNlbHBLQVRGdmFCbEpqdlVwc0JUVjVrNGl0NEp2aVlKT1I0?=
 =?utf-8?B?MU9kMVFPKzVxRXJIcDh4SUZRM1VSU0UvcFZBa1NhUWluUE9Ha21scjZraXZh?=
 =?utf-8?B?RzlMU0pzdDJibjgxczVIdFdseCtmQmVtdEFNZ3pxeHlCUTNOR3NhUndESkc5?=
 =?utf-8?B?V1UyaExVQkl6eU8zYjNvRWZSeW5WVm5XdzN4aGdCMzVVb01FVXBxVHVkWDhp?=
 =?utf-8?B?dUkxeG5lWHZZOFZ3OVhFb3I2Mk9PMG1maTFpUWVUaHpPZHNuUmJxKzM5YlYv?=
 =?utf-8?B?eVowbjljdGJqNzdnVWJTNHBDNEJycy9QSCtYeC9VWU91ZnNtVlFZbWNpZGRh?=
 =?utf-8?B?Y0JrYmNNTGJYWmQ4L3k1MXdBc3MybnhsOVRDMkZmZ2ozbFk4a1V4ekJhbW0y?=
 =?utf-8?B?SHpkbG1jZlJ0T29wNnc0ZFlON0dPMjBmdmlCMU16N1BnT3A4VWp6NkNJSWpo?=
 =?utf-8?B?V1RzZ2dCTmpxSVg1c0w3QXA3c1ptWi9GRWdBS2tHb1R4TS9xbDdLbjBoSXhK?=
 =?utf-8?B?Q2lsQTMwZlJrNk0vM3FhUmk2V1JISjZ1L09UaFJyUENQRVNzOEhEL081T0FB?=
 =?utf-8?B?NmJ4SXgvTkxwR1V0MnltL2VXK21UMnRzZDFxb1Q2Q00rSjV3NUw5UW12ZDZj?=
 =?utf-8?B?d3drekVNSFFFaGlTdVNrTDZURm1MMmZtWUU5TlAwVG9mdGhxa3BNbEVxcWh2?=
 =?utf-8?B?dS9ER3U4Rkd3TmlyQnUrRXBtR05BSmtNWk9VWmFkTDQrN0VCd21XcGJHMXZT?=
 =?utf-8?B?b1M4cnBSTTVwdndXa3hhY0Rid1lySURlVXhjR0JkTUJtcXRzNHdWVUQxZ2xM?=
 =?utf-8?B?dFU2dHZhMjZ4aDR0SzlKZW5uLzU2UEtsaW5zUXdQQU1KMG5qL2dsWFhKZmxS?=
 =?utf-8?B?RlhXVWJadVJxQklrT0Qza0tuK0ZLVUJLYnNoZ3B0TTNqa0MxVHUxOWdyUVlN?=
 =?utf-8?B?VzBIMzBRbTlDUGtFUlBiSlowVjJOOEJRMEViQmNucFpqOTBCaUdxM3REeDFw?=
 =?utf-8?B?b3hkTkVOUkZKMUtNOVdlNzhseWs5bkJhTHF3TExoNi9VNTAveEVodS9oTmpo?=
 =?utf-8?B?eUk0b3VWNmtJcmpOY3YwRWUrV2FoYzJvbVp4OGErdTYra2YzdTBwcGxZcUgr?=
 =?utf-8?B?WlJXbmkySEVOUHNKSTY0MzZoSnZ1cWFBNkttTzBVMkIxSHAwVlUwMWc3M0lQ?=
 =?utf-8?B?TmVPOVBpTWYyUy9JdVlKa011dXdFTDl4RTUxVkRlQVcvMWNIVVAzRHhlajM5?=
 =?utf-8?B?WmI3NDVYMXpia1ZRczR6THMxbmtyUmhyTW5kVmRKazg5LzEwSjU0YjBoYjRs?=
 =?utf-8?B?ZzdWZGxXVWdBWVlVTStvNHhOYU1lNU5RMnpHTmlqamVMRUoyUExiNVJtZUFC?=
 =?utf-8?B?TUFjdUphV21JYlJkVWw4a00xbWZWRktrOXcwbDFIQlRrU3lmVWRDOE9tdnhw?=
 =?utf-8?B?amQzQUdXK1I5azUvTGpwSDQxdHNyY2ZKWE5IS09MVmUvZ0dkNWErWWUxUTBU?=
 =?utf-8?B?QlFZWDNBamZ3MENuL0xVc1Y5elhtaWRCSjlzbXJnbTF0ZFVyNjhVZEYrdktI?=
 =?utf-8?B?MDF1MlcrcXlFcFYrWnBWVWtyMHVMKzhFeHlxeTBqMW9OUHcybXhHOTYvelhl?=
 =?utf-8?B?bVBRazlvYXM1RVhCMmxHV2lMNWRzdzFpdWttajFoZFQ5bkV2Z3BQQ2g3NGVk?=
 =?utf-8?B?WmJ6dkpBTld6bFM2VnM5cHlWVjNmRFM4citXT1oyM1ZGaXBKdUNZc1N2ZDlw?=
 =?utf-8?B?Q2RjdVFMdFNyTFJCTTRsek1Pbm51QlQydUNxYVJwbjZrcjMyUkdZUTdXanpl?=
 =?utf-8?B?bnFBMWlRNmd6U2hMajArM0dvR2Qxdm9mWlg4MmI0cUFRVHZTeGRpNlRqMWJB?=
 =?utf-8?B?MzVoME9vMjE4ejg5djJHTWtnZkxsZ2cwTU9YTzl2ZmpOSGlPRytYajRXUTJ6?=
 =?utf-8?B?all1b09od0VXU0g1SDZKWEpQTHhyMHhTV0h4VU50QkkvVTExTFgvdmVDMnJt?=
 =?utf-8?B?Y29yczhCMVd1ZUswODZCUCt5MVRvUWcybzJ0M3NRRks5MXE1cFB4LzdTOXFK?=
 =?utf-8?B?ZitxZW1PMEVvQVFscWRibEVzWi9oR1FNQkhRSDJoeGg0V2xJa3VNV0pwVktQ?=
 =?utf-8?B?Z042b2ZQNVVndmVTNmF1MnFobThxTlVhMFdrQmltNC9XUFVEZGlaVHkycjRt?=
 =?utf-8?B?eS9HUTFwNDRNZWZ5bVNXUk82RTZObjhuK3VFVC91akVITlZSNW1FR25jZVdm?=
 =?utf-8?Q?qeWLSliOMSRVeO5M=3D?=
X-Exchange-RoutingPolicyChecked: LpM1iFWdiYHt+xB1488eqkhZZInY3PkkyweKdfOsC0BpvApVOGEIG/y85n55V/jFQNCmzweO/BcHgQAOkxxbs6Wz/j0BkGcdk8O0/jK1rRWbmGXN+4mM+bNmeVHMxOSq7T/O72TF0/rL/vUKpBVrM1C077+8+f2P7gur4w6Ag4V0hHdumSnc3/xZy+sKwJhqpHGsCw3yf4Cru78tUTK4dZ6aij/WwOGq4kwgILGPAjIUaXgo+7x4QQAlkHIfRCD5lYpvrcyVMyYynlOySmz366tIZ51qjB4ANlf0wJJv7/AXIn6V4Q1jaRfhr6zR57Dt5RU+YXTvwNUNn7hAu8ELKg==
X-MS-Exchange-CrossTenant-Network-Message-Id: f4226760-36af-47ba-db51-08ded2cc7dae
X-MS-Exchange-CrossTenant-AuthSource: DS0PR11MB8718.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 25 Jun 2026 15:14:45.9738
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: wHLw9OtpSr/LHMQojuGYQqBeuFmzlF+PU8R7il3BTbY0E9rDovUgkHdRECM7AjSWhRDdm/v188RNhPyM+1uKIIPe+bdwqgMh4TTVlM1hCm0=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ0PR11MB5150
X-OriginatorOrg: intel.com
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-1.66 / 15.00];
	WHITELIST_SPF_DKIM(-3.00)[intel.com:d:+,kernel.org:s:+];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_REJECT(1.00)[cv is fail on i=2];
	DMARC_POLICY_ALLOW(-0.50)[intel.com,none];
	R_DKIM_ALLOW(-0.20)[intel.com:s=Intel];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-301998-lists,netdev=lfdr.de];
	MIME_TRACE(0.00)[0:+];
	FORWARDED(0.00)[lists@lfdr.de];
	FORGED_SENDER_MAILLIST(0.00)[];
	FORGED_SENDER(0.00)[aleksander.lobakin@intel.com,netdev@vger.kernel.org];
	RCVD_TLS_LAST(0.00)[];
	FREEMAIL_CC(0.00)[google.com,vger.kernel.org,kernel.org,fomichev.me,gmail.com,iogearbox.net];
	FORGED_RECIPIENTS(0.00)[m:clecigne@google.com,m:edumazet@google.com,m:netdev@vger.kernel.org,m:bpf@vger.kernel.org,m:linux-kernel@vger.kernel.org,m:kuba@kernel.org,m:sdf@fomichev.me,m:horms@kernel.org,m:john.fastabend@gmail.com,m:ast@kernel.org,m:daniel@iogearbox.net,m:johnfastabend@gmail.com,s:lists@lfdr.de];
	DBL_BLOCKED_OPENRESOLVER(0.00)[vger.kernel.org:from_smtp,sea.lore.kernel.org:rdns,sea.lore.kernel.org:helo,intel.com:dkim,intel.com:email,intel.com:mid,intel.com:from_mime];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[aleksander.lobakin@intel.com,netdev@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[intel.com:+];
	ALIAS_RESOLVED(0.00)[];
	MID_RHS_MATCH_FROM(0.00)[];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	RCPT_COUNT_SEVEN(0.00)[11];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	TAGGED_RCPT(0.00)[netdev];
	RCVD_COUNT_SEVEN(0.00)[10]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 3ED696C6FC2

From: Clement Lecigne <clecigne@google.com>
Date: Wed, 24 Jun 2026 08:41:28 +0000

> From: Clément Lecigne <clecigne@google.com>
> 
> Commit 560d958c6c68 ("xsk: add generic XSk &xdp_buff -> skb conversion")
> introduced a vulnerability in the handling of XDP_PASS for AF_XDP zero-copy
> frames.
> 
> Note: Currently, this specific AF_XDP zero-copy conversion path is only
> reachable from the drivers/net/ethernet/intel/ice driver.

idpf uses this, too (every driver based on libeth_xdp in general,
currently these two).

> 
> When building an skb, xdp_build_skb_from_zc() uses the chunk size
> (xdp->frame_sz) for the allocation. However, napi_build_skb() automatically
> reserves space at the end of the allocation for the skb_shared_info
> structure. 
> 
> Most high performance UMEM applications use 4K chunks, where the
> corruption cannot happen. However, if the UMEM is configured with 2KB
> chunks (a very common configuration to maximize packet density in memory),
> a standard 1500 MTU packet will trigger the corruption because the required
> space exceeds the 2048 byte chunk size:
> 
> Headroom (256) + Packet (1514) + skb_shared_info (320) = 2090 bytes
> 
> Because 2090 bytes > 2048 bytes and __skb_put() does not perform bounds
> checking, the memcpy() writes past the available linear data area and
> corrupts the skb_shared_info structure. This can lead to arbitrary code
> execution if pointers like destructor_arg are overwritten.
> 
> Additionally, in xdp_copy_frags_from_zc(), the allocation size is set
> strictly to the fragment size (len), but the subsequent memcpy() uses
> LARGEST_ALIGN(len). This mismatch results in an out-of-bounds write of
> up to 7 bytes, which triggers KASAN warnings and is unsafe despite typical
> page pool allocator padding.
> 
> Fix the skb allocation in xdp_build_skb_from_zc() by dynamically
> calculating the exact truesize required: the sum of the headroom, the
> packet length, and the skb_shared_info overhead, properly aligned via
> SKB_DATA_ALIGN.
> 
> Fix the out-of-bounds write in xdp_copy_frags_from_zc() by rounding up
> the allocation request using LARGEST_ALIGN(len) to match the copy
> operation.
> 
> Fixes: 560d958c6c68 ("xsk: add generic XSk &xdp_buff -> skb conversion")
> CC: Alexander Lobakin <aleksander.lobakin@intel.com>
> CC: Eric Dumazet <edumazet@google.com>
> Signed-off-by: Clément Lecigne <clecigne@google.com>
> ---
> diff --git a/net/core/xdp.c b/net/core/xdp.c
> index 9890a30584ba..f36d1fb875ab 100644
> --- a/net/core/xdp.c
> +++ b/net/core/xdp.c
> @@ -699,7 +699,7 @@ static noinline bool xdp_copy_frags_from_zc(struct sk_buff *skb,
>  	for (u32 i = 0; i < nr_frags; i++) {
>  		const skb_frag_t *frag = &xinfo->frags[i];
>  		u32 len = skb_frag_size(frag);
> -		u32 offset, truesize = len;
> +		u32 offset, truesize = LARGEST_ALIGN(len);

I think you need to re-sort this to keep RCT, now that the truesize
initialization is way longer than it was.

		const skb_frag_t *frag = &xinfo->frags[i];
		u32 offset, len = skb_frag_size(frag);
		u32 truesize = LARGEST_ALIGN(len);
		struct page *page;

>  		struct page *page;
>  
>  		page = page_pool_dev_alloc(pp, &offset, &truesize);

BTW usually LARGEST_ALIGN() aligns to 16, I've never seen a bigger one.
IIRC Page Pool never returns a truesize aligned to a smaller value. But
if you're really able to trigger this, it probably does?

> @@ -740,7 +740,9 @@ struct sk_buff *xdp_build_skb_from_zc(struct xdp_buff *xdp)
>  {
>  	const struct xdp_rxq_info *rxq = xdp->rxq;
>  	u32 len = xdp->data_end - xdp->data_meta;
> -	u32 truesize = xdp->frame_sz;
> +	u32 headroom = xdp->data_meta - xdp->data_hard_start;
> +	u32 truesize = SKB_DATA_ALIGN(headroom + len) +
> +		       SKB_DATA_ALIGN(sizeof(struct skb_shared_info));

Ah now I get it: xdp->frame_sz doesn't account the shinfo for
single-buffer frames, only for multi-buffer ones. The fix looks correct,
but I'd use SKB_HEAD_ALIGN() since it does exactly what you're
open-coding here and sort the declarations:

{
	u32 hr = xdp->data_meta - xdp->data_hard_start;
	const struct xdp_rxq_info *rxq = xdp->rxq;
	u32 len = xdp->data_end - xdp->data_meta;
	u32 truesize = SKB_HEAD_ALIGN(hr + len);
	struct sk_buff *skb = NULL;
	struct page_pool *pp;
	int metalen;
	void *data;

	if (!IS_ENABLED(CONFIG_PAGE_POOL))
		return NULL;

	...

>  	struct sk_buff *skb = NULL;
>  	struct page_pool *pp;
>  	int metalen;
> @@ -762,7 +764,7 @@ struct sk_buff *xdp_build_skb_from_zc(struct xdp_buff *xdp)
>  	}
>  
>  	skb_mark_for_recycle(skb);
> -	skb_reserve(skb, xdp->data_meta - xdp->data_hard_start);
> +	skb_reserve(skb, headroom);
>  
>  	memcpy(__skb_put(skb, len), xdp->data_meta, LARGEST_ALIGN(len));

Thanks,
Olek

