Return-Path: <netdev+bounces-227412-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 4A2BABAED21
	for <lists+netdev@lfdr.de>; Wed, 01 Oct 2025 01:59:39 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 042844A69CC
	for <lists+netdev@lfdr.de>; Tue, 30 Sep 2025 23:59:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1C3892D322E;
	Tue, 30 Sep 2025 23:59:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="BGax7MKo"
X-Original-To: netdev@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.14])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3A2642D29D1;
	Tue, 30 Sep 2025 23:59:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=198.175.65.14
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759276766; cv=fail; b=NF9AXDGKQpTM6PqnyjfEDh+kxWWI9QsXuvTzH00YQMMPoNO9w4z3mtnwaFtHGR4dCb60A2t/dQB6qKyOU1kooT4ZdxuxR5URqUvNjMYD8pacyBhVfksx4s84EmmO6JABU/OlnXW6iMcjDcAUj2rwL+YzrkDez/sWqlgEITn8IIY=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759276766; c=relaxed/simple;
	bh=AbCgyyWCrYfwbpCa37GNxlnRuphsLAPf4gJ//8vqLfY=;
	h=Message-ID:Date:Subject:To:CC:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=dwY0OhtysWRrrR+9SU99o/2V2FtURchGcPSD8pINeSes52u0bjKznKDF8lxkDWuJ/tMapvkQ5hs24CoOEseywMKGSy40R+x0u4BXSI1Abd6iucz0aXLa7nzk5ZlpPo1BbB8gT8Qn3GU0Rtd6JGbgc14FyxhHN9s/hifVrHGQUhU=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=BGax7MKo; arc=fail smtp.client-ip=198.175.65.14
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1759276764; x=1790812764;
  h=message-id:date:subject:to:cc:references:from:
   in-reply-to:mime-version;
  bh=AbCgyyWCrYfwbpCa37GNxlnRuphsLAPf4gJ//8vqLfY=;
  b=BGax7MKokF3ma54kbz29AVigViuQwAfrmr/IZ32QqBikNh+Ojh2bDdIj
   2OwawzPK8KOjkrovgfh0Rjao90uncLrtmLlQbSpX2KnQHDVt317S/MZdQ
   66n1ajTeAO1bOHNEJzfG4vbkudvnVWvA2Rq8CBJfSfk+VWrQj3sUN9VO+
   1BmHZ0HF5+/b/btRFrQbobTZ4q2nnzz6pjpK3RHouusRmPB+fae8JRGsu
   gdxyQQlQcHhhkQ4Njw6vq0DYVUqsWA1QjxpitbqDnZ5MBrFmyr6z7z43E
   Biz7XgibGfyVi7dS4Q6dPINCv4LHk9ztKl9pbtOkuzzPo3vD0rAn4ev+E
   Q==;
X-CSE-ConnectionGUID: 6rjxlll7Sti2gpAnuPSERA==
X-CSE-MsgGUID: MCugwJ5aRo+DLzG6vGUcAA==
X-IronPort-AV: E=McAfee;i="6800,10657,11531"; a="65367409"
X-IronPort-AV: E=Sophos;i="6.17,312,1747724400"; 
   d="asc'?scan'208";a="65367409"
Received: from orviesa008.jf.intel.com ([10.64.159.148])
  by orvoesa106.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 30 Sep 2025 16:59:23 -0700
X-CSE-ConnectionGUID: 3BXWB/ytS+++pTKQqGMPqA==
X-CSE-MsgGUID: E8OaJBqARGKPmKpT5saHaw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.18,305,1751266800"; 
   d="asc'?scan'208";a="178690275"
Received: from fmsmsx902.amr.corp.intel.com ([10.18.126.91])
  by orviesa008.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 30 Sep 2025 16:59:23 -0700
Received: from FMSMSX901.amr.corp.intel.com (10.18.126.90) by
 fmsmsx902.amr.corp.intel.com (10.18.126.91) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.27; Tue, 30 Sep 2025 16:59:22 -0700
Received: from fmsedg902.ED.cps.intel.com (10.1.192.144) by
 FMSMSX901.amr.corp.intel.com (10.18.126.90) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.27 via Frontend Transport; Tue, 30 Sep 2025 16:59:22 -0700
