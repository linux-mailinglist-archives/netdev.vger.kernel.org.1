Return-Path: <netdev+bounces-303674-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id r9DFGqceRWpq7QoAu9opvQ
	(envelope-from <netdev+bounces-303674-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Wed, 01 Jul 2026 16:05:27 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [104.64.211.4])
	by mail.lfdr.de (Postfix) with ESMTPS id 5F4446EE7F7
	for <lists+netdev@lfdr.de>; Wed, 01 Jul 2026 16:05:26 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=intel.com header.s=Intel header.b=RL4XhUc0;
	spf=pass (mail.lfdr.de: domain of "netdev+bounces-303674-lists+netdev=lfdr.de@vger.kernel.org" designates 104.64.211.4 as permitted sender) smtp.mailfrom="netdev+bounces-303674-lists+netdev=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=none) header.from=intel.com;
	arc=reject ("cv is fail on i=2")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id 64A4C30E2875
	for <lists+netdev@lfdr.de>; Wed,  1 Jul 2026 13:32:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0420248AE0C;
	Wed,  1 Jul 2026 13:32:20 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.10])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7A1B648B36E;
	Wed,  1 Jul 2026 13:32:18 +0000 (UTC)
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782912739; cv=fail; b=O/gWP/VtoDIdftu1nDRAfGYmPBb3OOeLgr6GRGyaT737EXv7DMNkMksNuLcF4XSozNH/uLRHnbNR4keBPnGfW7SwMWzgc1RvoMGzNcX4DwuszKiMPHYwVpaxIy614dm0cB82m3CWUOKQkVdeyUntSIq5ic6a9MptGakoj/K8ewE=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782912739; c=relaxed/simple;
	bh=kJu8j7IJO8UOfNCQtQud8RUKLHYBY5JzAcmJU0Q6+ho=;
	h=Date:From:To:CC:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=VlBpB9NcNNuHgknfdXQPE5uiwsRaMPlbHyG4uPlrJSwA33vgBs8dHY25DKLBz0Cz7yk/jJ8ej+TqlTM00miAyjuzi42xVHJYLN7Pv0po3yJYLjClnFJOn1LEIXAYBDQPyV4jrKY8PEg6zvEV6k9QeBzg3erSg+knlU9oQmkWJfo=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=RL4XhUc0; arc=fail smtp.client-ip=198.175.65.10
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1782912738; x=1814448738;
  h=date:from:to:cc:subject:message-id:references:
   in-reply-to:mime-version;
  bh=kJu8j7IJO8UOfNCQtQud8RUKLHYBY5JzAcmJU0Q6+ho=;
  b=RL4XhUc02kzBqKB/kxAkN+EM6CZfPYNq/iCDN6Zyguxt8dBsVF4AsO7W
   08CpoZ9qTakSePFM3kMNqZMH+zvJ778rDDieqXJ9AozHx/gjrUhSTSQuc
   K3Tb9/uc6jV++Uv1RcJQVcKoosJHeaKnYQZf/9+vr+fscwzriVyMDOXJy
   VavQvQl++se/pzSufpfFO//eJeqPpJU/qmKfCKr/aNALFMVEfNBfLD4Ko
   AAqjTaQAILUyIgXPLYdJtInVMpRPXrTjALbT8P1PSa99rfi96p0NA7eAg
   ht3ZFg2C0XteuWqff37PhGxqhJToWzPNJKftt3/suQM6jc+/EOLumtc4e
   w==;
X-CSE-ConnectionGUID: r/3T5tFkT8WCJGDfJOn9lw==
X-CSE-MsgGUID: VonTwfS7RsKBVIagPRNMRA==
X-IronPort-AV: E=McAfee;i="6800,10657,11833"; a="101069596"
X-IronPort-AV: E=Sophos;i="6.25,141,1779174000"; 
   d="scan'208";a="101069596"
Received: from orviesa002.jf.intel.com ([10.64.159.142])
  by orvoesa102.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 01 Jul 2026 06:32:18 -0700
X-CSE-ConnectionGUID: EMOm7taGRY27LweydjM1EA==
X-CSE-MsgGUID: UJgVy1KnRruoKt3Ya+EATQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.25,141,1779174000"; 
   d="scan'208";a="282648162"
Received: from fmsmsx903.amr.corp.intel.com ([10.18.126.92])
  by orviesa002.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 01 Jul 2026 06:32:18 -0700
