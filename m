Return-Path: <netdev+bounces-268904-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 4JMrOLJUumm8UQIAu9opvQ
	(envelope-from <netdev+bounces-268904-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Wed, 18 Mar 2026 08:30:58 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 425732B6F33
	for <lists+netdev@lfdr.de>; Wed, 18 Mar 2026 08:30:58 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 2B42E3073A57
	for <lists+netdev@lfdr.de>; Wed, 18 Mar 2026 07:29:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 585AE25C80E;
	Wed, 18 Mar 2026 07:29:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="i3P66WB0"
X-Original-To: netdev@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.20])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DAACD1F239B;
	Wed, 18 Mar 2026 07:29:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=198.175.65.20
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773818975; cv=fail; b=k0W/a68OtSL9hD+atFOkBlHEPBWUIBi/UYDYXqtbwIU0ZyzjB3W9zg125QpSa5KFWXOVDSKGn009JjBwPaVKVMJKHxwMOg88RFzQRCa6a1p9j3MV1EXKTzmnLFCi/OcQnncly6RLJI0wBSvQv+4NSEOu9rMKqnty1F/iM6g8ZLc=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773818975; c=relaxed/simple;
	bh=es75eiiWwzt3R7KZOD87KaXLh2HioGmuPnEVtUUr5hU=;
	h=Date:From:To:CC:Subject:Message-ID:Content-Type:
	 Content-Disposition:MIME-Version; b=SAUZYqmrQMWIPApg4rIIHBmPH44c3Ob9+TN7bOuWLozYYPoTP3yH5nwFXO89yBWWQUhJcFV7mwF6l+8QGdTlvt15FnM2LOIVTuZ8Nbeqtlrl6b4ROVSm/5jfnnxo7yUbOXZ2CcDtF+uicpNy2x/gxOf8ultFmuTzrrvjMnxUEVY=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=i3P66WB0; arc=fail smtp.client-ip=198.175.65.20
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1773818973; x=1805354973;
  h=date:from:to:cc:subject:message-id:mime-version;
  bh=es75eiiWwzt3R7KZOD87KaXLh2HioGmuPnEVtUUr5hU=;
  b=i3P66WB044Am5T5juE8gR8l0NG0B1ZhUe67tCpSWQZ3X58QmA6PuFtH9
   DMJqB4ViBKiv8LXlMcJEePka+QlCKnQq+VELE0OGEgkUxIu59vNnbgXpU
   U+D+qTHJTKFZzF08hqPixvVR3WHFOP2rfWORQoWgRJglTLuu5Y7Hsb0kf
   3cbyThHSiuHSoh6eJ0uB06rhtNeR7Ic1w9cz6Wp95oK9htiEIT3fIjISS
   qBZo+5sWgrnnpiH562NAYpFeGsA62nMUL/y1tNlheaQyI4M5dIuU3CGJ0
   V27NM0VtOauc8i2EywGEGcWzEO117VtUCRSG3TC9IscXJAF2/vrfTQlnp
   w==;
X-CSE-ConnectionGUID: nduRmHNPRH2Hh5cP6GmNbQ==
X-CSE-MsgGUID: OTfVukXuSQKU0AmDfngdPQ==
X-IronPort-AV: E=McAfee;i="6800,10657,11732"; a="74565915"
X-IronPort-AV: E=Sophos;i="6.23,127,1770624000"; 
   d="scan'208";a="74565915"
Received: from fmviesa006.fm.intel.com ([10.60.135.146])
  by orvoesa112.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 18 Mar 2026 00:29:31 -0700
X-CSE-ConnectionGUID: B3nLRMnJTQKKA/Evg8zUPQ==
X-CSE-MsgGUID: 5UK1jgmzRp6z6VIY9WScjg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.23,127,1770624000"; 
   d="scan'208";a="218138854"
Received: from fmsmsx902.amr.corp.intel.com ([10.18.126.91])
  by fmviesa006.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 18 Mar 2026 00:29:30 -0700
Received: from FMSMSX903.amr.corp.intel.com (10.18.126.92) by
 fmsmsx902.amr.corp.intel.com (10.18.126.91) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.37; Wed, 18 Mar 2026 00:29:29 -0700
Received: from fmsedg902.ED.cps.intel.com (10.1.192.144) by
 FMSMSX903.amr.corp.intel.com (10.18.126.92) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.37 via Frontend Transport; Wed, 18 Mar 2026 00:29:29 -0700
Received: from DM5PR21CU001.outbound.protection.outlook.com (52.101.62.0) by
 edgegateway.intel.com (192.55.55.82) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.37; Wed, 18 Mar 2026 00:29:27 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Trf2i63nLr8DheRBQNJYKu0ibaMCZQTOla9QV2iLAMYmwd6mIzLoR74AaNOe99qrZUljzNq4rXlXmlAkaWBwc6BT45njIk0e72+pPr26lZoqHLja2oBaVZKxBOgtVZjRg5a+Hww0Qom/jsVXVbYvXXcy3j2hbqQfXlGmAW1GusmqgiTYCTLeIU29IrAsrFzs9tuwUq8L6l97dfkpCymZglk32UibW7A/C4mngKQO7XClmFdhe0qKMvXop3yampK5qPs0/K+aYQWe61b5RV+0ua3KAXC3d49a3GM6YbF3mM3ZdEe19mA1SsK2DT9ZElkg+aV+dhRnHMlnB8x9xYqcmw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=KGpbEHGJradz1VDR57OCOy0ER5h6CMqkeuI5VJt7wQI=;
 b=UCW2FLTW92MnHzoen5fG8z+HbGNGyho9lGRLgztSJvysffvM71XgQ7dPV3602QbSF/Bgdj4J3ZR9BdRnmELFS9lBA+VQ/VzL+AQ8VlmxMwVCgLZk1J9Y2w7HtUja5OfauZkbjTkfNx91BMCueDuqzwZr2p3v3MrL4WFiYL4ONtyDKaQyeC6ReyGDnyhp7PiLTfDY43CM7XdxhzylhOtQZt1RtFspKCj7bOebF/jW1XUwsNIHxfOuE3XTq45jEFZUN1fJ7LfmmXlcpqm+fxOaZyWV2L9qPFXQlCdbnaUg7nztObd0kO/4WKEY1ryzzA/nrKQZITpD72HzM7b+XdROeQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from PH0PR11MB5832.namprd11.prod.outlook.com (2603:10b6:510:141::7)
 by CH3PR11MB7794.namprd11.prod.outlook.com (2603:10b6:610:125::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9723.19; Wed, 18 Mar
 2026 07:28:23 +0000
Received: from PH0PR11MB5832.namprd11.prod.outlook.com
 ([fe80::106e:78dd:4c96:d707]) by PH0PR11MB5832.namprd11.prod.outlook.com
 ([fe80::106e:78dd:4c96:d707%3]) with mapi id 15.20.9723.013; Wed, 18 Mar 2026
 07:28:23 +0000
Date: Wed, 18 Mar 2026 15:28:16 +0800
From: kernel test robot <oliver.sang@intel.com>
To: Xu Du <xudu@redhat.com>
CC: <oe-lkp@lists.linux.dev>, <lkp@intel.com>, <linux-kernel@vger.kernel.org>,
	Jakub Kicinski <kuba@kernel.org>, <netdev@vger.kernel.org>,
	<oliver.sang@intel.com>
Subject: [linus:master] [selftest]  400e658aa0:
 kernel-selftests-bpf.net.tun.fail
Message-ID: <202603181411.24db1a78-lkp@intel.com>
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
User-Agent: s-nail v14.9.25
X-ClientProxiedBy: SG2PR01CA0153.apcprd01.prod.exchangelabs.com
 (2603:1096:4:8f::33) To PH0PR11MB5832.namprd11.prod.outlook.com
 (2603:10b6:510:141::7)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH0PR11MB5832:EE_|CH3PR11MB7794:EE_
X-MS-Office365-Filtering-Correlation-Id: af3238a3-6731-4310-36d3-08de84bff01b
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|1800799024|366016|18002099003|56012099003;
X-Microsoft-Antispam-Message-Info: esGGXGilFuaOv0w1/77OdMKZSuF3W4Lyb9Quh6iNWEGJyVxw7SrGO1jCTAblYRRiTIc1EqEWOr9GzNLzcZOPgxWoFDf66VDDuTNEg1mqL9wR5aCqw9syZTMw1Agp96icRTSwSUc2WKPa/L6ix+x4T2jrRSZbNfUg8WlOCCK0hcq/x4mlxxKQh1jk+Dwt189WG1b8uaX01HrEI5Hxuiv3+dAit+3QfFPf5ogLjIBrLKqS6Elm95S+D4/i4iel25EuuWtapNnNZ6E2Sl0QsMenmrT45T/elpLspNL93zzv8b6VKF1tTTx4vR24RSMDq6YybIIm43QSstfotmnkkl2RRv4PPvnL61+AueLocAfZHwf564oiQnpGnIzHM5w89OF5wrT1vSITRGhI2DKtuFmCxlNfOCivprLtujlp8ik2krwOaiL1vZa96chIXV2rRzgrvLKKSWho10idothCk3Fvb2Y0hGu6f5vdQHJvZdyfa5ynvpVLqlUM2gKeAzzbHQB/KiNtiezxZlSwtAOOMOmZYfmOeGHTExBsrkGzArdrlNi/uwaciGSwaaOcgv+sx8R6Vp2o0f7oi/jlsQQecmTncE98MGeSK0vQL5Wn+2uR613fXPRefBDiBoCuk8V0Q20B2iBR3Oy0kznCYNklyvlTWxQovXdM6ZhxZVF6StjwGOM+jedptSgRRexA9802VMsF
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH0PR11MB5832.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(1800799024)(366016)(18002099003)(56012099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?0Py1/9UA974kFbUVba6HwT4dAEuFMtkgpnDsuMgcjPF2usqMOA5xprMAw91Z?=
 =?us-ascii?Q?6K9HRhFC4Rz9L7FP9HsFBuzsX5b3jK6R57aLVOzHKo/40123gvDVyGys9sMS?=
 =?us-ascii?Q?nOwswYKJ6+TndjiearExklsm5lgeSTfZOA4+Dq5b/b0gYVLc0R/EFM+EXxqI?=
 =?us-ascii?Q?MD8Xj8s8wZpO24olQ9JjmWRSs+acAO7kuTrf6aVeFYYBVfTFcODmhrmGtBU5?=
 =?us-ascii?Q?uOr239H9dTF9O3khOesKJlEOl+dxXN428QRRBTCuzc9snHky/dBqSEVYCafR?=
 =?us-ascii?Q?a+AzMi2tzRQAb5T6fV4kPeAkap2ErbF7O7ZqFQxbOPeb4hZM2N/RjI04LhK0?=
 =?us-ascii?Q?nWT1YeTzS5NW82e6l0yqSzzgw/+kLCAnkzPfod1FtPh4snECvHrc8R8hTywh?=
 =?us-ascii?Q?tWZFV4oJgGsX4eTBTZ1TSiZ/hbFZkbXFmrTxQzxr+J/zQJg97ZJrBvjA/L7u?=
 =?us-ascii?Q?Dx9wqWEvusK59L55o51CDYHqtV7byVQWgOn94MMLg3eO3oyp/SkfQjJfEhde?=
 =?us-ascii?Q?Vt/75A/rBEfl5iu5RdqxO9rRcVeWzztpR2kw8CMn87ZItZ6YmjgUeT2dBNZz?=
 =?us-ascii?Q?7KUQWtjF2v2x9DKFHKRlK7eYCEUMOg1jeVqrXrLxl/BWE2mPopKhA3ioJCEl?=
 =?us-ascii?Q?Nd/HoQB9GoRPqnxPZ6/Hi7WcmHi5x0pUQYyASJGxKQLVwIjAxNk6tINWQcqo?=
 =?us-ascii?Q?D7w3Tth3Uz1+dEl/9gOgmZ+HcZJJRgOJkNoc2PgU0IrxC0ayPmx86Elo3kAc?=
 =?us-ascii?Q?DSGPqF8G8f9Ttn238MIQMvK4Y158pSSmO/7EzLNdSM2QVdFWFYOR8xMaeMrk?=
 =?us-ascii?Q?u9sGSg/CXiASMWPykQo6H7ammkTaxL5771FUUibBoU5oME04eWpePIQBJasT?=
 =?us-ascii?Q?IOynUt2BgCnfVkRTL/F0JCv6yVxWaemv4Kwc9OOG60FdOeunZV3Oi0iGho/y?=
 =?us-ascii?Q?ApD/FQKkI9o2RYOOkkoLgFfMIWg1aQqudgHsT7Z2m4Bc3iS46/hZphuQTAgg?=
 =?us-ascii?Q?aoy2cL4qFR7gFjnKspj8JlrA1wE/nqnHgsPrBz+0G1CsCBkgTvhuCu7B19/I?=
 =?us-ascii?Q?aIh0vEWk+fIAriI3z3sIyRutBPhusk25j06crMvCfnw2G8+PbmRqkmImATjE?=
 =?us-ascii?Q?jFvog4wp+fTNUVNAWqaYYvzE2d4cJ0Ouu/fPJJtl4jHxyjYIkvHbe20YcQDN?=
 =?us-ascii?Q?T7tlN6rri5qbbcANcY2OoTUfWJMbBYzAJ4i5kyRttRO0eCCeVoq3gxypyHQh?=
 =?us-ascii?Q?5NyMyqHnNR46UzvL4srUwYuS4TMQoqIB6G3h0Qu2VXzBfLYzfzZJwisLAuS3?=
 =?us-ascii?Q?q7VoH3zOmVtJqEzVuQsswsgcHR9u4rmHSaztOqaFck1+ThzpWynB/rNQCbG8?=
 =?us-ascii?Q?cRnIDbYnMg1AG71ueIdMKW6z2k/2VdtPc8DOwLRomkiN/fNyE5p66ZV2Q/L2?=
 =?us-ascii?Q?o83VcWIzZeJlCxbZ1oOFt9WmcZ+zMrz7lSWBKmsRHzSg++xzobRjmU4T3Qs6?=
 =?us-ascii?Q?FaeQe6yB+OUIFtEYG9DI6R8pSwQKGQLFUDs+1PvOnDTWY8X/xGNZCC/Q9Ulq?=
 =?us-ascii?Q?7ULY2ND14V/SJE8SMgzPxmedvfpMKzY/yKo0icccqRXG4TBLSxxXnhjEevh+?=
 =?us-ascii?Q?oveYnES0qbI50VzvCKgRoO5K9+HK5veCz9OsRZ5mW/bThzRVT3+8JZYgRInX?=
 =?us-ascii?Q?nORaQcF+Cpc6x12ByoFNYK1s7GHDQnaU3QbxLf9Usd54Z5CosS9BWniwcu8K?=
 =?us-ascii?Q?UxH0s/srcQ=3D=3D?=
X-Exchange-RoutingPolicyChecked: lH+tgrceZVFu7KUmo84+vrlAg1yIb4Cqeg4FCr7uZihGIVsSeSeaxpK9xO7Prj2RiyznmPSOofs5VPqixJFpRBZqKZDtFOIqB2JVG9Z7oVIiDdGkkIKzNVXwiQnGGKRw/xdMR4pXxinTZGGJXMN01dj7OIS6UICTLdHAkGMWwu9Kb0+CYkbi09+NNCfXGYchPjbYVMJ3DUoXkXJqO0G+9rDgGhF5R27f4FK7P4Ngg0GJGl/C3wtb1OiIDbKtyvzuNUHsBtWASDzcrDTJCmQpufXK7i225gMx7gI3t8djOhcyuOiwBO6rQRNtn7ksOB5Wn+HYMgbpbQb3c0HhoPTB3A==
X-MS-Exchange-CrossTenant-Network-Message-Id: af3238a3-6731-4310-36d3-08de84bff01b
X-MS-Exchange-CrossTenant-AuthSource: PH0PR11MB5832.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 18 Mar 2026 07:28:23.7072
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: j0FSx026ur7CAxtBV2/0f/MiXKjCBb7v8HkrdnIol/fhSk/yHvoWkH2XFV0xcuExlc7MUv/VBBVm7W4Hvtw62Q==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH3PR11MB7794
X-OriginatorOrg: intel.com
X-Spamd-Result: default: False [-0.16 / 15.00];
	ARC_REJECT(1.00)[cv is fail on i=2];
	DMARC_POLICY_ALLOW(-0.50)[intel.com,none];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	R_DKIM_ALLOW(-0.20)[intel.com:s=Intel];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	TAGGED_FROM(0.00)[bounces-268904-lists,netdev=lfdr.de];
	DKIM_TRACE(0.00)[intel.com:+];
	RCVD_TLS_LAST(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,intel.com:dkim,intel.com:email,intel.com:mid,01.org:url,altnames.sh:url,amt.sh:url];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[oliver.sang@intel.com,netdev@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	NEURAL_HAM(-0.00)[-1.000];
	RCPT_COUNT_SEVEN(0.00)[7];
	MID_RHS_MATCH_FROM(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	RCVD_COUNT_SEVEN(0.00)[10]
X-Rspamd-Queue-Id: 425732B6F33
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr



Hello,


kernel test robot noticed "kernel-selftests-bpf.net.tun.fail" on:

commit: 400e658aa096cda99b37ce806ed63cfe894c9566 ("selftest: tun: Add test for sending gso packet into tun")
https://git.kernel.org/cgit/linux/kernel/git/torvalds/linux.git master

[test failed on linus/master      80234b5ab240f52fa45d201e899e207b9265ef91]
[test failed on linux-next/master f90aadf1c67c8b4969d1e5e6d4fd7227adb6e4d7]

in testcase: kernel-selftests-bpf
version: 
with following parameters:

	group: net


config: x86_64-rhel-9.4-bpf
compiler: gcc-14
test machine: 36 threads 1 sockets Intel(R) Core(TM) i9-9980XE CPU @ 3.00GHz (Skylake) with 32G memory

(please refer to attached dmesg/kmsg for entire log/backtrace)


If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <oliver.sang@intel.com>
| Closes: https://lore.kernel.org/oe-lkp/202603181411.24db1a78-lkp@intel.com


# timeout set to 3600
# selftests: net: tun
# TAP version 13
# 1..9
# # Starting 9 tests from 5 test cases.
# #  RUN           tun.delete_detach_close ...
# #            OK  tun.delete_detach_close
# ok 1 tun.delete_detach_close
# #  RUN           tun.detach_delete_close ...
# #            OK  tun.detach_delete_close
# ok 2 tun.detach_delete_close
# #  RUN           tun.detach_close_delete ...
# #            OK  tun.detach_close_delete
# ok 3 tun.detach_close_delete
# #  RUN           tun.reattach_delete_close ...
# #            OK  tun.reattach_delete_close
# ok 4 tun.reattach_delete_close
# #  RUN           tun.reattach_close_delete ...
# #            OK  tun.reattach_close_delete
# ok 5 tun.reattach_close_delete
# #  RUN           tun_vnet_udptnl.4in4_1mss.send_gso_packet ...
# #            OK  tun_vnet_udptnl.4in4_1mss.send_gso_packet
# ok 6 tun_vnet_udptnl.4in4_1mss.send_gso_packet
# #  RUN           tun_vnet_udptnl.6in4_1mss.send_gso_packet ...
# # tun.c:679:send_gso_packet:Expected ret (0) == variant->data_size (1402)
# # send_gso_packet: Test terminated by assertion
# #          FAIL  tun_vnet_udptnl.6in4_1mss.send_gso_packet
# not ok 7 tun_vnet_udptnl.6in4_1mss.send_gso_packet
# #  RUN           tun_vnet_udptnl.4in6_1mss.send_gso_packet ...
# # tun.c:679:send_gso_packet:Expected ret (0) == variant->data_size (1402)
# # send_gso_packet: Test terminated by assertion
# #          FAIL  tun_vnet_udptnl.4in6_1mss.send_gso_packet
# not ok 8 tun_vnet_udptnl.4in6_1mss.send_gso_packet
# #  RUN           tun_vnet_udptnl.6in6_1mss.send_gso_packet ...
# # tun.c:679:send_gso_packet:Expected ret (0) == variant->data_size (1382)
# # send_gso_packet: Test terminated by assertion
# #          FAIL  tun_vnet_udptnl.6in6_1mss.send_gso_packet
# not ok 9 tun_vnet_udptnl.6in6_1mss.send_gso_packet
# # FAILED: 6 / 9 tests passed.
# # Totals: pass:6 fail:3 xfail:0 xpass:0 skip:0 error:0
not ok 19 selftests: net: tun # exit=1
/bin/sh: 50: cannot create : Directory nonexistent
# timeout set to 3600
# selftests: net: altnames.sh
# TEST: altnames test                                                 [ OK ]
ok 20 selftests: net: altnames.sh
# timeout set to 3600
# selftests: net: amt.sh
# exec of "smcrouted" failed: No such file or directory
ok 21 selftests: net: amt.sh # SKIP
# timeout set to 3600



below [1] is from parent commit as a comparison.


The kernel config and materials to reproduce are available at:
https://download.01.org/0day-ci/archive/20260318/202603181411.24db1a78-lkp@intel.com



[1] from parent commit:
# timeout set to 3600
# selftests: net: tun
# TAP version 13
# 1..9
# # Starting 9 tests from 5 test cases.
# #  RUN           tun.delete_detach_close ...
# #            OK  tun.delete_detach_close
# ok 1 tun.delete_detach_close
# #  RUN           tun.detach_delete_close ...
# #            OK  tun.detach_delete_close
# ok 2 tun.detach_delete_close
# #  RUN           tun.detach_close_delete ...
# #            OK  tun.detach_close_delete
# ok 3 tun.detach_close_delete
# #  RUN           tun.reattach_delete_close ...
# #            OK  tun.reattach_delete_close
# ok 4 tun.reattach_delete_close
# #  RUN           tun.reattach_close_delete ...
# #            OK  tun.reattach_close_delete
# ok 5 tun.reattach_close_delete
# #  RUN           tun_vnet_udptnl.4in4udptnl.basic ...
# #            OK  tun_vnet_udptnl.4in4udptnl.basic
# ok 6 tun_vnet_udptnl.4in4udptnl.basic
# #  RUN           tun_vnet_udptnl.6in4udptnl.basic ...
# #            OK  tun_vnet_udptnl.6in4udptnl.basic
# ok 7 tun_vnet_udptnl.6in4udptnl.basic
# #  RUN           tun_vnet_udptnl.4in6udptnl.basic ...
# #            OK  tun_vnet_udptnl.4in6udptnl.basic
# ok 8 tun_vnet_udptnl.4in6udptnl.basic
# #  RUN           tun_vnet_udptnl.6in6udptnl.basic ...
# #            OK  tun_vnet_udptnl.6in6udptnl.basic
# ok 9 tun_vnet_udptnl.6in6udptnl.basic
# # PASSED: 9 / 9 tests passed.
# # Totals: pass:9 fail:0 xfail:0 xpass:0 skip:0 error:0
ok 19 selftests: net: tun



-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki


