Return-Path: <netdev+bounces-219328-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 86AB2B40FAC
	for <lists+netdev@lfdr.de>; Tue,  2 Sep 2025 23:57:48 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 2DE62547F3F
	for <lists+netdev@lfdr.de>; Tue,  2 Sep 2025 21:57:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3851E2E040E;
	Tue,  2 Sep 2025 21:57:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="dc24E55J"
X-Original-To: netdev@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.8])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3408F221F17
	for <netdev@vger.kernel.org>; Tue,  2 Sep 2025 21:57:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=192.198.163.8
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756850264; cv=fail; b=KXxMeuHFu0h7PBJmFrra3c+8LW5CPhHfoLzpd4X2DDEF7KmwnQE3W5ypzxJAuyIVPLhWgxn3zrlrjUafdH/hpSj3udwtV6tLEbFfWA0dlf6xHqaahrilTf7qtlqi1jrLhrkwv89KGmhQKDfItRlfkNkQr1Xaf+vqNt+yLj2iRnY=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756850264; c=relaxed/simple;
	bh=vs/2UPIPUUyHhh1gi2bmfmojI6QYEKsKlsbqkFNw6Tg=;
	h=Message-ID:Date:Subject:To:CC:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=Q3YVUAa6hvQLy+H8YE8BmjfuN3//mSVVWpJ8FGVzQMuOZvcruQC40B5Boqum8e61ILHFvq7K/RsF7+fti7Wsi/w0aE/yVfZmdOleKqZkMHL3BFty5ZLg8iVMoWL4cI/bzPxLabPXM3KyrzOvVDf3ZB7as0JSsfrssSI7krjZzmc=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=dc24E55J; arc=fail smtp.client-ip=192.198.163.8
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1756850262; x=1788386262;
  h=message-id:date:subject:to:cc:references:from:
   in-reply-to:mime-version;
  bh=vs/2UPIPUUyHhh1gi2bmfmojI6QYEKsKlsbqkFNw6Tg=;
  b=dc24E55JOzKu/4LpXeh5zoDOktJs1taOVC2LLM1aHMUkxgJPc1nG8awV
   5j6c19SHUoqZp2N4P/FHt/Lm0OHeMCbA6XgFnuopw1RDBCFqs9Kwws+P4
   Bd0l3jIFnnopkMPS/oFyzqC3CPltffDI35sjuMYVm6cXC9LGKda7cF+I+
   jzhlx9GwbtsNplPZVywdGunwtaPx3d9Y+6dDdZNvQjXdTuyDe7btCK6RS
   BhYfv7XvWSEqxT8S6N9J0GWmZcBOEEv9lcjjgkAjfAUjAs/tWXBeYyxoE
   1x480w79AZ6zrD/xlwpSte8HBhoO03pQkQtpOoLZfeezlA1Gt6he/24RQ
   A==;
X-CSE-ConnectionGUID: Sa2msSF5RZmm009/oggz0w==
X-CSE-MsgGUID: n7uIaMByTyqV7m/iizytsg==
X-IronPort-AV: E=McAfee;i="6800,10657,11541"; a="76749175"
X-IronPort-AV: E=Sophos;i="6.18,233,1751266800"; 
   d="asc'?scan'208";a="76749175"
Received: from fmviesa004.fm.intel.com ([10.60.135.144])
  by fmvoesa102.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 02 Sep 2025 14:57:41 -0700
X-CSE-ConnectionGUID: uSQUPhJvQQOMvGgzSO9J5Q==
X-CSE-MsgGUID: YG+q00ICR7CXuSBbGp/2BQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.18,233,1751266800"; 
   d="asc'?scan'208";a="176669440"
Received: from fmsmsx903.amr.corp.intel.com ([10.18.126.92])
  by fmviesa004.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 02 Sep 2025 14:57:41 -0700
Received: from FMSMSX902.amr.corp.intel.com (10.18.126.91) by
 fmsmsx903.amr.corp.intel.com (10.18.126.92) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.17; Tue, 2 Sep 2025 14:57:40 -0700
Received: from fmsedg902.ED.cps.intel.com (10.1.192.144) by
 FMSMSX902.amr.corp.intel.com (10.18.126.91) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.17 via Frontend Transport; Tue, 2 Sep 2025 14:57:40 -0700
Received: from NAM04-MW2-obe.outbound.protection.outlook.com (40.107.101.80)
 by edgegateway.intel.com (192.55.55.82) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.17; Tue, 2 Sep 2025 14:57:38 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=FzfY0F14aJEMMhInYLajkG2zH4zzn5RBPDuGt1kBQpDxCeV3RD9Xjszx2G0tj6l15dXgAvwZjRu/4mdG4S8+7Y9MWutJGqUZrxdzzC6THVSys37Qf4JOvF8wR0nwPQFhN4RvlXHm2u/MvuMKhByc6HcihHV7Oc87fTzzJ/UIU0j6JbosIpR08WMOsp2Vu/YBEufubcDXdP/oo5GCq2NpEZvnQhOm7K7KKvQOFw+QEOyzC+RZQHMgBO8feRafRHGF9zbpRfQslndu+zuZaXsxi0zz3ukhEaER/R7MBzB6lXGeKdcWUdw8q04LsBMjxmGCkjVY/XSz1pueOstzZOc9Xw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=MzmwDG+bOSqd5Z4CE4UPKCn7t+Wmjj1rNm/uHOgQamE=;
 b=sneAjIHeooU0B81O0NkGtKvwxjo300hX/t7Ujbul/WOa+gE0MwOnxwAMxK9fWtDMHPluw2qriRDU8w00tvPoQ4ZqkcIpPkKirjrxlIqUAG3tzaAqOJwdz3odHzJC9ZPKeQ1nuEjHhBNynTbaz1AfKl/XweUki86xEPZirAaPvRDCaEX2HhgaJDyoXCjcX6KgE566oqptw2gWT6vKMYfiTgykcFPxkb8/CdolVdCkP8MoprMnPU3U4fRkR4aQ56RqlmtAdrD7qkxdklHJl4uH/UhIcY5gq7orPl0ZRC01V6vQk/oIKAnxxGO2FqzdqQneagzMcsdEDr2i+BM4BLGOxg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from CO1PR11MB5089.namprd11.prod.outlook.com (2603:10b6:303:9b::16)
 by CH3PR11MB7868.namprd11.prod.outlook.com (2603:10b6:610:12e::5) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9094.17; Tue, 2 Sep
 2025 21:57:36 +0000
Received: from CO1PR11MB5089.namprd11.prod.outlook.com
 ([fe80::81f7:c6c0:ca43:11c3]) by CO1PR11MB5089.namprd11.prod.outlook.com
 ([fe80::81f7:c6c0:ca43:11c3%5]) with mapi id 15.20.9073.026; Tue, 2 Sep 2025
 21:57:36 +0000
Message-ID: <abdde2b3-8f21-4970-9cf3-d250ca3fb5c6@intel.com>
Date: Tue, 2 Sep 2025 14:57:35 -0700
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net-next V6 09/13] devlink: Add 'keep_link_up' generic
 devlink device param
To: Saeed Mahameed <saeed@kernel.org>, Jakub Kicinski <kuba@kernel.org>
CC: "David S. Miller" <davem@davemloft.net>, Paolo Abeni <pabeni@redhat.com>,
	Eric Dumazet <edumazet@google.com>, Saeed Mahameed <saeedm@nvidia.com>,
	<netdev@vger.kernel.org>, Tariq Toukan <tariqt@nvidia.com>, Gal Pressman
	<gal@nvidia.com>, Leon Romanovsky <leonro@nvidia.com>, Jiri Pirko
	<jiri@nvidia.com>, Simon Horman <horms@kernel.org>
References: <20250709030456.1290841-1-saeed@kernel.org>
 <20250709030456.1290841-10-saeed@kernel.org>
 <20250709195801.60b3f4f2@kernel.org> <aG9X13Hrg1_1eBQq@x130>
 <20250710152421.31901790@kernel.org> <aLC3jlzImChRDeJs@x130>
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
In-Reply-To: <aLC3jlzImChRDeJs@x130>
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature";
	boundary="------------a9hb0cnAhjGGp7Fwmim7RCW5"
X-ClientProxiedBy: MW4PR03CA0178.namprd03.prod.outlook.com
 (2603:10b6:303:8d::33) To CO1PR11MB5089.namprd11.prod.outlook.com
 (2603:10b6:303:9b::16)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CO1PR11MB5089:EE_|CH3PR11MB7868:EE_
X-MS-Office365-Filtering-Correlation-Id: 83f9c464-79a3-4c56-8661-08ddea6bba57
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|376014|7416014|1800799024;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?cnNwbHNUL2xLRHo2RUNPbTQ0Nytad2g3UU5RMmRmTy9mYWhFSFRIUkpkZzg0?=
 =?utf-8?B?YWNxRGVhdzF1ekE5VDJzZ0cvRkhaWFh4V0hwZ2lySHo2SExGTnBMMmRGanZs?=
 =?utf-8?B?S21vWHhmSStGRHFuSlBqVTBuN3JkZXgzM2hrVzBFQWRTMFVXSGVESG9jUWhD?=
 =?utf-8?B?N0tmNWs1akdXdkViYjEyVjJpVGZWVUQ0OGtpamZ0eU5JcDFrSnUvRFk2RkhQ?=
 =?utf-8?B?d0MzSDRTTmpmUFRVNWZNaS9oVlpCaVRRQkV4SWh4VWdEVGJpaEJmMU05MHNy?=
 =?utf-8?B?bjZtQ2tPcTY5dmJMN3Uzd1FpdzlWZXpGdDBNMTBralZFOVFKQmo0aU1FVmsw?=
 =?utf-8?B?TW5RK1hqSmZkVTJKZm5xOFphbThVdFN4M2F2WjQ5QTFIYmRCenB1VGs5bmlU?=
 =?utf-8?B?eUVTbUJ3UnZJWXp3MGpKZzFIazR6d2FVR0hCakQ1aVZVWFZ4V1RKUGdGUWp6?=
 =?utf-8?B?V0dRVk1LTWpjVm5xT3Q5N2VXQ1FrbzlPN2pXQ016UlFMSElSb050T2R2WWZp?=
 =?utf-8?B?enZRVjJQRExsNzZVZ1dqajFWZVBlWGIwaTdZV1d4WkcvSGhGR3pwdGRHbWtE?=
 =?utf-8?B?QzQ4U2ZDL1dVRFdEeXRMZ3dLTG9nZkdpMFpJQkVFU1FtZUl1ZGdsT3VESHJo?=
 =?utf-8?B?M2h2WlMyN2xuYUhXY3dPYUg5QW1DZnVhU0RxTUVMenJlbzZNUXV5M0hXWFNK?=
 =?utf-8?B?ajFaazUrc3oyQ1RuZ1Y2ZlU5VjZwTnROT2t1STVudFZ1ODRQZmhqblArNG1h?=
 =?utf-8?B?eVdHSGNjSzlpdUJnNkRPT3crWFNSSlBSaW5td1pnSmlhUXZ6ME5XeVl1bFhm?=
 =?utf-8?B?M1NQenhSS2wyQnVPN1Z0MCt3Z0N1d05YcmhBczhTV0hTa1FHKzNHdmljR1hP?=
 =?utf-8?B?OWRQU3UvcTFONWVoVDB4elZFV3dKMEFISnBBVVpROWFTTnF0bEdUbmVhcTI5?=
 =?utf-8?B?UDR0Umwxc2MyZmZETUdOeWZBTUFyZHdLV0xYQkJ6SUVxQ1VhUGxuODZ3bDhx?=
 =?utf-8?B?bWs4V0RqSmlVSitaN2t2bmZFS2xHVHV4dEJVL3Ryam5GZnZhdlJoYTlkcmll?=
 =?utf-8?B?QUZsaUhuRmplN1VEVUpzak9CMi94VU1qU0lndXpuSEVBT2hmeVg0Y2Rta2Y0?=
 =?utf-8?B?cTNjSVl4MjYvQlcwVUo5V082YStxYzBHWmgvQThibytobjBLSzZ2YmZkdVNn?=
 =?utf-8?B?M1F5bjdDanhPNmFpdCtkTlFpSmZnZk82cTUzdWh5RlhWaWtXRDZTVlhNMUwr?=
 =?utf-8?B?MXVEa3RGWlBma0ZoN2VUWkdoL0Eyd0hUU0dvWU5pZ09MMGdpeDZpQmp5Qmdu?=
 =?utf-8?B?OTdDNDFMRlNtMndvdGpTSUwvNTA4MTJRT3Y4aVNqSlRDb3NDbHZmclY1R3dX?=
 =?utf-8?B?N3ZOaVhVZkFtNDFGWnlDcXFjVml1YTNlN2hvOUlwT3V2ZzI0ZHJoOUpJajV0?=
 =?utf-8?B?ZDBEelZFS1BVa0U1ejF6VzZacS9PaitNYjYzcytRaWs5R2JNREZYTjVyRmN4?=
 =?utf-8?B?eEorWW9oT0dUWXZYdUtJWkZNUURZVWJRMU9jVDdKSnNBYlcydEdNcnBpempu?=
 =?utf-8?B?VWhuY3BCVG1HbXQwMDdKd256NFJHMElCRUxDeHJTRnUyek8zelg0WkpybGho?=
 =?utf-8?B?RzZiVGFQTDE3a3dPb3RsOXl3SElGU2ROYUJ6dHFzR3FVYjUyMUF2UU9EZmdV?=
 =?utf-8?B?cEVtd0dmbFg4TDNsQzJyWEZRMXNRdEZweTRId0p5Ri81OHV1cDhSZExueEZj?=
 =?utf-8?B?bnR0MmxYVjZJOSswcEhpSWQrWlg0bUsycERXN3ZJV0ZiOHRBZUNnQnJEazZs?=
 =?utf-8?B?ZkdtbTdIZXFXUUNXbXB3T0w5R0FxNjI5dm9oTEYyRjFhUFRiM3hNVkR6amtG?=
 =?utf-8?B?RlNFV2I1NnpWZFZ6eEJSTkRmeHhBRmY3czRrbWg1R3R0aWJod2g1MjQxMWZJ?=
 =?utf-8?Q?yJ7HjYRVmoE=3D?=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CO1PR11MB5089.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(376014)(7416014)(1800799024);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?QXNCeVRyS1NKek5aVnBibFJuYzN6RTRnOCtVZTZWdEQ3SHh6V2k2ZEJlQjk1?=
 =?utf-8?B?R3AzbnIvZDlqY2tmRkpVN1haM2tuY1VJMGdKaEkrY0ZqTGQxVEdLeG9hRFIv?=
 =?utf-8?B?dlpmY3RFK1JMSS9ubWVtVkJYWFZqQXorUmhjMmVROUVJYVZtb3hrZDdSNXVT?=
 =?utf-8?B?dmVSa3NuTzFPLzFIRGNnakxxMDZxVGl2L0ZDK1BUdlBPTUJDbU9VR1l3aXJL?=
 =?utf-8?B?cTB5N3RzQTc2QUYvUTNXcWNGaVVFei9ac2RkdlphSmNiZm96VytPQW5nUThH?=
 =?utf-8?B?NnpjaVJlQURFRC9YTUVGTVJ4Qk1yOVBHSGVxSFhHbHpVM2l6NCtLWmZORzRq?=
 =?utf-8?B?anVMQ0l3aGZkOGZUM0dyb1NvZCt6NFNtT2xlTzdrY1ZKTTZ1aTlWNVVhRFhS?=
 =?utf-8?B?Y2h5VjVWMy9PRVZzcFMvTnpGa00zTzJuTFExSmxqa29qbnN6UVVjWXFSVTF4?=
 =?utf-8?B?Ynlmb3NxSnFTMGZqYXdsQktEMEFQaUVuRkJtY21rZ2NvdDk1V2VOK20vNHl1?=
 =?utf-8?B?UFdJZzZVaUFUU2xrZWxvUWd1OHpHWHRwcitwOHFhL1pOZEE1UzdoKytpRi8x?=
 =?utf-8?B?Vmk3cENVMG5zcXVzS3Ztak1JWUhVOER4Wk9MNldqbUIrTjVEWmMrZlF2b21q?=
 =?utf-8?B?a2pwN3Qwd0llRlV6U3p6cmpEaFNzdUZCUzQ3Z3AvNkJGZkZqRXBIdWF0VmZk?=
 =?utf-8?B?V0VFeXlLd0kzZ01FcnEwL1JaNWFBSTJZQXBCMUpXbWFGUVZMc1JDeC85T2pW?=
 =?utf-8?B?bVZObnRCRFR6dTU2ODEycnlJdXd0cjQ3VVdpNVlwSlRES216amt0TENDcWV4?=
 =?utf-8?B?V0dua3ZlL3NTOG5LZHcyWGJLcGgxYSttd3RwKy9ZZVJBajA0M1lObGlHNXJ4?=
 =?utf-8?B?bHNQQmppUERzSmFEY0ltaCtTVmxBTEF0TWdXR3dUekk0V3AxTGZ2ZFAzV3RM?=
 =?utf-8?B?dGkwUC9QQ3F6dVp2MHhrVUo2a1d4eW5DOXFkaW96eVU4czhqNStvaUdqNEYx?=
 =?utf-8?B?YmhMQ1o5QVFFRGNBNC9xdFp4N2lleml3TEVvWS9SUG1QQmtoQkY4NFVnVVBa?=
 =?utf-8?B?UmRVS0wyYStSelRKWXZQZGpobEtBZFp0RTdzeitKNWtpdVdzdTlqSGtqbi9K?=
 =?utf-8?B?SU9PK05mY1A5WWZQZHZnRE9uVVlrR1RpK3F0eVRXWmd0L0dpbjVrUmZoMWdw?=
 =?utf-8?B?ZnA4VjRHeUsyQ2pPMjAzY25RVy9VTGIwRkJzc1p0SnhkdVJGeUE2VkZHYkNy?=
 =?utf-8?B?MHUvMlcwWXVFTTh4cEtHSC9PU3MrNzhTQjR5cEdmaUs5V0crMkJVYit4ZGxZ?=
 =?utf-8?B?T0ljbVp4SThPcmFyZEErMWFBZXBqS3MzMUxESXJpTTVXL1pHSFl6NjA3bWFn?=
 =?utf-8?B?UzRCc3FOOUtpY29zSHBQNEJvYW5pcS85eXBaZ0Z3WTZhdUkvV2Jzem9qblhz?=
 =?utf-8?B?ZEUrdWZXYVVvc2xXbXNXejY2NFBUdXhHY2FVaVNWcEQ1Y3d6TU1yKzZFTTBC?=
 =?utf-8?B?RUVyaVRoT1VIeE1QcjlrMXJRTWJxM3cybUN2RjB1dWp0M1NHcEt6aCsrMURC?=
 =?utf-8?B?WUJVK0pTOTloUUZJSWxjYWRQRW80VGxvYUYzNmtQaHpqd3k0RnI2MklhZmQ3?=
 =?utf-8?B?VnNkVjR2TjVSUEdWUWdvQnlwWkFJaVFPcjB4MFIxekVwREt6SlM3ZDRKOWhx?=
 =?utf-8?B?c0RMUjlrMmdheE0wZzZjc3RXa1NwellCR05BSTN4dk9jNFd0SkUyRk96RURW?=
 =?utf-8?B?UXVOdHpCMTRZYXNhai9hWVA1MjZrRk9TNlBrSmR1R0FMQUtrUU5wUFN0N1JD?=
 =?utf-8?B?NXhXOFEycTJtbGdjYW9TT2lUcEU2WEg3M2xDWEQvV0U1UzNQTU1ma21YSEhS?=
 =?utf-8?B?Q3BWTGVRMmk2T29jOVlhSW9aVXFCMWdWbGVtdzNnbFRhTWx1WkMxNkQ0dVM2?=
 =?utf-8?B?V2ZhWmJ5NTdMOFdaNm8xZHVRdTQvOWsvWG5Ia29JbW5vMDJrWEtIMktNcDZy?=
 =?utf-8?B?djk1MHdKOUsyL0ZlK0o0YmtmaUFtOEVaS08wbExJZzhWWGEycFcrY1htSlBQ?=
 =?utf-8?B?Vkk2SUpRU1BUZVpHbnl1Q1lsTTdJdnlQNDcyOWE1dVRVQ1pmTnRqMTdKWmpl?=
 =?utf-8?B?d2FlOVNwY0ZFeU9UQlRSWHNvR0NvZkZiUU1RUE5jaWtMR0NIU2pLVTRRQXZU?=
 =?utf-8?B?TUE9PQ==?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 83f9c464-79a3-4c56-8661-08ddea6bba57
X-MS-Exchange-CrossTenant-AuthSource: CO1PR11MB5089.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 02 Sep 2025 21:57:36.7421
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: fezjqin/jpfdrnWVS9aYOT8kK5AuJVYBmdKcqKgeV9byWC2Ge9zK+lXeoHDOlQY9ihQydwEKWkXfrOWvNPQ9aMFzbZ1AUYeAL5GzraedD6U=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH3PR11MB7868
X-OriginatorOrg: intel.com

--------------a9hb0cnAhjGGp7Fwmim7RCW5
Content-Type: multipart/mixed; boundary="------------BKHKKKZSXOYhS781eIFovpgo";
 protected-headers="v1"
From: Jacob Keller <jacob.e.keller@intel.com>
To: Saeed Mahameed <saeed@kernel.org>, Jakub Kicinski <kuba@kernel.org>
Cc: "David S. Miller" <davem@davemloft.net>, Paolo Abeni <pabeni@redhat.com>,
 Eric Dumazet <edumazet@google.com>, Saeed Mahameed <saeedm@nvidia.com>,
 netdev@vger.kernel.org, Tariq Toukan <tariqt@nvidia.com>,
 Gal Pressman <gal@nvidia.com>, Leon Romanovsky <leonro@nvidia.com>,
 Jiri Pirko <jiri@nvidia.com>, Simon Horman <horms@kernel.org>
