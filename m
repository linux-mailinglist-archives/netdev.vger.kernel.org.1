Return-Path: <netdev+bounces-73322-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 91EB885BEC9
	for <lists+netdev@lfdr.de>; Tue, 20 Feb 2024 15:30:29 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id EC3E9B2324F
	for <lists+netdev@lfdr.de>; Tue, 20 Feb 2024 14:30:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CEF0037147;
	Tue, 20 Feb 2024 14:30:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="lzU+m4yF"
X-Original-To: netdev@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 09C731CD23
	for <netdev@vger.kernel.org>; Tue, 20 Feb 2024 14:30:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=192.198.163.7
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708439417; cv=fail; b=WCNSLzop79urj5J/b4JWrsu79kf/Yh+JFWf4B0fnmtNvdN2zNnccdKy4e+dOiEfD1dJC8iNrtxK6T/MpbHLc1wUw8ULiA6brdAFlqw6oC31D5a78U/PQ7TpAsl5gmZbVPBlJkl8Fe7l02jN824JatGg2VI//5VAgtohzlDeiACs=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708439417; c=relaxed/simple;
	bh=om0SIpsxlFDaDmefr5C5bg7YeDlHTAuRJGVcsVBYh20=;
	h=Message-ID:Date:Subject:To:CC:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=YAUZ5Mw/UUrhIijt6ZYZvO2ybMEUniwN+uowhJiUq91sP+SFsHqhbLrDMkpk3WXh11b230fKRFfb1aJck02+K/gR/JTNAvEfVfnSyw+ZvK6XfHoVk0v2jXurX9Ka5plOB+Owr6k5HcZsF7/luZPaM+2QDQBC2MrmFYrZJKNBSrU=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=lzU+m4yF; arc=fail smtp.client-ip=192.198.163.7
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1708439416; x=1739975416;
  h=message-id:date:subject:to:cc:references:from:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=om0SIpsxlFDaDmefr5C5bg7YeDlHTAuRJGVcsVBYh20=;
  b=lzU+m4yFNeyJLeD7i45GIomXznD7wwxfFpbM40X0RW375Le5uQedv1yO
   7T6C1GcW0EmvlkfbIloInxiarb4wGQ8ANGeHZHi5X5aziS9JkN3dFKiXw
   CxG+CIdXronORWCF9VWBj+71JGzcIS6IN6wSaiAT7X8nz8gKSbLs2r01k
   gBqI8gzmbkRF1Ki0uCxWmuEj7ZMayIEYLBFwgvQOTn0UgfpXGUAzBPs0E
   DY/uT4ptpsxWb/m04KRnMF/ggzZ8Ci/K0vH9WU2Rf7P4aChELA9PwqMV7
   M0p09glP4HxdvBmSbK6ivcO5uhCEqGFO6OEWO4qwoNNMq48/UNR2PtfY3
   w==;
X-IronPort-AV: E=McAfee;i="6600,9927,10989"; a="27988700"
X-IronPort-AV: E=Sophos;i="6.06,172,1705392000"; 
   d="scan'208";a="27988700"
Received: from orviesa004.jf.intel.com ([10.64.159.144])
  by fmvoesa101.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 20 Feb 2024 06:30:15 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.06,172,1705392000"; 
   d="scan'208";a="9450750"
Received: from fmsmsx601.amr.corp.intel.com ([10.18.126.81])
  by orviesa004.jf.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 20 Feb 2024 06:30:15 -0800
Received: from fmsmsx610.amr.corp.intel.com (10.18.126.90) by
 fmsmsx601.amr.corp.intel.com (10.18.126.81) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35; Tue, 20 Feb 2024 06:30:14 -0800
Received: from fmsedg602.ED.cps.intel.com (10.1.192.136) by
 fmsmsx610.amr.corp.intel.com (10.18.126.90) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35 via Frontend Transport; Tue, 20 Feb 2024 06:30:14 -0800
Received: from NAM02-SN1-obe.outbound.protection.outlook.com (104.47.57.41) by
 edgegateway.intel.com (192.55.55.71) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.35; Tue, 20 Feb 2024 06:30:14 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=hbIZY+yuQGZktWroeBLolFFydNYVtNsQRJKruiIOCkIFwk3pAM7hYTeawJIJv32GIdaMNkW0kOeyEs/kc8LwvhFjX6fomgafESZ9Gkw+UKWL7hj3CaTHZneBwlL3Qyh06wsCIsvIY6TTaG1GqOi3vLyC9NtOOKBlEcIsy46HcMghGPgJmwe65u9+4TvOJ4xtS9JJqwB6HLxQmK/IFYMz1WHRPnTBAh4dg9NdlKs6xNhqKyc+kG/aSaXgZI4jFW3Zjadt2NavLs5i0zYCSh+v6EfQg5HQ4ZGGP4bL/hAATxvR+UbNi/cBP250eRBQRF3sNYC4XBMHa2iLEKhRodeBzA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=dwySLOjhKGTuB7x7K/GSqTqhmAiNkNS30tdC3IBYD7s=;
 b=nKbjZ7O3/kxyvXClG+4hISj1G+FqhTn6Vh7+vSm1fdZX+HTtNNABYitIcPwBHJCFI0nKATmyqCa4D87lqB7JOCZhRmr/VUTzSItFfxzN3tSKcf7QH0pSZX9jmsjBDSN2VoeDsv6bgZJDYpO0ZxU94vUuLwinWT+dYPBFhtceHiDBf6R0UKpjDmZGGxPnAt+uNZpHusGvEw/7/DktqWObZ5yOSBkleCM1mSR8z5luFAB0aycNmUd9WPHxxaew+M6gvDHJPzObYNl87a5iJ2pG5/LHxUJYEi3Hu2NEK6R0vtwH15y7HJcS8j8IFTCDinhg/0U/mrwv6OzgBHFCZOmZvA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from DS0PR11MB8718.namprd11.prod.outlook.com (2603:10b6:8:1b9::20)
 by MW3PR11MB4746.namprd11.prod.outlook.com (2603:10b6:303:5f::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7292.39; Tue, 20 Feb
 2024 14:30:12 +0000
Received: from DS0PR11MB8718.namprd11.prod.outlook.com
 ([fe80::93d9:a6b2:cf4c:9dd2]) by DS0PR11MB8718.namprd11.prod.outlook.com
 ([fe80::93d9:a6b2:cf4c:9dd2%5]) with mapi id 15.20.7292.036; Tue, 20 Feb 2024
 14:30:12 +0000
Message-ID: <22caac00-7a4e-4bc3-969e-fa3655fd9a93@intel.com>
Date: Tue, 20 Feb 2024 15:30:07 +0100
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v4 01/10 iwl-next] idpf: implement virtchnl transaction
 manager
Content-Language: en-US
To: Alan Brady <alan.brady@intel.com>
CC: <intel-wired-lan@lists.osuosl.org>, <netdev@vger.kernel.org>,
	<willemdebruijn.kernel@gmail.com>, <przemyslaw.kitszel@intel.com>,
	<igor.bagnucki@intel.com>, Joshua Hay <joshua.a.hay@intel.com>
References: <20240206033804.1198416-1-alan.brady@intel.com>
 <20240206033804.1198416-2-alan.brady@intel.com>
From: Alexander Lobakin <aleksander.lobakin@intel.com>
In-Reply-To: <20240206033804.1198416-2-alan.brady@intel.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: DB9PR02CA0007.eurprd02.prod.outlook.com
 (2603:10a6:10:1d9::12) To DS0PR11MB8718.namprd11.prod.outlook.com
 (2603:10b6:8:1b9::20)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS0PR11MB8718:EE_|MW3PR11MB4746:EE_
