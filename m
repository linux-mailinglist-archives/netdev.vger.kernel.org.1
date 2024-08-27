Return-Path: <netdev+bounces-122302-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C7EE49609B6
	for <lists+netdev@lfdr.de>; Tue, 27 Aug 2024 14:09:58 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 7F0E628599E
	for <lists+netdev@lfdr.de>; Tue, 27 Aug 2024 12:09:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7B14A1A0B1A;
	Tue, 27 Aug 2024 12:08:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="CiqT5GNB"
X-Original-To: netdev@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.15])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 079481A072B
	for <netdev@vger.kernel.org>; Tue, 27 Aug 2024 12:08:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=198.175.65.15
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724760537; cv=fail; b=Xvz80WBkofXqTjUycplREUrk7+tf7+NNrCxlhZf8qBOhHVAINIDxstLJ/KvoJ8CrYTPCsCScqPS8P8WmJZuwONZwHA20T+lqUrXDwtFkSuYFAJBTXXG6wZs6TBkCs18FdaYIuBzEo+jlrAdQeDvJYv4/l0Snwxl9//xBG6XAHjg=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724760537; c=relaxed/simple;
	bh=syPeOqBfEjP8S6p0CF14hJAjLbBhdTQX61lEXiCOiu0=;
	h=Date:From:To:CC:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=csJ66w3Bedm4lecx9pioUv+bZGbmfenL/MkcZ58orTZBmv8f3GjA0Yzrq+6fIUbgUaRUb2cGj/+5pSXIL6uMl2oagd/3QviEzOMVWQqNAkFH/x4I5zZj5VIQ3bF61y5sSbn+ozc6dyAof6pN1rpWhNRItsPhEqQ6ljtuuBUnL5Y=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=CiqT5GNB; arc=fail smtp.client-ip=198.175.65.15
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1724760535; x=1756296535;
  h=date:from:to:cc:subject:message-id:references:
   in-reply-to:mime-version;
  bh=syPeOqBfEjP8S6p0CF14hJAjLbBhdTQX61lEXiCOiu0=;
  b=CiqT5GNBf7dLRiarlFUF2dD3R62qpOcunHIHzDbn6p0sBr4pXcFfY08z
   oM2xii4XYpKSQ8xxcxCQvOY6kZGZguxenYyQO+zgTT3paDIEXoLqG3CVx
   3w96/e/bnfuk1aCkkTEgTuV8x93f/SSp/uqq3hPVtAAEc+iVkMSuAzBBQ
   dxjLjEGhgaxNgJaPjL7X7zdrfP5cRC8je26z4ahTXRBFAqi63H66aBUej
   ARy2n82Q+hQNQ8v1d1LL3vwKtoJwLRmZuH0pfymtFrsi9Jj6e8T0Xryip
   SxrgIVElhgpWU+dTRPAOcemfv+SEg0k8expFJkrDoTvgJsmuDWdWLln5V
   w==;
X-CSE-ConnectionGUID: OstbSYl0QluF4+DCMUODWg==
X-CSE-MsgGUID: 2CWemFhkRCmORe8DCyJH1g==
X-IronPort-AV: E=McAfee;i="6700,10204,11176"; a="26998668"
X-IronPort-AV: E=Sophos;i="6.10,180,1719903600"; 
   d="scan'208";a="26998668"
Received: from orviesa006.jf.intel.com ([10.64.159.146])
  by orvoesa107.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 27 Aug 2024 05:08:54 -0700
X-CSE-ConnectionGUID: N5jQgnXkRXudPw/dIFbBPQ==
X-CSE-MsgGUID: wact7NBUQhGfTMKb44ns6A==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.10,180,1719903600"; 
   d="scan'208";a="63149647"
Received: from orsmsx603.amr.corp.intel.com ([10.22.229.16])
  by orviesa006.jf.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 27 Aug 2024 05:08:54 -0700
Received: from orsmsx610.amr.corp.intel.com (10.22.229.23) by
 ORSMSX603.amr.corp.intel.com (10.22.229.16) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39; Tue, 27 Aug 2024 05:08:54 -0700
Received: from orsmsx610.amr.corp.intel.com (10.22.229.23) by
 ORSMSX610.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39; Tue, 27 Aug 2024 05:08:53 -0700
Received: from ORSEDG601.ED.cps.intel.com (10.7.248.6) by
 orsmsx610.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39 via Frontend Transport; Tue, 27 Aug 2024 05:08:53 -0700
Received: from NAM10-MW2-obe.outbound.protection.outlook.com (104.47.55.43) by
 edgegateway.intel.com (134.134.137.102) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.39; Tue, 27 Aug 2024 05:08:52 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=yodMsFe9YKF+TU5S3/jAuVLVrqu4jrKebVresypjIhjzadLe2x6TlNq+ygytXuc/3TwR1+N11TYz26MSNRzqFZbujuOTfu3hRFI0RZ7T+4htMMZ1DuCky/VItXaujZDzUn2yOBK9KlEg8qv54CIOJmGq51rjfoesvSFYvXDRgjadwRbrxFqGGlBEJCYbylr2ZY4Y9UAurQqSBfDZmkEH3zGLliqKgXyTEfXHZGYJEMw/SKuHTcnFOwwwcin0HgUgVSAOrA6UnlZdoKjEUNw/ErvuKbwpEelTVEHkfGrx/hKTh9CpqFQLmXraKdwJKOcEA0lIHdQ8tWoEMOLGp7VXWQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=zz6P3sDJqgWitkdWEcSYZXrEtWgVJd84evpm1sdPOhk=;
 b=THYzv/yYWik3/StgQD23Ty4d7uyAb9ashKQii2OtEErHYV/2ov40pdJDHMe0phJV2qnWuBzjitUcubq5C4ZJMnihT2gaBW92XNrEfje2p630O8Bud1fq6Yk5oKrDIshNgB0jMmQj3TUt5ot+RAwXpNv2TTigCEdyCP5ERCKhGOr1pcbNhE1dNQGC6bOtnlqdeUYjRTjG4yf55KsMQiAixf1MtQ6TBhCD+FbcmA+rH6ArOI5x1GxFCAZDeQIEo/lBUuTdc/PyPcQjLPrc0qrqvZb5TpCxrgD0XTJfh0fMRqxnXAeWjX27KY4kCYLIzEObu0r8PWAKdmjFlfC6C7ktfg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from SN7PR11MB7540.namprd11.prod.outlook.com (2603:10b6:806:340::7)
 by SA1PR11MB8255.namprd11.prod.outlook.com (2603:10b6:806:252::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7897.25; Tue, 27 Aug
 2024 12:08:44 +0000
Received: from SN7PR11MB7540.namprd11.prod.outlook.com
 ([fe80::399f:ff7c:adb2:8d29]) by SN7PR11MB7540.namprd11.prod.outlook.com
 ([fe80::399f:ff7c:adb2:8d29%3]) with mapi id 15.20.7897.021; Tue, 27 Aug 2024
 12:08:44 +0000
Date: Tue, 27 Aug 2024 14:08:36 +0200
From: Larysa Zaremba <larysa.zaremba@intel.com>
To: Brett Creeley <brett.creeley@amd.com>
CC: <netdev@vger.kernel.org>, <davem@davemloft.net>, <kuba@kernel.org>,
	<edumazet@google.com>, <pabeni@redhat.com>, <shannon.nelson@amd.com>
Subject: Re: [PATCH v2 net-next 4/5] ionic: always use rxq_info
Message-ID: <Zs3BxMCNEeuBrooo@lzaremba-mobl.ger.corp.intel.com>
References: <20240826184422.21895-1-brett.creeley@amd.com>
 <20240826184422.21895-5-brett.creeley@amd.com>
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <20240826184422.21895-5-brett.creeley@amd.com>
X-ClientProxiedBy: ZR2P278CA0036.CHEP278.PROD.OUTLOOK.COM
 (2603:10a6:910:47::14) To SN7PR11MB7540.namprd11.prod.outlook.com
 (2603:10b6:806:340::7)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SN7PR11MB7540:EE_|SA1PR11MB8255:EE_
X-MS-Office365-Filtering-Correlation-Id: fb7c31fa-1ce5-473b-775e-08dcc690ff88
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|1800799024|376014;
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?51annP9sHwFsiW3ImwHHTVPFDcKunh2vfMk5HSvWJujwJ3SyG4IcYvoH8QUN?=
 =?us-ascii?Q?hnOfqgjF5wFHV/if4Bh9bvYBGnc0OuZaeWvng5n2dbctBvu7HcvSdMb8VbqP?=
 =?us-ascii?Q?YoZgWpK/Zqf948687SY6TcTf6qqEdLj8LmR2yqB2Tl714VoFfCW17giv0Tm7?=
 =?us-ascii?Q?JpLtkBnHLd9u2rV170wZZjm4O9SjiEc+l6so0X+vjixuVKtA3DITQvstNB+S?=
 =?us-ascii?Q?x2d7hJlQfL/FxirRrDseGGmVGRs+zZGJxKJxlopuZIWu9eg9oRq2sedMYJaF?=
 =?us-ascii?Q?ZtZ8iP5UU+i58m5Ua5QfET2CQ8mK8P7NK538IYktvPPt/H6h4/GklmWXSEsK?=
 =?us-ascii?Q?FKX3ZCyFDrlOKX0Dia1Muvh49QKYD3TeKw2N5XIcWiYf5WzOK43z2fVTEWx5?=
 =?us-ascii?Q?ZWm3E1V7BCxzTsBlPKg5ogL+BCUmfyH3ahl6sUs7lZ57tvsS4DsChBoJi5Gu?=
 =?us-ascii?Q?fr/Qp0zybLBOMZWJwkTs1WmiO28btai5qKedgqTVYIK+1YDP5sOmKQbTQvqy?=
 =?us-ascii?Q?qDRXPkiiheTQb70K4L1qGvLPvOl+MCv/obs2cRh1mmpsJSw8GihgND+mc+wD?=
 =?us-ascii?Q?vYIlqfnHFN/gc5xEP+U1XGnzvrLxKU9iFXsmPHBLU29lwIJuX7nS2t2qdp0c?=
 =?us-ascii?Q?pcCdc30N2TdPhcBnAhvKtxi1pI9MzQG9f6qjhZ1+JBSX41yvHYn++AX2vG3w?=
 =?us-ascii?Q?8rHZ3WOguJHY0oIdli48WWbWT+K5tWXkoRhBP8CHBJQgtrrzmDp1tsEoX9Bf?=
 =?us-ascii?Q?ZJLJuKxVhkR6bfgpcIf6AcjuoaNjBn44TPAsTTIWgTWWOUfVItdpi7ZKeiRH?=
 =?us-ascii?Q?DCCAjJ4CKzzm6L76Jasy64cDdFSRk1eku71lsJtwyp/1FARkD0b73oTGAxZb?=
 =?us-ascii?Q?5d9Pc/Dtp/WyJ+PEGP3zNSZ+EAoo+CHi95bT1JZbTbFl186uA6nTbNlJDfMH?=
 =?us-ascii?Q?HpwPt+uhDdkLKSLQeiABT6ARvF75esg+ceyt7eX6H//VFc1Tjjh2K1rX2pGQ?=
 =?us-ascii?Q?2l9eY4bI/d6y51THayppxVml6TGPCAu7RppWSrxUSsc4A84AMDybaWVbJYaq?=
 =?us-ascii?Q?AKb5bq9nwO5HDHnTpQd176nS0Dz60k1fJD2wMPnyDSk+0hgK0iVe3g0kLGRB?=
 =?us-ascii?Q?9zzTTkN0woJUtsET3oFBn4/Wy9Grf4NubCmdcMvOA87RQzIcGsWYGqQ2L5Df?=
 =?us-ascii?Q?VbFTk6iJ9WF375oIdCjrWZuKAOc36onS9oRVZOGXM4fYGbSbHLs3TbE5ltP8?=
 =?us-ascii?Q?ZrQtiOIl9Yp4rW4Neo0CKhjdNKzXtCNoMuNRUA8PvARJBxAJZGTb2VVtrs5A?=
 =?us-ascii?Q?vsr7tidPjIixTSKIfk7gM1et72rag0rHB8CMNRgAMggC8Q=3D=3D?=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SN7PR11MB7540.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(376014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?C3bjF+4clhz8wgYuspyZubtkI7VsWQwPj+AHKxovClq2TuaeMWbY+I4SSM66?=
 =?us-ascii?Q?4QyMCzX6KeuO4fMHO+GwK2u+LRJYjq+qICpcuJy2UNFSGW0Ljh2OD6CUnMbu?=
 =?us-ascii?Q?PRixwsLYN4pnRBvL6J3bzNPrxQdFOFPrtUC3E+6FvZI6ZJDDv0aDMjy2gei5?=
 =?us-ascii?Q?xrOxYGKZ0dmAkyBG+fggXHs6qo+tqoZBt+ixJp0GqDWiHQXBDHtS95wj2+dX?=
 =?us-ascii?Q?v5qMAlLTzR3unYKoKLqYRP7Kij59lSEiXxgdbjtrLg52PD4Tazu1MhPEoEE6?=
 =?us-ascii?Q?KKXJOlh7ZW1tQ9AGRs4tz/n+nQVo8dyDWl3LnDfWt3ySWccwzNGly+9vawlA?=
 =?us-ascii?Q?68PpgEhUhR5/X+LOIpwD6rQHzF7wna8/QuYSZM4Ha08xcvZ2l0H4ieVB+84P?=
 =?us-ascii?Q?PRpJlXY6QZBwqPMBWZUK9fq5Xh+LwvZ2FPpirlQjPLI0B4MwojKyLbGbojDH?=
 =?us-ascii?Q?mG5XPfGemfX+vayuIkYdG8cVlETQAgYLR1HMNtFb9wC8Syi2ONNYacI9KQph?=
 =?us-ascii?Q?/CzYMtJSEktyWjUq+WzOC2Pogtb8dr900tIpfFwng3JmosreOcvnxotYh0Bk?=
 =?us-ascii?Q?FjQfmuK/0FFNeMh/gIBy7/cBKNVWvoqh56cpFdLIFJyueA/9U1+4yf7OF888?=
 =?us-ascii?Q?mDcc1RAXlIkaomNS0FerC5WiouhXbuyQwI+3o3oRK8nJLmadSkfNoLjAAoUB?=
 =?us-ascii?Q?WiSIAntWRrcevhSLM8199EriU8QcXPU6UtK838+2sAoiphwP7tOm+VjSrIfy?=
 =?us-ascii?Q?yevaw74yaEoi/jtHz6cz0i/A7tlkceDhYBHB1+CEloTlIwbFqAKDmxdGy3a0?=
 =?us-ascii?Q?Yc7sdVYhasJbvjZylxUKBbUpI2BM6Ku3GfbjenMb7cdyIQIBUq6WJH05RPBV?=
 =?us-ascii?Q?gu8V3YCvv8Gi5dqwf5fi519pB7waIEL+ZzI+yaDdgAT9/HfP24/alObY/jY5?=
 =?us-ascii?Q?HDaIbJVtSjGnEomKY3fbmc+BZwY7e+teNIO1UuHta/J5o7WEqF8jPi4t8RCD?=
 =?us-ascii?Q?EYqvJa6YFSRJOXfvSriVxC83VBnxPpApiCq3pXVHIPV23GmOlsC9i0f37rWi?=
 =?us-ascii?Q?QAx4h0ux+LrTAeAq4TTmhru3C48dhYTWvsZBgnglo+qaClisDHAeVIJqwXLM?=
 =?us-ascii?Q?ew1W1bbbNKlDXCOB62iU8OVzutt5tjutRZRMtj2g8YtrTj3IawNxVyQnxqnF?=
 =?us-ascii?Q?k9SxWXAltoSA+C/L//58KRsUyCWkm+ztYE+JFewe8r2kenhxDAWuriCXU5Ow?=
 =?us-ascii?Q?5WZ5HksH3HeA6o7gMqf7HV8wsSB283Z9Q9Zv047FzxjPHmmnj4GlaMXclh1z?=
 =?us-ascii?Q?ml8aKBSllFDXkUL+vtVH9jdu8Ma6Hos8Z5pW9KgMGyPat+4hTk/n2bRYip3r?=
 =?us-ascii?Q?JfYhlg8KZhxNIvq7/2oL3ERiOCbgFV5FbRmjFxP7kFLZ2/9KQ4HO3Ha/pGtw?=
 =?us-ascii?Q?jU87I2C792uSYsiqH02zkdxheDxVEGXt+CCWcqzebP4zo/unsuwBjpTL8PC0?=
 =?us-ascii?Q?yuXOEYaSImE29RIv9jQ9N+6Esr6A3kYUnmdC8U3n0A9y9fcxGKO/N2XtUH9/?=
 =?us-ascii?Q?KK3YrnZcDQa/lMawrVpN3dLq3XriKIYzO5aVeman?=
X-MS-Exchange-CrossTenant-Network-Message-Id: fb7c31fa-1ce5-473b-775e-08dcc690ff88
X-MS-Exchange-CrossTenant-AuthSource: SN7PR11MB7540.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 27 Aug 2024 12:08:44.5129
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: +aYpSPuQPt9qChZee3TkKmS7XC70MthLSWgA9CpW9EBsXYD38Sxy3ClvvwK1Wpj4BJEhbDRmxXx2lRpOoUPruucFCJy3F35sP29PSIycqyE=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA1PR11MB8255
X-OriginatorOrg: intel.com

On Mon, Aug 26, 2024 at 11:44:21AM -0700, Brett Creeley wrote:
> From: Shannon Nelson <shannon.nelson@amd.com>
> 
> Instead of setting up and tearing down the rxq_info only when the XDP
> program is loaded or unloaded, we will build the rxq_info whether or not
> XDP is in use.  This is the more common use pattern and better supports
> future conversion to page_pool.  Since the rxq_info wants the napi_id
> we re-order things slightly to tie this into the queue init and deinit
> functions where we do the add and delete of napi.
> 
> Signed-off-by: Shannon Nelson <shannon.nelson@amd.com>
> Signed-off-by: Brett Creeley <brett.creeley@amd.com>
> ---
>  .../net/ethernet/pensando/ionic/ionic_lif.c   | 55 +++++++------------
>  1 file changed, 19 insertions(+), 36 deletions(-)
> 
> diff --git a/drivers/net/ethernet/pensando/ionic/ionic_lif.c b/drivers/net/ethernet/pensando/ionic/ionic_lif.c
> index 0fba2df33915..4a7763ec061f 100644
> --- a/drivers/net/ethernet/pensando/ionic/ionic_lif.c
> +++ b/drivers/net/ethernet/pensando/ionic/ionic_lif.c
> @@ -46,8 +46,9 @@ static int ionic_start_queues(struct ionic_lif *lif);
>  static void ionic_stop_queues(struct ionic_lif *lif);
>  static void ionic_lif_queue_identify(struct ionic_lif *lif);
>  
> -static int ionic_xdp_queues_config(struct ionic_lif *lif);
> -static void ionic_xdp_unregister_rxq_info(struct ionic_queue *q);
> +static void ionic_xdp_queues_config(struct ionic_lif *lif);
> +static int ionic_register_rxq_info(struct ionic_queue *q, unsigned int napi_id);
> +static void ionic_unregister_rxq_info(struct ionic_queue *q);
>  
>  static void ionic_dim_work(struct work_struct *work)
>  {
> @@ -380,6 +381,7 @@ static void ionic_lif_qcq_deinit(struct ionic_lif *lif, struct ionic_qcq *qcq)
>  	if (!(qcq->flags & IONIC_QCQ_F_INITED))
>  		return;
>  
> +	ionic_unregister_rxq_info(&qcq->q);
>  	if (qcq->flags & IONIC_QCQ_F_INTR) {
>  		ionic_intr_mask(idev->intr_ctrl, qcq->intr.index,
>  				IONIC_INTR_MASK_SET);
> @@ -437,9 +439,7 @@ static void ionic_qcq_free(struct ionic_lif *lif, struct ionic_qcq *qcq)
>  		qcq->sg_base_pa = 0;
>  	}
>  
> -	ionic_xdp_unregister_rxq_info(&qcq->q);
>  	ionic_qcq_intr_free(lif, qcq);
> -
>  	vfree(qcq->q.info);
>  	qcq->q.info = NULL;
>  }
> @@ -925,6 +925,11 @@ static int ionic_lif_rxq_init(struct ionic_lif *lif, struct ionic_qcq *qcq)
>  		netif_napi_add(lif->netdev, &qcq->napi, ionic_rx_napi);
>  	else
>  		netif_napi_add(lif->netdev, &qcq->napi, ionic_txrx_napi);
> +	err = ionic_register_rxq_info(q, qcq->napi.napi_id);
> +	if (err) {
> +		netif_napi_del(&qcq->napi);
> +		return err;
> +	}
>  
>  	qcq->flags |= IONIC_QCQ_F_INITED;
>  
> @@ -2143,9 +2148,7 @@ static int ionic_txrx_enable(struct ionic_lif *lif)
>  	int derr = 0;
>  	int i, err;
>  
> -	err = ionic_xdp_queues_config(lif);
> -	if (err)
> -		return err;
> +	ionic_xdp_queues_config(lif);
>  
>  	for (i = 0; i < lif->nxqs; i++) {
>  		if (!(lif->rxqcqs[i] && lif->txqcqs[i])) {
> @@ -2192,8 +2195,6 @@ static int ionic_txrx_enable(struct ionic_lif *lif)
>  		derr = ionic_qcq_disable(lif, lif->rxqcqs[i], derr);
>  	}
>  
> -	ionic_xdp_queues_config(lif);
> -
>  	return err;
>  }
>  
> @@ -2651,7 +2652,7 @@ static void ionic_vf_attr_replay(struct ionic_lif *lif)
>  	ionic_vf_start(ionic);
>  }
>  
> -static void ionic_xdp_unregister_rxq_info(struct ionic_queue *q)
> +static void ionic_unregister_rxq_info(struct ionic_queue *q)
>  {
>  	struct xdp_rxq_info *xi;
>  
> @@ -2665,7 +2666,7 @@ static void ionic_xdp_unregister_rxq_info(struct ionic_queue *q)
>  	kfree(xi);
>  }
>  
> -static int ionic_xdp_register_rxq_info(struct ionic_queue *q, unsigned int napi_id)
> +static int ionic_register_rxq_info(struct ionic_queue *q, unsigned int napi_id)
>  {
>  	struct xdp_rxq_info *rxq_info;
>  	int err;
> @@ -2698,45 +2699,27 @@ static int ionic_xdp_register_rxq_info(struct ionic_queue *q, unsigned int napi_
>  	return err;
>  }
>  
> -static int ionic_xdp_queues_config(struct ionic_lif *lif)
> +static void ionic_xdp_queues_config(struct ionic_lif *lif)

I think this function should also get a new name that would reflect the fact 
that it is just updating the XDP prog on rings. Also, ionic_xdp_queues_config 
sounds a little bit like configuring XDP_TX/xdp_xmit queues, but here we have rx 
queues only.

>  {
>  	struct bpf_prog *xdp_prog;
>  	unsigned int i;
> -	int err;
>  
>  	if (!lif->rxqcqs)
> -		return 0;
> +		return;
>  
> -	/* There's no need to rework memory if not going to/from NULL program.  */
> +	/* Nothing to do if not going to/from NULL program.  */
>  	xdp_prog = READ_ONCE(lif->xdp_prog);
>  	if (!xdp_prog == !lif->rxqcqs[0]->q.xdp_prog)
> -		return 0;
> +		return;
>  
>  	for (i = 0; i < lif->ionic->nrxqs_per_lif && lif->rxqcqs[i]; i++) {
>  		struct ionic_queue *q = &lif->rxqcqs[i]->q;
>  
> -		if (q->xdp_prog) {
> -			ionic_xdp_unregister_rxq_info(q);
> +		if (q->xdp_prog)
>  			q->xdp_prog = NULL;
> -			continue;
> -		}
> -
> -		err = ionic_xdp_register_rxq_info(q, lif->rxqcqs[i]->napi.napi_id);
> -		if (err) {
> -			dev_err(lif->ionic->dev, "failed to register RX queue %d info for XDP, err %d\n",
> -				i, err);
> -			goto err_out;
> -		}
> -		q->xdp_prog = xdp_prog;
> +		else
> +			q->xdp_prog = xdp_prog;
>  	}
> -
> -	return 0;
> -
> -err_out:
> -	for (i = 0; i < lif->ionic->nrxqs_per_lif && lif->rxqcqs[i]; i++)
> -		ionic_xdp_unregister_rxq_info(&lif->rxqcqs[i]->q);
> -
> -	return err;
>  }
>  
>  static int ionic_xdp_config(struct net_device *netdev, struct netdev_bpf *bpf)
> -- 
> 2.17.1
> 
> 

