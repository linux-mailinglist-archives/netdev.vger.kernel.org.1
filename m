Return-Path: <netdev+bounces-196360-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id EA5E8AD4614
	for <lists+netdev@lfdr.de>; Wed, 11 Jun 2025 00:37:45 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id A5DFD189E420
	for <lists+netdev@lfdr.de>; Tue, 10 Jun 2025 22:38:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D580C283686;
	Tue, 10 Jun 2025 22:37:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="hkg5iMKu"
X-Original-To: netdev@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.13])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 05A1124676A
	for <netdev@vger.kernel.org>; Tue, 10 Jun 2025 22:37:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=198.175.65.13
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1749595061; cv=fail; b=MbNHNxwP+hCi2YfRDhORuDJFnwj0KulV8SXNq1Bqh1Uq1XmsnOff/G7LTlAdZGq8Z0313wPLfcwXFKCLH0lUwrvWcyVOwTta5cmM/pyi4sV/yB0cruQ3/F70rN1Is/PqjinqlVtRFAYr0x4DAZWenMQiAkZdHlv+vksBgqc7T8c=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1749595061; c=relaxed/simple;
	bh=jL0pn0eJVSxrCpjt14cQ2lQmud6OFD2a9KIJaWpVaJ4=;
	h=Message-ID:Date:Subject:To:CC:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=sseINSbWGyYXxgtschP4KXsPeCk6G5xVuoJDW1/E87MN07Exwy8V9EQ5xPjxk5YR/Yn4wHybynb7+tswfb8yQwc9dwwY7x6USd1sCoxNSHhZslzEIuDEV5CeoG8DtpSptpaGtjydnTmBUcGouuVxdKewPii8rIsnBlVAce8LEr4=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=hkg5iMKu; arc=fail smtp.client-ip=198.175.65.13
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1749595060; x=1781131060;
  h=message-id:date:subject:to:cc:references:from:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=jL0pn0eJVSxrCpjt14cQ2lQmud6OFD2a9KIJaWpVaJ4=;
  b=hkg5iMKuAnY1vOCyBV45o9w8/QH+wRGu/PvO+qb4APsU8obJcPJOdn4F
   //kpy2gF55SyATnmzzmgf3Xjpqj24SU04dRkOvbCX0j18VY9RP4GvXwsS
   SAMH00Iy+ofbitHODbLiRX+y0rvdd79I+546LOMih4HxuKTiGFNudjpXY
   TzASpoHE/C42u6o0TSMGDmFwlvAilHBui1a5z+sH2fLuSzFHXDKRODt45
   6MlT+hL2lnkfLOJ4tbTVHrGU7P+ODdiIwqaH2sX1T+8eMrbJLGOjZJ/jN
   LVmjZ7TERDl/eyeQ79UIklnVLqU4fJIWjMCibHgfkP1xcwqaYb20LCgO9
   g==;
X-CSE-ConnectionGUID: vI4nKmtzSb+bfjC+/zyhbQ==
X-CSE-MsgGUID: KiVjSq4rT3KoWUXa+wij3Q==
X-IronPort-AV: E=McAfee;i="6800,10657,11460"; a="62760661"
X-IronPort-AV: E=Sophos;i="6.16,226,1744095600"; 
   d="scan'208";a="62760661"
Received: from orviesa009.jf.intel.com ([10.64.159.149])
  by orvoesa105.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 10 Jun 2025 15:37:39 -0700
X-CSE-ConnectionGUID: NM3LqmWDT+el0E3j7ZXHRw==
X-CSE-MsgGUID: rasJPU86QUuI3LyRi4IcLA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.16,226,1744095600"; 
   d="scan'208";a="146957002"
Received: from orsmsx901.amr.corp.intel.com ([10.22.229.23])
  by orviesa009.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 10 Jun 2025 15:37:28 -0700
Received: from ORSMSX901.amr.corp.intel.com (10.22.229.23) by
 ORSMSX901.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.25; Tue, 10 Jun 2025 15:37:27 -0700
Received: from orsedg603.ED.cps.intel.com (10.7.248.4) by
 ORSMSX901.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.25 via Frontend Transport; Tue, 10 Jun 2025 15:37:27 -0700
Received: from NAM12-DM6-obe.outbound.protection.outlook.com (40.107.243.56)
 by edgegateway.intel.com (134.134.137.100) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.55; Tue, 10 Jun 2025 15:37:26 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=TzFAp7v/qoqqY7XuJSu3adgucH6GSb+ijX5UY/s04Ip613N8CvnGzY0oKudjRwEw0UMiCxVE04Yo2eFWE+Uohuqzfzmo3zwBBTK/nT8vO+iSAjbwbHE7IrWq+aV8Q16FOPFSveemJWquUMug1ZabyD4AHrFIFjEZLh3rxEYjgYg8s3TIl5OEIlFXeR9A8QhEx8QX4I+wZlYjOMVGgBVhJ5+ps0YOKYZeRBzIYHIzaRlZDxQ4Gz5Mp8f+M00HXB9GtdxNl2mJQAuvZS+YRt/1EOgS+7xsteM9Owj1Rj0pyTq9L5vrKxWeKA1mLiXrYoBBcdcWOjDE6lfhNzUoxwn6iw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=PgtuHuTtFwbzi+Y5dvjaUSqYMEcLnIsUGrXDgxW9vdA=;
 b=WCZtkc6hrQJMIxJqV7zvsFq4z5PZUOX81AxbC3DR61voyCKRdfVanh1C763tjpRbjx5viZEjppBscUhpG2rATbDIw5QE1jjwC3R7AVcfpZ9gXVhZlbcDTF2lJNv1pY9cO4JNAWDUtBjnK2XBzu6aR4DtULB6PPDELGgKk2q6CUA3+W6Y3EZ5ycN5jbdAHZLF/v2W2fpWZ09OWGAI0IW3ooT8BUenS+pe3TyiFZca5fnZmFof7h6wiLb2FH084C4R0FBH+eHYqrLX6F3rN81hPj9egLQAABe+zYgSq7SHq2tcZ1I+wbPp7IDyoioCzPOmaLmYMD72b30Gro8WdNSB2Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from CO1PR11MB5089.namprd11.prod.outlook.com (2603:10b6:303:9b::16)
 by IA1PR11MB6145.namprd11.prod.outlook.com (2603:10b6:208:3ef::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8813.30; Tue, 10 Jun
 2025 22:36:57 +0000
Received: from CO1PR11MB5089.namprd11.prod.outlook.com
 ([fe80::7de8:e1b1:a3b:b8a8]) by CO1PR11MB5089.namprd11.prod.outlook.com
 ([fe80::7de8:e1b1:a3b:b8a8%5]) with mapi id 15.20.8813.032; Tue, 10 Jun 2025
 22:36:57 +0000
Message-ID: <6058f688-ad9f-40b6-90d5-78172b6950a2@intel.com>
Date: Tue, 10 Jun 2025 15:36:55 -0700
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net-next 1/2] eth: Update rmon hist range
To: Mohsin Bashir <mohsin.bashr@gmail.com>, <netdev@vger.kernel.org>
CC: <alexanderduyck@fb.com>, <kuba@kernel.org>, <andrew+netdev@lunn.ch>,
	<davem@davemloft.net>, <edumazet@google.com>, <pabeni@redhat.com>,
	<horms@kernel.org>, <vadim.fedorenko@linux.dev>, <sanman.p211993@gmail.com>,
	<lee@trager.us>, <suhui@nfschina.com>
References: <20250610171109.1481229-1-mohsin.bashr@gmail.com>
 <20250610171109.1481229-2-mohsin.bashr@gmail.com>
Content-Language: en-US
From: Jacob Keller <jacob.e.keller@intel.com>
In-Reply-To: <20250610171109.1481229-2-mohsin.bashr@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: MW4PR03CA0262.namprd03.prod.outlook.com
 (2603:10b6:303:b4::27) To CO1PR11MB5089.namprd11.prod.outlook.com
 (2603:10b6:303:9b::16)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CO1PR11MB5089:EE_|IA1PR11MB6145:EE_
