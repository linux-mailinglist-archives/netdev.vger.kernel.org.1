Return-Path: <netdev+bounces-292617-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id I0B6AvgJGGpBbAgAu9opvQ
	(envelope-from <netdev+bounces-292617-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Thu, 28 May 2026 11:25:12 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 357845EF8A3
	for <lists+netdev@lfdr.de>; Thu, 28 May 2026 11:25:11 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id C7BBE325DF1F
	for <lists+netdev@lfdr.de>; Thu, 28 May 2026 09:15:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0D49639A05C;
	Thu, 28 May 2026 09:14:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="R+88OLp9"
X-Original-To: netdev@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.16])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C9CF3389106
	for <netdev@vger.kernel.org>; Thu, 28 May 2026 09:14:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=198.175.65.16
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779959679; cv=fail; b=lGsjDUk8hdoeF/j8Yr7NdOWoemqYH821hAVN6VtJf3QQvkCjbHex0ZZod8AxsDu9jpAWyEem6IBRq6zTaQUT3Jt9QZRKJ00d/AY2lFhYXsRTU1TkfvTDyb500y+Sy4zqEjWfByy/isNTpgL3/9+UwjzVStXOa8LFrsjCj4meXfU=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779959679; c=relaxed/simple;
	bh=WpWK/VL3GQxLkgXcceJOje0i3vr7wsggTs1FGcMWvWE=;
	h=Date:From:To:CC:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=ACvP/v3zo8r9Fzlb6sfQ31ivVZvNqBv9a6Ce/3dgYIkLSl3C1S8ceWCfVSjHE4ImL3zDQVueCH0wJ9GEtT7VO6jyP+Gys0piv2uVEAxAgsCEPR920vqwmumF4UqbUDf1+fw56veBWPbG5h8oAuDKblejTwsEZgsaC/iN7LLffT0=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=R+88OLp9; arc=fail smtp.client-ip=198.175.65.16
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1779959677; x=1811495677;
  h=date:from:to:cc:subject:message-id:references:
   in-reply-to:mime-version;
  bh=WpWK/VL3GQxLkgXcceJOje0i3vr7wsggTs1FGcMWvWE=;
  b=R+88OLp99EuHDgsQmgC4FDyUenE6cPZY2pIJB2+mntfevrtOpghsYq+u
   CFok2d5Sxo7AFipMdEu8WsnvO6MeUWluTXZPatIlZzzpK2G7laMbZ5rDv
   cHIopBgyvJh/2AmW+BuHoXCnjeWwLR3IT4yPZh6zqHQTZZBqq79ycuEdO
   tphE0bIZa6X/vlsqw7XaqMM9NrkQuujR66bZLORSOu+gYM9zd41RPBkPa
   I5kvDVnz2uQMMxVOoSTELdQ6+ZRHm2K8kK3ZwIDwJZHmjpnCGqKLPsLP/
   7plO4ZfrStBFNcJYOrcwZPTn/UP5z40xQ/ztBwld9egw6N7EycSSKhRkV
   A==;
X-CSE-ConnectionGUID: CUenhqmUS1KsY4Y/7oFdPg==
X-CSE-MsgGUID: c6JIWxMwTlOWEZwZdYd2mA==
X-IronPort-AV: E=McAfee;i="6800,10657,11799"; a="80986209"
X-IronPort-AV: E=Sophos;i="6.24,173,1774335600"; 
   d="scan'208";a="80986209"
Received: from orviesa003.jf.intel.com ([10.64.159.143])
  by orvoesa108.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 28 May 2026 02:14:37 -0700
X-CSE-ConnectionGUID: rt52m7APRLKN9xKcE+Wlew==
X-CSE-MsgGUID: Wn+rbyRQTeewxk5x2CkI1A==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.24,173,1774335600"; 
   d="scan'208";a="246526025"
Received: from fmsmsx902.amr.corp.intel.com ([10.18.126.91])
  by orviesa003.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 28 May 2026 02:14:37 -0700
Received: from FMSMSX901.amr.corp.intel.com (10.18.126.90) by
 fmsmsx902.amr.corp.intel.com (10.18.126.91) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.37; Thu, 28 May 2026 02:14:36 -0700
Received: from fmsedg903.ED.cps.intel.com (10.1.192.145) by
 FMSMSX901.amr.corp.intel.com (10.18.126.90) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.37 via Frontend Transport; Thu, 28 May 2026 02:14:36 -0700
Received: from BL2PR02CU003.outbound.protection.outlook.com (52.101.52.45) by
 edgegateway.intel.com (192.55.55.83) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.37; Thu, 28 May 2026 02:14:35 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=ZjtcKdXGPtgqvMfx2TTsljkj7pM+jSFmvKzqG/I/B6Grbpo8VW7clvG6ujc5+5ymNYIbpO0HRyf4tAsN675rFj3/GFSn7bSW5fX/T1KNoqyLUSXXbDH4JbkNHq1W69Q4rpXs/83nE11EPkP682RFLegSQWWuBOuFdrgurb1NzS4dKV/h7xkijjdu6TawncJ1Bv8m4Dx9tZpLicB9Qjw6EmwG3T3TJE8dVi+E1RPP6YO48lk3pYp5jT0Ig/r7eXqeD0F61gVipKFDmlx6VF6p88FFdbqZKHYDNDX2u6fusaULd4yYVao8rOk4rU++y7iY/BXk8WgEMpiiMLL5IiL/4Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=/LuQ83JfAfUagG2IoVlWO3iTtahzMj1VAGHNa2gvDhc=;
 b=WqUvwwd7imhLWe+b3+K2NihKO65GBwVOh9/3oXT15Dfi780gfoX878DvnX+0tZLrhwEYJyda7l6KfwidGw1via4gqsnpzkZBrDXis4X8vQQy4SogAAWtCCfBVdzGfeU2idY0KpW3pZIyE1hTpieiTyl6ApVJ27RhaUAelYAZB6wNti/qxGF5BMeMm08DfvMlc/E6kyvzVRv+ygueInZj6JQbvGWFBNxl2JxxRtOzWbCQD/lH/p5GX5oHBsOgCyHVLZDsWYRFB+e6SRG3eoJxBrGNCk7mJjaBABwBVYOmGkgKkV5oYvbmX81r5NRbMkrp2WSVpi6Gc74wZLDxjtKFYA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from DM4PR11MB6117.namprd11.prod.outlook.com (2603:10b6:8:b3::19) by
 PHXPR11MB9663.namprd11.prod.outlook.com (2603:10b6:510:3cb::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.71.12; Thu, 28 May
 2026 09:14:27 +0000
Received: from DM4PR11MB6117.namprd11.prod.outlook.com
 ([fe80::d9b3:e942:2686:3cdd]) by DM4PR11MB6117.namprd11.prod.outlook.com
 ([fe80::d9b3:e942:2686:3cdd%5]) with mapi id 15.21.0071.011; Thu, 28 May 2026
 09:14:27 +0000
Date: Thu, 28 May 2026 11:14:15 +0200
From: Maciej Fijalkowski <maciej.fijalkowski@intel.com>
To: Jakub Kicinski <kuba@kernel.org>
CC: <anthony.l.nguyen@intel.com>, <davem@davemloft.net>, <pabeni@redhat.com>,
	<edumazet@google.com>, <andrew+netdev@lunn.ch>, <netdev@vger.kernel.org>,
	<vinschen@redhat.com>, <alexander.nowlin@intel.com>,
	<larysa.zaremba@intel.com>
Subject: Re: [PATCH net 1/8] ice: fix UAF/NULL deref when VSI rebuild and XDP
 attach race
Message-ID: <ahgHZ8NNWPeFVsXr@boxer>
References: <20260520183501.3360810-2-anthony.l.nguyen@intel.com>
 <20260523001616.1757210-1-kuba@kernel.org>
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <20260523001616.1757210-1-kuba@kernel.org>
X-ClientProxiedBy: VI1P190CA0048.EURP190.PROD.OUTLOOK.COM
 (2603:10a6:800:1bb::19) To DM4PR11MB6117.namprd11.prod.outlook.com
 (2603:10b6:8:b3::19)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM4PR11MB6117:EE_|PHXPR11MB9663:EE_
X-MS-Office365-Filtering-Correlation-Id: 9976778b-e751-410f-3ad1-08debc99844c
X-LD-Processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|366016|376014|18002099003|22082099003|4143699003|3023799007|6133799003|11063799006|5023799004|56012099006;
X-Microsoft-Antispam-Message-Info: /8h+lsqdg1vjAlOQSi4VgTQ0O1GIIZE5KmJ8SfrnmoNPvT+/a6yd3bTkhNq+WDmTHCVIHVtSx3EYboMaqcu9IUBUoqcoo3FdYBHWuhFFupiMj2pMNyNvIQW4DlOMkTe9qYHKLYlJoAlu+67e2UeJI13DU94ME1xfCk2m13FbCB6BjuvlzBB52n8obMsLcbtlFsc/lnEKAE5WlvqlWGrCmtXasDs2HORDMgjYBpQObOyjFljEmfNEC84Pk53r5kZCstyhfOlIfGh9iGaYTnGBkb/+44e0K+hSJz76Wla+4IWerViXqxf0Bhf04wcPx1NPhFQVxzp0xW/HldEcSpsGFR7eCRd4RvuSEMHvzE5Zj8eI61vtuMUCHY0wNusomGYTXiaL5H0SclKrq0IMJUXj42JL3sk9nzpx2SOL4vFBStihwgCBvbvqZrYpdUMfZRGr7Z6sTtWBhaON3r5F+9n7tUunf0WED0LpML2rGSUihrxDlhYu/wGSkYtA++yQAWLIGLfnZfpN5XxMzeEnu7acBKmOy7H7OJqD10faFfzlGJsTGaJ9G8JaxfQ+1I3EKlFgAtlfXASsxxIgxslj3ermpLWtYzL5YFSYyGzFM8cWz+n3qxWmp4rsKEjLjrQiFD9c80O8au4yqhrh0yQqkNllRgZb+t+/hZuJ/rmilhe0HszAiTcExe1jq4Nni7tiESvm
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM4PR11MB6117.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(376014)(18002099003)(22082099003)(4143699003)(3023799007)(6133799003)(11063799006)(5023799004)(56012099006);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?w77L29Fk4NGkR2EYrEDqVhYNQgkgQ5cweMOJV4XQnu1i2Z8mIGs/Ee6fou3L?=
 =?us-ascii?Q?Utp6Ba2n/+7cC12RDhTBg5RFvRcVunmU9NjoWYdleMb+tklEsllMgjaXt1kX?=
 =?us-ascii?Q?cU6ZICtOHZHFPwuJ1DK40Z/Sq4sTf8qULrNfCs20Ns6JhQe8R6yqbm7gL5dc?=
 =?us-ascii?Q?2reCFLgthAlkh3LfM40OKaPDMxL/2Y5vbxYdGo4HZuBVUW/3dJisx+4MS16h?=
 =?us-ascii?Q?328I4Nczq3TgehqNJiIEgs7Mcn0TS2vJMXpH7pJ1X6IHjjiccrpsHG3cIxQf?=
 =?us-ascii?Q?IUvUcUNSXW7fOx0SITKAVSostXS/HEiuekAjvAAa6h7LGirRyKckNk8AZzo3?=
 =?us-ascii?Q?fSSZ02VaGFk9liqI0udqvHdJSHDGhJGsxOcDL1w75fMmFQy1zoH3xtMMX2Tc?=
 =?us-ascii?Q?92z+CLduWqNYrW+UA1Myfm7uEdQAX1fsPWEotba2ZVH6XkX/Hn1POBy8dwmV?=
 =?us-ascii?Q?sl2Is840uUHQJlAXRf8lk1m5khC+8n2tdPM6uS9etChRCi29puom5RE2hEtE?=
 =?us-ascii?Q?DUjRVEVohWbVfaSi507NEE4wzuPx0UWxBLKbohuN6ViAG3fe+jloY+LXU3uy?=
 =?us-ascii?Q?3sqO6DSuWzpobfdXTvJJ3ehlD08XlWPVdGHgQUVXzI0b65CSncXYluFSyUUp?=
 =?us-ascii?Q?hUCHsD7HLBwC7iF+zJaxpPkCG4/tmEPOFeYdcPBoR9UZGov2kPGjVlc4zJOc?=
 =?us-ascii?Q?y3oGEBPafc6lxjjCIwUoTXMl5Wb8Q0gBDGY71gs08jlaS/p1HOnrb/Ow4JBi?=
 =?us-ascii?Q?XWshrZ2UAcbb5YL7XvKrEn+XqUMEag+2BzpylGu9mzUMxRIR942SHN+HiDKj?=
 =?us-ascii?Q?8tdqQJOGqle7yzeCqqq3n1gLNpI2LpKTzV+3H3AeiG0vYtJNeN0EKi4MQAtt?=
 =?us-ascii?Q?pmtXo3l3l/Akb5HRvzjLbK2bqO6I3v1rAn4vZxECwdnOQbUo2t0yPxo979z/?=
 =?us-ascii?Q?4it6MhO6EUSU8FCdOUbxY2/aKy1g598rA36Wk/PBQC9uLA1Y/LK2Ak7LuA8G?=
 =?us-ascii?Q?JISwYcw2kj1t61CKP5gWD/6jbFPug2sFerQ++V46xcm0esIMvCXc7VrcL/pa?=
 =?us-ascii?Q?eIms+dcnCQauB6prJuoit476TUi5Up25wxUgpz5G3PEQ/9VmHNtZj4qc5/J6?=
 =?us-ascii?Q?ELEcgxcnvCeIpOMcAJN6LvTOOXCmPlZdnJJv+PdtDv6Lv9BHaGqnba+v028x?=
 =?us-ascii?Q?WcavvR06TDBFEaE5NLJ1EXjL8C7p48ypuT9LnIpA9qS0DupTJip8cPOsv3/V?=
 =?us-ascii?Q?NrxzJtyMccjYVwSDOYUZ/+QbTyF/fpmWfoCjBQRWZvAVlp2G4gjI/Th+1aIg?=
 =?us-ascii?Q?j6N0Qjo4ORaRp6sZjnhQf8PShLfMS0KMSJS90mD1G1eKDOeHxBDJ4Km/EBWK?=
 =?us-ascii?Q?Atbp0ILKM+0hWh36hx6dDz/4twUzg5h46BjqCmgWA7nyPpHAkqEA+XL0qnTK?=
 =?us-ascii?Q?k6Us0vcbLoaEgzlM8rrpiFZ5ZTTJLl0sMnkrX6epvbfJibdWTcBeJwyQGeYp?=
 =?us-ascii?Q?VNcwLegYPyLcS5/MEz1HqHSL3LKJMQCyCPbKMcWuqbFPyOEAwoj6ZAh2dPU0?=
 =?us-ascii?Q?yuY4DJDzBrHOpU1JtG2QfHBVMaNShhfP8KtkF6qiNv61FS6MQt0W4nl8e1Og?=
 =?us-ascii?Q?rIb1GDEd6NWmxi1fpS8kA6exKojoVDxS4CKFFzo9HexQuP5FuG+SQytQyWt/?=
 =?us-ascii?Q?W2gnaRh8XIuVc8q+BNmZ9afaC1MOAAMAGegvrAA6O82MXMfHLEScv2Yx559o?=
 =?us-ascii?Q?rIeWrFb07fuBOy0ZdXYSv95IJIpZwUg=3D?=
X-Exchange-RoutingPolicyChecked: TG5EG/s3M9w9wu1Dc7oj956wM7IIzO0M9K2Vun72qXz3qTY1sciMKN5NGZBWZpgFY9C4x1mbvAZKBsiYzCdjXMvQ+0VPWI58nA4WNHAfmqfKT0PX7Bb0IynzrewLaSZZUviFMvWuUWzBPUhEgDluynURSADAGAeRAokbU9iGOgzyCepHDrG+N39tXeF0wqblBmoxx3ol+gy6/w8KZYgIA/cS8Qk6O8EAr/Rc/B3mQQSjK8fHT3kdEp0QHaucFCL+jNSDr94zmCQ2TryggPwoyGU6BOwOCfutfr9p17v6kDZL7tIiRTU5O+wDk0c/uvB1rMCam5laQyNLN+cEBDWe3A==
X-MS-Exchange-CrossTenant-Network-Message-Id: 9976778b-e751-410f-3ad1-08debc99844c
X-MS-Exchange-CrossTenant-AuthSource: DM4PR11MB6117.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 28 May 2026 09:14:27.2348
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: pzmxRZ/v4ifgkslFUMABjvDatZzPwvOirsAB1/otxLhBkDCGQOis0E0DkGEV/6kFrKKMybw2t2jExC+/sINzHvsNhLw6XbgqG2FJtrC//s0=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PHXPR11MB9663
X-OriginatorOrg: intel.com
X-Spamd-Result: default: False [1.84 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_REJECT(1.00)[cv is fail on i=2];
	MID_RHS_NOT_FQDN(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[intel.com,none];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	R_DKIM_ALLOW(-0.20)[intel.com:s=Intel];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	MIME_TRACE(0.00)[0:+];
	TAGGED_FROM(0.00)[bounces-292617-lists,netdev=lfdr.de];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[maciej.fijalkowski@intel.com,netdev@vger.kernel.org];
	DKIM_TRACE(0.00)[intel.com:+];
	RCPT_COUNT_SEVEN(0.00)[10];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	TAGGED_RCPT(0.00)[netdev];
	MISSING_XM_UA(0.00)[];
	RCVD_COUNT_SEVEN(0.00)[10]
X-Rspamd-Queue-Id: 357845EF8A3
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

On Fri, May 22, 2026 at 05:16:16PM -0700, Jakub Kicinski wrote:
> This is an AI-generated review of your patch. The human sending this
> email has considered the AI review valid, or at least plausible.
> ---
> ice: fix UAF/NULL deref when VSI rebuild and XDP attach race
> 
> This commit addresses a race condition between a VSI rebuild and an XDP
> attach operation. It prevents rx_ring->xdp_prog from being populated before
> rx_ring->xdp_ring is valid by rejecting the XDP attach when a VSI rebuild
> is pending. XDP detachment is still permitted during this window to clear
> the existing program.
> 
> Fixes: 2504b8405768 ("ice: protect XDP configuration with a mutex")
> 
> > diff --git a/drivers/net/ethernet/intel/ice/ice_main.c b/drivers/net/ethernet/intel/ice/ice_main.c
> > --- a/drivers/net/ethernet/intel/ice/ice_main.c
> > +++ b/drivers/net/ethernet/intel/ice/ice_main.c
> [ ... ]
> > @@ -2912,12 +2912,21 @@ ice_xdp_setup_prog(struct ice_vsi *vsi, struct bpf_prog *prog,
> >  	}
> >  
> >  	/* hot swap progs and avoid toggling link */
> > -	if (ice_is_xdp_ena_vsi(vsi) == !!prog ||
> > -	    test_bit(ICE_VSI_REBUILD_PENDING, vsi->state)) {
> > +	if (ice_is_xdp_ena_vsi(vsi) == !!prog) {
> >  		ice_vsi_assign_bpf_prog(vsi, prog);
> >  		return 0;
> >  	}
> >  
> > +	if (test_bit(ICE_VSI_REBUILD_PENDING, vsi->state)) {
> 
> [Severity: High]
> This is a pre-existing issue, but is the check for ICE_VSI_REBUILD_PENDING
> prone to a TOCTOU race because it relies on ad-hoc flag synchronization
> instead of proper locking with the device reset path?
> 
> The asynchronous reset path (ice_prepare_for_reset()) sets
> ICE_VSI_REBUILD_PENDING without holding vsi->xdp_state_lock or rtnl_lock().
> 
> If ice_xdp_setup_prog() (which holds both locks) checks the bit before it
> is set, it proceeds to configure XDP and sets ICE_VSI_DOWN. If the reset
> path then sets the bit and calls ice_pf_dis_all_vsi(), it will skip this
> VSI because ICE_VSI_DOWN is already set.
> 
> When ice_xdp_setup_prog() finishes, it calls ice_up() which clears
> ICE_VSI_DOWN and starts enabling hardware queues while the device is
> actively undergoing a hardware reset (ice_do_reset()).
> 
> Can writing to hardware registers during an active reset cause hardware
> hangs or PCI master aborts?
> 
> > +		if (prog) {
> > +			NL_SET_ERR_MSG_MOD(extack, "VSI rebuild is pending");
> > +			return -EAGAIN;
> > +		}
> > +
> > +		ice_vsi_assign_bpf_prog(vsi, NULL);
> 
> [Severity: High]
> This is a pre-existing issue, but does detaching an XDP program while a VSI
> rebuild has failed lead to a NULL pointer dereference here?
> 
> If a VSI rebuild fails, ice_vsi_decfg() frees vsi->rx_rings and sets the
> pointer to NULL via ice_vsi_free_arrays(), but leaves vsi->num_rxq
> non-zero. The ICE_VSI_REBUILD_PENDING bit remains set because it is only
> cleared on the success path in ice_vsi_rebuild().
> 
> If a user subsequently detaches XDP, ice_xdp_setup_prog() intercepts it
> because ICE_VSI_REBUILD_PENDING is set, and it calls
> ice_vsi_assign_bpf_prog(vsi, NULL).
> 
> This function loops up to vsi->num_rxq:
> 
> ice_vsi_assign_bpf_prog() {
>     ...
>     ice_for_each_rxq(vsi, i)
>         WRITE_ONCE(vsi->rx_rings[i]->xdp_prog, vsi->xdp_prog);
>     ...
> }
> 
> Since vsi->rx_rings is NULL, does this cause a guaranteed NULL pointer
> dereference panic?

CC: Larysa

Seems we should check if vsi->rx_rings != NULL plus
ICE_VSI_REBUILD_PENDING should be cleared on error path in
ice_vsi_rebuild().

Do you have any comment on TOCTOU issue mentioned above?

> 
> > +		return 0;
> > +	}
> > +
> >  	if_running = netif_running(vsi->netdev) &&
> >  		     !test_and_set_bit(ICE_VSI_DOWN, vsi->state);
> -- 
> pw-bot: cr
> 

