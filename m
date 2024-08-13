Return-Path: <netdev+bounces-118019-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C80CD950435
	for <lists+netdev@lfdr.de>; Tue, 13 Aug 2024 13:53:36 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 2E1A6283EC5
	for <lists+netdev@lfdr.de>; Tue, 13 Aug 2024 11:53:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A2793170A2B;
	Tue, 13 Aug 2024 11:53:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="VfTDmoLV"
X-Original-To: netdev@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E01F91C20;
	Tue, 13 Aug 2024 11:53:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=198.175.65.18
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723550012; cv=fail; b=GnuTxU7WQSHTBW17SyZGpvIfAaatfdl77c8Q8S8KWAPBj+Hv1uKLAAh+LnOuvYPVJbrnCECmqLrpQ/SbQhFv87rwVuua4hSxth4QxTrqr14+0WdKdjvgr+dZPSEtAeHdnpYOq80lhq6Ff15HLPQaJbN+UydVaiYAQBFTetHvQHg=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723550012; c=relaxed/simple;
	bh=TrNJ453pgdO0CwmAI42+QRsbNJzrw0lVyWTkfmy+GTY=;
	h=Message-ID:Date:Subject:To:CC:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=SQjwZiSH8VjhATuhMVWdvfaSyNmVxKoDFUr99WSOwp5D+Bea/AZoV34YZPgg1DGXXIzuvuwNAxY5ALsU2mqjmhqeIJ4eBKLVmilEEloQYlhobhm8d4yU0mFnStRjVPxw39CRDw8Vh1GyquqmoTlbN+GDihcOiMIwgs1NoI8odV4=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=VfTDmoLV; arc=fail smtp.client-ip=198.175.65.18
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1723550011; x=1755086011;
  h=message-id:date:subject:to:cc:references:from:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=TrNJ453pgdO0CwmAI42+QRsbNJzrw0lVyWTkfmy+GTY=;
  b=VfTDmoLVcmLw5A4WGKRbrUKCwb7BGr2/0ectMXgBOYjXT0Ly05Ajg3cJ
   G3Qjjqst3Grf4r4HNtihhip79B8bSam9AnoH/2JexU44quk9I17D3z0v2
   P0PbiDeva37U2yWGSrJd2KxQMK0kLalSmTvKKhFCEJUje1k8ykMqdx4xO
   qBYUF2LtPs7hHdj8M1jn6eW1JOoPqEfVd2kspqihSnJiZ0Baol0vMixHy
   6kptumKusn0NOs63vJBSZDI4f9f2B5Ucl5CetEMef1BnBRZSsDhV4Ar5a
   ZNxrA/3a3ERvh4kRayCHBGXKsGZsOiLUBSVMVcNJ2bWkRttbPtir6a/Qf
   A==;
X-CSE-ConnectionGUID: 8AZjGpOqQnmjGYzAIyGuQA==
X-CSE-MsgGUID: 4xYO6LbaQza9supxQHyU4w==
X-IronPort-AV: E=McAfee;i="6700,10204,11162"; a="21851216"
X-IronPort-AV: E=Sophos;i="6.09,285,1716274800"; 
   d="scan'208";a="21851216"
Received: from fmviesa004.fm.intel.com ([10.60.135.144])
  by orvoesa110.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 13 Aug 2024 04:53:30 -0700
X-CSE-ConnectionGUID: aVw9nuLQTNa6Be7jfHs3Pw==
X-CSE-MsgGUID: bVnOoaP5SnuApB1fT0EgsA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.09,285,1716274800"; 
   d="scan'208";a="63326488"
Received: from fmsmsx602.amr.corp.intel.com ([10.18.126.82])
  by fmviesa004.fm.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 13 Aug 2024 04:53:29 -0700
Received: from fmsmsx612.amr.corp.intel.com (10.18.126.92) by
 fmsmsx602.amr.corp.intel.com (10.18.126.82) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39; Tue, 13 Aug 2024 04:53:29 -0700
Received: from fmsmsx611.amr.corp.intel.com (10.18.126.91) by
 fmsmsx612.amr.corp.intel.com (10.18.126.92) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39; Tue, 13 Aug 2024 04:53:28 -0700
Received: from FMSEDG603.ED.cps.intel.com (10.1.192.133) by
 fmsmsx611.amr.corp.intel.com (10.18.126.91) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39 via Frontend Transport; Tue, 13 Aug 2024 04:53:28 -0700
