Return-Path: <netdev+bounces-192415-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 096FFABFCD3
	for <lists+netdev@lfdr.de>; Wed, 21 May 2025 20:28:20 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 4F68D3AF069
	for <lists+netdev@lfdr.de>; Wed, 21 May 2025 18:27:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4670827CB0D;
	Wed, 21 May 2025 18:28:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="kJafdLGo"
X-Original-To: netdev@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.15])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 560301A5B86;
	Wed, 21 May 2025 18:28:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=198.175.65.15
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747852095; cv=fail; b=QqpK/4cPltUwn/k4LTfExBJCl0sX5Hp7FMHe1OVlj6ul51nDfAHIVjmtM8tQOyKvFwha75R6c2caK0c43r3FqSVXwfu9A+t+3MKzdpBXjgnU4QVe2ilgfF5z9kT+JV+H/dRPYhHfCi9iHSlr3xkCIX1rzlrolEmKkYzP9rFM2L0=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747852095; c=relaxed/simple;
	bh=ie05B1c0lO1QkWAU0WJqw+CXSAJlBsAInArFCvlDe8c=;
	h=Date:From:To:CC:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=BmoRqk1ggOnFbJhMXU0uyrFeVUB0XnJdT0Zk8Sgfs7qYwe/5ELHsCfKCk9efjKmAE0OBgD15loVkUBbNG2iVd1/2MEOHNbAsd3JZJb7SZz/mnxzQfBEl3oCsEsVss9mvQn8UhcUPnAy5LNV55A9IpzbbUU6Fj5+VcbRzgZB0IZA=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=kJafdLGo; arc=fail smtp.client-ip=198.175.65.15
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1747852094; x=1779388094;
  h=date:from:to:cc:subject:message-id:references:
   in-reply-to:mime-version;
  bh=ie05B1c0lO1QkWAU0WJqw+CXSAJlBsAInArFCvlDe8c=;
  b=kJafdLGo8U7ik997hdZybmnu4iK7qtNLMBPqUinWd8CGKQGuFKodNgy6
   LdYdldl4GB2HKYb7CbqGKKoAsceHU1Xkce4xreTQ4LYsuZR32iUOelbH1
   QK7i39iGx8Htkeekb+FIfkYC/lPag57g8TjzapAQj5G5++x6frwmKcH9r
   XnVEseEJiXn2wyGt9CxuQCGxr5b60hr9+s4hBd2OqGfe3/pwa4BbdBL+m
   hMQHPNBLw3iJK3Wkfe2jXJd3qAIftFXo4Brvye3P1p7nis6Uxny0Et+Xd
   z7LbZ1ubfrU0J4FIRAHR0SCaIAo4Y9w+OIIJOsj30t+GMIDF/d2gA1OhM
   w==;
X-CSE-ConnectionGUID: sPK/YxxpTQaURGxfJxz11g==
X-CSE-MsgGUID: VykGoUd0TK2F3FcG0G7b5w==
X-IronPort-AV: E=McAfee;i="6700,10204,11440"; a="53516398"
X-IronPort-AV: E=Sophos;i="6.15,304,1739865600"; 
   d="scan'208";a="53516398"
Received: from fmviesa001.fm.intel.com ([10.60.135.141])
  by orvoesa107.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 21 May 2025 11:28:13 -0700
X-CSE-ConnectionGUID: 6blLg5ojQq6YMUvkzM/EwQ==
X-CSE-MsgGUID: pxIUc85pT3qDKTcPDzl3yA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.15,304,1739865600"; 
   d="scan'208";a="171196685"
Received: from orsmsx902.amr.corp.intel.com ([10.22.229.24])
  by fmviesa001.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 21 May 2025 11:28:12 -0700
Received: from ORSMSX903.amr.corp.intel.com (10.22.229.25) by
 ORSMSX902.amr.corp.intel.com (10.22.229.24) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.25; Wed, 21 May 2025 11:28:11 -0700
Received: from ORSEDG601.ED.cps.intel.com (10.7.248.6) by
 ORSMSX903.amr.corp.intel.com (10.22.229.25) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.25 via Frontend Transport; Wed, 21 May 2025 11:28:11 -0700
Received: from NAM04-BN8-obe.outbound.protection.outlook.com (104.47.74.48) by
 edgegateway.intel.com (134.134.137.102) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.55; Wed, 21 May 2025 11:28:11 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=rl2oWBhO5XpmSEcWZStb774EfTpm5RnE9cjdfjmz1fzFtrg3nptnc/A2zGbtv9SmRByN081R6oL25u43awFnzAVClCZIwcucTZ5ei0RSDXr9bnYO2d+f5D60+6qSHEdjHRtssCETIMLfb58Kg/F1gvAjT6ovcGlJ23KVIgDQdxZqiYD6HCjAr+uCzhq4abpmtb5n7Vr0JdzUV1tT3h74I8NROua8ZMgzATSDO74nG17CoM+TQV+35iAEzg/1DwaLcbL5JUaC3kHUM+uQ3oTkCSA90m3HIwGTc5rUHye83cOE9VDwNCCpMgNNzDEypTOquJfxicP1bIyTUE9dfUii9w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=G99wGVR9yyxg3ak8Ly+2m2+vGcVOR/1i6702+rJMbaA=;
 b=aTRlHnMEX9i358ihbvbqqYnF6ZCCmNA+hb0rf4EZpYu777jQjPh2paYAYCJJmi11pD0DOivb7tKL6rPJn/qA8PAh4tuWHwHp/7ktqwufW368Zc7grocinIEK+aP2ebEZxoDeBy4gF7+JbqjYq1FOrdhFxRFmETudykWvQqUJBDZcYueoruN+HX3jerc+kd76YE3R8NGb9Z15iaa39f+NUgkJTaxYQYiG8K4L6nfcLonQr4ILgQlBeRfsO7Eze/m6X4KhCcPqbvIgQyo/VkUoAVevwO7JAzCjf4Bg5QT6XnH6bUK5UX5yOYbvMMzVAu5gIoI+AtF+nN4cotkLQpOCrg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from PH8PR11MB8107.namprd11.prod.outlook.com (2603:10b6:510:256::6)
 by SA3PR11MB7553.namprd11.prod.outlook.com (2603:10b6:806:316::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8769.19; Wed, 21 May
 2025 18:28:08 +0000
Received: from PH8PR11MB8107.namprd11.prod.outlook.com
 ([fe80::6b05:74cf:a304:ecd8]) by PH8PR11MB8107.namprd11.prod.outlook.com
 ([fe80::6b05:74cf:a304:ecd8%4]) with mapi id 15.20.8746.030; Wed, 21 May 2025
 18:28:08 +0000
Date: Wed, 21 May 2025 11:28:06 -0700
From: Dan Williams <dan.j.williams@intel.com>
To: <alejandro.lucero-palau@amd.com>, <linux-cxl@vger.kernel.org>,
	<netdev@vger.kernel.org>, <dan.j.williams@intel.com>, <edward.cree@amd.com>,
	<davem@davemloft.net>, <kuba@kernel.org>, <pabeni@redhat.com>,
	<edumazet@google.com>, <dave.jiang@intel.com>
CC: Alejandro Lucero <alucerop@amd.com>, Ben Cheatham
	<benjamin.cheatham@amd.com>, Jonathan Cameron <Jonathan.Cameron@huawei.com>
Subject: Re: [PATCH v16 05/22] cxl: Add function for type2 cxl regs setup
Message-ID: <682e1b368fc8_1626e100c3@dwillia2-xfh.jf.intel.com.notmuch>
References: <20250514132743.523469-1-alejandro.lucero-palau@amd.com>
 <20250514132743.523469-6-alejandro.lucero-palau@amd.com>
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <20250514132743.523469-6-alejandro.lucero-palau@amd.com>
X-ClientProxiedBy: BY1P220CA0016.NAMP220.PROD.OUTLOOK.COM
 (2603:10b6:a03:5c3::13) To PH8PR11MB8107.namprd11.prod.outlook.com
 (2603:10b6:510:256::6)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH8PR11MB8107:EE_|SA3PR11MB7553:EE_
X-MS-Office365-Filtering-Correlation-Id: 96e8dae0-b60c-4dd4-a50c-08dd98953c0f
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|7416014|376014|1800799024|921020;
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?luqjKza61NYlMxkQvuzI7nOC3EYeiu1vVGXi0IM260pz96e0vyHUH27+Lstr?=
 =?us-ascii?Q?tD20RebgrWGfxT8T0marZJwj1Cwm//daFv4wbFldqOmf9nxQq9kNh1tTe+Cp?=
 =?us-ascii?Q?OFFLgGsBNVUV5+xATLCCVYTII7Yy5k3YuLcC9UB6/CvN9HSJaHdzKfgcD1tj?=
 =?us-ascii?Q?1yyyi+AxeJEScE7OEeo/LgD/V8etBDHZnRL3l+VSumaQUh9SYY5GPvZ3NyPQ?=
 =?us-ascii?Q?a3oi1yKRgEXr+5JR8Ff8czMjLIbnhd0OQojLAE7eV5a5C9unQBYgXOY5DyHu?=
 =?us-ascii?Q?ma3mkcOYVObeoFKeZaMCZwwOO4Cnt4Jbrqv7m6wZaUmoCLbsRWm4YiAOC2Y6?=
 =?us-ascii?Q?oXVtLNpnkVMqsZxk+tPuqyF6zgbkH63/2mQV4Xp1jj6LcQ/OqVqArMJAflgH?=
 =?us-ascii?Q?pygyNtT1Tl0ArQHoWfFXCq5jrZwPWi9BR4XSDeYBr6Tba1AxOuMtMDV1vXxa?=
 =?us-ascii?Q?2EmhUc1AdKXPA1z5hFtLz7XjP3m9W1lxDkbbKaJeYCwoaF3LLJg68C7T+scQ?=
 =?us-ascii?Q?MtrmZHLHgJZwy8SOc01072FYtKlxqRqbYg6fqRAlsdItXAatKSlAXDfw7osn?=
 =?us-ascii?Q?Qk0fFUT/9ng2PB5GwmeMrhfRB83FcGUI5cKBUMQyY9I2DS/evK3sXVnSo48e?=
 =?us-ascii?Q?IQSyE3+g0Pr+DOnltIhvLbDjTrn8ibC09LSbTIWaTBuosOTjQpSmwUQJS5D9?=
 =?us-ascii?Q?xkjMqqTwMzoyV8nYJxd3KHqG1BnMsAYuTYtVPR7bOVgy0jzrmf/Qs+nDO40V?=
 =?us-ascii?Q?181QJilxPQsgYei+oldb+1ssZNryPrJQibRxKJRNpxypOJ9zDfhAnFw7K64L?=
 =?us-ascii?Q?QlBTGvWDraQ5ViIkuhT7nMecJUT8lQU+Qtq6kxtYpfPXLryBNIZRZZG/zLE3?=
 =?us-ascii?Q?rU96Unw4124aYUSNiH/9kEgjYoQcCHJVI/GzJnTeUSo3/fHLjHrisbrfzwlb?=
 =?us-ascii?Q?KSm2JFajQndnwaY/gGu4FtriiJUB2MRvL3n7dXtu6vorqzWt2x0R1jx+WBaB?=
 =?us-ascii?Q?fVh4iK0OxEgURVBbPmJQf5iGQnwgHSzw0JYH7UMcfVnXeUhC0VCvi9DqLHJJ?=
 =?us-ascii?Q?iOb10u0fgRiPj8wwnaOHpEbEawowcBXa8Avi4CvuMKjDoHkFXO3VOMpxWvUb?=
 =?us-ascii?Q?FWtlvKkL6M2GdcM7pv9phDJuCGkWR8I/QM2+HfeUR6KLFzO/0U7JlSNEOjYv?=
 =?us-ascii?Q?AYRvo+5ZfJDWqrJs4JDiNONzArjxr4E9/EYB9KjNXKSDd94dkf8cZQEHCh76?=
 =?us-ascii?Q?ob6hSbkczPoDLjSFqZo+H+rnO5SxPhCwmKJssqPfiFi+otUDBoYIMCd4y3g/?=
 =?us-ascii?Q?nlSAsXfeF5cUnzjZO68u3Yta9Va/10OYFxNAoNqwjjYhtuvG4LfLptngNxkS?=
 =?us-ascii?Q?7MQuDOmXIudcFeNgshrTFskg2AXBGSXzYDShWBhd6pd60QjIGk8yAWp3K80f?=
 =?us-ascii?Q?A8lpCoCLC53q6euvfKtkTdXPDhSVul5YcrkN0aog0TQOGWo6csibAQ=3D=3D?=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH8PR11MB8107.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(7416014)(376014)(1800799024)(921020);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?ndbR5iVguaDzRTGifqLvjQasOZJr30I13eC+4+A0myu8CxKNayJ7p1guPr0O?=
 =?us-ascii?Q?g1UKZ4rOK4Uo8GnEQH9tdWtzPAdV5+9grSa0N82pgsVRe+XIWuvy9OOxCbuV?=
 =?us-ascii?Q?aCepp8Huu7inOcoY9P/UAdzGhCHDXmfsL3/pDR6jv3OK+VmzzEv28/izasV/?=
 =?us-ascii?Q?K12nAyT1Xq8jGllYPUTxKyBYA7OlbYFy1chIBb8qwKdqM8ThADTxS5m2E6RP?=
 =?us-ascii?Q?dfuUsQ9tiyR7GjR3DTUWlsZzLocSWdoFm3ebmZX2PgJh0mPovj7gLH34QaqY?=
 =?us-ascii?Q?wV2C2LHDXvHY4HO79VJLKEtrDB37QWlYvXbVNhpS8ulSK8qyXy4qzrYfVpo9?=
 =?us-ascii?Q?Yo77qtLzn5kPbE67dH+wU1PNkgtvnm3j4QKyxA7bSbBf5jVREj1oW6VGTorb?=
 =?us-ascii?Q?wurbC7wR67ALPOSeCaJhCRsfLJfzLdFfMGJjWnYyGvuImdTCgStW6XH+/46u?=
 =?us-ascii?Q?Q8klq01qOLUdRKBozDDaK/+xW2B4+zLrXPT33Tz42KycEQeC8uOMBNb++Vly?=
 =?us-ascii?Q?t6zx5yRJxIPTM0Gn8q0CrEJ1YDlBcTyrftaEuZm9ZVJ8VTNg/LmV+R5FMTSI?=
 =?us-ascii?Q?sRfV+TvCnI/Psj34s58/x+/Zois6YvghtFFdcBR/tyR/ii6vMFth3mk2Te1w?=
 =?us-ascii?Q?8V3vTrS3BOGCQrxMnMB3yI6ey5tPEm7EvDVVdDthw5GRZ5NWkLhWa8MW+VsI?=
 =?us-ascii?Q?T0Jk6a50V5zulvnYyl6CRCCsrzmX2/ky7Jn92y7ianR2jzdR3cA01E25g9NU?=
 =?us-ascii?Q?EJvM7WtuYFUXe/BG3NAuBiHTwFUMTCzyDSRlx1TtqoNOYKKr7s8CIR3yPTRI?=
 =?us-ascii?Q?9XGUy9q5AEUoTsU8AFfQIoshqviU9H+6gihesn1A2hKqJu5WkQpXSCwdcKa3?=
 =?us-ascii?Q?g0cWDxDHbe17T7hXECyPcyBnSa0A4obh6xvH3POEFBctYiryR2/GcqGoJC+c?=
 =?us-ascii?Q?KZjexQk5UKZ1scgwTBflYY9EP+k8HyTCpLhHYUJjRMpJY9f6m2ps3W0fY/gQ?=
 =?us-ascii?Q?AjLztZweATvI29qY4iSUrdl3OS7aUhL7IWfttOhk2d/jjGlpX6Grwqjkq5//?=
 =?us-ascii?Q?336Ip+sjFW7RClV8zn/c7bsBmGz4F+Vv/DgJNBTgbMLJsKL/pW7OionJp9W2?=
 =?us-ascii?Q?KVI8oz1vy18bSsTRfqumU50JP2ODa6Pq+/pN8GKZeh8Gen86jVyz65n8IlUb?=
 =?us-ascii?Q?4UfFh8wzdwESqRw/fLisWzZ/dqSrqammx5harJxC/OzOh8QcRtrj3pP3OFye?=
 =?us-ascii?Q?MSL7h5/vpd60VjV0CNmhdkbKVnCib/HcfB6OjWPopToAd9tkooWfBSt1fKog?=
 =?us-ascii?Q?ahU1ba35TAg0gQZ4S2flYDLl30wzpJgZWHfSVZDOEPravvODY1KJhmx1PVku?=
 =?us-ascii?Q?7/e+4XsCnXkcrzi4VMQ8xgsW/R02Hy4Wf8Aigj/NJtykxafyayasOkoIodxI?=
 =?us-ascii?Q?UQtQMWYY2SebC509dFlaZPJ1j3YRVwi+8ffR5qcLSPanpgSGqmZLmZxa/Gm6?=
 =?us-ascii?Q?xDmsSJt2cJ9jcBs8CREHBQTuF9Uw0pVxoMaXpbPdsT1qiAyreYukQVcRM4Bd?=
 =?us-ascii?Q?coYNRjSP253G8W1RAUEhTGZtIHDTShc/dfE9bqWTXzlxizhNAml85/2LstwR?=
 =?us-ascii?Q?1g=3D=3D?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 96e8dae0-b60c-4dd4-a50c-08dd98953c0f
X-MS-Exchange-CrossTenant-AuthSource: PH8PR11MB8107.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 21 May 2025 18:28:08.4931
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: F9TXg9zU9G3lR76HQtOglWqer/zib6rTr2SrHWQTqWb1yQkI5ufB4GyL9S+vfjwkazchEND5rFqb6Dk7D727C+FAW3xNdSEFPn47scyG5Os=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA3PR11MB7553
X-OriginatorOrg: intel.com

alejandro.lucero-palau@ wrote:
> From: Alejandro Lucero <alucerop@amd.com>
> 
> Create a new function for a type2 device initialising
> cxl_dev_state struct regarding cxl regs setup and mapping.
> 
> Export the capabilities found for checking them against the
> expected ones by the driver.
> 
> Signed-off-by: Alejandro Lucero <alucerop@amd.com>
> Reviewed-by: Ben Cheatham <benjamin.cheatham@amd.com>
> Reviewed-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>
> ---
>  drivers/cxl/core/pci.c | 62 ++++++++++++++++++++++++++++++++++++++++++
>  include/cxl/cxl.h      |  3 ++
>  2 files changed, 65 insertions(+)
> 
> diff --git a/drivers/cxl/core/pci.c b/drivers/cxl/core/pci.c
> index e2b6420592de..b05c6e64bfe2 100644
> --- a/drivers/cxl/core/pci.c
> +++ b/drivers/cxl/core/pci.c
> @@ -1095,6 +1095,68 @@ int cxl_pci_setup_regs(struct pci_dev *pdev, enum cxl_regloc_type type,
>  }
>  EXPORT_SYMBOL_NS_GPL(cxl_pci_setup_regs, "CXL");
>  
> +static int cxl_pci_accel_setup_memdev_regs(struct pci_dev *pdev,
> +					   struct cxl_dev_state *cxlds,
> +					   unsigned long *caps)
> +{
> +	struct cxl_register_map map;
> +	int rc;
> +
> +	rc = cxl_pci_setup_regs(pdev, CXL_REGLOC_RBI_MEMDEV, &map, caps);
> +	/*
> +	 * This call can return -ENODEV if regs not found. This is not an error
> +	 * for Type2 since these regs are not mandatory. If they do exist then
> +	 * mapping them should not fail. If they should exist, it is with driver
> +	 * calling cxl_pci_check_caps() where the problem should be found.
> +	 */

The driver should know in advance if calling:

    cxl_pci_setup_regs(pdev, CXL_REGLOC_RBI_MEMDEV, &map);

...will fail. Put that logic where it belongs in the probe function of
the type-2 driver directly. This helper is not helping, it is just
obfuscating.

