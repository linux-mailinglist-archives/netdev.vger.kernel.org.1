Return-Path: <netdev+bounces-307659-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id gv5vLjsYV2qJFQEAu9opvQ
	(envelope-from <netdev+bounces-307659-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Wed, 15 Jul 2026 07:18:51 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id D302F75AA21
	for <lists+netdev@lfdr.de>; Wed, 15 Jul 2026 07:18:50 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=intel.com header.s=Intel header.b=SLABAXQB;
	spf=pass (mail.lfdr.de: domain of "netdev+bounces-307659-lists+netdev=lfdr.de@vger.kernel.org" designates 2600:3c0a:e001:db::12fc:5321 as permitted sender) smtp.mailfrom="netdev+bounces-307659-lists+netdev=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=none) header.from=intel.com;
	arc=reject ("cv is fail on i=2")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 77A983069968
	for <lists+netdev@lfdr.de>; Wed, 15 Jul 2026 05:17:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C72423B4E9B;
	Wed, 15 Jul 2026 05:17:46 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.16])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1552B3B47CA;
	Wed, 15 Jul 2026 05:17:40 +0000 (UTC)
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784092666; cv=fail; b=uwUTYCdL8ATLdRQ0qQYrvtiAteuozH1NcRZLQKPweEwYI7OoDHaOVuK3fGqzIR3nKojCb3V1JVMJHsTpegWbV52MEgugY10OvM4A6VVQulKDsO3u0GXEutT6SYtBCJYQqS1nFuiJM8b6u8RbN9sFztYwzH8xGJsE1B1ng7mejcE=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784092666; c=relaxed/simple;
	bh=a6gFDC2WXYS75wBMx5TOJIX0yrOzridQFiVIOsDd0SA=;
	h=Date:From:To:CC:Subject:Message-ID:Content-Type:
	 Content-Disposition:MIME-Version; b=K/jF8JMi6NtII9Lu6hjgP8YVO00nryqdzAxrLIxpQ8evkHM9HUzX1l5WWBdf/UFhYS7u2Y+Fs47J/HqpYOU6a3SrES9OylIz1IopmyukbJkQjTWsv5PReh/8NHnLMH0I0dhUjmG4STO19EU+l8o+LaIKB2/XidCSKURkTVEyemg=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=SLABAXQB; arc=fail smtp.client-ip=192.198.163.16
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1784092661; x=1815628661;
  h=date:from:to:cc:subject:message-id:mime-version;
  bh=a6gFDC2WXYS75wBMx5TOJIX0yrOzridQFiVIOsDd0SA=;
  b=SLABAXQBle5dpDCIgHXpqwKF/ZHFuO70b1+G2AFVo7PwjYI2jKzfDlKU
   3xiCW7zyII4WRZwkADLDPYs/Hb0DsAVdDH9yn9qAXHRpodDXceHtPr3tD
   JKAL9IVuv3F5Nz/Oxx9Nx6W7zr7qSSPTYyxYIsElqkTeStImSX/Uw/M+i
   Mj1+kjWHXespSk6PNVloWQSrPaMDzaJE/iA5ytzNskCskp2S8pnjXjiZc
   iQdQYujfd9rq3nEcTqlhO5Ej90QnQU5LJdb1OYKMnTzaNQ0IlFe3f2M/I
   UGosMJC+uvnVDI6mW/dIa37DLGjqgvd/7Za0pONlPbQ17SpH6nAczp/Ll
   g==;
X-CSE-ConnectionGUID: 7NAtZ+xDTS2gvxGUwfYmVA==
X-CSE-MsgGUID: uZ/ifBm4S5SduGjQrIMksw==
X-IronPort-AV: E=McAfee;i="6800,10657,11847"; a="72247761"
X-IronPort-AV: E=Sophos;i="6.25,164,1779174000"; 
   d="scan'208";a="72247761"
Received: from fmviesa006.fm.intel.com ([10.60.135.146])
  by fmvoesa110.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 14 Jul 2026 22:17:40 -0700
X-CSE-ConnectionGUID: A2dxr/RgS+2FgU/CGVDNUA==
X-CSE-MsgGUID: 0jP6htOfRPO8qbNgUqmpcw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.25,164,1779174000"; 
   d="scan'208";a="251651436"
Received: from orsmsx902.amr.corp.intel.com ([10.22.229.24])
  by fmviesa006.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 14 Jul 2026 22:17:38 -0700
Received: from ORSMSX902.amr.corp.intel.com (10.22.229.24) by
 ORSMSX902.amr.corp.intel.com (10.22.229.24) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.43; Tue, 14 Jul 2026 22:17:37 -0700
Received: from ORSEDG902.ED.cps.intel.com (10.7.248.12) by
 ORSMSX902.amr.corp.intel.com (10.22.229.24) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.43 via Frontend Transport; Tue, 14 Jul 2026 22:17:37 -0700
Received: from SN4PR2101CU001.outbound.protection.outlook.com (40.93.195.62)
 by edgegateway.intel.com (134.134.137.112) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.43; Tue, 14 Jul 2026 22:17:35 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=fWwW1SvGbOv5Hcf+Q9QWfmuRp1apt/VrIopC03JcTu8az0/ZxfuMTsUe6QJ2R/dLCzPfvJORvRIegjgW8zRvLjNJcELZd0Ksn77rjqn2yiOV8pCPB+qGeROe4NOQK0nFmiJY2VWfxlZKsemcWTEpeAlszHjEBsxoOfhiKFVn3TGsO5Fc1racGZ3tS11rFYoEU2aXtv1Sg3GnHVorOX9gNpZxQX+pm0QQJ4D7PrEo+SAK9MytnKRbQYX+GvbLMTEXSHmZA0aJ/vFl51Q/N9GnILiVIZddOmORXeFC/7tRakcDptkLq+60wp9Z9vWdzYteOTZTrxX8xHrwPxQNkh38iA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=CmkNRFgO86WJNgrjKa4f71hcrdr9OXvpV0Uby21HBB8=;
 b=rg1fPs0PisS4jQFRIYMbSeiEKo5XJyuJ0KZZVn7H5HwWiwIrGenLS9RGU4aUjjsGl3YFUvKR4ICITX3HGJpBd+jT2kl3530VHHSHu7eWsJpH61TmBZw3N0mvbBRtRxfGw1x+/rfh0/3z6mFNcaxlQMuNnwRUSj5wqffY4Mxd5Q9JWXboMiMZBVoXAhTlcBec8ktvpWCsTlcf0ePF93v1WdYRLus9FQtqWc9pROFISlgoBsvm/kYr2+shd6s+PGTVL0nOrQPwrTVmttwKnDPzcaRouyR5cV0ISyOGl/5USvna6NaSVv9yxlyIZsKb6YQRpInSED46Hhsi27A9FBmVxQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from PH0PR11MB5832.namprd11.prod.outlook.com (2603:10b6:510:141::7)
 by SA1PR11MB7064.namprd11.prod.outlook.com (2603:10b6:806:2b7::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.223.10; Wed, 15 Jul
 2026 05:17:32 +0000
Received: from PH0PR11MB5832.namprd11.prod.outlook.com
 ([fe80::106e:78dd:4c96:d707]) by PH0PR11MB5832.namprd11.prod.outlook.com
 ([fe80::106e:78dd:4c96:d707%5]) with mapi id 15.21.0223.008; Wed, 15 Jul 2026
 05:17:28 +0000
Date: Wed, 15 Jul 2026 13:17:19 +0800
From: kernel test robot <oliver.sang@intel.com>
To: Qingfang Deng <qingfang.deng@linux.dev>
CC: <oe-lkp@lists.linux.dev>, <lkp@intel.com>, <linux-kernel@vger.kernel.org>,
	Paolo Abeni <pabeni@redhat.com>, <netdev@vger.kernel.org>,
	<oliver.sang@intel.com>
Subject: [linus:master] [selftests]  6160ec9d03:
 kselftests-bpf.drivers/net.gro.py.fail
Message-ID: <202607150740.c8e9119d-lkp@intel.com>
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
User-Agent: s-nail v14.9.25
X-ClientProxiedBy: KL1PR0401CA0017.apcprd04.prod.outlook.com
 (2603:1096:820:f::22) To PH0PR11MB5832.namprd11.prod.outlook.com
 (2603:10b6:510:141::7)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH0PR11MB5832:EE_|SA1PR11MB7064:EE_
X-MS-Office365-Filtering-Correlation-Id: fd3315a6-01a6-4614-38b6-08dee2305d42
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|23010399003|366016|1800799024|376014|13003099007|3023799007|11063799006|56012099006|6133799003|18002099003;
X-Microsoft-Antispam-Message-Info: RCGz1+aO2rRpY+VHHd0117zasnGDAJ5QcehhBjjTqbVwnqSobsgeg69cPN2dJ0ow9dfLNCEmt9rwt7EJnXH10+HSNFN0PG7QE1YQpL5UjYCy9IV4IYph28XTTBWJmpZhJudKlfmGX6zIlglUsVJ1UG1je8JSgWnuldbSUoKClyaMPVH7ENhDyhbchdedyT/KJZmfgbxCaYqydgAAm2h6786sqBHrMI4p4aJ12ccGhkEbjngJoSfChd4LP6ucUt+AN4YhTRQPu0VRa3dgjh8nUwv8gapUWzF9HY/vZjat2fPWz6VTawp6XPQ592Yna5JqeD0sA2Rujmwvfp6zwtlM1upH6Av+LEqqMpPvnE/bTHRqw6jOYfn2sFz51sAMWvZf1RkPBvvVLNWyJw3ebSn+CdZg8cQ0pzGHbfARhCAT76M/nWtkQ2gSPVBy+OImLaMPAyUPR4vhMS6AsByqTdiKIvQ/zfFdh6Cf0CNhe+z/Kf0v41l2m52mWdj88CE/l6O3X4Pea9/+3guPopaYjQLqHYrZ0+C9wF7c+4ObF0JB1cyBByp8NXFid7YIJTeCtAibDJFUVvuCDa5nt/Js4F0m8PtxN9gH5D3mk+Lbboo5G+4=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH0PR11MB5832.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(23010399003)(366016)(1800799024)(376014)(13003099007)(3023799007)(11063799006)(56012099006)(6133799003)(18002099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?j/X56QcOW/ynvwAbyxXPt2SgUQdhFqFj16haLR2O/df9iqPzfX4unYSqGVh6?=
 =?us-ascii?Q?9bQ/k0hUwUPsuOKhH1BeS6shuukp/zKFLFRUJa/LaEvuMS6W5LN+nwBEUagj?=
 =?us-ascii?Q?3FJ2jHFxRqlHfBXlJ+/GB5+igaj3/6OLPaechJd8RV90YhOYLT8GLU/t7V9q?=
 =?us-ascii?Q?02EfEoV65DnVyocQqPf7x7GaY0tcXwyigGjzlmD5BX+4cp7WQRxsKsW+TzEO?=
 =?us-ascii?Q?yUqnYcMCLRI7sLGhQICicA026OMfMM+oHttIgw2jiDVxQcJpNEVVu1/aLRxm?=
 =?us-ascii?Q?Z0B1z/nK8ReE9pqeX0BMFuQdRkm5FTOvapxj20MP2DLkYNboCT1KaysmqyLR?=
 =?us-ascii?Q?xFWb1D63X11QCHyjzrmRQPwsXw4yj4ieAbunFU+Mt7Z9JQMtd1hYvubNH5bf?=
 =?us-ascii?Q?pEKSfeQyZGiPIdkPFPIQEnp2XaI0U22WahxQ5lgIzZl4t/noQ/N9tEROluAU?=
 =?us-ascii?Q?OcpTR5xTu1TiYLweDRmfWZqE5wwg+aF3mVEvhusA2aT+kt2tF9E2Aw/6e0Fx?=
 =?us-ascii?Q?EaU7lwbcSwf8t/zajQ52HFA8NS82V4tXebtxDLZmEe631oTQzaGc1WXxK26m?=
 =?us-ascii?Q?GjaV6IqB6xfSYKp12DIbmxuDOSOWkvtQ7KsgMWwSsQ3wN9yDkue4qeQDvYV1?=
 =?us-ascii?Q?/D02b57ipTcvTUFgCH6GDOhwc+LWtq616uQtOxqsn3d4uCvhSzbAKIavXLCC?=
 =?us-ascii?Q?NA2mkKRQE0IabJIVy3sOQhwfJ6kW2Jzo5v/lwSbfCWnAQJ8KMxYRPlH/4do4?=
 =?us-ascii?Q?OdrF6RQgYeU4Mgqul+7KoT3HLeWB1Y++CCf2vn/MiKO9AIoDgrB8qORSWTdT?=
 =?us-ascii?Q?h1O5OQaWLF+4LDAkD0nf/AutICbIoB4Ht3jvxgQB9OGCKk1anrMwB9/P6s0j?=
 =?us-ascii?Q?/W1uMcn/hzN83tRrZ0SVN9wq/cAhy4eAUncplA4rKSJiDElH2unZAphN8xsc?=
 =?us-ascii?Q?fNixn1VC2Nvq9a0LHz12wndX1EAH9FZQSWrzTxPzh4w0fhkx5ZDpTOvfHpnA?=
 =?us-ascii?Q?FtthXZNylVPmMjkl0PRZTK5h2dCvFmcTYPs0nSFU/Af+8/q5lQ/0PgS+u1ZC?=
 =?us-ascii?Q?T6YDd4CLgg6liT/sFAlZxjVxXzXl0xwR/2FocvU5nlo3XW0F9EyUH6GxkG90?=
 =?us-ascii?Q?sLAZTKZgLUOIP9ELbcN6XIs2KNJ0luOd3Ke/LI5oLGj22AHbvEjeMnv1Ae0S?=
 =?us-ascii?Q?c8a5MVpnNmEQ3jEVDEr9kuJnw8WkIWYHW3bmYcEOemty47pfFYFOM/QjXEzY?=
 =?us-ascii?Q?qIg28rOC/VPws+O3tERJk/gUhyK3YLbJeQDet4a32RfUMX+tc43Zc+vX5NUg?=
 =?us-ascii?Q?5wcf2dpQxX64ZdLhxXoskjkCKNZMlznSFOlut5l9ieLI6pyw96mJdeCrGsTY?=
 =?us-ascii?Q?hj5sNTWv/DH30wmtwTHfrli9HZKKJdoRemVgqLPgFdwgaiwkUvCZGBc6d4IK?=
 =?us-ascii?Q?g1xZc1E2hJIW+k9zXtYJP959WsX/TZToY9XU+VJiBak8ukCK0Ia/VqwgFMJ1?=
 =?us-ascii?Q?0kgQFgx9p/ktToRnH2qZOPy8Rhdywl4xfqLlR6KFqjBJS0VNMsFH9e4aQEw9?=
 =?us-ascii?Q?hJDGJ22RfoLtqkhJdc68frUDlIGi5N5kyaPluDkMurJuZct714mgvmGo4C5u?=
 =?us-ascii?Q?3pcNbhV9v5USdCjUoL1ltl9hq2ld2YY/wVN8PI6KfiTsVT3XNCJUXk+fo6yS?=
 =?us-ascii?Q?JY1+I9v36El17UD7BQbGi8KmKPjPBp7xl8BDFWpijjDLyjGsLGSaP93CD1Hi?=
 =?us-ascii?Q?okMODqohJQ=3D=3D?=
X-Exchange-RoutingPolicyChecked: rYektcUjx7zuof0igwFrJc/WxTQiADkHjLARVTkAyCj3CvfIv0cqTHcvazvJvFkEoI8VM4E7gT27A1SxhjawyIxyE0aVX/9FRkVCTZGxZpSI6jX91AHD/IW6cwwchtz91qt4sRTDMBTwRDJwusTdznB5Ps3GzGVdYlDtt9JeNmQdvUNPiOtPaYHsI7dhjiZBfQVaSGsAAsZUZD6xFEXameuYlNC0qxD2Qselrk8NnLwkDxNHo11NoWZpWQNbMNzHcdHVI+VtNV7CWw8uyOOApumjmF9/5dSpSooldgK7/qaZ8gB2bZENs5DZwNZTcvlTkl1z9fopF1qaJjTTVaGQLQ==
X-MS-Exchange-CrossTenant-Network-Message-Id: fd3315a6-01a6-4614-38b6-08dee2305d42
X-MS-Exchange-CrossTenant-AuthSource: PH0PR11MB5832.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 15 Jul 2026 05:17:28.8350
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: UrkOPpfjppZzh+3F3T/E2GiwewGbIwbZ1XAiFZtOY0xXT0TOymOnvLan9DnrMAKPRRDEItVxKHzZpo79iZ74xA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA1PR11MB7064
X-OriginatorOrg: intel.com
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-3.16 / 15.00];
	WHITELIST_SPF_DKIM(-3.00)[intel.com:d:+,kernel.org:s:+];
	ARC_REJECT(1.00)[cv is fail on i=2];
	DMARC_POLICY_ALLOW(-0.50)[intel.com,none];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	R_DKIM_ALLOW(-0.20)[intel.com:s=Intel];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-307659-lists,netdev=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[intel.com:from_mime,intel.com:mid,intel.com:email,intel.com:dkim,01.org:url,sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,vger.kernel.org:from_smtp,gro.py:url];
	FORGED_SENDER(0.00)[oliver.sang@intel.com,netdev@vger.kernel.org];
	MIME_TRACE(0.00)[0:+];
	FORGED_RECIPIENTS(0.00)[m:qingfang.deng@linux.dev,m:oe-lkp@lists.linux.dev,m:lkp@intel.com,m:linux-kernel@vger.kernel.org,m:pabeni@redhat.com,m:netdev@vger.kernel.org,m:oliver.sang@intel.com,s:lists@lfdr.de];
	FORWARDED(0.00)[lists@lfdr.de];
	FORGED_SENDER_MAILLIST(0.00)[];
	DKIM_TRACE(0.00)[intel.com:+];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[oliver.sang@intel.com,netdev@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	ALIAS_RESOLVED(0.00)[];
	MID_RHS_MATCH_FROM(0.00)[];
	RCPT_COUNT_SEVEN(0.00)[7];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	TAGGED_RCPT(0.00)[netdev];
	RCVD_COUNT_SEVEN(0.00)[10]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: D302F75AA21



Hello,

kernel test robot noticed "kselftests-bpf.drivers/net.gro.py.fail" on:

commit: 6160ec9d03d7af5aa345b8b994de80fa8454274b ("selftests: net: test PPPoE packets in gro.sh")
https://git.kernel.org/cgit/linux/kernel/git/torvalds/linux.git master

[test failed on linus/master      0e35b9b6ec0ffcc5e23cbdec09f5c622ad532b53]
[test failed on linux-next/master 5c73cd9f0819c1c44e373e3dabb68318b1de1a12]

in testcase: kselftests-bpf
version: 
with following parameters:

	group: drivers


config: x86_64-rhel-9.4-bpf
compiler: gcc-14
test machine: 16 threads Intel(R) Core(TM) i7-13620H (Raptor Lake) with 32G memory

(please refer to attached dmesg/kmsg for entire log/backtrace)


If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <oliver.sang@intel.com>
| Closes: https://lore.kernel.org/oe-lkp/202607150740.c8e9119d-lkp@intel.com


# timeout set to 300
# selftests: drivers/net: gro.py
# TAP version 13
# 1..318
# ok 1 gro.test.sw_ipv4_data_same
# ok 2 gro.test.sw_ipv4_data_lrg_sml
# ok 3 gro.test.sw_ipv4_data_sml_lrg
# ok 4 gro.test.sw_ipv4_data_lrg_1byte
# ok 5 gro.test.sw_ipv4_data_burst
# ok 6 gro.test.sw_ipv4_ack
# # CMD: /usr/src/perf_selftests-x86_64-rhel-9.4-bpf-6160ec9d03d7af5aa345b8b994de80fa8454274b/tools/testing/selftests/net/lib/gro --ipv4 --dmac 8e:06:42:98:a9:5f --smac c6:e6:7b:ad:54:ed --daddr 192.0.2.1 --saddr 192.0.2.2 --test flags_psh --verbose --rx --iface eth1
# #   EXIT: 1
# #   STDOUT: psh flag ends coalescing:
# #   STDERR: Expected {300 200 }, Total 2 packets
# #           Received {200 [!=300]100 [!=200]200 [!=0]}, Total 3 packets.
# #           /usr/src/perf_selftests-x86_64-rhel-9.4-bpf-6160ec9d03d7af5aa345b8b994de80fa8454274b/tools/testing/selftests/net/lib/gro: incorrect number of packets
# # Attempt 1/6 failed, retrying...
# ok 7 gro.test.sw_ipv4_flags_psh
# ok 8 gro.test.sw_ipv4_flags_syn
# ok 9 gro.test.sw_ipv4_flags_rst
# ok 10 gro.test.sw_ipv4_flags_urg
# ok 11 gro.test.sw_ipv4_flags_cwr
# ok 12 gro.test.sw_ipv4_tcp_csum
# ok 13 gro.test.sw_ipv4_tcp_seq
# ok 14 gro.test.sw_ipv4_tcp_ts
# ok 15 gro.test.sw_ipv4_tcp_opt
# ok 16 gro.test.sw_ipv4_ip_ecn
# ok 17 gro.test.sw_ipv4_ip_tos
# ok 18 gro.test.sw_ipv4_large_max
# # CMD: /usr/src/perf_selftests-x86_64-rhel-9.4-bpf-6160ec9d03d7af5aa345b8b994de80fa8454274b/tools/testing/selftests/net/lib/gro --ipv4 --dmac 8e:06:42:98:a9:5f --smac c6:e6:7b:ad:54:ed --daddr 192.0.2.1 --saddr 192.0.2.2 --test large_rem --verbose --rx --iface eth1
# #   EXIT: 1
# #   STDOUT: last segment sent individually:
# #   STDERR: Expected {64896 600 600 }, Total 3 packets
# #           Received {48672 [!=64896]16824 [!=600]600 }, Total 3 packets.
# #           /usr/src/perf_selftests-x86_64-rhel-9.4-bpf-6160ec9d03d7af5aa345b8b994de80fa8454274b/tools/testing/selftests/net/lib/gro: incorrect packet geometry
# # Attempt 1/6 failed, retrying...
# # CMD: /usr/src/perf_selftests-x86_64-rhel-9.4-bpf-6160ec9d03d7af5aa345b8b994de80fa8454274b/tools/testing/selftests/net/lib/gro --ipv4 --dmac 8e:06:42:98:a9:5f --smac c6:e6:7b:ad:54:ed --daddr 192.0.2.1 --saddr 192.0.2.2 --test large_rem --verbose --rx --iface eth1
# #   EXIT: 1
# #   STDOUT: last segment sent individually:
# #   STDERR: Expected {64896 600 600 }, Total 3 packets
# #           Received {40560 [!=64896]24936 [!=600]600 }, Total 3 packets.
# #           /usr/src/perf_selftests-x86_64-rhel-9.4-bpf-6160ec9d03d7af5aa345b8b994de80fa8454274b/tools/testing/selftests/net/lib/gro: incorrect packet geometry
# # Attempt 2/6 failed, retrying...
# ok 19 gro.test.sw_ipv4_large_rem
# ok 20 gro.test.sw_ipv4_ip_csum
# ok 21 gro.test.sw_ipv4_ip_ttl
# ok 22 gro.test.sw_ipv4_ip_opt
# ok 23 gro.test.sw_ipv4_ip_frag4
# ok 24 gro.test.sw_ipv4_ip_id_df1_inc
# ok 25 gro.test.sw_ipv4_ip_id_df1_fixed
# ok 26 gro.test.sw_ipv4_ip_id_df0_inc
# ok 27 gro.test.sw_ipv4_ip_id_df0_fixed
# ok 28 gro.test.sw_ipv4_ip_id_df1_inc_fixed
# ok 29 gro.test.sw_ipv4_ip_id_df1_fixed_inc
# ok 30 gro.test.sw_ipv6_data_same
# ok 31 gro.test.sw_ipv6_data_lrg_sml
# ok 32 gro.test.sw_ipv6_data_sml_lrg
# ok 33 gro.test.sw_ipv6_data_lrg_1byte
# ok 34 gro.test.sw_ipv6_data_burst
# ok 35 gro.test.sw_ipv6_ack
# ok 36 gro.test.sw_ipv6_flags_psh
# ok 37 gro.test.sw_ipv6_flags_syn
# ok 38 gro.test.sw_ipv6_flags_rst
# ok 39 gro.test.sw_ipv6_flags_urg
# ok 40 gro.test.sw_ipv6_flags_cwr
# ok 41 gro.test.sw_ipv6_tcp_csum
# ok 42 gro.test.sw_ipv6_tcp_seq
# ok 43 gro.test.sw_ipv6_tcp_ts
# ok 44 gro.test.sw_ipv6_tcp_opt
# ok 45 gro.test.sw_ipv6_ip_ecn
# ok 46 gro.test.sw_ipv6_ip_tos
# ok 47 gro.test.sw_ipv6_large_max
# ok 48 gro.test.sw_ipv6_large_rem
# ok 49 gro.test.sw_ipv6_ip_frag6
# ok 50 gro.test.sw_ipv6_ip_v6ext_same
# ok 51 gro.test.sw_ipv6_ip_v6ext_diff
# ok 52 gro.test.sw_ipip_data_same
# ok 53 gro.test.sw_ipip_data_lrg_sml
# ok 54 gro.test.sw_ipip_data_sml_lrg
# ok 55 gro.test.sw_ipip_data_lrg_1byte
# ok 56 gro.test.sw_ipip_data_burst
# ok 57 gro.test.sw_ipip_ack
# ok 58 gro.test.sw_ipip_flags_psh
# ok 59 gro.test.sw_ipip_flags_syn
# ok 60 gro.test.sw_ipip_flags_rst
# ok 61 gro.test.sw_ipip_flags_urg
# ok 62 gro.test.sw_ipip_flags_cwr
# ok 63 gro.test.sw_ipip_tcp_csum
# ok 64 gro.test.sw_ipip_tcp_seq
# ok 65 gro.test.sw_ipip_tcp_ts
# ok 66 gro.test.sw_ipip_tcp_opt
# ok 67 gro.test.sw_ipip_ip_ecn
# ok 68 gro.test.sw_ipip_ip_tos
# # CMD: /usr/src/perf_selftests-x86_64-rhel-9.4-bpf-6160ec9d03d7af5aa345b8b994de80fa8454274b/tools/testing/selftests/net/lib/gro --ipip --dmac 8e:06:42:98:a9:5f --smac c6:e6:7b:ad:54:ed --daddr 192.0.2.1 --saddr 192.0.2.2 --test large_max --verbose --rx --iface eth1
# #   EXIT: 1
# #   STDOUT: Shouldn't coalesce if exceed IP max pkt size:
# #   STDERR: Expected {65475 899 }, Total 2 packets
# #           Received {40360 [!=65475]25115 [!=899]899 [!=0]}, Total 3 packets.
# #           /usr/src/perf_selftests-x86_64-rhel-9.4-bpf-6160ec9d03d7af5aa345b8b994de80fa8454274b/tools/testing/selftests/net/lib/gro: incorrect number of packets
# # Attempt 1/6 failed, retrying...
# ok 69 gro.test.sw_ipip_large_max
# ok 70 gro.test.sw_ipip_large_rem
# ok 71 gro.test.sw_ipip_ip_csum
# ok 72 gro.test.sw_ipip_ip_ttl
# ok 73 gro.test.sw_ipip_ip_opt
# ok 74 gro.test.sw_ipip_ip_frag4
# ok 75 gro.test.sw_ipip_ip_id_df1_inc
# ok 76 gro.test.sw_ipip_ip_id_df1_fixed
# ok 77 gro.test.sw_ipip_ip_id_df0_inc
# ok 78 gro.test.sw_ipip_ip_id_df0_fixed
# ok 79 gro.test.sw_ipip_ip_id_df1_inc_fixed
# ok 80 gro.test.sw_ipip_ip_id_df1_fixed_inc
# ok 81 gro.test.sw_ip6ip6_data_same
# ok 82 gro.test.sw_ip6ip6_data_lrg_sml
# ok 83 gro.test.sw_ip6ip6_data_sml_lrg
# ok 84 gro.test.sw_ip6ip6_data_lrg_1byte
# ok 85 gro.test.sw_ip6ip6_data_burst
# ok 86 gro.test.sw_ip6ip6_ack
# ok 87 gro.test.sw_ip6ip6_flags_psh
# ok 88 gro.test.sw_ip6ip6_flags_syn
# ok 89 gro.test.sw_ip6ip6_flags_rst
# ok 90 gro.test.sw_ip6ip6_flags_urg
# ok 91 gro.test.sw_ip6ip6_flags_cwr
# ok 92 gro.test.sw_ip6ip6_tcp_csum
# ok 93 gro.test.sw_ip6ip6_tcp_seq
# ok 94 gro.test.sw_ip6ip6_tcp_ts
# ok 95 gro.test.sw_ip6ip6_tcp_opt
# ok 96 gro.test.sw_ip6ip6_ip_ecn
# ok 97 gro.test.sw_ip6ip6_ip_tos
# # CMD: /usr/src/perf_selftests-x86_64-rhel-9.4-bpf-6160ec9d03d7af5aa345b8b994de80fa8454274b/tools/testing/selftests/net/lib/gro --ip6ip6 --dmac 8e:06:42:98:a9:5f --smac c6:e6:7b:ad:54:ed --daddr 2001:db8::1 --saddr 2001:db8::2 --test large_max --verbose --rx --iface eth1
# #   EXIT: 1
# #   STDOUT: Shouldn't coalesce if exceed IP max pkt size:
# #   STDERR: Expected {65435 1499 }, Total 2 packets
# #           Received {63936 [!=65435]1499 1499 [!=0]}, Total 3 packets.
# #           /usr/src/perf_selftests-x86_64-rhel-9.4-bpf-6160ec9d03d7af5aa345b8b994de80fa8454274b/tools/testing/selftests/net/lib/gro: incorrect number of packets
# # Attempt 1/6 failed, retrying...
# # CMD: /usr/src/perf_selftests-x86_64-rhel-9.4-bpf-6160ec9d03d7af5aa345b8b994de80fa8454274b/tools/testing/selftests/net/lib/gro --ip6ip6 --dmac 8e:06:42:98:a9:5f --smac c6:e6:7b:ad:54:ed --daddr 2001:db8::1 --saddr 2001:db8::2 --test large_max --verbose --rx --iface eth1
# #   EXIT: 1
# #   STDOUT: Shouldn't coalesce if exceed IP max pkt size:
# #   STDERR: Expected {65435 1499 }, Total 2 packets
# #           Received {23976 [!=65435]41459 [!=1499]1499 [!=0]}, Total 3 packets.
# #           /usr/src/perf_selftests-x86_64-rhel-9.4-bpf-6160ec9d03d7af5aa345b8b994de80fa8454274b/tools/testing/selftests/net/lib/gro: incorrect number of packets
# # Attempt 2/6 failed, retrying...
# # CMD: /usr/src/perf_selftests-x86_64-rhel-9.4-bpf-6160ec9d03d7af5aa345b8b994de80fa8454274b/tools/testing/selftests/net/lib/gro --ip6ip6 --dmac 8e:06:42:98:a9:5f --smac c6:e6:7b:ad:54:ed --daddr 2001:db8::1 --saddr 2001:db8::2 --test large_max --verbose --rx --iface eth1
# #   EXIT: 1
# #   STDOUT: Shouldn't coalesce if exceed IP max pkt size:
# #   STDERR: Expected {65435 1499 }, Total 2 packets
# #           Received {19980 [!=65435]45455 [!=1499]1499 [!=0]}, Total 3 packets.
# #           /usr/src/perf_selftests-x86_64-rhel-9.4-bpf-6160ec9d03d7af5aa345b8b994de80fa8454274b/tools/testing/selftests/net/lib/gro: incorrect number of packets
# # Attempt 3/6 failed, retrying...
# # CMD: /usr/src/perf_selftests-x86_64-rhel-9.4-bpf-6160ec9d03d7af5aa345b8b994de80fa8454274b/tools/testing/selftests/net/lib/gro --ip6ip6 --dmac 8e:06:42:98:a9:5f --smac c6:e6:7b:ad:54:ed --daddr 2001:db8::1 --saddr 2001:db8::2 --test large_max --verbose --rx --iface eth1
# #   EXIT: 1
# #   STDOUT: Shouldn't coalesce if exceed IP max pkt size:
# #   STDERR: Expected {65435 1499 }, Total 2 packets
# #           Received {23976 [!=65435]41459 [!=1499]1499 [!=0]}, Total 3 packets.
# #           /usr/src/perf_selftests-x86_64-rhel-9.4-bpf-6160ec9d03d7af5aa345b8b994de80fa8454274b/tools/testing/selftests/net/lib/gro: incorrect number of packets
# # Attempt 4/6 failed, retrying...
# # CMD: /usr/src/perf_selftests-x86_64-rhel-9.4-bpf-6160ec9d03d7af5aa345b8b994de80fa8454274b/tools/testing/selftests/net/lib/gro --ip6ip6 --dmac 8e:06:42:98:a9:5f --smac c6:e6:7b:ad:54:ed --daddr 2001:db8::1 --saddr 2001:db8::2 --test large_max --verbose --rx --iface eth1
# #   EXIT: 1
# #   STDOUT: Shouldn't coalesce if exceed IP max pkt size:
# #   STDERR: Expected {65435 1499 }, Total 2 packets
# #           Received {31968 [!=65435]33467 [!=1499]1499 [!=0]}, Total 3 packets.
# #           /usr/src/perf_selftests-x86_64-rhel-9.4-bpf-6160ec9d03d7af5aa345b8b994de80fa8454274b/tools/testing/selftests/net/lib/gro: incorrect number of packets
# # Attempt 5/6 failed, retrying...
# ok 98 gro.test.sw_ip6ip6_large_max
# # CMD: /usr/src/perf_selftests-x86_64-rhel-9.4-bpf-6160ec9d03d7af5aa345b8b994de80fa8454274b/tools/testing/selftests/net/lib/gro --ip6ip6 --dmac 8e:06:42:98:a9:5f --smac c6:e6:7b:ad:54:ed --daddr 2001:db8::1 --saddr 2001:db8::2 --test large_rem --verbose --rx --iface eth1
# #   EXIT: 1
# #   STDOUT: last segment sent individually:
# #   STDERR: Expected {63936 1500 1500 }, Total 3 packets
# #           Received {51948 [!=63936]13488 [!=1500]1500 }, Total 3 packets.
# #           /usr/src/perf_selftests-x86_64-rhel-9.4-bpf-6160ec9d03d7af5aa345b8b994de80fa8454274b/tools/testing/selftests/net/lib/gro: incorrect packet geometry
# # Attempt 1/6 failed, retrying...
# ok 99 gro.test.sw_ip6ip6_large_rem
# ok 100 gro.test.hw_ipv4_data_same # XFAIL Device does not support rx-gro-hw
# ok 101 gro.test.hw_ipv4_data_lrg_sml # XFAIL Device does not support rx-gro-hw
# ok 102 gro.test.hw_ipv4_data_sml_lrg # XFAIL Device does not support rx-gro-hw
# ok 103 gro.test.hw_ipv4_data_lrg_1byte # XFAIL Device does not support rx-gro-hw
# ok 104 gro.test.hw_ipv4_data_burst # XFAIL Device does not support rx-gro-hw
# ok 105 gro.test.hw_ipv4_ack # XFAIL Device does not support rx-gro-hw
# ok 106 gro.test.hw_ipv4_flags_psh # XFAIL Device does not support rx-gro-hw
# ok 107 gro.test.hw_ipv4_flags_syn # XFAIL Device does not support rx-gro-hw
# ok 108 gro.test.hw_ipv4_flags_rst # XFAIL Device does not support rx-gro-hw
# ok 109 gro.test.hw_ipv4_flags_urg # XFAIL Device does not support rx-gro-hw
# ok 110 gro.test.hw_ipv4_flags_cwr # XFAIL Device does not support rx-gro-hw
# ok 111 gro.test.hw_ipv4_tcp_csum # XFAIL Device does not support rx-gro-hw
# ok 112 gro.test.hw_ipv4_tcp_seq # XFAIL Device does not support rx-gro-hw
# ok 113 gro.test.hw_ipv4_tcp_ts # XFAIL Device does not support rx-gro-hw
# ok 114 gro.test.hw_ipv4_tcp_opt # XFAIL Device does not support rx-gro-hw
# ok 115 gro.test.hw_ipv4_ip_ecn # XFAIL Device does not support rx-gro-hw
# ok 116 gro.test.hw_ipv4_ip_tos # XFAIL Device does not support rx-gro-hw
# ok 117 gro.test.hw_ipv4_large_max # XFAIL Device does not support rx-gro-hw
# ok 118 gro.test.hw_ipv4_large_rem # XFAIL Device does not support rx-gro-hw
# ok 119 gro.test.hw_ipv4_ip_csum # XFAIL Device does not support rx-gro-hw
# ok 120 gro.test.hw_ipv4_ip_ttl # XFAIL Device does not support rx-gro-hw
# ok 121 gro.test.hw_ipv4_ip_opt # XFAIL Device does not support rx-gro-hw
# ok 122 gro.test.hw_ipv4_ip_frag4 # XFAIL Device does not support rx-gro-hw
# ok 123 gro.test.hw_ipv4_ip_id_df1_inc # XFAIL Device does not support rx-gro-hw
# ok 124 gro.test.hw_ipv4_ip_id_df1_fixed # XFAIL Device does not support rx-gro-hw
# ok 125 gro.test.hw_ipv4_ip_id_df0_inc # XFAIL Device does not support rx-gro-hw
# ok 126 gro.test.hw_ipv4_ip_id_df0_fixed # XFAIL Device does not support rx-gro-hw
# ok 127 gro.test.hw_ipv4_ip_id_df1_inc_fixed # XFAIL Device does not support rx-gro-hw
# ok 128 gro.test.hw_ipv4_ip_id_df1_fixed_inc # XFAIL Device does not support rx-gro-hw
# ok 129 gro.test.hw_ipv6_data_same # XFAIL Device does not support rx-gro-hw
# ok 130 gro.test.hw_ipv6_data_lrg_sml # XFAIL Device does not support rx-gro-hw
# ok 131 gro.test.hw_ipv6_data_sml_lrg # XFAIL Device does not support rx-gro-hw
# ok 132 gro.test.hw_ipv6_data_lrg_1byte # XFAIL Device does not support rx-gro-hw
# ok 133 gro.test.hw_ipv6_data_burst # XFAIL Device does not support rx-gro-hw
# ok 134 gro.test.hw_ipv6_ack # XFAIL Device does not support rx-gro-hw
# ok 135 gro.test.hw_ipv6_flags_psh # XFAIL Device does not support rx-gro-hw
# ok 136 gro.test.hw_ipv6_flags_syn # XFAIL Device does not support rx-gro-hw
# ok 137 gro.test.hw_ipv6_flags_rst # XFAIL Device does not support rx-gro-hw
# ok 138 gro.test.hw_ipv6_flags_urg # XFAIL Device does not support rx-gro-hw
# ok 139 gro.test.hw_ipv6_flags_cwr # XFAIL Device does not support rx-gro-hw
# ok 140 gro.test.hw_ipv6_tcp_csum # XFAIL Device does not support rx-gro-hw
# ok 141 gro.test.hw_ipv6_tcp_seq # XFAIL Device does not support rx-gro-hw
# ok 142 gro.test.hw_ipv6_tcp_ts # XFAIL Device does not support rx-gro-hw
# ok 143 gro.test.hw_ipv6_tcp_opt # XFAIL Device does not support rx-gro-hw
# ok 144 gro.test.hw_ipv6_ip_ecn # XFAIL Device does not support rx-gro-hw
# ok 145 gro.test.hw_ipv6_ip_tos # XFAIL Device does not support rx-gro-hw
# ok 146 gro.test.hw_ipv6_large_max # XFAIL Device does not support rx-gro-hw
# ok 147 gro.test.hw_ipv6_large_rem # XFAIL Device does not support rx-gro-hw
# ok 148 gro.test.hw_ipv6_ip_frag6 # XFAIL Device does not support rx-gro-hw
# ok 149 gro.test.hw_ipv6_ip_v6ext_same # XFAIL Device does not support rx-gro-hw
# ok 150 gro.test.hw_ipv6_ip_v6ext_diff # XFAIL Device does not support rx-gro-hw
# ok 151 gro.test.hw_ipip_data_same # XFAIL Device does not support rx-gro-hw
# ok 152 gro.test.hw_ipip_data_lrg_sml # XFAIL Device does not support rx-gro-hw
# ok 153 gro.test.hw_ipip_data_sml_lrg # XFAIL Device does not support rx-gro-hw
# ok 154 gro.test.hw_ipip_data_lrg_1byte # XFAIL Device does not support rx-gro-hw
# ok 155 gro.test.hw_ipip_data_burst # XFAIL Device does not support rx-gro-hw
# ok 156 gro.test.hw_ipip_ack # XFAIL Device does not support rx-gro-hw
# ok 157 gro.test.hw_ipip_flags_psh # XFAIL Device does not support rx-gro-hw
# ok 158 gro.test.hw_ipip_flags_syn # XFAIL Device does not support rx-gro-hw
# ok 159 gro.test.hw_ipip_flags_rst # XFAIL Device does not support rx-gro-hw
# ok 160 gro.test.hw_ipip_flags_urg # XFAIL Device does not support rx-gro-hw
# ok 161 gro.test.hw_ipip_flags_cwr # XFAIL Device does not support rx-gro-hw
# ok 162 gro.test.hw_ipip_tcp_csum # XFAIL Device does not support rx-gro-hw
# ok 163 gro.test.hw_ipip_tcp_seq # XFAIL Device does not support rx-gro-hw
# ok 164 gro.test.hw_ipip_tcp_ts # XFAIL Device does not support rx-gro-hw
# ok 165 gro.test.hw_ipip_tcp_opt # XFAIL Device does not support rx-gro-hw
# ok 166 gro.test.hw_ipip_ip_ecn # XFAIL Device does not support rx-gro-hw
# ok 167 gro.test.hw_ipip_ip_tos # XFAIL Device does not support rx-gro-hw
# ok 168 gro.test.hw_ipip_large_max # XFAIL Device does not support rx-gro-hw
# ok 169 gro.test.hw_ipip_large_rem # XFAIL Device does not support rx-gro-hw
# ok 170 gro.test.hw_ipip_ip_csum # XFAIL Device does not support rx-gro-hw
# ok 171 gro.test.hw_ipip_ip_ttl # XFAIL Device does not support rx-gro-hw
# ok 172 gro.test.hw_ipip_ip_opt # XFAIL Device does not support rx-gro-hw
# ok 173 gro.test.hw_ipip_ip_frag4 # XFAIL Device does not support rx-gro-hw
# ok 174 gro.test.hw_ipip_ip_id_df1_inc # XFAIL Device does not support rx-gro-hw
# ok 175 gro.test.hw_ipip_ip_id_df1_fixed # XFAIL Device does not support rx-gro-hw
# ok 176 gro.test.hw_ipip_ip_id_df0_inc # XFAIL Device does not support rx-gro-hw
# ok 177 gro.test.hw_ipip_ip_id_df0_fixed # XFAIL Device does not support rx-gro-hw
# ok 178 gro.test.hw_ipip_ip_id_df1_inc_fixed # XFAIL Device does not support rx-gro-hw
# ok 179 gro.test.hw_ipip_ip_id_df1_fixed_inc # XFAIL Device does not support rx-gro-hw
# ok 180 gro.test.hw_ip6ip6_data_same # XFAIL Device does not support rx-gro-hw
# ok 181 gro.test.hw_ip6ip6_data_lrg_sml # XFAIL Device does not support rx-gro-hw
# ok 182 gro.test.hw_ip6ip6_data_sml_lrg # XFAIL Device does not support rx-gro-hw
# ok 183 gro.test.hw_ip6ip6_data_lrg_1byte # XFAIL Device does not support rx-gro-hw
# ok 184 gro.test.hw_ip6ip6_data_burst # XFAIL Device does not support rx-gro-hw
# ok 185 gro.test.hw_ip6ip6_ack # XFAIL Device does not support rx-gro-hw
# ok 186 gro.test.hw_ip6ip6_flags_psh # XFAIL Device does not support rx-gro-hw
# ok 187 gro.test.hw_ip6ip6_flags_syn # XFAIL Device does not support rx-gro-hw
# ok 188 gro.test.hw_ip6ip6_flags_rst # XFAIL Device does not support rx-gro-hw
# ok 189 gro.test.hw_ip6ip6_flags_urg # XFAIL Device does not support rx-gro-hw
# ok 190 gro.test.hw_ip6ip6_flags_cwr # XFAIL Device does not support rx-gro-hw
# ok 191 gro.test.hw_ip6ip6_tcp_csum # XFAIL Device does not support rx-gro-hw
# ok 192 gro.test.hw_ip6ip6_tcp_seq # XFAIL Device does not support rx-gro-hw
# ok 193 gro.test.hw_ip6ip6_tcp_ts # XFAIL Device does not support rx-gro-hw
# ok 194 gro.test.hw_ip6ip6_tcp_opt # XFAIL Device does not support rx-gro-hw
# ok 195 gro.test.hw_ip6ip6_ip_ecn # XFAIL Device does not support rx-gro-hw
# ok 196 gro.test.hw_ip6ip6_ip_tos # XFAIL Device does not support rx-gro-hw
# ok 197 gro.test.hw_ip6ip6_large_max # XFAIL Device does not support rx-gro-hw
# ok 198 gro.test.hw_ip6ip6_large_rem # XFAIL Device does not support rx-gro-hw
# ok 199 gro.test.lro_ipv4_data_same # XFAIL Test does not work on netdevsim
# ok 200 gro.test.lro_ipv4_data_lrg_sml # XFAIL Test does not work on netdevsim
# ok 201 gro.test.lro_ipv4_data_sml_lrg # XFAIL Test does not work on netdevsim
# ok 202 gro.test.lro_ipv4_data_lrg_1byte # XFAIL Test does not work on netdevsim
# ok 203 gro.test.lro_ipv4_data_burst # XFAIL Test does not work on netdevsim
# ok 204 gro.test.lro_ipv4_ack # XFAIL Test does not work on netdevsim
# ok 205 gro.test.lro_ipv4_flags_psh # XFAIL Test does not work on netdevsim
# ok 206 gro.test.lro_ipv4_flags_syn # XFAIL Test does not work on netdevsim
# ok 207 gro.test.lro_ipv4_flags_rst # XFAIL Test does not work on netdevsim
# ok 208 gro.test.lro_ipv4_flags_urg # XFAIL Test does not work on netdevsim
# ok 209 gro.test.lro_ipv4_flags_cwr # XFAIL Test does not work on netdevsim
# ok 210 gro.test.lro_ipv4_tcp_csum # XFAIL Test does not work on netdevsim
# ok 211 gro.test.lro_ipv4_tcp_seq # XFAIL Test does not work on netdevsim
# ok 212 gro.test.lro_ipv4_tcp_ts # XFAIL Test does not work on netdevsim
# ok 213 gro.test.lro_ipv4_tcp_opt # XFAIL Test does not work on netdevsim
# ok 214 gro.test.lro_ipv4_ip_ecn # XFAIL Test does not work on netdevsim
# ok 215 gro.test.lro_ipv4_ip_tos # XFAIL Test does not work on netdevsim
# ok 216 gro.test.lro_ipv4_large_max # XFAIL Test does not work on netdevsim
# ok 217 gro.test.lro_ipv4_large_rem # XFAIL Test does not work on netdevsim
# ok 218 gro.test.lro_ipv4_ip_csum # XFAIL Test does not work on netdevsim
# ok 219 gro.test.lro_ipv4_ip_ttl # XFAIL Test does not work on netdevsim
# ok 220 gro.test.lro_ipv4_ip_opt # XFAIL Test does not work on netdevsim
# ok 221 gro.test.lro_ipv4_ip_frag4 # XFAIL Test does not work on netdevsim
# ok 222 gro.test.lro_ipv4_ip_id_df1_inc # XFAIL Test does not work on netdevsim
# ok 223 gro.test.lro_ipv4_ip_id_df1_fixed # XFAIL Test does not work on netdevsim
# ok 224 gro.test.lro_ipv4_ip_id_df0_inc # XFAIL Test does not work on netdevsim
# ok 225 gro.test.lro_ipv4_ip_id_df0_fixed # XFAIL Test does not work on netdevsim
# ok 226 gro.test.lro_ipv4_ip_id_df1_inc_fixed # XFAIL Test does not work on netdevsim
# ok 227 gro.test.lro_ipv4_ip_id_df1_fixed_inc # XFAIL Test does not work on netdevsim
# ok 228 gro.test.lro_ipv6_data_same # XFAIL Test does not work on netdevsim
# ok 229 gro.test.lro_ipv6_data_lrg_sml # XFAIL Test does not work on netdevsim
# ok 230 gro.test.lro_ipv6_data_sml_lrg # XFAIL Test does not work on netdevsim
# ok 231 gro.test.lro_ipv6_data_lrg_1byte # XFAIL Test does not work on netdevsim
# ok 232 gro.test.lro_ipv6_data_burst # XFAIL Test does not work on netdevsim
# ok 233 gro.test.lro_ipv6_ack # XFAIL Test does not work on netdevsim
# ok 234 gro.test.lro_ipv6_flags_psh # XFAIL Test does not work on netdevsim
# ok 235 gro.test.lro_ipv6_flags_syn # XFAIL Test does not work on netdevsim
# ok 236 gro.test.lro_ipv6_flags_rst # XFAIL Test does not work on netdevsim
# ok 237 gro.test.lro_ipv6_flags_urg # XFAIL Test does not work on netdevsim
# ok 238 gro.test.lro_ipv6_flags_cwr # XFAIL Test does not work on netdevsim
# ok 239 gro.test.lro_ipv6_tcp_csum # XFAIL Test does not work on netdevsim
# ok 240 gro.test.lro_ipv6_tcp_seq # XFAIL Test does not work on netdevsim
# ok 241 gro.test.lro_ipv6_tcp_ts # XFAIL Test does not work on netdevsim
# ok 242 gro.test.lro_ipv6_tcp_opt # XFAIL Test does not work on netdevsim
# ok 243 gro.test.lro_ipv6_ip_ecn # XFAIL Test does not work on netdevsim
# ok 244 gro.test.lro_ipv6_ip_tos # XFAIL Test does not work on netdevsim
# ok 245 gro.test.lro_ipv6_large_max # XFAIL Test does not work on netdevsim
# ok 246 gro.test.lro_ipv6_large_rem # XFAIL Test does not work on netdevsim
# ok 247 gro.test.lro_ipv6_ip_frag6 # XFAIL Test does not work on netdevsim
# ok 248 gro.test.lro_ipv6_ip_v6ext_same # XFAIL Test does not work on netdevsim
# ok 249 gro.test.lro_ipv6_ip_v6ext_diff # XFAIL Test does not work on netdevsim
# ok 250 gro.test.lro_ipip_data_same # XFAIL Test does not work on netdevsim
# ok 251 gro.test.lro_ipip_data_lrg_sml # XFAIL Test does not work on netdevsim
# ok 252 gro.test.lro_ipip_data_sml_lrg # XFAIL Test does not work on netdevsim
# ok 253 gro.test.lro_ipip_data_lrg_1byte # XFAIL Test does not work on netdevsim
# ok 254 gro.test.lro_ipip_data_burst # XFAIL Test does not work on netdevsim
# ok 255 gro.test.lro_ipip_ack # XFAIL Test does not work on netdevsim
# ok 256 gro.test.lro_ipip_flags_psh # XFAIL Test does not work on netdevsim
# ok 257 gro.test.lro_ipip_flags_syn # XFAIL Test does not work on netdevsim
# ok 258 gro.test.lro_ipip_flags_rst # XFAIL Test does not work on netdevsim
# ok 259 gro.test.lro_ipip_flags_urg # XFAIL Test does not work on netdevsim
# ok 260 gro.test.lro_ipip_flags_cwr # XFAIL Test does not work on netdevsim
# ok 261 gro.test.lro_ipip_tcp_csum # XFAIL Test does not work on netdevsim
# ok 262 gro.test.lro_ipip_tcp_seq # XFAIL Test does not work on netdevsim
# ok 263 gro.test.lro_ipip_tcp_ts # XFAIL Test does not work on netdevsim
# ok 264 gro.test.lro_ipip_tcp_opt # XFAIL Test does not work on netdevsim
# ok 265 gro.test.lro_ipip_ip_ecn # XFAIL Test does not work on netdevsim
# ok 266 gro.test.lro_ipip_ip_tos # XFAIL Test does not work on netdevsim
# ok 267 gro.test.lro_ipip_large_max # XFAIL Test does not work on netdevsim
# ok 268 gro.test.lro_ipip_large_rem # XFAIL Test does not work on netdevsim
# ok 269 gro.test.lro_ipip_ip_csum # XFAIL Test does not work on netdevsim
# ok 270 gro.test.lro_ipip_ip_ttl # XFAIL Test does not work on netdevsim
# ok 271 gro.test.lro_ipip_ip_opt # XFAIL Test does not work on netdevsim
# ok 272 gro.test.lro_ipip_ip_frag4 # XFAIL Test does not work on netdevsim
# ok 273 gro.test.lro_ipip_ip_id_df1_inc # XFAIL Test does not work on netdevsim
# ok 274 gro.test.lro_ipip_ip_id_df1_fixed # XFAIL Test does not work on netdevsim
# ok 275 gro.test.lro_ipip_ip_id_df0_inc # XFAIL Test does not work on netdevsim
# ok 276 gro.test.lro_ipip_ip_id_df0_fixed # XFAIL Test does not work on netdevsim
# ok 277 gro.test.lro_ipip_ip_id_df1_inc_fixed # XFAIL Test does not work on netdevsim
# ok 278 gro.test.lro_ipip_ip_id_df1_fixed_inc # XFAIL Test does not work on netdevsim
# ok 279 gro.test.lro_ip6ip6_data_same # XFAIL Test does not work on netdevsim
# ok 280 gro.test.lro_ip6ip6_data_lrg_sml # XFAIL Test does not work on netdevsim
# ok 281 gro.test.lro_ip6ip6_data_sml_lrg # XFAIL Test does not work on netdevsim
# ok 282 gro.test.lro_ip6ip6_data_lrg_1byte # XFAIL Test does not work on netdevsim
# ok 283 gro.test.lro_ip6ip6_data_burst # XFAIL Test does not work on netdevsim
# ok 284 gro.test.lro_ip6ip6_ack # XFAIL Test does not work on netdevsim
# ok 285 gro.test.lro_ip6ip6_flags_psh # XFAIL Test does not work on netdevsim
# ok 286 gro.test.lro_ip6ip6_flags_syn # XFAIL Test does not work on netdevsim
# ok 287 gro.test.lro_ip6ip6_flags_rst # XFAIL Test does not work on netdevsim
# ok 288 gro.test.lro_ip6ip6_flags_urg # XFAIL Test does not work on netdevsim
# ok 289 gro.test.lro_ip6ip6_flags_cwr # XFAIL Test does not work on netdevsim
# ok 290 gro.test.lro_ip6ip6_tcp_csum # XFAIL Test does not work on netdevsim
# ok 291 gro.test.lro_ip6ip6_tcp_seq # XFAIL Test does not work on netdevsim
# ok 292 gro.test.lro_ip6ip6_tcp_ts # XFAIL Test does not work on netdevsim
# ok 293 gro.test.lro_ip6ip6_tcp_opt # XFAIL Test does not work on netdevsim
# ok 294 gro.test.lro_ip6ip6_ip_ecn # XFAIL Test does not work on netdevsim
# ok 295 gro.test.lro_ip6ip6_ip_tos # XFAIL Test does not work on netdevsim
# ok 296 gro.test.lro_ip6ip6_large_max # XFAIL Test does not work on netdevsim
# ok 297 gro.test.lro_ip6ip6_large_rem # XFAIL Test does not work on netdevsim
# # CMD: /usr/src/perf_selftests-x86_64-rhel-9.4-bpf-6160ec9d03d7af5aa345b8b994de80fa8454274b/tools/testing/selftests/net/lib/gro --pppoev4 --dmac 8e:06:42:98:a9:5f --smac c6:e6:7b:ad:54:ed --daddr 192.0.2.1 --saddr 192.0.2.2 --test data_same --verbose --rx --iface eth1
# #   EXIT: 1
# #   STDOUT: pure data packet of same size:
# #   STDERR: Expected {200 }, Total 1 packets
# #           Received {100 [!=200]100 [!=0]}, Total 2 packets.
# #           /usr/src/perf_selftests-x86_64-rhel-9.4-bpf-6160ec9d03d7af5aa345b8b994de80fa8454274b/tools/testing/selftests/net/lib/gro: incorrect number of packets
# # Attempt 1/6 failed, retrying...
# # CMD: /usr/src/perf_selftests-x86_64-rhel-9.4-bpf-6160ec9d03d7af5aa345b8b994de80fa8454274b/tools/testing/selftests/net/lib/gro --pppoev4 --dmac 8e:06:42:98:a9:5f --smac c6:e6:7b:ad:54:ed --daddr 192.0.2.1 --saddr 192.0.2.2 --test data_same --verbose --rx --iface eth1
# #   EXIT: 1
# #   STDOUT: pure data packet of same size:
# #   STDERR: Expected {200 }, Total 1 packets
# #           Received {100 [!=200]100 [!=0]}, Total 2 packets.
# #           /usr/src/perf_selftests-x86_64-rhel-9.4-bpf-6160ec9d03d7af5aa345b8b994de80fa8454274b/tools/testing/selftests/net/lib/gro: incorrect number of packets
# # Attempt 2/6 failed, retrying...
# # CMD: /usr/src/perf_selftests-x86_64-rhel-9.4-bpf-6160ec9d03d7af5aa345b8b994de80fa8454274b/tools/testing/selftests/net/lib/gro --pppoev4 --dmac 8e:06:42:98:a9:5f --smac c6:e6:7b:ad:54:ed --daddr 192.0.2.1 --saddr 192.0.2.2 --test data_same --verbose --rx --iface eth1
# #   EXIT: 1
# #   STDOUT: pure data packet of same size:
# #   STDERR: Expected {200 }, Total 1 packets
# #           Received {100 [!=200]100 [!=0]}, Total 2 packets.
# #           /usr/src/perf_selftests-x86_64-rhel-9.4-bpf-6160ec9d03d7af5aa345b8b994de80fa8454274b/tools/testing/selftests/net/lib/gro: incorrect number of packets
# # Attempt 3/6 failed, retrying...
# # CMD: /usr/src/perf_selftests-x86_64-rhel-9.4-bpf-6160ec9d03d7af5aa345b8b994de80fa8454274b/tools/testing/selftests/net/lib/gro --pppoev4 --dmac 8e:06:42:98:a9:5f --smac c6:e6:7b:ad:54:ed --daddr 192.0.2.1 --saddr 192.0.2.2 --test data_same --verbose --rx --iface eth1
# #   EXIT: 1
# #   STDOUT: pure data packet of same size:
# #   STDERR: Expected {200 }, Total 1 packets
# #           Received {100 [!=200]100 [!=0]}, Total 2 packets.
# #           /usr/src/perf_selftests-x86_64-rhel-9.4-bpf-6160ec9d03d7af5aa345b8b994de80fa8454274b/tools/testing/selftests/net/lib/gro: incorrect number of packets
# # Attempt 4/6 failed, retrying...
# # CMD: /usr/src/perf_selftests-x86_64-rhel-9.4-bpf-6160ec9d03d7af5aa345b8b994de80fa8454274b/tools/testing/selftests/net/lib/gro --pppoev4 --dmac 8e:06:42:98:a9:5f --smac c6:e6:7b:ad:54:ed --daddr 192.0.2.1 --saddr 192.0.2.2 --test data_same --verbose --rx --iface eth1
# #   EXIT: 1
# #   STDOUT: pure data packet of same size:
# #   STDERR: Expected {200 }, Total 1 packets
# #           Received {100 [!=200]100 [!=0]}, Total 2 packets.
# #           /usr/src/perf_selftests-x86_64-rhel-9.4-bpf-6160ec9d03d7af5aa345b8b994de80fa8454274b/tools/testing/selftests/net/lib/gro: incorrect number of packets
# # Attempt 5/6 failed, retrying...
# # Exception| Traceback (most recent call last):
# # Exception|   File "/usr/src/perf_selftests-x86_64-rhel-9.4-bpf-6160ec9d03d7af5aa345b8b994de80fa8454274b/tools/testing/selftests/net/lib/py/ksft.py", line 420, in ksft_run
# # Exception|     func(*args)
# # Exception|     ~~~~^^^^^^^
# # Exception|   File "/usr/src/perf_selftests-x86_64-rhel-9.4-bpf-6160ec9d03d7af5aa345b8b994de80fa8454274b/tools/testing/selftests/drivers/net/./gro.py", line 365, in test
# # Exception|     rx_proc = _run_gro_bin(cfg, test_name, protocol=protocol,
# # Exception|                            verbose=True, fail=fail_now)
# # Exception|   File "/usr/src/perf_selftests-x86_64-rhel-9.4-bpf-6160ec9d03d7af5aa345b8b994de80fa8454274b/tools/testing/selftests/drivers/net/./gro.py", line 220, in _run_gro_bin
# # Exception|     with bkg(rx_cmd, ksft_ready=True, exit_wait=True, fail=fail) as rx_proc:
# # Exception|          ~~~^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^
# # Exception|   File "/usr/src/perf_selftests-x86_64-rhel-9.4-bpf-6160ec9d03d7af5aa345b8b994de80fa8454274b/tools/testing/selftests/net/lib/py/utils.py", line 200, in __exit__
# # Exception|     return self.process(terminate=terminate, fail=self.check_fail,
# # Exception|            ~~~~~~~~~~~~^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^
# # Exception|                         expect_fail=self.expect_fail)
# # Exception|                         ^^^^^^^^^^^^^^^^^^^^^^^^^^^^^
# # Exception|   File "/usr/src/perf_selftests-x86_64-rhel-9.4-bpf-6160ec9d03d7af5aa345b8b994de80fa8454274b/tools/testing/selftests/net/lib/py/utils.py", line 129, in process
# # Exception|     raise CmdExitFailure("Command failed", self)
# # Exception| net.lib.py.utils.CmdExitFailure: Command failed
# # Exception| CMD: /usr/src/perf_selftests-x86_64-rhel-9.4-bpf-6160ec9d03d7af5aa345b8b994de80fa8454274b/tools/testing/selftests/net/lib/gro --pppoev4 --dmac 8e:06:42:98:a9:5f --smac c6:e6:7b:ad:54:ed --daddr 192.0.2.1 --saddr 192.0.2.2 --test data_same --verbose --rx --iface eth1
# # Exception|   EXIT: 1
# # Exception|   STDOUT: pure data packet of same size:
# # Exception|   STDERR: Expected {200 }, Total 1 packets
# # Exception|           Received {100 [!=200]100 [!=0]}, Total 2 packets.
# # Exception|           /usr/src/perf_selftests-x86_64-rhel-9.4-bpf-6160ec9d03d7af5aa345b8b994de80fa8454274b/tools/testing/selftests/net/lib/gro: incorrect number of packets
# # Exception| 
# not ok 298 gro.test.sw_pppoev4_data_same
# # CMD: /usr/src/perf_selftests-x86_64-rhel-9.4-bpf-6160ec9d03d7af5aa345b8b994de80fa8454274b/tools/testing/selftests/net/lib/gro --pppoev4 --dmac 8e:06:42:98:a9:5f --smac c6:e6:7b:ad:54:ed --daddr 192.0.2.1 --saddr 192.0.2.2 --test data_lrg_sml --verbose --rx --iface eth1
# #   EXIT: 1
# #   STDOUT: large data packets followed by a smaller one:
# #   STDERR: Expected {150 }, Total 1 packets
# #           Received {100 [!=150]50 [!=0]}, Total 2 packets.
# #           /usr/src/perf_selftests-x86_64-rhel-9.4-bpf-6160ec9d03d7af5aa345b8b994de80fa8454274b/tools/testing/selftests/net/lib/gro: incorrect number of packets
# # Attempt 1/6 failed, retrying...
# # CMD: /usr/src/perf_selftests-x86_64-rhel-9.4-bpf-6160ec9d03d7af5aa345b8b994de80fa8454274b/tools/testing/selftests/net/lib/gro --pppoev4 --dmac 8e:06:42:98:a9:5f --smac c6:e6:7b:ad:54:ed --daddr 192.0.2.1 --saddr 192.0.2.2 --test data_lrg_sml --verbose --rx --iface eth1
# #   EXIT: 1
# #   STDOUT: large data packets followed by a smaller one:
# #   STDERR: Expected {150 }, Total 1 packets
# #           Received {100 [!=150]50 [!=0]}, Total 2 packets.
# #           /usr/src/perf_selftests-x86_64-rhel-9.4-bpf-6160ec9d03d7af5aa345b8b994de80fa8454274b/tools/testing/selftests/net/lib/gro: incorrect number of packets
# # Attempt 2/6 failed, retrying...
# # CMD: /usr/src/perf_selftests-x86_64-rhel-9.4-bpf-6160ec9d03d7af5aa345b8b994de80fa8454274b/tools/testing/selftests/net/lib/gro --pppoev4 --dmac 8e:06:42:98:a9:5f --smac c6:e6:7b:ad:54:ed --daddr 192.0.2.1 --saddr 192.0.2.2 --test data_lrg_sml --verbose --rx --iface eth1
# #   EXIT: 1
# #   STDOUT: large data packets followed by a smaller one:
# #   STDERR: Expected {150 }, Total 1 packets
# #           Received {100 [!=150]50 [!=0]}, Total 2 packets.
# #           /usr/src/perf_selftests-x86_64-rhel-9.4-bpf-6160ec9d03d7af5aa345b8b994de80fa8454274b/tools/testing/selftests/net/lib/gro: incorrect number of packets
# # Attempt 3/6 failed, retrying...
# # CMD: /usr/src/perf_selftests-x86_64-rhel-9.4-bpf-6160ec9d03d7af5aa345b8b994de80fa8454274b/tools/testing/selftests/net/lib/gro --pppoev4 --dmac 8e:06:42:98:a9:5f --smac c6:e6:7b:ad:54:ed --daddr 192.0.2.1 --saddr 192.0.2.2 --test data_lrg_sml --verbose --rx --iface eth1
# #   EXIT: 1
# #   STDOUT: large data packets followed by a smaller one:
# #   STDERR: Expected {150 }, Total 1 packets
# #           Received {100 [!=150]50 [!=0]}, Total 2 packets.
# #           /usr/src/perf_selftests-x86_64-rhel-9.4-bpf-6160ec9d03d7af5aa345b8b994de80fa8454274b/tools/testing/selftests/net/lib/gro: incorrect number of packets
# # Attempt 4/6 failed, retrying...
# # CMD: /usr/src/perf_selftests-x86_64-rhel-9.4-bpf-6160ec9d03d7af5aa345b8b994de80fa8454274b/tools/testing/selftests/net/lib/gro --pppoev4 --dmac 8e:06:42:98:a9:5f --smac c6:e6:7b:ad:54:ed --daddr 192.0.2.1 --saddr 192.0.2.2 --test data_lrg_sml --verbose --rx --iface eth1
# #   EXIT: 1
# #   STDOUT: large data packets followed by a smaller one:
# #   STDERR: Expected {150 }, Total 1 packets
# #           Received {100 [!=150]50 [!=0]}, Total 2 packets.
# #           /usr/src/perf_selftests-x86_64-rhel-9.4-bpf-6160ec9d03d7af5aa345b8b994de80fa8454274b/tools/testing/selftests/net/lib/gro: incorrect number of packets
# # Attempt 5/6 failed, retrying...
# # Exception| Traceback (most recent call last):
# # Exception|   File "/usr/src/perf_selftests-x86_64-rhel-9.4-bpf-6160ec9d03d7af5aa345b8b994de80fa8454274b/tools/testing/selftests/net/lib/py/ksft.py", line 420, in ksft_run
# # Exception|     func(*args)
# # Exception|     ~~~~^^^^^^^
# # Exception|   File "/usr/src/perf_selftests-x86_64-rhel-9.4-bpf-6160ec9d03d7af5aa345b8b994de80fa8454274b/tools/testing/selftests/drivers/net/./gro.py", line 365, in test
# # Exception|     rx_proc = _run_gro_bin(cfg, test_name, protocol=protocol,
# # Exception|                            verbose=True, fail=fail_now)
# # Exception|   File "/usr/src/perf_selftests-x86_64-rhel-9.4-bpf-6160ec9d03d7af5aa345b8b994de80fa8454274b/tools/testing/selftests/drivers/net/./gro.py", line 220, in _run_gro_bin
# # Exception|     with bkg(rx_cmd, ksft_ready=True, exit_wait=True, fail=fail) as rx_proc:
# # Exception|          ~~~^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^
# # Exception|   File "/usr/src/perf_selftests-x86_64-rhel-9.4-bpf-6160ec9d03d7af5aa345b8b994de80fa8454274b/tools/testing/selftests/net/lib/py/utils.py", line 200, in __exit__
# # Exception|     return self.process(terminate=terminate, fail=self.check_fail,
# # Exception|            ~~~~~~~~~~~~^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^
# # Exception|                         expect_fail=self.expect_fail)
# # Exception|                         ^^^^^^^^^^^^^^^^^^^^^^^^^^^^^
# # Exception|   File "/usr/src/perf_selftests-x86_64-rhel-9.4-bpf-6160ec9d03d7af5aa345b8b994de80fa8454274b/tools/testing/selftests/net/lib/py/utils.py", line 129, in process
# # Exception|     raise CmdExitFailure("Command failed", self)
# # Exception| net.lib.py.utils.CmdExitFailure: Command failed
# # Exception| CMD: /usr/src/perf_selftests-x86_64-rhel-9.4-bpf-6160ec9d03d7af5aa345b8b994de80fa8454274b/tools/testing/selftests/net/lib/gro --pppoev4 --dmac 8e:06:42:98:a9:5f --smac c6:e6:7b:ad:54:ed --daddr 192.0.2.1 --saddr 192.0.2.2 --test data_lrg_sml --verbose --rx --iface eth1
# # Exception|   EXIT: 1
# # Exception|   STDOUT: large data packets followed by a smaller one:
# # Exception|   STDERR: Expected {150 }, Total 1 packets
# # Exception|           Received {100 [!=150]50 [!=0]}, Total 2 packets.
# # Exception|           /usr/src/perf_selftests-x86_64-rhel-9.4-bpf-6160ec9d03d7af5aa345b8b994de80fa8454274b/tools/testing/selftests/net/lib/gro: incorrect number of packets
# # Exception| 
# not ok 299 gro.test.sw_pppoev4_data_lrg_sml
# ok 300 gro.test.sw_pppoev4_data_sml_lrg
# # CMD: /usr/src/perf_selftests-x86_64-rhel-9.4-bpf-6160ec9d03d7af5aa345b8b994de80fa8454274b/tools/testing/selftests/net/lib/gro --pppoev4 --dmac 8e:06:42:98:a9:5f --smac c6:e6:7b:ad:54:ed --daddr 192.0.2.1 --saddr 192.0.2.2 --test data_lrg_1byte --verbose --rx --iface eth1
# #   EXIT: 1
# #   STDOUT: large data packet followed by a 1 byte one:
# #   STDERR: Expected {101 }, Total 1 packets
# #           Received {100 [!=101]1 [!=0]}, Total 2 packets.
# #           /usr/src/perf_selftests-x86_64-rhel-9.4-bpf-6160ec9d03d7af5aa345b8b994de80fa8454274b/tools/testing/selftests/net/lib/gro: incorrect number of packets
# # Attempt 1/6 failed, retrying...
# # CMD: /usr/src/perf_selftests-x86_64-rhel-9.4-bpf-6160ec9d03d7af5aa345b8b994de80fa8454274b/tools/testing/selftests/net/lib/gro --pppoev4 --dmac 8e:06:42:98:a9:5f --smac c6:e6:7b:ad:54:ed --daddr 192.0.2.1 --saddr 192.0.2.2 --test data_lrg_1byte --verbose --rx --iface eth1
# #   EXIT: 1
# #   STDOUT: large data packet followed by a 1 byte one:
# #   STDERR: Expected {101 }, Total 1 packets
# #           Received {100 [!=101]1 [!=0]}, Total 2 packets.
# #           /usr/src/perf_selftests-x86_64-rhel-9.4-bpf-6160ec9d03d7af5aa345b8b994de80fa8454274b/tools/testing/selftests/net/lib/gro: incorrect number of packets
# # Attempt 2/6 failed, retrying...
# # CMD: /usr/src/perf_selftests-x86_64-rhel-9.4-bpf-6160ec9d03d7af5aa345b8b994de80fa8454274b/tools/testing/selftests/net/lib/gro --pppoev4 --dmac 8e:06:42:98:a9:5f --smac c6:e6:7b:ad:54:ed --daddr 192.0.2.1 --saddr 192.0.2.2 --test data_lrg_1byte --verbose --rx --iface eth1
# #   EXIT: 1
# #   STDOUT: large data packet followed by a 1 byte one:
# #   STDERR: Expected {101 }, Total 1 packets
# #           Received {100 [!=101]1 [!=0]}, Total 2 packets.
# #           /usr/src/perf_selftests-x86_64-rhel-9.4-bpf-6160ec9d03d7af5aa345b8b994de80fa8454274b/tools/testing/selftests/net/lib/gro: incorrect number of packets
# # Attempt 3/6 failed, retrying...
# # CMD: /usr/src/perf_selftests-x86_64-rhel-9.4-bpf-6160ec9d03d7af5aa345b8b994de80fa8454274b/tools/testing/selftests/net/lib/gro --pppoev4 --dmac 8e:06:42:98:a9:5f --smac c6:e6:7b:ad:54:ed --daddr 192.0.2.1 --saddr 192.0.2.2 --test data_lrg_1byte --verbose --rx --iface eth1
# #   EXIT: 1
# #   STDOUT: large data packet followed by a 1 byte one:
# #   STDERR: Expected {101 }, Total 1 packets
# #           Received {100 [!=101]1 [!=0]}, Total 2 packets.
# #           /usr/src/perf_selftests-x86_64-rhel-9.4-bpf-6160ec9d03d7af5aa345b8b994de80fa8454274b/tools/testing/selftests/net/lib/gro: incorrect number of packets
# # Attempt 4/6 failed, retrying...
# # CMD: /usr/src/perf_selftests-x86_64-rhel-9.4-bpf-6160ec9d03d7af5aa345b8b994de80fa8454274b/tools/testing/selftests/net/lib/gro --pppoev4 --dmac 8e:06:42:98:a9:5f --smac c6:e6:7b:ad:54:ed --daddr 192.0.2.1 --saddr 192.0.2.2 --test data_lrg_1byte --verbose --rx --iface eth1
# #   EXIT: 1
# #   STDOUT: large data packet followed by a 1 byte one:
# #   STDERR: Expected {101 }, Total 1 packets
# #           Received {100 [!=101]1 [!=0]}, Total 2 packets.
# #           /usr/src/perf_selftests-x86_64-rhel-9.4-bpf-6160ec9d03d7af5aa345b8b994de80fa8454274b/tools/testing/selftests/net/lib/gro: incorrect number of packets
# # Attempt 5/6 failed, retrying...
# # Exception| Traceback (most recent call last):
# # Exception|   File "/usr/src/perf_selftests-x86_64-rhel-9.4-bpf-6160ec9d03d7af5aa345b8b994de80fa8454274b/tools/testing/selftests/net/lib/py/ksft.py", line 420, in ksft_run
# # Exception|     func(*args)
# # Exception|     ~~~~^^^^^^^
# # Exception|   File "/usr/src/perf_selftests-x86_64-rhel-9.4-bpf-6160ec9d03d7af5aa345b8b994de80fa8454274b/tools/testing/selftests/drivers/net/./gro.py", line 365, in test
# # Exception|     rx_proc = _run_gro_bin(cfg, test_name, protocol=protocol,
# # Exception|                            verbose=True, fail=fail_now)
# # Exception|   File "/usr/src/perf_selftests-x86_64-rhel-9.4-bpf-6160ec9d03d7af5aa345b8b994de80fa8454274b/tools/testing/selftests/drivers/net/./gro.py", line 220, in _run_gro_bin
# # Exception|     with bkg(rx_cmd, ksft_ready=True, exit_wait=True, fail=fail) as rx_proc:
# # Exception|          ~~~^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^
# # Exception|   File "/usr/src/perf_selftests-x86_64-rhel-9.4-bpf-6160ec9d03d7af5aa345b8b994de80fa8454274b/tools/testing/selftests/net/lib/py/utils.py", line 200, in __exit__
# # Exception|     return self.process(terminate=terminate, fail=self.check_fail,
# # Exception|            ~~~~~~~~~~~~^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^
# # Exception|                         expect_fail=self.expect_fail)
# # Exception|                         ^^^^^^^^^^^^^^^^^^^^^^^^^^^^^
# # Exception|   File "/usr/src/perf_selftests-x86_64-rhel-9.4-bpf-6160ec9d03d7af5aa345b8b994de80fa8454274b/tools/testing/selftests/net/lib/py/utils.py", line 129, in process
# # Exception|     raise CmdExitFailure("Command failed", self)
# # Exception| net.lib.py.utils.CmdExitFailure: Command failed
# # Exception| CMD: /usr/src/perf_selftests-x86_64-rhel-9.4-bpf-6160ec9d03d7af5aa345b8b994de80fa8454274b/tools/testing/selftests/net/lib/gro --pppoev4 --dmac 8e:06:42:98:a9:5f --smac c6:e6:7b:ad:54:ed --daddr 192.0.2.1 --saddr 192.0.2.2 --test data_lrg_1byte --verbose --rx --iface eth1
# # Exception|   EXIT: 1
# # Exception|   STDOUT: large data packet followed by a 1 byte one:
# # Exception|   STDERR: Expected {101 }, Total 1 packets
# # Exception|           Received {100 [!=101]1 [!=0]}, Total 2 packets.
# # Exception|           /usr/src/perf_selftests-x86_64-rhel-9.4-bpf-6160ec9d03d7af5aa345b8b994de80fa8454274b/tools/testing/selftests/net/lib/gro: incorrect number of packets
# # Exception| 
# not ok 301 gro.test.sw_pppoev4_data_lrg_1byte
# # CMD: /usr/src/perf_selftests-x86_64-rhel-9.4-bpf-6160ec9d03d7af5aa345b8b994de80fa8454274b/tools/testing/selftests/net/lib/gro --pppoev4 --dmac 8e:06:42:98:a9:5f --smac c6:e6:7b:ad:54:ed --daddr 192.0.2.1 --saddr 192.0.2.2 --test data_burst --verbose --rx --iface eth1
# #   EXIT: 1
# #   STDOUT: two bursts of two data packets:
# #   STDERR: Expected {200 200 }, Total 2 packets
# #           Received {100 [!=200]100 [!=200]100 [!=0]100 [!=0]}, Total 4 packets.
# #           /usr/src/perf_selftests-x86_64-rhel-9.4-bpf-6160ec9d03d7af5aa345b8b994de80fa8454274b/tools/testing/selftests/net/lib/gro: incorrect number of packets
# # Attempt 1/6 failed, retrying...
# # CMD: /usr/src/perf_selftests-x86_64-rhel-9.4-bpf-6160ec9d03d7af5aa345b8b994de80fa8454274b/tools/testing/selftests/net/lib/gro --pppoev4 --dmac 8e:06:42:98:a9:5f --smac c6:e6:7b:ad:54:ed --daddr 192.0.2.1 --saddr 192.0.2.2 --test data_burst --verbose --rx --iface eth1
# #   EXIT: 1
# #   STDOUT: two bursts of two data packets:
# #   STDERR: Expected {200 200 }, Total 2 packets
# #           Received {100 [!=200]100 [!=200]100 [!=0]100 [!=0]}, Total 4 packets.
# #           /usr/src/perf_selftests-x86_64-rhel-9.4-bpf-6160ec9d03d7af5aa345b8b994de80fa8454274b/tools/testing/selftests/net/lib/gro: incorrect number of packets
# # Attempt 2/6 failed, retrying...
# # CMD: /usr/src/perf_selftests-x86_64-rhel-9.4-bpf-6160ec9d03d7af5aa345b8b994de80fa8454274b/tools/testing/selftests/net/lib/gro --pppoev4 --dmac 8e:06:42:98:a9:5f --smac c6:e6:7b:ad:54:ed --daddr 192.0.2.1 --saddr 192.0.2.2 --test data_burst --verbose --rx --iface eth1
# #   EXIT: 1
# #   STDOUT: two bursts of two data packets:
# #   STDERR: Expected {200 200 }, Total 2 packets
# #           Received {100 [!=200]100 [!=200]100 [!=0]100 [!=0]}, Total 4 packets.
# #           /usr/src/perf_selftests-x86_64-rhel-9.4-bpf-6160ec9d03d7af5aa345b8b994de80fa8454274b/tools/testing/selftests/net/lib/gro: incorrect number of packets
# # Attempt 3/6 failed, retrying...
# # CMD: /usr/src/perf_selftests-x86_64-rhel-9.4-bpf-6160ec9d03d7af5aa345b8b994de80fa8454274b/tools/testing/selftests/net/lib/gro --pppoev4 --dmac 8e:06:42:98:a9:5f --smac c6:e6:7b:ad:54:ed --daddr 192.0.2.1 --saddr 192.0.2.2 --test data_burst --verbose --rx --iface eth1
# #   EXIT: 1
# #   STDOUT: two bursts of two data packets:
# #   STDERR: Expected {200 200 }, Total 2 packets
# #           Received {100 [!=200]100 [!=200]100 [!=0]100 [!=0]}, Total 4 packets.
# #           /usr/src/perf_selftests-x86_64-rhel-9.4-bpf-6160ec9d03d7af5aa345b8b994de80fa8454274b/tools/testing/selftests/net/lib/gro: incorrect number of packets
# # Attempt 4/6 failed, retrying...
# # CMD: /usr/src/perf_selftests-x86_64-rhel-9.4-bpf-6160ec9d03d7af5aa345b8b994de80fa8454274b/tools/testing/selftests/net/lib/gro --pppoev4 --dmac 8e:06:42:98:a9:5f --smac c6:e6:7b:ad:54:ed --daddr 192.0.2.1 --saddr 192.0.2.2 --test data_burst --verbose --rx --iface eth1
# #   EXIT: 1
# #   STDOUT: two bursts of two data packets:
# #   STDERR: Expected {200 200 }, Total 2 packets
# #           Received {100 [!=200]100 [!=200]100 [!=0]100 [!=0]}, Total 4 packets.
# #           /usr/src/perf_selftests-x86_64-rhel-9.4-bpf-6160ec9d03d7af5aa345b8b994de80fa8454274b/tools/testing/selftests/net/lib/gro: incorrect number of packets
# # Attempt 5/6 failed, retrying...
# # Exception| Traceback (most recent call last):
# # Exception|   File "/usr/src/perf_selftests-x86_64-rhel-9.4-bpf-6160ec9d03d7af5aa345b8b994de80fa8454274b/tools/testing/selftests/net/lib/py/ksft.py", line 420, in ksft_run
# # Exception|     func(*args)
# # Exception|     ~~~~^^^^^^^
# # Exception|   File "/usr/src/perf_selftests-x86_64-rhel-9.4-bpf-6160ec9d03d7af5aa345b8b994de80fa8454274b/tools/testing/selftests/drivers/net/./gro.py", line 365, in test
# # Exception|     rx_proc = _run_gro_bin(cfg, test_name, protocol=protocol,
# # Exception|                            verbose=True, fail=fail_now)
# # Exception|   File "/usr/src/perf_selftests-x86_64-rhel-9.4-bpf-6160ec9d03d7af5aa345b8b994de80fa8454274b/tools/testing/selftests/drivers/net/./gro.py", line 220, in _run_gro_bin
# # Exception|     with bkg(rx_cmd, ksft_ready=True, exit_wait=True, fail=fail) as rx_proc:
# # Exception|          ~~~^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^
# # Exception|   File "/usr/src/perf_selftests-x86_64-rhel-9.4-bpf-6160ec9d03d7af5aa345b8b994de80fa8454274b/tools/testing/selftests/net/lib/py/utils.py", line 200, in __exit__
# # Exception|     return self.process(terminate=terminate, fail=self.check_fail,
# # Exception|            ~~~~~~~~~~~~^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^
# # Exception|                         expect_fail=self.expect_fail)
# # Exception|                         ^^^^^^^^^^^^^^^^^^^^^^^^^^^^^
# # Exception|   File "/usr/src/perf_selftests-x86_64-rhel-9.4-bpf-6160ec9d03d7af5aa345b8b994de80fa8454274b/tools/testing/selftests/net/lib/py/utils.py", line 129, in process
# # Exception|     raise CmdExitFailure("Command failed", self)
# # Exception| net.lib.py.utils.CmdExitFailure: Command failed
# # Exception| CMD: /usr/src/perf_selftests-x86_64-rhel-9.4-bpf-6160ec9d03d7af5aa345b8b994de80fa8454274b/tools/testing/selftests/net/lib/gro --pppoev4 --dmac 8e:06:42:98:a9:5f --smac c6:e6:7b:ad:54:ed --daddr 192.0.2.1 --saddr 192.0.2.2 --test data_burst --verbose --rx --iface eth1
# # Exception|   EXIT: 1
# # Exception|   STDOUT: two bursts of two data packets:
# # Exception|   STDERR: Expected {200 200 }, Total 2 packets
# # Exception|           Received {100 [!=200]100 [!=200]100 [!=0]100 [!=0]}, Total 4 packets.
# # Exception|           /usr/src/perf_selftests-x86_64-rhel-9.4-bpf-6160ec9d03d7af5aa345b8b994de80fa8454274b/tools/testing/selftests/net/lib/gro: incorrect number of packets
# # Exception| 
# not ok 302 gro.test.sw_pppoev4_data_burst
# ok 303 gro.test.sw_pppoev4_pppoe_sid
# # CMD: /usr/src/perf_selftests-x86_64-rhel-9.4-bpf-6160ec9d03d7af5aa345b8b994de80fa8454274b/tools/testing/selftests/net/lib/gro --pppoev6 --dmac 8e:06:42:98:a9:5f --smac c6:e6:7b:ad:54:ed --daddr 2001:db8::1 --saddr 2001:db8::2 --test data_same --verbose --rx --iface eth1
# #   EXIT: 1
# #   STDOUT: pure data packet of same size:
# #   STDERR: Expected {200 }, Total 1 packets
# #           Received {100 [!=200]100 [!=0]}, Total 2 packets.
# #           /usr/src/perf_selftests-x86_64-rhel-9.4-bpf-6160ec9d03d7af5aa345b8b994de80fa8454274b/tools/testing/selftests/net/lib/gro: incorrect number of packets
# # Attempt 1/6 failed, retrying...
# # CMD: /usr/src/perf_selftests-x86_64-rhel-9.4-bpf-6160ec9d03d7af5aa345b8b994de80fa8454274b/tools/testing/selftests/net/lib/gro --pppoev6 --dmac 8e:06:42:98:a9:5f --smac c6:e6:7b:ad:54:ed --daddr 2001:db8::1 --saddr 2001:db8::2 --test data_same --verbose --rx --iface eth1
# #   EXIT: 1
# #   STDOUT: pure data packet of same size:
# #   STDERR: Expected {200 }, Total 1 packets
# #           Received {100 [!=200]100 [!=0]}, Total 2 packets.
# #           /usr/src/perf_selftests-x86_64-rhel-9.4-bpf-6160ec9d03d7af5aa345b8b994de80fa8454274b/tools/testing/selftests/net/lib/gro: incorrect number of packets
# # Attempt 2/6 failed, retrying...
# # CMD: /usr/src/perf_selftests-x86_64-rhel-9.4-bpf-6160ec9d03d7af5aa345b8b994de80fa8454274b/tools/testing/selftests/net/lib/gro --pppoev6 --dmac 8e:06:42:98:a9:5f --smac c6:e6:7b:ad:54:ed --daddr 2001:db8::1 --saddr 2001:db8::2 --test data_same --verbose --rx --iface eth1
# #   EXIT: 1
# #   STDOUT: pure data packet of same size:
# #   STDERR: Expected {200 }, Total 1 packets
# #           Received {100 [!=200]100 [!=0]}, Total 2 packets.
# #           /usr/src/perf_selftests-x86_64-rhel-9.4-bpf-6160ec9d03d7af5aa345b8b994de80fa8454274b/tools/testing/selftests/net/lib/gro: incorrect number of packets
# # Attempt 3/6 failed, retrying...
# # CMD: /usr/src/perf_selftests-x86_64-rhel-9.4-bpf-6160ec9d03d7af5aa345b8b994de80fa8454274b/tools/testing/selftests/net/lib/gro --pppoev6 --dmac 8e:06:42:98:a9:5f --smac c6:e6:7b:ad:54:ed --daddr 2001:db8::1 --saddr 2001:db8::2 --test data_same --verbose --rx --iface eth1
# #   EXIT: 1
# #   STDOUT: pure data packet of same size:
# #   STDERR: Expected {200 }, Total 1 packets
# #           Received {100 [!=200]100 [!=0]}, Total 2 packets.
# #           /usr/src/perf_selftests-x86_64-rhel-9.4-bpf-6160ec9d03d7af5aa345b8b994de80fa8454274b/tools/testing/selftests/net/lib/gro: incorrect number of packets
# # Attempt 4/6 failed, retrying...
# # CMD: /usr/src/perf_selftests-x86_64-rhel-9.4-bpf-6160ec9d03d7af5aa345b8b994de80fa8454274b/tools/testing/selftests/net/lib/gro --pppoev6 --dmac 8e:06:42:98:a9:5f --smac c6:e6:7b:ad:54:ed --daddr 2001:db8::1 --saddr 2001:db8::2 --test data_same --verbose --rx --iface eth1
# #   EXIT: 1
# #   STDOUT: pure data packet of same size:
# #   STDERR: Expected {200 }, Total 1 packets
# #           Received {100 [!=200]100 [!=0]}, Total 2 packets.
# #           /usr/src/perf_selftests-x86_64-rhel-9.4-bpf-6160ec9d03d7af5aa345b8b994de80fa8454274b/tools/testing/selftests/net/lib/gro: incorrect number of packets
# # Attempt 5/6 failed, retrying...
# # Exception| Traceback (most recent call last):
# # Exception|   File "/usr/src/perf_selftests-x86_64-rhel-9.4-bpf-6160ec9d03d7af5aa345b8b994de80fa8454274b/tools/testing/selftests/net/lib/py/ksft.py", line 420, in ksft_run
# # Exception|     func(*args)
# # Exception|     ~~~~^^^^^^^
# # Exception|   File "/usr/src/perf_selftests-x86_64-rhel-9.4-bpf-6160ec9d03d7af5aa345b8b994de80fa8454274b/tools/testing/selftests/drivers/net/./gro.py", line 365, in test
# # Exception|     rx_proc = _run_gro_bin(cfg, test_name, protocol=protocol,
# # Exception|                            verbose=True, fail=fail_now)
# # Exception|   File "/usr/src/perf_selftests-x86_64-rhel-9.4-bpf-6160ec9d03d7af5aa345b8b994de80fa8454274b/tools/testing/selftests/drivers/net/./gro.py", line 220, in _run_gro_bin
# # Exception|     with bkg(rx_cmd, ksft_ready=True, exit_wait=True, fail=fail) as rx_proc:
# # Exception|          ~~~^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^
# # Exception|   File "/usr/src/perf_selftests-x86_64-rhel-9.4-bpf-6160ec9d03d7af5aa345b8b994de80fa8454274b/tools/testing/selftests/net/lib/py/utils.py", line 200, in __exit__
# # Exception|     return self.process(terminate=terminate, fail=self.check_fail,
# # Exception|            ~~~~~~~~~~~~^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^
# # Exception|                         expect_fail=self.expect_fail)
# # Exception|                         ^^^^^^^^^^^^^^^^^^^^^^^^^^^^^
# # Exception|   File "/usr/src/perf_selftests-x86_64-rhel-9.4-bpf-6160ec9d03d7af5aa345b8b994de80fa8454274b/tools/testing/selftests/net/lib/py/utils.py", line 129, in process
# # Exception|     raise CmdExitFailure("Command failed", self)
# # Exception| net.lib.py.utils.CmdExitFailure: Command failed
# # Exception| CMD: /usr/src/perf_selftests-x86_64-rhel-9.4-bpf-6160ec9d03d7af5aa345b8b994de80fa8454274b/tools/testing/selftests/net/lib/gro --pppoev6 --dmac 8e:06:42:98:a9:5f --smac c6:e6:7b:ad:54:ed --daddr 2001:db8::1 --saddr 2001:db8::2 --test data_same --verbose --rx --iface eth1
# # Exception|   EXIT: 1
# # Exception|   STDOUT: pure data packet of same size:
# # Exception|   STDERR: Expected {200 }, Total 1 packets
# # Exception|           Received {100 [!=200]100 [!=0]}, Total 2 packets.
# # Exception|           /usr/src/perf_selftests-x86_64-rhel-9.4-bpf-6160ec9d03d7af5aa345b8b994de80fa8454274b/tools/testing/selftests/net/lib/gro: incorrect number of packets
# # Exception| 
# not ok 304 gro.test.sw_pppoev6_data_same
# # CMD: /usr/src/perf_selftests-x86_64-rhel-9.4-bpf-6160ec9d03d7af5aa345b8b994de80fa8454274b/tools/testing/selftests/net/lib/gro --pppoev6 --dmac 8e:06:42:98:a9:5f --smac c6:e6:7b:ad:54:ed --daddr 2001:db8::1 --saddr 2001:db8::2 --test data_lrg_sml --verbose --rx --iface eth1
# #   EXIT: 1
# #   STDOUT: large data packets followed by a smaller one:
# #   STDERR: Expected {150 }, Total 1 packets
# #           Received {100 [!=150]50 [!=0]}, Total 2 packets.
# #           /usr/src/perf_selftests-x86_64-rhel-9.4-bpf-6160ec9d03d7af5aa345b8b994de80fa8454274b/tools/testing/selftests/net/lib/gro: incorrect number of packets
# # Attempt 1/6 failed, retrying...
# # CMD: /usr/src/perf_selftests-x86_64-rhel-9.4-bpf-6160ec9d03d7af5aa345b8b994de80fa8454274b/tools/testing/selftests/net/lib/gro --pppoev6 --dmac 8e:06:42:98:a9:5f --smac c6:e6:7b:ad:54:ed --daddr 2001:db8::1 --saddr 2001:db8::2 --test data_lrg_sml --verbose --rx --iface eth1
# #   EXIT: 1
# #   STDOUT: large data packets followed by a smaller one:
# #   STDERR: Expected {150 }, Total 1 packets
# #           Received {100 [!=150]50 [!=0]}, Total 2 packets.
# #           /usr/src/perf_selftests-x86_64-rhel-9.4-bpf-6160ec9d03d7af5aa345b8b994de80fa8454274b/tools/testing/selftests/net/lib/gro: incorrect number of packets
# # Attempt 2/6 failed, retrying...
# # CMD: /usr/src/perf_selftests-x86_64-rhel-9.4-bpf-6160ec9d03d7af5aa345b8b994de80fa8454274b/tools/testing/selftests/net/lib/gro --pppoev6 --dmac 8e:06:42:98:a9:5f --smac c6:e6:7b:ad:54:ed --daddr 2001:db8::1 --saddr 2001:db8::2 --test data_lrg_sml --verbose --rx --iface eth1
# #   EXIT: 1
# #   STDOUT: large data packets followed by a smaller one:
# #   STDERR: Expected {150 }, Total 1 packets
# #           Received {100 [!=150]50 [!=0]}, Total 2 packets.
# #           /usr/src/perf_selftests-x86_64-rhel-9.4-bpf-6160ec9d03d7af5aa345b8b994de80fa8454274b/tools/testing/selftests/net/lib/gro: incorrect number of packets
# # Attempt 3/6 failed, retrying...
# # CMD: /usr/src/perf_selftests-x86_64-rhel-9.4-bpf-6160ec9d03d7af5aa345b8b994de80fa8454274b/tools/testing/selftests/net/lib/gro --pppoev6 --dmac 8e:06:42:98:a9:5f --smac c6:e6:7b:ad:54:ed --daddr 2001:db8::1 --saddr 2001:db8::2 --test data_lrg_sml --verbose --rx --iface eth1
# #   EXIT: 1
# #   STDOUT: large data packets followed by a smaller one:
# #   STDERR: Expected {150 }, Total 1 packets
# #           Received {100 [!=150]50 [!=0]}, Total 2 packets.
# #           /usr/src/perf_selftests-x86_64-rhel-9.4-bpf-6160ec9d03d7af5aa345b8b994de80fa8454274b/tools/testing/selftests/net/lib/gro: incorrect number of packets
# # Attempt 4/6 failed, retrying...
# # CMD: /usr/src/perf_selftests-x86_64-rhel-9.4-bpf-6160ec9d03d7af5aa345b8b994de80fa8454274b/tools/testing/selftests/net/lib/gro --pppoev6 --dmac 8e:06:42:98:a9:5f --smac c6:e6:7b:ad:54:ed --daddr 2001:db8::1 --saddr 2001:db8::2 --test data_lrg_sml --verbose --rx --iface eth1
# #   EXIT: 1
# #   STDOUT: large data packets followed by a smaller one:
# #   STDERR: Expected {150 }, Total 1 packets
# #           Received {100 [!=150]50 [!=0]}, Total 2 packets.
# #           /usr/src/perf_selftests-x86_64-rhel-9.4-bpf-6160ec9d03d7af5aa345b8b994de80fa8454274b/tools/testing/selftests/net/lib/gro: incorrect number of packets
# # Attempt 5/6 failed, retrying...
# # Exception| Traceback (most recent call last):
# # Exception|   File "/usr/src/perf_selftests-x86_64-rhel-9.4-bpf-6160ec9d03d7af5aa345b8b994de80fa8454274b/tools/testing/selftests/net/lib/py/ksft.py", line 420, in ksft_run
# # Exception|     func(*args)
# # Exception|     ~~~~^^^^^^^
# # Exception|   File "/usr/src/perf_selftests-x86_64-rhel-9.4-bpf-6160ec9d03d7af5aa345b8b994de80fa8454274b/tools/testing/selftests/drivers/net/./gro.py", line 365, in test
# # Exception|     rx_proc = _run_gro_bin(cfg, test_name, protocol=protocol,
# # Exception|                            verbose=True, fail=fail_now)
# # Exception|   File "/usr/src/perf_selftests-x86_64-rhel-9.4-bpf-6160ec9d03d7af5aa345b8b994de80fa8454274b/tools/testing/selftests/drivers/net/./gro.py", line 220, in _run_gro_bin
# # Exception|     with bkg(rx_cmd, ksft_ready=True, exit_wait=True, fail=fail) as rx_proc:
# # Exception|          ~~~^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^
# # Exception|   File "/usr/src/perf_selftests-x86_64-rhel-9.4-bpf-6160ec9d03d7af5aa345b8b994de80fa8454274b/tools/testing/selftests/net/lib/py/utils.py", line 200, in __exit__
# # Exception|     return self.process(terminate=terminate, fail=self.check_fail,
# # Exception|            ~~~~~~~~~~~~^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^
# # Exception|                         expect_fail=self.expect_fail)
# # Exception|                         ^^^^^^^^^^^^^^^^^^^^^^^^^^^^^
# # Exception|   File "/usr/src/perf_selftests-x86_64-rhel-9.4-bpf-6160ec9d03d7af5aa345b8b994de80fa8454274b/tools/testing/selftests/net/lib/py/utils.py", line 129, in process
# # Exception|     raise CmdExitFailure("Command failed", self)
# # Exception| net.lib.py.utils.CmdExitFailure: Command failed
# # Exception| CMD: /usr/src/perf_selftests-x86_64-rhel-9.4-bpf-6160ec9d03d7af5aa345b8b994de80fa8454274b/tools/testing/selftests/net/lib/gro --pppoev6 --dmac 8e:06:42:98:a9:5f --smac c6:e6:7b:ad:54:ed --daddr 2001:db8::1 --saddr 2001:db8::2 --test data_lrg_sml --verbose --rx --iface eth1
# # Exception|   EXIT: 1
# # Exception|   STDOUT: large data packets followed by a smaller one:
# # Exception|   STDERR: Expected {150 }, Total 1 packets
# # Exception|           Received {100 [!=150]50 [!=0]}, Total 2 packets.
# # Exception|           /usr/src/perf_selftests-x86_64-rhel-9.4-bpf-6160ec9d03d7af5aa345b8b994de80fa8454274b/tools/testing/selftests/net/lib/gro: incorrect number of packets
# # Exception| 
# not ok 305 gro.test.sw_pppoev6_data_lrg_sml
# ok 306 gro.test.sw_pppoev6_data_sml_lrg
# # CMD: /usr/src/perf_selftests-x86_64-rhel-9.4-bpf-6160ec9d03d7af5aa345b8b994de80fa8454274b/tools/testing/selftests/net/lib/gro --pppoev6 --dmac 8e:06:42:98:a9:5f --smac c6:e6:7b:ad:54:ed --daddr 2001:db8::1 --saddr 2001:db8::2 --test data_lrg_1byte --verbose --rx --iface eth1
# #   EXIT: 1
# #   STDOUT: large data packet followed by a 1 byte one:
# #   STDERR: Expected {101 }, Total 1 packets
# #           Received {100 [!=101]1 [!=0]}, Total 2 packets.
# #           /usr/src/perf_selftests-x86_64-rhel-9.4-bpf-6160ec9d03d7af5aa345b8b994de80fa8454274b/tools/testing/selftests/net/lib/gro: incorrect number of packets
# # Attempt 1/6 failed, retrying...
# # CMD: /usr/src/perf_selftests-x86_64-rhel-9.4-bpf-6160ec9d03d7af5aa345b8b994de80fa8454274b/tools/testing/selftests/net/lib/gro --pppoev6 --dmac 8e:06:42:98:a9:5f --smac c6:e6:7b:ad:54:ed --daddr 2001:db8::1 --saddr 2001:db8::2 --test data_lrg_1byte --verbose --rx --iface eth1
# #   EXIT: 1
# #   STDOUT: large data packet followed by a 1 byte one:
# #   STDERR: Expected {101 }, Total 1 packets
# #           Received {100 [!=101]1 [!=0]}, Total 2 packets.
# #           /usr/src/perf_selftests-x86_64-rhel-9.4-bpf-6160ec9d03d7af5aa345b8b994de80fa8454274b/tools/testing/selftests/net/lib/gro: incorrect number of packets
# # Attempt 2/6 failed, retrying...
# # CMD: /usr/src/perf_selftests-x86_64-rhel-9.4-bpf-6160ec9d03d7af5aa345b8b994de80fa8454274b/tools/testing/selftests/net/lib/gro --pppoev6 --dmac 8e:06:42:98:a9:5f --smac c6:e6:7b:ad:54:ed --daddr 2001:db8::1 --saddr 2001:db8::2 --test data_lrg_1byte --verbose --rx --iface eth1
# #   EXIT: 1
# #   STDOUT: large data packet followed by a 1 byte one:
# #   STDERR: Expected {101 }, Total 1 packets
# #           Received {100 [!=101]1 [!=0]}, Total 2 packets.
# #           /usr/src/perf_selftests-x86_64-rhel-9.4-bpf-6160ec9d03d7af5aa345b8b994de80fa8454274b/tools/testing/selftests/net/lib/gro: incorrect number of packets
# # Attempt 3/6 failed, retrying...
# # CMD: /usr/src/perf_selftests-x86_64-rhel-9.4-bpf-6160ec9d03d7af5aa345b8b994de80fa8454274b/tools/testing/selftests/net/lib/gro --pppoev6 --dmac 8e:06:42:98:a9:5f --smac c6:e6:7b:ad:54:ed --daddr 2001:db8::1 --saddr 2001:db8::2 --test data_lrg_1byte --verbose --rx --iface eth1
# #   EXIT: 1
# #   STDOUT: large data packet followed by a 1 byte one:
# #   STDERR: Expected {101 }, Total 1 packets
# #           Received {100 [!=101]1 [!=0]}, Total 2 packets.
# #           /usr/src/perf_selftests-x86_64-rhel-9.4-bpf-6160ec9d03d7af5aa345b8b994de80fa8454274b/tools/testing/selftests/net/lib/gro: incorrect number of packets
# # Attempt 4/6 failed, retrying...
# # CMD: /usr/src/perf_selftests-x86_64-rhel-9.4-bpf-6160ec9d03d7af5aa345b8b994de80fa8454274b/tools/testing/selftests/net/lib/gro --pppoev6 --dmac 8e:06:42:98:a9:5f --smac c6:e6:7b:ad:54:ed --daddr 2001:db8::1 --saddr 2001:db8::2 --test data_lrg_1byte --verbose --rx --iface eth1
# #   EXIT: 1
# #   STDOUT: large data packet followed by a 1 byte one:
# #   STDERR: Expected {101 }, Total 1 packets
# #           Received {100 [!=101]1 [!=0]}, Total 2 packets.
# #           /usr/src/perf_selftests-x86_64-rhel-9.4-bpf-6160ec9d03d7af5aa345b8b994de80fa8454274b/tools/testing/selftests/net/lib/gro: incorrect number of packets
# # Attempt 5/6 failed, retrying...
# # Exception| Traceback (most recent call last):
# # Exception|   File "/usr/src/perf_selftests-x86_64-rhel-9.4-bpf-6160ec9d03d7af5aa345b8b994de80fa8454274b/tools/testing/selftests/net/lib/py/ksft.py", line 420, in ksft_run
# # Exception|     func(*args)
# # Exception|     ~~~~^^^^^^^
# # Exception|   File "/usr/src/perf_selftests-x86_64-rhel-9.4-bpf-6160ec9d03d7af5aa345b8b994de80fa8454274b/tools/testing/selftests/drivers/net/./gro.py", line 365, in test
# # Exception|     rx_proc = _run_gro_bin(cfg, test_name, protocol=protocol,
# # Exception|                            verbose=True, fail=fail_now)
# # Exception|   File "/usr/src/perf_selftests-x86_64-rhel-9.4-bpf-6160ec9d03d7af5aa345b8b994de80fa8454274b/tools/testing/selftests/drivers/net/./gro.py", line 220, in _run_gro_bin
# # Exception|     with bkg(rx_cmd, ksft_ready=True, exit_wait=True, fail=fail) as rx_proc:
# # Exception|          ~~~^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^
# # Exception|   File "/usr/src/perf_selftests-x86_64-rhel-9.4-bpf-6160ec9d03d7af5aa345b8b994de80fa8454274b/tools/testing/selftests/net/lib/py/utils.py", line 200, in __exit__
# # Exception|     return self.process(terminate=terminate, fail=self.check_fail,
# # Exception|            ~~~~~~~~~~~~^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^
# # Exception|                         expect_fail=self.expect_fail)
# # Exception|                         ^^^^^^^^^^^^^^^^^^^^^^^^^^^^^
# # Exception|   File "/usr/src/perf_selftests-x86_64-rhel-9.4-bpf-6160ec9d03d7af5aa345b8b994de80fa8454274b/tools/testing/selftests/net/lib/py/utils.py", line 129, in process
# # Exception|     raise CmdExitFailure("Command failed", self)
# # Exception| net.lib.py.utils.CmdExitFailure: Command failed
# # Exception| CMD: /usr/src/perf_selftests-x86_64-rhel-9.4-bpf-6160ec9d03d7af5aa345b8b994de80fa8454274b/tools/testing/selftests/net/lib/gro --pppoev6 --dmac 8e:06:42:98:a9:5f --smac c6:e6:7b:ad:54:ed --daddr 2001:db8::1 --saddr 2001:db8::2 --test data_lrg_1byte --verbose --rx --iface eth1
# # Exception|   EXIT: 1
# # Exception|   STDOUT: large data packet followed by a 1 byte one:
# # Exception|   STDERR: Expected {101 }, Total 1 packets
# # Exception|           Received {100 [!=101]1 [!=0]}, Total 2 packets.
# # Exception|           /usr/src/perf_selftests-x86_64-rhel-9.4-bpf-6160ec9d03d7af5aa345b8b994de80fa8454274b/tools/testing/selftests/net/lib/gro: incorrect number of packets
# # Exception| 
# not ok 307 gro.test.sw_pppoev6_data_lrg_1byte
# # CMD: /usr/src/perf_selftests-x86_64-rhel-9.4-bpf-6160ec9d03d7af5aa345b8b994de80fa8454274b/tools/testing/selftests/net/lib/gro --pppoev6 --dmac 8e:06:42:98:a9:5f --smac c6:e6:7b:ad:54:ed --daddr 2001:db8::1 --saddr 2001:db8::2 --test data_burst --verbose --rx --iface eth1
# #   EXIT: 1
# #   STDOUT: two bursts of two data packets:
# #   STDERR: Expected {200 200 }, Total 2 packets
# #           Received {100 [!=200]100 [!=200]100 [!=0]100 [!=0]}, Total 4 packets.
# #           /usr/src/perf_selftests-x86_64-rhel-9.4-bpf-6160ec9d03d7af5aa345b8b994de80fa8454274b/tools/testing/selftests/net/lib/gro: incorrect number of packets
# # Attempt 1/6 failed, retrying...
# # CMD: /usr/src/perf_selftests-x86_64-rhel-9.4-bpf-6160ec9d03d7af5aa345b8b994de80fa8454274b/tools/testing/selftests/net/lib/gro --pppoev6 --dmac 8e:06:42:98:a9:5f --smac c6:e6:7b:ad:54:ed --daddr 2001:db8::1 --saddr 2001:db8::2 --test data_burst --verbose --rx --iface eth1
# #   EXIT: 1
# #   STDOUT: two bursts of two data packets:
# #   STDERR: Expected {200 200 }, Total 2 packets
# #           Received {100 [!=200]100 [!=200]100 [!=0]100 [!=0]}, Total 4 packets.
# #           /usr/src/perf_selftests-x86_64-rhel-9.4-bpf-6160ec9d03d7af5aa345b8b994de80fa8454274b/tools/testing/selftests/net/lib/gro: incorrect number of packets
# # Attempt 2/6 failed, retrying...
# # CMD: /usr/src/perf_selftests-x86_64-rhel-9.4-bpf-6160ec9d03d7af5aa345b8b994de80fa8454274b/tools/testing/selftests/net/lib/gro --pppoev6 --dmac 8e:06:42:98:a9:5f --smac c6:e6:7b:ad:54:ed --daddr 2001:db8::1 --saddr 2001:db8::2 --test data_burst --verbose --rx --iface eth1
# #   EXIT: 1
# #   STDOUT: two bursts of two data packets:
# #   STDERR: Expected {200 200 }, Total 2 packets
# #           Received {100 [!=200]100 [!=200]100 [!=0]100 [!=0]}, Total 4 packets.
# #           /usr/src/perf_selftests-x86_64-rhel-9.4-bpf-6160ec9d03d7af5aa345b8b994de80fa8454274b/tools/testing/selftests/net/lib/gro: incorrect number of packets
# # Attempt 3/6 failed, retrying...
# # CMD: /usr/src/perf_selftests-x86_64-rhel-9.4-bpf-6160ec9d03d7af5aa345b8b994de80fa8454274b/tools/testing/selftests/net/lib/gro --pppoev6 --dmac 8e:06:42:98:a9:5f --smac c6:e6:7b:ad:54:ed --daddr 2001:db8::1 --saddr 2001:db8::2 --test data_burst --verbose --rx --iface eth1
# #   EXIT: 1
# #   STDOUT: two bursts of two data packets:
# #   STDERR: Expected {200 200 }, Total 2 packets
# #           Received {100 [!=200]100 [!=200]100 [!=0]100 [!=0]}, Total 4 packets.
# #           /usr/src/perf_selftests-x86_64-rhel-9.4-bpf-6160ec9d03d7af5aa345b8b994de80fa8454274b/tools/testing/selftests/net/lib/gro: incorrect number of packets
# # Attempt 4/6 failed, retrying...
# # CMD: /usr/src/perf_selftests-x86_64-rhel-9.4-bpf-6160ec9d03d7af5aa345b8b994de80fa8454274b/tools/testing/selftests/net/lib/gro --pppoev6 --dmac 8e:06:42:98:a9:5f --smac c6:e6:7b:ad:54:ed --daddr 2001:db8::1 --saddr 2001:db8::2 --test data_burst --verbose --rx --iface eth1
# #   EXIT: 1
# #   STDOUT: two bursts of two data packets:
# #   STDERR: Expected {200 200 }, Total 2 packets
# #           Received {100 [!=200]100 [!=200]100 [!=0]100 [!=0]}, Total 4 packets.
# #           /usr/src/perf_selftests-x86_64-rhel-9.4-bpf-6160ec9d03d7af5aa345b8b994de80fa8454274b/tools/testing/selftests/net/lib/gro: incorrect number of packets
# # Attempt 5/6 failed, retrying...
# # Exception| Traceback (most recent call last):
# # Exception|   File "/usr/src/perf_selftests-x86_64-rhel-9.4-bpf-6160ec9d03d7af5aa345b8b994de80fa8454274b/tools/testing/selftests/net/lib/py/ksft.py", line 420, in ksft_run
# # Exception|     func(*args)
# # Exception|     ~~~~^^^^^^^
# # Exception|   File "/usr/src/perf_selftests-x86_64-rhel-9.4-bpf-6160ec9d03d7af5aa345b8b994de80fa8454274b/tools/testing/selftests/drivers/net/./gro.py", line 365, in test
# # Exception|     rx_proc = _run_gro_bin(cfg, test_name, protocol=protocol,
# # Exception|                            verbose=True, fail=fail_now)
# # Exception|   File "/usr/src/perf_selftests-x86_64-rhel-9.4-bpf-6160ec9d03d7af5aa345b8b994de80fa8454274b/tools/testing/selftests/drivers/net/./gro.py", line 220, in _run_gro_bin
# # Exception|     with bkg(rx_cmd, ksft_ready=True, exit_wait=True, fail=fail) as rx_proc:
# # Exception|          ~~~^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^
# # Exception|   File "/usr/src/perf_selftests-x86_64-rhel-9.4-bpf-6160ec9d03d7af5aa345b8b994de80fa8454274b/tools/testing/selftests/net/lib/py/utils.py", line 200, in __exit__
# # Exception|     return self.process(terminate=terminate, fail=self.check_fail,
# # Exception|            ~~~~~~~~~~~~^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^
# # Exception|                         expect_fail=self.expect_fail)
# # Exception|                         ^^^^^^^^^^^^^^^^^^^^^^^^^^^^^
# # Exception|   File "/usr/src/perf_selftests-x86_64-rhel-9.4-bpf-6160ec9d03d7af5aa345b8b994de80fa8454274b/tools/testing/selftests/net/lib/py/utils.py", line 129, in process
# # Exception|     raise CmdExitFailure("Command failed", self)
# # Exception| net.lib.py.utils.CmdExitFailure: Command failed
# # Exception| CMD: /usr/src/perf_selftests-x86_64-rhel-9.4-bpf-6160ec9d03d7af5aa345b8b994de80fa8454274b/tools/testing/selftests/net/lib/gro --pppoev6 --dmac 8e:06:42:98:a9:5f --smac c6:e6:7b:ad:54:ed --daddr 2001:db8::1 --saddr 2001:db8::2 --test data_burst --verbose --rx --iface eth1
# # Exception|   EXIT: 1
# # Exception|   STDOUT: two bursts of two data packets:
# # Exception|   STDERR: Expected {200 200 }, Total 2 packets
# # Exception|           Received {100 [!=200]100 [!=200]100 [!=0]100 [!=0]}, Total 4 packets.
# # Exception|           /usr/src/perf_selftests-x86_64-rhel-9.4-bpf-6160ec9d03d7af5aa345b8b994de80fa8454274b/tools/testing/selftests/net/lib/gro: incorrect number of packets
# # Exception| 
# not ok 308 gro.test.sw_pppoev6_data_burst
# ok 309 gro.test.sw_pppoev6_pppoe_sid
# ok 310 gro.test_gro_capacity.sw_isolated # XFAIL Device does not support ntuple-filters
# # flows=8 attempt=1 received=8 wire=16 coalesced=8 [PASS]
# # flows=16 attempt=1 received=32 wire=32 coalesced=0 [MISS]
# # flows=16 attempt=2 received=32 wire=32 coalesced=0 [MISS]
# # flows=16 attempt=3 received=32 wire=32 coalesced=0 [MISS]
# # Stopped at 16 flows
# ok 311 gro.test_gro_capacity.sw_1q
# ok 312 gro.test_gro_capacity.sw_8q # XFAIL Need at least 8 queues, max=1
# ok 313 gro.test_gro_capacity.hw_isolated # XFAIL Device does not support rx-gro-hw
# ok 314 gro.test_gro_capacity.hw_1q # XFAIL Device does not support rx-gro-hw
# ok 315 gro.test_gro_capacity.hw_8q # XFAIL Device does not support rx-gro-hw
# ok 316 gro.test_gro_capacity.lro_isolated # XFAIL Test does not work on netdevsim
# ok 317 gro.test_gro_capacity.lro_1q # XFAIL Test does not work on netdevsim
# ok 318 gro.test_gro_capacity.lro_8q # XFAIL Test does not work on netdevsim
# # Totals: pass:104 fail:8 xfail:206 xpass:0 skip:0 error:0
not ok 1 selftests: drivers/net: gro.py # exit=1



The kernel config and materials to reproduce are available at:
https://download.01.org/0day-ci/archive/20260715/202607150740.c8e9119d-lkp@intel.com



-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki


