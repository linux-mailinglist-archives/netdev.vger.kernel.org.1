Return-Path: <netdev+bounces-302188-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id XoyNCY+JPmqbHgkAu9opvQ
	(envelope-from <netdev+bounces-302188-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Fri, 26 Jun 2026 16:15:43 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [104.64.211.4])
	by mail.lfdr.de (Postfix) with ESMTPS id 61D426CDD30
	for <lists+netdev@lfdr.de>; Fri, 26 Jun 2026 16:15:37 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=intel.com header.s=Intel header.b=An5WTZqZ;
	spf=pass (mail.lfdr.de: domain of "netdev+bounces-302188-lists+netdev=lfdr.de@vger.kernel.org" designates 104.64.211.4 as permitted sender) smtp.mailfrom="netdev+bounces-302188-lists+netdev=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=none) header.from=intel.com;
	arc=reject ("cv is fail on i=2")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id 1237A301C5E2
	for <lists+netdev@lfdr.de>; Fri, 26 Jun 2026 14:15:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A49793F8250;
	Fri, 26 Jun 2026 14:15:33 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.9])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 441A637C910
	for <netdev@vger.kernel.org>; Fri, 26 Jun 2026 14:15:32 +0000 (UTC)
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782483333; cv=fail; b=KxEkaygZmwHOD9YatTZRDf85YftXYNyo0oqnlp1d+0k4ERQ5FZ2phcdNkQtGmOZ8Z8g480KXo7NhY5BJEJVPPmn3WYZDJELp5r++Y4QmmV1XqvCZkQ9vie9hcuiPSwZdaf5NrIop0QQJpgzqTsW6e/NrZy/hdn4O8R7eQfiDVDc=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782483333; c=relaxed/simple;
	bh=ARqba9ty5o8dMcGRZN6iskZJ7/hGFrsPUrtFl7i7LNM=;
	h=From:To:CC:Subject:Date:Message-ID:Content-Type:MIME-Version; b=SYzC+X2z4TrznS+P1GyGGtWba8vA7gBrkQj8qJjF0c7v0h7bZQvJgMmWHKLN1bKeqLlD4yPhN48qrbtTwssL2MJkk1zjZprgfZF4aJYoE+/hJOEmbb/38gHgztv0kcRNtAePeU3qmVmEUWBCn4Qc6tinedlQEV1N89UlGCVOfVI=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=An5WTZqZ; arc=fail smtp.client-ip=198.175.65.9
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1782483332; x=1814019332;
  h=from:to:cc:subject:date:message-id:
   content-transfer-encoding:mime-version;
  bh=ARqba9ty5o8dMcGRZN6iskZJ7/hGFrsPUrtFl7i7LNM=;
  b=An5WTZqZOuveia9VUxtsXEjtezS00V+L1S+niPpQdpEGGNf01RpEWekZ
   FKi/mXm+bXxMElBWf0yES3Gxd5yrhsufOi9fRdqqNAXLWvtX+9DrklIgz
   PQl7EwGRqVWIHKJkzfsgZicl2DCvPNMGjAu5NUPDWR78CjIEj8xXuMHPK
   AM6hgEKtez2VS+y6Eq70JdlHas78Iv0D2BaGtZvs49vJ4fGmeo0oSc+jg
   bgLqtmAa3/WFenSc9TnvJL9X9hV9J3Ihyhi97yiRUD29fSqgfs9CTDXmr
   Bk9Ghk4xjjYKvW1q3NeyKbFvAUKdPZAHvdc/Aju+k7CcmowuYC39UjujA
   w==;
X-CSE-ConnectionGUID: KaXAbo+LQVmAMqavAPySaA==
X-CSE-MsgGUID: JV6t0chUSHumd84wKhO4jQ==
X-IronPort-AV: E=McAfee;i="6800,10657,11829"; a="106069647"
X-IronPort-AV: E=Sophos;i="6.24,226,1774335600"; 
   d="scan'208";a="106069647"
Received: from fmviesa004.fm.intel.com ([10.60.135.144])
  by orvoesa101.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 26 Jun 2026 07:15:31 -0700
X-CSE-ConnectionGUID: Tww/M+aiQSCmsbjskykqzA==
X-CSE-MsgGUID: RpWs7ZHiSV+fbOisJAogBg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.24,226,1774335600"; 
   d="scan'208";a="253247345"
Received: from fmsmsx902.amr.corp.intel.com ([10.18.126.91])
  by fmviesa004.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 26 Jun 2026 07:15:31 -0700
Received: from FMSMSX902.amr.corp.intel.com (10.18.126.91) by
 fmsmsx902.amr.corp.intel.com (10.18.126.91) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.37; Fri, 26 Jun 2026 07:15:31 -0700
Received: from fmsedg902.ED.cps.intel.com (10.1.192.144) by
 FMSMSX902.amr.corp.intel.com (10.18.126.91) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.37 via Frontend Transport; Fri, 26 Jun 2026 07:15:31 -0700
Received: from BL2PR02CU003.outbound.protection.outlook.com (52.101.52.70) by
 edgegateway.intel.com (192.55.55.82) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.37; Fri, 26 Jun 2026 07:15:31 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=OHR8Fm6N12s4XRCnLhoBHK0jIBkTMj6f2CcKhmQP6WuyCkiVQwPSEZiQkHGyfIKYSWkIzKrvHgMr+45me+R9MmWfgjoInqIC9E123VAMmf/3C1N/H5Z5VDPfLTlQDxv6ZTTXqSPUzNNKtKsK1/+7K4SLZJ76vuYUsphKz2O19iEuclrW2AdfLa8lW3prxF9xuIKCcHXsRtjyy2eFmM/l9wgJm/LDqNFmTnST3y9FJUgC+QSg0YEt/lz3aFzOmtFVemJWZ5LGKxprrjz4SX27egIdC5g3Y/ZnYV7vwAqz7BXszlHFrLxSAF9xjVrB0hVdawqGRWvidX6pz/aHTDLnjg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=h01hoWCnpcHCEo+9WhOAfPqXKOdXtVuGqohDqXIn96M=;
 b=p/d9rTsFtT7+hmC9q/PbvTCKfW1Enzeql2cQKVp+6igr618XNmHmIoktbGPp62QXmGA3BdAyd8icSSbsNTXP10PLxjjUUSZ3aBdKgy/XT2nX7iuy6SH90faFuSbAqqOpyMA+kSVQ7McX/93j3Z/XWPIxMk43G3ARia32xQ2Zuyw52v1WSYBXSzwlCsC2HSAPvjf9VuqFLAlrzVuihXxIbVwxINbBg4DkQQdWw8tWZwbYR2TyYAT+f4DaberuVaYVjoO93zPaeR0w48tHxwg1sfpG7iSMLDzkbQ+xtCkQoJ8oPv+Fc5khbjZn9DdKrin62im9Da891nB/cE33RoVdlg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from MW4PR11MB6912.namprd11.prod.outlook.com (2603:10b6:303:22a::9)
 by SA0PR11MB4623.namprd11.prod.outlook.com (2603:10b6:806:95::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.159.16; Fri, 26 Jun
 2026 14:15:28 +0000
Received: from MW4PR11MB6912.namprd11.prod.outlook.com
 ([fe80::1ee8:dc26:e7f3:3d4]) by MW4PR11MB6912.namprd11.prod.outlook.com
 ([fe80::1ee8:dc26:e7f3:3d4%6]) with mapi id 15.21.0159.016; Fri, 26 Jun 2026
 14:15:28 +0000
From: "D H, Siddaraju" <siddaraju.dh@intel.com>
To: "netdev@vger.kernel.org" <netdev@vger.kernel.org>
CC: "Das, Shubham" <shubham.das@intel.com>, "Chintalapalle, Balaji"
	<balaji.chintalapalle@intel.com>, "Srinivasan, Vijay"
	<vijay.srinivasan@intel.com>
Subject: the confusing 10000base_CR. Shouldn't it be 10000_SFI_DA?
Thread-Topic: the confusing 10000base_CR. Shouldn't it be 10000_SFI_DA?
Thread-Index: Ad0FbzNABPoQ31JxTh+QV3XDba1IJQ==
Date: Fri, 26 Jun 2026 14:15:27 +0000
Message-ID: <MW4PR11MB6912A234CAAAFD25EAC7C8909AEB2@MW4PR11MB6912.namprd11.prod.outlook.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: MW4PR11MB6912:EE_|SA0PR11MB4623:EE_
x-ms-office365-filtering-correlation-id: a2b6c87a-2be9-400b-4f49-08ded38d5f9e
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230040|376014|10070799003|1800799024|23010399003|366016|11063799006|56012099006|18002099003|38070700021;
x-microsoft-antispam-message-info: ekfa2bC3wjdE++MuTJjL7tuQ4OCRKLqRG3galRSyP1KHuynU6wtnTzoHGDwGIKEUcpqxTxe6TualWdUqSp6OZiXaO8pnnmSqZTQCh7o0yG6HIsMo98Dj+/pui6dkZquhn/coMLylKPZukWkgpSm9POXprajWWMLZXatMA27gY/AFPCZYp+qGsvJUTastCembYIVOM2hJy2DTbwE96lsDxCeBuWJorieWPIlb/9LKAajGXR14FZLgsL701xSpa6gP9HwaJPEDxepAZMX0ZaaoSPTL1RO1minsbUKSzoTRK6Ib6FejM/4vibsbyn1kC6Qt4hzyCU5ySJWMApNKNjVwxiel1axaJodForFRaopXyp88BtIeC8ZPyN7wA0NXAu+KQ0dn8Bw4BjPht73wjZcPBf8xmuGSrG8J6CaZktClkfROrLVixs762PfSVXO+bkGkh9vY8YeuPqLkdoWjEGNiVdjUpxvdihj325nztCWUsxIztsA7oAU43JhsA4r6QyA0ic4C/5urMEM0nbEp+F7sEZH8N10yG73tFnFGlljVgcueRryAnHYF0mRSE1o+svKsbEFztMiV7q/HHagOZdqn3Gm3YtrTBtD9PlSXEmfPB7VrbbB0fS8J2YuC9pkbtI+9ytDyvXDRVz5+VU7hxoirJFD7gDIMWL1+bO7jlp+uZDYAKSx3R+kohm/7wUMYHPjpvq0pBV+Ucml99ITPnKssSU8H2ma3Oj0Zb+K1FRMcyVc=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MW4PR11MB6912.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(10070799003)(1800799024)(23010399003)(366016)(11063799006)(56012099006)(18002099003)(38070700021);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 2
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?mYFe4D0Sw85vuf7fv5rsC7WUHlP1h55/SPGrb3UjrdxhgW0fTv18FPtM+ZoG?=
 =?us-ascii?Q?G6RlLh1VAHXNRYCDX02PpamTgIp9z1BZgcMxRJh0qeDtGtYf4oLUyiSkX0b2?=
 =?us-ascii?Q?KFW76/x5Lpn6ekrBa2u6fMFo1tJcYeV3XWSuCRDt1YDsEuepl6KpssXAiaMN?=
 =?us-ascii?Q?PFnJXBy0pcpZbkFd3zL7JkW7sk4ztUXFWjSRrJ3JOOcSIyXM2X1ZXxtgQHGN?=
 =?us-ascii?Q?T22Tqi9uQ/Yv264KyTy66VUdV/q1RZeh4JRu0cVbD6Gyo8HUoAHKMn+/hdl2?=
 =?us-ascii?Q?TJPrAdzp6UPe5l2VhduPpVhLq0ndLBvW5r/3eQlLpwW0Lz/BrsB/XXhLlPFS?=
 =?us-ascii?Q?Ak5IKl9f6kohq/vN5hBufiFb3mloLG01y5BO3M/nM5C1v0/FC1khAihz5A7m?=
 =?us-ascii?Q?I1zhwSlyrQ/NU+sEmVp2xn3u83G9ycfVtkeJbuX36kCXo7PlvT2mWBW7dYUc?=
 =?us-ascii?Q?wLQ4wWqNFe/LmEafbTs2vqeyT53q6/jOy4G5ZrL201e9lYTuJjOrvRZzAZ2m?=
 =?us-ascii?Q?l1o8YB2XQC0tLtmMlHRBya3Lm1L5ePRbdpSS1cvEp8iwnSLNJSlwpj+A3XtZ?=
 =?us-ascii?Q?Obrwvz78nf3jQL7wbaWvx9LHDMMct9YFIOCMhHuKCX6rctG25ufBZzCZBdiB?=
 =?us-ascii?Q?4FWQ64+yOWtATisb8hazWer3ZlXwB/ESR3pF9rugBtJysoetMpOvoB90y9iW?=
 =?us-ascii?Q?XKj9hKmg+2UkUMHQ/BS1ToRNUqLw1bBGqTu6g4jWaek3SzD55krnrv+sCwFi?=
 =?us-ascii?Q?cKSWzcgG5aENQ+K3IiIRTsXsi4Sqe4cCzJmW/XdXvOCBW/UtzgpgrmK2lBH7?=
 =?us-ascii?Q?A5eDS/LXz+0860X2HpsKGN7X8as0UKmp2jjj+XaWOXyo/slQbzyyl62p8bvg?=
 =?us-ascii?Q?euV+0NaHh2vup/RkIx0jM889e6dpsofK71VAMmOazdQpVFLd5Ps0F9yXdcA1?=
 =?us-ascii?Q?iq9UzngeKHOXmABIlOnoUMof3wYtktzHDEhL0Yfv+jO/Hq3SuRBMak51T3aE?=
 =?us-ascii?Q?clnr73I1hYoGbq/gsp08GWcCCXHOoOzWwG2U+f21svuH9piOdig219IIQmW+?=
 =?us-ascii?Q?1sGx4IkGC66MVJyDY7C4qsofMiCtbYcqnqcC+t4GkjN+SEYhnujlYkQxEQPl?=
 =?us-ascii?Q?pxDFQbPtNlcCZCsoxQyvbNriwndhFT9SFEg1frZCKNdHfqWyGJA6oEGS0mfY?=
 =?us-ascii?Q?QAbSXPM845z9HhZpQHLv77FD5Yy5RNbiK4T8gEW8IInxL+MRV8dozAhu1dvB?=
 =?us-ascii?Q?sUEWPrinJ3oNJpiYcgJzY0Ew3c0O8ugTaCZXqCWWGitagbxR3X8WyvdfoPbz?=
 =?us-ascii?Q?lUtFXmwygNAfBAT4QYDZMwhGr0Rgio3o6GnWC4/HkGSdUtF5VHgde6aExUzl?=
 =?us-ascii?Q?Ps8qSdT/fObtBcRGXX5ZyXxNKDp4jktfNbMnfjc+f0itsvAg44SQfELmccRa?=
 =?us-ascii?Q?+kGmCviDbukkuyPGFujbLapkE8RpCndDoPq/mV1QpdLA6k5iZaMIghqJDHQ+?=
 =?us-ascii?Q?xBTKxfk4zNf2X7lIPxE5z4sDeRb8bsd6HkJfMTBuh6sxn5qn9JN8hT3QTjL4?=
 =?us-ascii?Q?JOKFXBn3Xs8WvYBZeP22nnD7REhq1D9HuJP6cnropqM2nInz9qjNyGsuuVRu?=
 =?us-ascii?Q?yNWJUQDcAdt2lqeEoNQppohi4PFcRzSbpIz4oERzXhKPpwblibR6U54xCjZL?=
 =?us-ascii?Q?SJNaEd+sCqUtpA3rRNJVNu25k1sgucN9om5dJrg/d/qfmB87v0HNsuaivnq7?=
 =?us-ascii?Q?TDd9/aBo7wb6g/lBvLP5LDj7qETdDw9jDmDAVfnzB7O7McEmdW0Jf7mP4Bva?=
x-ms-exchange-antispam-messagedata-1: Z3oHkLV0v7GxCQ==
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Exchange-RoutingPolicyChecked: irl0uokLfLio9O3w7oazDg7feADNpOuZMsuzp9Op8wJVg+stK/A+z8kd2Ywr78lxBE4GiXaprcvmL8A4f3emzaYaC3rq948SXbgjEtACRHuc0itkBG7R4DqvPhfdijuMq9bwf3A7GVS7VDDK7kwrnBEaxvS0Tb1iD7NxWMEDbrv9VWnC84iFzSQh8v4QfxF1LvyVwrKOT4UFUZuUSWDhAYAs+NfW1/Eb4Vxt+Q7mSsdlerW/4n0QNurV2PFSoU5bSgOoGomoSwEeJpz91NrCg/7I2uqKxvYgpT83BrFReA2E1hiKc4BmqqSCwVxgSkHFF0h8t+3GmutPvNwOPIZlUw==
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: MW4PR11MB6912.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: a2b6c87a-2be9-400b-4f49-08ded38d5f9e
X-MS-Exchange-CrossTenant-originalarrivaltime: 26 Jun 2026 14:15:28.1075
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 9bzZcBOs8lUxZUTUD0uTMFmZEezJyaiJZi0G0PDZ6FXgaGT0lknUYt//CXdsbmrGdAgtQKG81QjT9rOaH4DaEw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA0PR11MB4623
X-OriginatorOrg: intel.com
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-2.16 / 15.00];
	WHITELIST_SPF_DKIM(-3.00)[intel.com:d:+,kernel.org:s:+];
	ARC_REJECT(1.00)[cv is fail on i=2];
	SUBJECT_ENDS_QUESTION(1.00)[];
	DMARC_POLICY_ALLOW(-0.50)[intel.com,none];
	R_SPF_ALLOW(-0.20)[+ip4:104.64.211.4:c];
	R_DKIM_ALLOW(-0.20)[intel.com:s=Intel];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FORWARDED(0.00)[lists@lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-302188-lists,netdev=lfdr.de];
	FORGED_RECIPIENTS(0.00)[m:netdev@vger.kernel.org,m:shubham.das@intel.com,m:balaji.chintalapalle@intel.com,m:vijay.srinivasan@intel.com,s:lists@lfdr.de];
	TO_DN_SOME(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	FORGED_SENDER(0.00)[siddaraju.dh@intel.com,netdev@vger.kernel.org];
	TO_DN_EQ_ADDR_SOME(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sin.lore.kernel.org:rdns,sin.lore.kernel.org:helo,vger.kernel.org:from_smtp];
	DKIM_TRACE(0.00)[intel.com:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[siddaraju.dh@intel.com,netdev@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	ALIAS_RESOLVED(0.00)[];
	ASN(0.00)[asn:63949, ipnet:104.64.192.0/19, country:SG];
	RCPT_COUNT_THREE(0.00)[4];
	TAGGED_RCPT(0.00)[netdev];
	RSPAMD_EMAILBL_FAIL(0.00)[netdev@vger.kernel.org:query timed out];
	MISSING_XM_UA(0.00)[];
	RCVD_COUNT_SEVEN(0.00)[10]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 61D426CDD30

Hi Linux Ethernet Team,

We explored Ethtool's "10000base_CR" PMD PHY type
and we think it might be just a wrong name.

Why we called 10000Base_CR, a confusing name?
Because it fails all below 4 major highlights of a "typical base-CR"
    1. Every other Base-CR is an IEEE defined PMD specs
    2. All Base-CR have AN LT (Auto-Negotiation & Link Training)
    3. Almost all CR have FEC mandatory
    4. IEEE CR is a very close sibling of IEEE KR, the complex ones

There is NO IEEE 802.3 or ANY other standard spec to
support 10000base-CR and the industry fully adopted
SFF-8431 Appendix-E Direct Attach cable as 10G-SFI-DA.

We feel 10000Base_CR must be renamed to 10000_SFI_DA.
    SFI: SFP+ high speed serial electrical interface
    DA: Direct Attach cable media

Need your inputs for the next step here. Should we,
(a) Submit a patch to rename all instance of 10000baseCR
OR
(b) Create a new enum for SFI_DA and map it to 10000baseCR?

We prefer option-(a) since it completely resolves the confusion
and gives a technically correct name.

- Thank you,
Siddaraju D H


