Return-Path: <netdev+bounces-275350-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id YDojBtri0GmIBgcAu9opvQ
	(envelope-from <netdev+bounces-275350-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Sat, 04 Apr 2026 12:07:22 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id 894E639AB56
	for <lists+netdev@lfdr.de>; Sat, 04 Apr 2026 12:07:21 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 76F973012BDD
	for <lists+netdev@lfdr.de>; Sat,  4 Apr 2026 10:07:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6DB9F39659B;
	Sat,  4 Apr 2026 10:07:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="lJwQ1iIZ"
X-Original-To: netdev@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.13])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 305E8359A8C;
	Sat,  4 Apr 2026 10:07:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=192.198.163.13
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775297237; cv=fail; b=Nw0n4Zqt9EgrlEwRan1mJQHWZ9fLaBvwWn7ijJ2gmlWa+Y9iJs1p1SQTSe1JOu+DiZIc7zhYFg3pmnG6Ssp0C7Dh2YH9/tERavMl0WqMznc3aSl/OSILiW1JTxtg0VT0J20gyvP69Nyg77MbBX+RXjXbXPoFJ84bV8GotZAFKGs=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775297237; c=relaxed/simple;
	bh=03wvfZi9fba6xZz7u0suBfoK1nWVsjVx7CZsfNel3SA=;
	h=Date:From:To:CC:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=IXYZgIFLDkWgRQASRCeky1g4er6vaIs6IQDDOaYLdih61W9psI26Gcvbg6QcIgPPwRB9sm5lBhMIIoCgkGTLKn8NE3Sf5uTwbvDZZEYD8fLrvFq4JnLZ3AKKoJr9dnwaWDi/iS2H7CO0lkcQyyqgmYT/TH5MM83x8fygvFVCNyc=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=lJwQ1iIZ; arc=fail smtp.client-ip=192.198.163.13
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1775297235; x=1806833235;
  h=date:from:to:cc:subject:message-id:references:
   in-reply-to:mime-version;
  bh=03wvfZi9fba6xZz7u0suBfoK1nWVsjVx7CZsfNel3SA=;
  b=lJwQ1iIZFJ1gpt7Xz8ejoN6ygxJV9hbsQLH9ljnT5PYSl5f4wymc8GM4
   Rvcvh6OrRt8xDkyhzDYEDryBNF4bdRaPhAcv57hosCrU4/kofRrwHdFzI
   QZvVLWPWKGWR1o3Vzb12MKupVz/qfzFqpbboJuBILC0jdtMhm8qxC2aNI
   I4qxRAAYgbL8BXengRcqxtyA4TWaQijC46axPMZyFWS5LxRylWLpIRpm4
   wesOSoTDVqwE+JTw0kP1nzfMoC1/eBeLjhmFvCcL89v6Dq399ufjXG5qj
   WEUJU9ts+SksM13Lneyubg0kGUVRdEyzGb68URWpoTXDBpcpi13V8FYub
   A==;
X-CSE-ConnectionGUID: 6p0DHdUaST200+NgMY6cYg==
X-CSE-MsgGUID: DVGZm5+pS3yl3WSTkN11Dw==
X-IronPort-AV: E=McAfee;i="6800,10657,11748"; a="78931139"
X-IronPort-AV: E=Sophos;i="6.23,159,1770624000"; 
   d="scan'208";a="78931139"
Received: from fmviesa001.fm.intel.com ([10.60.135.141])
  by fmvoesa107.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 04 Apr 2026 03:07:14 -0700
X-CSE-ConnectionGUID: rg+BDyh4SL6QkdUqSQFDtA==
X-CSE-MsgGUID: skXgta/FTMW0E/w8DtmiSw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.23,159,1770624000"; 
   d="scan'208";a="250684045"
Received: from fmsmsx902.amr.corp.intel.com ([10.18.126.91])
  by fmviesa001.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 04 Apr 2026 03:07:14 -0700
