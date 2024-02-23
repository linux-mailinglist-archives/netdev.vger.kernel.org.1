Return-Path: <netdev+bounces-74262-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 9AE33860A1C
	for <lists+netdev@lfdr.de>; Fri, 23 Feb 2024 06:00:56 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id DBAD4B235D1
	for <lists+netdev@lfdr.de>; Fri, 23 Feb 2024 05:00:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D0D91111AB;
	Fri, 23 Feb 2024 05:00:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="MPy5OzXH"
X-Original-To: netdev@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E63FC11705
	for <netdev@vger.kernel.org>; Fri, 23 Feb 2024 05:00:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=198.175.65.18
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708664449; cv=fail; b=VtIxQloN5MWJ+fG9wqEAIozo15oRrFs4EOOQ+/juVaMLqZEMjRDGlUddkLsg0puQZ23u3HlUgmGdTf7wzDRB1T7TuKkPu7TMmmJOtMfGBC3l51uKukx9m31oaMEvXeS1M2q1d3dw1TxnuVduO6tuuOk3+0aHOvFRzd8GCwG7jxA=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708664449; c=relaxed/simple;
	bh=DewVNwLSxDKXvul853mfRuPJJJkOiq8m1yTrfXaYSMc=;
	h=Message-ID:Date:Subject:To:CC:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=hK7sJzN70nee1ydehGmSx70BhzZMGjf/RZF/Y49pGQVsW7epzvTFz6lvNrxMfdVlj+EV+Z1MWITX+y9oIR6/b772jFwOBOeIei6B/WRdtFlVnkR0Ih4bZycMDMRyukkDVn8YJK7V8WAFrQDuLhNsWNukCduUn71uJv/zDyc4X+U=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=MPy5OzXH; arc=fail smtp.client-ip=198.175.65.18
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1708664448; x=1740200448;
  h=message-id:date:subject:to:cc:references:from:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=DewVNwLSxDKXvul853mfRuPJJJkOiq8m1yTrfXaYSMc=;
  b=MPy5OzXH2zzrv2WdbaaVJNdEDTf0tpxh1mQTLFZ+yrcriK+gnqKEzpCM
   BufVSgHREnje3SEBPGbzIfp15DgMpWxig63SWzvGi68/b6IXlnvmB5D7C
   qfCoIqEw5Iy5hWRrYyK5yqI5gEADphE3cINP3ZAcdfo9q+A6fKSc/CNUe
   K30fTCL69YEgt7BJP+Sp98kLQZLWAjKt02YZrxpOERdPNM7XLgPDvCVpj
   lPJb/pSP1+gsOjDptbQ/JgcOeVCDcaGE90nyLWX3ZCnVUgrYOHIROrdyI
   T9vPZA5DTzEilaCleoq8vEl9YMwmuSTnltn1jt7XUDaozbSsfaMZJY3EH
   Q==;
X-IronPort-AV: E=McAfee;i="6600,9927,10992"; a="3090601"
X-IronPort-AV: E=Sophos;i="6.06,179,1705392000"; 
   d="scan'208";a="3090601"
Received: from orviesa004.jf.intel.com ([10.64.159.144])
  by orvoesa110.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 22 Feb 2024 21:00:47 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.06,179,1705392000"; 
   d="scan'208";a="10489730"
Received: from orsmsx602.amr.corp.intel.com ([10.22.229.15])
  by orviesa004.jf.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 22 Feb 2024 21:00:47 -0800
Received: from orsmsx611.amr.corp.intel.com (10.22.229.24) by
 ORSMSX602.amr.corp.intel.com (10.22.229.15) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35; Thu, 22 Feb 2024 21:00:46 -0800
Received: from orsmsx610.amr.corp.intel.com (10.22.229.23) by
 ORSMSX611.amr.corp.intel.com (10.22.229.24) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35; Thu, 22 Feb 2024 21:00:46 -0800
