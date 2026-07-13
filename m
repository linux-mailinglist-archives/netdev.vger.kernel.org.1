Return-Path: <netdev+bounces-307182-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id 3pXBHVTrVGq+hAAAu9opvQ
	(envelope-from <netdev+bounces-307182-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Mon, 13 Jul 2026 15:42:44 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [172.232.135.74])
	by mail.lfdr.de (Postfix) with ESMTPS id 1ABFE74BC31
	for <lists+netdev@lfdr.de>; Mon, 13 Jul 2026 15:42:44 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=intel.com header.s=Intel header.b=kyqtnouj;
	spf=pass (mail.lfdr.de: domain of "netdev+bounces-307182-lists+netdev=lfdr.de@vger.kernel.org" designates 172.232.135.74 as permitted sender) smtp.mailfrom="netdev+bounces-307182-lists+netdev=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=none) header.from=intel.com;
	arc=reject ("cv is fail on i=2")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id C58213049F18
	for <lists+netdev@lfdr.de>; Mon, 13 Jul 2026 13:30:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 62C794279EA;
	Mon, 13 Jul 2026 13:30:02 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.9])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 43AB7426EC1;
	Mon, 13 Jul 2026 13:30:00 +0000 (UTC)
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783949402; cv=fail; b=TYhm0lqPDpi7dN4bCEWRFnp+yhrBQd1eCjQNvmN6iuSrukp7slkIJTyg9WrfN5HEl8Lzxa1xYgqft5s84sH92OR42Q3dl0DUCAF5rx+NGxztWCdxghYVTdy1jg6NoLWD4jdV6SvZoRGeCTbipvVT5cwLPFWpieO8GBcPincLKTI=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783949402; c=relaxed/simple;
	bh=b6Z9arZ6mjSs7WuunuLgBYTbvEmnnmdKzOgv3U4ItKo=;
	h=Date:From:To:CC:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=T3GrcbDFTkvo/zFS6skJZ1QiQNteGqBiXYWdFTxEVfSgld80gcrzD28I8Wn+40uPHZ14JAc8ZF8QLfVbDvFe6qfkYD2Y6dgetOEjYclx48Y3wlZyaqbWQFviHPdyvzEWN4iWU5lFsj5Y+hHYhE0dFm0KdKKcoyTBOpQJptwl9JU=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=kyqtnouj; arc=fail smtp.client-ip=192.198.163.9
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1783949400; x=1815485400;
  h=date:from:to:cc:subject:message-id:references:
   in-reply-to:mime-version;
  bh=b6Z9arZ6mjSs7WuunuLgBYTbvEmnnmdKzOgv3U4ItKo=;
  b=kyqtnouj7pXMYekbl/UoRX4RY8Jjz6q9ncKXGmAgj33Y+9a+QmqYUX6m
   zmgmSyRBnR1juGN1xdyMyK0ROsFIO+f3V7DfPrI3IVJMOf9w4rHdWrLZM
   DMXJR9/7QxHX3rlbXC6d9tY/6zF8UblzngRvvzCSQF67ZbFHVvVglHrxb
   a1It/lGjjjf56bcT4Lwekr/1opXTHpOWIfcRSTXFdnBNYnQsFxZV8LFE3
   y9RLTTVtn7VU8tMMnN9Hhc4l5sNHwLt2VdHWgoZ5h11jSmrsxj4ieRh1I
   ds0GL8pMkJFOT1wnGadDKxh5rnzn3Th70V2B5pdLPgLjOPxyMSkfZCjxK
   A==;
X-CSE-ConnectionGUID: LvHH2ieZRPOtm6C8tjev3Q==
X-CSE-MsgGUID: hnWLoYAZSoiQYRgeKhaRqg==
X-IronPort-AV: E=McAfee;i="6800,10657,11841"; a="95201003"
X-IronPort-AV: E=Sophos;i="6.25,154,1779174000"; 
   d="scan'208";a="95201003"
Received: from fmviesa010.fm.intel.com ([10.60.135.150])
  by fmvoesa103.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 13 Jul 2026 06:30:00 -0700
X-CSE-ConnectionGUID: XtFvy6HmTmm5Ph3MLBdCjw==
X-CSE-MsgGUID: kwvIWE0tQvGVgRXyGiSp0A==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.25,154,1779174000"; 
   d="scan'208";a="251611803"
