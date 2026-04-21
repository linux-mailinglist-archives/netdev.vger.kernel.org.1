Return-Path: <netdev+bounces-280152-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id iAy6OO6J52lY9wEAu9opvQ
	(envelope-from <netdev+bounces-280152-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Tue, 21 Apr 2026 16:30:06 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 6481043C0CC
	for <lists+netdev@lfdr.de>; Tue, 21 Apr 2026 16:30:06 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id D33A03066A34
	for <lists+netdev@lfdr.de>; Tue, 21 Apr 2026 14:26:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C63B03D88F6;
	Tue, 21 Apr 2026 14:26:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="dDFShsz1"
X-Original-To: netdev@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.9])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D8AF53115A2
	for <netdev@vger.kernel.org>; Tue, 21 Apr 2026 14:26:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=192.198.163.9
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776781566; cv=fail; b=PG2pkPVZhLB9FVWxXvlEtO3xsQRKdKn0w9KPaZCUrveX81ZGO4YgefQV9qG/LlyvBFSWX2WRyN+WGkCRjOBUDYmwfeEUZfv9e+1yM8t7XqA1Mq94xcuC0oL0UReycihPYZFG3BYZnJY0caGXBMfgWiAaJyb71pz/IWTxf1wbQs0=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776781566; c=relaxed/simple;
	bh=hPi1j21C5IIb8ey77H5ww86RILZtm3pjAAXuMI1SN/s=;
	h=Message-ID:Date:Subject:From:To:CC:References:In-Reply-To:
	 Content-Type:MIME-Version; b=QyBp9uy9XZ0vyBZum00Emvs7uAlaDZcPJxZwk8haINE3mVmp46zQU+QNnQF7gAHbxKmYbe7JMphlinouKZ0OOyp8Gj89LVG7/zk6Jkcc95W37ZJdv7noHsDSx2CvmUnBS364sg42+Jd8LLz3TVOKhohkVDnCJBmtud3YVPBPots=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=dDFShsz1; arc=fail smtp.client-ip=192.198.163.9
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1776781564; x=1808317564;
  h=message-id:date:subject:from:to:cc:references:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=hPi1j21C5IIb8ey77H5ww86RILZtm3pjAAXuMI1SN/s=;
  b=dDFShsz1MHcTwyQssYSAtU3VPyYGRgwLPyckXZjj/aNEN5kQWOaVhcm5
   ZfER3aM3JW0rzw8hdPfN4BsFR6KsAewBnp60sl+qHOeMRh7HCU4gqSAr+
   tdfPs06P7f+5TSohGPgSN9xbfy4whab4w5kqkLL25aA1JQWDhglyjzgPd
   CkbiI0b/loi/C9VoNNE+1cx98yI6Py9pzJ5bxZaDhq8urkmNGuVeTRYOH
   c7i/h3KgNeYbGsB5rjQkQCdUgjExOA4gu/lzaZqxp4wjxf/7IgUZW9aaN
   t/qMIEVmaBykM2u29Fplb2qNKGen5SGPLadsS38kbqdWR5Vioy0+c9FLY
   w==;
X-CSE-ConnectionGUID: fcnvnSGESHa0n04HtV85mA==
X-CSE-MsgGUID: 0HMt+n9ZSY2K3QHYQtJ4fQ==
X-IronPort-AV: E=McAfee;i="6800,10657,11763"; a="88412328"
X-IronPort-AV: E=Sophos;i="6.23,191,1770624000"; 
   d="scan'208";a="88412328"
Received: from fmviesa003.fm.intel.com ([10.60.135.143])
  by fmvoesa103.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 21 Apr 2026 07:26:03 -0700
X-CSE-ConnectionGUID: 75IPo9qkQgmIffoZrnjGrA==
X-CSE-MsgGUID: uZJZ97FXTZ2PqyrMF/vOrA==
X-ExtLoop1: 1
Received: from fmsmsx903.amr.corp.intel.com ([10.18.126.92])
  by fmviesa003.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 21 Apr 2026 07:26:03 -0700
Received: from FMSMSX903.amr.corp.intel.com (10.18.126.92) by
 fmsmsx903.amr.corp.intel.com (10.18.126.92) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.37; Tue, 21 Apr 2026 07:26:02 -0700
Received: from fmsedg901.ED.cps.intel.com (10.1.192.143) by
 FMSMSX903.amr.corp.intel.com (10.18.126.92) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.37 via Frontend Transport; Tue, 21 Apr 2026 07:26:02 -0700
Received: from BYAPR05CU005.outbound.protection.outlook.com (52.101.85.9) by
 edgegateway.intel.com (192.55.55.81) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.37; Tue, 21 Apr 2026 07:26:02 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=UpUKGH1GQDlsaqb3Pch2An+6YFI/wrdRHHSj8c9K+eayv39XDG3FCU7Eq9nyYbrk3Uyz8WmtF6re1dGzGH95picAjLw72Z5h4tapcT1M2/2A+kfg/bghyp7I8Wp84Yjj0GU2zRLWN29INZNCK+jD7aCd0MRRDqf5GZZDpQ2vdMI7C+0ismgQIKOVQqYRwZ3tTC2MrZm+VAGXDxVsbO9al2pq0xxpLn0Bm/w9WjcRUyXLpre3fEL/iK2t/PxoqsdRhKSkfFGAQY1JIA2tfVJsN/l5unx0e8oZIEWWZOO0dj4KyhXRUY+el6t8Trq/ce2QAiCD0lH8caOIVFggziNZSw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=PMmb+c8FupxlA3RnA+UfGX6YEU2pkJoJflGZoRa15t0=;
 b=D9WNWY3FsgUYJ+H+uYW31aGVlXHBqejnlFl4nS++VvrROgBdH7pHBTECMKKryyh9SwAySjpd9qTL50KdPTlg7EnOWcdH3g/YvItiQkFhoEl2rPfyJIVEaKvWsRJ+sMd6Og0rNiVchFQ8tmJBLo+Hxs1ssKf6IYkt++5YHiLZreSBgZz+1KZpLyrUZpjGjvPTDixSMd5QXtKqX2RQSuXzF9Fcl/BWMVhpOFdsWH5bkM21VzU3k4/PMzKuHhHi/oByTI+O6Y8XdHb3mltec3nkle+vGCYdtvRcEoqEl4zMMmaHtSa9tn2wpyAqTo18dZvbfUn6QWzlIv0SDt1NtZILvw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from DS0PR11MB7958.namprd11.prod.outlook.com (2603:10b6:8:f9::19) by
 IA1PR11MB8098.namprd11.prod.outlook.com (2603:10b6:208:44b::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9846.16; Tue, 21 Apr
 2026 14:25:55 +0000
Received: from DS0PR11MB7958.namprd11.prod.outlook.com
 ([fe80::8cb2:cffc:b684:9a99]) by DS0PR11MB7958.namprd11.prod.outlook.com
 ([fe80::8cb2:cffc:b684:9a99%6]) with mapi id 15.20.9846.016; Tue, 21 Apr 2026
 14:25:55 +0000
Message-ID: <2c7f8250-35e5-4bc6-9f44-fde21d6264fa@intel.com>
Date: Tue, 21 Apr 2026 19:55:41 +0530
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 1/2] drm/drm_ras: Add clear-error-counter netlink
 command to drm_ras
From: "Tauro, Riana" <riana.tauro@intel.com>
To: Rodrigo Vivi <rodrigo.vivi@intel.com>, <maarten.lankhorst@linux.intel.com>
CC: <intel-xe@lists.freedesktop.org>, <dri-devel@lists.freedesktop.org>,
	<netdev@vger.kernel.org>, Zack McKevitt <zachary.mckevitt@oss.qualcomm.com>,
	<joonas.lahtinen@linux.intel.com>, <aravind.iddamsetty@linux.intel.com>,
	<anshuman.gupta@intel.com>, <simona.vetter@ffwll.ch>, <airlied@gmail.com>,
	<pratik.bari@intel.com>, <joshua.santosh.ranjan@intel.com>,
	<ashwin.kumar.kulkarni@intel.com>, <shubham.kumar@intel.com>,
	<ravi.kishore.koppuravuri@intel.com>, <raag.jadav@intel.com>,
	<anvesh.bakwad@intel.com>, Jakub Kicinski <kuba@kernel.org>, Lijo Lazar
	<lijo.lazar@amd.com>, Hawking Zhang <Hawking.Zhang@amd.com>, "David S.
 Miller" <davem@davemloft.net>, Paolo Abeni <pabeni@redhat.com>, Eric Dumazet
	<edumazet@google.com>
References: <20260409073318.2909379-4-riana.tauro@intel.com>
 <20260409073318.2909379-5-riana.tauro@intel.com>
 <e7978696-eff6-4c1f-ab0f-047dccb18b59@intel.com> <aderpXuhLoiUoxcT@intel.com>
 <ee2681bd-5223-4957-b10e-5dbde0c0e974@intel.com>
