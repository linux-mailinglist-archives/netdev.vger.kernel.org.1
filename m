Return-Path: <netdev+bounces-218386-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 4BA88B3C43B
	for <lists+netdev@lfdr.de>; Fri, 29 Aug 2025 23:23:48 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 5C7F27AA853
	for <lists+netdev@lfdr.de>; Fri, 29 Aug 2025 21:22:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F267728505C;
	Fri, 29 Aug 2025 21:23:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="GnSY13jx"
X-Original-To: netdev@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.14])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5C05B20B22;
	Fri, 29 Aug 2025 21:23:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=198.175.65.14
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756502620; cv=fail; b=rAOXTW9ObBkUOtTBHqFsVO0haeA48kYDJ0JYfKlrVajMGwd/riSJ5uuq3KlaP4vPaK8AOSQXW+WDL7BSioxCQFV+3IeELo2bmdtH9dRSJbNUdcTgp0W32TA09zj/bl7LQljktcvEGsEz4jEJzzg1zBDjZZxjI1MwwvfZsViJavM=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756502620; c=relaxed/simple;
	bh=uTC951RPwCZsSnrAmdVIBAYbPEhMW1Jg6SiXp0JABTQ=;
	h=Message-ID:Date:Subject:To:CC:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=q02ENBCdNfYlVtpmI0hzjP4/gWKju3GMqW2aQl0gz+Q/j4gC1Ico/YXk0FzX6xLv9S4q7gqp69AuMAobPVJkJ+DpWbdICYQRs8JrFJOfAZD06ci4s2DM1hITEFbCaGZxQEMnFXUzS4y2qPIVPCIDN7g9BXsYjwWirzMhAqnz0lw=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=GnSY13jx; arc=fail smtp.client-ip=198.175.65.14
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1756502620; x=1788038620;
  h=message-id:date:subject:to:cc:references:from:
   in-reply-to:mime-version;
  bh=uTC951RPwCZsSnrAmdVIBAYbPEhMW1Jg6SiXp0JABTQ=;
  b=GnSY13jxLerGe9+WORKF2e4Ct3/72DJhjrG1EaAm+1Rc51qcRmWeVZvF
   AXfmBaWfEYViZP8JCBmAx5qbDCIUw0IkfTceoWxfFkyuIyi+wP0rQO3WO
   O7u5au3mOe4ztHHLRZm+CrO3EL/DdnbhmaLqhdont1vpvtvFCYPiLM86F
   f8oia2MTdp6bw8UhbisX1OGH3alnuLTYlgl3wQY/73180pLMTK+gehg3k
   dwTNPTG/h9lOWt9WHJ75ee/95LVHbbYFbgypvJI4y93tqqu88LkQY42Qv
   1d/bA/5zLxwLFFTT0R8iXPClUX0z+NhqNsp17cWo3ZkOMR3W/bnCk9c0f
   g==;
X-CSE-ConnectionGUID: C1OGeDBOTYS1wAljYJq3Mg==
X-CSE-MsgGUID: 4VCzIViETEqsNwHEK4vYjw==
X-IronPort-AV: E=McAfee;i="6800,10657,11531"; a="62631795"
X-IronPort-AV: E=Sophos;i="6.17,312,1747724400"; 
   d="asc'?scan'208";a="62631795"
Received: from fmviesa010.fm.intel.com ([10.60.135.150])
  by orvoesa106.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 29 Aug 2025 14:23:39 -0700
X-CSE-ConnectionGUID: g6W8TBcRTlqvnElWr4JF2Q==
X-CSE-MsgGUID: 7r4Q8ctdROW0+JanBIKNOg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.18,221,1751266800"; 
   d="asc'?scan'208";a="171275437"
Received: from fmsmsx903.amr.corp.intel.com ([10.18.126.92])
  by fmviesa010.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 29 Aug 2025 14:23:38 -0700
Received: from FMSMSX902.amr.corp.intel.com (10.18.126.91) by
 fmsmsx903.amr.corp.intel.com (10.18.126.92) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.17; Fri, 29 Aug 2025 14:23:37 -0700
Received: from fmsedg903.ED.cps.intel.com (10.1.192.145) by
 FMSMSX902.amr.corp.intel.com (10.18.126.91) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.17 via Frontend Transport; Fri, 29 Aug 2025 14:23:37 -0700
Received: from NAM02-DM3-obe.outbound.protection.outlook.com (40.107.95.45) by
 edgegateway.intel.com (192.55.55.83) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.17; Fri, 29 Aug 2025 14:23:32 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=qx7qWRrYwLTN1QrIHBfPMJXnCKCO+CMtBAocixAKGX9FqeAjpsfgwDUWhJ921iu8f+RXDDdzvw26TJpiQhi7PGaOfwDnlplxAN8HtWYiLVHh8cGV/A/O0rE5j++cLYCqW7f/vRWuTTCAkzw23GD6VD2e0lSJghzCLSqn3Q22IwA/7tva0L/EXNGKN937blDNTnubqS60IdBtyKNQ9t5PNqbyuOnSUmEPn8E+hdE3Fp/DSj7hHoLgLu3Ae2c7uBKBVdFG7rLNfzotTTXdnipKfFODq9ayTxsCfEImCH7ZkdP6cMp4XocEbFfw1SjOYBdb3TpeLYiP6fAbFW3o2chrxg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=3twEMXfvJ/zqiShuO00XSAROLDdA4XA5dL0ue42izjc=;
 b=fhKluvCADJbnsq6kwu1MzZZ7Mf5LAFEzf9fc/qUiUlEXbvwqB8VcX2Dn6mqLHqXmrjMjnkCk1yjoJhbGKiiW9JqtDj/j8tNV2JkrVK5AmqxwhBRh8NSOLb5oVYohjwzWSoi/x5BRTF4ndkNTXxpNbwHLTUHCV7rodezbVkCcOawR1WhWux4X7t0ebN/E0mvPEYf8HBfBd25ckNqKS6PB+jLoXr0jivpPLx33LpHS51Da4emcl8Em5hVe352nZwNyiMLBsqirmrA4+DqI+G4Viv3AflUpCCfycukHu1yMpMjZHdjzcn0PhsWoHgiAGnGnH4Y7jcGYf9olZJLFfa+Spg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from CO1PR11MB5089.namprd11.prod.outlook.com (2603:10b6:303:9b::16)
 by IA1PR11MB7856.namprd11.prod.outlook.com (2603:10b6:208:3f5::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9073.21; Fri, 29 Aug
 2025 21:23:26 +0000
Received: from CO1PR11MB5089.namprd11.prod.outlook.com
 ([fe80::81f7:c6c0:ca43:11c3]) by CO1PR11MB5089.namprd11.prod.outlook.com
 ([fe80::81f7:c6c0:ca43:11c3%5]) with mapi id 15.20.9052.019; Fri, 29 Aug 2025
 21:23:26 +0000
Message-ID: <40c3e341-1203-41cd-be3f-ff5cc9b4b89b@intel.com>
Date: Fri, 29 Aug 2025 14:23:24 -0700
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net-next 0/4] net: stmmac: new features
To: Konrad Leszczynski <konrad.leszczynski@intel.com>, <davem@davemloft.net>,
	<andrew+netdev@lunn.ch>, <edumazet@google.com>, <kuba@kernel.org>,
	<pabeni@redhat.com>
CC: <netdev@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
	<cezary.rojewski@intel.com>, <sebastian.basierski@intel.com>
References: <20250828144558.304304-1-konrad.leszczynski@intel.com>
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
In-Reply-To: <20250828144558.304304-1-konrad.leszczynski@intel.com>
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature";
	boundary="------------Ac50QGlIpo0KAODnUEEyVFj8"
X-ClientProxiedBy: MW2PR2101CA0018.namprd21.prod.outlook.com
 (2603:10b6:302:1::31) To CO1PR11MB5089.namprd11.prod.outlook.com
 (2603:10b6:303:9b::16)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CO1PR11MB5089:EE_|IA1PR11MB7856:EE_
X-MS-Office365-Filtering-Correlation-Id: 30b720cc-7e87-479f-e075-08dde7424aa4
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|366016|1800799024;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?TGtIN0p0Ym84R1FUVlpjMm10dENnV1UycFpxajhpV00wazFGbVdESW1SVlNl?=
 =?utf-8?B?ZWw3VDFmRFBEejNUZE5tY3FySnpXeG9jQy9waE1ka1I0U3lKcGhxc3dzc1Uw?=
 =?utf-8?B?L29yNng2RUxMcHhXeElVNENSVHRCSnZPT3R5a0ViNlZpeG16L2REUHBta29H?=
 =?utf-8?B?UWxEN0M2b1h4UmszaE5CZmJmWER0T1VhejU2UDNkOURaclFEd0xoY05QcURq?=
 =?utf-8?B?bUR2RnNkdnpEQXE3YUpBMktBUHRnOGdSTzdxSHU3bENRU2w1Z204VjZGTDhU?=
 =?utf-8?B?elRtaDN3cW1DTnRNclU0K0QybkZMU2lYd3YzQkN2QkZJNXgydDBCRGxHQjdX?=
 =?utf-8?B?cTJjT3pRY0Q2QnM0aTB4MmR5NG9uYklLS1NtTzhaSGJaenRKZ0ZDbW5HcTFQ?=
 =?utf-8?B?QllXbTl4RmVOSzNyQ0Y2TkZyTjVXcFFNQStBam9xYnRBdHp2amlQd3dCZFpR?=
 =?utf-8?B?S0RxTmV0SWJKR0NnOGZoejI0YjdkQkRHRGpENU0vaDhaWjRhM0RTTEdNSEt5?=
 =?utf-8?B?TVNrdURiY1JMMDhwckZ1ZWxldUVSb2xRZmlvdnBTVFhSZW91QUZtYlZoU1RK?=
 =?utf-8?B?QWtGbWhNQVI1MkRKR3NNejhLdmlDVEtGRk5oWFhsdC9SUlJRanloYzI0OWFJ?=
 =?utf-8?B?QTFETW9oTWRKMHp6ZFM3b0ExUmZDczRxc244S2RqNTA0eDVmbE5hWW55UW1E?=
 =?utf-8?B?ZnliTjNBTnJQblFocmRRemQ5azFtYWc5d0V1Nk9qTndzc01LOG5xQUFzaStM?=
 =?utf-8?B?cVdlQmRDazRNNFNJRnQ0Vmt3R25HQm5nYmFPZG5xekNUbEpCalZiTWRqNWpr?=
 =?utf-8?B?VFFZK0hXNW9FeTJHa0xhenNsV294d2RPVU42VWNZclhjZWhvendCMDMvamEr?=
 =?utf-8?B?aWNubEowaldSMTBQNFUzanUxZGYrWWhBWkpDSXVxbldwc2g5Y3duaGhSME9Q?=
 =?utf-8?B?S3ZrWU5VZ2FCZXBMdURiTDhEMzhJa2R3MzR2cGR2aUdnUmplQ2hrck9GdUhE?=
 =?utf-8?B?TVRLYm1DZzRLT3gxb3BqcFlDTytLaHJBSmhUTW1abURqdEhBalFzcUlERFhP?=
 =?utf-8?B?TlgzUU1zMXdEVTBITFlEOFlRSitWbUxBSG9rd1MweWE2aFBFYWl5K0hMTGc4?=
 =?utf-8?B?RkcrNk40dFVGTnJQczRadVdNWWVTYTNJNzBFbUJtUitaVkYxR2E3T2hxZmFT?=
 =?utf-8?B?YkUzemtlRkZPaXRtWlg1NW1BUnJkbThqV3V3dVlHQlhXMmpuc3Rwc1FCTjM1?=
 =?utf-8?B?ekRKbFU0NTNxY2hCZkRBdytUR081WUNzNXA4Qk5WRGZHZEY1Tzh2cE5jNGoy?=
 =?utf-8?B?L2tVQWFNdWdyb0ZBd3dkdzlxVmt3VTcwUTN1dHJFL2FNSlhuV3owYlc1Um9K?=
 =?utf-8?B?NjlMVXhKcEFwMDlXUUFXSzY1czc5TXJrOHNsV0FHUC9BZ3BnTVExeEpJcXEv?=
 =?utf-8?B?OEZvdXYveW9ycG9qcjN0cWZVSXdncm9iMFRML2w0WFRQR0VaeXZoV3NNRGEw?=
 =?utf-8?B?aC9xT2QvcWZuZlRNR1ZFUUNiNFdHNFhjUFhZekJOUDV5WHA3OXV5RVpjUTJ0?=
 =?utf-8?B?MnJqeFhZVm1jOVdzRTFMbkNJTFlJeUl0b1I3TzZjWGdEaVR2RVNtRFp3RStJ?=
 =?utf-8?B?Y1NiUnlCYzY0ZDRUUXFaUHNVNkJ3Y3dEcVU1WURESzIrQnloRjlvSEJPK2Nq?=
 =?utf-8?B?Z0cwNEJ2VjlPRFBiUGpoUVlONHVJU3hhODY1enRnOFlTTEFIVDY4SWIvUEl0?=
 =?utf-8?B?Z2hES3hZWjl6NzdaOENlYTlOWXQ5dEs2TDBkOHEzcnV0Z3I3UEJ0eEdTZE5Q?=
 =?utf-8?B?RzVyZklFRXhLcFVPWVMzY0FsK2dERzNiZDRoMnZrSk1XU0ZaSDBvYjY4S2tq?=
 =?utf-8?B?RmQrSEI4MzhMUnZxQzJhL1RsQjBNdzVibkduT3pqYWVxNVkxTW0yeFh3YXhM?=
 =?utf-8?Q?Hux2WsyhK60=3D?=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CO1PR11MB5089.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(366016)(1800799024);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?RDNCTklEYXgwS0dGYm1ROVRSS0dvNnVOV2xkcTZLUTE1TmkvbWJjQkt4Q0sz?=
 =?utf-8?B?NE94Y2hVSG1GQ01NdG9oK1V1c3AxNnM3eGZuVWlXbjFoRFNuVUZ2aGVQK09D?=
 =?utf-8?B?MUxSTnEyYkFRcTZ1R3lCZXMrcWhwYThFenp3bHRoMTdpVGNtMWRHdGFvd3NM?=
 =?utf-8?B?ZjdYdVZOQkY2dGpBM0dVc3dQZU5xZkE4V3hrYXhFcG5zdEhLdDYxLzQ1a3Zp?=
 =?utf-8?B?OUtyT1lpWGg0bkZQOXJIVCtvVEZyZ25VdFlIWDBQa3J1aEVibTJheDZLZjJu?=
 =?utf-8?B?ai84L0VCdzN6OVdJWURodVNEaEVhWGgvQXk5dHdnMUprZDJRbFJ6enFma1c1?=
 =?utf-8?B?S0MyNkExL1FhdkZMY1cvVE54WDhaNFBOZldrbGUvZGFzaUMzWlg1ZEMrVG4v?=
 =?utf-8?B?QVhoUlVHRVo5cnpHWjZyV2NIZmhuV0hSMzNJaHZQNFRBRG9mTDYydUhraEMy?=
 =?utf-8?B?cklVcmZvWlBJQUZFMHU5VFVKSHZveGQybFRzazlVakg4eE80NElaUVFXelF0?=
 =?utf-8?B?SkROTTliZ1dOejhaK2ZlVEFha2ZDcXRXNURWN3dCZE9hZEhFem1BVWl2VXdC?=
 =?utf-8?B?T1I3c3RrcXF3aTByN0cxTWFzTW9jM0R0YkFDdXpud21kWXowNzN3K1hlcmhT?=
 =?utf-8?B?Tlc4d1ZNS1NTU1FRbVRHazdUOGtZNU40Y2EzYXlIaHd4Rm82U0xrZFVrdW40?=
 =?utf-8?B?aDVwNFllRWNQSG5JY0kxaVNQbkFyTEpsdkNjNmg4TXZ2cTRHeE1sQk5hSjVQ?=
 =?utf-8?B?bHZWV1NDUUIvNUNlMjFtMzFGNXB5VTJzbjdWTW9QenkvaFpoZmI4SFhLNTVh?=
 =?utf-8?B?QjM2L1B6UnprU01tREswUVhqN24yOTF4ZXNEODV0VjlvZ1JyMHF4ZHpXR1J6?=
 =?utf-8?B?Zm5RbFZCZ000akJwZGs4bVR1MlVzRll6ZjRyQjlKay9nclZtT0xVWnpXejZX?=
 =?utf-8?B?ZWFtUUs2Zzh2NjBFaVZHa3hhMXNxNXpXdDBLUXQ5U2xreEhVMFRleTF5WHZD?=
 =?utf-8?B?QmhoS3hKMTcvbTJ3RDZ6SnpSVTJGbllVdHE1Ti9qK0p3OFBjT1dhTVIybi9m?=
 =?utf-8?B?cXF4eFRMRUE5L3RqMWZiSjhpaG9BT2dNVUhHMitNMkZJbzJCSmw0WVhPdkhj?=
 =?utf-8?B?Ly8wSEUwUE55aStIU0U3Z0tnalNQaTAyN3RVejlPWHVJcm81V0c3alBjdHlQ?=
 =?utf-8?B?MjRtcEllMFZDTzBRU3M3NVNiczU0SUNzR3R3UW1ab2NqbVNIakhOdEovT01m?=
 =?utf-8?B?U2VXb09EVFNOaStyOGlmZTB5L3hXT2dSaVB6RkI3MGhtVHRuVUZlbDZDQi9L?=
 =?utf-8?B?WG9WczBDUnVPbFJ3WklaaklFWkE4QU9YQlRPZzMvZXZ6aFFmbi9QSG5kditH?=
 =?utf-8?B?V0FpS2lydmFFbjR0MXVySGxVRE9pbG9TcWFhb2xDMW04NW1FaFBHNzFrcnJk?=
 =?utf-8?B?V2NTNkdITDhGWHVnOGFDRExDWUJlY3dDV0dEVSsxcHhrbXJxdytIaTBqS295?=
 =?utf-8?B?cExKaTRrTkZGaEJVYUp0dnVSTE9nT2FWTUlnUWVJeUNjYmRsNGZhdEcyeFpu?=
 =?utf-8?B?RDE0Wm1aK05UZ2x0VVJnMFNvdTJXOWlrMzg0V0tJaVdJdCtaVVhEZnBsSmI5?=
 =?utf-8?B?bjB0YmM5d0xrRjlDU2ZFQlVZZ1FPaWVydmlVUk9LdzJMRmhoUzZqMzdmc3F4?=
 =?utf-8?B?Y2NJakZJRlhuNXhVUUNpdlNsY1BQN3A4WDhHbVZQdEY1UXdXU1BLWnBxT3Zx?=
 =?utf-8?B?dk02dTYvQ3k1ZWN6ZGdGMU9XZzFOQlI2RmpBcCtoeG5Gdlp0bk5yZUhaeXZ4?=
 =?utf-8?B?Y0FEa3VmMnpsTmVlblh0SUpMc3hJNEFjTzlDbzNxSXZJZWlwci9xT3RDSmIw?=
 =?utf-8?B?aThiRllCWUJxajFscFIrU1MvbHBWb2FNelpMV2VhRWdtWGUvWEpIamxlKy91?=
 =?utf-8?B?YURQNllwRFl1cW5mUGIwTU12aTlUWmxMNmRVRUxsbnhWRlVkWDhJOG9Bd3R4?=
 =?utf-8?B?bkIyR0VpVzVFY2g4QS84OC9TbVNJdHlxR3BXeUVkRTliVkZtQzF4bjRzVDVt?=
 =?utf-8?B?YkhuN1I4cVNMbk9jR1YvVHkvOUsvdExEdURFd05LVk9xWVBTOE9rZEV3Y0xD?=
 =?utf-8?B?VUdZQkdMZ2RCWXlhOXdRYktFSzRCeUtRZVllZ01GUDdCTVVndmx6Ukl2eTJP?=
 =?utf-8?B?MVE9PQ==?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 30b720cc-7e87-479f-e075-08dde7424aa4
X-MS-Exchange-CrossTenant-AuthSource: CO1PR11MB5089.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 29 Aug 2025 21:23:26.5439
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: Td7qtChqqqhppbT24olOY/PVuSxWMpWWDbPJrqb4MsHJcr1x54j5JmQ6/KhVbHc6ofmC5tGVvm4YpD+8lzyvYiL1zVkZewYv+QfLJBwTwOY=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA1PR11MB7856
X-OriginatorOrg: intel.com

--------------Ac50QGlIpo0KAODnUEEyVFj8
Content-Type: multipart/mixed; boundary="------------fUhCiYReLf4vc6CuVih1hvUL";
 protected-headers="v1"
From: Jacob Keller <jacob.e.keller@intel.com>
To: Konrad Leszczynski <konrad.leszczynski@intel.com>, davem@davemloft.net,
 andrew+netdev@lunn.ch, edumazet@google.com, kuba@kernel.org,
 pabeni@redhat.com
Cc: netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
 cezary.rojewski@intel.com, sebastian.basierski@intel.com
Message-ID: <40c3e341-1203-41cd-be3f-ff5cc9b4b89b@intel.com>
Subject: Re: [PATCH net-next 0/4] net: stmmac: new features
References: <20250828144558.304304-1-konrad.leszczynski@intel.com>
In-Reply-To: <20250828144558.304304-1-konrad.leszczynski@intel.com>

--------------fUhCiYReLf4vc6CuVih1hvUL
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable



On 8/28/2025 7:45 AM, Konrad Leszczynski wrote:
> This series adds four new patches which introduce features such as ARP
> Offload support, VLAN protocol detection and TC flower filter support.
>=20
> Patchset has been created as a result of discussion at [1].
>=20
> [1] https://lore.kernel.org/netdev/20250826113247.3481273-1-konrad.lesz=
czynski@intel.com/
>=20
> v1 -> v2:
> - add missing SoB lines
> - place ifa_list under RCU protection
>=20
> Karol Jurczenia (3):
>   net: stmmac: enable ARP Offload on mac_link_up()
>   net: stmmac: set TE/RE bits for ARP Offload when interface down
>   net: stmmac: add TC flower filter support for IP EtherType
>=20
> Piotr Warpechowski (1):
>   net: stmmac: enhance VLAN protocol detection for GRO
>=20
>  drivers/net/ethernet/stmicro/stmmac/stmmac.h  |  1 +
>  .../net/ethernet/stmicro/stmmac/stmmac_main.c | 35 ++++++++++++++++---=

>  .../net/ethernet/stmicro/stmmac/stmmac_tc.c   | 19 +++++++++-
>  include/linux/stmmac.h                        |  1 +
>  4 files changed, 50 insertions(+), 6 deletions(-)
>=20

The series looks good to me.

Reviewed-by: Jacob Keller <jacob.e.keller@intel.com>

--------------fUhCiYReLf4vc6CuVih1hvUL--

--------------Ac50QGlIpo0KAODnUEEyVFj8
Content-Type: application/pgp-signature; name="OpenPGP_signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="OpenPGP_signature.asc"

-----BEGIN PGP SIGNATURE-----

wnsEABYIACMWIQQgQFSp1zOQVirsQx5qll0+bw8o6AUCaLIaTQUDAAAAAAAKCRBqll0+bw8o6Nse
AP9iE4rJfbx9RtOrwhwl5wu9VKolmsT7qNziBb2p8QMMaAD+NdIYYLx0a4wFqyWK/n8lpsmCXFnC
JpacUbxAuk4JoQg=
=ixiW
-----END PGP SIGNATURE-----

--------------Ac50QGlIpo0KAODnUEEyVFj8--

