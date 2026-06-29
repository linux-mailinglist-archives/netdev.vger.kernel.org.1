Return-Path: <netdev+bounces-302811-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id coJXAk3CQmopAwoAu9opvQ
	(envelope-from <netdev+bounces-302811-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Mon, 29 Jun 2026 21:06:53 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 5066F6DE343
	for <lists+netdev@lfdr.de>; Mon, 29 Jun 2026 21:06:52 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=intel.com header.s=Intel header.b=V7pBbPN3;
	spf=pass (mail.lfdr.de: domain of "netdev+bounces-302811-lists+netdev=lfdr.de@vger.kernel.org" designates 2600:3c0a:e001:db::12fc:5321 as permitted sender) smtp.mailfrom="netdev+bounces-302811-lists+netdev=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=none) header.from=intel.com;
	arc=reject ("cv is fail on i=2")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 03CF03010508
	for <lists+netdev@lfdr.de>; Mon, 29 Jun 2026 19:06:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 897FE2EE611;
	Mon, 29 Jun 2026 19:06:39 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8ED2B2D9484;
	Mon, 29 Jun 2026 19:06:36 +0000 (UTC)
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782759999; cv=fail; b=JXzfJ/pIFO0iTAWnP5pFkuNjMR243D+b8xJm/Zd1LnuERe7o5fJ1AE8GIHTONnNPHQRv3M76WnIPP3HbrXgodWI+Ngxfuk1rVbh7oCnN/fZI0iZtnS28uqWtT2dBBo69XUGJQuwUHU8/CUVfbk6f/Yg6BS0aO0l9WBygxzPJPzY=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782759999; c=relaxed/simple;
	bh=f/oQdqsEtq7UNgh/hHRkfqVwvGUL7TWAhuFPaAjAZWs=;
	h=Date:From:To:CC:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=sstwB3LMxn1Sln088yMtoQilshQIc2e6+J/NjDhffcFxzl0LYU5he4J0MctHt4NGCqduUa3NkeLOIButeIZtMgRh69iOeCQ0xJEcOm3wywCH024FUN2uO0YB1y6LRHtXEF6MWQBh5VWMhydD0GG+AQYrdrcHjbxXwwc+n2KZs0k=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=V7pBbPN3; arc=fail smtp.client-ip=198.175.65.17
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1782759997; x=1814295997;
  h=date:from:to:cc:subject:message-id:references:
   in-reply-to:mime-version;
  bh=f/oQdqsEtq7UNgh/hHRkfqVwvGUL7TWAhuFPaAjAZWs=;
  b=V7pBbPN3i5lH/S+bXRPPqsQqm3BnJlE/ag9N3kvKRWrqxcfR4AoPT1gU
   oa0lbg5EHoMhJnz2X/KGPjrtLCPQzIor6eXUYeWzfqDSKUpEjVQUS00ca
   k11NFYytCVR/Hr/eftPnP65VYYmAZDEx7/cds3f7KDnxd3Lyo72TZ4vgQ
   RNDLwVPhwjhgaNFDb5Cdcf3fN9UY/GGXygmOqy9o2wWGwYOYWXAELH/4l
   WD6+sZvJSN8l3PI+iPSp2OueUjoyFLpaZUsgg/CZe7VE0EE5AwSfnGBTs
   l6l9mBeMRtiypKNY1tn0quCJCsf0lTF4pXUisoMn/CHoj5MZU8oPbrGXW
   g==;
X-CSE-ConnectionGUID: hJj24eeJT5Ws66W9Mgagtw==
X-CSE-MsgGUID: YNYtLwIMQsuoDJxs/1NJqw==
X-IronPort-AV: E=McAfee;i="6800,10657,11832"; a="83491646"
X-IronPort-AV: E=Sophos;i="6.24,232,1774335600"; 
   d="scan'208";a="83491646"
Received: from fmviesa003.fm.intel.com ([10.60.135.143])
  by orvoesa109.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 29 Jun 2026 12:06:37 -0700
X-CSE-ConnectionGUID: uN1EJhL6S5+DCaut0pQ0DQ==
X-CSE-MsgGUID: dDVCBt9TRXKabW7OZOgKdg==
X-ExtLoop1: 1
Received: from orsmsx903.amr.corp.intel.com ([10.22.229.25])
  by fmviesa003.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 29 Jun 2026 12:06:35 -0700
Received: from ORSMSX902.amr.corp.intel.com (10.22.229.24) by
 ORSMSX903.amr.corp.intel.com (10.22.229.25) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.43; Mon, 29 Jun 2026 12:06:35 -0700
Received: from ORSEDG902.ED.cps.intel.com (10.7.248.12) by
 ORSMSX902.amr.corp.intel.com (10.22.229.24) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.43 via Frontend Transport; Mon, 29 Jun 2026 12:06:35 -0700
Received: from PH7PR06CU001.outbound.protection.outlook.com (52.101.201.26) by
 edgegateway.intel.com (134.134.137.112) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.43; Mon, 29 Jun 2026 12:06:34 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=haAdaHbFKXcZo3wKwZVeNRgtCCHya0owRiYT0SxpGZpXPHANcj9fmeiho1QrlAN1H7D9c2J1B8WkIJ0GRVfGrdTf7Ax/w4fvf/UOSIhPX7HUA7OgXIfoMcDWsQ7dgJum/lTAsg1Lijbev9AphHD53XL/T6dZx8aRyoP2EW5b4/9QrbVzwZkc5HMZ6sPozb2v/cL+n6TJh8d2orzsfRUJJjRCzLZ7SjyL07v98AdJRliDwwK33ifU02eW6nVamurx8lpiiUrOLcnOxhek7fsY7G+dWZ76Y3B2c3QGLWjrl6lPJ6X+zQN1Ly7WG6wMZmwQvl+U9GGI2yy14TJUmYiozQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=L/dBkcvyd+1sya+qAZgx4IILQIlm0NrQ8hceGUio8gc=;
 b=g7rTDw76H2IMiXRASb78WGOLc29KJsrrw5t9rR0FSbY8ZqCgOfiVEdcCzJ0R1iumMIZOUYbJpjdkb8HpZrI81K98s5ePERQznIGTSrWj1MJb8+7JCJ4tYtnpA1PO2zFw8zrT7s9WiJaN1RzMCWZjNTW9J47lYgZaiZItOBAdsFlrpJ5Ai8QbLzzxoraN7XuOuCAVsQj/ZW3CYysw+ZyLOKoZFkIRufCl56O+Pxl9NyzfFOcxq0/dRJRK9T5b9/1Qom7v3PlpA7smoQMykEOCOnd0xBsW1KffzHsF6SdcCWK9azgpCR0p2QBU4eC+VU91dF5XadCmOpretroaKQoUvg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from DM4SPRMB0045.namprd11.prod.outlook.com (2603:10b6:8:6e::21) by
 SA1PR11MB9682.namprd11.prod.outlook.com (2603:10b6:806:4df::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.159.19; Mon, 29 Jun
 2026 19:06:32 +0000
Received: from DM4SPRMB0045.namprd11.prod.outlook.com
 ([fe80::b630:ca9c:20e1:f485]) by DM4SPRMB0045.namprd11.prod.outlook.com
 ([fe80::b630:ca9c:20e1:f485%6]) with mapi id 15.21.0159.018; Mon, 29 Jun 2026
 19:06:32 +0000
Date: Mon, 29 Jun 2026 21:06:25 +0200
From: Maciej Fijalkowski <maciej.fijalkowski@intel.com>
To: <netdev@vger.kernel.org>
CC: <bpf@vger.kernel.org>, <magnus.karlsson@intel.com>,
	<stfomichev@gmail.com>, <kuba@kernel.org>, <pabeni@redhat.com>,
	<horms@kernel.org>, <kerneljasonxing@gmail.com>, <bjorn@kernel.org>
Subject: Re: [PATCH net 5/7] xsk: reclaim invalid multi-buffer Tx descs in ZC
 path
Message-ID: <akLCMYoVilZJZEC1@boxer>
References: <20260623133240.1048434-1-maciej.fijalkowski@intel.com>
 <20260623133240.1048434-6-maciej.fijalkowski@intel.com>
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <20260623133240.1048434-6-maciej.fijalkowski@intel.com>
X-ClientProxiedBy: MI2PEPF00000B80.ITAP293.PROD.OUTLOOK.COM
 (2603:10a6:298:1::417) To DM4SPRMB0045.namprd11.prod.outlook.com
 (2603:10b6:8:6e::21)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM4SPRMB0045:EE_|SA1PR11MB9682:EE_
X-MS-Office365-Filtering-Correlation-Id: 8e9e5516-f8ea-4186-414e-08ded611882c
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|23010399003|366016|1800799024|376014|56012099006|4143699003|11063799006|6133799003|22082099003|18002099003;
X-Microsoft-Antispam-Message-Info: 4sjlEwguW/yriW0W0B0K9f+QITsTZyTRsbWa6rIAOWTySeOwuPCg2/l210pKwkXtstpYWM3pkpHYMbbI0+rWRRzeU2JIAL2PBJvOYoo833kVhI21ScHLhMDySNLcqFnDkLvd9jKICnqm9cuzGcHBArfbVliCZ5VKmprCpIFQo5xYLWv24j2wAt6FZkfXCH+6wDhcK+Yx/tVpAWLu+jp+TIWrJJuwM92nlXPHWLF8wcQ37rtMs0sF/cCLfAf4vmPWkgMaD5Y2mflDC6/wPvHTp/t9EvNLjNgwUdTpYWh8fGgJHkCqgcyonyeo0rbBSvN74BRqsdz1x2dTykWvDdEH9PITvr34zOM8jReEIDBIcgQiOBgak6CYbjlbAV+oDmCGqozbD8qjy/nm8gax7yVx05VihiTm3FQpIpt72m7n+G79LQgSrMawZia7y8m7ceVQCQwL88AJ7wVfgXG9lTkSlPpDUhC9mcP9zywRJ5KIkapBixPt5cRT/+2I2JKr/d9xpoYOL4PrSPCVSNJNqHpfvUVy+8VwK2e+D9w0Yo4GTcbAZmGDjTnrZrci1ebL6e4fdD8AMcizRv+rUZBOVCbxqz4rWeHY2jtyT7clRHkRtTri+T/l9mX9SluYkZjyeejWfJhnjoRG3A+Xk6rCDGsfNDBkbxVcIsOsQNli5MRPoPg=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM4SPRMB0045.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(23010399003)(366016)(1800799024)(376014)(56012099006)(4143699003)(11063799006)(6133799003)(22082099003)(18002099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?gLuS7M36TlhEX9HidQPPyC//8F6J/Rd5AleNJBTfQeYt6/M52hDVanWn5Imt?=
 =?us-ascii?Q?FpleaKKogNZ4F1Gwgf7BIRP2TJtvZ771ht2CmBqaIzB4l0TegmSFddFdlrkY?=
 =?us-ascii?Q?padSoDH1L91GCaTZshpKFe5EnqkMzOG9kqUB7TZA42lyCa3E9rn1/Ybl8civ?=
 =?us-ascii?Q?TLUoktwlslRbuf9rJt7dHZVyrpQX3yvcP4BZWaUppODixTNTEhU8Bxz95RtF?=
 =?us-ascii?Q?mBdZbCX7gkFL8o3pxFxgrSf+vY8HduX6rny9ufwnsoKnpWqZQRiqYn1eP6zl?=
 =?us-ascii?Q?+augTVbyPvdTDpC9TcWkYv5UKhBRI/P/OIYVszjTUkEt+cRnF6gojn/573p8?=
 =?us-ascii?Q?wlbwqOQG/CAxB7p1HA1KxYmSp5ElFSQATNHGVXVurFcDHUuq6nqnpw11mubs?=
 =?us-ascii?Q?i2o/2FgPvx99Jk+gpdclKcy8KB03wdlA+ee0TqYETXeCbt631O26ZI19qDPO?=
 =?us-ascii?Q?bLoiYpXacN6+Cfav6GSBCH3AWh/UAMfjzpsIcMexwbYIUI6ubJ43JlFbscWX?=
 =?us-ascii?Q?NSXXTXyLfsxRWxEdF43imEJR8rqLUZlkMLb30Q71n01XPLH0kOw2Fc7fLJq5?=
 =?us-ascii?Q?Bh9EThJhiOXfg/zdJKrEJVRP5+pmjNm4nTub0fnY/N3IVh+E71TaY6xTmn9V?=
 =?us-ascii?Q?AeqBu2A3AACHUK49aJ9LWoogu6MHJ9zBccBELbz9k8L+G1QvNSN0fzJx+ysW?=
 =?us-ascii?Q?Dr1R1wtCw0spvA/hJNqfcdDplUwYqFzsR2FDFXDK1q5IafBSvl1lxQxZnd5J?=
 =?us-ascii?Q?wqTrH7DE0P5HpJzfSCrpoa4R9lVuiHdwpyBIfgS2FmtKOR0rjwGIigkk7l4a?=
 =?us-ascii?Q?K303tw0b6+wiM02cyjuu36VXjw4RdKvZ2NRF2Em1stK0SUYkA5zp+TC6ldR0?=
 =?us-ascii?Q?c50I4t+xVoTdHKmaAgbAUTJKFyYv/yUDkb2gRxuX45MTCsy+gS1TDZfaMjTG?=
 =?us-ascii?Q?Az6NDjGpDEjkivBAwsF+cr44hYo2eSPU/qGqkWF0Px1mnbpBCtj7OUz16P/Y?=
 =?us-ascii?Q?pk1PgY1ucC8GWyUQrZXpRPnIuy975M4LKpnZkxdMUgjfQAXpkwf5TC7eisyT?=
 =?us-ascii?Q?7f/kHLZpXf0OP/wpJNwNkBi4hiPSZWjI1gdfELgeiAxII1L9BYwGb4noJ1AX?=
 =?us-ascii?Q?JjKpY1ey6BWQuweYj0SE7owjNJKaGbziW3M7LXbWz70X+d4RE9/sXyagAzzh?=
 =?us-ascii?Q?cOt+01d2bRHG9ahNxmVUt/KEiSMfWbeQmGYTey8kj3H0S/o8EbNhzadrd8a0?=
 =?us-ascii?Q?HASjFFSY1ZIBxyPXfPaLD2Xb7rVgY+VD9elEqGpkr0Nrqo03kwDosamCdnpQ?=
 =?us-ascii?Q?SDFTZRkPZw2gRSdfjq/EmusxbcaA1zjKCdIYTgti9YmtrHadKq3k5Zwp/LKi?=
 =?us-ascii?Q?CEKMLQxjXcl2rK6fPRPJXPr2Gz+HW1MKz8ZkjAh7Iv6WTfWGBo080TB2y5si?=
 =?us-ascii?Q?a1o6+s4dbTeBJrcEn1f5emBHoJDSGDHij6O/72UZozX7et/uwTatGeinitK+?=
 =?us-ascii?Q?BdbFq/eyrelngwAInCgRfkZ6g+Z5oFulj9zCGBsJlLC4hV6Sq3L77b31aR2d?=
 =?us-ascii?Q?vU/QspAXdUjMbRyy1ZFur8zAxg93M15B3YXN5xb4i7Rgby9Gj1Od5vQNIyGk?=
 =?us-ascii?Q?VAtofX7cOGSY8DMyHuWXuQM99iI1NBefeeSpFpam6thgcGmpE4dp9Ux1IJ8Q?=
 =?us-ascii?Q?h+MJdNdxxssW+tdFdGPwjtQ2LBxbLVPGWQWx1e2A+biSzy6AQ5rZOiASkTmT?=
 =?us-ascii?Q?3V8mSONczXJa1t6VgBpvKtlWiZbFpoM=3D?=
X-Exchange-RoutingPolicyChecked: KotqJtZgdf+8tL682/af2LcEWURKr2k9bbl2qTI1Hriok0QuI4YOBYnXwNbRyuhqToiNKGn5ndNV228xlAjcuZ2bYjvIKgzqQklzYhwnzcEYg6jd9GZjpl6GAnh1HVu6Ho0RYDqDXDMOeJAPrLRnZlssNpm/RStnKn0xDy9BUZmaRqtxsqYNf0mrGtPo9xORjInxvvRDGSV7DLqo8YkPn5EetOP2AoHZrd+u/8kH7SQvAJyS8cxSALe4O+KIAnt7aJgb28ziJqbf367EuMHE6BKGk2U60rXl6iZAdZ0w5C0bZoZoAhQ7wvELSCjfPklIQkCwLpaM60KWMdzR1LBkLQ==
X-MS-Exchange-CrossTenant-Network-Message-Id: 8e9e5516-f8ea-4186-414e-08ded611882c
X-MS-Exchange-CrossTenant-AuthSource: DM4SPRMB0045.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 29 Jun 2026 19:06:32.2615
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 0eZj7HAZ5rl+tPBFh9yFQRouy5yK/oqGjz062WptAOmnZhEQhrNZVpryZaYzDIZB++gNzwsyR5ozapCJUAAM0evLNICUsbU++5Y81IKftfw=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA1PR11MB9682
X-OriginatorOrg: intel.com
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-2.66 / 15.00];
	WHITELIST_SPF_DKIM(-3.00)[intel.com:d:+,kernel.org:s:+];
	ARC_REJECT(1.00)[cv is fail on i=2];
	MID_RHS_NOT_FQDN(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[intel.com,none];
	R_DKIM_ALLOW(-0.20)[intel.com:s=Intel];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-302811-lists,netdev=lfdr.de];
	FREEMAIL_CC(0.00)[vger.kernel.org,intel.com,gmail.com,kernel.org,redhat.com];
	RCVD_TLS_LAST(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[intel.com:dkim,intel.com:email,intel.com:from_mime,boxer:mid,sea.lore.kernel.org:rdns,sea.lore.kernel.org:helo,vger.kernel.org:from_smtp];
	FORGED_SENDER(0.00)[maciej.fijalkowski@intel.com,netdev@vger.kernel.org];
	FORGED_RECIPIENTS(0.00)[m:netdev@vger.kernel.org,m:bpf@vger.kernel.org,m:magnus.karlsson@intel.com,m:stfomichev@gmail.com,m:kuba@kernel.org,m:pabeni@redhat.com,m:horms@kernel.org,m:kerneljasonxing@gmail.com,m:bjorn@kernel.org,s:lists@lfdr.de];
	FORWARDED(0.00)[lists@lfdr.de];
	FORGED_SENDER_MAILLIST(0.00)[];
	DKIM_TRACE(0.00)[intel.com:+];
	MISSING_XM_UA(0.00)[];
	MIME_TRACE(0.00)[0:+];
	PRECEDENCE_BULK(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[maciej.fijalkowski@intel.com,netdev@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_NONE(0.00)[];
	RCPT_COUNT_SEVEN(0.00)[9];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	ALIAS_RESOLVED(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	RCVD_COUNT_SEVEN(0.00)[10]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 5066F6DE343

On Tue, Jun 23, 2026 at 03:32:38PM +0200, Maciej Fijalkowski wrote:
> Currently, the zero-copy Tx batching path stops when it encounters an
> invalid descriptor. For multi-buffer packets this can leave descriptors
> consumed from the Tx ring without returning their buffers to userspace
> through the completion ring.
> 
> Handle invalid multi-buffer packets as a packet-sized unit. Keep
> descriptors that are valid for transmission separate from descriptors
> that are consumed only because they belong to an invalid multi-buffer
> packet. The former are returned to the driver as Tx work, while the
> latter are written to the CQ address area so they can be reclaimed by
> userspace.
> 
> The batched path can retain drain state when the producer has not yet
> supplied the end of an invalid packet. Do not allow a second Tx socket to
> join the pool while such state exists. Gate the batched data path while a
> same-pool bind waits for pre-existing readers, then either add the new
> socket or fail the bind with -EAGAIN. This guarantees that drain state is
> handled only by the singular batched path and avoids teaching the shared
> UMEM fallback path about multi-buffer packet draining.

Well I think this approach is broken unfortunately. Second socket still
can submit too big packet or invalid descriptor within multi-buffer
packet. Then fallback path would not handle it correctly.

Seems we need to teach it how to play with these corner cases.

> 
> The reclaim-only descriptors must not be submitted to the completion
> ring immediately when they follow real Tx descriptors in the same batch.
> Drivers may complete only part of the Tx work returned by
> xsk_tx_peek_release_desc_batch(), and publishing the reclaim descriptors
> too early would also publish earlier real Tx descriptors that the driver
> has not completed yet.
> 
> Track the number of driver-visible Tx descriptors that precede pending
> reclaim descriptors. xsk_tx_completed() first advances through the real
> Tx completions and submits the reclaim descriptors only after all earlier
> Tx descriptors in the CQ address order have been completed. If a batch
> contains only reclaim descriptors, complete them immediately because
> there is no driver-visible Tx work in front of them.
> 
> This preserves CQ ordering while ensuring that every descriptor consumed
> as part of an invalid multi-buffer packet is eventually returned to
> userspace.
> 
> Fixes: cf24f5a5feea ("xsk: add support for AF_XDP multi-buffer on Tx path")
> Signed-off-by: Maciej Fijalkowski <maciej.fijalkowski@intel.com>
> ---
>  include/net/xsk_buff_pool.h |  6 ++++
>  net/xdp/xsk.c               | 62 +++++++++++++++++++++++++++++++---
>  net/xdp/xsk_buff_pool.c     | 66 +++++++++++++++++++++++++++++++++++++
>  net/xdp/xsk_queue.h         | 66 +++++++++++++++++++++++++++----------
>  4 files changed, 177 insertions(+), 23 deletions(-)
> 
> diff --git a/include/net/xsk_buff_pool.h b/include/net/xsk_buff_pool.h
> index ccb3b350001f..4e5abacfcbb7 100644
> --- a/include/net/xsk_buff_pool.h
> +++ b/include/net/xsk_buff_pool.h
> @@ -78,9 +78,12 @@ struct xsk_buff_pool {
>  	u32 chunk_size;
>  	u32 chunk_shift;
>  	u32 frame_len;
> +	u32 reclaim_descs;
> +	u32 tx_zc_pending_descs;
>  	u32 xdp_zc_max_segs;
>  	u8 tx_metadata_len; /* inherited from umem */
>  	u8 cached_need_wakeup;
> +	bool tx_share_pending;
>  	bool uses_need_wakeup;
>  	bool unaligned;
>  	bool tx_sw_csum;
> @@ -113,6 +116,9 @@ void xp_get_pool(struct xsk_buff_pool *pool);
>  bool xp_put_pool(struct xsk_buff_pool *pool);
>  void xp_clear_dev(struct xsk_buff_pool *pool);
>  void xp_add_xsk(struct xsk_buff_pool *pool, struct xdp_sock *xs);
> +int xp_prepare_xsk_tx_share(struct xsk_buff_pool *pool, struct xdp_sock *xs,
> +			    bool *pending);
> +void xp_finish_xsk_tx_share(struct xsk_buff_pool *pool);
>  void xp_del_xsk(struct xsk_buff_pool *pool, struct xdp_sock *xs);
>  
>  /* AF_XDP, and XDP core. */
> diff --git a/net/xdp/xsk.c b/net/xdp/xsk.c
> index 43791647cf18..2dda854c6590 100644
> --- a/net/xdp/xsk.c
> +++ b/net/xdp/xsk.c
> @@ -499,6 +499,18 @@ void __xsk_map_flush(struct list_head *flush_list)
>  
>  void xsk_tx_completed(struct xsk_buff_pool *pool, u32 nb_entries)
>  {
> +	if (unlikely(pool->reclaim_descs)) {
> +		if (nb_entries < pool->tx_zc_pending_descs) {
> +			pool->tx_zc_pending_descs -= nb_entries;
> +			xskq_prod_submit_n(pool->cq, nb_entries);
> +			return;
> +		}
> +
> +		pool->tx_zc_pending_descs = 0;
> +		nb_entries += pool->reclaim_descs;
> +		pool->reclaim_descs = 0;
> +	}
> +
>  	xskq_prod_submit_n(pool->cq, nb_entries);
>  }
>  EXPORT_SYMBOL(xsk_tx_completed);
> @@ -576,9 +588,20 @@ static u32 xsk_tx_peek_release_fallback(struct xsk_buff_pool *pool, u32 max_entr
>  
>  u32 xsk_tx_peek_release_desc_batch(struct xsk_buff_pool *pool, u32 nb_pkts)
>  {
> +	struct xsk_tx_batch batch = {};
>  	struct xdp_sock *xs;
> +	u32 cq_cached_prod;
>  
>  	rcu_read_lock();
> +
> +	/* Pairs with the release stores in xp_prepare_xsk_tx_share() and
> +	 * xp_finish_xsk_tx_share(). If bind is converting a singular Tx pool
> +	 * to shared, do not enter the singular batched path.
> +	 */
> +	if (smp_load_acquire(&pool->tx_share_pending))
> +		goto out;
> +	if (unlikely(pool->reclaim_descs))
> +		goto out;
>  	if (!list_is_singular(&pool->xsk_tx_list)) {
>  		/* Fallback to the non-batched version */
>  		rcu_read_unlock();
> @@ -586,10 +609,8 @@ u32 xsk_tx_peek_release_desc_batch(struct xsk_buff_pool *pool, u32 nb_pkts)
>  	}
>  
>  	xs = list_first_or_null_rcu(&pool->xsk_tx_list, struct xdp_sock, tx_list);
> -	if (!xs) {
> -		nb_pkts = 0;
> +	if (!xs)
>  		goto out;
> -	}
>  
>  	nb_pkts = xskq_cons_nb_entries(xs->tx, nb_pkts);
>  
> @@ -603,19 +624,38 @@ u32 xsk_tx_peek_release_desc_batch(struct xsk_buff_pool *pool, u32 nb_pkts)
>  	if (!nb_pkts)
>  		goto out;
>  
> -	nb_pkts = xskq_cons_read_desc_batch(xs->tx, pool, nb_pkts);
> +	batch = xskq_cons_read_desc_batch(xs, pool, nb_pkts);
> +	nb_pkts = xsk_tx_batch_cq_descs(&batch);
>  	if (!nb_pkts) {
>  		xs->tx->queue_empty_descs++;
>  		goto out;
>  	}
>  
>  	__xskq_cons_release(xs->tx);
> +	cq_cached_prod = pool->cq->cached_prod;
> +
>  	xskq_prod_write_addr_batch(pool->cq, pool->tx_descs, nb_pkts);
> +
> +	if (unlikely(batch.reclaim_descs)) {
> +		u32 cq_pending_descs;
> +
> +		/* CQ is positional. Descriptors already written but not
> +		 * submitted must complete before any reclaim-only descriptors
> +		 * appended below.
> +		 */
> +		cq_pending_descs = cq_cached_prod - xskq_get_prod(pool->cq);
> +
> +		pool->tx_zc_pending_descs = batch.tx_descs + cq_pending_descs;
> +		pool->reclaim_descs = batch.reclaim_descs;
> +		if (unlikely(!pool->tx_zc_pending_descs))
> +			xsk_tx_completed(pool, 0);
> +	}
> +
>  	xs->sk.sk_write_space(&xs->sk);
>  
>  out:
>  	rcu_read_unlock();
> -	return nb_pkts;
> +	return batch.tx_descs;
>  }
>  EXPORT_SYMBOL(xsk_tx_peek_release_desc_batch);
>  
> @@ -1442,6 +1482,7 @@ static int xsk_bind(struct socket *sock, struct sockaddr_unsized *addr, int addr
>  	struct sockaddr_xdp *sxdp = (struct sockaddr_xdp *)addr;
>  	struct sock *sk = sock->sk;
>  	struct xdp_sock *xs = xdp_sk(sk);
> +	bool tx_share_pending = false;
>  	struct net_device *dev;
>  	int bound_dev_if;
>  	u32 flags, qid;
> @@ -1549,6 +1590,13 @@ static int xsk_bind(struct socket *sock, struct sockaddr_unsized *addr, int addr
>  				goto out_unlock;
>  			}
>  
> +			err = xp_prepare_xsk_tx_share(umem_xs->pool, xs,
> +						      &tx_share_pending);
> +			if (err) {
> +				sockfd_put(sock);
> +				goto out_unlock;
> +			}
> +
>  			xp_get_pool(umem_xs->pool);
>  			xs->pool = umem_xs->pool;
>  
> @@ -1559,6 +1607,8 @@ static int xsk_bind(struct socket *sock, struct sockaddr_unsized *addr, int addr
>  			if (xs->tx && !xs->pool->tx_descs) {
>  				err = xp_alloc_tx_descs(xs->pool, xs);
>  				if (err) {
> +					if (tx_share_pending)
> +						xp_finish_xsk_tx_share(xs->pool);
>  					xp_put_pool(xs->pool);
>  					xs->pool = NULL;
>  					sockfd_put(sock);
> @@ -1598,6 +1648,8 @@ static int xsk_bind(struct socket *sock, struct sockaddr_unsized *addr, int addr
>  	xs->sg = !!(xs->umem->flags & XDP_UMEM_SG_FLAG);
>  	xs->queue_id = qid;
>  	xp_add_xsk(xs->pool, xs);
> +	if (tx_share_pending)
> +		xp_finish_xsk_tx_share(xs->pool);
>  
>  	if (qid < dev->real_num_rx_queues) {
>  		struct netdev_rx_queue *rxq;
> diff --git a/net/xdp/xsk_buff_pool.c b/net/xdp/xsk_buff_pool.c
> index 1f28a9641571..6fa732a843a9 100644
> --- a/net/xdp/xsk_buff_pool.c
> +++ b/net/xdp/xsk_buff_pool.c
> @@ -22,6 +22,72 @@ void xp_add_xsk(struct xsk_buff_pool *pool, struct xdp_sock *xs)
>  	spin_unlock(&pool->xsk_tx_list_lock);
>  }
>  
> +int xp_prepare_xsk_tx_share(struct xsk_buff_pool *pool, struct xdp_sock *xs,
> +			    bool *pending)
> +{
> +	struct xdp_sock *tmp;
> +	int err = 0;
> +
> +	*pending = false;
> +	if (!xs->tx)
> +		return 0;
> +
> +	spin_lock(&pool->xsk_tx_list_lock);
> +	if (!list_is_singular(&pool->xsk_tx_list)) {
> +		spin_unlock(&pool->xsk_tx_list_lock);
> +		return 0;
> +	}
> +
> +	if (pool->tx_share_pending) {
> +		spin_unlock(&pool->xsk_tx_list_lock);
> +		return -EAGAIN;
> +	}
> +
> +	/* Pairs with the acquire load in xsk_tx_peek_release_desc_batch().
> +	 * Stop new singular batched Tx readers before synchronize_net()
> +	 * waits for readers that may already have observed a singular list.
> +	 */
> +	smp_store_release(&pool->tx_share_pending, true);
> +	*pending = true;
> +	spin_unlock(&pool->xsk_tx_list_lock);
> +
> +	/* A batch that observed a singular Tx socket list before the gate was
> +	 * armed may set drain_cont. Wait for all such readers before checking
> +	 * whether the pool can safely become shared.
> +	 */
> +	synchronize_net();
> +
> +	spin_lock(&pool->xsk_tx_list_lock);
> +	list_for_each_entry(tmp, &pool->xsk_tx_list, tx_list) {
> +		if (READ_ONCE(tmp->drain_cont)) {
> +			err = -EAGAIN;
> +			break;
> +		}
> +	}
> +
> +	if (err) {
> +		/* Pairs with the acquire load in xsk_tx_peek_release_desc_batch().
> +		 * No socket was added; clear the gate so Tx can resume.
> +		 */
> +		smp_store_release(&pool->tx_share_pending, false);
> +		*pending = false;
> +	}
> +	spin_unlock(&pool->xsk_tx_list_lock);
> +
> +	return err;
> +}
> +
> +void xp_finish_xsk_tx_share(struct xsk_buff_pool *pool)
> +{
> +	spin_lock(&pool->xsk_tx_list_lock);
> +	/* Pairs with the acquire load in xsk_tx_peek_release_desc_batch().
> +	 * Publish the preceding xp_add_xsk() list update before allowing Tx
> +	 * to observe that the share transition has finished.
> +	 */
> +	smp_store_release(&pool->tx_share_pending, false);
> +	spin_unlock(&pool->xsk_tx_list_lock);
> +}
> +
>  void xp_del_xsk(struct xsk_buff_pool *pool, struct xdp_sock *xs)
>  {
>  	if (!xs->tx)
> diff --git a/net/xdp/xsk_queue.h b/net/xdp/xsk_queue.h
> index 3e3fbb73d23e..99fa62e0d337 100644
> --- a/net/xdp/xsk_queue.h
> +++ b/net/xdp/xsk_queue.h
> @@ -58,6 +58,16 @@ struct parsed_desc {
>  	u32 valid;
>  };
>  
> +struct xsk_tx_batch {
> +	u32 tx_descs;
> +	u32 reclaim_descs;
> +};
> +
> +static inline u32 xsk_tx_batch_cq_descs(const struct xsk_tx_batch *batch)
> +{
> +	return batch->tx_descs + batch->reclaim_descs;
> +}
> +
>  /* The structure of the shared state of the rings are a simple
>   * circular buffer, as outlined in
>   * Documentation/core-api/circular-buffers.rst. For the Rx and
> @@ -263,17 +273,19 @@ static inline void parse_desc(struct xsk_queue *q, struct xsk_buff_pool *pool,
>  	parsed->mb = xp_mb_desc(desc);
>  }
>  
> -static inline
> -u32 xskq_cons_read_desc_batch(struct xsk_queue *q, struct xsk_buff_pool *pool,
> -			      u32 max)
> +static inline struct xsk_tx_batch
> +xskq_cons_read_desc_batch(struct xdp_sock *xs, struct xsk_buff_pool *pool,
> +			  u32 max)
>  {
> -	u32 cached_cons = q->cached_cons, nb_entries = 0;
>  	struct xdp_desc *descs = pool->tx_descs;
> -	u32 total_descs = 0, nr_frags = 0;
> +	bool drain = READ_ONCE(xs->drain_cont);
> +	u32 cached_cons, nb_entries = 0;
> +	struct xsk_tx_batch batch = {};
> +	struct xsk_queue *q = xs->tx;
> +	u32 nr_frags = 0;
> +
> +	cached_cons = q->cached_cons;
>  
> -	/* track first entry, if stumble upon *any* invalid descriptor, rewind
> -	 * current packet that consists of frags and stop the processing
> -	 */
>  	while (cached_cons != q->cached_prod && nb_entries < max) {
>  		struct xdp_rxtx_ring *ring = (struct xdp_rxtx_ring *)q->ring;
>  		u32 idx = cached_cons & q->ring_mask;
> @@ -282,26 +294,44 @@ u32 xskq_cons_read_desc_batch(struct xsk_queue *q, struct xsk_buff_pool *pool,
>  		descs[nb_entries] = ring->desc[idx];
>  		cached_cons++;
>  		parse_desc(q, pool, &descs[nb_entries], &parsed);
> -		if (unlikely(!parsed.valid))
> -			break;
> +		if (unlikely(!parsed.valid)) {
> +			if (!drain && !nr_frags && !parsed.mb)
> +				break;
> +
> +			drain = true;
> +		}
> +
> +		nr_frags++;
> +		nb_entries++;
>  
>  		if (likely(!parsed.mb)) {
> -			total_descs += (nr_frags + 1);
> -			nr_frags = 0;
> -		} else {
> -			nr_frags++;
> -			if (nr_frags == pool->xdp_zc_max_segs) {
> +			if (unlikely(drain)) {
> +				batch.reclaim_descs = nr_frags;
> +				WRITE_ONCE(xs->drain_cont, false);
>  				nr_frags = 0;
>  				break;
>  			}
> +
> +			batch.tx_descs += nr_frags;
> +			nr_frags = 0;
> +			continue;
>  		}
> -		nb_entries++;
> +
> +		if (nr_frags == pool->xdp_zc_max_segs)
> +			drain = true;
>  	}
>  
> -	cached_cons -= nr_frags;
> +	if (nr_frags) {
> +		if (drain) {
> +			batch.reclaim_descs = nr_frags;
> +			WRITE_ONCE(xs->drain_cont, true);
> +		} else {
> +			cached_cons -= nr_frags;
> +		}
> +	}
>  	/* Release valid plus any invalid entries */
>  	xskq_cons_release_n(q, cached_cons - q->cached_cons);
> -	return total_descs;
> +	return batch;
>  }
>  
>  /* Functions for consumers */
> -- 
> 2.43.0
> 