Received: from orsmsx903.amr.corp.intel.com ([10.22.229.25])
  by fmviesa010.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 13 Jul 2026 06:29:59 -0700
Received: from ORSMSX903.amr.corp.intel.com (10.22.229.25) by
 ORSMSX903.amr.corp.intel.com (10.22.229.25) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.43; Mon, 13 Jul 2026 06:29:58 -0700
Received: from ORSEDG902.ED.cps.intel.com (10.7.248.12) by
 ORSMSX903.amr.corp.intel.com (10.22.229.25) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.43 via Frontend Transport; Mon, 13 Jul 2026 06:29:58 -0700
Received: from SJ2PR03CU001.outbound.protection.outlook.com (52.101.43.64) by
 edgegateway.intel.com (134.134.137.112) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.43; Mon, 13 Jul 2026 06:29:57 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=GU7LliOtXyZ7OAZqo6jSgzVrNxtWv/OWaBffdb2iFIfGtcuYcqARI3g+AUvQoRIZuwMsHllmCV5OfVsKJnl1n/gRh7yxu+AtHgq7DrQzseyJrbHbuKwgEJ7FI76TCESPAov+bseDM6Uj7JkDTwS+mFNFKcplkIM0qF02mdaOfyoX+3mIC6GXReMTyM5mV9CCJE888omA9gUJu8Otwh/kNXG5uGIEWNc3IbaIyHxZLxuonPEeTsP+OJwlkoHSChy8CVcwZf8iIE6eYPghAoisa4nBzmRNW15gEndZpzcIpjiWfZP5gx1Rq/dJ7Tg4Qltz/sJVsi6NRObhf1l5iyAf8Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=LkWZ+kT0XIj0QLqnnXLX2NHQH4JUcPYzJs5lJWbYz9M=;
 b=R0raxgiTmb7/QTTdaQL5L8cdz1MI6cJg2cCQ7rR4C+QmMdga0xMoaN38aZMrxRzbE5xlo/R76BWxMCYPwoP/o4Huyp6qCELVxDE0tWKmXJ0zfE4+OuQHW/d7DLzqVwmgHboR5J2FuhICwB/tQO0Zo+84++ry+oHX7Tk9tDlRLfGBqTDe+/meJQfDAB5204lMGAGWSjsR2PLQvnlb6Rt4Qjy6Ua/tRStgIZrj+e+OZoCXtQssr9IQ0hxalgeBCt5DKPQy5EPjBVmtslFXvyostGfHYzfAxKqVC+s0SVLzE7U71t4nQJwsmZbYFDqPUrTn29vAuBtfyg9ZMq60n49V8g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from MN2PR11MB3949.namprd11.prod.outlook.com (2603:10b6:208:138::31)
 by DSWPR11MB9954.namprd11.prod.outlook.com (2603:10b6:8:39d::24) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.202.18; Mon, 13 Jul
 2026 13:29:50 +0000
Received: from MN2PR11MB3949.namprd11.prod.outlook.com
 ([fe80::dfbf:4563:6676:e23d]) by MN2PR11MB3949.namprd11.prod.outlook.com
 ([fe80::dfbf:4563:6676:e23d%7]) with mapi id 15.21.0181.019; Mon, 13 Jul 2026
 13:29:50 +0000
Date: Mon, 13 Jul 2026 15:29:39 +0200
From: Larysa Zaremba <larysa.zaremba@intel.com>
To: Tony Nguyen <anthony.l.nguyen@intel.com>
CC: <davem@davemloft.net>, <kuba@kernel.org>, <pabeni@redhat.com>,
	<edumazet@google.com>, <andrew+netdev@lunn.ch>, <netdev@vger.kernel.org>,
	<przemyslaw.kitszel@intel.com>, <aleksander.lobakin@intel.com>,
	<sridhar.samudrala@intel.com>, <anjali.singhai@intel.com>,
	<michal.swiatkowski@linux.intel.com>, <maciej.fijalkowski@intel.com>,
	<emil.s.tantilov@intel.com>, <madhu.chittim@intel.com>,
	<joshua.a.hay@intel.com>, <jacob.e.keller@intel.com>,
	<jayaprakash.shanmugam@intel.com>, <jiri@resnulli.us>, <horms@kernel.org>,
	<corbet@lwn.net>, <richardcochran@gmail.com>, <linux-doc@vger.kernel.org>,
	Bharath R <Bharath.r@intel.com>
Subject: Re: [PATCH net-next v4 15/15] ixd: add devlink support
Message-ID: <alToQ05TGlcM9c2M@soc-5CG4396X81.clients.intel.com>
References: <20260710215313.1475803-1-anthony.l.nguyen@intel.com>
 <20260710215313.1475803-16-anthony.l.nguyen@intel.com>
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <20260710215313.1475803-16-anthony.l.nguyen@intel.com>
X-ClientProxiedBy: WA3PEPF00000522.POLP291.PROD.OUTLOOK.COM
 (2603:10a6:1d8::66c) To MN2PR11MB3949.namprd11.prod.outlook.com
 (2603:10b6:208:138::31)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MN2PR11MB3949:EE_|DSWPR11MB9954:EE_
X-MS-Office365-Filtering-Correlation-Id: edb72f83-57f8-408d-cb95-08dee0e2d094
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|7416014|366016|1800799024|10070799003|376014|23010399003|18002099003|22082099003|5023799004|11063799006|56012099006|6133799003|4143699003;
X-Microsoft-Antispam-Message-Info: 8RsF9UYBKkFRy3OPpMdcRSgZ1bP4bYWwCOdqX1RtSrl0U6xnQDrx0sLvQ1KYmhVx0gYk9TkX5faYGnb1xN05qeeJlKu4KwaVP4h0fD43t8ze4NcUa2xtrIiQrzKZ7sc/dgUNoTkbTfSp0vWfJOfGdtM3qZvAu58RbqB1RyQcrDaQ7KmEMn7jGaFiw5Qq3vuHKEEoEciOUiREM71akfxHfDjvm38ZZduWAaE2t+R5rxdgp2gQYvk+NOA1j44MK7bml2UNs2nVhu595DlTUjFzBq4O4T67TsPxdV+o/HOkg4fekcrSG7UN0SB7rfgY8fhNkiTQbof8hKm/n2Rsf7bcZXIF2tcGqz+TorbHqLSFjOs8KOshwktDaxNqCdQTVjkjJKTp7Fvb0azqN7qliJU21uR/bEcMJnIGef1viiyf944Ptgkq4R0ET2TqGC8ozko7VcsXTHZb/tLan/hGAo5pu/ZR+/LqlBeS7P/CtfRkqlbOXjkjhMGZFR82FXeVUTm8q+2/FbUCI4hdZHQR8HdxSySwLg056ORgy+kb3dAs40B85rpd/bekoBtpmylEFONdnoiNYcdaN+OY79EL8kyBuri5xzYlrsGRCvtQMo67WCUf8d6QHyXTFF/JLX5vWfRzv4AgXNeHUUR/eN6i+zjqHQHpC/gEA/xE/WANvLQ4Ikw=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MN2PR11MB3949.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(7416014)(366016)(1800799024)(10070799003)(376014)(23010399003)(18002099003)(22082099003)(5023799004)(11063799006)(56012099006)(6133799003)(4143699003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 2
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?AyRC0a3c0RrelcuARUbp37eCbYL0grKB73CXIoDqOa/Q6S8w5mO7yaFHTonl?=
 =?us-ascii?Q?aXYqB04RvwBZP0CqKJmmNIfWI6smnlV/WxgkUmu1V7pTHLLYXLasA9GLyzva?=
 =?us-ascii?Q?ShhjxbuzUHVR+UJAQFQmYwYXco+KNhkF3dB3GybI073c7lfRdto9BsUFhiOV?=
 =?us-ascii?Q?fBXZSsTODa+mSt7ztt/WGEvG3OmWt6bIlrYwufb2xpezDthr/XHQWZptMKTC?=
 =?us-ascii?Q?7oExj32LM02qul/nzECT0mTEE6+M/h9tOLvFeuXP5mS5NFS99M6L5p0mI1F7?=
 =?us-ascii?Q?qaR6a0lswXUGf7nJuqvZQdP1oOa9cre6N0VDCJXt+mv4xfZqjWm0Ljzop7A6?=
 =?us-ascii?Q?S6xmmP7Aiy2uTD3YrcGiq35YuhgKDkUKhXAfCulFLHCcQyN+UDxNLLOYjcpS?=
 =?us-ascii?Q?WsIwaNxpA/P1ST0/N8KtQMHRw5IqPOc53rDBpu7u2Xg66IH0pfCKAfvKidFq?=
 =?us-ascii?Q?9HOeVcxq65RV2/OvtF+uLj+6pRg/Rga+I0idpx+4jfJG/PQKjQQrAflU+Yj+?=
 =?us-ascii?Q?OTQZInXorRqH2HuSndgvJi+IDMkJl7DDDTAH2R7xhUKLHobY+Csw5SBg01T/?=
 =?us-ascii?Q?XfgulnBEFvft13RG+2MJD2wBR0CFRkgqGCIcXJVirhwnCCQ0M10yohu1D6hs?=
 =?us-ascii?Q?g6nlWNXkyFgs2HsKpZvx/37bD7WJJYUOvdI22vggbQ7R+Hyl5ggmRs9QuhNV?=
 =?us-ascii?Q?yyeRZcVm8AlAv5h0fZ44keKb8dwsXJ0Dr9OHxcTmda7S8sUNIWbbSm5Mqyvd?=
 =?us-ascii?Q?f94VrkpWfSB88g8L2nEqRhhdSbxsJWJ273nnOoRd81dL9S6PirN2eg68yKkS?=
 =?us-ascii?Q?qME1uwVkGD8DmurnFLU6yXgoVVv3zDJkkhFJGjaPwwlbYQCsOeLMeNcaWY8e?=
 =?us-ascii?Q?cU6412pdTSPhzo5YH69DsXFa5jcqDFWDurP+8rljVSZfUQVwl/bs5unVhfkU?=
 =?us-ascii?Q?MAd4QXgbMVleRp8QVQ2t778u8RJw3Uf0uKFBG6LZbRmHxuEjimoua2DGGu1Y?=
 =?us-ascii?Q?bvOeOZA9+or4YSaidE+UL9ytUixe+SvedCbtK0ZU9+WUec4Kz4TeArwyGKxK?=
 =?us-ascii?Q?Vzqc7W3Nn+KNievUA3QGF1P28slv7nDazq0MZXi340vIBnfZgh1pfPlhLWb5?=
 =?us-ascii?Q?6qGpu3cAIVOYrNPjEGbkepSrQqC1erWweVUUHVYxm7t+rC2xODe2p7FFUbD9?=
 =?us-ascii?Q?cF0+KmaUkvhbMoti1wJnIIaAGj0eYAiVWVpvZn1SJgwi74tycr+QDVhx5x4y?=
 =?us-ascii?Q?cvpYEvOevY+H/gymAg0tArVLUom8Zy4vJcSnV4oc90u0RLD910plTFdpiE8s?=
 =?us-ascii?Q?eBrWMn/0Vne7jmHcZV+ddZfOeggJfXIjMEqTSmdOBigEALygbtHTI6rrN/Ax?=
 =?us-ascii?Q?B4wuO2v8mLZfKpd4oJzBvV8rct0PNCZu5bDIq2rKLsZ0EIq5yjaewfaAfDQJ?=
 =?us-ascii?Q?DUXa0xXxr+ILyJvW3kKide6v3YUhDENvvLEjrhyRl2JnEjvl0fIdAsvNAnXO?=
 =?us-ascii?Q?efZ4viM5XV1YrhZ+oeiN0iea6cMo73c4Vl1PTdT+CM6xUXQWuBx1WtGZKQ/r?=
 =?us-ascii?Q?XNcm2e+130LqkaiOHbwn21KfpSxLYtxhtWjC1kV4zarziPU71H+8KyqXgwHe?=
 =?us-ascii?Q?uu2M4Y5Hsx4f9fkKOWVNqBhSmRgZ/vMlh0GxaI5Phoz7L28QYZatLegBP07b?=
 =?us-ascii?Q?AoIR8f+1R5hB0uU923qQiTJdvyrnHugFOy36ztAMZrk5UUQjTD30ZuAwFLBZ?=
 =?us-ascii?Q?P9VAp2RttiAJr4sEGBC1dw8NGvzKBKeBNsHkaqxxofxoxvS+1IoqGTlXaQLm?=
X-MS-Exchange-AntiSpam-MessageData-1: lprlcwYKJIQTqbcvceSQSjGAcKteJp4oPRM=
X-Exchange-RoutingPolicyChecked: L2kd9bLJ8WxtqOY3M/15yZSXo/jdMfASOKvgGPYZ9tGci+3b10cDRNPeVreL9908yCYO2v+Cm1fQstW/mIlsSwr7fdTIraBTVGW5RVHc8DHpo5jua5Ltbf2+/Nv2nYCCMns6TG7nibvQD6dj1Qs0cTds7ljc1JbGOGPtSs1tTfKDXyrXoc28z+X5KiyXuTP1MqjvE0+JT4oTc+wVFAndmRYiawNcgWF/efPcDmOjWhEaf3mb91lRbQ1f048A4EAL0ABK7SRCZgos95a7QVx7k8KCf4SCRKsJNYXRoQZmI6P4TYDpBqglXVv1DGguv33wH1MlGSe5CuWzw4T2FYUt+Q==
X-MS-Exchange-CrossTenant-Network-Message-Id: edb72f83-57f8-408d-cb95-08dee0e2d094
X-MS-Exchange-CrossTenant-AuthSource: MN2PR11MB3949.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 13 Jul 2026 13:29:50.1877
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 0614tE/PZwY81lzQuo9wnFnqioFL6jm2sUmRM+g3sHl5Uz4EFXXYi74RskhpxGSEiee+zzjRslDd/Ij6LRggUhdcIIjPUtacwV5h8wE0vaI=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DSWPR11MB9954
X-OriginatorOrg: intel.com
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-1.66 / 15.00];
	WHITELIST_SPF_DKIM(-3.00)[intel.com:d:+,kernel.org:s:+];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_REJECT(1.00)[cv is fail on i=2];
	DMARC_POLICY_ALLOW(-0.50)[intel.com,none];
	R_DKIM_ALLOW(-0.20)[intel.com:s=Intel];
	R_SPF_ALLOW(-0.20)[+ip4:172.232.135.74];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-307182-lists,netdev=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sto.lore.kernel.org:helo,sto.lore.kernel.org:rdns,intel.com:from_mime,intel.com:email,intel.com:dkim,vger.kernel.org:from_smtp,soc-5CG4396X81.clients.intel.com:mid];
	FORGED_SENDER(0.00)[larysa.zaremba@intel.com,netdev@vger.kernel.org];
	RCPT_COUNT_TWELVE(0.00)[24];
	FORGED_RECIPIENTS(0.00)[m:anthony.l.nguyen@intel.com,m:davem@davemloft.net,m:kuba@kernel.org,m:pabeni@redhat.com,m:edumazet@google.com,m:andrew+netdev@lunn.ch,m:netdev@vger.kernel.org,m:przemyslaw.kitszel@intel.com,m:aleksander.lobakin@intel.com,m:sridhar.samudrala@intel.com,m:anjali.singhai@intel.com,m:michal.swiatkowski@linux.intel.com,m:maciej.fijalkowski@intel.com,m:emil.s.tantilov@intel.com,m:madhu.chittim@intel.com,m:joshua.a.hay@intel.com,m:jacob.e.keller@intel.com,m:jayaprakash.shanmugam@intel.com,m:jiri@resnulli.us,m:horms@kernel.org,m:corbet@lwn.net,m:richardcochran@gmail.com,m:linux-doc@vger.kernel.org,m:Bharath.r@intel.com,m:andrew@lunn.ch,s:lists@lfdr.de];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	FORWARDED(0.00)[lists@lfdr.de];
	FREEMAIL_CC(0.00)[davemloft.net,kernel.org,redhat.com,google.com,lunn.ch,vger.kernel.org,intel.com,linux.intel.com,resnulli.us,lwn.net,gmail.com];
	DKIM_TRACE(0.00)[intel.com:+];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[larysa.zaremba@intel.com,netdev@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	TO_DN_SOME(0.00)[];
	ALIAS_RESOLVED(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	MID_RHS_MATCH_FROMTLD(0.00)[];
	MISSING_XM_UA(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.232.128.0/19, country:SG];
	RCVD_COUNT_SEVEN(0.00)[10]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 1ABFE74BC31

Below is the answer to Sashiko feedback for this patch.

Sashiko says:
> commit d1a5268fa124e852cecef1e844a5c981bd3df46c
> Author: Amritha Nambiar <amritha.nambiar@intel.com>
> ixd: add devlink support
> This patch adds initial devlink support to the ixd driver, allocating a
> devlink instance per PCIe function and exposing serial number, device
> type, and virtchnl version through the info_get callback. Registration
> happens from the asynchronous init_task work item after virtchnl device
> init succeeds.
> > diff --git a/drivers/net/ethernet/intel/ixd/ixd.h b/drivers/net/ethernet/intel/ixd/ixd.h
> > index 8e3cd5bc5a84..343c5053045f 100644
> > --- a/drivers/net/ethernet/intel/ixd/ixd.h
> > +++ b/drivers/net/ethernet/intel/ixd/ixd.h
> > @@ -23,6 +23,7 @@ struct ixd_adapter {
> >  		struct delayed_work init_work;
> >  		u8 reset_retries;
> >  		u8 vc_retries;
> > +		bool success;
> >  	} init_task;
> Is encoding devlink registration state via this new success flag the
> right approach?
> The flag only exists to gate ixd_devlink_unregister():
>     static inline void ixd_devlink_unregister(struct ixd_adapter *adapter)
>     {
>         if (!adapter->init_task.success)
>             return;
>         devlink_unregister(priv_to_devlink(adapter));
>     }
> Devlink core already tracks registration state (devl_is_registered(),
> ASSERT_DEVLINK_NOT_REGISTERED). Any future code path that adds another
> devlink_register()/devlink_unregister() call site (for example a reset
> recovery or renegotiation flow) would have to remember to keep this
> flag in sync, and 'init succeeded' and 'devlink registered' may
> otherwise diverge over time.
> Would relying on the devlink core's own registration tracking be
> preferable here?
> 
devl_is_registered() is not accessible to drivers.
The idea here is that init_task can stop working correctly at any stage.
Once remove() cancels it, we should establish, what parts need to be undone.
In the future, enum could be of use for the consecutive stage, but a binary flag in enough for now.
> 
> > diff --git a/drivers/net/ethernet/intel/ixd/ixd_lib.c b/drivers/net/ethernet/intel/ixd/ixd_lib.c
> > index ce870aba143d..6f2b39cd985c 100644
> > --- a/drivers/net/ethernet/intel/ixd/ixd_lib.c
> > +++ b/drivers/net/ethernet/intel/ixd/ixd_lib.c
> > @@ -154,6 +155,8 @@ void ixd_init_task(struct work_struct *work)
> >  
> >  	if (!ixd_vc_dev_init(adapter)) {
> >  		adapter->init_task.vc_retries = 0;
> > +		adapter->init_task.success = true;
> > +		ixd_devlink_register(adapter);
> >  		return;
> >  	}
> Should devlink registration really be deferred to this asynchronous work
> callback and gated on virtchnl init success?
> If the device fails initialization permanently (reset never completes
> within 10 retries, or the virtchnl handshake fails after 5 retries in
> ixd_init_task()), the PCI device remains bound to the driver but no
> devlink instance is ever exposed. Users lose devlink dev show and
> devlink dev info visibility precisely in the failure modes where such
> diagnostics would be most useful.
> Sibling Intel drivers such as i40e and ice register devlink
> synchronously from probe() so the device is always visible.
> ixd_fill_device_name() already handles the uninitialized case by
> falling back to "UNKNOWN":
>     if (adapter->caps.device_type == cpu_to_le32(VIRTCHNL2_MEV_DEVICE))
>         snprintf(buf, buf_size, "%s", "MEV");
>     else
>         snprintf(buf, buf_size, "%s", "UNKNOWN");
> Could ixd_devlink_register() be moved into ixd_probe() so failed
> devices remain visible to devlink?
> 
We have nothing to expose, if have not yet initialized basic HW communication
ixd and idpf utilize async initialization, because e.g. after power cycle,
control plane can be unresponsive for some time

