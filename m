Return-Path: <netdev+bounces-258117-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id ELrEObNai2ljUAAAu9opvQ
	(envelope-from <netdev+bounces-258117-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Tue, 10 Feb 2026 17:20:03 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 5D9CE11D0CF
	for <lists+netdev@lfdr.de>; Tue, 10 Feb 2026 17:20:03 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id F3289300E717
	for <lists+netdev@lfdr.de>; Tue, 10 Feb 2026 16:19:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 54120387370;
	Tue, 10 Feb 2026 16:19:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="kqKs4HgS"
X-Original-To: netdev@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.20])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7B4823876D7
	for <netdev@vger.kernel.org>; Tue, 10 Feb 2026 16:19:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=198.175.65.20
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770740392; cv=fail; b=nzWhBbbAa6UwVlAVHN0q695QVQEqgKdfg5V5+LOzLxsNrHf2wseqPXkz1AzaPE4zFPXvTDNphqyKMGJYYszany17FTPqljEm1V0621vRapIS3iC7q1HPRGOxsUKn8bLWvdAldX1KhQ9OW+I7E73V5CoMWyEP5lzo6DAHmERmx20=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770740392; c=relaxed/simple;
	bh=O/jsBz+XRArUDT3Fb9swqqbP0RL+rrLRE/HRZaUBOnw=;
	h=Date:From:To:CC:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=tE9NM5cGkgpPXI30rUkH6GdxaNvPrEc13cWQmF3xMJiD5nxNYjBGhSpOswl6gyrAb8uGU9Co4vlFreHnKoubWJHyDyRXr7PjhUH71BQfmA3ylCTuPEL8BxK9Rv/PiG366SGdQL9YHC4zOyuCkt6C/P6BnaEtNiMpr3oIikVy6C4=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=kqKs4HgS; arc=fail smtp.client-ip=198.175.65.20
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1770740390; x=1802276390;
  h=date:from:to:cc:subject:message-id:references:
   in-reply-to:mime-version;
  bh=O/jsBz+XRArUDT3Fb9swqqbP0RL+rrLRE/HRZaUBOnw=;
  b=kqKs4HgSabjXtVsT91zol+0GU1fZql1MTR2o0CdJNJrs4AgWOJzxBPsU
   oi+vAD8r0YRLkVV1aulKUq4BcCEtDKSLUSh4R8lzeDuC7WIEurmxf5uTx
   Ksg2bq5YugfB8TzVWlgfcyfLGHj41Z9NYevXFYsSKC6TdacpAQ9ugjq4k
   7r0ZSaMHnahqr0pgnTsyxyEmo7lMXpxSqsWLbYNM2BztIVzmGkPH0Tq3p
   QTdDG+jOE3Tb18aj+w23N3PaMdParqvwK2o67bw379AaoljlL8HISJhXl
   q0ylrVw67LiRn1m7By/PqfKxfSvGqrydEMGN0XmMv06Lb3d9KYqVyyvcs
   g==;
X-CSE-ConnectionGUID: 7A2dyR9FRKuoyb6/m4RUAw==
X-CSE-MsgGUID: eunwYY2XSmGL5nYheJChpA==
X-IronPort-AV: E=McAfee;i="6800,10657,11697"; a="71592525"
X-IronPort-AV: E=Sophos;i="6.21,283,1763452800"; 
   d="scan'208";a="71592525"
Received: from fmviesa007.fm.intel.com ([10.60.135.147])
  by orvoesa112.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 10 Feb 2026 08:19:49 -0800
X-CSE-ConnectionGUID: 9pgKplO6R8q+it4kkP/JwA==
X-CSE-MsgGUID: 9TGd7ZcLTsK4lOh7gXYBHg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.21,283,1763452800"; 
   d="scan'208";a="211037209"
Received: from orsmsx901.amr.corp.intel.com ([10.22.229.23])
  by fmviesa007.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 10 Feb 2026 08:19:49 -0800
Received: from ORSMSX903.amr.corp.intel.com (10.22.229.25) by
 ORSMSX901.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.35; Tue, 10 Feb 2026 08:19:48 -0800
