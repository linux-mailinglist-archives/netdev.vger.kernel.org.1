Return-Path: <netdev+bounces-105661-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 64B049122D9
	for <lists+netdev@lfdr.de>; Fri, 21 Jun 2024 12:55:03 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id C0B4CB21419
	for <lists+netdev@lfdr.de>; Fri, 21 Jun 2024 10:55:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CB30D171E54;
	Fri, 21 Jun 2024 10:54:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="N2tZ03n6"
X-Original-To: netdev@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.20])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D6F2A171679;
	Fri, 21 Jun 2024 10:54:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=198.175.65.20
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718967293; cv=fail; b=hZ7PhuLBxT9X9QSes7EuMXFBdZZA+EqI0OXPdQtiefM5atLzdEOCR7L5n/sQqaqAsX7IkChd+DPJfFxsklZVuSg2StTr4mKUWL3D17BMApX3Lal4MDDavCuh68uDhPDsnCPuHbbMVqayawBaoBhlvc2qfF7G1liQ+UfwkWNDwq8=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718967293; c=relaxed/simple;
	bh=/4rSgQc5gFhAJpw8/5WR7Ht4lps7Kh4Lj4oMO3ZHZEs=;
	h=Message-ID:Date:Subject:To:CC:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=eg8swCcwHh6R1S/ajZcKcfwTz9QZ3M5dZi8Ka7JCpPbMruropA51yoQ4pBQYmql4oU5PmwiziI3wzOAe/SciQIKvd9YqDTX5gRVSQNonfmBKJ2KzS3IPiQ+QyjH+OmIdZNdiE8Ee+rJsyXHjQrBRU9Z7ZG3/WBKbZWESWNV+lYg=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=N2tZ03n6; arc=fail smtp.client-ip=198.175.65.20
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1718967292; x=1750503292;
  h=message-id:date:subject:to:cc:references:from:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=/4rSgQc5gFhAJpw8/5WR7Ht4lps7Kh4Lj4oMO3ZHZEs=;
  b=N2tZ03n6+JqqPQub19GzHYdu2afN79lmuwX56saLr4kD68YOsMbRHVVs
   LmzVLVprXylEmcxZosdtE/sUMkigU/4w1ye/N6cpRHqBYm8urPZEZ6J0d
   Rt+g409JjpaenwznU7/XpRylDoBe9dvYyTQ+QC28GuvuKTJTA9JxyXUOg
   rg8Vyh68c7rKIjR/b1CPWSQB1z661ISruE2cNV9wwbn7YMh0TECxbRizo
   PnBcC0nT8XtQ3tg+xCsMoTPBHOyb813sjWrCA0cl/X9VuitmpmWYrarvv
   sT9d25/QssfP5gevUH7A8n7A9jH/y7tVLni3y4afP6tWUAr475XnDMdak
   w==;
X-CSE-ConnectionGUID: ffng+XtbRYqrcTarSV52fg==
X-CSE-MsgGUID: bqaNXSkFQBeYCqoEptRWww==
X-IronPort-AV: E=McAfee;i="6700,10204,11109"; a="15827673"
X-IronPort-AV: E=Sophos;i="6.08,254,1712646000"; 
   d="scan'208";a="15827673"
Received: from fmviesa001.fm.intel.com ([10.60.135.141])
  by orvoesa112.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 21 Jun 2024 03:54:51 -0700
X-CSE-ConnectionGUID: 4XhbnGm7TkGGP3HMXqq29g==
X-CSE-MsgGUID: /KaunSz8SGi68ZWeHlaYAQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.08,254,1712646000"; 
   d="scan'208";a="73770507"
Received: from fmsmsx602.amr.corp.intel.com ([10.18.126.82])
  by fmviesa001.fm.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 21 Jun 2024 03:54:51 -0700
Received: from fmsmsx610.amr.corp.intel.com (10.18.126.90) by
 fmsmsx602.amr.corp.intel.com (10.18.126.82) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39; Fri, 21 Jun 2024 03:54:45 -0700
Received: from fmsmsx612.amr.corp.intel.com (10.18.126.92) by
 fmsmsx610.amr.corp.intel.com (10.18.126.90) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39; Fri, 21 Jun 2024 03:54:44 -0700
Received: from fmsedg601.ED.cps.intel.com (10.1.192.135) by
 fmsmsx612.amr.corp.intel.com (10.18.126.92) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39 via Frontend Transport; Fri, 21 Jun 2024 03:54:44 -0700
Received: from NAM11-BN8-obe.outbound.protection.outlook.com (104.47.58.172)
 by edgegateway.intel.com (192.55.55.70) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.39; Fri, 21 Jun 2024 03:54:44 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=iwNrJadli0dJBSxeXTXUjLpOqHq53ydTyI5METYNzfmpBNotOcVAtlnkCgAlYN9z7Zn6vw6He4DRLZatOg+XAyaEsow1wVHwUb+tyHUjrpdSFlZPoLOq6D31/vmbkYNZKYPpjiDceuV0DXwH6tzDe28X9/t5e3J3dXxbCM6wOk0f1gerxCSYnq6uSrLZmzlc7u0Ix63liL97DIV8jgsDeG6nyKG3F1iguhGEzlLsUHCk1C3gRde1H/qCiwHvFdKGNGahk1uwLK13fGTdHDRuAR3z3lbrsK/Cb6mM2DBVx/jJQLxlE4Donilz0Mk/665rAp1/zV/RZWcn5GFPDrYDLQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=cnoqhN9yN650XPya0Rgg0eQjomNJINjcyJi+xZLRUso=;
 b=E2oomgnK3QzpRQU9ecxOdsELU+T29qGx4byp6a9RSpxzvSZ8v/9+OmCGUtseqSOFeGPI2HXnlDH8QfVBJy+ZwWeAoyYSYeGfSyhdJ0f7SFOBuzG8XNstkfbIa2dNCkbAu/m3EyoVEVSHgMjfZuyw6T5vRHMopt7VN+ysw/11IDcXMGqGPE8LrQ1sMUnzn2faqv2x21824vt8w+vwcxU9M4KoGI+VdhKQuTz4u1mOWgtnHsYSFr09HMw1c4yWxO7arx2R6Bc72unE2Af9nrOIrAXrfs2JUYa4z58OJHUchj1jmI+Yz5M1QaXV5F/qxjbN6QdtOULdonRk1nmr+s/MsQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from MW4PR11MB5776.namprd11.prod.outlook.com (2603:10b6:303:183::9)
 by SN7PR11MB8028.namprd11.prod.outlook.com (2603:10b6:806:2df::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7698.21; Fri, 21 Jun
 2024 10:54:42 +0000
Received: from MW4PR11MB5776.namprd11.prod.outlook.com
 ([fe80::4bea:b8f6:b86f:6942]) by MW4PR11MB5776.namprd11.prod.outlook.com
 ([fe80::4bea:b8f6:b86f:6942%5]) with mapi id 15.20.7677.030; Fri, 21 Jun 2024
 10:54:42 +0000
Message-ID: <b9481bf5-c36e-45da-a718-0c7a254ff3d9@intel.com>
Date: Fri, 21 Jun 2024 12:54:34 +0200
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net-next 3/3] net: dsa: qca8k: add support for bridge port
 isolation
To: Matthias Schiffer <mschiffer@universe-factory.net>, Andrew Lunn
	<andrew@lunn.ch>, Florian Fainelli <f.fainelli@gmail.com>, Vladimir Oltean
	<olteanv@gmail.com>
CC: "David S. Miller" <davem@davemloft.net>, Eric Dumazet
	<edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>, Paolo Abeni
	<pabeni@redhat.com>, Christian Marangi <ansuelsmth@gmail.com>,
	<netdev@vger.kernel.org>, <linux-kernel@vger.kernel.org>
References: <cover.1718899575.git.mschiffer@universe-factory.net>
 <78b4bbb3644e1fabae9cc53501d0842ccd1a1c5d.1718899575.git.mschiffer@universe-factory.net>
Content-Language: en-US
From: Wojciech Drewek <wojciech.drewek@intel.com>
In-Reply-To: <78b4bbb3644e1fabae9cc53501d0842ccd1a1c5d.1718899575.git.mschiffer@universe-factory.net>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: VI1PR04CA0113.eurprd04.prod.outlook.com
 (2603:10a6:803:64::48) To MW4PR11MB5776.namprd11.prod.outlook.com
 (2603:10b6:303:183::9)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MW4PR11MB5776:EE_|SN7PR11MB8028:EE_
