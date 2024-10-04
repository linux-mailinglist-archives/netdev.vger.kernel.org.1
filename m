Return-Path: <netdev+bounces-132291-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 7331F9912DF
	for <lists+netdev@lfdr.de>; Sat,  5 Oct 2024 01:18:20 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id E1E7C1F23A4F
	for <lists+netdev@lfdr.de>; Fri,  4 Oct 2024 23:18:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C97EC14B953;
	Fri,  4 Oct 2024 23:18:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="aqnFDFX1"
X-Original-To: netdev@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3E4A0231C9B
	for <netdev@vger.kernel.org>; Fri,  4 Oct 2024 23:18:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=192.198.163.12
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728083895; cv=fail; b=R7PFBVR7iPEppnPvouqZhg6dPmE1uetALztcVfKCG6UH4RtxCiwPrIvkNbKIOf8Z9WNzzLtk6e5uQEa8QI3DCrFV0ybWdcTnX/0RpIVLK9EF84ZLxhpH+u5APM28JUhgkaPIKoIb2781tmsj3qqs/aDKG9LPZqibLB/Ykc2OBTc=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728083895; c=relaxed/simple;
	bh=yFdLXXUTtUVO1nnMM8D5gLf+QDQOAFjCToaDMImZ3m4=;
	h=Message-ID:Date:Subject:From:To:CC:References:In-Reply-To:
	 Content-Type:MIME-Version; b=ULr21Ki8fX3VhIPCKuknMXcdqr8DAMvfMKklXIj8WTSBc+D1Z+5W5psF3cUxKNSdBGMzckjRoQ2jP1VdBWw+PvxSc8SgiQ3DpK4gMwHGmMuZmx0aPTDRyatK3z2t/9i1dsu7kr7EK1rrMQLh9wVUfMTnYBGRUhchePEjR347+uk=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=aqnFDFX1; arc=fail smtp.client-ip=192.198.163.12
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1728083894; x=1759619894;
  h=message-id:date:subject:from:to:cc:references:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=yFdLXXUTtUVO1nnMM8D5gLf+QDQOAFjCToaDMImZ3m4=;
  b=aqnFDFX12X86xPM8zw+u2gQnxgRtpRMFgP4JyGjdMAujDlxJu9YAOH+F
   FxGXAOeWz95dcNxhZFUggpGir3+qAO80EOHrVGsURhv5q0Jzi+91YMow0
   jNEXfkWjK9ec12dwzDt5c+1o7IDHQIEb8Sy6G+GbQ70QB3JjX2ayeoEZv
   99kvamng4cLtlmdPC5M3brCpsh7IQ4WA8Y6mqWxz3N0K4hysQRiJApGD4
   /fc/9sd5rGuoyN4FaeZv+LtS5DEdsE8nwYRRxPAzw+D/INEZpxC7c0kJs
   VAM5r/ebuZ7kqKP8f5Mj5biPq5zANpR75xV8wg2uOI8fAJoMLOd8g4Brj
   Q==;
X-CSE-ConnectionGUID: auqvzT7MR62X28MX9im1Sw==
X-CSE-MsgGUID: DaDtYesTQH+Cj51UjgZQ3A==
X-IronPort-AV: E=McAfee;i="6700,10204,11215"; a="31203166"
X-IronPort-AV: E=Sophos;i="6.11,178,1725346800"; 
   d="scan'208";a="31203166"
Received: from orviesa009.jf.intel.com ([10.64.159.149])
  by fmvoesa106.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 04 Oct 2024 16:18:13 -0700
X-CSE-ConnectionGUID: PY5YapU9RSeSh7b9jA8hRA==
X-CSE-MsgGUID: PlW7Pn37S9a4osvpRbQwUg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.11,178,1725346800"; 
   d="scan'208";a="74835702"
Received: from fmsmsx603.amr.corp.intel.com ([10.18.126.83])
  by orviesa009.jf.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 04 Oct 2024 16:18:14 -0700
Received: from fmsmsx601.amr.corp.intel.com (10.18.126.81) by
 fmsmsx603.amr.corp.intel.com (10.18.126.83) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39; Fri, 4 Oct 2024 16:18:13 -0700
Received: from fmsmsx612.amr.corp.intel.com (10.18.126.92) by
 fmsmsx601.amr.corp.intel.com (10.18.126.81) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39; Fri, 4 Oct 2024 16:18:12 -0700
Received: from fmsedg602.ED.cps.intel.com (10.1.192.136) by
 fmsmsx612.amr.corp.intel.com (10.18.126.92) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39 via Frontend Transport; Fri, 4 Oct 2024 16:18:12 -0700
Received: from NAM10-BN7-obe.outbound.protection.outlook.com (104.47.70.44) by
 edgegateway.intel.com (192.55.55.71) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.39; Fri, 4 Oct 2024 16:18:12 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=xawr7b4Q11E6cEcwLFRwLedyT5UQo7Rnqo2vGkUcbOQPkjEltu/+FjRMcqL9VULuOg0qlWrd6VNtxdM+fyNw2XtA3orB+4iQiMjIWe5RT0+6jxJ7ERMkGAqg7spZzpJz/Ng1KO3lqj8hq6LuRpeGVJWus2A8GBpLJXrkgPg+LRoH0RdyNul4h9krNItpUqAoM2dUaGgTPF6fb6tWY1+05IjdI4zZn6K3oyBuToNgpOga7QzUvA2HEpkPGLYhVkAcFtZV1mahtrSzL0iQE0boIkxBkgFgx6p+Es4+tdJejfUvUMTrBulNQcFdoMr1Q2lkY6Pj9QlraD6qnpknDUe9TA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=dNo8QtPRV9oRa5y0nRdBAPYBA2EEPK9H2PaNDnfoYM0=;
 b=lOcQ6OJSmsdpzZ0vmqAj6eudpP4lYrgdzmWUSuNTspWDBViwr7F9YwPsrpnHZFMrE0mxOxNSHD3bN9l66Cb14iUtyKzKFfflC0sZYX6zgy4TJliG8C4Ul0+nLLNub0SuKwwiTaqthFDWM0THbXyL0OB8YTmpGi5rlF0Gy1HJw5YaJkEvPpLHtr/3DmxlVZ342nwlQQgda9Y+rzPVJlTscAAnyQIJvOi7BroHnMC3xVFsra8ZqytpGovCwfS5/kAFt0Sxpa4ToXQB3x2eoVy4ZZQfXGaF/D35NDKYaDJdXXk+4po+sX8yKM9pUsC6WfhX5PGg5Z+nx0BRkVWuN8XEOQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from PH0PR11MB5095.namprd11.prod.outlook.com (2603:10b6:510:3b::14)
 by SJ2PR11MB7713.namprd11.prod.outlook.com (2603:10b6:a03:4f6::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8026.18; Fri, 4 Oct
 2024 23:18:05 +0000
Received: from PH0PR11MB5095.namprd11.prod.outlook.com
 ([fe80::215b:e85e:1973:8189]) by PH0PR11MB5095.namprd11.prod.outlook.com
 ([fe80::215b:e85e:1973:8189%7]) with mapi id 15.20.8026.017; Fri, 4 Oct 2024
 23:18:05 +0000
Message-ID: <c3af51c8-57c3-40d6-b960-c63a5f0224fa@intel.com>
Date: Fri, 4 Oct 2024 16:18:03 -0700
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net-next v3 1/5] eth: fbnic: add software TX timestamping
 support
From: Jacob Keller <jacob.e.keller@intel.com>
To: Vadim Fedorenko <vadfed@meta.com>, Vadim Fedorenko
	<vadim.fedorenko@linux.dev>, Jakub Kicinski <kuba@kernel.org>, David Ahern
	<dsahern@kernel.org>, Paolo Abeni <pabeni@redhat.com>, "David S. Miller"
	<davem@davemloft.net>, Alexander Duyck <alexanderduyck@fb.com>
CC: <netdev@vger.kernel.org>, Richard Cochran <richardcochran@gmail.com>
References: <20241003123933.2589036-1-vadfed@meta.com>
 <20241003123933.2589036-2-vadfed@meta.com>
 <57d913bb-a320-4885-9477-a2e287f3f027@intel.com>
Content-Language: en-US
In-Reply-To: <57d913bb-a320-4885-9477-a2e287f3f027@intel.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: SJ0PR03CA0369.namprd03.prod.outlook.com
 (2603:10b6:a03:3a1::14) To PH0PR11MB5095.namprd11.prod.outlook.com
 (2603:10b6:510:3b::14)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH0PR11MB5095:EE_|SJ2PR11MB7713:EE_
