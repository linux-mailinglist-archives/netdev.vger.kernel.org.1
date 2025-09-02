Return-Path: <netdev+bounces-219318-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id CA118B40F50
	for <lists+netdev@lfdr.de>; Tue,  2 Sep 2025 23:24:21 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 467391B25893
	for <lists+netdev@lfdr.de>; Tue,  2 Sep 2025 21:24:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 535DE2E9EAE;
	Tue,  2 Sep 2025 21:24:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="jJaE7Kde"
X-Original-To: netdev@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.8])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 845DC20311
	for <netdev@vger.kernel.org>; Tue,  2 Sep 2025 21:24:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=192.198.163.8
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756848258; cv=fail; b=YGLnpqlikFzbefaOl+DviFQhy2RmpyZL649w4bCO2w533zY16dFHZpyeAJIuQXN5yQRIyRjGbxeSCHomOcirw/BvRoaPlzPxj6MiS1F4XO1goOiyK4mz8B4BpBcnmM1G5OrEkAXHtDgnGBnth0x9QOCgvSJuMAfUjAAeK+v08y0=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756848258; c=relaxed/simple;
	bh=umlaNBb8KTwhtDfHxme8fqFHSbTwf+aOYqzLO4Bh/BQ=;
	h=Message-ID:Date:Subject:To:CC:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=iH+ksBSjnOtufGchlyFYDmfAkEmkC/aY0UIyn/aulGCFRNleWCgbkHnUsuOOo/ItGfV1egiWF3astMhr0T1KmjZXUAJxGdygivDr0I6e4EvsgVlNNfaC45I2rF/Clk1a+Q6nXI0B77Yv9wmTWVPbISiINulimdhJv226gtOb1s0=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=jJaE7Kde; arc=fail smtp.client-ip=192.198.163.8
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1756848256; x=1788384256;
  h=message-id:date:subject:to:cc:references:from:
   in-reply-to:mime-version;
  bh=umlaNBb8KTwhtDfHxme8fqFHSbTwf+aOYqzLO4Bh/BQ=;
  b=jJaE7KdeBwF670HYjXNnpLaX7kh5aIHonYMT6fPyOazSbuZXQ8ENKfA3
   d05w4b8xCxCmKtTQKNyaQVi0RSS3tjbYCylktYivBiUEa4eKPf5GkKqRe
   yGWugeyA2g2xSZCvCT9PQd/M5zUVZwxzQ1uaMjbQxBzciVxNHcmGYZk2g
   OJL8ggBJVYmNaChgGT/o1L/GcmmQcHSeThM6hgKzzWWbd1bFCRKttZH6M
   ZqFL0Xf9k6tjSXqUi3p7PzB3gr2QsBck6QgsMMqPAixi1hxWgn+7GI7eF
   yV1T2bBnnkdUJjEusnZwSXovWkgDLB2n1IPeCEDpyPZc/U5YqBW7HvsOR
   Q==;
X-CSE-ConnectionGUID: KU453pGfRNaNs148pduWGg==
X-CSE-MsgGUID: uD3HwHb8Q7CRUWMuZb9GWQ==
X-IronPort-AV: E=McAfee;i="6800,10657,11541"; a="76744447"
X-IronPort-AV: E=Sophos;i="6.18,233,1751266800"; 
   d="asc'?scan'208";a="76744447"
Received: from fmviesa002.fm.intel.com ([10.60.135.142])
  by fmvoesa102.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 02 Sep 2025 14:24:14 -0700
X-CSE-ConnectionGUID: fQjEkqYZQ7GONqHKCqPTZA==
X-CSE-MsgGUID: B3n2ugHuR/uSIU/D/3X2Aw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.18,233,1751266800"; 
   d="asc'?scan'208";a="195044481"
Received: from fmsmsx902.amr.corp.intel.com ([10.18.126.91])
  by fmviesa002.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 02 Sep 2025 14:24:13 -0700
Received: from FMSMSX901.amr.corp.intel.com (10.18.126.90) by
 fmsmsx902.amr.corp.intel.com (10.18.126.91) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.17; Tue, 2 Sep 2025 14:24:12 -0700
