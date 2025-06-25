Return-Path: <netdev+bounces-201228-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id D9B48AE8907
	for <lists+netdev@lfdr.de>; Wed, 25 Jun 2025 18:01:26 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id DB5391BC590D
	for <lists+netdev@lfdr.de>; Wed, 25 Jun 2025 16:00:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5BE6E2BEFF0;
	Wed, 25 Jun 2025 16:00:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="hzP4MsjS"
X-Original-To: netdev@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.13])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C4FD626B76B
	for <netdev@vger.kernel.org>; Wed, 25 Jun 2025 16:00:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=198.175.65.13
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750867211; cv=fail; b=M+Sotehnqi4q65G9eYgujmJ1BUTWIABDSK/YsB01XigaIPFtf3ItyuNxO6/02xubYuamGfJtcTge9QwPee6UQbKRRIjePUbN5FLLJv7qMggBTeU01z5owg66yHdebmbE1PYzA2OaW/ZEuSvdjbK9ZkoJRAB40QBWgTL53typqPs=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750867211; c=relaxed/simple;
	bh=OICqJu3skn11oJspKZvnSwSX5j26TYD48OJnG7GdILQ=;
	h=Message-ID:Date:Subject:To:CC:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=NXlMnf8z5fwtjJBxfdF2Nb5cn6EniQfGn5L04LDMYdtBmjmms8eSqBQbRNOsvvnUtUOE1zpw449JPlL1PViJqbOdqDgq5HxCxQwMac6n293zG51RxcgwdVQFMKxUuZDhlPjH+0rtDAvylVFMhdcuM9xWaWEAXGrg1cv6l/zXoQg=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=hzP4MsjS; arc=fail smtp.client-ip=198.175.65.13
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1750867210; x=1782403210;
  h=message-id:date:subject:to:cc:references:from:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=OICqJu3skn11oJspKZvnSwSX5j26TYD48OJnG7GdILQ=;
  b=hzP4MsjSTzzKnFQYqbRmzdFWDMWNLc+y0idLMYCpfBG2QlgQlSxa95eL
   HLngwBT+fdkg9118dnZ935oY0kdx2U4QFzq49FDPqEkmlC1yM0k/CCq7e
   dfna5AVO2jUxKWvqTrmDFgQnoPn+KaO4Zu0bm3MiwURE0PO32jmPQ0Ikk
   7+NErtsUqhnN+y3kpqrVuTYYwQ0+t+cVULoqlz+zibVSTakEeGM747f7b
   LQPZEu2JHqGzena+lQmRoAICye9yIDhFFg9FKUyHfwWTx98ySg1YLB/9B
   xJCqc4iLMgEG7foVKxTQ2Dnx5+o5BIQSSU7dQx/4tHSlvP+3HszxNTzDs
   A==;
X-CSE-ConnectionGUID: URom3EiqSxKzmOupuchmrQ==
X-CSE-MsgGUID: 1/OH3xGWT5W+sVTI5viSwg==
X-IronPort-AV: E=McAfee;i="6800,10657,11475"; a="64204120"
X-IronPort-AV: E=Sophos;i="6.16,265,1744095600"; 
   d="scan'208";a="64204120"
Received: from fmviesa006.fm.intel.com ([10.60.135.146])
  by orvoesa105.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 25 Jun 2025 09:00:09 -0700
X-CSE-ConnectionGUID: x+RHf3KESu6XtHOGs88+2g==
X-CSE-MsgGUID: KSnObqBFTg+dqr2YEJIhFw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.16,265,1744095600"; 
   d="scan'208";a="152382689"
Received: from orsmsx903.amr.corp.intel.com ([10.22.229.25])
  by fmviesa006.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 25 Jun 2025 09:00:08 -0700
Received: from ORSMSX903.amr.corp.intel.com (10.22.229.25) by
 ORSMSX903.amr.corp.intel.com (10.22.229.25) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.25; Wed, 25 Jun 2025 09:00:08 -0700
Received: from ORSEDG901.ED.cps.intel.com (10.7.248.11) by
 ORSMSX903.amr.corp.intel.com (10.22.229.25) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.25 via Frontend Transport; Wed, 25 Jun 2025 09:00:08 -0700
Received: from NAM10-MW2-obe.outbound.protection.outlook.com (40.107.94.63) by
 edgegateway.intel.com (134.134.137.111) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.25; Wed, 25 Jun 2025 09:00:07 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=H1IV/6YTHyw45vBhlVh5QYnUdGNaXAofMkRfG0HNJjw35121mcZ56YfZyA6d0WLChAdXlpfyaVQx9xC0ZS5lmRkpzyDUFeTLFAtpUJcrhBVCyvgzmv5s4XCynUMFYMDCgNmyDn9YcfrKCzwtMUdGc2yabQiyp/A8li8H713ruyfJcw6yp6kw0nJGJJir/iBmjhzvQgi/oAoWqIyJOKX/3EzoXOIzvozzTl0pMbHdmFGLWSyhYHjcyfqHczyZUzQF4v+es712njH3EUHJAN2DuyNs5Fq/ZjdOfYs/MedqF7aUuT2Hzzfdo4FpihYhR5fRSbtypZmV6eVJErH1rwgLsg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=iYhuMQ2d3DrX9sVBtuX1fCI4CLSC5Mphx1MFLeO2HRk=;
 b=Hn5gqXpX99GjQelDIqEAXGYhnlzqS5xtDYrZslnWybJ6UXcHQNgX0Oojx9l8sOoL3sm4y4+utMv4dM9ppHOUHj0dmwdiAn0HGszUnVNxhC6a7DfrHwDUcIUsOOa34jeuhY0kqJ3vbvoXXIjx5yNHIzM3SklPH5EG/jQIGqOcc1wy3h9d2FmtMJbVFdfgkdY24s8JQhNHCvzcJG8nUmK8s6LUU1QgFJRsp8dba60l9Vzt4jX0qQaOZQoerMq8RtfIuQ7MbJffen52guwe+SaxUs/syDqxpQjHyl9vyBUa48iPKSv/QR1AClm+YvXdd75fzMmmMwBQH3ALwd6aS+Gshg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from DS0PR11MB8718.namprd11.prod.outlook.com (2603:10b6:8:1b9::20)
 by MW4PR11MB6571.namprd11.prod.outlook.com (2603:10b6:303:1e2::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8880.17; Wed, 25 Jun
 2025 15:59:34 +0000
Received: from DS0PR11MB8718.namprd11.prod.outlook.com
 ([fe80::4b3b:9dbe:f68c:d808]) by DS0PR11MB8718.namprd11.prod.outlook.com
 ([fe80::4b3b:9dbe:f68c:d808%3]) with mapi id 15.20.8857.026; Wed, 25 Jun 2025
 15:59:33 +0000
Message-ID: <eef65ecb-fd58-41e8-a816-c086d0e11081@intel.com>
Date: Wed, 25 Jun 2025 17:59:28 +0200
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net] net: airoha: Get rid of dma_sync_single_for_device()
 in airoha_qdma_fill_rx_queue()
To: Lorenzo Bianconi <lorenzo@kernel.org>
CC: Andrew Lunn <andrew+netdev@lunn.ch>, "David S. Miller"
	<davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, Jakub Kicinski
	<kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	<linux-arm-kernel@lists.infradead.org>, <linux-mediatek@lists.infradead.org>,
	<netdev@vger.kernel.org>
References: <20250625-airoha-sync-for-device-v1-1-923741deaabf@kernel.org>
From: Alexander Lobakin <aleksander.lobakin@intel.com>
Content-Language: en-US
In-Reply-To: <20250625-airoha-sync-for-device-v1-1-923741deaabf@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: DB9PR01CA0028.eurprd01.prod.exchangelabs.com
 (2603:10a6:10:1d8::33) To DS0PR11MB8718.namprd11.prod.outlook.com
 (2603:10b6:8:1b9::20)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS0PR11MB8718:EE_|MW4PR11MB6571:EE_
