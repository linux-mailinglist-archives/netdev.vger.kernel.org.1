Return-Path: <netdev+bounces-301914-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id 7/z5A2P4PGrJvAgAu9opvQ
	(envelope-from <netdev+bounces-301914-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Thu, 25 Jun 2026 11:44:03 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id E520F6C457A
	for <lists+netdev@lfdr.de>; Thu, 25 Jun 2026 11:44:01 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=intel.com header.s=Intel header.b=g+uyFlz+;
	spf=pass (mail.lfdr.de: domain of "netdev+bounces-301914-lists+netdev=lfdr.de@vger.kernel.org" designates 2600:3c0a:e001:db::12fc:5321 as permitted sender) smtp.mailfrom="netdev+bounces-301914-lists+netdev=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=none) header.from=intel.com;
	arc=reject ("cv is fail on i=2")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 2A9BB3051C5A
	for <lists+netdev@lfdr.de>; Thu, 25 Jun 2026 09:39:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0083837472F;
	Thu, 25 Jun 2026 09:39:28 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 42CEA2E8897
	for <netdev@vger.kernel.org>; Thu, 25 Jun 2026 09:39:26 +0000 (UTC)
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782380367; cv=fail; b=J/cl6D1srm9WifiUdUU5VE/TPjdT84m1sEm0ceAP26pqZnCpnc3WjtljvQQCackOPqG6pmi1YaLbq45nzyz+elzZlVPA8GVt6mQbZGB+4DoY+NN9TSmRIrm0W5WDUsxs7ALohN1OZ65UVP270g6ma+xR6Utu1CtgWFcnZ3C7id4=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782380367; c=relaxed/simple;
	bh=RUU1JwBofd0IRkjsNaqfQ99jMOnO49PF3tgJdwa4kUs=;
	h=Date:From:To:CC:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=ekzVBkQPSIHxsTKvcDq6lmpHrL0ECQIHpkx/WC3YBjrwD8Unc8177Otwi7CZV5+tLlx+zxaxjTJUK2o9u5xvlWtSN0TvfmlmB6rKb6LlJxHCmpcNbdVBxc/TdqmGB8UmiW22ZA1MnngY7l5eOGSqSyee/KYO1tA2T9KziMPbmpw=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=g+uyFlz+; arc=fail smtp.client-ip=192.198.163.18
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1782380366; x=1813916366;
  h=date:from:to:cc:subject:message-id:references:
   in-reply-to:mime-version;
  bh=RUU1JwBofd0IRkjsNaqfQ99jMOnO49PF3tgJdwa4kUs=;
  b=g+uyFlz+D+nzgGDGTuUlBtoCOQOQykd7oXcoHgMlSWBqtqGuHQg3e2qK
   5ANio1xUXfthFQ6iE9CnWTdwoDivNhSRUKrFHd24hC0pdUWiawuQK4UQx
   NW8iQPAQUvSoxp9JZ/hLeptuRs5mMNiZXrO2rzddElkk2N+zxv9WY5xDt
   SUgSFGAz0qYmr3yMakuJ+Kfrdb6JoZI/zDNfIJRwDwgTkqf+QpvrcdJD3
   Ag2OOir7paTQDaB2tMsSRtsR3/8cqQcXGRBjPv9XX5x3xe7oQ33NkujtJ
   XczHQ0vq3sCo+f/xOGy+z/4+KUx/dcuYCkoy5kUvUa319y89+RI4ZO9y7
   w==;
X-CSE-ConnectionGUID: 4Qfk0cGDQm6UYtwzr+00vg==
X-CSE-MsgGUID: k5Mw4KypQCmmKbXTBp63FA==
X-IronPort-AV: E=McAfee;i="6800,10657,11827"; a="82273981"
X-IronPort-AV: E=Sophos;i="6.24,224,1774335600"; 
   d="scan'208";a="82273981"
Received: from fmviesa010.fm.intel.com ([10.60.135.150])
  by fmvoesa112.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 25 Jun 2026 02:39:25 -0700
X-CSE-ConnectionGUID: UBTPy5/pQ9mKqp47S5m8lw==
X-CSE-MsgGUID: YZzoilatSte1YdL+8Bi42w==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.24,224,1774335600"; 
   d="scan'208";a="246550509"
Received: from fmsmsx902.amr.corp.intel.com ([10.18.126.91])
  by fmviesa010.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 25 Jun 2026 02:39:25 -0700
Received: from FMSMSX903.amr.corp.intel.com (10.18.126.92) by
 fmsmsx902.amr.corp.intel.com (10.18.126.91) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.37; Thu, 25 Jun 2026 02:39:24 -0700
Received: from fmsedg902.ED.cps.intel.com (10.1.192.144) by
 FMSMSX903.amr.corp.intel.com (10.18.126.92) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.37 via Frontend Transport; Thu, 25 Jun 2026 02:39:24 -0700
Received: from PH7PR06CU001.outbound.protection.outlook.com (52.101.201.9) by
 edgegateway.intel.com (192.55.55.82) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.37; Thu, 25 Jun 2026 02:39:24 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=EJMV4GWLPm5+HatpwwtrjG0Ym+hNTsZLd39MwBvhHDgLWG7DxUhXAa1GhXUzoIX5Pr/VZzIwwD6dCUPJFvyv27SJn9Fn/RyVDbJPdUt+kCmwSoGziUtP9Fhhf6hmlJiCPlJpZibCxBMgGvPCPYWQKj0BWVLuLXjwK+qC4+O4dzTya80rjhq+7nWPzlX4Y6egc3b4UN3/E9wGSnO1VRnISLrzPxqj9ZU6vPJZP/4jupQQH7EcPK/ptClrhKmyf9ZADrnFsc6V92zFVBVyTMYWe/MAl7xeSTWtWbtGevofDbtjJRr1Hhmnz9T80sHjUzOKGWPFPKNydwSPnPXn0eLrxQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=yTcsSkH3jX9KDT+LYy2nW/oIzQ9kKgsp8bVl5JCR09M=;
 b=CyTu9lUgifWfgssuHvu5Gvvyg9OYXBjE+rg79bwRL5apr9465vDlnoYR/m/o7xMrRcH/4RgrZRnjaHwqwnj1+zgmj5m1GgQGicoRYvTU7FJepJENSGHEQR83JOtTE41SGAa1bZb55fvQI1z4IXvcTkBtkdHScqrEprc5459S2Z61OfZYTpA9DjA/DvoVdIstvYoRd1WnDR4q8+5BePBV9d6joMtNhuCl+XWU+8TN9igLLmEFDjHhC+Vw0NesDHki9Sq0f95m0eQjYq9n0E9hxfKj2ZvLF9QovR2rmNHxrp4CMtGSjBsNG0QqwXhYnjcD3/L/wW4tebk51nPZ6bUx6g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from DM6PR11MB2556.namprd11.prod.outlook.com (2603:10b6:5:c6::10) by
 IA0PR11MB7861.namprd11.prod.outlook.com (2603:10b6:208:3de::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.159.14; Thu, 25 Jun
 2026 09:39:22 +0000
Received: from DM6PR11MB2556.namprd11.prod.outlook.com
 ([fe80::ab22:139c:b0e5:20ac]) by DM6PR11MB2556.namprd11.prod.outlook.com
 ([fe80::ab22:139c:b0e5:20ac%5]) with mapi id 15.21.0159.013; Thu, 25 Jun 2026
 09:39:22 +0000
Date: Thu, 25 Jun 2026 11:39:12 +0200
From: Larysa Zaremba <larysa.zaremba@intel.com>
To: Jiawen Wu <jiawenwu@trustnetic.com>
CC: <netdev@vger.kernel.org>, Mengyuan Lou <mengyuanlou@net-swift.com>,
	"Andrew Lunn" <andrew+netdev@lunn.ch>, "David S. Miller"
	<davem@davemloft.net>, "Eric Dumazet" <edumazet@google.com>, Jakub Kicinski
	<kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, Simon Horman
	<horms@kernel.org>, Kees Cook <kees@kernel.org>
Subject: Re: [PATCH net] net: libwx: fix VMDQ mask for 1-queue mode
Message-ID: <ajz3QK96wKoLD4n4@soc-5CG4396X81.clients.intel.com>
References: <60D88ADD3E295420+20260625090851.539640-1-jiawenwu@trustnetic.com>
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <60D88ADD3E295420+20260625090851.539640-1-jiawenwu@trustnetic.com>
X-ClientProxiedBy: VI1P190CA0048.EURP190.PROD.OUTLOOK.COM
 (2603:10a6:800:1bb::19) To DM6PR11MB2556.namprd11.prod.outlook.com
 (2603:10b6:5:c6::10)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM6PR11MB2556:EE_|IA0PR11MB7861:EE_
X-MS-Office365-Filtering-Correlation-Id: ddc77a30-dc9e-4ff0-2083-08ded29da2eb
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|10070799003|23010399003|1800799024|376014|7416014|18002099003|22082099003|56012099006|11063799006;
X-Microsoft-Antispam-Message-Info: skGRAXWD9YJ3Iy5Y3iQtt5GAxg6rxF7WDv3YUKKRIWEwqL+tu5D82bCB4rF5O8hb4DWU30HNF9HRxAOw/N6jODwHpSq+zB5zhh+gKLtouXERAcPzOT1BQhJ4PGCJ95PB08kCcUfoUD3TzBceianYocdU9nMnRRKiFbTbrDFD5Tdh5PnbfO6QTmVBKw+PIe9ivYSJUEXAQKH341fGjMaO3IqT7dV5/EvHbFXeCPfbnEztsEdl1Nm24SUKnNhP3hwaW8Vy2V5l5tkfzybeYz7I75wbB7adhYpabzwNSv9/u1ZYOV5hot7SeJOxDqsVz2ERueUfMuIBMfaLBG8dPOlzn+xdYlkUxulsAoY65yYGz5fzyhSDFtptUQRR05MwkHl0Mc173to8UxlHlun2qXszk/EKM8/FHxE0jH0yz2YI66ogTz+TfXwV6OfAd6GO+Z98mnahWDhlfUp0OBTyiWrko09myv8jrIEY2UVQDrnX7t3ehiqmEwk19XfJO0tVxoK2kzPMbipC141cWBXz79WfzBnDYJuovdiizIA5M5OZwne37qN8Z2lrEQ4I93GIhko/QQ2OTw3q2x8EPwX0whE/r6k1uez1gxIAGQ3SV4NA1fnufR9qm6NKySaAmsgfSpQFKK0H8m+MStxESwwjg0P9ZQAvh4c3TJbfb1uTl22Jdwg=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM6PR11MB2556.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(10070799003)(23010399003)(1800799024)(376014)(7416014)(18002099003)(22082099003)(56012099006)(11063799006);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 2
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?O43oXmpZP4j0d9uMkObKX6xOwZyBOp3hGzd0dWZaTEMnAc+lO2pZD0lGUwlJ?=
 =?us-ascii?Q?VhBDdcmYMK8bBiiudCum3aDZCjhGSmiSvlmSJRoWcl/jGDo3ZVGu8b3ah8/w?=
 =?us-ascii?Q?Ko5B4uWTXNQdeWw8O4lUirTaWVMH/pH7wglMPs/VTS5tAtgM0XUMSeo1K3g8?=
 =?us-ascii?Q?xVbADYA0OcE+Qz9oXIcfHkff9EjMf2qWLnokvt4F5Sf6ddPe1LyDwN0wQa/k?=
 =?us-ascii?Q?1U3WH9eqeIr4tFRUAlZN4VR6BmWPNsx4BalbgZshq2IDZFtAPzJzyj0Uqvbg?=
 =?us-ascii?Q?Vay48iNwpqhVSeoro6pb4lzx6SPG8WZSGnH+2UUGN6XcV7GJIEYqu/JnjBD5?=
 =?us-ascii?Q?MRskZFppxK9OakZBFnCEbUKQ/etnObF+2ERye4iu6hslF4j7PBHlSIkCWeMm?=
 =?us-ascii?Q?D/aW3TP8LqeGYplblsF1gaQ5cw3WqZVqXPJhLKRcALMuRfev8enzMzKOYvry?=
 =?us-ascii?Q?F3gyK0M7q7u3INQbWek84yj/DjLqSEwQjHtr6K3i4zscA3iFaUzfRRN0dMta?=
 =?us-ascii?Q?Ef4qEfzWGuS/uV8KWIW36s3PC0zZ/NbyJqcH7fMeL5EYhGrLO2GKYcvM9RKC?=
 =?us-ascii?Q?+ajwM0KR0JJCvkDCKiFcI2GdYw/Q0Hd6V38hlDSuZnY5Q7DSwxXAp/iKYR/V?=
 =?us-ascii?Q?Bk3MtcAnlt/M/KOMDeCUe4qpPiHYsOla/nNr71Z0USDQ7exQBs5nBWJL/a5I?=
 =?us-ascii?Q?98l2d5DNIxp0F6wi8Njg5xBqN+J2YNeRaIDfuXHMpZP9VzmuUcLIqkedfWjv?=
 =?us-ascii?Q?culHvkSxhBqcAD41b4K7nJTRaKAmS9aGlG1bpyuuYW8LN9AMrRbkHIMo+Jeo?=
 =?us-ascii?Q?YEzeBP2G6sXgJ/z2zgEfFUGX9xFEDb9UI+SwvzG/58XRPuQu6yjjTxahVQAO?=
 =?us-ascii?Q?wjHSa3tP4B7HMNZsr1zUqtQN+n6fSN9e0LILvKNIs4WayBOlv1JSftsxAFFf?=
 =?us-ascii?Q?sIShKTAI86HTbtLmKdpxF7vzVXVreRxv4/ALifZYqFFREUXa/hPuJYDaEVMB?=
 =?us-ascii?Q?jRqvoTADj5ShLRK0zQ3F/Yu7YkZzFNEb179ewDm1tGYdM5nqA0A3i3GgjNBc?=
 =?us-ascii?Q?AqR3baWzQDAAiR03is/6wsslegUbTec5fcZ9P1Q1b4qSevtor0NxvMhlTwQ2?=
 =?us-ascii?Q?MBeHlaZ7zwcLJ7Qji5CELliC2FHXLGu6qbKqYvoU01ERPJPVwGwSxH3oQkw6?=
 =?us-ascii?Q?n8Hrylzdu/BDxnyS0nK9Fh2qBxHXIN25QXPQr9Av5mm59D6sN5oDW1//iMhQ?=
 =?us-ascii?Q?N2tO2PUsgworgGDTsp61oKrh1VATm4GeAZj06uHbQcGlnT7x+7kLSSSQIuT0?=
 =?us-ascii?Q?yi1oI4FoC5CrNnuAuvTCWhgfBRYbZMNSrEjo4gqRoPz6+e0utPNMZllvAlej?=
 =?us-ascii?Q?yCLjqu5BKuKQcYY+sm9t0sYctk8Lu9OqZe/1LiI4pTJNR1eiwcrB3w3v0zFX?=
 =?us-ascii?Q?PwLl8RLaJFaLxPZye20AagHdL22TAFpTzaM7GreeETGDXntsYwZHubZ9Fbb7?=
 =?us-ascii?Q?cDEKAKuKx7oPvhe+syNaqEdL/cxjq8LQWj6EWlRObcb38RYgjgsXjApx96sX?=
 =?us-ascii?Q?ZfBLetEK47MFrcgDb6IBeqXSrftaSB2ty2ST2yjPKPENauaWzxTNsQm+/Gsv?=
 =?us-ascii?Q?chw++mIrrakkTrgTxeXa0lsE7XZo+nZbmyv51FKyOxi2eFigUIZ1v/Fd0pl9?=
 =?us-ascii?Q?2bHJal9xmGXcv7VlhLHQOyAMac+gyj9waVN6t8jTDxeJLg+1mWlWu/DUAWOq?=
 =?us-ascii?Q?WFGvpAtqyvWAPgEX5ROMO0Iy5QIa/g4s2HlO8J85MdR3YkyqqcyKDGUrH7Cb?=
X-MS-Exchange-AntiSpam-MessageData-1: rTcK2ox1+uFaVMS2/6TsmqVA7d5b1c2V2nM=
X-Exchange-RoutingPolicyChecked: jwBcXbU9kHssUVDsj6xO+KsD82LDv7DHUpuxDLSdzqs9zgmY8ZQGovrGiKzuH0URmFsL4e7BuCfG4HKtZUwMHToLMPSNmMG412zPXmg8C9lzZMWnz3oMXIWE6ndCqbswH1gOxCeR4O1aljDUUDKYx8jL4EocjGxiX10d9QFqHsrznUjLdcRqn3Sdx5PWUKGpm8wDYuSzUyDIbhxNoPELvNvMidRHkkH9tNO5OJYPFKmKApUqNSAbISZAPZ+QMZo6K8w2a3dz99cq5whKpsrkQmshiU4fQPWLlx1p1bDrN+6btSJUNi2FB13DNeYlkMU/cgQNkWE4xleCZwXO8y9FjQ==
X-MS-Exchange-CrossTenant-Network-Message-Id: ddc77a30-dc9e-4ff0-2083-08ded29da2eb
X-MS-Exchange-CrossTenant-AuthSource: DM6PR11MB2556.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 25 Jun 2026 09:39:22.2694
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: G8IuZg5NXewunkZXvnxRFXOqk1VElPENJbBOP3rOY4DnRD00NbHxlAosIFK0AWpCNltQMV5CfplnchMMOkboPkXMj5YVTVa6eQ5XQMUAl+U=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA0PR11MB7861
X-OriginatorOrg: intel.com
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-1.66 / 15.00];
	WHITELIST_SPF_DKIM(-3.00)[intel.com:d:+,kernel.org:s:+];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_REJECT(1.00)[cv is fail on i=2];
	DMARC_POLICY_ALLOW(-0.50)[intel.com,none];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	R_DKIM_ALLOW(-0.20)[intel.com:s=Intel];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-301914-lists,netdev=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:rdns,sea.lore.kernel.org:helo,vger.kernel.org:from_smtp,intel.com:dkim,intel.com:from_mime,soc-5CG4396X81.clients.intel.com:mid];
	FORGED_SENDER(0.00)[larysa.zaremba@intel.com,netdev@vger.kernel.org];
	MIME_TRACE(0.00)[0:+];
	FORGED_RECIPIENTS(0.00)[m:jiawenwu@trustnetic.com,m:netdev@vger.kernel.org,m:mengyuanlou@net-swift.com,m:andrew+netdev@lunn.ch,m:davem@davemloft.net,m:edumazet@google.com,m:kuba@kernel.org,m:pabeni@redhat.com,m:horms@kernel.org,m:kees@kernel.org,m:andrew@lunn.ch,s:lists@lfdr.de];
	FORWARDED(0.00)[lists@lfdr.de];
	FORGED_SENDER_MAILLIST(0.00)[];
	DKIM_TRACE(0.00)[intel.com:+];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[larysa.zaremba@intel.com,netdev@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	ALIAS_RESOLVED(0.00)[];
	MID_RHS_MATCH_FROMTLD(0.00)[];
	MISSING_XM_UA(0.00)[];
	RCPT_COUNT_SEVEN(0.00)[10];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	TAGGED_RCPT(0.00)[netdev];
	RCVD_COUNT_SEVEN(0.00)[10]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: E520F6C457A

On Thu, Jun 25, 2026 at 05:08:51PM +0800, Jiawen Wu wrote:
> In wx_set_vmdq_queues(), the VMDQ mask was not set for the devices not
> support WX_FLAG_MULTI_64_FUNC, i.e., NGBE devices. A mask of 0 causes
> __ALIGN_MASK(1, ~vmdq->mask) to return 0, which incorrectly sets
> q_per_pool to 0 in wx_write_qde().
> 
> Fix the VMDQ 1-queue mask to 0x7F then ensures that __ALIGN_MASK(1,
> 0x7F) correctly evaluates to 1.

__ALIGN_MASK(1, 0x7F) evaulates to 0x80 (128), not to 1. __ALIGN_MASK(1, 0x7E) 
evaluates to 1. Maybe you need 0x7D for 2 queues and 0x7E for 1 queue?

> 
> Fixes: c52d4b898901 ("net: libwx: Redesign flow when sriov is enabled")
> Signed-off-by: Jiawen Wu <jiawenwu@trustnetic.com>
> ---
>  drivers/net/ethernet/wangxun/libwx/wx_lib.c  | 1 +
>  drivers/net/ethernet/wangxun/libwx/wx_type.h | 1 +
>  2 files changed, 2 insertions(+)
> 
> diff --git a/drivers/net/ethernet/wangxun/libwx/wx_lib.c b/drivers/net/ethernet/wangxun/libwx/wx_lib.c
> index d042567b8128..814d88d2aee4 100644
> --- a/drivers/net/ethernet/wangxun/libwx/wx_lib.c
> +++ b/drivers/net/ethernet/wangxun/libwx/wx_lib.c
> @@ -1802,6 +1802,7 @@ static bool wx_set_vmdq_queues(struct wx *wx)
>  			rss_i = 4;
>  		}
>  	} else {
> +		vmdq_m = WX_VMDQ_1Q_MASK;
>  		/* double check we are limited to maximum pools */
>  		vmdq_i = min_t(u16, 8, vmdq_i);
>  
> diff --git a/drivers/net/ethernet/wangxun/libwx/wx_type.h b/drivers/net/ethernet/wangxun/libwx/wx_type.h
> index c7befe4cdfe9..65e3e55db1cf 100644
> --- a/drivers/net/ethernet/wangxun/libwx/wx_type.h
> +++ b/drivers/net/ethernet/wangxun/libwx/wx_type.h
> @@ -486,6 +486,7 @@ enum WX_MSCA_CMD_value {
>  
>  #define WX_VMDQ_4Q_MASK              0x7C
>  #define WX_VMDQ_2Q_MASK              0x7E
> +#define WX_VMDQ_1Q_MASK              0x7F
>  
>  /****************** Manageablility Host Interface defines ********************/
>  #define WX_HI_MAX_BLOCK_BYTE_LENGTH  256 /* Num of bytes in range */
> -- 
> 2.51.0
> 

