Return-Path: <netdev+bounces-278778-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id OIqJGGaV32leWQAAu9opvQ
	(envelope-from <netdev+bounces-278778-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Wed, 15 Apr 2026 15:40:54 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id C94F5404EDD
	for <lists+netdev@lfdr.de>; Wed, 15 Apr 2026 15:40:53 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 2DDCC301601C
	for <lists+netdev@lfdr.de>; Wed, 15 Apr 2026 13:37:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A91FC3B47D9;
	Wed, 15 Apr 2026 13:37:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="ItJ7v3Ce"
X-Original-To: netdev@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B9B8C3B3BF7;
	Wed, 15 Apr 2026 13:37:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=192.198.163.12
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776260231; cv=fail; b=X6IyrTO6iUcIY+wZSas3cwqiQtCizoQXdw6PusNAFjLj257QL73F2/ohwOK+NgrqmFZ86V74FDRLAfwxUrIgn5DwFmUkJmXdXLhl6Fk9zjyKVC54KWtyfCQbg7/FcIb5HM2Y+LpfViGDQAhNW/gHDiKK7LJV6dCRchtRktp8qj4=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776260231; c=relaxed/simple;
	bh=CyryMd8W5wKNXIVfbkMZq5q2fcnQh4AB04LQ3/RYQME=;
	h=Date:From:To:CC:Subject:Message-ID:Content-Type:
	 Content-Disposition:MIME-Version; b=LY6wrA5+TwUL+Ra72ilHXmYU/WX78+TONU9swpAAao0xzqPfBjgIRYJi5hCUVwFcQprl5mQlqN8vyevvXbx66PVPN4NO64knLurR9w5sHsBB1CzvXOQaTNw3khbtkloLGwWtsxSEVCJOVJYY8LlzKbtSK1OH6Z9WLhNV3/H67ok=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=ItJ7v3Ce; arc=fail smtp.client-ip=192.198.163.12
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1776260230; x=1807796230;
  h=date:from:to:cc:subject:message-id:mime-version;
  bh=CyryMd8W5wKNXIVfbkMZq5q2fcnQh4AB04LQ3/RYQME=;
  b=ItJ7v3CeFm8a44L1MnJ6W85DMGQdKmp/M4QxgwkNIstAgdVAKFz6SfzL
   TtdU5C2Ucbz5zZj8T+2FRLXftm98wvLa1lJ8EkaMG7L9x4WGY/kkIH9QK
   H0Mc5w/d2vWKpesSU5QzVtnRQ6L5HqnbKmZKEG5gCnDqIqFux89kzUsF/
   iVVH8Mxkfemzoo7TKQpONO+ZWeqA4oC7NFkfuerfive8+VByZs3sstx5W
   wHkrf6u/fYGB1ZvC1yfTp976utik/PFqhRT8s6Td/++efsQWw2zAFVRXO
   fTKDTh8nvRzB6xV2L3yKymXb+cxFDzcMduRpzTnd4HK0+wuh+fd21cqMH
   g==;
X-CSE-ConnectionGUID: XBUdbRmjTOm/enGhiINkRQ==
X-CSE-MsgGUID: wnCdzV37TlmGoLVntp3mEQ==
X-IronPort-AV: E=McAfee;i="6800,10657,11759"; a="81116358"
X-IronPort-AV: E=Sophos;i="6.23,179,1770624000"; 
   d="scan'208";a="81116358"
Received: from orviesa002.jf.intel.com ([10.64.159.142])
  by fmvoesa106.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 15 Apr 2026 06:37:09 -0700
X-CSE-ConnectionGUID: Kmp1dGsHTeuHZEwVv2GO3A==
X-CSE-MsgGUID: 9l30Rk8tT/CQI7Vh8kPGaQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.23,179,1770624000"; 
   d="scan'208";a="260847518"
Received: from fmsmsx902.amr.corp.intel.com ([10.18.126.91])
  by orviesa002.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 15 Apr 2026 06:37:10 -0700
Received: from FMSMSX901.amr.corp.intel.com (10.18.126.90) by
 fmsmsx902.amr.corp.intel.com (10.18.126.91) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.37; Wed, 15 Apr 2026 06:37:08 -0700
Received: from fmsedg903.ED.cps.intel.com (10.1.192.145) by
 FMSMSX901.amr.corp.intel.com (10.18.126.90) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.37 via Frontend Transport; Wed, 15 Apr 2026 06:37:08 -0700
Received: from CH5PR02CU005.outbound.protection.outlook.com (40.107.200.5) by
 edgegateway.intel.com (192.55.55.83) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.37; Wed, 15 Apr 2026 06:37:08 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=hoLrHH1eeMj9x2xwSGzu+83lPIwKDCbN/0ojGtQJ++ekGxxeN2c7/BpaF0Dqn8HChl7t1TN+O4f/zV3xqBDqvsJtPqDO2K/2Ijttv88QzomJwwegzfV1MwQP8W39dughqOEwDIJx98ns4qtHXKPAurjTzhxTUDoZB4PHQoXVeAjuGJA7oRDeZZgPh/eXeK3e3Xe6yqOXSkxZjngRQU29f/+UXICjUnQHA/wh9btWZVd7qg/L4friAc7ydOZXZsYhPsS6P22w6h9pvBgdPIQihTu9qxt42c/5jfvAyOGxsfOxGXoNmiSQCmsiLV8sipxO9pmZbZZOKkqKHviFUFTFtQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=yZcs01xUwWXVtO6xi2oFJ4MjE6IjbQJhllIzhnu8Cx8=;
 b=PcvAYR4mFrKw5X0SKo9iXr6LVXKgJL0rpwK/xVEln4SPHWcqxGGXQp+QRnDbNA5n57C0+JmGZGxx9WCqzRnltDCQTJBuxQCwQUZPfJn11cnmKLnY/NE8J2bY4781nGctQUi1qi05YVhSHso0+mCWZM+CCDUMRAaM/50MRs79/IQ7Z9UHlG0c5hGvdewuO13iaV5c7zOA0XGmPaIoR7RL3/h8WMgt9nzTVoifeoEfPE7CONtMvIinQCB/DhBWF2n2bCxafTUoIu384sHMRu5HqgPaTPdPEQ+AwWrJT8lfQT8Hll+6ZQ5rg8g5iRjfVQL4yneviPfPgRYsNOIdGXcWOQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from PH0PR11MB5832.namprd11.prod.outlook.com (2603:10b6:510:141::7)
 by SA1PR11MB9873.namprd11.prod.outlook.com (2603:10b6:806:4d9::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9818.21; Wed, 15 Apr
 2026 13:37:05 +0000
Received: from PH0PR11MB5832.namprd11.prod.outlook.com
 ([fe80::106e:78dd:4c96:d707]) by PH0PR11MB5832.namprd11.prod.outlook.com
 ([fe80::106e:78dd:4c96:d707%3]) with mapi id 15.20.9818.017; Wed, 15 Apr 2026
 13:37:05 +0000
Date: Wed, 15 Apr 2026 21:36:59 +0800
From: kernel test robot <oliver.sang@intel.com>
To: Xu Du <xudu@redhat.com>
CC: <oe-lkp@lists.linux.dev>, <lkp@intel.com>, <linux-kernel@vger.kernel.org>,
	Jakub Kicinski <kuba@kernel.org>, <netdev@vger.kernel.org>,
	<oliver.sang@intel.com>
Subject: [linus:master] [selftest]  400e658aa0:
 kernel-selftests-bpf.net.tun.fail
Message-ID: <202604151525.8305306f-lkp@intel.com>
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
User-Agent: s-nail v14.9.25
X-ClientProxiedBy: TP0P295CA0012.TWNP295.PROD.OUTLOOK.COM
 (2603:1096:910:2::16) To PH0PR11MB5832.namprd11.prod.outlook.com
 (2603:10b6:510:141::7)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH0PR11MB5832:EE_|SA1PR11MB9873:EE_
X-MS-Office365-Filtering-Correlation-Id: 260c4788-5a3b-4f09-587b-08de9af41556
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|376014|1800799024|56012099003|18002099003;
X-Microsoft-Antispam-Message-Info: t0+MqT0oTd/n4fisN5ZzLBHkY3zmW9OTtR0Z02D15J1Q71EuRjlbGmBNd5FDG+fs/UVfUeaWVIAPeU6j2sEWD4xwA+aUEtWyrCMQFBy2paexqMdb4F9Te16gn0WfCs6S9bxL1GBKPRhnJexZxNaPxi0jRsU7y5sn5keTre7zN8MALZVA9eu/T14mtimqTBjM6mTWOcNEPtMJnYmH5FmZRPBWQgLHI933McR6PF7dHXIonNWwjO+t09SUNGekcAV0FrAcT4/jd6jN20KsQCsw8gyEkqPUtRft0qoVdUB4DCidDG1dqR6V4kw7vxcpNLqCcAUhyzLyS3T439CP+FQAd1ZGuQLHJQNs+PL70R7yDDIK0f/sTcWtQYfiOyM1F5PPLbjB81D0uoV9sGrddqMRMq2yIK1Lzqr/Y4AibcuIkUecEMBnw1OEGT/IyIL8Ca0rLH/M+5B7ATz5TS0ngENgdvWre9cgKL9EavQ6ahNDvnfKyyfvj2E678RT/sIzFFxAyGWi+N8BbqNtn+QS6Kv/5mDg10ZB153tfBziBiV+jQlTNIK7im+IJnI7swHbbAqwSXUKxvzPS65SBOCk+E1dyDRKTYtAA1/XRLilzUImM1Aq8HvCyiKn6497VaA0cMEeUW9WDFhz+yLB9+jw1Ya9s0tDssK3so/RHe0s9o0ePUzEMTTEsQBEkt/aPsQ8EI9t
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH0PR11MB5832.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(376014)(1800799024)(56012099003)(18002099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?THkH6NnXL5La7aU3eFRFtjVHpmppHCg4OXw+ppbY9d2OyiIi480ORcXGmifU?=
 =?us-ascii?Q?CvRPBUjrlXzd0DgeYCLWmi0nuK/JY2+3BSCnPxhUxJGIVL8VHx1/myTpivH2?=
 =?us-ascii?Q?pZTQQOI7ldjgvwTa1buaqxrlvanyUatp5wKpVCsQatXeKZatbJeCq7NAtjyT?=
 =?us-ascii?Q?9oWt8YUAgPHOJyYIgSArURbbJ3ialGIei54KGRIcCpMbZBUCMTsA9yMepjmX?=
 =?us-ascii?Q?jLPF95eYS/pu2UqvmXafM4R9v7iEbQ/KOKKBny02sIePOXYNKPaeo0BtnEXj?=
 =?us-ascii?Q?C5m/6ad/cdSVguHLrho1lUPKeeJwf5LRkgylE9m0UVMAWuFqc4zqd/tZahYn?=
 =?us-ascii?Q?tY/gk1sIROg5ldOCeHM48d6f1ec0C2xZYfm4dXkauDxzifDLOPKatfEQgR6i?=
 =?us-ascii?Q?MqGxEkszU8kPc+N4l+WdwvylRr2oy7TMqQEz7Sq91XmHOz/hszHdIHYzkrah?=
 =?us-ascii?Q?cs5nelvIlEHNOg/3/T4T3H6W8VIzGyXfs8usnQqf41c3rKuTXbe6YcTg8ATS?=
 =?us-ascii?Q?z8FGQpvxgCQyAVp32CJLfC6uK3/68B3at0albGV+yZWGp/oMVOYF7S016DBy?=
 =?us-ascii?Q?2kIbqNG5OBfK8AqG2ECkioPG8PbuR2hwgqetfvtyWfI/KzagTpCVkygMzgko?=
 =?us-ascii?Q?qmJAr/NnLauDpdBAsq4/V2+oj9NYuY3+8WSVh7/1f9aMHBUIzFGKczkJTtYd?=
 =?us-ascii?Q?ZrzE6VvZ2VzFP+KpxvXg5ACsan0HxFNvd8dLWhKAQjpMzNa1r4TMyb+0MGnj?=
 =?us-ascii?Q?L6LEnAAU24Lj1LsV8e0MpCslWAZmyq8xHRI9WTYm601jyrHh4j4dtBqtdIQ9?=
 =?us-ascii?Q?h4VanjrJG1Ro+cAlqUU0gBD6pGWxDUDe1ZceYh2KVzJVXqq2SmPD92ZS18gX?=
 =?us-ascii?Q?tRdZ7d3yavkALWKWYI6eepvRGHES5Tzg48g8Wt7Fp5B4oFphPzIEi+gsxFKx?=
 =?us-ascii?Q?aELDkGUxdiJGf9H/TGENxJwQbKS8q+AfsYyO0HHO7i6WJVUDJ/cAHkD727hs?=
 =?us-ascii?Q?Nv7qEK1p/gQ+RKHiTlmDjUv5AeTcnP3UshRQpfvA1NlOqoHn6bBsJnnFeHLF?=
 =?us-ascii?Q?Xj3T2yyeu+07kB+E66OBcZsHLEKAqSyTnC+9FlT8xMwKkacrrVwBdrtNWi04?=
 =?us-ascii?Q?c2VuRDbwKRADdRBXCtT8WH1YzY/SjOpBV8zwU7WVoU3LuGvpNoqk9DThTXmY?=
 =?us-ascii?Q?vIgeXEaRZQCVyQi8GYTsKXUk77nGIpjN4kxTeNucyQJzV8VT6cPYY1uatSJK?=
 =?us-ascii?Q?sfolzN1FHo+BjAbbR036wq+COJkwH7GW0S7mnD5+8HQaKvAU/tTotoYZR+MP?=
 =?us-ascii?Q?U39EAEHocppeY9M9ErxSE2iVZRkxVOdpNNxzaAYuMEuayvNKn5TlW5eBqZ43?=
 =?us-ascii?Q?bRm7Fka/1zZ06IshUF+eh1z+FYIfgXjM8hKQxCf1SkXNoMHzpHk9lkLMuU4r?=
 =?us-ascii?Q?hXrvfKr5ZxsABKuwEp+TlVVDITziaTi0la894ulbJCn3iDTUXDFBK7kws2o0?=
 =?us-ascii?Q?v5q6Qt/h+vmE+rXoAFJE8Mi9wnJ+341yFcY11CbQViHngL8gwvkyDW/M88g/?=
 =?us-ascii?Q?rrwHBPPgkCVOUvgAeiGxrfSBMbOd/EawDolJoWteeSf/1zFP5d/TTWBCdagN?=
 =?us-ascii?Q?77ra6vH90nMIqXUwRB7gtEAPeRVBZJE773tj7LQnaR/pz+qXR1A5qSVQb0ig?=
 =?us-ascii?Q?DR/YEcAPGU++F/4Qx67/nzO1Nh+gHyj1wFrGXJPCaxTP3TxXA4wksjZW/+hL?=
 =?us-ascii?Q?7gdQwupoTQ=3D=3D?=
X-Exchange-RoutingPolicyChecked: FQOnOrEIZx1ySjmzB0vqDHIz6lUZqzagNN7ZbR129kfCY9gLMG1N/Ie1+AfCIA6bbGuMzyzjc7LeyE6HdrH15IXQfTgdAk0I/42fwyKAN1L0hgMTZGxVOrs4qti61igQVoHduB9nLBXpKTk33SHimy2GKm45boTdptYAEe1wFWr52A0vTdJHOt8RZ3P2L7HKVpTyi44GcLRRZ1J6UUDA0jfrkP3bDMehwg/tL5y3IRUDpBvZ12iF0JQEzHgiAlDVo3M7vSY5aMPAuSFFXtlLtFOEZb0+dLpLU9cAmID7a0heMfAHar87/+M47TAvJX1VlBRhPBt1H6V3oSfqOgI/4A==
X-MS-Exchange-CrossTenant-Network-Message-Id: 260c4788-5a3b-4f09-587b-08de9af41556
X-MS-Exchange-CrossTenant-AuthSource: PH0PR11MB5832.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 15 Apr 2026 13:37:05.5005
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: ntGcz/RF8VyKNOUddJhHgNc9JOw4xzEWI/AkEvtuWWbpE4nl4DKVDI+yXkKNioLNkZ1K+siIXymG/q7dCUYLDA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA1PR11MB9873
X-OriginatorOrg: intel.com
X-Spamd-Result: default: False [-0.16 / 15.00];
	ARC_REJECT(1.00)[cv is fail on i=2];
	DMARC_POLICY_ALLOW(-0.50)[intel.com,none];
	R_SPF_ALLOW(-0.20)[+ip4:172.105.105.114:c];
	R_DKIM_ALLOW(-0.20)[intel.com:s=Intel];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	TAGGED_FROM(0.00)[bounces-278778-lists,netdev=lfdr.de];
	DKIM_TRACE(0.00)[intel.com:+];
	RCVD_TLS_LAST(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns,intel.com:email,intel.com:dkim,intel.com:mid,01.org:url];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[oliver.sang@intel.com,netdev@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.105.96.0/20, country:SG];
	NEURAL_HAM(-0.00)[-1.000];
	RCPT_COUNT_SEVEN(0.00)[7];
	MID_RHS_MATCH_FROM(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	RCVD_COUNT_SEVEN(0.00)[10]
X-Rspamd-Queue-Id: C94F5404EDD
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr



Hello,

kernel test robot noticed "kernel-selftests-bpf.net.tun.fail" on:

commit: 400e658aa096cda99b37ce806ed63cfe894c9566 ("selftest: tun: Add test for sending gso packet into tun")
https://git.kernel.org/cgit/linux/kernel/git/torvalds/linux.git master

in testcase: kernel-selftests-bpf
version: 
with following parameters:

	group: net


config: x86_64-rhel-9.4-bpf
compiler: gcc-14
test machine: 16 threads Intel(R) Core(TM) i7-13620H (Raptor Lake) with 32G memory

(please refer to attached dmesg/kmsg for entire log/backtrace)


If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <oliver.sang@intel.com>
| Closes: https://lore.kernel.org/oe-lkp/202604151525.8305306f-lkp@intel.com


# timeout set to 3600
# selftests: net: tun
# TAP version 13
# 1..9
# # Starting 9 tests from 5 test cases.
# #  RUN           tun.delete_detach_close ...
# #            OK  tun.delete_detach_close
# ok 1 tun.delete_detach_close
# #  RUN           tun.detach_delete_close ...
# #            OK  tun.detach_delete_close
# ok 2 tun.detach_delete_close
# #  RUN           tun.detach_close_delete ...
# #            OK  tun.detach_close_delete
# ok 3 tun.detach_close_delete
# #  RUN           tun.reattach_delete_close ...
# #            OK  tun.reattach_delete_close
# ok 4 tun.reattach_delete_close
# #  RUN           tun.reattach_close_delete ...
# #            OK  tun.reattach_close_delete
# ok 5 tun.reattach_close_delete
# #  RUN           tun_vnet_udptnl.4in4_1mss.send_gso_packet ...
# #            OK  tun_vnet_udptnl.4in4_1mss.send_gso_packet
# ok 6 tun_vnet_udptnl.4in4_1mss.send_gso_packet
# #  RUN           tun_vnet_udptnl.6in4_1mss.send_gso_packet ...
# # tun.c:679:send_gso_packet:Expected ret (0) == variant->data_size (1402)
# # send_gso_packet: Test terminated by assertion
# #          FAIL  tun_vnet_udptnl.6in4_1mss.send_gso_packet
# not ok 7 tun_vnet_udptnl.6in4_1mss.send_gso_packet
# #  RUN           tun_vnet_udptnl.4in6_1mss.send_gso_packet ...
# # tun.c:679:send_gso_packet:Expected ret (0) == variant->data_size (1402)
# # send_gso_packet: Test terminated by assertion
# #          FAIL  tun_vnet_udptnl.4in6_1mss.send_gso_packet
# not ok 8 tun_vnet_udptnl.4in6_1mss.send_gso_packet
# #  RUN           tun_vnet_udptnl.6in6_1mss.send_gso_packet ...
# # tun.c:679:send_gso_packet:Expected ret (0) == variant->data_size (1382)
# # send_gso_packet: Test terminated by assertion
# #          FAIL  tun_vnet_udptnl.6in6_1mss.send_gso_packet
# not ok 9 tun_vnet_udptnl.6in6_1mss.send_gso_packet
# # FAILED: 6 / 9 tests passed.
# # Totals: pass:6 fail:3 xfail:0 xpass:0 skip:0 error:0
not ok 19 selftests: net: tun # exit=1



The kernel config and materials to reproduce are available at:
https://download.01.org/0day-ci/archive/20260415/202604151525.8305306f-lkp@intel.com



-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki


