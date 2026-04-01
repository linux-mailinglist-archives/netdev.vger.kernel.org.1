Return-Path: <netdev+bounces-273893-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id yJFcMIurzGnNVAYAu9opvQ
	(envelope-from <netdev+bounces-273893-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Wed, 01 Apr 2026 07:22:19 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [IPv6:2600:3c09:e001:a7::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 25774374DD3
	for <lists+netdev@lfdr.de>; Wed, 01 Apr 2026 07:22:18 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id 5302C301DB64
	for <lists+netdev@lfdr.de>; Wed,  1 Apr 2026 05:22:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 30E0335CBCB;
	Wed,  1 Apr 2026 05:22:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="SgmdVB20"
X-Original-To: netdev@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.15])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 35022378D68;
	Wed,  1 Apr 2026 05:22:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=198.175.65.15
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775020937; cv=fail; b=D6AIZIQZddE5zfveeB9FZAplmQVRU91k2dL5CXX8gI5rJqqDH4hoCjjm/S739MbJ2AWGaD60JVR6AQyMsLcuUKebMtptA9xW9YUaNopKHVRW6TnFZ04EVbXllPLi6uhduufPh3B6O6MJgWmoPrp22PeRiPOAI5b+ETlhfcaRyTc=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775020937; c=relaxed/simple;
	bh=IxJQqzK8wl5ScqIXVa6DFhzixru/nfIhfwpbsttK8ZI=;
	h=From:Date:To:CC:Message-ID:In-Reply-To:References:Subject:
	 Content-Type:MIME-Version; b=c+T09mbi8rHfQ5enBT+2OBaSPlI33HPJ8+V7Le0g2apjpvnu/O4onlPi+jZo1phY+UNtfn32dEjJf2+pl98MDdFttVUeBXvqgI57N0JE1dNw1tccN/n7Jl1Rz5mfrcFSstTvBk0FwPkVJxR5AOR6Ra9AOb4tu25ysQ7LnPQ6Jsw=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=SgmdVB20; arc=fail smtp.client-ip=198.175.65.15
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1775020935; x=1806556935;
  h=from:date:to:cc:message-id:in-reply-to:references:
   subject:content-transfer-encoding:mime-version;
  bh=IxJQqzK8wl5ScqIXVa6DFhzixru/nfIhfwpbsttK8ZI=;
  b=SgmdVB20kpsnbp4n52BDP9kMM/b17HXOJAHkHTfNS2p3zqW1VHTDZKf7
   V0ntM9pFvHM6hNaGRwm5iJqRQ7ASClYLQM+V7CBqxCyRXyUVxxK7dbr1z
   BB9Buy4MziqbjuRN7Nfxa2sRKo9BK6WIIx/bPCGqIBKlFmexaluqXV/xw
   WIKB0vSovDbs4M3LR0GD36+tvHODbSqqQrjsD8KZfpU1xLUHdzwuIiuxT
   1HiZ3lMaX3yYscQIXg9Tualzn/Sr8E+HeNn9hzJE9p0GHaGfxXaRj2Pad
   NwTZJKfAFOqJ6SQ03wBL2jQBJ1auWJW+nxD8VyfHe84N5/IfZYY0ben69
   A==;
X-CSE-ConnectionGUID: FzADli8zTP+dct0FOciR8Q==
X-CSE-MsgGUID: 96sTPRlXSLWlANt8w5FGfg==
X-IronPort-AV: E=McAfee;i="6800,10657,11745"; a="79653140"
X-IronPort-AV: E=Sophos;i="6.23,153,1770624000"; 
   d="scan'208";a="79653140"
Received: from orviesa009.jf.intel.com ([10.64.159.149])
  by orvoesa107.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 31 Mar 2026 22:21:58 -0700
X-CSE-ConnectionGUID: 76aw41v8SnCe4BQWoJGwgw==
X-CSE-MsgGUID: LejoqCevR4GB+/nKxkJNSA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.23,153,1770624000"; 
   d="scan'208";a="226445747"
Received: from fmsmsx901.amr.corp.intel.com ([10.18.126.90])
  by orviesa009.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 31 Mar 2026 22:21:59 -0700
Received: from FMSMSX902.amr.corp.intel.com (10.18.126.91) by
 fmsmsx901.amr.corp.intel.com (10.18.126.90) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.37; Tue, 31 Mar 2026 22:21:57 -0700
