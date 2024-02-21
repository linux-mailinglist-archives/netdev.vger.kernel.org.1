Return-Path: <netdev+bounces-73755-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 8640D85E260
	for <lists+netdev@lfdr.de>; Wed, 21 Feb 2024 17:02:44 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id EB7281F2379B
	for <lists+netdev@lfdr.de>; Wed, 21 Feb 2024 16:02:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DBD45823B1;
	Wed, 21 Feb 2024 15:59:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="SMqT/FfA"
X-Original-To: netdev@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E7D54823AA
	for <netdev@vger.kernel.org>; Wed, 21 Feb 2024 15:59:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=192.198.163.17
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708531192; cv=fail; b=Ot5tjnNAcY/J6419W1V28yLXNiDxaaMjVnS9JGDEE2QyTEhsSE78quLTr2yjbO7RrxdtjVarOr3blXWP98eSbNbOmcV2PVwRTnLXiWMhFpftuttobZylhsAl+DVsbMawC3N+sd4GThZ80o7ZTrrS72Ho2P3sXi8j6MvggYPLwK0=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708531192; c=relaxed/simple;
	bh=kt/6hUsf39uh4FT0xufg1QfUjNJBd3Tw71OA3zgWaIE=;
	h=Date:From:To:CC:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=kEFCVD4gQGjx1XyZ/iKCZSWo80mURIqRmrc3Vvzue0bv1goPOjRwKJVP5pk/Al2wS2paUxhR/O7HswwW1tEV1mXG5JpWLH43wDRW2+xHZYRPyh0JJC5g55AwtlNmNKUQrpO+mdVwWTZb75N/KQ2IiT0MhoF31/OWPPeeHYLEWjU=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=SMqT/FfA; arc=fail smtp.client-ip=192.198.163.17
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1708531191; x=1740067191;
  h=date:from:to:cc:subject:message-id:references:
   content-transfer-encoding:in-reply-to:mime-version;
  bh=kt/6hUsf39uh4FT0xufg1QfUjNJBd3Tw71OA3zgWaIE=;
  b=SMqT/FfAkN18C/V2FnVh41N8/NiFXgld4RBNmXS8zPVNTDbmYfbUCKMo
   KAKD9CRGl3dr1KzA9zeTvrv4C/0JFoPmM9EY28mn8bte3RNKmAmf/b5Gj
   PUMQLgz1ySzP1jc9iMMcbE9/ixj6vrwHE+206p+c068Vt58edOWmB38/v
   T7dDyjK9mk9DjICdOGQ5DgO0keuOppHnxf/XROQ3jQ0anZ0fYCmvNDa+1
   D0F+uJaPLnks6z//4wFnGfBcvz6nBTvs3XUYZ5pOIyDcR8rwV2yflBJHC
   ShU8BPqJEkEDOlzdC3pjhZ1suRFv2wpF2oNroF/VL2ni2EBFaYLgNpcUU
   Q==;
X-IronPort-AV: E=McAfee;i="6600,9927,10991"; a="2558294"
X-IronPort-AV: E=Sophos;i="6.06,175,1705392000"; 
   d="scan'208";a="2558294"
Received: from fmviesa006.fm.intel.com ([10.60.135.146])
  by fmvoesa111.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 21 Feb 2024 07:59:50 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.06,175,1705392000"; 
   d="scan'208";a="5381372"
Received: from orsmsx601.amr.corp.intel.com ([10.22.229.14])
  by fmviesa006.fm.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 21 Feb 2024 07:59:50 -0800
Received: from orsmsx602.amr.corp.intel.com (10.22.229.15) by
 ORSMSX601.amr.corp.intel.com (10.22.229.14) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35; Wed, 21 Feb 2024 07:59:49 -0800
Received: from ORSEDG602.ED.cps.intel.com (10.7.248.7) by
 orsmsx602.amr.corp.intel.com (10.22.229.15) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35 via Frontend Transport; Wed, 21 Feb 2024 07:59:49 -0800
Received: from NAM10-MW2-obe.outbound.protection.outlook.com (104.47.55.100)
 by edgegateway.intel.com (134.134.137.103) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.35; Wed, 21 Feb 2024 07:59:44 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=JrN9btQjbdU2b4fPOD4RE1VIwqWUoii3uYFvj9MAdJkJTIXqcO6Z3bnVP1pyDKVHr74VwFs7LK4bSaPLiJP8niZs2bUlBnFlfcm2ed55fd94HY8pvYmJt3QflmRdSyyVOG9ZqI5cdgIFztZcOR4g7YFR/rJs3dxC6jDiUe2+YCDxf5LUthcjPVFxo2IlDI1O1iTP5MQRFshupA35H0hes4YYdi7vYig5pWBxsA9m7X4lzLj0FrfEe1NknvNqjyZ/kQc+Q9EBoS8vY7kyPBB1XUJxztbTKwCCWAkDiCNIZ0tiac6uOtTYsY8qfEM75BrXDUN6mKNmp6jwexqFr8MzfA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=puYd2L8v1qgMpfvtbLw3DTf4cWzSZt1fZ5JfItwJvqg=;
 b=hC8j8sTV2VuMyNh5VJC/v1jBwjTeLhMs1FOIxrz8H/53E+AXzulKOZhOCTopve4eW2iFAVYug2l1RK8z5wk3TGATpu7u+bfKZmjVwwxjn3coqag/LrW1mEplF0I2YyTXo+QFuvpBdP3GElVD0Wu5Vp2b9FCvs9Agewjym+eQEwThxd4ZBNJcP5s4C+L7jM2XmucSKyx1AjetthS7Si+1s359pfCdjH1t+ehSmmdNpf+pmm/5FlmkNL2m2JwF2ux62zzlaN8zZvBiAgHo1S+9XFZPZJwWgrIIoUYl4upi6W648wxrFfKK0jFv0je5QkzQ0Us8CMWn5GT01R4v3nrbBQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from DM4PR11MB6117.namprd11.prod.outlook.com (2603:10b6:8:b3::19) by
 SJ0PR11MB4895.namprd11.prod.outlook.com (2603:10b6:a03:2de::23) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7292.39; Wed, 21 Feb
 2024 15:59:15 +0000
Received: from DM4PR11MB6117.namprd11.prod.outlook.com
 ([fe80::ccab:b5f4:e200:ee47]) by DM4PR11MB6117.namprd11.prod.outlook.com
 ([fe80::ccab:b5f4:e200:ee47%6]) with mapi id 15.20.7292.036; Wed, 21 Feb 2024
 15:59:15 +0000
Date: Wed, 21 Feb 2024 16:59:10 +0100
From: Maciej Fijalkowski <maciej.fijalkowski@intel.com>
To: Kurt Kanzenbach <kurt@linutronix.de>
CC: Stanislav Fomichev <sdf@google.com>, Serge Semin
	<fancer.lancer@gmail.com>, <netdev@vger.kernel.org>, "Sebastian Andrzej
 Siewior" <bigeasy@linutronix.de>, Song Yoong Siang
	<yoong.siang.song@intel.com>, Alexei Starovoitov <ast@kernel.org>
Subject: Re: stmmac and XDP/ZC issue
Message-ID: <ZdYdzmvDSrdz03mb@boxer>
References: <87r0h7wg8u.fsf@kurt.kurt.home>
 <7dnkkpc5rv6bvreaxa7v4sx4kftjvv4vna4zqk4bihfcx5a3nb@suv6nsve6is4>
 <ZdS6d0RNeICJjO+q@boxer>
 <CAKH8qBs+TBRHhx0ZqMABCsGZ8sbXtSZMeFuP73-=hY69Wpfn8g@mail.gmail.com>
 <87ttm25lxw.fsf@kurt.kurt.home>
 <87le7e5g1r.fsf@kurt.kurt.home>
Content-Type: text/plain; charset="utf-8"
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <87le7e5g1r.fsf@kurt.kurt.home>
X-ClientProxiedBy: DU2PR04CA0309.eurprd04.prod.outlook.com
 (2603:10a6:10:2b5::14) To DM4PR11MB6117.namprd11.prod.outlook.com
 (2603:10b6:8:b3::19)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM4PR11MB6117:EE_|SJ0PR11MB4895:EE_
