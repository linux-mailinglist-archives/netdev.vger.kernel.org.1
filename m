Return-Path: <netdev+bounces-123725-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 0BBA396647C
	for <lists+netdev@lfdr.de>; Fri, 30 Aug 2024 16:50:39 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id B789428462B
	for <lists+netdev@lfdr.de>; Fri, 30 Aug 2024 14:50:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 693811ACDF5;
	Fri, 30 Aug 2024 14:50:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="cX/XgVEI"
X-Original-To: netdev@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BD6691B1D63;
	Fri, 30 Aug 2024 14:50:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=198.175.65.19
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725029434; cv=fail; b=FuXxdvzvp7dhKxS9Pfl21RwCeB+2wfeo66Qt790Xv6e4jEG63dE+j9RIAysQBOExo/jzudanyxxOpvUkl13b67mXIMgsUKoZeKVEITFqGCpEt7D9N8F/SQeNpY3FThYDf4Lv2W/4SQbGkdvo2apAUDR+VJ+UHie6jkiPLUZH29k=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725029434; c=relaxed/simple;
	bh=TOQKJidb9Szxc+pZbTTyh0VVTxNUVmT+3kdPn6PfP9s=;
	h=Message-ID:Date:Subject:To:CC:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=f7/8yWw6YbN9FgqtDBsanvcdYCYYvMBieGtHtRGSu9O7cROolhsHN6yLXxvGLfzx+qq/UxRaLaNOIUpNnzirMLXAnumaHtfnyUkz6vNo09x6H4ZLRRTlynybrgiR/6BVW6oaj5ezUB7b7PXv+2Lh9Ibgg57OJCFHEWht9zTdR5c=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=cX/XgVEI; arc=fail smtp.client-ip=198.175.65.19
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1725029433; x=1756565433;
  h=message-id:date:subject:to:cc:references:from:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=TOQKJidb9Szxc+pZbTTyh0VVTxNUVmT+3kdPn6PfP9s=;
  b=cX/XgVEID7guAazmq/gQY3rnKSOFFEauT1Li6YE6Vm3DJJ6yMG166e03
   O6A5KdyX8sv9SiUgIRgBn1sYKjdO1Ti6hJGrhkcToU24EwVHRm0dMP3PP
   JQfykzyVplki2ihWZeeJiRrAFSKPRvsSPhir3DTUTjmBFSaSUHC1ow41w
   1rke1O0SESgy9nE7rDAWwzZwHRIvd9kwDEoQ8zb1w2eXCEvgdzMcD5/h1
   9P49f++uX7g0UqxHozSR1vhxAqKLdTZGtGEJfJDm8GigCT+GxYtAWmbmy
   MgTukqOGkAsSnMcbhqjFMYMQAX74b4RyGgx8jsAGLA5PCCh3h9AhEa2bu
   Q==;
X-CSE-ConnectionGUID: lKtLG4IhS7ixUe67S8DfjQ==
X-CSE-MsgGUID: yIjl8UHwQIyv5ro5GIagZA==
X-IronPort-AV: E=McAfee;i="6700,10204,11180"; a="23537548"
X-IronPort-AV: E=Sophos;i="6.10,189,1719903600"; 
   d="scan'208";a="23537548"
Received: from fmviesa005.fm.intel.com ([10.60.135.145])
  by orvoesa111.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 30 Aug 2024 07:50:17 -0700
X-CSE-ConnectionGUID: +z3RH4m6QeCj4InTVwQ3uA==
X-CSE-MsgGUID: 3S70tr6cTwihGDPuvub1qw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.10,189,1719903600"; 
   d="scan'208";a="68319418"
Received: from fmsmsx602.amr.corp.intel.com ([10.18.126.82])
  by fmviesa005.fm.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 30 Aug 2024 07:50:17 -0700
Received: from fmsmsx610.amr.corp.intel.com (10.18.126.90) by
 fmsmsx602.amr.corp.intel.com (10.18.126.82) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39; Fri, 30 Aug 2024 07:50:16 -0700
Received: from fmsedg602.ED.cps.intel.com (10.1.192.136) by
 fmsmsx610.amr.corp.intel.com (10.18.126.90) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39 via Frontend Transport; Fri, 30 Aug 2024 07:50:16 -0700
Received: from NAM10-BN7-obe.outbound.protection.outlook.com (104.47.70.40) by
 edgegateway.intel.com (192.55.55.71) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.39; Fri, 30 Aug 2024 07:50:15 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Ewrdv5qJdV7VKpmB2CnLGomLavarvga5thdQBoGqxm6chIpXAqSslj6i54xJIuuJAPTkJTzmYabexw2QgUINFNuGTlxvNTdqQEP8+xsPi6DDNqvonAe6s5bHg6zXUjRYc3AfgWAL8QVIDPUI2bmSbP8/Zo94n5CYZinWYc0KSVv8MhjJwjUPZvZU8CuifRxT/Wp5yx7DYwOO1FqC+nxMVoZsSBwghoojRcPyKlsdnjumt2GjMRfGdGtFOTV3QrxfCgeFYP+aqQZXHecKSJ2Ptt9KTdbHpvMQbO5wcuHzoZqKrXaTu48PB9mlb4kGJS20KcgRW5l8c6bT/3X/+AFhpg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Cv9oLiNe87giJzEvOUYsfd3upFh/2AV/045yKfgy2H8=;
 b=fyMzyWAo8h29Oo0+fr+GvbPfKOW36OJ/JcFb5u1moruT074aK3d6wPCZOkU+pxLVS8o+oJaWrL7Fx/wpz2F+OzreYViMsR4gOynyiD0CVZIaSqYI5TQC7JtHoqzj2tTUItygf/3Ntaypibnde8chn6wIN1jvoi6ZCQGlApTvDYzT8DqQDJ51EdnMP2KUkQZUAxPK7qbdUFqYNNsLwfs1eVAkqR40cqFA0lGmSNkl0aXHDnTqHq1llBssjEkwClra2XykTddKQx42jTXElqJBPEpxcMOakt6VsRYg3wbxzwAunbcFZCpUCx7DAFHdlI8NBcL6rWNXdoYpFCLVfApBGA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from DS0PR11MB8718.namprd11.prod.outlook.com (2603:10b6:8:1b9::20)
 by DS7PR11MB6104.namprd11.prod.outlook.com (2603:10b6:8:9f::7) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.7897.28; Fri, 30 Aug 2024 14:50:13 +0000
Received: from DS0PR11MB8718.namprd11.prod.outlook.com
 ([fe80::4b3b:9dbe:f68c:d808]) by DS0PR11MB8718.namprd11.prod.outlook.com
 ([fe80::4b3b:9dbe:f68c:d808%5]) with mapi id 15.20.7875.019; Fri, 30 Aug 2024
 14:50:13 +0000
Message-ID: <06acad9a-2998-4c70-b186-c37739473346@intel.com>
Date: Fri, 30 Aug 2024 16:49:41 +0200
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net-next v2 05/12] net: vxlan: make vxlan_remcsum() return
 drop reasons
To: Menglong Dong <menglong8.dong@gmail.com>
CC: <idosch@nvidia.com>, <kuba@kernel.org>, <davem@davemloft.net>,
	<edumazet@google.com>, <pabeni@redhat.com>, <dsahern@kernel.org>,
	<dongml2@chinatelecom.cn>, <amcohen@nvidia.com>, <gnault@redhat.com>,
	<bpoirier@nvidia.com>, <b.galvani@gmail.com>, <razor@blackwall.org>,
	<petrm@nvidia.com>, <linux-kernel@vger.kernel.org>, <netdev@vger.kernel.org>
References: <20240830020001.79377-1-dongml2@chinatelecom.cn>
 <20240830020001.79377-6-dongml2@chinatelecom.cn>
