Return-Path: <netdev+bounces-98619-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id D8F0B8D1E1B
	for <lists+netdev@lfdr.de>; Tue, 28 May 2024 16:11:45 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 4EB361F232F6
	for <lists+netdev@lfdr.de>; Tue, 28 May 2024 14:11:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2548616F851;
	Tue, 28 May 2024 14:11:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="e26Iooeb"
X-Original-To: netdev@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 92AA916F283
	for <netdev@vger.kernel.org>; Tue, 28 May 2024 14:11:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=198.175.65.12
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716905492; cv=fail; b=HcQabKi48Dnev/O0MUDUuvkEdJ2SZZ2G1Znwi7fxDiZtBSPMG6iS1bVHDSuxrv0tIbzKBZZIZA36c7ziKiSno7h9Pl4W03lGm6DdXamgInrEUB79bcZ66gVNahvADbKAmYi1ew/r+LLdOSmvdfXZXOkXeAE0gKsQkFE2p7IMF/M=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716905492; c=relaxed/simple;
	bh=/PEvB5TV8tu+E2tuBXQek1pGwx/DGL9LmencBfeYZfo=;
	h=Date:From:To:CC:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=ZiOgWip8I5ytFAMAAWXOPzIUxYSIup9N5MmsELUympSZp6wSfUYVj/ZCLNExrVCdmu7d9ZcfyoWczfGqB5nNxXt5mHKMpynyejVZ3A6Bck6kP5ufXVlQa36r5opWIugY9OJwJNDrsWr65NMa0G9whg25wQvCeMp7pZ7voOSOzlI=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=e26Iooeb; arc=fail smtp.client-ip=198.175.65.12
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1716905490; x=1748441490;
  h=date:from:to:cc:subject:message-id:references:
   in-reply-to:mime-version;
  bh=/PEvB5TV8tu+E2tuBXQek1pGwx/DGL9LmencBfeYZfo=;
  b=e26Iooeb+P82gl4XJxcT/ls0kCYdSKs60B1AAlwMSSi8hudwCIn5GLJi
   4aYJ+s0/acPvlqEC9Efl+1FE/HtYhZT4GSblcal6V6QhksMHkPFZIH9p+
   QnNex3fSfaiv1MEfOBHUK8BodwU6YRl88Hy2fL62PoGYTcqGHDXrKc/g+
   IoshrM4gqkJLKJNfMqoS6DQvGbT/aYQ4pv7JJcqDsL5ujxmCJK45b6yNn
   eHGD8MTAMSBs1SYQXH0lLis6fa0Hifnnt3X0WYTj7gbDxVJ6DYV56WqqK
   YyPTjiw7JSJJIKX+J0MD2sFnvg4vTukqygZyB/A52zx1MqGd8n87fiISS
   w==;
X-CSE-ConnectionGUID: wO1ZQQymRq2vWDXhc2c9ow==
X-CSE-MsgGUID: 0mcUvtcpTgqRMqdagmjiRg==
X-IronPort-AV: E=McAfee;i="6600,9927,11085"; a="24666551"
X-IronPort-AV: E=Sophos;i="6.08,195,1712646000"; 
   d="scan'208";a="24666551"
Received: from orviesa002.jf.intel.com ([10.64.159.142])
  by orvoesa104.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 28 May 2024 07:11:29 -0700
X-CSE-ConnectionGUID: eTBozBZ2QhON3p/6qnVqxQ==
X-CSE-MsgGUID: rGZT648JQBSlHEQymzTnjA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.08,195,1712646000"; 
   d="scan'208";a="65924274"
Received: from orsmsx603.amr.corp.intel.com ([10.22.229.16])
  by orviesa002.jf.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 28 May 2024 07:11:30 -0700
Received: from orsmsx610.amr.corp.intel.com (10.22.229.23) by
 ORSMSX603.amr.corp.intel.com (10.22.229.16) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39; Tue, 28 May 2024 07:11:28 -0700
Received: from ORSEDG602.ED.cps.intel.com (10.7.248.7) by
 orsmsx610.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39 via Frontend Transport; Tue, 28 May 2024 07:11:28 -0700
Received: from NAM11-DM6-obe.outbound.protection.outlook.com (104.47.57.169)
 by edgegateway.intel.com (134.134.137.103) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.39; Tue, 28 May 2024 07:11:28 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=OEtRiEWuoooQy9yEAfEsWjxzI5Tq6pN4vgd1z+mdHeFBT2XP8mVKAxaK1q6LcvBZ1k1EfKip/LjpaC5dmkyAr/l8wdiWFJ+Cq1kY3/4u1kJ8Yy5YUA9XgkLL1yBwEVwjFEl6WpJ/zq+88hxDNXP2BGdTHDNoy7YnDyxspsXuQ2avj6qJaivAEJHocr7/0JfU5Rn1gWHDrR76/c4JZkvgfLMhW5aKryZIC7Mji+igH755TPgZW5lSybM/Af+sAlco1aDT20rEJ95eBOhrH2vCPeeU5msUn8m387bpqBrKMbS/wUBbJijp/FK90GPuQ3aUqz5K7gC9HlqDYm7IsLyYJw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=kzioxfrYRhpD7t5j8XAMTH152we0oBgtplAEK5io9cM=;
 b=bIMSvfKrpFBv+6YevdoJf78oq6zwXt83kG5VLRbwEy4xV1yNSlp0mujG+XdQqBie6OJm5DOxAgdR5ydazl09NL6o4xBmnU+6bhHVktOm3cs5yF9gaqIVg+zZabB/m/4d1oUkhsbb/YtsRHQcG8nt/yo+SaTqFh/u8ISba9CFXZpevPMCDy0kUPK6T7oE9yH590y1vD4+lgRjPjd0Pr/YRfowszkPjThdGoaGh6Vv7mJaeVHqmC0jtFM8tdWnyhBWRWQmwZvLMKzKSUfhg+lBVfHSfrgNeqYFkXRsYgN39ZcivcKSPOQ2wA0xm+9MijdBpi4vKjo6UGeDMTozJM32jg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from SN7PR11MB7540.namprd11.prod.outlook.com (2603:10b6:806:340::7)
 by SA1PR11MB7064.namprd11.prod.outlook.com (2603:10b6:806:2b7::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7633.17; Tue, 28 May
 2024 14:11:26 +0000
Received: from SN7PR11MB7540.namprd11.prod.outlook.com
 ([fe80::399f:ff7c:adb2:8d29]) by SN7PR11MB7540.namprd11.prod.outlook.com
 ([fe80::399f:ff7c:adb2:8d29%3]) with mapi id 15.20.7611.025; Tue, 28 May 2024
 14:11:26 +0000
Date: Tue, 28 May 2024 16:11:21 +0200
From: Larysa Zaremba <larysa.zaremba@intel.com>
To: Maciej Fijalkowski <maciej.fijalkowski@intel.com>
CC: <intel-wired-lan@lists.osuosl.org>, <netdev@vger.kernel.org>,
	<anthony.l.nguyen@intel.com>, <magnus.karlsson@intel.com>,
	<michal.kubiak@intel.com>
Subject: Re: [PATCH iwl-net 11/11] ice: protect ring configuration with a
 mutex
Message-ID: <ZlXmCRoJRhe1T4aI@lzaremba-mobl.ger.corp.intel.com>
References: <20240528131429.3012910-1-maciej.fijalkowski@intel.com>
 <20240528131429.3012910-12-maciej.fijalkowski@intel.com>
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <20240528131429.3012910-12-maciej.fijalkowski@intel.com>
X-ClientProxiedBy: ZR2P278CA0024.CHEP278.PROD.OUTLOOK.COM
 (2603:10a6:910:46::13) To SN7PR11MB7540.namprd11.prod.outlook.com
 (2603:10b6:806:340::7)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SN7PR11MB7540:EE_|SA1PR11MB7064:EE_
X-MS-Office365-Filtering-Correlation-Id: 1b9c6ed0-e3df-4219-2968-08dc7f200fed
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230031|366007|1800799015|376005;
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?CBb2lE0x6F0JvDiQXgU6485jLyDgwjRXeAGeS/p6/mGgMBjY47EvF5BNnUdq?=
 =?us-ascii?Q?0blh2xdG9SPmXHLL/eK0URBWWNck5rHpkCS4LLDmm3ULwptjNE97g2wgVMLn?=
 =?us-ascii?Q?wuhvEE7IPdYJruyESE+GP1DjuOX8B79vDisHmqv9YOz3nz0ugpWzZGQfeZ+b?=
 =?us-ascii?Q?O939gKw0F4JeKGA1Ck1t/3NRaHrAlx6G4zgM+yQyfuDEsdvmJntHtvXCkzV8?=
 =?us-ascii?Q?zLIhdTO9SeSTETdmUqg73je28n4lf0zTuZ7xCPF63+0AizUn/0Z+5GiSesHD?=
 =?us-ascii?Q?vy/qEfSiy+7XXNjnDGeSKB+1TX8JWOI6pFJpdVAnJPYOFj31ld6njnmXHU+j?=
 =?us-ascii?Q?WwiopmfxFWBejo9ALWheHDZ06hIrZNujzoi7IszuOkq30XcIS8Z7Kr1DLJHs?=
 =?us-ascii?Q?W7MKhmkxXTBx8HeKCkji1SDrARsNnk+Hx8Sn3lrRoJbfdDsfI7/LVkcmmHRr?=
 =?us-ascii?Q?2CZ9K1lTOQcMuWvNuJsN+AKzO3bxbaQ0Ah2p4lq10NhYmzWbGAuWOokEyF/W?=
 =?us-ascii?Q?GS5+1LQAJ8POnLbTAqKm6hTZXxU0/XV4lbiqG8X5QIY/XcSu8tL0WowTdowO?=
 =?us-ascii?Q?80LJ0Pc+6zZP3mTTYoKnK/XqufK6bChdgMzW4SozyXp+LDGbQnycfofW6Bem?=
 =?us-ascii?Q?I+3HO8hF7IAHX/wWpUs6mSg229yynHRlOnTL5OI27ZT7MELKRDM86TK+z/dR?=
 =?us-ascii?Q?5o5LFS7ttTnuRGXDVCLNdKy77yaizqVbYXnDMX4JYqPq6jnl3SIjFTPTUHsT?=
 =?us-ascii?Q?Kh1VcmppJqt6hkAEycUDtus0We8iV8pMa5IXrT3LkDeVUGa1X6GM3Rn16inc?=
 =?us-ascii?Q?72Bvilf7MxLKb/IUQ74rwqIjbvx7mmsWrql5FTDb82clWiUgtVC09uUIiYOn?=
 =?us-ascii?Q?HnaHWtakTFcRi7LsiNUaZOiOyhU7Lbya8YQIrUAPkKBCtIL/lUiK6wXpz9Zh?=
 =?us-ascii?Q?0IO5Gwrq9AoqMbdXebFJry7BWS8Rk3RH/3v6oY5PenewSykcbBFx6xx4gVMC?=
 =?us-ascii?Q?393KCAzVbZSMkNWWf5x0sCT7DnK9ufXmlSca+8weS9rIbyv8mfzRPafVOZ3e?=
 =?us-ascii?Q?UPnih/qY3fOXX/pkCU/R5DluMw/m0FmboUZLMRITEVFxUAhFnts7+XROdhlr?=
 =?us-ascii?Q?tZjlu4TNoKVfFC9wRiKvjeDEUZDndhj0q05w6hKQZeJOjoXadgQERWdgNsUj?=
 =?us-ascii?Q?VrzuC6Ixtgaq+sU155D6LwhGVnqD6yk27SSkyP9EGYmhZp3Sc7AxWcc3OAid?=
 =?us-ascii?Q?lT2rcpibyG1SktUAiK5z0fS+K+sE5kn0F0ZDpTh6nQ=3D=3D?=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SN7PR11MB7540.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(366007)(1800799015)(376005);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?G0eYenGcPfDjf/6D/zn+kSU8/OQtBsAcQwNb+frTfZ+8sKzWCwnXB0NmdoeV?=
 =?us-ascii?Q?rpo7Aw+d4akyNzV8Hs4nTTo2abqax2O68PL2r6yigRtNrSm/2BoQxbSy+KIc?=
 =?us-ascii?Q?DvlRerGLuOoiGs3eoIf3AdUbFY+EXduPW49fIlkXL63ic6mjW4vscGQ3YPBg?=
 =?us-ascii?Q?HsUL4Bv+JuNDb5sBA1Tfbl0syUu5TMeD48eWtzJV4/1NMTwMBZwzU9VGlkWP?=
 =?us-ascii?Q?XAzXIOfQI5sBf+uLrsuQFW0GqAn7sGf2XX2gWNFsN3+2OcYOMeYmpcWbgv2Y?=
 =?us-ascii?Q?fJ3DE8KJibYWSNIynn8BhAaTEngm0b1YS0nzMPGOroaPpkRfQ8HQSRvsxTix?=
 =?us-ascii?Q?fRSu1ZoptqE9u7sDgtdz1ElHN6i4avAP/Uw8G3PF7uw+za/mnwfe0qDiMcZ8?=
 =?us-ascii?Q?p5lnsT815FtwS+J/1iRUWoVYI/LJ7nqThujaUhinSmkv7nrNRGPo4x1EktNP?=
 =?us-ascii?Q?BTkXmKr5IO/HkW7iF9N14KmDHlQooqCA04rLjh8W0IILzEZbuu8DzBgAoGpg?=
 =?us-ascii?Q?NZf8l/BO0cGxV6XWvrFT9K72vzJ9ZPcVyO1q5TZubMurj5glcbolb0WgLdlZ?=
 =?us-ascii?Q?5ch2/Cjxcp1fCv/46tEZr/hhZfWmP+PjWebRFDAzjPQeCWav7ly4EFR4Fp9p?=
 =?us-ascii?Q?hMlbLgjmqdE1jB1mrQ4qOOdKs/f8ZqiMaa9zILk3+We3K/jST1Cd7XjBZM3b?=
 =?us-ascii?Q?lm/QN6/s/GtPQ29CD6cJOEp0BKh3q0V7yk9byKIpEMw7iAKr8mTl1Nhtt69u?=
 =?us-ascii?Q?cc4H80n/JV1N/1oo5xN8zH9ydog0O+L6e6BhqejHawpi+Nj6h5fkcwk5oWVu?=
 =?us-ascii?Q?08pKptC9z/LL5m+OxBrJWDUFDBkGH22kfN32HVg77JTbGRIrVCfytKLBsWgV?=
 =?us-ascii?Q?rm+tuPTXDnWhgAlzTDI60KNNri2eEwotOLAl9g64k2FKiJ5uy3dE7aBoM8nb?=
 =?us-ascii?Q?3heB1NYhlezfPYzoX6IRLobRBaajHeLywyWzjBrgv6BBe3Hu9+kJicXrShOe?=
 =?us-ascii?Q?8AvjGVdPU4rQ0aax18NgwIcNout/dqtnGzCotF7m+c4nAPaGE9FK6ZVyYie/?=
 =?us-ascii?Q?D1H9/IZ7HlL2CrN9g0RNf5tiBktlKKLaAod0gMKs0EfhSIBVqQDRyn7BvMVf?=
 =?us-ascii?Q?YbSq1JJpn2W04ba/869g/5aCoSE9cvYPvvw8jh3pnG9h92IZgcLVhiucRyL6?=
 =?us-ascii?Q?jHmqNt3Du0dQZ0M0B3WHtjlCTKpUx46U9x3S8wmbX5LF3Hp0oWsrd7tPf+Mv?=
 =?us-ascii?Q?YPi7MYMUb9GDEvK4sJRydV3scNqysYLg7l/crCHZe/+6oIxmaS79CQMRE2VT?=
 =?us-ascii?Q?Njiphe6U8xSwr+BL8mubtf50/Sj7fC8VSiFmrLwyhnCUUmm0YWYMV3rEfmHM?=
 =?us-ascii?Q?xd6JEbjlXAbumHEu4TJu+CWhFUg2f7MZcioN7A1IW0T1j1oqH0G9wXy1OQot?=
 =?us-ascii?Q?u2CS1lW3Jq/luqXe+oCexzQ/mQXa8X0wF8EC0xVuFVVFRS8jG4/1o4+ra1b7?=
 =?us-ascii?Q?sgqW8OtZ56R3B2kkkCQD7JebbyoCAxwtrRbTuJn4kYQI7jo9O9POcfnI2h+g?=
 =?us-ascii?Q?yKpUMFFdmsdibYLxvkdajNPKOfUnXqC9ylYs17/xrpysboEXuUqJebm0Dgxv?=
 =?us-ascii?Q?5Q=3D=3D?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 1b9c6ed0-e3df-4219-2968-08dc7f200fed
X-MS-Exchange-CrossTenant-AuthSource: SN7PR11MB7540.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 28 May 2024 14:11:26.4954
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: /JZFW7JuXAfrptBWOg9+vxXJa+0vfYfmoqj43T9vdoAWm9EnNVET27zbPXnFBbQCjXW4EOmXoGsOOS+chQzwhw9GKgqrzQZbCmVWhZpF1+U=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA1PR11MB7064
X-OriginatorOrg: intel.com

On Tue, May 28, 2024 at 03:14:29PM +0200, Maciej Fijalkowski wrote:
> From: Larysa Zaremba <larysa.zaremba@intel.com>
> 
> Add a ring_lock mutex to protect sections, where software rings are
> affected. Particularly, to prevent system crash, when tx_timeout
> and .ndo_bpf() happen at the same time.
> 
> Fixes: 2d4238f55697 ("ice: Add support for AF_XDP")
> Signed-off-by: Larysa Zaremba <larysa.zaremba@intel.com>

This is not the latest version of my patches. Code is the same, but newer 
version has better patch division and more relevant commit messages. Maciej will 
update the patches in v2.

> ---
>  drivers/net/ethernet/intel/ice/ice.h      |  2 ++
>  drivers/net/ethernet/intel/ice/ice_lib.c  | 23 ++++++++++---
>  drivers/net/ethernet/intel/ice/ice_main.c | 39 ++++++++++++++++++++---
>  drivers/net/ethernet/intel/ice/ice_xsk.c  | 13 ++------
>  4 files changed, 57 insertions(+), 20 deletions(-)
> 
> diff --git a/drivers/net/ethernet/intel/ice/ice.h b/drivers/net/ethernet/intel/ice/ice.h
> index 701a61d791dd..7c1e24afa34b 100644
> --- a/drivers/net/ethernet/intel/ice/ice.h
> +++ b/drivers/net/ethernet/intel/ice/ice.h
> @@ -307,6 +307,7 @@ enum ice_pf_state {
>  	ICE_PHY_INIT_COMPLETE,
>  	ICE_FD_VF_FLUSH_CTX,		/* set at FD Rx IRQ or timeout */
>  	ICE_AUX_ERR_PENDING,
> +	ICE_RTNL_WAITS_FOR_RESET,
>  	ICE_STATE_NBITS		/* must be last */
>  };
>  
> @@ -941,6 +942,7 @@ int ice_prepare_xdp_rings(struct ice_vsi *vsi, struct bpf_prog *prog,
>  			  enum ice_xdp_cfg cfg_type);
>  int ice_destroy_xdp_rings(struct ice_vsi *vsi, enum ice_xdp_cfg cfg_type);
>  void ice_map_xdp_rings(struct ice_vsi *vsi);
> +bool ice_rebuild_pending(struct ice_vsi *vsi);
>  int
>  ice_xdp_xmit(struct net_device *dev, int n, struct xdp_frame **frames,
>  	     u32 flags);
> diff --git a/drivers/net/ethernet/intel/ice/ice_lib.c b/drivers/net/ethernet/intel/ice/ice_lib.c
> index 7629b0190578..a5dc6fc6e63d 100644
> --- a/drivers/net/ethernet/intel/ice/ice_lib.c
> +++ b/drivers/net/ethernet/intel/ice/ice_lib.c
> @@ -2426,7 +2426,10 @@ void ice_vsi_decfg(struct ice_vsi *vsi)
>  		dev_err(ice_pf_to_dev(pf), "Failed to remove RDMA scheduler config for VSI %u, err %d\n",
>  			vsi->vsi_num, err);
>  
> -	if (ice_is_xdp_ena_vsi(vsi))
> +	/* xdp_rings can be absent, if program was attached amid reset,
> +	 * VSI rebuild is supposed to create them later
> +	 */
> +	if (ice_is_xdp_ena_vsi(vsi) && vsi->xdp_rings)
>  		/* return value check can be skipped here, it always returns
>  		 * 0 if reset is in progress
>  		 */
> @@ -2737,12 +2740,24 @@ ice_queue_set_napi(struct ice_vsi *vsi, unsigned int queue_index,
>  	if (current_work() == &pf->serv_task ||
>  	    test_bit(ICE_PREPARED_FOR_RESET, pf->state) ||
>  	    test_bit(ICE_DOWN, pf->state) ||
> -	    test_bit(ICE_SUSPENDED, pf->state))
> +	    test_bit(ICE_SUSPENDED, pf->state)) {
> +		bool rtnl_held_here = true;
> +
> +		while (!rtnl_trylock()) {
> +			if (test_bit(ICE_RTNL_WAITS_FOR_RESET, pf->state)) {
> +				rtnl_held_here = false;
> +				break;
> +			}
> +			usleep_range(1000, 2000);
> +		}
>  		__ice_queue_set_napi(vsi->netdev, queue_index, type, napi,
> -				     false);
> -	else
> +				     true);
> +		if (rtnl_held_here)
> +			rtnl_unlock();
> +	} else {
>  		__ice_queue_set_napi(vsi->netdev, queue_index, type, napi,
>  				     true);
> +	}
>  }
>  
>  /**
> diff --git a/drivers/net/ethernet/intel/ice/ice_main.c b/drivers/net/ethernet/intel/ice/ice_main.c
> index 15a6805ac2a1..7724ed8fc1b1 100644
> --- a/drivers/net/ethernet/intel/ice/ice_main.c
> +++ b/drivers/net/ethernet/intel/ice/ice_main.c
> @@ -2986,6 +2986,20 @@ static int ice_max_xdp_frame_size(struct ice_vsi *vsi)
>  		return ICE_RXBUF_3072;
>  }
>  
> +/**
> + * ice_rebuild_pending - ice_vsi_rebuild will be performed, when locks are released
> + * @vsi: VSI to setup XDP for
> + *
> + * ice_vsi_close() in the reset path is called under rtnl_lock(),
> + * so it happened strictly before or after .ndo_bpf().
> + * In case it has happened before, we do not have anything attached to rings
> + */
> +bool ice_rebuild_pending(struct ice_vsi *vsi)
> +{
> +	return ice_is_reset_in_progress(vsi->back->state) &&
> +	       !vsi->rx_rings[0]->desc;
> +}
> +
>  /**
>   * ice_xdp_setup_prog - Add or remove XDP eBPF program
>   * @vsi: VSI to setup XDP for
> @@ -3009,7 +3023,7 @@ ice_xdp_setup_prog(struct ice_vsi *vsi, struct bpf_prog *prog,
>  	}
>  
>  	/* hot swap progs and avoid toggling link */
> -	if (ice_is_xdp_ena_vsi(vsi) == !!prog) {
> +	if (ice_is_xdp_ena_vsi(vsi) == !!prog || ice_rebuild_pending(vsi)) {
>  		ice_vsi_assign_bpf_prog(vsi, prog);
>  		return 0;
>  	}
> @@ -3081,21 +3095,33 @@ static int ice_xdp(struct net_device *dev, struct netdev_bpf *xdp)
>  {
>  	struct ice_netdev_priv *np = netdev_priv(dev);
>  	struct ice_vsi *vsi = np->vsi;
> +	struct ice_pf *pf = vsi->back;
> +	int ret;
>  
>  	if (vsi->type != ICE_VSI_PF) {
>  		NL_SET_ERR_MSG_MOD(xdp->extack, "XDP can be loaded only on PF VSI");
>  		return -EINVAL;
>  	}
>  
> +	while (test_and_set_bit(ICE_CFG_BUSY, pf->state)) {
> +		set_bit(ICE_RTNL_WAITS_FOR_RESET, pf->state);
> +		usleep_range(1000, 2000);
> +	}
> +	clear_bit(ICE_RTNL_WAITS_FOR_RESET, pf->state);
> +
>  	switch (xdp->command) {
>  	case XDP_SETUP_PROG:
> -		return ice_xdp_setup_prog(vsi, xdp->prog, xdp->extack);
> +		ret = ice_xdp_setup_prog(vsi, xdp->prog, xdp->extack);
> +		break;
>  	case XDP_SETUP_XSK_POOL:
> -		return ice_xsk_pool_setup(vsi, xdp->xsk.pool,
> -					  xdp->xsk.queue_id);
> +		ret = ice_xsk_pool_setup(vsi, xdp->xsk.pool, xdp->xsk.queue_id);
> +		break;
>  	default:
> -		return -EINVAL;
> +		ret = -EINVAL;
>  	}
> +
> +	clear_bit(ICE_CFG_BUSY, pf->state);
> +	return ret;
>  }
>  
>  /**
> @@ -7672,7 +7698,10 @@ static void ice_rebuild(struct ice_pf *pf, enum ice_reset_req reset_type)
>  		ice_gnss_init(pf);
>  
>  	/* rebuild PF VSI */
> +	while (test_and_set_bit(ICE_CFG_BUSY, pf->state))
> +		usleep_range(1000, 2000);
>  	err = ice_vsi_rebuild_by_type(pf, ICE_VSI_PF);
> +	clear_bit(ICE_CFG_BUSY, pf->state);
>  	if (err) {
>  		dev_err(dev, "PF VSI rebuild failed: %d\n", err);
>  		goto err_vsi_rebuild;
> diff --git a/drivers/net/ethernet/intel/ice/ice_xsk.c b/drivers/net/ethernet/intel/ice/ice_xsk.c
> index 225d027d3d7a..962af14f9fd5 100644
> --- a/drivers/net/ethernet/intel/ice/ice_xsk.c
> +++ b/drivers/net/ethernet/intel/ice/ice_xsk.c
> @@ -370,7 +370,6 @@ int ice_xsk_pool_setup(struct ice_vsi *vsi, struct xsk_buff_pool *pool, u16 qid)
>  {
>  	bool if_running, pool_present = !!pool;
>  	int ret = 0, pool_failure = 0;
> -	struct ice_pf *pf = vsi->back;
>  
>  	if (qid >= vsi->num_rxq || qid >= vsi->num_txq) {
>  		netdev_err(vsi->netdev, "Please use queue id in scope of combined queues count\n");
> @@ -378,18 +377,11 @@ int ice_xsk_pool_setup(struct ice_vsi *vsi, struct xsk_buff_pool *pool, u16 qid)
>  		goto failure;
>  	}
>  
> -	if_running = netif_running(vsi->netdev) && ice_is_xdp_ena_vsi(vsi);
> +	if_running = !ice_rebuild_pending(vsi) &&
> +		     (netif_running(vsi->netdev) && ice_is_xdp_ena_vsi(vsi));
>  
>  	if (if_running) {
>  		struct ice_rx_ring *rx_ring = vsi->rx_rings[qid];
> -		int timeout = 50;
> -
> -		while (test_and_set_bit(ICE_CFG_BUSY, pf->state)) {
> -			timeout--;
> -			if (!timeout)
> -				return -EBUSY;
> -			usleep_range(1000, 2000);
> -		}
>  
>  		ret = ice_qp_dis(vsi, qid);
>  		if (ret) {
> @@ -412,7 +404,6 @@ int ice_xsk_pool_setup(struct ice_vsi *vsi, struct xsk_buff_pool *pool, u16 qid)
>  			napi_schedule(&vsi->rx_rings[qid]->xdp_ring->q_vector->napi);
>  		else if (ret)
>  			netdev_err(vsi->netdev, "ice_qp_ena error = %d\n", ret);
> -		clear_bit(ICE_CFG_BUSY, pf->state);
>  	}
>  
>  failure:
> -- 
> 2.34.1
> 