Content-Language: en-US
In-Reply-To: <ee2681bd-5223-4957-b10e-5dbde0c0e974@intel.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: MA5P287CA0153.INDP287.PROD.OUTLOOK.COM
 (2603:1096:a01:1d7::8) To DS0PR11MB7958.namprd11.prod.outlook.com
 (2603:10b6:8:f9::19)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS0PR11MB7958:EE_|IA1PR11MB8098:EE_
X-MS-Office365-Filtering-Correlation-Id: 589bee1e-bd72-4bd1-d762-08de9fb1e5ac
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|7416014|1800799024|376014|18002099003|56012099003|22082099003;
X-Microsoft-Antispam-Message-Info: yOXm7vmuy3zsbgY+8mvLP6JWijpYGx4A7WxPnr5GmabJG5a7C4TklpjnVUlkRvFi3B5n+iYYc5fyjyHjya5qiGAUkTnlgOd77IkridpxWUdTajN94ixRSwWY1IHqhf8LOB30LoWPSIVZj+RvtEoZr8ow41SfaTEcYPpJK2fp4rMsX7hAnKFcgQB4YsFelN9zt9WaPZEDu21E0lUzUDkjPTtxW6ucovJEi6/RtyeyenaeEj/Jat53gQ26BW6Z7BXPbjTUYuoTtuJ3dnvVlhN2hP3dzACTKZRSwViy45pnhxnZ5gucToBDXsCuwAVrXKZruaVnofQpMEgqENmMUgHkQWvabyujLoqE1Yc1rNOqzFvHP7PYvBAhZRZmbnDdIt7VDI4ZX3b9muJR4tqtnr9uCr5cncUwe4zQZ73gdnEUqlQIv4nmUk0IEpniw7WKeQlrTRavZK5lLbb/ZZ41x15Dm7i0cECIyXLG9Gbe3eBAQY1Z2GcMMKxZbSI6zG4vnBdrcbJnrpGUZ/PQ/iObzt/ECHC7m/wq+IgKWw45tk/wwG3rJvS8DM77qWQi7BICrNnhJvCJ2krQJpNLRUhPK9EnhTMoWrTCcpFOhehc3I2bkqkLoXlKBo77KdBaiDgaVtLdoqIGnLleqK16iLtBbu0Mq/EDK96yR/HujC3/OcFfkVpIYCZIisoVDTiIZS/hzopsdCiXQlCT6FGyjjlz1+tjs4hijStJhVfXBAZxs57vwJk=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DS0PR11MB7958.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(7416014)(1800799024)(376014)(18002099003)(56012099003)(22082099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?OWM4SnN1TGNFcTlYdXlIajFteUh4OTJhRVhZc3RONFBGSUdrNEVGUVVyVC9N?=
 =?utf-8?B?dXp5NkRyaHNmbVlzQ0tlVVJnSlRhSFJYOWErM1dBK0g5ZEplbG12YU91a3V2?=
 =?utf-8?B?TFdNd1BYTlhORVEzajNGTm5pU1c5MGVKanl2NFR0YXd2Q1dVbW4rT0pZdi90?=
 =?utf-8?B?M21VRlZYZHcvZHpTSmt0MWhmWk1YWnNuV0Q0MFNmbTMwaUlVVTZSZnliMjA2?=
 =?utf-8?B?elhSaW04dmRncm81dFQvOVMyMmt0L09pRmVkcThpYU5lMExCM0hUd2lURXlC?=
 =?utf-8?B?MlZGdWhRQ2RGbWV0WCtiV2x4NUcza256SXFkZXhCaHJqc3VHd0N3VTEvQmtM?=
 =?utf-8?B?bVZ0RXRuM3ozRW9FbWkrazR0ak1jM0RncSsxOU5ET1pXaDZuNktHc2ZHSVpH?=
 =?utf-8?B?dmlMbE9EeWkxVDM4NGNMTm05N0tEeExBVCt1L2lQNHMxV0Z6a0ZScDhxZEd2?=
 =?utf-8?B?OXBvYW9jUHZDZ3hHNzR4ZitSQ1lPSHJzZkl4WWRISGZ0VTdPMHM0Y1NFUDhS?=
 =?utf-8?B?YkRidkhoVE12UnhiblRGRElBckVoQ0M3ajdLM01ZTkxrbjE1K1kyWnZ3Rmd3?=
 =?utf-8?B?OGZhZm1OVDhGV3BBbEI2UVJHcERYVUVVWHV0UFZZckVEUnJjelR2NFhZcVds?=
 =?utf-8?B?dFpEU042WVJQOGxVclpwRmo4WEhzVGxuVkNxcWNkbGZXNmlmMWp4QW41amw4?=
 =?utf-8?B?NlRxS3BWWVRjK1lPbFcrZ0hWcUZoZ3ZiaVBRK0VaYzhpejhRMGMvc0pnQ29O?=
 =?utf-8?B?UDk4N3BVZlhaZzdsQzlZV1d6S1Q5djJ2TU5aTnp2Q25USDlVOGErVk1DVHE5?=
 =?utf-8?B?UEV6dysxUjM1WXRmRkFseFVBM2hqeVZBMDNEUDJGcEFBemZnK1ZOMXczWUp5?=
 =?utf-8?B?emZUbVNPdUo5VU1UYVFsbXFwRldsbXhobitTV0tBYXhYMFhmSWlHS2RVNWFN?=
 =?utf-8?B?WUtwZVdlZ3E0bGNFZEhGRlBOWVk5WFNIZVRaeStYZUIwQmptUmt5MkJyNW5K?=
 =?utf-8?B?TW9WM3JsK1lwdSs3alJTbXFjLzgydHRGVXU3aFUxOUZFN1ZoSHM0NUc3MkdZ?=
 =?utf-8?B?TFRWWTUwVDhVZHorcUV0cldQeTVPU004QXJzcElMZitGRUk4ZUdRYWFwRGwx?=
 =?utf-8?B?cW1SWmFyQTRDT0laQ1FpSVpDb0RvcmRFZlFpeldoYTlSUUNVQzIyRk9mNTZh?=
 =?utf-8?B?ZVp4emxDRmpnZkpaTEJsNURIdFlBYXFFbUp0dlZwVWFXbzV4ekhwbVVxMU1Z?=
 =?utf-8?B?MVc1QUdxTE1xWjJ2OFJkVktTSVdZYnQxTXArRm9wTS80UXViemNOT1VmeW1G?=
 =?utf-8?B?TmcrcTFRZE9rRFpqbTNkcVdGTWhjNUlWZmJTRkk1WFVkRjJjYldGUGYxSlVF?=
 =?utf-8?B?elcyTWgzTGc1TDJhdGIrckUyalEvTTZ4VDZQR0lGSlMySjZrQ1puL1NRSG1X?=
 =?utf-8?B?Q1IzZjdLNzNJckNvTis0eFZiVGt1ZmdJdmlEZ0RWc1RnUjJDQStVS2Jua0U4?=
 =?utf-8?B?R3lwc0lHM28vdkhHc0ZwaFJOMmRNcUFzbHNrb0NhcGFtRytmUUp6TUp1T2du?=
 =?utf-8?B?UEVpMnBicFRMeTh6VlRuRHBNaTU3VUFlR3cybHY1ald3bENuek9ud2hQRi9H?=
 =?utf-8?B?bGN1ZTZiVk81THM0ZXA5cGR2eUFabW9lbVcrMDgySWE3Rm1nUzQwUGZ3cS9G?=
 =?utf-8?B?OGljRkxleEtKdG0wVzBFZS9DeW9uWFNjWnFxY1BUMlFTRFNtdTBtbUMxVjNG?=
 =?utf-8?B?QXh6ZWd6em54M3NSZ2pzMHB6MGE3bEFMc2tzNzFkeS9JdVJtT0pQaUhGMmVZ?=
 =?utf-8?B?OGFnOFBPQ0xnUEtZS09YaUtjMElzeUtnVXJEb3RzMk5yeEJHdEYzMGY5U0Rr?=
 =?utf-8?B?dVR3QjYwclZaQWtSQi9oMVh3S29BYU5yY2ZsYkRNdzRORkdLY0VvMncycXQv?=
 =?utf-8?B?S04xY2V5dTF4TzZyeFQzQkFQYVNhZlF2eThJcTJwL1lSVG5TakJ3T3ZvNlc4?=
 =?utf-8?B?emdBMUpBRmcwZkxXU2cxb1R6YmNxZVZEUWZsTUJTOUxhV2J0TFREQ2JCeFdy?=
 =?utf-8?B?T3JiQ0ZQWXNlVStwcVUrV1RreHlxSmpIZ29maGJvSDliZXJYbHFwbGZ5dmZq?=
 =?utf-8?B?bWhXVGVmd0dQSXdlRmxWdGhpMjB3WFlxOTMySjNmVlh0SUxVb1NDbk1IV2dH?=
 =?utf-8?B?b2F0dGRDQU56NjcwVUxmcUtwWDFlUXRSVXoxWTFlOGd0YjRjU0NRTVoxT2NM?=
 =?utf-8?B?ZWZaUisyN3lYNDF4TjJGUEVycTRLNUNvVk9xUnZ1b0JvK1BiNnV3Ti9vb0hh?=
 =?utf-8?B?WUhPdEhxY3BneUZQTUFSNXRiM0NvRGxSQ0o4dzkzY0RKc0NQVkhTZz09?=
X-Exchange-RoutingPolicyChecked: LOEZ1yseLAWjcm6MIK0Enm72ePGlVOl1JTly0v5FU5jM+kuPoV8mPj2v8W0zO0iESTF1uH+jOsxGa1IuCQ64cYSzqHZs2pbtHY4yPimeIn8KG5rzxV9TUosmF9GgRswgSyii2DPRD5TYaF8p0VDRubSb/lx/f31cA2mEtUWNi2zg083Id2794FhIyOMlpvinJn9bMfUTtni1fAxREQo683WyhqxtFcRoqphw5pDvLsk0nwMSe5yCWCaAmIGcEQjo4iQfqT2acFag/qGaS17R6sFskldexTtmLIaYXQTOYX0T5XwjZDNOVcjvZ2fr8xvUZkRBzUaYJafvSmoeh0Q+dw==
X-MS-Exchange-CrossTenant-Network-Message-Id: 589bee1e-bd72-4bd1-d762-08de9fb1e5ac
X-MS-Exchange-CrossTenant-AuthSource: DS0PR11MB7958.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 21 Apr 2026 14:25:54.9474
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 2JvB6RYnEX+dSBaafw2Jv/08XfQu3EcbsBu/xAmRhc2fJ2TKDL2sSQvVLmXttS6xJ2+TRV0uYxmKV6xcOOm7Yw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA1PR11MB8098
X-OriginatorOrg: intel.com
X-Spamd-Result: default: False [-0.16 / 15.00];
	ARC_REJECT(1.00)[cv is fail on i=2];
	DMARC_POLICY_ALLOW(-0.50)[intel.com,none];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c04:e001:36c::/64:c];
	R_DKIM_ALLOW(-0.20)[intel.com:s=Intel];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-280152-lists,netdev=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FREEMAIL_CC(0.00)[lists.freedesktop.org,vger.kernel.org,oss.qualcomm.com,linux.intel.com,intel.com,ffwll.ch,gmail.com,kernel.org,amd.com,davemloft.net,redhat.com,google.com];
	RCPT_COUNT_TWELVE(0.00)[24];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[riana.tauro@intel.com,netdev@vger.kernel.org];
	DKIM_TRACE(0.00)[intel.com:+];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[netdev];
	MID_RHS_MATCH_FROM(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c04::/32, country:SG];
	RCVD_COUNT_SEVEN(0.00)[10]
