Return-Path: <netdev+bounces-222444-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 8DFFFB54420
	for <lists+netdev@lfdr.de>; Fri, 12 Sep 2025 09:46:53 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id B8B391B2724C
	for <lists+netdev@lfdr.de>; Fri, 12 Sep 2025 07:47:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4C3612857F5;
	Fri, 12 Sep 2025 07:46:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="mf5kcilE"
X-Original-To: netdev@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 277E9242D9D;
	Fri, 12 Sep 2025 07:46:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=198.175.65.19
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757663209; cv=fail; b=AupHpyjU7h5/8Al/P27uDLMAl675qNwitYB81IDOLiZO9Ml5TX7YOf9dpmyvFm1HWGYPzmkGwlbe4M4l0I+ZpxiYaqfwHS8ufpdo9S5ezrmMuoWPSEzcwuNZjASpZqmMN+gZkPE4NwYJV0wR6i6DFZ+T0A5aNk1xNql1tdoSjm4=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757663209; c=relaxed/simple;
	bh=dAZ/I3ggRqR8AQ9517MmOqI3GEvfHsoO5pbOF8rtp1Y=;
	h=Message-ID:Date:Subject:To:References:From:CC:In-Reply-To:
	 Content-Type:MIME-Version; b=XQHTc6A9hic5fN5Sy+4pL+YnWoTrBpoTspujm2Iyz396aDIuu+QjAKI4hXSryTGdjjt61oz/WoEuBMSrNAniHVJNABzZk2mAK/Ljj7gNrLZ/b0SFGcIza08Xj331MQlIWYaLVRrMITayRkYIUrRXUH7pQRFaE9ItEAkua8do71Q=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=mf5kcilE; arc=fail smtp.client-ip=198.175.65.19
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1757663208; x=1789199208;
  h=message-id:date:subject:to:references:from:cc:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=dAZ/I3ggRqR8AQ9517MmOqI3GEvfHsoO5pbOF8rtp1Y=;
  b=mf5kcilE499RkNGpzqm3TSD4IvB0QuZAnxewzD4MKLIjRqrNU5StXBk2
   w7I22yLbsyroEIGmUAto2zK01ZmanzNamluUr9Gmk10u5xYKdhW39UXB4
   d69oBv7jb/0Hl5yJQfAfEdyb1U8cQcP2gKEHgzOlYRJyLBc0/dcddYZLO
   5yHa61jI0ldWFeCYURyTOH24D2frVaJkZ35U8hghtgqzFr5dC2aCTnDtb
   i5LOQcpnCIYMcjya+odM/cAvkDPGYby/ZPz/2lMMX+yOUYRpm0tkC0FY2
   mwYpOiSjJJ9CY/Jc/VLBgO9t7BLUrt3YNsnfuzBJaA+zw5rkh/xB4VetS
   g==;
X-CSE-ConnectionGUID: rDhiPDuATCuESg0B7Dny2g==
X-CSE-MsgGUID: nXWYMPXBRHGPv8rJaXbX1g==
X-IronPort-AV: E=McAfee;i="6800,10657,11550"; a="59863950"
X-IronPort-AV: E=Sophos;i="6.18,259,1751266800"; 
   d="scan'208";a="59863950"
Received: from orviesa009.jf.intel.com ([10.64.159.149])
  by orvoesa111.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 12 Sep 2025 00:46:47 -0700
X-CSE-ConnectionGUID: QdM5/fuyRoyMwAAl0AafUQ==
X-CSE-MsgGUID: UZxt/rR4SyOqhcNspdiV4Q==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.18,259,1751266800"; 
   d="scan'208";a="173452148"
Received: from fmsmsx903.amr.corp.intel.com ([10.18.126.92])
  by orviesa009.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 12 Sep 2025 00:46:47 -0700
Received: from FMSMSX901.amr.corp.intel.com (10.18.126.90) by
 fmsmsx903.amr.corp.intel.com (10.18.126.92) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.17; Fri, 12 Sep 2025 00:46:45 -0700
Received: from fmsedg901.ED.cps.intel.com (10.1.192.143) by
 FMSMSX901.amr.corp.intel.com (10.18.126.90) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.17 via Frontend Transport; Fri, 12 Sep 2025 00:46:45 -0700
