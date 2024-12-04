Return-Path: <netdev+bounces-148974-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id AB6B39E3ABB
	for <lists+netdev@lfdr.de>; Wed,  4 Dec 2024 14:00:54 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 89B3416947F
	for <lists+netdev@lfdr.de>; Wed,  4 Dec 2024 13:00:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 64EFB1B4130;
	Wed,  4 Dec 2024 12:59:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="TAIbG0jr"
X-Original-To: netdev@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.15])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8EB001B395D
	for <netdev@vger.kernel.org>; Wed,  4 Dec 2024 12:59:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=192.198.163.15
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733317183; cv=fail; b=lFUoVFfaWjC1ijS5A3VohBRy7boVcqp5BCxp7EsDrSf17JY3/AhQWbW1fwjclvXpT1MpmpRopwfn9Yl/nXp3Wj7AnSqlHYa1ExoLy/6De0MOMOhfUv2icfFTScABJOdo/hBgAZ1O1K/3qqPWmh5ezLPOh7NmKO0sVEHoh7qOFqo=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733317183; c=relaxed/simple;
	bh=DUgha/uMrXOrTijA7qgD6rQPlTFJXkIrIW7Jxn9Pvwc=;
	h=Message-ID:Date:Subject:To:CC:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=BksIMRYaDA+J7vCnXlMT1QOW0unEgz6V2A1zHGMynQLlqYT3Se3HENkyNhMY2jcZc8O/oF2WDAnpoZdikWtN/yudT3/2OiNOixOprlLd0pqsqbl/UEb2yrkqYmh4xP1U9fo+wxlld+sWuv5HBETpKZ/pZfBIkf140KAjQvo9xcg=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=TAIbG0jr; arc=fail smtp.client-ip=192.198.163.15
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1733317182; x=1764853182;
  h=message-id:date:subject:to:cc:references:from:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=DUgha/uMrXOrTijA7qgD6rQPlTFJXkIrIW7Jxn9Pvwc=;
  b=TAIbG0jrMwi3O5NSDqLHmtssHeqONreTJmQ8t4O5hTt9ppIiMuTX57PX
   T21s+js8AGmNq5J5+4eozg4RPpKppg8XBjEpJwzk+wHDfHiBk9iikXNRn
   pJivUpNAvLmpvvmD2OPWlZv9q3ngeHyT1zMm6ajZuBOATOA0BXcRV78oS
   V84rFaf6M4Z21wRHReWqm5ruv2MNEIGA0WGAXlOZc08sI/qRPY5OMoLOk
   J4N+X7fih8nC81pPMsAZ69/G6wE+25GMFVAriAEhgzucQBP4HT/nYiJhI
   Fan1KUBDcgYNQNWKBffw8eZeHWh9lKGVDDoScb29SoX4Sudm/ZNQllAD6
   A==;
X-CSE-ConnectionGUID: VkmsckdSRRamavB8ZWB75Q==
X-CSE-MsgGUID: uQqq/g/YTCuqoZlSEdKGoA==
X-IronPort-AV: E=McAfee;i="6700,10204,11276"; a="33710851"
X-IronPort-AV: E=Sophos;i="6.12,207,1728975600"; 
   d="scan'208";a="33710851"
Received: from orviesa006.jf.intel.com ([10.64.159.146])
  by fmvoesa109.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 04 Dec 2024 04:59:41 -0800
X-CSE-ConnectionGUID: IOKCmRjoRCKT/3V8wUh7OQ==
X-CSE-MsgGUID: K5Ah8o+cThOUiczTrDexHQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.12,207,1728975600"; 
   d="scan'208";a="93841290"
Received: from fmsmsx602.amr.corp.intel.com ([10.18.126.82])
  by orviesa006.jf.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 04 Dec 2024 04:59:40 -0800
Received: from fmsmsx603.amr.corp.intel.com (10.18.126.83) by
 fmsmsx602.amr.corp.intel.com (10.18.126.82) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39; Wed, 4 Dec 2024 04:59:39 -0800
Received: from fmsedg602.ED.cps.intel.com (10.1.192.136) by
 fmsmsx603.amr.corp.intel.com (10.18.126.83) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39 via Frontend Transport; Wed, 4 Dec 2024 04:59:39 -0800
