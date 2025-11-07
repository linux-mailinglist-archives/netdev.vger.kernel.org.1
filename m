Return-Path: <netdev+bounces-236714-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 7C362C3F46D
	for <lists+netdev@lfdr.de>; Fri, 07 Nov 2025 10:55:29 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 94C584ECE5E
	for <lists+netdev@lfdr.de>; Fri,  7 Nov 2025 09:55:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EC4F62F5A0D;
	Fri,  7 Nov 2025 09:55:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="HKL9ih0/"
X-Original-To: netdev@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EBED52D2497
	for <netdev@vger.kernel.org>; Fri,  7 Nov 2025 09:55:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=192.198.163.7
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762509322; cv=fail; b=uBJY7qZaKzliyWPAcWQSzbT/riJY0VsKn9qLB3bbqeQD70pcWUu6lCergWyuciH46HsSPv2QL4/+KHp9wj1+OBKL3lHebsuranM5EWuFaolMUl/oP1jhmk4NpbRs8b+bit9z7K3vQQNVkyjcg6DjiOvbPvO+O7bj/F5Rhzrp5Fw=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762509322; c=relaxed/simple;
	bh=oY3Ljl7T6a44TNVCR7EozMUBFnXVpx5mzZMX4W/xrGE=;
	h=Message-ID:Date:Subject:To:CC:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=JZ8DFXnGRMvo9UL+l53f1XyIM3yGByz8DF6RSxuhDJoONbBcEjhNVJaYdKxUEdJG3j1OVq7K0lw4w6flabh7GLqYi4ZZW80sseaclIB9I+PEQrVgSOWiI/RWwUzucc4XJvE4+DdSb77wJRzmdwOBNE6Q0TzjsQTCe8wRby29rus=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=HKL9ih0/; arc=fail smtp.client-ip=192.198.163.7
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1762509321; x=1794045321;
  h=message-id:date:subject:to:cc:references:from:
   in-reply-to:mime-version;
  bh=oY3Ljl7T6a44TNVCR7EozMUBFnXVpx5mzZMX4W/xrGE=;
  b=HKL9ih0/KjR4sv9Hy8H65TB5fKplu1zB1Xt3+RWuvYTWYVp1E/VujoO0
   LZ14H7jysZUu66WHTNZ3bJeHJjPSGaBiibmetmvVm3KKxy1KazOCMoIeC
   /JHgAZ84t6zcRMmWzWp3vcKI3oDDtdmoCX/uXO22/UI6CoJiytZTW+XWr
   g7NvRuSlR30TC3EOz8tUrvr4vLLwScn8K66C8CWFTDaLh254BTEUj7pjc
   ugiqtMt1qA14lQIBhtP1m9+4HWvBp6KDNp8i863OQKYiAIqm9cVxLTaRD
   LxE2YwS2bjhsBVf4ZTB65qGab8DIz+nVPPSKeClm/C4lWb38bbS0beks0
   Q==;
X-CSE-ConnectionGUID: YGiuXwNEQBmFTsfdFe1dGQ==
X-CSE-MsgGUID: DtadAhoLSwi7eXvrU7QFvw==
X-IronPort-AV: E=McAfee;i="6800,10657,11605"; a="90128113"
X-IronPort-AV: E=Sophos;i="6.19,286,1754982000"; 
   d="asc'?scan'208";a="90128113"
Received: from fmviesa001.fm.intel.com ([10.60.135.141])
  by fmvoesa101.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 07 Nov 2025 01:55:20 -0800
X-CSE-ConnectionGUID: Cs3X1UW9T4Guw9GTcn8UPg==
X-CSE-MsgGUID: yANDqEY8SHu80ZWrUF8xIQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.19,286,1754982000"; 
   d="asc'?scan'208";a="218742665"
Received: from orsmsx903.amr.corp.intel.com ([10.22.229.25])
  by fmviesa001.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 07 Nov 2025 01:55:20 -0800
Received: from ORSMSX902.amr.corp.intel.com (10.22.229.24) by
 ORSMSX903.amr.corp.intel.com (10.22.229.25) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.27; Fri, 7 Nov 2025 01:55:19 -0800
Received: from ORSEDG902.ED.cps.intel.com (10.7.248.12) by
 ORSMSX902.amr.corp.intel.com (10.22.229.24) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.27 via Frontend Transport; Fri, 7 Nov 2025 01:55:19 -0800
Received: from BL2PR02CU003.outbound.protection.outlook.com (52.101.52.70) by
 edgegateway.intel.com (134.134.137.112) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.27; Fri, 7 Nov 2025 01:55:18 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=rssIN6w1fS6HIb69FWU/w+1qMbw3OCvwFxp8C7xllyXj4WvXEEqTHop3MYojVg+OE1i/qZJrW4tmYBfOWazMoIiD3ee7OPHRSAzTZrKD5LFFUDafvtSrrgGjzdlmJgxnl9mcBX28j+QDwVEAYG1homorlRpZWgfby1BUgd0nweRPomfxyEun22o/QRwF54zrTkF3gUFDUAqpqMr3VAjEzOc2dciupjgElLSh/ba5U/Cw7ujIdn1hkUOpGvfTkE5nB9EKZZvyi8Z5r9vNHnOwij+ODZGqGbhAWpjaJF2kJe7BGIbiFOpwJIk/a38Xtpye6KiyvH5W4Tcy+HvGW/d9yA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=GC282HlAUmSZDLfbp8JGKgM+RbYIWBf7HSj/Yx9ynBI=;
 b=FAmpv6Vsj+KJn6lIydvlaWRfg3U4de/Kp1IZYqsiKBaGla718d6ESXtASJRQJcbDmEkkueZNK472Lv/N/kL5oH0JF++1pMjPTxfu3R4pHBPu+9SLX5qFB+1dCTdne0fLtMdKbp9Cq0H1Am62rqJuo9BpMdbv8vdSTQSBbBUePEanI+e5nN0C0npHXal3lUD5InJmMpt950HROfDY4u6KU+t/7B3v5aZF1wMLaW7AxGyiOXM7Ylq0znW1tWdBDHuCdRMA4yS4u5NDnhz74MmPsc2k4aATwxBAbWgHKEKCQcRaa2QrRp4nmH3NWD4s++hal8sFT2UnLfh/lctm2ct2tg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from CO1PR11MB5089.namprd11.prod.outlook.com (2603:10b6:303:9b::16)
 by SA0PR11MB4703.namprd11.prod.outlook.com (2603:10b6:806:9f::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9298.13; Fri, 7 Nov
 2025 09:55:11 +0000
Received: from CO1PR11MB5089.namprd11.prod.outlook.com
 ([fe80::81f7:c6c0:ca43:11c3]) by CO1PR11MB5089.namprd11.prod.outlook.com
 ([fe80::81f7:c6c0:ca43:11c3%3]) with mapi id 15.20.9298.010; Fri, 7 Nov 2025
 09:55:11 +0000
Message-ID: <8f2640b7-0b11-47c9-a43b-870f4613dd69@intel.com>
Date: Fri, 7 Nov 2025 01:55:09 -0800
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH iwl-next v2 2/9] ice: use cacheline groups for ice_rx_ring
 structure
To: Simon Horman <horms@kernel.org>
CC: Aleksandr Loktionov <aleksandr.loktionov@intel.com>, Alexander Lobakin
	<aleksander.lobakin@intel.com>, Tony Nguyen <anthony.l.nguyen@intel.com>,
	Przemek Kitszel <przemyslaw.kitszel@intel.com>,
	<intel-wired-lan@lists.osuosl.org>, <netdev@vger.kernel.org>
References: <20251105-jk-refactor-queue-stats-v2-0-8652557f9572@intel.com>
 <20251105-jk-refactor-queue-stats-v2-2-8652557f9572@intel.com>
 <aQzZfXz9qBjr5vtB@horms.kernel.org>
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
In-Reply-To: <aQzZfXz9qBjr5vtB@horms.kernel.org>
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature";
	boundary="------------SOJ60G5NeWBHM0Vzx1sCCLux"
X-ClientProxiedBy: SJ0PR13CA0009.namprd13.prod.outlook.com
 (2603:10b6:a03:2c0::14) To CO1PR11MB5089.namprd11.prod.outlook.com
 (2603:10b6:303:9b::16)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CO1PR11MB5089:EE_|SA0PR11MB4703:EE_
X-MS-Office365-Filtering-Correlation-Id: f0a021c9-5947-4dd3-8999-08de1de3bdbc
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|376014|1800799024;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?aWdySjcrQW9iN3dGZDZYNWNROWM1S1FwNzg1RXhycUVWUGhCNmQ2Z1VQM0l2?=
 =?utf-8?B?ZFIxd1BPOVNyMVlLb3lXVENFWm80dGo3aFFpSHY2SnQ0Qm9lUFFONHJZbHBC?=
 =?utf-8?B?SCtxb2czaEFuSDlVMDBIR25oWUphUUpmNERFUkw4N0xxWDZ2eHFIbXh2TDQr?=
 =?utf-8?B?aTMyV3JjMUJ6NkFBNW1oaVFxc0tjRUVBWU9yWlhXdWNaRnhFdVAwSTMxVkpi?=
 =?utf-8?B?aWVxMkVkR1FxK0xGeHprTXgyRkprVGl5ZWFYdG9ndXF5V1N2dTIveFZtbXRV?=
 =?utf-8?B?Nml5bE4rSE5DU09DUU5paGxKRlVlQTRnYkZ3bm5ib2J0eU1Ic1NYb2hQVzlh?=
 =?utf-8?B?NW5SaEhkU2RUL1B0NWxKVlVjTERJRlpIT0NPZ29aOHVoaW0wblZqcTZYMlli?=
 =?utf-8?B?bG5WV0tYQjI5RmtKVVgrTFBBZ2JEb2ZLaG9ZTmtQSFR6Q0NWc1FuRGh2OFd4?=
 =?utf-8?B?NnFrRFh6Tlc2OHpJd2F0MUF6RjNPeW41c2xmdlZaTzB4QjRDY0ZuajlRKzJx?=
 =?utf-8?B?SVlpTkpaU05SVEN1ZnRWUUhJa2NQaE5lK09HaVQxREVLOWFrUXJPYndMRnVF?=
 =?utf-8?B?QjdMcTBDK25BZEtSSkdnRVNoUzJ0dHM1S3NESnE4L29FeHFXQ25RS0lWNjdL?=
 =?utf-8?B?T0d4RWJaeGE3c0k2TEw2RDVjNi9RR25jZ0tpY3ZOTHVnRVhRdHhwOEgweDhB?=
 =?utf-8?B?c3FwalVrTm03cDlQN280bG13TEoxSG16RVlaZGs4VGh6anNTeFU1SjRwbkdP?=
 =?utf-8?B?K0ZiNDJWbWpyV29Ja1VtcjdyZjViamJQeGlad3pqNUcxZmpGc0lnaTJMMW42?=
 =?utf-8?B?NE5ZWXZmcnhTa05USmYxVTFvdmluY0V1Q1hxVnRiMUhra1lub1FTRDhqNElU?=
 =?utf-8?B?S0NrZTRrcGJmTVBKQndMTVYzRW0ycFd4aUFyTXdJd3V2TmpwOE1acExEUTcw?=
 =?utf-8?B?UkdES3JGeHFsZEZ4TGthOFQ0U3U5V3lFTDIwWUptWTJUNzl1WkZSMVNyWDdY?=
 =?utf-8?B?K2ZFaEpEM24yYzFtanZodnlmRXZCZWZVWUEvZCt4OCs1TU4zaDVQdFZFdmJy?=
 =?utf-8?B?SzVnNVp5dC9hUTUvdlNXb3puK3E4ei9nRkVtSS9tQkdtRldZWGRSeHlFY0Rp?=
 =?utf-8?B?RG84bDZhdlJNRDBSOWFuTWJSZ2FYUUdTdXZ1cTF4eVJ5cTBrQVNmdklBdFFq?=
 =?utf-8?B?VHlsckxldWp1aU1ydnFBOVBjRnpYbFM1T0pQTzU2MGRUbHdlSjFoM2tnbWVx?=
 =?utf-8?B?ZEg2dkZtSG5QUWZqSEoxR2Vmd3NIdDRlZXByUzQ0N0RIS3RxbnpsMDdjY2xF?=
 =?utf-8?B?UDBhVXVmaVhvbG5tZGdzb0FINmtEaDBMV0JxbXkzMzc2VFo0ODRVSS9GUzRE?=
 =?utf-8?B?eTdlR2cxVmNvV1ZqRTcxb1BPVmY2RUpadTFseGVhZTVDcndKNTYzZDNOS3NT?=
 =?utf-8?B?ZUhaVjZva1NQQXJDczFoWjVMSnR2OVNHVjRDNmNrRjRqRzVWa1ljUzNVdTJM?=
 =?utf-8?B?TTlCNzltL3pYalNZWjRGeERmWE0vVEcyUUFhVCs1dHVsVXEvQTdyS1hMMHhB?=
 =?utf-8?B?ZmZqRWhMcUNQeGQ2YTg0QWdaK1ZJdmJWOVZOR2xCSkN1a3lIK1FkOE9BcEt4?=
 =?utf-8?B?NlN4aVR1Q0IyV1lKWk9PUklnM2ZIMDZWTWwwRWJTajZXUFVkeWZ0endCeEFy?=
 =?utf-8?B?Z2c1cFBiNmFHRHN3R2czQndOczBpUTkzcnJYeHdXUHRyc2EyZk8wUHVRWW1T?=
 =?utf-8?B?U2JwaEI5M015L05FdEliUzQ2S2tRQzNDZncrR3NmSVVFTXR5b3FGejViRVln?=
 =?utf-8?B?Ump5STVIVUswN3NqY29TUGI3V0lmc29WTTNjSUJRVmJNcUVVUjd4MzlrcU8r?=
 =?utf-8?B?UzV3VVRIaExibGlVek1CN2RNd3RzZ2lpOEtVZUJMVmduYmFmS3hTWEJwTEY2?=
 =?utf-8?Q?nPk3Civ+y3go9/gd47/AZsiIwFF1q+Ct?=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CO1PR11MB5089.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(376014)(1800799024);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?WVJQY1J3a1g3SzdVR2RveXZQRkJyVEF4OFhTZEJDNFArcHorK1VQa3g4dlBZ?=
 =?utf-8?B?VXRSUWtpNkU5TTB6clB0VTVtUjlsVXBMSVFycXFXOVliVWFVcG1qVWNpMEdV?=
 =?utf-8?B?a095R0NwU3ZBUFJ4QzVIQko2UE9ERFQrdjRRMHFkZU90SlRJRFpJeGhPMThs?=
 =?utf-8?B?cTJjUlYyUXJKa2hpVmlJTjZsNzFjeFBwY2c5N1M4SVlWN2FubkVEVnlCQlRJ?=
 =?utf-8?B?VWVzUWFyTEhITWtBNnppS2VwMXM1TXA3MHIxdUFUVVhVeU5FS1UrK2Z6eVZN?=
 =?utf-8?B?S25zRjdyTWRrOHM0R05lS1JiYUd5NFVRREkydWlaTXc3RU40UnZFMkExS24w?=
 =?utf-8?B?NDdwT1gxZWZpN3ptdUlzOFpKbzRvYlU0VGYxUFlYeExxQ3VRa3RzRHljL2lj?=
 =?utf-8?B?RkExK1hVMFdjZ0p1ZzRGaGV0V2ZZeUUvbmJkazFWc2QrUmRjL09OL3ZJRnJW?=
 =?utf-8?B?NDFmR3BjVytpWjRJeDR0R3JCQklZaFgxNUI0TkN1bko4d1AyNnpxQU93T0Y3?=
 =?utf-8?B?Yk5ydHZKM2ZEQzVZbnVVL2lBcStGc2F3emhmQ290SFBqSzdoQ2gxRG1KeG84?=
 =?utf-8?B?RlNNUXVCbkhacXhlWlBsOUt2VTdWOTRpbjBQQ1JLT3JYNkM3Z3U2U1llajhJ?=
 =?utf-8?B?dzhGWko5U3EvYmpUMEJpMDc5SjdTZGViZWl3WExjc1RGVUlZRCt2YUI3RjUx?=
 =?utf-8?B?UWs4UjB5blRZY2J0Q2ZGeVJ6QnhCN3JzVUlTK0Y0V2ljakZXNVNhMk0zbCty?=
 =?utf-8?B?NEhhekk3ME9zeFpuN1lXbDhOODFJSFZXV05nUDRFMGZzbG1yK25Lc1cyMlNU?=
 =?utf-8?B?dlNkQ1pHRUtrRjFEWUkwQlZmUGpTK0Fpb2lZLzArcisyZ202c09PVmpka2c3?=
 =?utf-8?B?UVpNNHdWVk9pRXJrSU9JakdvMHZmcE1rR2JQNklNT0FlVitvRmQvNThjeHIr?=
 =?utf-8?B?bGdEa1oyeDNKVWVmT3BWZXhYSWJDd0FoRy9naG9aMVozNXhhOTVYZmlreDZZ?=
 =?utf-8?B?OXVlcWdlSUpWYXFYaGFPUi9yYmQ4NTFubmtkRm5Sd29lODJWN2hZb3FqaEV6?=
 =?utf-8?B?dU9DMW0zeXFHUFhIbEs2VnVHQjltUGNKVHE4enhNajVxZW5NK3dwSDUyS2Ro?=
 =?utf-8?B?dVI1alVKMXR1T3E0UE9aY1V5ZjRyRGt2OWRtY1BLVlpuQm1wMFZ6bEN5STVp?=
 =?utf-8?B?czRpc291Ti93SHp0T0UrbDQ3ZUMvY2xaMEJUQnk3Tm9TZ2pNdXpIWFQ0QmVP?=
 =?utf-8?B?c2tjOWNueUdhQzE2Qy9MUm5ScEpHWm9oTFlXc3l5NmVlUWNNYzlvOVhkbVJS?=
 =?utf-8?B?Mjl1YTJvQmRSU0dhNWlMaGxwREVlci9TWDFvT2p0TnlRd0s1MUY0V1o4QnFo?=
 =?utf-8?B?dkJhQlkySEhRZDgzV0N1dVhIUStKblJ0Uk0rRTl0eU1TamtwQXRCN3BQd21D?=
 =?utf-8?B?M2lrZ2xQK0krVHBzY3pjUUVGV2dhSGZRQzRib2s2OFhaRmdZV3BlSU0rbTBw?=
 =?utf-8?B?eG51US9RczNFYkNUTHllU2NuRTMySDFqTGN6Vk42M21zNHI5cVp0Q0ZhdkVq?=
 =?utf-8?B?eFIzL1NBZWxBMTNreTNOelNhRkdZUm9NYU43NVVuelRGWi82RjM1UzV3R3By?=
 =?utf-8?B?WDJpQ2JTVmZ1eExhUlFFVnBxRUVpckw1NGdHWnV4cDZXMUkxbnBTK1hyV2F4?=
 =?utf-8?B?bGlMWTNaL1BTQklvTHZFWFVTb3JvRlJCdXl5K0VrOUltYVQxWFNwZm5UUG9W?=
 =?utf-8?B?YW9WRmhvZzRPOFlhTURzbGtub2tMUU5zcTVHV3o2RjdOY3ZMM1hybzc5eUJw?=
 =?utf-8?B?QzF0dE5TU01CU1I2eHlYSVN2TjQ3ZkxjQ256TnpWRjZUQ1U5dXRLZnVjR0NC?=
 =?utf-8?B?c0FSN1pxbFF0STRVOXMrNzdXbkdPWDU3UzE4SWJBRnJBU0lLZzdWTFg5S3Fy?=
 =?utf-8?B?dThSNEp4WjVVUmNGVGd4bkljcWwvOGNYeGkzUnh6MzE5NWxnQm1ySXFFVFpI?=
 =?utf-8?B?dWxTV2RhWUZxV0hObk9YeXFKMW1KRlNCWXpuV1kvd0NpdkkvblU0NjBJV3pw?=
 =?utf-8?B?RktaL1ljc2M4eWNrei9NR2h1a1R6QWt6c0NpalJrYzZ0S09jaCtlZFN3QVJ0?=
 =?utf-8?B?eS9vdUJ5NFBEcG5vS25ZaXp6ZnEyOTJHUkhWS1lmeUhwTkZtTGk2QUg2dTlu?=
 =?utf-8?B?Ync9PQ==?=
X-MS-Exchange-CrossTenant-Network-Message-Id: f0a021c9-5947-4dd3-8999-08de1de3bdbc
X-MS-Exchange-CrossTenant-AuthSource: CO1PR11MB5089.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 07 Nov 2025 09:55:11.5574
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: hdR5nbFxrSluZDvd/F4eoe/c2gE4uNvQzysn2CilAZfb08hcJf5DcrCjD00CzP9dceapyHGd9xr1fBGrATOe4Ck3YEtvkTglIr8Q3u9THt0=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA0PR11MB4703
X-OriginatorOrg: intel.com

--------------SOJ60G5NeWBHM0Vzx1sCCLux
Content-Type: multipart/mixed; boundary="------------ayRfO4HRX2Q7rI05QcjigUTf";
 protected-headers="v1"
Message-ID: <8f2640b7-0b11-47c9-a43b-870f4613dd69@intel.com>
Date: Fri, 7 Nov 2025 01:55:09 -0800
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH iwl-next v2 2/9] ice: use cacheline groups for ice_rx_ring
 structure
To: Simon Horman <horms@kernel.org>
Cc: Aleksandr Loktionov <aleksandr.loktionov@intel.com>,
 Alexander Lobakin <aleksander.lobakin@intel.com>,
 Tony Nguyen <anthony.l.nguyen@intel.com>,
 Przemek Kitszel <przemyslaw.kitszel@intel.com>,
 intel-wired-lan@lists.osuosl.org, netdev@vger.kernel.org
References: <20251105-jk-refactor-queue-stats-v2-0-8652557f9572@intel.com>
 <20251105-jk-refactor-queue-stats-v2-2-8652557f9572@intel.com>
 <aQzZfXz9qBjr5vtB@horms.kernel.org>
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
In-Reply-To: <aQzZfXz9qBjr5vtB@horms.kernel.org>

--------------ayRfO4HRX2Q7rI05QcjigUTf
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable



On 11/6/2025 9:23 AM, Simon Horman wrote:
> On Wed, Nov 05, 2025 at 01:06:34PM -0800, Jacob Keller wrote:
>> @@ -298,10 +302,22 @@ struct ice_rx_ring {
>>  #define ICE_RX_FLAGS_MULTIDEV		BIT(3)
>>  #define ICE_RX_FLAGS_RING_GCS		BIT(4)
>>  	u8 flags;
>> -	/* CL5 - 5th cacheline starts here */
>> +	__cacheline_group_end_aligned(cl4);
>> +
>> +	__cacheline_group_begin_aligned(cl5);
>>  	struct xdp_rxq_info xdp_rxq;
>> +	__cacheline_group_end_aligned(cl5);
>>  } ____cacheline_internodealigned_in_smp;
>> =20
>> +static inline void ice_rx_ring_struct_check(void)
>> +{
>> +	CACHELINE_ASSERT_GROUP_SIZE(struct ice_rx_ring, cl1, 64);
>> +	CACHELINE_ASSERT_GROUP_SIZE(struct ice_rx_ring, cl2, 64);
>> +	CACHELINE_ASSERT_GROUP_SIZE(struct ice_rx_ring, cl3, 64);
>> +	CACHELINE_ASSERT_GROUP_SIZE(struct ice_rx_ring, cl4, 64);
>> +	CACHELINE_ASSERT_GROUP_SIZE(struct ice_rx_ring, cl5, 64);
>=20
> Hi Jacob,
>=20
> Unfortunately the last line results in a build failure on ARM (32-bit)
> with allmodconfig. It seems that in that case the size of the group is
> 128 bytes.
>=20
Ok. I got a cross compilation working which actually built with 128-byte
cache size. Here's the relevant part of the structure layout:

>         /* --- cacheline 8 boundary (512 bytes) --- */
>         struct {
>         } __cacheline_group_pad__cl4 __attribute__((__aligned__(128)));=
              /*   512     0 */
>         __u8                       __cacheline_group_begin__cl5[0] __at=
tribute__((__aligned__(128))); /*   512     0 */
>         struct xdp_rxq_info        xdp_rxq __attribute__((__aligned__(1=
28))); /*   512   128 */
>=20

The xdp_rxq_info structure is aligned to 128 bytes, due to the
____cacheline_aligned attribute.

>         /* XXX last struct has 104 bytes of padding */
>=20
>         /* --- cacheline 10 boundary (640 bytes) --- */
>         __u8                       __cacheline_group_end__cl5[0] __attr=
ibute__((__aligned__(4))); /*   640     0 */

Due to the padding, this results in the group end being placed after the
104 bytes of padding. This is because the member struct has the padding,
rather than the ice_rx_ring structure.

>         struct {
>         } __cacheline_group_pad__cl5 __attribute__((__aligned__(128)));=
              /*   640     0 */
>=20
>         /* size: 640, cachelines: 10, members: 48 */
>         /* sum members: 263, holes: 6, sum holes: 377 */
>         /* paddings: 1, sum paddings: 104 */
>         /* forced alignments: 18, forced holes: 5, sum forced holes: 37=
3 */
> } __attribute__((__aligned__(128)));

I'm not sure what the most ideal solution here is. I think the simplest
is to use SMP_CACHE_BYTES for the last cacheline size assertion, since
this one will always scale to the size of the cacheline due to the
__cacheline_aligned attribute.

Does that seem reasonable? I guess I could make them all
SMP_CATCH_BYTES.. but I feel like that makes them a bit less clear. The
other groups don't have such varying sizes as the
CACHELINE_ASSERT_GROUP_SIZE doesn't include the padding added by the
cacheline_group_end, and using SMP_CACHE_BYTES would mean new members
could pass on 128-byte cache size systems even if we exceeded the
intended limit of 64bytes. Then again, on 128-byte cache size systems
the structure does grow to 640 bytes due to the padding which is keeping
the cache groups on dedicated cache lines.. We could drop the assertions
entirely too I suppose...

Another option is to remove the cacheline group from around the
xdp_rxq_info struct entirely, since it will get a separate cacheline due
to cacheline_aligned...

--------------ayRfO4HRX2Q7rI05QcjigUTf--

--------------SOJ60G5NeWBHM0Vzx1sCCLux
Content-Type: application/pgp-signature; name="OpenPGP_signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="OpenPGP_signature.asc"

-----BEGIN PGP SIGNATURE-----

wnsEABYIACMWIQQgQFSp1zOQVirsQx5qll0+bw8o6AUCaQ3B/QUDAAAAAAAKCRBqll0+bw8o6Prg
AQDhTwObrtH/qi9AdSPfaWko5Iz7uv+ay+QKYozjglo5MgD+KGEFhY5JRCCO3ymzSmmdtD7yYOG7
h8esIl6Vu+JR3QM=
=Nlz9
-----END PGP SIGNATURE-----

--------------SOJ60G5NeWBHM0Vzx1sCCLux--

