Return-Path: <netdev+bounces-304525-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id RR7bBJekR2o1cwAAu9opvQ
	(envelope-from <netdev+bounces-304525-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Fri, 03 Jul 2026 14:01:27 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 7BAC2702207
	for <lists+netdev@lfdr.de>; Fri, 03 Jul 2026 14:01:25 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=intel.com header.s=Intel header.b=i1VOazNJ;
	dmarc=pass (policy=none) header.from=intel.com;
	spf=pass (mail.lfdr.de: domain of "netdev+bounces-304525-lists+netdev=lfdr.de@vger.kernel.org" designates 2600:3c04:e001:36c::12fc:5321 as permitted sender) smtp.mailfrom="netdev+bounces-304525-lists+netdev=lfdr.de@vger.kernel.org";
	arc=reject ("cv is fail on i=2")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 86214300F78F
	for <lists+netdev@lfdr.de>; Fri,  3 Jul 2026 12:01:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 99ECB3B42F3;
	Fri,  3 Jul 2026 12:01:22 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.15])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 990063C10A6;
	Fri,  3 Jul 2026 12:01:20 +0000 (UTC)
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783080082; cv=fail; b=VlKhHODg1vZFhnlInttrq+ncjtASkH3ws3TJHCJGyXc/S9Gze613dWLWb5ESu4aMbvx7LYAXK4H9Z1eEBEY00KI/RDsVrs5RpU9qF+/OCgAJVvom/uv+3hiytyPdzsU/jtNeL0Ejp+fmCSwSyKMij8oFAJH064FhLMQlvaVgMAo=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783080082; c=relaxed/simple;
	bh=D/FK+ulSN27qrzcAeZ0m25njjJZTqbqmoG0ydFHqJgk=;
	h=Date:From:To:CC:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=bAn75qMolL1qDhkG1cTC6+yv2GOTXNGPgQeO2LvmSbcAvz1Zt0JqMRUZGqd4UaNzrZAAq45aomkZvbna4Q/7bKx/C1qSRXkOP3TD3n+fbIhEAbkm0XgJ+yixlBYKrwPThLp0/fjjJZVsKfyNuBxswDMpcKC0mDAiga5r9w3YfQU=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=i1VOazNJ; arc=fail smtp.client-ip=198.175.65.15
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1783080081; x=1814616081;
  h=date:from:to:cc:subject:message-id:references:
   in-reply-to:mime-version;
  bh=D/FK+ulSN27qrzcAeZ0m25njjJZTqbqmoG0ydFHqJgk=;
  b=i1VOazNJEnZyZOc/sx6C51wkiEiUqdeDn2mJcPGsJcWxnPckSfBST5ro
   Sa70rxcRAIBh/jrJU1LWXeK86etF6OqSLSFLrrvaSROQn7G0UVF95OzqQ
   raszJQPl8zvW0UPTNq8mNA2065hNn0gHDKkgf6NXPClWPiw9ladYJpSw4
   N5ur0j9OiMn4jSZPKISzUbCGWgsVs+D4Klv+MsGxUK/BCFn1uvLmfYzuS
   SPu3Li6Gv9235Jx/R1DKVzcReFlGbbN6mLkPxb9L99qnsmuA9bMvwYh3H
   fWw5OcLl8dphQVDiDRitf3KwZMpjC3jxcDvWQHz2s/0CUZXY79oIjxq/U
   A==;
X-CSE-ConnectionGUID: SAleJtnLTEuc7sO8ctpEvw==
X-CSE-MsgGUID: 4q1TMc+2TCqnfod6EsQdUg==
X-IronPort-AV: E=McAfee;i="6800,10657,11835"; a="87513842"
X-IronPort-AV: E=Sophos;i="6.25,145,1779174000"; 
   d="scan'208";a="87513842"
Received: from orviesa003.jf.intel.com ([10.64.159.143])
  by orvoesa107.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 03 Jul 2026 05:01:20 -0700
X-CSE-ConnectionGUID: fnHIfpzlSmq1DIOXHUsB2g==
X-CSE-MsgGUID: j5uO6eD7RP6vXhzGkDD+tA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.25,145,1779174000"; 
   d="scan'208";a="256675430"
Received: from fmsmsx903.amr.corp.intel.com ([10.18.126.92])
  by orviesa003.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 03 Jul 2026 05:01:19 -0700
Received: from FMSMSX903.amr.corp.intel.com (10.18.126.92) by
 fmsmsx903.amr.corp.intel.com (10.18.126.92) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.43; Fri, 3 Jul 2026 05:01:18 -0700
Received: from fmsedg903.ED.cps.intel.com (10.1.192.145) by
 FMSMSX903.amr.corp.intel.com (10.18.126.92) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.43 via Frontend Transport; Fri, 3 Jul 2026 05:01:18 -0700
Received: from CY7PR03CU001.outbound.protection.outlook.com (40.93.198.57) by
 edgegateway.intel.com (192.55.55.83) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.43; Fri, 3 Jul 2026 05:01:18 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=eJpgcDjvNL+tY1nBWudgbFkmIa1xS10moBRIHecz9cu6I3zHU4jjzUxkuXf+f7CkFW8ORL3u0ro6FoM9Cyn06eHCNEKadtguB4Cto99Q2dxZ55IqVlYB7o1TF3la9SA8Yo/vUxgKGQnBLg5JJn/2TeSaZsj0divu1H8KuWmkm+DBE00CSgwIKe1evXd3LfQwRzY1DXdPhTf8aMbj5Yno8eGcx1pJxqqYp5HcGR2JPJrAeDZd8VvMiXOV1CwSESBf0CE9wYdryRSh3hWvfAahHpCqusfeEqrTKR5Dkcagk1Qvh8D0BQHV5fkypNyj38V8GXDhle7yu3/PI+01AovZeg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=hvH+8ZEz3eATJUtWVWhmT9i2Y1Ee2bUQy7PCfYGRV9U=;
 b=sF/ieMnRv0elWD4I8/SqqJu7yDjP8HH4hOj2lIPwuwFhVQAbTL+0u6pdbvGOsQ4uuVXKwLAYQYeZV1Qkfkz2l5e0WyA6YvEJ4xhP5YFmtVIhOlej0ZHwaJ7pYB6c0I8jdcVsf13dtahxvndLDD+XQcKb69AUUOcLVOsRms2rthCDMsbP8drX+lpq+xkwi9v/TglKbzsLOESfp4SFVIkP3c5ghdoIsikki2oLkasoq+O0pgLJqHQb2U8i+kLui26iXCv/3dJcImg5colP7xSYNLdRvk1tvaFqlGYE0VyJAgPOMke5RG4H/PokwwyjjC7Ghu3l2gO1uWTaHei5/M7+Cg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from DM4SPRMB0045.namprd11.prod.outlook.com (2603:10b6:8:6e::21) by
 LV8PR11MB8699.namprd11.prod.outlook.com (2603:10b6:408:1ff::9) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.181.10; Fri, 3 Jul 2026 12:01:11 +0000
Received: from DM4SPRMB0045.namprd11.prod.outlook.com
 ([fe80::b630:ca9c:20e1:f485]) by DM4SPRMB0045.namprd11.prod.outlook.com
 ([fe80::b630:ca9c:20e1:f485%6]) with mapi id 15.21.0181.008; Fri, 3 Jul 2026
 12:01:11 +0000
Date: Fri, 3 Jul 2026 14:01:00 +0200
From: Maciej Fijalkowski <maciej.fijalkowski@intel.com>
To: Maoyi Xie <maoyixie.tju@gmail.com>
CC: Veerasenareddy Burru <vburru@marvell.com>, Sathesh Edara
	<sedara@marvell.com>, Andrew Lunn <andrew+netdev@lunn.ch>, "David S . Miller"
	<davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, Jakub Kicinski
	<kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, <netdev@vger.kernel.org>,
	<linux-kernel@vger.kernel.org>
Subject: Re: [PATCH net v2 1/2] octeon_ep: fix skb frags overflow in the RX
 path
Message-ID: <akekfMttnBCX25fH@boxer>
References: <20260702180518.2013324-1-maoyixie.tju@gmail.com>
 <20260702180518.2013324-2-maoyixie.tju@gmail.com>
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <20260702180518.2013324-2-maoyixie.tju@gmail.com>
X-ClientProxiedBy: VI1PR10CA0091.EURPRD10.PROD.OUTLOOK.COM
 (2603:10a6:803:28::20) To DM4SPRMB0045.namprd11.prod.outlook.com
 (2603:10b6:8:6e::21)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM4SPRMB0045:EE_|LV8PR11MB8699:EE_
X-MS-Office365-Filtering-Correlation-Id: e7da73cc-d3e5-4011-4b79-08ded8fac614
X-LD-Processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|23010399003|1800799024|366016|376014|7416014|22082099003|18002099003|11063799006|5023799004|56012099006|6133799003|4143699003;
X-Microsoft-Antispam-Message-Info: 7A5ZVVPwK/Fv4hiahC/YzgZ5bLTPYem2YbKJL38U0QgIGJp5s2VmN0P9mvORkudF5Rhqm2f4ryeBhKMHWMn4V/THIam4kwOT3NmhSq7rOCQCvXFM9Gov7+twSjLWqXflLzJbv86TD0JV1uRNewKmb0ashv2p2hdjtgQZemB7EeuJxfYz+l6gLrrm57o3B4hBeYHfwmLMkRL2nIy9ttnF2pnnRyGhKbZcVztTd/frEiCfGT02rnCxemm9MCIiSExj2sveBsbZGsydctMGOq6lFa3wpR7Qd3YWjaFc5ptesZX9cZGbanESdjev3WIxv//EoLsuJAUENUTqOCiV1UXZSkLMNSk6J4VZsNgXQ5LGd53SIf2L/3RBOeVHG69G4mPoeITuUfbPFZxBljcEdmeLVPVTtATTexCBxVlEU7Gcm8PTz2PgkIDHwNY6xEE2ln7KzjSQV0YLogL9OYB/OCFL1GZE+18pGPOUA8bZy4z3Ndi2NhhyLCMu2ZHDRaevmSZzczGgUx5VvQ8J/OQfWJxxdCfLwjKVraEL4WdIoIthLLrYc/FI+fqAIA81pHqTElSY/LgNOXVTAX5P8oclKpxA+KSJx2FJM9ou2moGJYx3gaG1WW5XSyX/YsCWxPwS3kCs+cvN07H9PD+LKIJ6uwFOlpRR9fwNNUmqbUa4wFIMHd8=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM4SPRMB0045.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(23010399003)(1800799024)(366016)(376014)(7416014)(22082099003)(18002099003)(11063799006)(5023799004)(56012099006)(6133799003)(4143699003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?gsDvjYz+Une09cjIzxLRPUNB/excL3zueFT+ANXfPqfMGW6Ks2qB+9wIJBmU?=
 =?us-ascii?Q?/LRY6F5l3xFpVH6L1uszeNX+ud0M35PgVgC/kiDjjFuhX+OO83OOC0a0M0X3?=
 =?us-ascii?Q?CNnIU52M0SP+7zGmFGvOQl6QnROAHvIES06kwfox0MBCL7SBaxCgw6xqsXKv?=
 =?us-ascii?Q?C9gR4Gg23RJHM+v1+D57866AzlP1oWTWfzskV301KBE1D8M1wXyS0TzGYvBy?=
 =?us-ascii?Q?cpojjKR3q47Aa7154noMhMDzSlbJ4YuEsIOg8ra8fjew1cmVn/qA3j38fmms?=
 =?us-ascii?Q?VClDPJiCfgIE2YW/U7lCRYKVMCkxqc0By8aSSY59aDLDOzLPH+KD7Bq+YkHT?=
 =?us-ascii?Q?IAFN1ujAFggBdGOQO2bc4iw3SCLxweKfdmB/NYjqX9KjyHFUdaOwxk/3FB3q?=
 =?us-ascii?Q?Ubat8f6B1NO/lqM/vqPbvZHlNkghVbQVKdIkyuQ4fnJgFV1C8s0mTdzWojSj?=
 =?us-ascii?Q?nxFjAibqduNGNIEeVEA255Mp6xXnIzHdRR9iYD5D0gLWfpYT9h+woRobahlb?=
 =?us-ascii?Q?94o0iSIpAe1tPwSP+GOnZoEyFBEP9FLLfzmknBusk8clcBMzax4R2NZea4bO?=
 =?us-ascii?Q?Iw3NNaD8dSywIvcgO7Q5dICpfbQpLYzTHSGjbsU3Pr+YM9hmsIWsUDU4ctn7?=
 =?us-ascii?Q?EdCg5I3QmsauDZX5CVhliCo3C6Qw1SeLp2qX2oBFrSPywO90gXEY+KGMFpLS?=
 =?us-ascii?Q?Emm/FQIi/ngW5HbssrCFnEKIMMtlKx6bt5NBmgq0XuOnjUpxLWWMw6TcWj7U?=
 =?us-ascii?Q?OSZTeeCVQzFy/o4kZN7LZpRgWkTCh7xn2IaanEy4yqjjzpCHW2xkzktz0gJX?=
 =?us-ascii?Q?LVdmZ8e2oVpC3wUCzaLxk0W8uCWxLO2M+U1ct3hoj2msP4295D6YTDyjBtOv?=
 =?us-ascii?Q?2vwktHYv03STZ/0JShrzv4GFz5cb8p0uDUCVaMTE+88ILGaDovHFt6b7vAjz?=
 =?us-ascii?Q?AeVzLaB1L+4gvTCn/+jVyGy8nqwu1MBS88pqRhbLKISVusr60Q5peJauvn5H?=
 =?us-ascii?Q?Lpxx8TXMiQrmbgauB1VMl5dpCEOZVd0hzJHpZUnDU8z4bYURyDU3Tyk7GisA?=
 =?us-ascii?Q?2XxexFOVN9UY0qKM00Xm9XdG6y/BSuvhMF82CdY09dW3VA5ocrf89DLIRK9U?=
 =?us-ascii?Q?hVPaS83P6IaqzJqKVQVa3BbU4b0STcJea/Eo7d2MDtbzTbZ2fdRSJZgDY1IX?=
 =?us-ascii?Q?nx1WorfjtsIwFAfDppfvG/F1lkoNmVxxxZJQXSjHiGtAaD7xBga1ZRRufEMH?=
 =?us-ascii?Q?y+BUb/LxDrDbzcsu6ssRs+oOAIaPLAsVlNAienrXe/2xyqxnquf6et6haiQk?=
 =?us-ascii?Q?5Q58BATCU1CYn2RtTqsfTZb6GBjyh3i0Vfs+VSjBU0iBQMZQ5wCJuj760s9x?=
 =?us-ascii?Q?Nn7Y9ZtZGqXg+q9HxhyyPkmtV5lGTwykIinViC/0xn91RfwRL9M2VCPc/2fi?=
 =?us-ascii?Q?xj23wjsbNNSSpTYLXQJKJd3ygt6ZPjlQN/sDUyWPaTKB+RNuOCRMw5B0Vye7?=
 =?us-ascii?Q?tQF9j7w+SrEyFgc7ljF/K9KnBZJHf0+90pIK7L3WcHfSBiPR4ZgOWxgKUheZ?=
 =?us-ascii?Q?wrzMyTuTbCm4v8YlyxKOwRKRf7D4dWz4X38M2aTEq2dZrjE1Do97aa3QD3kd?=
 =?us-ascii?Q?lYgEt4aWYDBs9CLzRRMzxQU60hwyUpWvj6N8vOEI2atDk+U6aKrR6fiP9JLN?=
 =?us-ascii?Q?rWj2tJcJA/izAhyVs0u9ZgvWmTxAwxXHrQYcUiVB3I7eMc5mUQxDAxwb3fyp?=
 =?us-ascii?Q?AUsomCCDjdcGh5hYZ69he0+YUsIWEg4=3D?=
X-Exchange-RoutingPolicyChecked: oK5ziBICnVL4EO3WSUV2bf0FO53i8IGSK3d4hggpJ7NsJlZNQZOLndw26K1wLhsd9K7DIl8fGJpR+21KSxtNV5QYsycGYxzggq6sueSAgkm0eaot9UiTqKEzwt46vtnVICXgs0Ji+KlQU3afwioKybdvqvOHpS0U2NqHEe38BeJfg3b+ME3/obvmCSQe1QulKYiCNCmmtfQRe1JZlXmEnRSJcWb2B3O0KGpnwK4rx/LhzGs+tBi6vqvVKdN+VbGxotrAQCxe9zyryY3OpYhyQlEs57yoklpnH+0iEjw2UbxmNX5YfrNw52fmWUURLF1eVDAGbx854BUZ+7+SUlFaRA==
X-MS-Exchange-CrossTenant-Network-Message-Id: e7da73cc-d3e5-4011-4b79-08ded8fac614
X-MS-Exchange-CrossTenant-AuthSource: DM4SPRMB0045.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 03 Jul 2026 12:01:11.0778
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: fvHuBOzKynjbEckjTp9s/x0Jujtxx2c++z4KMvdOkXzhCfEARSlytgrAuWdegf25GsKXuqgbu71JCYICBkVIB5dos5Aw6tgnpq5hzLsrYsg=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: LV8PR11MB8699
X-OriginatorOrg: intel.com
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-1.16 / 15.00];
	WHITELIST_SPF_DKIM(-3.00)[intel.com:d:+,kernel.org:s:+];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_REJECT(1.00)[cv is fail on i=2];
	DMARC_POLICY_ALLOW(-0.50)[intel.com,none];
	MID_RHS_NOT_FQDN(0.50)[];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c04:e001:36c::/64:c];
	R_DKIM_ALLOW(-0.20)[intel.com:s=Intel];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-304525-lists,netdev=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FREEMAIL_TO(0.00)[gmail.com];
	FORGED_SENDER(0.00)[maciej.fijalkowski@intel.com,netdev@vger.kernel.org];
	MIME_TRACE(0.00)[0:+];
	FORGED_RECIPIENTS(0.00)[m:maoyixie.tju@gmail.com,m:vburru@marvell.com,m:sedara@marvell.com,m:andrew+netdev@lunn.ch,m:davem@davemloft.net,m:edumazet@google.com,m:kuba@kernel.org,m:pabeni@redhat.com,m:netdev@vger.kernel.org,m:linux-kernel@vger.kernel.org,m:maoyixietju@gmail.com,m:andrew@lunn.ch,s:lists@lfdr.de];
	FORWARDED(0.00)[lists@lfdr.de];
	FORGED_SENDER_MAILLIST(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[vger.kernel.org:from_smtp,intel.com:from_mime,intel.com:email,intel.com:dkim,boxer:mid,ntu.edu.sg:email];
	DKIM_TRACE(0.00)[intel.com:+];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[maciej.fijalkowski@intel.com,netdev@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	TO_DN_SOME(0.00)[];
	ALIAS_RESOLVED(0.00)[];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	MISSING_XM_UA(0.00)[];
	RCPT_COUNT_SEVEN(0.00)[10];
	ASN(0.00)[asn:63949, ipnet:2600:3c04::/32, country:SG];
	TAGGED_RCPT(0.00)[netdev];
	RCVD_COUNT_SEVEN(0.00)[10]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 7BAC2702207

On Fri, Jul 03, 2026 at 02:05:17AM +0800, Maoyi Xie wrote:
> __octep_oq_process_rx() builds an skb for a multi-buffer packet by adding
> one fragment per buffer_size chunk:
> 
> 	data_len = buff_info->len - oq->max_single_buffer_size;
> 	while (data_len) {
> 		...
> 		skb_add_rx_frag(skb, shinfo->nr_frags, buff_info->page, 0,
> 				buff_info->len, buff_info->len);
> 		...
> 	}
> 
> buff_info->len comes from the device response header
> (be64_to_cpu(resp_hw->length)). Nothing bounds the fragment count against
> MAX_SKB_FRAGS. data_len can be close to 65535. buffer_size defaults to
> about 3776 on 4K pages, so a full packet yields about 18 fragments. That
> is one more than the default MAX_SKB_FRAGS of 17, so skb_add_rx_frag()
> writes past shinfo->frags[].
> 
> The fragment count is now checked before build_skb(). A packet that needs
> more fragments than the skb can hold is dropped. octep_oq_drop_rx()
> consumes its descriptors like the build_skb failure path. The same class
> was fixed in other RX paths, including commit 5ffcb7b890f6 ("net: atlantic:
> fix fragment overflow handling in RX path") and commit f0813bcd2d9d ("net:
> wwan: t7xx: fix potential skb->frags overflow in RX path").
> 
> Fixes: 37d79d059606 ("octeon_ep: add Tx/Rx processing and interrupt support")
> Co-developed-by: Kaixuan Li <kaixuan.li@ntu.edu.sg>
> Signed-off-by: Kaixuan Li <kaixuan.li@ntu.edu.sg>
> Signed-off-by: Maoyi Xie <maoyixie.tju@gmail.com>

Reviewed-by: Maciej Fijalkowski <maciej.fijalkowski@intel.com>

> ---
>  drivers/net/ethernet/marvell/octeon_ep/octep_rx.c | 9 +++++++++
>  1 file changed, 9 insertions(+)
> 
> diff --git a/drivers/net/ethernet/marvell/octeon_ep/octep_rx.c b/drivers/net/ethernet/marvell/octeon_ep/octep_rx.c
> index e6ebc7e44a..bdbed58c7b 100644
> --- a/drivers/net/ethernet/marvell/octeon_ep/octep_rx.c
> +++ b/drivers/net/ethernet/marvell/octeon_ep/octep_rx.c
> @@ -453,6 +453,15 @@ static int __octep_oq_process_rx(struct octep_device *oct,
>  
>  		octep_oq_next_pkt(oq, buff_info, &read_idx, &desc_used);
>  
> +		if (buff_info->len > oq->max_single_buffer_size) {
> +			u16 data_len = buff_info->len - oq->max_single_buffer_size;
> +
> +			if (DIV_ROUND_UP(data_len, oq->buffer_size) > MAX_SKB_FRAGS) {
> +				octep_oq_drop_rx(oq, buff_info, &read_idx, &desc_used);
> +				continue;
> +			}
> +		}
> +
>  		skb = build_skb((void *)resp_hw, PAGE_SIZE);
>  		if (!skb) {
>  			octep_oq_drop_rx(oq, buff_info,
> -- 
> 2.34.1
> 