Received: from ORSEDG601.ED.cps.intel.com (10.7.248.6) by
 orsmsx610.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35 via Frontend Transport; Thu, 22 Feb 2024 21:00:46 -0800
Received: from NAM12-BN8-obe.outbound.protection.outlook.com (104.47.55.169)
 by edgegateway.intel.com (134.134.137.102) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.35; Thu, 22 Feb 2024 21:00:46 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=UXUitTjaeoIWvjfZ5tI7sGvi48kZv3ME7dZgEaJWaVd1C+J3RZzOuWbZ36SAOkeXLGQ4CRsDHB4nEhUKCgudA3IJJBlip+S5YTe/x725IEUQAmkAMA4/esIHsiecrUY/95ZyPMwH7HzlUGZzmx1zVdLFhocJOQ2z69u9Mfk4p/aQUxvYLuceVg1ChIuQNiMNJmX2IldOCPrMjr9059YLsmeXLre/Vd+3Iyi1tNIdmDb41WzcMBqq6QemnsqMPsnFI8MqYr1FqNU7AZCqDSL5RjGRwRUoVU9JjmMv999dtRFq45s4MImPIlOzqotBBQubEi7roarPPRPYrlLqaLAOwA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=OySVyfr8z5Xi5y4KysTJ+fd0GkOyb0PzUifI2m85NqY=;
 b=D0l/Nz0hryo2hpTtVQjeG3SJMquPXKq0/V30hqpFQfP5admn/GKaezg85XPgEoa3uPtjTf6U0g9UNEYd9Se+0qpPr8ULsIyBC0SxzrHT2mzudg4h+tlAUOtG0Vdr9yaKGmfJpOShZtaTae6kgHFrkzr9OyF/DT4QM9kl5u5gY3ipze1U3LpJaqEtzCXDy+NWcTrCFXfTOwh3PDlQyXzuRyj1SNWwoe2A6pQQ3noiNPDNDn/t5YNxN5fxAhdOf4xJU/CWRD1x8PzxNLtnY/uecScnjO+R34TseXazxDCu/smt1CbADTqSq/Lpg0St+FqPYVzVZcLxSED9P08z45OKdg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from SJ0PR11MB4893.namprd11.prod.outlook.com (2603:10b6:a03:2ac::17)
 by CO6PR11MB5665.namprd11.prod.outlook.com (2603:10b6:5:354::24) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7339.10; Fri, 23 Feb
 2024 05:00:43 +0000
Received: from SJ0PR11MB4893.namprd11.prod.outlook.com
 ([fe80::28cf:cc9d:777:add1]) by SJ0PR11MB4893.namprd11.prod.outlook.com
 ([fe80::28cf:cc9d:777:add1%4]) with mapi id 15.20.7339.009; Fri, 23 Feb 2024
 05:00:43 +0000
Message-ID: <b7b89300-8065-4421-9935-3adf70ac47bc@intel.com>
Date: Thu, 22 Feb 2024 23:00:40 -0600
User-Agent: Mozilla Thunderbird
Subject: Re: [net-next V3 15/15] Documentation: networking: Add description
 for multi-pf netdev
Content-Language: en-US
To: Jay Vosburgh <jay.vosburgh@canonical.com>
CC: Jakub Kicinski <kuba@kernel.org>, Greg Kroah-Hartman
	<gregkh@linuxfoundation.org>, Tariq Toukan <ttoukan.linux@gmail.com>, "Saeed
 Mahameed" <saeed@kernel.org>, "David S. Miller" <davem@davemloft.net>, "Paolo
 Abeni" <pabeni@redhat.com>, Eric Dumazet <edumazet@google.com>, "Saeed
 Mahameed" <saeedm@nvidia.com>, <netdev@vger.kernel.org>, Tariq Toukan
	<tariqt@nvidia.com>, Gal Pressman <gal@nvidia.com>, Leon Romanovsky
	<leonro@nvidia.com>
References: <20240215030814.451812-1-saeed@kernel.org>
 <20240215030814.451812-16-saeed@kernel.org>
 <20240215212353.3d6d17c4@kernel.org>
 <f3e1a1c2-f757-4150-a633-d4da63bacdcd@gmail.com>
 <20240220173309.4abef5af@kernel.org>
 <2024022214-alkalize-magnetize-dbbc@gregkh>
 <20240222150030.68879f04@kernel.org>
 <de852162-faad-40fa-9a73-c7cf2e710105@intel.com> <16217.1708653901@famine>
From: "Samudrala, Sridhar" <sridhar.samudrala@intel.com>
In-Reply-To: <16217.1708653901@famine>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: SJ0PR13CA0110.namprd13.prod.outlook.com
 (2603:10b6:a03:2c5::25) To SJ0PR11MB4893.namprd11.prod.outlook.com
 (2603:10b6:a03:2ac::17)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ0PR11MB4893:EE_|CO6PR11MB5665:EE_
X-MS-Office365-Filtering-Correlation-Id: b69ff389-032a-4ab2-b300-08dc342c6379
X-LD-Processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: jiOE000izCZXWai1lv5s/qU4ctorDibXVLTI9SXkVLqNSONF+5gknORxVTd2RE/iNdw08WHG+xjM40JV5Oin9Sf62bj8TTxdrLP+Wbcxhbo9NDGznhj8MlXRaRms/k6QhlwYdxlUR56V4upisb+6z2zXIswpsyPBz8inBQnCLtMBENrJaeKh+qfW8jy/CANkIV15GRNIROtQGM4D0vJnfPmxooBhHCmQxWe8LOmrc+GOyAsE4yucDPKwwNI/n+sCDMGHVJitJpwSj4YOOOLmNa8oXzK+AJcGr/zTuXLEbpPO8HQGODplgR5AMAOhZvdk+O+6fsnoZO8PcxqkPdjQkD4fMhRKyyT8tt1osJnBWFUai25S9+e82eM6p0dtyTczfySIX3xDy+ZQ19KlOXsMLNwq0SVAUrWX0YlHZhKylAzIIJ51FkPuLU1xTKZepzdA++3wwBJRXliTQO4Ev0+J0l7RjzLT5JrT+s40rPoqw53du/wikhuSBK/v0neBMkYxedoF3yclxWnz4yc00eJryo6KzxbWrkt2s2KYvno+vXc=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SJ0PR11MB4893.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?SEplOFExMy8xU3F3Z3RmSnpyTitlUHJDanE4VkFQWVZibkVHMERZTkRIZ3RG?=
 =?utf-8?B?ZnIyTkgxaURCaDFjLzVyUWFOaG56S0Y2NHg2SVppOUN3ZWlaTU5zN2p4WWZ6?=
 =?utf-8?B?dDc0R2NqS3lJZHFteGNNVGk4SlFWS3RqWDJZUHFWdUdMMi9MUDRwV0EvY0hx?=
 =?utf-8?B?cVpjbVRZVkpBTm92RkpIam5vT250c09QQjd3OXg3dVhBOG9od2dxa0RHV2pF?=
 =?utf-8?B?MkNUUXhoZTI2ZFZCTjVyQTBwaGFBYWtIRnloSkc4QVRZYXVpWVBCeWlWcWln?=
 =?utf-8?B?SUJndi9tUnNTVXRHR3hoYjAyLzMzK3VCV0NtTExVT056RkNlZlNOTUJtS2sx?=
 =?utf-8?B?WVJVNlVBK1pkL2dCdFBNRGZNdEVqVWNZa2Z1YWo0T2cxMkU2ZlRsZHg4ZWZt?=
 =?utf-8?B?NEhEeUZ6Mk51WithY3d6OVpOSGdYT1J1QmpGSmYxYjlpUGJEeEZwbVBZQ2JC?=
 =?utf-8?B?MHF4NVdidUx5WmJ1cWVvejlaWGMwVW05cnAxaGMrR0Joby9nMFJGUWdPYUFa?=
 =?utf-8?B?T09PMCttUC9oRFhKZTVMckdrUlVLQkhHenJic3ZvaHAxaGp1Qm83a3JIRENJ?=
 =?utf-8?B?L1VhS3NZMFhlVnZ4Y0tXWkI3NlhNSVprVW92UVlzMHdEbStMRzB1OUtUYnBi?=
 =?utf-8?B?T3NFd1h2N1dVMjBFY2wxQzN1eVdNcElOSnBjUUhmWUlGRitFbkdvOHlJbnRw?=
 =?utf-8?B?NEpiYWluYWlncXE4WDV3YWNCdUJ3MWNpR2ZMVnM3Qks1K05OQ28zRHE2QW1S?=
 =?utf-8?B?NVF6cHVJbGR4QjFiS2ZIZEFlc2F6bVJ0ZmdTbmtpVzAzeVFjVWxvWStGdjdv?=
 =?utf-8?B?ZE80QnhzYVJreWNJeWVLUFhWbWhma3RsWEMzd0VFOXc4UldJNkJ5VDlxTUNO?=
 =?utf-8?B?azhXUU14ZEcycHprSW0yYlArNzFqYUVxWjF6UzYxcWxqMWRxV3ZCdmVzbFVy?=
 =?utf-8?B?elBMclZlY3MzU2ZiNVFXdmJJT1dWREx0bG0vb0pvRW9PTTg5WTA5eDdNanlW?=
 =?utf-8?B?eDgzYzZ1Z1VNb1pZVkd0SGV2cGFDeUVDQTRBNzRIckJPWWFjZjdOYlZhNndt?=
 =?utf-8?B?WHNQejlIMDhSdDV6TVd5dkVpUkNISENvcWl3Si9jZ1p5SGtVSEFUU3IrQUVy?=
 =?utf-8?B?Q1M5bUsvMFRSR0lPVE9BWWNXaFNVeCtqcHlyMXZBWVpUOWZVUWg0czhPSzNP?=
 =?utf-8?B?a3JLaUdoOXk1YVpsdmdjSDhoZ09sc3V0ekRac2diY0RBMFk5M2puWnI4Y1hZ?=
 =?utf-8?B?WDRHNWJubTlZaG5wQjJYYXR1RWszS2IySG10U0crcnF2TGpiMmtJVnFiZjZZ?=
 =?utf-8?B?b1ZOY1pTSjdRTlRKcnNSTzNwcVlxdFNaYnBMM3dSMjBOSzlSZTNpRkZSeER2?=
 =?utf-8?B?SktPdzA2WGl3UHErTFlNRjVQRnFXenNPZXNjTTA0bjJGZnBWc21pSmZ6VW9i?=
 =?utf-8?B?SmFSanN4YXFRZkJlUllVQ2xnLzdOd2pyT0plRGFJZ2E5MWh2NVVPeVcvbGor?=
 =?utf-8?B?UVJpWWJwWVZ3VnN4Y1VCK0didkVBa1EzWUl3SWpXZWJ6YVVmR21uOFovK0JR?=
 =?utf-8?B?VDFaMUEzQm5OcmpBejhROFE1MThkUEVpT3lkb09RYUVvc0xwc0RWNURSWkgr?=
 =?utf-8?B?TEVjazJyVEI0eUV4bkk3WGtnbGZHWFpnTHZwdzVmYUZuQjVUd2dFSUZkN3A3?=
 =?utf-8?B?Wjl3REp3MDBFL2ZDS3NqSVdYc0FiM3lJTndMTy9GNFJMellCY0tUVVRMUURK?=
 =?utf-8?B?b2ZEQm5XSmNWbFU5STlzWTJDQzNvRndmOGdMZFZJWWlBQ1NYYm51WDBDb2NL?=
 =?utf-8?B?dmZMaDZCaDhUY01iZGNYWjFhYm4ycnZIYWI4OEs3c3hrdjNDS1IzMzhrYUlM?=
 =?utf-8?B?TVhXbGNqK1lhRUpKQXRqMnhMYlFIY2RtWmx2Y0ppb05CdTVEalVwYjZUazRL?=
 =?utf-8?B?RzB4cXNTWjlnNmJPNURDRjc3YnVVbjEySDgrQXNrQ0NNWndhYU0vZlhuY1lU?=
 =?utf-8?B?RWtyS01FVXZCMlBZSmxiNFhBdDErSy83Q05wNzJlTzNOM2ZTZDZvOXJrcjIz?=
 =?utf-8?B?UFBSUXByTWk5UkVRb3ExaTVCb1d3WXN0UmFiaVhpNXI2NkpJVVNMM2dGa3Vw?=
 =?utf-8?B?d0ZZeHc5bC9iNmh1QkFjb1NYaFpGUml3c25qVUdib2lQN1FPc1R4S2h1WFpH?=
 =?utf-8?B?Mnc9PQ==?=
X-MS-Exchange-CrossTenant-Network-Message-Id: b69ff389-032a-4ab2-b300-08dc342c6379
X-MS-Exchange-CrossTenant-AuthSource: SJ0PR11MB4893.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 23 Feb 2024 05:00:43.2707
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: IjDtEX85GDOwIZWnuCYEDxBEsLgDJ6X8Hriyvvm2uNCzmE9WuaRSZ9LtfcspzYLoLkLuPtL5Y5MArDCTcNLK38tAdHjl/AnWSbhxljjzf9U=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CO6PR11MB5665
X-OriginatorOrg: intel.com



On 2/22/2024 8:05 PM, Jay Vosburgh wrote:
> Samudrala, Sridhar <sridhar.samudrala@intel.com> wrote:
>> On 2/22/2024 5:00 PM, Jakub Kicinski wrote:
>>> On Thu, 22 Feb 2024 08:51:36 +0100 Greg Kroah-Hartman wrote:
>>>> On Tue, Feb 20, 2024 at 05:33:09PM -0800, Jakub Kicinski wrote:
>>>>> Greg, we have a feature here where a single device of class net has
>>>>> multiple "bus parents". We used to have one attr under class net
>>>>> (device) which is a link to the bus parent. Now we either need to add
>>>>> more or not bother with the linking of the whole device. Is there any
>>>>> precedent / preference for solving this from the device model
>>>>> perspective?
>>>>
>>>> How, logically, can a netdevice be controlled properly from 2 parent
>>>> devices on two different busses?  How is that even possible from a
>>>> physical point-of-view?  What exact bus types are involved here?
>>> Two PCIe buses, two endpoints, two networking ports. It's one piece
>>
>> Isn't it only 1 networking port with multiple PFs?
>>
>>> of silicon, tho, so the "slices" can talk to each other internally.
>>> The NVRAM configuration tells both endpoints that the user wants
>>> them "bonded", when the PCI drivers probe they "find each other"
>>> using some cookie or DSN or whatnot. And once they did, they spawn
>>> a single netdev.
>>>
>>>> This "shouldn't" be possible as in the end, it's usually a PCI device
>>>> handling this all, right?
>>> It's really a special type of bonding of two netdevs. Like you'd bond
>>> two ports to get twice the bandwidth. With the twist that the balancing
>>> is done on NUMA proximity, rather than traffic hash.
>>> Well, plus, the major twist that it's all done magically "for you"
>>> in the vendor driver, and the two "lower" devices are not visible.
>>> You only see the resulting bond.
>>> I personally think that the magic hides as many problems as it
>>> introduces and we'd be better off creating two separate netdevs.
>>> And then a new type of "device bond" on top. Small win that
>>> the "new device bond on top" can be shared code across vendors.
>>
>> Yes. We have been exploring a small extension to bonding driver to enable
>> a single numa-aware multi-threaded application to efficiently utilize
>> multiple NICs across numa nodes.
> 
> 	Is this referring to something like the multi-pf under
> discussion, or just generically with two arbitrary network devices
> installed one each per NUMA node?

