Return-Path: <netdev+bounces-136161-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 255BA9A0AF4
	for <lists+netdev@lfdr.de>; Wed, 16 Oct 2024 15:03:22 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 88DCDB25799
	for <lists+netdev@lfdr.de>; Wed, 16 Oct 2024 13:03:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 42062209666;
	Wed, 16 Oct 2024 13:02:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="Elgd/UH5"
X-Original-To: netdev@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 87E8E208D99;
	Wed, 16 Oct 2024 13:02:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=192.198.163.12
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729083769; cv=fail; b=U7/2IG3/4IiphrNqsnocGE2Yic/g8d80i8YdgWCZQAqXEhqUDxfNmEevswe077cc39uytMSE51SW9Y0YavCmuprzVv5OYG63RUNxU3wN1UQJ5Hi/GatyxGl0mQOrH7cPm+otwK2ucpCqbtpZDTyhXrJzshKhJcKDLwjogXNmOME=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729083769; c=relaxed/simple;
	bh=FipOljRzuNfB8yBOueSjFMjNMm2kZQtcEo+SNxxakFo=;
	h=Message-ID:Date:Subject:To:CC:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=qNcQVLm2eIE+NcaYmelhtPyCD8cVnZDM1Lim7diw8w2RkYYQYaJnCuoYXuYVZ3UmUVNvxMGD7OOBlqK4rjT+SC0p315ASWiYbDLHBVaIUa7bOneLoH7qRsJZnYHg+IBzK9RQd+fYOaiW/hbNPXUN5n1FjZqKGiF1uDLzhGOUyko=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=Elgd/UH5; arc=fail smtp.client-ip=192.198.163.12
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1729083768; x=1760619768;
  h=message-id:date:subject:to:cc:references:from:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=FipOljRzuNfB8yBOueSjFMjNMm2kZQtcEo+SNxxakFo=;
  b=Elgd/UH5/vfJkUVUeR73J5Z6w6vRvlLwFFDgdQG1jlZHrQG/FJyewknU
   LT8s+YtrR/8TRrNaLGNCAcseIKtfyWRHs7np0w7C1Y6Hxef88VAnjU4Lv
   MNATnivKDLVfqc0jfcTwgr7AMCWdVtNegGI1LmYcHHnPdhE/NX+SP2+wd
   QtR0NtFgJDBzrC3hpIIAW1DnbZJH3QHecdfIKqQcM0Pm/ys307LxRvisd
   0KZObW+X7QOtJinBbXWAPSoGtboBekRiF++VwxwukaEQoJrGjBG6ihxFP
   ZJL36T46ftGqWvb6zG7zvOxR34tSq6GNfl/JDVx7LbBAAnCsdTFnk4pCz
   w==;
X-CSE-ConnectionGUID: BZTwVb7VReqsTjrlKJ8EIw==
X-CSE-MsgGUID: Na5vEZZcRG65hSSUsW8M9A==
X-IronPort-AV: E=McAfee;i="6700,10204,11226"; a="32450498"
X-IronPort-AV: E=Sophos;i="6.11,208,1725346800"; 
   d="scan'208";a="32450498"
Received: from fmviesa010.fm.intel.com ([10.60.135.150])
  by fmvoesa106.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 16 Oct 2024 06:02:47 -0700
X-CSE-ConnectionGUID: ZPyT1d//SgSMi6e5N0XE+A==
X-CSE-MsgGUID: +J6pzYX0SBSgRyo8qm5IBA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.11,208,1725346800"; 
   d="scan'208";a="78566744"
Received: from fmsmsx602.amr.corp.intel.com ([10.18.126.82])
  by fmviesa010.fm.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 16 Oct 2024 06:02:47 -0700
Received: from fmsmsx602.amr.corp.intel.com (10.18.126.82) by
 fmsmsx602.amr.corp.intel.com (10.18.126.82) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39; Wed, 16 Oct 2024 06:02:46 -0700
Received: from fmsedg601.ED.cps.intel.com (10.1.192.135) by
 fmsmsx602.amr.corp.intel.com (10.18.126.82) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39 via Frontend Transport; Wed, 16 Oct 2024 06:02:46 -0700
