Return-Path: <netdev+bounces-210197-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 52884B125D9
	for <lists+netdev@lfdr.de>; Fri, 25 Jul 2025 22:52:51 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 0A4A8AA7F42
	for <lists+netdev@lfdr.de>; Fri, 25 Jul 2025 20:52:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2CDE5257422;
	Fri, 25 Jul 2025 20:52:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="UHNP3tEI"
X-Original-To: netdev@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.14])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7F30625178C;
	Fri, 25 Jul 2025 20:52:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=192.198.163.14
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753476767; cv=fail; b=mWc82uIznfsWSOGiCpKV++VzLNxYMvmsY8D7tcM67Z8jVLG/zWngOc3XPAzSgwSwHALBIAC678mcIa1ICUtvv0LRmnrsUb7Dl+rQcOqYY0nYmSL8YcWqquHJFAv5lhPnnPKi9gnWnw4wJxfB+0bEdCpolCFCyGpt1LTGZcz9YwQ=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753476767; c=relaxed/simple;
	bh=xxU4GT+Do4x1sF4fcqR0XVEtWo5tmxOPtvueViPYm4A=;
	h=From:Date:To:CC:Message-ID:In-Reply-To:References:Subject:
	 Content-Type:MIME-Version; b=AS8OdoNR4vMY2vCpJhrlNzbiNP/pS82cnoSpTWy1ntcf0VvVGJmzpw5v2RatAvR6gEoNuqMdRpx2i+cB/iu9jRECQpps4O7Xgz2RI1OCefty8SToUiUUyrZe35L+oL2FxUdLoan4gY9e8nG7/CNF8xDwgCb30Bgtdwf/MXfYntg=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=UHNP3tEI; arc=fail smtp.client-ip=192.198.163.14
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1753476765; x=1785012765;
  h=from:date:to:cc:message-id:in-reply-to:references:
   subject:content-transfer-encoding:mime-version;
  bh=xxU4GT+Do4x1sF4fcqR0XVEtWo5tmxOPtvueViPYm4A=;
  b=UHNP3tEInDNol7f0D3rqhVvlmpFvxas39PqdfIqs+a66IzADVbgm7z2f
   M5nARaruvz1aN1c4mQgFg2NEFGUCXkAlB9VII6HsjemNV3hBs0kgrAcPM
   c6hIyyGWcCOiabo5Y4EKyQ54ikKgKZjRJspGPGTAenR6wwA2EXrC3s0SL
   vVsZOceV0bb54+TuCOVRypgJXv4YsTt+Fi2Q5bZrdNFNk937gLbAbch4X
   KbfTdRqTwXyNbeCmflHkkC9UDTsqHHnd77hm4v0tPbkFJTPfHCoC0RKWT
   g3c4ThcJwLnSAF2CnatYnTh34DeTUz60G3iezwva3G3isA4JIX9ZbGyMl
   Q==;
X-CSE-ConnectionGUID: IB7FFs7FQdyYbDkL5toUxg==
X-CSE-MsgGUID: 6xdKNOLIRoOyYj0JzW9ciQ==
X-IronPort-AV: E=McAfee;i="6800,10657,11503"; a="55901845"
X-IronPort-AV: E=Sophos;i="6.16,339,1744095600"; 
   d="scan'208";a="55901845"
Received: from orviesa002.jf.intel.com ([10.64.159.142])
  by fmvoesa108.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 25 Jul 2025 13:52:24 -0700
X-CSE-ConnectionGUID: eYmoHPp+TWWMP6cQM7VLdQ==
X-CSE-MsgGUID: thfOf7OkR/6OByPnrDOPSA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.16,339,1744095600"; 
   d="scan'208";a="192010294"
Received: from orsmsx901.amr.corp.intel.com ([10.22.229.23])
  by orviesa002.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 25 Jul 2025 13:52:24 -0700
Received: from ORSMSX902.amr.corp.intel.com (10.22.229.24) by
 ORSMSX901.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1748.26; Fri, 25 Jul 2025 13:52:23 -0700
Received: from ORSEDG901.ED.cps.intel.com (10.7.248.11) by
 ORSMSX902.amr.corp.intel.com (10.22.229.24) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1748.26 via Frontend Transport; Fri, 25 Jul 2025 13:52:23 -0700
Received: from NAM10-MW2-obe.outbound.protection.outlook.com (40.107.94.59) by
 edgegateway.intel.com (134.134.137.111) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1748.26; Fri, 25 Jul 2025 13:52:23 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=AOP9axpIlkK1/3RmFOJuUm6KIjW8OzqYr+a0na0RTbloymmFaw0Sj2UbDYs8Jvo210latQfjqLtTpZeB+KhUWN/BZZxX0FfvppiCoNQqvMBPVco7EL693Pq6bBns768VaLrrkfYA6YuLyhL1fNAqsWUY/ERRsRX2KtHBXhjdqkpmYQB1DZlGIHOGWlkOIDux2E8goQKQxR3MPNnjdfJj4yzkcqA+MG+c5693ZzCCpflwU7CPMG6ZxGUQHvawljzXyLN6M1ll/BbwqyAsCHN/Ih5rlm9OeveyrDjAsaFWMS6QpUhjuUuHHQ5iGau+4ZfQt1j19ZYnxvHbVcRouDXaSw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=vtLcOFCQl2cQorwKstSp4i9mxGdGy4Xc+jCy0EiUsgE=;
 b=lJ+bQ3loXZFFvuQ130DY0M8EI/rurfUjBys0iQX4eo3teIDnXVVcpv5fkHJQz1GShpBjKst0NpgjwdJGNoFKrIdghVQve8PeKBmy+v8FThTs9yeBFJLrBzmw77Ju1nps7/nH9/cndw11bdQB/khdYiBAFtPj4COFpqxRvGaZO/k4T+iSGnMX0xoSzRCV0wm/GCwmkZCRn9bgk1OrqksOWVGO74kk9gGUMJv6Sxy4Np2ddSLABUcrYbZePZPd6BWklKajBBIKLBESTkohUuDk4rEWHS7P9A3VenDDsea0q1sht6vp4fmo7f9unU3J3ROyNuDAvpXxVaZaOe0/CBT21A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from PH8PR11MB8107.namprd11.prod.outlook.com (2603:10b6:510:256::6)
 by BL3PR11MB6529.namprd11.prod.outlook.com (2603:10b6:208:38c::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8943.30; Fri, 25 Jul
 2025 20:51:39 +0000
Received: from PH8PR11MB8107.namprd11.prod.outlook.com
 ([fe80::6b05:74cf:a304:ecd8]) by PH8PR11MB8107.namprd11.prod.outlook.com
 ([fe80::6b05:74cf:a304:ecd8%6]) with mapi id 15.20.8964.019; Fri, 25 Jul 2025
 20:51:39 +0000
From: <dan.j.williams@intel.com>
Date: Fri, 25 Jul 2025 13:51:38 -0700
To: <alejandro.lucero-palau@amd.com>, <linux-cxl@vger.kernel.org>,
	<netdev@vger.kernel.org>, <dan.j.williams@intel.com>, <edward.cree@amd.com>,
	<davem@davemloft.net>, <kuba@kernel.org>, <pabeni@redhat.com>,
	<edumazet@google.com>, <dave.jiang@intel.com>
CC: Alejandro Lucero <alucerop@amd.com>
Message-ID: <6883ee5a34049_134cc710072@dwillia2-xfh.jf.intel.com.notmuch>
In-Reply-To: <20250624141355.269056-1-alejandro.lucero-palau@amd.com>
References: <20250624141355.269056-1-alejandro.lucero-palau@amd.com>
Subject: Re: [PATCH v17 00/22] Type2 device basic support
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: SJ0PR13CA0173.namprd13.prod.outlook.com
 (2603:10b6:a03:2c7::28) To PH8PR11MB8107.namprd11.prod.outlook.com
 (2603:10b6:510:256::6)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH8PR11MB8107:EE_|BL3PR11MB6529:EE_
X-MS-Office365-Filtering-Correlation-Id: b4782edb-59f0-4d0d-24da-08ddcbbd0dc6
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|366016|376014|921020;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?NDdnTzFzTVo5cE1QUExhdnc1Wk9iOXlVMWZ2ejFrR2F4dDlSaTVSK0NpT3BB?=
 =?utf-8?B?d3MraTd3YlE1V1IyQlVCTFdYM1BmVVEwSmFFUDB4YUVLQjF3NHhtR3dXejVP?=
 =?utf-8?B?NzZwVEdLcnJ2WWg4Wi80Z0VEOVQzV1JmWGZJaFQxRWtHRFFOdTBpRTljbU5T?=
 =?utf-8?B?dVpxdS9FR1FqVEJrOCtZZXFCbmxnZ0xPOTBzbksyUVZHTjE5UnhwNjI1UXJI?=
 =?utf-8?B?c2k4dWVqNDdoSlhQMStMaWhubzhQTWpNT2ZhVTRHc0hsb3hOQXZPcXA3eXV1?=
 =?utf-8?B?OGp1SG16bG1sSTZ5UXl0L1U3c3lLaVF6dndCMVBrbkJubzhWS1A4U2NkaWRq?=
 =?utf-8?B?elVFVU5WUnYyVldtWW9FdkNqeCtuOHJtZ1FoaElvT2ZoM0JYREFxT3VpWmpB?=
 =?utf-8?B?NVRYQkJhOHNoTTNMNmZ2OERMWGQvMXRSeWs3cWpaZWxwK1dFcEVlNGx4enNu?=
 =?utf-8?B?U25sR2xRVFdnK0RjQ1poOC9pOFR4eUlucWlwS29OR1BvS2xPSFNrSnd6Y01a?=
 =?utf-8?B?eU9FRkhWaXJYTnc0TGgxcnpYajlvNkdSTk0xYkF0WmpGZUpBYTdpVnlDajlY?=
 =?utf-8?B?VHErVDAxY0FtZ01XNkFkdmZQbjltdGNMa2hjRjczb1RpYldmNEZtRDRzeUJL?=
 =?utf-8?B?UmNQa3VmVTFXMlhsN2NuaDVQR3Q1dUg3ZjkxRmE0eVpUaDFNVVRjRTBWV0pM?=
 =?utf-8?B?R1J4RnlHODBSSWJzU1V2Q0ROT1QyRUs4S05EVGNCeHN6R0d2V3Z0UUhxeTh6?=
 =?utf-8?B?cWppajlYZUdhTXFWUmowNElnQmgvbEI3UFlLWjhxUVFQZWpab3dvUUJQL2lD?=
 =?utf-8?B?RFVkN2N3bVdtZlhXQ3VOTWx2QzNyTGFlaXQxZnNWb2FPY25FTVJlS2s1d3ZU?=
 =?utf-8?B?Q3RFeFhhRlN5VWZ6TENUYW5BaEZvOEphb1lDczlsT3ZBQitDbDJUK2kralk5?=
 =?utf-8?B?VE1rSnkwTEJxQW93OFY4d0tSNHB1R2MxbjR3MW5TZFRvT1RXK0Y4MFIwT3lM?=
 =?utf-8?B?VnVlM292TWNkT3ZYa0R6d1c2NWxleTFraDdLbFhvdGx6Nnh6elVzdVc1aVBI?=
 =?utf-8?B?dWhKdFJHUVY1NURuN1VDTzJka2hQbUcyL1VvRHpiM1BvR2dIdE1OWTczY2d6?=
 =?utf-8?B?V0h1QnhjMnhRUUxVQTNOVXdnZWJqd0RFVmx6cjBIZTJxOEZVeFJkK1Rwei9G?=
 =?utf-8?B?di9Mdm9pcldmSndDSDNxL0pyS2tNdU00UjRQb2FFVGVrRnl6a3JjdDFtQ0NT?=
 =?utf-8?B?enFhaXpORTRULzh3T24xcEV0ZEgzNlVtUVlvd0hzQkZjSTBjQm1FNEkzYUFX?=
 =?utf-8?B?RGlBb1lVdGE1WWZwN0lReDk1UTk0cDZGczhNTmdQN3hrTVFURXZYcUs2Yk5X?=
 =?utf-8?B?MWg1TEpjYUt4VVljRTliN0pzZUdaRktPUENTNnNMVnZVdytCc3EwSEhPSU5Q?=
 =?utf-8?B?c0RyRjBqMlUvejNRZmo1Q3dqRVFGNGRkbnRlcFBhSmg5NFFuYmJxcE90TVdt?=
 =?utf-8?B?K3pyU0x0bXRGSHJUd29JNXR3SGVDVXlsNEZyNFkraTJaeWUvM2dzbHNEaDFR?=
 =?utf-8?B?SjVKQ0tBTStOMitOQ1NiTDh4R0pscEljMzVBWmx1QzFPa0RVK1hWVFNkTG5Q?=
 =?utf-8?B?czFTbUJ1QWNSZm9JMWlCaVVPM2c5b3RVampJRWVhWVkwWW5OY2xCbDR6R1Y1?=
 =?utf-8?B?MVZyS29WaHdzYTJUN0NpT1NSS2QyWmZVcEJtMEl5aVNzaUZXMDZLVDZpZU4x?=
 =?utf-8?B?NVBMYzVaNGZPN2QwUUY5QnhtRkNndG1sMTRXS1FoVUpSUmNsZEw3bk1tY2RL?=
 =?utf-8?B?M0didC8yaFo2eUU3VEltTVg3RVJWN1BDL05iMWpoY0lFMUhFdXdTWTVwQXhG?=
 =?utf-8?B?Vi9wQkNQaGo1eXJZZTdPWWJON3hEVlJuRXdoY0NoQW9SWEkyV2NXSDhvSGhs?=
 =?utf-8?B?VjdOZVUxRDhGSzVDSHRrUzNDVWlaM2hFWEhEeFM3M01lOUlKREM2MEludzl1?=
 =?utf-8?B?a1Vma3d5VzdnPT0=?=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH8PR11MB8107.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(376014)(921020);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?RUlqWTBIYVoycEoxaVBxREpuYmYvSHViVktDMWsxcndhanV6RWxsS1pZMHl3?=
 =?utf-8?B?blZPbnhIZE9NcUEwN0U5akE1ZDhhdzdraWZKSlhreWlvbzR1Z21oRkcvWWxy?=
 =?utf-8?B?N01KanQ4bFJ1K0JOYllUOGJMYTArVGx4ZzNZRFNJWU5ZRTlReEZTU3VObVlE?=
 =?utf-8?B?ZEZWN2lqdHpvMHpjYVlreHFxWlFoelR0TlpRcUlCcE02VkwvcDFzVmNlcGU1?=
 =?utf-8?B?MU9MWjBUWWhPdnlseHdVOHRZTEhsczl0UTZZcHZHczIrclBVcW9lZU5Xd1lX?=
 =?utf-8?B?VDRnc1dYUVQ3SEpnQUdOSlgyU21LcUlGTSsvL2QwNnUzMTNaZFgvNWU1d1Np?=
 =?utf-8?B?WXN0NU9xZ3FHN3dOTHFXdGVBOEZxdzRaN2JKc0pWQjU5Z2JQczRYUFhjdnRh?=
 =?utf-8?B?M3NUZC9kNkNSRk1TbENGMUxhMVdVR3NQK2hnaUZLTTFHdHRwenV0M0lKN090?=
 =?utf-8?B?Z3hOTzIrV2dsQVNpYWUwd0dKazJqbnc5eHR3NVRDL0pYbmVJbGdnOHBCTUhY?=
 =?utf-8?B?RlJGSlIvY3VMQUM2RWoxRWRHMER6Rlc4V0duZnVTcitOcDJ6MFh2amovUXNN?=
 =?utf-8?B?VTRudVFQOFVhRnJqeVlCaFAwMHd3Qk9UM01sbHBwTjBEb2Vaby8wOHRiUjg4?=
 =?utf-8?B?Z1ZVdmxRMWxGV2s5cTY4NVI5TXk4bCtLc1gyWVVwVGFYZTBhdTV4LzRXZ0FX?=
 =?utf-8?B?Um83SGY4eVltQ2YvTXBPbVJiSEMxZmFsWG5UelNaUFVBRityRUowTXc0YzFU?=
 =?utf-8?B?WGtHd0NmbGl1UnBjc0l2MXRpNHI0eHlyS0RyTVVCcEphRC9QKzAyYXRVTlNv?=
 =?utf-8?B?NDcyTVBrR1BnNEdXMTZxNGdhdVBqMVpsT2tFMnV5Ly9aeVNkM3pyVHNVUFJU?=
 =?utf-8?B?dlVJQXIrZnRwdXJ4NEJPZWxmNHlPYUYvQzZ1d1EyUFEvSnlsOWk3TXl5Y3hY?=
 =?utf-8?B?M0ljVzd4UTNqUThZa3lmZDMyY3M3L3hhbTlXZ1hWUmRIM0Q3dEsrVk9kVjRV?=
 =?utf-8?B?UFNQdkdnUGJld1hvT3Q2V05vWlByRUJMR2VSY1pEQ3MvQm5wZGVyOHppK0p4?=
 =?utf-8?B?SGxrTEZ4WWZhaGRjSitMRldkbkNHSlFrOHMyMjR5d1ZzSmJldGk5TUZPalU1?=
 =?utf-8?B?YUNVbDRBaDA2U1ZXNzIrdXNobzlHMlVDamxPbWZmdlV4TndRd2VQUmpBai9T?=
 =?utf-8?B?OS80OGdNN3kwbCttWmZETzJua1A2UjZ2bi9rSkpYOWtmVEN3MG1ITFlFZmR0?=
 =?utf-8?B?MWxZYkJ2SVdlMG5aZjIvOVFQcXNkeEliWnF1Y2FtQ2prQ1g0RThCU0dkZ2Fw?=
 =?utf-8?B?V1Q5Ly9QVGRLWVI5cGFjdHRIclRQaEFWQTVXQnlGa2lzMEl5elAwMGtVbUps?=
 =?utf-8?B?L20va2VyQlNoK05wYVRvcXhDZmNEcDZzQ2NMNyt3ZUlWamZCUzRFenU3SDZ4?=
 =?utf-8?B?elo2L1Z5My9NdFhvdGRGa1ErNjU5Y2JGOTlOaFRmZlB2MGFsOTlQeXQ4dU1v?=
 =?utf-8?B?OEJsTldzOVQwT2hZMXhHeklvMER0QmJ1VXZOalk1c2wxcTd3VmJkWnF2N2kw?=
 =?utf-8?B?YzlRWTlTNGZFdURPclZ1NTFZelEreUxrcmR4bjVyT1UvVzdxcnB1VEFpaEdR?=
 =?utf-8?B?aVA2c0hYSEZxVC9Tc1hJV1VrMzk0Y1RTVnBvTElUeGY5bHhrYlpad01SV3py?=
 =?utf-8?B?YWMwUGJlaG00SDNSZnNmTm16VTd4ZnBmQys3ODlNV3Irc2p1MStZSmQ3VVRU?=
 =?utf-8?B?TFFJcXQ5NU95Q1NtZWdneUZ3M1drbUtMMFgxbU1RL2R2TlRZdDdXVkZodTNj?=
 =?utf-8?B?NXBQR2dDK1BEZ2NkMStqMk5yK3VYR2dzUXhsVlltT1JGY1REU2Vibmt0WjFJ?=
 =?utf-8?B?a0lmbjVsWjdKMlhQSG9RL2tWaGY2TEhDR1FZbkdQVHc2YlhtTUlxcHVFV2NL?=
 =?utf-8?B?SHhLZVJPc1h0UitVQUJGQU1JcnNpRUdQZUNLZm5EV0loMThXRWZXZkNMU1lY?=
 =?utf-8?B?bk4wMEk2WlRpYkQwMkhod2pNclFLT0Nmd09CMldRWXBCbFBESnVzdFNPQXN3?=
 =?utf-8?B?eVhDUnR0YVE4VXNmRlRJWlZPUjU4N3RFaVZGN25JdXNzT1FvZXdJeFNqaEZl?=
 =?utf-8?B?U2dYK1JoNXRlaVFxVS9JZDRCOXJiWW1XeVNsYVh5SVdmQ0FwaXJDdzlyRmpG?=
 =?utf-8?B?SUE9PQ==?=
X-MS-Exchange-CrossTenant-Network-Message-Id: b4782edb-59f0-4d0d-24da-08ddcbbd0dc6
X-MS-Exchange-CrossTenant-AuthSource: PH8PR11MB8107.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 25 Jul 2025 20:51:39.8097
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: QxklK0Ikd8nyeB1ViP5EisSxFU9GLZjblIAXhVgwKn82Ukm0Rs78/SFbW8SuB1/JmsblykgUrUx7OsqDqI8d4LsEilZvwed+dxPz41ZrRPE=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BL3PR11MB6529
X-OriginatorOrg: intel.com

alejandro.lucero-palau@ wrote:
> From: Alejandro Lucero <alucerop@amd.com>
> 
> v17 changes: (Dan Williams review)
>  - use devm for cxl_dev_state allocation
>  - using current cxl struct for checking capability registers found by
>    the driver.
>  - simplify dpa initialization without a mailbox not supporting pmem
>  - add cxl_acquire_endpoint for protection during initialization
>  - add callback/action to cxl_create_region for a driver notified about cxl
>    core kernel modules removal.
>  - add sfc function to disable CXL-based PIO buffers if such a callback
>    is invoked.
>  - Always manage a Type2 created region as private not allowing DAX.
[..]
> base-commit: 0ff41df1cb268fc69e703a08a57ee14ae967d0ca

That's v6.15. At time of writing v6.16-rc3 was out. At a minimum I would
expect new functionality targeting the next kernel to be based on -rc2
of the previous kernel.

It might be ok if the conflicts are low, but going forward do move your
baseline to at least -rc2 if not later.

This highlights that CXL needs a
Documentation/process/maintainer-handbooks.rst entry to detail
expectations like this.

