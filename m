Return-Path: <netdev+bounces-132284-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id AE43F991284
	for <lists+netdev@lfdr.de>; Sat,  5 Oct 2024 00:52:13 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 08028284B81
	for <lists+netdev@lfdr.de>; Fri,  4 Oct 2024 22:52:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6E9521474B9;
	Fri,  4 Oct 2024 22:52:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="JvrdtXMU"
X-Original-To: netdev@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 918C7231C9E
	for <netdev@vger.kernel.org>; Fri,  4 Oct 2024 22:52:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=192.198.163.19
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728082329; cv=fail; b=lvmHj5wjRHDjbSq2XkC7OL1fDWJNO2XTaWhhsamCnd03ECwFYUIu0E69EwnwAPbU+A6k1pluX+s/+0JeHELZ2Wu6H/EZLrPmClkUB2w5cZaxdlqRiP6vU2lK2HeujO3zJNtUOEoGXrUr+J7YvwfAN0j/wAWW+s5sQVjxPErijUQ=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728082329; c=relaxed/simple;
	bh=VypfBR+a+PYoZiEqMRjoKV5X+D6DZkH7UDthvpf6pZk=;
	h=Message-ID:Date:Subject:To:CC:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=bAT/HklR32NsjCyv+VHElXOLJ4nt580sW6ikbGLvon04ZUCryvFfwC8iD/g4qTF/JfFConTKV/pTq7uA7iVMCquzpDPde/zVEDRF7s1iwWU//pejJTvP9gCi/QRxBWc2IiwUF9a8tjzol5qzQghCShqjdYYCLA5qnRj2nazMpl8=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=JvrdtXMU; arc=fail smtp.client-ip=192.198.163.19
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1728082327; x=1759618327;
  h=message-id:date:subject:to:cc:references:from:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=VypfBR+a+PYoZiEqMRjoKV5X+D6DZkH7UDthvpf6pZk=;
  b=JvrdtXMU9JBN5+IJxknbOHgv396wgtzoK2L352tcWK1L352gLEAhrpkL
   Du+Byg4cfERUXbgf5bARLIxIEXw+c1kMPBbIU2sKC668zSquIWBO0eT6c
   gdca/zlsUGJBNiRfvv3W87nvod+YyEbS7HghAtL2UAY8/rLTujrNSdvQ/
   d0Zk+yvzKehCPbtLsLV4yEWCKQ6fgvn55QUNVTi9ZvfFhODWhhAdf23uC
   zBBA09Acidoxpr1Lm5UeE3VilI+p2R7KoMlvZJoaOl96QNcMvPMB6MR2u
   a3DskEjjH2HE8Ba3Kr56tVOOyB852d/K5PH3M/qO9znQ28AlxKbTKNpuc
   A==;
X-CSE-ConnectionGUID: +8PyzgXfRMCN743i3FDMxw==
X-CSE-MsgGUID: Iy92u/nsQia6sZMakW7p2w==
X-IronPort-AV: E=McAfee;i="6700,10204,11215"; a="26822537"
X-IronPort-AV: E=Sophos;i="6.11,178,1725346800"; 
   d="scan'208";a="26822537"
Received: from fmviesa003.fm.intel.com ([10.60.135.143])
  by fmvoesa113.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 04 Oct 2024 15:52:07 -0700
X-CSE-ConnectionGUID: zzNQ61DpSaWQULhxGADj9A==
X-CSE-MsgGUID: ojBj1lfqSDWYQ/KpnSe1Pg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.11,178,1725346800"; 
   d="scan'208";a="78829635"
Received: from orsmsx603.amr.corp.intel.com ([10.22.229.16])
  by fmviesa003.fm.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 04 Oct 2024 15:52:06 -0700
Received: from orsmsx602.amr.corp.intel.com (10.22.229.15) by
 ORSMSX603.amr.corp.intel.com (10.22.229.16) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39; Fri, 4 Oct 2024 15:52:06 -0700
Received: from ORSEDG602.ED.cps.intel.com (10.7.248.7) by
 orsmsx602.amr.corp.intel.com (10.22.229.15) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39 via Frontend Transport; Fri, 4 Oct 2024 15:52:06 -0700
