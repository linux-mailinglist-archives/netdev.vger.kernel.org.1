Return-Path: <netdev+bounces-293731-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id wHPRItZ7HWrEbAkAu9opvQ
	(envelope-from <netdev+bounces-293731-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Mon, 01 Jun 2026 14:32:22 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id D5EA761F4BC
	for <lists+netdev@lfdr.de>; Mon, 01 Jun 2026 14:32:20 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id C9AF230305CA
	for <lists+netdev@lfdr.de>; Mon,  1 Jun 2026 12:21:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5A746372073;
	Mon,  1 Jun 2026 12:21:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="Iqd2+XOx"
X-Original-To: netdev@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 98AF53655F6
	for <netdev@vger.kernel.org>; Mon,  1 Jun 2026 12:21:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=192.198.163.18
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780316512; cv=fail; b=U96BPGWtvJNlzqJBqSQXyW6vy43MSlEvzkiNbwXt0aHdqcZ0hqT3bCHkF6RHb+mgpCpcYMJhcbi/FO0q3Q3inRFchj3K2c/Mt6CjT35D28rABBX2FasY3u+cgA0svVPPP0C5/2CsQvHKhswirvBf6oskbNzmo4YUc+J7o6JdNhw=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780316512; c=relaxed/simple;
	bh=rqiYpGUSIgr37gR9E5YBKN8yjJ/uQglLy7YmviK6hIY=;
	h=Date:From:To:CC:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=oMI2hHmih0gAaJc2VLFG/8s49lXIKkItzrsu/XMFkeXcZ2CJi8PzD5/lWFae0mLVfNTVmm3N2/PN3RrkbatSmQ1ADHSI5dofgMtrCG3HnRbIepzXBzrpxSY3EVSI9+3+b+xQfijrOzgBufqudlUh2aw+Ts3Cftcj07/vvEb+zmQ=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=Iqd2+XOx; arc=fail smtp.client-ip=192.198.163.18
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1780316508; x=1811852508;
  h=date:from:to:cc:subject:message-id:references:
   in-reply-to:mime-version;
  bh=rqiYpGUSIgr37gR9E5YBKN8yjJ/uQglLy7YmviK6hIY=;
  b=Iqd2+XOxzshO0WbH9NzPTMSyOsvNARsoc/w6zwfq2eMC33yw6URXIGi/
   M0PenDMIFXmyqwmYqKWhZlO8Cd4YYUEk3+BfEHz+5yYN5X8XkvdBlb5el
   Hgl+TPGDxmCb23jXe7ENRJt30GWsmT/TB/OnB+ag8PPTG9GTiBAu1KZng
   cHosgS6InyzSvtndQK4I8dvcghXDzeSRuCVkRvP86r3q482bV4z7LdPHX
   VEB0weMipX9mSfaB+/2+xz0ZqEoe7lTp6cUbInMjjggYjpVyg0AyV5zxJ
   NhyzZkJs4m9ex9hSpBoT689x6WD2FfvOH8/WF/FRkk/kShnw61lghYc0F
   g==;
X-CSE-ConnectionGUID: 75jmfhPSRTGGEkstxGmNgQ==
X-CSE-MsgGUID: p8Ul009cR6WQQkAY6wun9w==
X-IronPort-AV: E=McAfee;i="6800,10657,11803"; a="80211078"
X-IronPort-AV: E=Sophos;i="6.24,181,1774335600"; 
   d="scan'208";a="80211078"
Received: from orviesa003.jf.intel.com ([10.64.159.143])
  by fmvoesa112.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 01 Jun 2026 05:21:47 -0700
X-CSE-ConnectionGUID: SGRtCfcrSNG9KBCRNnS08A==
X-CSE-MsgGUID: MZM5Qd0bSHmxNg3YfSrUiw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.24,181,1774335600"; 
   d="scan'208";a="247524802"
Received: from fmsmsx901.amr.corp.intel.com ([10.18.126.90])
  by orviesa003.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 01 Jun 2026 05:21:49 -0700
Received: from FMSMSX902.amr.corp.intel.com (10.18.126.91) by
 fmsmsx901.amr.corp.intel.com (10.18.126.90) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.37; Mon, 1 Jun 2026 05:21:48 -0700
Received: from fmsedg903.ED.cps.intel.com (10.1.192.145) by
 FMSMSX902.amr.corp.intel.com (10.18.126.91) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.37 via Frontend Transport; Mon, 1 Jun 2026 05:21:48 -0700
Received: from SA9PR02CU001.outbound.protection.outlook.com (40.93.196.33) by
 edgegateway.intel.com (192.55.55.83) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.37; Mon, 1 Jun 2026 05:21:48 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=HWbxxOSfmz4u4iYnkkyZV4hqC+NHF2U7ik1MSHudPoTYD0x+Z7Qkho5J2sQrptaYTrZ5siHMKY6BcH2GLnEsHyO5jbSNZcPMEaz5PwggFWtT0Wqu8N/+wvP7SlYTgkc0kbW9nlUEw2KY4w2L5b8uoWBJHocbI0mrhvyTzw5mH6uTwbG7nkuRRa+x6amTilkQBaYn26xVzrYV95UxN4wyf3oXuoWc0uUnRVD+Y60Uz0fm+yT2X5I+FwjybPvtyebmWZGWvSrx+aOzvac1usw3JI5BcO+DpjZmH7GVCJZYL5bDHAyduVXc9s/aIkIbRM24Esqi/cv4J93zEO0fMqMDng==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Vb+jIKBxeusuvNm69GbL+Syv6lfawMzoMzK9iEjKjvo=;
 b=iM2q/UUYUNJY+ybnD+SMr0d8S8QTCXJ4yxGgbzDMIcLGZewuWnD98zEsV47Ln2lgU01aG1wL+N7KQ0XVED1jEXCOgYAsQatY6BwV9Mk+aGJF8qykx/HrHZ5Wg96Ew69moopG+X2cL0nWsEBSyG3+u1jEdpcXRuXFEp/hDi8ZCkgEI3XxxgMc7qkCi/LpCz2y2Iy/ksmKqsM2d0wRTZcdSHyADBXh3pBMU65gUpQX92ybFLAwX/qtBF6b3DeQvse+GIZmAJcGU6SpTf9EgIBs7LZYnKnsrWQCS9IBxivisu5k7m7oSdWynIj/ZR4hitItEFCrBpRwINbH49pk9cnJAQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from DM4PR11MB6117.namprd11.prod.outlook.com (2603:10b6:8:b3::19) by
 MN0PR11MB6085.namprd11.prod.outlook.com (2603:10b6:208:3cf::5) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.71.14; Mon, 1 Jun 2026 12:21:40 +0000
Received: from DM4PR11MB6117.namprd11.prod.outlook.com
 ([fe80::d9b3:e942:2686:3cdd]) by DM4PR11MB6117.namprd11.prod.outlook.com
 ([fe80::d9b3:e942:2686:3cdd%5]) with mapi id 15.21.0071.015; Mon, 1 Jun 2026
 12:21:40 +0000
Date: Mon, 1 Jun 2026 14:21:34 +0200
From: Maciej Fijalkowski <maciej.fijalkowski@intel.com>
To: Larysa Zaremba <larysa.zaremba@intel.com>
CC: Jakub Kicinski <kuba@kernel.org>, <anthony.l.nguyen@intel.com>,
	<davem@davemloft.net>, <pabeni@redhat.com>, <edumazet@google.com>,
	<andrew+netdev@lunn.ch>, <netdev@vger.kernel.org>, <vinschen@redhat.com>,
	<alexander.nowlin@intel.com>
Subject: Re: [PATCH net 1/8] ice: fix UAF/NULL deref when VSI rebuild and XDP
 attach race
Message-ID: <ah15Ti7O2m3Hj2T+@boxer>
References: <20260520183501.3360810-2-anthony.l.nguyen@intel.com>
 <20260523001616.1757210-1-kuba@kernel.org>
 <ahgHZ8NNWPeFVsXr@boxer>
 <ahlIwmIHiPsB50Zn@soc-5CG4396X81.clients.intel.com>
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <ahlIwmIHiPsB50Zn@soc-5CG4396X81.clients.intel.com>
X-ClientProxiedBy: VI1PR04CA0053.eurprd04.prod.outlook.com
 (2603:10a6:802:2::24) To DM4PR11MB6117.namprd11.prod.outlook.com
 (2603:10b6:8:b3::19)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM4PR11MB6117:EE_|MN0PR11MB6085:EE_
X-MS-Office365-Filtering-Correlation-Id: 13138e0d-ed2d-45ad-bcfd-08debfd855a1
X-LD-Processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|1800799024|376014|22082099003|18002099003|4143699003|6133799003|56012099006|5023799004|11063799006|3023799007;
X-Microsoft-Antispam-Message-Info: xCIKYLCBebjqesf5ABUdx0iRZzopmm8dt3ZEqBMQMMmies8oBDxj81spd2Avju3jnU/AJvU07IOriNzCKCxZfAigpULr5dntTBZdenA0TM0/ksdx5OwjkX7CHrAzdOy/I8nJ3jnDh1UefLom0mWMW+5ho8GYuD0pmGtedN+8/qRIvPkqIkaBxdjofwDw3Idz10FtPcaRCkp0aNVsBoPEnYtI7MDSxod7G3Rd3LUg0rykmHS9PkE0W8kLXXjNbqrsO/KX3u4T8V+DOXEaZqjZ6in7Ahz9z3IOOIx0xKo8Ic6f1zlHGXJIlIIP4Hv6rwUuLGQ/XKty7+rF8klV5GUcRvlZWi66GfhhplTDc5EfeI5N5HGgvl3mFyGI9R4egHXtxn3uhkPLPWs7yoZpDI0xYBltZErNMVVdqi+QIE0IaRxvsDovDMnDOoH2mOsdai4rJ7VZWoCTfEQPvhhAMqMSmWNMXFZtUamu0AVqFNZNcVPc3gU4YFszm6DQbA9Shhc6iBUEs7n4Q1r/24NL6a3gRLOfuj6mw6QXL6/ykFwwDR8n4cOnC0FOPQoHPUIlOVXpzbbBCsc0RBZ3GLaJ9ZenzSWNgtWtJ6wa7Tq714gARKm6mv99wRMwfSULu3I8L7/Rnd1MYaM9NmTA9Ck+N+28SoApUO1EqE2yvailmOoZZzMIEYBzY2SXG6my8LSNLGRuIQJ9euALDqVw+osGf0mCNA==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM4PR11MB6117.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(376014)(22082099003)(18002099003)(4143699003)(6133799003)(56012099006)(5023799004)(11063799006)(3023799007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?7lyhyEKAEACcxzC+Yjr8QdGT1/aPPM7YdbM+mxL8vH9EoYQfJ8LBAdsyObp2?=
 =?us-ascii?Q?N8pVE0eglyst/iRX6DAbw4ZKe3wUBcCaNxD5MDYu1RCRWm+akvnoga2e2+0B?=
 =?us-ascii?Q?leEJ8Weiau7Bsaq37nQopk7KIwsvqvBkmRlERyhdN50xBg/6DeZMasbRJj73?=
 =?us-ascii?Q?O5F4j+cwQll6Ab+khXtI+I5IzdYzAgsH9j73UcjgndRA2Qsd9G+I9zz3trn0?=
 =?us-ascii?Q?j2oyMf4YCWeELBFM0QDlZ3ldtZKLuMjSBHyqr/uOCSKuF4NyLLqtnuGrwnZI?=
 =?us-ascii?Q?ac9GSVeU6YiXxPwQ2Oq9Fs7ABQ7Hf37yl9lVqrlWPgvpyJiu6Dsk+5hJSuro?=
 =?us-ascii?Q?GBn7qqIN2dV7JdSctcajoqnOrkXZDgNpdOZwJc4s68wgabbt8Az/G7o7MM8k?=
 =?us-ascii?Q?vIT9huLoHM/qkhAcZAupa3Tdg8T48CnRlphrnT/7ROcKAzUwdBM6GRdoz/pI?=
 =?us-ascii?Q?xYX+QaVzoMpjBiMpUkPKW3jj6uToWFUzGHubxYL2lUhQGfb3wf3+jL/7kppf?=
 =?us-ascii?Q?nS/OI4eD25s8S/E/ERJIyIbB3k6A4hjxgSzdxO0IZRujFQgRDVny0g2Qn3v/?=
 =?us-ascii?Q?ADyGN0ch1nazarYNYvh+EZ4oxOJOVMFGmYc4evg4otoSJzpQIQNyXpGwIY62?=
 =?us-ascii?Q?2dTNi8FdAXaZ2/dh3xOIUo87aPqrdRapAXmTcY5956zSH4xXnd/w/+KUQZHx?=
 =?us-ascii?Q?zs57PeFTSeEoM/4F74zdvE2KCCM0T5+dieLxEZ5dgQzBaKVnlx6GUYSlxTd9?=
 =?us-ascii?Q?ZNwbF6GvY4r/bowIpw3M0t8hlNvwLhUAMJkhHh+Hu8VlHFkFeuD9Zg+/rJdH?=
 =?us-ascii?Q?36NYuyi2LE1dsn8yIcyKXuc97T/WX+4i+acjKu9PG89GNTW54b1LUk1gQ9ad?=
 =?us-ascii?Q?8JxwLGs0iSW14vorBt0wR36Ot5ZlRcGlciX/YGgOx0Tf1xmKVvTkKOjx45Z2?=
 =?us-ascii?Q?OZk5dSN267LRXLjQOh/lrOv8Gk/Fi+k0R1gdKGrUZvYQSGLkNk/paj0v5cCF?=
 =?us-ascii?Q?CI7gP1k7dkkjlqs9KGXYQzCxumtgIVNGJdzVG7CZHy5Mr2uuWZDMu4sUa2Ad?=
 =?us-ascii?Q?QwAHF6BWTzQNadPaaDPccYhoUJBfyySBZZhVfIPnNyW+tOCjv8aj4ESUOImE?=
 =?us-ascii?Q?+VeaL5KyXnm53nS38TPAsuDTvj2fnIFambVVzvsWViqAXiOOJGLTFqFJDJac?=
 =?us-ascii?Q?kNVzmpHgfsH+DSzO6g9nlp3vLCNwZCp0G7/fOev3+9KjF/1dQzZiP2kAceCt?=
 =?us-ascii?Q?mg7pzxkncSKLz1LPpV6k+11+IeocWON6iUH1RsLCzVU8CzHlw+lMC8Gsop0m?=
 =?us-ascii?Q?GC5h/v2UzZi9anVUITrbHkoUAL8u7h6BlgNKryyJmLxDhWWudG1hskZh4QPk?=
 =?us-ascii?Q?ug+gwi8/dZhjdZldHYZjndTMbJ4M9wgoSfek3WrsmyUt05DU9vY01rQhqxil?=
 =?us-ascii?Q?XEiboJ8JBVA8a7hGujVTfI4J0O8W7aEUc3gsjjcqW9rZON8W00hzwEJYAjNe?=
 =?us-ascii?Q?Sv1nBgn4NS+5jmLQZ5DkrcPZoJFH15poCnLqAwF4Vf5rVdY1hB9ci+MNPgts?=
 =?us-ascii?Q?9sRuxq2eXU+toP5sKQ2MoMJzkbncpjUIPv1P+IkSHuZXSCyDNWvMds6C9BOv?=
 =?us-ascii?Q?g4SQbmcx+TfIJNGJOVWMM4uLFqcwr4dcbL+UyrsDg+EnptuDEy1kX7wmScLX?=
 =?us-ascii?Q?EGU2417mZMRl1k91+WYzRQIq5LGZr5k6b29t0Ac9zfkYGj3R5rX+kfUXA6Bk?=
 =?us-ascii?Q?/eI8rRX8XzOmFs5iMbacOe54VKFUI6Q=3D?=
X-Exchange-RoutingPolicyChecked: s5Z6mUOX/51CPoDDaryS5Zl6JSC7iGQs1NwNVzZ8uQypR2xEwPmgz/do+ezpK2+//LfOReIgsrGsOT6Z54Pn561f5Jx13UJJsWINzuqUZpyVONIiK8E8hnyCLubD3y4QLn7qSLKtJAbEFoaqcFyOml+qKcSyQ3FQXjumTk0r5OIPbYt6L4raxpZ8sR2YCp4XYT+phVALeRgwUqVMfHJAzpRBITqgjXFHnL4vJODXef6hBYgBayy1qslyPSoO+yl91qfrOqpLQ/U2Ni4VhwwbwxCD73lACzpxJeFqALzXoDBK4ML6q1c5CMzy3RpRAsDxMrlgKl9iLDqD/AXu4w+YFg==
X-MS-Exchange-CrossTenant-Network-Message-Id: 13138e0d-ed2d-45ad-bcfd-08debfd855a1
X-MS-Exchange-CrossTenant-AuthSource: DM4PR11MB6117.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 01 Jun 2026 12:21:40.6071
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: XMNv1LwWrUleRrUe4kxx5TW4pQLkO+IqyEPgPmMdIblX7r6MdUNeZNPG8rYwvp8pSdr44WFiSaI4WOCir6Q6ry8uDa8alQx7wBL+EyKl9S4=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN0PR11MB6085
X-OriginatorOrg: intel.com
X-Spamd-Result: default: False [1.84 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_REJECT(1.00)[cv is fail on i=2];
	MID_RHS_NOT_FQDN(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[intel.com,none];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	R_DKIM_ALLOW(-0.20)[intel.com:s=Intel];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-293731-lists,netdev=lfdr.de];
	DBL_BLOCKED_OPENRESOLVER(0.00)[intel.com:dkim,sea.lore.kernel.org:rdns,sea.lore.kernel.org:helo];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	DKIM_TRACE(0.00)[intel.com:+];
	MISSING_XM_UA(0.00)[];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[maciej.fijalkowski@intel.com,netdev@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[netdev];
	RCPT_COUNT_SEVEN(0.00)[10];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	RCVD_COUNT_SEVEN(0.00)[10]
X-Rspamd-Queue-Id: D5EA761F4BC
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

On Fri, May 29, 2026 at 10:05:22AM +0200, Larysa Zaremba wrote:
> On Thu, May 28, 2026 at 11:14:15AM +0200, Maciej Fijalkowski wrote:
> > On Fri, May 22, 2026 at 05:16:16PM -0700, Jakub Kicinski wrote:
> > > This is an AI-generated review of your patch. The human sending this
> > > email has considered the AI review valid, or at least plausible.
> > > ---
> > > ice: fix UAF/NULL deref when VSI rebuild and XDP attach race
> > > 
> > > This commit addresses a race condition between a VSI rebuild and an XDP
> > > attach operation. It prevents rx_ring->xdp_prog from being populated before
> > > rx_ring->xdp_ring is valid by rejecting the XDP attach when a VSI rebuild
> > > is pending. XDP detachment is still permitted during this window to clear
> > > the existing program.
> > > 
> > > Fixes: 2504b8405768 ("ice: protect XDP configuration with a mutex")
> > > 
> > > > diff --git a/drivers/net/ethernet/intel/ice/ice_main.c b/drivers/net/ethernet/intel/ice/ice_main.c
> > > > --- a/drivers/net/ethernet/intel/ice/ice_main.c
> > > > +++ b/drivers/net/ethernet/intel/ice/ice_main.c
> > > [ ... ]
> > > > @@ -2912,12 +2912,21 @@ ice_xdp_setup_prog(struct ice_vsi *vsi, struct bpf_prog *prog,
> > > >  	}
> > > >  
> > > >  	/* hot swap progs and avoid toggling link */
> > > > -	if (ice_is_xdp_ena_vsi(vsi) == !!prog ||
> > > > -	    test_bit(ICE_VSI_REBUILD_PENDING, vsi->state)) {
> > > > +	if (ice_is_xdp_ena_vsi(vsi) == !!prog) {
> > > >  		ice_vsi_assign_bpf_prog(vsi, prog);
> > > >  		return 0;
> > > >  	}
> > > >  
> > > > +	if (test_bit(ICE_VSI_REBUILD_PENDING, vsi->state)) {
> > > 
> > > [Severity: High]
> > > This is a pre-existing issue, but is the check for ICE_VSI_REBUILD_PENDING
> > > prone to a TOCTOU race because it relies on ad-hoc flag synchronization
> > > instead of proper locking with the device reset path?
> > > 
> > > The asynchronous reset path (ice_prepare_for_reset()) sets
> > > ICE_VSI_REBUILD_PENDING without holding vsi->xdp_state_lock or rtnl_lock().
> > > 
> > > If ice_xdp_setup_prog() (which holds both locks) checks the bit before it
> > > is set, it proceeds to configure XDP and sets ICE_VSI_DOWN. If the reset
> > > path then sets the bit and calls ice_pf_dis_all_vsi(), it will skip this
> > > VSI because ICE_VSI_DOWN is already set.
> > >
> 
> Here is ice_dis_vsi()
> 
> void ice_dis_vsi(struct ice_vsi *vsi, bool locked)
> {
> 	bool already_down = test_bit(ICE_VSI_DOWN, vsi->state);
> 
> 	set_bit(ICE_VSI_NEEDS_RESTART, vsi->state);
> 
> 	if (vsi->netdev && (vsi->type == ICE_VSI_PF ||
> 			    vsi->type == ICE_VSI_SF)) {
> 		if (netif_running(vsi->netdev)) {
> 			if (!locked)
> 				rtnl_lock();
> 			already_down = test_bit(ICE_VSI_DOWN, vsi->state);
> 			if (!already_down)
> 				ice_vsi_close(vsi);
> 
> 			if (!locked)
> 				rtnl_unlock();
> 		} else if (!already_down) {
> 			ice_vsi_close(vsi);
> 		}
> 	} else if (vsi->type == ICE_VSI_CTRL && !already_down) {
> 		ice_vsi_close(vsi);
> 	}
> }
> 
> For __LINK_STATE_START netdevs, DOWN state is rechecked under rtnl_lock() 
> before closing VSI, so we do not have to worry about XDP and other configuration 
> functions tempering with it.
> 
> For !netif_running() netdevs, the only situation, when there could be such 
> problem is if the whole .ndo_open() finishes and another rebuilding 
> (rtnl-locked) callback starts and sets ICE_VSI_DOWN in between
> 
> `if (netif_running(vsi->netdev))` and `ice_vsi_close(vsi)`
> 
> Which is already unlikely.
> But I think this is not possible at all since ndo_open() will not succeed while 
> we are in a reset path, so no rtnl-locked callback will see !ICE_VSI_DOWN state.
> 
> It would be more robust to check for netif_running(vsi->netdev) under rtnl_lock 
> too, but the code should work as-is.

I think issue is not about repeated ice_down() scope but rather the
allocations that could overwrite existing objects as we skipped these
calls which ice_vsi_close() has in it:

	ice_vsi_clear_napi_queues(vsi);
	ice_vsi_free_irq(vsi);
	ice_vsi_free_tx_rings(vsi);
	ice_vsi_free_rx_rings(vsi);

?

> 
> > > When ice_xdp_setup_prog() finishes, it calls ice_up() which clears
> > > ICE_VSI_DOWN and starts enabling hardware queues while the device is
> > > actively undergoing a hardware reset (ice_do_reset()).
> > > 
> > > Can writing to hardware registers during an active reset cause hardware
> > > hangs or PCI master aborts?
> > > 
> > > > +		if (prog) {
> > > > +			NL_SET_ERR_MSG_MOD(extack, "VSI rebuild is pending");
> > > > +			return -EAGAIN;
> > > > +		}
> > > > +
> > > > +		ice_vsi_assign_bpf_prog(vsi, NULL);
> > > 
> > > [Severity: High]
> > > This is a pre-existing issue, but does detaching an XDP program while a VSI
> > > rebuild has failed lead to a NULL pointer dereference here?
> > > 
> > > If a VSI rebuild fails, ice_vsi_decfg() frees vsi->rx_rings and sets the
> > > pointer to NULL via ice_vsi_free_arrays(), but leaves vsi->num_rxq
> > > non-zero. The ICE_VSI_REBUILD_PENDING bit remains set because it is only
> > > cleared on the success path in ice_vsi_rebuild().
> > > 
> > > If a user subsequently detaches XDP, ice_xdp_setup_prog() intercepts it
> > > because ICE_VSI_REBUILD_PENDING is set, and it calls
> > > ice_vsi_assign_bpf_prog(vsi, NULL).
> > > 
> > > This function loops up to vsi->num_rxq:
> > > 
> > > ice_vsi_assign_bpf_prog() {
> > >     ...
> > >     ice_for_each_rxq(vsi, i)
> > >         WRITE_ONCE(vsi->rx_rings[i]->xdp_prog, vsi->xdp_prog);
> > >     ...
> > > }
> > > 
> > > Since vsi->rx_rings is NULL, does this cause a guaranteed NULL pointer
> > > dereference panic?
> > 
> > CC: Larysa
> > 
> > Seems we should check if vsi->rx_rings != NULL plus
> > ICE_VSI_REBUILD_PENDING should be cleared on error path in
> > ice_vsi_rebuild().
> 
> I think checking (vsi->rx_rings != NULL) should be sufficient. Not sure about 
> clearing ICE_VSI_REBUILD_PENDING, if a rebuild has failed and the device is 
> disfunctional, rebuild is still to be expected at some point, and XPD changes 
> should not have any effect before then.
> 
> > 
> > Do you have any comment on TOCTOU issue mentioned above?
> > 
> > > 
> > > > +		return 0;
> > > > +	}
> > > > +
> > > >  	if_running = netif_running(vsi->netdev) &&
> > > >  		     !test_and_set_bit(ICE_VSI_DOWN, vsi->state);
> > > -- 
> > > pw-bot: cr
> > > 

