Return-Path: <netdev+bounces-73668-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 5730D85D7C1
	for <lists+netdev@lfdr.de>; Wed, 21 Feb 2024 13:16:08 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id B235AB218F1
	for <lists+netdev@lfdr.de>; Wed, 21 Feb 2024 12:16:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F212E4F5ED;
	Wed, 21 Feb 2024 12:16:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="QyjlazaR"
X-Original-To: netdev@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.14])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 15D753B794
	for <netdev@vger.kernel.org>; Wed, 21 Feb 2024 12:15:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=198.175.65.14
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708517760; cv=fail; b=VhvLrnfBZu/1aPbH/BkgpzwmpSqAixUgOTB+3IIKi/MTMsNatt8xTbdhieeOrv17CzGocyUvWKYSgzv7t6B7WxNf3nMdl3kPZ15S/28bzxrLrOqrJdVcvs7qb5FmLRmq6rdXY0aJmwbw22u39H4TVho6HolEqYbKRmyHYukHIiE=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708517760; c=relaxed/simple;
	bh=oPdzTZ97ugh5ivVIwAc1kTUBUp/kHdoUw8E71XJceoc=;
	h=Message-ID:Date:Subject:To:CC:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=HTcYvx7qrsi1TgPKFTMhH3eEYMx16Hm6fFH68ZXVeB/K1PK+zeMjP574w4gJU2bm8ZbUtLPTkchNPE8XKEJSx/chZiXbsS6s9VZzRpEPItatHFfHowSoLj4GzYq1NApePE87ntqP1UlMY4m2UCBlc1DNYrDq5UmLfW45IfsITIM=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=QyjlazaR; arc=fail smtp.client-ip=198.175.65.14
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1708517759; x=1740053759;
  h=message-id:date:subject:to:cc:references:from:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=oPdzTZ97ugh5ivVIwAc1kTUBUp/kHdoUw8E71XJceoc=;
  b=QyjlazaRVx5+W9MZZU82nfOOx/VmJlDog3HTHD0WkUZKJ66JVEVtMB3Y
   jrNStMlAIeJjOLfAKDSI3udDv0qi885xaqQw0eO+iZWp8YCYAkq8z5VsH
   ts4rex//cyVNtmOqtXE6URtnMCRYYPnPp8HSDGWE5mAyk8k9SSGP1lhGI
   UwUFQHaipsETw2AOHxM6bpA3Ys40mfcyuXnxhlPkdCp1WRlFTWvmqcQRJ
   0vphdH4sWnflPdJPRi24zgVkGMZvLIVvMXWaEqhDVtApm+hXdbbv5Wuvv
   FG/UisS5gPSM3D7BRgjS+M6h2Hzeur5n/6dxDfxJQgyb8CHng0iSyzWG8
   Q==;
X-IronPort-AV: E=McAfee;i="6600,9927,10990"; a="6488262"
X-IronPort-AV: E=Sophos;i="6.06,175,1705392000"; 
   d="scan'208";a="6488262"
Received: from orviesa005.jf.intel.com ([10.64.159.145])
  by orvoesa106.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 21 Feb 2024 04:15:58 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.06,175,1705392000"; 
   d="scan'208";a="9810870"
Received: from fmsmsx601.amr.corp.intel.com ([10.18.126.81])
  by orviesa005.jf.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 21 Feb 2024 04:15:58 -0800
Received: from fmsmsx610.amr.corp.intel.com (10.18.126.90) by
 fmsmsx601.amr.corp.intel.com (10.18.126.81) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35; Wed, 21 Feb 2024 04:15:57 -0800
Received: from FMSEDG603.ED.cps.intel.com (10.1.192.133) by
 fmsmsx610.amr.corp.intel.com (10.18.126.90) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35 via Frontend Transport; Wed, 21 Feb 2024 04:15:57 -0800
