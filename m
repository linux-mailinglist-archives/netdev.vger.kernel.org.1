Return-Path: <netdev+bounces-301929-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id rsfqOZsEPWpevwgAu9opvQ
	(envelope-from <netdev+bounces-301929-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Thu, 25 Jun 2026 12:36:11 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 462176C4B1F
	for <lists+netdev@lfdr.de>; Thu, 25 Jun 2026 12:36:11 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=intel.com header.s=Intel header.b=X5hpLR7u;
	spf=pass (mail.lfdr.de: domain of "netdev+bounces-301929-lists+netdev=lfdr.de@vger.kernel.org" designates 2600:3c0a:e001:db::12fc:5321 as permitted sender) smtp.mailfrom="netdev+bounces-301929-lists+netdev=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=none) header.from=intel.com;
	arc=reject ("cv is fail on i=2")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 7D039303DAAB
	for <lists+netdev@lfdr.de>; Thu, 25 Jun 2026 10:35:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C84B33D16FB;
	Thu, 25 Jun 2026 10:35:24 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.10])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 68B3A373BE7;
	Thu, 25 Jun 2026 10:35:23 +0000 (UTC)
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782383724; cv=fail; b=oUldHqvu1y3tCABDUJgXGWxuHldXP94r38ydWAO3yA9r7TcG0F2V9qDYJOS+hNPby/ueYKXEOBXYst/PaI6o/R1BY1WFQsnezpdGy6MjgQHwxJzcQPOsJ0zWdROb88PWM4LsvxYjPiIhJOraoI4wl/jiZUvtpfPgldkZdN9CseI=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782383724; c=relaxed/simple;
	bh=zg+G31gu5iktvMQX9Hm/p1oniqbgypAvc0QqP76LemY=;
	h=Date:From:To:CC:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=Y6oOoy4M7c3whqXHX5EzdbGIcBHtkriUdl+i4mU9IAJcnbH2aBJAaNIGYmPhM6yYgDR4G/ab5eSu8AVlXTy57Patxx0AkCTze4KamEIZoE3H/Sfj/ZIZlQSNW1rg13DjafEnsDD5CgCAzzkj+qmkeG5ciLhbmV8mL8mXiHVj7YU=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=X5hpLR7u; arc=fail smtp.client-ip=192.198.163.10
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1782383723; x=1813919723;
  h=date:from:to:cc:subject:message-id:references:
   in-reply-to:mime-version;
  bh=zg+G31gu5iktvMQX9Hm/p1oniqbgypAvc0QqP76LemY=;
  b=X5hpLR7uyBHGE/DPCfX9Ao40eQK6fnvPKXm9oW38/cInwxKPi8uoGMmX
   sXfYYmHHIzJ1s7b9ykJwdWotEiODgpms49KN8agfFZr66rhwhfJ57xS0z
   vVzYQVnqoVgzQQm/AcoSA1ciOpJwcg8Y6HzKnKhZW6sGGp0J2I3zfc4mU
   xkDIXbosETr4Vfk7bka3XV7Z0ofBLWJawMHdlH7GB6pYlFxYzQ6d5hkXs
   cSot/ZC0lbpJBeg5AG4UZVwbRoi0bD9PUclRYnpFRYt6y4B3IOY/4du9j
   VSWrj2bdzT/3uN9CpFCPMePZtmDZ0KDagbJaPvx8lTjkkW9afrxXyMwpJ
   w==;
X-CSE-ConnectionGUID: ubRD/oKrTMGtkJJL3sMsCw==
X-CSE-MsgGUID: tDNzkwhLQWCHPDsi3ewdBw==
X-IronPort-AV: E=McAfee;i="6800,10657,11827"; a="94553268"
X-IronPort-AV: E=Sophos;i="6.24,224,1774335600"; 
   d="scan'208";a="94553268"
Received: from orviesa002.jf.intel.com ([10.64.159.142])
  by fmvoesa104.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 25 Jun 2026 03:35:22 -0700
X-CSE-ConnectionGUID: Q3c2Apr4T9STlFj4HbqoGw==
X-CSE-MsgGUID: I1QPFctvSHqAkwlZE/zZYw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.24,224,1774335600"; 
   d="scan'208";a="280745142"
Received: from orsmsx903.amr.corp.intel.com ([10.22.229.25])
  by orviesa002.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 25 Jun 2026 03:35:23 -0700
Received: from ORSMSX902.amr.corp.intel.com (10.22.229.24) by
 ORSMSX903.amr.corp.intel.com (10.22.229.25) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.37; Thu, 25 Jun 2026 03:35:21 -0700
Received: from ORSEDG901.ED.cps.intel.com (10.7.248.11) by
 ORSMSX902.amr.corp.intel.com (10.22.229.24) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.37 via Frontend Transport; Thu, 25 Jun 2026 03:35:21 -0700
Received: from PH8PR06CU001.outbound.protection.outlook.com (40.107.209.41) by
 edgegateway.intel.com (134.134.137.111) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.37; Thu, 25 Jun 2026 03:35:21 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=wJZ9Ks0ECwdvyF+oc0eDXDH3EahraM4YHG7usHw7CiBuXf6h3K1JFt8ke9kp+8PtqzbJbrufdZgLjfS7/pa7nJ0cqnoBTJr9HhNVvm257w1uJg0JoBePXEH8RQwN6d9qd81Xve6TrF0U7IYSXo7pknD+ma9ymVECXcdvRohBKFuckGlRsIZvBHPiTQ7f8cJGiC5FgP8iw3FXCP51K3DDmd7GVpDuWoosrr+rmzo1yrUiVK8C3U7OBYWe0ZqshXCALRwLNYmqaIVGYDiNjl4eiTjerV1r8Xjwo0s/wDT5QJOokeVPlEEaab6/V339gUTJyBWgN0WJOk+N9U2PUf+ZuQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=xZREWRrW46wjcn85oTuOYHQaXdCfCtgSo0osIFONZ9Q=;
 b=SL4sEHJMtdp4Dxv9101hBO+HcvJVJ3Dt9/d4kaXUcHWYSFmTjNrckkRJYOAIKNq9k/vE93HOCArAJdtO8TsoALX3NZvSbcQUbQERY0lZNiNtl/EA+pGMrGmS8x2eOv8ceZgvwRx7Fe7x2rVJD/erdN85o07UUTAivFeRoTRe02f9xSWMAurWs0V+IQ64fOoik4ksofAePiURh2/aKL2OzwddfJXNkFBMb4aW1czFv1a1kwF9o8+k9ei+E+MpfVTEfpgOnNZfOMBuwhAwKtBXaEpmNDcS8l89raoexeuMpEISB1ZVS+dc5BSYbvkrCtqgwe9UuzI7XJjww1vbfbYoCw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from IA1PR11MB6097.namprd11.prod.outlook.com (2603:10b6:208:3d7::17)
 by CH3PR11MB8436.namprd11.prod.outlook.com (2603:10b6:610:173::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.139.20; Thu, 25 Jun
 2026 10:35:19 +0000
Received: from IA1PR11MB6097.namprd11.prod.outlook.com
 ([fe80::61e9:afe6:c2c0:722]) by IA1PR11MB6097.namprd11.prod.outlook.com
 ([fe80::61e9:afe6:c2c0:722%3]) with mapi id 15.21.0159.013; Thu, 25 Jun 2026
 10:35:19 +0000
Date: Thu, 25 Jun 2026 12:35:12 +0200
From: Maciej Fijalkowski <maciej.fijalkowski@intel.com>
To: Jakub Kicinski <kuba@kernel.org>
CC: <netdev@vger.kernel.org>, <bpf@vger.kernel.org>,
	<magnus.karlsson@intel.com>, <stfomichev@gmail.com>, <pabeni@redhat.com>,
	<horms@kernel.org>, <tushar.vyavahare@intel.com>, <kerneljasonxing@gmail.com>
Subject: Re: [PATCH net-next] selftests/xsk: preserve UMEM view in bidi test
Message-ID: <aj0EYNt7Sr1dD96N@boxer>
References: <20260623091008.1046547-1-maciej.fijalkowski@intel.com>
 <20260624193326.295e3711@kernel.org>
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <20260624193326.295e3711@kernel.org>
X-ClientProxiedBy: TL0P290CA0008.ISRP290.PROD.OUTLOOK.COM
 (2603:1096:950:5::19) To IA1PR11MB6097.namprd11.prod.outlook.com
 (2603:10b6:208:3d7::17)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: IA1PR11MB6097:EE_|CH3PR11MB8436:EE_
X-MS-Office365-Filtering-Correlation-Id: 7b092bcb-0582-4a80-4a45-08ded2a573fd
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|23010399003|376014|1800799024|366016|18002099003|22082099003|11063799006|4143699003|56012099006;
X-Microsoft-Antispam-Message-Info: nOyUS5LHXo+uUOiSio0nxtgtfTBV4f1E6adoDIUyTegofOUKwLYVBRfP9kZYuQE+Z4V3iDSGw/BPT6Yu1YhZEudy8atf8obNAlHVvWwD4p2Dt5ifY4SNZHjpAROCA/gpPMtHw2EXoM3kNmycUaXxFJRSIfTGuwD76+lnbBBaBKEoAfUj1HyBj99uAOmIyy1JOh8CMz2BpnkMTWREySmM0424k8nQ408UVD5YSg+FE2aOPkib5ignIT5OdWVWQiWF1PMLjqTl4VGIrx1Mz5mRoQFheCwJ3ZHBkbvtTr8NddqCpfRupLOnJRpHQzkJONtGWJY2B5M0bCIdE8+WjcopteYHUE9fTZ6BR+EOnlDTHQ+N/7Ew8u2ebM8HI+5hCbWK938AnAmaqrh8tLqBCd3PkiyH72/XvETHcvE5g0sySjefBRxKyiyGEePasv5/Wn0xBnOJp3AzfUaYr8rugUMNLakha77RzS+JRsgD6CTs2jC5gKUnbyLfaowZe11lS9/KqrbmMyNxVA4dQHPN1VRC/uEqdNi9sNRgsG+GxV2COhB+HNH6hAng/SiI5MjQrwcP5w8PMG8dsmwalPlm6KjumhaEhdPg0owNiCZMVx39cgcbDKDCLY46p42Xl+QXrL0wXfIdw2PdG7vfDrS+9yKVGDS+JNTQeGSjagzEqK02BLE=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:IA1PR11MB6097.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(23010399003)(376014)(1800799024)(366016)(18002099003)(22082099003)(11063799006)(4143699003)(56012099006);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?iCn5LoIk+6jCgI7P++AvVNYNgNwQ1dEIe3BgCSfkoh6IByYzI8HcAvyZgJR/?=
 =?us-ascii?Q?jaOd2mji+vHX1Gq0ExShMbzcf6zmrbR9YneYh4y5/W81b3uZ+jLtrBSmqEFu?=
 =?us-ascii?Q?nze8cZRUqtHH7daAgjH0doLBiev6wgtfwbDM4l1Nk+pO8qYOLqkUA7tOm7NR?=
 =?us-ascii?Q?GZ9uDeeisXBdFLFJ9u5DqiCBClyQeMJAeFWH85GFxUtX0YY81+9TBsKrFGIt?=
 =?us-ascii?Q?GhnPk2mriN/qdVRkc6ShW8llDDIXnTCuO8kYe8UYXElUeBXg8NMyzbtaKh8D?=
 =?us-ascii?Q?Hm5nIwN2gExbxolPcTvN997yxIArtR69BuAZinu04H+WpFlQaPtwlsAOoSIP?=
 =?us-ascii?Q?p7xpu/o2Qf4031bK3LGoYvidXZ5EwFCIKSdh+I0NIbPYFJwLeiqAPLApO5Fp?=
 =?us-ascii?Q?4t6+egzJ2lmUEiFjG48S7lxm+gDGsi/TjEnpUNJybahRmdE8e/QRV3Jj9K+d?=
 =?us-ascii?Q?Kn+3kHbVl9DuBiDmPn9JpvO4kFlz4yzhOuPoU3xi45uT5EVx56DNsnUGL3m2?=
 =?us-ascii?Q?qlaal2F3NXN3jbNWOQGaddgV8DcJawv6HUe4cPpSX3HFukEQODQsBzv2jaQU?=
 =?us-ascii?Q?F8azswRrXw+OBB/A6us2QZpgaAMNUifAivE56ik9G0zbOCncS8Ne45sKi/3b?=
 =?us-ascii?Q?7JyLLf6rGOFkv9GtjllV0uep54jANke4Cgo4ie3GDdLUJTFrsk8pyPyPJoQT?=
 =?us-ascii?Q?qsMoAigHqRZO0eWge0DaXcyLGDK9/kowEzTp4ofO5d3sYsLtw+TTqmq7gR4Z?=
 =?us-ascii?Q?qR3FakNtFfZ9uYqkqDq6XGrZeijO7Q+n1Jr+qVa/gtOvpJDxT3Qq1Zc5KuN/?=
 =?us-ascii?Q?urSUWMSj8QNffmDxrkExwvPgpEdkZ5/TjW3J22tgKfPDkwsECFhcUWKOP9gF?=
 =?us-ascii?Q?IekdblezRKN8cSyKxwbFVcdBGg/+R296QjWi5qKdXJcCcOZpwJNloa1vunzi?=
 =?us-ascii?Q?j4LcPUUEHsnOhzUsOpiYXMc3juuSIbEN5sabGssYr/VTMGuQ053H7nY7W5MT?=
 =?us-ascii?Q?Vy/eR+LztdUcKSjpRoQDtpktlz/F6g7zX7ClcDokitcz5pO0ZnWdNW+hqmcQ?=
 =?us-ascii?Q?MbzdbtjrjKlbth13cM3CaIItGilxEw+0dTv148ak31Txw/ne9ESSiKbD9Z8b?=
 =?us-ascii?Q?rXYV3Alc0cccCiuFyR60PhZLd4u3+nGOH+q2OD7/nXh4IVVGnvpX+B0Ta+gv?=
 =?us-ascii?Q?HsqfQQf5LMzMwjZ/CWwsS2E1aSBqJzYoYRIIG/xXI7EDoRch7cUfcJ94M6jk?=
 =?us-ascii?Q?dlERyDt2FnG+40GeFLa9rTAPxcVvYp4G/tVSawtInL+QoGh+pCkhdX07JSpQ?=
 =?us-ascii?Q?c3E27zF6z4zBn0YEPwbT5nQ5r9F7vLO6WLok3FeB+gaEZ7VyTOlQYKcjEZRy?=
 =?us-ascii?Q?9KdMMG9WVkxRAg/LDqq6tAY20ax8idi9aL5miIBH6msFmPfPca0D5P2bY9VK?=
 =?us-ascii?Q?kPFkWVgQTjReeD1ToIi/Wq8dtM1siA6tfVMy4Z3wdq9StgP/my6Q5b0LRbpe?=
 =?us-ascii?Q?TMYypdofPC9SejSjXdiO/xZUtmyLK9k3yNSGfixa74QEW1s7JNli2/3sYa3k?=
 =?us-ascii?Q?P7aql7gpx1PSA3D4sS99wVUw95ihyoqNh1e309laHy0OOrfZIRNOzhRdkOlF?=
 =?us-ascii?Q?YUKGwQCgGV0aWHyBdl/Ywhyxdt5k0LhT/TZjlLedpDgTdDC40NDs3IzzRIl0?=
 =?us-ascii?Q?/pk2hDxWH1FDJQM24TwKhVjB56VD72dDATfbV7eKVcQwQ5goF9xzZqw59Ryf?=
 =?us-ascii?Q?js7sn/SR96IehHarLMpTR3fb2kUVAlw=3D?=
X-Exchange-RoutingPolicyChecked: TpR07zD5yiRTI4VgBo6/Vh3B/Q7EckWsbPYH3qPcVvQpJQ9ZllEgsht/RlnyVJakoa/7nOYgr3TRp9gEwlIXbKh9/W7zfQobNoVw5ysxQ2QVZM14QqFUT18PngtyZQdZ4nuayCzpe6jHas6Vg6vOrWiUId9KlslB8PV1QI3xSyUjp5A9VKuZCMrzE5NkYv6NUfU/B4eyD5DPRA/usMX9EfcPAQ3QG1aqjINkV+yFcbX5o7ckYCdLxBBwvqIAweduzJIG/Plmma4N3x5CnShFJLVfMDVM1DFvYm3KkVMkRZmQH5LzFjTJAtDmooiOUd9NRBfJAxdCKcfNLryAUmfJ9w==
X-MS-Exchange-CrossTenant-Network-Message-Id: 7b092bcb-0582-4a80-4a45-08ded2a573fd
X-MS-Exchange-CrossTenant-AuthSource: IA1PR11MB6097.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 25 Jun 2026 10:35:19.2493
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: oJhIiLe1DWg0J+T/ncat2AO0xSZsJDZH9ijzPt7I5uyiZpuBB80mSse9qxqqwRpx7o55Z3G5lG7zzd6YwHR3dMyY06JqL0A7P/txdKXUuwc=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH3PR11MB8436
X-OriginatorOrg: intel.com
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-2.66 / 15.00];
	WHITELIST_SPF_DKIM(-3.00)[intel.com:d:+,kernel.org:s:+];
	ARC_REJECT(1.00)[cv is fail on i=2];
	MID_RHS_NOT_FQDN(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[intel.com,none];
	R_DKIM_ALLOW(-0.20)[intel.com:s=Intel];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	TAGGED_FROM(0.00)[bounces-301929-lists,netdev=lfdr.de];
	FORWARDED(0.00)[lists@lfdr.de];
	FORGED_SENDER(0.00)[maciej.fijalkowski@intel.com,netdev@vger.kernel.org];
	FORGED_SENDER_MAILLIST(0.00)[];
	FREEMAIL_CC(0.00)[vger.kernel.org,intel.com,gmail.com,redhat.com,kernel.org];
	FORGED_RECIPIENTS(0.00)[m:kuba@kernel.org,m:netdev@vger.kernel.org,m:bpf@vger.kernel.org,m:magnus.karlsson@intel.com,m:stfomichev@gmail.com,m:pabeni@redhat.com,m:horms@kernel.org,m:tushar.vyavahare@intel.com,m:kerneljasonxing@gmail.com,s:lists@lfdr.de];
	DBL_BLOCKED_OPENRESOLVER(0.00)[intel.com:dkim,intel.com:email,intel.com:from_mime,vger.kernel.org:from_smtp,sea.lore.kernel.org:rdns,sea.lore.kernel.org:helo];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[maciej.fijalkowski@intel.com,netdev@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[intel.com:+];
	ALIAS_RESOLVED(0.00)[];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	MISSING_XM_UA(0.00)[];
	RCPT_COUNT_SEVEN(0.00)[9];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	TAGGED_RCPT(0.00)[netdev];
	RCVD_COUNT_SEVEN(0.00)[10]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 462176C4B1F

On Wed, Jun 24, 2026 at 07:33:26PM -0700, Jakub Kicinski wrote:
> On Tue, 23 Jun 2026 11:10:08 +0200 Maciej Fijalkowski wrote:
> > Subject: [PATCH net-next] selftests/xsk: preserve UMEM view in bidi test
> 
> Do you want it in net? Either way - we'll need a rebase

I have not checked if this has been -net propagated already, but the rule
of thumb on bpf side was that all selftests related effort goes to -next.
Is it different on netdev side?

> 
> > Signed-off-by: Maciej Fijalkowski maciej.fijalkowski@intel.com
> 
> missing <> around the email 

oof.

> 

