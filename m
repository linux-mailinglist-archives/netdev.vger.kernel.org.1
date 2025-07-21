Return-Path: <netdev+bounces-208726-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 84311B0CE7E
	for <lists+netdev@lfdr.de>; Tue, 22 Jul 2025 01:58:10 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 425616C1E94
	for <lists+netdev@lfdr.de>; Mon, 21 Jul 2025 23:57:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1BCB2248F55;
	Mon, 21 Jul 2025 23:57:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="dzVEnCNn"
X-Original-To: netdev@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.10])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 25201248F52
	for <netdev@vger.kernel.org>; Mon, 21 Jul 2025 23:57:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=192.198.163.10
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753142273; cv=fail; b=HTLTov6sDvtrmmVoFbI3jZSpERR2oE7wL6RJBUgtTpe/AsWCsL5nOgcmy6cfaF4iqndFzY7l2kumTonkp2dhNXmoOfRee3+tqEvEnAiOXf9UZ62A3u5HlfOql734dEKphxGnlb4J/w1pM8rkXemiorSeM+/UBUcynfBOXKk89s0=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753142273; c=relaxed/simple;
	bh=QzFpHV5tcnlU4T7cJh0EScI1P95neKh7I9sCEbcmAPY=;
	h=Message-ID:Date:Subject:To:CC:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=IWdPlNI1dUQa39lZC6fXuAV92X0IuGWAlAXSpLxt2xR9ivzMy5StRdEMLGuKvsQaDD4LD25J92LdPy1izX9d0T3A0X15QYyEIuvu7lwMSbnb70MR+JGVZSVjHmYsOUyN/EpxX2LXemDgv+47ZaoRpT9MxZv64nEu8H85MxVHcOk=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=dzVEnCNn; arc=fail smtp.client-ip=192.198.163.10
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1753142271; x=1784678271;
  h=message-id:date:subject:to:cc:references:from:
   in-reply-to:mime-version;
  bh=QzFpHV5tcnlU4T7cJh0EScI1P95neKh7I9sCEbcmAPY=;
  b=dzVEnCNnZiUf3HWOS/zY3d5H7Ke6EsEiGiOzs3IsQc987q3KVLjxkAW5
   aSOZPECkKoEjysQTWZHVDceHLsQsUaTds4aVaGWx+7JUvBSs/QM0PKTt+
   uC+ky6iC4f61FsHS6LTL/XptZq9l2tJBSxb9xm36cYLgUKJ2EjwvVOlmR
   tqEyJfq4/B8dI6HnJK27+BRm4nyrGHcYvIgqyI9Q0HY6bkcJx3l25VH4J
   mp6F+TgyL8TZKzj7inrm2VbpAt0lNw/ykjax31Ri6OU4ejnVNvf+et0c4
   B0zf6ZipvdXyOtcJF17slQMGMi6zgy0PF3IwuaYT8yWSV5EIrh8Dj6HY5
   A==;
X-CSE-ConnectionGUID: pQHwl9ltSBiE5LOX5RHb5Q==
X-CSE-MsgGUID: 1d/XiFHzT9yUrmF+eQaTzg==
X-IronPort-AV: E=McAfee;i="6800,10657,11499"; a="66720007"
X-IronPort-AV: E=Sophos;i="6.16,330,1744095600"; 
   d="asc'?scan'208";a="66720007"
Received: from fmviesa006.fm.intel.com ([10.60.135.146])
  by fmvoesa104.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 21 Jul 2025 16:57:49 -0700
X-CSE-ConnectionGUID: Gwc/YI4UTxeQ9Sh7IBzWKg==
X-CSE-MsgGUID: 3l00zlBJTxOdVohS/GjYfg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.16,330,1744095600"; 
   d="asc'?scan'208";a="159024171"
Received: from orsmsx903.amr.corp.intel.com ([10.22.229.25])
  by fmviesa006.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 21 Jul 2025 16:57:48 -0700
Received: from ORSMSX902.amr.corp.intel.com (10.22.229.24) by
 ORSMSX903.amr.corp.intel.com (10.22.229.25) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1748.26; Mon, 21 Jul 2025 16:57:48 -0700
Received: from ORSEDG901.ED.cps.intel.com (10.7.248.11) by
 ORSMSX902.amr.corp.intel.com (10.22.229.24) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1748.26 via Frontend Transport; Mon, 21 Jul 2025 16:57:48 -0700
Received: from NAM11-BN8-obe.outbound.protection.outlook.com (40.107.236.63)
 by edgegateway.intel.com (134.134.137.111) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1748.26; Mon, 21 Jul 2025 16:57:48 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=xiyss8RwfWA4IbccExQ4Sfz0PKKBaa2g625SyVVu9GAckj2myJV3KwFhoYHr8SJdH5hjUs8B6dpbq5pCo2HHP+KnTl7C4bXWha87eAz8q4daM9bYotD1+Dh9vkFJCz6INVwXZkk0nv5fUsrsPxoi5rYTncYLLqzwZwcSJbnTbebzQLlKjIr054MN5JSyXW5vrSLAaywAXiaawVrwODHeCplOZCn8UfdwgA/BWW4xxLKYxii/kwrT4yeqnqAepc3tBtVanICx4QeFajkqcOzBfFLRhhtvFYk9Mh2/I2e+8kKUHFJXeZc+rpUMSOUT9Xct+2/bMATxe3JmHZn0GBrhfA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ExGKURqcGHl+BDJvS7FtEZcYeUxtzqH7GxvAfty7WV4=;
 b=V9PXG+ihViBFH4Tv/UGUh4VpABA9VUcIaZUwg82b3PyP89AVsVgOzYdZX0umheo7JMa5meYHwyRcCkNNezGPhJjg8ygXf2QGz8c0BT0vEMVTjcbozsuvIulUftZO1nUWEBnSXfAswW/JMd/y8eLsrvH5QWbmIWiEzecuyRBMf1xMVPysZcumNZLw8wrSmcnj09vw3KvCUbz7P7A53577aHaMAOk3hh4y4roPBZULuZmAq/z0sB1FQDsCYeDsBp0OPOw3RVHRU43fjjVU8z9E+nnN4WleIFWd3L1hLZIiRPmOBR7+MyF8m1kwyrWAkO9Ed+UU3ZvpAkOAVAPMYxNSQg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from CO1PR11MB5089.namprd11.prod.outlook.com (2603:10b6:303:9b::16)
 by DM3PR11MB8733.namprd11.prod.outlook.com (2603:10b6:0:40::5) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.8943.30; Mon, 21 Jul 2025 23:57:05 +0000
Received: from CO1PR11MB5089.namprd11.prod.outlook.com
 ([fe80::81f7:c6c0:ca43:11c3]) by CO1PR11MB5089.namprd11.prod.outlook.com
 ([fe80::81f7:c6c0:ca43:11c3%5]) with mapi id 15.20.8943.029; Mon, 21 Jul 2025
 23:57:05 +0000
Message-ID: <97f47ab9-638e-45e4-88be-b1bcd089c2c6@intel.com>
Date: Mon, 21 Jul 2025 16:57:03 -0700
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net-next v2 2/3] net: wangxun: limit
 tx_max_coalesced_frames_irq
To: Jiawen Wu <jiawenwu@trustnetic.com>, <netdev@vger.kernel.org>, Andrew Lunn
	<andrew+netdev@lunn.ch>, "David S. Miller" <davem@davemloft.net>, "Eric
 Dumazet" <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>, Paolo Abeni
	<pabeni@redhat.com>, Simon Horman <horms@kernel.org>
CC: Mengyuan Lou <mengyuanlou@net-swift.com>
References: <20250721080103.30964-1-jiawenwu@trustnetic.com>
 <20250721080103.30964-3-jiawenwu@trustnetic.com>
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
In-Reply-To: <20250721080103.30964-3-jiawenwu@trustnetic.com>
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature";
	boundary="------------nlMQDThd8YtPGXyx10BEvEJi"
X-ClientProxiedBy: MW4PR04CA0250.namprd04.prod.outlook.com
 (2603:10b6:303:88::15) To CO1PR11MB5089.namprd11.prod.outlook.com
 (2603:10b6:303:9b::16)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CO1PR11MB5089:EE_|DM3PR11MB8733:EE_
X-MS-Office365-Filtering-Correlation-Id: 90a38a60-b7e7-402d-b36d-08ddc8b24b63
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|376014|1800799024|7053199007;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?ZlRCTHpMK1JCODRlRkVLT2ZjQldlc2l6Q2pHY1F0WEdsNWVnc3JlYllLN3Vm?=
 =?utf-8?B?OWMxSzR2M1RwZnFhY1ViNDZMd09iRDM4RXR6aGw0VTU3QWhTckdjNDduRFc5?=
 =?utf-8?B?OURjY2VNYTQ5VmFEb1dRMGl3RkliL1BpM2krZXgwdEtKL0dUNVdpNERnSjN0?=
 =?utf-8?B?SGdEQ0MvUG55VHM0SFE3dmtaZnlkelp3K04reFYyQUxsV1d4M3VGa2FQNEtP?=
 =?utf-8?B?cVRFc09NV2pHcjlzMzY2MGpHSzM0RVlvVzZkNTFuc0taZCsxMG93RCtPejFC?=
 =?utf-8?B?R083amZadHY3YU5Kd2E1OW84NUg2N1lCVWV6V0NnNWZ6VnB6dUxraDBNK1k5?=
 =?utf-8?B?bmlHL0RSaG9tN3FqYkljaEdtVkdrc003KzZlb0FXN1Jpb1hXWXloQ3crYmNa?=
 =?utf-8?B?L1NISDJnVEFmcE9oY05KcWhuekd3Q0tBcWhWY09oY1owWnBOSE1qYmhweDNl?=
 =?utf-8?B?Y3pVR0k0ZUJWSlRLK28yR0pSWHN3UmthVmxZZDZqUlB5c3ArT1pYaSs4ampQ?=
 =?utf-8?B?cWtKRTFkWXIrWDlMS215MFRrOE9PUEU3TnZVVXRJOENMNDFEYUVZdDMyZ203?=
 =?utf-8?B?VUpBS0RWQk1kQlBHSTZKZkk5UTk5ZnZ4WHZuVElSczZteFpObE1aVlJueFFp?=
 =?utf-8?B?YjE5SU9vbEw1bnk1eWdwcTRKNzZrNk5WOTZ6Mk9yU1phY0RFdTUrSCtqNFZi?=
 =?utf-8?B?bjcvem44dzFsVG9ISytyMFQ0RUVISTd5bmRLY09SaVRXN3NTclRmNzFtTXJi?=
 =?utf-8?B?emdhZlhFWW5aTnVUQW9CMFlOdXFVdDNrOENidmxldlJvVkNsMW12RWl1a0ZT?=
 =?utf-8?B?OUxxcHpadExRWHBvbmtRT3UvNXVicEN6TkNHVk5WYnQ3eXc5UXdHSVo1ZUZI?=
 =?utf-8?B?bXBZWHlkT3hGa3IxT1I5eTJKVGY0Smpad2tGUDlKc1BrbUV3OWw0eXN2bTE4?=
 =?utf-8?B?QU1lalJndlRPN2NUMHZVemYzM25VejY4cVp0NzAwNGFDUWNVK3dGR0VnTmRh?=
 =?utf-8?B?S1RuZ1I1L2FLYjkzK3dxQklPb3lBT2RlYlh4Zzd3dVVzR2o0ZzRiQ0VsdUxw?=
 =?utf-8?B?SXJKUjZvUDhqOVBidjdHTURwUktaTytSbE1Xb2VhaFF3L0ZRZ0xHS09qUXJv?=
 =?utf-8?B?WnB3ekpQS3V1cCszalVYVlVleGtLUTR5UlRzYTVESm1nM1I3RWdQcE1XeS9y?=
 =?utf-8?B?NE1WbUVMdGhhY1l4K1NXVCtZRHYxQVpBcHJmMTdmMisxVXpBVnA5VzVmWXJM?=
 =?utf-8?B?VDBlRmxNQk42RGdYU1JXTlNVdUtJcERNQWg5SWVpMVdlZ3RvMGwvSmVnZ2JB?=
 =?utf-8?B?SGE3NVJ2dzhPSUd5UVRkN3Nmb0NXM016bkRCNWZPMllFMEpsNHlLV1R0Mi82?=
 =?utf-8?B?TXd2RXd0Vk5nR3Z6QjkzQVAyR3J0SGpVQ2Z6aVN5MWJSZGJTTzVQSFpJb0dF?=
 =?utf-8?B?NDlka3Z0czV5dGhZc2tJSTVZSlpqTTEwQlFaR0I0OXE1dW9qT1ZPK3RhVHJX?=
 =?utf-8?B?VFcxY3ZFWjRIeHRiM1VLbS8rOGt6a1gyOW14ZnpJL3IxRENTWHFIZGUyS3pw?=
 =?utf-8?B?SzVKTTZQd1UzRzdtM2pFNXFaSVRmM1pUUHJyUXpYb1FYck51NURLbDJTK2dP?=
 =?utf-8?B?eThYZFVxenl4NWUxQVNhbVZvTzRyQis4b0x4b2UyWHNwMkgwRnBXZ3BnUHkw?=
 =?utf-8?B?ODI5QURQTnlVcndWQVFtd2lTZUpYR0VEWk5zTk0vdjRVdGQ0Uk41dXhjMzEy?=
 =?utf-8?B?SEFYNkZPSFVmWWQ2VGtJS1N6U2RkaTZBSVhkdTRwNnI1MVNITmtvN0Mzdlp2?=
 =?utf-8?B?ZUorcVBLM0haYkx4TUpDNjBpblJhRnpld3JyRCtMQVZzcnVYUGNmMWVCODFt?=
 =?utf-8?B?aWN1QVpIcStkV2lDaW05NnIvbExVQml2WnJGamwxRVA1eWpYRDRRdEUvOW1G?=
 =?utf-8?Q?XAqw60187xQ=3D?=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CO1PR11MB5089.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(376014)(1800799024)(7053199007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?WlFROEtnU3lHYWFNc0NIbEp5WVRCZElHRit0Qk9NTlFHK3haWVBkYmF3cWlM?=
 =?utf-8?B?R3E2L0lsTW1NR2t5d1k0YzZmWHlveldZamNDb3lSemwyUlR3alBBWkVWc1Vn?=
 =?utf-8?B?ZGhJUXpraVgyMFc0NUFOODU3dUYzanJLNmpMVzdVc1NMSW5iRHdLZ0x3SURX?=
 =?utf-8?B?ZFFpUEQ3bTVDd0ZjRmZablFTbkNOcWhreEZNLzZFTXdaZmtuVTNZRitZdWNV?=
 =?utf-8?B?VW81UE93cmJpUWpMeFVja0Q3N2oyalBkM1BKQzhwM1R4aFRmUWFIWkVjeVZJ?=
 =?utf-8?B?UjNIRVR1SjZQNmtqWkdkWTFwdWdNcHNQMTFKUHgrVlNlSlV2Tm1nVlFEMGdP?=
 =?utf-8?B?dk5nbkx3cWxpZy9nWnVncHZQREtINUVRZExrZXlMWVg3QzNMWXdFRm9qOXpj?=
 =?utf-8?B?Qk9Oa01OQ05RcXNoamZyWFUwNUZ4RmhUM1FRdFRMd3Z3OU5SYnBtTThKTmFY?=
 =?utf-8?B?YmlMNDlEU2V3UUZJUE8zUzdSSTg2UDVaTGd4RXlmWmhJaE9EM255ZnM2enp1?=
 =?utf-8?B?Y05LUjZueHNRNkZSZTJzZVMvTGxTWWRHRWhwTHN3VUFjODQ1dXRMWWNaUnBV?=
 =?utf-8?B?Zy9yQlN0cm1MMW5uMzhxU09Vd2J6dU1sdUxNeWh3YTVFVG9wYkNCc0ZRbGZ4?=
 =?utf-8?B?Q3NjTEozTzBaNkFpYktnK1NzRHJTQ21yc0p2RkhrOUowbTlqQnl3M09qZmZQ?=
 =?utf-8?B?QWM4d2hJY3NZZmNVT1hNMWhTM3RqSENTMEdHbkIza1Y1eUpzUFQvb0dCTk1j?=
 =?utf-8?B?L0Zpd2kvemVWMVZrOGR5YXJCTi96MkVuaFVsa2RvNFdITC9sQ0xkMGhqWEgy?=
 =?utf-8?B?RnM0NHJMcXdNU1ZKVWxYeDkvbHBGK0lXVmxNdFpvejBGZ29CRmhuUnVMNjJy?=
 =?utf-8?B?N2dKTmhKQU5oR0xOb0FkVENUT29uZktDUkVnOUxKdTBQcHVRVjh1S0NDbXp6?=
 =?utf-8?B?ZmpMU3JvTGszSHNaWGIxRE1QSDd6RXhPZkFFZVVvQ0xwbFFiVDJVRXpGSDNK?=
 =?utf-8?B?VmgrVi9sQ3lrUTNKQmJ6R2ZSZVZjVHF4cXIrZEFWYUtKRVZyTUpzVGVRN0Vt?=
 =?utf-8?B?KzVkeWFsR20rREFjVVJMYVg4Q1NaR1luNkhkbVRkMm1mSmlsMlI0NTdGeUVt?=
 =?utf-8?B?TzZKYzk2SW16L21rOUg5R3NKQ3FsUFpVSWQwUTJyMThRQmNkZUxPM2pESjk2?=
 =?utf-8?B?VDhkeTJtTW1WWUViVmdHQy9pSTJkOHlCWkErd0M1R3E2UEpZOHQ4OHBRcWdk?=
 =?utf-8?B?RTZjY0dOQXMvSFdkMXF5czZmTDhYSzBwSEtzL0wvRjJQaW4xcU8vS3BXLzVi?=
 =?utf-8?B?Y1BCcHRjbGRmN2oyeUxKNUhtNWM2TDVnUnlzUHRWbklLTXJDN0dEUVJKcElv?=
 =?utf-8?B?bHJ5YjdhbGpwZUk4MWJwRG1nVFFsMUNDZUUrT0dRSHB6dUJrbVVlNWl6aXQr?=
 =?utf-8?B?V2ZNRDdNZm1Va0xhNE56VjBLQVZNYUlZRGVPUEpGODJ1OVdjdjJyd1N6TTV3?=
 =?utf-8?B?NElJTmVPSDl1TXJrWmNibGJYejBVVjNwTThodHhDSTNyUityeFliM0c4N0hP?=
 =?utf-8?B?U01aaXlOM2lKNTQ2NGpDRVBRb3laQ1lpR0FFQmxrSXpFU0VKWnVtcTViYXBy?=
 =?utf-8?B?RVF1cDM2NmZMZDhpV3RKYTlqVzhVVUZWVUNoeTdCd3lrcm5QZFNXTzdSYlNv?=
 =?utf-8?B?Ujk2SmFjelNFMCs5ZEsxQUFkdnc4YXNXc2tKUU5mM2lPWmpJc3NSYjlRWU9q?=
 =?utf-8?B?bnNwamJTSXhvYkE0NjJRUjJLN2IzbkVCZjB5NGlmamZjaUptVERNQ1NZVXpC?=
 =?utf-8?B?cjltTnZ2UlZWWTNYbXVZQU1XNEVLS0M1cnh3VU9NNnVKUnpwRXROYStnNTF3?=
 =?utf-8?B?L0hqVXdHL25sTEpGNXB5OGQrZVpmQlRkaEtPUmhtYWNNK2dTbGVlT3NNS2JJ?=
 =?utf-8?B?ZDRXRmZnVDJod2hDaEZSZU5YMXlFUXhrVE1FQ2cza1JuWlN6Q0JWWFhDS1Zm?=
 =?utf-8?B?c0UyaCs3MnRWU2lMY3VGZWtiOTBqQ3FGMWpPMFdzK1crKzc4NmZpaWhDMm9v?=
 =?utf-8?B?Y1VkME1Cd2ZvN1o3cTBxOW5pMSt2c0xxM1pIN2VMVkcza2pic0lvaUEwVWd2?=
 =?utf-8?B?SWliYjRuWG1TZDQ3OGROMkdaY3pLVjMxdjNzZ1huZlJFUVJ0RjZNbFdGV3py?=
 =?utf-8?B?ZWc9PQ==?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 90a38a60-b7e7-402d-b36d-08ddc8b24b63
X-MS-Exchange-CrossTenant-AuthSource: CO1PR11MB5089.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 21 Jul 2025 23:57:05.2130
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: zT71lEinzQEtruViRQcLcPA7/TXsxyve1Nu+Lsk85CgFR+HA3nUdzPZHZe59UkuBeoaZO32s3H2WUZNI/BwvTTpnWjdwq5wmmAw6ehasKMw=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM3PR11MB8733
X-OriginatorOrg: intel.com

--------------nlMQDThd8YtPGXyx10BEvEJi
Content-Type: multipart/mixed; boundary="------------RnBBgITgozndCBNowTz5HBeZ";
 protected-headers="v1"
From: Jacob Keller <jacob.e.keller@intel.com>
To: Jiawen Wu <jiawenwu@trustnetic.com>, netdev@vger.kernel.org,
 Andrew Lunn <andrew+netdev@lunn.ch>, "David S. Miller"
 <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>,
 Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
 Simon Horman <horms@kernel.org>
Cc: Mengyuan Lou <mengyuanlou@net-swift.com>
Message-ID: <97f47ab9-638e-45e4-88be-b1bcd089c2c6@intel.com>
Subject: Re: [PATCH net-next v2 2/3] net: wangxun: limit
 tx_max_coalesced_frames_irq
References: <20250721080103.30964-1-jiawenwu@trustnetic.com>
 <20250721080103.30964-3-jiawenwu@trustnetic.com>
In-Reply-To: <20250721080103.30964-3-jiawenwu@trustnetic.com>

--------------RnBBgITgozndCBNowTz5HBeZ
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable



On 7/21/2025 1:01 AM, Jiawen Wu wrote:
> Add limitation on tx_max_coalesced_frames_irq as 0 ~ 65535.
>=20
> Signed-off-by: Jiawen Wu <jiawenwu@trustnetic.com>
> ---

Previously you accepted arbitrary values, and now its limited to the
specified range of 0 through 65535. Seems reasonable. Might be good to
explain why this particular limit is chosen.

Reviewed-by: Jacob Keller <jacob.e.keller@intel.com>

>  drivers/net/ethernet/wangxun/libwx/wx_ethtool.c | 7 +++++--
>  drivers/net/ethernet/wangxun/libwx/wx_type.h    | 1 +
>  2 files changed, 6 insertions(+), 2 deletions(-)
>=20
> diff --git a/drivers/net/ethernet/wangxun/libwx/wx_ethtool.c b/drivers/=
net/ethernet/wangxun/libwx/wx_ethtool.c
> index 85fb23b238d1..ebef99185bca 100644
> --- a/drivers/net/ethernet/wangxun/libwx/wx_ethtool.c
> +++ b/drivers/net/ethernet/wangxun/libwx/wx_ethtool.c
> @@ -334,8 +334,11 @@ int wx_set_coalesce(struct net_device *netdev,
>  			return -EOPNOTSUPP;
>  	}
> =20
> -	if (ec->tx_max_coalesced_frames_irq)
> -		wx->tx_work_limit =3D ec->tx_max_coalesced_frames_irq;
> +	if (ec->tx_max_coalesced_frames_irq > WX_MAX_TX_WORK ||
> +	    !ec->tx_max_coalesced_frames_irq)
> +		return -EINVAL;
> +
> +	wx->tx_work_limit =3D ec->tx_max_coalesced_frames_irq;
> =20
>  	switch (wx->mac.type) {
>  	case wx_mac_sp:
> diff --git a/drivers/net/ethernet/wangxun/libwx/wx_type.h b/drivers/net=
/ethernet/wangxun/libwx/wx_type.h
> index 9d5d10f9e410..5c52a1db4024 100644
> --- a/drivers/net/ethernet/wangxun/libwx/wx_type.h
> +++ b/drivers/net/ethernet/wangxun/libwx/wx_type.h
> @@ -411,6 +411,7 @@ enum WX_MSCA_CMD_value {
>  #define WX_7K_ITR                    595
>  #define WX_12K_ITR                   336
>  #define WX_20K_ITR                   200
> +#define WX_MAX_TX_WORK               65535
>  #define WX_SP_MAX_EITR               0x00000FF8U
>  #define WX_AML_MAX_EITR              0x00000FFFU
>  #define WX_EM_MAX_EITR               0x00007FFCU


--------------RnBBgITgozndCBNowTz5HBeZ--

--------------nlMQDThd8YtPGXyx10BEvEJi
Content-Type: application/pgp-signature; name="OpenPGP_signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="OpenPGP_signature.asc"

-----BEGIN PGP SIGNATURE-----

wnsEABYIACMWIQQgQFSp1zOQVirsQx5qll0+bw8o6AUCaH7TzwUDAAAAAAAKCRBqll0+bw8o6FKJ
AQCTmfpTjD9ZGpDPQqH528lAh9L5bLCMqyWTgMM3oNAtXwD/T9RLR6we7n3F0fyPmmi8mKonRIp7
0seEb0419LGrVgs=
=/9Nx
-----END PGP SIGNATURE-----

--------------nlMQDThd8YtPGXyx10BEvEJi--