Received: from CH4PR04CU002.outbound.protection.outlook.com (40.107.201.43) by
 edgegateway.intel.com (192.55.55.82) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.27; Tue, 30 Sep 2025 16:59:21 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=ThQJvuaGuAilCgP0xt71sP+8sX9ru5qYPEJ5Comf90knbETMb8XqT0NDs+728LFMpW4xp0FvcHwVPwf4KDG10GQruZIGBdKqPY3zSXWMy+P6IT8tfvo2EDSI4WXyaaFQbmu/xx3bdixTAlT0UkghvNtqPM81eCqQqDh+xi8jjsIUUl+QKExkeFbfrAT3XwWQqul4GrFE0qElGRvmxZKSe4I9ME8I4hPT1ihbr3CYRZ2n8J7fbtpS5DtE6ikOD4M1/9B3rPD6JU6oNLGVJneuo8wUWFWMqV+IQXh8CowropUL6ZTIesd/NJ40KTENBs3f9GYc8CbpXf7CMTVVERTq1A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=t6VVSNGKR9Okty7+j5UkRIrIoiDujNNLMgAdxyH/G4g=;
 b=HR91gpCdLDsM6hxDsrz4NUBOc1w8Q063QFeqxutLOGkROB7NUkyyrNwjGPdN+9AEq5+4/s9GFnRc/yvDgAwsx/YYRpcpJYp/NC+XDiStcWkFZoLNkI6MtinBZmw+tYi1p3oXMbhXtGdo14MLFqwBy7j8A2ZKXEAEdy4KW5kQvvpfHKsshxk1Gh8guatGFHe6xqCFvnnsp6U3Sqd5L/O7+kUmLtw9rILHqwnEPQtkoyVwRq0y7NLHUsnutWBmcRaLimfoQ1Um9/3eqHV/bz6vPcRu0HbBmGCzqRCwGWB/WgY2T3umxBvLewYsPdgdmNesG6y3rJbdVtziuv6rYv9LWw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from CO1PR11MB5089.namprd11.prod.outlook.com (2603:10b6:303:9b::16)
 by IA3PR11MB9087.namprd11.prod.outlook.com (2603:10b6:208:57f::5) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9160.17; Tue, 30 Sep
 2025 23:59:19 +0000
Received: from CO1PR11MB5089.namprd11.prod.outlook.com
 ([fe80::81f7:c6c0:ca43:11c3]) by CO1PR11MB5089.namprd11.prod.outlook.com
 ([fe80::81f7:c6c0:ca43:11c3%4]) with mapi id 15.20.9160.015; Tue, 30 Sep 2025
 23:59:19 +0000
Message-ID: <c8d9f60a-341a-4386-afc6-b7a9451cda9f@intel.com>
Date: Tue, 30 Sep 2025 16:59:17 -0700
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH V2 2/3] soc: ti: knav_dma: Make knav_dma_open_channel
 return NULL on error
To: Nishanth Menon <nm@ti.com>, =?UTF-8?Q?Uwe_Kleine-K=C3=B6nig?=
	<u.kleine-koenig@baylibre.com>, Paolo Abeni <pabeni@redhat.com>, "Jakub
 Kicinski" <kuba@kernel.org>, Eric Dumazet <edumazet@google.com>, "David S.
 Miller" <davem@davemloft.net>, Andrew Lunn <andrew+netdev@lunn.ch>
CC: Santosh Shilimkar <ssantosh@kernel.org>, Simon Horman <horms@kernel.org>,
	Siddharth Vadapalli <s-vadapalli@ti.com>,
	<linux-arm-kernel@lists.infradead.org>, <linux-kernel@vger.kernel.org>,
	<netdev@vger.kernel.org>
References: <20250930121609.158419-1-nm@ti.com>
 <20250930121609.158419-3-nm@ti.com>
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
In-Reply-To: <20250930121609.158419-3-nm@ti.com>
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature";
	boundary="------------tmQGLAYJnLL9BlC77iSJz5hD"
X-ClientProxiedBy: MW2PR16CA0019.namprd16.prod.outlook.com (2603:10b6:907::32)
 To CO1PR11MB5089.namprd11.prod.outlook.com (2603:10b6:303:9b::16)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CO1PR11MB5089:EE_|IA3PR11MB9087:EE_
