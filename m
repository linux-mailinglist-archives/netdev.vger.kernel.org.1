Return-Path: <netdev+bounces-229766-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id A8FA8BE09CB
	for <lists+netdev@lfdr.de>; Wed, 15 Oct 2025 22:18:55 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 6FD90424B56
	for <lists+netdev@lfdr.de>; Wed, 15 Oct 2025 20:18:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 626B72D640F;
	Wed, 15 Oct 2025 20:18:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="eu6KHCa4"
X-Original-To: netdev@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.13])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CC5502C3261
	for <netdev@vger.kernel.org>; Wed, 15 Oct 2025 20:18:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=198.175.65.13
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760559517; cv=fail; b=YB/5SoilRJ3o98qtR+74etNHgVBkZaTDyaOSrtC2TmlYoIzJMCdYP+ZxfiabvWYBb5HVQPIvyGSsPFVs66RuZFZqcOIinQboB01xBbjU4iSNHJ7FFX/YMFvD+NwuoJll1BvTJ0qyjX93i19MhZ1P9XnnqpdlwqoVVjtSoOmVACM=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760559517; c=relaxed/simple;
	bh=9w00sv8Up44bFSVSvJBT6x1pxCc4talzUfF9eJx6srA=;
	h=Message-ID:Date:Subject:To:CC:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=Isyy1kxtDSUou6GerfIr/6A7ByZ5500yvqqJtbCFLn10A9/8Y6v3qZKFhHE1oNug4NbSC7e2j6t0wClu7b/ew9ItKJ+y4iFjZS4CJUzDlU/yQsr6tBDrCkIwVzgmK7jPJt+znwST/mjQALZSabla5TFIcykT+Jnca+g0Vb1wRVQ=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=eu6KHCa4; arc=fail smtp.client-ip=198.175.65.13
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1760559516; x=1792095516;
  h=message-id:date:subject:to:cc:references:from:
   in-reply-to:mime-version;
  bh=9w00sv8Up44bFSVSvJBT6x1pxCc4talzUfF9eJx6srA=;
  b=eu6KHCa4MKq7OW/DyaTIDy6uD3cSdzHtPGZNcMerMOCs+y3a3wgZP3dH
   QSweg9JvaILu5Xbl/lCB8ImY1H+DvvWyL99ig/yRLaaVUcol/bLPYVx+n
   szxvPAik/+juBjN36+qzwekjFmTW/tc0IuKDAG2AdcKIcY6HfVMGupMv3
   GGQ3IkFZQ8iHtzP+1YOXHTwWkMllZNEeAjje4x4gCWf5N4/MUCWYmNS2B
   klj5XG84DqLYkLAyDBzqI03yuHF4rwyVI7sYh3eN0rUmdSj0sUgQXtsjM
   LrIl/hcd1N2cpZoqfv/HBWG6W0eBqkKJG2mGgCI55WjxFhOvT6hrRTk07
   Q==;
X-CSE-ConnectionGUID: ez3yrSovSlqrCubiPUbvpA==
X-CSE-MsgGUID: R0PQPTjYTGeD9k+dQh418A==
X-IronPort-AV: E=McAfee;i="6800,10657,11583"; a="73857477"
X-IronPort-AV: E=Sophos;i="6.19,232,1754982000"; 
   d="asc'?scan'208";a="73857477"
Received: from orviesa002.jf.intel.com ([10.64.159.142])
  by orvoesa105.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 15 Oct 2025 13:18:35 -0700
X-CSE-ConnectionGUID: JbjhMXPOQSSbi8rA1fQ+7A==
X-CSE-MsgGUID: FNtuyvEBToCmLp3rljPpkQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.19,232,1754982000"; 
   d="asc'?scan'208";a="212876589"
Received: from fmsmsx901.amr.corp.intel.com ([10.18.126.90])
  by orviesa002.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 15 Oct 2025 13:18:35 -0700
Received: from FMSMSX903.amr.corp.intel.com (10.18.126.92) by
 fmsmsx901.amr.corp.intel.com (10.18.126.90) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.27; Wed, 15 Oct 2025 13:18:34 -0700
Received: from fmsedg901.ED.cps.intel.com (10.1.192.143) by
 FMSMSX903.amr.corp.intel.com (10.18.126.92) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.27 via Frontend Transport; Wed, 15 Oct 2025 13:18:34 -0700
Received: from SN4PR0501CU005.outbound.protection.outlook.com (40.93.194.58)
 by edgegateway.intel.com (192.55.55.81) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.27; Wed, 15 Oct 2025 13:18:33 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=exVRISoiYwYIifW03cgDARzqaOxMyZW36gX0nQiLmKEbfbt869HQBET0UgV4ZTPag1K996pOemXcENG/J/P4JgMTTjPo1f+I2KuCd/4cx7jJAZr6COtuRFT4H5z5SjXrIUKFjETPZ15RxMjI8QJkBXYpxsZnxwoqlgWAY6HQnAbr4DtFvTUs29yuC9Cy3KS0CoeIJsQwG7ljLIIH1BdF0qSE3O+Xjfm0dFD41h5MDzG2gV3boSjoYVkn+HqywcwJMeBHcIuC5rLY2+A2+cKsimkloP5nfsfw5+MAXTajoRAmFKinnGu3XoQx8es7il+yg2yZS3gmlkNKhYevKIA7eg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=9w00sv8Up44bFSVSvJBT6x1pxCc4talzUfF9eJx6srA=;
 b=hTpjSmpqJJ9hwLvIgiqLq0g2LlwTCePA5Mj02AXTisZaTiMms6fBxRUBHes2XQ07rkYD5l53AgXjc9nRu41qmibKOmp7uEux/ADDw2BBv3e69BqQRrGYlr7Tf+0jCEIOwCjOVGvjYJ4UU22uxKCJ6l+Zjl1WpRuyFxe+XaUaKjpAhj9fUpnwH9tslN7B78dVBLuBuP+CIJnOCIS696I+bcwivlwiJmAO5sS7ZfX7SVEOdR9/249a8Mru+/Uu3laNyaiAvvirzTHWWTUXsAHqBlHaqUH/AUo7W1A9l5e0wmvj9yzeR/Tfl1sHO/PfCL7UUfyfdIrCIR0YO+3lfTNtjg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from CO1PR11MB5089.namprd11.prod.outlook.com (2603:10b6:303:9b::16)
 by SA1PR11MB6663.namprd11.prod.outlook.com (2603:10b6:806:257::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9228.10; Wed, 15 Oct
 2025 20:18:29 +0000
Received: from CO1PR11MB5089.namprd11.prod.outlook.com
 ([fe80::81f7:c6c0:ca43:11c3]) by CO1PR11MB5089.namprd11.prod.outlook.com
 ([fe80::81f7:c6c0:ca43:11c3%4]) with mapi id 15.20.9228.010; Wed, 15 Oct 2025
 20:18:29 +0000
Message-ID: <e7afcd75-7e12-4438-8ff0-26b06b209526@intel.com>
Date: Wed, 15 Oct 2025 13:18:28 -0700
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net-next v2 5/7] cxgb4: convert to ndo_hwtstamp API
To: Vadim Fedorenko <vadim.fedorenko@linux.dev>, Simon Horman
	<horms@kernel.org>
CC: Shyam Sundar S K <Shyam-sundar.S-k@amd.com>, Andrew Lunn
	<andrew+netdev@lunn.ch>, "David S. Miller" <davem@davemloft.net>, "Eric
 Dumazet" <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>, Paolo Abeni
	<pabeni@redhat.com>, Egor Pomozov <epomozov@marvell.com>, Potnuri Bharat Teja
	<bharat@chelsio.com>, Dimitris Michailidis <dmichail@fungible.com>, "MD
 Danish Anwar" <danishanwar@ti.com>, Roger Quadros <rogerq@kernel.org>,
	"Richard Cochran" <richardcochran@gmail.com>, Russell King
	<linux@armlinux.org.uk>, Vladimir Oltean <vladimir.oltean@nxp.com>,
	<netdev@vger.kernel.org>
References: <20251014224216.8163-1-vadim.fedorenko@linux.dev>
 <20251014224216.8163-6-vadim.fedorenko@linux.dev>
 <aO9x7EpgTMiBBfER@horms.kernel.org>
 <193627cf-a8c7-4428-a5d3-8813b1edc04d@linux.dev>
Content-Language: en-US
From: Jacob Keller <jacob.e.keller@intel.com>
Autocrypt: addr=jacob.e.keller@intel.com; keydata=
 xjMEaFx9ShYJKwYBBAHaRw8BAQdAE+TQsi9s60VNWijGeBIKU6hsXLwMt/JY9ni1wnsVd7nN
 J0phY29iIEtlbGxlciA8amFjb2IuZS5rZWxsZXJAaW50ZWwuY29tPsKTBBMWCgA7FiEEIEBU
 qdczkFYq7EMeapZdPm8PKOgFAmhcfUoCGwMFCwkIBwICIgIGFQoJCAsCBBYCAwECHgcCF4AA
 CgkQapZdPm8PKOiZAAEA4UV0uM2PhFAw+tlK81gP+fgRqBVYlhmMyroXadv0lH4BAIf4jLxI
 UPEL4+zzp4ekaw8IyFz+mRMUBaS2l+cpoBUBzjgEaFx9ShIKKwYBBAGXVQEFAQEHQF386lYe
 MPZBiQHGXwjbBWS5OMBems5rgajcBMKc4W4aAwEIB8J4BBgWCgAgFiEEIEBUqdczkFYq7EMe
 apZdPm8PKOgFAmhcfUoCGwwACgkQapZdPm8PKOjbUQD+MsPBANqBUiNt+7w0dC73R6UcQzbg
 cFx4Yvms6cJjeD4BAKf193xbq7W3T7r9BdfTw6HRFYDiHXgkyoc/2Q4/T+8H
In-Reply-To: <193627cf-a8c7-4428-a5d3-8813b1edc04d@linux.dev>
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature";
	boundary="------------kIEPuZ1cABiAVg0zC0Zx6t0k"
X-ClientProxiedBy: MW4PR04CA0055.namprd04.prod.outlook.com
 (2603:10b6:303:6a::30) To CO1PR11MB5089.namprd11.prod.outlook.com
 (2603:10b6:303:9b::16)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CO1PR11MB5089:EE_|SA1PR11MB6663:EE_
X-MS-Office365-Filtering-Correlation-Id: d71c6357-810e-4fe2-65da-08de0c280150
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|366016|376014|7416014|7053199007;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?NExCS0ROUWZlWHR6bmt5M04wRUxYV2FuVEJwd2ZkZXdEcUdRTmszSVRmQWdu?=
 =?utf-8?B?M3VSUE1ncE03QTFvblZ2a1VCenlYTXg5NEhxQ25aSDlnUElubkEwRkNsMjZl?=
 =?utf-8?B?a2dicUNOZlZiWnFzNEJsV2Z0Z2hFTzZwamx1UEVkS1FaTFNFajBNcUFndGRX?=
 =?utf-8?B?NEpicUsxeG1PZ3d0TzNuU0RYQmdhRjJiTC9weitLZnI0eVo3Z3FQd1VTd1JU?=
 =?utf-8?B?MExCWVY5dVlQWU5WaUJ2RUJuSU9BQS9DNXNDQTRZY2xQUGNDNktDMzVxcTBw?=
 =?utf-8?B?Z0xaT29aS3lKRGI3WFV2Si9WTi8ya09YeTY5U2pmN2VZYjZjY2hVbmYyNjZH?=
 =?utf-8?B?ZVAxWSs2eUxWTFN5TDc0V3RZK0FFaUoweWlHUHZzZ3BKL2tlYzBjbkkxWlQr?=
 =?utf-8?B?N3ptUVRIQlg0dHRRUFl2c3VjdDhjRGd6bHZ5MWJVUEhuRGowUVNzU1NwdXBT?=
 =?utf-8?B?VUwrc3g3Sk5sM1h3UkRSRFlXWjJlQ1Z1KzBEV1REVG9YSjRMYmlLMzFiaWFS?=
 =?utf-8?B?WnM3NXh5aDYvanZqOFI4RFlwYWdJZ1FXcXNaU1UxRDFzSS9vVFV0bWF5YmFO?=
 =?utf-8?B?bkN4UHZXWHVObUpjbXhybWNudFVHZVlvRFljQ0d6VDdGTHFwZjhBcURjKyts?=
 =?utf-8?B?UVpoSE1xRWlmWTVIRk5KY1Z5VTdTTHVta0RLNDF0U2daYmU4S0k1bTdjcnFC?=
 =?utf-8?B?T0NNd0FBNWJqQ0N6NkpIU0wwQllxbVFuS2VTSkNVdW1jc1JMSFdGZFh3a21w?=
 =?utf-8?B?MWJMWDN4S3pEbnRyOXBZRndwdmx0UDc4cFdVTmtzcllIdEZMSjBmYlRjQjlr?=
 =?utf-8?B?eit1eUpmV3Zwdndmd011a0pYL295cWZxWUFUT1FIQlVuTGx0RWhJVUI3OWtL?=
 =?utf-8?B?MzI5Y0tzZGxxV2xodHFzSG94Slc2WUZMZXlzUGRVT21Ebm5tTzMyS2Z2dEZl?=
 =?utf-8?B?VzBQdlRQOFg2QlJrMVRrUjRPMStPSS9hbmx1dERsamI1RG1sY2FUWEtvZmVB?=
 =?utf-8?B?S1BJQ1ZtbVdZajI5bC93WGdrOThKUVR2bllGQWVCVHVGenlqTnV4dm93YitK?=
 =?utf-8?B?OGxNMEFHUVhnQWVObWY5dmlsZzdpOGdHbWFXNVRTR0NyU0NMLy94cmpFWDEv?=
 =?utf-8?B?cmkwZTNwT3ArL3ZDV2s0ZjhxRitYbGhGT21KSGxBY1IvRENwV2h5SWR0SG5a?=
 =?utf-8?B?aXFFVmpRdGtLWGNhRVhMYzBlZ2RYN01ad0luZVlSSURtSmZwNVMyeWZ6TG84?=
 =?utf-8?B?MC9rYjdkbm5CR0dyTzJrS0UxWkJoVnJEajg2eTRuek01S25COUg4eHZPc3VJ?=
 =?utf-8?B?N0lVV1lnZjBYbU50aDVvZFdRZGtqaE5XMWRFKzJWckswdHA3Ym1PQUErL1I1?=
 =?utf-8?B?QTFCM1JuUU1kZzgrWnc5N05DQjE3MWMvMytFNkx2NWJ3Y0YwVEVad3U3MjlT?=
 =?utf-8?B?SjFDWGtQWDN2TDhGcDlVTmM2QzVnUVllTUpIdi9seENiNmZBMllCa1hlUitP?=
 =?utf-8?B?WVN0UXc4U3NHcEVyNHJoT1hBYWQ5L0ZGUFV3WnVhcndFaEVYMHVQNVVKaWNF?=
 =?utf-8?B?NlpkNWk2OEYwUHRpQWFxTDVwdnU0L2hTb2poTWFvOEwwdlBOd1lyUDVYN0VL?=
 =?utf-8?B?aEpNOFF4MnhzNGdlUjlzZGhUR2V4eXNmcDlLdTFCeG50aEY2YkRDVldmRTlL?=
 =?utf-8?B?ZmNnU1Q0RzgrN09lMHhuV1pOalo0YW9MU2JKNlVEejBScGF2OVd6VTNoVzdi?=
 =?utf-8?B?R3N3eWdNZUo5aGV1cUJwS213YjBTTE51eE9IdmNrVlloWnE4alJlSE9HTlFS?=
 =?utf-8?B?enBJSFZuWkpxL25oMGV4TFhreDEwSEJUMlRXaEtSR3FBQ280b255REMxcEVw?=
 =?utf-8?B?Q2hXV2hDcHJ3cWMzNHZZcGk0RUxqaW5FU0JTZ2QrUllGdGtyRmQ3Y3U0UjZw?=
 =?utf-8?Q?MUJDShRfaPap7Ycm6yUBxGuEkNEGMBk9?=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CO1PR11MB5089.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(376014)(7416014)(7053199007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?YVVKWDl6V05VdkRnd29TZjhPVjV0NmhWbTVwVkxWTmNseTZBZUZNWk9tbzE1?=
 =?utf-8?B?R2U0R0I1YW14OEE4bUYyY2dZWGRaOVhKTVM4NFVZZGlLZUwremZ0UmFISm9G?=
 =?utf-8?B?ekF0eXd4TGtvQm1hdWljbXUxd2tjb2dKRTRFOGV3aTBpZTVyY1ZCbVAxMmRX?=
 =?utf-8?B?cHhaMjdSTnAvMll2QTZEdzBVWW8zTGp1dEV2T1BQNFcyVkNRQS9RY1dwU09D?=
 =?utf-8?B?RTdJOVB4eEMxN0xiUHVubFpUbHpwN216UG5sQXNINVNDUzNVczZQeTYxSjhX?=
 =?utf-8?B?SmdYK3hPcGpkS2JmQXR3V240ZTlVOGgwVU5hM2tyZGlXc2hsRlBPMzZyWm5C?=
 =?utf-8?B?QXhqZlZzai95eHpiNU9zS1lmNkI2OU5hREJYV3p5YlFJTy9mQ2YydXRiZGtW?=
 =?utf-8?B?eU5JOU5qRHNYSHE0dnpDNnVFdXhQblQ5RUNBZ09RREdMR2ZKWDhESGt0T1Zy?=
 =?utf-8?B?dnpqWWZRSit2bmYwc1VyTWo4QWNoMHBjeSthUU5UKzQrVzZjL3ZlaXNGcHJ0?=
 =?utf-8?B?aEVZVzNGWHFhODZPNVNkVmpDNlFtOUFUUzVNRE45aEVpVHdDblUzbjIzUTJh?=
 =?utf-8?B?OEs3dFZLRjJkYjdRa1NwZGlJZmY3OVFYcmdMOHYvZS9DNExJczNyRVJGTC8w?=
 =?utf-8?B?ekxvb0hKZ0dsQ3VqU0dDN2gvTm50NWN1dStWUXpBbzFJU2hSbDZWOWltZTds?=
 =?utf-8?B?QkF1L3RTSkMzZUFIWThxcFo2djdORHFWT01naTFQS1hWaFlrWVZuQnZhUWpW?=
 =?utf-8?B?OHIza052UnZ1STh4RkFpUndJV0lNVnIwYmlVckNLaktIUVJKWlNYMUtJSUxz?=
 =?utf-8?B?TnRBNU1QMmZDVTRBejd6UFNzM1BkWjR3VUs2MWU4UG8wRlJQVThZeHE5dG4w?=
 =?utf-8?B?RmI1emFBL1VxRmp2ZWR0SG9uNHVOUTBEOTJhd1BYSHVteUlsKzhoU25OSndq?=
 =?utf-8?B?NHVXdENUNDd4dzlpU2hNZ0N6eDdmRTZrZHNRN2dRSkdvelFZNWl4ZFZVSkto?=
 =?utf-8?B?c0hmNXByMFpvZ1VoeHllbDE2YWIvWldQenFkejlnbUZQb0JwSzErcVVNRUNy?=
 =?utf-8?B?dkZrYzBXY00xTFZQNThFL3R2RmViOWFyL1RlU0hIMG5SY0d5bHJaYUlMbEpQ?=
 =?utf-8?B?SlgxT3ZSWlRMK0xDVHRCeDlJM3lYRHJVelZnaU5jM203YXVQbFhWVitJTUpX?=
 =?utf-8?B?ZnJHVGVFVUkyNHpiYk1Rdk5Rc0h4Wm9jN1E2SjRGOENST0pHQ0U4K1FMUkp0?=
 =?utf-8?B?SHB5UnNYT0xSQmVKVzl0cDJJa2pub0dOZlZ4Z1o0NnV6OTN4T1ZhZGVYeFNm?=
 =?utf-8?B?bmdVOW1qeVhJdkhkYytnZFRPRlpXZVFKRXMxdm9nVFVpNDdDRzJhMldQOWVq?=
 =?utf-8?B?SVVDcmRBam13eUdrYmkvK29xdmFUMGNpVENXNGxvNG11UEFGamFhdENVdXFW?=
 =?utf-8?B?Rk5TVVNXZVpHOHVaVGZOVlZTSTE3bUhhZVF0NWZlU2x1YkoyeXJPTWw5MTl6?=
 =?utf-8?B?clRJUUR2cEMvYy9kZDlwZVRwVTVSanY1bjh2NU9iZ2VJV05Oc1N2RGdocFg1?=
 =?utf-8?B?bnBRbkdUSURkMHgvM0Fpb1lwZXJIajk2RDVDZjYxa051ZGp3RG83ZWpxbXBZ?=
 =?utf-8?B?aXhnbXdJbTZDWDYvNGIrdUJGbW9RMlRDVEgyU3c2SGswbTVGTUVqQThCOUVQ?=
 =?utf-8?B?STZWZmFRN2sxUjhmWitTNGxlR1c4dk9samRIdFk0dXBaNzZTTWRqTmxjNjN6?=
 =?utf-8?B?NlhmaEZIN1VLeWt6WjluTWdCUDl5VlBESGR1dld2V0orL1NBT1lNcFRvNm1q?=
 =?utf-8?B?RnVIK3cxSG5ZRCtOd3BiMWd4UnFXc3EvYlFDZFliOEY2WEFkbTVsckt4Rmxr?=
 =?utf-8?B?MnZkZHNxa1Q3V0J4OEJEblFkUTZ2TTN3Zk1RYThEV0UxdG12THBzYnRaTnZI?=
 =?utf-8?B?KzRWK3FEZkhDWWhLTG8vRWxxMjI5YlNtNkJJLzc3eXpjQ3RZOVBSSnpoUjI2?=
 =?utf-8?B?ZXY3TGwvVDI2czZpcU9FaFQ3MG54dlkraTUwaWdjMm4xa3dyS25sR20vOUg3?=
 =?utf-8?B?TmJxUjZhdmZ5YjR6VUJYS1BwUHJ1ell3MDRxek1aNEhmUTR6RXFPRWlkTDhY?=
 =?utf-8?B?RFluKytXUzFYNkllNStSeXhJVXAwVEgrQzd1dXFHTFFEUXA5RDZzT085N1Vk?=
 =?utf-8?B?UGc9PQ==?=
X-MS-Exchange-CrossTenant-Network-Message-Id: d71c6357-810e-4fe2-65da-08de0c280150
X-MS-Exchange-CrossTenant-AuthSource: CO1PR11MB5089.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 15 Oct 2025 20:18:29.4638
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: ftQ6Zdqf4AKZbawUippUWky6p7BPRScpJCAaq2fZl3MM8RHFwm5KqrYjKEEuPcbexP2RO/BVGi4+JNt/b+P742+sMwQUcfUr8+RJYShyg0k=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA1PR11MB6663
X-OriginatorOrg: intel.com

--------------kIEPuZ1cABiAVg0zC0Zx6t0k
Content-Type: multipart/mixed; boundary="------------gr85pIBv1jsp1JG4102Z1Kvy";
 protected-headers="v1"
From: Jacob Keller <jacob.e.keller@intel.com>
To: Vadim Fedorenko <vadim.fedorenko@linux.dev>,
 Simon Horman <horms@kernel.org>
Cc: Shyam Sundar S K <Shyam-sundar.S-k@amd.com>,
 Andrew Lunn <andrew+netdev@lunn.ch>, "David S. Miller"
 <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>,
 Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
 Egor Pomozov <epomozov@marvell.com>, Potnuri Bharat Teja
 <bharat@chelsio.com>, Dimitris Michailidis <dmichail@fungible.com>,
 MD Danish Anwar <danishanwar@ti.com>, Roger Quadros <rogerq@kernel.org>,
 Richard Cochran <richardcochran@gmail.com>,
 Russell King <linux@armlinux.org.uk>,
 Vladimir Oltean <vladimir.oltean@nxp.com>, netdev@vger.kernel.org
Message-ID: <e7afcd75-7e12-4438-8ff0-26b06b209526@intel.com>
Subject: Re: [PATCH net-next v2 5/7] cxgb4: convert to ndo_hwtstamp API
References: <20251014224216.8163-1-vadim.fedorenko@linux.dev>
 <20251014224216.8163-6-vadim.fedorenko@linux.dev>
 <aO9x7EpgTMiBBfER@horms.kernel.org>
 <193627cf-a8c7-4428-a5d3-8813b1edc04d@linux.dev>
In-Reply-To: <193627cf-a8c7-4428-a5d3-8813b1edc04d@linux.dev>

--------------gr85pIBv1jsp1JG4102Z1Kvy
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable



On 10/15/2025 3:33 AM, Vadim Fedorenko wrote:
> On 15/10/2025 11:05, Simon Horman wrote:
>> On Tue, Oct 14, 2025 at 10:42:14PM +0000, Vadim Fedorenko wrote:
>>> Convert to use .ndo_hwtstamp_get()/.ndo_hwtstamp_set() callbacks.
>>>
>>> Though I'm not quite sure it worked properly before the conversion.
>>>
>>> Signed-off-by: Vadim Fedorenko <vadim.fedorenko@linux.dev>
>>
>> Hi Vadim,
>>
>> There is quite a lot of change here. Probably it's not worth "fixing"
>> the current code before migrating it. But I think it would be worth
>> expanding a bit on the statement about not being sure it worked?
>=20
> Hi Simon!
>=20
> Well, let me try to explain the statement about not being sure it
> worked. The original code was copying new configuration into netdev's
> private structure before validating that the values are acceptable by
> the hardware. In case of error, the driver was not restoring original
> values, and after the call:
>=20
> ioctl(SIOCSHWTSTAMP, <unsupported_config>) =3D -ERANGE
>=20
> the driver would have configuration which could not be reapplied and no=
t=20
> synced to the actual hardware config:
>=20
> ioctl(SIOCGHWTSTAMP) =3D <unsupported_config>
>=20
> The logic change in the patch is to just keep original configuration in=

> case of -ERANGE error. Otherwise the logic is not changed.
>=20
>=20

Makes sense. It isn't entirely clear if that could cause an actual
problem since the flags the driver uses appear to be set after
validation (ptp_enable and the call to cxgb4_ptprx_timstamping) .. But
having stale data there seems like it could lead to trouble and is worth
cleaning up.

--------------gr85pIBv1jsp1JG4102Z1Kvy--

--------------kIEPuZ1cABiAVg0zC0Zx6t0k
Content-Type: application/pgp-signature; name="OpenPGP_signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="OpenPGP_signature.asc"

-----BEGIN PGP SIGNATURE-----

wnsEABYIACMWIQQgQFSp1zOQVirsQx5qll0+bw8o6AUCaPABlAUDAAAAAAAKCRBqll0+bw8o6L8Z
AP4+JUiUrF6GP6Sc7NbBSAd9cZhjLFN7tzW+wMSfsCI+QgEAoxmGAaNraz2C+/wycn7/ZmkRxYrk
LcSAPZ5xrUwJ4Qk=
=X3kQ
-----END PGP SIGNATURE-----

--------------kIEPuZ1cABiAVg0zC0Zx6t0k--

