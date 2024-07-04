Return-Path: <netdev+bounces-109186-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id F0F2D927475
	for <lists+netdev@lfdr.de>; Thu,  4 Jul 2024 12:58:05 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 1F08B1C21514
	for <lists+netdev@lfdr.de>; Thu,  4 Jul 2024 10:58:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5BFDC1AC226;
	Thu,  4 Jul 2024 10:57:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="bRlKkZ9r"
X-Original-To: netdev@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.11])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1F9DB1AC224;
	Thu,  4 Jul 2024 10:57:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=198.175.65.11
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720090677; cv=fail; b=s1+6xLhAGlzc4M1qvKvwzZzH8HjjFkXL4ZuRIkBXsenntrzsAaDwnNhce8fVOQRaVQvP4Y0I5dTglIYjMU/Iom5Zu9nHJQyHGAA8Vz8zJoCFkacRNijaLpyzP2NP+yI6CNKdQ7T6LKbIb1xZpZrzpy0eJq5ERg/xy2NhRCQlpgc=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720090677; c=relaxed/simple;
	bh=aNKqvGBhNHmCWAWitkBnhbsyM5nnqg5JfjX0IdMeBoI=;
	h=Date:From:To:CC:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=hPenSHbLuO4lS9dwO2qTO2r2RSjGDB/BtJuwP60dLCGTHITeAX4W6VFwlIb46MvXv4qHSjWTtNSzrDtgtL5ceyMmHuJCRkd3Ui1UXTPEpV29I+k+HgyuG5HR2tPZ9cQRhuAwJwEIm1BAoLFVOPXMfQyhLMfDlfzjiT2UFUxm0eI=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=bRlKkZ9r; arc=fail smtp.client-ip=198.175.65.11
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1720090675; x=1751626675;
  h=date:from:to:cc:subject:message-id:references:
   in-reply-to:mime-version;
  bh=aNKqvGBhNHmCWAWitkBnhbsyM5nnqg5JfjX0IdMeBoI=;
  b=bRlKkZ9rQf2tNrtwL3niUWgjATZx5/SnmShLX2USscO7TdRd9RUZ1Vpm
   MjPm5E4cUwSkTMgcEplSdp6/CLYOCWneJvP94z7CFWWO5Se1VzAQuk1pt
   Nz5MnrF5xsTdEYMsshdyYVdLL3+GUucJR/ZTp+vGyJDBe+iGafuBzogrs
   D+LjKI/z3yAay6wPZ8XaI/dKhwHK3i81hxVmJ/nbYkbrL6i84Xuauzh4J
   9UKAy5aDjB+pZUhw/zHN4l9pgmoiXqtK6xOrIlWHEQA+j8tPdMZXr+vc7
   qHFxlu9MC7IyQlaS/oanQmyfsIIbcyOIkKNfeTQ2/VOrBbv7MLZ5gq/G4
   w==;
X-CSE-ConnectionGUID: AH/9/4kxSJy2JQY9UAy0Lg==
X-CSE-MsgGUID: /fZAsNUcQKyH5m2EF5YuAg==
X-IronPort-AV: E=McAfee;i="6700,10204,11122"; a="27966968"
X-IronPort-AV: E=Sophos;i="6.09,183,1716274800"; 
   d="scan'208";a="27966968"
Received: from fmviesa005.fm.intel.com ([10.60.135.145])
  by orvoesa103.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 04 Jul 2024 03:57:54 -0700
X-CSE-ConnectionGUID: KcSQHvPjQ1yFOT0b6BWcTw==
X-CSE-MsgGUID: 8Y0G3z+MRAa5M3cMBNkyUA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.09,183,1716274800"; 
   d="scan'208";a="51009484"
Received: from fmsmsx603.amr.corp.intel.com ([10.18.126.83])
  by fmviesa005.fm.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 04 Jul 2024 03:57:54 -0700
Received: from fmsmsx612.amr.corp.intel.com (10.18.126.92) by
 fmsmsx603.amr.corp.intel.com (10.18.126.83) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39; Thu, 4 Jul 2024 03:57:53 -0700
Received: from fmsmsx610.amr.corp.intel.com (10.18.126.90) by
 fmsmsx612.amr.corp.intel.com (10.18.126.92) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39; Thu, 4 Jul 2024 03:57:53 -0700
Received: from fmsedg601.ED.cps.intel.com (10.1.192.135) by
 fmsmsx610.amr.corp.intel.com (10.18.126.90) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39 via Frontend Transport; Thu, 4 Jul 2024 03:57:53 -0700
Received: from NAM10-BN7-obe.outbound.protection.outlook.com (104.47.70.43) by
 edgegateway.intel.com (192.55.55.70) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.39; Thu, 4 Jul 2024 03:57:53 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=XuNm9bDmSpPNGlAI0JfTlqtHtHGroIe2lvI8fVGvpCBzzD+SvMuq9+4a7B+fDrceaCyGZ40ryD2ps3ry4900JVebLmAvozVyhg5aqtcqVUEmpe7aQfFTVtX3B4xjqOmZt8SGfyi58FszeE++6E7RG9UAeuZVpItgf8uhB12XRuJS93Gy/+B10ulZqfEuEn3HhWzGO9Iy7Mk/sznabXgqQqgOrrRQflED+Uh3npi60DXKyCqeqK5lSytURjlhBp9nc19hZhRvR8dt1oNNgV3Fbj0aJmHDdLkkuQrIwhpmHtvQ98tPAtwxsjKWf281fr5qB/p/keEGRLDB/N04e4G6+w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ng9i+LynzeFDP+ceU6ZljcciaKRcOE73Er6ZBqzK1vs=;
 b=Ced5ocr+6elLr5ikzqQMghuObB2ZSCFOuLEwMY12WMKdPlDoPnqZOroXydMX9km9WrODCs1H5iN2SN+653gXb9gr8dN8CTprLArb34BCL4OAk1puS5j2sPk8an147H5Wd3zKcYJgBYZdsfteGzk4BD+e6WU9eKCTBIhoaYGZj1jvYdG8b3bYwdwByxGadE+cq3VFIWYsc2pAvVbCQrkxgklqT672r/Tvc2ret68aHrGpXk6cEir5QzmtSdwlRC38NdALRs1OxxY34/UI4eNKyuYVPbO/x8wiRaJnbU+imVzp0hMfdQxFjUhX7w21PnYm7P0OhJ8KOfEn2VGrW/u1qw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from PH0PR11MB5782.namprd11.prod.outlook.com (2603:10b6:510:147::11)
 by CY8PR11MB6963.namprd11.prod.outlook.com (2603:10b6:930:58::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7719.28; Thu, 4 Jul
 2024 10:57:48 +0000
Received: from PH0PR11MB5782.namprd11.prod.outlook.com
 ([fe80::9696:a886:f70a:4e01]) by PH0PR11MB5782.namprd11.prod.outlook.com
 ([fe80::9696:a886:f70a:4e01%7]) with mapi id 15.20.7741.027; Thu, 4 Jul 2024
 10:57:48 +0000
Date: Thu, 4 Jul 2024 12:57:35 +0200
From: Michal Kubiak <michal.kubiak@intel.com>
To: Chengen Du <chengen.du@canonical.com>
CC: <jhs@mojatatu.com>, <xiyou.wangcong@gmail.com>, <jiri@resnulli.us>,
	<davem@davemloft.net>, <edumazet@google.com>, <kuba@kernel.org>,
	<pabeni@redhat.com>, <ozsh@nvidia.com>, <paulb@nvidia.com>,
	<marcelo.leitner@gmail.com>, <netdev@vger.kernel.org>,
	<linux-kernel@vger.kernel.org>, Gerald Yang <gerald.yang@canonical.com>
Subject: Re: [PATCH] net/sched: Fix UAF when resolving a clash
Message-ID: <ZoaAH/R8NM1rtYFt@localhost.localdomain>
References: <20240704093458.39198-1-chengen.du@canonical.com>
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <20240704093458.39198-1-chengen.du@canonical.com>
X-ClientProxiedBy: MI2P293CA0002.ITAP293.PROD.OUTLOOK.COM
 (2603:10a6:290:45::17) To PH0PR11MB5782.namprd11.prod.outlook.com
 (2603:10b6:510:147::11)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH0PR11MB5782:EE_|CY8PR11MB6963:EE_
X-MS-Office365-Filtering-Correlation-Id: 76513590-7be2-4466-1115-08dc9c18246f
X-LD-Processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|7416014|1800799024|376014|366016;
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?lFXBIZb0OpUlsFJv7B0M3X2OgXFWzJGbForisi7NEobUSNjTH5uHrFAytz7f?=
 =?us-ascii?Q?j5GdULy5CaW8BVsA35XP7xkVLOXilGEIW/WotjVQ+tpNu7zDDw7jisQ6nZNe?=
 =?us-ascii?Q?93B+MEdtK3oeqR+rGwRxVkH8kgk0ynKWBRH/Aj4UOIIL5wqjCcvOPINasvgw?=
 =?us-ascii?Q?VHO6GcFJ1IHm+11jZgDs/TvYyTJ9scDRg+gNIKA2kVNu/ff0K830qBkBI2ym?=
 =?us-ascii?Q?mrwES5qvDKdrJ5QUwDBBautHTWY+Yj8HosO0kp1MxRVyZgHG5987RydNE+Dd?=
 =?us-ascii?Q?1IgGk1PrTxrbKPlyoKtuqlWCg4Cdv/VnlZsZsUpDLUJv/Nx7alSdtJ3ypSnn?=
 =?us-ascii?Q?6e/Sk5VYGj9IV5YZ5JnFsYWEhQntbRO8ldsJzaG1tKwMAdchZJiVpEgCFdzh?=
 =?us-ascii?Q?VBeByzjXJlNDueYwRsQeoxIHGgZTqNo9VckLxxeBXEan49xQbEuH8Iy1Kz6l?=
 =?us-ascii?Q?WvAkmh8hRP9ZhEGC840bhQuJl+EvhnheQY1wEpyn91i3khyE1GapkMrTF4Tc?=
 =?us-ascii?Q?K0kLHUbFwQcTQjMI2dyeF2u3CUherS7J4+8pWTOJ33s3N+gpg52UF1ASUydr?=
 =?us-ascii?Q?OJWmLgI5jBxzii6AQfieH1HL3UQKDqXBRsJfOKLLsWhwuD4WDi5TCOnQ88K2?=
 =?us-ascii?Q?ZG0SxFJvkM+vA1ZIrzUfvbjNxBfeUxwo+8YMXeec3L8rPEf+CkSz/30bulgX?=
 =?us-ascii?Q?6zuravgz7+E+FiZ2DhubGA+6MeMpf+0fQ22qzmuaZeIq1Uf3ux/dAMDzcFQo?=
 =?us-ascii?Q?NQOLINTqCBtveWhmywneeyEoV/vf9/AaTwfcozyrLHSRAaGgZNpDI7iHq0Ow?=
 =?us-ascii?Q?S57mZSO3JP9leuyQoZ//Kca8ZVt3Scvrqjdsd9zwZAK/gyhDgEahFMoxpidw?=
 =?us-ascii?Q?hduomI65Gf3OcArIVXMl7rYGIX2/2op3SoBX+s0z8hvSExeg/BgTscvOn7UH?=
 =?us-ascii?Q?l+6uFaUQj9VXpBQyLnO5ZyNrPBqqaPQRDCMqE6uwNQ4fvls8ER/0qBncvHkK?=
 =?us-ascii?Q?j61jAeIaoNzacB2pyN4HClsX0ZJC3su8rq/GRwrv0NMezrh5KBiOuSePrnow?=
 =?us-ascii?Q?L+Yz0cAULAa3QHLDQMIyP/kqKevWMNyCzM006Q3brS9S6Kuz0cqWll5C9tzC?=
 =?us-ascii?Q?U6aqj0gfj3mzKtihfqq9YSebwuApWi2B2wzBH8W4oplN/2+7j/QofJmT3C4U?=
 =?us-ascii?Q?BjxJPGreNOnY+tdGLI21gdsWWq8lGZTw2wpdmV18aZ7oK7hi3/i7JQ+L6/cw?=
 =?us-ascii?Q?f2Z5RVC1c68j6q/itKAxEptGimmP7OtAroCP2Kqj1qbKkBFcF/eWqBteGA1q?=
 =?us-ascii?Q?AIfvVCjfSb1EsELbE2EgVlU9yiduu1ajqzlrqVc1LwHtGQ=3D=3D?=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH0PR11MB5782.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(7416014)(1800799024)(376014)(366016);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?4Rdpv27Hdrotc2f/R9JfxsEag8+KCmsEu0Yf9fXxd7KGh5xZ0bACS7JOBpf7?=
 =?us-ascii?Q?aaQHKZeZTUC9fyI+6DuyaTk+1k77r5RuqLP46NgRfQUSzekxGjGqnZg73fwz?=
 =?us-ascii?Q?PgQ0IPLPw+UnuySMKPx33e09N7SfAZYVKE+nvJA3WkziE+MIygm8ql9hGI0t?=
 =?us-ascii?Q?VEmLdXP/Zy4XkiG/LzLE7+XWpCOnGxQVvP3cLMEPm2SurNtXX7PywdnDh8de?=
 =?us-ascii?Q?IdDuiO+YOl9pTA601VzISJgGYuMsYVzZDifUwiRVkHgpfA6tkCbRN/aHgGHm?=
 =?us-ascii?Q?FqpJvrA3pYH3zEocr8PU3+3RitoBURhj2+dpmuOTTlnsD5v8d/tHSLAYdpPB?=
 =?us-ascii?Q?AB31eDelb37MUkGxa37RIiXobcSob+bCNmQfblBSjnHDV4hG/gmpN1VObxTE?=
 =?us-ascii?Q?4uZVFI9OHAlDLCjN3GqmV9A9pIOEkaiyChqT7JXyqHefEJZCiSgpfdMFjmQp?=
 =?us-ascii?Q?0BExZT8UpM9WuQsh4+9w1KRUIJ3iCsimUM2Mps6hRh6SHGU6oWKdv5ysfQnx?=
 =?us-ascii?Q?kDmVtnvBagVkrXgNtTZM6R+vRvDOJbccyPbc4L1ju0QWU7xkqrhgpiuMGtPJ?=
 =?us-ascii?Q?RqgMLtelcuC4JV24Z6hpe8KPrOR3DeWypezLxZ/voZLCUAMbKz5+l3S8oOGV?=
 =?us-ascii?Q?Sd8uGm2hqS2q9+++a8pybJLibkxzUzdKLixzbobueonoaGlEIe0Swkcgzct+?=
 =?us-ascii?Q?8M9CQEAKRM3uWJBeo6vVbIGqulyk3TyOXoZGi4aOGcqQI80xyiza3BF85ye9?=
 =?us-ascii?Q?VDucvF0zb9OYQcKEGKzAafQz3cubj0IiuIkKYBDIZdZMJPsmFb3wg+nvYkul?=
 =?us-ascii?Q?6/NGg0Yo7NnEqnRoHOqSvRRD0UEZdO9rdvGqUXgh+vl64AidEzVQR5axRLP2?=
 =?us-ascii?Q?/czY2SpZywPDzv0tfJomB7br45pGLr8NdpllBGS/5jzhcp8LuXp2f+BTP93p?=
 =?us-ascii?Q?NNiBQZbdSb3kYSLR8oSOAhXPb1+zc86/Ebl+uWM7CCLQx7L5VA176dTzm8Sr?=
 =?us-ascii?Q?LMi9Ez9efSrWtx2rEJ7dt4ARNhSf56ZxxrQbOtEB+fNUpCBni3ho31qVz/Tg?=
 =?us-ascii?Q?uObHZ9hZz+1yeA6CYvQznorEDc+JNYwDf9ck5R0cHH6njENJF5QGSfsDJXwa?=
 =?us-ascii?Q?NycUiw/2bhRLAm9Kt61FRuiVDKb+ebEHwbC+zUFUEgdMoJUnjewHbNLct3D8?=
 =?us-ascii?Q?5x92quljnrtYwBsQcHhuGWDdpQU6pmyH47HfW9FId5vCIkEn22GIOtYo3cBQ?=
 =?us-ascii?Q?Uz5aVRBVnAAVgh+f+Q9icPpN1BzjoKl3rqeRDYjYXwcYraoed+kcY0Le7qX1?=
 =?us-ascii?Q?TRI+V6eCtMIFlpWOtbe7ko6LhxTiQDNnGaXLaDNtYxn5EyaN9uHq0al9AKfr?=
 =?us-ascii?Q?lfzUi8MPs0XSOnk55k2oiVRgR2m+J9JHizWJwa9hkelLG6Kw8wtbx1azMiJL?=
 =?us-ascii?Q?wR6tHSOuVyoshvRxy6edzMW0Z9zsyyC2TgpBZ3nIB4VPfahJN36DEq1Hdmz7?=
 =?us-ascii?Q?7J2xXjQArcFDZ9+a7WsFm4z9AFWpTj2H79XnbJxZJh+UBLCF767MlFO1KOaC?=
 =?us-ascii?Q?2g8zCiCTuKHjBF03iHqiuo3+ORfJ/tz2AbSMIh6cEKLyJRRm4NNYelcl7LOj?=
 =?us-ascii?Q?dA=3D=3D?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 76513590-7be2-4466-1115-08dc9c18246f
X-MS-Exchange-CrossTenant-AuthSource: PH0PR11MB5782.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 04 Jul 2024 10:57:48.5466
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: BYXup++uZzXLoUw/kObHzDcWBA5xtqITqvWJsj/Nk89Ujy5TNHh1sVtFjOfETCxM8XIWsu+n4/pENIsl3QK6Aw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY8PR11MB6963
X-OriginatorOrg: intel.com

On Thu, Jul 04, 2024 at 05:34:58PM +0800, Chengen Du wrote:
> KASAN reports the following UAF:
> 
>  BUG: KASAN: slab-use-after-free in tcf_ct_flow_table_process_conn+0x12b/0x380 [act_ct]
>  Read of size 1 at addr ffff888c07603600 by task handler130/6469
> 
>  Call Trace:
>   <IRQ>
>   dump_stack_lvl+0x48/0x70
>   print_address_description.constprop.0+0x33/0x3d0
>   print_report+0xc0/0x2b0
>   kasan_report+0xd0/0x120
>   __asan_load1+0x6c/0x80
>   tcf_ct_flow_table_process_conn+0x12b/0x380 [act_ct]
>   tcf_ct_act+0x886/0x1350 [act_ct]
>   tcf_action_exec+0xf8/0x1f0
>   fl_classify+0x355/0x360 [cls_flower]
>   __tcf_classify+0x1fd/0x330
>   tcf_classify+0x21c/0x3c0
>   sch_handle_ingress.constprop.0+0x2c5/0x500
>   __netif_receive_skb_core.constprop.0+0xb25/0x1510
>   __netif_receive_skb_list_core+0x220/0x4c0
>   netif_receive_skb_list_internal+0x446/0x620
>   napi_complete_done+0x157/0x3d0
>   gro_cell_poll+0xcf/0x100
>   __napi_poll+0x65/0x310
>   net_rx_action+0x30c/0x5c0
>   __do_softirq+0x14f/0x491
>   __irq_exit_rcu+0x82/0xc0
>   irq_exit_rcu+0xe/0x20
>   common_interrupt+0xa1/0xb0
>   </IRQ>
>   <TASK>
>   asm_common_interrupt+0x27/0x40
> 
>  Allocated by task 6469:
>   kasan_save_stack+0x38/0x70
>   kasan_set_track+0x25/0x40
>   kasan_save_alloc_info+0x1e/0x40
>   __kasan_krealloc+0x133/0x190
>   krealloc+0xaa/0x130
>   nf_ct_ext_add+0xed/0x230 [nf_conntrack]
>   tcf_ct_act+0x1095/0x1350 [act_ct]
>   tcf_action_exec+0xf8/0x1f0
>   fl_classify+0x355/0x360 [cls_flower]
>   __tcf_classify+0x1fd/0x330
>   tcf_classify+0x21c/0x3c0
>   sch_handle_ingress.constprop.0+0x2c5/0x500
>   __netif_receive_skb_core.constprop.0+0xb25/0x1510
>   __netif_receive_skb_list_core+0x220/0x4c0
>   netif_receive_skb_list_internal+0x446/0x620
>   napi_complete_done+0x157/0x3d0
>   gro_cell_poll+0xcf/0x100
>   __napi_poll+0x65/0x310
>   net_rx_action+0x30c/0x5c0
>   __do_softirq+0x14f/0x491
> 
>  Freed by task 6469:
>   kasan_save_stack+0x38/0x70
>   kasan_set_track+0x25/0x40
>   kasan_save_free_info+0x2b/0x60
>   ____kasan_slab_free+0x180/0x1f0
>   __kasan_slab_free+0x12/0x30
>   slab_free_freelist_hook+0xd2/0x1a0
>   __kmem_cache_free+0x1a2/0x2f0
>   kfree+0x78/0x120
>   nf_conntrack_free+0x74/0x130 [nf_conntrack]
>   nf_ct_destroy+0xb2/0x140 [nf_conntrack]
>   __nf_ct_resolve_clash+0x529/0x5d0 [nf_conntrack]
>   nf_ct_resolve_clash+0xf6/0x490 [nf_conntrack]
>   __nf_conntrack_confirm+0x2c6/0x770 [nf_conntrack]
>   tcf_ct_act+0x12ad/0x1350 [act_ct]
>   tcf_action_exec+0xf8/0x1f0
>   fl_classify+0x355/0x360 [cls_flower]
>   __tcf_classify+0x1fd/0x330
>   tcf_classify+0x21c/0x3c0
>   sch_handle_ingress.constprop.0+0x2c5/0x500
>   __netif_receive_skb_core.constprop.0+0xb25/0x1510
>   __netif_receive_skb_list_core+0x220/0x4c0
>   netif_receive_skb_list_internal+0x446/0x620
>   napi_complete_done+0x157/0x3d0
>   gro_cell_poll+0xcf/0x100
>   __napi_poll+0x65/0x310
>   net_rx_action+0x30c/0x5c0
>   __do_softirq+0x14f/0x491
> 
> The ct may be dropped if a clash has been resolved but is still passed to
> the tcf_ct_flow_table_process_conn function for further usage. This issue
> can be fixed by retrieving ct from skb again after confirming conntrack.
> 
> Fixes: 0cc254e5aa37 ("net/sched: act_ct: Offload connections with commit action")
> Co-developed-by: Gerald Yang <gerald.yang@canonical.com>
> Signed-off-by: Gerald Yang <gerald.yang@canonical.com>
> Signed-off-by: Chengen Du <chengen.du@canonical.com>
> ---
>  net/sched/act_ct.c | 7 +++++++
>  1 file changed, 7 insertions(+)
> 
> diff --git a/net/sched/act_ct.c b/net/sched/act_ct.c
> index 2a96d9c1db65..079562f6ca71 100644
> --- a/net/sched/act_ct.c
> +++ b/net/sched/act_ct.c
> @@ -1077,6 +1077,13 @@ TC_INDIRECT_SCOPE int tcf_ct_act(struct sk_buff *skb, const struct tc_action *a,
>  		 */
>  		if (nf_conntrack_confirm(skb) != NF_ACCEPT)
>  			goto drop;

Nitpick: I would add a newline character before the comment, as that seems
to be the convention in this file for other comments.

> +		/* The ct may be dropped if a clash has been resolved,
> +		 * so it's necessary to retrieve it from skb again to
> +		 * prevent UAF.
> +		 */
> +		ct = nf_ct_get(skb, &ctinfo);
> +		if (!ct)
> +			goto drop;
>  	}
>  
>  	if (!skip_add)
> -- 
> 2.43.0
> 
> 

The fix itself looks correct to me.
However, there is no explicit tag where the patch is addressed. It
should be "net" tree as this is a fix. It should look like:
	[PATCH net]

Please check the patchwork warning for details.


Thanks,
Michal

