Return-Path: <netdev+bounces-160186-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A0A9EA18B1C
	for <lists+netdev@lfdr.de>; Wed, 22 Jan 2025 05:47:56 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id CC6F61633D1
	for <lists+netdev@lfdr.de>; Wed, 22 Jan 2025 04:47:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9AC7C1586CF;
	Wed, 22 Jan 2025 04:47:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="T6jDT6Dg"
X-Original-To: netdev@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.11])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 97BCA139CEF
	for <netdev@vger.kernel.org>; Wed, 22 Jan 2025 04:47:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=198.175.65.11
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1737521272; cv=fail; b=CisDgNd3ReS+7Z5IPrg6nDpCd5Z052bqzB7wQWJ2QIxF3syNO1sU4RULAEpubD0WY5/6tMELOjRhBnk71cYg3n/Me5D4dlfdbb5SaRXHfophkKQHob7wwwn1XY7qCIvZFYDu45srQ6JJzyudiRFoXLsqkOiGoBbApLAhPMO4gtI=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1737521272; c=relaxed/simple;
	bh=flrqgFnn7QhJwBN2l19Ds4oJOKsMOdP61gI3D/Ov6Zk=;
	h=Date:From:To:CC:Subject:Message-ID:Content-Type:
	 Content-Disposition:MIME-Version; b=n19aMkm7X5w3SZjdpZqUzu/upm9868A4l+AZDn4HFlAzdARxs+py0uDxIYs3yUvY+u9nt8kZClEuoz3IXcUoqgVy72ohNigVaxdelhOe/YGqvVNlrwBvq+bx+sJgcfCGZ2udYGt/lc1VXxpXUMx52Y4VLcxsjUNlT0I9O8SfYe8=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=T6jDT6Dg; arc=fail smtp.client-ip=198.175.65.11
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1737521270; x=1769057270;
  h=date:from:to:cc:subject:message-id:mime-version;
  bh=flrqgFnn7QhJwBN2l19Ds4oJOKsMOdP61gI3D/Ov6Zk=;
  b=T6jDT6DgsKfnYzUwC2zrfbxYLWpqJIGGw88L3U33hFyhWaz1ZtOjYso2
   kekMudrNHsK9y1Ab1rtoYZDEJMKZNC4d0kZfY42f29WVTt04oWuNr60dU
   yFK+94K80KHFPONX5gtFhFYBaf319jOVOxV87LundwnSYUE693YL71evC
   zbaMc73VAfmL+KTuanQi9PXUI5epcat7Nb3j5tJ9upJky3GyEA08zFj88
   Mr/lF0k6qHIBAmzxp213wQhXWef+9zLBi6GOHWvBQjCHpxt1hGtxotWs9
   qOgWJk3UzFoJSck/6A1LVR/G6vpftl619zcFDi+tlqJo5MIDdwpmA4nGt
   Q==;
X-CSE-ConnectionGUID: eqLHEGDwTTqS6E6CezkDDg==
X-CSE-MsgGUID: cTD6RiPJSOSLR6GrJzTxLw==
X-IronPort-AV: E=McAfee;i="6700,10204,11322"; a="48456555"
X-IronPort-AV: E=Sophos;i="6.13,224,1732608000"; 
   d="scan'208";a="48456555"
Received: from fmviesa001.fm.intel.com ([10.60.135.141])
  by orvoesa103.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 21 Jan 2025 20:47:50 -0800
X-CSE-ConnectionGUID: M8eqT779Sk+ivSWX2a/+Xg==
X-CSE-MsgGUID: X3H01mnoRSKvvvrpUrsEZg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.12,224,1728975600"; 
   d="scan'208";a="137895862"
Received: from orsmsx603.amr.corp.intel.com ([10.22.229.16])
  by fmviesa001.fm.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 21 Jan 2025 20:47:50 -0800
Received: from orsmsx603.amr.corp.intel.com (10.22.229.16) by
 ORSMSX603.amr.corp.intel.com (10.22.229.16) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.44; Tue, 21 Jan 2025 20:47:49 -0800
Received: from orsedg603.ED.cps.intel.com (10.7.248.4) by
 orsmsx603.amr.corp.intel.com (10.22.229.16) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.44 via Frontend Transport; Tue, 21 Jan 2025 20:47:49 -0800
Received: from NAM11-CO1-obe.outbound.protection.outlook.com (104.47.56.174)
 by edgegateway.intel.com (134.134.137.100) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.44; Tue, 21 Jan 2025 20:47:49 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=foSWbi4eJtvnJKhSAgEfjoWjtn3vrapqGeEkvt5iPkFCOf1tcr5C8z14kNtpMq2LVc5Mi5Ve/5TfQaeOvNFPSeCm54TtoHf+nNrPe0I83mg3xKj35EHqcV0XTzIgBGmO3BscpUWUwg9gymJL2AW3JbnpGLYf9bZh/pJayKIriMSJO7z2hYCDHF/htMzkMerXUSggiA9FFzZA6mCKc9GwE1PdM6KidPaUmoYhrvPkLpeeQWRqvfM4FINbAlcOrvpzBY9w+6Xo6rgtEw5i3I/jiAmZgCE06dV9JWp8fPMVS2vJHrlLFDe++tgcEATj9xAPdbAdaoW7WU1uc/3kFNfn+w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ZHY+gNZ0WLclhgQpH08F2XARlsG8mPSgsTggJ0iKhUI=;
 b=uwmbCvHvJ9JWTuRnbuaHPYxXKwFfpX1+tyz0UcZ3XP5da3sWFvX7P4Mh0D8QbDkn9IQE4Sx3giLTktvx/VxYubCGNH6yXoabLhZhtlB1KJdBdTE50QazqaB/WLilSc4jcipcr6oH5av5rrmL4tq/tMzGNP62XCBB2uV7+O9dDS/9O5M1exOrU0BiALoNyAY5IeR5kmZ/ZY00CNL/4wdWzbnwLvaMZDHwuyfWwjwHlRNXieZD6VNUoKtBoWfE6+rrRiM9R5ye6wgyy2NC4kZ9iS3yNb9wUU2y19uid3wKLJy2TkkWn1LljKy02U7u4r8SWw6om/SrMMi8V03oStDnRQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from LV3PR11MB8603.namprd11.prod.outlook.com (2603:10b6:408:1b6::9)
 by CO1PR11MB5060.namprd11.prod.outlook.com (2603:10b6:303:93::5) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8377.16; Wed, 22 Jan
 2025 04:47:29 +0000
Received: from LV3PR11MB8603.namprd11.prod.outlook.com
 ([fe80::4622:29cf:32b:7e5c]) by LV3PR11MB8603.namprd11.prod.outlook.com
 ([fe80::4622:29cf:32b:7e5c%3]) with mapi id 15.20.8356.020; Wed, 22 Jan 2025
 04:47:29 +0000
Date: Wed, 22 Jan 2025 12:47:20 +0800
From: kernel test robot <oliver.sang@intel.com>
To: Russell King <rmk+kernel@armlinux.org.uk>
CC: <oe-lkp@lists.linux.dev>, <lkp@intel.com>, Jakub Kicinski
	<kuba@kernel.org>, Jacob Keller <jacob.e.keller@intel.com>,
	<netdev@vger.kernel.org>, <oliver.sang@intel.com>
Subject: [linux-next:master] [net]  03abf2a7c6: WARNING:suspicious_RCU_usage
Message-ID: <202501221104.9fe82ac4-lkp@intel.com>
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
X-ClientProxiedBy: SI2PR01CA0016.apcprd01.prod.exchangelabs.com
 (2603:1096:4:191::20) To LV3PR11MB8603.namprd11.prod.outlook.com
 (2603:10b6:408:1b6::9)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: LV3PR11MB8603:EE_|CO1PR11MB5060:EE_
X-MS-Office365-Filtering-Correlation-Id: 04d22c15-17ea-4671-e3ce-08dd3a9fe00a
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|376014|366016;
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?9GKw+wiZ2I7aMLASnS7XwaNx/ie+Vb5btCjbZdpDhs7u02UhXBH8F8zLMYjA?=
 =?us-ascii?Q?KOa9W6twd+V/wC1PpDHtmY+VRwf1Mpr13HgAwT5e6cHYWZQ4g3hHFoiJx/V4?=
 =?us-ascii?Q?wYNFEvh4RTt8bMeZ+CRCHDxwkNyh1NIsnUYsPVqj1I4fGY0SMoEbADAR9yYq?=
 =?us-ascii?Q?Ft8O3K9w7Vibiw18hkxtUt8rpE+EKi8V6+YRbJCzT7WIWZTk93RtLMlyiqb2?=
 =?us-ascii?Q?mjiozLcTs8PES0CUSgdD6IYApnTkWeksuPW6z2QknX8WL4cTK2NIYt80v5Ri?=
 =?us-ascii?Q?x4VC8FlGzLN1dmGDkfyjf5uiBpljJ12tJLcsnOEMh6zvyKxfFWeADZFA6e5u?=
 =?us-ascii?Q?ncs1ePTFLPqjqyyANIaYvCXfT7UjOM4txdpc5S1GhltL1aXDLPVCR0yjnAct?=
 =?us-ascii?Q?UFKhaXC0aFUxqSbROPUOJi3fVU7HZrr0NsBjwlgDWLZIZg5hIDGNYCyXmJkD?=
 =?us-ascii?Q?yJ/kEA7Mkdwg94m0Ur8/YjTcDC7n9l5vRiole+wRXmXiIcuvMhx1orXtpVoU?=
 =?us-ascii?Q?uKC3es0AtlkrmGH5wyM1G/v4eW9nsPFom265moCtQ6UOIkSN7To3yug158fn?=
 =?us-ascii?Q?jkkGM3ay3IeT6fsl68/S3osBDukGF5LX3i7+Hrzfh1SMX7Lj/zSrneW465fq?=
 =?us-ascii?Q?nM7C7FsXipH32PWdbVzIg6QHOjZnibRnBHWiqSZVXBrCHvl1KOoRCLkQBJ9i?=
 =?us-ascii?Q?v0SRt7aTzh0kI38x8ZpzOo1SSxMuUrPP4UAdcBMlz6R2F/21yS5EAbi0ev1q?=
 =?us-ascii?Q?7iiHL2zJCV1/81IjSHQ8hSD9/xYBi/dgb2ZqDuW7+dxh1Ftn1W/F/aLH3BjB?=
 =?us-ascii?Q?dbfuChZqZCTLd+8pR/l9vP+xJSvw2wG+XWE2xYChDHE4WTDwBrMurpfe1UWt?=
 =?us-ascii?Q?Vs/dVa6YwJHE7oNeIBks1VZNa6NZv6FEpAtcWwcu+t6p0aRcFJ78Xd2PwJlT?=
 =?us-ascii?Q?mlLeFsI3vPpeDQl/TRWx2ClT1HSQsBip7L8eJAdKZrYwqbclb0kmNsBYjiTw?=
 =?us-ascii?Q?4Eb2G01N72tVE0EX3Ex9SIUaPxmqewCZz264ghMuAGcHy+t3ki0K+LKNyX5a?=
 =?us-ascii?Q?0PyQnsCJl45CuigpVmJTPyJCwp0MYYDbMb2qH2UfGHq+Z+0C/nHhnec/yClS?=
 =?us-ascii?Q?EfozkFOdFWui1lQ8VvA0MpB611jlvgmPWxJ3l8eOFGqrsn76J78emRaaa6Hz?=
 =?us-ascii?Q?PfsJQHNBeSOYJsEPtJW/YnSet8HQR7Z2jMZsK23IfSqXM5wgrgg4NsPxQ02k?=
 =?us-ascii?Q?ZI8h+Y2lE5tIurppJFxF8g6ExnEXcyWAYYoRnIi2e9wBrNjMY6vqX88aVx/7?=
 =?us-ascii?Q?YpMxpxzRGubsFrP0TKiVHSr6hHME/cgsXCIu3PialELbxA=3D=3D?=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:LV3PR11MB8603.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(376014)(366016);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?llnIreLllP0nuHU5EgL7mcoysk6qbKTfc0Mw81KsOiOTvYtgtRQRrHcO396W?=
 =?us-ascii?Q?ZEuQiN7074hOcNcta2Y91YIW5VsIgh5teuzwUYCm1BPJzhXSZVYDgk/qYMu6?=
 =?us-ascii?Q?NbyOAj6bubKLPfRGgkBzycdigrTqWWM6W6mUQ5nHdeQQRDx4eWHxUCp/qM/3?=
 =?us-ascii?Q?gspAb+aIiIGtdmjUOy9UG3nKzS1HZSkJES0iw4L9e9ex3I2VKnvXxfoG+yYP?=
 =?us-ascii?Q?hXu9Rr6fqit11ix6KoIYxoJJUPemK3Jl+bHa3rhvdrNEF1vv4ZDtSBY5XejD?=
 =?us-ascii?Q?CcOLe32YVg8xyiElfCOMI3rQ+JhPoZGBqKyVuUo8my+4/+/Xpr+Owope+R+d?=
 =?us-ascii?Q?dtzIXMx4JbNaENFwwqT0zZI3B6SboXJFuwTCvAVJVNDs0xvEV0942spsSFOM?=
 =?us-ascii?Q?g91xjkaKJlEVO+qhJJkirGzuVB+CnqI3dThrMfCXqz/OOIc0PWakO40HESRQ?=
 =?us-ascii?Q?d+K3QzxX5bZoSY91rJKUdJSfMoKJqStz5nIFFlSxnnsSzh2h6m4zXCu2URdu?=
 =?us-ascii?Q?VZE0T4FanHWV62LnOF8g8byrUvIE3VW5mePCFuHucwWJE7wGd4QODWJ4qRpS?=
 =?us-ascii?Q?jXC85nBpmHlZ8yMHspaj4Mx1f1FpiQRt/EDaf1CLy8aQpPwleHNSh9j+Ruki?=
 =?us-ascii?Q?yCPAWLfgDl9U0Wl/emi0wJPXz9equqQdDQJ6+IkiQbBYMUXVwFntCAYQhHar?=
 =?us-ascii?Q?/Tu0yvDQ+4vJqtuKnKgm68JqyUF8bXgSRCiKX9lLQhIt+N/V1mGV4m2YVzuH?=
 =?us-ascii?Q?bzwpbFDzZOiVsi1GH1MWT6iR+Kv2AxudnwysIQoBk+PAUJRE9rL7BY+fhNvZ?=
 =?us-ascii?Q?MHpHF6Hyq+9r4zMj9+vFuAIijezxGtyYSoN9/0vQvS8XSFH6ks0BAlacVW+r?=
 =?us-ascii?Q?obfu/0DBKnXOlxGbZy+wY79tm9HKz6lR8G2O5FfoObI6pxPNq4L0QAs5xohT?=
 =?us-ascii?Q?8ScPPc/BxsmEWJKOYoWmU+JWcezGTB8F2STRPgIaepVg4tzTgzJh3EiBD9j5?=
 =?us-ascii?Q?EsE7sSWX3xFKcH/7qH24FWa+5sDPWGVoYu9omRdTpikNZlefod/7yS3rcELI?=
 =?us-ascii?Q?fDq1cDbB7b8+ygnRqa/DcLwVhwdfpVuPlQ9cQot8t2dVN1Tl9A8aCwhf00xX?=
 =?us-ascii?Q?ihHIVkEjax3zTuV7EKp6a5r9lt2mxPk2RBFjxaUsiJbtFxdSL0Si4hMXKxCh?=
 =?us-ascii?Q?upAIaPAszKwEzTys6+4gj1fX6YYW5ybwQNonVareqM/psSrSLHmnVPJhLUFY?=
 =?us-ascii?Q?wT6U1jsPmw+GSWWuzw1MV/tNZfQ8KqZXJzBLgHPHxJySFr6IkNdV/IDvXCb5?=
 =?us-ascii?Q?1gaMp/pS7Go5vRf9ETpmJC2GolWxOjaAxJVO2t5i6f97dtuvPQHIF3oDlbgg?=
 =?us-ascii?Q?cajVV1+Di/yTH5M+HOyTGZisBn0PsJ+Af9eWcmZOjnSctCJWllSOkPB5qRui?=
 =?us-ascii?Q?gWBwnsxCL7VvY9jt9pYXhDKIPdRNNN4TUxGRc986VR+riMl0G6ufqTn9AVSZ?=
 =?us-ascii?Q?ab5hayEa+/Zcus92qaJt7DPZHQf6TQq4eHE3JPSruNALVxNuh/1Wsj1l5YHv?=
 =?us-ascii?Q?8ch6KYTn9Kq7hczSdlyTta4hexQeqPc5/iGkrVLYQ47YHa4CAXbn5wotrGg+?=
 =?us-ascii?Q?6w=3D=3D?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 04d22c15-17ea-4671-e3ce-08dd3a9fe00a
X-MS-Exchange-CrossTenant-AuthSource: LV3PR11MB8603.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 22 Jan 2025 04:47:29.0525
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 6UggejJ7cEkzW/1hp2P9GPMvPYJex33JIvaLyxR+h+zx+tpvoCrPqJX/MAj4a75tE+udtpal5Klhqqt3OYishA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CO1PR11MB5060
X-OriginatorOrg: intel.com



Hello,

kernel test robot noticed "WARNING:suspicious_RCU_usage" on:

commit: 03abf2a7c65451e663b078b0ed1bfa648cd9380f ("net: phylink: add EEE management")
https://git.kernel.org/cgit/linux/kernel/git/next/linux-next.git master

[test failed on linux-next/master f066b5a6c7a06adfb666b7652cc99b4ff264f4ed]

in testcase: boot

config: i386-randconfig-141-20250120
compiler: clang-19
test machine: qemu-system-i386 -enable-kvm -cpu SandyBridge -smp 2 -m 4G

(please refer to attached dmesg/kmsg for entire log/backtrace)


+---------------------------------------------------------------------------+------------+------------+
|                                                                           | a17ceec62f | 03abf2a7c6 |
+---------------------------------------------------------------------------+------------+------------+
| WARNING:suspicious_RCU_usage                                              | 0          | 12         |
| drivers/net/phy/phy_device.c:#suspicious_rcu_dereference_protected()usage | 0          | 12         |
+---------------------------------------------------------------------------+------------+------------+


If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <oliver.sang@intel.com>
| Closes: https://lore.kernel.org/oe-lkp/202501221104.9fe82ac4-lkp@intel.com


[    9.233895][    T7] WARNING: suspicious RCU usage
[    9.234510][    T7] 6.13.0-rc7-01139-g03abf2a7c654 #1 Tainted: G                T
[    9.235566][    T7] -----------------------------
[    9.236305][    T7] drivers/net/phy/phy_device.c:2004 suspicious rcu_dereference_protected() usage!
[    9.237605][    T7]
[    9.237605][    T7] other info that might help us debug this:
[    9.237605][    T7]
[    9.239057][    T7]
[    9.239057][    T7] rcu_scheduler_active = 2, debug_locks = 1
[    9.240153][    T7] 4 locks held by kworker/u4:0/7:
[ 9.240882][ T7] #0: c5111cc0 ((wq_completion)events_unbound){+.+.}-{0:0}, at: process_one_work (kernel/workqueue.c:3211) 
[ 9.242349][ T7] #1: c951bef0 (deferred_probe_work){+.+.}-{0:0}, at: process_one_work (kernel/workqueue.c:?) 
[ 9.243712][ T7] #2: c75e6c80 (&dev->mutex){....}-{4:4}, at: __device_attach (drivers/base/dd.c:1006) 
[ 9.244868][ T7] #3: c3f31254 (dsa2_mutex){+.+.}-{4:4}, at: dsa_register_switch (net/dsa/dsa.c:1499) 
[    9.246218][    T7]
[    9.246218][    T7] stack backtrace:
[    9.247150][    T7] CPU: 0 UID: 0 PID: 7 Comm: kworker/u4:0 Tainted: G                T  6.13.0-rc7-01139-g03abf2a7c654 #1
[    9.248636][    T7] Tainted: [T]=RANDSTRUCT
[    9.249165][    T7] Workqueue: events_unbound deferred_probe_work_func
[    9.250080][    T7] Call Trace:
[ 9.250503][ T7] dump_stack_lvl (lib/dump_stack.c:? lib/dump_stack.c:120) 
[ 9.251092][ T7] dump_stack (lib/dump_stack.c:129) 
[ 9.251610][ T7] lockdep_rcu_suspicious (kernel/locking/lockdep.c:6846) 
[ 9.252284][ T7] phy_detach (drivers/net/phy/phy_device.c:2004) 
[ 9.252804][ T7] phylink_connect_phy (drivers/net/phy/phylink.c:?) 
[ 9.253421][ T7] dsa_user_create (net/dsa/user.c:2657) 
[ 9.254067][ T7] dsa_port_setup (net/dsa/dsa.c:523) 
[ 9.254648][ T7] dsa_register_switch (net/dsa/dsa.c:759 net/dsa/dsa.c:888 net/dsa/dsa.c:1525 net/dsa/dsa.c:1539) 
[ 9.255298][ T7] dsa_loop_drv_probe (drivers/net/dsa/dsa_loop.c:343) 
[ 9.255927][ T7] mdio_probe (drivers/net/phy/mdio_device.c:166) 
[ 9.256445][ T7] really_probe (drivers/base/dd.c:581) 
[ 9.257004][ T7] __driver_probe_device (drivers/base/dd.c:800) 
[ 9.257624][ T7] ? lockdep_hardirqs_on_prepare (kernel/locking/lockdep.c:? kernel/locking/lockdep.c:4406) 
[ 9.258384][ T7] ? trace_hardirqs_on (kernel/trace/trace_preemptirq.c:80) 
[ 9.259006][ T7] driver_probe_device (drivers/base/dd.c:830) 
[ 9.259624][ T7] __device_attach_driver (drivers/base/dd.c:959) 
[ 9.260257][ T7] ? coredump_store (drivers/base/dd.c:922) 
[ 9.260846][ T7] bus_for_each_drv (drivers/base/bus.c:459) 
[ 9.261459][ T7] __device_attach (drivers/base/dd.c:1030) 
[ 9.274224][ T7] ? coredump_store (drivers/base/dd.c:922) 
[ 9.274849][ T7] device_initial_probe (drivers/base/dd.c:1080) 
[ 9.275481][ T7] bus_probe_device (drivers/base/bus.c:536) 
[ 9.276057][ T7] deferred_probe_work_func (drivers/base/dd.c:124) 
[ 9.276734][ T7] process_one_work (kernel/workqueue.c:3241) 
[ 9.277401][ T7] worker_thread (kernel/workqueue.c:3311 kernel/workqueue.c:3398) 
[ 9.278006][ T7] kthread (kernel/kthread.c:391) 
[ 9.278532][ T7] ? worker_attach_to_pool (kernel/workqueue.c:3344) 
[ 9.279213][ T7] ? kthread_blkcg (kernel/kthread.c:342) 
[ 9.279803][ T7] ? kthread_blkcg (kernel/kthread.c:342) 
[ 9.280398][ T7] ret_from_fork (arch/x86/kernel/process.c:153) 
[ 9.280951][ T7] ret_from_fork_asm (arch/x86/entry/entry_32.S:737) 
[ 9.281536][ T7] entry_INT80_32 (arch/x86/entry/entry_32.S:945) 
[    9.282546][    T7] dsa-loop fixed-0:1f lan1 (uninitialized): failed to connect to PHY: -EPERM
[    9.283900][    T7] dsa-loop fixed-0:1f lan1 (uninitialized): error -1 setting up PHY for tree 0, switch 0, port 0
[    9.285629][    T7] dsa-loop fixed-0:1f lan2 (uninitialized): PHY [dsa-0.0:01] driver [Generic PHY] (irq=POLL)
[    9.287170][    T7] dsa-loop fixed-0:1f lan2 (uninitialized): failed to connect to PHY: -EPERM
[    9.288436][    T7] dsa-loop fixed-0:1f lan2 (uninitialized): error -1 setting up PHY for tree 0, switch 0, port 1
[    9.290098][    T7] dsa-loop fixed-0:1f lan3 (uninitialized): PHY [dsa-0.0:02] driver [Generic PHY] (irq=POLL)
[    9.291626][    T7] dsa-loop fixed-0:1f lan3 (uninitialized): failed to connect to PHY: -EPERM
[    9.292898][    T7] dsa-loop fixed-0:1f lan3 (uninitialized): error -1 setting up PHY for tree 0, switch 0, port 2
[    9.294593][    T7] dsa-loop fixed-0:1f lan4 (uninitialized): PHY [dsa-0.0:03] driver [Generic PHY] (irq=POLL)
[    9.296110][    T7] dsa-loop fixed-0:1f lan4 (uninitialized): failed to connect to PHY: -EPERM
[    9.297398][    T7] dsa-loop fixed-0:1f lan4 (uninitialized): error -1 setting up PHY for tree 0, switch 0, port 3
[    9.299343][    T7] DSA: tree 0 setup
[    9.299993][    T7] dsa-loop fixed-0:1f: DSA mockup driver: 0x1f


The kernel config and materials to reproduce are available at:
https://download.01.org/0day-ci/archive/20250122/202501221104.9fe82ac4-lkp@intel.com



-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki


