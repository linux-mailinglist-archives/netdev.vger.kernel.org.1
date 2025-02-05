Return-Path: <netdev+bounces-162876-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 0E336A28415
	for <lists+netdev@lfdr.de>; Wed,  5 Feb 2025 07:08:36 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 2DA0F3A3D3F
	for <lists+netdev@lfdr.de>; Wed,  5 Feb 2025 06:08:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 26C56221D9B;
	Wed,  5 Feb 2025 06:08:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="fN9EpT6S"
X-Original-To: netdev@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.14])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8792E221D86;
	Wed,  5 Feb 2025 06:08:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=198.175.65.14
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1738735705; cv=fail; b=laeOx+0wEGhuoYm+jhzjSSHE/N5zVFBWv4cDR2IC2VEJw917zYb7XRXOgoLMgmVxZSdOlrZfz6RvMCXBNNlkYpyDHEfqTCVhUwnMMqc2tkSLsIEjFxgEHbiabJ0gZoY8sC7YysYlUMVscvIum2KLOEb6mEppKwNDWQUXe8dL3PQ=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1738735705; c=relaxed/simple;
	bh=4au4y4vMmBL60EXJD0ldJ7ZydbZcyQL2x0sri986hGY=;
	h=Date:From:To:CC:Subject:Message-ID:Content-Type:
	 Content-Disposition:MIME-Version; b=SHSFwOCO4LZB0l1Pxb4cMQ0Bc5MYtJFxJhJOW2wtjl5jdcr26bPBY56+IUktSDc7fmEDfU6LWKfcXq6Sag3Af4z8jxaEVReUArIxiEmfTqN0EMedRUusYaUcA5GERfJOnSaLnRN4/mcVu6VnJF8jf0HdJhgomeoMXRe/RstnfSI=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=fN9EpT6S; arc=fail smtp.client-ip=198.175.65.14
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1738735702; x=1770271702;
  h=date:from:to:cc:subject:message-id:mime-version;
  bh=4au4y4vMmBL60EXJD0ldJ7ZydbZcyQL2x0sri986hGY=;
  b=fN9EpT6SaKQXp7qUB1fuYiY35bcwVCYHTtXjCCQhOBJ4cTT0/wTfZOGJ
   bAoMKYXM1sJ7HhKtEedtKohk+IObrlkmet2AJJIsd5+1i5AH2072P/E3b
   qbw6Xw+BDeEfRb7FOyhi6/W4dbzWU7D7pLdiytTItYeM4a/f6qlZ+N8Vu
   zjRxKH0QBtJ7z1NiLmEhZCw8od4nkb810OZsq6HZjuhiwrHWWI0kIlfUn
   VmzEIzpDF/3Y2tLtALmiyVj5pZYLetFQ2MsTxfWsYj4nRKW+xx8mYFybd
   utgdsn5i2tXa+2cBwq0Hrt+v8Vm6OlC8GYrE8Dp4o/vhqItzGwsHsJMtV
   g==;
X-CSE-ConnectionGUID: pt1r8aplRAWpd53sUehy+g==
X-CSE-MsgGUID: E/U+68CRTT+MkVlW8dYSbg==
X-IronPort-AV: E=McAfee;i="6700,10204,11336"; a="43038688"
X-IronPort-AV: E=Sophos;i="6.13,260,1732608000"; 
   d="scan'208";a="43038688"
Received: from orviesa009.jf.intel.com ([10.64.159.149])
  by orvoesa106.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 04 Feb 2025 22:08:16 -0800
X-CSE-ConnectionGUID: OTcAwp+oSqK4dd91dYA1uQ==
X-CSE-MsgGUID: EJ5iZlGwRUu5bhFPR0FxEg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.13,260,1732608000"; 
   d="scan'208";a="110592062"
Received: from orsmsx603.amr.corp.intel.com ([10.22.229.16])
  by orviesa009.jf.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 04 Feb 2025 22:08:17 -0800
Received: from orsmsx601.amr.corp.intel.com (10.22.229.14) by
 ORSMSX603.amr.corp.intel.com (10.22.229.16) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.44; Tue, 4 Feb 2025 22:08:15 -0800
Received: from ORSEDG602.ED.cps.intel.com (10.7.248.7) by
 orsmsx601.amr.corp.intel.com (10.22.229.14) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.44 via Frontend Transport; Tue, 4 Feb 2025 22:08:15 -0800
Received: from NAM12-MW2-obe.outbound.protection.outlook.com (104.47.66.40) by
 edgegateway.intel.com (134.134.137.103) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.44; Tue, 4 Feb 2025 22:08:15 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=VAcPWH9eEnh1oKby3DKPSIMGTDYemWnGOCgCNp9uDfI9FjR0H0Lx7Ux6n5CFm3Kv7BlNQMh7QD9CMBliRlh+xC3MsFZKvMSids4mLhCQZmXZ30PM93V2uSi1hwHoLF44NLy5/TPTa+H82L77B9B0TFndS02J8JzxbAt041DfKjf7tBH6mBjad1xD02WCErn/tHqt0Zi6slyuFfaiOihSECx8HDp1QkGQVx8+vJZhW7Om63tOjuh/Fo3SQ14ZrFEUzy8MSYqFrf7DrUMPN3/oiLYaFmHhUiQ+hjHzsWym3AJYBFS2lD1WM4Dfj83CD1pKXfKeEX2Xhsmw7ppWtwX5MA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=xkftY1TpNSjy4UzhF68HFQWBZkziZkPzbu4ChvXhtT8=;
 b=afkzFYFXXBVM910Vl2fCnbvGvMuWJD1qZA9ph0BwLeyvIJ4rCbSVjHG/ad/ajyyvNzC9v50KmcgF4NoVgSoMu0uZl6j7Fs8UFGBnxKhLpcsoTJ6Tb/KYNYpWDRERMl4+cxO7edIGjQvUvCAis5xJf4WwZj/n31Cg/HAOexI89MYoBKpShluZtSLzrqm6wUkWb8j7enegi/vNIEI7CXu0gh5Xlvlm8G8Ebkl8bdiMsmDUYfCkEUuCK3fYeNR7CGu7XDHXDV7Zvls5QlkixZ1M1r7HfqgTT4JvtCO7zDcGtF4yPVPl0feM8xEPojhOAmu7xnS0ob8NfJ3eK3LqTG2ZWg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from LV3PR11MB8603.namprd11.prod.outlook.com (2603:10b6:408:1b6::9)
 by CO1PR11MB4820.namprd11.prod.outlook.com (2603:10b6:303:6f::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8422.11; Wed, 5 Feb
 2025 06:08:13 +0000
Received: from LV3PR11MB8603.namprd11.prod.outlook.com
 ([fe80::4622:29cf:32b:7e5c]) by LV3PR11MB8603.namprd11.prod.outlook.com
 ([fe80::4622:29cf:32b:7e5c%3]) with mapi id 15.20.8398.025; Wed, 5 Feb 2025
 06:08:13 +0000
Date: Wed, 5 Feb 2025 14:08:04 +0800
From: kernel test robot <oliver.sang@intel.com>
To: Russell King <rmk+kernel@armlinux.org.uk>
CC: <oe-lkp@lists.linux.dev>, <lkp@intel.com>, <linux-kernel@vger.kernel.org>,
	Jakub Kicinski <kuba@kernel.org>, Jacob Keller <jacob.e.keller@intel.com>,
	<netdev@vger.kernel.org>, <oliver.sang@intel.com>
Subject: [linus:master] [net]  03abf2a7c6: WARNING:suspicious_RCU_usage
Message-ID: <202502051331.7587ac82-lkp@intel.com>
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
X-ClientProxiedBy: SGXP274CA0017.SGPP274.PROD.OUTLOOK.COM (2603:1096:4:b8::29)
 To LV3PR11MB8603.namprd11.prod.outlook.com (2603:10b6:408:1b6::9)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: LV3PR11MB8603:EE_|CO1PR11MB4820:EE_
X-MS-Office365-Filtering-Correlation-Id: 979f0685-819e-4bf9-edb1-08dd45ab796a
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|366016|1800799024;
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?6Ly8ObnSw7q2BiCqkt6OSRHH6BWzKsIh0c4C361gJEJljKqVdtK9OJCrWgW6?=
 =?us-ascii?Q?oRCu0mbJzbXKB8yJN6oQcfIXKQcmJH25U+HSGXnXLg399Bjqdn/cn+WXr4aS?=
 =?us-ascii?Q?TD5T3NEsBKFwhC3Hi+ZoIdHMY7TLJQcb/QJzmZBb9NnN1Rct/8AkkEozL2il?=
 =?us-ascii?Q?Mf8/ehl6VhH1dAD11QwqKrUQ4rN5WwGmsCeKW7C6TbCPg7eP8nuyBdb6p0uu?=
 =?us-ascii?Q?w4MehxKqhIb94buhiVqPU+X3uQBlXICRMD6bKhDaquakQ8LiS7xn9A6dNwn0?=
 =?us-ascii?Q?1j0LxKbfBm4gu7611WYak0K0AaaegFse4ks3hR0QjpdDalnslqHFgsjCOCOA?=
 =?us-ascii?Q?feNTGL7EAxMPWv82pZUd8zxRLE7oi7CyrmTfqqFewKBJY6OuO40hI15AOqWV?=
 =?us-ascii?Q?UT/hbU+5RcLNnw1akxsGvgkDl0KVO2GC/H1Yi7Fs4oLhadJCtxsteTjlQZEJ?=
 =?us-ascii?Q?U88RKCR20cOyoWgKkafOfOwup6IzbhoBFm6x4OlCY2hCK0nIZWINhKAB2IJe?=
 =?us-ascii?Q?2eI5YP3VyAdem8lkJ7qbB0JBhxgkmgB7rrbwXrmPlvUT1fvE71USz1dcJmHC?=
 =?us-ascii?Q?vwLabjq5pI7UeFgaKSOgxV8vqBAgxTxSkpkRl3bwKDca1efY690fzXUUwGQy?=
 =?us-ascii?Q?jdPLg5zithbOfAtInzxj+Cu4XFaG1Eiye3nKVb7ZpcpcxsWjZOqj2K8VhpeF?=
 =?us-ascii?Q?j7CVB7U+821QoGzUO78aAXdKMTPP7S0p2xPYp0scgpjdPzrXi1tOhgCruLFF?=
 =?us-ascii?Q?YM1l47euq0x6SIIO9Lj6K1rSOGO/S9zW1esJMRhOWV3Y4nQMiRz7wGqEZ263?=
 =?us-ascii?Q?4OPEX3IMecpk77RmeuEdgBBetbGRxiBAeQIkZouf/1jyguR+lWzpgcpvOKDd?=
 =?us-ascii?Q?019Zcy27as8KqkuoTyYX9IhlkZg2Rl74sex9efUh43AvDJU51rvxRdX4nSjh?=
 =?us-ascii?Q?OiWVGKMvaXn5Y9PB1IcFHje4GmHNaYF5tLcDHtsBKhW7t7NG2aipL9etjR00?=
 =?us-ascii?Q?IEVLMvNYUSy7urVoEJcvcFiVZVD42IuHFdvULxPph5ygSK6cuP5ItGZWXZra?=
 =?us-ascii?Q?jgOYdQGakB8HZ1YkTnExjgzsTgVL+p5XFPEB3rcGteHjoqn2xE2vv4ukg3pJ?=
 =?us-ascii?Q?PscUV2qFfJVtv9OS400U2ht2gfSZjA7uhxcojbWVEn70UFkoSdcai/gtXEUT?=
 =?us-ascii?Q?ngLJh/Wi67emGkZ+50a8SA43aT2GXXLcosijip/OnD2+J9K+fnNZGnkAGFT6?=
 =?us-ascii?Q?U1tv2Gbd2FZajV5c623LxQb2BOBn22SVSqRF/DqR2l56zuChQD/NAFMR2/BZ?=
 =?us-ascii?Q?ym0U6ZcxtVCEW5S1mdWRbZTlU0OorvMDZ0mlXM7E6Z8S+Q=3D=3D?=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:LV3PR11MB8603.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(366016)(1800799024);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?m1MdCqKOEFIS18ORDRlkgSwO0rimDKzhUiIE4W12w2NcGnbHkkSHorBB3k5l?=
 =?us-ascii?Q?pvZk+vCwq+tHFuf8jv/MIbComhE6P57fgGrBG5jzilFhQpZ/hwzG1yRa1Lxl?=
 =?us-ascii?Q?TQOWCE8SVqvwk4tZ8tuL4+vX+PwFuzxptNez+be4X+b3sRIRJzQdpWnyja2u?=
 =?us-ascii?Q?il4+ZmDKGFWEmMMXUW0GurcAjs+OCSCR+QN0BI5L1tTVvTUagVh4gJyQ2vfk?=
 =?us-ascii?Q?xSW0bS5iGJ+3v9R8uOGZwfRvTO/ItTW9rLtXoFe327/m50e+iBEb8yOIUnEZ?=
 =?us-ascii?Q?D1v5XF6FDU0jyuo6EMvr809+lRkMpJxfSzVWaq+5JlfhaXro9qsY2KnJSmTo?=
 =?us-ascii?Q?MedwIRICVWE/gM1tSPiaZIzZTKCkgaf89z+e3/UTPzAuMh1FnKrXVi0lN2fn?=
 =?us-ascii?Q?LoDQRiJ2xZN4pmfgOf4EIzobpXAws17eBjnlpY+oymLtVxlBQQEBM0JOhRPq?=
 =?us-ascii?Q?qpK4H2EGJChBPeGWfo1qLLsDmnC8Lq++EJozlq475z3VN1EXbQLxMlv9S6CQ?=
 =?us-ascii?Q?H3hMy0rpRc/y4MdI/6mBlgwogjSLuAo9CNOO3Ri2TBPioA0wRtPconzTsfzK?=
 =?us-ascii?Q?wBhD1YNYkYRNcjsro+XITSSzoE5516OE3wBMNR997YrdVLaxUA2BuD/QYGNt?=
 =?us-ascii?Q?SuIzEEUhI+RTujiRf075qbdJOpNtrcaI/ySfjz/MDbE+8GJJTa9rFm1wNhUO?=
 =?us-ascii?Q?DEgbiA5jRe57i029+sGWNUUONFHD7Uhi8r8QrBHsmR/bcs0bSM7itA5TFIyq?=
 =?us-ascii?Q?Be2JLP3FvLnQobH9TTwIr633j9TQl3zI7921dO7Lgq8E+vst2Zl7hHx0VZve?=
 =?us-ascii?Q?ZD5B62LGGZNIoJsYQJTO8uaqLTR7TdfB06SjnEADbsJ0Ay24UFGMwceuOLn4?=
 =?us-ascii?Q?4HH3WgqKnJ+fn65mz/8wM0nf4XKizY7nLBcdp1gqeC2R2xIg6vsUljn1h5RM?=
 =?us-ascii?Q?qnRM/igVydLWicQJaJhYbON3S4ImFIw9qMZDuLzm91ZzJx0bA3TxjQy9Efws?=
 =?us-ascii?Q?wFL2aTvgtmEzP4nGVqdGQ3rROhM7AFnhMfa3hFSPLNSkQLaw/qr8thPKtATJ?=
 =?us-ascii?Q?zILQZcYeCeAi0QnZRQFLr5cAu6pnU+5PXXcFKXWdhBj8HOe+npVOpKmiSmDi?=
 =?us-ascii?Q?FOZHAuUe6xPEeoNmg8EOyP3zmR2MFAZPA7vptt4hY3OtYjcCl480My/qYM1M?=
 =?us-ascii?Q?BEJbDuMb5cHydvCFCamOhNjFMgyGdU+IUJHgXeyesgL5jennLPDrpCqJD69Y?=
 =?us-ascii?Q?jM12GwgoM7fTWLrWLEtGGuFd+xys/yPICPdNg8gyaPFwIGWEBzAzadov6q2p?=
 =?us-ascii?Q?728I3KoZo62yak3KZZryp6Ad5X6UDTGPw44W33lS1JsMzSgzzDIZI0DOVR0I?=
 =?us-ascii?Q?iyR4m3/jOXF62cS+c5nbdxtTOCRxUugBzwsK4l23sjobpFWte7aClYSAFiSc?=
 =?us-ascii?Q?O/g5pWrNWdyHv6Juie/p7wYcTsTFkgM/8vgMB/s8DfooCC4C1A00qnY3IbpT?=
 =?us-ascii?Q?9k3SahoQ/KyYnHMhpJ3iHVPpZK67zNFojdKmun0vPgFYVvs9idpXsqJgTJbo?=
 =?us-ascii?Q?wjsymTzs7HXZVbVy+FPPZxkM6r0i25Hax9R5lpApD/A7PsDCEIJX8KLDOkhw?=
 =?us-ascii?Q?uQ=3D=3D?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 979f0685-819e-4bf9-edb1-08dd45ab796a
X-MS-Exchange-CrossTenant-AuthSource: LV3PR11MB8603.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 05 Feb 2025 06:08:13.6052
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: NTzcZKOFyxUBxawCBYn6E51Tl93wdXwo11/6f46b1aULBsjrMPph7LsyAtuUvuLGc+2jYLKAvGLj7rS6VutxYA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CO1PR11MB4820
X-OriginatorOrg: intel.com



Hello,

kernel test robot noticed "WARNING:suspicious_RCU_usage" on:

commit: 03abf2a7c65451e663b078b0ed1bfa648cd9380f ("net: phylink: add EEE management")
https://git.kernel.org/cgit/linux/kernel/git/torvalds/linux.git master

[test failed on linus/master      5c8c229261f14159b54b9a32f12e5fa89d88b905]
[test failed on linux-next/master 40b8e93e17bff4a4e0cc129e04f9fdf5daa5397e]

in testcase: trinity
version: trinity-i386-abe9de86-1_20230429
with following parameters:

	runtime: 300s
	group: group-02
	nr_groups: 5



config: i386-randconfig-051-20250203
compiler: gcc-12
test machine: qemu-system-i386 -enable-kvm -cpu SandyBridge -smp 2 -m 4G

(please refer to attached dmesg/kmsg for entire log/backtrace)


+---------------------------------------------------------------------------+------------+------------+
|                                                                           | a17ceec62f | 03abf2a7c6 |
+---------------------------------------------------------------------------+------------+------------+
| WARNING:suspicious_RCU_usage                                              | 0          | 36         |
| drivers/net/phy/phy_device.c:#suspicious_rcu_dereference_protected()usage | 0          | 36         |
+---------------------------------------------------------------------------+------------+------------+


If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <oliver.sang@intel.com>
| Closes: https://lore.kernel.org/oe-lkp/202502051331.7587ac82-lkp@intel.com


[   19.591040][   T22] WARNING: suspicious RCU usage
[   19.592068][   T22] 6.13.0-rc7-01139-g03abf2a7c654 #1 Tainted: G S              T
[   19.593703][   T22] -----------------------------
[   19.594724][   T22] drivers/net/phy/phy_device.c:2004 suspicious rcu_dereference_protected() usage!
[   19.596546][   T22]
[   19.596546][   T22] other info that might help us debug this:
[   19.596546][   T22]
[   19.598680][   T22]
[   19.598680][   T22] rcu_scheduler_active = 2, debug_locks = 1
[   19.600338][   T22] 4 locks held by kworker/u4:1/22:
[ 19.601463][ T22] #0: c7d1e6b0 ((wq_completion)events_unbound){+.+.}-{0:0}, at: process_one_work (kernel/workqueue.c:3211) 
[ 19.603512][ T22] #1: c512bf30 (deferred_probe_work){+.+.}-{0:0}, at: process_one_work (kernel/workqueue.c:3212) 
[ 19.605344][ T22] #2: c8d1da78 (&dev->mutex){....}-{4:4}, at: device_lock (include/linux/device.h:1015) 
[ 19.610278][ T22] #3: c3fba014 (dsa2_mutex){+.+.}-{4:4}, at: dsa_register_switch (net/dsa/dsa.c:1499 net/dsa/dsa.c:1539) 
[   19.612136][   T22]
[   19.612136][   T22] stack backtrace:
[   19.613434][   T22] CPU: 0 UID: 0 PID: 22 Comm: kworker/u4:1 Tainted: G S              T  6.13.0-rc7-01139-g03abf2a7c654 #1 0503d02651d90c323d4064ac27ee9898a6e76f3e
[   19.616145][   T22] Tainted: [S]=CPU_OUT_OF_SPEC, [T]=RANDSTRUCT
[   19.617319][   T22] Hardware name: QEMU Standard PC (i440FX + PIIX, 1996), BIOS 1.16.2-debian-1.16.2-1 04/01/2014
[   19.619218][   T22] Workqueue: events_unbound deferred_probe_work_func
[   19.620457][   T22] Call Trace:
[ 19.621167][ T22] dump_stack_lvl (lib/dump_stack.c:123) 
[ 19.622090][ T22] dump_stack (lib/dump_stack.c:130) 
[ 19.622924][ T22] lockdep_rcu_suspicious (kernel/locking/lockdep.c:6846) 
[ 19.623932][ T22] phy_detach (drivers/net/phy/phy_device.c:2004 (discriminator 9)) 
[ 19.624755][ T22] phylink_connect_phy (drivers/net/phy/phylink.c:2327) 
[ 19.625475][ T22] dsa_user_create (net/dsa/user.c:2620 net/dsa/user.c:2655 net/dsa/user.c:2790) 
[ 19.626083][ T22] dsa_port_setup (net/dsa/dsa.c:519) 
[ 19.626631][ T22] dsa_tree_setup (net/dsa/dsa.c:759 net/dsa/dsa.c:888) 
[ 19.627196][ T22] ? dsa_switch_parse_ports (net/dsa/dsa.c:1440) 
[ 19.627844][ T22] dsa_register_switch (net/dsa/dsa.c:1525 net/dsa/dsa.c:1539) 
[ 19.628455][ T22] ? dev_get_by_name (net/core/dev.c:881) 
[ 19.629080][ T22] dsa_loop_drv_probe (drivers/net/dsa/dsa_loop.c:343) 
[ 19.629973][ T22] mdio_probe (drivers/net/phy/mdio_device.c:165) 
[ 19.630762][ T22] really_probe (drivers/base/dd.c:579 drivers/base/dd.c:658) 
[ 19.631583][ T22] __driver_probe_device (drivers/base/dd.c:800) 
[ 19.632519][ T22] driver_probe_device (drivers/base/dd.c:830) 
[ 19.633287][ T22] __device_attach_driver (drivers/base/dd.c:958) 
[ 19.633903][ T22] bus_for_each_drv (drivers/base/bus.c:459) 
[ 19.634466][ T22] __device_attach (drivers/base/dd.c:1032) 
[ 19.635018][ T22] ? driver_probe_device (drivers/base/dd.c:922) 
[ 19.635627][ T22] device_initial_probe (drivers/base/dd.c:1080) 
[ 19.636222][ T22] bus_probe_device (drivers/base/bus.c:536) 
[ 19.636783][ T22] deferred_probe_work_func (drivers/base/dd.c:124) 
[ 19.637569][ T22] process_one_work (include/trace/events/workqueue.h:110 include/trace/events/workqueue.h:110 kernel/workqueue.c:3241) 
[ 19.638328][ T22] ? __list_add (include/linux/list.h:150) 
[ 19.639013][ T22] process_scheduled_works (kernel/workqueue.c:3317) 
[ 19.639878][ T22] worker_thread (include/linux/list.h:373 kernel/workqueue.c:946 kernel/workqueue.c:3399) 
[ 19.640635][ T22] kthread (kernel/kthread.c:391) 
[ 19.641303][ T22] ? rescuer_thread (kernel/workqueue.c:3344) 
[ 19.642153][ T22] ? list_del_init (include/linux/posix-timers.h:225) 
[ 19.643006][ T22] ret_from_fork (arch/x86/kernel/process.c:153) 
[ 19.643818][ T22] ? list_del_init (include/linux/posix-timers.h:225) 
[ 19.644555][ T22] ret_from_fork_asm (arch/x86/entry/entry_32.S:737) 
[ 19.645201][ T22] entry_INT80_32 (arch/x86/entry/entry_32.S:945) 
[   19.646149][   T22] dsa-loop fixed-0:1f lan1 (uninitialized): failed to connect to PHY: -EPERM
[   19.647542][   T22] dsa-loop fixed-0:1f lan1 (uninitialized): error -1 setting up PHY for tree 0, switch 0, port 0
[   19.649283][   T22] dsa-loop fixed-0:1f lan2 (uninitialized): PHY [dsa-0.0:01] driver [Generic PHY] (irq=POLL)
[   19.650853][   T22] dsa-loop fixed-0:1f lan2 (uninitialized): failed to connect to PHY: -EPERM
[   19.652238][   T22] dsa-loop fixed-0:1f lan2 (uninitialized): error -1 setting up PHY for tree 0, switch 0, port 1
[   19.653856][   T22] dsa-loop fixed-0:1f lan3 (uninitialized): PHY [dsa-0.0:02] driver [Generic PHY] (irq=POLL)
[   19.655392][   T22] dsa-loop fixed-0:1f lan3 (uninitialized): failed to connect to PHY: -EPERM
[   19.656689][   T22] dsa-loop fixed-0:1f lan3 (uninitialized): error -1 setting up PHY for tree 0, switch 0, port 2
[   19.658308][   T22] dsa-loop fixed-0:1f lan4 (uninitialized): PHY [dsa-0.0:03] driver [Generic PHY] (irq=POLL)
[   19.659841][   T22] dsa-loop fixed-0:1f lan4 (uninitialized): failed to connect to PHY: -EPERM
[   19.661168][   T22] dsa-loop fixed-0:1f lan4 (uninitialized): error -1 setting up PHY for tree 0, switch 0, port 3
[   19.663018][   T22] DSA: tree 0 setup
[   19.663591][   T22] dsa-loop fixed-0:1f: DSA mockup driver: 0x1f



The kernel config and materials to reproduce are available at:
https://download.01.org/0day-ci/archive/20250205/202502051331.7587ac82-lkp@intel.com



-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki


