Return-Path: <netdev+bounces-280742-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id yCWYKawN6mn4sgIAu9opvQ
	(envelope-from <netdev+bounces-280742-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Thu, 23 Apr 2026 14:16:44 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id 2D60B451D93
	for <lists+netdev@lfdr.de>; Thu, 23 Apr 2026 14:16:39 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id DE23930234C0
	for <lists+netdev@lfdr.de>; Thu, 23 Apr 2026 12:15:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 43E7F36A013;
	Thu, 23 Apr 2026 12:15:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="Q1yBhbRT"
X-Original-To: netdev@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.11])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 71A833EC2E3;
	Thu, 23 Apr 2026 12:15:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=192.198.163.11
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776946511; cv=fail; b=TOeYA7tNJWglrlzP1/0LOoIWlwaixY5ZuAmUbORfqBQHSt+ZgeUOzIeoOJTSuEpbs2hAgmmpd5HpvQnhll4K0suGGx/r5jxXH9s1UA90zyqepL1mFE0DbDpIOJMuBOPYBM44yTCC/u3z2Ek6yF+ptHZhEeIkLniC8iReUxiRbv8=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776946511; c=relaxed/simple;
	bh=0cGUOko4OJmevUCsa4cXKorGksc4EPH/FFlclvXedEM=;
	h=Message-ID:Date:Subject:To:CC:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=S4dMM53tPo07xneP3rouV+PYd0fHkXBOkBMb+cKZFTlBrQ2r7wMYCqTSv7VOJClk+hm+LqW+KP3uEl1XP4IQfAvdOMBMgFneBAnIU1L9HMA9aB9YHEjbqPHiqwLw/1oDVm1CIx0/V9M8wwwHd5SdksDdRE0PBtzUjbjUTd/Hgms=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=Q1yBhbRT; arc=fail smtp.client-ip=192.198.163.11
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1776946507; x=1808482507;
  h=message-id:date:subject:to:cc:references:from:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=0cGUOko4OJmevUCsa4cXKorGksc4EPH/FFlclvXedEM=;
  b=Q1yBhbRTMJ5ZHo1DLsIJipUyAeer+HjgF1BhTCaROlKbQTK9xOhyyBJr
   PMe5G07FagnLLUPstHL9kRZgozShc0wSmfHVzLY4tjz/W6rXYbEil6MMm
   Oqt9jKBmPmIIVu5YJ+t56hfSBwJVZAQlciZdHP7gr1aRbPBEofAYjLjKt
   JrBL4SsuAdXYYZB761I/JD3TtNdXIwq7P1+v5UuVnmmpdNMDwbYjy8z7o
   59a5AM9Dfj9zSGOczuR9a0gVnK05X5G9VA+LsyPKIq05I+QtaMNochY/k
   +0rEnLty7dB2YR/beWlqqWQbsR8TKu8e+9A9paoOsJbmFYJK287b8DQVl
   Q==;
X-CSE-ConnectionGUID: Onkxxf2/RVKi05iDCyUlzQ==
X-CSE-MsgGUID: Rrd/AVmyQpa5Qbm82xwEiA==
X-IronPort-AV: E=McAfee;i="6800,10657,11764"; a="88523960"
X-IronPort-AV: E=Sophos;i="6.23,194,1770624000"; 
   d="scan'208";a="88523960"
Received: from orviesa001.jf.intel.com ([10.64.159.141])
  by fmvoesa105.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 23 Apr 2026 05:15:04 -0700
X-CSE-ConnectionGUID: QJyLz1wnQoCI/LBwB443rw==
X-CSE-MsgGUID: 1J5K1s24RyqHffDqmiAUeQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.23,194,1770624000"; 
   d="scan'208";a="270762136"
Received: from fmsmsx902.amr.corp.intel.com ([10.18.126.91])
  by orviesa001.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 23 Apr 2026 05:15:04 -0700
Received: from FMSMSX903.amr.corp.intel.com (10.18.126.92) by
 fmsmsx902.amr.corp.intel.com (10.18.126.91) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.37; Thu, 23 Apr 2026 05:15:03 -0700
Received: from fmsedg902.ED.cps.intel.com (10.1.192.144) by
 FMSMSX903.amr.corp.intel.com (10.18.126.92) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.37 via Frontend Transport; Thu, 23 Apr 2026 05:15:03 -0700
Received: from BL2PR02CU003.outbound.protection.outlook.com (52.101.52.40) by
 edgegateway.intel.com (192.55.55.82) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.37; Thu, 23 Apr 2026 05:15:02 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=PmbPNhah+p5WhvBxiW11Jv9fiO5iy2Ld37uz9getqViBmvVawLqG07i2Zth2MiPZTt6154LZdAXoKR0fNR+kygZW69ts2xoNOQ4vauajnPf0r405oMH+ziZDw1+VnU7Tr6AGnWcSRDT148aU074NrBbFdAZtQ1doIoJFAClAyFv4ewyUHnry5RQWFdGTOAh7GLz7PhyMTjsuBkhVtnDYJ3OEQ86/dVbMxBqop/8+ayspiVEtC1Z6zcQnx2Bd0KFWWn2tw4yvuYlP0mMfpeESDprOL/3eI+Y9U4sHN1c6azk26ElwgzhNJIeugtxVp775e5NPM6zwSgN1nw0k69yJBg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=iUHhf2t4akHR+bvXnQD49aNdDq8xxTc13J9v2bcLgqk=;
 b=XDILMFO2O3BE87NFZUczi7uD2yK7W7b92a9fz5m7yGRkIgixwlVexA4VCp6bUCohg9cAmqstyo4oNuaSrVb01kVIf+yWnefGsm6xgySrLlcus8N7CiDdxouNeAN9lSZUojzJdrUV6fYbli0BxwQ2eGk5+u/umeWmvY6JIy5QUlMdBJBUvv5NyIJDi10ffLpN3ierrOJ1CwpnFukqQ4NMk2ppuF8Y0ON0oR/4t6nIZzzK7HoPv9y7KejNhsJD5TLAMDwSlJiGtJkUTiv3KJOWPGL9gEYRYIBfGOv1C/cuKgeWHI6xZoek2DOAn/iKIKLb6jwWBYClZWU5762Iv8SMhA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from DS0PR11MB8718.namprd11.prod.outlook.com (2603:10b6:8:1b9::20)
 by PH8PR11MB9878.namprd11.prod.outlook.com (2603:10b6:510:3c5::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9846.22; Thu, 23 Apr
 2026 12:14:59 +0000
Received: from DS0PR11MB8718.namprd11.prod.outlook.com
 ([fe80::6aa:411d:4bfa:619c]) by DS0PR11MB8718.namprd11.prod.outlook.com
 ([fe80::6aa:411d:4bfa:619c%5]) with mapi id 15.20.9846.021; Thu, 23 Apr 2026
 12:14:59 +0000
Message-ID: <f78a505b-6be1-4b4b-86f4-005d709e0253@intel.com>
Date: Thu, 23 Apr 2026 14:14:52 +0200
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net v3 8/8] xsk: don't support AF_XDP on 32-bit
 architectures
To: Jason Xing <kerneljasonxing@gmail.com>, Maciej Fijalkowski
	<maciej.fijalkowski@intel.com>
CC: <davem@davemloft.net>, <edumazet@google.com>, <kuba@kernel.org>,
	<pabeni@redhat.com>, <bjorn@kernel.org>, <magnus.karlsson@intel.com>,
	<jonathan.lemon@gmail.com>, <sdf@fomichev.me>, <ast@kernel.org>,
	<daniel@iogearbox.net>, <hawk@kernel.org>, <john.fastabend@gmail.com>,
	<bpf@vger.kernel.org>, <netdev@vger.kernel.org>, Jason Xing
	<kernelxing@tencent.com>
References: <20260422033650.68457-1-kerneljasonxing@gmail.com>
 <20260422033650.68457-9-kerneljasonxing@gmail.com>
 <2e0e0e18-cb75-4638-9a12-5906de6a8308@intel.com>
 <CAL+tcoDTXEsehprDHeO7P1pcqwu_US3Li-dm_YyGDAwu2aYZvw@mail.gmail.com>
 <aej+JZyYwUrRXD6e@boxer>
 <CAL+tcoBH9qm0Ce=vBuCResVEbC_9a1D2VofTW73Uo+t519Ui0A@mail.gmail.com>
Content-Language: en-US
From: Alexander Lobakin <aleksander.lobakin@intel.com>
In-Reply-To: <CAL+tcoBH9qm0Ce=vBuCResVEbC_9a1D2VofTW73Uo+t519Ui0A@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: VI1PR06CA0124.eurprd06.prod.outlook.com
 (2603:10a6:803:a0::17) To DS0PR11MB8718.namprd11.prod.outlook.com
 (2603:10b6:8:1b9::20)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS0PR11MB8718:EE_|PH8PR11MB9878:EE_
X-MS-Office365-Filtering-Correlation-Id: 34c5f5ad-299a-4f0e-fc69-08dea131f05b
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|366016|7416014|376014|56012099003|18002099003|22082099003;
X-Microsoft-Antispam-Message-Info: hfSjMCcH4CRZH6cTmck3bGHy8VXIvBo/LM29ZWTxsAWBLK2U0a/r2p/AYVQvrMNHZz7iiF0Qnfc5gYgj2UOwo1d1GKEt301rHHzy+XaDtrglvMfxeIx7F9RmzAcp2dYyr7Nvc2vNOIkM3+/6mW/XE+6S43rsiqMyVB3/OME2L2e/wayI4vQ5C3Scq2eAViK4RdVUH3lhs5E3KAVWEiLPMlF5+/mqU4dwKt3xKp5MtPT4qb4tMULcrcI9GxWZd6DRHqJuFfGDpYKK1CjT99qVi+Lzvsqm35Ov0+oCLtSqCpNAjHYK1G3A/SGTqTA83NqSwy2WeNJhemVr+jlDQG36fB472wc37UyY+waueJzL9mH6KZ10Xyzoq4/NhvUK1KpmchO7DL2EGBhDmyW6X2ERmYXkiDcTIZ6VpEuYBJxOnhOFckKBo7UMbj+v9cB4bwCNL4A8YhzkIXumV+J3tcQYCiwgs2GP5r7sK/D2Ywx/CaxL6WWpYcZOYlBNW58Szz/PhAEuDec4aBKGWwEBGuM5kTh34w4HTlr4Z/fUMLrB537+FbJ9HGGlE1Eci11stQYo5FDByZeZjLdFjAdSH+SXnHfgUjUu7VHBgAaAl+382pDtW/Qg4GNmfr4ewYY5CzKO51J5TvuCx4Jb6NOiAW+mnNA1UkIC/qWFTxWIaBe8CPILJopXimCsQv6UUNf7FykZ8PvsS+6LibKszpWD/vITVto0QpUvegy2IaBgeci34IE=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DS0PR11MB8718.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(7416014)(376014)(56012099003)(18002099003)(22082099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?cElkQnhLZWFzNnppZ1FwRitsL2VXUzVoUU9KMEVhajI1RkRMRlltYnBqM1po?=
 =?utf-8?B?TDJ1cXNaNGt4R09XSVVTQVFuVzVlV3ZDTDUrTER5akFFdTlBbzlnNGEvZVRY?=
 =?utf-8?B?djdmM1hNRjB6RHYzT1ZreDJWaGkyN3hQZmNaK0ZCWmdEVnYrWGxBa3pYUWxj?=
 =?utf-8?B?dGhSMmhrMFlWZFdpdTVEMmttbFRHKzBZNnJHbjRyeGpwRmZPU3hBSWdFYlNn?=
 =?utf-8?B?WTFRcEpoZW5UWHFTMG9Da1hocER3QlAxbENTUm1CQ01IdnhaYmN4ZE9WdTFD?=
 =?utf-8?B?SHN4ang5MnVGRVl5RENQcFE3VlVhT1JRK2FyRmF1UStUWGlFN3VlNGJKYnJM?=
 =?utf-8?B?RjBLRDdsL0QvK0F5Z2gvckE0SHR0ZU5BZ0ppN0FnbHNkSXViN3dHNEFPMzJQ?=
 =?utf-8?B?UW1VYkFnK1hwVmJZWUQxaWUrdXdncUdKN1F6cWR1aXhhK1QzQWZ2dXROTVF2?=
 =?utf-8?B?WTlvZVZhSzcvY0VIMlFPQWcxYzBGNVU4TGRmenhaSGZUWjdIeHlsQ2VyVG9M?=
 =?utf-8?B?OFVMTzUya2dIWkhsM3d0MjhSbEVqdTE0QkJDajF5bDcxcDFvTklSSEVzQ3RI?=
 =?utf-8?B?ZTRsTTRRSDlJZWpJNGFmcXJNa1hwampuWUNPZ3NnSTUwSUdJV003eWxRWmNu?=
 =?utf-8?B?Mld0bDVSM0tTaEY0Rlozajc1dWRWRTVxWU81a3B5UURwN0o2TmVMT2FpSVBO?=
 =?utf-8?B?L1VPUmZNa1d5QVRYY1M0N0h2cHkzMnM0dE9VWWY3c3kyQ2FMaUowd01aQjVa?=
 =?utf-8?B?WXlmZnlUc0FmSktYYUJkdDR0Z1NoTW55eCtkSGUwdlE0RFJHYzZkZkJGT0tP?=
 =?utf-8?B?QlpsU3dFbDhWdzQ1djlUUThoWFg1WG84VFhIdjdOZ1hud3c4ZzhmVWkrbHpM?=
 =?utf-8?B?U3pRVGxOcGlJV2w4eW9pM2NjRUNrSUN3bUdNanNHNUtFM29oeGlrckRYcUdo?=
 =?utf-8?B?NzlhTlUrWGI0Z041WnB5WnJBSlFoM09yQ09ibHVmblBrbWZEek1leHVYMkpj?=
 =?utf-8?B?RWVsak8wZ2g3VWtJdHRER0lMZjl5UWpvdzhsTXBrRG5IL09ybnRIR1hGWlF4?=
 =?utf-8?B?cHJVTkpKcnpMWVIwbDl6NzR0RzhiaG9wbXJnSDA0R2U4RDVYaVMxRElqRmNE?=
 =?utf-8?B?aUs4RWg2QnYyalZHVVdKYmVCZXJYVUF1YXdZMXc1Ull5WjZKNGtZNnc0UzFK?=
 =?utf-8?B?TVc5MGdGaVJvZXFrNHE1MEltTlZPaWR6TEpIcENtWHk0ME9HemluVkI1T0Zu?=
 =?utf-8?B?Y21RWkVNR1FwOGxBVmVZRkpWL29Pdm5TdVNCSWNOa1RHVWxBZElaMlZMS040?=
 =?utf-8?B?SytZSFBDUTNkQXdwQW04SEs0SG5VZnpXUllKYldqTzhkMmV3SW01Z1hPRDFs?=
 =?utf-8?B?SFlmVXd0b0tpK0FJUkErMkZ4VDlGU25iSEUxWFVzNVJKcENLMHhMcXNXcmZX?=
 =?utf-8?B?VUhCck9zL0l4L2lKa0xKY1VwakpkQTU4YWJZVlRPeUFScE9IUEdJK09ROWtT?=
 =?utf-8?B?NTVrcjg0ZUE4S283Mm52RHR4d1RyK0YvRlg5UmJhVnVXaGFYSFNiOEJyOEVq?=
 =?utf-8?B?SzVzQ1c2aWxEN3locms0TjdJeHFNallpUi9MSWdaMDNjbjNraFZnL1dNMElW?=
 =?utf-8?B?SDFJUnJiTW41NkhPaFVGVHlOUFV2WjR3dkZRdjNsNis2cWJJZ3oycEt4enUy?=
 =?utf-8?B?ejV1QmlmanJ3MVVxeC9hMUFVMXV1QjJRK2ZldjFlRFljNTF4d2xMUW9Za2NF?=
 =?utf-8?B?VE1DK3BqZm1wa3lBa1NMVi9vTGg4VnFhbXlwcDhlelFnd1d5Ymg0blYzVSty?=
 =?utf-8?B?TDVhWjBnMkJCRUt0NDBiR1A4eFUwS2prc2pFUlVkYVJRT0JVRHhWd3Q2ZnJ6?=
 =?utf-8?B?M09YMnBMQnJvazlJQy9TNGdnYlRRWkEyVXZzOWRoVlMrMEtGZEszTTNBbFlz?=
 =?utf-8?B?eFdjaUpDV0NiVXhZYUh4MkpEelRuVUVRMHRYMlVwdnRoQzBEbS9lQjdhaTNN?=
 =?utf-8?B?TGhYOG9CRWtNY1c2OHVHRkMvUE1JMFRCaWt2Z2JLNTk5eDNDemY2TmRuNXVF?=
 =?utf-8?B?V1dKU3FMRkh1TCtiZGIzNXd1bGhNM3FmN0VES1ZRQ2VrdWxWK2lXWEF4VDEz?=
 =?utf-8?B?K0ZIZnkvNm9PRnZVUmpFUUF3RGpQdmZqaEFkRlVrVWpCa3hoTXVqYmdVUC9B?=
 =?utf-8?B?MStEbWs0RmUrekN6NkRjNmhSdU9xaVptV1piS3JiNVZIVHFpTEFKelpZNFdX?=
 =?utf-8?B?Z3hmZVhTTjZNbUNqSk5jRFJ2aktkKzd4WjBPV0h2Q1JrN3U1SFFwRmxLR0NJ?=
 =?utf-8?B?Q1NhUmY2bmNCY1hpVlhYTmpsKytaQlZMUkFPVEVleW5waEo0S0V6N0xOaGY3?=
 =?utf-8?Q?/7iQAQFzKLVy5LXg=3D?=
X-Exchange-RoutingPolicyChecked: kTkGqtUcPXhnxJwxr1cbdxdNkXzOO5MTOAFk+O5FqhIcxDWnqmGUO8rxs8jWZczOFl4kNKW/Uf2hcno+87Bro9ydKs9DXwjnqyubbJs2xAldcDmzJhQzmk+dQc5sTq73NlWgM3Q2okbSu5NJsdR4mtYSh1iv5hK9KAPL4o9P9NLzKKB097ilhmrwpr8iIX73tN10mCRZxYxvHhvw3Rk/JVevPqUMmR+/H5z1iW4S9Omimn/f4fZtbLuv57GMluxyAVjGzV1sigL4av4oGeQsAjck1im2grr4cneQZeQqGcs3Fc6loeGM65NHfrAZEBLuV7DG1D5XFec8jSbhVXnrXg==
X-MS-Exchange-CrossTenant-Network-Message-Id: 34c5f5ad-299a-4f0e-fc69-08dea131f05b
X-MS-Exchange-CrossTenant-AuthSource: DS0PR11MB8718.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 23 Apr 2026 12:14:59.4310
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: HVazfFSKriEUaXDjyAwLnttoKiY78QmCohPfUXmmPDPz0Rm09Thst/6KYZdTNUUAPr18frrynxh6ickKRr1rTHE2mT3v7KKVKKmih47b3tk=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH8PR11MB9878
X-OriginatorOrg: intel.com
X-Spamd-Result: default: False [1.34 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_REJECT(1.00)[cv is fail on i=2];
	DMARC_POLICY_ALLOW(-0.50)[intel.com,none];
	R_SPF_ALLOW(-0.20)[+ip4:172.105.105.114:c];
	R_DKIM_ALLOW(-0.20)[intel.com:s=Intel];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[17];
	MIME_TRACE(0.00)[0:+];
	TAGGED_FROM(0.00)[bounces-280742-lists,netdev=lfdr.de];
	FREEMAIL_TO(0.00)[gmail.com,intel.com];
	RCVD_TLS_LAST(0.00)[];
	FREEMAIL_CC(0.00)[davemloft.net,google.com,kernel.org,redhat.com,intel.com,gmail.com,fomichev.me,iogearbox.net,vger.kernel.org,tencent.com];
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns,intel.com:email,intel.com:dkim,intel.com:mid,tencent.com:email];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[aleksander.lobakin@intel.com,netdev@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[intel.com:+];
	MAILSPIKE_FAIL(0.00)[172.105.105.114:query timed out];
	MID_RHS_MATCH_FROM(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	ASN(0.00)[asn:63949, ipnet:172.105.96.0/20, country:SG];
	TAGGED_RCPT(0.00)[netdev];
	RCVD_COUNT_SEVEN(0.00)[10]
X-Rspamd-Queue-Id: 2D60B451D93
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

From: Jason Xing <kerneljasonxing@gmail.com>
Date: Thu, 23 Apr 2026 07:49:58 +0800

> On Thu, Apr 23, 2026 at 12:58 AM Maciej Fijalkowski
> <maciej.fijalkowski@intel.com> wrote:
>>
>> On Thu, Apr 23, 2026 at 12:37:07AM +0800, Jason Xing wrote:
>>> On Thu, Apr 23, 2026 at 12:10 AM Alexander Lobakin
>>> <aleksander.lobakin@intel.com> wrote:
>>>>
>>>> From: Jason Xing <kerneljasonxing@gmail.com>
>>>> Date: Wed, 22 Apr 2026 11:36:50 +0800
>>>>
>>>>> From: Jason Xing <kernelxing@tencent.com>
>>>>>
>>>>> In copy mode TX, xsk_skb_destructor_set_addr() stores the 64-bit
>>>>> descriptor address into skb_shinfo(skb)->destructor_arg (void *) via a
>>>>> uintptr_t cast:
>>>>>
>>>>>     skb_shinfo(skb)->destructor_arg = (void *)((uintptr_t)addr | 0x1UL);
>>>>>
>>>>> On 32-bit architectures uintptr_t is 32 bits, so the upper 32 bits of
>>>>> the descriptor address are silently dropped. In XDP_ZEROCOPY unaligned
>>>>> mode the chunk offset is encoded in bits 48-63 of the descriptor
>>>>> address (XSK_UNALIGNED_BUF_OFFSET_SHIFT = 48), meaning the offset is
>>>>> lost entirely. The completion queue then returns a truncated address to
>>>>> userspace, making buffer recycling impossible.
>>>>
>>>> What if we relax the restriction a bit? For example, refuse to configure
>>>
>>> As to the bug itself, yes, It only affects the unaligned mode.
>>>
>>> I wonder if we can support this after someone requires us to support
>>> 32-bit arch and use it in the real world, then we can use the previous
>>> patch to complete the full support (which doesn't harm the path on
>>> 64-bit arch).
>>>
>>> The code looks like this based on your suggestion. Just for the record.
>>> diff --git a/net/xdp/xdp_umem.c b/net/xdp/xdp_umem.c
>>> index 58da2f4f4397..03417b04592f 100644
>>> --- a/net/xdp/xdp_umem.c
>>> +++ b/net/xdp/xdp_umem.c
>>> @@ -177,6 +177,9 @@ static int xdp_umem_reg(struct xdp_umem *umem,
>>> struct xdp_umem_reg *mr)
>>> if (mr->flags & ~XDP_UMEM_FLAGS_VALID)
>>> return -EINVAL;
>>> + if (!IS_ENABLED(CONFIG_64BIT) && unaligned_chunks)
>>> + return -EOPNOTSUPP;
>>> +
>>> if (!unaligned_chunks && !is_power_of_2(chunk_size))
>>> return -EINVAL;
>>>
>>> Actually I'm fine with either of them. Right now I'm not so sure which
>>> direction this patch should take :)
>>
>> Abstracting from discussion, that is not a patch we would want against
>> -net. We should not forbid 32bit on stable kernels, maybe there is someone
>> in the 'basement' using 32bit xsk on stable kernel. Plus the fixes tag vs
>> patch's content looks weird ;)
> 
> Sorry, I don't follow this. Any specific suggestions on how to move forward?

Maciej just says that if we go the first route (forbid 32-bit arches),
then this commit should not go to the stable/LTS kernels.
But

> 
> Now we have three approaches w/o the fixes tag:
> 1. completely forbid 32-bit arch
> 2. only forbid unaligned mode on 32-bit arch
> 3. completely fix/modify the allocation logic of the first frag on
> 32-bit (see the v2-0008 patch)
> 
> I'm wondering how to proceed with that?

I've just reread the v2 thread (I realized I missed it earlier) and to
me, the v2-0008 (route 3) solution looks good. It introduces a bit of
overhead, but only for 32-bit arches, where the XSk performance will
never be push-it-to-the-limit anyway (esp. given that this is skb mode).

So I'd personally vote for number 3. 47 insertions(+), 7 deletions(-) is
not a big deal. And for 64-bit arches, there won't be any object code
changes at all (unconditional `return 0` and checking the return value
of xsk_skb_init_misc() will be optimized out by the compiler).

Number 2 is also okay-ish, if we're sure that addr is always 32-bit on
32-bit arches in the aligned mode. But given that you already has a
proper fix (n. 3) which allows to not forbid anything at all, I believe
it's more preferred to fix rather than disable.

+ as mentioned above, if you go route number 3, the series could be sent
to -net and the fix would eventually hit the stable/LTS trees, but I
don't think we can disable/forbid something in the stable kernels.

> 
> Thanks,
> Jason
Thanks,
Olek

