Return-Path: <netdev+bounces-221803-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 51B11B51E68
	for <lists+netdev@lfdr.de>; Wed, 10 Sep 2025 18:58:56 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id F3AD67A1AEA
	for <lists+netdev@lfdr.de>; Wed, 10 Sep 2025 16:57:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E1A3D286D44;
	Wed, 10 Sep 2025 16:58:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="UkWx0Dje"
X-Original-To: netdev@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3D72D221FCD;
	Wed, 10 Sep 2025 16:58:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=192.198.163.12
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757523529; cv=fail; b=pSN228XUs5a8p/ZyThBGpwNjgchTz1Of1bIRbTCJuJVZZPJhcFeX9PBn5FyKFbD0yRjFGj5De1SGoWZ+WXJMzLnsAloqG0aqqsY6uxCbbKFPz41gtfPoZ32zAV7WncF7jEO36xn44rH5gZlsST0J2Tmst/fXt90AgbNG8KR0IMQ=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757523529; c=relaxed/simple;
	bh=nQkPiFouxmoUPxvnDjfXavjOhUMCYEUljkg5fPqV6qY=;
	h=Message-ID:Date:Subject:To:CC:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=O8bVBI/hbSRXb8vhZhfEwggaQhOBook7nNvxcybNmGIrT6185ySfz+KlXcO1NxJSWBjKvlCmUWb9Oz/1uJ0UFNE46aT5SwdFE1x+jh2U9KXgTYp8MP2WhW/sEBCOp7mG3FAndGplx5eNIoyJNmhL8wTn0qhUDYT/pKqrsihE2VU=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=UkWx0Dje; arc=fail smtp.client-ip=192.198.163.12
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1757523528; x=1789059528;
  h=message-id:date:subject:to:cc:references:from:
   in-reply-to:mime-version;
  bh=nQkPiFouxmoUPxvnDjfXavjOhUMCYEUljkg5fPqV6qY=;
  b=UkWx0DjeM/di7ctqkaXP2xHrfJ83xpkq8+h0oFyybBH5xVZRd+MhhKL9
   T9uFfK8P9YI03IvlXhnGDi4KdD0VSyYdr+SdYfHFimJKDsAj3XKZdQ/F/
   etKn0i3clz/AUvUh/p4L0t7EmiL9P0vgOAde+s1a5CsM6vHn9SofDm0/A
   ROQ+s9CWc7sBUnf1suPbodC4XXQ/h+gj7j4xuV0WmsU4H9+tDel/xlzAS
   R02VWcA/wghuVpcUONw3o7p72MbHXH1JgQPedgM32Fimx7/X0mXob3ASp
   ARsL2E2lT1XJkAOmKf3NZdvdX30rwkFW0eSfem5a30Bap7WV+PcPrErAe
   Q==;
X-CSE-ConnectionGUID: /B5k6vQZS8W32AchijaReg==
X-CSE-MsgGUID: +E8PpKbtSn60KpYQu9orZg==
X-IronPort-AV: E=McAfee;i="6800,10657,11549"; a="63670322"
X-IronPort-AV: E=Sophos;i="6.18,254,1751266800"; 
   d="asc'?scan'208";a="63670322"
Received: from orviesa007.jf.intel.com ([10.64.159.147])
  by fmvoesa106.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 10 Sep 2025 09:58:44 -0700
X-CSE-ConnectionGUID: Yx6zUs/jSIuCNK/r6weaOg==
X-CSE-MsgGUID: uU//epc5Qz+/0N3LqoVAkw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.18,254,1751266800"; 
   d="asc'?scan'208";a="173292287"
Received: from fmsmsx902.amr.corp.intel.com ([10.18.126.91])
  by orviesa007.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 10 Sep 2025 09:58:43 -0700
Received: from FMSMSX902.amr.corp.intel.com (10.18.126.91) by
 fmsmsx902.amr.corp.intel.com (10.18.126.91) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.17; Wed, 10 Sep 2025 09:58:41 -0700
Received: from fmsedg902.ED.cps.intel.com (10.1.192.144) by
 FMSMSX902.amr.corp.intel.com (10.18.126.91) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.17 via Frontend Transport; Wed, 10 Sep 2025 09:58:41 -0700
Received: from NAM11-BN8-obe.outbound.protection.outlook.com (40.107.236.84)
 by edgegateway.intel.com (192.55.55.82) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.17; Wed, 10 Sep 2025 09:58:41 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=WRe5nOsVoObJOYHwdGGHFN8h0dT1DeyMXhVuURoslCEWi3LYfsyqNM8tRaIseI+ws18JYZGeWehV3XUK47C4jjSTfDt/wYJf7nibhmPfX4qTIpLvVChLfQWOm70iwSLbTKSvfHJ17qCqDvxLR7EQZNmz0MEI0sr3SlLaacWnas7V4B8H/e0qXGsoS04h/gRhg+Cq1bpy17dXwc5ttCB2yhEpsf13NWoVsayt5Hy7ztbHiRb7ExTwu31q3qZfr6w4HEkfdz6NTlojUrazXqCemBypkJcia6XQ5JAsR7x33jJqqsn121im+JMIHkke5hkyPwdmI2JPKIA8DbTK48sU1g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=nQkPiFouxmoUPxvnDjfXavjOhUMCYEUljkg5fPqV6qY=;
 b=Dhb0Qocs/PavtWiEEosBOeRu2AisqQOcR1CYc5WBkl0E8OZIXcpC6VyuBLAJx7texAYYoUXUBTlMJIb2Smq+NvebFyTD1LAUXJoU2H9AFtRECsYLurCTQp9gnL4frcfz6FBMu8gjoQ2EFlhssB68mPScX3wsYHAiman1q1KF8b8XxqC3YiVLUUYxXrnsMaxh/hROh8g6H3JnSnnwKjBuoQcbvEGYP+meBtV+hugGRP+UuMepPJ3sJUg8SD+hICb7P53RTaViYdbixsXMDdg077jB7GvwxJz7lmDRizxt+PvTSDPCWkrewzd/JcJ5ZGDTIZmM+u5x4VslXTxX7Y2LgA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from CO1PR11MB5089.namprd11.prod.outlook.com (2603:10b6:303:9b::16)
 by SN7PR11MB7042.namprd11.prod.outlook.com (2603:10b6:806:299::5) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9094.22; Wed, 10 Sep
 2025 16:58:39 +0000
Received: from CO1PR11MB5089.namprd11.prod.outlook.com
 ([fe80::81f7:c6c0:ca43:11c3]) by CO1PR11MB5089.namprd11.prod.outlook.com
 ([fe80::81f7:c6c0:ca43:11c3%4]) with mapi id 15.20.9094.021; Wed, 10 Sep 2025
 16:58:39 +0000
Message-ID: <7fff6b2f-f17e-4179-8507-397b76ea24bb@intel.com>
Date: Wed, 10 Sep 2025 09:58:37 -0700
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net-next 06/11] tools: ynl-gen: don't validate nested
 array attribute types
To: =?UTF-8?Q?Asbj=C3=B8rn_Sloth_T=C3=B8nnesen?= <ast@fiberby.net>, "Jason A.
 Donenfeld" <Jason@zx2c4.com>, "David S. Miller" <davem@davemloft.net>, "Eric
 Dumazet" <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>, Paolo Abeni
	<pabeni@redhat.com>
CC: Donald Hunter <donald.hunter@gmail.com>, Simon Horman <horms@kernel.org>,
	Andrew Lunn <andrew+netdev@lunn.ch>, <wireguard@lists.zx2c4.com>,
	<netdev@vger.kernel.org>, <linux-kernel@vger.kernel.org>, Johannes Berg
	<johannes.berg@intel.com>
References: <20250904-wg-ynl-prep@fiberby.net>
 <20250904220156.1006541-6-ast@fiberby.net>
 <d2705570-7ad2-4771-af2a-4ba78393a8c4@intel.com>
 <d612ce20-ae4a-4f6d-9d1b-a3d56f3d10a9@fiberby.net>
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
In-Reply-To: <d612ce20-ae4a-4f6d-9d1b-a3d56f3d10a9@fiberby.net>
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature";
	boundary="------------OLVVMmZtyz00u3KW05g9oYFp"
X-ClientProxiedBy: MW4PR04CA0219.namprd04.prod.outlook.com
 (2603:10b6:303:87::14) To CO1PR11MB5089.namprd11.prod.outlook.com
 (2603:10b6:303:9b::16)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CO1PR11MB5089:EE_|SN7PR11MB7042:EE_
X-MS-Office365-Filtering-Correlation-Id: b6561463-d256-4eb1-8410-08ddf08b4a39
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|376014|7416014|1800799024;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?YTVFVVZJSnFGbzlwVkc2WkdoMnRtVmwzcXM5WjRIejhhdWtaNFpCQ1pRclg0?=
 =?utf-8?B?QlF4YXRMNE9tbWlOaGs1V2NIUmxyODNmVlA3VUlJNDEya0drb1J4QXB5OEJp?=
 =?utf-8?B?VlhMNkdBZndJekU5T2c4dEVrT0hLUU43R1BDNFQ0VDg1MS9mdGRoVEpFOW1i?=
 =?utf-8?B?YytIdERGWmZMTkZYUU83dWRTamtqQ3R4WWRjSjRLNFN1K09Kam0wK29pZjJM?=
 =?utf-8?B?by9FbmJBOG51di9mMkJJdDBHOStYYjlQZ1BiOFVkazNKaDB5T1B5UTBVTVNW?=
 =?utf-8?B?RmI2YU1GVGkzMGg2czFwNjR3T3ZIMDdseVIrbDF0NHpJYUtpMnpNNGhkQzZt?=
 =?utf-8?B?bG1jV2hldklrMmU2aWd0VFZ5ZlF0bzFpUjB6MnU1YnFnaHU4M2taTjhDYnRX?=
 =?utf-8?B?WkMyZVFqdDJjSGJwd05NS0NWUWJTbVNYZmRoTm8zV1RGUUFYMFMxbkJ0SDVw?=
 =?utf-8?B?VTVFdEdsUFZyVzBJWXBhTzZUaER3bDgxUEJNNnkvNnRDdS92aVJEYUcwSDhX?=
 =?utf-8?B?NHE2REh5Q1JQTFJNK2FDV1dKQmcrSjhGSUVqc2FhODNMOENBeWJyaEJzN3E0?=
 =?utf-8?B?S1ZIcXRmd3JIbzlIZUN0LzVwWWZLQXZBK1YrOTdhdFBiaTV2SDB4azR4Q1VX?=
 =?utf-8?B?NnJ3bmZJem1ORFBhS1NKMDdMc0FKejVOeGJWK0k2YjhmaHpJajRSdlhxdE4y?=
 =?utf-8?B?Mi9Kdk1hOFRsYThDWjJKdFhpaXp6ZFk0MzRUT1JNY2dBbytsc2VoTGQxQllv?=
 =?utf-8?B?b0J3UVJKL2pIWTlVN3BIQ3J2aWxkVDlvQWQ3SXk0cng1aGdpRVdYa0lXbDA2?=
 =?utf-8?B?N2NjZHVyWXpyWVUrbHNERmhSc3p0OGM2MUJkeVhMZkZCV3h2eExGeEdGTi9x?=
 =?utf-8?B?d1FYaUtRQUM2TmNrWTJoeENZYm5hOHBLL09JMEtVTWt1QlZNYWJBeDFIeUVE?=
 =?utf-8?B?UHBvVmlMYWk4R3ZkUmVLQzFlbXFsUkREYVJoWmxQdllNVlN1alk3N3c5bVdm?=
 =?utf-8?B?N2ZaRmpoVlhCU3UrNythWG5ienpvbElwUVJkWkRSSCs0TmkyYkwvaC9lS0FU?=
 =?utf-8?B?U00vUkxNSHVxN1VwcWNvNkpxaHdxRFBSakZIaC80OXlhM2FVNzhFckFieSs5?=
 =?utf-8?B?OXdOYzUvY3VGT2pCeHMvVHprRHA3T1FKNU9OcFV4eitWOTAvclZyZ0ZwcndF?=
 =?utf-8?B?L1BranhxK3oxN3AyZ0xjRzdnUVZmZjdvNXRuS2xYdlhKRmtGZjJMSVhHN2JN?=
 =?utf-8?B?WllQUXNKQWI4d3U1VmU2NzY4Z3QvUk9FNXJoN0oxRGt4Z0Vyb2k2bE52NmZi?=
 =?utf-8?B?OVpJaHFCdFMwN1FENlNjTEg4OHF4QnhwRkNWTXJzNjRaSzNxL2pWR0VzOG1D?=
 =?utf-8?B?Wkkza1c3Z1ErU1V0RU9CMTNTTlFxNENlQ0dtNUZ5SXlDRGMzRVJWZm5hTmIw?=
 =?utf-8?B?UDhhZ0xKWTh2SmVKcXIvbVJyd1VLQU8yOUY4S0N1SGVjTnQzV0JCK2lpeVlq?=
 =?utf-8?B?aFVLODBiSWUzaVFKejFsdmI3NEhzTGZOZVBoYndRbDZ1V2FaeHFweDFabVJ3?=
 =?utf-8?B?UEFxVU5pcUoyRnJNQ0p3S0JVRm95NHRHK3FZM2F5dm9sSW81aFJpK1RsdUdK?=
 =?utf-8?B?ZjhHa1hzQlBGMnN3RFFOQVhNbk9mY3pudmdvQ2x3TUI3RHM3VU15UUlWa2pz?=
 =?utf-8?B?MzdMTGRubFJobjJIWVBtd0lHSGpvMXNVU21SVnFjbkJmNTkxMDNlVWU0c0RB?=
 =?utf-8?B?ZkdQMENjWGN4eHhIQWxEMDNmSFRNYjlQSEcvckNIOGtHaWw0SDVXai95V2NN?=
 =?utf-8?B?YUJKL2hjM2I0QXYyZGZVbHZJcnJ0dEQvclRqdEdDazE2K0QwZ1BSUzE4N2F0?=
 =?utf-8?B?bllCSkRIQktNSUNIOXJnK1A4a0d6WCsyNkhPNXBxRGpnczZkS3lmN0ZsZVVp?=
 =?utf-8?Q?i6yAGAHTQ1Q=3D?=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CO1PR11MB5089.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(376014)(7416014)(1800799024);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?bUpacXNPUjFVSEFST3k3WTZEZlc3cStzQXpveHFNL24zVkt0Ylg1UW1QemFa?=
 =?utf-8?B?ZFEvTkgxcHJPUG1tNkZGd2tVcE4yYWxyRjJXZ2lSdWNnUHNVZWNZUXFGcEVH?=
 =?utf-8?B?ZFFwaVJDeG1zek5qbE9EZ2VYKzRFOXJOWjVSdUJPSlBSbzZHQXRHeWh4Mkh4?=
 =?utf-8?B?TURUaFQvS3NsUXNBK3dHSjZ0SXh2UzlEbVNMcDRIejNWaVJKL2M2YXBqcHpt?=
 =?utf-8?B?M053ZXJoRFl0UVlsSWw4MEJUSjJEemZyNldzQlNYRVFiYnZUU2NGcXpBb20r?=
 =?utf-8?B?OXVMT1hDeFRaVk1VRjhsblVhQVlqTXBJbW1GSmliSEROSFhaU2doYUFMWjJw?=
 =?utf-8?B?VVVCSGR4a244bU96R21NbmNxZitVK3BzSWIxbjZMRjVSYnRRVEtaanVUeVN3?=
 =?utf-8?B?ZDdHMDE0ZmRQMnorRzF6L3pzQnJxMFRCZkJqZld0bVZuWWsxSTQySWVlZFJt?=
 =?utf-8?B?bHZqcWtHbmF6K2J0dWZtYTV5dmxaTXBQL1BZWWVsMnVmTnZVV1ZlZWdhcFl4?=
 =?utf-8?B?UGs3UnJnVG01QWtBQ09ITklERTRVRXZRV04vYmZmUTFEWGVUUlVEbFZRczhm?=
 =?utf-8?B?d2FEVkplV3Nqck40OFhxbk00cURKN2Exd0hoVThlWFk0MXhWMkwzbGhHUUFu?=
 =?utf-8?B?cFZoaXlsNkI5Nnc0cjlYbmxpSUpmeHlFS1dBanA5RGxQWEVJZ0FRTXluYWdk?=
 =?utf-8?B?UDJ0V2pSYVpLZWJjc3hNSTVVUi9FU1ZmaWFZb2ZmUDhsQlIvVklOeVp0KzNM?=
 =?utf-8?B?OW5maXBUT0x4YzR6OTF6T05lRWZKRVUremQvUkIzY0RxTitHSFpDSG84QlZy?=
 =?utf-8?B?Rk9laVlobTRwcC9YQkprRXJ1TTNMdy92clNjeDIyQTRBa1o1a2pZZ2w1ZWZy?=
 =?utf-8?B?R09HMjdBT2ltS1JvcXRUMnRiZ3JCS2krOStQRkp5aDlDMktRQkV4UXhlRW1v?=
 =?utf-8?B?b3VlMTltbGhYYk1QZFhDK3FZeDNQaVVwSWhrS1ZBVFkxUDFVbnVSaHVRdUdZ?=
 =?utf-8?B?NTFEdjBVWE1lYTZ0aGhiVlJFRmdWM2xkWFRXWEtxTjg3VkRzak92WkVEczFU?=
 =?utf-8?B?RFIxYWQ1WC9jT2xLVWMvaTV5RUJ2bGcrTGcwbWRvZmhMRTR5TzlYUVdkcEVM?=
 =?utf-8?B?QWU2emMzdk1iRGJSZmJKRXBsUE10QUhrVjkzQ0g5L0RsOWJ3bFd0YWdHSXhM?=
 =?utf-8?B?QllWWW5mNkFYTmx2aEQ3VkVhbEg0aXhYZis2M2VQQzdWTFYrSGR5MWFUWEs0?=
 =?utf-8?B?Mi9iakNhWkF4dkNsMW5QbUxvekluMU1FYnN4aCs2Mjk0R3BQaFR0bEFGbGpu?=
 =?utf-8?B?ZS9Xam03R0xWUGFRanN0V0VXRmZGYkdVT2NIbHhmMzU0RUZ0UEpJbVFwdk5n?=
 =?utf-8?B?UXMvN3NJODA3ZDVhV2FZUmpwOU91TDBCOXNrNFlvdWZSdVdoVWVyQ2hLa0dC?=
 =?utf-8?B?blFvNjVFdXJDNXdkcWFuZmVIc1dKZnNSZkJTenBTRzVWc0hOc0s3OHRlVURU?=
 =?utf-8?B?WmU5eEd3eHFuNTJGSFAwdmxCUkh2YzNaYkhDMXdYcjlUYWtXVzM1OC9RSVNX?=
 =?utf-8?B?RkJyWWg1cmVnWjlrRG9kbDNudmIrSEduNlp2eCtzNzVPbTR3c1NFN0ErVURM?=
 =?utf-8?B?dSsrOHhJbFJ3akxiNFpHSmdDQmwzVlN3dGxYTE9VQ2toVXdIZUY1YU9BaEJp?=
 =?utf-8?B?WDBGRW1FbDJlTlN2R0wxMlU1Wi95Z1hZcXpucjZTaXpTUUJFamtxTGRZbUpv?=
 =?utf-8?B?ZGRhZTZjQStzVHJBRFYwd3lldDhhVTlnWU1pRlZLODBLT0NNY2dzUjU4Vkoz?=
 =?utf-8?B?Yytwc21GczBnMWNDcVNGZ20zbWloWmVTd2Z3YzdVbzJmUDNQUE5zTERFZE9B?=
 =?utf-8?B?M0VWL0QweGY0UnMvTmZpS21xamhYNjRVSGd4TERYRWFrNHcwVStGbkorWmhI?=
 =?utf-8?B?eGxZNllYQTdFbmIvZjAxV2pZWHJBZmhLS3U5Um1qNzdRYXE5K3A5MU5IdFRX?=
 =?utf-8?B?UmV4djYyOGt0L2h3elR0N0hqTUtlUmRIVlQ5TjRTZjZ3elRJVUdtWjVOOStL?=
 =?utf-8?B?d1BVR3lwc0FKODRXVml0RWpLVzErY3hiUFV6Lys3SlcxdU1wWWJPT0NZWUJV?=
 =?utf-8?B?aDFnZjdCUWdBVi9aZlQ3QUtZQUNIMVpFbkpqMXZwRStnTVFEbFZnZjBiM3FZ?=
 =?utf-8?B?OFE9PQ==?=