X-MS-Office365-Filtering-Correlation-Id: 70ac0932-569d-43a3-4583-08de007d5ebc
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|1800799024|7416014|376014|7053199007;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?V2ZnbnpOYXA2OVJaUDVaNFFOUzMvYjN5NVZUV1IyWGk3b2o1NlBWYUJnWUxG?=
 =?utf-8?B?b2pzenNTRUVEMEw3eGQydFQxd1pMTmxDb3lseVprZGxMQS8zUFRLL0hMdkJQ?=
 =?utf-8?B?RGZCZlM1VUNiU2ZhbmVtdTZiVG40am5IU1ZJaGdnNTEySXhTalJZc0RMbjJP?=
 =?utf-8?B?KytFK0pQVi9VVHJpUWpEOWsrNENIQWM4QU5ydWRVUC9WMFU4NC9jUnV3VVA1?=
 =?utf-8?B?eVRoQlFsc0MyWDhiRWNvaG1ZWlFqSzNRUGRONGtmOCtKcWdnbFBiZ0ZocGlD?=
 =?utf-8?B?dG1YVDJEbGNRc0p0bDhaNWtXRTR1YzRKT0F4SlZhUTFNT25qNGpiemQxYkl3?=
 =?utf-8?B?N1lVZUowMXFSZWFiY0FXNlBreVNFMGd3YW0zODd1L0R2aHBTMUFqeWFsR3dW?=
 =?utf-8?B?c0RVVlhXU2xNUVh2YzFmRG03ZmRyTldIUkIwNjNkeFJjbHVEVEhMSTNkY2RI?=
 =?utf-8?B?KzdoMVQrMG9RaFd0Sm1KaGFRZUV3S2MzWTAzZm9lTmZoQVZFejVpK0NFZ1Er?=
 =?utf-8?B?d3Zab3d3eXZoV0NCNjhFWUNUdUZkTWNHVGJiNUNodllvVVVEcHcrQjB6Yk51?=
 =?utf-8?B?aHNaSklhY1ZBblRHSDlzQVplcGVQSzVGZW1EY1JNMWdwZFZjOEl2OENnK3h6?=
 =?utf-8?B?VEw5M3hSSll5WHU5dzJxOFUvb3E5S3AwQWJ4TmZvRzQwSVpOdGYwVmRaOEEx?=
 =?utf-8?B?ZnZ5eU5IQzdBaUFYbnpuYUU3Y0NwQzBrVW1LU05jdWordGhuTCtLdlMyd1Fh?=
 =?utf-8?B?aHhOcEQ5RnRnaGhybHZTeTZneVEyQytvODZiZUluTkV6SnYwb1I0U0pZYUtW?=
 =?utf-8?B?S0Y4UGhXOHp5R0NQT29YN1RiN3JNdU5pSnpzT01kVEZHWncvcnBwOTVxeWJO?=
 =?utf-8?B?U3JoQUtKTDZDSEczMjlNalM5bFdPOXNLN3ZVUTVvVUxoSnF3ellBQkp0dE52?=
 =?utf-8?B?TzJjcUk1OW82TmpvRTNzVDJVbWN5bENKSit2Vm9zUXVUNWdXdTg1MEFpbmxD?=
 =?utf-8?B?Z09YaGxXZkZ5elczVUxPdlFBdGtZUWhDSTlpc0J4b2w4SjM0WmhTTHhjdlNw?=
 =?utf-8?B?YnJmSXl2WnFpeTV4cXRJV1VXR0E0OGgxQ0NURW9UUGZ3T1FtZkFDNngvdldN?=
 =?utf-8?B?VG5DcEZWUW1hYitEM1RvWU1LS3R5a3N3S3VZU1lRa2ExOThLVWphcldPSDdU?=
 =?utf-8?B?Q0dacTQrZFlaTjRCVmh1YitVWGpMVW9yZHpRaGdQc3VhK3drVkk0TU1UN0dM?=
 =?utf-8?B?Rmxqdi8wMEZFUUwyK0FLWWp4SGZ5bEdyOHZpRDNBbTRpZkFWekFkM3Fac3VF?=
 =?utf-8?B?U3grMHdBb1p0VS96bXY2ZnhjNmdYMnlQemF1bCtwbzJyeEVOMWpJdlJlQlZE?=
 =?utf-8?B?MDhLOWRpNVA0OXk4VjhQdmFyaW1lODhaZ2NVNkV2T0JleXFaVys4cVlLZE8v?=
 =?utf-8?B?czM0YXpOcnkxcFFhcnZET2d4N2lTd0VLdCtYbG5xd0IvSGtUcSs5NEZZU3Iy?=
 =?utf-8?B?Z2cvQ1VSSHc1VEhRRmlJK05DMU5OV1M1RUVsZTdGa2xKeWJQU2ttZHYxRG43?=
 =?utf-8?B?VnN1L1k2T3d5VkUvMnZ3T002aXRCQU9YenU1THMydk83eHB3dDRNS0tnSlhk?=
 =?utf-8?B?OENWcjJ0dmZsU2haSVBUTEFVWU95eHI5ZkNPSGpJeWN5QWVBM3NxQkhDYUpR?=
 =?utf-8?B?ZlRiOG9BWDhtTmtlOHdteEp5Q3VlOE9WbHZxSzZGZ2VXb28wUUsxWGY2cGFZ?=
 =?utf-8?B?eEhTUm9DU2JUa0NhdUVyb3c2MzlLMHRoZDY2WkRJYlFhNENKSC9yTkg2OUdz?=
 =?utf-8?B?ZGlRZE9NUFpIM0hoU1pCbnIzaVlDaTh4cGkzNXQrOEhpUDlRdEo5S1NnbUl0?=
 =?utf-8?B?aThzWnpLaUZxL1pXSFUyZGM2OTB2RUZYellDRWcxc294QkFVMGNPNXV2UGtm?=
 =?utf-8?Q?cdlYWkzRbou9RdpG+huO8y7outZh17aR?=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CO1PR11MB5089.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(7416014)(376014)(7053199007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?WExzcS9VYUxBcytrUm95VWptOVd0RmVRZ2tmT2JEMUVmRHg4NDJiT1Z3NTdD?=
 =?utf-8?B?VzRRT2FUODdpbmNKVmZid0dWTGxpU09CS1ZwOW1ueXdpeDl5VWE0Tm9kdk1W?=
 =?utf-8?B?dnJYam11WkdrdkRYbnlTTElKNXBuNnNiVFY1M0M4eUJIT2pWc3VocjlYUzhO?=
 =?utf-8?B?QnF6NTRaMzlyb29IOHN6TnZzY0Q1M0JBVFROWTROaEt0M2sxLzBrMC92ZnNs?=
 =?utf-8?B?TTVrcHhNZUdRZjRWc1VkWkc3TXlJSEQzc3VGaDJqdmszVFRIUm9XRUdsNS9I?=
 =?utf-8?B?UmFwekVqZWRWQWpwU2xKQkZWazVRNytvRVFiVWlxeGVvVzdRZEwxV0lvYmM1?=
 =?utf-8?B?TjVGS3hxb3ppcW1YclZ3QUFnbHc0Nnd2TlNjbndoQi9VU0VMRDNoRFVLaHd1?=
 =?utf-8?B?NU05eVYzdGNQLzE2SXlEeVRFSWN5Z2o4MEhmemhDSU93WkwwZFVGTmpjYm53?=
 =?utf-8?B?dW5PcUpxUHlTeUZuaG8xS2NqZHBtMWxuYVNSMWNpRHJwbW80dHNDUjlBNFU5?=
 =?utf-8?B?TW1WYW5GTENTV2Zjb0RVQXhzNlpxa3FFajdqTEhzdndVdFN0ZmFYTjBzeWRS?=
 =?utf-8?B?b0FlL0Z3WkVuYkQ5MGpsOEQ3cURhN1c5YXQ1RFpoUVN1RUx6eDI0ODJzc2FG?=
 =?utf-8?B?c0VkdXJ3WlY0SDl3Vk9WQ3BLcXN0NDVLb1hGSy80T0FOQkdNNVNMeW9TNjlK?=
 =?utf-8?B?K3NSYWJHM2VHbUJMRGFQRGQyNGxqOFFvV2lJVDU0Z1lZRDk2OWhnd3grSHgx?=
 =?utf-8?B?bVFFa2lkaFZnaDBKSGhzUmtXK0tsRTlNQXdoRWgzczVmMjh3RmlBTlFCL0Zm?=
 =?utf-8?B?VjJBNG0vbk03TXRrRTNWMndScVd6SDFMVmcxUUNKRHBEU0REQ0E3aVdsKzdX?=
 =?utf-8?B?MXpUZG9JTSs0Y0hiWkdjRTRXQUhCWmU3eXZBdjI4MVVWTWFIS09UUHQ2SEln?=
 =?utf-8?B?ckh4RFhGMkM5ZEprY0loMUhnOHl4Z0tWT25TcmZaUkVLYlN6aXR2ZFlUUGtS?=
 =?utf-8?B?dVNxc29rSEFqYkJ5OVdUOEdPRlpRbWViSFFRZnpiT1c5aHhKa3ZBNGhhUGJE?=
 =?utf-8?B?cmR2ci95RnpHZTB0d0ErSGZZbUVoWTRFMnlYMjlhalpsNUwrSE1YSXduSnlw?=
 =?utf-8?B?cUs2NGhPRktYcmNpcG05bHAvZnAwQTl2SFNUYTV6NVB5akZaQ3V2ZTdTUnJa?=
 =?utf-8?B?ZmFmOHZ6QVBleVJUQlNPT3JwSUFuWnNRdWRWRHNPaVJjYlBUc3hsK2hMRkRB?=
 =?utf-8?B?WktHcmw1bGQzZStaQk9ndHN4ZVhsTCsvdkduSDNTa3IrVWlxOVcvS0Q1d0NG?=
 =?utf-8?B?dkE5U3hJY1Frd0ZteDNIZWFaYm9ManNpYThZQWVtRElwOGNmT0FqaTBXZkxK?=
 =?utf-8?B?WXVSTzAveGZjK1R4dHlNSkM3cWx6MUtFQzB6eEJxY1JjWGNEc1JsU3U0anZi?=
 =?utf-8?B?Rkl6V3JBSVNxelIrMFo1dmpwVUowYjJwa3VROVRlSzNiZWc0cFNyYURKWHEr?=
 =?utf-8?B?SFFXalcxTlpHQVRhc1BrM25Idy93S3VFTE5Fa2t1REQ0S0R0ZEFpUHNoVjhQ?=
 =?utf-8?B?VE1VdWM2aTU5NndXZ2RSY0d0OUNSa0NCSktLazIxRng0cEE3WkFIWWRsUWZX?=
 =?utf-8?B?VnZ5MXUvaTNaeGcxU0NEY3R2ZktCdGltOEFnOEJRdzl5WFBrY2lMYzBoZ2c5?=
 =?utf-8?B?OVM2ZEFyZEdxbkVMcjZHUlR3MTBCL0hPUlNEdDBPUkxqVXNhaTRXQ25KTVpv?=
 =?utf-8?B?aXkrY1lvcXpyb05rWGZSR2drMXBaaUZjWS9Zek9DMm4vN05nMTBZeXMrYUhV?=
 =?utf-8?B?SDJrQ0NDRDJkbzNucU45a1owUWRyaGMyOHJwaDI2Y2V3VjNLeWlmQWJRTDh2?=
 =?utf-8?B?WEIrVHQ0bGZFMUZacVE0Vm9oVC8vMEdwWjkrOGpWQ0t3elc0WmVNN2U0cHlD?=
 =?utf-8?B?UzNqMVdhVTIxK01aU21yZzl4TXJLWFcyQ1AzY2pRMEovZEIxblNIN2M0V290?=
 =?utf-8?B?NHp6MVhzenIwZWFvYm9ZT1R1TStJUGpxVnVPUnJVVnhIZUJTeGhnT2ZaczVK?=
 =?utf-8?B?czlXVnY5TGNvamp2Qk03WnF0SzFsUzhabUZJRVFEREY5amJSRGZUc210dlNM?=
 =?utf-8?B?YXlXY0FERG9VYjNhbGd2SDJXL25CQkZlSWdHWWRBdkY1d2VYeVFUNzFiMGFt?=
 =?utf-8?B?MUE9PQ==?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 70ac0932-569d-43a3-4583-08de007d5ebc
X-MS-Exchange-CrossTenant-AuthSource: CO1PR11MB5089.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 30 Sep 2025 23:59:19.6192
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: OCIxBxQ9Bs2qmfDIe9QXN6DqpDfBhHo9PzOy9TxTJ/eu2gQ5zbXBBCERG6wEaZno6VyRXwONECyd7E4GWuy3XeU8LH2iXZUI9o9r+axdYTQ=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA3PR11MB9087
X-OriginatorOrg: intel.com

--------------tmQGLAYJnLL9BlC77iSJz5hD
Content-Type: multipart/mixed; boundary="------------W73zgVc9dZMRwiwFIUJNoDcv";
 protected-headers="v1"
From: Jacob Keller <jacob.e.keller@intel.com>
To: Nishanth Menon <nm@ti.com>,
 =?UTF-8?Q?Uwe_Kleine-K=C3=B6nig?= <u.kleine-koenig@baylibre.com>,
 Paolo Abeni <pabeni@redhat.com>, Jakub Kicinski <kuba@kernel.org>,
 Eric Dumazet <edumazet@google.com>, "David S. Miller" <davem@davemloft.net>,
 Andrew Lunn <andrew+netdev@lunn.ch>
Cc: Santosh Shilimkar <ssantosh@kernel.org>, Simon Horman <horms@kernel.org>,
 Siddharth Vadapalli <s-vadapalli@ti.com>,
 linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
 netdev@vger.kernel.org
Message-ID: <c8d9f60a-341a-4386-afc6-b7a9451cda9f@intel.com>
Subject: Re: [PATCH V2 2/3] soc: ti: knav_dma: Make knav_dma_open_channel
 return NULL on error
References: <20250930121609.158419-1-nm@ti.com>
 <20250930121609.158419-3-nm@ti.com>
In-Reply-To: <20250930121609.158419-3-nm@ti.com>

--------------W73zgVc9dZMRwiwFIUJNoDcv
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable



On 9/30/2025 5:16 AM, Nishanth Menon wrote:
> Make knav_dma_open_channel consistently return NULL on error instead of=

> ERR_PTR. Currently the header include/linux/soc/ti/knav_dma.h returns N=
UL
> when the driver is disabled, but the driver implementation returns
> ERR_PTR(-EINVAL), creating API inconsistency for users.
>=20

I would word this as indicating that we don't even use ERR_PTR here at al=
l!

> Standardize the error handling by making the function return NULL on al=
l
> error conditions.
>=20
> Suggested-by: Simon Horman <horms@kernel.org>
> Signed-off-by: Nishanth Menon <nm@ti.com>
> ---
> Changes in V2:
> * renewed version
>=20
>  drivers/soc/ti/knav_dma.c | 14 +++++++-------
>  1 file changed, 7 insertions(+), 7 deletions(-)
>=20
> diff --git a/drivers/soc/ti/knav_dma.c b/drivers/soc/ti/knav_dma.c
> index a25ebe6cd503..e69f0946de29 100644
> --- a/drivers/soc/ti/knav_dma.c
> +++ b/drivers/soc/ti/knav_dma.c
> @@ -402,7 +402,7 @@ static int of_channel_match_helper(struct device_no=
de *np, const char *name,
>   * @name:	slave channel name
>   * @config:	dma configuration parameters
>   *
> - * Returns pointer to appropriate DMA channel on success or error.
> + * Returns pointer to appropriate DMA channel on success or NULL on er=
ror.
>   */
>  void *knav_dma_open_channel(struct device *dev, const char *name,
>  					struct knav_dma_cfg *config)
> @@ -414,13 +414,13 @@ void *knav_dma_open_channel(struct device *dev, c=
onst char *name,
> =20
>  	if (!kdev) {
>  		pr_err("keystone-navigator-dma driver not registered\n");
> -		return (void *)-EINVAL;
> +		return NULL;

Wow. The driver doesn't even return ERR_PTR, but just directly casts
-EINVAL to a void *... thats quite ugly. Good to remove this.


--------------W73zgVc9dZMRwiwFIUJNoDcv--

--------------tmQGLAYJnLL9BlC77iSJz5hD
Content-Type: application/pgp-signature; name="OpenPGP_signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="OpenPGP_signature.asc"

-----BEGIN PGP SIGNATURE-----

wnsEABYIACMWIQQgQFSp1zOQVirsQx5qll0+bw8o6AUCaNxu1QUDAAAAAAAKCRBqll0+bw8o6ONh
APwL61q/rfMSkKmXr8BkM0Z9nf2r69G7x3dfRKUJ+WfvIwEAp3ek70eYj5mA/pVz75nRlCMXA9t4
dxNNBQNhHIp55A8=
=fkb6
-----END PGP SIGNATURE-----

--------------tmQGLAYJnLL9BlC77iSJz5hD--