X-MS-Office365-Filtering-Correlation-Id: 355e549e-cae0-41a3-d6c7-08dda86f4ebc
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|7416014|1800799024|376014|7053199007;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?QlFDQ0xQb000Z1lBVmZ0TXFVcllZN3NIUHpWVlF5TW51VkNEZWl1VTZtRkNp?=
 =?utf-8?B?R3ZVclZQSDA4SVRkTGhORTJEUEJQV3E0QWQwb1o5RFdjRkc2VCttM3FkSkhY?=
 =?utf-8?B?VG9STmxwU3dNQ1dVRHdqbUhPczBjMFE3Ym8zZWI3K1lMeEFyM1ZOaEtSSVpV?=
 =?utf-8?B?RGRBWTZxWlRKYlJhR2FKM2p2QzhFSUc5UVprVXM2V0JwVGJXcUt6eTdYckNj?=
 =?utf-8?B?UkMwY25Fb1A2a2JQbVhZSHdDSm5SZjIvNXdvNVFxVTh1akN1cktySHZHQzZL?=
 =?utf-8?B?QVAvUVVKMTMzb09FaExCOEF3Wm0weEx5MmtyRkRGLzhBUkYvaE45bXRVNEtr?=
 =?utf-8?B?dXZvNVVVbzBxbGNzczA0eDBpMlFETk5WUHlKbzNoLzM1WTh5K1RlY3VaaDJD?=
 =?utf-8?B?eDllSDIzM3ZzQ3BlMWtYWG5LRldCRzNPaVUzZm0wVU14dHA0SFRhVEovMUNM?=
 =?utf-8?B?OXo0ajIxaS9EQ2grRVFMNDNJSXV1M3k1OGN0U1diWDJPK3hobW1TTlNEenA2?=
 =?utf-8?B?N1dQQU9UVndzOXhhV2tqRFlaTllEVTY3SGlsbDNaTmV3OFZTRXNwUk5PK1JF?=
 =?utf-8?B?bEx2ZjdKUmtFYnl0Sjl1NXNSS3pFYjAyajJUZmt3dDdEekJ1MmxqUEpBYzhF?=
 =?utf-8?B?d3VNby9ZNVMzMnVWQW5ZL2RqRG5NYk50aTc4NE1WUjg1WGZ0ejhlanZuTytN?=
 =?utf-8?B?bGJvaXpBNXB5ZmliUWt3R0FZa1JOdEd0c0hjY0dENTNDbFl0N1g2WXg0MTBZ?=
 =?utf-8?B?OUZyRWJtRlRKTU5BVTJ5OGRmLzRwUCtQWS9LTHhJMmFQOFVCYlc1QUVrNkJV?=
 =?utf-8?B?T0NKUFo0SS8vRUx5NEFVRlBEQ2lpaGJtOGVON2Y5WlVwSmtZS0RRY1NTSzFY?=
 =?utf-8?B?c2c2a1RvVHI3c0Qyc1Y4RHhVemFuVEo2MGdtNVdIR3drak44OENOL0t5UzRE?=
 =?utf-8?B?YmNVbVpCQ0VnYjMzc0xlVFFEWlhGQjFOMUx3c3Q3SmZ4RWlrNFQyQlkvR1Rl?=
 =?utf-8?B?Tlc3TXZWaGVqQTJtSHVyemZmNTRzQU01b1lVazNJMC9LRmJQblU1UERGdW1V?=
 =?utf-8?B?RFllRS9xbWc5clR0aEVHQndCQlVVVmVOTy9PaStJbHdjUE9xK3B4WndjWURn?=
 =?utf-8?B?a2l5bXpnYms4ZFFWTE9ESGFyOVlGcHFNVk8vTStqVVY5YnpvbVBzUGZhMzEx?=
 =?utf-8?B?WFBQMkcxaTBhVURZUVgzdWI2bS9iV2s0K0tmeGoyVHFsZjVnRFN3MEFzYjRy?=
 =?utf-8?B?ZDBLQlpQYnVDZHBRK0ZlSG40a1IzQmVUdWNNTmRXNUhURnVQdGlHZ1BZRVho?=
 =?utf-8?B?NW53aTZwM1RBN1dscDUyN0Yxb1BZSlhHMFliM21aaE4ydkNNeUIrMTZ5alVo?=
 =?utf-8?B?OU40VXo2dGZBMVdPZUk1SWc1aFEzM2N5bnNpWmMyS29oSCtvdzdhTUg1TWt3?=
 =?utf-8?B?QlFiM2NNeU5iNkwxaldaYTl0Zm53d0RlSFhUdEhlZzlMWCtjeWdyZVJSMTYv?=
 =?utf-8?B?VWJ3eGRaVjNuSy85c2JoQ0pYWWQyOEdzS2IzMEdzdnZEbzhTbTlYcVY0YnFo?=
 =?utf-8?B?VUxzUkVJYXNHYjZMeEFBWHNjK2ZydmRNRTU5VVpOSk5kYXhVSUFJKzE1ME5o?=
 =?utf-8?B?MlRiV3FOYTFqaXVHYUVraTdYbHlraUtVbTJpN2w0akVTU25MTTFxUm9kYW9o?=
 =?utf-8?B?bDhLRm8zYjVBTHpYOFpmZHF4WEp3RG9GREkvczNVelJDNm5xd0lSYW5LSWxx?=
 =?utf-8?B?TW1lM1p3VDRJN1V2VVExRm9YUmhQUlVESkc3RTBQUjJHWWlUWmNSUUhYZkwv?=
 =?utf-8?B?OEkrM3BwYnkrb1dPbjdiRUM2YmxSWFFGTlV3aE90bkRSQ1RTOHU0K1pQVXA3?=
 =?utf-8?B?b0wvM2hKMjhQMnhZRFVxajgwbUJiMjVVZS90NnlBOEdlQnQzSTE0YWxaaHpj?=
 =?utf-8?Q?Ht43j9IdbCA=3D?=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CO1PR11MB5089.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(7416014)(1800799024)(376014)(7053199007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?ZGxBR0todDFkL0pNd3pWU3FLVUhlVmgxZ3BaYXVMSTZua2c3TXphWjkwWEpr?=
 =?utf-8?B?blBncnViRG5YU1NwUVJJV2EzalRHblpvNEZiRHBvTW5LYldhdW9HVmhxU05F?=
 =?utf-8?B?R2lNR3lKWmpiaVp0SUhkaDh4SS9OS3VSQm1KOXcwRFlvcTBDV0pRWHptdFRZ?=
 =?utf-8?B?MkVzSkN6WFlQT2pGd0VhY3ByeE5tSVBPQUtJMitBcC9OVzFBZVBxd0o0eFZV?=
 =?utf-8?B?TnRCbjVvWGRjNGEzbTRQRldIbGxod2NMSTJHWVNsczAvam9QbVp6OUs1UVVE?=
 =?utf-8?B?eVova2tDTVYrblpETVk3SndkZVoxUXhuaDZtdC9hK1diNGR4SHdiUkk2VHo3?=
 =?utf-8?B?K3cvaXkwTzZ5ZmQvWVI5RjlGM3JZZU5TNmVxUlpQYWNERTM5a0RhdU9WV1NI?=
 =?utf-8?B?ZWlOd05uQW1XenNuQ2dRZm94NndvREwzUTdKc3krNHZmUElNeTdpbCtDRTZv?=
 =?utf-8?B?RVJXMWRkZ2JNVWRXL3k1NXUzdG5nVzVFc2h5enJKWjR4WWdoS2pWNWRKT3JL?=
 =?utf-8?B?cUVuQUtlMTlITUN0ZmhNYW1iK1BMVjBEOVdiUnpuUXBqeTBGeFpLVHpzZzV0?=
 =?utf-8?B?cEFBdytpRnJnTkFvc3IrQ3JhVk9TamJBZm1GTXF6QXhaY3p5S24zRHJKTTFF?=
 =?utf-8?B?TUxTMlQxZmR5aEVJeURueWk2VTBrbmRIaTAwUmlsRzBkVDZ1eUJmSWhpS2NS?=
 =?utf-8?B?dVYramk2U3lkWWR3Q1hLZ2EvOEpMVjdTSzgwcTBrYzlqblo3Y1NURmJhUkYz?=
 =?utf-8?B?WWdmeGN3dEdGaExDWXoySm92Szh3NXRwaW0yYzRWK0JzdGJrV0tKc0hiaWND?=
 =?utf-8?B?dXloNEJyWWJtK3EzdGhSN2lKakJYUk9JaExrVDVGRnZJZE9WZmFJdmNqeGZI?=
 =?utf-8?B?b1JUcWpKWXF4ZFpNRG1PV2pmQzc4NDZMbzhEWlZFZGMwM2ZzeGYwOEdJOGhB?=
 =?utf-8?B?YWY3NVB2dm85VkZNK2crZU8vWWU4UzRmSGlyUVhkcnVUZzY5YWRIUU9FT1dx?=
 =?utf-8?B?amJSaFRlN0t0aUxrVkRaK3YvOFZGMXgrR3ZDWmVSaUNvQ1BTT3gwc3N1YVd2?=
 =?utf-8?B?UGxNNXkvU0xJb0tyc1BtNEtQeG11aWVyL1NoSC9zMFJBQ0dZMXk3THZVb0th?=
 =?utf-8?B?WXk1RHZRWmx3eURaUm53UXdtVldxNlA4Q2V2U21SaUZuQXVSNllsREZpUm5X?=
 =?utf-8?B?ZHF6WHlPVEFhRzNtb2hXenFzbjczbUY2SjVwSU5wekwzamVOWEltSGJ3T1lh?=
 =?utf-8?B?dUtBaHp3SkVGQ2ZuS2JZYXF0NjFHOG5jbFZIbnpvc1pibTBPOStSNXJZOWFP?=
 =?utf-8?B?NkdqTUhVcW4zQlZ1ZjVlK3lTNVRzQmg4cGlENEpjMVJKZW04MDlOV2pMa0ZK?=
 =?utf-8?B?N2NSUnM4K0phSlp1OGpLT0tZUFNmZjgvamJYM1lPRDhNbGlNUE5ZcjhjcjV3?=
 =?utf-8?B?RGhybEN3akNGVEZWdXhXOTFSKzlBYkQ1Qmk2TlRhS3dWMUtJdTU3RWdaUjFh?=
 =?utf-8?B?anlROFIzU3B0VFlDT0FYSVBScytTNjFiL0pSR0dWQmtkQm1CeUpTOURJeTlP?=
 =?utf-8?B?ZDBQZTZkdWh2WFBxTzR6WWFhbzhhTWNnbGNWR2xMblU3RVNvMUowRUlDdkxk?=
 =?utf-8?B?ZmJpc1BWL1plelc2MkpZb0ZvZ2g4WWVQQXhsL2NlUE84Y29YVXNsSHhZUTho?=
 =?utf-8?B?eEdWOU5GVUxhbHdEZFNURUYzYWtFeXVlTUFURktwKzZLUjUvbVNZSElGenFt?=
 =?utf-8?B?RnZta3FvWjV2bFJwUHk0Rkgzcms0cHdVYjhWaWt2aFFXV0JjWWhXaGR3Z3Yw?=
 =?utf-8?B?ck80SEJNUzU2VkZwUldIdmtnV01JTUZDQll6REltTlBOU2UzUHJwejg4djVw?=
 =?utf-8?B?b1I4bDIySk83TjByanhFV0hWRnQvMTA4Z0puVCszME5VYkEzY2xoejNkNnli?=
 =?utf-8?B?aTlQU3dPN3AreEZnOXhZUVZWWkNQell3aEpKWlNSc2NLb1pYQWhueVhzaVNs?=
 =?utf-8?B?U1NJZGdKQ2pHdnlKUjBoMVZwRkJjalh3L1E4UUx5NStRekFRUlBkYklWd0p3?=
 =?utf-8?B?aXYxSm9WYVVQNWFKMnBDazVxaTFBS0JCK0dlOFY5UlVTNjdvREcvSWU0YUtD?=
 =?utf-8?B?dGJRN2tucjAxR3NJWE9uaVh3ZmxLRE5NY3lHU0RtZ1RuNm1PaU1kTUc4dnVD?=
 =?utf-8?B?Q0E9PQ==?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 355e549e-cae0-41a3-d6c7-08dda86f4ebc
X-MS-Exchange-CrossTenant-AuthSource: CO1PR11MB5089.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 10 Jun 2025 22:36:57.5056
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: C3CxQFm5LRWiFmCWz0R8H8NC8+FtZ1BfJoSNfMfrVfAw9vKBLJc0x/kSTP+ayxulsqvKr1mWF8Rz5l1+U1qABxCKF+t9Lcsj6FNCUzPNGPQ=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA1PR11MB6145
X-OriginatorOrg: intel.com



On 6/10/2025 10:11 AM, Mohsin Bashir wrote:
> The fbnic driver reports up-to 11 ranges resulting in the drop of the
> last range. This patch increment the value of ETHTOOL_RMON_HIST_MAX to
> address this limitation.
> 
> Signed-off-by: Jakub Kicinski <kuba@kernel.org>
> Signed-off-by: Mohsin Bashir <mohsin.bashr@gmail.com>
> ---
>  include/linux/ethtool.h | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/include/linux/ethtool.h b/include/linux/ethtool.h
> index 5e0dd333ad1f..90da1aee6e56 100644
> --- a/include/linux/ethtool.h
> +++ b/include/linux/ethtool.h
> @@ -536,7 +536,7 @@ struct ethtool_rmon_hist_range {
>  	u16 high;
>  };
>  
> -#define ETHTOOL_RMON_HIST_MAX	10
> +#define ETHTOOL_RMON_HIST_MAX	11
>  
Reviewed-by: Jacob Keller <jacob.e.keller@intel.com>

