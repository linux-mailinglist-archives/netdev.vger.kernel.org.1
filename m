Return-Path: <netdev+bounces-217092-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 2148DB3758E
	for <lists+netdev@lfdr.de>; Wed, 27 Aug 2025 01:32:27 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 25CEF189240E
	for <lists+netdev@lfdr.de>; Tue, 26 Aug 2025 23:32:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 97B0A27B323;
	Tue, 26 Aug 2025 23:32:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="CMaeDv4T"
X-Original-To: netdev@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0167328153A
	for <netdev@vger.kernel.org>; Tue, 26 Aug 2025 23:32:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=198.175.65.12
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756251142; cv=fail; b=VoyzoJTLiP31Eg8u1eN8kKSSxaFexKt+N0edWMG5jnhHgCGU1EnGkKkGaC12hybLuAIumuWMVVEiUKPzsk2rhQFjPuSjXVu7gES1zA5t5kAxyrP2I+iKkxJi15UsyifDh0UpuOPoe7QWjwLZUYDkqpglph1faRbOxLfHK3nk2Ps=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756251142; c=relaxed/simple;
	bh=ClMhaVS/y7M0erHTe0X9WVYQQxGeATYQD/4Ed+p7Pnc=;
	h=Message-ID:Date:Subject:To:CC:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=HzFTxccpniua+7JqzyxzBdfVi5rXp9Oz1fjC93wy88kBcavI4ha3g/l+MNW4I0bnAapm07dwbMcXi3cHRQo4BUAh7JeuF2ovo8gCnCj3W95h8Lks9HwNoD2kaPRBssKN+VlYdv584S8oWkyfVmT0/hFISkHEiwui6ueozHqYWv4=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=CMaeDv4T; arc=fail smtp.client-ip=198.175.65.12
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1756251141; x=1787787141;
  h=message-id:date:subject:to:cc:references:from:
   in-reply-to:mime-version;
  bh=ClMhaVS/y7M0erHTe0X9WVYQQxGeATYQD/4Ed+p7Pnc=;
  b=CMaeDv4TL/+OATPIrZCHJtRj+csxqNzHgBMNCn5sPjKcghdDnBQs6psJ
   nsKae9AKezBgxbo6g+PPTDkKzraqf0XvZbJtx95tZ4NmnjbYQtAABkyKb
   MzIT5BbOL5HzVpXSIfLhUcUheVU00S3Z47Zl7tberTAXPRNnD7eNSCKWt
   KczLxIDn100/WPwwm2mEvVaX1JaSbEjh0iX+/YHmDyL01l1lC4QgpISyz
   XUWJcZL6d3e7tJTXhA+LRvi8/rNSnU6rQ7mTyPIPCczsHEKHrYg56/Nfv
   EE8StdsGWhxtO/wnB3QedGNsWGysM09TMVGrtuhaULtx94MM4hWAXJAKV
   g==;
X-CSE-ConnectionGUID: q0zIcXzoT8KxLBpab6iKiw==
X-CSE-MsgGUID: uaSz1l30RfGwxaM+HaesBQ==
X-IronPort-AV: E=McAfee;i="6800,10657,11534"; a="69939457"
X-IronPort-AV: E=Sophos;i="6.18,214,1751266800"; 
   d="asc'?scan'208";a="69939457"
Received: from orviesa005.jf.intel.com ([10.64.159.145])
  by orvoesa104.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 26 Aug 2025 16:32:20 -0700
X-CSE-ConnectionGUID: ZaQHfvoZTQufSNjSYrMfzw==
X-CSE-MsgGUID: LCCXgquNQMCy3N7seftWcQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.18,214,1751266800"; 
   d="asc'?scan'208";a="174999584"
Received: from fmsmsx901.amr.corp.intel.com ([10.18.126.90])
  by orviesa005.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 26 Aug 2025 16:32:20 -0700
Received: from FMSMSX902.amr.corp.intel.com (10.18.126.91) by
 fmsmsx901.amr.corp.intel.com (10.18.126.90) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.17; Tue, 26 Aug 2025 16:32:19 -0700
Received: from fmsedg902.ED.cps.intel.com (10.1.192.144) by
 FMSMSX902.amr.corp.intel.com (10.18.126.91) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.17 via Frontend Transport; Tue, 26 Aug 2025 16:32:19 -0700
Received: from NAM02-DM3-obe.outbound.protection.outlook.com (40.107.95.50) by
 edgegateway.intel.com (192.55.55.82) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.17; Tue, 26 Aug 2025 16:32:18 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=CK0D6Z8/ymfClhTu7sjiJumuS+irMHyq43TTgNQibll8SJvehZOMphod5K4GPtaNsnFZVRc2XXwhczjIBW8KyRGR/N8yuelo3uJEWq9qLP4/FTn3pZPjOkKP1iFZ38Uo9hJLGqaAGqPKUFPK96n/m0vTvlimfbe00evM7BO5vdPDoT6fcK2fzlcqwQR0sDPBVvyhgCV792WYgmqwy26WH3fO4KQO/M9PndPkda8fUKfmRzr1m0M9+DwvNys9gme1rRr0+uvAzTS/U0dEYf48ZQZo/sGmV78RHXn/74brcZDLoeLo/DONEjwELubH2FV9zzhtzgXbkunzI6wp9jyY5w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=oMjPFgueVHJG5z9Ew7G627QNLx1NLkXPBlRlEvSMqjk=;
 b=xeccwbw79H6R5DBawWWe1QYuC6ixNqlFIhim9N1gk3z2cBYHCbdebrTxgOiDQZRajB5Iiw2S3SHajUty1kGOQ1MPDtcZe0r+rqNwMDTViujOMKixMq5Fn/jGKBhZMlt+iXHpO3L4Nd5tDjJfmI4H36ltb1KzMOJNPdXUoCkY3BrUYRuJRpGnoGpjmJusRr80EyN1eQ+yPY3u3el+oh2HCzbxygQ+z4y+x1j1zhfOkhFEhBdNknzPgUjfCNv8KXRIXrBITIOwbUYaPolVcghl46F66rswsPRAgWtEP1FcCfO56RSnniSv03vqbSUNxg4lgqbUsxQz0luziR9s7nOokw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from CO1PR11MB5089.namprd11.prod.outlook.com (2603:10b6:303:9b::16)
 by DS0PR11MB9454.namprd11.prod.outlook.com (2603:10b6:8:28c::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9073.13; Tue, 26 Aug
 2025 23:32:17 +0000
Received: from CO1PR11MB5089.namprd11.prod.outlook.com
 ([fe80::81f7:c6c0:ca43:11c3]) by CO1PR11MB5089.namprd11.prod.outlook.com
 ([fe80::81f7:c6c0:ca43:11c3%5]) with mapi id 15.20.9052.019; Tue, 26 Aug 2025
 23:32:17 +0000
Message-ID: <fa164612-0009-4ae3-811f-b349c625e162@intel.com>
Date: Tue, 26 Aug 2025 16:32:14 -0700
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net-next v2 2/6] eth: fbnic: Reset hw stats upon PCI error
To: Jakub Kicinski <kuba@kernel.org>, <davem@davemloft.net>
CC: <netdev@vger.kernel.org>, <edumazet@google.com>, <pabeni@redhat.com>,
	<andrew+netdev@lunn.ch>, <horms@kernel.org>, <mohsin.bashr@gmail.com>,
	<vadim.fedorenko@linux.dev>
References: <20250825200206.2357713-1-kuba@kernel.org>
 <20250825200206.2357713-3-kuba@kernel.org>
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
In-Reply-To: <20250825200206.2357713-3-kuba@kernel.org>
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature";
	boundary="------------dhXqEbeuMm6xpsslL7UJxxLo"
X-ClientProxiedBy: MW4P223CA0013.NAMP223.PROD.OUTLOOK.COM
 (2603:10b6:303:80::18) To CO1PR11MB5089.namprd11.prod.outlook.com
 (2603:10b6:303:9b::16)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CO1PR11MB5089:EE_|DS0PR11MB9454:EE_
X-MS-Office365-Filtering-Correlation-Id: f6885b7d-2205-42a3-dae9-08dde4f8cb5e
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|376014|366016|7053199007;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?cmdNeFUvd2pnSVluMEpXb0ZZOS93ZUVnRzNoZzBQWndKYmFlZWkyaFhUYzJ5?=
 =?utf-8?B?WU0ycE1sWFVjNTNOQW54Z0hDSmw5WUVBeGd2YXpXdjV3amQ4bEJkUmhsQ1VM?=
 =?utf-8?B?TE5LMTlRTDBuVHNsRE9GZ05tMy9MVDBvWlNXMGthOGs2S2FyR1gyRElJMWlW?=
 =?utf-8?B?QVhKY1liRzJ5Z1FaS1R3ODh0b0RNTnNSVFFXa05mSVhsODBvUEtmU2pNRFhU?=
 =?utf-8?B?OFhoZzU2N2ZZdVU5QU45SnZ3ZXBJOVZLM2ZpdG81eFJlNWhsWXRZU1hxcUZY?=
 =?utf-8?B?QlJnMGhRbEQ2UVVNSUw4QWpJZjFjU2M1bXhXdHJpMC85YUlJZFQyV3UxOTFH?=
 =?utf-8?B?L0pNUU5ldnlXMEt5YVUvc3pCUXpPLzl3Q3dKelMwODRRU2xaQVMvb0JYdis1?=
 =?utf-8?B?MU1Zd0tQWllwK0MyUVF6QUhLZ1QzTmFKbWlJdGJzc1JuNE1sU0Z5eE95OTZk?=
 =?utf-8?B?TXVGMVhFaEthWTBHcksvNmdxS1gzNUFtazlmQndlZmpDRURVZWdiZU15eXNu?=
 =?utf-8?B?VFpnN3FXOEhCR3dndmNLbitIQWx5Um93NUl4N01iM0pSbngrY2EzOGxOQVFK?=
 =?utf-8?B?b04xNzAzRVkwNzhYRFVXWCsxNzV3K3Vxd2tTZ3NSWUdGY01LWDJBckRnY2xt?=
 =?utf-8?B?c3FlYVp6RzFSYUZiSFkrRDRZY3hBalRIRklYZ3hSSFlVVlBoVi83SkJ5MTAv?=
 =?utf-8?B?ZUk2WmZyK05yNkhOUlZhNTNrcTFzSWZmYW9ReUZrL0I4STRoRHRSQmo2eDlV?=
 =?utf-8?B?VkpzKytFWDk0NGpXTnFsWDRTd0tLVjFaVDI2dE1iU1VtV2c5TVdERXJLa09y?=
 =?utf-8?B?N1NGQnI4WHkvYlA0N1QyU1p1WlhEQnhUS0lQeTNEblhaTE9UWWVGZHQ1MCtJ?=
 =?utf-8?B?M0xPSXNYOEtpekozNFFnanYyZHliQkFkeHJzTkxqUzZuN3lrbzkwU2RzSk51?=
 =?utf-8?B?dHN3L2hhQnVmdXNYcmgwYURHbzl1T2hnR2VzN1NWRllHUUtvREZOdWlZS0ZE?=
 =?utf-8?B?RmVOcUQveFozUXRXUW5adCtYeE9DemVzQ1gzMmRhT3VyQ0s3c3gzNVArOE14?=
 =?utf-8?B?U2d4ZDdDdXdzVThtcFk5Vng0cTNscks2VzU0M3JrYjNnOFMzTEFJVFZidDFQ?=
 =?utf-8?B?QkdnS0tSalJ3SzhYRWlHV2VmYXRvU0s4TnZyYVo1UlptSHVIQ2hseXJEbjhX?=
 =?utf-8?B?L3BPQXNVZ0dyeGxzM1J2TVdSZkJ4SWkxSkoybW0yQUpXNWtzWTIyTXNLdlZm?=
 =?utf-8?B?WGsxUlpaTDRPVG02MmEvcnpZUStiVld6T2R4dm11bHJhRlpZRUJBOEVwU1Er?=
 =?utf-8?B?U3gvcTFPdFZVeDM1M0pKWEpYRGUyamtvZXZuRjlnNlRwK2w5QlFoQzBSNUVV?=
 =?utf-8?B?cTdqNVVzRU1zRzcxa3FKWHJVTWJJWEJlOFZNZUFoMExZY2l0YkFCZUxvd1FN?=
 =?utf-8?B?bDVnMmhPWGxmam1vZm5ISjJReVN3MXAwWUdpWUZ3d3Qvc2Y4R0dleVhITTAr?=
 =?utf-8?B?Vnh6TmVnaUhGYnRDN1BwRXlWYytJRXIyK1FjTW1HQm1pSndQTlFScDNDcEdD?=
 =?utf-8?B?bXFRbWpla1dMTGhZazFoejY5NVo2bG5BK25IWW1CNzdUTG0rNjhickFpQTZk?=
 =?utf-8?B?M2k1aTU3SUJzS0RPeUd0KytWc3p6OThyRFJMVkJ2ZWYwSnhlUzFZMXJtb1ZZ?=
 =?utf-8?B?M05YWnRaVmJ2YWhDNEtvWUZ4R1VPRGE5THk3OVJwbmZiYnRuV2FVZDh3blFB?=
 =?utf-8?B?UGdZblE4K1gybTF6NVhrb1E1OUIxRFVKUWNuNEF5dlBqa3h1RllKdEpFV3RY?=
 =?utf-8?B?bjBzVlIrWFp4WTFUSXRPQ29zWkFlcDFUeWYxdVphUkRSMFVtK0Z6cDVmUGNv?=
 =?utf-8?B?REY1MDVuTllPd3dlZDh6YVRMM2s2Ukx3Q3BpVkV0cWVsaHc9PQ==?=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CO1PR11MB5089.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(376014)(366016)(7053199007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?RS9vWWVrTmVaQWtpdkhpOGhTSWc1bm5BOHNtVTBveUJsZ2xxOUh5QzRmUXNa?=
 =?utf-8?B?R2E3NmJIbXNzM2hwQ0VZd2dOekxNVmFwTC9GeDA4UFRsanBsZGZSdStTWVpI?=
 =?utf-8?B?UHlJSW9SVXV6Wk16QnM0RmVqQUVHZVBoQll1MWp0dVZ5RHZidGUyYXRHZHJp?=
 =?utf-8?B?c2hwYlFvNkxDQzk0cmxINkozSHN5cFFVWFFBVnhqTzg3T3BVcGxhdlpxM05l?=
 =?utf-8?B?SUd1cStwWnZhSzB6U1NTN3c1WW5NU0o3c2pXcTJIRW90WXVXZ2ppTTZXYmt3?=
 =?utf-8?B?c3hMVkRGV3hzbnk3VTdybHl0YXR4UFh2QUhSK1dQeExTWTgzdkVsREhzMW5G?=
 =?utf-8?B?QlVEN2EzNDhlVVgvMC9ER1RzOFMzeWNHU1NBdjBmWGlvUStQdXp1ekRNM29L?=
 =?utf-8?B?UXg1eGR2ck5HdzhmMDdNeVovbXliODUwQlNCaUxMOEwvc1NwNEdjQTBINE12?=
 =?utf-8?B?b2JRaXIzSXhOTGNKMXFhbE1BdmxPTzFJTlJSQ3FaN1VCT1lMU21reUh2K2li?=
 =?utf-8?B?KzgyT3o3QTZqTFkxaW9NM2JYVFVkT1RCWkVKdnIyUXV1OXNWUUZ6K1dtS0Fv?=
 =?utf-8?B?TklvdWJQQkx0dmRSWXkyN2FHWTJMMFBhbW51N0lkYVl6bVd0a2JqZEt4WW9T?=
 =?utf-8?B?NW14VDhydHZJUDJscUw0NXNFaEhtN25yTmZVKzZ2K2FKbjlwbGw0Zjdub0Zi?=
 =?utf-8?B?MzJDRHBFYk14SkFJdE5LTVBWSzRscW5Qd0pqQ3dDVm1NY2hCSG1PUGxuQzFY?=
 =?utf-8?B?RktPRlEvZ3NlWnZSZDlxc1RHUFFqUGFvZkkvbStnQXl2aXFCTTFHM252Ump1?=
 =?utf-8?B?bnh2SUtpNjRPUGJJUWVPYVNLclBHTlo2ZHJVQkhtbmQ3NDYyc0V2RWtSM25z?=
 =?utf-8?B?Q3pXdEthb2U5dVFSNXRmN2hxSzBQZ29hK3RsUWkxeW84aHBBQWxRbVZqMjhM?=
 =?utf-8?B?RG83WSt3MEd5RC9Hc2RUUG4yZWxsK3E4ZXZEVC8zYnBsL1o0N0tsMUZUcHdo?=
 =?utf-8?B?enpXdUM1K1lERzc0WWRGWXRBNmVzYVlpR1Z5NFI3UUxqWHdHUFU2UC9rNUZF?=
 =?utf-8?B?c0xJVmJTMHB2ejlDWUZhaERmS3hLOUV5UjJTUXBCUjFEZFBOMTNsc1gzQnhi?=
 =?utf-8?B?MjNML1FIak0vNHpaS0MvMEhINTF0STJtdUZRLzVqTjBBcGx5YXpoZ2dlTFVs?=
 =?utf-8?B?alkzdk9IR1RQR3dzVlBOWE5Da2N5ODhndVJMSUhmZ1dGaDNockV6U3VocEt3?=
 =?utf-8?B?TDFTR2xTblpvQlhBK2t3RllFaEtLUnRwU0VEK05hWlVBTzBOYldxcDNDcTFD?=
 =?utf-8?B?QmVTL3BhUWpTNU92cVFrQW93SzZUS3pET2VRVkVhNUNUMGcxSitoT0IzSlRM?=
 =?utf-8?B?SW9tbGdMcjdDVmZ0a0oreTlmZTBENXlycUpyYjNORkRBL0JEaTZ2Q0xRbWFj?=
 =?utf-8?B?dmcxd1djMXVtcEh3OWtCZEFzRWRuNGtvbkl2YndqM3BzcFE3ZkpqYjdZVWFj?=
 =?utf-8?B?OVpCMkR3NVkzWWFqMzE5ald1UkZ1UHdSaWl4MkpTWmxKSTkvZlhQc2hidFhi?=
 =?utf-8?B?cDRpT3BIa1ZHQ0g5dHBheHd2MGNnNm9BSUhhQ2N1b0l5ZHA0SWUrNExid2lK?=
 =?utf-8?B?ZjZpekY5SUtxMEVUeUZYT3U5dzNpQll5azZIQ2VpaWQ2RkprOTBsSUNzY0ho?=
 =?utf-8?B?K3o2YlVTamx3MHZmVnFLNkE1Q0RrOGw1dnVNMWY4aCtEM0ZvcUJPVndXVzhR?=
 =?utf-8?B?QWlPcVBxVEp3RGdxUEE2SUlIaDZzZnpnQ2xmTUhaUi9GalYwQ0diQzF5R1ly?=
 =?utf-8?B?eHBodEVDeVJLaGQyMzBuQUhpRTRaalhiZ0VwTzJscTZSZENHRURXTnBlVVRH?=
 =?utf-8?B?c2hzbmNDRUg1UStzM2NndnBkOGVTMEVOQ1FDQmR1Y2ZyMkxnRE9YQXZ0Ym9R?=
 =?utf-8?B?WFhpTFFmWFNQeHdXMWJLdjB0UCt6Q2VzbUxVbC9xY1NVVWVLckJONmRjdzZ3?=
 =?utf-8?B?dkFsNjFxdHpZMDl2QlJmT3ZXUW04RnhLYWFPbjZ6VEtqUGpKbS9mNWNsNTBw?=
 =?utf-8?B?K0hXd3JMWUdvSXpOcitpd1liRlJRaEVNclFiZlVnb0llTDFTMFl3K1Q3U05x?=
 =?utf-8?B?eG9GTU5OdVJBQTZYTHcwa3FhMlVpZGsxRVhNakJkUUxhUll0OS9QRW5hR0ZD?=
 =?utf-8?B?dnc9PQ==?=
X-MS-Exchange-CrossTenant-Network-Message-Id: f6885b7d-2205-42a3-dae9-08dde4f8cb5e
X-MS-Exchange-CrossTenant-AuthSource: CO1PR11MB5089.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 26 Aug 2025 23:32:17.3483
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: gssBrS42G2WzKPOxj3ahlDJ53dgvVMqFIiQ0pda6cmdUXDvc5Pqn9H79Sm+MASdD+gX4NWQ4gVtRh8M+7+OFhs4+7QFnEc28I6vI9xG3b4I=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS0PR11MB9454
X-OriginatorOrg: intel.com

--------------dhXqEbeuMm6xpsslL7UJxxLo
Content-Type: multipart/mixed; boundary="------------3Sai8waEf0RAvw6x5VdHdE0q";
 protected-headers="v1"
From: Jacob Keller <jacob.e.keller@intel.com>
To: Jakub Kicinski <kuba@kernel.org>, davem@davemloft.net
Cc: netdev@vger.kernel.org, edumazet@google.com, pabeni@redhat.com,
 andrew+netdev@lunn.ch, horms@kernel.org, mohsin.bashr@gmail.com,
 vadim.fedorenko@linux.dev
Message-ID: <fa164612-0009-4ae3-811f-b349c625e162@intel.com>
Subject: Re: [PATCH net-next v2 2/6] eth: fbnic: Reset hw stats upon PCI error
References: <20250825200206.2357713-1-kuba@kernel.org>
 <20250825200206.2357713-3-kuba@kernel.org>
In-Reply-To: <20250825200206.2357713-3-kuba@kernel.org>

--------------3Sai8waEf0RAvw6x5VdHdE0q
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable



On 8/25/2025 1:02 PM, Jakub Kicinski wrote:
> From: Mohsin Bashir <mohsin.bashr@gmail.com>
>=20
> Upon experiencing a PCI error, fbnic reset the device to recover from
> the failure. Reset the hardware stats as part of the device reset to
> ensure accurate stats reporting.
>=20
> Note that the reset is not really resetting the aggregate value to 0,
> which may result in a spike for a system collecting deltas in stats.
> Rather, the reset re-latches the current value as previous, in case HW
> got reset.
>=20

Good. This means stats should stay relatively stable across reset, while
preventing glitches if the HW stat itself reset. Makes sense.

Reviewed-by: Jacob Keller <jacob.e.keller@intel.com>

> Signed-off-by: Mohsin Bashir <mohsin.bashr@gmail.com>
> Signed-off-by: Jakub Kicinski <kuba@kernel.org>
> ---
>  drivers/net/ethernet/meta/fbnic/fbnic_pci.c | 2 ++
>  1 file changed, 2 insertions(+)
>=20
> diff --git a/drivers/net/ethernet/meta/fbnic/fbnic_pci.c b/drivers/net/=
ethernet/meta/fbnic/fbnic_pci.c
> index 8190f49e1426..953297f667a2 100644
> --- a/drivers/net/ethernet/meta/fbnic/fbnic_pci.c
> +++ b/drivers/net/ethernet/meta/fbnic/fbnic_pci.c
> @@ -491,6 +491,8 @@ static void __fbnic_pm_attach(struct device *dev)
>  	struct net_device *netdev =3D fbd->netdev;
>  	struct fbnic_net *fbn;
> =20
> +	fbnic_reset_hw_stats(fbd);
> +
>  	if (fbnic_init_failure(fbd))
>  		return;
> =20


--------------3Sai8waEf0RAvw6x5VdHdE0q--

--------------dhXqEbeuMm6xpsslL7UJxxLo
Content-Type: application/pgp-signature; name="OpenPGP_signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="OpenPGP_signature.asc"

-----BEGIN PGP SIGNATURE-----

wnsEABYIACMWIQQgQFSp1zOQVirsQx5qll0+bw8o6AUCaK5D/wUDAAAAAAAKCRBqll0+bw8o6P9f
AQCwyhrlqofTcIAUVYi0xAKYMR7dczllglX2Klz2HpmpKwD/bIJuosCG/eL3i0C3kUaF3GUkPFf9
UBXanRptdjzLoAY=
=/JSe
-----END PGP SIGNATURE-----

--------------dhXqEbeuMm6xpsslL7UJxxLo--