Received: from NAM12-BN8-obe.outbound.protection.outlook.com (104.47.55.168)
 by edgegateway.intel.com (192.55.55.71) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.39; Wed, 4 Dec 2024 04:59:39 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=IKdlgLn//D7Q70XY+lEQ5Jh9VEEXcMAjVfJpiCGay12QqT5NxEQ+OjFSdR9gK6Mg907OC/3uu2jq0q7Z+5IY5clWMTLbGPbKsAM/3TQT3X8/Cy2MrZu2Oksxms8nnY+4CHUkdKgZaVxV9IvJlVrL7GMP/wvjBP1mSZv743HtvStB2unAI/1SlKvvU9Bf4FLaVtxIbXh2P0Cjy9/xRWnORhWHboBidg7UAG9FQHvY4VFhSh/+CxS8B21ggJzcWFPaaGHP/PWsOXiGYOeReR7tdXchx1q3vFH3GePUghkoD+2biTpzzoNoeJmjVcOjP87pol0yB7EiMdvf8RIaakJ2Dg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=nSlmE9JszDXg65Xokwjrgz8D7s17dzMlNd89NK+kyX0=;
 b=WWAzdbRI488l68PIUhS0XUAbLCKM+y3PNlYtRxlljwjmaq4rSEv8P+mVR4Ymyr6SoSqt40vWUNQZd+NFFuTu85Ij6qm8nzaCnnYgrTylU0/N52Qtoyc66JFOOqmhBZgFjLT9J15rklaAlNagnMTq1C5R+meBe4ZyRHPvsNtS+TxnaASVmGQT79s3T91RPmrsllCatGbli3rTI4uawBOqOnZZu2sC3LqYFDv5Sp8U64UJlhUUSqH/PmzJp0VPRuJrRNOB0nhsqOqV9RDtJ0UEIv963OJ1AVR9TjPMl3u1x84KaxA2BnJtMEsxC7UzCVrp/ObmCe/C+G9P/6I8imdbMg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from BL1PR11MB5399.namprd11.prod.outlook.com (2603:10b6:208:318::12)
 by SA1PR11MB8793.namprd11.prod.outlook.com (2603:10b6:806:46b::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8230.11; Wed, 4 Dec
 2024 12:59:31 +0000
Received: from BL1PR11MB5399.namprd11.prod.outlook.com
 ([fe80::b8f1:4502:e77d:e2dc]) by BL1PR11MB5399.namprd11.prod.outlook.com
 ([fe80::b8f1:4502:e77d:e2dc%5]) with mapi id 15.20.8230.010; Wed, 4 Dec 2024
 12:59:31 +0000
Message-ID: <6d317ad7-84f4-4cfe-b7d5-22eafada0f17@intel.com>
Date: Wed, 4 Dec 2024 13:59:25 +0100
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net-next v1 04/11] vxlan: vxlan_rcv(): Extract
 vxlan_hdr(skb) to a named variable
To: Petr Machata <petrm@nvidia.com>, "David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>, "Paolo
 Abeni" <pabeni@redhat.com>, <netdev@vger.kernel.org>
CC: Simon Horman <horms@kernel.org>, Ido Schimmel <idosch@nvidia.com>,
	<mlxsw@nvidia.com>, Andrew Lunn <andrew+netdev@lunn.ch>, Menglong Dong
	<menglong8.dong@gmail.com>, Guillaume Nault <gnault@redhat.com>, "Alexander
 Lobakin" <aleksander.lobakin@intel.com>, Breno Leitao <leitao@debian.org>
References: <cover.1733235367.git.petrm@nvidia.com>
 <d28c09cf04d210255882d7f370862f60e8f7fdf3.1733235367.git.petrm@nvidia.com>
Content-Language: pl
From: Mateusz Polchlopek <mateusz.polchlopek@intel.com>
Organization: Intel
In-Reply-To: <d28c09cf04d210255882d7f370862f60e8f7fdf3.1733235367.git.petrm@nvidia.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: WA2P291CA0012.POLP291.PROD.OUTLOOK.COM
 (2603:10a6:1d0:1e::27) To BL1PR11MB5399.namprd11.prod.outlook.com
 (2603:10b6:208:318::12)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BL1PR11MB5399:EE_|SA1PR11MB8793:EE_