X-MS-Office365-Filtering-Correlation-Id: 2606b90d-12ae-432a-15fa-08dc91e08e2b
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230037|1800799021|366013|7416011|376011;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?dDJHcmlQbVU4K1BnYTlHK0NPNXVqbE5KVUNpL2NoMG9tbU5XMnlMN0p6QXpk?=
 =?utf-8?B?QnlUaVNhcWE1WkZ3eVhkdVM0dU9PRGZxU1RBLzJwbmxWTndHU3FVa1FXUDFM?=
 =?utf-8?B?bnVQMUsvRjFXZW5aRTB1VDVKbnpqMXFHUDBUcUZtTTlyOGZmWmVGRjh5bURH?=
 =?utf-8?B?TDl4RmJ4NnJZeFRHVk53MGlGdjdoS0VrUkQyTCtRWjdpWFc2TE0xc1lzWHU0?=
 =?utf-8?B?OW0wYnMwNmVlUzVUemFpWklzVlhlMGdiR1JuZmVLd3FTTWhDa2krOG45ZFM3?=
 =?utf-8?B?czNsOVU4NzBPWWh6RklueWhDamErSkVqQjBGbWdFVFVuWmlGZXUwYlVYUVpp?=
 =?utf-8?B?WThXM25ZWlRDc2thby94ZFRmSGgzODY2Yjd6eHkvMmZ3WEpIUi84NjJhOXFV?=
 =?utf-8?B?NDhjL0Y5RG9BSGh1cWI2MUhsNnFPNmFxMmE2N1k1UVorbVNiTzdwZTJxbkVH?=
 =?utf-8?B?UjBBVWdGSElPV1NRU0wvbFJlUjdmWDFnMUprY3pESXJVclFRK0ZkMDBmZTY1?=
 =?utf-8?B?WFYyN3o0RlpsWGtXVUxkVEpENGZ1OWlCK3lKS3N2aFdkdXV4dDBJb3VPN1Q0?=
 =?utf-8?B?YzY3dE1zb09YR3JIMXRib0JtNFRrTjRYWnZMU0VCZHhmWnVuZTE1dThJQ2JP?=
 =?utf-8?B?Qk1BVGh3TDU4aE8vY1pYR2J6NDJUcFZ3dnk0MHRQTnltMURZUWo3cDRrVzRU?=
 =?utf-8?B?OXJVYWtkVVdpRmphcWoxNWwxbENqcmdQTG9JT0pXRk10TGlVd2NxeGJVOVFS?=
 =?utf-8?B?V3lBZFRPSnlVc0lueGtXaVV6L29XcHlCZ25nU2g3SXluRG1UY0s3Rmw1S1or?=
 =?utf-8?B?dnF5dzJLWlhXZW9kWlNNMUJsSW5sOEYzZlJtTUFBZW1HS013a2ROdG1xcHBH?=
 =?utf-8?B?YkVOaUMxdUVIRU5TeENwdkZlcDFJYkI4OElDR0NNWTBpZUc5SnFJSjVURFpN?=
 =?utf-8?B?VHFlcFN3S0I5S1d6MHRWS25mekZ6WTdDSG5adHQ2QWtnUlNVSXEzeDZQVGYw?=
 =?utf-8?B?NEpOZFFRdVpHdWNIdm5HWTNqU0VVb25vZzY3MU5PVHhUWWFqVnk2b3dWdWtV?=
 =?utf-8?B?cXBJQmFidGNxVVlldUt4cHFBRWxkaWVmUVFyWlJpUUVPT0lTNE9KQXIxc2Nx?=
 =?utf-8?B?Qy9qbnlUT2xuOEU5ZXVVNXVMSVhyWENHYVRFS0Q1dXdVTmQ0ZENIcGdsUjZq?=
 =?utf-8?B?dE5xTHJkSHBTUSt4V0lrQXlWSzR1b0hRQWFDMXg4RlFmdlo1dVNqY1UvcGlj?=
 =?utf-8?B?NCttQWR4NGs1cENycXJ4SFBoYVhkSUV4SVdJTDZNblBSME0xanZTZVhwQWNw?=
 =?utf-8?B?U0hGNE9vMXFMekVtM1MvR1dCM0M1VlJhTkFJNlpuRlVkKy84VjJSa3M0aGJ2?=
 =?utf-8?B?OGw5Z0JrZDlEU1dZRXo2ajhNR1d3Z3VOc0Ixak81Y0pWcGxXTnV6MGQ5eGtn?=
 =?utf-8?B?Zmd4ZkJGK2dTZzZBR2grL3pDeVB0ZmJBVUQvUk1CMkdPZ21aRVF1Mm5KSlRE?=
 =?utf-8?B?am8waHQ3Rk1yUWtYa0VpY1NIMllBemNEK1VSR0I5bkV4MzhDMWNDdy8rRXkw?=
 =?utf-8?B?c3BjNjFLS0tPWEYyU2c4ZXU4aVpUU2NydWVzTEs2bEJHVkN4cXJtU1FmWUFa?=
 =?utf-8?B?RWpPNnlESXNQNU93QkZRdVhXOUdnMDM1OTI2YzFCS3lQUEpwQnBocTMwb2pY?=
 =?utf-8?B?TnZGZTN5U2xBcnBnME0vZlA2NzYvSFgrRXUzbkdWR0xOY2pZL0lsWUMyWG1v?=
 =?utf-8?Q?KXnCcpGEc/kjg1jgQjgOdjg2lvWjNpCi6QwDZ1n?=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MW4PR11MB5776.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230037)(1800799021)(366013)(7416011)(376011);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?WDB4NlBDQ2VZdkRDbzdOTGRDczlVUExtM2UvVGxITTZoVkN0ZkVEOTZLTWVL?=
 =?utf-8?B?d3VlLzluRlh0Q2FmSTZxZUlxZ0FQeENvaXhKUUtCbVF0TEVOZUlVcDZ0MXdu?=
 =?utf-8?B?UE52Ym96T3BGNnJQWTJNVE9LY3cxTXNLM2V1NVMxd2FxdjhGUk90VzQ1VzdR?=
 =?utf-8?B?R2dlOVdzV3A1MW9WenZ3aEJUUEE3aEpQQkhzaWtWNWszNy95eGpKQkk2VUtw?=
 =?utf-8?B?cjZpMFVQL0RLdk10SmxpL0RSVy9VU201MU9paWY3amhIUVdRRCswNzQ2c1Az?=
 =?utf-8?B?RTZIMDkzUm84cHVnYjYwZWUxdXlZV3ZJRTlmOTZrTExvdFUwYzBCdHlNanZ4?=
 =?utf-8?B?b3ZGK05JU3BFTmN3SjExbjRqTWphS0huQ3gxMGMrZXE5UnVGRStRZUhvWDdv?=
 =?utf-8?B?a3d6YU9pNVdyVkhNU1hpSmVJZ1l4VnBnTWlaRTgzODJDTFRiV2RkYzVlVmhp?=
 =?utf-8?B?OVpkdGk4QXI0ZXkxcmlqU09DMVVjbTBQcnN5Mk9kTDZrdHVlbStIMnJHTllo?=
 =?utf-8?B?UGxiNUlnWjhEUzJsV3JESjY0NW1iQmxaQTA4ZXpMVXZXbmZuVkdOWk9RU0JB?=
 =?utf-8?B?SzQrZWJGd1VqVHhsblpFOGVyczBQc2tRWFpMd2JmMXlKOVdaeitOYTJGcGVH?=
 =?utf-8?B?ck5jVUtyWEVSazhIazhRbXp6SjM3UENWZkMwUHhkTmg2Y1djM0t4a1hxMm5D?=
 =?utf-8?B?UEdkUjBmNHNrTTN4K3hhS0YxSFE3bFJJc1lLMFR4YnVjTDdqNnJXb3dBT2ps?=
 =?utf-8?B?aEcyM2doZUlZeGNvM0Z5MlhwMytvSTBHUFZsR3YrS21SREdXeGppQ3YvbFV6?=
 =?utf-8?B?dTlsUWxFdzVKUjBQTnZLNkVkcnhVei9LZjdUMTNuQXQ3dkI4cm5PUTh2UzNV?=
 =?utf-8?B?TE5aWFdwTUJiODFtM0hSNUZ6OVJtbkk5VGFRMmZxdy9tQXVCcEl6Qk9ITmxI?=
 =?utf-8?B?RDRhSUIwYUhtaE81YkliaTdiSDZnazNlTU1WaWo0SDlXWWxNZWROOHA0SWE4?=
 =?utf-8?B?eGtLSGlsUHFmaTYraUplT0xYbmdwYXZ4OEhXYUJlVkFrOEFPT3NHS01TZktp?=
 =?utf-8?B?bi80anpneHFaNi95WUZjWXdXMjVablljREhZbkVVMTJKbVMwR1dNb3ZrWHlP?=
 =?utf-8?B?WmJOK3p2c0JEZEc4NmNIcEJXV0JqRUFuQnZaK0ZVWHBDbWQ5eW95emdNdzJj?=
 =?utf-8?B?dmxBeG1jSk5WVU9VTHpXdC9jaXc2RjcxRGpDdnJ4MXVYV044N3pjQmhBMnRN?=
 =?utf-8?B?N1QvRTJER2tBRlRWYlVwcWlUOXBwQ1RQVDBHQmNFMjlFYWpYeFBBTllSUyt1?=
 =?utf-8?B?c0dzaWN2bXplWnB0ODZMVVh4aStac0tEakJxeCtHRFFPbDlpc1pDOVYxU0ds?=
 =?utf-8?B?cWpQWGhEc0lVcmMwOGsvVjFZa3B0QWo3bWNzb2Y2c1RaOWU0S3hISEVpcmlV?=
 =?utf-8?B?SlNHZW9PTDU4K2ptUHNIaG9YMUM4K1gvTXc2cjlhcUh5U2o5YXA3VWpZL3A0?=
 =?utf-8?B?cFQrTjU2M1NaeUlhTHdiWTQrcDR0eVFaSE5pelFaaHpOWGs0QXU0NDdTSWc0?=
 =?utf-8?B?M0hMTE5uZmdrUnZKenhRcnFWbFNoTVEwT3NYNWRaUGJzOGl5bXlLa3FBQjBl?=
 =?utf-8?B?MzJxT1V2QTVWTldvM0VjZmdtYUs0OFBzUmRXa1Z1Sk1OSGZtMDRUTVJIOHFO?=
 =?utf-8?B?K0ttRGN1MDRUUXdZQTVUSU1jSlFKNFVDRVJhV1lodWlZRGN0VUJJeHNwOVZX?=
 =?utf-8?B?d2I5cEIydzVHenZXbHNyYVhvYW5SdTBOSElUL2lLeUs1VnNFSzBhdVBuRU1R?=
 =?utf-8?B?UWY3UTFsM210UHhCeHZoYWJPUUJwaVNlallFb25zNUxkSk9XL3ZwVjBKckhF?=
 =?utf-8?B?K1lKd1NkZVRJYWZWdXVXNjBLQ2RldUN2UWd5VmdUYlRZNE9iYTNjZTZLdE5R?=
 =?utf-8?B?YlRkaktQNFROWkdKZElmZTJvWkRkZ0NEL1FIL1NRMmY4SWZkd1VhQ3AzVzRl?=
 =?utf-8?B?RlR6MHF6MlB3enFrUW02SFVYbUxITnEyb2NBOGxxTzhUdlB3bFZhaTRpQjhk?=
 =?utf-8?B?TCtTZzBBaUU3eWs5VWVkUDJRZGp0UEJiSCtGYnlKZGNUakVoY0lSNnNhdkdp?=
 =?utf-8?B?aTJMVWVUQklORDJFejczZmk4dGpXdDBTUTZWZmQxWk5YOUVld2FJdUJCV3lK?=
 =?utf-8?B?S2c9PQ==?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 2606b90d-12ae-432a-15fa-08dc91e08e2b
