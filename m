Return-Path: <netdev+bounces-307631-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id QKMCNb7YVmqdBwEAu9opvQ
	(envelope-from <netdev+bounces-307631-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Wed, 15 Jul 2026 02:47:58 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 3229D759C0F
	for <lists+netdev@lfdr.de>; Wed, 15 Jul 2026 02:47:58 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=intel.com header.s=Intel header.b=SwWysUnl;
	spf=pass (mail.lfdr.de: domain of "netdev+bounces-307631-lists+netdev=lfdr.de@vger.kernel.org" designates 2600:3c0a:e001:db::12fc:5321 as permitted sender) smtp.mailfrom="netdev+bounces-307631-lists+netdev=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=none) header.from=intel.com;
	arc=reject ("cv is fail on i=2")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id DC20530A29B7
	for <lists+netdev@lfdr.de>; Wed, 15 Jul 2026 00:47:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4917D258EE9;
	Wed, 15 Jul 2026 00:47:56 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D7F2778F2B;
	Wed, 15 Jul 2026 00:47:50 +0000 (UTC)
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784076476; cv=fail; b=SWKk/GwXbw1QyU0gciPHTl6l/2fSSe6e0K4Z7vpNb219hcoPcuKeR9tCjtIGbelWFYqsB/hwpz6cuyFBUirwxGz7Nl2d1nJNrXrMWoxz75yHRqys3s+IBDoGFLifvyN0hSRIVmatxwy24wmWyPHotdx1QToQLYy6zVcgCpTdQWY=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784076476; c=relaxed/simple;
	bh=WP6ZFRb0R2eCrR1SPuxn7/zeIymdQQs3/0GZn/6MsNs=;
	h=Message-ID:Date:Subject:To:CC:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=qG9xw9VUu0UDRjKdkun8oPSvEOxeQCji9B5BU95N3ws1D+W24ZXBnqLylWG9yjYTqzoBahwAN+PJNVMc90sU5CnMY/6Gm3q5opSTuulL5htljBAv1uCovxM5fku0vnQqSMjQkxLiUG1ZJVDmG9/oWWb+ewspI0u9AxDvizp4btM=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=SwWysUnl; arc=fail smtp.client-ip=192.198.163.7
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1784076471; x=1815612471;
  h=message-id:date:subject:to:cc:references:from:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=WP6ZFRb0R2eCrR1SPuxn7/zeIymdQQs3/0GZn/6MsNs=;
  b=SwWysUnlhdW6EmeDRCr4UBDB4t0f501JW4qQSVJlgBUm3LL+9qYGHp3u
   BllkUXwvhGkDUBUVOiOl+0vt5HX47hwcezt/uypMh1754LZFU9YkHRXne
   SCC2/NK2dfLVG2jHPz89RPe+c2KsjqvsdeRQJG/MJS8jtei8bSBHuM/TB
   tW2/o5bF1J2rS308ZMnyaMJRR10OSvfZw0VNUIgVi/6oj5ICIleokJse2
   P77Zx3cmz86ebirDdifPqSrRxRzyGSDrlYXOj/yqCJsWtGJtwNw2ozzaa
   hL10BaE72LPf3a6zS+aPycX4i/sYqMMSWrPsRwp6xFitZ8tw5cplSa6UQ
   Q==;
X-CSE-ConnectionGUID: NvqQSFiTReeVzugJv3+01g==
X-CSE-MsgGUID: 0QkDpFAwTeqE3mxFt0B0iQ==
X-IronPort-AV: E=McAfee;i="6800,10657,11847"; a="110253984"
X-IronPort-AV: E=Sophos;i="6.25,164,1779174000"; 
   d="scan'208";a="110253984"
Received: from fmviesa001.fm.intel.com ([10.60.135.141])
  by fmvoesa101.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 14 Jul 2026 17:47:50 -0700
X-CSE-ConnectionGUID: butiFfGhSxaWxvg3WfRIOw==
X-CSE-MsgGUID: aG20E+blQgez9lF6KLAvjg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.25,164,1779174000"; 
   d="scan'208";a="280436232"
Received: from fmsmsx901.amr.corp.intel.com ([10.18.126.90])
  by fmviesa001.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 14 Jul 2026 17:47:50 -0700
Received: from FMSMSX903.amr.corp.intel.com (10.18.126.92) by
 fmsmsx901.amr.corp.intel.com (10.18.126.90) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.43; Tue, 14 Jul 2026 17:47:49 -0700
Received: from fmsedg903.ED.cps.intel.com (10.1.192.145) by
 FMSMSX903.amr.corp.intel.com (10.18.126.92) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.43 via Frontend Transport; Tue, 14 Jul 2026 17:47:49 -0700
Received: from CO1PR03CU002.outbound.protection.outlook.com (52.101.46.51) by
 edgegateway.intel.com (192.55.55.83) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.43; Tue, 14 Jul 2026 17:47:49 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=yi287h79Si1WR4yRh35eJAIwznw0f8HZN79VwKSAUS89eeAFw17+4L+n4A/RqFqInUcbpvSwskuWXD/zFVWFD+bdfa6z9ax7NuTWgJv7q6uQ58g+trNIJTSyfgWAJx9G/BXnssxiooBp1Rh1P4ru270dhn3AiFfAKALPzy2Qx1WrqR9vDCxy0lTHa5EZ9vpN8tFzAL6EnonQ9qGXHV+nFDv6oecuSTVNEf2gUKzWY2TmErk3/cp3k5iS7/Ns2BRLuBFldJb3WyzZ+poRz1/bsnzm+G+etI52vdEy2U9cxm92AnPOrBcXbK7tYwpZByhaHH712LDWZUT3AQr7kP7VCQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=mwdDyOZpOBmPnpm25loBCMaX6nASRbLo32cIb59ze+8=;
 b=k2erEXgm5rxOPJOXHkVjLi73J5nz6Zcfx00tvW1cRzTbni/SgPG8OP/KyvT0q1zrG9ra2tl3dAw1dRJGUugZd/Y2fWnkfOMynjZKmwHwzXPBPq3Eot7C/Gd6VsH5WsYmMOYCIZiI/QIfmUaICI9C1SsnIusXIfge3qh5MENxU8CpCfH4EjUn8Dbp+Nm+CJP665QnRA8v53YATYA1yfNrIvnMF5KTY7aNYIi1k+eUYmYBdAybvKMO4WxRaW3O/Vesuk4UnIiLCeEUUdxGyRHItWUH9Y9YOP775FMsiTyELi6GVLqpwxA9s+J3MXD6+8a5L+kQgj+SMA4JvqJk+SZv4Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from DS0PR11MB7381.namprd11.prod.outlook.com (2603:10b6:8:134::14)
 by DM4PR11MB6504.namprd11.prod.outlook.com (2603:10b6:8:8d::5) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.202.19; Wed, 15 Jul 2026 00:47:39 +0000
Received: from DS0PR11MB7381.namprd11.prod.outlook.com
 ([fe80::4c39:dfe6:d6dc:6f58]) by DS0PR11MB7381.namprd11.prod.outlook.com
 ([fe80::4c39:dfe6:d6dc:6f58%6]) with mapi id 15.21.0223.008; Wed, 15 Jul 2026
 00:47:39 +0000
Message-ID: <f8974bb1-e27d-480c-8f88-6aea3ef41ad8@intel.com>
Date: Tue, 14 Jul 2026 17:47:35 -0700
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v4 net-next 7/7] net: ena: Implement gettimexattrs64
 callback for PTP attributes
