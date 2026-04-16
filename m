Return-Path: <netdev+bounces-278922-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id YKOREG1n4GnZgAAAu9opvQ
	(envelope-from <netdev+bounces-278922-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Thu, 16 Apr 2026 06:37:01 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [104.64.211.4])
	by mail.lfdr.de (Postfix) with ESMTPS id 3FD4540A322
	for <lists+netdev@lfdr.de>; Thu, 16 Apr 2026 06:36:58 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id E16B8300980A
	for <lists+netdev@lfdr.de>; Thu, 16 Apr 2026 04:36:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CFB4E3314B7;
	Thu, 16 Apr 2026 04:36:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="Np75FllL"
X-Original-To: netdev@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.21])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 74C44330648;
	Thu, 16 Apr 2026 04:36:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=198.175.65.21
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776314214; cv=fail; b=OLiW6e4tMNQYj3qGMJBDL5leTtyAb3aRpegfQRyoZ6utQSlv3RlVJNVSI3xSkXf/2D8M/FEzaXRfFWjrjVQSWET5wiu4iK19ENfvEFbsLHE5EjtGLnB/z38QDsA33DGm4YcVhuIXRKRjLCc6yooJtu/zO7z1CjVeP9po8mTqJfs=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776314214; c=relaxed/simple;
	bh=ZZfEeLrTwrmrEypYMBXIiZOfObfp0ImwWfwaFXWwZKg=;
	h=Message-ID:Date:Subject:To:CC:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=N7/Cg7jy/pFmVhEQSBuEBAmN1wAxsUmLTUWaOK0lvVl5DNnsPSaJiv05aM3R0T5NiJjA+s1vFDiwaBUsHVxXzy2x8wnu5Ninn0dPOXnK9nbYKtKwv5/9zefXST5kcR7ygJA01xSN8ymIrPhIdOROIY5Nfktq8rA6g6Yad8otc9I=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=Np75FllL; arc=fail smtp.client-ip=198.175.65.21
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1776314213; x=1807850213;
  h=message-id:date:subject:to:cc:references:from:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=ZZfEeLrTwrmrEypYMBXIiZOfObfp0ImwWfwaFXWwZKg=;
  b=Np75FllLsIPOgsOe0vFwC2Pk5aX7/g/GJdm6K44e+6qtnlxx41bxGQHs
   WQrr6U78TNzSqycM1M9PBSG0kxOZ5IpU/y914DlVMB2tMpnmSmSE3w7rj
   W6MbTCv3oMNxnpqrGUKeSzEbquqbYuiAahNrEj5njOhK+SJA1W3xeCQe2
   I/I+a9jYkE6mcJAGGMdC8UgHSKg/3l3JJ3bsdZo1kgmywjz+OAxyxMpmz
   zCcKCbBSRkcr39UNJc7bKig8AqgOlLWdkUamN1tUJbT/bnXI0C1L3arXC
   0oYLv5muTKOIR/gwcXiWCGpHP/Q7gOkmqfTpIgc6C5yXlsyWEqn0KMA8Z
   w==;
X-CSE-ConnectionGUID: clSOfpB5SI+0p77DVswi8w==
X-CSE-MsgGUID: kDl4kfLcRHyZJDfrGKbw4Q==
X-IronPort-AV: E=McAfee;i="6800,10657,11760"; a="77178931"
X-IronPort-AV: E=Sophos;i="6.23,181,1770624000"; 
   d="scan'208";a="77178931"
Received: from fmviesa009.fm.intel.com ([10.60.135.149])
  by orvoesa113.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 15 Apr 2026 21:36:53 -0700
X-CSE-ConnectionGUID: OePc8m2LQzGEfgSb7UNbwA==
X-CSE-MsgGUID: 3HVm+8NSQLi3Or+I8+rDrQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.23,181,1770624000"; 
   d="scan'208";a="224109151"
Received: from orsmsx902.amr.corp.intel.com ([10.22.229.24])
  by fmviesa009.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 15 Apr 2026 21:36:51 -0700
Received: from ORSMSX901.amr.corp.intel.com (10.22.229.23) by
 ORSMSX902.amr.corp.intel.com (10.22.229.24) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.37; Wed, 15 Apr 2026 21:36:51 -0700