X-MS-Exchange-CrossTenant-AuthSource: MW4PR11MB5776.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 21 Jun 2024 10:54:42.5976
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: PHbKJyAe4qO5lJTQyA53XPAnbXieafx812CHuYqDqdH777RdCV/dGF7m5C8vL97y7tAcJNOSnrNSdOm3XQC3ed8TQkwh+VyJkzl99NXJxG0=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN7PR11MB8028
X-OriginatorOrg: intel.com



On 20.06.2024 19:25, Matthias Schiffer wrote:
> Remove a pair of ports from the port matrix when both ports have the
> isolated flag set.
> 
> Signed-off-by: Matthias Schiffer <mschiffer@universe-factory.net>
> ---

Reviewed-by: Wojciech Drewek <wojciech.drewek@intel.com>

>  drivers/net/dsa/qca/qca8k-common.c | 22 ++++++++++++++++++++--
>  drivers/net/dsa/qca/qca8k.h        |  1 +
>  2 files changed, 21 insertions(+), 2 deletions(-)
> 
> diff --git a/drivers/net/dsa/qca/qca8k-common.c b/drivers/net/dsa/qca/qca8k-common.c
> index 09108fa99dbe..560c74c4ac3d 100644
> --- a/drivers/net/dsa/qca/qca8k-common.c
> +++ b/drivers/net/dsa/qca/qca8k-common.c
> @@ -618,6 +618,7 @@ static int qca8k_update_port_member(struct qca8k_priv *priv, int port,
>  				    const struct net_device *bridge_dev,
>  				    bool join)
>  {
> +	bool isolated = !!(priv->port_isolated_map & BIT(port)), other_isolated;
>  	struct dsa_port *dp = dsa_to_port(priv->ds, port), *other_dp;
>  	u32 port_mask = BIT(dp->cpu_dp->index);
>  	int i, ret;
> @@ -632,10 +633,12 @@ static int qca8k_update_port_member(struct qca8k_priv *priv, int port,
>  		if (!dsa_port_offloads_bridge_dev(other_dp, bridge_dev))
>  			continue;
>  
> +		other_isolated = !!(priv->port_isolated_map & BIT(i));
> +
>  		/* Add/remove this port to/from the portvlan mask of the other
>  		 * ports in the bridge
>  		 */
> -		if (join) {
> +		if (join && !(isolated && other_isolated)) {
>  			port_mask |= BIT(i);
>  			ret = regmap_set_bits(priv->regmap,
>  					      QCA8K_PORT_LOOKUP_CTRL(i),
> @@ -661,7 +664,7 @@ int qca8k_port_pre_bridge_flags(struct dsa_switch *ds, int port,
>  				struct switchdev_brport_flags flags,
>  				struct netlink_ext_ack *extack)
>  {
> -	if (flags.mask & ~BR_LEARNING)
> +	if (flags.mask & ~(BR_LEARNING | BR_ISOLATED))
>  		return -EINVAL;
>  
>  	return 0;
> @@ -671,6 +674,7 @@ int qca8k_port_bridge_flags(struct dsa_switch *ds, int port,
>  			    struct switchdev_brport_flags flags,
>  			    struct netlink_ext_ack *extack)
>  {
> +	struct qca8k_priv *priv = ds->priv;
>  	int ret;
>  
>  	if (flags.mask & BR_LEARNING) {
> @@ -680,6 +684,20 @@ int qca8k_port_bridge_flags(struct dsa_switch *ds, int port,
>  			return ret;
>  	}
>  
> +	if (flags.mask & BR_ISOLATED) {
> +		struct dsa_port *dp = dsa_to_port(ds, port);
> +		struct net_device *bridge_dev = dsa_port_bridge_dev_get(dp);
> +
> +		if (flags.val & BR_ISOLATED)
> +			priv->port_isolated_map |= BIT(port);
> +		else
> +			priv->port_isolated_map &= ~BIT(port);
> +
> +		ret = qca8k_update_port_member(priv, port, bridge_dev, true);
> +		if (ret)
> +			return ret;
> +	}
> +
>  	return 0;
>  }
>  
> diff --git a/drivers/net/dsa/qca/qca8k.h b/drivers/net/dsa/qca/qca8k.h
> index 2184d8d2d5a9..3664a2e2f1f6 100644
> --- a/drivers/net/dsa/qca/qca8k.h
> +++ b/drivers/net/dsa/qca/qca8k.h
> @@ -451,6 +451,7 @@ struct qca8k_priv {
>  	 * Bit 1: port enabled. Bit 0: port disabled.
>  	 */
>  	u8 port_enabled_map;
> +	u8 port_isolated_map;
>  	struct qca8k_ports_config ports_config;
>  	struct regmap *regmap;
>  	struct mii_bus *bus;

