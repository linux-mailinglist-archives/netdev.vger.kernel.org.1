Return-Path: <netdev+bounces-294819-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id Al4HI1hUIGro1AAAu9opvQ
	(envelope-from <netdev+bounces-294819-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Wed, 03 Jun 2026 18:20:40 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 0741B639A7E
	for <lists+netdev@lfdr.de>; Wed, 03 Jun 2026 18:20:40 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=intel.com header.s=Intel header.b=nO66wJtk;
	spf=pass (mail.lfdr.de: domain of "netdev+bounces-294819-lists+netdev=lfdr.de@vger.kernel.org" designates 172.234.253.10 as permitted sender) smtp.mailfrom="netdev+bounces-294819-lists+netdev=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=none) header.from=intel.com;
	arc=reject ("cv is fail on i=2")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id BEF0B3093F2E
	for <lists+netdev@lfdr.de>; Wed,  3 Jun 2026 15:34:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4D2B73ADB99;
	Wed,  3 Jun 2026 15:34:35 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.11])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6D3F7385D64;
	Wed,  3 Jun 2026 15:34:33 +0000 (UTC)
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780500875; cv=fail; b=pw+8bTzlZMuz0IkdnxrVRWS087mi6+PmMcWCnm/9Dei0bNQO23sT3C0nO1bo2eFj7UqqliuQKwxYmZHPf8bJYoAgwOmABa+4Zif0yZTwc+AgtWuFutDL+PSn8W1R5+WLT4+FPFEUJr9oaIBShh/4jCSO1Vj80ASTgxfGnm6O97I=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780500875; c=relaxed/simple;
	bh=QIY9FAu9POzq3hiNE7IpkEMnHqzskbEjqCW75NOgKgQ=;
	h=Date:From:To:CC:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=p0rutVt3YvOumhQEuUT5L6/0x2YmLKoGX9w4ructa6DA1RMfGdmo+Mle6KMmI18R/aQml6B4sDYzSgLOM0WKZcMo8sKuoWXmuAmICpxzrw8it6fxUbTzG59gjprpedQELjyCTKi1wDl3ZYoW/s2Ou01TTdw8skSIk/WMWUdIRpg=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=nO66wJtk; arc=fail smtp.client-ip=192.198.163.11
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1780500873; x=1812036873;
  h=date:from:to:cc:subject:message-id:references:
   in-reply-to:mime-version;
  bh=QIY9FAu9POzq3hiNE7IpkEMnHqzskbEjqCW75NOgKgQ=;
  b=nO66wJtkFgKdvsxj0GHauM9fZ07RTSM60qUIsWQtcPGTAw4oNeCc4F4E
   Xc8zRoinM4fFvIHUmI/xl88oY2zPSu4vhVpb5P6erCYadYpgn4OvEun2F
   NFSsmrIbZOt4Wd5wkoLKZTr/miDYX8M4+yjH/QNfoq4q9XzUzOZx0e/hi
   R51gT8DmJcYnw8LQz1hwetO+EjXAbrdBYI53/3VBdpIpJQe9Iie7MJ6bf
   lt0an5VuR64a2YuQT4QfT97A9lYWsGk1CL6b+MYrU2WqyS6aLxroJWwmn
   EuZ3GMovFuI2MMT96cHngRrCYV/iLE6xnLzASCkbllVTgNGGjg2CSfNVX
   A==;
X-CSE-ConnectionGUID: yW2Vw8wAQ3SrktjDXbxXaw==
X-CSE-MsgGUID: LXbRNcOLSs+6QWEt9l6XkQ==
X-IronPort-AV: E=McAfee;i="6800,10657,11806"; a="91889389"
X-IronPort-AV: E=Sophos;i="6.24,185,1774335600"; 
   d="scan'208";a="91889389"
Received: from fmviesa005.fm.intel.com ([10.60.135.145])
  by fmvoesa105.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 03 Jun 2026 08:34:32 -0700
X-CSE-ConnectionGUID: XCwEE9HVRI+Zmjf7+24rQQ==
X-CSE-MsgGUID: ryu30I8JRySEvsjKDT5ibg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.24,185,1774335600"; 
   d="scan'208";a="249353519"
Received: from orsmsx902.amr.corp.intel.com ([10.22.229.24])
  by fmviesa005.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 03 Jun 2026 08:34:32 -0700