X-MS-Office365-Filtering-Correlation-Id: 49ddc994-ce56-4d1f-ea7a-08dc32f60de1
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: bv9GcEhgjy81y0ODRnWfJcoFlr5rcgXwEUsZtbu75HwC5NOVcVSIv30gQtI5cfjGjl9Oj97CFt5o0U+EiyIZVthAm0RPAkyCv00paCW3l/syd+YmikWZvMmthFgi3ZEH8qwWeGRqGMankYXb1Oc8G7qjCsg9vSDxWyVOq3To/Banc2E2qNhHKDIf1jnFl6Yp+hk2ynQq2N945kBxo4oMmumaRVAytXEJRA1RdIhdVb7llfbvM18LbRtgPAOU5AfDTPl5GWlaipc+lDpNcooQu1SRHVHD/fQ2Ee0TUAdYNeOvt/KnIegzAr+aQYfXCIFkhX9eB/dXWR2NapXug4o9Hibjqn1RSf2ZlFG+FcUgItF7/ZZ5meVD+ynaCaEpYkpgfNdQsuuRk5d/OHJhdxtAHUFxn2Ddoy4mcGNZvO8pDkikX1iTyHOdHB23S8OESFI6zP2Sw1PT7EOQYattXK3IbLiYIXNccsOgonfZ0k6WUYjJR+BiQ9wN8K6TxdpPiD4FAE+Fr3OCG1qA9PZAuLSy77ThGdjCHEErrVfTXxAOXHc=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM4PR11MB6117.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?TWljclVpOWU4WC9aMWQ4Q09xSnZFNHlheEFMZ2lLcnM3cXdLVjdJdzBPUjdV?=
 =?utf-8?B?RUVpVHpxakJlUytHMElwd25rY2V2VTdvU1praTBibmRuWjltRTY2QlBGVU9S?=
 =?utf-8?B?dnRwdVgyK3huaDNtMTdHM2dEdzRSWXQ5MWRCbnB2WFRZMHUrZEhVQzdRUlhw?=
 =?utf-8?B?dFdodEQ3ZEhjMlU5dmRrU20zRk1QdnRRR0l0THM4RnFPUmkzQm1CVlFqQ2Z3?=
 =?utf-8?B?T1lEWTJaOURlajl2Nm1PVXZVeHIxMXpUR2VOaHlxcXlwT1FqWkFzZTRabG1D?=
 =?utf-8?B?MnFQbXZ1R0dsSTNMaldRS1lDSWF4WFM5RjFjTXRBK0JEb2p6c3hCVVpSOHRj?=
 =?utf-8?B?NXgwdWVsSXFvOFJ6Tk81aGh3aUF6WS9VSlJ5RHRyc1g3NWFZcnNsN1pxaDhY?=
 =?utf-8?B?YkVPR1NlZTBoU1NUWjk4ejUwUFI2OXJoaGp3VWdHajViQTZDN2JYa3piMGUy?=
 =?utf-8?B?S3NkOHR0U2tRTzQrUElKV0VlY084OEwrdUdmeFNsci9tNGd1Sjk5bXZ3Y3N6?=
 =?utf-8?B?QStDZExON0ZsQjNidGU1eDU4amFWNDZPQXE4VjhGc1JsQVlCRGd1U0tMME1y?=
 =?utf-8?B?aUI3VGpRaGU3YUltQzd3ZDZZMjB6SzVCRDZ6RkVWcDZBUW42djN1NmNCdTlj?=
 =?utf-8?B?dDFzN3BndVJhbFJDTzBrcjJHbHpRdkdaQlZUdWhDWDNQMkk0TkFlcGFHRkE4?=
 =?utf-8?B?YVdNZHBzSUM3SnZiZ2dCTFl4c3dUUnhQdEo1UkNwVEtaT0xnOGxIYUxpbGF5?=
 =?utf-8?B?OTRSUzVMcDkyUDYwTFlycGQwR0p4eFF0ek43VVBya0NuMHU2VzZadzBKbUZ1?=
 =?utf-8?B?RTMyWS9lUXNhRTFoWUs3eUtYWUJPRUs4eW1BazhIZXpUc2E3eEd6dGRaRVRY?=
 =?utf-8?B?YU9ienRJMGw3d1JGcmN5c0R4bFZoRHdjWlgwcnorbmkwNk5jK2E5d2lsblEr?=
 =?utf-8?B?eEg4OGtPVG1JVEttVHVKN3VMZ29KV1hjVG1Nbm9nWkU2NHNZZjBVK0g1ZUFt?=
 =?utf-8?B?MDBvdHo1Z1AwRzllRy9HQnBGaFJKT3A3NHVFbGFjcEF4UjU1NmFTQk5VOGNv?=
 =?utf-8?B?aGdaSkRiL0oxVTFyMk8rRzlJVnI0cnhTWnJuYUFzT1NzMUtzWkhlNm03ZGtT?=
 =?utf-8?B?RkphUU5jdlpmL3ZFVzhSVzZGdUgwN3p2b04ySFQ4MkFWZEtpUXE3NW5kY3pC?=
 =?utf-8?B?aXZoK1NhdVJFOHQ1RHhhSkZXVEowRGZLLzZjZWlEQ3NoQWIyUVhGeFExbjVr?=
 =?utf-8?B?WXBrb2RRd09Sd0htbExBSitaZlNjWDlVVURJQmxPdk5EbldNcWpIRnJEYUxQ?=
 =?utf-8?B?ZEl3c0MraHZtd0s2MTltdkRoT2RmRmEwemFCMnhGTUluYzFCOU8vc0phbXJu?=
 =?utf-8?B?L2RtY1UwYkZWSkt2Zll2aXdsdlUrV2J6RnNZNzA1c0UrVG40QVV5ZEV1SGxM?=
 =?utf-8?B?OUtHMjdFK2V4bUN3VHFGRjY3eUQvTWs2Q2dNR3krZk0zYVM2WHFRaklxZUtD?=
 =?utf-8?B?dmUxOUl1VE54RDhxcVFtdG93eEdxa2dzczNuVGJiT1JiMHAyd0pJM0xrZzI5?=
 =?utf-8?B?bkNNOGorK3lLaWFYR3pHTW5qeEJoNndHRlV0UnBGVHM4ZnlZbDFZaGhzS0t4?=
 =?utf-8?B?YTFma0lWQUtteWVJd2prb0tQaGd4QmFJaUhvODYxWWZvUzhFbWVNSk1LdkVt?=
 =?utf-8?B?NU5EMEhQMUpObXBsdXZKMmdWT1lrRGFTYlRqUmgyUld6U1lNcnF3U1AxdlVF?=
 =?utf-8?B?TUVmRTB5VTNBWkx2MytpalIvVjlpZTAyNStRc1pTMllJazZwb3dDdjB5VGU4?=
 =?utf-8?B?T1hMYmcwSW1acXduOWVJVnlDTXBNa2ZXUzlIR0diZ2hnL21GbHRrQ3hqUjhx?=
 =?utf-8?B?bmpzcUt3TkV1WXlJTDgyYUpHcHczL2JJNFVUQVYxbWd3MkJLNGdHRndKc3lr?=
 =?utf-8?B?L0ttaUZ1UFVwSGZSWHJrNU9MeVZPcWk4VmFUVUF0Z3krR0wxK1A3MGtiWmZm?=
 =?utf-8?B?TmZkblpmVWp4VWxVOFRMNW1FUVhuQjVBbzVtRjJwdXVxaUpzTmUrVzlUOE5B?=
 =?utf-8?B?VktIU0pQbjlxeWlUK1hseTE2TUcvSlhRNWROajFxVFN3Qm1CcXRGUWV1dVRV?=
 =?utf-8?B?TFRGWkRBQStMWVBSdVlYUmpDUUVUSHhYOGlkOElydnBIaVVzM2djR20rYS83?=
 =?utf-8?B?TlE9PQ==?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 49ddc994-ce56-4d1f-ea7a-08dc32f60de1
X-MS-Exchange-CrossTenant-AuthSource: DM4PR11MB6117.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 21 Feb 2024 15:59:15.7490
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: pKdu/ZyHYzczsiZ+XUI5MPCXqGVyYqKP8H6H+HlYzvZ+BTizUDO6nRSAgahrBEgD9mF6s/H7+ci/SGKYOJatkRx9Y+9CkMtygNx1s9qTDKw=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ0PR11MB4895
X-OriginatorOrg: intel.com

On Wed, Feb 21, 2024 at 10:21:04AM +0100, Kurt Kanzenbach wrote:
> On Wed Feb 21 2024, Kurt Kanzenbach wrote:
> > On Tue Feb 20 2024, Stanislav Fomichev wrote:
> >> On Tue, Feb 20, 2024 at 6:43 AM Maciej Fijalkowski
> >> <maciej.fijalkowski@intel.com> wrote:
> >>>
> >>> On Tue, Feb 20, 2024 at 04:18:54PM +0300, Serge Semin wrote:
> >>> > Hi Kurt
> >>> >
> >>> > On Tue, Feb 20, 2024 at 12:02:25PM +0100, Kurt Kanzenbach wrote:
> >>> > > Hello netdev community,
> >>> > >
> >>> > > after updating to v6.8 kernel I've encountered an issue in the stmmac
> >>> > > driver.
> >>> > >
> >>> > > I have an application which makes use of XDP zero-copy sockets. It works
> >>> > > on v6.7. On v6.8 it results in the stack trace shown below. The program
> >>> > > counter points to:
> >>> > >
> >>> > >  - ./include/net/xdp_sock.h:192 and
> >>> > >  - ./drivers/net/ethernet/stmicro/stmmac/stmmac_main.c:2681
> >>> > >
> >>> > > It seems to be caused by the XDP meta data patches. This one in
> >>> > > particular 1347b419318d ("net: stmmac: Add Tx HWTS support to XDP ZC").
> >>> > >
> >>> > > To reproduce:
> >>> > >
> >>> > >  - Hardware: imx93
> >>> > >  - Run ptp4l/phc2sys
> >>> > >  - Configure Qbv, Rx steering, NAPI threading
> >>> > >  - Run my application using XDP/ZC on queue 1
> >>> > >
> >>> > > Any idea what might be the issue here?
> >>> > >
> >>> > > Thanks,
> >>> > > Kurt
> >>> > >
> >>> > > Stack trace:
> >>> > >
> >>> > > |[  169.248150] imx-dwmac 428a0000.ethernet eth1: configured EST
> >>> > > |[  191.820913] imx-dwmac 428a0000.ethernet eth1: EST: SWOL has been switched
> >>> > > |[  226.039166] imx-dwmac 428a0000.ethernet eth1: entered promiscuous mode
> >>> > > |[  226.203262] imx-dwmac 428a0000.ethernet eth1: Register MEM_TYPE_PAGE_POOL RxQ-0
> >>> > > |[  226.203753] imx-dwmac 428a0000.ethernet eth1: Register MEM_TYPE_PAGE_POOL RxQ-1
> >>> > > |[  226.303337] imx-dwmac 428a0000.ethernet eth1: Register MEM_TYPE_XSK_BUFF_POOL RxQ-1
> >>> > > |[  255.822584] Unable to handle kernel NULL pointer dereference at virtual address 0000000000000000
> >>> > > |[  255.822602] Mem abort info:
> >>> > > |[  255.822604]   ESR = 0x0000000096000044
> >>> > > |[  255.822608]   EC = 0x25: DABT (current EL), IL = 32 bits
> >>> > > |[  255.822613]   SET = 0, FnV = 0
> >>> > > |[  255.822616]   EA = 0, S1PTW = 0
> >>> > > |[  255.822618]   FSC = 0x04: level 0 translation fault
> >>> > > |[  255.822622] Data abort info:
> >>> > > |[  255.822624]   ISV = 0, ISS = 0x00000044, ISS2 = 0x00000000
> >>> > > |[  255.822627]   CM = 0, WnR = 1, TnD = 0, TagAccess = 0
> >>> > > |[  255.822630]   GCS = 0, Overlay = 0, DirtyBit = 0, Xs = 0
> >>> > > |[  255.822634] user pgtable: 4k pages, 48-bit VAs, pgdp=0000000085fe1000
> >>> > > |[  255.822638] [0000000000000000] pgd=0000000000000000, p4d=0000000000000000
> >>> > > |[  255.822650] Internal error: Oops: 0000000096000044 [#1] PREEMPT_RT SMP
> >>> > > |[  255.822655] Modules linked in:
> >>> > > |[  255.822660] CPU: 0 PID: 751 Comm: napi/eth1-261 Not tainted 6.8.0-rc4-rt4-00100-g9c63d995ca19 #8
> >>> > > |[  255.822666] Hardware name: NXP i.MX93 11X11 EVK board (DT)
> >>> > > |[  255.822669] pstate: 60400009 (nZCv daif +PAN -UAO -TCO -DIT -SSBS BTYPE=--)
> >>> > > |[  255.822674] pc : stmmac_tx_clean.constprop.0+0x848/0xc38
> >>> > > |[  255.822690] lr : stmmac_tx_clean.constprop.0+0x844/0xc38
> >>> > > |[  255.822696] sp : ffff800085ec3bc0
> >>> > > |[  255.822698] x29: ffff800085ec3bc0 x28: ffff000005b609e0 x27: 0000000000000001
> >>> > > |[  255.822706] x26: 0000000000000000 x25: ffff000005b60ae0 x24: 0000000000000001
> >>> > > |[  255.822712] x23: 0000000000000001 x22: ffff000005b649e0 x21: 0000000000000000
> >>> > > |[  255.822719] x20: 0000000000000020 x19: ffff800085291030 x18: 0000000000000000
> >>> > > |[  255.822725] x17: ffff7ffffc51c000 x16: ffff800080000000 x15: 0000000000000008
> >>> > > |[  255.822732] x14: ffff80008369b880 x13: 0000000000000000 x12: 0000000000008507
> >>> > > |[  255.822738] x11: 0000000000000040 x10: 0000000000000a70 x9 : ffff800080e32f84
> >>> > > |[  255.822745] x8 : 0000000000000000 x7 : 0000000000000000 x6 : 0000000000003ff0
> >>> > > |[  255.822751] x5 : 0000000000003c40 x4 : ffff000005b60000 x3 : 0000000000000000
> >>> > > |[  255.822757] x2 : 0000000000000000 x1 : 0000000000000000 x0 : 0000000000000000
> >>> > > |[  255.822764] Call trace:
> >>> > > |[  255.822766]  stmmac_tx_clean.constprop.0+0x848/0xc38
> >>>
> >>> Shouldn't xsk_tx_metadata_complete() be called only when corresponding
> >>> buf_type is STMMAC_TXBUF_T_XSK_TX?
> >>
> >> +1. I'm assuming Serge isn't enabling it explicitly, so none of the
> >> metadata stuff should trigger in this case.
> >
> > The only other user of xsk_tx_metadata_complete() in mlx5 guards it with
> > xp_tx_metadata_enabled(). Seems like that's missing in stmmac?
> 
> Well, the following patch seems to help:
> 
> commit e85ab4b97b4d6e50036435ac9851b876c221f580
> Author: Kurt Kanzenbach <kurt@linutronix.de>
> Date:   Wed Feb 21 08:18:15 2024 +0100
> 
>     net: stmmac: Complete meta data only when enabled
>     
>     Currently using XDP sockets on stmmac results in a kernel crash:
>     
>     |[  255.822584] Unable to handle kernel NULL pointer dereference at virtual address 0000000000000000
>     |[...]
>     |[  255.822764] Call trace:
>     |[  255.822766]  stmmac_tx_clean.constprop.0+0x848/0xc38
>     
>     The program counter indicates xsk_tx_metadata_complete(). However, this
>     function shouldn't be called unless metadata is actually enabled.
>     
>     Tested on imx93.
>     
>     Fixes: 1347b419318d ("net: stmmac: Add Tx HWTS support to XDP ZC")
>     Signed-off-by: Kurt Kanzenbach <kurt@linutronix.de>
> 
> diff --git a/drivers/net/ethernet/stmicro/stmmac/stmmac_main.c b/drivers/net/ethernet/stmicro/stmmac/stmmac_main.c
> index 9df27f03a8cb..77c62b26342d 100644
> --- a/drivers/net/ethernet/stmicro/stmmac/stmmac_main.c
> +++ b/drivers/net/ethernet/stmicro/stmmac/stmmac_main.c
> @@ -2678,9 +2678,10 @@ static int stmmac_tx_clean(struct stmmac_priv *priv, int budget, u32 queue,
>                                         .desc = p,
>                                 };
>  
> -                               xsk_tx_metadata_complete(&tx_q->tx_skbuff_dma[entry].xsk_meta,
> -                                                        &stmmac_xsk_tx_metadata_ops,
> -                                                        &tx_compl);
> +                               if (xp_tx_metadata_enabled(tx_q->xsk_pool))

every other usage of tx metadata functions should be wrapped with
xp_tx_metadata_enabled() - can you address other places and send a proper
patch?

> +                                       xsk_tx_metadata_complete(&tx_q->tx_skbuff_dma[entry].xsk_meta,
> +                                                                &stmmac_xsk_tx_metadata_ops,
> +                                                                &tx_compl);
>                         }
>                 }



