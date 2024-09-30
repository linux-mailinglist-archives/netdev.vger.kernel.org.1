Return-Path: <netdev+bounces-130372-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 2951E98A463
	for <lists+netdev@lfdr.de>; Mon, 30 Sep 2024 15:11:42 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 4D8611C20984
	for <lists+netdev@lfdr.de>; Mon, 30 Sep 2024 13:11:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DA46E190052;
	Mon, 30 Sep 2024 13:11:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="aPhmiE+f"
X-Original-To: netdev@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.9])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8C96418EFE0;
	Mon, 30 Sep 2024 13:11:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=198.175.65.9
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727701873; cv=fail; b=M2oamAa93INeZ+2xDKZ64awDIT6xwjW46hRPce1RICx5i1mX2A304WAHOgVhbwjrgjr+qvIjqt2TxBj6kQjVTt4Gvslf5fuXvgMBY+erc6xSdLWGjEDRWsX1ZmUyI/0XTWFVzdchey3I5CgiNlxpZDH+in/iuKcY+PuzSSaVL2E=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727701873; c=relaxed/simple;
	bh=64PwkLTaWIAC6X9PD+gLApqofbVhXp40nilrp3FrLmY=;
	h=Message-ID:Date:Subject:To:CC:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=iNhPkySCl3lce8igMB800zHqul2QLGXvesm2ZdCBeSvoKX6GH9ifPr1UdzOKLap+LL3Th6ALvWQChBHbsYYpXqvdqWJb9Q/0zLQi2NhpttOU1Hp3sJxsvE7MLDWeL1ZqSp9H/5hkksBsrbS5+fgKF4dr1ni2Vi4KsAfGZG/sXzI=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=aPhmiE+f; arc=fail smtp.client-ip=198.175.65.9
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1727701872; x=1759237872;
  h=message-id:date:subject:to:cc:references:from:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=64PwkLTaWIAC6X9PD+gLApqofbVhXp40nilrp3FrLmY=;
  b=aPhmiE+fZ212YHqAd5Afs4NbHrXq1KRtg9tKX/El8YHu+lrwEFLu4CxS
   eQLYIc8ASt8Tj49qokEpCNM2AHJ9CrxKkgqGW09NOwpKa8gu9D/Lb3Fm4
   ObEDht5etZHKE6M4VyY+2fBWuXs+W66kt1f1dyyJu0x9ZwR0l02Iv941z
   Us0Zv67748acJF5mDkSzfUIdr8My4XMGrEAKf6J88cSXrf3VI32TP203Y
   mhZDpxZFJT3AHQlM/pyQSccEL+jeP9wzmG6FcKsm7AdcT8nHyME/evH6v
   9sj1Ro9V5ceT6HwZFVBM9/G95j7sVl+iNkeQHz0IaLIqcQ36M7uK7ep51
   A==;
X-CSE-ConnectionGUID: y7ANvkQWSJGv2/he5zR/HQ==
X-CSE-MsgGUID: yq/GAVosRsOvyXz6vK4XgA==
X-IronPort-AV: E=McAfee;i="6700,10204,11211"; a="49312432"
X-IronPort-AV: E=Sophos;i="6.11,165,1725346800"; 
   d="scan'208";a="49312432"
Received: from orviesa008.jf.intel.com ([10.64.159.148])
  by orvoesa101.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 30 Sep 2024 06:10:52 -0700
X-CSE-ConnectionGUID: JWTKbo0iTpyKpnXpXX4AVA==
X-CSE-MsgGUID: PoL9dcNjQmGDs5khqJxTSQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.11,165,1725346800"; 
   d="scan'208";a="74086793"
Received: from orsmsx601.amr.corp.intel.com ([10.22.229.14])
  by orviesa008.jf.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 30 Sep 2024 06:10:51 -0700
Received: from orsmsx601.amr.corp.intel.com (10.22.229.14) by
 ORSMSX601.amr.corp.intel.com (10.22.229.14) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39; Mon, 30 Sep 2024 06:10:50 -0700
Received: from ORSEDG601.ED.cps.intel.com (10.7.248.6) by
 orsmsx601.amr.corp.intel.com (10.22.229.14) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39 via Frontend Transport; Mon, 30 Sep 2024 06:10:50 -0700
Received: from NAM02-SN1-obe.outbound.protection.outlook.com (104.47.57.40) by
 edgegateway.intel.com (134.134.137.102) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.39; Mon, 30 Sep 2024 06:10:50 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=VkvEuTMBYLMHdpwqzNlHorcB2GwBDbNfSbAlk+eya9HSmv1lgDIZ9aL8LCPoKCdI9GYhfncpotJ+xH+85vMG2QFo+TU3VYG4lhnsE9003AHdgIqlQa2rmOEBvmEhM8/IgdeS4KiTF7BedPt7F3eAvGH7D7fBO4+BrfbwkzQFqyrNt+D8t+gVl9o2DYEn42g00StzsdYSWRmlV0OmG1CKIKcTWkaX71JHfIgO1FSziecayMmCorGJFk/L/eBX4v3miveyUbxTorD3l4CPpJAjbZ7GMI6UY6h7Nwebv7+D2QJ4vFgMBfTI8C4qDZnpjpE2TMxGA1G8Uj3/VuD+4x/cEg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=0Aj1/aoD2Jufbj9qwmFUVLkNJFpS4DpcOLxQwc8LCVc=;
 b=UED3Fz8W3YB4FjN9FBbP6/zE3nUaTLriu2hLzLLblhN2KXPhyzfhB/mAc19YgK1wqmiRhItvFO8kLqDUTPdmXbyZdmZpOhxtr7YFxmC3ywZfUz5lxJIHhdRvHKaanJdY5PmRvpIBHvBneOVsXPmY+YVrTCOuW0Mx/rgoo7nUcRH1sU6Cj5rVVadfDzgguH0JZw3Vzn9IRMFJbn1Sdz2SPQBHy+/gIzNiDIMqsaTCtL0wvCCm4utyXC7awaXXnaXOvMt5qPGsZLX0e56hJPfESCPsG7Jm5QIASn9FxQr+c4NIiCrDDufiutycXk0pvizCCbpKVN206ywWwrDjtg5Wtg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from MN6PR11MB8102.namprd11.prod.outlook.com (2603:10b6:208:46d::9)
 by DS0PR11MB7957.namprd11.prod.outlook.com (2603:10b6:8:f8::7) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.8005.27; Mon, 30 Sep 2024 13:10:47 +0000
Received: from MN6PR11MB8102.namprd11.prod.outlook.com
 ([fe80::15b2:ee05:2ae7:cfd6]) by MN6PR11MB8102.namprd11.prod.outlook.com
 ([fe80::15b2:ee05:2ae7:cfd6%6]) with mapi id 15.20.8005.024; Mon, 30 Sep 2024
 13:10:47 +0000
Message-ID: <9f86b27c-8d5c-4df9-8d8c-91edb01b0b79@intel.com>
Date: Mon, 30 Sep 2024 15:10:41 +0200
User-Agent: Mozilla Thunderbird
Subject: Re: [RFC net-next 1/1] idpf: Don't hard code napi_struct size
To: Alexander Lobakin <aleksander.lobakin@intel.com>, Joe Damato
	<jdamato@fastly.com>
CC: <netdev@vger.kernel.org>, Tony Nguyen <anthony.l.nguyen@intel.com>, "David
 S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, "Jakub
 Kicinski" <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, "moderated
 list:INTEL ETHERNET DRIVERS" <intel-wired-lan@lists.osuosl.org>, open list
	<linux-kernel@vger.kernel.org>, Simon Horman <horms@kernel.org>
References: <20240925180017.82891-1-jdamato@fastly.com>
 <20240925180017.82891-2-jdamato@fastly.com>
 <6a440baa-fd9b-4d00-a15e-1cdbfce52168@intel.com>
 <c32620a8-2497-432a-8958-b9b59b769498@intel.com>
From: Przemek Kitszel <przemyslaw.kitszel@intel.com>
Content-Language: en-US
In-Reply-To: <c32620a8-2497-432a-8958-b9b59b769498@intel.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: MI1P293CA0004.ITAP293.PROD.OUTLOOK.COM
 (2603:10a6:290:2::13) To MN6PR11MB8102.namprd11.prod.outlook.com
 (2603:10b6:208:46d::9)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MN6PR11MB8102:EE_|DS0PR11MB7957:EE_
