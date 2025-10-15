Return-Path: <netdev+bounces-229769-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 6A8E8BE09F5
	for <lists+netdev@lfdr.de>; Wed, 15 Oct 2025 22:23:47 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 83D314E8BF8
	for <lists+netdev@lfdr.de>; Wed, 15 Oct 2025 20:23:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 978A52C2360;
	Wed, 15 Oct 2025 20:23:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="lfNm/Svv"
X-Original-To: netdev@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.15])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 026471DD0D4
	for <netdev@vger.kernel.org>; Wed, 15 Oct 2025 20:23:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=198.175.65.15
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760559822; cv=fail; b=ULC9ZVVHyqcBZnNAZKSxUT9xLH2rn/SOt8P94DygdqJEe2+yhilc/+PDX6HuhnSkdxOiIej7uDFgoUF8D8j0kfVGvLBsrQ+PEuydp9N9UuE+iTWjkdP7pltw2xQGBCn8n0HGcCHsgwcQAlmIOmNpV3FwcIQlznZQGqXedTO33oY=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760559822; c=relaxed/simple;
	bh=l/XB/EtWDCA6GkxNAi+58ARbTtG8NxwTvA8FqsfNSiw=;
	h=Message-ID:Date:Subject:To:CC:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=riUNDVDIBisH21TCyDecB0yOHRdfZG+AFWbCBa1vuoDDrBJlLdCLA+4n55WflR1q6N2x0vlOWrQy7cyCDgjocHugvtWPYvTMLUUFIBTky8ImLaYdV2ETguHG5gdyGmtlaTSTOG6c93SUVbCJSyN/RGbB8TskVIXpK4n55QC7jtk=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=lfNm/Svv; arc=fail smtp.client-ip=198.175.65.15
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1760559821; x=1792095821;
  h=message-id:date:subject:to:cc:references:from:
   in-reply-to:mime-version;
  bh=l/XB/EtWDCA6GkxNAi+58ARbTtG8NxwTvA8FqsfNSiw=;
  b=lfNm/SvvdcPvwfbGdZg3c9nRzEdHWL2KYipbsazRAHjxh5CpLmMoggR+
   gCLAE3AdwvXnNh7WN4HoJmh+8wOZi+amXUL8vfFGIHcaGNXGnk6cO0Apz
   wp1CeHtiPCaxe/zJxCuzUbR+KhrVKNW19g6laMe3HlT2wBQGrD6lLgy2q
   9X6kUwsojEywOlOrw8tIRua73JgEsQ1aBIwzFL/YvRqNoJIWNqrNyf0I+
   lNeSsnlneP46k2bhbqbqVLrcFvyyhqyR5WssQ9UGDlGrBIzLQUzfP4qGA
   QVG6ikbt8mztQm5tNurviQOPNg0Saxh9KFLTUaVmM2HkwDR/oW1GhEENg
   g==;
X-CSE-ConnectionGUID: S3R3BZ7KS76t41gQ8FpBZw==
X-CSE-MsgGUID: p54K9IiET+i0w8csByRYuA==
X-IronPort-AV: E=McAfee;i="6800,10657,11583"; a="66397276"
X-IronPort-AV: E=Sophos;i="6.19,232,1754982000"; 
   d="asc'?scan'208";a="66397276"
Received: from orviesa001.jf.intel.com ([10.64.159.141])
  by orvoesa107.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 15 Oct 2025 13:23:40 -0700
X-CSE-ConnectionGUID: wGFDaBlUQ0uVSsYvQsRAqQ==
X-CSE-MsgGUID: C4GTvmWCSy6uMCXRynpgSQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.19,232,1754982000"; 
   d="asc'?scan'208";a="219417317"
Received: from fmsmsx903.amr.corp.intel.com ([10.18.126.92])
  by orviesa001.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 15 Oct 2025 13:23:40 -0700
Received: from FMSMSX903.amr.corp.intel.com (10.18.126.92) by
 fmsmsx903.amr.corp.intel.com (10.18.126.92) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.27; Wed, 15 Oct 2025 13:23:39 -0700
Received: from fmsedg901.ED.cps.intel.com (10.1.192.143) by
 FMSMSX903.amr.corp.intel.com (10.18.126.92) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.27 via Frontend Transport; Wed, 15 Oct 2025 13:23:39 -0700
Received: from SA9PR02CU001.outbound.protection.outlook.com (40.93.196.41) by
 edgegateway.intel.com (192.55.55.81) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.27; Wed, 15 Oct 2025 13:23:39 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=XePAKXB0wnxYYMCWcCXfMQsITCWDZyTR/XWcKVWBrdvpWh1A6CzlrV1LRayOr0I4/XaMqlbsp9Qgg2lkJRzACJrnsQa4M6YoSsxbJUYPVPkXPSWksioJOpEx6E/KtRq9q/NsK86Nufe755m7AsmN4Hjpkb47m1smjkGi16U60DvXdr1dkAhgMaiFOKXzlACHcpYMFl4J7C8QvZhPQo+DQfxwVPp/zlBSosmEHUx9U5LAI8ZjPehU26liYrDzNQTgXrTpELzW63Y+3ET4vNuxCamaOvgysZTmleNh/I1axv5frevDt++Ntte9G1/3qmzPUHrwIBc87M6Z7iqnlN5zeQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=GZKex2J15XClO7G8QvdoyjZcvUEn74phALFyKJhtql0=;
 b=nOhVzuL4cOQjCrhf87I+Ea7aFHkYtOA6XI7LMetbQHq1ucAhLPrh/NzfVMRVUaRr7FylD0M6V2Xvf7viehPCOPfElVIGOcTPYTtujCWgGKnfMOUGItdGhxyShz+sRYITC8jn0wqwXnZCDa6HT2CdFYthG4BWH6olkXxE62AZPNmzzotS7zYRXf1z798XZZDy9ZZjpJQl9AlBpEqrrOp4CJbBF9JOj+nt77Wstn2ZnVaE/om9aNzPgZ1kqGpBW0eDouQoswW1nGy6WMRm/DYa2kvzP80GXclwI4RL8kac9wG03hlvnSHguTNtQ/vTrQ4QnPbqQiRa+EvD6SdIIvbpEg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from CO1PR11MB5089.namprd11.prod.outlook.com (2603:10b6:303:9b::16)
 by CH0PR11MB5297.namprd11.prod.outlook.com (2603:10b6:610:bc::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9203.10; Wed, 15 Oct
 2025 20:23:32 +0000
Received: from CO1PR11MB5089.namprd11.prod.outlook.com
 ([fe80::81f7:c6c0:ca43:11c3]) by CO1PR11MB5089.namprd11.prod.outlook.com
 ([fe80::81f7:c6c0:ca43:11c3%4]) with mapi id 15.20.9228.010; Wed, 15 Oct 2025
 20:23:32 +0000
Message-ID: <ebeb9fdd-1fb7-4ebe-861a-820e17468bb2@intel.com>
Date: Wed, 15 Oct 2025 13:23:30 -0700
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net-next v2 3/7] amd-xgbe: convert to ndo_hwtstamp
 callbacks
To: Vadim Fedorenko <vadim.fedorenko@linux.dev>, Shyam Sundar S K
	<Shyam-sundar.S-k@amd.com>, Andrew Lunn <andrew+netdev@lunn.ch>, "David S.
 Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, "Jakub
 Kicinski" <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, Egor Pomozov
	<epomozov@marvell.com>, Potnuri Bharat Teja <bharat@chelsio.com>, "Dimitris
 Michailidis" <dmichail@fungible.com>, MD Danish Anwar <danishanwar@ti.com>,
	Roger Quadros <rogerq@kernel.org>
CC: Richard Cochran <richardcochran@gmail.com>, Russell King
	<linux@armlinux.org.uk>, Vladimir Oltean <vladimir.oltean@nxp.com>, "Simon
 Horman" <horms@kernel.org>, <netdev@vger.kernel.org>
References: <20251014224216.8163-1-vadim.fedorenko@linux.dev>
 <20251014224216.8163-4-vadim.fedorenko@linux.dev>
 <0529aae6-19ef-4e10-9444-a99e54c90edc@intel.com>
 <a8a523bb-a50a-419c-8ba8-78a3e7aa0daa@linux.dev>
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
In-Reply-To: <a8a523bb-a50a-419c-8ba8-78a3e7aa0daa@linux.dev>
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature";
	boundary="------------3pkLbh0wM6WPoUOWG14Nma39"
X-ClientProxiedBy: MW4P220CA0015.NAMP220.PROD.OUTLOOK.COM
 (2603:10b6:303:115::20) To CO1PR11MB5089.namprd11.prod.outlook.com
 (2603:10b6:303:9b::16)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CO1PR11MB5089:EE_|CH0PR11MB5297:EE_
X-MS-Office365-Filtering-Correlation-Id: ba4e9a5d-f0bd-44a3-539a-08de0c28b5b7
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|376014|7416014|1800799024|921020;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?eWRadFU2VW5QdHhycXdxMVpvc1FxMi9paW9QSUtBRHBkZmNxTFFSeWlJQ2xS?=
 =?utf-8?B?RU9OVEJhcTF0TG1rcmxsYVNaSlNUcVBvNXZSYlVYVG8zR1Jya1VqSW84aGhs?=
 =?utf-8?B?ZTNMRFJoTXd4SDFUWVIrRmZFam9PUTM5RXNkRnYvY21EampuVHlYdWM3WUwy?=
 =?utf-8?B?UGhBeUJMSVR0bjRTZ0F2dDluSVo1NkxvaUwrTjhZL1d6VTN2NllyMFM1MHRO?=
 =?utf-8?B?dzRDZDhqc1U2R1YzeFJxYUhMYURGTU9RZE5PSWI5VE5uSW5ORjhlVXNGMEIz?=
 =?utf-8?B?ZjZuN3FYczArTlQwOUFsalN1Z0R3MkpKWVA0amlSUm1SYWJJdUw5TlBiR2tU?=
 =?utf-8?B?SGJtOXFzK1ExdGFod20rKzJYUU1pdlJoL2xlOERSUUlxL01YZGdRaWphYTVa?=
 =?utf-8?B?Yjl0WE1paFRlNjFBRFJ4Q3hhdTM0aEl6Y2ZjejgyM1J4VG5iMzNGV1AzMkY4?=
 =?utf-8?B?dlpha1JoSENIL0V1Znd4YyszU0JxV1duWDBWVFJwMjB0bDR5OVowM2Uvb2Zt?=
 =?utf-8?B?VWdET0lWYXhIQm4xWkEvQmRiUXZjblI2NW9GdGJOb3pMUHg3ajNzcEo4Y0FT?=
 =?utf-8?B?VVVKb2lwNjlXb2Nrcjl2WGxGai8rZC9nOXROcmRyVityMHR0ZWdLOE4zelRJ?=
 =?utf-8?B?dzRna0tzTG9MV2p5Qmw0R0ZDR3lDK0dUS0ZjZFQyNXFKOUdROXRvQ1o5QmMw?=
 =?utf-8?B?ZUViWExLMElOOGRzQmtxQ0lYcEwrdlVtMFFUcWVnRC9FdGNtOWl0NDgyaU5H?=
 =?utf-8?B?Y20zZFNzMEZGRThxUFlOR1BJMjVuSGhmeUFha0N5bDVjSFA2a2F6N2U1aHZY?=
 =?utf-8?B?ektONUZrblBOVHFaOTBtMDE1cTdRanN1K241d05VUzlOeHczV2Z4dWZlN1pD?=
 =?utf-8?B?QitTdWtXdkY2L3RUMXc1S25Td1N0Z0x1SzJPR1RCNURFTHUvVXpEZ042NTZh?=
 =?utf-8?B?RUxxYjdsckxvd1RFUGZUTzhTdjN3dkRPcEkvUjFsMkNTUzNucEptbFMxNFRp?=
 =?utf-8?B?UWJpWWJ1QThETG1LUW11dlNWUjIvUm4wbnQwdWh3RWY2cVVwRFIwUUlvNk5S?=
 =?utf-8?B?cFBESVdXc0N1anBqUDhja0NzaTl4cVpMcHBMbDVRVjlRbkZQSnpwa3JEQ2Qw?=
 =?utf-8?B?MmE3RnVFQUJyVDNHWWttVG9YTHVia3M3T01PRlJueHJzY3NabDdTbk9pSHpW?=
 =?utf-8?B?QkFjQzl1R29aV3NDaUk3OW51Rldwem5PWGFGd3RKNFl1N2xGZzVySmJxdXpn?=
 =?utf-8?B?cUc1NlpYZU8zU1VPaGc2WVJxdHZmdW9WM0FzNWxKVTh3WHdaSVRtV3dNd09o?=
 =?utf-8?B?Z3dsclJPK0lVbk90ZG0wVHRDdUZseGt2bEY2emM1YWkwM2Eyd1VjdmdpWEFq?=
 =?utf-8?B?ZFRjL2QrVGZ1ZStLUDhIYWZTYTJhRXpqZEE2dmNVOHRDTUE4QzIwVVlWTkFC?=
 =?utf-8?B?NlJYemdtS3lVT1d4aUt0UlN2S1NtZk5wNW9BMHVFM0tzUkR4K1pzRFcyK0dN?=
 =?utf-8?B?TDFTTVVkTHpza0ZWWlJLMHhFRnR4c002QnlIZXlnWnNhVWVmdVdJZ2djaXRM?=
 =?utf-8?B?WDZ6bkxKWGw2cU1ia2dOUE1WSWZRVytmYWpqRHRSdUlzU2lUSFpWd0c4TkU4?=
 =?utf-8?B?V1FjS3BtRVY2UTFtOG5wZzV4NWlrUUlEeGxMVmg4cE1YNVpXQk8yOElUcVlw?=
 =?utf-8?B?TnhocFgvRDhQOUJiUHkvVWpGUmxuWmpwdUMzR2d5eGFoUW1pTk82OVpJMks1?=
 =?utf-8?B?NkNNU29UR0VPNDQrbzF2b3F0VExYckRwQU9sSVVMbnZyQnJqZlNNRE1hamRh?=
 =?utf-8?B?Tzd6ZFAweldzdHlicS9SZXhkNlAwcG5sZ3Fra3ZmeG0wTzJCbkRVcDN1REYv?=
 =?utf-8?B?dlEwYUJnQUl2eUQ5VDhrMGxzUVlBaXNnOVJ0bmpNa2oya080MzJ4NW12OSs0?=
 =?utf-8?B?d0loQnVyN0pnY3RQYS9NRXRKaS9JUzVhb09nNjh4ZFo5eXpVQzdSdjlrak1w?=
 =?utf-8?Q?4GIIe8LRjlT0LchbW7DBVGnnZ9Gnrw=3D?=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CO1PR11MB5089.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(376014)(7416014)(1800799024)(921020);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?NXpCSzVXanp5NGd0Zmdtazc0ZlcwVXZFNWtwY2EwWGwwRk0zLzhQSzVJN2ow?=
 =?utf-8?B?cDNUQ1ZST2Z0N04yL0RBSHJ1WnE5MElHRkRaMVhxUjg0bzVrODQ0ZWpBN1Fz?=
 =?utf-8?B?VFkzNWt5K3VjUWduNWJWenpldlFYMzM0Q2VQOU1Qd3l6Wk1KZGNKVHdsckdr?=
 =?utf-8?B?TmpsT1d5dk1tM3hMdHlYTmo3UGRyZ1hzM0lIUGZ1Y3dncThmbUJYNWlDTWdr?=
 =?utf-8?B?aXp3UTBQR2JVc3FRYmh4WkJXSjZsVTZNZ3Y4YVA1bUlyNXBuaUY4ZnVrNDFK?=
 =?utf-8?B?VVpKTHJDblY3THJ3d3BjZ2MwQ25yTkR4Mms0RGZjZzRwN2xwYlNuTEZ4YnM3?=
 =?utf-8?B?UmpjSXY4T3VLdUt4Q0Y1M016UUY5c29IeVZWL1FTc1dFMUtDTnR3Ny9rV2Z6?=
 =?utf-8?B?Y1ZUUis0aTA3NGlJTGpIZVllczVyOU9hcFNDajZLeVJXOWwzK24xS1lwRlZK?=
 =?utf-8?B?d2IvTGxlK01NaHhJK3NobVYzWXhkUndSVW0zSW0wcWR5RmNIZW5meDFLQjM4?=
 =?utf-8?B?akxZczFPN0czYXppdXM4QVpwZFJ2RFp3SW95NGo5cER2dkJXU2swbWZ1OXBK?=
 =?utf-8?B?SEhCbmRDMnQzREIxTlZPYyt5R0FpN2FHT1BmMWlGbFJ6OTUxOXBxWXVNVU45?=
 =?utf-8?B?U1B0REN5cERodzI4NTcrQzVla0dKUlgzL3JvMGdBUHN4Y2lNN0RXY3R0V2U3?=
 =?utf-8?B?V3BBK1FnakRkbkpUWm1yZEJuUm01WWorbnF1U1VzWE5oeFZVdlN1RmIxSEQ3?=
 =?utf-8?B?eFdoMnJTWEJPSDQ2a21xUHM4OGNiTWk0dzBYR1F3cHRaQ3FTWGRWSWg4YS92?=
 =?utf-8?B?L0Znb1Bya2pBTmZVVUxUL2dXbjF5WURlUlRwRElJZW0xVFNsMU5lbTBnRGFW?=
 =?utf-8?B?NURSZjh6Mkdwd0p1eExOWjdkS0tFZFQwTXpWcGxSWHdtdEI3Z0Rrcm4zdHhL?=
 =?utf-8?B?aTJUelJLL2tKLzk1VEVYRDVId1ArNjNZTmNVRURYMXcvWFpaVGM1R0Qwb2s1?=
 =?utf-8?B?ZWFCdkIwbnljNE5YdDZUWlc4TnUyMkZkSXkvVUtuRWcwcU4zUmJBdDlFc1gv?=
 =?utf-8?B?OEtlMFExYlpMVndZYllHQkJBb1lkYkpEa2hIcEladHYxRjdUaXpYZ3VuSlpF?=
 =?utf-8?B?ZGZZSjZyWTBnWkZrWkZhYTVkL1pMM0pWZDVrOWhwYTRaVDRCUDFBSGJ6SnRN?=
 =?utf-8?B?aHZYVmdrLzBSaGkzWkh4SzlKbjB0T3BldVo2VHg4eGZpcFhUM1pHQlpIZDFv?=
 =?utf-8?B?V2U5RWp0TWFiblNCUWVEYjhFRXlON0hLcy9jcmY0VE0xUEZvcDd5bTArME5Q?=
 =?utf-8?B?ZnJPMUYxbnIwREZTREhMcWNBOHVKaUx4Y1pEQ1dQMWxoaENGRkN5Z0lMejlR?=
 =?utf-8?B?N2g2Q3BIb01Xemd1ZWVBOXFHbXovRDRBVDJ1REthT2xldVQ2V0RWQjQ1Z010?=
 =?utf-8?B?eDZKSGxKOGdsVzFyQ0JDSHlYSERDbHU2VFFJdGtYN3JnYUdXMVhyTXNlQXF2?=
 =?utf-8?B?d0dWYlhDUE1BSnZPNm1pYWJZUGtpSGFRZ1VJNzEvZFA3bGZJUndSN01ZVWJk?=
 =?utf-8?B?Q3JsN0F4aHh1SFYycFZzb3VsK1k2MDk3TkdTby9jMytnS0x1VnRUbnNqZUpM?=
 =?utf-8?B?Rzgzb2o1aWRkS0VUYzJZRGQ2RzI0dlhJZjRVeEJzN1JqN0prRUxtcHhTUnpv?=
 =?utf-8?B?UW1DRWxRNzllWnlZWXBIclppaG5UTVNvbERBU2xaWktwUDgxTmxWQWR2K0Rm?=
 =?utf-8?B?ZWNRejlQdWw1eEdEaWR0Mm5tTExKUUtnRzVZMXVSUWhMR0JQRWhqMWFEVUxk?=
 =?utf-8?B?WUFrR1lMNTE4YlgyeUZNSHpOaDM2WEhDUHpJY0FWd1ZRZGYrdVF2Z0d4ZTJl?=
 =?utf-8?B?ZXUveW1QWFF1cTI3V1VxS25kdFNYUmRESENWMlQvZ1NaVGhISnEyMmhBYnpt?=
 =?utf-8?B?WTBxY2lGWmZQZmJkeWxydEEwcTdkN1kvMFJ4NGJXckpXVmhIcjRBdWw3Zmha?=
 =?utf-8?B?cUFJU0tlczVvUzNZcW8vWG5KSmlMbUQ0dEI3NEpQd2Q0YytnbS9kUGgrRlJm?=
 =?utf-8?B?OHZZQzBOQnV0NnVJTWFuT0hseFlCckkxVHZSSUczRFhCSngwaGxYY1NaRkNs?=
 =?utf-8?B?MG0xc3hrMXdGS2J5QTArU1ZZcllYNkpHMUhmbitwd1JXVkljRWMrQkJKZmVh?=
 =?utf-8?B?eWc9PQ==?=
