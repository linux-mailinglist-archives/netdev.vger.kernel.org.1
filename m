Return-Path: <netdev+bounces-210229-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 5F8F0B12702
	for <lists+netdev@lfdr.de>; Sat, 26 Jul 2025 00:56:19 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 08559AA5428
	for <lists+netdev@lfdr.de>; Fri, 25 Jul 2025 22:55:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 33B64238C23;
	Fri, 25 Jul 2025 22:56:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="G9eu7VeY"
X-Original-To: netdev@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.16])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 836E52376F8;
	Fri, 25 Jul 2025 22:56:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=198.175.65.16
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753484175; cv=fail; b=Z6utY4M/NnQKuLRexfbcQuyG+2plDCUASF5IyicxmwODBqAA6ykKQ8GzngyB8y1kVFGNDaY4adLlak6dNZDRBXTPTapg1mfNLqzmCEbZkgY4qj2FsMR9Z1C3nm5yxaACbZbF8SO2j/MMpn8dqU5fHSy304XGUHrEpF8qV0PVtfU=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753484175; c=relaxed/simple;
	bh=MUcMNj0DQalTd5Gi5CM08l5kNJA6wX2P0OreOILEBhI=;
	h=From:Date:To:CC:Message-ID:In-Reply-To:References:Subject:
	 Content-Type:MIME-Version; b=jYHZJM2yyFQRVcJ+Uke9bAbA+XO8dRYKhPDAsM5HuEwwojLDUB9dyVlono0/aaYZzaGocw4MfeSiZ1Juw4erJr7JTlmll/SSLXB6aMtFl2ZvDHtBP3Ptfiiy+74uuMuzmQMz4N6CXFVKYbtuOoH84qR73EmLtZ4Rqo1LavR0hMc=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=G9eu7VeY; arc=fail smtp.client-ip=198.175.65.16
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1753484173; x=1785020173;
  h=from:date:to:cc:message-id:in-reply-to:references:
   subject:content-transfer-encoding:mime-version;
  bh=MUcMNj0DQalTd5Gi5CM08l5kNJA6wX2P0OreOILEBhI=;
  b=G9eu7VeYFn9IzV7wUHGZrD2zQbghP9no/mOk0C6XALEXfVvRWux/WEU0
   lCTlvwUlAjlbSolwqhWCp5cGnoBYhPTFbBA6qXwOszjtmxGs5h7gADDZH
   NwaNoa++u8zlfPqE5gpdxryHl3nEzRo/tKckZ01S8icTGPONiywK1Un53
   a5cCR9BpafSXXHohO+Lwwacf8cdk+lvCbvSni/Hj2Vz7VY5wxjUAoZobV
   xbwS7uxMOE5eBMz+st1+r48S/p0YtfW+k1EsMkYlbY54CjcKNH1trgFhR
   TyAHgqdzVidR5JHsSAQYm65csUcaxh7/k7INwbS9bDNCNOjPL2wwO5IjQ
   A==;
X-CSE-ConnectionGUID: cya19mJ+RZKA/8DA0O5wgw==
X-CSE-MsgGUID: ffa+++jIT++7ACn8F1JZJA==
X-IronPort-AV: E=McAfee;i="6800,10657,11503"; a="55973686"
X-IronPort-AV: E=Sophos;i="6.16,339,1744095600"; 
   d="scan'208";a="55973686"
Received: from orviesa007.jf.intel.com ([10.64.159.147])
  by orvoesa108.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 25 Jul 2025 15:56:13 -0700
X-CSE-ConnectionGUID: HmkZ7W+BQWyBLAqwiAtuRg==
X-CSE-MsgGUID: 3Sm9BuJxSdWQtSu9Vsi6xw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.16,339,1744095600"; 
   d="scan'208";a="161402297"
Received: from orsmsx903.amr.corp.intel.com ([10.22.229.25])
  by orviesa007.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 25 Jul 2025 15:56:13 -0700