X-MS-Office365-Filtering-Correlation-Id: 6eaf4528-d87f-4562-99d9-08dd14637e55
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|1800799024|376014|7416014|7053199007;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?c0VTQWFDMWl2YnpPaWdaSlkzZTdpRUZ3enJHUEVxZHVIclg4ckRqZFphUkpv?=
 =?utf-8?B?K2s3eTJ6RW5kM2xmKzhGYU5oQkxyUkNzbnJEbGk2YThpamZxcHNsTy9ucmQy?=
 =?utf-8?B?NXdQcDdvb2h4UU4zMFZsVitEaTZNUDdjRzZGS2QvbmN2WFIvZDJnbmFjaVA3?=
 =?utf-8?B?bERmWVllbHBvSU9kOUFpY3dvalFuVFc1Z3FyRzJ4V25zcTlSc21tdDZia2RJ?=
 =?utf-8?B?UTFGSlFOTDN1VnV3K0JmcW1NRWg0U3N4NXFpQm9GaVo2MFdnQnJNMTdhenlJ?=
 =?utf-8?B?SjBiR1l5VHljWnRnTVNGRDZjd05VZFFwalJ5Ym5UbTJmaFF4V0RSbUF2NXBM?=
 =?utf-8?B?cVpyeWxhVHNLV2YzRFFtYnFDcFY4U0pXaFlTQ3lZRkVjVitkOG45VDhXQSsv?=
 =?utf-8?B?Vzc2QU84WlhxaHZCN01PK05ITXdwTWRJdExGNnpyZjhIR2JDSmlpU2lWUVFx?=
 =?utf-8?B?ZnZqTCtLdkNkV2FaRlN3L1FkN2xVbzc1RFczemFlVXVSYTM3Y2IyejlHMnVl?=
 =?utf-8?B?TnMzc2FLQUlDcDBLNU1QbzhpbnJlRE9QUVZRaVRrb09JMnlPa2FMNDY5Z2xO?=
 =?utf-8?B?eWpVaEcxaXFMUnBsa0RJTEtaM1ROMWxtN28yRFJuT2VmbGlMeitEbU1YSWtY?=
 =?utf-8?B?NndmbHFNN0pHZ202dmxKTUtENnJYSXBkYnJHTSs4Rko0YlJpcjhPSXNJU3Jp?=
 =?utf-8?B?ZVNaVlYvUFAwSW5NMzczelBqZktMeDI5WU5pS0dCRWpKYVJnZE1IZEoxV1di?=
 =?utf-8?B?MnpYVTg2TGovR0VBL1JzSERxa3htTGVjcjBDcWVYczN6YU00NVZrUkhlTzF4?=
 =?utf-8?B?QWwrUWdpclRxOHNlQ2tpS0ZmNEt1YVppTnZvY2hObUdNUGtLWGQxLzJKejM5?=
 =?utf-8?B?YmpzZ29vclJXbHZGQnZBb2hlTUhMajF6QkpuWjUvbmxhU0tSYkFsMXYvTW1r?=
 =?utf-8?B?Z1NjMm1uN3BHQmtOVGd0VUNOaEZFSVRrbm82SEJWMjFiQWM2NHROMVRUaTIx?=
 =?utf-8?B?VkdkOE9YeTVjZyt5NWdYRlhUT2lzQ3B2K2JJQjVZMHBqTVJDTWRaYkpncVhF?=
 =?utf-8?B?ZUJJaGNkaDlIanBpb1dtdFFxVm53b2R4YkpFZitxMUxidWo0Z0dyQU8wV2xL?=
 =?utf-8?B?endOTmgydm5ZS0JDYTJlSHRSd253U1ZYYjhLWFlZNnFvcldDaWFnTmJLUUZP?=
 =?utf-8?B?ZmloaXE3MDB4NnNHMTdkakJIYXorYnpYY0pVVTlGTklJeCtQNmNiUytHTlVN?=
 =?utf-8?B?cmtlQTRGKzhZc0o4WFoyQ0RrZzhIQXFqVW1mbEhGcE9DSFpzT1ZOL3NJQ25M?=
 =?utf-8?B?NStheTAyTk1SKzVQdWgxS0lTWkNVTGkrbENzUzhSUnhKVzJwYjVRRHFRNURB?=
 =?utf-8?B?ZXhyT1lONWdBdXkwV0NEVFhpL1c2V2lzQVJJVzJhRUM0RnkvaUYxTlpCU09i?=
 =?utf-8?B?T25DaW1pNTR6bUdSSlh5T3JjTkw4Qlc3YXpmbmZzbC9oemJWSnpaZkxsV2ky?=
 =?utf-8?B?Vzl1bXgyZ3FVOUVIQnBhUEgrSjJUSnZmejZCeXNnNW51VUJuTVNSbGhySUNV?=
 =?utf-8?B?aDdlTTU5dkJEb1h4bEJaTDVuUFVCbjZSRzh1UDU5eTVsUnJpT1Y0ZmxYOGZN?=
 =?utf-8?B?UlFIcEF3MXpDU05VWFVwNjhOVG8zRS9hZWVGc0prenJZM0lwKzZOdXBaS2lj?=
 =?utf-8?B?QU0vM1k3L0JaaUxWT3JvRWh1YjMyVldlbGZlQzNIaW0vTGpqczB1NHk4N2lS?=
 =?utf-8?B?b0J4Wk9RRmJVU3VMNmRTWDd4SDh0WjZrWDN5anNKcmVUaFNnd3BxUTdmeFlP?=
 =?utf-8?B?cHRKTU8xaWozdTluTDkzUT09?=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BL1PR11MB5399.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(376014)(7416014)(7053199007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?T2xJN1FqZ2Z4QzIzMTNxM2ZCVUkraEtDZzNwZ2VWUVZKdDRob3pkYWc1S2hm?=
 =?utf-8?B?aHZJSVNhdk9OZU1aNThIallHZUVBUVlpamx6ZHZtbDM2c3U4NGFHWjcyQndx?=
 =?utf-8?B?dm03ODNHMXBiakpWeUZ4amg3MlFwcGRWRk1LWXVGR0JjeUxGRkZTSDAvbGU1?=
 =?utf-8?B?bytEd1BqYjg0bEFna01udENpcENvS1Erd2R6L09FY2NNQ09wZ25XcXluN0Vu?=
 =?utf-8?B?eVkvRklsaGx5dlpvK3VEYjFCYjBGWHdNVGQrT242eHJyTFNuMFBBUm5yUUZS?=
 =?utf-8?B?VXhFNHNtTEgzb0w5UXZjcm1vMVY0VEhmaDlISTRrWWRlVVhVNXJoSkxuTzRZ?=
 =?utf-8?B?SmpPSFJ1M2haQVZaTmpGWm95T2lUV2U5ZENlQkU5QkU0ZTcxcm9pMGtvWlpC?=
 =?utf-8?B?Y1I4QkRQZkc3eVlCZFhIRWpUWVFSUzFOMFQ1Ylp1M1BIbmZXRFM3Uzl2YkJT?=
 =?utf-8?B?VUJYMWNpc2x1Y2tqdk5tRU1kelliSVQzTHFIM1JVSnR1SnZlbWp2SlNSVXh5?=
 =?utf-8?B?UjZ2TkNxdVRJa2ZtSDFZWlI3Z3NabEw2bnhuUStZWXNYcHpTbWg1cG85TXFW?=
 =?utf-8?B?WTZBajVpdmRoTlF4a21VMUU3UDhuNkY4dlNhMGlsYm5yY1RVVEFnczIwb2o0?=
 =?utf-8?B?Y0JJV0pVM05rYXZZdFQ2SHJmRTFyMjlyQlk0RysvV0pENlhqanprRFdqTWs3?=
 =?utf-8?B?RlplLy9Wa1VmakJNQTl0ZDNDU0hwazN6RXVrY24rN3ZacTU1UFRDZUN1Vnd4?=
 =?utf-8?B?SWJ6dmNSbTZodWt2elZlWWp3ZTV3S1pqNUl0K2xXKzZFalFhS2JRZFJiaklZ?=
 =?utf-8?B?QkxWdEZlTmp1RG5XR3FVMXRZWXk2MHpKT25kUFpZdk1IQmZYcENmb3l5Q2V6?=
 =?utf-8?B?VTlFUmpZNUVlaTEwRCt2S3RtdEpzUkhNbkNpNHFUYnpxREdNWTVhcmc1ei80?=
 =?utf-8?B?Rlc1Q0htSkM5aE1iaXgwZHF6aXZ3UkNEbUhZbGkrUEgzakNvUHR6eFZQS2N0?=
 =?utf-8?B?Sis5MFpEampYSGI1dWhtSTEyYlF1ME83cmg1R1VwQml0eDQ0cHhEdGo2L3Zl?=
 =?utf-8?B?eCtyRU9wQTF1UTdhWUpGTmg3Tk9tMVZOM2w4c1AxSjNLTERkV3IxVitFVFg2?=
 =?utf-8?B?dmhORG1xWG5vQTdFQ1lSNWxBLzloV3p5dkwwK3V0TlQyRVhIRkVvTjE4T1F6?=
 =?utf-8?B?blhacGRvUFdYbXNCbzBnN3JXOUNCcGpNNXc0b29wUFB1QWRHTm96VjZQd3Fl?=
 =?utf-8?B?RmZNR3RwcmFiS3BkaTBSSnZabmt5L2FlNEFiZUZCeCtNT0FGaUZNODYrM1li?=
 =?utf-8?B?Lzd3RDIrS2NuWXJxVkZmMGJmQ05iQm5pT3Z0UDZTWUQrZm1WUmRUcTg0ZEQr?=
 =?utf-8?B?aUczTWdTaHA2ZVdhYTF1WjB1cU9wYkQvNDJJK29JTmlIVmhEUkNoNjBmUzNU?=
 =?utf-8?B?NVlEMjM1Ti8razFsbFVycmhNbWlPNnU2ZnFzbVZ5d24zKy9UaVRkdmxhSnVt?=
 =?utf-8?B?aExxVzlpMk9zZFFFRHI5UVYxbmVGekdXeldRZEk4S0lDYVZFZUhqTDhnRHRV?=
 =?utf-8?B?T2ZjbyszZ210ZnBpNG9ZL1o2YnA2aytjVE1uQ1I4OG9VWEx5RC9XL3JlT3Vh?=
 =?utf-8?B?L3JhZkJpejkwL1RITmZvbVRkN0hDRzFXYzVMbTdJOFhoOEc1anJuRHordHY3?=
 =?utf-8?B?eHF4eFZmcFFFdkdLeVZEOGIwWU1DMEc1U3Y1dGtEazEvYUhidjJ4R0MrNHZI?=
 =?utf-8?B?d3FXMnJqOUVpZmQvUzBDOWdTREx3UDFyMlp1MEIwV2t2TFM5Z0o3Zi9XL2hx?=
 =?utf-8?B?UmpTR0hyNnc0MVhxQ0luQ1gyTTF0UkMwUXUrSmlIaERFOUVraXNZUXM3YUtV?=
 =?utf-8?B?d0RiT0VObVR4RzBsaTJQM1hHZ3JhRG5UY2Z1NTFCS0FqOFp5dDFCTXpoc0Vr?=
 =?utf-8?B?MVBMVUhkNlV4QnJSb3pHeDNudVRGWG15amQzTGZ5QldqZmNXU1hkeHlVdXBV?=
 =?utf-8?B?SUFYbytLUnZ1a0g1Rkxad1UyWi9QN3J0UFdQWGUrWWhzbTdySEFJL1prSlhq?=
 =?utf-8?B?cjB0ZVBLSXJiM0JLSy9SakpORzlET3IyR1ZrSjJITzF1azE3dlM4TnNNbHYz?=
 =?utf-8?B?ZGs0SmNKRW1Bd1pwQ1lzYyt3cHZEMkdmcXhoOXNhU1dHVFp4LzF4MFVhSWZj?=
 =?utf-8?B?c2c9PQ==?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 6eaf4528-d87f-4562-99d9-08dd14637e55
X-MS-Exchange-CrossTenant-AuthSource: BL1PR11MB5399.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 04 Dec 2024 12:59:31.2829
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: kUQwexhBuym3ucSsrMCdn/YUMBMdmivIzCczLYKxURImlzdDKlzFJJWNiDd9t/xtx9lgDDLvVYBxUVFCCsocFoboU6i4DETURt4a4WxSRGY=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA1PR11MB8793
X-OriginatorOrg: intel.com



On 12/3/2024 3:30 PM, Petr Machata wrote:
> Having a named reference to the VXLAN header is more handy than having to
> conjure it anew through vxlan_hdr() on every use. Add a new variable and
> convert several open-coded sites.
> 
> Additionally, convert one "unparsed" use to the new variable as well. Thus
> the only "unparsed" uses that remain are the flag-clearing and the header
> validity check at the end.
> 
> Signed-off-by: Petr Machata <petrm@nvidia.com>
> Reviewed-by: Ido Schimmel <idosch@nvidia.com>
> ---
> 
> Notes:
> CC: Andrew Lunn <andrew+netdev@lunn.ch>
> CC: Menglong Dong <menglong8.dong@gmail.com>
> CC: Guillaume Nault <gnault@redhat.com>
> CC: Alexander Lobakin <aleksander.lobakin@intel.com>
> CC: Breno Leitao <leitao@debian.org>
> 
>   drivers/net/vxlan/vxlan_core.c | 11 ++++++-----
>   1 file changed, 6 insertions(+), 5 deletions(-)
> 
> diff --git a/drivers/net/vxlan/vxlan_core.c b/drivers/net/vxlan/vxlan_core.c
> index 4905ed1c5e20..257411d1ccca 100644
> --- a/drivers/net/vxlan/vxlan_core.c
> +++ b/drivers/net/vxlan/vxlan_core.c
> @@ -1667,6 +1667,7 @@ static bool vxlan_ecn_decapsulate(struct vxlan_sock *vs, void *oiph,
>   static int vxlan_rcv(struct sock *sk, struct sk_buff *skb)
>   {
>   	struct vxlan_vni_node *vninode = NULL;
> +	const struct vxlanhdr *vh;
>   	struct vxlan_dev *vxlan;
>   	struct vxlan_sock *vs;
>   	struct vxlanhdr unparsed;
> @@ -1685,11 +1686,11 @@ static int vxlan_rcv(struct sock *sk, struct sk_buff *skb)
>   		goto drop;
>   
>   	unparsed = *vxlan_hdr(skb);
> +	vh = vxlan_hdr(skb);
>   	/* VNI flag always required to be set */
> -	if (!(unparsed.vx_flags & VXLAN_HF_VNI)) {
> +	if (!(vh->vx_flags & VXLAN_HF_VNI)) {
>   		netdev_dbg(skb->dev, "invalid vxlan flags=%#x vni=%#x\n",
> -			   ntohl(vxlan_hdr(skb)->vx_flags),
> -			   ntohl(vxlan_hdr(skb)->vx_vni));
> +			   ntohl(vh->vx_flags), ntohl(vh->vx_vni));
>   		reason = SKB_DROP_REASON_VXLAN_INVALID_HDR;
>   		/* Return non vxlan pkt */
>   		goto drop;
> @@ -1701,7 +1702,7 @@ static int vxlan_rcv(struct sock *sk, struct sk_buff *skb)
>   	if (!vs)
>   		goto drop;
>   
> -	vni = vxlan_vni(vxlan_hdr(skb)->vx_vni);
> +	vni = vxlan_vni(vh->vx_vni);
>   
>   	vxlan = vxlan_vs_find_vni(vs, skb->dev->ifindex, vni, &vninode);
>   	if (!vxlan) {
> @@ -1713,7 +1714,7 @@ static int vxlan_rcv(struct sock *sk, struct sk_buff *skb)
>   	 * used by VXLAN extensions if explicitly requested.
>   	 */
>   	if (vxlan->cfg.flags & VXLAN_F_GPE) {
> -		if (!vxlan_parse_gpe_proto(vxlan_hdr(skb), &protocol))
> +		if (!vxlan_parse_gpe_proto(vh, &protocol))
>   			goto drop;
>   		unparsed.vx_flags &= ~VXLAN_GPE_USED_BITS;
>   		raw_proto = true;

Overall that's cool refactor but I wonder - couldn't it be somehow
merged with patch03? You touch vxlan_rcv function and the same
pieces of code in both patches, so maybe you can do that there?
Squash those two patches into one? It seems that in this patch you
change something you already changed in prev patch - maybe
it should be done in patch03? Or do I miss something?