Received: from NAM12-BN8-obe.outbound.protection.outlook.com (40.107.237.88)
 by edgegateway.intel.com (192.55.55.81) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.17; Fri, 12 Sep 2025 00:46:45 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=vadEDB4EbueE8qljRU7LqPxSBfu355P2xCkf3EOu0vIVQ3RxGOQOwCzppR8aiM3MFm7LfXinvMs/NPjKrTVLeJ9oZ4ZBMKpVK34Rs0ol3s1ERZh9axVQ+n2QeQP1nfqsFs3l5Fugu7Xs4WvL8zVBwn0o/o2e0xYw+h/R7wShlzSm9EUsJ+hgyzKs79o1fh5XsxlP05SGF1lHCLsBrU3KO+zLUjJXT1EN5py6g9YCfLlLMP/7Raf7VId0Wjc1Bp+wnLvE6jIqofb/HIsJACXDHRqignXK8SLqVWd6+J7wpUxEIPBmuNKt0+eLaalEXgDwC4q7xZlC6Jqk7Py3kHp5zA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=06gClTpPjoPHUqXCuMyFerkDkLMTlGDZjFwv9kxAKLg=;
 b=cwwzEl7Z+V7Vc+wBGhG1NJSiNmj+RWhRgaLbksLMnXfV3xMgwiv0gjKWVCD+MmH3h1sgezQCIhgV0qOWE0NOtVjkxZaDwHbaDRDiPiIhjown1xV7JLTT1dJBzRzo7EXdInCgdVpVOF4hdWSdwldbeS2ac/Nqr+QTSzPaaxvuvs2gQA9aYZzU3Hmz03A3P48lKiOJ7S2QFD0RzyhTGrYhBaV+dTxX8c2XRBPXoZpjmy9avGlIrTNDvyhwfmYo6CjmhIwgT/kC8BzmAxGt/VBF+mHJG5fm9VINv6vEQhqp3aD9qRpfAnsLUH6fp0+gBszwrNZ9c0Pmm7q1aZHal3wUbg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from MN6PR11MB8102.namprd11.prod.outlook.com (2603:10b6:208:46d::9)
 by DM6PR11MB4547.namprd11.prod.outlook.com (2603:10b6:5:2a1::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9094.22; Fri, 12 Sep
 2025 07:46:37 +0000
Received: from MN6PR11MB8102.namprd11.prod.outlook.com
 ([fe80::15b2:ee05:2ae7:cfd6]) by MN6PR11MB8102.namprd11.prod.outlook.com
 ([fe80::15b2:ee05:2ae7:cfd6%6]) with mapi id 15.20.9094.021; Fri, 12 Sep 2025
 07:46:37 +0000
Message-ID: <95c067ea-6c48-4a94-8f76-ae4cdbdfabeb@intel.com>
Date: Fri, 12 Sep 2025 09:46:32 +0200
User-Agent: Mozilla Thunderbird
Subject: Re: [Intel-wired-lan] [PATCH v3 5/5] ice: refactor to use helpers
To: Jacob Keller <jacob.e.keller@intel.com>
References: <20250911-resend-jbrandeb-ice-standard-stats-v3-0-1bcffd157aa5@intel.com>
 <20250911-resend-jbrandeb-ice-standard-stats-v3-5-1bcffd157aa5@intel.com>
From: Przemek Kitszel <przemyslaw.kitszel@intel.com>
Content-Language: en-US
CC: Jesse Brandeburg <jbrandeburg@cloudflare.com>, Jakub Kicinski
	<kuba@kernel.org>, Hariprasad Kelam <hkelam@marvell.com>, Simon Horman
	<horms@kernel.org>, Marcin Szycik <marcin.szycik@linux.intel.com>, "Rahul
 Rameshbabu" <rrameshbabu@nvidia.com>, <netdev@vger.kernel.org>,
	<intel-wired-lan@lists.osuosl.org>, <linux-doc@vger.kernel.org>,
	<corbet@lwn.net>
In-Reply-To: <20250911-resend-jbrandeb-ice-standard-stats-v3-5-1bcffd157aa5@intel.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: DU7P194CA0010.EURP194.PROD.OUTLOOK.COM
 (2603:10a6:10:553::13) To MN6PR11MB8102.namprd11.prod.outlook.com
 (2603:10b6:208:46d::9)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MN6PR11MB8102:EE_|DM6PR11MB4547:EE_
X-MS-Office365-Filtering-Correlation-Id: 82c72a6c-fd45-43b5-97bf-08ddf1d080b5
X-LD-Processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|7416014|1800799024|376014|366016;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?b2svZEdyNXdBYUYrM3FIQVBncktFRjdIMmJRK256U1JMeFVxRVFkalRaL0Zk?=
 =?utf-8?B?K0Q2ZTNjU2NtMTJpb0JpZ25GOWZ6QVNMbnMvUVJoZGxUSXZENWFIWlVwcHFM?=
 =?utf-8?B?SXQ2MGpBSFZFTXduZW1NY0w1OGtBbjE5c3YwRFhTdy9PWkFuemtVQXBicHpo?=
 =?utf-8?B?eEMzd2VRU29qWjR3NWs4aUZIVXdQQitXQUFEZ3RUOTRFUzYyUlRtaUVUMVZI?=
 =?utf-8?B?WSt3SCtBd3FaT3Z4VEhraDcwQmRSYmlNcllkYktSeDJ3dmZRSGoxM2JqTzZE?=
 =?utf-8?B?VDlhYzY2Uks0WmVKcFJnMzBJNThRNTBBZHpYdVc3NjVJVUlGWSszTnY3aWRP?=
 =?utf-8?B?elZGYmI1N21CSVhaNmFXTEJMSUdCR2VjNEgrQllIK3VQSjlEeHBaa2ZRalBv?=
 =?utf-8?B?UUEyV3hRcGppc3hUQWg0Vm5rQmFVY3FQbDBnemZrQTdlc3FOcmJTMUJkbk9x?=
 =?utf-8?B?blNmbU9HMzhudkdvUFpnUWpLNUJ3QWNnWGpQVFFmQXRiMkR3TlFraS94ZS9n?=
 =?utf-8?B?S1VBeTl1ZmF6Qjh5YllqNStBNWdEVm1CcFlFc3BRd3JockZrRDB3dEx0WmlD?=
 =?utf-8?B?THF3NldEK2dESGtLcTZiVWRXUitsYTUzWVkzVHN6SUUrcDd2TS92MmJ2VFQz?=
 =?utf-8?B?bVNSOVlKRDdTUE1MWk1nZVpMN3F4ZU9QVkFWY0d5YzZ2R1o5NmdTNXB6U2dD?=
 =?utf-8?B?eEN0a2ZiQ0N2WlhPbVZZbkRQWXlMbFJqQXFJZmRXY0FVRWpjMk5LVktOMVUz?=
 =?utf-8?B?L1hkMDI2eWF1NXk5TEpqOHpvOWkrRDY1cXgxajdXQm1nVFppZHNOV1hKSlJF?=
 =?utf-8?B?N3JWVVA0c3VtbzhrT3A4enVZdXU1VWcra2lURUUyR1hDMjYwQUxYQkdFTkVX?=
 =?utf-8?B?bFBpRFlPV3RRckx3WTZWcjZ6Y25GNUdHM1FpM3dYSVdMTDNRSDJ6L0czR3Jl?=
 =?utf-8?B?N0d6Q2FZRnFRbERZV1FQUmpncEQwTTZ3cjFxQ3YxVTl1Z1FaY2drQzlkNVBp?=
 =?utf-8?B?YXJnd3hSNVh5ejVseTF0T2pXSVZ1SUNYZmlhZ1JCZTgwMUQ3cyt3WnkyU0RC?=
 =?utf-8?B?NCsvaTNFd2pRTUd1cnVPVnQvL0FKY2F1K2NyY1BIOE8zL1NFMENkMjdOWTBX?=
 =?utf-8?B?aE9rdm40Rkk0bXNTZWNKRFBjbzFSeDhnMlN1Zm1RSkNqTkJ0WjBCQXAzVFZy?=
 =?utf-8?B?NDUwVGF6eVFFc3RJSGNQK0FXQ3F0NDNwbXJCTWlyOU1qb1JxSFpMYTNuSlRS?=
 =?utf-8?B?YUlwc2JnVk5jMkIvS1F2LzlJR21vSWNvY1ljUXhubWVWNUVIQitSb0MwTXQy?=
 =?utf-8?B?aTF2eUlxQXE5SGpUQUt3Z2pzUWQ1WkR0aExnZ21aZHF1TG05SW42WmNNRzBK?=
 =?utf-8?B?QUZzVzJaUnQ2WDR6Mi93VlBLSUNoUUkyb2NncHVmcjlKSGZXYjFOL01jaENM?=
 =?utf-8?B?eWNNRUk2Yk41NGFIOTRLTTB6VENBeXgrQlAyOThya2hoTmtVd1d3dmNBVGl5?=
 =?utf-8?B?Szdha0ROaUxsR3hxTEtlbkdVL0p2K2czNENYQVo5Q0NiYjBUZ1RIUE0zNlNj?=
 =?utf-8?B?VUNUQnNZNXJYMnF1R21hYW9lZStYblMrTWc0WW91NW1TenlGak96V01BZUF6?=
 =?utf-8?B?b0RYMFkzQ3J5b0lkdmg5OHJ1blRSMTdhSkN1UE90b1lud1JlQTBVeUJwYVJM?=
 =?utf-8?B?RFBjL2k3QUw1VUxpWHNta0tvd1pnKzBSdGZMWUhETUcxSXo2b2RoRmR6QUZs?=
 =?utf-8?B?TmZKMHpJVnVOVmcyVTlPRUhHTVo4UVdvZ0x4aEEyRmdsRG5sUzdzb01sS1FP?=
 =?utf-8?B?YVNKeEFUMUpNcXIzblA1K1JhWmJscXhDQU9FV1pERnBZSWZzOExXWTUxQ01w?=
 =?utf-8?B?azFtRGs2YkdJVWs4bUI5dy9zbWgvRjVhZi85NTlvT011cHpZOEdnZTVJK3k5?=
 =?utf-8?Q?Zk6ZkRPjFNc=3D?=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MN6PR11MB8102.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(7416014)(1800799024)(376014)(366016);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?Tm5rTmpmTTN3eEtreTQxRUZoZFo4clBNc2xOMnQ3aDNZMXZZSDEzdk5JRFBN?=
 =?utf-8?B?Mm0zeXFNazgyME1NMm5BQUVXRXFkK0JwVitpbFlPME9DYXFiWDJsYk9TN3Zm?=
 =?utf-8?B?NlFvYnhHU3BzWjYzd01nTjFMZHFRWnJyZGlFdk9sWll5aUI3K29GZzlYbWdj?=
 =?utf-8?B?OVh1OUUzaW9Hc0F0OC95ZC9GclFQRlIrd2dJMzZUejdiTGhzTHZHVDNXWGIy?=
 =?utf-8?B?OWRaUmNlT1o5L3AwNlNqdGdSRmVxRXFxdFRWbzVSSlRyZS9QNmVEbmVPWW9T?=
 =?utf-8?B?Tndad2xuWFNKY1BSMVVMQ0FYZUorMWFxdklqdEtLM0VoMEp4a1Y1R0s2Nm1w?=
 =?utf-8?B?VHJqWDBZZWV0emJWV2gwKzRpWWtJTFg5TmV3L0ltODFndmE2ejB0aVlsc1NZ?=
 =?utf-8?B?U0VVNXl5bGVKSlpxeTEvUTJIUEdqMFJaREg4UGhGYVlZTUh4TlpXU1ppWDRj?=
 =?utf-8?B?NTdtQ2lmWVV3Z1VpaTFLSUo2dzRuR0RTcTBSN1h6MHRlb1ZPOEEvN1cyZXIy?=
 =?utf-8?B?RHhPczA2RzBtbWF5VEdQNmF2ZnFWQmp1RTFKU0VJQURPbmFGRy9PQ2lSYjRv?=
 =?utf-8?B?VTUxR2JxajhnSzR4elhqWVpKcW5PYWdVTXNWY2lraXpKVCtRUDBGaCtHN3g2?=
 =?utf-8?B?WVhhTjZIYjRKS1gxWE5UVXFvSkZ5ZXg4NEorSlhqaEdiTHFjTGlRT2U3QUtI?=
 =?utf-8?B?TEVVOWFyT2tQZlFQbitCbXZnWFRUZ2dVSytac1VaQ3U4Sm12aHF1R25HRndT?=
 =?utf-8?B?Q212VGRhemhSUXJ5blZuLzY0VHpyTTdmZkl3aXhPQzhrS0hEVDgxeEFJVnM1?=
 =?utf-8?B?NkhSd2hJam9XcDdTdldUdEd4TXN6SFNKcUw4TzNIL215ZTRBcUNLOGVyWlov?=
 =?utf-8?B?cE9RaEVvTDJTSVd3STlqbjgyOUlwbkhxQjBndkMyOHA2VlorYys4blozenpF?=
 =?utf-8?B?Q2ZpeUREbXV5R0hDK2FHZVp5aFVNWkJCRXB5WlZtUXhOUy9jazh5dnpVNmlP?=
 =?utf-8?B?KzlGaEhCTXh6ZDNBMm9uN1ZxM3hQTVl4VUkvVUZzT1ZFOWpKaVU2Tk81SmV0?=
 =?utf-8?B?QlR4aFA3SnBaR3FveFplMjlBZTNjVnFPT0Mvd0VsVU1ISTM3Y2tRYk5nd1Bn?=
 =?utf-8?B?UDdZTkxnUktaYUdxYXdydkJMTjE1Wk9abnVWVlBaQlhYT1VrRjJPVjlWTS9m?=
 =?utf-8?B?UUV5UVd5VnBIU1ZOZ044c2hTR1EvNWdUckhibzBZM2NQc0N5KzJPSUJqTnoy?=
 =?utf-8?B?TmIva1lYYktmQklOdllMbE1LV3FxeElpTWsyMXkyVisvWExERzFBZE96NnZt?=
 =?utf-8?B?N3lQOWFzdnhuNSsrUjIzTGFZdExjOHhwVkhLRTBsS29rM1pqelFOcDNCTUto?=
 =?utf-8?B?ZjZmM2pJVGVLbjh2UkpPdk02Tm9JalFjU1lYRll3ckdiY0F6d0IxQnJyU2xi?=
 =?utf-8?B?OVFsL0lWd0FuWHVNMXJWMnJLWTI1TndMdzV6WTNHR3dBbkpwMVpSR2tkQk1h?=
 =?utf-8?B?dFJBK1NnR3YrbjJkM1hkVklMeXJlclk1cEtGNWQ3OXJ6UkE2VDgxY2NaeEZh?=
 =?utf-8?B?dWhzdnRhQWtVd1ovYno3N0VqdlYrbTZNQ2s3UFowQVkzcWNjRVBiVnZTckY2?=
 =?utf-8?B?aW5qM2VabHZpamZIQ2FKQVJjWTl2cnlpMWdYQjlaMUJsL1hSdlJqWThCU1JS?=
 =?utf-8?B?TDJvUlpJYkVoS0JIdWFIZzhhanVXK1A1V1MrWkk3akdJMEJnU08yUXpZdU5y?=
 =?utf-8?B?NzhvZWpOV0oyVGROSEMwQVV2VXZRVDRhbVMyU3ZiQ2JxSE1lMHp4aVBNYjN4?=
 =?utf-8?B?UmVvTkVmZVZTRjEwOTh1Y0VPMHZQcENLYUdiU1ArV1hrTjhQZ2VuVG8yQy9C?=
 =?utf-8?B?VTk4RWNKbEJBUWlTVGlsanlyTkF5L0MzZThTLzNoeWNQVm5YK3dNdXk0OWY4?=
 =?utf-8?B?ZUI2ajE5ZFZ3STdUa3YyTGpPZC9meWFUV0NrazZ0TTVxc2JSdjBWSVErYUV6?=
 =?utf-8?B?byt5bUhhSFZUVEw1a053MVdocjU0WXdvQlJzU2tXYXVUY3RPcnVLWkdhRE9E?=
 =?utf-8?B?WXJRZ2ZwZEFXUXoyMUZyRzk0aGdDZ01kUnZnNXZPUVhwL0ozVVNjZ3plSEgw?=
 =?utf-8?B?ckpnTnNMeFZuaklqVk9ldmZvKzRwbXYxSzN6dlUzZWQ2eHNtbzNWUS94NCts?=
 =?utf-8?B?YkE9PQ==?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 82c72a6c-fd45-43b5-97bf-08ddf1d080b5
X-MS-Exchange-CrossTenant-AuthSource: MN6PR11MB8102.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 12 Sep 2025 07:46:37.2796
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: dZSw9XUcVqdGxJbsgWEudEA8MKTuZuMt00ytjnkvG38rNptCuIQWobK0+Jrm4o/cVTk7RRWqM/x46jhm7KN6Ykvybsb01PfvA3B/0HNWVsQ=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR11MB4547
X-OriginatorOrg: intel.com

On 9/12/25 01:40, Jacob Keller wrote:
> From: Jesse Brandeburg <jesse.brandeburg@intel.com>
> 
> Use the ice_netdev_to_pf() helper in more places and remove a bunch of
> boilerplate code. Not every instance could be replaced due to use of the
> netdev_priv() output or the vsi variable within a bunch of functions.
> 
> Signed-off-by: Jesse Brandeburg <jesse.brandeburg@intel.com>
> Signed-off-by: Jacob Keller <jacob.e.keller@intel.com>

no controversies here :)
Reviewed-by: Przemek Kitszel <przemyslaw.kitszel@intel.com>
(assuming this is for iwl-next)

> ---
>   drivers/net/ethernet/intel/ice/ice_ethtool.c   | 48 ++++++++------------------
>   drivers/net/ethernet/intel/ice/ice_flex_pipe.c |  8 ++---
>   drivers/net/ethernet/intel/ice/ice_lag.c       |  3 +-
>   drivers/net/ethernet/intel/ice/ice_main.c      | 10 ++----
>   drivers/net/ethernet/intel/ice/ice_ptp.c       |  6 ++--
>   drivers/net/ethernet/intel/ice/ice_sriov.c     |  3 +-
>   6 files changed, 24 insertions(+), 54 deletions(-)
> 
> diff --git a/drivers/net/ethernet/intel/ice/ice_ethtool.c b/drivers/net/ethernet/intel/ice/ice_ethtool.c
> index f8bb2d55b28c..0b99a7b863d8 100644
> --- a/drivers/net/ethernet/intel/ice/ice_ethtool.c
> +++ b/drivers/net/ethernet/intel/ice/ice_ethtool.c
> @@ -794,8 +794,7 @@ static int ice_get_extended_regs(struct net_device *netdev, void *p)
>   static void
>   ice_get_regs(struct net_device *netdev, struct ethtool_regs *regs, void *p)
>   {
> -	struct ice_netdev_priv *np = netdev_priv(netdev);
> -	struct ice_pf *pf = np->vsi->back;
> +	struct ice_pf *pf = ice_netdev_to_pf(netdev);
>   	struct ice_hw *hw = &pf->hw;
>   	u32 *regs_buf = (u32 *)p;
>   	unsigned int i;
> @@ -810,8 +809,7 @@ ice_get_regs(struct net_device *netdev, struct ethtool_regs *regs, void *p)
>   
>   static u32 ice_get_msglevel(struct net_device *netdev)
>   {
> -	struct ice_netdev_priv *np = netdev_priv(netdev);
> -	struct ice_pf *pf = np->vsi->back;
> +	struct ice_pf *pf = ice_netdev_to_pf(netdev);
>   
>   #ifndef CONFIG_DYNAMIC_DEBUG
>   	if (pf->hw.debug_mask)
> @@ -824,8 +822,7 @@ static u32 ice_get_msglevel(struct net_device *netdev)
>   
>   static void ice_set_msglevel(struct net_device *netdev, u32 data)
>   {
> -	struct ice_netdev_priv *np = netdev_priv(netdev);
> -	struct ice_pf *pf = np->vsi->back;
> +	struct ice_pf *pf = ice_netdev_to_pf(netdev);
>   
>   #ifndef CONFIG_DYNAMIC_DEBUG
>   	if (ICE_DBG_USER & data)
> @@ -840,16 +837,14 @@ static void ice_set_msglevel(struct net_device *netdev, u32 data)
>   static void ice_get_link_ext_stats(struct net_device *netdev,
>   				   struct ethtool_link_ext_stats *stats)
>   {
> -	struct ice_netdev_priv *np = netdev_priv(netdev);
> -	struct ice_pf *pf = np->vsi->back;
> +	struct ice_pf *pf = ice_netdev_to_pf(netdev);
>   
>   	stats->link_down_events = pf->link_down_events;
>   }
>   
>   static int ice_get_eeprom_len(struct net_device *netdev)
>   {
> -	struct ice_netdev_priv *np = netdev_priv(netdev);
> -	struct ice_pf *pf = np->vsi->back;
> +	struct ice_pf *pf = ice_netdev_to_pf(netdev);
>   
>   	return (int)pf->hw.flash.flash_size;
>   }
> @@ -858,9 +853,7 @@ static int
>   ice_get_eeprom(struct net_device *netdev, struct ethtool_eeprom *eeprom,
>   	       u8 *bytes)
>   {
> -	struct ice_netdev_priv *np = netdev_priv(netdev);
> -	struct ice_vsi *vsi = np->vsi;
> -	struct ice_pf *pf = vsi->back;
> +	struct ice_pf *pf = ice_netdev_to_pf(netdev);
>   	struct ice_hw *hw = &pf->hw;
>   	struct device *dev;
>   	int ret;
> @@ -959,8 +952,7 @@ static u64 ice_link_test(struct net_device *netdev)
>    */
>   static u64 ice_eeprom_test(struct net_device *netdev)
>   {
> -	struct ice_netdev_priv *np = netdev_priv(netdev);
> -	struct ice_pf *pf = np->vsi->back;
> +	struct ice_pf *pf = ice_netdev_to_pf(netdev);
>   
>   	netdev_info(netdev, "EEPROM test\n");
>   	return !!(ice_nvm_validate_checksum(&pf->hw));
> @@ -1277,9 +1269,8 @@ static int ice_lbtest_receive_frames(struct ice_rx_ring *rx_ring)
>    */
>   static u64 ice_loopback_test(struct net_device *netdev)
>   {
> -	struct ice_netdev_priv *np = netdev_priv(netdev);
> -	struct ice_vsi *orig_vsi = np->vsi, *test_vsi;
> -	struct ice_pf *pf = orig_vsi->back;
> +	struct ice_pf *pf = ice_netdev_to_pf(netdev);
> +	struct ice_vsi *test_vsi;
>   	u8 *tx_frame __free(kfree) = NULL;
>   	u8 broadcast[ETH_ALEN], ret = 0;
>   	int num_frames, valid_frames;
> @@ -1368,8 +1359,7 @@ static u64 ice_loopback_test(struct net_device *netdev)
>    */
>   static u64 ice_intr_test(struct net_device *netdev)
>   {
> -	struct ice_netdev_priv *np = netdev_priv(netdev);
> -	struct ice_pf *pf = np->vsi->back;
> +	struct ice_pf *pf = ice_netdev_to_pf(netdev);
>   	u16 swic_old = pf->sw_int_count;
>   
>   	netdev_info(netdev, "interrupt test\n");
> @@ -1397,9 +1387,8 @@ static void
>   ice_self_test(struct net_device *netdev, struct ethtool_test *eth_test,
>   	      u64 *data)
>   {
> -	struct ice_netdev_priv *np = netdev_priv(netdev);
> +	struct ice_pf *pf = ice_netdev_to_pf(netdev);
>   	bool if_running = netif_running(netdev);
> -	struct ice_pf *pf = np->vsi->back;
>   	struct device *dev;
>   
>   	dev = ice_pf_to_dev(pf);
> @@ -1723,9 +1712,7 @@ static int ice_nway_reset(struct net_device *netdev)
>    */
>   static u32 ice_get_priv_flags(struct net_device *netdev)
>   {
> -	struct ice_netdev_priv *np = netdev_priv(netdev);
> -	struct ice_vsi *vsi = np->vsi;
> -	struct ice_pf *pf = vsi->back;
> +	struct ice_pf *pf = ice_netdev_to_pf(netdev);
>   	u32 i, ret_flags = 0;
>   
>   	for (i = 0; i < ICE_PRIV_FLAG_ARRAY_SIZE; i++) {
> @@ -4413,9 +4400,7 @@ static int
>   ice_get_module_info(struct net_device *netdev,
>   		    struct ethtool_modinfo *modinfo)
>   {
> -	struct ice_netdev_priv *np = netdev_priv(netdev);
> -	struct ice_vsi *vsi = np->vsi;
> -	struct ice_pf *pf = vsi->back;
> +	struct ice_pf *pf = ice_netdev_to_pf(netdev);
>   	struct ice_hw *hw = &pf->hw;
>   	u8 sff8472_comp = 0;
>   	u8 sff8472_swap = 0;
> @@ -4487,12 +4472,10 @@ static int
>   ice_get_module_eeprom(struct net_device *netdev,
>   		      struct ethtool_eeprom *ee, u8 *data)
>   {
> -	struct ice_netdev_priv *np = netdev_priv(netdev);
> +	struct ice_pf *pf = ice_netdev_to_pf(netdev);
>   #define SFF_READ_BLOCK_SIZE 8
>   	u8 value[SFF_READ_BLOCK_SIZE] = { 0 };
>   	u8 addr = ICE_I2C_EEPROM_DEV_ADDR;
> -	struct ice_vsi *vsi = np->vsi;
> -	struct ice_pf *pf = vsi->back;
>   	struct ice_hw *hw = &pf->hw;
>   	bool is_sfp = false;
>   	unsigned int i, j;
> @@ -4768,8 +4751,7 @@ static void ice_get_ts_stats(struct net_device *netdev,
>    */
>   static int ice_ethtool_reset(struct net_device *dev, u32 *flags)
>   {
> -	struct ice_netdev_priv *np = netdev_priv(dev);
> -	struct ice_pf *pf = np->vsi->back;
> +	struct ice_pf *pf = ice_netdev_to_pf(dev);
>   	enum ice_reset_req reset;
>   
>   	switch (*flags) {
> diff --git a/drivers/net/ethernet/intel/ice/ice_flex_pipe.c b/drivers/net/ethernet/intel/ice/ice_flex_pipe.c
> index fc94e189e52e..c2caee083ca7 100644
> --- a/drivers/net/ethernet/intel/ice/ice_flex_pipe.c
> +++ b/drivers/net/ethernet/intel/ice/ice_flex_pipe.c
> @@ -574,9 +574,7 @@ ice_destroy_tunnel(struct ice_hw *hw, u16 index, enum ice_tunnel_type type,
>   int ice_udp_tunnel_set_port(struct net_device *netdev, unsigned int table,
>   			    unsigned int idx, struct udp_tunnel_info *ti)
>   {
> -	struct ice_netdev_priv *np = netdev_priv(netdev);
> -	struct ice_vsi *vsi = np->vsi;
> -	struct ice_pf *pf = vsi->back;
> +	struct ice_pf *pf = ice_netdev_to_pf(netdev);
>   	enum ice_tunnel_type tnl_type;
>   	int status;
>   	u16 index;
> @@ -598,9 +596,7 @@ int ice_udp_tunnel_set_port(struct net_device *netdev, unsigned int table,
>   int ice_udp_tunnel_unset_port(struct net_device *netdev, unsigned int table,
>   			      unsigned int idx, struct udp_tunnel_info *ti)
>   {
> -	struct ice_netdev_priv *np = netdev_priv(netdev);
> -	struct ice_vsi *vsi = np->vsi;
> -	struct ice_pf *pf = vsi->back;
> +	struct ice_pf *pf = ice_netdev_to_pf(netdev);
>   	enum ice_tunnel_type tnl_type;
>   	int status;
>   
> diff --git a/drivers/net/ethernet/intel/ice/ice_lag.c b/drivers/net/ethernet/intel/ice/ice_lag.c
> index aebf8e08a297..d2576d606e10 100644
> --- a/drivers/net/ethernet/intel/ice/ice_lag.c
> +++ b/drivers/net/ethernet/intel/ice/ice_lag.c
> @@ -2177,8 +2177,7 @@ static void ice_lag_chk_disabled_bond(struct ice_lag *lag, void *ptr)
>    */
>   static void ice_lag_disable_sriov_bond(struct ice_lag *lag)
>   {
> -	struct ice_netdev_priv *np = netdev_priv(lag->netdev);
> -	struct ice_pf *pf = np->vsi->back;
> +	struct ice_pf *pf = ice_netdev_to_pf(lag->netdev);
>   
>   	ice_clear_feature_support(pf, ICE_F_SRIOV_LAG);
>   	ice_clear_feature_support(pf, ICE_F_SRIOV_AA_LAG);
> diff --git a/drivers/net/ethernet/intel/ice/ice_main.c b/drivers/net/ethernet/intel/ice/ice_main.c
> index 249fd3c050eb..9994a9479082 100644
> --- a/drivers/net/ethernet/intel/ice/ice_main.c
> +++ b/drivers/net/ethernet/intel/ice/ice_main.c
> @@ -8043,9 +8043,7 @@ static int
>   ice_bridge_getlink(struct sk_buff *skb, u32 pid, u32 seq,
>   		   struct net_device *dev, u32 filter_mask, int nlflags)
>   {
> -	struct ice_netdev_priv *np = netdev_priv(dev);
> -	struct ice_vsi *vsi = np->vsi;
> -	struct ice_pf *pf = vsi->back;
> +	struct ice_pf *pf = ice_netdev_to_pf(dev);
>   	u16 bmode;
>   
>   	bmode = pf->first_sw->bridge_mode;
> @@ -8115,8 +8113,7 @@ ice_bridge_setlink(struct net_device *dev, struct nlmsghdr *nlh,
>   		   u16 __always_unused flags,
>   		   struct netlink_ext_ack __always_unused *extack)
>   {
> -	struct ice_netdev_priv *np = netdev_priv(dev);
> -	struct ice_pf *pf = np->vsi->back;
> +	struct ice_pf *pf = ice_netdev_to_pf(dev);
>   	struct nlattr *attr, *br_spec;
>   	struct ice_hw *hw = &pf->hw;
>   	struct ice_sw *pf_sw;
> @@ -9550,8 +9547,7 @@ ice_indr_setup_tc_cb(struct net_device *netdev, struct Qdisc *sch,
>    */
>   int ice_open(struct net_device *netdev)
>   {
> -	struct ice_netdev_priv *np = netdev_priv(netdev);
> -	struct ice_pf *pf = np->vsi->back;
> +	struct ice_pf *pf = ice_netdev_to_pf(netdev);
>   
>   	if (ice_is_reset_in_progress(pf->state)) {
>   		netdev_err(netdev, "can't open net device while reset is in progress");
> diff --git a/drivers/net/ethernet/intel/ice/ice_ptp.c b/drivers/net/ethernet/intel/ice/ice_ptp.c
> index d2ca9d7bcfc1..9b9b408c0adb 100644
> --- a/drivers/net/ethernet/intel/ice/ice_ptp.c
> +++ b/drivers/net/ethernet/intel/ice/ice_ptp.c
> @@ -2244,8 +2244,7 @@ static int ice_ptp_getcrosststamp(struct ptp_clock_info *info,
>   int ice_ptp_hwtstamp_get(struct net_device *netdev,
>   			 struct kernel_hwtstamp_config *config)
>   {
> -	struct ice_netdev_priv *np = netdev_priv(netdev);
> -	struct ice_pf *pf = np->vsi->back;
> +	struct ice_pf *pf = ice_netdev_to_pf(netdev);
>   
>   	if (pf->ptp.state != ICE_PTP_READY)
>   		return -EIO;
> @@ -2316,8 +2315,7 @@ int ice_ptp_hwtstamp_set(struct net_device *netdev,
>   			 struct kernel_hwtstamp_config *config,
>   			 struct netlink_ext_ack *extack)
>   {
> -	struct ice_netdev_priv *np = netdev_priv(netdev);
> -	struct ice_pf *pf = np->vsi->back;
> +	struct ice_pf *pf = ice_netdev_to_pf(netdev);
>   	int err;
>   
>   	if (pf->ptp.state != ICE_PTP_READY)
> diff --git a/drivers/net/ethernet/intel/ice/ice_sriov.c b/drivers/net/ethernet/intel/ice/ice_sriov.c
> index 843e82fd3bf9..6b1126ddb561 100644
> --- a/drivers/net/ethernet/intel/ice/ice_sriov.c
> +++ b/drivers/net/ethernet/intel/ice/ice_sriov.c
> @@ -1190,8 +1190,7 @@ ice_vf_lan_overflow_event(struct ice_pf *pf, struct ice_rq_event_info *event)
>    */
>   int ice_set_vf_spoofchk(struct net_device *netdev, int vf_id, bool ena)
>   {
> -	struct ice_netdev_priv *np = netdev_priv(netdev);
> -	struct ice_pf *pf = np->vsi->back;
> +	struct ice_pf *pf = ice_netdev_to_pf(netdev);
>   	struct ice_vsi *vf_vsi;
>   	struct device *dev;
>   	struct ice_vf *vf;
> 