X-MS-Exchange-CrossTenant-Network-Message-Id: ba4e9a5d-f0bd-44a3-539a-08de0c28b5b7
X-MS-Exchange-CrossTenant-AuthSource: CO1PR11MB5089.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 15 Oct 2025 20:23:32.1276
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: JLsy7o8TK4qnqE7wJQGg/C/9t1V/8wX8E1IxQIIgVpee+LQx29MVOghKYjpQJLAKfHFNikCHcYgCutY/a/sMfjz5x0kkZ7B6nWS/o8UibUs=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH0PR11MB5297
X-OriginatorOrg: intel.com

--------------3pkLbh0wM6WPoUOWG14Nma39
Content-Type: multipart/mixed; boundary="------------AhgmGMi0juug5U0mttdw7Jp0";
 protected-headers="v1"
From: Jacob Keller <jacob.e.keller@intel.com>
To: Vadim Fedorenko <vadim.fedorenko@linux.dev>,
 Shyam Sundar S K <Shyam-sundar.S-k@amd.com>,
 Andrew Lunn <andrew+netdev@lunn.ch>, "David S. Miller"
 <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>,
 Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
 Egor Pomozov <epomozov@marvell.com>, Potnuri Bharat Teja
 <bharat@chelsio.com>, Dimitris Michailidis <dmichail@fungible.com>,
 MD Danish Anwar <danishanwar@ti.com>, Roger Quadros <rogerq@kernel.org>
