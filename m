Return-Path: <netdev+bounces-157731-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 6F1DFA0B66E
	for <lists+netdev@lfdr.de>; Mon, 13 Jan 2025 13:11:06 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 7991E16120A
	for <lists+netdev@lfdr.de>; Mon, 13 Jan 2025 12:11:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 182D01CAA96;
	Mon, 13 Jan 2025 12:11:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="GRUom9El"
X-Original-To: netdev@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 071F01E885;
	Mon, 13 Jan 2025 12:11:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=198.175.65.17
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736770263; cv=fail; b=RZ4dOa0zo42EgaQT74YDZT38qeWDWwVE6zX648UJunsbIZFfKZYeDgXWEyJGWv8hUfB0A0GN2ZkavVcv6+DBC9UD6rl10e10fBCllSGBryC0KpsoFVzC4/STSOmL6e6pAA1HcnLOEzs2TLFstFZM/BxCePUwXzCprnJCpUNC7bI=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736770263; c=relaxed/simple;
	bh=uRHOQMnkffECpHBurBjq9TQr4U8jqN9ubI6kXspJtow=;
	h=Message-ID:Date:Subject:To:CC:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=PcLOdlSwNmDTJ4LXzezpKG+j8pMJ7wiwN0m9fGWNvgu0IXUIdjEGZycFlDk+/fw/yHXUmGFngXkLAI+u7Q3Cw/SsZkHAF3EX50viKlylzx5cJbYvt9VX1CiPdauUr0DD/hjstzM5xVajR7ozJVU6ASOAmY4EQ8+D5KxyxnL5FdI=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=GRUom9El; arc=fail smtp.client-ip=198.175.65.17
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1736770262; x=1768306262;
  h=message-id:date:subject:to:cc:references:from:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=uRHOQMnkffECpHBurBjq9TQr4U8jqN9ubI6kXspJtow=;
  b=GRUom9ElnD+Jk7eBvJELyBL9gimZl0hKTPWQcKuQv+0qFHATYJCUGCIM
   nPe7quXyFYDJx5cNBBhHJ9iZy1eem1C5LL8kc8GwP3nDIw14i/G7SiELX
   wiGv2qHOhdjxKBq1zb21a/vBGhKWdWG99vqFY7hhB85RvWVRophB+ybfP
   TRzhPH3dLt/KqTu3etuULquxIBM9k0/+ZDKiKMAd9NwpZtwtUjPqDz/IG
   fZi7w98cdRTP51i8SxNPP4MZ8w/ePwpyY7mwcjtMhQXhf4UHMm7l5nAwa
   vP+fJ+lh0LFKTqE6gn3IsSiCVQClctSvvALGS9EqhkX3BArXdFnlWWavU
   Q==;
X-CSE-ConnectionGUID: wPwytKueSZqd7xClO616CQ==
X-CSE-MsgGUID: 3YyU2V5gToCHCAuqsNpfcA==
X-IronPort-AV: E=McAfee;i="6700,10204,11314"; a="37053509"
X-IronPort-AV: E=Sophos;i="6.12,310,1728975600"; 
   d="scan'208";a="37053509"
Received: from orviesa001.jf.intel.com ([10.64.159.141])
  by orvoesa109.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 13 Jan 2025 04:11:00 -0800
X-CSE-ConnectionGUID: 1d/1Ti0pSK+e33og0i0yTQ==
X-CSE-MsgGUID: j70hWmNGRiiS06/GZzRpow==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.12,224,1728975600"; 
   d="scan'208";a="141746495"
Received: from orsmsx601.amr.corp.intel.com ([10.22.229.14])
  by orviesa001.jf.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 13 Jan 2025 04:10:59 -0800
Received: from orsmsx601.amr.corp.intel.com (10.22.229.14) by
 ORSMSX601.amr.corp.intel.com (10.22.229.14) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.44; Mon, 13 Jan 2025 04:10:59 -0800
Received: from orsedg603.ED.cps.intel.com (10.7.248.4) by
 orsmsx601.amr.corp.intel.com (10.22.229.14) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.44 via Frontend Transport; Mon, 13 Jan 2025 04:10:59 -0800
Received: from NAM11-DM6-obe.outbound.protection.outlook.com (104.47.57.172)
 by edgegateway.intel.com (134.134.137.100) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.44; Mon, 13 Jan 2025 04:10:58 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=eXbI2FzO+5GasVCTISotYsy4AU+GS8feCooXb4InQnXJ9nxwHtDZ7UHJeB1kamabH+78QJ/AQIWwRo8RYZCY9Z/GyzIk6A87GhvlhAAFofrEw1S1dsEpheRBtj6eAj7HUmf2KswqcPYz2aoPelWLHrSZbotnKQaNM6Jn5wF7kMBKp87W+d0DRu3EK2RGHqQdrUBP75Mfz5gzh/6mPpjoOiz1cO8kV+bkdXMDhYrtxNsyuLVfshSZ/8PEGbpHvg3wLz6C1l9hxFy0VpHImoyqDz7qVh1YhjkS9CzTJgHKBCE2q2PrrjgWEYf9cJ/sNqgkM+IqzDzqZh9oQSMTBNGOdQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=nFrtjvaHhIGuKBrfwMN85mgYX/0fHAH9TcD4BbZQKKY=;
 b=bMnuLzhZTqO2HWCSXrHeHYJsx10pBNHaHCgX1drBLNeJ+jCO7QICepNBgepkJDt2FGepNSKnUSCnHrdLGyWrUaRx6L91Y+nFFEHBOkPXRUBWHUKyo6dQNebQYMwHOiVK8/pSuz/n2vouBjq46ntJFoFTeyutTJCcMA/U1IZJkemyHghemPu8G2B6H/fDIDcjMe4/IALK5uhJzy5g+DBqQuILBauMj6X64ZQXc+H3e7sehURh94kP0+tzTEYxhxzoMiXmhGErxKLxFrgCE7aVpGugvmC6wBTiWom9g4ZrCbgVPvg2n7ClRmcW74pzcZGqPCUWyKdZ5VZe76vbKleCMA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from DS0PR11MB8718.namprd11.prod.outlook.com (2603:10b6:8:1b9::20)
 by MW3PR11MB4746.namprd11.prod.outlook.com (2603:10b6:303:5f::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8335.18; Mon, 13 Jan
 2025 12:10:51 +0000
Received: from DS0PR11MB8718.namprd11.prod.outlook.com
 ([fe80::4b3b:9dbe:f68c:d808]) by DS0PR11MB8718.namprd11.prod.outlook.com
 ([fe80::4b3b:9dbe:f68c:d808%4]) with mapi id 15.20.8335.017; Mon, 13 Jan 2025
 12:10:51 +0000
Message-ID: <f20c339f-5286-477c-9255-e2e1fbeba57c@intel.com>
Date: Mon, 13 Jan 2025 13:10:46 +0100
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net-next v1 3/3] net: stmmac: Optimize cache prefetch in
 RX path
To: Furong Xu <0x1207@gmail.com>
CC: <netdev@vger.kernel.org>, <linux-stm32@st-md-mailman.stormreply.com>,
	<linux-arm-kernel@lists.infradead.org>, <linux-kernel@vger.kernel.org>,
	Andrew Lunn <andrew+netdev@lunn.ch>, "David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>, "Paolo
 Abeni" <pabeni@redhat.com>, Maxime Coquelin <mcoquelin.stm32@gmail.com>,
	<xfr@outlook.com>
References: <cover.1736500685.git.0x1207@gmail.com>
 <b992690bf7197e4b967ed9f7a0422edae50129f2.1736500685.git.0x1207@gmail.com>
From: Alexander Lobakin <aleksander.lobakin@intel.com>
Content-Language: en-US
In-Reply-To: <b992690bf7197e4b967ed9f7a0422edae50129f2.1736500685.git.0x1207@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: WA2P291CA0019.POLP291.PROD.OUTLOOK.COM
 (2603:10a6:1d0:1e::26) To DS0PR11MB8718.namprd11.prod.outlook.com
 (2603:10b6:8:1b9::20)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS0PR11MB8718:EE_|MW3PR11MB4746:EE_
X-MS-Office365-Filtering-Correlation-Id: 211cd5ec-c75b-4360-1501-08dd33cb529a
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|366016|7416014|376014|7053199007;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?TzFHL1dGT1NNUjlzcVVlRTk4eDJjNzJucFFVYUU1eUZqQXVidVFud2pTMEh4?=
 =?utf-8?B?VmFzUXd2dTlLSUZZYnNJREJ5d1BFMS9xZG5qV3BuUnpISXpJMWRXVStHLzRE?=
 =?utf-8?B?RjkvaWZQK2hwVWtDd24yTmJ3bm5YcUsrSGpXclI2RzZqbXNkdTFucStSUVkx?=
 =?utf-8?B?ZzgxNE9uLzVaYWtzSzZBMlpEN090dnJIK3J5NElDdXVBREVxMjVBTXRKMlBR?=
 =?utf-8?B?eHUwMFphUUpoZGVRbDNjV0dqYy81dEpuQUtzZVZYYW1mcXBnMGVxZjZFZkJs?=
 =?utf-8?B?cEZuU1BjcHVnVk1yNGU5WFNleDVaSDRXamRHWisybkw3QTcybDFMNE1jYVFN?=
 =?utf-8?B?aGtLdnhmTTZETWtrd0xvVGFuQjgvRytldlBWS0FUS0MyLzRtbWNqcjBHTDZF?=
 =?utf-8?B?R2ZBU0tDTUhxMVI5cFNkT2hvdzI1QWtQTUhuV0tBL08xK2FOb3FObEFGVTBG?=
 =?utf-8?B?b1l0NWdwZG9yU2lLRU1LbkFNN2FXanVYdkIxV1lVbVhDMkxuQUJQbE1yYXJC?=
 =?utf-8?B?Y2NBeEs0VWQ4MnNNSXFWN0lqVWxvRlNDOGxzVkh4VEM5Qkk5RytGTnc4ZE5P?=
 =?utf-8?B?YUdPeDY5bUIrdTRkUDNqL0dPbmE1UnQ0SXFFWlZFeWFUNDRLb0wvbW1zVEVC?=
 =?utf-8?B?MkZmNFJCU1BUVjdqczljOGE0R2lwU1loVWtTVXVqcUp2bkRmRlRkVVFjbXc3?=
 =?utf-8?B?VmdwcG5IUFFHWjVuOHFFS2VaNGE3ZFdxMlEvSGVIVTVlUGt5NzVCL3prYjl6?=
 =?utf-8?B?QUNkcVF5TnprbWJ3TWxLQ3JrWDJyL2p0aE4yTXlSMUxmWGkrZWc0c0RxQm5v?=
 =?utf-8?B?R0NLMjdWU2FGdHRrR1BDVDUvYzdnMG1xUTZlWUl4amREWmkvcnA0emo4dzNE?=
 =?utf-8?B?T2JGa1p3QkZEV3N0ck93cUIxVFhvRzE3YTU3dDR1aTJ4UkJyV0NmSGJxSUZq?=
 =?utf-8?B?Qjd3NmY0a1NSK1M1MC9uV2xaVHJIcFQ4UkU3ZFhpMWV1LytCYzBLT3IrZmRY?=
 =?utf-8?B?MTI3VUdJVnhLWjJiVm81dTU3RVgxNFBCek0yc1JPVEJLUVhpUEpreVBHa0dl?=
 =?utf-8?B?cFRGWlZDcU1VbW9aUWJhSldwTWYwZ1RuS3V0RnNsSFlPendibVFXQ29zalhK?=
 =?utf-8?B?V1U1U1BvU091WkdkRVYyL01kQytKQmlWUmdaWTJZN2Q2YXdVMnM3K1l0RU5t?=
 =?utf-8?B?Um1VWU9NT1lPQ0pDYmJ4dUlZS0dRdHg4dXFCK0ZWVWluTjB1bEhaNTJjS0lX?=
 =?utf-8?B?N3RaR0dydDlSTm1FSlRiYXkybmxVTUFXQXpCZGQ0Ym56bExQUmdHR0dBWS84?=
 =?utf-8?B?OUVIYkliamhhY1RRK1lJcnozVEpIRVkyNnZNUTFJd3M2OTIzT1QvTytOYUdy?=
 =?utf-8?B?c3RTd2pzVjQ1L3BTcmlqZjJLRG9zTUt1MTU4Vm1FR2pTcmo1cERhTEpYZmQv?=
 =?utf-8?B?QUhENXFKaXlzM0JHakxwRnluNEJobnVXQSs0cU5IeEhDS2xRNlR0aWxQQnRP?=
 =?utf-8?B?MzhZdFJ0UnFpVEt4VU1DNDhUQ1BEd0xmVzZVZDJlTmFtTzA5eDBVSW85a0FU?=
 =?utf-8?B?eENzenVyL01aN1pwRkZLcVZrczF1RVFCdXY2cGtFcHpwSmd0cDdyaVRzcm4z?=
 =?utf-8?B?eVlYYkkremNjemtub0xLcWhNQjdSTDhRVUlJVDVvTmI2dTFhRVV6L3NwNUlZ?=
 =?utf-8?B?L04yK1c2RnRZbEI1OFEya2NONDNad2Qrc1R2c2ZhbmgyYVA2SlM0Q1gyNW05?=
 =?utf-8?B?bGpIckZHODlYVkRrQVpHR0RZa0ZVQTUwcllUSVNyQnpydVV1M3QrS2JVRDFS?=
 =?utf-8?B?YytSTzJyQWVINUw3NDVDenNoUU5ic0pxWm00UWV5MFRwMGFqSmM0Ym93R0xp?=
 =?utf-8?Q?BrJRHQPrHlo8E?=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DS0PR11MB8718.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(7416014)(376014)(7053199007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?czJSYTlnc1dycnRVKzllVE5ITGlUTGNEVDZkbGljMXBuYmJSLzFqR1phVzhG?=
 =?utf-8?B?R1NhUlN4cm1PSXl2b0FtdkJxU0ZOMGwyMjY0dDVHVVYyZVE5N3I4em8xZENn?=
 =?utf-8?B?WGlGVGVkM2lvR1FJWUpoNS81b1Z0amNrNHFrcXhVbWxpQ3YvOFVUbHJDbHJZ?=
 =?utf-8?B?RlVhRENWL1haOW5XeG85aDBFUG1Qb1dyL0dqZFJXaWVWOUkyQzBoMGdaNzJP?=
 =?utf-8?B?amFmY2JGVjdDMVFsYWUxU3lVS0dRSVpWSndBbUVXMS9jSXpOZlNsYU4vZHVD?=
 =?utf-8?B?UDJGbzZNYXU4NnlDa3poRndJWGNMdnVRVk5jWFp5b1ZSckFtWEc2TTd6ZU1V?=
 =?utf-8?B?elRWM0k5YjdTaUVmOU1PYmRaT3NHQVBpTXJ2Wm5kUzVsTGNKYjduZDkzaG1s?=
 =?utf-8?B?SVFqR1pNOEM0OHBlUFY2QzJORFNmNEcrRVR6RVg2ZmttT3NxeGFZSDNqZ0hD?=
 =?utf-8?B?UjhZeTBQVnFjRkF5NnM4cU1XOTV2SkwvWVlLc0loVklQRC9YV0UvWmRpK1U1?=
 =?utf-8?B?UmRQWENFalJSNmIvanpVYlNTOXpTdDFBYVJHOHltNVVSa0JJNEcyMTcySUk5?=
 =?utf-8?B?NkhvYkxza0E1K0ZKaXdNbVJHOGZacHNubkM4T3VsL2FQSVg3SU0zT2VlOXB4?=
 =?utf-8?B?Ni9QNEo4Z0NuQkhSVGZnaXJCNmRhVm9nWXhSVkpRZUZibEFIc05YMndEbXFZ?=
 =?utf-8?B?M1NxRGNwOHpMUXExbElsbGVGMjNPbW13QSs2MmlReitlWlhyeVFXeG1IUEQ1?=
 =?utf-8?B?b25VTVJ1NzVSZjBrNHRITDdvK0x2eCs0Z0Z1SGdGM2FydTZnbE50bElpODFC?=
 =?utf-8?B?dkxUUUI5VnpEL2ZyVS90bE5zOGowbGhlMmt1cisySVYybXpROHBMMTlJV0V2?=
 =?utf-8?B?WnNiWVdhaHZFaGV5YmVDOXFhT3VyZk1peHFGMWhsbS9idHpBdG5zbnRpQnNp?=
 =?utf-8?B?VW5sRGhuVUtJbG9ScW9GRFBacEtBK09aT2tva2srZ201VEtLa2JtSG9NK1pm?=
 =?utf-8?B?c1JubytvNytZL0plUEV0Q09zc1FqQXA3Smp0ZWJVRjlibEZnSnFTV1h6RmFn?=
 =?utf-8?B?UnpVTDI4aTJBT1dNR2tpbU9zVllNVGVLUmoxR2RTdmxGdVhnMGtvM01EYWJa?=
 =?utf-8?B?QWt6bEh4NHFmUW9laXV1RHkwQ214K0I2SUlvTVJhQzF0RUNFRzVDOFVVbnVq?=
 =?utf-8?B?TEtRV2JQYkN2TmtQYm5WNGlwZm1RWUdiN3dXSXFyLzFZVkNrdCtWL29WWU9p?=
 =?utf-8?B?UzFhYVQwSzlYSVFtSVg5RXBVNFBRN0FveWw1RlJkQTVCSjFLWEZOVzBPa0d0?=
 =?utf-8?B?S1NUcEdHeEFwRVNJT1kxR1lPdXNnd0REOTBMcy9udlp2SzJQQXFRQWhnN2Mw?=
 =?utf-8?B?Mm5mK0MzM0s4bjYwTHhDaGt6Q1Yxbm15ek1kTFNOV2diQlBwaXFJM2xTYngy?=
 =?utf-8?B?QUVIMjRzRzViS21VUk9id1ZjQ2JWQktmeU5FVXU4UlV4MHVHa3FqWEhwUHdR?=
 =?utf-8?B?SlR0WnV5WGZCNnR3aWhwQ3hRbWs2aHVqTTJRcXM2RUR5M2dHZjJONTAvMk85?=
 =?utf-8?B?VWt1WU9td2dsTERUL205Sm0yam96TStkbzM5d2JKTllYQU1JeTQxa1dJMGd3?=
 =?utf-8?B?NzdPY1pYaWZVZUxWNndTc0ZQY3JXTENXcVZTbFF4c2Uvc0NvbVUvei9HUms4?=
 =?utf-8?B?OEdZdXRnWnNFMTBUK1ZWVTJaTXlVb3hMdkdNcEd0Wlc0N1Y4a1FYajJ4RjVm?=
 =?utf-8?B?SmxCZE1HZ2s4eU1HN3Qvd0g1T0d5UkxnTEU0VFZmcGxhb2xRVG9ReFFEbzhi?=
 =?utf-8?B?aEY5WU1hMXMxMGlYa3VlSlpidktMNkU0SnA3TE8xMVduM1FERHF6ZDFrOHQy?=
 =?utf-8?B?ZW9HTDJuWCs3bDArMlFWMlo3Y1FlWGpGRDE2QjdOQlVsVVNJY2lJWU15Mjc4?=
 =?utf-8?B?OS95SGpCcVNmOUFPT0RFZFIwenljNXR6SHNGMTZLTVVIbG1VdmFMb0VWbjRr?=
 =?utf-8?B?azVZZUVSRjlUVjFXaWI5dFNvZ3hzRlcxUWZ1T2JsS0ZuVEJOOERKTEp1VzBG?=
 =?utf-8?B?NndGL0g3bnJ6bGp4QktodS95ZTE3Nk1EcWl0ck9RQ2NBSTJJQXlGcDdPUE5M?=
 =?utf-8?B?THowZE1seUFSZXBRUG5Yam5GR2IxR3JnYlYwa2c5N3Y3VmJ3N240dDRVbHl6?=
 =?utf-8?B?M1E9PQ==?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 211cd5ec-c75b-4360-1501-08dd33cb529a
X-MS-Exchange-CrossTenant-AuthSource: DS0PR11MB8718.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 13 Jan 2025 12:10:51.6670
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: SyuhEmvl+AkhgLRziO3kq1OvbJ7QJbN0/1D7srndkIKepi5MqrECxBl501HSEWqj7FVFweqkJ1ytyZgnrMnXujrhhMFVAwgBpV5jwfd8jzg=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW3PR11MB4746
X-OriginatorOrg: intel.com

From: Furong Xu <0x1207@gmail.com>
Date: Fri, 10 Jan 2025 17:53:59 +0800

> Current code prefetches cache lines for the received frame first, and
> then dma_sync_single_for_cpu() against this frame, this is wrong.
> Cache prefetch should be triggered after dma_sync_single_for_cpu().
> 
> This patch brings ~2.8% driver performance improvement in a TCP RX
> throughput test with iPerf tool on a single isolated Cortex-A65 CPU
> core, 2.84 Gbits/sec increased to 2.92 Gbits/sec.
> 
> Signed-off-by: Furong Xu <0x1207@gmail.com>
> ---
>  drivers/net/ethernet/stmicro/stmmac/stmmac_main.c | 7 +++----
>  1 file changed, 3 insertions(+), 4 deletions(-)
> 
> diff --git a/drivers/net/ethernet/stmicro/stmmac/stmmac_main.c b/drivers/net/ethernet/stmicro/stmmac/stmmac_main.c
> index c1aeaec53b4c..1b4e8b035b1a 100644
> --- a/drivers/net/ethernet/stmicro/stmmac/stmmac_main.c
> +++ b/drivers/net/ethernet/stmicro/stmmac/stmmac_main.c
> @@ -5497,10 +5497,6 @@ static int stmmac_rx(struct stmmac_priv *priv, int limit, u32 queue)
>  
>  		/* Buffer is good. Go on. */
>  
> -		prefetch(page_address(buf->page) + buf->page_offset);
> -		if (buf->sec_page)
> -			prefetch(page_address(buf->sec_page));
> -
>  		buf1_len = stmmac_rx_buf1_len(priv, p, status, len);
>  		len += buf1_len;
>  		buf2_len = stmmac_rx_buf2_len(priv, p, status, len);
> @@ -5522,6 +5518,7 @@ static int stmmac_rx(struct stmmac_priv *priv, int limit, u32 queue)
>  
>  			dma_sync_single_for_cpu(priv->device, buf->addr,
>  						buf1_len, dma_dir);
> +			prefetch(page_address(buf->page) + buf->page_offset);
>  
>  			xdp_init_buff(&ctx.xdp, buf_sz, &rx_q->xdp_rxq);
>  			xdp_prepare_buff(&ctx.xdp, page_address(buf->page),
> @@ -5596,6 +5593,7 @@ static int stmmac_rx(struct stmmac_priv *priv, int limit, u32 queue)
>  		} else if (buf1_len) {
>  			dma_sync_single_for_cpu(priv->device, buf->addr,
>  						buf1_len, dma_dir);
> +			prefetch(page_address(buf->page) + buf->page_offset);
>  			skb_add_rx_frag(skb, skb_shinfo(skb)->nr_frags,
>  					buf->page, buf->page_offset, buf1_len,
>  					priv->dma_conf.dma_buf_sz);

Are you sure you need to prefetch frags as well? I'd say this is a waste
of cycles, as the kernel core stack barely looks at payload...
Probably prefetching only header buffers would be enough.

> @@ -5608,6 +5606,7 @@ static int stmmac_rx(struct stmmac_priv *priv, int limit, u32 queue)
>  		if (buf2_len) {
>  			dma_sync_single_for_cpu(priv->device, buf->sec_addr,
>  						buf2_len, dma_dir);
> +			prefetch(page_address(buf->sec_page));
>  			skb_add_rx_frag(skb, skb_shinfo(skb)->nr_frags,
>  					buf->sec_page, 0, buf2_len,
>  					priv->dma_conf.dma_buf_sz);

Thanks,
Olek

