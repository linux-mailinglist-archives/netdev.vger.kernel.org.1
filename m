Return-Path: <netdev+bounces-272591-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id KNYrIfCSxmkyMAUAu9opvQ
	(envelope-from <netdev+bounces-272591-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Fri, 27 Mar 2026 15:23:44 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [104.64.211.4])
	by mail.lfdr.de (Postfix) with ESMTPS id 89702346029
	for <lists+netdev@lfdr.de>; Fri, 27 Mar 2026 15:23:43 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id 3ABF230086BB
	for <lists+netdev@lfdr.de>; Fri, 27 Mar 2026 14:20:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E9BDE3F0AB1;
	Fri, 27 Mar 2026 14:20:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="hjO9EhCZ"
X-Original-To: netdev@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.9])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BB3B7394463;
	Fri, 27 Mar 2026 14:20:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=192.198.163.9
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774621251; cv=fail; b=pBqgnklXu4u6LbI8ujb+njl9NL1xZo0Q0nTkwGeyNQmR2Ko71CPPO+eQDULtgxcQyqwEuzBHSfZIPw1iu6DRlwB1sN6b/FNpP6plEdVwyC+pAd5d8006/Ye8kqh726EVM9RafHaIu/D5jugHoKyT3nVlxAsCiH3UGS/1PHDCR0M=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774621251; c=relaxed/simple;
	bh=n/DhL+bC7UMDPz6fgRVj9tMp7KLfz2d1jCcef27wmSw=;
	h=Date:From:To:CC:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=rOGZxk4o5W85eQILix8f5j11jhYadSEH8nw6tFdmH7wMK2f1VYcTzyPGPuc8nFRAIwTzgVEuMz0B1Ww+DCq5Sf+fX/JMa1w5dh1y09GQhmZXvNQYkzcA6SuxnNSWqAf/K7D/73/s59hLD/uW6rn0GekpziYe5Pz1IvVH1TQkle4=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=hjO9EhCZ; arc=fail smtp.client-ip=192.198.163.9
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1774621250; x=1806157250;
  h=date:from:to:cc:subject:message-id:references:
   in-reply-to:mime-version;
  bh=n/DhL+bC7UMDPz6fgRVj9tMp7KLfz2d1jCcef27wmSw=;
  b=hjO9EhCZ73ZQ9e1UXHDmh3iW+yR7qzHJbi/Xls5PN9c1klv51hIA5jUv
   WDI1SnAZE9I4+0qAFs2B5Ux/GGzu2PChwsewX40GQvPQtd3pOs/tPgIOT
   XuJNlrLNZNgAmJtZFJunGJ/CVyoKv/ynGDaqvMTAn/XQicl1xrT6o2rKJ
   XI+tk2U7m59hxFcBvjLpO9NG5UEDoZEH12k1sA7lTuFgfEPltuCqWB4dG
   byDdtLzvR67wdRK54Pju2RdDwYiEiWqezRSJsEUj/VTw+IN4fu1OT16P9
   TAH7GKSLfsWTCkroeY5NgxVMpEsYX684zePIsMwCSxc9RZshg93OekDOl
   g==;
X-CSE-ConnectionGUID: 5jWpp1enRfmOWa3in3sttA==
X-CSE-MsgGUID: ReoJVAORTU2L8hcyg4DopA==
X-IronPort-AV: E=McAfee;i="6800,10657,11741"; a="86387619"
X-IronPort-AV: E=Sophos;i="6.23,144,1770624000"; 
   d="scan'208";a="86387619"
Received: from fmviesa005.fm.intel.com ([10.60.135.145])
  by fmvoesa103.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 27 Mar 2026 07:20:49 -0700
X-CSE-ConnectionGUID: hZxIDo+dQm+1h/2iyvVz4Q==
X-CSE-MsgGUID: n+k2oksgQJuMjy2RwNx1fg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.23,144,1770624000"; 
   d="scan'208";a="230099933"
Received: from fmsmsx903.amr.corp.intel.com ([10.18.126.92])
  by fmviesa005.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 27 Mar 2026 07:20:49 -0700
