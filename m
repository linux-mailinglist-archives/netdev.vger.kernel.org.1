Return-Path: <netdev+bounces-122146-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 95D9996016E
	for <lists+netdev@lfdr.de>; Tue, 27 Aug 2024 08:19:49 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 3FE192816A9
	for <lists+netdev@lfdr.de>; Tue, 27 Aug 2024 06:19:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 47A3713C9A9;
	Tue, 27 Aug 2024 06:19:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="TRAwA8by"
X-Original-To: netdev@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.11])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5D602D51C;
	Tue, 27 Aug 2024 06:19:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=192.198.163.11
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724739585; cv=fail; b=DVSWABw571n21be0WJ2xGqzfVF4C0FPv190zC6nZB3IJzazOWOOIbHsIYReC1Qdo0S79IrKWDGmiGDHK9s8VMHOhTRmy+xE3elmEQNeru5z8GsYNzFX5wCcbfKLmfxhp4HfmhiTM642uXI9ojLKxhyTBuN2XKNI4M902/LqTYN0=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724739585; c=relaxed/simple;
	bh=dC5NbXFmNvbpyN3j6hAvBOM56zlWAgOnjBx1v0sznt0=;
	h=Date:From:To:CC:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=O0VJRhagK+OHquaUztJmrsCc//LHxgUZjfOg7qI4xCGnTLcVK7n2TQ4ao8dcz319mke+klJDx2436zutmX9NYC6RsxyMhzQsTu1FrzXIk+5pctwZhbX1ZUsI+lI8cdrRP/2Z3jLptMOukx340iL5K+xtwoBQfiO+LLJnvhtgCT4=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=TRAwA8by; arc=fail smtp.client-ip=192.198.163.11
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1724739584; x=1756275584;
  h=date:from:to:cc:subject:message-id:references:
   in-reply-to:mime-version;
  bh=dC5NbXFmNvbpyN3j6hAvBOM56zlWAgOnjBx1v0sznt0=;
  b=TRAwA8bysx+lrR8iTkbcXPGILCrfDqpUEe2s4UlSFRrDlrXoGDJQkyli
   qcJ7S474RzAf+8JQT2CY0TUU+FjA8VoTYY1NwNPPmr40iSvEbaEYL+WpL
   /aLYCnv2y3R7t1JhQgVDLofPLg9YyKyA4+mb9Zuz6msCNXCoh9Jn1RFZi
   byJ4NotaUyJW7zvIhsDp5scuiGoGBhH+LfUXTmx95Js5sjRLU6hJeYIzl
   5E06thIu95kyas8oF2rl+7HgxvEL3AMGc6bnYoPWsmqJ5DhLOl8SnehNb
   tMCFm2KjRy/v3W+i+UycdfyRKmiMJu4cwuqT9b+akwhE279zo/AQsHYd8
   g==;
X-CSE-ConnectionGUID: eGX2LXdDSOCQlG135BvvSw==
X-CSE-MsgGUID: D6tjjcw1R0Wr5qz+t1xhTw==
X-IronPort-AV: E=McAfee;i="6700,10204,11176"; a="33820864"
X-IronPort-AV: E=Sophos;i="6.10,179,1719903600"; 
   d="scan'208";a="33820864"
Received: from fmviesa005.fm.intel.com ([10.60.135.145])
  by fmvoesa105.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 26 Aug 2024 23:19:42 -0700
X-CSE-ConnectionGUID: ecuTxJXRR9GuMlzuqY1qjw==
X-CSE-MsgGUID: bkF1KCfdS06BxHyk1JYBHA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.10,179,1719903600"; 
   d="scan'208";a="67097778"
Received: from fmsmsx601.amr.corp.intel.com ([10.18.126.81])
  by fmviesa005.fm.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 26 Aug 2024 23:19:42 -0700
Received: from fmsmsx610.amr.corp.intel.com (10.18.126.90) by
 fmsmsx601.amr.corp.intel.com (10.18.126.81) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39; Mon, 26 Aug 2024 23:19:41 -0700
Received: from fmsmsx610.amr.corp.intel.com (10.18.126.90) by
 fmsmsx610.amr.corp.intel.com (10.18.126.90) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39; Mon, 26 Aug 2024 23:19:41 -0700
Received: from fmsedg602.ED.cps.intel.com (10.1.192.136) by
 fmsmsx610.amr.corp.intel.com (10.18.126.90) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39 via Frontend Transport; Mon, 26 Aug 2024 23:19:41 -0700
Received: from NAM10-DM6-obe.outbound.protection.outlook.com (104.47.58.100)
 by edgegateway.intel.com (192.55.55.71) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.39; Mon, 26 Aug 2024 23:18:50 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=ol1A2iuyY4dmRKCVelDpHDgBSOkpc6sntEug1AT5LlkkVny/9uc8jiP0e092sR1+d6GWJ1GLz7Sr5XQX7Wv9Ppt9nO08ia9rgOjPOO34bFlyY3NTvIPHA74ta9G+XVRAGAW4j9FehVv1wo4CAitNK9v/Q4n+nsg8HVni5cvsxN90+k32aP7QHJQQbQ7e8hfUvJDJXUyFV05No4TSe2l+ORB0DW2SSS8KfetasZZv33DffjN1M3kFg3coMuNGQ40iKeV0hf2z7724mnrBHpp/fWD/xYKIQUzMRA5QCtSxiCfvgFsXamnwPb0GoB1S4VY8kcAkssUbyN0Rzb/537eUVA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=5OeNIRz+elPhse+s0OKbk1o1CZa4aiVOxYYUC+mu3i8=;
 b=QP/NwXsPuk+A9Pfk8EWuP/Modf/HQYUmRGP2PJTRjSWSahoNM4WtiaItuUAS+sT9LQKf8lvEiSm3rf/w6HupLAec9BqsMINuX6HEsiXEfwwVr1jezwN7LWG46cehgGo8CRGGIvnSLmLb6S2utW/0j2xJN/9uB+pmlyzj39MOagVgdJyqVajNqHchaTOaI/lATMspBodvi1Bi7sw2WQLrKm+u32C/NPZ/CcncWT5GAf4qpU4hGsB+usg1XBClzisi4e1uvr3T2bXVyi/6eh+Fp4zHpKeRfwDQtwkBWoeUO/Q2Frn8kOwoW1ZefaxwtUiLZKzxV5wFQ1LCQUKueo/wTw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from PH0PR11MB4839.namprd11.prod.outlook.com (2603:10b6:510:42::18)
 by PH0PR11MB5063.namprd11.prod.outlook.com (2603:10b6:510:3d::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7897.25; Tue, 27 Aug
 2024 06:18:42 +0000
Received: from PH0PR11MB4839.namprd11.prod.outlook.com
 ([fe80::2c61:4a05:2346:b215]) by PH0PR11MB4839.namprd11.prod.outlook.com
 ([fe80::2c61:4a05:2346:b215%6]) with mapi id 15.20.7897.021; Tue, 27 Aug 2024
 06:18:42 +0000
Date: Tue, 27 Aug 2024 14:19:39 +0800
From: Pengfei Xu <pengfei.xu@intel.com>
To: Maxime Chevallier <maxime.chevallier@bootlin.com>
CC: <davem@davemloft.net>, <netdev@vger.kernel.org>,
	<linux-kernel@vger.kernel.org>, <thomas.petazzoni@bootlin.com>, Andrew Lunn
	<andrew@lunn.ch>, Jakub Kicinski <kuba@kernel.org>, Eric Dumazet
	<edumazet@google.com>, Paolo Abeni <pabeni@redhat.com>, Russell King
	<linux@armlinux.org.uk>, <linux-arm-kernel@lists.infradead.org>, "Christophe
 Leroy" <christophe.leroy@csgroup.eu>, Herve Codina
	<herve.codina@bootlin.com>, Florian Fainelli <f.fainelli@gmail.com>, "Heiner
 Kallweit" <hkallweit1@gmail.com>, Vladimir Oltean <vladimir.oltean@nxp.com>,
	=?iso-8859-1?Q?K=F6ry?= Maincent <kory.maincent@bootlin.com>, "Jesse
 Brandeburg" <jesse.brandeburg@intel.com>, Marek =?iso-8859-1?Q?Beh=FAn?=
	<kabel@kernel.org>, Piergiorgio Beruto <piergiorgio.beruto@gmail.com>,
	Oleksij Rempel <o.rempel@pengutronix.de>, =?iso-8859-1?Q?Nicol=F2?= Veronese
	<nicveronese@gmail.com>, Simon Horman <horms@kernel.org>,
	<mwojtas@chromium.org>, Nathan Chancellor <nathan@kernel.org>, Antoine Tenart
	<atenart@kernel.org>, Marc Kleine-Budde <mkl@pengutronix.de>, Dan Carpenter
	<dan.carpenter@linaro.org>, Romain Gantois <romain.gantois@bootlin.com>
Subject: Re: [PATCH net-next v17 11/14] net: ethtool: cable-test: Target the
 command to the requested PHY
Message-ID: <Zs1v+yAmWpKCVQpm@xpf.sh.intel.com>
References: <20240709063039.2909536-1-maxime.chevallier@bootlin.com>
 <20240709063039.2909536-12-maxime.chevallier@bootlin.com>
 <Zs1jYMAtYj95XuE4@xpf.sh.intel.com>
 <20240827073359.5d47c077@fedora-3.home>
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <20240827073359.5d47c077@fedora-3.home>
X-ClientProxiedBy: SG2PR02CA0120.apcprd02.prod.outlook.com
 (2603:1096:4:92::36) To PH0PR11MB4839.namprd11.prod.outlook.com
 (2603:10b6:510:42::18)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH0PR11MB4839:EE_|PH0PR11MB5063:EE_
X-MS-Office365-Filtering-Correlation-Id: e59e6aba-d718-4bca-cd6a-08dcc660196b
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|376014|7416014|366016;
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?l7jr2GcT/VHzsIVKk0B7Hy+9Y7CushEbndwwaz2Cxwp1HoJ5aoWl0EnGN2KU?=
 =?us-ascii?Q?Y+B1vWP+3wx5V88s71zgHlEmyYe453QLFYfnXeqelYeSaUEfZPjExmLYQp85?=
 =?us-ascii?Q?bdvyx9/CDTbiVH8cnbF6hnS6FV5ixhxOIj2HnurKCDQtgOjMyq0dlTTrVSTT?=
 =?us-ascii?Q?yYPuUP3mP8Pa1tD7Otty/ofW45MYTqZoLsXLoD7/KQD+3SBAceS6Eve/+OvB?=
 =?us-ascii?Q?vt2TrhY3Wphqj/vT3/8zd9IhVjKvmq4qov7qWR+x9XMJF4GKwPrTCkIg/4+G?=
 =?us-ascii?Q?dCCKuX8K2KwErH6OQWLOYQdnvhIsF0fNqoCqFmLBNocx4t65r9OPPs69k31b?=
 =?us-ascii?Q?QMRdeOOPyW8h+v1OBEcY/uNOmBcQZAuEN6BB07Qf/yGqFI6FeXGwwDT3XdtE?=
 =?us-ascii?Q?Y4/UCyMZW9+NbGPZOZ7Ha5cAYsDvrEaiHvenxUmYZi5mW/4P3Byqn8z3Z7fs?=
 =?us-ascii?Q?1kZSfGSfyhQZOhHy9A+AcW/WtwGumhTMbvnt5HZp6sEJ/SKbGrMztGEvy4/W?=
 =?us-ascii?Q?SdjvsU9QAybiZY8G8Jr/yiCwxuivmdrlC8UOr6EpamgADIWH4AnYNC2T+38v?=
 =?us-ascii?Q?dc/vJDY/wFEowSfRCtiqbQxjzeXIEP556XoTr0jtJh9g1ZP8LU8/IBWi4xse?=
 =?us-ascii?Q?NmYj7NSwdid1vF7H3bc2YYonNqmEQoBNahJ9Tq1f/bKYbhGGt0+jB19mJCdP?=
 =?us-ascii?Q?300ftZQwdgCsN2OmDMhy2LLZl3nGFzOnI2Klq2s3GJtHAZM+NTCry3k1eMj/?=
 =?us-ascii?Q?MgPYRB28QMKxqdR5yGb213noTEYAjTBXofMV+spuFUhRDBvVgE/xc7HBZJcN?=
 =?us-ascii?Q?i72t2lgydjkGcUFL5TjQKhcalTseAEwNrLKJmHaCiiuc2TO8yaz0bSeQEIi/?=
 =?us-ascii?Q?+cLcEHZj7nNxy/GOTbLgeIY5PUTeA6SwDRSz31IXv8XxRBmfUDmHWYZiab0/?=
 =?us-ascii?Q?FWJq6vT17yHT6oiLm0Qgqddws0E9OjDVNIj7Sw4V16okvEGXSFX1auuuPWWy?=
 =?us-ascii?Q?17+XxHgBDj6X8grc2PImmrCqmfm8rOK9iz6rgbOpxJXTUceFyKuTlmCxggV4?=
 =?us-ascii?Q?Hcx1JU5He8pCt2oizu669DskmdLNj6izTy3KVIwiRtLhw1qYdA2VK2ei31Ko?=
 =?us-ascii?Q?XWqIotlAtJMzVq1A1myE1uwkMmb2MiCNUGs1KZU13/kIq61Jn2q83VPu6wuW?=
 =?us-ascii?Q?6/qHH4eSx4Ab0a4KKugIWbq3xdrgVo8BTMXmsBKnupY5Aj6bW6Yo4yXT/pp2?=
 =?us-ascii?Q?YmfNAxzYNKCOlf+6PKsesmtF7FutV0D77O3N1KH5aXbMIZScEBBDc+i1uj3j?=
 =?us-ascii?Q?522lo7rgORnEEgAF5FXhgEjE?=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH0PR11MB4839.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(376014)(7416014)(366016);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?Or8eAwROawjrp2nUthUb13AmPXQhxIDvW+83UZqgsU2lEVCNMpEEaFaUwdnx?=
 =?us-ascii?Q?gCYk8FXNeSfmA6aqz25klw7aD5BH7zSMQx24IxYcRJH10LF7OXlzN6hBcrmb?=
 =?us-ascii?Q?XPRxA4nQDB6DqlWTlH+Wt7G0wbJo9GtM3azoHFu2MwWGexXpKc2yVTRErRl+?=
 =?us-ascii?Q?zikbNFj4d1AUJsX+Elngkq0AO17PrXRPmAq2IRSQO3Vvi7rUh5Yjz+EHfwbi?=
 =?us-ascii?Q?qgbvc+L7r/yZhHoyuv8OoGxLN8DfW1pbyCA8kySfRpGB+bgrqbrjnudurTM1?=
 =?us-ascii?Q?Z7PKVwmPD2gj3A55mbx9fvavoPlXcrFeM/D3Jxk7ODvs8kVMSqQcmxH7xhrB?=
 =?us-ascii?Q?4ErAzotLkuMBl7NVsvsOInTa5Wt2KFKWhTtTIuiB2BzBYt2ot+N6IIoK7r2K?=
 =?us-ascii?Q?R15RGYPITvttpjnNwXj/fKZJatL7ZzQ0oMkXK1MuwJrijNr3TpMh8APu2Bpm?=
 =?us-ascii?Q?6DqzhzR/EhY6onjvzcp9RZvlg2SadIgRF5GYInckBNKixD1hsRLr1S01bEq1?=
 =?us-ascii?Q?VW6nVFIxcztezeE1f6bHZmBoewd0KajBJ8KuoGaC6R3Isa9A152wkKNRgiDd?=
 =?us-ascii?Q?3QN7B6GJzuYatJxG4L5tUBVXo28DpcImkuzuwH2zUY435/gYRlFIoCKLepbL?=
 =?us-ascii?Q?FCxm9Sf4nI3zTywgylUyelXuUT2Lgr87YkKSrsDzR5kuB1zucE78/0N0tFCF?=
 =?us-ascii?Q?HSthQpAbTpiRzGdtTqZF5Mi1DiTwjOQ+URA9n9GPBeCH588FRLJE9UDGnA3f?=
 =?us-ascii?Q?LewOnA3b7HfFfdv5D3bTerYUnVoc6rxlzFzwhpJFstfXe74WrSlFHcVMla5S?=
 =?us-ascii?Q?xbm9cyurSgPSYscbBVzfM3s1vtK3mVUYYU+qYbp/vb2tgzBDMyNdrHlROBqo?=
 =?us-ascii?Q?7XjM+e6AOrbrvME1niFPQ0DPmcp4PWKZ5mZUZrltzy1fGDa0dtLZnxFuCIRW?=
 =?us-ascii?Q?1twMgwlzag/vJPXeQhZUHNL+qv8ZRFMmGpPuwHNewP+OWoazip/3F637Zj/B?=
 =?us-ascii?Q?MlSNNtR5qW41tX5zQ8N5ngfjcCCvv8CI0Mcvv9X2WY3/91c2c8hAeqs8X/Tg?=
 =?us-ascii?Q?XKttTQI2w8iNGybpykiwz6HnI6Uw0KQNeY4AYPb6Cua1JvoNV2Hv/+pB876P?=
 =?us-ascii?Q?+UtkMOfD7u9GObftT7FjDQ8CqmeFFh1aEH0z/9o7NrBkY1+HFKgpzzJbTEvq?=
 =?us-ascii?Q?XrLaDQOH0HMwzS/A8Ihy5Pd8KO+vBb6ZcHVPIodpP4er241iDs9WbN5XoQ/Z?=
 =?us-ascii?Q?IgGR4NWe5+O6sDCSlVSdDPQKm8iJ34dIUKliS+1R/NRkzDO2fjtjg+BBi5jr?=
 =?us-ascii?Q?oymgOfvRj/RhfXWpenTbgj0kSRqYpz6IJYxMcWE6UeJEnV4ZuCDLblLFSbph?=
 =?us-ascii?Q?VCb7XoCnpXn611X2yoWEzJW7V9dAHn2JrYlZq1GlJfaR+68dJ02qU+Rtn8mh?=
 =?us-ascii?Q?za4rdxdftoVW+rgrHs17d1R41HEleeHyC58RbKF0vgkrndFzD/tzYVk90qsB?=
 =?us-ascii?Q?/v08l1rVLrbBYeDRlCrZIsbBcRGO19EarKLaRe5kWQLeH5YiV+M8/ngKHW/b?=
 =?us-ascii?Q?dz6CxVm5+uZeLl1+LLubiUU+ThW9h7iRpuEi30UB?=
X-MS-Exchange-CrossTenant-Network-Message-Id: e59e6aba-d718-4bca-cd6a-08dcc660196b
X-MS-Exchange-CrossTenant-AuthSource: PH0PR11MB4839.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 27 Aug 2024 06:18:42.6478
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: qtyzxyiuelSNBg58bXmUstE4UIRbUUN5G+2Jjhiy2XqocrLWkpE99VO8uukVOvWtZUDx+TlFrsAxWyJ/GjHlYg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH0PR11MB5063
X-OriginatorOrg: intel.com

Hi Maxime Chevallier,

On 2024-08-27 at 07:33:59 +0200, Maxime Chevallier wrote:
> Hi,
> 
> On Tue, 27 Aug 2024 13:25:52 +0800
> Pengfei Xu <pengfei.xu@intel.com> wrote:
> 
> > Hi Maxime Chevallier,
> > 
> > I used syzkaller and found that: there was general protection fault in
> > phy_start_cable_test_tdr in Linux next:next-20240826.
> > 
> > Bisected and found first bad commit:
> > "
> > 3688ff3077d3 net: ethtool: cable-test: Target the command to the requested PHY
> > "
> > After reverted below commit on top of next-20240826, this issue was gone.
> > 
> > All detailed info: https://github.com/xupengfe/syzkaller_logs/tree/main/240826_202302_phy_start_cable_test_tdr
> > Syzkaller repro code: https://github.com/xupengfe/syzkaller_logs/blob/main/240826_202302_phy_start_cable_test_tdr/repro.c
> > Syzkaller repro syscall steps: https://github.com/xupengfe/syzkaller_logs/blob/main/240826_202302_phy_start_cable_test_tdr/repro.prog
> > Syzkaller report: https://github.com/xupengfe/syzkaller_logs/blob/main/240826_202302_phy_start_cable_test_tdr/repro.report
> > Kconfig(make olddefconfig): https://github.com/xupengfe/syzkaller_logs/blob/main/240826_202302_phy_start_cable_test_tdr/kconfig_origin
> > Bisect info: https://github.com/xupengfe/syzkaller_logs/blob/main/240826_202302_phy_start_cable_test_tdr/bisect_info.log
> > bzImage: https://github.com/xupengfe/syzkaller_logs/raw/main/240826_202302_phy_start_cable_test_tdr/bzImage_1ca4237ad9ce29b0c66fe87862f1da54ac56a1e8.tar.gz
> > Issue dmesg: https://github.com/xupengfe/syzkaller_logs/blob/main/240826_202302_phy_start_cable_test_tdr/1ca4237ad9ce29b0c66fe87862f1da54ac56a1e8_dmesg.log
> 
> Thanks for the report !
> 
> This issue has indeed been detected, and is being addressed, see :
> 
> https://lore.kernel.org/netdev/20240826134656.94892-1-djahchankoike@gmail.com/

Thanks for your sharing of the solution!

Best Regards,
Thanks!


> 
> Thanks,
> 
> Maxime

