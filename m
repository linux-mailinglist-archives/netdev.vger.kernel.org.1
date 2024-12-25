Return-Path: <netdev+bounces-154231-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 017979FC34E
	for <lists+netdev@lfdr.de>; Wed, 25 Dec 2024 03:27:10 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 4D9E41883FA9
	for <lists+netdev@lfdr.de>; Wed, 25 Dec 2024 02:27:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4D6DD347B4;
	Wed, 25 Dec 2024 02:27:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="arRRjXKe"
X-Original-To: netdev@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 20BC224B34
	for <netdev@vger.kernel.org>; Wed, 25 Dec 2024 02:27:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=192.198.163.12
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1735093624; cv=fail; b=nvtBQcywi0F7a7qjB6JiDZaP0MPMP+dRPClgim3tKNTBIu6mDASvOKzdlAdGUGk9p3MmuE0HcJxbJFdP/kHZWIhLZPqqRuM772GAWO9mKCjTiaisLxMfB8Z3hK96m6iFXXltTFc1/MimRJY4mcK39pbgSQ4arwe9TALvhRnDhG4=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1735093624; c=relaxed/simple;
	bh=/QkLf0b4qD1NW/XY5VZlcwti9J2ocRPSy9ReF8QVT50=;
	h=Date:From:To:CC:Subject:Message-ID:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=l8TiR2kPtTMo84Ymyr7pS8goDgcYw1W9hXwpJIGZGR4afeCgWxMfZK+tmzkgsK1aq7yHB4QzUJRj9bvnPAfJ4B9mVuwkUJ4vumP8oW4Q1WOGOqWwV29QYuGT0iplpJAAcdnt5HDn75HT/+JrDYbteCNrK1r75oCvokgCDymGXhE=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=arRRjXKe; arc=fail smtp.client-ip=192.198.163.12
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1735093622; x=1766629622;
  h=date:from:to:cc:subject:message-id:in-reply-to:
   mime-version;
  bh=/QkLf0b4qD1NW/XY5VZlcwti9J2ocRPSy9ReF8QVT50=;
  b=arRRjXKe5c7WG4U9ozj95+X+Agv8XnjZFFPxf20IsAh1YX11WAT4khs2
   FM+68gFeEZkyp9ftOchKHVkP8+LVMLp0Qq2vkgWDVu1G1SOJgmwp74uwd
   iRiPnQEEsce2VwKeU4N3RJPj4PxuS0/KBX8Fbe4C5WeoPvjx30V812dBT
   q2csdHf/+w9AEpapJtBCvQKEXDx6YrTLkMi+0rmlYMDMU4q+Hh40vqeSs
   KAHQqxI+o4G7Zp6vjNN+Pf3gNmcFv3sQ3kZizYPv2uUCL7panrY98L51C
   Q7gVhmwAypbGC77LkipkKggCKTUxAPdyqzbYzRzwUMW4B5X82e7fKiYTA
   Q==;
X-CSE-ConnectionGUID: S+4HMWdmRqORHVCobe9/9A==
X-CSE-MsgGUID: 8BsUw34iQ1CQcQeNxw12OA==
X-IronPort-AV: E=McAfee;i="6700,10204,11296"; a="39496516"
X-IronPort-AV: E=Sophos;i="6.12,261,1728975600"; 
   d="scan'208";a="39496516"
Received: from fmviesa006.fm.intel.com ([10.60.135.146])
  by fmvoesa106.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 24 Dec 2024 18:26:59 -0800
X-CSE-ConnectionGUID: II27tdnxR7SZXSB/diRkeQ==
X-CSE-MsgGUID: s/LvAUkYRh6TxkFoo02T/g==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.12,261,1728975600"; 
   d="scan'208";a="99366347"
Received: from orsmsx601.amr.corp.intel.com ([10.22.229.14])
  by fmviesa006.fm.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 24 Dec 2024 18:26:59 -0800
Received: from orsmsx601.amr.corp.intel.com (10.22.229.14) by
 ORSMSX601.amr.corp.intel.com (10.22.229.14) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.44; Tue, 24 Dec 2024 18:26:58 -0800
Received: from orsedg603.ED.cps.intel.com (10.7.248.4) by
 orsmsx601.amr.corp.intel.com (10.22.229.14) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.44 via Frontend Transport; Tue, 24 Dec 2024 18:26:58 -0800
Received: from NAM04-DM6-obe.outbound.protection.outlook.com (104.47.73.47) by
 edgegateway.intel.com (134.134.137.100) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.44; Tue, 24 Dec 2024 18:26:57 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=btJMjE/jzt5PXaj/M/I00SlBxdnuqQqS5/2V0s+ylaiimvLqo/pfbSfkC8vWWkgy3FY5T6HoOA+5FK8eVwtxXg52vHxS3CR7ifdJrCWqGZtXimu6gks32UVCPT8MvqjN1Wy4SMPEMcZqXnSoHuDvowyK7e48awM+eIqNOZW+qbl0M+VYywLGXTXX2tU4pOFSwn28uWR03+1kpXbpT4Jmf+BMwps0bmP1iepygysVKoOW3JKIsb2vpyOnv1Dr7u3Je+qXW2rhcXKSg3QHtJjx2r+ch3aa8Usm0KDcPe6JXxLCyvdaAzyzgDNi+uHaMXkJHaPPzCq4yh+DvyOCwWPdwg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=n1TAfC/Cxjf4cqg4Yv8QlcIBAUxGe5KnCRlU9REaRuE=;
 b=IhGueoOFTTJxrMuLgqc+fzegkABfyNXiGldt7sNl+f1/sHyIyG5Vw4Fj0jsvb0JrHUJBDELuy2geoLeElhFzxAhcFXRPm6xPEvzKnU+qanSDLkWA0Fx8lQ0ZhYnJUmbiuc0yUaSBXSZYqiJr6nW1amotX2Yf1ykAEh2tX9GfrQc9Ay+FV5WrqEdDvBgZyI+NLK0PBjFaOjOGiSLux3gpUj4G6dzVkJnFZhTcvRB40rpUVbFHZKU4/2mmYaZD8RKRGoVHykPFSt182xYEO2KmKqXa4FBNoBqWy3Dgn1RvxpTEKgjeglNKBNNDcNHHO8MXE5DUJHMXncZlkBgR49O7Jw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from LV3PR11MB8603.namprd11.prod.outlook.com (2603:10b6:408:1b6::9)
 by SJ2PR11MB8370.namprd11.prod.outlook.com (2603:10b6:a03:540::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8272.21; Wed, 25 Dec
 2024 02:26:50 +0000
Received: from LV3PR11MB8603.namprd11.prod.outlook.com
 ([fe80::4622:29cf:32b:7e5c]) by LV3PR11MB8603.namprd11.prod.outlook.com
 ([fe80::4622:29cf:32b:7e5c%6]) with mapi id 15.20.8293.000; Wed, 25 Dec 2024
 02:26:50 +0000
Date: Wed, 25 Dec 2024 10:26:40 +0800
From: kernel test robot <oliver.sang@intel.com>
To: John Ousterhout <ouster@cs.stanford.edu>
CC: <oe-lkp@lists.linux.dev>, <lkp@intel.com>, <netdev@vger.kernel.org>,
	<pabeni@redhat.com>, <edumazet@google.com>, <horms@kernel.org>,
	<kuba@kernel.org>, John Ousterhout <ouster@cs.stanford.edu>,
	<oliver.sang@intel.com>
Subject: Re: [PATCH net-next v4 12/12] net: homa: create Makefile and Kconfig
Message-ID: <202412251044.574ee2c0-lkp@intel.com>
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <20241217000626.2958-13-ouster@cs.stanford.edu>
X-ClientProxiedBy: SG2PR06CA0248.apcprd06.prod.outlook.com
 (2603:1096:4:ac::32) To LV3PR11MB8603.namprd11.prod.outlook.com
 (2603:10b6:408:1b6::9)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: LV3PR11MB8603:EE_|SJ2PR11MB8370:EE_
X-MS-Office365-Filtering-Correlation-Id: 40fa006f-3b46-4724-ad95-08dd248b96c2
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|1800799024|366016|7053199007;
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?3O6Yo78DhwI843ZOk+x2t0SX4u7KKhwFaVQnJ6jjrRr19Qyn00++iOfdkvx0?=
 =?us-ascii?Q?fwsVwP7ttxf6VLCdxJi3BoNTpFpH82PDg+2fV+QMtN0Omqf7456nr1ClY3hv?=
 =?us-ascii?Q?zLR2wrZyzLwVIcrdWCo5eOT4xxsLjpJOEdavav2PMtU9tzPneCU3IWHDkJBG?=
 =?us-ascii?Q?R6Kzj/H5zM+6xFoNWKedqRk/FugIjYwNFdMpPIQuhQbh8XSXjr21CbmyolPg?=
 =?us-ascii?Q?MZHH1WcrksyDOTSlg/lfl2en5akHjVJ5NedpILkgh322XaX1iq1sf3lH9imn?=
 =?us-ascii?Q?yorc0zJ9Vxt14n7IwSBZijuhJRd21qmk2IQSXBYTuFxLderNFtJZRjyZ8h3M?=
 =?us-ascii?Q?A7vzv4E7oWqgqXKGrnTtVkh4TJzjoxfMflT+vsvFukt8v6FHYkRp7pWWyT6D?=
 =?us-ascii?Q?QfJdnr967LO8C+RmhOMDkyNqvJzu8m3r5JSlKhvQiR6mZKHmaAn3S5LkHaal?=
 =?us-ascii?Q?yIAUT8mTGER3pfz5PmDRcxnDdd2TVF4ttHvb+PVOX/IuDOK1iAkukudiZFKj?=
 =?us-ascii?Q?sbp7b8vfpmQwSgmNB3KEq0rXoBDKwR5y5rUd2dQVjpTfKURIRbHgCx2WOj0O?=
 =?us-ascii?Q?FfOW6dSbIFaJGEDydF5xbxA3qkDtGbAPspaq2TokS+4fwLTmnA7tFKz6RhBa?=
 =?us-ascii?Q?3cFHMrjCqMs3ohMZgvyyOs8KkRMbaiQ7ndJ9SZGZy5kOX0NHjoxthHeCnJiA?=
 =?us-ascii?Q?Ox4tDt3t4cYDJ9BrVNd6LdanMVZW5ke8/dVz/OB+/hJXsJY0s+4KA0dYREsU?=
 =?us-ascii?Q?q+0q7YngzKkuEbI9ATn4L9G9anCO1mZHoPyr7Ek+KSdnHg3vwtkQ/Z29gF1J?=
 =?us-ascii?Q?CSR8RGQ6sziqrfmko4Y3Ya9Y5VmC3Ad5yCYY4ERegMg6+JQbBR92W/T58kCV?=
 =?us-ascii?Q?2AFPLgyHsv8sIwlRPj9KGoKUUIAf0GTYpXx9oF75RCWoCb/j/cq8kxZcS7z4?=
 =?us-ascii?Q?tS7yzWT2rbru9CA5lOwjLhxdU4gFQLfdFgsr31CWFTVNIY7tzoNAKSgzwlJQ?=
 =?us-ascii?Q?ABlZxaehf/gfqk4Ly4e5t7RlesbPd1gUe+0SuK5WIdmKE15qPBszWtHIoWca?=
 =?us-ascii?Q?uXoukXD0XHKX45hRk3rjfPrdN/lyWnw5lQGHED6Ou/bDU9oXVWVfVkp4vYyX?=
 =?us-ascii?Q?wKN7gtYtI/tICDuR5BcKhsSPL0kcAMbO2iRe5qwjFPheYfuo8/hXOSptXHyS?=
 =?us-ascii?Q?hSa1SXXtftvEQ82/6kWP42ZDfiaVydtIC+N4hnP/ptDLr1kZJKewDHAWQTaM?=
 =?us-ascii?Q?shbjo3MdJbecFAsNA/5ViVyk6nNMACzJD57bO5Q5LCJK8LC26d34xHdjvY0j?=
 =?us-ascii?Q?y+qnmUHG7ryO68ZvQow0v383sCyECb8I+4EeVVXJLi0RXw=3D=3D?=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:LV3PR11MB8603.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(1800799024)(366016)(7053199007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?4fe/eMdKm2E9K8GOUYBoEVd+vW94f/yKhA8volqHLCPcnXX8z+nCtztb1VAf?=
 =?us-ascii?Q?NysiCtejD1raQe1sknEACSkkUvX6nTw2RpyKCpdOfDOQXgmm4GfbaCCchE/V?=
 =?us-ascii?Q?rZ7bIqITn5s+x9o6dlOwh6Hthdryljaq1BVcmVNm7+afmJ8JDyuXSQ4dPYTs?=
 =?us-ascii?Q?rEEPEhU744eIw5ZJ+JAKQvTmfXx3iIOgOqH/B+Dy2wdfbU2hON7eTYmgWm1a?=
 =?us-ascii?Q?8YmATAVNOpVUUNkOrQIPRCKHPYCbw6xKYmxBq9vfGbmjMJeRXeVqSSQMvEpw?=
 =?us-ascii?Q?Dsph50mONXcgFHsTB5cOKsfGcBo0mdLb3B50yedqlIxALt5xFvH3MO3S/Ua/?=
 =?us-ascii?Q?to4fXrJMPZp01zp5V18bdL7Po1yFQCkX2SdK6Vj+DROZcZpuoGdk3bBhXoen?=
 =?us-ascii?Q?eDtw/nWiNkPSia0duBma0JAqyiBrvPRuUOmWbHrbj7aE/RVePi8GqYbeEhpM?=
 =?us-ascii?Q?WdK/LtYEc2RI0lT5YDfjnnGwZi1/eLgzJWF/byc20pBW62/eKBPt7o9/6nak?=
 =?us-ascii?Q?+i+UPzfxfzv0BXZUghADMJEob5RvCwjuBYwB/4m6SiFutSrQxhHqrXITm6bu?=
 =?us-ascii?Q?I3HdQn7zzjI0bEl9Kl9k67ASIUq819YyrH/9DPg71VND0UUNoCzCcsGXY5rd?=
 =?us-ascii?Q?zc6NF5/FvoSWNe5UdFZ0CCZMIC4XrRGfmBvnLQwPOAZZGfoc6xe2Qx7W29xU?=
 =?us-ascii?Q?eWA2fDZKaouyyPyHWnrVu7ubGvuQOwmsOCwn+TLTfrgz7duucCE8pyLwMmY3?=
 =?us-ascii?Q?EglPmoCxdClEaCiq3gKlEeCXn+iAfHblXsA6CzyowYj/xl/WxN8FOZchOyID?=
 =?us-ascii?Q?Gf3eOfnmh99nOCu08HJfP31B4bz9HHzNwCGHHFVCeuPJMYebi3rpFRLi/Rwv?=
 =?us-ascii?Q?jlwQrU6g/oDY7bSm564qsHjFKUUROk4m6lpTMA4kDqg3tqGtowQlskPqlh3+?=
 =?us-ascii?Q?n73F/pyU70EaDp4YYpNW4QRPpKV9+hx9Nc4hfEGErGwbDGYtK8xaHBWKYY6F?=
 =?us-ascii?Q?HSfL97AnKZodT6Oz2ueo2xpyLio//X/gON5Zr6O+Mi6PZeurfxvWoGJ3g+Rp?=
 =?us-ascii?Q?2odQbC6vFHcEUIeXD9Ek5Fpv6udVTXbfdHtTpbpyosRu9jUnZSFc+hJeLD2D?=
 =?us-ascii?Q?+wCyzI1X7OulBUvnCCmEiwomIgEpzisWl+7vh450Gz23v2CFUBjGIFQXMJJ1?=
 =?us-ascii?Q?W1ViqfV9ujr5s+EEBIgTjE4yjN756qXjwIEenOGfifVrHi11zn5o2a1lyY0Q?=
 =?us-ascii?Q?2DXRw7EUxvJfl1Gjmj3FV0tgG0qP0qy+QHwUIxBIA+fTuoIFJxT4zLfJRW9m?=
 =?us-ascii?Q?lPVvhMXncJhH2mL+3v7EaGfbQxoUTOvW5JcaXD7+bP0uQHYqEFyomoyz/cup?=
 =?us-ascii?Q?Q09Blso9oSJd1Y3fdpBIDYn42fqVBAV5eHvHFyMMIFLNNP+/WUOO5SwtJnWt?=
 =?us-ascii?Q?7d+5CTVn8oUtwOBdoXqS/wrRwWAAtdtkbwKL7gD0RhsDs20YWZsboSiJAXPe?=
 =?us-ascii?Q?MnBdAN3vvwkc7o0s6JTtRfKytyowAA5J9rNPgNuBs4AKhya2EmZuoDbfKU4M?=
 =?us-ascii?Q?R/y1HsjCyL4ujKXsXxe02+dlbABOnHXhfQcY1c+LH37xaJDYt7HIwma0wdPd?=
 =?us-ascii?Q?+A=3D=3D?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 40fa006f-3b46-4724-ad95-08dd248b96c2
X-MS-Exchange-CrossTenant-AuthSource: LV3PR11MB8603.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 25 Dec 2024 02:26:50.5777
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: kigs+uQj52Wf4I/WQ67WcOtRe9ek2wbvU162qbaDrSfLv3BVASJSkGUtvQ2OaC0vUXSsJUqi98O2c41CVkkVjw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ2PR11MB8370
X-OriginatorOrg: intel.com



Hello,

kernel test robot noticed "WARNING:possible_circular_locking_dependency_detected" on:

commit: 087197983ce53b12680eedd496208567f189fbb6 ("[PATCH net-next v4 12/12] net: homa: create Makefile and Kconfig")
url: https://github.com/intel-lab-lkp/linux/commits/John-Ousterhout/inet-homa-define-user-visible-API-for-Homa/20241217-081126
base: https://git.kernel.org/cgit/linux/kernel/git/davem/net-next.git bc6a5efe3dcd9ada8d76eeb69039a11a86add39b
patch link: https://lore.kernel.org/all/20241217000626.2958-13-ouster@cs.stanford.edu/
patch subject: [PATCH net-next v4 12/12] net: homa: create Makefile and Kconfig

in testcase: trinity
version: 
with following parameters:

	runtime: 600s



config: x86_64-randconfig-075-20241223
compiler: gcc-12
test machine: qemu-system-x86_64 -enable-kvm -cpu SandyBridge -smp 2 -m 16G

(please refer to attached dmesg/kmsg for entire log/backtrace)


+--------------------------------------------------------------------------------------------------------------------------------------------------------------------+------------+------------+
|                                                                                                                                                                    | 3a0d944318 | 087197983c |
+--------------------------------------------------------------------------------------------------------------------------------------------------------------------+------------+------------+
| WARNING:possible_circular_locking_dependency_detected                                                                                                              | 0          | 21         |
| WARNING:possible_circular_locking_dependency_detected_homa_timer_is_trying_to_acquire_lock:at:down_trylock_but_task_is_already_holding_lock:at:__debug_object_init | 0          | 21         |
| WARNING:at_lib/debugobjects.c:#lookup_object_or_alloc                                                                                                              | 0          | 21         |
| RIP:lookup_object_or_alloc                                                                                                                                         | 0          | 21         |
+--------------------------------------------------------------------------------------------------------------------------------------------------------------------+------------+------------+


If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <oliver.sang@intel.com>
| Closes: https://lore.kernel.org/oe-lkp/202412251044.574ee2c0-lkp@intel.com


[   11.584244][  T133] WARNING: possible circular locking dependency detected
[   11.584248][  T133] 6.13.0-rc2-00436-g087197983ce5 #1 Not tainted
[   11.584253][  T133] ------------------------------------------------------
[   11.584256][  T133] homa_timer/133 is trying to acquire lock:
[ 11.584261][ T133] ffffffff8c9b9318 ((console_sem).lock){-...}-{2:2}, at: down_trylock (kernel/locking/semaphore.c:140)
[   11.585197][  T133]
[   11.585197][  T133] but task is already holding lock:
[ 11.585197][ T133] ffffffff9165dbb0 (&obj_hash[i].lock){-.-.}-{2:2}, at: __debug_object_init (lib/debugobjects.c:662 lib/debugobjects.c:743)
[   11.585197][  T133]
[   11.585197][  T133] which lock already depends on the new lock.
[   11.585197][  T133]
[   11.585197][  T133] the existing dependency chain (in reverse order) is:
[   11.585197][  T133]
[   11.585197][  T133] -> #3 (&obj_hash[i].lock){-.-.}-{2:2}:
[ 11.585197][ T133] __lock_acquire (kernel/locking/lockdep.c:5226)
[ 11.585197][ T133] lock_acquire (kernel/locking/lockdep.c:467 kernel/locking/lockdep.c:5851 kernel/locking/lockdep.c:5814)
[ 11.585197][ T133] _raw_spin_lock_irqsave (include/linux/spinlock_api_smp.h:111 kernel/locking/spinlock.c:162)
[ 11.585197][ T133] debug_object_assert_init (lib/debugobjects.c:1007)
[ 11.585197][ T133] __mod_timer (kernel/time/timer.c:1078)
[ 11.585197][ T133] add_timer_global (kernel/time/timer.c:1330)
[ 11.585197][ T133] __queue_delayed_work (kernel/workqueue.c:2527)
[ 11.585197][ T133] queue_delayed_work_on (kernel/workqueue.c:2553)
[ 11.585197][ T133] psi_task_change (kernel/sched/psi.c:913 (discriminator 1))
[ 11.585197][ T133] enqueue_task (kernel/sched/core.c:2070)
[ 11.585197][ T133] wake_up_new_task (kernel/sched/core.c:2110 kernel/sched/core.c:4870)
[ 11.585197][ T133] kernel_clone (kernel/fork.c:2841)
[ 11.585197][ T133] user_mode_thread (kernel/fork.c:2876)
[ 11.585197][ T133] rest_init (init/main.c:712)
[ 11.585197][ T133] start_kernel (init/main.c:1052 (discriminator 1))
[ 11.585197][ T133] x86_64_start_reservations (arch/x86/kernel/head64.c:495)
[ 11.585197][ T133] x86_64_start_kernel (arch/x86/kernel/head64.c:437 (discriminator 17))
[ 11.585197][ T133] common_startup_64 (arch/x86/kernel/head_64.S:415)
[   11.585197][  T133]
[   11.585197][  T133] -> #2 (&rq->__lock){-.-.}-{2:2}:
[ 11.585197][ T133] __lock_acquire (kernel/locking/lockdep.c:5226)
[ 11.585197][ T133] lock_acquire (kernel/locking/lockdep.c:467 kernel/locking/lockdep.c:5851 kernel/locking/lockdep.c:5814)
[ 11.585197][ T133] _raw_spin_lock_nested (kernel/locking/spinlock.c:379)
[ 11.585197][ T133] raw_spin_rq_lock_nested (arch/x86/include/asm/preempt.h:84 kernel/sched/core.c:600)
[ 11.585197][ T133] task_rq_lock (kernel/sched/core.c:718)
[ 11.585197][ T133] cgroup_move_task (kernel/sched/psi.c:1187)
[ 11.585197][ T133] css_set_move_task (kernel/cgroup/cgroup.c:899 (discriminator 3))
[ 11.585197][ T133] cgroup_post_fork (kernel/cgroup/cgroup.c:6697)
[ 11.585197][ T133] copy_process (kernel/fork.c:2622)
[ 11.585197][ T133] kernel_clone (include/linux/random.h:26 kernel/fork.c:2808)
[ 11.585197][ T133] user_mode_thread (kernel/fork.c:2876)
[ 11.585197][ T133] rest_init (init/main.c:712)
[ 11.585197][ T133] start_kernel (init/main.c:1052 (discriminator 1))
[ 11.585197][ T133] x86_64_start_reservations (arch/x86/kernel/head64.c:495)
[ 11.585197][ T133] x86_64_start_kernel (arch/x86/kernel/head64.c:437 (discriminator 17))
[ 11.585197][ T133] common_startup_64 (arch/x86/kernel/head_64.S:415)
[   11.585197][  T133]
[   11.585197][  T133] -> #1 (&p->pi_lock){-.-.}-{2:2}:
[ 11.585197][ T133] __lock_acquire (kernel/locking/lockdep.c:5226)
[ 11.585197][ T133] lock_acquire (kernel/locking/lockdep.c:467 kernel/locking/lockdep.c:5851 kernel/locking/lockdep.c:5814)
[ 11.585197][ T133] _raw_spin_lock_irqsave (include/linux/spinlock_api_smp.h:111 kernel/locking/spinlock.c:162)
[ 11.585197][ T133] try_to_wake_up (kernel/sched/core.c:2197 kernel/sched/core.c:4025 kernel/sched/core.c:4207)
[ 11.585197][ T133] up (kernel/locking/semaphore.c:191)
[ 11.585197][ T133] __up_console_sem (kernel/printk/printk.c:344 (discriminator 1))
[ 11.585197][ T133] console_unlock (kernel/printk/printk.c:2870 kernel/printk/printk.c:3271 kernel/printk/printk.c:3309)
[ 11.585197][ T133] vga_remove_vgacon (drivers/pci/vgaarb.c:188 drivers/pci/vgaarb.c:167)
[ 11.585197][ T133] aperture_remove_conflicting_pci_devices (drivers/video/aperture.c:331 drivers/video/aperture.c:369)
[ 11.585197][ T133] bochs_pci_probe (drivers/gpu/drm/tiny/bochs.c:724)
[ 11.585197][ T133] local_pci_probe (drivers/pci/pci-driver.c:325)
[ 11.585197][ T133] pci_call_probe (drivers/pci/pci-driver.c:392)
[ 11.585197][ T133] pci_device_probe (drivers/pci/pci-driver.c:452)
[ 11.585197][ T133] really_probe (drivers/base/dd.c:579 drivers/base/dd.c:658)
[ 11.585197][ T133] __driver_probe_device (drivers/base/dd.c:800)
[ 11.585197][ T133] driver_probe_device (drivers/base/dd.c:831)
[ 11.585197][ T133] __driver_attach (drivers/base/dd.c:1217)
[ 11.585197][ T133] bus_for_each_dev (drivers/base/bus.c:369)
[ 11.585197][ T133] bus_add_driver (drivers/base/bus.c:676)
[ 11.585197][ T133] driver_register (drivers/base/driver.c:247)
[ 11.585197][ T133] bochs_pci_driver_init (include/drm/drm_module.h:69 drivers/gpu/drm/tiny/bochs.c:806)
[ 11.585197][ T133] do_one_initcall (init/main.c:1267)
[ 11.585197][ T133] do_initcalls (init/main.c:1327 init/main.c:1344)
[ 11.585197][ T133] kernel_init_freeable (init/main.c:1581)
[ 11.585197][ T133] kernel_init (init/main.c:1468)
[ 11.585197][ T133] ret_from_fork (arch/x86/kernel/process.c:153)
[ 11.585197][ T133] ret_from_fork_asm (arch/x86/entry/entry_64.S:254)
[   11.585197][  T133]
[   11.585197][  T133] -> #0 ((console_sem).lock){-...}-{2:2}:
[ 11.585197][ T133] check_prev_add (kernel/locking/lockdep.c:3162)
[ 11.585197][ T133] validate_chain (kernel/locking/lockdep.c:3281 kernel/locking/lockdep.c:3904)
[ 11.585197][ T133] __lock_acquire (kernel/locking/lockdep.c:5226)
[ 11.585197][ T133] lock_acquire (kernel/locking/lockdep.c:467 kernel/locking/lockdep.c:5851 kernel/locking/lockdep.c:5814)
[ 11.585197][ T133] _raw_spin_lock_irqsave (include/linux/spinlock_api_smp.h:111 kernel/locking/spinlock.c:162)
[ 11.585197][ T133] down_trylock (kernel/locking/semaphore.c:140)
[ 11.585197][ T133] __down_trylock_console_sem (kernel/printk/printk.c:326)
[ 11.585197][ T133] console_trylock_spinning (kernel/printk/printk.c:2852 kernel/printk/printk.c:2009)
[ 11.585197][ T133] vprintk_emit (kernel/printk/printk.c:2431 kernel/printk/printk.c:2378)
[ 11.585197][ T133] vprintk (kernel/printk/printk_safe.c:86)
[ 11.585197][ T133] _printk (kernel/printk/printk.c:2452)
[ 11.585197][ T133] lookup_object_or_alloc+0x3d4/0x590
[ 11.585197][ T133] __debug_object_init (lib/debugobjects.c:744)
[ 11.585197][ T133] hrtimer_init (kernel/time/hrtimer.c:456 kernel/time/hrtimer.c:1606)
[ 11.585197][ T133] homa_timer_main (net/homa/homa_plumbing.c:971)
[ 11.585197][ T133] kthread (kernel/kthread.c:389)
[ 11.585197][ T133] ret_from_fork (arch/x86/kernel/process.c:153)
[ 11.585197][ T133] ret_from_fork_asm (arch/x86/entry/entry_64.S:254)
[   11.585197][  T133]
[   11.585197][  T133] other info that might help us debug this:
[   11.585197][  T133]
[   11.585197][  T133] Chain exists of:
[   11.585197][  T133]   (console_sem).lock --> &rq->__lock --> &obj_hash[i].lock
[   11.585197][  T133]
[   11.585197][  T133]  Possible unsafe locking scenario:
[   11.585197][  T133]
[   11.585197][  T133]        CPU0                    CPU1
[   11.585197][  T133]        ----                    ----
[   11.585197][  T133]   lock(&obj_hash[i].lock);
[   11.585197][  T133]                                lock(&rq->__lock);
[   11.585197][  T133]                                lock(&obj_hash[i].lock);
[   11.585197][  T133]   lock((console_sem).lock);
[   11.585197][  T133]
[   11.585197][  T133]  *** DEADLOCK ***
[   11.585197][  T133]
[   11.585197][  T133] 1 lock held by homa_timer/133:
[ 11.585197][ T133] #0: ffffffff9165dbb0 (&obj_hash[i].lock){-.-.}-{2:2}, at: __debug_object_init (lib/debugobjects.c:662 lib/debugobjects.c:743)
[   11.585197][  T133]
[   11.585197][  T133] stack backtrace:
[   11.585197][  T133] CPU: 0 UID: 0 PID: 133 Comm: homa_timer Not tainted 6.13.0-rc2-00436-g087197983ce5 #1
[   11.585197][  T133] Hardware name: QEMU Standard PC (i440FX + PIIX, 1996), BIOS 1.16.2-debian-1.16.2-1 04/01/2014
[   11.585197][  T133] Call Trace:
[   11.585197][  T133]  <TASK>
[ 11.585197][ T133] dump_stack_lvl (lib/dump_stack.c:123)
[ 11.585197][ T133] print_circular_bug (kernel/locking/lockdep.c:2077)
[ 11.585197][ T133] check_noncircular (kernel/locking/lockdep.c:2206)
[ 11.585197][ T133] ? print_circular_bug (kernel/locking/lockdep.c:2182)
[ 11.585197][ T133] ? prb_read (kernel/printk/printk_ringbuffer.c:1909)
[ 11.585197][ T133] ? alloc_chain_hlocks (kernel/locking/lockdep.c:3528)
[ 11.585197][ T133] check_prev_add (kernel/locking/lockdep.c:3162)
[ 11.585197][ T133] ? lockdep_lock (arch/x86/include/asm/atomic.h:107 (discriminator 13) include/linux/atomic/atomic-arch-fallback.h:2170 (discriminator 13) include/linux/atomic/atomic-instrumented.h:1302 (discriminator 13) include/asm-generic/qspinlock.h:111 (discriminator 13) kernel/locking/lockdep.c:144 (discriminator 13))
[ 11.585197][ T133] validate_chain (kernel/locking/lockdep.c:3281 kernel/locking/lockdep.c:3904)
[ 11.585197][ T133] ? check_prev_add (kernel/locking/lockdep.c:3860)
[ 11.585197][ T133] ? mark_lock (kernel/locking/lockdep.c:4727 (discriminator 3))
[ 11.585197][ T133] __lock_acquire (kernel/locking/lockdep.c:5226)
[ 11.585197][ T133] lock_acquire (kernel/locking/lockdep.c:467 kernel/locking/lockdep.c:5851 kernel/locking/lockdep.c:5814)
[ 11.585197][ T133] ? down_trylock (kernel/locking/semaphore.c:140)
[ 11.585197][ T133] ? lock_sync (kernel/locking/lockdep.c:5817)
[ 11.585197][ T133] ? validate_chain (kernel/locking/lockdep.c:3797 kernel/locking/lockdep.c:3817 kernel/locking/lockdep.c:3872)
[ 11.585197][ T133] _raw_spin_lock_irqsave (include/linux/spinlock_api_smp.h:111 kernel/locking/spinlock.c:162)
[ 11.585197][ T133] ? down_trylock (kernel/locking/semaphore.c:140)
[ 11.585197][ T133] ? vprintk_emit (kernel/printk/printk.c:2431 kernel/printk/printk.c:2378)
[ 11.585197][ T133] down_trylock (kernel/locking/semaphore.c:140)
[ 11.585197][ T133] __down_trylock_console_sem (kernel/printk/printk.c:326)
[ 11.585197][ T133] console_trylock_spinning (kernel/printk/printk.c:2852 kernel/printk/printk.c:2009)
[ 11.585197][ T133] vprintk_emit (kernel/printk/printk.c:2431 kernel/printk/printk.c:2378)
[ 11.585197][ T133] ? wake_up_klogd_work_func (kernel/printk/printk.c:2381)
[ 11.585197][ T133] vprintk (kernel/printk/printk_safe.c:86)
[ 11.585197][ T133] _printk (kernel/printk/printk.c:2452)
[ 11.585197][ T133] ? printk_get_console_flush_type (kernel/printk/printk.c:2452)


The kernel config and materials to reproduce are available at:
https://download.01.org/0day-ci/archive/20241225/202412251044.574ee2c0-lkp@intel.com



-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki


