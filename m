Return-Path: <netdev+bounces-149358-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 1DF789E53C8
	for <lists+netdev@lfdr.de>; Thu,  5 Dec 2024 12:24:59 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id E7E7E16A62D
	for <lists+netdev@lfdr.de>; Thu,  5 Dec 2024 11:24:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 64BC0206F2E;
	Thu,  5 Dec 2024 11:22:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="e9kZeoh/"
X-Original-To: netdev@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 13D332066ED
	for <netdev@vger.kernel.org>; Thu,  5 Dec 2024 11:22:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=198.175.65.17
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733397738; cv=fail; b=j7Z7QKAU5SgWawP8ANjRQlFmZhRuVBE3Uz6aBOTXJKN1CyhPfoPiM3YBeBykIx1vMk12Hzoo33OkvyAA12R4ZRTpdcHMcOzb5gnm9qhifRqTVEoqDTF4jc5WkQGXtxFxJDrKoHQedEP9HlCE6553MO1522x/PYp94VAv4rV5cC4=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733397738; c=relaxed/simple;
	bh=iqDwrUfbQJ6YbGVFBGgK57x+otOcwA9VcG5jId8cosw=;
	h=Message-ID:Date:Subject:To:CC:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=pbXPOiM5BGAgVLWvbbjeC22GqEJ3Eqb+nSxzV0MfALCT3s5mdJpUanJp45eINPnj+iflk7zHoaibkZ1S5tN2jq7Vr4847HHNrMgQFpESwFlJ8woTEUngHtWZ+ydBARRjSzj5oSj4g6aJr6xtlJsvMlYzYTarHs5wuCelt0TBOsQ=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=e9kZeoh/; arc=fail smtp.client-ip=198.175.65.17
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1733397736; x=1764933736;
  h=message-id:date:subject:to:cc:references:from:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=iqDwrUfbQJ6YbGVFBGgK57x+otOcwA9VcG5jId8cosw=;
  b=e9kZeoh/PAQi7/Iumz0tddfHmA/An9c+ygvI3xneu6yScQom6fkAoqXu
   o3o2m/9p9mbzw+Tzy8cuDavIx+85QVJjq0uqubCT/50fgD/btc+qqMglX
   cgYmRDOocENTWcFnb+AmHXM8ZjpYsRH5qf2DJurKYR3+xtPqKISldnhQx
   tQs4lia02FLr8+q7D3q4WOwi6OHJDKcOj57kx+dr/qMFChhY4T/rvFIKx
   1w8T6OPpATNOn3A4sBubg2Ud+a1cbM14/IQg0+XFQzww2mJCO75OFla5q
   /N11JLCH2hUqWI0FPZ9NzjWvqIzzgTPqKHftEqJ6P1SQTdc2DAFMnEnpp
   A==;
X-CSE-ConnectionGUID: VigKRKECS6me5IpuOsK3cg==
X-CSE-MsgGUID: EypFuXrcQG6dHSt8/EUi2A==
X-IronPort-AV: E=McAfee;i="6700,10204,11276"; a="33764661"
X-IronPort-AV: E=Sophos;i="6.12,210,1728975600"; 
   d="scan'208";a="33764661"
Received: from fmviesa005.fm.intel.com ([10.60.135.145])
  by orvoesa109.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 05 Dec 2024 03:22:15 -0800
X-CSE-ConnectionGUID: gCWaQ9+URY2QLJ/sW8FxiQ==
X-CSE-MsgGUID: +HSABqgtTcSmZgjN61O6qg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.12,210,1728975600"; 
   d="scan'208";a="98516015"
Received: from orsmsx601.amr.corp.intel.com ([10.22.229.14])
  by fmviesa005.fm.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 05 Dec 2024 03:22:14 -0800
Received: from orsmsx601.amr.corp.intel.com (10.22.229.14) by
 ORSMSX601.amr.corp.intel.com (10.22.229.14) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39; Thu, 5 Dec 2024 03:22:13 -0800
Received: from orsedg603.ED.cps.intel.com (10.7.248.4) by
 orsmsx601.amr.corp.intel.com (10.22.229.14) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39 via Frontend Transport; Thu, 5 Dec 2024 03:22:13 -0800
Received: from NAM11-CO1-obe.outbound.protection.outlook.com (104.47.56.168)
 by edgegateway.intel.com (134.134.137.100) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.39; Thu, 5 Dec 2024 03:22:13 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=CfUAVNmxN9wCZqD8WVzs2k73H3oePTefuYTCRyJSki2r7c1Z45KNrLdOkcP5bpFIlp/I8jGJaHTVQxY6fcl3WhSPKpoBHkgAUHElshcqeNgFpg58EX0m3JlmrvlByYOkEnbLhZgCjTkgZKu8c4Pi/VVjmlQfiGWYAbbP0rFbZzqrjqBG7coxXDnkMZQ2ql2UBH4ZrIzPmpk+In025DicNDiAiqCB8Z84nR0NSaquy03QnLprNk9eNxApJIoFaONlXUR27r+G+dmjbws/CD+TlnvOYldTL5qRgdMRa0wqxODjsUc8ZZ2foApFTxs1oN3ScuLICR232iaVxYCOL1m2Mg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Cx9HMU20ltVUidRjzmpMfgF4qXdd/0a4j/4NwpoCH9A=;
 b=GTfbXdlk8IvRdscgwhq7qJPzCQfgscEDdURMJgF5fHbrGlXqy2MraBweQP5yszfX6MTS5OuCJIAxxi9kzLAl7seWiQGFkUBkiaUQjLV5LXPW3V5Teo2a52YiL25bCPRyU3wiI53OzP6pwGfYw4XkefvPytXYKqRgGoTtuaDBdPNrmgs8Ya7PM2301RvdiA39bnJ1aJfgSS86jiiqpVAnJ0+EMA7MiTmMEce7oE4BFXl4HH7g03bPmYc9NpIRPUNEDN8OH546s96ylBoKfu3Nb4j3EaBB61V7+mN2iDBqic+j7pFvPeITNedm+NGHWCTzC8Y/JQEy0r3RbN5ZDCMnbw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from BL1PR11MB5399.namprd11.prod.outlook.com (2603:10b6:208:318::12)
 by DS7PR11MB7740.namprd11.prod.outlook.com (2603:10b6:8:e0::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8207.19; Thu, 5 Dec
 2024 11:22:11 +0000
Received: from BL1PR11MB5399.namprd11.prod.outlook.com
 ([fe80::b8f1:4502:e77d:e2dc]) by BL1PR11MB5399.namprd11.prod.outlook.com
 ([fe80::b8f1:4502:e77d:e2dc%5]) with mapi id 15.20.8230.010; Thu, 5 Dec 2024
 11:22:11 +0000
Message-ID: <f478c65a-d70d-4cf8-a742-e0456cf97fd4@intel.com>
Date: Thu, 5 Dec 2024 12:22:05 +0100
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net-next v1 04/11] vxlan: vxlan_rcv(): Extract
 vxlan_hdr(skb) to a named variable
To: Petr Machata <petrm@nvidia.com>
CC: "David S. Miller" <davem@davemloft.net>, Eric Dumazet
	<edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>, Paolo Abeni
	<pabeni@redhat.com>, <netdev@vger.kernel.org>, Simon Horman
	<horms@kernel.org>, Ido Schimmel <idosch@nvidia.com>, <mlxsw@nvidia.com>,
	Andrew Lunn <andrew+netdev@lunn.ch>, Menglong Dong
	<menglong8.dong@gmail.com>, Guillaume Nault <gnault@redhat.com>, "Alexander
 Lobakin" <aleksander.lobakin@intel.com>, Breno Leitao <leitao@debian.org>
References: <cover.1733235367.git.petrm@nvidia.com>
 <d28c09cf04d210255882d7f370862f60e8f7fdf3.1733235367.git.petrm@nvidia.com>
 <6d317ad7-84f4-4cfe-b7d5-22eafada0f17@intel.com> <87ldwuie1s.fsf@nvidia.com>
Content-Language: pl
From: Mateusz Polchlopek <mateusz.polchlopek@intel.com>
Organization: Intel
In-Reply-To: <87ldwuie1s.fsf@nvidia.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: ZR0P278CA0138.CHEP278.PROD.OUTLOOK.COM
 (2603:10a6:910:40::17) To BL1PR11MB5399.namprd11.prod.outlook.com
 (2603:10b6:208:318::12)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BL1PR11MB5399:EE_|DS7PR11MB7740:EE_
X-MS-Office365-Filtering-Correlation-Id: a89414cd-c2e1-40ca-76cc-08dd151f0feb
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|7416014|376014|1800799024|366016;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?QzRTeXJMcEE1andLeGlrSTRzd1RoVkVqMlJnSHJmdnlhWGFJeDVuSk1NNHd6?=
 =?utf-8?B?NStlTlRFc3FGTUs5MVNxUkxBUGxKUzh6Wk8wYjhyRnhSOXcxc1c2V1puMkhH?=
 =?utf-8?B?dTRvRWtVa3RCYlNOVG5yb2VGRGw0UVBXK3k4aldRQktXYTRwMTVsY042UTkr?=
 =?utf-8?B?QVdBTUJNV3g3OXNRay9ocmluS3dWKytxOUt1QzFDVlBBTFlXUGdFWWhNQnV5?=
 =?utf-8?B?RTV6L1FJdEdPWXRpOVZyOUhMOENuc1BOcXBuU2k3anE0Z0RUTXdFMk5kYUhV?=
 =?utf-8?B?OHRmWUdhYVFqV1VGd0o3UmczamV3OXhkdVN5c2F2aTBKcitaWkxJWU5EQjc3?=
 =?utf-8?B?OEwwQjNITi9hNldvZmRLakc0TUxkaXo1SkMvM1QvcGRzc3ZRb003cUhZcjVH?=
 =?utf-8?B?TmNQekJvdHY1T3dTcGtDS3UwVWdjMURZeDRHaCtONnBQSXl6VUdpckRhTVVF?=
 =?utf-8?B?ZWlhbGZhUHBEamlVZG1nVkRDVTZMRzhRQm44OGQrb2IzNGtEWTQwRTlBYXp0?=
 =?utf-8?B?YnZ0d0IyMUVPaTNDeExjWVkrcGJIaUNpelQvVG95SnNOcGt4TjhFZi94RWpN?=
 =?utf-8?B?bnlMUXlmY2dORTNYSGgyR1Y5UmY2NHdBa21xcmJWMlVQWmhadCtOcE9mSnh4?=
 =?utf-8?B?TUg3QVgyS1lMU0t5amJGTHlPT2hVSG13TWFKcUwvVzdJVjR1SzkrVkwzTEpE?=
 =?utf-8?B?NXZ2UHo2bzkvSzU2TmJCS1BnK2xlNG04RTBYRWFkTkd5K0RFdEl5VHJrVWJI?=
 =?utf-8?B?NzVqb1ZuMFhLUWlQNTArNGlIdU1pb0hwak9teW04L2dzUlI2NlZzUFBmQzdU?=
 =?utf-8?B?OS9vTXB2Rjd1MGNVZzd1TDNzK3k4S1RIWkt1NnNRYTdCMVVjcnNvWFB4RENO?=
 =?utf-8?B?dDdmTnhQTzZtWTZYY2ZrTWFCYzNlUjhzUm56WlM3M0QraG9uOGd0YWQ0dGR6?=
 =?utf-8?B?NjlJNGxYeEcxaWFuR20vdlowUk5CeFFtaFhrK3pnN01xVVN0MUlBL3ZCeklJ?=
 =?utf-8?B?cVNXeWtCVXAwWnJpUDBsRnIvTW5PTDRVYmpBc2ExL3BFeHRPY0x4Y083VTlJ?=
 =?utf-8?B?aFpkdUhHSzR6QUdsM3Bhb0V6RWhWNHNDWEdGekhLeHRVcFlnQzA4QitrcHFS?=
 =?utf-8?B?TEFieVlOOUdNcTFERGt3TG5XbFRKOER6bjIxbURvMnBta1M1QVQyV3VGTFNP?=
 =?utf-8?B?d1pPai9yTU5ySjdJL3U0WGFWS1JTVDVxbVBXZnFEcXl3M0FrV09wVVZyOEdH?=
 =?utf-8?B?TVVaem9uZW1kK2grYUNqRmU4VDlrbDhKY09nNGRaVjVNUUh2YS9LeXNTZHBO?=
 =?utf-8?B?elh5MXdOc2ZTTyt3S1lvZmxhZWlMTGwyajZYSDN3bXpHZjAyVlhRVUxWZEhT?=
 =?utf-8?B?M2E3d0pVTDF1djFWYm83dC9hWWQzeXRmaWJrQlFzU3NFSlNuNGloRUlOT25P?=
 =?utf-8?B?RTR4MUFSeE1ETmd5bmRBS3Z2bjh1M3gvSkg5ZlVLb2xFWjM2cG9UOTY5aG5Q?=
 =?utf-8?B?YUV1VjJSVi9FQi9LdTJIREdEek9ETTBUdUg3Y1NNVTcwenJlZk14V0JYMWtC?=
 =?utf-8?B?WEF5alpRdVc3M0ljZFpZYWVXa2hEb21vODdwd1BiNWRoR253L21Yc09KMWRr?=
 =?utf-8?B?NVFUcWxJUit5R2FIS1BtUkl1R25QY244eFlYQlhROWs2d1VBNDN5b05ScjJI?=
 =?utf-8?B?bzZWWkc3eUdWdUVyWkNIZWRQSHpwZnYwSkRoWThWNm9CWUxaOW44OFgxckYy?=
 =?utf-8?B?d2xHbVU1eWR2Y2ZxWlYyREtYZERNRlBSWEp4VTZPVCtDVGd0R2prMEI3dzkv?=
 =?utf-8?B?SCtVT2JoK012ajE4TFgxUT09?=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BL1PR11MB5399.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(7416014)(376014)(1800799024)(366016);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?NCtjSXVmN1VDVEYrU2RoQnFTUDVIbWFYTWI3TFRkOXFQTzROaDcxWDNMRDZP?=
 =?utf-8?B?TFd0eUkrY01zK0pLVG5lVUR6ZjgxK0p2Nk9VeFNMb0tnWE5MS1gxSGpUVU5i?=
 =?utf-8?B?Z3NDb1g2ZENiRVJtTFBJeVVybXpTZG84Qm55NFFvUU5OTlVwTWtsdnFRVTdI?=
 =?utf-8?B?bFQzaTdOUkFrMEVBdmVSeWNDaVZ6b084NnZLM2ozRlpkcFZWUnJuVGVVRTJC?=
 =?utf-8?B?SHBCOWNjZXVFeXZWTnJwL0dQOGJKdk1BUE9SL1hkaDdYdUQybjVnNVNNczgx?=
 =?utf-8?B?QSsweER1TXR2L0pQYnl2N0E3MDhrVmRENmtIUlUvSnlRWFkyamVPTmR4Mm5r?=
 =?utf-8?B?WFptM0h3R1FRUEV4ajQ4Mk9oSG9kNG03UjB6WERJcDdNcEYzMzN3akhkbnI1?=
 =?utf-8?B?d0JTMDU0REorY2VUSW5HSkExd1ZOSmJCQ05Ldmo2Q1ppbGpRcjBFQnRIbVI2?=
 =?utf-8?B?MEd6QmNPNnpncTFLb1ZTVUNCVDd0aDU1MTQzbEhiWldaUzJEMG40K2VZYUpv?=
 =?utf-8?B?UGhlSDZwTUQrOTU1TWYxeVZZc0NkOHR1dktqL2NobVZ3eU1xTlpUdjhiVmZD?=
 =?utf-8?B?TnFjc3YwSUlOemxvRWNhRWFZTlNBMTkyS0JmYTM4NkF3N1dnTTVVZXhYcldl?=
 =?utf-8?B?N3ZvNEdZRG9abDlMRVc3ekdINUhVMXNZbk5aNjJuU1lwZnR1WUdIRkwxZGNB?=
 =?utf-8?B?cmExV3RPQzJ6TUJYNE81dFM3UFdrTi9lQUxFdTBCSmRJK1k0VVVhSW9teEVM?=
 =?utf-8?B?Q2QxY0s1elB3ak5FVitEN0lUNHRGbEprUDZoS0xPbTEyRGIxNTNZcURycDVH?=
 =?utf-8?B?Q0VacDJJallUWDNCZXQ0TkRJQlorR1pZL2hPQlBBQ1F5WmJQdE5hVlhaT3RH?=
 =?utf-8?B?RTNpL21mbzdXUWI2V0E3eFF5NHJsVzJjM3daMFVKQStLbTlUenRmc05WejNn?=
 =?utf-8?B?OVNZUDlTcEFEWHVmSHY1WmtzdWJmeWpaYWw3S3hCT0FRUUlUSW1hNWEwU1dy?=
 =?utf-8?B?cERERWFXSmxQYkxiLzJCelAraHFjQmRVMU9MWDltU2JFQWp6N1hJc1dNNVlQ?=
 =?utf-8?B?Y0VkZkY5RnhMaEgrY1VDYVRqbmFodlE4MGl1aGZuL21tQnI5VlFoU09sdGps?=
 =?utf-8?B?d2VrV0I1eTVScmdiZjhVWnd3UVNmQU9CandSZCtCYVBKUW8xUUY3Y0MrQnZ2?=
 =?utf-8?B?UkMyTlI2MnMxZkY3N241MmFlZVMxWTNWUEdDaVVjZnBtSUhnQStma1B1cVd4?=
 =?utf-8?B?YmUwZ3JsMU5NQ1pVTWRBekNoaThwNUY1NGxVRlJnUmJTSVllaEg2TURwOE40?=
 =?utf-8?B?TmdNRnZZZzEwTDhQSG9mMjBvU0tkYzZrMjhHOG1iRVFWbWcrVjk4SjVaUUdq?=
 =?utf-8?B?Rit5OFFScStpanRsY01HaTArKzdKcG84bVAySXZmeTJiOHNMZzB1QU5DVzlZ?=
 =?utf-8?B?ZVNhUkQ1clZnQ0NpSHlCZlpMV1B6bmQ4cStvbnVDNVdUdkQ0L0FpK0l5d2kw?=
 =?utf-8?B?ZnducW9GVmt2amdlV1h6QmtSZVhHNWd0Q0pzRzJLd05rQllSalJLWVpxaWk0?=
 =?utf-8?B?Z3ZsMURUK3M4RFJVT2plMkhwRDV6dUUrTk8xVkhKbW4xT0xoV3RCeEJydHZ5?=
 =?utf-8?B?S2pscko0S05wNEJVeDA5eVh0SmMvMlBlTHRSa211ak5sVkMyWnJkT1hic0hi?=
 =?utf-8?B?bVpIaFNobGFuSWZZOWp0Z2pYZ2V2YkZTN2hQVTZvc2ZuSEpobklFbnd1NmJi?=
 =?utf-8?B?cDVhUXVkMUxmZ1RQWWZ2ajVjS1RONWQ4bEdhRWVCSHYyanVSeEFJVHhOejNJ?=
 =?utf-8?B?ZFJMcVdzVk5HSzJrOHpRRVRVRkkzOTRYTkdLUG5jZ0RUNzBERVovVWtGa0Fi?=
 =?utf-8?B?U005REk3U0g5cVd4THlaczYzTlhzdERabFRkNDFwZmRoQXVkTWpDNFgvT1VW?=
 =?utf-8?B?THluTUtKbWJNd2pBdUJyVHRnRHZtTEtSNWpEZVRDL3MvWkw1aGRLLzJPaTB0?=
 =?utf-8?B?cEFEbG0vOEg0UlhvS08xSzBRUWZIYXRzaGMvcU42UjMvc1NpSW1hdERkN09u?=
 =?utf-8?B?SElLWVhOaGhLcE9xbWNpV3lvWFRmNnVPY1VsOGtDbnE4MGN2dFBzU2dac21D?=
 =?utf-8?B?ZzdnV1lJaWtHWks5NkJmM1NpanY2VDZveTd6aGttS1JBYjg0L0o2ZDUzd0ln?=
 =?utf-8?B?QlE9PQ==?=
X-MS-Exchange-CrossTenant-Network-Message-Id: a89414cd-c2e1-40ca-76cc-08dd151f0feb
X-MS-Exchange-CrossTenant-AuthSource: BL1PR11MB5399.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 05 Dec 2024 11:22:11.3580
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 25iDA/eOlCZkAVc5kdhBC300DtncF83SZR+Jl3YE5wq10DMz3A3YdbRm2xqcUk+uvp/qF1Rc6lD3vKnNC7orxbexcW1iq+f/oAHPS1WqsBE=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS7PR11MB7740
X-OriginatorOrg: intel.com



On 12/5/2024 11:44 AM, Petr Machata wrote:
> 
> Mateusz Polchlopek <mateusz.polchlopek@intel.com> writes:
> 
>> On 12/3/2024 3:30 PM, Petr Machata wrote:
>>
>>> @@ -1713,7 +1714,7 @@ static int vxlan_rcv(struct sock *sk, struct sk_buff *skb)
>>>    	 * used by VXLAN extensions if explicitly requested.
>>>    	 */
>>>    	if (vxlan->cfg.flags & VXLAN_F_GPE) {
>>> -		if (!vxlan_parse_gpe_proto(vxlan_hdr(skb), &protocol))
>>> +		if (!vxlan_parse_gpe_proto(vh, &protocol))
>>>    			goto drop;
>>>    		unparsed.vx_flags &= ~VXLAN_GPE_USED_BITS;
>>>    		raw_proto = true;
>>
>> Overall that's cool refactor but I wonder - couldn't it be somehow
>> merged with patch03? You touch vxlan_rcv function and the same
>> pieces of code in both patches, so maybe you can do that there?
>> Squash those two patches into one? It seems that in this patch you
>> change something you already changed in prev patch - maybe
>> it should be done in patch03? Or do I miss something?
> 
> Look, I'm juggling various bits back and forth and honestly it's all
> much of a muchness. There's nothing obviously better whichever way you
> package it. First changing to open-coded vxlan_hdr in 03 makes sense,
> because it's already open-coded like that several times. Then we have a
> clean 04 that replaces all the existing open-coded sites, including the
> new one, thus everything is done in one go.
> 
> I'd just leave it as is, largely because I don't want to touch something
> that works for frankly cosmetic reasons when the end result is the same.

Okay, you convinced me, so for this patch:

Reviewed-by: Mateusz Polchlopek <mateusz.polchlopek@intel.com>