To: Arthur Kiyanovski <akiyano@amazon.com>, David Miller
	<davem@davemloft.net>, Jakub Kicinski <kuba@kernel.org>,
	<netdev@vger.kernel.org>
CC: Richard Cochran <richardcochran@gmail.com>, Eric Dumazet
	<edumazet@google.com>, Paolo Abeni <pabeni@redhat.com>, David Woodhouse
	<dwmw2@infradead.org>, Thomas Gleixner <tglx@linutronix.de>, Miroslav Lichvar
	<mlichvar@redhat.com>, Andrew Lunn <andrew+netdev@lunn.ch>, Wen Gu
	<guwen@linux.alibaba.com>, Xuan Zhuo <xuanzhuo@linux.alibaba.com>, "David
 Woodhouse" <dwmw@amazon.com>, Yonatan Sarna <ysarna@amazon.com>, "Zorik
 Machulsky" <zorik@amazon.com>, Alexander Matushevsky <matua@amazon.com>,
	"Saeed Bshara" <saeedb@amazon.com>, Matt Wilson <msw@amazon.com>, Anthony
 Liguori <aliguori@amazon.com>, Nafea Bshara <nafea@amazon.com>, Evgeny
 Schmeilin <evgenys@amazon.com>, Netanel Belgazal <netanel@amazon.com>, Ali
 Saidi <alisaidi@amazon.com>, Benjamin Herrenschmidt <benh@amazon.com>, Noam
 Dagan <ndagan@amazon.com>, David Arinzon <darinzon@amazon.com>, Evgeny
 Ostrovsky <evostrov@amazon.com>, Ofir Tabachnik <ofirt@amazon.com>, Amit
 Bernstein <amitbern@amazon.com>, <linux-kselftest@vger.kernel.org>,
	<linux-doc@vger.kernel.org>, <shuah@kernel.org>, Jonathan Corbet
	<corbet@lwn.net>, Shuah Khan <skhan@linuxfoundation.org>, Simon Horman
	<horms@kernel.org>, <vadim.fedorenko@linux.dev>
References: <20260714020340.25014-1-akiyano@amazon.com>
 <20260714020340.25014-8-akiyano@amazon.com>
From: Jacob Keller <jacob.e.keller@intel.com>
Content-Language: en-US
In-Reply-To: <20260714020340.25014-8-akiyano@amazon.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: MW4PR04CA0193.namprd04.prod.outlook.com
 (2603:10b6:303:86::18) To DS0PR11MB7381.namprd11.prod.outlook.com
 (2603:10b6:8:134::14)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS0PR11MB7381:EE_|DM4PR11MB6504:EE_
X-MS-Office365-Filtering-Correlation-Id: 2e9bd03e-caf6-4137-9a8a-08dee20aabc1
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|23010399003|366016|1800799024|376014|7416014|56012099006|11063799006|4143699003|18002099003|22082099003;
X-Microsoft-Antispam-Message-Info: B9ThCVO0GN3Al3XOpcLVjyHJPdo1Owo3Fuo6h3s9VjjPxOfUVhzwSb59D5vVFFIE0n3djDPyVrdf27606U6d74DtPNxCdz34eRAg/j9GGh10Lom1fOGoMS+ywDD2Mm6bmmZtnGszKFLwCPDr9AuTG/+a0vEhRHnAA4XiFYG5hLjnndicFT5wwO+VSyxDYhS4qlsmQG2z22VCkIbIZ/CBHrJzpPxqQifwIVIQp8GMDF/X3CFq0Txj+0jfikqHUibOHngBxbROTkCFRr9tF0Zi/lerRlPasQ09oPC7NDrIZRmULwLWxamYb7fsXwLzNXGAHs5w2a+bJU0aSY6J3lxybFGRxPgwXbrfKEiq22TBYYF7rWQMnQ6Lh0wLOnsv+pagQQ0dhEaHNxL+GjBVKkp9eabux3DXY2LgA0pQCxydwIz1C4UPsb2aSoWrxpN7JONxzfzSCQhu4G6rAsVv20QhZquOaqi4qP/r80DgI+zkrBHLYx+7ybvlvpy42byuA7a2uf6VgbzbRp+AuPYX3+4wrhTWpXXvgcPz3i6DkM3xMPHzK6qn9MKYcbps/SPCACdfUKREhH1pINMtJaoTe+LY7IPPUJHunWzQNBAQTklMQvMBHTnKSw3NVuk11dljLqrC6Yqvx+P5D5j1cHbWg6Sls0aYxPBbIT34lF+Ce09Ah44=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DS0PR11MB7381.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(23010399003)(366016)(1800799024)(376014)(7416014)(56012099006)(11063799006)(4143699003)(18002099003)(22082099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?aFNyTXROYkFqeUJ1aTZhbXh1N0xvZktQelZnNCtHdll3eEp3WEVFV25GZ3dN?=
 =?utf-8?B?cmlYSlhwdUFHRlBXOXVYaitDQWpKZ2FQOU5kdStreTJQUzdMbWg1Sk1rc3M0?=
 =?utf-8?B?Z3VxdWJrdG15amtzbGJHa1cyam1mTEdwS0JTak8xUXRReVBNNlVXRjhJMjAv?=
 =?utf-8?B?YTN0bFZpTUZGckZXeFdPMFl5Vjhha2V0V3E3b1UrN1pvNWJNek4vNjRHVDl6?=
 =?utf-8?B?OE5tb0RPU0NzeDQxK085NUVxdExRd3RiWmVidGdEZlVvbXpHVVVPTUQ0UFV6?=
 =?utf-8?B?RVFvREJlbis5ZVAyWkNkQ2tGNXNGbk04clhOTm1lWWxWM284TEcvWjJpem4r?=
 =?utf-8?B?a0poeWZ5V3hwZmtSVk9QRnVkWTJMbHdZamJuUjVwUllFWExWSnlLMkJaMm1k?=
 =?utf-8?B?NTZDL1RDS0lobmlaR1FUenN0bVVKRFJYUmoxTXFUcjZQSHhlaUNhTU12WWk3?=
 =?utf-8?B?N1lNQ1lWQjUrM0h3NDUwRXJVbTVTVkhPYkxHUEhCNmxXeTBwNWEwUVRGZzVQ?=
 =?utf-8?B?b0FIWk5oVHJlU0l3SlNYRk51dXhlQ3pQb05YMEpoZndUUEFXQlBTL3lWcVVJ?=
 =?utf-8?B?a2p1QkRlYXRRMFYzQ2E2OUdGS3hodGdIMnk3aGpWY0FSV1lIVTZmOW9ZNGFK?=
 =?utf-8?B?dnN3NE02WTNqYUJMaElhelhjL1hGc0l5RmMwSDdmcFlvRk5yUXlzU0phSGpx?=
 =?utf-8?B?empRdzBWeGFpOHdMYTQvWTc5Nm5DRjZYcGJwT2hELzVOeW52aWJpUS95eUlk?=
 =?utf-8?B?elFKYUxtN3o5OWVjQ3dSQWJuWlBoZ1VGcU5tWUU5TkhrL1NTZjVmNVFVbDBZ?=
 =?utf-8?B?VHE2bmpqOWdUeUtVSVNLL2g1WmIzOFVLWk1yVGY4RldsVmtWNlF2dUZCL1oy?=
 =?utf-8?B?a3lVc056TjBxSUQ4SGorckV6ZllOR2NUeDRLTWJERmFISFlPMnNwZ1BpbDRz?=
 =?utf-8?B?MWQ5Rkc0NEFyTFozclVndVJtUlBldmJlN3RWTktmRExVSXlEczg1bzlTYTAy?=
 =?utf-8?B?VUxta2YvQkh2M3V6Nkh6b25sZU16N3hpZi9LUTZCdjBkWFhNdUdZc1RSUDhu?=
 =?utf-8?B?N3hTNWhDaTNrKzlJd3V4WlpwMDJLMmNZb3ZhWW81cStybWR2NGFYV2ZINzV3?=
 =?utf-8?B?eDBlTU0ydlZ2QUJaOVpaSEJzWTk1OCtEQVVmd0FzVkFWVEFZYWUxT3ZhL2R2?=
 =?utf-8?B?RGNEWmg1WFA1dDV2R0NJR2ZJcGVjbGFZcU02bUlOaUEvZHFuSnBGRWppR21m?=
 =?utf-8?B?Znd1Tkk3RHBHMktYY2VYU05UU0VvbHgzNzRPY0tTelM0d2JHSmNPWUxyTDAv?=
 =?utf-8?B?Zzl0Tk8veDUwalcySHAzTnJZazM3aFhJdlp2bDRwaDc3USs1Qmg4YmU2V094?=
 =?utf-8?B?YXpLR0FEUmFON0VHZE53UDlicXR1L1NIZzZ3K2xESmdPbVhML3pxMUh6d2x5?=
 =?utf-8?B?dzZaWmdLbHBFRTBGV2ZUb0l5a1FaVEszZ2VkV2I4WXBwZ1dqTS9rOWkvZ0kr?=
 =?utf-8?B?ZEhaYmZRcUpTOTRKMmFiVzkrZmJHZ0JIMTkzbmRCWXpWTy83RExadmlnNzF4?=
 =?utf-8?B?M2RXNndRZlhKaVFKa1NWcEtmcVpLYUtBSzZ1OHMveVJzVEIvdVVJQVBqUmZa?=
 =?utf-8?B?QjRTRUhUdEV3cUlzcVNWMVNQWERNcTdsbThURTRmZjZobyt4OFBxR0ZGb2hz?=
 =?utf-8?B?MVc2ODN5cHRjd2lML3NRUnhCQWczaTJMVGNSNjR2VnZsaXVvWFpkMDVkeG0z?=
 =?utf-8?B?eFlCNGdhSDFHTHV1cUhXdEQ4YU9HUGs2d3lWYVEraTJueWxSbHZhZkM0aEZU?=
 =?utf-8?B?OG5XOEV3R0I1Y1I0enFPbm16N1hpdEJ2TWRobnNCeUo4T1lMTU43T2FLek9v?=
 =?utf-8?B?VmMwZEMwZmtjZTZPL1FZYk9FaTltL092MnkxYmcxUDloVHJvd2I4OVdDL2JR?=
 =?utf-8?B?ZHJUL2xvaUtSWGJUaERLRGNuQW11M2dBUm1uMmFEd2VoeVJTN21FeXYwSFoz?=
 =?utf-8?B?RUR4WTI1WXhyVnRNWjZKZmNqUG1SL2NTcVVBYlNMaG84aVJwWU01OHg3bUlU?=
 =?utf-8?B?TlVYN29mOVNKYzFjS2hLRkh2YzV3bnRIbEZPVGJXV1NXMGsrYVFubms2Y1Rq?=
 =?utf-8?B?MnJtc2FSMmFIS1JnTUovanZXb2RjdkY3N1hscGhDRW0rSUxGWVhSWkhOZHg5?=
 =?utf-8?B?MzhzV3JVa294MGFCMEVja1V2OElCU3lNM1ZFZFZxNVExNTdkODlhZ0ZxRVht?=
 =?utf-8?B?RG1tWUZBZjJtekREdGhuUnQ2ZkM2bGV0by9xRGdsSXBKMDJ4VldBamltNnI4?=
 =?utf-8?B?ajk5UG4wcTZLOGdBK3dveDJtN0VBVXd0MGs0U1NteWR6QW5NUFc5QT09?=
X-Exchange-RoutingPolicyChecked: gjQoZryY1HXIDJWrp6n2QwgI4Hl7JRb9sOzpA2EbHcw0lk+12+B6AKPi/6TgLr8+/FM7uDHLTSKwAc3msNL8Yt7P6nG1E2Ns6v9w7DO+rDoZNaY1iDur7xYdr/SOWiYpgE2KwTcK9G7coFjC7NMQvm+Hkp/EiwTz64r/wmQdHpipvpm2PJgHl0QuJCwO+W0IcCg3c+35GcwhZIj0akc40dw8S41tkD91V7052bgcFzHk0CIq/eiJA6xm+hpa9UhLifjF4xwqZ+KwHCDFTTHDrFgGMQNfM2eiCEN9O3QXPXvAj15HanMC8VBZGQC9mR+l/UddigdX8Yo/ziY048656g==
X-MS-Exchange-CrossTenant-Network-Message-Id: 2e9bd03e-caf6-4137-9a8a-08dee20aabc1
X-MS-Exchange-CrossTenant-AuthSource: DS0PR11MB7381.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 15 Jul 2026 00:47:39.4006
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: Yk2/IP1mHqEkwQTNMLjE6VjgWRc2ih0elSJe2P61Z9e694SFmdy/tRMTqDg0X8c6Grf1sospv/lhpOIbBoUP6gbUlAy8KwitNQ5HuTvfzOo=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM4PR11MB6504
X-OriginatorOrg: intel.com
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-1.66 / 15.00];
	WHITELIST_SPF_DKIM(-3.00)[intel.com:d:+,kernel.org:s:+];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_REJECT(1.00)[cv is fail on i=2];
	DMARC_POLICY_ALLOW(-0.50)[intel.com,none];
	R_DKIM_ALLOW(-0.20)[intel.com:s=Intel];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-307631-lists,netdev=lfdr.de];
	RCPT_COUNT_TWELVE(0.00)[37];
	RCVD_TLS_LAST(0.00)[];
	FORGED_SENDER(0.00)[jacob.e.keller@intel.com,netdev@vger.kernel.org];
	MIME_TRACE(0.00)[0:+];
	FORGED_RECIPIENTS(0.00)[m:akiyano@amazon.com,m:davem@davemloft.net,m:kuba@kernel.org,m:netdev@vger.kernel.org,m:richardcochran@gmail.com,m:edumazet@google.com,m:pabeni@redhat.com,m:dwmw2@infradead.org,m:tglx@linutronix.de,m:mlichvar@redhat.com,m:andrew+netdev@lunn.ch,m:guwen@linux.alibaba.com,m:xuanzhuo@linux.alibaba.com,m:dwmw@amazon.com,m:ysarna@amazon.com,m:zorik@amazon.com,m:matua@amazon.com,m:saeedb@amazon.com,m:msw@amazon.com,m:aliguori@amazon.com,m:nafea@amazon.com,m:evgenys@amazon.com,m:netanel@amazon.com,m:alisaidi@amazon.com,m:benh@amazon.com,m:ndagan@amazon.com,m:darinzon@amazon.com,m:evostrov@amazon.com,m:ofirt@amazon.com,m:amitbern@amazon.com,m:linux-kselftest@vger.kernel.org,m:linux-doc@vger.kernel.org,m:shuah@kernel.org,m:corbet@lwn.net,m:skhan@linuxfoundation.org,m:horms@kernel.org,m:vadim.fedorenko@linux.dev,m:andrew@lunn.ch,s:lists@lfdr.de];
	FORWARDED(0.00)[lists@lfdr.de];
	FORGED_SENDER_MAILLIST(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,vger.kernel.org:from_smtp,intel.com:from_mime,intel.com:dkim,intel.com:mid];
	DKIM_TRACE(0.00)[intel.com:+];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[jacob.e.keller@intel.com,netdev@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	FREEMAIL_CC(0.00)[gmail.com,google.com,redhat.com,infradead.org,linutronix.de,lunn.ch,linux.alibaba.com,amazon.com,vger.kernel.org,kernel.org,lwn.net,linuxfoundation.org,linux.dev];
	ALIAS_RESOLVED(0.00)[];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	MID_RHS_MATCH_FROM(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	TAGGED_RCPT(0.00)[netdev];
	RCVD_COUNT_SEVEN(0.00)[10]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 3229D759C0F

On 7/13/2026 7:03 PM, Arthur Kiyanovski wrote:
> Implement the gettimexattrs64 callback in the ENA driver to support
> the PTP_SYS_OFFSET_EXTENDED_ATTRS ioctl.
> 
> This enables applications to retrieve PHC timestamps with quality
> attributes through the standard PTP ioctl interface.
> 
> The ENA device currently reports only error_bound (valid bit set).
> Other attributes are not reported (valid bits unset).

Typically it would be a policy not to introduce new attributes which are
not yet used, and add the other attributes once a user appears. However,
I think it makes sense to have the full set of desired attributes
especially given the ioctl interface limitations which would otherwise
require a lot of reserved space or new ioctl numbers. Especially given
the uAPI here has been discussed and changed heavily from previous patch
iterations.