From: Alexander Lobakin <aleksander.lobakin@intel.com>
Content-Language: en-US
In-Reply-To: <20240830020001.79377-6-dongml2@chinatelecom.cn>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: ZR0P278CA0193.CHEP278.PROD.OUTLOOK.COM
 (2603:10a6:910:44::23) To DS0PR11MB8718.namprd11.prod.outlook.com
 (2603:10b6:8:1b9::20)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS0PR11MB8718:EE_|DS7PR11MB6104:EE_
X-MS-Office365-Filtering-Correlation-Id: 0bef3928-e3f1-4b9d-de6d-08dcc9030d67
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|7416014|376014|1800799024|366016;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?bk5MejIwSVhseGlVVUFDQnpyR0xPNXBzcTZZbmJCZmdvVmVnYzBTMUtaZnNl?=
 =?utf-8?B?MVZyR3pabHR5c090MURiWGp3U0htU0VoU0NHc2VmMU1hTU45NGh1dmlNbTZz?=
 =?utf-8?B?R2xWY1NZWWJVR1EydnBrNm9qU0g4SllQdXMyOGRETlpoM3dYcE56SDlxWk9u?=
 =?utf-8?B?Qm9MMDlzUGlaSXJidUNkQ3ovd3NyUVZuc1RFVmFGYVdETk9rdFRhY1FERGJr?=
 =?utf-8?B?Ni9lYUZCdk5BMjl3RFo4VjFua0YybnV6Z2JBZExtN2tIZlBBVi9BeFplb2Vt?=
 =?utf-8?B?VU43Zy9nNkFFa3JZTEF1UHorSkh5dnNwcVJkRThMOUFRbElGbkFKcGNld2Y4?=
 =?utf-8?B?UXNRNEMwcXBJWFJjMk9yZTVvejVvdm03TU9NUGtCaG9Vd0IrTWZqOVJRSmYy?=
 =?utf-8?B?RHIreXdoKzA4WGlqdlFnSHZVaGRIc0R4Y0ZvcXByL1QvL0svSHJJcWFjUThz?=
 =?utf-8?B?RmJIZ0M4ekFKaHBtY0tEYk1LZ3JFUTdKblcyc2E5ZHlWaldEd1paYmVnbXZ2?=
 =?utf-8?B?M1VmenAzenpSTCtqb3B6ZGFpK0pMMVhYL1g2bngvMUpzbUZuUWdYOFNuRjJu?=
 =?utf-8?B?T24xRkNLdkJ5ZmVGdVl2akE3d0JReGppRU1PNy9QQXJGUEl2UVJScEQxQVZZ?=
 =?utf-8?B?dUtTdEdDbnVMN29mUTdmbGRQRGVQenRpUjFCM1dwZXlGRlhrVExxQ1RYaS9O?=
 =?utf-8?B?a01ER2ZjeHZXSnczKzFITGFveXJDa1VvZDRNbHNSdTZUcTVwSXFLY2VVSU1m?=
 =?utf-8?B?Y216UENLbEpiZVBlM1owK2FoQkxUY0dkWlpGdURLeGtkT2ZwRUNnT0JZbnIz?=
 =?utf-8?B?WkNDbjl3WnNQazNPZXpENml5U21YNHo4dFNCdElMaUkwcUdrbzB1ZGYyOGtq?=
 =?utf-8?B?dG9OaWovaUJXUTVsWVlvSzYvb3JWaTNZMmhWbG9wNWdMNU9wSU16NXVkM3RR?=
 =?utf-8?B?LzJ4QU1Ud2NnRjV1TTUzSThPZ1JSRW1qZmNsb3EvcG1mWHhKZVNhMmhDV1F6?=
 =?utf-8?B?N0J3dUlaRlBxNytCalRUY1lOYmtPQVc2MjhmUytWQW1LajVHODZZNW1lb3BN?=
 =?utf-8?B?eVhLNDhReUdieWIxdnE4YzdoSFRSSnpjaWxhMVAxb1R2T2FkQXd6aE0yZnFL?=
 =?utf-8?B?MXFOUDVPTHpLa2FUNnM5aDNqUVIyWTU2LzYveUlOVjRsZjc4U04yMTJxSUpS?=
 =?utf-8?B?Y2N5cGpzY21iR3phYjBHUXkrMVlmdHJLVkJRa2dmT21TVWhWd0VqdFp2UFE1?=
 =?utf-8?B?bzBINVpqZXAwWHVhUnpZTmlTSEdoWXc5eTVyT2E4YVB3SG5NZFVUWlA4VEw2?=
 =?utf-8?B?UFFHcEtmQXo5Zk5kR2QrZ2pzN2JuK3ZDSFM0WTVsV0MzSXlVbUJRdGUyWG51?=
 =?utf-8?B?dExZZkdlYXNteS80OWZON3NPZ1d5cWMrQUlKMlVTRlRsR3lrYlN3KzlYSDJN?=
 =?utf-8?B?MVlOYnhmeE1qc3pFK1NDa3BvY2RRK0F0dG9RQWI4endmUGN6TjNnRTQ5bmZB?=
 =?utf-8?B?M1FRMDd4MDNlT052c1Q3N3dFZmJNTnpxazMxRzBoWFVCNnprSG1LQU5uOWV2?=
 =?utf-8?B?NWt1MjBidFE4Znd0NlMyUnJtQVdRK2w0REtENE5KZG1KREhJN25QUXVIeEZM?=
 =?utf-8?B?S3hoRDloVVQ3R29CZ1BzUUo0QytFcW5obzNJclBDbHkvc2JPMWJOeUljYXlZ?=
 =?utf-8?B?aXNaVHRZZUNkOFVyY1hEcU1tLzAxZSs0aHZMOEl4MlhwRlp1T0I0Nm0vd0kr?=
 =?utf-8?B?Wm1ObVE5UE9pc0duWW93RFZVRlMydnJRQ3FTcnk0WjdURTd6ZXRsdndiNUg5?=
 =?utf-8?B?V2FGSEZlQ3BkQytWNjFoUT09?=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DS0PR11MB8718.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(7416014)(376014)(1800799024)(366016);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?TWtaK3kvNko2TngvSUJPVFpIdXNPNWwydmZoVHYrUFJCaW9OdVdCeVNUNG56?=
 =?utf-8?B?VTBwY01QaTcrcGw3Rit4dXpITnBUOE4rQitFMnZwN1RRYWdqZndnU01jNVBD?=
 =?utf-8?B?UVVaYmttTEwyUkdRUTRqMzY1anJZY0lPcEl1c2lMSWR0ZEYxRnNKMDIrREhT?=
 =?utf-8?B?YmtqengwQ3hqUGxYMGFnYjA2QW9YUnc2cGhWZURIV2N2YUxGUlkzOE1vQkVP?=
 =?utf-8?B?NUhyN2NVZVhDUzBlNGhvUjkycDFvZ3VjS2ltdjcvakpRb041NWlLSDdYMzJ4?=
 =?utf-8?B?RXFqOU9EbEtKY0cxZUpLSEtrQkRzcW0zQ2MwODBxQW15WUhwSnhxTlIxb0ZY?=
 =?utf-8?B?OExWWGtCWXU0bENBakxoOEI2VWtVVlhiamlhZTVPQ1BsWFp0T0IyS2VEWXkz?=
 =?utf-8?B?NzVLSkZYVlROVzRZNDBxb0FyYnYwa3RucW1JNzhIcGM0QTM1YVRVZFBHVUt4?=
 =?utf-8?B?S1JqUFZ5aUNRWmNkajhQN3FDVkVBcm1NcHBBZmcyVXdGMU9WTmJ0TzdDdkVu?=
 =?utf-8?B?ZGZucTJWaWhuU3lDOFMwTTQ0MDFhZnhFbHgyTlBmR0VDdUJCMDNKUkNzZFpR?=
 =?utf-8?B?NjN1WTFsd3ZRZ2N0U1BBT3ZnRHY1U0RsL1dWNkkwNGZGcDNOaFl1MitCUUxm?=
 =?utf-8?B?SmQxSlBBSnVZMTA3aVFKVmtUUC96Ukk0d001YzVLYzVBbXI1dlM5dy9IVVQx?=
 =?utf-8?B?SGdXcmVBd1JuS292ZjV1cVd1RUpRWDErbEs4RHJWODh0K2FGYkNVbGFjVHhZ?=
 =?utf-8?B?WEtYbXFGclkvamwwbExyMWZnaW40dEQwTEFNWU9McmdKZHQ2SWZ0ajBRdm9B?=
 =?utf-8?B?OGIzd3VSZmZGVWtDTkFvRGJLYkx3TDVRUERtN2tMNmxVbXFVMFhYWFREUHZR?=
 =?utf-8?B?YWl2VjZCV3FNWFhoK1JlcTVYS2MxMUtnR2drS2o1cXp4NTh6SGVadXp2YWFs?=
 =?utf-8?B?dFBCczlYamFxOXd1Ull2WlNFV0xvemo4VzBlWWRoVEZoM25kVFVjdUxCcjl6?=
 =?utf-8?B?a2hxaGpNMnJXVmRWVHFEMkJ6T3BKQXIzVDBwZmhmUWZFUXd4U2hna0dKT3RI?=
 =?utf-8?B?c1NoMVB0eGordS84dG9kNGZUbit5WVRaQTlyRGJxRGsvcFIwOHRHZ3g4cDV2?=
 =?utf-8?B?SzUvb3h0blNDWHg2d1FCUllrcW4xT2RvcVpuRkNKKzZXMFZONnd3TXY2WFB5?=
 =?utf-8?B?RHp2akhRT21PTXBDVmFpV0owUHJBTmlveEJvVldqU2dQMUlMeUUvSlA5UGtk?=
 =?utf-8?B?aGJjb0tpc2tiZVZWVXErekZNYmIxdW5UR09CdS9vRnhtWXQ5dEVqem5nNTd0?=
 =?utf-8?B?bWluVkFsSXRKZjF2RU0xTFpMNk5ZSE01REg3b3dOYlBBaS93R0lHY280TFBN?=
 =?utf-8?B?YVM5QWx2bzFOZGEydHZPTEhzVE8xbXJLckljbGk5VE9LYnZweUFueVhHZ0Qz?=
 =?utf-8?B?Y2NXL0dIZGJaU3ZIaWcvbXRPeFJTSldXRE9xVm41ajJiM0NLMXExOVM2dk03?=
 =?utf-8?B?SmdXSjhqcDVlRnJHR3lsVHZyNWhyWkNLVnBxNVpHVHdpQXNCbk9UakNXUzdt?=
 =?utf-8?B?T1RTMU4rMEgwRGh4NjE3clF2eTJhRHpmNDU0UzdKalJ4YUgvaGlTQnJjY1Vt?=
 =?utf-8?B?OEM5MGQ4QXFGTHVxcHR2KzdILzZqd0hwZ3ZtaFdVRjNFeVhXQUN5K3RuR09h?=
 =?utf-8?B?bWM2Wit0VGV4Z2xiUmxEc0V3SDdtVVgzQ1labElMcUJpMlJhK1hrN21veWNC?=
 =?utf-8?B?aE5lZTMvMjNQSU9xVVVoVFhmZlhoR1hZa2ttcVlUS3pFSWJFeFVRdFJvSnAx?=
 =?utf-8?B?TmRKR2p5WVk2V1N0bk1ZblBZekFjWmRQN2VFdFAwOGVVVHduUXBNckN2bG5R?=
 =?utf-8?B?c1R6RnpJd0psd3ljZ056a1FPR3IzNVE5K28rRG10aDhOZkpSZ2ZPUlJZMEJS?=
 =?utf-8?B?MFdmQ1h2TXdsS3VHZC81dkxyRjdZdjk5L3QvTkc4QzhTOUxiblJKNWxHMSt5?=
 =?utf-8?B?a1BqRkdBM3d1cmZFVVpPQ09PbVRPelRMcVM2M3psMFV5Y014RzVVY0ZvUFhE?=
 =?utf-8?B?R0ZCY3pZanR5UjVrM0Q1dmx6MG4vUEVQeHZRY0kwT2hmWWJZaE04ZVNzRUNh?=
 =?utf-8?B?UHN0TFVUM0NNQzIxN2tWYjYzYnZHYkFSdVRjSU5ycUlzT2lNa0diNHI0cFdI?=
 =?utf-8?B?YlE9PQ==?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 0bef3928-e3f1-4b9d-de6d-08dcc9030d67
X-MS-Exchange-CrossTenant-AuthSource: DS0PR11MB8718.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 30 Aug 2024 14:50:12.9969
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: p0yqtitHC98euR5L9ygf0NytvoUavXpqc14zWXoUpMlCaSSsQUqqpN0Pj/E02cEMeRxOiEFSk7G0y9qdrvganvitPqDkwzuO+1eSYFD/HPE=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS7PR11MB6104
X-OriginatorOrg: intel.com

From: Menglong Dong <menglong8.dong@gmail.com>
Date: Fri, 30 Aug 2024 09:59:54 +0800

> Make vxlan_remcsum() support skb drop reasons by changing the return
> value type of it from bool to enum skb_drop_reason.
> 
> The only drop reason in vxlan_remcsum() comes from pskb_may_pull_reason(),
> so we just return it.
> 
> Signed-off-by: Menglong Dong <dongml2@chinatelecom.cn>
> ---
>  drivers/net/vxlan/vxlan_core.c | 13 ++++++++-----
>  1 file changed, 8 insertions(+), 5 deletions(-)
> 
> diff --git a/drivers/net/vxlan/vxlan_core.c b/drivers/net/vxlan/vxlan_core.c
> index fcd224a1d0c0..76b217d166ef 100644
> --- a/drivers/net/vxlan/vxlan_core.c
> +++ b/drivers/net/vxlan/vxlan_core.c
> @@ -1551,9 +1551,11 @@ static void vxlan_sock_release(struct vxlan_dev *vxlan)
>  #endif
>  }
>  
> -static bool vxlan_remcsum(struct vxlanhdr *unparsed,
> -			  struct sk_buff *skb, u32 vxflags)
> +static enum skb_drop_reason vxlan_remcsum(struct vxlanhdr *unparsed,
> +					  struct sk_buff *skb,
> +					  u32 vxflags)
>  {
> +	enum skb_drop_reason reason;
>  	size_t start, offset;
>  
>  	if (!(unparsed->vx_flags & VXLAN_HF_RCO) || skb->remcsum_offload)
> @@ -1562,15 +1564,16 @@ static bool vxlan_remcsum(struct vxlanhdr *unparsed,
>  	start = vxlan_rco_start(unparsed->vx_vni);
>  	offset = start + vxlan_rco_offset(unparsed->vx_vni);
>  
> -	if (!pskb_may_pull(skb, offset + sizeof(u16)))
> -		return false;
> +	reason = pskb_may_pull_reason(skb, offset + sizeof(u16));
> +	if (reason)
> +		return reason;
>  
>  	skb_remcsum_process(skb, (void *)(vxlan_hdr(skb) + 1), start, offset,
>  			    !!(vxflags & VXLAN_F_REMCSUM_NOPARTIAL));
>  out:
>  	unparsed->vx_flags &= ~VXLAN_HF_RCO;
>  	unparsed->vx_vni &= VXLAN_VNI_MASK;
> -	return true;

Also an empty newline before return.

> +	return SKB_NOT_DROPPED_YET;
>  }
>  
>  static void vxlan_parse_gbp_hdr(struct vxlanhdr *unparsed,

Thanks,
Olek

