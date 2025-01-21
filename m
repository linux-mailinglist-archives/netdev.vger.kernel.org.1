Return-Path: <netdev+bounces-160144-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id A0501A187E1
	for <lists+netdev@lfdr.de>; Tue, 21 Jan 2025 23:52:03 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id D40FC1691D3
	for <lists+netdev@lfdr.de>; Tue, 21 Jan 2025 22:52:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 627931F8930;
	Tue, 21 Jan 2025 22:51:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="dVTpoYx7"
X-Original-To: netdev@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1D1141F8908;
	Tue, 21 Jan 2025 22:51:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=192.198.163.7
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1737499918; cv=fail; b=HSevLHw+r6UmZxJPYE8YW0hM+Whhuq0k4khFebTZpp/c1E3pbTAhzlv6KIe3zg4MgyuoY1LcQxOMOIdh4aikJo9JlKzGKfZi+1wk6RDefpcLxNlorcJzMRSVTWDmp2scHEGMdU1O4pLSJcWc8Q8QjCtF+2oVix5HKBWL3hDx07s=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1737499918; c=relaxed/simple;
	bh=9CsUbdOOBPCgjImh78rlvVMvuKjofPl0qBHGSCAzV38=;
	h=Date:From:To:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=hAIgz8s0qps9FkLd6aoxTZob68kVAKFsyv+wXHlTjUVZEAlo/4fy1hXcr7QA1KVEhFAcGIHxi+y+3SFDWClbzQJTrPby+e8OlMt3V5ARL+oQ5zsJm8VBQKCM80VF8CAiNEt1bqIMNgg5FKs2ZauU2+Y42XL1/PulMWOpYJqfjgw=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=dVTpoYx7; arc=fail smtp.client-ip=192.198.163.7
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1737499916; x=1769035916;
  h=date:from:to:subject:message-id:references:in-reply-to:
   mime-version;
  bh=9CsUbdOOBPCgjImh78rlvVMvuKjofPl0qBHGSCAzV38=;
  b=dVTpoYx7AKnG35zzusKFiacp7ncLNs0AwW427pimasHj29W1hbdUt9aH
   4KcxNUKckA150i381pgBiDa7Q/030xOd0OAq9Rca0pvqxhCKS2shWJNPz
   YMy0ny1OjP7HJfXVXJqzHdnNRq4wkO38r/FTqmnQO1BeXWMu9Ro5BzSdC
   gZNkrYig1k3dZeL8nrh0dIvmtOIALacrZz6HHNRTMbW6fJJZ8ASxqydLL
   yXHZ9vjsQ+C7xX2FntLptmFCFnesTHgxvfIZ2FUSScGtQkEgNTBH4mApS
   q83FJQiEDr3dr/oaETQpn+P2cPKVTeTqXQO+fdDbikRl4zDHcjH5dSRxj
   Q==;
X-CSE-ConnectionGUID: vDk/d/D2RgGCM3cfh4N+XQ==
X-CSE-MsgGUID: rkdM4ki1R6ms/sOdtiXBJQ==
X-IronPort-AV: E=McAfee;i="6700,10204,11322"; a="63295345"
X-IronPort-AV: E=Sophos;i="6.13,223,1732608000"; 
   d="scan'208";a="63295345"
Received: from fmviesa010.fm.intel.com ([10.60.135.150])
  by fmvoesa101.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 21 Jan 2025 14:51:55 -0800
X-CSE-ConnectionGUID: aoYk5pg+QzWKjMair/6ePQ==
X-CSE-MsgGUID: GBASE+V3QPeAtRDiGDAe8g==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.13,223,1732608000"; 
   d="scan'208";a="107486601"
Received: from orsmsx603.amr.corp.intel.com ([10.22.229.16])
  by fmviesa010.fm.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 21 Jan 2025 14:51:55 -0800
Received: from orsmsx601.amr.corp.intel.com (10.22.229.14) by
 ORSMSX603.amr.corp.intel.com (10.22.229.16) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.44; Tue, 21 Jan 2025 14:51:54 -0800
Received: from orsedg603.ED.cps.intel.com (10.7.248.4) by
 orsmsx601.amr.corp.intel.com (10.22.229.14) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.44 via Frontend Transport; Tue, 21 Jan 2025 14:51:54 -0800