Received: from FMSMSX901.amr.corp.intel.com (10.18.126.90) by
 fmsmsx903.amr.corp.intel.com (10.18.126.92) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.37; Fri, 27 Mar 2026 07:20:48 -0700
Received: from fmsedg902.ED.cps.intel.com (10.1.192.144) by
 FMSMSX901.amr.corp.intel.com (10.18.126.90) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.37 via Frontend Transport; Fri, 27 Mar 2026 07:20:48 -0700
Received: from PH8PR06CU001.outbound.protection.outlook.com (40.107.209.9) by
 edgegateway.intel.com (192.55.55.82) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.37; Fri, 27 Mar 2026 07:20:48 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=kB1rCJaam4kZY5SC/lYngHd57XyOXNqbWcono3tIZcxMPqbXc2Zk1oqgusTFz3i3H8yP5WuVOUmkSYiit8A+ErGWMkbZtGxwhQgVNwCcsmlvaJTwpaPq2uHXhMQX/O1vZIvq9tZpIFlna5Dc6ADZBaLwY/YDg/scSQYhl5f+BBXj6SOh6206eJJsM39Fmf8HDZeApMs8AxavJc0Kmvh1FG22IQtBI0KjV9aD9kGN+ws/yNeuNY4WRN6/Wb5T1A4rasL0aY4i8zrQ9lIoRV+uvXjdae7GKZ1UYQgRCEDOAyWJvasIgg6cOXNeM0FYjlRemMdfOQqEGgOTmzLz8Apu6Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Y1SmRZwI5nMwxEiL/+mO2lx34zBNvQWfNaQ1aJYA87M=;
 b=BdibX+TtALZ5G9Eu5hMQa+2UtDxj3sXb2qumMBS2UHk6MyKwJk8BVfBzOv+YiWejuQWLBolIdwmuTnZMnI4v5YK2bVca3b+qM4BJqPCyb6bThHq5bxOGfRLUNfaRpmpNyAr0guBSl4hN22Z55FJE/KEUGT9q10uJg9muAnnZPsMFYUu8+jwUIH+rZAEY28sJ7fHxjLxCS6H3x8rHjMmLXvWT2YmAjCnJGnVNm1825gjI84Jb4UZYYxvwMesa9SYTAfXy4QVgqqTz8hwadUxYSIOQx7DKgUV1+0oCucCPNMc0TMyDbge2TvJrKGb0ds6UgivnVbG2moD5Eqy5iACnxg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from DM4PR11MB6117.namprd11.prod.outlook.com (2603:10b6:8:b3::19) by
 LV4PR11MB9489.namprd11.prod.outlook.com (2603:10b6:408:2e4::6) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9769.7; Fri, 27 Mar 2026 14:20:44 +0000
Received: from DM4PR11MB6117.namprd11.prod.outlook.com
 ([fe80::d9b3:e942:2686:3cdd]) by DM4PR11MB6117.namprd11.prod.outlook.com
 ([fe80::d9b3:e942:2686:3cdd%6]) with mapi id 15.20.9769.006; Fri, 27 Mar 2026
 14:20:44 +0000
Date: Fri, 27 Mar 2026 15:20:38 +0100
From: Maciej Fijalkowski <maciej.fijalkowski@intel.com>
To: Jakub Kicinski <kuba@kernel.org>
CC: <netdev@vger.kernel.org>, <bpf@vger.kernel.org>,
	<magnus.karlsson@intel.com>, <stfomichev@gmail.com>, <pabeni@redhat.com>,
	<horms@kernel.org>, <larysa.zaremba@intel.com>,
	<aleksander.lobakin@intel.com>, <bjorn@kernel.org>, Ihor Solodrai
	<ihor.solodrai@linux.dev>
Subject: Re: [PATCH v3 net 0/8] xsk: tailroom reservation and MTU validation
Message-ID: <acaSNnW8moIFNCMb@boxer>
References: <20260323192457.504631-1-maciej.fijalkowski@intel.com>
 <20260326202721.37382070@kernel.org>
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <20260326202721.37382070@kernel.org>
X-ClientProxiedBy: VI6PEPF00000216.AUTP296.PROD.OUTLOOK.COM
 (2603:10a6:808:1::8ce) To DM4PR11MB6117.namprd11.prod.outlook.com
 (2603:10b6:8:b3::19)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM4PR11MB6117:EE_|LV4PR11MB9489:EE_
X-MS-Office365-Filtering-Correlation-Id: 71998d56-98b7-4b9c-0168-08de8c0c0878
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|1800799024|366016|18002099003|22082099003|56012099003;
X-Microsoft-Antispam-Message-Info: ncUZue8mclDSmFxs+uIs2EiVk8doM3AVGqdpRZhasC+WGaViP6rHBcCwqlB33B4ATcA3bc+aMQaxhmX+JM05DrmZ2JLVO6a8w7n8x+YMQfdpyI3qMmAS9+10ksCruTvEA2f8IC1u2iUiqXil27WLgSCx8rqtm+NCnTtpHc1LS0aqSDM94WBbv7FSuLzZPzO/GY9LZIVTGAILoTpyinVksX5fXsJwbRAOYp6JZvZjz/Qvc9tdlQMcQXivKsem+aEmvyy0xQRLqhuEcJzKJe3VAnH6aTF7WmPqs1Ke4VOKH6uvVNfYCvGbEVMvXZ3ghpLUa6TGGQMfI9e7JxobjPUsknQHwTZLdFhtzZVP/7LBvBNIMMVh9KMc4zYdwhczjSmJin+IiVfljwO6LBBkTNVTbugLUIXs5Qtuh+QFLJkPWKpT3Aw28Jox4Ef/mkBosrlDZKCFnufNcPE0XGfGP3leQuKR/Ka463PL8+VXoUQTQ6pWV+1Py37eWZjm2wBSjCkPvUV/SDpG+aEg7fC0uofBnvw0ODEkBPDaL2BIC2lKxyR6lMWDRtS2WEap9bjLF2NLzHPJ/VE/ysaQa8btffOkgX4rmwQdod2czAbSJzVmP9JXoyayX7jgcSqYSCOTA8UmZpOM40IiEjNzvDbOWD75kIzSp0qsNiOS7XnGYPOo/q/jWZREqicSLyqGWaw8M5CmipOA2q1yChYINihdxiCbygEZfo6htCSmXPOioCAqpPY=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM4PR11MB6117.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(1800799024)(366016)(18002099003)(22082099003)(56012099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?NJI+5UcpLFJ219Ly1R9D623CKA7b1EjfYjJEWOwdtp8hd5yFnIGZfOg3ldyY?=
 =?us-ascii?Q?fFUnhIk+dsh6rhwXGHXfMdpg7kXjquzH+32mqpDVyyktXydluEwYWjDFuAGb?=
 =?us-ascii?Q?7WakelFJkbmmp0YVTQYCscPRcbXNuq8MMPVMdIZa76qTwKRucGjfQ+GiXDRV?=
 =?us-ascii?Q?DVCzRJ0cN4Uwvzjf7bKpqH7qpuBYY4/Zi/Z2XwB/h77jnwnJH47MmN9XgzhB?=
 =?us-ascii?Q?EFwneRVhBUN+KpnXQNAvmog+CTyuPk8rUJMvrJZsHEmy+7oNcVsaYfEjpgdq?=
 =?us-ascii?Q?fuWMQfcpu3KSIZWucxPzlunRuhWB6+RAMt6sBTqYC4HHlCY2UB9PyZVZQ/OM?=
 =?us-ascii?Q?fqqTx0fMGddmqQim7KByxpdxdte8dT+NgL12w/238zoSmw9kP06BOJ59tsRl?=
 =?us-ascii?Q?z/g361h+Q0S5ddUkEIajtinVp00vGXcaCIVej4zdYpLuHXtPIbg55jwWYI+S?=
 =?us-ascii?Q?k76P4g6fA37/ML8jciXEt+WHH9usY0jkCOHPhHfxc6xVTpZKH71MI17BjIkE?=
 =?us-ascii?Q?S4XlpyLDyOXZcAoYNvrqCz/VJnIgNrUTf1M+60nIa5x5i2qUJ1+HbKzDee0d?=
 =?us-ascii?Q?IrRlIaxdAY45edz9euUbDHgq7tKFVb5vjHKa02nMow8XeKOUY7jm47TS3NC8?=
 =?us-ascii?Q?2sTLeuNeGttx77HpQLL/TgQYRILBI/AUi7dHrF9KCU9EQVVBJeX3P4vkoimQ?=
 =?us-ascii?Q?NAXN+JhzbojseBPFuuI6vKAeQIK3ZHIYBJx5AKzO0Vy59txrXPYZJ/G25qh6?=
 =?us-ascii?Q?LcarBLekcQKTOCrERMtSjizqfQrHk0FPAgcrELxQesqEcDdRGSe1ycKWokfh?=
 =?us-ascii?Q?LUVZU8e5FHRxfr74MZghAP0qFvUIGYiDxCXvgoIyg8B7j+BUZxneo0vbb7Mz?=
 =?us-ascii?Q?42cRDviqmH/KcepZfeIG0nBc1C5xGY2lZBtzKsuFWmWOF7OODb6dEMO3/NLQ?=
 =?us-ascii?Q?ok8MySwhorXGnJ+1ecNIB65Q3VVh3/2SLKLCyXX/ohDo3PaZpxXSR+hJ/NqL?=
 =?us-ascii?Q?5sKpE5vt8lTn+6rpN+THyjpF5jXENbLtmwAEshaxpkzPfIJU7E+DbDRDn1V6?=
 =?us-ascii?Q?3yRtbmRzzMovo8xM6eCN4yl6HZOpwipg+OJNESt9SUplAJQp8Tjq061u3dCg?=
 =?us-ascii?Q?oPyVvIOIs3FIj2LzFhbL/5ezsrm9K92LPgVm+oxcIG7K6xw0HEDTSHLolm2q?=
 =?us-ascii?Q?u4WZ/EfUKlPAi6FdMemSv3z/9B+ZC2t42ODGkJfpImMqQh0LKwh8fPorBRRS?=
 =?us-ascii?Q?93L7ZW+W1LilZlD52Qqd1VkczO+bT8hB45SjEfNvGDJsDVbzoW/U1Lp741hn?=
 =?us-ascii?Q?9DOAQs584O0guhwwGxFJjJeWvacy/aP363D+cqX49HvDejYQe7UKHsFjOckE?=
 =?us-ascii?Q?ecwrQQwNOHzTGfhB/DSh2UHhPCM5mWG7Mem58pTu4A/qtrKPJaELnh1FwSfn?=
 =?us-ascii?Q?ihzOKTeD4ewjpRwL1Xf+NrfYRGn8DbzklAOcjOTnCxlbnoifiPkD73pCSTYd?=
 =?us-ascii?Q?6K4Y3GbRbzcz+CVng2SMzXxXleEnKCqZcJgIHNpamjKzhtsjS/mCI6v8C/j7?=
 =?us-ascii?Q?bm5npTMijZPKmPzs7MsO2j/X0IYveJA4XFVMjWhIBc2ZcmTtK3F2TD5ieiA2?=
 =?us-ascii?Q?f2pHByQ8SNnMosRCutyNK9SgyOFEgGiO5tJ9Doj53L52WwH6hCY+q2NyHAwc?=
 =?us-ascii?Q?fXGsTBS4br6OihKbe9qQBZaw/2+iZtmpQQEYZ9ILiklJ6lv/OO2IJilK+jwQ?=
 =?us-ascii?Q?MqMDhuXW7aK/bYNHzTqXsw148YfjXp0=3D?=
X-Exchange-RoutingPolicyChecked: ICKig3fqzGLXeyHIUjSjW1duHtnfC95kMh7x2tw/Uaal9qaP7GGKe86CThHxN9MmiBC1WomNnlYsL+ZFbY61c8rStMThMg0Fcxj4GuFUlr7poJHbkYbqSycx3HztUJrbaLPQAPM7KZPEgDWeZSkfSsbspXUNx7eyi4sMsUX1OUc1Slgyv56RR0ii0ylDIn/3MWTiN4zzJToQjYEZCfLExENvjDJoWhN702yUd1hAk/bgNxjYsfSaBZsYjU3vlZHK1Hm2qNLg0QNsEISV7OX7+ZFjveBa0OZvbEHhiom6W3jceKmCsfk6wJvsalKM2xtAmmCqWiEuVV07RMImwU6yLA==
X-MS-Exchange-CrossTenant-Network-Message-Id: 71998d56-98b7-4b9c-0168-08de8c0c0878
X-MS-Exchange-CrossTenant-AuthSource: DM4PR11MB6117.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 27 Mar 2026 14:20:44.4391
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: f0gofqlzHwlHBZwZPdy7GBDVltMO9E1NRffDqVrYpgRBLbt171Wu+nsEpdSbJbrL02cKWdtWkJnpEln6PDUDeNZkJj3mOmwxKPQ8JSxjz2E=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: LV4PR11MB9489
X-OriginatorOrg: intel.com
X-Spamd-Result: default: False [0.34 / 15.00];
	ARC_REJECT(1.00)[cv is fail on i=2];
	MID_RHS_NOT_FQDN(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[intel.com,none];
	R_SPF_ALLOW(-0.20)[+ip4:104.64.211.4:c];
	R_DKIM_ALLOW(-0.20)[intel.com:s=Intel];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FREEMAIL_CC(0.00)[vger.kernel.org,intel.com,gmail.com,redhat.com,kernel.org,linux.dev];
	TAGGED_FROM(0.00)[bounces-272591-lists,netdev=lfdr.de];
	DBL_BLOCKED_OPENRESOLVER(0.00)[intel.com:dkim,sin.lore.kernel.org:helo,sin.lore.kernel.org:rdns];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	DKIM_TRACE(0.00)[intel.com:+];
	MISSING_XM_UA(0.00)[];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[maciej.fijalkowski@intel.com,netdev@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[netdev];
	RCPT_COUNT_SEVEN(0.00)[11];
	ASN(0.00)[asn:63949, ipnet:104.64.192.0/19, country:SG];
	RCVD_COUNT_SEVEN(0.00)[10]
X-Rspamd-Queue-Id: 89702346029
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

On Thu, Mar 26, 2026 at 08:27:21PM -0700, Jakub Kicinski wrote:
> On Mon, 23 Mar 2026 20:24:49 +0100 Maciej Fijalkowski wrote:
> > here we fix a long-standing issue regarding multi-buffer scenario in ZC
> > mode - we have not been providing space at the end of the buffer where
> > multi-buffer XDP works on skb_shared_info. This has been brought to our
> > attention via [0].
> > 
> > Unaligned mode does not get any specific treatment, it is user's
> > responsibility to properly handle XSK addresses in queues.
> > 
> > With adjustments included here in this set against xskxceiver I have
> > been able to pass the full test suite on ice.
> 
> Please scream at me if I'm wrong but I _think_ this is somehow 
> breaking BPF CI ?? It's the only BPF change we have AFAICT and
> CI has been failing like this all day:
> 
> Root directory input is valid!
> Error: The path for one of the files in artifact is not valid: /packets-132-3-net_timestamping__INET4:_bpf_timestamping-net_timestamping_ns.log. Contains the following character:  Colon :
>           
> Invalid characters include:  Double quote ", Colon :, Less than <, Greater than >, Vertical bar |, Asterisk *, Question mark ?, Carriage return \r, Line feed \n
> 
> https://github.com/kernel-patches/bpf/actions/runs/23624136123/job/68809559810

That is probably due to this hang:
WATCHDOG: test case ns_xsk_drv/STAT_RX_DROPPED executes for 10 seconds...

Sorry for that! Please toss away v3 and v4 and let me resolve this.
I was too focused on the outcome of HW tests which I have been running via
xskxceiver. I need to see how to satisfy both sides.

Maciej