Received: from fmsedg903.ED.cps.intel.com (10.1.192.145) by
 FMSMSX901.amr.corp.intel.com (10.18.126.90) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.17 via Frontend Transport; Tue, 2 Sep 2025 14:24:12 -0700
Received: from NAM11-CO1-obe.outbound.protection.outlook.com (40.107.220.85)
 by edgegateway.intel.com (192.55.55.83) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.17; Tue, 2 Sep 2025 14:24:12 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=TjGOLrYYLHowdpMphMfonqNuJ9FaHAJWm3zQjecTJHlBwTlXxdTsbvPelH4e8IpYIJJfbbgk9Pg5IsYTYNCaQYM/oRYKIGC1AL8S942Jjn2CR9hSXAC2S+256lEswwdEkK2sjQBwCc06cg9aWFIX+D1ZCPvEhfQgdCJr+Kg+OPiR9PA4iMrO0l7drUqI1kL25kCg+bvDceejsW6sj1J1w+5f2ZqLnYDrTLhdjke5yQZU+QqlRFtskA+NWh66G/ge1MZOQaT2KmjdnjTfEOd6CHIcWzVSQ1jUuYFjQBfaiulT1Wv/otL7H7FOXRV86ZpyXn3HiPRfLk5tc+ABZEKLqw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=+b1ccFyCLoqsrdS+EXl8+6Pt8vxdDKQzeIXF2RFu2UI=;
 b=S7p4A+eibPudPe3cYkKiwsCLrz4Juq1OPm0nBn4dy+MQJVbTOVaQXL8gfGrctl+1cEW9E4eklIaihG3enIwK5shK0j9w59aIXMk6RXUn5pBrLmcBQ99SDr0qqn7dCNL7vN6CS9DI5WVbwQcnKK7E1oyBvMcmg7Z7I8B+XNBHlyCTX2xqHfntrYI92U+qKJ2GsAdTR8nuf0WobJTuCREqwpfhfQw01ODsjDtCls1AwrvqXoM5qByP6OPdFCHMrR1HOWUwGGniUuelynzifEHDchMT6Z28t8hTQK8hp9QrnYLRmXyRW/I+wHbMqG7E+TIAfJrYAFhW4LBqdgYSNtOD2w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from CO1PR11MB5089.namprd11.prod.outlook.com (2603:10b6:303:9b::16)
 by DS0PR11MB7926.namprd11.prod.outlook.com (2603:10b6:8:f9::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9073.27; Tue, 2 Sep
 2025 21:24:10 +0000
Received: from CO1PR11MB5089.namprd11.prod.outlook.com
 ([fe80::81f7:c6c0:ca43:11c3]) by CO1PR11MB5089.namprd11.prod.outlook.com
 ([fe80::81f7:c6c0:ca43:11c3%5]) with mapi id 15.20.9073.026; Tue, 2 Sep 2025
 21:24:10 +0000
Message-ID: <5056c692-7478-4f38-8859-7cc7c823bbf5@intel.com>
Date: Tue, 2 Sep 2025 14:24:07 -0700
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net-next V6 01/13] devlink: Add 'total_vfs' generic device
 param
To: Saeed Mahameed <saeed@kernel.org>, Jakub Kicinski <kuba@kernel.org>
CC: "David S. Miller" <davem@davemloft.net>, Paolo Abeni <pabeni@redhat.com>,
	Eric Dumazet <edumazet@google.com>, Saeed Mahameed <saeedm@nvidia.com>,
	<netdev@vger.kernel.org>, Tariq Toukan <tariqt@nvidia.com>, Gal Pressman
	<gal@nvidia.com>, Leon Romanovsky <leonro@nvidia.com>, Jiri Pirko
	<jiri@nvidia.com>, Simon Horman <horms@kernel.org>, Vlad Dumitrescu
	<vdumitrescu@nvidia.com>, Kamal Heib <kheib@redhat.com>
References: <20250709030456.1290841-1-saeed@kernel.org>
 <20250709030456.1290841-2-saeed@kernel.org>
 <20250709195331.197b1305@kernel.org> <aG9RuB2hJNaOTV3e@x130>
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
In-Reply-To: <aG9RuB2hJNaOTV3e@x130>
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature";
	boundary="------------gJTHodK5fGpWOaIkYLsHuk3y"
X-ClientProxiedBy: MW4PR03CA0325.namprd03.prod.outlook.com
 (2603:10b6:303:dd::30) To CO1PR11MB5089.namprd11.prod.outlook.com
 (2603:10b6:303:9b::16)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CO1PR11MB5089:EE_|DS0PR11MB7926:EE_
X-MS-Office365-Filtering-Correlation-Id: faade402-165a-4acc-cf02-08ddea670e32
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|1800799024|7416014|366016;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?TGFXSmZpN3A0WW85cU1ac3I1Zm1IVFJmT0hUR3lxdW1XVXk1SWVDemlzTXhP?=
 =?utf-8?B?S0ltWlExT1ZOTFczY3RFQktyOTRhaVd3cmI0ei83dnRjUDZTejhpYjgzcWVi?=
 =?utf-8?B?U09OYWxQdHdVYTlneVJQeVpGeDJTNVZHcG5FeUV2bmhtaEVneHBYNXpzZmpq?=
 =?utf-8?B?UGtzaExCRjc4RkpzNit6SWV6M1Q3ZmNVYVQrQUo0OWRTYmduUWtWWFYvZHdu?=
 =?utf-8?B?UWh3SHdFeVBwTFIvbmFFelN0djhOQW9WQWhFekxVR3lhZXZzTmU1TGpwNHJU?=
 =?utf-8?B?bm1CQnJuT0ZmQWczTTR2ZVVpVnAvWHdoRUF5b2V4VE9iaW0wVUxkM1JYS2hK?=
 =?utf-8?B?aTcyamdsSHgwTWF5MkF3UkdkMEVsSmpCRWJtS1dWRlhXZ25jZkp6bHFvWWNY?=
 =?utf-8?B?QzNwWnJvTVVrSWVEcUsydU1Iajc4cTIxODZZa3BKWDdUMnpqOGNWUUhJOEEz?=
 =?utf-8?B?N1FpZGEveWxvM2VLTkRzYXNSTWtuY0VXY0FPM1dBQXVXRVphQ2w5U2lFZHB5?=
 =?utf-8?B?Umo3U3pvVGhYVGljUHN1ZHBZeTEzRHMrM3V4UGVpamViVkcweVRiekFSbTJp?=
 =?utf-8?B?MHo3NlNKTXhnRkRmMnF2b0VGVHc4WUJqdHVKbFh4T0VFMGRvNktlaEpDVHZX?=
 =?utf-8?B?NElVSFdKdmlvOVkwUS9IcGtPNFRXa3BnZ3RLUUprd2FZcHhISytsTlJjbW1D?=
 =?utf-8?B?NkFvNjhZTUxLVGVuVXJUZnFCUlMrOC9NT2VubTVvSE8rcXRpM1Y3LzZQVXdl?=
 =?utf-8?B?OTc1SnFnTklmYk9vSGpXMUgwNVBObUljYTR3OUpyNXFiUmo2bGJyRzc1S0hu?=
 =?utf-8?B?S1h5aHhMaGFZNGtzaEw2MG9keTl0ZTgzb0EyQzRmWUw4S0dKbXE1VEd0TDI1?=
 =?utf-8?B?dU0zYTJ0YndBSjRUS1pCRzhoQXpnNXBFNFZxNGgya0syRUkycmxReUNWcVUw?=
 =?utf-8?B?RHJpRkVvQWFmVERQWFRrU0QxWXBXdTJiVE1DWEhVK0xqeU9JekxaT0h4dSt3?=
 =?utf-8?B?MlBxODZjZ3NzRUZsVjlNRVVaSUo5Z3lLOHBwVytWOEZsczBBbmp1dXJWbDE4?=
 =?utf-8?B?WGNJNUxlM1A5a2plUnVNcWEzdkxTelRWbUprMmlqeFlvejVPakxOUUMvbnVM?=
 =?utf-8?B?QzE0endpK3lRSm80MTltanJMRmRISHlrZGQzekd1VjBrckNDYXhtL0lSQkU4?=
 =?utf-8?B?anM4cVhaWEE5VDUvQWRoOFNkVVpmQ0NtQWJLaEk3alo2Nm1NVjNBZ2EzeC9J?=
 =?utf-8?B?Y0JuNVFCUG5rMFE2bjAxK0ErN1IweVdRSnhVVGE5NlZHTkhUeVpqRkFYOVFI?=
 =?utf-8?B?K09FMVhUbGxsMUNNbEFkRlR6WENNbzhITkdWVDk3ck03M0xKOE1BekhyYUhP?=
 =?utf-8?B?L2QwTC9EeVUvN3NSY01TN2FiVFEzT2pXaWFDblFZZWc5ajdxTXI1THNQVmRD?=
 =?utf-8?B?TVJ4QUVsL3htUGpnSjFlOHdVWmQ1M0lnVlp2MnIwbW5Jd01DZjJxeTRQMVBN?=
 =?utf-8?B?Y1ZlaVE1YmxLOVlLZy9CL20rTWVoQVB1ZmkxeitlYnloazE5MjNmSjR2aUJJ?=
 =?utf-8?B?eTQ3YWdWV1Fub25hUmtsSzJadWhMTDFEMFk4TE50SVZJYWJiR3E1MWR2bGZs?=
 =?utf-8?B?Vm4xUE5RcitnMWxaZ1BLNFIwUmt1TlllbXBKYWhvYWdBK25XQnFyMEk1Vk1L?=
 =?utf-8?B?eE0zUTRTd2VMLzRHVkFGMVFwR0FSVWhXc2xKeW9xaDBRV3NFQ0NsbnJqb1Vt?=
 =?utf-8?B?K1c0akRPQU9hZU5nVWt6MUR4aUpmUUF0Y0RaejRMQWpZUytmUVlQZVZScDYr?=
 =?utf-8?B?bEx4SzZ6SE4zQzdyQ2J1Y0JKT0lDUkxoMkhVRThhbXdpSDB4L01FUEo1dXdJ?=
 =?utf-8?B?TEVSSWUwWnI1VWFnUnFCWnlyY3Z4NDloSmxUQjFKYlNoTFRIWEh4TTZES2k3?=
 =?utf-8?Q?Q3AOX84kI10=3D?=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CO1PR11MB5089.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(1800799024)(7416014)(366016);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?dlpKcnlOQmJQL01wNGYreFB3N1FOazdZNjhWbzN6TjE3WnhEdkNEakhCVE51?=
 =?utf-8?B?T0FxSll6RUNMTjFJLzk3SHoyRnFrVHZJa3dkakhuWWlMRXVURmIwRkQ4VGg0?=
 =?utf-8?B?TVlrbmV0akhldWxsVUFUaUJQbkxxVjh3bHVOcC9kUDJOVkoxbnJqWlN2N0Yx?=
 =?utf-8?B?dnRaY3Z4YndlSmpHVlR1c01GUXd3MHJBZGRNMTF0MUJQNGpjS1NzN2RrVWQ2?=
 =?utf-8?B?UUV5N0s1aFpzbWE1dE04TU5FejRkd2N0RzNiL1Y4MW56VHQ4WmtucXVnYUlp?=
 =?utf-8?B?Q2lUcWhySXZtZ3lJQytwK2lLT1UvdkFYaDhzcXpwbDFydzFwQWZIbmJva05v?=
 =?utf-8?B?dnhoQ0pmTU9uS2dWZnh1MFV1eFBpdjlCb2ltdFNvbU0rcmxVK0Z3Y2FOdjU1?=
 =?utf-8?B?bnBBQksrcEtIaDd3alJKNUdlN3lDWnBqM1dUc0FzSW1GeTR1cGtKa2ZzdG1F?=
 =?utf-8?B?TXQ4VU5KUTNHR3Z1T3hVTlliSU5JU2UxczBuYVg2RWdCdUY4Wk44WkRwVkRZ?=
 =?utf-8?B?Z2lIc0N5amR2V014dGt6THdnYUlyRDRGSXI1SEt6aEFaNnM3b1FKSlRXeG4y?=
 =?utf-8?B?cVFQd2d4ZGRlU2xBOC9KdjR1WnNJYUxFZ09Wd3hWSEJOWm5VV0g0VFpMdDR1?=
 =?utf-8?B?R3N4MlMyNjgyNkxVa210dGYzU3NZRHNBbzRoZ3ZLbkhQRXA2N3JWMC9lS1FS?=
 =?utf-8?B?cXNFd1RsVE9rdjhtTlZEdUJic1ZFckxKSlVpOHZ0Y0tHYUxYb2NNOW9SdTNG?=
 =?utf-8?B?SStpeDRUdzA1dkhYVVdnS05kdkRkUWFIcjNmUDYxK0F1UmVDOFR2YlZLbHhk?=
 =?utf-8?B?NVA3aTVEWVdzSk1Rc2pFa3RnZmJjajdtczN6aU5aTnU0ZHJabHl4TEhZRlNJ?=
 =?utf-8?B?dllTRnZxRjFsS3UrbVFTSkRTcVNMc2dWU21jVFYwZ3FJSzcyTVZmYStKQ1FC?=
 =?utf-8?B?VlQxem9hTzEvOVN3dHJiN2trK1VxN3R2K1FMNFFpSEZhbEkyVjNDRkNZZ2Qv?=
 =?utf-8?B?YVFKT3RLd3o4bE9UaGx3ZVQySnFQQitZUmx2VjdVWGpCOTM5UVdYaWVOdzEw?=
 =?utf-8?B?L3h1UG1DRzNOdGE4YU9tc0ZCc2ltb3NhWmgwUnBqWmdzbXFoKzk5WC8zajZv?=
 =?utf-8?B?RWZ3dFkwZnZXSElxM3owM0o2RyttWlZtY2ljV3NzQUd2cjNzbVE5NlhYSFBE?=
 =?utf-8?B?eXdTWjFwcVNhdDR0VmJyRGlRUDJuQVZ3QUFlTWdRTkRPY0Nvb1FpWmUxV1li?=
 =?utf-8?B?bE1iV2Y2T0d1cDdxUHJWSDVYNUp4Z21nN2xMTkdRdkJMNkxyd3RqQnY4UlNM?=
 =?utf-8?B?K3JQOTN6TS9ZV3hXQmV4Ri9PenVhdEpZcnBWbnNIWGFTcU1DY0QyNUREQ0tE?=
 =?utf-8?B?OEVsS0NicU96WE5oSU51a3lONm82dldkMnp5d1VjT29jZ2xVdFdicGowQjBU?=
 =?utf-8?B?QkJjQ20xYUJ5Yk9iOXlWY1NZY2xqWC9QWWhYNm5NQ2tOSUdlZlFzMXFFMXQ3?=
 =?utf-8?B?T1FsQlpwOVZSUzdUT1Q4QXN3ZDBnWWR2WUhvY2tMWmU0NlJhNzI1WUc2TE5I?=
 =?utf-8?B?dC96L2pUbUpwWnkzekZYaGZ0MXBGTTJzTmZ1ZmVUQmVTZEZEZ3luNTVybzYy?=
 =?utf-8?B?YTdURlhqSkdvV2ZxbWVJbU9EUHF5bisxRzlyd2RQK1N3dnVLV3QzUHJaNE1x?=
 =?utf-8?B?NmxkT29RWXNZZ2ZUVEhhQjA4VEczTFVwOU5ENndPYk9XZG9RYy82ZlBhbDZU?=
 =?utf-8?B?UmpScDZsaDJ4czJQdjVpNE1DeXFKbW5PWXV4N0dLcXFNbWV6VHZLYXg3b2J0?=
 =?utf-8?B?a0FzYWkrdnhRam9XRVBpcE4xVjZLRlhiOHJQUnplYTBRZjNtV3RkVTVNSWd2?=
 =?utf-8?B?VUl2SDdvQVU5QXdqczE0UHI2V0hacGVBcVUxK2ZQNThURzBlRDlXQUI0b1M1?=
 =?utf-8?B?MG5SYkZJeHNSMERoWmNsVE5oVkQ2VXd1MDBPb1pLdVVHaUdod2ZwZFNLdS93?=
 =?utf-8?B?RnRTOFNKMnRRSjA1R3ZBSkx6UWNDMnNDeEJHeExwMVgwY0lwNzVnWkJaemZH?=
 =?utf-8?B?bTFTZDl4ZkdKMytDcEoyMndpTnBocHIrSzFTV1R3Tjd1aCtJS1pCbUp5b2tp?=
 =?utf-8?B?QnUrTHB4NFl6cm5ITGZaellQQ08xZWkvcWQ0MlY1Um5kSTRDcXk1aFF1SURS?=
 =?utf-8?B?WlE9PQ==?=
X-MS-Exchange-CrossTenant-Network-Message-Id: faade402-165a-4acc-cf02-08ddea670e32
X-MS-Exchange-CrossTenant-AuthSource: CO1PR11MB5089.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 02 Sep 2025 21:24:09.9965
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: lKZPy+ROUs3Y80omOyKwG0GeO0jeUM+5KeJd+7+JfOmQV8MK4L9O89g8PkvMzZt3kxj1QyJAIW9ST8GYwg+lljOVrlZgzkDTAkHtisjX02Q=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS0PR11MB7926
X-OriginatorOrg: intel.com

--------------gJTHodK5fGpWOaIkYLsHuk3y
Content-Type: multipart/mixed; boundary="------------J1XHtNwYoKry8AORgleNyu43";
 protected-headers="v1"
From: Jacob Keller <jacob.e.keller@intel.com>
To: Saeed Mahameed <saeed@kernel.org>, Jakub Kicinski <kuba@kernel.org>
Cc: "David S. Miller" <davem@davemloft.net>, Paolo Abeni <pabeni@redhat.com>,
 Eric Dumazet <edumazet@google.com>, Saeed Mahameed <saeedm@nvidia.com>,
 netdev@vger.kernel.org, Tariq Toukan <tariqt@nvidia.com>,
 Gal Pressman <gal@nvidia.com>, Leon Romanovsky <leonro@nvidia.com>,
 Jiri Pirko <jiri@nvidia.com>, Simon Horman <horms@kernel.org>,
 Vlad Dumitrescu <vdumitrescu@nvidia.com>, Kamal Heib <kheib@redhat.com>
Message-ID: <5056c692-7478-4f38-8859-7cc7c823bbf5@intel.com>
Subject: Re: [PATCH net-next V6 01/13] devlink: Add 'total_vfs' generic device
 param
References: <20250709030456.1290841-1-saeed@kernel.org>
 <20250709030456.1290841-2-saeed@kernel.org>
 <20250709195331.197b1305@kernel.org> <aG9RuB2hJNaOTV3e@x130>
In-Reply-To: <aG9RuB2hJNaOTV3e@x130>

--------------J1XHtNwYoKry8AORgleNyu43
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable



On 7/9/2025 10:38 PM, Saeed Mahameed wrote:
> On 09 Jul 19:53, Jakub Kicinski wrote:
>> On Tue,  8 Jul 2025 20:04:43 -0700 Saeed Mahameed wrote:
>>> +   * - ``total_vfs``
>>> +     - u32
>>> +     - The total number of Virtual Functions (VFs) supported by the =
PF.
>>
>> "supported" is not the right word for a tunable..
>=20
>  From kernel Doc:
>=20
> int pci_sriov_get_totalvfs(struct pci_dev *dev)
> get total VFs _supported_ on this device
>=20
> Anyway:
> "supported" =3D> "exposed" ?
>=20
>=20

The parameter relates to the maximum number of VFs you could create. It
sounds like this hardware by default sets to 0, and you can change that
in the NVM with external tools. This adds a devlink parameter to allow
setting to be changed from the kernel tools.

exposed seems reasonable to me. You could also have language that
explains this is about a maximum, since this changes the value reported
by pci_sriov_get_totalvfs. You still have the usual means to
enable/disable VFs via the standard PCI interfaces.

--------------J1XHtNwYoKry8AORgleNyu43--

--------------gJTHodK5fGpWOaIkYLsHuk3y
Content-Type: application/pgp-signature; name="OpenPGP_signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="OpenPGP_signature.asc"

-----BEGIN PGP SIGNATURE-----

wnsEABYIACMWIQQgQFSp1zOQVirsQx5qll0+bw8o6AUCaLdgdwUDAAAAAAAKCRBqll0+bw8o6H68
AQDERFBIZT2NQpZnFo6aFPxY3625n4xCRoa7Y2XgbwAgDgD+MHWpyDg5qtDmyYkI0Kx8Lp1Fd9ET
UGZh88UqbpfHmQM=
=EOyW
-----END PGP SIGNATURE-----

--------------gJTHodK5fGpWOaIkYLsHuk3y--