Received: from NAM11-BN8-obe.outbound.protection.outlook.com (104.47.58.172)
 by edgegateway.intel.com (134.134.137.100) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.44; Tue, 21 Jan 2025 14:51:54 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=XUsDhxAmlnzEJHRkw+/9TD+YhtvTgN2vks0J/dOCi/2sEf59vl9HIq0a1+v0Yjp7c7R7h/VpIC0MsY8MVzIzGseokEKuSc9HeBb0LXNG0QwrH6/Bh9HpcLmqqIKq4cSlVksjo4TTaRScvyVdf4i+tsM787tYCq+8exPh5bz41cE9NIN6chYrUvxQ42GIL988JUCjWCbcf8UugP7E8HglSmRyrPcI7FGFlSwFwNTJbivn+l1pEldnBhT4LER1nmeW2+n4okuIicGb5ZEOos+QT+c1qxfGYmiTgd/xGmY2hhOMY1pl9ogwCgJhykfPC27yBs+b88rlW3O6pzRPH8pWZg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=wlTdHaDSF1Erug2/6c5dMFMULIJEavwEg8KPBjMBTgk=;
 b=nBHK1/kaBzsE2vQJnWbULTW4QoTAhp3K6OO30zmWLilTTf9IYbq97WYFUucGpIx2St8FJuN0DUeIgdDxAJ3fv8WW6D9U+L0bbZ3r3GeGuMc93izMVtypWLGzOKkrK/VE7/N/BNxpViHgMO2b9hc6IrALWA/doBIJPweRXrFzbZZRFJeZ/reAaAoXwZUK7hbCRyFddPmCV9n6FDjQJ4U0oUbt+lsJ3+CEBWL+hbfWgR/IBxPJSLTTDKj5naaSVJsfPx5XbmzgOydWwwyYdJSD6pfokpefp5VaHxJchi+Eqa9ck1/GfQRoVr5U1vFIvzzJM8t3t17FXmOBPfo3NjWHEQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from PH8PR11MB8107.namprd11.prod.outlook.com (2603:10b6:510:256::6)
 by PH0PR11MB7521.namprd11.prod.outlook.com (2603:10b6:510:283::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8356.21; Tue, 21 Jan
 2025 22:51:39 +0000
Received: from PH8PR11MB8107.namprd11.prod.outlook.com
 ([fe80::6b05:74cf:a304:ecd8]) by PH8PR11MB8107.namprd11.prod.outlook.com
 ([fe80::6b05:74cf:a304:ecd8%5]) with mapi id 15.20.8356.020; Tue, 21 Jan 2025
 22:51:38 +0000
Date: Tue, 21 Jan 2025 14:51:36 -0800
From: Dan Williams <dan.j.williams@intel.com>
To: Alejandro Lucero Palau <alucerop@amd.com>, Dan Williams
	<dan.j.williams@intel.com>, <alejandro.lucero-palau@amd.com>,
	<linux-cxl@vger.kernel.org>, <netdev@vger.kernel.org>, <edward.cree@amd.com>,
	<davem@davemloft.net>, <kuba@kernel.org>, <pabeni@redhat.com>,
	<edumazet@google.com>, <dave.jiang@intel.com>
Subject: Re: [PATCH v9 06/27] cxl: add function for type2 cxl regs setup
Message-ID: <679024f84230f_20fa29478@dwillia2-xfh.jf.intel.com.notmuch>
References: <20241230214445.27602-1-alejandro.lucero-palau@amd.com>
 <20241230214445.27602-7-alejandro.lucero-palau@amd.com>
 <678b092428a86_20fa29462@dwillia2-xfh.jf.intel.com.notmuch>
 <0063f9c6-9263-bc4a-c159-41f9df236a7c@amd.com>
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <0063f9c6-9263-bc4a-c159-41f9df236a7c@amd.com>
X-ClientProxiedBy: MW4P221CA0020.NAMP221.PROD.OUTLOOK.COM
 (2603:10b6:303:8b::25) To PH8PR11MB8107.namprd11.prod.outlook.com
 (2603:10b6:510:256::6)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH8PR11MB8107:EE_|PH0PR11MB7521:EE_
X-MS-Office365-Filtering-Correlation-Id: 8269b489-5a60-4148-85bf-08dd3a6e2a51
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|1800799024|376014|7053199007|921020;
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?6Ma5Pkz0DiBwisrw9sFlbKfnvsX6hyzKqfYdBlBeHh/DCeUS7A/CcVVMwsLn?=
 =?us-ascii?Q?APIY3m+/1mbauYn8XzQx1Qpi+S2cs8Q1pmxiVtpmEL+XBg2C6fo5/4mIDuT5?=
 =?us-ascii?Q?oDLA6IT8SAAD5eRTqQjx5jnpGQ1SD3qcPyZsDQ4johmVTuSlesbAZ4Jq2fv+?=
 =?us-ascii?Q?O+CQ76dmE4U4SILKZqLsNdRhKYCF5i6cOZu9Icyc52cAaLNvmBd3qHrwCGgu?=
 =?us-ascii?Q?TDdPBCIRHfaT5jK6sqlijzXzN44HLb8d4Q6rysUrawGcbQSBsChBq101an/S?=
 =?us-ascii?Q?DwTVfuCqGQ2ssQz5XC7mpX3XKJpJFcl6pPK0bAPS9XPynYm9MjAKYKo1UHlx?=
 =?us-ascii?Q?utZGa3/vACUT23kI6KHZmSTteaVFON3PuMj5s8tzeFYLdyrUoHG1ppc/yJY+?=
 =?us-ascii?Q?wa5M72p5eqaQ3Lxvng8YgmH1X0/FWv86PrTfeA5uVxlVw13RMP/uOROrT3vQ?=
 =?us-ascii?Q?EjTm+ISOzwbokhx6ZviL8cxA9yPlXNRIozMG7azsc0kbU/eM5Mmlu4g//eTj?=
 =?us-ascii?Q?J01J3QI3RnEC23KudkZPliN1ZaUPypm8bMQzxb/tZ/Kq82V/l4mI0ul+2Er5?=
 =?us-ascii?Q?8LfSkYVVgJ41vSC79XnbkHePrcaI9X/8mwxlIZdfQWZWiP0uYdwpAhMaW6db?=
 =?us-ascii?Q?M8KqaK1Tc00BDPHD/j0/MWVMukFmmiOp8DdKkShZL87WjLnGmO0XL4EGVmNJ?=
 =?us-ascii?Q?rbpIKgGCNPHpdC1JArNQi9R0k5BTym8KP2hcyud0I4QJihjnWj9ti8XgmBoZ?=
 =?us-ascii?Q?mo/MwBlpVor2SMs7nVPhGh9+wPE+JZoB6Ht7S2PoeubIk47PAVioaBz+k20u?=
 =?us-ascii?Q?ZuSiyLum/vpr/SKuNPOrdK3sKSXWtlvPjDpXk2TZljscakw+51FaFhaIvMma?=
 =?us-ascii?Q?JqY5S/JosroC1/ZrK4UpZTk5DEjK6ycdCeyGcfV7H2xLL+rdVRAHOo9MPbue?=
 =?us-ascii?Q?nadevAVf00W6SpLfqL7MV6A2AxIh1P5gLrXxONkiTDZdLJhOhsdXYSjchGg/?=
 =?us-ascii?Q?yNNH+/YOVzTRpfX5hH40jM9vi4BJ4qya5nd/o/kLBpu8o0U/CCo/5t0y7lZe?=
 =?us-ascii?Q?M0TNRfjayga7yRObbgTKZkXbKnGXhfsXdgWdfwiKjBRB/+9tezKSVY9ibG8q?=
 =?us-ascii?Q?rd8J7HqVobBqAqybFpqP/g1MP9tq45aEXw8uiL7KVkZN4E0eXnomA8SceSEM?=
 =?us-ascii?Q?psS0dMaFds0a8D85H/oisJq9MpRbgrCuSFEPSN+sirFnfo3CbKp8WF/LmtCd?=
 =?us-ascii?Q?L6oUbR8YXybrHiy/FcJUPVpbG/W8wYAFn/sVNVpJ1pfsz2ScexvdBuD5SmCR?=
 =?us-ascii?Q?GoEDIPkozOWp91MIofdHI93iIsQAk34WG5ivykwuVoZR5bVMqBN/2ohjeg4J?=
 =?us-ascii?Q?y46p6Tf/KQvo2EOuS8TouqHO/EKAG7KUqGE/00VjrdbhD+Q0nqr1rCZmAMA3?=
 =?us-ascii?Q?X9AykbIQWQ8=3D?=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH8PR11MB8107.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(376014)(7053199007)(921020);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?fWGnSkAkZPG/Be0i7qg7pGROiRJVW9QX5ttSb8HD37lLoSsEp7rSYuMsoSkv?=
 =?us-ascii?Q?50oxyj3McKpEF2xOMmx0mfhvKMfeJzBYwv4xbpJyEBEVfkl8En7pzZssWLgS?=
 =?us-ascii?Q?Nw35LUMOaMq5iSbnkl2eOwEytfM5iPQqC/siVuzaZKL9NJYvgoPoHwhCA6qi?=
 =?us-ascii?Q?8ZRPwlUYNoYG1ubcikZRYKusCxDM3ISnUb4Ihi7x4x2rcea7pRu5A7BPcF5y?=
 =?us-ascii?Q?TsjX2+NhsxLZiaIJGTazrBUl9DyA8+QvbgU3cld17WSRzFnHZX/XDbhVPZBw?=
 =?us-ascii?Q?3IsxdImHOcxlIJk6Cd3wzk+JCwGMtu/d7BupBlEVrC1c9Dkeh48n8Gr5o+LX?=
 =?us-ascii?Q?WhH2EW/eEcW4p9jzEdgxgxMgH98AEfEu9mjKlg9puBYCi7SgYtpQ+8Ahf41L?=
 =?us-ascii?Q?rNEgJghvwq5j+EFxrhoszUoy4S6MJo+qdBFmWWIgYexm01byggS1ZcYGEnDb?=
 =?us-ascii?Q?coJXwONGTDZfI5qe2NAP3IK+qJfXlNi8prcZEg8kzd8vIhgtaQSqytvL2uPp?=
 =?us-ascii?Q?jW+ACgmlwzjy1bnxgQcvpmhxZxbXVHbJ9L/0oY2etOhx533p36vewGGN1m51?=
 =?us-ascii?Q?yMlbYkwMWvGkNQSJbpX3x0VecWWQ5EzD6RCh5v6zOjbpUN1VohTPzy+qVuKr?=
 =?us-ascii?Q?619ZiDZFZwR6xcykQ+9gyjjd/bpQ45c4Os4tGw3qH3YHu5KH6AoDhCTdtr0O?=
 =?us-ascii?Q?HbWTj90qsjg89Pu8ssBOfsn8mJBIAQsOASeizBjoabk0az3Ffei6+xLL9Ex2?=
 =?us-ascii?Q?encVxNrRjZS7WvgK6sBkchZ5TlwHvTxTd+GAwmCDQ1qCTf5+ilvd/6rzbKDk?=
 =?us-ascii?Q?MxgG+CxUD71z24v6i52VIMzELfzu1rlbrzxjyA/IcDDKAjfS/lrMqHBVrPXU?=
 =?us-ascii?Q?DQQqRAv0PAw3m1ohF2F4+7PrD22BaQVcVj1qVdd9ZnajLBgN22m0D0jrglV3?=
 =?us-ascii?Q?dPuCOdR5MFL/OnGrEREV7ojKuo4X0KhcWNeDtEv8U+0pAuLcNXA33oYsylKZ?=
 =?us-ascii?Q?7LDH0ddGvZLCGC7TAb99DMelaMMSVr3SlTwji8/Kt8MEkbVUburiwp5byURr?=
 =?us-ascii?Q?KPp6REDNDWCdyNyG6S+56gOx/ClIfkKDsFZ1BsxIaWg2Q4i+lAyMU2HofkFH?=
 =?us-ascii?Q?fNCQtxLppk6xqaiKuxlmcYiNZaxJuv6zHBk7BXOn5SKMbh7krPXMy8ZxSKJf?=
 =?us-ascii?Q?WpJm2N6WD7WHOStYXBMZ5rVnADC3M50m72Tzqm9Y/gzOAe/cDHSdMgzmySbC?=
 =?us-ascii?Q?ALK9tSw5/ybXHIYezINzxbtZOqh4Q81LeNT8yp+setpJIzVAj706PMmYF8N9?=
 =?us-ascii?Q?Qh3aPAZS+Rk9t+RSQz5OY1ChBx1RZ9o/OFWmcwLypnuU0JZqho8mk89AVF4b?=
 =?us-ascii?Q?SjMfeLW8gemiPpoIB7wwZLNvq/w1I2J0ywZTdPWDjN5IXft2mwrvL/wvZtLA?=
 =?us-ascii?Q?E1GsegKAKfAWOx+fpaNkrcGeAhOMS7HxM3eV/JXuE5B7iHJ5n6fmFhOHXmJS?=
 =?us-ascii?Q?AmDc0xBLMpr5j6C4lglHiyCfaHrbqUtGOaEKnhK41ghwTW0HYZpzhpfxf+zf?=
 =?us-ascii?Q?bK+onnyZYWJ5T7TRliuY7kPNH/15EHjpiUMRTMifCYsINSXuR4fjhgLjP2b+?=
 =?us-ascii?Q?KQ=3D=3D?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 8269b489-5a60-4148-85bf-08dd3a6e2a51
X-MS-Exchange-CrossTenant-AuthSource: PH8PR11MB8107.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 21 Jan 2025 22:51:38.8478
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: TjOmDRz3TEvHOtBrCFhP26uZ0uHpX/9TinmZIcC7fmCspzopz3RkzaksMxfZufXOp+KrPbMPX/jL6BZBAVlnmZUa/V4qzJFAEquDczvOUGE=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH0PR11MB7521
X-OriginatorOrg: intel.com

Alejandro Lucero Palau wrote:
> 
> On 1/18/25 01:51, Dan Williams wrote:
> > alejandro.lucero-palau@ wrote:
> >> From: Alejandro Lucero <alucerop@amd.com>
> >>
> >> Create a new function for a type2 device initialising
> >> cxl_dev_state struct regarding cxl regs setup and mapping.
> >>
> >> Signed-off-by: Alejandro Lucero <alucerop@amd.com>
> >> Reviewed-by: Dave Jiang <dave.jiang@intel.com>
> >> Reviewed-by: Fan Ni <fan.ni@samsung.com>
> >> ---
> >>   drivers/cxl/core/pci.c | 51 ++++++++++++++++++++++++++++++++++++++++++
> >>   include/cxl/cxl.h      |  2 ++
> >>   2 files changed, 53 insertions(+)
> >>
> >> diff --git a/drivers/cxl/core/pci.c b/drivers/cxl/core/pci.c
> >> index 5821d582c520..493ab33fe771 100644
> >> --- a/drivers/cxl/core/pci.c
> >> +++ b/drivers/cxl/core/pci.c
> >> @@ -1107,6 +1107,57 @@ int cxl_pci_setup_regs(struct pci_dev *pdev, enum cxl_regloc_type type,
> >>   }
> >>   EXPORT_SYMBOL_NS_GPL(cxl_pci_setup_regs, "CXL");
> >>   
> >> +static int cxl_pci_setup_memdev_regs(struct pci_dev *pdev,
> >> +				     struct cxl_dev_state *cxlds)
> >> +{
> >> +	struct cxl_register_map map;
> >> +	int rc;
> >> +
> >> +	rc = cxl_pci_setup_regs(pdev, CXL_REGLOC_RBI_MEMDEV, &map,
> >> +				cxlds->capabilities);
> >> +	/*
> >> +	 * This call can return -ENODEV if regs not found. This is not an error
> >> +	 * for Type2 since these regs are not mandatory. If they do exist then
> >> +	 * mapping them should not fail. If they should exist, it is with driver
> >> +	 * calling cxl_pci_check_caps where the problem should be found.
> >> +	 */
> > There is no common definition of type-2 so the core should not try to
> > assume it knows, or be told what is mandatory. Just export the raw
> > helpers and leave it to the caller to make these decisions.
> 
> 
> The code does not know, but it knows it does not know, therefore handles 
> this new situation not needed before Type2 support in the generic code 
> for the pci driver and Type3.
> 
> This is added to the API for accel drivers following the design 
> restrictions I have commented earlier in another patch. Your suggestion 
> seems to go against that decision what was implicitly taken after the 
> first versions and which had no complains until now.

Apologies for that, I had not looked at the implications of that general
decision until now, but the result is going in the wrong direction from
what it is doing to the core.

> >> +		return 0;
> >> +
> >> +	if (rc)
> >> +		return rc;
> >> +
> >> +	return cxl_map_device_regs(&map, &cxlds->regs.device_regs);
> >> +}
> >> +
> >> +int cxl_pci_accel_setup_regs(struct pci_dev *pdev, struct cxl_dev_state *cxlds)
> >> +{
> >> +	int rc;
> >> +
> >> +	rc = cxl_pci_setup_memdev_regs(pdev, cxlds);
> >> +	if (rc)
> >> +		return rc;
> >> +
> >> +	rc = cxl_pci_setup_regs(pdev, CXL_REGLOC_RBI_COMPONENT,
> >> +				&cxlds->reg_map, cxlds->capabilities);
> >> +	if (rc) {
> >> +		dev_warn(&pdev->dev, "No component registers (%d)\n", rc);
> >> +		return rc;
> >> +	}
> >> +
> >> +	if (!test_bit(CXL_CM_CAP_CAP_ID_RAS, cxlds->capabilities))
> >> +		return rc;

This is injecting logic in a bitmap and a new CXL core exported ABI just
to avoid the driver optionally skipping RAS register enumeration.

The core should not care how and whether endpoint drivers (accel or
cxl_pci) consume register blocks, just arrange for their enumeration and
let the leaf driver logic take it from there.