Received: from NAM02-SN1-obe.outbound.protection.outlook.com (104.47.57.40) by
 edgegateway.intel.com (134.134.137.103) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.39; Fri, 4 Oct 2024 15:52:06 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=cLRtCdmijMov1Icw1QGPAJObjXgEGizx5lRHEWY30KK0keNtbkmKhqv0o5TkoMprH7LJQY4TXMsIGAuHLXos+WyUWm9cnLPn/Ph6+5bajt9s/g8e9SXnms+KA1eO10WP3hHBRDj+PZxln9MpkHIi3QPgWVgdmiZTrmgvhRCas3WouwPLbzS0Vgg3Bs1qHACbG5yrzclG8Ul+voav5019KzPmdBDsPzxfJ0xoWY213i6Y4PYwN2oj+1hwWZGarvIZ2BbMUDyRC35jIU2aJX6l9SNZIC+0rRxDIeRt1tT1VFK21A+9u5fQjnisMbZ0BFZdnceyD2BYxAS4ggfq3gqgGw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=is1kVNm3V5h2hRW7V/wWdUH/C6/yI5UgfK5W7ir1brg=;
 b=TZ5fiPdTPFgVotm7BjvuT46y817iIWyxXoAmYHyhjJzOEjBKT184syjXppD8i0WTzlF1DlaEZnMzYWebqEeIdc5ftpu1wMYZDdZaHfKoIG+o7QLhhDrGpum+MQOn0Iy7tL+QKW6mUVnSNvvEqwWEMP+3YfAR4/oQbLFIBAP/r61dVdtuFpvsAANwfeWyTpd1wod0xS2n9PgEUer5HrcztipY1zzwTDbLapQL6+HEmfImy9mRWC2z2xBCKFFgw4zs6HFx8RSmv5jw0r2wDGg98LMWRKM3Higai63vwTT43IIQxlWVpArs8MsKkWWIXzUgAVxb+xdyBJco7ds9h5TyZA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from CO1PR11MB5089.namprd11.prod.outlook.com (2603:10b6:303:9b::16)
 by SJ1PR11MB6132.namprd11.prod.outlook.com (2603:10b6:a03:45d::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8026.19; Fri, 4 Oct
 2024 22:52:03 +0000
Received: from CO1PR11MB5089.namprd11.prod.outlook.com
 ([fe80::7de8:e1b1:a3b:b8a8]) by CO1PR11MB5089.namprd11.prod.outlook.com
 ([fe80::7de8:e1b1:a3b:b8a8%4]) with mapi id 15.20.8026.017; Fri, 4 Oct 2024
 22:52:03 +0000
Message-ID: <1156e722-2e71-434f-97d1-04b6abefbb78@intel.com>
Date: Fri, 4 Oct 2024 15:52:01 -0700
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net] Revert "net: stmmac: set PP_FLAG_DMA_SYNC_DEV only if
 XDP is enabled"
To: Jakub Kicinski <kuba@kernel.org>, <davem@davemloft.net>
CC: <netdev@vger.kernel.org>, <edumazet@google.com>, <pabeni@redhat.com>, "Jon
 Hunter" <jonathanh@nvidia.com>, <alexandre.torgue@foss.st.com>,
	<joabreu@synopsys.com>, <mcoquelin.stm32@gmail.com>, <hawk@kernel.org>,
	<0x1207@gmail.com>
References: <20241004142115.910876-1-kuba@kernel.org>
Content-Language: en-US
From: Jacob Keller <jacob.e.keller@intel.com>
In-Reply-To: <20241004142115.910876-1-kuba@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: SJ0PR05CA0101.namprd05.prod.outlook.com
 (2603:10b6:a03:334::16) To CO1PR11MB5089.namprd11.prod.outlook.com
 (2603:10b6:303:9b::16)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CO1PR11MB5089:EE_|SJ1PR11MB6132:EE_
X-MS-Office365-Filtering-Correlation-Id: 0a20b4de-16b2-4491-4d44-08dce4c72a1e
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|7416014|376014|1800799024;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?ZGlodDVPV0o0N1JhZ0hJak5ZZUNoN0VVSUlJaHN2YzdFaVFHZWZMbG1NUEpT?=
 =?utf-8?B?aHYxSHpkMmxoc0w4V2g1dUlwOXdTaGcxWEE1RnRaRE0xcmNZMm41T1RmbjNu?=
 =?utf-8?B?L2FvY09TUytub0VTcytzS1VLeVl0S1c1d1lhWGl5cXZYUUIrSE5Yb05RbFhF?=
 =?utf-8?B?bzRsUXZuUTJ2cGVCYjRrTVh4WkZJMFhGYWVoMm0ydXhQNDNFZis4a1JTUFhl?=
 =?utf-8?B?WDgxR3gxbkJESnk3R2p4ZjZkSjc4SHc4OWFVSHo3RmRCMGZGbXhONDFibnA4?=
 =?utf-8?B?MjcxM1pJNzNJMXZJNnFxak8zdS8wSnBIRVVCaFFMd1dVQk9Sb25CbmxqOCtZ?=
 =?utf-8?B?OG1HbTNIcmVvN3kzejVCTFVuVWxSY1JpbC9TSW9TVHhVUHIyM2s5QTlXbXJz?=
 =?utf-8?B?dkpDNmxOWWNHdWdZQktEVXBBOERTdWg5NWQrb3EvL1EzOXM1VVU0Z21VQk9D?=
 =?utf-8?B?Z0hJbDdTWEYvUm1sMXVNMFlRYlNRa0RQNGRGK2xhUDBiUW42aEJ5OENZR0d3?=
 =?utf-8?B?TDQyYlNkQjVpbkwxY2h2dXk2QWRQcHJDZW8va3dtK1J0VGtjQ1huR1hZWEtI?=
 =?utf-8?B?OENPK3RVUFJEUHhESkJFR1FLY201bjJmTjBTa1RyQlhLRGFMa1ZaK3JTMjBp?=
 =?utf-8?B?cUw4THo5WnZ6Z01iRzFWbWY4RTBJV05PT2QyZzR4UkZCSXJGZUZMalVwYktD?=
 =?utf-8?B?Q3FUNDlzWVZQaTN0MVNBU3crY1pmTnR1MWpKdk9raXdkd0RZckg4RGc2TDBI?=
 =?utf-8?B?UWpSejlkNThYMmdEMkRCQ3ZISmZrZHc0TmZ4aThuNW8rdGtlaHAyZzBNK0dY?=
 =?utf-8?B?S1dYZTJjUGZVdnBjOTZDdWh2dVRGODlkZTFHVUhXc0dVT0lwai9nVXJnMmE2?=
 =?utf-8?B?TGVJRkJaZ21hVThIUlNTbFhsZ3UrWG4yZjVyVTJrTTJnWXArVkRBK2lwL1M2?=
 =?utf-8?B?TEE0S0s4cmx5R2V1RDhZTXZ5Vkxtc24rdjlBeGF6Nm9UdzZOT2h4RTB5WHh1?=
 =?utf-8?B?Mm9oU2UrT2tOWFduOXFsSHFyVnhCY0VLZFM5OU1pMlRYQWIyZE8yTjc0NFhD?=
 =?utf-8?B?dzdFL0J2RUMrT3B5TFVFTXoyRFN1UzFmYm5PaitNTStCMWlOa2g4VTJJSWpj?=
 =?utf-8?B?UXN3bWxqd2ZyRTRTZWdjZ2dqc0JDYWNjNlA5aXhUWWhQVVkrUHlDOU5TMlpy?=
 =?utf-8?B?dVdDcGI4UHVZLzB5MWkyOEErZnAzOVpwVlNPUVBXaEZIcm1TcUJMVzJVVVF4?=
 =?utf-8?B?TWF6di9MYnVaREFFRmQzZnJzS1JZSVZHMHpIMUt2bmFCRk1GR2RKQVJ4ZHZZ?=
 =?utf-8?B?YU9qNkdoMWp0WSsxQVk3V1BWbnU2RHQyZGNyYjRGNlhVL3ROeEhTVVJST0lT?=
 =?utf-8?B?T0NRcnJyZi9oMzVrQVdvM2tBRDFDbEZJVlNTZFMvWDZGNzFpbGRjY0FyTnF1?=
 =?utf-8?B?UnZWcTMzWEQyYTNYeWhVWm04emtGS0ZRWFZ4dTVlWmhLaVZDRWZDa3czZU9P?=
 =?utf-8?B?MVAwSFUrcitDNEpucElPVlIzQ2M2bVRvN3RyWGJKQW5HU0JtWHNHQlVoQ1po?=
 =?utf-8?B?c1ZJVVJFa0xIbEZDR0lSUU5MZ0dCQzUyM3dTeWRMWThiZHZWMUkrdE9VYkhY?=
 =?utf-8?B?SzdOTWFWRlFyVzJucDVYNEJ4UTJIc2s4NG8yUzB5TFkvZW15N3huL2RqV1F0?=
 =?utf-8?B?QkcvZjYxOGh6OTByQ0doOU8yR1k5cjZTSENMNnJzZXNMWlpCY0ZMR3hnPT0=?=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CO1PR11MB5089.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(7416014)(376014)(1800799024);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?UzRqdFQwSEtiR1JxYU5vWlJvUS9odVVTeHJnN2dZWmdOdy8zUUtXYjBQTHBr?=
 =?utf-8?B?THYySzBsaTFRZURYSHk0cFl1N2c1S0xxek85K29DWjBMalJPVHYrNUt4SEZv?=
 =?utf-8?B?Q3pvM2dVVnVBREVNdU9MNUlESlNUSjVrUy96RmVHblZOVGpwWFV6Q0l2emFa?=
 =?utf-8?B?bGRhNHFzVllwbkk1S0JJSEFuTUZXNUFycUhEYXp1cW1CTnMrc0QzQjlGR09P?=
 =?utf-8?B?Wm9EUzRtMFk3MC9jQ2h0ZmhGclBJb0VSbmMxeFVka0VPdHBMWGtkRnU2alpk?=
 =?utf-8?B?d3Npa2ZISy85d0dKbTVIS2lUZXoxdm1GWE8rVEFxVkY1SHo4U0ZMQWJQU2I1?=
 =?utf-8?B?VVI4bjhGRENCMkRReEsyNkh4RmhOeGRIaXNlK2x5M0hqRGY5WlR2c1p6cmo0?=
 =?utf-8?B?TkllMkdFM1o4ekFmWkhBU2dPVWtQM0VnN0trQzdTb3dWaDZzZnZWM3k5YkhS?=
 =?utf-8?B?VnE2cEhaRGFuZk5WNGFQVEZDdVNHbTQ2di9lTlVWOE9RMFI2N1ZJZlZjc1lU?=
 =?utf-8?B?YnZoYTFnNloxL3hVbkpGK3ZuMDBwaldyOFhHZ09BSSttZjR0cGhUdU0zbVlQ?=
 =?utf-8?B?QTFVTFdmSUNBSXEwSkZ1ZW0rbkdBNnhkN0FRaVE1WkdvcE1wTFRRanVrVEgw?=
 =?utf-8?B?MUJ2MVdsZzFaYzRXbFBmeHMvaFRGWHFtLzVtM2JHQm9KbE9YS3RxRFNNa0h3?=
 =?utf-8?B?RkQ4cTZmblc4Nmp1VGRnTUNqWlp4MkxaVldyRS9ybUtMcUI2QVAyUDZzc2o3?=
 =?utf-8?B?OHRIVDliSnlKdzBtanEvRjkxYlgyaUZkcU1KVGdSYW14clBVd3U1UXNzazhP?=
 =?utf-8?B?THNmcnVwZnRzNVlhQ2xGWmt2RmVpN2s1OXVQNlM2R2t6ZmZaR2FhVWFyeVpw?=
 =?utf-8?B?c2J3RGlqaktyeGZzYjlIQlRxUkcxWFUyK29hejdZQTlncDFKVThSc0djNzFl?=
 =?utf-8?B?eFprR3pEZC8xelZQUVZsbURRb0ZycmNxeEg4WWdEMXNjR2dwMFY2NzdZM1Yx?=
 =?utf-8?B?UnhYRk92NzRGYlVVZzBnd25mZVF1ZjRnNy9lT2RoRExMTHJGakFtRkpoWjcx?=
 =?utf-8?B?WTBJcUhoMW5MemE0NGtRd3BTQ2ppNDg0LzVXMkZ4cUFlbDA3bHRUdklKM3FI?=
 =?utf-8?B?ZGxMYzJiakdnSXhROGp4K3EvYVFsckNGajFYUXlPUW1VcllPQnlBdkpmZTJs?=
 =?utf-8?B?SWNqOXk2NHBkMWNHSnhsbnQydGEvRGFkMktIQnRZOHF2T2doN2JEVUQyMXVD?=
 =?utf-8?B?T3RqdkI5cXFxN3RUVHJwM0c5TjdGa2Nac3cxVWlSaElobTJ3aSt0RW9NZlBy?=
 =?utf-8?B?aVNVcHF3SU5Jd3Y3bmdKbGNsb1IrTkNhUUVLRHpBUXhid2ZKeGdDVEhhSDdv?=
 =?utf-8?B?NWVUK0hsbmU2Y3NPdW9ESlZIdmpUM21wbTluQkhiQ05NZEpTTEVyTk05M1Aw?=
 =?utf-8?B?MExFNjZPMjVLYXRidDVia0FzR0d3TDdwWXgvL203WVlIZWR0bjhmeTlRa0hT?=
 =?utf-8?B?VE1xOFZVRS95empqWXNaRHg3aElZaFJ3WXQ4Q2ptQ3RERE5ybW5idXBMWHhy?=
 =?utf-8?B?MlJxWmJtTFNsaklzY1F6UzUvYTg5YzJXSWo0VGh0MlY3eEVWOEZlN1FvcXc1?=
 =?utf-8?B?NUlJT3lJNkZYSDRudjl1VXpnOEwxNlVTNlRFcjBMTG9HMTZPYWdZUzRiTzBn?=
 =?utf-8?B?bDZ1dXN1bGVJU24vMHM5Y1YyTUhqR0VtK0IxTXdrQVlkNUlRWUUxcWhwMzlV?=
 =?utf-8?B?MDBvWGVqWEw2NS9lb21nN3J2dGJ0ODV0aWRFcWRyNm44M2N1OW9UbE14YUx4?=
 =?utf-8?B?ekRxb2VKV25FSEkvbERMK0NEUXg0WkVLRjVvbjM4RGRBa1owcmVNeXYwMnpX?=
 =?utf-8?B?T0wrc2M5TVZTNmxWWlBtdGNYOFJkVWtnQjRPM1pTQzYxcVluYUw3T29OcHBY?=
 =?utf-8?B?TUl3SkJhSFdSZzR0T0NFMkl6djJXVGNUbTZVczZGSUkxL2t1UUdSREFqbHBw?=
 =?utf-8?B?UXRVc3VPSEFrTVJVUCt2UHN2NGl5ZHFLVzhUZnpXTGxGTExSdTVYWGI3cm5h?=
 =?utf-8?B?QTdMMDBrREdBNjBscEpvV0NuS3hQdUNHUWt0SEQ3UFE1TW5kTzUrd3VwUGp6?=
 =?utf-8?Q?LMuCxSvvtx5o/br4G0ajauCS9?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 0a20b4de-16b2-4491-4d44-08dce4c72a1e