Received: from NAM04-DM6-obe.outbound.protection.outlook.com (104.47.73.40) by
 edgegateway.intel.com (192.55.55.68) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.35; Wed, 21 Feb 2024 04:15:57 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=RzPIortC5xWbX1mbwS1XsszmJ2S41ArmrBjdF4Dt7A+pryD2IjWR5619lefAvbgZoDPq8SvNk7Gk+tDscsxovOAKadMiWUYPticygp7AdlmIO6aNh5zFkD/c0G5Q7MGwvAHgQVyg75sLFMntlTtAhX3toGgqAVPZuOz/oe+zTSuW19mI8OoO7rH5QKAhoCZbzBjhsuc60fHasgF1aqc6ivIAX4sanSMfHche0UpcA4gC7QffLlEMCeKbfeo4a9t6/0aIUPy+scfxpf6r5fVwETrg1rivSrekh80C/3tblKu/jYy687Y0PaD5V0B2b1iPrcRgmlj1SJvLX6P/TdSrmQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=KAp0PNDNhvqBEmSPDCHgGRqJavJFVcdjPvtp1hwmygw=;
 b=D58flpgBsUsotzOae1nf3aDQQ5rxCnb9FS4qyMZG/q04Blbm+hpwOZk2i7LADMZIyAYajwW5A4jj4bjVhvwySr8/aOsSxN4EZTwKAeXZCDdC0ZZOClhQLx4784X5NqBeCnp7rQeHfXMMIzk8I2qW355yDozMn+DAhnyUJjY2EvSiFqsWptSjeWAMZ2hTxfHGLDKxUIs+CwL7P51C/n9NbdVLrOpF9foWBNTuFvH33f21dyVIMfr3c2OyoqJnzKjfhTCv2sCj/G2MPW8QAcyvyJwWaCgYIBD9Yu+Ym3R0KJmwbs2gRWT30jdZaV7j9si0OBtvmsWSYT4B263dyG/zsw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from DS0PR11MB8718.namprd11.prod.outlook.com (2603:10b6:8:1b9::20)
 by PH7PR11MB8551.namprd11.prod.outlook.com (2603:10b6:510:30d::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7292.39; Wed, 21 Feb
 2024 12:15:50 +0000
Received: from DS0PR11MB8718.namprd11.prod.outlook.com
 ([fe80::93d9:a6b2:cf4c:9dd2]) by DS0PR11MB8718.namprd11.prod.outlook.com
 ([fe80::93d9:a6b2:cf4c:9dd2%5]) with mapi id 15.20.7292.036; Wed, 21 Feb 2024
 12:15:50 +0000
Message-ID: <369a78cd-a8ed-49ea-9f89-20fea77cc922@intel.com>
Date: Wed, 21 Feb 2024 13:15:46 +0100
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v5 01/10 iwl-next] idpf: implement virtchnl transaction
 manager
Content-Language: en-US
To: Alan Brady <alan.brady@intel.com>
CC: <intel-wired-lan@lists.osuosl.org>, <netdev@vger.kernel.org>, "Przemek
 Kitszel" <przemyslaw.kitszel@intel.com>, Igor Bagnucki
	<igor.bagnucki@intel.com>, Joshua Hay <joshua.a.hay@intel.com>
References: <20240221004949.2561972-1-alan.brady@intel.com>
 <20240221004949.2561972-2-alan.brady@intel.com>
From: Alexander Lobakin <aleksander.lobakin@intel.com>
In-Reply-To: <20240221004949.2561972-2-alan.brady@intel.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: FR4P281CA0090.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:cd::16) To DS0PR11MB8718.namprd11.prod.outlook.com
 (2603:10b6:8:1b9::20)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS0PR11MB8718:EE_|PH7PR11MB8551:EE_
X-MS-Office365-Filtering-Correlation-Id: 8e46cc48-573e-4e42-ad70-08dc32d6d77b
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: ATgebsM14Qq2au2fvvFgm1/wr9CERwCTkSOZYRnDd/XhwXg+Eu/98yBqYAFhi0gh+aHetoJzzkufSjfsOp46pbw+Ka+KjhHN62jgBI9IZqSMWDECuVNGOBRbi8MYZjZdu/eU/FlJPbvEf3mxDOA/mmxp+pwcot2CKbEELn1tl0944gNotNxBsEUFS5DPl3DJaogAw3RRh6I7EoNpIE/MLhRag3UJsjWtpDn760tbpHm6l9YMOrOFNq4tggwyJ3bc0NhaFBbX0q+VB+x8JUiTlfOUHRpGoIm0GQ4zogaH3MuqU2BoAjHp+p1jZLL+lSyLUZAVTDIHOoQrhxS1Bn4YazxG3Q4lRQtqAo7WylCN1PIH5nhPoD44BHON2efQMiLaZa3cBoqdNJ8ORdS7OZInGreEdL7zPPCvWkRLLtUBOZ7EE5486O9O7RB+dY2w3IpEP6DCn9ktRjitnXm5uwVEAD/QCyM8+hgFdGFa2iVVIcpuzr4C6PZ631NJIgff2JNhfzFQhPqlFa6UVHNGbTQB34udQx0hJ/nGyAZthP7tTAs=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DS0PR11MB8718.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?QTBTaXJYTDFiVWs3SmNlWUMyblR3MG8vSVpRbEFPNlZKRkVvMU5hQWswUU5D?=
 =?utf-8?B?UGpSSnpXazhqVHhuSlc0YWRrQStNMmxvVFBZNzhCaU1zTTFpYzVFQnlINU81?=
 =?utf-8?B?eDRqM21LSlBIMUVSZW9sWWR6TkVKc1oyOHJXbGhHaG9LLy9jVFZIK2NWSk9a?=
 =?utf-8?B?bGFFalU5c3MxRGx1SUx2OFdFVytkVlFWRXA5OExaSnpJSzdBY3Q3d1llUVpH?=
 =?utf-8?B?aERDSjVzL2JRbW5YTjBEZFA3OVBBZjBpbThWS1RnZUVPQ1E4YUdBeXZTTXdy?=
 =?utf-8?B?Smp4TDRpT1JKRlpnQjRLQm1idDlhek9uOE5uZjRoK09wQ09XWDdubVZUM0gv?=
 =?utf-8?B?UG1BQlU5SU00RlJ6UjM0T3ZPZEh5eHpWNldPTUo0NStOSHZwSUtOUXgvMXVO?=
 =?utf-8?B?WnBMWEMrQUt5TmU5VTJZemNRMCtFamg5MFZpSXg0NUk1b0toSDIwNTVSN2pu?=
 =?utf-8?B?cVI2aWNIUy96OTNjYmJ5SVk4MUJLT0NOOW5TTHp4dDRaRCt2RSs0YzZNK2dk?=
 =?utf-8?B?WG8vRytVM1FyQ2NONkVXVm9DbGVWakRNcncxdkkyb3NkSGNoaDdoRE5ISGZK?=
 =?utf-8?B?MWVTSjlOaUo3cml2Nzd3WitFSUN0VDlSS1BlRnBPNTZObllqU1J3REd1UHZV?=
 =?utf-8?B?Y0RTQklMZFhTeDhKRzNUdkJhSU9DZDVrYm5Hb3dvLzROV2tHM1REc01iS2Ev?=
 =?utf-8?B?d1JjK3lNMEtOc1hCV3AxbDlVSTNEb1pPN1cxcFF1TEYzcC9PZHBKOWVTYUh4?=
 =?utf-8?B?QVJxalVxaHk2MCtyS2JzNCsyUVZBa1ByQ2k5SHlzdytDdnM4U3Y2enpyRmll?=
 =?utf-8?B?SklUZ3BWeTlJMjVCcjV0NUZXRVRxL3NlWHh6eUYrS2VndEFDc3hqK1dOMnd5?=
 =?utf-8?B?MDBtR0ZvUWRKRlA4emhJaStCZWpFc0xxbU1HRnA5UXl5K0J6QTRIZ1p0bnRV?=
 =?utf-8?B?M0JoV2RVZkFxYjJ2Y1labW53Z2lDYklEQ0NzbDZxSG1UUGtETDFvSWJIYURi?=
 =?utf-8?B?dkJLRHVVTVNMa1JaNXVVS3ZrWjRObUdZRkpXVm9GNWtBbjdSWHlaQzZxWllC?=
 =?utf-8?B?SG1XVVIyZFp4blNsak0vY2J0RC9rSVN4V2F3ZnhHcDlSa3huVnRySVpQOWl0?=
 =?utf-8?B?aUtvMWdvOWFmZnpLTEZYNU1aTU5ZTGNwanAzcklqNjZZUWROakRkbFhUenlM?=
 =?utf-8?B?UTNOYVJTb2ZWYW1jUWFQcllWeWVHYll6a3gzT1BDQ3lmNG90dFRFWjlHc0Va?=
 =?utf-8?B?RFhxL3F0YU42ejBYWWh4ank4dDJRUWtPdzNkYW8vWkUzaWVzTjFpb1Rnb04v?=
 =?utf-8?B?aXptUUFqdEorL3ROeGRaYTNRT280T3lmc1ZqQVlqOWYxMVBhL2tSdjdBdEdV?=
 =?utf-8?B?NDJFNW9kMVhzajIyRHowUEhEMzZSN3JCMHJVc0dsN0xScFFFY0R4bGU3bGlU?=
 =?utf-8?B?Zmg2Q2g3WUU5aXpCUkdiNTIyTTNmdHNRYllkNXdackI3ck90aEc4YXFhaG53?=
 =?utf-8?B?c1IyWEtqSmcrNU1rSUJPeVRWV0dPZW1GRmF4R1hqeFVBMnk1UzVaNUNYeUZ2?=
 =?utf-8?B?MXg1cVhUMi9kS01laW8wZVNRdVE3UVRhQWdxQmRVem0zcVF3Y3FJSnk2N2RT?=
 =?utf-8?B?dmhwa2dkN2ZWN09ONzdFMUs5K3pRYnhDMjRCa2xYVUw3Wno3bUdHa2JwRzNZ?=
 =?utf-8?B?Ny90bG9oc0R1a1FxdTNIZGYzdkpTVEdXL3BZOWMzcDI5UTBtQkd6SXViNkox?=
 =?utf-8?B?ZjZSWU13WVFNQjdHVGloNHlNTHY3bU1ZSFNwSlFBdXFjWlhkZ0NmZU8wMXNi?=
 =?utf-8?B?bHVUNk1DZzlFenJXK1hQQmMxcjRCRndvZzNwMjhOald3YUJPWHRNNzNSQk1x?=
 =?utf-8?B?OVMxdTVydXVzeDRGam5GQWlUdVVxMWsyc1NTem9NRHQvWGJEYTJDYkpMRnVT?=
 =?utf-8?B?cDBhejMrVG90Ujlmb0YvR2l1Sjl4NzEyWmczK0tEM3ZPZ0pUVG9TZWZsQW1F?=
 =?utf-8?B?KzZjcFJFdGFJUTBMa1FPdlNnV3gramZnbFQzY08yWmUwSFUrRzZja1hGaEpJ?=
 =?utf-8?B?RVExWWpRWDhJSWx3ait2MlArSm1Jd0ZVZFRwbWl6Znh5dU03cXcxWDBDYklr?=
 =?utf-8?B?Uk56MFh2azhIWCsxb010a0JzdTFsYVl2MEEzOUFERGhTZWZaM3EvZWFjOEln?=
 =?utf-8?B?K0E9PQ==?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 8e46cc48-573e-4e42-ad70-08dc32d6d77b
X-MS-Exchange-CrossTenant-AuthSource: DS0PR11MB8718.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 21 Feb 2024 12:15:50.1793
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 8deAcEPFCSogajTU8R3UBuNS5QVGJLxDpv9sgND6Bj1Szeh6tp4SiSkAUcvYkaBI8EHV3UbSuJUMd0JQ5FZjQNETOreKg1k6zohINgHdeCA=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR11MB8551
X-OriginatorOrg: intel.com

From: Alan Brady <alan.brady@intel.com>
Date: Tue, 20 Feb 2024 16:49:40 -0800

> This starts refactoring how virtchnl messages are handled by adding a
> transaction manager (idpf_vc_xn_manager).

[...]

> +/**
> + * struct idpf_vc_xn_params - Parameters for executing transaction
> + * @send_buf: kvec for send buffer
> + * @recv_buf: kvec for recv buffer, may be NULL, must then have zero length
> + * @timeout_ms: timeout to wait for reply
> + * @async: send message asynchronously, will not wait on completion
> + * @async_handler: If sent asynchronously, optional callback handler. The user
> + *		   must be careful when using async handlers as the memory for
> + *		   the recv_buf _cannot_ be on stack if this is async.
> + * @vc_op: virtchnl op to send
> + */
> +struct idpf_vc_xn_params {
> +	struct kvec send_buf;
> +	struct kvec recv_buf;
> +	int timeout_ms;
> +	bool async;
> +	async_vc_cb async_handler;
> +	u32 vc_op;
> +};

Sorry for not noticing this before, but this struct can be local to
idpf_virtchnl.c.

> +
> +/**
> + * struct idpf_vc_xn_manager - Manager for tracking transactions
> + * @ring: backing and lookup for transactions
> + * @free_xn_bm: bitmap for free transactions
> + * @xn_bm_lock: make bitmap access synchronous where necessary
> + * @salt: used to make cookie unique every message
> + */

[...]

Thanks,
Olek

