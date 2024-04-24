Return-Path: <netdev+bounces-90838-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 6DC8B8B063D
	for <lists+netdev@lfdr.de>; Wed, 24 Apr 2024 11:41:04 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 920851C21EDC
	for <lists+netdev@lfdr.de>; Wed, 24 Apr 2024 09:41:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 55FD5158D9B;
	Wed, 24 Apr 2024 09:40:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="Ia+Vs+rJ"
X-Original-To: netdev@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.14])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 47989158DA8
	for <netdev@vger.kernel.org>; Wed, 24 Apr 2024 09:40:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=198.175.65.14
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713951659; cv=fail; b=cOkKCn3hJutgXviR8cXjtYZb7JvbxWQKjrBDbrQHkRHvR0C2h+JR7lqg7mDeLtIZa3Ls4h5bhGhT9abcK2qvYgrvYifD8OWTPz08ZdMwIeSZ+htCqPqhn6Glb/m1TXmLzUgHyvWa2anhdXqJNkKs0Qn5VDtw35w2iq4xt0okXrw=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713951659; c=relaxed/simple;
	bh=Uh3ff7PLadEWE3MyIQsLJOjylW2C263hjMuKCRZhkJA=;
	h=Message-ID:Date:Subject:To:CC:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=uEa9rgDR+6H2NNtCk5qB5GfCk76dEcwUenfY5RZL8KPCokiAKmsbZbXW4H9SVp+EHRoD1CJ7J00zYLDriIqel/npKlQZuWBlcv46320iTl7jR4gLzhZ4Vz6FaJhqnIe32izQqpJFng/PfrIpxktw+aBLGJxd54U9yW+Do8BGp8M=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=Ia+Vs+rJ; arc=fail smtp.client-ip=198.175.65.14
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1713951658; x=1745487658;
  h=message-id:date:subject:to:cc:references:from:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=Uh3ff7PLadEWE3MyIQsLJOjylW2C263hjMuKCRZhkJA=;
  b=Ia+Vs+rJYOToQfjBiQD/7utsAi/FhwrDsdJwlL2DSNvK+m6AKpmSBb+H
   WzPen3PzDSc+SmodLsxAGX4DEmk29dGmD1Jcj2teiupUnE0kSaPrCpz78
   b898Ekd2x2a4JXDShqijnWB39reFkxhwlZl+qOfOeM+8CMlidHCoSP5pJ
   aPl/GCuPb+zc7jVA93VtHxaMe96oWIEwa7/8mIdt+GqdORPQiPrR11gK/
   S29rj9YZKfTiwmtTAxpE0VpFwxIhmIMqpEqAgxuJmnj/NpqIbxlq+BvFk
   rnUgzUrgzJGhDJH2sk+M5bbW2yDGxL8vypCJkfKA7BebFCmDhkuj9LJLI
   Q==;
X-CSE-ConnectionGUID: qbRvU/PtR1WYrdVek8G/8Q==
X-CSE-MsgGUID: rmOIhEo1SwGhcpIHJUA9jA==
X-IronPort-AV: E=McAfee;i="6600,9927,11053"; a="13407465"
X-IronPort-AV: E=Sophos;i="6.07,225,1708416000"; 
   d="scan'208";a="13407465"
Received: from orviesa002.jf.intel.com ([10.64.159.142])
  by orvoesa106.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 24 Apr 2024 02:40:57 -0700
X-CSE-ConnectionGUID: 0V8uY3NbQIuzssVOH4sLQg==
X-CSE-MsgGUID: OvxIRhuuR3mdMCVN7I9pDA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.07,225,1708416000"; 
   d="scan'208";a="55613750"
Received: from fmsmsx602.amr.corp.intel.com ([10.18.126.82])
  by orviesa002.jf.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 24 Apr 2024 02:40:57 -0700
Received: from fmsmsx610.amr.corp.intel.com (10.18.126.90) by
 fmsmsx602.amr.corp.intel.com (10.18.126.82) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35; Wed, 24 Apr 2024 02:40:56 -0700
Received: from fmsedg602.ED.cps.intel.com (10.1.192.136) by
 fmsmsx610.amr.corp.intel.com (10.18.126.90) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35 via Frontend Transport; Wed, 24 Apr 2024 02:40:56 -0700
Received: from NAM04-MW2-obe.outbound.protection.outlook.com (104.47.73.169)
 by edgegateway.intel.com (192.55.55.71) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.35; Wed, 24 Apr 2024 02:40:55 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=jo5qJ11TWxWuUOuEF2ZvcIsY8hSLWWSMrmhIlIYX6YMNF0fgLMSvVmHOv4NIa7CgC0GCcEalKm9gaUmV9MBDX5NdELBbz2aTl2lMOyw03CzOj1XgGEreQFqQ5uGNW8y5XAV58ipfrZNB+ah9f0ukUUoEz/IsjvMkluF+W4a/5AzmwtZWuX6PDnu0rICq7jp9HFEmUXYM+hVWKKBR/wZWHviMTMC1atuUYpYIA0xwCOLtVJ5uC8/kWtixDAXCUfi30PdQS+yweJPIPRY715Gr+CF/r4n0iddvNYxFbI/bo0GKY9qg+/3oZyb/nsWBLG170NyoonAOub/k8AuHyf9rlA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=DwS+Uowselfzc3NwjJvjpbh7m+zGq/LSxLeyEitqAPE=;
 b=XZth6xi+iuXrdAVZQ7f/An/HVi/YvQYcxzekYQem/HlpSG2VDUoxkUmnLKvE94jkQKsqkvIcAMq9eTpyWw9HWMRAjUVai6Q6FpsO+H1O6p3fpY/JPRACdDeX4DOZM9koWyZgw5DkCxwthP3BJro2wn59PV7ypPETKYrsAPoq2iFMvrPGheIQbXCOHwNA9r9RYxdvu3VPi+JzNrQq+MplNGvG5TWO70j7djK1FPXagoObVe+ezf44eOoMd1ewc15idvTH0sjTCMzst1x+xIlN7P9vRWP9xfFERg8xmWtJEvRgAcM376c7WsCSFQY7coLHEFWglZsagKYUoJ5PHgCjMA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from CH0PR11MB8086.namprd11.prod.outlook.com (2603:10b6:610:190::8)
 by PH0PR11MB5143.namprd11.prod.outlook.com (2603:10b6:510:3f::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7519.22; Wed, 24 Apr
 2024 09:40:54 +0000
Received: from CH0PR11MB8086.namprd11.prod.outlook.com
 ([fe80::984b:141d:2923:8ae3]) by CH0PR11MB8086.namprd11.prod.outlook.com
 ([fe80::984b:141d:2923:8ae3%5]) with mapi id 15.20.7519.020; Wed, 24 Apr 2024
 09:40:54 +0000
Message-ID: <103c701f-8859-4c8c-b340-5d3b5bcc94ba@intel.com>
Date: Wed, 24 Apr 2024 11:40:46 +0200
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net-next 1/6] devlink: extend devlink_param *set pointer
Content-Language: en-US
To: Alexander Lobakin <aleksander.lobakin@intel.com>
CC: Jiri Pirko <jiri@nvidia.com>, Mateusz Polchlopek
	<mateusz.polchlopek@intel.com>, Tony Nguyen <anthony.l.nguyen@intel.com>,
	<davem@davemloft.net>, <kuba@kernel.org>, <pabeni@redhat.com>,
	<edumazet@google.com>, <netdev@vger.kernel.org>
References: <20240422203913.225151-1-anthony.l.nguyen@intel.com>
 <20240422203913.225151-2-anthony.l.nguyen@intel.com>
 <cdd3d9d7-1b21-4dc2-be21-ef137682b1ea@intel.com>
 <fa6e7d19-e18a-4146-983b-63642c2bf8c0@intel.com>
 <fc3c9135-ad5e-4f32-b852-c08cfb096492@intel.com>
From: Przemek Kitszel <przemyslaw.kitszel@intel.com>
In-Reply-To: <fc3c9135-ad5e-4f32-b852-c08cfb096492@intel.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: MW2PR2101CA0013.namprd21.prod.outlook.com
 (2603:10b6:302:1::26) To CH0PR11MB8086.namprd11.prod.outlook.com
 (2603:10b6:610:190::8)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CH0PR11MB8086:EE_|PH0PR11MB5143:EE_
X-MS-Office365-Filtering-Correlation-Id: e030d999-b9e0-4bd4-9a4e-08dc6442a29d
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230031|1800799015|376005|366007;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?akc3KzdwWmNRMEVsdmd6T2JCUDFKa29NTC9LTkladWZxNUhLRUZSZFlYMWlu?=
 =?utf-8?B?cUVzQitGcS82OTdDbXRNOGVKVlF6aTV1RnZJMmYyMzUvejdxU3hNNE5iZm00?=
 =?utf-8?B?RTFxaThoNlMxNVFuQnFGWVlleTRxSVc5N3VleGFSM3QyTGhJVmRySmdUWHNQ?=
 =?utf-8?B?UzBYRVRSZ21adHAwOXVUVmIvbEMweGFWZWlHQkZwbFhXMnlUMEpNMmV6K3d4?=
 =?utf-8?B?N21HMS9VTlJBNnNoYWJoejZsaDlGUmFhbUtQT3hodmF6TTdqYkJ1VDZWbHdF?=
 =?utf-8?B?TU1QcytIMk4vZFdiM0dTUGhkUjlIcThQenp3MnpUS1hhanB6anY4NllTWTZW?=
 =?utf-8?B?UWFBZlpObmtvU2lyYVJ0R091RkNxVkMrMjE2R1RNS0p4VGs4cGZlU25OQ1Ja?=
 =?utf-8?B?UGZvSE9nZWlwb0V5cWdRZlJHTElZNUxTMFZlRE9GYnp4Q0lhT0xPT21JWXlo?=
 =?utf-8?B?R2Z4ek56eXU2U2xuSGZtRnFPTHFSbmlXYmVqWWw1NDJwTFZHQVp5Qm8yR01j?=
 =?utf-8?B?L3BoYnRGVnovUXM1cTVrVzRZUWtDWUZKdXlmalpoQlN6M0FSb0VnVWFFZ0Ji?=
 =?utf-8?B?Y1d3K29HVklqWW1xZTlrODEwSkVPNFJNMkxIZTBvRXdvOXlxeDRaM2R2a25P?=
 =?utf-8?B?WVlaUHdMOG5PMjhLd2FNalR5Y0g5SVU4dUcvN1lCbFlXV3k1TXZTKzZ1TElm?=
 =?utf-8?B?MEtwVWFscm5sbWhva1dSVENrTGpwQ0NzNXBwWFBmZGtFV0pYZnBBUHZSQ3BX?=
 =?utf-8?B?ZklPY2xJR3NNdHQ5S2tSWFZtOVQzak1UWXd5NVp5ejczZUwyRFZ2TWxnbk9w?=
 =?utf-8?B?OTBuVjdFRmh1MHppTzhCcXhLZ2dUOGpMMlF3bm0zeHppcnZ2RnQxRGlRQ1RO?=
 =?utf-8?B?V1ZyTEdLZG01NENOVGNwQ3puS3NDSEZ1WWZZMkRNa3J3RkVGTWVrUUcxZFdk?=
 =?utf-8?B?V3llYyt5L1RsaUxRd2hocHRwa2czc2ZNa2JUYk1pK1lBTlkxZEY5eDREL2hG?=
 =?utf-8?B?U0FzOWw3SVZQQSt4S1F6WjNwLyszTzFSTHdOWHpGWWdEZ2gzMDZmbWxUck1Y?=
 =?utf-8?B?WmJMdmQ5SVJ0RHNRNFZKdGp2eng0MVpEeDVaamZZTVpmNHJrOVIvV2dORlZX?=
 =?utf-8?B?RlVSVUp2aUV3MWVFUWZIK09OSWY0ZDM4dW4xRm1aRFhJbWhCMnN5SVRETUpQ?=
 =?utf-8?B?K3dyMlRHTGJkQXhmcU1ENkVKdFhBY3BkYjd5bCttVDJSZEJ6NUlPY3lKZit6?=
 =?utf-8?B?ZUp0Y3Q4T0ZjYTEyRDlabml3Q21uNldwTVh6STYwZkFkY2MxT01mNnl5OHlM?=
 =?utf-8?B?bU5iMnl0UitlTml0NXg2OFdweXBaSzN2NDgvaW82cXJaS0V4bXZVNGhLcW1z?=
 =?utf-8?B?YkNzSFRIdjFJN3h3eGVuZStYVVI3RCtNS3dYTTVtYkpaSGRLNi83N3lYbElF?=
 =?utf-8?B?M2VSTmJXOU9yQUtvclliSktHcFoyNnQ2V1oxWGwzODNuYUJpVE9XcmZnZmlF?=
 =?utf-8?B?ajUvTUlkN2JhNFMvSm1ER1dua1Z3azd1TGw0bmVDcWtzemlpQ0VhOFRIQW5z?=
 =?utf-8?B?Wk1kWkE1bkRBYU4ybC9VNGNYbGNVRnpPUkJCM2tLQ1g1QnMxVnB3UmVmRHc1?=
 =?utf-8?B?L0VzVm1ONTR1SEFWN1M5WlYzZHgxZUFUdHR4NTlzRGRXeDBURzJ4UkpkVmMy?=
 =?utf-8?B?RUxDWEFHQzdBU1hMQkNIeHlVazA5aHhveEFTckFyQkFaNUJWc1lyQzJnPT0=?=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CH0PR11MB8086.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(1800799015)(376005)(366007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?dmJkQjkzUUVpd3pCL1c4dXVrdnJSWjcrMVd3VW1iNWJuNEl4dEdRTWk5bXRN?=
 =?utf-8?B?V3ZXRUs5MzZlNEFqS0ZycktiOFB5SlNaUklkMGUzcG13SDhVVUhPSGxtRFlV?=
 =?utf-8?B?SVQySDBldlVYZkpqTFJIZVJydk5oVHhRSzRQOVpQZEFoUUJkVGdSVTNsNHhE?=
 =?utf-8?B?TFloQndLTzRwTUQ1RnR5RTRwZ2NLZGYvdnk3YXVTaUkrUW1ZaE5WWVFHR3lC?=
 =?utf-8?B?Q0FmTndFb0xzelp6a0lKOEhJNXBES0lDdXVnazgwRlgvMjNQa0VMNHQvbUI1?=
 =?utf-8?B?cTFqVDcwdUVTTnRRaTh4aUZrSHNQMFpzclc4b29Ea1pDTFBleU1ValpRU2pR?=
 =?utf-8?B?ZnRvd1lpZEg3SUhHbVliM1lUYXRyNW04bU9oTmpyRFArSzFiK0NoNnpRL2Vy?=
 =?utf-8?B?MzRaL29iVkJmVmllYmxtdlNkNDBVR2ZIKzM4VVBYeEIwTkNXRnQ5YTJ0L3dY?=
 =?utf-8?B?T0VVZHpkQWdmbThvVUdkU0hFeUQ5TlcrWnRhOGRWampzbXpsbDkxSldHTWdW?=
 =?utf-8?B?R0t2K3FwRWtUanZaclI5TFhEVm8rYnFqTlFOVnVVK280UCszcEloNmhMQUxF?=
 =?utf-8?B?Mm15QUlYOFVaVGh6UnBGQ0FGVmpua2tOVml3eDlad1dqdUtkSGQ2dW5jWWFV?=
 =?utf-8?B?b1JXc3l1V0kxTFgxdGxHTFVQNm1waVlrL09GRnorY0FEdnpDYTRmdjkwRGxx?=
 =?utf-8?B?VjRQaWtXOCtEcG9IRDNMalQvUk1qN2dLS2p0NHY4eXU4REprZW1GdDVqemI2?=
 =?utf-8?B?b3lMVjRRZ09GUVhIU3VjYkRDYWx6ZWdhZ04zdnNBRFdtUXJhMDJxSW9XSTFU?=
 =?utf-8?B?UnhTUWo1WnZ2dWl0eUROMDJUdzExNkRUTEQ1S1FxR0l2SFRUdXJ0ZnNyMTNl?=
 =?utf-8?B?ZkJBbWhxa1ZxTU5QTkxjTTg4bTV3Q0JNVWk4NW44RVNQSEZkV3dWVDQxZGlN?=
 =?utf-8?B?KzJjTDlQbnMvYVJFeXBCSHNOR1hFZUo2M2RyWU1UYm85cGlWWm9vSkhtQmRW?=
 =?utf-8?B?bWJ6b21XOCtiZ2N0YUE3ZFpXSzdFeUFpYlVaSzRSdjd5L2R5STlPK3E1eDRY?=
 =?utf-8?B?bGNwNk4wZStISnFjTmx1RUJGLzFaZzdNVTlZZGtmNGFYOEo3bzh6NklER253?=
 =?utf-8?B?WmErOHFUK1o2MmNRbkVFOHZiQmMzS1NvTGM2QitCczJKeXlVVGdmdVdyb0Np?=
 =?utf-8?B?UU1pdkFaY2RQb3p3L0RTZjRZam81S0FxdnBVSGxaMGI0Yzh5bFdEdTUraURK?=
 =?utf-8?B?cXFNVnRpRzNXV1ljOTJwdWlFbThTOHRiZXFoYzF1eFJyYkpNMXhzWUNEd1hw?=
 =?utf-8?B?aFk1VnNlNGVnWCtDUk10aGVXUGsxK2wrTG4xUGVTMFhDTUdtU0xvamVhZy9i?=
 =?utf-8?B?Vlk0U25MUWlIU3FDTFlxU1U0Z1RQazRPZjZ5alFlVEdRYlp3dUhIK1Q4bmhS?=
 =?utf-8?B?N0grdTdodG8wWHR2YlhOR2E4NFBQbWFETk9JbXpHRGtpL2hDbjZabFR2YmRo?=
 =?utf-8?B?YmVsbkFYbXBuNm1DaFNFMTltTTg0bXZyWmJvU3ByUGJ5bWhsZ3pNR0hhNFZs?=
 =?utf-8?B?UFM2cktHM1hnL1FZSXhvK3c4NFVJOEVCRFpBRnhLMUlvdEpKYW05WjFETHQz?=
 =?utf-8?B?KzlDVTFNMTNmWTVSREVOVEsvcW5XeDNhLzVmWmVscTcxQlVLNGtnQW80NTJG?=
 =?utf-8?B?TndxdzFkdFVsWnFRaG1OQ3g3WXBQZktiYm1TNjIzaVdWN3Z1K24zSDVSb2pn?=
 =?utf-8?B?UW9ueFlscVNESU85RGlWWldIRmNaOThDYitwL0lCUUNvLzJkVkY4S2Fzb0kw?=
 =?utf-8?B?eEF5TUJIODhRS3FpdGxBUUJTN0s1MlRwVUdLSnlna0d0YWd5NVZtZk9wK3I4?=
 =?utf-8?B?WHQxNERCejVBaE5tS0p5My83L0M1Lzg0VzJ3RGdtdkN6TStJaXRiWjl2bUVI?=
 =?utf-8?B?dHFVUU01ZUx0WEVWRlZ4d1FPck0zbEdrU3I2d3BNR29HL1hCMEpSZ2E3VFNM?=
 =?utf-8?B?dGZsd0p4Y2dyT3AyTVVFd05tcStpWXVVL0k1OVh3M0VoZVF4L056KzdhVFZD?=
 =?utf-8?B?Wkc5c1BtSzJnckNDSUtXa3I2S24vRUZuTWwxLy9pT2llcVk0bDJOS1pzT3dL?=
 =?utf-8?B?dGdwQTEyL05NZ2tSazdPRTBxT1FkT1ZZMmoyTkdWeEhIM3VFWFU4WjM1VG90?=
 =?utf-8?B?dXc9PQ==?=
X-MS-Exchange-CrossTenant-Network-Message-Id: e030d999-b9e0-4bd4-9a4e-08dc6442a29d
X-MS-Exchange-CrossTenant-AuthSource: CH0PR11MB8086.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 24 Apr 2024 09:40:53.9953
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: BUc7dkUt0tMXuzRlKt+dfegJhkwelfQji7oRTrry9z00w6jLr8r482aAICSykgdWq/cVwxVFxdsAkGHe9g3QbR4+snwRV0VMGiAi+K/C5qA=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH0PR11MB5143
X-OriginatorOrg: intel.com

On 4/24/24 11:24, Alexander Lobakin wrote:
> From: Przemek Kitszel <przemyslaw.kitszel@intel.com>
> Date: Wed, 24 Apr 2024 11:20:49 +0200
> 
>> On 4/24/24 11:05, Alexander Lobakin wrote:
>>> From: Tony Nguyen <anthony.l.nguyen@intel.com>
>>> Date: Mon, 22 Apr 2024 13:39:06 -0700
>>>
>>>> From: Mateusz Polchlopek <mateusz.polchlopek@intel.com>
>>>>
>>>> Extend devlink_param *set function pointer to take extack as a param.
>>>> Sometimes it is needed to pass information to the end user from set
>>>> function. It is more proper to use for that netlink instead of passing
>>>> message to dmesg.
>>>>
>>>> Reviewed-by: Jiri Pirko <jiri@nvidia.com>
>>>> Reviewed-by: Przemek Kitszel <przemyslaw.kitszel@intel.com>
>>>> Signed-off-by: Mateusz Polchlopek <mateusz.polchlopek@intel.com>
>>>> Signed-off-by: Tony Nguyen <anthony.l.nguyen@intel.com>
>>>
>>> [...]
>>>
>>>> diff --git a/include/net/devlink.h b/include/net/devlink.h
>>>> index d31769a116ce..35eb0f884386 100644
>>>> --- a/include/net/devlink.h
>>>> +++ b/include/net/devlink.h
>>>> @@ -483,7 +483,8 @@ struct devlink_param {
>>>>        int (*get)(struct devlink *devlink, u32 id,
>>>>               struct devlink_param_gset_ctx *ctx);
>>>>        int (*set)(struct devlink *devlink, u32 id,
>>>> -           struct devlink_param_gset_ctx *ctx);
>>>> +           struct devlink_param_gset_ctx *ctx,
>>>> +           struct netlink_ext_ack *extack);
>>>
>>> Sorry for the late comment. Can't we embed extack to
>>> devlink_param_gset_ctx instead? It would take much less lines.

So this one still makes sense.

>>
>> But then we will want to remove the extack param from .validate() too:
>>
>>>
>>>>        int (*validate)(struct devlink *devlink, u32 id,
>>>>                union devlink_param_value val,
>>>>                struct netlink_ext_ack *extack);
>>
>> right there.
> 
> We don't have &devlink_param_gset_ctx here, only the union.
> Extending this union with the extack requires converting it to a struct
> (which would have extack + this union), which is again a conversion of
> all the drivers :z

I see, perhaps when there will be a need for that, for now there is none

> 
>> This would amount to roughly the same scope for changes, but would spare
>> us yet another round when someone would like to extend .get(), so I like
>> this idea.
> 
> Thanks,
> Olek