X-Rspamd-Queue-Id: 6481043C0CC
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

Hi Maarten

Could you please help with an ack for this patch so we can merge this 
through drm-xe-next?

Thanks
Riana

On 4/10/2026 10:51 AM, Tauro, Riana wrote:
> Hi Rodrigo
>
> On 4/9/2026 7:07 PM, Rodrigo Vivi wrote:
>> On Thu, Apr 09, 2026 at 12:51:44PM +0530, Tauro, Riana wrote:
>>> Hi Zack
>>>
>>> Could you please take a look at this patch if applicable to your 
>>> usecase.
>>> Please let me know if any
>>> changes are required
>>>
>>> @Rodrigo This is already reviewed by Jakub and Raag.
>>> If there are no opens, can this be merged via drm_misc
>> if we push this to drm-misc-next, it might take a few weeks to propagate
>> back to drm-xe-next. With other work from you and Raag going fast pace
>> on drm-xe-next around this area, I'm afraid it could cause some 
>> conflicts.
>>
>> It is definitely fine by me, but another option is to get ack from
>> drm-misc maintainers to get this through drm-xe-next.
>>
>
> Yeah this would be better with the other RAS patches close to merge.
>
> @Maarten Can you please help with an ack if this patch looks good to you?
> This has been reviewed by Jakub from netdev and Raag from intel-xe
> There are no other opens.
>
> Thanks
> Riana
>
>>
>> so, really okay with drm-misc-next?
>>
>>> Thanks
>>> Riana
>>>
>>> On 4/9/2026 1:03 PM, Riana Tauro wrote:
>>>> Introduce a new 'clear-error-counter' drm_ras command to reset the 
>>>> counter
>>>> value for a specific error counter of a given node.
>>>>
>>>> The command is a 'do' netlink request with 'node-id' and 'error-id'
>>>> as parameters with no response payload.
>>>>
>>>> Usage:
>>>>
>>>> $ sudo ynl --family drm_ras  --do clear-error-counter --json \
>>>> '{"node-id":1, "error-id":1}'
>>>> None
>>>>
>>>> Cc: Jakub Kicinski <kuba@kernel.org>
>>>> Cc: Zack McKevitt <zachary.mckevitt@oss.qualcomm.com>
>>>> Cc: Lijo Lazar <lijo.lazar@amd.com>
>>>> Cc: Hawking Zhang <Hawking.Zhang@amd.com>
>>>> Cc: David S. Miller <davem@davemloft.net>
>>>> Cc: Paolo Abeni <pabeni@redhat.com>
>>>> Cc: Eric Dumazet <edumazet@google.com>
>>>> Signed-off-by: Riana Tauro <riana.tauro@intel.com>
>>>> Reviewed-by: Jakub Kicinski <kuba@kernel.org>
>>>> Reviewed-by: Raag Jadav <raag.jadav@intel.com>
>>>> ---
>>>>    Documentation/gpu/drm-ras.rst            |  8 +++++
>>>>    Documentation/netlink/specs/drm_ras.yaml | 13 ++++++-
>>>>    drivers/gpu/drm/drm_ras.c                | 43 
>>>> +++++++++++++++++++++++-
>>>>    drivers/gpu/drm/drm_ras_nl.c             | 13 +++++++
>>>>    drivers/gpu/drm/drm_ras_nl.h             |  2 ++
>>>>    include/drm/drm_ras.h                    | 11 ++++++
>>>>    include/uapi/drm/drm_ras.h               |  1 +
>>>>    7 files changed, 89 insertions(+), 2 deletions(-)
>>>>
>>>> diff --git a/Documentation/gpu/drm-ras.rst 
>>>> b/Documentation/gpu/drm-ras.rst
>>>> index 70b246a78fc8..4636e68f5678 100644
>>>> --- a/Documentation/gpu/drm-ras.rst
>>>> +++ b/Documentation/gpu/drm-ras.rst
>>>> @@ -52,6 +52,8 @@ User space tools can:
>>>>      as a parameter.
>>>>    * Query specific error counter values with the 
>>>> ``get-error-counter`` command, using both
>>>>      ``node-id`` and ``error-id`` as parameters.
>>>> +* Clear specific error counters with the ``clear-error-counter`` 
>>>> command, using both
>>>> +  ``node-id`` and ``error-id`` as parameters.
>>>>    YAML-based Interface
>>>>    --------------------
>>>> @@ -101,3 +103,9 @@ Example: Query an error counter for a given node
>>>>        sudo ynl --family drm_ras --do get-error-counter --json 
>>>> '{"node-id":0, "error-id":1}'
>>>>        {'error-id': 1, 'error-name': 'error_name1', 'error-value': 0}
>>>> +Example: Clear an error counter for a given node
>>>> +
>>>> +.. code-block:: bash
>>>> +
>>>> +    sudo ynl --family drm_ras --do clear-error-counter --json 
>>>> '{"node-id":0, "error-id":1}'
>>>> +    None
>>>> diff --git a/Documentation/netlink/specs/drm_ras.yaml 
>>>> b/Documentation/netlink/specs/drm_ras.yaml
>>>> index 79af25dac3c5..e113056f8c01 100644
>>>> --- a/Documentation/netlink/specs/drm_ras.yaml
>>>> +++ b/Documentation/netlink/specs/drm_ras.yaml
>>>> @@ -99,7 +99,7 @@ operations:
>>>>          flags: [admin-perm]
>>>>          do:
>>>>            request:
>>>> -          attributes:
>>>> +          attributes: &id-attrs
>>>>                - node-id
>>>>                - error-id
>>>>            reply:
>>>> @@ -113,3 +113,14 @@ operations:
>>>>                - node-id
>>>>            reply:
>>>>              attributes: *errorinfo
>>>> +    -
>>>> +      name: clear-error-counter
>>>> +      doc: >-
>>>> +           Clear error counter for a given node.
>>>> +           The request includes the error-id and node-id of the
>>>> +           counter to be cleared.
>>>> +      attribute-set: error-counter-attrs
>>>> +      flags: [admin-perm]
>>>> +      do:
>>>> +        request:
>>>> +          attributes: *id-attrs
>>>> diff --git a/drivers/gpu/drm/drm_ras.c b/drivers/gpu/drm/drm_ras.c
>>>> index b2fa5ab86d87..d6eab29a1394 100644
>>>> --- a/drivers/gpu/drm/drm_ras.c
>>>> +++ b/drivers/gpu/drm/drm_ras.c
>>>> @@ -26,7 +26,7 @@
>>>>     * efficient lookup by ID. Nodes can be registered or unregistered
>>>>     * dynamically at runtime.
>>>>     *
>>>> - * A Generic Netlink family `drm_ras` exposes two main operations to
>>>> + * A Generic Netlink family `drm_ras` exposes the below operations to
>>>>     * userspace:
>>>>     *
>>>>     * 1. LIST_NODES: Dump all currently registered RAS nodes.
>>>> @@ -37,6 +37,10 @@
>>>>     *    Returns all counters of a node if only Node ID is provided 
>>>> or specific
>>>>     *    error counters.
>>>>     *
>>>> + * 3. CLEAR_ERROR_COUNTER: Clear error counter of a given node.
>>>> + *    Userspace must provide Node ID, Error ID.
>>>> + *    Clears specific error counter of a node if supported.
>>>> + *
>>>>     * Node registration:
>>>>     *
>>>>     * - drm_ras_node_register(): Registers a new node and assigns
>>>> @@ -66,6 +70,8 @@
>>>>     *   operation, fetching all counters from a specific node.
>>>>     * - drm_ras_nl_get_error_counter_doit(): Implements the 
>>>> GET_ERROR_COUNTER doit
>>>>     *   operation, fetching a counter value from a specific node.
>>>> + * - drm_ras_nl_clear_error_counter_doit(): Implements the 
>>>> CLEAR_ERROR_COUNTER doit
>>>> + *   operation, clearing a counter value from a specific node.
>>>>     */
>>>>    static DEFINE_XARRAY_ALLOC(drm_ras_xa);
>>>> @@ -314,6 +320,41 @@ int drm_ras_nl_get_error_counter_doit(struct 
>>>> sk_buff *skb,
>>>>        return doit_reply_value(info, node_id, error_id);
>>>>    }
>>>> +/**
>>>> + * drm_ras_nl_clear_error_counter_doit() - Clear an error counter 
>>>> of a node
>>>> + * @skb: Netlink message buffer
>>>> + * @info: Generic Netlink info containing attributes of the request
>>>> + *
>>>> + * Extracts the node ID and error ID from the netlink attributes and
>>>> + * clears the current value.
>>>> + *
>>>> + * Return: 0 on success, or negative errno on failure.
>>>> + */
>>>> +int drm_ras_nl_clear_error_counter_doit(struct sk_buff *skb,
>>>> +                    struct genl_info *info)
>>>> +{
>>>> +    struct drm_ras_node *node;
>>>> +    u32 node_id, error_id;
>>>> +
>>>> +    if (!info->attrs ||
>>>> +        GENL_REQ_ATTR_CHECK(info, 
>>>> DRM_RAS_A_ERROR_COUNTER_ATTRS_NODE_ID) ||
>>>> +        GENL_REQ_ATTR_CHECK(info, 
>>>> DRM_RAS_A_ERROR_COUNTER_ATTRS_ERROR_ID))
>>>> +        return -EINVAL;
>>>> +
>>>> +    node_id = 
>>>> nla_get_u32(info->attrs[DRM_RAS_A_ERROR_COUNTER_ATTRS_NODE_ID]);
>>>> +    error_id = 
>>>> nla_get_u32(info->attrs[DRM_RAS_A_ERROR_COUNTER_ATTRS_ERROR_ID]);
>>>> +
>>>> +    node = xa_load(&drm_ras_xa, node_id);
>>>> +    if (!node || !node->clear_error_counter)
>>>> +        return -ENOENT;
>>>> +
>>>> +    if (error_id < node->error_counter_range.first ||
>>>> +        error_id > node->error_counter_range.last)
>>>> +        return -EINVAL;
>>>> +
>>>> +    return node->clear_error_counter(node, error_id);
>>>> +}
>>>> +
>>>>    /**
>>>>     * drm_ras_node_register() - Register a new RAS node
>>>>     * @node: Node structure to register
>>>> diff --git a/drivers/gpu/drm/drm_ras_nl.c 
>>>> b/drivers/gpu/drm/drm_ras_nl.c
>>>> index 16803d0c4a44..dea1c1b2494e 100644
>>>> --- a/drivers/gpu/drm/drm_ras_nl.c
>>>> +++ b/drivers/gpu/drm/drm_ras_nl.c
>>>> @@ -22,6 +22,12 @@ static const struct nla_policy 
>>>> drm_ras_get_error_counter_dump_nl_policy[DRM_RAS_
>>>>        [DRM_RAS_A_ERROR_COUNTER_ATTRS_NODE_ID] = { .type = NLA_U32, },
>>>>    };
>>>> +/* DRM_RAS_CMD_CLEAR_ERROR_COUNTER - do */
>>>> +static const struct nla_policy 
>>>> drm_ras_clear_error_counter_nl_policy[DRM_RAS_A_ERROR_COUNTER_ATTRS_ERROR_ID 
>>>> + 1] = {
>>>> +    [DRM_RAS_A_ERROR_COUNTER_ATTRS_NODE_ID] = { .type = NLA_U32, },
>>>> +    [DRM_RAS_A_ERROR_COUNTER_ATTRS_ERROR_ID] = { .type = NLA_U32, },
>>>> +};
>>>> +
>>>>    /* Ops table for drm_ras */
>>>>    static const struct genl_split_ops drm_ras_nl_ops[] = {
>>>>        {
>>>> @@ -43,6 +49,13 @@ static const struct genl_split_ops 
>>>> drm_ras_nl_ops[] = {
>>>>            .maxattr    = DRM_RAS_A_ERROR_COUNTER_ATTRS_NODE_ID,
>>>>            .flags        = GENL_ADMIN_PERM | GENL_CMD_CAP_DUMP,
>>>>        },
>>>> +    {
>>>> +        .cmd        = DRM_RAS_CMD_CLEAR_ERROR_COUNTER,
>>>> +        .doit        = drm_ras_nl_clear_error_counter_doit,
>>>> +        .policy        = drm_ras_clear_error_counter_nl_policy,
>>>> +        .maxattr    = DRM_RAS_A_ERROR_COUNTER_ATTRS_ERROR_ID,
>>>> +        .flags        = GENL_ADMIN_PERM | GENL_CMD_CAP_DO,
>>>> +    },
>>>>    };
>>>>    struct genl_family drm_ras_nl_family __ro_after_init = {
>>>> diff --git a/drivers/gpu/drm/drm_ras_nl.h 
>>>> b/drivers/gpu/drm/drm_ras_nl.h
>>>> index 06ccd9342773..a398643572a5 100644
>>>> --- a/drivers/gpu/drm/drm_ras_nl.h
>>>> +++ b/drivers/gpu/drm/drm_ras_nl.h
>>>> @@ -18,6 +18,8 @@ int drm_ras_nl_get_error_counter_doit(struct 
>>>> sk_buff *skb,
>>>>                          struct genl_info *info);
>>>>    int drm_ras_nl_get_error_counter_dumpit(struct sk_buff *skb,
>>>>                        struct netlink_callback *cb);
>>>> +int drm_ras_nl_clear_error_counter_doit(struct sk_buff *skb,
>>>> +                    struct genl_info *info);
>>>>    extern struct genl_family drm_ras_nl_family;
>>>> diff --git a/include/drm/drm_ras.h b/include/drm/drm_ras.h
>>>> index 5d50209e51db..f2a787bc4f64 100644
>>>> --- a/include/drm/drm_ras.h
>>>> +++ b/include/drm/drm_ras.h
>>>> @@ -58,6 +58,17 @@ struct drm_ras_node {
>>>>        int (*query_error_counter)(struct drm_ras_node *node, u32 
>>>> error_id,
>>>>                       const char **name, u32 *val);
>>>> +    /**
>>>> +     * @clear_error_counter:
>>>> +     *
>>>> +     * This callback is used by drm_ras to clear a specific error 
>>>> counter.
>>>> +     * Driver should implement this callback to support clearing 
>>>> error counters
>>>> +     * of a node.
>>>> +     *
>>>> +     * Returns: 0 on success, negative error code on failure.
>>>> +     */
>>>> +    int (*clear_error_counter)(struct drm_ras_node *node, u32 
>>>> error_id);
>>>> +
>>>>        /** @priv: Driver private data */
>>>>        void *priv;
>>>>    };
>>>> diff --git a/include/uapi/drm/drm_ras.h b/include/uapi/drm/drm_ras.h
>>>> index 5f40fa5b869d..218a3ee86805 100644
>>>> --- a/include/uapi/drm/drm_ras.h
>>>> +++ b/include/uapi/drm/drm_ras.h
>>>> @@ -41,6 +41,7 @@ enum {
>>>>    enum {
>>>>        DRM_RAS_CMD_LIST_NODES = 1,
>>>>        DRM_RAS_CMD_GET_ERROR_COUNTER,
>>>> +    DRM_RAS_CMD_CLEAR_ERROR_COUNTER,
>>>>        __DRM_RAS_CMD_MAX,
>>>>        DRM_RAS_CMD_MAX = (__DRM_RAS_CMD_MAX - 1)