X-MS-Office365-Filtering-Correlation-Id: 37324c59-de76-4892-d16d-08dce4cacc97
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|376014|1800799024;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?dkZaS3h2WGg1Q0JvMHIwaC9QenFNZzM3QlI5NHlMV1R6ZFhrZGZlSG9PU3FP?=
 =?utf-8?B?Ry9iNEREcTh4cVRlbERHMi93R2dtcDlYTit4MnBHT2RaOVRCMm9lbC9xVWI4?=
 =?utf-8?B?azYyczZNV2ZpcE5DcytlNjgwald0YStuV2FRZWJTUFFwT0lwK2YrOXhQSUo4?=
 =?utf-8?B?TnA4Q0x0YlRKVHlpYTdqWW1QTzhnYUhmcUwvMlRtMmgvZCtQSndXelBOcjh4?=
 =?utf-8?B?NGVDek02RjNSbXRocFlMSnZ0Z3VFckRCRHhtSjNFYzlRamtrak5oa2FmdEMx?=
 =?utf-8?B?TDlraUhMd2VacmN1NGgzVEdhbkJPSTZmRklObHBQU1dsNnJTNGNqR240bitE?=
 =?utf-8?B?MS9jTE81anozUkZNRXpTd2pobW9ta0RIM3BvY056N3h1RlVPT08yMDl1SzVH?=
 =?utf-8?B?dUNseHZTQVgySDlncE5mYmQ0YlVvcGc3ems4RHZlbjF5NkVPcFlpcWF5U0sv?=
 =?utf-8?B?Nzg3U1B2Wmt4SGtDSzZnaFl5YlFjejdmQ3A1MnBia1liQ1lxR3pxaUozOUVk?=
 =?utf-8?B?M2tlL2hwcGhBVnRMbEFJbHdUOXV1QWptVjhoWFJUdVoyb3B4T1lDS0FyNEZ0?=
 =?utf-8?B?WW1oaUxTd0ZNRFdSZ3ZNRWlPQWYrU0NKaFhGdEc4MlRkcCt4eXVFRm5nZXln?=
 =?utf-8?B?dUVuaDd4cVpjbkNyMHZGV1puQURIN3ZuRWgwWFJCcEIxa0RPY1czR0N6dGV5?=
 =?utf-8?B?b3RnQUJ1WHdaNVY0alhLWDdzYjFLT3pzQzVVbzNUbitlL0tucXE3TXRzTERn?=
 =?utf-8?B?dVEzUW5VSFlEUWNSWDhPb1BlMnlRTklUSVdQWE5GRUlXanJiNEVJbkVpZUZK?=
 =?utf-8?B?MlJSamRET1dYZkwzR3daNHBjcy93am1Ibm5KdVIyY1dKa1BLdVBDR2FESXRB?=
 =?utf-8?B?U0oxdGxzaUcyUFJPYVZTRUhseHFJeXA2NkpFdnVDbThPM25HbnlLWUgyVFYy?=
 =?utf-8?B?RmpEMU1HTm9hazUvTTdRRnZFMVhuS25QZWFZZjNaOGxrN1lzRnBkVE9HZmw4?=
 =?utf-8?B?UWU5NVZaYmcyekdNTDFSYUhidG5WZ0dVMWJ6SmRMUG5ZdlVzZDByU1AyN0tH?=
 =?utf-8?B?UFJGRzZWZE1IYW5WTU5wWmQvMVJCNEtYOGFtRy9oY3BGVWZPRC8vbGNWOGNp?=
 =?utf-8?B?dTh6aWNzM1lJbTFad0t1N1czZ2Z3WUhFUk1EY2d3b1dsYjd0TXpBL1lLbHVU?=
 =?utf-8?B?M3pkbHU1WkMzdmJjVTB2K1oyT2xlSUI3dnc1QlFzeCtUb3lqTEZ0dHBvV25C?=
 =?utf-8?B?ZXJGVWtoU0xjUnc5MEY4ekJtQjRFMyt6OWQxYnoyTVU1NWQ3cHhaMnBmK3hi?=
 =?utf-8?B?UzFFczdTMkErSGo1MHhNUktGbDNlek9Td2xCNHhTaEtGM1JwYjU0SHF2NmNU?=
 =?utf-8?B?RkplOTMwaE80UVV2VE1KbC9tYSszYlo1clNpQVE5QUdaV0xpYXV3SEM5UGRa?=
 =?utf-8?B?ekl5NGRNWXJ5Y0ErbHlBSmxhdEhPdlluKzA5UzNMcFJSMk1Fd042c1YzZFkr?=
 =?utf-8?B?aXBpSXd0TGdTWEU4Um9EZWM0UkFYT1EwWjlXOFNvK2pnQzQ0K0RmOHZqalM5?=
 =?utf-8?B?cHZqdzZJK09RaWZWQmg3OWF1YW5mQ0JiU0JsbDZLZEorNkZiY0lWOWFpOWRv?=
 =?utf-8?B?cGRNTVFsWGpFaHVsRTFFbkVOemVhVk4vSmFFTFh6ZFhMM3hqUlRmWHdIQldU?=
 =?utf-8?B?Q0dIdFd0RUFwaU82anpqcisrS3lRQlVDckpMcTl4TVVLWHZISEd3N0J3PT0=?=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH0PR11MB5095.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(376014)(1800799024);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?dFY5MFpkaFdxZTFKRmJzQzVCNW8wTU9VN2Uxd0cyczBFeEhyUkZsM2RxR1g0?=
 =?utf-8?B?Wi9jbVVrUXJPM0JOK3V4cmdUL3VMOW9tM1FIR1ltT3lQN3pqNWVybmVGMzVP?=
 =?utf-8?B?R0NqRTE4clNzSGxEeDEvQzVlY1RVcENtbWFYUkNTWUp6bU01Tk9XNDZzMmM2?=
 =?utf-8?B?eU5Yc2ZWQmVCZ2pxdFMrTDNZL3ViQkNmRkZJUG44d3B4dXpRYzRYcVJZSUVa?=
 =?utf-8?B?VEp2N0IwekpkSG1IU29sVVkwSm1GaTlnVUhWQ0YwK21yMmxocG8wL1A5Zm8w?=
 =?utf-8?B?WTNZRGN1S09xNHcrb3lzSGdNWkZzZXB5VDFMR1hlejhWdUhjUElMOGtnSm5z?=
 =?utf-8?B?aHl0QkJoM3FxM0ladXNCSEg2T3NzZmFZSmZrcUd1UUZvWk4vc2pYMzA4aGJR?=
 =?utf-8?B?V3dpV1liU1pSdlFGa2lLL05IV2ptd3gzWldtelRTTnE5QmFHRko5TmpmYkd4?=
 =?utf-8?B?bjdVY0w2Ty9zQkc3eHpPMjNGQUVMa2FDR04vbXVOeHpUeG9KUGtyS0djcXNL?=
 =?utf-8?B?emdKN3dMeVlGV3k3blFGd05NUHA3eERBMStrbGJuRmRvQ0ROeFFFTFJmcG1W?=
 =?utf-8?B?TEE4ejlnSE12Rkd5NFpYZ3l2ZjhjR1V6WWRra2JrNk5qektlTm1NU0VKb3Mx?=
 =?utf-8?B?RDQzVlZaS0tvRUtnS3VUMi9RamxOQkdiRWRudk54ZlJRdkdWVU5qMnNRazlq?=
 =?utf-8?B?S1N5V28zVUJoRFhjakNHeGVmUFpCa2s4NVF3WEFyUEovekR6TnE2WHAxMUtr?=
 =?utf-8?B?WFZ3eEdEK0NHMlNOdUNZaTZqUHpPRzk4VXRpWWRkUXo5blY1Q2RSaUppSUJO?=
 =?utf-8?B?U25rWk95R2pxbU1WaHZBYnF4YkU5aURNRk9iWElOenB1bGpRNU94WVVoeTZB?=
 =?utf-8?B?WGx6MG1WZ1g3dHVoY2VlMGlVZUQ4V1V5VDdlM2MrdzFxWkxXQ0tFdGlsWDZz?=
 =?utf-8?B?M0VjTzlkdFA0Z2paaExXMWRCUTlpQWszRTZTclAvK1hML2ZQUVIxVG56V0hZ?=
 =?utf-8?B?cE1BMmg3ZzFpT2tuem0vUjR1MXJraktvMEx4bVZ2eTVDVGh4REFHMVI3KzFl?=
 =?utf-8?B?eUNrZS9qQ0VDcXppWWY4b0wyaWx2bXFiZG13QU13SDVBc3BkNUlwM3ZBS1FK?=
 =?utf-8?B?bmZBSlY0ZVJrL2hIVk13eDl0bStyblBJYjFoV3N4Vkt1ekNFZXIwbGY2QUlW?=
 =?utf-8?B?UmhpNVNPekJYNk0ybW5CelFjRE9ZNEhSMVhDUnl2d1dvSWx6bmNrcjd0ZTJi?=
 =?utf-8?B?MUNnN2kyblZ6T1BQT0FGZFlJWklaQUl6VlBzb2V1VTR1Nlk0M09LQ3FDZjg3?=
 =?utf-8?B?MjdsMW5iNW5kVXhrcm11bXVZakNqSDh6RFhJNnNSL1lTUW9MYW54d04xZEU3?=
 =?utf-8?B?U0Vla1NteU9tNU1kcU5vV3hTTnlJYWwrWmJTY2hCN2s4T1NyUU0zYUVzK0N0?=
 =?utf-8?B?aHlNYUFZd3BoZWswOUVCWTg4YjVBQzFBa2NiQ2pSY1hvZlpjbzBBTnpKYU5H?=
 =?utf-8?B?RytlZTM3YVVrbFpkYklWM2VUdEdqYnBnRFNVeldGcXZ6b3BlTWJPc0NXN3da?=
 =?utf-8?B?TzJUNkdmUklWNTc4T2hjRVhMQVdtUzdIT0Q3ZklUVmhZRWhCV29RZVNVVWRI?=
 =?utf-8?B?RWhwSHpEcEdvMHhMdmFzczVkeHdkYmszaExpSnRmUnN4TWRaTUhQZ2U5MnlR?=
 =?utf-8?B?c0p6TTRzVWw2NVpUc2UzcmdKeGtEcHlVdlhLV3dIeFpsNUdiTXZTTG5Mb2Vw?=
 =?utf-8?B?RitRaUltdUF3WTdYZUd5ZTdHcHNtd1hQWmdsYlo3TEdNc25xUHZ1VGNCTWZy?=
 =?utf-8?B?UnNjSng2dTljVzVrRkorUkFJcEFWamJ0elo3T0xPUWxSU0REMC9DRHNzOTBI?=
 =?utf-8?B?QmRCSWkvVnFYUVJhKzV2dTN4Q215NWtEZkp0Vi91ZnBNaFU3UzVCK2dXRDBs?=
 =?utf-8?B?c0lHbmk4Y2hDOXNROWp5YjFsam5jbks2Q0ptbmUrTXRrUm9hSG50SWk2cHZ2?=
 =?utf-8?B?cEt6U2xHZ05WWmljMk5MQjllUkwyeG02d0RUalpJUUJ6Z1dxWnhIZFBCQmNh?=
 =?utf-8?B?cFBobVIvWW43S0FjYWE4UHBIWGZPeXVwcE5uamtHT1FWRk01UElRMXZlZWZQ?=
 =?utf-8?B?VjZ1N1NYSkI3R0hSTmNTc2loMmdkU2d3V3dyR2o3NHA5WFFyT0hQYi9wUjBE?=
 =?utf-8?B?WkE9PQ==?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 37324c59-de76-4892-d16d-08dce4cacc97
X-MS-Exchange-CrossTenant-AuthSource: PH0PR11MB5095.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 04 Oct 2024 23:18:04.9850
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: IMzbt8ciLzUcsiN8RC0UazSOgI0HVIdnBK5HRZYNpcrgyaELoKeBpntu1gtMJuH9CrUaDJEnzDwfw51bMAfSluReiNNquzZsanlSfeP83hw=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ2PR11MB7713
X-OriginatorOrg: intel.com



On 10/4/2024 3:55 PM, Jacob Keller wrote:
> I think you *do* still want to report SOF_TIMESTAMPING_RX_SOFTWARE and
> SOF_TIMESTAMPING_SOFTWARE to get the API correct... Perhaps that could
> be improved in the core stack though.... Or did that already get changed
> recently?
> 

Ah, this did change recently, but the helper ethtool_op_get_ts_info()
was not updated to do the same. :D

For other reviewers who weren't aware, this is true since 12d337339d9f
("ethtool: RX software timestamp for all")