Normal network devices one per NUMA node

> 
>> Here is an early version of a patch we have been trying and seems to be
>> working well.
>>
>> =========================================================================
>> bonding: select tx device based on rx device of a flow
>>
>> If napi_id is cached in the sk associated with skb, use the
>> device associated with napi_id as the transmit device.
>>
>> Signed-off-by: Sridhar Samudrala <sridhar.samudrala@intel.com>
>>
>> diff --git a/drivers/net/bonding/bond_main.c
>> b/drivers/net/bonding/bond_main.c
>> index 7a7d584f378a..77e3bf6c4502 100644
>> --- a/drivers/net/bonding/bond_main.c
>> +++ b/drivers/net/bonding/bond_main.c
>> @@ -5146,6 +5146,30 @@ static struct slave
>> *bond_xmit_3ad_xor_slave_get(struct bonding *bond,
>>         unsigned int count;
>>         u32 hash;
>>
>> +       if (skb->sk) {
>> +               int napi_id = skb->sk->sk_napi_id;
>> +               struct net_device *dev;
>> +               int idx;
>> +
>> +               rcu_read_lock();
>> +               dev = dev_get_by_napi_id(napi_id);
>> +               rcu_read_unlock();
>> +
>> +               if (!dev)
>> +                       goto hash;
>> +
>> +               count = slaves ? READ_ONCE(slaves->count) : 0;
>> +               if (unlikely(!count))
>> +                       return NULL;
>> +
>> +               for (idx = 0; idx < count; idx++) {
>> +                       slave = slaves->arr[idx];
>> +                       if (slave->dev->ifindex == dev->ifindex)
>> +                               return slave;
>> +               }
>> +       }
>> +
>> +hash:
>>         hash = bond_xmit_hash(bond, skb);
>>         count = slaves ? READ_ONCE(slaves->count) : 0;
>>         if (unlikely(!count))
>> =========================================================================
>>
>> If we make this as a configurable bonding option, would this be an
>> acceptable solution to accelerate numa-aware apps?
> 
> 	Assuming for the moment this is for "regular" network devices
> installed one per NUMA node, why do this in bonding instead of at a
> higher layer (multiple subnets or ECMP, for example)?
> 
> 	Is the intent here that the bond would aggregate its interfaces
> via LACP with the peer being some kind of cross-chassis link aggregation
> (MLAG, et al)?

Yes. basic LACP bonding setup. There could be multiple peers connecting 
to the server via switch providing LACP based link aggregation. No 
cross-chassis MLAG.

> 
> 	Given that sk_napi_id seems to be associated with
> CONFIG_NET_RX_BUSY_POLL, am I correct in presuming the target
> applications are DPDK-style busy poll packet processors?

I am using sk_napi_id to get the incoming interface. Busy poll is not a 
requirement and this can be used with any socket based apps.

In a numa-aware app, the app threads are split into pools of threads 
aligned to each numa node and the associated NIC. In the rx path, a 
thread is picked from a pool associated with a numa node using 
SO_INCOMING_CPU or similar method by setting irq affinity to the local 
cores. napi id is cached in the sk in the receive path. In the tx path, 
bonding driver picks the same NIC as the outgoing device using the 
cached sk->napi_id.

This enables numa affinitized data path for an app thread doing network 
I/O. If we also configure xps based on rx queues, tx and rx of a TCP 
flow can be aligned to the same queue pair of a NIC even when using bonding.

> 
> 	-J
> 
> ---
> 	-Jay Vosburgh, jay.vosburgh@canonical.com