Received: from NAM11-CO1-obe.outbound.protection.outlook.com (104.47.56.168)
 by edgegateway.intel.com (192.55.55.70) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.39; Wed, 16 Oct 2024 06:02:46 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=C0zjPIDchzJ8R6AVJxy41nyXjk09xXpttbF/Duf+avOb/hXhT1g9k2Alhm0o4m2lhsMyWAN2p/B+71nMGu/ZYcCSeJYC/dFQDDh5i0rePzBQCJ2ZnByJTDB6DSisyJZVHg1fKqX+qEK+EXvOKklqcE/x80HBPtD3f3jDYKhkTqHg6Q+E8KRFjfW5I2gZ7+oYI3Eb1iWYrZr9DMftsAOGBgm7Q48WUnw7fKTGyk2vOK4MRpsmaLt+w4r5/8EwvQWEHKgXRCJu07kKsU2D1RQKlzjwb0AlELB1REH7Q6BzNYvNeKiZnJJIwQ84GvBpiPDZkYD5xTWe38L85Y0jZI5Z9Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=kgnKtvlLZOW4RMMsqhpxTAWTyw1X+muF34EJV5JgoeU=;
 b=dSpGUeAf8rIk8J4MJ8kS7yiect9v/UeFNmhABrnMpzA9nBw5G5nGVzAJNiBIv5SZ1G8p1iAEtKv0L0pf24RRnBPc4bAIB9fDh+dXhUBFKNOD5/J91WjTdnk6ZBMwSxVOBjkZMhyM+GoewEODr7U3R3pdyvRozl5T7FAAnaJg3yhrNuuI2fWVia18S1EIeVRNcs0pbH/HC1XvB9Kxexf0trlJGTAGk/7/lMfEhTrWnVzAPKauf3iPu/u7m+5wTnA099o0q2Jltzsej/r6DT4pO9jfefS0Bu5G9hPlcPFoODCX1bkALPprmFEmpBN4IMNCAYgc/CbcBpfyaE8oWqUMpA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from CH0PR11MB8086.namprd11.prod.outlook.com (2603:10b6:610:190::8)
 by CH0PR11MB5316.namprd11.prod.outlook.com (2603:10b6:610:bf::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8069.19; Wed, 16 Oct
 2024 13:02:43 +0000
Received: from CH0PR11MB8086.namprd11.prod.outlook.com
 ([fe80::984b:141d:2923:8ae3]) by CH0PR11MB8086.namprd11.prod.outlook.com
 ([fe80::984b:141d:2923:8ae3%6]) with mapi id 15.20.8069.016; Wed, 16 Oct 2024
 13:02:43 +0000
Message-ID: <601668d5-2ed2-4471-9c4f-c16912dd59a5@intel.com>
Date: Wed, 16 Oct 2024 15:02:38 +0200
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net-next 3/8] lib: packing: add pack_fields() and
 unpack_fields()
To: Jacob Keller <jacob.e.keller@intel.com>
CC: <linux-kernel@vger.kernel.org>, Vladimir Oltean <olteanv@gmail.com>,
	Andrew Morton <akpm@linux-foundation.org>, Eric Dumazet
	<edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>, Paolo Abeni
	<pabeni@redhat.com>, Tony Nguyen <anthony.l.nguyen@intel.com>,
	<netdev@vger.kernel.org>, Vladimir Oltean <vladimir.oltean@nxp.com>
References: <20241011-packing-pack-fields-and-ice-implementation-v1-0-d9b1f7500740@intel.com>
 <20241011-packing-pack-fields-and-ice-implementation-v1-3-d9b1f7500740@intel.com>
From: Przemek Kitszel <przemyslaw.kitszel@intel.com>
Content-Language: en-US
In-Reply-To: <20241011-packing-pack-fields-and-ice-implementation-v1-3-d9b1f7500740@intel.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: WA0P291CA0004.POLP291.PROD.OUTLOOK.COM
 (2603:10a6:1d0:1::14) To CH0PR11MB8086.namprd11.prod.outlook.com
 (2603:10b6:610:190::8)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CH0PR11MB8086:EE_|CH0PR11MB5316:EE_
X-MS-Office365-Filtering-Correlation-Id: fb6dfce4-0fb0-4499-003e-08dcede2d2eb
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|366016|1800799024;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?UHJMN3pwYU1MUDZHa2srZXdiS21KalpGakV1MVI2SU5yckwwNHlEVldDeVZD?=
 =?utf-8?B?M2hnYnppNTVITGdmRDZQZHhWbE5CRHc0dS9WTG1aNE0rSHcwMnRzQndWdnRD?=
 =?utf-8?B?SnlqbkVkaGV3dW5QSnpNYS83a0dCR3FWQUZKa1pQcWRpZW5LQVNQRXJHays2?=
 =?utf-8?B?d1pSbWFvYWRaYUJGNmU2UkdVR2NXSzZBRnpOVW01U0xlMFdERTRSQ1VhdmtK?=
 =?utf-8?B?eG9peDZQRThFdHh0emJBM3U1L3dWRkRqbHd4azZJU3J4Ri9MbkZFTndVY1pY?=
 =?utf-8?B?UmJ4YStyMUxZT3NxMWxFYTIvVmJTMG5nU3R2QVJKS2ZNTGdYeng0b3NXZTZ2?=
 =?utf-8?B?SlRqQ1RsblpETzZCU2krUWlKWmEvU3NJa0ZYRkR1S25SaDM1K2E3Nys4dWth?=
 =?utf-8?B?dFQ3OVNURy9kWHJTNnVCR0c5MFJYQUd4NzN2ckkyZHRGc1dQS3RuMlErRy9j?=
 =?utf-8?B?UVErQXZ0VlZDeWFic0prU25tNjB0M2drRTJ2ME1hbzBka1dJNXQxelhmbU1W?=
 =?utf-8?B?YnBYN2FvMVpQaXZFZjlQQWtMTTYrNUx5T3lKUjZIbmh2TnJpRU9RTGg5ZlNL?=
 =?utf-8?B?T2pjMHRiN1JHRjJza1hvUy82Ti9MNmJrUElPVnRndHI2UytmblRxdnVaVnRx?=
 =?utf-8?B?TVVVVkJBd3ZRd0VnOWhrbXVCSTk3NTNYMmpjTzR1dUh1SWFhOGE5b0tNdDJi?=
 =?utf-8?B?NkpBOGJWc3lwa2g5UW9admZCdkNURW81aGNHUDRReUdUT3kzQXVDWWZBN3p2?=
 =?utf-8?B?ZlBCR291V09vNm1OZ3kwc1A5WGFCbklldHlBdldLVEk4NTFXaTRmbVliZmpW?=
 =?utf-8?B?a2l0R0lKeWdsK0Q4d09VMzFyajA5WUNwTlZkYjRHYW55UytkRGF5Y0w2OVdB?=
 =?utf-8?B?MXNWblhRNmRVeE9SMUVPQXUrb3FPVytQN1BTN3lMUjRMa2w4UksxVjE2Zith?=
 =?utf-8?B?ZFplZTJoN1puYjhTK0RWT0NsSEE4cS9kY24vVTRWdXBrUXhxOUtiNHZLcG9R?=
 =?utf-8?B?YUEwM3pZRUgza0JsN0Q2M2lIQ09ZeW12NFZDMEdVQVQ1M21WY3QyVDI2ZlBS?=
 =?utf-8?B?STNVVGs4VXdUdWNQaDBwZzVXaTdFcnl4M2YzT3FuOWxqaUp5SjMyNmlrVDBM?=
 =?utf-8?B?U1hBT2xYUzlmdDVTSmY2eTVUK244VFBDR2pGd0VDMEVUblNkd2x3bHl5L044?=
 =?utf-8?B?M1p1K1d1NTFKVWlDaFFtUC9vOHYwOUZTUzRibzNBWnNlSmN2cHRoRHFHdG4z?=
 =?utf-8?B?Y3ZONFZVSFdCSGtLWXVXaEdZRFVqbnF0TmpDNWZ0encvOUtxRnNWVVh3aG85?=
 =?utf-8?B?NUNtMG9uSkxSQnJuai9RcHdVU0VHSThZMWUzbEFON2xsTkNzSlFsYUpleERk?=
 =?utf-8?B?M2hQdFdLa3RSMWI1VDNPa01PdTFpc09KMUdxM2NGTUE2R3JxK0FFdTlPMmtC?=
 =?utf-8?B?THVZZXdyWmsyUUZ1TXBibVdzY2NMYml1YVZianBWN0FqUVJGcmc4VW1MZytq?=
 =?utf-8?B?OC9NVW9YdktLYkI0RnNDckI4T0xpWkpXczBoQWY1OGZtbkI2QmFPa2JhcjY1?=
 =?utf-8?B?TUljc3BRN0N3SHU3VE5ZRnc1NmlRT3J3WVFmQkg3TnorUU1uWWRpbkNNeDdW?=
 =?utf-8?B?ekxyblVEWm11QU9lMnVNTk5xZWhlallEWDkzUjlwV1JzelZmUXg5SGF6RkZu?=
 =?utf-8?B?RDFQK1IzTm1EZDdhbjN0dWVpQ2gzclhVSHJkR2VZaGRNM3RVM3pEdjBnPT0=?=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CH0PR11MB8086.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(366016)(1800799024);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?OU1KV0RwTFJYNXJEQlhuekRZeW9wMHk2QnBwVnQ0QXYwcHZRK2daY3JSU05D?=
 =?utf-8?B?VWN1Ym9CWXRyYWZ6M1hxYXQ5alBIM3RvRngwS2pkeVZFYkllZk5mRzgrR20y?=
 =?utf-8?B?clhId1dNdGgwQ0xSRG9qdlBHNkhWYytzaVBQelJROXFBZ0N5OGMxeVJTaTRu?=
 =?utf-8?B?b0xXMy9Nck5GamlObzZqTC82c1FwWVczbXU5Y2hxYkdFM1d3MnBTczlBQ3lQ?=
 =?utf-8?B?UW9JQTZUYkFPQ2FMSEhNdGdmdFdWeDcxYThMMmx6VStLRzB4TUI3WVhCS0xM?=
 =?utf-8?B?Y092bjFhTDF2cXBRM2pzTnlNQysvRzRTTW5TL1pldDdHMEkzZW9IZzZ6ZHE2?=
 =?utf-8?B?dW5PQUVTMnM3N205UDZPWHhYNEVJTmFSY2Z4Zm5FRFY2bVBtZ25wN01hRGwv?=
 =?utf-8?B?MWVXczR3ZlBwenZ2OThwVWNOQStGSjNoM3EwYnVkcTNtbnhvVmdpVWRrMG1X?=
 =?utf-8?B?eG5KV0hlb2RvcDlTenR6a1NpNWlOdFdocGJnNStPczB6SWR4MWRtSGNvK3la?=
 =?utf-8?B?RVVqZFU4d3JSUTZPRDh2T3B1SHJ2TE1HVmpuT1BjS3BpZm1GKzB6aG1DRy90?=
 =?utf-8?B?Y2NIdk5uZHgzMjhLOElHVG9RZWgvZEk2MUs4WVB3M3p6bmF4OXU2TVdLK2lO?=
 =?utf-8?B?MDFCdDdpNEIxRlBQRGxFc0IzK3ptVXNTM20vZmRqNnZQbXdYME5CQi84Ny9P?=
 =?utf-8?B?YVQyNzRUVnhJeVN3THByYWIxWlpUUFJLTFdwc0lxWFJzUVl3MnZQLzVTUFZk?=
 =?utf-8?B?eGNydVpzRzNmclJ5VmxvMmRuTDFvNk85MndYRExoOWYwYXdCKzM2ZVNyQ2xK?=
 =?utf-8?B?bW9NY3JHSTNFazdpV2lHdldRanQ1ZDQ5d1RwOUhNanhPelh3VS9Ga0pNbDNN?=
 =?utf-8?B?UFVPcmdpTVd1cHRNUFFqbC8rbFZTN0gvQlJ2elBWczRJcFMwV1M4c1BzOTY5?=
 =?utf-8?B?bDlrQUdWRXZNY2VKQ2R0R2JrbEFSVHh1djgzbHl0ZmJhSVJrZUV1U2ZxUWM2?=
 =?utf-8?B?alVFSlJLR0ZSYWtrS2E4K1grZjgwWnR4MkY1aXlkb2tKRDEzRVBpSWdyK1pv?=
 =?utf-8?B?RXBKRnFkdnVuejQ1ZFQ1eWhFVmVkK2taa2FhR2NMeVRlUitCdkZuNWxxQmQ3?=
 =?utf-8?B?UmNQNElLMTRsVFhTMWNOTlJMN29mUFhPMlFycGxyUjlhRmpCM29IVlc5QWt3?=
 =?utf-8?B?K0lHMmdlTlAyZmcrSDMrdWI3VjRtNFU0bEJ0Y200UUtMdlpoSndPNnhmZWk5?=
 =?utf-8?B?cmdaU3ZySmZGUDFmVlRIcUZrcUtXZFVXRFd2dE9QUjNQZzVCbjIweEpDREdw?=
 =?utf-8?B?SkZwNGc4UFAxVEZxUW1jZ1JpY1Z4NGxCaCtKMG9IbWN5cm5VSUhSOEMySXNF?=
 =?utf-8?B?SlF2bTdNazk2cmFjeU5NZ3ZqcG8yNGpSNWZXSFoxcnNpS2orU2hiZXBzMDdz?=
 =?utf-8?B?Uzh4WXVVZ2VDUTMraDNNQUpRc3F5N3Y2YUd3ODZtR0J5Y01sT2VsY1RRS1dk?=
 =?utf-8?B?U1NRcWQ2VnJqdkNuWXR2cSsrQUZwUVBzajdUTGs4M0IzY25OL25tZ280WWN3?=
 =?utf-8?B?bWF0NGN4QTE1eGs3Wkx6VVZhSTlITkxvOHg5WUJzVWU3ano5MHR2SnNmL3k0?=
 =?utf-8?B?enZFSkVlN0pGKzVDTTh3ODRzcDF5VE80WS80bFRSUWtnOWZsOE5pY0FXQ2Nq?=
 =?utf-8?B?U2lyUE9xWWtscE9qWGV1dVg3bmV5QVphdTIybWJac1hBVkVscEsxaEVYS2Vn?=
 =?utf-8?B?Y3hheEl3anArRDBlc3lqRWJINHdXUURHZVlYUXR3OEZFY3B5WHhzWURFTWNN?=
 =?utf-8?B?eGVHVTFBNXZqdHpaa1hjK3FLRGlGa2haOW1wcTFiS1NHYVNuT3JJV25sSmMw?=
 =?utf-8?B?SlNPN3ZHQTVhMm4rSnZTRjZRZDhGNFFFSTgyQVJveWdpREdHV2RSa0dKNXlz?=
 =?utf-8?B?bHpZdE1reTJQL09ja2QyQWVlYXdvckNiVXRObHQxM3JicE94V0dEdTA3eG9H?=
 =?utf-8?B?RzRzTElBZDJJOWRzMUo3NlVzbmFtbjhnR0VLZHpIUmk0VmdlaEM2NEpDb1Na?=
 =?utf-8?B?MFByVklSVzRjWklDNS9VNjZWVXVXekI1NG9Xd05HMS9sNXBkRFFxclNnZWEw?=
 =?utf-8?B?WHowNTlrKzJrbnc3djFteExqLytqYm81VVFMSlp4Tnd5U2Z2ZEZVWEs4ZktO?=
 =?utf-8?B?akE9PQ==?=
X-MS-Exchange-CrossTenant-Network-Message-Id: fb6dfce4-0fb0-4499-003e-08dcede2d2eb
X-MS-Exchange-CrossTenant-AuthSource: CH0PR11MB8086.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 16 Oct 2024 13:02:43.8261
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: xxGVdFBp4K3ePjMibqggxpP6ngy1x1Z4fzw0m53pRC2QkTbnTQ5/aDw3cp2yXQvwGphr415IKWm8jd67peF/OLNtJsySnU+OP0IW2ancWIs=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH0PR11MB5316
X-OriginatorOrg: intel.com

On 10/11/24 20:48, Jacob Keller wrote:
> From: Vladimir Oltean <vladimir.oltean@nxp.com>
> 
> This is new API which caters to the following requirements:
> 
> - Pack or unpack a large number of fields to/from a buffer with a small
>    code footprint. The current alternative is to open-code a large number
>    of calls to pack() and unpack(), or to use packing() to reduce that
>    number to half. But packing() is not const-correct.
> 
> - Use unpacked numbers stored in variables smaller than u64. This
>    reduces the rodata footprint of the stored field arrays.
> 
> - Perform error checking at compile time, rather than at runtime, and
>    return void from the API functions. To that end, we introduce
>    CHECK_PACKED_FIELD_*() macros to be used on the arrays of packed
>    fields. Note: the C preprocessor can't generate variable-length code
>    (loops),  as would be required for array-style definitions of struct
>    packed_field arrays. So the sanity checks use code generation at
>    compile time to $KBUILD_OUTPUT/include/generated/packing-checks.h.
>    There are explicit macros for sanity-checking arrays of 1 packed
>    field, 2 packed fields, 3 packed fields, ..., all the way to 50 packed
>    fields. In practice, the sja1105 driver will actually need the variant
>    with 40 fields. This isn't as bad as it seems: feeding a 39 entry
>    sized array into the CHECK_PACKED_FIELDS_40() macro will actually
>    generate a compilation error, so mistakes are very likely to be caught
>    by the developer and thus are not a problem.
> 
> - Reduced rodata footprint for the storage of the packed field arrays.
>    To that end, we have struct packed_field_s (small) and packed_field_m
>    (medium). More can be added as needed (unlikely for now). On these
>    types, the same generic pack_fields() and unpack_fields() API can be
>    used, thanks to the new C11 _Generic() selection feature, which can
>    call pack_fields_s() or pack_fields_m(), depending on the type of the
>    "fields" array - a simplistic form of polymorphism. It is evaluated at
>    compile time which function will actually be called.
> 
> Over time, packing() is expected to be completely replaced either with
> pack() or with pack_fields().
> 
> Co-developed-by: Jacob Keller <jacob.e.keller@intel.com>
> Signed-off-by: Jacob Keller <jacob.e.keller@intel.com>
> Signed-off-by: Vladimir Oltean <vladimir.oltean@nxp.com>
> ---
>   include/linux/packing.h  |  69 ++++++++++++++++++++++
>   lib/gen_packing_checks.c |  31 ++++++++++
>   lib/packing.c            | 149 ++++++++++++++++++++++++++++++++++++++++++++++-
>   Kbuild                   |  13 ++++-
>   4 files changed, 259 insertions(+), 3 deletions(-)


> diff --git a/lib/gen_packing_checks.c b/lib/gen_packing_checks.c
> new file mode 100644
> index 000000000000..3213c858c2fe
> --- /dev/null
> +++ b/lib/gen_packing_checks.c
> @@ -0,0 +1,31 @@
> +// SPDX-License-Identifier: GPL-2.0
> +#include <stdio.h>
> +
> +int main(int argc, char **argv)
> +{
> +	printf("/* Automatically generated - do not edit */\n\n");
> +	printf("#ifndef GENERATED_PACKING_CHECKS_H\n");
> +	printf("#define GENERATED_PACKING_CHECKS_H\n\n");
> +
> +	for (int i = 1; i <= 50; i++) {

either you missed my question, or I have missed your reply during
internal round of review, but:

do we need 50? that means 1MB file, while it is 10x smaller for n=27

> +		printf("#define CHECK_PACKED_FIELDS_%d(fields, pbuflen) \\\n", i);
> +		printf("\t({ typeof(&(fields)[0]) _f = (fields); typeof(pbuflen) _len = (pbuflen); \\\n");
> +		printf("\tBUILD_BUG_ON(ARRAY_SIZE(fields) != %d); \\\n", i);
> +		for (int j = 0; j < i; j++) {
> +			int final = (i == 1);

you could replace both @final variables and ternary operators from
the prints by simply moving the final "})\n" outside the loops

> +
> +			printf("\tCHECK_PACKED_FIELD(_f[%d], _len);%s\n",
> +			       j, final ? " })\n" : " \\");
> +		}
> +		for (int j = 1; j < i; j++) {
> +			for (int k = 0; k < j; k++) {
> +				int final = (j == i - 1) && (k == j - 1);
> +
> +				printf("\tCHECK_PACKED_FIELD_OVERLAP(_f[%d], _f[%d]);%s\n",
> +				       k, j, final ? " })\n" : " \\");
> +			}
> +		}
> +	}
> +
> +	printf("#endif /* GENERATED_PACKING_CHECKS_H */\n");
> +}

