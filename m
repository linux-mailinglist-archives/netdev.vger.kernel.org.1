Return-Path: <netdev+bounces-294924-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id gZI+NBGdIGol5wAAu9opvQ
	(envelope-from <netdev+bounces-294924-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Wed, 03 Jun 2026 23:30:57 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [IPv6:2600:3c15:e001:75::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 5CBF163B647
	for <lists+netdev@lfdr.de>; Wed, 03 Jun 2026 23:30:56 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=intel.com header.s=Intel header.b=QK0IYPhT;
	spf=pass (mail.lfdr.de: domain of "netdev+bounces-294924-lists+netdev=lfdr.de@vger.kernel.org" designates 2600:3c15:e001:75::12fc:5321 as permitted sender) smtp.mailfrom="netdev+bounces-294924-lists+netdev=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=none) header.from=intel.com;
	arc=reject ("cv is fail on i=2")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id 6BD2B300C3B0
	for <lists+netdev@lfdr.de>; Wed,  3 Jun 2026 21:30:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 08EDE495535;
	Wed,  3 Jun 2026 21:30:52 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 528D837189C;
	Wed,  3 Jun 2026 21:30:50 +0000 (UTC)
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780522251; cv=fail; b=RFBcvqqmifumSrnxevVO2h5XqsKtwvV1Lejfv6Elh6a4t+2Hwowxij/ybnKlnEda9QNePzbDHCG3Cbu1T5nCkND5krN/+rbk1kzwDRDhKpvVlkreRhqqXKKwxAyOwckkiEhL4lS7eKNucHj7xUhpMHMOScUTfeWt18VG+sK5cn4=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780522251; c=relaxed/simple;
	bh=15WpQWSKtengsQ236j5cYkDcpLYoRa3OOfOLQyadpjo=;
	h=Message-ID:Date:Subject:To:CC:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=u/GNe8slghm4wa8No4l+BilTthM6Ob58AumcOr4x+OGDIEbrPo8X3TRqz6HSisKvVeGJtHLPQ+qcceeAt82DERGb+B3UH5Zp+rof4+sq9L6q5NetX96d6NACe5mqFscq6OJel++WvURqj1T29Vv5+AAl9a5wUPqrXhUGtuwpWC0=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=QK0IYPhT; arc=fail smtp.client-ip=198.175.65.18
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1780522250; x=1812058250;
  h=message-id:date:subject:to:cc:references:from:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=15WpQWSKtengsQ236j5cYkDcpLYoRa3OOfOLQyadpjo=;
  b=QK0IYPhTnmXHZAF09KjB6pzHCDUftPPt/V/j1GsvBDihRE0h/B7AbmsJ
   FGe+/a868g+aakWu/MnNFgcCocAlttVyPxZAp2D+O7XHRecB6jOZtluqn
   n/gUpQod40+ZWxOKGZxQ9V5iRiwA0cIo6sVH0PHhYZij+/x1t0c+nnmiB
   crAVwBNHarfiiO8Kn4JIbwFz9gzFysAddkaPMesktk41AWmcJWR5e8LhJ
   seKSr1BtRtmYM8gn3FIHBaIIEvZQCMMfcnESZCFCnHYHNtqV+/UM4a3PH
   v51YJIGnP+UnKM9TQ89tcvV/GO+xkaBmTTJSw2oc4kGgD4wO92GHCzcCg
   A==;
X-CSE-ConnectionGUID: VJg0MvMxRbGKsvXXAlUWEg==
X-CSE-MsgGUID: nfCllcwPQnWOV8rKAcJU+w==
X-IronPort-AV: E=McAfee;i="6800,10657,11806"; a="81405576"
X-IronPort-AV: E=Sophos;i="6.24,185,1774335600"; 
   d="scan'208";a="81405576"
Received: from orviesa003.jf.intel.com ([10.64.159.143])
  by orvoesa110.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 03 Jun 2026 14:30:50 -0700
X-CSE-ConnectionGUID: ipgVsE5GRyacx2eGBH/I3Q==
X-CSE-MsgGUID: 7bsnqRmbRT+qNmeRRCanDA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.24,185,1774335600"; 
   d="scan'208";a="248304112"
Received: from orsmsx902.amr.corp.intel.com ([10.22.229.24])
  by orviesa003.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 03 Jun 2026 14:30:50 -0700
Received: from ORSMSX901.amr.corp.intel.com (10.22.229.23) by
 ORSMSX902.amr.corp.intel.com (10.22.229.24) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.37; Wed, 3 Jun 2026 14:30:49 -0700
Received: from ORSEDG903.ED.cps.intel.com (10.7.248.13) by
 ORSMSX901.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.37 via Frontend Transport; Wed, 3 Jun 2026 14:30:49 -0700
Received: from BYAPR05CU005.outbound.protection.outlook.com (52.101.85.41) by
 edgegateway.intel.com (134.134.137.113) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.37; Wed, 3 Jun 2026 14:30:49 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=fqjAkL9yNgTAgqHFM4pvzPbMmpEDPlP+y40fUDcxGdhng5me8PEGPzbodD9jDcn/bJbXVM8/Nih0DkD91B4DMOiBOFSB3/JVZQet4oSoSNh+lHRtO9ZQqdp0peshm1v6DJK1ycqTUd1Ywi4WF/gvHvpDL0g265K0CyfBWpeoBJPwSYCm8uImTrEL4DVyAGxS6u2hmWhqXzIsli/RI7b0xFkezMugZ2MYwJmN87rR2KPxj1+SUdk2JuxTQnKRW1CEjBk65YbZYH3+rRIG0cBRB2atufsER2TLQlMHi+exKSLehoRIYtOX8//2uuJK9NE2tysmbTaPQPHfGNb9J8aAZw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=hUn+ZgjTRsyfmJ9bt/hulMzKac4DEevS752jjPxAuZU=;
 b=yBMTEsQHRg+fON0Cf1QlcyIcJMXI7xf2TnzlUJdrj4vI/mGVkAves5+sh0xwCot9U+RsVPkslhR3S/YFih3vRL1YhWN6hglQSWxxh+ZM6Qeo4f8egNfNyiu8QrIyKSGGIUjboL5ycypf3t8gRrPEWbbrOfCxENdedRc40hVJPNwRElA2SMsoayJbfh0OQbttU0hB/lI0XJ4/Ln/gIB4rNMn0eFdWZvOjsZEBNmEtapnPGr0D8aVUrHJv9BTi1DQe0zU6h/BrrBRSWCsPDCnzWOV0S3XhUSf8i58/36Ntyu3waldEZ+qPfTaXCs4BPujJcME2stLcs+C1eWEKw1HwoA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from DS0PR11MB7381.namprd11.prod.outlook.com (2603:10b6:8:134::14)
 by IA1PR11MB7810.namprd11.prod.outlook.com (2603:10b6:208:3f3::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.71.16; Wed, 3 Jun 2026
 21:30:46 +0000
Received: from DS0PR11MB7381.namprd11.prod.outlook.com
 ([fe80::4c39:dfe6:d6dc:6f58]) by DS0PR11MB7381.namprd11.prod.outlook.com
 ([fe80::4c39:dfe6:d6dc:6f58%5]) with mapi id 15.21.0092.006; Wed, 3 Jun 2026
 21:30:46 +0000
Message-ID: <f5354617-25fd-46e5-b795-c5aedd011c88@intel.com>
Date: Wed, 3 Jun 2026 14:30:44 -0700
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net] net: ibm: emac: mal: fix unchecked platform_get_irq
 return values
To: Rosen Penev <rosenp@gmail.com>, <netdev@vger.kernel.org>
CC: Andrew Lunn <andrew+netdev@lunn.ch>, "David S. Miller"
	<davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, Jakub Kicinski
	<kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, open list
	<linux-kernel@vger.kernel.org>
References: <20260601040252.103585-1-rosenp@gmail.com>
Content-Language: en-US
From: Jacob Keller <jacob.e.keller@intel.com>
In-Reply-To: <20260601040252.103585-1-rosenp@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: MW4PR03CA0331.namprd03.prod.outlook.com
 (2603:10b6:303:dc::6) To DS0PR11MB7381.namprd11.prod.outlook.com
 (2603:10b6:8:134::14)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS0PR11MB7381:EE_|IA1PR11MB7810:EE_
X-MS-Office365-Filtering-Correlation-Id: c16d4c51-e546-4a97-2a4f-08dec1b75fcc
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|366016|376014|18002099003|11063799006|22082099003|56012099006;
X-Microsoft-Antispam-Message-Info: OUa6ZeVzMGprUaPD512f6ObrDZtcX5sP+gYt2T9dsYCKuzgM61p7wKiy82HwuUWJFyH6p5TXwqFRuad4SUX1q9MsPW4G1Qhs41vbmw/bu1GboFgaTXrMYoYwBd99MA5BtIU02y8M3wLsplZSGRuLJjm5YMBrsTYCeSY+pNNLT6N8G1owf2mEruEJ06Lyatcqn1ZMgbYqIKqTfHt+oDQX2UGnQhPWNMOD2nqCpcaBFJ51xbn2IUq45hZKYCZyflY9XJZyimUs90A5jnu74fdcsdpymKSiSBrGhRmcEWdcj7ffeAyQSdqlGzl5y6gWeSCun7QxjCGhhceQ/wgQ0Ez1xj3XYveDSYvH7E8rqduzAWRNm4PJ8otE4uOw9vL/sB/ARW1IaSlJP4tCeThG+KAFPL9YbgTDUS/tBej4ya6O15hq6khXDpHUE/nQuAQnbtHiSRWlD94jwBoy03CBplJivpTMZMGwFo9inWTMg6B5AOMKxIkPThDrqKh65hksHBNtY/7HZSePHRjk+miMicdkD3qwV5kJFv3JtvlDf+/U6jIfGHUfD1vTunBDp8t2HIMLUPQvE6+d33cI7JC8Fs51BFL24fz6bPOQGSGtNzAkD+BmtZyE9ZN0XZshdMekXnoQVvdLyRJo5/7hAfQzauxzv/fPO8ULCqd8Yi9YRGSRYyLYDchvK3QzfNf1dcA9qkz6
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DS0PR11MB7381.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(376014)(18002099003)(11063799006)(22082099003)(56012099006);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?T0Z1QjNSTWNaMlNHSmlGNXF4V2RBdndzekIxZGNTOU5xN3laMDdIbS9sREJ4?=
 =?utf-8?B?NW1YaTBuN25YVmk5eWVFcWdTMnBkeDY0aGFGMlBXT0g0N1NLa1NBM1hnMkhO?=
 =?utf-8?B?SGpIQVRBdmoxVmlxaktINFI3M1B2L20vQ3ljUGYxUjBOOGtibVhkeHVTcisr?=
 =?utf-8?B?cEJKTHB1c1c3R29GN0VDR0d2REs3RDRsNEViZ3JDVFVJbzcrR0V4aWtLOER4?=
 =?utf-8?B?c2xMRzM3RkljNnR0RFU4cENJWlowQVc4MnFDdnRIV0NjbEhnOTU3QUdmZ003?=
 =?utf-8?B?WXRRZFNpU2lIMVRXVy9vVi9leDFwK0NZMUNsV2RCVWNra2oxUEV5MUFBQ2xT?=
 =?utf-8?B?VUExbHBRcWd0enFuUU9BWEd4TkNodnVmQzBneFJsZlVMMnF3dTlqaTJpQ1Fk?=
 =?utf-8?B?MXlsL1hKWGVRYk1tL0dMdGZtOElWSUZnYjFuUFRXWk5ZS1l0ZjU2dWRVbHk1?=
 =?utf-8?B?QnVvRW9CaVBkQVJIaDluVWJHMFVsUzVJU0lTSURQRklsTkJOTWFpNG1VaUta?=
 =?utf-8?B?RmpPYVFoeEhDSXJpZTJhSWpiMkZhTGIxREhvalFnNnZWZG1aOWFqeGpUblZh?=
 =?utf-8?B?U2pMdW9uVU5LZWRXWHZ6VWtrT3dXUXJVa25hZkNBK0hVeWRLOUlZNVV3eWhy?=
 =?utf-8?B?c2FzODU3T1V3c3JyQWEvbk1DNXVvRjVJblA2V1F6d1lsY1g1b05HM2R6V253?=
 =?utf-8?B?V3ZUaFJicUYrVjJZMG1MUmJzazRUNHRySFpJTkZXc2xzWWdDM0o3WktabnNS?=
 =?utf-8?B?M1lwcHd5UjJEeWl4SHByTGZMTkluWmcyeXpnS1dRTVU1TlJwOVVNMjQwaDVV?=
 =?utf-8?B?a3U5V202cFI1bFkvYytkR3hycVlOZURBZXFIK25MeXVmYmdhVXVDbU0vWFhZ?=
 =?utf-8?B?cjlkcnJkZWtaZGM3WnhpSWRreDN4R00yQU5aRzZFOGdvUE5IWUpDTEJaNGFV?=
 =?utf-8?B?OUp4SG9YbDdZNzhTdVNoR296OVE1TGk5M3k4RHg5OHB1djdYYnd1eHo0OGxY?=
 =?utf-8?B?NTZ6ZzVZUnNZcDZqeEdFMGpIKytrWlZFeTREK3JCNWJaZkpLNnBYWjlHczlz?=
 =?utf-8?B?bUpGMUJjRllJdmtOS1RUenE2TXVRWU5jcGFRQkRvci9VNy9JTzFyWmZxNWh1?=
 =?utf-8?B?aUtNZFJpM216T0EzbGJGZ2pWdkNKYVVTcnlydWdxdGtFaTFrQXh5VzdPNW8y?=
 =?utf-8?B?OFlwK2RpV3ByU0xHZldham45UmpvZ3g2V0NNZHFVY1JpUG1vYTVVeXRIQmsw?=
 =?utf-8?B?RDJMN0JnMWFRaU85NVYvQ0wrTFp3bU03bldhNC9MZDNJbnFhWGQ0TXJ2N2Q2?=
 =?utf-8?B?MHkyOHZZMEhWZ3k0SjRKTFVtbXhoQ1RMdVhZNjdndDVLZXVuNDdzS1ZZbk0x?=
 =?utf-8?B?bU1sWlFpVHB6TFdQYVF3dlRsMmlvS2MvakhlTDNTUzJzNVpNQnNUeGxMZFhP?=
 =?utf-8?B?RmZKeHdHeDNqbXh4RzBRNnhRYmxvc1hqUXhRbkFlUnVTOSszYXBxZUNZV2V3?=
 =?utf-8?B?MkN0ZjVKc0NXOFlDS3VKU01iNmxSOFArOHNaaTVic0lpOVUvOVV2NSsvMUtz?=
 =?utf-8?B?WmdtbFpNSG1hZW9FRFZKZVNDRjdkbE5MRGxnNG5YL2FxcFIyVzYvcm4vTHZw?=
 =?utf-8?B?L0NYaTlhU1kvZlRHZ2ZUZlcxcXRuRHFXUDdXTWJyazVkRkVEYTRaZWptM3lT?=
 =?utf-8?B?YVlTOVdqdGdlL3FZVmQwUnplSElaYURSYytrcDRPT1RTUFpwSHZGbUgvVWNW?=
 =?utf-8?B?a3c0MjZtNHJzTTF6UjhRN3FHbjNPU0dKMVRIQWc3WmZDYlFqTHpJZ29BMWtz?=
 =?utf-8?B?NUc0VmNhc1R6cDdlYnpENlZCQ1laZ1pTRGc2ZUhjandwM3VLM2dOR2dVbUZO?=
 =?utf-8?B?MVZvM1p4TER0WDIwSWN6OVVjK1pmRHIxVkhOVlNKYU1oeFZLc1BaUUdSaXBl?=
 =?utf-8?B?Y25MNUVRTDBFNmdjR3dWRE5qZEsxS0hORlFGalJBUCt3eDlkK2xRaGtZd2Fp?=
 =?utf-8?B?SXJ2YUJQa09lMW1KM1BoblI1R1kxUm0vWFNjVDk5dHRZSU9EYmlHTmFML1RF?=
 =?utf-8?B?amlxT0xUSTViYWNPQlN0YlFWZm1zZ1M3MnB4YlQ4dnFqTm1GeTR6Ym5ZM0I4?=
 =?utf-8?B?cUEyNUZBaStMUTB4UlZUN1RBdHJSeXJheHYxSTNjcFNjYk93czBPNFFUamhl?=
 =?utf-8?B?T2pBUEt4NCtmUXp5Qkc5elVjN3I0dFZ4Uzd6KzdkbjVDcmNsQjcwblZnNVdI?=
 =?utf-8?B?M240dEMvdWdacGg4WWxZR3hVZGE5UHBSd2JtemVJTllhTVZsODBNZ0lpMjc1?=
 =?utf-8?B?OFFwbVhNQVNFMldzZld6OFZiNDVxeTFxZ2dlZkJzLzVaaHBWMncrY1E3a0Fp?=
 =?utf-8?Q?VzHDnzfLsZvqwuXs=3D?=
X-Exchange-RoutingPolicyChecked: Dh9/iHhgshplWhP3uCZbFQ8Zy88WidboutKkzMTMO5EfvIVhIQdiihCrnepKoCYjS21bPPJ80pazUv2u/1kFr66ktnwZ5E1Xj6GY4b7bEucAV+JPDjpDzsqM2bsxeksFGjARJs4pJs8PmCbBEKXlo3PJn3TEoONe/5jKwlJqGzXkgDSDqbYvcVnR3GGnXGnJ6WPMzhqIZkRSWPyk5Mr2Gud5uGMEAD5CNco3UNEub0enQqQgiegLr10kKSgjd3EJ+Iu7Wq+qazKhvXDZJDYm3Px+/6p1vgOs7QVmmyX3sL+Us8DSeCmMZfZRfrU9TK+LfoLjvqaeS7douu4iv4ihLg==
X-MS-Exchange-CrossTenant-Network-Message-Id: c16d4c51-e546-4a97-2a4f-08dec1b75fcc
X-MS-Exchange-CrossTenant-AuthSource: DS0PR11MB7381.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 03 Jun 2026 21:30:46.5168
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: ETSP0P58Z8KUGPKFPDfK2B2Dd5T3EE2ZDAMovryl2ZUBuUnoiVBLrdaNiawrDdkeBses/R+xL9OotkN4rZeHxLY9OxvtCs9z/jaH/gquauQ=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA1PR11MB7810
X-OriginatorOrg: intel.com
X-Rspamd-Action: no action
X-Spamd-Result: default: False [1.34 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_REJECT(1.00)[cv is fail on i=2];
	DMARC_POLICY_ALLOW(-0.50)[intel.com,none];
	R_DKIM_ALLOW(-0.20)[intel.com:s=Intel];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c15:e001:75::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FORWARDED(0.00)[lists@lfdr.de];
	MIME_TRACE(0.00)[0:+];
	TAGGED_FROM(0.00)[bounces-294924-lists,netdev=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FORGED_RECIPIENTS(0.00)[m:rosenp@gmail.com,m:netdev@vger.kernel.org,m:andrew+netdev@lunn.ch,m:davem@davemloft.net,m:edumazet@google.com,m:kuba@kernel.org,m:pabeni@redhat.com,m:linux-kernel@vger.kernel.org,m:andrew@lunn.ch,s:lists@lfdr.de];
	FORGED_SENDER_MAILLIST(0.00)[];
	FREEMAIL_TO(0.00)[gmail.com,vger.kernel.org];
	FORGED_SENDER(0.00)[jacob.e.keller@intel.com,netdev@vger.kernel.org];
	DBL_BLOCKED_OPENRESOLVER(0.00)[vger.kernel.org:from_smtp,sin.lore.kernel.org:helo,sin.lore.kernel.org:rdns,intel.com:mid,intel.com:dkim,intel.com:from_mime,intel.com:email];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[jacob.e.keller@intel.com,netdev@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[intel.com:+];
	ALIAS_RESOLVED(0.00)[];
	MID_RHS_MATCH_FROM(0.00)[];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	RCPT_COUNT_SEVEN(0.00)[8];
	ASN(0.00)[asn:63949, ipnet:2600:3c15::/32, country:SG];
	TAGGED_RCPT(0.00)[netdev];
	RCVD_COUNT_SEVEN(0.00)[10]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 5CBF163B647

On 5/31/2026 9:02 PM, Rosen Penev wrote:
> platform_get_irq() returns a negative errno on failure.
> Commit c4f5d0454cab5 moved the platform_get_irq() calls and explicitly
> removed the error checks that were previously present, claiming
> devm_request_irq() can handle it. However, a negative IRQ number
> passed to devm_request_irq() fails with -EINVAL instead of
> propagating the real error from platform_get_irq().
> 
> Restore the missing error checks with proper errno propagation.
> 
> Fixes: c4f5d0454cab5 ("net: ibm: emac: mal: move irq maps down")
> Assisted-by: Opencode:Big-Pickle
> Signed-off-by: Rosen Penev <rosenp@gmail.com>
> ---

Reviewed-by: Jacob Keller <jacob.e.keller@intel.com>

>  drivers/net/ethernet/ibm/emac/mal.c | 11 +++++++++++
>  1 file changed, 11 insertions(+)
> 
> diff --git a/drivers/net/ethernet/ibm/emac/mal.c b/drivers/net/ethernet/ibm/emac/mal.c
> index 7d70056e9008..63a7a32aaf72 100644
> --- a/drivers/net/ethernet/ibm/emac/mal.c
> +++ b/drivers/net/ethernet/ibm/emac/mal.c
> @@ -635,6 +635,12 @@ static int mal_probe(struct platform_device *ofdev)
>  	mal->txeob_irq = platform_get_irq(ofdev, 0);
>  	mal->rxeob_irq = platform_get_irq(ofdev, 1);
>  	mal->serr_irq = platform_get_irq(ofdev, 2);
> +	if (mal->txeob_irq < 0 || mal->rxeob_irq < 0 || mal->serr_irq < 0) {
> +		err = mal->txeob_irq < 0 ? mal->txeob_irq :
> +		      mal->rxeob_irq < 0 ? mal->rxeob_irq : mal->serr_irq;
> +		dev_err_probe(&ofdev->dev, err, "failed to get IRQ\n");
> +		goto fail2;
> +	}
>  
>  	if (mal_has_feature(mal, MAL_FTR_COMMON_ERR_INT)) {
>  		mal->txde_irq = mal->rxde_irq = mal->serr_irq;
> @@ -643,6 +649,11 @@ static int mal_probe(struct platform_device *ofdev)
>  	} else {
>  		mal->txde_irq = platform_get_irq(ofdev, 3);
>  		mal->rxde_irq = platform_get_irq(ofdev, 4);
> +		if (mal->txde_irq < 0 || mal->rxde_irq < 0) {
> +			err = mal->txde_irq < 0 ? mal->txde_irq : mal->rxde_irq;
> +			dev_err_probe(&ofdev->dev, err, "failed to get IRQ\n");
> +			goto fail2;
> +		}
>  		irqflags = 0;
>  		hdlr_serr = mal_serr;
>  		hdlr_txde = mal_txde;