X-MS-Office365-Filtering-Correlation-Id: ad95952c-5143-435f-a137-08dce1514c29
X-LD-Processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|366016|376014;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?Y3BKbU9VekdFUFNZemVZemo5RWVsTDVUMHNHVTdxbDdTa1RUeUQ1MUp5eGZx?=
 =?utf-8?B?ZnVWc0hwU3FuZDlTb3hORS8ya0pWWm5ORTRPYURVYm1xZ2dydVg4MkY1TFM4?=
 =?utf-8?B?S09wc2QzbDhYQjBQSTFOOWlQU2RyTm9NNDZab3FZSXRNMFlhTkQzWVpqK3hv?=
 =?utf-8?B?ZXV6dURqZisrc0VJamdHL1FhYU5hdjBZeWVOSnEyai9SMkZEbnRVWDlaV1VH?=
 =?utf-8?B?Q050SFI4c1ZEZmxBdFBOS1RJZUxkcXNocUN0MUJid3dPSUUwWEZRY1Nwa3Fn?=
 =?utf-8?B?V0dLdmtPRG1aZ0Q4Z2NZRnBDblNrcFBwTjhLZnJxK3lpblRFSytsNWtKb2hz?=
 =?utf-8?B?SEkzaXBMTHozTGM2T3VqWG1vS2FZQkExTDNVMmE0RVlNbzQ3V2tOd3plUTBl?=
 =?utf-8?B?MThsVUd5SXVEb29jTnA0aCs1WHdlUXcvR3g3YzFGVE0vbEZjRGxiRTM0M3Mw?=
 =?utf-8?B?VDR0ZXVHcnJGNU1ncTlXZVg3ODRMaFVHWmRnaXVicUc0aE5EaEFyL0JaVWNq?=
 =?utf-8?B?dnpNRDdYQkxLK0p5T0s2SWNjeGdRaDRkS1lmYWdSa1l5ekdlWFVpenM2eW5I?=
 =?utf-8?B?dm9ZWmtyM3crNGd2SGxNL1MzSVowS2JlYWgwQ3dXMjZDZTJTMWVDNnZqZWMw?=
 =?utf-8?B?US9XdkYra0d5VVFhNXUyUXlkVlM4VnNpTEdzNWhYMllWVkU0WVJUL0ovbXIy?=
 =?utf-8?B?RFlZOXdPeTdGeHAxSmFtUmQ1R1NNb2dSU0tqcGY2TjRxN0h0QUhTdmR5QkI4?=
 =?utf-8?B?SnFFaDBJVVBmYWRhMUpsOCs3b3BwckJjUGpHWURsWTF3Q1J1cC9pNHUwZ244?=
 =?utf-8?B?UHlYbzBJWUhXZlY3TS9HTGFWUDkxUmtFSlpmRkhwdWhJYVNYNVh3aVJwQ2ZX?=
 =?utf-8?B?cDUwTHNITFB3SGhMQ2d4eC80eFJIcFhONnhlaGhxZ2grdXhRa04ybTAxWGxQ?=
 =?utf-8?B?Q0VuTE1rNG0zaXl2c2hPREZQQm1KV0hDZGprL09ISDlvbFF5VE5pVnU5V2pI?=
 =?utf-8?B?NDlhVWhwWVBIN0Z3Vm1JbkIrWDF1RnlsTEI2dU1ETlRhbHJtUWQxYTFtQ3Nv?=
 =?utf-8?B?VWJiVzF2WEtQVDlRVTR1eE85c0ZRVUNnK0FtdXdDVGlaT3JVMlpMelp4cWZr?=
 =?utf-8?B?Qzcvams3YlFDaXNmK2ZMaUxtdFdOekFkblBwQ0g3ZlNBV1VNUlhJalYzcTYy?=
 =?utf-8?B?eG1Fd29SeTBJeXZnSzY3UmJTYjR0UlNEYjZuaEs0QTZjWmpYUGh2dlYrUG9T?=
 =?utf-8?B?dVJuc1F0c2pXdGdpUU9wYjVJQkpXYUplOXBkSy9QcGlyYWhyTjF3aEJoOHFs?=
 =?utf-8?B?eUFtK01DQmMrcEFSbTBvdCs1MitsNE40ZjhoYTZ3VnJ1TjltZ01YbUluN056?=
 =?utf-8?B?OFkrVmtLcS9hL0JyMTUxSnV1bzJoWnJzTGt2d1dtRU9ReFR5RHFod3I0NVVl?=
 =?utf-8?B?WWxHQlkwalprbnMvdWN5UFpoTFpWR1A4V2lMbWp0bEY5cTV1eW5BTjlseFBu?=
 =?utf-8?B?dk5VNVlZN1E4dGVxR09pcU1lKzBLdVQrYk11MXZGOExpaEwrMUUxMHlrWitw?=
 =?utf-8?B?S2NLRUdzVldhb01sZUxvR0FpbitZVVU2R2Qwc0E2RDRkSTFPVjd3M1JoaXkv?=
 =?utf-8?B?eHFndkNvem4wcFh4NWZScnBkOXhRaHd0RG16cC82U1doaFc3VkpTZnppNlZB?=
 =?utf-8?B?TlJTVTNydFpUcm1VMWllMFI0TkNSaFZ6WGNjbTZMNXdMeXRBMURhdlBnPT0=?=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MN6PR11MB8102.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(376014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?VHgvenpVSUdMVVFLSUZGWXdLNlZlNTJPMGpuWGJpOVl1dTJub1BIanVhUW9l?=
 =?utf-8?B?RnlSR2JIRm4rL253NGFmUTBrMlhncmQ5dWNIL3JUWk5yZGNiUXpxVG5uMFIz?=
 =?utf-8?B?Q2xqWVlzcU4zSFZRZDVLNldrR1UrTm5JU2VTaitnRXZObG5HSHpSTkY1VWdz?=
 =?utf-8?B?RHY3aSt3RUxTL0pYYlFOOW9sV1lCN2RmblVWK21hVGVVT1dOc0E0WjlnT2pF?=
 =?utf-8?B?SUkzSG14L0dMd1lpOERNeGxsb0hJSTlzNDJDNFRtdjRuZTZDRDlUQVV5RmM0?=
 =?utf-8?B?M3Z4cnhpNHByZjRFQTBwQXgzV1FFY0VHODA1SzBqT2puSWtkcUcycEdWblo4?=
 =?utf-8?B?SlVXcnNDdHh4bjFNZjhzUldZTTJxSFhFUFJHUUY2YXNKMVBvOExhWXZQNVZK?=
 =?utf-8?B?VTYzMFc1bGUyREc3VWpmMFBESENkZG5hTGdJSXBwTEwvZkxKUUhQNjRvZXBC?=
 =?utf-8?B?VVpqR1VFNXhHVGVhaTJrNElMNlBCa21SOEdrMEtFRDlaV2VQUnAvSXRmZXhC?=
 =?utf-8?B?a1YxMVRoSVpvSnhUcjhIVzkxMVpseWw1cVZrdVJ0cFd4OVVNV0NJTDJIVStC?=
 =?utf-8?B?Mzg0MjlpZTgrdVk1aThhclNBdnhYUTF4WFo0WUVWS1A1ZXMxNm9vekRESk8z?=
 =?utf-8?B?eWFKL1F2Z09mZm83YVVlTHRtUWRLeGs0eVlEdUs2T09JZmcyeU5zdG9wSGxv?=
 =?utf-8?B?bjF6RWhOTVFTZHRlK0h0aTc1aDIxRHNiQXJDN0hYazJMa3BvNzNycUhWK3Fk?=
 =?utf-8?B?ZmRwdU5TU1Y4VmZWVk16bklSMHRwZlVvU0V0dkFTOWo0aXJWeWFxR2xqazc4?=
 =?utf-8?B?OWdGeVc5OE5NNC85T3E3N2V4S2Nnb0pad1Nxa081RnhyZTIrOEkwSkljTTYr?=
 =?utf-8?B?ZDh3NFFXODVCK0Z0MUJCeldiV0J1WUtjK0lkS29LeVFQSWFaNTQrTGFjNlhV?=
 =?utf-8?B?anNEUk1jaDlXOGM2QjJ0NGw1Y2RmbDlTLzdkTXRvOUtnR0Rpdmx2aFJFc1Np?=
 =?utf-8?B?TkdmK0p5cmI1OTVDVDNSSWhJc0ZLYS9YVGdFSStOeDFudFl3SjFETTN3cyt1?=
 =?utf-8?B?UUZvUDlNeDU3elhGRlpqZUNLWlJwSGcyT1hjdFk5KzRlNUZsT21pTEFsRnVp?=
 =?utf-8?B?VitreFNHaHRNMW1ieUFrQzkyczRLNXh2eE1pUDF3RlMrbUN6RTNSMGRvSzc5?=
 =?utf-8?B?VmRrZy93T3JQemNXNDVWN1hWYTVCTS9lMzVCS3FpemNrU1l5Z2NHa0dtRUNI?=
 =?utf-8?B?NTAxMTlFYXJvQVlPRjN0V29nNUE5UXljUURjY2VmQUxHbjlZVjN1VmEyUDlN?=
 =?utf-8?B?RjVpdTBPanpiNkhRY2d3ZDVCOTVqencxN2NidnBqNnRuOUxUWFVSLzVPQWdR?=
 =?utf-8?B?S3VlMHJTdnE1encyeWNRdjZpdDZWNExpM0dJZUk4aU10emE1OVhEMEY5OXZ1?=
 =?utf-8?B?VmJMbUYyL1E1NjFXVXhDWHY1NHNvZXY3ZVBQRVhsMlg3SGFsUW92NlRwaTdK?=
 =?utf-8?B?ZUFOMTBqd1NmNWRERVUvK3o2Y0dZbGgxandyMTJjWTRWdm9HTDVDTjdUUE52?=
 =?utf-8?B?NmtsR0hqTUpXU0xqUS8rVzdWTkZWb0RBR3VlcTVtbkN5SjZPaUM2akE2YmJ6?=
 =?utf-8?B?ZXA2Q3pwdDYvRXhRTk1meGV5cmFOUVFjK3JRSHo4dnliTFNZMlBjM0lVd2tM?=
 =?utf-8?B?NTJzQjJSS0swMHhRTjUvalF2aUVWY01XTTRxUm1XKzdPYnJnUDB6eHlBQ3Fq?=
 =?utf-8?B?TXdGMnpiOHlueldhZGpRTXIrb1YvSXkwTlJNU0xEdGdac1dKVFAycG5XSVFT?=
 =?utf-8?B?OWU0OG9kQWpyb2VyWFVRdnR4ZExXQkJpTzhpSjlxWVE3RitJdXYwcVZ0SUhk?=
 =?utf-8?B?ajRGSXhCemFXb0IwODBXNlpkblJWNVpwUmdoZ21ZRDZiYW8yVzF5WitseHBC?=
 =?utf-8?B?UmNDSGUyQWFoV1Y2YUQ1MUlyc3kxTzhuYnA0aXgzNmpIWG42VFUwQVI1WWVG?=
 =?utf-8?B?SEFJOFZMOXJEK3dwT21YbGFaM0VCci9KNS9EWm4wcklNZFdGb3Rjalk2M2lm?=
 =?utf-8?B?bFh4UmV4K0Q0NDRGdEU4R1A3bjJac2crU3N0aUxtYyszY0tVQkx2WDQ0cGVn?=
 =?utf-8?B?WVRnbUZoWkFQWW9XaUJ1ZHJ2VnVRSXpaQ2hHVGdHbFJ3RzVqbTRGRTVsblgz?=
 =?utf-8?B?MHc9PQ==?=
X-MS-Exchange-CrossTenant-Network-Message-Id: ad95952c-5143-435f-a137-08dce1514c29
X-MS-Exchange-CrossTenant-AuthSource: MN6PR11MB8102.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 30 Sep 2024 13:10:47.0588
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: L5w9FJwzJRzMxUbBKhfjZwJA9+5LL2vKPlsIVGgZfob7Je/Oj2JbJrWtwHzr+2+aPPjULWKDyVOXfo7td3UBS3QFPfV5Bvop3cNhEJJPKww=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS0PR11MB7957
X-OriginatorOrg: intel.com

On 9/30/24 14:38, Alexander Lobakin wrote:
> From: Alexander Lobakin <aleksander.lobakin@intel.com>
> Date: Mon, 30 Sep 2024 14:33:45 +0200
> 
>> From: Joe Damato <jdamato@fastly.com>
>> Date: Wed, 25 Sep 2024 18:00:17 +0000

> struct napi_struct doesn't have any such fields and doesn't depend on
> the kernel configuration, that's why it's hardcoded.
> Please don't change that, just adjust the hardcoded values when needed.

This is the crucial point, and I agree with Olek.

If you will find it more readable/future proof, feel free to add
comments like /* napi_struct */ near their "400" part in the hardcode.

Side note: you could just run this as a part of your netdev series,
given you will properly CC.