X-MS-Office365-Filtering-Correlation-Id: 64fe720c-53e5-43c9-96ea-08dc32207261
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 4gygkDpzB1XsEBDznKHWNH1RmZ7nlODMVAaMFeSUWO6+JnIA9qbDzuPvwBIGdwq0jsId47PiJSRDZjYFz1nuGaJ9DMUsZf8/PkFsCtEcrkudeZradBEb2U1pO/EGYYcrV0OkP+/AtCSvabYWpez4tnH6mrtswpjT/gWhKzDcveBJ6X67G1OdpQlwub3OCG2pmPnWJsx3q5UhLTixOI9ywYO/1QofCMRU7uK1FPQN+WzwQ1URLI3VKPT116c71wLdOjdcHGlEHx24Ld4n9GqOqbxdRHejW9wQVyIBgRNC3SMWf4FNO0H9IzdhIZyp743WSx6BxcvFSEnhMRBY62VBjNMCUHjRMQwH/yNQbo9MHXLbs1c1bl8Ntm0tQQFL4VrEVzTGd77PPQuNQDeBnKwLgsRh/i/LhqZZH5WIOYsJK8lx/TmVJ4Kh5kEE9z3wI1ul36EOJKI5SGWN1SkRvlWq+ZfHMFQPvQnHnWZF4UM5Y4sHOV0T/hmMvIhRzBThDpp6c54f/lO5pqhJxLQf5Excv48lb58XiSC3VctuLzEUAY0=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DS0PR11MB8718.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?S2lnclllUDR0YVBuZC9YVnY4d2NtZVA4Y2o5cXExbS8yMjBvZEZNQmxOSHdU?=
 =?utf-8?B?cS92SmVxV3pzVXRjWXRFZ1ZmZnNNY3hCNTFCbEdtdGJKK1cxSTlsWDJrelFm?=
 =?utf-8?B?U0lWR2wzc2pQK2w0bVA1Y25LcnVUQytINmEvY3Bodm5iUTZXK2loU1ExT1NX?=
 =?utf-8?B?SnNFallBVDNuZm9XOWh6VVJ6eXNTd1d5T3pCY3JaWFhxQjJkTlNrVUFhVUsy?=
 =?utf-8?B?Vjh6WllFNDA3ZVNueGoxQVVzdHRnUitxYjF3dHY2b0R4NEFYdGR6ekdSMTZh?=
 =?utf-8?B?KzNoMGs5VGtmZng3TUZON0FTYU1PSkdsVXVPZ1JlMVh1MDRSaWYySGNjeHhO?=
 =?utf-8?B?UmJVRGxLakxLMUoxVFdKWk42cFFXOFc2NTlIUXAybzZYOEJzYncvOWxyS1NT?=
 =?utf-8?B?WUI3WFhtc09heFY4MGI0QTJ3NUtaY0d1bXl3amxGN2NKMHBrQytzT3dqWXBs?=
 =?utf-8?B?S3RUdEQ1NElqS2dHWlVIWFNBV09KQWNJTnkxTW15L1FQTlhYWEQwQitpdHFj?=
 =?utf-8?B?VnprSnhUQldhMnlCTXd1T1p0ekFJN0FSZmoydktjVEVGMkdYekVIa2VHVVZE?=
 =?utf-8?B?WjdkMi9MWlNlVTBqR2ZSWVk2RmFaWVIxdFl3alZQK1Zhc3hGNWlNenRrODBZ?=
 =?utf-8?B?L2dGNVNtbm5EdDlIVWo4YVVLaFg3My9YYXBCbEJ4ZW1kY0M5WGZhYmR3K2Fm?=
 =?utf-8?B?N3ZEN2FKYmtQSXh6ZHh5bjN6TEt5VDgwVFdKdkVRcWpHZXRxVG9VaTlxOGFI?=
 =?utf-8?B?Wm9rQjIxMHZ1YnExS2V3NzlFTkxWU210eEtMVTVZdGErSmg1aTlPTlllYWVm?=
 =?utf-8?B?SGJHaU9uazNwdjVWY0NRTmgxRWNlOTcxOTh3NG00RDNyQmFmVEtCRFIzemRR?=
 =?utf-8?B?dnJodUVjUkhJenF6WHVXVnhUdlI3bUxUYlVZdjJaUFpsMkdiY1h1dXQrTnJj?=
 =?utf-8?B?NEFuNjhXUy9YVmJteGMxM2VxU0dtRTdlajFGZHRId3VpV1FmNmFlYmkxc3F2?=
 =?utf-8?B?UWtaajN1cng5ekJnMnhySVhMUVF6dWs1N0V6ZlNSUThBOC9RWWFpbVpMWUtF?=
 =?utf-8?B?VURCZWhoYVhxc3p1bk5iczMxaFVVNW5VRTRrOXVUeGxHYWwvRG9DYy80OVh3?=
 =?utf-8?B?T28yYXdUOG1VSVdOdTBVSEVOTzlJMi9NTE5EK3NpMW91MlZoalhhNG90U2gy?=
 =?utf-8?B?a1JKQVg1djEwSnlDNThzcDErbCtWSnlwLzFqRW5CU2VMYjBxTW1zbXJVd0xS?=
 =?utf-8?B?bnRtK0F6QkpheVRxWjJjaitaQTMxK1NoU1l4djlkTUM2V2NRVG9mUU4wbGJ4?=
 =?utf-8?B?ZjNpNlRWc1dZMndMT3p6OWZQQ05vSVhuYzEvUDBWbU1RZW4wL2tuZitSN3lB?=
 =?utf-8?B?anZ5S1FUMGZmWUpGYWxBalhWQnFheWJXenBOQzJoTFVTdWlITkhpb1dsMGdV?=
 =?utf-8?B?cjZSMG9pTk8vaDJRTEhrVFhtL3dSWFZDdjduSzhaQlR2WnRaaU1RV1BUcGpq?=
 =?utf-8?B?Z1JadWsvbGlENVFjcHArc09TR2VIN20xaDRkMEFMMTRWZkdObUdXY28rOGdI?=
 =?utf-8?B?aDJvdTU2M1BPRmxPT0VOWkZmQmJxcktDU2ZWeVVsWWpzeVRyWkpkK0dvY29J?=
 =?utf-8?B?Ukg0eDJwUkJRaG5QSEV5aHkwdVo3MmQxdnpmSFMrS2RZakpMcG4vRHJRMjNq?=
 =?utf-8?B?dTBGcHFiaGV0VE5odWtxbWE3bXF5cEJFUFFVTzRWc0ZCZnNNQlVtMWNkZ2hN?=
 =?utf-8?B?bVg1UXpRbFMvRWhpY1U2QTcvaXhQazMxVCsydkZtZzBPUkFXMDFmWW44TG96?=
 =?utf-8?B?MU5QMnZhS0c5NnNmd0VGcGEva1h4QjdnU2dWanNqbVlNN0lkSWYyaThlQ0hR?=
 =?utf-8?B?b2RsU2VkUE45d0NabTBsY0RzNUdoTUc1cUY4eGhCcXljTms5a2c0bFRHKzgw?=
 =?utf-8?B?SUVvREVnK2JmTnVoSzF1bzJhQm1qOUp1cTZ0MkhXNVc2aVpqV3RubjlxdHND?=
 =?utf-8?B?ZFJNaEppLzd2UmdWNlVJZGZzUHFQTUg4YTJwWFREdW84UnZVenc2aWh6Y3d6?=
 =?utf-8?B?UllNM2dzYkppTGJzNW1wWm92S0dpRWgxWmxnZVR5QnVWUDJISHhxdU81cVdV?=
 =?utf-8?B?b2ttWUR6aUtkZVZtSURXcm9HdVA1dVArU2tPSUZucmJ6RjIzSmRIUkVaWXZn?=
 =?utf-8?B?cXc9PQ==?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 64fe720c-53e5-43c9-96ea-08dc32207261
X-MS-Exchange-CrossTenant-AuthSource: DS0PR11MB8718.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 20 Feb 2024 14:30:12.2897
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: NZGFC94Qr3OFUu0PNKBZ/X/aXHcEdnLwHFMCe1JS2lTEFKtDvh/Y7zXCf3suuSoVwvudAkBRESlo3ik4BKlyvDD/nCEwxnFVuBvJQvc2DZ8=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW3PR11MB4746
X-OriginatorOrg: intel.com

From: Alan Brady <alan.brady@intel.com>
Date: Mon, 5 Feb 2024 19:37:55 -0800

> This starts refactoring how virtchnl messages are handled by adding a
> transaction manager (idpf_vc_xn_manager).

[...]

> +/**
> + * idpf_vc_xn_exec - Perform a send/recv virtchnl transaction
> + * @adapter: driver specific private structure with vcxn_mngr
> + * @params: parameters for this particular transaction including
> + *   -vc_op: virtchannel operation to send
> + *   -send_buf: kvec iov for send buf and len
> + *   -recv_buf: kvec iov for recv buf and len (ignored if NULL)
> + *   -timeout_ms: timeout waiting for a reply (milliseconds)
> + *   -async: don't wait for message reply, will lose caller context
> + *   -async_handler: callback to handle async replies
> + *
> + * @returns >= 0 for success, the size of the initial reply (may or may not be
> + * >= @recv_buf.iov_len, but we never overflow @@recv_buf_iov_base). < 0 for
> + * error.
> + */
> +static ssize_t idpf_vc_xn_exec(struct idpf_adapter *adapter,
> +			       struct idpf_vc_xn_params params)

Why do you pass @params by value, i.e. whole 56 bytes per each function
call instead of passing it by pointer -> 8 bytes per call?

> +{
> +	struct kvec *send_buf = &params.send_buf;
> +	struct idpf_vc_xn *xn;
> +	ssize_t retval;
> +	u16 cookie;
> +
> +	xn = idpf_vc_xn_pop_free(&adapter->vcxn_mngr);
> +	/* no free transactions available */
> +	if (!xn)
> +		return -ENOSPC;
> +
> +	idpf_vc_xn_lock(xn);
> +	if (xn->state == IDPF_VC_XN_SHUTDOWN) {
> +		retval = -ENXIO;
> +		goto only_unlock;
> +	} else if (xn->state != IDPF_VC_XN_IDLE) {
> +		/* We're just going to clobber this transaction even though
> +		 * it's not IDLE. If we don't reuse it we could theoretically
> +		 * eventually leak all the free transactions and not be able to
> +		 * send any messages. At least this way we make an attempt to
> +		 * remain functional even though something really bad is
> +		 * happening that's corrupting what was supposed to be free
> +		 * transactions.
> +		 */
> +		WARN_ONCE(1, "There should only be idle transactions in free list (idx %d op %d)\n",
> +			  xn->idx, xn->vc_op);
> +	}
> +
> +	xn->reply = params.recv_buf;
> +	xn->reply_sz = 0;
> +	xn->state = params.async ? IDPF_VC_XN_ASYNC : IDPF_VC_XN_WAITING;
> +	xn->vc_op = params.vc_op;
> +	xn->async_handler = params.async_handler;
> +	idpf_vc_xn_unlock(xn);
> +
> +	if (!params.async)
> +		reinit_completion(&xn->completed);
> +	cookie = FIELD_PREP(IDPF_VC_XN_SALT_M, xn->salt) |
> +		 FIELD_PREP(IDPF_VC_XN_IDX_M, xn->idx);
> +
> +	retval = idpf_send_mb_msg(adapter, params.vc_op,
> +				  send_buf->iov_len, send_buf->iov_base,
> +				  cookie);
> +	if (retval) {
> +		idpf_vc_xn_lock(xn);
> +		goto release_and_unlock;
> +	}
> +
> +	if (params.async)
> +		return 0;
> +
> +	wait_for_completion_timeout(&xn->completed,
> +				    msecs_to_jiffies(params.timeout_ms));
> +
> +	/* No need to check the return value; we check the final state of the
> +	 * transaction below. It's possible the transaction actually gets more
> +	 * timeout than specified if we get preempted here but after
> +	 * wait_for_completion_timeout returns. This should be non-issue
> +	 * however.
> +	 */
> +	idpf_vc_xn_lock(xn);
> +	switch (xn->state) {
> +	case IDPF_VC_XN_SHUTDOWN:
> +		retval = -ENXIO;
> +		goto only_unlock;
> +	case IDPF_VC_XN_WAITING:
> +		dev_notice_ratelimited(&adapter->pdev->dev, "Transaction timed-out (op %d, %dms)\n",
> +				       params.vc_op, params.timeout_ms);
> +		retval = -ETIME;
> +		break;
> +	case IDPF_VC_XN_COMPLETED_SUCCESS:
> +		retval = xn->reply_sz;
> +		break;
> +	case IDPF_VC_XN_COMPLETED_FAILED:
> +		dev_notice_ratelimited(&adapter->pdev->dev, "Transaction failed (op %d)\n",
> +				       params.vc_op);
> +		retval = -EIO;
> +		break;
> +	default:
> +		/* Invalid state. */
> +		WARN_ON_ONCE(1);
> +		retval = -EIO;
> +		break;
> +	}
> +
> +release_and_unlock:
> +	idpf_vc_xn_push_free(&adapter->vcxn_mngr, xn);
> +	/* If we receive a VC reply after here, it will be dropped. */
> +only_unlock:
> +	idpf_vc_xn_unlock(xn);
> +
> +	return retval;
> +}

[...]

Thanks,
Olek