Message-ID: <abdde2b3-8f21-4970-9cf3-d250ca3fb5c6@intel.com>
Subject: Re: [PATCH net-next V6 09/13] devlink: Add 'keep_link_up' generic
 devlink device param
References: <20250709030456.1290841-1-saeed@kernel.org>
 <20250709030456.1290841-10-saeed@kernel.org>
 <20250709195801.60b3f4f2@kernel.org> <aG9X13Hrg1_1eBQq@x130>
 <20250710152421.31901790@kernel.org> <aLC3jlzImChRDeJs@x130>
In-Reply-To: <aLC3jlzImChRDeJs@x130>

--------------BKHKKKZSXOYhS781eIFovpgo
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable



On 8/28/2025 1:09 PM, Saeed Mahameed wrote:
> On 10 Jul 15:24, Jakub Kicinski wrote:
>> On Wed, 9 Jul 2025 23:04:07 -0700 Saeed Mahameed wrote:
>>> On 09 Jul 19:58, Jakub Kicinski wrote:
>>>> On Tue,  8 Jul 2025 20:04:51 -0700 Saeed Mahameed wrote:
>>>>> Devices that support this in permanent mode will be requested to ke=
ep the
>>>>> port link up even when driver is not loaded, netdev carrier state w=
on't
>>>>> affect the physical port link state.
>>>>>
>>>>> This is useful for when the link is needed to access onboard manage=
ment
>>>>> such as BMC, even if the host driver isn't loaded.
>>>>
>>>> Dunno. This deserves a fuller API, and it's squarely and netdev thin=
g.
>>>> Let's not add it to devlink.
>>>
>>> I don't see anything missing in the definition of this parameter
>>> 'keep_link_up' it is pretty much self-explanatory, for legacy reasons=
 the
>>> netdev controls the underlying physical link state. But this is not
>>> true anymore for complex setups (multi-host, DPU, etc..).
>>
>> The policy can be more complex than "keep_link_up"
>> Look around the tree and search the ML archives please.
>>
>=20
> Sorry for replying late, had to work on other stuff and was waiting
> internally for a question I had to ask about this, only recently got th=
e
> answer.
>=20
> I get your point, but I am not trying to implement any link policy
> or eth link specification tunables. For me and maybe other vendors
> this knob makes sense, and Important for the usecase I described.
>=20
> Perhaps move it to a vendor specific knob ? or rename to
> link_{fw/soc}_controlled?
>=20

Intel has also tried something similar sounding with the
"link_down_on_close" in ethtool, which appears to be have made it in to
ice and i40e.. (I thought I remembered these flags being rejected but I
guess not?) I guess the ethtool flag is a bit difference since its
relating to driver behavior when you bring the port down
administratively, vs something like this which affects firmware control
of the link regardless of its state to the kernel.

>>> This is not different as BMC is sort of multi-host, and physical link=

>>> control here is delegated to the firmware.
>>>
>>> Also do we really want netdev to expose API for permanent nic tunable=
s ?
>>> I thought this is why we invented devlink to offload raw NIC underlyi=
ng
>>> tunables.
>>
>> Are you going to add devlink params for link config?
>> Its one of the things that's written into the NVMe, usually..
>=20
> No, the purpose of this NVM series is to setup FW boot parameters and n=
ot spec related
> tunables.
>=20

This seems quite useful to me w.r.t to BMC access. I think its a stretch
to say this implies the desire to add many other knobs.

--------------BKHKKKZSXOYhS781eIFovpgo--

--------------a9hb0cnAhjGGp7Fwmim7RCW5
Content-Type: application/pgp-signature; name="OpenPGP_signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="OpenPGP_signature.asc"

-----BEGIN PGP SIGNATURE-----

wnsEABYIACMWIQQgQFSp1zOQVirsQx5qll0+bw8o6AUCaLdoTwUDAAAAAAAKCRBqll0+bw8o6Dg2
AQD0X7per9dnFO94OlnTAtBD5zmvQZGn+1DXnYJgLW9bhAD/c7BWtwb9uYDhxRcHxvX+F8rOkJ5n
db1uPUlE+eSQpwA=
=UWAF
-----END PGP SIGNATURE-----

--------------a9hb0cnAhjGGp7Fwmim7RCW5--