Received: from ORSMSX901.amr.corp.intel.com (10.22.229.23) by
 ORSMSX903.amr.corp.intel.com (10.22.229.25) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1748.26; Fri, 25 Jul 2025 15:56:12 -0700
Received: from ORSEDG901.ED.cps.intel.com (10.7.248.11) by
 ORSMSX901.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1748.26 via Frontend Transport; Fri, 25 Jul 2025 15:56:12 -0700
Received: from NAM04-DM6-obe.outbound.protection.outlook.com (40.107.102.46)
 by edgegateway.intel.com (134.134.137.111) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1748.26; Fri, 25 Jul 2025 15:56:11 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=dzQINRMyHmu8bzmmPl0+g5EJGGIyKueOXZdx1ahW9aAWwWDq/iI5CNvfloXrjZUV9c7LlUZOcH0o0ps4zw5u5muVge6xvd2SWZFgi76y/rlDS8HXvA3q2gqW6d1jVOyYTRpPkhS2riCsiZ6WkjD6Jt1xmdtnLTGwQrC10dEFmRf1sRRsBgfqqPr0UlTaMBC8ttZj1qdlhm9PgDSJW3zvJKcWY8BUjknSCdTHFq/EBRTHVlcHg+LRbZuQyNjIVddVbyJMNHTKnSC608ChE+LUFWT8aT+haUVwo14mn8bcY8o8f3H8DFIGMdVomqowgrT0jRSKEaoj4mbqbkvNivf3Aw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=B0pz6G+bQxgu82d8Sa6UPSus0T1qI0fq76ehvrm4+Kk=;
 b=jWd1/fE92QUFcDMhdmLxIxDRX/lPCuTjp/d45RrFtMRWwKA8td/4GeRmduLhDrJgIuCbYMEdSUW8/voZD1rGR/kbTkzGVRREH3kAGz7QI8MXCBdrFcJ5mEJkzg2OxewNms7OOm6IwS6TE5RQsE3+qHlBlL1KyjLo23Tm48HrqYo+Bgo+egSpJOEH75z3JuHq7DJLQXiypMf0GTcHO8zLtVK8/tJDuifID5cVwhD0QF/6EGw1mvhla8XHwtuhO3R5thABjsi+++BBRMgoRB/siBtdvFElMkz7E4f5f9z3NoP9DaFb3QpJ5caXfxsZO/FUjzAPx1N6rQWxInuE2oLcbg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from PH8PR11MB8107.namprd11.prod.outlook.com (2603:10b6:510:256::6)
 by SJ0PR11MB5816.namprd11.prod.outlook.com (2603:10b6:a03:427::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8964.23; Fri, 25 Jul
 2025 22:55:43 +0000
Received: from PH8PR11MB8107.namprd11.prod.outlook.com
 ([fe80::6b05:74cf:a304:ecd8]) by PH8PR11MB8107.namprd11.prod.outlook.com
 ([fe80::6b05:74cf:a304:ecd8%6]) with mapi id 15.20.8964.019; Fri, 25 Jul 2025
 22:55:42 +0000
From: <dan.j.williams@intel.com>
Date: Fri, 25 Jul 2025 15:55:41 -0700
To: <alejandro.lucero-palau@amd.com>, <linux-cxl@vger.kernel.org>,
	<netdev@vger.kernel.org>, <dan.j.williams@intel.com>, <edward.cree@amd.com>,
	<davem@davemloft.net>, <kuba@kernel.org>, <pabeni@redhat.com>,
	<edumazet@google.com>, <dave.jiang@intel.com>
CC: Alejandro Lucero <alucerop@amd.com>
Message-ID: <68840b6dbac3_134cc710045@dwillia2-xfh.jf.intel.com.notmuch>
In-Reply-To: <20250624141355.269056-5-alejandro.lucero-palau@amd.com>
References: <20250624141355.269056-1-alejandro.lucero-palau@amd.com>
 <20250624141355.269056-5-alejandro.lucero-palau@amd.com>
Subject: Re: [PATCH v17 04/22] cxl: allow Type2 drivers to map cxl component
 regs
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: SJ0PR03CA0343.namprd03.prod.outlook.com
 (2603:10b6:a03:39c::18) To PH8PR11MB8107.namprd11.prod.outlook.com
 (2603:10b6:510:256::6)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH8PR11MB8107:EE_|SJ0PR11MB5816:EE_
X-MS-Office365-Filtering-Correlation-Id: 7beae65c-4549-4431-4317-08ddcbce621a
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|376014|1800799024|921020;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?K1lUd2lkMlFqTHk1RUs4UzZReVJNM3BrVkJWT1R4RVhGZGlCRzdXN05xUlpu?=
 =?utf-8?B?SmI5bjBYOHhZNnZpa0VuTmJqQys0bnMrVkMyeC93bEI0eTl1K0NEWmQrdmRw?=
 =?utf-8?B?Rmk1WkJUWDJhbHFjL2ZXMDFOTjZUT0RFcXgxZk9jbER3eVd1b2ZGUHdnbHkz?=
 =?utf-8?B?M1NQaVhnTTZIRUNGdFh2cG5kdS9MQytTMzRrTWVxemhMb1dHTFJ2Z3BZNUhL?=
 =?utf-8?B?eUpLTEYxdzBUMmY5b2hGeVExR0RYQyt4YkxldGh1bm5KNHhZQnc1clR5cW13?=
 =?utf-8?B?Z2MxYzd1TEFvbDJvWTUxUWE2Zk5aQWNJQ3p6SmxUVE9uUVRYQlc5Z0FaRjR1?=
 =?utf-8?B?RDgycXdySWRhQkF6TzdLTGRhN3ozVW1GNWZHYzJKMU1WNUlhWGV5T1lHcnUx?=
 =?utf-8?B?L29ySHM4Ris5alJxV1dvR09MdkRtZG94U2pGZjQ5MERjTVkybzFlUEVML25K?=
 =?utf-8?B?aXlvRWdOckZRSGNaa3NvQ2xOUGZIZWZlTVVWQm1CK0NaYzRqU3FUMXMxVWx1?=
 =?utf-8?B?ZFN4YVRNak15L01CQ1hMSSsrNDlWdmJURlpUZHBBYmRaNGxHODZhdnRqeW42?=
 =?utf-8?B?Y2FRaEYwUlpteVBQSjFIcGErMjhIdDI5cXRuMHFKWVdiOUYyc2grbGJHM01z?=
 =?utf-8?B?NHhVdWNMcXM0ek5uT0gvV3daL2xwdmpNTWJWSHB3dDRoQmhRcE8xNk5SbnB0?=
 =?utf-8?B?QWtwV2xFSGZSSm4xRFkwZVRGbTFnOUdNT3djOXdxd1F0ZmVVZC9ZWXRPdWVW?=
 =?utf-8?B?U0F3cCtJNUZYM3BzZHJTTGVhdFhDZzNPd3lNRXBiSmpBbExSYUhKQ0tPamJR?=
 =?utf-8?B?VjN4aUYvMm9MM2RmbDRIOTN0TXVQa3pjY0FveVAvU29tZi8zVzdtK0NQTHU3?=
 =?utf-8?B?UDdwQ3BsQnNTbVBkTDgwSDYxZzBZbXdDbjVxREJ2amwrV2JuVEM5TG9LUG5P?=
 =?utf-8?B?b3RybjN2UUVjTng5bG9QV0l1cXFKbXE5U3o0Ymo0NUhXVHJJNmNIWUZTamZF?=
 =?utf-8?B?RDJ3RWRwMlNwNTgxQmtRbHhabU9HMDArRytwd3ZzQ1NhWExPQzFrRXNkdjR2?=
 =?utf-8?B?SDVoSkxIek56YytNVmxqREphWm5qYzZpUUpaUTFiQ0NDSHYrSlRPY09uNUFZ?=
 =?utf-8?B?Ykl0Z0ZqSTRNOEdxOFZWSXZsZnplNyszMzdXOEhYdWJKUkkrYXdleEJhRkhi?=
 =?utf-8?B?NlNyQTRoYStVMDIzMzFzOUNvOEE3M1g5OExDZGJOVUV3VERDbzhVNEJaRGdx?=
 =?utf-8?B?c1J1U05FSUwrbGRrV2NOZFJnWW5qejNmOVlOVVo0OCt3bGRIanlaQzBLOGw3?=
 =?utf-8?B?MlhsdSt6MXBqdXBwQmxSTjkyZG1iSDlvM2dDSEJxcCtaeXlDWDRUK2pmQ2pj?=
 =?utf-8?B?dkl5emRpUS9XU0FiZk9CVEM4aUlmMjZPMEZPdmh4UFEzNXVybkhKMVIzYXBI?=
 =?utf-8?B?U3YxR3RCOUgrTW1GTFdUdEhacDNidjk5VUZkQlNOdnZwN2s5V0ZzOFQ5N1Vk?=
 =?utf-8?B?eDNOa0diQlNpenpQT2NDc1h0bDFKT2tjUVpjZVBRWGlXaGh2SWxyUy9pSXl2?=
 =?utf-8?B?ZjdhN2tyZFJVeld1cnNXUVY4VGN1d2xMWWFLQUFzZ0ttZ1ludThPazUrNjh0?=
 =?utf-8?B?SGgwb1Jmd0lyY3V3b1ZFLyt5Sk9xUFNSNE43QWRDNnRBNmczMktPRXhWeVBi?=
 =?utf-8?B?ejBvdkdDcnJ4aDVCMXY4ZGpXT2hDZVc5eG5CWElnTllHV3pIK3hySHlvYVVv?=
 =?utf-8?B?dUEwQUNabU9mUWVmUlFtcWJ3c3N5aEtHeWYxNm5ZUWtNbGF6eEhUbVBMRUxT?=
 =?utf-8?B?TlZRQ2FjTzZJRmloSVFOVVoyYS9hdk5reG11dFdOTzVva294UjhCbHBDWFpj?=
 =?utf-8?B?MVpFR3ZqQlZ5em1LTnNnQktydzRpS2VUNnZ0czBuZGNTSkJSL1lxekhrTUJm?=
 =?utf-8?B?blptbDAzNHprZlhuRDAzNmVDMWZ5a1ZNS2czRllLY2dJcCtNVUxnQkRpN2Nl?=
 =?utf-8?B?b2hHdWxBZHBnPT0=?=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH8PR11MB8107.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(376014)(1800799024)(921020);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?dldpdnR5ZUNYNmo3Y24yY1REenFHQmxlMVl6ektWZ29WWEIrOEdQenhNWnB4?=
 =?utf-8?B?VHFvajJsREhLWU9xUHRUd204S2FkY2JhR3JTSHJYcWdlbHpNVmdrQmszY1Rt?=
 =?utf-8?B?aEtrMU9rU09kUVdCbjRaS0JrbVpFZW9nTWF0NHdhNHVOMmJQdGMrcXJ0czVx?=
 =?utf-8?B?eHo1U2ZaQUsrcU1hV3d4U3lhcmQ3eSs2SExzT2tuMGdZbG1MWEFYN2lzVVBk?=
 =?utf-8?B?SDA0K2xnSnU0UjZXYy9kVmsybFZ6K1AyKzBja1gramtESlJpOGtSN3pWSTc0?=
 =?utf-8?B?c0dHaHJUYXRMQlprMWJxTXlRMnBZdlZMZG5zTWNQUDZDVGQwTjlDUUZBYThT?=
 =?utf-8?B?TVg0UlNGSHgxNEFOM3F3c3IyblhyMUFQQVovSi9IWXZvYWlabkZlaE44VWEr?=
 =?utf-8?B?R3JZOUNPbWFNTDZIelhEUlQ3a0F0L2c3L0p3OWZTNm82Mm8rSzliSVFzd1pi?=
 =?utf-8?B?bVFxSVV6V2UzeUpEN0J3QWJCc21UL0RuSjRQd3BGcHVzL0hrQUlDYWJtUXdW?=
 =?utf-8?B?TkVoL3FreExwRFFmR0U5dURUZEVQY0REVVhvdDBqSkxoenliWVowUkVxM2RX?=
 =?utf-8?B?NkkwcmswMS80VW5mOCtlR3VFU2I1YnI5eFJiTTVPTHBsdEUrUFhQbDRjQTdk?=
 =?utf-8?B?d3hXSTJjbXNpSHNCV1ZUWnVaUVVxZFF2RjhzaXJsTWRqaTc1bXFHOHp0akpG?=
 =?utf-8?B?TW1UV3lRVDJETHRCQmpyNlVzdEJoakJoeERuOUEwbGIyYjVIT0QvZTNIZ1Ey?=
 =?utf-8?B?N2gvSDFLM3NkZDJ6aTFSNUFpYkptMEs0T2NSL3VKd0FPWEJqd3RtcUp0MFhP?=
 =?utf-8?B?OGhweVhVbGFLQVRwU0Q1Rm5CT2ZKa0lGeEt1dDBSM0kxckZoaXg3ZGduSGZ1?=
 =?utf-8?B?WTZMd2cwcnA0Z25UR2dRWVBUSS9RZC9RZmpxYjhvUGdjaUN4WnVxcW95Uyto?=
 =?utf-8?B?eFg1Y2dWbEJVS1l1eC9IcmZ1cjAxYUkvYy9Va3FUYnpwZ2N2L2FHRkVvVlNp?=
 =?utf-8?B?aVZVamYwTU5PejJWRVZEZ2s2eGhNcVBmV2VPSkdzWHU3TWlYdlVVd2V5R2FR?=
 =?utf-8?B?VjVWZWxBQ0sxNEFtL0l6djFQZEhEcFNaL1dyODNTRTJIbWV4WGVobmdFRW5H?=
 =?utf-8?B?ZzdianczUVQxckVUZzZGU2owNDBvUHVTZEhoNmwveDF0M2dSYjJUS0dpMWt0?=
 =?utf-8?B?MFZSektVd2thZHMwSyt6bFZ0ck1QNkk2eHd5SU1nejU1b2xoNCtjeWU2dmlx?=
 =?utf-8?B?bjRTa2hVa05GRWlNRjhWYll1MW5rR2NzeTl2T2ZxUnozMXNuUnpsVVhLbGx4?=
 =?utf-8?B?Zm5aWHFYZjB4ZTA5cVhseC9CVS8yTjBUQytIYVVHYkdkNzFick0xMkZQS1lP?=
 =?utf-8?B?Y3kwajd6UVc0TXVjUXJYSWtLbkJTVUsxYVA0eXdYMkl2d21lN2hZVmw2Z1hO?=
 =?utf-8?B?V2dodWhjSUt0cHo5cEJGM2lRVGNKY2NkN0JvVGQ4UWZkSWU3NG53eCtmYm9n?=
 =?utf-8?B?dW1zOXZ3NjZGTHRLM0hMZVFteVNCRkkrNVJOZDd0ai80eGNhVjlrZ1hxN3JD?=
 =?utf-8?B?di9LNUxYWC8wOXQybjEvWGRrcHZ2azg3ZG1zL09jVHhyWEtRVEszRDQ4TXlT?=
 =?utf-8?B?TldEMWhUOEVtUWJQZnhQSG9TMlJGRzJzbkNCa2lIYisrQ3JINXZVU2ZtQjVT?=
 =?utf-8?B?ZmhLVVlBMWE4QmhvZDVzRjlSVjd5VnJtNHdFa2dIUWZQQ0dkMkx3N3VOR3cv?=
 =?utf-8?B?TGJXdnIzcElqb05XRytTSzRzV1pFSDM0TGVBbjJ0V3U5QzVWRXRXM0txWnhT?=
 =?utf-8?B?QUU3SEVYN0ZuNTBKSzJPTGQ2akJkUmlNQko4RGtYcEdVUllpUUNMR0dyM1V2?=
 =?utf-8?B?UkNIajQ0Y2hKZXpPVTdXSHh1STNJMFBWUG15bTAzaCs1b3dsUW5MdVRGY0kx?=
 =?utf-8?B?eVcrK1N5TitabFJiZFNzazVuM2pMblJyVVUwdW1neXdhYW9QZ2FRNVRhS2Fk?=
 =?utf-8?B?ZHVpK21uOE1KWjBPUXlyTGlxSnl6dFpKYWlOWFplaGdEcnl3MWdEMm9nZVdR?=
 =?utf-8?B?cGxTM1dnVlFTZ09SVHY3NTlwV21yTEV4QUNncEVPNnV3ZkdDcFV0bTFBR2p1?=
 =?utf-8?B?NE5FWkk2akMrNTVKTDg0SEswS3Z4TWJYeitzN0IxTDZsRVVlbXVlcDd6aFVH?=
 =?utf-8?B?MGc9PQ==?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 7beae65c-4549-4431-4317-08ddcbce621a
X-MS-Exchange-CrossTenant-AuthSource: PH8PR11MB8107.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 25 Jul 2025 22:55:42.8259
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: USF6OuY95FnROKYOssR8Sq4d2QxbM7PhpLzl3R4K2wMn3sNkPSuE+iLs3fnNOca42MOFGeCVzvyClk/okZ69OM/69UzQ3cYSZjWnAHR6cEc=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ0PR11MB5816
X-OriginatorOrg: intel.com

alejandro.lucero-palau@ wrote:
> From: Alejandro Lucero <alucerop@amd.com>
> 
> Export cxl core functions for a Type2 driver being able to discover and
> map the device component registers.

I would squash this with patch5, up to Dave.

> Signed-off-by: Alejandro Lucero <alucerop@amd.com>
> ---
>  drivers/cxl/core/port.c |  1 +
>  drivers/cxl/cxl.h       |  7 -------
>  drivers/cxl/cxlpci.h    | 12 ------------
>  include/cxl/cxl.h       |  8 ++++++++
>  include/cxl/pci.h       | 15 +++++++++++++++
>  5 files changed, 24 insertions(+), 19 deletions(-)
> 
[..]
> diff --git a/include/cxl/cxl.h b/include/cxl/cxl.h
> index 9c1a82c8af3d..0810c18d7aef 100644
> --- a/include/cxl/cxl.h
> +++ b/include/cxl/cxl.h
> @@ -70,6 +70,10 @@ struct cxl_regs {
>  	);
>  };
>  
> +#define   CXL_CM_CAP_CAP_ID_RAS 0x2
> +#define   CXL_CM_CAP_CAP_ID_HDM 0x5
> +#define   CXL_CM_CAP_CAP_HDM_VERSION 1
> +
>  struct cxl_reg_map {
>  	bool valid;
>  	int id;
> @@ -223,4 +227,8 @@ struct cxl_dev_state *_devm_cxl_dev_state_create(struct device *dev,
>  		(drv_struct *)_devm_cxl_dev_state_create(parent, type, serial, dvsec,	\
>  						      sizeof(drv_struct), mbox);	\
>  	})
> +
> +int cxl_map_component_regs(const struct cxl_register_map *map,
> +			   struct cxl_component_regs *regs,
> +			   unsigned long map_mask);

With this function now becoming public it really wants some kdoc, and a
rename to add devm_ so that readers are not suprised by hidden devres
behavior behind this API.

It was ok previously because it was private to drivers/cxl/ where
everything is devres managed.

