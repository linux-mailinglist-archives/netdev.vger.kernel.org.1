Return-Path: <netdev+bounces-216705-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 9A806B34FAE
	for <lists+netdev@lfdr.de>; Tue, 26 Aug 2025 01:29:05 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id C79267A964B
	for <lists+netdev@lfdr.de>; Mon, 25 Aug 2025 23:27:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 856FD2853F2;
	Mon, 25 Aug 2025 23:28:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="UOt4vnLv"
X-Original-To: netdev@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.8])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C682B277C8E
	for <netdev@vger.kernel.org>; Mon, 25 Aug 2025 23:28:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=192.198.163.8
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756164538; cv=fail; b=AXlRUDnXe9hInNlI7NTYrhhB0fGprJJvTESTnaq0DuZL/oJgYfP/ZJegZ7A7fGYx/exj0bAryli7TqoFuSNhGIK747l8uxWK1hFmb+DGI1SzgI/OC8MVmXDbUTrONNlNumFaB1nELPGkIfJGo07sy00b35CUtJcrGMRyyQG3ekM=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756164538; c=relaxed/simple;
	bh=1xsk67En23ttG8Z7jtl0uLZQs7oIfiZrNUi42TSBiPk=;
	h=Message-ID:Date:Subject:To:CC:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=slrQtCJLZQ8h3xQ/uq0M7XCwT+gaI9bd6BZtE9XxFkpCDTHU4y3tJ7D0Fe3efC2MfE/jiKBFLWLBHzpCMq5XpRVb60JsRmqp1X05MFDALD0LQWPgB8Zk6jVJ50NOB+bnj7lRrnoSsDO1hFqymrbFGLpu6dyI4rkSFdNK1AydC/4=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=UOt4vnLv; arc=fail smtp.client-ip=192.198.163.8
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1756164537; x=1787700537;
  h=message-id:date:subject:to:cc:references:from:
   in-reply-to:mime-version;
  bh=1xsk67En23ttG8Z7jtl0uLZQs7oIfiZrNUi42TSBiPk=;
  b=UOt4vnLvsFbGJdcotzoT4c84ELGmn/jEfPCPOA8sMvSl1TwXeWhkDQI5
   MXh1slO4GrTuEhaKxLT39sfuLRdPsU40AkeMB2fCG/SKBh6xZ7wyYIjRq
   O1QMspxN3IST8z4khZCg5tRJawn1mi0EWtz5+uT6egBfJpDungQf4UdDj
   FoZrKCboflhfRzgiTbhEi+h7bqyD3QKBMkgwz6LMDKvfVAHVhWTiunN6n
   8GEL8mGAIUBE4xGLIiVKF05Q/7Qa81FMMXrgkDS3aam78aLPOLeDJL87/
   xZnopNeqM6ZwCd9GiM34+Y1x8vbWL4ehmw4KQyEWGQsHKmut4L2dXk1Vj
   g==;
X-CSE-ConnectionGUID: c8BhgQ+kThGWKOlrgeWaPA==
X-CSE-MsgGUID: rswZUCBcQkKx76/+xYNpfA==
X-IronPort-AV: E=McAfee;i="6800,10657,11533"; a="75986677"
X-IronPort-AV: E=Sophos;i="6.18,214,1751266800"; 
   d="asc'?scan'208";a="75986677"
Received: from orviesa006.jf.intel.com ([10.64.159.146])
  by fmvoesa102.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 25 Aug 2025 16:28:50 -0700
X-CSE-ConnectionGUID: ISZI0/TcR02j4IyHFvd06g==
X-CSE-MsgGUID: PbSnxwPsTL2wYmPIJIzMGA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.18,214,1751266800"; 
   d="asc'?scan'208";a="168628734"
Received: from orsmsx901.amr.corp.intel.com ([10.22.229.23])
  by orviesa006.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 25 Aug 2025 16:28:44 -0700
Received: from ORSMSX903.amr.corp.intel.com (10.22.229.25) by
 ORSMSX901.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.17; Mon, 25 Aug 2025 16:28:42 -0700
Received: from ORSEDG903.ED.cps.intel.com (10.7.248.13) by
 ORSMSX903.amr.corp.intel.com (10.22.229.25) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.17 via Frontend Transport; Mon, 25 Aug 2025 16:28:42 -0700
Received: from NAM10-BN7-obe.outbound.protection.outlook.com (40.107.92.76) by
 edgegateway.intel.com (134.134.137.113) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.17; Mon, 25 Aug 2025 16:28:42 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=eR+IkiGrMwD57qMKITMbmII0MWZ8me1L69feOibdoElxNvEQwwwBNdvP4Mu/i5bvbxWZm6YCElB78UFtXXIGPwkK4SckVavjddzbFoqRVq8Ml2p+j7fFLV2CI2bJDJAKaOAiA3HF+nntfp7744GK87P3cZwTyhR9W/ht+b6ugi0HVzBeKL51yPkpzaew17by8KnzoAVb7UXZZAbhK/NeZPS39RYi+B99h1enw+camjdop+YRtXUrNzX0V/pa28YAN8Sae+8dN5DjLpcaUOBFqOcojSbi9eG9EcxOOzkdrfkNrXAOr7e7OY8d7hPHRvB2YBh3O2V7pdsi+cFENU/ZzQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=su9NFv6Pl9LuGAfEyS4LA5M6Z8OBYZytGg2Zr7BvNjU=;
 b=ipxmgBlUhJoG09cbRrfKwF1o7E4UBhV5Yxyzp/s//qZnilRszYPPNr3eZU9aIIQcguqA3yUGraEfrWAoP2dmt14OR4UnFcSxGehOVfTdcgIZQyg3KFGwvBQBuHKhMXEx2D2czfUd0JV8cPLZuZacDpGNElRnb79Q9ggiDPP0poLOAkz0qIA94B3H3X2dxY8fNsvi4IRK0k4xNLb3hv1LX2+d2zF2+nmRBCPeQTSWyuCt3S8/d9NzKEAyzyIxIseV6Gwy1oHYfiTR7GCi2zJVJm/VKpFc+dG+fcUghfphLsEWF7YQU+guSdQWJNnaiX8qJMFWE6nEcvkmE8fgeM9Dow==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from CO1PR11MB5089.namprd11.prod.outlook.com (2603:10b6:303:9b::16)
 by SA0PR11MB4557.namprd11.prod.outlook.com (2603:10b6:806:96::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9052.14; Mon, 25 Aug
 2025 23:28:40 +0000
Received: from CO1PR11MB5089.namprd11.prod.outlook.com
 ([fe80::81f7:c6c0:ca43:11c3]) by CO1PR11MB5089.namprd11.prod.outlook.com
 ([fe80::81f7:c6c0:ca43:11c3%5]) with mapi id 15.20.9052.019; Mon, 25 Aug 2025
 23:28:39 +0000
Message-ID: <02d40de4-5447-45bf-b839-f22a8f062388@intel.com>
Date: Mon, 25 Aug 2025 16:28:38 -0700
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH iwl-next v2] igb: Convert Tx timestamping to PTP aux
 worker
To: Kurt Kanzenbach <kurt@linutronix.de>, Sebastian Andrzej Siewior
	<bigeasy@linutronix.de>
CC: Tony Nguyen <anthony.l.nguyen@intel.com>, Przemek Kitszel
	<przemyslaw.kitszel@intel.com>, Andrew Lunn <andrew+netdev@lunn.ch>, "David
 S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, "Jakub
 Kicinski" <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, Richard Cochran
	<richardcochran@gmail.com>, Vinicius Costa Gomes <vinicius.gomes@intel.com>,
	Paul Menzel <pmenzel@molgen.mpg.de>, Vadim Fedorenko
	<vadim.fedorenko@linux.dev>, Miroslav Lichvar <mlichvar@redhat.com>,
	<intel-wired-lan@lists.osuosl.org>, <netdev@vger.kernel.org>
References: <20250822-igb_irq_ts-v2-1-1ac37078a7a4@linutronix.de>
 <20250822075200.L8_GUnk_@linutronix.de> <87ldna7axr.fsf@jax.kurt.home>
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
In-Reply-To: <87ldna7axr.fsf@jax.kurt.home>
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature";
	boundary="------------zyvLfy2IOYRsxkcuS0YLy3HK"
X-ClientProxiedBy: MW4PR03CA0026.namprd03.prod.outlook.com
 (2603:10b6:303:8f::31) To CO1PR11MB5089.namprd11.prod.outlook.com
 (2603:10b6:303:9b::16)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CO1PR11MB5089:EE_|SA0PR11MB4557:EE_
X-MS-Office365-Filtering-Correlation-Id: 229c6a86-d1a4-44f3-1564-08dde42f1f5a
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|376014|7416014|1800799024|7053199007;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?YVY2TDdZbFVPVzBVMVpQMkVPTTlJbVgwcUpaZnBPcjdlQXRlNDNkbEg0eTg2?=
 =?utf-8?B?RERJYy9XVFhCazZzTDZqUks2R3BUYmRhd3JPQWh2VTF2VW5iT1Vmby9SRXc1?=
 =?utf-8?B?VDEralg5d0lWRGhtak93d1h0M0JXdGhlUDZaWEkxbk1CRE1NWXhYTzlQd2dY?=
 =?utf-8?B?UlZWSmFjdjFtL2o4VkRsMEUrbDFVd1FMa2NPQWtNeFJJWElSaVVSdXc0eUVF?=
 =?utf-8?B?QlhtL0xrMzhkbG52eDJMOGlqNXZnOE1naWRKUFFKSnZPYkhETnoweDllaE5q?=
 =?utf-8?B?SzAwYkRBbjVkY0Eyd0JpTmJxWU4ycFE4WUg4RGg0Szk3SmVjYkowVyt1Zjg5?=
 =?utf-8?B?TExGUlUxRisyTGdjQ1MralQzN3R1aDY5SEx1dGRUQ0FVRFhubStHODFqNVRr?=
 =?utf-8?B?ODZFVnZya3F2Mitxd08xN2h0Wmt3VTVhZVAvZkFYMlJqL01CUmh6dEhyendC?=
 =?utf-8?B?R01oVjZSQ0huVVFJbEFXbzdUTURBZkZUNGZqYWU0VXM1SXFoUTVtZS9pbXJw?=
 =?utf-8?B?ZDIwZDRqaWlYcEJEMnNTM1hQRE13emlTRUtZQTVnVDZQVkpZSjJna2RJR05J?=
 =?utf-8?B?Sm9QdEVzeGtxSDVMUDQvcWtPWDFSWU41bHMra2VxdzVFZTNXZndmdkJpVjRP?=
 =?utf-8?B?VDdTTzBmSEwwN0VUeDh6SksvYml4Ky9qMzl2V05relN0TWdIcENUSGpkcWdi?=
 =?utf-8?B?UGpleVg2c2p6emtaTm96dURDcVZzd1VqZWVPTFpYdUVESnVxa1RqZkU4eHdh?=
 =?utf-8?B?VXRiZ3VQZmpHTmJMUC9IbUlFTThPWm1RbXlqSDlnUzZIbWVkVmFtNHl1M3RD?=
 =?utf-8?B?OHY1Sm1Lam4ySFJ2dExYU01jL3phVkxnMDVkWExYSUd2YXN2VEdxRUFzcnAv?=
 =?utf-8?B?eTdSTUJPRExiUnFlT2RkVTljYU5LT1ZwYnd2NHdwMVpKNkhpRkRSQmRCNkQ5?=
 =?utf-8?B?Q3N3OW9yOTVYbVpLR2lzVEh5ZExxUkFWeUtuZkJQN2xVUVdiMUtLODdOdUpu?=
 =?utf-8?B?UGFaRUFzdHlBcTM4M0ZIdjd3UlUxYTVudXpaTTVTU1o1NjdrZkxwUEE0WmlF?=
 =?utf-8?B?cXJjdkdBTjAyUnFhNFVyWjVVK01oaDZlQ0ZsS2JVd3VKV1NxTHBNT1BONmNW?=
 =?utf-8?B?Q1F0TGREaFM0TU9nVyt3WjQwVjlOMlh1MGpoaVVqVVBlVTMzdll1aGhNU1hu?=
 =?utf-8?B?dWllc1RWeFdQYVBYcDEwWWc4amEwSm5SRnNNRG0zK01qUUhTN2J6ekZUYnU5?=
 =?utf-8?B?SDFtTUtLNm00akszdW83Znk1Vzk2RkxhMFRhYmNmV3lHVlkydmgxeENneDFF?=
 =?utf-8?B?YVZyNWFHMjhCbGowY2dBWFNWNGVrb3R5OXpyeWlZWWd0ckZJU3RKZjFqSDhJ?=
 =?utf-8?B?RG1aRy85S0I1UnlGU3E1MXl0ZjN0aU9Vc0ZHTS9ZbnNMVUVrc2d5YkZsajJ5?=
 =?utf-8?B?NlplMno1akQxQlNHcUtUT3JVU1dJMDZSeTI4MWdKYlM0SDh2bU9oN041VXVJ?=
 =?utf-8?B?QkpWSmNvQXdLejdKWnJOVFVRZ01OeUIreUhSQUR5dFh5ZHFFbkJQU1ovNHJo?=
 =?utf-8?B?NXB3T085RzFMVXorUm1MWFVnTTMxOHJXQU85ZmNyV2VObm5EVngwc3lyM2Ir?=
 =?utf-8?B?dmJXMEtJVVMwMEhwRWxKanFjZngwemptY1UzazN5VVlLQjFJYmpVMGVBcTIz?=
 =?utf-8?B?Umo5Q1B1VFVyUk1zQjVDLzQ4SFdjaThhMFRka08wNHNNWmU0dGpWeEx5VFBi?=
 =?utf-8?B?RmcvTU9DaEs3ZjNQc0RXWk9QWjdjaWllaDBTL1pmL2NPTUVZYnZTeEtVUzhh?=
 =?utf-8?B?S0Q1UzZkdFNHR0RYNnFCelFMZnVSeUxUMWhWVXVCU1AzeHVpbDVYYzdOUlBz?=
 =?utf-8?B?VTZvMmtZa3NXUFFZV1Z5MTZ0UXJTTlFPYit0M0c1Y3QzcHRDRzRwMXQvZTZG?=
 =?utf-8?Q?vr14eb/PISA=3D?=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CO1PR11MB5089.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(376014)(7416014)(1800799024)(7053199007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?WjRyN3VqaG94aXJPaVVGMkpxdFdDSXcvcmFsT1B5cFRsWGNUYWlaWGFNSWF3?=
 =?utf-8?B?K2ZuTFg5c2U2U2JJd3Q5YklNMHRTZ3k0a1hJRjVaN0RtVkg2cElWdGlVb2lJ?=
 =?utf-8?B?bnk1UDl4WHBHRU5rZ08wWGQ3djFQRWkyRUNYYUFTdUYzajJLNnV0eGh4K0li?=
 =?utf-8?B?M0REM2cyUkRqSzN2TmlQMlBmek1KNUhjeDJrakh5bGNObnZlNXpOdU5Ub3lh?=
 =?utf-8?B?N1lNYk9lcWd4MkgrMmhjbS94S3piY0cvUmdEVlZuTGNlWE1QOERKN2RTUW91?=
 =?utf-8?B?R21CRnpCL1NpQndMRjhucklkNTFlcUJjQlpMOXhONy95N1I1VXBwSENUdEFt?=
 =?utf-8?B?QTZ0UnBPV2hTc3VFSVBVWEdqbTBQWG9BTUNhZEwzVDh1QTZVU284L2M1VWRO?=
 =?utf-8?B?aWxBUVlLNy9vWUZJUGRjQ3p3TmFqRnhkMHl1VWUzRVJYUkdsemo4Wmh5UzV3?=
 =?utf-8?B?NGN6RDVBT05oQUIrOGVsbHZhZnFvMVJGQ1dZQzBOdG81WEFYeVNvZUYvTWVx?=
 =?utf-8?B?ZlVDeEdteFl3a2xjVm81V3BzRWtKU3AvNjh1RExTalAzamJMcjVKMjVSRUFU?=
 =?utf-8?B?dWNvbDBNeE9yWWpXUm1wVjd3b1R6SnhQdEcrTjV5eHRCUy9ZUVo4S3VOL3BG?=
 =?utf-8?B?MVJVWmhLV0JXbE5TRmVsWXh3R0ExZG4vSzFzN1NFalhIVDdnYm1QM3NzTC8y?=
 =?utf-8?B?eTZaaDd2aWlleXdhTGFXK2pYdlkvUUdISmo3R0Z1SzN4dHpmeXlaYStPSlJl?=
 =?utf-8?B?aWU2NG9DQjZiK1o1eUI1M3hrblN4WjV1bnVGRE5aS0xmQUtwd2tobE5neEFi?=
 =?utf-8?B?MUJvYysreDhJdURnQVFVUmsxeTVqZUlUNTJ4ZVZnT0FMUWg2QXRTOVJscGM2?=
 =?utf-8?B?N1VKOEFCdkNKTklvbHR6U0g2RDNBbUwvNTdNOTJmMkw4ckVOMFRmRHphU1pZ?=
 =?utf-8?B?ekNsWVB6Z0RFeUxXeFNmSmhJZ3NjUVNmdGozTGpxSFhoUVFQbXRIUnl2RUdx?=
 =?utf-8?B?WnBUYTVwdlBWVHk1Tlh4UE1sTDY3ZjdtRmtrT0oraTBCYjd6eU5UNnh5dmxZ?=
 =?utf-8?B?NndOT1BVZ0xQMi9reGVxekp5aGU3WVE0eWhaUS9wRm83bTJrQ1dpZ3BIaldq?=
 =?utf-8?B?L2FZdjc0bWoyNWNGZlRNNnZpdWlMaE9yTjdIcTRzaUxlVjk2emRNWnlENENF?=
 =?utf-8?B?REJJWCtDZ3BvY3RKTzRWdWQ4eUJRdkM3S0h5ZHBPcitEZGV6Uk9qZ0xjYWw1?=
 =?utf-8?B?MnB2bE4yUDhPdU02T003cEJlOEhsanRWR0I5Q05xeGhCM1ZJUHg3OVhvTHl3?=
 =?utf-8?B?eUcwM3FzREw2NHBvdFNOTXdqUGE5RHh6VkM0d1ZxNWplZWtTaXdhNnAvRThy?=
 =?utf-8?B?cGxZQ1U5dEU3ZkU5TXZpT0Z2Q3JWVDN0TmZ1bmJ5a2hqWFN2UEZPT3ZaQ2Yx?=
 =?utf-8?B?WmJTOXNaVkhJUDdUanVsdjcvVHFkWi9BVjFoQ2FEbEhKcDRMaWIxclpRMk9y?=
 =?utf-8?B?dnFoV2tySEpUdVRadktlamp3ODBidElvVnBrRFpuMTg5SW1oY2xHR3duZ0g1?=
 =?utf-8?B?akphaTdhcW1sbHJ4SlMyOWpMRnFjbXBiNGFJLzVDU3pUNnlMTmZkYXMyK2RH?=
 =?utf-8?B?WTdtNFkyWFVjR1VVZmpmeUhRM3RpUFQwNDlrRlRWbXBuTVcyOVJyNzA5M3lw?=
 =?utf-8?B?ZFJscDVhYXlWYStFOEFubHBKZzdKRnY1OXErSXhROVd1cWZGaFUyN0ZkOVVN?=
 =?utf-8?B?T2Yrek9BcXp1NzVqNUI0TnNGT1krZWJkZUpXR3hidE01Y0ZXNEtlaWNodm1X?=
 =?utf-8?B?TXVyWEhVV2syWDMyQ25haEo4N3VSdkY4UG5FRUZ3NllwdVMxNGthc1FlK0Vz?=
 =?utf-8?B?bTcrbTlRVDNIaVdTMG1jWTNjN0Jyclhhbnc2eEtUSlJLR2RieUREdjlnR1hV?=
 =?utf-8?B?UFVkOWxZdFBsc0d6UFdjMFEraGlLZ1IwR2o4d1hSejF5TGhRenBHQUh1VjBJ?=
 =?utf-8?B?N1VtRFVrcm41c2xiVG8zMEtpVGttaU1FMnVDZHZYakM1UUNoMStoclM5UzRk?=
 =?utf-8?B?ZjRNTzdxMzhYVlNEMWhnZVVPVVk3WGg1TUx1bE5YRXNXYTFhVHJzaGkwUE1X?=
 =?utf-8?B?dDJKWTU4aW9BOTBsa0JpaytsZUpDT0wySHlYN1ZyNmxITTB2UG5KWnBoakta?=
 =?utf-8?B?MHc9PQ==?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 229c6a86-d1a4-44f3-1564-08dde42f1f5a
X-MS-Exchange-CrossTenant-AuthSource: CO1PR11MB5089.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 25 Aug 2025 23:28:39.8888
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: +gSv87G+CkdXhrhpiOAUTbxbZS2AobAylDZZeKNm5mugrUFYtwDaC1dFiEzHDAb5gtx2SaElATVp4jX/F/qFSmmQFf5DyKuZhwPSmvdQvms=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA0PR11MB4557
X-OriginatorOrg: intel.com

--------------zyvLfy2IOYRsxkcuS0YLy3HK
Content-Type: multipart/mixed; boundary="------------MhogzamRgbDK658RBMlcZyTu";
 protected-headers="v1"
From: Jacob Keller <jacob.e.keller@intel.com>
To: Kurt Kanzenbach <kurt@linutronix.de>,
 Sebastian Andrzej Siewior <bigeasy@linutronix.de>
Cc: Tony Nguyen <anthony.l.nguyen@intel.com>,
 Przemek Kitszel <przemyslaw.kitszel@intel.com>,
 Andrew Lunn <andrew+netdev@lunn.ch>, "David S. Miller"
 <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>,
 Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
 Richard Cochran <richardcochran@gmail.com>,
 Vinicius Costa Gomes <vinicius.gomes@intel.com>,
 Paul Menzel <pmenzel@molgen.mpg.de>,
 Vadim Fedorenko <vadim.fedorenko@linux.dev>,
 Miroslav Lichvar <mlichvar@redhat.com>, intel-wired-lan@lists.osuosl.org,
 netdev@vger.kernel.org
Message-ID: <02d40de4-5447-45bf-b839-f22a8f062388@intel.com>
Subject: Re: [PATCH iwl-next v2] igb: Convert Tx timestamping to PTP aux
 worker
References: <20250822-igb_irq_ts-v2-1-1ac37078a7a4@linutronix.de>
 <20250822075200.L8_GUnk_@linutronix.de> <87ldna7axr.fsf@jax.kurt.home>
In-Reply-To: <87ldna7axr.fsf@jax.kurt.home>

--------------MhogzamRgbDK658RBMlcZyTu
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable



On 8/23/2025 12:29 AM, Kurt Kanzenbach wrote:
> On Fri Aug 22 2025, Sebastian Andrzej Siewior wrote:
>> On 2025-08-22 09:28:10 [+0200], Kurt Kanzenbach wrote:
>>> The current implementation uses schedule_work() which is executed by =
the
>>> system work queue to retrieve Tx timestamps. This increases latency a=
nd can
>>> lead to timeouts in case of heavy system load.
>>>
>>> Therefore, switch to the PTP aux worker which can be prioritized and =
pinned
>>> according to use case. Tested on Intel i210.
>>>
>>> Signed-off-by: Kurt Kanzenbach <kurt@linutronix.de>
>>> ---
>>> Changes in v2:
>>> - Switch from IRQ to PTP aux worker due to NTP performance regression=
 (Miroslav)
>>> - Link to v1: https://lore.kernel.org/r/20250815-igb_irq_ts-v1-1-8c6f=
c0353422@linutronix.de
>>
>> For the i210 it makes sense to read it directly from IRQ avoiding the
>> context switch and the delay resulting for it. For the e1000_82576 it
>> makes sense to avoid the system workqueue and use a dedicated thread
>> which is not CPU bound and could prioritized/ isolated further if
>> needed.
>> I don't understand *why* reading the TS in IRQ is causing this packet
>> loss.
>=20
> Me neither. I thought it could be the irqoff time. On my test systems
> the TS IRQ takes about ~16us with reading the timestamp. In the
> kworker/ptp aux thread scenario it takes about ~6us IRQ time + ~10us ru=
n
> time for the threads. All of that looks reasonable to me.
>=20

Ya, I don't think we fully understand either. Miroslav said he tested on
I350 which is a different MAC from the I210, so it could be something
there. Theoretically we could handle just I210 directly in the interrupt
and leave the other variants to the kworker.. but I don't know how much
benefit we get from that. The data sheet for the I350 appears to have
more or less the same logic for Tx timestamps. It is significantly
different for Rx timestamps though.

> Also I couldn't really see a performance degradation with ntpperf. In m=
y
> tests the IRQ variant reached an equal or higher rate. But sometimes I
> get 'Could not send requests at rate X'. No idea what that means.
>=20
> Anyway, this patch is basically a compromise. It works for Miroslav and=

> my use case.
>=20
>> This is also what the igc does and the performance improved
>> 	afa141583d827 ("igc: Retrieve TX timestamp during interrupt handling"=
)
>>

igc supports several hardware variations which are all a lot similar to
i210 than i350 is to i210 in igb. I could see this working fine for i210
if it works fine in igb.. I honestly am at a loss currently why i350 is
much worse.

>> and here it causes the opposite?
>=20
> As said above, I'm out of ideas here.
>=20

Same. It may be one of those things where the effort to dig up precisely
what has gone wrong is so large that it becomes not feasible relative to
the gain :(

> Thanks,
> Kurt


--------------MhogzamRgbDK658RBMlcZyTu--

--------------zyvLfy2IOYRsxkcuS0YLy3HK
Content-Type: application/pgp-signature; name="OpenPGP_signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="OpenPGP_signature.asc"

-----BEGIN PGP SIGNATURE-----

wnsEABYIACMWIQQgQFSp1zOQVirsQx5qll0+bw8o6AUCaKzxpgUDAAAAAAAKCRBqll0+bw8o6BKU
AP0XZUBAawwDGsJkOpkrj1vE8vSvoUMmdA5HJe5dKxP7MwEArvhTV1CbDZPr/39M7vpzWJS0EV0t
QVAVeKOIYSBMlgs=
=kgLs
-----END PGP SIGNATURE-----

--------------zyvLfy2IOYRsxkcuS0YLy3HK--

