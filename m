Return-Path: <netdev+bounces-306118-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id Qar7OZ5tT2o8ggIAu9opvQ
	(envelope-from <netdev+bounces-306118-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Thu, 09 Jul 2026 11:45:02 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 3B74372F173
	for <lists+netdev@lfdr.de>; Thu, 09 Jul 2026 11:45:02 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=intel.com header.s=Intel header.b=QV1Wu1Mh;
	dmarc=pass (policy=none) header.from=intel.com;
	spf=pass (mail.lfdr.de: domain of "netdev+bounces-306118-lists+netdev=lfdr.de@vger.kernel.org" designates 172.234.253.10 as permitted sender) smtp.mailfrom="netdev+bounces-306118-lists+netdev=lfdr.de@vger.kernel.org";
	arc=reject ("cv is fail on i=2")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 952703050A70
	for <lists+netdev@lfdr.de>; Thu,  9 Jul 2026 09:36:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 25EF83EDE5D;
	Thu,  9 Jul 2026 09:36:48 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.14])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 974483E3142
	for <netdev@vger.kernel.org>; Thu,  9 Jul 2026 09:36:46 +0000 (UTC)
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783589808; cv=fail; b=bmAWCSgwaxqIoVg5C+yiGu/bS/yJki3+Mq+1afLESj/MXj0t/YROVspJUdy2qnUakHiGd0Dzi0nldWa/nSn5DE8yedqO2S+6oD6vjMlcjiqL1ZluLuT8Fn6vpzNNgSL1KvIpfeZ+okYkpV3UdE3LIP/aOZrZ+O4JsJnF4h6jj5I=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783589808; c=relaxed/simple;
	bh=mWwJbhK5BS2CBg/vilaiHUoKaB0nNPBbw/R1ei+65EI=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=Kqwk1NNBufrTbl3AARb6AX9EJqeunZ7sOMOTALvu7rxFfUe+gjGyWAR3RygPC49O61Rj5y0jZrg4V6kfH1jK5cyXjtyksxdyt646H4r0kTeYF8leUXiy993W2NwNI0j5ejebNOQtDZD1XPu5HWOf6YMKlNni7Di96sxm4s6vzv8=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=QV1Wu1Mh; arc=fail smtp.client-ip=198.175.65.14
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1783589807; x=1815125807;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=mWwJbhK5BS2CBg/vilaiHUoKaB0nNPBbw/R1ei+65EI=;
  b=QV1Wu1Mh7fCHALU87pDQv1lIPvf2TmtYdwCFjrKy9SgBQvnUlj3K08zN
   TyY517F3tJZ8rr7/7t39RJFS0nlv8EK7xeD7kRccHDmnO2soGKtEF6+bh
   vBd0wNrbMBDWLKDOhIPL60KqljxmW7aQiSU1ho+wohfn/qr4O+byRbdqJ
   h/APaz0Rqdrm8nzxP8um7hjmqZOSmp2LNm/gBHG43Msi22UeRUlOJ3Oa1
   xq6yyRUpPH0gzKMDvoN5Lt0B0RHz+CNDdLaaJXF3w3D1iVPX1hpMRAdBb
   cP/4t5VsrtSpFEBEVednsrZpLu16SNXdHHregMFCjyIANTFwNkUs04cVx
   g==;
X-CSE-ConnectionGUID: GkW+azscQLe/lOyUXzuS3A==
X-CSE-MsgGUID: FolB/yCbTNeRGsjcuyG9jg==
X-IronPort-AV: E=McAfee;i="6800,10657,11841"; a="88181568"
X-IronPort-AV: E=Sophos;i="6.25,154,1779174000"; 
   d="scan'208";a="88181568"
Received: from fmviesa007.fm.intel.com ([10.60.135.147])
  by orvoesa106.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 09 Jul 2026 02:36:46 -0700
X-CSE-ConnectionGUID: r65ThwW+Qd+P8dSj2YpyJQ==
X-CSE-MsgGUID: e4myhkS6SvGWD+QS8O4CFg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.25,154,1779174000"; 
   d="scan'208";a="251172266"
Received: from orsmsx901.amr.corp.intel.com ([10.22.229.23])
  by fmviesa007.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 09 Jul 2026 02:36:46 -0700
Received: from ORSMSX901.amr.corp.intel.com (10.22.229.23) by
 ORSMSX901.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.43; Thu, 9 Jul 2026 02:36:45 -0700
Received: from ORSEDG903.ED.cps.intel.com (10.7.248.13) by
 ORSMSX901.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.43 via Frontend Transport; Thu, 9 Jul 2026 02:36:45 -0700
Received: from SN4PR2101CU001.outbound.protection.outlook.com (40.93.195.31)
 by edgegateway.intel.com (134.134.137.113) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.43; Thu, 9 Jul 2026 02:36:45 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=NovWvNgiJGCAtMB1SyKz6d9aLY4sVKbuVyRKInvIzI2t/6QNBzZo+5qUfGFDohwkRxdSVOCm4N7rK9dLTRAIJFi1+U+ymLEcET3fSVojQJjlqhiXtW7zdxS7CHSDuKGrEn5HIMuHaWOJgQWVbOe+Mu4/2dDkTWiz3+IREVB5J4E+P4+bqMVyi46FD6xzuASiCsz8Cr+KhjKil7EdQOUA0hVH/fur1cpmu7pPSTG+JZ2h+yN+Y1ZIe+kNK/Y0nmBu+pO/DAFDdDhg1wCf1g+1bsln9p2oCZMp8wctZfrvVrIz8CWZhnu9um00D6BVO2B86de6Yjd3Ipq11lz2cYhaxw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Q+HtAR7N039Cu5DSfp20NZEEb4MHMnWBqgccp6ACbww=;
 b=rCGC57w6v39QJSpecOvy6SQ8eInmjV79cbUV38yVCjZkf3D8kLuMWY56CsgLOfWDKeTbm6v8CO+FzWi1sRbxT4Ld+G23uiuTgwj/zuVTGZtK1/vatdiv2gFTwGFpTM1E5ZQ67Nn+V5KWehzvovA1cIX6pPT99GqUDZ1W6mAK/yT8iy+53CBIJ55xYJ/PBF5lfHV17Bdjyn/JfH3XgWA9egd1zFi5wbwHrqs0TFRk8Du3XdTYY//wB/HbLcHEi1/FOMH2U9dyP1M0hGMuz4RDPc60yZo42MtFdoAfWCYts6XQiKcyNhYmd7LLJXhBEfWYF16yvLF5vclT9fTiRSJwQA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from PH0PR11MB5902.namprd11.prod.outlook.com (2603:10b6:510:14d::19)
 by IA3PR11MB9422.namprd11.prod.outlook.com (2603:10b6:208:57e::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.181.15; Thu, 9 Jul
 2026 09:36:42 +0000
Received: from PH0PR11MB5902.namprd11.prod.outlook.com
 ([fe80::f95a:602a:34d3:5d37]) by PH0PR11MB5902.namprd11.prod.outlook.com
 ([fe80::f95a:602a:34d3:5d37%5]) with mapi id 15.21.0181.009; Thu, 9 Jul 2026
 09:36:41 +0000
From: "Jagielski, Jedrzej" <jedrzej.jagielski@intel.com>
To: Simon Horman <horms@kernel.org>
CC: "intel-wired-lan@lists.osuosl.org" <intel-wired-lan@lists.osuosl.org>,
	"Nguyen, Anthony L" <anthony.l.nguyen@intel.com>, "netdev@vger.kernel.org"
	<netdev@vger.kernel.org>
Subject: RE: [PATCH iwl-next v1 3/6] ixgbe: E610: do not disable LSE on driver
 down/remove
Thread-Topic: [PATCH iwl-next v1 3/6] ixgbe: E610: do not disable LSE on
 driver down/remove
Thread-Index: AQHdCgYfbtwmrH6yCEWyEePrcV5UfrZj4twAgAEVfgA=
Date: Thu, 9 Jul 2026 09:36:41 +0000
Message-ID: <PH0PR11MB5902745B58B8ADCE2EDEEC84F0FE2@PH0PR11MB5902.namprd11.prod.outlook.com>
References: <20260702091553.57112-4-jedrzej.jagielski@intel.com>
 <20260708170145.1514345-1-horms@kernel.org>
In-Reply-To: <20260708170145.1514345-1-horms@kernel.org>
Accept-Language: pl-PL, en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: PH0PR11MB5902:EE_|IA3PR11MB9422:EE_
x-ms-office365-filtering-correlation-id: 932b1cf0-9f48-44f9-9ea2-08dedd9d955f
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230040|23010399003|376014|366016|1800799024|38070700021|3023799007|4143699003|5023799004|11063799006|56012099006|6133799003|18002099003|22082099003;
x-microsoft-antispam-message-info: Siv3KWzsTHJ4OknhxpDNiqqVIBK7Dh4QnM4mvy6SoNdN5T3PlGqDpKWU4x+c+q/uJ6/e3/Gqcza/VuYIbaCbvfRPOanr1ez8uZ8wUWhe16itWYg4FMRY4y2nPNpk4XN6lsupl3QaLHn5jgJHh778EHam9/K8g78N86fjXSQBSBb4wyajKW8JJiLJQulbg8DrDvKVqm96EP6PaXiAcjCh08YqIMbzupHZadteORjK6cQby+Hh8zZ6FVL7aV9gBAqbK4GKaeQ764MWFzmvCeK6thnKlGlcJ/oKtklJZdaAvppG5R/1OS5C8r6AZH0EDdASvOcuttlEmJ2WtmdSO7t/0rHv6xfxek6bXqjVxO/pV2V7OZV8KeJFT+1sgFDpvo0yOymJnOWdTXH2+PtzzOftP/ydGokRQXxs32vQo4VopYYzzU4PMgZop8irD+sOGPDC/QJXKwQA0fbxgbc27S1nWElInlG78N251YNkxS54wjxXiQr4O/lLiTY05hOpPfVNp4LywY+tolkXtvTirJS9Q+Rq3vOAmoDh6ft4AX6fLzzkY86SAZrKzHVaPOc4bSywbqUidvY2DZ75Hd19d9MXXrG8Ih7BhsJOg8r1+q8EZMb9arSNfUIAT+RiaCzoLodZrL2drVGbFfhCyZGmryBoGDUjJbOOKR3ML5Gl8Ct/Zbo=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH0PR11MB5902.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(23010399003)(376014)(366016)(1800799024)(38070700021)(3023799007)(4143699003)(5023799004)(11063799006)(56012099006)(6133799003)(18002099003)(22082099003);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?tUmJmc55PzNhm2kaIUqShIRP5/ts/Kq4Hjqmqn7AAyTPVRjfjUARwpXQ7DsH?=
 =?us-ascii?Q?TmhqfbvLlVASMXs5Jrt+81mhDvq3hHkQDU8x+x1P7er8CsNkBH7CF2F78bkj?=
 =?us-ascii?Q?t4GauSDPvZj4jHCPqxcOEMfAzYa6Sf077o80slMCUbVN0Bg3J/Kg9cpJSIEa?=
 =?us-ascii?Q?hbKX/eyQkxAmG5ZzJmcgs3IK5pPrnYaFkO9DHt7SA0p2CYSDIMLQnPhXyHAV?=
 =?us-ascii?Q?urCbDfOLkJz0otj3ueXmLFbWtt2ges/NoDbAuBtLdLYZCZnAbhJTsGxKzgim?=
 =?us-ascii?Q?jCwyVbl0qmbDI601b5XH9Ajt1Ml/uEy7OpxpEUzeosXK0PLiicsGr08161N2?=
 =?us-ascii?Q?6IyLlecFT5szz4JsyU7PYrFQarR6rYENAF2r2GGxVKMYT/hXn2HjXsUA0C2L?=
 =?us-ascii?Q?8RGe1+GG7oODtUZZ5Rw5CT5aGMY/hgdkol0OSxAMSt+wuBcnZNGivd9Kl8lX?=
 =?us-ascii?Q?zWl+auFrU5Pm4I7H9TXd2rVkwrHfBNjTabHwM1gHSqWjzxgqcUmqIZk6BX2t?=
 =?us-ascii?Q?6Bq5V8RdsH28Y3t8oh+X3yp2kI41/wbtTqTvyQZDL9s4svjVHVr6vQukOjUR?=
 =?us-ascii?Q?aROCG6KRLihZeyEjf4y8pfnFwvJynT4xiMg0uaRdJq2J0dUFrxvGOzD6l5cf?=
 =?us-ascii?Q?gVw4FboUuNwdhF3X0yQCECkH6Iq5yBznRQwMQbxMprrpCPpAsb+HYeNUdtOD?=
 =?us-ascii?Q?ZJQemzqCv5mF7NK4iZcBzuePMM/l40o0qQQxaQxYnICQhmU04nNxI4s0Shcl?=
 =?us-ascii?Q?+pleeWa8M7NtFUWT5yo5utmCSED/aBFXE3ke2MAKbe5pMweE+SkDoVg1tcb8?=
 =?us-ascii?Q?c6sEuqrYs8h7Zchf9oBnLl4qmyLgZdDuh9KaEHxTrs18L74YimjJtpWpTgia?=
 =?us-ascii?Q?ujxfDLcO3XVIQkCc17keD48gJenSiSPPwUq76FaeVEY3p6zfFkZztO4TYEyh?=
 =?us-ascii?Q?+ZvajmHcXqZ6oO+ge6ML46vHhhCdVneOLPg+Xzp8wpF/75Ret9iVhXc/dnwt?=
 =?us-ascii?Q?lVQ1EOXmpk9+W/WvzLIRTQ4dNLUWtOaKlN91VsOwo4b7cjXNLbzqmQi7UN82?=
 =?us-ascii?Q?WfSSWbqdGRCdyef9JZLibUE/WufG+TfZ1HqeT9yKOQNpUVtF48g2PQZl3A0Z?=
 =?us-ascii?Q?vBwE3JQAxJwILMcHvlNiO+MVwt3BcNcWvnwvHBLVk1awwDO8HFH0QTwHbI8c?=
 =?us-ascii?Q?293NRLDeD3SwXwcWR3s2rW4sMBz7yGyFXo9KBkUO86y7jO+38WVAkV+Ozb6X?=
 =?us-ascii?Q?oqvZdQ5EIITuQ/hjhUmJloPDDvibH1993RTmexlSeGS9op15TbsicwqEkUiX?=
 =?us-ascii?Q?4PVDLO5UXMa4alssLnfiphok8vgC0R5u1XlXxv/YkvojpiZboH5fHyfMrzjU?=
 =?us-ascii?Q?Lwib4F+kTz0eHMs0UgYeJ2r1WTpucBIdwZJuzBpuirnBspJlOGwovOc0iHVi?=
 =?us-ascii?Q?5RG57E3gYruFwVhKmUFfPFY6oWm46R8Eu3i9PljBsAf/1hOWmU8P/mwhV9Qw?=
 =?us-ascii?Q?CYrEmPMMBh5g2IZ8iaitj5LaaId2Kb+Z47Iq39Bmgv6zC3Thtjl6kuIuU4ZR?=
 =?us-ascii?Q?WGkXRG+TYZNL/2GaSg79WJ4IJeEWPZpPOEj135LrVdz3RE+Whq42SKSE+7Z4?=
 =?us-ascii?Q?ILf7C3pkGPeGdWTOQrMc+BOhvYQ4WYG+8QTR8Sqx3p4Q9vGZ1rDnUs5jKWJz?=
 =?us-ascii?Q?soG5b4Hse3hdJmEB3YrsjPu+O4vNgRwcgIq6j7p2e1UasT353qwWH5ld7SIv?=
 =?us-ascii?Q?Sp6492WDTw=3D=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Exchange-RoutingPolicyChecked: ENg++8yS1mTmOaRSclX1tI+5cTUZwd8tLvqdb32eUD5UBFPr6xGZCTP6OsUwdgwvLnvMnwQCUH2bjdij84xsOvCDsow70gY1j6UeGznh7aV25zvE2JPVlBv2i42eplII3vKxyw9jX0v9qv0IKjt9tZsm3qzUYL7D0jk5/gY9ef8r4ulNzImtn6T0CGjvtvxW/E3CozFDpRMS62P/OwaHWk1+SmdKtWlqHJOYQ7I7vQAOgJFef+7dY8uKfAafSmZRReCGx1JA6ztF7w/hiJ+dAUP0lRzTUnsyftPJqGj0HiHIq1XKQO4GfkdW9/hM2cG70kpNvuHqWSSyLqOileIOOA==
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: PH0PR11MB5902.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 932b1cf0-9f48-44f9-9ea2-08dedd9d955f
X-MS-Exchange-CrossTenant-originalarrivaltime: 09 Jul 2026 09:36:41.8718
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: OQtc0dgq6WmtSVEl8NNPqHFrJr/AkcZ9M8wQJS3Yiv7Llu2RMxLTLhMHArFUcFEHQBoVpA6TidTDyZNVB3AJvZ0opSMwixcIjoLRVieHiRE=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA3PR11MB9422
X-OriginatorOrg: intel.com
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-3.16 / 15.00];
	WHITELIST_SPF_DKIM(-3.00)[intel.com:d:+,kernel.org:s:+];
	ARC_REJECT(1.00)[cv is fail on i=2];
	DMARC_POLICY_ALLOW(-0.50)[intel.com,none];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	R_DKIM_ALLOW(-0.20)[intel.com:s=Intel];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-306118-lists,netdev=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FORGED_RECIPIENTS(0.00)[m:horms@kernel.org,m:intel-wired-lan@lists.osuosl.org,m:anthony.l.nguyen@intel.com,m:netdev@vger.kernel.org,s:lists@lfdr.de];
	DBL_BLOCKED_OPENRESOLVER(0.00)[intel.com:from_mime,intel.com:dkim,PH0PR11MB5902.namprd11.prod.outlook.com:mid,vger.kernel.org:from_smtp,sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,sashiko.dev:url];
	FORGED_SENDER(0.00)[jedrzej.jagielski@intel.com,netdev@vger.kernel.org];
	TO_DN_SOME(0.00)[];
	TO_DN_EQ_ADDR_SOME(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FORWARDED(0.00)[lists@lfdr.de];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	DKIM_TRACE(0.00)[intel.com:+];
	RCPT_COUNT_THREE(0.00)[4];
	PRECEDENCE_BULK(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[jedrzej.jagielski@intel.com,netdev@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	ALIAS_RESOLVED(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	MISSING_XM_UA(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	RCVD_COUNT_SEVEN(0.00)[10]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 3B74372F173

From: Simon Horman <horms@kernel.org>=20
Sent: Wednesday, July 8, 2026 7:02 PM

>This is an AI-generated review of your patch. The human sending this
>email has considered the AI review valid, or at least plausible.
>Full review at: https://sashiko.dev
>---

Hi Simon,
yeah i saw most of these on sashiko local run and i believe we should
not be worried about them.
I see that sashiko does not understand some of the FW/NIC <-> driver
communication concepts for this series

>ixgbe: E610: do not disable LSE on driver down/remove
>
>This patch removes the calls to ixgbe_disable_link_status_events() in
>ixgbe_down() and ixgbe_remove() for the E610 MAC. The intent is to keep
>Link Status Events (LSE) enabled when the interface is down or unloading.
>
>> diff --git a/drivers/net/ethernet/intel/ixgbe/ixgbe_main.c b/drivers/net=
/ethernet/intel/ixgbe/ixgbe_main.c
>> index 882021c436d0f..83098bf522e42 100644
>> --- a/drivers/net/ethernet/intel/ixgbe/ixgbe_main.c
>> +++ b/drivers/net/ethernet/intel/ixgbe/ixgbe_main.c
>[ ... ]
>> @@ -6733,8 +6720,6 @@ void ixgbe_down(struct ixgbe_adapter *adapter)
>> =20
>>  	ixgbe_clean_all_tx_rings(adapter);
>>  	ixgbe_clean_all_rx_rings(adapter);
>> -	if (adapter->hw.mac.type =3D=3D ixgbe_mac_e610)
>> -		ixgbe_disable_link_status_events(adapter);
>
>[Severity: High]
>Does removing this call allow unhandled asynchronous LSE events to permane=
ntly
>block the ACI mailbox?

No, removing this call does the opposite - it let driver to handle events
which without that step would not be received at all.

>
>If a link event occurs while the driver is down, the firmware can queue an
>event in the ACI queue. Upon the next driver load, before the service task
>can clear events, commands like ixgbe_get_flash_data() are called.

That's not true and actually it's opposite to the idea of async events.
Events are not queued when driver is down, that's the period when it
may required to be notified by some sort of event, like eg link state chang=
e
so simply its send then

"before the service task can clear events"
they are handled in an async way, not synchronously by servise task

>
>In ixgbe_aci_send_cmd_execute(), if the EV bit is asserted, the synchronou=
s
>response is overwritten by the unhandled asynchronous event from HIDA_2:

It still bases on assumption that for some reason event has not been handle=
d
That's mislesading, handling mechanism is implemented and events are handle=
d
one by one. HIDA_2 corresponds to the cmd which is proceesed in given momen=
t.

>
>        if ((hicr & IXGBE_PF_HICR_EV) && !(hicr & IXGBE_PF_HICR_C))
>                for (i =3D 0; i < IXGBE_ACI_DESC_SIZE_IN_DWORDS; i++)
>                        raw_desc[i] =3D IXGBE_READ_REG(hw, IXGBE_PF_HIDA_2=
(i));
>
>        if (desc->opcode !=3D cpu_to_le16(opcode) &&
>            opcode !=3D ixgbe_aci_opc_get_fw_event)
>                return -EIO;
>
>Could this result in an opcode mismatch and return -EIO for all future
>commands, causing device initialization to fail?

I really do not see such possibility

>
>>  }
>> =20
>>  /**
>[ ... ]
>> @@ -12080,9 +12065,6 @@ static void ixgbe_remove(struct pci_dev *pdev)
>>  	set_bit(__IXGBE_REMOVING, &adapter->state);
>>  	cancel_work_sync(&adapter->service_task);
>> =20
>> -	if (adapter->hw.mac.type =3D=3D ixgbe_mac_e610)
>> -		ixgbe_disable_link_status_events(adapter);
>> -
>
>[Severity: High]
>Can the same mailbox blockage happen here during driver unload?
>
>If LSE is not disabled on remove, a link state change (such as a cable
>unplug) after unload could leave the ACI queue with pending events.
>
>Would this cause the same -EIO failure during the subsequent ixgbe_probe()
>when the driver is loaded again?

That's even more odd. Event is not something what is kept to be send
between driver reloads / FW reinit

>
>>  	if (adapter->mii_bus)
>>  		mdiobus_unregister(adapter->mii_bus);
>>