Received: from ORSMSX902.amr.corp.intel.com (10.22.229.24) by
 ORSMSX902.amr.corp.intel.com (10.22.229.24) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.37; Wed, 3 Jun 2026 08:34:31 -0700
Received: from ORSEDG901.ED.cps.intel.com (10.7.248.11) by
 ORSMSX902.amr.corp.intel.com (10.22.229.24) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.37 via Frontend Transport; Wed, 3 Jun 2026 08:34:31 -0700
Received: from SN4PR2101CU001.outbound.protection.outlook.com (40.93.195.22)
 by edgegateway.intel.com (134.134.137.111) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.37; Wed, 3 Jun 2026 08:34:30 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Lu4D7hP/Lij0IbzzqobOPFo9zs9gbsDYbu/t/J++x+qm83GYD0sGap1uSVHAhCQt0jIXzAg2uGQvbLfIUQXdnCu2BWvKfKM0kDCMWpIVZtttzFo/ThWa+FBu0eObtA3ZyQ4JeT6nivtIcWpplM93evR/jgq0gW9mOGg4Mg98rZDif3WphUdABVRwBofSFulvT0g3KZmb9hc4+4S9ur96CyI2gsQ+oNy3P+tQLopiBY/eJWv+KKQ0jiSrym/2xAY+2wXMHAN01mf0A2QYa4gnZzxKomC877ZYmrA3JykvxXNL8eKxsm9IqclruPyXC/sS5IpYvjU5vX9pt9aonTvf7Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Zm+MeU/xKdYUSKE/wC+ZwX7H673W8XXVBmAYBFICt70=;
 b=vL/NQxCp3KmLm+y6O5K5UNKQO272XBA8uYSbnztAHd4GRpGYM/BfeUzg+o+wlDljuz7Tgfqt9EW9UBrCs9kG6MUlQ8U6/2oYGfukUXk8Vmagft33y9/je6tQhOh3+vBLyCgJvvRMlwJ7LrQdN1+hemD3y6SxHt6uxW894YRoc8UTftakU3d9IftOT0wCYMJmLCmQm4FfFwd0IKJLTCXLRVEXMBxib92BfgQOAywG2G8+TB+1xi1B3tqtb6nrX09kot0YEYqpJX+PMEf7kN7yrhPrSh3z2J080E7BmBt0AslHbiQwFjhb8hqkx5+AGRRulm4BdlpYLb99MToE/gPCUA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from DM4PR11MB6117.namprd11.prod.outlook.com (2603:10b6:8:b3::19) by
 PH7PR11MB8124.namprd11.prod.outlook.com (2603:10b6:510:237::9) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.71.16; Wed, 3 Jun 2026 15:34:23 +0000
Received: from DM4PR11MB6117.namprd11.prod.outlook.com
 ([fe80::d9b3:e942:2686:3cdd]) by DM4PR11MB6117.namprd11.prod.outlook.com
 ([fe80::d9b3:e942:2686:3cdd%5]) with mapi id 15.21.0092.006; Wed, 3 Jun 2026
 15:34:23 +0000
Date: Wed, 3 Jun 2026 17:34:16 +0200
From: Maciej Fijalkowski <maciej.fijalkowski@intel.com>
To: Tushar Vyavahare <tushar.vyavahare@intel.com>
CC: <netdev@vger.kernel.org>, <magnus.karlsson@intel.com>,
	<stfomichev@gmail.com>, <kernelxing@tencent.com>, <davem@davemloft.net>,
	<kuba@kernel.org>, <pabeni@redhat.com>, <ast@kernel.org>,
	<daniel@iogearbox.net>, <tirthendu.sarkar@intel.com>, <bpf@vger.kernel.org>
Subject: Re: [PATCH net-next v2 3/4] selftests/xsk: Use umem_size() helper
 consistently
Message-ID: <aiBJeNRplaNRfb23@boxer>
References: <20260603060327.298389-1-tushar.vyavahare@intel.com>
 <20260603060327.298389-4-tushar.vyavahare@intel.com>
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <20260603060327.298389-4-tushar.vyavahare@intel.com>
X-ClientProxiedBy: VI1PR04CA0065.eurprd04.prod.outlook.com
 (2603:10a6:802:2::36) To DM4PR11MB6117.namprd11.prod.outlook.com
 (2603:10b6:8:b3::19)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM4PR11MB6117:EE_|PH7PR11MB8124:EE_
X-MS-Office365-Filtering-Correlation-Id: a5ab713c-fede-4d2c-46a1-08dec1859695
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|376014|1800799024|18002099003|22082099003|4143699003|56012099006|11063799006|6133799003;
X-Microsoft-Antispam-Message-Info: A0EfKMFrJgUY1II0u8Rot92cNa0D+uYDn1oAbvLAnixM6gxihXem5SeqQo4hgYWe0owY1DSEmca5k3tZLPTQKSGnHQytVIbYoP+gaRUoWSA1F7p9jsiXhNckVmEznOKrasasHbAp7RNkArkdgAaim6j1wv0JO7TggvvOtAKGsB123srRTe3M8GoJOUsF9A21OFf/CkFiBdWWHXIiCqzin/SvJ0trAcvQh26lH8ge5NNKL7l+5/HnY5olqFtH4vjvUf/bcdxwyu4i0yk3dLvlA7fk7E2pCye1pnFAexUeg/M+TxYI0IqC6fIKB3mKfb2qZO8c88nyfTRrgGUoeSuFLHAC2wl/gv5Adcyr1KK1bAn+pSb7FOEWwLtIB3eCksi5COn53u88TSKexUWuxiqOwfGgLRYWQnjCXfSJ18QN96zFPgW3tJCrxkY8CAFSssU6Ng7621jDGoYMIf0WsBMkp5ATuCPHkCUH0sFmac52SFv/kgSfiUqFiNtPwm65QkjTwyZ9zKi6VvyUuDAQ5lFFFsIC9Nd6SwTVBN5c6FbvYH0KIap6oqp6viD8dOiB1EVjSdH/TBPmSddKETX31hdaFzmv3I3qhqwnNLY45xfVcvu16bLCs/xSNOJuvfnfeqrFq//wUUeyAxckHXkjtzvTW2mjNI0nrlU3Y04ht3gFwYTyRCVc4HwmsqrdoPneHZDp
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM4PR11MB6117.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(376014)(1800799024)(18002099003)(22082099003)(4143699003)(56012099006)(11063799006)(6133799003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?ScLHnavYaQu8a1elA6ezL01U+McGDqaQiwpAqCKQ9+Gd0kJUZtt7VgakQTNy?=
 =?us-ascii?Q?rYfEFdXHz1h4sLWvh337JiJFlFjHv1N9mWFojcgBiG8A27lR8Qumjq5y0UOb?=
 =?us-ascii?Q?7evGMGOp1bgv62SBlPR0mk4uYo22RECHbHy8VhesqvekVPk4TH8GvGyzqRri?=
 =?us-ascii?Q?Hx54hCJjfzH4wPB2G6djLAhaFHy3oW2+qdFceIJIfSK9bVrCBOf5WHLYCBUj?=
 =?us-ascii?Q?he2DRuHJImwRDNyaUKUeaqIN7j4N0Tcawv2yaKX+4zk8qYj+2FMEE46cvaoT?=
 =?us-ascii?Q?6HXRT+WFdEh4wIpek2k99A2hM5M57WJrn0tUY8adHsNkcoD08MYDpY6vSbZX?=
 =?us-ascii?Q?xViCk4q0kfH0wcQUs/klHE1tkYDpaZkP6r5mc+1bvkz+X125Ir91XeXMf8wR?=
 =?us-ascii?Q?q23lV6Vnyt6/CP/D2kzveZxjwnpVUglCylu4YvgzvV4Sx+qBS/ViBGX9ipmq?=
 =?us-ascii?Q?bQo4LVwduVeJ1jlhZYEk3vSFo7XpuUciH+g17PD1EnT0jXW5G/5OywOEPC0T?=
 =?us-ascii?Q?VewqJrMKcw6VRhOnQ12DQZDHBMQBHGFvMn+EuSsk0Ta6bvvsQNy2l6qRM52J?=
 =?us-ascii?Q?o2aO7Y79evKyL9MBBBJ6egDsUjVizkQ3QnCd8PynuZgpAdxLcOA+yTxL0zk2?=
 =?us-ascii?Q?D0VCNmmgK4gLqw1cw2ZtK57w+s0+l6GO/kwhNCDULOcvcZRzr3mpCKiam9eA?=
 =?us-ascii?Q?8eJapIKxsFJEWibJgg/NYgO/+3pwk71NtO/Oim2qrVXMI0xxbtjVe5ezn5RF?=
 =?us-ascii?Q?Cj03FFzqnq3IaQA/qtvAoB1keQd61zL8MyglAeaA6uKOeiypvNacF73Sg6C+?=
 =?us-ascii?Q?OFaLTzUsvani6LpVOwjcn+cjr2iDD4DoebxO861dsqsyzxuiJOOmuT/eMfW5?=
 =?us-ascii?Q?MQM+aCz9TVsWV8fXSiO19Q6ZsLkKic2MOpO4qZShwcYMaPy05fTR33YWznrE?=
 =?us-ascii?Q?NpJEc09j9FLL/29ng4IssOCtB1LyJi6gmyrSztItLYV8noC+drioxH8DKfll?=
 =?us-ascii?Q?WdGxjUJd8cJWeBZPW2Z1wCOLLcG+65Gj8gK9BZAnWpg+V7WZ2epOzAj9PFoQ?=
 =?us-ascii?Q?IuqdPS6itYxmW1UUeeQXDvRN7D37UIBG6oLntgimogH85ut6f85l75UNqsC8?=
 =?us-ascii?Q?17sQcu710HwCX3oO3+wveDy/WjTSqeghoZLEHe2jdUDvjS9gTtUBZmN51me+?=
 =?us-ascii?Q?tifcZV10IkDHVmPZeyu3J2lEDSB9rNWt3jv2QJ4q687xruRQVEzR0h4tcDST?=
 =?us-ascii?Q?9FdbQt8ay3Qxw6dUwkf0YetCrRohoA/5XVsuB2292osvFZPBIp4XZDBa6Phh?=
 =?us-ascii?Q?NbgEuGw838tV0Rv2XnQ3hoV5xD9LZ+cdMvm1q4zbyin2aLao0Oojdf8k36qd?=
 =?us-ascii?Q?gpYCYBP2B4YdTOVrQdu3KY21WcGfYB/mlobbC4svkbQ2a5IxbU8ZKTcj88a3?=
 =?us-ascii?Q?H/WcCoYH9k68e3skvhAKOOOBITiOCRr6RrtenUGU6XhwEAdtpPFdC9EnGWqG?=
 =?us-ascii?Q?e2/UIMMTTWcPmnDX7vqf6SW/plUaOOSQJ+VrGpiXQoBh3JrP7rusitLdCPwp?=
 =?us-ascii?Q?4VeVZXT8upJvWWUz1jDflwf4MuAd0ZhJhtvqHGDKthlRX0hX9ZT9eBirXhtr?=
 =?us-ascii?Q?GXHgo8+ZpWam2pmZiSbDP6gzAZhSjRk+VcXn2MiNFxfOODgu3qgZ0KlobAuC?=
 =?us-ascii?Q?tmCJSahbJNs9r3CrMzHD6cOOROGfNPSg9FPjmf7+XVks9hrunDy2j3bbDuKd?=
 =?us-ascii?Q?esLEcnPg6SXXhabrUtbS0ZzhPbQqNcg=3D?=
X-Exchange-RoutingPolicyChecked: CkAo4w0XzC22VQ0wu/P2w0YjmbzcQhlsGvOeZc4a8JS4D4mp6L+QXhQKN5+S81tQRWDMWGcVWAADkgOALboxYWqnKCy8C2mRR7LL0pWkVhCrrOoEq63u/e/IE2165LECaGx9hLzgGoW94wbgVV2I+gNA5HlojpEKYW+KLpZH2itLqU2K+9UmKZf/WdIAmIEmOsaggkn7fEodkhV+QnnvW2cbL2Vuy7dxT1F0TcByTVuwn0VCkIdv11fogebq5LnPUpDtMH/AtpNgD0xGcHjsoYeGmyFXu6lsM5G7jOMaBeZfyxUKGx3V7dLkLhGxyCE888cYMsGUhB8+zV35o6YoBg==
X-MS-Exchange-CrossTenant-Network-Message-Id: a5ab713c-fede-4d2c-46a1-08dec1859695
X-MS-Exchange-CrossTenant-AuthSource: DM4PR11MB6117.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 03 Jun 2026 15:34:23.5721
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: TzL2VzCixp/019MmuwQXPvTPMdYMwGBw/hVgoXBl0Qsja6beZdzAqdFtHpab+MGcFDqnU1SLxbFc3523Wv8vRQXet0L6e/fY462udcQ0Qw0=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR11MB8124
X-OriginatorOrg: intel.com
X-Rspamd-Action: no action
X-Spamd-Result: default: False [0.34 / 15.00];
	ARC_REJECT(1.00)[cv is fail on i=2];
	MID_RHS_NOT_FQDN(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[intel.com,none];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	R_DKIM_ALLOW(-0.20)[intel.com:s=Intel];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-294819-lists,netdev=lfdr.de];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,vger.kernel.org:from_smtp,boxer:mid,intel.com:dkim,intel.com:from_mime,intel.com:email];
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
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	RCVD_COUNT_SEVEN(0.00)[10]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 0741B639A7E

On Wed, Jun 03, 2026 at 11:33:26AM +0530, Tushar Vyavahare wrote:
> Replace remaining open-coded umem->num_frames * umem->frame_size
> calculations in test_xsk.c with the existing umem_size() helper.
> 
> This keeps UMEM size computation centralized, avoids duplicated arithmetic,
> and improves readability with no intended behavior change.
> 
> Signed-off-by: Magnus Karlsson <magnus.karlsson@intel.com>
> Signed-off-by: Tushar Vyavahare <tushar.vyavahare@intel.com>

Reviewed-by: Maciej Fijalkowski <maciej.fijalkowski@intel.com>

> ---
>  .../selftests/bpf/prog_tests/test_xsk.c       | 36 +++++++++----------
>  1 file changed, 18 insertions(+), 18 deletions(-)
> 
> diff --git a/tools/testing/selftests/bpf/prog_tests/test_xsk.c b/tools/testing/selftests/bpf/prog_tests/test_xsk.c
> index 7e0d34111b2f..f1730466ffd9 100644
> --- a/tools/testing/selftests/bpf/prog_tests/test_xsk.c
> +++ b/tools/testing/selftests/bpf/prog_tests/test_xsk.c
> @@ -829,11 +829,11 @@ static bool is_frag_valid(struct xsk_umem_info *umem, u64 addr, u32 len, u32 exp
>  {
>  	u32 seqnum, pkt_nb, *pkt_data, words_to_end, expected_seqnum;
>  	void *data = xsk_umem__get_data(umem->buffer, addr);
> +	u64 umem_sz = umem_size(umem);
>  
>  	addr -= umem->base_addr;
>  
> -	if (addr >= umem->num_frames * umem->frame_size ||
> -	    addr + len > umem->num_frames * umem->frame_size) {
> +	if (addr >= umem_sz || addr + len > umem_sz) {
>  		ksft_print_msg("Frag invalid addr: %llx len: %u\n",
>  			       (unsigned long long)addr, len);
>  		return false;
> @@ -1586,7 +1586,7 @@ static int thread_common_ops(struct test_spec *test, struct ifobject *ifobject)
>  	int ret;
>  	u32 i;
>  
> -	umem_sz = umem->num_frames * umem->frame_size;
> +	umem_sz = umem_size(umem);
>  	mmap_flags = MAP_PRIVATE | MAP_ANONYMOUS | MAP_NORESERVE;
>  
>  	if (umem->unaligned_mode)
> @@ -1706,12 +1706,13 @@ void *worker_testapp_validate_rx(void *arg)
>  static void testapp_clean_xsk_umem(struct ifobject *ifobj)
>  {
>  	struct xsk_umem_info *umem = ifobj->xsk->umem;
> -	u64 umem_sz = umem->num_frames * umem->frame_size;
> +	u64 umem_sz = umem_size(umem);
>  
>  	if (ifobj->shared_umem)
>  		umem_sz *= 2;
>  
>  	umem_sz = ceil_u64(umem_sz, HUGEPAGE_SIZE) * HUGEPAGE_SIZE;
> +
>  	xsk_umem__delete(umem->umem);
>  	munmap(umem->buffer, umem_sz);
>  }
> @@ -2097,7 +2098,7 @@ int testapp_send_receive_mb(struct test_spec *test)
>  int testapp_invalid_desc_mb(struct test_spec *test)
>  {
>  	struct xsk_umem_info *umem = test->ifobj_tx->xsk->umem;
> -	u64 umem_size = umem->num_frames * umem->frame_size;
> +	u64 umem_sz = umem_size(umem);
>  	struct pkt pkts[] = {
>  		/* Valid packet for synch to start with */
>  		{0, MIN_PKT_SIZE, 0, true, 0},
> @@ -2107,7 +2108,7 @@ int testapp_invalid_desc_mb(struct test_spec *test)
>  		{0, 0, 0, false, 0},
>  		/* Invalid address in the second frame */
>  		{0, XSK_UMEM__LARGE_FRAME_SIZE, 0, false, XDP_PKT_CONTD},
> -		{umem_size, XSK_UMEM__LARGE_FRAME_SIZE, 0, false, XDP_PKT_CONTD},
> +		{umem_sz, XSK_UMEM__LARGE_FRAME_SIZE, 0, false, XDP_PKT_CONTD},
>  		/* Invalid len in the middle */
>  		{0, XSK_UMEM__LARGE_FRAME_SIZE, 0, false, XDP_PKT_CONTD},
>  		{0, XSK_UMEM__INVALID_FRAME_SIZE, 0, false, XDP_PKT_CONTD},
> @@ -2138,7 +2139,7 @@ int testapp_invalid_desc_mb(struct test_spec *test)
>  int testapp_invalid_desc(struct test_spec *test)
>  {
>  	struct xsk_umem_info *umem = test->ifobj_tx->xsk->umem;
> -	u64 umem_size = umem->num_frames * umem->frame_size;
> +	u64 umem_sz = umem_size(umem);
>  	struct pkt pkts[] = {
>  		/* Zero packet address allowed */
>  		{0, MIN_PKT_SIZE, 0, true},
> @@ -2149,11 +2150,11 @@ int testapp_invalid_desc(struct test_spec *test)
>  		/* Packet too large */
>  		{0, XSK_UMEM__INVALID_FRAME_SIZE, 0, false},
>  		/* Up to end of umem allowed */
> -		{umem_size - MIN_PKT_SIZE - 2 * umem->frame_size, MIN_PKT_SIZE, 0, true},
> +		{umem_sz - MIN_PKT_SIZE - 2 * umem->frame_size, MIN_PKT_SIZE, 0, true},
>  		/* After umem ends */
> -		{umem_size, MIN_PKT_SIZE, 0, false},
> +		{umem_sz, MIN_PKT_SIZE, 0, false},
>  		/* Straddle the end of umem */
> -		{umem_size - MIN_PKT_SIZE / 2, MIN_PKT_SIZE, 0, false},
> +		{umem_sz - MIN_PKT_SIZE / 2, MIN_PKT_SIZE, 0, false},
>  		/* Straddle a 4K boundary */
>  		{0x1000 - MIN_PKT_SIZE / 2, MIN_PKT_SIZE, 0, false},
>  		/* Straddle a 2K boundary */
> @@ -2171,9 +2172,9 @@ int testapp_invalid_desc(struct test_spec *test)
>  	}
>  
>  	if (test->ifobj_tx->shared_umem) {
> -		pkts[4].offset += umem_size;
> -		pkts[5].offset += umem_size;
> -		pkts[6].offset += umem_size;
> +		pkts[4].offset += umem_sz;
> +		pkts[5].offset += umem_sz;
> +		pkts[6].offset += umem_sz;
>  	}
>  
>  	if (pkt_stream_generate_custom(test, pkts, ARRAY_SIZE(pkts)))
> @@ -2406,7 +2407,7 @@ int testapp_unaligned_inv_desc(struct test_spec *test)
>  
>  int testapp_unaligned_inv_desc_4001_frame(struct test_spec *test)
>  {
> -	u64 page_size, umem_size;
> +	u64 page_size, umem_sz;
>  
>  	/* Odd frame size so the UMEM doesn't end near a page boundary. */
>  	test_spec_set_frame_size(test, 4001);
> @@ -2415,10 +2416,9 @@ int testapp_unaligned_inv_desc_4001_frame(struct test_spec *test)
>  	 * the UMEM but not a page.
>  	 */
>  	page_size = sysconf(_SC_PAGESIZE);
> -	umem_size = test->ifobj_tx->xsk->umem->num_frames *
> -		test->ifobj_tx->xsk->umem->frame_size;
> -	assert(umem_size % page_size > MIN_PKT_SIZE);
> -	assert(umem_size % page_size < page_size - MIN_PKT_SIZE);
> +	umem_sz = umem_size(test->ifobj_tx->xsk->umem);
> +	assert(umem_sz % page_size > MIN_PKT_SIZE);
> +	assert(umem_sz % page_size < page_size - MIN_PKT_SIZE);
>  
>  	return testapp_invalid_desc(test);
>  }
> -- 
> 2.43.0
> 

