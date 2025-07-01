Return-Path: <netdev+bounces-202908-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id AFF16AEF9E7
	for <lists+netdev@lfdr.de>; Tue,  1 Jul 2025 15:11:57 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 0001C1642F6
	for <lists+netdev@lfdr.de>; Tue,  1 Jul 2025 13:11:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 99D1D22094;
	Tue,  1 Jul 2025 13:10:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="AuLxe6dc"
X-Original-To: netdev@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.15])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BBF5B1DFD84
	for <netdev@vger.kernel.org>; Tue,  1 Jul 2025 13:10:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=192.198.163.15
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751375459; cv=fail; b=XujsxCwH6byNGo7P/0hVGySIAzPjb5O0sIU6b3WTdA/gjiPgczF+DPjU7BWNOE6vdHFu69YN6pwZUrn6GKFtvBs51EPhFcxn+NKzeHlqoZUwBJeIi0YsFL4hAnT2NEfnkv97KrntVvt6/j0ZmPXob94k9U65hog2td2vAvCZKdc=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751375459; c=relaxed/simple;
	bh=m9OQ+r0JdFppN5PjZ1B3FmBog4jKNwrk/oqkHbQ+3iQ=;
	h=Date:From:To:CC:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=dxkBjoV1LQ38oV5jTgsFMMQ0vac0KEapV6ViyUoz7DOuUtKXdICSuymsfdlSQZm80dpjfyLHWKIufdmbSFreybrdTirLfNurVNZ1g3mCbIM3fZoDP+/rSBPxVMvN3mNLzJafry/CXkfiwASdU1kY5JdIfibI+HVKWbunRjh4dMI=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=AuLxe6dc; arc=fail smtp.client-ip=192.198.163.15
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1751375458; x=1782911458;
  h=date:from:to:cc:subject:message-id:references:
   in-reply-to:mime-version;
  bh=m9OQ+r0JdFppN5PjZ1B3FmBog4jKNwrk/oqkHbQ+3iQ=;
  b=AuLxe6dcYyOzQlAsgLnRUT0zArkV7wOHl4diejtNT6Ya9baWTw2vMFez
   ViVo+DePgPkm+Gv6mShepZQZlnbXg7KzqlZdmCRTRuoCc4OXsFOTmbJEJ
   /a2l6woH7t0HVqRoUmV7CuP/q2Io5FTW80gpiMUP8u8iwTKzAJbzMIWgu
   uxswKopH0ITweWaJ4VHHApegQXByfDVaRF1mK3fl+MdKbJGOblwBxK7Ga
   iY74hbmizqb/0aeC9p1pfrjgOqBWBsSahQCsHwfy9o0DUNF5WdYZa02M3
   8Ixx6BVrvacG2W/OsG4sXQSoW9/D6CQCyPzrWwMTW1eqmrwAM7tjcv2KI
   A==;
X-CSE-ConnectionGUID: tjBJ/rkdRaiDmqk7bBkjwg==
X-CSE-MsgGUID: VQJeeug2T8eFt6MzOaFN0w==
X-IronPort-AV: E=McAfee;i="6800,10657,11481"; a="53784032"
X-IronPort-AV: E=Sophos;i="6.16,279,1744095600"; 
   d="scan'208";a="53784032"
Received: from orviesa006.jf.intel.com ([10.64.159.146])
  by fmvoesa109.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 01 Jul 2025 06:10:57 -0700
X-CSE-ConnectionGUID: UemnwjwjQGOIaH+ccrEC0Q==
X-CSE-MsgGUID: Rm4tNrZ7SCqKLFQpsVWMSg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.16,279,1744095600"; 
   d="scan'208";a="153239203"
Received: from orsmsx903.amr.corp.intel.com ([10.22.229.25])
  by orviesa006.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 01 Jul 2025 06:10:56 -0700
Received: from ORSMSX902.amr.corp.intel.com (10.22.229.24) by
 ORSMSX903.amr.corp.intel.com (10.22.229.25) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.25; Tue, 1 Jul 2025 06:10:56 -0700
Received: from ORSEDG903.ED.cps.intel.com (10.7.248.13) by
 ORSMSX902.amr.corp.intel.com (10.22.229.24) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.25 via Frontend Transport; Tue, 1 Jul 2025 06:10:56 -0700
Received: from NAM04-BN8-obe.outbound.protection.outlook.com (40.107.100.46)
 by edgegateway.intel.com (134.134.137.113) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.25; Tue, 1 Jul 2025 06:10:55 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=LpnMHueKz6ZEzk6mMrM3PfQ7L/ExUpvVOOxhuWllKL0d+LgXk/68DP7+AOHQdqXfMHIJCUdNze10W0hByjzLxPisx4/h/fX+xPxB+72GHsOWNvjuvHl31a3vfvaokfuTe8ur0MkvE5NaZKxD0JY20RbLOmn0zav4/pwCs9JWaz0YnYpf4bRzY1MKgoPAD52A/9xYe6eS7117A224fhma+RbnonYl1Dvu+qRPfkDq/18l07llHh+p1Wi0XIccTy3qNCSpJbCA9Y9zVemhQGeoNseDHrWnRJewZ3Hf0EWuDafhD+Zq8DRY7AJUqooaxJRvRvROBzxM2q2MNGnH34XVbQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=cEeuvIfihMBuFqZ6iOlv3hmXU6BpPujO5YHNQZ0s61k=;
 b=TkeS1BUxaMGb3jHQ5icMk3W/8rD1IePwd4jF70UGoVR8deo/H/akINORg7LjcajyzHXjyMUrUaBzPmShnnK/P2lBQXQDhHnnbwrtcIjJlhUQzPkRId4YI8RAXKTqYf+j2ol/oN1soiVf9EKDii2OP9jW+YjIcySdb738XVFQ5jSvIfQGevx07YicpoaJXhFwqctknuxWUtjdXvjuqjP0taXfNxu2t8FMODpdSCZc1gKLF6nNmavYKorV7jNbTE00XUJyCS9r2of0DKBlVW7tIqBajwxd/EBKWyiw74NEMsKtwv/bJkYUfU67Ci8q2+QgCHh/x40KMS+GEfQ7fXz++A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from SN7PR11MB7540.namprd11.prod.outlook.com (2603:10b6:806:340::7)
 by DS7PR11MB6270.namprd11.prod.outlook.com (2603:10b6:8:96::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8880.31; Tue, 1 Jul
 2025 13:10:49 +0000
Received: from SN7PR11MB7540.namprd11.prod.outlook.com
 ([fe80::399f:ff7c:adb2:8d29]) by SN7PR11MB7540.namprd11.prod.outlook.com
 ([fe80::399f:ff7c:adb2:8d29%5]) with mapi id 15.20.8880.030; Tue, 1 Jul 2025
 13:10:49 +0000
Date: Tue, 1 Jul 2025 15:10:42 +0200
From: Larysa Zaremba <larysa.zaremba@intel.com>
To: Jiawen Wu <jiawenwu@trustnetic.com>
CC: <netdev@vger.kernel.org>, <andrew+netdev@lunn.ch>, <davem@davemloft.net>,
	<edumazet@google.com>, <kuba@kernel.org>, <pabeni@redhat.com>,
	<horms@kernel.org>, <michal.swiatkowski@linux.intel.com>,
	<mengyuanlou@net-swift.com>, <duanqiangwen@net-swift.com>
Subject: Re: [PATCH net v4 3/3] net: ngbe: specify IRQ vector when the number
 of VFs is 7
Message-ID: <aGPeUqVGbk_EzSgO@soc-5CG4396X81.clients.intel.com>
References: <20250701063030.59340-1-jiawenwu@trustnetic.com>
 <20250701063030.59340-4-jiawenwu@trustnetic.com>
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <20250701063030.59340-4-jiawenwu@trustnetic.com>
X-ClientProxiedBy: VI1PR03CA0057.eurprd03.prod.outlook.com
 (2603:10a6:803:50::28) To SN7PR11MB7540.namprd11.prod.outlook.com
 (2603:10b6:806:340::7)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SN7PR11MB7540:EE_|DS7PR11MB6270:EE_
X-MS-Office365-Filtering-Correlation-Id: 50a65e6a-7095-4ba7-54a5-08ddb8a0b2ef
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|10070799003|1800799024|366016|7416014|376014|7053199007;
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?z/JsMUr6bi6RLGt+z10ptT+IvNcKLoxvv58EQW1jHXnRmg7tThDSKxmg30rk?=
 =?us-ascii?Q?2F3quoQPam+LofL1VcSQz1vrm6jrboYSsGLCaGlqnDH53/++cO2SG2z/iNHV?=
 =?us-ascii?Q?Q1lpEEYfhOXchPH87ei0Z4VzXMabOEUp2b2DxhI6ET+96euV4zCgQIn2KsXL?=
 =?us-ascii?Q?HQkXYt/ZdRS/7zRUfoIAo6uaOEN5UqqjkeDjKZbkFxiihIsRvtUEFfA269Tx?=
 =?us-ascii?Q?YEC0UF8SDhHm5Cf/zLvqT975Ohp6nigLmWlNJQLYs7KakvcNkP1wwd/LHOrU?=
 =?us-ascii?Q?S1+aUMKrswyo/IL4i0Bfa8uYU/X46Lqa0TwIXp65M+QTlXHTZbnnppsIZupc?=
 =?us-ascii?Q?HfZ2fvu+CPgenYWVoexNlSJLHq0X8nmWABQEF2+CrsVeqPA13yrftrubcGYt?=
 =?us-ascii?Q?JJTer/WmNbtJ00hSZtS38QCeiRvTl3Bneo1ZctobiCbI6d/GovfqAK0Alf0V?=
 =?us-ascii?Q?uAY+O+UrWE+6m4qfzHB7EhWl+LiDBVkYz6WT5wx1+xnUg7//9+eGhb1VaiHm?=
 =?us-ascii?Q?vDio/NCzBGquk9bPkrlnHiji5c8Orx8VQh41EhrkYEx4RnvEOJ3kvwNeceGW?=
 =?us-ascii?Q?j+/fP+4p1/epThrGu9akVvYVHamLQrjKSpLJ3M1xWoHjhyZHyLQkAPOOwGu3?=
 =?us-ascii?Q?jysVmncDKIaxIJwtl8nR2gaKYp9IqIrnHRmwkFejfJ67jRq10blQekUl3EvI?=
 =?us-ascii?Q?tH6FLLa1o8JPBr2M0fiCYIKHuuWlpbJcr+jW8dBenJrR8enysSzfAtzD/Ygp?=
 =?us-ascii?Q?A+mBKqTWzw7BsqfAdaSiJlZ+I/GmNq0AUXo5UAak9d0NYMCyjU22BH99O3Gr?=
 =?us-ascii?Q?81ry8QVX9PLRM6jMFK/mBys0zG0KxqA/6a0kYxtvkmtcvUN49fF0KKSPm6gd?=
 =?us-ascii?Q?gAhyDMpsvaVJLlaJG5SQa0CaFI3vnYexYCFTqWQYi90URraOiANI6Hm9i1J8?=
 =?us-ascii?Q?3eX0lSFKF4fCUNU4pGnAV5jNjpoosMIz2PdWZXrACBSC/IO+KdKiyFsTaUUB?=
 =?us-ascii?Q?Vt8EdNT3ziaKgdbaomiduxW/Vn4BAApDEJhGCuAeiWmS0MTDtEWzUJa092to?=
 =?us-ascii?Q?XQqrabxowwhbGdRjBtfUYZaWo/IqcL59yfrCGi+3ZgbNc0cIQkmOMO2f7Qfq?=
 =?us-ascii?Q?Kd9pHE5rP/sTJRb6RdpDGx9/WUNM+sg7NnpFgmPSs5nEvC5QdTFJNmPRM7Ip?=
 =?us-ascii?Q?rR74sLfmJ7Pru3r1sNgTAjKWveMIzbhiRMET5elNEZLWY+t4UTgFs6lZMulV?=
 =?us-ascii?Q?+QR4D36IdDgYIQN7OFe8kPWD6X7hH5JiJHrKYQFlVJcwQRaOhJD7BsCxej1E?=
 =?us-ascii?Q?ibmxDj3FhYQM9hdQA+VzJTJ1ulmSjmQPwOq75/T2FXpS0ks95AyUI9HmgFMK?=
 =?us-ascii?Q?nCif+jC/HBky3uGsFudqcZl3iGZbzhMpUrwu2YMAND3EtujH8nqmyOnLACbP?=
 =?us-ascii?Q?phDZ+OBvN+Q=3D?=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SN7PR11MB7540.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(10070799003)(1800799024)(366016)(7416014)(376014)(7053199007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?UU4jw1SZlz/CCk5hlpoyajWpn20sW7Q1rLbI/EkM4QrnTwEZMznYk/9Q7B6W?=
 =?us-ascii?Q?nLha4pLxDMoIcVg6ElBwE/ZCu/J2cOj4jbGx/4PVlhITR55DDubOa6YJernb?=
 =?us-ascii?Q?223lEbHpD14XdnGpVFcJAmB+RnsPDfwXBdaDYU/8kahyNASQt01HQQT0/+a2?=
 =?us-ascii?Q?oIb/c3YujozqkhiciW9WklbRAga8RhXarhvnDEb7jONcXybhLiG61MwGzHQ5?=
 =?us-ascii?Q?mXUGYqDwF/vH9ePd2Nn6eWkpnparm8Wj9a7z1PyUtx7ICVHUSUzm/RV3n9UW?=
 =?us-ascii?Q?c695lMwPo93dxL5oxeiYu0Ms4MlyJdYCDhcWJyeKyXklX3ByIRJfDJSvFlih?=
 =?us-ascii?Q?6PPwkpLJZ//S74IvS2kfyPNq7TbdcSpoFv0L2fb0PF/XSt95HlPnfowCdm4q?=
 =?us-ascii?Q?d1mmXqKNKvtamjdZdJuCMjleThFXY/+ek02QzM/Drkt9xHl4binvQ7ZJT6aA?=
 =?us-ascii?Q?du61qIxNXHNbduriJDGNjDUjWnZPGTmeubP81UNONtr36AsARrAoe4h5+6Mu?=
 =?us-ascii?Q?VjnrZqO5MkHY8T6SBoy/ahFJoIuMAJKqrMcfWyLKYpGi3xIml2l1crM/Zvol?=
 =?us-ascii?Q?o++tcxi8qMikOf7Tkh1KR1CHCs6GUpSW3PfHIKG4SSfexk7zX3sKbOHKNQf6?=
 =?us-ascii?Q?i8cz6XaYqv/F3FKHIHEigRMKJWhuVcf1mO4LM5mdEhfP77V5xBsVQZpTlhwH?=
 =?us-ascii?Q?eab8JAEZ+Pdw+cSH7LYtObpCnT0UbNYf8DCi2rH+imKEY9plvVrpNp/Oia8y?=
 =?us-ascii?Q?xgwlDy1xYlmUd/dwditPy1fcI1a6ByhO6n4VtYAQO0H2ObWrqURQytckHxOU?=
 =?us-ascii?Q?CKrFGxTyuM7+axhYwSJ2N7GbzTp/SkQqc/XlctozStIRBBFiN25ie0aYgh0y?=
 =?us-ascii?Q?gDBUfvyUsvKEqLg74zYzFgBv6tDw1bV/YR/LUUAuqFrbA2T2PVhPvhh8pf8e?=
 =?us-ascii?Q?3TfFFKnZTNHggng9DTtjMgzl85B3IRgCmVcBEVBP0/UdcmPNpU9VXkgAYIve?=
 =?us-ascii?Q?v5NkM6LsZpUcMcfdx2lutqVCOQRHQl5x5sodtLndDWrw/jv5KhhZugAibGmT?=
 =?us-ascii?Q?B8FPPHxkXuSIkvgcftnTtd6+7FRrhNqN3PZEw1HnGU0Szwi1HDJ7N8W+VM05?=
 =?us-ascii?Q?wwmEiUhn68okRQS15kW8bzLn6dSndBHqw8n2jzw5Ucb8YLt74EqzkyJF3kf0?=
 =?us-ascii?Q?IV5sArZNhSYQnBHINwtTgiCby0+3Qulxz9/XJPC5QbaR92ZA/Vb3C4H4n7IW?=
 =?us-ascii?Q?6zgF75SypiZYuLHKbiBNktVnhHwbw4ZHpsvi667vZ6KOp4lrTyBrjkme4liP?=
 =?us-ascii?Q?g3tPMNHw86ICIJV96rWYqnxttxIxbpy4mLzcpmQQKuflqSvfwqW1zfWEkSKx?=
 =?us-ascii?Q?NwmRII3TN11VJ1/rczr0gvap6jfZQry+5+rE3mUUsaxvsW2nY4TpMCoWJy0k?=
 =?us-ascii?Q?evf+9Ld91rDtncZ4R6UbZ5E+kh9hT6wd3DugTWmq9lSZ6xWvw+BEoNBTC0vA?=
 =?us-ascii?Q?gT7wHj+TXaj3dpmDI4YLU++k1h23g+m+yRKOSvSuJ0nFTE/E3hgDh7FaMocG?=
 =?us-ascii?Q?jAzCxBsODgPqnJCDNyPLasIEIeqe6Kf8Q+02O6u9Xady0dxXVDXI6YHaKtFY?=
 =?us-ascii?Q?SX+s9H7sJ6CVUzYJ5TnlXTEOI4b+F4XPhjzGGVvKiEYuk3xlTAh0GfKWJydw?=
 =?us-ascii?Q?BWWkBA=3D=3D?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 50a65e6a-7095-4ba7-54a5-08ddb8a0b2ef
X-MS-Exchange-CrossTenant-AuthSource: SN7PR11MB7540.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 01 Jul 2025 13:10:49.5515
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: ZJELf7R2gzR1Px5y0BUFcTFzYjpzf3GVX+uY8vJhb7rtqQNG6N6Pgec/mvuxXZvNxWlCMDaJGnDmBGpF7tOwAodL103CHIborQCSqLYzs2I=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS7PR11MB6270
X-OriginatorOrg: intel.com

On Tue, Jul 01, 2025 at 02:30:30PM +0800, Jiawen Wu wrote:
> For NGBE devices, the queue number is limited to be 1 when SRIOV is
> enabled. In this case, IRQ vector[0] is used for MISC and vector[1] is
> used for queue, based on the previous patches. But for the hardware
> design, the IRQ vector[1] must be allocated for use by the VF[6] when
> the number of VFs is 7. So the IRQ vector[0] should be shared for PF
> MISC and QUEUE interrupts.
> 
> +-----------+----------------------+
> | Vector    | Assigned To          |
> +-----------+----------------------+
> | Vector 0  | PF MISC and QUEUE    |
> | Vector 1  | VF 6                 |
> | Vector 2  | VF 5                 |
> | Vector 3  | VF 4                 |
> | Vector 4  | VF 3                 |
> | Vector 5  | VF 2                 |
> | Vector 6  | VF 1                 |
> | Vector 7  | VF 0                 |
> +-----------+----------------------+
> 
> Minimize code modifications, only adjust the IRQ vector number for this
> case.
> 
> Fixes: 877253d2cbf2 ("net: ngbe: add sriov function support")
> Signed-off-by: Jiawen Wu <jiawenwu@trustnetic.com>

Reviewed-by: Larysa Zaremba <larysa.zaremba@intel.com>

> ---
>  drivers/net/ethernet/wangxun/libwx/wx_lib.c   | 9 +++++++++
>  drivers/net/ethernet/wangxun/libwx/wx_sriov.c | 4 ++++
>  drivers/net/ethernet/wangxun/libwx/wx_type.h  | 1 +
>  drivers/net/ethernet/wangxun/ngbe/ngbe_main.c | 2 +-
>  drivers/net/ethernet/wangxun/ngbe/ngbe_type.h | 2 +-
>  5 files changed, 16 insertions(+), 2 deletions(-)
> 
> diff --git a/drivers/net/ethernet/wangxun/libwx/wx_lib.c b/drivers/net/ethernet/wangxun/libwx/wx_lib.c
> index 66eaf5446115..7b53169cd216 100644
> --- a/drivers/net/ethernet/wangxun/libwx/wx_lib.c
> +++ b/drivers/net/ethernet/wangxun/libwx/wx_lib.c
> @@ -1794,6 +1794,13 @@ static int wx_acquire_msix_vectors(struct wx *wx)
>  	wx->msix_entry->entry = nvecs;
>  	wx->msix_entry->vector = pci_irq_vector(wx->pdev, nvecs);
>  
> +	if (test_bit(WX_FLAG_IRQ_VECTOR_SHARED, wx->flags)) {
> +		wx->msix_entry->entry = 0;
> +		wx->msix_entry->vector = pci_irq_vector(wx->pdev, 0);
> +		wx->msix_q_entries[0].entry = 0;
> +		wx->msix_q_entries[0].vector = pci_irq_vector(wx->pdev, 1);
> +	}
> +
>  	return 0;
>  }
>  
> @@ -2292,6 +2299,8 @@ static void wx_set_ivar(struct wx *wx, s8 direction,
>  
>  	if (direction == -1) {
>  		/* other causes */
> +		if (test_bit(WX_FLAG_IRQ_VECTOR_SHARED, wx->flags))
> +			msix_vector = 0;
>  		msix_vector |= WX_PX_IVAR_ALLOC_VAL;
>  		index = 0;
>  		ivar = rd32(wx, WX_PX_MISC_IVAR);
> diff --git a/drivers/net/ethernet/wangxun/libwx/wx_sriov.c b/drivers/net/ethernet/wangxun/libwx/wx_sriov.c
> index e8656d9d733b..c82ae137756c 100644
> --- a/drivers/net/ethernet/wangxun/libwx/wx_sriov.c
> +++ b/drivers/net/ethernet/wangxun/libwx/wx_sriov.c
> @@ -64,6 +64,7 @@ static void wx_sriov_clear_data(struct wx *wx)
>  	wr32m(wx, WX_PSR_VM_CTL, WX_PSR_VM_CTL_POOL_MASK, 0);
>  	wx->ring_feature[RING_F_VMDQ].offset = 0;
>  
> +	clear_bit(WX_FLAG_IRQ_VECTOR_SHARED, wx->flags);
>  	clear_bit(WX_FLAG_SRIOV_ENABLED, wx->flags);
>  	/* Disable VMDq flag so device will be set in NM mode */
>  	if (wx->ring_feature[RING_F_VMDQ].limit == 1)
> @@ -78,6 +79,9 @@ static int __wx_enable_sriov(struct wx *wx, u8 num_vfs)
>  	set_bit(WX_FLAG_SRIOV_ENABLED, wx->flags);
>  	dev_info(&wx->pdev->dev, "SR-IOV enabled with %d VFs\n", num_vfs);
>  
> +	if (num_vfs == 7 && wx->mac.type == wx_mac_em)
> +		set_bit(WX_FLAG_IRQ_VECTOR_SHARED, wx->flags);
> +
>  	/* Enable VMDq flag so device will be set in VM mode */
>  	set_bit(WX_FLAG_VMDQ_ENABLED, wx->flags);
>  	if (!wx->ring_feature[RING_F_VMDQ].limit)
> diff --git a/drivers/net/ethernet/wangxun/libwx/wx_type.h b/drivers/net/ethernet/wangxun/libwx/wx_type.h
> index d392394791b3..c363379126c0 100644
> --- a/drivers/net/ethernet/wangxun/libwx/wx_type.h
> +++ b/drivers/net/ethernet/wangxun/libwx/wx_type.h
> @@ -1191,6 +1191,7 @@ enum wx_pf_flags {
>  	WX_FLAG_VMDQ_ENABLED,
>  	WX_FLAG_VLAN_PROMISC,
>  	WX_FLAG_SRIOV_ENABLED,
> +	WX_FLAG_IRQ_VECTOR_SHARED,
>  	WX_FLAG_FDIR_CAPABLE,
>  	WX_FLAG_FDIR_HASH,
>  	WX_FLAG_FDIR_PERFECT,
> diff --git a/drivers/net/ethernet/wangxun/ngbe/ngbe_main.c b/drivers/net/ethernet/wangxun/ngbe/ngbe_main.c
> index 68415a7ef12f..e0fc897b0a58 100644
> --- a/drivers/net/ethernet/wangxun/ngbe/ngbe_main.c
> +++ b/drivers/net/ethernet/wangxun/ngbe/ngbe_main.c
> @@ -286,7 +286,7 @@ static int ngbe_request_msix_irqs(struct wx *wx)
>  	 * for queue. But when num_vfs == 7, vector[1] is assigned to vf6.
>  	 * Misc and queue should reuse interrupt vector[0].
>  	 */
> -	if (wx->num_vfs == 7)
> +	if (test_bit(WX_FLAG_IRQ_VECTOR_SHARED, wx->flags))
>  		err = request_irq(wx->msix_entry->vector,
>  				  ngbe_misc_and_queue, 0, netdev->name, wx);
>  	else
> diff --git a/drivers/net/ethernet/wangxun/ngbe/ngbe_type.h b/drivers/net/ethernet/wangxun/ngbe/ngbe_type.h
> index 6eca6de475f7..3b2ca7f47e33 100644
> --- a/drivers/net/ethernet/wangxun/ngbe/ngbe_type.h
> +++ b/drivers/net/ethernet/wangxun/ngbe/ngbe_type.h
> @@ -87,7 +87,7 @@
>  #define NGBE_PX_MISC_IC_TIMESYNC		BIT(11) /* time sync */
>  
>  #define NGBE_INTR_ALL				0x1FF
> -#define NGBE_INTR_MISC(A)			BIT((A)->num_q_vectors)
> +#define NGBE_INTR_MISC(A)			BIT((A)->msix_entry->entry)
>  
>  #define NGBE_PHY_CONFIG(reg_offset)		(0x14000 + ((reg_offset) * 4))
>  #define NGBE_CFG_LAN_SPEED			0x14440
> -- 
> 2.48.1
> 
> 