X-MS-Exchange-CrossTenant-Network-Message-Id: b6561463-d256-4eb1-8410-08ddf08b4a39
X-MS-Exchange-CrossTenant-AuthSource: CO1PR11MB5089.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 10 Sep 2025 16:58:39.4858
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 844i+c/S4cqCr/JfAP2GJ59lUEwzC0FRhaxPUB/jdGHxViHooMeSA/Dhhg5xsW/3u8qQJRmrJ++hCbsdamn1n5t+gUD+mjgcEW6YAnTt8OA=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN7PR11MB7042
X-OriginatorOrg: intel.com

--------------OLVVMmZtyz00u3KW05g9oYFp
Content-Type: multipart/mixed; boundary="------------BJSaVYFrV8QZqf1QmEtBi3k0";
 protected-headers="v1"
From: Jacob Keller <jacob.e.keller@intel.com>
To: =?UTF-8?Q?Asbj=C3=B8rn_Sloth_T=C3=B8nnesen?= <ast@fiberby.net>,
 "Jason A. Donenfeld" <Jason@zx2c4.com>, "David S. Miller"
 <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>,
 Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>
Cc: Donald Hunter <donald.hunter@gmail.com>, Simon Horman <horms@kernel.org>,
 Andrew Lunn <andrew+netdev@lunn.ch>, wireguard@lists.zx2c4.com,
 netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
 Johannes Berg <johannes.berg@intel.com>
Message-ID: <7fff6b2f-f17e-4179-8507-397b76ea24bb@intel.com>
Subject: Re: [PATCH net-next 06/11] tools: ynl-gen: don't validate nested
 array attribute types
References: <20250904-wg-ynl-prep@fiberby.net>
 <20250904220156.1006541-6-ast@fiberby.net>
 <d2705570-7ad2-4771-af2a-4ba78393a8c4@intel.com>
 <d612ce20-ae4a-4f6d-9d1b-a3d56f3d10a9@fiberby.net>
In-Reply-To: <d612ce20-ae4a-4f6d-9d1b-a3d56f3d10a9@fiberby.net>

--------------BJSaVYFrV8QZqf1QmEtBi3k0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable



On 9/6/2025 8:10 AM, Asbj=C3=B8rn Sloth T=C3=B8nnesen wrote:
> CC: Johannes
>=20
> On 9/6/25 12:24 AM, Jacob Keller wrote:
>> On 9/4/2025 3:01 PM, Asbj=C3=B8rn Sloth T=C3=B8nnesen wrote:
>>> In nested arrays don't require that the intermediate
>>> attribute type should be a valid attribute type, it
>>> might just be an index or simple 0, it is often not
>>> even used.
>>>
>>> See include/net/netlink.h about NLA_NESTED_ARRAY:
>>>> The difference to NLA_NESTED is the structure:
>>>> NLA_NESTED has the nested attributes directly inside
>>>> while an array has the nested attributes at another
>>>> level down and the attribute types directly in the
>>>> nesting don't matter.
>>>
>>
>> To me, it would seem like it makes more sense to define these (even if=

>> thats defined per family?) than to just say they aren't defined at all=
?
>>
>> Hm.
>=20
> I considered adding some of that metadata too, as I am actually removin=
g
> it for wireguard (in comment form, but still).
>=20
> In include/uapi/linux/wireguard.h in the comment block at the top, it i=
s
> very clear that wireguard only used type 0 for all the nested array
> entries, however the truth is that it doesn't care. It therefore doesn'=
t
> matter if the generated -user.* keeps track of the index in .idx, or th=
at
> cli.py decodes a JSON array and sends it with indexes, it's not needed,=

> but it still works.
>=20
> In practice I don't think we will break any clients if we enforced it, =
and
> validated that wireguard only accepts type 0 entries, in it's nested ar=
rays.
>=20
> For the other families, I don't know how well defined it is, Johannes h=
ave
> stated that nl80211 doesn't care which types are used, but I have no id=
ea
> how consistent clients have abused that statement to send random data,
> or do they all just send zeros?
>=20

Changing it at this point could be a significant backwards compat break,
as some clients might somehow send data that wasn't zero-initialized,
and checking would break them. At this point I guess it makes sense to
leave it as is... It would increase code cost and complexity for no gain.=


> This would make a lot more sense if 'array-nest' hadn't been renamed to=

> 'indexed-array' in ynl, because it feels wrong to add 'unindexed: true'=
 now.
> We could also call it 'all-zero-indexed: true'.
>=20
> In cli.py this gives some extra issues, as seen in [1], the nested arra=
ys
> are outputted as '[{0: {..}}, {0: {..}}, ..]', but on input has the for=
mat
> '[{..},{..}, ..]' because it has to be JSON-compatible on input.
>=20
> If we had an attribute like 'all-zero-indexed' then cli.py, could also =
output
> '[{..},{..}, ..]'.
>=20

This part would be cool. If we know the index is "uninteresting",
eliding it so that the input and output formats match is good.

> [1] https://lore.kernel.org/netdev/20250904220255.1006675-3-ast@fiberby=
=2Enet/


--------------BJSaVYFrV8QZqf1QmEtBi3k0--

--------------OLVVMmZtyz00u3KW05g9oYFp
Content-Type: application/pgp-signature; name="OpenPGP_signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="OpenPGP_signature.asc"

-----BEGIN PGP SIGNATURE-----

wnsEABYIACMWIQQgQFSp1zOQVirsQx5qll0+bw8o6AUCaMGuPgUDAAAAAAAKCRBqll0+bw8o6Emy
AQCN0z0QVh4QT2Oh9Y5N4JGEHGZwkfJC++FfUA31iwaVzAD+IkuC76JKatIeWkbOP2cwIbr0FLKz
GHKICpDY/5aL6gs=
=RN/n
-----END PGP SIGNATURE-----

--------------OLVVMmZtyz00u3KW05g9oYFp--