Received: from NAM12-DM6-obe.outbound.protection.outlook.com (104.47.59.168)
 by edgegateway.intel.com (192.55.55.68) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.39; Tue, 13 Aug 2024 04:53:28 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=g64/pbE0uvnDeHWKuGMgv1p7IcWHSV9sxHJxTjJt1akVMIIfe+N1zWIpv2UE/pih0rJlea2nE8XQwQw/v5oaiYTQNxE4X7naSz/yIUVLG9n42qSXcBZWyLl1bdph1WJqyqKkuq5IxW1LUlWU8+PAabK9vC93kn0iAKkKlpYyA31IEWU7c/rzBdYcuntM73y1f4eS1Rrcce0d5qmJscaBeyA49+wiWuQZkpztbHKTNZizgFHTvzFfukQp9OsE7bVjAvSQA2dHQVTWlfY0HouZJGxZNsec+VBBxTUB1RbP5R9eVxMyGFCCXcvjSn8ofO+kaLqUMDy6kH6mM3CX/VJJAQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=GQKCy8E36gnxXJsyvU95F2ihFKUxa86Yg4gWF+cP4tA=;
 b=Cord8QUFRVCl8SsvrQ0C+vSc6vnrHYgScCzsy9qvk09u9T84wC7BVI4eIjVM/cQxzbXFFug/+jJhW2XVXA1Ti6mkZhTB6dDldHprLuunHbDE+KUa1I6wEhCjVZ/yRBLvV571zuqwuI5vJzLkj2jyTJgcOJKyzwEiDG99tF+HRVmtYS16PVfoumEJgUovx43SJhD4mJK90hrZV6orlrSJug2iZ9lVszmhXmDjXVuein8fNX++LmMmhUWm9Kui03Du6n/j4TbdGL05YHt1UJuA+dDAtFV30FmYRnqGkWEm3rUs/4NMHWbO4vn2gEA+QwcQ2spq9w7S8UXBdy6t6w9lHA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from DS0PR11MB8718.namprd11.prod.outlook.com (2603:10b6:8:1b9::20)
 by MW4PR11MB6569.namprd11.prod.outlook.com (2603:10b6:303:1e1::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7828.33; Tue, 13 Aug
 2024 11:53:26 +0000
Received: from DS0PR11MB8718.namprd11.prod.outlook.com
 ([fe80::4b3b:9dbe:f68c:d808]) by DS0PR11MB8718.namprd11.prod.outlook.com
 ([fe80::4b3b:9dbe:f68c:d808%5]) with mapi id 15.20.7828.031; Tue, 13 Aug 2024
 11:53:26 +0000
Message-ID: <0a73afa3-f834-4b77-9762-6431cd40f3e2@intel.com>
Date: Tue, 13 Aug 2024 13:53:20 +0200
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net-next v3 1/6] netdevice: convert private flags >
 BIT(31) to bitfields
To: Jakub Kicinski <kuba@kernel.org>, Kees Cook <kees@kernel.org>
CC: "David S. Miller" <davem@davemloft.net>, Eric Dumazet
	<edumazet@google.com>, Paolo Abeni <pabeni@redhat.com>, David Ahern
	<dsahern@kernel.org>, Xuan Zhuo <xuanzhuo@linux.alibaba.com>, Andrew Lunn
	<andrew@lunn.ch>, Willem de Bruijn <willemdebruijn.kernel@gmail.com>,
	<nex.sw.ncis.osdt.itp.upstreaming@intel.com>, <netdev@vger.kernel.org>,
	<linux-kernel@vger.kernel.org>
References: <20240808152757.2016725-1-aleksander.lobakin@intel.com>
 <20240808152757.2016725-2-aleksander.lobakin@intel.com>
 <20240809222755.28acd840@kernel.org>
 <26db3c81-5da6-483a-b9d0-6c9fcda5c5c0@intel.com>
 <20240812110413.2ed0d275@kernel.org>
From: Alexander Lobakin <aleksander.lobakin@intel.com>
Content-Language: en-US
In-Reply-To: <20240812110413.2ed0d275@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: MI1P293CA0005.ITAP293.PROD.OUTLOOK.COM
 (2603:10a6:290:2::12) To DS0PR11MB8718.namprd11.prod.outlook.com
 (2603:10b6:8:1b9::20)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS0PR11MB8718:EE_|MW4PR11MB6569:EE_