Received: from FMSMSX901.amr.corp.intel.com (10.18.126.90) by
 fmsmsx902.amr.corp.intel.com (10.18.126.91) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.37; Sat, 4 Apr 2026 03:07:14 -0700
Received: from fmsedg902.ED.cps.intel.com (10.1.192.144) by
 FMSMSX901.amr.corp.intel.com (10.18.126.90) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.37 via Frontend Transport; Sat, 4 Apr 2026 03:07:14 -0700
Received: from CO1PR03CU002.outbound.protection.outlook.com (52.101.46.71) by
 edgegateway.intel.com (192.55.55.82) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.37; Sat, 4 Apr 2026 03:07:13 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=AhBmuvgiQ0Bh4dqnlWjkYHthShPozhkCI1eGaqyFVKu7f5t+rqKP1ZgMdDxECVIFmf1/lozD1oQHlQo/lrZkXkPt/YG24si1MLaGOpWrVBxfpvpilwcZMoEu1tL7Dgf4WF6aqSnRIFZItexHvtFPSARDkH8+W70bcokQQMaQQuwT8YHflKO5RhXmHjDRtkcPInbzlu6Gpazlmq4/uhQ7JNxSlTRMqYyszggvzEHh56OSIOjKEL5t7Idl3La/nzUh9yFZPRJ53b1Tfuio5KOdIN9XckR5lSismWxKgav0ZyLQkFlyGBvH2539JYqzCr7IgKpoJAHfVQnm5MPF16gF5w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=bbk70xHFEmQ/2u9XDkMrhYv675MmxVWNOWnrsUxpno4=;
 b=A36pHC0DGN9MeoUgY2++hUHSwiBTPC3uEixZgMGZA4WfZIvP481VoW4yjS0KvcuEsa2SsKjkho4kgLpxj2GFug7qc0VlGM3oVdruSkJLCKHWKA0m5jhbEhke8wO6jN83tnyPPyTtNqxoogv6VhzrVvVwkAQl5EGyN3Se8+u1de9wrNl9k9ZrduIkupPthwgPDkXlP+cA1ia09g8t+IsLoLP3G2CeExUUaoX5X0u4aHVK3V6xOCv57ZiqNeViiehFFrEo07VqO3vDZKNySU04rH0pJvfhplOZCXWFSHajO6q3BvUXwVEcEC60ycM7SiJ+DY748hWMqT6kOyz2//Tppw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from DM4PR11MB6117.namprd11.prod.outlook.com (2603:10b6:8:b3::19) by
 DS4PPF900531A26.namprd11.prod.outlook.com (2603:10b6:f:fc02::3b) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9769.21; Sat, 4 Apr
 2026 10:07:06 +0000
Received: from DM4PR11MB6117.namprd11.prod.outlook.com
 ([fe80::d9b3:e942:2686:3cdd]) by DM4PR11MB6117.namprd11.prod.outlook.com
 ([fe80::d9b3:e942:2686:3cdd%6]) with mapi id 15.20.9769.017; Sat, 4 Apr 2026
 10:07:06 +0000
Date: Sat, 4 Apr 2026 12:07:00 +0200
From: Maciej Fijalkowski <maciej.fijalkowski@intel.com>
To: Jakub Kicinski <kuba@kernel.org>
CC: <netdev@vger.kernel.org>, <bpf@vger.kernel.org>,
	<magnus.karlsson@intel.com>, <stfomichev@gmail.com>, <pabeni@redhat.com>,
	<horms@kernel.org>, <larysa.zaremba@intel.com>,
	<aleksander.lobakin@intel.com>, <bjorn@kernel.org>, Stanislav Fomichev
	<sdf@fomichev.me>
Subject: Re: [PATCH v6 net 1/8] xsk: tighten UMEM headroom validation to
 account for tailroom and min frame
Message-ID: <adDixAXZRpvcRJkR@boxer>
References: <20260402154958.562179-1-maciej.fijalkowski@intel.com>
 <20260402154958.562179-2-maciej.fijalkowski@intel.com>
 <20260403170126.276f9623@kernel.org>
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <20260403170126.276f9623@kernel.org>
X-ClientProxiedBy: VI1PR04CA0126.eurprd04.prod.outlook.com
 (2603:10a6:803:f0::24) To DM4PR11MB6117.namprd11.prod.outlook.com
 (2603:10b6:8:b3::19)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM4PR11MB6117:EE_|DS4PPF900531A26:EE_
X-MS-Office365-Filtering-Correlation-Id: 727f6e80-ecfe-47d3-de46-08de9231ed41
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|366016|1800799024|18002099003|56012099003|22082099003;
X-Microsoft-Antispam-Message-Info: CimtagAAMIjFk6L10k11mZK7mXzqKqFhwo+H5UVp65L3DV4e5cZlW4yEVqWsRtf5i/xRM9eBJZFuMb7ql77L+RoBElJ1looSGn9R09G0Sx6CrYyS1AymzjEwGBicBOblZQF742A0EgNOcWKLX2uE79wqG1hneyjD7WJ30GY9vUKbYxbmneEcYgbGQRuJ6lqCyeDoTvaBsgDvpyUyKtiG7Y3Rt9/C40yU7xaGnDY8p9WN5KuiyA2LBPkLFGBhm4ZF/oUf3HpeTz7HDHNzV2EP/6T0ZbZ2Ed6AZtTklbX41lSQCYdB+/3G7Bf45YgfxluSsI7IR3EO5mvcpUHu7UXdv1SvXOcYuUi7uy5waYThYotlYgzoI5CAl+1/gU89vsV965ZxzVJ8yh0iRNjEcGr/qCL5jxz2RlgfzszTyJmQYmM7u+jA+PIlnuDhsBaowRhWW1Ep0zubYQUDbaE/yDuvoeGCiIaDo3v5/8NcRpV0ysYchpl0MZ40wry71vVVWuCtaRCrppdxRjvtFpUbhE3GaH8ZwcIryKzRsZcQxqZYr9FEWicVmskzUAJm/IIKFQVMcd+s74HjF4ADL/STVDGoLKqkACVyjXPN8Uqyi8+YQz++01QBIVqTnI/UdowEwVXW/ieEF6gf1L1Ubuf19tIZWTNp90h51Hm4rpc6g50f/BL1ngkl1TdZnBa1UM5wMGVTwbAo/+vwg4krHqA4W7tikcNcGElo9w9kNhuIOOWudAU=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM4PR11MB6117.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(366016)(1800799024)(18002099003)(56012099003)(22082099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?25RXxKAC6hndvaev0+g7GrRLIlJaJiITqzuf8S6rOcUYt8By7ZXvI99EKWmi?=
 =?us-ascii?Q?9plr2Emtf5MwSHt5bMBxqFh52uPE/Kvd7XDyYg5zNaj/ZDoxudb3ln9RaV3T?=
 =?us-ascii?Q?lmxwMr6xOHwGU6UllfEzp8kXOyZLRfwUiMW02ukRiOxV3JcyrkTiqwH5AUb8?=
 =?us-ascii?Q?+Q8K6aBivsdFORLV6xJQLJGlI+cCcwsF2i0u46HXuWzg3hOkNZfL4NoUI0ZY?=
 =?us-ascii?Q?feGSCm1aMMjszZ8S+zNVQNc++tEcrVnoQuPPAuci832vYgd73jV5IBPzve0I?=
 =?us-ascii?Q?kbUdN+qNlnZh0KGSRwfnsfPHfYoAE30kX5uVS4b/4ZLRHkrwuHOIifffmtmZ?=
 =?us-ascii?Q?48wvN3MMHbd5HhmA3USSMdlZVRAUizNUERF0r9SNec+nKuTQR2Q1GfLlTGCy?=
 =?us-ascii?Q?DJYnCdkVeeNK9Gi5IZBaSNvmiJOrNcSmzHZqkiB2Lvil6OHJPmPwujTL9T8b?=
 =?us-ascii?Q?TbgPc8LhSJPutA21MQzz0t/K+sPCEER3dJWoIC0X199V0ZkvDH6XAx211nis?=
 =?us-ascii?Q?7l5Rw/VuPKs3BO7ZIHVnLxzAorV/zjGPIkc16wrgt1jtJeZka9qMp7R1ZLho?=
 =?us-ascii?Q?FDP9AzyWDqz3yXmt2ylFNbuVitaLbGGx9B+p7KkHyUDkG7ntV9ESlypeB//n?=
 =?us-ascii?Q?1TtfXQmtMFbLFPpeKKwPH7iSkBMf3xIBIOuHIJpP/yb5uU1T2bqDYt0NpCH8?=
 =?us-ascii?Q?dCf8mV23oiNd4V49nPBCKlFbpPRzjm6SQh3L2QuVSK+ar0mJfWvveInEPN9m?=
 =?us-ascii?Q?Nfr3x1s3Jy0ZoapxVZleBgCaIvIgMgODPcLlhhQIF3mA5vGXM7vij00aJYwg?=
 =?us-ascii?Q?VSkViJkanvvUD+KOepAzif1ZsMU31k+DmrSdNDkz0L6HQN8gZco2hIep7pze?=
 =?us-ascii?Q?AIDkMfXADwh1Y1iy13H6wPt6+RA5OwAbxxxlmvpoeeWrkFwLFNf+hE5MJSKt?=
 =?us-ascii?Q?pgF5aRnspwUEpQNCCFsjJHVGx+wz8iPp3nnUgw04SmhgLMWElY8r1hk5FPph?=
 =?us-ascii?Q?cDdZXFUznXyDJM8Ds/L6qEkYfQy8MHjd9GR1i5pGNPj2n+znPdEgLweRCsVv?=
 =?us-ascii?Q?dLW+GEKVPzvakwE6xZiR9iHcvb7YqKINMBCzOTdR8RROsENxrGdCBhoRWc1m?=
 =?us-ascii?Q?DdzPcADRstbeChVh8nMMq7OYrJQPgz6w2045wAjm1f1M8c2mAnyTXiWfNh1g?=
 =?us-ascii?Q?yT4+UdbtCu1/nDuss2OZEua8DhjYxLN/WoOvxALP6Bm1XINuqV5VDSVeJyak?=
 =?us-ascii?Q?DnNS3DFCZYsz1dTiNJ2/7hpQHS+TRxGoVq4AGMt+K9+z+SYAEPT2O26CBrbT?=
 =?us-ascii?Q?vimphONC7iyMFMirU55xv6l1lXg/37FyzCzNHoy3hCX2FrpCqsu5x9VfYBSP?=
 =?us-ascii?Q?9g8YkpiKN8eDUud2+tNFhmOx8vQaHp6Cmlpg+3p/zxR+MUgzK87QySlZcHAG?=
 =?us-ascii?Q?KYWdXT8xU2P3hL+5DkORnPj2pza5ZnpWO2foPVzprg0zUoXsqvuBdySotpCO?=
 =?us-ascii?Q?zQmMVQmlqZ/MWVZLKpXVTac/YkptXpfUsOz1vh4AYWTALYuNts8umET7I8RL?=
 =?us-ascii?Q?X/OudjakGD9rB74Ru8TMq1GXIYuzHVBwEN5ZEu6HrNcZ16qV2B5303u5+FJl?=
 =?us-ascii?Q?He6r+oxxrDgxW2MQJAyiNk6d5+pB8V7h4ZKklDxvZzaLQmfgYvT9tvu+4aSZ?=
 =?us-ascii?Q?lbm0j0eOKTx0m9Ag7e86kucchrGpO8+rxt7mErI5QxsNv1TUamjFabSBc2eG?=
 =?us-ascii?Q?WGeUVeCSSRW6UMpBKZcGpVkl1f9032I=3D?=
X-Exchange-RoutingPolicyChecked: WvWrq95gzPiGk64y3ocZ/jd3j9tfkFtYhP5f2IEQuY28EIj38UOg+B05jneSGlQIFYKdeJyiXpCxCyuz913OI2pkC7I65kqVBi9UJLNtL+pOvPyHM9JlMvyZJwIiIcM1tFtyelrkZqME3ViZWQObPcet0aNlsxQ0F7ODf0kzNznGCB4wdyHV4VUwCr9ZnQ2wSs5zg7Ybu254+xrR/m7WsagsAx3XuHJSiF7iAT1em3lOU9T7wQxqXgFjAOFW9bG8+8Dt1KDCBp7nFZCCbVFN1157GltT+tWP5AIwKMXXyeyYAz8OSAXkKRRjgP2TIVBr+k3RFncih25PjbgcoZgQGw==
X-MS-Exchange-CrossTenant-Network-Message-Id: 727f6e80-ecfe-47d3-de46-08de9231ed41
X-MS-Exchange-CrossTenant-AuthSource: DM4PR11MB6117.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 04 Apr 2026 10:07:06.5574
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: JTKhYsFLKyvfyjRO89Nt2/vNgsq0nRBleKV1S/GmWH0EfRkt7XsIXWxu+H2HQ3oupME4CAc3VYK86oPVNQ2DnEiXII8JnRzZWLmEAYHQt2E=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS4PPF900531A26
X-OriginatorOrg: intel.com
X-Spamd-Result: default: False [0.34 / 15.00];
	ARC_REJECT(1.00)[cv is fail on i=2];
	MID_RHS_NOT_FQDN(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[intel.com,none];
	R_SPF_ALLOW(-0.20)[+ip4:172.105.105.114:c];
	R_DKIM_ALLOW(-0.20)[intel.com:s=Intel];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FREEMAIL_CC(0.00)[vger.kernel.org,intel.com,gmail.com,redhat.com,kernel.org,fomichev.me];
	TAGGED_FROM(0.00)[bounces-275350-lists,netdev=lfdr.de];
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns,intel.com:dkim];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	DKIM_TRACE(0.00)[intel.com:+];
	MISSING_XM_UA(0.00)[];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[maciej.fijalkowski@intel.com,netdev@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[netdev];
	RCPT_COUNT_SEVEN(0.00)[11];
	ASN(0.00)[asn:63949, ipnet:172.105.96.0/20, country:SG];
	RCVD_COUNT_SEVEN(0.00)[10]
X-Rspamd-Queue-Id: 894E639AB56
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

On Fri, Apr 03, 2026 at 05:01:26PM -0700, Jakub Kicinski wrote:
> On Thu,  2 Apr 2026 17:49:51 +0200 Maciej Fijalkowski wrote:
> > The current headroom validation in xdp_umem_reg() could leave us with
> > insufficient space dedicated to even receive minimum-sized ethernet
> > frame. Furthermore if multi-buffer would come to play then
> > skb_shared_info stored at the end of XSK frame would be corrupted.
> > 
> > HW typically works with 128-aligned sizes so let us provide this value
> > as bare minimum.
> > 
> > Multi-buffer setting is known later in the configuration process so
> > besides accounting for 128 bytes, let us also take care of tailroom space
> > upfront.
> 
> I guess it's a bit late to ask this, but am I the only one that has
> weird feelings about shinfo living in user-mapped memory?

This was the approach was picked to be consistent with XDP side and allow
to use mbuf related helpers. I can imagine you would be suggesting to pick
up pages from system page pool but that would be a major refactor (however
I have not put much not thought into it - i'm here without a coffee and in
easter mode).

Outside of this rewrite this set fixes existing memory corruption, so I
feel it is needed and we can think how should we address the concern you
are bringing up later?

