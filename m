Return-Path: <netdev+bounces-302002-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id 9EpmCu9HPWr+0ggAu9opvQ
	(envelope-from <netdev+bounces-302002-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Thu, 25 Jun 2026 17:23:27 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 755C36C706E
	for <lists+netdev@lfdr.de>; Thu, 25 Jun 2026 17:23:26 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=intel.com header.s=Intel header.b="iFZY/nTv";
	spf=pass (mail.lfdr.de: domain of "netdev+bounces-302002-lists+netdev=lfdr.de@vger.kernel.org" designates 172.234.253.10 as permitted sender) smtp.mailfrom="netdev+bounces-302002-lists+netdev=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=none) header.from=intel.com;
	arc=reject ("cv is fail on i=2")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id CDF5C3037BA1
	for <lists+netdev@lfdr.de>; Thu, 25 Jun 2026 15:21:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 377953B8D79;
	Thu, 25 Jun 2026 15:21:43 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.14])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 122EA481B1;
	Thu, 25 Jun 2026 15:21:41 +0000 (UTC)
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782400903; cv=fail; b=LnfN8Jqw/wJYMWsTcl0G4l8zLjM5cKSVPlEN23bW0yc1tZZTaK1KQMXCNGvd1omNV5rTwb1Ev03km92/wWA/BlR0dqt9ZNSAEqzOum0bgF6Pcbp7PTgMklRIZUd9PaI8zVj9jRM7wvdVxzzybo2sdK7g9ZPYU2AUCPf9YzfFVuc=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782400903; c=relaxed/simple;
	bh=LgtSHKh4yMMEblvAc9PIROFXauuMXnF+ExEiHE2Pvdw=;
	h=Date:From:To:CC:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=mMIzUmDRbffrEShlDFDSTlYG1VN5QOlfsO6Z/SwUZPVBaT7o6YG3lXjx3wB26xuGYvn8gyKlKJxeLXderoEEI5RVm7QS1xAPfg2KZ7DFn52bv3DkNLPa3KcLSUhBGrkK4ROdgqCJn0COealSmAdmJehHnvNJboPBugURCMW5szM=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=iFZY/nTv; arc=fail smtp.client-ip=192.198.163.14
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1782400902; x=1813936902;
  h=date:from:to:cc:subject:message-id:references:
   in-reply-to:mime-version;
  bh=LgtSHKh4yMMEblvAc9PIROFXauuMXnF+ExEiHE2Pvdw=;
  b=iFZY/nTvc2pdBmR1PxDEwTbr7xEl+TdTBDfvoN+iOHc3LJafNTx61yGm
   B/UpXnCweJ3V5ooPXC77HKQol4X/Z++02ygBQzrZ7U5USCgvhifH4csAl
   Jt6UmNtESR0FLYjEIVkK1kX0sNqSVqaMCKYBfJQqSQ9aLPwATVKY6DZxf
   3L5cULwZ7q77MMXv93J89Yt8LTm9F5gBN3sVRxso1sI0EDCfS/iw9Cu49
   DKI86gqtOTjvCKKdCYSNEvg4Su8A6+iuSAyTLJn+BN7BRCxrsYOt8qCGz
   YuF4SsTje/OXoopb8qffgjlRGapk2D5MuV18RRFzCEO8Gp4sKW1LlvuKD
   A==;
X-CSE-ConnectionGUID: SyWjJNVWRa+trTvEhCfNWA==
X-CSE-MsgGUID: 1ITnIK3gTgmu2i6C48Cx8w==
X-IronPort-AV: E=McAfee;i="6800,10657,11827"; a="83233374"
X-IronPort-AV: E=Sophos;i="6.24,224,1774335600"; 
   d="scan'208";a="83233374"
Received: from orviesa007.jf.intel.com ([10.64.159.147])
  by fmvoesa108.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 25 Jun 2026 08:21:41 -0700
X-CSE-ConnectionGUID: 0/mN/r2ERmi1kjrcWUnBkQ==
X-CSE-MsgGUID: nKZeUSDrQvi921cHkHnBrQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.24,224,1774335600"; 
   d="scan'208";a="250980828"
Received: from fmsmsx903.amr.corp.intel.com ([10.18.126.92])
  by orviesa007.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 25 Jun 2026 08:21:42 -0700
Received: from FMSMSX901.amr.corp.intel.com (10.18.126.90) by
 fmsmsx903.amr.corp.intel.com (10.18.126.92) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.37; Thu, 25 Jun 2026 08:21:40 -0700
Received: from fmsedg902.ED.cps.intel.com (10.1.192.144) by
 FMSMSX901.amr.corp.intel.com (10.18.126.90) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.37 via Frontend Transport; Thu, 25 Jun 2026 08:21:40 -0700
Received: from PH8PR06CU001.outbound.protection.outlook.com (40.107.209.39) by
 edgegateway.intel.com (192.55.55.82) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.37; Thu, 25 Jun 2026 08:21:40 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=preulA9EGu+wK1xgXVs33wuij2NkYvcyHhWrjigLmVYRL13PGwnDuYSF55ugSt0ZJoKlfwc8KhUkRI0Oy0471K9y53WOCNahdchjVt0TabLGycMLwKNSfFcNjkPKrkdp0KlQyKMeEmuK3OQMta6hD1xOpOQulS8gUvmK+VVmFdc772yray65hPLnsXmaisDsAs41iUJEmq3VsZHPacXBjd9XAZpe6L2G05hlUZsQWUBijUzDEhljtakoLM/YvAUavOBc+1EveMda6b2qO5BDxd0lLRlkVVqMLzPhcOMa5ZkcLtQT31YN8xlMT1DF2/Q/4L/M4aP7zJMcWTCOHtmlDA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=kFU6MLZR4aDvCQAUUDpBvvSgK/tHjm08T1pqDa3zm8Y=;
 b=VW6PrR6kTgxFgOhExBqP11jAQHUW3T0MWKRW4ZDrLYA+wDkgBRLVuYDAM9ozivH7IrXHNZA/xpTX2Nq5Sg5OLM2Lxor1PEzhSGXyUfRCwSUml9Ue7NqXi2GAsvsNz/rtlEH2DIwAJjCl2HRwHoyj/s9/z28gTy9tCnd6Lgp+g9drG3sL7PHJUX2Yp/mCyMgDd2ISsaWc+Tassyu+/3CWY3nalgg60SsySpGkjTtB7hrKhmOMXm6C3mkMtyQ8tqeaIP6lT6NAHH8VGGq7o/1wZwpDeySHSCeDDyh08mF6RSPqenoby3DVGHVhgEdrhqQgtoFfwFkbgKn93YGjsLA6Kw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from IA1PR11MB6097.namprd11.prod.outlook.com (2603:10b6:208:3d7::17)
 by CO1PR11MB4833.namprd11.prod.outlook.com (2603:10b6:303:99::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.159.17; Thu, 25 Jun
 2026 15:21:38 +0000
Received: from IA1PR11MB6097.namprd11.prod.outlook.com
 ([fe80::61e9:afe6:c2c0:722]) by IA1PR11MB6097.namprd11.prod.outlook.com
 ([fe80::61e9:afe6:c2c0:722%3]) with mapi id 15.21.0159.013; Thu, 25 Jun 2026
 15:21:38 +0000
Date: Thu, 25 Jun 2026 17:21:31 +0200
From: Maciej Fijalkowski <maciej.fijalkowski@intel.com>
To: Jakub Kicinski <kuba@kernel.org>
CC: <netdev@vger.kernel.org>, <bpf@vger.kernel.org>,
	<magnus.karlsson@intel.com>, <stfomichev@gmail.com>, <pabeni@redhat.com>,
	<horms@kernel.org>, <tushar.vyavahare@intel.com>, <kerneljasonxing@gmail.com>
Subject: Re: [PATCH net-next] selftests/xsk: preserve UMEM view in bidi test
Message-ID: <aj1He9vNkRh+Ettf@boxer>
References: <20260623091008.1046547-1-maciej.fijalkowski@intel.com>
 <20260624193326.295e3711@kernel.org>
 <aj0EYNt7Sr1dD96N@boxer>
 <20260625073636.449a28c0@kernel.org>
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <20260625073636.449a28c0@kernel.org>
X-ClientProxiedBy: TLZP290CA0013.ISRP290.PROD.OUTLOOK.COM (2603:1096:950:9::6)
 To IA1PR11MB6097.namprd11.prod.outlook.com (2603:10b6:208:3d7::17)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: IA1PR11MB6097:EE_|CO1PR11MB4833:EE_
X-MS-Office365-Filtering-Correlation-Id: 7c379fec-3bc8-4ccd-9d71-08ded2cd739c
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|376014|1800799024|23010399003|18002099003|22082099003|4143699003|11063799006|56012099006;
X-Microsoft-Antispam-Message-Info: jk0XPF0E2roLva/vXK7hjX6ZblNqOrej+Ct4OmC53uh12CnuLGJCZy/oUTH9aESwb760xJ1L1ec+ZXC7aHf1rLhbX3Un3Ttp2flP2C+D1UQnoF7ZVy+9aCGj2AmtRhFHArsC17DBYN+LQhlM6Jo0sPEhSSNhOkvHNX/XhJmge/JUKsfCGA7op4Dfu7F0YZUP1LgwqXO6xY4/1Dc2JvWcuUm5igCrMsEyEtR+lNsIFjuJZXL6Ah43zCF28Tbb21CYf0ozHn2dcdunptGC1hcGUI56WHTqDgicZ28kgMsrjMWT4/bt6Lvmed+75N/Wz0ezn0ETV+umoWulLATW/fagKjgAT90Dsu7JLei35vAwI4eNv/ETNg+ljFcLgHNGanQNyLwmcRBAl1obu540N7+ns8IHI9p+iw2CqCgWdie/EaFZGlE6EmaBibE1TcKErhoTfz+L2W/cOeGgadTw7zAElCeLzPEN9Rh3u1gDmcF7sHHv/JYm0d5OQCGqZfsXTh+67qZTscGcP2oh4ECPinaxy3IAyM9oZi53uKTPlo0bu95asapn+IAP596nkR7iGn/pXvkEHtG8f/EI9MHGXvLOjsn78swvZAuxAwwMlT+xbCr3kgUK6KcFjj5nEi4GoU+BiwpQXGxtPJFlpClV1j336WSjWjgLaUMnDqWAhSyoTVU=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:IA1PR11MB6097.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(376014)(1800799024)(23010399003)(18002099003)(22082099003)(4143699003)(11063799006)(56012099006);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?2v2mJpxbUAnpk9oQjKe78eiZVB1yrTyMKSamVQ4ZGBIZv7L2XTZkcz4u1FWc?=
 =?us-ascii?Q?38SbuO2ESDXxiEelHFftkGrROIAxry2QLQfJoZIj/2FjfvAJtcNff3SUV59K?=
 =?us-ascii?Q?57lfO/gqHdKtrKY8a84qREli18a95fbvNw0+0Vvg7S/pJY9Zm15W5ReQCWjX?=
 =?us-ascii?Q?ZBd5PFnVBUJa1lvEdZisudyut0VtrF7K0rwgyATQVegwJfR74Y41V7o/BdHd?=
 =?us-ascii?Q?IW58U+rEaUSiP0zsMlhuGmEbQjs5vcMINGUkqi2y+JO5BG600kHmglwR70Tz?=
 =?us-ascii?Q?91igEEbXGJngbuxsQRYrxU3skQia2cM/OHydek65uE/H+IRCSiN3YXWmz3Py?=
 =?us-ascii?Q?hsMvLd43qrW2wE25KU5ej6mcxRufWmabXqkauqGC6M0IxfLUD4UMaM+n2eIv?=
 =?us-ascii?Q?mQ6wDJLbA7R1+5HMBgEvU6X7ILKCzJcM4O3p78b497UgLlie8EfLv8UROKwt?=
 =?us-ascii?Q?0NHnYJXLMM70BfpvdHsGf39hVcVCsqtU4te+PYbatbymK7isOWx8ouFrRnO2?=
 =?us-ascii?Q?dfxIbTwjqT8US/D7r+A7O68tNycwQdUbjg2nxkMDq/HR+Uz8bx94v9VwsH8N?=
 =?us-ascii?Q?IqxlCp19qfa9K/PSeqCkMACUizrGJ/3XEhGk5ySl89wEYMJjGicAX8pSvNIP?=
 =?us-ascii?Q?4HMoSwRIT//KSKuRaADVgeNIcX4yDwwJCxfJkxNEsqXOBGwDJQ4YFIWMThI0?=
 =?us-ascii?Q?x+Ke6pNij/BiL86s+6VfBueYkLDggR4EncPfZ7xjs385OEJjfyRER9xXxJ9W?=
 =?us-ascii?Q?ieQAfpIGMVyzzSr9brLJEB+E7KeyuQEQWxxs5RZcf9kczeP8Itt6CWE82AOM?=
 =?us-ascii?Q?oOJDUAWKIqLzy4a8brbDk9tnCqijDLW9JqW7/+W/KUqBfPQZ0G72wHrxkFBE?=
 =?us-ascii?Q?ITX8fUPRL/7jMapngso6sfl74gcmrfmKVnEfTIDDM0tOwOeRbEXFjhEiOKhv?=
 =?us-ascii?Q?sFUpLmT+YFqwxLtdRAWhm1GjNyBGmEY0k+rx7u6c3NxjRPRMwJboMUECq8Xk?=
 =?us-ascii?Q?Bt6No0CN5rw7h7LwyBzzniLg+79fwUgAXwQR5M3T3stbN4wDs4Wwl0V3dl77?=
 =?us-ascii?Q?Ypus7ZFhHXIT0vQUbcu+zMN0ypC9MoKCvXA/jROk4edX37MMnUm9ai2mef2k?=
 =?us-ascii?Q?09KJcya9dvAr5t6Khnky7F/AbCz1jZ7o7RYhaoj0RARY8loczGPLYsjR8zOC?=
 =?us-ascii?Q?nI8c9uP0sW/AHhpazgB01xa/FHYMKt5gzUmqw4vob52MpJtGCjQfFFI4GfYG?=
 =?us-ascii?Q?ON+a5uOnrxcHjbwlZhcL/4DFgijJggfL8/uuMuFsyRefIzqG4a8OQCxdDfaC?=
 =?us-ascii?Q?Ax+ZxCbrWVGyM12ij23S1jUTj0hLB4L7uafDVBo0iT46utr+4V/Hhzre3hxp?=
 =?us-ascii?Q?EA2WDUp4e1dwEPPK+CnXdweP8qr4pjU9KUn890wy93AYmTKb7WltsqCzF53A?=
 =?us-ascii?Q?4q2KhaQREGWtO1VsDSjBL8j9zyhS4vJzv1l28RwZqqke2sQuUNDHNXKuHffX?=
 =?us-ascii?Q?EW42tsyJKpxdGQCOySWHVlGsv1ZUmJYDvFCzAgcD7GJfMJt7MCWuFBzYtO7x?=
 =?us-ascii?Q?GoTiTWt7wPBPao9k53pWHv9s1QnMtFvJftZzZb88nBqX7gZM+P5YSkM+/n1N?=
 =?us-ascii?Q?QYslCIaE+htxq2fDGid0N7xCvYiSaOcMSD8fnXDOHQ5IZx/ZPJJ+fjcKWKFh?=
 =?us-ascii?Q?v7Fyzx95u8iLETv5SmZtquzxM6tXkP+u3KvORA8/gK5bLkxfaqJfX/itXc5a?=
 =?us-ascii?Q?8nMrtOE+mpLpa/bwDG/9Sd5+4n2EFfo=3D?=
X-Exchange-RoutingPolicyChecked: sQMolwDJfFgmuU8tk4zZp3F7wIL4bm6xnfKmYIrGyGz6S3kyk/ucDUSNdiV+64Pn4uf3CAmGt5IM9dhGL6fIjZY6UuvUN3MKp/1Yji6GvsN6JdZAmP/InXdGXQTypHtr6MFphvqe4mGcGjTjfBRG6hbK11GZHyJZq+hQTwktrBQDeczaL4zi7rT0nJpL+HP8b+2APNN0vhvfpU68T28uXvg3ZXuBvN00epucFVTyg8SqqAvIAFmbvSy3EILUc7ADB4TKuHaJzTDxteaJc9TPuN8EIHUXQZMfY4Y6Ool/JHKg/U+nUd1CcuN/QAKOK1fSYZUx6r9cBsv4H1bZU9RzHA==
X-MS-Exchange-CrossTenant-Network-Message-Id: 7c379fec-3bc8-4ccd-9d71-08ded2cd739c
X-MS-Exchange-CrossTenant-AuthSource: IA1PR11MB6097.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 25 Jun 2026 15:21:38.4206
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: /r1eLGACpHw9sHJnr1tl/8HQAYaZlUbDXWTR4R3qDlqD0GKsZTPNOeDrv0TgRuPgecTW0YGaMg4BUvx1UHaHMPbgf1IefvT08Z+5qTYDSxQ=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CO1PR11MB4833
X-OriginatorOrg: intel.com
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-2.66 / 15.00];
	WHITELIST_SPF_DKIM(-3.00)[intel.com:d:+,kernel.org:s:+];
	ARC_REJECT(1.00)[cv is fail on i=2];
	MID_RHS_NOT_FQDN(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[intel.com,none];
	R_DKIM_ALLOW(-0.20)[intel.com:s=Intel];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	TAGGED_FROM(0.00)[bounces-302002-lists,netdev=lfdr.de];
	FORWARDED(0.00)[lists@lfdr.de];
	FORGED_SENDER(0.00)[maciej.fijalkowski@intel.com,netdev@vger.kernel.org];
	FORGED_SENDER_MAILLIST(0.00)[];
	FREEMAIL_CC(0.00)[vger.kernel.org,intel.com,gmail.com,redhat.com,kernel.org];
	FORGED_RECIPIENTS(0.00)[m:kuba@kernel.org,m:netdev@vger.kernel.org,m:bpf@vger.kernel.org,m:magnus.karlsson@intel.com,m:stfomichev@gmail.com,m:pabeni@redhat.com,m:horms@kernel.org,m:tushar.vyavahare@intel.com,m:kerneljasonxing@gmail.com,s:lists@lfdr.de];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:rdns,sea.lore.kernel.org:helo,vger.kernel.org:from_smtp,intel.com:dkim,intel.com:from_mime];
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
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	TAGGED_RCPT(0.00)[netdev];
	RCVD_COUNT_SEVEN(0.00)[10]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 755C36C706E

On Thu, Jun 25, 2026 at 07:36:36AM -0700, Jakub Kicinski wrote:
> On Thu, 25 Jun 2026 12:35:12 +0200 Maciej Fijalkowski wrote:
> > On Wed, Jun 24, 2026 at 07:33:26PM -0700, Jakub Kicinski wrote:
> > > On Tue, 23 Jun 2026 11:10:08 +0200 Maciej Fijalkowski wrote:  
> > > > Subject: [PATCH net-next] selftests/xsk: preserve UMEM view in bidi test  
> > > 
> > > Do you want it in net? Either way - we'll need a rebase  
> > 
> > I have not checked if this has been -net propagated already, but the rule
> > of thumb on bpf side was that all selftests related effort goes to -next.
> > Is it different on netdev side?
> 
> We prefer -next too, but during the merge window net-next is closed.
> 
> What we definitely don't want is a -next patch with a Fixes tag.
> So either net or drop the tag, please.

I have verified that offending commit is present in net tree. Could you
apply the v2 that I unfortunately sent already targeted at net-next, to
net tree?