X-MS-Exchange-CrossTenant-AuthSource: CO1PR11MB5089.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 04 Oct 2024 22:52:03.6902
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: Sp+AayoHTC2iLdev4vaDJwLO8bvf4vCF0/TzSYvTRsS4ZWH3zyip49BBJxaUIPT3Xt/y4So6EAc0oo67o3QYG/eY7AofXWJcl7zhR592Gu4=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ1PR11MB6132
X-OriginatorOrg: intel.com



On 10/4/2024 7:21 AM, Jakub Kicinski wrote:
> This reverts commit b514c47ebf41a6536551ed28a05758036e6eca7c.
> 
> The commit describes that we don't have to sync the page when
> recycling, and it tries to optimize that case. But we do need
> to sync after allocation. Recycling side should be changed to
> pass the right sync size instead.

Makes sense. A proper fix would be to pass something in from the
recycling code to disable sink.

Reviewed-by: Jacob Keller <jacob.e.keller@intel.com>

> 
> Fixes: b514c47ebf41 ("net: stmmac: set PP_FLAG_DMA_SYNC_DEV only if XDP is enabled")
> Reported-by: Jon Hunter <jonathanh@nvidia.com>
> Link: https://lore.kernel.org/20241004070846.2502e9ea@kernel.org
> Signed-off-by: Jakub Kicinski <kuba@kernel.org>
> ---
> CC: alexandre.torgue@foss.st.com
> CC: joabreu@synopsys.com
> CC: mcoquelin.stm32@gmail.com
> CC: hawk@kernel.org
> CC: 0x1207@gmail.com
> ---
>  drivers/net/ethernet/stmicro/stmmac/stmmac_main.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/drivers/net/ethernet/stmicro/stmmac/stmmac_main.c b/drivers/net/ethernet/stmicro/stmmac/stmmac_main.c
> index e2140482270a..d3895d7eecfc 100644
> --- a/drivers/net/ethernet/stmicro/stmmac/stmmac_main.c
> +++ b/drivers/net/ethernet/stmicro/stmmac/stmmac_main.c
> @@ -2035,7 +2035,7 @@ static int __alloc_dma_rx_desc_resources(struct stmmac_priv *priv,
>  	rx_q->queue_index = queue;
>  	rx_q->priv_data = priv;
>  
> -	pp_params.flags = PP_FLAG_DMA_MAP | (xdp_prog ? PP_FLAG_DMA_SYNC_DEV : 0);
> +	pp_params.flags = PP_FLAG_DMA_MAP | PP_FLAG_DMA_SYNC_DEV;
>  	pp_params.pool_size = dma_conf->dma_rx_size;
>  	num_pages = DIV_ROUND_UP(dma_conf->dma_buf_sz, PAGE_SIZE);
>  	pp_params.order = ilog2(num_pages);