Received: from fmsedg902.ED.cps.intel.com (10.1.192.144) by
 FMSMSX902.amr.corp.intel.com (10.18.126.91) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.37 via Frontend Transport; Tue, 31 Mar 2026 22:21:57 -0700
Received: from CO1PR03CU002.outbound.protection.outlook.com (52.101.46.39) by
 edgegateway.intel.com (192.55.55.82) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.37; Tue, 31 Mar 2026 22:21:57 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Hi9sE9gzJQoX0OvOqR7pO+o3b9EMvr+w3WXVHYhgHp4LOxsfwl2EsQircbiKxiMqv8vEvR/ordt+2YvLO7zHvzwvpQmTfy/irZHkHNeO9/RmxNvZQgzjv+yyRwP7DCFv8noJMSZlZMb/TnM7SLLwPIrklGfGdeAGpAaJsOOKiiw4D7LcwBhllQanb/FnSbJE53PaAADt+Ua1sbekA8onZp7i5DP1F/Y13y065fgs7rpre5G7O+91P9BF7drHQhryD59tRYuu9KVSHrqSZPpOD8L3bYC3jspmOXyMYni9UCneTMMONgJ928lduRQSMZ20RYD3LL/Srb1rdYMtfdnqaw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=nDf3I8CdWaU25h6eF078Xhf6wUglNI2di1gZtwnz/QQ=;
 b=M1PzCwhrRGmclRWwYRhDzMOdMiGmII6u2w6AlTcZ7serapT8ta7K/tgGwDCsgc7YoBTMp0Lvn3Vjr68pJ6RC9yCS6HTAGbZoXnKZLcyR48EbTLI3Mefo6AHxyJUYRzrvBFuOSEm64wbasb5L7IV946Fhx7QqWoLITz3ODoAqKoQQ3tNajT2hbq94L7LaNYxOy/jcm2g6HAeg39x/LRBMxCGYdZx+IrySLIKX2oXEV/60Cb2hCzwBPlLoSTPJAHoFNYW6AEaRcP+yRq5W07SE16Pa9Z66W8FJgtF5wfJevDWEqFjEiLkSCiaR/Q+kRkT4yUA8SVwL1MdxCOLNNUpTpg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from PH8PR11MB8107.namprd11.prod.outlook.com (2603:10b6:510:256::6)
 by DM3PPF5217261E0.namprd11.prod.outlook.com (2603:10b6:f:fc00::f21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9769.15; Wed, 1 Apr
 2026 05:21:55 +0000
Received: from PH8PR11MB8107.namprd11.prod.outlook.com
 ([fe80::1ff:1e09:994b:21ff]) by PH8PR11MB8107.namprd11.prod.outlook.com
 ([fe80::1ff:1e09:994b:21ff%3]) with mapi id 15.20.9769.014; Wed, 1 Apr 2026
 05:21:55 +0000
From: Dan Williams <dan.j.williams@intel.com>
Date: Tue, 31 Mar 2026 22:21:52 -0700
To: <alejandro.lucero-palau@amd.com>, <linux-cxl@vger.kernel.org>,
	<netdev@vger.kernel.org>, <dave.jiang@intel.com>, <dan.j.williams@intel.com>,
	<edward.cree@amd.com>, <davem@davemloft.net>, <kuba@kernel.org>,
	<pabeni@redhat.com>, <edumazet@google.com>
CC: Alejandro Lucero <alucerop@amd.com>
Message-ID: <69ccab70808c6_1b0cc610039@dwillia2-mobl4.notmuch>
In-Reply-To: <20260330143827.1278677-9-alejandro.lucero-palau@amd.com>
References: <20260330143827.1278677-1-alejandro.lucero-palau@amd.com>
 <20260330143827.1278677-9-alejandro.lucero-palau@amd.com>
Subject: Re: [PATCH v25 08/11] cxl: Export function for unwinding cxl by
 accelerators
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: MW4PR03CA0283.namprd03.prod.outlook.com
 (2603:10b6:303:b5::18) To PH8PR11MB8107.namprd11.prod.outlook.com
 (2603:10b6:510:256::6)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH8PR11MB8107:EE_|DM3PPF5217261E0:EE_
X-MS-Office365-Filtering-Correlation-Id: 27285878-1466-4764-5be6-08de8fae96f0
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|1800799024|366016|921020|22082099003|18002099003|56012099003;
X-Microsoft-Antispam-Message-Info: MBSlatGfaHrEpxlC9+o5hureIyjZl7LlrhgFdM8dhtd9j3SCxee38IdRfAScaLocZ4Wk1T097MpJK3D99pIpoUu/eO7tf2iyQQRJfDVO04Yy5nQ1W3WrIv12kI1EsFDc3p+m4Su6vXlax7uW1RVvLAvG/JAWc+qXyM0RZ19DVaTaL7ShuzPZHlR3FqSaYqrZGSxMvKhDI1mHshXfG2G6/cfg0vN1xsyiUctO/VUhMZZWaqTV+dIYCv2CPmxjhLf/srHRND8XB8eSZ/iEO/KiUNgWmYC6D00F38o919YUVGHt71vogfZQjvq/JA0ObhDyRTTO3Jx/fjcgxzLcOyOtSZJ+Dq+8agvlE16d8LyWrMYibXWSi7NXG4hOFqRQ02gOyKQ6OVMvSTEupIZCOaDOg2ysrDJKZ445WHT06/hrqzvwOezRRr6JdLtL7SaFfINAxtics/CosgUR9CYUUDTLM/Thg/9+gwAySZoQKT8Qm3/nBy4W1Ogc4g0Hn4H9PAki9wrhaBjjG4XnaVkz9IApQzigPoTU5PsOovIWmJEf+5BP7kbSK5dyzZHAuLAXR2wWV4bKpQH+0I7as/qNwqAdYJnPksLZYXlX/2z460CBQnwAT1awBp3PO8kfONGeqHpL+tc3A4Z97o2+sow2sihGTu4WA+QXsjsa/UWI2WJDE3uNoLPmKQl62/cxGcX/o3N7+RzLsOOI0QSf6ISHs74P+o/laNv6ZaUX4TBxy6oucwbWwG/cy6SI1i3k2Y4tSxpPs8Hw1TrgYMwFnWAG/6FIdg==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH8PR11MB8107.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(1800799024)(366016)(921020)(22082099003)(18002099003)(56012099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?S25LeFpCVEo4KzFsK0FoaEF6aGZzeTRIcTZGWS8zTTJVUEZ0bitGZE5HZHhs?=
 =?utf-8?B?QzdjZXdTOXFmM3NYUWdiK2pZY1p6RGNHZURqNVk0Y1JWQVFONFUzOURTdUFz?=
 =?utf-8?B?ekpmS1pTUmJuTUVubjVYYkVtSS9mcXdYdjlpMkhkcHh5ZFpzbWYvNXcyUytW?=
 =?utf-8?B?NWVrc2NScDBGa04xSk5vWVViU1UwOGZGOHdXTjMvbEhsYzV0N2N6LzFaWmdx?=
 =?utf-8?B?aERlbTBOa0MwamY5bGltU0hWUEpGSDNKek9tdjV6ZUZBUlROQk02SlNpdHRT?=
 =?utf-8?B?d2xCTHRhVWRnaTJpcDlTejhNakdBT2oydUUyTUdacXdxRThJY2VVbTlFc21z?=
 =?utf-8?B?dGFUMmxFdEc1Q3lHb1ZXWlpnQW9aa0UwZjk5Q1R6cmFLYzBIK3ZRWU5zWXV5?=
 =?utf-8?B?RGx2KzRHaGE4U0dhZ3N4Z3ptZnBNNE8xMG5TbS9HSmhWaSt6a0Q4WmlWbG9k?=
 =?utf-8?B?N282WC9MNFFZNlVBYThtRTV3bU9HaFc5aUQvS3JMTGZTeGYvRUxIUVE0SW54?=
 =?utf-8?B?c0U4ZnRSOUZnNFFBZ2pHU2RXK1JMYzNsVHVFa1ZKUUNzWWx2bmwvVTJXaHlE?=
 =?utf-8?B?YmJTVXVTREhmSkRXV3lIOU9UMWVTWGlQZWJ2YUo0ZVJrSnRtVW9zY2dxTDI1?=
 =?utf-8?B?VTk0NjdtN3dqQjN3QXkralMyUFcySDlPOVpPQXFZWG1rVllaa0k0MmNpbnhZ?=
 =?utf-8?B?V2hJcGYrWVpjSHZjUWY4UUF3SVVlWE8vN3lTRFVOYStTeXJ2dXF6WVcyNERv?=
 =?utf-8?B?TTBWQzdyR3RPZFRjQ3NuR2dQYktZVWxWOEFmWGkweSttRG00Um1yZDY5MVdZ?=
 =?utf-8?B?K3FWSWxDbU1WcGhNaExkcVZXNnJQSHBCSXArVE5iRVRJMHJKZUdVTGxEb3E0?=
 =?utf-8?B?RGZ2RnU5OElQN1dMSlUxOHMycDNuTkIrL084UnJuQ21VWVVhQk0yYVVSSzVh?=
 =?utf-8?B?NjQyUkJHbXI1cHBzUldlZkNBYWZya1FzdjBYTmhGVk9jZWNjckJwZlo4VlNF?=
 =?utf-8?B?NUU3NkRNZ0F3YnhWUnljdHNLTEw0TjRtS2NncFo5cTA0WEovZ2JreUNCdlN1?=
 =?utf-8?B?MEIrV3VVMW5mRmJMMzJqM0wvOHVFaXdJR2xPdVhDNHNLQjBxVzJZOGxINTFp?=
 =?utf-8?B?THdNVTIwdytXNXJRZFF3WXlpVTlGTWgrTnFEc1V0a2FhSWo0YTV2QjFrRFRk?=
 =?utf-8?B?eEZCWHBhSnlnTXZsWFBHcUx2S2o2SFJobG1LU3c2cktNcjVHVG8zbGpwM2U2?=
 =?utf-8?B?SENTT1lpSy9IZHo5b285SlpVVTNwbS9ZWHNUQXNiMGt2VnBJWXk4SHlyc2ZJ?=
 =?utf-8?B?d0F5WHROeUVObGs1ai9OTHFCbkZaRUtidTRZR1lPT2MwNnc2L0xXK1NidVMr?=
 =?utf-8?B?WERJQlg2SE5ENlF2d2JqSnhtNWR4TmhEOE5HQmJ0REVKTUt4d2cybGJvbEdw?=
 =?utf-8?B?akNFNkdMQ3c0YXhSV1YvUlZ4TDA2dmN6T0pGWDR4WHdLajZVdGJKazlodkxh?=
 =?utf-8?B?cmMyKzdDVzNDRDE5ZFhma3FaMW9halNSdExxMGJ2eGE1VFNzV1RxNUhpejVH?=
 =?utf-8?B?MWFMYWQ4bytiL2F2SVMzZTNramxoTHpJc2xoTmU4cWRzbGY2ZzZGVi9SQmg4?=
 =?utf-8?B?VFZQZGVJdjdjRWhnZ3hFYTlKTHVSNWdSbTVoQ1RrNEJXRVZ2c1gyZk5lWXUr?=
 =?utf-8?B?YmVTVm9xRnp4UTdtVWhVQUlvWWFSVW9tOGFnczJIM3V0Z2hoK3Flb1pkTkho?=
 =?utf-8?B?T1VXaWRteVM0b1UvNngrMmFlNG9tWDNCRUN0aEpML09CWGVUR3dzS1RSa254?=
 =?utf-8?B?L0xlaXVrV1NTS3grUFlTTmpKdXR4akFBNGhBQ0FPOE0wMlgzQk1jRGZJajZG?=
 =?utf-8?B?UCthSEJob2xQRGo2eGxScTF5Um9HREpza3BiRzhWb3FjMUZJWnlYQ0JNZ1Bl?=
 =?utf-8?B?U2crY3VkeTAzMmluWnNYUWRvYW90YzFPeGtqS2kwY0FicHloTnFnK2ZBWkhG?=
 =?utf-8?B?alpjUm92T2prOHBUQWsreVpxMFBNdUFpZzRmMU84WFV0akE4cFdXd1RaaCs1?=
 =?utf-8?B?cUdtOGd3QWl3aDRJcWgvcDlxOTV1YlZXdHNtc0dFZ2R0aWlKZmp4SUNXdHUr?=
 =?utf-8?B?Nmo2MGorRm4zVE85YnBMemd0cG9Ta1JvQmZuanpMWEV4TVhKbnlsOVhFcVZP?=
 =?utf-8?B?ZENWZmI0eVI5S2tteHcvS3NHT3FPai9WY0VKU2Irb0Z4YzFsbkZBbWYxdm9v?=
 =?utf-8?B?cC9SaExUOWJ2MFlMODZ2bnpweVZsZEp4SEcwVjJ5ZkpDWUtlb0RnMmJMQVFB?=
 =?utf-8?B?OFpzSFRuS3BHM3QrMlpsbSt0bHkzUDZNcmgwcG40ZUhKTVdaZVpaZ213alpT?=
 =?utf-8?Q?TmN9+taLFvOQJ9vk=3D?=
X-Exchange-RoutingPolicyChecked: TwDAfDt6r2DaCbgqxL2UBhUNomhL/h4GH16RNwb1haKAxghkyrtpBOTWTlZqrde1j0F8p1rPzl3k8Fp6n66o0hyq+4QhYZoQVXM1gwcyPzIfyxW/P5CNuQF+4ZdSWUCvA9+HSOpwmoPatlF2e5hEwUuZtT5zDUij6WypeBibi08h2RZimbo/nCdTxx7XkfiZeSMg7Q9xDki4T9szskZFNGrhHbk7kmrZXpzN6O3yqnsHwysiKmkLRrIylQ+ct1Qw7Fb3ZctbArS+k6GgDVGj8cw7kmUHMxcLSsduGrq8gUhz5wI0iFXBhSL2/2uHwZzXHmvYWq+6MfgVd3nx4JX7cQ==
X-MS-Exchange-CrossTenant-Network-Message-Id: 27285878-1466-4764-5be6-08de8fae96f0
X-MS-Exchange-CrossTenant-AuthSource: PH8PR11MB8107.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 01 Apr 2026 05:21:55.3423
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: WfrsPVeLFT2E/v4B7IbK3NpZC+aPaT29nnH5WSlvAxzklqTifcSxDDULUXdtu9Cge4U5GqQj0lnJtbFvNrpb/x7kk2TWj28bth4dT9ltEZo=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM3PPF5217261E0
X-OriginatorOrg: intel.com
X-Spamd-Result: default: False [-0.16 / 15.00];
	ARC_REJECT(1.00)[cv is fail on i=2];
	DMARC_POLICY_ALLOW(-0.50)[intel.com,none];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c09:e001:a7::/64:c];
	R_DKIM_ALLOW(-0.20)[intel.com:s=Intel];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-273893-lists,netdev=lfdr.de];
	DBL_BLOCKED_OPENRESOLVER(0.00)[amd.com:email,intel.com:dkim,intel.com:email,dwillia2-mobl4.notmuch:mid,sto.lore.kernel.org:helo,sto.lore.kernel.org:rdns];
	DKIM_TRACE(0.00)[intel.com:+];
	RCVD_TLS_LAST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c09::/32, country:SG];
	TO_DN_SOME(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[dan.j.williams@intel.com,netdev@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	MISSING_XM_UA(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	RCPT_COUNT_SEVEN(0.00)[11];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[netdev];
	RCVD_COUNT_SEVEN(0.00)[10]
X-Rspamd-Queue-Id: 25774374DD3
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

alejandro.lucero-palau@ wrote:
> From: Alejandro Lucero <alucerop@amd.com>
> 
> Add cxl_unregister_region() to the accelerator driver API
> for a clean exit.
> 
> Signed-off-by: Alejandro Lucero <alucerop@amd.com>
> Reviewed-by: Dave Jiang <dave.jiang@intel.com>
> ---
>  drivers/cxl/core/region.c | 8 ++++++++
>  include/cxl/cxl.h         | 1 +
>  2 files changed, 9 insertions(+)
> 
> diff --git a/drivers/cxl/core/region.c b/drivers/cxl/core/region.c
> index 9c3ba911d865..b3a6d08be461 100644
> --- a/drivers/cxl/core/region.c
> +++ b/drivers/cxl/core/region.c
> @@ -2490,6 +2490,14 @@ static void unregister_region(void *_cxlr)
>  	put_device(&cxlr->dev);
>  }
>  
> +void cxl_unregister_region(struct cxl_region *cxlr)
> +{
> +	struct cxl_port *port = to_cxl_port(cxlr->cxlrd->cxlsd.cxld.dev.parent);
> +
> +	devm_release_action(port->uport_dev, unregister_region, cxlr);
> +}
> +EXPORT_SYMBOL_NS_GPL(cxl_unregister_region, "CXL");

devm_release_action() must only run from port->uport_dev attach context,
I.e. a context known to not race ->remove() / devres_release_all().

