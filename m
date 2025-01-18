Return-Path: <netdev+bounces-159516-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id DE2AEA15AEE
	for <lists+netdev@lfdr.de>; Sat, 18 Jan 2025 02:51:46 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 33FDA188C092
	for <lists+netdev@lfdr.de>; Sat, 18 Jan 2025 01:51:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D8C0819BBA;
	Sat, 18 Jan 2025 01:51:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="Lwms1ijf"
X-Original-To: netdev@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.20])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 95A961078F;
	Sat, 18 Jan 2025 01:51:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=198.175.65.20
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1737165101; cv=fail; b=jGegtN17Fj3upNGHLE6myCuztwGWIdyRG1VTgkkNxz0dnMPXYjBCpcmI4/YbpVaaBQW9V/y6oSHJYt0kQ/z2PxXH9PRPhze+ZkUmwJo1sY7e9jwym5Ee0yuxdgKEQcP8k6Jj65soXMNAY6Nq5XeZfOsOHCwEUdVlRNLmfZGU6bs=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1737165101; c=relaxed/simple;
	bh=3FA4mFNNYCmMwAyXuZgdqqEg994ppPHvO7R0FTJSMK0=;
	h=Date:From:To:CC:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=g2HoLCny4VGOm3oFnJJY+9uxs5nPElp9QF0YBTWTysMEz3rxHoJBhxYmAv3W+AQNWypyAXdTQvRynuzX8R/sQx+LqCUJhbg00nD1Ow2bba9QqHjcHExoH0dmAXUyfq8UIBa3URwA+mK7PO+IEaBA7FJsKz7BfGYubh4ZAGjSbxQ=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=Lwms1ijf; arc=fail smtp.client-ip=198.175.65.20
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1737165100; x=1768701100;
  h=date:from:to:cc:subject:message-id:references:
   in-reply-to:mime-version;
  bh=3FA4mFNNYCmMwAyXuZgdqqEg994ppPHvO7R0FTJSMK0=;
  b=Lwms1ijfUbDuAz5tP3Etg1dGATNpjtlIlN8nPjbFc5ZTGAj+x4P5YEwB
   r2bLNVDJlO62nvIbt9GdeSIfx/E577jXR1RMi+s8oQW0doc/medIK2g8V
   eYdybVvjQ/uoMSQ8T8QKR/appG6A0ZKEAGwKHvmAD8M1NhbFMoZAnln9i
   BUPycvGjbUhDYFebgkQfX6FmdSPAqFnPf7FjeDTqfypO9GBDfDb9/AC/T
   ftPTShS9f0CJ1RUNRdabIZy0DKeUuaTZcYenTYD0Dn7eM1dDOvnBtA0hA
   0ACqAXfqxVESok/rPfh67ixrKWFYxjW5mXTqEXQIGbmkBkT67vLzqDOhW
   Q==;
X-CSE-ConnectionGUID: e8zxUTxbTra97YEofKe2tA==
X-CSE-MsgGUID: y3tkpMRHTWiy8+OP4DPQXA==
X-IronPort-AV: E=McAfee;i="6700,10204,11318"; a="37307709"
X-IronPort-AV: E=Sophos;i="6.13,213,1732608000"; 
   d="scan'208";a="37307709"
Received: from orviesa006.jf.intel.com ([10.64.159.146])
  by orvoesa112.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 17 Jan 2025 17:51:39 -0800
X-CSE-ConnectionGUID: d0d5qkMaS96U3ZzxgPO5OA==
X-CSE-MsgGUID: 7YBmbpSUT7mAB+Kg/pHjdg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.13,213,1732608000"; 
   d="scan'208";a="106006723"
Received: from orsmsx601.amr.corp.intel.com ([10.22.229.14])
  by orviesa006.jf.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 17 Jan 2025 17:51:39 -0800
Received: from orsmsx603.amr.corp.intel.com (10.22.229.16) by
 ORSMSX601.amr.corp.intel.com (10.22.229.14) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.44; Fri, 17 Jan 2025 17:51:38 -0800
Received: from orsedg603.ED.cps.intel.com (10.7.248.4) by
 orsmsx603.amr.corp.intel.com (10.22.229.16) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.44 via Frontend Transport; Fri, 17 Jan 2025 17:51:38 -0800
Received: from NAM12-MW2-obe.outbound.protection.outlook.com (104.47.66.47) by
 edgegateway.intel.com (134.134.137.100) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.44; Fri, 17 Jan 2025 17:51:37 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=bpylziciYdHCHPEaJP8LoUbeKrsjFiUBejEjNQFbb99uRp+ynU/v0GMEOygtAgUsx7p6xnzF15IMvG85MqfkgDKLurzUpLY8TvK5AKf0rDo1fL4IRPFwOMjCTNF3OfMKe1woeQVJguE1firize34OCX6lx9jYx7ZXgg+WqIHTlzyQIn3yq81PFtHYKJN55YRp8rif5soPWtryFiA0fkJBpOKtW19EIhvpdx2lR50mMBoa89/0NAk+CIADSDssHwwJh47mKmpv4tuhPE3V8CfP6rdiXJzreCEWys/Yxv8SMfimUmBxJKQbEYTxkCm9Pd4HgrcoUR+LLQ3SVFh2btipA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=czsEKBrTErd8UVUGIE0nr7svUWzr/zmouHeNs285T/E=;
 b=TiANd3pi71SfVBAoD8dhrzx6cvKWHYGm0/zPlQ1PbvitYJl28U792qcms32DfTlpMs8rNMXBlKWetHaJjKcS9qZUdMrt6sqpobUsYN4PN60Yy7UMYbTnRzxkNq3VAKu/k31sg5BFweHrKNTXvbkxvEZtuYgRVecWHwmpuP5psTUS2Y/DK4Mw6Fe2LBjUs+YF3qpuB7n9ki9G1avgYQ2vXNqfpmzrm/9oq7NbgfnssyGFRgxZDZ8ilt1Ey5r1zs30vr5b3ADDR+NcRb7tZQL02l+yAILAEVNeTvZsSQrtwhxG5D7dxM+317cchftPiOzrUlUMec/mpKyGxAxD3tyi0A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from PH8PR11MB8107.namprd11.prod.outlook.com (2603:10b6:510:256::6)
 by IA1PR11MB8199.namprd11.prod.outlook.com (2603:10b6:208:455::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8356.14; Sat, 18 Jan
 2025 01:51:34 +0000
Received: from PH8PR11MB8107.namprd11.prod.outlook.com
 ([fe80::6b05:74cf:a304:ecd8]) by PH8PR11MB8107.namprd11.prod.outlook.com
 ([fe80::6b05:74cf:a304:ecd8%5]) with mapi id 15.20.8356.014; Sat, 18 Jan 2025
 01:51:34 +0000
Date: Fri, 17 Jan 2025 17:51:32 -0800
From: Dan Williams <dan.j.williams@intel.com>
To: <alejandro.lucero-palau@amd.com>, <linux-cxl@vger.kernel.org>,
	<netdev@vger.kernel.org>, <dan.j.williams@intel.com>, <edward.cree@amd.com>,
	<davem@davemloft.net>, <kuba@kernel.org>, <pabeni@redhat.com>,
	<edumazet@google.com>, <dave.jiang@intel.com>
CC: Alejandro Lucero <alucerop@amd.com>
Subject: Re: [PATCH v9 06/27] cxl: add function for type2 cxl regs setup
Message-ID: <678b092428a86_20fa29462@dwillia2-xfh.jf.intel.com.notmuch>
References: <20241230214445.27602-1-alejandro.lucero-palau@amd.com>
 <20241230214445.27602-7-alejandro.lucero-palau@amd.com>
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <20241230214445.27602-7-alejandro.lucero-palau@amd.com>
X-ClientProxiedBy: MW4PR03CA0170.namprd03.prod.outlook.com
 (2603:10b6:303:8d::25) To PH8PR11MB8107.namprd11.prod.outlook.com
 (2603:10b6:510:256::6)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH8PR11MB8107:EE_|IA1PR11MB8199:EE_
X-MS-Office365-Filtering-Correlation-Id: 3b529e73-a624-4840-9383-08dd3762a37a
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|376014|1800799024|921020;
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?FbYpTnkbAmTG4122M+JNOiJwLovTyNNb2p1B215F1avcEW+pcXtAODrAFTTf?=
 =?us-ascii?Q?iqss3VXRzDPz4z5/HMYh1eZIREFOhYfBEAGx6bcbqgo4n8445uXP8wcY7Mm3?=
 =?us-ascii?Q?h01aJCXgAv4zBer568QvssR14K2AFIEOprl3mDReuPs6R/DW+X2FY4b9WnB4?=
 =?us-ascii?Q?lniRVaZKWVkqj5tMgln9lq1CIulyuBDbu1EME8nfLpDqw0HIXWR8d8+LoWCD?=
 =?us-ascii?Q?boXaTEyNZcfssZDMOAVBB+xoCR6G+n8VP5ksP0jKbL3SH/GnFY7sASI4xAHW?=
 =?us-ascii?Q?6L40LdG9FYXz83F6SGk0i8YCk5mQkzxzzcQZBhuvUpEhG8JgATfHIzZZfG/u?=
 =?us-ascii?Q?EjxMPWm9jTOAXmohGU0BCGmKzYmeJOLleNLmCEH4raKgPFc1UB4CywjMLuop?=
 =?us-ascii?Q?j3VC3XZmh/gGbpRACPFBtVq9ROaFfe/iPTMNsIUqBZtUEL8W7YQO5Y+ViIJv?=
 =?us-ascii?Q?DC2wsxkNLGBvSnzdcU9B1kPS95sFt6B7MlRaIuaRO6WoZPBld0JqWVU3tJ4n?=
 =?us-ascii?Q?VxcHBm9Pur/PwIcydNddAJuyrEPyoJCP0WbOr7V/6nbOWgceSsiBejLo/5Fp?=
 =?us-ascii?Q?VdXksVLnh2B37CEL3tH+SsHAABKpTb61tQphoNIAWqCsDZRIyXfIHT5xOri9?=
 =?us-ascii?Q?uQ8W8hqCmzNW7hMqY/DyVDEBDLfjeSMdD/1mFasIVA3Okepa+O/ZePEDvL4Y?=
 =?us-ascii?Q?iScjI84K4OmwihdkEHfArJqfyvH85eWtgwG7xYZyY5FYtufGVeGlOoLkB/dk?=
 =?us-ascii?Q?MjRpvZsHLF5nAm02a/3ojh+44s0bERKAdo6mFU1dX5k650ZQNJXeAFoF3N/W?=
 =?us-ascii?Q?oqGsrjmPtrkT5SmWlcfCT4E1eRl7HgUHv9wcTlY6O/cENElcL1seqJFh9P1i?=
 =?us-ascii?Q?D1PMuOgLDcsV3E5Q33o+awnKViA5xpYcbcfxzV/SoCeM83fi4fv+jXFnQEeC?=
 =?us-ascii?Q?8KlcnfGKlu/VVTSKhDuQiOXRLRDymZq4OfcSo6MsSO0jgrD+mb5JxOizHCN4?=
 =?us-ascii?Q?RCqsw4351fXQ9o3gO7FR0MJNNrFC0pbVEm9WUne1DfDy8whLdFn6NvFPdCDm?=
 =?us-ascii?Q?OC/Km7Pm8Cy8QKHRIe0u91I80qaJ1vwSuIBXVPAXG47r5fwbVBqOXrdmQWoQ?=
 =?us-ascii?Q?daYLis+fvOzcE8nXcfan5XxtACgQ2asvcC5NMklAO8hChIAPjIOmtcFp0Axs?=
 =?us-ascii?Q?wSwHDrVboOMxb2pss0Ic9rHO70t2QrXKLEMdANKRJuBavWLE6FRQwaFz8w4v?=
 =?us-ascii?Q?cAlhBE7DDTm34100cCYaVwK3Gau8mFuie82+dlySHxf9L52oBZuUWDsg7x4M?=
 =?us-ascii?Q?QtdnL+WmW/K6UulcWPtgywkLbZKE+qbbmcFJaIjz50sZCVq7//oN999B+GiX?=
 =?us-ascii?Q?vUYXzhGBrSMVCUbaVf29WHtqw/TvLifElt19B++KRitbxGwC2hndU2NxPbsV?=
 =?us-ascii?Q?zAePdUNmJGY=3D?=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH8PR11MB8107.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(376014)(1800799024)(921020);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?PCPzamKyblQaxutyi5qz1eabofktMQ3K3L8I6g1OcQwoKTkFXiA0qjbAA/xO?=
 =?us-ascii?Q?p1GC6ZXUXUUSC90NkharjY1pkLJEgXZfzIiR2Ddh7wY1esZdHnVEZcDN4HCM?=
 =?us-ascii?Q?ukdo4VtKjeCUh71TmG40rBmBPhm1ETSsCFz4BizDggHUEFfxFJ4QUKkJbTfx?=
 =?us-ascii?Q?fmwLqXv6AhpqqoCH9A9837ipozIkoJrbgupWsbPn6Y/l6ZORpXK7PqMIoj40?=
 =?us-ascii?Q?NjxvNCo4uxqbzTsYKLC3HlpxcWXdSwK4KyKLiVGbGhWPFzEqw1o88PmU9O0N?=
 =?us-ascii?Q?7j93wqp5rZXQxihqujT8ggzrULap/20N5hAcYzW54v1CQvZ0t7J3pynVUgBH?=
 =?us-ascii?Q?Wt47KItnvKj2DceixL3Mm9GVzQgPc6Iw6ChgMcfcjW9T97DZdcKWSi/Bz6uP?=
 =?us-ascii?Q?A3ZoRX+7mfA0ibIF6p+UlKIvavXOLXGkMnd1eaJlD+9yvXQsNRNqKmGnyjmc?=
 =?us-ascii?Q?63S8OFDioV5V4sDPzoJ0vA4Su29EWzEus7h++bDwWL8htF+/yCYB7OGSULLh?=
 =?us-ascii?Q?HzSOC8dzy2h69bKMrVF2eohCCxKB645p9IC/m1Y4VX3qSruTdte6XpCT6iZN?=
 =?us-ascii?Q?XgURnMSZaL5D22foOwVFs1B8o/rFoCb7x9tkk3RYXwxPKxdDYmiJlogWXyik?=
 =?us-ascii?Q?+0k6nA0SEzgIQnxfrV5KEtpC/Tq5fAv9LMVyzRUwwZlPrqHPiQkagTrSO9zI?=
 =?us-ascii?Q?AdiElNh2E/5SJZLfdpdvIh4iJCNml/NxPVFLfK4l6sn1bx6AhYlsQmKzgDny?=
 =?us-ascii?Q?yVDHwwJeV4YV4DM7MvOOAdZ58ff6IyevjXC7qIV160GoKibjZSlQqSFglW5x?=
 =?us-ascii?Q?nJcZ2tOSYe53TgDtKMdwI29hd8Uag0OuYAdTUE66Y77o4RX98+7DRLUX74GK?=
 =?us-ascii?Q?bkELqE6jFUW9T5QbtgrZ1/Hs9nQn9eXl+qK7KzZLq9i1F262teEX8/5DPh+x?=
 =?us-ascii?Q?LuwCPGUM5h0EbnhGcgqheIxBLuQlARKnOLqMUO/htUDmfrD//5GzqZ7vohsW?=
 =?us-ascii?Q?5m5tqSlnYAVbs1ThpjoJofNpXHM4eaRi9RZ0uhz+Mb4G02KYF/skml7XCbKC?=
 =?us-ascii?Q?KH7vcEuAdGYYE4cwawHUTEGnwNIHlD1yOX0qFSEvoRTFWHyHI+uBi1HnCAMS?=
 =?us-ascii?Q?a2geYgsFTN9Ucr/xiwf5pqkCZLBtmoHvEZCxVMsijPlMPSuVHfkXBb1pWFZw?=
 =?us-ascii?Q?q//CF0mld5pjK2Jdhxt0/Q/6Far+ji6sfjlB4j7N+njhyKvEDlo27UjOVMvq?=
 =?us-ascii?Q?HYRY+DArTL0uMoZzHLdUkgtV5uO5ZMOW8ZpX9bWu9+QKoJniHCJIzM5MRvo/?=
 =?us-ascii?Q?xP52Or5bvUiHQjAxDsY/vFXVgNOZB9EZjBmV/YuW6JeTepnvirnhL9HfQKDn?=
 =?us-ascii?Q?MlKpPCWHW0ihdpGod83q9FHZSGYPNrUczlzt96f65fIIle/Nnjg487/XRdax?=
 =?us-ascii?Q?fGFaSSEC1cS65VG5FyPHD4shuUHJleEuU6KHJr4amKUIUAXJ4SjdN1Fl1Wjb?=
 =?us-ascii?Q?tuxl3whp0nfS3rQNQSf9LuWROw9cYhifSyfSGiZdOF794aAMdLC7AwxItUat?=
 =?us-ascii?Q?qvgPO6JfZbgcjHvFG2fvcpzKcVSjMvqEQaqGo7Vb5BN/NUi6h193Xqbm7Jiu?=
 =?us-ascii?Q?Tw=3D=3D?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 3b529e73-a624-4840-9383-08dd3762a37a
X-MS-Exchange-CrossTenant-AuthSource: PH8PR11MB8107.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 18 Jan 2025 01:51:34.6478
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: DCxjAay30ks2mFqtsnv+7UPLYqQXKDmWxpn2WTbHW3Xgl3It0CxQKHXi+dNg4zglFhh2idx3NK60rh0PHsi4iHFMk7sD09WudEHlcjd7RfU=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA1PR11MB8199
X-OriginatorOrg: intel.com

alejandro.lucero-palau@ wrote:
> From: Alejandro Lucero <alucerop@amd.com>
> 
> Create a new function for a type2 device initialising
> cxl_dev_state struct regarding cxl regs setup and mapping.
> 
> Signed-off-by: Alejandro Lucero <alucerop@amd.com>
> Reviewed-by: Dave Jiang <dave.jiang@intel.com>
> Reviewed-by: Fan Ni <fan.ni@samsung.com>
> ---
>  drivers/cxl/core/pci.c | 51 ++++++++++++++++++++++++++++++++++++++++++
>  include/cxl/cxl.h      |  2 ++
>  2 files changed, 53 insertions(+)
> 
> diff --git a/drivers/cxl/core/pci.c b/drivers/cxl/core/pci.c
> index 5821d582c520..493ab33fe771 100644
> --- a/drivers/cxl/core/pci.c
> +++ b/drivers/cxl/core/pci.c
> @@ -1107,6 +1107,57 @@ int cxl_pci_setup_regs(struct pci_dev *pdev, enum cxl_regloc_type type,
>  }
>  EXPORT_SYMBOL_NS_GPL(cxl_pci_setup_regs, "CXL");
>  
> +static int cxl_pci_setup_memdev_regs(struct pci_dev *pdev,
> +				     struct cxl_dev_state *cxlds)
> +{
> +	struct cxl_register_map map;
> +	int rc;
> +
> +	rc = cxl_pci_setup_regs(pdev, CXL_REGLOC_RBI_MEMDEV, &map,
> +				cxlds->capabilities);
> +	/*
> +	 * This call can return -ENODEV if regs not found. This is not an error
> +	 * for Type2 since these regs are not mandatory. If they do exist then
> +	 * mapping them should not fail. If they should exist, it is with driver
> +	 * calling cxl_pci_check_caps where the problem should be found.
> +	 */

There is no common definition of type-2 so the core should not try to
assume it knows, or be told what is mandatory. Just export the raw
helpers and leave it to the caller to make these decisions.

> +	if (rc == -ENODEV)
> +		return 0;
> +
> +	if (rc)
> +		return rc;
> +
> +	return cxl_map_device_regs(&map, &cxlds->regs.device_regs);
> +}
> +
> +int cxl_pci_accel_setup_regs(struct pci_dev *pdev, struct cxl_dev_state *cxlds)
> +{
> +	int rc;
> +
> +	rc = cxl_pci_setup_memdev_regs(pdev, cxlds);
> +	if (rc)
> +		return rc;
> +
> +	rc = cxl_pci_setup_regs(pdev, CXL_REGLOC_RBI_COMPONENT,
> +				&cxlds->reg_map, cxlds->capabilities);
> +	if (rc) {
> +		dev_warn(&pdev->dev, "No component registers (%d)\n", rc);
> +		return rc;
> +	}
> +
> +	if (!test_bit(CXL_CM_CAP_CAP_ID_RAS, cxlds->capabilities))
> +		return rc;
> +
> +	rc = cxl_map_component_regs(&cxlds->reg_map,
> +				    &cxlds->regs.component,
> +				    BIT(CXL_CM_CAP_CAP_ID_RAS));
> +	if (rc)
> +		dev_dbg(&pdev->dev, "Failed to map RAS capability.\n");
> +
> +	return rc;
> +}
> +EXPORT_SYMBOL_NS_GPL(cxl_pci_accel_setup_regs, "CXL");

Only after we have multiple instances of CXL accelerator drivers that
start copying the same init code should a helper be created that wraps
that duplication. Otherwise move this probing and error determination
out to SFC for now.

