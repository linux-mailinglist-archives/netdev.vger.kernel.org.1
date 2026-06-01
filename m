Return-Path: <netdev+bounces-293781-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 6C+LNM+OHWr4cAkAu9opvQ
	(envelope-from <netdev+bounces-293781-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Mon, 01 Jun 2026 15:53:19 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [IPv6:2600:3c09:e001:a7::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 6C19162052A
	for <lists+netdev@lfdr.de>; Mon, 01 Jun 2026 15:53:19 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id AC3D73001031
	for <lists+netdev@lfdr.de>; Mon,  1 Jun 2026 13:53:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1ED2539E167;
	Mon,  1 Jun 2026 13:53:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="UwO9w92e"
X-Original-To: netdev@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.15])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 78A753ACF17
	for <netdev@vger.kernel.org>; Mon,  1 Jun 2026 13:53:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=192.198.163.15
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780321996; cv=fail; b=XWv+TeDgDxazPwjo7zBtunttiw/WaP169+bw0/vAacTkI4eZlU6JMitRPEg9FFzC5sKSV4ugtEY6yMJbcXTxT7Mmm6Uwgaq1Xc8qH7v2zLRfxSDwl8lGlNPf53e0VXLTG7VRpw2P6fsSU569fgyxDepHkNA/z27U35pDTFYCoEo=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780321996; c=relaxed/simple;
	bh=y3P5x+8GqVJsmMfhOPWb43I5vI1ulEQRCekgBaCSGAk=;
	h=Date:From:To:CC:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=qpTnZ0dZtfn3oNsEBVS+8lIXumsFG4wIsihqK8M59Owpj6dtsKxUBIIO/Fr50scoNTLblEcXvY1FB+diCSAXdbEOaHLA0WNxrVrzKshKgcA67hgApPXB6bYqdi/NPaWWqzFfF5LO4rv17trg0d8PW39oY+4xIYDis2F4hGqnOko=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=UwO9w92e; arc=fail smtp.client-ip=192.198.163.15
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1780321995; x=1811857995;
  h=date:from:to:cc:subject:message-id:references:
   in-reply-to:mime-version;
  bh=y3P5x+8GqVJsmMfhOPWb43I5vI1ulEQRCekgBaCSGAk=;
  b=UwO9w92e0WGZGm0t65HPqfEEoGLUdMyQmb7VryesZOcpO/8pvnNmcrwg
   x+XaZU1P9P2W6jKMWiapGQSn8mx23xjpOssh1YgQUhj0+0TkD+k+lFALR
   9SuaA2JFt3/ZRUQVI+/KwuZ3hDm2oy1F4uCjCHY+/518D0TRRVL0MPP+q
   gaFIIVPVKjTKtcjD6KACtEdFoACGV89DBwULyy49bO1K08Ffgjw/sVeL2
   8Ka02bjqEtjyXf+X/sfS4hxpakXTBr4897ikhiio2LclODqA2U6Xh4tM4
   iB2TnPnO73JNyI+4vYb5fawvecWlpQiT2nubzCiSEBxOm7bFUSexlc8Ux
   w==;
X-CSE-ConnectionGUID: vCa+j1WwS7qIMbvBygZ8qQ==
X-CSE-MsgGUID: 7/wzYtF9SNK7gWPRBl0RyQ==
X-IronPort-AV: E=McAfee;i="6800,10657,11804"; a="81191403"
X-IronPort-AV: E=Sophos;i="6.24,181,1774335600"; 
   d="scan'208";a="81191403"
Received: from orviesa010.jf.intel.com ([10.64.159.150])
  by fmvoesa109.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 01 Jun 2026 06:53:14 -0700
X-CSE-ConnectionGUID: ZyYIppmUSSaYYD0DUQNncA==
X-CSE-MsgGUID: RPtMeGvjRtSFu5XsFy2LuQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.24,181,1774335600"; 
   d="scan'208";a="242768773"
Received: from fmsmsx903.amr.corp.intel.com ([10.18.126.92])
  by orviesa010.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 01 Jun 2026 06:53:13 -0700
Received: from FMSMSX902.amr.corp.intel.com (10.18.126.91) by
 fmsmsx903.amr.corp.intel.com (10.18.126.92) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.37; Mon, 1 Jun 2026 06:53:13 -0700
Received: from fmsedg903.ED.cps.intel.com (10.1.192.145) by
 FMSMSX902.amr.corp.intel.com (10.18.126.91) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.37 via Frontend Transport; Mon, 1 Jun 2026 06:53:13 -0700
Received: from MW6PR02CU001.outbound.protection.outlook.com (52.101.48.15) by
 edgegateway.intel.com (192.55.55.83) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.37; Mon, 1 Jun 2026 06:53:12 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=MwcdezPkny2/KJ57+MPZIsFwgpCYdZ5CO9HvnasEYndgPO8t4SEIGk6pbhTfU11ishlKfYUQGCTenDI7VJcF0lf3ob9epWg1ajyDIQCP38fMm5fkNviURCGV2NRjtzJ2TSOwoMiv8limmsJyInuLB5kwgq3IkqF0PVH6xl4K7xjhPmffuYF9ON8w0TR6uIA1l8C7qINJCm7SPwvL0cADcLCZDSGltoRst0MUC2NbE12zfudCXBC9wlGjxGZeOFzPPnHA4slivDb0UQMylxeWomzIpIqlHvqsVcb6AVJnKIkhyptvQCx0x/qXZlNq/EFMu5vwMUt9zthfvNJreUMMBQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=zQp7jqo2YRbpKQVACkjuT29CQS5wUKJ8cTs24DlXNZI=;
 b=YjC10JC+ipf3H1jhkdoQzgdqjJBOSKNYohGLIQt8eptXjMywfEjwZXk+MAfZJ95zrhr0rITBuT4wqTfZU5wF0xcRBmC/bikh/ba5F5D2ofJCjwXXj+p7F7RGFkDBLGs7UPHwm85PYP3XkgCXuSrKj90pvXJFxsC3CvMxLLOEY9TtP9cWC4u4iuxZq+xXLRglY76zGxKbwyqOKnFfaRM1u3hI3RlTexJQGlRXMiwQPNyqXooEAsR3Hv1qtPVem5F4mM0P2Ei/Ts63jr73z3YeHsjUAQKvIYubKx5aR6AQxMOdpz85osXQi3csPsjzv18ZtvNKI0T3ZWObPcec2iju1g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from SN7PR11MB7540.namprd11.prod.outlook.com (2603:10b6:806:340::7)
 by SA1PR11MB6759.namprd11.prod.outlook.com (2603:10b6:806:25e::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.71.16; Mon, 1 Jun 2026
 13:53:09 +0000
Received: from SN7PR11MB7540.namprd11.prod.outlook.com
 ([fe80::2edd:5c6d:169c:389b]) by SN7PR11MB7540.namprd11.prod.outlook.com
 ([fe80::2edd:5c6d:169c:389b%6]) with mapi id 15.21.0071.015; Mon, 1 Jun 2026
 13:53:08 +0000
Date: Mon, 1 Jun 2026 15:52:57 +0200
From: Larysa Zaremba <larysa.zaremba@intel.com>
To: Maciej Fijalkowski <maciej.fijalkowski@intel.com>
CC: Jakub Kicinski <kuba@kernel.org>, <anthony.l.nguyen@intel.com>,
	<davem@davemloft.net>, <pabeni@redhat.com>, <edumazet@google.com>,
	<andrew+netdev@lunn.ch>, <netdev@vger.kernel.org>, <vinschen@redhat.com>,
	<alexander.nowlin@intel.com>
Subject: Re: [PATCH net 1/8] ice: fix UAF/NULL deref when VSI rebuild and XDP
 attach race
Message-ID: <ah2OuScZKhJYhwGp@soc-5CG4396X81.clients.intel.com>
References: <20260520183501.3360810-2-anthony.l.nguyen@intel.com>
 <20260523001616.1757210-1-kuba@kernel.org>
 <ahgHZ8NNWPeFVsXr@boxer>
 <ahlIwmIHiPsB50Zn@soc-5CG4396X81.clients.intel.com>
 <ah15Ti7O2m3Hj2T+@boxer>
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <ah15Ti7O2m3Hj2T+@boxer>
X-ClientProxiedBy: VI1PR04CA0119.eurprd04.prod.outlook.com
 (2603:10a6:803:f0::17) To SN7PR11MB7540.namprd11.prod.outlook.com
 (2603:10b6:806:340::7)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SN7PR11MB7540:EE_|SA1PR11MB6759:EE_
X-MS-Office365-Filtering-Correlation-Id: 0aa476e9-65d4-4c02-66a1-08debfe51ca0
X-LD-Processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|376014|10070799003|366016|6133799003|22082099003|18002099003|3023799007|11063799006|4143699003|5023799004|56012099006;
X-Microsoft-Antispam-Message-Info: awBNwM1IVXFIxnt6S3Wti0227CGGWxymouhkXFPNMNWd04ASmS1a7CaQ1UdbMdBCewBHGPok1Ya9PCiiU9AcYEexQXSq9aXFK1QhyJ3ylYA33jd5b+YFNRE7e0xtvnnjEuEg5OMiv3fWcKjFtgdFmNkISWknV3DoIAhzaPr3UaIwQ5vc8yDd6757h7QImVWlRSq0vS/dN0f6iQJd//4+hBSPTfCNqiJWMBwgar/eeH1i1WcEC+HsQnhYAl6ziQjW54FA4LHsA2Za66Ldmy5K2nuJCoFWpqgvS/v0yXaGl1OtsSjGX32wU7AmU6e5AokBQXtOBTGZx3vMzcCrigB8pT3PBHmhBOEDCpyrWv8kcAI2ZNlWx7npUF2ezc4qKif5OTV4tLmLwoNr2H6L/VapcRqnIye/xgZYDd0ELSCic8I9aC/S3oNpUycaW/rA7xC3i2tCjaH8hdonMQHpEMI1SgTz3Z8hTEyIjUElzGyIsPPIkicMfDHkdIMyBVO/Zu62f1hGvgFa3c2bGlm+KjZbYcpB+xvdefvQC3sxwmHhjKR6u/kvGoi/ealzO3Zp3zF8E5PXYVJiF2b6utCEswsdGYXM/npJoMXR705qiHHKmKfMyYu1+Mjj/TxfZFvCmKJe31FV3YshbXLu/lKl3lHyHnZGVcnSDjoboHbvMn06YACm8C8uUvWCN/bIvD2p92lq
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SN7PR11MB7540.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(376014)(10070799003)(366016)(6133799003)(22082099003)(18002099003)(3023799007)(11063799006)(4143699003)(5023799004)(56012099006);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 2
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?4PkbgBkz1+nf6C9DpP/pvU5fpX8ZaltbOBHQaE4e3U1SDk2wSoX3IgcOanDP?=
 =?us-ascii?Q?BxVFUxy9d2AzHOKaF+CpLePUy1uj0lw9nqamyiOb2VaHHnHTMmB1AxuZhe0z?=
 =?us-ascii?Q?b3/aInb5pebvYQczSO5jpTHnrkeIIB6oXFPuwUXrh7WPYSgKaKRDHfBZub+j?=
 =?us-ascii?Q?wH1iJ/7ruwXxVgleyo8LavBnUQHRo9DJFDkFU9dl5AdhnE5T02KjizsFbvvG?=
 =?us-ascii?Q?YZ6QMQHnvAGfZw3NTFWuOaKGMTmnfRBhW1AhrIyhbzdMLbaGsGUiyKNs/4S2?=
 =?us-ascii?Q?2WKa9eDVtxsaVrf63YSKWzrneGF5mN9Mli+6dhzTk6NGZZQ0hkVviiIQc7Fe?=
 =?us-ascii?Q?a/dtSqq/YFaMXwOW+nTflCcX0RULg5751PStLuqa2CC/4CQPYNELnh/OuZ5j?=
 =?us-ascii?Q?MH4iBLnAorM/aK1Jlul+9MOsOFOMW92EK1D2xINxUUNatGas4KXcfMMirRup?=
 =?us-ascii?Q?ACFh1i9vr7xfoOGvT1Llad5MQx9vZQOQA7t2wTw8yaP9sBD4mW0I9s4c4I9n?=
 =?us-ascii?Q?WWOpm0mrnX7stEBolGFE2jAQ/rCe8yfQtLA7tXodR0+uekZDRlSKQUFoIBS+?=
 =?us-ascii?Q?5d7Eu0aV6FHxmZR58DjW1osjI3nAF8OlKQ5D8aZ63SzVEdvP6tblOG7wyJpN?=
 =?us-ascii?Q?Aeq5HjwW51HQVqG3PaPdOiAIovUw57RSeL1yXEyvXjuQ1T/w8hUHs3Q+xojP?=
 =?us-ascii?Q?1FEubfS/GqXgAmv4QThG1v5HVlFBFOcpNihe+OdGRMrF9mXyCS19H35a+IWo?=
 =?us-ascii?Q?GiGOQVvuotb0uB5fvNkfdnrLv1uCJNUEmewPLvg0tVcQkccVhJSKqgBsrcPV?=
 =?us-ascii?Q?iTI2hBBXiZnrp/X+IiSz8GLtGhPUcM5EZyLsAiJtrDjMIPuBkDnpzNs0ZhXw?=
 =?us-ascii?Q?xe4/SWyo4RO2F5uVZtKfu9VFqME8k4VKCSAApFC0YUHFEYo8YytJEJ/dTxA7?=
 =?us-ascii?Q?NGZKjASvCMCHIlupT90Knz+IuuNREQ3SEIwp7Nn9Zos3J5avaAJhj3FMBoNc?=
 =?us-ascii?Q?jCbst5xSAy+k2KDqNwIrWyO7MKyBv4anxABCLprYtxbLQl7nAuB4kREUnN+t?=
 =?us-ascii?Q?Ss2JG4soh/A796JHYqpNn0bF0zdWtav5LqkMzXcYYrvTcg0+a6d14gHXva9e?=
 =?us-ascii?Q?CW32+eigUOlUnKEP/yH0Pg3p/F1X/VCdI+s8J0KLifjxl36TyerX81FI4Dti?=
 =?us-ascii?Q?gQqaiMxGggeb0REgEfjwF+v1IIh5apUzL/cLIdAMVWhczJIrXhDQ4H3X5ozN?=
 =?us-ascii?Q?XT7A1OKGNIaAct/rJLkmTXwf2126PCUSzo6Yk48pcROo/GzJZJgNOrKd0PpY?=
 =?us-ascii?Q?yeXJPz/GkmTqeBxTGcVe45MfVuEiPK2FFUsaJ42oRlwob3n1zuBXD95y6SUC?=
 =?us-ascii?Q?y1CIxjGz9VxDSMrkpgGzBh+w+IyqG+vulrIUVlAyEZF2fmL/5LYuzY1oISUx?=
 =?us-ascii?Q?YeKUDPEzDqeUb7WQ04Lj3jjQ+jApIlzyxIFPSk9KdM3Xluh4einkAqQ0M/f8?=
 =?us-ascii?Q?ST30vaL56U5xRMTUjjDSaJacUfbGg3n792DaLAZnCErKUZm1AFg2szGmuh3E?=
 =?us-ascii?Q?1Bdqa0iyQtHE+zADXH0cud4IoCJRabolJoqLOKxCyGU+9RCmiIghVgVnhsEd?=
 =?us-ascii?Q?lTvbbk35RrgQqHMj1q6lnDlI4Dg0niLrc4XWV2m59RY7akwJZWqZTSsUNljo?=
 =?us-ascii?Q?n+L81NWIJb6Qmoey/f8JC9vBAnpT7rpxtncMUEQyPXsOhNXczp8s/VdJXN57?=
 =?us-ascii?Q?C5V69wXf4sSgVx54gUJPIodi7mhkmSH1W2w7pO60uQ8kF8fFDfM+WcqS4ioK?=
X-MS-Exchange-AntiSpam-MessageData-1: S0gOSce+3yC7Yc+K68sKnxF4oMOH1awZKhY=
X-Exchange-RoutingPolicyChecked: I2RURSqWLfFyx+MYtNa0SYMjy4IVYqXIwGRhv3OQZR5/DXHK2eSUMNtgOPRtnoaqYsAZSQBLaywmzbnSIM01SONtIHNHxzaKA8UCj1eef0zyskZ2NVUi8QvKaEHPfGG5yWJc8RODhnjP1s7L+U4XSuRLtA9TZwskvGHEVesdka5JLnkiwfbUQR6/8AZnbjZLlJBM78H8SIIQScjYhLHj/tUpCOIUDzU/1XLMNcm9Bmma2h4//iHS+wIUhIlIYHhVxSiex4Ig8YfoKTgakc1leVYufxN/IinMO7ecvnaFox+AbUMV9JDAhUvp8Md1XdAYi8e/9kVC3jy2W7TByJZNyg==
X-MS-Exchange-CrossTenant-Network-Message-Id: 0aa476e9-65d4-4c02-66a1-08debfe51ca0
X-MS-Exchange-CrossTenant-AuthSource: SN7PR11MB7540.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 01 Jun 2026 13:53:08.6936
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 7QuSMqDThiDfNS2/8pGzHE9Vi3smQmumMuZ2BWCOZEIXRc7vgVbdrxrcKp0Gm9CALywOjvdSpfskGN7SkbmXLFQ+pv+Jvz3sGxOS4Mq6V8s=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA1PR11MB6759
X-OriginatorOrg: intel.com
X-Spamd-Result: default: False [1.34 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_REJECT(1.00)[cv is fail on i=2];
	DMARC_POLICY_ALLOW(-0.50)[intel.com,none];
	R_DKIM_ALLOW(-0.20)[intel.com:s=Intel];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c09:e001:a7::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[intel.com:dkim,sto.lore.kernel.org:rdns,sto.lore.kernel.org:helo];
	RCVD_TLS_LAST(0.00)[];
	DKIM_TRACE(0.00)[intel.com:+];
	TAGGED_FROM(0.00)[bounces-293781-lists,netdev=lfdr.de];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c09::/32, country:SG];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[larysa.zaremba@intel.com,netdev@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	MISSING_XM_UA(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	RCPT_COUNT_SEVEN(0.00)[10];
	MID_RHS_MATCH_FROMTLD(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	RCVD_COUNT_SEVEN(0.00)[10]
X-Rspamd-Queue-Id: 6C19162052A
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

On Mon, Jun 01, 2026 at 02:21:34PM +0200, Maciej Fijalkowski wrote:
> On Fri, May 29, 2026 at 10:05:22AM +0200, Larysa Zaremba wrote:
> > On Thu, May 28, 2026 at 11:14:15AM +0200, Maciej Fijalkowski wrote:
> > > On Fri, May 22, 2026 at 05:16:16PM -0700, Jakub Kicinski wrote:
> > > > This is an AI-generated review of your patch. The human sending this
> > > > email has considered the AI review valid, or at least plausible.
> > > > ---
> > > > ice: fix UAF/NULL deref when VSI rebuild and XDP attach race
> > > > 
> > > > This commit addresses a race condition between a VSI rebuild and an XDP
> > > > attach operation. It prevents rx_ring->xdp_prog from being populated before
> > > > rx_ring->xdp_ring is valid by rejecting the XDP attach when a VSI rebuild
> > > > is pending. XDP detachment is still permitted during this window to clear
> > > > the existing program.
> > > > 
> > > > Fixes: 2504b8405768 ("ice: protect XDP configuration with a mutex")
> > > > 
> > > > > diff --git a/drivers/net/ethernet/intel/ice/ice_main.c b/drivers/net/ethernet/intel/ice/ice_main.c
> > > > > --- a/drivers/net/ethernet/intel/ice/ice_main.c
> > > > > +++ b/drivers/net/ethernet/intel/ice/ice_main.c
> > > > [ ... ]
> > > > > @@ -2912,12 +2912,21 @@ ice_xdp_setup_prog(struct ice_vsi *vsi, struct bpf_prog *prog,
> > > > >  	}
> > > > >  
> > > > >  	/* hot swap progs and avoid toggling link */
> > > > > -	if (ice_is_xdp_ena_vsi(vsi) == !!prog ||
> > > > > -	    test_bit(ICE_VSI_REBUILD_PENDING, vsi->state)) {
> > > > > +	if (ice_is_xdp_ena_vsi(vsi) == !!prog) {
> > > > >  		ice_vsi_assign_bpf_prog(vsi, prog);
> > > > >  		return 0;
> > > > >  	}
> > > > >  
> > > > > +	if (test_bit(ICE_VSI_REBUILD_PENDING, vsi->state)) {
> > > > 
> > > > [Severity: High]
> > > > This is a pre-existing issue, but is the check for ICE_VSI_REBUILD_PENDING
> > > > prone to a TOCTOU race because it relies on ad-hoc flag synchronization
> > > > instead of proper locking with the device reset path?
> > > > 
> > > > The asynchronous reset path (ice_prepare_for_reset()) sets
> > > > ICE_VSI_REBUILD_PENDING without holding vsi->xdp_state_lock or rtnl_lock().
> > > > 
> > > > If ice_xdp_setup_prog() (which holds both locks) checks the bit before it
> > > > is set, it proceeds to configure XDP and sets ICE_VSI_DOWN. If the reset
> > > > path then sets the bit and calls ice_pf_dis_all_vsi(), it will skip this
> > > > VSI because ICE_VSI_DOWN is already set.
> > > >
> > 
> > Here is ice_dis_vsi()
> > 
> > void ice_dis_vsi(struct ice_vsi *vsi, bool locked)
> > {
> > 	bool already_down = test_bit(ICE_VSI_DOWN, vsi->state);
> > 
> > 	set_bit(ICE_VSI_NEEDS_RESTART, vsi->state);
> > 
> > 	if (vsi->netdev && (vsi->type == ICE_VSI_PF ||
> > 			    vsi->type == ICE_VSI_SF)) {
> > 		if (netif_running(vsi->netdev)) {
> > 			if (!locked)
> > 				rtnl_lock();
> > 			already_down = test_bit(ICE_VSI_DOWN, vsi->state);
> > 			if (!already_down)
> > 				ice_vsi_close(vsi);
> > 
> > 			if (!locked)
> > 				rtnl_unlock();
> > 		} else if (!already_down) {
> > 			ice_vsi_close(vsi);
> > 		}
> > 	} else if (vsi->type == ICE_VSI_CTRL && !already_down) {
> > 		ice_vsi_close(vsi);
> > 	}
> > }
> > 
> > For __LINK_STATE_START netdevs, DOWN state is rechecked under rtnl_lock() 
> > before closing VSI, so we do not have to worry about XDP and other configuration 
> > functions tempering with it.
> > 
> > For !netif_running() netdevs, the only situation, when there could be such 
> > problem is if the whole .ndo_open() finishes and another rebuilding 
> > (rtnl-locked) callback starts and sets ICE_VSI_DOWN in between
> > 
> > `if (netif_running(vsi->netdev))` and `ice_vsi_close(vsi)`
> > 
> > Which is already unlikely.
> > But I think this is not possible at all since ndo_open() will not succeed while 
> > we are in a reset path, so no rtnl-locked callback will see !ICE_VSI_DOWN state.
> > 
> > It would be more robust to check for netif_running(vsi->netdev) under rtnl_lock 
> > too, but the code should work as-is.
> 
> I think issue is not about repeated ice_down() scope but rather the
> allocations that could overwrite existing objects as we skipped these
> calls which ice_vsi_close() has in it:
> 
> 	ice_vsi_clear_napi_queues(vsi);
> 	ice_vsi_free_irq(vsi);
> 	ice_vsi_free_tx_rings(vsi);
> 	ice_vsi_free_rx_rings(vsi);
> 
> ?

I still do not think that is what AI meant, but I do see the problem here.

So, if XDP setup fails, and we are stuck in an ICE_VSI_DOWN state, we will not 
free the proper resources in case of a reset. But if setup goes as expected, 
we are fine, because ICE_VSI_DOWN would be cleared.

I am hesitant to propose a concrete solution currently, because while the 
problem above would be resolved by an additional state flag in case of 
rtnl-locked callbacks, we also have ice_down() in ice_eswitch_setup_env(), and I 
am not sure how it is synchronized, if at all :(

> 
> > 
> > > > When ice_xdp_setup_prog() finishes, it calls ice_up() which clears
> > > > ICE_VSI_DOWN and starts enabling hardware queues while the device is
> > > > actively undergoing a hardware reset (ice_do_reset()).
> > > > 
> > > > Can writing to hardware registers during an active reset cause hardware
> > > > hangs or PCI master aborts?
> > > > 
> > > > > +		if (prog) {
> > > > > +			NL_SET_ERR_MSG_MOD(extack, "VSI rebuild is pending");
> > > > > +			return -EAGAIN;
> > > > > +		}
> > > > > +
> > > > > +		ice_vsi_assign_bpf_prog(vsi, NULL);
> > > > 
> > > > [Severity: High]
> > > > This is a pre-existing issue, but does detaching an XDP program while a VSI
> > > > rebuild has failed lead to a NULL pointer dereference here?
> > > > 
> > > > If a VSI rebuild fails, ice_vsi_decfg() frees vsi->rx_rings and sets the
> > > > pointer to NULL via ice_vsi_free_arrays(), but leaves vsi->num_rxq
> > > > non-zero. The ICE_VSI_REBUILD_PENDING bit remains set because it is only
> > > > cleared on the success path in ice_vsi_rebuild().
> > > > 
> > > > If a user subsequently detaches XDP, ice_xdp_setup_prog() intercepts it
> > > > because ICE_VSI_REBUILD_PENDING is set, and it calls
> > > > ice_vsi_assign_bpf_prog(vsi, NULL).
> > > > 
> > > > This function loops up to vsi->num_rxq:
> > > > 
> > > > ice_vsi_assign_bpf_prog() {
> > > >     ...
> > > >     ice_for_each_rxq(vsi, i)
> > > >         WRITE_ONCE(vsi->rx_rings[i]->xdp_prog, vsi->xdp_prog);
> > > >     ...
> > > > }
> > > > 
> > > > Since vsi->rx_rings is NULL, does this cause a guaranteed NULL pointer
> > > > dereference panic?
> > > 
> > > CC: Larysa
> > > 
> > > Seems we should check if vsi->rx_rings != NULL plus
> > > ICE_VSI_REBUILD_PENDING should be cleared on error path in
> > > ice_vsi_rebuild().
> > 
> > I think checking (vsi->rx_rings != NULL) should be sufficient. Not sure about 
> > clearing ICE_VSI_REBUILD_PENDING, if a rebuild has failed and the device is 
> > disfunctional, rebuild is still to be expected at some point, and XPD changes 
> > should not have any effect before then.
> > 
> > > 
> > > Do you have any comment on TOCTOU issue mentioned above?
> > > 
> > > > 
> > > > > +		return 0;
> > > > > +	}
> > > > > +
> > > > >  	if_running = netif_running(vsi->netdev) &&
> > > > >  		     !test_and_set_bit(ICE_VSI_DOWN, vsi->state);
> > > > -- 
> > > > pw-bot: cr
> > > > 

