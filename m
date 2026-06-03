Return-Path: <netdev+bounces-294795-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id Td/mI5RHIGoR0AAAu9opvQ
	(envelope-from <netdev+bounces-294795-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Wed, 03 Jun 2026 17:26:12 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [104.64.211.4])
	by mail.lfdr.de (Postfix) with ESMTPS id B8852639277
	for <lists+netdev@lfdr.de>; Wed, 03 Jun 2026 17:26:11 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=intel.com header.s=Intel header.b=DHeVSmir;
	spf=pass (mail.lfdr.de: domain of "netdev+bounces-294795-lists+netdev=lfdr.de@vger.kernel.org" designates 104.64.211.4 as permitted sender) smtp.mailfrom="netdev+bounces-294795-lists+netdev=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=none) header.from=intel.com;
	arc=reject ("cv is fail on i=2")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id 0704D3053C2C
	for <lists+netdev@lfdr.de>; Wed,  3 Jun 2026 14:53:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B5B2C319852;
	Wed,  3 Jun 2026 14:52:58 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.9])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 561AA33BBB9;
	Wed,  3 Jun 2026 14:52:57 +0000 (UTC)
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780498378; cv=fail; b=QqRDW1hJ2WLWIY7gOGHqFYWk1RXnZXn/r5gmIIj5K0F5jz0djlBfdKpo5jMo+vvJVNhW13n9NHTEpaAGAdCcIkq14bqP+sWo2uxVIPMxQF/h2HYp4Y9bsCWLBIsSUK54kcHPpdSuo857R2ISKQh5vUTViMvRZS+Zrzv29nwyX48=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780498378; c=relaxed/simple;
	bh=5bXBrWnLucQfOEr1loG/OjnPWx28CIfbaTvCJxs+nxU=;
	h=Date:From:To:CC:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=mBWIDBCldediM6G97W8Z6SVBW9qp2wj6FuJoGkYGsOhl86Nig95VfUEscQT0SycnxZCbNGLTbibeBVQOm9gaNPCfIoEaMTjR4JNPRcctHYmGKfxZPdJ3NYunTGdwpkNccEAGn7C0rBg8MItuO5MHatIRew0bVl73JgpLHCg23XE=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=DHeVSmir; arc=fail smtp.client-ip=192.198.163.9
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1780498377; x=1812034377;
  h=date:from:to:cc:subject:message-id:references:
   in-reply-to:mime-version;
  bh=5bXBrWnLucQfOEr1loG/OjnPWx28CIfbaTvCJxs+nxU=;
  b=DHeVSmirlQ5OOaIM4fTQpjdeiE+pgKPgarqrMnxRLH68I2TlZozMHNIa
   vxoO7v7rWMRU098yqCDvTGeaSZ/bNOiYnrJnsFIZyMFA6sqRX2fKfdHML
   B8n+Z9j+P4+Ergh1rEtmEVkVwQopy3KBt99zyqpt67fbAAsUQnLJqAjGj
   F4zl1aMANzPavGFmj+RKcn9FfcJyUZIpshSNw6bTS2Y7O0V1Q9Dc5k9Hr
   zgZCS2GtOh+n2L9gs1q8PeYszabl4qWIAwbnNO1d8z+NUYad/b9CtYIEI
   odAZBEHzN4DC63BoJKJHTrDuqrXC1b/sD5mSXR9S84zerjOr9ulKZ88xF
   Q==;
X-CSE-ConnectionGUID: dAKiWJozQvmR12qpf9YPVw==
X-CSE-MsgGUID: xDY8144aQwOWTXlVcuRMLA==
X-IronPort-AV: E=McAfee;i="6800,10657,11806"; a="91993208"
X-IronPort-AV: E=Sophos;i="6.24,185,1774335600"; 
   d="scan'208";a="91993208"
Received: from orviesa002.jf.intel.com ([10.64.159.142])
  by fmvoesa103.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 03 Jun 2026 07:52:56 -0700
X-CSE-ConnectionGUID: f9mJX/uyTNKmmzoF21dOmg==
X-CSE-MsgGUID: 4lCTRQcNTAmHyQsjcQ+b6A==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.24,185,1774335600"; 
   d="scan'208";a="274500380"
Received: from orsmsx903.amr.corp.intel.com ([10.22.229.25])
  by orviesa002.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 03 Jun 2026 07:52:56 -0700
Received: from ORSMSX903.amr.corp.intel.com (10.22.229.25) by
 ORSMSX903.amr.corp.intel.com (10.22.229.25) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.37; Wed, 3 Jun 2026 07:52:56 -0700
Received: from ORSEDG901.ED.cps.intel.com (10.7.248.11) by
 ORSMSX903.amr.corp.intel.com (10.22.229.25) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.37 via Frontend Transport; Wed, 3 Jun 2026 07:52:56 -0700
Received: from BN8PR05CU002.outbound.protection.outlook.com (52.101.57.56) by
 edgegateway.intel.com (134.134.137.111) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.37; Wed, 3 Jun 2026 07:52:56 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=g/FDAnPJN89TH6MfrlVRDT9vEuW4hby5uLE27MkbPyyx7kvfQA5yadSv/v+yW4CrFSXaoBPwPc/6VhI34ImXzU/Z6lUi8OWfFaRBLqmArO0O12vSK96JjMjOv7UBTl7eRnRZhSXNXk31B+zdKd3SnbZQeo5q3QNS02EeWwt+Q96Gu9hbTTxy4FquYDv74pMMvYGZuw18vPy1/QNQYt0FQyWaHt6Mu0b65s3Z/MYLqfPqYC0Aa/PAEVuK+If5VKf2HP5XgsjvBepG5NQaQ7q7Ss4v9jb4dQz5KPPk/SBeh6xhxR9hL2RADM4zCIHzODWc30Ns+I2l+RPqfTZsXijZSA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=AuAVmbq38e7KovNNxAYscpw/LsPNzgtEUhhsGWQqj1Q=;
 b=B6f5icH+aerqOOPhbQ7HDXRIFy0sB+8T7aZ8AXXnDguqhOshq1w6+uWp42JEKaEbX6a0bZmZcGC2GsI1At5FG+dzXGh67NdJi0mNzPelaPwhJk+qaviaZkk/nmfjaUCyGMBLbeI+XkBTK8EnUohoh6NQ+BhdQbCH6XDCjyk0JkPJur/ThwSdpZzNFosFzFlQ90TgMpnEwWHahylbMlNwv45lupWNY5g6kBwMgEBBkSyr2y2nN+u2qSlJmPkSbqV5b9keiMCXyCa4dXETaG5iJxkL1RxXU1xViys1AarVdCXcIr5dKJHMrLI4iiRsPFU6zIhVRRy0SYUfhJ2pcmi0Iw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from DM4PR11MB6117.namprd11.prod.outlook.com (2603:10b6:8:b3::19) by
 SA1PR11MB6991.namprd11.prod.outlook.com (2603:10b6:806:2b8::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.92.7; Wed, 3 Jun 2026
 14:52:52 +0000
Received: from DM4PR11MB6117.namprd11.prod.outlook.com
 ([fe80::d9b3:e942:2686:3cdd]) by DM4PR11MB6117.namprd11.prod.outlook.com
 ([fe80::d9b3:e942:2686:3cdd%5]) with mapi id 15.21.0092.006; Wed, 3 Jun 2026
 14:52:52 +0000
Date: Wed, 3 Jun 2026 16:52:46 +0200
From: Maciej Fijalkowski <maciej.fijalkowski@intel.com>
To: Tushar Vyavahare <tushar.vyavahare@intel.com>
CC: <netdev@vger.kernel.org>, <magnus.karlsson@intel.com>,
	<stfomichev@gmail.com>, <kernelxing@tencent.com>, <davem@davemloft.net>,
	<kuba@kernel.org>, <pabeni@redhat.com>, <ast@kernel.org>,
	<daniel@iogearbox.net>, <tirthendu.sarkar@intel.com>, <bpf@vger.kernel.org>
Subject: Re: [PATCH net-next v2 1/4] selftests/xsk: Introduce helpers for
 setting UMEM properties
Message-ID: <aiA/vvEkP0Sp8kUQ@boxer>
References: <20260603060327.298389-1-tushar.vyavahare@intel.com>
 <20260603060327.298389-2-tushar.vyavahare@intel.com>
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <20260603060327.298389-2-tushar.vyavahare@intel.com>
X-ClientProxiedBy: WA0P291CA0009.POLP291.PROD.OUTLOOK.COM (2603:10a6:1d0:1::9)
 To DM4PR11MB6117.namprd11.prod.outlook.com (2603:10b6:8:b3::19)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM4PR11MB6117:EE_|SA1PR11MB6991:EE_
X-MS-Office365-Filtering-Correlation-Id: f153eb69-8d0e-4924-66c7-08dec17fc9ea
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|1800799024|376014|22082099003|18002099003|17002099007|6133799003|4143699003|11063799006|56012099006;
X-Microsoft-Antispam-Message-Info: O8rDGGF0uP3RJsNueJsHRflo56JVNpAgZ7PS1bVX0AKUCasa/V6itb8AtRjHTkLVp0YwhGd29F4ShfhZptUVZZO5XjTTblceBYnRB8rZKsBGGgkoBpMGC9jMHuccgHDh25O+CdX4ddumTyWTgcBT4qns0HoD0oLC0fMyRe0/og1FxSQou5DYrxtVh+LDy99rP19no+zMcaAn3rucHNksX+ri1tgxC0lpORWwZVkVvACGju/mFymErxlIelYlEXJPg0B/Oe9SfbgiOTDg6A2qA6x9l644npt8VXdEJCoNaDPPudUAe3oKWjPzCW9gUdaxNhg1XuMqf25Eud737zZGwGWAs0PAVER9HSSWgvwxmF0HwrP2d5/mTtOsk9llZH2mY2aEssvdxSRJ/JxwSSq3XTRh7BJfZpZf7mPfZxh1N2RuXLc/FDNrzLBCfOHYSYXGOP9IJ/6Om4tinLs3SoKk+IO+3Oo+ZkYhodR1CfmlGUOIXWQVZt+SKFuJT94jd2EtSZ2gr6445t3GQA+UTnTFG0rrzg62Xzz9E2WerrVFHosnftgZIiDJXtpKHkLgEqrdmeTONFYQQxwi3d69xuA6f63BiAAcViH8ly8jE/nnGrKQLSW1h+tB8S03RIpDsF5pEgm7QhZcw4gp+CLJ7gkq1B/MP9lCK3fc/nT4fuZ+/1eaHcQAhIinM9Pi9Fe8X4Ww
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM4PR11MB6117.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(376014)(22082099003)(18002099003)(17002099007)(6133799003)(4143699003)(11063799006)(56012099006);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?mf+yLysV8iQ9CmxKryy+cgjTcpkOGBe2SQ8z2K/JZlucy2UCiZC/yYbIe3Vq?=
 =?us-ascii?Q?JNtkQa1lFQBe/5TtUlnfxROkFeokZgSHOk2C++w8nG4rstk5OvxioRrM8bdF?=
 =?us-ascii?Q?AGIHBPA9H6POBKhABdGfudfTQfZQ9w7fyGjKa4maP4QLifMqdrfr3CPRGXyO?=
 =?us-ascii?Q?ZT7Ty2ZvtQC/fgVyIoeIKmq/MYQSoQNdw7xsowXw7uHjRi2TC7jiM1gpQZvx?=
 =?us-ascii?Q?A6tN3gvJIdJvyH+EmgCre2FEJtvn5PvOhZprfYgzDfRTDN+JpiOtKOSQIs1t?=
 =?us-ascii?Q?Bxv3uG8DGNP5nfjwiaqPionAFn+6zKZ9QF0M4X7dF1ERvODDr36Llphd900M?=
 =?us-ascii?Q?ZNBYIuP+8UfvFjPG9ZerkQ0PpeDnT755kVm+hgfxC274QDZOzcUUdhAnv5uP?=
 =?us-ascii?Q?JOguZJenIApFWup5aFrk8lzeQmXG2mE7uES4D1jpIFlicchbPtAAmrFZTIj1?=
 =?us-ascii?Q?u/yjaN4Q8+gHVaCz0eochi0kpV8SaJZyrhtHdHyWkx0LyL8N/8AXREkZx5Sj?=
 =?us-ascii?Q?tQq3LWo0J0LR3dYKrFaRWd9MuSKk6LSw9QnE64XvjWPUh9Kyn7ZG9/rt346s?=
 =?us-ascii?Q?TE4CmRLrkbNQxR5fTgQsnklcy3uvM4EyydXD6EeDNWFcbD/X9aBgasXEpbj5?=
 =?us-ascii?Q?SYzQRcZ87w9L7HsIkRKsP5nUtRDOjmetLRehYa3dW0hg6Bim1C0wd4c3mxRc?=
 =?us-ascii?Q?TdK4kXVhIgn6KhG2BUv3PMXY0/GEXeQ8/Wgho8+kQgF9rydz7VO4URXYffzw?=
 =?us-ascii?Q?CYjyif2gqkYL1jLTk/R8gQkIQoHHKJ0nxigvAKkkvNpNnZkLMt2j//9zMiu5?=
 =?us-ascii?Q?iUsGKOW9j8fyw1E++fD3NRm+rA1u588qUpyrmCv+O6wfns/xyvqhoDjEMaZX?=
 =?us-ascii?Q?13SgDBQ/fGToI/ry2EKpHfA5IrpaPO5+4QYYx+0ONSLJHCpSKmTq9brGOk/e?=
 =?us-ascii?Q?ex0rWV3o8qkWsJZvpcR6Lkkv2UUpY2GnxbhQ0WHmLX2HUPledTkiABRCSUv2?=
 =?us-ascii?Q?XIPxxq4FiQMF1KaVP5+zSJs2aqZNQd/XROlDD7kkvBlKNPXaDXPgDXVkfFMD?=
 =?us-ascii?Q?9wnXzFcdUIuOA9XMCJ7BUQhnhZvgZMiOzsT4D+0hciysQ2x+J7BiyFzhvCiF?=
 =?us-ascii?Q?g9i133SewF7lPiGFw6yOLLdEWhImJMQqsTNrnv3WSoXkVABFKMabp/G9ID2i?=
 =?us-ascii?Q?QrraeDOScw2tAQUTHSf9KQ1DZsPdyycDMlF2Pkck2lgKP4Gj7SzFfIHMm51D?=
 =?us-ascii?Q?L1CorA5OyB7TT0FKYtgp1b0I/6BF5AP1Y2Qb/AAn/NRtspDwXCdY4oQYLrlw?=
 =?us-ascii?Q?RkYYup02ggOLR7/kGC9VsArQiCYSq1Jd7MKm7hnH5HDsh/YOETSv8GyyiyU6?=
 =?us-ascii?Q?KURNTvX+fdTSFVvQMMCibQhYhVqi+gTP6OtuHwJ/VdILmKRv4YTzWL7weCRT?=
 =?us-ascii?Q?d0BJGYIznYo1TwG2uKDP/c0v3Rls2YqRiysxJsBRdzEt2Gd0HazoRfsdFS2y?=
 =?us-ascii?Q?VWBX1nCktkm/OTM/MF5pV79ua4MqCLXpLqMLLIvHZiL08yQ5fAVOLELFKXX3?=
 =?us-ascii?Q?Mw5RV9W+CCdBStCp1D0rX19AYZIAvIv7LCxRqom01yBwLekr786DDHVHTvQU?=
 =?us-ascii?Q?d5aAywYMvrx/Gs40PIwt3kzRXgUzvnRvwBsr2Yo9HeFksVaRwOS8r1IOwo63?=
 =?us-ascii?Q?C1JVjORuGIdGw6LcPG6yH9twxub0TaSkUgs8B8H4vyPGjahqX5blOMmsGoHL?=
 =?us-ascii?Q?zp354sM5wtoQB4yt+t2Usk+VYlAqohI=3D?=
X-Exchange-RoutingPolicyChecked: J5OKhVSdgbKskhQHZydMYIJIYoWMhIN2ot/z+c54AuLQn8Ajh3DzYeh6xO8Rb46awNhyE/zftR3JqG5IdouGGTxyv8/6nOqDjS6AS4pJhNjS4B7V2AXwneSU9mt7CGbgZ/UHtN9kUH+Yxp3frKpAF2EYi+keqV/KvKjLNoGTNWp9cJXNiv1z7UqutDxMk6anM1PVR/N8Q8PYJsuERHHH23wfL+gkZ2VlRDMshgKspaOa60ktM2G2t5PUnwzIxtFSxx+MBQgve/f3RVcF20sIxmjoqozv8ujvsnNKG/pGuh3psWSWnWl4whh5Q20j5OFg9r25ygdKleIgS2yJkYoqeg==
X-MS-Exchange-CrossTenant-Network-Message-Id: f153eb69-8d0e-4924-66c7-08dec17fc9ea
X-MS-Exchange-CrossTenant-AuthSource: DM4PR11MB6117.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 03 Jun 2026 14:52:52.7089
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 0mldOBzxyhESVl/Z67R+kUi1n27S97LJhPBvt0grfPgZTyK9sTs4ouS11SGNJm8mSKdTVLn9EjI3ysmrxLkc6q8AFOIcLTyA7iIq7m9X6Qk=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA1PR11MB6991
X-OriginatorOrg: intel.com
X-Rspamd-Action: no action
X-Spamd-Result: default: False [0.34 / 15.00];
	ARC_REJECT(1.00)[cv is fail on i=2];
	MID_RHS_NOT_FQDN(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[intel.com,none];
	R_SPF_ALLOW(-0.20)[+ip4:104.64.211.4:c];
	R_DKIM_ALLOW(-0.20)[intel.com:s=Intel];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-294795-lists,netdev=lfdr.de];
	DBL_BLOCKED_OPENRESOLVER(0.00)[intel.com:dkim,intel.com:from_mime,intel.com:email,sin.lore.kernel.org:helo,sin.lore.kernel.org:rdns,vger.kernel.org:from_smtp,boxer:mid];
	FORGED_SENDER(0.00)[maciej.fijalkowski@intel.com,netdev@vger.kernel.org];
	RCPT_COUNT_TWELVE(0.00)[12];
	FORGED_RECIPIENTS(0.00)[m:tushar.vyavahare@intel.com,m:netdev@vger.kernel.org,m:magnus.karlsson@intel.com,m:stfomichev@gmail.com,m:kernelxing@tencent.com,m:davem@davemloft.net,m:kuba@kernel.org,m:pabeni@redhat.com,m:ast@kernel.org,m:daniel@iogearbox.net,m:tirthendu.sarkar@intel.com,m:bpf@vger.kernel.org,s:lists@lfdr.de];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	FORWARDED(0.00)[lists@lfdr.de];
	FREEMAIL_CC(0.00)[vger.kernel.org,intel.com,gmail.com,tencent.com,davemloft.net,kernel.org,redhat.com,iogearbox.net];
	DKIM_TRACE(0.00)[intel.com:+];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[maciej.fijalkowski@intel.com,netdev@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	TO_DN_SOME(0.00)[];
	ALIAS_RESOLVED(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	MISSING_XM_UA(0.00)[];
	ASN(0.00)[asn:63949, ipnet:104.64.192.0/19, country:SG];
	RCVD_COUNT_SEVEN(0.00)[10]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: B8852639277

On Wed, Jun 03, 2026 at 11:33:24AM +0530, Tushar Vyavahare wrote:
> UMEM properties are set via open-coded field assignments in multiple test
> paths, which makes updates noisy and error-prone.
> 
> Introduce two helpers to set UMEM properties through a single interface.
> This keeps setup logic consistent across tests and makes future refactoring
> simpler.
> 
> No functional behavior change is intended.
> 
> Signed-off-by: Magnus Karlsson <magnus.karlsson@intel.com>
> Signed-off-by: Tushar Vyavahare <tushar.vyavahare@intel.com>

Reviewed-by: Maciej Fijalkowski <maciej.fijalkowski@intel.com>

> ---
>  .../selftests/bpf/prog_tests/test_xsk.c       | 36 ++++++++++---------
>  1 file changed, 20 insertions(+), 16 deletions(-)
> 
> diff --git a/tools/testing/selftests/bpf/prog_tests/test_xsk.c b/tools/testing/selftests/bpf/prog_tests/test_xsk.c
> index 7950c504ed28..3369450da974 100644
> --- a/tools/testing/selftests/bpf/prog_tests/test_xsk.c
> +++ b/tools/testing/selftests/bpf/prog_tests/test_xsk.c
> @@ -303,6 +303,18 @@ static void test_spec_reset(struct test_spec *test)
>  	__test_spec_init(test, test->ifobj_tx, test->ifobj_rx);
>  }
>  
> +static void test_spec_set_unaligned(struct test_spec *test)
> +{
> +	test->ifobj_tx->umem->unaligned_mode = true;
> +	test->ifobj_rx->umem->unaligned_mode = true;
> +}
> +
> +static void test_spec_set_frame_size(struct test_spec *test, u32 size)
> +{
> +	test->ifobj_tx->umem->frame_size = size;
> +	test->ifobj_rx->umem->frame_size = size;
> +}
> +
>  static void test_spec_set_xdp_prog(struct test_spec *test, struct bpf_program *xdp_prog_rx,
>  				   struct bpf_program *xdp_prog_tx, struct bpf_map *xskmap_rx,
>  				   struct bpf_map *xskmap_tx)
> @@ -2025,8 +2037,7 @@ int testapp_stats_fill_empty(struct test_spec *test)
>  
>  int testapp_send_receive_unaligned(struct test_spec *test)
>  {
> -	test->ifobj_tx->umem->unaligned_mode = true;
> -	test->ifobj_rx->umem->unaligned_mode = true;
> +	test_spec_set_unaligned(test);
>  	/* Let half of the packets straddle a 4K buffer boundary */
>  	if (pkt_stream_replace_half(test, MIN_PKT_SIZE, -MIN_PKT_SIZE / 2))
>  		return TEST_FAILURE;
> @@ -2037,8 +2048,7 @@ int testapp_send_receive_unaligned(struct test_spec *test)
>  int testapp_send_receive_unaligned_mb(struct test_spec *test)
>  {
>  	test->mtu = MAX_ETH_JUMBO_SIZE;
> -	test->ifobj_tx->umem->unaligned_mode = true;
> -	test->ifobj_rx->umem->unaligned_mode = true;
> +	test_spec_set_unaligned(test);
>  	if (pkt_stream_replace(test, DEFAULT_PKT_CNT, MAX_ETH_JUMBO_SIZE))
>  		return TEST_FAILURE;
>  	return testapp_validate_traffic(test);
> @@ -2337,8 +2347,7 @@ int testapp_send_receive(struct test_spec *test)
>  
>  int testapp_send_receive_2k_frame(struct test_spec *test)
>  {
> -	test->ifobj_tx->umem->frame_size = 2048;
> -	test->ifobj_rx->umem->frame_size = 2048;
> +	test_spec_set_frame_size(test, 2048);
>  	if (pkt_stream_replace(test, DEFAULT_PKT_CNT, MIN_PKT_SIZE))
>  		return TEST_FAILURE;
>  	return testapp_validate_traffic(test);
> @@ -2363,15 +2372,13 @@ int testapp_aligned_inv_desc(struct test_spec *test)
>  
>  int testapp_aligned_inv_desc_2k_frame(struct test_spec *test)
>  {
> -	test->ifobj_tx->umem->frame_size = 2048;
> -	test->ifobj_rx->umem->frame_size = 2048;
> +	test_spec_set_frame_size(test, 2048);
>  	return testapp_invalid_desc(test);
>  }
>  
>  int testapp_unaligned_inv_desc(struct test_spec *test)
>  {
> -	test->ifobj_tx->umem->unaligned_mode = true;
> -	test->ifobj_rx->umem->unaligned_mode = true;
> +	test_spec_set_unaligned(test);
>  	return testapp_invalid_desc(test);
>  }
>  
> @@ -2380,10 +2387,8 @@ int testapp_unaligned_inv_desc_4001_frame(struct test_spec *test)
>  	u64 page_size, umem_size;
>  
>  	/* Odd frame size so the UMEM doesn't end near a page boundary. */
> -	test->ifobj_tx->umem->frame_size = 4001;
> -	test->ifobj_rx->umem->frame_size = 4001;
> -	test->ifobj_tx->umem->unaligned_mode = true;
> -	test->ifobj_rx->umem->unaligned_mode = true;
> +	test_spec_set_frame_size(test, 4001);
> +	test_spec_set_unaligned(test);
>  	/* This test exists to test descriptors that staddle the end of
>  	 * the UMEM but not a page.
>  	 */
> @@ -2402,8 +2407,7 @@ int testapp_aligned_inv_desc_mb(struct test_spec *test)
>  
>  int testapp_unaligned_inv_desc_mb(struct test_spec *test)
>  {
> -	test->ifobj_tx->umem->unaligned_mode = true;
> -	test->ifobj_rx->umem->unaligned_mode = true;
> +	test_spec_set_unaligned(test);
>  	return testapp_invalid_desc_mb(test);
>  }
>  
> -- 
> 2.43.0
> 