Received: from ORSEDG902.ED.cps.intel.com (10.7.248.12) by
 ORSMSX903.amr.corp.intel.com (10.22.229.25) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.35 via Frontend Transport; Tue, 10 Feb 2026 08:19:48 -0800
Received: from CH4PR04CU002.outbound.protection.outlook.com (40.107.201.52) by
 edgegateway.intel.com (134.134.137.112) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.35; Tue, 10 Feb 2026 08:19:48 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=nzG6WYP+XFOSEDa6mqWE9rEVEN/kx0tZ/UchNyog1s/0HXqdqKYvGq2WeoCBtC4DfATJul3GMpkkXNVm292OwGBCvdryJx0vmKYn3P6n6Gu1HwCWcbAK61Z8bS12k0dOhp/WkJuwpn6HBaRq61y2pG5i2bMf8sfpjBa5p9hJXAv4R3Ko7NbvdsbnQGBf0/kI2h2+i2Lim/EjFINwo/nnqv11i9iTWwadFK0MYL/YavgElP3dmyBwZyEkQdRoGGKYFV+NvlK0eEe2tpLluKVMv2hHjkIvgrS/RStwApUpBJCNlNTRxwOJawxY7hj/rr+fHw5RGDf2ziz2nWDi+4DNWQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=RJdu2lkohTbmAURUuk6C+R4+xcxYQuJC5QtqQNHSuco=;
 b=SqDbYQoUHUgXROqYUwXdE2S47KA3NhIUrwpxkyuEHQfKG86rzQBd5ZGCKVuQoHYo/tSCynNzxvQWCWp9isdkjlMxlHDBNZo0pSOqI43alYAInzUrhU3NeO7fjUbNkV52u7pcXpg7jPbcTwVBCqdiszI0QXQblrmN8dXsfmAf00rXY1BsYuLJicgn5Hh/7x0oppCAnAFGP5/Ol1wUp9cjHLz8ORMvKGQFYrKvWSANwo2Z6B3+Ee+W7qyLZwkmzY1vCF3URuRRCof7UdxEqqX+DO41rKMpVTI5xDC+PWaGORK0zbkqeQ/K3P98DOLWwASraVfX+ZorhOwOGNpWYRvtYg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from DM4PR11MB6117.namprd11.prod.outlook.com (2603:10b6:8:b3::19) by
 LV3PR11MB8577.namprd11.prod.outlook.com (2603:10b6:408:1b8::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9587.19; Tue, 10 Feb
 2026 16:19:36 +0000
Received: from DM4PR11MB6117.namprd11.prod.outlook.com
 ([fe80::d9b3:e942:2686:3cdd]) by DM4PR11MB6117.namprd11.prod.outlook.com
 ([fe80::d9b3:e942:2686:3cdd%6]) with mapi id 15.20.9587.017; Tue, 10 Feb 2026
 16:19:36 +0000
Date: Tue, 10 Feb 2026 17:19:22 +0100
From: Maciej Fijalkowski <maciej.fijalkowski@intel.com>
To: "Nikhil P. Rao" <nikhil.rao@amd.com>
CC: <netdev@vger.kernel.org>, <magnus.karlsson@intel.com>, <sdf@fomichev.me>,
	<davem@davemloft.net>, <edumazet@google.com>, <kuba@kernel.org>,
	<pabeni@redhat.com>, <horms@kernel.org>, <kerneljasonxing@gmail.com>
Subject: Re: [PATCH net v2 2/2] xsk: Fix zero-copy AF_XDP fragment drop
Message-ID: <aYtaioooXhsXVL0G@boxer>
References: <20260209182642.237904-1-nikhil.rao@amd.com>
 <20260209182642.237904-3-nikhil.rao@amd.com>
 <aYpXxAowNQe99cEm@boxer>
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <aYpXxAowNQe99cEm@boxer>
X-ClientProxiedBy: TL0P290CA0015.ISRP290.PROD.OUTLOOK.COM (2603:1096:950:5::7)
 To DM4PR11MB6117.namprd11.prod.outlook.com (2603:10b6:8:b3::19)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM4PR11MB6117:EE_|LV3PR11MB8577:EE_
X-MS-Office365-Filtering-Correlation-Id: 950fc31e-e543-44f6-87bf-08de68c02eee
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|376014|1800799024|7053199007;
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?C+dOIUyP7/5VJCMt42Rf3uP5AsEdY44+WisUg7Jgrh/CdTKnRCbd++wvEHpu?=
 =?us-ascii?Q?lWJACWjkpt1Qc26JI1g2zhBgzkHHETnUVDn85ZDOeIGtIBeTqCO4eAK6Kl3L?=
 =?us-ascii?Q?10VuborGu5fRDyeMspf4sMtFOiEVimsp7QnRsRzcHm/+wDIsTenvkNpfP59W?=
 =?us-ascii?Q?zV5xSKExkvSuNtjraUck29uQOg2QxHzvz+TlXmetZ3ldUrHfoTJE5ZPdf/mV?=
 =?us-ascii?Q?J8sjYBXkbX+z0OwKTTn02nV5optDJgfsnFOdxIlsVS4zD1jQlOJQi4bciefV?=
 =?us-ascii?Q?25J8JkNRhFD9bR1s5iyaU6vD+X0iD+quCvvL7W3wSq405pw4siVZ4DhbxZ+H?=
 =?us-ascii?Q?PAo6wK6xJZjZZB4YbDzbqxuhrLH/Q2kZmwwAkVTt7AYhF2NbqG5bjsqSYreN?=
 =?us-ascii?Q?Yfxs4cUgxAXzh9hnQmV/DUhvgfF36U5r1IUv7FOSrWiGHAOj4IEJdRFcw/eh?=
 =?us-ascii?Q?B5uyMZbGh17Z1D9W73+/4wnX91ubyYI3KIN3r5WA2UiNoqEP8ammev33wGXV?=
 =?us-ascii?Q?n0HyTUcsog3v4DhAIylT4XupzQUhEUf9q90kxwHW+nnGov21VzdroHkpuOZx?=
 =?us-ascii?Q?xnGOx6u7c3PgdozmH7GqbbTmRiSDJGdqqF26005Y/NAjBv8Z4gQ/EmDElKDP?=
 =?us-ascii?Q?S0P/eiUiTpahKw14s6tcQ0dF8GhCdywfMWF2KV1XF9slWn5gsis7pDIZSthi?=
 =?us-ascii?Q?0vW38gJR7dvAB5ZRJbc3LfVDUUTsyfe9I/YnPTM36lawqncywA1gYvb2jjDY?=
 =?us-ascii?Q?ItAfRmYTPYvSkpWMhlb2mH4+aJSEm1/tdFziwROKce17J2kJKtkLbRLf+Zu2?=
 =?us-ascii?Q?xe2w6UVeM6u1Nl/b498tRr6ZswxgZ8zZxppALeK+pDL9f4T9w8DG85/PYpp8?=
 =?us-ascii?Q?hP+ExSYcUkfZ0i+3SvonSehW5miU3K/gecniq4KG6+N+bTbhSuDlLgmiN+GV?=
 =?us-ascii?Q?7Y4lXJcIVWUCYWxcV1hP5yiMPvykqfmj45LEg7bLZ2Yu7JOQ4aLM4YlFXd9I?=
 =?us-ascii?Q?OfbEcXSY78pTBqavDdXqc2f0AqNE7ThHO6hP1R5xTKQPWnN6a4OFjIViAxbm?=
 =?us-ascii?Q?tTFqB++ZfUq85ui7Mu0ndkF6aUy+L8GNnaXl8pSeicNAxh6DXMcfOYbBxAA7?=
 =?us-ascii?Q?LmBo9S2hsczVwAqWdisr9P9Ncnw9qhFDsYPR2BrotcPNXUdppm9fQEzxvFGN?=
 =?us-ascii?Q?nbLm/Az1GPUXQ+WKIfsdoPfPkOxssXd2ntDFm/0tfdSlmBc64VduGFlul1qH?=
 =?us-ascii?Q?wmuCAamQDxUZCAOB1x1pKIY3zUSknI7a1ntEBQyE0CAkYmVZud1J2zTiGzLa?=
 =?us-ascii?Q?m4q7ZvHN/zwX0r2tO1UTDAcU3Rtb790CZa2IR4V2EZuNWJzvHUlaOJndFK84?=
 =?us-ascii?Q?eGkSJy1WNOPGibxJ65MbkmNLElbRinsnT1985ilaKXq+GAYlolG1RuAEoR+C?=
 =?us-ascii?Q?Jvwo/t7ZzviAoEW4OS0cqIFz78B7uEobjJzrKm8T8Tz2RLAFlCzyKBLDNbQF?=
 =?us-ascii?Q?eNWjt5FzC0XQ4zMkiXKm2mlyHKlOYERXWJhHz7O9z23HdSP5UZ+vobBHqWaF?=
 =?us-ascii?Q?diMJBp2x3B/yqJjc2Jo=3D?=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM4PR11MB6117.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(376014)(1800799024)(7053199007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?ML5KGrBTNKNA60/bpPY1l8e7uORiZ8ozmcYU6jVLs7eYuU8MBcarNm5Ozwyp?=
 =?us-ascii?Q?CRXFBKH/9lhV0hdMC7EeWNL/H62meP6JhL1vv7v0JgllPVfYbGKr1u3orJbF?=
 =?us-ascii?Q?MSUqnhHkJbcW2kCbyXK3kD+GDQTqwSdCaOsqMtnv+GbhaLPT2h8FbuHf/29G?=
 =?us-ascii?Q?mMzn5aM8YlNQd1pMzNfk6UHrKb9LHnyed9Y0oT1xloND03kVTBFScNOvxGZ/?=
 =?us-ascii?Q?8qJX1ofA1PykSM90JmdZCWYU/N+GXy9iIpp5v0YTlz4kkTh4DHc163po/AIR?=
 =?us-ascii?Q?D3t8LlCY/bJjWnQdlmj468QAHwPw/31AGWe/+cBwxmkH0CObipo3uE3OPnZT?=
 =?us-ascii?Q?zO8HVmMEilK9F0vnPkh2HwBTlEYFLyGCW3Txof6PyUZcy12l1hVkwSL4rb7x?=
 =?us-ascii?Q?VCso4l9o9le8qrqsQdy3TPvi4OC0Pc2LKibN32JRyf+hpPOe5WGvyMIgkNtT?=
 =?us-ascii?Q?muURQO350HqHsorY074PADWFpS5r/A9vJ4ReTQ84OJMTFxzQpDjZCPrHNZvG?=
 =?us-ascii?Q?oTDbRKISzc9oYux8ABZNckXcKuiJTluqNAQ7x5Z0uO82xoMinCbxvO94pj1v?=
 =?us-ascii?Q?otQOCZNI1AGFniZR1e7Eh6sWxvr6JcmR/NkHKyPSdU//CnWGHGmaMCNwvc6P?=
 =?us-ascii?Q?rOvfh3OJlMfstBHaR7slRLYJkwf5Y9AkA08XS926z2aQTvJMUCHE1hOb1ftd?=
 =?us-ascii?Q?XZq9YRNS4wmK8XcP46JWbTlQ8QRaP36n/dUUCOWZ92ccEvEcJMUS2ygmR+uk?=
 =?us-ascii?Q?XrHgESmfu/nMVh7DkRufS1HcX6yvGo1yknU8h5kS/PHRYZT104UX1N3KxaMI?=
 =?us-ascii?Q?QIbNbghF1bv4w24WIdk6Usb88Pcm4CRK/dVV76QnMOrVsd+R9Pt/UvBbqkRu?=
 =?us-ascii?Q?oaW874FSUgz7FGJMD2sVjY5idECElEw9Siohoj3QDPAQ/Ml/VAe8VRx0xhjH?=
 =?us-ascii?Q?UMmq8UUmQZMx9m/ud1dcgLYbjoMG5OpwIAMZdgVtvElRJs67CgyxKOam+9aj?=
 =?us-ascii?Q?NrADx003MthMVH6L10ke7Y2dmaoX6WY7rXhiV2BmDyBl9MA6qHox04QS46YF?=
 =?us-ascii?Q?mwCM3bT58jfmrxcT/5h3yOQ87mmRetJQYabERrzRXoV+EED6rmdsPw4TN1yp?=
 =?us-ascii?Q?zafbnGsuEykYnbl2Uk7QQWfxGn5iJc3BdgKrkV2cnje8Siy5LVyqSwRMhi9b?=
 =?us-ascii?Q?FlgUIvJWTq1LNGVJh7EA4hQ/RtaIaWvzcXTLdc/p0Jms+NsGrzohCSQ5y1Zv?=
 =?us-ascii?Q?/XuWEplwKJasgSMHV2SfZf9W7WAVjIWxRT6HepTSJiVay4qOsTVUFaNVfIHG?=
 =?us-ascii?Q?iJESNMjCo0hOfaza6LNwLBICwTNueI8CoNNEpzAm1VZ4HSqZh5H1uB8wkTPV?=
 =?us-ascii?Q?XL9JQfX8NxNB9/0+xxtg8edQgNHXXzpt0UCpBx5a/+Cw0xB7DhAkJcnmfZya?=
 =?us-ascii?Q?DCTdGTp7d2uFJy9VovK725P9tDVN4mXgcEQv+zQfkS0use6QMPKH3PCc69Yu?=
 =?us-ascii?Q?fikE/ElTazVgTUL4wHuNbdXec0QkwuE5JoRQi7B9WfNBNMwSHXkkkKBbzluD?=
 =?us-ascii?Q?96yGI5WodXPZPDWSUH68oQQxQNlQ++qwPMttvb9oAzo+jGzeBmwg8RVZeWVl?=
 =?us-ascii?Q?HmawXVT1Ci8BSGPk8TynJ7S7PkLdRhkPuhhuhPOpH7um++RJMPZX4jxZPuHm?=
 =?us-ascii?Q?zrCubpb38LG7qS35Hf8bq8T1klTpjD3+7Bl8cIvPb7ve8iJiLRv4iF4uRxLk?=
 =?us-ascii?Q?yA62CGfFgBqirNzFjr6TCVyMzWbK/K8=3D?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 950fc31e-e543-44f6-87bf-08de68c02eee
X-MS-Exchange-CrossTenant-AuthSource: DM4PR11MB6117.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 10 Feb 2026 16:19:36.5001
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: yN8eSlBW4/uNkI6LsYNeJVeNEpOenJwsx8QIz1zVIIie8fpclbuqr1LE77tmiu/RjKV25R2L3k7GmW89zeoyNyoaCgUO8e8je44D06mjB4E=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: LV3PR11MB8577
X-OriginatorOrg: intel.com
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [0.34 / 15.00];
	ARC_REJECT(1.00)[cv is fail on i=2];
	DMARC_POLICY_ALLOW(-0.50)[intel.com,none];
	MID_RHS_NOT_FQDN(0.50)[];
	R_DKIM_ALLOW(-0.20)[intel.com:s=Intel];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FREEMAIL_CC(0.00)[vger.kernel.org,intel.com,fomichev.me,davemloft.net,google.com,kernel.org,redhat.com,gmail.com];
	MIME_TRACE(0.00)[0:+];
	TAGGED_FROM(0.00)[bounces-258117-lists,netdev=lfdr.de];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,intel.com:email,intel.com:dkim,amd.com:email];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[maciej.fijalkowski@intel.com,netdev@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[intel.com:+];
	RCPT_COUNT_SEVEN(0.00)[10];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	TAGGED_RCPT(0.00)[netdev];
	MISSING_XM_UA(0.00)[];
	RCVD_COUNT_SEVEN(0.00)[10]
X-Rspamd-Queue-Id: 5D9CE11D0CF
X-Rspamd-Action: no action

On Mon, Feb 09, 2026 at 10:55:16PM +0100, Maciej Fijalkowski wrote:
> On Mon, Feb 09, 2026 at 06:24:51PM +0000, Nikhil P. Rao wrote:
> > AF_XDP should ensure that only a complete packet is sent to application.
> > In the zero-copy case, if the Rx queue gets full as fragments are being
> > enqueued, the remaining fragments are dropped.
> 
> All of the descs that current xdp_buff was carrying will be dropped which
> is incorrect as some of them have been exposed to Rx queue already and I
> don't see the error path that would rewind them. So that's my
> understanding of this issue.
> 
> However, we were trying to keep the single-buf case as fast as we can, see
> below.
> 
> > 
> > Add a check to ensure that the Rx queue has enough space for all
> > fragments of a packet before starting to enqueue them.
> > 
> > Fixes: 24ea50127ecf ("xsk: support mbuf on ZC RX")
> > Signed-off-by: Nikhil P. Rao <nikhil.rao@amd.com>
> > ---
> >  net/xdp/xsk.c | 22 +++++++++++-----------
> >  1 file changed, 11 insertions(+), 11 deletions(-)
> > 
> > diff --git a/net/xdp/xsk.c b/net/xdp/xsk.c
> > index f2ec4f78bbb6..b65be95abcdc 100644
> > --- a/net/xdp/xsk.c
> > +++ b/net/xdp/xsk.c
> > @@ -166,15 +166,20 @@ static int xsk_rcv_zc(struct xdp_sock *xs, struct xdp_buff *xdp, u32 len)
> >  	u32 frags = xdp_buff_has_frags(xdp);
> >  	struct xdp_buff_xsk *pos, *tmp;
> >  	struct list_head *xskb_list;
> > +	u32 num_desc = 1;
> >  	u32 contd = 0;
> > -	int err;
> >  
> > -	if (frags)
> > +	if (frags) {
> > +		num_desc = xdp_get_shared_info_from_buff(xdp)->nr_frags + 1;
> >  		contd = XDP_PKT_CONTD;
> > +	}
> >  
> > -	err = __xsk_rcv_zc(xs, xskb, len, contd);
> > -	if (err)
> > -		goto err;
> > +	if (xskq_prod_nb_free(xs->rx, num_desc) < num_desc) {
> 
> this will hurt single buf performance unfortunately, I'd rather have frag
> part still executed separately. Did you measure what impact on throughput
> this patch has?
> 
> Further thought here is once we are sure about sufficient space in xsk
> queue then we could skip sanity check that xskq_prod_reserve_desc()
> contains. Look at batching that is done on Tx side.
> 
> Please see what works best here. Whether keeping linear part execution
> separate from frags + producing frags in a 'batched' way or including
> linear part with this 'batched' production of descriptors.

What I meant was patch below. However this is not a fix so I wouldn't
incorporate it to your set. Maybe let's go with just processing linear
part separately just like it used to be and then I can follow-up with this
diff.

From 153e1bc5d2baf6328667956ae16d47103085eac8 Mon Sep 17 00:00:00 2001
From: Maciej Fijalkowski <maciej.fijalkowski@intel.com>
Date: Tue, 10 Feb 2026 13:39:17 +0000
Subject: [PATCH bpf-next] xsk: avoid double checking against rx queue being
 full

Currently non-zc xsk rx path for multi-buffer case checks twice if xsk
rx queue has enough space for producing descriptors:
1.
	if (xskq_prod_nb_free(xs->rx, num_desc) < num_desc) {
		xs->rx_queue_full++;
		return -ENOBUFS;
	}
2.
	__xsk_rcv_zc(xs, xskb, copied - meta_len, rem ? XDP_PKT_CONTD : 0);
	-> err = xskq_prod_reserve_desc(xs->rx, addr, len, flags);
	  -> if (xskq_prod_is_full(q))

Second part is redundant as in 1. we already peeked onto rx queue and
checked that there is enough space to produce given amount of
descriptors.

Provide helper functions that will skip it and therefore optimize code.

Signed-off-by: Maciej Fijalkowski <maciej.fijalkowski@intel.com>
---
 net/xdp/xsk.c       | 14 +++++++++++++-
 net/xdp/xsk_queue.h | 16 +++++++++++-----
 2 files changed, 24 insertions(+), 6 deletions(-)

diff --git a/net/xdp/xsk.c b/net/xdp/xsk.c
index f093c3453f64..aaadc13649e1 100644
--- a/net/xdp/xsk.c
+++ b/net/xdp/xsk.c
@@ -160,6 +160,17 @@ static int __xsk_rcv_zc(struct xdp_sock *xs, struct xdp_buff_xsk *xskb, u32 len,
 	return 0;
 }
 
+static void __xsk_rcv_zc_safe(struct xdp_sock *xs, struct xdp_buff_xsk *xskb,
+			      u32 len, u32 flags)
+{
+	u64 addr;
+
+	addr = xp_get_handle(xskb, xskb->pool);
+	__xskq_prod_reserve_desc(xs->rx, addr, len, flags);
+
+	xp_release(xskb);
+}
+
 static int xsk_rcv_zc(struct xdp_sock *xs, struct xdp_buff *xdp, u32 len)
 {
 	struct xdp_buff_xsk *xskb = container_of(xdp, struct xdp_buff_xsk, xdp);
@@ -292,7 +303,8 @@ static int __xsk_rcv(struct xdp_sock *xs, struct xdp_buff *xdp, u32 len)
 		rem -= copied;
 
 		xskb = container_of(xsk_xdp, struct xdp_buff_xsk, xdp);
-		__xsk_rcv_zc(xs, xskb, copied - meta_len, rem ? XDP_PKT_CONTD : 0);
+		__xsk_rcv_zc_safe(xs, xskb, copied - meta_len,
+				  rem ? XDP_PKT_CONTD : 0);
 		meta_len = 0;
 	} while (rem);
 
diff --git a/net/xdp/xsk_queue.h b/net/xdp/xsk_queue.h
index 1eb8d9f8b104..4f764b5748d2 100644
--- a/net/xdp/xsk_queue.h
+++ b/net/xdp/xsk_queue.h
@@ -440,20 +440,26 @@ static inline void xskq_prod_write_addr_batch(struct xsk_queue *q, struct xdp_de
 	q->cached_prod = cached_prod;
 }
 
-static inline int xskq_prod_reserve_desc(struct xsk_queue *q,
-					 u64 addr, u32 len, u32 flags)
+static inline void __xskq_prod_reserve_desc(struct xsk_queue *q,
+					    u64 addr, u32 len, u32 flags)
 {
 	struct xdp_rxtx_ring *ring = (struct xdp_rxtx_ring *)q->ring;
 	u32 idx;
 
-	if (xskq_prod_is_full(q))
-		return -ENOBUFS;
-
 	/* A, matches D */
 	idx = q->cached_prod++ & q->ring_mask;
 	ring->desc[idx].addr = addr;
 	ring->desc[idx].len = len;
 	ring->desc[idx].options = flags;
+}
+
+static inline int xskq_prod_reserve_desc(struct xsk_queue *q,
+					 u64 addr, u32 len, u32 flags)
+{
+	if (xskq_prod_is_full(q))
+		return -ENOBUFS;
+
+	__xskq_prod_reserve_desc(q, addr, len, flags);
 
 	return 0;
 }
-- 
2.43.0


> 
> > +		xs->rx_queue_full++;
> > +		return -ENOBUFS;
> > +	}
> > +
> > +	__xsk_rcv_zc(xs, xskb, len, contd);
> >  	if (likely(!frags))
> >  		return 0;
> >  
> > @@ -183,16 +188,11 @@ static int xsk_rcv_zc(struct xdp_sock *xs, struct xdp_buff *xdp, u32 len)
> >  		if (list_is_singular(xskb_list))
> >  			contd = 0;
> >  		len = pos->xdp.data_end - pos->xdp.data;
> > -		err = __xsk_rcv_zc(xs, pos, len, contd);
> > -		if (err)
> > -			goto err;
> > +		__xsk_rcv_zc(xs, pos, len, contd);
> >  		list_del_init(&pos->list_node);
> >  	}
> >  
> >  	return 0;
> > -err:
> > -	xsk_buff_free(xdp);
> > -	return err;
> >  }
> >  
> >  static void *xsk_copy_xdp_start(struct xdp_buff *from)
> > -- 
> > 2.43.0
> > 

