Return-Path: <netdev+bounces-269039-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id EMvkDYi2umlWawIAu9opvQ
	(envelope-from <netdev+bounces-269039-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Wed, 18 Mar 2026 15:28:24 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [IPv6:2600:3c15:e001:75::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 34E802BD20B
	for <lists+netdev@lfdr.de>; Wed, 18 Mar 2026 15:28:23 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id 39A3630ED7D5
	for <lists+netdev@lfdr.de>; Wed, 18 Mar 2026 14:11:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 05E383DA7E9;
	Wed, 18 Mar 2026 14:09:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="DeUjgyCT"
X-Original-To: netdev@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6B0403DA7CE;
	Wed, 18 Mar 2026 14:09:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=198.175.65.12
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773842963; cv=fail; b=sJy1i8YrWjLIQZ3KpYCqrEZYTnOvW+2D0zjFIiDdn0tb3EFQAoCGzHk28oxxrrlZHR1Khit4xifA3kIKQZ3KGwyFQQzwZfmQHt8lUPfuPpxXHFjCgifmWazj3qTIqizlULoAs9pPkYrY5GMNdhRifzdJX34rWlcNXTZ4RcBYDY4=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773842963; c=relaxed/simple;
	bh=taMdGz6oHuj3TRwwPX1NcU289pS4Akq6A6uFKz/AqYs=;
	h=Date:From:To:CC:Subject:Message-ID:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=eUtHf8GYBIpEBzP/zVyg0HN67kbZrogPnUSt2iPs0dD3eNVEdZQZbnaxLNVh9ZNp3g6DOAtpWZGsqf+7W/mgOaEA+9pDEoUOHThwrigvaxAjusUeJ6yK+JwPsajz1rw2c7RJGubeZ3ZUr9mr08NC5iJLA3+re1exYKGcgOqRTFE=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=DeUjgyCT; arc=fail smtp.client-ip=198.175.65.12
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1773842961; x=1805378961;
  h=date:from:to:cc:subject:message-id:in-reply-to:
   mime-version;
  bh=taMdGz6oHuj3TRwwPX1NcU289pS4Akq6A6uFKz/AqYs=;
  b=DeUjgyCT/etXefz7EU+a7p92PAromGfsLTi/UBIbnceNozWPdW6VuigQ
   wSW4xfA90pGucnI7W5dwSFRcbgodUMuRJyHi/8TSNOh+MH9CS/tISjRzu
   ut499OvMCzU7+d35MjJMS1Yv/lo0oI/RGA/W8Q/R2OjH+aMqYIaDAK/Eu
   5M5Z/B3Cdq548suABLdBRbVt6ZSktVHAYbOrtED+JywukI3+HVHPeJOiZ
   k2tWS9jA5NGNaqXQOCnVoQmO9KT2TzE7ngAPzif0ADw0x8di1bAMz6WCU
   L/x4PLm2X3AS0Y31fAhfC52oj73Qd8aKuZWcBo7qZV549M5LM4pzv1f5i
   g==;
X-CSE-ConnectionGUID: JwIFE4HeRvy+Af2FVQ/0+g==
X-CSE-MsgGUID: dpu+N3iVS8SdgZIa3LA5fA==
X-IronPort-AV: E=McAfee;i="6800,10657,11733"; a="86372367"
X-IronPort-AV: E=Sophos;i="6.23,127,1770624000"; 
   d="scan'208";a="86372367"
Received: from orviesa010.jf.intel.com ([10.64.159.150])
  by orvoesa104.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 18 Mar 2026 07:09:21 -0700
X-CSE-ConnectionGUID: qnXqXkKtRV2s9aIyPCa/Tw==
X-CSE-MsgGUID: yVIgcB8UQAyZISHfF86amQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.23,127,1770624000"; 
   d="scan'208";a="221863131"
Received: from orsmsx901.amr.corp.intel.com ([10.22.229.23])
  by orviesa010.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 18 Mar 2026 07:09:20 -0700
Received: from ORSMSX903.amr.corp.intel.com (10.22.229.25) by
 ORSMSX901.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.37; Wed, 18 Mar 2026 07:09:19 -0700
Received: from ORSEDG901.ED.cps.intel.com (10.7.248.11) by
 ORSMSX903.amr.corp.intel.com (10.22.229.25) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.37 via Frontend Transport; Wed, 18 Mar 2026 07:09:19 -0700
Received: from DM1PR04CU001.outbound.protection.outlook.com (52.101.61.20) by
 edgegateway.intel.com (134.134.137.111) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.37; Wed, 18 Mar 2026 07:09:17 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=bhjKCYAnMuigyZsD1HcnImJ+o6URhfHvcOdoiPA9oM0WHBLUvzF07FMrLEfN6tN4vIXOLdMapHYe88VFgTnb6EkGmdXUWKWTO6HtDo7FVtXcS2itHSPwHljpnnucePEc7pKHJYDKR7Xm9Qv+RjJ0X7jEGAqdzZHc23L7MH5l8G2y6tWk8l/YUgUqlmbnV/z2wQ8BRx23Z+VvWAf/oizL6qHmcTn2xLQXqEB/VZlTPX8L8w1Ig7OpAm/nGLxuIH6XMjOcyxwpJmZIn9I08E0rVYAXbHRVuH8XtRsjLZQGOhp/ybqkyBJFUcf3y3xTx+F+i9leQwmJGL8aijh6/j1+xQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Or4xQfg5+aUiLxnC9OSQLOXHdAfCvfawaT5P63Pxi0w=;
 b=eC3UWY0R/WHHqBBrbf5HKy2zix7+2v/yRlyMqE9Hrx7FjcLuaeHrjFyhmSdnUSGMnqZcH0jW0+UK3ICmffiJONz6nkacYHNMfaW+f5Wfy3Ka0F/9iHFYJdDlbtB6OU/mIai1CQo0cFO3O2L3BM635zH5XhXGn+YlUZjkyje6o2ap8pXvBjyt1fLh9NNZqTKugqaKwGYqkhoPPGKXxLvvO2zudo/E+OXOC0Gg9btMDgQmCBiJV73cGoKICFBw7mJFA0jTskZ8YbjgTFMeqCwuKWcRMjTOg84vjqerHaLh0Tt5tLcu3YBGKrUpZ3WjJ5FTxwAldSvrMGRM9tV8mDsv3A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from PH0PR11MB5832.namprd11.prod.outlook.com (2603:10b6:510:141::7)
 by PH7PR11MB7513.namprd11.prod.outlook.com (2603:10b6:510:270::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9723.13; Wed, 18 Mar
 2026 14:09:13 +0000
Received: from PH0PR11MB5832.namprd11.prod.outlook.com
 ([fe80::106e:78dd:4c96:d707]) by PH0PR11MB5832.namprd11.prod.outlook.com
 ([fe80::106e:78dd:4c96:d707%3]) with mapi id 15.20.9723.013; Wed, 18 Mar 2026
 14:09:13 +0000
Date: Wed, 18 Mar 2026 22:09:05 +0800
From: kernel test robot <oliver.sang@intel.com>
To: Adrian Moreno <amorenoz@redhat.com>
CC: <oe-lkp@lists.linux.dev>, <lkp@intel.com>, <netdev@vger.kernel.org>,
	<dev@openvswitch.org>, Adrian Moreno <amorenoz@redhat.com>, Aaron Conole
	<aconole@redhat.com>, Eelco Chaudron <echaudro@redhat.com>, Ilya Maximets
	<i.maximets@ovn.org>, "David S. Miller" <davem@davemloft.net>, Eric Dumazet
	<edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>, Paolo Abeni
	<pabeni@redhat.com>, Simon Horman <horms@kernel.org>,
	<linux-kernel@vger.kernel.org>, <oliver.sang@intel.com>
Subject: Re: [PATCH net-next v1] net: openvswitch: decouple flow_table from
 ovs_mutex
Message-ID: <202603182149.54af5f9b-lkp@intel.com>
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <20260313173114.1220551-1-amorenoz@redhat.com>
X-ClientProxiedBy: TPYP295CA0056.TWNP295.PROD.OUTLOOK.COM (2603:1096:7d0:8::7)
 To PH0PR11MB5832.namprd11.prod.outlook.com (2603:10b6:510:141::7)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH0PR11MB5832:EE_|PH7PR11MB7513:EE_
X-MS-Office365-Filtering-Correlation-Id: bb416484-e28d-4103-700d-08de84f7eef9
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|376014|7416014|1800799024|7053199007|56012099003|18002099003|22082099003;
X-Microsoft-Antispam-Message-Info: U/9rVZytd7gNkz0fcATZwrakeXkpAHjO93Ffa3b0I1wCew/0JI2YdTL/sUBmEG+Jx0RfHAc1nt1DIdaE2SOOWyjkpXZh+fQngKE+JaLdcWgAuEXMaE5SR6SNJ/eThYvGgbv+Uu8/MZtkmKS+jQIo5apyPgeVTkT7XSUKp2uKzvEe/Hwg+VojIWKWOfupQFSY6pACuceL2WTELy7fIn5MWE7GrrIe/O8pBIF+weJIxrL0+oyOCqSwT9CRakGUq2icqJBE/Y5IBxRD3fI+fcS0ABui+H/gevdQaHgDgE2ga8mepw1vdTVNJp72lpQPLFZgAdtDUvLxDJySxNvxNr1c+L/3kfwR9wNCirxHBfqO2pW1DnXe5YFMcJK5RSxtOpRbD8kzX7CcA+JQ5nOZKU0kWo/1wpriljJU2B/Ma8+BWqCA0XPXlzncJJQ3kUQZYGbF5pQC1CQbYjrh/Xi4urncChmbJo3Y9wA1JGYzZzVeU9gtaMDVUYZ/ysATQsjtbDIwjbfZy5++hSQqTsxSRswJmU69zo79fn2yZKJV7+pVQ4DXnHbGb5ZWLvx6m9SNgXIwwxdrzclFCNMjH1MnIzb0M+uApBMkwhkPUu08kcfQtqe6n9PAo5d7enfsNTpw/iJTunOrwVnq7Yrg0qz6xHC3dYcRfRBGsbxiZJ9MznfB2lRqb/mVDwCuw5otDTRcKk4rUvg65empHm2D7b9bAajqBw==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH0PR11MB5832.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(376014)(7416014)(1800799024)(7053199007)(56012099003)(18002099003)(22082099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?J5IAf8V2bwv0pWnj5N0JFzbZE3kuGXrmc42mwQsF+sI/kzrL0s6FgaX2THBS?=
 =?us-ascii?Q?wJsv5zOdjMZnkzHrjuTspGHYC2UCTX9vo1Be5P0lWZjMrCCLW/QSt2Zuj1Kb?=
 =?us-ascii?Q?6QCOls3Ppjg+OFC0fmXa3TbN/0zlDzuXF6ZEyO3KHkeuc+yxHHfOzTZP78fT?=
 =?us-ascii?Q?ApWnKFRFaLQ9UduU9YbWggm+wuh1L1BmoZWyOStNiNUuOhghvla7GOBAQkWW?=
 =?us-ascii?Q?h9qCIK3KGBUEpV8w3X8v9EZK77Z9XW7T4UBMVe6whn/atMZ5U8cJKnnq7pzj?=
 =?us-ascii?Q?dJ/dwIjg75TF56KPzVSBVdJTg1/Ods3x3RQywBZrlo1OpNKpNLVm4pYJ839d?=
 =?us-ascii?Q?ILDcf/wyGBxrcyxjHtUdDRRqXIJ97x2g4OREPjorRjUe8jQbvs5GAjzkit60?=
 =?us-ascii?Q?2WV22XsoPd9od/m1MzIaINbPNZWdPVCK9d0AwZgboJ7T9WdPIuGFW7RFI7E9?=
 =?us-ascii?Q?YoRAYUeW3+OSY5ORiy9vgF0/CKXd7Gw3Lsw+dPS2BmHgfvnLpZ+ZrQ/uuV1S?=
 =?us-ascii?Q?Ijs0CfRi7jSbJMlMsDKOAhwYKsrxhwwwCntPPKR1ZKqQNIGNaSIifUr6fK5C?=
 =?us-ascii?Q?X8tdvBdI7xYYm5ZRB0D4tulkr7dFYWsP1WNVOSCWGjUr4/5jhYGeZBtswKQH?=
 =?us-ascii?Q?vT1tAyicycIEmfUxTGiAG1SYHRGScJ72slO/ScbFXAOOOvCzXrY87431Jyqh?=
 =?us-ascii?Q?XoKLYRVIfGbzyOLgMP8Ob9j6Ra2BuUVu5FDbzlkoD7qpK00utoHyONuWkrpz?=
 =?us-ascii?Q?TTAy0/VqegLSq8WfnAt5565E95CZELqTYK0RLye7I26wYlm5/LbtB7tHOm9F?=
 =?us-ascii?Q?0ZU5lsSinCwBCxuxFroI2HrOJ5Sbt3/WZsorGRw6t2tVjWEnvs8wPlMkTodS?=
 =?us-ascii?Q?TzuxBdVPeQZWERlwQIfRNt0jqcGal1YcYjPl6EGBcm8OlecB3eWzOUvMswrT?=
 =?us-ascii?Q?wbHygeCjlsOazib/FuvTziBtp75V8IiyRMLwesmCKMl5nx75LNJioo1AFoR2?=
 =?us-ascii?Q?08+dHyYaFNnkhcSN/Iw2SC23tyWdQXCueihzOpITKjEZRUdT4YDI2v/OX9tJ?=
 =?us-ascii?Q?tpAA+Bkutj95UK+/nmW2iwxY9iISyeKmBNlLxBXXEYtkwgDlhCwixfMUBVgr?=
 =?us-ascii?Q?hPS6n6Z7zI/CseWyHaMfxsS4DVUKDvwYI4++3iJAytFZsYXLbYeekCz4DDF5?=
 =?us-ascii?Q?s2SnOZeiurPWgS1jRcmbnPvE/+ZsQ4HZWbRHJrITiXuSrhmDQOy5toWyO9sI?=
 =?us-ascii?Q?ADlQmdH3CQiFwOwRV7s/CMi4h/4/vPXtq/Azyd3fC7jeXWLZGVhaTxlXDINI?=
 =?us-ascii?Q?q6ZOao6yaSTrj0MqUSbTKuJlurib6JpY1UCh+jUgATrQxUFdCpaKG6/07eiL?=
 =?us-ascii?Q?IheitaW7+uDlDLi5ZNwvuIW5yl7NTB4DCW+kHqCZdmudbaQKmxWWVzpeQ8da?=
 =?us-ascii?Q?oaeqcqL0n5zvLmgxf+GPRfUXf/h+rgsS8Y8D1UnQZTLyBHlt/bWFQeCuUPE/?=
 =?us-ascii?Q?3WNf3PMOLVKE4Z4ZLGm2OEVAYCpUq+Aeqe/0PJVq0j6wZy+jlpvpgJnWOrNp?=
 =?us-ascii?Q?tccNQW7MNwS727sElNF2MXC4S4RMSU0uR/M+jzZsKYc4XexnzzFZ2+53H1Jq?=
 =?us-ascii?Q?bmdiuUDw+F0hzXUtAiUQmwqY1ZJPyiIpcI8lVyjSq6lZ0olIbLUsO/CpDdFA?=
 =?us-ascii?Q?llAVW1PP1Rxmc4H2RJZX4SDTOlZJdYE2WN2jD7fj9jCyqLhcHXnfLRAIbnLO?=
 =?us-ascii?Q?gtAVi9PJ6Q=3D=3D?=
X-Exchange-RoutingPolicyChecked: s5MSiqzEGTx0JWpXM7wPLIpWYCzdk3ZsffvOkHqA+vdBvr1MAp3EtvIjMt04SrDSIRo/V+vtO2Qc/ItxWdIoH4Gle7J6cUbqv/LlC9en6W6OS51+A2EK/wR1muWT3DoX8O6mqjG9hPwfl0dHiqjgC3hl0in+sjeIks1nWV0Y9SQfWH2u2qjLHDDc4BWp2Cv5a7cakDLSlnogolbg8/k1p/fzrLeGMoK8PxPVDf11ATCsV7nuEd+Z6wu1rN8xM9TBcbdTlu3/bd524Tvw56ubLi+lsu4Zd+k8/U7DPIirFbgbJVitNW5k/3IpuUXPf3QNkkpGw7irLOhl2Zbg/lQyfw==
X-MS-Exchange-CrossTenant-Network-Message-Id: bb416484-e28d-4103-700d-08de84f7eef9
X-MS-Exchange-CrossTenant-AuthSource: PH0PR11MB5832.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 18 Mar 2026 14:09:13.6696
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 1UboQPZbZWPlIaFn5UtJZJ8Oq8hnKGtLi48BQqtAPOdD5DoDWWmIQhOV5MzqHZQcimR8iPcpCVCAWDVRgizwUw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR11MB7513
X-OriginatorOrg: intel.com
X-Spamd-Result: default: False [-0.16 / 15.00];
	ARC_REJECT(1.00)[cv is fail on i=2];
	DMARC_POLICY_ALLOW(-0.50)[intel.com,none];
	R_DKIM_ALLOW(-0.20)[intel.com:s=Intel];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c15:e001:75::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-269039-lists,netdev=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sin.lore.kernel.org:helo,sin.lore.kernel.org:rdns,intel.com:dkim,intel.com:email,intel.com:mid,01.org:url];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[16];
	DKIM_TRACE(0.00)[intel.com:+];
	MISSING_XM_UA(0.00)[];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[oliver.sang@intel.com,netdev@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	NEURAL_HAM(-0.00)[-0.993];
	TAGGED_RCPT(0.00)[netdev];
	MID_RHS_MATCH_FROM(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c15::/32, country:SG];
	RCVD_COUNT_SEVEN(0.00)[10]
X-Rspamd-Queue-Id: 34E802BD20B
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr



Hello,

kernel test robot noticed "WARNING:suspicious_RCU_usage" on:

commit: e556fbe58fe8144bc9e7f0909344b22af53c05ce ("[PATCH net-next v1] net: openvswitch: decouple flow_table from ovs_mutex")
url: https://github.com/intel-lab-lkp/linux/commits/Adrian-Moreno/net-openvswitch-decouple-flow_table-from-ovs_mutex/20260314-152511
base: https://git.kernel.org/cgit/linux/kernel/git/davem/net-next.git 9089c5f3c444ad6e9eb172e9375615ed0b0bc31c
patch link: https://lore.kernel.org/all/20260313173114.1220551-1-amorenoz@redhat.com/
patch subject: [PATCH net-next v1] net: openvswitch: decouple flow_table from ovs_mutex

in testcase: boot

config: x86_64-randconfig-013-20260317
compiler: clang-20
test machine: qemu-system-x86_64 -enable-kvm -cpu SandyBridge -smp 2 -m 32G

(please refer to attached dmesg/kmsg for entire log/backtrace)



If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <oliver.sang@intel.com>
| Closes: https://lore.kernel.org/oe-lkp/202603182149.54af5f9b-lkp@intel.com



[   67.815648][   T24] WARNING: suspicious RCU usage
[   67.819156][   T24] 7.0.0-rc3-00655-ge556fbe58fe8 #1 Tainted: G                T
[   67.821304][   T24] -----------------------------
[   67.822695][   T24] net/openvswitch/datapath.c:2666 RCU-list traversed in non-reader section!!
[   67.825209][   T24]
[   67.825209][   T24] other info that might help us debug this:
[   67.825209][   T24]
[   67.828074][   T24]
[   67.828074][   T24] rcu_scheduler_active = 2, debug_locks = 1
[   67.830500][   T24] 3 locks held by kworker/0:2/24:
[   67.831886][   T24]  #0: ffff88810007db40 ((wq_completion)events){+.+.}-{0:0}, at: process_scheduled_works (kernel/workqueue.c:3250)
[   67.835011][   T24]  #1: ffff88810184fd30 ((work_completion)(&(&ovs_net->masks_rebalance)->work)){+.+.}-{0:0}, at: process_scheduled_works (kernel/workqueue.c:3251)
[   67.841040][   T24]  #2: ffffffff96bd5220 (ovs_mutex){+.+.}-{4:4}, at: ovs_dp_masks_rebalance (net/openvswitch/datapath.c:2666)
[   67.843339][   T24]
[   67.843339][   T24] stack backtrace:
[   67.844454][   T24] CPU: 0 UID: 0 PID: 24 Comm: kworker/0:2 Tainted: G                T   7.0.0-rc3-00655-ge556fbe58fe8 #1 PREEMPT(lazy)
[   67.846651][   T24] Tainted: [T]=RANDSTRUCT
[   67.846651][   T24] Workqueue: events ovs_dp_masks_rebalance
[   67.846651][   T24] Call Trace:
[   67.846651][   T24]  <TASK>
[   67.846651][   T24]  dump_stack_lvl (lib/dump_stack.c:123)
[   67.846651][   T24]  lockdep_rcu_suspicious (kernel/locking/lockdep.c:6877)
[   67.846651][   T24]  ovs_dp_masks_rebalance (net/openvswitch/datapath.c:?)
[   67.846651][   T24]  ? process_scheduled_works (kernel/workqueue.c:3251)
[   67.846651][   T24]  process_scheduled_works (kernel/workqueue.c:?)
[   67.846651][   T24]  worker_thread (kernel/workqueue.c:?)
[   67.846651][   T24]  ? _raw_spin_unlock_irqrestore (arch/x86/include/asm/preempt.h:104 kernel/locking/spinlock.c:194)
[   67.846651][   T24]  kthread (kernel/kthread.c:438)
[   67.846651][   T24]  ? worker_attach_to_pool (kernel/workqueue.c:3385)
[   67.846651][   T24]  ? kthread_unuse_mm (kernel/kthread.c:381)
[   67.846651][   T24]  ret_from_fork (arch/x86/kernel/process.c:164)
[   67.846651][   T24]  ? kthread_unuse_mm (kernel/kthread.c:381)
[   67.846651][   T24]  ret_from_fork_asm (arch/x86/entry/entry_64.S:258)
[   67.846651][   T24]  </TASK>


The kernel config and materials to reproduce are available at:
https://download.01.org/0day-ci/archive/20260318/202603182149.54af5f9b-lkp@intel.com



-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki


