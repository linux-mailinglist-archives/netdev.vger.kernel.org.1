Return-Path: <netdev+bounces-165610-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 421C0A32BCD
	for <lists+netdev@lfdr.de>; Wed, 12 Feb 2025 17:36:12 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 7F6A01623A5
	for <lists+netdev@lfdr.de>; Wed, 12 Feb 2025 16:35:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E9D3D25D53C;
	Wed, 12 Feb 2025 16:34:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="FE4BTmpc"
X-Original-To: netdev@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.11])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D46C725A2DD;
	Wed, 12 Feb 2025 16:34:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=192.198.163.11
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739378055; cv=fail; b=OZ4hf203Hwk0Fbj9Ifnpl8zVqznfD5yLDp0yZNTh0VCGyxr14gW9F3gqC4OlWMNF4BLHBkToqd4FAsUuwhs/rJSver1+KHqq0o2y5TPVzkui1S+/ZN0BJn+mU7/hmjP9LRrehCut+PgElWEErN2z0jNFvBYwG6juUjK3V7YUaEk=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739378055; c=relaxed/simple;
	bh=SIJmIppjGi5WZ1ukKUieYsLht1gzpJbgngy5laZKSsA=;
	h=Message-ID:Date:Subject:To:CC:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=Q2zXELJoG00CLJxbtZMurEkMorGIPoaT5yLxTl7h96A2F48gH6E+E73Wa4iIcde2XxjA9pgcN0Ys9Ag+Wx15Jl79PPxfb9K4FZ80EcY/Xp+BXzntCIv+zdZU2QeNw/PS2VXPh+XAuqmFAa9onajqOT9qDeybw2JftNLZYpJ4iVI=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=FE4BTmpc; arc=fail smtp.client-ip=192.198.163.11
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1739378054; x=1770914054;
  h=message-id:date:subject:to:cc:references:from:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=SIJmIppjGi5WZ1ukKUieYsLht1gzpJbgngy5laZKSsA=;
  b=FE4BTmpcHptlFpCswbGe9mOq1brfzS81YHCa0HLnmBE7ND0sQ+1WDa1Y
   lZHiT+cjoYzvkexujXgfVtBVd7NNetvLKQa7sUkPMBX4GvuwZeDG1L7Xz
   knYrg72hjF4VMrYaCiunYbN6xXcZyOe+3gugzB/dXZJZ6fKSmkXPxbnDG
   9W4yDXtiQQLfK3bqaLlc1/YAaaA1rusGoSM7DJ/DstulyflLYdC4DQ+qW
   hIiMjVi1YVb+h3tXva3nEmyRJ33rtCNOBSJm5XLf8yNaolBqTigy/x504
   +O+J++/C7hyhJeOsRuUMgGNvB89CcOIt2XChS/peiO/lmN9N4fF7bp/pl
   w==;
X-CSE-ConnectionGUID: PCLfoh+7SL6cSjhuOboLYA==
X-CSE-MsgGUID: PJrdWgjGR7mfx9uWF0d/Mw==
X-IronPort-AV: E=McAfee;i="6700,10204,11343"; a="50679423"
X-IronPort-AV: E=Sophos;i="6.13,280,1732608000"; 
   d="scan'208";a="50679423"
Received: from fmviesa010.fm.intel.com ([10.60.135.150])
  by fmvoesa105.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 12 Feb 2025 08:34:12 -0800
X-CSE-ConnectionGUID: OTwtP2pySOCf2AJsQK4wNw==
X-CSE-MsgGUID: XX+ercpFS0GN4d+hKQKNRw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.13,280,1732608000"; 
   d="scan'208";a="113389215"
Received: from orsmsx603.amr.corp.intel.com ([10.22.229.16])
  by fmviesa010.fm.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 12 Feb 2025 08:34:02 -0800
Received: from orsmsx603.amr.corp.intel.com (10.22.229.16) by
 ORSMSX603.amr.corp.intel.com (10.22.229.16) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.44; Wed, 12 Feb 2025 08:33:56 -0800
Received: from ORSEDG601.ED.cps.intel.com (10.7.248.6) by
 orsmsx603.amr.corp.intel.com (10.22.229.16) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.44 via Frontend Transport; Wed, 12 Feb 2025 08:33:56 -0800
Received: from NAM12-BN8-obe.outbound.protection.outlook.com (104.47.55.175)
 by edgegateway.intel.com (134.134.137.102) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.44; Wed, 12 Feb 2025 08:33:56 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=yW7ctvytXlI+tjQj9fY9FX0qebXFyZHc/8CMjTJlpSfdnRq/p2wdivKQ//EIJeSG5t9IM4j6cjq5Uh9GWyGiFp/JS7zugVY3CrxeK7VQFQPumNIwPkZDQ6i3PPrLkwEsvAhYV5vKEKgKfcSYDZ3iFD66CGmYaSMmsdGxsRKhCesTPzx+tmr+RRApl+Q74ll1+3raM8+rnXD1l9B4kdw/GhF0qU35f1rkpwA81GYU5S6EwSwmaU31KlKPzpJ3lFuNuo1Y55Np7jAW0vCNG3Jb/T/etUfKDb38B9mUvQ9yFNKKwPM0FOldY4NHdt3DPHZgp0AQc/v4vSW5s4POFTyDyQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=RxgvUu9asqp+fK1VgHFQ/8f/E76UFavWGQAjwI4Sez4=;
 b=Wu8Dy8HgWg4TirPSffB/3h1zJVzHdxck4njfiBoNJ08GqjVyhI7NUfkXRDB3DsSWFuBxbQXySocwZqXuOsz07pmUprCNVd6jNyjsVpcBkPmaNAgvIVpQY34potQj9d97vC9dVGWLWu2Vtuiksyfvj3AHbDIXC0ORoUqKT+iofqf4GLFhAEsT1r5WNQGWeFYDxhWFc/1UhH35fEruXynCMtmv+NG3P190DYVHFXwoCieDO1dWDsyJPoDo1UE8v1Ilh0doZGx64LD56YNpQ2mxl+9FOL1XXpsl66SlGQKINDPDQBo9C6fCHOnpOCcWLYrvr306ArVE+hQyF2w+Ai1rfA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from DS0PR11MB8718.namprd11.prod.outlook.com (2603:10b6:8:1b9::20)
 by PH8PR11MB8016.namprd11.prod.outlook.com (2603:10b6:510:250::6) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8445.11; Wed, 12 Feb
 2025 16:33:52 +0000
Received: from DS0PR11MB8718.namprd11.prod.outlook.com
 ([fe80::4b3b:9dbe:f68c:d808]) by DS0PR11MB8718.namprd11.prod.outlook.com
 ([fe80::4b3b:9dbe:f68c:d808%4]) with mapi id 15.20.8422.015; Wed, 12 Feb 2025
 16:33:52 +0000
Message-ID: <f9adb864-8ed5-4368-a880-b2aac8aac885@intel.com>
Date: Wed, 12 Feb 2025 17:29:40 +0100
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net-next v2] net: Add options as a flexible array to
 struct ip_tunnel_info
To: Gal Pressman <gal@nvidia.com>
CC: <netdev@vger.kernel.org>, "David S. Miller" <davem@davemloft.net>, "Eric
 Dumazet" <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>, Paolo Abeni
	<pabeni@redhat.com>, Andrew Lunn <andrew+netdev@lunn.ch>, Tariq Toukan
	<tariqt@nvidia.com>, Louis Peens <louis.peens@corigine.com>, Simon Horman
	<horms@kernel.org>, David Ahern <dsahern@kernel.org>, Pravin B Shelar
	<pshelar@ovn.org>, Yotam Gigi <yotam.gi@gmail.com>, Jamal Hadi Salim
	<jhs@mojatatu.com>, Cong Wang <xiyou.wangcong@gmail.com>, Jiri Pirko
	<jiri@resnulli.us>, Kees Cook <kees@kernel.org>, "Gustavo A. R. Silva"
	<gustavoars@kernel.org>, <dev@openvswitch.org>,
	<linux-hardening@vger.kernel.org>, Ilya Maximets <i.maximets@ovn.org>,
	"Cosmin Ratiu" <cratiu@nvidia.com>
References: <20250212140953.107533-1-gal@nvidia.com>
From: Alexander Lobakin <aleksander.lobakin@intel.com>
Content-Language: en-US
In-Reply-To: <20250212140953.107533-1-gal@nvidia.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: ZR0P278CA0073.CHEP278.PROD.OUTLOOK.COM
 (2603:10a6:910:22::6) To DS0PR11MB8718.namprd11.prod.outlook.com
 (2603:10b6:8:1b9::20)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS0PR11MB8718:EE_|PH8PR11MB8016:EE_
X-MS-Office365-Filtering-Correlation-Id: 50ec6731-9e6b-45ec-0ba8-08dd4b8308e8
X-LD-Processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|366016|376014|7416014|7053199007;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?RDR1c1YyUS9oZnJNNFc5YXd3S2NpbmkwWEZwK2dKRDB0L3NkN3FhUGxab2VJ?=
 =?utf-8?B?d3RDalAxYXNrYzJ4RmR5K0ErL1I0c1ZlYXNGS3RacDVTMWdIM1hJWkJaaVRk?=
 =?utf-8?B?MERWTndYTVZwcjBvcUxwQkhYYkZzV09FZ3NqV3QzZ3MyK0F2M0kyL21rYjNv?=
 =?utf-8?B?akl2b3lPOGJsSFVseGNmY2l6NGgvR0dGVGZMcVFzRXBkOGJiSWFIdjR5VGZV?=
 =?utf-8?B?TE52QzFsNUhUUEp1dmtoR05UdXM3QnJyZ3Q1eHRMM0hNUjdRY3ZBbXB4L2FY?=
 =?utf-8?B?THhpVjV2dnhuY1B6SDkxNWVlYlpOTktZSVB2M1RtamxUVlFXZUFneG1WUi9t?=
 =?utf-8?B?eGNHTDVleSt3dUlCZzNrcU1lZDAvV3M0c1dZeUttQjBnaHYzcTF4S2xVOWpB?=
 =?utf-8?B?cDRqRE96bVVQTXZ5ZkxNYjA2UUFXTnArUFJuek1VWGROOG05NXNEQ3JodmY2?=
 =?utf-8?B?WjA2Y2orWVBrQTYrTDViVTVOM0V3Vm4zMHRkMllvN2FYc0ZsUENWN1ViVGN2?=
 =?utf-8?B?NEdyOHJreWNwS2JDNWN1cHBoL0lMZ1M3MXl3aTRaeHRxNUhndUhtM2xtVW9C?=
 =?utf-8?B?emgxTVNjL1JjRXdVWjVqcjJKckRzM214STB5aDZDS1pQOXl5QW9TK0NsMWNC?=
 =?utf-8?B?OFMvWlIraytKNEVvZW9iREp2VFE3S0Y3aFZVeFpGL3RoeEFRaXUrOFEwVUdQ?=
 =?utf-8?B?SkE3S2hSV2tLQ2RveHdxOU1hTlZPTVFQZXh5T2tDa0dZMjNnWTJmdDJaYVRL?=
 =?utf-8?B?b085V1M5eDJ5aG9tUVBKWklrU3BRV1ZlS0FuWFpvQmtpdTRpN1JNaVB1R3Rl?=
 =?utf-8?B?RXgwOXorQktJUFEyblJVeVpkcXU1M1NHRytHTk5tQWxPbU1KaSs0aUd2WHVR?=
 =?utf-8?B?WFRDUy9OdUlDWTd5dUhJakVRVmpLVTNvY3hCRk84YkRMSWx6SEtKN1lKVjJZ?=
 =?utf-8?B?Wko3QjBDS3NYNzhoTnlaZytmRVNsUG9ZR29TYW9sUlc0aFFaUFhCR0p3ei9q?=
 =?utf-8?B?cEFsdjk4NVVIVGhxNWswdE8xM1BRNGR1K2Q3bnMzRmc0a3lOZVFZYmdDS3lC?=
 =?utf-8?B?UWxJMTRneHZZODRicSsyb2hyNThwdDlxNmp4clpkVjVBMWRTVEd3Ujd4Tmto?=
 =?utf-8?B?a0JuSXp6cDgzK2FQSnZuVFhvMUdISS9PWDIrWkNkNUxvRVlqbEw1YUJSVnJw?=
 =?utf-8?B?UW1DSHpNS1RHNWtoZFZjZ2R1VGN4UUVzRXVUWUlxRkZhL2ZIRjZnTGJ0aVZk?=
 =?utf-8?B?Zmp0dTNhNkFoZzh1S1JqY25xT1pSR2VwVlNNVVJvT00zSm9Tc3JFWmFCdk4r?=
 =?utf-8?B?NlBKRmRzQWMvYTk4dmNqWDArNkxCWUQyYk5NM2FVb21qZFU4K3FsUTdET0l1?=
 =?utf-8?B?S1VTa1k1VEp2Ui8yanJ1VFZ1OEdaTUNmdGR1eXFUWG1Zd1Q2RUJybENRMm9x?=
 =?utf-8?B?LzlheXRucWFoQlg2UG56THViOG1teC9hTnF4M2dSN0lwcU5JQXBkY21SME1T?=
 =?utf-8?B?bGVDayt3M2pmZGZUL1FvVTY2Qjg2QkFRTlBRN1ZtMXhRK2ZTTHhuV3QzNHFs?=
 =?utf-8?B?VjVjK0xaNHZuSU9HRWxlOFFoODJRY1VsS0xuWExmS1FvOXp0SWFXNnZUZjhS?=
 =?utf-8?B?ejFaV1IyQzQybUpXTUs5MHZzc0lYc09QcHFKTlJyRDNrZjdDWTU3TzNTYVpT?=
 =?utf-8?B?RXl1M2RjWExtemVOV1o0bmVLWENxbnRFZFAreEtoZDlPc3NUczkwSFJSSmpy?=
 =?utf-8?B?alRWak15RFpBY0Y5VXNuelNjc0Z0ME1pckkyUmg1ckVBWFVOc2pDRXlLbnln?=
 =?utf-8?B?cWNWUFNrRDdiYjdVSkF2bkdEZTdjQVJrdGtUbFJJdk5jd2t2T1pLZklPWjRj?=
 =?utf-8?Q?8itCpDlkKKpnM?=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DS0PR11MB8718.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(376014)(7416014)(7053199007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?ZjVJd3BjZm9MS2ExLzRhdFZiYW96YmxwazUyTDYyOUZ3QWYrR3V5bXFEYlEx?=
 =?utf-8?B?RGo3VkNKZTViOGdWTmRsblhqRGMwZDFyUXNaUks3MHJyZVdLRjVxSWxQV1Zx?=
 =?utf-8?B?dlprZWdJaGVLSnN3andISmNRdERxY013ZVlNeG1VTHBmY2V5MmZOV0ZwZHJT?=
 =?utf-8?B?MXQ5TzFiZlFWaFIweGtXLzhvR2E3QVhTSFdqVU8rNlFUUXE1bnNjbzZqa3l6?=
 =?utf-8?B?c2NGOUpRcXNCNHB0RElhT3ZtTElMMWdHT0JXZFUxd2IxNVd3OHByMElQbkdZ?=
 =?utf-8?B?dTE4YndkTDhYSTdBR3JKQ3gvV1pqZ1dZODBFNkRSTnp1bFJySTNUTFNOcnNs?=
 =?utf-8?B?TFE1MVZabWxWSzNuSmJSMU8xRlNqeDZzVEFlNnhSVE9nQW00WUJUaWVVQmZW?=
 =?utf-8?B?U0NTR203cWU1RXQ3dytwSHM1YjI0MEFSMkl2VEpMdm1VdEhMVWRHQ0s4cnFv?=
 =?utf-8?B?SnpXWWZVeDVURWFmVEVzbkwxMkFNYTluTHo4YThub2twaW0rSFpYQkhQM095?=
 =?utf-8?B?UWpDSDVmTkR2eDJvdS9Gdm9hcGJmQWhjWWdBdlRsMzk1RC9wTjFsYnhWdnNs?=
 =?utf-8?B?NE5Gb3ZRdkpYeGRPR0VTL2M1ZUp2TjV4TkhwRHRuQUNaY1c4SmFyOVArNUNo?=
 =?utf-8?B?M0NCV2c3blRWY0t6QUJSVzM0TXo3b1dXcDBycVcwZlUrcUpodVkwS2dYSHpF?=
 =?utf-8?B?L3dkd1kxSWRzeTFBUXFKNGpJK2JtSStLTTQzVENsRTdhWjRaUmtXclUxNzlN?=
 =?utf-8?B?QkcrN3RmbERVQXJOVGo0L2o2aWpIRnFLdXdxVUdYVnptSUUyQnUvbHc3TjhH?=
 =?utf-8?B?Q3NHN04xcFV0cnVqdll3Q01pRzg2S011cVVmR2ZrUkN0czBXWXVFNXNHdDlE?=
 =?utf-8?B?Z2NtaHRDLzZIcy9zZVNUakYrU2tRSHREemJXb2dRaVlZazVRZ05ZeGlwYlVk?=
 =?utf-8?B?NDZybndYTnV6eGJrTXNhdzdYV2VDQWlzZVdFQk5QZFFpR2N5VFpYYXk4RzAy?=
 =?utf-8?B?L2JUYjlhM1lIMzlWZzZXVWRwczlsaGdsZ1NPaCtIazkrUksxdTFUT2pXa1Qw?=
 =?utf-8?B?bWliS0ZacStzaUlqUFRMbnluZFBSM0NYUS9sSFRoamhQR1B4MXZvUE44OUdo?=
 =?utf-8?B?R0JuT2w3eXpPd2VPekRnbkxxcnBDTmdsa1pDWHRXS1pUcTRkcS8zTERsU05p?=
 =?utf-8?B?c1M4TzdOQWo0bzVaVU9SMVRPV3A2dnJjY3dpemFIbUpKMFlVNGQvNnl1QklT?=
 =?utf-8?B?M2JYS08vbnlsT3lCS3FWOHhVMEhQQnhHTWRLQWp6ZWo2ZDRMckFGa1dnNGhY?=
 =?utf-8?B?VHlya0RoQTVzeGRpT1RWUnRnRjdkQ05YcmkzeXh4WVU3YUtETk93MHd0Zi9y?=
 =?utf-8?B?SjRoY2VMZnErdWhrblBDTWppU05JZjdiNUtFd01NaElqUGZuYVZwd2taSk82?=
 =?utf-8?B?VGZPMmdtaUhocmZhSHp5Z3ZoUEFWMk0rQk5BK0RITzVLV0tWT094emdaRGE1?=
 =?utf-8?B?VjM4dXMyd3dOcUgydWpXRHFYM3k3SUthdVFIdE8wazFnMXdqNnFWZzd0T2V1?=
 =?utf-8?B?anR5SENEM3g1VGRmbUJ3RVhMZFJiR1VuTVIwZHM5Y2ZLYk9CbGhqZm9tVjBO?=
 =?utf-8?B?VHNDS2J0WXF6cGtjYzYrbFJSNytpaERkcHJqUnZ1dkRUbGdFeGlEQ25SZURn?=
 =?utf-8?B?cnVWc1N1QXJoSFZlUU92SkdobDdkM0d1amMvS2thMy8wRTlORE5NaVdIdzFn?=
 =?utf-8?B?UUlwcGQ4TkNOYmxTc2srY2grRVdGQU9TNUdFQWlMYXpJb3gzYm5xNHBzMlZM?=
 =?utf-8?B?dStpOFJyRUJ0RlZGaVBxaDhGVDVWeGQzajRpNGU4QzFJUDNIYnA3Yml5NjRJ?=
 =?utf-8?B?clNaQnlpYUZzcUdiSmFqRWxrYTZxZUJuT1dwbGUxdHFNMHVUc2ROU1JZcGx6?=
 =?utf-8?B?MHVtSVlDOVBHbXdKT3FSUTA2ZkVON0pHWDB3VlRySnJyd0xIM1I1bm9ydmww?=
 =?utf-8?B?a0pQRWIxL0g4MHBQZ1Judk5xa00wUzRnakg3UzhXN1ZJUTc0dTJDZ3RxdkF3?=
 =?utf-8?B?VksyaXB6UTRvN3V4YkpadmZuOHJjblozMjRqbzVtYXdORUlQdGlscGIyaDBS?=
 =?utf-8?B?QVY3UlFQdVRHZ1pLMFdvNnpReHQreUQweDlMNEVDMlEwODlxWGREQjdJZHZ5?=
 =?utf-8?B?Mnc9PQ==?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 50ec6731-9e6b-45ec-0ba8-08dd4b8308e8
X-MS-Exchange-CrossTenant-AuthSource: DS0PR11MB8718.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 12 Feb 2025 16:33:52.1114
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: FMlLwCZuRYDVEipWS9X6Uptft31C71pQVlHaafByLI8V6/J53qfNZNM5QQSqLnsVwqlX/EwPZM1SnVMrxRdH5su8CMR08C/LAM93JegfGE4=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH8PR11MB8016
X-OriginatorOrg: intel.com

From: Gal Pressman <gal@nvidia.com>
Date: Wed, 12 Feb 2025 16:09:53 +0200

> Remove the hidden assumption that options are allocated at the end of
> the struct, and teach the compiler about them using a flexible array.

[...]

> diff --git a/include/net/dst_metadata.h b/include/net/dst_metadata.h
> index 84c15402931c..4160731dcb6e 100644
> --- a/include/net/dst_metadata.h
> +++ b/include/net/dst_metadata.h
> @@ -163,11 +163,8 @@ static inline struct metadata_dst *tun_dst_unclone(struct sk_buff *skb)
>  	if (!new_md)
>  		return ERR_PTR(-ENOMEM);
>  
> -	unsafe_memcpy(&new_md->u.tun_info, &md_dst->u.tun_info,
> -		      sizeof(struct ip_tunnel_info) + md_size,
> -		      /* metadata_dst_alloc() reserves room (md_size bytes) for
> -		       * options right after the ip_tunnel_info struct.
> -		       */);
> +	memcpy(&new_md->u.tun_info, &md_dst->u.tun_info,
> +	       sizeof(struct ip_tunnel_info) + md_size);
>  #ifdef CONFIG_DST_CACHE
>  	/* Unclone the dst cache if there is one */
>  	if (new_md->u.tun_info.dst_cache.cache) {
> diff --git a/include/net/ip_tunnels.h b/include/net/ip_tunnels.h
> index 1aa31bdb2b31..517f78070be0 100644
> --- a/include/net/ip_tunnels.h
> +++ b/include/net/ip_tunnels.h
> @@ -93,12 +93,6 @@ struct ip_tunnel_encap {
>  	GENMASK((sizeof_field(struct ip_tunnel_info,		\
>  			      options_len) * BITS_PER_BYTE) - 1, 0)
>  
> -#define ip_tunnel_info_opts(info)				\
> -	_Generic(info,						\
> -		 const struct ip_tunnel_info * : ((const void *)((info) + 1)),\
> -		 struct ip_tunnel_info * : ((void *)((info) + 1))\
> -	)

You could leave this macro inplace and just change `(info) + 1` to
`(info)->options` avoiding changes in lots of files and adding casts
everywhere.

> -
>  struct ip_tunnel_info {
>  	struct ip_tunnel_key	key;
>  	struct ip_tunnel_encap	encap;
> @@ -107,6 +101,7 @@ struct ip_tunnel_info {
>  #endif
>  	u8			options_len;
>  	u8			mode;
> +	u8			options[] __aligned(sizeof(void *)) __counted_by(options_len);

Since 96 % 16 == 0, I'd check if __aligned_largest would change the
bytecode anyhow... Sometimes it does.

Thanks,
Olek