X-MS-Office365-Filtering-Correlation-Id: ee835d4c-e20d-4d39-c8ee-08ddb40146c0
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|376014|366016|7053199007;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?VnphSkU5ejRxVU8rYkJtUjFSb05VWWtLMnlYZzlGNXBDbDhvT2grb2JNejRR?=
 =?utf-8?B?bUhnZDZTcERZM1lod1J1OGowM3NndkptaHFmRWR5UmM2YVFVSTVqVDN5L2o5?=
 =?utf-8?B?NlNvQnBtUXYxSVR6NHNPRDRUK3dGKzdtb3JGNjUxbTU0SWtGRHh0KzB4MXh4?=
 =?utf-8?B?d3RqWGExVEt5TkJkRlR1NXgwSjhud29aVGhQR1J6OGVXTUdkTmpuamZlWWNo?=
 =?utf-8?B?R0cxRUxCTXNlQmNjd3liYnZ6WkxESFdhcE05ZVBOUG1CeHZVKzFINE1LSkhr?=
 =?utf-8?B?REtDVEJZc2xwYVBMZXc5VkNDVzFhalpMNWJzTDlrMW5kbGt6TkdwTXBWYWMy?=
 =?utf-8?B?aXRZSnBmU3dtUjFjc1dIWC9wOHY0ZXZZaVdNUG5GRWlEdUs0TGt4dG5ENEpR?=
 =?utf-8?B?WGdkSFZzMkFZVyt3K1FhempYbGsrWmdnWFluYTE0QVFKZnpPcVZPR0hTV0RG?=
 =?utf-8?B?dms2Qi9lY25CVS9SWUZuZWVPaDV3d2lBNzJ0MzFyQ1dPL1NrVmZEdjY5Zm13?=
 =?utf-8?B?dHhHTUR6VUU0SnRjUzdzZGNNb1pzU2FzZ3psRkdzSkpSSGx1RTVvWWlSL09k?=
 =?utf-8?B?UThkN3RrTGVyem1LYmRyUzBHT3k3OC9GVWNuNGxGV2d1eHlSQW5OOFhxUVM3?=
 =?utf-8?B?VkZxMmV2UnpIaXd4YmVGSFlXYk5OaGp3Ui9RSjdHdkpmNDB0RTJVaHBFNW9F?=
 =?utf-8?B?UjdXNndsMXFRcndnQ3RLUkh4YjdUNDdTMkxDOUM4Q0RMem9pb0huWkhnRTg2?=
 =?utf-8?B?QjUxaXZEc0grYU1qLzVhR2pIT1ZUS0R4WTY2emJFK3UyckF3WHJvU2p1Ym5k?=
 =?utf-8?B?MWlZU2s3Y0NZYlMzL3FPb2tpKzQwcW96TmlJNFNRRzBNQ0JWNU9VOU5nczNv?=
 =?utf-8?B?SHRHaVUxdkQ5SW5zeUJpU2pNRmVZL2NBWFZXYzF5am1lVlY4YXdoVHVHV0w3?=
 =?utf-8?B?OFhhQWVJOHpzdzBrOXhieHBZY0x0aU9XT2J1ckcvOWZaOW1obUl6dThaNzhm?=
 =?utf-8?B?YVZSSXg3OHYvZERDN1grclpvM3N0TE1VS3lpUSs4SXVQd1MyaUtJb1RRS3Z3?=
 =?utf-8?B?d1hiSVF4Zkl6bVlyeTY3RHVRSWU0a29zTGtxbVQ4aW5RN0lldC85bS9zRjlO?=
 =?utf-8?B?OE90Nlk4a2xvSFhxSm5kNDQvdjNrRnFFcWRxNWxuWTQycjdYeGRBK3crV2ZG?=
 =?utf-8?B?ZXJVQUppazd3K3ZIVCtYVUpKWjl6bHh6ZnhzbzZNQ015dkI5aHd3Ylh0bHoy?=
 =?utf-8?B?ejlBYW1UTk5ac0p4bmZzS1lRSEVlc1Z6OFZ6b2ZiaEo2dTZzVGlWRjZObEl2?=
 =?utf-8?B?cjNlaDQrQVdyWldGeXZDTHNPY25TdVR4TDZPM1FZc05nb0diMjZYbG1US3VD?=
 =?utf-8?B?MysycHZmT3NtSFR1cndIRTNibmNrc0d2cHNUUHBGMTB6aGVlbHVjeUI2d2o2?=
 =?utf-8?B?cUprd2FKZzlLb08yaUVDUGlWS2JSRjNXT2lmR3o2ZVdING9GZ0VKN003R21m?=
 =?utf-8?B?eDUyMGFobUtpaTNCZnFCd2grNU1LZVBKSSt1LzFKMFRtajIvaERMVU9uSloz?=
 =?utf-8?B?VmRtbWpjN2NPWUpuQ2QwWkxqTXdPaUUzbnJzTnR2d09TdGRMRnhBbjNORGhG?=
 =?utf-8?B?bFN2T1V3T1FUUEJ4MjQ2OUI3bGlxYUNZbllsRVBXUTZyenpFSTJMWEhUa0ZO?=
 =?utf-8?B?NjlMRG4xQVdTUVNXV2czT1hQMDlTeXAxQ2hyVE93ZkhvMDl1emRqMnU5d3d6?=
 =?utf-8?B?dG1rMnlmclN5T0NkOHJ3cUtkeDNmVFBTSjBvQzBZcDJuVXdEejl0ZzJyQ3Ix?=
 =?utf-8?B?a3lQUW40UU5YQ0pjck83eml5QWVVWGRzMWdHbTlKSUdJcEg0VDhnN0IxNzU2?=
 =?utf-8?B?S3kxYW1XRmpCRzVxeDZuR0dDME4yeHh5YWN5NExzSXBuU2c9PQ==?=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DS0PR11MB8718.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(376014)(366016)(7053199007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?cmVRbk5yaTROOWtyRHFkZDBYaDNPVXRpWWpHTlhSTlIvNGVSQjhncDBGTitP?=
 =?utf-8?B?QkcwYnBiOHlYSUNYNjBCYUJwYmdoRkQ0QWZkeEFHQ3NxU0dZNE1KdG5nNEdF?=
 =?utf-8?B?d2c1TzJSLzUyMlR0T0R5MXFiYmZkKy90czdhaFFyeGtOeDZZTkZVa21EUW1P?=
 =?utf-8?B?M0NMK1lraFUwU3pvZW1SS0xxZGxSMWVlRE9mc1Z4K0VFSlFyNkpSOWhiNlkw?=
 =?utf-8?B?VVVHSDVpcndoRXplWTlWK2FvZzFoRHF4dExITWVqQ1h4djBWeUJMblpWV3hD?=
 =?utf-8?B?RVpHdWdVMFYyOVI4Mzl3Rnc0cGtiWWtvdG5vdE54cEhMNU1hQ1haZVlMN2tn?=
 =?utf-8?B?M1dsRURUa3lSdS9wZ3BncjZMcUtjYWxCK0orSFZzYldxNmVpZnQ1eFJ3eHNk?=
 =?utf-8?B?R1lQakx0TGlWZWFBNnYwa0RrcXAwNnhuRTl3RHRCUm5Bc1MvRldlb3ducEVM?=
 =?utf-8?B?L2N4ck9ZQ00vbDErUzZYd2J2NTlaU0xYcnMzVFBlM2JaTXNqWHQ1Si9nYjFB?=
 =?utf-8?B?Nmoxc253WmdHcUdQQy9CSUFkancyRWhLekk5dDIwdWc0c29PMFpOcDlXdmVu?=
 =?utf-8?B?WmJLd1BrUUJZS2toWXZjN2owWjRuUitDbysrTEpMYWRjRVdNQWhiYmRCVDVH?=
 =?utf-8?B?R3VtNWczVkpRT3p3SmxOQWVwMm5WQlJyTzVoL3FTTm5nQkVWYnREQTZPRVJL?=
 =?utf-8?B?VmFrK3FqZXBCeTRGdjVnZWcwdHNsbzRVK1NmaXNwaUR0QTBia0ZzWkNQcnRs?=
 =?utf-8?B?dWdxUTRTZFU4dUU3Zjd1dTVGREQ3RGU3T20xbzVPcE1FdHZjM1VNZ08vcEs4?=
 =?utf-8?B?VE5YYjVDV2MvSFJSd20wNzgvdkNncWtsVlNEdzR4MHRwcC9TdXJXMlNGQ0Zv?=
 =?utf-8?B?aGIyUjVwTVliZFdjbjJsazVqOG13YkluTHhtNTFIZlpEMWlQdHdDV1owNHZT?=
 =?utf-8?B?MnBnRzZpZmNKSGVNQm85ZzI0aUk0QzBtTlovSFMvTEhKK0xHeXQyWUV6RHlM?=
 =?utf-8?B?NVN5a3RDa08xNU5wcytUWHVya2JiVW05Sk9jZ0pubVZhTG9vaWc0VVhUYXI2?=
 =?utf-8?B?Y0YvSGVyWUY5NStvbEUxNVdHYUxWYUc4b2h5bzZNRndENWhhTmVNa0lkU01m?=
 =?utf-8?B?OHdtYnpPUTRKMHdrbEtTdHdKSTNGbEVCMndCcS9uNVQ3d0x3bTNBOUZVSVpP?=
 =?utf-8?B?RU93RVRhb21oWVp0akNacUUwOVRUN0o4NEVVQldDVGtIWnRHTGhCc3Q0MXN3?=
 =?utf-8?B?a3B1cHdDTTBOZE4rRGQyZldkR09jbGRKWFVQZFpCdEdHNE55akFsdzJBSGpE?=
 =?utf-8?B?L0ovS3RQUkhhbjhncmpic1dhMmhSU2lDTnVOMkU4TWFKOGFsTXUwcTFTTnNS?=
 =?utf-8?B?WTJHUFRpY3JDR2ZxZnZyd1EwdnlQd2NlWStBUGhyTzFTUTFhcnlGUkVjVUhU?=
 =?utf-8?B?Q293Nk1KNE1zWFR4OFpsTlpvcUp2UWM1SWZVaVhvbHJZKzdkVWgwaEpOQ0dN?=
 =?utf-8?B?QVl4WU4xTDZKUm1pM0dvQ1lSUThBZ2NNdWVSTzZ2bUtNWDM1WGw5SVg5UnA3?=
 =?utf-8?B?UVQ3UG41NXBEUHlaRmhXVzdMcGNBK2VuTG5qTUk1bUNPOTZhckZ1dzlrY3R2?=
 =?utf-8?B?K1VFV2F4a05qVUUwb3ZZeWNYTWhuQWRtZEJpd055ZkY0ay9odDFvN3ZwTFEr?=
 =?utf-8?B?Q0VRWUo5Wm5va3l5RzV6RGYyd0l4czFTTE1GeG5razRPckRBT0FLMUxuSThI?=
 =?utf-8?B?WnhMeHZNc0w2SndwdXBZTk1WQ01qaGdOQk1NQmhGNE9MKzA1ODZqNEM1ZnFk?=
 =?utf-8?B?ckh6OEw2ZEVDZmdLMjFzTkIwRTdmSHJ2QVNHT1pRSWtCTHlSV1JyTTdlNUQ2?=
 =?utf-8?B?K2tmVWNid0hPRXJkSFl4VDlSNUxmNzJwek5UYWg5Q3U5UXU4SnlrdHR2bUc3?=
 =?utf-8?B?d2lkZWVLZyt5TWRSZi8xRm5yWlJZemphNEtyU2VYQ1E2eWpjRTJGV1dKSFY3?=
 =?utf-8?B?ZzdJdkdLK3RBNVE2OUpLNXNMcUxVMDN6ZWxDYTZlMHdqNWUvbkpkSHVUR0Jx?=
 =?utf-8?B?cVdnY0ZNQ3NmeXR3K3JYUVZjd1Zoc0prWUdGcys4Yk83VjZwZTkwb3Y0cjVE?=
 =?utf-8?B?b1Rzd1JpejlEZzlHOWppMnFsSmFoekNmRTh3NThWdUF0Rmk4QXhnMHREYXFs?=
 =?utf-8?B?SkE9PQ==?=
X-MS-Exchange-CrossTenant-Network-Message-Id: ee835d4c-e20d-4d39-c8ee-08ddb40146c0
X-MS-Exchange-CrossTenant-AuthSource: DS0PR11MB8718.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 25 Jun 2025 15:59:33.3403
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: r8fVKG9Dopbx1ELKTw9XM01BrVxg6jaiPnQTcvRA2Ai/F/tqc/QWa8vSNme5acIY7ZQHc6I7nTlpYjfm8DC49yhFXBNPUhMT/G9axa1wMA4=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW4PR11MB6571
X-OriginatorOrg: intel.com

From: Lorenzo Bianconi <lorenzo@kernel.org>
Date: Wed, 25 Jun 2025 16:43:15 +0200

> Since the page_pool for airoha_eth driver is created with
> PP_FLAG_DMA_SYNC_DEV flag, we do not need to sync_for_device each page
> received from the pool since it is already done by the page_pool codebase.
> 
> Fixes: 23020f049327 ("net: airoha: Introduce ethernet support for EN7581 SoC")
> Signed-off-by: Lorenzo Bianconi <lorenzo@kernel.org>

Reviewed-by: Alexander Lobakin <aleksander.lobakin@intel.com>

Thanks,
Olek