Received: from FMSMSX903.amr.corp.intel.com (10.18.126.92) by
 fmsmsx903.amr.corp.intel.com (10.18.126.92) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.43; Wed, 1 Jul 2026 06:32:17 -0700
Received: from fmsedg902.ED.cps.intel.com (10.1.192.144) by
 FMSMSX903.amr.corp.intel.com (10.18.126.92) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.43 via Frontend Transport; Wed, 1 Jul 2026 06:32:17 -0700
Received: from MW6PR02CU001.outbound.protection.outlook.com (52.101.48.6) by
 edgegateway.intel.com (192.55.55.82) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.43; Wed, 1 Jul 2026 06:32:17 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=wGyji1GjeWzxyDDdR/uBbhK2k9yozuqZKJu5itzqiK4A/J7TBgpveqjJ+SEIuxyzuODgZB8HlZJUHFgMP9pIj0J1iGmiLCHkj2jOq7H1MSOCBIl7ksPY/gJPECpYGnRN6V4J/7P4ooWQxVcxp4uQlSulnavZOhB7wPtdwMZJq38wRyvfvCPR8IlY3CEbLbpNEjmc/o4mXXJYkoiEk1qc6VYAVbJ4DO4y7SMqw6No2ov7+2MedypXlHaYE+U8wC2jO0lk+fbG1rljLnZLIpP0jKfgZaeGFvgzFFJ3p7dr7jD8XAR36/5E44QgLk4PokSy04+qxW/4b9y1gy5dfB/87g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=/ZjkoUEhBlBoYspIrSpmDQYgwpF8DVOgKD/JeH5nXcw=;
 b=D4OpnwXHN8Vo8+7RXO/WZwoZ6fIe2trlzRhSPYmNwfU0sLMME7VNOhhEOvIwk+q7Hyuf1Ng3+DgOtpK7rUtY484YLzpfvBENrNl20zPsKldYmeMUN19n6ULn3f2ibNt67oNtGX+HuRZIibt8xyfMk+D1/Ij1NamJ6sq9QgO8Y74mclJoxVWtxEzlntIDWeTQYlWd2ROG7IqDPAGK7KvtXDt5TrZiXR4JPTmJPISLyX5LLemn/FbzfWiOVqUZsXfH40h46rBA+rUHVo6NXrMAdC3e9Nm9QILwLiFyBYEcBEeFYOx16f2nNZ408AMKEClSeE5lgjoa5O503/wgOq3KoA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from DM4SPRMB0045.namprd11.prod.outlook.com (2603:10b6:8:6e::21) by
 CY8PR11MB7873.namprd11.prod.outlook.com (2603:10b6:930:79::12) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.181.8; Wed, 1 Jul 2026 13:32:09 +0000
Received: from DM4SPRMB0045.namprd11.prod.outlook.com
 ([fe80::b630:ca9c:20e1:f485]) by DM4SPRMB0045.namprd11.prod.outlook.com
 ([fe80::b630:ca9c:20e1:f485%6]) with mapi id 15.21.0181.008; Wed, 1 Jul 2026
 13:32:09 +0000
Date: Wed, 1 Jul 2026 15:31:58 +0200
From: Maciej Fijalkowski <maciej.fijalkowski@intel.com>
To: Maoyi Xie <maoyixie.tju@gmail.com>
CC: Veerasenareddy Burru <vburru@marvell.com>, Sathesh Edara
	<sedara@marvell.com>, Andrew Lunn <andrew+netdev@lunn.ch>, "David S . Miller"
	<davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, Jakub Kicinski
	<kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, <netdev@vger.kernel.org>,
	<linux-kernel@vger.kernel.org>
Subject: Re: [PATCH net 1/2] octeon_ep: fix skb frags overflow in the RX path
Message-ID: <akUWzu9VjN5WEoJH@boxer>
References: <20260701112825.1653044-1-maoyixie.tju@gmail.com>
 <20260701112825.1653044-2-maoyixie.tju@gmail.com>
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <20260701112825.1653044-2-maoyixie.tju@gmail.com>
X-ClientProxiedBy: VI1PR09CA0147.eurprd09.prod.outlook.com
 (2603:10a6:803:12c::31) To DM4SPRMB0045.namprd11.prod.outlook.com
 (2603:10b6:8:6e::21)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM4SPRMB0045:EE_|CY8PR11MB7873:EE_
X-MS-Office365-Filtering-Correlation-Id: 71ba8010-e7ba-4962-581f-08ded775268b
X-LD-Processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|23010399003|7416014|376014|1800799024|366016|18002099003|22082099003|4143699003|5023799004|11063799006|6133799003|56012099006;
X-Microsoft-Antispam-Message-Info: SSQJeCHUleUsUDNVbqqBvQZDeMreU7HIYE+dmxkMuuhA+cyd1zpx/U75M+2e7eXDpoCQA7jDX4Wcrn1x/W9HdgK8S1ji6VrssIMW1idQeQemHOoqTkVurBPHafYsmrgqa8ghO8SCyZuSBdVpy7PbPVqZuHKJ3CLIsfXD6COMEbAf9fOx842/vsIMkhN2tD03wWMV7um36Wu0Trknonl9qh+PWA2RlnzOUpwbCXvAl8V2j007Dw5B4+IPct9dBOitz0n8Y9sJ3ubBFss1hYWWCrV7AEx/JQWhGwsracT6iVTWgGaIv/QpJQMf54GYv4jr6fwPwdDIv3zxL3Y1S2MjIPIloDV7rhlMMnaMPkqtijXnKlQiWcBWXY22HLI4F2A3qWCTTStR5r2joJkEhE5B6YKa7nY6q7PVDfWWKE+V0YabAdVfnZC14vc7jXT8JWuZ7bbPAXN9Lwu4958REkEOXtt6+M5Yrzop0nAy48ddO+RucBC3UyQ7B/omK679JnKZqoPaTbS9ajWcNtjzD/PB771kmjwfX2ON5wXzA4lU1iTWaEW7os7hheCzv/SkczyKIfQraNqoKNZLtOtl0vfluFUdJQNIIqFxyuBuwq+v4LQGSUYqYl0D4jA8fzQhgzNhQ0hWRjI75x+1YXkv3BBMut6BXR3WouldjkpULHUHif0=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM4SPRMB0045.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(23010399003)(7416014)(376014)(1800799024)(366016)(18002099003)(22082099003)(4143699003)(5023799004)(11063799006)(6133799003)(56012099006);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?9gKD7g9V4aLHM4dVWBS8xxgIZGv56MYBzrJj8OsSlzjqWXCbmnFutNeHYAAG?=
 =?us-ascii?Q?1qI3aAcxa2Wr0fjAfnsqXg73hqvKgAj3mMXcjFKY1WhSZkTHG2OC337B7wix?=
 =?us-ascii?Q?ZrwVIYDRwokhahEKyuv/jh043F5b+rEgGbRJM0dHWHWNTwBn7F50n+t82++1?=
 =?us-ascii?Q?ItSOjTxWUKQsRFbE+sA11UCmRAmmkaVSeMez0fh+SAfevGZvfBBIvD7T3SM8?=
 =?us-ascii?Q?8cb9/Nf60dgd1huKhYrpHMC0M+6MbRt4FPpdpHlXPbNK30YRqk4Da6nRkS8F?=
 =?us-ascii?Q?qqmCV/Mbj9/Z2exTiwt4127uVFJLWeG/PlCtrxjeMKKYoFRKJMTwrjhR5Nuh?=
 =?us-ascii?Q?gjSh1+BcBmpqU8/3ZiTdzfGdTuibn9DM56n4raB0QQXL+a0fdJmVefeIC/N5?=
 =?us-ascii?Q?1suLdGuu+2ucZvGI182zpJfUFXJLSaIUVbohQjg4kAMCXKrmsLk2aj9Vqp31?=
 =?us-ascii?Q?l+qWQu58JWOLXMWUJ8nkxgYVkZkRl6QSjYC3LHyzecs2Lj0xVS91AIKLiMtS?=
 =?us-ascii?Q?U49GkeK8VQCfM2Oi7qj5o1lfMQD7aeJluDYRxpMJQW2SPVvWJCKWDUJJpGFy?=
 =?us-ascii?Q?P7q9cdZg8jiK+JwRofrADbMbXi3iRrviYPpYnU4A72mPrHLIHNpyvpptNTs6?=
 =?us-ascii?Q?8D0PaYQaV6cKgERI8Ncg1bENN/W/wYrlrc9rnlNDLyurvzNRmXYA4mjSsmnY?=
 =?us-ascii?Q?UB6DOvo8ChzgJeblQ5DQ7tYrLpeOrryOjbwDw5Nixch4XuEOipvL9TykYBzi?=
 =?us-ascii?Q?gKgFGyM+79oU6yTqroqEXDfr3fBBCFpChgAuHJ4xkhxvzwD+LbFF4c0jsVp8?=
 =?us-ascii?Q?DHcphYV9TZ8diNZcP4b71As8yVgSvYDhaBMdItFIB8yfiOEbMrpz7hIoFfV7?=
 =?us-ascii?Q?TsbMNncnVna/Bru/CrVhTqPRJuIwP9QK6fyrwaVRczX6pX5YCgrmMGnBUVqu?=
 =?us-ascii?Q?fg8dmD/Se8CtrIM+fLM6ELCiHVcEcLBEgRZyIIE/Mi/9rOg29PEDNaH4m096?=
 =?us-ascii?Q?U1ZrAGjvFGqoLZZ5vUdPNtHl3ECiXUi72IRgUVShqqf3ERiBoNK8uMJy8aI7?=
 =?us-ascii?Q?OznVkNW6jHnb/6FdLhpUjucnAc3DgCeR3HClPvX1L/o8+gUywUd6kk1pKFWR?=
 =?us-ascii?Q?PeDNrb3VwGF0xtDO7N9CRV+epPmI61MX8zdWV67xwXE7b/YXITATvpeI+bl8?=
 =?us-ascii?Q?OLkAc4U/9tjH537pfvsWE+ktV9JpRJXKTbxeHBkeoYYu0AHzasnTANpjyVmY?=
 =?us-ascii?Q?Wm8N/aPZeP81r2Ww2/7rVn4hV/wy7l7m9PqdB2qmOMqdY5f8qnsuBylXiNvE?=
 =?us-ascii?Q?NLG83QpzsxRjQA8WeRpwdG/xS0YOtykCjZaZG9bQ6NOuxNCuDPgBoPemfb16?=
 =?us-ascii?Q?oY1i2EMM4kg183aUgaVSo2RPyDVr32gdOZv4kbVRWbUOqp9KkjXYuw8Lqwhp?=
 =?us-ascii?Q?4HToWCjPEu/nhUTckPz4W/L4uyw5Wqt7vpsmjYKCNUzMZg8ZBuI4p4Xk9wz5?=
 =?us-ascii?Q?CsDMk2T6BSW/wxeyb8h6wCZt373vuAIL9he/ge4QBkvW/UJIrAUuGBYMdf96?=
 =?us-ascii?Q?OQEwWP+qm5rlV6654CrmLkEPNEjwNzh8+zO1OAm1bPymv6U2W+8Qj4Y8iPa9?=
 =?us-ascii?Q?eTrNT790Ezax6eQvePwBvsy7YQbXFR//Q6bOghO2ta7bRFR6/W+NLXzwpnly?=
 =?us-ascii?Q?kezvodQv7LV4bZwbJJlTbTJb+JzYD/kAB/4mzaYQ16JXfHC3UmjfNIxfPgAn?=
 =?us-ascii?Q?6T83qhn+JekpeeL9bVOuVRpjOKEApdw=3D?=
X-Exchange-RoutingPolicyChecked: l5HURCvl7EIPy3LaVz/x+HpRWJ/WO4/Dove0w5VsFsJ0Kfobokmh0/RyqhdBI7gnNm+2YrHxmaS6cegwkh9SYqRjfgUgkJZBGD3lifZ3hTdSqwaL1iG7I1Qekb1YQpRgcbFvSvW+5lpT44RapJvetWv24RB6CyY5D9ZeutWXXSCkz6d1GS1Qc92k30P22xMk1QtzzWARIZFASoeATc6wVK79xbddg+He2n+yB7t5RnXATlEPKpEgi1kqIdYuehHi+lFC6Dzo9R97rgrVt+/ZM8Pvn2kokpLLuL3ZNNO9Dd6YxaM3B6nG8labJkVjVxt75ut6qwZRNUmDRdqI9ReJMA==
X-MS-Exchange-CrossTenant-Network-Message-Id: 71ba8010-e7ba-4962-581f-08ded775268b
X-MS-Exchange-CrossTenant-AuthSource: DM4SPRMB0045.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 01 Jul 2026 13:32:09.1691
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 81V3ZoaYTSIcIi93OoFiLxbF21MsCXW4syBWfX5cI5kPoW51Bh8qWf71nehlljxkye/8HAcnVYZ987txXzLDdVVQl0SljWWAw87KFM59zis=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY8PR11MB7873
X-OriginatorOrg: intel.com
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-1.16 / 15.00];
	WHITELIST_SPF_DKIM(-3.00)[intel.com:d:+,kernel.org:s:+];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_REJECT(1.00)[cv is fail on i=2];
	DMARC_POLICY_ALLOW(-0.50)[intel.com,none];
	MID_RHS_NOT_FQDN(0.50)[];
	R_SPF_ALLOW(-0.20)[+ip4:104.64.211.4:c];
	R_DKIM_ALLOW(-0.20)[intel.com:s=Intel];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-303674-lists,netdev=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FREEMAIL_TO(0.00)[gmail.com];
	FORGED_SENDER(0.00)[maciej.fijalkowski@intel.com,netdev@vger.kernel.org];
	MIME_TRACE(0.00)[0:+];
	FORGED_RECIPIENTS(0.00)[m:maoyixie.tju@gmail.com,m:vburru@marvell.com,m:sedara@marvell.com,m:andrew+netdev@lunn.ch,m:davem@davemloft.net,m:edumazet@google.com,m:kuba@kernel.org,m:pabeni@redhat.com,m:netdev@vger.kernel.org,m:linux-kernel@vger.kernel.org,m:maoyixietju@gmail.com,m:andrew@lunn.ch,s:lists@lfdr.de];
	FORWARDED(0.00)[lists@lfdr.de];
	FORGED_SENDER_MAILLIST(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[vger.kernel.org:from_smtp,intel.com:dkim,intel.com:from_mime,sin.lore.kernel.org:rdns,sin.lore.kernel.org:helo];
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
	ASN(0.00)[asn:63949, ipnet:104.64.192.0/19, country:SG];
	TAGGED_RCPT(0.00)[netdev];
	RCVD_COUNT_SEVEN(0.00)[10]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 5F4446EE7F7

On Wed, Jul 01, 2026 at 07:28:24PM +0800, Maoyi Xie wrote:
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
> The driver now drops a packet that would need more fragments than the skb
> can hold. octep_oq_drop_rx() consumes its descriptors, as on the build_skb
> failure path. The same class was fixed in other RX paths, including
> commit 5ffcb7b890f6 ("net: atlantic: fix fragment overflow handling in RX
> path") and commit f0813bcd2d9d ("net: wwan: t7xx: fix potential skb->frags
> overflow in RX path").
> 
> Fixes: 37d79d059606 ("octeon_ep: add Tx/Rx processing and interrupt support")
> Co-developed-by: Kaixuan Li <kaixuan.li@ntu.edu.sg>
> Signed-off-by: Kaixuan Li <kaixuan.li@ntu.edu.sg>
> Signed-off-by: Maoyi Xie <maoyixie.tju@gmail.com>
> ---
>  drivers/net/ethernet/marvell/octeon_ep/octep_rx.c | 6 ++++++
>  1 file changed, 6 insertions(+)
> 
> diff --git a/drivers/net/ethernet/marvell/octeon_ep/octep_rx.c b/drivers/net/ethernet/marvell/octeon_ep/octep_rx.c
> index e6ebc7e44a00c..4ee911b6c0107 100644
> --- a/drivers/net/ethernet/marvell/octeon_ep/octep_rx.c
> +++ b/drivers/net/ethernet/marvell/octeon_ep/octep_rx.c
> @@ -476,6 +476,12 @@ static int __octep_oq_process_rx(struct octep_device *oct,
>  			skb_put(skb, oq->max_single_buffer_size);
>  			shinfo = skb_shinfo(skb);
>  			data_len = buff_info->len - oq->max_single_buffer_size;
> +			if (DIV_ROUND_UP(data_len, oq->buffer_size) > MAX_SKB_FRAGS) {
> +				dev_kfree_skb_any(skb);
> +				octep_oq_drop_rx(oq, buff_info,
> +						 &read_idx, &desc_used);

nit: would it make sense to pass data_len to octep_oq_drop_rx() to avoid
re-calculation here

But besides, wouldn't this be better to do even before build_skb() call ?

> +				continue;
> +			}
>  			while (data_len) {
>  				buff_info = (struct octep_rx_buffer *)
>  					    &oq->buff_info[read_idx];
> -- 
> 2.34.1
> 
> 

