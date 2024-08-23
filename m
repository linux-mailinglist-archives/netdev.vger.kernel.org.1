Return-Path: <netdev+bounces-121531-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E614E95D899
	for <lists+netdev@lfdr.de>; Fri, 23 Aug 2024 23:41:44 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 08DA51C21370
	for <lists+netdev@lfdr.de>; Fri, 23 Aug 2024 21:41:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 187171C8225;
	Fri, 23 Aug 2024 21:41:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="bI1pqtJN"
X-Original-To: netdev@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1756C14A4C8;
	Fri, 23 Aug 2024 21:41:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=192.198.163.17
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724449301; cv=fail; b=RxWIRkup5dsU6Bx3glDsGgCsB1hCObhH+FquE78kGXg5vzKuT74edRNjJr5iMUxU0kQQrg0qhifa19gbVt8Jy+eYQtqMp+3AgLHnmqUlD5Fm8PmvTdpjSzGMtncbNQ4FJSjQROkS+3+xkDOUmGs915NybDCboGFAC8vSb6Ze/7A=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724449301; c=relaxed/simple;
	bh=QnderjiwJP8/sLkIFyVT09hHOE2c5nrUYqVxVxxnJcg=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=IRE6rPcID1oSk5RUep9YaXrf3m5pTDPDIgzHmZbFGOezb35HX2SloM5r+Nlg9aUH+zb2Xv4+dF8GOIQXjLLzWQbFvqY7N8sFx220OJcrFLliNs7sEk7+3bGm3ldGW6j4hQlUISxtN0uu5WlevyR+eaOHbhb30d6hVpNYOzbxzc0=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=bI1pqtJN; arc=fail smtp.client-ip=192.198.163.17
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1724449299; x=1755985299;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=QnderjiwJP8/sLkIFyVT09hHOE2c5nrUYqVxVxxnJcg=;
  b=bI1pqtJNnkauedM/mHzdVLZqDNOdxqCTYz9vAnbhaTh3XhtifUXGt0bF
   unbe8EClsbSGOANg+Tr2txgbxWU+NXkK4IT6br6KVF4hTPkZHTeqCoYzL
   ROQSzumDik+oSqA6bdYfPPnG8Y5J8o/xmlzV+iY+hPZMNZoB7dRGzHEb3
   Z80h/HKNwgEzxGuBercEF5B0/6yW7SqBF26BqYC6ZOIgkYzf27uPMzPd9
   1ZrHLNmHMEVe8J/V15MQZ2SfLlSuBXW667s0K+lZaNx3MXNOKdIuzbSo3
   PELO/Bd27yU4lGXn6PCAa11IYs5jn7eRb7Sd+mReM+UXK2bk/CqULEgAq
   w==;
X-CSE-ConnectionGUID: 4b7kspj4SkKbfQnLB+tHeA==
X-CSE-MsgGUID: 40yn3HV6TgKeIOpsCfVcSQ==
X-IronPort-AV: E=McAfee;i="6700,10204,11173"; a="22830929"
X-IronPort-AV: E=Sophos;i="6.10,171,1719903600"; 
   d="scan'208";a="22830929"
Received: from fmviesa008.fm.intel.com ([10.60.135.148])
  by fmvoesa111.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 23 Aug 2024 14:39:52 -0700
X-CSE-ConnectionGUID: bvBRCB+dRuaX3Ek8hAiFVA==
X-CSE-MsgGUID: v6TZ4xnvTpaSpSBwWMTy7w==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.10,171,1719903600"; 
   d="scan'208";a="61920093"
Received: from fmsmsx603.amr.corp.intel.com ([10.18.126.83])
  by fmviesa008.fm.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 23 Aug 2024 14:39:51 -0700
Received: from fmsmsx612.amr.corp.intel.com (10.18.126.92) by
 fmsmsx603.amr.corp.intel.com (10.18.126.83) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39; Fri, 23 Aug 2024 14:39:51 -0700
Received: from fmsmsx610.amr.corp.intel.com (10.18.126.90) by
 fmsmsx612.amr.corp.intel.com (10.18.126.92) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39; Fri, 23 Aug 2024 14:39:50 -0700
Received: from FMSEDG603.ED.cps.intel.com (10.1.192.133) by
 fmsmsx610.amr.corp.intel.com (10.18.126.90) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39 via Frontend Transport; Fri, 23 Aug 2024 14:39:50 -0700
Received: from NAM12-MW2-obe.outbound.protection.outlook.com (104.47.66.48) by
 edgegateway.intel.com (192.55.55.68) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.39; Fri, 23 Aug 2024 14:39:50 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Zcg/Va/uSp4tMmn3aauo2RwdMwnKOAozrN3TNjFCNxwFxc9QRNX7OPrDgfU4MUQE3L8X4LWkPfZzGUMsULGiTqS1xO+MHbJTkhUsa6beVPfwnRt/iGeskdIgbMNvih557JLYQq6ZOKjw88ubCmXXyACQdCeEyskgrNrNQKBuRRYchdrudIKnvqeCTkQl81UR6Fqc6Icnt9pOpvM/h3V6rINKBiD7dH30KDUhrAcrV+qqAw+Ux7QRfg0hsEi23yZu0aQn8XHxBtwbpmd+ko18arGTSehSc5qTE4K93Iq8JDcVYXe2rLqeMbfVLxkO+xE4eg6o/U3MciTucrn/8v+3UA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=QnderjiwJP8/sLkIFyVT09hHOE2c5nrUYqVxVxxnJcg=;
 b=TqCLtOapQUPcR2u7X1BE0WVcw9ag0Z/5tQTXvK4MdjQgSx/wLErY/MY1GEDbGxa8YfHaKMcA0KiKU09QfM1wCiXg6ZZpFViQ503nl8I+CW/4jR3dYanGLlK08cBJnD3KjW12twtEB58kUp2nDUNfiZ7+NhhDMDSC6UoaMFbLc2rVMuuTTsi2uLbWtNR+u6405FYfWlH6UYisazMtFFwMKNsK1RPRT8vNxgmYOTY1bqexSkn7BvcHyyDPbVtt/g7EEYov/ukIIvECuQHXtwNtv5EdMMgbYupPTFW965EkeR/gTUdC3Z++YYg26drEv6q2NBIo4QQ+YfTaxBcWrOYs/g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from DM6PR11MB4657.namprd11.prod.outlook.com (2603:10b6:5:2a6::7) by
 PH7PR11MB6499.namprd11.prod.outlook.com (2603:10b6:510:1f0::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7897.19; Fri, 23 Aug
 2024 21:39:48 +0000
Received: from DM6PR11MB4657.namprd11.prod.outlook.com
 ([fe80::1d5f:5927:4b71:853a]) by DM6PR11MB4657.namprd11.prod.outlook.com
 ([fe80::1d5f:5927:4b71:853a%4]) with mapi id 15.20.7897.014; Fri, 23 Aug 2024
 21:39:48 +0000
From: "Kubalewski, Arkadiusz" <arkadiusz.kubalewski@intel.com>
To: Donald Hunter <donald.hunter@gmail.com>
CC: "netdev@vger.kernel.org" <netdev@vger.kernel.org>, "kuba@kernel.org"
	<kuba@kernel.org>, "davem@davemloft.net" <davem@davemloft.net>,
	"edumazet@google.com" <edumazet@google.com>, "pabeni@redhat.com"
	<pabeni@redhat.com>, "jiri@resnulli.us" <jiri@resnulli.us>, "Keller, Jacob E"
	<jacob.e.keller@intel.com>, "liuhangbin@gmail.com" <liuhangbin@gmail.com>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: RE: [RFC PATCH net] tools/net/ynl: fix cli.py --subscribe feature
Thread-Topic: [RFC PATCH net] tools/net/ynl: fix cli.py --subscribe feature
Thread-Index: AQHa9TkQuCaSryVCCUmbqP20abVdm7I0p2KdgACRUgCAACIAgIAAAzvA
Date: Fri, 23 Aug 2024 21:39:48 +0000
Message-ID: <DM6PR11MB4657642B8DDA56A8EE5CE24D9B882@DM6PR11MB4657.namprd11.prod.outlook.com>
References: <20240823084220.258965-1-arkadiusz.kubalewski@intel.com>
 <m2le0n5xpn.fsf@gmail.com>
 <DM6PR11MB46578FDE21C9E875A7F3C1BE9B882@DM6PR11MB4657.namprd11.prod.outlook.com>
 <CAD4GDZza0TWkzmwW_qP8GFXzr7DOGVfg-xsiXOVUyRqe47Rung@mail.gmail.com>
In-Reply-To: <CAD4GDZza0TWkzmwW_qP8GFXzr7DOGVfg-xsiXOVUyRqe47Rung@mail.gmail.com>
Accept-Language: pl-PL, en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: DM6PR11MB4657:EE_|PH7PR11MB6499:EE_
x-ms-office365-filtering-correlation-id: d77c4a52-c027-41e6-f548-08dcc3bc1cbe
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230040|366016|376014|1800799024|38070700018;
x-microsoft-antispam-message-info: =?utf-8?B?V3ZFQlpMT2Y2VnMyN3l0QisxOXprYmlKVkJSTDVuWHFHTGQrZmFtWWNWS294?=
 =?utf-8?B?dHR6SUtZSGplWjFubHovQUVYUUE3VGwvWHRaS3plS05EMHk5V3lxcjZJUVkv?=
 =?utf-8?B?SGJZSVVlMGFoaGRNNS8xV1liNHREYUU0bVo2SlB6K1ZRREZMYk5kck42cjYy?=
 =?utf-8?B?MGtITHFxRWwxcFViYUphOTZVYkU0SmJaaXdjelBPTktxQXNsU2s5ZW9tOEdI?=
 =?utf-8?B?Y2UrWjE4NjlzNDVDNTN5SWx6dkRpcGlkVXZaSDFEVXZDdEhPMU9vYjFMMWFU?=
 =?utf-8?B?WVJOYW9lWndGTkw4aFU0SFAvZWIzbjI4Wnp3T3Z2M3NLbU9LR3FON3dKQ1Yx?=
 =?utf-8?B?Wit6dEovMnRhTktQMVFKMlF4Nmc0dUlUdVNpM0ZaeEo3eHg0TUM4aW96dVZq?=
 =?utf-8?B?ZEF4bGtsV0NKMVVqNCs5RDJZVHQrNit3UzIvbnd5N1hOTlE1R3ozNFl6Y3hL?=
 =?utf-8?B?djRFSVNUNDVpWjFIVXE1OWIzZVFZR3ZlT2g4NXVXVnRpMEYvM2xHZWxyOVRM?=
 =?utf-8?B?VStCdGwraUVJR0Qya3h2bEIvWjU5Uy9iSFk5UFM5RXNJZS9pWkIyNVBwTW9F?=
 =?utf-8?B?bCt6ZjQ3dkVMTnJORE1WNHgxajJ4R0lSYkZDWXRpSGd4SDhFOTlpVzNkYmdx?=
 =?utf-8?B?ZHE4OTlOM1J2azdBV29uZ25idU9VSUFFTWN2WnhUZ2RIQUxES3MxcHpIWjcv?=
 =?utf-8?B?TmE4dU9HYWd1bzNiZTBkMDZwbzdQem1kOUFraTdJSlJpRG52WWp3ckpzakhp?=
 =?utf-8?B?YytybzExdU1tRFFvakFrNDFnR0g4ZllKNHdwYkZCNk5mMFlOMmVjazNodXZy?=
 =?utf-8?B?SzNnOGR1VVRLZmRkTFoxZnNFcVJTL2orbG4yc3lsUEUxUjhhOHc2Z3dGRDBM?=
 =?utf-8?B?ZGdCL050TUpkZTRScXFJc3YybXBwc3RRbWpmODBRZGV4bjBxZkJzQzlqQXRx?=
 =?utf-8?B?Y0V3SWFEdW5pb3ZkSWVzRENlaWE0QkcyUUVLWWVRZkZqTTUyanMyOVRMZUFE?=
 =?utf-8?B?QUt2SC9sWkxxcVhPUW5heG95SkZ0Yk9DRGxBZ1pQWEtxNEwxZkRZb2N6UGNJ?=
 =?utf-8?B?SFcvSytxU3JLWTRaVVNwT2R3R3hmbEtzbjlQcWhlM3o3Zy9aTFFrUDUzMVN5?=
 =?utf-8?B?cXJMbnJERFpCTUl4cEQ5U1BiWDNWQjZaNlRPTWEwcUNmUklEdmVvOUZMRE9R?=
 =?utf-8?B?aWx0TTFBUW5qNU5DN3Z6MXFidERjMnNVcmc5b1ZyaDdlMjFPWXU2VWcvTUNC?=
 =?utf-8?B?MldBTzM1a2xxdk9HNWVWbGQ3NEFLajIrQ1luTWpBYmo2ZHZUZXpOZEZLazdI?=
 =?utf-8?B?dG1jaGlPQUtUQXV1UGFDcDJXWFlzQUdaTXRNMkhOZ1dBZ2wza0Yrc1FDd0Er?=
 =?utf-8?B?YzJVU29EQWpaOU45WnY5ZldLSGNqZDhJbWlpTnFFbDFyOXlaZHlEWjhYVGNK?=
 =?utf-8?B?R254dnI3Rk5uV0duUXNuVW8zUm1VYnpoQ21LUHI2T0t2UW1BRmQreHFpeXVz?=
 =?utf-8?B?TlZaMndEZ256YmZXQy92bUo3Y2tCam5Ya1NHc0F6d0V6SnZPRFI2MStkQlZX?=
 =?utf-8?B?L3RyUEpyY0JMdDZUcUdLV0JpbU1nWUxIRCtkN2tHeFQ1RE9UK0RNaWxEbS96?=
 =?utf-8?B?c3JWMEZ5QzFzVTQyLzBsY1dQcWZscjNPTS95Q2xvUHAvT2N3L1ByYVltUHd3?=
 =?utf-8?B?ODBMaUlrcXZqK0M0WDU1dUFvUXd2b2VtbXZzNmhEOFM3N2hpVk5RaTM2TU1Z?=
 =?utf-8?B?Rk45aDVzTFllZFRKcU14QnlkbEpjZGo2emNzY0hSaEdTaDc1N2RrMi9YN0wr?=
 =?utf-8?B?OVRJNEpQWkhBcFRLdEVtbktpdHFsYkNHUXZqRURJUzFTOW1PRG1CYVdiK0Zr?=
 =?utf-8?B?SU16ZHA0N0FJSmlVek96L1FCOTI2RjJTRVU4dHBKb0VLeHc9PQ==?=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM6PR11MB4657.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(376014)(1800799024)(38070700018);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?Q3BaT2VVWUFNQkNiUlY1TUhOcTBibUd5Y1IxUEVValVwRDRxSmhubnRHQ05n?=
 =?utf-8?B?THhEbnMwMmFRckhDTWpPQXYyVXlIZlJEU0xxZlUyUHU3V05FYk5ROGhocUNO?=
 =?utf-8?B?ZFNnNjdyR2g5bnE3SzU5aE1CWUJYdDQrSVN1Y1JVcWdVMkpYcWVQbWp2OS9B?=
 =?utf-8?B?UHhmc0VKRWdUSkVLWHpEVW5RenRNSXcwa2Z1b2ViSGdEaVdhQVRjRlB3M3VZ?=
 =?utf-8?B?UWNLOGJ6QVREQTRnTWV3SjhmTFJNS3ErV0kzNkVGWGU0NGVkUHQ1Zy9aanBI?=
 =?utf-8?B?VW5GZGdRYVlHVTRia0RKYjBzNEZvaUE2c3NOaTdVTTRIeFB6dEJnWXNSbGdm?=
 =?utf-8?B?NEFnT0U0UUFGeWpQMHJVa3V4VmRvM2FSVDNGdUpob2JlWHlSM3owVUxFcEsr?=
 =?utf-8?B?MVc0RVpYL2dwb21UY2NpUjdQczdLN004VkRrY2RWUTdlamh3MGpZamxJRGo1?=
 =?utf-8?B?Q0VFODRiblVPK0t2RTdGOFQ5Qm93QTRmbTRjS0c4WnhLVTBjL3E4NkYrVHFw?=
 =?utf-8?B?RjZGUUF0aXlaTENXSCtlejdvVmI4WG5vcWVaV1lTL1NsSzRKYmt4N3FyN0dI?=
 =?utf-8?B?MUIybFV1YTZlbVF3V2JBSysydGdWaHNkTC93ZXZIemYxK1BTWTlYWjRoTERC?=
 =?utf-8?B?aXVhTEZnS3BVUTZxOFVVcGVoYjg4cCtUNWxWOWFndXl2UzJ5OTFXWlRhL0Zs?=
 =?utf-8?B?SDIxRDd0ZHZSeDgveGZrTnpBdVZWUFlRckRBbkZKMlBHcjdUbE9lM3dsU1ds?=
 =?utf-8?B?dy83ejVidmxoakVFMjBqNG16NzltUXhOOE9kZFpYTE5sYnB2OVlybHNDdlNl?=
 =?utf-8?B?dy84MGlwaXRrN0dLVVVxRExvVmhBNXhlQkk4WVBkVy9qUnB1WDZrM3dFQ25C?=
 =?utf-8?B?MHZhZTlyRmNSL25DMlV3QTJEdmJRek5EbFd3enJ0THM0NEtuNkV3ckdrZjVB?=
 =?utf-8?B?cy9ITHlmTTZHRWJvVXA5OVFjaEptRlJybGd3dHRPMkFqQ2xBYlNFK0JjQXg0?=
 =?utf-8?B?RGRGVzh2STgwOTFMdThRN0JQallyUkZDMUlwdjRIdTc0R1R1WUF4SzRvazZa?=
 =?utf-8?B?OERDMm9jcjl2ZWx2YW5ZMGxIeU1oSkhCbytoSm1DTGNKMVEwaXFkSzA1YlI4?=
 =?utf-8?B?Q3g1YVZrV2RnNkJFQmVwcFhyUzNQYjRUbG5wcVRjdDNyTnBmRUtiOGc2aTZC?=
 =?utf-8?B?bUY5TWZkVlNqUDQvM29uRnNNc0JHcERFeE5CbTg2Vzh0OFRIUWdXTksxM1lF?=
 =?utf-8?B?Z2RNdEpsTHdIVDRFMzRsRkYwVk1uYnRlanJKS2xZek91UVVUQWQ2eVk1cjMy?=
 =?utf-8?B?Q2wxc3ZDc0V5b3ZCTVZsd3MyY0pIQUZLclgzWUk1c043THoyTGhkR01PcExH?=
 =?utf-8?B?aGpqSDJoaytNZW1mc1F3dkp6SDRrdjN4TGdJK0dXRDdiZU96dnhqR2orU0FN?=
 =?utf-8?B?SlUzV1Q4MFprYUFSZkRmVldBQ1cwTkM1ckplNVBoaXV4Y1JiYXJmUmlhSGRo?=
 =?utf-8?B?bW1EZVNUSS9IZU9rZXRIcnM2VnF6UnNxc2piNDhkVWtXOWFEb01Dc3RkeFBW?=
 =?utf-8?B?cDNTRHdjWEVVc1lUSWg3eGhYV0VEaWhKODlkRW5CNjFweXA3NWV5SktBdFdn?=
 =?utf-8?B?ZmhPbnhGVzFGUm1sRXFmdG9ZaW4vb2pDaHZXQ0N6YW80ek44cWZiWG1XRk9r?=
 =?utf-8?B?QmRKNCtSODViSVkxRWpuZU5JNG5QaHRaVWlpNzJpQ2ZmeVdRMlVtVFpNZGVU?=
 =?utf-8?B?YjQ1VlkxTlFjWlJJVWY0R0VkNXdEZUcxcE0yRlF6TEZMZW9xQ04vTHFDejZH?=
 =?utf-8?B?emNMTXJhWGs5eDZiMFF2ZVE5enZmMU93MGxLTWhpeDk4QkZ6TkM5bkdETXVQ?=
 =?utf-8?B?YnZVa2tMVjQycDNaU3RIdE9YcUcwcFgzeWxTSVkvK2gxQnphR29rQ3lUMlh3?=
 =?utf-8?B?Y040ZzRjSE9wWWJZUnBrWWJjekhDdjltaUFlNkdUWXJPbG83UTlHeW9lWXRP?=
 =?utf-8?B?ZGVzWWpHSm9YVWdzNUZpYjBRYXU1YmYyMnZobHJvOEh3b3UyWVVRNGxtbGUr?=
 =?utf-8?B?SVR0cjlmT0ZJZ3I0VWtIOXNkWTNhU05pSjUrZHlZUGRTcUUzK3FwTW1TNGhj?=
 =?utf-8?B?M2M2eHNjL1JmMlRDeUxoZnk5bTdZTjB1NGZJZDFleFc0WGcrYThObzNodUR6?=
 =?utf-8?B?RlE9PQ==?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: DM6PR11MB4657.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: d77c4a52-c027-41e6-f548-08dcc3bc1cbe
X-MS-Exchange-CrossTenant-originalarrivaltime: 23 Aug 2024 21:39:48.3215
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 7tMYc9i7syD3cd12fr9WNX/vR9kZi6jNsgwKxZNpLemZ+DK6DNAA/QplUE1N9zBURc4UKXTFRgygI6X+VQ5I1OP17XJz7xQujLRELKP59dc=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR11MB6499
X-OriginatorOrg: intel.com

PkZyb206IERvbmFsZCBIdW50ZXIgPGRvbmFsZC5odW50ZXJAZ21haWwuY29tPg0KPlNlbnQ6IEZy
aWRheSwgQXVndXN0IDIzLCAyMDI0IDExOjIzIFBNDQo+DQo+T24gRnJpLCAyMyBBdWcgMjAyNCBh
dCAyMDozMSwgS3ViYWxld3NraSwgQXJrYWRpdXN6DQo+PGFya2FkaXVzei5rdWJhbGV3c2tpQGlu
dGVsLmNvbT4gd3JvdGU6DQo+Pg0KPj4gPlRoZSBwcm9ibGVtIGlzIHRoYXQgd2UgYXJlIHRyeWlu
ZyB0byBsb29rIHVwIHRoZSBvcCBiZWZvcmUgY2FsbGluZw0KPj4gPm5scHJvdG8uZGVjb2RlKC4u
LikgYnV0IGl0IHdhbnRzIHRvIGtub3cgdGhlIG9wIHRvIGNoZWNrIGlmIGl0IGhhcyBhDQo+PiA+
Zml4ZWQgaGVhZGVyLg0KPj4gPg0KPj4gPkkgdGhpbmsgdGhlIGZpeCB3b3VsZCBiZSB0byBjaGFu
Z2UgTmV0bGlua1Byb3RvY29sLmRlY29kZSgpIHRvIHBlcmZvcm0NCj4+ID50aGUgb3AgbG9va3Vw
LCBpZiBuZWNlc3NhcnksIGFmdGVyIGl0IGhhcyBjYWxsZWQgc2VsZi5fZGVjb2RlKCkgdG8NCj4+
ID51bnBhY2sgdGhlIEdlbmxNc2cuDQo+PiA+DQo+PiA+SG93IGFib3V0IGNoYW5naW5nIE5ldGxp
bmtQcm90b2NvbC5kZWNvZGUoKSB0byBiZToNCj4+ID4NCj4+ID5kZWYgZGVjb2RlKHNlbGYsIHlu
bCwgbmxfbXNnLCBvcCwgb3BzX2J5X3ZhbHVlKToNCj4+ID4gICAgbXNnID0gc2VsZi5fZGVjb2Rl
KG5sX21zZykNCj4+ID4gICAgaWYgb3AgaXMgTm9uZToNCj4+ID4gICAgICAgIG9wID0gb3BzX2J5
X3ZhbHVlW21zZy5jbWQoKV0NCj4+ID4gICAgLi4uDQo+PiA+DQo+PiA+VGhlIG1haW4gbG9vcCBj
YW4gY2FsbCBpdCBsaWtlIHRoaXM6DQo+PiA+DQo+PiA+bmxwcm90by5kZWNvZGUoc2VsZiwgbmxf
bXNnLCBvcCwgc2VsZi5yc3BfYnlfdmFsdWUpDQo+PiA+DQo+PiA+YW5kIGNoZWNrX250ZigpIGNh
biBjYWxsIGl0IGxpa2UgdGhpczoNCj4+ID4NCj4+ID5ubHByb3RvLmRlY29kZShzZWxmLCBubF9t
c2csIE5vbmUsIHNlbGYucnNwX2J5X3ZhbHVlKQ0KPj4gPg0KPj4NCj4+IFllcywgYWdhaW4sIHRo
aXMgc2VlbXMgbXVjaCBiZXR0ZXIsIEkgd2lsbCBwcmVwYXJlIG5ldyBwYXRjaCBhbmQgc2VuZA0K
Pj4gdGhlIG5vbi1SRkMgdmVyc2lvbiBzb29uLg0KPj4NCj4+IFRoYW5rcyBmb3IgeW91ciBoZWxw
IQ0KPj4gQXJrYWRpdXN6DQo+DQo+SSB0cmllZCB0aGUgY2hhbmdlcyBsb2NhbGx5IHRvIGNoZWNr
IGl0IHdvdWxkIHdvcmsgYW5kIGVuZGVkIHVwIHdpdGgNCj50aGUgZm9sbG93aW5nIHBhdGNoLiBD
YW4geW91IHZlcmlmeSB0aGF0IGl0IGZpeGVzIHRoZSBpc3N1ZSB5b3UgaGFkPw0KPg0KPmRpZmYg
LS1naXQgYS90b29scy9uZXQveW5sL2xpYi95bmwucHkgYi90b29scy9uZXQveW5sL2xpYi95bmwu
cHkNCj5pbmRleCBkNDJjMWQ2MDU5NjkuLjMxMTU0MmE4YWEyNCAxMDA2NDQNCj4tLS0gYS90b29s
cy9uZXQveW5sL2xpYi95bmwucHkNCj4rKysgYi90b29scy9uZXQveW5sL2xpYi95bmwucHkNCj5A
QCAtMzg2LDggKzM4NiwxMCBAQCBjbGFzcyBOZXRsaW5rUHJvdG9jb2w6DQo+ICAgICBkZWYgX2Rl
Y29kZShzZWxmLCBubF9tc2cpOg0KPiAgICAgICAgIHJldHVybiBubF9tc2cNCj4NCj4tICAgIGRl
ZiBkZWNvZGUoc2VsZiwgeW5sLCBubF9tc2csIG9wKToNCj4rICAgIGRlZiBkZWNvZGUoc2VsZiwg
eW5sLCBubF9tc2csIG9wLCBvcHNfYnlfdmFsdWUpOg0KPiAgICAgICAgIG1zZyA9IHNlbGYuX2Rl
Y29kZShubF9tc2cpDQo+KyAgICAgICAgaWYgb3AgaXMgTm9uZToNCj4rICAgICAgICAgICAgb3Ag
PSBvcHNfYnlfdmFsdWVbbXNnLmNtZCgpXQ0KPiAgICAgICAgIGZpeGVkX2hlYWRlcl9zaXplID0g
eW5sLl9zdHJ1Y3Rfc2l6ZShvcC5maXhlZF9oZWFkZXIpDQo+ICAgICAgICAgbXNnLnJhd19hdHRy
cyA9IE5sQXR0cnMobXNnLnJhdywgZml4ZWRfaGVhZGVyX3NpemUpDQo+ICAgICAgICAgcmV0dXJu
IG1zZw0KPkBAIC05MjEsOCArOTIzLDcgQEAgY2xhc3MgWW5sRmFtaWx5KFNwZWNGYW1pbHkpOg0K
PiAgICAgICAgICAgICAgICAgICAgIHByaW50KCJOZXRsaW5rIGRvbmUgd2hpbGUgY2hlY2tpbmcg
Zm9yIG50ZiE/IikNCj4gICAgICAgICAgICAgICAgICAgICBjb250aW51ZQ0KPg0KPi0gICAgICAg
ICAgICAgICAgb3AgPSBzZWxmLnJzcF9ieV92YWx1ZVtubF9tc2cuY21kKCldDQo+LSAgICAgICAg
ICAgICAgICBkZWNvZGVkID0gc2VsZi5ubHByb3RvLmRlY29kZShzZWxmLCBubF9tc2csIG9wKQ0K
PisgICAgICAgICAgICAgICAgZGVjb2RlZCA9IHNlbGYubmxwcm90by5kZWNvZGUoc2VsZiwgbmxf
bXNnLCBOb25lLA0KPnNlbGYucnNwX2J5X3ZhbHVlKQ0KPiAgICAgICAgICAgICAgICAgaWYgZGVj
b2RlZC5jbWQoKSBub3QgaW4gc2VsZi5hc3luY19tc2dfaWRzOg0KPiAgICAgICAgICAgICAgICAg
ICAgIHByaW50KCJVbmV4cGVjdGVkIG1zZyBpZCBkb25lIHdoaWxlIGNoZWNraW5nIGZvcg0KPm50
ZiIsIGRlY29kZWQpDQo+ICAgICAgICAgICAgICAgICAgICAgY29udGludWUNCj5AQCAtOTgwLDcg
Kzk4MSw3IEBAIGNsYXNzIFlubEZhbWlseShTcGVjRmFtaWx5KToNCj4gICAgICAgICAgICAgICAg
ICAgICBpZiBubF9tc2cuZXh0YWNrOg0KPiAgICAgICAgICAgICAgICAgICAgICAgICBzZWxmLl9k
ZWNvZGVfZXh0YWNrKHJlcV9tc2csIG9wLCBubF9tc2cuZXh0YWNrKQ0KPiAgICAgICAgICAgICAg
ICAgZWxzZToNCj4tICAgICAgICAgICAgICAgICAgICBvcCA9IHNlbGYucnNwX2J5X3ZhbHVlW25s
X21zZy5jbWQoKV0NCj4rICAgICAgICAgICAgICAgICAgICBvcCA9IE5vbmUNCj4gICAgICAgICAg
ICAgICAgICAgICByZXFfZmxhZ3MgPSBbXQ0KPg0KPiAgICAgICAgICAgICAgICAgaWYgbmxfbXNn
LmVycm9yOg0KPkBAIC0xMDA0LDcgKzEwMDUsNyBAQCBjbGFzcyBZbmxGYW1pbHkoU3BlY0ZhbWls
eSk6DQo+ICAgICAgICAgICAgICAgICAgICAgZG9uZSA9IGxlbihyZXFzX2J5X3NlcSkgPT0gMA0K
PiAgICAgICAgICAgICAgICAgICAgIGJyZWFrDQo+DQo+LSAgICAgICAgICAgICAgICBkZWNvZGVk
ID0gc2VsZi5ubHByb3RvLmRlY29kZShzZWxmLCBubF9tc2csIG9wKQ0KPisgICAgICAgICAgICAg
ICAgZGVjb2RlZCA9IHNlbGYubmxwcm90by5kZWNvZGUoc2VsZiwgbmxfbXNnLCBvcCwNCj5zZWxm
LnJzcF9ieV92YWx1ZSkNCj4NCj4gICAgICAgICAgICAgICAgICMgQ2hlY2sgaWYgdGhpcyBpcyBh
IHJlcGx5IHRvIG91ciByZXF1ZXN0DQo+ICAgICAgICAgICAgICAgICBpZiBubF9tc2cubmxfc2Vx
IG5vdCBpbiByZXFzX2J5X3NlcSBvciBkZWNvZGVkLmNtZCgpDQo+IT0gb3AucnNwX3ZhbHVlOg0K
DQpJIGNhbiBjb25maXJtIHRoZSBub3RpZmljYXRpb24gd29ya3Mgd2l0aCBhYm92ZSBjaGFuZ2Vz
LCBidXQgdGhlcmUgaXMgdGhpcmQNCmNhbGwgdG8gZGVjb2RlIHdoaWNoIHdvdWxkIGFsc28gbmVl
ZCBhbiB1cGRhdGU/DQpJdCBzaG93cyB1cCBvbiB0ZXN0aW5nIG1lc3NhZ2VzIHdoaWNoIHJldHVy
biBleHRhY2sgZXJyb3JzLg0KQmV3YXJlIGxpbmUgbnVtYmVycywgdGhlc2UgY2FuIGRpZmZlciBv
biBteSB5bmwucHkgYXMgaGFkIGl0IG1vZGlmaWVkIHNsaWdodGx5Lg0KDQogIEZpbGUgIi9yb290
L2FyZWsvbGludXgtZHBsbC90b29scy9uZXQveW5sL2xpYi95bmwucHkiLCBsaW5lIDEwNDAsIGlu
IGRvDQogICAgcmV0dXJuIHNlbGYuX29wKG1ldGhvZCwgdmFscywgZmxhZ3MpDQogIEZpbGUgIi9y
b290L2FyZWsvbGludXgtZHBsbC90b29scy9uZXQveW5sL2xpYi95bmwucHkiLCBsaW5lIDEwMzQs
IGluIF9vcA0KICAgIHJldCA9IHNlbGYuX29wcyhvcHMpDQogIEZpbGUgIi9yb290L2FyZWsvbGlu
dXgtZHBsbC90b29scy9uZXQveW5sL2xpYi95bmwucHkiLCBsaW5lIDk4MiwgaW4gX29wcw0KICAg
IHNlbGYuX2RlY29kZV9leHRhY2socmVxX21zZywgb3AsIG5sX21zZy5leHRhY2spDQogIEZpbGUg
Ii9yb290L2FyZWsvbGludXgtZHBsbC90b29scy9uZXQveW5sL2xpYi95bmwucHkiLCBsaW5lIDgw
MSwgaW4gX2RlY29kZV9leHRhY2sNCiAgICBtc2cgPSBzZWxmLm5scHJvdG8uZGVjb2RlKHNlbGYs
IE5sTXNnKHJlcXVlc3QsIDAsIG9wLmF0dHJfc2V0KSwgb3ApDQpUeXBlRXJyb3I6IGRlY29kZSgp
IG1pc3NpbmcgMSByZXF1aXJlZCBwb3NpdGlvbmFsIGFyZ3VtZW50OiAnb3BzX2J5X3ZhbHVlJw0K
ZXJyb3I6IDENCg0KVGhhbmsgeW91IQ0KQXJrYWRpdXN6DQo=