Cc: Richard Cochran <richardcochran@gmail.com>,
 Russell King <linux@armlinux.org.uk>,
 Vladimir Oltean <vladimir.oltean@nxp.com>, Simon Horman <horms@kernel.org>,
 netdev@vger.kernel.org
Message-ID: <ebeb9fdd-1fb7-4ebe-861a-820e17468bb2@intel.com>
Subject: Re: [PATCH net-next v2 3/7] amd-xgbe: convert to ndo_hwtstamp
 callbacks
References: <20251014224216.8163-1-vadim.fedorenko@linux.dev>
 <20251014224216.8163-4-vadim.fedorenko@linux.dev>
 <0529aae6-19ef-4e10-9444-a99e54c90edc@intel.com>
 <a8a523bb-a50a-419c-8ba8-78a3e7aa0daa@linux.dev>
In-Reply-To: <a8a523bb-a50a-419c-8ba8-78a3e7aa0daa@linux.dev>

--------------AhgmGMi0juug5U0mttdw7Jp0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable



On 10/15/2025 12:58 PM, Vadim Fedorenko wrote:
> On 15.10.2025 20:47, Jacob Keller wrote:
>>
>>
>> On 10/14/2025 3:42 PM, Vadim Fedorenko wrote:
>>> diff --git a/drivers/net/ethernet/amd/xgbe/xgbe-hwtstamp.c b/drivers/=
net/ethernet/amd/xgbe/xgbe-hwtstamp.c
>>> index bc52e5ec6420..0127988e10be 100644
>>> --- a/drivers/net/ethernet/amd/xgbe/xgbe-hwtstamp.c
>>> +++ b/drivers/net/ethernet/amd/xgbe/xgbe-hwtstamp.c
>>> @@ -157,26 +157,24 @@ void xgbe_tx_tstamp(struct work_struct *work)
>>>   	spin_unlock_irqrestore(&pdata->tstamp_lock, flags);
>>>   }
>>>  =20
>>> -int xgbe_get_hwtstamp_settings(struct xgbe_prv_data *pdata, struct i=
freq *ifreq)
>>> +int xgbe_get_hwtstamp_settings(struct net_device *netdev,
>>> +			       struct kernel_hwtstamp_config *config)
>>>   {
>>> -	if (copy_to_user(ifreq->ifr_data, &pdata->tstamp_config,
>>> -			 sizeof(pdata->tstamp_config)))
>>> -		return -EFAULT;
>>> +	struct xgbe_prv_data *pdata =3D netdev_priv(netdev);
>>> +
>>> +	*config =3D pdata->tstamp_config;
>>>  =20
>>>   	return 0;
>>>   }
>>>  =20
>>> -int xgbe_set_hwtstamp_settings(struct xgbe_prv_data *pdata, struct i=
freq *ifreq)
>>> +int xgbe_set_hwtstamp_settings(struct net_device *netdev,
>>> +			       struct kernel_hwtstamp_config *config,
>>> +			       struct netlink_ext_ack *extack)
>>>   {
>>> -	struct hwtstamp_config config;
>>> -	unsigned int mac_tscr;
>>> -
>>> -	if (copy_from_user(&config, ifreq->ifr_data, sizeof(config)))
>>> -		return -EFAULT;
>>> -
>>> -	mac_tscr =3D 0;
>>> +	struct xgbe_prv_data *pdata =3D netdev_priv(netdev);
>>> +	unsigned int mac_tscr =3D 0;
>>>  =20
>>
>> I noticed in this driver you didn't bother to add NL_SET_ERR_MSG calls=
=2E
>> Any particular reason?
>=20
> The only error here is the -ERANGE which is self-explanatory, so I deci=
ded to
> keep the amount of changed lines as low as possible.
>=20

Makes sense.

> We might think of adding netlink error message for ERANGE error in
> dev_set_hwtstamp() in case the driver skips setting specific message.

I think this is a good approach. Use a generic message when unset by the
driver.

For the patch:

Reviewed-by: Jacob Keller <jacob.e.keller@intel.com>

--------------AhgmGMi0juug5U0mttdw7Jp0--

--------------3pkLbh0wM6WPoUOWG14Nma39
Content-Type: application/pgp-signature; name="OpenPGP_signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="OpenPGP_signature.asc"

-----BEGIN PGP SIGNATURE-----

wnsEABYIACMWIQQgQFSp1zOQVirsQx5qll0+bw8o6AUCaPACwgUDAAAAAAAKCRBqll0+bw8o6PPu
AP9SDlNjFOzqIggIKWPQvW76+CiIyBbgkXCa+rj7AgHmFwEAgk9fj0bo80SMKTKJJcD6o+07iSQr
IKXMdsSq04TEUQY=
=McnW
-----END PGP SIGNATURE-----

--------------3pkLbh0wM6WPoUOWG14Nma39--