X-MS-Office365-Filtering-Correlation-Id: dbd099a4-6cc1-4ddd-481f-08dcbb8e8a9a
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|7416014|366016|376014|1800799024;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?SVJRU0s3TUJDeGlOWm15TzBFOGdCODZsZm5ra3I1QzhyemtNcjgzbFhqK3B4?=
 =?utf-8?B?M2pGK1oxWUxndEdtUFByT1YyQUQ3Wkw4NmhtV050QXN6NmRRTkZjK25TU3Ni?=
 =?utf-8?B?TGljY0ZEeUlJRlVsZW42d216UmdvbGs4a09oUkJtWHEzSlprN0FNcHk3N0ly?=
 =?utf-8?B?WGZveXorK2NtdzQ1RWN0ZHBGSFZzZUNwcjJsdmxkNDg5MVVpMENzNWZRNUx0?=
 =?utf-8?B?am0wOUsvS084RXh6V0JZZnFxMXptYi9jUWFYejJwbEVZak9XMytueTh3ejhn?=
 =?utf-8?B?TTJXeHRCRzVuQXFYVXJwQmJPZzR4S2l4ZXJLWmF4VXV2dnBueWtnd3ZIYUVD?=
 =?utf-8?B?WVV4S0hKdUx2WXhXZ3BuZE9GZzlsQVBzRDVueGsvMndxcHZBbEliT0w4Q2ZJ?=
 =?utf-8?B?anFwSTJNNEZRYzJ3azhLck9ZNWVrUkYwczlwZ1h3WHVCbzRVcURWUEhvMG1V?=
 =?utf-8?B?WFR3NitSOVY2NFBWMUw1cmRIdFRVQzNubzFlSUYxR2RwU2UrNktZZjU1YlNz?=
 =?utf-8?B?c1YrZDdJNUpoYUhXZ1F0cWt3TC9yMFE0TEorVFM4TDg4RG9mcGdnZkcxMmJF?=
 =?utf-8?B?SDBGVTRxbC9vTHdDeWNpOGZXalZkZTZ1NFQxRENVNU1aT2cySlIzeE5IeGhs?=
 =?utf-8?B?K0NVSnNhRy9OMUZhT2p1cnpJYkZrUzc3L1BlZ2NuOElVdkhDdmpnZ2dXN3JS?=
 =?utf-8?B?SnV1Z0tZSEgwM3JNWXo5NEN6d01LL1pGdWdCMk4yNmM0M05yTG1pdUpaRlQ4?=
 =?utf-8?B?Q21KQzBGRlF5SEpBNFU5VTBvU1BsOWRPYmlhTmRhZ0xnRzV1MG5RdTlZUENX?=
 =?utf-8?B?S21valQ0NTMyL08yWHdhNzd2MGlwb0srRG9ieFFYc2t6MUdCUmJpak1Oa1Rw?=
 =?utf-8?B?cUhLZ2pXWXRoamErSHhMMDNuU2VGclJVQmVYdEQwV0hNTUN6RDJ4aDVFRUh5?=
 =?utf-8?B?c3BrOVU1K1pnclFuS2U0RFY0TGFEVlpzQThnNmxyZXVyMEcyU1hIYUxSWm1D?=
 =?utf-8?B?TG8zd0xTUUNuaGRUMnpsdUkvUUttcUZreUtvYlhzSHJpNHNBTkdLMFQybzBI?=
 =?utf-8?B?VWwrcTk0bWpYMkdqaGl0Z3M4WThTTTlDd3lyL241YUhGS0cwNVJHTmphM1Zk?=
 =?utf-8?B?ZmxSOUJQcEI5V2oyOUZNMzBEd2lDUFBUVStUdmFMZkpIelVrdmxXcEJXV0Rh?=
 =?utf-8?B?M3l5dzA3d2NVUkJzUW16eUlDaElzdG5KNldjcUh3RTdtUnlSSlE2NkdsbTRm?=
 =?utf-8?B?SndzY2txOEduMEFmMC85QWhBWWJLL2RaZWovV1NrdjFiTTM3VDJzYUdQZ2Jl?=
 =?utf-8?B?RXVDbFoyYWNXNTR1UGduYzBHMlhyd0FrSlUxamkzZ28rQnFWV0wrWG1RMnJB?=
 =?utf-8?B?MThWcDVaeS9BTE9TYVB5alFMOFpLR2dHVnBrWWtMRjgyS09RMEs3c1dWRlpu?=
 =?utf-8?B?SG9zWVozOWpjTjBIWnU1WkUzR05PL1dsSWU5akxPRE9DcEx1cFJSTGQ4OGd5?=
 =?utf-8?B?cm5BYzk1Rmg1cFY0T2RQRzN6Z0owb1RKZFFKUWRFMjdWa0dVL1YrWk5aeUFM?=
 =?utf-8?B?cUM3Q3I5YUNyajNka0tWTTdYVEhDWkdaU3h5Y29YYzQyK2VZMUF3NmFPWmFG?=
 =?utf-8?B?UnlYU29EU1Rpa2FwNmFqMTMrcUlKWXB2MnZuQzluTjZ5WVRGTDM5dTVDbW8y?=
 =?utf-8?B?cFQ3VjVaNk1hVlNPWWYzb01WcE8wUy9TOW5SVkxobG93Vm5PUWRDNEkzRTU1?=
 =?utf-8?B?SFlMWFpMektORG9lTVJGSUloWHd1SnU0UmEwL3RJZUZzNVQ4VHd6OTlQeDhm?=
 =?utf-8?B?b2hHVUJXbktYQUl6Sjlpdz09?=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DS0PR11MB8718.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(7416014)(366016)(376014)(1800799024);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?MWdUb24za3VVY0QxeHo5eDRtYjg2ZThneGU5MDVkTGVDbjI5ZmxBamFOYU5Y?=
 =?utf-8?B?azdXNTZtOENlTWZIN3FhOXpOOHBnRjdkMXJTWFJxWEd0dTVMcXpwOEJIV3N5?=
 =?utf-8?B?YXFKVXZhZDFkbXh5L2hmMjRxU2R1VXdqNkNMeUFLbEw3WUcyV2lBR1h3WUJr?=
 =?utf-8?B?NTY2aHhVcXl1aFZCU1VaSGZqYktVSDg4cGN5T0Znbk5hekV4NEdYdUxGbVJD?=
 =?utf-8?B?VjRNSlh3LzF2ZDVWL2xrUWx2STZQRmRLWXhkbjVzSVRLQmZKSTZhZVFFckI4?=
 =?utf-8?B?OTBUbEVMWldBNU9DYWR2VDVPZDNYeGxOWk00TlA3bmNDMkNTTWZnQ1hHVE1l?=
 =?utf-8?B?M1B5WnZNN3hxV2FlY3FIamtVRzZob3F2VW1pTTlQa1FyZjBNZlhlM0ZQbHJ0?=
 =?utf-8?B?NjZ0NmZKcGF1blhzS3JYZnBPakFPcm5GUmN2Y0hLWCtObm9zVklNdzMwYnNl?=
 =?utf-8?B?MHdRWHVVZERsZ211OE1iNzYwdFJRakJQQ3dGQ1BCN29qeU1lTW0ycmU0MDA1?=
 =?utf-8?B?MVFhTWR2OGE1TFNMMkFWa3IyRE05SWFwWE40aVZ5c0JqejdoVU9OeTIwZUwy?=
 =?utf-8?B?Y2ltK0NFYnBsSUdteTFtbkJpYWROSjFtTkVNU0pXVjg0bStYYy9jekl2R0Yv?=
 =?utf-8?B?c0pCY3AyVEZWTXArajlNN1BEYnRRL2JidElVczRWck4rT3hmS1YvbmhQTUc4?=
 =?utf-8?B?dks3Y0toMERtRzJlUjZzYVd3c2YyRklGem9zbUNCV0wwQ1dxY1dLOC9zV243?=
 =?utf-8?B?a2UrWEh3Z1dzVjFKcDNiUndFT3I4eWg2UkpvL3BsenU0aFcyWkkzR29HaVRi?=
 =?utf-8?B?TThXUWtrRmN2Z3YvYmNsbHFpdnA1OU8zZ1Q5bHA0eTZnalhESGdwMUx5d0V2?=
 =?utf-8?B?aXAxRmpMazlZOTE1Rzdaelo5dkFKVFhKNzZwbTV2cXhNZUxrYmt0Nmx1a0Rk?=
 =?utf-8?B?eFlMWS9zRFV1S3ZrQWZlTmJaWUdQKy8yVHJ6SEl3SUpUalMzd0g2WVZ2NTM5?=
 =?utf-8?B?MW9PRkVHY3p6Y3FNRXJxT3ZKK2pXRVZCcEVIVlRGUzlEaUtTbmNxOVBJamV6?=
 =?utf-8?B?Y01IWHRoV1lvZkFQU1BlVGhrNmlNeTFxcmwxckZkcm9JbjUrVmlyZGRJSEht?=
 =?utf-8?B?T25UNUhNMW5Cb0F3R240ZVNXcTBXRWgzS04zclNhV0MwQ3JiR0JGKzk0YXVS?=
 =?utf-8?B?azR3SmwxcEg0d1lsTU8vRDAzSUYwc3VjQ3RKNDFMZHlZSnRJYnZUTlFUUWdn?=
 =?utf-8?B?STQ1QnJ5V2FQaVZQTi8rbkFrVDVwc1FZL09yUXpDWmFRa2VRWUU5b2xnN0dW?=
 =?utf-8?B?UVVaSWJOYmM3d1NRaTFBRmJJU1k5Nks5VGhObHZqZFpDZ2pBUiszN3RKNmNI?=
 =?utf-8?B?UEhEdDBBT2FlRjBtYnl2ZFByWWFqUGpRbFlCbVZjcm00dWVPM0VWVGRIbXdB?=
 =?utf-8?B?SnJ1eFhFb2dkczF6N3lWUUxnT0ZkV2VQMnRQUXN2S1p2VVlVQytZNkZjbm1p?=
 =?utf-8?B?OVAyRnZyWWo4OVBINzRIbkNFK2NneXdId2tZZERsMWRaS3N3dkVRR3EvMnZR?=
 =?utf-8?B?ZHI4ZEx3V0JJVGUzYmRsUEdYeDNKWDdkUjhnQUlxZDIxWlpjdlhoR2JzcUVS?=
 =?utf-8?B?dUpRZXVxQWdHQkJNTVZuQlNBcTZhY3NGK1grYkJxRGx4TEZ0dTFRUzcyMVoz?=
 =?utf-8?B?MGo4WVIxMTRvNWdrOFZhcEJBektwSEFNd2tpYXlrUndHNDFtc0lEWUhaS2Vu?=
 =?utf-8?B?K1cwNjZ5ZWJzQUtoSXB5OVYxS2dBdFhpWWo3a1QxeHUvYU1FN1Zpa242OUZL?=
 =?utf-8?B?TXVNc3I5TFRZWVFpdjZLYUdLSG13S1hQcWpmdUhscWtDT0REL0VwcE9ESmpa?=
 =?utf-8?B?eFZnV3pnUTl0ZjdxcWpMR0hiT1o1a2o4Y2UyNUlvaGxkSEQrVmxwTkZUNWFB?=
 =?utf-8?B?TTJJenhuQ3dFUHZhMXBGLyswSTltazB4NEhHY3Nzei9oMFhQNUZoa3pvbEJT?=
 =?utf-8?B?UkRuZkp5NjdJVEkxZk5TL1l6d0RCTEZ0RlJGN0h4RkY5blR1eEtYN0h0TkZE?=
 =?utf-8?B?OXhGNGttQTUzTVUrWldXWVlGKzVFbGlKWDh3WTZicW5hQnIwWnllTXdtVTl6?=
 =?utf-8?B?NStuSkNnejh2YUE0b2NqSWVzcGc2OG84WkRDb3JmcnpOUzZMbUx3R1pCV0hn?=
 =?utf-8?B?Rnc9PQ==?=
X-MS-Exchange-CrossTenant-Network-Message-Id: dbd099a4-6cc1-4ddd-481f-08dcbb8e8a9a
X-MS-Exchange-CrossTenant-AuthSource: DS0PR11MB8718.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 13 Aug 2024 11:53:26.7201
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: A4pIqOXqyd3FBAJGkZe0TZLAQJbZxIEHefdk6aOLxNwMmyY6QpsQG09WMHdKCirzc+tOIx8mJnhFQwkK/IyS/9svSxvOGycZEzyDyHxXxEY=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW4PR11MB6569
X-OriginatorOrg: intel.com

From: Jakub Kicinski <kuba@kernel.org>
Date: Mon, 12 Aug 2024 11:04:13 -0700

> On Mon, 12 Aug 2024 14:09:31 +0200 Alexander Lobakin wrote:
>>> The kdoc scripts says:
>>>
>>> include/linux/netdevice.h:2392: warning: Excess struct member 'priv_flags_fast' description in 'net_device'
>>>
>>> I thought you sent a kernel-doc patch during previous cycle to fix this,
>>> or was that for something else?  
>>
>> Oh crap.
>> The patch I sent expands struct_group_tagged() only.
>> If I do the same for the regular struct_group(), there'll clearly be a
>> ton of new warnings.
>> I think I'll just submit v4 with removing this line from the kdoc?
> 
> No preference on direction, but not avoiding the warning would be great.
> 
> I reckon whether kdoc is useful for the group will depend case by case.
> Best would be if we made the kdoc optional in this particular case.
> But dunno if you have cycles so you can just delete.

I have some cycles, but I dunno if we can make some kdoc fields
description optional, I didn't work with the kdoc script that deep.

Thanks,
Olek


 