Received: from ORSEDG902.ED.cps.intel.com (10.7.248.12) by
 ORSMSX901.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.37 via Frontend Transport; Wed, 15 Apr 2026 21:36:51 -0700
Received: from BN8PR05CU002.outbound.protection.outlook.com (52.101.57.36) by
 edgegateway.intel.com (134.134.137.112) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.37; Wed, 15 Apr 2026 21:36:50 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=GqqKIudQEI+JyoCKXTc01wvgtqpLsd5G8UZXQPNjvMaRlWRa3cTBB4RiCHmJkX4NbLdh4HBazArbX5w40CmGPw+KfhDOIqgPPkt1Npp5rp42+DP7XVSt+Xy130WCqQKYenJvljGbRRrRl1sVS9wC2ho7DOpE9+pJ+nNM4O4nll6Tn/CGAYYjWdwnwPOxCNv6JxYFL+8gnUWkBcaOcflLIIAZLp5f58XIsO+EXwh2zwHrfkfQ1F2cdAXdAu67W2ok0lUJdDMw9M6Pv/VnkvWpg2n70Lp6RjEKXlwwK4ekDoIj1DKrLxS6HNRCVuI3avyc4yAuSAsplCSIkP4W2pCitQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=hbQhn9BdombBSdotYhOov2EOlI0v3fjoo0MgyOn0/OU=;
 b=lj/GILd8wLikGTCwdlk8S/8NSgwKx+khkAA1x2sIT0PAzXxJCOPyB+hYluNpPbmY8Mgl4WStd6atcBBWCGztDQfA/mz6vxV2yBrDdgm5yE9PJrwvQU35Hfp/QmU9nSWWHW4zstxpf23EdDPlWRGwtNa5r8P0ci1+oEBQO/gEiP0+StCl5JMklOiApltfj/mmwshZYenRhgtRA8o1SzFMXLjSjAX00OOR0avTpV0b2Y2HXEQG5YU16G4+Y+JIwyzoXKzRmrEikbdjZhVmQANT1LfyUz5CacfbWWbIXNbIUQ1pAA1ww9coIFrTmxU4drja1Pn0ygBPoOtnKorzwIm+wQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from MN6PR11MB8102.namprd11.prod.outlook.com (2603:10b6:208:46d::9)
 by SN7PR11MB6680.namprd11.prod.outlook.com (2603:10b6:806:268::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9818.21; Thu, 16 Apr
 2026 04:36:42 +0000
Received: from MN6PR11MB8102.namprd11.prod.outlook.com
 ([fe80::8d98:e538:8d7:6311]) by MN6PR11MB8102.namprd11.prod.outlook.com
 ([fe80::8d98:e538:8d7:6311%5]) with mapi id 15.20.9818.017; Thu, 16 Apr 2026
 04:36:41 +0000
Message-ID: <e62469a2-4090-4ab9-9a6e-ba9ce035b717@intel.com>
Date: Thu, 16 Apr 2026 06:36:35 +0200
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH iwl-net] ice: fix infinite recursion in ice_cfg_tx_topo
 via ice_init_dev_hw
To: Jacob Keller <jacob.e.keller@intel.com>, Simon Horman <horms@kernel.org>,
	Petr Oros <poros@redhat.com>
CC: <netdev@vger.kernel.org>, Tony Nguyen <anthony.l.nguyen@intel.com>,
	"Andrew Lunn" <andrew+netdev@lunn.ch>, "David S. Miller"
	<davem@davemloft.net>, "Eric Dumazet" <edumazet@google.com>, Jakub Kicinski
	<kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, Aleksandr Loktionov
	<aleksandr.loktionov@intel.com>, Nikolay Aleksandrov <razor@blackwall.org>,
	Daniel Zahka <daniel.zahka@gmail.com>, Paul Greenwalt
	<paul.greenwalt@intel.com>, "Dave Ertman" <david.m.ertman@intel.com>, Michal
 Swiatkowski <michal.swiatkowski@linux.intel.com>,
	<intel-wired-lan@lists.osuosl.org>, <linux-kernel@vger.kernel.org>
References: <20260413191420.3524013-1-poros@redhat.com>
 <20260415163003.GP772670@horms.kernel.org>
 <f30ad78e-1eb9-4c9d-9034-c8873966de66@intel.com>
From: Przemek Kitszel <przemyslaw.kitszel@intel.com>
Content-Language: en-US
In-Reply-To: <f30ad78e-1eb9-4c9d-9034-c8873966de66@intel.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: DU7P189CA0030.EURP189.PROD.OUTLOOK.COM
 (2603:10a6:10:552::34) To MN6PR11MB8102.namprd11.prod.outlook.com
 (2603:10b6:208:46d::9)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MN6PR11MB8102:EE_|SN7PR11MB6680:EE_
X-MS-Office365-Filtering-Correlation-Id: c4ff6377-04a6-4eca-0d8f-08de9b71c144
X-LD-Processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|376014|7416014|1800799024|18002099003|56012099003|22082099003;
X-Microsoft-Antispam-Message-Info: EwChHBu816CvSH5SEoZrWZvH5XmL9EfE6ouirHn33IMwUn/53ZObrL1cXdzAGIQyrLH6DekH/pv7UpTpwHfwdQj55/7KU3oXSNOEHSOkFR3WqEvPJTSZU++q7lsf8VVxGLaDjbMgDMlHzOXMkUhJxKv1t09xX8Wn0trgajF9JfHDcA/NK20B4RwNDYo/v7POui2x/LSpZjwhBNxKgwvz5XknV8Hou5lYH1N6vY3dggNGiXnsyvYo9IY2FT0YiAYAgcaIT9e0LSDnLwSDmIYZDtwhiqC/jDUy1QgZj3aBIQ/BXuapUciKXek7K42ta6sikq1moy/peCvIo8NTMYqch4/JXqT6mgC7oOZ0Hje0Mk0sSZxMJpnDCHXxaLNXf/Hb97S7a72+U1ztm85Ja1X6/AeKXtBl4N2hj60mUj3AnT1zZdLxN8zDPZAPrvNBTHHHDr8mK6Uvu0+UaxtRLXmx04UFkyTTX5cyyziwcXDORQHcbzz3lVMN8B+CuAxWh+YqJK8buWsT/7y/PTRMWd/ztX+1qy0Mxhcn0rgQyKqhqm9poedWwXjtbKjrwUl0bxI01+P8IBxCmhDWoJEetT5lPqwJAdtW2q+MKtEJ81CSU4m90dxCv7+ZcYd1mjsuB2gjbDCAsTYfsHD3bK5WZoFQQ+4K4vZf/zoFLNT3wXdQTx5LZ40XlNEQk9c8oF8cg+z5HTnYsiY8U8cUPDTvydu8nsuoi+5SP3luutl+iA8KTBU=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MN6PR11MB8102.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(376014)(7416014)(1800799024)(18002099003)(56012099003)(22082099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?VmtVK2FtbmEyajZGeUpGVGxSSlFNcWFWS0l0VjllSXJRN2hvWVp4RXhMWXpY?=
 =?utf-8?B?VGJOTUlEVlFiWk5ZZDVsMzd2WWZPL3VDb3d0aGFKczRORWMrcDF6dU5kbW8z?=
 =?utf-8?B?NUZWRjZsSXR1SUlqUGdaUTVYUkYxZURjcDJaQnd0dFVJWk04YVdURWNNQm15?=
 =?utf-8?B?Zll2a1c1UUhVK2psM0RUbGpPK0x6bUpQWFFsRHh1ZDBaSENzbEtJSjRSR3Fx?=
 =?utf-8?B?MS9ZanNxMXZaclYvZ2o2ZFVQcUNnSStsOVFGZXEwSno3cmJQd2I4Q3hwNW9o?=
 =?utf-8?B?TzRWam42dU5mdnJoVnY1UDQxTmZhQ1lCZDZYU29SMi9pSGtndGdjUm9udUJH?=
 =?utf-8?B?ajRnYjg3eU1Fclh3cmZaZ2g4VFFBbUtzMGgrVGRSTEx1bVd1YXltVWgxcDlj?=
 =?utf-8?B?ZGNPTmxpTTFqeldGMXVrM2JGbUN3M2p3RVFoQVQ0LzZBT2tRenFDc2xpcWlK?=
 =?utf-8?B?MkdpbnZGRXowVDl3YUp5bktqZEtpdzcrRnlmNlVzc3pIR0hKTVhhNTE0N2F6?=
 =?utf-8?B?eFkxZFpsOW83VU1GRmkreGJuZGNDbUl1aXBkZE91Zmxhd2lwODM2QVpVSTZC?=
 =?utf-8?B?Wk5qVU4zUHhhOGFpa3BWVTdhRHlDNmtWdXhrZGV0cFZhT1VwdnBuVGNmVXUy?=
 =?utf-8?B?MkswYTBRWG1oWHJFM2tHZ3dxZ3BsTmlnSXFyWHJDTlJjbmI3cS9ETjZQdk5T?=
 =?utf-8?B?N2xqZWtBYURZNDZiUW9oWWJSRDI4SERqUm13MU5SQ0JZQWNETXg2cjEyOWY1?=
 =?utf-8?B?NEJGNzlqMUZMVDNVN0Q4TXJHTTBWejUyRFZ5VWM3Y2NTcWlkMFJweGNzV2Zu?=
 =?utf-8?B?MXpaSFdOVFJGK0w3L3pwZXFndGhyR2dkMnlxQXIzRTRoSFUxcU5PdThWaVo3?=
 =?utf-8?B?TWVqRTVZN2d6M0pKZVJhcFFIQnF2MEpnSW0yanc0NEtvVExEMjh3S3hPNnNj?=
 =?utf-8?B?dE1rRFozTXdtMVpSenMwVHFkZnJ1c0trVngwRCsxTVErOWMzblFONUZMQ3I1?=
 =?utf-8?B?UEQ0c005aHljQXVYTjdvODNwcnJqa1VYUTdiYlA4eEhpNXpKM0ZaenZpZkM5?=
 =?utf-8?B?a3l0Zkx5TGFQdzlUVU53dThWemxTQm9JcHFYM1IxODBvVU44TCtnYVFiU05E?=
 =?utf-8?B?dUJOSEV5a2RtU3VpS3FLMTU2bmxldnlhdGZwRFFkeG4zazhLQkVUTE85ZlZt?=
 =?utf-8?B?YVJITnhRMUJneTV3Z3k4a2NUaERoaUpORU9aOFBacEh3UGNtdGhPK2pXd3R5?=
 =?utf-8?B?c1B5RXNiZlFFQ05ncjRDSHVKRnJjNXA1dE50cTVLaXJ1NW9xL05DMmpqakhS?=
 =?utf-8?B?bXlrK2FDTDgwaGwxUlhPZXRoYitWTjh4STc0dFZ5NFduTUxGL1pDM1Jxb2Yw?=
 =?utf-8?B?QW1Ga2lnTmpVSk5OWjJNaXdoOXNzRWhoWUhMVFNYQ3h6c0Y3UndIcjl2UVE5?=
 =?utf-8?B?dHhPVTJhbStmSG1sRldyOGkxbUI1SVdJdWFSTkl4WHVFbXB6TG15MGM1Z1Ra?=
 =?utf-8?B?UWxCYW1ENnZCaS9sckNUVXFCYzlRNnh1UzI1V3hia2tsVWovaHY4SW5CbExt?=
 =?utf-8?B?OExha1pjWlhYMnNMNm16MWxUSTNmaTV2VjBnUmY5Ymw0OHNkN25VbW1Ib25s?=
 =?utf-8?B?RFEzbDlYeExJbWszeDV1MVlBSTRZVXpJeXd4QTQ1enhGZkdsQUw4ZE15dEFW?=
 =?utf-8?B?MndPbTNMNFp5T05ZejFINE1CcHVGYmpXTU1BVHp2V0NxcXE0OFVXNlBsVlZK?=
 =?utf-8?B?dGNkOHZUSVA5TFc4TWZHSXd2Mm9PeEx0Q3JVTmJ1MXBvNGpVUU91S3Mrb2s3?=
 =?utf-8?B?MUhoZTBFZXp2QlpvL1poTUVWNVU2VXNUcVZaQ09SenFpaVhPWCsveVBpTVNU?=
 =?utf-8?B?MDlPaktaMng0SFJHVFpkRjEwR3dLODhsSGtvaVZRUER3NkF1NnRxSEVmOFJK?=
 =?utf-8?B?Ym5DSmlMS2tjMlRnN25YU1JTR1RCSUh1VHpjNk4rODlWZG1yTllWZHlIWVVF?=
 =?utf-8?B?YStRNFRWclhIYjZPUXNIRXBMNkU5c2tRcllIUWE0WVhsb3E1SXZvWklxR0ln?=
 =?utf-8?B?MEVUWUtVNjhQdDFLaktsZDNQUmhrRWdrS2hMd1RGMU80SEtpdU90VmRCei8r?=
 =?utf-8?B?SHdYT1ROU1E5U1RzZEtacEgyQkUrVEZGTEVGdjY2U1BrUUg2RGRFZUo3L216?=
 =?utf-8?B?dXJSVWZxZVBtdStnbnU2U3hwbElRRCtXcUdSMkhDejhyNFA0ODB1UUpIbEVK?=
 =?utf-8?B?ZVBybENPL0dBNkpMdnQvSHFhUEZveXVEOEhuN2hmcGxiZll0cWdRbFdtWmFt?=
 =?utf-8?B?YmlJWm02dzE3Tjc4L1RYYVRuV0NXT3p6ajN1eWJRSTU2VlY4TTBoczZCRFEx?=
 =?utf-8?Q?5w221A/+8IhMyfHo=3D?=
X-Exchange-RoutingPolicyChecked: uDUwW0/f3u7kIwYPHrGsL9Bmt/6ErD0GZIbp97pEyWw46HFah5G3DAobIzX4cBIV/c0+ANanrA95DcHJr1fd3NkC2HxZevHtiEa8pBZLzoHv57RfUd6aAm51w9B+6mKHeqU+OOBJ/7i+H1QN8tY0gksiyuXE8IFtQ1fneaQY9IonU0hLWIa7NsTa0grL5LbmIikxMXe5yvWuVRyVDSiShOY6vItlB32bU8Sp9nDagxqYCXlLfDQ1HKUHh7GBO1uIXS8EabHNp05GutRueY6oLHqsaA9HWFt7P2GaZz9jmfo4lh8K2drEQJ9DgAFFkrW8LhUSDyydqZebw751huuJ5Q==
X-MS-Exchange-CrossTenant-Network-Message-Id: c4ff6377-04a6-4eca-0d8f-08de9b71c144
X-MS-Exchange-CrossTenant-AuthSource: MN6PR11MB8102.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 16 Apr 2026 04:36:41.7243
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 5vTEAD20NTMph4GM8davWnOlS8RpvaMn8JNXa7/wMSiZfbc2UUTlx5B3T6o1+qhKbFTXLaaekG6AtRgPeu2ZvcXdCgG8EEs0cmGpJ99EVJA=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN7PR11MB6680
X-OriginatorOrg: intel.com
X-Spamd-Result: default: False [1.34 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_REJECT(1.00)[cv is fail on i=2];
	DMARC_POLICY_ALLOW(-0.50)[intel.com,none];
	R_DKIM_ALLOW(-0.20)[intel.com:s=Intel];
	R_SPF_ALLOW(-0.20)[+ip4:104.64.211.4];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-278922-lists,netdev=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	ASN_FAIL(0.00)[4.211.64.104.asn.rspamd.com:server fail];
	MIME_TRACE(0.00)[0:+];
	RCPT_COUNT_TWELVE(0.00)[18];
	DBL_BLOCKED_OPENRESOLVER(0.00)[intel.com:email,intel.com:dkim,intel.com:mid,sin.lore.kernel.org:helo,sin.lore.kernel.org:rdns];
	DKIM_TRACE(0.00)[intel.com:+];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[przemyslaw.kitszel@intel.com,netdev@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	FREEMAIL_CC(0.00)[vger.kernel.org,intel.com,lunn.ch,davemloft.net,google.com,kernel.org,redhat.com,blackwall.org,gmail.com,linux.intel.com,lists.osuosl.org];
	NEURAL_HAM(-0.00)[-0.999];
	TAGGED_RCPT(0.00)[netdev];
	MID_RHS_MATCH_FROM(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCVD_COUNT_SEVEN(0.00)[10]
X-Rspamd-Queue-Id: 3FD4540A322
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

On 4/15/26 23:22, Jacob Keller wrote:
> On 4/15/2026 9:30 AM, Simon Horman wrote:
>> On Mon, Apr 13, 2026 at 09:14:20PM +0200, Petr Oros wrote:
>>> On certain E810 configurations where firmware supports Tx scheduler
>>> topology switching (tx_sched_topo_comp_mode_en), ice_cfg_tx_topo()
>>> may need to apply a new 5-layer or 9-layer topology from the DDP
>>> package. If the AQ command to set the topology fails (e.g. due to
>>> invalid DDP data or firmware limitations), the global configuration
>>> lock must still be cleared via a CORER reset.
>>>
>>> Commit 86aae43f21cf ("ice: don't leave device non-functional if Tx
>>> scheduler config fails") correctly fixed this by refactoring
>>> ice_cfg_tx_topo() to always trigger CORER after acquiring the global
>>> lock and re-initialize hardware via ice_init_hw() afterwards.
>>>
>>> However, commit 8a37f9e2ff40 ("ice: move ice_deinit_dev() to the end
>>> of deinit paths") later moved ice_init_dev_hw() into ice_init_hw(),
>>> breaking the reinit path introduced by 86aae43f21cf. This creates an
>>> infinite recursive call chain:
>>>
>>>    ice_init_hw()
>>>      ice_init_dev_hw()
>>>        ice_cfg_tx_topo()         # topology change needed
>>>          ice_deinit_hw()
>>>          ice_init_hw()           # reinit after CORER
>>>            ice_init_dev_hw()     # recurse
>>>              ice_cfg_tx_topo()
>>>                ...               # stack overflow
>>>
>>> Fix by moving ice_init_dev_hw() back out of ice_init_hw() and calling
>>> it explicitly from ice_probe() and ice_devlink_reinit_up(). The third
>>> caller, ice_cfg_tx_topo(), intentionally does not need ice_init_dev_hw()

ice_cfg_tx_topo() stops calling ice_init_dev_hw(), that is the real
change that patch does, OK

>>> during its reinit, it only needs the core HW reinitialization. This
>>> breaks the recursion cleanly without adding flags or guards.
>>>
>>> The deinit ordering changes from commit 8a37f9e2ff40 ("ice: move
>>> ice_deinit_dev() to the end of deinit paths") which fixed slow rmmod
>>> are preserved, only the init-side placement of ice_init_dev_hw() is
>>> reverted.
>>>
>>> Fixes: 8a37f9e2ff40 ("ice: move ice_deinit_dev() to the end of deinit paths")
>>> Signed-off-by: Petr Oros <poros@redhat.com>
>>
>> Hi Petr,
>>
>> I don't intended to delay this patch.
>> But could you follow-up by looking over the AI generated
>> review of this patch on sashiko.dev?
>>
>> Thanks!
> 
> I'll take a look as well. I recently included this fix in Intel Wired
> LAN update last night, so hopefully nothing too problematic...
> 
> Sashiko says:
> 
>> While this code wasn't introduced by this patch, the restructuring makes it
>> more visible: can this cause a use-after-free if the nested hardware
>> initialization fails?
>> If ice_cfg_tx_topo() triggers a topology change, it performs a CORER reset
>> followed by an unroll (ice_deinit_hw) and re-initialization (ice_init_hw). If
>> that nested ice_init_hw() fails, its unroll path frees hw->port_info and
>> destroys control queues and mutexes.

here is a talk about "prerequisite for the problem"

>> Because ice_init_dev_hw() returns void, it swallows the -ENODEV error and

and here is about code that Petr just removes, IOW, does not apply


Plausible sounding comments, yeah, I hope we will not drown in the sea
of AI content :(

for the patch:
I have tested that it does not break my test suite (it was me to start
touching ice_init_hw() and friends), and both code and human written
commit message looks good,

Reviewed-by: Przemek Kitszel <przemyslaw.kitszel@intel.com>

thank you for fixing the code after me!

